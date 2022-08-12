Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02428C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 09:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8780E8D5F6;
	Fri, 12 Aug 2022 09:14:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1B58B64A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 09:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLFAGXuudnSTyS/lH6vyobHdcSEocBZ6qsx3liweISoqT5SnzTWML4yTZmkXbquzlGar+H8q00CwsJVC/a1j5CZkT+WjOvU/rs2KbrGW6YckT8we8poqXUsC5MK26zDLnRs7ysCpz12GztemcBCu18CRrWPWnUVQOVpllkidJOBstnOgk8dm9lbcSAWb01JzUrfF6U8+YzLpNX3MmhOExSr1ZrjwgTMqyAabFMZcUl/mzXyeRYeNG4jq6MfmfEewzMzsJuNIQwddiF9asokV1FPJ4uAKtBKMPZr/Ejj5blbyv08DaTCgwE/uUJtlajAmXc5O0BM1X4TRdE1Kb54+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yCQF6ady5DIqbt9SitybDQBQP/G6LCDzmkW08re8fg=;
 b=cAhU2sznpWuFkux67gpsy1fDgGB4M38B7u2jc47tLYQE3E4/YMQjPHdJe7q4o049uKvgenR0nICQrUi60mN3OCW+s2maGq7GaWkjIX7h7oWqwB3WgXs2ZscicftopX8u3Ik3rMNzPkrZethb9S2DxasUIdcId2oR9mSFl3uTIypqQR23BwsZkCngBVQdTcoDE5sWfk6NLppaXslC12fQwagKigmMabnaa9FariZ0hhuLtZbdMwsRwILJICRHiuYqix0dBAEQVwwr9YlyHXhxe2sNJ1apzF0kY65KGDzE91a55V6OMDMfiduZ2dcgWwmQDL3na1TGmqEOPOWFyKVjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yCQF6ady5DIqbt9SitybDQBQP/G6LCDzmkW08re8fg=;
 b=rHIkpNdRgHJ9Fd5cXyKNdYTJYuvd4PIfw6j0d4Yc3/CexObyz8+rCfhySgUMP+Bjpn+GpYolLebIl8yewn377NSLzKNx3kL5qyLFlwV/RndESFqzrnXe3FNANYaJulv0/R/yLarrFMmU+PKotdFx1MxU9X96qxW8vDklZJ4hQ6s=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 09:13:51 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::2b) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Fri, 12 Aug 2022 09:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 09:13:51 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 04:13:48 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device needs
 to be earlier than psp_hw_fini
Date: Fri, 12 Aug 2022 17:13:16 +0800
Message-ID: <20220812091317.338637-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca1281d-62c9-4857-ac5c-08da7c42f921
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uD/H8TKrMbdFD0SRJDyCChjonqxhdCdwtudetRvKDwOH5zaIklFcXmiCKpGCGIqdoC2vd8t/2BgUEEjhoow9Ccl5ei2kVYA/t+zFgzd1XDEcTVsNcQYhQ6am8VMwrUEeKKksULLpybgtVQGAwJp8kB7wFzfqix+JcOBHLjEue8L4z9EksmCBu8LJLie1oYsZqfo+GnWuhxk5QrvOpo9SGMu6PiqSHbImdpsB+sTQbB7W2x8pztpgHY4srl8In03F00hJX0oDeWFY9xHfw0HEmDOu7tF44eed2RKPBc4SW0U2/obxHpbSYYS6rxVyA8OIESEWDS8zjAiImlbDlFn0toj2LstAcFqWLWjwWW6cgQHXRIVb9tEry9aSWPPuDnR92uTONIVjhMtgqL2KxC9W1Kbj+DdcVe6ZnJ/cKd1DRkWXLrc3hKeHFVs+0jqXQkQX0Ei1qFLBNOMYgSmRTi1ymhEomL8O60BhpQMcbUSwrgfu5wuqUyq/s29OYBeF1LHTQfQEowGrzb6dKN701MmrHW8JMWJ/J7ls1ZJA1wpCXFYsKDUc8qEjQnA1Gh/MgrTE+ZdcFEeC7dbl+056b4xAa0Olgi+Q0w8nns04avfRY5Po8sxRd+mKGqUSPXzVlXZiTu53V6EeWgPudL3VND0BMNtfY6WV2GjTwBuBMWDaEuYnCpx2GEaHNwB850YNqA8Q2MeO5WHeQkRnvBEyPrg2toNw12I7OH+mpIAtprS6iV3PqrfMR73E16mTvVjEk3cfKH71os+OW5dkHBacIKHuFqYnSe8rj6fR/5pTTArWKH7jLavSbsTS1Z37mOIid+OO1YWpYE+75WUEE6J56dPXYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(70206006)(316002)(6916009)(4326008)(478600001)(5660300002)(40460700003)(54906003)(82310400005)(8676002)(86362001)(40480700001)(36756003)(70586007)(2906002)(8936002)(36860700001)(83380400001)(82740400003)(81166007)(47076005)(356005)(6666004)(41300700001)(7696005)(426003)(26005)(336012)(1076003)(16526019)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 09:13:51.4672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca1281d-62c9-4857-ac5c-08da7c42f921
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking.Zhang@amd.com,
 KevinYang.Wang@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_xgmi_remove_device function will send unload command
to psp through psp ring to terminate xgmi, but psp ring has been
destroyed in psp_hw_fini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c84fdef0ac45..2445255bbf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_suspend(adev, false);
 
+	if (adev->gmc.xgmi.num_physical_nodes > 1)
+		amdgpu_xgmi_remove_device(adev);
+
 	/* Workaroud for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
 
@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1)
-		amdgpu_xgmi_remove_device(adev);
-
 	amdgpu_amdkfd_device_fini_sw(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-- 
2.25.1

