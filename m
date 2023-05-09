Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13711C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 21:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825A610E1B8;
	Tue,  9 May 2023 21:43:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED1110E1B8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 21:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4tYkz9mp8aySIZNlyee6KViHnSLcONqLzXyUGrYrCPhOuYjQuUaf/iTkyTXk6RyLlqiWJxR/T8WepFk5tiH99ZVFBS3A09zPOL/ZDe1eAXBSLCUP0CbESDBN6JjPxBNs9rRBeLiFhTuqA2L97nOxEbX/svsEoq4hUGsaK05icZGZBwyT5RvEXITfZuK0E8FSrGiD5jcdsfgorJimOTem5K0Iy8+Fo2yQT0x5uMNDOCytHZo0hT7ukKIwM0ECHDXV4ZuDE5qIWvAF6ijzxMBergmMh6aMTYJbhIcsYxMmOwb0SSuSmZweROSjsuJqOjaXylcBQXCQ949a2CjCM4uSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TVXvW+tBiiY31mvld4y9ZDz9tZO5cfvY6elZshxm6w=;
 b=XhxqaWuiB1NaYVxGRemO30WtqN6oMxej8GMK4rfQzoMzIrrB5hEufY04RlKhx+/mCF9r08C14j7n8/7betVTQtMfXBfRTAzZ6PbS+WJqBZcSzkh4zJumIX6nFFkvLbvsVqydsvukgEXXOrlk8J6L6PhwnpO2Mi2nOpl7ZfA/MT3dUj13ikyoA38CVKD48pwWaH8lhS0X6l/7XOtkq9JpmXbxcgzYlfiPoNYf02hRd/+qHVbQzzfkQfdwf+/hDMotgcZIupu9TI5LAX19TSVfkK9yhzZBJGw6krgOO8ghLfcra1RD7EDzIB9f4PMq1iLLFe2oM2IQPWnDRmwyqevZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TVXvW+tBiiY31mvld4y9ZDz9tZO5cfvY6elZshxm6w=;
 b=RR2p6EYEKahxYwNzf6QtCi34UAc7owmDk3fnTe5VmH3XZqpWuOz6OLYfa8nV5DbntFMSek/gcbxSwhfxg9adGDbMolNogrM0tszQKsGZGXvsT0uCDKBzGg3QXMGmDlxEcMT9r2naRtFUeOT4D6YjY162VXQT6y8sF9luF+3xlVo=
Received: from DM6PR07CA0049.namprd07.prod.outlook.com (2603:10b6:5:74::26) by
 CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 21:43:42 +0000
Received: from DS1PEPF0000E63A.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::7f) by DM6PR07CA0049.outlook.office365.com
 (2603:10b6:5:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 21:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E63A.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Tue, 9 May 2023 21:43:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 16:43:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 14:43:41 -0700
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 9 May 2023 16:43:41 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <Luben.Tuikov@amd.com>
Subject: [PATCH] drm/sched: Check scheduler work queue before calling timeout
 handling
Date: Tue, 9 May 2023 17:43:37 -0400
Message-ID: <20230509214337.124382-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63A:EE_|CH0PR12MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b397653-8f03-4afd-6d86-08db50d6751d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek4ojJHQramE/xgi59tzf2Cn9thZ+B+NWErmc9PXAlNYCP2Ng+umqpbIZaLwmSS9kluCqXdKD4VcsZ6l+7zFXAhHK7S93RC2vGTLHxjeOrxdDaxCL3lgZm+pQyGg5AFScIMgQ27t002HpctQGDIN1VQo4ffS++9Cdv9FQj28CX0OHnFEL2zHmt5NdVN2EPQrOTT9CLLnJHlIF2ovBVBqRkfu1bE4sOXQhPg0N9pi/anX54uLFvPhL9LyqP9dPDOGbN0ZfhHtbL13WNUoTwBW0dgVlcG02oQbt0/yzOKxiPoIvosY+qHjiyF1/yfr5L8wFAMJhuBffmMYYiGF6hq16NEFuvukZgnWYclKZaey5ComYhUS845Bj0bqI1IXyWa7mA7liUfVfjJAw7K4Ozfu3IHHE1MDjR7lxuVKBC+v+3KC0QTRWswLQZXNkFSMYlZcjWfEOTukzLbZZmKP55ON6lOg0yvbZnkDLHRs+29exRpDkr2je/Z+DzbGRHWKKXy5K7PL08P3qyzdD4Ap7v4r1NWxbUVpFK3P3e7BIwjNVurJhwa5Mjr4+I1fp1eqjUd1rg8cFWj7iof15C+EyKyrW2739loDAGMZYq2L+HF9WRBqe6/i1eIBqNLw6RWp56nH6jwmjtVlcTnDNSH4oPFsig5CiPsqZFSdbWtxE0JjbkqAw6HjtpzqOGwLgFZsUl6snqfp3I3NmKLqU5lq0MXUWzDnHRCdu64VYor4oQ9tYSY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(4326008)(6636002)(478600001)(8936002)(5660300002)(8676002)(26005)(110136005)(316002)(41300700001)(7696005)(1076003)(6666004)(40460700003)(2906002)(2616005)(83380400001)(426003)(336012)(186003)(36860700001)(82740400003)(356005)(81166007)(40480700001)(47076005)(2876002)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 21:43:42.0362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b397653-8f03-4afd-6d86-08db50d6751d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

During an IGT GPU reset test we see again oops despite of
commit 0c8c901aaaebc9bf8bf189ffc116e678f7a2dc16
drm/sched: Check scheduler ready before calling timeout handling.

It uses ready condition whether to call drm_sched_fault which unwind
the TDR leads to GPU reset.
However it looks the ready condition is overloaded with other meanings,
for example, for the following stack is related GPU reset :

0  gfx_v9_0_cp_gfx_start
1  gfx_v9_0_cp_gfx_resume
2  gfx_v9_0_cp_resume
3  gfx_v9_0_hw_init
4  gfx_v9_0_resume
5  amdgpu_device_ip_resume_phase2

does the following:
	/* start the ring */
	gfx_v9_0_cp_gfx_start(adev);
	ring->sched.ready = true;

The same approach is for other ASICs as well :
gfx_v8_0_cp_gfx_resume
gfx_v10_0_kiq_resume, etc...

As a result, our GPU reset test causes GPU fault which calls unconditionally gfx_v9_0_fault
and then drm_sched_fault. However now it depends on whether the interrupt service routine
drm_sched_fault is executed after gfx_v9_0_cp_gfx_start is completed which sets the ready
field of the scheduler to true even  for not initialized schedulers and causes oops vs
no fault or when ISR  drm_sched_fault is completed prior  gfx_v9_0_cp_gfx_start and
NULL pointer dereference does not occur.

Use the field timeout_wq  to prevent oops for uninitialized schedulers.
The field could be initialized by the work queue of resetting the domain.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 649fac2e1ccb..670b7997f389 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -308,7 +308,7 @@ static void drm_sched_start_timeout(struct drm_gpu_scheduler *sched)
  */
 void drm_sched_fault(struct drm_gpu_scheduler *sched)
 {
-	if (sched->ready)
+	if (sched->timeout_wq)
 		mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
 }
 EXPORT_SYMBOL(drm_sched_fault);
-- 
2.25.1

