Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C09DEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 12:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC3810E1F8;
	Mon, 19 Jun 2023 12:42:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541EF10E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 12:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNet+9HNmbj2O8ihZGi2Vr2aDZGh8tjUYyz+lp4YKuAldqw2Fv+s9e13wdjtgmFoSYa0eiUobqPk/Jd+dY1uO1piEooCH9yP/g8Ryic9hxkBoa3bcmmFh0xsIQ/7ic4ojK9JnJ+5Wec/oG31C/8DlThcmwPSz89bOYQj/jCb2H+L3v9J2pYheV5Z+V49g/cWSvnZpND7ppXLdU9nRZiZDppaxW6uQo3VeObxG5MDb0hAbVmfy5H6MHOdhqV2Oxmw/cQIvS9iTuanfql672fsTThu5MHklWq/BzjBcTPURqmyLdnsQkiKpw5ov8XQ+T5I3mZx3C8hn2RjXYmkbQ4+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oolfi1kMfVa0nnNmr+09JK9AFVbsy+LCLKd+DxCil8g=;
 b=Hq6+oDxr0negpQM1Sg5kwCZc2FZ7mP08eLTbEDnkDovagw06kV+xU/4uaG52wpC6BGdaWJtRLLfo7iDsA1sDI/gOoWnxjNuf5bRXadyzOjagS6ybK/hF4JdKSg09cuoNe+xbQJzCtjVjR6RTNddJua3YNh0QrCQ8bvFvj/qCR7h5JnlVue97RjOFcCAEn4TP0s79Mjo+2haqVJcJoY2CjNji6lBwJfa8Gy/GErLv0dmOVPMBniiljxP08OfOxmE/VCuYmWe6oUYKzP7A8NDXsvqpEQTJE4Xc/oc/r/snx8pbDpiq0pgkTJHobUvAVUBdJCs1K8eS45y/P+DCGvi4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oolfi1kMfVa0nnNmr+09JK9AFVbsy+LCLKd+DxCil8g=;
 b=0OLXIrc7KuGkX2RDbUlHnUnYTPPEaHYRWTQS5a/nYZhi6/xginDZXLK5ngIv8c4Viwq1mONv1xHcNcrzKFReg6bW2vibXBJ4sSW4bPaxcPvyMP1jsyU+3NxjW9RxNrtUc9L5+7e9wVnHef8usdmJbdQ4Zhn97ulrfCOclfVuZCE=
Received: from MW2PR2101CA0009.namprd21.prod.outlook.com (2603:10b6:302:1::22)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 12:42:31 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::98) by MW2PR2101CA0009.outlook.office365.com
 (2603:10b6:302:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.17 via Frontend
 Transport; Mon, 19 Jun 2023 12:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 12:42:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 07:42:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units
Date: Mon, 19 Jun 2023 18:12:15 +0530
Message-ID: <20230619124215.2085234-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 34beb126-a2fe-4f49-9452-08db70c2a67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fh6QWA+WfqAPRTWidsI45qulMZgm/NfXkSldS2WipkDMiwjyat5hI+NZ+E1LVKUmjd+F2jUQ7Cw5/JY9zrfszf8wj15Me3qYHEWPEVKrEkZdDC8G1nXrYaMZlyAs/SAsv5jksF166u6rqbyte4rPwMGsGX67K0Ik+5yppIWudva4+9/7PDuhv9E6/4z44lb1D/Sj4fElsw6TWWXU3I3EitlvoXKb0PUoThovk3pPpOwLBlmIN45z3CJudcuj4mf6B4GYghdA/d93tJU+Pr9mpQMNS2/N25sc7WeTFhuuKO/jO9570nAZdBiMVgx2h7JjANf1v6ZRVqE95APZRObNK9qq1VrQjto6QVs4/kQ+kmAVRdV3HnufzJixonPsSKste0eP2wnJAKGXySYZN6GoHyzLFy2kodqCpmhK3dXLLs6sJMunK+MWruWAjEdRUF2TUwEPeMa5sfT5LC7N5hdMETSEaoWZjojBWRymYlSQn48YPYzf4C+WKSyeW06WiL1bxwGH21aq33/gM4KptI61i5pfssNJlsz3QOeDywaQsmAXlrNpiGrL8fJfszGl82hLbS8ZBiAYYkR+tgqbWSBpFx6cKKTp1oNrI56IyOEZ9dJYdpU+gRJXYAn1mCSAX7o84zfIBtTJ4PuGoWaOWcxjkhlTsJ7cLDQrs1U11yb9gOUsOD0Uo1O6DEzO6h7YzrXReiO4sibCiEFQB7z/MJaAtnmXPPl8XW73JhyFpTp2U0az7S1S2YxoBe/DmBMBNyKfUGlx5Mj+9nDQCBSsnN1H5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(54906003)(478600001)(7696005)(1076003)(40460700003)(26005)(16526019)(186003)(40480700001)(6666004)(36756003)(2906002)(8676002)(41300700001)(8936002)(70206006)(70586007)(6916009)(316002)(5660300002)(44832011)(82310400005)(83380400001)(47076005)(86362001)(426003)(336012)(81166007)(356005)(2616005)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:42:32.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34beb126-a2fe-4f49-9452-08db70c2a67a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Publish energy data in 15.625mJ unit for SMU v13.0.6. The same unit is
used in Aldebaran also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a92ea4601ea4..6ef12252beb5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -200,7 +200,6 @@ struct PPTable_t {
 };
 
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
-#define SMUQ16_TO_UINT(x) ((x) >> 16)
 
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
@@ -1994,8 +1993,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->average_socket_power =
 		SMUQ10_TO_UINT(metrics->SocketPower);
+	/* Energy is reported in 15.625mJ units */
 	gpu_metrics->energy_accumulator =
-		SMUQ16_TO_UINT(metrics->SocketEnergyAcc);
+		SMUQ10_TO_UINT(metrics->SocketEnergyAcc);
 
 	gpu_metrics->current_gfxclk =
 		SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
-- 
2.25.1

