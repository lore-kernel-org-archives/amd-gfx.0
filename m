Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F3C54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84219113629;
	Fri,  8 Mar 2024 08:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwv/l6eT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE64711371B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb2uX6AWoRFuAWNi6K+2BdQr1JeOzaWa9aZGkCSsX7POpJ/W/1AHqorSbhvkMViPaUP9KKbd+Zg8Seri06ZLcYoZdqcH2ww0Lqa9ibpWd1p5cWyqWCKtaAWCv8CJPxCm24rF2CL32VvTI3/AAi5z8Y8hmwXrq/wdlQo3rTZ6cYrxXXHRDzZPBxyOQ8I43w51jMAKSNtugvib1+iTN1R8IiPmf8ASYxxoJquSIMLGy0/0BmZxHKbLCI1GHvob9FkAtXRA9FuT3tn/Jp/1QTyiM646mro9V10D8yOpm4P2/5bMhCHj3HJpu2PlR/l8cXkIKpcKZ5z0pJpdvsC9Vma0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tATOv6OwHdkmGB1F8HcGhhHXpvx7Lc6ZhGw+a6cvtaY=;
 b=W23TfeNC56HlY7DlSGDNBRAZHjcuSbFo39Dqlh2n7ILqTxqZffh+gpWgMlbxaK431sRlr0QzuRjs7J6Y251NOxSEAD0pa/U7iEO63AW7cKa9noLWuYnoWKLoyimg9JmrCZeZmErVhixmk3MZUwfc+e52A9j/a6EK1lMpajiH1dx5wwfoL7u7mQvV3EAoeaKkG1uomMBTsjPvimlGjbRM/7pIqTMK5HgvO/aH9/tD73ovvTeSNwN2ZrYwCRcizjDY3Po+fOqMq4i/rVlEsvt8i3w+u+WZlxE6WD141pq7x3wxgDrQXSYXRnFXPxqa1wrVf24QRW780Ka06oynD/Rl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tATOv6OwHdkmGB1F8HcGhhHXpvx7Lc6ZhGw+a6cvtaY=;
 b=zwv/l6eTvQUVRyDRco2mlVIQgS1ADCbh0adAXBTmbo3BQMZfXkkZNFI0H4NJtaedkejaaAc9EFvUfbc7CmfSClJIhcd2BQgNAfkU0zCmtBpyM7h3NTZsE8ZY1/Hq1vTeynxMw7wmGTzeVgEWcSAgSs9/Ca2OEk7mtA8CZD07E7Y=
Received: from SJ0PR05CA0192.namprd05.prod.outlook.com (2603:10b6:a03:330::17)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:54:25 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::ff) by SJ0PR05CA0192.outlook.office365.com
 (2603:10b6:a03:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.12 via Frontend
 Transport; Fri, 8 Mar 2024 08:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:54:25 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:54:23 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu: add VCN sensor value for yellow carp
Date: Fri, 8 Mar 2024 16:53:58 +0800
Message-ID: <20240308085400.385793-5-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308085400.385793-1-Xiaojian.Du@amd.com>
References: <20240308085400.385793-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: b32d1606-dab3-4b64-c8af-08dc3f4d5b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rc+nuc02y5Bjlic5l8HI7OEo7r4wAhNH6eNHAnJRe65hehj61idiE+pkQiKsE4rNzEoLIU3+KkD840kHC7At4eqUn0AggKAt6V6fVHfwEAxNlQ22wo5RkpHaqBPqfhuoVfwZp4dzNBpG+wmH/BZBxdHwlzNQ73q41hgFn4OrW2/IgSfrpSMM/ZobU+7YwHSBTXHRTauJRIJ/cDKHNijjdtHA5DHpkqZpzwxVhcgbOxxn4pMHyv/Z41jpfplk1CzkqFCvcBXyPldVwn/9BFdWD8LkhU4uFfLFdLQ9+AIk67/JTF986X0PgleYzBD26/HVCZSI1bybTQCkRA3jmEsKUgjR3+2t9Hsg76ZaTi1t4tIfAzr4kHCViIvjOJU6T+bqFgi2vUfjhmgHpHdb6PBFwZhIdjJVIGQKzF65BVbOKaKWSpSntu/8LcKqubD0u5bnFWitYUCuV8xMw4P30XPpxPdyncyEvd4vPfnxLdq0HLJdxvHKWFqqfj+SwYQ10CB1ZJiAsmhjqNw5UzXvAZfXvLiC8jCwLUajfLy3taCnrzAfjnTRI6eR5kiVejBQwU7VjpYl9qDS8aWOwmYYUJehS3+Us0Awn4azFvwVoirUHVv/Atae4FKjLkci2IWBnjJDV5Q4Lg+0S3vckUO+YuJwLfg4IXHZx5ZBRoXnyKk/rIWRUUvP2NK0G9iTrXZLMem7OgQWFa+fSde0cWnqB5rwv/kpPYyRb8T5jmDTXG7Iup3qoDcjbxrCKZGTev516h3P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:54:25.3185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32d1606-dab3-4b64-c8af-08dc3f4d5b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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

This will add VCN sensor value for yellow carp.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 2d1736234b4a..d8bcf765a803 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -363,7 +363,7 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->UvdActivity;
+		*value = metrics->UvdActivity / 100;
 		break;
 	case METRICS_CURR_SOCKETPOWER:
 		*value = (metrics->CurrentSocketPower << 8) / 1000;
@@ -423,6 +423,12 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 								(uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = yellow_carp_get_smu_metrics_data(smu,
+							METRICS_AVERAGE_VCNACTIVITY,
+							(uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		ret = yellow_carp_get_smu_metrics_data(smu,
 								METRICS_CURR_SOCKETPOWER,
-- 
2.34.1

