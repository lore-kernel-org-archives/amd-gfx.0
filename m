Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EEFC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 18:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6F510E217;
	Fri, 28 Jul 2023 18:21:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D931210E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 18:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsV9kHJdqCHQ6JJxIKGUO7bdIzB9CEbPNWPkPORRT7BWuJ8f6BWNKcoPGI/oVxcBlaGw2rzIjvAd8VjldvF6M7F2GOFLGMqEvMKHYAt7S8El5YQ7QibSBJQdYfgUsRof1hy+KtIwX3NnQZEYf+rYlx9TDDcPR8hhF9+0806b/VX4uM6RPX6NmKbyKhkd7XupKHZxwsJn/oS0GAHGlfPRZ8RaXytv3hxiAadjPS81iHDd6gu4LfmFE4zON9q6/LYKxIJUwzFWU3eTOnOUrZ6QaAHYxwxSVfF6d73YRMgUOo+G4PlPW0kyDeZrcKMGvct0zRRBYyaItdWAAOPcISdcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z39qb3+H5hOalZ+bNaFtETgUFsTO5twPZX9VaeGQvqM=;
 b=mRv6AdVak83D6Vy+emG4sUXZnTXJslt052F+cIVBY+Pf7RPEV8ydeSHGgD8o0gPuGaZnhHSDknj70J7A1yAHdwbLp/gjl876NRbQPVebwlF4wKHpFAIX9jcDSnJ57XfxomddewyvElf+CRX5iaA0TOl+mbVqVoJDX0bt5YY5mhQI8FTKusJHt01CLgfflSv+P6YuofdcqmQgcqG3TSxdLDVuyY3erEcljyxXGSXIr+Ui9UFENQpIO2fC0SpHBKFh4OD2hDXnGfEQgTXlPByZgaxetSO7H1+FiyODw6lkBk6TTLV61e2soUP46Y5+fui181HkAsyXQWeZbbTdTFkd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z39qb3+H5hOalZ+bNaFtETgUFsTO5twPZX9VaeGQvqM=;
 b=tokaBCXKORp21XPt0PFzCmcJACoR+6Zrn1u7Zq5OGBqVqDbmwOquOZG0zQAgmDFZMke90axUyCkiIqhkKKeehD70l+my/a0aTAuAwFW3UvNjio7F+brNeFReXGpbyH/HwmdeRc60P+9V7fZngA3vHJEN8hzHml6x7NLTWUssVZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 18:21:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:31 +0000
Message-ID: <b9d86945-e3b4-d84a-556a-43bb2b0ed697@amd.com>
Date: Fri, 28 Jul 2023 14:21:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] drm/amdkfd: disable IOMMUv2 support for KV/CZ
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230728164102.3327956-1-alexander.deucher@amd.com>
 <20230728164102.3327956-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230728164102.3327956-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b242049-54e4-416e-abd1-08db8f9777da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xMCov0xAmi+1bCRMoAKuXogq0NKi54HpWniv17IXB5InAnEa8xRuKqKs6ggJ7THIY5v1q3Og6hKINL5+vk7w8W1727ARhDO0jhANXxLEtXIMY/BUO0T5x12STehxfFNu6fZebng05LVj3iOaMcDowMliHgsjFybJEgacwmpzN4lHdEqm70mLbskK1MrByv5ZcYNuoH267eEn9QTNE7T3xsb/2GIw8d2/CXRaqpxHXe1RDOjaJZiifKNOTtvFID6BOfjGDA9pL6RT2UzLTh/nSUzd7J6ZRYBml/LchMX0T9d8LF+fyAcPIxSeEyRbr4T76NWZDzruV+3uuEhxAznVngXkFEtnH0r+fJivISx5kILx/pyjS+Bm73Y8GDA/scYaYUb0MzsxL+nqWvfaOByIs4uLn6TNSJsjJxSY0zknMgkMSx3wWbROjEjYUvA8L3LTMBj2f2277XjPN1p2a6Gsqog2NFpJ8IJzlff53vn3z0QmiX/lZEfqRAPsWog0f+hqEGYsHXZyKyupR9x+pyAoikJt+CAHvtOHWEPVHmRD21mN6xoBtYXLFiqf+UK2os2QmjoAyc/YazA7Pxk+rWo7LA6vvCeO+ngyltcL37IHSIKMVjGjpRxz5U9eiuqdgdUBJPP2vvD0OlNxgQfC6IPcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(478600001)(6486002)(36916002)(83380400001)(8936002)(6506007)(26005)(53546011)(6512007)(66556008)(38100700002)(66476007)(186003)(2616005)(66946007)(31686004)(44832011)(8676002)(5660300002)(316002)(2906002)(41300700001)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJLbmxUSENYVFphd3E0UktmWkdjNmFSN3Z6YWxxekY5K1d4NTZlUmhRT3lW?=
 =?utf-8?B?N1hMdmNsM01ycHpZYzUxcmlGemZ6ang4MkhiYlJVWHZFcFVKN2ZQaUU5elZS?=
 =?utf-8?B?Y01BRkpNRmMwZGlzSGZaSEpPc3F2d1M4anJYTlhOZ1JlcmpIQktRdnRpRDJP?=
 =?utf-8?B?UWVZRU1Uc1JqWmh0dldhMjVmbzdxekx3ZmpRY1BzZFdXQi9LSUxQSnQvOVMr?=
 =?utf-8?B?NFgwRnB4YmdFQjNSVklOQWZveDV4eUxmdDVtUzN4NHpEcExGNkN1YWtaa0or?=
 =?utf-8?B?TXlJajVsR3M1cG54NjgzSnpDZUlVYVlxMjBHQ1A5Y1pxRmw2Y0F3TXNwanU3?=
 =?utf-8?B?U1BmYmFWa2huTlBsM1luNHh0Y0xFRmkrczZyYjY2bFppMmtCOC8ybVpwd2Zx?=
 =?utf-8?B?SEJKbzBxSHFHdW15b0J3QXJKWDJZK2VUTnE4dGlGa0U3Q0NZbVRRcWRDSDNI?=
 =?utf-8?B?UG9TY2Q2RWwvZEZxY0NpSHl4d21iWW1tbkcvZS9ZMUYwSkd3NWd6ZUxnMmJl?=
 =?utf-8?B?eDJvRjRiVVU5K1hhb2tlY21lN0NTcHY5UTlneU9QcHgxQUJ3aGJWVXV4akM5?=
 =?utf-8?B?bkhKMUdPRS9xdjlkSzRORWRYNld2VTdiZzNmT0dueDZHOXY0RThYUjBNU1ZF?=
 =?utf-8?B?Ym8vQnd5ZWxkV09xNlBwN0dOUlhXd1hXS3lyU3h0TEpxVVZRNHhzeGtJMktv?=
 =?utf-8?B?RzZHb09zUUcwOUR6N203MjcvU3ZBcEVmREJkaWNkTW1nazBQckEyTDJKS3hv?=
 =?utf-8?B?YjZKdmxtOHRCVEk4ZXRueHgrQXovWGVQdGs2NmE2RXZiZnVhOGZ4SFBzbDNl?=
 =?utf-8?B?QXYrL1A3QjJ6NXQrUnQxVUJXZzhZOHp0eC9DVDBFUWc2YkhLQndiT0NKMXpS?=
 =?utf-8?B?Q3lOanJleDJMekowck9IcE1DZWdYbC8rZHFVcHh4OU5xdVJWbTYvUlhoSmow?=
 =?utf-8?B?MUVCSGltWUdxbFFxYTRONzlMM1FQQjdKOFBIL3JwUFF4OHFab0czdjRNNXlP?=
 =?utf-8?B?aWtoYllRZllhd2NqN21sOUFGVm8vOFpvcFFNSXRUTkk4N1F4eUVsdlk5WVNH?=
 =?utf-8?B?YlFSdER5Z0xSa2F6NlJtOTQ4eUozTGVaeXNkODdLekh4dUdia1pNYzB4SDgv?=
 =?utf-8?B?ZEI4NEFVQSthMUNPZVpwRTBZT2FoUGdjRW10WFZXVUdZbWE2a2RVeFExSUVL?=
 =?utf-8?B?bG56MXFXTTNUMXBGelp5Ti9QWER6M0pCaWJtK0Q5QklRbnIrczkySlRHcEUx?=
 =?utf-8?B?TE9WV2JYQkZTaWdaOUkzdHNTVS84SEZQTmlhYWtBeDFVZVgrdkI3SGFQSTd2?=
 =?utf-8?B?bHV5S2tBVHhhdXpEbGRwSFl5QkZhT1FUL0d5aWUySnhrV1pLblh6SG1SK1Vu?=
 =?utf-8?B?N1Jxamdha2JET3M4S3RFOWVqVFZkWU9NaTBsRXBQSE1IbDJ1bGVzNXhmVXRV?=
 =?utf-8?B?VWRXTWNGSy8rY3QzQThhVjRBQVhSRkk5VGVCM0c3dTUwUmVubURlWHAxM0ph?=
 =?utf-8?B?UWd4UXIvaGlQaElZS0R3YnNrNjl3bTdMeWVqR2p5TjREczE4MktXMkk2eEMr?=
 =?utf-8?B?Q2pmYjNKRkFUclp3WmpVakpRNDh0b3gveGtmUVM4dmtiY2dzOWExUFdzeEtk?=
 =?utf-8?B?WFFDOFk2b09lZEN5N2JFZENKNlZ6aTRybm4yVHhET0pOM2o5Q0d4SkxXRFhI?=
 =?utf-8?B?QXJlSmd2am1oYmo3d2s0dVZQZng3UXl5am9yYU1tRUZsajRJaktPWlM1R0h6?=
 =?utf-8?B?ejBKUkFnT3lOaWcwTStuRzZtMXd4dldwMkh4dWs3dlIwUFhCbWN5SWt0VzZ6?=
 =?utf-8?B?Nzc4cklkU3lIRVliR3AvWDJ3ZWJHNlRaalpRNmg1ZDN0RnJJQ1JYQWlZb3RP?=
 =?utf-8?B?YmVDclE0Yll2OUI0YUV0MzNkM0FheFZRRldkaDJzenlwQWdLUldiQTNXOTRQ?=
 =?utf-8?B?bjVUV2lyMkNsK2Y5L0hBZ3FDcnV4MWRsOXdPZTA4TGdNOHJ4N0tJUEZ4dlR6?=
 =?utf-8?B?bjdoWnRLZkJHVDZTR3h2SW4wMU9Zem9nMGF0Z1RhM0dMRmozV0FWT0p0ZHJB?=
 =?utf-8?B?Y2p5VnpFM2hyYXlCdXJ0MFp6QzZrV0t6eTluR3ZnT2xjdjlTQUNMdkdaYjNO?=
 =?utf-8?Q?VOswrl3wp8/nl+716xJ+dwiDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b242049-54e4-416e-abd1-08db8f9777da
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:31.8278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEzeiyFMg6OwPdTELyVCzGxrivtjlDslMLnaQOs52MqXQu/skK/skJBl9ET8+vAG62zUy7M/EnKG+eeAZEjFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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

There are some APU-specific code paths for Kaveri and Carrizo in the 
device queue manager and MQD manager. I think a minimal fix would be to 
change device_queue_manager_init to call 
device_queue_manager_init_cik_hawaii for Kaveri and 
device_queue_manager_init_vi_tonga for Carrizo to use the dGPU code paths.

Then we could probably remove the APU-specific functions and remove the 
_hawaii and _tonga suffixes from the dGPU functions.

Regards,
   Felix


On 2023-07-28 12:41, Alex Deucher wrote:
> Use the dGPU path instead.  There were a lot of platform
> issues with IOMMU in general on these chips due to windows
> not enabling IOMMU at the time.  The dGPU path has been
> used for a long time with newer APUs and works fine.  This
> also paves the way to simplify the driver significantly.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 64772921ea43b..814a6116ca9bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -234,10 +234,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
>   		    asic_type != CHIP_TONGA)
>   			kfd->device_info.supports_cwsr = true;
>   
> -		if (asic_type == CHIP_KAVERI ||
> -		    asic_type == CHIP_CARRIZO)
> -			kfd->device_info.needs_iommu_device = true;
> -
>   		if (asic_type != CHIP_HAWAII && !vf)
>   			kfd->device_info.needs_pci_atomics = true;
>   	}
> @@ -250,7 +246,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   	uint32_t gfx_target_version = 0;
>   
>   	switch (adev->asic_type) {
> -#ifdef KFD_SUPPORT_IOMMU_V2
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   	case CHIP_KAVERI:
>   		gfx_target_version = 70000;
> @@ -263,7 +258,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   		if (!vf)
>   			f2g = &gfx_v8_kfd2kgd;
>   		break;
> -#endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   	case CHIP_HAWAII:
>   		gfx_target_version = 70001;
