Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B58C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351CC10E08B;
	Tue,  6 Jun 2023 16:00:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BFA10E08B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/nbenwJdwqdtYvLlJe0y/d9izh0e+B1NUo1qBj9pliPu0gqJ5xn/KfWxV4H90FakooxQnJRhkHaRd0xBkP2Lz3m4la6xTl+NiOUiSd+W7IOvsLHQz7SupD9+ewSnVO06QPrG7XmC/j12UY5zCtNCGYSRTehwB1xDOrVIbrrC1KaVROZ9LPKWoqos6ckkKVSvn040RO1cV0n5JQMVr/ccFs8pT3TZnZAgwB1BJ/s425zjYZciKs7tivqUBw3uzzXRIbWbZgjWKRo1RJ1k+3ZfC1CGexV1MecxFCPB4jko+ZtQguTLkWLY9g6HvfIBhYYqDEFOlw5qeYziU6moh59tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnjDxuprXaG8hzxKXv57oTcS7UWlTKFgHzIcOxI1Gdg=;
 b=b0IXBNGamjyJ40tsnmwh637fcQdBFlX/nNBHRWUkwQSCUN52KPiQJzqP+TIKac+rwpQVOsQyVRwjoe0y8Mh2PxdjeaniqUJYE+d2aVY+lWZBSvg8ZCHdzqgVmxiCuEwtK/nob5HaHon87pxVhTAWbw7jqmux5j8ZhSBsrsSO6RBBfn2mTvgYbjTgXn5Pxxy5GzHqrC6ceX2YzEWN7dM18eJ08clg5Zdfj0ODNc44BWFpqHcTWdDnhs74w6H+Y4HmcEfokpeHRavQk1TCXEq3fCHQJRUL/pUAsQVOdRxSUXLEfUJN3k0zpbS/hChH9gYWsrXVlywDvtqBRqYjCaLqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnjDxuprXaG8hzxKXv57oTcS7UWlTKFgHzIcOxI1Gdg=;
 b=lbgDvmkLndXm7O9IEZWb73bVD+oFyjPLObmPaLZGi6qkfwxC2X9nhZMHMl6kfxpWWBmEZJbTGBq2brL5/iAhC3M+h6hh2d1pTlulICyOSNp22t0J9cq+k0kNOCIcNwwyH+M5bgSkukF6+hNqo1Ahh1V8ojFTmAstiT4UjDYZG8Q=
Received: from DM5PR07CA0099.namprd07.prod.outlook.com (2603:10b6:4:ae::28) by
 DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 6 Jun 2023 16:00:23 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::13) by DM5PR07CA0099.outlook.office365.com
 (2603:10b6:4:ae::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.34 via Frontend
 Transport; Tue, 6 Jun 2023 16:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:00:23 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:00:23 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: add event_age tracking when receiving
 interrupt
Date: Tue, 6 Jun 2023 11:57:59 -0400
Message-ID: <20230606155800.1859694-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606155800.1859694-1-James.Zhu@amd.com>
References: <20230606155800.1859694-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edd8294-6676-4b88-3aa5-08db66a72338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CPs7i/cxrF9zQjCQ43cdF+qNLWhPZUpyXaKstVs1puoEUi5BWIOow1UQ9Tais12+qJo4yBI3KF0h1+yNSFHJd3+BgQ42IMIUt0BNarT9RkY7rwNFaG+NTyVH1xRBwFNgxz/zzsSinsUxq5wm7MCvpQ3iMIOb1JwybqNxgAFJw9z6zadMSnRXvOjFARznxe4hW2GGVmAPXKf6s0igH9k1hcM1MazeGHXuYDIHE0stAAvIgAhCzDjQnuNjPB7FWRdIGA3sF5Cf6rQ3YONkTRt+c+P1Tn/mxGc4RIzMEMm6esjJTkUYMRL38uNqsqj42f3t7cXexqvt6MILwjEWhpv17QD++rJsVX/BxbBIKrmVPymE/7xauwNk8RIX1remlcbHf9Wh9NhMoNvwt5YMGe7P5MZDslro5q8rJd+fe6EoBl1sdNDUWYB83HRqndKsbPE5qNoEMSruJ9U8r2ZX/mEPwNN24jLt6eWXHz0KMuaqFvc0r44iXV+qi0ftzvRY1vH0d/gqpnzeYPHEZpYfPqOp76NxlU7cHc9gO8552E/6fUkSykj6UwYFOk324MsL/Nq2A33s2DvGnc7YJNRi2ta8GlUJkYyAPVR6gUM0hAn6R8HTEabGOIqGBsY4bZ3NvLlCVDbGJyqkRpTX1taIEQ64IGeIsNI3wWNDGF+ErXAJOJRaihisBbf3Ngw83FTAbwrTo2A+K6KwaBUBcI30i8gyR5C8wDLSZagCTGu0dLTY2DQ0HGO+6Wg2UMVWYd08mErSetOLitw6ptf4As/I739sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(6916009)(70586007)(86362001)(478600001)(8676002)(7696005)(5660300002)(41300700001)(8936002)(4326008)(1076003)(54906003)(82310400005)(316002)(6666004)(26005)(186003)(16526019)(336012)(47076005)(40460700003)(2906002)(426003)(83380400001)(2616005)(36860700001)(40480700001)(36756003)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:00:23.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edd8294-6676-4b88-3aa5-08db66a72338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

