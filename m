Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3AFE77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 10:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6561010E614;
	Mon,  6 Jan 2025 10:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJmiIEnh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7F510E614
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 10:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCIy5Tfv25O2E/ZE8M3ovhTGtahxf8skXUCaM2X8UXbmiOplcbcN9VQIG5jkYOatLttHTbJfw65dyKfokao0CgZNWRFiMvNB8VYQhoS6E9PxR1E9j7AQfYkAOWfAQY79x3MPCmyYrfjHNWsi/ST8/BsDuJ0rlCan7dT/1kP00866RNIQAT88a+3eKNN4QQP/gdoIRmOk8umVlKzNE2G5fmch3HUkbd+hHnYN+ieGUkvzt+3vxbOpcqkMlRROu4aBw5KbA5KW6HqS53YGFvnZ5wIR8pMvl2P4XhjiHcoohTnLaL/MXZ2YP5LMN82lAwXRA+OtMq1K7cxEZ4XPdZxw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WFSwp2dVCKK3BK1NVg11lVMR+K1VefqoucnMoXXSlE=;
 b=oNa0LZZvZddQcli1fJhDex33OKfoBwonWHajQkm7xgzjIKBaE1CtbhVdE41AyNb+Z9k93RzZcGfV9USsYlUyG3Z5M+SlIfMZZGx0tKB1i+ApsUtiKxd2p59kwMAb3Ygu82Tf5fXvO5SDNDI0L8Wwr9HcvRAXhTPdchZ+US6ub0io+iHH2C9jsXd3g5x5Lc/CW09UAVEW0V/0jEGgN/1nADD7VQpnTNE2AL5vJRqTA8N1hAiO/fCn4fEttz0rdVDdagpwhqeihnAXZgJ0G4P/Aw11IkIWvh8yWXjDFRFgEtTpr/m8U1udUW6otGXJotfdTDZR1eWF0JhrUJf3LA1cuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WFSwp2dVCKK3BK1NVg11lVMR+K1VefqoucnMoXXSlE=;
 b=cJmiIEnhTN4L7mIniyeJ9hHbYacIsFJmVYXHU5kgBmsZuquFV2OllNs1AH1/2heepJVJaC7R9JqgLlsODo+JQ32mRfF7rDoylGahB16KH2Z8q0xyi5LFqw0rACayvB7YaegTell5IkGIcLhEEg+Iq2IOyS2UhlJlh3f4ve6P6I0=
Received: from BL1P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::20)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 10:52:43 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::aa) by BL1P221CA0019.outlook.office365.com
 (2603:10b6:208:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 10:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Mon, 6 Jan 2025 10:52:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 04:52:42 -0600
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 6 Jan 2025 04:52:41 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: fill the ucode bo during psp resume for SRIOV
Date: Mon, 6 Jan 2025 18:52:28 +0800
Message-ID: <20250106105228.2121987-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f8a8e2-11c6-48de-9528-08dd2e403f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ezH2bTO9sjHj4LnHLzabMIZrfJu8Bjo0YfhrVVNXu65DTtbjyKNBSZyNVi56?=
 =?us-ascii?Q?CtDif6lc6Q7HCtZrj3erzpdDxbDAs/BRmmNfA3xxNdnx65jvkE6U7Eesfika?=
 =?us-ascii?Q?KViC77e3LiejqtfmEvSbavt9qpUbHd6ju6qAmXiSwWLqaeCJNFXLo4yB5OL8?=
 =?us-ascii?Q?cpVwbdGMw5aUR3CXL+UNC9xNYnpNWbwNjAoY/ZHlVTQirH5eLNno8WXNVbYO?=
 =?us-ascii?Q?3tobBSzBbJsBMI46I9V+M0bNa9+zdiGM/B8tFMnm2gGt3VjNS2C0gw3WEkr/?=
 =?us-ascii?Q?mSOUQdusXt6XzN2tTrOfMTAuQ918X7Sieukh7WpeGhZUBE0GkD43Ld3nh4l1?=
 =?us-ascii?Q?0Yw2OzMLsVa0ounkCJA/d3YA7oAvOXisp1XeVdURJ25LuIzmo5xEWPnf0Phu?=
 =?us-ascii?Q?v3BR0lrGJDjcM2h8UoTwvP9DURku9ISBJ3/z62f57oLPdjkFiAIaWSUTGnmT?=
 =?us-ascii?Q?LJMbWWhdtU2PnDqxoYgyvHwHQFVjmSAHHpUFgpPMYlSUFV4oGZaRnFCT21WX?=
 =?us-ascii?Q?BLgiomHc2o5XBHEXVKs/mjiVdVKUFpGfajvOao8iQJwfYJDSq01Z8pn3vMSJ?=
 =?us-ascii?Q?daFK0tRDTnJNbhUHrfzLrCKZoEl6axxy3avrXpvxsP/6wR0hUdXYlco8An1p?=
 =?us-ascii?Q?Q4PBQmyOkE5bxHdeXRwEA01jsowuScI3yHrFcfN/kcARCqyZ4jL4u1W9DvsN?=
 =?us-ascii?Q?q4cZKufdZfesow8YrK/8Z9gMBJ4hnE07F+4QAcQ794CwfcEv7aLmTauu9Qs0?=
 =?us-ascii?Q?JhmzT1IxaRgq0T6lWER+eXu/ovdc/nxJ2m6G7ZK0bJkVUYVuvQd/ZZLKbzba?=
 =?us-ascii?Q?s33iOgM1D2/K4C+O6f35jFe9XNE9B/6vZGsTAZu1XOcZQwyDVNpokVAPTTu7?=
 =?us-ascii?Q?th82eCP+4ekeUYXtc6yLtPRzIPm36lTKgpUHJQiRu+x95/+9FZ+A3S5u3JxW?=
 =?us-ascii?Q?2L8eiGkdgFw9j7T9T46vwmHdgICnMfVsPRCXmkwwlW78am7GND86S9qShdEz?=
 =?us-ascii?Q?SG7mNelsse2PSwQwWiSXl31LQPk6MGqervwv1X2ajHOGNaFzqd7lc6YV/kg9?=
 =?us-ascii?Q?7qccsx208Z4lvvmwFMFdwWvaRACS0kvF5rMqIOOXf4mcXe7v21ElXAKqf6zD?=
 =?us-ascii?Q?4zi0t5dFWIeoltMc92ADyM8HDFrJ5nbscdUp9d9JjCmYy4o/TD5BMChD5/6L?=
 =?us-ascii?Q?u/pepTYcUvCfF4y6pDdT3h/GD3INqW5tyXkRc9C66SOK9BTg/oeVlQQfXcPR?=
 =?us-ascii?Q?VINunCYZbV0zaAWq6gkMljnKkArRqy7q9zQRdMBOX3nxuf/m5HeRFhPHyU43?=
 =?us-ascii?Q?WU0WN0QAKRt6BR606Jc3j6OA5FLHvFT13GI3Er1eD5LYdNQr4rmZZwlg+VhC?=
 =?us-ascii?Q?htEC5o8HvvjRvIwNya3bGayoXstj0mEr5emHa1UNbFOuAnFu+Trl7n5BsRAb?=
 =?us-ascii?Q?qHKeurO6iFO1pHel3KzpB7gCn4nxB/hDrDWNo9161FRZb7pVCoLeibGUmMph?=
 =?us-ascii?Q?DsECBa69qElpQdY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 10:52:43.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f8a8e2-11c6-48de-9528-08dd2e403f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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

refill the ucode bo during psp resume for SRIOV, otherwise ucode load
will fail after VM hibernation and fb clean.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 010c038b33ab..97fdd93c3ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3148,6 +3148,10 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 
 	mutex_lock(&adev->firmware.mutex);
 
+	ret = amdgpu_ucode_init_bo(adev);
+	if (ret)
+		goto failed;
+
 	ret = psp_hw_start(psp);
 	if (ret)
 		goto failed;
-- 
2.34.1

