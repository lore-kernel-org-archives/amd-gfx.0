Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F041ECDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A6110E2DF;
	Tue, 17 Oct 2023 12:46:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D6A10E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeIJPnb9w8qsBm9e1Q+MXFYQrZrdX44CRb+3mE36cE2cZcjeIEjBs9ImLGhERzBRAecq46m4rkBMMuCk246G2H16A9CLfnpxHEiciRv5nsj6wvkLyD042wZIhg/+hARjsww/1XQjMbcGQWLsfho/CR3aJLhCM91v68y/O+BDaGBBecSasn6tPIyaZWwXh7zpd4xAQEOuZNgiX+CThkNJ2fwUpsWvVtnvm7dr3yNOVwwlUPcvkehqSTbfkAB+NiCzzGFwF26jVJPs8W2tiL36vfgfh5Pof2+FD7WRWNLztmaicbfYO2qAU7C5vqN/VvMOD7u8dj+EPbDt2xoC6V9+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48SW22+75XY8RRKGY0jUMJN0MVN1IrlindHoJ+5ACls=;
 b=EaElG+SRvDZ6Ey1kntCHpJW6bf96ZN7dG9s0C/UHyCZSrfeE+sjYD0dapopNMslPEnyKjqEyCyyq3jbgtVmDAALj10WAGbummcplRVjwLmvoqfTxfitfSAlUIgPjDH/X7VaMRbfZZOm39mS6avoC26xAmbmKq2jHkFSi0iqDrCJdKGZ/7gphGDKBDkG2jg1eaB7ycgn89zU8/YDTmE5T1CvzKcsrWH5VwXjVJkht9xAJkQk3BBD67QSQtmtuvQGJMCIdWDQDwZ9ZuYUT+UpxPmQ2xVE3AhbCdMD3PntLZ1RTGHl+RuHkSILEpTHtZKMCqijypneraKRpW+9MAnXBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48SW22+75XY8RRKGY0jUMJN0MVN1IrlindHoJ+5ACls=;
 b=FHoB9z1ZVRE6bQIu9mk3RLCG0hNH9/WNFoFfKUWDkpbZn6+rNwKu4p/cSyaAMYdepKbX3TOx4lKJud/FeAdEzoX3xEqVOp0SL+r95sTsti5TWdRrjSz4u6wB5WlLm3OL7xSsaZNCrRcNqqkLVf6OrKC9UXrJyMn+FoRkZWlsypY=
Received: from BY5PR17CA0040.namprd17.prod.outlook.com (2603:10b6:a03:167::17)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 12:46:10 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:167:cafe::52) by BY5PR17CA0040.outlook.office365.com
 (2603:10b6:a03:167::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 12:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.4 via Frontend Transport; Tue, 17 Oct 2023 12:46:09 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 07:46:07 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: add set/get mca debug mode operations
Date: Tue, 17 Oct 2023 20:45:48 +0800
Message-ID: <20231017124552.27509-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231017124552.27509-1-tao.zhou1@amd.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae151ab-86f0-4a65-cc48-08dbcf0f09f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tAl3jSd3uJrYsAI7dQjJkQrKPNKd5flip8cGFZ1gtttl9v/YBxIcTMhDDtuyU80gKaers8f0PpTziiStk8h5Anu2f/zkg2OAK0dpDgtDjyRXUJN1no8vwtA0iCVK040ocjWw6EunEzdsnxZXxWdAe+0gkga/mIf9znc3af9jszZtgcbai2SGzP36FWQe1qjsoRgfrR7yuwLptr2Ek7IgCC/FhFS//ckJZtHRXlV449vDIrYu/6UyDaCBLqPQn6LEnIx3Rqq2KxAEbzV7WTRPgnM2CFw0Xg59W+J4GQ8cyv+LYljz5IvKlVjzc6KNm0r8SMAxlTPVlDebw7tur6qUTAfjk2IntV+v+NRX8Ro5ENFh61Q9MaFlsGpy7RikryyMHZIvdZH6C3rveyakgduZoO5v3fzG/xE2SvGmWvYTjBI53JMiPi77oUKaF22X4JmfAxIscOYmmiGeDM7dSWnQR4zV4Ws4rYO/IPrWtGRAldkHhwVWe/3j14Xhe9JYXbhvcgHEYuIrrGiuSAri5UaJTq3/afitNkvmXx4QMyCaymRgnlmyB85vDzWTQZGI+NXTCSB4IbG4AUrXZ4X8CWQSSzUFmUOlrIv6agGQeyAX3vA+g3qcB+RVePV5pptEy7LEQctX0ajjF+4XNbae/EEQYBIVyIEZ4U48uAN6iitW8RxvJaWM3C05b8IcVcRdCPXFaWuoO2mAbFrAP5VtIgRy0brc3JImCr6vVfokJvgLsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(16526019)(26005)(426003)(82740400003)(1076003)(336012)(8676002)(8936002)(4326008)(5660300002)(47076005)(83380400001)(81166007)(40480700001)(41300700001)(356005)(478600001)(2906002)(86362001)(110136005)(36860700001)(316002)(6636002)(7696005)(6666004)(70206006)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:46:09.9901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae151ab-86f0-4a65-cc48-08dbcf0f09f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Record the debug mode status in RAS.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 344ebcf1a6e5..95c7ba889e2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3329,6 +3329,27 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (con)
+		con->is_mca_debug_mode = enable;
+}
+
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!con)
+		return false;
+
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		return con->is_mca_debug_mode;
+	else
+		return true;
+}
 
 /* Register each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 3f9ac0ab67e6..2fdfef62ee27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -434,6 +434,8 @@ struct amdgpu_ras {
 
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+	/* Record status of smu mca debug mode */
+	bool is_mca_debug_mode;
 
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
@@ -768,6 +770,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
+void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
 void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev);
-- 
2.35.1

