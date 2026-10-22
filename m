Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625E606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DY52nIDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9451123AE;
	Thu, 22 Oct 2026 09:38:36 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83876112422
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 09:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWXErkwRSyTXVCLiYIVZbWv5tMDiVfi6zHtxvM883DlDvCMDmlCtze4ExV7vir2bXStqb/Paci+bgNg9WqRhY2to7H8X1EO+ZDZxT6Ux8U21XhQ8UWSwmR4vhcnFbvibP9EIEPWlBY6CBSHgvumXap8TgaZ9C7/UVib5Y7P8KRj+3OjC6g7hcOfuLUaw0T5QaS13wm+5f2Kq1BvBFnZv/dOu1eJmL0z9neTeSQwaPIx7xSko7OU/+zolrQRk4H4Mcan8ALrjDA4Mq5YcF1x0goppjQsd8DiXJC0xFCoNyufvC7MkuZ0TZvPqU7zAHGgqyyg7yQZDDq367O80uMWGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnZQQmUpF02NSGTbLcq4uWhuzXgQZvze0HZME+nrZW4=;
 b=sW2uyoDGWfJQorCnDYpfs/1ZzVtgX+dirWtTDGkvy60ZqGk5kxFRuCGgUxSNSRXEbMQH3ih+Eow/yjM6svpRheh5SIynBijV7JEDMKVXhuBVkPYPNLVjFzIaTlii7FTKXuPWKSl12+DDPO1kSLr9ilF0EZl/7S/MWZKUYtNuNB5PLx2nxYkjmKRujKd/Bb2RWJ5OaUNwifiRfYnSYmyQV8qryPTbClELioBjYswxnicbFtU2D1W3SIGcxdPyI2jr//3MD2n0UisRmHFXP36jfv7+lgHNLNga/iUdFPfYFaGsYAbFM3uQaVqtPqjBLqDXGWrJ4H7V7rfuyiJVYpaw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnZQQmUpF02NSGTbLcq4uWhuzXgQZvze0HZME+nrZW4=;
 b=DY52nIDuCawYkeOco12X6whXotUTOWnAKeh5dEgjFcl6mA3+l1p3mn4uUbv2+zgZ3eqmBpqaxY0jubtOJVsTZabPhxiNvqoyhHmSF+MbjdZ4emaufDEauEa4nJBsi7hKwOTBCgQKPmLxx8IYI2OBg67c80RvM28vu53ugNCLFLc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 09:38:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 09:38:26 +0000
Message-ID: <323e0946-0928-4226-bd29-5a021892f2f1@amd.com>
Date: Thu, 22 Oct 2026 11:38:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/amdgpu: Program trap TBA/TMA for
 kernel-managed VMIDs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
 <20261021065603.1329111-7-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021065603.1329111-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: f99d4267-6ed9-4f28-8300-08df30203919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|3023799007|4143699003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: nmNUGR7hEDEjlJucIDk74S1Ia09K2BjwaokTDjybvl0EixI7EzovglKGMukqG79oBWZ94VOeJ2jqJfiFrWc+PgiNni6rQOBNbaa/78AidtVB/wZl3IR9WaprI3D4AeVL4g+Edqk9+MWg2+j4fopk9gSGeFbeiH97YZm1lCHSvszhk1GptuR6NwTN2faghMb9L+Kr/Epxz2eUz8UgkYFSMQH3lvvCvMc2EwUA3HZLb0ADszXyLhiisFdLXuNmcAv0k2Pvu9a0IGXGesMAORLRH61zOFzkLxJYjKZtKkXXMRuClMuG8qshhY7p23mCY5Ups3EvRv+bYo1kqbrI2LAzxn0blEpeK97I3idwb9vm4T1PXbjUuUdlms0XAfYNuqr7f1vDbbwYju0YBFKHXqWDraE4WiVOCXFGYBGKIDFFckeCL+Y5Jr+Z3SoMPy/lUVcRAwuXubXxXgoiQFWveDr619Yv/hSzt1thWwpF8BKcV3E0hL04pdbkzoILICr11nOjr0fx3mNt+VeryPCEYdNoA/7IzE4E8kOQ1h8LAtePQj0IKmY3KB4PURTvgE5US4W0m2tcDK6xPE3CWiqEHX2X7WlBu5tUNeQ0gugWKRYWrdBj0LpJy13biLj90IRuzoFONz3g7OamPfu93GGR8MXZCCbq9P3PZcJ6ZhPL3Z4eV5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnp0SUdpTWxUWGdiVi9aWGhiV29DbFNUWlJORzdDTm9SbUxQZTd2UTFjM2pB?=
 =?utf-8?B?ZDdyaDdaTzJWOXFpTG5lakVKeGZrRWR3U1MwTUVpUTlYOXRNUDBjUXFSRW5y?=
 =?utf-8?B?eStLRFZkQzBvVDNQa2N1RzBoV1NQUGtjUjdDbXFhRDc1K2JpbzVKM2Q2YlpY?=
 =?utf-8?B?QXVmNVRhRHBINFJYV3RPVTJIZU52WlFlUldCWHk4anpQdmIzWFhuSm40Um5Y?=
 =?utf-8?B?SVI3TnhaSk1MVUMxMU5ZbGZMaTZxVXhOMDdESmQwMVNXekdKaFU1RkRBZnFZ?=
 =?utf-8?B?dWxRV2JXcm9YT0txSXBjY0JaTnp4WnAxU0pLTXNJYXlNcHROR21MY25uMEhN?=
 =?utf-8?B?dUlLNG9PYlBNZlU1UGtqRDBUUlpFWjE4eGJhOS9sRThTMklqWlM5ekRSa0JV?=
 =?utf-8?B?Z0xPaTVrOXc4NjJzZ0NYL3FQdlJVR1crS2xZcE5YamxBeGNlQnUwRHZ0MG9C?=
 =?utf-8?B?bTg0d0s1bExUTktwSExGWTl6R2RKSGU1M2xPRktwZjVMdGQ0ZDBCYjFHNlgy?=
 =?utf-8?B?OWI3VXl2OFlrM3VhMHd0Vi9rRVFtOCtzVzlHUmdTeFB3alBXRVJ4eEZUK2xI?=
 =?utf-8?B?NnUvOFpLQmljUnYvMUxwYmMyUnJvZmdvbEh2NU9oSkV5bjQxVGh6dkVLblJT?=
 =?utf-8?B?WE5qTHpFMTZWZStxVEZhTGp0WVk4RnVuSXE2bEw3U1lJeTh4SGhoVlRxbkYr?=
 =?utf-8?B?SU9DUFh3RHFwV1RUMXVlN1Zydk5EQUZDWGFUWGFzcXdwV0NuK3NBMWN4aTlL?=
 =?utf-8?B?OHJib2g2L2g0SjAxVnNyZys4SHNqU0hLMzhQUWxUNUIxWEpsTXlsa0NOVHFa?=
 =?utf-8?B?SlFTRDU0R0x6dXhTZ1hpS0hobHJUU3JvZUFpd3MzRWg4azkzUExtdzFJbGhy?=
 =?utf-8?B?VnQ4dEJwcnlmN3lma3RZdnl4bjhjNERDMlRGZkdNclZqM0pkVmxUMGtiUWl2?=
 =?utf-8?B?RzNVQXNyQnJsL1FBeWdGKzA2S2RQSVp4Q2Fobi9tcERrYkVVbkJnc2JnbHc0?=
 =?utf-8?B?ekdWS0RUNFlQQWlQaHZBeStJYVpoeEF1bVA3YS9kRTNuRk50RkIrNW9sdHBJ?=
 =?utf-8?B?Y2RLYk91cWVwTXdUSUNkUExuVGlJSXJSdCtLNWEvZWxSd0tTTGZKai9lTGZM?=
 =?utf-8?B?QVZzcWJwOWFLWjJUcUVJNTZocUlObnY3R2FkOUtGM2ZFbzd6by9jVFhLbTNN?=
 =?utf-8?B?UmRVcGMyTkdiU2ZrTUhLTisrcmNxS0tMRHNWWHFhOVE5cGZaRXJZZ0FmaUlW?=
 =?utf-8?B?VE4xQUhYNUZHYXp4M0tqV3pHQ1c3aDY1ek5ZSGVGYnBtMEcvbVd4Nmk0OTdk?=
 =?utf-8?B?N3RCNlBpUWNaUDdLSmFGRUZNaUtlYnFtcVJ2UERnb01SSzgwdVZ3YUF6YSs3?=
 =?utf-8?B?L2FIbGJTajlQSWc0TW5HRmc1SCtOaVBScDRKQ1hBZXJrWklYN3lqbitjODRj?=
 =?utf-8?B?bisrVUlxeHE0bUJaS0VaSzJ3Z3hHZGFJajlUdWZhR0hlYmxzbko1ZW5TUVFo?=
 =?utf-8?B?Q3VvZGc5TDYvL3hESkhEMXMrRit6MmNMRThyQlhXYW9CMnFiMGEyaTNRaENq?=
 =?utf-8?B?S052ZEUrQWI2TDl4MGVOMW8zcDFsWEkvYjBCQXY0dmFXTTR3ZjNmYXl3KzJL?=
 =?utf-8?B?elQ1eTZYbUxNQnFXWm1ZZDllaFA4eG5ZTkhuaU1MaXlUU2JSWUc3TVlDRWlv?=
 =?utf-8?B?WDcvRVRIRE9BdWZ2WnE4SWxEMzNYcFA1eWk0QzBmbEJ1Z0FQMHdyVTJUenJp?=
 =?utf-8?B?aGw1ZXI1c0dVdk5tOVZMNXVrNW16T1JaY3pUV1F4V2tybkFkdGo4YjRWL1Rs?=
 =?utf-8?B?ZVFZM0pSWGtiWmF1ZkVFYUszU3I1MGRvVFZoV3NSYlJoOGhlMlMyUGl0Tnlr?=
 =?utf-8?B?TGllZEJDWHY4eWdpUTVya05DUE9UNnZHZHpNTzhoZ0pJcFJuK29GMUJIb3F6?=
 =?utf-8?B?Z1YxSFFMTVdDc1pUTG0wSnFGbmxhTmhTaXJvcGluOStKQXZJWHZZc1dnZ045?=
 =?utf-8?B?WVZncEIvWUdhQ3FhZTVBbWpPOUw3ZHNya3picitRR2plM1BXUFYwQUVKak1z?=
 =?utf-8?B?d2Qxb0I0TUhxRzdsVlhrY3cxRWU4NVJjWHc3czM1SHFjYVVkVGN0VzZqd1dQ?=
 =?utf-8?B?VE4vWC91R0FrMndjbGgrTFZua1Y1aHFyQVZNTFMrT20xczhReVRHbStzb2Rq?=
 =?utf-8?B?TFVWOXhHREZacllHUFVodjhNZ0NpbU10M3ozMEhGSzduMVJZUmdpWHNCVi9n?=
 =?utf-8?B?TGxlekNTZTZ1MUFaWkE3QXIyUTluWlhYUUlqQzFia21yWVlqVkg4aVVPRUw0?=
 =?utf-8?Q?B0Jo1dotlnCJaxAm/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99d4267-6ed9-4f28-8300-08df30203919
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:38:26.8224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veOTd9nqtfEvlMp940fvzyBCOg4chMYe4w1fapQqCMx2e8njgbQp+mNHfGxPueEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

On 10/21/26 08:56, Srinivasan Shanmugam wrote:
> User queues get their first-level TBA and TMA from MES/KIQ when the
> queue is created. Kernel-managed VMIDs do not use this path, so program
> their trap registers from the gfxhub setup path.
> 
> Get the reserved first-level TBA and TMA virtual addresses and program
> them for kernel-managed VMIDs. User-queue VMIDs continue to receive
> their trap state through the existing MES/KIQ programming path.
> 
> The trap registers use the SRBM selector, so keep the programming under
> srbm_mutex and restore the VMID selector after the registers are
> updated.
> 
> Trap enablement differs across GPU generations. On GFX9, enable traps
> for user-queue VMIDs through the debug trap configuration and program
> kernel-managed VMIDs through the gfxhub path. On GFX9.4.3, enable the
> per-VMID trap control on each XCC. On generations where trap enable is
> encoded in SQ_SHADER_TBA_HI, program TRAP_EN together with the TBA
> address.
> 
> Mask the TBA and TMA address fields before writing the registers. Keep
> TRAP_EN disabled on the affected GFX11 ASICs to preserve the existing
> trap workaround.
> 
> On multi-XCC hardware, program the requested XCCs and restore the VMID
> selector on each XCC afterwards.
> 
> Keep the first-level trap VA layout inside amdgpu_trap. The gfxhub code
> only needs the final TBA and TMA addresses.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Change-Id: Ib123b53f00c7c82f5c736183273e97ef21474508

I skimmed over it but there are just to much changes to review in deatail.

Feel free to add Acked-by: Christian König <christian.koenig@amd.com> but I think Alex and Lijo should take a look as well.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  9 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  5 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 28 ++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 75 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 50 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 50 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 61 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 47 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 59 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 50 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 50 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 55 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 55 +++++++++++++++
>  13 files changed, 576 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 89968b5b7ecb..6e7dfceeee10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -63,7 +63,14 @@ static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
>  	return addr;
>  }
>  
> -static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
> +void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
> +			     u64 *tba_addr, u64 *tma_addr)
> +{
> +	*tba_addr = amdgpu_trap_tba_vaddr(adev);
> +	*tma_addr = *tba_addr + AMDGPU_TRAP_TMA_OFFSET;
> +}
> +
> +bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
>  {
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index c78c60e3d18d..523f65cb3d3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -76,6 +76,11 @@ struct amdgpu_trap_usr_addr {
>  int amdgpu_trap_init(struct amdgpu_device *adev);
>  void amdgpu_trap_fini(struct amdgpu_device *adev);
>  
> +bool amdgpu_trap_is_supported(struct amdgpu_device *adev);
> +
> +void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
> +			     u64 *tba_addr, u64 *tma_addr);
> +
>  int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		      struct amdgpu_trap_obj **trap_obj);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 75d1bbdb421f..a84991104b43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -29,6 +29,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
> +#include "amdgpu_trap.h"
>  #include "soc15.h"
>  #include "soc15d.h"
>  #include "amdgpu_atomfirmware.h"
> @@ -2568,14 +2569,25 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
> -				uint32_t vmid_mask)
> +					    uint32_t vmid_mask)
>  {
>  	uint32_t data;
> +	uint32_t trap_config_vmid_mask;
> +
> +	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG));
> +
> +	trap_config_vmid_mask =
> +		REG_GET_FIELD(data, SPI_GDBG_TRAP_CONFIG, VMID_SEL);
> +
> +	/* Add the requested VMIDs to the existing trap configuration. */
> +	trap_config_vmid_mask |= vmid_mask;
> +
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> +			     VMID_SEL, trap_config_vmid_mask);
>  
> -	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> -			VMID_SEL, vmid_mask);
>  	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> -			TRAP_EN, 1);
> +			     TRAP_EN, 1);
> +
>  	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
>  	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
>  
> @@ -4044,6 +4056,14 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	if (amdgpu_trap_is_supported(adev)) {
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
> +			gfx_v9_4_2_debug_trap_config_init(adev);
> +		else
> +			gfx_v9_0_debug_trap_config_init(adev,
> +						   adev->vm_manager.vmid_uq_mask_gfxhub);
> +	}
> +
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
>  	    !amdgpu_sriov_vf(adev))
>  		gfx_v9_4_2_set_power_brake_sequence(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index d66c7901783e..98a54e53232f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ip.h"
>  #include "amdgpu_gfx.h"
> +#include "amdgpu_trap.h"
>  #include "soc15.h"
>  #include "soc15d.h"
>  #include "soc15_common.h"
> @@ -1167,25 +1168,66 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  	 * Scratch:     0x60000001'00000000 - 0x60000002'00000000 (4GB)
>  	 * GPUVM:       0x60010000'00000000 - 0x60020000'00000000 (1TB)
>  	 */
> -	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
> +	sh_mem_bases = DEFAULT_SH_MEM_BASES |
> +		       (DEFAULT_SH_MEM_BASES << 16);
>  
>  	sh_mem_config = SH_MEM_ADDRESS_MODE_64 |
>  			SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>  			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>  
>  	mutex_lock(&adev->srbm_mutex);
> +
> +	/*
> +	 * Enable traps for kernel-managed VMIDs.
> +	 */
> +	if (amdgpu_trap_is_supported(adev)) {
> +		for (i = 1; i < AMDGPU_NUM_VMID; i++) {
> +			if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(i))
> +				continue;
> +
> +			soc15_grbm_select(adev, 0, 0, 0, i,
> +					  GET_INST(GC, xcc_id));
> +
> +			data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> +					    regSPI_GDBG_PER_VMID_CNTL);
> +
> +			data = REG_SET_FIELD(data,
> +					     SPI_GDBG_PER_VMID_CNTL,
> +					     TRAP_EN, 1);
> +
> +			WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> +					 regSPI_GDBG_PER_VMID_CNTL,
> +					 data);
> +		}
> +	}
> +
>  	for_each_uq_gfx_vmid(i, adev) {
> -		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
> +		soc15_grbm_select(adev, 0, 0, 0, i,
> +				  GET_INST(GC, xcc_id));
> +
>  		/* CP and shaders */
> -		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
> -		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_BASES, sh_mem_bases);
> +		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> +				 regSH_MEM_CONFIG, sh_mem_config);
> +
> +		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> +				 regSH_MEM_BASES, sh_mem_bases);
>  
> -		/* Enable trap for each kfd vmid. */
> -		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL);
> -		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
> -		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL, data);
> +		/* Enable trap for each user queue VMID. */
> +		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> +				    regSPI_GDBG_PER_VMID_CNTL);
> +
> +		data = REG_SET_FIELD(data,
> +				     SPI_GDBG_PER_VMID_CNTL,
> +				     TRAP_EN, 1);
> +
> +		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id),
> +				 regSPI_GDBG_PER_VMID_CNTL,
> +				 data);
>  	}
> -	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +
> +	soc15_grbm_select(adev, 0, 0, 0, 0,
> +			  GET_INST(GC, xcc_id));
> +
>  	mutex_unlock(&adev->srbm_mutex);
>  
>  	/*
> @@ -1193,10 +1235,17 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>  	 * access. These should be enabled by FW for target VMIDs.
>  	 */
>  	for_each_uq_gfx_vmid(i, adev) {
> -		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
> -		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
> -		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
> -		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_OA_VMID0, i, 0);
> +		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
> +				    regGDS_VMID0_BASE, 2 * i, 0);
> +
> +		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
> +				    regGDS_VMID0_SIZE, 2 * i, 0);
> +
> +		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
> +				    regGDS_GWS_VMID0, i, 0);
> +
> +		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id),
> +				    regGDS_OA_VMID0, i, 0);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 8be912d50601..5b9efd09493a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v11_5_0.h"
>  
>  #include "gc/gc_11_5_0_offset.h"
> @@ -295,6 +296,52 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -342,6 +389,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 4144c1c2ee13..f0ca90f8b50e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v12_0.h"
>  
>  #include "gc/gc_12_0_0_offset.h"
> @@ -300,6 +301,52 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -347,6 +394,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index b13967a1c8fb..a35ca7fcb198 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_xcp.h"
>  #include "gfxhub_v12_1.h"
>  
> @@ -392,6 +393,63 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
>  	}
>  }
>  
> +static void
> +gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
> +					 uint32_t xcc_mask)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +	int xcc;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for_each_inst(xcc, xcc_mask) {
> +		for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +			/* Program only kernel-managed VMIDs. */
> +			if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +				continue;
> +
> +			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
> +						    vmid, xcc);
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_LO,
> +				     lower_32_bits(tba_addr >> 8));
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_HI,
> +				     (upper_32_bits(tba_addr >> 8) &
> +				      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_LO,
> +				     lower_32_bits(tma_addr >> 8));
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_HI,
> +				     upper_32_bits(tma_addr >> 8) &
> +				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +		}
> +	}
> +
> +	/* Reset the VMID selector on every XCC instance. */
> +	for_each_inst(xcc, xcc_mask)
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  					       uint32_t xcc_mask)
>  {
> @@ -457,6 +515,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  
>  		hub->vm_cntx_cntl = tmp;
>  	}
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v12_1_program_kernel_trap_tba_tma(adev, xcc_mask);
>  }
>  
>  static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index c35856180c3c..6cb7bae80f3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v1_0.h"
>  #include "gfxhub_v1_1.h"
>  
> @@ -252,6 +253,49 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v1_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Skip user-queue VMIDs. Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     upper_32_bits(tba_addr >> 8) &
> +			     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -310,6 +354,9 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  				    i * hub->ctx_addr_distance,
>  				    upper_32_bits(adev->vm_manager.max_pfn - 1));
>  	}
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v1_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index e89813590539..b06edea271af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -22,6 +22,7 @@
>   */
>  #include "amdgpu.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_xcp.h"
>  #include "gfxhub_v1_2.h"
>  #include "gfxhub_v1_1.h"
> @@ -328,6 +329,61 @@ gfxhub_v1_2_per_process_xnack_support(struct amdgpu_device *adev)
>  	return !!adev->aid_mask;
>  }
>  
> +static void
> +gfxhub_v1_2_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
> +					uint32_t xcc_mask)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +	int xcc;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for_each_inst(xcc, xcc_mask) {
> +		for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +			/* Program only kernel-managed VMIDs. */
> +			if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +				continue;
> +
> +			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
> +						    vmid, xcc);
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_LO,
> +				     lower_32_bits(tba_addr >> 8));
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TBA_HI,
> +				     upper_32_bits(tba_addr >> 8) &
> +				     SQ_SHADER_TBA_HI__ADDR_HI_MASK);
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_LO,
> +				     lower_32_bits(tma_addr >> 8));
> +
> +			WREG32_SOC15(GC, GET_INST(GC, xcc),
> +				     regSQ_SHADER_TMA_HI,
> +				     upper_32_bits(tma_addr >> 8) &
> +				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +		}
> +	}
> +
> +	for_each_inst(xcc, xcc_mask)
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  					      uint32_t xcc_mask)
>  {
> @@ -398,6 +454,9 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  					    upper_32_bits(adev->vm_manager.max_pfn - 1));
>  		}
>  	}
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v1_2_program_kernel_trap_tba_tma(adev, xcc_mask);
>  }
>  
>  static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 04778f9f95bd..b7364d1b52c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v2_0.h"
>  
>  #include "gc/gc_10_1_0_offset.h"
> @@ -285,6 +286,52 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -332,6 +379,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 6c77c17878f8..c00c7b23e6e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v2_1.h"
>  
>  #include "gc/gc_10_3_0_offset.h"
> @@ -297,6 +298,52 @@ static void gfxhub_v2_1_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v2_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +			     (upper_32_bits(tba_addr >> 8) &
> +			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
> +			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -344,6 +391,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v2_1_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index e2b9fd0c8af0..fd7a0f1f369b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v3_0.h"
>  
>  #include "gc/gc_11_0_0_offset.h"
> @@ -292,6 +293,57 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	u32 tba_hi;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	tba_hi = upper_32_bits(tba_addr >> 8) &
> +		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
> +
> +	if (!amdgpu_trap_has_dbg_wa(adev))
> +		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     tba_hi);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -339,6 +391,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index fa8b966b7ea1..6c4b110f8048 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -23,6 +23,7 @@
>  
>  #include "amdgpu.h"
>  #include "gfxhub_v3_0_3.h"
> +#include "amdgpu_trap.h"
>  
>  #include "gc/gc_11_0_3_offset.h"
>  #include "gc/gc_11_0_3_sh_mask.h"
> @@ -297,6 +298,57 @@ static void gfxhub_v3_0_3_disable_identity_aperture(struct amdgpu_device *adev)
>  
>  }
>  
> +static void
> +gfxhub_v3_0_3_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
> +{
> +	u64 tba_addr, tma_addr;
> +	u32 tba_hi;
> +	unsigned int vmid;
> +
> +	if (!amdgpu_trap_is_supported(adev) ||
> +	    !adev->gfx.funcs ||
> +	    !adev->gfx.funcs->select_me_pipe_q)
> +		return;
> +
> +	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
> +
> +	WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +	WARN_ON(!IS_ALIGNED(tma_addr, 256));
> +
> +	tba_hi = upper_32_bits(tba_addr >> 8) &
> +		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
> +
> +	if (!amdgpu_trap_has_dbg_wa(adev))
> +		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +
> +	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> +		/* Program only kernel-managed VMIDs. */
> +		if (adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid))
> +			continue;
> +
> +		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +			     lower_32_bits(tba_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +			     tba_hi);
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +			     lower_32_bits(tma_addr >> 8));
> +
> +		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +			     upper_32_bits(tma_addr >> 8) &
> +			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
> +	}
> +
> +	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -344,6 +396,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>  	}
>  
>  	hub->vm_cntx_cntl = tmp;
> +
> +	if (amdgpu_trap_is_supported(adev))
> +		gfxhub_v3_0_3_program_kernel_trap_tba_tma(adev);
>  }
>  
>  static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)

