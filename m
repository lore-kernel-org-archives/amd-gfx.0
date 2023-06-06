Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C4C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B0710E37E;
	Tue,  6 Jun 2023 16:24:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED2210E382
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2xYrNmBRbLGkynAW43E6qApw64x5MObgdtyg8EKm28vojcpwI+5kqcRCiDcyaG3EpEdsV6/t8rJY+uJvV5cffxH2A/ESXY/tStDPIIB1249aHhZRA1cG4nMRRclWgJE5+jTJiyV+8IcF0vxrbMKK8Wa0P3h65qSJbjnWiMLWW48oPUoli+KFKTC3T0AYg00Y7mulAfc2zxXuqAYxWW1znJtcpma3YynAYOX5kawmrIQNKldwAVRL23izgL/JPtj+q8zDNJrOQ9c5axY8G/JiHhN3qA+HwjO1kyFh2nSAxssP7pN+HiE7cCY+9p7l6Owvfjs1Gq/HNMy5pPNwN9UoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnjDxuprXaG8hzxKXv57oTcS7UWlTKFgHzIcOxI1Gdg=;
 b=UyyCvXg2PyuJq8oPerxqm08WXKc7tGEfETudkTyv9h4hRy5oeRPJ1Bn6AcraO5gfsc/X9UbhpRhRA2jOYukxSA6619rJLJlP2J3Yn0j223HA6U/Hvz+2lSJoPgYstqus3zLF4Ky10h8HFVN376twZ6YDZIIR6E/4gytOmUAK5Vqsm849itWwX3D4Zit6GTB8CRaCwMR/Ivd5JaaFIGsGqdAXOuo+0c8QPK2OuX+AEMLaji90gx1jpS8iTcUYnb8jcW5T0AEaISSieV5WF0N8MKuPCAfMv5/WQtnmqH7SsojBB08Xj2/5pVVZ4VBxDZKFgqUjravHA3DMuWtRm+7mNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnjDxuprXaG8hzxKXv57oTcS7UWlTKFgHzIcOxI1Gdg=;
 b=QjEnRCxzyYsgT6HgP9GJ1Iqsq1YKM+Gb5MO7hggpxQM4OLvUNDjeQHVI4TKvYMjcdonnAbEywHjtAA8fGTvDHgIIavhomuvuvDWgSUJfnLXH3byvd07152cYIh1cosyIHktnVpx+p3p6yMvPTCEgGxD21RQJQYdxHFWpLmz3OXk=
Received: from DS7PR03CA0349.namprd03.prod.outlook.com (2603:10b6:8:55::24) by
 DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 16:24:32 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::a5) by DS7PR03CA0349.outlook.office365.com
 (2603:10b6:8:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 16:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:24:32 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:24:30 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdkfd: add event_age tracking when receiving
 interrupt
Date: Tue, 6 Jun 2023 12:24:17 -0400
Message-ID: <20230606162418.1862540-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606162418.1862540-1-James.Zhu@amd.com>
References: <20230606162418.1862540-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c5fa5-19e3-428f-ba56-08db66aa827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWya7VUxQkfrn0kKkYzHKqx9F5MV1nP/ZageeMQd05AjCwVOdp1LEkQ3GSoJd3m+Zl/aSbyBGKgManyMORu0Fkiu+fokh1RifowHa8GZgIx4COQbjwYhDk8gCknnKnacpZxP+Vh7rKTX4mDD+k2U6R5jiGyoo702TUeJqb84jjFge/jfqFq2peTnx5wzfNlE1x90L2DbqizCU/0KZjSnctIocazrLjNq9MBtD4dMNHlQ/J6BJzs+MsueRi1TjFqIvcI3gRoVPMQwEmkWTiyVGmj3h7vO2cIMgFYBrgmMmIstPBmyt1kN3uxrC/51L3HYMlEcD6FOnyc5f8cvoaYz8H9WT25l1xzYmfUSavxZ0lfvosCRtJ0yZl5xFc+SXgPgeYZULR4bB71mYqTWzr5RtcnqfLiJZ+M4iN+p59NJVryBj1ANdCJ5btDADmSR5le9ypXrFnDFmr9jKbUkKWR0XEWAN2uAtTw8H2x6BlrughGyx5YmrIagtbHXqFG0avCo1EU/Dk9C/R2eYxMMGAB7cC2E7YVowBIPdu8FiNiWF5jXN/5GHMi6GlPYU6obxANbMRa+Xm5OOGizIRs7E9NtS1E0cJ5Du4/rHqgFZnt2PeO192lg3jFlhroaE5wbrZodbHRJBXaSnaCOiJL/N/ncbU1oSFEQ3syLfLiESROlqmbb1AbLx2ch8Q2IuuKVOFV8zvqtVDP2oKk7OE/pkzYKIBdC7UZmjvTfNX2MrMvYxv73FfRGtRqaOiZGZ3XR8LjMNQYFc03KXsZs/nUcw+VzHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(36756003)(40480700001)(40460700003)(82310400005)(81166007)(356005)(82740400003)(86362001)(54906003)(186003)(7696005)(6666004)(478600001)(8936002)(5660300002)(6916009)(70206006)(316002)(70586007)(41300700001)(4326008)(336012)(8676002)(1076003)(83380400001)(2616005)(426003)(47076005)(36860700001)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:24:32.2158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c5fa5-19e3-428f-ba56-08db66aa827f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add event_age tracking when receiving interrupt.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 7ff5c4e1b7e2..c7689181cc22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -431,6 +431,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 	if (!ret) {
 		*event_id = ev->event_id;
 		*event_trigger_data = ev->event_id;
+		ev->event_age = 1;
 	} else {
 		kfree(ev);
 	}
@@ -629,6 +630,11 @@ static void set_event(struct kfd_event *ev)
 	 * updating the wait queues in kfd_wait_on_events.
 	 */
 	ev->signaled = !ev->auto_reset || !waitqueue_active(&ev->wq);
+	if (!(++ev->event_age)) {
+		/* Never wrap back to reserved/default event age 0/1 */
+		ev->event_age = 2;
+		WARN_ONCE(1, "event_age wrap back!");
+	}
 
 	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
 		WRITE_ONCE(waiter->activated, true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 1c62c8dd6460..52ccfd397c2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -53,6 +53,7 @@ struct signal_page;
 
 struct kfd_event {
 	u32 event_id;
+	u64 event_age;
 
 	bool signaled;
 	bool auto_reset;
-- 
2.34.1

