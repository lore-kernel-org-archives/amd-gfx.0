Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E75CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 15:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F4B10E060;
	Mon, 25 Aug 2025 15:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nf+J0IMi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B482110E060
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih7EhAdMNJ5s5AihMeZBUW5HFVrnry+zYgMeOCf1AR5Nfhl/WZPOdOErw09DOZJ0e+L1rkMt3L6cm9X5h8RRf20bQU1kFAXZ+rmBUjmm7qsf29xtS9nlRyysuog1PaLFNZrPOhgTZk7vlZ2AFPOGYxspGh30abZgJ1CF0Xhi+F52TCEnEA05zaKIhOdzk7yTwHENQ+KBJ3S1AnAn0BRf6M7kqP5ZUbG95IKXJsvK7jc14397GL9vFxn/0MfLDHbVp1Eigy3vsbKGAe3RuVrIMACbemRECLp6zD/2t9+SJV7qy4psQZH1JxYXY0/ToNLzdtUK86tEHh9OjAJnZ/uOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq7A6lzVsvpp0d3MVtQ6ZjSZTpPZqIh/vJebw+n6hZc=;
 b=r62l0kmWudJcZH+J2rZqO5cYIK4DzTqYlQBLuzBwrU67WsGQaO37enS1MLxVgAUonLKcL5uLZvPueJsJ96CZmiFJBA+4NsHeDx9RcXzLdZY40AjVqjyfRMqF1Y/V05/OwIfsVo3L3Sd+bVEzEKod5NYV/KX76yYZOZvSlwpj56ixX4OYqHOKwKFmZ9YWthb4O3VLUMVXda3aoiykOof3NhWoM4iULO2nLMIcw6T16UaHF11+ko7Q4FH7lnlGfmeQZyo3B4jG4RPwSbvkElfA+88j+g3IWquRHkZI/2BZ4Gly83yJuqT+xaasd2yX/wyAnboytxbetjyZTJX/XBSpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq7A6lzVsvpp0d3MVtQ6ZjSZTpPZqIh/vJebw+n6hZc=;
 b=nf+J0IMisEGAKDgkf14du47eR/MPdWdFqZkmX1OAItnZlHvF8MZPpdkL5OyzXlBm01K8jRXguKdU7/NJvBW+yRwhRo4FyuwPM/zwwD2EOa/Ph/KWKgmr2I5xuqOy8+glD5x0DmsAT+r7fADDsqDmFWbq1UpJg9GxtVXywsqJNi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 15:19:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 15:19:40 +0000
Message-ID: <285a79e9-4296-4028-89a6-02378cf9c381@amd.com>
Date: Mon, 25 Aug 2025 17:19:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250824233149.3780127-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e90d07-ce2f-432a-0eab-08dde3eacfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkZHOWJDdEVweEo0S2xCR2JRclpQc1h3RjAyRENHMHdCTTVheTZVM2ZKUHpN?=
 =?utf-8?B?ZklyVk9uVDVjZkt0UUloSzh2emk4TG84bUU3Uy9xT2lhaEhodFhCdjB2VDI0?=
 =?utf-8?B?RzJlbFFLSlYzbGlxUGc0Tno5NGZwc3VIZEN1dWZ6V3RlWmppNkd1YzltNEd3?=
 =?utf-8?B?NVVLL3FYR2gvOVZDYzJKektTVjRZTjdNZTZDZ2NYd0F1VEVKZGNmZ1BQbnJu?=
 =?utf-8?B?UytLMDBPWmZyZkI0MHNHWUtuTks4bGZzK1BYaW9veStORWh4U3h5YUtteXli?=
 =?utf-8?B?eW1KMUM5UC9sVSs0RTJpWDRtSDd0ZXJndWMyUFc4MG9veWM2aDltQ0piS1Zm?=
 =?utf-8?B?RUt6Vm9LSUtHSk4xVXUrRldxSlhwdVF2MTE1emtqZ3NYRklmTXVzZGF0NVcw?=
 =?utf-8?B?TWIyZnBCSUlqNkF6YkhqMzBFeEVBWE1qWTJFYmJYMnNZQnd3NnQvYkVxOXVE?=
 =?utf-8?B?TnUvU3phN1JYdDF4R0ZvWWVqZklyQ040bzUzVUxpUm53QTBvaUVVbUg1K0RX?=
 =?utf-8?B?ZlVYY1FwTmVzL1JleVlnNjdmZ3JPMmFKVm1BU3NxOS9GbVljSjUxUGNaSVda?=
 =?utf-8?B?ZkNiRy9MM1Z6R1dqMkpuM05zQU1YUzN4a2pDclRJT1RyN3l1MStRTUVzeUtz?=
 =?utf-8?B?eitnOFF4ZEpuTlpSL0RKOUcrU2tDVGVMeTIxa3N5d0dudUh1dzFlc1FncU1Y?=
 =?utf-8?B?cHBPMXFKWnRLYVlpRGNBdURzaTZRWWlqQVZiU1BXOXlDSGUwTnV6K3hoVXpC?=
 =?utf-8?B?M3Y0YzBpMVkvcUhuUnBLUENDenZqZU9KQnNnZi9QYzlkRmI0SFhvQWYrc3Nv?=
 =?utf-8?B?ZnVGMmhvanBBVy9ndU45Uzk5dmpkMmk1RFlWb0FGbExFejllL1pNYjhMWEl5?=
 =?utf-8?B?aW1MdGZRK21WbXlhZXZONitEZk1QMU9FZFZOMkpjZTVDMVdHQmhyTmlLL29W?=
 =?utf-8?B?U0l2Z25NcHVBSUc5Y1A5Y251MGRwc1BBdDZuVFBndkg1czZHaEFEV3g1OTd0?=
 =?utf-8?B?RjBXalhxcldkSjlRM3ZhMnArSyt3NmlnTVdoSi83ZmlMV0VoYXoySXdvU2VE?=
 =?utf-8?B?ODZIRGFYRVIyNVlSd090UW5SU1NGbllxcXBrTGN5MExHcTN4OWZEeVdJUGsz?=
 =?utf-8?B?ck5sc2s1T21LZmY1d21KVEI1WVlUNVh6OFZKMFM4UjBmV3FUV0dmSklmQ0Ev?=
 =?utf-8?B?OEdiZzdBUU96Y0dPM1RxVDZiR1hYaDArTXhWa2VyZHltUUhycFM1ZDl4Mlov?=
 =?utf-8?B?V1cvdzNLK21obkY2UmhBaENDT2trbFpTaGV1SnZkMzIzSk0xTVQzRjQwdms5?=
 =?utf-8?B?aDh0dGtiVzNuUy9ySTVYNlRUL2QrQnpWbkloNWNFV09uOGtIU2FOcldVUlJh?=
 =?utf-8?B?OW8ycXI2NnQ2ajVpNEpJeVZkOHZYR0xSUElIKzltSjFjUThoTlRwdU5Ha3Mv?=
 =?utf-8?B?VG1WdEw2SXB1VGVac3g5VGUvbkY1MkZjcGdIUjloRjRIZFhoZ2ppalJMVUlt?=
 =?utf-8?B?T0luTkZlZ0g1MmJGKzA1MHlyTjNWYzJlRXh1UzNyRFRkUlNNN0gyY1M1cmFF?=
 =?utf-8?B?Y2FLY2gvWDRBeUtyYUhZTExPekExUkRJRDl1azBFaGxKRFE4akZHb2xVZ3lF?=
 =?utf-8?B?WTZkOUw2dWJrK2lqa3lMa29nVHpPSVZJVzRIa0hoS01lcUVOcmt1b05uTTV5?=
 =?utf-8?B?NWlDVU50WkNzRm03WG9VNGNRdXh1eStlWmlXc01xaHBvYnNVd3lvL24yTGxk?=
 =?utf-8?B?alRGb29BMHFsb0hDaklCQjBlNFpmanNNZERaWWRHT0hBSkh5b1pwSElmbGV5?=
 =?utf-8?B?RVk3ek9tSHl1eGp6Z0NwbndHY3BXMEt0eDdZSlZxL1BscHlKUElGZThpTmFF?=
 =?utf-8?B?b1lvVWxrM3lpMkswU3F0Y1QwV2J2UDIvVllBb2IwWndWU0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXQ3WGFDUVl5K2JDK3d1UnRLYnZEdlpmZlQvSXBTd0Fjc0JTYk1URU9UbmpR?=
 =?utf-8?B?NG5neHdaZitadElkemdqTy9JUzB3cmkyY1lrMjhwa2JtUnJPbU10Ykoza1ZK?=
 =?utf-8?B?ZEVzQWREcHpNd3RrbmE0U1F2cCtlS2x3Snk5djkyZ3krVmVXaTNRQk05SGpi?=
 =?utf-8?B?RTlBaTVObHBtZzgwcDY5bG1MUnhOTCtmcnpHbmM1bXNRWkFYL3c4UDBSOEtj?=
 =?utf-8?B?b05PMmswaXhUUmpsTDNVLy9aaWtVeUQ5V2R3Z3ZMWVllcm1PNUxHaEFwc01v?=
 =?utf-8?B?OHBoL29IVkQrMGNJWmJHZjdZYlJQZURMMFdxUWRlL1Jibzk5bGNlLzkwUVla?=
 =?utf-8?B?aFJTWUdHZFR1b3hYMXFqTHBraFNhK2psR1NucnNaN1NWdEtScCtuVWVqd3NU?=
 =?utf-8?B?QU93NmY0TnFOS2NrdTgxdFVRQWhrLzJTRkZESlVHdVlZcGo4QVJNTHBPbk9H?=
 =?utf-8?B?TDFLRHdmcFhzRndhRlBHNmZyOWR1VXBFR2NiaG16emdpMVZZVDlTcUNORXFG?=
 =?utf-8?B?NVlDU3dQZGdXTUZTM3E4NHdjeUJyVkx6cEVhdjlnd1lGMThLcXZ2UU1tLzgv?=
 =?utf-8?B?VjF6Q2ZnY3dESGxRUXV1enJsVmRnbTk1ZkYyUWI5SlY4TDBSTkJMam0vaVVv?=
 =?utf-8?B?a1dGZlVqbUdneWplUm9kU3paK1I2OXZIRVRJa0t1dnpKZTM1ZFdkOVdwY0U2?=
 =?utf-8?B?akVWNnBYSGpQNTc1K29TUVF4VE1Cd0J2NHBLSlo4RUxLeXh1NHJxYkhTQ3R5?=
 =?utf-8?B?WjFzeXRENEErdm42WEdDdVgxOUQ5c25UeGxyb05sYjdodlpyYkpPbExJKzBz?=
 =?utf-8?B?bWZtYndUUVlwSUs3bE1EcnNBV2Q4NmpWbEkvSDBiTmRzSW56MFRqd0lSTmZM?=
 =?utf-8?B?Y2FCTDd6SklLS3RvZzdGVmIrTmpnQmpTdjBiaGxsMUpkNTdtS2p1bkRmVzRB?=
 =?utf-8?B?OVBEcDhIR1Y2S2p3TWd2MU1IcEltK0Q5M014RW5tV3hKdklZMnhiOG1rOFJ4?=
 =?utf-8?B?TUpISVlLazI1cHV4VnZQZlJjc29MZUlNU0s5bWtQQmRVdEdOMGY3NmR5bTBZ?=
 =?utf-8?B?ZzVGSklOT09OL2FEQmxBbm1hazJuZGpicmtpaHdzRmRaMUh0dzIvMzUwZ3VN?=
 =?utf-8?B?UUw1UURJTmZ5ZHB1djRFaVhyYnlUckVHRlJxQkZEdnV3bGN4b3hnSWgzVDZn?=
 =?utf-8?B?clpNdU5NWDhVRFRnbExXVERXWC8wbVBHRGVreHA3dGtwRE0rdUlnK0dIRWZt?=
 =?utf-8?B?M2lwVTFVd1k4LzRXd0hGOS9ucGJpUjUyRVpkdWxvejRnWTJPb0tNb01aWXVp?=
 =?utf-8?B?K3ZlS0s5RDF2K1VaTlV4RkdFRDR0bDNTQ0YrZGduQzM2MmtOK0VyVVRybitW?=
 =?utf-8?B?dUwrb0xTRlBueW5nUU5UREhGYk4vcE9HUk5aa0dMMEo0VzBHUSt4WmFBcTY4?=
 =?utf-8?B?WnBxajZMTFZLVEhXY0NRNFlkN2VZSGJlNmVRakpjYStUOFpadHZ1Q1EzZzR0?=
 =?utf-8?B?a3RxdlJKbExNVGpwNzFMS2I1b1dTRjMyc0tINzZyWWZiazU2NkFkdGtVS2hu?=
 =?utf-8?B?Rk82aHVYTWsyVU0vYjg5SkJPeVlKZDlFN1RQOWEyYUZrTmR4cHBEMnhuV0w3?=
 =?utf-8?B?YnR6dmtnRFZkQnNWMlZnZUNZR3d0VHFoODN2STE1S3JibXhMOGpib0RjVDBJ?=
 =?utf-8?B?Rm1Ua0QvcEpSVlVibmFWUzZtYVRIblBneDNIM28vT3kvbGs4VWNYZXBPQVlF?=
 =?utf-8?B?eVMxRW5iemQ0eGprL1A0VTlFUTg3QlFSeEo5QmpXb0JPOEFKMDQyZy9wTCts?=
 =?utf-8?B?QW5scVYzc3FxQ1pVMG40U1NvdjB3SDJuVFpYSDJBR2xnUXg2dFJpeEtvRHNE?=
 =?utf-8?B?b1l0Y3pSeDJ5TkFjczVYSVdVSG1GTGRpT3UxQWdRTTBydzkyaXZUM3lKc0hD?=
 =?utf-8?B?dkJlTjN2MGcwVThEYWRXL0EzeTV2cVM2SkFDWnoxbWFRSmJIdytYa2ZMTzhi?=
 =?utf-8?B?TzFoU0pvVU5pd1dwdHNhcnk3NklyemJJVzROQ2JYSjV0dmM0Q3FLM3RnVkZY?=
 =?utf-8?B?RWVVc0xIekRvME1MU2hRN3hZYURWSzFMR3RTRExFVGhtdTBIQ2o2aFdTRTV6?=
 =?utf-8?Q?pg50bT0tNPtC0L05XT9ljzTFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e90d07-ce2f-432a-0eab-08dde3eacfc5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:19:40.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQQoZds0fPy9855Bp0iqgm2MrnmMlnC2IjpXNh+rxyFInIQGeNOJkV6ChKYta1CN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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

On 25.08.25 01:29, Rodrigo Siqueira wrote:
> Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 +++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5c..80dd6f58a53b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -75,8 +75,15 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>   * @ring: amdgpu_ring structure holding ring information
>   * @ndw: number of dwords to allocate in the ring buffer
>   *

> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * Returns 0 on success, error on failure.
> + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
> + * inspecting the code, you may encounter places where this function is called
> + * amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are integer numbers.
> + * This indicates the number of dword operations to be inserted into the ring
> + * per operation.

I think explaining that is overkill, but the remaining comments are valid.

With the change above removed that patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> + *
> + * Returns:
> + * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
> + * maximum dword allowed for one submission.
>   */
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  {
> @@ -122,7 +129,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
>  		ring->funcs->begin_use(ring);
>  }
>  
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
>   *
>   * @ring: amdgpu_ring structure holding ring information
>   * @count: the number of NOP packets to insert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e..d27dbb3c109f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
>  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +
> +/* Ensure the execution in case of preemption or reset */
>  #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>  
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

