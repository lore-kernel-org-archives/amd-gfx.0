Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3958DC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 07:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DF110E56F;
	Tue, 27 Sep 2022 07:35:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF03F10E56F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 07:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6j1eVfoNJQG7OL3almJnJTbJn8T74mID9mXAYcROtFVm2qq2IDnJ8uYshwFN7lo7bnoOElI6iOmVFxff38pFOiyHwf/OhpAxwHlAd5ptJqhkHmhI8A9axbCiTmae8sYBbzolx9D0tIrZsYKx9lt4EBTK1joDveiWk92EQ+Bi2uG+O6Y/FB8KTd9RxdbEuPpQ0PSb2y4mt0Ggnq8YqO/YAhICvFUoKxxX5EPhHbjKQVy/NpPHhGsHuSbkKogH8/f+K1TDFhx2fLwD16Gb5wlVZ91IypkMxyawnJKUIIJGK0gSdwGgX89XqoenPY5uPjKF6TXuyu1AqQTq61Q2ttVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnKnRut2o8aRyI9kQ54e22+ZH7PMTlI0jP4DEgxbyMQ=;
 b=LNzD+NxbXTyKkM4mZ11cKUFP8bt9pvYBAg8tskTOSEDvdod0aCGWosJ7OthAnn3gftvYMST2C13EA2+eGEjiR/HM9F/DM4L1zRE5zbAL9UwubTrcYbdcJwZF3WeOujbwtZHR1cBVtRDYlOUIB1Ep1Pwm0Qd7h3C0hA0bZB3ingyqT/woThLZy5b7YWLnoIJs2F9yPZ43vOghwwUBxcM9V8A3CCvtKA2IroNgBO82KEf5fRSUiGEsfkRhm3MJDn7mYoQQPOyS2xS0DR8ZTxy0FcAqRwa/PR28ZFlwyGJb+3U0AGSh7JoNyqvRVukeRm/itgIFlwCV0PqQGiqNmE0LXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnKnRut2o8aRyI9kQ54e22+ZH7PMTlI0jP4DEgxbyMQ=;
 b=JQfl2K8eLHfrtM69AlmYvOQlWtGbmTACgT3JxlGZdGIBorEBKtcR6d/J8sUOUOb1Et5BSE6X4qkqzXAgskYpwhjFbkg0NRbFG5pGxqZeo/ZIyrwoI8RJO/jPCJwIH+Acat2XSDN0lYr2lKxdhUqrhGko1j+2rmpiVT6NOlPTB68=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Tue, 27 Sep 2022 07:35:34 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::26) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 07:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 07:35:34 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 02:35:31 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <monk.liu@amd.com>, <Victor.Skvortsov@amd.com>,
 <haijun.chang@amd.com>, <Vignesh.Chander@amd.com>
Subject: [PATCH] drm/amdgpu: add VCN poison consumption handler for SRIOV
Date: Tue, 27 Sep 2022 15:35:22 +0800
Message-ID: <20220927073522.5102-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|DM8PR12MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e48d30-c0e0-4825-9d5e-08daa05add55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyCauwU3EuHuWQ/OFzaEYxo/4xa7CK0zj8GeC9Fz+yLzwff4IGJ59DQRKnIZXxyzN3Xw9v85SInk5P5lmAz4o2ZEd5aH+VgnsD5eWLE8ep0rIFz1sl65hElPKBm5sMcMxvxVmcb1Q18xu7IaQRtOE2ArfbUjILlIiH6u269OuAhrN6N8d6pRRVOnRVU+PXBXE8HXZ9COQ3rXGrXTumNgO5hXZfQEtoZSs9vWYBUp13HbYe2PPQ/CGfDpKUdgvz39oLLUPe4NnhbTuucIuMA0xFGdGgeWxAVWuPpLZMdeaCo6IaRkg1gI4K1IsknAHarTY44iOdRLVdkwuUXTEWPYTzCVW6EDTxachI7wrty5Y7FKv4N/dAJMtPOGpj06e/UNbt/taa+DyvU7aIzrSs/QoUnGyZzCmt9mNVAfu3teUIEqsXevFmLNBAF+35EMHVNaHZ2y3aCV/qyqToEZmY+cMN/HnW31FCgWEB+VNlLRhDd997BjX7B3mlHUxSRbFyRB/Y4KxpcX0YT2UVO4+pXAKlCb5WNY2jaY8u7JLpkoUW31AtDF2qCL6tZqKdjH3UrvHGdgY6im4RUZ+FcMMbapzylDJtJh1Mfyfuu+eyGcS9AikB4ZsRk5Ls/VVwJVenFRV+k7Y+pyQtPr9h7cOlHG9otEMS1/cRpc7D4qVkDWmSRLOzJvLQOfl6mEPXtllTrRtgw1+gGzV3yK5SbV9PXLf/n445ZqAH4Sql1gMdd03Hk8YjqY4ZmMAtAhysTl9JyROVnGvKDigByeuJNPknEVk1dnW16TySEkdh7rXm7ggcvLySrSP64dMRcz7/vfFcl9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(36860700001)(40460700003)(86362001)(36756003)(356005)(81166007)(40480700001)(316002)(110136005)(70586007)(6636002)(8936002)(70206006)(5660300002)(4744005)(8676002)(4326008)(41300700001)(2906002)(82310400005)(83380400001)(426003)(47076005)(186003)(16526019)(336012)(1076003)(478600001)(6666004)(2616005)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 07:35:34.6129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e48d30-c0e0-4825-9d5e-08daa05add55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inform host and let host handle consumption interrupt.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f36e4f08db6d..cb2885999219 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1243,8 +1243,16 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	if (!ras_if)
 		return 0;
 
-	ih_data.head = *ras_if;
-	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	if (!amdgpu_sriov_vf(adev)) {
+		ih_data.head = *ras_if;
+		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV for VCN!\n");
+	}
 
 	return 0;
 }
-- 
2.35.1

