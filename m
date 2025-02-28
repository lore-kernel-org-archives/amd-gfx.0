Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0BCC282D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 19:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39F410ED30;
	Fri, 28 Feb 2025 19:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="knWWUKfe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B3010ED30
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 19:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrxSNR+GunPP8mkuDPSLHL43CDknPj9acZbqCTeEkcvuEv0fhjnedpiVw52KkqjzeGtjW/4yig1hZrLPGX2/UaS8e/OqDX3Svmg5NHEvvp5HzEMveN0iMlIaZHafEO9Ebtfkz3rFoPS8xME0BsJK2VDMExs5hS+BFUlQwzKp97WQVbjA6qQxso5M0LcBDIMIWT+DCxeqGV5pmOwRVEMNexr5df+2upfBohZrOm71JXfq1u8dmvH6HZOMiJhLxvPtgWHOUr7fPoiUBw8vD+hlkWvGznwIbCMMLcd/vAAW1fr46ArQLhqfy8gGxgTLbGfjXrNIpoO+MdcudDp5FM4VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7aQrc+VtIXzs6Z+z5oWWsjgDMopopAIsoXRm/gFERw=;
 b=SWYC5w0Jf/SkYmKwTQksWquMhPPDQI9oS79h4S6GCL6cqP04YT425ZGqFArKuIXo84Bho/CF0lv3mFBeOMtNbuoqKJeAK/at5z/3V6S8A3PqTaYTULm2l/0Vgef4cK7Ce+ERPfVK+9HZqzOjMIGvnaslPHT+5iEGCW0Km6Caaoc384uI0gPKYIPip00rsLEvoDbmDmkyytA/3ZPjvu/gKdRQGmNxapV1yQNZqihtU9s1lxIUI2gG3EIhX+xF5VgZkSeyBJqDTEiHHiZtB4XMyiuk9EcuC7ja8/axXFt5WmLaWyqZ+e/xzDaqHIvunfJQYunmBItt5/Wn5/vJu/UY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7aQrc+VtIXzs6Z+z5oWWsjgDMopopAIsoXRm/gFERw=;
 b=knWWUKfeVPIV/FNuB303/yxUEqHrmBLWhNF0DxXoNh3ONuAhVyQU+cT68BNG1KdWPtujhaPBq3pPOXKyBlI6TW5Lk8RU27SAVQWL+pfCaTUck/rxtdp65ssiX68nlfjGq4lauVRU92ci2sNNRoi+PaRNtx5eMGJ37ip1Bx+btqc=
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 19:54:24 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::d8) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Fri,
 28 Feb 2025 19:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:54:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 13:54:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: return an error in the userq IOCTL when
 DRM_AMDGPU_NAVI3X_USERQ=n
Date: Fri, 28 Feb 2025 14:54:07 -0500
Message-ID: <20250228195411.2530147-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e760a7-9b62-4da3-7420-08dd5831b37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQvZKPsKq++bJsONC3oFu1bmGy61UokMHm9XCZlfqDUw5+pZ4okPnxLmLRS3?=
 =?us-ascii?Q?NEtY+1QEjMEwOflgNxq4DeSoUzUPg05ZX8pEOTh6nxHMnOLd9tmuLwmyghkk?=
 =?us-ascii?Q?ISmhjCqHyF3rdr3k2zHU88cEpVrPC6xCvWXmK/phy1Y+U764KPRuf3L0KZyI?=
 =?us-ascii?Q?+lIzXThmvL2OrABISMemEMaPzh7fiBNtf5Dn7MNcOXZvkOCPO7PqlBHmrFdx?=
 =?us-ascii?Q?CkYAf7aS74R4pDDQorrui9yXFBJdazTqpUJmjnB9GGv8Vh00NzhvTc5Hd5HX?=
 =?us-ascii?Q?z1z8AL/1lknt+i30Z2dyl/iCdYf5x57bYHdWSfNmp5I7La757vEo0HIsQsRd?=
 =?us-ascii?Q?xb1K2JcZ8BaJYlyOcT6q4IO1OlRMylwyAKX7ZlG8MiEpQzTSCvMy3TOgohaN?=
 =?us-ascii?Q?0g+ubdhvEbswBnUC3xs8DwzIrSSio5r1M/iyi7oRXlPqTOPplGQtpAY6K67J?=
 =?us-ascii?Q?qoCRAkbRfKe2H2dpEWp4w2fFvusi7LHG03Vl8oZ17zXS0bVPZHkXLUTR+bwy?=
 =?us-ascii?Q?xztPiCggAcfsAzprnxtBeBlPfSa9nmqO7DzuZ0UPBE1/MXiKZsP/W8eQfW0A?=
 =?us-ascii?Q?kewvB4BA7AkoZEQ+tBovFb2vLBrzTGJuTviLZRvSgeKvxW4ktXdzZ9TWq+Cg?=
 =?us-ascii?Q?4XxKP0z05yqUOjEpZWh+BkVwd3iaB8aLilZvm5Cw7fe/C8+7JJEJEfBoKirJ?=
 =?us-ascii?Q?a12Q65bSidl5GBNPDLCK+J93mNw8GawzVy8HBMHudEDDPNG92ey9Qjk6X5NP?=
 =?us-ascii?Q?T9rGFDLQMA0rHEj+EdJ4/umMYP93kNqk6qvUBc+wUbS72OhOKjISc7iRDQgT?=
 =?us-ascii?Q?H4cuCDaZduJUJyDIaGshQ/h5UpviXDVaWWT+vZY2BqSk+rWJiY9je0esvYsM?=
 =?us-ascii?Q?Z2E1ovkZfPiosZm/DxvDejUB81V4mOOjhEm/95nnug7CQzGMQ+jTx4aD7s1J?=
 =?us-ascii?Q?awAIrz44PBCBL26bgsMU5sTBzH5LUc9ATq78u68AY6n+4CI/wF9pEvYuqaTM?=
 =?us-ascii?Q?hFiMqkWb7n/dTgvqseGhZEaghjM6NJH2QG81SxRs6aR4wpennnKNG4XXSWe4?=
 =?us-ascii?Q?N1QuQfQAHd6dgbWdXGfGgtggrvxSJSpWu024e8agWYVEWxJuCU2+Si2th/HQ?=
 =?us-ascii?Q?r+SJBm6q3/DyY4PGPPXU0hL0JAP71H4xiTUbVl74ciMEZ2UNS0XarH8mrUiX?=
 =?us-ascii?Q?k6ZIuNnm/5dNoJGkMuQKP7/kVdVwMKD9m4nnlbN6dn/a9paoYazqt53IVcWt?=
 =?us-ascii?Q?cC5hXQBfEheTf1GQrHEIr56UfD5dUCTvDJ5N9hn6HMZZIINUKR2BlwHb/E5D?=
 =?us-ascii?Q?fugUv2Ro7smk2yH/7c5ZLtRgOuBn81b0eP1jLBE0sm3K4uwNE4QoLwJJPk60?=
 =?us-ascii?Q?HgpCb+EMiYd9hqvCkAUnIaZ0DIOIjhdq3wEPu2ta435ZVcBLw9tmSOpPx8st?=
 =?us-ascii?Q?syY+fg7FhrxkYArHhoGiRpyS/q7RcSdn5TBBCqlAwhU2/ghDaqwimvrvftIK?=
 =?us-ascii?Q?G2OgmxnxUFqyrBY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:54:24.3616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e760a7-9b62-4da3-7420-08dd5831b37c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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

I'd swear this was already fixed, but I guess the patch never
landed.  Add it now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 39279920a757c..a02614cbda36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -416,7 +416,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
-	return 0;
+	return -ENOTSUPP;
 }
 #endif
 
-- 
2.48.1

