Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0D1C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E1F10E5CF;
	Thu,  1 Jun 2023 20:47:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C45710E5CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8RxPJS+wTeF56uNiKFP7tPnV/wf3qUBwubQIXPqYFFFi+A4WFMGiQu+kIKstYfznVbAFxkk6AROGUDu87cv0TP12gKzT4h1v9qnLSk6Vhb8QHX13IMxdVGIlFGnE3jSjQDcO74tU6/0Im5UoztOOC0an/X7b0lZicLh5lDLf8CKq/NgjR9KZKrOt9ZCSFKlMAB+1xlN3VnoUGc2awN/oQ8kNKAwl7In3LIRKXl4DPUXgquDyAv1D1VM2zRAnn401Tq1t84Kc0UUuapG9VP5SQVr/3yWK0458WwS0fjkat2AvNpyCcHti35FahcLShYhFNsrSwexaw48XTNb2rZOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TCe7kpqnQkIDsz/GtvrGmHDGhUiTqInDId1qPO7W4k=;
 b=L3uv7seCNUdDS3aZnW9kK2w9IGB73I8iuClaNjUKmTE0jK5peIHDChOVdZqs/yO2Rt7zefeqQnkCCkIa/YwEX7b4TN+kvmunbSbyPmH01+G2waAuDtNrZxI+Ao1OUINngD/D3V3jN35ShHRbDyjbM8+V19kq2qla/TiX2SuraTrAkgjVEuWfmLwbhxYYLMueTywK+qFQJPN13v30QiMqtPmhVzt/cu99maqF5JhyqzmvfREW8pW2myjEfBILukTO/2OvySl+FEPJMLgJP0mxtRb3hKbROKa0+sT2eqszMN/tvQVsyGo4/sT+i6WUaoyCNWpC4ZPg8g9Edi2CGfRA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TCe7kpqnQkIDsz/GtvrGmHDGhUiTqInDId1qPO7W4k=;
 b=FmKjuyD1PWvQxF3yyI2PeTXV2Vb0FCzSScK/U95atQdDl2y2eK5NdAeJy3TgnTEqi0NKd8uB+Q5bFkUTcLaINz7ZrkeDHVtFOxkzID8QIxEjk0vdgyJb//MwHqxABWuUug2fFPc5gI2JtIWwvsY7hiiV52G0YnmHcpYcZK7hac4=
Received: from MW4PR03CA0066.namprd03.prod.outlook.com (2603:10b6:303:b6::11)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 20:47:54 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::ed) by MW4PR03CA0066.outlook.office365.com
 (2603:10b6:303:b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 20:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 20:47:54 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 15:47:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: don't sleep when event age unmatch
Date: Thu, 1 Jun 2023 16:47:40 -0400
Message-ID: <20230601204740.1501616-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601204740.1501616-1-James.Zhu@amd.com>
References: <20230601204740.1501616-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f316cf-935a-4aff-1ab4-08db62e1794c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkOGp0wL+C3iY1ZrZnNOMrN2x5qwyBTFpzwI3Z3FoQpjbiH3NvS3BlIwnBKsp5t6kQwnjMby4ZA/wbypdza3VnUetFDQUitEdfB7U3najdErPYBvMrj/1Kx+rs/jLYHV/hoPLAb/lWjnOTGfWl/1Ni7nsBi4u5T15OYBudx2ijO+SJshsmszn+SeDIsYBPgyRTFtywHUhFnh2dLLQovkkg7Bo3B/EsJN4Slh6yD4nV4cFaLEcs5bjOijMz5EiFnqfZzmePVHua/DMhhTW8D90gm4xphdved/dryP0ZazqZpcIMEO39w4e3YvvEDeI6GbgUCMDg0uQnteKhzTI++JOupEqt60DLPyUgjTuqIgJR3wY4pXWeR+6LZlR45KQUIdsKNJ9Em3qCqEUSbnSyrK9iQizY8SLFwVNaXeDQEuGH6Aj2K0vlbfTo08xhI1TX/mzT5bujg9SzRC9/YICs8SGVUfMItPLeBPQxqx4M1Yd6EZrfM76JmekJlRwQfIsDViTlFkJZTLNoYe9Mb/OX9/C8BShXoNTkPqkFda69u3UsK5ABMfEdyskuKtQTs4s2FBLIQgwhG6Ikf2u7Lszk7W/6Z5QBIjEtwfzC7mQiCmwjw8pAr/iAmKLJhFTsyLgyWsSTnUGwLzz9nTDqp1mG2kzvFjVpcRbDHlzBPAi9vp1PI+L5uwz+8wuIJoTMB1AfgmsBSUhWDZwQy3HJ/WC/LG7VoQMrmkcH0olVg3sixswdZ3gl0t0oLOaUPp56zjGyyKXDsbZX7dRLY95YK0N9VZuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(8936002)(82740400003)(36860700001)(426003)(47076005)(83380400001)(336012)(40480700001)(70206006)(70586007)(6916009)(6666004)(7696005)(1076003)(36756003)(478600001)(2616005)(16526019)(40460700003)(186003)(2906002)(8676002)(54906003)(5660300002)(4326008)(81166007)(356005)(41300700001)(316002)(26005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:47:54.3845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f316cf-935a-4aff-1ab4-08db62e1794c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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

Don't sleep when event age unmatch, and update last_event_age.
It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index b27a79c5f826..23e154811471 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -964,6 +964,19 @@ int kfd_wait_on_events(struct kfd_process *p,
 					event_data.event_id);
 		if (ret)
 			goto out_unlock;
+
+		/* last_event_age = 0 reserved for backward compatible */
+		if (event_data.last_event_age &&
+			event_waiters[i].event->event_age != event_data.last_event_age) {
+			event_data.last_event_age = event_waiters[i].event->event_age;
+			WRITE_ONCE(event_waiters[i].activated, true);
+
+			if (copy_to_user(&events[i], &event_data,
+				sizeof(struct kfd_event_data))) {
+				ret = -EFAULT;
+				goto out_unlock;
+			}
+		}
 	}
 
 	/* Check condition once. */
-- 
2.34.1

