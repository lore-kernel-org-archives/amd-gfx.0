Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F5DCD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 06:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D44210F40E;
	Fri, 15 May 2026 06:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yxaBM5rb";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC8D10F40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 06:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLVpP9eEKt5L3QQP6+8AHTpuJoMTbGD/rlzmuKjY43re8ByX30D4IZz5JVk1bFP6IFs9jaCamaXm2XDPBOGo1iP7+4h9Vra1mVZrW8MntoA5s1rgGU98K7WmSLrOm3USYZNjx7/TDIenlAJeRDLFZSLGhsqfieSZLsGVEEBbD/MkSJx9zzAVrwqCH/gi0IUFzjsveQUWc4yl//jkL59m+r1/oGtxwzZAvNQjY0d+/keKCpeWs9hvwYZ1ownqXWyl5Jio2DS38kW8R9jVW+K1kc/IkaHfj5uXtv9uJ4ODJzqaJ2STOdi3hAim6uZzUWamgnLU9nkh9Kr2/HcHy27UpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2quggVaYmW1gb419TZKmgnJnWWMqO4msm00ar8irnRM=;
 b=LyBrZVfVvmK82cEEwdL0CZMgFKy4lzC8tgrnrbLLKBi1pjJjWQ+sZZRDkXZsc5Xrpl945NES4UTRvOepW24o54npEDfCOV7kKQK79cgbWzzwCKV9Kl2+osD5JNm+EpyU8uHzOD4hQvLS9G1UQfTvvocgZYADfnsbKzAYTHvvhNhtliU1DKzNVJryCp2lAjGB24Ak77FzC6bRvRiiOajuJfqqTtTEd5Ht/M5i1/J523dfjQxkjnBiDuqNjxdMJpUnyIGKRa+EaTWWLtLwMg1aikf4I9h2OPUaF/44PZENokQeh6ZbMm8udvSf20R1nbZil7mowvfdGuGOm56MUnJS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2quggVaYmW1gb419TZKmgnJnWWMqO4msm00ar8irnRM=;
 b=yxaBM5rb6DhM3AtKpP/LtBJ25sGx1ZPArVvv0BLLxUVfD2Pl0ZiRwhyDcDE+xtC1+RQF6pPKpb+NOmjgNWccClJSNqtr91V3kcxSe4fIJZ0MG1nRkU/D9pClHWAhXv39SA4vct2SmhmOI82LKjhMQ4i9mhe9GsvAtQTF/RgUFDA=
Received: from SN6PR05CA0023.namprd05.prod.outlook.com (2603:10b6:805:de::36)
 by SAVPR12MB999119.namprd12.prod.outlook.com (2603:10b6:806:4e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 06:57:57 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::86) by SN6PR05CA0023.outlook.office365.com
 (2603:10b6:805:de::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.9 via Frontend Transport; Fri, 15
 May 2026 06:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 06:57:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 01:57:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 01:57:56 -0500
Received: from fc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 15 May 2026 01:57:55 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Feifei.Xu@amd.com>, <alexander.deucher@amd.com>, <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add size guard before copy discovery binary
Date: Fri, 15 May 2026 14:57:52 +0800
Message-ID: <20260515065753.3488208-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SAVPR12MB999119:EE_
X-MS-Office365-Filtering-Correlation-Id: e58da1aa-4c39-48a3-a7fc-08deb24f4b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: qB0SH5uiWm7P5G2IFPVLrf+rZ3PS0Lq6G9J0L/KxwHA2QQ9iP1pEuyL5NbUz3k32FULbDhrcfYNxsd/KiT9TM97yqqf0g3ls0dAx8vGH9O0aAzHVJeF3ouMKKQiZH3VI1vxdwwCYNelDZHqU1uTWr5IdH6YNtT+UongWi+b+ZSwBDmcHWHZyrk5kQYNfxUEGkcaFQvRlUp8K+pBMNArCCCc4ufY8m03TyzOQbFCZpG5FVPNrxqguqze/pxQkTVawAeQK3VX3ODyR4w1JcFSdAY1aHTy41IopAiCp03Q0vqa3oTD0ySbCyf5slfu0I7HQD/8lQ9k40OOEcdDiG7mQ/QyYtciq2n5xRybpME7bxHH5OZHGq3AR79xUbgl3PuAMQ8SwLhhkxOve1JJBcMthtynmFSi/LR6lmeg3PxLQDJ8S1nPjV40cCz3gQcBMkW/djEVaOq0TbkrpG24QE71kWw7cA8bU7+rDf4JCQKFssc4gNs6oUKN1tBHdVrrb6KsIsHDsGp2QML9d7asaceub34a/MscB9X6Vmj+U36p1hUxuJWCHppfouXoxUUJFP0uxPvHHiO5IT7xMUzcCChYvQkSQtk7CGN8VTrzUTT2vnAvhtkYHTfMLbZqc3lrJ1WUgQH+kh1c+67JVPoNM/hkmeEVLo7Sw8f2Q7Pzwp1ObFczQ90a+rDmyPf3rnQLFvassQc4pZeQyC3wof7x43X/kePMcpgTq0cPsqdEyYpf97k4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: loq02KIgaDPWbfdCsR7ia8wdBmccax/2GbDQnx3Js3OWpeHlBSZDF1WENV9d7e0GA/k/i2GM0riuOuFOHnADZVf7Big6gbNyAmlS3ntKZjHN1HCeVoOw3Npiq+IS4xNp57ELHsgnO0OuZDSZWoEmuq1yX4vInn0X0mS16+HhB8w+ooOSqrn4/KmoRBdjtyrkGdAKhpx955B6Z7CtuyGzDWOSHtjxaagKpTpQGsaeOeCOb2do9irXLRdfmhC0b9sEv11+ArtIfdjfqrGStuH4cg2WXnr6oV+vZ63iyJ1pnIuhc/PeYlZP53tb+nNNLccwgcq64qtmbnWFobRWNjMDZfGJ0ED0Ma6/HqUWsCeVmnBpmw2YYQL4attnyM/E2Q2w5CEqBC4PIIg+Mt2hSEaOJ4OuPlfF5RY7csnADu06dD0VlmgQdpfAa1+kWSzGC8yz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:57:57.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58da1aa-4c39-48a3-a7fc-08deb24f4b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999119
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

Fix the firmware blob copied into fixed-size buffer without length check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8e3b6a4050e9..c9073935e1a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -396,6 +396,26 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
 		return r;
 	}
 
+	if (fw->size > adev->discovery.size) {
+		dev_err(adev->dev,
+			"ip discovery firmware \"%s\" too large (%zu > %u)\n",
+			fw_name, fw->size, adev->discovery.size);
+		release_firmware(fw);
+		return -EINVAL;
+	}
+
+	/* Ensure the firmware is at least large enough to contain the
+	 * binary header fields.
+	 */
+	if (fw->size < offsetof(struct binary_header, binary_size) +
+			sizeof(((struct binary_header *)0)->binary_size)) {
+		dev_err(adev->dev,
+			"ip discovery firmware \"%s\" too small (%zu)\n",
+			fw_name, fw->size);
+		release_firmware(fw);
+		return -EINVAL;
+	}
+
 	memcpy((u8 *)binary, (u8 *)fw->data, fw->size);
 	release_firmware(fw);
 
-- 
2.34.1

