Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 22:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033396516F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 22:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033396516F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93AA46E2D1;
	Mon,  8 Mar 2021 22:03:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680060.outbound.protection.outlook.com [40.107.68.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FFB6E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 22:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoJDwaxF9OpqOXvf366pnTyE8IMkEPFkERDA1qhDevd5bwfOOdF7BikwVxo60bbxbIDYDoND3KQc6Pd6zlHx504RAjFDF1b1q6UxHoTANfirPGgvTG9QbPZBgGX438VrX19ypqEo88COtA8EUCGWQ83OXshsvSWHfj1r784EAn8Jq553iVsqxGdCSoCHsqJiMEJFd+6MMs66FC3FTDNSVjg8lWreJTstmtNGP/X4zttpxm90Tp9eAE1D4BtaapghNe7yJLzyBYTCrbGZqfmGYBOdBqL4uKfToWFto5f552VThSQhtFoV3bcsnW5IDhmYU4hUMZ8hrbhKr5XVbqrfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QclKyxkNsFRG/OuaE7o3jt4XubR+CMh8wvLcgbl5ZfA=;
 b=T6YLQU5K6Lbzt51ztIGmFi75cFlp2qPYLgKzT3+HNfv04kg6estjkEmHOr9KPNmQ3lob26508UkGHr/w47mXKej8BeOFexEttHmRD9porJAGph2/hCGN/6GDu4Zs5gmUVlSKGUut5+p3Cbh/5TBHKiawY21rZu03+8c0BlDgZLxBk/ySiIfBjTxq8Ki4X4veCQ7t6aSAP06zXrLo0bMi4DTuyloSRYNAsZxkOwrAM98C9y+yLeeXQBDplzoHccdZhK7mj588wXcog2PiapZ3SaEw0lFT2ngtu9lQsqPzxHLMOvKRVCtC4MSM4Xrwogdt3UGJw3phqAenllSYLqFm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QclKyxkNsFRG/OuaE7o3jt4XubR+CMh8wvLcgbl5ZfA=;
 b=hRrVPfZ6Y4BgLBchzHcwTmXans+/SmRCpxrnxCUB3NslFNceGrcvlWjUTWScvniBS3POvH9JIKrKUzrZyEnsFCX54w3anZMjO7II780Z1KjiH6ORfuG3OVc5ZM/CLoFMRhvihtBmb9IWn3IxGhmoK2dqfRSvmR90sSSxhtz0XLI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 22:03:10 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 22:03:10 +0000
Subject: Re: [PATCH v3] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com
References: <20210308123356.243375-1-Jack.Zhang1@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <a64ddb0f-f55c-27a8-1d66-c96f8dbefd29@amd.com>
Date: Mon, 8 Mar 2021 17:03:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210308123356.243375-1-Jack.Zhang1@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:6981:46b4:b72f:daab]
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:6981:46b4:b72f:daab]
 (2607:fea8:3edf:49b0:6981:46b4:b72f:daab) by
 YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Mon, 8 Mar 2021 22:03:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef860919-44ac-4db5-1a50-08d8e27df637
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24804AF0D89A159535774A9AEA939@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olJ5Nh5TVcS7YbtI8jKf3Z5wccpUxOwgcrN8NA+SALbL0giyjrx6TZTHBfP8sernBizp4iAT3mabvjgcmDRxkJfg35sj16euxDrLn+AlTXdijkbkW70pXyiJDRVqzZT5lncQPn0QJKZMQa/7R9ooNRV9CxejIKhIMyC0FJNxOoGOrU3+Tc2dpGPD/xafQCzaTTpPBXF94lxkUxi209OVfEf/HF79Pa2As2JQ2AoU3ZiUdIERnMhnenYI93j+6x3RD6LCG+3J4HgPQ0pYTH89l3eSCwvngzdngoEwLDjcRYl+3h3KxhWN1jzsWHWFNnFQ1Pg9xDLLTFk+vWVdpXxMh1OKmc0wfqRanyc9HbNqZsADQIS8FDz9KAztP2DtAnF9LlcrwBKXV4oy7lxWskBiZhkMKiKLxd0qwnNJavuoOH/gWmYa39/D4FLFNJyVwL8tMV5lrngZ5zOoYsUKsm1OlZFkqJrcValusfjW1E9uQl8y62Y/hv245Axdr94rHFOPxP1U12cO3F2mQeNysmpGIN93HXDpXZhJcji49Iu5lRmiOf1adBkGHKuT2oK0lwbO0E48+wjY5Ml1bR11XYz0lmhWMyglwxkcKAzpGh8Y6gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(44832011)(6486002)(86362001)(478600001)(36756003)(316002)(186003)(5660300002)(31686004)(53546011)(8936002)(31696002)(2616005)(8676002)(66946007)(52116002)(66556008)(66476007)(6636002)(6666004)(2906002)(83380400001)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WHp5eVdBYlVaZVdUaHM3MVZwTWE5TjZydVdQZWwwd2psY3podVVXbVZUeWdK?=
 =?utf-8?B?QmZDSlYzRWUwbjR6VEZhcU9OQVJheFd1TmJuaFIrQ0NuczJ0K3FFaTY4VlVh?=
 =?utf-8?B?Q2hBL0xJZnd5YS9xREpQY0tmSTFsayszYmtjWVBqTC9Zc3QzNWd3Vk9ScXk1?=
 =?utf-8?B?TWsvQWF2STJVU2t5ZElsQjhiaFUyK2puSXBwdGYxYTU5V04zMW8vTFdUOENO?=
 =?utf-8?B?ZTZ2bWVhaUNjL0d0dUpYdWVicTN3ZFBVV01ReWJpK25GdVpSN0pEcnFhZndG?=
 =?utf-8?B?bXFnL0dXSDlqckttcTBVSHcvUC9zMlV0ckh4TU50Q1Fudlg0ZFdId0E3a3F5?=
 =?utf-8?B?L0pqSjgyT3R3MEpJQm1vajMvYmhEeFdTYjIvc2EySFdkMzhWZ1RWcmhGQmp2?=
 =?utf-8?B?TmFlVE5qaXIxbHhSTkd0bzhCTHBiWkV2YTBDMGsrQ0t3NngzYWlFS0RzelpU?=
 =?utf-8?B?VWVXQUdlSStadDZKYW4xRU5Udng4U3doT2ZnaHZlTHlEcU44eE1zcHNQa0Va?=
 =?utf-8?B?RWh5amRhMFhJSFFtYkVxa3hCMUtUdkJDQWxpejVJVDg0TDdOZksrUHRUTGhm?=
 =?utf-8?B?STJlMHBxWHlGcjZ6WjZveDh6aVdjNTRuTFlwci85U04ybWZQQmZQWDEwQ3RY?=
 =?utf-8?B?R05zV0RpOEN5NkZMcUk4bnhoODZmdDJlKzhiS0tqTHRCdTBaNEhRT3l4bVVJ?=
 =?utf-8?B?dHIrZWJ6NE11YkZTMEN5ZmkwTkZWY2dPWjVRME9ob2sxWmdtUGUvOXViOFhy?=
 =?utf-8?B?THJvYWx1K3pacTdCSlN2MTlseUp3MVRIR2ZweGkwQll0NkRXbVY3YTNialB3?=
 =?utf-8?B?Ty9WQ1lyVEk4QjZweHJZb1hsNnJzWnhVbTZKSEc0S2RQTGRkSWMxVEdQako5?=
 =?utf-8?B?VzVFdUtRbHVaMGFlTXNVR1JiV3NZRmc0QmxNa2o0SXdtbWN6Q3h2dS90YVBJ?=
 =?utf-8?B?NmY0dUh3aDI3YWc0MEE3eHVnb1FSQkJlWk5xSzhpNElSQVJZODVFWDRTa1dD?=
 =?utf-8?B?V2krOGlrL2oxdWdQbjdQdFMyU1NCNEt5dHp2V2l0UFpyWmZmV3NrbFZ5NVFU?=
 =?utf-8?B?S1BZbDBjQ2hIeFgwNm01cDMzUUV4ZDRON3N3ajVqQmt5RUVqWXUxYzdJbXQ2?=
 =?utf-8?B?TWIramJ5am15U1U4SVZxQmFtVzlDT2ZMY1ZGZjdNajMzczRBZlRjWFo4NEZs?=
 =?utf-8?B?ZFJsQnZlNVg0ZGhxUzNHNGdyMEhQTVZySTlFZ09hdFpXeVhnTzR2NllNR3No?=
 =?utf-8?B?bXE5cjNZVUR6L3RCQUtvRFVLUE1Ed0NrQjcrbGN1Vm01bm5kaW1LWCtKNjNQ?=
 =?utf-8?B?VTBDd0JyVFB6eW9lVjd5aWxvamFEYnFwOE5LZmxDWkNjNWFKb1FGZUxrR0tD?=
 =?utf-8?B?dEJKc0kxOWlETDJlaUVXVHNTTmFMZUNOQnZ1L2NidFJnN3FlSm5KMzk1blZO?=
 =?utf-8?B?ckJmeXgzUWFnRHF1QldRb1FhWXlTeTJEektKQU5vVWN5aWZlT09zME5NLzQ1?=
 =?utf-8?B?UHQ3aTlSTGpuT3RCUE1CVzRGRDdCYnVIUnEwQkpJd0hIY3M3WC91Mys2QnM0?=
 =?utf-8?B?N1pjUHd2WmhEMHg5YnAxMGpPMmlhNUlITzBkM3hFQWtqY0I3aGxER0JOTERn?=
 =?utf-8?B?bFVMc3pWVTArZFczdnZIUlk4QnJ0TlVhdXdwMlF0S0x5OER2SjVwQVkzMnRz?=
 =?utf-8?B?ZGdCNEx3bnNqMGdreUg2NldLNU9CaklUUTFNVkhhZHlqNGpnaWFtUzRpVE9U?=
 =?utf-8?B?ZXJCczQvQzg5YjV4UDJJUjZaV2xuV3JMQldSOCt0dVQxLzh0YVViY1hqVFIw?=
 =?utf-8?B?UGZZcnVhS1BsbFZ1LzVMYitWYTlvTHBYNE5Xcmovakw1QzF6QnZnTDV6aXZw?=
 =?utf-8?Q?eAAPkOAbFyHKP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef860919-44ac-4db5-1a50-08d8e27df637
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 22:03:10.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Bx1nGL/aDM08Axkl907OUyee8QMUpAASVs1guAlnsbtLtdRrFBL7M1AndrFfp0swzlINIbgqpE1fgdtb2sU0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-08 7:33 a.m., Jack Zhang wrote:
> [Why]
> Previous tdr design treats the first job in job_timeout as the bad job.
> But sometimes a later bad compute job can block a good gfx job and
> cause an unexpected gfx job timeout because gfx and compute ring share
> internal GC HW mutually.
> 
> [How]
> This patch implements an advanced tdr mode.
> 1.It synchronized resubmit wait step to find the real bad job. If the
> job's hw fence get timeout, we decrease the old job's karma, treat
> the new found one as a guilty one,do hw reset to recover hw. After
> that, we conitue the resubmit step to resubmit the left jobs.
> 
> 2. For whole gpu reset(vram lost), do resubmit as the old style.
> 
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 ++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 33 +++++++++++++
>   3 files changed, 88 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..fa53c6c00ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> -
> +	int	tmp_vram_lost_counter;
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
>   	 */
> @@ -4788,6 +4788,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4807,17 +4808,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
> +			int ret = 0;
> +			struct drm_sched_job *s_job = NULL;
>   
>   			if (!ring || !ring->sched.thread)
>   				continue;
>   
>   			/* No point to resubmit jobs if we didn't HW reset*/
> -			if (!tmp_adev->asic_reset_res && !job_signaled)
> +			if (!tmp_adev->asic_reset_res && !job_signaled) {
>   				drm_sched_resubmit_jobs(&ring->sched);
>   
> -			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
> +				if (amdgpu_gpu_recovery == 2 &&
> +					!list_empty(&ring->sched->ring_mirror_list)
> +					&& !(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)
> +					 ) {
> +
> +					s_job = list_first_entry_or_null(&ring->sched->ring_mirror_list, struct drm_sched_job, node);

Seems better to check for NULL here and skip checking for list_empty
above


> +					ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched->timeout);
> +					if (ret == 0) { /* timeout */
> +						/*reset karma to the right job*/
> +						if (job && job != s_job)
> +							amdgpu_sched_decrease_karma(&job->base);
> +						drm_sched_increase_karma(s_job);
> +
> +						/* do hw reset */
> +						if (amdgpu_sriov_vf(adev)) {
> +							amdgpu_virt_fini_data_exchange(adev);
> +							r = amdgpu_device_reset_sriov(adev, false);
> +							if (r)
> +								adev->asic_reset_res = r;
> +						} else {
> +							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
> +							if (r && r == -EAGAIN)
> +								goto retry;
> +
> +						/* add reset counter so that the following resubmitted job could flush vmid */
> +						atomic_inc(&tmp_adev->gpu_reset_counter);
> +
> +						//resubmit again the left jobs
> +						drm_sched_resubmit_jobs(&ring->sched);
> +						}
> +					}
> +				}
> +			}
> +			if (amdgpu_gpu_recovery != 2)
> +				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
> +		}
> +
> +		if (amdgpu_gpu_recovery == 2) {
> +			/* delay sched start until all jobs are submitted for advanced tdr mode */
> +			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +				struct amdgpu_ring *ring = tmp_adev->rings[i];
> +				int ret = 0;
> +
> +				if (!ring || !ring->sched.thread)
> +					continue;
> +
> +				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
> +			}
>   		}
>   
> +
>   		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 759b34799221..3457792b5d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -281,6 +281,39 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>   	}
>   }
>   
> +void amdgpu_sched_decrease_karma(struct drm_sched_job *bad)
> +{
> +	int i;
> +	struct drm_sched_entity *tmp;
> +	struct drm_sched_entity *entity;
> +	struct drm_gpu_scheduler *sched = bad->sched;
> +
> +	/* don't decrease @bad's karma if it's from KERNEL RQ,
> +	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
> +	 * corrupt but keep in mind that kernel jobs always considered good.
> +	 */
> +	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> +		atomic_dec(&bad->karma);
> +		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> +		     i++) {
> +			struct drm_sched_rq *rq = &sched->sched_rq[i];
> +
> +			spin_lock(&rq->lock);
> +			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> +				if (bad->s_fence->scheduled.context ==
> +				    entity->fence_context) {
> +						if (entity->guilty)
> +							atomic_set(entity->guilty, 0);
> +					break;
> +				}
> +			}
> +			spin_unlock(&rq->lock);
> +			if (&entity->list != &rq->entities)
> +				break;
> +		}
> +	}
> +}
> +

This function is practically identical to amdgpu_sched_increase_karma,
probably better to make one function with some flag for the increase/
decrease cases.

Andrey

>   const struct drm_sched_backend_ops amdgpu_sched_ops = {
>   	.dependency = amdgpu_job_dependency,
>   	.run_job = amdgpu_job_run,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
