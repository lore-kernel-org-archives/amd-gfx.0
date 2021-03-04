Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C91C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 20:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FC464E6C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 20:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FC464E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27706E108;
	Thu,  4 Mar 2021 20:09:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7326E108
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 20:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiwEkwfdMN+0lQzbO11uPJVmlDlDpHKGkKgc0tYgsv+vBVSsXkeMtZyui+ASEl5WDM6ZbOH5uQ55a8YhYxGbUwZ6zOFEvP5rU2/ANKC7NoOcu+WlOpOSp5GORX9TMZFthbdOYe+XUk9qZKLFEZR+Wv7CDP3UoJV+6RIuXgf4xPzBo1KJCtjv1GJS3fAyJIo3IPJE8HzkaHZjNzbsXncf0rrygICqxNsGpBegQHmn27b2oKT8cP48R7fNewr0MVMLNdDz+sI071DfA7eII+lSqo8GF5n8TvK0BTkB1SpOgN0GmflWgfpwQCbQtOJGkA+KoTZqGrecFGicc9yrH36opQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQriLB84EJP7zGZ7Rs9Oua/r2D33yT9vOS60kgre3Rg=;
 b=nXW4VCTGCccPF1wo/6Nm3k+JIMhDnqtnFzQXJERmQet404Fwclvk+tteC5w2mPSKTio1dlMgqrQdIewR3H3r2IR+YJndAJ7TJ0IkD7My7/FpDRqtZj2fJtNB3N7tc8V/7TeOZPT37PPD8k0A9CWIVQlcNaoLpnDW8EqyCs1nyvDlFwHmKUekWyy23dVRpT7GZga98/eYZFL+UrTfzp96RU40m0FIOieR1wBW4f5KwoMi4m1YddptacsSiHdlFXBH+Lm97lGk1p9eyA7UFvvc7mKhKqiV3o7WpE4k3DI1Hl1+afQS4GZfnkwKmirg2U9oDsamx9IuZuROh7Y4Ug3gjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQriLB84EJP7zGZ7Rs9Oua/r2D33yT9vOS60kgre3Rg=;
 b=Y8SBOyP/iHhS0M/Nx17q5IBiqdaiVc+cG5hRs8V3d4QZKPvzVsHgI+orVV1bsRriMndaRjxmM5TL6ms7R9HhV5FbMWHYB2WMoaB3OTgYOoS1XlcxnbBNN7gGbRZwWbwI4Btp94XmjJ/9fgpD72gythCoqdv8j8cps55A5a2WiWE=
Received: from BN6PR20CA0057.namprd20.prod.outlook.com (2603:10b6:404:151::19)
 by BN6PR12MB1442.namprd12.prod.outlook.com (2603:10b6:405:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 20:09:16 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::aa) by BN6PR20CA0057.outlook.office365.com
 (2603:10b6:404:151::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 20:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 20:09:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 14:09:15 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 4 Mar 2021 14:09:15 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Date: Thu, 4 Mar 2021 15:08:51 -0500
Message-ID: <20210304200851.4937-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc512471-d7ce-4282-2e72-08d8df496321
X-MS-TrafficTypeDiagnostic: BN6PR12MB1442:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1442C186CEEABEE4EBF419C2EB979@BN6PR12MB1442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZx2LEHwv71zO1zxPk7SKTzVRtDwL6Rknxo/HjxInGkuvoMSaLpuW0HgRyLwUURrXQikX4caw+7VhbBP1urpQetIM/8U8vRyBM1KQeRvR19DdQJ+vCPdhJwxb5ZdBnpwmSAGwZwDlZ01eMdT5m1moEEobnV3JNXXLq4QE4JQXxkf4bNRK8RbVYTND3s3NexuTkPOKhqp8Hxdw7RcpQUY/dsXaVv4DuhkCKtYLal6+OhwfC3oApNhvFK6XuORmgcQb9Aj6K2vRLKebkUohPlP1nR/pFJ+JxmHzQAOy9O3grfjX4VfqW5CwxKPQefWaEbYla9Ybtr4GUdjs/ZmuocFfXBg2JQKtB7jofyCFO3INUCvlj4fWNTHOpmTKIDAGgdj1+Y28g1AsMokoVxdIaIwmSIHxyCkHofO4+Pf19KWvIGziDgQtq8Y3V2opOmebD++CW/jqRMxghSwDgzi+1GWieMXQr1axd2fCJunuPuIcgMvK3Z/yO2pBOZ/NraE4RFX+XogPI/QJbaaA3P+tVJ0O8583l0t3W1eBPTpck6N56h+QN5ChiVwCvDaIjzkdOm77Et86W0wsd37/FQJFdTTvcOZQ1Ln0XjD+cjw6hqsHfSO3Il+y78Z4fXhVJ04dIBQG/xKcFFkO3EJ1sRbWhV2pkEXGwJgWJPjAdQ7HUtPKgDem3j8d+zns2TZ7ORf7MbtHtvSeoEIQao1LLs9ZxMSDhm12Ur8sq7zCdLo1a4Igmg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(5660300002)(36756003)(70586007)(478600001)(70206006)(2906002)(47076005)(6916009)(1076003)(966005)(36860700001)(86362001)(82740400003)(82310400003)(8676002)(81166007)(4326008)(8936002)(356005)(26005)(336012)(6666004)(83380400001)(426003)(2616005)(54906003)(316002)(7696005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 20:09:16.1201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc512471-d7ce-4282-2e72-08d8df496321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If get_num_sdma_queues or get_num_xgmi_sdma_queues is 0, we end up
doing a shift operation where the number of bits shifted equals
number of bits in the operand. This behaviour is undefined.

Set num_sdma_queues or num_xgmi_sdma_queues to ULLONG_MAX, if the
count is >= number of bits in the operand.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1472
Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c37e9c4b1fb4..e7a3c496237f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1128,6 +1128,9 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)
 {
+	uint64_t num_sdma_queues;
+	uint64_t num_xgmi_sdma_queues;
+
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
@@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
-	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
+
+	num_sdma_queues = get_num_sdma_queues(dqm);
+	if (num_sdma_queues >= BITS_PER_TYPE(dqm->sdma_bitmap))
+		dqm->sdma_bitmap = ULLONG_MAX;
+	else
+		dqm->sdma_bitmap = (BIT_ULL(num_sdma_queues) - 1);
+
+	num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
+	if (num_xgmi_sdma_queues >= BITS_PER_TYPE(dqm->xgmi_sdma_bitmap))
+		dqm->xgmi_sdma_bitmap = ULLONG_MAX;
+	else
+		dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
 
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
