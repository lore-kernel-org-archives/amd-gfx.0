Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74650CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101F310EEF5;
	Wed, 13 May 2026 14:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tNbNwEUy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34EB10EEF2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW6H6Tq+ez2Xp9jzj3x0FCd+vvIxh5Sroj6M3U7sCGSlkaEthfUTHfpd6EGpCEVlQL4kWvWnL3Hze6duJYf7Ys1jgYCjYi/9xnJU3WOrp6nQk7eSAuSonIC7C6jSivCz5J0oTUxCDlsBOrpbQZmsqvGgUjRXRmmPs4SBMJIPE1wqisUdej5rJoym34ck670DgnimrKgd2F0LJjkE7RQYPy8kpdcNUNaogVnyW/xgHDMeHEKugWc2Pj6doxD17qB2WWdoMrCbBvq8CLADgF9AIBQaULuSrYNzx7/OWS1Y8wNtGpCXfkCAUSQRRZIn5SJpcwdIz9FDn1rZNG1YNW7lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZbUtGoGNCETjGi0p8YH85VBH0ohmWTnM+mxKoULDEg=;
 b=Yya8MZUZuiYMh7HkHq11pLKMCEL4rLq1GkWxkTv6JE1rKV7onw3M6A57O0KAr8UdNkMaExYfOAjB+a9BsHhV9vpZ3LT+cRnKwqtWD8s8wCw1u7TTDXoIFTvTYyn3AhJ7bSrAP1P4BDp0tPUH3MeA2K5QW2aB9T5PGKKQCRjeR6vEp/ycMpPUwnTTpfKLPauiCoNvMajMHWlbyr9n3eWI8JCXCapSiWn71SBP+ku2vcah+s9PgrQw9nHNO9QOUw/DC727pDXmTEhWqLrtRDQRSB7YD9xGRsN7kcpFPR418qs6AZYL1IM+MdDIGJCi2x3PKb8SkVgu3qL3oWX2OguSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZbUtGoGNCETjGi0p8YH85VBH0ohmWTnM+mxKoULDEg=;
 b=tNbNwEUyGPwssnNCHXtz89Tw0LFFZFzYo7VfQzWMf82M/JH5Esm4QvJ8itD1Qu63XKDUT5esCRCPeVzymAsnt+FAyeAz8jFhjZwY9D744NQQ/iorfOXguyJ0o38xqj1hH1EeCbw3OzTytdksKO8dRjfnkkbp5qD+jaXs+87NFl0=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:43 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::40) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 14:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 07:33:35 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:30 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 17/28] drm/amd/display: Use lockdep_assert_held() for dc_lock
 check
Date: Wed, 13 May 2026 10:29:39 -0400
Message-ID: <20260513143213.1852892-19-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DS2PR12MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2323a3-68eb-4e5a-6efa-08deb0fca1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IpgBBbizgipPY318b9RQB2kt2l+trIG4esRnQ0MFutTVLcgg3tcSbZ1lXHPl/FyWJ93dDyVVITj20GGBsjyZrQ3g7YzltLmNB0Orw+EuUAxeSRY2b9zLsbV/cvjSFqThhwE0ytC/fDmQqF7ZulELJkhnHphfEmbWPG5MNW4a7+i6gAcz71q83JzrhPq+viUKwmphUjFWooUhzmTx9lXbm3+uX/K/HGOL6WyEbj0gqqF+yFmB8OCkev7rHyWjxyAEF6RYopzuCsl9khIUqHP4qfKrkyizp33h7fi5FIAys5cm8KBTGqutpYXeCq7Kz0p76mYsTOytRf/jv2SWC7xYcibZsOiOfWn9DZ7eLTMjEUszhX+Pg7q3nAoVWfbifWevMTQmfaCGILlDsBf/Upysir7p8WbZbFRKciE+RObl0e7idBNghlbhYytvtmM8o6VhCll5TY8+m0+SIJHgYdYt+mLNtB7RqVlcGPvGsn/XHuOmmt/89wjVmNGMqXdnD5qCUIGdXZZyOW7pVT0SOfq19qljmTU4bvr8JXuJGYq+z7rvrto0QHvup212x71dw+slw3J9zoGz+Z6n7PaoEREwTVe4NO7EPTGQRo/X9gM/eFcOcNX5BMth1UmM9SClpfWaiC0WYlyrqwHToDGbruxdVOzGGbbltnd9nLrN+DbjRl/clDLd9mwBRShEoW+qyUr30Fs3GZbrvmAx5kmxYA8O5OIrjiycAlLGw+VdjgYvT78=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s9dZTlDCV8kdkiUx75unGN4KEYutf5pl0lOwDdXrVetDXx0Cc7orutDNUKay+3LpeYGXbVTEqMo55RRFBjbdjDB2JebrN5iKbVVNxWcHvJNym9ThwuUtIHnxmVxWrZKg31BVf8VsvAn6OToB1uvD20QkKp/bJbqrS+kZxPwx+IHDhSMCGabjsHX5/mSLphCwpjIDHNH6dj4y71md7Wa8rQxxNpv+mAoE12hFowbuU2eJoNUnAFp90JLxIdGeQdhDyvE53V+1lXSzfjn5D4ZANpDyzz2IduDq32LpG7k5/ofyYVIVIOvkNSUazVgu1ifMx2tqLE7hde2aDV8SWcMKDeQwXyxwOtJ9Kxj1w8bgr7qk/VxHeZDsy1dX4KVrGT0K/3oJKNzBdycfpkKK/a6wcFpObxPfUYSTF9RRpnjpeWK9XhDqqqcsEYNMgt4vmbij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:42.6540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2323a3-68eb-4e5a-6efa-08deb0fca1e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614
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

From: Ray Wu <ray.wu@amd.com>

[Why]
mutex_is_locked() only tells whether *some* task holds the mutex, not
the current one, so the existing ASSERT can silently pass when the
caller violates the contract.

[How]
Use the kernel's lockdep debugging utility (include/linux/lockdep.h)
and replace ASSERT(mutex_is_locked(&dm->dc_lock)) with
lockdep_assert_held(&dm->dc_lock), which checks the current task's
held-lock stack.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 857c22007743..1324b55c403c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -459,8 +459,8 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(acrtc->base.state);
 
-	/* ISM transitions must be called with mutex acquired */
-	ASSERT(mutex_is_locked(&dm->dc_lock));
+	/* ISM transitions must be called with dc_lock held */
+	lockdep_assert_held(&dm->dc_lock);
 
 	/* ISM should not run after dc is destroyed */
 	ASSERT(dm->dc);
-- 
2.43.0

