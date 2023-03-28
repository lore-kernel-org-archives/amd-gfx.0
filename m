Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E3C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AEC10E924;
	Tue, 28 Mar 2023 15:15:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227DE10E91A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e10p03mJF0l9eN+0cMgOFWdSidw2FZ7zcB8byDcCCWq7avsrd6xj1LQL8UwMmSBUm9gU1fZtEicsBZ4G9DBRYvf/AbwtyW1zyFhxeOY0p8UFARYHT0ZO4m0bnTFsyrqQxva3sfQsjv2XtckC5tTvw11fC15GxaOxUY5trlHqw1vsBOZCP4RzKehAl40GovYI/xAxFSg9SbLUMKHESThFPc5tflF8d9Dottc7g5VwEdLM1bTk1D+EzgN0zXY/Cwd2XJLGsIE8bbDbSW2SibK2dAo/SUYqxg4DqVlC7seulDfX6B9m8K0ixRZ6jbi0DJ5Yl20CT5WB4zHs6GoF/Xfq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0Fk1FhzRJAGmvRbfBTIbGYuGbSCT9ghv6kLbfV1Gq0=;
 b=If3xInR2d3VEjMn0YAPsRubB8B1Ran1ad+KXi3zZ4v+R85USnaIfALOvPH65nnKJL6p+R4LRE2qeBCHKjOWNgiaGeDLbqugwtoGtyOoHl0pc9Exh0RWMwGN6iOF3z8uJmfD6wzvnzPcFxS5btgUxWJglQit+PyjRIHqJU7G58cWFwFc5X97yZ93BGD8FR72BghT75zfDRZpg38eLeWPu/uwGS+1YAzl6CiO19tTxwcRXl9bJgEXnuW3MIezJkbrp0AOTMJP7BYbUHh7pWisiyb7rJNtF5GR56WbkoI6Q2c/QpSY45sdq1fYvdbYr70rkhHRPbPRu32Js8f1eSGXcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Fk1FhzRJAGmvRbfBTIbGYuGbSCT9ghv6kLbfV1Gq0=;
 b=qQQuLtSKS4V2f4nmFoQzNJFUWS+jDLPLhXca6jgZp9yF54FyjbY1Do0cSBPWsQr5bD1nSQ6Wqajh/rGUe9S3nXbUDv12DyeCgvAXGiq4pfTGZCf7Wf2iJDJ7BQKtShkn0yNtm734klwTCu89HIs269t7vdSB5Kvtvp8TFCjYAho=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 15:14:46 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::9a) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/32] drm/amdgpu: adjust some basic elements for multiple AID
 case
Date: Tue, 28 Mar 2023 11:13:34 -0400
Message-ID: <20230328151344.1934291-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd2777c-5ba1-44e0-fe94-08db2f9f2a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmPd4sbqn33u4XxzvuP9FPpJeShRBfxCRp7fqV1U8C8ArEfrsb2EHHavMoTE+PZRaxXcBUbVoHyMvqW27se8MmiSxiKnThN85um81ma48UrQE8hO6Gn+PIk7b2iWt18FNWfofF7xN413mInFHHYtCmVJGHn/UhVu7Z86isamTY7+BKrIVDgyHmMqTYbFTvxR6ZgFj26jUd8NDYMRNvphSnbjk1zLBCDKUHWkV79pcMdGGWu9rOAYFHU/lAQq5FxEZjbmt4NFvCZAijprHsmOKaSkXlgBt2ZBsOJGU76AHEIrn0aDmSxmOABakYih2+mX6XMXZk+eCwNhHMDiHZIcrLVq8nbPmqoO2p2m6D3k1M6qSA6AlBE5XCmaariMTaDerecF3gl+/IPtO9MAju9pYy31YnmteQCqNlx3Riryhlm6kZRleDy7ytw53WZNTIFbyxVP5ecF41846e/CpVztwcbRueyh07HCK38lxnkTBVm18EWRt5SQf20p2gPHXupLuoo/Frd5rCg0mrM2hBOWAK1cJ3C7kVNhnhHvLZq6el88n6fisDe+Gd1xynp6hbYMMM0V55gVJaWc8wYoVg9Oe4M2oQ9vnJzsaA7xJ3bQL3v/LqpAVKoAIEhUTptIAXySgyG5/tk9eksy9SNoiGwgqvZ2sKBzjXkFFSGl4BBThgq7/M6sOSTaX7fY/gffTUiG3KdfXwt5j17Pup97z/WZs0WzH7Ne3yRVZQlwlIzEGiQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82310400005)(2906002)(40480700001)(40460700003)(478600001)(6666004)(426003)(336012)(83380400001)(54906003)(26005)(47076005)(2616005)(7696005)(4326008)(1076003)(70586007)(70206006)(6916009)(36860700001)(81166007)(316002)(8676002)(186003)(16526019)(41300700001)(356005)(8936002)(82740400003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:45.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd2777c-5ba1-44e0-fe94-08db2f9f2a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

add some elements below:
 - num_aid
 - aid_id for each sdma instance
 - num_inst_per_aid for sdma

and extend macro size below:
 - SDMA_MAX_INSTANCES to 16
 - AMDGPU_MAX_RINGS to 96
 - AMDGPU_MAX_HWIP_RINGS to 32

v2: move aid_id from amdgpu_ring to amdgpu_sdma_instance. (Lijo)

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 786b28821324..ca9c4d31e352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1072,6 +1072,7 @@ struct amdgpu_device {
 
 	bool                            job_hang;
 	bool                            dc_enabled;
+	uint32_t			num_aid;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 72a7afb852d0..f4467e5cf882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -36,8 +36,8 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		28
-#define AMDGPU_MAX_HWIP_RINGS		8
+#define AMDGPU_MAX_RINGS		96
+#define AMDGPU_MAX_HWIP_RINGS		32
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
 #define AMDGPU_MAX_COMPUTE_RINGS	8
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index fc8528812598..67975dcede5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -26,7 +26,7 @@
 #include "amdgpu_ras.h"
 
 /* max number of IP instances */
-#define AMDGPU_MAX_SDMA_INSTANCES		8
+#define AMDGPU_MAX_SDMA_INSTANCES		16
 
 enum amdgpu_sdma_irq {
 	AMDGPU_SDMA_IRQ_INSTANCE0  = 0,
@@ -49,6 +49,7 @@ struct amdgpu_sdma_instance {
 	struct amdgpu_ring	ring;
 	struct amdgpu_ring	page;
 	bool			burst_nop;
+	uint32_t		aid_id;
 };
 
 struct amdgpu_sdma_ras {
@@ -66,6 +67,7 @@ struct amdgpu_sdma {
 	struct amdgpu_irq_src	srbm_write_irq;
 
 	int			num_instances;
+	int			num_inst_per_aid;
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
-- 
2.39.2

