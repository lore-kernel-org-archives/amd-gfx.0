Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356CBC28B26
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D0F10E337;
	Wed,  5 Mar 2025 20:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LAPJZn2X";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA5F10E331
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGEaktTqV9ykUhLaWH7wde+vB4hd0+WBfHdr4kj3eckj9AnGTb+9tmKaIq13diiqwrsjeqpnowg7gSBxUw73TxVzx0ZrOwCA3+dCXReXx+O3xQ8e+57AIngLsfMQEtbf40o5kMCpRaP/JttPI4dLZw/ZGi2ZVRJ/PGK92JyNsPWU5Ab9y2zkybEXSUCguxmsLeMQRaZfXoH2qlA5KLqHK+SQG4bgEb6l1CAF6KXWWGwQjZkHidKGtwaA2JSeu7RGUgLV6CwIxiNeLcSvZkKGkiAw+mDoLyVGdPxnYxkRVsGoFumd0m/qjmelfIwhOn2v81shTLn+ocDCjr7zi0fFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMVWU9ERmTmWgOFLLhrXPcRFQqcNZxqCe1Ow8spkzdc=;
 b=yPSoq2etRf5F2zmV5VKXyVDCBCMyJaOXKJOfyfpowb1rFe8nlXrpS/62ZQL0I5q8xeLiNsee4Y1AKNiLfveNiHKxlI8n8Bnq+JvLp0ZoQsIsi856NuIJm+C47YLmlLVWmA6jYNzaHpLWvMUdc+MJmCFF0lOK7OEbcQKGFREEt7Hlj+HSkzfK0tt5OgkVrnl7zSAw4NysnVle/GxjHbdQbgDskZPbsI4ewldk/Vh7gdhKZ++Qi2YjQ/TEYjFuJXtv/zc5fs52T30p6A8A+9hhP1IT/axWDNeziNLsGMGX4ey0HnxJyFDMnjiNO1TCjEBNtZq/jMa3nKCcnoM/WFCcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMVWU9ERmTmWgOFLLhrXPcRFQqcNZxqCe1Ow8spkzdc=;
 b=LAPJZn2XQt+5t6B7JqCrbjnbo/ltwYLa1BHr3kuWeHp7BK04botOjkMhCH1ND+hqn7yJNlniEnK+1X5j9NbD8Ml33UOKRJiuFZyrV+WaMcJSdx8O7CWOSF+7UyP8iJvec0e1Mx+YohdpfSf6xMYFAY0WHy+cPDjbS/m9Ejh4UcE=
Received: from DM6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:5:1b3::48)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 20:47:42 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::e9) by DM6PR17CA0035.outlook.office365.com
 (2603:10b6:5:1b3::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 20:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/sdma: add flag for tracking disable_kq
Date: Wed, 5 Mar 2025 15:47:19 -0500
Message-ID: <20250305204721.1213836-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a43fea3-8967-413d-eacb-08dd5c26f9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxAli4Rk6PI1Xi8SWp5VTwZJ3of6XLr0J/CvxE0AH6VlpJlJE9CPvUj/7IVm?=
 =?us-ascii?Q?WHSWGBKWY//X0q7OrmHbdAHeJX5qRf5SZn4ds8a1UpNsbpp0MULCBe65cfhw?=
 =?us-ascii?Q?6a8tdRjvRk32+bX6lTWUqIwfAagId4qpWO3TWHj7S0Jo751xzix+pmblwQzq?=
 =?us-ascii?Q?APvIuB3PzYYzRDanpy34Zr/VEZWTaM5r2NBH0lHPJipChyk7uC3y1mrGSCPq?=
 =?us-ascii?Q?O4lTUkzpTgoRhjB8AD+jZAlSO1mzluPhAsPfTUMoBLZ6AgPXJ+opT9k3NOou?=
 =?us-ascii?Q?6ZxffA0bqrUhAccvyOTDzWK10DVqJCE9ND2yqTcpu9dvulght27nNw9ABO9N?=
 =?us-ascii?Q?HQ4q34gF/lmNGJR2PVccVNsXlaXI2ESzgSheT7VEKALNCcIyDSN6JHUTusw1?=
 =?us-ascii?Q?AqKUkaaocmI6GWoLSyWik0BOjaPS0xU+CQoBQlMkc+EXV/77PpZFc2uwR9bw?=
 =?us-ascii?Q?vXYaYII+Bv4wp7xyglNdK8cKyyx8obSEfnLRA+jEceJ9lRSJuCc9kBdQcHye?=
 =?us-ascii?Q?93IaMWkkPq5vu50uYyhdEpj5WTEfbX+5bNIp3fWEyM5mYqd1JF2Vg5lwTyMC?=
 =?us-ascii?Q?DodaxJBX0JHOmlp02ZqzgJQN6d1p+OBsXtBZsV0KcRmqImhf/+asg1Oq0WdN?=
 =?us-ascii?Q?V0hdz60zLyryEP8ePKk9XmAbOeU1fMZWn8Jcdk05Ee6DNPvYWu3y9qsosfcO?=
 =?us-ascii?Q?Xi0MkwW3AhjSifyb29kFDeXexqnT149P6RTLT/lAojU4xAD1Q2jleP+LSIZZ?=
 =?us-ascii?Q?mOz9Lheunoy8LijnsptSQr1faFrLL1rdDqD0jlz64idP/hau2raiKwONNTOp?=
 =?us-ascii?Q?sTpWXbUzIgkZxzXwE/R6UIAHbxxju45BFJz7oR6Kx/xJdIovEtJxSN3shUxy?=
 =?us-ascii?Q?8Y7im3d18K60aZXfVaNdPjC9tFYQ6d8diEqlQgd55DaA8Ojg8v5lg3cg2TKK?=
 =?us-ascii?Q?yKMuhlqHgDqtqBlGAGG+u+CWo3OB30vkutMRql8zMglknU+MC2gfafYVFt/3?=
 =?us-ascii?Q?auzjd8Gt6/6jz/ffAZe6MegSGqbdN/gwyWg0ou8C9BqupQBdlOv/rB1dMsF9?=
 =?us-ascii?Q?sOnJxdpuVdFtZ4AZo10o7zZKlt6TVn0qlD97vFCreAk9sVP3lFAn1SWzUyet?=
 =?us-ascii?Q?1rSMGYKSTbb+tCtnYo0b0ofY2QIYOcq8BdTmuuQ3mLEuE22v9pu21gvP6mRO?=
 =?us-ascii?Q?A4BIkaynIKBS6RA5QMYxa72wtLc+ckS1KRmlj8URYrf6d2kvy8SBFQ+j0YMp?=
 =?us-ascii?Q?2EMvJaP86S0StxJkimPpeOvxS/lqc0UUR8NGe5PHGRL6llmYY3DmPnR5Bzkw?=
 =?us-ascii?Q?ZLFlwBFW6onkc3CVQU2qlnHqib48CZYUW6z6TuaMzr542ZXc732MmsrEkark?=
 =?us-ascii?Q?JNJe6/iiRvRGjVuua1FANc3bM4oar+znYcojo6wLnDluJvOGU0EBFN2liUeF?=
 =?us-ascii?Q?yTE75wER1IqM/XbJuCMkqdpBxYtwQDQPjmxzANGeSUezBjq9tzmCXFDwFxo/?=
 =?us-ascii?Q?nD0Wh7tjmoiALOc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:42.2565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a43fea3-8967-413d-eacb-08dd5c26f9b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

For SDMA, we still need kernel queues for paging so
they need to be initialized, but we no not want to
accept submissions from userspace when disable_kq
is set.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..edc856e10337a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
 	/* track guilty state of GFX and PAGE queues */
 	bool gfx_guilty;
 	bool page_guilty;
+	bool			no_user_submission;
 };
 
 /*
-- 
2.48.1

