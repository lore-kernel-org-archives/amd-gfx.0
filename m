Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446B7C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D499C10EF01;
	Thu, 28 Mar 2024 03:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02aBf0OV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C38C10EF01
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw84ELO9PHEAJYMDwBvglJUtyhaACZNXUZOhn4phTD0NFPscFquIuQIOcQ0Dnkk7PywTx8OhX75N6AL+bauOetUgffs+ehdmf0uWBWpTgNyaDW9UHt7SkCPnwDL4t3PmBLhmoq0LRs4BacM6G8L3af5/6qHxTHCVDY56TL5qhyNomvu/VX42HgyFoMnr5Bb5rb8c+Hwl20mO5/YQ3U1YHLQUBsSfdUcxvOFmkcezWgNnDuTfDFvKGisUuX9n6ZTChzQ2uMfK+FdtfGauiA6qalqYkAYxRgA+hc7B1R4EsBN7mgA0yVv+Qv1ZVU92Ze0+MA1xSIbuXGHz/uqw+SQahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj8zXnzFNGIvumXU1oJP2Tvn7LW3BtONsKKr8sIY+vg=;
 b=eb4FVSTWKegL/jliZqytlC381WEwIPUyQqEoOc6JimKATTmceXbejNbWkWrQyWw6TTPBivocy/n+Lt6HnE5wxlCD/gWXCjLJt6DMu4O5SFvM6A0x5w8XXWcz6yLW5LQCt3uo5aBCqEdbiAXfadj00OfofS4ryvLsDWOQSshVDqPBuMJU+7fqSxnOa9RFm9oKAYP1F6VTV6/BSHvOHaQRA5UlaL+6wfxUuMcD3tRT8Pof2UxfoshyzC2Q2Nsv+TJdt9fcMxC2dK7Mq72iv7k5vfbNvtnrJT37NHYZG1FnNr8B+INpruRA3F7wssdbmfGceeK/j+QLfWFFbJ6EryHo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj8zXnzFNGIvumXU1oJP2Tvn7LW3BtONsKKr8sIY+vg=;
 b=02aBf0OVjadRjwQuGQ+4ennwbiBRsLkL7vzcDcrE4H5jEel3iMG/tqemPMJl5PhO7nxHb57AasStD3TFbgn74KHP5cqL9tv5/5QJVs9Z3HNRhNECLei554XEDIk/RzWcuy3VpCSuUZVbFTCdnOjfFcN3RTNUrMU0ICP/8PwReyw=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:23:06 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::f7) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 03:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 03:23:05 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 22:23:02 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hamza.mahfooz@amd.com>,
 <roman.li@amd.com>
CC: <alexander.deucher@amd.com>, <yifan1.zhang@amd.com>, Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amd/display: add DCN 351 version for microcode load
Date: Thu, 28 Mar 2024 11:22:34 +0800
Message-ID: <20240328032234.3466383-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 1798387b-0108-43b8-7ec4-08dc4ed66223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmAAAXbgEdfdmbWDwO7VzdG2GlLq6wfE1xVsMi9zNAQEA1tfRBiTcj4Jli8jKXBXUQFadU32moAypJhn09E59s72pJ/VlU+2JXKCo7H0MPIU+1kIHKZdj9frRTUU77sK8MjwQZSFK+3zWRDHdR3SnXnPGBLHitTAPD1Q6xRz8XWBoHZOYYyDefqEbxI/omWdehz61gcoDTuW8RmGmn+KjfnksKoZ9Gh7S6rEoMA6SsO2lPU8+vIOBH5a4arS6p0nUa46ZHPGQ0wkCb4j2xjDOHOP0c4bWh8XHSAqRRdalYGjbUmRcQEw2BejQDjbWRayud3o0yfo9O2ongYzG/oR4jj3ObgDYczdt+/j0aAPwm8D9sAAVimniv3Xa6+L4OdgL5HTuJXkPg71ibrHTwKipbhGUQgeSmadjtVmKtU+w0pt0u+74EzssK+P4mJrcNXxIYLOnJ2Hz77H4Tn1eSy5wn3aldqii7lteEdaq6qriaNzrszuCd9e8acMOU1BMnCqq5ueNLvoxbk8ZKFo4gIDJv1foUZJe2bykwgbA16iQ4Nd32hzS7rurKldArMJGlW4tfVDYyBhzh8DfJTxXIqV5ggde3sY5L/2xxETzZmYo9lIF/4NNRJTv/+jucmhifCvO3KUop4WOp7j2pdh7enI2ZXfjzxaOyehmueAK09+4VIRHeQQctIDljDsS4W2hRlqKrR4YMeu9VcbRQCBef1WbBY0P6PZIU7IxjDHtW5OVK530vWacJnfUJdj1uS1XMst
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:23:05.4822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1798387b-0108-43b8-7ec4-08dc4ed66223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

There is a new DCN veriosn 3.5.1 need to load

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ef546932f6c9..d98632f37c0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -148,6 +148,9 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 #define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
 
+#define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
+
 /* Number of bytes in PSP header for firmware. */
 #define PSP_HEADER_BYTES 0x100
 
@@ -4820,9 +4823,11 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 		fw_name_dmub = FIRMWARE_DCN_V3_2_1_DMCUB;
 		break;
 	case IP_VERSION(3, 5, 0):
-	case IP_VERSION(3, 5, 1):
 		fw_name_dmub = FIRMWARE_DCN_35_DMUB;
 		break;
+	case IP_VERSION(3, 5, 1):
+		fw_name_dmub = FIRMWARE_DCN_351_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
-- 
2.25.1

