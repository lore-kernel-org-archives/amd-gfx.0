Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D465F34C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E0310E4B2;
	Mon, 13 Apr 2026 14:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S/ETzdCh";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3019910E4B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbn3CI+4SUJVbzeWZaNSb7Ufr2oyrLGy55eUh8vSv4Ht2ldp6ZR82wuXyzWB+UsOP1k27nXyHiCZQ838+64zUp3TrfqQl4hMesE5o/oFB591vBimk/9FMUAOWmAXQbrJ0SdaKIdun5mMrIE4A96oq75Da9TBGwqNkRER385biwlg+CV6dSs76HFuq7fXua6eWga9i7fiAKoUfP96v80Prl+wwzGesO81YVn/E7eDTWb/WEUZWo+W+rqeJJiewc9/csipQTjN/Ku6BTUPb458HPGg6pwqx3B+KEuz1GzRG8jwpvGx0uwwHKh8GRqE2KotXi4xT7J2SND/SMj704Qbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXa3smJSo0J8zcbOH0DZ17dWpZgmf7IJG3pGCs2pqNs=;
 b=dEY8jADmirKSEj7lrHUppz9CAngEvoRZxmtOmV/eGUn1kND3QZHvAVIPLcjGdMR1hgzIfhAOvmNMCsIS/TtPvhBzxGD/0lDFRLkRj5lzsTUzlsWXpLSVGA+ZKzjGntRB82mwHJEkHNDML6lG15mZ5nkSnvl7pIS/SvGEwhXF3jx5yHTJd3PAIT6YfL3oACXUUAj7OOXK+fMM3Km2Xn6xwte42wuzr0Fu24hRm41jgktRj+t+0CYmQLpugLeLCXhgfjn559UytV9nwQ7yZNPp+3FPf1f7oZY2VBH2/2fnJ2FSHTEbqcCrknsk58BxotRCAHlftZ2uuCSguRNknNcjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXa3smJSo0J8zcbOH0DZ17dWpZgmf7IJG3pGCs2pqNs=;
 b=S/ETzdChjvrtYLu3RexLD5o5q1DbKVY/O/0kV8h8l67uZfVLqRwbOULRhehvZ/x8TL2MHQkHDCT7sCs35JPMwICp1/sJA8I9tOzUvSy9WtP1rT0JEwDTcPivbPHEJB7Lo7yuwLSLHiBuNxh5m0JWJuip4OXSouk9C/lup6TH6eo=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by DSSPR12MB999214.namprd12.prod.outlook.com (2603:10b6:8:378::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 14:58:24 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::61) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:58:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 09:58:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 4/4] drm/amdgpu/gfx11: Queue USERQ_EOP records for
 WAIT_EVENT
Date: Mon, 13 Apr 2026 20:27:45 +0530
Message-ID: <20260413145745.2326236-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
References: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DSSPR12MB999214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac545a6-3bc7-4b8d-12b5-08de996d1c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2rtdo6IwB46PzOWK36TxP67lpKmZSQZrGLYUn8u+oi9Ie02/bL7irfWkBC24OZCk2lh0dC54aZ+q7zFvaJOa0CGb28c9TgvGmTBmNXzFMoo2PY8eoPbIEk2AAn9PCb7+dN1xu3JmlJpc+R5Ip6aZeasb7kgdF4PKBKE1kZ9CH4xOwDHkvXBe2oVN1Md84BO/veOqT+Nt4XtQogmaNrHA0RvWAizBtjkaelavv4xdGF6QYWSkww8cbetHML/efGUEHyIMJg5Z6Tk1hkWNlEBvZwxDaoRDGaF1Tuiwor5+WeKWnAHdLV8fdVVC1uM48D0QFuH3hxvq1J9VR1BGxaIazHEe6JSsRi6HclZG2ahyMM5rixR1qHA0tBLpnXR9+BmErOuVes3OThaDgDzs1Gw4wOqJ8ndVBpGO2RrMONz/2x6oBWlzaUn1uqg97pxnu73hLx9hEdbX4W5ATgQWMP7ZDZnRSK+waX4cjTNAcE1ZzYGBo4mHVEWIp/+JheQr3wD8Lsrx+OJCuI4ClY6M0rB83huBcAxtCCrk7GaaKo7QfQYblkOXKvNJHoZrabxOIU8jm7zkenmaPt/8Gg6W99iY5jch74EkVR3UY+Q61sL7I0TiEOG+YUvg3n0dYkuOFXdWd9iCbt5kp0JhSH4+S9dlOp09c9BCZkYJQF34e73L2GvNn+VscrwCpUeTR8Rg+EcDAVyRPTT0mGjDY/+rPSqz4m9J909Q9kHQUoUDDt70HgQeeJ0z2fpzQSelyd+7AM8L/AcVIW4XwYiPvDIiWh4f8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sz5TBlvPP/utI8AJQGjQL4nyBzwQel9gqSiX5Q/VBe3vIkhQwB/1WNW+2yuGmurO+iJ5q/iyJ7NwJEvaVfTE5hBpILMYS8ZGiGNyN3W2A1HowEFp6TEQAk3HWvp0im212C3PBfcIWRkUw4q/jpqbT8X8CQokS2yR3/fVyz9Uo409di3AEa0DeR2JJRvOlWbIjSqR67Gt7T6zW0t5mMWYUFX9kU59ivGuU/c7Y7nSuxV526Dn9O0RuTAdVGjelm6Y9NEyhOaonguW6isu8zSaFfk5AOHS+RQk4mYFX2e+fRM8Fu9YJfKIuVunNyoJMwZ8L7dKzskokOI7s0UXqCz4pIJlp4i/wz4UCsOVLze/+OZx2WMcZbdwm42gyPnO1DWtJIkCQY7qSIwJS3Cboq88hoE6BmyHiUlQigdI/Jpcw1c4R1dVD5LJIU+Ycgg0VKRI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:58:23.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac545a6-3bc7-4b8d-12b5-08de996d1c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999214
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

Queue USERQ_EOP event records into the per-file wait-event manager from
the gfx11 EOP interrupt path.

This wires the first producer into the WAIT_EVENT path.

Use the doorbell offset as the current queue selector for queue-scoped
waiting. This keeps the initial wait path independent of a separate
logical queue id definition.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a51e83cfeca3..b81b2b84c77f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1318,6 +1318,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
+	userq_mgr->wait_event_mgr = fpriv ? &fpriv->wait_event_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8ce039eec2b3..725c33ab5c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
 	struct amdgpu_eventfd_mgr	*eventfd_mgr;
+	struct amdgpu_wait_event_mgr	*wait_event_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ff43902a9c48..20864d12ab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6546,6 +6546,10 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
 					      queue_key);
 
+		if (mgr && mgr->wait_event_mgr)
+			amdgpu_wait_event_push_userq_eop(mgr->wait_event_mgr,
+							 queue_key, 0, 0, 0);
+
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

