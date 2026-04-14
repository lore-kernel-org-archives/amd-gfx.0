Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B60F9D0C9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2703B10E5EC;
	Tue, 14 Apr 2026 12:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y24exLd4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B723910E5EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y135NVi5dH+J4VrS2j8DGfpEz/aiefJnNZM2ZDTZPKNe3598TB+q/uQPL5JyDQYbQX5UAi/8ac8AQHxIDVjo2Subd8hk/CTjoNC8o0lz/Cc4FTiodjHACnVXQ51sS4U7gsKuiwYHVmQxdsOx62Jc2ArgUuXMfilgr2Cv/Vg6/2ISJQfhTSN/VDPz6+43Hj5rIKvkAgj45yMmglVhpI8lc4kL6YMAGjRMuIZVInn68ERsikR4VwgPfVcDwm1rguMft0GetpbiRUXpKw6tIypDx61vy4FSHLdDTDKoCd6lqh7XeAmmu/CGV0goqql3q5/Nh3nEFk5tKhoaclHqMRt7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWFt/RNUMCwJueL8ehlf9O5NMLfkbg6H+pbGP8GPM6Y=;
 b=dgWhWoyHytqr61hWoZm1T5n36yrKgqFQZ0TihmuLrksgMQDTC+EG2grKfyq+3ws3xYL0EKgm4ec289fhUYaaStTUylXQTILv8Ii0zzy9NzfzX0xXz5zFGUIQ6J/QUZP+6Y5vUWi1FrFsJK+Na1SnjUQdx6izCv2n+OL+g41uLtb/gtm5ky5lGaPkQ2oJO7pjZ4iQOrEYnvfWelhIpBAw08EaLHafXbYIJxEs6g/njiAMrD/2VqIKO61Tnun0AgJrCQ+9FOscFT1xI/yX39vYqC0y3R30TbJnKKBouDGsgQHYlGxDiyhGlZj7DZK58X+ywpK/0625zlpTyq2tWQc76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWFt/RNUMCwJueL8ehlf9O5NMLfkbg6H+pbGP8GPM6Y=;
 b=y24exLd4CbVJSzyLXPzEWv8qczrvWnOr+wsFh9OgTXYsNKpfM0ZbrVDiBqZBzt2N2+81wv653e23vLV7LUixv1mg/63wG6/PKdSIO2mkB9dcCU1OPZ5VJCS49zIn+H9AEhxTkXwV8yIRuRU2zmxfgptfmnFP2kiwGXa+IZ08cSw=
Received: from CH0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:610:11a::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 12:43:53 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::de) by CH0PR03CA0335.outlook.office365.com
 (2603:10b6:610:11a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 3/7] drm/amdgpu: Register WAIT_EVENT ioctl
Date: Tue, 14 Apr 2026 18:13:18 +0530
Message-ID: <20260414124322.2335906-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
References: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d78705d-6889-4446-9995-08de9a237c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: GdXVxldn3laSWV43jG2eypaHUBrhT6J2F93s1XYGj2B+crj+SbaEiADzc1Hd6ni+P47tHxlvnsFebixtsbrLZt2hr1qaxb9hRjljROBAc2UPuSGN0ugX6kJ1Nb7YKW5/EJtLXXLszSSng+4gOOFJgItPCVDlxH9ffNvkQySUE8Qy4ejKgpm4N4uWT0SZIjWx7bkTc5ncvEW7yA3lPpPtFwL66U5EKSmZyi/rznACgGEdZZzSj4RkfuKHeNt3GjGXQ6KU7Ne1gG/zPibbD2Cxlxt76QfQBtAY/PMGQz/CeUva5VJACILC8dVuFYGBcruc6Lrgd1VaheSkkitTzhKsnF8CHel9gd4hC+Thrn9ABUnTMOE7vpV0uc2LiOGQcUF2NLWGfKRc+dViK9/ScUMlzBedDNCUeu1M1DnsiHkZ6HMjjkYE3Ev3Dj3mVMSFZFHuF7pFZYzXA2qCHU3k627Zee9igs7pOGMyuVZ9aSQYUQu26rspI5SZ8qpwvOqJJmVt20eVWKP6CIjZneG841kjabOxBS7L9GE3mrZ3u1/AZepFbiANzMY3MuJvWYHKiQdCMYYLzxkkV+MNtn99i5lCVlfkPqw/wHswMZJGmABdTa0bKAmuBirmsuADjbhzypAr+Kcw/almm0tymsdRs0T0aNOd/uS6m/3CIwZKeOaOl1CYEZcZTwHEJGE/yXnkGQ42IwJlZB+QMJrlz8AbYrLXwSqpYqu3Z+3pft/CnNSmsAqXcMuXBEnCrCzRpVO4wL4YWyzehmgC6dQmhO5bGF66MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q5HER/cQ5HG2sdxh4FXtSOcHNdFBwBf+QoenWT8jUD/t6DEh94T5b0d+4jKBs6bd4IsnXZ5SBNbb2mM4L90JCMkeMYOF3Ajra/jrBc5Z1uirUzWFU4duMCxSK2Ni/xMhaIxbGKLyItLKqOv2uXsmsffr878HgkfQ6y2A1l4VJbwKwmc2bNTTBasOH143Zx10+JIreVtqlTfhz6BLH/QoUnYsRm+KwlmoyBwWLmpctcXfytgz1F0CSfQTm3M4+EPAkq734/6KZC3/q0XTn2T3usxz6wH1g6kWeq3GErTXBNhvkFSxfUccfU8aGWPEScGDiZ7YUkQzw1hdkJXRwBa4KnVwctC4l26ThDuPJE0966Xf5zY7WdiNrW8kFv0LKYxbFWQ+ZKtB9JVpKe1O39mypjIVa+jDU3bUlVI2B9xrE+Mkjr5lF76S6E0ih/yleKXT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:52.9418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d78705d-6889-4446-9995-08de9a237c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

Register the WAIT_EVENT ioctl for render-node event consumption.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f4acb785b3fb..91b143c3683e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3079,6 +3079,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

