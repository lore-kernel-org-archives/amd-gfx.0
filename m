Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB3E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE3010EB0E;
	Tue,  7 Jan 2025 15:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XedNpT4I";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D5810EB11
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv1dlhnrtnkYM4HOC5Gkhjww4mH98TBbr+aioA7Lm6Eu2mBzBeVWq4cm/o3xID/I6iUcZJaVQO7iEEizDgyuRHTBJ8Mdtcgiu0bA3YmBlnxNWGyUTn38RCsVdnFF3Ncf4vg9h/qENhuMLhVUisgihm+TQ54nK/rpa1qVX6D1LAto2RsRtKcLleNiOUlCMnvfzEvZMLSQ6oCq6XswSG9DPdGz3rTlj6Z5euivS9KIcucnnVNSBCpKZYcijmJ6eqGiAcWAMC2JXlp6lIBmqGwaftNptC26Q0XgzAFgm/Ky6ulAPHDp3CEcHL5AhIkt9lEW6FdlXXJWWCdqji3JNNUfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Pc59QzQ9U0ng0/juZDoftEpexVGkMi0BJ33NoECrmM=;
 b=eWGobBINUzs2rVp+Qe+qrmXTJyCWTTXvv9pItXf3t22tVhSBCXC+qJI/UisT4T3pRAhNcUtEx9ccgRo5kRMkSLnP2ep7KyGEOBRyB4lU0i50r3fFGKpQiKYOEO5bhAfL6LDzPRYKuwbh4Oh/pPPvt3qHI2PNxbdCjd3/6NwHzckZMlQz3UpqeMJCloLZYK4gs9UQL2bBDW8Z7Eg3LNpzAO19t2DgfFWM5XnrRnbmi/fhcMnkFh/wentt2uenver0DxqxhIVkbn0+WT3njKR/6uLSosmgasOZ4w0vbmR1zaviPt8BcmaVepvQ73ATe+ZotZyQZJMYTXlxt6+1++BEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pc59QzQ9U0ng0/juZDoftEpexVGkMi0BJ33NoECrmM=;
 b=XedNpT4IRui1MuVEgfBZwOP0FSADb/ooHSjLHi5iAGyEyL8Kz/UtLIj93UrQXJOAfUhrIUsAPlxOmK7D/XPhKKpg21hKDMTCXS7LnhorNZp3I1XyrLqR+CAaDhXhQ+RBT8xexOur+vEYDzA0IsP0H7EGRQM5Y2KobxzNjROvrWg=
Received: from BN0PR04CA0178.namprd04.prod.outlook.com (2603:10b6:408:eb::33)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:33 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::cc) by BN0PR04CA0178.outlook.office365.com
 (2603:10b6:408:eb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:32 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:29 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Robin Chen
 <robin.chen@amd.com>, Allen Li <allen.li@amd.com>
Subject: [PATCH 18/24] drm/amd/display: Add a new flag for replay low hz
Date: Tue, 7 Jan 2025 23:28:49 +0800
Message-ID: <20250107152855.2953302-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f5c7f8-d9de-4c25-a07b-08dd2f303a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sIS7DDaB5kIBlTmBuW6NWVgORHxkn898xmx5q3GkUvVPxkHATcV+ey2vrzkV?=
 =?us-ascii?Q?8V1QkcEpI15Lu+P11mA345f1vsoixwqERX9K6T12rMyXh3ufEKNVvYPIJCZg?=
 =?us-ascii?Q?TkqtMA+a5wfhO+hZolZbhPbxdehyUD3yl3sB5iWXJAORPbg6r4uSDJecWi9V?=
 =?us-ascii?Q?yGxNd8OaStSsmsCdyD+SBbCVxtCvlRaBhf707cf3GyjWZUS3x2k2y5edPDRQ?=
 =?us-ascii?Q?IZXRwyX6ylN1fNrqaTooRr3GpCPkPcqvyV887tyyopvSVpNWLI8JhNOnt6rI?=
 =?us-ascii?Q?CK0ulqty4KKtV2RLVRHVwwaSB6Lc7u68+Nr3GxAok0R/PN7B/+18W1nEtfDE?=
 =?us-ascii?Q?a0pBcEcwVnsK1mz+mlffsm2/2Nr6DRtgkuM/8yO17/LbW0iXkJaiCfDo8p16?=
 =?us-ascii?Q?Bq4Mvq78d/ezkQyd5uhNWYMxIX5lBXuEstkVAAukpwWlrtspFK027jyU0l2L?=
 =?us-ascii?Q?C15tOazex/VHGurjq5ocgfg+mDQck1wbVl0sqnC3FFsthhQD4nInZOz2/IOm?=
 =?us-ascii?Q?e6vx3u8Orq6KVNGxHziXpzxvbVbBu1tLh26o1LRUAyJLdQPp2CFUkPy1gmLi?=
 =?us-ascii?Q?PQrgcKkIE0phnfuKM76HhZfKcxg9SmCs4uYbjPHicU5gRBViLAE8mxG/yxu+?=
 =?us-ascii?Q?OrvNNKShCDe+9Jt7MteQf/6Ziy2qTqLbfdBvfx8GZn35NyFSmGD7Ujx9qJB+?=
 =?us-ascii?Q?rp5+dfRs1Q6pirfCgUPNonY6sUh8406G1foTWjsNBlZgvAqJjbrc/aqIYvJM?=
 =?us-ascii?Q?BkigUyw/We5PxQ6y9Zaz4ht1isyJlyQNjDHQfcki1QR5HvEoGQoI2f+1qoiz?=
 =?us-ascii?Q?U8AQokhswR4udu2Tf7fo1VxAzynD9VaoNeIXwwR+CMYwHCX8vAz4q3ucTYLo?=
 =?us-ascii?Q?oN52h26YCcBO3Al28+AJRsMN4YYQ51oRKH/BoN564v5+PqfnqrARphPXkv03?=
 =?us-ascii?Q?AL7+2ACTnHOzmYmlkscimB8Mj+fZjR/PP4SFFC0KVMjCp4wEudtSpiaFdhPf?=
 =?us-ascii?Q?k7hJ/n4ThEkGS45ZJdgG1YphFunYLGQQDHYTmRdb2pTTBPWetw2bmaQ/HgTY?=
 =?us-ascii?Q?yVeVZ6HMN3L/3/K+prCe5wD9Wa7qNRrXWH+RC49gCPFC07P4q2eba0qeVmKo?=
 =?us-ascii?Q?wAj4AYFj4DEsXhcK9EmY6usejpxf1ysi587ZOjrC/EEl28MDVQti9w8xWfq9?=
 =?us-ascii?Q?yV4H+eSz7VvZFkWwdKLG+BxatzgWjsDFJXo0mhQ5qQR8cpHY9evvWr3Po3WE?=
 =?us-ascii?Q?Bo25eHK98139cYRRFwvLd+g5IkqXK6xP6qseKnuQyQM+O9dEHoPL1qTB2l96?=
 =?us-ascii?Q?3H/te4+3ukq3KMyPn9hFTIHiRGgx4u1GvZiaKODiMqADVAaEuWeSVrlS2EE7?=
 =?us-ascii?Q?elBA1UhZNW+Iqcm/R39+AK671ATRsXCGIIHaZBpluh/EUkhASV8od617T/Ee?=
 =?us-ascii?Q?A7UJ/g+sUNr5EY7lGw92Jyr9qU+roPjs7tA+g198q45qQF8sgK04UMQAXyeN?=
 =?us-ascii?Q?KMdjz+jGZ6lxR+Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:33.4302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f5c7f8-d9de-4c25-a07b-08dd2f303a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

From: Robin Chen <robin.chen@amd.com>

[Why & How]
Add a new flag in replay_config to indicate the replay
low hz status.

Reviewed-by: Allen Li <allen.li@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0aef2d84c3a4..d7242dd83def 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1119,6 +1119,8 @@ struct replay_config {
 	union replay_error_status replay_error_status;
 	/* Replay Low Hz enable Options */
 	union replay_low_refresh_rate_enable_options low_rr_enable_options;
+	/* Replay coasting vtotal is within low refresh rate range. */
+	bool low_rr_activated;
 };
 
 /* Replay feature flags*/
-- 
2.34.1

