Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37436C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CC310E8A7;
	Tue, 15 Sep 2026 07:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ul/c4J1s";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A0B10F19E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2u1joSDs9W5PsnnnCX8VOp/kv1Syb0fPjZlBN7AuMSi5oYzvRd2Aj5Mo29yeAYjRd00HRAeoMXymU7m8ze3vbgbBI8S8vc771BAG7RGpjNaIRzQHdDIg/7Ye9wQ3jV1NwclEuVVATq0YyvprD3C72nSJvAFe243RSbOJzcI1XY7kSSAjnGyYJOAIxBKUc4BIydn1/HfNXDBLe6h9QKZKiKv+YF6cXLZ4L6rqh4tbyeqtap1F33gDioToMmgiLiCiszCtgDJ2NmbMB5gtj46YZzBX92/K5wlrM5V/zhhSNBiDUZfS+328D/fZ5BMGrpqNA4Qo0rbpFFmS10J92cNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAYogiUL5bgXqOOvNpxg7Md506RFvpiQor9OdyAQpDs=;
 b=yuIoVhrPTL/sqVuSiMvhwVEKh8nYK/kWZCtYXKr8hR5NRmbjbKdUuEbDVN7iUP1wo4Ogn7RutpRqye8upxF64CoQ2OEzf3Nifc/4rnEsTzGIAXxi9/MsgkBZR8qSNDQVINmWz8Q9zh0DD4/exd64uH53ZGtA8i49GwrpwBvUUO66wH9KEmIinYay7qXRyhzr3f+x0/3dgqemNbVkGT1ro0xsVlgDtHZZHTtcBXxWVx1mLvlgBT6yRuC0cMeTyHWleQ1iwU9V0NNBwddEF+LHww5yw93ArKaJdkUN1WbPa/rbQNKt55CcW30SnIAyuZ55GZXjK71kP4Ia609wb38XDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAYogiUL5bgXqOOvNpxg7Md506RFvpiQor9OdyAQpDs=;
 b=Ul/c4J1sdi9cZwgkl5MkdTEvtph3hr5wtSmEWzAEZLUZAH0OqL102wfbgc3yLCcsBRskewb0dNtn4x3QDvIvFPjRQ82seLUGAxS2ebMDJ1P0aLb16+INxL5//B4ZWrkHOM3c/XADJ5lFIukqwusw8qSD/l6P2EeuhU0/Knlj27k=
Received: from DM6PR05CA0059.namprd05.prod.outlook.com (2603:10b6:5:335::28)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:25:23 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::88) by DM6PR05CA0059.outlook.office365.com
 (2603:10b6:5:335::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 07:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:25:22 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:25:11 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: suppress warning for unsupported early init
 service
Date: Tue, 15 Sep 2026 15:24:31 +0800
Message-ID: <20260915072432.1751101-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
References: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9ac5ae-dfd2-45ca-62d9-08df12fa810a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DRTCWb+o4uDSqVOwyilTKxJEe5nlmPkM8fLtzl9IHqxlpa6DQTKSJytBnmm0IFqPyThiXhnnvgvcVgiKb2t0JNHGoOQuc9TEjIP39LbCngmKLm2Q270Hr/ZdwRoDyqNf1gY3UN8eNigUllRi4Aop+xLoRUW5+vUH3Gqc24O0MK1AW1/9r0nXtX9f9vQFSxtaeTCH2L3efA/KJOepGdPgZN1/mOdLtJ0vocKgkpD0MhutdVw2onq4OoqMPRtXLdIeEHUvW/I2BSRaRB9xkSEihY/pjjbzQBxHmL1ewtSuRjLLpJf78K3N916Pd0+1NdfHOwCXSxubL23IYj5LOyvXdWD7IswjfpFzhlPkmUYc0cn58G4ID4foYVeTBwy4zhGxVPpit24cIYZcJPYp5lJxLQfRLSUvdFpgjo/ZlocJ/+FIv6tXwEXMEMVzuASfyKgrNonAMxjnBQ8fLNilYZzMCH6MCrwPh6qZbTl9xbfyIiccxBu5NoriVBzFj8dXaHgfk+1rK+5rxwLFYCnNfoobFErh6lwSRhsjMcJ/G9gEgVUtJqoORz7k4ACZtktoFpclfHsqU6sArvFMU4byDUsyPT/rnG+T+0o7OQCmkKqdZVp3zWNbx7NZi1hefBAXkkZRiRbPiRRcv2Er4qOkPjgpAyX7TuzwMbEmGDoJq4zVA7qZdPoguDDKXa/qx9yE+IjqsYBtvqbkATE8p/ijZ35Kww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9qPCug5s4RPQpypUFklIrO4AUZQ7W7uWzMbkfWW3zNR5ObXRrrl5dhfuuPV8uVc7D95n2rT28ZxHWun142ab4rgSM7gn+seMSzVYorF8t6qPD5sLl7z4INrKNykiUkWLo7PtmcfjDww64q72epc2smRDlkZhkqHeupvq9WMCXjXEfvZ1VGbhpJX9OTAkEUKQEQHVaBDQLSsTSr1qPLoNCNEah/nG6WnFpK3d7pTT5AeceZzdo8562QafwjHKhAVaqLlDjOX+7oYiPmR79jeG9qhA8PYe5SHlWnUFxAZZnQUMcLVYYVPZPhld0eTtjNrU6WhoqbSTXj6106rJqQf3jOPaNmXzjaMDMVtWcJm7gKKcJxsKXjhE90WpJTM2gqUG9ZAs/dD5f5EAU8UaWlBrk7ITyVaDsNQBvOGA0FMXmMBBYFElqbg30/YAA8YR8LkJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:25:22.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9ac5ae-dfd2-45ca-62d9-08df12fa810a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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

Suppress warning for unsupported early init service.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 07dd62ae460b..23be4212d0a7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -863,7 +863,7 @@ int amdgpu_ras_mgr_early_init_service(struct amdgpu_device *adev)
 	}
 
 	ret = ras_core_eeprom_early_init_service(ras_mgr->ras_core);
-	if (ret)
+	if (ret && (ret != -EOPNOTSUPP))
 		RAS_DEV_WARN(adev, "RAS early init service failure! ret:%d\n", ret);
 
 	return ret;
-- 
2.43.0

