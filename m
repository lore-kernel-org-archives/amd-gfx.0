Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E03C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 15:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1E410E29B;
	Wed,  2 Feb 2022 15:43:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E473210E29B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 15:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyC095UNcGhADAgHqMxy9Vq9daxzsSD5IyLCUYG99WTKJmt1ZvH36PV5QMibFhncB6I6gX6TuQDofHqSKs/ez3+QYDScu2mUvbznHsRu+UWG540/HznqEty6vM+7p8yzPZEamJhMm23XHItEX4VRMGm4kp8APnxvpySkrzcbg3fLjVb2nszwAA+IaUyWtshCpyBUxkauPBb7yuE7QL8ZTJX8o1hMTYOrK7QOXzeHmKNsnSk2Q89EncbL3U2U1ol/rOCMh5BywmBJ+wUa0UpQr9t0D6yfac4uCnqD3ItT/ebsxJ2177lOdGu5gCDA9+YYVCyoqZvp87ZW/lYXCMTURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azS25W/1iMif7ln0PoxgsDmlmk9u030IR/9vZ42Oby4=;
 b=hWffTLAzAhH/T4UvJdYdWp1Bf8P+nJuODif2GLZlsPnpmB+eXWpti7FdpNkV3MkINdgIkT58YBlC20cO4b+jeiEzb/Jtcfe+qRdD2QCk7o38RP6ipwin4yreYV13SWoPKD26IfKhMyamTU3jeggkQ7mj0+NhU7jfVx+dK2Al7+a39lBJeArLxeX9YYUElNIxRoMTVAfLuUJEvbmucIBPWueQbSgoUmO6W/pY8GBcUQAwdN8P2fFaD+7nBLLjFHy6+LdDlaI4+glVwjg2/p/8NylEHgvD8jBYmxtFEVc386Vu9WZaDVS1rGuUsmTEQXlzCrhgDQWM6ZX8yZO9An7MXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azS25W/1iMif7ln0PoxgsDmlmk9u030IR/9vZ42Oby4=;
 b=gvU0a8eP420BXdZNf9Bs3zYDcZvp0TjoJdLE/WK4grH503ySTAkMhbC5vZITXk62ZPcav/aKv8hGanzPUVxxdnbpA5Q8OE9bXHOqb5wlGLcGUJ5ejlCeAN2+AeEhgkKb95QMM28Ciu/5SkvWjW1kO11mFpWmerLw0wfDKBfBlWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN8PR12MB3460.namprd12.prod.outlook.com (2603:10b6:408:48::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 15:43:30 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 15:43:30 +0000
Message-ID: <926f9027-3ee7-6f90-b3c5-69022c2fc86c@amd.com>
Date: Wed, 2 Feb 2022 10:43:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Handle the GPU recovery failure in SRIOV
 environment.
Content-Language: en-US
To: Surbhi Kakarya <surbhi.kakarya@amd.com>, amd-gfx@lists.freedesktop.org,
 Bokun.Zhang@amd.com, HaiJun.Chang@amd.com, Monk.Liu@amd.com,
 Alexander.Deucher@amd.com, Kelly.Zytaruk@amd.com
References: <20220201214719.166802-1-surbhi.kakarya@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220201214719.166802-1-surbhi.kakarya@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d630d068-572d-40e9-fd1a-08d9e662c304
X-MS-TrafficTypeDiagnostic: BN8PR12MB3460:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34604425CA56749C14C65838EA279@BN8PR12MB3460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+os7mbEQzhtaJyT6NI96dUG7dBggZ2HcTK1Y2Dpho1MCwsTModYk+2J/P4IgnSWh7c3MkBqREQly9xoUpXbxU2Cq6HpyjvM43bdezMDIk72b0jfp1piZ+hJBkz0HRtRQtQviac+PXDJxYJxsRFm5G8cy7C/MW5ebYV85MIniGXxkrdEwJZuTMAIFv72suhOBAX5Ha4KBAqWPUURoMKV1Z7DKBYmBDOaiE9t80IGpDdvsQ0ofaIF7Uqm+Ndw8XK1sqkyplbHv2ysedxpRGsYq0fV7LzfVMYkuotqrFDY3T4F2Xze6GTJa3n1X7qMB8OfG8jyJBZkRvrFzr1rcwklR32HE0tELHzVEQj84Tn+TK4xw3Viqg5cnRTOfQKiiLkBe3YeUFDUN4Tii261vDhNPjowHpk7YDZZEwlK2uPHAKohn+f2WS2dgPAHzJDv46sBAL6NaiDDSIIG8qjeUCUI4c6v4TRfXayL+bEockiW4BNkPtWoT52lX9GC2HRP7oeexd0b2mhpAIO62j1nO4WICJ2QDy4WiFgIkaY2yl26OPXnfme3weBZWa7BS7sU8clq15WSAZYZemhkh0ZuVL+6TIDTpwApdTViTrlyT1qEBzjQGbUk+pjcdmf5M4691/oxnng3Udz4OSYWLq/nBp3rxcvFb2vNhL0PTpuWCn1FiNe/74I4blwwG0/dzc/ucCFBU18i2qTfskYaehcLtajg+b7pwqGe1nfEDUYFnz1WTxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6486002)(2906002)(83380400001)(38100700002)(8936002)(8676002)(44832011)(186003)(2616005)(6506007)(6512007)(31696002)(36756003)(86362001)(53546011)(66556008)(66476007)(66946007)(316002)(5660300002)(6636002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dJNTlXNFlxU2dqRTdZQWpramNnR0VVNFE4STh6a2tqU3V2NU9GSlV4MnZh?=
 =?utf-8?B?M3l5Uy84cnJWY0ptSEEvSm5rZExGdDlld3lidkNlL0ladmdDTDRJZmllTU1h?=
 =?utf-8?B?YzlGaVFBdEhDa1E5RnFRQ3JRcy9UWStnd1pHeE1zQTZJcVpxVmtXNGErOUUx?=
 =?utf-8?B?VjcySE1yeFplaVRsYmF1aUJDUXZlTmhzcHJQVHJnbkVyOHhUTnkyNkRrR3g2?=
 =?utf-8?B?TXE5ZmZ3Yjc1aWFWeUoyK21SdmlKQVV3ZXZ3R1loOXBwUGUwbjVUSVJzL3Rz?=
 =?utf-8?B?Y0s4SVJZSHNsellqWFNKNEhXWVRKcDhJblY1aktOMzN1eElXRTRQTTBoMTE5?=
 =?utf-8?B?OHA4Y2svajU1dzVaRlN3cDdyaUZWam9QeW5WV0hCeXZ5SmJxTVVQWUJ1M2Nz?=
 =?utf-8?B?NUdhdnROdzM1WWpJdmNYZTdBMmJ4VHE2TFpVeEZ4UnhnYmU3Y2V3ekV5VTd6?=
 =?utf-8?B?NlJ6cndQSnNkMzZsL2Y4MDNvWVh0VjRxZTNpNkdPR2h3VjdiQTBpVVl5QStv?=
 =?utf-8?B?V2RXOTdldmJ4QWI2c2JJdGFCRGpBSWkzcjU0Q05lUkJzSU85V0FNS21HZ1hV?=
 =?utf-8?B?MWh2QXg5NmNXT3RnelRRc2d2Ny9Bb043dHUza2djR2ViQ3MxNmd4US94UUhy?=
 =?utf-8?B?UXdTKzcvK1Z2VmFlRWlKaEhnYnRqVEplV0tqcXphV25qcVpKdEpMc2hVR1Mz?=
 =?utf-8?B?Y3dES0VDckRxYzdjUzJqblViUWtIQk9BZFUwdEF0SHJ5Tkppckg4bEVYZlRr?=
 =?utf-8?B?cmtBTGxUNklGM05mNDBjOFlxeGVYWlhIYSs5SlpTZjU4OVVIUDRIZFRNRVRz?=
 =?utf-8?B?ZU1IL3pjaStPQkQ3N0MwbFpoTUVPSmJZN3NaR0liZVVOVFJVZzcvVkhEaVRE?=
 =?utf-8?B?TGVGRCtXZHNObGQ3NEJycURwR1oyQ0s5UFlFNXpuMnZ6RTFaL0J4S1NjZkZz?=
 =?utf-8?B?ZVpleE1zRnJ2aFBxbytZRWtPNGQ2RUdTYy9aYk9VVzJISnJQcndQNm5kcXE4?=
 =?utf-8?B?dkNVMlI2UzhRWHBFWlhQalRacWJEb21SVERXOS80dHB1M2ZNRkJDcTVZRy8v?=
 =?utf-8?B?b2crZkpYWE5ydzg0MmZRNW9jbTg0RndqWkNKOTFJS2FTZzRUSk9MYzVDdm9w?=
 =?utf-8?B?dE5YVFBSemdya24vQU5rOGZvUVNHSzMrbXltSmFTZzZwNVQrNHdUeVdUcUsv?=
 =?utf-8?B?S1F1QWdGcWdiMlZEQkU4VEN3TUNBYXBUQi81a1p0NHhNUGdFdnZVQ0s1N004?=
 =?utf-8?B?dmIzSmlVNG5VcldkMWQzNzgxdEsvQzNieGF1MEIzNC8wc1h2RVIrK2dNT1dW?=
 =?utf-8?B?WmRSWmZOWmRMa0VNY2c2ZzJDWU5zN0ZiS1pqeDRkREJCWXArWlA1SkZEcElE?=
 =?utf-8?B?OVVLcUFzZDlEazMvbXF0OUEwS015U0pKY0NWYjVhSHkxRDNIZDRzcWMramxI?=
 =?utf-8?B?eEFOczBxZFNQelp1OG0rTGhONSsrZGo1c3pST0tncTZZZE85WnVMcXRsWmN6?=
 =?utf-8?B?RkRaRmdLK3NGV1pXT0RkQ2pPOWNySXJSREZpaG1WVHU1SjlibERiR2YzUTdo?=
 =?utf-8?B?KzVYbU5ZQjlkMzliQmZNcGxjcjhFTHUzZElrM20xQVloSEJUdkl0Zmh1RjVk?=
 =?utf-8?B?T3BSTmJ6a2dudkFBLzR5MkhoYUdoYmFITTJkWEY2L0M4Z0hzM1NiUkZFczRG?=
 =?utf-8?B?S1FJd1V0UjFiVHY5L2dOc1VGcmQwamU2MEU5VFFRWnhoK3dwZDhIZDlZb3N6?=
 =?utf-8?B?cU1IQ1l0T1FHS3diMFlyQWQ4RXlGQWQ2bmxha0dPbktzbE5HRWRJZXBSNkVZ?=
 =?utf-8?B?S0VJTmFnNnhNVUgzbUcrQnF4aXQ4NFQwVFcxM1BsdGRsaTlWNVVVS2x1cXlT?=
 =?utf-8?B?ZXd5c0FWajkwOExiWXc5aElGWmJ1STZza1NtTERPejhYWWJSZ1U4aDdFbElQ?=
 =?utf-8?B?YjYzcENoS2I4TEp6dnlWaHVIMU54L3M0QzZVZnZEYnJTdlhETEY5VHZJWmtK?=
 =?utf-8?B?WldLYkZOZ1owaVJSejJJL3BSUWJRVXBRYVgwVk1abUlqeXNGQzZUUXhaZEJ5?=
 =?utf-8?B?UDZxWWZKUG54Nk9DY2hwTXV1UGl5YUhSMnA3V0MzQ1VOZE5jUVNTd2w3MU81?=
 =?utf-8?B?K0Qxb0k1OVJTV291MmRqMXk5R3d5aHloNFc2cTcyYW8xc0lYOFZ2N2lFbmNz?=
 =?utf-8?B?em9XWlorTXorWXA0dWl6MWV4bXVYTFVjL3kwY0NZbVcxNnFDdUorSjVZcnVD?=
 =?utf-8?Q?UbXV7vqIYipEw0Vziq/3jjQzd00uN3wk0kBdgf9Dsw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d630d068-572d-40e9-fd1a-08d9e662c304
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:43:30.4734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b6RaspEWDQhqWlnvVbKWyhUiCaGg5jnzaadnh44A/D80wO01QNpQhkWNaqE/KMGnSyno5h++rM8XFz4OA1O0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3460
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


On 2022-02-01 16:47, Surbhi Kakarya wrote:
> This patch handles the GPU recovery faliure in sriov environment by
> retrying the reset if the first reset fails. To determine the condition of retry, a
> new function amdgpu_is_retry_sriov_reset() is added which returns true if failure is due
> to ETIMEDOUT, EINVAL or EBUSY, otherwise return false. MAX_RETRY_LIMIT is used to
> limit the retry to 2.
>
> It also handles the return status in Post Asic Reset by updating the return code
> with asic_reset_res and eventually return the return code in amdgpu_job_timedout().
>
> Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
> Change-Id: Ib2e408819b4780e6963e1dc078c3410cd512e6e8
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 ++-
>   2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 53af2623c58f..f50c18cb38c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -89,6 +89,7 @@ MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
>   
>   #define AMDGPU_RESUME_MS		2000
> +#define MAX_RETRY_LIMIT		2
>   
>   const char *amdgpu_asic_name[] = {
>   	"TAHITI",
> @@ -5026,11 +5027,27 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_is_retry_sriov_reset - check if we should retry sriov reset
> + *
> + * Check amdgpu_is_retry_sriov_reset and return status to see if we should retry reset.
> + */
> +static bool amdgpu_is_retry_sriov_reset(int r)
> +{
> +
> +        if(r == -EBUSY || r == -ETIMEDOUT || r == -EINVAL)
> +                return true;
> +        else
> +                return false;
> +
> +}
> +
>   static void amdgpu_device_recheck_guilty_jobs(
>   	struct amdgpu_device *adev, struct list_head *device_list_handle,
>   	struct amdgpu_reset_context *reset_context)
>   {
>   	int i, r = 0;
> +	int retry_limit = 0;
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> @@ -5064,8 +5081,18 @@ static void amdgpu_device_recheck_guilty_jobs(
>   			if (amdgpu_sriov_vf(adev)) {
>   				amdgpu_virt_fini_data_exchange(adev);
>   				r = amdgpu_device_reset_sriov(adev, false);
> -				if (r)
> +				if (r) {
>   					adev->asic_reset_res = r;
> +					if (amdgpu_is_retry_sriov_reset(r)) {
> +						adev->asic_reset_res = 0;
> +						if (retry_limit < MAX_RETRY_LIMIT) {
> +							retry_limit++;
> +							goto retry;
> +						}
> +						else
> +							DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> +					}
> +				}
>   			} else {
>   				clear_bit(AMDGPU_SKIP_HW_RESET,
>   					  &reset_context->flags);
> @@ -5122,6 +5149,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	bool locked = false;
>   	int tmp_vram_lost_counter;
>   	struct amdgpu_reset_context reset_context;
> +	int retry_limit = 0;
>   
>   	memset(&reset_context, 0, sizeof(reset_context));
>   
> @@ -5299,8 +5327,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Host driver will handle XGMI hive reset for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_device_reset_sriov(adev, job ? false : true);
> -		if (r)
> -			adev->asic_reset_res = r;
> +                if (r) {
> +                        adev->asic_reset_res = r;
> +                        if (amdgpu_is_retry_sriov_reset(r)) {
> +				adev->asic_reset_res = 0;
> +				if (retry_limit < MAX_RETRY_LIMIT) {
> +					retry_limit++;
> +					goto retry;
> +				}
> +				else
> +					DRM_ERROR("GPU reset retry is beyond the retry limit\n");


Just same comment as Christian, if you could move this retry handling 
inside amdgpu_device_reset_sriov
so to avoid code duplication here and above. Other then that looks good 
to me.

Andrey


> +                        }
> +                }
>   	} else {
>   		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
>   		if (r && r == -EAGAIN)
> @@ -5341,6 +5379,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
>   		}
>   
> +		if (tmp_adev->asic_reset_res)
> +			r = tmp_adev->asic_reset_res;
> +
>   		tmp_adev->asic_reset_res = 0;
>   
>   		if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e0730ea56a8c..1f0fb21ac15a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -37,6 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_task_info ti;
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
> +	int r = 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
> @@ -63,7 +64,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>   
>   	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> -		amdgpu_device_gpu_recover(ring->adev, job);
> +		r = amdgpu_device_gpu_recover(ring->adev, job);
> +		if (r)
> +			DRM_ERROR("GPU Recovery Failed: %d\n",r);
> +
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
>   		if (amdgpu_sriov_vf(adev))
