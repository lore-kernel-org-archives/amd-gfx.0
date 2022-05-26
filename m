Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1318FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0610E286;
	Thu, 26 May 2022 18:00:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C869C10E286
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dasmErsT1RO7hVivyYHPzxR4Atve0v1BU4k6Sd5cmY4CaedJyoCNwAVJF0a+Rv6D0gINnv/Ara8P32fFHsopBfBzn6lX7486K3JTg78tbejY5LskUD4Ay2lYGt6k3TkdhT6YG/Zt8P3MiIF00KObyCaNt8iakg15OsJr0qMziLTmxcmxR2Hs46fCXEWsoOxCazngKBDPpIUyr/GkZDrxYsgaIMu2Ty2vTXbb4jr+eP/c6vQubooTW8kh4/x1nbIMZgN5m80JL/xWSN6esomL5XzcATq/woEGiqUkNKxPoGbXDiRFj++5xfypbOOX41nzGJlWSTJZ6uSfl9smG0W+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+TvHzrKAf/S/WBbvQ6vxItccYita40vuuNJLKh1CZ4=;
 b=n60VowW8/ERnvMu9ndESXvHqL0iYsyrFn0QOFp9JHyjOLKSbh3Q0/zte0SxysL1bOpww51o0mHnfZ3btfBuQMvC4Buu0Ms39H/Dxs5thFphnySmOaOI69acMRznB6bfGY1c1IqDA3ynKsUpuRPCotelJAy0jMENebL+LmdCjl5TKwz99BawIbekiZZSMtSlXB73W/EtFa5JFzPReKlBQIjv+qU8bk4lcy0gzlYacW7GqHOWQPO6GvZznjc+Tn2Ty7jd3ScRc3JMPu2qvcbAcePkVC2SahTlj/HEWek17iB83rXIb2pPrbbxVfgHlubFFkBAjgLDU2dJ3C21ybfPfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+TvHzrKAf/S/WBbvQ6vxItccYita40vuuNJLKh1CZ4=;
 b=rSRbBzDxcaH+fPqb9DHLhfROakWGPapfvvqZQ/QVGJI+N34lF6pfnsrxigq8YZczQ7Cpc6MAldKThJcuvs2Ow6ZcA2fYI1bzv+EnQBeFhCo+CywYURtxyerSkzIDdKtpGYYfwyVOcxDzUtXDfBZnTJuFkd0rqwOLb8/GzxKcNe8=
Received: from BN6PR2001CA0044.namprd20.prod.outlook.com
 (2603:10b6:405:16::30) by MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:00:41 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ee) by BN6PR2001CA0044.outlook.office365.com
 (2603:10b6:405:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:00:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:00:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/pm: update MP v13_0_4 smu message register
 marco
Date: Thu, 26 May 2022 14:00:25 -0400
Message-ID: <20220526180027.3044740-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e0618a0-13e6-410d-6b59-08da3f41a5e2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3344:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3344FA686FFDD9FEDAF0199DF7D99@MN2PR12MB3344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6WLyTgx5zTLxAiYZdlpIptQo/p/oLzQmBMd6Q4v8RexCxLEW8EWfxmJb+zWaQvo06o1CWEeZFX2vZZTlABPIACaUx3gr89COKkf7XBKAq7K5pQNTOF37FbSPtGv4bxAFHmUcyGaqQx7hHMSCXVNdDmLbxnx4RPr6dr/YBVMovMt4TIdn1s3qDmFu7gtqNfp4k4YEmcxgwgO7vvqffNqRoikiCYs2f0ymwuP330pCrleG+V/gOaT6w1ssbKLMUKKuEX1Y1C6YqNCnJFou/kagLjHiPgYAh4roP+BCJvs3UgpWZCZmckVHuTb4pdBF10PZZ3mUCRJAnCvVlBrXXKlmtNomJLYO9Hk5kEzZZGQTZsbmbQgjaN0RPkIH1HdVyTPNYrXP7iWAEzdeXUViO+FgzS/jq7vQ6NhGNWAZT8lw4iatBhdpVH4Feyx2pWvgbWCO0XBgWyfF0f+PTXMEF7SSptrEKNx+ppLqkV76fJNqrsqEXv9B7kYaZcMx4OjVvihsm1d/bS6kjQUcapuFiEqZsQ/7ipPeahfwlrpjWC88NJJiNeOrv0xO71K1I/TII856ama+szk7V5ULlBNr2zEs639X3DZXvtFTEWq9Y1d4rxJDiCR/UQLp2FCHHg9gPOP4aSrKlV+FtiF5ShLGnx7EyZcedEGjaol9rCQbzOdeBYkt81i/TK7mXxNg8ev1VmqH5PuGuQhb4LNF+TG0pYoZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(1076003)(83380400001)(356005)(81166007)(5660300002)(8936002)(26005)(336012)(54906003)(47076005)(6916009)(2616005)(426003)(16526019)(186003)(7696005)(36860700001)(2906002)(82310400005)(6666004)(15650500001)(4326008)(8676002)(86362001)(40460700003)(70586007)(316002)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:00:41.4068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0618a0-13e6-410d-6b59-08da3f41a5e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3344
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Update MP v13_0_4 register macro for SMU message

v2: squash in missed case (Alex)

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 5de7da75d14a..5215ead4978f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -51,6 +51,15 @@
 #define mmMP1_SMN_C2PMSG_90                                                                            0x029a
 #define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
 
+#define mmMP1_SMN_C2PMSG_66_V13_0_4			0x0282
+#define mmMP1_SMN_C2PMSG_66_V13_0_4_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_82_V13_0_4			0x0292
+#define mmMP1_SMN_C2PMSG_82_V13_0_4_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_90_V13_0_4			0x029a
+#define mmMP1_SMN_C2PMSG_90_V13_0_4_BASE_IDX		1
+
 /* SMU 13.0.5 has its specific mailbox messaging registers */
 
 #define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
@@ -92,6 +101,8 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 
 	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
 		*arg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+	else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
+		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
 	else
 		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }
@@ -141,6 +152,8 @@ static u32 __smu_cmn_poll_stat(struct smu_context *smu)
 	for ( ; timeout > 0; timeout--) {
 		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
 			reg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33);
+		else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4))
+			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4);
 		else
 			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
@@ -167,6 +180,9 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
 			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
 			prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+		} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
+			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4);
+			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4);
 		} else {
 			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
 			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
@@ -268,6 +284,10 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
 		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33, 0);
 		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34, param);
 		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2, msg);
+	} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 4)) {
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90_V13_0_4, 0);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82_V13_0_4, param);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66_V13_0_4, msg);
 	} else {
 		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
 		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-- 
2.35.3

