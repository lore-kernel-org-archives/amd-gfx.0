Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 01:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570706108F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 01:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 570706108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63E16E0EE;
	Wed, 25 Aug 2021 01:08:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D886E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 01:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8W6K28CC7Sgxk3MtqlitalZgM72x+cO01qWe74EIYFWviHqEnxg4OyTE7mBifjWczgf742NpYwhUeTDHuKHAPD1QQN0giqaLj2N/M8OTNCvu5+J7f9V8acDl+mEU9akTl5mT+gh8423J/Smjayh3Mx+p8umq7NnTRtfYQJc1VNGbHiJ1GkKzQCZSBIsGiNlrH0bndS+5CTPv0OxhEniSC7Ysm1dS7zhQesG6ax77UiDmmaMNcGnGWIKnlrPq9cA8JpYJwTPxLkOUoOGWfCKB9Coxh0Gkq4Gf/dgJI1o7X0/wuIICaBcHP3WEc5iQ5hoK8RCRe2psDPZBu/nq82SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDmKy04rudNcpb8PZgTGpOQ8oE5EowOHv3oqApMU6c0=;
 b=TPZlERFE9k2aU4mJoLw7ZwDTNIa6UX/ghVJVutHUQLSdTL+1BfBlGdwY4lZr9LCzJuQEi31BKWQy2CaS05sijxFMr0CRdllf8A+fCw58bXhYJ7KWY/zXusC5yP3sFy3NZ7h37sbzE7MGLZfPSDt02S8lDY5xdPMFKgzWbF+vMwWi2Ttd6rYSNPg/RkB0PkgVC6r8n/E1yP780KzKaQEiKqN4J6jRoXJ5CiBRY9NCAKxURYHii3e2t4OWtt8hPewdhJTl9uKMCCSjonFSHPeu3o6wu9EITClQaR8Qnfb9+RN57PS0P8Al/cqApl5tcaKbRyBmX/GBeaKtlLu7F07lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDmKy04rudNcpb8PZgTGpOQ8oE5EowOHv3oqApMU6c0=;
 b=z2y9nggm3sx+8EuMn51LPRIsC/lL3tBr1ppnIgKeNIlE9y5f3RP+Ql+XonE43m7su0aGwziXRALE4gy75T+admE+msa4nBcsqjEHXLiDd1wfH9MxSExTuLNOnq+/CnaHB3EDZgNGnShq3zpjDXg7uJ3pyJiLymhJ/+9UWSit/fw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 00:53:39 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 00:53:39 +0000
Subject: Re: [PATCH v2] drm/amdkfd: Account for SH/SE count when setting up cu
 masks.
To: amd-gfx@lists.freedesktop.org, "Keely, Sean" <Sean.Keely@amd.com>
References: <20210824003658.84092-1-Sean.Keely@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f9ed210c-470d-61f7-bbad-79a83b8659f2@amd.com>
Date: Tue, 24 Aug 2021 20:53:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210824003658.84092-1-Sean.Keely@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::10) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 00:53:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9837e62c-4cfd-4c74-6e35-08d96762c6a0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5035:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5035A250E2E7EBFC4F860B7192C69@BN9PR12MB5035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/ufh60nAiiik3i6++/YkimsEGiIqFCug4jUs3uCeGu1B5KVD9QNpQVSDtUE6yqbu/te5tFgOK2J6c2nK4xxeG0yqpIqWvmFx1z/khsHLp+pVN2iLxSX2H6hnlcUE3FnQTfMB6Xpdltn2oymOKgPZ8o0wOX8QIaZmELHdoqAmMDjY3S1yHf0kSE4Id+ZGQylUBfCXYhepwmQqqQM3U4ZFtn48wtVDgGU/7yEoIF+vg5B6ivFuZcwSfYYl9Z4Qp7wubodFErFHf9KzED1BzxAATJ0Kfc0sziyl/4qcdK1j5BDDueWvd/7b0ag6dU8p71jTJRShqX/DxBMyMd3SrA9im7PuVETWg3+oW86aoDo7EVygd3biGtK8/opv58rwuk9msam+m46fXWWYNrInPB4u49jEz02aWGFtaXBbn0SNx8Dbrb8c+omaca5mSy6v34jubhR6M6wM6/lehZW/d105X2RVB/f6cBMq2l+/40DgU112i1+kArd/wA5CYu4yiRN0QDPf8eEzeKeMmz9Kph+Lfb+UKW9jpgMnlFXBPm6aUDrLUQg4hVn5i/ReH3QGAu2t3tEpVsBlKIvVNqMugSRpHd/+sp9zQUQycM2Aw26vGI+BmBhuHJ+BUWyOISX6cgL0uBcXXhvSvUlRLA6lkCeo+Z6++Uo7c6eC85eaytoMkveYHIs1kl7V/owpyeDljtNtRC+sI7ZDcIm9+5ghhDhaC/l8tVfFDKg1gv0VW/dp7FfdrlRGz6uYQZJjLTqvCPu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(26005)(36756003)(8936002)(37006003)(6486002)(316002)(478600001)(186003)(44832011)(16576012)(86362001)(83380400001)(31686004)(2616005)(6636002)(956004)(6862004)(2906002)(38100700002)(8676002)(66556008)(66476007)(66946007)(5660300002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUtjMkM1ZUcvOEcwNnJTcHpoa1NaaHl0QkJYdzB0ZkpJbGVIK3JwbmpKQkQ2?=
 =?utf-8?B?Si90UlZIYlk2RVEzdDdqbkdxNUg3QlBjWjNTaFIxWXBRWk9IMlpBWHpLQjU3?=
 =?utf-8?B?cGU5OXcxcERPemlYa2JIN0Mxc09kd3FZZ3J5VUZlZU1GR3BwNE5zdndpd2Nm?=
 =?utf-8?B?UEZNckErUitVSkV3QXJiMXhUcFlhWE1nbS83RlNxUERTeE9xWTdFR1BQUWtl?=
 =?utf-8?B?YW5hZ1VETUxVRzBDSy94WFB3MWx4Y2M2VXJYV1VuWkFmUk9vWmhJYnM4VUMv?=
 =?utf-8?B?NGIwUGRWaERNbVhOVGJmRm1NZXJSU24xMTQvNU5icTJZVE1aR2tlK09SaWZo?=
 =?utf-8?B?NWhNU1F5Umw5QnNBc1ZQcVFKUXkzSFQ2czVoMGZWUXFCUzlUU3dxZnphUHNF?=
 =?utf-8?B?VU5odHVESnZ5aVdwMGJRajNFcDR0K3JvUlhLOGtybVZUK1ZZcWpIeXdoUEVR?=
 =?utf-8?B?djNyZ0NmcmlGZVY1RFN4SWFPbGFMRGYxd2ZnczhEcmFDWUtKT1U1b0ZnTVdn?=
 =?utf-8?B?djdQUlozSk1LK2hEUnNNMHZ0T0JORXh3V3ZJTW92c2pSS25GZElHb0ZhVzZM?=
 =?utf-8?B?a09LY2ZuNDNuVWxiR3V0ek9IMXhQNjJWV3M1YkxUUXVGZFcrZWNEQkFXMHdn?=
 =?utf-8?B?THBSeEtjZnRHcXplOFo4Mnp5NXpSTGJ3a1hjZGhhZHdwWWhCMVJPK0ZuMXVa?=
 =?utf-8?B?dHQ5NkVtbzl5ejRocXZmWFpHUmsyeFNybXQyWWJwWHkybCtxYkxkSVd0WmxH?=
 =?utf-8?B?OUh5NjRSS0pRQkdFRGRONGV3eXJJMjJ0cG92Zmk1T295MzZDRjlWM2l1ekJY?=
 =?utf-8?B?Ymk2ZkRadHFvOURwUXduNW4wK1FkSjFRNmI4cXhPTGdra090UlErUFVuN2lm?=
 =?utf-8?B?YktQQ21WY1o5bGpRQklRbWhURml1WWtXY0YydXRoTEpRSjBBelI1VWlFUGlV?=
 =?utf-8?B?R0JFL3E0dXpZMUV1c3h4b3dQZXRobmVKNTRZbmVQcDhvRHRYYWRXZ3NZOVdJ?=
 =?utf-8?B?cWJKK0ZPSzlEZ2ZDZUlQT2w5K3p5ZEZxWkp1MjUxMG5uQXRVUmFWQUFmUkZz?=
 =?utf-8?B?ZTgzUWtrWnRWc2NraC94YUJBanFEWDg2U0lNOTcyRk9kTHh5TUlwN2pMZHZF?=
 =?utf-8?B?ak9DZ1lLSjZPVDUvKzZ3MHM4Mmp1blZHMnZDOVlkUUVNL2xBMnY4akgxT3d4?=
 =?utf-8?B?dGVmMDVueVJUb2VYdWVWY1ExT3E4cW92YVRkNkxpdmRwQTMxM2hiMnhuSk1v?=
 =?utf-8?B?VnZYaVNsWFlHWVlwYnVjenNpbktkdGZFK3pTeUwxZ2xyWExhK3BjV0ZHQmlk?=
 =?utf-8?B?Ykp6NkFFUmxLK0I3Z1Z1WDU4SnFUQWVJMkI0T3pRUWx1Y2hrMEhiMHZxM1Ew?=
 =?utf-8?B?cmJGbUdEdjkvbHlvZVk4eE45RnQxTlpoaHROOUJ4Zi9ybVNZcmo0cDdxVWJz?=
 =?utf-8?B?ZWRaRTdwUXNTek9GTitqeGs5SE1MaHVLMHBMVUZ1ZHVVOGluSW9aOWZRdGNp?=
 =?utf-8?B?MEtvcTkxTW45WUpBYU5xdmpiY2ErSDIxZS9nS2FtRlhPckJHdWpZYzA4TkF5?=
 =?utf-8?B?UVh2VnovK3F1TEJubm50STN3cWdFSzBKdC9MQWhpVkpzUGgvajh3NXQ3aENl?=
 =?utf-8?B?NXZlWGxEVTR3M0NTbGZqMUZIL1l3ZEVjckdla1NnVWVVTmU2YzlSS005U0F1?=
 =?utf-8?B?UXJEZG91a256K3Q4aGRxT2FHSjltbkI1OU5ueHd3QzNNSjBOUlpvZENaY3Br?=
 =?utf-8?Q?DzuJhq/+JNbgOfgtwZHTQT9IbHUfz9eWI6CT3/r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9837e62c-4cfd-4c74-6e35-08d96762c6a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 00:53:38.8396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu+zoM4jNpj4k59U13vXxeKELstzGASOxsvEfT4oiNciR4F8Yj9AT+pyXYST/SbbyC/DEolwPfJEJEAM5Qe6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
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

Am 2021-08-23 um 8:36 p.m. schrieb Sean Keely:
> On systems with multiple SH per SE compute_static_thread_mgmt_se#
> is split into independent masks, one for each SH, in the upper and
> lower 16 bits.  We need to detect this and apply cu masking to each
> SH.  The cu mask bits are assigned first to each SE, then to
> alternate SHs, then finally to higher CU id.  This ensures that
> the maximum number of SPIs are engaged as early as possible while
> balancing CU assignment to each SH.
>
> v2: Use max SH/SE rather than max SH in cu_per_sh.
>
> Signed-off-by: Sean Keely <Sean.Keely@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 79 ++++++++++++++------
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h |  1 +
>  2 files changed, 59 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 88813dad731f..5d7016928d24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -98,36 +98,73 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>  		uint32_t *se_mask)
>  {
>  	struct kfd_cu_info cu_info;
> -	uint32_t cu_per_se[KFD_MAX_NUM_SE] = {0};
> -	int i, se, sh, cu = 0;
> -
> +	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
> +	int i, se, sh, cu;
>  	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
>  
>  	if (cu_mask_count > cu_info.cu_active_number)
>  		cu_mask_count = cu_info.cu_active_number;
>  
> +	// Exceeding these bounds corrupts the stack and indicates a coding error.
> +	// Returning with no CU's enabled will hang the queue, which should be
> +	// attention grabbing.
> +	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
> +		return;
> +	}
> +	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
> +			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
> +		return;
> +	}
> +
> +	/* Count active CUs per SH.
> +	 *
> +	 * Some CUs in an SH may be disabled.	HW expects disabled CUs to be
> +	 * represented in the high bits of each SH's enable mask (the upper and lower
> +	 * 16 bits of se_mask) and will take care of the actual distribution of
> +	 * disabled CUs within each SH automatically.
> +	 * Each half of se_mask must be filled compactly, LSB first.
> +	 *
> +	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
> +	 */
>  	for (se = 0; se < cu_info.num_shader_engines; se++)
>  		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
> -			cu_per_se[se] += hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
> -
> -	/* Symmetrically map cu_mask to all SEs:
> -	 * cu_mask[0] bit0 -> se_mask[0] bit0;
> -	 * cu_mask[0] bit1 -> se_mask[1] bit0;
> -	 * ... (if # SE is 4)
> -	 * cu_mask[0] bit4 -> se_mask[0] bit1;
> +			cu_per_sh[se][sh] = hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
> +
> +	/* Symmetrically map cu_mask to all SEs & SHs:
> +	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
> +	 *
> +	 * Examples
> +	 * Assuming 1 SH/SE, 4 SEs:
> +	 * cu_mask[0] bit0 -> se_mask[0] bit0
> +	 * cu_mask[0] bit1 -> se_mask[1] bit0
> +	 * ...
> +	 * cu_mask[0] bit4 -> se_mask[0] bit1
> +	 * ...
> +	 *
> +	 * Assuming 2 SH/SE, 4 SEs
> +	 * cu_mask[0] bit0 -> se_mask[0] bit0 (SE0,SH0,CU0)
> +	 * cu_mask[0] bit1 -> se_mask[1] bit0 (SE1,SH0,CU0)
> +	 * ...
> +	 * cu_mask[0] bit4 -> se_mask[0] bit16 (SE0,SH1,CU0)
> +	 * cu_mask[0] bit5 -> se_mask[1] bit16 (SE1,SH1,CU0)
> +	 * ...
> +	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
>  	 * ...
>  	 */
> -	se = 0;
> -	for (i = 0; i < cu_mask_count; i++) {
> -		if (cu_mask[i / 32] & (1 << (i % 32)))
> -			se_mask[se] |= 1 << cu;
> -
> -		do {
> -			se++;
> -			if (se == cu_info.num_shader_engines) {
> -				se = 0;
> -				cu++;
> +	i = 0;
> +	for (cu = 0; cu < 16; cu++) {
> +		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
> +			for (se = 0; se < cu_info.num_shader_engines; se++) {
> +				if ((cu_mask[i / 32] & (1 << (i % 32))) &&
> +					(cu_per_sh[se][sh] > cu)) {

You need to increment i when cu_mask[i/32] & (1 << (i % 32)) is 0.
Otherwise you'll get stuck on any 0 bit in the CU mask.

Regards,
  Felix


> +					se_mask[se] |= 1 << (cu + sh * 16);
> +					i++;
> +					if (i == cu_mask_count)
> +						return;
> +				}
>  			}
> -		} while (cu >= cu_per_se[se] && cu < 32);
> +		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index b5e2ea7550d4..6e6918ccedfd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -27,6 +27,7 @@
>  #include "kfd_priv.h"
>  
>  #define KFD_MAX_NUM_SE 8
> +#define KFD_MAX_NUM_SH_PER_SE 2
>  
>  /**
>   * struct mqd_manager
