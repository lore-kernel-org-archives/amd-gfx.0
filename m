Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D411C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 17:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C629C6103A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 17:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C629C6103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7499F6E42C;
	Wed, 28 Jul 2021 17:32:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CDB6E42C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 17:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxP6s8Z2I6yFNr8Ydt2NuqAxrZO0nK668bL+aXTCdCHzhlchu4DrqEj0wC5Yyb01ywmBnMh3mpTz/lGXzsUF1wQBsOllThDVZqNikchCsaX5K1vzkMf5Ocbz/g6+3ewchvfs2vD6KEta6lXWVOKXrBfoASeOFfF+oCjCc6/9Lw+5qu123dmK/F8gFAiZexmj0kuKvXQuD00wKS90ci0QOUxGc8uoudh42rZ/suPrcMMdUS89TP4TLUtylqpm9865A12yMfcdp4DEXecCPZIVaWsIk/SyBFWpkGd0q0sIRGjuSmfj98vijlQ1wmwGFr6ZBg45OWeIswcano+u5DKlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6INm903h8BfekHfcfrRH+vUgQdcvA4lJ+6Uh80BZxP8=;
 b=Cz2qQQ9eW2VDz5iQvZH3qDYymy9WvoUPxrV0m4IHiRcAmBhEtRt3s2lvftk49xvd6Cgz38x8nMk0sRqm7/QIqxH+t5trYb++bjVcK9xoz2kUB83B29wODXSfL3JfbI1p8QAt6IPf92beNeHTjG3yUd3FdTnSd/TryNbTZXjV03Q3EBIy2Jq9eS6yxzEwbDltG6UAstDPNES8RJkLYkp7vnYVbEsTrfAQpvFilVE3IA29Q+5bPnpwZsz7L9sXd0urP/Hh7ZeXn25lYQfrjCViM4eyrwC+KgQVZLaDnVow4kY2nZBTWvlXz3w7VcaUjlD+J33nHh13THMvZrm2PkCOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6INm903h8BfekHfcfrRH+vUgQdcvA4lJ+6Uh80BZxP8=;
 b=o/8f07qN2ft5x3m7sUw0hi9eyBr0zoYDR4DJAuBm7WhjjZQZzHK5WRkFguwYwcjGBJSfUZjF0t1TpXfn/OngiOhYcIYNWCdIy7/tJp/W/QAPj+Yr28cauWErQQW/Ki2Z+sTMJ93a//6N1T6OMWFoUnNbFFD/MpqCaBcJX/PV6xg=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by CY4PR1201MB2502.namprd12.prod.outlook.com (2603:10b6:903:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 17:32:11 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e9) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Wed, 28 Jul 2021 17:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 17:32:11 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 28 Jul 2021 12:32:09 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Restore all process on post reset
Date: Wed, 28 Jul 2021 13:31:54 -0400
Message-ID: <20210728173154.834263-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e70c1a-6ea5-48f4-90ee-08d951eda1d3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2502:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2502A37DA54A235BCE626C5882EA9@CY4PR1201MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMhfdwqTUopPg4D0gOik+GQSFQfZ1oocZ9Ysl0HR83iONHZJDzHE4edmCUHBYqStjYd5gdq117d0Ne8BHeygFDIShDlJyu9VbW8BRUBYV5vE+uBrQNbxy8zMGRGg2fPq+X7giXdjv2Ao/v1zoYvpFBIIuHDgPCZa1Rvk6hwSGs1w95ej5Q0jlz67X0gT6Vm+j2aNteGCyCc3Lfyc6OKHVTkZluGz5S8gguRJE6HglxUQ2OB1KJPVQoOO1bgICrTgKm66ivOiLnxveJuKtC7OJiWb3YQqGNWyWSgoDrAdZrNShYncVR/oYNx6ObczAojf4fJxy2WEVt5xlLV2ZCr7dsAhQnlo9N8IK6pqcLCEgJxeWDzJemMbeTtOsZY/ey82RCc0ZnA6QVA+BMZ+vf8YXoyMxHsIX7TeDHb0s1ZqgNyR2t4WRQEdF20lk7Eh2mRnNU6N5719/AT9nT0vaXyO4e9JP0RGH9S6s/topZs5zgciMAVCMqr699mMd8OdXRO/BbDkarkKMYo81YjU5C6+DQncJ8nunAW43MhCE+v/eS71EzhHOXMywBYrDB8h8pn6bpmLEzb8ZE3aCu1zlDCQIIQaYLQDCUaVbZalQIJ/ZQ3USViU0WdocnIynAJxlCCEGTouyzFZKTMMa9Ip+5OLhxRrRvFB4N5Z+EjaVC7CiLkgPa0wXfuyeNxfxfUdQ/jskXFZDL3nCsCHpqAp2QZLoQtMYNWKmH+EU8vFFFa/3EM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(70586007)(316002)(8936002)(7696005)(36860700001)(86362001)(356005)(2906002)(83380400001)(26005)(36756003)(70206006)(426003)(508600001)(47076005)(6916009)(5660300002)(1076003)(186003)(336012)(82310400003)(81166007)(4326008)(16526019)(8676002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 17:32:11.2152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e70c1a-6ea5-48f4-90ee-08d951eda1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to fix a bug of gpu_recovery on multiple GPUs,
When one gpu is reset, the application running on other
gpu hangs, because kfd post reset doesn't restore the
running process. And it also fixes a bug in the function
kfd_process_evict_queues, when one gpu hangs, process
running on other gpus can't be evicted.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 24 +-----------------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 24b5e0aa1eac..daf1c19bd799 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -984,7 +984,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
-	ret = kfd_resume(kfd);
+	ret = kgd2kfd_resume(kfd, false, true);
 	if (ret)
 		return ret;
 	atomic_dec(&kfd_locked);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 38a9dee40785..9272a12c1db8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1879,36 +1879,14 @@ int kfd_process_evict_queues(struct kfd_process *p)
 {
 	int r = 0;
 	int i;
-	unsigned int n_evicted = 0;
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
-		if (r) {
+		if (r)
 			pr_err("Failed to evict process queues\n");
-			goto fail;
-		}
-		n_evicted++;
-	}
-
-	return r;
-
-fail:
-	/* To keep state consistent, roll back partial eviction by
-	 * restoring queues
-	 */
-	for (i = 0; i < p->n_pdds; i++) {
-		struct kfd_process_device *pdd = p->pdds[i];
-
-		if (n_evicted == 0)
-			break;
-		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
-							      &pdd->qpd))
-			pr_err("Failed to restore queues\n");
-
-		n_evicted--;
 	}
 
 	return r;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
