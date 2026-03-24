Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1150E9A74B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 09:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE6A10E590;
	Tue, 24 Mar 2026 09:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8lBaqeO";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92DE10E55F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 09:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/PlyZ7y2sIfRgF8PUmPBuWgmUH4LHe84st7Yij+0jx8pZXJLBOz1HmDUOowieX7CxL1hqR6xMS2jokyYosMbBNnhnCukQKcb9gfxFCAyvLMpEbs3mzib5Fh72LNWGM0TWM6iGHr7W/f20a6Ux6bCj8xRRn25OpmS++JWwkjHBXVcMYN4IzuXZ9Y/0UsETbCJUgs+HLtSS5ARYqTCaE88USKor2BrYrLbzicCL2/OXrsYoWrWkVMb4BVeaDnz9jQ6bKetkClslzCmyyQSwj2zwZIPgG+k3c76W8TkvzCbLXIqQ9c0eGndEWK9OL/qWrgElZzFl0Oecd6tMqIhS2NLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plxx8iGu2vs5UbEsz/qLfaw0ZGaQGrERyKRCnEXCih0=;
 b=Y3g4KIMk37S3reW/FHeN7FFt04mRtHA1Rbn9G8QIR/E1eD+MgiD5qnhVCj8brgTb0ypm1ZKC0t9IJcWGP0I2Trr37S4W7bD8PCWvO2kO49dflqQZr30xOuHs2M2f5F/npb5H1af57kos3R2YBJ5zJXei7D8uCis5ClmZTMTdrhc3+4IjWzNT+X0o70SeTBh0txlGL7qv2UJGRzCBZP6ZntVOAAw/3w4NSo29yFrLolRDVJm79zuFsi/PhgNyqgXDzlFYGUiU8LIbhEJMIgsCGmtFuDLoxrE9tWcE/EwUl+9FFna3M8AvRQqVZXOxWnoqY+cWpCdaHxJytdcLVmstHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plxx8iGu2vs5UbEsz/qLfaw0ZGaQGrERyKRCnEXCih0=;
 b=o8lBaqeOnx/jqJQ1KxlpkWOGw8zO0lD4BIwimeOFvb3D27ADl3QZrEWA+6uPFBxZt95uz7RJvC/rDYAo4afR9kiCasq6iGJgZcKQx4+z3l7ovHunEfrIJfkKHv0a1ahhFQkIWKRw6fDXX3v6T6PSS1vkWZypf+pLFbCE5ZWHg+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:48:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:48:23 +0000
Message-ID: <47badee2-9f58-4826-870c-d4f945548415@amd.com>
Date: Tue, 24 Mar 2026 10:48:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix NULL bo_va dereference in VA clear path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260324043600.2075763-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324043600.2075763-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0014.prod.exchangelabs.com
 (2603:10b6:207:18::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a3b95-2a98-47de-b268-08de898a7d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Wns2T56XGu6Q4zOFmwCmSDInDjYEVWgcNfRHuAe5ZyHpdE0elLEAVhGCEf8pXhrtT/Hp8toZVxLw1DRdEp8DtfSCy1QeLGOm/f/XI/N3ctmS2+UBsx7/8xlwYp6v3L8a5BQ9zJ29mUg4hJetfQgwvzL110GTnZARalx4IN9zBgtpESrSzqCqMCjXpGlpgln/87JJqXinCsotD31pxFezkqadHX6E9uG0CK9TMlv4Hb69N60FVFqEkIt9AXcG25yRfwaebeEnKmN471aVX/ln0FuL8CbEAAaLkfDsBCDfG69pYKZ4Q/kvqjJ/n1C+G8Z4kMgo3Peu2KZXP4rsTAEdRsySZCrZJu5jLwQ5+7PzR7yQiycl+a4BekuTBtC7J8+KoJ/1bmMecRjb6Q75qdRehG4+7oRCgjjnKSzROUxtuheDwQDYpfz0rwo5z2hObhV4eZ5xWda+xXnSYeJVvqydgytISjkGpZCr1SyXj5eComw2T+dx5qixGEtt1Dh/z1ndMaY3kNm7mYNTQT3T7F+5hpAP/1dUw7R5GhC8CSbF79Jy6rVHoOckW2RyESDhr2bZwZ8le/BhWv4ppC/4KCuuzSbGAl3fRONI62kJyeY9QBtMM2IP8e4aA1Cd15A0N445aGLpdKF3Zsmj/dJoUOCeu8jt3EFcU7Y15pUuXH6d44CWGAhCveSgyNv1OLq3CZmGSOe0LDHcTPe3J05dYwWotCfI903Ve6YRn1L/l53YEDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlaM283UXpwdWM4VU4vdzRKNEFTdHFxQjhlcGpRYkd1L0k1ZlBsTTJLMFcw?=
 =?utf-8?B?Y1NZZTZNenMyRkJBVVpJd3dZZEM3Tk1aTFVmcGdESzN6Slh1aVorS2dRbkg0?=
 =?utf-8?B?SWlsMHlnamtBZmhVMkIzdFBaUnlBUytwMHI4aEdmays0VHprRStpTHFQb0dy?=
 =?utf-8?B?NGQzdVNhR1lMKzNNeHNKSmJDKzZpU0p3ZVMzYzRvNlkxM3JIV3QvTWNoSWxB?=
 =?utf-8?B?cVhZUWlPSzB6endhV3hORWlPeGFFeHhET3pSNUZab204Mkd4TzN2aitFZTZV?=
 =?utf-8?B?MnA5bmwwUHNSUThuZEpJTWNwekhOLzBYK1FVN01NakloSGtMQUxYN3RpSjVU?=
 =?utf-8?B?MkR2a0lhME9JdXdXYkpxMGdHT2pFdXFVV3hHMjBvQ3FtZU9icW15K0QyNCtn?=
 =?utf-8?B?ZWIvdXBiNktPNkc1Q3FEQ2pMcUJXTGkyV2pjTHJYQ21LWjZTakQ4eno3ZGk3?=
 =?utf-8?B?M2RtYWNRdFFaZXZvU3Vlb05JMmtYbm50QURiejlUVDNJK2IvYW5FbDZPaDcw?=
 =?utf-8?B?b1RZL2w5a216THFxWi9EczZjQVhxK0hocGlvT0tPSEwySjU0MHVQS3JYci9I?=
 =?utf-8?B?U1VKZmxIalBjOFoyZmdicTdXNDZ3RWF6eTdPUWlIdDIxWENUeDYvWkp2UWha?=
 =?utf-8?B?bGJuSzBrYWUvaTQyZlJRZ1R6c2o2czdBSWdaUUVtTXhFODdiRURld2RJdEFo?=
 =?utf-8?B?SWlIRXJuMGMxTGt0bmxBWnpDZUJVbmRoNzdManhSSSt2NXRYaHNWczY5RHBh?=
 =?utf-8?B?WWxKM2FGZ1BSQnU5MG04MG1RMXkyaXN3ZjN1dWltM2RJTzF2UmdqQVZmU0FC?=
 =?utf-8?B?ZklldzJBR2szQVArM2czUVpTQVpabytwV3V5enJVYXIzbmJRMzNWQUdJQTBx?=
 =?utf-8?B?Y0NWd3Irb3JleGVaZFJ6L0kwZlRSOEZmU0VHOXhYZjVZV3FmRG5UdHh0QnN0?=
 =?utf-8?B?dVVLQ3Y0UDNxSmlkTlpldzdyUVZENFovTS9NdFRSSDR3Nm83ZWZRZDkvdFVT?=
 =?utf-8?B?bWVPOXdpeFk4RnVydmg1dGI3d2lrQzEvWFUvUEZvSjFkSHYyaFZVMlQvNWVX?=
 =?utf-8?B?SE5rUER3eCswa1BESFZ0cjgvK0ZxNWJkbUJYTlVGaitoR2N1T2VJVkROMnoy?=
 =?utf-8?B?K3hEb1p6Mjdqa1REa1NMNms2M0hGNGRuY2NXN2pDQTg1Y0lEYm8xREYvdlYx?=
 =?utf-8?B?eGp1aFJBRlJSb3BPemxLUXBzN0xrVGxaSVNiclRTcENhZm8vVWlSSWlZZThi?=
 =?utf-8?B?bzVZdk95YkFTRi81eWN0TUxJNUVoelFoQ2tmYmUwVUJSNDFKNm9FMXFLYXZM?=
 =?utf-8?B?eTBCS3V6Z2prY0NQNCtsakgzVXNtWkN0YVJlOG11TWxURHNtUnc1aWI0ZmZy?=
 =?utf-8?B?eXVYaUs4VE4yVTFQcXJUSFY1YklielBjM2hRa0dMVlZGRm92Vms1U0QyT0hs?=
 =?utf-8?B?UDFnVFIyRzg1SGdHQ1JGUTFFZGZiY1dIVGU0OUZGSnpyVXIvWWlwbE96Y3Vi?=
 =?utf-8?B?bmkwVTJqQnRDczJjSzlpOGlTaHE4Z1l1T01TM1pWNmVSSXh5eEJzYS9ZM1pR?=
 =?utf-8?B?bEZ5cmZIeGVZNTFnK1liSlpNNThWalFJL0FXOUlTQnpHODVRSS9TbzM2SWk3?=
 =?utf-8?B?NUg0M1dDdXZmN0xhNndYU0liSWV2ODJYMXJaNmRkRUpBcTVndDREdlk3eElO?=
 =?utf-8?B?dnBVS2tpSENrSHlsQUszRGUxZDdvOGtIRGw0cUc1ZTd6eVNJVlhpckY1d1Vw?=
 =?utf-8?B?K1dzeUVNTm5NZDBIUXdjb1dqNVFKV3Y1WW9KTExhbDZCYXJLeTAwcmRzaHg2?=
 =?utf-8?B?RjVtK2xSNkYxbjQ2Q2hMMHVHbWZ1TmM2Ui9veHdML1Bmbyt1U083QWZuek9T?=
 =?utf-8?B?TzUyRHcwcTcySERCOGUwU0tSbFVJSTMvL29DREZGMk1hM0wwcW9BaVY5VWtF?=
 =?utf-8?B?OWx6U2UwYTBrY3R6SzRiMzBtOHdmdmlkS082d2tZaUlDdUVEZUttNXB0S3Rp?=
 =?utf-8?B?QThxN2ZqTE1MY21iNWkxYXpDeHU4UyswREhrMGhVeWE0dkZFZ1dOUVExSEZM?=
 =?utf-8?B?L0FJc1hjZnJSK04vNmxvcVdLVjlTQVhKT3U1SmZic25tY3JIbzhYR01yRUVw?=
 =?utf-8?B?VEJDOVJqRVlvTkVhM1NlYVNQa3NraWhxaS8wMkFjU1habEhrNkNXenNCV2hK?=
 =?utf-8?B?cUhpSFkyd2FjQmRVeGxyM0xJZHpqZkRIMmtIVDhVWGxPaHRFRXVlRWs0MVMy?=
 =?utf-8?B?ZVh4S0xNWU5hckFPTjVjSDI5ZzBUcU9ISG1kZjVNamk4OUxrZ0lNd1lCZDlr?=
 =?utf-8?Q?3fn4xqdzz1h0oWB7xE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a3b95-2a98-47de-b268-08de898a7d05
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:48:23.0766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8/63ohKn6E6sCnj/li/3Fu6OxxMd5OXCs2M4wAFsK1sXIJx1GF/QpcMndJNbWiR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
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

On 3/24/26 05:36, Srinivasan Shanmugam wrote:
> amdgpu_gem_va_ioctl() sets bo_va to NULL for VA clear operations,
> because CLEAR works on a VM address range and not on a specific BO.
> 
> However, the code still calls amdgpu_gem_va_update_vm() with this
> NULL bo_va. That helper expects a valid bo_va and dereferences it.

That isn't true. amdgpu_gem_va_update_vm() should also be able to deal with bo_va=NULL and do the necessary clear operation.

Please fix that instead if it's broken, could be that my recent patch missed something.

Regards,
Christian.

> 
> This can lead to a NULL pointer dereference, as seen in amd_bo IGT.
> 
> Fix this by skipping the BO-VA update helper for CLEAR operations
> and using vm->last_update instead.
> 
> Other operations (MAP, UNMAP, REPLACE) are unchanged.
> 
> Fixes the below:
> [  325.716062] [IGT] amd_bo: executing
> [  325.779102] ==================================================================
> [  325.786483] BUG: KASAN: null-ptr-deref in amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.795105] Write of size 4 at addr 0000000000000000 by task amd_bo/7893
> [  325.801997]
> [  325.803595] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Not tainted 6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1 PREEMPT(voluntary)
> [  325.803602] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
> [  325.803606] Call Trace:
> [  325.803609]  <TASK>
> [  325.803612]  dump_stack_lvl+0x64/0x80
> [  325.803623]  kasan_report+0xb8/0xf0
> [  325.803631]  ? amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.804427]  kasan_check_range+0x105/0x1b0
> [  325.804432]  amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.805229]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu]
> [  325.806022]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.806815]  ? __pfx___drm_dev_dbg+0x10/0x10 [drm]
> [  325.806894]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.807686]  drm_ioctl_kernel+0x13d/0x2b0 [drm]
> [  325.807767]  ? __pfx_file_has_perm+0x10/0x10
> [  325.807777]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  325.807857]  drm_ioctl+0x4be/0xae0 [drm]
> [  325.807936]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.808728]  ? __pfx_sock_write_iter+0x10/0x10
> [  325.808737]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  325.808816]  ? ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
> [  325.808823]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> [  325.808827]  ? _raw_spin_lock_irqsave+0x86/0xd0
> [  325.808835]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  325.808841]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu]
> [  325.809622]  __x64_sys_ioctl+0x139/0x1c0
> [  325.809630]  do_syscall_64+0x64/0x880
> [  325.809638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  325.809645] RIP: 0033:0x7f205fd12e1d
> [  325.809650] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [  325.809654] RSP: 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  325.809660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f205fd12e1d
> [  325.809663] RDX: 00007ffe9032b5b0 RSI: 00000000c0406448 RDI: 0000000000000006
> [  325.809665] RBP: 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e
> [  325.809668] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c0406448
> [  325.809670] R13: 0000000000000006 R14: 0000000000001000 R15: 0000000000000001
> [  325.809675]  </TASK>
> [  325.809678] ==================================================================
> 
> Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR v2")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 98276b55ad3c..a07d00f1127b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -967,8 +967,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	    (!adev->debug_vm || timeline_syncobj)) {
>  		struct dma_fence *fence;
>  
> -		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -						args->operation);
> +		if (args->operation == AMDGPU_VA_OP_CLEAR)
> +			fence = dma_fence_get(fpriv->vm.last_update);
> +		else
> +			fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm,
> +							bo_va,
> +							args->operation);
> +
>  		if (timeline_syncobj) {
>  			if (!args->vm_timeline_point) {
>  				/* Replace the existing fence when no point is given. */

