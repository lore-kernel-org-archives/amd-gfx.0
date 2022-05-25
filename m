Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386DBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6F810E14C;
	Wed, 25 May 2022 19:05:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E30410E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtYmqX7LHQs8v+7+5bHH8JfdoCZOQ1Tpk/aIlJyvUwDMSra94RzCniyJ0gDO+rfZoqUaZA7JRzb8h//QRAYlIt4nipIygoTxe9gy8P4D/AnjqBrNEshuAWlE0KCYbMdlmFsCNjpB2KUwtRvRfmxnoJA8Ca4lJBilZKuNIoG5vAPzw4fzVH6edKfBh5duluzEyCE0b3hJzC+egUv+utdrmzsfIRCvKjN6J+09KGMe0Ij/vnUdqKUAmYavh33w26RgsYI8uv40U7EuUzISBSY+G0s23fgjNxZnet/F83Xl7JDpd5PqSqjFm4k6I2KxdqXlZ0SjE0GmAuNOxjn6cDu/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2McQAJ0/g5O1wwZSpzgqqbg2/bo7v5KmEIJzO37uVU=;
 b=SIGYW+eHgAE/MoqCscY8oUj/Z58P1SIT851BIynj6smDBt1/0VtO8tWVuXVsyf7kCrE4yBHOJHIx9JmU+FOh9bTPV9A8ScwltnrKHYiB8vGeKLCon8QzYUUqpT6pzUuwBtKAULGM7+0ZJMUti9cBb3zkRDGWmnZ+YAIzlgSGOq5LkTf3a5VbV897M5GlOaONMEYv9dMqbkbnjJAp0jOjj/V5Sq3oZAuUmvpXGdJHRteA8TZ+wj9a9z69ch/t1aAt8ATwqmurp+AkWHPPFLhrpEojefeHjEMrVL5+ExTCVvdz5UiKVpH3bvtKpQrUbiHajg9fnKm1w7l2w5I6EQtg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2McQAJ0/g5O1wwZSpzgqqbg2/bo7v5KmEIJzO37uVU=;
 b=pJT9Co5DyfpguFgEEpj+NQZwt7mtc2G8zJIt+S0IPlyCnVbGTxkgfuQ38GRzKb822VSIM9RRZuk7d1lqq1FGhuAXGTWcgq3xJ/AbzAD5swyEpustOUuSYhF3ShbEugw+1EApI5pceeQlVXQDrmwJGrFuvTf4GhLbWS6lfGbUfCg=
Received: from BN8PR15CA0059.namprd15.prod.outlook.com (2603:10b6:408:80::36)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 19:05:10 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::d7) by BN8PR15CA0059.outlook.office365.com
 (2603:10b6:408:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 19:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:10 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:08 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/7] Revert "workqueue: remove unused cancel_work()"
Date: Wed, 25 May 2022 15:04:41 -0400
Message-ID: <20220525190447.239867-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18607df4-199a-4866-1197-08da3e817d85
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB47988B35CC775A3D78441CFBEAD69@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJAdUIKfzG1FR0ByIuyIDPZRVaEWpNnaUcNC1lMaBx7WXDSlMlW5H5/h4FNrUOgKGNongNxMM9veov8/cyIU6IGwLn7vxyJGkmGH556kwkK/qLj6SirlU4ihsYu2J/5iePzxMFKlu/CObEt8ROUcDK5n6TRfxvExx0ecRRT1xo5Gp0GEC6He8gpheHz7sz8t7251UXIT4MzSE381I67psYzROjmMdF0UwP29r1UDJsV/SptfxHpwUDPXFkfS9ZMRBeAgGC2F+TWN0yB03C5d/RTBkXiv9kucS4LM9l2fxHYsqemcd3WACS17Ovo2ggmP82Pp/fOvf9cjBgiJpN9S6Kd5U2/g2eTHV1Xu8HHagyXi58k2av8JRhMwpd7Bkn2Qo7ERP3BMI8+3FchfCBMfzoQ/cLwWJ55eO6Z3zZaN/TdU5lRyU7YOfbpXbWesq+WQtRK8fWGRcYtgochf4mxpzNlwPx96DLy7L4+nZAue5wuVzPdOS2ClhYX+8J/9X000vM1in/pYbVJirS3PrnN4nwaoSt9HTN7e2hA2Qh4qD6oFZn2N/Tlhn17qE108JAfjODVV7az2LyZjB6vvGmaIVdX46kFgWuSfJwes6YrrE4YK57xKxqoqNkWTmGiCKnAiRALW5O8xobiNwqHja3v+RmmpL6SunY3JFJZGw+WvE4QkQhS6mkilmdvwi5klc5/beQNdntvCZTkCuNy53BfnTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(508600001)(54906003)(70586007)(316002)(2906002)(70206006)(47076005)(6916009)(82310400005)(5660300002)(44832011)(86362001)(8936002)(2616005)(26005)(4326008)(8676002)(66574015)(36756003)(81166007)(356005)(36860700001)(426003)(336012)(16526019)(83380400001)(186003)(7696005)(6666004)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:10.3297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18607df4-199a-4866-1197-08da3e817d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Lai Jiangshan <jiangshanlai@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.

amdpgu need this function in order to prematurly stop pending
reset works when another reset work already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/linux/workqueue.h | 1 +
 kernel/workqueue.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..9e41e1226193 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -453,6 +453,7 @@ extern int schedule_on_each_cpu(work_func_t func);
 int execute_in_process_context(work_func_t fn, struct execute_work *);
 
 extern bool flush_work(struct work_struct *work);
+extern bool cancel_work(struct work_struct *work);
 extern bool cancel_work_sync(struct work_struct *work);
 
 extern bool flush_delayed_work(struct delayed_work *dwork);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 613917bbc4e7..f94b596ebffd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3267,6 +3267,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
 	return ret;
 }
 
+/*
+ * See cancel_delayed_work()
+ */
+bool cancel_work(struct work_struct *work)
+{
+	return __cancel_work(work, false);
+}
+EXPORT_SYMBOL(cancel_work);
+
 /**
  * cancel_delayed_work - cancel a delayed work
  * @dwork: delayed_work to cancel
-- 
2.25.1

