Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10018606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y8zhE8Rz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797DC10E0BA;
	Thu, 22 Oct 2026 08:19:50 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013037.outbound.protection.outlook.com
 [40.93.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6410E0BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFf+BQqjW6wQ1C6rEltWtKEcikB74VrYBc8WELyh4C2LJcaexeV7HLv4t+qQhFewZbg4ekd78oIB0HBMvuU+J54GfuoTD1tIl98htJk+jiRNS9lZ5xGvzzV9EtsfSrclqt9kziQz48p6A6jP+K9iHx9kaYLlErRfpaT7ay5iSYwwbS34JiYfjSvyrdtx1fNaVo3QWHE5yRWVzZxlLhoyXgiutdoUBlzOvimI0yj0NMJQorabbaCYgbgiQv0FkgIjyBpwGmyzTIYtWb8o6hl58zNUHPPLEtt8RapPRFY0Da35gM/zRyilM9/kDXTVNfbLzCxW9UvkZen5/fO+0hdInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg7z2MEkAcpLBmNXcjB+4HqxTaeuc8m2eimlJc/JXtQ=;
 b=nrvCoYcv708ZY6oVobTYRPf7I+Yr3LY9PqvDeVPn1kshRvSiWPUlKEKu40UJUovlnG+Ajdjb7BArkU+7xIQqcees7kdpWlhj8/A2KbM/npRMoOJYhj2rxw+PIULPoHxfb+zpwvKGoxvDFdyDJjuvtwbsPNqmrxRk/Ta/lKDB+svPmtahbHH//E5CBLYY/heiEWlNVchAaKgRB/EyMZS8hOEwTY4OYOwRtqH7gOpZqsI4IhvgwvVixGBsYg/AgsKE2shWjFgcEsl8Aigs5pS2WLv+r+suAsCKgGGGHaUGNwDnWKgz7nTzeGqOrQ2pcCrNAcd6uH7RHMobbHaFwie31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg7z2MEkAcpLBmNXcjB+4HqxTaeuc8m2eimlJc/JXtQ=;
 b=y8zhE8RzS3yHafJneX5Kq3lgb0kMDFgt/AgoYNsukckMKclGYciqFQ7ax5MYAG3+jXpXVRfdIMKIbJfSY2JBp+l+cAMZ2S4A6osjGAzUenMA5nZXLzD2lgA2QwQ+xqV8/xGmGlRy6eDhO0F6nzWvwNV+YRBUCXw7RiSFuCaL+uI=
Received: from BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 08:19:40 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::2a) by BN0PR04CA0045.outlook.office365.com
 (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:19:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:19:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:19:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:19:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 00/15] drm/amdgpu: add GFX engine reset support for
 GFX11/GFX12
Date: Thu, 22 Oct 2026 16:19:10 +0800
Message-ID: <20261022081934.331260-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4b1d35-c0f1-4a2a-2236-08df301537a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|261021121427099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: yPCHHFotzzUXpe9HSYzpxQyOhmNUiQSJRAMRLgOM7tEWvYTl5lM/NCo7hykACpTjKlSpwLZ+5/+eSmvhopthUHS2CRnMeIdzzEA/Zaeh1HlUAqZXU3X/5GbfYxAAYN7SKZtHD70E63ofKSLjsfoLkx6Yu9kjkFBDUCOEH3e65oVB4qdduqfb5JRhMlt6u/Zp/i7xVbQV4ic1+g/R/wsyYdqiNMHvWIuAFqfRriMhyYhSwRnXIyFZE88YRsCnfq9YAK9Ah6r0Ik2nXzPoqM6ZxNmUVKjvygltAV7jArgpNhXO4htue2Vbw+SCSn5sipaYeZ+d2K/TrKUhY9k8PLBiur3nsAXLIA7G5rhAr5xBTUZSnPHIoUR4ss1WtJsBZiGU5tESovXQPkLKf+vkQt376lV+fmz8jEwy2sLV70bju+vUqyZbyjJq2wBlXSxUiOYMrEwbI4ZeW+h+I/LozAOFWgIzishnP1Yo+NE1FmHhuNFU2ZB8n/6nnvi9GczaX3l1xJ2FT91RcI3Yv1qj/tWX7YwTIlgpfiknoHSoTLkaW6arYMGE0+Q5aob0IILEiAZO5VLMsE2GUvbnWl20o8BKHwqEi+kQS+ta0MYWYrDpoySIJzYbAE7lnW656w0JZRtQBZcvxWhsU2XRUz1+s+a8HSDnfNEHCQeitqAjoXvBJezo+z1WsGi7m5NbkypcSDqfbknrzTb9goWHyEyqkOzEhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O+JvEnlQE5IEbaY6vvExg1Nd6cBAgIm2j8loNzsBlSvjlV7byGHKxWvAxRi79POXWytu7WorvF33r627YiLnXdRMDjBPBD2evvEXmFf7cDLmsRAsqOS3gmyA5BccX/eX+ddQZkT8z9V53HddTE8ong/d4XndsIUSJT0HHzSWu0ClQkvi5sCI5tNmaunNyK9JSom61s3OEuhtFbHZmNVpLcEXx/oIHDxCMMb+U7oVdSj9bL/SVuUc1CDr+urNbRrkFaGiW3AZE7QtziaBYJl9uYt5UTjH2LNbPXMec0Q8o1UQKKwteNLsUvDtZBPylh9oE0mNkVg60VTMBFfjcadcOYyziMu4CKuG09fiFnr+pJm1BtqOvm+UAZRJgOKqjEwlsDI+Wrj4CJhrM4JltmrT/Fe/YL67HNKvdL1BFJS2Aj+0IgZjEGwb7ix+sDaqS9Us
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:19:39.5611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b1d35-c0f1-4a2a-2236-08df301537a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

*** BLURB HERE ***

Jesse Zhang (15):
  drm/amdgpu/gfx: add a reset_engine callback
  drm/amdgpu/gfx12: add a gfx engine reset
  drm/amdgpu/gfx11: add a gfx engine reset
  drm/amdgpu/gfx: add callbacks to read and restore the ring state of a
    gfx queue
  drm/amdgpu/gfx12: read and restore the ring state of a gfx queue
  drm/amdgpu/gfx11: read and restore the ring state of a gfx queue
  drm/amdgpu/userq: add a helper to signal the fences of a queue up to a
    point
  drm/amdgpu/userq: add helpers to keep the user queues of one engine
    across a reset
  drm/amdgpu/gfx: add a gfx engine reset helper
  drm/amdgpu/gfx: reset the gfx engine when a kernel gfx queue reset
    fails
  drm/amdgpu/userq: reset the gfx engine when a gfx user queue reset
    fails
  drm/amdgpu: show the engine reset in the reset masks
  drm/amdgpu: add a debug_mask bit to disable the engine reset
  drm/amdgpu/gfx12: enable the gfx engine reset
  drm/amdgpu/gfx11: enable the gfx engine reset

v2:
- Drop the per-engine user queue reset lock and the walk over the queues
  of one type (Christian).
- Keep the gfx user queues across the engine reset instead of dropping
  them: new gfx callbacks to read the ring state of a gfx HQD and write
  it into a gfx MQD (patches 4-6), and a helper to signal the fences of a
  user queue up to a seqno (patch 7).

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  97 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  38 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 109 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  31 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 276 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 225 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  22 +-
 12 files changed, 808 insertions(+), 8 deletions(-)

-- 
2.50.1

