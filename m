Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA41C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A4710E4BE;
	Wed, 23 Nov 2022 01:44:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AED10E4BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb1ZdKGxJdsUx0fJtgjyqmrMJGEr/ymTe1d+WBx7wif+8QqXVNlQuCJVIi2Xpn1Ey9q+NhnuQB1ZuPhghKRwDetm/KYJpnOkYImjBEVUgJvT96AfMrKRxHuCd0qcn8CWLI0eMM+kP8inKXHZq+x7RqZxOTuUcx/liMXV3mi/UJKzymoBsrt2AueDOoLKdB+wpWMiqn/u/UN7W4F/yAyNX7dHaAijcVQNTqSf2zUtr5ZobvDwLC32cxaDLcSOgE2n+bHBZ81rDrnP9A+7z6xr5kgX4aVVc0dYGqjVdciGzihlBeVOumWGJb+ImxW6V+wxi3ZZJNTYdESjQE67FgOqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94uFXPN1Cuikh+Xo+VDB+U+0n/hC65ysZ3+c+M+pxvw=;
 b=MtQhGbHHFvKqKCahqRjHJ1wzwrInxPedqJykMfMbW9edmr1dpU66jjmHX6dDGXq2yjVAX7DIDSV9iPQeeAgupfqwg9FR842Tkqb6jS1XfJTLa8IJ9SIjZ7LLDImRv6SHH3J1YpdbXKOjl2tk20gNhKYnelEWDUhFk2cZfcshHreEgnCUKwGvROGWbLZE/7DF3VDpqFb9y2+/hmpxCjVlp/AOGlkufa9dApb3SHMNS6BXoxuJ22zVisj6myT+Hs9csBNVDp4wWaC0NpihY7OvRyiuK1IXsqG8ebVMIIACyFKF4zQPYxdzcBbkqXQxDp52D2+Nlhqn+fsKNPDW6Gb/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94uFXPN1Cuikh+Xo+VDB+U+0n/hC65ysZ3+c+M+pxvw=;
 b=WvPmTMhZ019ORBBjvRjP98hGL1nw8psaUsC+fvUNEfQ7OEUlnrMQHY1l1gp7ExakmGaTBaOQCbwzJ/uQ+vwBwl/2We4KOz/GKWCOWBj/MH5BeomBlm72mM6uiqTFlm+fW5hV8yNDWrhx3/SZ9C6TlpNLseRksU9AewdPuxehYBM=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:43:58 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e2) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8 via Frontend
 Transport; Wed, 23 Nov 2022 01:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 01:43:58 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 22 Nov 2022 19:43:55 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 2/3] drm/amd/pm/smu11: poll BACO status after RPM BACO exits
Date: Wed, 23 Nov 2022 09:43:41 +0800
Message-ID: <20221123014341.263439-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db57597-b97b-4a4f-4426-08daccf4307f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pc4xh2xtbemO6r4pc2hAi+x3m2zAEN0cltHu7AOws2JcbUFkNBCt+2GN8SORfp9QUR2tWZJkVdZODhSaoZ5/4XQIw8i5bI325vN3AwZ7m+L01a08tArsCN/J+53mwXP7RZgQzFORxDcxMrFLaY91rAbESDjdhrXda12EQSJAFqpHgFuBjOtWNnDoAugosVouFjSOtEb3RCqaNY5YMjtILaNjBIOZ1IZLaoEzjyz1eCD3Ap6bG7oEYqOROPQwKrPY5O9QyVTUqCSX3Ar/kOEVpnbkGZiNql8jVU09blliQoM8cDagKP9H0pvHqfHh3FAbzkikij+7cdHOc3vNt+KS2Gkl3AUzfXCP8e3E84awp9McguIbS0RKDJs9uapvcBwlaIcEBKo2DQ91az/kcZebiHS+CbM4RZajqAB58hkb4Sk9IKcyJVI8s6zt+IlsNZ5INouJKydznwdgmWhCOWThGth9XfCqPKRonD9YnoAS0QXy1db3nbqfoMUcFZNOyGFGY7LKefSu4ljZc/T/4OC/r+WzNZoB4+ChvNw0SJ0hAQ5nicTJ1jLH5ikW/URuE8+d63Cc3eV9lnKDpga81tDR2TOjE8XGJQd6agZnMXWWlBv/5ZkYE7KfKygsPWF5PLbDMBq0zuQkOiyp9Ggh2bb2Y3uzHCN5UmJeV+3InQUQkF2VnDQcHUQETibEtlG4oRibz0cs3za/Ed1cFGcXVjAXTB4+Z6PWLwqH+Yp4grj911Boc7RhLeH5xx2PT6h++opg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(2906002)(83380400001)(336012)(86362001)(478600001)(316002)(8936002)(426003)(186003)(47076005)(1076003)(2616005)(44832011)(82740400003)(26005)(5660300002)(70586007)(82310400005)(356005)(81166007)(7696005)(70206006)(8676002)(36756003)(16526019)(4326008)(110136005)(40460700003)(6636002)(40480700001)(41300700001)(6666004)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:43:58.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db57597-b97b-4a4f-4426-08daccf4307f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After executing BACO exit, driver needs to poll the status
to ensure FW has completed BACO exit sequence to prevent
timing issue.

v2: use usleep_range to replace msleep to fix checkpatch.pl warnings

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index ad5f6a15a1d7..ad66d57aa102 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -79,6 +79,17 @@ MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
 #define mmTHM_BACO_CNTL_ARCT			0xA7
 #define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
 
+static void smu_v11_0_poll_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t data, loop = 0;
+
+	do {
+		usleep_range(1000, 1100);
+		data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+	} while ((data & 0x100) && (++loop < 100));
+}
+
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1689,7 +1700,18 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
 
 int smu_v11_0_baco_exit(struct smu_context *smu)
 {
-	return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	int ret;
+
+	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	if (!ret) {
+		/*
+		 * Poll BACO exit status to ensure FW has completed
+		 * BACO exit process to avoid timing issues.
+		 */
+		smu_v11_0_poll_baco_exit(smu);
+	}
+
+	return ret;
 }
 
 int smu_v11_0_mode1_reset(struct smu_context *smu)
-- 
2.25.1

