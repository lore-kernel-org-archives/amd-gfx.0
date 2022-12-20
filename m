Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED4CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 02:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF85110E335;
	Tue, 20 Dec 2022 02:31:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CF010E335
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 02:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TywzaOgkOTaxQsKgwubxyOe92PDsCagakEG+lb38BnfwfO7nY9GHGveeV6VYjFf496t/ubyB++MO7yItybmxvsHkA3+pRHTl6rlfYU6PRoDSio50X1ekvNUutqvI1ktk9NO0ad1nXqACvt+r3jLu7JqqV9kihJI3etdAB6Cak5CmEu163r3vVIK2sMCLBJ9xGgTrHr7maKwsKOYD3yKu4Ic7GLU4xwipzcX24dAkLGnzEWMCg0lBAe9ntA4HGIyhLYYkqTIKV8JR16i14OGCMePR3aZTwj1l+Ce99AcdCHg5TOrUJu4vy5DTzo2Ip/TMjsltXYhwB7nvs5WBejIdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hdCdufXMXsQZ5ISXDeym2ZB8iNAAXs/vCkVRPosZdg=;
 b=UAXNMBQht6LyqwH+dZszzRuMOPeswDP1AMwlEAEmicOWbc6wdNbdDmYYCK7Nn+rMexXLI+EOHS9BxLVcW92qY0stC6Kkpu/Ex52O6As2UPN5beGAN93DNqy3aMJBufq6IiWcj2/PG9s77RpaGW+xsNMbEeNLzT147WDeYyYnYlnnnQxHsUY9olfFceurMZEysR/oFrrgGLql0ZFA2hzsnJI2BpAacFJyCIC129Lyf5a//Mv6xFFQ6GUSPayEP++2j7n8kJecuWeG6TP41HG7nOCPb3Lp3KvlVpsZAK0GsDcrw8dWdo2K/7J028btf8uAVVI0TL6zfZ6BZAG0YWq2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hdCdufXMXsQZ5ISXDeym2ZB8iNAAXs/vCkVRPosZdg=;
 b=cR6MgvUKf/X6sYNQDDweL2b8T/mnQ+4KwXkyWJSa2ljMP0ra+lG0HwL62OUngufzl25FEi1hodVMLC+dm7hu1uYbKc0VWxZOOqwVMnot3USNrTV67n56CqXxdJ38cdwTWYEvi0MOK6QKYMWLF9kLtf/irbAjqSkAUQg8lS6WbGY=
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 02:31:44 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::f4) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Tue, 20 Dec 2022 02:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 20 Dec 2022 02:31:44 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 20:31:41 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: skip mes self test after s0i3 resume for MES
 IP v11.0
Date: Tue, 20 Dec 2022 10:30:55 +0800
Message-ID: <20221220023055.2602689-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 29887df6-11d0-4522-783b-08dae23255bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6zwPfy4c+RboDrTI6k/QcoelPD7WZ6AmYCv3+ajkUU//mbVPoMb6CND9/3jsV5AX2eAc86lKlfdZdBuNe1/QluEdz52k4J+tYVvq37qOWkdHjux3yl2rVdvnx/rT6TiaubB4zHDSpfRfADg3o+t1Jxg4MXZDrEObXPKgc8shL/GwqEfJqpdEK2SdIftIwQ5RxHF0gnD4mUdmMD4E1qnJdpxY06SvqQCYhOd//v33N1kPyiQw52sdpqJaosylUCnEID0aFr2/drpTLWsYPxn/FFb+QTA4u0NS1s+HwuOEnB99pqm1KVu9dM9Y5I0uZYssgvlrk4WD8lfOPRYYIcCbzjcHXIQAsGoZksnl6B3KTKQXHs4NJkl88fRlCK3IY6/C6H8bgpSu8Il3IX/fZbdzQEMozfBMXVxEpaQWQQj+NMxIwLovp2SLKQf8uD1j2wD/mxxZ+d3toeVSRWWODs22yQmdQ6jBUqMnEW668hOnLfTPdvPT5GwVxR2VoyVGduNtTTjYdw4ry7xemR5baUrNsuJmvpuj65iHjfHjWc+0/mLUqOdImJEMEkPhQhvrWhu76FLnS1SORhCPBat76wsAaXXxi4UjSGgo6t7ZKuwXZBdbIjMzsyJv+CwaHau8kzSKIvEb3PTES9CqqSqSk/Roymc+EuZ9gQtUlySzoQhgRjChCK+9lEnjj/867xe7pWFL7xpIa9m/y9/OPniYg0l3DawOwW+5Ldx9adhiacTxHY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(478600001)(7696005)(70586007)(186003)(70206006)(2616005)(40480700001)(26005)(16526019)(86362001)(6916009)(316002)(54906003)(336012)(1076003)(82740400003)(8676002)(41300700001)(4326008)(83380400001)(81166007)(82310400005)(8936002)(2906002)(44832011)(426003)(356005)(36756003)(36860700001)(5660300002)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 02:31:44.0469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29887df6-11d0-4522-783b-08dae23255bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim
 Huang <tim.huang@amd.com>, li.ma@amd.com, Alexander.Deucher@amd.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES is part of gfxoff and MES suspend and resume are skipped for S0i3.
But the mes_self_test call path is still in the amdgpu_device_ip_late_init.
it's should also be skipped for s0ix as no hardware re-initialization
happened.

Besides, mes_self_test will free the BO that triggers a lot of warning
messages while in the suspend state.

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

v2: make the comment clean and use adev->in_s0ix instead of
adev->suspend
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5459366f49ff..970b066b37bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1342,7 +1342,8 @@ static int mes_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (!amdgpu_in_reset(adev) &&
+	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
+	if (!amdgpu_in_reset(adev) && !adev->in_s0ix &&
 	    (adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3)))
 		amdgpu_mes_self_test(adev);
 
-- 
2.25.1

