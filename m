Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21257C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 09:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B404710EF46;
	Fri, 26 Apr 2024 09:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4NjhWyNo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA06610F2A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 09:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jko3ffA9D39wLAjtwpRhD+acoK4Nnru0ldELtW1EG2VTusa2xFZo232/uEW/YfNWp7DairYUUx1uMccSEt+rbcDZPrL1H/iToHBC1qg99DaiK+Os0BnoAtwrhCXskq7BTWzaHncfpNsS0swZxLFPxtQfxnPs3mfZMLiJmOLQwz/Ow1Q+gXTAm1EXCICrcgyNYruua28pfjUVi57a7eCX7z0iqa4EDL++PpOPdwLzDyD3Sq9cNppfQx8Eb/t6sS2mjWCee0Wo0nJpaDD7rqr5kY5uwiMTdyO5+9mUkB8+1+nfFeGyHweSpAh0K8shmyrpPYf+0stQrroCGCaheMDRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbcQSb9kZ0Yzz9x0cBClu33rDaWGSuGek6X0LAkkm/Q=;
 b=KyA6Ka5O++T3gceKdufQdvckaCnlGjYLujKVk3jBlKWlsYzINhHDz7XDZfyEPAngRbUwnbIj+tKlh7OdPJF3JVqvFehoo4OW8aemiSmdsbgBXG5xXiEei8d0yBFhZJ+aaE5r6hhf4uZ7G4SafNQ5yeXw+Dh45hxO54CWV2ZI5i0LG83xA0KOeMpVX/w+3em7K6yz4+xJ8wEsvNjL5e5n8qFgNjFD+lZerLd/mI3bxENTjQPkzy3YTQrzWOuJGTP/hiFM5jFZR2Ud0uOdlcWRKyJqgceDQ1wRA1hSRXtlRe6spJwU3MSacpvC6CBDiDFgSmzdJCBS3uL4g2CmCtdWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbcQSb9kZ0Yzz9x0cBClu33rDaWGSuGek6X0LAkkm/Q=;
 b=4NjhWyNo+uMHn/G46AShHchL19M7zjKB4jS5kutsm2xHSgccBf9kxkt+6tAFUe8P3/lWmjOE5J5q1N5VFuePIhiPmiZsIxbm/i9LIwUATP5P/350jEi3iIbiiqBvBgyRYyzlQUtLspf4777mxAs/XqZWwbdJ7dyLn4W+Db+C9CM=
Received: from CH0PR03CA0429.namprd03.prod.outlook.com (2603:10b6:610:10e::13)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 09:38:07 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::3) by CH0PR03CA0429.outlook.office365.com
 (2603:10b6:610:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 09:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 09:38:06 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 04:38:04 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix the uninitialized variable warning
Date: Fri, 26 Apr 2024 17:37:49 +0800
Message-ID: <20240426093749.21707-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 83378f4f-3e46-4893-38fb-08dc65d493dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AxPfcQ0L1+/401DZZ0KESGeXO2IUR/b/8Da9btVdFiKrEC/5n6XRbQy0IiYP?=
 =?us-ascii?Q?3BA0tCYhR/0tg7pWQRof+nlsK0YZA6hy2WaDW14Ypwfh3Qcpo7Y8r97bjtNc?=
 =?us-ascii?Q?jK53y0cVn12ItasrXerXiFBYAU2lhWWUB9NmktgHxq7L8wI8BCB2frgFMp1D?=
 =?us-ascii?Q?/baOSs6RnEAMZpInhDC4TFldD3SE5dN+7pjxEDLZ1WHH/O73p/BKFrmC8s+q?=
 =?us-ascii?Q?vbWEzALbYTe0oU+DClMImzxkGqIALQJtwG5T2/wTPHE+OPtCtqI/hu8f+dJn?=
 =?us-ascii?Q?ApBcxaId+MS0UnxAvxqLn7vSMpO7EPhrSyd2+tKnwT0jfJz2ctPUIybIyUSI?=
 =?us-ascii?Q?qQh3bl4mmGDwPG3M7G+SFdBP9r3uNgAsa+nScK5MmvJyHR1Qio3Z8T1pibDq?=
 =?us-ascii?Q?7l0l1ZG3aw5hrvu0+YND+4AKXe1uSISFNoLa+bo4tjZap1TAdqrcUMKsu/Qq?=
 =?us-ascii?Q?rC+/4UZRdhz2ibSxHKBl/O4R0CQBUojsJHmhl2X1W/kGNspxRjmycBk74bvi?=
 =?us-ascii?Q?MiwY5M6ja6r8oXpIMe+NhjlAWTtohcHvw2afLV4FmZCdDt/Ji/iU+/9tvhIf?=
 =?us-ascii?Q?8zRb8BTxiXu/Ib4rvOGfSneH7YvDNR7IN0Q3G8Z2Xg0hx1tHah80nWu4dtNx?=
 =?us-ascii?Q?g8uECDOHggtKMuvfAJcjTMEvoXdPRzdoN1vzS54Fhb9OfHiP1Q1eI5aeaE4d?=
 =?us-ascii?Q?UI+t3qIGE0Tnz0mKSvCs58hIW2m3jLLg5pBdVZ7wVJ/lUxtWLc443LYGVO4v?=
 =?us-ascii?Q?07CT//5UxBCZqgrfUNGu2KbUpAXUTedlfr4i3q5ph9hoTiAqCrhS5Ote4FHv?=
 =?us-ascii?Q?NzCa8m2gQnb6jl6UMIlGHxuaavXIJOWgP3EWwDaMGO/dHSqhXV+WeoqsxiDI?=
 =?us-ascii?Q?skZQJBvbHIpdU9hDMABgXssyq6Qp09QwT9S6CsB7VtSciQxSA0SCI9Wzz7lC?=
 =?us-ascii?Q?sgLrYX8ay19+PWbir4O9msgBpYTK6PwaSQShG2V9aY1keZaNtmLQ9sq7Q++t?=
 =?us-ascii?Q?jLuX5bnCU9svl4aIouaFi/KFfJSdvIeVhdKFIImv3NA85B3ykQn/z0hZr6ov?=
 =?us-ascii?Q?A2Cg+cRoZm3UKAkxnhBJgy8yaZu8aVbCOcL2iCalMTBsmbCSQAaORj0sPYoq?=
 =?us-ascii?Q?+odTO6Dp3P2WA5OZXvpmRO/kvk9Yf4hDb1nW+jYoxiIr6p1+jue7GGIQXlq+?=
 =?us-ascii?Q?3zlHUsRMX8zvpxam7CP1xcCqsZQmYK4C789Ky9JOcePq1hct9utc54COoSF0?=
 =?us-ascii?Q?C/bytD7E/Mu+kbUkxq0+w/I7Yh2TrfA7osgoJrF7QCHJWf1ZHY/pLqLFssEW?=
 =?us-ascii?Q?dgvp91hPflu/10nP2TgYFvuxtl/IDZVCuQ2BPxpytzL3FUrKTFz59TOi2BPY?=
 =?us-ascii?Q?irpn711LJAUlNawa7aMC3ony2Teq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:38:06.7051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83378f4f-3e46-4893-38fb-08dc65d493dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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

Check the user input and phy_id value range to fix
"Using uninitialized value phy_id"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 8ed0e073656f..41ebe690eeff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		mutex_unlock(&psp->securedisplay_context.mutex);
 		break;
 	case 2:
+		if (size < 3 || phy_id >= TA_SECUREDISPLAY_MAX_PHY) {
+			dev_err(adev->dev, "Invalid input: %s\n", str);
+			return -EINVAL;
+		}
 		mutex_lock(&psp->securedisplay_context.mutex);
 		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
-- 
2.34.1

