Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A1C001DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 12:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F61C10E13A;
	Tue, 25 Jul 2023 12:04:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F407510E13A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 12:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF/dtHuCM6WoPMwQZubIkQSshAF7dpWV3XrR9ZiLDenYjbH6VrHhgaVe3fHs4LKP/BLIt9TZmQ82103fMwBtVj+Qe3PCdIghxGPGYrdTaB3z9qAZ/OwzM5HYXkS65TbuHJSnrvI5zH1k3fIwTrBy0mSFqZSC2laE9mpcgh+LqYhB8dTx9LDGAkjZoTIPLgysKmIXt3klhC05TWYIZpMjfCH6LacefyeGR8IXYqZGvy4/yDHWiPD1qaetJD+89mNHReL7TfvfCv641DYaEbvoyfvlzViYS/qxXgAy1tqr3xRpmHXwAeoKAjKQYoFdyq9i0XxJLMf86dvfPBWvEIt0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc7JqCvldssyWBOM8W4cVfzz8oH3aRUsNj8ey+D1FWI=;
 b=cUGVlyKRBQTCLVlWFGP6ELMbtd5F1TkQmerKzB5XTgEROPlF4/RbU6iZRHOkne21dua0PcoNP4lKraTESo04L4xPf6hCR4guzj1RKxgwomdb8lOaKY2KBTyb9sD5JvHWfGmDWbwp50N0vHE6Og5hme3MKeWT2GYA0RKQtjJp66bN4nFIFwpac1P38nZQn6sQ8WaCNPP1yQnuZKJcN9G4ev4uwlf9AIcZus/F2Oy/Od/pCICK9oM8VxepcySLGnFkDFGqaWETFUcb5QJfSy7CFtt30MbAdIc1F59ujv7BJ9dDB3SpKD6qwKOEdmd9s1lobbW3/JbkXHZbFDEB/I3+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc7JqCvldssyWBOM8W4cVfzz8oH3aRUsNj8ey+D1FWI=;
 b=CbWPGPWgI5rVFIyOhNGUpk9FFy8OjrvdyMV75BJ4f5efJ1k+eUR+dN/4nWYSsdjbV9BlbPLewUv1ihF5kODto/XibnbV36aX/i4/rquQzaw1LlUSUmyIOhukQ+wjqkDRwbJ8kjJuYwNDLoEjZ0iP3OzEMgQMg+dOzSCZAE3/nC0=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 12:04:43 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::95) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Tue, 25 Jul 2023 12:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 12:04:43 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 07:04:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix no new typedefs for enum _AMDGPU_DOORBELL_*
Date: Tue, 25 Jul 2023 17:34:13 +0530
Message-ID: <20230725120413.2285840-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 24020a93-ac85-487a-ed31-08db8d075521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+ZgKToRUrjMEsRrs9VzHIJ/omWuk0EzrpIUGU1bUf4EqMKDb7ifeU+v5Nl357ba1itO02YyWMQTdtVUyXjM9bKAYl2/Qsx35OQAHpOxRdyMzHjCVTxUzkgbSCS2oP9K5Uisyoa6mH3pnwraipzI+5VfChwfO2nJNI6DNH+KVyL3VxfhIinzmaO3iskaZahdgnAfqbOKvna3TtMgKclI2i5uL9Z9y6altYFBaKwvBCV6/pLfn5hNMIqDXk8Mq6Qdv53/yGuBpMTgngG+IavDticVSXEaoAaWwkszonNAF26xCQH6As69lb0WwH0186ly2/wiyetDkj7Z0GTUZ/yIaQssvHVB15aZ8iAXlbnXANRarNofAsT/5/sYNTFtuZ7WzNP3r6RQWd1UDqUwY7hs0ls5R3KFj8AYSLD/6nuoYQng4vD4uiBlTk/M2lCTZQJ0kzNjMrecWNQVGOMdnT9lrnbjJ3dFZ53KZOzTtvCZR8C/TI94f70yDkW8HtgAfzIFM1BbOKKyqJZ8HmsAhJIPxEaXxIhWVCg/EsFfJh6Lpo2VPz4MTClZ30dDCINMZXrWfLU+MnAmOp401kKx63i+xyEbi9e/Tl/vi0lh67DB/l/3Qbr9CK2ri5szT/G6Jw2moDveHEGjJI7hmvgU88rrguJkXp7yQ7EVlMiVEj3fJRpbOKDxu99LYRmVtAmCfqUNrbqWQmQlkcw/YbnXr/3eXAGLANLtaseL9bX8T0uTP0PL9tXgx/IuZG3AeX2g2XOfyyRPe5xDfmnyhUTTFvpmQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(44832011)(8676002)(8936002)(41300700001)(5660300002)(316002)(4326008)(6636002)(2906002)(54906003)(70206006)(70586007)(6666004)(26005)(186003)(16526019)(110136005)(336012)(40460700003)(1076003)(7696005)(478600001)(40480700001)(86362001)(66574015)(36756003)(426003)(47076005)(2616005)(36860700001)(83380400001)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 12:04:43.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24020a93-ac85-487a-ed31-08db8d075521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: do not add new typedefs

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 27 ++++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 5ce29426ef11..0e593cfeb570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -90,8 +90,7 @@ struct amdgpu_doorbell_index {
 	uint32_t xcc_doorbell_range;
 };
 
-typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
-{
+enum AMDGPU_DOORBELL_ASSIGNMENT {
 	AMDGPU_DOORBELL_KIQ                     = 0x000,
 	AMDGPU_DOORBELL_HIQ                     = 0x001,
 	AMDGPU_DOORBELL_DIQ                     = 0x002,
@@ -109,10 +108,10 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
 	AMDGPU_DOORBELL_IH                      = 0x1E8,
 	AMDGPU_DOORBELL_MAX_ASSIGNMENT          = 0x3FF,
 	AMDGPU_DOORBELL_INVALID                 = 0xFFFF
-} AMDGPU_DOORBELL_ASSIGNMENT;
+};
+
+enum AMDGPU_VEGA20_DOORBELL_ASSIGNMENT {
 
-typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
-{
 	/* Compute + GFX: 0~255 */
 	AMDGPU_VEGA20_DOORBELL_KIQ                     = 0x000,
 	AMDGPU_VEGA20_DOORBELL_HIQ                     = 0x001,
@@ -176,10 +175,10 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
 
 	AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            = 0x1F7,
 	AMDGPU_VEGA20_DOORBELL_INVALID                   = 0xFFFF
-} AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
+};
+
+enum AMDGPU_NAVI10_DOORBELL_ASSIGNMENT {
 
-typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
-{
 	/* Compute + GFX: 0~255 */
 	AMDGPU_NAVI10_DOORBELL_KIQ			= 0x000,
 	AMDGPU_NAVI10_DOORBELL_HIQ			= 0x001,
@@ -227,13 +226,12 @@ typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
 
 	AMDGPU_NAVI10_DOORBELL_MAX_ASSIGNMENT		= 0x18F,
 	AMDGPU_NAVI10_DOORBELL_INVALID			= 0xFFFF
-} AMDGPU_NAVI10_DOORBELL_ASSIGNMENT;
+};
 
 /*
  * 64bit doorbell, offset are in QWORD, occupy 2KB doorbell space
  */
-typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
-{
+enum AMDGPU_DOORBELL64_ASSIGNMENT {
 	/*
 	 * All compute related doorbells: kiq, hiq, diq, traditional compute queue, user queue, should locate in
 	 * a continues range so that programming CP_MEC_DOORBELL_RANGE_LOWER/UPPER can cover this range.
@@ -309,9 +307,10 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
 
 	AMDGPU_DOORBELL64_MAX_ASSIGNMENT          = 0xFF,
 	AMDGPU_DOORBELL64_INVALID                 = 0xFFFF
-} AMDGPU_DOORBELL64_ASSIGNMENT;
+};
+
+enum AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 
-typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 	/* XCC0: 0x00 ~20, XCC1: 20 ~ 2F ... */
 
 	/* KIQ/HIQ/DIQ */
@@ -339,7 +338,7 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 
 	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1D4,
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
-} AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
+};
 
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
-- 
2.25.1

