Return-Path: <SRS0=1siV=OB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E2C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5230961209
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5230961209
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709C16EB22;
	Sat, 11 Sep 2021 01:55:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93586EB22
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Sep 2021 01:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8y2l/2q72Jrxkdy962kE9Adv717pEu7OVFCaZUtG3D+jG7ZmlNSkU/DqOhG3Ji2aSz57JipbF1y4D3pWg9KTnMQTZfMUF9USRrFXXWUxQxK+BWeSOKgSN4aOgMEDwgsoaDuKwCg11eMFkzYdaS2ntZ7hCCPbRvOydUx91Mgj6SNE8OnViDweE46Zq2a0PSV6CqiV+Wzami2G/SxVyjut0iIpZPBeXsSeNRfSzffxgznPDm9MpRwol424ZR0H/nBE+wm9rjoGFOV4LCGP8BhNFsod5Uosj92pJvCUCRfJnoGKTObhcNTBCr68c/hMy5a9xZTMBV417EVWRviAFgf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eURG9UqUdoluv43XSeiHFfBUqvbBF/PZmKNh20RHa7s=;
 b=H9O/Tm2VbFL9ZIF9Yq2rV/1DFZ2nQtOkq4l+UESFBB30rgL4YRl1kfUfD7AqTmO1Zxz3r/qDYGwD/Pm6M5DQFuknVRzBZqw06zAD9Tza+Nnb9Cnv0fFcMq+hmVk6fIqybMkbVJHxsSUmCDbOtYS6SfSnJIR/HzWunOHe1q8KC28sw5vsPidAkIAHaTBxRHljTk5azFis5Pg4zFOsrnlQITZjQpIikZK4b1ugVPxrqm0hygyuO0m5U8IL40KgCewaPl/honobmF692o/vA0ePGj+GxGtJN9ONwfSqWLNTd3E7rXViP63JoYKL1g/dLeGEolbOO0FVPYDSTS/jQVBesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eURG9UqUdoluv43XSeiHFfBUqvbBF/PZmKNh20RHa7s=;
 b=W0WQT7RYwMX3mEjpv2uwHZSa8bMPmPNv8RObrsqte7MinP9911p0pifcmUjGvcS617T28gBWw2u4fM0dsrnEQU+ahbNQIyXEdvuB5sw0l6o+D/5138w61z0EKm6sfreP7iWDJ0qyHG6sJY+aUQzYEGWE/8QqWy54Xfh9//z1/zQ=
Received: from CO2PR18CA0056.namprd18.prod.outlook.com (2603:10b6:104:2::24)
 by SN6PR12MB4751.namprd12.prod.outlook.com (2603:10b6:805:df::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Sat, 11 Sep
 2021 01:55:37 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::82) by CO2PR18CA0056.outlook.office365.com
 (2603:10b6:104:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Sat, 11 Sep 2021 01:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 01:55:36 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 20:55:34 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix a race of IB test
Date: Sat, 11 Sep 2021 09:55:13 +0800
Message-ID: <20210911015513.3822-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9947418-607b-4fdb-b9fa-08d974c73f9f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4751:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4751EE6584A24579278EA77487D79@SN6PR12MB4751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taN3qIu8PtJwfwYo144x0oTjrQVzJzVuf5+6Xj0aQBqHYBR65m0OvWBWg/p1ctcmKWRJrzwgQHLdwyJ3Y7RdmJ1eO6zWY6QSlfn6o5YQUuWxUi7M1lgE/SpnoPIKJHs+1w5pfC3WXzOsK+PrF4Ys+MAbCMm7n+JLtwTLLa+FEvsuI7dhZliIPvmwhtnrCwf7fzDXJ8vd77LP2eZvUiSKbMvyGA+soGDlweocAh8JzGrzjZRlsl6ftfRvwmqSr1bG590Cmh3SdmWFQkZPq/ab3z6FNog+qo3vvP7yi9c0BE723nnhq2gE4zXgK2YFHJmtzMprfmrfs9wBr93whVOsjpHsI/TlJKSJ8P9T+ZYzWam8nHwwsebhnSIKIkVEIYliQOSoH4LHTnW98xjo1QMJTBqdwpsFMv+T5img4dF7DPZ1OOHq1zg7K+LPJNpdG9++63aNvDphpr9LCD1Q8lPQ8zUybh1Xx5q50hKUeJmUdKiRoUYYGkGa9XKwSrer4TgqYlhZBeTT3Jz8wCfhiD9FcBtJjL5pVXtnDd4eULdMleoEbd3pzjqnPdEwNdJV9+zT1DZDm3kPoto2oJZsyD3LcjC2DS/Q75BrNn0zbQ/Cj+p2/e9H2FF/ztmj4v/yjY+BCVI1hY7eLuqkz5nmMjWhInArfUiRhVRqvm6RavdrZraB+3gt4V9L11MnRAF+JiWHb9Y/NuuClsl1l5M3tIPjlPoBvlhPMrqBJ6cCkVkOfb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(316002)(36860700001)(36756003)(82310400003)(2616005)(478600001)(356005)(8676002)(47076005)(336012)(54906003)(186003)(1076003)(16526019)(70586007)(426003)(4326008)(6916009)(8936002)(82740400003)(6666004)(7696005)(86362001)(5660300002)(70206006)(81166007)(2906002)(83380400001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 01:55:36.2563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9947418-607b-4fdb-b9fa-08d974c73f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4751
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

Direct IB submission should be exclusive. So use write lock.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 19323b4cce7b..acbe02928791 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1358,10 +1358,15 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	r = down_read_killable(&adev->reset_sem);
+	r = down_write_killable(&adev->reset_sem);
 	if (r)
 		return r;
 
+	/* Avoid concurrently IB test but not cancel it as I don't know whether we
+	 * would add more code in the delayed init work.
+	 */
+	flush_delayed_work(&adev->delayed_init_work);
+
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -1387,7 +1392,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	up_read(&adev->reset_sem);
+	up_write(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.1

