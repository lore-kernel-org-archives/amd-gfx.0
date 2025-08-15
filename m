Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2858BCA0EE0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 04:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C962010EA4A;
	Fri, 15 Aug 2025 04:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NswmucTW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D189910EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 04:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEn9heONCOyumFgD/RbnZ0rb834sel8P1z2okVl8eQMi8jI9GkyFekaZgD3wziCy4phxYWoxYshW5BJTBwnbmOrsh0OaY3TAO/c+a6qm0T4WgiVT54fHkK8PYtSdTs0MSbJHvkvRWFyejL1JOIZmrhEc35vN4FQpr5Y/nx4CIri1F5n6ws3Epma213e+CyW2cLIh4daU43H+Qgr9hf96MJ3RU5s2MFI47wqv2nCQ7yhZFl5498dvs7I8U3ZePzPFyW6/Pl7LsJxXRppEtFonfEVr/o2yP43sythuwoiqbbwvKBM3ISxPq0FvWzwfkN4U0NADjs6IIJTJt7z1F0zL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt5QuG9WRW5tzeo8aTnF6z2I7jFMo1gfO6NzIFM0NEw=;
 b=E2Z/di17CDjj7vGmViEOSze/GaG8QB4kg3PCT8Y2f92dyoP1iky+p3cWlpR21spFbSH18eCkQNyFffKMGMpc7Z+dI4x+KqrlmmFdg3qAioeyVGvRxz0pDK5kNMAdXjvdrdhsKV0FdrPLVETNJG6p8BzNtlMPTmSrV7FF2jJq+K34+787f0f8HFv2tOzqhHlgzrTuQLG6vNjTC4d5wn08FWOyv6yNtroLAsLV0XRjsCNVaykDs5i8ZPR/W63GpvScpxHacUPlDr0Uj15r1trIkBR+0Eoo6J+eRWr/yY0K5h2hySDW8gQqDR2mvcOXpzIYny7z8GbyEWjOuOoHP6cXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt5QuG9WRW5tzeo8aTnF6z2I7jFMo1gfO6NzIFM0NEw=;
 b=NswmucTWytn4CDe84ufBs6ty0ePcPQqUN1OJBXzDyAC9OsIOQsLh7b1MqR7i02nFfs8jJpfaQGRRkgwtj5gs5k7TGxNlF05wpigTYfMg5NfXTPpjkB/XBFCmLfO7DguNtsgQ/vbFhBUAbKsO62Mv+H2M5EUFaVrnNqvjlLSRKcA=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 04:11:54 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::59) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Fri,
 15 Aug 2025 04:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 04:11:54 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 23:11:51 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 3/4 v3] drm/amdgpu: Add a mutex lock to protect poison
 injection
Date: Fri, 15 Aug 2025 12:11:37 +0800
Message-ID: <20250815041137.301016-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7ff916-1f0e-4f37-13ca-08dddbb1de88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1wBh3egPaSaKAoUONhdYEsVS6ahUNGlNKzBhzRw2DxwwdtVFy6v6H8Ippur9?=
 =?us-ascii?Q?gxAvVuxUkXGvjUfyZGH/f20e1qrcw2Tp+5fNCEWDJlL0DnRUpaUJUZB+UZp+?=
 =?us-ascii?Q?GUuulRIwMb7vp2R1DE6c57SvUXQf/iw8VvlmRNyB8pVOLyUMNGkohgs+GVXo?=
 =?us-ascii?Q?8psfTONKmELI0IpEbJ4LC7yp78MShVkn44g3Qu8xMaIHJirfME1UIxWugf1G?=
 =?us-ascii?Q?1oaHn1ySNEWw8Orvpmr2VlGmhYPCs9fISr6o/DzaxlRNsZR2zRbKrtOnD9h/?=
 =?us-ascii?Q?kHp3I9yCsxAH/k63NFF2JVyGx67oDRieoJB4lvlYZ2RUpLpcyepHOK61WgK0?=
 =?us-ascii?Q?eQo/KUDmAdJEJuDilJx3yCu7BvnBAoOh6hlOBqjFPBHjbp1NopKI6wbBl6p2?=
 =?us-ascii?Q?Zb6EzWPcrJnyh+lLSdkSYZ2du3SXJANSGyT8MJSr7Dri/FhQMI0lOG0OVVsZ?=
 =?us-ascii?Q?UWnvSNP/w4bkeucfPjzEOHbIIShzZ4ER1Tjxw5nwnlvGReDn87LxP2SThwED?=
 =?us-ascii?Q?W8e22YOdpC788UcQxI8cquweOXyFdkIMCS7/LPaQQfR48mnhuv2zURtwFMm3?=
 =?us-ascii?Q?WqeDemgzeQMaGv0vcPd/wfP7c3GMKQwXdCpqkRi/f+8Lr1oML4IJ4v714keU?=
 =?us-ascii?Q?3DRuNB6KJ52IJOCG+vpK40g6qrHQx6/SBc+fLlXoiJV30vjubSfNLYd3hSIp?=
 =?us-ascii?Q?0tkLlQrNkNS6nPqK5Rwqfrq96iExjXJ/Hixn5v7lPEV0prZNSHEqGuiFvG8n?=
 =?us-ascii?Q?KEagwMizj1bMvTi2uBR30dFndcAsmw7g9wvfhsxuDgYJ8sVwhxGwtEdpX+et?=
 =?us-ascii?Q?D0tw2mNkECyc4SviDqIDovKlPb2JWQlUvT72Uq4O38+aXAacA0A0VhhcLPX1?=
 =?us-ascii?Q?6wAEfuqbZ5QTelOfU1KgwswmBX+61Vs/yIQywcr7LAyZ34VeNhHsucJW78uu?=
 =?us-ascii?Q?vouYn3OEK6xTQa/7/0xOTbMhh03cPcaSdGdya+KCG12mlkGPlj9elavLAJwC?=
 =?us-ascii?Q?uP1OJfm9xE4XO8c9G58ndOB53vNQO2wXU8RNjaoL/90LbHaFV3r+pQ+vNwgy?=
 =?us-ascii?Q?hL85Ye19X3QgS0pgO+jh6WAu7/3h1yT4XowIxpnAChfW6AmrCF1HzcNRAioJ?=
 =?us-ascii?Q?u456zOUnMya9Qs1b2lnLkLz0fXWr0kzPMxk0rNy9LAgClIlITUd9HsizuVOD?=
 =?us-ascii?Q?/v8fOlMP877TFqGimRumehth1pFihVOekxvJBYKdsOPWdYOI7karz4yL9nnA?=
 =?us-ascii?Q?iG6ViNnqGVoZvcEk2YN521Pltow9InFZ8nbti7If19CcYE0SgpiO5zv63tZW?=
 =?us-ascii?Q?5pLe+VMNqPQNw9CcqNg/6m3OcBZrEexbic9e6URmFLk0mkD4Tn71Bp+GCK2H?=
 =?us-ascii?Q?Pu1KXNilR8tZQRotqDXZQYLFg++l33kUsJuvRECgluDVI8as3yKO8X8o0auE?=
 =?us-ascii?Q?HbE7T9DQnnhKpXYfCGWHbLAVCtnlQmSaGEUO9hjXcHTUMgm5fNXBfKJVVA7P?=
 =?us-ascii?Q?hLFBDd23E3rTi7JfDVcbPFX1yYvPSnW/aSmh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 04:11:54.4289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7ff916-1f0e-4f37-13ca-08dddbb1de88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

When poison is triggered multiple times, competition will occur.
Add a mutex lock to protect poison injection

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 185b9e538f98..31850a47a41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3503,6 +3503,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
+		mutex_lock(&con->poison_lock);
 		gpu_reset = 0;
 
 		do {
@@ -3560,6 +3561,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			/* Wake up work to save bad pages to eeprom */
 			schedule_delayed_work(&con->page_retirement_dwork, 0);
 		}
+		mutex_unlock(&con->poison_lock);
 #endif
 	}
 
@@ -3657,6 +3659,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	mutex_init(&con->page_rsv_lock);
 	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
+	mutex_init(&con->poison_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7f10a7402160..6265dac0e1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -573,6 +573,9 @@ struct amdgpu_ras {
 
 	pid_t init_task_pid;
 	char init_task_comm[TASK_COMM_LEN];
+
+	/* Protect poison injection */
+	struct mutex poison_lock;
 };
 
 struct ras_fs_data {
-- 
2.34.1

