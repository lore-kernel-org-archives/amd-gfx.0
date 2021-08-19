Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE1BC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F35E610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F35E610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202FC6E96A;
	Thu, 19 Aug 2021 13:37:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B555E6E96A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNWXOA0X88M81IR5bHWjrhbH1TX8Knta3nWqoIgW3km/AbI70zS93zFROwRJGKelzbecSbMfJ3zpQbSWjUsgH+zvRUvasoNBTdc2MvV/aqex9dLeKGk2hbyBvWcl3OdDeELqQlUGxX5FOo4ge6zydX+efV8aObw2lxlgrcQ1MECmq25TUQ8ArRy8VwYNdSxAfmbQOhAVACndgi8z8Y4SwCu6wKQGAunOXC0i55JZCF0rs5CqNHbrg6v/YaZWERqT0aMLK044wk95IBuHL1ToB0CBljTza1Zgu6YG4vSaPdHfM7/YtC2+7QEs3VGzoRz5uUYApqpzf/oXWJP72xFFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfb3f+hEmlECQ87268rvywftTJ7u4xqp/J/Fe1dDaVw=;
 b=gLyxYU+ZMqLyDUqH3dM1MUUmzRRFfjfSDmfp5OhgMcxCIGTdqT7nRz8LSChuPL72kKPhZeVuY5+UdZzRI9EuuFcTbrNHspbxATdyr3lZeDu9dCNZJ8GV/ZY62pxLnYpMUf/As6qLBUj7tOU0yZT0eUl2H727nB/ZxLewTFm0QPI04obiszll/dUAOlTx7PzGcfFd4v6h0EaTZMJcbymJjXvdHVKBypsCDC6zmpeTQoSHgwebYTSuPxKkacrwA6wks/Y+EHgTkePIcPtkDgWA4C8aFxwgD8AJnGfNwkalYdObVf+BJpz2u+7wfuYGmGdBWN9h+eqdbgzz9j4Je3I/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfb3f+hEmlECQ87268rvywftTJ7u4xqp/J/Fe1dDaVw=;
 b=EvSFQ0e0eyNQAllE1tC0K3UiakYI8eFpAOgI0C0phvvV20NRjY+HPM5B/EyIkIhf1FIrD+kb1sr12KrQ+Vl5yRWsD/LX1E6XIDdJm61Wd+frQgefH4xALFGCLpfeQPLUYeLTjPB5wQGyY1NlhDx9WcIY8NmAKBkFL7JaO1LoDOs=
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 13:37:54 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::44) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:54 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:50 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 08/18] drm/amdkfd: CRIU Implement KFD pause ioctl
Date: Thu, 19 Aug 2021 09:37:03 -0400
Message-ID: <20210819133713.4168-9-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 691804fa-495e-48a8-4be1-08d963168c4d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:
X-Microsoft-Antispam-PRVS: <BYAPR12MB317600E53D7C74E7A87E4DEA95C09@BYAPR12MB3176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h668QLdDzMybNRK0cE22ZYQ6Gf2vPliQ1KRQQVoGkbjQRIil2DfPe5s/FwMBozBFanIe5D+kr5oKNuHV/MBBLWxiAk9CbcdB7yOuoHf+/YMor3TMLbQZIVQNczNBNupxOvfYDw0KSSJOs8HQIapkbXs/tbcZV4bivUDRM6AbwtT9oOvVbTeaxIk1xvSkStH9W3c/52UcTrpAvPa3zya30BpIcdmQdtZ7lO4UUgO2Y44HVXXsrLo5/4jQM6lVF04fFSuX80d8U+X2qVn2g7wUQmOl9NsQa4wdgVbnrggpefnGIkuKDPCyh5flohWbeWalTSsjBrXeCv3FpkYQxQ5Qk/3zYA41+icg36otJ6givA63CfBjfPx8q0hiv+UKa72dc0DWpEX7lbubd2TvxNpHlhSGYk7ONjtlHgO/63LPuTYec8g1fxa0tH9Hl/GUhq/VYkco3MKfJQSor8rRlJ8W/A/MaqZ5rrV+U0RvyVebUtnPU9dd91fut+zbclcNKd2fkz6fzLcQGkSkmD6Lq4inysn7JXAMnKzIGWsncgebxW//biQ1uWXqwN48tS2fktZqTOrPq9je71i+NkxbZEWWpB2tVH03B6A72kYkDxMK1CFYK2s76+ak9u+RuX0udIlOacuLO5Xxoc/BZxJ/63zGYWPjKDyPuwGghTgwQ0qOXti5ghrcWjfXtJJXRivLpy/cauTzDWwPAy6oEzdZiG1zCkoP6JWIhLGsF2BfUDXKoI9cRLTd2xoha+lPQkLzSddbrQCxgYTxt/JL9j29U0A3+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(8936002)(336012)(16526019)(426003)(5660300002)(82740400003)(478600001)(36860700001)(2616005)(1076003)(34020700004)(4326008)(70586007)(47076005)(7696005)(81166007)(70206006)(186003)(82310400003)(26005)(2906002)(36756003)(6916009)(356005)(316002)(6666004)(86362001)(8676002)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:54.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691804fa-495e-48a8-4be1-08d963168c4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3176
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

Introducing pause IOCTL. The CRIU amdgpu plugin is needs
to call AMDKFD_IOC_CRIU_PAUSE(pause = 1) before starting dump and
AMDKFD_IOC_CRIU_PAUSE(pause = 0) when dump is complete. This ensures
that the queues are not modified between each CRIU dump ioctl.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 23 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f0c278e7d7e0..24e5c53261f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1984,6 +1984,14 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 		goto err_unlock;
 	}
 
+	/* Confirm all process queues are evicted */
+	if (!p->queues_paused) {
+		pr_err("Cannot dump process when queues are not in evicted state\n");
+		/* CRIU plugin did not call AMDKFD_IOC_CRIU_PAUSE before dumping */
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	switch (args->type) {
 	case KFD_CRIU_OBJECT_TYPE_PROCESS:
 		ret = criu_dump_process(p, args);
@@ -2306,9 +2314,20 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 
 static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void *data)
 {
-	pr_debug("Inside %s\n", __func__);
+	int ret;
+	struct kfd_ioctl_criu_pause_args *args = data;
 
-	return 0;
+	if (args->pause)
+		ret = kfd_process_evict_queues(p);
+	else
+		ret = kfd_process_restore_queues(p);
+
+	if (ret)
+		pr_err("Failed to %s queues ret:%d\n", args->pause ? "evict" : "restore", ret);
+	else
+		p->queues_paused = !!(args->pause);
+
+	return ret;
 }
 
 static int kfd_ioctl_criu_resume(struct file *filep,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 719982605587..0b8165729cde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -857,6 +857,9 @@ struct kfd_process {
 	bool svm_disabled;
 
 	bool xnack_enabled;
+
+	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
+	bool queues_paused;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index bbf21395fb06..e4cb2f778590 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1268,6 +1268,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
 	process->svm_disabled = false;
+	process->queues_paused = false;
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
-- 
2.17.1

