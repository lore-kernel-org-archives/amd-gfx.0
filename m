Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901DACCF2DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACB010E4A3;
	Mon, 19 Oct 2026 06:49:08 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95B110E4A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0MSWvDAB6xPvBq1aT98HzsJ3e4hy8Qit/vUOp8pxJuKoTZuQSG60Jj/rDt7U6gO7bSrZtULnEsLzd8e/H1zY4UhPshX7X/qZ+EnfnumoVoX/VGJGm58Ag6gHhVXBUzl810ui2czFod3lnQl4zLuRBkuiY90mAtDrVuf1Q07ujcbohqcIy4PbNdkUFC2x+wNamESrUV2Egyh0TjCLZA76yVQVyVnr63fG+eMQWcAVTIvRZXzzCDPwNwIdJwA9RNZ4SIsB4RGpEqWpmH0N0eYxkv7k+PImOb0eSI/jkFLDObUBy+QG6GQV22awJkr+fNffE6p5xHztCoXJM9Xm9GglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByvvRjuW5hJzpU9tVK+khY8PcaLwCjAByljcaOOgDok=;
 b=S5Z0xHS6+OGZ2sUg1BTR1pA2dKlWlVyaf3d8oGOXmBG62zXk5ojCLSLzonusGM4cjE5AoOe08OpYD241tu7kJPq6gZaHCl4Hlhtqzy+mJeX2pLX6g33RRW/KoodtCULywvYuugMLL6Hp47lqOw7yHDyVrbu76sRrQnBkuJyl9xIHkvlxFLDBp3EFkAB8sNfAIGT5bgEXLUjHLKNhtL7tKMFKu4+wC1uBO3+OdPkYcwIXtiNsZo4xHxLlQF6oX3HewGfgVPz5YDR37aEAU0ONLkPYTi1/iRc2wYgmgSmhyqsaFSXKj9ogXkAc9oH0KuWfHhrLA/NV940NG6AIDxvj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByvvRjuW5hJzpU9tVK+khY8PcaLwCjAByljcaOOgDok=;
 b=cmvKcVi/y6jL0qlkRc+8tQLig6PV9zPz1mfJjw6WbWaSBJRi8kSKncyeRx+ChvAT+Kwd/nt6s0CzAAMUOhEBocBF5WD/b54QVFP2Dq9Py55FF+u5rBH9OwjPh76hCevjhxsGdosOsTqRDyBmKb0RG18DJZ1RDYzUODN/nDH/Whg=
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 19 Oct
 2026 06:48:58 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::47) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 06:48:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:48:57 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 03/10] drm/amdgpu/mes: skip unmap queue notification during
 GPU reset
Date: Mon, 19 Oct 2026 14:48:31 +0800
Message-ID: <20261019064838.2577746-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 52018364-9176-4adc-ea77-08df2dad0cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0I6yJ74GlPj5tng3ob4n9pk+Dz8CByT0VUevNACAXsNDt8bFe/kETH0b3nhHA7gdirAM4F/dQNZOUiSK3khMe5UtT0z+xkBP/rhH97bUZuhrte8Mg0t6k4CyZtB3L4/1z4ucB+XynNmODnhpuT8HiIfvd52ZeVFyDdTs+FEmh8LLMvUelAN+L8WmgPRnFeA/1qULLVZzlgKHqEUlqsUf/ArhMosxmizogAF1x0wtUCer2wMTiezoH0iwhrmYIJVqb6IJwyFYevVRPva9fh4/15sBrCYbl0Trtt+FTjRCKPRvmovHSvGOHawh8W8flawzOP3uh8rxRZfoAj3KnDU4uZ3eh7q+uClwLj+VylURUW1eME/6xIIPZSMcDw/Pr9z+fcvqE4Gj8moNwnpOuR9UNjlS6vFExTa4YrSigA1OKXhDpWIaf6mbo6GKw7+4iTuwN5l7uO8CiSIqdAe13FWAIL9oRdEEl1jHiKs3vAWEmT/0t7W5qsU/wTfoitewqj+PicwS1vPfbyPiphq9fTkbwAXyUL25Bl5+h90G+kIpBEAeoyiQuczd37vrZ2yvh8LGOewjxC0IOam4AoKss/oy/v1i7jm3rz4jVoLC4NtjVn6DmbjMhhsNKTj2o79fO2m/04P31JAfiH1qEBGg3ndXkYz1mDPtOonlC2MqAjdLtyefqk6dQ4gOWPE7JbWOasX1TyE5sc4m9Wo5sp8ZjtdvTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X+brnVRiAHj48b6QU/IoWegzaSifexn254ZCx/1VI6VKBCHkg9rlZoTkB1NAM5GTP4sHpU46Ts7cZj8pjXNi9Lg7k5gxu6YhE7JGYV/w6SBAmI34DKxsqJeDhw38PjQtNygILulUkhEjFxrfUErvLxOU/gATlguKNVc6pc/OweCSjGZP6KJ3Po4Fesx7JmJm+N3iwr5VYQHtR0tGY0I85ntCT6hlzskiAJsaZI3TC8w6ScsjT6cbvhzLDIzY53PoUL9Mif0luow480Ey7RNsj7ygBYMwudk/u/+1BeF4hAM4Z8pg3YrWeuHMQqNsrFl7OuEJTQMJItBmNWHcKGLvGFaMecWQ9+DdRaYoTjrMr1N4H2YpNMlm1wLcBJhwY8TDlxOxCCuxf7i1V0F4js3NVe2L60Zb8cIlYeWTpgyKWt/XMqNeawpdetL85zp2yBPL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:48:57.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52018364-9176-4adc-ea77-08df2dad0cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

amdgpu_mes_userq_notify_unmap_work_handler() submits a MES misc op
without holding reset_domain->sem, so it can ring the MES doorbell while
the GPU is being reset:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_mes_userq_notify_unmap_work_handler [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_misc_op+0x8b/0x240 [amdgpu]
   amdgpu_mes_notify_unmap_queue+0xa3/0x110 [amdgpu]
   amdgpu_mes_userq_notify_unmap_work_handler+0x24/0x70 [amdgpu]

Only send the notification when reset_domain->sem can be trylocked. The
work re-arms itself while the HW queues are oversubscribed, so the
notification is retried once the reset has finished.

Fixes: a3e112968588 ("drm/amdgpu/userq: create the same workaround of oversubscription timer")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 05bbbd1afb63..f573453415bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1191,7 +1191,11 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
 					       userq_notify_unmap_work.work);
 	struct amdgpu_device *adev = mes->adev;
 
-	amdgpu_mes_notify_unmap_queue(adev);
+	/* MES is unusable during GPU recovery; the re-arm below retries later */
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_mes_notify_unmap_queue(adev);
+		up_read(&adev->reset_domain->sem);
+	}
 
 	/* Re-arm if still oversubscribed */
 	if (atomic_read(&mes->userq_hw_queue_count) >
-- 
2.34.1

