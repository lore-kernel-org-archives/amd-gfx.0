Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF1C25B77
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 03:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5901710E8FC;
	Tue, 21 May 2024 03:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFv7iJJI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E3010E8FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 03:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUqSzDYGV/ipPQCb1M06hcM9T0c5p6Q4zZqCS7sSgZWo+UWpABq+jKEeLWI+fPp+Cxpww21UoVXU3QxYXqTswAISq5h47eQ/6L2aHzxLP94nWNtP9UwelPhqUuAB0TZp41Mv+BaZw+gIH1OheGi8S+8okJZucUCdeljpoCGYAB7EbrVstVu43Kec5ECLDxq9nsl2euqpkvUjN45zJ0hqVRO5tYI6IdtnROhfwKGyjkf5k3i27JXzKwFpb8pNxvLisXkNtHQXUyztJbwNrhhCStcaAZ1RT2Ee8IvMwx5D131gM3hjstmsqBaiouix7CzdHil5H/8O1pioM/uSvJW8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg4zMShUTeQZejaZPqUe6tq8Gyq5iwJrvwBBo7XcRNs=;
 b=nPSTQRkCaPwXmAqX/6rcbCK9NfpSiUMsyDtNwFHAF8M9pcu4NMw1JRn85mD5RMl3Jxo6eiVua8nHJlG8CtxmwFbINtB+eQLKhDbFhsKkdTltO6JA6wz0ZwcDy2Dv+ex2t14jzCQTOK5FA3coCFZYdtbmlP3D8DHiVr7+sV3ClMkMb59S46Dc3nENqQIBdeA8MdPINci/75nkQcyEthAKJAoe7UNyfGaW2qxJlSP3oTZ5nt/m2ksjEveO+FpyFDRtqVb1Rv67kJCTtZyo64DeO2Q3P82LdW/bUv+d2vyskrrJYmTcZtnbyeeojTfjHv+bIrlXSu27XpM8JLm5/wlpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg4zMShUTeQZejaZPqUe6tq8Gyq5iwJrvwBBo7XcRNs=;
 b=AFv7iJJIUoG6vpBzr45XWMJaHShHYxpuL7zkEjoB+xkQuFMmsr7UXXC4JFJrcpEa8/boaOp1ho3ApE1lkHTy6WL8nsQgnOFp6dIGsXMueg28nb6XSvp0rFvhbXHXeCel5xR7t3meditzJGJYlxu/uKT3tyobRTmjqCUwOrmINzQ=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:26:04 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f7) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Tue, 21 May 2024 03:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 03:26:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 22:26:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 22:26:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 20 May 2024 22:25:56 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context
Date: Tue, 21 May 2024 11:25:50 +0800
Message-ID: <20240521032550.288684-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c53e002-2939-40fb-364d-08dc7945bec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aTnVHk0ap4iFRRl6EouHQ4UlwJOaiHB9OyqfJrHMCvploOsz4qUiEwp2lEd4?=
 =?us-ascii?Q?pAmxo0fS1rqZD86DBRNDrJ2kJAPvV5/J3UOUoSBI8ZwuvABMC+Z/A7g43uTR?=
 =?us-ascii?Q?7QkFfsbMIM3ilr/YyH9yIxcoDuSv/kMzEPxnuO045kch1Y5wi9zF2XP9sqqF?=
 =?us-ascii?Q?h5tvo+tagvj2+qvvCHZFEfeOE+hioVX0Ma8kAWQWJJPcAPkqkNmuBKwMZL2/?=
 =?us-ascii?Q?oCjOa6rKTGe4wUI+6FoV035PTmQzKIGlWmCNde3/aS87YxCgjbElBz19cUMQ?=
 =?us-ascii?Q?1bc3kiofk8sjXbb/mO3/yv0IW5kjwzDG3il+iF96gdcBv1NIeNHledu5WlTK?=
 =?us-ascii?Q?OwI33wqBueNCa7GR/JHa0TtQ2Yzm9/r+oSEAM8odaMx6Cu4WEXSPN/raoZM3?=
 =?us-ascii?Q?hLy+TpsIIzEYCAD5vACjnfGrid0MdiIX+GVv0YMWUXwEkbdN7m6Jdq2tJBuq?=
 =?us-ascii?Q?0qGUc+XfLlcBZxixHxPeP29QBAcO27J5I6OUS2xlDXgH+va11IdemUCAilvd?=
 =?us-ascii?Q?dIsKp4ox2YXEkxPclcbYeVmNtv9i07HPFgIBVscpqcgVsSTHIYgOU5cpuBdH?=
 =?us-ascii?Q?Cp19L7VVD75oDoMpoT7AWkXO7Z6fxXNt/6GUccxsBQv90oR0oGuIHm+zeB61?=
 =?us-ascii?Q?afiYMPRh5yFDHITTlUcPsUOvb/IWEAWBIzFq3sVABEK84jpTpTmdayXCGY6K?=
 =?us-ascii?Q?lEXC8n59Z96DwaOoPUdzoEVuHnZGb7bgZHY9vumVz2tn754uP2GfpbB7+YOb?=
 =?us-ascii?Q?O+3tfL5q/aUNsdRps13gWwyyLF5nb+rJmmBKCUK3gxBBms2WNd0zeN+wiZ3S?=
 =?us-ascii?Q?b0PfL/z96WW2V7RT949cuPgGWkeQ24EH9yiYO/GesOYXbESrr5xvGOz1oID7?=
 =?us-ascii?Q?S0KgzedMQYA8vUsteqCvyYPWaV3+7T15CR51HQf9nMA1HWQVph9h70+wzfc/?=
 =?us-ascii?Q?lhRAEOAHwL9OzMFmAJVcOGr7z2d4WPP/vLkbbNRd1xZh1P19XV057duuDXkW?=
 =?us-ascii?Q?1653lubgXgNwDlTd97qLJiXOVcmwsPzOsb9prl+E++RavBBmqOayoK5oK7zC?=
 =?us-ascii?Q?PVdcTwsLdYICJ+fbr+hXMFBHNGjr0iqUfKXw9MsbxMMYRY8VgAQ+F52oQMJ1?=
 =?us-ascii?Q?WLvH+QB9h4t7jpcwGSIjPhbQZqBC4Blp0iTGP7E8ytsTyc8/GrmBspN/fVfV?=
 =?us-ascii?Q?szmN+fonjfJ2TAZ/RfjaYQwhkMykTOz3Ivt3LyJW7+cgioKImpIoBcFFvZmP?=
 =?us-ascii?Q?XZWakOqN8oUgO31f+hlN8r8l2SMQypkVV49PrI1m/qE/d1PjHz0Tq455SbIT?=
 =?us-ascii?Q?eT2XSDXyipHsgd9dxSjddzGCNdpyOrT27oPnxJ2jODNVVPLcH4Y1L1kA1xg/?=
 =?us-ascii?Q?/A4Syk4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:26:03.8464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c53e002-2939-40fb-364d-08dc7945bec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

When user space sets an invalid ta type, the pointer context will be empty.
So it need to check the pointer context before using it

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd..ac1f423dd28f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -334,7 +334,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 
 	set_ta_context_funcs(psp, ta_type, &context);
 
-	if (!context->initialized) {
+	if (context && !context->initialized) {
 		dev_err(adev->dev, "TA is not initialized\n");
 		ret = -EINVAL;
 		goto err_free_shared_buf;
-- 
2.25.1

