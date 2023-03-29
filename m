Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6FDC761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963C910EB60;
	Wed, 29 Mar 2023 15:48:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA3510EB63
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAPQ1UHswQCphBPeUFr2/rDvWIwuXMW6xXyRBOVMUWcdu9WK8vnrmyjB5UKIrwqz0kTi9iPiEnCLRIugFFH0ZjbAYWKGGf8BJvMRmPoqdy+1s/9YUNUJxkFFby7eAsPu1EBB7zogIUB+2OmaeLia6xXVx/DZCmrX++oCrS3bI2uhyQOu/qS+kI+r81NpztUhF/cFBxOSDD3KiGCWSbwfwK9yusegliwpXzLBPF+Q4tXf5ap7s/Ag2PCqiKqdaaSn3OD8S+tDJdJvLGgUl9Fh3y4cBODBh5TZQBZUq6m82t/HRXzxq3IAVLGk7O7B8lSJAKARPfVR95YwX81Psvit1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaQYvojcmWKNNDn7ygcEQCvJitovg9yekFl2kJqKj9s=;
 b=nKgZWsYaTRGdf3QhBtQ1J+2EeXrY3lgSAt8BawkppZtXZEhIa1csk8/zDZW3suE08RYB4BtC9j+NIKltU42PBN3UyAEO9C+rKv1TIbDtL//11/u/Agu2ZwOF/B7J6wGndUFS40vfJy2dvfRbeE1J/iWcZiMKnxZsXwTq6jB/jJPgeYBaIynICBclg0mu5ECw77GVnptDcW7sZypRoMQnP7ZD/UhOnEaMqabFsHG42N/OJjPd9/hDWk2BMEdfT49nBnYIOt3dtLOS4JdfcGf1pz3+pp1lIkpXQbYv0+/QlhlccbSksB0AGH+bftYSCuGX32MDBmslAlI+/9GdRxgbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaQYvojcmWKNNDn7ygcEQCvJitovg9yekFl2kJqKj9s=;
 b=dyEMDvMiqPMu7VnX0GSdGK2gTSO4Xa9ifSmqSYrvTL+iaVNZDe2EotsjY+Upq6gQs1y7z4yi3mLe98aEAY4i+PpJvZLnkjzCkfC0KTjGE1/1XDXrOlf35v7uDV/TpHW4/7FUaXOg2dmdGuZTwcmKseuomRzlHoSDweXQLn4CUfA=
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 15:48:18 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::4e) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 15:48:17 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:15 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amdgpu: include protection for doobell.h
Date: Wed, 29 Mar 2023 17:47:39 +0200
Message-ID: <20230329154753.1261-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc716b3-56fa-4e44-81d6-08db306d03ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MmheStntGiTZMTyf2t+aRvOf8KaAFaaqBieJAiqNOAgQOpYdaAAjmNcTVz7jBFlQifsbG6xTgQkGLKCx1PriARZN7CCNXg9SsMiYTNhYq6j5+bVS5NmuEu9HR8i/LuDxaUVkrd02WvNOqlcwp+rlrWpXeaMhydRpkdk5MqAjIAQL189PnIFXzpc4gjVZQyBkrPS7oPHIPhb7xzaaCoy+OBaEsqePpedL2AzzoeQxEx0QrmQBi2vDlgJ+iqoWzem7rnbCnYFtXHIuDD5qmDToVovb5iolhVXWg0Kblcwt+TW7j9cgnKN+3e+Iali61wpRo0Dx6/iZl7YBgyVL15SYi0GMw2cvWfLCcy32ZK4o6BAlDxBQrwWlDEJ9oJsDMCDq/lmXiElFp8HETUUJDNkKsbdhHIYW2jY4hi/T0GkKrwQ7No0QuouYq1IHlOKLEGfhEnhMXm0i2jV/jKKEN1zFtpvN9E/ID3PUzMieJZNWhkp3kJt422z7dKdNw7xzVBl9Esg4ksFJcWom3N6WaLxQBLrw/SMl7/SHm0KV5c+ckxT/XaTp6JiFo4l+ZWpQUBnv4HDHkFb2WBkRvZHSL05dfVIhX+N6hK+sw9qyKZEtV6gVe/qoZWIxhML39yzvAc8zYW+uAOWxG1rIBjKj7zBe+Ey2T3iS/dc6Mhzp4vxxG629ZTKezV/78qDT/atjorjzgyii65/usnUZathKRWIWABD8TImmHIiQUgT+kv1Zns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(1076003)(6666004)(356005)(81166007)(26005)(478600001)(54906003)(7696005)(316002)(82310400005)(36756003)(4326008)(6916009)(8676002)(70206006)(70586007)(41300700001)(86362001)(82740400003)(47076005)(36860700001)(40460700003)(44832011)(8936002)(5660300002)(336012)(2906002)(426003)(16526019)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:17.8921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc716b3-56fa-4e44-81d6-08db306d03ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds double include protection for doorbell.h

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 12263986f889..6064943a1b53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -21,6 +21,9 @@
  *
  */
 
+#ifndef AMDGPU_DOORBELL_H
+#define AMDGPU_DOORBELL_H
+
 /*
  * GPU doorbell structures, functions & helpers
  */
@@ -308,3 +311,4 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
 #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
 #define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v))
 
+#endif
\ No newline at end of file
-- 
2.40.0

