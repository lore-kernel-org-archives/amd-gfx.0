Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833A606A32F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NfHnk7DA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C770E112311;
	Thu, 29 Oct 2026 13:53:58 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7474E112323
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4RG6XLPMDxThuqZTuQlKn37qg1eSVAhiTyImP7olXALdL/iNntdLnmMFelYO7iR8Qa7IzfEsJec52hvyw5VmLB5SiXkELXULBsN1z3LZYNnMujrXlGcYKrsU5nrYI88XmispBjN3v5/KaDczcZyNRvVh2Pu/e5aYE2lAcYzJbX433us/AsIHcgQ7KcCgzm/rz23fIUU8o6an95bkpdNzcBTq8iX3QpeMnYq6r2gC+KNrWzC1o2ZXpiqvQavhxfig8ePahlH1vtPc11i5VRPI3KJ5f/EAASGYvSRGZqw7V6iQKuieueR89tIWBruLPlMerU46f9aLu7ilYQNqifUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+soAefK8uqfyyGywyRwZ9OYZ485SGUJUXpZCpzVF5Q=;
 b=LqDiJAYXcT3UpMZrunAAXG+juD7Y8XOMxp5zzuTvPoplnHCxebaB4CpyjRUXhLgXaUiWwO5ci110fWE3UjfgbmD7+amx82KRey/2S1s0S65PDMp1VHGy68PJH8zy7jyg+ZJfdmFyUzjCYtBQbce+z+/op+o3IxaGsIHYnWLI3WfUMLsrEkx7+xHvwDEdCXJ+7MscDYH9umBKPlBEcyqqlgXBKWiJmIJa8+cBFTAI95qW03BSmOOMBBN2ej4DV0Fy1sMsO4QCmufrWp2QW1N7NDiPJsEg9vfvEGqjnDLeD5tad46C4luFc4WpFk6W7XOAblhwv/By6E/UDc1rzAqsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+soAefK8uqfyyGywyRwZ9OYZ485SGUJUXpZCpzVF5Q=;
 b=NfHnk7DA3N5Ft9INye4D7tbkhGI9ZuzWSS4wzYXbvfgys8ZdQc+r1E07mCItcimMU7CS1IQk/lxdXbsEtidh/8X8YLco7uR88yWKQ1L70fI0JTjgu/N+239VMVeSHfCq1yuBab+BB/qN4LDM3ZN2YkEo6/7pFTVjVBazyQ2bJQU=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.8; Thu, 29 Oct 2026 13:53:46 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::6f) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 13:53:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 29 Oct 2026 13:53:46 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:53:44 -0500
From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: use supported SMU clock messages on SMU 15.0.0
Date: Thu, 29 Oct 2026 19:20:49 +0530
Message-ID: <20261029135050.1820997-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: bb542b7a-01ca-405b-50e4-08df35c40d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|56012099006|11063799006|261009223027099003|261009223327099003|261009221727099003|261009220027099003|261009221227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: v4CzQwXvUQw4WBEWjj1gX1MvMwFeu2w+XI9xN9VGaLNmKaaJMM/W217GX3U4RfYmCXfqzc8z3n+rwBUeL+v4g2cx/lR2xq0sLMhiOxRHvViMlRvA5W2odz6SjDN/iIb4zMkMc6DiZnQvFDbTyJaRKhOfzXbSOwROfiic+Wz+ZI/fBzOe3Eu+aqV0OwWbsgUcYE4aNpWSJ9Fw8qioBxcb8IFPKg1j0gd9aHuSE1/aDsQtb7gUyjMXSlqLgDm2iY7goybIvU78nxxJWyoLb112XQXTZySvfx/+IEgG+T8/zPmSt0obYJi5iXvZRKW6zAURnf+yen3+I5Ywo8SevI6Z4qXBw4Ik3Ki6kednCSDcaqtFCuaPMRFtrfKHrEKQe7G9MJmMlD65G6ZoqElVW5AMbryI9dRgKHw1bj0jX5+zl8kqSvoUTtwvPDGPnzn4Sr9H7atQYN36VwWemzu6wBaip4jk1ytEO9hd7+Oy/5DK7A5Z+SauEgzLS44oODhvycT+I5urbjr1r+9DvVFobrUnoQEYBJ04T4yhkW6zB2Db8T5Us2j/uFXezoyo7CCyWkbrF0gkHrPdCAMhUqq6nSsn8P7ZE7Jtxd1JrQqQ8rxT8HFqugWNgFApWCwTHXAq1FBrgrnBXDLyDthDG75Xp7VLiBrta3ifemLNzZRxtm/8qVT7i4340nx1aGrZv/BhFHExzYSlgPx2WTXyPso9/F2p4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009221227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h0cUVB6a06F1E3cJrM7KTz1kxrDk2tkX0++qpHBiFseHsWwhiReg1u8khrrimndOtYNUmTYi9/8UsM8h9LYk2JtgA4WUhrFI1lrZRy5ouc4QQC2Fos4cb8C/p2rGfYopNNL75khW/C6pqU+zgOSnDdpiWgcrAt8D0xbgbzcZGm6mY148UitN3/EmS+h1Aqkf9vfD2DLbXVT7zP7rfHFf/lQUqH+58s5RL5lMXNqtgpwlix+pa6KtBbTYaAClXaAKTinwoWnfr4RTqC2uB/cH+wR47FjV3eoAh0d5wUq7Qm9p8Yht0MDYCIttbUJaARz9huRZR9vX09xHU58CBcDeHQxZygOLIhINNFgIB2emj9a999F0yYa/1jXdfCQoc/CcAdyxWFRKMT3pepdNOO+RMrfjmoHjdpVvZ8IX8faA1xCam7KWb1ZMQq2XTreVj1hp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:53:46.1371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb542b7a-01ca-405b-50e4-08df35c40d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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

SMU 15.0.0 no longer implements SMU_MSG_SetHardMinGfxClk, or the
SMU_MSG_SetHardMin and SMU_MSG_SetHardMax messages. Sending them
makes the clock request fail.

Program the GFX hard-min clock with SMU_MSG_SetSoftMinGfxclk, which
this SMU firmware still supports.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4be864e4f0e6..e7a74b732639 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1457,7 +1457,7 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinGfxclk,
 						      smu->gfx_actual_hard_min_freq,
 						      NULL);
 		if (ret) {
-- 
2.53.0

