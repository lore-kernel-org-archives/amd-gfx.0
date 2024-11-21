Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FC8D6ED28
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB6C10E937;
	Thu, 21 Nov 2024 13:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b3KcXNBV";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72C610E937
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANnizu6/OLun9Z3GXKlQn7y3rHfr/QQwyYm2CBAobcqjvZEXUEEQZGq6+mNq558l9sVIUvL9V+mdWKVhZWgxyoYuJKI33iZ7E+puixE981R1BPZ8CLco4yocBwH6fb2GXH+YxiOohl9Qu5N18mj5j6uwqaY6AlSDlvgi5DQazinpr9vYGabTXv+FaL0weY0C19xhUW4K0Mh+0WNcJ4dgHYuGm2F5NY7JfAEBBVAZCFgIVijnNUwX/VQ9Eo7HSiQ6Sg2ojxyTR0uu0xA35/0gcc+HwtY71rZ3X7MMZUsPCmxkD496+cYrFfi9TRJU95eojU/ZyQc/WCPlC+OGM528+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjR3v4IwcwaVw9OjES78ZpPDURYcQXSZHCR/3Cy1A2E=;
 b=hBxe+BAwlPorni0CgaOdMSAW4iE+cQKm2KKQ0vfSGAj41N7nBbJKfhtW62lDkQNegdBqCqZuY1cIwbnrkJXaAgiI5Iy5WRDuTOnX3TOlsAAw4BKiOVym9NJH4ttxSHMgFmv4ytbxBmMvKvMOeQ/rmexLs2e2+CQsgFOAi2Q12cXfZgA3I5sj1nvPyOBGrDQ5z31ft7XIYhrt0LXRtptEzsXlcyswl24DOBdi4h9dWex9zqCE6KlnnB+KM1jOuzjBQrfMWG5kygzsUGmfkynvP3MBf0NrNhvOFE5S/3psRjiov1lOGcPP+JXqPYavfUBQUmFo2R1ErgouBjn5YYXiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjR3v4IwcwaVw9OjES78ZpPDURYcQXSZHCR/3Cy1A2E=;
 b=b3KcXNBVmYRFBnH4dsS8hAsyWBiNU2e9TgauCxlXsy0ihaSv0JnBG69ngqj+FJ6Luoy8U5EqlNu+w+MLgk/qHBbNkcpiKn3QHm3oDMh5d1xmpL2zhy8c83ZAO9tWVTRmsfxB8j5i/x9Fd9oa6M0ISR5AdlB1twmVQFX0SEGapvc=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 13:11:32 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::20) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:26 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/sdma7: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:10:51 +0100
Message-ID: <20241121131055.535-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e96fb0-7b38-4367-09b4-08dd0a2e0323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aHCg2Btr3ZEncvkrJKxTr1QYIlR0eUPYNDLki8AAeu9TUsb9clG0sdB+4/lB?=
 =?us-ascii?Q?L6Sg4485OdEHs7SVM1+wTaoh8Zl04zkRuCzTsXsSv5LeezN4l518tTTFkvyq?=
 =?us-ascii?Q?8IJyZRslm5wdXqSQvuE8+e9KJOCQL8FS1tEEu5CpIVsT2TUJkA0Y797jV6Ag?=
 =?us-ascii?Q?Sph+nask0mGz/eAk+zI++IQgljEb3J7WgPldekvvOyeMnlW4JBqC0wRep0Vg?=
 =?us-ascii?Q?z1w/PJBeT7yeLopif70naMJq07KBcnYuXPIa6nFxzooJBBm2DtcTX4Et4cdV?=
 =?us-ascii?Q?5uWHJgO99m/utHgoE/ZmBz/CMtLLnLKp2STt2czZYJC5JzK7uf4xWJ1682Fz?=
 =?us-ascii?Q?Y/cYyTp6k07i5/tsOBvwlObuDqK5+A3Z959Pu0BJ+65GRlmbetuZFErgrf75?=
 =?us-ascii?Q?uUiSH9mo6l30ODwT4yAuPqdBkS+h9Tga586l565SyqlGBnY4f+npPphOvYKa?=
 =?us-ascii?Q?zTN/JtChFWyrSBThwkESrTwszUkYwL1VbWVQRG5x/rgcnDYrvWZWHVQa/3f3?=
 =?us-ascii?Q?jDYNPz2rOC4K51QaKzOUd5O7exWOdudcNvV9QzAiv1g5lTDyxS7aL28M52C7?=
 =?us-ascii?Q?Qrk1BgtZq6Jr3F/Hnsy4YaxxhyEyqbtomlYQCVPu3RGuWsX/2bJWnIj9qOPC?=
 =?us-ascii?Q?hGbEGTU2dXU/rbDnH7kH3Euu4bBNw9Wrc6H5+JKATrZb+VIfWEwA26FiMlvn?=
 =?us-ascii?Q?tsolvOoRx5yKuDv49i5M3lOAzrmenXXNRIDqlO6nj7DN+vw0x6hAFxl45le6?=
 =?us-ascii?Q?PLjLxPb8L+Kmf6KBJOWEMltaUL6jonN1cpENCskgfv5kur4xU26JzfUPcA2j?=
 =?us-ascii?Q?O4dboINsbEwFB5/U55ejFoOs43xDZ5BrncS8SwcZDQaTC1JK0G9g01FGLjS8?=
 =?us-ascii?Q?Zl2Xs3rgLef3cJ42qpDNyfWziHHPET23WQPnKFvYq8OYTl34apKItBkbz5iV?=
 =?us-ascii?Q?qGXRrkpabzOaghD2R+d3mhgpNPbudEjxkahNg3yMugI3cHJ4BaWjx39pnpWO?=
 =?us-ascii?Q?Q2ia0LA/kT2SjZQce7fTkNmM7ONE8ozOuPhbUeBa6FCodu6ewtU1JZNbNM8A?=
 =?us-ascii?Q?B+1RqZUOJIm/YwbGnbYE1BKiMGJ4CiU4NVuPGw2k08pEvHGOnklXb0mpkwlj?=
 =?us-ascii?Q?kPg8OsHVJ/gKtOlQEF6VRog0Lfop1Jznjj1/egyY14hJLD4A2cFxf5LfnCCA?=
 =?us-ascii?Q?mjHzXqQp6N9A1DELBCQ8QGgQtztjHlIU9IEx1fJV/df6zVPr6BNoDEVEjkE+?=
 =?us-ascii?Q?9KyNn6DVJ37v7SDlCIuiG8twBtQqrO2yPyPUZGpcC005j9IEowkJVOARWmUV?=
 =?us-ascii?Q?t2L/YVmvAYMyo87IzdxwAa3rS73sKleJecE4xr2vjHgC7HKIeTHvjK8y/6ZA?=
 =?us-ascii?Q?s+f6pM2rC1b0sTFsL+zOLMEmqe98yg7PVR0csXgcuPE/4QYKwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:29.2004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e96fb0-7b38-4367-09b4-08dd0a2e0323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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

