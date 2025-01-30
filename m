Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E290C02190
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 06:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38C010E282;
	Thu, 30 Jan 2025 06:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzUPY2dA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E50810E282
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 06:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDfetkdkwa6nWmZD8PqsEZZBhGKf42tHAUYkqrw7YBP9QRG8P2eqy0KvbFls47S+eEgNnNMeM1LJOwVJVfJSOfOWEU1XD5bxcbYJUzo6EHbRFMGvCADNP4V9ITkof73XX5EFFEYEsxsJsfGHqgUNdo+Enmf3mMwiQjjfV/dTB8+S4ngM3EZarque/InMSF5yFvKsBsysYdw4Ow/qT4DJZBjgihAvgAsX2P1tww5WnI15tbDg2h3roD6MUzrZHQMxe9zNKSoqVDHiELkxh9rFZvL210ZOU9SiOFkK7Yy99AsoKlBLbJsRFqRZcmTdC1BKVfvPhATSByRwJY31SMMRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QV1GVX3AKUOYG2vED5XHG+IR5sx59/y8vd8FYWWwzI=;
 b=JApir1JvBKrPFemMdX4O7GDe4p05sLyKS/utp39dCXkOqJivWMLdlyyGQATGUZhN+peF3SdKIuEmrG9bh/qdNRN/86iWQBdYk0WmsgUvpf4bFurLV9qhmFoCX1QY8xxnHFImB/OTo8toeZks8r/BFiNihgK+ZY7AQ+xzg2m1m0jqZI/UKc8YHoI33ou8r6iW3dt7K3SRl1j4sKo9YYV8ydIGeBEsQ01cenc1mDweAmqiUPYcQ0mbjI3wHKf6acNqX1J19RJU7vajknh98GvGamZSlznQyHMoN23QrB3tz/htrH8xluNrMwISFdoZsVyEaIPZovKVGnX0OqlM7k6h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QV1GVX3AKUOYG2vED5XHG+IR5sx59/y8vd8FYWWwzI=;
 b=wzUPY2dA0+Sy2sk3dB0DtfSDukNHujHksqJA+msqm9WQYFC1e6sFTxhCKFVqH0EXAoXI6/rTg+7/ekWyT3B6vGukkQVKqmPpNW8RboV44qZ1C4Mkqk4nTkR+C2QgR2t/ZZEr6GT9PMyizENGQrUHa6Za5aXE5Il3THaAqGQ5vVY=
Received: from BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::21)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 06:45:50 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::93) by BL1P223CA0016.outlook.office365.com
 (2603:10b6:208:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Thu,
 30 Jan 2025 06:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 06:45:50 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 00:45:46 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: update ip versioning for smu
Date: Thu, 30 Jan 2025 14:44:27 +0800
Message-ID: <20250130064429.2215628-2-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
References: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: a9101b14-97ff-495c-86d4-08dd40f9bbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O2DiJ4kancPPQWNt4kaSmY+XFbzVPj7pfi9jTQgMVU7F8CWfWePG9ZNuzHwK?=
 =?us-ascii?Q?S0fVXoPwm/+rXF4Rt+UU7Wz7hKioXkyzru9fa7lC6ct4/MTElcaKi4+gXa3U?=
 =?us-ascii?Q?u20T7htKeZCqouhPj+CXoJ8dlt/JH/ROayZthxK+7jdMkGJmcYaZWHeftuDi?=
 =?us-ascii?Q?DgxrIYAjSGpvFZGrzHTnDUFfjcp/YHrmASIJaW2NzUAi2lYsTupKKU0wolmA?=
 =?us-ascii?Q?XS/y3kZaQx9ZzS7mPckDHMe/vd9Vqf3Y+ZFOylcs27U35lSAHgZDuoy3n2lx?=
 =?us-ascii?Q?qXRitUioyBfiKBQUj2cLlToNGJ3jXspdDzNjodKij7MvJyizgmIIeOg+ILPj?=
 =?us-ascii?Q?X7VKC01JncpvJVuqCz3BU91KmcOr62pH0wy4BI/fELHHTprWqIQpCqIbvHxa?=
 =?us-ascii?Q?x3rEUKsAKD7l7X2sUQ2UIOM2XMQpPeB/8OAMGlAzBWIXcjD0XNlKzN8/fLIe?=
 =?us-ascii?Q?SvfZ5Q86AMEbzD5lMu1VVAvPUAVc4Z82uQH+9AiKz1cNxumVWicq0k2emMNI?=
 =?us-ascii?Q?eC8mk3jo7pVkxUj2sKoxl73f/2Sx78psIR5rQG0dSP/YwdPaE4s6R2aHzQha?=
 =?us-ascii?Q?/kYnl3D18Ijvy2x7BGYOon67Dm3j/j6c++qKc2vlooXJXt/U+xvjEsA1NLCQ?=
 =?us-ascii?Q?6M8bX/ZKEKVbk1UM6+31JWh8qQXA4J3y1OqZG1Idj+NRGFNyEwRZmW5eOLAL?=
 =?us-ascii?Q?rrNz62qTH7d8MCytWx0ePCURR2zgh2vLQNnmTHZMpdyF9lv5AomF/m5qKSJ1?=
 =?us-ascii?Q?UI8On/AZ/8ga9YnFtcLEj2o7tCXGSGgrVawib20RHP/QFOjSrUB2A+bAh5ye?=
 =?us-ascii?Q?g+87khRQ6JjlPp0GLOB9hwuk5Qrctgtqhr8bca4dSrg4YUW2O+w8t42KRzM7?=
 =?us-ascii?Q?ZFHX4OMP/qerYCvYIjIIkPc9MwAFqoXNMEVSj1uB8Nmm0lgKR3QNKbWAhtGi?=
 =?us-ascii?Q?fjU4LakoEFNv8jx9ECTlEiM9bgbrMdWKMp4CnhjsS7oPk3BaGDHyTaJmWUu+?=
 =?us-ascii?Q?Q2xcyUcHoM51fCqUHzKNB/2qa3vjKM2XYoj5dvUU/X+bCxsSj07RNe8Fw61x?=
 =?us-ascii?Q?5I4G7tzhC99jfBhlq5Iasat2XPA86/oGOpfbkPlLIYKwy2EPeiqusoqUlVTD?=
 =?us-ascii?Q?mIitP67eNndN/565h7VlEWzvAaScHZeNo92B3x8u1NNfKCuYxFVrIRHVU011?=
 =?us-ascii?Q?eWsuUtT6PHV2/xWbFMB93v6ABXuvq7WMCGLLQyfDpmog8zFW0E3w+0zk2Eaf?=
 =?us-ascii?Q?Ba+IQ7ByQmZAeWdPBzprCpOsfjaP8VqpUMXzPXWztLSL26TCOJZMUTHNDWbF?=
 =?us-ascii?Q?SbmV8o3ZmsJgEhkzI/HE2FMBld3HF9F4AL7Ts4UEyz3DlK2Bb7OiBLw+Gt6U?=
 =?us-ascii?Q?i+Wo2sGzNieZ8CeJC0zVDHPpauTlVEzILr2/2upv5RF0jnDyeZtKbpoW6clH?=
 =?us-ascii?Q?SCWPh4sUwKqYejrXerqcp6eEw4/q/ktCqLKuZbOt5Ptf4pO1v3xHkkcu3RLM?=
 =?us-ascii?Q?V5qJVho3ezhuaNU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 06:45:50.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9101b14-97ff-495c-86d4-08dd40f9bbfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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

support smu ip versioning though ip discovery binary

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fbe1e23526f0..32b809a4b658 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2083,6 +2083,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	case IP_VERSION(14, 0, 0):
-- 
2.34.1

