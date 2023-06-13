Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF876C7EE29
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 10:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BA910E368;
	Tue, 13 Jun 2023 10:54:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AC210E368
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 10:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB3Xh+ys+ciF6T2sZeMjf/cANt7P37b5eIJmlGpsq+yohICyP7TN7MFf+/CiUpaHkS7OAei6TNnQf1CFuy+9nyaPup0j3S/F0tBuoD4wMS7Sg0cwDOLxjMOUfq5U6u2qNPjhXTpu8rQihPSGjOpO38EJWtubZBnod/kyu7BqSTPD/IrI9sSuPf1eHhqHyE+GcR/SYhOpkVg2uydqiExJFN22dENKUe3ZXGkG/8TSwTB/KYb7oauGBseKTR5kptRmBdigDwWk0OSSVNYxziCiYMDnd/S1eE1s6e8NbatSYYRmiaQTpOoshR2HOz3ox5jbeN1k4yQmUX2dPToElnM7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rKnQrHfhbv+hMqjl/1DCx0ZnUpNHaDSNAfZCqoCdVU=;
 b=UfqJpHMm82TwfIzEREEjpQiSYrsYqZaoRNRYEA+G7cFFASGjjbCFo1LbWecByqw2FdZZmxfp12gOvWLy4O9jr4LKmdLdazSqFTcKKy3kuhLsXRKppTYD5kO1aPw483uiNe8ewoinvvAx1TxeLyaFlSk/wtqi6n0qlvBwQKeqhHkh0rBNTEgJAPDxVoJaDH2U/a+feojK9Aape4mz6T5EDo+UNahci+IB4tHswy8478BMkf/H6C2C/T+zvXnTu093nu6sZTXHKv6uXanXXGb/VMTtWtCp/79JgVJmAhF9PUfthCIajvfD1fQPLbK3axSIUzYU3fxvaLT1GQrggJVFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rKnQrHfhbv+hMqjl/1DCx0ZnUpNHaDSNAfZCqoCdVU=;
 b=n8mTKmKV6EcNDm86V5YKA5MS63Cg19UHT7p/wIfHZUlpcAgIJ3fHl4IEaQQpqQOJdT9tFd+cqkC6OmWfG5Y3PXjoa5uaotBEwzG3sC4N+J+rs47TRfqz9rRdABpFWhPwMq3al22JBlHuyXLBbXMk1/BWd62OeOfnQUvxbfA1Tbs=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Tue, 13 Jun 2023 10:54:11 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::68) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 10:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 10:54:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 05:54:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Change nbio v7.9 xcp status definition
Date: Tue, 13 Jun 2023 16:23:52 +0530
Message-ID: <20230613105354.1561876-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f076b17-e6f0-4458-583e-08db6bfc84f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QI8qGttaDuCJq7lQEuZFSYupuL3xpyn3+1d/s6P1myeD4m1dtmQ7dxdeh+FXy/SfIjsm+qEFkIG3mjh9UJJk7A/z9CowkOjAX4ynasl8BoCP243Ju8nSldYbVNiVtPKBLbK1MwTLWG2HqX33icTF19NXjvFpFmB6R6I9y+Th1Z42N6d2iF+QYkl5Yo+/2ZsoOCanjom0P0J3YMI7B1aBnoXUTwfwEfbE5sfgPaptwQvkw0z21qmhCBOiPytb64201lAi/xBQ+f7SX77k4iKg6lNAo87PNcSuDj498RZqjU8CQe0S6ciLXvwxkkmIIuatz9wDT3fqnKs6WuzF0SZaLKZ+l9wWtMLPglv8TnKP41x6PpFt0nIL3Rn0ZfWZaZHR504TL/ZnPKi8At3TNibxluwKk5nRLRSGxbOY7uPlBH1fxk2Zf4wcqzOoxlXCFdxEbAXqDNp+AvbIrT1S3VRaJ7aigg8RKXHCiZMbXedEFhQ/Z3mE12Bc3ZwM2nRKu8jhcFl+n96/TsB8wk9xoZuS4566Xah99KA0EQq/AwDv4K+bkjxmR1RK3BW5g4zGicDZ0LEzL3Qxcm10psf/9eOapnsrN5FWVFFCGPRFvm+reZlgVPbsTeeAgV4FzUOtvdvRG/PrDeMXisWI3bWCudvFHyFDoLho3qpdsPH70+zxFA/5JTBkbQ1EIO9rD46GU+92DIDuPWsWYnyT4flDKNklQnH1X+fDT/4CL6XQf2raowHze048q+YP7F+bi8hohwtLEQbYQ9q1lvHE/n7pw/+alW0Ed7eSBiVZS08GPX4HdQhOJM/ZDYpu5cHIKlvo6GSg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(41300700001)(8936002)(2906002)(8676002)(83380400001)(336012)(36860700001)(44832011)(426003)(82740400003)(356005)(81166007)(70206006)(82310400005)(6916009)(316002)(2616005)(40460700003)(70586007)(4326008)(16526019)(186003)(26005)(40480700001)(86362001)(1076003)(54906003)(7696005)(478600001)(36756003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:54:10.9140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f076b17-e6f0-4458-583e-08db6bfc84f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PARTITION_MODE field in PARTITION_COMPUTE_STATUS register is defined as
below by firmware.

	SPX = 0, DPX = 1, TPX = 2, QPX = 3, CPX = 4

Change driver definition accordingly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index d19325476752..b033935d6749 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -390,7 +390,7 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	px = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
 			   PARTITION_MODE);
 
-	return ffs(px);
+	return px;
 }
 
 static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
@@ -398,12 +398,10 @@ static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	/* Each bit represents DPX,TPX,QPX,CPX mode. No bit set means default
-	 * SPX mode.
-	 */
+	/* SPX=0, DPX=1, TPX=2, QPX=3, CPX=4 */
 	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
 	tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
-			    PARTITION_MODE, mode ? BIT(mode - 1) : mode);
+			    PARTITION_MODE, mode);
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
 }
-- 
2.25.1

