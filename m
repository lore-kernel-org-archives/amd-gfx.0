Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91868C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 23:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83E110E19E;
	Wed, 16 Nov 2022 23:45:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338EA10E19E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 23:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJv7QMlZvudvZ/hfMRU7i1CSTqweY8kXmmwfdtxV1IqmCryaGdzjksVvGhwMDlT72m5wfPG1nKqqjEkG0aBy5MS/vCVXFyEhiJ+FYchnrlHm27Sb7Jk54n70cbwE/quT3EvaaltLorx3OTPHIAK07ELOYZoAa1RwYNfcTkASnDaiMasuXI6/erOD0J2JqPeyE44EEH+kVhjRV4rHEoPYq6Uv/FfWxoJtqg0zLEEWUXydu+XfWtYMJZi33GjZ6Qa44pS4LcPGAep2Vun2snU9kGl42PLV46j+x0b6+1ij9xZUvDToVS5sDlJjUxpobyYV+jWboQG4iQ3dUkMiMbOiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Seqml3KfyWY8nu60jRLDfXqrIB6AjMMCrhjC0gveBlI=;
 b=WXpflTwHJferBSn1Ems1K5O4E3AeGOpKCAX7ji/QvrtzY+hGZiCIopbf93NA6Sri5v238RydXq6HPFRS9LvepWnC0GlJ4mLRc0tg4ubtPN2/9BV0j9HubkcFG++XUEZ9XhRB/DtaJHYIkL3uye25+SmxVpRd2I6aEUwSMtLQV5jfainsvzPOKH7ymqkvCnkGK55AtDGPoSUgruhOstzlF0E4uYZzToQglZoRWq6PTRCFJS9vPTlPxFF6qNTvjOb+mKWNgX0k/CSqrCK9y7+o2j+5sihqF/RUM2JRFQSvY8WBWW3fwTiP0N0/z/G3JmyR2U7zZl1ew6zzJoDHbZIBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Seqml3KfyWY8nu60jRLDfXqrIB6AjMMCrhjC0gveBlI=;
 b=ex/4nclfHYgZnKRPSN8mGlYCvqUvjz0JjXXmic4Hp6OVBEJH7o5rMbwJoS/1wt1aQuOSXiZRak1zlzak3DnHZkFmnSI3+gbfjCHLIX2rbRYuJvoKZ7XCleC7xVOYVYUHPDW5donMecqCJnZK2AzdDw+Uig/hptxebz+KbyUfZ4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Wed, 16 Nov 2022 23:45:33 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 23:45:32 +0000
Message-ID: <35eaad03-35dd-7d76-b7fb-44e2406b58e3@amd.com>
Date: Wed, 16 Nov 2022 18:45:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] drm/amdgpu: Read IPMI data for product information
Content-Language: en-CA
To: "Russell, Kent" <Kent.Russell@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221116194838.15315-1-luben.tuikov@amd.com>
 <20221116194838.15315-4-luben.tuikov@amd.com>
 <CADnq5_PoKyEHKLWXjWtgB-LeAUocRGYKtWJmv7OhqzJeWtA95A@mail.gmail.com>
 <DM5PR12MB13084DDDBF34512E7E3D893285079@DM5PR12MB1308.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM5PR12MB13084DDDBF34512E7E3D893285079@DM5PR12MB1308.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6c1567-1aef-4ce5-78b7-08dac82ca6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLjQL58YWE9Yvvz8gzhX8EUkMjKE0mPeVO5VSKUiejl0bhfC7dgK2kV2xTCEPcTHKw5C1Q6TP1/BKk1HxViBm8CwFNVWxM5V4n6s5j3TVRe1N4cL5ynWIKwYOHqrjeZXbHTmAI1Z0akSLMAu4dNdKzab2XccAyDOgVIcW0qYbsVWXDWxoi+mGIda/g9f/JEiEkiNKxUxs8phZPNnu7ur4YcPc9XPMQHfdyT60LIe7Jb/Dxt98HQtSr+boasgCYYnA7N7ILJuLGS2HDe7Xx0wadf3CQN+3ZtIzEyHP7hEYdK9xIOQT3+IFeEEXcVwKmXh+KmwvO29x9jg/py09gvSZ0r8LCPXPWUx1MK+DIrs6G8fts/X5VXdylQJwW+ImrcrWrO8GMbhu2tG/y2gSeFrJseUzi+zKCBQhub++lzhnijz177BMSyJPepCWXYVHWF7DdSHHBm4X2EDec26OFYK+A80sbjVCpEax9LMiVM02CscaBPhrf9VPkheHocssVIBA+tpnFVr6GqsXaDYpHAupe0Ks+kBjSQD6NkEjZtfSMWNycFlsY5KAw7Xmlfr8Fv7W51iP319+oFdO2QOFxYwXQOqaAxUavep883DZ9iETpF6ZJ4ivaZ9ocWQj8Ja6iA7V+IvQvNLEvbjGJ1pSHKizDTWpdprQN+yEv8Z/HSO2UUjUsI3dsORtQNOzZKYaiI9OozNL1hx+IC9cTzmCH7WpmDrmrUZbONoTqprvhzw/mrxKj+Gm6g30nNJptNfObfLc5npdfJ82iKOibvlGYoOcLuO+qptJ5UYqbnRE6GC/3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(86362001)(31696002)(36756003)(38100700002)(53546011)(316002)(6506007)(54906003)(110136005)(6486002)(478600001)(5660300002)(44832011)(8936002)(2616005)(186003)(83380400001)(4001150100001)(31686004)(2906002)(66556008)(66476007)(66946007)(41300700001)(6512007)(26005)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTlnd090ZnMrN0liNzZHRDA2aWU4Si9naTYwYklEc2c4R0ZDR0o0dS9RY3l3?=
 =?utf-8?B?UE1xeEZtYXFCSXJjd2xnTUN4aEZLdEdTdElsblphSVdGd2drZ2tNU1M3QnZC?=
 =?utf-8?B?dEVaV3pvOWExbmU3SlhNY0R3NHVLMTFTYmZBWVlsdTVrdnVqZ241Y0M2UGNp?=
 =?utf-8?B?THlraFNsV2dqUmNIM1ZWVkNHYkZPRDRnNVd5aS9PWEhBT1JpNDJmK084SWQr?=
 =?utf-8?B?cUJ0VThzLy9VcFVvVHpXSzExam85UWE4OCs4cnloR3VreVpXdmE2R0tOMzBW?=
 =?utf-8?B?cDlId01ZQUJOQm9qcjcxYThHK2hiL1VqRDQ3RWVtS1hSc2tJQVdUYTNlT0Vy?=
 =?utf-8?B?Um1YQXh1WFJjVUdta2RvVXVSb1AwZERWTXJadExURjN5RVFKL0lielJuSUVJ?=
 =?utf-8?B?d1Z2a3lNMkxrcjJEUEtFbU9PUUN3OE11K3RLRCtoYzF6dk0xLzhBWWhvL0kx?=
 =?utf-8?B?Z3B2cXlZejYwemdTOHZtUVcyR0ZHMk1LWkFBWmFvbzFBVGRQc1dYbnV3ZE1P?=
 =?utf-8?B?MEZlak1ZTzlWWTBQWU5oRzM1TXlwdWl5T2tFVjk5c2Npd01sN3RSb215SVRJ?=
 =?utf-8?B?dWJJSk91MjF0YlA5TVRTZGd1REtUZVIvNGRsRTQyRnBHWW5LQ2J1Mnp1QmVa?=
 =?utf-8?B?Mkt5dDJ0NWx0cVNncnM4UzgvTis5OWwzM1d3TW5UeWV6TXBYakdZYVdRNFhB?=
 =?utf-8?B?TTBhNUQ0eXI1YkVlSnNFUk9pZURsWEkzYmpqUTZLYnpuUGlFYmllWXlCREpP?=
 =?utf-8?B?cTBtdzhWei9DdGR0T0R4NXE3ZmVGalUvN0dMa3RYV2NXV0FqcXJWSHYzNEd3?=
 =?utf-8?B?NE1EVGcwZDVtbDE5S091ZzladUNBYlErUzV6THVBVW92empycVlXYlg4TlpK?=
 =?utf-8?B?WWVYdUxmdTdZb3VxbXRQbnVidURxV0Yrckh3ZnNacEVjTXg0Vzk1N3RuRzZZ?=
 =?utf-8?B?djMzejQ2UndlbHJaa3BpVlhlY2Jra21FczdNZXZQaE94V3VNQzZZTHpsQ0Zh?=
 =?utf-8?B?N2d4OXNndzQ0MVVCQTY0VUg3a1J1WkZUNjdRVDBBbXF4bTFkeGltRWtZeDFR?=
 =?utf-8?B?VWxsbllIWnpzMkVKcE02Zmw3SlFiQ1FqZ0hrclZySmhvMTdiMTBzVXVQbmIw?=
 =?utf-8?B?dTFVK1pmaTFSdkVYOVdqOW4zb0VkK2M2dUNEblFQcUhlZE56cVdkcHJqLzEw?=
 =?utf-8?B?Y2lZNUVOV3ZRTTlVTHdvak9HMXN6eC9wdDllUmxRRnI2WWY5ZVZiR0tKWkxs?=
 =?utf-8?B?Y2ZDRnVBR2NtVEk5L1pIRHQvMUE5czJzb0pRUllnZFlTd1JxQ2xWRkF6QkEw?=
 =?utf-8?B?SjRsRmxzOGRETG42NEQ5S0w2b1k2dFQ1TW45ek53c3kzMWNjVktIVUVjKzBv?=
 =?utf-8?B?OTdWeDRMSUs1VXErbzlsOHNGbG81T0M3WkdmZVR1NTRkZDFkdm9DeWk2dW5C?=
 =?utf-8?B?NUlkN1ZUNEJOd1pjMzFhczEvYkg3dEJKa3RxRlhYa1ltYkVhNDBacnZCdnlx?=
 =?utf-8?B?TTg1WENXcVNKWDN2UWlpa0xlTEV2SkpuektZTFhaVmk2ZHJYbi95c1QyOGpS?=
 =?utf-8?B?WXZITXZGc3Ywcm5aU1lmL1FybE4wY2RvWnNZczRTM1U2czlaZ3BobmxXdFdI?=
 =?utf-8?B?R2J0dWFxbEpZTXJXR0ZKMEQ4SklIYzJPNnBnZTdlZUxsUUU4cjExeDFVZExx?=
 =?utf-8?B?eU1kZmFFOHNnTWppSW93TEFiQWtBTWREdG5QY1pCanNzSnc2ZUQyTGxSY1Ji?=
 =?utf-8?B?VDNvV3JGUmgzM3BrS1BtY0NaVWpKam9wT01WSEZ6cDZQMlBhU2x1bFU5bjRl?=
 =?utf-8?B?RTVBYnBER256Sm9XaWRUR3JFWkNjKzZUaEhPVEFJREV4WmJMNHJ1Rkw2a2Y4?=
 =?utf-8?B?eVhkSDE0a0p2ZG5tWUlObHM0cGl4VzRHQzcxRVFSRmZUbjFLSVVodEI5NTZB?=
 =?utf-8?B?ZFZ5eWptcXhMT0ZFYkJJKzdoTTVaNk9qTmpveFZML2czWjRPUHdBSnMyZktl?=
 =?utf-8?B?bjVIQ3lDV0JlMFNDbTd2c3JTakxLK2J6N3htQkxmSllraWZzdGgyaG1LRk5J?=
 =?utf-8?B?b3ZuNGdyUnNsaUV5dEErZXdEZ1VhNkc1Y0hWZVhiUjNzWm1La1E5N0NrT0NC?=
 =?utf-8?Q?kwfOTi0bhUNX00v5ImygpnWmv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6c1567-1aef-4ce5-78b7-08dac82ca6b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 23:45:32.8845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX1sCLwQjEUsnGze+YSwd9fOcBltzDkn0ujBoYWrFzR1aXJyRIb/f9OECHhnCGeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not sure how much more to say, than what the commit description says now:

	Read and interpret IPMI data to get the product name, product model, and
	product serial number.

It reads IPMI data, and interpets it, to get the prodcut name, product model,
and product serial number.

What else is missing which should be part of the commit description?

The change of this commmit doesn't really do anything else.

Regards,
Luben

On 2022-11-16 16:19, Russell, Kent wrote:
> [AMD Official Use Only - General]
> 
> You can add my 
> 
> Reviewed-by: Kent Russell <kent.russell@amd.com>
> as well. And I have no issue with a little elaboration on the commit. We definitely changed a few things here.
> 
>  Kent
> 
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Wednesday, November 16, 2022 3:59 PM
>> To: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Russell, Kent <Kent.Russell@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amdgpu: Read IPMI data for product information
>>
>> On Wed, Nov 16, 2022 at 2:49 PM Luben Tuikov <luben.tuikov@amd.com>
>> wrote:
>>>
>>> Read and interpret IPMI data to get the product name, product model, and
>>> product serial number.
>>
>> Patches 1,2,4 are:
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> for patch 3:
>> It's not clear from the commit message what this change is doing.  Is
>> this just a rewrite/cleanup of the existing FRU parsing or is there a
>> bug fix in here related to the rest of this series?
>>
>> Alex
>>
>>>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Kent Russell <kent.russell@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> Tested-by: Kent Russell <kent.russell@amd.com>
>>> ---
>>>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 183 ++++++++----------
>>>  1 file changed, 85 insertions(+), 98 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>>> index 9b2ff386b7c4f8..2c38ac7bc643d5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>>> @@ -94,39 +94,12 @@ static bool is_fru_eeprom_supported(struct
>> amdgpu_device *adev, u32 *fru_addr)
>>>         }
>>>  }
>>>
>>> -static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t
>> addrptr,
>>> -                                 unsigned char *buf, size_t buf_size)
>>> -{
>>> -       int ret;
>>> -       u8 size;
>>> -
>>> -       ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf,
>> 1);
>>> -       if (ret < 1) {
>>> -               DRM_WARN("FRU: Failed to get size field");
>>> -               return ret;
>>> -       }
>>> -
>>> -       /* The size returned by the i2c requires subtraction of 0xC0 since the
>>> -        * size apparently always reports as 0xC0+actual size.
>>> -        */
>>> -       size = buf[0] & 0x3F;
>>> -       size = min_t(size_t, size, buf_size);
>>> -
>>> -       ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
>>> -                                buf, size);
>>> -       if (ret < 1) {
>>> -               DRM_WARN("FRU: Failed to get data field");
>>> -               return ret;
>>> -       }
>>> -
>>> -       return size;
>>> -}
>>> -
>>>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>>>  {
>>> -       unsigned char buf[AMDGPU_PRODUCT_NAME_LEN];
>>> -       u32 addrptr, fru_addr;
>>> +       unsigned char buf[8], *pia;
>>> +       u32 addr, fru_addr;
>>>         int size, len;
>>> +       u8 csum;
>>>
>>>         if (!is_fru_eeprom_supported(adev, &fru_addr))
>>>                 return 0;
>>> @@ -137,88 +110,102 @@ int amdgpu_fru_get_product_info(struct
>> amdgpu_device *adev)
>>>                 return -ENODEV;
>>>         }
>>>
>>> -       /* There's a lot of repetition here. This is due to the FRU having
>>> -        * variable-length fields. To get the information, we have to find the
>>> -        * size of each field, and then keep reading along and reading along
>>> -        * until we get all of the data that we want. We use addrptr to track
>>> -        * the address as we go
>>> -        */
>>> -
>>> -       /* The first fields are all of size 1-byte, from 0-7 are offsets that
>>> -        * contain information that isn't useful to us.
>>> -        * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
>>> -        * and the language field, so just start from 0xb, manufacturer size
>>> -        */
>>> -       addrptr = fru_addr + 0xb;
>>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>>> -       if (size < 1) {
>>> -               DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
>>> -               return -EINVAL;
>>> +       /* Read the IPMI Common header */
>>> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, fru_addr,
>> buf,
>>> +                                sizeof(buf));
>>> +       if (len != 8) {
>>> +               DRM_ERROR("Couldn't read the IPMI Common Header: %d", len);
>>> +               return len < 0 ? len : -EIO;
>>>         }
>>>
>>> -       /* Increment the addrptr by the size of the field, and 1 due to the
>>> -        * size field being 1 byte. This pattern continues below.
>>> -        */
>>> -       addrptr += size + 1;
>>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>>> -       if (size < 1) {
>>> -               DRM_ERROR("Failed to read FRU product name, ret:%d", size);
>>> -               return -EINVAL;
>>> +       if (buf[0] != 1) {
>>> +               DRM_ERROR("Bad IPMI Common Header version: 0x%02x", buf[0]);
>>> +               return -EIO;
>>>         }
>>>
>>> -       len = size;
>>> -       if (len >= AMDGPU_PRODUCT_NAME_LEN) {
>>> -               DRM_WARN("FRU Product Name is larger than %d characters. This is
>> likely a mistake",
>>> -                               AMDGPU_PRODUCT_NAME_LEN);
>>> -               len = AMDGPU_PRODUCT_NAME_LEN - 1;
>>> -       }
>>> -       memcpy(adev->product_name, buf, len);
>>> -       adev->product_name[len] = '\0';
>>> -
>>> -       addrptr += size + 1;
>>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>>> -       if (size < 1) {
>>> -               DRM_ERROR("Failed to read FRU product number, ret:%d", size);
>>> -               return -EINVAL;
>>> +       for (csum = 0; len > 0; len--)
>>> +               csum += buf[len - 1];
>>> +       if (csum) {
>>> +               DRM_ERROR("Bad IPMI Common Header checksum: 0x%02x",
>> csum);
>>> +               return -EIO;
>>>         }
>>>
>>> -       len = size;
>>> -       /* Product number should only be 16 characters. Any more,
>>> -        * and something could be wrong. Cap it at 16 to be safe
>>> -        */
>>> -       if (len >= sizeof(adev->product_number)) {
>>> -               DRM_WARN("FRU Product Number is larger than 16 characters. This
>> is likely a mistake");
>>> -               len = sizeof(adev->product_number) - 1;
>>> -       }
>>> -       memcpy(adev->product_number, buf, len);
>>> -       adev->product_number[len] = '\0';
>>> +       /* Get the offset to the Product Info Area (PIA). */
>>> +       addr = buf[4] * 8;
>>> +       if (!addr)
>>> +               return 0;
>>>
>>> -       addrptr += size + 1;
>>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>>> +       /* Get the absolute address to the PIA. */
>>> +       addr += fru_addr;
>>>
>>> -       if (size < 1) {
>>> -               DRM_ERROR("Failed to read FRU product version, ret:%d", size);
>>> -               return -EINVAL;
>>> +       /* Read the header of the PIA. */
>>> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, buf,
>> 3);
>>> +       if (len != 3) {
>>> +               DRM_ERROR("Couldn't read the Product Info Area header: %d", len);
>>> +               return len < 0 ? len : -EIO;
>>>         }
>>>
>>> -       addrptr += size + 1;
>>> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
>>> +       if (buf[0] != 1) {
>>> +               DRM_ERROR("Bad IPMI Product Info Area version: 0x%02x", buf[0]);
>>> +               return -EIO;
>>> +       }
>>>
>>> -       if (size < 1) {
>>> -               DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
>>> -               return -EINVAL;
>>> +       size = buf[1] * 8;
>>> +       pia = kzalloc(size, GFP_KERNEL);
>>> +       if (!pia)
>>> +               return -ENOMEM;
>>> +
>>> +       /* Read the whole PIA. */
>>> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia,
>> size);
>>> +       if (len != size) {
>>> +               kfree(pia);
>>> +               DRM_ERROR("Couldn't read the Product Info Area: %d", len);
>>> +               return len < 0 ? len : -EIO;
>>>         }
>>>
>>> -       len = size;
>>> -       /* Serial number should only be 16 characters. Any more,
>>> -        * and something could be wrong. Cap it at 16 to be safe
>>> -        */
>>> -       if (len >= sizeof(adev->serial)) {
>>> -               DRM_WARN("FRU Serial Number is larger than 16 characters. This is
>> likely a mistake");
>>> -               len = sizeof(adev->serial) - 1;
>>> +       for (csum = 0; size > 0; size--)
>>> +               csum += pia[size - 1];
>>> +       if (csum) {
>>> +               DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
>>> +               return -EIO;
>>>         }
>>> -       memcpy(adev->serial, buf, len);
>>> -       adev->serial[len] = '\0';
>>>
>>> +       /* Now extract useful information from the PIA.
>>> +        *
>>> +        * Skip the Manufacturer Name at [3] and go directly to
>>> +        * the Product Name field.
>>> +        */
>>> +       addr = 3 + 1 + (pia[3] & 0x3F);
>>> +       if (addr + 1 >= len)
>>> +               goto Out;
>>> +       memcpy(adev->product_name, pia + addr + 1,
>>> +              min_t(size_t,
>>> +                    sizeof(adev->product_name),
>>> +                    pia[addr] & 0x3F));
>>> +       adev->product_name[sizeof(adev->product_name) - 1] = '\0';
>>> +
>>> +       /* Go to the Product Part/Model Number field. */
>>> +       addr += 1 + (pia[addr] & 0x3F);
>>> +       if (addr + 1 >= len)
>>> +               goto Out;
>>> +       memcpy(adev->product_number, pia + addr + 1,
>>> +              min_t(size_t,
>>> +                    sizeof(adev->product_number),
>>> +                    pia[addr] & 0x3F));
>>> +       adev->product_number[sizeof(adev->product_number) - 1] = '\0';
>>> +
>>> +       /* Go to the Product Version field. */
>>> +       addr += 1 + (pia[addr] & 0x3F);
>>> +
>>> +       /* Go to the Product Serial Number field. */
>>> +       addr += 1 + (pia[addr] & 0x3F);
>>> +       if (addr + 1 >= len)
>>> +               goto Out;
>>> +       memcpy(adev->serial, pia + addr + 1, min_t(size_t,
>>> +                                                  sizeof(adev->serial),
>>> +                                                  pia[addr] & 0x3F));
>>> +       adev->serial[sizeof(adev->serial) - 1] = '\0';
>>> +Out:
>>> +       kfree(pia);
>>>         return 0;
>>>  }
>>> --
>>> 2.38.1
>>>
