Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA25C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 06:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BF9601FC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 06:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2BF9601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288BF6EAA8;
	Thu, 16 Sep 2021 06:19:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DCC6EAA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 06:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb/6QPmaIdE9UGb23jFo1+fMCbAerNhD0oKz6JL1EFLZzcXfmxAQ7oPoltlwnrcFV+GU0JmeNaRj1bZvQ7n1QISRRbcjPVgYdeBXFxoj9YHoo3Q+RGRscl0DSZ5Qy3UO8U0yOrpMuImrVKqH5GUm9lcj54Wtk85NzfhsenQSGF5jgDrhnPP6gav2t0MM+GCXXR6lOMC1rsBRfEkW6lMsNN4k+GrGbG6tifQIPaJtxYmjxABAdTQmaZYsi6xUJItNASjgZo3Fr+w5jHHrxHYlGiOV3G4EIKRaRqAgph/GpHcMLTfIzDBEd5cNcpN3MnIZepPwpi/7/Jmff+WVdOAtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=T3cpaMSBefsCZgklkXQQyPvdmEl9qjy9AVvK7OqyXBQ=;
 b=H866ruRxnzjC624P7E5C05U1ScCjv1N8/XsemvHqrBQ11F3FcAFx3A8hvxfS9f+Rp3WQsrrLWVk0QRsn+WCUDPykU5ejp098TSbxqITW0I0mWfsnBF9ZCf1et459p8VFEE1chrh6a5OPfQynzmSNjXQJD4FsUMKqvopoVU8schfoRplRu3tLDODVAyIEDVv6ruMvbRj2SgGZIE6DPUa6t087cba02TRAONvVofs18hfVUkN023eE5wuaNF/9TT2O4zbQNkRr0s3uMMIMv3O5/ZrrDhqdZ7Ridrih3PVHKqJZBt7+k8ShwQkTZohbF/K0CKahzhHg37UGGoMjGmREfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3cpaMSBefsCZgklkXQQyPvdmEl9qjy9AVvK7OqyXBQ=;
 b=WDRhpxV4lFMywnXBEK/cUNeXm73en78L1x6Gc1bxGgna042xQ0Djt5EOVVJdG7ikaWhXXhBOyyWDRfz9ho+jZJMv3E7lPBl6yR6beY3OGxS0fWeduc0DnChXgXZxQnWvgG99QgcZhhLdCFggsDflAmkEpSWQhTnLycplLJg0nyc=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by BN6PR1201MB2545.namprd12.prod.outlook.com (2603:10b6:404:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Thu, 16 Sep
 2021 06:19:23 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::2b) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 06:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 06:19:23 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 01:19:21 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <leo.liu@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix uvd ib test timeout when use pre-allocated BO
Date: Thu, 16 Sep 2021 14:19:07 +0800
Message-ID: <20210916061907.12347-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ccc26b3-9cf9-488b-54db-08d978d9ed43
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2545:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB25457A5CDE6EFF42EEDCF33F87DC9@BN6PR1201MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9rrehCG+J7WagI/I/gFxd4qKryP/qRzz87JMxZ9UOgMV4RpHCBCbx5mKZcMch/hnbpjJspCNZr6fo1imDIqWNKx3rr8hX0Kkr/n5uPe7UsRTXNnhSc/HsmFIzoCW3/wq/cMnJZC2nRfB2zJzsdKkET+KstGQZ/jkP7dhCYtGzch4HYMF+yY7qjcAiqYqTNkgA6tkOhkOwkIN0jrU9f0mppqj9ayB0DQGQSr3sLqcD0NTtWAsLjiPUN9VO98M9Fspp0MpvxGr1EN1hzcu0prSYzK/XdL0nsqZoG8lpBBfBmRiUlURl32E40IW2tdVabSELfA0pi3uKWArSrbHzGMP3qQyjULw5+9cdgNPmtAsvDixixQH5Fb+BBewzwhxUbEpiUOCH0TFlEEgWKkF1BnvrHqpO7rlk5OY6I+A4C91oav/XRAwnVoGc7IjUE03wxbs7CrFC/7w3EhsfZYW8mwN8YVkJaHUX20CRDu+FOpSA697AG5Sf8qDzhG3l/CpQisKojrDDQNuKFkHiaBZ6UP3w8m7Nbv9fdKTs0ZZwskek8VjqWwaIrvlCMOILS8lRsr+JoWPdJ/jNkLCDyyjgYobqCY/mWR1oJQ+TLUTUqYFvfLwhbnynSjTzHp2aVpmZ2m/ir2SnAZkYfptmvTtXMaESz4jkl4lfSTecAzmg6H+Nct7QSMnI8KMGK2yPJ4WG6sCIzvy6DpJaqJHkRbrI6DmEklEkcDd6/PZwHJsKBWAvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(508600001)(6666004)(82310400003)(7696005)(4326008)(426003)(336012)(316002)(47076005)(8676002)(36860700001)(70206006)(83380400001)(2616005)(8936002)(36756003)(5660300002)(186003)(356005)(1076003)(86362001)(6916009)(70586007)(26005)(16526019)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 06:19:23.2615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccc26b3-9cf9-488b-54db-08d978d9ed43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2545
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

Now we use same BO for create/destroy msg. So destroy will wait for the
fence returned from create to be signaled. The default timeout value in
destroy is 10ms which is too short.

Lets wait both fences with the specific timeout.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b6e2abf26e18..8a26459bd80b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1336,10 +1336,17 @@ int amdgpu_uvd_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *fence;
 	long r;
 
-	r = amdgpu_uvd_get_create_msg(ring, 1, NULL);
+	r = amdgpu_uvd_get_create_msg(ring, 1, &fence);
 	if (r)
 		goto error;
 
+	r = dma_fence_wait_timeout(fence, false, timeout);
+	dma_fence_put(fence);
+	if (r == 0)
+		r = -ETIMEDOUT;
+	if (r < 0)
+		goto error;
+
 	r = amdgpu_uvd_get_destroy_msg(ring, 1, true, &fence);
 	if (r)
 		goto error;
-- 
2.25.1

