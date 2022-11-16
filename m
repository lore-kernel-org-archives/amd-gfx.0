Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7398FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 23:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAD010E023;
	Wed, 16 Nov 2022 23:42:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADCF10E023
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 23:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHMzec7PZAqgrAGRbJREUmD/C95pC3HXo08w6qXv1dLoz3QRrS88J3S0ul83ptQNusCAU37J4hz8+w3ToZnfidMiIeRSj+datOmvkGvtd7sHPx4u4ICn+gn1rQb9YVm/6dB8FcKIco3G2ZiO6KE8iFGw50nHETpEPsD6m2OF0B8tXj/AwHoqg44vhH2eIudrbzzveGKAyl/1ieoYx51yxnvLejZe3jyoKgLA28umCXB80L+vu8a08/gVFpAGJm8Q5q6ohHMW3U4ioQARlbof9GnuS1K/8PLr9+BDG1tWZpPPGCvG968Aki60zVYDQR5hN/RjnL0m6OV/nMkoJiGibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNDSZosh/z8d/MB1dkHfA87aVc2hWpSGdAjZZtGUXNk=;
 b=WAUJOjU1JEAeSlig94r/sn5u2Fh6pBL37CpBrtKMsLJmxf3q6+6nnUHu7rI7FiRZ7DdytsqiAPJQgkYTTYPKLtPDsvt/clafVOjl+huiIJk5ISIxkjM6YkVoQEvQ6UnE1ge4tvG+dCfmKcTX4Jan+SdVKerOnMfHUS63x5Y7ACEYJFA9yo+iY/co5lDZPEwx4eRdYpnwe/LBF9KqVyB+Uosu23hPJZsq+0sXttTONnbyzUbtrYRjvT4xXbdPalAu5yLo3XlSzyJZeJdKoUK4mng7AjeXahmQsA2raN8iARwR7rP+qMA+cKlnOPEh21gIl0fqlTM4g8Eiwe9lcm01rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNDSZosh/z8d/MB1dkHfA87aVc2hWpSGdAjZZtGUXNk=;
 b=RwfApCk/OcLUF1I6nx9YW3DtYZBZPOw18QmKrNW9HubNVux/3yAGw4C6FeKhEEG/wt3/lHmbGvYkRNM4ceoTuWu9RmpNgtsgzbR38/bOVD7ipBZ0XLk/fNIiyrGjbBMELjdOpm58FxEL/1lmMRh+lSQmINyR1hDC+oGLnFmd30Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 23:42:32 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 23:42:32 +0000
Message-ID: <2c5562bf-c98a-b69d-adba-74a1878abf65@amd.com>
Date: Wed, 16 Nov 2022 18:42:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] drm/amdgpu: Read IPMI data for product information
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221116194838.15315-1-luben.tuikov@amd.com>
 <20221116194838.15315-4-luben.tuikov@amd.com>
 <CADnq5_PoKyEHKLWXjWtgB-LeAUocRGYKtWJmv7OhqzJeWtA95A@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_PoKyEHKLWXjWtgB-LeAUocRGYKtWJmv7OhqzJeWtA95A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0088.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::21) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 06478d95-e670-4cc7-b7b0-08dac82c3b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWyJuJqbaKRWnBLc8Nv4xU0gNKog66GEEQmlTjIGxuSMjJXtDsNAmzgHTTGSVDKwkEwy1bJjk/8oS4t8D2lt/mUGpqTaFtPNqqGP9s63D1OQtFjOoWL7hJoF1dMWJ1EKrDUiX96BAPdgaQsPKDa1/gau+hn9fdTe5vuHH7CrK89jAoTJPuPb23oKvWG/6Qy1w4CDN4lxkLgC/KGbSuKSsh2qCjPLtmBLrrdMDP5eR+SBUOHOO81DBWVkUlzxO71IVZH8DqN0vCKiu2Ba7dzjEDuhQFox3fSm6FOh31ZVPyHiO1nfJAZoKUF4+baJmrOH9XfxJnY2yfXvpDNhCnWif9Gy2sz7Bc68jbeBdsmpPZL0vr9UY8TOW2g8go8VDVlZpBXfoi2kjQTVSlumBEIKrEBeSsSB/yjUbQ14VhTTkJMOqdwhMex4sjKLhhIfeGpt08GIQkMgt13C+m8MRZvNBKC3M6OqKcvtmARiUEDBXXfOZtTzZC1D5vQxeHYg6NMhI2kfdO0omE+wT52HU2c0Q+2UiY1y+r4dFy5n37m0ugnL/HM9HYSLzNIb9HRO/eXkhGOoDJj2TSi76JNz6IvypzB1OSO/zyW7hdLD+ckqupDcSFECW8XhsRDSjz620Ds0B1n7Kp8Q5FOfwx/wCRWyVQOvnBBWjjVKIFk+I8vTmD5f1hhhGKn7fHwjxv7+Zoj70vgQPvIY/5j6NfzZWBu2Uw7xizVVbW7zGMRoDOazJcBiLVB7Q0CvdViMxSaDFVrbnqvRnf5WcAArzMdBsv0KbnWaQyFbwB/PXuBd30Zg15c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(2906002)(4001150100001)(31686004)(44832011)(66476007)(5660300002)(66556008)(8936002)(41300700001)(83380400001)(4326008)(31696002)(8676002)(66946007)(86362001)(316002)(54906003)(6916009)(36756003)(186003)(478600001)(6512007)(26005)(38100700002)(2616005)(53546011)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJoK3JtdEZzM0poMkdDMnl4WFV1NkNZQlc2dTZRRFVCY0RrVkF6WmxVdnFu?=
 =?utf-8?B?M3EvWm1aNTNtL3dOd0o5VGg2WUdZYStnMDBxT1pIUlVXWlZxSmFEWVF1djNR?=
 =?utf-8?B?ckJWV0pheExqY3lZMi9ESTBFc2Z2end5WHlvNGpjUW1Uc09zUGJQYXdvemVr?=
 =?utf-8?B?ZUlDZHI3Ly8yQkRia1VkR3dJcWE3NEJUajc5NFBIb3hnMVAwSmdBVFBPcTFR?=
 =?utf-8?B?SDkvZTZLbVNGYVEvUkIrLzJVdkVJNWxpcFdXck8vT2JCRFppbkFaRFJnRlh2?=
 =?utf-8?B?ZjA3OXJtNHNtMFVIamp5QjZzZmNaWGdKeEsxWjd4bUtmYnJhNmhaaTZEWTgz?=
 =?utf-8?B?UGcrZThuZDBDSkFqMDRiWWpwUWVyV1gzUldMRlM0ZnhsN3d3dEluWGk2enMz?=
 =?utf-8?B?MEdkNXBuTHcvRGlZZE5jd2gvZlJBNDNKbi9zUTNBaW9rb1grY09CSlBReWFY?=
 =?utf-8?B?Z3MyV2p1UXJWYTU3R3VSSlE5VEM5ZER1K3VpSWh3VE1QR1A2NVd0U1JHUVRj?=
 =?utf-8?B?MkFwOElTYkZ1TFlMYjJqVWVCV0Rra2dqSDNQSXJ3V1o0T0UyOGo1bUhqNGFl?=
 =?utf-8?B?Nk02dXlsUzAvVTEvZG9YcXhUOTU3anVoT3ROVmtzT2lXVWVxSmsyV25tNkFF?=
 =?utf-8?B?YUhmbWVtVE9iZGZFa1JKMnJpaC9OWnNGMU1YKzNMVW9iVUd5aHh4eTluQnJs?=
 =?utf-8?B?S3FMWVQyRndzaFhIdEtZUjBQK0JBNWxhWGxNRlNoOEtDTVZmVkdRbnpweUtT?=
 =?utf-8?B?WWI1TWxQUHVTZEhRSlc0V1ZKVmx5VHVhek9NWERuZDVrdlFaWTYxR2E5cDJy?=
 =?utf-8?B?M05oYU8xUUJvSUtZVWlxTi9UeFZLV3Z2VXpVKzNzeGhoTFVaU3JjeFd2aElq?=
 =?utf-8?B?amFkMkhLZGYwOVJ0VVdyNGx4bldUYmJaajhTM0NGOFB2eWNiemFhWGFjNHRD?=
 =?utf-8?B?eG5paXBvKytFWE9vaGNTOTVLZWZSYktTdHJtUVUyOFVlSENlZHVJSVFHQVBU?=
 =?utf-8?B?YXVLR3JINUFMdjA2b3R4UTJoWnIwZ2xRUnc3aWt3NzVhTmdZQ2tIbTVEVlk5?=
 =?utf-8?B?K1RwY0hPYS94enJvenVNQTBvdzR5Wlk4aEZWREpnSXNscG5XSDM3TDVud2Rt?=
 =?utf-8?B?cVpBcFgvcU4rU0VxUEZ2QVludW0xZlpTdU9HR25zemtJdXQ4a1VwMmNLU2ox?=
 =?utf-8?B?Yk5BMXp6MTMzc0dqczhGSjFpekM0aFhYLzVpaXJZQS85b0hIMGhVSnhaSGVV?=
 =?utf-8?B?eWV0VlF4MGhTajJkTmk5dkNIa3kzNmtUZkwwYlg1eENELy9tdEdTNHJDdmFG?=
 =?utf-8?B?Yys3SC95cDRzQmdqNk9CZ3cvTmhNOFVOS2NLY2JSOGZxL3hyWVBCZk9KRVor?=
 =?utf-8?B?VERiVlVQcTR2a3NUbnRKY3FCTWZBRzNOUzdsT2c2STFDMndNVnZadTUzVmkx?=
 =?utf-8?B?YjdvMkFlMWJseDJKc1Z4cERra1U3QW1jT2VGQmovSGV5TE9YMy9nWTM5eWVQ?=
 =?utf-8?B?QTFjNFhYcFpnOVdBR3l3bWhZTytvczBkZUFTVjZ0WGdZTmJqc1NwdGJ3SHJG?=
 =?utf-8?B?a3FSS0wvNnJzTHIrZUN6RCtyOHJBR21OLzI1MHdvRWxoRGxjU3o0VFE2REhi?=
 =?utf-8?B?M2JlbzVGc3p3ZHVVZC9SVElPclhqaXBCK0NrTk5rTWVaMm05dlNQTVVHcUt5?=
 =?utf-8?B?S08yUmRhRVRLZkRDZTRkRWorRmN6ckdqUC9aOGFBclJ6UlpDVU1QTnhRTHFa?=
 =?utf-8?B?ZlpBeEEvVm9VdVgrT3NMSlAyRTAyYjNzRTg2U01jWFdHQ09RVlBydXQ0cTFT?=
 =?utf-8?B?SFBPZFFBSFNOU2o3dUZRbmwwYjV1UkdvOTV5dk5xcFdMNUMxdXE4eHh6azRa?=
 =?utf-8?B?UEpCdm90ejV6UUdaTVJOUG15UnFFM1FjNmFrMGF6QWoweDVyaWtGRzZtODBi?=
 =?utf-8?B?dGtZME9aNm9YOGhKcWRWRHpubFAySjBYazdvaHdzdG85UE42N2ZTS1FjOTVn?=
 =?utf-8?B?aTgyOGxDU3h2eDlnM2RwQ3hhQmx5MVlISHJBc3JRbm9QUFNVNVRJZTFvMTNU?=
 =?utf-8?B?UnNoVlBJNnQvNHcwR1lpWDh3OGQxQ2FtRzI2YVVuOFAyOU5vR3hIdkRQcWNi?=
 =?utf-8?Q?bQWOk5T2eDejgA7gb6YZWflGe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06478d95-e670-4cc7-b7b0-08dac82c3b4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 23:42:32.7261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEC3ZHBxHxoUO76BiK1hM3KtOplXK+trqaio8S7Vevt7ozvGjfmnuiPtwEJnJuWi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is actually reading the IPMI data as it should. Previously to this, it was
just assuming where the data would be, it's size, and so on. In talking
to some engineers internally, we concluded that it shouldn't do that, and it
should instead follow the IPMI spec to read the data--in the same way
that data was written there--folloing the IPMI spec.

Regards,
Luben

On 2022-11-16 15:58, Alex Deucher wrote:
> On Wed, Nov 16, 2022 at 2:49 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Read and interpret IPMI data to get the product name, product model, and
>> product serial number.
> 
> Patches 1,2,4 are:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> for patch 3:
> It's not clear from the commit message what this change is doing.  Is
> this just a rewrite/cleanup of the existing FRU parsing or is there a
> bug fix in here related to the rest of this series?
> 
> Alex
> 
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Kent Russell <kent.russell@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> Tested-by: Kent Russell <kent.russell@amd.com>
>> ---
>>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 183 ++++++++----------
>>  1 file changed, 85 insertions(+), 98 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> index 9b2ff386b7c4f8..2c38ac7bc643d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> @@ -94,39 +94,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
>>         }
>>  }
>>
>> -static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>> -                                 unsigned char *buf, size_t buf_size)
>> -{
>> -       int ret;
>> -       u8 size;
>> -
>> -       ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
>> -       if (ret < 1) {
>> -               DRM_WARN("FRU: Failed to get size field");
>> -               return ret;
>> -       }
>> -
>> -       /* The size returned by the i2c requires subtraction of 0xC0 since the
>> -        * size apparently always reports as 0xC0+actual size.
>> -        */
>> -       size = buf[0] & 0x3F;
>> -       size = min_t(size_t, size, buf_size);
>> -
>> -       ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
>> -                                buf, size);
>> -       if (ret < 1) {
>> -               DRM_WARN("FRU: Failed to get data field");
>> -               return ret;
>> -       }
>> -
>> -       return size;
>> -}
>> -
>>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>>  {
>> -       unsigned char buf[AMDGPU_PRODUCT_NAME_LEN];
>> -       u32 addrptr, fru_addr;
>> +       unsigned char buf[8], *pia;
>> +       u32 addr, fru_addr;
>>         int size, len;
>> +       u8 csum;
>>
>>         if (!is_fru_eeprom_supported(adev, &fru_addr))
>>                 return 0;
>> @@ -137,88 +110,102 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>>                 return -ENODEV;
>>         }
>>
>> -       /* There's a lot of repetition here. This is due to the FRU having
>> -        * variable-length fields. To get the information, we have to find the
>> -        * size of each field, and then keep reading along and reading along
>> -        * until we get all of the data that we want. We use addrptr to track
>> -        * the address as we go
>> -        */
>> -
>> -       /* The first fields are all of size 1-byte, from 0-7 are offsets that
>> -        * contain information that isn't useful to us.
>> -        * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
>> -        * and the language field, so just start from 0xb, manufacturer size
>> -        */
>> -       addrptr = fru_addr + 0xb;
>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>> -       if (size < 1) {
>> -               DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
>> -               return -EINVAL;
>> +       /* Read the IPMI Common header */
>> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, fru_addr, buf,
>> +                                sizeof(buf));
>> +       if (len != 8) {
>> +               DRM_ERROR("Couldn't read the IPMI Common Header: %d", len);
>> +               return len < 0 ? len : -EIO;
>>         }
>>
>> -       /* Increment the addrptr by the size of the field, and 1 due to the
>> -        * size field being 1 byte. This pattern continues below.
>> -        */
>> -       addrptr += size + 1;
>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>> -       if (size < 1) {
>> -               DRM_ERROR("Failed to read FRU product name, ret:%d", size);
>> -               return -EINVAL;
>> +       if (buf[0] != 1) {
>> +               DRM_ERROR("Bad IPMI Common Header version: 0x%02x", buf[0]);
>> +               return -EIO;
>>         }
>>
>> -       len = size;
>> -       if (len >= AMDGPU_PRODUCT_NAME_LEN) {
>> -               DRM_WARN("FRU Product Name is larger than %d characters. This is likely a mistake",
>> -                               AMDGPU_PRODUCT_NAME_LEN);
>> -               len = AMDGPU_PRODUCT_NAME_LEN - 1;
>> -       }
>> -       memcpy(adev->product_name, buf, len);
>> -       adev->product_name[len] = '\0';
>> -
>> -       addrptr += size + 1;
>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>> -       if (size < 1) {
>> -               DRM_ERROR("Failed to read FRU product number, ret:%d", size);
>> -               return -EINVAL;
>> +       for (csum = 0; len > 0; len--)
>> +               csum += buf[len - 1];
>> +       if (csum) {
>> +               DRM_ERROR("Bad IPMI Common Header checksum: 0x%02x", csum);
>> +               return -EIO;
>>         }
>>
>> -       len = size;
>> -       /* Product number should only be 16 characters. Any more,
>> -        * and something could be wrong. Cap it at 16 to be safe
>> -        */
>> -       if (len >= sizeof(adev->product_number)) {
>> -               DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
>> -               len = sizeof(adev->product_number) - 1;
>> -       }
>> -       memcpy(adev->product_number, buf, len);
>> -       adev->product_number[len] = '\0';
>> +       /* Get the offset to the Product Info Area (PIA). */
>> +       addr = buf[4] * 8;
>> +       if (!addr)
>> +               return 0;
>>
>> -       addrptr += size + 1;
>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>> +       /* Get the absolute address to the PIA. */
>> +       addr += fru_addr;
>>
>> -       if (size < 1) {
>> -               DRM_ERROR("Failed to read FRU product version, ret:%d", size);
>> -               return -EINVAL;
>> +       /* Read the header of the PIA. */
>> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, buf, 3);
>> +       if (len != 3) {
>> +               DRM_ERROR("Couldn't read the Product Info Area header: %d", len);
>> +               return len < 0 ? len : -EIO;
>>         }
>>
>> -       addrptr += size + 1;
>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>> +       if (buf[0] != 1) {
>> +               DRM_ERROR("Bad IPMI Product Info Area version: 0x%02x", buf[0]);
>> +               return -EIO;
>> +       }
>>
>> -       if (size < 1) {
>> -               DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
>> -               return -EINVAL;
>> +       size = buf[1] * 8;
>> +       pia = kzalloc(size, GFP_KERNEL);
>> +       if (!pia)
>> +               return -ENOMEM;
>> +
>> +       /* Read the whole PIA. */
>> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
>> +       if (len != size) {
>> +               kfree(pia);
>> +               DRM_ERROR("Couldn't read the Product Info Area: %d", len);
>> +               return len < 0 ? len : -EIO;
>>         }
>>
>> -       len = size;
>> -       /* Serial number should only be 16 characters. Any more,
>> -        * and something could be wrong. Cap it at 16 to be safe
>> -        */
>> -       if (len >= sizeof(adev->serial)) {
>> -               DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
>> -               len = sizeof(adev->serial) - 1;
>> +       for (csum = 0; size > 0; size--)
>> +               csum += pia[size - 1];
>> +       if (csum) {
>> +               DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
>> +               return -EIO;
>>         }
>> -       memcpy(adev->serial, buf, len);
>> -       adev->serial[len] = '\0';
>>
>> +       /* Now extract useful information from the PIA.
>> +        *
>> +        * Skip the Manufacturer Name at [3] and go directly to
>> +        * the Product Name field.
>> +        */
>> +       addr = 3 + 1 + (pia[3] & 0x3F);
>> +       if (addr + 1 >= len)
>> +               goto Out;
>> +       memcpy(adev->product_name, pia + addr + 1,
>> +              min_t(size_t,
>> +                    sizeof(adev->product_name),
>> +                    pia[addr] & 0x3F));
>> +       adev->product_name[sizeof(adev->product_name) - 1] = '\0';
>> +
>> +       /* Go to the Product Part/Model Number field. */
>> +       addr += 1 + (pia[addr] & 0x3F);
>> +       if (addr + 1 >= len)
>> +               goto Out;
>> +       memcpy(adev->product_number, pia + addr + 1,
>> +              min_t(size_t,
>> +                    sizeof(adev->product_number),
>> +                    pia[addr] & 0x3F));
>> +       adev->product_number[sizeof(adev->product_number) - 1] = '\0';
>> +
>> +       /* Go to the Product Version field. */
>> +       addr += 1 + (pia[addr] & 0x3F);
>> +
>> +       /* Go to the Product Serial Number field. */
>> +       addr += 1 + (pia[addr] & 0x3F);
>> +       if (addr + 1 >= len)
>> +               goto Out;
>> +       memcpy(adev->serial, pia + addr + 1, min_t(size_t,
>> +                                                  sizeof(adev->serial),
>> +                                                  pia[addr] & 0x3F));
>> +       adev->serial[sizeof(adev->serial) - 1] = '\0';
>> +Out:
>> +       kfree(pia);
>>         return 0;
>>  }
>> --
>> 2.38.1
>>
