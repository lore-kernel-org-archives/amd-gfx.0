Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84441C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 11:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE96112357;
	Wed, 17 Apr 2024 11:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQZvuMiC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D9011337A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 11:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYtuRmKJKz6mGXbRLlwmL2lIqgq3U1Hu6Y61/jTilx4Vbknf2/h+lO5CGuuEAcP/y09GU3t4Qs1H7IutdIj5g2dp4KSfvJEg5cRFnXOcmy/Bx8572GtruQUDzdR0H/K6NdfHhh0witY0As3AMixEYW6tjxkuzGeyPJJKTuMPFhEhA4oYh1p5ca4D6kGzs5IKRhsvNOpznteuRMT3ragHvB0krVOuI7BOd4FumzVG8jB0AUAIxfHsdt+RawGpDQK5gUqyIeHGxrj5Z6pFr+NRPdzQtlIQNHT+iVKvA+rqjVpgmKdlkJQ4AA3pb/8tAnB845SBU5cCYds2oOGeyWatIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O4dEfhs4csoiiRR7SmNEzvPYE5ObaIcehjmEjUwgJg=;
 b=WwXVTd/221S0ZX3ewFCxEaAJrMQUSV8sjqlqjcekbsQuFRozm1Ix7yniettjY6aD8qIoOhrV2Me/LOli5Mbecb1pU/oKHwA0amV/6kIY/AZQs2W16csHfs+nMDO/jgSsqHNne5yaWfWYVIHgHBJQ/oEUOO21gpvKeDH0OP7/Xd3mCl9B46yvFLw+Y0U776kXrrC26mqQXBQs8C8ncfN1DTXD8tewNwkK1nzvxkRSngf5/Yi89vCG5gki9IOFb/3CEDHEJfANPTl2QrAO4XwVDYwxkC88xzdGIz02uPyz9Ogaz9BeuRCvBtsqolouVaHNumQwiLPW0O8emKT3NFuMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O4dEfhs4csoiiRR7SmNEzvPYE5ObaIcehjmEjUwgJg=;
 b=VQZvuMiCaX04yB2jv+MCcsHePxxa+Zn96LtJbV9MoWzDGtAMmMMGZB6YCESBzNTsPoIKFAT7Udeysb1odYYncRFYdfSms+/b61Vi/HOeCWNUMT4Rc8B+BhFC1Ti0aaA3kHWWjI4X4g9By8wKCmFwpXS4muf7V/zb3h6E0WekmpU=
Received: from CH2PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:52::28)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:31:34 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::29) by CH2PR04CA0018.outlook.office365.com
 (2603:10b6:610:52::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 11:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 11:31:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 06:31:33 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Wed, 17 Apr 2024 06:31:30 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, <horace.chen@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Deucher
 Alexander" <Alexander.Deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, Monk Liu <Monk.Liu@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Haijun Chang <HaiJun.Chang@amd.com>, Leo Liu
 <leo.liiu@amd.com>, Jenny Liu <jenny-jing.liu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
Date: Wed, 17 Apr 2024 19:30:25 +0800
Message-ID: <20240417113025.2886905-3-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417113025.2886905-1-horace.chen@amd.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: horace.chen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f1f02a-6ba4-4e5b-0369-08dc5ed1eff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XESiv4nw16mVLFDEsxmf1R+pN0YFkSEciD+1BFa3MslVrm4Rr/2Z/BD67/7+1uJWEUIUn6mxpVu01sTaVZ4wXcVKcaI3MDfjs5VPnMlNUmvhcomDvHtGQ8OsMOj4e0vc0qL+KVvOMMK/0sLS5YJJugMJr/AFF0ffmyOfEAavaYyAxPLEW7vIfce73YPEOGPIDLN4QeiCQ2hHPaWLG0njDyP+b0ePx1eNGJDSN2hVuLbuVf3tzm6daYxlwx1X0jM3docTFg31rV3dctQMaRBxXkLcoC8JU4sCtYoB2ZwUe5GhwXQ1xm30inUkKSSCiU7VuGN2SNymqRieulKqawLDEA3IpAAW3P+r+VF6hsS/atd+TkHU2C3sybQbMlSSyNjRvk3bJZG80cLYI7+ywwUTAf2vxhG7rmaXZShtOKRkrc+HZe1ApFIE3YAfzFk8f23Gli7SkIXPAGR4gvn+4crniWuoVGWT449ntg/K6nDMNWH84BmxOYEzzMbbfzNf78ALzjisOtohrCAjVmLJiY8quQDeq96BYG+bdyE2hO+F71gNA1UoZ40/3G7MGZZKQugXgUj9VAA3kACPJzyRo+73G+XHOTgAEJSe3rm805xqV4u3Oi+pe8PJiFdCM8lkIJZaz0ojtyGuPKzO0MYawsJ2eEO4r6pch+6TMG6uGI2K0u7aOivfbdMM5evfw/dCvUGGf8ElHsNa1LTZvgtwsBKhW+/9Cbdg2Ld0an8fLgwtZQ5icYFImjA7aZ+HSKPzpOA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:31:34.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f1f02a-6ba4-4e5b-0369-08dc5ed1eff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

The MES firmware expects synchronous operation with the
driver.  For this to work asynchronously, each caller
would need to provide its own fence location and sequence
number.

For now, add a mutex lock to serialize the MES submission.
For SR-IOV long-wait case, break the long-wait to separated
part to prevent this wait from impacting reset sequence.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 18 ++++++++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 78e4f88f5134..8896be95b2c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -137,6 +137,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->mes.queue_id_lock);
 	spin_lock_init(&adev->mes.ring_lock);
 	mutex_init(&adev->mes.mutex_hidden);
+	mutex_init(&adev->mes.submission_lock);
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
@@ -221,6 +222,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	idr_destroy(&adev->mes.queue_id_idr);
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
+	mutex_destroy(&adev->mes.submission_lock);
 	return r;
 }
 
@@ -240,6 +242,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	idr_destroy(&adev->mes.queue_id_idr);
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
+	mutex_destroy(&adev->mes.submission_lock);
 }
 
 static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6b3e1844eac5..90af935cc889 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -85,6 +85,7 @@ struct amdgpu_mes {
 
 	struct amdgpu_ring              ring;
 	spinlock_t                      ring_lock;
+	struct mutex                    submission_lock;
 
 	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e40d00afd4f5..0a609a5b8835 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -162,6 +162,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
 	signed long timeout = adev->usec_timeout;
+	signed long retry_count = 1;
 	const char *op_str, *misc_op_str;
 
 	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
@@ -169,15 +170,19 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 
 	if (amdgpu_emu_mode) {
 		timeout *= 100;
-	} else if (amdgpu_sriov_vf(adev)) {
+	}
+
+	if (amdgpu_sriov_vf(adev) && timeout > 0) {
 		/* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
-		timeout = 15 * 600 * 1000;
+		retry_count = (15 * 600 * 1000) / timeout;
 	}
 	BUG_ON(size % 4 != 0);
 
+	mutex_lock(&mes->submission_lock);
 	spin_lock_irqsave(&mes->ring_lock, flags);
 	if (amdgpu_ring_alloc(ring, ndw)) {
 		spin_unlock_irqrestore(&mes->ring_lock, flags);
+		mutex_unlock(&mes->submission_lock);
 		return -ENOMEM;
 	}
 
@@ -199,8 +204,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	else
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
-		      timeout);
+	do {
+		r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
+				timeout);
+		retry_count--;
+	} while (retry_count > 0 && !amdgpu_in_reset(adev));
+
+	mutex_unlock(&mes->submission_lock);
 	if (r < 1) {
 
 		if (misc_op_str)
-- 
2.34.1

