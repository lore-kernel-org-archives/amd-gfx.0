Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61372C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 03:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90F510E12C;
	Mon, 28 Mar 2022 03:47:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DBF10E12C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 03:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2biNtjZsU5tdStBuDClrJg8EuFMOwQnbUnxLgB1O+9ROVVr4/K5cAbm1DYraLhhgdMtn34iS9tC8yJiFFzjtGbVyQxZbt4hEHhcS7+zkyT4RCqC5Ux3S/vNpeQw+wa8gSDNuoAZ3ZtZJIwNyUJHAPruK7bWs0/OgOVR4YYwN0hAj1yTF40xkGMZIbXTDVQzDs7C24tUnV5dKH5PYb3nRmiCGMUkvVT9n8JaImISqtjUMh/NbuP8/671RYh/tZVzr66Xzrgg8rVelnpK9way/DhVV+K67UUgPYh2vjtS5NQF5eWMaiPr0BZg0S48y0ki9Zihu8oESj5xa3MhX4AnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI+I6MIaFICiaHaJLh4Gtb+9BXrKk2LN19yvVmvfXEw=;
 b=KPHXDMATcfm+tVfkxnBMCKFA8R+OevH6pBWB8JL/vTnNv9J/9u1sD3gctzACG5bjLLU1YbfBCJn0Jr+KwG9LX02yOy048F4UC61qDvH1rj9VXAcCmnr3tKUmkD9nB1sQhP0VoxTiHbvpzUJldrwTcO0LgHmjWZbwYXWU/17C2ZhtObqmTanJ+Oi8pi3oainJnbw3Z0puw1ACHDW4CSCZgak7/GAXeoIpgQbTA9twXRglnWjYTDLoPghTRL1uXlkF5YCfDSHKd1+ro1AHzOfXGGDWePPQuHKr4uA+1o8/7jaCaqFEa4WahD5ykHQVRSHbzl18U5ifhpE5Tncxwq0qHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI+I6MIaFICiaHaJLh4Gtb+9BXrKk2LN19yvVmvfXEw=;
 b=HiugAmt+Vhsa5L+aPH2bXOcICw9SU39Tn89FulYha7pdBDjpdlDOBKUZv0mH8/JWzFJ07W0mp3H+Ez9ltbh9owuugrW/4oqsaTBd1o9tqd2TLI+tZJ3ZYlnMNHhWrpTphPYcp/JxTP20juvaNft1E+mYU3t4ju9bGNDtKsag+0o=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by BN6PR1201MB2499.namprd12.prod.outlook.com (2603:10b6:404:b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 03:47:47 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::a5) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 03:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 03:47:47 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 22:47:44 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Date: Mon, 28 Mar 2022 11:46:50 +0800
Message-ID: <20220328034650.1983337-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a99e3791-df19-4c50-2a3c-08da106db950
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2499:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24998E5C1781547C6379A4AE9B1D9@BN6PR1201MB2499.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXDFJwJpOntrhmoBG1Xq7L9L8bfZrHpVK/YfZKEtmYpAoyy5zZALJ7rmlZH42h4TU7UATt1mNvQsKE2dhR+XqW560lYj2BHskd++boEevCHyf0wSJvDN1W3WplgJtaQtRux6VLpy4N0Sb2r/hhCWgvKx81ol80/PtJf4dQ1yG9qjXJnfC0NmxXSatQ58CZL1aFwf4HcKbjEJxQDb3ckOq+dOEnZAFMsv1kmgN1kjO7fFjuqr6n01M/0GaMfiCEuDPdoGFiJ5j+vj3Qf6p7a78BWpiIqYs6rJ4TtlhGCNu4MFRpj022uxENayJdduZF2NbMgc1IGBpUXbINi4wWP3sZD2le7ly0yEnNT2hWbGpy1tT8eux1Bjfec1l++oWWkSro2PKVurR4OZNpWqlp9uC9eHc9PsMGl3t9aOXCYO22eozc+fsQU5CV38ANrN+vDTbKiU5Du/wBWbNKdxMe9iFI/RIzyMdt50jHRbnG5J+RWb1TC9n+UVKZ/ATgGOSxvAh3n0iPjNah2qw99EDvBXpl/YaQ5gMiJgRa3vjIXXo1QKuruAqm08MN2qx96zYYZhC0i40PpUk15cNR0E6R6AS3sfQKNhqdvwzHTHDQqViwLdKCtl+1l70KNVbpeSP83ajQpPen/L4jU+v8eJRdVaGsWpTP+rddDpCe/f7vnfz0ieuK/jvNWAdPs6OuBYp9qzjXsGlmXkG2jQfWcaEtHF5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(26005)(8936002)(70586007)(36860700001)(7696005)(2616005)(426003)(36756003)(83380400001)(16526019)(186003)(336012)(81166007)(4326008)(5660300002)(2906002)(508600001)(40460700003)(54906003)(316002)(6666004)(6916009)(8676002)(47076005)(70206006)(86362001)(82310400004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 03:47:47.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99e3791-df19-4c50-2a3c-08da106db950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2499
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
Cc: yifan1.zhang@amd.com, Aaron.Liu@amd.com, prike.liang@amd.com,
 Ray.Huang@amd.com, Alexander.Deucher@amd.com, Ruili Ji <ruiliji2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

RMB shall use 0x1580 address for GCR_GENERAL_CNTL

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Change-Id: I10a85891986f31411f85fa3db46970aaa8a5bd03
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 99df18ae7316..e4c9d92ac381 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3300,7 +3300,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
@@ -3436,7 +3436,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_6[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000042),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x00000044),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
@@ -3461,7 +3461,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_7[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000041),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
-- 
2.25.1

