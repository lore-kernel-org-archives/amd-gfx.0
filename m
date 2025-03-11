Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C1EC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951D710E071;
	Tue, 11 Mar 2025 20:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZj2kM7E";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE6E10E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB89IjPMI6LidW4+oHS0jRj3OIX2m81aTBBn20ypxPaEaZMtMc4Z/a5xJfEvimKcN1PH4jN3vLKxKD+Cv7FlkDODf+4jlP8tLiXtjEyBDOcEdIZfAt2kE18Ds6ymTAUOOBw8fqCF/3PCdvyrHubrL5C3an12KveYtpsGpW2Fk5czfdyMLyAH1zDUaJtPlOK552+TMYqLuEeOhhq9HzDK6jQjD7OOiFUfnT4e3OV7qz0zuGz1TOURs5OSphgCNUq5LjsSHoBHRoMec12bz3j+VMiKv00wbmFtr622nn/4AFwUe3F3hUqSwyOls8ttXnmmiT4iswP1KI/OT9e3X3Yvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Sz13uIgD97JsgCxIJpkvlMh77VvkFy8DYpu7JUHZbw=;
 b=Yje7PaeCtPJBdeukq/m0IjRiDm7SMyRQcm94vZ5X+9SPAveln9bmbBv/YfHKWRk1saN0L0zS3t7XFgMbx355G5zCOh9zH4VCAIgGvcuYZ0t8FcTh7oeZ0gKlU9TPVRy6JeXboxpRNn6K30MqabPmWGqEpfMSdKaUz5VmMOvuKzeJ+UG4PRUFHHxsqxABX4dKEbdFsyzx3oWu0xSeWj5P8kQsFu78RlCzDf/Nfrm3mzbb9q+XhN08Cp7grKDGKKaPWkRPnR9sngGX8j/Ojf91FGIzz3mfTIDlEg19UvEZPjBa+kOFCm0GZNNqjaBRL0wbTac62VX41ludCzXJQhNAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Sz13uIgD97JsgCxIJpkvlMh77VvkFy8DYpu7JUHZbw=;
 b=CZj2kM7ETqFgYskd/0DCIWD6FnSXXxk8O6efKnobN52vwqkm6p4prGizKXe03qtBNbb+1dnbe9QIUWj4qBk+Etw3oNWcvjvqz/3n1Lxs6jD4MqFo4GVUBWxdLHEu6aAuGx7mXCkhLvSa0Qh1BbQ0gJPhhpgF+PJJvPpQjPgOZms=
Received: from SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) by IA1PR12MB6627.namprd12.prod.outlook.com
 (2603:10b6:208:3a1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:45:13 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::3b) by SN6PR2101CA0008.outlook.office365.com
 (2603:10b6:805:106::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.3 via Frontend Transport; Tue,
 11 Mar 2025 20:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:45:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:45:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/pm: add VCN activity for SMU 13.0.0/7
Date: Tue, 11 Mar 2025 16:44:55 -0400
Message-ID: <20250311204459.23864-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311204459.23864-1-alexander.deucher@amd.com>
References: <20250311204459.23864-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 510b61b4-00c8-4836-4d53-08dd60dd9ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xUTWjZ3YMtZZeQRXs97mQphvSUfVwR/QqlOrZigjHmSDji+BjneH0jVnybw4?=
 =?us-ascii?Q?MTEaxV4uG6N4Rmc9Soci51o6tztIpCCIzUrgBdFlVJpai/uB3Q5K6VyvWKB6?=
 =?us-ascii?Q?YHbrmtgTF7Winq+4LxdW2OeE1bta2LgaAh6KwvOgnP0ax+F8onGQzCpd0rB+?=
 =?us-ascii?Q?EeuROStAZO0Uk10IQIoYwtz8DUdV4r5oAeFdyUiclqp/9BlUAozGjABbHHHP?=
 =?us-ascii?Q?RYI7vEsXJ8qSzwGO+7G5etxcg02P9Gq7qXoyLzi8W0ZxHRbk2anFI5LqZlcl?=
 =?us-ascii?Q?RzS4yd9ijESciHBmtpU7wfcTr/q/+PI5jtwuOEp0B1elMHoTwGMXhdXtiwKt?=
 =?us-ascii?Q?UcE8iYps48t8+7BlWr+3vlvIaj1Ig0ssldrSK+h0WUafPThX5aYQty3MT+1L?=
 =?us-ascii?Q?vqITe2m2KNOkBEShpslX20xUK+zk95Zvkdy5fnA2cg6ixnwqIlW9SJV1ZBEJ?=
 =?us-ascii?Q?1ikWLBblVEFhuaF4OzmCVe57WTdQHizF+B6285WNEETbTIJPSs/cbfYc3V4r?=
 =?us-ascii?Q?tQuq5RIiYoXMkMipxAWYRjlwhgt0RrhIMbh72orezJPEDZxyxZb8UBranMUt?=
 =?us-ascii?Q?9r9ZoFcm7AbQ1AYiJET0AkOev+K+5BaY9BzC/LqbQUGzYdEqQvNi1swWzfdD?=
 =?us-ascii?Q?V3O5yf0A2fPLYOPRfsDDDYwjgzx+FMtch+J8vDySKQew5KzFo8Ix2FAc35Xj?=
 =?us-ascii?Q?ISfT/S0rVJOegkxMh/PpfrGuNv/dNEV6DguoSx6Mgr+Vp2Wl5k7jaXNOHG2R?=
 =?us-ascii?Q?XroNbeZO20hxVDfzPWTi3xEFlrVLL3znlUKTfjXvk5T0nXyLBml+cqENmPao?=
 =?us-ascii?Q?QA0mBUQMeWV7W7azamUuTtEB1NMCMC4Yg7k94K7pKAEBxf41P440u4efx4pM?=
 =?us-ascii?Q?RfPYXQ4zj4Y5lYVbFunZnIEKrklwybQgShPPwvewJ5Y5DUyrbcQmbODtn7ox?=
 =?us-ascii?Q?//KqljD6vWwF6DIsrJUG1LKJCELft43+A7OFloCbS2P57fxYUOi/av2QLyVh?=
 =?us-ascii?Q?FUioDtv1LAqVgozrIljF5zCY874NlEHcKepklGv8CHNvUOYG8LXCsvCHzESK?=
 =?us-ascii?Q?WMrM7gnKD4YYJ2vGARVl9H7b7zzW9VIHVves40UVvmmvs4cxu6Jn51ZrYThf?=
 =?us-ascii?Q?WEexueC0kZIvFOHIaSlidZ38Hv+qVpFslsZ5xbAXfuJ4tsu85YJSXZMjol+H?=
 =?us-ascii?Q?fFzP45UOJzG9dFnSt79en7lSxbto1g+OFyT9WpP/NsPkPh8kE5WCVYcMUVI3?=
 =?us-ascii?Q?gbnC44pxEfuyKduzT/UXBs+Y9lsmIpiQ3IaQi4Yq8gFBlTFVOSmnKlxWQlra?=
 =?us-ascii?Q?eIceLcF2MZfUgfKIW7dzoYKMRIzsIH3oXXWTyIwgWjTaHy3oOiBKCvqguMNO?=
 =?us-ascii?Q?tusu/y6rbu4tAI/i6DOYjq1F2mAFBkhvI/0R2Tzac9gBB9gwrpPDvRBfpRWI?=
 =?us-ascii?Q?MomlBKvg3N7CSXpRnbNeWgpiTi2yRoJenaUdGDkCHhPc22fdyFuE+N6W3z0P?=
 =?us-ascii?Q?UCCYJKxtWbm3NtM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:45:12.4948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b61b4-00c8-4836-4d53-08dd60dd9ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

Wire up the query.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 898487ad6cd2e..5a9711e8cf689 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -836,6 +836,10 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_MEMACTIVITY:
 		*value = metrics->AverageUclkActivity;
 		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = max(metrics->Vcn0ActivityPercentage,
+			     metrics->Vcn1ActivityPercentage);
+		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		*value = metrics->AverageSocketPower << 8;
 		break;
@@ -962,6 +966,12 @@ static int smu_v13_0_0_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v13_0_0_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_VCNACTIVITY,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 19f47811f6db2..c8f4f6fb40834 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -807,6 +807,10 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 		else
 			*value = metrics->AverageMemclkFrequencyPreDs;
 		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = max(metrics->Vcn0ActivityPercentage,
+			     metrics->Vcn1ActivityPercentage);
+		break;
 	case METRICS_AVERAGE_VCLK:
 		*value = metrics->AverageVclk0Frequency;
 		break;
@@ -951,6 +955,12 @@ static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_VCNACTIVITY,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v13_0_7_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
-- 
2.48.1

