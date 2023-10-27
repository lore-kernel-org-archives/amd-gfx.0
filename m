Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F8C25B67
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 11:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9E910E0C6;
	Fri, 27 Oct 2023 11:33:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F0310E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 11:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8tSxWrpvPzuwdUEU8x1O+JjvtaWmVZOwhPrKTV92hPK932XEgcjBY9U2WgaYU04z3E0OXD1OjA8o7YqXH6KUNC7hea5RwgiXnmhkI4F+5jDgl0KOO75IJLkZLjRyrOCiYm/+FrRKPNRHzQSlX3VruR6nn6Uyz/t/LcIZjpSBXrMRUJbDkkqZgpq/PEqP+nxkVEq1OwoApbgNqnQYAcxlrYlI25fOgDvKBfzDRjraVF3qqCGCnkZv/ZiAXWQNRJMqJQYh6tkIi7IjVBO9i6tGuSn3meZyXJetSvNI/kkgUJ0f6PsS+Q4pmWXYxw81r62HIKQLDtnGaeYWAnwvspXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QZAak04rr3nScaLD8L755R5FNhQ7x+mGu+jg4Ntyu0=;
 b=ZmX4fYmWQXZzznNXjsAlEml5L3SxBDK9vuFOP3p166+FrsziNfeLIu4ri9LQFZsobQSreR7OMHh+z4keMWAh+Bcsj5uWtWxSPAbGpNCcczl6oRlUPb4428QbfI/xIMJhE5F642+i6PRX1AMq1imyrFR7oJmx4Ljpcpa3S1nXBY6S8VS13zI99l8KsMSsiMx1f70ZZz77Bc6JowvW32abWp7JeH/Et/kJ1YX0JyDFQ4D9HzW74EzRWxfAeCKPyUfA3CKGT+OdAnwyl5bGMyCyzY3B9C33LbC9QhSNT0lFhr/LThsmekGH0suQHuIA23rwRMtDNzX/Xrhau0qzl2YQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QZAak04rr3nScaLD8L755R5FNhQ7x+mGu+jg4Ntyu0=;
 b=ILPvs0EOkljtVjevR7vySb4bGgWUkXMqYL/HpR6j3VwBhn9E5AAe582iWTqBWvDlwi2F+HN/TGDFyrPqJIN2iqPiPUhzY5EGuAjge1Q61M3AoHT3m0eLrk7ElVOpBtwB5rsRFQvSq33g4/0HecRACxRszrjXOpjlzWqVGw7tKRk=
Received: from DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27) by
 PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.24; Fri, 27 Oct 2023 11:33:30 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::4e) by DM6PR01CA0022.outlook.office365.com
 (2603:10b6:5:296::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 11:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Fri, 27 Oct 2023 11:33:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 06:33:27 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add RAS reset/query operations for XGMI v6_4
Date: Fri, 27 Oct 2023 19:32:54 +0800
Message-ID: <20231027113254.20958-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231027113254.20958-1-tao.zhou1@amd.com>
References: <20231027113254.20958-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ebd2e7-9bdd-4d79-a143-08dbd6e08b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQPf95ied0Fs3wjcA9YkyJXwPxsVV6eMzXGGm4aF+0Qzhe+DkqPFLjrI/vP0G4FpmoR8m1157Mh2zgyDceCRFrpM/MWKzkPR7XhFDreQ/B1Lt0ijR10gLjTFM9ZAfiSZtYmfGIg4C6gHxuzI5ljtw9TAXD5SMF+qI+93ZsTn9mtLv35QnN6086MJyTujDNQgRbtYfJRrhvPAfsJBx5I8oxrsB4rhngQ45kFlKOlgHuQmMEsgUkUqdz0U1paFYCVQbE4AsqziZzOengEmJoaY+HjZYpCXnga02xuzC7QdqujTSnkcBlNpxC4ewdovqnMH2DvNvc9iNauBtfzeVdOvpMTiPy0ZAeRHg99COpL5J6XNXIbKfpAdxn+j78Ugb+IVCxNsro9/OwM94tBMwL7IiEm/lXEbxKpsQsrqg/CuLdKam9Wl7wcc1AuSnqvOmuK4Sl9PmqsaUVkN5hsJ79FcuW3VLg1K8ZiBMad5kyCJDCLPT+r1oh5mAjbjZD+4z4/I9wfHp+B735u8TBcAAN5z2FTArohQGcuDR1/zXGzVJ6bl3cIpRmeoH88vx4YgAgfoMMYcNDvp+JDQ81ZMmdPllMWwycd2tgCSKOcUTECZB2IlIyZivQ5lUUgl8Q6aSLAxSaiRNiqSAdVkh99GF2KZxqDZc7LmDeMBxeLz4oxCXLsQqhWWmU4MhLPHXFfx3N4IMWeEEzLWK631B6kpARw/raUUBQltdkaqCkczVINQCM6jnxr9l6a+KLR4XtRIeri/0qwWW24g5l9MLdhXnlG/jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(426003)(356005)(81166007)(83380400001)(36756003)(16526019)(1076003)(26005)(336012)(7696005)(70206006)(70586007)(316002)(6916009)(478600001)(6666004)(2906002)(82740400003)(5660300002)(41300700001)(2616005)(86362001)(8676002)(4326008)(8936002)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:33:29.8645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ebd2e7-9bdd-4d79-a143-08dbd6e08b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

Reset/query RAS error status and count.

v2: use XGMI IP version instead of WAFL version.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 46 ++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 2b7dc490ba6b..0533f873001b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -103,6 +103,16 @@ static const int walf_pcs_err_noncorrectable_mask_reg_aldebaran[] = {
 	smnPCS_GOPX1_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
 };
 
+static const int xgmi3x16_pcs_err_status_reg_v6_4[] = {
+	smnPCS_XGMI3X16_PCS_ERROR_STATUS,
+	smnPCS_XGMI3X16_PCS_ERROR_STATUS + 0x100000
+};
+
+static const int xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[] = {
+	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK,
+	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
+};
+
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -958,6 +968,16 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++)
+			pcs_clear_status(adev,
+					xgmi3x16_pcs_err_status_reg_v6_4[i]);
+		break;
+	default:
+		break;
+	}
 }
 
 static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
@@ -975,7 +995,9 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 
 	if (is_xgmi_pcs) {
 		if (amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 1, 0)) {
+		    IP_VERSION(6, 1, 0) ||
+		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
+		    IP_VERSION(6, 4, 0)) {
 			pcs_ras_fields = &xgmi3x16_pcs_ras_fields[0];
 			field_array_size = ARRAY_SIZE(xgmi3x16_pcs_ras_fields);
 		} else {
@@ -1013,7 +1035,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	int i;
+	int i, supported = 1;
 	uint32_t data, mask_data = 0;
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
@@ -1077,7 +1099,25 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		dev_warn(adev->dev, "XGMI RAS error query not supported");
+		supported = 0;
+		break;
+	}
+
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		/* check xgmi3x16 pcs error */
+		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++) {
+			data = RREG32_PCIE(xgmi3x16_pcs_err_status_reg_v6_4[i]);
+			mask_data =
+				RREG32_PCIE(xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[i]);
+			if (data)
+				amdgpu_xgmi_query_pcs_error_status(adev, data,
+						mask_data, &ue_cnt, &ce_cnt, true, true);
+		}
+		break;
+	default:
+		if (!supported)
+			dev_warn(adev->dev, "XGMI RAS error query not supported");
 		break;
 	}
 
-- 
2.35.1

