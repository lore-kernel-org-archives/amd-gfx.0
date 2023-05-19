Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E97DC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 04:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89510E5BC;
	Fri, 19 May 2023 04:42:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514A410E5BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 04:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D96+Xjf5Xrqtp8itVxUujeKFS0KUK+lMt0y+aDgiBqmjg4DHF406SZZUJqRFo2Rk5NATI/HrJNXVZ8DqYI35ztTKYtBCJPeX2Hb4aTeod81dfWxPXTXokD5wf1dOD8wOErtTyMafVuo+HiZ+EwY7cEhg4j38x/mKbPylS5jmGwoWcfAyHwAAgHJv1GBteBGp/UdyNsgaaJTEND4mZ6Y6J6BPko5Ue7th0tjQmUF/2UPzN+tqzaC/QOp88pCuakoq70sm7wp/yHkT8gHN1pTfp0kiIqS/DkUoC35QP11Eedxlw1CZUK4Uj9X8tVg/pRL4fnFOHWZVLSAVy1Qcb8IpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64hvXwE6WzowkRJ2t1LN9xFpP27I90wq8/uQRrMs8uI=;
 b=nSzwSRneHVggSRifWTvkBF+uPRk3iZTI7v2LkpOcFD0Ri8ZlKM3vNIiLmMBnPL56VWNfwVjFNxJA8I37b4Wt+irbmAGeIfc2Hqz8lg5hbU6SVG4tWDnUCKqiNgNE/OIPXM05E3uNgX/44qjSLGW281trjWFQQ6P08OHB2RkNV5GX/DQJbcG7Mjgn2+NJ1vlYRJYxS5rp/hnkKYvSrG/l41g6QbZlhK7MnchNDUFLOKGbc95K7gXWkuVu2K/rj27ZFzapDGXGHkgx0mn02+9O38zUSVrGHUOUmlpkXnwFcNbLqonlNFd5UgecycAxbIoqNXqSQhqvb92U9uOeqt4e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64hvXwE6WzowkRJ2t1LN9xFpP27I90wq8/uQRrMs8uI=;
 b=ughI6NDg+OgJ1c4fPYEYumtgRAt3HXtpmRFSK719zUtOAgdxFWvl18+1W+4FXgOrYgVHQAAKGdksO+QtgU166vmxJWRVuYo4Z50eohUJNnJHFbUh4eSg4NA9VUf5QHg5RkaGR80CVqYOjgPV2A8HJA0QXIHN3sowBYW9wTm6rSo=
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 04:42:11 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::de) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 04:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Fri, 19 May 2023 04:42:10 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 23:42:09 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: init the XCC_DOORBELL_FENCE regs
Date: Fri, 19 May 2023 12:41:52 +0800
Message-ID: <20230519044153.16726-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7758ed-87de-4e20-6d9f-08db582368b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djkmgzhDKmbXPY6sNBogqV/ZcDQXRjkBeCsQ5YWY+F4T9tqpbX3Ll3gMqph7tyZsn52SB9UwesIlYH1HUpoRqR306l8YN6U8Zd5QeQ5LELx56i4k1rHUcZ1dAz2Dzbz2CeJmQgljqJIJrirBADb9q9XNW96/6OmDriXR1j22FFJJmWTWDB1amBCXjCO78dQiW2tGqLFkSqICIo9S9CcAmdyu4KSesb33XeUU4kD4pvTES/R7We7BZWIIyaKFQRbRScnkdDhp61t1f68uVlYCoQQqTV+wtegoJ3rXVMzFsdcmzOzd1zms3DKLK0ESp1ZfxhOs7/68TM8efX4bhO4z50yqjVh2EQorlHWIKVNnV1+ka7vxzJ4UJJ98EPFlppkRcHRi2k0ayq2CCNz+bojdVxq+RnwFVD9QbytgXykK311gdsZUnbfyQcoT7/CJXNcQd7xTVRNI5DAOxXGxh3W23FWeeSwgLSyEedVtbdY1jStF+u/EnBOMw+h0TWw/3TLixhvbwhgdI6pBxxd0nQUNVxz/HPCRsnJW9xH0hLZVVmWOoJ4WAG57KbKixhTy/xAiQD3L+9p/Lfpw2RT6STyy4cm8NdXv99PIgzY9dXkBVfOlAroYKkFNh4D5Eh55uN+gzMBJ9TKrB7jo0WmU9yxlxI+7QbMqK9iQ46JXxLZmm5juBRXU01Y0/G8Anp7IRbij6OCnXdFgtMqowhH+91ed66QReza8k2BQb/KCG68tvIPFOwGn8QTso2s9GX83++gDX9yXmaVptSnWNZPLBPkCZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(40460700003)(41300700001)(6666004)(36756003)(1076003)(44832011)(26005)(5660300002)(82310400005)(186003)(16526019)(47076005)(336012)(426003)(2616005)(2906002)(86362001)(36860700001)(81166007)(356005)(8676002)(8936002)(82740400003)(40480700001)(478600001)(70206006)(70586007)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 04:42:10.6408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7758ed-87de-4e20-6d9f-08db582368b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
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

add the the init_registers callback for nbio_v7_9

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 755259e96bbc..ad70086de9b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -424,6 +424,22 @@ nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev, u32 *supp_modes)
 	return ffs(tmp);
 }
 
+static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
+{
+	u32 inst_mask;
+	int i;
+
+	WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
+		0xff & ~(adev->gfx.xcc_mask));
+
+	inst_mask = adev->aid_mask & ~1U;
+	for_each_inst(i, inst_mask) {
+		WREG32_SOC15_EXT(NBIO, i, regXCC_DOORBELL_FENCE, i,
+			XCC_DOORBELL_FENCE__SHUB_SLV_MODE_MASK);
+
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -447,4 +463,5 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.set_compute_partition_mode = nbio_v7_9_set_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
+	.init_registers = nbio_v7_9_init_registers,
 };
-- 
2.17.1

