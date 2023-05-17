Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E71C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25BCF10E44E;
	Wed, 17 May 2023 16:14:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AA910E44D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCDTE7Z0pNNg4Bsf57SRh7ARHg905QqFOyJW07rw5xdXjaNMauEe0M8dChumiGKgx1W4Yz1MbEQ4df0+Tb8TP6RY4QwF8aAkfpAgh6PV9qKX9tU5Mu/UJjAVEtQ88Uy0EPpa1hteM2AqMsvi0wL58R5Bfyqi6efEvTLvXFv54jdyivLP1zkEocVg3ljJxJlqWyJnXP/PuFCrJQdw/Qoi9EZEhMCS7bxImC0iTy7a+aBYlhT8LExzYAlLIW78XTqyr/dSnQX/+i2me2Z7NR3dnfjtWhOevg9nxjicROopeyzCcoEcQRbsDBI/QkRZLpOsZFHYeQCGh6S9T2/03nKOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBRwZ7qOvGFswWanK0IhW1bch0/6nknAxLH0bMlKt3A=;
 b=Ls/eTplNkfCFicm6gRJSPzX+U3x6t1i57cbGKSHX5xb3Hywi7+t81n1ZH/j5bTNXmizBNa8fzoFo6CKBS6rIe76tjU2h5sfCPXiKNnOoGxTcTsNE5Sc8yFd4TlBu8dnJA1dVh7cv4cJXYGraPX9LMl5n/b2A+M2u++1Hci0ED39uyKtflpCuZoKt20X7rXxQCYYYzfmeRbidY/GgJVUlxTbI2P/X9LCGnM39V9Xl6R1+H4XCwegCYsxVlK/NPCSkoXyYklt3hG/67FoOPgBL3s5NW+b2xEPF6tPzqU77wgeo+DsM5xzS8PZxoR3xMjjQiKBJm6eLUbMhZE9UhUuJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBRwZ7qOvGFswWanK0IhW1bch0/6nknAxLH0bMlKt3A=;
 b=aPrw1PJ2bp/jVZsOJz6nfOTyfXo/CWqEzNh8IQlRAQkQ/jYRcx2N4LUx/s5a66LP2z9PsWqUWofnlVMPeQEsqZoZqlS4BpsDiZ2XJ3UlG2HQZUIlp6QgiG+BbnUCS31Oo3ShwXLbXOHPe9GFBPEisiU/IAJ2CwWS7/m5qLlDz+s=
Received: from MW2PR16CA0069.namprd16.prod.outlook.com (2603:10b6:907:1::46)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:14:25 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::5d) by MW2PR16CA0069.outlook.office365.com
 (2603:10b6:907:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 16:13:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:13:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/4] drm/amd: Validate gfxoff state for smu12
Date: Wed, 17 May 2023 01:08:19 -0500
Message-ID: <20230517060820.5499-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517060820.5499-1-mario.limonciello@amd.com>
References: <20230517060820.5499-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 85824507-212f-4d77-5525-08db56f1c7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UVwKipRFT9xhSaDwZ7UaOFKCo14qhvs+fUt92mcAOeja1hgF/rafdDlsSthgmkAiL3HbOZzkn2IftJUyk0brhqTbB4lBR7HuWkO6eRoXTO8UXWxuUDXsJmD/cK9IktP0vlzPXEFcTq3oYJK5Od0nud6F87LhGn7vcNFMAa3/+Q1eSwDV2sqz3rTpyFNgGiat4FzBxsAGqzQojj7B3idwtty6KFmXkoVrznrf4HcSH37ZLMG9TodlGfDJXUJmh9VYK/y2zg7vj1WVIL5UPOICRhwo3sc43DU/fS/QbgdlvSrLkBuBm9uWXDz3XnukbB7RGVHDnOt9YRkimDrL326W8OpD4xNxOLjP0+CIuNjN4uvXptm0gWk0IOz10zpTBzB4DAr7acsv9ylbwJ4E8qDMUcDbs0KZSzEPiW2su9PsDpYiDZXKSdHM9hq3M9JY5wUJQsLR2nnAx8CM4qIqm8EssuaoEF1IZbeOpKW2/wphC7MF2qdE2A1GPMadM4rLZwEabNU3R8RV+mwBTAlrwjYt2rQEkOk7ahRIb0FvMqvYGH6IHYM85l6uO8ipz6qcGdynJ7U1Pv9o81Va+CPk1OASQUh/MWlMX+VLpqWdMOs9i8MrsHfyHy0S/fBp/aZhJUKeI3P7nlJNmPF8xEP4GsyunOXqF6mcRZY4M88IOoWCytbecRx10gU+eQxGgO4+0JkbnGSukBEnOcPX+tGqQ84B0ZipqP8YeRTwbiWE8xXSkgWoQIsDMY1awCHOR9wzWF6u1Nkb0dMWUgb7Iyoyyx1LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(47076005)(426003)(336012)(7696005)(54906003)(478600001)(2616005)(6666004)(26005)(186003)(1076003)(16526019)(44832011)(15650500001)(8936002)(5660300002)(8676002)(36756003)(40460700003)(41300700001)(356005)(82740400003)(6916009)(81166007)(4326008)(40480700001)(82310400005)(70206006)(70586007)(2906002)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:13:47.9227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85824507-212f-4d77-5525-08db56f1c7dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF may be flushed at suspend entry and it may be important
to ensure it reaches desired target state.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index c788aa7a99a9..869237cd0c2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -157,26 +157,30 @@ uint32_t smu_v12_0_get_gfxoff_status(struct smu_context *smu)
 
 int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
 {
-	int ret = 0, timeout = 500;
+	int ret, timeout = 500;
+	int target;
 
 	if (enable) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
-
+		target = 0;
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		target = 2;
+	}
+	if (ret)
+		return ret;
 
-		/* confirm gfx is back to "on" state, timeout is 0.5 second */
-		while (!(smu_v12_0_get_gfxoff_status(smu) == 2)) {
-			msleep(1);
-			timeout--;
-			if (timeout == 0) {
-				DRM_ERROR("disable gfxoff timeout and failed!\n");
-				break;
-			}
+	/* confirm gfx is back to intended state, timeout is 0.5 second */
+	while ((smu_v12_0_get_gfxoff_status(smu) != target)) {
+		msleep(1);
+		timeout--;
+		if (timeout == 0) {
+			DRM_ERROR("%s gfxoff timeout and failed!\n", enable ? "enable" : "disable");
+			return -ETIMEDOUT;
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 int smu_v12_0_fini_smc_tables(struct smu_context *smu)
-- 
2.34.1

