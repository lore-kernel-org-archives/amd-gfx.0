Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9600BC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 17:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4D211B198;
	Mon,  6 Jun 2022 17:18:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669D111B198
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 17:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdeUX9yp6Qaw9HqrJigYPgX8ouaeszQgw97O3T83522N6btlID6hsCt379mKoeJ3jn+E54WN3HIMrUOnZ3jInS18ih8GVgBqBknDargWv7J3VbOSK8h1QNPd/xOfVLckCmACcZwNSNvO1XtumjEGAqHwnwCRz9xFbSpR7+SOdrWx0GMsTvHA3wFLdQzmMqp+WzljwDrATyJ0s1h0WXAtZLx1Z3gOcUhtR1md/r1Zy9iXjC3vPq+QCIzQmPV5+vCbhpLjLEihiL+6Qnol8IHKGUsrpSLxEWtfl0C/QgmB6b1tHNhF/AsKK8zkV/v635Yb9UDrMSHNUjuN3g5qD/ZbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwHUPPOsIkgf8Nh0lPxWwtrg0pcJ5TFIs4W4P9HgnNM=;
 b=e8pI2XvuNGWfWMNo3d3FTn1RSZypzB3krEZgvx7xkYFaNmkSEiBjQRYAeQdrZuyc/WEO5XSIJVwqD8MtrXbUsRwMhHyFIFgURwr26Nm3bZwaz2fSSC/YZ9dhos7yBLNXsUPfIazMm+0pmFXUwHewvBie3u4asHv1n4TvWCB+x+Y0854lfhIdj+HkP0co57P6N5fQDnuRcj/Sz2LXa9NEgGfUMZKX6Dh2gHJqInIgdjolBtOLzaGKDHVvNhgctEN0ySn6VVGE3tqxO2PtD9z+JaQzOLXTRGVWtaRSh9LPTucYRzgBGkHlx4URWJzKjyAg7D+Dkwxd7wLs5YUbRRF5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwHUPPOsIkgf8Nh0lPxWwtrg0pcJ5TFIs4W4P9HgnNM=;
 b=rmNC73IemRojmuwPjcdNeuYuuzvAXGi/2I55i7p0bKP9WQgBgQyC77PdVPMS3WbDO5NUmKcMIJ/gjG0VWK6KaCqfJIJmyhFKvfHmmfcorJnRLJZ/bTAC4gH2uG00zmJqObdY7MujPSmeIj2Q2qcJSxznFNWfKKQWHOCo9PfCV7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 17:18:15 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 17:18:15 +0000
Message-ID: <731b7ff1-3cc9-e314-df2a-7c51b76d4db0@amd.com>
Date: Mon, 6 Jun 2022 13:18:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: fix refcount underflow in device reset
Content-Language: en-US
To: Yiqing Yao <yiqing.yao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606074352.1326835-1-yiqing.yao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220606074352.1326835-1-yiqing.yao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e4fd6c-d3eb-44e0-b251-08da47e08a7a
X-MS-TrafficTypeDiagnostic: MN0PR12MB5881:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5881F21DE14475B57FCEED26EAA29@MN0PR12MB5881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+6D2zTuxEOxACit2yELNQ6/Z/0h0jdD4hzu/wwf0VJieLCrfI0MSqoJis8aPtdmeYW3OWzL5jJBf5MtTAcTp1/tvtK+iZfgkCMOPp6j/R0Ykx8fF6t5HOqZ06WFscAiGPTKMBeeCMpGYVBdBBA5elcpU5ZG6awEePJ/s62cFUFOTjpNVvD9NmtPAJQJ6O0MNjwrViRCqAfc/Wcc7XjEYCLEoAmYLWZnLWfTQjMfdDkEfijUGJ1ZHaTxcYz6daNXGv5mCrLh73wqjBNxLyZH6mhBRClgqFiWVrXSxe/ED/yVg1irq/WMlMsaD6bPZufrhX9emwOTP139c4J8FGhwAnzDBhaVYkryH4RXPuriJtrbtVNUctQzLa9FNqmeY2Ho7xDWymlfdnjHKhwfsW8wn2HhQcBlbVoww+R1bgnlv230lPRGApxIz1/pXDigymWiZWoYvXiz5zcBUVRyR+FDOn/2QJFzcv5AtH+0i/89a+Vl8gC4C+LtNx+Q66/p//NrL8gKo2SCZtes+uazzpl5wH0sZ+r5RtfEVdxzwxqMflVnL2mrWKTPDjD/JLTvySHiH/l0DC3niQASI/yy9jvo5OWUQk0qWbG7Us1TXO5XWlWiYyLV4CBjPHBpcZ6caijj/By6qaS5996BojsPorfN+ty6nOrl4kldST8er1JcP9EDl8Y7RheRMDbGDCb71n8vQFXO9/TuKJGFIMmigpdb9mSerg5QiJWG75yGLQD/n0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(186003)(6512007)(31696002)(8676002)(2906002)(86362001)(2616005)(316002)(6486002)(31686004)(83380400001)(8936002)(44832011)(36756003)(508600001)(5660300002)(38100700002)(6506007)(66946007)(53546011)(66476007)(66556008)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3JqcFpocm90akp2L3NoRlNxVkRLTmV3c216V0xmd3Ivd1JPWi9rbmxjVk9Z?=
 =?utf-8?B?dTFpNGZmNit3UHdDdTV4OEMzZ0ZBOUg0Vlp3Wmt0N0R4MHlUSFlwK3VackdX?=
 =?utf-8?B?R0pZRThHeFRaYkRTMW1BVXpEc2hkTVNHL2duc2NPNXZXSktudmppVTJIVlU2?=
 =?utf-8?B?VVJITVlFZGFhWmpESGNPekNEbnd3WWtxR2FDTUZBekxNdEdrTmRGOWdHTko3?=
 =?utf-8?B?d29KalB1dDNXUHNIeHhaekNuSnkxQUtMNE5Wb21WbXEyWjJGQk5McW43WFR3?=
 =?utf-8?B?NWtDTFlISm9oRjhFcVc1bGUra3lmODF6cldKMWNTNTBjUzdORjZRdUZzWVdD?=
 =?utf-8?B?ZFJPUmsveDI0bDJSaTdyK0dLUXk0TW84K1ZrLzJ1a3grOW9pMEtJS2E0bDdH?=
 =?utf-8?B?Sm5NODBOV3NHcnR3WVdMeU15dFlCTmxpeHV2dlA4Y1hxT2ladTlYKzRjblJi?=
 =?utf-8?B?cVJheTdmN1VFSFFkdXR0Wkt2TU04RHAyeVIvUWxJY05iLzE2Vm8xZkNqSWhP?=
 =?utf-8?B?eFhxa241Z3lNdlEyOWgzaXoxamdaNFpuNlBZMDM1SThtY1REemdMRUdWM2VQ?=
 =?utf-8?B?ck9RNSsydFJoN29NTlpQK1BKb2VkNk8rZm9UamxuNnM2dmtqMXAwUkZ2bEE5?=
 =?utf-8?B?bUJ1YlpYM3lrdzJyRFdQc29LU3dhcWFhQ3FJKzFUdWxqcVNqTThCYWNwTjhh?=
 =?utf-8?B?ZFRBV0ZQcktXSE5uaGxncVBKdW5OdnJSWWlyYklLTFFtV014U3NvcFZTR0xB?=
 =?utf-8?B?OVlDZm9YNmZLZlNaeUU2akhZQzRxMjhFeFBnaDBRRm1GN3B1b3pMMGpMU1VI?=
 =?utf-8?B?LzhBRzZXeHN1ZDdQOHU4SlJ5WWRlWlZPV3JobkZqUnIrci93RmlhWUtTUWpa?=
 =?utf-8?B?VWxFRVVIU2MwZ3NGNWxKb29tLytCTllDb1lsbDVtR3VSWGd3bnBkTysyM1Q1?=
 =?utf-8?B?VjY3SzFpdDdtaC9WYTFPQTQrYVdFLzlQM0R3WC9iUHZvUjU3NXZjb1hwdDY4?=
 =?utf-8?B?QUlXakcxSHc0M3VxVnhHWnEwQXUrT3RnVEg0Mm1pUkQ1Z2xFSzJGVlpXTWJX?=
 =?utf-8?B?V05WNVV1V3d5NUZ0T3FTbG1KZVV5QW9EL0VYYmZ1ZFBRZGY0OVk4a1BTcTBu?=
 =?utf-8?B?L0JuVUVVaDBBVG5lSlFQd1ZBSVhWZTl6aVVqTHJacTA5ZFhnZEQ0NDd0RmNZ?=
 =?utf-8?B?a0Y1VUMvUkpneTdGT1ppSWNLdVRMOG85dXQ5OVh3RDNMVWt3aHdOWGtUd3Y2?=
 =?utf-8?B?SWd5OGFnTVozVDUrWnB2ViszRVNRSWJFMVI1cXRsMGRRZTdYR1B3ZXpPbE82?=
 =?utf-8?B?UHdXeFFEYThOb2pHRjViMGVUb0o4c1BFNE15NVFNSG5iN0tyNmU2NXI2WEdF?=
 =?utf-8?B?U3R4Z2FzWmtYOXVHVmhHU0J3MkVWZzdnVFdkRXpuV0tlK3BLeXk2bGtSZVlC?=
 =?utf-8?B?bjVGa3JsNEs1ZFhJR3huUXVrR0NvWVhua1J1MkFXaVV3aEtsTlN0TElIcTk4?=
 =?utf-8?B?eVVTY1hjWFpMUVVQR2QveXJGV0thM2N0OXA1MzF1ZXA3czZMSWIzclVxQjhU?=
 =?utf-8?B?L1A1TWVJL2xVYzc2MXRiWWYzTS9yRVV2RWRKcEs5NXlaOGVlZ0orRGZkM3dH?=
 =?utf-8?B?ZENJa2JpeGVDSTFmeXIxTnVVeTNqNWZ3UjRqNTVjc2NzcDh1NmpYdmM1SVVF?=
 =?utf-8?B?N0pUeXAzUS9RblZPdlI5L2lSbmtiTjB2U3FwNldLbHBVM3I0WFgwWFFJWUdw?=
 =?utf-8?B?UWtCTjJNQUJBMndDTXZ5YUEzdHZNcEtRRWNBc2w5UEJ3TWZZZWtvTDBkZksx?=
 =?utf-8?B?MWgxN2tqYnYxWWJNZS9pekN4UEVtazdyaWlOTU8xR2NscElZVWlHcjhXUlgy?=
 =?utf-8?B?Z2pWTWYrTitEWGV0V1kvVE9XS2NjQ1djT25KcllNUmxXVDZZQTczTXdVbGk3?=
 =?utf-8?B?cExSSXVtZXFlZTJlbjlOUHROQkJubGQyVGdFQlduU2tETzBqM095MDhWVEN1?=
 =?utf-8?B?bWNRRmZQM0EyOTRIZ0lLbkxpN3k0clVSOEFqclgvR0lvdHlCay9aZGF0b0Jq?=
 =?utf-8?B?bEZtbUdwTUlqSDRVbXVzQW1ncUFlMjNkUS8xSDV2c3g2WEZDcFdKWXhsdEdE?=
 =?utf-8?B?Y1o4eFI5eHptVkpDblV5MUEzR3o4WU4vaExwSEdKYWdFcVc2aFEvQWlwVi9M?=
 =?utf-8?B?cmFuWXJmRWp5V0NSdUF6K0VBdXpIRlNqV2k4dEdnbkhQNllXZ3Eyd2lGU3hH?=
 =?utf-8?B?UldlaUY4NjF6V0pYOEZiMHFRQlJPT0ZzQmg4czd2TVhSbW5wNUlnbW8xN3hP?=
 =?utf-8?B?YnVJRzhSb0JBZU9aTllRZStoMXF3eHQwUkhrRk8rbTFlSFhCSG10TVV0Zy9E?=
 =?utf-8?Q?4KksOylU0wwmCkuuUMS35AGLFK3rpejoGnWs4vrAzL0yd?=
X-MS-Exchange-AntiSpam-MessageData-1: gyaXIXbTNNswCg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e4fd6c-d3eb-44e0-b251-08da47e08a7a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 17:18:14.9452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYP7k/cj/CDxv4uQctKjzU7Yw7hCLQ3Xx05jUmqZC0naxSoOtE1X8UKU/UcM1DJ05Vkan5OeXDvxNdBVZbR5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
Cc: jingwen.chen2@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-06-06 03:43, Yiqing Yao wrote:
> [why]
> A gfx job may be processed but not finished when reset begin from
> compute job timeout. drm_sched_resubmit_jobs_ext in sched_main
> assume submitted job unsignaled and always put parent fence.
> Resubmission for that job cause underflow. This fix is done in
> device reset to avoid changing drm sched_main.


Are we talking about amdgpu_fence_process sneaking in here just before 
you call
drm_sched_resubmit_jobs_ext->dma_fence_put(parent) and doing extra put ?


How about first remove the fence in question from &drv->fences like
it's done in


>
> [how]
> Check if the job to submit has signaled and avoid submission if
> signaled in device reset for both advanced TDR and normal job
> resume.


If what i said above is the problem then this is a racy solution no ?
The fence can signal right after your check anyway.

How about first removing this fence from  drv->fences array and only then
checking if it's signaled or not. If signaled you can just skip 
resubmission and
otherwise you can go ahead and call resubmit and not worry about double 
put.

Andrey


>
> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++----------
>   1 file changed, 41 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f16f105a737b..29b307af97eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4980,39 +4980,43 @@ static void amdgpu_device_recheck_guilty_jobs(
>   		/* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>   		 * to make sure fence is balanced */
>   		dma_fence_get(s_job->s_fence->parent);
> -		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>   
> -		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> -		if (ret == 0) { /* timeout */
> -			DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
> -						ring->sched.name, s_job->id);
> +		/* avoid submission for signaled hw fence */
> +		if(!dma_fence_is_signaled(s_job->s_fence->parent)){
>   
> -			/* set guilty */
> -			drm_sched_increase_karma(s_job);
> +			drm_sched_resubmit_jobs_ext(&ring->sched, 1);
> +
> +			ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> +			if (ret == 0) { /* timeout */
> +				DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
> +							ring->sched.name, s_job->id);
> +
> +				/* set guilty */
> +				drm_sched_increase_karma(s_job);
>   retry:
> -			/* do hw reset */
> -			if (amdgpu_sriov_vf(adev)) {
> -				amdgpu_virt_fini_data_exchange(adev);
> -				r = amdgpu_device_reset_sriov(adev, false);
> -				if (r)
> -					adev->asic_reset_res = r;
> -			} else {
> -				clear_bit(AMDGPU_SKIP_HW_RESET,
> -					  &reset_context->flags);
> -				r = amdgpu_do_asic_reset(device_list_handle,
> -							 reset_context);
> -				if (r && r == -EAGAIN)
> -					goto retry;
> -			}
> +				/* do hw reset */
> +				if (amdgpu_sriov_vf(adev)) {
> +					amdgpu_virt_fini_data_exchange(adev);
> +					r = amdgpu_device_reset_sriov(adev, false);
> +					if (r)
> +						adev->asic_reset_res = r;
> +				} else {
> +					clear_bit(AMDGPU_SKIP_HW_RESET,
> +						&reset_context->flags);
> +					r = amdgpu_do_asic_reset(device_list_handle,
> +								reset_context);
> +					if (r && r == -EAGAIN)
> +						goto retry;
> +				}
>   
> -			/*
> -			 * add reset counter so that the following
> -			 * resubmitted job could flush vmid
> -			 */
> -			atomic_inc(&adev->gpu_reset_counter);
> -			continue;
> +				/*
> +				* add reset counter so that the following
> +				* resubmitted job could flush vmid
> +				*/
> +				atomic_inc(&adev->gpu_reset_counter);
> +				continue;
> +			}
>   		}
> -
>   		/* got the hw fence, signal finished fence */
>   		atomic_dec(ring->sched.score);
>   		dma_fence_put(s_job->s_fence->parent);
> @@ -5221,13 +5225,19 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
> -
> +			struct drm_sched_job *s_job;
>   			if (!ring || !ring->sched.thread)
>   				continue;
>   
> +			s_job = list_first_entry_or_null(&ring->sched.pending_list,
> +				struct drm_sched_job, list);
> +
> +			if(s_job){
>   			/* No point to resubmit jobs if we didn't HW reset*/
> -			if (!tmp_adev->asic_reset_res && !job_signaled)
> -				drm_sched_resubmit_jobs(&ring->sched);
> +				if (!tmp_adev->asic_reset_res && !job_signaled
> +					&& !dma_fence_is_signaled(s_job->s_fence->parent))
> +					drm_sched_resubmit_jobs(&ring->sched);
> +			}
>   
>   			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>   		}
