Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D38E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 23:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF46110E407;
	Thu,  2 Jan 2025 23:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQXLGjgb";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5D310E407
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 23:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXDYC435JTeGqokTd92HxTXNbDV0MH2rTrhXUEGYX06CDNkhM1x4o77cbJxJb4ZPPRdTugmiwboscQUf/XsxXr8a7RKYF5hFZJ/IgL7Cg4V7A3valxVrigJDaZTBPGtuqvfGkeYXh+p0vc5VSmmwiBayM+B0gZ5FOQJu+RV9jI0EOmia/uH7MX5FRm7m3fBuP23ooJa0yQT3id5CvA2kPV/oxkaEChTw6vZcuZplRqYY0RnY0mpmswVNeSndiDMUMTaiAPOHVcb8tvTNG3AN1kGzSCLWqsw3zh1dl4hM3hwpvffdisYZjqdgefsjqUnYXVLQ3jgfR5HZaCEfoztl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFO49flU5ngFmIDikiyyr6EwHWpU3ZsGpnjuIZX0dSo=;
 b=OuKOmYzOzi4VQmPdU4kvAXEVEcCEJu4+Vy2oqS+lo4roElKphVdBX6cFuoe6zicF0IH0cbkfjS5SCzmEor3BQPA3AE7uR6nb+bZcgFQpe8btsiZxo6m0NMuzso3MMUPTKE0tKsPFkeSAZ2w//LUy6k3Jly93+ERKMHYm4BZ6iMAGH1JgZUuQn9k8WJMqpK5CmfUeinyEeKbMa5FR+w/hyX0fHvyMS8B6T8GeukMtsw7T2NN5UamBdagOVz9rCscrdXtKPDudsB7FpXeiSzOTes9Im6ZvVRr+L6SlfeL0cklv9rNPeYpoW8C+lR1iTeGMOwrLEf1N+J3JGH0bpp4FmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFO49flU5ngFmIDikiyyr6EwHWpU3ZsGpnjuIZX0dSo=;
 b=TQXLGjgbsuuxDVeETNpGfVBtSbNlirxa0zVzKnUqdfHg3ocVHSlwLsR0blVZ4XeGWRaf2JW9XsRKCH1NwhRZHKlG4rEUaxhXlsnJsZXln7PKyKt0PMFdQDO6Up493eGBfVdynZDKg8x4sJKivRO0gM+q0sSYteJJj0j4+x86rrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11; Thu, 2 Jan 2025 23:09:44 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 23:09:44 +0000
Message-ID: <0624a755-8e5e-42ca-a694-9be40bdfdcd6@amd.com>
Date: Thu, 2 Jan 2025 17:09:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <4cffa8720810823b92f1a3bb484da499bc0410f8.1735795671.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <4cffa8720810823b92f1a3bb484da499bc0410f8.1735795671.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:806:23::25) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c44f6a3-f6cd-4e37-44d6-08dd2b828bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3lHbzJMdUpjWkFjalhXeC92Y2s3c3dJK2VLcGR5cDNjTTZObUgwN0xlMTl3?=
 =?utf-8?B?cHVNc0t0bUVoR29saGlsK2c5Y1FTWkJaOTBzaS82a1lZVjVWdUNndEJRaUV5?=
 =?utf-8?B?STdZMWJVc2lVS3RBa0hLQm1OaFBGWCtMSWsrZnZDZEh6eXdOaHIyQkhTbnRJ?=
 =?utf-8?B?VWpOUm5aaHptVlFHUDBTRlZwMkREMFZaS2h2cUZ3NGR1eGxmc083YVV4TzBx?=
 =?utf-8?B?OHlWVW9ERGtOR3k5MlNZME5NYmR6a2l5d3Q5VHJTZFM4M2dTS1lxUy9SVG56?=
 =?utf-8?B?L1JOZDJ6aGZNL2VnV05WeEV0bmxMNmtDejJocWJIQkZBRTBTNHREWUp3c0p3?=
 =?utf-8?B?a2t1RHU2RTZJYTRIRGZQWHM3WjgzanFmdTR1Ylcvd2k1QUs3MWM1MkZNWFF3?=
 =?utf-8?B?bDNZTUJ0LzdNNzl2RWpldk45OUVDS3dzTDgxN2R1RzF0cW5pbWE5d1k1QzFx?=
 =?utf-8?B?RDMxcm5kTTRmcWJycGRHZ2gwbEMrR3NRaU9aYmF6U0pndFJyTVEvb1ZraVJl?=
 =?utf-8?B?cjkybEdtV000eDk4cjhTcWJ5UzRML2VINm16RVlQZ3hacXk0dGZlUmpyODdO?=
 =?utf-8?B?N1VtKzFXV1UrazZ2a3N3SVZ3bzlIRHpPTGQzNVlVakR5VXNnV2xVeHVNMlg1?=
 =?utf-8?B?WW1kZVRUK1F5czRJRk02MnExZUswWlFETFR1ZDRyMmV0SndxdW5lbjBtYThp?=
 =?utf-8?B?bnhOczBPK0FrdlpMMmxONVJ1ekhVdGM3TG01N3JBRUFJaEpqMEhtazNOTTAz?=
 =?utf-8?B?by9CeWRQbmJMdHRLY3d2L3E4RjZ6b0p4RFZENEV4eXNUTkJ2TzdON2NyakZs?=
 =?utf-8?B?anZaRndaNmUzeEFBa3lrWXYyK1Zjb1ZBS3NvQk9KR0pTU21JSU9SaEZhbW1P?=
 =?utf-8?B?SEkvQXM5QmdVUjJHOGtEclIrQUZoaHR5ZGQvbDV2MlVBc1NnYVBwV29vMitx?=
 =?utf-8?B?Uzc3dGs0bDlOMFpPaks3dzBkUGR0K3dhcU9lRVNLNHN3NzJpdEh2dkt4UDFx?=
 =?utf-8?B?VjJkL295cWdNNzVJUmJlVktKTTl2d2p4WStQRHlLbmVTUmExQVZ0RlgvL1Jl?=
 =?utf-8?B?Q1Z1YnpMM0dxblYzZTR5alJGdG1aSmJhRG1vYjhCc1RTU2VkSnlrK29Qd1cy?=
 =?utf-8?B?QkNCOXl4bDlTR0xQcVhPUml6Mjh3cnVwTVNmdlBweVNEaWhTc296WnE3a3dk?=
 =?utf-8?B?clJtRFVhYUlvZ29PWEJHWFpKYk90bVVtWktNYzB2WWsyNElZdEd5UGN4Uk9L?=
 =?utf-8?B?dW1mdVlEaUlNRDNHMHJab3ZrcHM4ZUtVYW02ZkgvNVlPQmpTaWJqZXlNeVRQ?=
 =?utf-8?B?NDVGd1FXWVUrY2UzWEs0NmJxZXM2NFZvWlJVdnZmekJXYlFud3ZaVXJqR3pQ?=
 =?utf-8?B?ejk4aXQ3NnFJc1dwVFVkYVd3WTRJakhtMnZtODdhNXRVSndoYVBNL2ZCd2xL?=
 =?utf-8?B?NXRHUGduVHhIU1pFbURoTmxhUXpERnNVMjljN2VWall6WFJwQ2I2Q1M2dElp?=
 =?utf-8?B?UGROcUp6TURYVTFWODZhbFpOdFRUZHcvS2piMnpDNzlQbGo0S2w1WDRDUHln?=
 =?utf-8?B?NlZYWFk4b1VuSTdOeWtRalZsSjcyV1J5TnFQd0g3eUU2RDZmakpQRHZsMXRD?=
 =?utf-8?B?ZC80MGJ3WHcvTjRML2N4SmM0YUI4c1NaZzFNZk13ZjBDV0QwaWtnVTNUaDk4?=
 =?utf-8?B?NVhnMjZuaGZUdHcxM0tqcWdaVXZRK3NZUFUrSGZNOFlWODJGSzI2d2FBTG5E?=
 =?utf-8?B?RWVPQjR2VkdZQUFSTUhJZXhQSGsweEFQcXFCanZDakNma1ZRUVVvSzREVEZx?=
 =?utf-8?B?c2UzVjhvWXEwQnpRRjBDclQ5OTVMbkhLVTBLam5ZcmppaHFYVjZTWUlNWm5N?=
 =?utf-8?Q?m9XTicI5J0A5w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBzNTljRUV4ZTFVcStMZlRWOUZQMVEzWk0reURFdjIzbU5kTTBYZ0NNakhr?=
 =?utf-8?B?NVZRQW9kb3pxNitYay9nVzJrYU9QVjIyZ3FHUVNxa1h6Q0RLMkJMUnF6Zy9w?=
 =?utf-8?B?VkgrcWJIYmx0eFF5c2kvb2k0OENPR2R6UlpicTVoTjRSV1o2SlM3M3ZaZElH?=
 =?utf-8?B?TTloYmRlRmZTeFRWQkMxQW9MSWtiOFlacTVsNkJGd3ZXdjBHcDNMbUpNU05o?=
 =?utf-8?B?SnA0NjdIY3RxWWFNMjI4SzlObkt4L2hIc3huK2tFeGJHdGUyWi9ZSWJJU0I1?=
 =?utf-8?B?R2RPd0E4OHBETUMyNUF6TWtNamd4clFrZGhUVTdDdG5JaTREeW1WdGhqK0Jp?=
 =?utf-8?B?V1ZDdjF2b2VoOVlLSU0wVXJCaGFMQ2QwblFzVFJWdzJSektva2lPRklMbW04?=
 =?utf-8?B?bUZSVU8wUkZnRUxvSDJnZ2RyZyt0bTgxR3A1cVUwR2lSdVZUeEQrV3hlbzFq?=
 =?utf-8?B?d3NJek9rNmhYeXM3Uk9IMEdMRmVBUHY4Wm9tMEw2N3FGZjVFZWJaeXk5NVV4?=
 =?utf-8?B?UFdtdzdBUnN6VmhCL3FtTk5OM09XNlZoR3d6QjJac0FBOHZQc1pCZWN1aHN4?=
 =?utf-8?B?U1pnMmtwZ1ZwaDV4QklsaitJNlplUW91MkV3eldBTkh2NVpET0ZGVHRoQnRi?=
 =?utf-8?B?VlpvRkswRlplNEVhK0N1T3NoYzg4SEowY0ZWWkZnS1kwN2UwWVN1TnJuR1F6?=
 =?utf-8?B?UjU2K2FWK040ZWhFWkpjdzZScktCS0t5Wk9QY1RycERPbEkvME5FdW9tbVZG?=
 =?utf-8?B?aWlqczJsOWhFK2pma21OMEN2dTdvRHVZQ0R2c2VPN0NxSVM4ellySW9jM2xL?=
 =?utf-8?B?LytQUlBvbTgzQnFYR0hVVlN3cUhBcDM1MEJlRmNGQTBjRG1uVk52eFRHVm15?=
 =?utf-8?B?NHJ1RS9aTXhSRzFTelZHZ2kwclRtVWI3ZXdNV3NOOStnMnVhZFZUeUZnSWVN?=
 =?utf-8?B?bFZtSlkrUFdvNkY1eUxBRUJTSTFSQis3UTFHMVliZk5nY3B5VnZoSHcyZzNl?=
 =?utf-8?B?eTROcXBITHVlSWxlMDRxazlzY1FmQy8wNzQwdlRlUmE2TUZSMDF6dEJNV3J5?=
 =?utf-8?B?SDZPT1BaTzErVFJxcTNhSXozalRxWi9MRHhUTTB6M1Rnby9lbmRTZUNDclBT?=
 =?utf-8?B?RmJvdm1Rb2hKUWluOGd3aTkralFqdGNQRXpaaTl1UEFuUUpYdzRTZEw5UGI4?=
 =?utf-8?B?M0I1cXpXcnFzMVl5TlBvdmFDRnJUREVRZHRMaEhFekM1dTNVdzdCSldvdEt2?=
 =?utf-8?B?T29SK01OdVhWZGg0Yk5zbXBRbFFWTWlncTdBT1U4MTJtalEwL1d6R0tlMFgr?=
 =?utf-8?B?R2ptZFBXRUVSVjRqOWhYZUs3UnBJM29ITkx3b3R4Y2MwVVh4SlZKbk1ObGRN?=
 =?utf-8?B?Vzh0VmZYT21qdU9oZzdaamZXUE4yUXlOeWY1SSttcjliWjUrWFpaRWxzWi9I?=
 =?utf-8?B?YVRxK2ljUldheExBZTlIVUdvK0MvRVNTWksvL2FZWkdPS3BDOGhXa2pUMlNh?=
 =?utf-8?B?VTlKMW1RQlJRRTBJdlBlSFkxS2cvd2RVclFNazY2NUJ3NWF6WTkrcnFoVVBx?=
 =?utf-8?B?c0F2SGU4OGZyZ2tTRHl0bTVwcFF3Y1ZtVkdQV1paS25ud05xYjFSVzRvbmp4?=
 =?utf-8?B?eEJBb1BQd2UxZi9wNnRpQmdXaCtmRklKbjJRVDVhTXNlNHBkeUZpN0lmeTVy?=
 =?utf-8?B?K2MxN0tSaEQ1KzJVSW1nMzFwdVdpalV2MkRiMzBHWnpJNzY5aWJMZFp0cnFY?=
 =?utf-8?B?WWExM25mSzE0bVpOWkhHcmU4cjBRSXhkaDJuM2d4cno1L3ZrL2lDSlpvdHl4?=
 =?utf-8?B?dU40RCszZVNSNFRuUlkvczk2WnUwOUxNK0JQVVJ4UGJPWUtTZjcyMzFGa3FZ?=
 =?utf-8?B?aEl0bGRybkc1YVBHcVhmeEtEcHRrUGJrcXhpYTdJOHp4clc0WFI1MU5MU2lo?=
 =?utf-8?B?VXA5MnEycWRjMXJqT2ZiWXZoL0dQUEw1K2ZXTk1xVVkvRXRNMzN2djBtYlRm?=
 =?utf-8?B?Tng0SU01VzlHTzEwNUdJdDNIaTJZSmFyYmhEQVM1K2xSNm5Ndk1yNXY0Yyts?=
 =?utf-8?B?OGMyM2NkbGFYNlRiK1BJc0VRNkpQc2NQeUUvYlJXZHpiNzV3aU9SRllCNEV2?=
 =?utf-8?Q?Ibbw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c44f6a3-f6cd-4e37-44d6-08dd2b828bac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 23:09:44.6671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhJhzziI7WKt9/whw0UadzxgGcIXHiwOfkZ0B33HtWXNeTU1P5EMLLLyggdwOx+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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


On 1/1/2025 11:36 PM, Jiang Liu wrote:
> Function detects initialization status by checking sched->ops, so set
> sched->ops to non-NULL just before return in function drm_sched_init()
> to avoid possible invalid memory access on error recover path.
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 5adab4b3386c..ce2afdfc0158 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1331,6 +1331,8 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	if (sched->own_submit_wq)
>   		destroy_workqueue(sched->submit_wq);
>   	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", __func__);
> +	// amdgpu_fence_driver_sw_fini() checks sched->ops for status.
> +	sched->ops = NULL;

Instead change drm/scheduler how about change amdgpu driver? At 
amdgpu_device_init_schedulers if drm_sched_init fail for a ring 
scheduler set

ring->sched->op = NULL;

It is not drm issue. If drm's scheduler init fail its operation has no 
meaning, we can set it to null at amdgpu driver.

Regards

Xiaogang

>   	return -ENOMEM;
>   }
>   EXPORT_SYMBOL(drm_sched_init);
> @@ -1375,6 +1377,7 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>   	sched->ready = false;
>   	kfree(sched->sched_rq);
>   	sched->sched_rq = NULL;
> +	sched->ops = NULL;
>   }
>   EXPORT_SYMBOL(drm_sched_fini);
>   
