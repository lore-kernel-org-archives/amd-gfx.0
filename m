Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CC0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DC861106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16DC861106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8FD73784;
	Thu,  4 Nov 2021 20:52:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB2473784
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhu0YCHQWvAFWTH3BIbPMqCTr2yTSNeTRWzet3FL926QGhtxkydStpdn2P/y9eywMOfLFgGSehEtt/nbw6RPALDVZNc+iqTXT4V+b3cc8Z69XUy/vggkqQYLSJhVdZWXLgT/RTlcAvyo3ZEUqs3M3zylWLUXXPZromcJ4Pq6zHPh/FICAeE2BgaGi/k+A4LzXFkBREamwfkbKv6RBcZaVlw57O9DtqmjLoQnvWOU4dvg48qOxkUL63Ej5ek8jYUcCmO9QuP58ab/O8LKVemNOv+878Q9DCQdgvetiTK6i7rUi9VOfck5VMZD60GqXrPgEl192VtQfQOLf+N3wtMo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2diz/PXyCqN8ov0rvZQ0kik69TwV4h42ZVS5tSnBcao=;
 b=ePBllKtSX1qB4fvWAut4C/dTKW0JO78nftlWPGC4YKn96gOUw/1Nahgu5Ua2G3nW5j3aGwHNVBVjw0p2NG+m/VaGSSjCjsp1bgFgqWUvKfn5V4woAe6f7ffFHO/68GC67fNI7d0I7FeRqAFS0Ud0TguTQvspiEmXz79asfOquCgtQJo3LF5q+X+Z69EioirNs7/Mk1UXrv3enjwXzydHJOciD+N8ZxnqSt3YELRlGzw3j/DwuuT5ohAwXuI0PYBqQ2w67V0wTMthNnO15eEqKiT4ox8ujrJ5JXwAEorWTH52Hp4nKsvqS1984neKx5AS8As52B8biiDXFIOIkoBCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2diz/PXyCqN8ov0rvZQ0kik69TwV4h42ZVS5tSnBcao=;
 b=dAG16BywciHUOjHR9TTHIonoVtoBEy5YwTAuleLP/6B30iaDngw8SFZZ0sU5Dpzi4c/MSnmrV3rA7g9M+QnPsZty9ua9/mEQ9L6Gni9qANlx0YT3OGUEJHkdzOtLUCRMaLrWj8YjP1DmyUJJSt3NC6ZKc3U4oQEEqnmN4CcWfu0=
Received: from DM3PR12CA0050.namprd12.prod.outlook.com (2603:10b6:0:56::18) by
 DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.19; Thu, 4 Nov 2021 20:52:38 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::73) by DM3PR12CA0050.outlook.office365.com
 (2603:10b6:0:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:36 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:30 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: use link_rate_set above DPCD 1.3
 (#1527)
Date: Thu, 4 Nov 2021 16:52:03 -0400
Message-ID: <20211104205215.1125899-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7396765-51a1-4447-2be6-08d99fd5091a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35956421A0027F5EFDD7A3ACEB8D9@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVrLovHobbnxtsfTJXxWu8sE6XZvrJRwHiVGcHeoCdcxRD+v8ygvTgHsFx0hUxV/QD6Ql8mhVMioUZ0fHjvAEM+UuDC7DdeTqZjlAjkCDEFy/q1VLZHxKt0RWjq07yMcMW0FXVZgG9FwWEgcAOZB+IiYWlW+BpzcEjGId/4zTtn+gjpPVp++vN2gRHPxn1jaNUIMicbIaQrGD/w1KiwE65hHfPDOQoovdotsnKQJyNTqh4P2L7GLuiCLMaxucHc869gqKXhxW02jsoLq8UjqpHOiLnaG40IizM5E3tmqhT4H3vV7UMytioXv4xpFykh97Tmeopd5ZU8J2Nz1x8cYNPLJsRrYdEa4vMmgckAWKnlc2x7ZhlyIrp4J/LHwRNuF30+w2aWvoAeT5LmPq1dnL+7eoKFGiuxs3Jt+cwsk8o/4YyZPjEyjM3kkAeSjaDtt7/YomXNULF4Su3jRlSkue1iwSfg+unKsf/9YrXX9LIQddqfj/zHWY3msWidtIJWW8iUij3rus4y2ePicBE7nK1Z3d8eAAq5AWgm5AaH5fGkQi0BQ/+nyhn9KwkXGZMUzD2LYi8tl8UOAymyRyQSKNf11uzzQ7R5Xj9td6PEXNlV9l2x/ci5TRkaff3ysW5pEI+INsGSpwzg/PWgeTuH7DbrqQ2VOMM7XzKpxoNSAzuGC5neMPQ4ZFwQzX9DYSySsxiQ8iQcOFP9T+ovjymA+++kKnhLDlAqw/CuD3R9f8KI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(508600001)(426003)(6666004)(336012)(70206006)(8936002)(8676002)(1076003)(6916009)(26005)(186003)(5660300002)(7696005)(70586007)(86362001)(316002)(4326008)(2906002)(356005)(36860700001)(81166007)(54906003)(47076005)(83380400001)(36756003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:37.8326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7396765-51a1-4447-2be6-08d99fd5091a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 ChiawenHuang <chiawen.huang@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Huang, ChiaWen" <ChiaWen.Huang@amd.com>

[Why & How]
According to eDP spec, DPCD 1.3 is only for eDP DPCD v1.4
In dpcd_set_link_settings function, the driver is just above v1.3

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: ChiawenHuang <chiawen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cb7bf9148904..b21f61e89cba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -430,7 +430,7 @@ enum dc_status dpcd_set_link_settings(
 	status = core_link_write_dpcd(link, DP_LANE_COUNT_SET,
 		&lane_count_set.raw, 1);
 
-	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
+	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
 			lt_settings->link_settings.use_link_rate_set == true) {
 		rate = 0;
 		/* WA for some MUX chips that will power down with eDP and lose supported
-- 
2.25.1

