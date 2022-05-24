Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC37DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 09:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5907010ED10;
	Tue, 24 May 2022 09:00:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C8510ED10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 09:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOAhESuwb47rRqdRZDFmMcT3dlD8dmcvSPQhkpWUhr180LWWAiR5eoBCnKVoKL2iSyA3dpX3Z7M34uCDtrB/Wvua4O8cFPvQ2sJb3eXoC+J+j10h0MR35ci6hA1KLtkb5fMYk/vck8FYTJ05RW/l14nP/moIPY2YX1NRv7tzULhq2kkzwoym/81sfWmBLbWRODKc8fz46GTSmOSEgwhZCS6SjwOyd+Poawsz6mWq2/ihvYLxBjORGAra9dkMAQosoUNHc7m6avhWRZl6HeC85LPcuYCtVDYR1KNyhX/JPGUUCqGHAnwKZLNsa9jyuwPLItC3oPUTAdE1VRI9CbjgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaMEGYvV4iuj3DVn5O9lxNBOUswUVOCFeXQlpnQ7ZF0=;
 b=fAuxikiWXvYf5iJiHlQIg/zaRzGD+C47EvChwhyrPW9jaIGx59fmO1VRyxZNW4pgmORC1u82ID2B2Da3NPFEV9rWvl16n7avbJcrL12uQg7JP4OwDY1xDn547ul8w0Di+Ol7CJQW6ljB2dIN3zv4V3wyAZz89PJuSlgDBAkQnk8I827TP2M9Zcp2X8M09Cm8VRGuZqvUtCYlZfr49tdvVducodfdJqWBvCFrE0N76LUQdPRN9ckZI1TNjcOnlhrUCDqrf9rBj3muKyQPGXlcqzcvEJ+L6rkI4n28GssYovt2M5pETmPpW7MBntzYOzzIQjPwN4CkXv9MPpBTgrgssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaMEGYvV4iuj3DVn5O9lxNBOUswUVOCFeXQlpnQ7ZF0=;
 b=439KBckZjx8gbJq9b4Lk7wCyasBwMIP5GE5ewCNuDXE2D0xhfd1vrjme63DGdsxqX6sxhb9rJiB9JSa61orEjTS7cwBvKRSJW57sqqDUWy5RQPaYYcFrBSQWLXAWAjcAKxWvC+xxyCF9q2de1gsZ0ZAX6wU8Y6ZVYxEqUo6AZL4=
Received: from DS7PR03CA0131.namprd03.prod.outlook.com (2603:10b6:5:3b4::16)
 by MN2PR12MB3519.namprd12.prod.outlook.com (2603:10b6:208:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 09:00:11 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::53) by DS7PR03CA0131.outlook.office365.com
 (2603:10b6:5:3b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18 via Frontend
 Transport; Tue, 24 May 2022 09:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 09:00:11 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 04:00:07 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: enable fclk ds feature for SMU 13.0.0
Date: Tue, 24 May 2022 16:59:39 +0800
Message-ID: <20220524085939.33215-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220524085939.33215-1-evan.quan@amd.com>
References: <20220524085939.33215-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d98b140-b99c-4d38-6269-08da3d63cf33
X-MS-TrafficTypeDiagnostic: MN2PR12MB3519:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB35193B0EE9AD632901D73956E4D79@MN2PR12MB3519.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkBtrhqxIYd+kC5o04dHYNyFQhGvEjj64blYcDbTrmDsDlgvL7yCQxx9mq8/NMSoZWgaAtSkTOeXZc25QiWKt7zU2JWl33bRDdzyfEw7r2b44WZpzuQa3Nb2Pb8Vxqm7ZYoMPwS3Y6FAH5PlmRVq0EWP20ez9Osyj6hIoTPaRuqkXNteZYnH0/KPDYIGA/jKWRbcrx/p+F0rtNK3LXUX3C6Y7Uhyc0UrECfHA4TOHU1YIHeflYJO16IqNpWQaEtxZRQ+H5R2aTSltnqHeZvv8T/d98Adw1FdrSGxy0WA//Yr2dHBPqdPdpcdjYZ9NgmLw3hqZgpTuo5DxKQuUTfJ4LT0ePOGatvByFdzNNsozdGRwdgiNARKRoYMOqmgrhRHVrQ4JLAERvhc+uBQly6hWjUMqN9S3AzIvBy5L1awzTN7aIxTNtcioP+O1aqXReq4pme1PXOgf8FkqnPXPJobj0xVrDuCOKvpEnniA6Uy+bqeLfrhQJmX+Y2TBCGzUYS+hDWg3+ZGqjOQvGA0K7+30uGhZH8pX68J1GxILp/xehOe+Ky66PJKAh4ejH45KdprLijPWM8H/JZUK6tiUHOruFx05nkTQKl9GuCt+f+gqVUMXldnfz8FT+CyxjTJxwmr9vEx22jXtV5QOEV4+XBXHSoTE+ww4mhzN/2DMIQ+Pq50I8NpiKZ+SIAj2kKJaNCxQfBMFTBCVy/DRKJGxZkmKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(82310400005)(16526019)(47076005)(36756003)(81166007)(336012)(40460700003)(1076003)(36860700001)(6666004)(356005)(7696005)(70206006)(6916009)(426003)(54906003)(508600001)(316002)(70586007)(2906002)(2616005)(26005)(8676002)(4326008)(5660300002)(4744005)(44832011)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:00:11.2716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d98b140-b99c-4d38-6269-08da3d63cf33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3519
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature is ready with latest 78.39.0 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I99096e23ed7ebcd5aaada84b7f11ad9e3d3cd8b8
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index bfced430cd31..70c93abe4f5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -269,6 +269,8 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_FCLK_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

