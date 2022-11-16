Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F347C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 23:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B3010E1A2;
	Wed, 16 Nov 2022 23:49:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBCB10E1A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 23:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV0PHpgxP+ZepO+WCm3ZxJaBXWQ6X0HTuo7OuJgntm8rSPOHK2/d5LAYNIK/N2jAvZBvvXAmezT3FqdprY95G2MmzQ1L3uHdJzDOIZ8zZmijjIp2/hFMjVnQrp9QvSeEvdXFUdneWqkJh+9L+qWuO6phD9OAx0OU6S4wcgXoLTS19UuikhM8I03BHoc+7EzDAWTQ9Gml2uHnDhTMH9smQJOAA1+GyCdrpxK/0z+TqmB3DWNrjIcGyWlRjIPkkHdjniXiO2q8SZRBlGGo3Q+m+KMThPjv4feS20QqjMUFJT3JxApGeJ5Y4rqpQqQqmZJiwY+rcvGLa62O3ZEj+K1ZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajQd1LzpQejefCFm2mYWnI0wdr4QbRAV52/ykMHl3RY=;
 b=QNsAo/H3yYCjyGBaZdvMvK5L4cg/QTh+2HbSnR9OlueRvE5FYexbFz8v23CIWlFu3SlZBWQcr+G398370LscU1OgBT9kMeRysKQY7ElzEcBj5y973QdMwLrwj4NqgDtfrT5NFHF9hlWisAaXR5tC3z4Pu3L7+IH+YJ4AqQTlnK5NYJ4XeZz457cAumtWUA5dcogCoQ+MNHg9y5/mN50ynJsIA6e5pWLfcitQP/Yh+HMqB3wufbepZxGcUvFaMt8oM6Bil7u5h8DmaQ3kZ8Mr8z9b9o6jXmyP97ib84FelDgFW09CRQPaqCs62KlZbNSUKLN5k4zV0WYvDEDv+UYsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajQd1LzpQejefCFm2mYWnI0wdr4QbRAV52/ykMHl3RY=;
 b=BtY3Pg2Pg97LJhIUNgl5usZy8CD2RdXuS3u99nf/q4TVgkeXZxOYTIsygJgMdxuxlP+FhyoYDeX4qW4IbpPjSweYypjYOwMgwkdzkRozaBTtdnvmdTrrmoKDn1V/5xI4kjnNpQcrP8cB+ul03JI8t0Kxy01W8wwIjAQ8qiOmo2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 23:49:38 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 23:49:38 +0000
Message-ID: <1d2751b6-cde8-72f6-9966-792eec5270bc@amd.com>
Date: Wed, 16 Nov 2022 18:49:36 -0500
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
X-ClientProxiedBy: YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::9) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0509a9-6c24-4376-a2c6-08dac82d3937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMX+XzRseZLmpYW3Wr8nL3V6s0D8Ia1jFXAGpg6gKfmkxkqTSGNS5JTQXBfiaBLtelKZowqjl4roFB9ymYfFforb72kSB/l3ysZgOClZ6MgtJBV20P2mRRGMvgUzbCJo+JKu7+rRUzFdYQxOHExL7zxr9lyUUf43taLQHWsecP/ELzLNKYlDaD25SDpepbihiQz4HouXY353fr5iccnDCFQkmnhjXVwMQVbxpqoJjLZGJ2NeyorYDDN156FsZ5X7JnCulfb5w7FUfBM3fwXb/se0L+UShdrksV7/ssIu5j+tnzq+CSL5lyT2of4w6uyFlIo53sFNAOmIrUViKaZuao9HPqWviKiTrIj3Ve060gYaOSw3ySExhmn4zk/BwuGVwcyOZ0rslRm7YkodGkyBrXogdVC4Xr/tmFIoYQG3OIAArROujyZkxJvB33ltH5hfyw99PJxc+ZCZytIwJh2BcMSrpcMCfxgNWcXbIXIkB+NbjJRr4VYYw6o4iqUvqPQ2kR9vXcHKab3BH4xtAG7ku0SDE4vfYpu8TftDI1AtAI5XgGSF6rm1uX3DktW6ZeTm4qVyxGVIqkuqxhcM02rJ66PYHqtAGzDnSSH1J9KFNUVEqundUDCWXzPKCaPZZ/iOvD0dy1YJIhYYXPLoMdprxLpN5PgIXO4FNPfJCLPiNVgvUhE+f+WzOnBFw2QfKNIjdcdOJsPbXx9rctRmAO4I9aWRzR+UCYZh82N3EONEjU/UMCadRQtEvI1PXdSJTRghVLitIfrZojOYohITc+z+oTkDKohzrqoaDNlYoB9X2Tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(36756003)(26005)(31686004)(31696002)(86362001)(38100700002)(83380400001)(2616005)(53546011)(44832011)(6512007)(186003)(2906002)(4001150100001)(5660300002)(8936002)(478600001)(6486002)(41300700001)(6916009)(66946007)(66476007)(316002)(6506007)(4326008)(8676002)(66556008)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhzMjlFNTAxOEZGTVArNlpHQ1FaYlBmZjJFQVBJeVlTRWhNVmZTeFdMRlQ0?=
 =?utf-8?B?S2UxT3NzWXgrYWtIOWRPRWFGVmZPUnZSak1TNUdJL1I0MkFiL1UrMFRpT201?=
 =?utf-8?B?djhTbTZWc1BHbWVSMldPVFdtUnZFdTM3TEN0bnpIbFV1VXRqK1JwRGo1d1NM?=
 =?utf-8?B?VEdBOEJ2aFgxS2lZWlZJR01NYURhWUFXNUZRSU1ObkJQMGpVQ2t6QzJwVVB6?=
 =?utf-8?B?RUlFaWZ3U1NHU1dUaEFSNU5jZ3J0TlEvNEpSdlNmNkZ1ZnIzV3ZudzRpdHMw?=
 =?utf-8?B?VzdOTzRTTW1YSFFSZFFXcElTbjZmd3FFRlZqaFpDbkVRS2hvdjdVRU9PNm0r?=
 =?utf-8?B?WTJnR214OUdlMXRFSlkyN3h2bzg2dGNpMkRHZWcyZUhRQStHMjRmd3JCTTdI?=
 =?utf-8?B?SU1WQnJtRk12L0ZJNVNpQUJwVWtadU1KbXJ6dEJaTTNDUkNrYnVWNWc4Y2U5?=
 =?utf-8?B?dE1xWWoyUEo5WGhJL25iUDNsTWJSUEwwaDVaTmplc0dCR085ejVIbVdwbjk4?=
 =?utf-8?B?TmthQzVIeHhLZ1VaeEJ2SWh0dDB2MjJJbUZPY0VlaitGSllSMjZtL0NMSUNh?=
 =?utf-8?B?NzRWOHduRDhhS05JNXFDWThpeXhiM2RWQVZKeEJaZUIybldRVFBQczlGZWVJ?=
 =?utf-8?B?N2xrbWExcFNMZHRBdnBEZmpqYytDekFEV2xpbi9BSEw2RzFEenl0azdERVM4?=
 =?utf-8?B?ZmtRVlV3RDdNMGh3c0EyRVp2N3FJYnJlZG9VRXdDS0Jmd2piTUd4anJuS1RF?=
 =?utf-8?B?YzdtYitmWWliOTRvakJCTVQzeVZjbWdLb250OGtrdkF6RGNPblhtY2FjSkJ2?=
 =?utf-8?B?bjVpR3doTlQ4OEpxWlNHcytLYUNoK1BSbEQ1Unk2SGZBNENVeGFtNm1vaEpV?=
 =?utf-8?B?bm45d3BYQklON0Y1WHRTRkpPdXdRSTdsKzFXdjNVUGpUKzR4YytXckJMdjNm?=
 =?utf-8?B?UFFxZXFOTmFOKzYzNm9CemJqMGM4VkszMThXOWtRZzBaWDRUeVlJYisvMC9P?=
 =?utf-8?B?R2NQM1RnRnNVVzFkeUI3eEhwWTF4WS9XTWVPS0ZGL3ZLd1dXbzJ4MUNOK256?=
 =?utf-8?B?aUxaaFRzNWJRbmtPWkphcU0waWFhd0s0YUQ1QXJOMkYzUnhuVml4TjlOK3Zm?=
 =?utf-8?B?OU1XajlQbEE3eXMvVmx1Y1dSQ2VPb0FXZWlmaFhuUmZlc2F0blNNejVvK3Vv?=
 =?utf-8?B?d0U4VWJQcHdITWdxc0pXMlMrUWhRenEySHNpVFZub25vYlIrYjRObm16SDEv?=
 =?utf-8?B?V2lSTDNSRzQyakw4dkJMdmhDWnFpaXYzUEFYOEpKMC96SVRhMG0xbHk4MEJX?=
 =?utf-8?B?TVJ4cm9vSXViZytaandyaE1oZVdQNWd5STh6OEhkWG5RZlZKZ2ZSS2ZhWmdJ?=
 =?utf-8?B?TGZoRlhaVGFVVlVESkZPL29jZmNRVjZHZWNXVXZLVXBOdE1jbFZMMnhpRnR3?=
 =?utf-8?B?WXdSTjJGYUwwUVp2Q0hWMGVpVGZza0d6ditoYmROc2xpOVhyZHFVQjNMcmVJ?=
 =?utf-8?B?REtUN2FyQ3JXalo5MDJZNU1ma0hPeURaR1M2SjRGVnExTzV6RTR4bGNieFRh?=
 =?utf-8?B?dS9saDlYRDJOZG9RRmV1Z25sSDRWK3YvcXR3WGN1bWlRbUd4UEVNSXBjZlpE?=
 =?utf-8?B?WmVUZStremE5eXcwT2RiOWsrOWF4bGdBSWczb01kL2hUakE3NlFGNjZ0ek5V?=
 =?utf-8?B?R3J2RFNvL0cwQ0dtWHlPaFc1VjJDNmZNZ21YUDBmYkQrSjlMV2tLNE1MTk9u?=
 =?utf-8?B?Z2xhOXdsTFhhZDdhTVVMbFE3cnBYTDhkSDROUVJzVjhyeDhKMjJDMFpMZlBD?=
 =?utf-8?B?YVBncnA0Nmw1bjVzVVJVY1E5Z1krTnpKNWp5ZWg3c3ppQi9BU2JqbDZyNVhK?=
 =?utf-8?B?R3RCbVRKdFhLMElJUmNjaldNTE1FUXBkUlpCOEN1dlUzVGJhQkQ0M2FxZFZN?=
 =?utf-8?B?UDFXcVhvcUxWVXE2L016akNrWVRwVTdKVVRncG1ydnhUMitMZ3RLdjlhdzdJ?=
 =?utf-8?B?MERScXUvSXo2M2ZjanhLR2N2dk0yOXhVTFRuMnhIN2hadUZ5bTVnWFZQRThY?=
 =?utf-8?B?N0xnZ05KR21YUTc5ZHkyMGF1UHJFN3U3MEZTL012ZEtFK3dFdHV4dHZGeTkw?=
 =?utf-8?Q?GXxmd8fzsNHhkEBw64s1m0SfW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0509a9-6c24-4376-a2c6-08dac82d3937
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 23:49:38.6627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE0r46iDrcwzqklIpmolMwXX6q2fSIffb+bTzSEPPnUs6hJxROnO52I4Le5oLRy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

The previous code just hacked away at reading the data, assuming
locations and sizes of the data. It shouldn't do that. It should
instead interpret the IPMI data as per the IPMI spec and find out
the data stored by the formatted tables as per the IPMI spec. It
should've been written like so from the outset.

The commit description says:

    Read and interpret IPMI data to get the product name, product model, and
    product serial number.

And that's all that the commit is doing really. Nothing more, nothing less.

Regards,
Luben

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
