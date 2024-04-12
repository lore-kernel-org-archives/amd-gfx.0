Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA25C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 04:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA4E10E12E;
	Fri, 12 Apr 2024 04:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkUMBBP8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2219D10E12E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 04:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC3woE0GS33oVvCOgKkkih09zxG6vfudD6eheizsACjLEZ7Q1TMNJF1XtgieGAbKK8WGbpE8DtbW0WMMO0/IIIwwQw4v9kjbDkGlhPlW3egVnsZhtCjcnta6agSboKd6DNRv8zSq6xRpBTJkD16vKb3ZIf7TMGu8CGWQL5sxBys8ANS6ZeQ3h07k4aumNm4nCFodHr8iJP5zQhoOp1nR7Drh/SQXAv/BiEMUjIcGh8Av2OHLRvtS115CGwYW/P+m+RF5UowsqQtCaEyYkzEuXcWPIja+vdHKWJdBHcXDoYO9t6tU3I29m4eMpW9wLLsITVUhPxNUK6t7Jb4fL2m6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A5ZpRacspREs8lGp0C0P+h1VhewXawKm+rbY09yVgc=;
 b=CGPitqOYRZOI859nCnh12SUtx9rF7PI8UcFA0ta6FpUy+up8iL/10NAxTQZ5EzTKvOBxq5HApIJhE5V00zM4fGvwtZSN6H3ll2GqI55LE4/IArmJrMg8ChggX5mBeXHPqhlmwM850H7mdu2fEfSQ4FVQIHbrXx91l60UMPBQXjbWV7XcaI3kP97tUQmsKQrK/6bbFH8hlOoiTpmr4mb+d1C8GCOdMLrA3cIGX80vMWkTZlTFuMiX80POZ8wbghJroC8kBcjpDrCJ5BRf+AF/imygOKewtkTRrNhy4ljizyVJByTECBlcumt0twU2/EZUxPO3+YmTFApSoN5UBKX7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A5ZpRacspREs8lGp0C0P+h1VhewXawKm+rbY09yVgc=;
 b=MkUMBBP8o9ONmf5JH2IrPVfPa6n1jtHzlLcu80JL0IVSnm5r7guH9ljHx4Cb0hT391mNwKDG1G5CSAXgYwf5s2UN9/MpjfuLbntAEAWZC3NeUuVEKgmMjJ2hESMLPq9HCddFo5VaS2J+iD+kNL4o2w3fBD3e+0FIuQ50uVQFL2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 04:40:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 04:40:38 +0000
Message-ID: <f283f7e1-ef59-482a-8c5a-364ecc6d6706@amd.com>
Date: Fri, 12 Apr 2024 10:10:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx11: properly handle regGRBM_GFX_CNTL in
 soft reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240408172025.5848-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240408172025.5848-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 613a48d3-f4b4-44e8-abbb-08dc5aaab351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLiqsc7T/k8bfvvoSKLbDBsWbjAuAdaowzbD8z82qIKYwnFsW+Shdhq3YSJeztlDqp24DZYfntPyfldG1mMdJ0wXvvcT0IXvJhmufUwe+EyBqs9FXVDo+UZSU9qp0Mxkp2qOFg2WzacthuG3g4+k+c92NjczT8fIi1zkg6KRaQ7/J77Dt+/1NjM2dtEpZ3mWaDfHHQR5lYt0+YhMNTVRpev53KxDfkzZFSqxmRvxeFzW39+t2ZfTwGFJS2MiX15YxEnGYxZTqW54YF1KqeULICoIXzsStlLMVqd31mwqIEGDTl0Qn2JEKRXD90Un9MfkDU1/5uJkobj7UM7oHAL8MzZ8JxljqgGOuR4BzCTJaJZQbaJosZRy1uXc9dyz/85yH9lNYZfwY0ouASivlOKzsjiDw5xz8NzHaL75v4Lr9Ejvyl0KPRGpzT/VA6BZkjX0qLkO+kO5UxEdtdwyuTPqBok0f6A3GGjdsrn1ztJZL70rSNwSN2YN6+ss2fimnl5jbS225+hMej1KAXKaR1B+c3I8hYwO/zeQ4dsGPeAoNmR1QE7+ECgBzHZ4UwT/unskzs/0741GvqYS0DqtOx3ijJefNa7O6GPT5RFjTs3n7vT+Bb5HHYEKfzMGY/bPbAg87PW8npMODPnI38eWzf2R2Wq2+Pu7R9i9W3WQaxu+gIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndQT0NZemoySHhPeVRVTEp2ajNyNzF0U2xCakIyMGY4TmxjK0lxVHF1NEYw?=
 =?utf-8?B?VFR4aWgwY2ViWWlKWnlVc1JZWktrR0FKbEhsSENFenlXSElnTnYvLzA0RE5q?=
 =?utf-8?B?WWxTcUErZTk0a1ZsV0hmaHd4d1dFbkFpSld4TjJ0T1VaaHQvMjNIWmpWby96?=
 =?utf-8?B?T1l2aFA1RHVsWHc0eGpxNFBDQlJTVzFpak9nSjYvb0c5U2lTbTZvVmlGeE9v?=
 =?utf-8?B?NXY1amF3NXpHZ0Rvd1V1NitJa1EwalNpL0t2eENYSHFqZGhJOEROWlBYeXht?=
 =?utf-8?B?M3FoeVNZaDVzNy9WSEtLQ3ZtZFZDVGRxUk51cy91QkhvTDBTN3NvZlpmUW5G?=
 =?utf-8?B?aGM2WVZGalFheDZkYVpVVy81cW9jblloWVNSQ1h0MzM2aTgzSEl3TWh0UDlh?=
 =?utf-8?B?TW5hVXpuSDlIUnBORHBOYkNJU04xU3NNSTlkaGVOWDlEWWgvZ2RQN1VkeUl4?=
 =?utf-8?B?N3Bra05KSVdKRllINVYzRytpY3ZHVWk0YTRsclZyam96VURVQ2M1VzIwaWZn?=
 =?utf-8?B?NGxOUllhWnkwanZkSmp5OUtHNVdZNzhzVHBiSFVublovWEtKdW5CdGdqZlo5?=
 =?utf-8?B?UGJacHJQbDhvRjNxdmRjYTMvcFhKZG9QQlRsM0V3UllvamNUMHIxaTRrYXRz?=
 =?utf-8?B?RjdiM09HZFQ2dkl1SW1KTzIyRHpvdmFFTDV4Y3FiMVQ2OCswcDVXQU9aYkJ5?=
 =?utf-8?B?cm5yQjhEMTc4RE1ySEUzOGFLeWJobUh6Q0ljWWNhcVRMZEJvajNmMmtJRHJv?=
 =?utf-8?B?QWR4K3lZZGkybkpBcmZueUR6Z045UUU0MXhYSDIwMmNkNjNnOWlYWnJaWFNO?=
 =?utf-8?B?SWRLbjNTcENRQzVnSEZONjBRMzdyM3VKWW81NHJwQ3FVQU9Jd2x5Zjk1cU9E?=
 =?utf-8?B?YjBuSy9mWlQxb1lTMGRBMVBYVzZRcFVPZFA0bUlNM2kwSUtrcHllMWx4MG1M?=
 =?utf-8?B?enhBaE1nVkxrSVA2YXpERGV3dlN2eVV0YkpGZjhYR3QxY1ZPSnkrcy8wNWxB?=
 =?utf-8?B?d2Z6cmhyMkM0MXYzZE03eGh1YU1hdC9vM3RMc2xUb0dkQzRRUUFsMWFPbWZi?=
 =?utf-8?B?RHN3TGEyaGMraHlFWXBsT0ZMK08xdUhiZnBCdVZ6QTVESFp6Tlp3ei9PMis3?=
 =?utf-8?B?UktiYUNEZUlhS0lTL2EvWVc4dkxoVlFha0dqSDAvRVl6ZmVHcEdxN3FwVWp1?=
 =?utf-8?B?RXFLbUNDak13MmJsbVpCejM5dU1NbVN5U1ZnQnZnVHVCRVcySVZEakU1bHVa?=
 =?utf-8?B?Q0xJNVY0YTgwekJ5b2R6TWs3aU9zdGZNdysrMHd3R2M5bVExZUk1UmZRck03?=
 =?utf-8?B?TVVyanhZbkM3SDh6Q2ZQR1ZLYXV1b0hGVmtwZmlpSTBBNHBtUHdHMlNWS0Q2?=
 =?utf-8?B?c1lDWFFPSlRVVXFNejlLUW9CVjRJd0tvdXk3NmdZd2lOb2ZtZlRicTU4TEdj?=
 =?utf-8?B?MUd0NU8wTUYyVUsvTXRlbFgxbmprZ1dTQ3dacTZ6NXhkdlYyWmN2ZzRxU1Rj?=
 =?utf-8?B?Z3hrTWlNWCs1cExFYUJ3eUdCbGRoTytPa2ZwNEVDb1VnMUNmb1VtNkpKUUcx?=
 =?utf-8?B?NGhma01IdWNVTHE2cUVRTTNJVFQ5d3U5aitYa0dkQVFBaTFkSFVDeHp3MTQy?=
 =?utf-8?B?OWxMSnBNZ2pEWUhoMlZmNkpZM2tnSWZhbEFGTFcwdS9MQWFwOFdYa3JkK1Zy?=
 =?utf-8?B?WUMyQ0s2VnVyWURhZ3JZdG9XS0s0RWtETXVlRjhQNzVUdFhmcWhyZ09rUmE5?=
 =?utf-8?B?TktGWGtBWHc4VVJidzhMS3pTOG1IdWlSd2h2RjNwanFESVRHV0VkRk5nTzI5?=
 =?utf-8?B?ZnpvRWc2ZlpVSEJtSzMvWmlpT3RnNHVnb3dZWGZmL0ZSRjF4Q2YrYjF6SEQv?=
 =?utf-8?B?cjJCeDVaV1ZKdUdVQVU5MFZJamkyWWdBMkZUNG0zSFhsVzZZWlF2L2tFSGFa?=
 =?utf-8?B?anhXTkhnOUNDOTUwbkwwSUYzRjMza1ArMlRaTnlWdU8ydGhrNzlsajF1SmN5?=
 =?utf-8?B?NGpsSHZXTDJoYXBnT3NMbE5PY1VhMlE5NHRPcktNYnpOVkI2VkVDcVVYV3lk?=
 =?utf-8?B?d0ZPZEpzRXpoSERaM2VnMFUwWjZKanZvR05MbU9ORDluTW1iZlM4Vmt1Zzdj?=
 =?utf-8?Q?d9Fn8K8rby9r1BBaaosHnDLQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613a48d3-f4b4-44e8-abbb-08dc5aaab351
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 04:40:38.2518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1U22SEz349zH4r7Kii2/mR3N0kztw46MRyMWGow85zSdnMtOntSb7eJ1tBsmm/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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



On 4/8/2024 10:50 PM, Alex Deucher wrote:
> Need to take the srbm_mutex and while we are here, use the
> helper function soc21_grbm_select();
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7a906318e4519..dc9c0f67607b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4506,14 +4506,11 @@ static int gfx_v11_0_soft_reset(void *handle)
>  
>  	gfx_v11_0_set_safe_mode(adev, 0);
>  
> +	mutex_lock(&adev->srbm_mutex);
>  	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>  		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
>  			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				tmp = RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
> -				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, MEID, i);
> -				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, QUEUEID, j);
> -				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, k);
> -				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
> +				soc21_grbm_select(adev, i, k, j, 0);
>  
>  				WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
>  				WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
> @@ -4523,16 +4520,14 @@ static int gfx_v11_0_soft_reset(void *handle)
>  	for (i = 0; i < adev->gfx.me.num_me; ++i) {
>  		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
>  			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> -				tmp = RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
> -				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, MEID, i);
> -				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, QUEUEID, j);
> -				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, k);
> -				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
> +				soc21_grbm_select(adev, i, k, j, 0);
>  
>  				WREG32_SOC15(GC, 0, regCP_GFX_HQD_DEQUEUE_REQUEST, 0x1);
>  			}
>  		}
>  	}
> +	soc21_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
>  
>  	/* Try to acquire the gfx mutex before access to CP_VMID_RESET */
>  	r = gfx_v11_0_request_gfx_index_mutex(adev, 1);
