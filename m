Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6A6C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C41110E52E;
	Tue, 17 Jun 2025 08:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAUt3u8W";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7631710E52E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH2j0sdHy+7ZPVCumwUlxLjQkeKX7PREIVDCGTKX+9+hyKJnKK9OwQVcbjBYjH+RWYvYc3MOoxLSaVXEWmSafp4srpnTORbqH/6pkedqNeco1bLeIJKxld1Lcrsg7NvMDrpgwjf9t9wPtpDXTFjJWwMgRYXkpqE1mC6aFXJYAQG32WykVaJX+SeoBzBL0TcnGpZu4rMCCKSEGqe6gfdwxzpC8dkw7rEy1/HwvnOxlf2+v1BbpodrGqJnsuWuNdiG4ZwzMRGnVASAalxep8ty/AUwU5pBtgiMIUnxvu/UJcllmqF/MODjbjG05kreFd/nB6IC/7h0it6qNm/VlahMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC3EIhEzQr2XRMfVANXJm9TArPciGx47cPIXnezL9Hw=;
 b=kSGYJP7nvYI7i9Ek911U1jRROW0tad4D6tB46IkOm6qXKUSs52FIfbeIOwYBNeoNgBhCMLiUnnE3JULtU7Gcwip7tYWRsISx1PTkwYwnkHjcYY5d2fqth9SjU16bB0o7BTFYTVvmv7MUQyw2b1/zg3g73UbJOuyRtksUspe8c3ZWyY3hwcVBCefZhxZaiEOIXO028XrK1dsQbAjhOSZYbfUotM3I8MILUF93VkLr6cMPZ9bRKw8c5M2m4mk5mmgFfnq1ltlY+4w67pG9EiRRcoW0UkaxaR/yzpuo9UDEcSkvAB1S5+rhLpiXPm1BYb9B6I4kDqAGo4dVuIOWhwUy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC3EIhEzQr2XRMfVANXJm9TArPciGx47cPIXnezL9Hw=;
 b=uAUt3u8WyYsS88Ds521djnPD9sDUyjB0q2csbkBykdlQrI/K0msaU2/QezQOYnJDzJusCEICgVvNj5w4k4v1ayejlpUAdS7kvxZ6fL0ZdzekRTHWKbcHj7jINwKpu1rs2NXtbilNnyaB/9o9Sud27rJn91g4hu9jyac2wr0R8Vo=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 08:02:29 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 08:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:28 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:27 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 11/11] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Tue, 17 Jun 2025 16:01:51 +0800
Message-ID: <20250617080151.1093481-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be23bf9-5bf0-43f2-c59d-08ddad754e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MnRhAeVbo6bcRPDOIKuiQJLc4aOGsPmQOwizzM2F2PYBWxEZgjYFdttL4TkS?=
 =?us-ascii?Q?XPHGQy3ZBtz4LW2wapZm9FX+6sUULR1a76d5yqw40iNrW4wUiNICkl6O6V7v?=
 =?us-ascii?Q?uhe3aeq9pkomYSb6nTS3ev2f033mabFpe5hCnG3z3LVutorKppsAE8yO6gal?=
 =?us-ascii?Q?g5xCtJT6Z5/f4xnFhbAPyNuea8zPqAvtHzrlIfP2lbSZGFmwMDIu4HWkuUFl?=
 =?us-ascii?Q?tM9sWqzZ+cIE6ppktm+dZkbAwKrI7Dp4XDzusdEYWG9pa5pFBgSVyawo3Zsn?=
 =?us-ascii?Q?nxHdNnvTTfRGifdYIcoHRi9JCoddobleNC7JYyQCc+HUNAG1Y1v1JzRfH+T9?=
 =?us-ascii?Q?lUZfRrksG4pyD6/LZpSxoiCW3KhMuAeRcjJp4ezEHHiwSM3KmUwStxp9+E40?=
 =?us-ascii?Q?PoDTcvIKYDnKNlc8Yxz2lQHi9awhpysyai86N/7hU41CzL6L4MpxOTBabiCr?=
 =?us-ascii?Q?4MOD/5RZzDZ1TeqoJq6XtoEjksKlyw3OeRYOqqrq8XGUaIYDvLMybC0nz5Nh?=
 =?us-ascii?Q?i8gf9gTbOKNAerFA5TaNPTVXV3LYl3LtkbtbGaVDCCE1xcpRMnpsfqeRtWlp?=
 =?us-ascii?Q?vTiZxOQV327z9FDu8zQcakRLwSF8yQsjzmNVGAQob7dRz6RgUKPwh+zvu+ny?=
 =?us-ascii?Q?MNhxEaaLoRhiAHabdQzgm1SiMod0nhcI/+JN2XUAKbKgwJ7ToaoB92MU8cME?=
 =?us-ascii?Q?dQu9wUuaxyoXroGMyFDvMNwR4bsbNXRwi3bXCUv1OQztl+Pltepf6sHymV1c?=
 =?us-ascii?Q?E7vxxLUBFYsDyeUNfa7c653fD9RDtO53KGdSaBoOha99WTSVyRK0WkvxttrY?=
 =?us-ascii?Q?aRdnZi5zRch68DW9Sj6ZOO7qSBQSsymP1X/CJcw19k8UHlO5r3dV5E/JG9gQ?=
 =?us-ascii?Q?nxbhRexO8f1TdlJBLIT/9TJ04ykH7BoJPclnkvFaKWQKuzuRwcKppPi/oCLh?=
 =?us-ascii?Q?FeIVSPmbpWlda4nXwICutObQ4NIM8RiZoY7LQu70+QsIlqbcUX8oc2myyvmE?=
 =?us-ascii?Q?MZjnxnO42BDl4rynE/veQP4miMklH+X90I314H2eh+ecUCmSjJiGMIE7TpCO?=
 =?us-ascii?Q?9Pca/DYdpfG4VHQWQGwK46xLF4qF25tv+9jgVx6U6aDn93LzAyDB/FAI8z0F?=
 =?us-ascii?Q?e+ZYvZWRpAUlebM34Yfku2NkD/ssN1oS7U1XGNpKc6VcCL/6NptBjfAB8dDL?=
 =?us-ascii?Q?Pswe7FHPKWKHSm63hIORh+VPZCxm3Y7a3HeVimfr68KcP7bjt6dhIn//iTqV?=
 =?us-ascii?Q?2Bb7B6fH83md2MdCHmBbbuSUJ2s+8HsruH05to6HLooTZOTuEecuR4Oh4Hh9?=
 =?us-ascii?Q?Pve7dTo/Nr75LkMFODOjlUWHAed/1FdIVLe8i12j0B4Ymo4iLfbvmglOcBPW?=
 =?us-ascii?Q?ofzoPKls0CJxI6y4TGIzcLlGto3Ymvct/7AzlWvlBimWHXpGRrnPD37ME4O2?=
 =?us-ascii?Q?WzanYNyNs5UxWI39+8AapObrf9xFlVwtZSp0JxI4f1wwELP9vxVbVGi8dd2d?=
 =?us-ascii?Q?Y85DYA+8cWqzEazAWU32CAgrbATxXXQO6uRC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:28.9465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be23bf9-5bf0-43f2-c59d-08ddad754e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index be3220a973ae..f3028f344bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -258,22 +258,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 7e532ca0ba05..929d04c70971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -118,8 +118,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

