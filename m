Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F17C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 19:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC906100B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 19:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC906100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342DB6EA77;
	Fri, 18 Jun 2021 19:08:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895C86EA77
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 19:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC5PpwTHDRVOcciUZofLNnwsjfEgMvDIJjPCp9OIVNrB9hKg7rrECkGY64ciz//ynE3dqb+oawChw8XC8vPUErZxBtS9tlw2SYHkWDdmRM2QrYNTMLHupiK3+A2GCzoJzl3JUygQVGAdgO+rWRRq4MHf5YX/Ujr+PfjLri54PyiXGE0K7tM0bS9tLI4EECjGzRrbx+Srh0pKmpWGsvx7vw0R+yF8E8GoHFqC88gUtbVAGox02uXMY7PTT/7lV11JfUir80FI9RUv52v1ha2qeEs7QtKdP5z3+klYAdNAQHqYyD3FZGIEu9PkwK3lengJcnZbHWPl4cLF/HuQsdKQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgq2agD0c5ZppXpB7ZLstGJXWsxKbm8o4qtmSOvH14c=;
 b=IsRRRTLJ3ZsGRFN8yzlM8I8H7hjohUqDGS0YXbugr9+e0wtyDQAx75XByoERUiERwOHwkecHpUG0kyhwVtKY40qriUr2kkK7O75ImtId+dRcMLUOAwCZUaCwkdQkmh034+xY12l535aUQ+dif7oW04k9vriQBZFSOwGvbIov0afRlfseor/GFbMOoFa4nqFNf0k/tVXhlB1ETVqPs+qrxpxoHLbl+TpBzh657Xlu6jmUAglEUnKJxwridCpyZvusK5ocfPGwyP9vmohlHwo90WhMiRXvZO+tqpzqT5hnckNeB2dzkE1GaTjrM1PdNf5dPHwMP1R6acgUQtD77A/dWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgq2agD0c5ZppXpB7ZLstGJXWsxKbm8o4qtmSOvH14c=;
 b=ZVBG6sSHOc5CjaaHnISy+8NsIYYUoEJAtvZ8cZPV6AFoXtxHc01i1rVUOaSvrJ6TXAseDMPfDw1x4wgi3s9WnYTyfNWxWrOPdDTB0V3yK5USYjR8VzzHuXqazfuSaYfzdkzhudUM8DM6EIaJlXKyCIZ8Sp1Y7++VQVqbKNsW0OQ=
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 19:08:20 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::5) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Fri, 18 Jun 2021 19:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 19:08:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 14:08:19 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 14:08:18 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Fix edp_bootup_bl_level initialization
 issue
Date: Fri, 18 Jun 2021 15:07:18 -0400
Message-ID: <20210618190722.650921-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4ee0ba-d016-4e39-49ea-08d9328c700a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5443EE06B06D4C34CD526EA3F50D9@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owBSO1ttYn35fwfN8mZX8aevvcfc0pKhZNpC0HMPhIzvptGizfB/kkCZcMhMWdbofFmMSzIqvmk8OnUXMUn2Kzx9Nr2jvWiI//0Yfr9p+WMQrM1zRRagUiobyHFWFRHDFkPAZbNTV+gEtJwqEIE3f5g9mWxlbpa9//GSJTYq2Wm/+gw+jsuB5DPDdg3vUmIP35CNJkDZKXpRQP+E0GmLC/N6/x41EMSyd2xOEOjHTgYeeMR2TjXkFPAsehbovUcVruzgvHWtZl/R2QP19oVUbQpjmdyNDXY2yrXBhz+z3r/nftcs0aJI/JPaYl4IdY+M0VUMKMVmtWyWw86VbmEpGNNeT9h9v8M6d/bNOcMKBM7PZEJZ0uz+MY03kgocqN9q6xxdSUPafNlooyHRKqhAmpx/hxWMTF+ND8LViD+vVasOE8mG3lu3KIUy0f+qlBsTlziELDvFfRgKvA5JN0AepcWInSzuvzrQOh15QNDhn6115a7OjZfWtV5UGf2PBm1OtW8hlxnlZwxcf4y3iXyvPDIEAF873p/TnkMHNyUfV14ZDik/TYaAZFFcsVhYxgLKYRnTL1abIdNjGvkLNjUZNR/H+sqI4Dkg8pPDqp7DESipJ6WMI/FLmDK5dzwkZ+jflSvLGDBGST5LpYg/CyzRnZ5DWzh7BWazh2b8BKral1c3LgmY1LtPgEPSRE3MaNFX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(82310400003)(5660300002)(7696005)(70206006)(2906002)(86362001)(47076005)(186003)(70586007)(83380400001)(426003)(478600001)(54906003)(1076003)(36756003)(2616005)(81166007)(336012)(82740400003)(8676002)(26005)(316002)(6916009)(8936002)(356005)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 19:08:20.4639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4ee0ba-d016-4e39-49ea-08d9328c700a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Cc: Logush Oliver <ollogush@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Logush Oliver <ollogush@amd.com>

[why]
Updating the file to fix the missing line

Signed-off-by: Logush Oliver <ollogush@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 7d1c1b76d8d0..840d7aca17cf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2140,7 +2140,7 @@ static enum bp_result get_integrated_info_v2_1(
 		info_v2_1->edp1_info.edp_pwr_down_bloff_to_vary_bloff;
 	info->edp1_info.edp_panel_bpc =
 		info_v2_1->edp1_info.edp_panel_bpc;
-	info->edp1_info.edp_bootup_bl_level =
+	info->edp1_info.edp_bootup_bl_level = info_v2_1->edp1_info.edp_bootup_bl_level;
 
 	info->edp2_info.edp_backlight_pwm_hz =
 	le16_to_cpu(info_v2_1->edp2_info.edp_backlight_pwm_hz);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
