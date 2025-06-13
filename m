Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A602C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 09:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15AD10E948;
	Fri, 13 Jun 2025 09:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCTyYbvZ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF17B10E920
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 09:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9svhM/A51cHwv8A0onF1hKimTxeNpCCc1MbM2fygCbXTCeiQEkBJaiSVL4i43BPncCVyl4WxA1e/6pnmpaYRI1NGmbht1lkpABPegWNNrc3fKQIWIJ6gFFz/5WTmuoZFqoBC2AoRLILEpdN6AmLc+BP6ZnLc4FaH3nBGVYUgjpAAgnlDzIKJi4/wvtnwOc9s9N1ut7Yi3+iiqcPaMoLOMj08ZUBzMeexkqGQ2ZSKNvj0ppYwwXXK/d9unV/5uw5dGVyBDBWkqLuto45Cce94q+Yncvg1sFj7KJMlVRGl8E9/1vXO5Z2IeWZ40zGdk7thC/v/OCK/KfcU1wIwGsvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zvT0J3raLyt8FDv6eO5Eym+wrOIBVnLw+sDNFQ7HSI=;
 b=I6iv8sFh7qIssr5cjOp6nEz/1kvy8jlo6NERCpK+ZA+L9HL4COtk6aS7uPSR2RrDv5APD8rTJz8lWddjy7n5iUiMiTpPSvHXPwu2hH+tc8qU9rcUZLtC1XfrbZyR+sYhPXIHPcb3mnNOXkD+8jAYPddRQmYbzMrYrPzuV9Pw+UuLs4kg3QK43YrgcCR0mmQHt9hgNtI0VC2kR+8a9rYyTXZj1yFQQgRTgCXtsAt+hmXnnys0a3rXYLtklV0HfOSmaQBaEzkVVTz9FAxUA72iSQa66emOWmAb5YQSnxlHjQ4Wr8YX1SoaAhHwkyugbHq1CsuE/614WIONJxyBKbOaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zvT0J3raLyt8FDv6eO5Eym+wrOIBVnLw+sDNFQ7HSI=;
 b=WCTyYbvZeh0wrYX9abArnshkFqANw4C90K29MrElhUTiESaUqj8DMeBQJTOkCAmg8lEy5g9kIMKLtA5xQMOY0zhs1hGvTkwWyfDRaKqwVKfIMdnJ17JGPl+JbTARn4EEv4dSUuwW3Y5ntWREXdCBi+9VAisPq0lKhmr4fVTu8bk=
Received: from BL1PR13CA0212.namprd13.prod.outlook.com (2603:10b6:208:2bf::7)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 09:34:05 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::46) by BL1PR13CA0212.outlook.office365.com
 (2603:10b6:208:2bf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Fri,
 13 Jun 2025 09:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 09:34:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 04:34:00 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Report pldm version and board voltage
Date: Fri, 13 Jun 2025 15:03:41 +0530
Message-ID: <20250613093341.830218-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613093341.830218-1-lijo.lazar@amd.com>
References: <20250613093341.830218-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c119bc-154c-4fed-5e08-08ddaa5d7031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tkyKreyNgBTcyw2ddj93QJV0GBAWLoAcmwLBLurSXCI8bEpPuEZZuheqwtSu?=
 =?us-ascii?Q?xNhLPg/kxuEliaHMA8fFev691n5aXqUR7QRbe3lxwWZ5WfqEgbCD7tVeXsCX?=
 =?us-ascii?Q?NrZ2z+1uXQhnBr4KpYn4knK8P/zqRRh+WE5WxuI9LrkfdT7CzqON8/0O/RU1?=
 =?us-ascii?Q?C7/UNMFw+hDr8KgELDnsc/yiAxykRrIDLTsU/32b/7fKLZGyzopmF+t8xAzS?=
 =?us-ascii?Q?C44bFyfRkZjTIhrE8h19erMLMd7mMjd+7sS+mVOzv3HtFU/gxeTJ+nKBFp3g?=
 =?us-ascii?Q?yaJlkl+LggWqyOPfw8UcdvQdIQdmnvJCLGlgaiNYdgIyiHfqq14/7iJQiALC?=
 =?us-ascii?Q?TdELow0dTwlYHGdk1TSXxXNkm8Hk7PKeCyjEgXCKOzkstA0QBjuVpn+oONvf?=
 =?us-ascii?Q?iJVYYSmuDI5zhhkK0Mwcy0qLFIf3ZpRJCctJVKYZ+yziKahJmn5erHGt7wpu?=
 =?us-ascii?Q?fLG44pb0tui3mF+sZ3G9rSrmAP7Lerj8w/k+WmrxA7O1uxJ4eX9RGaPt3RhK?=
 =?us-ascii?Q?zGYFl3L18pBVUCsqNkU4QrbT/K66IV1rEKad+O6+is+gDiKI8zHgcFg1/l67?=
 =?us-ascii?Q?YMuNe1/IsE/7Q60UOVOU4+GKFMsFltJjQcB3uPZmpnQRyd0hx3ulHXQ5l1O6?=
 =?us-ascii?Q?EKHIVIoWuC/mEasW9Mu8AeDXZ0XnOqTMpEUfB2fDXIZwun5T0yVJo72EYRTs?=
 =?us-ascii?Q?KgegnMHgKA3RwgpLrEMmuH9CiM0X82Dn7YtluIrIwrDYH1TAH1Lu+IlhLnka?=
 =?us-ascii?Q?h3oHsAYeAMPHemwLdDl/pWKdQ/I4VbnEdAZ5f5J3jyDn63yBnfK2gZt3BSm4?=
 =?us-ascii?Q?wa1GOjV/lsR0A3XHediuCoGsp5XTDiHGBwJpd0sro/R/Q7XWhUPd3xYbT+K4?=
 =?us-ascii?Q?tCtpjbopqjSc5WRVe/EuCW6eLZTK26ygZZWrHfaHPVuRuWtypmtwVKZQ8ZQk?=
 =?us-ascii?Q?76nT1zpdLu29hbmXQ7UI6w82YR+p7hn4yrS63xfesvad542NQRk/MOi83/zm?=
 =?us-ascii?Q?SDRPut0wAp9XfUXS1Ahk/Nd69tUzODKSflfq9ydXaGQiqzTuJ/0t0MMQPome?=
 =?us-ascii?Q?NISphi0xssUmyh5W48gyAGsnonrrOFYryTIRIp7F6lci3wapDxr1zM7B4zzC?=
 =?us-ascii?Q?i5sL+4eg8CMvxngEWlmp6WQfYUQ+wreC5H3RcdFvfyJCbiel8Rhiy13mntn5?=
 =?us-ascii?Q?xPNaYypuIcKR4Sdita/zGRl3WS8f3OcN/AtsmGx6iLqDeBd9uzug++SRTJ4J?=
 =?us-ascii?Q?OTsriiiXe3H5eyvdW6tMzgRhPJsH7b/KlDdaKNAbXFhRd7h7b1n6pFSr0Yoq?=
 =?us-ascii?Q?u3EC8b1NItVN8UNylbyOEJVp3cO519uJEc7gZGot4nOtPocyjm6s85ak7cTo?=
 =?us-ascii?Q?J6/aloBvRLLT5wPnGqHJKb4ijuYjk25MWiXA3TF7DQ/s3q/WTjsOMqSCs2PT?=
 =?us-ascii?Q?32y5xjw/Sdabk2DqheQwDPQAwzebhwmAT660seYXdz2BJvGGbXNHQb/XSlUv?=
 =?us-ascii?Q?DUTNJk5xpZYQ3HmjmZolxBVOAaFqCxalJrxz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:34:04.7029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c119bc-154c-4fed-5e08-08ddaa5d7031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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

Add support to report PLDM firmware version and board voltage on SMU
v13.0.12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index e0d356f93ab0..77ca98600c1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -189,6 +189,7 @@ int smu_v13_0_12_get_max_metrics_size(void)
 
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 {
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
@@ -237,6 +238,17 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		if (ret)
 			return ret;
 
+		if (smu_table->tables[SMU_TABLE_SMU_METRICS].version >= 0x13) {
+			if (!static_metrics->InputTelemetryVoltageInmV) {
+				dev_warn(smu->adev->dev, "Invalid board voltage %d\n",
+						static_metrics->InputTelemetryVoltageInmV);
+			}
+			dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+			if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PLDM_VERSION)) &&
+				static_metrics->pldmVersion[0] != 0xFFFFFFFF)
+				smu->adev->firmware.pldm_version =
+					static_metrics->pldmVersion[0];
+		}
 		pptable->Init = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 36f210698bea..44daea9a07fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -345,6 +345,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 
 	if (fw_ver >= 0x00562500)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
+
+	if (fw_ver >= 0x04560100) {
+		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
+	}
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
-- 
2.25.1

