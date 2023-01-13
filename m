Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88198C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 02:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF05710E973;
	Fri, 13 Jan 2023 02:40:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA6210E973
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 02:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUCSKIyuX76cMc8BQ0RnLPajYfBLfM4toHG/0trWjHvi77rkGgAhdE/yCUYsC1kAjivzzmLFHtrhV6jXecrUfHqXVhSQB0iL1ff4VatFVGWLogzF6Fv2GbUQUkw0fyOYiN+IPRfKFneIFwe+HET153BnRp/FgUemBkwfDhr0DNF8WUB1be29ra7gtkuDuG48NXD3O7wVWRdzI2/M0/R99Xf41yLBjWMLfyzL8SBxFqd1C5ZSikKxG28Ru8jlyoZmjx/tGio2fyIsi57uT6ugUS/CdBA0hWe4HIrvnHqFelg2o73KKXe2abJ3pSjgRtU010HuujLDAWPyaEp3FhfGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8swK4g7M0pIMIo7nUeqaGlLV73djcMCVmRuGfPGtY0Y=;
 b=C2UsAtgzLQNvQlHUpCHRvbC1ubDF7W5QKWk4WmGZ5/PQgehrWV55GoAg9AD7XUBc7u1Pj2f2RB5i47JLPGs2cxQTMTiTSNG0ECwCjU+bnA8s3sNZBwj8e4aYOXjJpkdrtKPON4w9ZNZVfWpnP/aUcJol98+k6xHw7FC+t5NeoyVyj/Kx80Uo+2z4zkYzqepktqG5Vz7hAbtCjYVYS5SQVvx5436jh1DbCpbYCGH2WO0IdrV5L7plLRj30kfyYkxZOcQD/LB2+NPrLywzx2Zr2DjTlAB1zT40F8yXdjlVb02j68nY1Qx9CNMl5wsxz4qBtLFrQmdA2gI8ankqdRZ6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8swK4g7M0pIMIo7nUeqaGlLV73djcMCVmRuGfPGtY0Y=;
 b=ErlAgt5HUg0H7wktEuT5xJp82aDeuko3wZty05fQBZ+EuD6D4wZacM/trtjY6QOQjb4Ttt92k43UyrE7JxaYiYL9/Kn1ygSQweznJOlGQTqaZvG+WtJDiWL41u6Zhg3FG5SMBY/gXaSAlXZq5/3WYizC5CivzAxIZLe1BdDI8tg=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 02:40:31 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e4) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 02:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 02:40:31 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 20:40:24 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Support RAS fatal error mode1 reset on smu
 v13_0_0 and v13_0_10
Date: Fri, 13 Jan 2023 10:39:56 +0800
Message-ID: <20230113023956.18405-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: b50849b0-b45d-41dc-9973-08daf50f89de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbONrqJKugITJ1La2Poyzoe+A7kFggD3aGhEeMKbvOlDMz6KcRzJEiiZPFUbrqfYM7nyx9HPuHJHpM3qp24O/tUs0y9xRZPJ0cVHYo3zo1f5cweTIPteFSEqG/YfYemyVV/BnOUyZlXQnF9VwnefPxJUa3zTsvoo3ry6u79XUqn62lYuSYrCltx/ukQ93MxVgHTu2AeucmYPBuWyRAQricyfSeiQakkg4Z7p9lwkkcNiY8fK/pcuiMBErcZEu/FGllR+ceL7k9ecwasoetkm0XTNSwrghawCbXQv94bMrnamc/twXO5A4XBJ2RoEcvnNk9gLhj/VR/BDgRwnFBnDxyjZTUZgaCe4w2//qpBL8iRGsGcWyoZo6xd7II7kQXkTsq3a1Jl/LMViov/uez86GdgZi2eQFO08biwbdQhZ8cA9VZiuygeBJ0Pt58aI6grNR4x3A9gz7E9TOMcVUsU7Yj1V5CsbjdyTHxrhoI7cnlpqqUlVILvdEkM2mRSWcNt2dRcr+51IGtZHzXG0GWg2IMs9J+toRsAA8l8NPgVU2WUhXtYofzINefYqlLHwTRY4WZwy50ttyJNVFlYMaRlUJS2WU5C0df4h/4jiRVun5Uaduc4bFbz1W3SScJvlO76CqY2J/NBgFGPVXqvSkh6wE+HJyffuy/H5jl3ZyDHDLff7CoH7dL6VO/fmYob+o7sSuYcc0W7YK0ogihWAVLdCoA8AiyW2BBIy9k9TtDjPeLc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(5660300002)(26005)(7696005)(8936002)(186003)(16526019)(8676002)(478600001)(83380400001)(82310400005)(2906002)(40460700003)(2616005)(316002)(1076003)(40480700001)(336012)(70586007)(6916009)(81166007)(356005)(70206006)(4326008)(44832011)(41300700001)(426003)(6666004)(47076005)(36756003)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 02:40:31.1009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50849b0-b45d-41dc-9973-08daf50f89de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support RAS fatal error mode1 reset on smu v13_0_0 and v13_0_10.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 42 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 969e5f96554015..d0cdc578344d8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1904,15 +1904,51 @@ static int smu_v13_0_0_set_df_cstate(struct smu_context *smu,
 					       NULL);
 }
 
+static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
+						uint32_t supported_version,
+						uint32_t *param)
+{
+	uint32_t smu_version;
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+
+	if ((smu_version >= supported_version) &&
+			ras && atomic_read(&ras->in_recovery))
+		/* Set RAS fatal error reset flag */
+		*param = 1 << 16;
+	else
+		*param = 0;
+}
+
 static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 {
 	int ret;
+	uint32_t param;
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
-		ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
-	else
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+		/* SMU 13_0_0 PMFW supports RAS fatal error reset from 78.77 */
+		smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &param);
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						SMU_MSG_Mode1Reset, param, NULL);
+		break;
+
+	case IP_VERSION(13, 0, 10):
+		/* SMU 13_0_10 PMFW supports RAS fatal error reset from 80.28 */
+		smu_v13_0_0_set_mode1_reset_param(smu, 0x00501c00, &param);
+
+		ret = smu_cmn_send_debug_smc_msg_with_param(smu,
+						DEBUGSMC_MSG_Mode1Reset, param);
+		break;
+
+	default:
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+		break;
+	}
 
 	if (!ret)
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 768b6e7dbd7719..d5abafc5a68201 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -404,6 +404,12 @@ int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 	return __smu_cmn_send_debug_msg(smu, msg, 0);
 }
 
+int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
+			 uint32_t msg, uint32_t param)
+{
+	return __smu_cmn_send_debug_msg(smu, msg, param);
+}
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index f82cf76dd3a474..d7cd358a53bdcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -45,6 +45,9 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
 int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 			 uint32_t msg);
 
+int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
+			 uint32_t msg, uint32_t param);
+
 int smu_cmn_wait_for_response(struct smu_context *smu);
 
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
-- 
2.17.1

