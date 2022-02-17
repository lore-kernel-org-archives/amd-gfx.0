Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98085C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 20:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9FE10E77D;
	Thu, 17 Feb 2022 20:19:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD81710E77D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 20:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dys4CnEvCUf0XIhQ44TTlK79pWtn9u0X7NOslQACnoGZVl11thynSSLLm1xYZpjTrAVa8d1jaPz86BH3g/WJNKNH8qHxbp5987XgnULwHevd4Uy54uGnz4VrydmJNy7/FwMKH1GrqrDdTDLIePtjfw6f9LjkNEHCq8lhHZNJxY8bEElJ+EUYslQuoZJrmrtv9/dFRRkoC0eu2vDZ4w/cKL4xBEi+9rHbdpI7vScaUYtWArtBd8E34Q9Hn7JKL3UBXgx1bmCYxqUuN/n7yR7Vioz8zchUVy4x8G0ZBkbjok/L4yEfWbDjtIHa1U5+YQyGfYrXDVhjsfzNXQ6Sal/o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UNbZ8b05PIyZAmLo0fX3OaH1uXcdCV2CkdDDFY05Zk=;
 b=j6xWbnoLvYE6kgu5EYTiVj4DHUNB3tkm/PyGyDdpg7Ac8djQZ9qtluC2vOm/bEQUmPstVF1uG2YCfNsk3KxeNHDw2eFVvpcF99XUtruSHgZkIX6XctqG1KutHl33w7VilKD5kOc2It5NnN6uA+6ggfE7wC58ysO/RBOCq1gCtBfhFZeHHtV83ZQx79ryIi0e5QXTb5ft1R6o+Twd54/2RkZ3jrMOFBrowhtmAKUjL2Htr/E6hC4Vb9z+bRFDssjqskBb41oRDYpQkENzSUzjJfBwn62sJZHsSuWURQ/DQEFlKSM70w1O7i8y0L9IEIPvps6ezqnV50AQDdNYOxqmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UNbZ8b05PIyZAmLo0fX3OaH1uXcdCV2CkdDDFY05Zk=;
 b=CbrXn38LXYBnTEK5DR3wsFEcurOa2RC3Q4YsHf3bUlyGsxugZCukXrT9s7qT8LkYyPGlej8joHFl4TgUmmeTaZDZZIUxT7aEofPso9y0OvmhFqAvJwaCILVg61JOOlEF70mveXyb6yuaYNcS/cOqJy0VKJahMlEPwc/prZlgNmc=
Received: from BN6PR18CA0023.namprd18.prod.outlook.com (2603:10b6:404:121::33)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 17 Feb
 2022 20:19:41 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121::4) by BN6PR18CA0023.outlook.office365.com
 (2603:10b6:404:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.20 via Frontend
 Transport; Thu, 17 Feb 2022 20:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 20:19:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 14:19:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: update smc message sequence for smu 13.0.5
Date: Thu, 17 Feb 2022 15:19:25 -0500
Message-ID: <20220217201926.302025-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217201926.302025-1-alexander.deucher@amd.com>
References: <20220217201926.302025-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931953a9-fc88-461c-2932-08d9f252d428
X-MS-TrafficTypeDiagnostic: MW4PR12MB5668:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56689AB60271AF88F9F204F3F7369@MW4PR12MB5668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrNsXoS7+UP+u4PiD47HRIAM101digMxOOT4l1FzuKewsYihlIPVZCS8/Wknfbesk3G1pHbWGXvg69fz3MX7MAzHCrsYa8oewfgaXolDCGdvGH9bLPHe5WAf/oqlpmFDYt4EbARk70HNgtB0X6M7O7NQSRoEVeYZtIJtbew8mkbgbBU4KQtuzrwTRutvjipdKbsWFKa2DFgeB8b8V/jrH0tTCFXe84Un7qm0lHmxNInKQwGFdtQ6aZfCw66y8XcGayJfLSeSemZ5dpIjDZ96zAFiC/Hf3APYUFmaEJFfNHj70hBpJ/VvpQODPjd/qdmwEPIUJQLBmQjfK3TGjPeSJT4ufeRqZ/D4vIUsunrRfJwiV7nMZSSBXQGOgOtJRvFcAJgAmYpanz4K6BSiBbRwEUAd53a6+9m6B5i6ejLqwSipn9aFiLU9OOBud9n7/cruI//r6zonp9GjVOypqC07mVycsZiyNVSOJ2AzI5gNI2rI/ngV5ZgljBb7bAG8Aq+TbnVeHXAGw4GCK4+aHxYGC4J90zNPxBMb5sFNx+4fE1qG3JGMO4Svriha6+yulIKDcbmCd1zezvNvK2T0Bzo6nFiWzx4J391t8SCZyBQc+0VQfK1BTalDaq5NwbJhew2kCYr3FeSqg0odcJyhYVBE4E428LAHj+1vnI37HtGoSqqgCKqiXIwc0SLL0DnNqqAtNfpk81Oo1BgAUibKMfTwDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(82310400004)(70586007)(8936002)(54906003)(426003)(336012)(86362001)(8676002)(70206006)(316002)(4326008)(26005)(7696005)(356005)(186003)(6916009)(2616005)(81166007)(16526019)(2906002)(508600001)(47076005)(1076003)(6666004)(83380400001)(40460700003)(36756003)(36860700001)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 20:19:40.9496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931953a9-fc88-461c-2932-08d9f252d428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch updates smc message sequence for smu 13.0.5.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 34 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f24111d28290..606b275a2e94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -51,6 +51,17 @@
 #define mmMP1_SMN_C2PMSG_90                                                                            0x029a
 #define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
 
+/* SMU 13.0.5 has its specific mailbox messaging registers */
+
+#define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_2_BASE_IDX                                                                   0
+
+#define mmMP1_C2PMSG_34                                                                           (0xbee262 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_34_BASE_IDX                                                                   0
+
+#define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
+
 #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
 
 #undef __SMU_DUMMY_MAP
@@ -73,7 +84,10 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
+		*arg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+	else
+		*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }
 
 /* Redefine the SMU error codes here.
@@ -119,7 +133,10 @@ static u32 __smu_cmn_poll_stat(struct smu_context *smu)
 	u32 reg;
 
 	for ( ; timeout > 0; timeout--) {
-		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5))
+			reg = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33);
+		else
+			reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
 			break;
 
@@ -235,9 +252,16 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
+		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_33, 0);
+		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34, param);
+		WREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2, msg);
+	} else {
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+	}
+
 }
 
 /**
-- 
2.35.1

