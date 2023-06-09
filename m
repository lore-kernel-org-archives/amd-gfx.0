Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3469CC7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 20:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7085B10E0BC;
	Fri,  9 Jun 2023 20:13:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A1F10E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 20:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/nDTLAUDCx/lAItLSZ+USWY5bM4MRJ3daksVMmP0NrdC0gNjSb/03nGvbc1tP2PeHZ+RNR5S/6ymWQOMBxzFrBrEak/LNPL97HeHUYEhs5hlfLlVRurrmO/nLjcTfV9oUHrBGE2Gm47/Zm7hnZ7KNJShEFLm9mLffW5XHacQDxe3W0TAAgFz/cSlo+1+L0xmHqATNgfG5ZyUi94AIewhNJOrDSdmbX9JnqKQKvcp24B1nwrDFZJ1L0Mkuyu7k53Miga7uM7zQwbBEAxkCV2i7ywmuulHKIT965h2WqqS+DgdEuBDU274n0erA/NRM3oZaGBV4VZZs4hYnxbDs0eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXwNEyLCsEbT9w3Gu9+BI5LiofD37Oz+pIwcA80tktI=;
 b=EAKQrOH7U8QK0aiR4NWrWDzT+Z3cs29hrjovuBaICa03upFbHaBwzfm4kFJfVZwJBsKX6dhSh1Zi5hBXgRUQ+G1iYngX6Zu022OpI+D5+51wdwYMSGgfDYg/W4YfgU2bGmrhb5HWIdR9pIyAdvZKlHa9l4z3+Zu35jO7Egwuv6NcsGBd7JdrdEVPGVnefghpISNiTU6B4hUZ7jvVS1vXNS9I0DV0BMwz+JttFMJ1GSxhqtrYSSC3IlSCy5jx9And3K6J5GGZFgVZMAInhHrNgigHLoFwjB3J4x9Mi4sLMMjKZajHSX7dtPGPyb/mL+uaX0TTSZriW+2vmUEhMVODjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXwNEyLCsEbT9w3Gu9+BI5LiofD37Oz+pIwcA80tktI=;
 b=g7Yp51pI/sawX0bKmFEMXxjajvqIc48wXset6NIs73xML4wbV++2iC8KyGHCcgRTX/c6HorhnTh3Z6FqnZM4/RepfVRXmU+ZYCvpm57z9Bd1PsNccwPPGdz9M+zHP9H6eH3PIy+ggEsr801hsqNYggKqSReNK+59JbIzfaw+Wrg=
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 20:13:41 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a9) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 20:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.27 via Frontend Transport; Fri, 9 Jun 2023 20:13:41 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 15:13:39 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Date: Fri, 9 Jun 2023 16:13:28 -0400
Message-ID: <20230609201328.2350231-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608170705.2271276-4-James.Zhu@amd.com>
References: <20230608170705.2271276-4-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: d34f053f-cace-449f-1c55-08db692604da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfJ3+6lg5FgJrTnFcF75aVzBvBAu+pUa21zg4hh4zTpcKjArnwoXP7ROd82OZpx+HosGZiHVJGKSCaKWDZW6og1Bclfni9s1Ms+mHNdfaAFJS6YLz6fpIoFcxdCqNkXv+eIEuzdb6We0tx9jCPeIpmQnwU/3BViEVVro/VK9vP6Kh8JMjX0DQYaKidBe5Uh3nhEQpbucistYHLVWLSBtHvFLEok1IgDqgK+p42Mqi8MrPhBqFM3sT636BcKC5ApKux1yW8tcLTY4pdkA0jUSYMkCUlZbkuGRTzSKnRRK9tfAW5GHQowEARYxvkjITC7UQ51IH8kY7JPp1NfruTUAe9RV86FhSf+Vw5MdVVuGRCDpdOLZnLnOCd7YJDV/RE/b0FEuLWiGVbb+ycdH3wgKdc4mK5OdANViBVavyz8Art2CdKN1hsiJz7lPs/b+/tZfmlBof/sUKU2IlCauqEFMfQEHeGUn3YHtSmfzaM1aodO427Pe9N3cbWgzHuuq7soFZo+J6TgZIm/NdyQGFwCE47W2L42lRGW9nZ0f9/trE609AvgfxwKYnE8ic9Z7IFADn6PQqJ2dapZSzhYDLB0zE+yDm0Zi7Nnf3w+jdL0u7AjTzAniSRAv5PfrPviknceeShGs2eaUMk4dnllmht5q6pkOEQjQb3ihCGMDsle16r73jiPLwWv9LpdvuyJOG74UmtWiZykcn9nQxf2Q7almUD3aX+LfgVQ3rJeIvpVmZmOuv0F02d6ec7VUNhGF9gQfhq6yXMMRRgVkcQZbv4xOtyquhb7x+dHBhuYEQTLg3bo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(7696005)(81166007)(356005)(6666004)(82740400003)(2906002)(70206006)(70586007)(54906003)(5660300002)(8936002)(8676002)(86362001)(36756003)(40480700001)(6916009)(4326008)(316002)(478600001)(41300700001)(40460700003)(2616005)(426003)(186003)(26005)(1076003)(16526019)(36860700001)(336012)(82310400005)(47076005)(83380400001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:13:41.2727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34f053f-cace-449f-1c55-08db692604da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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

Set waiter's activated flag true when event age unmatchs with last_event_age.

-v4: add event type check

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index c7689181cc22..2cc1a7e976f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -41,6 +41,7 @@ struct kfd_event_waiter {
 	wait_queue_entry_t wait;
 	struct kfd_event *event; /* Event to wait for */
 	bool activated;		 /* Becomes true when event is signaled */
+	bool event_age_enabled;  /* set to true when last_event_age is non-zero */
 };
 
 /*
@@ -797,9 +798,9 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 
 static int init_event_waiter(struct kfd_process *p,
 		struct kfd_event_waiter *waiter,
-		uint32_t event_id)
+		struct kfd_event_data *event_data)
 {
-	struct kfd_event *ev = lookup_event_by_id(p, event_id);
+	struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
 
 	if (!ev)
 		return -EINVAL;
@@ -808,6 +809,13 @@ static int init_event_waiter(struct kfd_process *p,
 	waiter->event = ev;
 	waiter->activated = ev->signaled;
 	ev->signaled = ev->signaled && !ev->auto_reset;
+
+	/* last_event_age = 0 reserved for backward compatible */
+	waiter->event_age_enabled = !!event_data->signal_event_data.last_event_age;
+	if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL && waiter->event_age_enabled &&
+		ev->event_age != event_data->signal_event_data.last_event_age)
+		WRITE_ONCE(waiter->activated, true);
+
 	if (!waiter->activated)
 		add_wait_queue(&ev->wq, &waiter->wait);
 	spin_unlock(&ev->lock);
@@ -948,8 +956,7 @@ int kfd_wait_on_events(struct kfd_process *p,
 			goto out_unlock;
 		}
 
-		ret = init_event_waiter(p, &event_waiters[i],
-					event_data.event_id);
+		ret = init_event_waiter(p, &event_waiters[i], &event_data);
 		if (ret)
 			goto out_unlock;
 	}
-- 
2.34.1

