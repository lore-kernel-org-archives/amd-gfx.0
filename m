Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8F7C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 12:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2278B10E22F;
	Mon, 19 Dec 2022 12:13:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232CD10E22F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 12:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HupDULSNCtLzE6r/2PYb8/YRU29TkRYLHgNZsWIZ6Ev6I/44uZEtao7XEA15uKEI75TX7NaJ+m8PjQW7//gpOr4tvItelyQr/AaCY6anokldCVs7cra42lwABFc23AW2LwleiQ0gtOcsAJwLMfBjI+UCJBxHOr8AOZNSjYdq6ThKjuwZTZNyym8mFi3K1EBbPaDeP0wq2t5QZp5gGoZbO3BnXAAx0TUbKFqgy0Mxzcc7uaPksjWrXM8HO2FK4GCiGLr/5/wSrgx1nC681dkxhHGuAGZF6CxJQjyJZ0/g0SwQmhwFFl/Svjn8hWSEd3SEMVsnc3mKyWi/e8MSypaJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zvS0UrLmkQLQu5Degw1IrU1S5VId5rrjhKv3S7/qWs=;
 b=GwHADSLlDwUybYRH77LeAWdMNtECarYLo2zsqW8ycCQ3Nu7Y3Da3wGOsW4t2eberIZTE4cnwalsGdjuJwv8B8RvAzkyZ+sHM7iqVtXeFQ/0vyA7/7ahfXqaLw9QeaeLdM9pvhc8aA59xuckr0QJOOHWSaShq7o2EQogWJa7pI+8+4oKWBq5Aj0gls9ETUZXMmY1l1HIIoRpTKFqbUhrM085HL6jnLZTQSZphsOQpREivnSWI7LIM4qfQrkPVTGHaAnCE1MJvRE20jfqrzPsKaA5PL33IldRwF7MA7i+bOJtGkHfCPx9DoxZ+0CVTdqtVgQuulOjpqJW9c8QTu37yDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zvS0UrLmkQLQu5Degw1IrU1S5VId5rrjhKv3S7/qWs=;
 b=I+jclTmesl6fhohJH9zHzWCa1OkElQczhSKLyZKtzNPWIueios67CpDDIwJht+qZGbqwjYqBkO9zh3JihQ67pP3SHGkSLVaUU5HsQdgp8rH1OnOAMUMfDUY+FWFqN/3CNrHBGbBlE7/Es4C9hodbvJgj9JjVgeuKfDKrHQkEQiU=
Received: from DS7PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:3b5::23)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 12:13:41 +0000
Received: from DS1PEPF0000E64B.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::e2) by DS7PR03CA0048.outlook.office365.com
 (2603:10b6:5:3b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.18 via Frontend
 Transport; Mon, 19 Dec 2022 12:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64B.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Mon, 19 Dec 2022 12:13:40 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 06:13:38 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip mes self test after s0i3 resume for MES IP
 v11.0
Date: Mon, 19 Dec 2022 20:12:52 +0800
Message-ID: <20221219121252.2567663-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64B:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: cf31409f-8811-472c-a625-08dae1ba7735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhgstPefn2t8ldBGfFxOa9/17E7YIl3NCGLkN2DkRhLUz+Y2aRvX6OyJYi6R3CWhlPJO7OHvg2ESMrxYicIN79y/LISfINRmUr0ClrztKNmGSB4IQSHtM81yrJUBeKTsi6WT1DhXA/qUt1vFQNMK/laLq9SgfOeiwTSiaCmGiujZF5Pvl8jTNIoB+JumvKbse2tJuKnMMoi715rrsoL+pksnTF+tUyO2jh0mHvwY5a7ZWQdvk0iRNUhRrGdMdQT8k+VQ9hj/UVNVT4cEoKKeoHXjequkYBReAYdtpYepPt9H2cfKeStUgu9qg5p5GT3x0u/XF4AWR46sAH0APfbb6mjAQZzeXDZH6OIW8V3Zxcgjll1ho+NXSCIJYR+xb0duSM797wNfiGZ2CDUArflnDRNVjksIsZqfpdaTi6QZ9S9EICrGoMi2Bixw++CSzXBpiixFvauL9hlgVqoXilm487+Cij3Zh6lK8+kuQnsY1TviC14rgemmR53HG/TngZQGXcb5txK4TOy0pICdsT/U6yeo5R9oDHMOzgwjTsMutc+dLycrjQyb3wLUdMK7NoT1BeCJGKVEAVRt653tMk11Urp1JX2zY67MIuSmphS/cwXq3eo1p/KcBqxEofaGgjZOsb1ASIo8lMS05JX7WqYmhXcHrtHAX1QxILRbqkNgLca/t+5YSaGSsAUDPXDwl2hNl8GATHpDzYjjT6jeKOq88DuO5ky5RuteuFS73GHOrrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(2906002)(82740400003)(6916009)(40480700001)(54906003)(478600001)(81166007)(316002)(8936002)(5660300002)(36756003)(86362001)(70206006)(70586007)(4326008)(8676002)(40460700003)(36860700001)(47076005)(83380400001)(426003)(356005)(26005)(336012)(41300700001)(2616005)(6666004)(16526019)(7696005)(1076003)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 12:13:40.5736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf31409f-8811-472c-a625-08dae1ba7735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES is part of gfxoff for S0i3 and does not require self-test after S0i3.
Besides, self-test will free the BO that triggers a wraning while in
the suspend state.

[   81.656085] WARNING: CPU: 2 PID: 1550 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425 amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
[   81.679435] Call Trace:
[   81.679726]  <TASK>
[   81.679981]  amdgpu_mes_remove_hw_queue+0x17a/0x230 [amdgpu]
[   81.680857]  amdgpu_mes_self_test+0x390/0x430 [amdgpu]
[   81.681665]  mes_v11_0_late_init+0x37/0x50 [amdgpu]
[   81.682423]  amdgpu_device_ip_late_init+0x53/0x280 [amdgpu]
[   81.683257]  amdgpu_device_resume+0xae/0x2a0 [amdgpu]
[   81.684043]  amdgpu_pmops_resume+0x37/0x70 [amdgpu]
[   81.684818]  pci_pm_resume+0x5c/0xa0
[   81.685247]  ? pci_pm_thaw+0x90/0x90
[   81.685658]  dpm_run_callback+0x4e/0x160
[   81.686110]  device_resume+0xad/0x210
[   81.686529]  async_resume+0x1e/0x40
[   81.686931]  async_run_entry_fn+0x33/0x120
[   81.687405]  process_one_work+0x21d/0x3f0
[   81.687869]  worker_thread+0x4a/0x3c0
[   81.688293]  ? process_one_work+0x3f0/0x3f0
[   81.688777]  kthread+0xff/0x130
[   81.689157]  ? kthread_complete_and_exit+0x20/0x20
[   81.689707]  ret_from_fork+0x22/0x30
[   81.690118]  </TASK>
[   81.690380] ---[ end trace 0000000000000000 ]---

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5459366f49ff..80e8cf826e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1342,7 +1342,7 @@ static int mes_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (!amdgpu_in_reset(adev) &&
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend &&
 	    (adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3)))
 		amdgpu_mes_self_test(adev);
 
-- 
2.25.1

