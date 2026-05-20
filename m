Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0BCCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994C310EF89;
	Wed, 20 May 2026 08:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKS0yeuA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0985A10EF89
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMDr9BxIY7JqUP7MDJgds5DKcuf/vpeVfZLRvLtbTXfWjyOsf85/+3cxbJp1A1fH/VMWVbQ/LL4e6shyhHWE3E6av/xOC6HMIsXGZyzSdojvU12iyIX3xDVRGA+akdWz0gRRO8dtlFceS9Lrrsp1W8iGyZ/A355h1J7MAwSK5eDLeBR851z6SgvrmabiB0Tcu+IPeMDtSr4863LFT44ZLth5ERRORU9JSUWu5EsjYcCo6xCKpMeZmjnZPVGhwjpUZr1TT80P30qy+4+8IpJrETHg69iCTXIN8crQirkx5dBH8AMlJvcslScGKL1qlLy0DD+MiIR7kWJb0ZmG06wM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcsy/0mRH2D4vSmq5v55Ui25XspwJZDN1qCwspxF+iU=;
 b=m4NCIGyLEfjKxlWpUNi0sEbMaMSUmtjsn7kH9Z8ZEQs1DdMiNLRVLbKQiCuLxZ+zmmmHP7rQwmNyTFAWFpNWrUDpp3Fhv6AGNbrsFm8LdbYZhBZubeGPPIQT3jFAVeMogoBtqonOz1Zo0vxAN9Xfe5aK5HCSqIr65XarhCiAAw0IaYTiwxP8nyW8yaSRnysrgNn9jIStywY86Oey5b7oX1ukMwQiJIa2IuPJ/THh7+LQjjt6g+EimUITu4caR345EMi7JRi8QTRkmtXGE3RBr3EtJov+X6zNZdcX0uG0sDWpKRnmJ8SpRKiXa/YVqEY2od5/kpG9lijFIVlQp+juzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcsy/0mRH2D4vSmq5v55Ui25XspwJZDN1qCwspxF+iU=;
 b=LKS0yeuABsPuIoJrZcwez6VY/171Rq3PqeNKb+9o4R0Z1aI/cTg1CDnOdKi83jOrmp7uvF20K74F91R15MCgkV6wE6xoNit03uiug2B+jBS4G4UjYW6NovlAJMSHLCtd6MHJOu6o53fQpuHZxVqymXqHjRLSHpcnb99stV28qdE=
Received: from SA0PR11CA0121.namprd11.prod.outlook.com (2603:10b6:806:131::6)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:35:42 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::f9) by SA0PR11CA0121.outlook.office365.com
 (2603:10b6:806:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 08:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:35:41 +0000
Received: from codemachine.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 03:35:40 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: fix duplicated buffer allocation for
 concurrent
Date: Wed, 20 May 2026 16:34:51 +0800
Message-ID: <20260520083518.191863-3-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520083518.191863-1-shiwu.zhang@amd.com>
References: <20260520083518.191863-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c984c76-f7f4-4918-6a0f-08deb64ac725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: KKieLYsKyj82LUOUdILNcHTEdkrCgIJXm9lwqz9KNeNjejLmtpbqjyBQ6n5QSz98+5bKT5yY2pd0kWt7ocAR4qxC71fOojSj0tqwe0I2HJIRuVX7O2jZGQ21NSfFechWS7q2fJZ+VFmJ332ksrpCm+vHBYFXw3sV5v0pLdv7Zrc3g0Hvbuv0H8vHBD86+WkBZx6qCaiK8mf9hZhm4ePk2UlMn/VmFwrEBO5Mi42Yc45o6GNhjZpyqxrjeWcNBbcGSmw3BtKE54F4JTW3qde3ynsZftta/NY5wi5cPzhRyaDbOenK43aH73IDEC9AM2lzsgeKric5BmXOSg+qdAKiDss5vzBK4zxeosEbqsHntDNHIZu84a6kb1Y1+OaznsMe2zK3gsSjFU82R8Cm5wHfUbTHC5x/g1teyWrfhcCzvyIS/b9+g7QQVdhf+cCMlAt+Wsan6qGrCHEd2xeoY7ufai05C68O/gcar3omzQdVr67SEHuEoJqR29Fus1to3H+PWQ9hpFduBkBaQ3KDeEI6xElLN/a/Jt4dwmc1HWDmfll5MhHuefrk5fXE6Rs2lA0lLWKDZ3SbrAFhAgH73LBxCL9jqYkWSajNObjMo2NO/n6OFwQJAAfSTPfqG3QmupoesPDEtdtwUU/P876kmLxA4L6TLLuYWUaiINaNE21GC4MiVmYrMXLGqClA/9+Dj0ckBTOGFQNpI/0RyqBMD6fYKQhSlTyhU4Sknem9GuHDQbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f6ZkymT7OuFjuIlRY24pJ4WHOu9XTExyhwtVZzaNyjNAYMC3dLHNx/Bo0/qgOq6+yvZ4nGu9poCbZJ0dv0LGpV1I53h3Lv6/SQh31uvJNTZKzT8MZhZvWgFuDnbtYAm4xwpuxoJf11vnIDtQHsNb3NkcmfQ8hxK4Z9BAUyQLW2jeOsYG2f8/f4nOJoo9ZNdnCLg7lNrafcqlBW1OQdtRct+WgZSvnYKuBp3fBLzGj4S671c5ICRpy+7c+0xHIEOl94mKOyf/joOAH5G4Tgq+lTJ+g5Hkk9BM8qWzkTKv0/nJRvMR9lAWlrFRK2dhcpTkPPIBQiE/ylmnvQPL6HYrARablh3AwYYErhxZkJz+VKHzQUdmhp9qgmdpLTn49agNsZ+WCNj4A+9iGsu7olsRzYmqXV3iHAh6J5YqLexDOLG8NaIXDPiJSsFFZM2wSMG1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:35:41.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c984c76-f7f4-4918-6a0f-08deb64ac725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

In case of concurrent calling to the bin file writing, use the mutex
to avoid allocating the temporary buffer more than once.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 576372ead63e..60a1d86ba9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4942,14 +4942,17 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 		return -ENOMEM;
 	}
 
+	mutex_lock(&adev->psp.mutex);
+
 	/* TODO Just allocate max for now and optimize to realloc later if needed */
 	if (!adev->psp.vbflash_tmp_buf) {
 		adev->psp.vbflash_tmp_buf = kvmalloc(AMD_VBIOS_FILE_MAX_SIZE_B, GFP_KERNEL);
-		if (!adev->psp.vbflash_tmp_buf)
+		if (!adev->psp.vbflash_tmp_buf) {
+			mutex_unlock(&adev->psp.mutex);
 			return -ENOMEM;
+		}
 	}
 
-	mutex_lock(&adev->psp.mutex);
 	memcpy(adev->psp.vbflash_tmp_buf + pos, buffer, count);
 	adev->psp.vbflash_image_size += count;
 	mutex_unlock(&adev->psp.mutex);
-- 
2.43.0

