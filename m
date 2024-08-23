Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF1AC5321E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF36F10EB60;
	Fri, 23 Aug 2024 14:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g22Peegj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F00710E0B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSX+IWMuuf3ZVOaLIqSoNXVIP1LAjF4pJoQ9/KLk5S8sZTPmR+iGaeHf2L9a4vuEyQxPzwd3NIjuCQrD4NWCq3QgNPd8FtstrglQPA1l+yzLHiqoFbIRXzs5jJ1+/G3upM3VS7bN+RH6N77Wx7LloepRVyzfC3mSaxneKindmsgXdYRcMiioVRT6/uIV3w2/3IBnpD+aQJyEkDpV4Ofdpu4soeO1WD9PJhhMSeA5bwRFn7qr66ig6PynuF3iHIiO3qv8Y66RH9GCGZ/Jss83WfGlFrqIqM+uJHwrbaihv9OOIgcFkvRAEdJognRB9MPhL4PgyMNDpWry9RzN6Tcg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g+jOCoOtCK4+TTrt9IObSoQicDNqBztAoFvWgfVwcA=;
 b=yNnWS/1+hCUdjU+A0dadnBjk0Wg2kQAnHixPp38189YT5yX2QP102iNjdOUelcWxIjmS9nrN6eEGqPuD/fziegW57id8ihqN2Db0axGst3HgRc+5dkn7YKBSdUK9Nw/PtIq/HUx1CjZpL/cReRfSOi7ObrRn6+24QtUZEKxkNreqGHWF+BToASzhVuM+EuN+a4eMcrumw8pKmxrc9I4z1GiKwpr2vxtMPkglYsPmojlfp910I8ToflPeM3NRmcdS3ECMDbRXX/M0RVNtaya46XsE/5ldXxSnN1CVKpZCtJCZ0o6qq+WS4n1kJKpQN2bjbh5lgo6xyGtlUXX690NcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g+jOCoOtCK4+TTrt9IObSoQicDNqBztAoFvWgfVwcA=;
 b=g22PeegjNM1Yt7h6Ll4DsXkemfY2225i81imYmrnZ0BzlraLkQeJT9KeO8IdhMLR5nbFMKd9fxw0Y+DoIrckbmRycU0vg44qGHEuTo+DWqc5Nx9EresSU95wgx3TSg31nNMR40PRYORyF9OnKtNX65u5qJ9dFrVXIOfGjb7Kx6g=
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:55:46 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::15) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 14:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 14:55:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 09:55:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <luke@ljones.dev>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] drm/amd: Don't wake dGPUs while reading sensors
Date: Fri, 23 Aug 2024 09:55:27 -0500
Message-ID: <20240823145527.150749-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823145527.150749-1-mario.limonciello@amd.com>
References: <20240823145527.150749-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ed4b3e-6b62-4449-0ac3-08dcc383ab36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cQUZwr2vrX7adWZ1wxGsZ4WMv3DPVFeh46+Dfbuz/+j5Br5wOjw7Ar2eVhLI?=
 =?us-ascii?Q?6/pgSwaVop0HMM5pNybkL6+dBTydmSNtCFG0WrSxaNFrQFaVlgF3Jpg0m1Bk?=
 =?us-ascii?Q?+qatC4TVF1uha0UzJarkpw0oOUzzW1DjSYp8JJ4vTfNjaQJJfRoEGqO5DwW6?=
 =?us-ascii?Q?DmcoricoHci7K4YsPqiZCkW8GGLYklMBOe+U6DRGV3ukykEC1ntSHx2gO6lN?=
 =?us-ascii?Q?8+k1n9CT10NMD4Z4WWwJNkALHGBMJm+qysvfDGo/plC+Bns2bQA+7UlgoGBw?=
 =?us-ascii?Q?e8aBJyNlrkAPx7/KGgOglzMJqJm0KEHFVCYeBO+afquTOP2sJokcNvwYOiYR?=
 =?us-ascii?Q?OIfBxN1vcBFcNymgnFBRZVWlnMj0fye+ZvUAXcx2EIFpx6Mf6UXWw04mupsl?=
 =?us-ascii?Q?4DtrKgmrZjlt1yZN/LFuNwrd5Ln7uqIC+nKHA3M446bDFWllgcKSu5GK9/E9?=
 =?us-ascii?Q?QDkJtW9FiCYskmaDZq9H8elzS3Gwayt8lJhXLG0Uhuu87l8G3+U5/6h6owsi?=
 =?us-ascii?Q?5h0bKocUV6eWIkmUQxh9bKkuXhkkBPC7PbvMokxrAxOOlIgrykgyFIc3UjMl?=
 =?us-ascii?Q?r9h0KZCd7+J1lFs1EaC+xhZHlo6uDHkif+Md2tJqejXZIKGAEDRdtDSI1++Q?=
 =?us-ascii?Q?yNdfB5FMLllgRYAZT1doJR/leZvkF0wGInqpX6kWSOuXYMD6E/CcuRivQ+od?=
 =?us-ascii?Q?f7iQDRJHo14cBT7NyHPGNCY6T7KE3Sf1NtAK8whLch7VpaUeanrfnH+h+7ja?=
 =?us-ascii?Q?oKUx5EFas0CsQiqJLNd1+9X0+97IB78V3Cd27HtfKXf08g4qNd2qlQSB1iKM?=
 =?us-ascii?Q?kw2rB/zQhmN7Jox49QwSTpTiEZ0T2ZVYQy6ZIKBkXqh6wJUVSY5g/VImjHjS?=
 =?us-ascii?Q?cj4TAXC5i199Goib1KSb8X5oL7d9Qr8RpHzEq48bWtGnDYYiFtbZecVfU2CJ?=
 =?us-ascii?Q?AxMgry1pAnyFOd+MBcz5GMiQ7iub7s1hXdzyshGFgnq3k0+nnMcPvbsNIz2F?=
 =?us-ascii?Q?P52tNYgIfKmQK3uXuQ8HaqiPFuupJS/hP/4iV3gRd1o/vxubDULkTzjKSe4/?=
 =?us-ascii?Q?0UyJv/C53foSIx+GEdK89+b9btYqvNrpzsW5JOJrIPF65K+8XnpwaUcjxzsj?=
 =?us-ascii?Q?XEMf1KOFKi6ib2zkbqYPyxY92Caaifw4HHcvcvbQsxZzQPosWKN8Xfbb3C1/?=
 =?us-ascii?Q?7Gzb+9jm/0UytvJ9kjWFJoifwEeKXZFQhXXoI1QosTr5m+gp+1a9Q/mqtFvm?=
 =?us-ascii?Q?wmPaNUkMcKVDdedzPQWJ4QsdbM0hhNpF9HV17iF2+swBZudF+hl8EfPssO2v?=
 =?us-ascii?Q?KKNBtGXvN3h1ORIEhpVaNbCio9nVrvdvXbwDKl0qcviqTVjBpVyAhp64AFdu?=
 =?us-ascii?Q?7xvtBmToukmKMh197wJ8Ruewe25xD5QdQoSuVGn+TVHstoXjC+1xFuSztLkd?=
 =?us-ascii?Q?HX7mTsmKmqSVM9dpgXvygn+HfHUT8IFd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:55:45.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ed4b3e-6b62-4449-0ac3-08dcc383ab36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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

If the dGPU is off, then reading the sysfs files with a sensor monitoring
application will wake it. Change the behavior to return an error when the
dGPU is in runtime PM.  Leave the behavior the same for debugfs files.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index bbd6f3e617358..cca08eea0e26a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -101,14 +101,18 @@ static bool amdgpu_sysfs_attr_accessible(struct amdgpu_device *adev)
 {
 	if (amdgpu_in_reset(adev))
 		return false;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return false;
 	return true;
 }
 
 static bool amdgpu_debugfs_attr_accessible(struct amdgpu_device *adev)
 {
-	return amdgpu_sysfs_attr_accessible(adev);
+	if (amdgpu_in_reset(adev))
+		return false;
+	if (adev->in_suspend && !adev->in_runpm)
+		return false;
+	return true;
 }
 
 /**
-- 
2.43.0

