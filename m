Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86316C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 07:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43EE10E1B4;
	Mon,  7 Mar 2022 07:54:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCC110E09F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 07:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrKbKVZMiK+xMRnaN8qBqeNxoCQbGN8S+rEPSbm3HBgG4zNDmTJem956GuSpmJIdnr+v5PbOG7p2DoQPEK9pzhZ0hlR15TIN6ZriyCMgJRqZAns0WQj843VQzfV+0g9JwnmzXjkR5gtfTE9mr+Zf8qlzHVZi2r5dt2t/qLmq/dYi5ZCzqLrFQ42+wCYResaWuSYR6/eyuJoDIYCpUx9prDX3VFnA+zASqWNueY+UV8ynPlPPBRnXlJQyp066aOvo1fu5rhF99YkvTkCNeNExBi8OzniQbXsZTMpkbBv9dWcrWaKs8MCfJZWcQojNaTPboOk/OBHYR06AuQ//t0IRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPjzCP6iCu6uODt4YYm+rKHdsQcc0geyc/JjyJUFo2g=;
 b=h3IObAepBlZLxvNMCfj5uPU1gIUWOt8yvH+exrgLFTJbhzhLcMkeMg7ZKGlBSf859Pb6ZV/cF8hub3aeVn/HXDvKoxtwMtyIP+E+A34jpUgvorsvJQ0AcfMno34KzUzY+gJpcP0v2jH8HdoRDM76leOtBBUpgeheFJBiCzvRkKTSlk8in5SduR3G/7T5S4t30xJtoqwqy9xQEo0Y69MWqWNFN12g0ITW5K4ueUvtmMtvlsWmW425VArJS+qWBF1lpg9Iz1vlAXzbcxfg94F26eKC8KcD/JgQPbr5sAIsAJI8Qcz2jIv8aekTEfdWv8y+rtHyH+AcC5WvE1hFyNFudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPjzCP6iCu6uODt4YYm+rKHdsQcc0geyc/JjyJUFo2g=;
 b=bElMIXbVADaBmbbv1niuW6bWPB8/kt/BwR+gkOi20Crc/ahnfGVTE4kYsVLKYAKJEmHGsdv9pw2/Ywu3CYrUimZv6Eu3C5OQyJSx+mMkBMJMgdR/JOSOMsFs9m6e42/gjz809wJIVDo00g1Vf5kW+sWkpJ14+Vys1ZiyiI17jEI=
Received: from DM5PR11CA0013.namprd11.prod.outlook.com (2603:10b6:3:115::23)
 by DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 07:54:45 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::ea) by DM5PR11CA0013.outlook.office365.com
 (2603:10b6:3:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Mon, 7 Mar 2022 07:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 07:54:44 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 01:54:41 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: change registers in error checking for smu
 13.0.5
Date: Mon, 7 Mar 2022 15:54:12 +0800
Message-ID: <20220307075412.1984581-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f922e76-e3d1-4c68-3557-08da000fbe67
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2505BF36815FA140C99D0219C1089@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBM8JrkmaEvENzSXHKC/NKolhOxKVgnAR4RKVKC0F7nJwuoefTQAqzSZzxQPIEhg4kCYZm2L+a7+v+thYf6TVMV/MMuxZTnPYDcn+FnXD8IE/qPwyou14mBRWDMyFVZ/9YzzC0X4/hAZLY3NXygrT9dphbfjgJfgdsgdHly2CyAOeaAx0s4B8kklXinhgUYSbXG1bAvCHNWboMvH8yHk08jlPrQLSiJ+HRn9Qr8NEbwz7Ja1mYw4dY71xoJmycviDjVJX9i9g4kMe4flZTwsU9fq7Z4LfWekIKXlMgv92l4FlBfjuPDDZqMtAdmgxnRgIFC0NLiSoc9I/ox+RVGiu4EhUpP+rnf7UWNGS63T/BehqJgIxHXQSzQ2oqSjTo4YXB0D9wqRLaR4PRl20/xHACgDzwg9LE29jTYtJi0GwYq8glqElkrGJuaTghqzNih1q/XUyz/x9MAWjK3AZxWJmVKSJYmF2NpbJJ1a/BJj77ky2faHok9ljja4jQHxLPaEhlhr8U3zEH9fd6i+jdzx8XHg2QcJWXOlP+9qWhVyRSX06VbYVr3BE2bplaEdoBwh+y4BMkDEw1U4fCrh/RTiaIE/R9u+LKOLMrO4exUGWH9mqYBBO7YGBFcizI/upnRPvI5mnnuxSgF5X8Dec+MLoIXb4qK76YOcsE8C1K7O2nATGKuVAmvbMjxjzft+4k3aU5ZFRBc+jjigJb+SaMg5rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(82310400004)(81166007)(7696005)(36860700001)(2906002)(356005)(86362001)(316002)(47076005)(70586007)(508600001)(70206006)(8676002)(6666004)(4326008)(336012)(8936002)(26005)(16526019)(426003)(5660300002)(186003)(83380400001)(36756003)(40460700003)(54906003)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 07:54:44.4353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f922e76-e3d1-4c68-3557-08da000fbe67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu 13.0.5 use new registers for smu msg and param.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 590a6ed12d54..89b22b261066 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -160,11 +160,17 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	const char *message = smu_get_message_name(smu, msg);
+	u32 msg_idx, prm;
 
 	switch (reg_c2pmsg_90) {
 	case SMU_RESP_NONE: {
-		u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
-		u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
+		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
+		prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+	} else {
+		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
+		prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	}
 		dev_err_ratelimited(adev->dev,
 				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
 				    msg_idx, prm);
-- 
2.25.1

