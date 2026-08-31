Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE6C624D6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E15D10EA8B;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cr/GB5lz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADDD10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scG2+6nO0VlGQ6cz5yA3A5s9HMle2pxfpTzzanfzh8TbLCaqmB5E9PV1sYkxFXKzp9qMREaduRnCQrqfM0hFR/fFMZ5+f0607nXpIvQGWIRs5ft6gDeceSx87XVse5cgtaKu8LVgthn4OtLFQWf7R5tXSMIW775tWGzVZuDG5mYd7tfYlfRHnmPNkHgEpzOijrvL1h+j8vUsA+7nvo/C2+4FlhvzyMr4wmqyY9tIa5TDZ65QbVrYhSCD3uJZBvztJ/9/gMdxQc3cILTGpc1T++Ni6cPN9TVuJKbPGYme9dmVbCgaW5Tqjoad95uUs6HBuF79j+mphunD+0oXYs4ZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD2MDXKAEC+N2Q0BBOFluJ6oIyCkO0N6qMho7XEnVnc=;
 b=oyhYxHLrYPHwaZ5NrICWep3SIkdeFe+XPDK4nhuN4M7y+YBmmQ23BkB6atSqGwt9ehIH2ejU86VoK4YGwcQC3DAhH2lhrsZPZZhSHUylX0Vhy+Mc6qW6MuQKmn5FciGdSNkyCy4c0glOfz9w0o2XX0bmn2SFTrRyzT95wTTAaWyemC5aapseeiyKAl7U4o4oLLtV0qrKp+NMhoTvkNt/R5+57vDrIQbeMxt4cMulrmCch3tSt+FuvgTHOQpWnkSeMSegg0fcPn5eF+dhZpQCIFp1ST7WPTABpPbeohS9EYHPBRnVLyBDc2zwMxDnC6T9mKvP3+89PNmmQ7FS9o/ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD2MDXKAEC+N2Q0BBOFluJ6oIyCkO0N6qMho7XEnVnc=;
 b=Cr/GB5lzvnWic3i0+LlG5Ea5vIlSuUPAWjT+hmxRYgcWJpX75Y0XLeCRiDiLy2JjZSgQEscw4wwmTZyLtMVSzuSyl0xTaB1qbTkWsf3VKOSInONNZ/TPFrsG7N+VEHwvIe/RQtIWjDffjt9iQQ5jICwwe/G5X46x4Ix0mFIoLbc=
Received: from BN9PR03CA0129.namprd03.prod.outlook.com (2603:10b6:408:fe::14)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:50 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::1d) by BN9PR03CA0129.outlook.office365.com
 (2603:10b6:408:fe::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/95] drm/amdgpu: Add UALink SDMA scheduler entities
Date: Mon, 31 Aug 2026 14:26:54 -0400
Message-ID: <20260831182754.1089811-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b2837a-3973-4719-555b-08df078db45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: J+A1I9N/CTXGEdUKtr7sy3mKj6uC/9ITvUpZwbepw9gK1hn6l03JoHnFmUViDnz0hviIjuhGGvoK7O+pL5tH7o38c8V3IaweGgNHL2eiCLV4PZAA2gTytrFjm3gOzchj8dcfmD1eyEXMo4uNbisOz7SHIuGz9mAKAyvrDRA52TP4sdGsQuRhLd/EpAbY7qxDhqHM2iurmGmA4xJDM2gdaHoclagusO2kqVCr5uxS1Brbsy7psagbZb4UzPyD3rlRtB039bZbhg2Q09J875DOFxi4i7MtlZFa9xC9Ir21UXZ44iPToI6rgSxH+acqB3AKSgUM/QXts2Rn/vETXEm7edsxE7ZWosgq2coqFdxx4qHMpmzh9N/hRDiRIBGQTxnutYGGroYp2h8KxG3Z7oYVqQ1p/ARLWxL/aUEfcjpi2+sCAuIZSSozI4zgqO51S5WQk1iZZIKccaybXKWIzIZFZ+eQIXyQmYmGgAOZUhVjxqRomzq/Bt+EV3bsjn8Moj9PBpfY7EYmqAUbUC5zM0lx58Wk41m3akBfP7+eZsnXrtiSAYb4pjtNfDJ0izvIwH0gAwllrYGd42fj7eSHeAfsAjfDHXEJopHfeCEcb+2wgXFNDVIb0RhBMfs3DLuq/BVQSV//5j2y+A5hq3IWgHIXaNxu27VfcsFvG/TTbT/FEjkeLeagi44II3XpUH92OXxkj8xhZ0tvB+LsVL82H3M+PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f3dGI5YVYPy2EGNfllmJ1/pnZxoUdkJVqH/EjqM6GUvmxxkXqWS5SXOMjJ1niWGiwtLgcVNBUFIT7V55Oo2s7+OK0GYignEK57zINDKch0+U496Kn6bshe27/rF98JyOxs0nDfF0y90PYMOiTSL9IHqd/hrNy8J0wLS7i7qT8DAcYvt93nwco4gvEVsdKZip1I0Nsn6NIazewCqGcVHjbIBCaKHqD+9O2v9GqroLyLaynmTbOcJom47MiA9421nJ01feKLv4l7esjE15DklPD2nX+RvaPHDIeHfsEY9vgsM53Vd6UtIWMl/6xHf7JA8G5PGHkEkww7PN0eTiC9ptnry64Kak0TfYLTc6ZSRISlXefqn/xq9+itEJqI9z+eiVgZrrhSu44SVhoCcWliebrVIURLIAU55UwaJJdYxBEgWEHnLVM/Yn1IS2mTuOan5Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:50.7395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b2837a-3973-4719-555b-08df078db45f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

From: Philip Yang <Philip.Yang@amd.com>

Allocate one GPU scheduler entity per SDMA instance for remote command
dispatch. Commands to the same peer are serialized through one entity;
different peers can be targeted concurrently by different SDMA engines.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 51e0e2336d052..2cb805dd6cbf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2007,3 +2007,56 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 	return r;
 }
 
+/**
+ * amdgpu_ualink_sdma_entities_init - Initialize SDMA job scheduler entities
+ * @adev: amdgpu device pointer
+ *
+ * Sets up SDMA job scheduler entities for remote interrupt and shootdown.
+ * Each entity uses one SDMA scheduler/ring.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amdgpu_ualink_sdma_entities_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct drm_gpu_scheduler *sched;
+	u32 accel_id;
+	int i = 0, r;
+
+	dev_dbg(adev->dev, "enter\n");
+
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		sched = &adev->sdma.instance[accel_id % adev->sdma.num_instances].ring.sched;
+
+		r = drm_sched_entity_init(&remote->peer[accel_id].entity, DRM_SCHED_PRIORITY_HIGH,
+					  &sched, 1, NULL);
+		if (r)
+			goto out_free;
+		i++;
+	}
+
+	dev_dbg(adev->dev, "exit\n");
+	return 0;
+
+out_free:
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		if (i--)
+			drm_sched_entity_destroy(&remote->peer[accel_id].entity);
+		else
+			break;
+	}
+
+	return r;
+}
+
+static void amdgpu_ualink_sdma_entities_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 accel_id;
+
+	dev_dbg(adev->dev, "enter\n");
+	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX)
+		drm_sched_entity_destroy(&remote->peer[accel_id].entity);
+	dev_dbg(adev->dev, "exit\n");
+}
+
-- 
2.55.0

