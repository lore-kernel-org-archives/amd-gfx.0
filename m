Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40833CA0EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 11:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D641210E430;
	Mon, 18 Aug 2025 11:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxMGdQSc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785F510E430
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 11:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB0tG1EKqtczd/LcPJhkll8+PIVi+1MRthgo3pr8tuXwPz8VI59VIjUkLGUiVkpO4BxJGLbj5ikttfj7lx/Hv0CFFYAq7tbfAe3m1NEKtY1KykpJsX/tRCgqa+DKfzrB+tOHa/IXtZVNRe9LEPR+I/OEb4lyx6NOfGRZUDLqHgeIUxthGxliljW+gSYpFY7azQqOooejKkCjCC/Dk+eaVBzjupBPcMhZFwLu6BHnAa7/HgHBj6nhebYM5Nb13WZNDifdlYLN00Iu2HOnMc4h4q+bpnEAGARNJNW+4gWnHP8UmYL8v0rSDnjxY0HAhfNf/tzYbCzPtNqlHt4FCAVG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot5hHM7OUbC64I21kii71MJySnlH8mRDF6Gm2redNvM=;
 b=Oh8O/vhYou0bAZ8rPsRiT0b+lrMekVvP8T0e5aw73TAX1pqQlGLHA5NLWM90qw8nkRBK7AP8b77yUbfTLyMq5U4VS4+h34VQ7A414CgROK9FQs/qlRKWYxmdSe0+ImAdRYtisfOJ7gj6sH7037RgUQJtpUHnx0Fj+n1qEahPSpTfeAJwKti9qPKAuZ5KwYVWcglWf8r2mj8nt6/Z87oUpZKZlq/dNU7ThGIXh3G88nROH5eDgXLKGp0/LgiuB5oX3Z6Yvww6LlKjEIuX3+2cx1ql9wZRAn/FNRuatTvihq4yzmB9KAlCuPWsyOpaVOTuLrV4UxNkPYy4JHhck4sBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot5hHM7OUbC64I21kii71MJySnlH8mRDF6Gm2redNvM=;
 b=NxMGdQSc9OrU+roNtb6IcERdbHX2Rg3QtHpFoHWGOsWhAeWxqID+h1G9BAEy2FZUiQlZzrv4Z4LFzPttSdKGIVL3WwN6OZiwpbdHnb1PjFg5AoqOUNW8Ph1GfU+oucdyJ3P4BBdHqiXyet2Z+DZbeBrnUau0vkse60o6Otijhhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 11:17:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:17:16 +0000
Message-ID: <2a4603bb-caa1-4762-ae8e-347617d2b10f@amd.com>
Date: Mon, 18 Aug 2025 13:17:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/vcn: Ensure that sysfs reset run in the
 fini
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-4-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250816162806.1301791-4-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: a64aa6b1-e4c4-4f99-e20e-08ddde48ca03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVhrNlhydXVOeGxqZCt5Tk5KdEErNWtDalhQelB6R3NOWis3SjArSVRNSUlO?=
 =?utf-8?B?cXF6emduU1haVlBDa1dUOEZNNTdwVnVKUWdING1OR0I4UVVTcVZYa3NnOW5L?=
 =?utf-8?B?VkFYTEZ3ek1ZRWJSL0xLT0hFd0p0RXRkRjZBS1FVUnRqdjlPLzNOeEpsN0Zv?=
 =?utf-8?B?T0hOWkJDdDEzYnorOEFDdHZGZFBRNHovVlEvLzlzZ2FHOUdZTXhYQ29DOXpW?=
 =?utf-8?B?SGlEUENoOGcrcytOczMvTUZRdHpYWld6VjdacVpqbnhRMmxDWHA0QzlBa3NT?=
 =?utf-8?B?WUVYcGdrRlU0bXBXaDVXd1p2b0FBY3ZGVTZzL3d4anB1RjFxWGd1VnJLQURk?=
 =?utf-8?B?aStueExCdlFBc3grcGd3MVRZb0VWN0tadUdVSzFBOWY4Vys3UktsditJVUFz?=
 =?utf-8?B?MmdqUjVHUVlWUXhYR1lzTlJjbTFndVhqYlA0WHVCNk00SkNCSnFud0xWellp?=
 =?utf-8?B?NWxvSmNMdDg4S0ZNWnN3OUs5dUJzdDFSR0wyVlE4TERDeDhsQi9qSFlTRTZn?=
 =?utf-8?B?ZWYxdm0zd1ZZTkZMdTRnOElZdHl4cDVpVHhOWUlHdkRJMEZBc2I5Ri93M3l4?=
 =?utf-8?B?WUtSWk50THE4ZzI5blU3RzV3aXJTelNIcTZnNHZEUlNqd0w1eDdiWEVlMzBL?=
 =?utf-8?B?dXhoeUMwMHNZL0VXRDVzUzNGUnZWMk1EUjBwMlNVYkRxRnNFaTgzUnEzUmV0?=
 =?utf-8?B?bDZWemIxb3g1cHRaVVFKeEVwRGZmcEZqNVNQMEdHNjFuU0RqUWZEVUdUSVdK?=
 =?utf-8?B?RHh5aXgvTWRmZGZnUld5NGVJa05rVDBHc1BtR1Bkbmt4dHlJTWNURFA4VW9V?=
 =?utf-8?B?SFEvQ0dRdzluZldtNjI4L2hNeFVQTVR4a0JUS24xWlhjNmRxQ1dGSDA2TmJy?=
 =?utf-8?B?cFVORWtOcDUxZXRZUzVFUDFBM3c4OHdVWnM0YkpnamxnWVNGQUhraEVWNWxZ?=
 =?utf-8?B?N1RBRHkwUEd5OTVYSWdRZGtxaEFlRmpoTEQ5dktPZnhYdEt3OFo3ZmU2bnBV?=
 =?utf-8?B?eXVpYkZLUmRVRGdDL29pbnJNajNReUJUaEVQdXkwSEJJNkdoTGdhUTl1NGxl?=
 =?utf-8?B?N0tkK1RlODV0MklOeHdRTkxna1ZKWTR5L1c3MkxmS1B5WWFjb0xmcG5STVJy?=
 =?utf-8?B?dG03Qkw1UnBqclh0cStGMDB2ZXJzMHRKaFRqMnlFSFE5VVVtWVovWTZnOWxx?=
 =?utf-8?B?ZEJXd2psUXFmYWY0N0tEaE9EaGQ2VTdaVXhkZVJId0RPZkE5RlZ1OTBPZE8w?=
 =?utf-8?B?bFVPT1g5NitqMVdzSkE0aTJJMlJFWWlIdG10QS8xWmcvQzRNZEtpaHA1eUl4?=
 =?utf-8?B?SU5lK3cyYUtOL1hkSzBqVEthRVFSSVd3RjBTbnBmZVpMcGY3Z0xucFRGZ25a?=
 =?utf-8?B?bml3M3JVdm9ORkMrOHpnRWtvMHRLRDZpSnUzTWozamRSN01DYzErYXAvbldW?=
 =?utf-8?B?RVBXWC9abU5ZZ2RtK0NsTmVLRFdQUjlXNHQ1QW9wWmE5ek01THNzSlU3Nmp3?=
 =?utf-8?B?aXlLaEkxSHI1NEc3QmtkOFpDbXBFaHpFT1ZKbkZzS3I3d1EyUkE0bjhRa1ow?=
 =?utf-8?B?eFZjQkRuSVFQTXBvYWYraTZwL1EyMEdneTlYZFZDUHZhQkRqVmlvTDJwdktF?=
 =?utf-8?B?Yzd5V2ZTK1NCVytMZUhuY254QmRWSldJZGsyV05KaFl0MHppQUZhZkhDZzBK?=
 =?utf-8?B?RUgweUlrTk5DbzlTY3ZmWjlBOVlhOXZYSElTZkVCd05rd2JUczFPTzVNL0tD?=
 =?utf-8?B?M0RKRGdZSVpxYy9jMkNyTCtGK2tGZm1KbFpiWFR4TWFwSkNGeHhBOHRLVFVU?=
 =?utf-8?B?bEZNKzhUVGU5ZS94M2V4OGFjejM1R2NwYnJheXhXQU56UHdtdGV1U3BiSkJm?=
 =?utf-8?B?cHhDWUlHU3pqbFB6aDBGbzFicHZnaFFtUW9DUXU0RFRqdnNpdm5iMm9tMHo2?=
 =?utf-8?Q?SbCC/S1hjbs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JNZDVXM2o4d3k4b1NLbVBmcnZvOGpadmNZRUZ2b2swMGVKS2hIaTh5YjBG?=
 =?utf-8?B?ZmZGWnFsODVmSUg4bXlURDRJK3piMFo4V0FSQ2ZMdnhyS1hHYmNPWFhXL3hD?=
 =?utf-8?B?bkdWMGFuVFBqTmZvclBOQ1pOYm5yN3pmNEVyY0xaNllFTmtydXB0L3lVVlh4?=
 =?utf-8?B?UDJHM3kzajFzb01tSTAvVzlWVjdTbEplNEtvcFVHODhoZWx0T2hhZnF4dlcz?=
 =?utf-8?B?NURhdDk3S3hBK3IxUkhkNVJrZ3hJK3Vja2Y5VXBjSEt3Rm1jZStsSXAwa1Uw?=
 =?utf-8?B?TWo4YWFNak0xaGtLdWgyT1ZQYlB0TFJ5RXozOWhPbWxrendRQkRYdzBBSE9L?=
 =?utf-8?B?cjRmakI2SE9LaWhXQTBBMks2cUtMRUtwYnpWUmxvUUxGeGtCQklOdHRaS2lZ?=
 =?utf-8?B?SkhOSUpaRE4rdktXVzlQclo2aTRnTWhGNVpVaFJxaE5zTThYSDgwSDBRdjBt?=
 =?utf-8?B?bnJrR3dJdG5rNjJKaDN2VU0vd2lJSWNoa0FZamVHc1ZKOTRmSDA4TlVWOGhk?=
 =?utf-8?B?YkE2R2trSjlmSU5vKyt4dHUvYW51S25aTURuZGhLRS9GcGlJUm5PcWxPOHNt?=
 =?utf-8?B?aUlvZE1IL0tJMklGczFmTC9Lb0hSMzhrUFBSbmNJOWRMRUwyb0pVNFhuUFdW?=
 =?utf-8?B?aGlsd1krTDhLRTFwZWZiNmNRZUdUOWpCK1dIaTR0S214aXdiR1p5VHE5Rkpk?=
 =?utf-8?B?MlpDdC9Ua1RMWkpGeXZ6U2VFaXNYMUJXN1lNbFdRaWwwRXd2M3ExRDN1Yzl3?=
 =?utf-8?B?WWFqRW9zcTZIVmloTVpiZDBadjZ5a2hwTGo2K05vWUx6K2Y5OFRhSlRKRkZH?=
 =?utf-8?B?WkFDTzZTaUs0Sm9TSFlIRGxIaG9nVFk5MVltN2ZVSmsyMmVCcjlWQnBwWlhu?=
 =?utf-8?B?RGdwcjNMelhKVXBKaFBuRzByMkE4NEFaUm5xZDNEVkJJaFlFR2Z0b1E4NE9V?=
 =?utf-8?B?ZWtJclFXMzRqM25pdFJrNnlCY0dma255MGNiQjhDMGE0NllKZDl1cUZQSXkw?=
 =?utf-8?B?NVN5T3J5L08zZXM2bjFCVmtMZXBnQ0xIZ0xndlc0cjh5MENxa0I3L0xpZ2NQ?=
 =?utf-8?B?V1dNL0pub1MvQkYwMStGUzhhdnFEMHB5d2w1NFZTMVM2SHpCL3dlVDlCenhM?=
 =?utf-8?B?SUErM0laSHBEWXZZc2k4bjFsK2tkU2R3VTdtQ3dOYnlGOEIyNGl1NGpsNFRQ?=
 =?utf-8?B?bm9EdkM5d2EvbFNPcmk1d3oySXZndlVlTmxZK252TkE4K01PM2RsWGRiRi9M?=
 =?utf-8?B?b0VUYnBPWjlLYjBpdWNKNzZQZkNHVEhjUzJZY0hkVGZTckd2aC8rN21USFFI?=
 =?utf-8?B?SEpKSmhJZHBSNFRDcEJ5c3h1VVVVOVNlR2RuSHVwTWlKN2QrMDE2M2haWUhr?=
 =?utf-8?B?anhTZ25Yb1VVcXE1cmg1V0Z0TWV4NFZKMHMyeGJlRXlJVWtRSC9zV25seUFC?=
 =?utf-8?B?c1JXYk9SRWdPdnZESHhTb3lIQ2MyOEl5bGpSb1pJcDhWNGJqMTRVNGN1aEFt?=
 =?utf-8?B?MzhUMG5acWRWVjFOWUxNNFJMYUpsMzE5dUtXTW9hNWdQZGVrNzJMMnBlNXRD?=
 =?utf-8?B?elo2amFBYUZPU2JHQXVUNmx1dUNyeTAxa05nTTJFbUUzdXZhalRUZk43WTk3?=
 =?utf-8?B?ZElRVXNCMzFndEhuNFMySzFJdkpDZWxNRVhGajE4WlBnM00zN1M3eTRqWG9v?=
 =?utf-8?B?MFF0VStpZXVRMlV6cWtFaWZxREhBZlpxVjJ2dHhJazFBay9vUlorWWJ0M3N1?=
 =?utf-8?B?UWJvYmVRV3Q1dmNnV0V6SmJIN3QzTGFVM2pmMitJckFGRFpPWUltUjBSUlQ2?=
 =?utf-8?B?MnhDcnM3OURKOWE3SlhpNURpTUJuS3dKQTg3dDR6RGdxV0EzYTVxK1FWaWVT?=
 =?utf-8?B?MTRra095OVNFR0I5bkZ6QmllNWxmRktDdUFreDRxMDBZWmNHd3dJcEVsb0VQ?=
 =?utf-8?B?Qk00ZnF6SDR0dVRsRzgzTDFlL2MrMVNMT1BHcnlybTBxaHJLWkhGYTM2Y0c1?=
 =?utf-8?B?SFo0eWRKQ2RJajR2Ukk3elFCTEdjK3o1bUd3YkRmbHNabUlOQUxIdHdiZ2k1?=
 =?utf-8?B?NU5JMTRkWEgwUWtJVkpRU2tBU2lGeWJLSlNka0Iwd3dPNmtRbDVXMHhSSkdV?=
 =?utf-8?Q?rFlnuHKTwTQGRlIqAqislgufK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64aa6b1-e4c4-4f99-e20e-08ddde48ca03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:17:16.7284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx6y57mQMQ/L0AaBF0TlLgZQf+AbzR+0x/1/OpCOveR3/6qfx3imY/Va/qsfOmGN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

On 16.08.25 18:27, Rodrigo Siqueira wrote:
> The function amdgpu_vcn_sysfs_reset_mask_fini() in the
> vcn_v5_0_1_sw_fini() is invoked at the end of the function, after
> amdgpu_vcn_sw_fini(). This can be a problem if amdgpu_vcn_sw_fini()
> returns early, since the VCN reset sysfs interface will not be removed.
> This commit addresses the issue by moving
> amdgpu_vcn_sysfs_reset_mask_fini() above amdgpu_vcn_sw_fini(), aligning
> the fini code with vcn_v4_0_3_sw_fini().
> 
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 7cb21e2b4eb0..3b7372861032 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -245,14 +245,14 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>  			return r;
>  	}
>  
> +	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  		r = amdgpu_vcn_sw_fini(adev, i);
>  		if (r)
>  			return r;
>  	}
>  
> -	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> -
>  	return 0;
>  }
>  

