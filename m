Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9746E83838
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381C610E0E6;
	Mon, 16 Feb 2026 21:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ttlwl6oy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F4010E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIh7NrxebSwwtcTse0XNIF3SGbWru7Y7xR6Mv559TJPWKsKwOcmkPz0tamGB6hKLoT3aosW26g2WNt071F5c1mXaHLgU4htgk0hkJCeRkl8ZhAS8Y7fSWLol+79VAwkXJ19Y0xbWsqNSVYktWV92Wo24kVVaYrvbchAaWfZ8+luFDCjXcEJCNM7ZliqzebVcKeXAcIlqvWCTO+4KTf72FmnAU3rkSEpJDdsoXhi7NpW479+Xga58wvvUTYs3Brg+qvqEPIQviKV/oPTo2GunN4gMUL0bKLalnT1e6vecjPLsIC46VjGMDoZjirNMhzOt/C9J+FOFzxaUd2iEL7XMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5ZQuv/k9E+NswLb9ej8+GLoK/8CznDbpyyADtVgBxw=;
 b=AREI7mFl6p9v6ktJ7N5dbdkJatBOJDoEYJPD+ZpaeouD4cW6VWVIawq62tZD9vksijyRzh0BYgjQpvt7ydZVfVpdO++mdNg6TOryU3q1BIJtQcsUNe0N5JdylTQjvnd/9en1C0R8ZlYeJjXv7s0dKaGYdnNWeNAzH9QpM77jrPYMUeiQ8XpF3XfxBUiXRzBsrP9oUqfUaER6dcvLBvV7qgCkQqMGlJ4XcgQcK4+xaJMOfXe+22bYP7sWo0330UdXHCIDUIWGVtjyxJHLKH8oJI8qP8xinrMcoTAWwxtRspdRmURwjFK78TGvvblvJn0+dSe36u1guNqiIfoEYOF0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5ZQuv/k9E+NswLb9ej8+GLoK/8CznDbpyyADtVgBxw=;
 b=ttlwl6oy+peUgOcxCThnXUnpz1DC0n3DTfAfuQKCRgau33Wmkv/p/+DUAlgbr+63mz03r1bD6JUKZTHj59HjzaVo7l3Sa8JKbVA/XJRYiHgUNcNKxhCG+iYUJkf6wzT2tzLUhx8gXlmAyc0LZOooiTsnY6GxnwakW+ArpQIuafU=
Received: from SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:13:51 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::84) by SJ0PR03CA0171.outlook.office365.com
 (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:48 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Feb
 2026 15:13:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/8] Improvements for IB handling V9
Date: Mon, 16 Feb 2026 16:13:32 -0500
Message-ID: <20260216211340.16364-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8c3b06-dea8-4ff9-d3ac-08de6da04780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2E4bDlmUy9GbXA2T3RPVHZVeEEyTXk0MVJJMTBZdkdUMjlTWmZaMEJjNUZt?=
 =?utf-8?B?a013MU0rem1CeG1Dd3A1SFh1UGxra25pbmJYcE05SUlLV1M2RzB2OFZSam4v?=
 =?utf-8?B?Y29xZVkvNERJK2dhdXZjYXZoaXlSaGlIOXluRHFralVzQVFZNFpGYld0bVVI?=
 =?utf-8?B?cTlhNWRnRzVCL290a1dta3Mwam1XQVVQakpZaHdkZzBwaFhCWVVjOGlLTG4x?=
 =?utf-8?B?TWxqSk1weDAyTFNyd001THRGTU1uSFFsdERkbHF2cmREa3Zhc0ZBZ2FFRm03?=
 =?utf-8?B?b3ZJWDdiNFZCM0hicmg1Y2srVW5HSndtQ2g1Wm0yYjFKVnpFK2h1TEt0TFZZ?=
 =?utf-8?B?TGxWRTY1bUE4aDBlaVREcEVSaXB1bWMvcWJWcElRWk5RSmg4bHJ0cGNERVFZ?=
 =?utf-8?B?dG8yZzBqUG52Y3JYeUVKMFYySVRJck9xRkxHMUlXUk02Q2h1WVFlWDY5Y1Y0?=
 =?utf-8?B?UXI0dWhVdzlWUFZzRTJKQXhNOUJRaFpDR1B6ZWs4S3p5aWVWSGppbW5WYWlz?=
 =?utf-8?B?dFR3Z0tycld2bGw1TXFvbzRlR2M1TkRhRjVRUDZqaTNPTlMxZysyYVRpamJq?=
 =?utf-8?B?dVdHWWYwK2l4dTR0K1dqQTBRR0JkZHRPUXg2WHh4ZkduZWJJdEhrd1dvOWYv?=
 =?utf-8?B?Rkw3WGQyRmJkek9RRHRXVmdLRXJmYlRCcE5FMi8wdm5JL1pLYUdEaS9EZi9O?=
 =?utf-8?B?OE5ycUU5Y2xlU09oMVRQYytZOUZCNGxKSHlEOUlXT2cxVVlPK2dFZy9QekNy?=
 =?utf-8?B?ZzdqdUU4WVdQUG9CdmRPdHl6VUJ0RVVuT2pQb001SWgvWHdRT0Z0WEpjMVNl?=
 =?utf-8?B?WlJWSWgrNWdJeGl1VkRJUnZENWd2bTI1MU56UHJkTjFJV0ZsazVkd2hzS3oy?=
 =?utf-8?B?NVBjSEpkdEVwY3BwcVZEQm56S0tzU0FXa3hRM3hrZEFKbHhSUTh4cW5RV08w?=
 =?utf-8?B?M1RXbUthWnNrZ0FkMCtDdkNyVEl2b2NRNVd5WXFFVENQNElyY1NSQzdjNGpG?=
 =?utf-8?B?bGlaL2VJdktpSmoyZkQ2NW14L1h6dlhrQ3ZhNjkrNDlVZTBGK1QyTEpOSnAy?=
 =?utf-8?B?N3ZPSlJRRVVuK1NkdDNJRkFtc1lkWG11YURjNzN4ZGZBenNtSm9LWDdnNVJ3?=
 =?utf-8?B?QXgrRGo3QmFPTTVqQWFycVl5TXBQVVQ4S0NseW9PWG5wM2J0KzVhNE5TcWdF?=
 =?utf-8?B?UU1mQm5ldlo3UmpzVFFlQjREd1dST2VoUkJsc3NlcCtVbU0vTDVxeTJOWmpx?=
 =?utf-8?B?V1hxeEpYSjZLMFNRcEFlZURkYkpTUlk0UmFmTHhqRjVmd3RXY3lSR3k3TEtx?=
 =?utf-8?B?K1ZsTGRTMXZmR3phWWtXUExubGd4ZzlWK2JDNFZQVHFQODFOODhkcktRa1dn?=
 =?utf-8?B?SUdIa3Z0WVFUU1R6ZGRVYVM3UEJEUzFEZ2Q3WDJxbStjYTk2eU1taFdQSDhi?=
 =?utf-8?B?OUdpTnpOSGtyV0xNeXFZNy9FcUhzT2lzblRuaEw1S3B5VGhkeGJ6Q0x2NWpF?=
 =?utf-8?B?ZDk1eE9KWXhvUHJCOW5MQzZDQ3k1dEJpeENLVFN0WGFyMEFaU3Z3Z2RkQVFw?=
 =?utf-8?B?dlBCNWFYZGdTaEdVQXB3OXJ0QXhmWGZJelhTakYvSVBtUmdKc0JOdytmM3lh?=
 =?utf-8?B?Z2JCekZvbVgram1YRE1LQkFmNlZwT1NjZEE5eGFxTDZxdEVDVHZ2aUNoUkR0?=
 =?utf-8?B?S0pFaGNjdGxrSjVkL3dhRklJbkg0VE9xT2VxQkxYYkJlZEpQMEM0NUV4SDdZ?=
 =?utf-8?B?UzVCU2xFeUFWMjVpK1J6ZFVDZzkxMmZ3Z1RRdDI2QnQzNzN1RTc1M2ZlNzZM?=
 =?utf-8?B?UzBHZ3RJMDFYZjNjSkZ5ek9aa2YxeEVjV0YvSUVwdjlJZWozdEZESjFydG5r?=
 =?utf-8?B?QWYvWDBJaW1PMmVodWtiOXRVeE1YcDR1cEFaVHJZSzlkZWwzRUdEUHNVTUV5?=
 =?utf-8?B?VCt3S0lWNksrQ2FUVXR4Y2p6NUcybElMcWdMOFdEei9RK2dPVmc1Q0U5eUN6?=
 =?utf-8?B?N2pUMjhseEo2TGU5b1VSWG53akEra3lYcEU4eHFYakdtR0FCd3JETENPRkNu?=
 =?utf-8?B?ODM4TTNSZUpuR1NhNEI1b0QxUlBQTnlQU3lzU1RGckQ5V0ZHc0QyMEdlZ1BP?=
 =?utf-8?B?NkpsYm55WGEwekhwc2ZNcUZYYTV5cTd4QW0zWHFabUlrWlc4MXc2VFoyUHZQ?=
 =?utf-8?B?QWIyejhqaFZMMHkwSldqK2xNcVJuT1JReVJDS0tpa09pQW04TEZWYTIzVDhM?=
 =?utf-8?B?WkZWYmFaUU5NQm5Ka0RFNTF2Rjh3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +5EjrxmJeP589QxJLsMbyA58AbsMs/6n90D9Ge/1SiF3K+zUFfkee+4pitGfdtnjV2mwSDBrJ4nvykJl9RNFYwLBXi2ZbCe2u5uaUo0ZMKvk/8Z5kWLzSMO8MlI85zTgmI900KRcx9IjAgrDT2EjOx69RVyRpCMI++3tSHu9cGyoQDhulzBDBvmjbE74x29qkN9bRLwZHcbXpbLXuDZk47AEHXWK4pg4bmPywgsoPFMndy6JFBAH71OnMQzfv0Zs4eonN3tiy3SUyKQh9aC0iI3N1n0xlUUv4534kXvVbGLSKyV1Ng5QIVCdFBRw8qjGRITGCgct+ktNJi0ZeFf4WmCnhcZRjC67fmFf1xbDk0ZlZx7E4jKCxJY3AKU6+saFKN8vRVwUYEMwz2ZQ0o8CsudzEmkCcbVrjgA3dQEpc6CJ3gdpLyiI32CoaR60MvKt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:49.4215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8c3b06-dea8-4ff9-d3ac-08de6da04780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

This set contains a number of bug fixes and cleanups for
IB handling that I worked on over the holidays.  Many of
the original patches have landed now.  These are the
remaining patches.

Patch 1:
Rework the backup and reemit code for per ring reset so that
we can safely reemit repeatedly.  This removes the current
single reemit limit currently in place.  V9 moves this to the start
of the series as its dependencies have been reviewed and
applied.

Patches 2-4:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.  V3 sqaushes all of the
IP changes into one patch.  Not sure there is much
value breaking this out per IP. V4 uses the pool type
to determine the alloc flags. No changes in V8.
V9 fixes some typos in the gfx9 RAS IB handling.

Patches 5-8:
Improvements for adapter resets.  Properly add the bad job
back to the pending list so we can stop calling
drm_sched_stop/start().  Return the proper error number
in the CS IOCTL when the context is guilty.  Now that that
is handled properly we can call drm_sched_increase_karma()
for ring resets as well.  Properly set the error on the the
timedout fence for adapter resets.  These changes also resulted
in a small clean up the the VCN reset helpler.  No changes in
V9.

Alex Deucher (8):
  drm/amdgpu: rework ring reset backup and reemit v9
  drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
  drm/amdgpu: switch all IPs to using job for IBs
  drm/amdgpu: require a job to schedule an IB
  drm/amdgpu: plumb timedout fence through to force completion
  drm/amdgpu: simplify VCN reset helper
  drm/amdgpu/cs: return -ETIME for guilty contexts
  drm/amdgpu: Call drm_sched_increase_karma() for ring resets

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 125 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 127 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  20 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  46 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  26 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  37 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  31 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  24 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 139 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 139 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  27 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  29 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  37 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  29 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   2 +-
 39 files changed, 689 insertions(+), 671 deletions(-)

-- 
2.53.0

