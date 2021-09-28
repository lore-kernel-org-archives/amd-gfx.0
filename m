Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E326C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3644D6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3644D6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919706E8EE;
	Tue, 28 Sep 2021 16:46:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBCA6E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCKQ0rXBVxL0OE3ji11MSGNkM+ANMl40RFIdIdfL6eOW8t2i8zNTd0BYjLDs+EG62BVSbI3Z7nKB+7ZvXtJNNr6DHAAdxG1zFMj8Xe45QqU/yaxYJr29WenaaCPeS8oftZUois1MlaJY69VxEJz1wp54x5fGYXhrxFnuc96yKWdUou+g8d3t/U5L955HruJG/i7dCzjUJVTVifFTDC6rm4Z88kaNssy6njcUzsjrIwqyNSmon6GyUWwFiJoKDFKO4P1IxKnt1QuFla54NCR3oOqpKBRt9fPtDQ3lVuFwF56FfwnRMJuYtOpALfAD61L3lF2dJgIdFOzjnlGnJjMg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=313Fp5hb4JohWoNiAitNs/zHCk8GoU6QT+NLu1XEH20=;
 b=bkJgv929M34AWUpi+ranKiDY6RpGQHD9rZ9+hR8s+OhYaBMRg0OtANTL/PGrA2KTlvplpSGwyjrO8cP4f/obZSVfj6rEzv3BP/frgesEM0DUG00v05/2L6ogU74G1eD1Z2rlguQB6JFtk5UyWdT3M+vON2KHu6EWiAQlfmAVekRytVZNRylPOCg57ouiaJ1KuKuocnHjn1AYSqxmTnguSver7plCIy9f6u4/dsSTwXZTkBYDIcyL+O9oGiQR9skoQTc9fdnPvJWhYUTb1Nii4enZ5vFYzKdi9nHzNkT2bjf9494KDE1F6ejgeFilV/ydrB+HI5PDvU3QmBq4uR66ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=313Fp5hb4JohWoNiAitNs/zHCk8GoU6QT+NLu1XEH20=;
 b=OCsZW10I6JDwRJri/t/zZiT20Yb7B/oDzsxImausWL4Fasx1EuJHlOahiUXobKxfE9Mu3I8OEYi+1nB5/VhOfjXvMwH5XL7/8nK9IcZKP4+FYfST48UKfoxq3SGp9AfnzmoC17L8IDdsVrJa43iAhkDcyQAm8ZmlQsXvp6c7kY8=
Received: from DM6PR10CA0026.namprd10.prod.outlook.com (2603:10b6:5:60::39) by
 BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:46:05 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::71) by DM6PR10CA0026.outlook.office365.com
 (2603:10b6:5:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Guchun Chen <guchun.chen@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 51/64] drm/amdgpu: add HWID of SDMA instance 2 and 3
Date: Tue, 28 Sep 2021 12:42:24 -0400
Message-ID: <20210928164237.833132-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa155331-bc5d-4c76-5554-08d9829f763a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:
X-Microsoft-Antispam-PRVS: <BYAPR12MB309492016639D0F78626ECFBF7A89@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Mc/dAbPf9WHlj2y/alfLMML9Zj1CkiLci3cC1SMXb4xSW9r7cqBGWD4QzYS2xNrhJioz4QjE1GDYeLmpEPtr2WJ5dsBiTAv6nOG0XTZHdHUh5BtRaA+w2ea0BlyvM+YVbHKy49gLqsiInPQW14Sz6+AeojVhrWv4Pw3jDC3wLsR+dD8dT+a5TxEo3s0IqrQdxym0MCg8Kwf+syDPS1yyD/KmDIQ15wC/926oolUE0fHFGnTTYjVp2F7yMpbv45/p5ozk9R2hGzA+u0wvyqny7cLlvPNvkkOcjidZeJg7/vthiVlVKhfMmPsXVZFkj+jPY0BECy3bI+39Bw9WLNfRY2n6LXqy38lFdwtrwhd79Pp6f1JeFgm/e/COoXG2/FE+2KQWrUgul7dkLfLnY0RPIR2cJ8esYl4FRXCuG0xU87h9tjMbX5dEZxEE9BKs7Ru/RQNdO/Jr4weUEh66yVjv5eMLy9iR7bmEL459UpAYgqFgiIiydl9rv2KKoswmbNOdeFDpt+19b9maSEEwywX+H7my+kEKQNi7QfWrWQ2nAv2i8sUKIlTUeQYRnW9L4oO31Gw5cOrWow9k/N8idtkZLEpGTMc/JJf+AzhcX5KiDoYOvYmr/LvdlROHaKe8dfQvSoQ1mYt8IUUkAszGz5skdYpv+1heLvYIQbHl7KT063tUZKCOC8GxnAH2pXFp65dkF96NgO/xDs3tyCqXGuZFO63DNIVK+9BkX3zsUD2WPI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(1076003)(6666004)(4326008)(8676002)(8936002)(336012)(426003)(2616005)(54906003)(316002)(36860700001)(186003)(47076005)(86362001)(81166007)(36756003)(2906002)(5660300002)(70586007)(82310400003)(508600001)(70206006)(26005)(356005)(4744005)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:04.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa155331-bc5d-4c76-5554-08d9829f763a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

They are missed.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/soc15_hw_ip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index 45ca4c921a66..c1519d20596a 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -80,6 +80,8 @@
 #define L1IMU15_HWID                                      65
 #define WAFLC_HWID                                        66
 #define FCH_USB_PD_HWID                                   67
+#define SDMA2_HWID                                        68
+#define SDMA3_HWID                                        69
 #define PCIE_HWID                                         70
 #define PCS_HWID                                          80
 #define DDCL_HWID                                         89
-- 
2.31.1

