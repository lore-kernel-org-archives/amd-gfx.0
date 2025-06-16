Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0FEC71135
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9328310E269;
	Mon, 16 Jun 2025 03:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uEi3eezc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1782710E269
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKF9r05nmBqivs+wcJnofyfuu9mNeDxpqlsejq1OT1sUMuc7q1IXHe3m4aCd+icPrVdnVZO/YpZkmF90nUd+tN91iCY9N38CNssJoSK9tGeL6isbiAyHDNoKC+RT3Ud2F/H569191mV5vRPeoNj708rqNUN3e8YYoED7VHDeEJ1ttYy/RznSGbe/e2Sj1Uveh3F53Vwy+Vh5CisOOzzqdO9YMjxmnxVUmQeWXcxOV1MTQJYgxvQ3lgGIflB3hB94hYCDi8zx6oBL0yHWR7gqT7MJIDg5dfMmh0llRsGijDFpxevSHN+96fXNCVmsfUbwp7Ny1VmgXWFn1GOag1lVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=B7/JlZiDQGDe18RYoLA1neyzItHMDt0Rs11b6gE2L3UgWycJUe108UEugvU6XDklBM7PWxwFyB2ngP3Wkee7nWjcNXlNdR5dT3XaAVdPvMa8xJ+AsJoBfuHmt7wQV7T2j4PZJ3sqMoeae5+GimNeUEgDl9Nw1/n7vqfsSr59EhZ0QJfgEriraA3KFN2EPH8CKwUA6Ba8slNR5+pnNRs+88EdJQ2qb66SwKX/2layHW3f83X2+tm5IIyHvJzXgwwMY3D5s6UlQphrZc8v9r34c9RFCQAQVfnFWVTImlK5nZ8lCcrkbXSV9TmW6RV7F6eISS8gDHbxA7JR0NfgdQPhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=uEi3eezcG/+jL3zI2q9CreBrQMuu0+6yX73J7ktE1xup+t22EKS/B/iMXyVD1uNLUh3CNFVSAtVBAR2pIKfZGgCI72pmrdGqU82oRsm9BdqcrgBU/v5lAMfUCR7/zdsN1IBpTZzA7kaPj1EWS0T0R9ebV3NGIfCk4Qvd3IM/JPs=
Received: from MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::13)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Mon, 16 Jun
 2025 03:46:14 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::82) by MN0P222CA0003.outlook.office365.com
 (2603:10b6:208:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 03:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 03:46:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Jun
 2025 22:46:12 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 15 Jun 2025 22:46:06 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v2 1/9] drm/amdgpu: add user queue reset source
Date: Mon, 16 Jun 2025 11:43:34 +0800
Message-ID: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd6ca36-d170-42b4-7217-08ddac885757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L8OTnWN5cJMHBu5M/HQE2ud/WWWJxx2a80pZojeFFz3C8Fzr6kI0a4uFQxT8?=
 =?us-ascii?Q?c1AUIjHnV28EnqcJghEPgWLezlcY702d+4l+JBUL+JVHb9rOtaFX4wlewV83?=
 =?us-ascii?Q?VZ8Lm0QsnzDQEnGjrTZYNxVAFRonUIHh7bgb4uA/JbPnBGXfoLm3AfUlFdFy?=
 =?us-ascii?Q?eRhLyo/3nEK/edA20ZxUb/Kxub0bOXUY8YdkTZ4MYg7yVs5iYMKHsyn5ahVX?=
 =?us-ascii?Q?P5BXRFzOYp5ADwOXAP4lxX8+oXnhKnxO1jLnF2fONGirY2hrFwhyolDvO+IW?=
 =?us-ascii?Q?pCDr5Moy/jB+OpJqWvRiEzaRLlBicNeRZBsCVOtM2IMPPo+zaAQcfYjkgR7z?=
 =?us-ascii?Q?e6ySGNKMTxWYwPAUpAdd/eclymFcW18vfMcVHrheJ9mTT6zkxGRDGvFhcRS1?=
 =?us-ascii?Q?3TQ6l1dt6XNQHQLePSJkRZ68CcY2hSOwp0RUdSJ+jZxQHWRCiLJN1Urn2XSj?=
 =?us-ascii?Q?QhC5dGcO07N5uEM4CXe24k+wQp7h1JIZhe66hJLhgqFzXhkuEluG4ZCtsngp?=
 =?us-ascii?Q?toOcTKr4FAj7uVNftZwtrycAjBWtDgxv9vLKmXOXONhQpMDqH9VsDRhj/YCJ?=
 =?us-ascii?Q?WMsbqU9LvEbyCsY2VsI/xiA0pjy2v0c7zBZKshYTphE39yuvHeOS7p5MIalC?=
 =?us-ascii?Q?0hgvYdEJGe7lBAVwfRr4C6VCEtvzKuHUmY6144UILGSfWvQ9yEs92ctUdGQo?=
 =?us-ascii?Q?QHVFZWHLBo3iwNQbZCtjabFyStb7VWcdkvbHe4EzSoZBfcI7SESad9Zx5zBp?=
 =?us-ascii?Q?KzVYQdnGNHXe0PkGPD6EpgbI00WDr5l7mDjVwxk4DI/HS9ILOeX3sd+aralt?=
 =?us-ascii?Q?bQHEnhX8C1bb8YEbXLlwnrf5CghZcgwzdUo3pXGcOl931hO9FsK4Blo8O0e6?=
 =?us-ascii?Q?QSy1Hfe2P0vuahYWrzQ7DhjruYkhSwwcIEugov9mPHtZLjyjI8pzSsPcKg13?=
 =?us-ascii?Q?y7K5Bbf4WND1LBhZP7mSJayYuvZFOEi3st7+eC6rFvgfDysDGY6N0rQDkvyz?=
 =?us-ascii?Q?nH+KkKCDC6lPIYfgnnkAmhZb6NJptGjOyigGILyAeh2r7GMLWYlJfZVKGFIi?=
 =?us-ascii?Q?tqK9G9A+9WxXaULEYgWqozbUy0j1bHy2cTUxCzbPNDrfrPN8bo8jVdi+ICV5?=
 =?us-ascii?Q?Np0z127O/OD4cftHwg7eT1WtJEJqbR58KAZlZik7wgceKYV9qGwWS3apQ84O?=
 =?us-ascii?Q?Qa+VWLZdavh9IMpIm4H7n1Fazn9siQb5B8r/hvi+dnjSL1A7RunKdyOA1R6T?=
 =?us-ascii?Q?Eww+0dqRACMf0VU3BoK7YBF3VQE2i6zAczsZcDlsOIIQQZTSz+lbiaLpk5Rq?=
 =?us-ascii?Q?4T8y73Un8COzIZeleA5LPSfa5NWNH+kp5sxi+ngHwsHCihxHTJdlQdBfYYva?=
 =?us-ascii?Q?1QVXim+NdAmjQ3tDFI1dLOPfDhG0CMCkGxCoSrXTmsNT63Bj5JutMf4FjH7P?=
 =?us-ascii?Q?MwusE6a8c6XoRbGpd0OohiGhcrTJYcLRhcQvQg0yYR1Rl9VGbSTWLMsiq60G?=
 =?us-ascii?Q?RONhXLPgabzy/49aHW8kxdT6g/SwjrY8A2xP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:13.6904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd6ca36-d170-42b4-7217-08ddac885757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

