Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC5BC3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C4F10E4AD;
	Tue, 30 Jul 2024 07:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qms00U86";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D5510E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPV8y/3jDk634UkTULndYv6zyCk9WVv5kIFL2XmkPAXRrFGQd247yE7gFW7PFYgpldKyvXYOo2mK651V3nlAATwLJYZ7sUo8AVYy3FhPEOp8QpJ/5IWebNejZnWEmyJVE4TbyneurTmRSRkckM+gM77dPvz2afBiZ4p1cmT2+og3K3wqcOROtLaPoHjorMLZHLCIN20+x6pra7ks2khNgm6vAmLuXL6QB0X4WkLbTXVOFXb7oUi+FKTCngTIWadUtY+Pwz+x2UpaJ9lj8OB8KXDLKrNxdXW8AO9sMCsniWO5AWWg6j6nqkiYDTwrPOqV2ATA6SVKAPOAcV285K30Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHqYjQmcZm2JHUeaV/K86f7Y+rwRvM5PnQUELN74gf0=;
 b=mgPVobBxvVbdu5N2L3M9xGbUT2M57oxGTgEQdmBy44p0Z/mwtMx0OIvXf6zcK9VLjbxAaqhR9czUVW3+xhPOMTqfUq9rJnIl0ZKxFKNPGU5pAI4BIjnMfqlrkIz+SaMyP6C+naWSpy1L02H6G1CcfE9wWbIY6P3ortlfRGa+AnrqRmKPFjPlfLVIzjI5H5nnknUb1o2cnyshpXI7SCCGq4LHA5PBh/gor3YbWy4gm7pPeHhnGjADk7ZasT2VyHHEYqyiI3eBElV8nAtyl1kDZB5xVNLUuONOcTXpfeUglOdkkKePCSRzPmt2ftHpc6uGTpr5rj8p/2QlHxIEZMjG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHqYjQmcZm2JHUeaV/K86f7Y+rwRvM5PnQUELN74gf0=;
 b=qms00U86bTwV3+OhvItEDHHEeAk9TDJsgosxLNa2i/hQp3a2Qkn+PU3tdWYp0VOHvg4IpFo87jzg9rW/YxlpNUeNVThFowZHy94P4XmeYgQAGWc3lJuhc3LplaH6f22WQK6fXDYS5N9sGnmpiw0cvIobMY9DMVpdrfNLuN7t2js=
Received: from CH2PR14CA0054.namprd14.prod.outlook.com (2603:10b6:610:56::34)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:19:23 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::52) by CH2PR14CA0054.outlook.office365.com
 (2603:10b6:610:56::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:21 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:15 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 01/22] drm/amd/display: Add missing DCN314 to the DML Makefile
Date: Tue, 30 Jul 2024 15:18:22 +0800
Message-ID: <20240730071843.880430-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af58423-fb45-4038-67ad-08dcb067efd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hc/gtDCMrW7cxgTwlijCofQ77nG1lMr+aLEEdivQfUIsdzqsKP70I8jToowb?=
 =?us-ascii?Q?+WY7y/8BWApyHwMiK1kEFqtdNUSYqvu1q/+bC82BAnaHdpqpfEG0fADbk4+9?=
 =?us-ascii?Q?FZ3ekIHtrqkp/SBZDpRvrIhrNTS6JlU+ae08dd24iXmf1iNivHzJPRc+Mo0g?=
 =?us-ascii?Q?IET1dodDvmf7PLEVx2l5mEszpjOl//naZCjVXUjhtJR4hpvwa1UCYx410xkR?=
 =?us-ascii?Q?bU7k0xftKbA+vrjd22H8G60tjJN/zpP2J+SRvq6J5rya0urHKpHnI5C0ewri?=
 =?us-ascii?Q?isb1foxhPbZHwq0oO1GrWRNtsrcPjmUzlXWOISMuvVQMDoceXYrBxQiAQ/K/?=
 =?us-ascii?Q?urccojVwLNbj91dlzObyWJ9CcLz30IQiwPLviXa7voUoZD9yDAK//eUZ3Op5?=
 =?us-ascii?Q?QMUFJvHjZtd8Pdex1eRcifs67baUXfcvjtzun+xn7FOQDyUgWNYekVxYfTLV?=
 =?us-ascii?Q?G81A9QZl3bva68RnQPJAgc3Lswa/3m1k3MK9WdI6676dumDzlSeKNG6veog2?=
 =?us-ascii?Q?49wvv30EZYOVh8ADdUYgRZd966kNLfUPrzt7qZuYYLD9UllQ62JRd7tbP0EA?=
 =?us-ascii?Q?FBkVFWaTJ/CQE8IHd0lj+jvbz773tegg5mQZ97pqeT1YneWDorigCsjEuWxu?=
 =?us-ascii?Q?cSD3lZgeHemRi0RFughhcpd57XQrfGepmP4HeoVCI6uk002xm1MLAFhvKwtv?=
 =?us-ascii?Q?LGpUghul4tCeieRaksk+LCli9R2u8kCH3OIlJAY0Bd4aIcdJ5pbR0kHJH5M2?=
 =?us-ascii?Q?exOKvWjRzCnyyvNuKvk2Eyo4QcBPZWC4T+7CLVSOsgKmfmOE6HUf8QPHmlxV?=
 =?us-ascii?Q?45aY0v5ynw9D3qQAJxr8yGaaAMi455JJrZ37wgnUypzXNKu7/avbOhdtj0Kt?=
 =?us-ascii?Q?gi3EpazDZ69wSqlcAAkskuquGpXlm+B64ca6YG3U/OcmlOS4hZPJpMw4vUx1?=
 =?us-ascii?Q?IeHbLrwlLvCulDRH/2K34mhpH/u0uRWXbYeg9dyAG7JLj4iGHkmqGIO/iXtU?=
 =?us-ascii?Q?zkmrr61Zey06j5myLQKYJ5Ww2/Yi7pbVUfvR+8+WpHGSykLQ0d9+JbVsmLos?=
 =?us-ascii?Q?nYrP4PRu3OG95UGdP2vgv4XUnpPV5RXM2zrLPwwsElJJrDGww4i8jpZ+2V/g?=
 =?us-ascii?Q?Ct/OAX+0SG1p0cYJslOMVC03IhN01W47Q2mbalVKN4TsQrbta+6o/cqtMmG9?=
 =?us-ascii?Q?BypcpvZRFXuBNCZ2V8xfbaKES9Jc9rTUte9Qy+u9caVkgpeSvqJEJ74hsUsP?=
 =?us-ascii?Q?DyyZNzhRcLfuIXg9coW0f4MJSqA+olk24+7n+QTVfGIilhF0FENDyW4UYgkV?=
 =?us-ascii?Q?orzkfaydAOPiCEvjjaYbpxtNHMjVPwgudYxLVnf9ZmaG2DKgruhpUlSvWGBb?=
 =?us-ascii?Q?7YlLCeP8cHRIPiOKPBEj1Toqkp4duAf79VzsfM9cn3eJpS1GbJe6yVEEu0XF?=
 =?us-ascii?Q?3NL7hMvcqYiOxnjzXpVCJ5xEYzDt6GUI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:23.0978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af58423-fb45-4038-67ad-08dcb067efd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Include display_mode_vba_314 and display_rq_dlg_calc_314 to the dml
Makefile.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 0f7f1941aa54..887c4bf6f58e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -115,6 +115,8 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcfla
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
-- 
2.37.3

