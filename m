Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55706C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 05:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CFD10E494;
	Wed,  2 Aug 2023 05:15:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232BB10E494
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 05:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvmEnDsRcJR+xQ4DIMGqgluNBGTR0Y7RrZ/t90ZYFdJbKNfuZKDQYOCPznAemvXvm1IsjKEz0CqJe8zuHb6FMqhL7dJHYxs2uY4ZOfOZlbfP9YEIVN9ydklyXE6sxNavPX9vZjnmIZCAzwhJWzceN0XYjWZe/+wpF8VwdF6BxlE0QC1hd+IkoM0kv5UQnUlKU9DanZEecmwFqhax+8NHhRHO59s+OrS25aADbsFerZWhb/yuovRrZi676dKCkqwzojPXmk75+hdsG2KCwdZjepn6K+AUKGtcCZEEpdmzVAH/opZGpTvK+kWDtXV4ImJhXAhH9Pzj7mD1y7U9YGKo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4812/9++TKaRvO12siePKUnA+V8cnmBYC5Xsh7M9z2Q=;
 b=arL+Ax+SZtRj0Y/002/Zf1dGIfy7d7bIerRk1Uw0yi6H82fr8W4qQiF2CNxbkT3hbhqF98qK2wOlcSq7APm+tkENnRwp6BYeaUVq+uynKiUT1ymMdc9y3uJg2QRwCa4Nw8WNmMUecEYHRuQ6qaygvtYVskN3PRYCnIgqhz3nZA5/C7mcIihYsC2xQv2pquAgvIXj43humw2wSIZSxrdM2ytybQ3lek6yz+kQHkSCb2dTnFo7M+55yXiGvdYnjnhvuCuBTJ3H6AAM8tjaEWb2g7yEt6cSqCwQioZa8WfsQt2Hcoyl0oKmx8b57vgzNRp+itigO7ksqinyucbUWzjofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4812/9++TKaRvO12siePKUnA+V8cnmBYC5Xsh7M9z2Q=;
 b=3Y6XiUIb/A8/GwNL9aZqJ1WAjt7L/ZRtFOvALyWqDpjScRQcpC2nbbYp+wfjzakQGdxllkZPn6J9F3J12di6XEZdu4YDZovgLOV190Qjz5PCOdhZIsa7xVc6z8eaXRiLvhyVYXv/xkfvdj+WfRsTJ0nwfhDAT3EGoT6ELbmhV/8=
Received: from SN1PR12CA0063.namprd12.prod.outlook.com (2603:10b6:802:20::34)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 05:14:58 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::f1) by SN1PR12CA0063.outlook.office365.com
 (2603:10b6:802:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 05:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Wed, 2 Aug 2023 05:14:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 00:14:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Report vbios version instead of PN
Date: Wed, 2 Aug 2023 10:44:20 +0530
Message-ID: <20230802051420.238606-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 0170020f-9938-4969-255c-08db93176a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PBqOsIUHSw6KijSt9IHULmnTk3JSz9owvn9Q9d2le4ixAWAewkZcLT6muofq/OD0H8ujIclfUs8ykBzZMW/KePyujzNYtM/ZG9a5LECmQ+htsDGT+Bz3Z4BSgQt3IhWaw94zDargDCJ4XOHwj9WKcH0EcOnqrl1215TthXtGkTd+yIxVYiTCAuUf2dnhLcadMDqegX3EPXd/B16iAq6XzngNEVQsaU2hd8Mjf/KIgOcUMZpl7WSQg3HsZO8Ai68H0D04wT0813QMYTMnN3PIodVDCa+tUYrogw36yW30CvoLW07eT6No/ftwKNzMNKLVg0XvkPQy0CbchwObvBbCkb9Zshc6iYC/yNto45Wwo8/2pyStqcrQYwxVorNnYZHc/nGJEg1d1s0AXV3L3Zh5EM2cDOyRyx3AfPbGF+TEbTj7N0QY6syJ+8jpH+iLFQ5Kb2b2iW8UmP4LGMOJRfO/nTfZpzEL0p4cO+qBog+JK/izAAzS2t6YN360PGZpbdStmhkThNGpTq4bnM5K43vSQYEHswuYgjPOFc70ziIebn9jgieHI4toLH+pi9JxzDEsOENP4mE2ufgph2VMztXhhuoeC+lFz1wC4e8ueCu8nsiXrOmUKdQWE1T1fD2MgeCi73USNNOAafTJDPNQvhVWxb/F/WiUNwHZ6xBr0RIV3oY4Jfda1zUMiDe3awPT61KRhnvR6TNW6xv3X3Ges4xCmweWj5ZOrW+MDySDxbbVgEgobLLd+PtWXv7l1e5BaLkSysqFJOh7JsC2GhjR8kz9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(40460700003)(16526019)(40480700001)(54906003)(478600001)(356005)(81166007)(47076005)(336012)(426003)(2616005)(1076003)(83380400001)(186003)(26005)(41300700001)(8676002)(8936002)(44832011)(7696005)(6666004)(316002)(36860700001)(4744005)(6916009)(5660300002)(4326008)(70586007)(70206006)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 05:14:57.8773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0170020f-9938-4969-255c-08db93176a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

Report VBIOS version in vbios_version sysfs node instead of part number.
Part number remains constant for a SKU type.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index dce9e7d5e4ec..73ee14f7a9a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1776,7 +1776,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct atom_context *ctx = adev->mode_info.atom_context;
 
-	return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
+	return sysfs_emit(buf, "%s\n", ctx->vbios_ver_str);
 }
 
 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
-- 
2.25.1

