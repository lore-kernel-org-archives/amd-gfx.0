Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80354D6ED2B
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1A810E94C;
	Thu, 21 Nov 2024 13:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pjNORigG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCE410E94C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT6QfhZS6PFHSsYM0WFKbZhOkwiVVlpRvTjzkaRgTGmLzE2fwnNM1jGKSZkDmZJkOzlWRrwAAM852IBZRi6gllZVqqki6dCMoeoyF3zq5VRzB9PbGRUSMdi98KwVE3TsM+5NmIGwkKOhPLPqoVn9l0trDW1vcWmCOIBkj3J/RTUoybkSrkXCVsEWKI5n1P5E4+ZWS2H3GPQB3Ru4qmlc6VNid17iNKkO8G0NtfofKQjbHGQqv/FfMdOXZzTvsKvkyQ01eDsNkQ/jiLvZGqHuujndm6av9pSnmHtXpl+UWh6iyCguaEcVOdDWiALBneOFm1siUZZI8fPsm+PtoWwkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjR3v4IwcwaVw9OjES78ZpPDURYcQXSZHCR/3Cy1A2E=;
 b=GS41s8oDmFbA6/B5OucFHfUvdaE8a7e8MjaHzciULZvs+zaPCE0xQcszFLeun7TQVuNfvcOcEbj781CVZa4XtbdI4C2R4Yl0wQeG4TfJxc+lSgtb5dxWhXqUZylhcMQyJClFG322+vMZqRD2EmPkPgOlfj3P0IWCb5gtWPtr1fCGbFPgR8fDIG4zUM1wrOqX3RjbwbByZBqmtQuFlL2tNlF/PPH6t6LLjJjPPqhdpKmiE3IrhKxjYMyl2D9lWFTf0NIYjZD5hwtEdzUhun6fsfE+tYm2L6qqvFFUgEnY53t4sXx679ePxk3TPNWU8xqtPwZRSl7PF5q0faZJD6QRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjR3v4IwcwaVw9OjES78ZpPDURYcQXSZHCR/3Cy1A2E=;
 b=pjNORigG/QzfAa5g95ZqVNpJ8U7j3Rmp7xxQAzrQaRblp89hh5buWlSaVoNSt0vABWhuUhk97iu2f2/OUvjZ6qVyQmTQkk19VF64JpneTUjXbFfX80SVFeAzZIoRvNuxScdhfug8sxso47svHZSBiQMC0M8lo8PaknIs0reekj4=
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 13:33:38 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::99) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:36 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/sdma7: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:33:03 +0100
Message-ID: <20241121133307.594-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bf754c-60ca-451e-3898-08dd0a311b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ycQfLiIB5mz/nMqrzLgWP3roJy2RfCqLTKQgTH8jOF/h789e26cfzRxWRfZ?=
 =?us-ascii?Q?JlvidvVGacnaAFeeAD7V+e1fxzRTXr4O1hHyckqFpV2e/Mm2s4iBHqnHaIpM?=
 =?us-ascii?Q?fi40jvkRvx3WZMQn6c1MhpJTDQF2p9htCz93Z5BomIfAah2S15roAm7C6VDP?=
 =?us-ascii?Q?x0bZeYtVLfz+DrLzpKxrr7HNWTXbXmiLiWF0m5Fsk+FRrugjv9BRCYMKK5te?=
 =?us-ascii?Q?ZLqX+8t9HznPNslPvW3gY7sNdziaaKeYHYyf+mh4mKk/BQOMB+PwTjJyu/x7?=
 =?us-ascii?Q?kAWIrXAbwtQ/KomAKVtN0ifFjqMo8L/OTygdquC7YJS5xXYzgDe5pNzw3ZhM?=
 =?us-ascii?Q?HduiDCzFmAr5Z5z4arHFOiHRe7V2nzSQ+HII2eQOSFaoxDc9spz9y3keOSAm?=
 =?us-ascii?Q?50tAQNrbY/e8nad+2DBX8F/+TejQjcm1j1XhkvvEa3GMvkVLFpFLOXDx0Unc?=
 =?us-ascii?Q?wnHzqGmDaTuWPVkM1cRQK38boqF6jXF/S8AMaO0FqZW1XvYHNKK7oa12+TkQ?=
 =?us-ascii?Q?sADyrOBy4pkBezpI2UKGppsrLdCE7hL3Vs9u0vUos6am2M+fGD/LI2Qndipv?=
 =?us-ascii?Q?KqrOOVjII53K5fx6ZXqTEVNaZPAVMMjEfyxrUHwjsLaRkA0R403jgSsrg1Ei?=
 =?us-ascii?Q?SzOB/q+wDCfHhxbDud6+JKjcqjNBQCyClnmGCIen6GRALKC78go1xsEEdHwZ?=
 =?us-ascii?Q?udOHN6boxqNfu/JFykqkxm1uVnxaO9npAX14qNO5wHbTISW7ycpXL6uwOU8G?=
 =?us-ascii?Q?gy4SfTgOgAh6REZVS584+t3vRBN2u2Id+8wEOSS2N76BNM4VQDBMZjaRwiIt?=
 =?us-ascii?Q?4u8zGMDEkmuu7kc+Xj/1GusVM4pe/DbBUAg+knidaxanpo/sc5Ie4nGpcIv/?=
 =?us-ascii?Q?mekdGSdIxj1EISk8zQdv46afwPauAXlXUn8x2yQINlZHkatCidjGeXwIt8B1?=
 =?us-ascii?Q?z+XzWQlYKpW/i0mA1SVAmmyIT/Q9f7yDOXjaVHrbRNy/aYD9TYpMTC8CKhJo?=
 =?us-ascii?Q?Y8CYA15l0ZSL56SeVEZSw5GGiLyv15UGuatmNX/NbLK+FGKavosBku8AKeM5?=
 =?us-ascii?Q?WiBvEfgFTbCJJv5suysb5u+ug8YKuRjXwLo0x0rd/rK88f5HX0Hvno13fmIE?=
 =?us-ascii?Q?mxuQhf8zs+Hz3VWAju0o6LJYQ67cRkFQQnmIk3VadATPP3OIhyr+ID8XQvuL?=
 =?us-ascii?Q?mdtcdGD19KmrhJwSRb6dzQ6aPacm7ggNhnu1gCUZKNEPjSfBy+1I5Lqa0nN5?=
 =?us-ascii?Q?3mum3DFUvJYaHuWXKVbrh0zuG88mHMmugC9KmfPycMUHAlyrDDkAOkfUcdiV?=
 =?us-ascii?Q?Jm5RvWiP6c1U5CHiB9Cme5iPhOomU1FYZBT2xqLD1lSrq1u62SceuwC470tw?=
 =?us-ascii?Q?A5cvn8EfveIO1hJwpB6lz43uHCsc26Y+HVbTpvbW+Jj5YzxldA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:38.6261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bf754c-60ca-451e-3898-08dd0a311b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

From: Alex Deucher <alexander.deucher@amd.com>

Set the addresses for the UQ metadata.

V2: Fix lower offset mask (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index eb35ec9f3da2..fc9cb989aa6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -887,6 +887,9 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_aql_cntl = 0x4000;	//regSDMA0_QUEUE0_RB_AQL_CNTL_DEFAULT;
 	m->sdmax_rlcx_dummy_reg = 0xf;	//regSDMA0_QUEUE0_DUMMY_REG_DEFAULT;
 
+	m->sdmax_rlcx_csa_addr_lo = prop->csa_addr & 0xFFFFFFFC;
+	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

