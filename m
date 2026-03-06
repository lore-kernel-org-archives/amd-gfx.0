Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53859FCC048
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34B610E0E0;
	Fri,  6 Mar 2026 17:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pIdWTW+e";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C2110E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6XdOqnyAAKx0iWvWPgJsbtazmA4D/AlqOoG1OncVYjPex/lDCno8ZVstbbOwt4YQywRB+0EDkPAIAtiNRPHlK6hKp6hn+TBkqM3o/3l3Uc5CDaHQH67/YmJNZLL83hDM0s4rm6ynrnZQi+Uz3ckko/JmzvFPFqQymZ9uEJmoycVMwyhvHivGn9MndXx6P9MoZYbBcZ/tAws7oQQ6PBPy1oIYVQwwYVc2z3vP4ukNjwwpZ04W1IQnEXIKFp5pVZg/UHqrR504WyGzbAUGHhqKV/LQLX11E65BqFJ3X3DbWytq6UIMD7GjyWXsl7B7Z/Bz+qKNcPeVnlmvzAaNKqKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvIHO53FdwJRg7MrofOwi4VAuwHswvUcZ+gWbVyRkmA=;
 b=QKWOaQXqsVQmulzOWD/rU+PnWXoBGkA7cE+efn4ouoCIYS5Ng5RVKLkG+N2f1ndQ7oAHf+MvUQaZrCsMPbiOiIN2H866vh20miv5Y1c7ppsfFnAWh5lOxVdR0TcdDsxZ8x1sPoFTxAfy7V8OWoKviGs2BBlrgjL5p5hcbM5XAEkCzUudMQze/V4HF2kQNU2/YN+n9AZYljLzdbNUOco9rEMMYzuM4sEPntamCBqh/7UMDg0rLbcNgPgbl4C1LrTykLd7UMbl43nIbzu/oHQP72qKmXW5r0S5R2E+VKtEFWnA0X52ifDjayuSxRqXHHmeLbCWkvdQ7yISVE5Pld1iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvIHO53FdwJRg7MrofOwi4VAuwHswvUcZ+gWbVyRkmA=;
 b=pIdWTW+e6GSASbNVSPZJdB64Ki/PviZtssxZ1ssxfodmaB0QqYo+MuMgX5JaRa7731tZIpMrKk+c+ZLgvlnW9nCseko+tUlRG2xUnXXk0367XoyCpxUl+8iRIY38GsyGJWkfQ+hDl/Lla5ZazgHGUNu28k/wwu15oQyus0x/U1o=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 17:24:25 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::3f) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 17:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:24 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/si_dma: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:09 -0500
Message-ID: <20260306172417.325169-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ded464-bd08-46c1-78b2-08de7ba5369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: 9ZoTiNZRsAA6dGOUTS3ge+uYW4o4ILEnQneRmEHJZ2Qh3mktPmSJKoiYepOBG275aSuHBgAvJNKBZBfeSMJgs8t2KEe1B69UjagiD/nwamOEnV8zoRPBlTqfvKS5xit0DI3ykQWrhlF17PiLDqdcABpE1ZZp8ofnU+7muTxEnPyqfGts29z602zIcqrkKZD0IbgbAbTNRnPJ0BAQxKviXjWTYlyghfC6OEtdtR0t0CtE6qwXFaG0TkECmJRxBoyIDKb48rSiAyLTZBUypib9Txla8U1e+u1zHORpiJjJNQxpzipWaf+ZC0wPQUw7x1jJf0rUflyM26HUQ0FL5lu0Ahk6Geo5FZP8O0ZIAl4gZ9LRVNOcilbR2UhzQq+ufb921aLL+PkJJDAbUpi580mxM+Rj8HZEJuAyMLwo9mbgrarE2aRrKdhiDu4FYTMNciFGzaTRwaRhcAUsL7X2nciLY0QwA7RLAU/XyGVif9EMC1PR9zL5jZnZqW7qmsoayhq2tKAtOXAkoC7kc7U7eP3vBBTI4AkwCTNGe9WxgzwWNVElAbO/LTs6psU5Tls5bnRyC9aHLRLCxUOIETrZhUNVBPIr4nfr/MMa+Zc7kWqrlI4U+EBo/r6Y6nAS3B72Yj6Na58gn2TB30WymndAt9SBGLLZhb/zPRAVsKrydHxfVCly0o+t6hchQJ0UsBz80MNDUTkW1uh4qIC3eJ+y0Bq5z2MW+MNMuWuZk6yaOjsD0ZWDuQgm6ISjksO5pZ6Wt/v0+U+lnF+c1sGrs0tmz0kqsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ri/Py7oTkErZbnjs/P026Wu14y3XvIBy1I8OGAeLshc0d0D+oDhi8TBGKRIpXGc6WTyrGnPmNL35ldUDiJbSw2+W4dx813XpMwaKk7LYCbWlmYKFXa6uBO8SUWhsW4bkTYxvD4lquBp1CbshWN7RTQBMGzrX534YjYMPGrPmhFdOiqobYR7yb630pvwVt447kI6LU8qemuc0SdB+U9Bf49hovGR+O5oEFDXJrTxLgGeUVgxV7C8ZZjP7evZWSVRd5Sa4C9+jVGNiP0+zBM92Uhbo/79QpzIniXZqaUAUg1/FvXYl7oAFW+Wpou2PNeF8EOTPPUMMl2UNNEhwlRqRCdSBv1hogSNknndcNYAVnkb/0hudLpDvRThIaYAuHwemm0Z08UktG7kmnrrTaSypo2gmapKSq1Usbmx5GhChCeRb/2/LiciSuiZmIpmRQfNg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:24.8976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ded464-bd08-46c1-78b2-08de7ba5369f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3e58feb2d5e4f..7cf9dfbf11196 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -149,7 +149,7 @@ static int si_dma_start(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 
 		WREG32(mmDMA_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmDMA_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

