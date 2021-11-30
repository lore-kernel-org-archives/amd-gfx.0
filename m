Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82480C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 06:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E140F6EAE2;
	Tue, 30 Nov 2021 06:19:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9326EAE2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 06:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJnRwJbBC6U3fsPLZXyNInRBAovutvgPNFq07xu8H2au2lXcWJ8Nd+5anME09+LqUoT2xDKwr7bidQ2k++iVSC23oV6//CNScLqbTH2dwT4BAXTM1CDsuYTPJ6xXghBSvHo7nyhZeFwLTLO4oV70Z7N1w8K0kjeSmzCp1NfYcJRkRM68Sxee8vOMQkPYE6WbPfR1ar5W+4KY5k+spl9AjorACsKDjr+AYFtOGuiuz4PwDggSLh+oDcFdVP1LHLXdAcbnKYXvhbxa4w9X5k+YREVlkzJshtKnfv5Gh5ldbFkxBppmoMwvkQp0HKUIyDXPdZzRasj8ks5Pg9fvTLiLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rt1Srdw9ercu+A/o+J5KG7BaypdAAgXFz6zbljMvLw=;
 b=EHPaAnk1VJbmHY/skF3zry7nYTbL/QJWW8bdyuRnV/95x6mfB9mNH3jGYZKOWFfczAvbG11ByxDG/HuiNlYGK1+RZ+aINFFujnFQdu0dxiXFglYE6S3iK+BED98slUgRWDohX4+t9JgdXUtzf1Tyx5qeNzoBe/8pvAFH9tmCcnQatKMDzel2ByF0CUuvzOvNakYWEoIFlKSXZa50lSp6s0JhY5T8EBOWihmraYNT2KYtk94WDT8sDiV7vxzfFKJ7hjQVjeAXgl9AzG+kkkLvmnitehquSCD0sq54KLeJnAhIJ6Fr2wzTYdKHk2DE6S8ttzoA3/0iAA1hvb9hg0PoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rt1Srdw9ercu+A/o+J5KG7BaypdAAgXFz6zbljMvLw=;
 b=lV4ZEidKBmRblhMA496Wf6XHDJjH2oyMkfTkmSWQemazeQRY6DfRo+Y9aozRaOKMUjC8crZp8+ga9PP+HN3iDDBJ+npOU81lPEYC/LwuJ6ld9jUFujBorZWwS6KYIDRSkfQkB1/uuAhy4uO7xxaOc2GA1LC2Crxewh8yGsxNFsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 06:19:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:19:18 +0000
Subject: Re: [PATCH] drm/amdgpu: adjust the kfd reset sequence in reset sriov
 function
To: amd-gfx@lists.freedesktop.org, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
References: <20211130024002.12492-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <de193754-887b-50fd-3a4f-452796272854@amd.com>
Date: Tue, 30 Nov 2021 01:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211130024002.12492-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 06:19:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82905a9a-936c-40b8-039e-08d9b3c956bf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5337BE21AE0F9A86D1620E2A92679@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3AxlxKXu7zqIcyikYKO7sj+FXtG5CoxY9ZswXoyvhffV3MoHQGZfRac7wmRTbyYaVXA4IE+S/PJ7pavjAdhRn2UcqGd9Op6LxOsbRByZUncAJvQjnOC5pr7ANcn0cUSGLAZ/Ja45xUhqZp0bURmxYPFNJJwyjD2dMcRI2sk+sR/f1sfuH0ddhNYIrd4yZj+j0sclpwH75AnxriHorIePm7FJhAByHwShKTKIZgIMSsBMI0pSVXFEebz6VlbqxZshIWYB9XJ4Y7tgKRz4ISvvfnKdi9t8d+9uwyBjCi+i94tP63mqWDUVctYuEb50WdiCfTjhXo1Wlt7uBeNG45MARwCGzWe3W/Kp2peeLRrDliHM9fLDoNHLHz3xgc0XJgv6l8XyOYnoRokEIPDsfnb+SN55dIiix+crdtX6p7L13NzV5PuLRzxSULySR4576LWEdsm2ajHdCjsBe7VhetVuSd3jBHS1k672h0sg2HU/kEF7iZwWB18SaI2/tDL3lDRoXgbcfrR/SECjjbqRvQB3lqI42tCfW/LRYeV+62a41hDW6zu9uHAs4Q97ZHyML4HYSFtSy8QKu/xF1hvyEl4U2dC9HG1jikY9zxNR0oDdQg4iaIP7hFFiPzkFJJydM30c2xJaK1eTjLTosSEIBbAW5cNz0KaWgnv25mFXIxvF3Q/UWyk1I8sAIurII8SZa+26VeLgk2W5tGMx1Dql11j4da2ldhavt7Y5p95xGmUdH4ULtpayeq4bhXSmUX8/oUs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(2906002)(8936002)(38100700002)(16576012)(8676002)(66476007)(66946007)(6862004)(26005)(83380400001)(4001150100001)(31696002)(508600001)(186003)(6636002)(2616005)(956004)(5660300002)(36756003)(37006003)(44832011)(86362001)(6486002)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlPUzBlbVhqZk5ZQzQ2TW5lYkJrQUxPdTE0MnkyYnZWTUl4NmZPQlVLTS9z?=
 =?utf-8?B?d0V5MUxhRDhnTGNJdmM1RGNNTWhGOGhUczJTODRuV2FobVJSbC9qRkNnR1ow?=
 =?utf-8?B?NW1zQ2UrdHhjdlh0TG1UaUtZeUdmbSszUzdnemRlTVJNVEtjbytrcE1VRHMz?=
 =?utf-8?B?L29GNWU4c0F1Mk0wLytrNFNvR0ZLcG9ZOHVqTWx5R2VwOGR1b3dLTU5QeXFD?=
 =?utf-8?B?UGVURU56eXJuS2JnY1NMNlRFSldnUFdpS0MxNEsvaTRaMFBQRFJBU1hnYlpi?=
 =?utf-8?B?cFdQT2RRU1IzWUZIaUt0Mm1wdDl6bVNqaTgzdFRrdzh2amhBVGV1M2lHNVBB?=
 =?utf-8?B?aFowRVRDR0RjZFoxQUdMUFczc2FZVUc1WUgwL21MQTB0dmkvTDY1TDlEb3Ry?=
 =?utf-8?B?VHN2c1YxM2hKbzBDdGZzRUQ2Sng5SllPUXFOc0h2RHZPQ3ZtYVhMOStaRWlh?=
 =?utf-8?B?VVViWjlSd2E2U3BSQ2M3OGdVQmpYZFNDY1hXVWlaYzdnRm1ZQmFjNU9oVW1r?=
 =?utf-8?B?cHY0c1VmUkEvbzdDYmlJbUZnSzVKaTIvdFhneDVLVmRDM0dEcGhlZjM1SmVR?=
 =?utf-8?B?RHp3c2xxRlhZQ3BSZitDU01VT2Q2ZEw4MGxyeTQ3MEdobWg1dk9iczZLTk81?=
 =?utf-8?B?Z0hacW9JMUJYYlN3QzgzTXRNMlplWGdpQVJzLzRGbndmZWJuQzZsSjdyaU9I?=
 =?utf-8?B?RFJtY3RLOEZ1MjJ2WitaRHJwbTZvaElVNWJ0UUlPWCtkVi8vTlM5R2d5RTV0?=
 =?utf-8?B?Nm5YZjJhZ0RPNytUNVJPd0hOaUpLVUZtWVhHaGRqYjdEbkhZdzNxWkZ2OGhN?=
 =?utf-8?B?cGsvUGVLN1RMVHB2YzZCMzJuMXZqTEJDdDBua2tUZ1hLa0psZ29WdGRIbk91?=
 =?utf-8?B?bUpLU1JzWk1SZ3Y2L1JMQWRpRng3dHA4UjQzK1J6MDZjVldpUktmYkJoOXZr?=
 =?utf-8?B?UTBERFFxcXd6djU2Wm42bEtWTFFhOXJxWktxNEFwNzJMVjNLL0FXemZVRWRi?=
 =?utf-8?B?Nlc2NjdOMHZUNldRQlFRMW9iN1orakNEVWkxalpzd1RiY1RiNUFIbzJMTnpt?=
 =?utf-8?B?MVlDRFdkWU9TemowMldqRURTYmxMRGxmRGlIMWJaUXIxQ0duWHNEb3llOXda?=
 =?utf-8?B?Z3VCcmZYTDNwbXN3RXlOcDdOVThMVld2RlU5bGcxYVh1YWdFYXdLWWNZOXVZ?=
 =?utf-8?B?QlAvNjZoSkJ4RGlYRFJib0xPc1d4UmV2R2g0VHZIdUxRQVl4UDdIZy93R1lt?=
 =?utf-8?B?dU1ZS0lacFlXWGNqYWpmYytOTWM1NVErcStuZnBLL3hEckYxbkZRWjc4RWh5?=
 =?utf-8?B?aVpsSEJEaEtvSHJPYWFTQ1E3VnppUlBWMDRtVzRkMDZwRFdwaGRwL1lwdTRI?=
 =?utf-8?B?VmVWcDYrT2RjL1k5enhocGhsaWk0MVozM21ybFpFbWx1TERXKzZBZEVtd0pX?=
 =?utf-8?B?ZE9ZL0g3RlhnWDY3aGxyZ1ZqbUFrTkFPM1VocWFEb1NlaHNhQSsvZzRBTXoy?=
 =?utf-8?B?MS9HSFZNZTlGU0xaR0FwNEFrOVgrMXlpTmp4MHlTVkdUNUZaSHJERVhGUHZ2?=
 =?utf-8?B?ckRtYmxnRXVSaWZaRFAxQSttTjBVRy84Z2h2bGVuWVQ1U3NUejJvNWxwTWtK?=
 =?utf-8?B?Yi9GaVQxQVZTdGwrVW81QTFKTmZDVzdGZGhSQ29nQmNZbnZuTUx4Ymo1TXYv?=
 =?utf-8?B?VlZ4a1Z0OFhrQ2xpd0tsK2JUd0xtZXUvQjRhTXVocFlpMkpUVVdhbmRkL3VE?=
 =?utf-8?B?NE8zNElXYk1sVGxFUHJWVW5OR2pUbzJQOVErVnhaN0N4UnJiWDRLVmNrZ24x?=
 =?utf-8?B?VUtwZ3J2SGxwSzdxcVJ3YXN0ZEpWd09HaSttM2lxMWNKeHRBTnpNTFhHb1hy?=
 =?utf-8?B?MSs2ZW8rWkl6R2lQRTRtaTBnS0ZDNlNLRkloZ1JsK2JHTlVWZWpsbSt5MzVh?=
 =?utf-8?B?YTVXcHplb05RdStQTzVYK0xHS2JiZUJjQlpGdGtZenpSeFJHUWZ0U1lCcEFP?=
 =?utf-8?B?NGYxOG14ZkZUYWg4cUtCd2R3ZkQrVGo0NXp3Y05CcmFRU1BCWVYycytGcnVa?=
 =?utf-8?B?aXNaVjhCS3JpMkkyQm1qd1d4S2JwQzlxN0dKZVdFazlUYzROclRuZi9QZW5B?=
 =?utf-8?B?WW44aWVQSjgyK1R1MDJvZGlqQmM4ZW5UZGduZUNBLyszT05jNEtJeGwxaUV1?=
 =?utf-8?Q?BdUem5ccGm07n8PSdb5LofM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82905a9a-936c-40b8-039e-08d9b3c956bf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 06:19:17.9213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53cbDjyZ946dZxhRtfbrqgDhzUnWGSKM/hjGredKBa2YA6ic4KDi9g+JrlpCE8GBOnpmf/LLruc5Cz934GbW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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

Am 2021-11-29 um 9:40 p.m. schrieb shaoyunl:
> This change revert previous commit
> 7079e7d5c6bf: drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
> cd547b93c62a: drm/amdgpu: move kfd post_reset out of reset_sriov function

It looks like this is not a straight revert. It moves the
amdgpu_amdkfd_pre_reset to an earlier place in
amdgpu_device_reset_sriov, presumably to address the sequence issue that
the first patch was originally meant to fix. The patch description
should mention that.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Some register access(GRBM_GFX_CNTL) only be allowed on full access
> mode. Move kfd_pre_reset and  kfd_post_reset back inside reset_sriov
> function.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1989f9e9379e..3c5afa45173c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4285,6 +4285,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  {
>  	int r;
>  
> +	amdgpu_amdkfd_pre_reset(adev);
> +
>  	if (from_hypervisor)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  	else
> @@ -4312,6 +4314,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  
>  	amdgpu_irq_gpu_reset_resume_helper(adev);
>  	r = amdgpu_ib_ring_tests(adev);
> +	amdgpu_amdkfd_post_reset(adev);
>  
>  error:
>  	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
> @@ -5026,7 +5029,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  
>  		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>  
> -		amdgpu_amdkfd_pre_reset(tmp_adev);
> +		if (!amdgpu_sriov_vf(tmp_adev))
> +			amdgpu_amdkfd_pre_reset(tmp_adev);
>  
>  		/*
>  		 * Mark these ASICs to be reseted as untracked first
> @@ -5144,9 +5148,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  
>  skip_sched_resume:
>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> -		/* unlock kfd */
> -		if (!need_emergency_restart)
> -	                amdgpu_amdkfd_post_reset(tmp_adev);
> +		/* unlock kfd: SRIOV would do it separately */
> +		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
> +			amdgpu_amdkfd_post_reset(tmp_adev);
>  
>  		/* kfd_post_reset will do nothing if kfd device is not initialized,
>  		 * need to bring up kfd here if it's not be initialized before
