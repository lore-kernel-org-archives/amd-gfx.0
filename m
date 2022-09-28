Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC92C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B3810E7DB;
	Wed, 28 Sep 2022 19:09:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90C710E7D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwtUGPzICgcZtuAffAoIx0/m1Ts/Q8ClbLd80c3BAROz5PjZm2PcMsNSMHRzd5lIapnnfu3P4nUIVnKT1CPU+5yysBsp/XLoOEHoq2VhPv7YBk7VKxKRAXwgagCnp5ZJD9XdBF5Yc9Xsd6jP9ivYaXP4EmXFZquf6JjzzFTcSm+Gdlu8JvviZvgPgm4XpdgNmre3xigOdEXnNHf3xrZAWkmYv6pRobLcFHy401BVZOvWPdiy9uUQeAvm8fkgdka000j4LR768ad/F0Us7Wp6jkomOjr7U5uG10s9Bsj5QE4d0BRQ5HtggAtR6MZMJri2DzDyNjtUs9ViYdOiOkKMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDPmjlqYz5hLoFog1sXfwWQ6/h2D0fpbIrsZqOwypOg=;
 b=f7aZi8Naa7C2pL1MheEGlFscbHvJkzpW+vw4St/E8om5MA9VGtQNjG6GBmdiP1v5Sl3olJkxk1VKZKgmaEibtr58GRRT8l1UKgKqG3gfKhWNCmKNaaLkwD7Xp9R8CuKU5X7qn0uwcXLyH0sf2wdhM1tn0zHF7pxnjqBgSDViMrN4lGbZpGMgTFvOUB7sqnLBRrT8827TGTnbEUsEe3frF2RBiSVTUyentIakYI6LpwftDpnOZXCcC0Kn/8QqO5CBXs2huBYv/JhvXqIbNg4Q67WVMKl12MdDHUXOKWxpmnMJJHepQ6xViL+F6TD5vsivZv5RPbd+1mQ1KmJJcatEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDPmjlqYz5hLoFog1sXfwWQ6/h2D0fpbIrsZqOwypOg=;
 b=ypXXBqwIbi0ICP+f2dsiWKCo8B4KoXWHtUWcuD52WKqem64/wlvj+7RF0kFhyX9H9D3Ay0Fc6TnHy1XH5fNmRlCZ7uzWagDbW0PsTwlU2Vr1uboiZ67pJFLUAGTR7Wfh/+SdbolqLEz4blOifUllPE2PykQ+l0uBmzP+/zz8DIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:09:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 19:09:33 +0000
Message-ID: <448773a5-8f42-b085-8a2b-080dad3057f1@amd.com>
Date: Wed, 28 Sep 2022 15:09:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: remove switch from amdgpu_gmc_noretry_set
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928152117.1602358-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220928152117.1602358-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 217d7530-16d9-4a19-176d-08daa184fa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQvsJ9vpahBQeRmNlshY45fJ1xnAdZ4GBP3kOEcF73/OMGVkD9f3SjW8OPS3IvAjq9Xmib2NYV52JD+0bAL+b7C2+k6Ymqi84Cs9eb6VrD0hyfJrZnLVLBoexlEs5phmSMS+4MR0nWuyKrT2oKls59JSwsafLLRztTGbQiWzB9P7D5cH9Q3JBVS0eIadYNhTPnhkk6BPr69OSoG0srFb6VTLQCuQnbf6Pc2AlDam53ocnSMOdV9uPr9iPx8IICAiO5V6M5Z/dYVuO5B2p6f+b7cuA1pS6Z83+fuA0POcFTuuumxNYX1okXYuJ8NFeV++7A8zamQp+8ctVhxjPQOej/GoIgSHTIom6HWfV74FKiCYhHhY+9CYvWf7UPaUCAt5PxClE7RiFgAcS26otDA6x4l+iG0sNs8PBCiknrDOITu4xW7XXNLsDfl3ldbEydVOyt2pqRyW99OzPN88zUJgnDfQaRWF0OhFzuuNnpvlEKrR0lVemozWOa7+p2UgHFbm10BxjnYyeQU/7GL53S2nE1xoRxi7gVWRXT9K+mSOd+QVDVM90rF491bDDB/vSftjD1IrwcwEXTkwzWbyiVDlbqTgIpGZhVU9roudoiNolbxjEMnQcJ07yU6TscsnwmUO2ucdhcng07uxckQ1674o1hv5KTwwRpzoeCyy0TXvNBZ9QmvrgTZTnUxyo+hyY4Dbi+DnZb4Bv5Q8WN4hucS5QKuk3fkSk81sqhSA/t+gEnZrsZ9ZGdUDa8dc0OCcr1HhcQX6UaYt8r/fKzODHK/5vooHGCIj6LMZly3iSEWWsAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(31686004)(478600001)(8936002)(44832011)(2616005)(36756003)(83380400001)(38100700002)(86362001)(31696002)(316002)(5660300002)(41300700001)(26005)(6512007)(6506007)(186003)(6486002)(4326008)(2906002)(66476007)(66556008)(8676002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExnYm93V3I1SzBWczFIZ3JBN1hwNWluL2JtbjhQbFFBWVlITXo4RUZWeTcy?=
 =?utf-8?B?T1U1a0VRamFqK3dZZFpGVmIyaVNNVW8wam1xeEJyWWhGUkd4V2xBZHByYUxs?=
 =?utf-8?B?YWpGL3NQQzJVclMwMTRqUWJNVUl4dE1IZnRUZUxWRGZ4T0tEU05rT0tPTUk0?=
 =?utf-8?B?cUozOVhrdjlnSVBzdUdUeGgwclRJaDI5NVQrMUJSeFJaa2xuL2tvVU5CRWtL?=
 =?utf-8?B?TWVFa2M4K1RzdUQ5N29YUTFHNG45eVVqQ3EvclNqQ204dGk3UEpZR2hQbkFX?=
 =?utf-8?B?aWtsZnhGQXNzNnZjNnpWSndZSUxiLzVZNnBOSWEvSmtKNDQ0YWlQK3BLbTBY?=
 =?utf-8?B?YjdTby9aajhvQko5RlRKaVM5ODV3WUkzbVJ0QmU2ejFaanBDbVArUTkwVDR2?=
 =?utf-8?B?UmZLT2N0dzB4KzVyU0NpNEo0em9HakVEN2doL1lFR2oyQXUvQURmTlA5TFBp?=
 =?utf-8?B?VTlYTXgvcml4aldNV2xhVHdKVS9weGxRaXpPT3hBdWhCTW03VTlyaUROMDlr?=
 =?utf-8?B?eHEwNDZtblkwRWp4M0FrQWFXNEF6NzVmRmh6ZjFVRGo0MStMN0lxZkMwcXNS?=
 =?utf-8?B?TWJTMHg1NDgwWnBBbVp5TzRzdmUrZjFleTN5YUk0Ry9yaXVBekJsL2dCNWxp?=
 =?utf-8?B?dktYdm9iVDNROHBEYTI4RFlwT1NiVEpUZFVtK1ZhQ2ZaSjh6WjdGcXV3S25w?=
 =?utf-8?B?WnEwT0dXbHRwejl6UzZOVGhnbkpuckNRVldMQ3czckN0aE1tS3M2Rk4yWUVX?=
 =?utf-8?B?N1pKdzNsU0FpZ3pMZ1Y3bWNxV1JEcWZiRk9NMG1zdDRCU05aVmpHSG5QYnFr?=
 =?utf-8?B?TXNOWjNmeXpYOUxzS0grQWZvOWZiWHROM0tFeGVaSmFHZDQ0UWdmaHpNV3lI?=
 =?utf-8?B?dGVWbmE0dEc1b1ZKRmIrNEFOSGJrRGwwM2JPejA4UVRTTEVxU3owZEtUUXlS?=
 =?utf-8?B?cDh3M2NrUW5QWWYrbEg4SmRCZm9udWtSSVFXNlE3VFIvU3FTNCtoTnFaaEg5?=
 =?utf-8?B?VHFNTWthVXhQd0t2RzlaWHlSUU5DQWMxbWlWVEhxRzRYZWY1QUVjVWU5RGkw?=
 =?utf-8?B?UTUyNGlPNnRQTTZnUjQ3TStjOUxpUzFwaWFSSlFTdEgwZWhLYjIxNWVqOFlO?=
 =?utf-8?B?SGdWWEVxUk5EaWR1R2VlZ0RsRWtNMmU1QWpYTlBxWjZvUS9uOEhOTjk4bmlz?=
 =?utf-8?B?YXB5eW9BR084NnNaRHcveUw4aHFuK24vZGU0VWRlelYxcEJORlFobzRQQ1FJ?=
 =?utf-8?B?dlUrRUpvMTdIZ1dTOXowTFFYeFJvQlhmUkJhZVJCZTNNS3hhMHhTTWxEV1Zu?=
 =?utf-8?B?QlZmN0dFUnhXRmlQc2p0TmFMWkwrbkZ5SkxXVUk0ZWhYL240dUJ1UGQvc2JF?=
 =?utf-8?B?TEhVSVUrZWlBblA0V1RDRy9ZazE0UHdEQytCVU4yVC84UGNXdTkyUGJHR3Vy?=
 =?utf-8?B?WGJWRXNia2x6V2RNclBPRy9sQVdKb3VHelMrbmh3aUh2cHBqT2RWaGptdTJ1?=
 =?utf-8?B?SkFEYWhtajBld25zVHVJQ1FsVjFoSUJSQ3pvVTd6Z3FvSzhBYjQvT2NWUVpl?=
 =?utf-8?B?cCtXQmJpYkp3bm4rcFZuZG5nKzBWUEs3b0xMOHFqNHZ5MVVTMlNsWTRDQWtL?=
 =?utf-8?B?K1NjOWptMHdiYzViZlMwcnJ6YkhpVlBLS1RBaDdKVUM2WHVRdDNqcWpJdW9a?=
 =?utf-8?B?TGNiSGkrT1MyS3JDNlAydS8zREpZVmtva3FlNGNVaExDTjV1L0x3NHV4alo3?=
 =?utf-8?B?RWxGWkhwNldkOTBac0RDbXhCeGtFTmtmQmhKTVFFRWpYRjJDOFZ3TE9Ob2lJ?=
 =?utf-8?B?MDQyVTZCdGttTm5JZGJBaWxQemU3RmtqMjZicXZBOGVsRWZTSW93eGs3ZE9X?=
 =?utf-8?B?UVNmYzNNU3lPZDZveURUbWdSTWIzdzVEaVVCSzVqdk5xSlpyUkE0WHROTmFG?=
 =?utf-8?B?MmVFNFhEenlTc3FMb25aTEdXY0tzdlEvMzYyYzAwRDhFaHhxeHU2bms4VzJj?=
 =?utf-8?B?NmRVQWxmSUlaOUx5aG9KTTFlZ1JqZHFvODFrZCtzU3haM2VSWUllUEU1ZkMv?=
 =?utf-8?B?VlJFR2dKNkIwZUtWNkNiVVJtbURCL1JvRkZHMDFVdUwwK0paMisyNk1Xenlr?=
 =?utf-8?Q?u94VKC9mmaDAiY3DmI5pdzWUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217d7530-16d9-4a19-176d-08daa184fa02
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:09:32.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBdaFn7aUhwKPq/9DGh+CMg8JbmyfDzUtXOYs7iEbGh8gGdNOasZmPCfP4rBv7nopfzuLY037SF1rcE1x0vQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
Cc: Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-28 um 11:21 schrieb Graham Sider:
> Simplify the logic in amdgpu_gmc_noretry_set by getting rid of the
> switch. Also set noretry=1 as default for GFX 10.3.0 and greater since
> retry faults are not supported.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 +++++--------------------
>   1 file changed, 9 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index aebc384531ac..34233a74248c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -572,45 +572,15 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>   void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_gmc *gmc = &adev->gmc;
> -
> -	switch (adev->ip_versions[GC_HWIP][0]) {
> -	case IP_VERSION(9, 0, 1):
> -	case IP_VERSION(9, 3, 0):
> -	case IP_VERSION(9, 4, 0):
> -	case IP_VERSION(9, 4, 1):
> -	case IP_VERSION(9, 4, 2):
> -	case IP_VERSION(10, 3, 3):
> -	case IP_VERSION(10, 3, 4):
> -	case IP_VERSION(10, 3, 5):
> -	case IP_VERSION(10, 3, 6):
> -	case IP_VERSION(10, 3, 7):
> -		/*
> -		 * noretry = 0 will cause kfd page fault tests fail
> -		 * for some ASICs, so set default to 1 for these ASICs.
> -		 */
> -		if (amdgpu_noretry == -1)
> -			gmc->noretry = 1;
> -		else
> -			gmc->noretry = amdgpu_noretry;
> -		break;
> -	default:
> -		/* Raven currently has issues with noretry
> -		 * regardless of what we decide for other
> -		 * asics, we should leave raven with
> -		 * noretry = 0 until we root cause the
> -		 * issues.
> -		 *
> -		 * default this to 0 for now, but we may want
> -		 * to change this in the future for certain
> -		 * GPUs as it can increase performance in
> -		 * certain cases.
> -		 */
> -		if (amdgpu_noretry == -1)
> -			gmc->noretry = 0;
> -		else
> -			gmc->noretry = amdgpu_noretry;
> -		break;
> -	}
> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
> +	bool noretry_default = (gc_ver == IP_VERSION(9, 0, 1) ||
> +				gc_ver == IP_VERSION(9, 3, 0) ||
> +				gc_ver == IP_VERSION(9, 4, 0) ||
> +				gc_ver == IP_VERSION(9, 4, 1) ||
> +				gc_ver == IP_VERSION(9, 4, 2) ||
> +				gc_ver >= IP_VERSION(10, 3, 0));
> +
> +	gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
>   }
>   
>   void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
