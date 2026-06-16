Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52A1CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4891010EA32;
	Tue, 16 Jun 2026 11:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsPFRHNQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF6410EA34
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRdK+s/HtgGv5+S9kqPE9vf0N3KVXUPO2N3GMnolrpvP4GH+QL5wrmpGgFjPH713bJ6KH7V9GVnOpMCvZhKjpk/O0Hpm4aNA6X7dzhPx43h1Qj8e2nyVLsEtk/A0niAlTzRNmYomIF61WRDWi6o7ai7pQWqDt0f+gjdPQOGA2tWZQ+T2c/tsuC/nEcodsBex92nELhAisNrzDOiYoLwIsPW8YArvLf7Urtr15KmT714pFIejBJX80Fm38g9TEtrfXUbk+yMvgr3L6T9tpNA0sVduT9j0nY0HwpPmrfEgNFOVO5Fw8/sT5Jhh4Yp4P9ULYai0IU/SwznqJvYzWa5CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgfFeCvh98sinijLriHdX2k4O2wYZTfUG7UYD6d2OiM=;
 b=YIF90+Eh+mc9eygc8w1cZPcxY6IZfWvLKbZEmqmxsWSU91cCo9heUgWCRQxh/XQqyuO2VOJRCiZ/nQ+n5dQiuZX481GvfSH6u7Xv1qE4cGyI2jnE9sFB4wlNYhhjhuGN4OE+g3N9suxClP2oxVkNEldLGv6uZ5T/gD5RQff8wFD1VVD5goZ0/dQDiuwqgwqxM7wJ1i0gIH2a8DI5qvFBLqC/Dcs30jspKfdSg62cka6kEx0C/4Wv0ajLVIk13b/FnR2uoIvBuCn0kea27wqA+ZCbzi77exBZ9Ud4EmwiSvKKVnlbr4xXUfZYF2Jhi9vbDZlO5hAN8Z+PGGBt53fZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgfFeCvh98sinijLriHdX2k4O2wYZTfUG7UYD6d2OiM=;
 b=MsPFRHNQ/6HtsKWwECejXf98XiDbeIAXh7Ip6fkYNdqk8eh7P9BCqV2DprskECdrp1YvQby3PQGypPfmzFJnBLrZJuOxti3XaPAPkF/Th0aemri/0av1OL77o4DavWvlcC1x2saXWIXUYAwgTfUwf4AmtHxAM9UKEC8XGyBLAFA=
Received: from DS7PR06CA0004.namprd06.prod.outlook.com (2603:10b6:8:2a::19) by
 PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:13:38 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com (2603:10b6:8:2a::4)
 by DS7PR06CA0004.outlook.office365.com (2603:10b6:8:2a::19) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18
 via Frontend Transport; Tue, 16 Jun 2026 11:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:13:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 06:13:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 3/4] drm/amdgpu: Register WAIT_EVENT ioctl
Date: Tue, 16 Jun 2026 16:42:41 +0530
Message-ID: <20260616111242.2922144-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
References: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 990f90a6-695b-4414-484e-08decb985059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9MHHdsWPRwF+xknywQypumjW72taPEy8qVQC7Z1QoI6phCOgQAVUn+OiBXtSc4T0wHPPxHvOozCJAQyebflkORH3KXpAwPCTjCIUGqhIOO/nl9pFXRwYbA5EMvFwXmuc6+yfRtGOwOW7fmPuZutvc19kX19cJv7I7OjS8A48W/zKYTeUO4dSx9hbdK8mI8pueiL/6yMf1ryZlIwqXv0AaaW0U1OGKPXBiodKb60p55ZKnt+kyMJhs4rhPqAX1NgemwOYJCGQ3wUwFvtZepRtpH6lRsoaRlMtmwDZ01TuBTae+USG9wMt7wK7k67kXyI4avth5OqsIz2hDXhPl52F0r+dZIsLm484CajjZlXXp+2f7O7DP6PX0tGQKTE3QJQyoaSu6cW8MXfDN10Q92WxgS6nUPudHNsVY8oya5Anb/EA85w+wfdaqvHbJSu6UBZ9XJBsiNUGuZ9A7PZeM91+t74ryG4gIwfHu+TElHiA/Kw2zlUXa5xJnW/nt0zS4CEWl1V5sRKxBkaFD+lrgiLC2emIC/lDhVvbqvFtFSsyWPoTwFAYf5m8temVNXr8c1TnU2ldxU9vxr3exgyXr6hQ32Z47w6gNVTimV8lLNVTwFKNpyoLyHUEXpUxaPVCY6Hslqq7xVoHDRh2qfnf9lIs3s5oGoI+EkJWgdJ2SQB72XLLoRD+E5+3KJw9QLBpUskiYnZTyIiDhW5V9ick0XnbmGnMStS2Mgq79csyCs8tdq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nnkmLi6speyPF0Zy8fBTIaUEjugPiXWM8C5+i4UWJFDZJkMpeXviPMEJy/Jwmav0cS3mMYcnwI3vwit0soGctVwn697b8SwHJ1/YBdde+EEO93H5UvxtBAOpb3jANx6FwyDf8Q4v7/P9NZ2PAMRBCAVKbjcKcm8j8IxFo2VHZiyYp8doD21BLGsi6KcBIP52j5XygGtBzNfog8ljzNULfx3+Arlv2srI8fPsqik4WmbnMJWaOMcqWmgDZdsP2U+VWkv6eZ2yETunK2SOphk2pjcSdfGNSZmvf5Z97PVzVxKKToJfWZ3F5wOwS2aGyxlmNCeeP+5Wls/MpURAlOAEuId7dNvko35rFUbWFecOmrL9XmqUu9WtjRp3T05R5LeXJYSiZ2Ffbmg0L562qVl6Fn9KFzPwv51R3J64LZoDC+HaWHnosABYlsWRQ2BhfA+x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:13:37.6373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990f90a6-695b-4414-484e-08decb985059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

Register the WAIT_EVENT ioctl so render-node clients can wait for AMDGPU
event records and receive event metadata through the per-file WAIT_EVENT
manager.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index aaa4dd57099f..33f2330ba640 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3077,6 +3077,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

