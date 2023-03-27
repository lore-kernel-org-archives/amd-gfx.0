Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA2FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9752B10E731;
	Mon, 27 Mar 2023 19:36:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BF910E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpSpqiTLXspQ9L3TPuLQuU3LqUtyXj35XRXGnaZRdf22ilRttmcPC3zDwKvD1LU7mKktuw1uV9ny1Bk/4bgNlOUpxlGIOqVhRjeQRIBro6FnxzVbnkGovSFkXQCnd4fDYKnHBWTb4M9vGPxvUcD3AYCEVt+uGQOTfOUaW55TnPqMljLGMI3A8LIMOTqpTGKee2xxE3czzhSvWC8U6iJHhjsROBhAHwPAJmMOAK22XNXmDBP5XQXIuo7q34nY9tLbrnr26DAt4CvAVy4JMVPNrFNB+BOiqjcSL2LH0nKqf98lWHKKILrPHche33zgIc+SfNUmt+qZBEan7/Z51ToZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gRoese9l6CQkbUXmfyu3ofCwObanNDZJ8Ny2c+bxcE=;
 b=b9CIdpb5wZcnOkq6Lirv3axl7gj7PDGOE9ojFAJOlWUrrbE3gczNGtSDaH6gqp1svOk6WHXmFec/R3TQ1OQrHirMbVs4RRVFl0hCpEFEHK++9OYL/77UtI9zmxY23e+qu5ZlpxBWDio/cJ+qaZGmYnJiDrA5WB0caX9roGfzr1EmuxiGhypXidp8oNk7s/9gAViA5K9W17YcT5y1hqfjs/MK4U+vV1VRt8hBmqTApfLCM3Yg9zwMCrfjSH6TOSkN+lLNHkTDNEhju1g+IQiUNxK8RJ2LYwEWKcQ0PqB4nizWkWIGEYLTDaYQRFtTSmsMOxHFW54OvnFB/gw9XIyK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gRoese9l6CQkbUXmfyu3ofCwObanNDZJ8Ny2c+bxcE=;
 b=BUG7NckQ/bBdMfxgA/lK3RSgk+AFI5orxr9igGI8E3UhvWqZ7arJMMK8Z6TDMYAZZuvLvjA73udgsAn3IoJIQnsABw0Mu9Dl4cLEFRDhxNERMO7FcbCakKt65YYPq2Osio1h5wIYJqj8fWGNu1F2CzFgFGcAeHywd06jpAq/hZ8=
Received: from BL1PR13CA0363.namprd13.prod.outlook.com (2603:10b6:208:2c0::8)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 19:36:32 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c9) by BL1PR13CA0363.outlook.office365.com
 (2603:10b6:208:2c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/28] drm/amdgpu: assign register address for vmhub object on
 each XCD
Date: Mon, 27 Mar 2023 15:35:52 -0400
Message-ID: <20230327193602.7901-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 21898fb4-0460-47be-4666-08db2efa91da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47wC1P9AsBWmyMUIaUbYIqubeCHyTALcuK2wCI/k07StreJs8U2+ieDBFcynuXCukD7FyvYf+yHY3vasQMOz5TrL4hJieysxyi+u5SaLfjppRC0kbAoEL+lEWQ3FP1w8Q4iYUUph5r4UdwIEf96SSh6aHP6zNJq3NZZdJp8OoQK24DbMah/kOmJQtynCm7lh3yDgYWQpwx+fn/P9MKIiBpkKNiyf4TMTFDgwppxXgQtYhJVwf3nUAE5o7ZioddKEqQM0Ftsz+Uz/AkK3+dhubJ0IQze4eOcRz7IEDS6KFst8GQTV5MRvbQkkpmWRJblfLy/T1CiXmxIsDLFsecugfYvMCz0U5SFdjcau8iWxonPKgwdK7fadR9j+PzKhs9xHnGOm/k9HgHQKINaGnJHF/C/I3cvGkc4j3UGIfeUPpHPadbPSv7ov2kCuJ2Haemcp+y1bcZ+ca46u8Iuemr4M3maQiPGKb3guxvsq+fCz4Fn31KMAU3RjXioUIpw5aQo/cdg6n1gOwLS3LSJD/vO8UUpaErW2rM7n2T7nsH4BNiVm9B7rQF38p6HdGNLjv6TgbvKrEjufOj9N6KVanU/SnmY8Y/kri5hzMImXcdmBrQ85xr/kXVdrl3fc0iZKpFIV3czzV5SSgDToVlFpoyrhF7Mclg/ZEz9lDMc/03A8jxrCSG3X0YhJ5/4YNJgvZ6nv5Nr4eC7SFP1bBmHcFt9pPr5mq9AiDeR0lrWvLgqFjz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(40480700001)(82310400005)(36756003)(2906002)(40460700003)(478600001)(6666004)(426003)(2616005)(83380400001)(47076005)(336012)(7696005)(54906003)(81166007)(70586007)(36860700001)(6916009)(70206006)(4326008)(316002)(8676002)(186003)(82740400003)(16526019)(26005)(1076003)(356005)(5660300002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:32.4260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21898fb4-0460-47be-4666-08db2efa91da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Each XCD has its own gfxhub.

v2: switch to the new VMHUB layout
v3: fix mistake

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 58 ++++++++++++++----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 9c385ce3a8c4..e5016fea1f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -483,33 +483,43 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 
 static void gfxhub_v1_2_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct amdgpu_vmhub *hub;
+	int i;
 
-	hub->ctx0_ptb_addr_lo32 =
-		SOC15_REG_OFFSET(GC, 0,
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
+
+		hub->ctx0_ptb_addr_lo32 =
+			SOC15_REG_OFFSET(GC, i,
 				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
-	hub->ctx0_ptb_addr_hi32 =
-		SOC15_REG_OFFSET(GC, 0,
+		hub->ctx0_ptb_addr_hi32 =
+			SOC15_REG_OFFSET(GC, i,
 				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
-	hub->vm_inv_eng0_sem =
-		SOC15_REG_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_SEM);
-	hub->vm_inv_eng0_req =
-		SOC15_REG_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_REQ);
-	hub->vm_inv_eng0_ack =
-		SOC15_REG_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_ACK);
-	hub->vm_context0_cntl =
-		SOC15_REG_OFFSET(GC, 0, regVM_CONTEXT0_CNTL);
-	hub->vm_l2_pro_fault_status =
-		SOC15_REG_OFFSET(GC, 0, regVM_L2_PROTECTION_FAULT_STATUS);
-	hub->vm_l2_pro_fault_cntl =
-		SOC15_REG_OFFSET(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL);
-
-	hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
-	hub->ctx_addr_distance = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
-		regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
-	hub->eng_distance = regVM_INVALIDATE_ENG1_REQ - regVM_INVALIDATE_ENG0_REQ;
-	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
-		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+		hub->vm_inv_eng0_sem =
+			SOC15_REG_OFFSET(GC, i, regVM_INVALIDATE_ENG0_SEM);
+		hub->vm_inv_eng0_req =
+			SOC15_REG_OFFSET(GC, i, regVM_INVALIDATE_ENG0_REQ);
+		hub->vm_inv_eng0_ack =
+			SOC15_REG_OFFSET(GC, i, regVM_INVALIDATE_ENG0_ACK);
+		hub->vm_context0_cntl =
+			SOC15_REG_OFFSET(GC, i, regVM_CONTEXT0_CNTL);
+		hub->vm_l2_pro_fault_status =
+			SOC15_REG_OFFSET(GC, i,
+				regVM_L2_PROTECTION_FAULT_STATUS);
+		hub->vm_l2_pro_fault_cntl =
+			SOC15_REG_OFFSET(GC, i, regVM_L2_PROTECTION_FAULT_CNTL);
+
+		hub->ctx_distance = regVM_CONTEXT1_CNTL -
+				regVM_CONTEXT0_CNTL;
+		hub->ctx_addr_distance =
+				regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+		hub->eng_distance = regVM_INVALIDATE_ENG1_REQ -
+				regVM_INVALIDATE_ENG0_REQ;
+		hub->eng_addr_distance =
+				regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+				regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+	}
 }
 
 
-- 
2.39.2

