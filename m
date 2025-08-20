Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8756BCA0EE6
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 03:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D94810E342;
	Wed, 20 Aug 2025 03:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J3ny+VHM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532C810E342
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 03:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saRdt0ExZyuhbUHfxh0jN1eJXFUyUkQqtYhi3XebBlX7bmIv0QnYEoIjhSlP3Q58cT1ZWb4umTOFcAEGgo82LmDYx3dEweKUwgR1BtpAz0OZHvwx8kiu8zgvH4lPZHf6ub2uVnnNQZWCKlZYUK9m8J+NhETja0AUIOF0nfZIDgY2ETB1gCukDuZZSz7tvfQc+PQDgdUlp9DBM14tEZomP775Hr6hNlK5Dcxd6Io5p49k4l+d8EvZD3/NL5mTQ0YOKeR46oS3WzoPnvlIBn0WUIqujWWIlrVQJjM6cRonVNanxwouERpQAK8IZR6wFcpRwXtFJcC/TAoRvc7Gb0kzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMvkvChttSG4+OEG8jN5xrUpbNI8YfgQ4BZzIC7MQuU=;
 b=ZDKrBX3cjKxF5qHwXlrwZOj9YZPlgNHBGbr03fUXCAPf1hAWalKs7DcOSm3GeLb9uyHvb5hewAbC1tDtYAfaYQkTLFtwDgHkFwILtRvQWOA3gTDNu0+b1CqI+YKTkKv4TY0cvaRXh9F5we74Yj3Mt1+OdJ1C77AsLbKh98sNOiE2YOCPaK74AHoKc9KRULynBAy9glQeAWj9JfNACJTrVt1N81Rq8wv9cnWOZj6yIUHeItAwnK3yDizYCCTeujE00uSqShr8i/bpNvvRHBntuPhmB5fP0S3m5ufHxGfK/dSEIWV0Qa7BZMAlft1kNglIhFYXfUetH/7XZopBCBcn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMvkvChttSG4+OEG8jN5xrUpbNI8YfgQ4BZzIC7MQuU=;
 b=J3ny+VHMldaowX57bh+b/iAOACR5lhIZLjsEUAdZvyv/vXpfRwo+KRIH9gUQifN927O1sPOZLvdtE5lunSE0wImveYR+1UUET8+i5hXGtFHqqN6pEzksTya3RpRQT/322ehYxjm4ULsEuZj8HmUo0MXGHcsvl2DFQg9ikFSfnJA=
Received: from CH2PR12CA0001.namprd12.prod.outlook.com (2603:10b6:610:57::11)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 03:04:17 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::bb) by CH2PR12CA0001.outlook.office365.com
 (2603:10b6:610:57::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 03:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 03:04:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 22:04:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 20:04:15 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 22:04:08 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Date: Wed, 20 Aug 2025 11:03:27 +0800
Message-ID: <20250820030400.514460-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250820030400.514460-1-Jesse.Zhang@amd.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8950ad-87ef-4bd0-176d-08dddf964026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/QHUPR1lnxiJo2XC5OXKtrGjhCoClBLWGmiZXUjp0Fp6q1s7mt50egxoSrd?=
 =?us-ascii?Q?7FU44dFJt7XiBiyQfCHAjzHRiT2sSkESdpUHZ7b0mjGblcbUc3DpE9+hLJ6f?=
 =?us-ascii?Q?LS8SmreI3kQ0xTH5qdo61mtw2dBy+m7nonSFtcXo9fbwykCm7uu/oooaKCm8?=
 =?us-ascii?Q?gcrCQ2fItHTuqQ976FGD3RLwN7dfLr4D2ZiayFc+jz2/AeGK0DF5iUVp/3ma?=
 =?us-ascii?Q?j/OJA8ZEoHEeLeMsYMHcy75dCwlOzM0F6/Ddg5b6Mx9kdnB6z1QXhlczMpof?=
 =?us-ascii?Q?2LgHHuoZ2TBMxDSkyXADk1ilZ6Si22eWA4UmXkI0AbRJ2sw50sCjuxSQjfIc?=
 =?us-ascii?Q?zh4zGyQBGlMU21dY7dpGrrEI7BZsULC/RCAxrz4uVwnaQa7vqkrdTMke0jil?=
 =?us-ascii?Q?mNP4uCHedLw9SHGdp/o8k6n3o7zAzEh6dbILhDnBuWYRg2AZQfw9OGxlEcqI?=
 =?us-ascii?Q?pj4YTC5zQCZFRH1VOBsIq1E7Sf9N5c39rWMIbdgy7GBJBO8qHpZOkWqU6bbh?=
 =?us-ascii?Q?Idq0YsAFttnkJCllt0keeiya/UvxS4fip/Is2SAh8fDUKidBX0j8Lj6YB8Z1?=
 =?us-ascii?Q?v7M3J4XNwFEHnB5CPAysa+AMwi2ABue7aD/sujihQeABzKfq6RTKmjzP0VvT?=
 =?us-ascii?Q?BC7rPMOzDavr38hX1jCBp2Vw8NwsHRrxAp63ztooP1fdXdKZ9ueqSqiVTctN?=
 =?us-ascii?Q?EuPq3tgzKFKZA6RH4sUsVUfqnTCQWqdRipaygI9BsUq20wBS4Ty22QCz4CKF?=
 =?us-ascii?Q?7SF5lccgoj09eDG27eLkEd6QHp2LSwCiN2IMsXTN5JQ7rT/vXYv33fQsnSph?=
 =?us-ascii?Q?OyG1g3N1MkEhQg89VSU68cenduvm0T8q1F6rvVX2i+SBUkBgZ7asBWsTzefb?=
 =?us-ascii?Q?9TZkB5NMJ+TwJrnIqLhtXSzl/C+Q+ytun+nJWD9krH4kUjiak0ndrhfozLEG?=
 =?us-ascii?Q?Y2DLqaknEGUmP2XFwo6tD4Nyw7OVPlvnZs7bavWUSihCe0d0/9yzrS7KCsxw?=
 =?us-ascii?Q?++58GbxrlHMI98SpdqXOasSIfWi5rpCt03OkLehaSEIoK3VzORrQYU1B8tF0?=
 =?us-ascii?Q?R1XmxLeEI9n5rLC8vt1ScNxfkaw8AnjDMFaZhKbbdKm4oZuA0pp95JGEHAza?=
 =?us-ascii?Q?PaVyXrqY4Wilwo/d4/6ukE0xpyH6U1IUiDrIiTwhnxmrZfyzdsdNuZzGLOFL?=
 =?us-ascii?Q?LT28PnUrg2cQBRzOMtFNrVTSq74PbxVjAOhPVEWp8mcHmVS3A5UdCgQrsLTE?=
 =?us-ascii?Q?r89pCZncJ7adb4PB2jDb0PTCVLa8I4icVobLvuQQI0DkHQLuqsFxDYL4gHw+?=
 =?us-ascii?Q?r/UGprodxz77V+CNcdfmJ3weRC357624ZsRHiSvaCUij2h2BrYNSh2UbF81d?=
 =?us-ascii?Q?AeISUlWlW8GzsjZCPaDDGsdOEDEynG8CtMBBjahOifSSasalm2nRwHd18uh6?=
 =?us-ascii?Q?4NjVMCkbD7+ZuYrIydIrEZP1nmuyP4odWwHonshArvcnWhWtWgbx8XRfjGoL?=
 =?us-ascii?Q?73cDrUQ/wBW18qatFF1Rr2AFfCN+V85DKaUd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:04:17.0237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8950ad-87ef-4bd0-176d-08dddf964026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
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

Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6 PPT
initialization function. Specifically:

- Add support for VCN reset capability for firmware versions 0x00558200 and
  above when the program version is 0.
- Add support for VCN reset capability for firmware versions 0x05551800 and
  above when the program version is 5.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..9306bfe808e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -437,7 +437,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
-	if ((pgm == 4) && (fw_ver >= 0x04557100))
+	if (((pgm == 0) && (fw_ver >= 0x00558200)) ||
+	    ((pgm == 4) && (fw_ver >= 0x04557100)) ||
+	    ((pgm == 5) && (fw_ver >= 0x05551800)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
-- 
2.49.0

