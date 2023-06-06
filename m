Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F0C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132A310E308;
	Tue,  6 Jun 2023 09:18:03 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E7510E318
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+EiFgBj16Bz30tSZxHTdn91VlizodkfoLGJFhZfqwMqRV7yvHQ+owX1QDXBZ7dbB5PZDeNYOUDKzcMDaaSSTos1mwkf99RRMrSkZSxUSovHsRPSHR28cea38S8stYBYeLZZ0DsAh7YW4DujGzIyKkqeruY+ekF21pq3+ZbMG9a/7Bu6G/pfDVd5FON272Pl3N6Z+NsGkQFjRgd8vgYoeq3/lyJwnU5IOtFCbm+VsmxRXJvimAHDPlkbFCIWabMdUoafNZ2cyDj4Xqn7HybxQrXtGvaDVqVdwXbuKzNpvXG7oi8K/Du/eXuDDn16hRse5AyFTcPz/cYbWZxX6Q+7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCaFs9gClYdfxakEnEkQBpxSYMUf4pxJ1JegmJFdr9I=;
 b=kQSyw9zsjJDR3Z0ztXkVwE3xfElFy40jUKcgz19AIEolwSyHvbs0EI0mxwpRepwx8kzHfv1vi594AUjCAxNJYo1TCsjUicPiJdBquLVAvqc9TkSq2/v1huFIGMJ7ENuFXCrWbL20ZiGHHGQqRAk5bTxHHh5+1G8+G+FEJ8qbSqx+So4Ztg1z2ASqLBH7yrUOIvXWbWUj4NLFPCvl4KDzr6azRn6hBqvThDHJFrmNe+CrjG5SEKOzJ8G9D9lxaxcAMIDXRQPkx35BxDoIES8jOebVOyjMH7sGWcU0T0LQWuZFmdWHMxOe+CsSs8URIdNSrwJIIlgST28H+t2/LJY1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCaFs9gClYdfxakEnEkQBpxSYMUf4pxJ1JegmJFdr9I=;
 b=PM6noKjJh2m59VmPEHukBr87rcOP+UWc0J7xdDvHhrP/mwlnL4rNCITB3PnyfoKW4BSvuTxvPwDC5aB5NW58ubA+0ouIgoPS2+zmKNaPoIBExn9GoiR21E102UNoKLT8mQ+vMNQvWCexyeq/ixEHrA664pPejIOwZ+3H3sAXGHM=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:17:55 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::93) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:55 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:53 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 10/17] gui/info_panel: correctly identify the GFX11 family
Date: Tue, 6 Jun 2023 11:17:18 +0200
Message-ID: <20230606091725.20080-11-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e4b3d8-c8f0-4b86-d031-08db666ee9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23Hg99mtLC6gux8usOtHqL2Ew15i1hKxjaqh//nAeYLZQeaPEF5ykOI6gmSmASZvLvmN3nPon6+vbhfZU+CbmDaRFRPkOa18yJrtQV1GCreXaDTdNK4Y+rVheEnR4Ll+dd9InnAnBiOadu/Yocg8yPeZ+8UNV3Gj8BDnhtOH6XSaBjp8aCEJJoGlTmyW7Fc3A7BFv39I65/FZbGWt66G29Bm0eoegfmKzCYsEahIIYsHgyTp4k04QLPU0xl4C/uiJicWoOSbazLjgY4r8KjWnDOhZ+EaOWZY+63aU62AhBnUaEewgEHz+Q9oTINR4+YQq4Nw5/tb8e1xEbQdHGLC6zIRW+GVlndokD2DsKCE6++antkRX+5sXz8Y+zmuXoarJpyrM5jrnYe7wtOA8K+MKa925jK5nuFWekVebuDVFhZWlJ+H3gpcthyWah+QUv+K485Q65OPy2LgcLmVHqROZIsA2evEkZuM4DTHZkIsYH4/rV2YD9KjgpdLtmfAQlW1r2cTVL3Jgong2zMu/Qgf234kokOrBjqP0oyLOJH+cCe7Mj2JIuT/wcSDVqJBSIaQa3mXP1PkTfuHY7OrC9u6ATjSVaaCBf/u8JbrbFAwCXCcg3S8C7Wk5bYDthtU04xI3LaebQEJMbZ3lnCJ2lEa2FPSOpshgAx3MAt8h5onr530pnMI7EMfEkhayiiR403yTiaKAk4puI/Av+2IwXEiPyejOnqyqwkl8ztD9CPH+4XxHYO2kz3oN0CTUAUvQHvTeP3J0/v9teHgkN/59st2SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(2906002)(40460700003)(36756003)(7696005)(66574015)(6666004)(36860700001)(2616005)(336012)(426003)(47076005)(82310400005)(83380400001)(26005)(1076003)(16526019)(86362001)(81166007)(356005)(82740400003)(186003)(40480700001)(6636002)(70206006)(4326008)(5660300002)(8936002)(8676002)(70586007)(110136005)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:55.6837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e4b3d8-c8f0-4b86-d031-08db666ee9d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
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
 src/app/gui/info_panel.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/app/gui/info_panel.cpp b/src/app/gui/info_panel.cpp
index d9c3421..bca7137 100644
--- a/src/app/gui/info_panel.cpp
+++ b/src/app/gui/info_panel.cpp
@@ -25,21 +25,21 @@
 #include "panels.h"
 
 class InfoPanel : public Panel {
 public:
 	InfoPanel(struct umr_asic *asic) : Panel(asic) { }
 
 	void process_server_message(JSON_Object *response, void *raw_data, unsigned raw_data_size) {	}
 
 	bool display(float dt, const ImVec2& avail, bool can_send_request) {
 		static const char *families[] = {
-			"SI", "CIK", "VI", "AI", "NV", "NPI", "CFG",
+			"SI", "CIK", "VI", "AI", "NV", "GFX11", "NPI", "CFG",
 		};
 
 		ImGui::BeginChild("Info", ImVec2(avail.x / 2, 0), false, ImGuiWindowFlags_NoTitleBar);
 		ImGui::BeginTable("Info", 2, ImGuiTableFlags_Borders);
 		ImGui::TableNextRow();
 		ImGui::TableSetColumnIndex(0); ImGui::Text("ASIC name");
 		ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%s", asic->asicname);
 		ImGui::TableNextRow();
 		ImGui::TableSetColumnIndex(0); ImGui::Text("Instance");
 		ImGui::TableSetColumnIndex(1); ImGui::Text("#b58900%d", asic->instance);
-- 
2.40.0

