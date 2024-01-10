Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04E9C47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3BE10E7B6;
	Wed, 10 Jan 2024 21:57:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6006710E7B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwbVDT328gn93dyrvAsJqtBpPtbZtEERaScN9aWdGviFzYupZMG9gWERsmyPtKgPwTRkvkpIt75vQWY78rh66+pQKpkZvzVfacgzA5EuzzdjVSEKo1Ky5ypMFXWA2STF1V1HnQ3/4JStCiDrjwJ2O+5mjFWH+jJgC32p/quA5KobhhGMruEKusl1eAFo/8yVTnQm9fjcQ6lZZlRiaP00b6ypuOsOjsTcU1fyUU9IEeNAA/lAbU57logR1lYo+nx53ZhzYSUqV5LjzH6LrVL6qS5yWugxVB/6BlXVPe60yqJbjwpAliyMQ93/1LJeyHCoSV+XiIa2/7enL+XUTVm2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPOpn3uoasSJ+OwVJhK0HTJjQuEWDHDHQKkikG2PwDM=;
 b=JN2tKwt3qqaHpsh2TqL7/o+M/qW2APIPDv3o1ubROTtuMqLEHCCRsZnxTDrZsmnCo3P6uxUrsFKIetsqolZusFSxyyqRiOIkIwOxrj3JGtW1bymR4ASTL4amVZtNMfPy6GU79ZIB+ZvsQWm/TF5cfXdRzlwXbzEFvmTQY1Sb3aiNvdcPWqdDvuleWT00AMtLdHsez0EA69pvOd8w+25tUyyg6SLgbTkEn/W9s6EI3scJE9gXBG+o6S7m2KdmI1eLb1oxJw4Frn92VjxgMtnovnWRqSp9NY2+dvMYOLgEs7VWjHn/t7qJo38+EmqF2I4DyA3yj3sSpiEE3Thv7GNs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPOpn3uoasSJ+OwVJhK0HTJjQuEWDHDHQKkikG2PwDM=;
 b=nGAiYWRhY9eSFW3cunWHnlwJA6qdFqyIMxHnDQzwxCcafaSoZY7ai4sRvTN7vQ4o7MfAPzTUdlEvGFT/r5h8nTHx0cPOXzQb1TdnElP1dhhnZhBZ4Zg8+5kCa0/LjQEPk3JTTaLNzTbirqPfEl7t5PIZe1yoFSD5XHu0tnQkAUE=
Received: from CH5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610:1f0::14)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:57:46 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::10) by CH5PR05CA0022.outlook.office365.com
 (2603:10b6:610:1f0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.12 via Frontend
 Transport; Wed, 10 Jan 2024 21:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:57:45 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:57:43 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: Set default Z8 minimum residency for
 DCN35
Date: Wed, 10 Jan 2024 14:52:59 -0700
Message-ID: <20240110215302.2116049-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d189c7-bcb3-4f34-adf6-08dc12272d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dempGwU/5Z8g9CrOh/OZZOg5+225s+w4D7EPwlUFkHQLcChFO+dIBzFdWpwme55uA7g2R3GfCRS7Z/BmKThVoelcfrzYbqqTZC2Dh1OXmAKxMPKNdjc4JB6Be0kbambfQJB442SHYsZcBJdc0JXUSsswwLE6roDbJCNqUyM2vBV5YcgFEZx2LE7EaQdkHtyETW5kfnIPTJba+fj9lepergNxGv22C2hzHD5jspwcGbi2EuRW84bqsBNgorUl71V6Qk6/Scq9h+RNDGfuBqzWP+ojOeZ0klYXk37J/yf2ptwSI2dzSIZ+UQTT0XIP1mzR7yMath04SyeowB7VDj5iMHrP0C3XhS9NqW/RZSXBKWGNYd/HLnGvldX9MFj0TN7vuRfQgnNF6MEHx4m5IFKJM9lIhNf1Sn7Y91RrDDiXgGv/KD5ynCjz8DEouxQByTLWFdvVBKBlwM3Sht2dXzSSAUQQD7PBwvrXe0dacmuqCbAkrVqgMhsmYblwtYxQWpGifkKukRgINmWytp5LmIVg0FnetuYovvNUZOipNQfokcuH0N0hmdoHO0Sq9lpPBCI3tuK1EK1x99ZevpRyW8/eRkMX1/FgK7ZcE2sYSwg02vAymb6YL7I8byEp0R2OiW3KTyDT4EjmQHRj7fTCmt7PnXAR8ZL6eaXVgbqChRKLGomjkGCCEMnwZcNQ7ZpbEoZCP/vf9tGVuE5fThKpOkppnKj98Dw2WNXnpLYi18Zwxtmi6d83bTgsm/LYZOtIFRrYLB6/VtEgTZWg09WVcahsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(6916009)(40460700003)(70206006)(5660300002)(44832011)(2906002)(316002)(7696005)(8676002)(8936002)(70586007)(54906003)(4326008)(47076005)(41300700001)(6666004)(356005)(81166007)(1076003)(2616005)(16526019)(426003)(36756003)(336012)(86362001)(82740400003)(26005)(478600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:57:45.6467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d189c7-bcb3-4f34-adf6-08dc12272d90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Gabe Teeger <gabe.teeger@amd.com>,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Match DCN314's policy.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 7d8e957d6a19..5f7cf01abef9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -764,6 +764,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
+	.minimum_z8_residency_time = 2100,
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
-- 
2.34.1

