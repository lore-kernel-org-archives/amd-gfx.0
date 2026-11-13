Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F5606A33D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qg8kvpe2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A64D1125EC;
	Fri, 13 Nov 2026 14:50:46 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF82112609
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAVpx5vKc3Vw6IodL8sQCMHnkrW3I3zi4oSt0NOG8e4dwf3GENGl0knG1lz3tXyIm4FxCaCXeblitJpXSNIq0dGai5pzL4uFYI/lNKJZe8xkszBKrTiBNXPumw8Cp8XC3C4JVamioSXP9XMSTZAttol5/y3X4eSjndNN6WuvyiUFjLYEPXqECNtOYNsl8LI0acuOU3koYVls8qWrsP2At6/BJYD090WApfAItsKmZFymaG+hMiOH0L6lMSVd5LFzYRAyanYROfa51EZ3EZxVYP09UnD69o/Mac6k8rnkc/jE7jyrWa8NHeBR0/66KvbC8CdCwQYkH7F+r/UX8TPTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syJwfTCyZiEVeLdadG4ORjW4YupqNg55vZqiM5bkpa8=;
 b=SDtp0f/sk5BDUKvyX+UHM6g9o6gL++b8HB3kT4Z5V7QGOOAjyMxpwwm/C6Zbdy2bcpuB0tviZRBvpJgR+5fYHm4oSG30osXpf5/LCWzrPL2Ky6nud32GagFyfJClrJ5POG+FluOd7+aq3qvh3X4cu930NVX+iDwUQvN7/wfVTXwgpQ+3OeF52qNBzbexsgBIK+Tp6zGGnIacfLgfkF+tewsJvhdiS5qUfWAwRE++MGLis6teO0NKfL4u7jFMmzW8Xsd2HgRevBLPfLKwSLEYoUMePexjHzF0jP+4o9aMnxMqPUP4SdvpRFBVAz7A+lZMlN7GzC0EvGb14+12op36iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syJwfTCyZiEVeLdadG4ORjW4YupqNg55vZqiM5bkpa8=;
 b=Qg8kvpe2KAkbTzZE5WtA9kSBf2BNug+vKy6J7prlMurmXgtAFCs1DVYspw1pAAaIzQb8q5vI1+wIP6r57x83BsvJ6sFOshr/JZSMRcxFBSd1twGYeKAAeJXHQQkSYCkO+df52pjhW8fTNBeKvbdxPtTE0j7SjhJdYRDwcwUIcDE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH9PR12MB987669.namprd12.prod.outlook.com (2603:10b6:610:312::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:49:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 14:49:13 +0000
Message-ID: <09297fb9-0fe9-4c72-9461-d8b1445a799a@amd.com>
Date: Fri, 13 Nov 2026 20:19:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reinitialize GFX compute across a partition
 switch
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Mukul.Joshi@amd.com, Harish.Kasiviswanathan@amd.com
References: <20261109192953.3746947-1-alex.sierra@amd.com>
 <20261112221217.4015963-1-alex.sierra@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261112221217.4015963-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH9PR12MB987669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b982ff0-cb6e-4bba-13da-08df419548af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|18092099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Qv/lPUq7pvrgKNwD3Uy3j07vF6TYc/U3OyZGkdaYP4vFrERD6ie4qHBLzKcRuz7p2aeFe+kleDAPQkX71idu0tdkmtAFJNoz0Ja/wRFnWE2E92u4Gtwa7WIvCSRug9yBHlwojzR2NyPnlCVfTGmNTvvi2h0T4bN/f56JUxTTbG44V+UGnayPfoHeBmMiWyEnA25iq+OeCL/iD3QPp1kRUlOjgbBdd48M5ZHT096/JbfoS2/7uixJ1sV8FsBwavkwyd9RR3otS1NxQdeNNB1unoyx7raVg398c0RqEciCR/bWkQiRIAlPVj2Qh/2XCJQ7CJs1hPeh7a2SwFOD8C4r9llwWV9rS671CJBgF9aVrUEuuIHPH/4knIFAJ/Br6KEW9toBM6dbhe7AFUU60WCxfAjLazSy5fPlKnTd0TtnkoymJLo/o5QLII60TjgbauQ/fJBcjWezeMgCy0OSVZKNWMIWpLxD9eJOGvi3CDwrezy+fQe6kgsncnpqcF+96m4wkE732oeTuoi2OBkBxV7y0g4I0be11R94WMNSNffagdtPHA3vZBN9eJpt5jBJKo4TkrnL7+oZVymgRdXv/XNRvXpntURTNyKYHN3liB1ufrsy411/3F6V/a1UGzNHaqJ0r29T7QgOFHCFiKPKCrIgRmieOWdh6meJlM1vk2xnkU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(18092099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC93elRVYnBRWkFUZ1ErS1lpQ1JsVW5NMkRUUzNCQ2Rkd28wdEllWnh0MGxN?=
 =?utf-8?B?bTVkQjdOV3VzdjRzRXYyUzgrQ0xWY0RYOUtLTHBRY3E5UHdhSmNrNG1mdzli?=
 =?utf-8?B?UWM4WldHLy9oMnl3bXY0YWZwcWVjaGFtRStJYzZjUUM3ZWRSZHVkSUxNeVl0?=
 =?utf-8?B?U2hzQng2UjI4dEQzQVpVZWxvbVZ0YzQrRS9zQ1dZUm9wcVFMbEZTa2tYT05v?=
 =?utf-8?B?SzgzTGh6ZTQybU5KN2F5ZDZwWForVkRwem51ZXFCQlh2NHVuaUxma29vQW4v?=
 =?utf-8?B?dmg2eVFWczZaMHpaTHFTdDR3bnFoZy9KQmN0aEZLN0ljRmM5RGJjL2FjMlha?=
 =?utf-8?B?aGlaai9tMUN1d2Q0YlVYUnAweXM4bCthR2NicFZPZitEamNwTnpQRnRLRmVt?=
 =?utf-8?B?b0lIRW1WeE0rMGxQaTBFL200bU9ZNzVqOFM2YU1aS1ZmN3IyZ0xxdmFPVS9r?=
 =?utf-8?B?L0NoaW1lMGhCU2RFZEhscUNOU3pReGRzcGZ1S2VqQ2kycngrTG9NT3NSNnE5?=
 =?utf-8?B?L2xiUm5ISWo2T3VMZGNaN21QdEllY0txOFo1cnlXZDFuYldPM2Noa3NFYVdm?=
 =?utf-8?B?dXVpY0laRnpocnRrNG1yRzMwdytrK3g3ajJKUnpxUkxrdW01NlE1U3V6RVlM?=
 =?utf-8?B?TnQ0T1IxSEF6VHIzMXJXOGFBRWczTFJMcmNNZWNiT1BZRlR3NiswM1JHdXd2?=
 =?utf-8?B?OFBGZTZDN0FZclFrL3F6OTkwcml0SVVZaTBwRjh4clJFYjBDUlN0Q0hLaVF1?=
 =?utf-8?B?clZCWmhMZXV1dVJ3VzRSZkp3OEJQaHJhVVdQbmhGQmEwbmJmMGpWbnBEblZJ?=
 =?utf-8?B?bGIvQm1lQThhRGVwMHV3bGJET3kwMi9aUGMwYVNLamtxL3RyQ0lpMzZ4TFpL?=
 =?utf-8?B?b3ZpcThuZHhWZnRPYVB5Vk1mVTRFT3hUWnVqWVZmYitnbDUzT3lhUStCZGZ1?=
 =?utf-8?B?eTZOVjU5V1BERmIzSDA2bkJPWVJVNjJCMUFlR3pibS9ockU2SytpSFNCM2lY?=
 =?utf-8?B?SVNrejZEVGxwTU8zdk5oR3UxMnpDWHJzS3hxOTR2NStxTUpuQlJlNlgreWt6?=
 =?utf-8?B?OGdlS0U4SEVvUTdMRCtZbmZNeFAraE5admlHVUF4aTBka0JaUFJnTHNmMFNS?=
 =?utf-8?B?Z2hWU2E2RU1neEV4TU8rWXgvQ0FaUmc5ZXgxUm0zcGJ5b0JpeS9NSHFIZDJI?=
 =?utf-8?B?R21Bald0c3NWMktCb3o3TkUxbnVUaDBjTTV4ZDUxL1NFZUVoUlBhYTJrK1hN?=
 =?utf-8?B?MU5ITXBLR2l5Z1p2TGFtM3ZiTHYrNCsvNlhIU3NOSFpWRHhCcVM0azVPekpl?=
 =?utf-8?B?dGw5TG93cUhoOUFQcnhpOUgwbWF3VUo0SUtKYU5udDVLbXV1STI2YVVrM29m?=
 =?utf-8?B?M1Q5UW9mMExpeDNQQzBTTk9vTUh2ZzREYUw3akRjZXRJMVMxaEhrOVVPd2N1?=
 =?utf-8?B?UnNGY2hqc0RKc1dQcW8zLytKOTZrNmJyNFlxUWI2dDJqaXRnWDFGRE0xcE1J?=
 =?utf-8?B?a1BnaC9IdjNTeDdqeDg1RlJhZmZ1QWhkVmZrYkE5UUk0RW9rKzRjYlZoYjZ2?=
 =?utf-8?B?b0FmaHI4ZVFVekNtcEFTcHIrSDhlR3psaXVlMG0rY0hZVXFFZWhpZkVQSm1j?=
 =?utf-8?B?MUpEK2xKWk1wOHAzZ21JMTlOOE1XamRLYTFOVjZ4OFhGb2JsaWRYdFBCaFV0?=
 =?utf-8?B?eWYybzNOOTdDNEFiYnVCMXUvcElWdmErYzhMV2xVMTNHcW43Rm5malZsSnFQ?=
 =?utf-8?B?MHZBWG5WelNIaXlDamtKWXphcnNxRjBVVHFOaWdTWEUxZVFIV3hLeUk2aTgr?=
 =?utf-8?B?UGVBbk5XMFZCRUtEMzlSa0toaWhnM2ZMYUZDOXd6L1JZTTJFY2Z3anVFNXR3?=
 =?utf-8?B?UjFzcGtjT2JwOE9rdXJzQVMrRzFtbGVxaDNseHdMNDlPUUs5Ykc5cFQ5MGJk?=
 =?utf-8?B?OWFhR1ZqbmszekRkcnh1RXdmM2F4ZzlkcnAwcEJ4eDBodFU0bUVDSVc1UXlU?=
 =?utf-8?B?YThzRXZmdGNpdEIwdWhhK25EeS9YYkF1VDFUSHIxaURyN09zWHNjdms3Ritm?=
 =?utf-8?B?UVpxVmxKZWNIZXVxTmV5UkVuNHJvWjQzWVRJUjNTWlJkOFpyS1lNczhGZ3NS?=
 =?utf-8?B?LzVuN2ZoUmJLc05iaW5DazhhSWF4ZXFCeDZJeTlrdjg5dUFDMDRqTURYYlJn?=
 =?utf-8?B?M3JZSjRqZGN0aDl4NDFaM0pZOTQreGV2VVM0RlpYYzEvZWw3ZCtnYlhhK3NT?=
 =?utf-8?B?RFJDbGZFZUNvWCt1WlgzdkF2ZTNyU3dtWHZiejBBY1ljb2gyK0N5RFhieTd2?=
 =?utf-8?Q?OxDB2EPu1p3suGGkYQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b982ff0-cb6e-4bba-13da-08df419548af
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:49:13.7437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac/lL9kNU5X12OOYFHmhfrr1WThINe+ygHvp0Y27NKCfLczBpAPm4scs/criITPd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB987669
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 13-Nov-26 3:42 AM, Alex Sierra wrote:
> A runtime compute partition switch updates the XCP mode and IMU
> partition without passing through GFX hw_fini and hw_init. The MEC,
> KCQs, and MES KIQ therefore remain programmed for the previous
> partition, including its cooperative mode.
> 
> Add optional pre_px_switch and post_px_switch hooks to amd_ip_funcs.
> amdgpu_xcp_pre_partition_switch runs the pre hooks while the old
> partition is still in place. amdgpu_xcp_post_partition_switch runs
> the post hooks after the new mode is committed and before KFD
> recreates queues.
> 
> Run the IP hooks only for a runtime switch with a known current mode.
> Skip them during initial mode setup, reset or suspend recovery, and
> amdgpu_xcp_restore_partition_mode, where the regular IP initialization
> path restores the hardware. If an eligible runtime switch fails, run
> the post hooks to undo any state stopped by its pre hooks.
> 
> GFX v12.1 uses its regular per-XCC teardown in the pre hook. This
> disables KCQs, tears down MES KIQ, and disables the MEC compute pipes.
> Clear both MES rings and their writeback pointers before the switch so
> firmware cannot replay stale packets when it restarts.
> 
> The post hook runs the matching CP resume path, which enables MEC,
> initializes MES KIQ for the new cooperative mode, restores KCQs, and
> tests the compute rings. Track whether the pre hook stopped GFX so the
> post hook only resumes a path that was actually torn down.
> 
> Add debug output for SET_HW_RSRC_1 to expose the cooperative-mode
> selection used while validating the new partition state.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 88 +++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  3 +-
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 54 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c     |  8 ++
>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  4 +-
>   drivers/gpu/drm/amd/include/amd_shared.h   |  5 ++
>   8 files changed, 152 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 41471bc560cd..df6e9da1a11d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -532,6 +532,7 @@ struct amdgpu_gfx {
>   	uint16_t 			xcc_mask;
>   	uint32_t			num_xcc_per_xcp;
>   	struct mutex			partition_mutex;
> +	bool				px_switch_stopped;
>   	bool				mcbp; /* mid command buffer preemption */
>   
>   	/* IP reg dump */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 9f4158e06e60..158faa362606 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -213,8 +213,32 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>   	return 0;
>   }
>   
> +static int amdgpu_xcp_run_px_switch(struct amdgpu_device *adev, bool post)
> +{
> +	struct amdgpu_ip_block *ip_block;
> +	int (*px_switch)(struct amdgpu_ip_block *ip_block);
> +	int i, ret;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		ip_block = &adev->ip_blocks[i];
> +		if (!ip_block->version || !ip_block->version->funcs)
> +			continue;
> +
> +		px_switch = post ? ip_block->version->funcs->post_px_switch :
> +				   ip_block->version->funcs->pre_px_switch;
> +		if (!px_switch)
> +			continue;
> +
> +		ret = px_switch(ip_block);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
> -					      int mode)
> +					      int mode, u32 flags)
>   {
>   	int ret, curr_mode, num_xcps = 0;
>   
> @@ -224,10 +248,15 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   	mutex_lock(&xcp_mgr->xcp_lock);
>   
>   	curr_mode = xcp_mgr->mode;
> +	if (amdgpu_in_reset(xcp_mgr->adev) || xcp_mgr->adev->in_suspend ||
> +	    curr_mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
> +		flags &= ~AMDGPU_XCP_OPS_IP;
> +
>   	/* State set to transient mode */
>   	xcp_mgr->mode = AMDGPU_XCP_MODE_TRANS;
>   
> -	ret = xcp_mgr->funcs->switch_partition_mode(xcp_mgr, mode, &num_xcps);
> +	ret = xcp_mgr->funcs->switch_partition_mode(xcp_mgr, mode, &num_xcps,
> +						    flags);
>   
>   	if (ret) {
>   		/* Failed, get whatever mode it's at now */
> @@ -237,6 +266,19 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   		else
>   			xcp_mgr->mode = curr_mode;
>   
> +		/*
> +		 * pre_px_switch may have stopped an IP. Each post_px_switch
> +		 * decides what to bring back for the mode settled above.
> +		 */
> +		if (flags & AMDGPU_XCP_OPS_IP) {
> +			int px_ret = amdgpu_xcp_run_px_switch(xcp_mgr->adev, true);
> +
> +			if (px_ret)
> +				dev_err(xcp_mgr->adev->dev,
> +					"Failed to restore IP state after partition switch failure: %d\n",
> +					px_ret);
> +		}
> +
>   		goto out;
>   	}
>   	amdgpu_xcp_sysfs_entries_update(xcp_mgr);
> @@ -254,7 +296,8 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
>   	if (xcp_mgr->mode == mode)
>   		return 0;
>   
> -	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode);
> +	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode,
> +						  AMDGPU_XCP_OPS_IP);
>   }
>   
>   int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
> @@ -262,7 +305,7 @@ int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
>   	if (!xcp_mgr || xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
>   		return 0;
>   
> -	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode);
> +	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode, 0);
>   }
>   
>   static bool __amdgpu_xcp_is_cached_mode_valid(struct amdgpu_xcp_mgr *xcp_mgr)
> @@ -855,27 +898,52 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
>   
>   int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
>   {
> +	struct amdgpu_device *adev = xcp_mgr->adev;
>   	int ret = 0;
>   
>   	/* TODO:
>   	 * Stop user queues and threads, and make sure GPU is empty of work.
>   	 */
>   
> -	if (flags & AMDGPU_XCP_OPS_KFD)
> -		ret = amdgpu_amdkfd_prepare_partition_switch(xcp_mgr->adev);
> +	if (flags & AMDGPU_XCP_OPS_KFD) {
> +		ret = amdgpu_amdkfd_prepare_partition_switch(adev);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return ret;
> +	/*
> +	 * IP-specific prep while the old partition is still programmed.
> +	 * enable_mes_kiq and similar checks belong in the IP callback.
> +	 */
> +	if (flags & AMDGPU_XCP_OPS_IP) {
> +		ret = amdgpu_xcp_run_px_switch(adev, false);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>   }
>   
>   int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
>   {
> +	struct amdgpu_device *adev = xcp_mgr->adev;
>   	int ret = 0;
>   
> +	/*
> +	 * The new partition mode is already committed. Let each IP
> +	 * program itself before KFD recreates queues.
> +	 */
> +	if (flags & AMDGPU_XCP_OPS_IP) {
> +		ret = amdgpu_xcp_run_px_switch(adev, true);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (flags & AMDGPU_XCP_OPS_KFD) {
> -		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
> -		amdgpu_amdkfd_device_init(xcp_mgr->adev);
> +		amdgpu_amdkfd_device_probe(adev);
> +		amdgpu_amdkfd_device_init(adev);
>   		/* If KFD init failed, return failure */
> -		if (!xcp_mgr->adev->kfd.init_complete)
> +		if (!adev->kfd.init_complete)
>   			ret = -EIO;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 6b3fdafc8b02..b4c0f80488dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -41,6 +41,7 @@
>   #define AMDGPU_XCP_NO_PARTITION (~0)
>   
>   #define AMDGPU_XCP_OPS_KFD	(1 << 0)
> +#define AMDGPU_XCP_OPS_IP	BIT(1)
>   
>   #define XCP_INST_MASK(num_inst, xcp_id)		\
>   	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
> @@ -150,7 +151,7 @@ struct amdgpu_xcp_mgr {
>   
>   struct amdgpu_xcp_mgr_funcs {
>   	int (*switch_partition_mode)(struct amdgpu_xcp_mgr *xcp_mgr, int mode,
> -				     int *num_xcps);
> +				     int *num_xcps, u32 flags);
>   	int (*query_partition_mode)(struct amdgpu_xcp_mgr *xcp_mgr);
>   	int (*get_ip_details)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
>   			      enum AMDGPU_XCP_IP_BLOCK ip_id,
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 05e4edf72e4d..ec8b0c8f5e6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -364,11 +364,11 @@ static void __aqua_vanjaram_update_available_partition_mode(struct amdgpu_xcp_mg
>   }
>   
>   static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
> -					       int mode, int *num_xcps)
> +					       int mode, int *num_xcps,
> +					       u32 flags)
>   {
>   	int num_xcc_per_xcp, num_xcc, ret;
>   	struct amdgpu_device *adev;
> -	u32 flags = 0;
>   
>   	adev = xcp_mgr->adev;
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index fee6b1b433cd..3592b95371b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -4041,6 +4041,58 @@ static void gfx_v12_1_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
>   }
>   
> +/*
> + * A runtime partition switch does not pass through GFX hw_fini/hw_init.
> + * Stop the GFX compute path while the old partition is still programmed,
> + * then restore it after the new mode is committed.
> + */
> +static int gfx_v12_1_pre_px_switch(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int xcc_id, pipe, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +
> +	if (!adev->enable_mes_kiq)
> +		return 0;
> +
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		if (!adev->mes.ring[MES_PIPE_INST(xcc_id,
> +						  AMDGPU_MES_SCHED_PIPE)].sched.ready)
> +			return 0;
> +	}
> +
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++)
> +		gfx_v12_1_xcc_fini(adev, xcc_id);
> +
> +	/*
> +	 * MES firmware restarts with its read pointer at zero. Clear both
> +	 * rings and their writeback pointers before bringing the GFX compute
> +	 * path back up, otherwise firmware can replay stale packets.
> +	 */
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++)
> +			amdgpu_ring_clear_ring_and_ptrs(
> +				&adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)]);
> +	}
> +
> +	adev->gfx.px_switch_stopped = true;
> +	return 0;
> +}
> +
> +static int gfx_v12_1_post_px_switch(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	uint16_t xcc_mask;
> +
> +	if (!adev->enable_mes_kiq || !adev->gfx.px_switch_stopped)
> +		return 0;
> +
> +	/* Cleared first so a failed resume is not run a second time. */
> +	adev->gfx.px_switch_stopped = false;
> +	xcc_mask = GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
> +
> +	return gfx_v12_1_xcc_cp_resume(adev, xcc_mask);
> +}
> +
>   static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
>   	.name = "gfx_v12_1",
>   	.early_init = gfx_v12_1_early_init,
> @@ -4056,6 +4108,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
>   	.get_clockgating_state = gfx_v12_1_get_clockgating_state,
>   	.dump_ip_state = gfx_v12_1_ip_dump,
>   	.print_ip_state = gfx_v12_1_ip_print,
> +	.pre_px_switch = gfx_v12_1_pre_px_switch,
> +	.post_px_switch = gfx_v12_1_post_px_switch,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 3585897c817d..a8153c504c41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -679,6 +679,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
>   			mes->shared_cmd_buf_gpu_addr[MES_PIPE_INST(master_xcc_id, pipe)];
>   	}
>   
> +	dev_dbg(mes->adev->dev,
> +		"MES(%d, %d) SET_HW_RSRC_1 coop=%u enable_coop=%u kiq_ver=0x%x mode=%s\n",
> +		xcc_id, pipe, mes_set_hw_res_1_pkt.mes_coop_mode,
> +		mes->enable_coop_mode,
> +		mes->kiq_version & AMDGPU_MES_VERSION_MASK,
> +		amdgpu_gfx_compute_mode_desc(mes->adev->xcp_mgr ?
> +					     mes->adev->xcp_mgr->mode : -1));
> +
>   	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
>   			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index b782fe2841b5..ad9913723cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -1166,11 +1166,11 @@ static void __soc_v1_0_update_available_partition_mode(struct amdgpu_xcp_mgr *xc
>   }
>   
>   static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
> -					  int mode, int *num_xcps)
> +					  int mode, int *num_xcps,
> +					  u32 flags)
>   {
>   	int num_xcc_per_xcp, num_xcc, ret;
>   	struct amdgpu_device *adev;
> -	u32 flags = 0;
>   
>   	adev = xcp_mgr->adev;
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index e81ce9d79009..db24bacb8e0e 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -446,6 +446,9 @@ enum amd_dpm_forced_level;
>    * @get_clockgating_state: get current clockgating status
>    * @dump_ip_state: dump the IP state of the ASIC during a gpu hang
>    * @print_ip_state: print the IP state in devcoredump for each IP of the ASIC
> + * @pre_px_switch: IP-specific prep before a compute partition switch - Optional
> + * @post_px_switch: IP-specific programming after a compute partition switch,
> + *                  or after a failed switch - Optional
>    *
>    * These hooks provide an interface for controlling the operational state
>    * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
> @@ -476,6 +479,8 @@ struct amd_ip_funcs {
>   	void (*get_clockgating_state)(struct amdgpu_ip_block *ip_block, u64 *flags);
>   	void (*dump_ip_state)(struct amdgpu_ip_block *ip_block);
>   	void (*print_ip_state)(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
> +	int (*pre_px_switch)(struct amdgpu_ip_block *ip_block);
> +	int (*post_px_switch)(struct amdgpu_ip_block *ip_block);
>   };
>   
>   

