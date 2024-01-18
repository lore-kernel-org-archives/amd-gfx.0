Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6DFC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 07:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1D410E157;
	Thu, 18 Jan 2024 07:50:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC5610E157
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 07:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGOZQpzXjAJe8QkA5od1Fw2BbOZSr6PHIAFIN5YAKyFprf3STRtZgWAOYhaRb6CZpA9vs8+RJubFNFwU2mV0W3Xn+SmMMUZGcSzMPIJnie5yRYS8tJmB9OKBCkUzVtXj7XiMiUjVjlwNrKkssNh2ydUWmxMyWjpEzuLGJ5X44/xSn412j0WpvYUIhruQJV2Ru7CqJcb9VJDFjAZj5rczH51QpEd5S4oybY59CfUJVSvee4jPgP1lgQFo9pgbSTbPpFTXQLl2J4W0oe9RyrpjSyeE/x5hJuVBV1oYVNFCX/wBYbQ+cpbqQinPy3MurkcehfA27C3fj4aqSCQCaaHuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i0fSHbmyttWZoiTZx1AgG52GGZ1DYxlMLKDTghGSvs=;
 b=Ocjpq8PDMVwvOyEvxR7Dm++espgPwDq6D+TyetH+Asuu1IsLkJSx2/iMw7NcjK4v9Q14C1lezmK9AOJ0EsHOayaZD6uipDAEcai/OAvFkBk2ImPceHlzY4jwnzPAHUdFG5EcgqFyNl6yVGMdYas3GzGuYbbkdghtvEeK2PoBBCXSajhpmsRu984fribA+5PMY847TeicRYPe7Bzo55t79tntzf9o5JbujhoUEab96jMTBXIO6qhbXWuXrp2NrAuNUPNpyvEzJ/3QkT7+Cr2bAOi7Rf8c6VepTMuWgRWz8Mng2ZEH/UCl15n8fmNs2wd+E/vxgxt6vpFQnf01zGTs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i0fSHbmyttWZoiTZx1AgG52GGZ1DYxlMLKDTghGSvs=;
 b=w+KE/SW929riiQSYRkwg+UeMNR+51Y7pqpQSp8zvFBGuiW/H43k+AunWVxQgGC8RsAeGtAkHxBM/g0uo4/fZz6FN67+bjDJJvyzjRKM8Op7DdlN4d2lO93OcnFN23nYk4DgiAAmF55N9iJ+JHbkxgmt49YvwC6XPHgkhhd7JHds=
Received: from CH2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:610:57::36)
 by DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:50:41 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::81) by CH2PR12CA0026.outlook.office365.com
 (2603:10b6:610:57::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:50:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:50:32 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip call ras_late_init if ras feature is not
 enabled
Date: Thu, 18 Jan 2024 15:50:02 +0800
Message-ID: <20240118075002.2071651-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DM4PR12MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 760d08e6-1b95-44da-9766-08dc17fa2ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYrJ1VjLwyn6X9P3UYR17knd8ranUa00x26FiOK/lF8uY5K09/GwK080155UA+srLiqdXJQazv57+M+GrcnfRq915oifA/0/Zo4x1Eb2Andkpp233Eq+GFBTQDCAqrAEuOTJu1/VoJxSyB5Ie5V3u1ixrmx4VFEYYXlS5OHHu0lPMNon51RHzR7oEf+sAigul7zVQ3CXLwJoy41DxlgRTSFdS0BDKIJHxT0Ij0dQPdc/Jbwbu1UqBBHy6z2ADRMWVZBCu941Rs89/vdY+jEHYdY3RY2itlX69RH6WMBcNz8ifrb1XsGuYKyHcNdqbxuHGBwKlQvzp91HSAc9VBCGaP20S0n2vHAeTm/e2IfjddrffnpcpIgg3g19NKXhe1BDD0JWrUCegkruf05vW19roXEsjgkX93cFSur+OcnX/YAUte1gqCgMKlvxTnNgrukgwq8rcAvI9sAx/vG+DV5irXyDV8idTqbB0tUqMY9ig4YfCLDl1FGVXtQqmvUwvAFVxYvQUcY04mKukPRS8RnQ5p/bynZoHqK/yYw2/GrnI073Cj/0TlLD6Qg8AQpei26YKQSbUlWod8yZU+/gAUcwP9C7jOzwFqzeMknA1g7FoYsiei1FVLJXrTjhSekhTSBd9otybILqBp5ot4AF1lX6CkdAQmmgFLg7gUF5jlSm5HoTVB2nA+iVMEmT6LjO755YvxhTA9oosAMc3FOq0a1E0fnwig1db/vLIoW52ymCV8ZKI1zU7HVes+/Sl8tDH6TEtWdlC/tIpiBOaE0CvhUREQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(4326008)(8936002)(426003)(1076003)(2616005)(336012)(26005)(70206006)(70586007)(5660300002)(4744005)(2906002)(54906003)(16526019)(81166007)(36756003)(86362001)(316002)(8676002)(40480700001)(478600001)(7696005)(6666004)(40460700003)(6916009)(41300700001)(82740400003)(47076005)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:50:40.8070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760d08e6-1b95-44da-9766-08dc17fa2ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
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
Cc: tao.zhou1@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip call ras_late_init callback if ras feature is not enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5c817c155d72..5c73d0871220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3312,6 +3312,9 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		}
 
 		obj = node->ras_obj;
+		if (!amdgpu_ras_is_feature_enabled(adev, &obj->ras_comm))
+			continue;
+
 		if (obj->ras_late_init) {
 			r = obj->ras_late_init(adev, &obj->ras_comm);
 			if (r) {
-- 
2.34.1

