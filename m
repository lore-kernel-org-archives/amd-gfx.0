Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C175C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 07:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9504810EA35;
	Thu, 13 Apr 2023 07:07:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0975810EA35
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 07:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmoz48uiVMl11sz3/AZjarqxbx2FMHhIQLGfsEztv2TTSh9eXjNQ0mIyuo7crwKDK2R+sc1tCPrdCIFoGWPKjPy52pMV5ATjCbLgExruod4DuuMGa8/2aAtfgxYwtumC+lwOgwFmpdxUcA1ZNPeksMcKK2IxI0XnWAymAqZ1xy/4Mw2Sd3yEZRpfHKjSxi8JmArKuTAnQCt00Bi4Hk8Y4b373t/RbhXREsvBuQh2c0ub6R87J73TSmb3vFA4eJf2jti0+v1uM7eihM7x5vjeJrhLdx0+V+vefSwVqZ6LnHXzndN0aVVWzuCSEEmEi44fS1vXf4JuC5XYTBObtXYClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHHSB8MHuD0J2dxLTGJEbH+J9jjG0dO0K7PKI6A17Qo=;
 b=hnE2WkWgNcdttbq3LroHrFbLt93u6mSuBy0z+9jkkn2KWIWwi5AJQpZ7Fv1mala/gg60cIvGix9hseCEW1CjFJ1Z1tJ3ratj10Ji8rTtZ8y45gFC6q+i0b0HvWy1uSrIeI/+PMu/EsLzSXO3JAlayfOZpc7Q6zs+/8Kt7DOOw1zS8LlaqM81V2mwEl5JDVFC0yLp1biHyNmx1Sl7dskCOQyRgdqzKgqZbxJyhW29X4RU8FbG/Z/tAVcj78kUie79vqjHolReJQv4rwOpPDTQGMFc4uO0GQKB1jCArYDo8A64HMs7xqZraIP/2f4ScfbfOIf+St2sdXXcQw1j625OCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHHSB8MHuD0J2dxLTGJEbH+J9jjG0dO0K7PKI6A17Qo=;
 b=Pp9Ta1AT+49OgBX+MgoWtRY4ePT6IIi0x4cCD1hjCRB/NtLgmQrnu0gvgGvBTQODDjJ3DcfOuFoSg4lZRHlu4TcCDXVjCAJhiwg3Bcmb72xA7TptWwxZcG34E+JHUoydi0WkRzsS7qHmqKkgYWhnVgIYqV40sKRfQLeBbswnvBk=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Thu, 13 Apr
 2023 07:07:13 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::9a) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 07:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Thu, 13 Apr 2023 07:07:12 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 02:07:09 -0500
From: Longlong Yao <Longlong.Yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix calltrace warning in amddrm_buddy_fini
Date: Thu, 13 Apr 2023 15:06:10 +0800
Message-ID: <20230413070610.45233-1-Longlong.Yao@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 194aed0f-8af8-4ec7-1012-08db3bedb49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9v3ScSYyxp04RBRKvkZskHbLVRtlVvCISAnZGVzPwF1kBVsr+nwWjrafBJbb/qNA+3dCYU4wOqJs45Co0dXdVoVg4S5d5eAe7wM1dDrHTj6YI7T4Jy/JpaKASzuALbx13zPFb3lKZcMxH2xkhgcUp+gNNGJi3mB8Kv6NvjXOqsLNlxMK5GzZHsCB7TxMhqt4hGuIfLbH/ZmvBBZ8thfMEmoV1V1nOOUi1l2otQQsyUwAFB5zyW4pdp7xCYYC92iBwMq8KhnJ7vE9yIbANmKhM/jMikQKxn/7LVTdmDzIU7s42zfWgDNJhwRNNYYobco8VJpKt+ty2mQrQpKxK6hUyQxXLQJ4k8RHvyQdPRs2IoA/YD4YpznbtRggwP9v6eC3KcMe50ySWeoaxtfG3SiU/TM6ZWrHopP4JnJgcHcqkC0bHaGRv0hqvh5CqQpS6cquDg4nQMrQEsuBzxht5pVYOYwDJinq4J5GGPOYWUmi/5xK/SB41NRMtrkv7HesDldh5TbGrbcPuEuS8uXN1ilXEpNo+NEIliUfxshqOFpHjsVywNtoE9sEcfW7WUhEeSNy9kTzHNZbXRZrP1jfgv8W96uamCYEJGksg4BKv7m3nlGl9YNIhw3KekC2rmYI9Ck5vk1ZHwheJ7tgvXql8YLlMH2nCi6fStuC5s7M5ztUoY8WAYkP+l8sJUDS8wtjGUlH2X/6lLABxJ7prkZdD5XQQTvKREMXsL1PDaJSE0dh3k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(7696005)(478600001)(16526019)(26005)(186003)(1076003)(316002)(336012)(36860700001)(2906002)(70206006)(70586007)(54906003)(6666004)(82310400005)(41300700001)(5660300002)(4326008)(8936002)(8676002)(6916009)(82740400003)(356005)(47076005)(83380400001)(81166007)(86362001)(36756003)(40460700003)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 07:07:12.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194aed0f-8af8-4ec7-1012-08db3bedb49e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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
Cc: Longlong Yao <Longlong.Yao@amd.com>, Feifei.Xu@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following call trace is observed when removing the amdgpu driver, which
is caused by that BOs allocated for psp are not freed until removing.

[61811.450562] RIP: 0010:amddrm_buddy_fini.cold+0x29/0x47 [amddrm_buddy]
[61811.450577] Call Trace:
[61811.450577]  <TASK>
[61811.450579]  amdgpu_vram_mgr_fini+0x135/0x1c0 [amdgpu]
[61811.450728]  amdgpu_ttm_fini+0x207/0x290 [amdgpu]
[61811.450870]  amdgpu_bo_fini+0x27/0xa0 [amdgpu]
[61811.451012]  gmc_v9_0_sw_fini+0x4a/0x60 [amdgpu]
[61811.451166]  amdgpu_device_fini_sw+0x117/0x520 [amdgpu]
[61811.451306]  amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
[61811.451447]  devm_drm_dev_init_release+0x4d/0x80 [drm]
[61811.451466]  devm_action_release+0x15/0x20
[61811.451469]  release_nodes+0x40/0xb0
[61811.451471]  devres_release_all+0x9b/0xd0
[61811.451473]  __device_release_driver+0x1bb/0x2a0
[61811.451476]  driver_detach+0xf3/0x140
[61811.451479]  bus_remove_driver+0x6c/0xf0
[61811.451481]  driver_unregister+0x31/0x60
[61811.451483]  pci_unregister_driver+0x40/0x90
[61811.451486]  amdgpu_exit+0x15/0x447 [amdgpu]

For smu v13_0_2, if it supports xgmi, refer to commit f5c7e7797060255, it
will run gpu recover in AMDGPU_RESET_FOR_DEVICE_REMOVE mode, which makes all
devices in hive list have hw reset but no resume except the basic ip blocks,
then other ip blocks will not call .hw_fini according to ip_block.status.hw.

Since psp_free_shared_bufs just includes some software operations, so move
it to psp_sw_fini.

Signed-off-by: Longlong Yao <Longlong.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9d7e6e0e73ed..a496bf2fb199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -520,6 +520,8 @@ static int psp_sw_fini(void *handle)
 	kfree(cmd);
 	cmd = NULL;
 
+	psp_free_shared_bufs(psp);
+
 	if (psp->km_ring.ring_mem)
 		amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 				      &psp->km_ring.ring_mem_mc_addr,
@@ -2655,8 +2657,6 @@ static int psp_hw_fini(void *handle)
 
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
-	psp_free_shared_bufs(psp);
-
 	return 0;
 }
 
-- 
2.39.0

