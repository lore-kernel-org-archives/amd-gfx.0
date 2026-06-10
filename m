Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80392CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 18:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5BE10E6EF;
	Wed, 10 Jun 2026 18:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f1kLmxCp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E9B10E6EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 18:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwGducmOgvRQSZ9fTZJS2aE6HH7KG2QY7dadeVSALaFYx5laOACs7IfKZyk2EwxChoB/lGgD+nq23fUwbF2HdsIMF/3Ygc5umMvpyxBtfWFp2ehzMWImslGOkBXvY4uxHkWpmDCqizuy9hWUuf6VODIxLPpNYZS/us1AhdXa7ihvGpBMytO1pmzr3KDLEGyer3VgiEPHEbjzJ4ssY9cbKpRtf4dWGrY7CgZvA3vJ/xz1vhrF80Hlalgit5sEaJOwnKKaGfYaudthDZKu50YXDuyFmIzoki6iIp0yHaku3UekHnRRNBA2bP1uMCvtA/G61qUZXN7XyjrBCKWIZdkFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8UxeENYr50hYo7WYUisgul/tSypdnGzhWzb7sE3/0s=;
 b=GFEtFUAdDM8ob6Uyj9Pg3M+M1tNMzW5yk+KcA7AMRZwQy8uIt9SltUzH8daudL4mBrf9xE378+mYRXUy6jbL+nIunV1lvzsNwkP16TWLmRPlOUiVRv6OIxAqlYhYJms2MsLt/0Ac834jwHcAjnIfzl5RlqWy1HLEE85+eqCBGSNmhJW4HoJ5u9Rl6XaHy7AO3RHgfQgRVAmL8Fp1Ze17hDDb/RT5EZ2jR3wwllmnEtbQd6mlWibDXuJUv8krwjiOcqY/JyLhE2nOavEl000Xtw164gE1Xk2BIPbwldSCmb9cGBdkjHqvBWOvj0fSJn2gF9cuBR5sawDQRfBjhN7NPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8UxeENYr50hYo7WYUisgul/tSypdnGzhWzb7sE3/0s=;
 b=f1kLmxCpKqkNBgyFFnRloYAon9F3eKqFEygFw6wduP4+fSLldxsfs5tmqv2U6bAKTglL0qFf0LQFy3yPnV4sFa6mxv3QM15QT3UmJpx0AWJ18aZBwBd9B9h4jfEpdODLpUUHd0U6OIDaHR8va6QMDitRAOQMytjd8uptIWENKU0=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 18:23:41 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::23) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 18:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 18:23:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 13:23:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 13:23:39 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 13:23:37 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v2 1/4] drm/amd/pm: smu_v14_0_0: add DCLK metric handler via
 VCLK fall-through
Date: Wed, 10 Jun 2026 23:53:30 +0530
Message-ID: <20260610182333.3922-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610182333.3922-1-Priya.Hosur@amd.com>
References: <20260610182333.3922-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: a083c050-de30-4497-ade9-08dec71d6598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: FtJ5HZENqLHdXr1ci0S95r3EV383DB1DCdbiuk2QLhg7aNMn1Q/ilv9XJbINXwk7W037EIFlQutkw+98e+5XfajxHIY6nWkiMLJrwvtOadxv4KrMdiMSPGH0mg5wbRuh4dzD7oBIgcHP+mHDQTeCd72racmXZ5x5lofGBVBQ9AjFmTdBXkIAYIoNCp9Cdz4pApttRzj0i4L7Jmz3SRtlLGc2lcJrh4eeCVaXotweLVU2VdKEslvVWiTGgS5pOPCnKmhQk+5BN0Md7ui2om6r6CTYobyClMCaNYzBynVvReRt0Cf6PHHoe/9SVWiEBSlq+es+I6TrgVIcW+VScXsrQr7yMcgRKdZmZ1JZ3pYXf4qq24I2HLtey0tNkIq45g3N/xXJ5hnhooe6SoO/Wu1VJwSSacdsupAQCyURqTWofbrh8cpc3mFtJbPtBw65OorPA3xPm9xvscA+GHKWU7sSeuVYtYmrbf6Tapz+RIckTZU50kZG53q1HJmHui41UbQJq84/oHDTVWts3nRh55sSlEoOr+iJppI5KnJdZy0zL077DmfdpQ/m4ymJVOhQzQcDud4mOu3hLcOEnuVUiDvtos1JaNyJEsszEqy354UBvUg7tDWIiN1qmWPhAZsWbDzXaoCXarrW56rP41+TlZDpBk/yFoRgb1Phvi6QBNkHbw72upwq2ROnA/JuQPIg2PNThxQyNVkaEjGMjdkOgbQsd4MWu+8xQV+4sQTkTSWmmhE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DqVzO/bIIsQlzvQ3Rfvmo2BOG9vubohgUrjRYmtLiXtNoCE9fr+FtJCcZ9QANyNEhah5kW1dx9chtugXtrQPAK1QUfRpLMoBL+mNt0EiBCYTfjqURp4XRmHWR7IkisVD5pleaCJv5aSOgq9j7hVXHfkbzdqq/Fy6212mrNHLJyqiZWcTU5oa52TGtHAkSK3iwof40BoIqh1CXJihYhlOEPX0ibOcWEq+eWXixhgX0yd2VeW0+BmpbJrQzH8Y5uM+scJoVtxf0LYrqKNEh1b05mrCuP+9FWYGkgM17ktE+4ltnPrUSRwbqqtkCKbHlNIkGtkg0JDisuE3AImN1FCDir+vfIocFddK4SjoXycg4/8dlQqslfSrR/qLZV+IPEoelaEKn6Xfz/MMKDbwz+ouLraAHYFlnYlB0N6/hxd6nxOUf9Hg7bfyPqJlP+qyKhtB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:23:40.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a083c050-de30-4497-ade9-08dec71d6598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
fall-through case mapping both to VclkFrequency, since SmuMetrics_t
has no DclkFrequency field and DCLK tracks VCLK on VCN.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 2fe006de927a..79e0e2fca602 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -281,10 +281,9 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->SocclkFrequency;
 		break;
 	case METRICS_AVERAGE_VCLK:
-		*value = metrics->VclkFrequency;
-		break;
 	case METRICS_AVERAGE_DCLK:
-		*value = 0;
+		/* No DclkFrequency in SmuMetrics_t; DCLK tracks VCLK on VCN */
+		*value = metrics->VclkFrequency;
 		break;
 	case METRICS_AVERAGE_UCLK:
 		*value = metrics->MemclkFrequency;
-- 
2.43.0

