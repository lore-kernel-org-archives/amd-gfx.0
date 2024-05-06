Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCDCC10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 09:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5A010EAE1;
	Mon,  6 May 2024 09:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nq6PGrfu";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C591210EAE1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 09:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7XuMs+4Wmgm6oqJ1nSD6PoqgM20W6Nqj1TGm1p68qTRyTc01nXb7vJO3w1JUWt8cCAPErPy3YQK3xRSuUMoL5rBE4LyOP1xa47/AY9AibFqKMPCJZJWM/oCA4Eph6l4nRsSqOiVJ02TSONynv058G3C6q3eN+fxkLD+K2qdra8osH+o2X3rxkjEI0Ln9Qu7pNubmYOrzyT/nhXVJOelOKwZaLSK70SrUy+cbHm2IXBTGwm9h60nyya2DLBMvA+lLxUAIhOyQMyBP7RB8VywbSKQhIc4/catYriVbiXPh+UYNZOfqCBsHlQ7uNNzu14yXcn2t3on9/m1WJw5TnY78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILrxsvwJcL0u4aeZHwfRVLGdxRlhpbHBQZtOpYjtfF8=;
 b=kuLu7Z711CvUvfc1SKWhtTIg+2anLdwBjEW24x9Azn0qsX/E67fq+PA+kKJg8JeqsPywYeJaP2LXQeVu3xHrSvF9ys+BUbUIc78c3tzt9Rl3rVgA70TJNvu71bsgADK8IBtchOx/PcQyNJk6u5mStAfEnfXEISEJeM5opAG8A3Dp54qQPgoa19GFQD8xFtF62ylWJDFwTeGNxzbCku9XefiDLa7AeC3ILjpTiG7WIaWLLqWsAxHn5MZFTiu/xDsN1rxeLPuBF/6DR/HjrwkReTJ2cbwEqfAHLpQnrAdgSWsANeskgmbNpBKGF3wS++AuAy1TvswBXkv6r5dKNuMaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILrxsvwJcL0u4aeZHwfRVLGdxRlhpbHBQZtOpYjtfF8=;
 b=Nq6PGrfuVAMHP+Wdi2CYSscowx8993uGzR3nKU4rVVQWJW4jD8NzRl2Lhgg148jDb0bk6Z7gbgORS89MW0mPTMTVyqW+S7z9zWFD7MpbXq6G74FyarOMoeotV/QkquPo9Du+zIPaStBqJb0+/AaR4ELBzX/UBA6vU0OR08Q+UQA=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Mon, 6 May 2024 09:26:00 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::5d) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Mon, 6 May 2024 09:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 09:26:00 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 04:25:58 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Mon, 6 May 2024 17:25:15 +0800
Message-ID: <20240506092515.2027655-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506092515.2027655-1-Tim.Huang@amd.com>
References: <20240506092515.2027655-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5597f7cf-ac8a-4faa-3f12-08dc6dae8b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pitm3DbyXoGjo/YFw8yYwJiqxTqbIMGWrHa0kStBOCEK2HW/jfVTEgV0PNAq?=
 =?us-ascii?Q?UARAAiz1PLCPYo2lo4GlCLQOijzpIf7KFe45biVRX2dce/RE9APB4nY9wlkC?=
 =?us-ascii?Q?M5fHBmjpgUmzPiXwq6BESguHa18rV4ByGguHQAuiK+Uu5rBCpA1ZLcQ3oNX7?=
 =?us-ascii?Q?ucNcewfJlNdbOIMFYD6jeKu3xa+25Lp6NL9AGicgF77DrF746vcgzOFMYtJY?=
 =?us-ascii?Q?W/nX/qBXauGJqKQpMVdbA01Y3R0HQ/Or5RoBdxI7EnjvVvgg+GzsVJrBBT1p?=
 =?us-ascii?Q?D8pWsH8bqwjltuQQkdje9B24zUU1NUq+9RWj/L0x1NTWvohafTqcADVJtRD+?=
 =?us-ascii?Q?fzyHIfjx7lnR28svftma4LDCFgwEZ/wQc686n3qJCN0MQpCReBl5heBMy0ba?=
 =?us-ascii?Q?EfomR8eWeGvldEcsePiU5DDJyHP+PdlULMMyp0iocrpx8s5IrwqYLD3gRNIC?=
 =?us-ascii?Q?giBYgsO+5CJ6U+I+EbcJQ13tfxaQwdPGgLRaY1nhUOKC5LSyjUj0dtig4iWA?=
 =?us-ascii?Q?TxIC6LmL/KHyGYrSkFU8/8FeftfBqNcR7jIYvBpA/zztf8o3e1UDMd6lPcGY?=
 =?us-ascii?Q?J2Fog/xW9eM4VS5Ht4u2R85t3jUqiHkR3JAby0PH7tQOUXUJUtVZ/lEBbuId?=
 =?us-ascii?Q?FCsDUdD3n4xAP2TAEYzmvES4bSSQ5o8opOZHi97ztwq0c2a9qO4N9HQ5jQYR?=
 =?us-ascii?Q?d5kNKgzGwDFUSc2CmXov+I1MqkFmV9eBQXItTkJ9UFqXT9/xsgrw7KndkYvh?=
 =?us-ascii?Q?rr92x2WLeWommsvuLMsHbK0L+IgXPi99az+IaLNt/ON7uJRF31r0AwWTxwZ3?=
 =?us-ascii?Q?0XvJ7OqjtK01lV/6cjJVN4f7TKde3zo0z6MKsYyvjf5v3GdXa1hphIYsonxQ?=
 =?us-ascii?Q?i4CGQmmOnbyIvqEyv3DxxGZp06M14AlCnDttBXEofbykY7dxAVM4QNforVdY?=
 =?us-ascii?Q?cq6hbPHxVslVQ8nCo2Attt6uYC7EXNGp2xQj0jjEVRoKcyiIhymX50dXRgjZ?=
 =?us-ascii?Q?iWouwLS0f3s81SZZ3LAyR2LpyM3cBhzkI1dhHlKlfnUvIKQEQ0tl1bXcOtE8?=
 =?us-ascii?Q?lKf5MyfY8xjYVeYforhdF8qP2PPqdrZ5E3fnVHaVBLkvsZL8TnL8xcqPXF8K?=
 =?us-ascii?Q?WkSIEMXbmDsAMtkWx2pltnMF7aDpwhFVcj86wc1foTfWoIbx1TuGS2zdFBfu?=
 =?us-ascii?Q?M4ksS1NsBuvg6SLEgFlFzvi+G19ZxfMmw+yA35Nm7Y+qK7po9WzaGFkkgDQM?=
 =?us-ascii?Q?3VNEjzg85hUo9A6SOsLg7d0t/JXV3xxDumv1LbGEdczOQUtAmX6NZnXq0lee?=
 =?us-ascii?Q?tAc/9skbv1VEBXSNv5okUBDLKGmkqYyeln+S1XZx6W3CiGLBYJUZ/WhRLrZW?=
 =?us-ascii?Q?M5qdq+vEidUgwSuIKc4BYoUDHpMi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:26:00.5001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5597f7cf-ac8a-4faa-3f12-08dc6dae8b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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

Clear warning that read mc_data[i-1] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 52b12c1718eb..7dc102f0bc1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1484,6 +1484,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
-- 
2.39.2

