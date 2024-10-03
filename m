Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFA9CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C94410E9B5;
	Thu,  3 Oct 2024 23:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qi2j+MOq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D404010E9B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8VssottvMqySnC1fL0h2maUH3dBm9InZzYpr00AYelQR4pYZstUxOMi5iYP7FJW/Dj/+rD3tS3JE6eMN0t22s0nOtcOmXc9Uzi79I6C9ptPWYzosVN7aMIFvqckm6uBtrqQjmuwUTSKoW62cBGFqpBCgcNh/9EfvFRlNubQMMiYCXgZzAY7ngM7RPg+Y0eeu81QpXm3r2RSs1A2nOvk++e5UJffSlQpretc+2WsnG/OvyvYz9ca3s5haPT9mO0yZ/IJClW+Uj9Vbrz4WzgTPP/alqcZbajwMc2zu2ti3qRHd2yv7e1PrD1AwTj/LbmHWuviIw/Ekj1TIXvEzE2ITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdFuJVZTVS60vekxxzH3n7CjnOVR6/ZzC+o6GCACnlE=;
 b=bZy+hv1HRzUNSpTCJ476y2QRjXD0TGXWAJLeZNZUFG4DGJzkSwd+qtnvkQwQ+wKZ3GrQ0eJuazFP4PRVUVyQDhJfKV0vZL+axdnT+/MrjWTVKmiAT7Rw0o26Fdf8Y8MMevDFIpPHj05WZNQcVzBC0qmIcWBrhTQWg7BMMKBNlaW50yNQKTbDyQsnoZsA6TMGdcl8QV9p+nEbGEJxt5H3pbZHbfTyPhelhBJd7SHeCE5yh2H+ZExK6HrWV6tNIxQEU8bDHZ5BKJrsRMy06khFhrgF9qC0+pAwzMgf+mg+TIE5OisR+9uovTjbjgDtSAm4TNdEGOlAAPyQsWdMowPebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdFuJVZTVS60vekxxzH3n7CjnOVR6/ZzC+o6GCACnlE=;
 b=qi2j+MOqBajkuNU+8AbbSUzdDsHudIA2RP9mjWNb3O/M+zEdK03AeJNrPpF9rWeXtkh2dqtIrg/iAFQ4kg+AbcVt11vUQSuDXwsVZ2YsR8PNIicYzaeWmx3Ko4YmxyMM1GHmmyvl7NdtQrC2EjIumxnvZXndpk9nNS6mH5N8Kf4=
Received: from DM5PR07CA0091.namprd07.prod.outlook.com (2603:10b6:4:ae::20) by
 CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:36:17 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::30) by DM5PR07CA0091.outlook.office365.com
 (2603:10b6:4:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 21/26] drm/amd/display: Add DMUB debug offset
Date: Thu, 3 Oct 2024 17:33:39 -0600
Message-ID: <20241003233509.210919-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: c72d3b31-b16d-47f8-1685-08dce4042d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?icv0UQSmdgwed8q5qwklU6RGcGp4axi8dXD6iNTPMQ0tthKQB729k8c6m7ef?=
 =?us-ascii?Q?QafQKQVoR1GSh6yjkhJlVFh40Ve4D1pMlklbFX2BfD7zB+Zy4rmq/oJuGcD2?=
 =?us-ascii?Q?kB28w5Pyh9ayAwPGR9OoS3ZtlO7iNWkWhzc28DtWK2sycOeKmTKSS7eqa6bC?=
 =?us-ascii?Q?1sdXv/3Z51P1o6osFqzb95XXRympnQlE+NCccPF3MfCGXbXz9qjE9RlhGxQC?=
 =?us-ascii?Q?2e6PirTkaC3vtwh/gKHQ/IQ6tCgoLWRQCSzj39ge1d/kUlnlkNDBcKoazJQE?=
 =?us-ascii?Q?EgyaX7lNKcrj3RyxGa7I2uu+o5zaEzNsNNzz/kK21ldofuK5JayggzeNcIqX?=
 =?us-ascii?Q?8yMQWeRl/IOTK1UVRYcVLh5Ezoa72LCl/VFj0RpjwKp5gtNFbVwWrJi5e94+?=
 =?us-ascii?Q?iZea+95vIkCAOSZq6TjHlaC2GGbGoeFZSjxwQ6RvcI4oQ0Kmr2igMVieoP7K?=
 =?us-ascii?Q?ubMXxCoixkZJuZ7o11HaL5r92uzbEbpuRjqQvyOPxMhRCUoZybKi0PDfNCT5?=
 =?us-ascii?Q?9DpssG9k/KcOlM4PylAg89EZMxZU7rwGI2lxKtxkc3lA5Zprj3uSlhmI+0KG?=
 =?us-ascii?Q?Y2gMKtqaK1eNa93ui9EdtTZj/M8KWwPPb+WPfXAcNBzqIbQvTgCVDY2gnYXE?=
 =?us-ascii?Q?RC0LAKD/Cdc7pCPrRay37O0QHCVspGM0geNh1GcgAAkZ77FlEco69M+UsJQ1?=
 =?us-ascii?Q?YyHb3k/IgBN1b1otT3sKIypmJf64i0NsaEWW547qsfqxZv8iLVcIZeJbV7Hf?=
 =?us-ascii?Q?Pg3m8RQiNO0C4XiVk+UWg5Nj1HH8knDLOIlcJc8D5prTuA4Ga0q8lNQHpyHX?=
 =?us-ascii?Q?ehQekxBTZKP7ol+HUIg5ZZByBpacKIAW1N7dh/3gKP5uk/HSGQDdAr04D2O0?=
 =?us-ascii?Q?2dJnvPccYm0rwHxpfzftynGmiF93ibJ4+7krNInDP4H7Y22MEuEVPkUFkGTf?=
 =?us-ascii?Q?4GfolB0thp2gzJ0POXyVt2kJaI0E+96m/iNDmUQOJd0vc9rlWTHWR+2vu5bv?=
 =?us-ascii?Q?O4pYwtledB5zC+iX/ehWbonyCYSVmL7tkGhM2xM9xJ3O4g+ogCRHxwj4L9JM?=
 =?us-ascii?Q?lGR5jSkCnF9meAV9vZQdO4E6YDfTXV/29Vi/J+x+L0JnJUvyniaKiGcV5ueC?=
 =?us-ascii?Q?HuchIImL7hioTUz2hGcFNVRXNZXKPofsS7g0mQZ5v3mInOasSppzcN9VqEdr?=
 =?us-ascii?Q?9nK7O3UG2TQSWE13cp3gLGauSNvDwaPfyzRbLjFnjUDSZfUoOkdCPfFOoOVp?=
 =?us-ascii?Q?PkDbfuIV/L+O48/T47Ktfty8D9N5PdyGYCgEAULKewgOXZL+qjpfOZGWfIqd?=
 =?us-ascii?Q?EF/pSXsTaQTmJHsvGqfaJFnWFTMPNR80wILZmfFNGhYHRqeeK9TDWSW5pTv+?=
 =?us-ascii?Q?cwmqnKA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:16.9839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72d3b31-b16d-47f8-1685-08dce4042d5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Add DMUB offset for future use.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 05d352c7b1d3..f9e82c4f8deb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -170,6 +170,11 @@
 #pragma pack(push, 1)
 #define ABM_NUM_OF_ACE_SEGMENTS         5
 
+/**
+ * Debug FW state offset
+ */
+#define DMUB_DEBUG_FW_STATE_OFFSET 0x300
+
 union abm_flags {
 	struct {
 		/**
-- 
2.45.2

