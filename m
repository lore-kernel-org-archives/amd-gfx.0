Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C262C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 06:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA58310E430;
	Mon, 25 Apr 2022 06:56:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE03910E07F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 06:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FutToNl6F2+dxpk4KIB5J+9oK3t6MBZFLKjCkmRVmZRtIkHF4Z9QMiXNvzzgX5cAquvOmlik+RHs8UWSJ+D7366qwf1x0PU/Xgo/k8+RQlqdlRojuUaYI6v+7reZ8o2hQwkIuoMXdV//0FyTUqx8RN/xRlUdUGTTICqlwVRGMqwA+z5Zera91LwU1cTt6nuDwlmPyAOiY8gs+Zku1Qp0BkHGhM5MTRLHQUn+Lviu9wuj+6r/IhTfLxTIuG6y52uxIHwJ9bh4z5hF+lQauU8dRtyO+zUHdwGILxldh8H7ci2SbpKOMIshKMj5XLI8fKqGGBsU7KRfexJ8mr4lal5VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hACqZkooqHZsdq1iQYHi4AwlXsMdqiy/7V5138zrMSo=;
 b=ha8Gv3VZO/C6G9s764avO+4vmzC5GVOXNBtGRVb2CIxIGsATrVVPS7pLGmMKhm7usqmXniQjq1WLWyo5WpctTmi2AeFUZlKUylg6m8x1ZlZAihEAQm1+jxp2e38bmHQNWSSJCe98ulnMrVH4QYEfFJ0+N/CyKY86hfaOq9K5BsKJgYY+RdDXQ9CNBNVobKJ3NqX6TUTcKoX0CIifLzQjlo0UCxJyztHb8rVgZoUFhwjRKZ4ot8IhaxNlfU8jb7mnhLORk9/lwPmh8NCZ3DM834KXogBS/nU4PlpvWA97mSQ2L6wacW5GR/lLzBdz36fpuOUFhqeiwNVJnb1ZbfC+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hACqZkooqHZsdq1iQYHi4AwlXsMdqiy/7V5138zrMSo=;
 b=jPBJ/JCfHA32lmnoBSWswWGZ7XZ/Oni+fMiLCwDpbcXAL5scU2WVZt2/vSh25uzC5mufrpgPCRuP+qvcWWvJ1pBXXFZiJMNpTJr9J18HhqPRFKI0Lix6EQkkxc0rsumQR72mtTJV/n+MPdK1muNwDQeH2HtBSt9OuDkTb09rcjg=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 06:56:05 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::a8) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 06:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 06:56:04 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 01:56:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Date: Mon, 25 Apr 2022 14:52:33 +0800
Message-ID: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e15ec4a-9711-4a69-d248-08da2688aad5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1287:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1287D6BE1902466C0625E9E0FBF89@CY4PR12MB1287.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TghTl/E8aJdOKN1tsHnmis86Bqgieb5q4pw21xgUAnyJsOx3mR5pPJ0uVfwuBfgtZrYGgWsXjvZoLj2OSnVAAmMjftuJ720t0JUClouArV7yHqcLbnEn1sMv9vyiWj5OApt8lM83XUaA5l290j3rN0okzwVNPg/SVDyA6Xv1AgF5TDk+9s1JKaTi8EKdWsGQK4V3+I6K5YSiWdbDhYTSiNUbwHpTsO+vC4im/0AvKKYmsBaYVtK2oBTxvIkqry6sefSxXN18aVFdNZH4YIGN4CSLsQvggtZZYOYIVv6F6987W2RwMDQF/TSuh8UbaNdz2exbsFvhK8rVJSdPPgMAz6/VJpiRTubntEb4jT9u0oqT/5fvq1PGekPniSYrbPCH4MC1JSoyS/EU3a0tr+lpyVdfEGg6735oegg3AsPYt0GKrsxD8OCH3tMPoQmTdfpebFC9v3whEAF7x36wzg9cG/3FaINTYiJhAq1DsfhGsuuIU1hgGSVyQFcrAfINjatj7UISmvmHsfYGPCQVagQyVlgHaMuXoMWH9t8muxY4nyRAEDjiEiBEkxTBdbXItWGdcu4Cr0rGwbX8nDFL9DHuOI8+YHUPCgJkev0tglcIhyU3KEcYmu9/dRx8sX3gLBQ3S0EzYtN6UvtjWlbBNWa9ZgJ08uHT/xQbEJRci9BwwpqzoM3imzJjOq9a6qU2u2UVFljpOfWNjsZGit5Csk0nsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(40460700003)(5660300002)(82310400005)(81166007)(356005)(7696005)(6666004)(316002)(26005)(336012)(186003)(6916009)(54906003)(508600001)(426003)(8936002)(15650500001)(2906002)(47076005)(2616005)(16526019)(36756003)(4326008)(8676002)(70206006)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 06:56:04.9269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e15ec4a-9711-4a69-d248-08da2688aad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1287
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without MMHUB clock gating being enabled then MMHUB will not disconnect
from DF and will result in DF C-state entry can't be accessed during S2idle
suspend, and eventually s0ix entry will be blocked.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a455e59f41f4..20946bc7fc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1151,6 +1151,16 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * The issue mmhub can't disconnect from DF with MMHUB clock gating being disabled
+	 * is a new problem observed at DF 3.0.3, however with the same suspend sequence not
+	 * seen any issue on the DF 3.0.2 series platform.
+	 */
+	if (adev->in_s0ix && adev->ip_versions[DF_HWIP][0] > IP_VERSION(3, 0, 2)) {
+		dev_dbg(adev->dev, "keep mmhub clock gating being enabled for s0ix\n");
+		return 0;
+	}
+
 	r = adev->mmhub.funcs->set_clockgating(adev, state);
 	if (r)
 		return r;
-- 
2.25.1

