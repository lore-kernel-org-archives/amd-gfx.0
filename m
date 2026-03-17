Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35159FD875C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 12:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFB510E351;
	Tue, 17 Mar 2026 12:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQ5l+cZB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A5D10E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 12:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGtfB/VJ59fIWRUlMjBDZoMb930Iv+0YBUnViJxq5A2rXxQQZhUZabQgzPUOsvBBnbwj1HHCcVAaDtehNI82A10Dyqcahq9PBc//cSwphB+TfDNxovNRGydsr9Q/VU4FTn+3JZq3w0K1wr1dW3R3czIGmlNHX+i/eocoLJqakbd/oC5RxzFzjFsLjuPunnPPJLC8hUR2nDZ1C7w3LcctUAF/aWGXkJivYIOJNUGu6btjwTXFJHupJ5ttspedU7L1MC8qt9LQRYnTk/+34slV6B2XpjvdZqkPGlS2Lo4e1aMBeNXzan7qtsYDbLGekaNYLlJ6XkZ6DolKktJJfR1EFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZsZuTEXHpFVWeBu6Ex/TR7WiSB+O3uA6UYwx/wKoXc=;
 b=JNyVmslMM4ufXyOTJt+SEPQFB/PPx4I+Fp8Jk+baH8KieJN9Mo5JaDsQeRnmvC3jrIF53gGEGhK/Jw4/xAeXsgCc/VcgICJIkqFAscLNaoMEdp2So8HZetKBj58/JLJKpk6xDyi5vcDZLS6Uk8VOzr8vNfljAzkGdkrahQkLAkRcLfefnae/T6/hhAvtStuirdDwDCOj5SqFet9KPX0X9uLUZioD427Nz78vh+wE9P8aV8/kS/A0lIFyiNuhbWXYuetizJwJHQ+G79E17fEC9g3vgCsBB1ezdA0OsyVl531In//V5kn5EwLlQ4dLl/e2ViBpXQJo9lbC5cmAiUag9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZsZuTEXHpFVWeBu6Ex/TR7WiSB+O3uA6UYwx/wKoXc=;
 b=RQ5l+cZBA1rFOPZNjDtowBMp+JM46YnMQN1zHRVn5ihmDcBHEF9+kSdXvatQERPCv5bD4Vn2K11J7oca9QqNBjHdRxDbtM949crP8IEGvFNY6oNTl+Cm3AWxCDyjw2W2WCsKj1Z4gkqQ3YXaU/KIrOKGWFPAeBmI3NUhBzqxkdQ=
Received: from DS7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::6) by
 SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:25:58 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::9c) by DS7P220CA0001.outlook.office365.com
 (2603:10b6:8:1ca::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 12:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:25:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 07:25:56 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Add client ids for gmcv9 mmhubs
Date: Tue, 17 Mar 2026 17:55:29 +0530
Message-ID: <20260317122529.361748-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317122529.361748-1-lijo.lazar@amd.com>
References: <20260317122529.361748-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 274bcad6-f46f-42a1-eb5c-08de8420580b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: lRHhxFhpOZEk06bdYhwTWf/DGFoJe9uvZTo69cPDqRifl/3CxXgcG9GydJOmLMvHrnVgBPn9VCwdDO3Gs+/j3cEPcjsOE8LIEJW3cMK0vI9twgy0OkiqsUXQyeJ5N0obCS+RvB91TMp7fL2Pww89URgzZ2xSyDRPW4MdmXMDxwLKumrizzdvEx4CnkZzZ2sqvsdOk7FC9YyJBoN7QIZACeirXZatpt3ygvJmazQics0rzUzNdmhXRauZXkGzkMHYXmsEe6d/WpKt4Ibcgj7RNG0nlfWNpKESbYm6ASacdWuLN8h32mboz3nFBuyT7UuBp4thtvnAyuYNCEUPriHsYMJt51GxWXe063mfEOzVT2bcaK/uf3cx7hMa2Vg2Pwa6o+0ErdlV8XwhV5/VryvzDhhumJjSE7TB2GQSnf5pFdiiyeUdu38tWqwNcIh1+NO7fq9mjTkXL3yz5+cIYJpCr8ee6qQAqEmkO86lscj6VTDi2o+28VDqSHeG4AR6JzlhfPSNZ0eFr/otz8aE/NYknxF45syYwh/S7w8dWK3NNWayxdfE0W825MGriel9EdPrQMk6dmdXiTmGlVkltBAp2OABcogQ3UQsepuTaAN6tNEV1ax4DASxn+4YOZm2+OyJxqH2SIU9aHuFSBQCvgDVDu6whc1wh14Pt+7TcE52uINGmIfmkDEIi9X2tiRHhh+0/SKELIzgRbDFUsFehNI/YS121LrI0JpbIonhnBlCqjSC6ETcem7NOjgjbjqhg0pvTNHldg80QDx9F6g8pgeKgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OmNtfIqp8Ffg342qxZXlRI4fdMXUE0dqZ4uAOacgP/nimQTHT1hSUAFDlhrLoqj7+CKNzPt4Qqo6ekwt5rb1naJoR8B/Qr2xAbOxhEZNgn2oplnZn7N99rmQeCBANeiKM0C8bgi18+LZO8kJkoPmCHMAANfd1AMnFH87CXndPJGRFCsWYcD3DAiVtZqAfIqX6Pq4w3Qu00Io1AtNsNDtDHa0bJS+nt9wpFH2xwPuecxdmDbr3H+ML8ZERXkJWk8d++gzUA7tGuQjThPBQmrMPz7CfdGVtLkqWcGZeCsvCLxY9I9vVGwHciLL05h5SfltNe3Um/XZRFpEcT8o73r8cMgSxmYuHF9A6LSrwn+i9t+R2VYIrr97VDexrWCwQdDnT2uAKT5MXi9oVXLPk6QSSvMr4bXSGrSAGCAG9g2duhdicq23nQaDHPrAOFLpT0JW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:25:58.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274bcad6-f46f-42a1-eb5c-08de8420580b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

Initialize client ids for gmcv9 mmhubs

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 78 +++++++++++++++++----------
 1 file changed, 49 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e35ed0cc2ec6..1ca0202cfdea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -660,35 +660,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			gfxhub_client_ids[cid],
 			cid);
 	} else {
-		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
-		case IP_VERSION(9, 0, 0):
-			mmhub_cid = mmhub_client_ids_vega10[cid][rw];
-			break;
-		case IP_VERSION(9, 3, 0):
-			mmhub_cid = mmhub_client_ids_vega12[cid][rw];
-			break;
-		case IP_VERSION(9, 4, 0):
-			mmhub_cid = mmhub_client_ids_vega20[cid][rw];
-			break;
-		case IP_VERSION(9, 4, 1):
-			mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
-			break;
-		case IP_VERSION(9, 1, 0):
-		case IP_VERSION(9, 2, 0):
-			mmhub_cid = mmhub_client_ids_raven[cid][rw];
-			break;
-		case IP_VERSION(1, 5, 0):
-		case IP_VERSION(2, 4, 0):
-			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
-			break;
-		case IP_VERSION(1, 8, 0):
-		case IP_VERSION(9, 4, 2):
-			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
-			break;
-		default:
-			mmhub_cid = NULL;
-			break;
-		}
+		mmhub_cid = amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
 		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			mmhub_cid ? mmhub_cid : "unknown", cid);
 	}
@@ -1428,6 +1400,52 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static void gmc_v9_0_init_mmhub_client_info(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+	case IP_VERSION(9, 0, 0):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_vega10,
+					     ARRAY_SIZE(mmhub_client_ids_vega10));
+		break;
+	case IP_VERSION(9, 3, 0):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_vega12,
+					     ARRAY_SIZE(mmhub_client_ids_vega12));
+		break;
+	case IP_VERSION(9, 4, 0):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_vega20,
+					     ARRAY_SIZE(mmhub_client_ids_vega20));
+		break;
+	case IP_VERSION(9, 4, 1):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_arcturus,
+					     ARRAY_SIZE(mmhub_client_ids_arcturus));
+		break;
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 0):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_raven,
+					     ARRAY_SIZE(mmhub_client_ids_raven));
+		break;
+	case IP_VERSION(1, 5, 0):
+	case IP_VERSION(2, 4, 0):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_renoir,
+					     ARRAY_SIZE(mmhub_client_ids_renoir));
+		break;
+	case IP_VERSION(1, 8, 0):
+	case IP_VERSION(9, 4, 2):
+		amdgpu_mmhub_init_client_info(&adev->mmhub,
+					     mmhub_client_ids_aldebaran,
+					     ARRAY_SIZE(mmhub_client_ids_aldebaran));
+		break;
+	default:
+		break;
+	}
+}
+
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
@@ -1445,6 +1463,8 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 		adev->mmhub.funcs = &mmhub_v1_0_funcs;
 		break;
 	}
+
+	gmc_v9_0_init_mmhub_client_info(adev);
 }
 
 static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
-- 
2.49.0

