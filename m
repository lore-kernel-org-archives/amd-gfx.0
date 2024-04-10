Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B184CD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEFE10EA61;
	Wed, 10 Apr 2024 21:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ktG1ZlwT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD1B10EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdYzVbFqvgyv8h+asi2pYoN9068KeuFyzEdmP8ehk3aiFlwRWu79r5xt+oMKiihuh+Jc6xShJsimbHa7MfcUFKPRavvYtgWUvsS5bUluEPOLp4/2Lr7xLhMjl0oMdIRTh7k1e3qUk+cFtKIwqEp6Fr+lSThirBMww9n2eE6nV25l1lthej88/Ugt67l9JSSoT3g23M/xp+BS5qqFIW5B0Jg3saRJ/tqkH0oTwvVvOjIrip9nBi7bAizb4rs0R/poDqKWp/+05wlzK1uJxY7ueH/bcuobRlVVnbxZa9NAw9OrbtmbuAArffnWsklXAr4D70/GpUJRyCsSZn+RJeedmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETtZbLHKowvE+tLL+8rQ2MnrrP60q5lXwhvMgwydqYI=;
 b=dBbe+Inz8m9Lr8TxeClZqeYCnrFoWfrxv/X93mGWkpFkgf9rRo7vbhtzZ8HM7oagEkNIQqozkpQ6aAPBiUeOjH9pxz1ZVzGnvtNXM9gkFJS8zUCWCo1b/Br+btdn0CD+A1kqKLYha9Dz6QulBYEfEQewTxlSJcVFFkbbUyFq2WYkxB4BKybK8iEIiUH0UTNXYjoM+UWMxKGyjWsK94dFuwX83kRznelc5HwSp9IFdUvlYv/o3oJKM0DJ4VRX8J+p/q3062mIxqyC059FIK3qBu1Gvf6FxDZdQyOmugGWSo0Hwedzyou0TcYlyCfSCzfQFDg9TQYtR9gm/e5FvGDuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETtZbLHKowvE+tLL+8rQ2MnrrP60q5lXwhvMgwydqYI=;
 b=ktG1ZlwTDn1BOAiiikb1kAuZescXJ7AZgWKVga7SHOGIl0S//iiZFKuZbkvx3HKlBuGn2EtOhye0yDRZgXu1eNrhfKA49pyYIqx8Ph2nfw2jDRN0R1zoi5NkR4Igxku6hZ3X5Ybh+sGfaFDLDnyBC1pNysDzADtcyxZIcHWpyD0=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:27:55 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::2f) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 21:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:27:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 02/25] drm/amd/display: Add a function for checking tmds mode
Date: Wed, 10 Apr 2024 15:25:51 -0600
Message-ID: <20240410212726.1312989-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1db539-d985-4d9c-7a05-08dc59a515da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv+um2iUZ2QZ5CKgmFm+uaXoslQL/SwMAX+hmFd+u9mTz06QQ8Uzc4Vuz3sqaaUDMM6DqRUcKo6Lpm8zZfKl3POtTgHJdNRLNGKcrdKh/1YrBr5AckDhtU1qlNQXvxmn/GjWrYNG9qCraT8IDmi65r4O26B96yGSVMSnUMsfzGRfeg6fHk6lwK27MrJqwT63vQA8WUjfAziobs7Vz29a6EBDNMDewubuT52YLf/ANV1vccguYyu0O7W2NF6hTfNkDQJWR5FcbJYesrCm81kspvsRRw6SKTQ94cZsV7mEKosKSjwqDav6FXmYFc70rvSWVgGbfVQYGVpBgiCr9zZGTyUXQa7rDi5/lGvc0Fah11Bt+iXzA09yBubPFLgMnWjANiOJD93lKIHGsqDzo/7dXWwbUpjS2KZnfJY05lUoUjVPTAZqvKb6bicy09OkCIBYJBC71BG5OSKul5RYCpaJUHoApMhA/JfoakRRlPLPhjLe9DFqJdslUL4+b3G2nCE8IjdXEXb7Io8UUgZw0aS68guCq8kc0blyB2eHHPFqKdkGbPH+H15zUNy08uPV1gsXQlWytod2yJtKZUvunS/JCo9Uh2NSTWTen8qx/xcRzxpyAQdwmSYoIcuTIMuwO9MdTVd7LOvw3Ha48yRYV1y9ZFJY7+wDAYA3MMLLrxkmrWcI3SklpLTKn0kF74oIzWsl1xjVR6FNdA8MAhMYFbNEkFSsfP/sgyaKOGFZVC6vxurVLftlIYTB4tDbBop4WHnM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:27:54.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1db539-d985-4d9c-7a05-08dc59a515da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

From: Chris Park <chris.park@amd.com>

[Why]
DVI is TMDS signal like HDMI but without audio.  Current signal check
does not correctly reflect DVI clock programming.

[How]
Define a new signal check for TMDS that includes DVI to HDMI TMDS
programming.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/include/signal_types.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index 1b14b17a79c7..a10d6b988aab 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -118,6 +118,19 @@ static inline bool dc_is_dvi_signal(enum signal_type signal)
 	}
 }
 
+static inline bool dc_is_tmds_signal(enum signal_type signal)
+{
+	switch (signal) {
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		return true;
+	break;
+	default:
+		return false;
+	}
+}
+
 static inline bool dc_is_dvi_single_link_signal(enum signal_type signal)
 {
 	return (signal == SIGNAL_TYPE_DVI_SINGLE_LINK);
-- 
2.43.0

