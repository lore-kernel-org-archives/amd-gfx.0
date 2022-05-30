Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E5CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 14:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E8C10E7ED;
	Mon, 30 May 2022 14:57:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D2210ED81
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 14:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsBsnLrO/6BEcdI6u9x4fXtU3J1he9S9nRrVnwavedJAiHhCYZYSNJGIKXMWpz3qLjNithwH3ZD1FIoLzgCxxmjFMJ2fPLOz0Bpdo948ce4yGWqQOPQqlptcycxV9oWntL2WAcm2YT1EiJNraseg7PyDe23Dbj65fpOR9afd0qm2b2XeDU4qmsfkD3MEf1/o0NgDctqXU94e8Ezae2lk94iLIXpJw8m6WE84KrQrpuiU0lbwhXPPIkkJ/2ySxHxNNYDIpvCAvsVGHemL3OCUQdR+g/tnQHW6diz7YIJrvGs5L0Fr1WttZG6Drq1f0cIznqVcnWI4w2sT8wDTqwscMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG4qnXRyObYpDlFhDKAs1Xwf67LuxY2iKjQQ8RxLFBc=;
 b=Vu1agWd9rFcgisYJXA2WAl+1fq0XZTpo1RVpUPjPY/zgSwY5UZwmdDdelNfafGeb3sQ/TTFB3sZMp9+5a49Zu73iMxTNSj7alBolAGEcBV570oFn9P0mZ+zkYFOqlJ4JOCOnSkZ/rIU8MtIIEZnoGC87pK4Gx0CKrlFS9wy8HX2Xj7eh2L8UEXS01nXppohICY2RTGXvKXFpVQQ0/C+Ea5qYJR2/CzNiWpA8FWloSJ4cj+fePR/8PbBTBMbbBNPcbqKcmToy1NCCDWBXLdUOenlsF4P+xMlQmXmIxiN+sXbeLFaj+0Ah8JFjK5vX0mw1Hcl4hLVhp6qXyniGSIoTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG4qnXRyObYpDlFhDKAs1Xwf67LuxY2iKjQQ8RxLFBc=;
 b=j9jxeLcIN6ClXF8/H7d05y1FiXekCouy0eDphwAt3DDRfBtdfOCc0z3iBQkqDF4uHk9d1y8O0DMac718oNq2fEi42k1RDr7OQ7ul8Ul9q+0FxEiDMoFPEcMvqECbiXgGMFJqHKsniyjU4Dh16E46S8jsuQSXQXnh8tfunS9ggmw=
Received: from CO2PR04CA0184.namprd04.prod.outlook.com (2603:10b6:104:5::14)
 by BN6PR1201MB2465.namprd12.prod.outlook.com (2603:10b6:404:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 14:57:42 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::e) by CO2PR04CA0184.outlook.office365.com
 (2603:10b6:104:5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Mon, 30 May 2022 14:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 14:57:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 09:57:40 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Use mmget_not_zero in MMU notifier
Date: Mon, 30 May 2022 10:57:00 -0400
Message-ID: <20220530145701.3881-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a72d0785-6aec-43d2-5fa4-08da424cbf27
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2465:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB246533099963311E4BBA5DBDE6DD9@BN6PR1201MB2465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kleZ8qL0M11VHzRsBlQuGrcen8nKA7S/L64OH/SxHoVgDLszZgvWoXBOR9IT1dghLJ9CnNPrMDXrVafrIbj+HOwJArGwZb3IME7P0gxcvx8mxhBJQq24wr3kngttk/aKHYzRZrahEZY1rAEXw+X50zDc0O00ggkCXdvchWyhACFhrCiK+FH8iz0noJO8p4Q1ERl2izmQsb2qYuf7thTycCWaZfgnWW5IeQ1nVP8sL67OvEcMFN4j34mG7yyZasRdo2dX1JLL7AZ0Y8mBLqTeENknA7/TbVLOYorFGizw52iqCmOXi1NY/DQYtajDuak6tufn5Xr9UiJqvGdLjN+PNzr9Aw5dc9SwYZhPvDSA4npFBKH/Y4HgwUPpHojzzkNgcCO18EwN6PsdZgFuBixfqlQF63UTSZSbWhJ9tbmLaaNFN6X3TkX0zizj+w8Rr7mVYAmQAZBvV982GuyNC0dSPohieE9R+nNOrtOXERihB4AUgVbGbXh8ajFmrLTbbSlBW0TxdGwg538gKAwiNTYKrQ/eCrA6eoXFiHtzIaGLT4kuEMGENLafDCXdLvbWLbg1j5y7rXEI74YsiXuKiulQPQr/4Nqrw/oCd21UFh2i70Y4lBh3G0yjiElFald7w5uBZvDWg5YWinXYi855fkDQqxQauWg8Q1t959uKwsI4+RF2N3qfdN3k5gHzpRRIG3gwNJOMqfRYaGXi/vkF8Z2TwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4744005)(6666004)(70206006)(82310400005)(70586007)(356005)(8936002)(8676002)(6916009)(4326008)(54906003)(16526019)(86362001)(316002)(81166007)(36756003)(36860700001)(83380400001)(1076003)(7696005)(508600001)(186003)(5660300002)(26005)(2906002)(336012)(40460700003)(426003)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 14:57:41.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72d0785-6aec-43d2-5fa4-08da424cbf27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2465
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMU notifier callback may pass in mm with mm->mm_users==0 when process
is exiting, use mmget_no_zero to avoid accessing invalid mm in deferred
list work after mm is gone.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 835b5187f0b8..2ba3de0fb8aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2307,6 +2307,8 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	if (range->event == MMU_NOTIFY_RELEASE)
 		return true;
+	if (!mmget_not_zero(mni->mm))
+		return true;
 
 	start = mni->interval_tree.start;
 	last = mni->interval_tree.last;
@@ -2333,6 +2335,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 	}
 
 	svm_range_unlock(prange);
+	mmput(mni->mm);
 
 	return true;
 }
-- 
2.35.1

