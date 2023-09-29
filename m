Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04CBE732D0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 09:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F5410E0F9;
	Fri, 29 Sep 2023 09:38:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3839110E0F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 09:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKSfXqIw5BiMJltscjAIiyLpI9HmCtUJf/cvP2x+kWOHAgK36BcKAWzk2up+4u7fuaVjo+4ZHREKex32SrOT4eRcXLnPH/ECIgfePyIntvXKrv5+xIygfY00PK4Tx83IN3raijC716ovCXrhFJVr+7bIgS6x32gkNGCv7N53gqV93LD1D7/4tyE9ew/K2z8cibpkutYynuLKo8CVqSuSalxokWVnYCwXMXstBqll9gejnDh945KWn5wjVj5RRpzyR12KDaU//pmI7EAGUDDc5QyC9EuEjC/KYjVYYk8Udf3hToCQASKOSFDOLHItGolz+GxvSNYvNvqdbhhkwPCgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qae05qdFu/Kn4KfncIef4znSe6vUfpi8PoWBJE1hYk4=;
 b=KbRZQ0Krc8InCPAyK3koGgR/kQRt+2wOKYkZFChbYmmw3EK74v1epEdO9s6N4gNfkoWhhPUxB1ShAbD5M1XGa1RPwx/ySHacy+8fex5SbivlyIlWFIeSVm6k+vRak/aRjpuLZjJXYj7f0rztOdgfdyNg02uY08CPEHy0V8vKNfDNYxy4ZprDcoiO/zKCNnJq55Z8m3TrcpdXV8n7INvZcwiwT3QQB2VtBJMWCJRQfQLeDlgsVFZ7VZsZja8qj3W/hVyTzbYw9Aslk7sQQnxgFNfO66FtZZAsWBivjK79h6sPbNKi+PckvnviWc5cTx/CyHh2xPSLaLfqeammT5IhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qae05qdFu/Kn4KfncIef4znSe6vUfpi8PoWBJE1hYk4=;
 b=do3KlokC9FEXI2o0eeMHp1aRJ5y5wYRLmotW41KRlR5yUo7PvqrezWHG5l7uSm14/Mm6fhx6sJnEIHnNrMxPVOxlbix2ShI2o5Fc0IrZCyoZV1ArEcCVMmiJEewwIJ8QRXmaUjlQ1IxbHe4pwh512kmcNTk8VBxsR4dT9+N7ATQ=
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 09:38:14 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e9) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Fri, 29 Sep 2023 09:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 09:38:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 04:38:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Get package types for smuio v13.0
Date: Fri, 29 Sep 2023 15:07:45 +0530
Message-ID: <20230929093747.1456991-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929093747.1456991-1-lijo.lazar@amd.com>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: d11fd649-fc9d-4585-7f4b-08dbc0cfcd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrL7kPnDGwUFVP23hNPKwaLfXoH4YcM1DggDkSFXO8tU0BWF6GTLtF4nQ3pFGzCokIpdCyUl43Kos2eKpgZVrsDIw+FA+ZjOmxlEb0GsZr7LpyzqLwy66DeIQrePUEl7CBM8oCMOgPgUSA+bsGiIQXK4AhO2Fd3kX1geAf8rw3oXV8/7QgyFbn9Ldbg9SfOa18MG4P74GVDdrZt8Tj3yJwofGAadHikesxXimstQArZCfjSso/VSLXUTdY0PKPUQISNHwMeqfARtEAYto6sZxgnmhoOVaC2WiQFIxceVhEZLoInkymher24SQm1o2rS0TxKw4IntxvR9Av6QoZFwHXpj3o+9yQH+FMJliGFsbpw+0a9ylXa60I7pmOJ9trElckOFlsGbsHxb4jrdL5s475GWqy1cs6oD60oL/tCsKDEnkbxqvrcb4lqPDZ/M5gFHHe+R3lC8BftX6jtQjT/S2WBxHPXOt3W41HaQQJggXuUoLkA8wEpoMfXhj2AN6Cjo4tE2CT2124pVaHwgugyARYcUbPZZkTsvixbezTAtaGUA1IgVmwyuGdWJX3sEAzKDmX+/3c2rNMBLeIUpqVbuBTMq8HnArVyNpPshRUWYD/b7d5kiloC27ZjplZB8XgAlOWU3hz6wsMBTlpVDx9iTEXemVEN35gKOjamYLV82Y2ecYA2OivRaUqTSXiHEGagaxp42+j7VDTNHEZrfYyLZNqGYFXYmh7atzSt6m47w2IJX/nhjSoFZngadd2UzGrNK4zxklVbCAzjWnnKGRQH7HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(81166007)(356005)(82740400003)(36756003)(86362001)(40480700001)(1076003)(40460700003)(478600001)(6666004)(54906003)(316002)(70206006)(70586007)(6916009)(2616005)(7696005)(5660300002)(8676002)(4326008)(8936002)(44832011)(2906002)(41300700001)(47076005)(426003)(36860700001)(336012)(26005)(83380400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:38:13.9947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11fd649-fc9d-4585-7f4b-08dbc0cfcd6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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

Add support to query package types supported in smuio v13.0 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 13e905c22592..bf8b8e5ddf5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -128,6 +128,27 @@ static bool smuio_v13_0_is_host_gpu_xgmi_supported(struct amdgpu_device *adev)
 	return data ? true : false;
 }
 
+static enum amdgpu_pkg_type smuio_v13_0_get_pkg_type(struct amdgpu_device *adev)
+{
+	enum amdgpu_pkg_type pkg_type;
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+
+	switch (data) {
+	case 0x4:
+	case 0xC:
+		pkg_type = AMDGPU_PKG_TYPE_CEM;
+		break;
+	default:
+		pkg_type = AMDGPU_PKG_TYPE_OAM;
+		break;
+	}
+
+	return pkg_type;
+}
+
 const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
 	.get_rom_index_offset = smuio_v13_0_get_rom_index_offset,
 	.get_rom_data_offset = smuio_v13_0_get_rom_data_offset,
@@ -136,4 +157,5 @@ const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
 	.is_host_gpu_xgmi_supported = smuio_v13_0_is_host_gpu_xgmi_supported,
 	.update_rom_clock_gating = smuio_v13_0_update_rom_clock_gating,
 	.get_clock_gating_state = smuio_v13_0_get_clock_gating_state,
+	.get_pkg_type = smuio_v13_0_get_pkg_type,
 };
-- 
2.25.1

