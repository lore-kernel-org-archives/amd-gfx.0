Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF23C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EA2112F27;
	Tue, 30 Apr 2024 20:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iDd5xAFl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB939112F2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTLmEp0J9YTAFWU6wdvJN9rU0gKtzMGx9k4nJhWkd5GEQSBSgSys2YCKQFgeTYdzrfn5FsFedGi3mfmhhjiz1QNeM/Zznv16uurBzTmwzK+j4QBFXFb6K2EmVOlKbgolUn3hZLin6TUSKR1pUhkQI0PmugG9ZTVio7xos2G0mTHXrxgz4VuvWSekU2zdcKpMAnk7xMcn55WL6j0N1Qu1O3G+wjbOVYMWOw2TQ9P48Q9HsDq4KlAu6NItvvRLBmQDuSFCez/BiLIBlTsOClzqcuBqFY6DjcWccLE8q1IT5b813lfrAzWzKNp7B8LMbyJuhEE60y7JspQWdTm2vgjejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaKY5eCgQSsiRI3ZAQ7lSLoBqifg9Ph5Zine1cLyblA=;
 b=OdtqPEZUMv1wMMI2naCWh7xtBB/euZUhXOpmybVrjjtTDghMLbF/PRYIi8JotIXHmFZgZASEpdXH6MqFR5h4pvZDK1PZldS8KG2WPYdXz2wbVnXj+R9I6IWFWfQgw8pzQZJckhpRRVCveTssAsJlHzvFfvc55xWyiiHVLL0GlCXc4ij8tmrrL/XtInG5hCyKAw9/ECEe7sBqmadfIy5ntCaChyu7zSF/lwmsXYkjWdEpUeFeGaLOcAyL7e0i2+UrttY4aC0LackKL48lCYjMCjeUZ1i3Nu7py4+R06fmIR6WJjJX6KhGsxqFrl8Zr+kQQZwATw/0wVHSd0A9uHwKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaKY5eCgQSsiRI3ZAQ7lSLoBqifg9Ph5Zine1cLyblA=;
 b=iDd5xAFlsM5SoNykMuaP/SQQZAGgOCqvoDwQlVVra0XfxLtL6ucDVOq6qAzlTy0NCRJXULJr/PCGNLq5uUv56FY6KzFKcKp/bbbVUgOgmFiP0yhYGiCJW2V/fg5rr8sjOozdIGQx81IDoAgwGyLOiG/mALY2GQmIBbqCymK6Zr8=
Received: from BN9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::18)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:34:33 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::dd) by BN9P221CA0016.outlook.office365.com
 (2603:10b6:408:10a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Jack Gui <Jack.Gui@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amd/amdgpu: enable gfxoff on gc 12.0.1
Date: Tue, 30 Apr 2024 16:34:05 -0400
Message-ID: <20240430203405.798798-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203405.798798-1-alexander.deucher@amd.com>
References: <20240430203405.798798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: d001b961-29eb-4917-d209-08dc6954f1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YC9eH1lhZEfndPTmCE3E40iU4aRdDGKe/EewSAmOAcOy7ifNgQOOc7RCMsHv?=
 =?us-ascii?Q?5Cw3MlBaqsCkLfPYkCqUBAWteyA5UuoacYaaW3ObnCXul9Qz1ie8Ipfm40gf?=
 =?us-ascii?Q?Uq03YPLfQQQIAeGMkyhHzaZvJgXDcmUarx30WI758qS6cDr0Jm69q7t8IFAn?=
 =?us-ascii?Q?nMlWa2AlOfDjbHANk+FwQ917V0xzh2jAW1pK+E/ycsvEVQ1MCZBoj2fY1Jni?=
 =?us-ascii?Q?BqlgONwsx36a8BLtUv6s7JaoKNIpTHYYr4996QNOjKAuRS7GxL8Z0GpU1GB3?=
 =?us-ascii?Q?ER3rMNY0vmYK0Yltci9iASLdxqlV4wRidZTKFO5vfqYSZkgULmprknivciXl?=
 =?us-ascii?Q?Aj7j5+HkP0ANWPESRG3VCe8PeGM95JTb90ouYTDPN6RQKK0bkazmrYRd6mP2?=
 =?us-ascii?Q?wA/MUJQc9iUHk+xRDHx32zanc6GMUVdmRnQZ1Z3CuhpSF46STxbTkUaU48Sj?=
 =?us-ascii?Q?Tcx3oOg5i9f3i3bOTStI4igxW6GR2x+2MIINB386FvqvAbN74ThV/uR25+Ki?=
 =?us-ascii?Q?M2xa6CDbx6u1qEQkCsWHam9VU68rxSVK6Y6Hz1NFjUZfNcyTGRtvjLRFPgHn?=
 =?us-ascii?Q?7YVYpOD8y7fRd6OBdWXVH4jYyJ8IRxayH/5Jl4xpkL7YtAi+Ae2kJQ6RZtEn?=
 =?us-ascii?Q?Nupeb/sIsbcHWOsx4irdhxH9EiVLUf5ZWuDsSCeectzVWYOF6rdnh87Phz6o?=
 =?us-ascii?Q?ROTrwPb9MQKKAT/ljC0GxvZ9KeW/ZFyTebihFvopBqMYTVajCO5lzdB4bkv3?=
 =?us-ascii?Q?YuMjtNCeso3992XZH1uu7maJQbYAo3v5RDc7lf3zHM+tXALJh8VzvjrXM5XY?=
 =?us-ascii?Q?4Tib+mwFZcUEH31XqMe+6CisSzRNjPHzoD5/WRNDdFD3I17nlEiIgyET2hx7?=
 =?us-ascii?Q?hO/4ggleS3l47AXCv+mxUHxnHZFOepebYnSiorSgHO5jUWAfKTZ9h6uUoFf7?=
 =?us-ascii?Q?lRRzaTpoD8XVqA6Uof6fP5FaCnKXgST9PAE995/Jpn5h9NUfEy9Yo82luXQg?=
 =?us-ascii?Q?/JKv3S8mA3oCqRXfKyGxK+I1bZqrq++M7W1NGniZUF4CSZkyStCTiXxpRK+e?=
 =?us-ascii?Q?urYqz9AsmbCD6g9ZLpfMug/xFZ1ep8HZX77kb0UwYqHswIlUg+CJVgEw1ibR?=
 =?us-ascii?Q?CGuX1ezekTporj+LtHWyrshDFMhCpYLF79hWOqb33YorYPkFhARVCnagVfWN?=
 =?us-ascii?Q?DECw8RQNrWmzISvOOE5SgcfkJgMaENuH5dnOlSjZM/ihX125sIGGE0ZWKed8?=
 =?us-ascii?Q?+WDQ+k5svPEtKCp6/mVoWjSkOC6R84zNrd4/Runr9hjQQGuOERkKqdPkxgKX?=
 =?us-ascii?Q?TGzPgrj4lui6oEXUtsuNHnF2Zl2dYOEAXWdH6bPttIa2QUHkHPWpSnMVaF3u?=
 =?us-ascii?Q?LWJnKhcXsmFp5Pkueewn7fRHslO2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:33.3938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d001b961-29eb-4917-d209-08dc6954f1c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

From: Kenneth Feng <kenneth.feng@amd.com>

Enable gfxoff on gc 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         | 14 +++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 08f866c5ff432..d9e975a9825d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3606,7 +3606,19 @@ static void gfx_v12_cntl_pg(struct amdgpu_device *adev, bool enable)
 static int gfx_v12_0_set_powergating_state(void *handle,
 					   enum amd_powergating_state state)
 {
-	/* TODO */
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_PG_STATE_GATE);
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 1):
+		amdgpu_gfx_off_ctrl(adev, enable);
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 68b9bf822e8d8..fe6834f1648b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -758,6 +758,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.44.0

