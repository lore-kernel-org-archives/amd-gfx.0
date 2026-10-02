Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE398CA5FD4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 14:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5344F10E60D;
	Fri,  2 Oct 2026 14:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u59TyEGx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920F010E60D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 14:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecgecm555wfe0LT9Y5q1mQEZW9ysoBNFB11srcNMPyKY08jDIqM8KrgCQWClTidLbd99gI8ndcA/4gDiLywFcC5gSR/CZoNk6w8SOwuzvfKio5A+v72cNaK/VDkg+pVYNDaY5X3kmXEK4sy+LcKA2iMwwCtzbniDG0HBwxFoUv+E76zugApM5c8SS7PBOkgLh1BO1mw/fD9yzHWvFkS/BelSfxMSXn75JmHA43hEDVMkxtH/820sJ/UMsr19xtZK/cotoej9anUBrCUfBWv9DZfrrsLQYJVlQkAZARxcAUvfJyU6XGbc/ClLIuXIVBfOOcRwhWFOabQHC0StLvfVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSHjvlaJy2WdfX80Wv5YnVOXcjD6+KDQYysoBBL22SI=;
 b=iMAjG3HesEDG/IlveF+zGyFGm38VYf/S0BcmOtuBQF09ZwbeiLL0pQHjxsaFm5g0mj+enDLJhX+vUKRNeuk8MImSbfkVh0HdQ6bXcyvdSlsPNsobyXhQQeOy51zp/vloo0BR5TgOh7V43+QkXEXhTqd8U6YckndOOm1StdoHd2M06vIxDS+xW8mtflTK2ibFGx/3dW2wergWpktHtjFrkme0cxIt/8kSSul1fvtbPzJkxnIWPsUEQzhzu7QrF3C6P4KVxx67s8/icchk8vaPOHv4v6PCf1fiM+SJduIyaJ03wS2N/P1F+TOg4ly/zqyFPX9k1jBobrNIjAzV0wyWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSHjvlaJy2WdfX80Wv5YnVOXcjD6+KDQYysoBBL22SI=;
 b=u59TyEGxyI9PtvOgsfroTIwRJS/BQrGBh8myqQVkHtU/OtSKzjtazeA1oGGgQCENWaCRs3BA6NNYl0YyxAbR0uDKCmN59E1G6cMJnO1+Rzyd+2r/ZPAmr42bKn/r8NeWWwM2fP3OJYjjXNIM4xGXWEeWuUuEqWjbjwBXS42GAmg=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:53:09 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::39) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 14:53:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 14:53:06 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:53:05 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Allow VCE SEI command in IB
Date: Fri, 2 Oct 2026 16:52:49 +0200
Message-ID: <20261002145248.30879-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f47b118-827d-471e-112f-08df2094de3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 1IfXVGHxlHhiK1+Xg5GwHrZVLW2XSnFh2eg7hTSHZ7PrbwL6ppi1qRNxvDmeFSr59XOrpeaZhDG0I8ir4rRU6xQvxk9dTx/j97lDvhjiDWgAlrMyPx9o4ECsQoWcGFKkS/Ksv/QOgGaPq9wbbgntk+gebxKRBLswMFQtihiqDfATJH9v4Fy62kq+aC4wzmv9713sYkeAuuSwYiosbtXhe2Wdu8qmzlLB3+Twbb7994kT7/GjYovJ9wfrL6Nx9cVdrO2X4U2TcHVTI9fPtcOEnl0GiCp+6vyd73fKX49Pgcsfcv7F/ntgveJ6HUAo3rcC/+FRRr6lXO3KnYvyaV4m1RA53N+l+PaxFATRfg51n0n4jYn+N3rfaIFD8W+pIAY90pCmDQso/1ZxnDf6MMz1fKugv5zzTcDs8nw9dDMUZSQxa1KML0H3ogiqu87mY3EITpVKN3tntxlboEtVgRiL+Pmc6+aeKU6w9uH1u9FHkDLRqthAyJiHgBeo9z9C7IZO2vXwvYOlhvpPDGkANFIb5nFdz702BQw2PLyph1DwMAbVLkN5oatOYxuFB0RWijH6OXtad2raUblisJqnvhjBDsDqXRpFjsudMnW0H+l7DjAZYJ0m3QnVK6YxPrJA5Ey8apyn51NH3AQbtsR18VuPrTz6JdZo8FQFPXWoZYZ5Y1VmrsnjHSPciWENQEgPmpYMkzNpljSlzQIMNpQF4n+1cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wCJouCLI+uIfNZfbdRYtXFTMhYiqJUbhakoLeejjjIXVVglyyzJh4Y9LT2KRYCRgxBStV0+AHKMS8CeKk9qKxkTX4FVDmLBo/1r+8KgccY4B/KtWtJZ/4coG15ItZQH9PbUGFtHqicggkQb/FbDrnGTTbbDQeHvDGhqdGL2JI3eM+gLj0i/nEjLhKJZTAuAB/6EMfuGVC3BIGSvDmbRIA8R57pYe44crfWSh/uAIfgxokYO7BXqEqQiwwhTTX16ISBYT7Yb3Jpr8vZnGA/GQcetwkkGEvd0hKSwPy23gLtXtRY2uo5BOBYFOsPGDJftAAeZO1hpQzUil+4hGaAAObbeV32F6HtTcVL7dmarcPfW51IGNFk7wfylhyuAy+wTgJPomzgSokdADw08sRnwtI3v76lLgT7olQT5HlGWbEW/nZSHf7RC1bTvL6bnYlAxp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:53:06.5132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f47b118-827d-471e-112f-08df2094de3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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

Mesa will use it to get the slice offset in bitstream from feedback,
which makes it possible to filter out SPS/PPS headers that VCE 1 and 2
FW always forces on IDR frames.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 39d87f3df9e0..bfad44ec7feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -920,6 +920,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 		case 0x04000007: /* motion estimation */
 		case 0x04000008: /* rdo */
 		case 0x04000009: /* vui */
+		case 0x0400000d: /* sei */
 		case 0x05000002: /* auxiliary buffer */
 		case 0x05000009: /* clock table */
 			break;
-- 
2.43.0

