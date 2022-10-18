Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC591C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 05:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDDF10EE47;
	Tue, 18 Oct 2022 05:41:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0379210EE47
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 05:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjC+25yB7QQqj/+hdjWXec9I1eEbBY8/rfgDL45HX78w85HYwNNsmRblYL0qasIHZKzlKarZyLzMrh38GZ1ollULeABrB47WKBZ2CyM85RRdCya6FjB3OTXPglCerhqdflP+ylICwr5Es1T9Gpbffocm47d/lYW6fyg+pntZ14I/xKGZZejN6ZbaquwcRiUh7H/PsXIAkeRVQejjXk7S4lsjv7IfSxmriUP1WiXNyrZwsyHb5mRRh0kz9h/0/3LYdY3zRYjN8jJpXYMsd0SjFm5835XjJpTrnVjig8jGUPPaqJMeiJINd+aFHhG+U6sfg/pBRS9u9frsrVJOopqd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2g1jfWID4F9VzYLu5vDlH8QhcDIiDXPdNuZzY4QcG8=;
 b=fLoYvNgfIB3KydYcTLBK7GiMNfTnUMJSicXVQWolFmCqz8kC5OwBID1WlmV6HcellU6QtPJNdQAetAlX+aRr7SWcS85IKzlkawsnf+Hz4tKXdICjMwVCtRV5sT/+1w+VeVUlXze2+jeUEEaxkeq8ntIty8n1rr6aIPf0sWDluWmTK9NkXZ+YK/2nzBSzBcius/6y+JGWJQMfRBQn6jQuzqH/gxmzSZKtpU5Kd5d7zbwwS3QUWySUhzVwAxWbwaJ1ueceoOnN78y5fLOBLnAKs/gzFuI6bn/pskCSzvbCaJwueiTvD8XflHbuHja6Af/zL+x7NhRpRc9/gvvJwk7Peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2g1jfWID4F9VzYLu5vDlH8QhcDIiDXPdNuZzY4QcG8=;
 b=Vl91wbIGDfAjZGPdY+aY8aWeijockDRgYXQUFafo4OS60G/gzV5RHy1u6iTx3Nb12AOu3FVs8WsR/paYc1a5Rx+66MhoOetSuY8NsCzJDM05dPNClMEg/eNMRD9Yo5HMNzwiIBjW0kdnzjypa4LteIyhYo/QwNrDz1E0FvZaNvk=
Received: from BN9PR03CA0390.namprd03.prod.outlook.com (2603:10b6:408:f7::35)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 05:40:52 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::ec) by BN9PR03CA0390.outlook.office365.com
 (2603:10b6:408:f7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 05:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 05:40:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 00:40:04 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 18 Oct 2022 00:39:30 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Date: Tue, 18 Oct 2022 13:37:43 +0800
Message-ID: <20221018053742.135890-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 038c4f45-1b1d-41eb-59f8-08dab0cb516f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Regstvb0nEsqSeKw63myEU3clBiQDeTDE0BwHV45wZVNSW0nVXWgID/iuYs2Ae0habsx+aZLpG4u+KJGQPpxSfIRv76nuM/A+YD7JXAdCmp5xMRcYN3Nv2cn4a/2W4GlKF5i0Isbpaa4sPReKJBJx9OEFPI3F/pp8n6bOAp4G3TncpnJXWO0McuHECMB1gG5IFwGOx1B4iVeoso04uZ2Yq3wnufOkb8Spyicq5zzY+IVJrMTDMcgxYtKDpJ6EsHZRwj1ta1MKWjiS2CTWkjuSmaK6QkR3QfcU/bl2JUe8xtolP8xX8eFe/FJrNfalc3QD1vHg8v5sZ7eMfavsUYGEI3DaPcFUe/z9VCUd/g3VzDkdVYKal+Rgw7rBKQFprfL4EUkqA2miTcC5hrP83YbIzLx5jynVq5of9g6/GqKOqgM6z8V0XXvny2vnbyY1dChdN7daV+ILEnryC8Ha93E0DboqB/sc0xbn6r7qsmsBfpFcyDy9994okbqOoqh3Fo7OdNXB6LZC4uooE1J14o0L9WQUJphcWT9UrPwogpqGghjnY/ILjenp24R0t3tixKrovp2B4up87itbh/G+cNcSp7D7OE0VhzlnAYWc0s+lqg6yZWkvO162MHLDyMTiuQdPHcvC5OkJKk/4+xKUTT7V603yNen/5NITsYA3U0ubJTLEVckvHyylZy2Gi5WhDH8XkXIQ522vbKUgzbJtFJc2jG9hCrgMiSrjHTrG5koq1srGpjvhGgYFZ84Xw+7p+sLxDYLrV1HgfA14xCdMm4+OVZuZ/1Enl7P62FKXx4XOGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(316002)(6666004)(7696005)(8676002)(70586007)(36756003)(70206006)(4326008)(6916009)(41300700001)(54906003)(40480700001)(81166007)(356005)(1076003)(40460700003)(82310400005)(2616005)(336012)(36860700001)(186003)(26005)(47076005)(86362001)(83380400001)(426003)(82740400003)(5660300002)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 05:40:51.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038c4f45-1b1d-41eb-59f8-08dab0cb516f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
If mes is not dequeued during fini, mes will be in an uncleaned state
during reload, then mes couldn't receive some commands which leads to
reload failure.

[How]
Perform MES dequeue via MMIO after all the unmap jobs are done by mes
and before kiq fini.

v3: Move the dequeue operation inside kiq_hw_fini.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 42 ++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1174dcc88db5..b477bed40d61 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1151,6 +1151,42 @@ static int mes_v11_0_sw_fini(void *handle)
 	return 0;
 }
 
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+{
+	uint32_t data;
+	int i;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+	/* disable the queue if it's active */
+	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+	}
+	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_EN, 0);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_HIT, 1);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	adev->mes.ring.sched.ready = false;
+}
+
 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 {
 	uint32_t tmp;
@@ -1202,6 +1238,9 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
+	if (adev->mes.ring.sched.ready)
+		mes_v11_0_kiq_dequeue_sched(adev);
+
 	mes_v11_0_enable(adev, false);
 	return 0;
 }
@@ -1257,9 +1296,6 @@ static int mes_v11_0_hw_init(void *handle)
 
 static int mes_v11_0_hw_fini(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	adev->mes.ring.sched.ready = false;
 	return 0;
 }
 
-- 
2.25.1

