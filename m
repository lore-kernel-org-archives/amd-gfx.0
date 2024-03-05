Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF8C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 21:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB5810E1C1;
	Tue,  5 Mar 2024 21:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWkZ4Ie/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9724C10E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 21:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Try4ioSEHPxEqlOr4JfpvZv9empXrorjnntvXhhH0ACuNgTJUAXceJ5WJLxrVf9MGq34KjcTTPDr4a7pvWzxLivtjFCueh3pfECs4N9mD1NCowzLV3jjP32gqRUP9NPnM/l4N7ikCtbxML4ZPsl5tckPrfnxNUNln6fjq0pMyZROKYjiubkIOLv+8bH50yM4SoJPMpgJ18GjkisdLaum2Ko9+IQf89Xv6KBt7ldtNcfZqpl//9wvSMm+UqWRA9JioKVHSCf2elJR1pNoZ5Wsr2BEKzynJDV4fOOh3xJK+XDvxCWjsgSWA942QBuQ7aMgcR7cT6cozRXEIw5yBYv3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia2blw+dxRTVNfTyMae9uW61UJ2Z4n07T34hazLhv0w=;
 b=P0dxoWJOpYAalzztcdyhB8FucMDpJsVgViJwrg7rdWeip7bziIhby44Jm8lAJzmyWnwKcO2+tF2z+csbJ+/v6AZra8tRMzZwoBjMvBXvS7TkVTufPABETonbGVpCejzKaPCJ+FuWg7jGFHGgiXCQ+AHcqA5Xzq5agcbuAbx0Pj98I7KS3F4pVRobyeOejav06+9+3qUZm/Evl3l4GXhrP63BeKV4kOXEiGTR81g6Zt3V+3ebLrH5UpOTaMCy0YUJ4PHSUdFTSoMGKdazOKp+WtJJizOJgzCxuhdRNmtsSU0N+cHjpsSa3nQI8eh7pLAd73fJhPUBcLChghkb08Yfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia2blw+dxRTVNfTyMae9uW61UJ2Z4n07T34hazLhv0w=;
 b=nWkZ4Ie/qeZnYjTHogUF04oM3gB8xFozvfjYQbZe2d0AUrqJuKtptjv2OdIGudALJXXQUFsX7hyjhNa6X7DfuEBex4GLANhbaTTwRE8vHcQkVAnJs9eb3b8bjShagOCXyWCmVWxxdAhuNmTmv1G6dLGHkY7CWpDoPM8o6XmeTXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 21:14:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 21:14:48 +0000
Message-ID: <ac98d26e-7dfc-401f-a8ae-5cc3a9215858@amd.com>
Date: Tue, 5 Mar 2024 16:14:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: sdma support for sriov cpx mode
Content-Language: en-US
To: "Dhume, Samir" <Samir.Dhume@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
References: <20240304151931.802397-1-samir.dhume@amd.com>
 <20240304151931.802397-2-samir.dhume@amd.com>
 <5958ccab-35a1-4802-be50-77e9a7d80c10@amd.com>
 <MW5PR12MB56002CED0987A31B15225044E6222@MW5PR12MB5600.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <MW5PR12MB56002CED0987A31B15225044E6222@MW5PR12MB5600.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: fa67cf85-2710-499e-de50-08dc3d594a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPd9w75H8NLenz6hgoU77cBq2nICPT66/wiPtER4Z6uAuHXU3iExqK5SHO2opDX08cgvyHlIPnGKnoaoteobfqW2yy9EumT4Gou8VSmkhtH9joE7XBV7MXAQA31jqBjgf0tTeIP0KhzSBSXqgO89TVr4LEgpAN4HspMG+e5LR8qJ7sUjRgzfDu99Tf1SlUNrbnu+z8fpAtk4u75lZJSE6/8OmVPoVWyPDY3ll/qFzbCeG1gYZPuxdnDs+b9/1tRhMYXuLAh93DBFN9SBxiNOdIOMtbO9xQKLV4oE2sWbv7sGh2M6CippViwdTIkReAtIGL/xX3MD7sPfCpvS+o9/35TfnayyT8brC+JxbUdIZGaqeXV9fJP+LEAm6YZ/RkC7PcgdAB6uslmnVxCve/QSILmGy0YkerGi1dImi6tRDOiiwJjRzGlpuV9mStvQVlK5Q/CUebQaWq1LKfIMs9g5kGKYRLfyj9Yehu611XJBXgSUMR6fG8HBccgzcsziHxTfDsjf+lbw54Evmmqe2erd3DJjOekwXYU1LEImIs8hvkENvVlUXY8kRHP7eBtmOYzNXcdrlFXIkue3ffdyU6tBB+A7uyzz/YPvjrF4LZNvkPg7LHnP3w9qJO+l1p5hR8XAnszyQt7SCLI8OFG3uXU/DHF68uugtJr2mDeHSRryW4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ozdUVwRU1yczhoK0RYRnU1T1JzTG80T2hCUGdWaG1kNGIzK1pYcm85cms2?=
 =?utf-8?B?SlovTzR6YXR3ZnUyNmhiaFB3WWZKZEd6enVmcERpYmZoM25NOWM5MWFaNk9q?=
 =?utf-8?B?Slc5Y2hEcWFqcG1yQjc5eUl5WlB0dTlQQUkzOWNFWXBoZys1aHREeXliVlJD?=
 =?utf-8?B?NmRXcXRuZzhrRG9wZm5mVFpralRLWUl3WVFqZjdVNy9zR3pPdzNCTlVXQVhP?=
 =?utf-8?B?QS9JTklJcFZPWmVnN1ByRzVOdmZzSkRUTk1WSkkvaGcyMzkzY1RGby9XUkNY?=
 =?utf-8?B?VWJYSStRbG1HRXVYWHpPWlhyZFk4VFAxZXo3VzU2U2VlNFY2UjY3djBFMlMx?=
 =?utf-8?B?cUJtcndEQVlERS9BOXRCcUVRRk1hTTRmOHJZKzYyVHd2dXYyQmRpb0kwZjla?=
 =?utf-8?B?dUE2RXNFRHZoY29ack92ZW1TMERtRmJ5bXlidjZZWnBmTmdjU0gva05xNlRT?=
 =?utf-8?B?eFdrV3g3cW5ZYURPVHVrc3pKYjhTdHFCWEoxWFBDMkg5Y0IxOTFoaFdha1RJ?=
 =?utf-8?B?OEN6UkhIakRHUnRwcEJFcUdoMjkwNExaZUUzRWhJVHlTT1pLM0dvRTVTNmJi?=
 =?utf-8?B?WFgxZVlIZDJxTUwzTllJb0tKa0NDenV2anduYzZ2R0YrbzFmTnkvYyttSmRp?=
 =?utf-8?B?YW5OczBMMWdGVENVUElka1ZUTjgzYUhEKytMa0lWb2Q5eXJMTUZLTnpaY3N4?=
 =?utf-8?B?QlRwSWZvUDdjc3Nac2FqaGhteFdWYjEweWJTa0tmRW5BQk9Hb1ExKy9NaXFG?=
 =?utf-8?B?UmlaUm9XSUxaL0lmVGZyRVhXMnpyMEZ1Y1pDR3VvVHpzejRZTTdNNHo3VHZH?=
 =?utf-8?B?UjdPWWJXTWc3S0xuMG4wTWFoRlhNRXBDc1RMcHNveXhjRDlWRTNMQkJycm43?=
 =?utf-8?B?MjdjWmV5NHltUHU3OFRycEE0ZHgzMVJ3UEJRRFZMUDY2bEtOdVV1Y3hBajdM?=
 =?utf-8?B?RTN6RjNQRlVHTkdhRHdDZUV4dXdNVWUyWXZweUdHNUthZWVXWll5S0I5R3ZY?=
 =?utf-8?B?ZnFoZ1VheUp0ZER4bnZjeE5ma0Nna1pzMWR3eVkzUkxBM29qaXdSdWRKRFZK?=
 =?utf-8?B?VlEveG9HV0k5Y0h5Wi9FWU1uZS80dmt4bXhsUVNqREcxcUhTN0gxVkVwS04w?=
 =?utf-8?B?NDAwcTVwRVhhTG5vT2d5bHVtRWI1R3dmN1poWWN2eCs1U1RJRjhpeXA4WmFp?=
 =?utf-8?B?TnNId0ZSZEZYRmcyRENCTTFRYkNZd3dsMnJHUjdkcE53MlUxZDg0ank3bHEx?=
 =?utf-8?B?cnNRWm9DYWdjMG5tUnErYWNQTjcwLzg5aFpvcmdyNlVJRzgxUjNOeFFSc2Fi?=
 =?utf-8?B?bExKenRidmJFMWxockdCTFBaNDh5NkdaTEc4c0k4U3FSZHZXQkpiZEh5N1Bo?=
 =?utf-8?B?ZU5CVnRsSlVQUnhNdUl4WTU0L2w3bHpUNW82UHYrTUI0bUxxWEtoemxLNGRP?=
 =?utf-8?B?dVNyVVNUSFMvcTBhQ3R5blE3ZmV0bHdNOXZqOFllQ3BXbWpqdFRQcXNtUHZa?=
 =?utf-8?B?R1lQM0FJcTg2NCtaWlVmdHVjL1Z6Y3NZMzhXR0JSYUhvcWs0cEM3SlV5b1gw?=
 =?utf-8?B?R0Q5amFGNWxYR0N5TGxlSzdrK2JObGdUQmN1OTBhakhKNU15aXJaME9aOFdS?=
 =?utf-8?B?YXN1VE1XOWEwQmxSMnVpL1lGWUNKNGFISFo3NVo1TkVZZkoyUkE0KzlXY1dG?=
 =?utf-8?B?SVZqR3liNDd2N05XTlpIVjlCY2tjSGduSkpSTnV5T3h0T1VBa2xTRHAzMXp6?=
 =?utf-8?B?VXduU2xqS2pwSm5EaFdOTjNRRjFUWkRXbFJhVmNRN1dscGlvNSs3K1JPN0hN?=
 =?utf-8?B?aGFsalp1cGc1c2VnYnEzRXZkbVcvSG5qaDV0S3YzMVRnR0Z1MVVoenJMVXI2?=
 =?utf-8?B?Vkg4dUdCMHBCYzN3dW1xL2RrMWdnK2dkbFlNVitoVEdxNUgzVXdkdGtMSzI4?=
 =?utf-8?B?Lzc3eG9taEpmdkEyOEZ4ekp0N0MwbnF3QlNCSzhUdlpNNDNacTFHaFc2TXA5?=
 =?utf-8?B?V2ZHUy9hT3hkbDY5RHJiT2RJeXFWa0toNGFFOGZQT3pGUTgrSHBLbXVKV0tx?=
 =?utf-8?B?aW9SWUJ1cXVNSzFtemI1YWUyOHgveG8xL05CK0VBRzEycjNRTkxBYzg1aTFs?=
 =?utf-8?Q?/qBcvGnVJRo4pPgqv34cLhW2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa67cf85-2710-499e-de50-08dc3d594a0a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 21:14:48.4818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wacMIIWQTPRCepn7Ut19yoC9SLyTxk2j73qAJbJd1rFoz2jCJ9cL71T9w2cWIKIJS4IUwadyr6Fij8IM2EPK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-03-05 14:49, Dhume, Samir wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Monday, March 4, 2024 6:47 PM
>> To: Dhume, Samir <Samir.Dhume@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>;
>> Liu, Leo <Leo.Liu@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/3] drm/amdgpu: sdma support for sriov cpx mode
>>
>>
>> On 2024-03-04 10:19, Samir Dhume wrote:
>>> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
>> Please add a meaningful commit description to all the patches in the series.
>> See one more comment below.
>
> Right!
>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 34
>> +++++++++++++++++++-----
>>>    1 file changed, 27 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index fec5a3d1c4bc..f666ececbe7d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -82,17 +82,37 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int
>> seq_num)
>>>      }
>>>    }
>>>
>>> -static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
>>> +static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev,
>> unsigned client_id)
>>>    {
>>> +
>>> +   struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>> +   bool sriov_cpx_odd = false;
>>> +   int mode;
>>> +
>>> +   if (amdgpu_sriov_vf(adev)) {
>>> +           mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
>> This queries an MMIO register for the current mode. Is that really
>> necessary to do in the interrupt handler? Could we use the partition
>> mode stored in xcp_mgr->mode instead?
> The design appears to be that even when the host sets the mode to DPX/QPX/CPX, each guest sets itself to be in the SPX mode and xcp_mgr->mode is set to SPX.
> But I can use a new field in xcp_mgr to reflect the system mode set by the host and remove the MMIO access from the interrupt handler.

Can you clarify what it means when the host and guest see a different 
partition mode? Is this the case, where the host partitions the device 
into several VFs, and the guest partitions those VFs further into 
smaller partitions? As far as I know, that finer partitioning in the 
guest is actually controlled by the host as well. If the guest sees SPX 
mode, it means it doesn't partition the VF into smaller pieces.

Instead of looking at the partition mode, would it make more sense to 
just query the number of XCDs in the partition (from the xcc_mask)? That 
should give the right answer regardless of how the host partitioned the GPU.

Regards,
   Felix


>
> Thanks,
> samir
>
>> Regards,
>>     Felix
>>
>>
>>> +
>>> +           if (mode == AMDGPU_CPX_PARTITION_MODE) {
>>> +                   if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
>>> +                           sriov_cpx_odd = true;
>>> +           }
>>> +   }
>>> +
>>>      switch (client_id) {
>>>      case SOC15_IH_CLIENTID_SDMA0:
>>>              return 0;
>>>      case SOC15_IH_CLIENTID_SDMA1:
>>>              return 1;
>>>      case SOC15_IH_CLIENTID_SDMA2:
>>> -           return 2;
>>> +           if (sriov_cpx_odd)
>>> +                   return 0;
>>> +           else
>>> +                   return 2;
>>>      case SOC15_IH_CLIENTID_SDMA3:
>>> -           return 3;
>>> +           if (sriov_cpx_odd)
>>> +                   return 1;
>>> +           else
>>> +                   return 3;
>>>      default:
>>>              return -EINVAL;
>>>      }
>>> @@ -1541,7 +1561,7 @@ static int sdma_v4_4_2_process_trap_irq(struct
>> amdgpu_device *adev,
>>>      uint32_t instance, i;
>>>
>>>      DRM_DEBUG("IH: SDMA trap\n");
>>> -   instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>> +   instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>>>
>>>      /* Client id gives the SDMA instance in AID. To know the exact SDMA
>>>       * instance, interrupt entry gives the node id which corresponds to the
>> AID instance.
>>> @@ -1584,7 +1604,7 @@ static int
>> sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
>>>      if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
>>>              goto out;
>>>
>>> -   instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>> +   instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>>>      if (instance < 0)
>>>              goto out;
>>>
>>> @@ -1603,7 +1623,7 @@ static int
>> sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
>>>      DRM_ERROR("Illegal instruction in SDMA command stream\n");
>>>
>>> -   instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>> +   instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>>>      if (instance < 0)
>>>              return 0;
>>>
>>> @@ -1647,7 +1667,7 @@ static int sdma_v4_4_2_print_iv_entry(struct
>> amdgpu_device *adev,
>>>      struct amdgpu_task_info task_info;
>>>      u64 addr;
>>>
>>> -   instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>> +   instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>>>      if (instance < 0 || instance >= adev->sdma.num_instances) {
>>>              dev_err(adev->dev, "sdma instance invalid %d\n", instance);
>>>              return -EINVAL;
