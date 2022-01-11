Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7199AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 05:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233A910F968;
	Tue, 11 Jan 2022 05:22:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC1910FFE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 05:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQxe/6YAyY/ZoRqwX65JM9JVvIvZ/qwM/2Qikm7aS5d/yzyy6ie6/di1Fl8eapOoAJmIEcoBG6PbH0J7Gtlw7HpYuQrMWw/IIZ5Gp1hFFy3bnuhgc9uRuBrip+5EeSm3jn6xTs5BqFnS+UDCVm0MXas9gtGtzQvrIOJnHyryZrzAHo0+kcWhIOTC9D6B3q3+8qyPiQGUSqXhMPhJ8ikbg/diKJ2FmirEz7s/XDjwYg9rW2Pjhuw6VTvCSlvU28nlsYLchZMvJnEM65LazlWxsDItetskTWgHP4i7td3Q7xQ/F/gRRWpXx5goafdNq180R0XH1yhmUV5KjLxFCJM0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nwvb3eO3IiSaDTQy8jTloaJgbayq6FzSewvSpSxF1U=;
 b=WxbJ7WTtQWV8FIp6ui3HVZPjY1XPJpEVbKYsN/OyXEF4XPtAy1YLMLSz/DSLdn+BXTsG1C0Zt9ppn5N91m4tg5Ob146PHcrbS5s1+vFs0xKKz36MmuHvXxkntpJDqlWAbRO3HnqbXB2Q6+xqJ2nkJiDy+WA6cUuNtIWoxbxZaWwFqth12ywo/35/qmKlWUJcaClg8eho3nVcqAWJLl5bYU1jrgJw3lpXc9eHDHH3oQi3RGYo+K5iVUIcHkysMPNUQbVWkJsA7yPDArujhYxteBoHtQLd4fJuOG5W0huTqYojL+Hw2niwNmPJFMI2X+cE56zcfUm6a5ca7GaWmswN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nwvb3eO3IiSaDTQy8jTloaJgbayq6FzSewvSpSxF1U=;
 b=coir1ZJbdjfoOm64aFu19jcp4ARVL+xntvAM2bWySBPt07nqRdclVilBWqshYH76VloaZjAmDzxc7rzVFcC1N93AYWdk6RyQZFeiRrvb18WCF9Ce/HvBNYDnhgIMttLpj4igbmg1dLOX8NzAFxkMjq6cv+lAxmkv0DS/hPEEjeI=
Received: from DM5PR04CA0047.namprd04.prod.outlook.com (2603:10b6:3:12b::33)
 by CH0PR12MB5185.namprd12.prod.outlook.com (2603:10b6:610:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 05:22:14 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::15) by DM5PR04CA0047.outlook.office365.com
 (2603:10b6:3:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Tue, 11 Jan 2022 05:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 05:22:14 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 10 Jan 2022 23:22:09 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <kelly.zytaruk@amd.com>,
 <qiliang.huang@amd.com>, <bokun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by local
 interrupt
Date: Tue, 11 Jan 2022 13:21:37 +0800
Message-ID: <20220111052137.28844-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af204d57-fbc7-489c-2278-08d9d4c25404
X-MS-TrafficTypeDiagnostic: CH0PR12MB5185:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5185A407B5CDCEB419511C89F1519@CH0PR12MB5185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZpQQPZu9qIn3u1KmdDxJnJUD7ikU7sqUFzGDdqadNy9WchJa3b2pLgg/N+3zC6ByJRU+sKCd9PXz54oilvC3HhMoockjerD2zcicqBvLcr3FgOrigQPQfXZsV3Dqv1OwfEy8SCM300l9cRAf6nZ317fpXVHxt+wVDHmYwYYz8a/pVZbJ+kISOkkGWkI+6zi2+/kAKKis0is4J+EIkSerkWhxuX9BzA3P8hRzlt+VXVZCHWK6OeRxa/bwBZ0WzMDQ4V+gF0v9g6yHiR3jMOSMcr1O92kAKH4sWXjOorLgm+Zhbow/DUfscYzeIyERNGq3C90NvZAiZHxmQX0HRHPpE5ZKx3Pqs5UsgykSz4jvrzOdrvhEC+LW3clKTekdAfRdhpKkbs5AEFeF9qz8UZN0cZ2wV1P0h/N+EgVDxbnVPETDXcNjKV9z6pENZ6r3b4oZxeB945DZeLxcR9C9aC6KM/PKSbTLjrMw3z8v3MoIgPfnGRYw7c1djpTypA9HSdb5iCbKY9FGGTYLdCeu6Ls0Qm4USP7j+TdHfOhNCtKjpe0fxVABubrDn9Z55MQQEyLzrialIKNlOPwNSgI+xdTkHFB4lqZCAehYH9dn+GlL/sV5QVnt1liA07Z6QZPIZuVkKrTVxmkzKH1QQxVKap3OfUiKil8/i5tipBmWnIOookv4OmsDEvBetw7ODecocJ0wu1JYdK/HKiRApCmv7+tuMntKc4SNyZjRYF9Ds9xulCXHr8mXu8OA/UfJ4UmhiOwDGk9Ux1xNAb8Gig9+wyjAzcP0uGOv9fyzzFtV5QMLnEfRSU2DdJfHPbx7J7cl13I
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(508600001)(8936002)(8676002)(6636002)(316002)(36860700001)(44832011)(86362001)(40460700001)(7696005)(47076005)(4326008)(110136005)(26005)(336012)(16526019)(2616005)(186003)(426003)(356005)(36756003)(1076003)(6666004)(83380400001)(82310400004)(81166007)(5660300002)(2906002)(70206006)(70586007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:22:14.6843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af204d57-fbc7-489c-2278-08d9d4c25404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5185
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is observed in SRIOV case with virtual KMS as display.

_raw_spin_lock_irqsave+0x37/0x40
drm_handle_vblank+0x69/0x350 [drm]
? try_to_wake_up+0x432/0x5c0
? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]
drm_crtc_handle_vblank+0x17/0x20 [drm]
amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]
__hrtimer_run_queues+0xfb/0x230
hrtimer_interrupt+0x109/0x220
__sysvec_apic_timer_interrupt+0x64/0xe0
asm_call_irq_on_stack+0x12/0x20

Fixes: ba5317109d0c("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 2dcc68e04e84..d99c8779b51e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
 static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 					  struct drm_atomic_state *state)
 {
+	unsigned long flags;
 	if (crtc->state->event) {
-		spin_lock(&crtc->dev->event_lock);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 
 		if (drm_crtc_vblank_get(crtc) != 0)
 			drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		else
 			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
 
-		spin_unlock(&crtc->dev->event_lock);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 
 		crtc->state->event = NULL;
 	}
-- 
2.17.1

