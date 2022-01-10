Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D17EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 05:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8609C11B76B;
	Mon, 10 Jan 2022 05:14:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F8C11B769
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 05:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILsQa048b1SlkOPDm6WB91W2/xCdQyFcbZQDJ7JPNmQf9Ka6sFV7JaBUhdc8lsHJByLT9JlDSeSYtYkXgDnpgu/A78DoMT4EpTvFncyPPG5hcK/rQDopx5dmnmW3PY6wAIpDwkf7kV1VJYWwtXaKAAswnDOdQcKdRJ2rY0KWga1u5dNd/tJ62VK9Fjik/sZgdhnfwn/pcQE7ag5Q2vkFTVHuHxsBg5v5lzLez0Zbj2TJ+2pHYOOguMomTBynpr8upt/V28Us+TcM/TE91/y3JNpBuwKr2vR2xdWYU07u5xHDuDcsUe10OBIuovauDmca91eECR5q0smKns2+uNXQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIJa7yJC5PIdOj+azzCNKJW1taALyv9TQALgLfeygoE=;
 b=ETqTsGxlqfzFzgTqZ9cKhi7KCCX+CHGlVX3TzAGjUUP+g3roqYLwf+OlbeuOyg6tNfEGHjXoK9WxqfZT4FZuV8OyBoeqK9xPDCZnqNqh7qe3yBVtfuq7kSxTYu39hpFH6LpxWNEraLCiXvTNUHfra6gB21Bl04eLo5jt8tKlFkp8Cc2rLUqTSIVJBzqVnQwASeqWwazcR+wY8gHi131yXXQtVv3s7sNJuO5mhvIWfsyOa9W6T3SrBEDIL2AoOU44VHXR0B2xe+bpTlXoo3rBl5669mg3NWhls9PzgwI4Osq81NH7kqjkHfZ4hXVkqVJgyyb0HcrRylWWTIy7WvqlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIJa7yJC5PIdOj+azzCNKJW1taALyv9TQALgLfeygoE=;
 b=1DGEZSW4RcGNVwEwQCzu0gjrZmtQw1X+eTzt7HuGH3kkQu04nBchpgQnVgnSHXumnltbFWCEwcwxTnu/ONEVG/WF4gAdQ6omlIeJ2rJw2ruROcgmrhZI2ngMHOPbfk3lw8tiswfMe/JlafWIxPKXJb7t0rf4JZ1jsMUuzWQwbGE=
Received: from BN9PR03CA0981.namprd03.prod.outlook.com (2603:10b6:408:109::26)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 05:14:00 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::6b) by BN9PR03CA0981.outlook.office365.com
 (2603:10b6:408:109::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 05:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 05:13:59 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 9 Jan 2022 23:13:57 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <kelly.zytaruk@amd.com>,
 <qiliang.huang@amd.com>, <bokun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by local
 interrupt
Date: Mon, 10 Jan 2022 13:13:44 +0800
Message-ID: <20220110051344.29134-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 728ddc16-90e7-4d53-e7c7-08d9d3f802a9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5490FCB85192F41F3F6B5BCEF1509@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxYKUnMWJevVD5zjh7yaL6rt+efyV+U/98wWFxUaWBlzUKANf1JBsX1fXRDKTZqPE++P7cBkeweYxBTHP5MmLhPT4ca0y0vCmobMA7Z41QD8Qk5mFRgN6YQBRKc3wQ5QN+JUe/zrPk7+mvbM/+wNQNri6Fx8tdHY4D0ZE30Q5mqjxumgvBV/qUfiXah2S2f9g9IdhOYqq5DepdD+FmpZ6inOcHnLXUUWXpXz8o3iYbzWCkE7ZD4fpgtYqQK9yVjN6NZ7zPyPYKIqTZuJoTfxUbK2/uMrM9ErHCBgWlhfjWCbgqyCikSI+MrGMS+waZJqARktzjgm6/kv1SVr7lgFCn8KtIFQzAa9KJaKS70l8vkKAH54rtlgyJS1XswniK+XyP8bRUdJ7qDghRjTDpyqz22Jwid5GWG5O9lYKOM40192pZjI/N3lhND4h8cS2RnBEC7yBHWsrEy8tNh4mSlFe1+Ngwic840nV1J1p81GqxyesPkdNyvmlhzOlaAkpHk0B2HqMNva48t+lnhuQvM7EEFDkn1Ii8CjELPi5s4EQWPq1GH8e6zY3L4QHrMa/b88xK1asWLQrcASSkcitxHqNxb6XWSysv0C/qHHrdWAcH/SWQIJ1/cqKXWNkGP8jEJ1lSaVLFqRwvkGQ4ikK0p/3dtKDID7qDQE4x5cOgHEJNuKNhwRGSy7W/wHXRrTYcfuLrZLrZ0lMijyCQFiuxozxfa2wCfFRzPBRX+/xW+JYZ3J3ryerAx98ollMTgzuLjR/yKxfeBtn2yEP1W/RBVe42ot1KegthX+1bBes1VCXq8Hm03nwyclAgL1yXEfHga/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(44832011)(70206006)(36860700001)(70586007)(336012)(4326008)(83380400001)(7696005)(82310400004)(5660300002)(40460700001)(6666004)(110136005)(2616005)(2906002)(508600001)(86362001)(6636002)(426003)(1076003)(316002)(36756003)(81166007)(47076005)(356005)(16526019)(186003)(26005)(8676002)(8936002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 05:13:59.9206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ddc16-90e7-4d53-e7c7-08d9d3f802a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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

