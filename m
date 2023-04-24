Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A5C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0527E10E57D;
	Mon, 24 Apr 2023 17:39:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C8110E5B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWcAZHfG+7WjHHqdG9Xqt/wydN/0rCRxHFX/EAJPFoF2n92/iGsbzeqHSWtLfZkgCV2TXH1KFEf5cjx9qY5C8jIJ7fZguzhyVrL3YtitAQ2j3X/nbmUGYL6ZKGqdqv4T8+/aAKBVH3wEnt4jTKaMyFMVTK40z2qdEi3IEMPD4U4jmi4vlIL6/NhdZ7tbgN6IXkv2rltXKxnt398+dbG0nce8qJtqLxtZyJtIEcBiRK6rUI6bScPw8FU2cRXGEzulrDuD3869rbE0/YPZxBeyN/75YpLUN4ukfCO+9n1JMdVUPrMxAlig75LBGrDBz5jgatGj1GQzg4JcOr3fgRNHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkAMoMnpsXD9qBJjIuncVCoMfTsmE7U77Z0YtCbLpbo=;
 b=nEckwVdwQwGo1xkg8/AHxfAz1iYkekXmMZ9Zfmcio/zkN0DwbeZJogrYteC+iXkWYhL8olAt0CaoYrIGE7eK7NiHSvlWsBVb29iy39W092UhN22SwgjrpAjpHu+RUWSyWhFGN85z5IBHUB3lpeA9lWtBkEUAr1G2XheXuKineoDUwokQRW/y03fENQ8DCjI/MtvY+h3j2HVWsoG1sYWwRQwnuoykRDqtXgIBLBVObPBKuKP0qBMAWHplN0ZfvMmRb0FnOi2FOrg89L8ipWr2OWjX/FRYBA9pFKoAzucxC78B7VbVTppHMp4mKe8qQp1mLk3TRp4WoJ1tzGmXYrVndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkAMoMnpsXD9qBJjIuncVCoMfTsmE7U77Z0YtCbLpbo=;
 b=QUH/HV0UUbtOh5XEYalUkA2jsBoPJMUuIYDhGhe6DLv02qFxJI7MJZHp19nGwjoqs5yNlcBYt6+KBkBeSnp8CYD62Fp/94LQO4kRTH5Rw1EKa2XiEQ/W5l2gyRtpcE5ADFAqUPt8RVZiHcKR1McWiIrcCwTOwYVaEA9HNiETUKQ=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:39:23 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::fa) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:22 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:20 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 10/10] drm/amdgpu: cleanup leftover queues
Date: Mon, 24 Apr 2023 19:38:35 +0200
Message-ID: <20230424173836.1441-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 3946b0af-95bf-4f02-466c-08db44ead769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNY08NHRNXZO6n0ub7j5uz7I3ekhxYpdCMEG4bkHtflREN7oQXz6JFMamAHmnqZZ/fWaFDmaaQ4q9LGYp7XmCTtxe1qGAqJPKelF7H59xP0iYOw1HqJN7TG1IGV58nE1ESEFTlApFvaa8ZWutTjRtR1Fpx5Ts96bSQOuJFmwzuDtEWrwrR6r35P2LcKdDt8oJGYI7WQsL+vEEx6635Ophix/jpCRL8qtFgCXn7xOjNkpHLebupWeUCu3i1597Y1OxfQ83432S9BskI5fxFhrPam/36p8x+wG6lxnRA4i0TPkAb+tsM6b8XwVr+Id60ExrjZm9g1EXnOcUS/zC2FlzfPG8roucMM/ir6kA4hbWueWB5ndZENKWUbYLF9oW0BadQ/4Hg7owo0Qs66B97cRMhmN9U/gu8N34hesQYf00A2adwz2WQJNUtU4Idxwyw0wQvQwMrTd638GKj8JkZ1KU9tv3/G7cq2UG0KSU2vAgWnAZ7sIF0yqIsO5TiaUlTuNzFb6SpxKRiaiS2Dxrtr4bKXJYWX5s5C/Zxokl+B7hmNwmQPVoCLg5juZ17Pw3D4MMe0mEl5PRZ4ECfxqxKk3l35jKS++PeQNKNCqVlPFVppribL0DLsYPgmjGnNlA3+5mhFlcSGkMalFGq7NovApvPLBvZz8O6zyjO5jZYahzOiCcUBJXqXJCoxjdmWDFVw5SNkrP473I0KFjejh+14mPibBa0mwtz11OriGUHDU258=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(7696005)(2616005)(6666004)(16526019)(26005)(186003)(40480700001)(1076003)(70586007)(70206006)(8676002)(8936002)(41300700001)(6916009)(4326008)(316002)(478600001)(44832011)(5660300002)(54906003)(82740400003)(356005)(81166007)(36756003)(82310400005)(86362001)(40460700003)(36860700001)(47076005)(336012)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:22.8687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3946b0af-95bf-4f02-466c-08db44ead769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds code to cleanup any leftover userqueues which
a user might have missed to destroy due to a crash or any other
programming error.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index fbc9cb5c24ad..27201a0b1441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -237,6 +237,18 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
 	return -EINVAL;
 }
 
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+	mutex_lock(&uq_mgr->userq_mutex);
+	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
+		uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
+
+	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
+	mutex_unlock(&uq_mgr->userq_mutex);
+	kfree(queue);
+}
+
 static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
@@ -249,12 +261,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		return;
 	}
 
-	mutex_lock(&uq_mgr->userq_mutex);
-	if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
-		uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
-	amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
-	mutex_unlock(&uq_mgr->userq_mutex);
-	kfree(queue);
+	amdgpu_userqueue_cleanup(uq_mgr, queue);
 }
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
@@ -307,8 +314,20 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	return 0;
 }
 
+static void amdgpu_userqueue_cleanup_residue(int queue_id, void *ptr, void *data)
+{
+	struct amdgpu_userq_mgr *uq_mgr = data;
+	struct amdgpu_usermode_queue *queue = ptr;
+
+	amdgpu_userqueue_cleanup(uq_mgr, queue);
+}
+
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+	idr_for_each(&userq_mgr->userq_idr,
+		     amdgpu_userqueue_cleanup_residue,
+		     userq_mgr);
+
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
-- 
2.40.0

