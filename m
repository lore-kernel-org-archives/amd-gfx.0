Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0732C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B4110E92D;
	Tue, 28 Mar 2023 15:15:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F3B10E920
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFds2dNkuadmawwf5g3kHpneBU9dnRWXaJSVHTkloDZlPOC39k9aPWhFQ419JUD2VwwkreOKjYLHtE91TSkVL9X3l30HfwiVNr3lfo6iM8DVjAjTgZHhD6GS9F6baWusZELMvOt41q+NfI5Le8MtrxYE8DQXK+QzctQjUWOJhe3ZfgFgBQjyl758ws8kJ6zAHB4yzAvlGJCuG9IVgd6d9yQp4Cs/3tjUCS5XslUVu2KXxtxW92yPufhnfIDO0PhGI3vvAiWpODYt/UA+zPapMm5vSG/xV+WvdpA2ewN4NfQ0Ir5dWinaxcf23YVcGJ8Ve3LqC+W+GUdhQweLZHvVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwyKB2F50+HGVz8AGGRGrn0GDhCnO+GzzuSuCLXDgvY=;
 b=O8AgY8ACQMnh8+OBVUc9HbinY8NzWXBGwom2IARfZrOQAtt5VOxa0egRrMkYhld5LtNak48j5MOh+JJ3YGy0nnldC7pt81rTklnD6C5+WDbNPELA1gO+M2CgPDTmMbQXHXABKAwQ0/JboWAskCPpJuFei7nAlfeyRosmFHbTmkflW24pzNXszG1EibQ8Lcb2Rl2aEIYQ4j9CJV4p8+H4DML+8iyuK2OEaTsP+RfyWgld4yx6kjamJHS4r8mc4evqX6ZkBa9QJQ+uRwHrvxfdtJgGoUb3aWC8dX2SYnsDfsqRXUhPerEzaLTF3GFqJCwcezTCm/jgdrDSf5gus7oSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwyKB2F50+HGVz8AGGRGrn0GDhCnO+GzzuSuCLXDgvY=;
 b=afNm+n7wN3oIpqBNYwYjdfNoAS7E7h+cLidNkdllZRqlOzEVhMRzL7Cj5WqC1fyAV+9iYMY9D4+KfqipijhJib5zHObDdi/y19Tbq3S9kr2GCTqey7boSNzUcdjFwhaxs2RmktK1T0xsk8gb1TGn7fXIv7cEvZEDBzJkitprAK4=
Received: from BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::13)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:53 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::86) by BLAP220CA0008.outlook.office365.com
 (2603:10b6:208:32c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/32] drm/amdgpu: convert the doorbell_index to 2 dwords
 offset for kiq
Date: Tue, 28 Mar 2023 11:13:41 -0400
Message-ID: <20230328151344.1934291-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d256ea-f622-49ae-f604-08db2f9f2ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZXHX9g37ZmgBdTPgigbijP0kdDJ1qInSurc2Ff0jODU/PVxKliAAgs87zpQxwYJWU3wHOzxqwvYjcovTiiv893dgq+WPUZvb5c9yFr1jF5xKEQT+rMj3srRw8ix27WXY4/OpClGhikXuPSLrfujx1nexJX4t8BDZiZGa0QyAmcHtpH/ZPnbiDBJexdxyPXDTu4NaolinQyoColzlfgDn5bssah33qmb0PqxygWxAbo/aAW+lGUQzkwjbZJ2HJT6q0NkaTFSmxMi4WYtpyX77hbqMBrNtwLD6bz7nHkA5IEdzmnDjY7shGLVInGjqvVC0IFluZvsc+yADKyFCpn2zCaWEvx2snOeEN6AbHkBRqlcV004N1HzNF+300ztWioUgE6B7JKzh/4THqGBI/Ov1nxSGMyBcO02gMr/HdwKCktnxxsKVBvYWmh8OnLAyfxa8DW+9R4YHofyK8pVbrYoOgzSskEkPz231rIaWj6SXMQW793JDCbf5lsVTKhGkM22LZhRzxEwTEHvRgS179ZkuZmJ+fgWdmHAnZURdN8q2RtBL056uNc4Nn47hnJQ8HSzC0yddAO+fYk4J9jf8GH8P2v+2ndZRSY4zxzzS/8AKlWd2XWoMJdsEeAo5GiwIWC7x0ETBIGSH9UmVZ4k8TECfpUX1kwBvIjzweVMA21MtvvRq5CxWWPt20w12Qzq/6MRUgad4/VDJGEM8H2VaJqhvPIBL7F1aku2zQ2Pigyafo4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6666004)(1076003)(26005)(81166007)(83380400001)(86362001)(8936002)(356005)(2616005)(186003)(16526019)(336012)(426003)(47076005)(7696005)(2906002)(82310400005)(40460700003)(5660300002)(82740400003)(40480700001)(478600001)(4326008)(6916009)(41300700001)(316002)(70586007)(70206006)(36756003)(8676002)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:53.1718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d256ea-f622-49ae-f604-08db2f9f2ea8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

KIQ doorbell_index is non-zero from XCC1, thus need to left-shift it like
other rings.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5ef6fbe354c9..d48f80469533 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -313,14 +313,13 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->adev = NULL;
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
-	ring->doorbell_index = adev->doorbell_index.kiq;
 	ring->xcc_id = xcc_id;
 	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
 	if (xcc_id >= 1)
-		ring->doorbell_index = adev->doorbell_index.xcc1_kiq_start +
-					xcc_id - 1;
+		ring->doorbell_index = (adev->doorbell_index.xcc1_kiq_start +
+					xcc_id - 1) << 1;
 	else
-		ring->doorbell_index = adev->doorbell_index.kiq;
+		ring->doorbell_index = adev->doorbell_index.kiq << 1;
 
 	r = amdgpu_gfx_kiq_acquire(adev, ring, xcc_id);
 	if (r)
-- 
2.39.2

