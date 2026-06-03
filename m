Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08787CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9792D1120E8;
	Wed,  3 Jun 2026 16:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0005YOXE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DF81120E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuxPzst1UGU6I3W1hgLZHMIMKSUF4cWCO34ejev79PB+/SAURXYzWe1CmKIdvrO5roKJG0rAEdX44/t1VpNlIqifQ0ohcHZIkUpyEfLZAdJ1ghFDQPQwXQlYl8xR79a1wSJAiQQ22xayZmxjXEBWA1sjXB9+EIQdO/JjdeC1TsIZrpKdHWDuMexgMyYAyrrRLa7iHMEBpWMa0fLdaYSPVcpQ0r4rjqU0Z4IKQvKPSQaTRQTLHY1PDsIqmsmkoCNjbeDfg14zrV9ybybhFdLW0TimdHkiqCbxYhkSuH/tsv6FxUCR+XLfYpZiufWtAZLlA/ljGmKuKSUy+n1xc3XQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVry5zUUpQli7JLJjkD8Ne5oT75KeAadSUS5yxKsc4w=;
 b=gRl4w98Rul/po4o56hNGwTVcUDA786lRv2BAKHA4v7Em6RppWc/FCYNcrVvZ4LWPxxhMKhhHlR25JwXW3aImDxIZo1AXrTmvTosKcOJDcTfA3C2zYvXvjkeyZ6EuS4rLmTdXSuIpQc6IFgqi71LVTuxgWzsogJsDBVTi4aDvsfMekiAK4AoB1Y/kzyyni0dB7mQsGrUjdQ33KUK8UL34Fes2Fy8o2JCLrmkyqBB4nI+sSoS87FhospI/qCff3oGrTIiiKD+B+S3TyrqcdQ0K95tX98F1zD2dPD9Op0N2VMSpSNy5A/4Ddaaonocp5VHNC1POxgLGBmc6Zqer32XKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVry5zUUpQli7JLJjkD8Ne5oT75KeAadSUS5yxKsc4w=;
 b=0005YOXEF12ySUdoGHk/0bg8+zaL9gqoLcSlg380FkqD6Mi7dztA9EiVok0LdY82WOjABSNv2oxaHXSsNOCeRb4xSE3cdEyGF58QciTuh5I63C98DbNtMp/qY/Zb/1sJsktD9FW0iP46FUcA+aZMK+Q7s4ZzuvXyguCsK+zn1oU=
Received: from BN8PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:d4::20)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:36:20 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::89) by BN8PR04CA0046.outlook.office365.com
 (2603:10b6:408:d4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:36:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:36:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Register debug event ioctl
Date: Wed, 3 Jun 2026 22:06:01 +0530
Message-ID: <20260603163602.2678435-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
References: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: f716907e-1ea3-4fe5-6eaa-08dec18e3dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7m3yDWCgAbWDsdlqhajQTqCdiz7Zyw0pAhIqOL48sZ2bxrN/00Ybo3Lemb8e0WYAVytTUrXcg3yvnVFJzc1dn+3gteTn1a8edSYeMXpUpS1RawgAMLFyIBX3/n4jrgBiqkhse3LGc0nZgU/LrQCRdY4rKlKiJpSUjguBhsApEF+RRQzEIe3JVmMzyIEqtE9qQaKIQwv39nMa4D7Buhuy33U6FpbKgwnaXxQxzJI86b/mIg6QZpar4c1faZ+by1cPy/TQ0i8EEnfcZ4uigsuT39Wjoo4EtIhwu/F5DQ8qgIVffrsAR0uyqjHwY9+L/PEvWQS7j5GWD+tl4repxgVbKTY3kVtw5JoXML5gknPNwOPfWM8WCcyol2ztO3q7W4rvFXwUX1rJmdfxkWXrH9F1r4TXxhWO1ecAO3blMx9jp3j56iZ1PxDHrFV3kx56Mn0IDnU8oqicJm9b1wvXxeQ5GTo0jC7yEuWOTzu3LvhO6lEA5YI0I4Fv/oh2nQ+Lit5/bWbPXse01cd8N9ybC4PpIYpR325slnKVGzsZPBkyuWCssKWBvar7fDsDtVlUxXkirGmqQ6Va3oy9dnmu2hnIFevUQ8lptDPpDKV+qwsVt2vadxRx5qOGpo2AF1C8ZttnZ6hzZf8ltx4YfT1BFU39oNiDUpQp3oX6yhlmaLTM2LOCrTDRw58maGkksLGCjsmAru8SEMwKvOojHRRUDobPrnBu2p8jvirvgI7cnrc2P4E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eTeMnxHkRiQyHSGmgA4tqc1ITCmQyMr3tLRsGJu8lbutmWD1z7ee8TUhUdXEBm37/XFHn35UJsrLDdPhlmqhAUQlIDjTwU1FVnlacKRG0I6QDug75hcYYBxoemqGe0GBKUffxseRHAxmEhvCDxnUPAcbuJq03xCdZKNWfWYXdLoaJrqqPPXokanGJfFIguDbgfj54bwO28YZyJPetpOCmrxSWdyFk39vqWL7KbkGXA0FXrE/SYVMcAifGku/fB2bJxJ71VE7fBc8ePtfaoDFGeEqUzJfrQEJadU21Et69k/Eb2rBq5gyfWuadWHdBds/v98QUtKC7zk3lcGL7QUz7Y1bqT+EyxDOcZRTTcIMAAAfBaUwtb8STFaQIGye9RqIUw0hKj79ASUpkHsg8Qxt8dabvrDVr5UKvWAZ7QEAgjpzPEapuMD56hHm6wzOHjRf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:36:20.2227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f716907e-1ea3-4fe5-6eaa-08dec18e3dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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

Register the render-node debug event ioctl after the debug event core
exists.

The ioctl currently supports only the attach operation. The returned
debug fd is used by the debugger to read intercepted events and forward
approved events back to the application path.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 33f2330ba640..d34a8a3442c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_DEBUG_EVENT, amdgpu_debug_event_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

