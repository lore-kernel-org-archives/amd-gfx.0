Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28A3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 03:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3650810EA22;
	Wed, 19 Oct 2022 03:45:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EBA10EA22
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 03:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArfBugnogOxYGX2MCbxLaVnGdXYxj9gGdbxXMU6kNuVu7eFMzAc6Tk1YZgRlBBDT+vuT/uIoNlVky3HYJqOt03GrRX0uGG84uWaRwjCBqtBv5A3I1WXk/D04mitw1ocedM8fkXEbO0rFL/aY4pT/bXRMPLZgiwBmC96ooVkx/ZRC6zEh0HKOGo5xWgufONSZ61BUMj/BWqP7phbmhxUw13iqItWhZYRLPRmn29TSKeIHH7/RGmxAc22MP6yGqdGwcGrrBuHrYvaAKLc/mPPkFTo1zHeIhw4NzVlvGVSEx0hxYxNvy2y3ecEhsY+/1VXFxurG/S/ag0BwpgGnkWDs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiw2320VcAO/VBvtCetV3QvZaGqXHZnLQFV7HKasj9M=;
 b=huCNiZ2sJoF3BLhwqZD5c0Upukb9Kq6LpmvrLhSuc4B7Q8/wL79FhOMusTEvT1nA1LGpkDRW5crC6eyAO9lNtKFV+/GHeFY5kJpcDCk3KUQ0RV1diRbcgny3ujGAT+zp2HU9RrUI0nD0JZxdF8fIaGhmQ69zMU6QIg7Ip5F+ApqI1eDqR84CRdRNN8rJlnch8bcxgmtLzzAk3pUtOUG7nxISRt2910v+v32eoMpoHKa0GKUt1HrIve4CnKvwVWb/HspDsWG2KywX82XoV7opbU2UI9uHt0Y7JzDNxIwUA1bl9PAOzw63S5+u41v5d/s32iyNPZ8BN4HessyakJKnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiw2320VcAO/VBvtCetV3QvZaGqXHZnLQFV7HKasj9M=;
 b=ayERStW3Noh8b5hCIu6ogo9ePNPC4W01Ho47kE3gRLNOc7Z4QTmNaYjTlq8iLHHD157uJhFQmjr7I2JUprWCYe9jTfPVLUqYQrZJ2rkyXXso4NuC12YkO6m635w0WXTXCEcGiWXyD+o4O0E8E4WWNSrxHwsl7ri2Qok+YxZEdsg=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 03:45:42 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::62) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Wed, 19 Oct 2022 03:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 03:45:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 22:45:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 22:45:26 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 18 Oct 2022 22:45:23 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Date: Wed, 19 Oct 2022 11:45:19 +0800
Message-ID: <20221019034519.1558366-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 21396e6e-b973-4e52-0ffe-08dab184655c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9WLER1ar3GQp4TrnApiqOdh1iY34ee0HKD8a1lETYiWyEEaYBhOLeCX+djA8YasOBgeICsss9+wRzI3shJSBuiSLmYdo+Cbqz7ASOmGRuuFyO9v6Oo6q6A2by8Qk4gSzUgd4ZoJwSTjxvTQr8m/merBubD4/n9N4E9vIhoCH4J6cPNDXDpbvG6Zig9ZDnnscamJDO/IcA50QBrc0SgzcZ5c3R2Cv2DdQ/kEyWxZZcri3fzxlPYtKeSymQINbP7UTDRyVIruCR1ghUV31Hl3aFBZBY2gJPWmpnkaPPdT5SAie+CAHWWfcn5wwc2JS3Kr1VexIkWkA1zR0vBNHOXeS20r2EH7l0Aq1yR+bnmIww82J3Z8oUw8jgIAyzfOhq943mg5dGIsuiJJV3MSARigrXqSGwhq44Gz0PbOkKBZgugWqG8yIqUSaczcaikd9lUInlZW3TSUkVPxZ7eRGBbDvfb/gj/gHL/VXGXRFwwQuUtJx/HvUdbCCgPowyF1Dv3D5A3lHHj+aMdBXSiBQMWWJ+U/jj0x3TlS7oJFIYyCNaRemHNDLD2uc074+iMON1fc8Jhmqh+P11howu9eMimdV6sDWddxABMGagaDqF3VqDmhk4G9eev79vNpodDLiHaqloM9Hgsp+jgnplIkadBGGbmN72RowN3uJD9cQDAE8lIDlydztp0R9t7XHJgTZoxif/bzV7W25ZSTL/sfpknZdnQqyaiTUzzQ4PiNBiMzwQ1t3vXHFLev/1HSpbcX9sEg5odsx/lkI9g9T0VE9lsbTLkvHZTV3S4D3l2JITsjll1VdFKgo1z2FQgwXcshe1O3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(6666004)(41300700001)(8936002)(478600001)(4326008)(8676002)(54906003)(316002)(6916009)(7696005)(36756003)(36860700001)(40480700001)(356005)(40460700003)(81166007)(186003)(82740400003)(86362001)(2616005)(426003)(1076003)(336012)(70206006)(26005)(83380400001)(47076005)(82310400005)(2906002)(70586007)(5660300002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 03:45:42.0209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21396e6e-b973-4e52-0ffe-08dab184655c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Temporary disable mes self teset for gc 11.0.3 during gpu_recovery.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0445e8cc342..5b8362727226 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5381,7 +5381,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
 		}
 
-		if (adev->enable_mes)
+		if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3))
 			amdgpu_mes_self_test(tmp_adev);
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
-- 
2.25.1

