Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851EEC54E49
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 08:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D6710E42D;
	Mon, 26 Feb 2024 08:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KevY5SHM";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5634210E42D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 08:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4RarbjZldHwKIVwA9eZTEDkWCLRkVuPHIzXTqAfiNX/PtmSKoqBDdQOp3QJWsPJadZ+gwXDf2mOBK2U3JFrXM4ICu48eN5IjKCUp7IYaS34aSfyT/Wl3R8nXrC6JMeAWNo+5uZXlr5QFSzxVv3jH3k8JgDYIjOcXMKVYOaDtbE6O74wbtEU5zwtTkXL4G0zO4FeFdnRtlSdFAYRCmXcqrqcknexKw5SuYxBlkatJo4YkryC7e23Sih2XyVGMG2ITOB4SDMdb8sExPK5vZwzq1c087HiSfT4R1wZHwFQ2di1u0KKapKfUBIWV2fXLkSHbZ/mmQV+SoNNzQGqLERYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvNEwGJdykLb8l5YVrmeDTf0Byw5XbJf6lOhSX5wySA=;
 b=SXieI0fmMMWPRSnY+m57J6dbV3nnyqIoFGe8hec7AOq9UtiqYU0PDbn9kM5LOBshb1C6azj6i9RTtlA4TUcy7w83EWdd9dZhMZBsLeY2Dfmyz/rSad2/AacKJU+pu1OjuN4jM9nv2JCmQv+vUSOFvp/TVCbeUXqbUJfSGALOYcoiWr0yuN42xGROJrc26mcHyZKavml3W5Gj7m2ShpJJAoZtDzZWoRwQGXeENHCavBFcrWZuC0icnj58Gx5sUr89j9NgZHshKEHlruegETUZNFReuOi8L5Y9UpBQwIoqWSmfpGPQOgYuYkXKVEX3DrryGWE+mzrETIk80I/2mVeXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvNEwGJdykLb8l5YVrmeDTf0Byw5XbJf6lOhSX5wySA=;
 b=KevY5SHMPQK2zxUxu4xFiW2ZtjvpHoOpiCO0sFLCBdpK7W3VsRVuREj75eOxQHbiVraMpFvyR8A43xjMMkj4S+njgnEizxFmnp2LoZc954EhpSv3OtQxDN+Ci8aDBqytsFDeC8rxEvK9MMAuyHOCX9CH5CFEeG0MZ4YN5NfjA30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 08:44:58 +0000
Received: from CH2PR12MB4119.namprd12.prod.outlook.com
 ([fe80::9d8f:d9c4:133b:e56d]) by CH2PR12MB4119.namprd12.prod.outlook.com
 ([fe80::9d8f:d9c4:133b:e56d%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 08:44:57 +0000
Message-ID: <6591b62b-208b-4459-b0f2-479fbf34c51d@amd.com>
Date: Mon, 26 Feb 2024 14:14:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix potential ioremap() memory leaks in
 amdgpu_device_init()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
 <d916ca82-b0a6-4b32-948a-f5a1c06bfeae@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <d916ca82-b0a6-4b32-948a-f5a1c06bfeae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To DM6PR12MB4122.namprd12.prod.outlook.com
 (2603:10b6:5:214::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:EE_|BL1PR12MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a9e3b2-508f-4244-b94e-08dc36a735d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjH2iyAQg8CKabdGX7A5P9dFZphff0MNy3Ec/n7imj2bf5k0i8pfDikqaEawMQeXhiO4r251ejTTtmxilOOmgpH0qgqu22PmBPQ2cHF3ViVmbz56WlEdkfIzOJkyvGBeS0SaZU/GcSqOHUOwuwtrSMJSaHL8CMC52Gur50qRpXlV02EiPGvWGq/95FkEmY3jG2TpOpsSpA6gOySvQB2aTFvEZbyJrvYVg2mqOxAFt0iHiVpv6DgqcG3Ie3EhVQZv4Gy6w0M72QlbvuuFhc3rVxNPRO9S9CpHkFvdng9XCLf5rbxr91SER4/tHP0BtVpaHBxqyPAUP44WchJbz+ZZg1Ie4ARPMNiute9+IBDvjFo6SpR3IYFeipgLK2qs4pYJzgLgHzgUdAgQNn9YRjOdRoqmBWEXC1CtMK5KTs/ondeXigi8Gt9sLO7QkCxym7VJxUnXDderEI8Jzl2/Fsj1D6S7Uq/k2w0cWwtJWJS0Slu4Wc1dTS3L+Kwa9NLmCGjgWwhXcPDuHOKZSLanlRo7NQ/Z73KcgUSimRG+K3z4H8RB0dyWZvFup0nVh2xa62x9iJMcD1/5uTge+MoMxxKHFz2pIHtXyR6SQZbK824FuraEclqfmUSdxgBiQnhmMc6kBt3Z7oInP//bpGhWC3j9HgOyNFf5NsU0HfezAqTPcNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWo1dGZJTUhYK3VMOTNCSm00eDBSejM5Zkd5RERLYjJIL05UeWIwSkJmQ0lz?=
 =?utf-8?B?L3JQdlUwWGNwQ3RvTkNRcGlra0U0ZzlocWxic0Jnam9Oc0xKam15akNmMTQ5?=
 =?utf-8?B?K1NFVHhMSFlUVjVSTDRPRUVxVDh4OHI5MXJQdnZnZEp0cHJwTXNtNVNQOWZR?=
 =?utf-8?B?dmt5Ujk3ZUhWK2JDRDlVU0YzcE8zazdwNlJsb1hpZXpFOVB0czM3TnNEWUJi?=
 =?utf-8?B?RUpwZkRyMG9la1VHU1pnTXpKYm5XYXVCWXgwTnNFRVY5ZEovMXJ0elJnL0xT?=
 =?utf-8?B?aTZOY2E0ZDZUWVcySHNoMXFvaVJNMUVFbHJWNkcwSHpaMG1Rejg4dGYyMyts?=
 =?utf-8?B?RW9KUG5vZk1XNHdBWnBkTkcxaG8zaVVEbm9WU0g1WlZLN28wNHRwVTVLRlRm?=
 =?utf-8?B?ODNPelBBNS90TGRYclllQzJkZndxRzU1NWxQMW1mSnR6SWVkYTF0bVF2ZGJD?=
 =?utf-8?B?OGcwVFhPZ2xUbzN2MW13eE5GT01QRDNOSXJPQS9jcGJId2RHNVYyQnpnR1NF?=
 =?utf-8?B?TWptZGZhbFJWQ2N5MU9Wd3FTRjZVTDRsb21wQjMvWVBGSjUxYVMvTjltTGlo?=
 =?utf-8?B?OVhINmdKRzhqb1ltdkxRbXZMRlVMUjczOU05WWZBd3FOeUVmMjYvRU11djJX?=
 =?utf-8?B?TWVBY28yUzRwbW5CZjZEZVB2YkhHSE5Bbmhudnp3WVdiSDQwK3pBUjk5dHg0?=
 =?utf-8?B?R3Y3eklCU0p2K2hpTnltK1NtMnVCVkluRmZCZzVlNFF0d3N2bHJETXIySWc2?=
 =?utf-8?B?b3U3S1ZNWng5TFJDQ21ISkh0ckgxLzhFWTVkbUZBNVZZRFQ0dlk0OWhEeGxP?=
 =?utf-8?B?NHhGdm5HVXBiSERScUltV0ZQa2xLeStXTVVoZndBSXFMTzdNYXd3eHBaSDNJ?=
 =?utf-8?B?SUtnWEZveGRGNHR5SG5nM3cvbWp5UGVwVzhHMktzVFI1bnlyY3paS0dxWjhH?=
 =?utf-8?B?RVllRjh0RHM2WTJSN0dyK1F3ZU1iVUxBSHVjVDlxT002QmUvYXZuQnNOS3Y4?=
 =?utf-8?B?Sm5lR2huU2VSVUJYYjNUM1NmekNrVzBjUDFJOWd6Z0R3a1Q0ZXhRU0hXUHhW?=
 =?utf-8?B?WWE3WXZObHhSbUR6T1B5VXZEWTExUStjbTd6K1RzYlQvUUNPNWhxTEFuWUhl?=
 =?utf-8?B?M2t6TmJJbklTeStraWVEdjFBb0tCRHo3NUZMbjFmUHUrZG1FKzUyRi9zUkRp?=
 =?utf-8?B?YnRuOU5iZTRvcG9mMzZoeWlBeUl1TnlCYmYwNzFVT0luMSt3dEI5OEJObDUr?=
 =?utf-8?B?RkZEbGFyaC9ScHI2UldqU2N3VjNKR3dWVWQwTC9RV09xeXZkdlNnTk16Z1k0?=
 =?utf-8?B?UklBRWg2eDNOVkdKRGRsb0R2SnFXVjZxZitGNisydm9LREpySkgxUlI4dHZK?=
 =?utf-8?B?Kzk5bnJHc2VQK1lGRXpHeWcyeHI0SFh2cjN1OVVWanVNc0ZzZ0VRQ0RUM25L?=
 =?utf-8?B?MHduZEhVWmNoV2RTUCtqM3lmZEdabXRRNEIyd01idHBRRkgrL1RCQ3E2cDdt?=
 =?utf-8?B?NVBNY3dwQUltK1RrZVJ0WnFHczE4ZlRpN01BQ05nWjYrT01ObFhtNTI4R3hM?=
 =?utf-8?B?eThBa09HeWRTSzIrb1VPa1JWQzJFOFhlTGtjdzdNUDd5TzRkNk5tMVk4SUQv?=
 =?utf-8?B?QlhhS05CZEhlcDNTci81QlQyVUsveTZrWm1jd0w3OTY2M0IxOUViN0ZTZUt0?=
 =?utf-8?B?OTZMaTQ0K251dEFTakxhbkRIOFIvczZ6ZGRMcm9MZmJpdDZuZlBDWERTclJq?=
 =?utf-8?B?QVBEVUQvL2FaQjREMUhaMTh6dDNNWlFtZUV6QWhKd3NxZWJrT3dMdmphaTV3?=
 =?utf-8?B?R2x2azBncmx1ZjIyY0JkN0pyZWp3YTF3OXhxUmhqWi93VjFiemxYTUl0S3hp?=
 =?utf-8?B?bkl6enJocXlHZnFFZkM0QXVqVkdyNUM1WVhCZDlzcklLUzhadjR4bE43WFla?=
 =?utf-8?B?WEVZYmQxaHB6aXRLaG8ranBYN2dsT2J5ZG9XWFVKNHFzZUNhb1ZTNVBaUlps?=
 =?utf-8?B?Z2Q2UzFyWEtybXMwU0Y1OUNYaEdnbmU4OG94a1FlUzFZamNRVGppcDlQYUY3?=
 =?utf-8?B?bXpOL3NQMGVsaVhQdU80TVJGcUcxV1d4T3BjY3BLS05uNVplN1FlSlVodHN2?=
 =?utf-8?Q?0aufFVuMNSa1nxG1NwW1FOnYT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a9e3b2-508f-4244-b94e-08dc36a735d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4122.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 08:44:57.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0bc2Y9wgf2rHTS5+lhCsUmPXrM+M5A3pDEDkXpTPLs1qGdNvMRoAuJg55yYj/2PnNLzHsZm02JSR3CpoqlMQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
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

Hi Christian,

On 2/26/2024 1:46 PM, Christian König wrote:
> Am 24.02.24 um 07:38 schrieb Srinivasan Shanmugam:
>> This ensures that the memory mapped by ioremap for adev->rmmio, is
>> properly handled in amdgpu_device_init(). If the function exits early
>> due to an error, the memory is unmapped. If the function completes
>> successfully, the memory remains mapped.
>>
>> Fixes the below:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4337 amdgpu_device_init() 
>> warn: 'adev->rmmio' from ioremap() not released on lines: 
>> 4035,4045,4051,4058,4068,4337
>
> Hui? How do you got that warning?
>
It was caught by smatch & will update the same in the commit message.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1ef892bea488..68bf5e910cb8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4031,8 +4031,10 @@ int amdgpu_device_init(struct amdgpu_device 
>> *adev,
>>        * early on during init and before calling to RREG32.
>>        */
>>       adev->reset_domain = 
>> amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
>> -    if (!adev->reset_domain)
>> +    if (!adev->reset_domain) {
>> +        iounmap(adev->rmmio);
>>           return -ENOMEM;
>> +    }
>
> Please use a goto label and error handling instead. Apart from that 
> looks good to me.

Thanks a lot for all your reviews, highly appreciate it, will send v2 
for this.

Best Wishes,

Srini

>
> Regards,
> Christian.
>
>>         /* detect hw virtualization here */
>>       amdgpu_detect_virtualization(adev);
>> @@ -4042,20 +4044,25 @@ int amdgpu_device_init(struct amdgpu_device 
>> *adev,
>>       r = amdgpu_device_get_job_timeout_settings(adev);
>>       if (r) {
>>           dev_err(adev->dev, "invalid lockup_timeout parameter 
>> syntax\n");
>> +        iounmap(adev->rmmio);
>>           return r;
>>       }
>>         /* early init functions */
>>       r = amdgpu_device_ip_early_init(adev);
>> -    if (r)
>> +    if (r) {
>> +        iounmap(adev->rmmio);
>>           return r;
>> +    }
>>         amdgpu_device_set_mcbp(adev);
>>         /* Get rid of things like offb */
>>       r = 
>> drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, 
>> &amdgpu_kms_driver);
>> -    if (r)
>> +    if (r) {
>> +        iounmap(adev->rmmio);
>>           return r;
>> +    }
>>         /* Enable TMZ based on IP_VERSION */
>>       amdgpu_gmc_tmz_set(adev);
>> @@ -4064,8 +4071,10 @@ int amdgpu_device_init(struct amdgpu_device 
>> *adev,
>>       /* Need to get xgmi info early to decide the reset behavior*/
>>       if (adev->gmc.xgmi.supported) {
>>           r = adev->gfxhub.funcs->get_xgmi_info(adev);
>> -        if (r)
>> +        if (r) {
>> +            iounmap(adev->rmmio);
>>               return r;
>> +        }
>>       }
>>         /* enable PCIE atomic ops */
>> @@ -4334,6 +4343,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   failed:
>>       amdgpu_vf_error_trans_all(adev);
>>   +    iounmap(adev->rmmio);
>>       return r;
>>   }
>
