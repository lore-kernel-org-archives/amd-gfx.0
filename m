Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C6606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=edRsbnbM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D1210E7E1;
	Wed, 18 Nov 2026 13:24:24 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5959E10E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 13:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATsqFkTnMBr6OvGDePaadgoCzPFO9LshF7v/EhEHK/2/fycDPzJrGpM95PB3RjZjwcqtlv46lrqxpeAeGeX6BXsamQOB6UcCeXpU0ADbZaTk4qMi+of7GtHPO2UdcHGBYPzFQioCskZK5MyFzqEfhKYmQKLEMxaoGAGsBvSoAPREMuq5hv7kSG7kiXMNrGk6v70jSnZPPVUY5gm8mBnDfX5FSeM9kgc3B5YAqqxrqhN1sPoPXobbo9hOnUYJeGVxB4fRVRgFY8TV4KT0fojeeho1FMrFFA6ulUC5vtx3UgQko/VcNcrZIYV6Fq0ME6WJ8uCwY/azDKOwDXMJlmHQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CB9VXPZDbAcFp10EkUvQnskN2gL6lFnku8sgAcYvWs=;
 b=OXEdBFMn69X0XxI8ouLX/7lPZRsog5DdF6c7VXVoiVlnfJIPVq6oBJ66AB6L9hcwNP9K2dDvcwEG+re1mmBTsMDg1dkFERMu6lACpfY2yBR94mQky+I9IQzgTm/CRXQAdPRWw6HXk0XsaT7h9cfw2KBMIvE4PdS/lp5OqKj5RuolL/DT89q1I/zgDHHuIF4wOt/k6aKo0KHQtomNIxP2DhqCBMbgXYb3tfnn/bbD+P+ikk+PQsCVLTXXul3J58TqSc8E9WZVmHEeOD4bS12JZYPRGniJ9aXHsAmaaApvcrg1zJvjwx0X003Ra3Mq8onm3eqeuvJrtyUWTEBZ2EuBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CB9VXPZDbAcFp10EkUvQnskN2gL6lFnku8sgAcYvWs=;
 b=edRsbnbMj6i1iksGfYNL9ucq17yw3HN0dYkKCAJdO31BhIK/RnBKaiEr0BoPGMSb5blSswwM16kFDiQ+sUBNVyBpPTSkLm7Cf2XuvOi5qSppaPoaATwm2OMJGiEgPnjJaUKchltf9RFIOcnwOhSeaqcQI1u9EAND/0Pkl9zbVDQ=
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 13:24:12 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::23) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 13:24:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 13:24:11 +0000
Received: from SureshG-DevBox.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 07:24:04 -0600
From: Suresh Guttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <suresh.guttula@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Date: Wed, 18 Nov 2026 18:53:48 +0530
Message-ID: <20261118132348.4101528-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fee75b-a22d-4c54-cbb0-08df45773b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|261009223027099003|56012099006|11063799006|10067099003|261026121527099003|261022075727099003|261102123227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Ai0f2dgxpRsoh0e9LsbyJimOE1AXqhSsp0pZb27r3puowNoUVZnrEtnZHldEK4yIPa0ToKV0VTUJ5ENTSm7D0shFPjEvXEKr6f3/21Qx0TqnxqEXMPy53ErmpwKGiasij9nYIHCIAWVEw0s+o9YlL+aPP3VzB8nDMnCIwlh2aatrPi6PUzwxzOFgqUI5vb771BIVBfZu1yvKoq58CsTNnIpKZ5l49Yz9qrUHp2EAWrW9aRLgFVo+hMbpn09o3Q0xEz21oSlEgyS8wtES/FHF2hkWmhr/WMFrKGFWPyIKe4glVjjANrsm+OdeZv4H6S+dkgmzMG5gaebSsZqWALvHjiSiUMinb6+oSAW491zkeUeoij7HgWuvqxkYYVZAsoZhNf1oqtMiN37AzxDyGZng1hjfA2yC310Y9Sv9aKIE9/vSb5lXzhcIEpxdqIf4rvhADDB1Zh4olQCPhIL8Xvz2/j02Ou8BiLAh0r3NH5hs/vonsMhlD1ZMbKPALnoaN5LL53EE+5HzNkXTbbQjdYIbLJ/HAgTsAsIw++WaIUjEBME+0qagj/huJ5lQyn1AP5mXXxun5dtNIiWp8Mhv6SBckoiA/HneGXQky82IWnepgoU4bNAmqLTd/WjWqfQhRF47/LPzygYNSRDDd7Oo4F8GP5n1/wrQkMoMyBBdYYoOkZ9vpRRIaBYBwJLOwg6NhXjOSBHiqAUp8SUzALTCkw1mEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(261026121527099003)(261022075727099003)(261102123227099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eg2Sy3q8Pm1Mn4lWKorYOMBY4tIQqJWagOjYOgn+qm4uQ/yJagaHGzUF3dkg0EpWNyk5ci3HgKYh9pPyhEUQzwQnJbncGW6rZUtXhs3k0MVxsd86/EN+gdcbxgoPiXOHTHV0XHpLPKNGYP2x6T/DI1IYGG5s3stncd9XJ0yMnxflgcJr3XQknpRrvaa1aWu2FsG7OwKGFwj5e4Sz61F5X4ir9mRrm/xjbVm//WZ4D6I0GGEfacFfKl9K5ljsXPPU0r21N4PTUDicHIYifFpKDn3wGW5eBw4LQy7KRK6ZD1ZZrusImmXSEhPYQZ5OUyW2rRMW5q58NmvvkWjsyPTN+83wRCM09tQ98MZaIrntSDt+xFNZrgp83t5Lik7Za/QOf8Y4971SRyvkGAuAbanwfmWuXzMXBPbU1LeAsN1PuDbOjOBIyv6kAAJBuOR0FIW0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:24:11.0832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fee75b-a22d-4c54-cbb0-08df45773b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For GC 11, Eventhough IMU ucode load from BIOS/IFWI, PSP exepct Load
command from GFX to load IMU ucode.

Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7a8cc043df5e..9d6c192db348 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4091,8 +4091,13 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 			continue;
 		}
 
-		if (fw_load_skip_check(psp, ucode))
-			continue;
+		if (fw_load_skip_check(psp, ucode)) {
+			if (!ucode->fw && (ucode->ucode_id == AMDGPU_UCODE_ID_IMU_I ||
+			    ucode->ucode_id == AMDGPU_UCODE_ID_IMU_D))
+				dev_dbg(psp->adev->dev, "don't skip IMU fw load!\n");
+			else
+				continue;
+		}
 
 		if (psp->autoload_supported &&
 		    (amdgpu_ip_version(adev, MP0_HWIP, 0) ==
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index b6c4ae35ca03..3aef68c9891a 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -31,6 +31,8 @@
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 
+#define IMU_DATA_SIZE_BYTES	66304
+
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
@@ -73,8 +75,18 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
 					   "amdgpu/%s_imu.bin", ucode_prefix);
-	if (err == -ENODEV && imu_in_ifwi)
+	if (err == -ENODEV && imu_in_ifwi) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
+		info->fw = adev->gfx.imu_fw;
+		info->ucode_size = IMU_DATA_SIZE_BYTES;
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
+		info->fw = adev->gfx.imu_fw;
+		info->ucode_size = IMU_DATA_SIZE_BYTES;
 		return 0;
+	}
 	if (err)
 		goto out;
 
-- 
2.43.0

