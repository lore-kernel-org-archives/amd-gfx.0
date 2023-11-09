Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D89C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 07:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE9C10E1C3;
	Thu,  9 Nov 2023 07:38:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E0C10E1C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 07:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke8EHxNgZaA5gjf0eTFG1EagpNN/2h+evyX8bscUuI4Kd4d4SUvOUUfdMwPuay14BzaOKo5i1l5HLMoHe4kUIcrZRaCouvE2xbQlJ5Uh7NTQ5Vlf4OR/YckOJkiW3dhoNArynIi+ErA6mWmMBVGLtsmrHjOUDy7hjL6fuLO2MpChdKRfbgwOX5FYfCYpyAs1fySBhUKh2hZi79P7Rd/nqRzgJ6Z5mDYEif5tJd27EyfRFShGfB+CQgvH8t2dF0tNe5/cynKJdc+XJ+9cHTAKUZeg5PSRQ/mSozctfjcko0XexUK+a+DF8hcpG03v0Fk35umOw8k8TxWiF9gsf8Mrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWNqrjoFbYC223lfui5HvGPYevW/cEePWoixS0DbhIQ=;
 b=JFw+nlY9b/3N4ZJaKBHligICf1vJkc0Ub5H++gYkrHfimJSpqMnrhHDuJylW40eMFXNqlyVM9ehZRH5xZpRZE+Stn/EKXNAV5dtH7aOp6HwADk/YSBZf8GuGIeiQoRiTtwoZrTCkqS/C7yoeU6mVouHlQk5q4igbXj+Hh8TxgmGd51Y+WfUlrciCaXirG5wupWMhfJxT8mPreW5Oq/YHFgKg8Zhp8tzgTnu8yYp3GyfRf7ymdrOrihU5QPzzz8mfx1ZmuleZI3zLCTlRFH3n+ikHmXwVbhMkNbIxxsec89d/LKFF742qUtOsAgsY9zItP8fsSyix4WK9uc1mnNh9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWNqrjoFbYC223lfui5HvGPYevW/cEePWoixS0DbhIQ=;
 b=bxbZGNlb2cO/AURq1rx5iwGBdf9PUfkrj68H9v3aAqN4LWPDxE6OZ7GzYqPgwTUepUd8YYY6MUtXPuL7XkOcwo78QcCXB6tcYcJbAjRdwajcRnGYVkp6CJuxzswx5s3Axdhp64YaQMX3b5K/gBemCndfNFZK2W1GDV5h+tH6AWo=
Received: from BL1PR13CA0335.namprd13.prod.outlook.com (2603:10b6:208:2c6::10)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Thu, 9 Nov
 2023 07:38:37 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::48) by BL1PR13CA0335.outlook.office365.com
 (2603:10b6:208:2c6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:38:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:38:35 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Date: Thu, 9 Nov 2023 13:08:13 +0530
Message-ID: <20231109073813.552664-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 838da589-bbcf-4126-679a-08dbe0f6e2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBF3YmTkts9Otd4LVxpnzvBCihoXeqj9YFg6OjA6N9rlt2wskT/rOkwAVYF+p+ZNiT/90MKdfpZ3lH0/Ef0HFoo7UYKUoVsxcYxgdZBEVXs/7dM/IWAPHBbdXPAnrjYMW46m+8wzhqjz4c8o7tcaZiukgcXcv+6l/YN1eIn1rBugHh1OZggsACa3saxCgiYkshO93wh1h8xEWdmWviatmQRvQHeNYMr5CogeBtiljMiJRu79bTkaN+v/xs9J/1fUttbkh8Hf0GZx5fDr92ybPYAeihk0+kKlOCwdSzWdC/yaCKYf1/h4ddsYb9wooq+PqBLWTGuxUD6Lobieu7/XcifKaoGrI8bfk6yppFiiN//2aLjCqBXj4Ho3BF60CDZKiN+K4vIAI79rLgLIOrQoDHybIk8uPtdsebEZKkCOdh0HfvASpq36HefDfTjnxpRrnSc6nksQCCj0vCcjKnVEoP8d+ddm6FU2wZ5i7fInu6/+VCK/XB1k/Y1i59WG44dcwezIUe4Qc+wtENCk3R3DjO1Z0h9nMgttTo18QJl+OHicuvY6gQxpfVLhfWRhQR2EpKVfIZi/CvjGqT4ArvK/jWpyJo0kTSQg+1yU3buex8zf88h3nA5CYHFfD4E24S/ArVbdR7t5l3m0PiASsL2R+GjpBPwmA5Kievxu03GYk09jvGa7H3IEYSTnUffZAbXrjrYt7dTv3qBXEfP4p74HOUHXhctF01O0LP0VZDBflWGGlb+FAu7zAqoScJSOzNG2oOzIWGmCdE8wQJqD/mpOGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(7696005)(478600001)(2616005)(6666004)(426003)(47076005)(83380400001)(26005)(70586007)(1076003)(336012)(2906002)(41300700001)(54906003)(44832011)(70206006)(4326008)(8676002)(6916009)(8936002)(316002)(16526019)(5660300002)(36756003)(86362001)(81166007)(356005)(82740400003)(36860700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:38:37.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838da589-bbcf-4126-679a-08dbe0f6e2af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cancel_work is not backported to all custom kernels. Add a workaround to
skip execution of already queued recovery jobs, if the device is already
reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 16 ++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bebc73c6822c..c66524e2a56a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5411,6 +5411,8 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
+	amdgpu_reset_domain_clear_pending(adev->reset_domain);
+
 #if defined(CONFIG_DEBUG_FS)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
@@ -5452,6 +5454,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool audio_suspended = false;
 	bool gpu_reset_for_dev_remove = false;
 
+	if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
+		return 0;
+
 	gpu_reset_for_dev_remove =
 			test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
 				test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..3ece7267d6ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -120,6 +120,14 @@ void amdgpu_reset_destroy_reset_domain(struct kref *ref)
 	kvfree(reset_domain);
 }
 
+static void amdgpu_reset_domain_cancel_all_work(struct work_struct *work)
+{
+	struct amdgpu_reset_domain *reset_domain =
+		container_of(work, struct amdgpu_reset_domain, clear);
+
+	reset_domain->drain = false;
+}
+
 struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
 							     char *wq_name)
 {
@@ -142,6 +150,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 
 	}
 
+	INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work);
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	atomic_set(&reset_domain->reset_res, 0);
 	init_rwsem(&reset_domain->sem);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index b0335a1c5e90..70059eea7e2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -87,6 +87,8 @@ struct amdgpu_reset_domain {
 	struct rw_semaphore sem;
 	atomic_t in_gpu_reset;
 	atomic_t reset_res;
+	struct work_struct clear;
+	bool drain;
 };
 
 #ifdef CONFIG_DEV_COREDUMP
@@ -137,6 +139,20 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
 	return queue_work(domain->wq, work);
 }
 
+static inline void amdgpu_reset_domain_clear_pending(struct amdgpu_reset_domain *domain)
+{
+	domain->drain = true;
+	/* queue one more work to the domain queue. Till this work is finished,
+	 * domain is in drain mode.
+	 */
+	queue_work(domain->wq, &domain->clear);
+}
+
+static inline bool amdgpu_reset_domain_in_drain_mode(struct amdgpu_reset_domain *domain)
+{
+	return domain->drain;
+}
+
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
-- 
2.25.1

