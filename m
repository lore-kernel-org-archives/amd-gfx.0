Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75418C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 14:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DBF10FE04;
	Thu, 16 Dec 2021 14:14:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DDF10FDD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 14:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6agzH6uIrz4WzYBDCVq0bve9sGNhOub3yUWTx8I5ooIGvjFpYh396bytQhyo/Jqr89mdDGVVEmbC/NVFFYPAPYnYxmRGw06IV3NyPfffYFVdVB20Jf/C4cis93EZTNEP9zLzeq6uqcrsmrqkQFj7RAUvW3wg0CVOzVCnjFLDl7bBcI6tBi0wYBD4w6osj4gfYPAqxWDSOshBTwMWf7N0bFCbu5kUtsxJ7yEw5RK7y6AOJ/PcaAvcy1euaOoYAAIGzUaVqMY17/AX8MxRlMQ1dd9Crb+RvDZSblglpPoNBUPvBCTlFaVpwoa9hQFRQry+Z0bdLByu15HkbFAUuZ3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHXb1ZxjHF/wIoNhOyk1MiIXJUW6AL+7JfcbodIQzu4=;
 b=hv3Sp+L5eZonMf11MyKB1p4cQdfU987BmpUWbm9LquIwz9ARhJ/djSkkRLyATe9IzcOnqbv55GKqvj2O6jlwdCNaTQRUL8EWa8uNz/ee2zbJkuyRyjmJn9SVc39QRDR30yveoQB/2q2wa+1OwNd+2Ff0TTTzGF18MmcbxBJxHVIex17T4fChTO03SEsdBP2axbHc4v+Kj0ldRKFM3Uldswme2iF9HawHD+guO1o3jCvG62fQQs2n2dCNnLsMYepz8WxxmoV+hiLOmfKBs/CoGVLCdcNykMwkSHFcxNoPSHbrc3vddWl4KIDPwCa2rcKbcxti8K8i+ul0krvSS2kbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHXb1ZxjHF/wIoNhOyk1MiIXJUW6AL+7JfcbodIQzu4=;
 b=3ptKIDzFgsWOZgUeqW5v6rYHBe9perU3uDWrkQvuJjZ9whEU4J8i72nhL/8R0facYIyGXJFMUgY7KK6h3amOyvZMTZY6DLwzB8DgghsadcZM4b7LtypRzK/aMHV79ahkWaRcFZGfRUct+Vazju3NijVnyias0fWmY/SGHf+FzT0=
Received: from DM5PR13CA0049.namprd13.prod.outlook.com (2603:10b6:3:117::11)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 14:14:33 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::78) by DM5PR13CA0049.outlook.office365.com
 (2603:10b6:3:117::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.12 via Frontend
 Transport; Thu, 16 Dec 2021 14:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 14:14:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 08:14:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: bump driver version for new CTX OP to set/get
 stable pstates
Date: Thu, 16 Dec 2021 09:14:18 -0500
Message-ID: <20211216141418.299554-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216141418.299554-1-alexander.deucher@amd.com>
References: <20211216141418.299554-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc52180b-56f9-4317-ddb3-08d9c09e6211
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45484EF0C9BB38723F91D9DFF7779@DM6PR12MB4548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykAKECgKkPz1zIJa3K71rljEZlVcLIzV6YLlqDUr/rbLmAvmGWw8mBorMxes3Daoj1g3U7MMDM8Q4bSCU2VWfXrGvAmQgCJtRGM0Ai67iH86huuJyKH6HyHzbaspoSNZRJ9H402Le1J7mdeH2u2JpTajm4oLvZu6hVCCqN0Ugwo8zC3wnejqYv5opJyQXKpnnfaKu2ADtQvWJJDA3j2CKFvQaATa5wRvAkBGhT+jgDhzAKmJ8oVO7RdftumE7t3hD/koMCxik2+54d0NOTgDZfGyQN/wQIVfgYxUjn3a9JaXd7Iuhx87u6XAlAk6OpNQfeWCc2jNkdHPaOGYye9qnmGDDwEOPA3bSPcIlGM2S1Tt4YHp6K4fjnuH4zTxZrJ2cTealQXmveos0YSBYpHvnxy7sCtVitnkx2CPu/yoM8CSINcLYlsmCnr0YjO4yhMAFdfA6iksYIuBkVQk8F+7P9xIZgU0qnOYOLN+4V9CfJreRY7w7P9N1H9iaurilMHKOEhb/xb3/oROdcZ0rDZUKW32Spzm+E638fvvd0U3WUjXojsCHS+VeUm6YgV7HGX2ge4Mo+d0rEHNr4Vl4fPw6xAWO1Wnnr7pWT9DOZtbHK1koaLZUpD7p0l1GqzbQv+SKMGhmIqXqQkmZs6Zr9OKqLw88pXkZydpDWPHY3hM3kNn4mF3VI35nku/+dE1RvrCYGFx1nmbbmSix8y2g+xSY1GRaOXk20DGrQ8OKEK7Ptl/PHJq3yhtDych//0ELIbJ24sF3lxVv6OcbPxKLlHo0TeHsxVf4amyZ9c4ZL0aI1g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(7696005)(36860700001)(47076005)(36756003)(2906002)(5660300002)(40460700001)(82310400004)(316002)(86362001)(2616005)(508600001)(4326008)(6666004)(70206006)(83380400001)(70586007)(26005)(81166007)(16526019)(186003)(356005)(1076003)(426003)(6916009)(8936002)(4744005)(336012)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 14:14:33.1481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc52180b-56f9-4317-ddb3-08d9c09e6211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So mesa and tools know when this is available.

Mesa MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/207

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bc1355c6248d..320706b3a8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -99,9 +99,10 @@
  * - 3.42.0 - Add 16bpc fixed point display support
  * - 3.43.0 - Add device hot plug/unplug support
  * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
+ * - 3.45.0 - Add context ioctl stable pstate interface
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	44
+#define KMS_DRIVER_MINOR	45
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.33.1

