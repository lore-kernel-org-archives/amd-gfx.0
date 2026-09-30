Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D09DCA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9B110E44C;
	Wed, 30 Sep 2026 08:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ajy4oFhG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78DF810E44C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwAteC/GzFBRDuopu8DMmWvitfU0gGDYSFmENSuTiaIyXQ3eJXkU9LAl9461e4TNYE+WJD8bGIBeLP7G/xwG+ypXtOFZf4vxqY2nS1UiIs3oV9mBfZNHujB/5ansMqXfz4Qo/Ms0cEOE3CbgaC5L4jrn2Eh0JZy4bpRoUFsamFsrOe0PAAacC8mbVWZH6rGzKEdFhIk1eT7JbWN5poM6Wz940UaFMJtWBGlh9NTTeOLXPPOYP6a35eRdeg2bsoFuUq6VHznFzp7rB0GOTpDhC10U1SpnMUg/7T37yAQraN+ceaGda8TrgFdNkENLkisxP3L+2qsvXko4T52kTFmUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUbFmIlp9cxOeoJQvbqrn2pvSxhdOGvEb5HP0Qbb6fs=;
 b=T/1CpHWM8fVluEI+o6D1zdGVKBIeJEgEssRai5HsD248u1mda1RobS028JLXBe02URsuo17bis1n40tMI+9B5k+7OF55W4xLgeVj5WVSK3nQWhWqoVgewrcBVl/GEjHdQzC6EOM9tmTcIPLvk6Gpp0FzgyWP61UcY9fIioAX9wvdtnSAR0T+hVtEPi6zFWqGXtfOwOOrVzpBCjzZV+mHE2tncc8Er2fhoQY80145rZStxqxXIgQK+mj4R6dIyBh3AhR2tGE5yBfljdcHeDXGbVIydzR/n3Iw9vsWTlwdzfx/dxcEp0/fEPuJbE0NCdezRGPGd7rhSH1ZAYc7xDoJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUbFmIlp9cxOeoJQvbqrn2pvSxhdOGvEb5HP0Qbb6fs=;
 b=Ajy4oFhG6BHAHGOn1yB5Xy4rFe1jtqOwBtwsihA/6lsv0fRyEdWLdAovnSE0etdKKYI8YlkU5xJ4up2vk2vGpO7ePPAbAHtQYWIvYK7QJUwvaKfsIpF8qsTpODmy0GpITw2np59/UE0MOh/bi4u+PdA3nOVKthVvej8Uy5XYybU=
Received: from SCYP152CA0051.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:148::20)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:31:58 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10d6:300:148:cafe::9f) by SCYP152CA0051.outlook.office365.com
 (2603:10d6:300:148::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 08:31:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 08:31:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:31:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:31:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 03:31:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/userq: only accept doorbell BOs as queue
 doorbell
Date: Wed, 30 Sep 2026 16:30:44 +0800
Message-ID: <20260930083148.151311-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930083148.151311-1-Jesse.Zhang@amd.com>
References: <20260930083148.151311-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ef16fc-dce4-4f90-c84a-08df1ecd496f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: vtW9mJPVWy0dyqBM8tAGE2IY6VRoZ0orMMY7TYX1e3Azit70HpiRFZTwI/njruvQY0AZWwpWigGd0UWXRgdQK0AAuUcFbdGGudxBJYRSlapHqu6pBTUJS2CNOddPE4R1P623r/vnpbsD1mLIhGRyyQX1EC/lwyhhs2l3lotHgKzqjNUBDSHWkN9LvfSY3sZztDXIdLnPesnaG1tOIXOM0oBFIxcynsULs4GKytRaGcvwdGiDfo3jorrUpOYqVB25Rm+/2kFt1TC22ZG+0KGqZ14YbqrVBEQbNv29/zDN8aJkRTjbEoOpDc1RaclsEPcsfWObQMWOxC007Ooew3WRIPbd2MmvCUKl0jzujpBZYES/XGyIlZFGf+XPLTBvI1oTmdUQZ/v/YdXmrcgIltUy+Fw82KDfinb+F3aKzkIw0VsedDFB6lKDsERjV7h3aAm34NzjDlY1aH8unSJLJkobbSNL7+QAnJZlbciF27ciITiuTGh5qPDi1a9L920Iji3hSybXdJXTc80uC+IfNDSCRfQBhkdGBvlWeOEteIy28oGfi2Dw8I+tkwO7KgI4KnG7C/TggVbKeE76v8YsDPNyIajmFJ8grXcLFc4wG8vcGEv0Z1iKrkWRHUud0rnh+09VW1HpcM9UiftR15BtfmOHsp3YYeNl+R7rJW8tquo+MLxIQWKAxGj2ttSAG7qZYBTbAWtHD7lAhkHHLng8clrkvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9p5/bqL8FQRjbm0XDQBa2ebUBZKNOJhAGc/+yH5kANuJFX07vzmsMg0waS1WNxVAAAnyo1O3gjp4BLaOSJqxZZ1i5vWuNjXrqJqqsF3/fwcL4niw+EkUAIT5JZlgzSvOo28t6DTKJLGol+/ncWgnW8Qoqw7qbu0a0KLb2uJRwuR74pID+3doByzsaMEx0epOyDImpuxZHntas2YHuTR5kKBckr7miPx4f6lG4/WEp2PS2ZKAnnvOiTfvBs1d+6iHYVoZd/l4a0QLIj/U3k/MN3Xl+7Ax75mMTiTdVebYa02ZIdk2VhzopKlkkqx0JRcT3GOOHmmyS0SHDGfahgavRbHUcqvJi7g+8jpNoBpfwSAdu0y6paq+kWXUCX4dfLsvytrRax60jABnlpXwvN3PWv/MmpezddHlVEw3h1U0y9IasUzTK7xjHkuU42j2DFg1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:31:55.8700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ef16fc-dce4-4f90-c84a-08df1ecd496f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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

amdgpu_userq_get_doorbell_index() pins any BO passed as doorbell_handle
into the doorbell domain. For a regular BO, TTM moves it with
ttm_bo_move_null() and its contents are lost. Since an importer on the
same device gets the exporter's GEM object, a client can do this to a
buffer another client shared with it.

Reject BOs that were not created in the doorbell domain.

Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 89e03d3a930c..a5733a18dc52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -477,6 +477,16 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		return -EINVAL;
 	}
 
+	/*
+	 * Pinning a regular BO into the doorbell domain would discard its
+	 * contents, possibly those of a buffer shared by another client.
+	 */
+	if (!(gem_to_amdgpu_bo(gobj)->preferred_domains & AMDGPU_GEM_DOMAIN_DOORBELL)) {
+		drm_file_err(uq_mgr->file, "Doorbell handle is not a doorbell BO\n");
+		drm_gem_object_put(gobj);
+		return -EINVAL;
+	}
+
 	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
 	drm_gem_object_put(gobj);
 
-- 
2.50.1

