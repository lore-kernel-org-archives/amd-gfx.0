Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA3C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874B710E30B;
	Tue,  6 Jun 2023 09:17:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39E410E30B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKnMLeCO1QuHgIdnpKpqPuzgRuqWFPaSq0NfKSzPr1IYqATtLmYoPepl6SmV3hP3ttu6A6E8mNL0hg3Or1h6JhVJFCqiIuwf5ZvH6Oppbmvtdy+TJ/I83vC7qYnFRWcekO2t79f/f6fpQazd2LoXPILhQTDwMLMbcRy5XzwL30C6r783QA9FIVuIwjSuinfzXKiGxsmncqjRanGNDJKBTyRyxJ9ygde3JfiLsbxTVZ7BRHXzb07rWs4i9KZuOWBnpNngQf0S5Apy3uEf/G+Rjgh2qm2L9DwPVX0qEnoA71VLrJqaMMyfuuz+B/hMZ3oZwN30OizJoCYj49SUCnX4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgh7KYNezHIMPTrN7PU16Kl583TIrImXIcft2ZRVHtI=;
 b=b4cYQfhbZ9hufZ5dXKFeXZPBRT2MQqjSPZobZA7xxNHe3gaUSOFE8GWfRyjAb2HjBQ0kG1nQgJQQgGvMJP6SCG1bcxfLKBTSKZ9oy/tJDd5d0qbwFpc1PEyCR5p1TX1CR3EoC7jTtW4scstjquh8Ucw2X2tuaEszbYwxhj0zP7TiVathRzVKMEzMxW/cezk2Y/yx2WDd07dgJyfX3iGEqO1CdpwgIbdZt+kEMke7ObmYcDLlZzpBTFaOq/0rS/eZS5LBHlu445HLqxSS1OZQcf8kN3oAr6XuCoOlb8bztecOY5BQiMDDbrQ1V1fTaGhXVpV4WNY+zy+qzcesa8Wy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgh7KYNezHIMPTrN7PU16Kl583TIrImXIcft2ZRVHtI=;
 b=WsAAoUYiOesw45Ms6VSTTk41ErNYG3mhILaCVrOEv0k+i69q5PllFOgaFiBvpkAQUdnb9zgBxF4bb0cZcJbMdp5ufL8ct+hCLx7fVxMmsAC7jzoEvaBun6uIhMIIydrvercNPsvYh8W+w/4UvKh+5cANqQUHRYprPslkIbgERBk=
Received: from MW4PR03CA0066.namprd03.prod.outlook.com (2603:10b6:303:b6::11)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:17:50 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::8f) by MW4PR03CA0066.outlook.office365.com
 (2603:10b6:303:b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Tue, 6 Jun 2023 09:17:49 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:45 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves
Date: Tue, 6 Jun 2023 11:17:10 +0200
Message-ID: <20230606091725.20080-3-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 967165de-2a4c-47ed-57f4-08db666ee653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEx4O5jpV+fJi7VPYch1P4V+oXjfnQ2PJmAfRxRicxpTtzhbkV88NgVk+w0xDkwf7OT3udj0VPzSqSdIpvz4cUbirW7n0ENtG7mL246hW3XYLbvP/YCF5MSVXIr1tKBMjw2DLoyA8o3F509sV9N7gygmaS+TtYCZPn8s8GQgAqcJxC0shE4SNOIg19XxL1+Cdo8EPiQv0KSPVDMjBxROwcpmIyL/sd7whDKUzUakiDRrT1vAqvmvi+TgHfj42gmo5GxY+Afa2SMVd0WCuwoItmPK012U88uPjGDYGTHZmRp5Q51gp8pcQgZqYIFMrW0EtUyGBFCtFMjkwr8BAJnkWs1BoQpM8pFOJPtaozSs+M5xJWJ38Qa2D5dZHT3GE1h2JBrfs2zAI/cM+cSUpCLiPmRxuExOE+qE5Nf+8Da/uet9aHz2fTwvX+x5TKMVv9+Cf48h0lr00ebm0PsrrsrVV/LKQRE71bIW6a5hHuhhBmvNYfhp7u5dVnPglZSY8oF8cTcIvlHgP8G175jf3Q5r+y8vRMGfTAcXsTY23RJmVvx/2fWuXSnTwfMgwehn1MGZHswKujhX0AaF+aUhCFvIPxd16PpWHtjbloLi51iB5bs8whEhlweZSwmE7onXOp9MgkQIdXgvs0592H2nsIfIjNEPQT+iob/4vVt3eBCujXCpZTy7q2FtGlVeMh9vCw5B8GOvHwHdAh4spZF9UrzUg53fs24x6U1P/De4IXzrhkFEQ0lCiLZZB35uoJhK8+4bHFvpww3xLBgz9KOr/xtmAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(36756003)(336012)(2616005)(426003)(83380400001)(82310400005)(36860700001)(47076005)(66574015)(40480700001)(86362001)(81166007)(356005)(1076003)(82740400003)(26005)(16526019)(186003)(40460700003)(8936002)(5660300002)(41300700001)(8676002)(316002)(2906002)(110136005)(478600001)(70206006)(70586007)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:49.8152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967165de-2a4c-47ed-57f4-08db666ee653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/sq_cmd_halt_waves.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/lib/sq_cmd_halt_waves.c b/src/lib/sq_cmd_halt_waves.c
index 368e701..841b1d3 100644
--- a/src/lib/sq_cmd_halt_waves.c
+++ b/src/lib/sq_cmd_halt_waves.c
@@ -36,21 +36,22 @@ int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum umr_sq_cmd_halt_resume mod
 	uint32_t value;
 	uint64_t addr;
 	struct {
 		uint32_t se, sh, instance, use_grbm;
 	} grbm;
 
 	// SQ_CMD is not present on SI
 	if (asic->family == FAMILY_SI)
 		return 0;
 
-	reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition, "mmSQ_CMD");
+	reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
+						  asic->family >= FAMILY_GFX11 ? "regSQ_CMD" : "mmSQ_CMD");
 	if (!reg) {
 		asic->err_msg("[BUG]: Cannot find SQ_CMD register in umr_sq_cmd_halt_waves()\n");
 		return -1;
 	}
 
 	// compose value
 	if (asic->family == FAMILY_CIK) {
 		value = umr_bitslice_compose_value(asic, reg, "CMD", mode == UMR_SQ_CMD_HALT ? 1 : 2); // SETHALT
 	} else {
 		value = umr_bitslice_compose_value(asic, reg, "CMD", 1); // SETHALT
-- 
2.40.0

