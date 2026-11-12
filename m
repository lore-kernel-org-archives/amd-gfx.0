Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E3606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AnZNKunL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EE610E47A;
	Thu, 12 Nov 2026 03:02:57 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E72810E47A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 03:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxOKsZN27y9f4pO8Arode3DkGXMhDruCr+Lv1xMcA0lS8T/GAKjEWPQ6k8OBHFQyYhMdYtbqOMgsJ8+TcqDJfFH4JYtN+je8nBiK85YfQCPeti3lIM0qlXa0hOTNtv5Ys+d0cmHfSS2sbO+kFYOHXi2KnKk5DVo4IgnnAlJvKDIeNiAihQ8Sw4LOaCkJHAlLSGSstiXqdbE9PBfmPwN2m/QLoIgMu9+pWAjFT0pjB2mWdbDtke88Yxz581lBEZC+dEPtegDBmIBGwVp/P5+k8+tumFHGMPbDHZ8glDyIVDZ3P3f4GEUhwCNbRvTkD4iFHp7euFMxg/78/XJRuAJJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdbz4ngcVKavgmpRJw0miBCgrdG6XkTXpfalIqRioSg=;
 b=DQmncMaFp72vsopqG75V+nvz1YW1XhVxvk8cKpe32gR1YYJFz3I8aLFDf0+bJu9pmzzH108U+dFbTWO809DI+aqdU5RmaVI6iSzGGS2DG3+ertu3w4sli/4QOyo7JBBuUCM3KsvrozVsX0213VdTR4LaUfntflzTX6KX/gj2vJXvOtRWY+pKnXqh2YpPFtaa3D+GILSj6rA3MAYEXvLgJIvuFcKREIXVdACL6ejaOygBsMbwB9U2AL3G8TICmIGj0Bnne/uxvGxH5I2q+z4jSVXaAufNUKZh6EAWasVlKk6+RxrFT+VyCMfeOYHRU0brN/V0wQqneAPTJANTKpi7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdbz4ngcVKavgmpRJw0miBCgrdG6XkTXpfalIqRioSg=;
 b=AnZNKunLLUmym5YjnHWOwargL+z49CKE9PZKxivG+6/AyDd8OB3jdSrpJkhG50yuAMQirR9KWVQ7vFQ4QS3KC7OBw+51cYwlIcDH9/v9oyWcArrQCBaltivLmSYFIZ1l22UpPqF5aCHMFNca1kqMIsxXot0aCWd2p++4AMjYc30=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 03:02:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 03:02:47 +0000
Message-ID: <5c47e6cd-ca7d-4ccb-a51f-0c3594347ad5@amd.com>
Date: Thu, 12 Nov 2026 08:32:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reinitialize GFX compute across a partition
 switch
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Mukul.Joshi@amd.com, Harish.Kasiviswanathan@amd.com
References: <20261105135053.3501763-1-alex.sierra@amd.com>
 <20261109192953.3746947-1-alex.sierra@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261109192953.3746947-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 04492244-a70a-4686-8305-08df40696e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|5023799004|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: ulBzZcj5U9j1MtM1jsiMzeBXpVH+KzpS4JRIceJIOYHaStnl5VkAFqfXPsv27C67SbtkZd8wd40y/wv0GigvrfiNpz6sjq0b0nVb0+pHSLbwKGvZuliqyOZh52UD9sJD3aeGUauvWoPoGwgS1lh0H90YqKEoQhUyx9Au1+K3dH3u+2XH7QNnj3bqpO2WSJiFD4++Ug9ZUqDRYjYNU00oDFqVLtIJF25T3xInZRb4LFgnf9yhxEhB7h2qLdS9nYjNl3cKHfVQtVYLYv7H3RvT7WdbRxQ00ehDoD28wTQ6FTiIOXzyPyCMMwukLN7YriSSOM9n8MEoXPJFoqR3be3Q9msKSY7IOHu24jJNUi6GU+xu4IUbXQND61SvKA9nBPyLjHFDq2wR6F4MfqlORkguF6G+4YCHYJmNbGbN4to9lWX6kyLMhkZyASPo/UCC2lCiTixlzFEeK42bHAhEqBV0H40ar4kggqp9duWza21XfR4oc6rv6b4qTGzuX15MVlSSy3iaYpv2NQ7Jl5CTLX2+qUBMP9GHGa5GDTS+0bqva1irv9+pzHBwSSRZuexeST1dUc6tFnt5nsxdxQvHZ1LQqKnK+RNbmEcKp8eCWlXFQJZKYbKhG6F8YOX+oeFH3bJLcCf6Pi+37onajcGl3JB0tfybwvT5WOIKKpjSL5qedKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(5023799004)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZTQjNLZUlpMjJ1dDlwOTdlQlVHUVFaZmRyaEc2MlZMSENwdmtCaWRDY1li?=
 =?utf-8?B?dE4zMmVCNlZVNTFndXZtZG9GMk5Wb0c1bnFZUHoyZ2ZSekhWKzcvblVJaDRy?=
 =?utf-8?B?VjhuemNYMW1LZU9ma0N3QkFRWjhNMDM3VDcwRnNsOEFBVlN2VzBOZ2ZPL2t4?=
 =?utf-8?B?WmphSVNuRHppQjdDUTRQdEtXaFR5RXNsVnNQWGdlY0dHdDZ3dWt2ZzBWVERG?=
 =?utf-8?B?ejZDQXhEaDl0TGIrTVkwbCtiSE1CV0luTVYvR01xREY4em5FQVUxak1yNGtN?=
 =?utf-8?B?a05laDEveFkzRTl3eW9WOE1IZ0dmQmJwcDNJbnFLaytWSmNZN1U0RVQ3eDBF?=
 =?utf-8?B?WWFBNGJ5VUFybFk3Ri9rWE1Jc3FxNTNGZloyK3U2QUxXS3QrSUZrQktGYkRM?=
 =?utf-8?B?aHJDdDdZaEZpTFhEV1NjOTVsSDhvUTRNTldGOTdBUmRkS2dYSnBTNXdFTkRa?=
 =?utf-8?B?YzZZOEE2d0RuZGZSSUY1VDg0MHc0a2NZQ29yWW05ZXpuOUowbGd3UlhkRFNo?=
 =?utf-8?B?ZEZwdVFrVUphemxUaHN6T0dPK2NkbTBYdGFOQ0FHdmkzZHdiZlRlMUh1S2ZK?=
 =?utf-8?B?VEkvRGhMVUdDMGtzS1lHVmZnNjhGcHFZdWFLTi9yQjV2VTBLWU9SeVFkUUpK?=
 =?utf-8?B?NGZ3eG1KYnRrRm5ubnFEWmhTdjAxVVcxVmlVUitrREdQd3creDVsMzRua3h2?=
 =?utf-8?B?QURMYndEUGtPOVhVVG5hWHNudFhNQ1hKQTMwRndkSFVKTy9aN0I5WHFHWEF1?=
 =?utf-8?B?YzlxcjM1cjlTeXVFNUFkMWNKTUtPeGZmanQ4WS80NmRlZVd1bURDS096UmdY?=
 =?utf-8?B?MEpnb2Q0Y1h0Vy8vR2NkQkdldm1nY0VVRUh2VERlUEtFbmpRU05OY0ErVk9N?=
 =?utf-8?B?b2xQL2kvbCtiMkplLzlJSkg4MnZVNzVUd283My91NlFHTit0eUdjY1BiNDVL?=
 =?utf-8?B?c050SnJOdHl0elcvOG1GUXdTMlRpckFwTERHRXhJdDY0SjZ2UkdrWU5jaktY?=
 =?utf-8?B?NEYycjN3T3M5aU5hb2xtT09GOEdiZW9PeEVSSlFuOFB0THI5Q1ZxaFZUZGRz?=
 =?utf-8?B?NlY2a1Z1RG12QXYvTDJJdHQ4Z0V6ZTBKaDJTUXpqakZBMlgwSXEwdUdrRjl5?=
 =?utf-8?B?Q2ZWTGF2QTBraXgzZnNtbmFyVkFTVFVnVWZiR083VnJsQUlTOUsxY010STJJ?=
 =?utf-8?B?TGhmTVB6bnIxNDVKd29Pd1RrNlYydmQwYlNTY1FIZkFkQWZEdlJ1cUtxT1Z2?=
 =?utf-8?B?SDcvNWNyTWZOQU0vUFNOQ3JDOGUwVUdCcFVIYVZJTDcrU2ZjVmRib2FCdElF?=
 =?utf-8?B?Vmc5c1ZZS2hDQ3JKRmNvTmpwelNpSUJ6SWYrY200ckJJYzVVcURKZ3NRTmh6?=
 =?utf-8?B?dWg4aHc5R0ZrMHcrQXo5NlBuMDBBRGZ5NVlwYjV1L0NGT0VCa2RuNzJFWnBM?=
 =?utf-8?B?MmZUNHhPQVFkdzJyR3ZtTUgwbkVyRlhvcFNxN29TQ3Q5RTI1RE5ZMWF0YndT?=
 =?utf-8?B?K3BTa1dtQVE2SGcwYVBmZWZwV1pCM2FzYmhlYnU4M2t6aXJQY0ZYYlE5OEc5?=
 =?utf-8?B?Qkg4NjNrL0REU0xYcHFoT04rZldWbHg3VnZqS0Z1NXQ0OGlOcE9zZURYUW1J?=
 =?utf-8?B?enE3UzFaUk5NR0VObHl1RGN4ZGE2RjZWb0N3Mmo1MklCVzk5Yk9ITkwzbURo?=
 =?utf-8?B?M3dCdjlzN1VDU2o4OFBNL3EyVkpHd0IzOTVyd0FRNjVTUmNvbktYZ2w3YUpk?=
 =?utf-8?B?aytzQ2FRWXFzWHlQajJ4ZEJCeWIvd2ZvYTJyeWVyaWZ6TlRWbmtHSXZ5Yk9z?=
 =?utf-8?B?bzQyblJNSjhRemtRNkVTR1N3bGxNQ28rRDJOYWZvNHByQ1F5OWdwT2JZRFUx?=
 =?utf-8?B?REJkNXg0YkNwbEVZR3BROGlWU2pkVHBpanI4anVvRndyRUw1SnBpdWY4cmtQ?=
 =?utf-8?B?QjdpeitTSS9QMEhBOTk1Sk5hWm01ZlRKdzlENmRVSVpLbXByZmpQTzI0ZGE2?=
 =?utf-8?B?bld1aUk2YWRJRG9QWnk4bGpXL0oxdFo3Rm5VaHBoeUJDdEZ5bkU2V1ZmM0Q3?=
 =?utf-8?B?RmtKeVFMV1dzZmZLQkZITFZIR0dJdlJTQytET0paNGYxZVF2NVkyVmRvbkta?=
 =?utf-8?B?TUhSQUZDSjIzZFVBNDRKMTZMQmxjQ2hnZmlyamdrcTVjanlteTVUZm53RXIz?=
 =?utf-8?B?ZThpUHYyWExQMlJFSGoxa21WQXBmcC8raWFodGJjanNqUmJWN3lHUEEvbHlN?=
 =?utf-8?B?WUEvekZYTjZ5OVlBb0U5NGZJUS93bmhzUUpuclhGZHdzaDdNWGovMU1jY0Na?=
 =?utf-8?Q?xIrM0rPSwPJcyuC9Ey?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04492244-a70a-4686-8305-08df40696e51
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:02:47.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95rvv94dE5Q+fvSFT8gn97tFjkKiA67EVJaHuPZu8o3NXVzxVHioVWx2zI5RRsQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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



On 10-Nov-26 12:59 AM, Alex Sierra wrote:
> A runtime compute partition switch updates the XCP mode and IMU
> partition without passing through GFX hw_fini and hw_init. The MEC,
> KCQs, and MES KIQ therefore remain programmed for the previous
> partition, including its cooperative mode.
> 
> Add optional pre_px_switch and post_px_switch hooks to amd_ip_funcs.
> amdgpu_xcp_pre_partition_switch runs the pre hooks while the old
> partition is still in place. amdgpu_xcp_post_partition_switch runs
> the post hooks after the new mode is committed and before KFD
> recreates queues. A failed switch also runs the post hooks, so each
> IP can undo whatever its pre hook stopped.
> 
> GFX v12.1 uses its regular per-XCC teardown in the pre hook. This
> disables KCQs, tears down MES KIQ, and disables the MEC compute
> pipes. Clear both MES rings and their writeback pointers before the
> switch so firmware cannot replay stale packets when it restarts.
> 
> The post hook runs the matching CP resume path, which enables MEC,
> initializes MES KIQ for the new cooperative mode, restores KCQs, and
> tests the compute rings. If the MES scheduler rings are not ready,
> the pre hook does nothing and the normal CP resume initializes the
> compute path.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c  | 70 ++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   | 54 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |  8 +++
>   drivers/gpu/drm/amd/include/amd_shared.h |  5 ++
>   5 files changed, 132 insertions(+), 6 deletions(-)
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
> index 9f4158e06e60..77d9782cf799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -213,6 +213,30 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
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
>   					      int mode)
>   {
> @@ -237,6 +261,19 @@ static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>   		else
>   			xcp_mgr->mode = curr_mode;
>   
> +		/*
> +		 * pre_px_switch may have stopped an IP. Each post_px_switch
> +		 * decides what to bring back for the mode settled above.
> +		 */
> +		{
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
> @@ -855,27 +892,48 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
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
> +	ret = amdgpu_xcp_run_px_switch(adev, false);

There is no need to run pre/post preparation when partition switch is 
done for the first time (unknown mode) or while coming out of a reset 
(IP blocks will be reinitialized). May add a flag to skip those two cases.

Thanks,
Lijo

> +	if (ret)
> +		return ret;
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
> +	ret = amdgpu_xcp_run_px_switch(adev, true);
> +	if (ret)
> +		return ret;
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

