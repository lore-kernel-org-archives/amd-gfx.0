Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8A010F6FE;
	Fri, 17 Jun 2022 19:56:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852DF10F6FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8O5w2A/UiHCfbbaocNVnFSO0bm2/6S7hANiW74CdsMt3DoaYrBliLtBEU4IqXBfrRaTcplGAk7iORFx6bSbRvHNv2xr9FBIIkAmxEGLQk4sy3wyV0SALkImf8jtlcux1GAG/7Hk5LME7gZzyVw5nshwWAFNC1gQCH6BdEJyKKrLvlQq4/yDfRHGvRj/8rdpmGeNCndUmudDlqf5cuVdRTwNdCQpIscT69Y2HKXCruvgoIMWhemai/MTTKGQ4elOXTSQR0hinr3t/i7CBGkpVG8T6lpV05PRqbQ3r70p+6DRg5rT4/FZn3IlzZtlfH8Kl6/nF0eqCMt/NWl1dLjLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWKf3u2jPVcvjTgKbNpSgmcunbvUbBuWmJKTSf21qJs=;
 b=Ilaf3F2KonrTRtZ/Rnz09C4YVauLhA4NZIGc3Vi/qrGITLco2V6BFSpXYRsEidQ8iWeSXSnqeapGQHM6nPJ552haNM3ydWrrA/vHXnL3Sk7jE21B2KZaViNB+JxGvmmUJHAd2eMWWvhOtyCeNeRJGe74zE2zC+wWOsMQS2EnzWDL3I/ite3MJ//YEWb9csZPd/Oj9x5T8o6+XkPeWo7opqDTdR4iBdvMoMPjYwgbvHVuC/VonmPLC7cesm/ydosOKb5FAfA3HAw1nbzBUP/lQJ03ZlZOb8J3iJrgeH7yyCUUYWx8TG9tMkOMvisuFp8P16UhZ+MdUsgHZRdEjR7JTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWKf3u2jPVcvjTgKbNpSgmcunbvUbBuWmJKTSf21qJs=;
 b=tb1tTwTkGmjz9bHrZA7PPkkzC3uFRIRfXWcdikBMf2JbBhWvA4aaUFx9ZgtaAC2FYFQKFlwKExAm/PMQQjkDShDr8eV21cUGzprhhVt6UUwzai6FjDEUDwFGUEyAKDjommmieIzR8QlfUnRLim5WFvPhloapEzkIsB7GA4UJidw=
Received: from MWHPR18CA0052.namprd18.prod.outlook.com (2603:10b6:300:39::14)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:56:10 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::ca) by MWHPR18CA0052.outlook.office365.com
 (2603:10b6:300:39::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:56:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:56:09 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdkfd: Add queue to MES if it becomes active
Date: Fri, 17 Jun 2022 15:55:27 -0400
Message-ID: <20220617195528.20894-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17553a4-e607-4957-e6dc-08da509b6cee
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6169:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB616936E8B272680DA3D84E21E6AF9@SJ1PR12MB6169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLu/PMQd1GKPxC2edCOWCV/tZykK1wP6hHO6hG9GcBsANGRhyn7qNIm3EVaFScu3rTvoukv34c98j4eiIrIb5Q4NdKtgtaTPgh9XvUSTJrFZAl3ofQHQsz+vuG2fqxSlNGlp6+3YibzmhBaQZrVvV0c5XkxUX+6VkAVix9xUt86AWlWrR8IV060t0Sdol7JHoW2Yjj4xuyhPa1Bd1U99oVxXhn4bIeLN1dn3NLDb8GSIDw2wcH7W1tvLFPs9Xw4FXzmuDvmspaLe9ILF3Mn4MPe72yLzkQolDyh4SjpExyQmxmHw6sd85KqLHcCSJhEwuHnt1ddnOsJoK8MMbiU5lim1ddMRpwqIX1ARmVA10fPz366G7IiQh6gMQcQjiZoDoKopOZbcz+GdT3SnwKajXV4Ky6XHQQYn+OCrDCqlxLANwrtgMEENYvCrb/sKpJSRzBzA2dPg/cNz6pOie0hXBavVP3wiS9ygf4PAmIKFB7FpRzb0yhRA2uLEKnUEzPahb41EWH2blmvlFH1AKdCqj7mGs3V2vMbEuU84gkDIxPx1FCyzGbJEBG06iXaVZf76QlxiixV9EsaXTxTwPUxk4vteh+IdBZ7dg+ptWY7mak5LVk7KKaCzwUtU7nDMrVbpjOl4BUVL8cp4IGPuCB19kALuWX/xg8tGYaabLNcgvgltKbUmrtFWUVz8JH0owPirAL8bH14+zyWl2u1R2jlMhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(1076003)(36860700001)(81166007)(426003)(2616005)(16526019)(8936002)(5660300002)(356005)(7696005)(186003)(40460700003)(83380400001)(336012)(498600001)(47076005)(2906002)(70206006)(4326008)(36756003)(6916009)(70586007)(316002)(54906003)(6666004)(8676002)(26005)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:56:10.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17553a4-e607-4957-e6dc-08da509b6cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: Philip Yang <Philip.Yang@amd.com>, Graham.Sider@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We remove the user queue from MES scheduler to update queue properties.
If the queue becomes active after updating, add the user queue to MES
scheduler, to be able to handle command packet submission.

v2: don't break pqm_set_gws

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e1797657b04c..21aeb05b17db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -811,7 +811,6 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
 	bool prev_active = false;
-	bool add_queue = false;
 
 	dqm_lock(dqm);
 	pdd = kfd_get_process_device_data(q->device, q->process);
@@ -887,7 +886,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
 		if (!dqm->dev->shared_resources.enable_mes)
 			retval = map_queues_cpsch(dqm);
-		else if (add_queue)
+		else if (q->properties.is_active)
 			retval = add_queue_mes(dqm, q, &pdd->qpd);
 	} else if (q->properties.is_active &&
 		 (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-- 
2.35.1

