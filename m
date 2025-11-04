Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF477CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478E610E526;
	Tue,  4 Nov 2025 06:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35y6AlYg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CAE10E526
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxXEY8mu2iFEveF+JlUSfeQ45uSdlLVM8agNdj0k4T1vyLBzl6N/EmFjPZB2b1rH3EfMqQK+83ThZz8FI6Ox3O8AnJUk1liGzTMYGRk1JSrE4UVtjNAtddHwieyiQJUETcSL972X49OXVyURdzk7Uu6fWr85KPwf5HAUY1ZxsiGbEWU5UdiU4nMqcs+kkhm3hzWVYsc22tPSkplVy22Kdy+J6JWuNdzlM2LDi+pGTXkHFMIvZQiXOXiXRFdnFIfEQ4Yq2AdOi1S/fQzetDe1SMg5sVidsYmdjlG27WBN5pVV+SfC51sg82h/iFagiqt0SN57gtzGDanh44cGkHaYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xLpg8eLeNQBEa+c3xYI4jB62q0GIG1IrRnHrAoMb6M=;
 b=Vyjsv2FnVSlpUUiOapnyQut4+OciZmuEq7RWZTYPM2c6/hiyvZQn6NspzUexuyxRwQfPn7ix9l2wZ90HVBItCtBwHTmniI8z5UTBfUacCEMHUjnFiR80j30QC9/7hMww6W0C0aIXEna3N6KIA/0MDkOJBA06JgYEFNKtWqiNrz7FurRZc/zh2Wk0nwWL5aBulkUe6eXUUZ52OyI5ll1VZsFaF9ehugbp7Wy8+gKfLCpO2b3SKeoiZBqWuzKI6/ptwUSvDbVHRvmCwTfzUNUKuMJRtJqtYf+7MvkMCScCV0eP2wDm7vvTba13EXznU3wSiGSjc2bzOBPSzbDAeGShzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xLpg8eLeNQBEa+c3xYI4jB62q0GIG1IrRnHrAoMb6M=;
 b=35y6AlYgM5+jYb4HPktQ8VSZjmUoQhPD0bzAr84b0UYaE7uB+GF1e8Yw+1mpUea7Z0CiKkQEOXTPKcSHRH3rPiih9LDorLQHaowBRq3fhMgWi0rIQ4rhOP+6LBAhw14SelioGnPk6u0KNu5F69GtwMiXAVk8/+ydILaHjMon6J4=
Received: from MN0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::28)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 06:58:26 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::99) by MN0P221CA0017.outlook.office365.com
 (2603:10b6:208:52a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:26 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:25 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: add check function for pmfw eeprom
Date: Tue, 4 Nov 2025 14:57:43 +0800
Message-ID: <20251104065745.1737050-8-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 141caf21-baec-4fc3-b3c9-08de1b6f8de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V7SMtWtosZaKy+BgMzgnSRhyphbPkO08SaImz+FFTjIDp6z0ASoUoFMzJyej?=
 =?us-ascii?Q?xuZa6/Jr+k8zI6/lwf1CeFuA+pf6EeILzR2VNBM+r2sbq/S4HKa3MYYZ/Uni?=
 =?us-ascii?Q?kVbgzOSewsNJOoJiPuYPt4gw8Qpz/rsiv1H793x54HdAxVKsCVnLnO4t3xET?=
 =?us-ascii?Q?nTHKolZbPuVM3jfwRJwwBxbJJ3QiP9s94gHpmHEnrwOflyzqhsPickS3VFXl?=
 =?us-ascii?Q?O+F4cg3aNorL3qOw2wP9ao/3fiJyHtkS/0wf2i6ffEF5UAiP20HAktCI+qYN?=
 =?us-ascii?Q?19JjK8GDXA1NseBdO55V8cJRJthQJ4giX87SIq4Wyhb7pigX1/EzsSNrqoNB?=
 =?us-ascii?Q?0bmZnKj2MGYKtpY7zbBznJbKtFAX3lhSgfiZs5HZvoCwtd9Klpzoy/9TtbPl?=
 =?us-ascii?Q?ofC2iBV7600LewoBYCFzdywhFwbUlBhtZMX2xw1tzCKD0Rpg3g4qnYv9eF6+?=
 =?us-ascii?Q?c38Ff5dyRJnSAip9g1aNmG5IYyjq8HwC57uU8AAV47+x9H6gZXARXtbyWsOr?=
 =?us-ascii?Q?TogesQLseqmsdUYRKtqwR24WMAUnq36ABVXspOy4TUP9NxxBYCf/z1tphKyG?=
 =?us-ascii?Q?GuJTMyLku4MMyxR7W7qKx8ucDI/IipgRR0mVkVgud2v29tOsaV2lY3Us+FxM?=
 =?us-ascii?Q?6p+fVS3FdGxrQXxfw/tLO1YulmqJtn6yEnWrPa/vYKZz3LKeDdaFudgMhDvu?=
 =?us-ascii?Q?iD/b4pvJjyzlBN5ElLOkVbpoX/uhEyoQyyBR8/+kJHYvm167jumkYZWaPJ02?=
 =?us-ascii?Q?b0HMxVibnTjubZ8HV6nQotJm1EALvqvSIC9Q/tdTcTdP9BvwtR/fpuRVUu11?=
 =?us-ascii?Q?/uQw3NLE9Fs1Ysx+WLxH2YZcXih9WD/oE0UVj4HO63ZjaPwD0FDyWN46kl0j?=
 =?us-ascii?Q?VEcq0gty1O0O8rlDnXp7ZvuARGwIa7kLOnhd10QIK3CtGMTKZP3d2LikbUJD?=
 =?us-ascii?Q?6tkkgfbClfH8ucMxM+i55m06jbL6lkYBdjbPwfsDYQLV1/gefhuJrm1ZEs1E?=
 =?us-ascii?Q?vyWrrhSmrmOlae8z9bjU4cP11Sj+e6WboHfqXy/qHzgdl2Gt1+fojiGNjkmj?=
 =?us-ascii?Q?Fp1JlqoI9WcY3JSV1WDKUaDIh/vCxrX3vUtXuz8GhAs00Xy3kY3ohxCsQ7Qs?=
 =?us-ascii?Q?M/NZxsf6c8BFugpOcEF+gGtMcKwLsBOvAwgYIQsUgqaMYPUO+F2IUp0zyfhw?=
 =?us-ascii?Q?GfZFaMLxfO6aIrWdIcDHaSCo4vTzTbKMYkNNd/+yX5t4HH55ejj+Mu4rPX4l?=
 =?us-ascii?Q?nnYMYaND26PwqpFfIw3Mw6g0AFCAF5lUQPuB6MB19bCkHw3M37KdSk3HxDQQ?=
 =?us-ascii?Q?wYbqebPLMOip8aPnEFw5OeMDjU9hCPq/ic0jmFT3hEg477MY5lKicn6pRtJc?=
 =?us-ascii?Q?ERfDsh8yd6KADCA1idBoPvEZX536JXVNMvSL1wRQjqtrmLmKa9rBJPOhTiR1?=
 =?us-ascii?Q?i4B+KuTAYDfiNIuA4lckwjSK8wXqlfUadPQJ38uqO1MsdOzx6wudGqopWnX6?=
 =?us-ascii?Q?YLxYF5r9C9sEL50nO0FPtQHtlCXj2LTZP5WQ7dqW8ST2Iz7XnoGKMcSarm/G?=
 =?us-ascii?Q?g7QCTFmRD4GAK0gFJZc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:26.8979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141caf21-baec-4fc3-b3c9-08de1b6f8de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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

add check function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 6b51574530a4..3c646d9dad77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1499,6 +1499,47 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return 0;
 }
 
+static int amdgpu_ras_smu_eeprom_check(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!__is_ras_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_bad_pages = ras->bad_page_num;
+
+	if ((ras->bad_page_cnt_threshold < control->ras_num_bad_pages) &&
+	    amdgpu_bad_page_threshold != 0) {
+		dev_warn(adev->dev,
+			"RAS records:%d exceed threshold:%d\n",
+			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
+		if ((amdgpu_bad_page_threshold == -1) ||
+			(amdgpu_bad_page_threshold == -2)) {
+			dev_warn(adev->dev,
+				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
+		} else {
+			ras->is_rma = true;
+			dev_warn(adev->dev,
+				 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
+		}
+
+		return 0;
+	}
+
+	dev_dbg(adev->dev,
+		"Found existing EEPROM table with %d records",
+		control->ras_num_bad_pages);
+
+	/* Warn if we are at 90% of the threshold or above
+	 */
+	if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
+		dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
+				control->ras_num_bad_pages,
+				ras->bad_page_cnt_threshold);
+	return 0;
+}
+
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1506,6 +1547,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res = 0;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_check(control);
+
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1

