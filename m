Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4750FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 14:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF01610E71A;
	Wed, 23 Mar 2022 14:20:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637DD10E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 14:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLgrmWIvmXex455Fy6bztZ/XRwifSoFXPXfqgdlvvcLnAftiwSKVBFNmVMTKUW9UJO7BMq6ZTC+AVcDN4ScsMBjydPJrEYciA7/1Ae3xz0G1Y6mW0tyHnnGPXZmXw/XW27U5Vdw5FcNOAc8glpwns5qXaa7oTA+FVnbUt8SZ+vXLi7J1vLunjGn7Q7jQQwRcnbejfZo/vLdF1fzHjU2NRphCcKmeqHYViNRpFmUEnl0ONkxDTYNcd2l6L4tCWYghQISzbPzjQoigQtbZAJb0cd6MbV3Zv+g2bdTHBgyYL6QGooREKmvXJKWdMCpAAhxzke1k3x83U8uc7jxDwaLYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T5XaA3wHyMWgwoqg7722WM+hWDW4JqjMxBYpSNs9NA=;
 b=QS2eEKEkZ9J3fxayUOrLQmFRgqONaIAmy7zxNlvi5A8GDDzldegl+cySYVEht+kJv0yBNTAczTy6IeFioyqAMFt9UJVphVqVBPoadPQtG3G/vtGE3bKN5T8+WuCPTTflhnrwtbEwMpLsm5vG7o5Vh2cqVu8Pa8EfjISiRPwyHF8Eho0aJ5Nht3A777tLnW+jE9A+paLezuuoaZ9q0lUZQMydbFG/OhUetlBLvdL4Cy67IM1rjcicYKQWqNvMwhn7agumMn3RsWf1BgtL+ztiVN1qImV24ueQ04qhRuFJb2AFlY4LsP95Yuf4JngdXVFr4OyeyCjBmzEKUE/6O48KZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T5XaA3wHyMWgwoqg7722WM+hWDW4JqjMxBYpSNs9NA=;
 b=EItkFIfTod0Iquizw24YyPaJzqK+8IHog05MDbGFeyQPRwa7z6bGPB90rlnxfaRd6O+TKz4bThIniCfFA6Y2DTa3s6TIofOgBQvTFS7U/MTQRlfvzta59OeoGGzxOdkprcwgtwESFfj4SE/XAuzTDDkff+4FGt6ALDTDb8CIKns=
Received: from BN8PR15CA0042.namprd15.prod.outlook.com (2603:10b6:408:80::19)
 by MN2PR12MB3341.namprd12.prod.outlook.com (2603:10b6:208:cb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 14:20:31 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::a4) by BN8PR15CA0042.outlook.office365.com
 (2603:10b6:408:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 14:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 14:20:29 +0000
Received: from dishikre-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 23 Mar 2022 09:20:28 -0500
From: Divya Shikre <DivyaUday.Shikre@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Check use_xgmi_p2p before reporting hive_id
Date: Wed, 23 Mar 2022 10:20:16 -0400
Message-ID: <20220323142016.1810918-1-DivyaUday.Shikre@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb8d69d7-fda1-4610-539f-08da0cd849b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3341:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33410A0DB6228D6CCCAC676097189@MN2PR12MB3341.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpgoJOI1Nxlvohe3KjFE1j7amQO7BWCDAUrn+UoCqQZm7aZ+MJPGhthY+IH94fCwQM2praejumJxaJ17/AD8rnkx9KuepjzMKKjOGQW4uWSN2WQ5K3rLblD/wA/QFgw2oOnSY2Wjn3Z+LGPWhMgtMNhGAnRTYKawghIBSmJebm7g/Tzr0+Ns+QS1/9s9uDWBUFJXe5lTmlCQSmAWREqAvA71VcrE5KbHH3HK1QvC3dz+lo/1bNuG8YduPt2cjgZkGX6725+SU7YS6w4h8FMX3Wi6JkkKelMwrX3Wona0QJdZF6wdH/6DduPc6aiUBj6vSZ2gjwVusWM8o1MZeqp5os2tSP+E3oph5jFgtUMl91AI07hJ4MXMw/3GszuO8GGCl34GBtVoUoyAwRPexpTp47FGlw9cJ4e4aofw/6EScpn9NCHHTF8UdbM9tbNgbELmI181+00Ol6nsaPGmxrCRpg8xSuQMldvVBmMunKfRA4CvjO+NrdD2CkfIfrAawT7GXidpN8bo/Fx4aoiCf9veEgataVlgRTp+vtGdIcKcrdR0v/cDIkfHRQBajtwpZCx9fHXbnL94IL6Iva+wD0qrdaswsuBeZbJxSyqGi3ySVmRfoamFjiUSf71DGGl7UKi9NQsbSAA+CE0bu/y9dx7fZaIO4QDRqYAD+FLlJnQQT1ardhS/PIbzBRDFxRW5+a9px1WDzVsYODLOOKJAiVbAMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(356005)(5660300002)(81166007)(4744005)(2906002)(7696005)(426003)(336012)(47076005)(83380400001)(36860700001)(82310400004)(6666004)(40460700003)(186003)(26005)(2616005)(36756003)(1076003)(54906003)(16526019)(70586007)(4326008)(8676002)(70206006)(508600001)(6916009)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 14:20:29.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8d69d7-fda1-4610-539f-08da0cd849b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3341
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
Cc: Alex.Sierra@amd.com, Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Divya Shikre <DivyaUday.Shikre@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently introduced commit "845ebd6b7c32 drm/amdgpu: Add
use_xgmi_p2p module parameter" did not update XGMI iolinks
when use_xgmi_p2p is disabled. Add fix to not create XGMI
iolinks in KFD topology when this parameter is disabled.

Signed-off-by: Divya Shikre <DivyaUday.Shikre@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 339e12c94cff..d5536e33b3d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,7 +536,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto kfd_doorbell_error;
 	}
 
-	kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
+	if (amdgpu_use_xgmi_p2p)
+		kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
 
 	kfd->noretry = kfd->adev->gmc.noretry;
 
-- 
2.25.1

