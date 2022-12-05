Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B68C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 08:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79A310E12B;
	Mon,  5 Dec 2022 08:48:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1A810E12B
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 08:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuZ9Acm0+SCDxfwMgaFeTXCoGnxLiIc85y7tDTjc6FKZPRL0q+FCI7vc69AALF2B/2cu7mMl9STiWzTCvsxpAA6RGtRIcOQapZBtfygN8MVGekexY8VHtx41PEmHcVG4eOb2usr6RDYW8iZzZIvNMvLOZq18n2u5Ip/cwsxwwzjVB2795DrRwXGtEyPU4DjHgUIK+CJCQfLtBSjREmVD6uBrnZ4bxIxoP+sMtKIOYe0zadEfkchUXuIGNWnnc4HdnADeADIuPUF1Ux7ci32X32DzUjjzewLS8HMsKyIGArseHA3rm6b6cUVQYmIqE4lvqGAYtwf7Utfje3u9LE/5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+CkYbdM1Sn2jhssCz5DJwWfKhDnCxpa+2qFEWVQgZA=;
 b=M5A2p/GZAZpybFht/KmHeOGVSRz3fdmA++VFy93TYrnDRKDzSvrg2XCttV/Vb5AsPr5ztR+X+J1Jod9tQrYiceYuVRSyZtKU+oA94YP7kfzVmKed5bqYpLT+DoD5Gs6Gq7c1MMXdI0Gya1/ugcNTmo8hl6o9v1Htp37FPgCF4BsM/H4UPJOBycYqb44Px+oyhcQE+O+meXEYKFB93Jtk6XlA/76w65bwM1wJXXV+2os3SBa7zmzI4EANBwC7o3Vps5fPwQMOdBAg1g8Jk4c2xUTTLoWIIjuZaFxYXTNS1H1Et6ef+q/r1kvabLORIJaq2osCrA/V9aIVkNidnkFDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+CkYbdM1Sn2jhssCz5DJwWfKhDnCxpa+2qFEWVQgZA=;
 b=4YFWcj21jeZl7wmp9S5cwzsA5g2BF0Su87jD2gtodZRTF+q7EJ6I6Glkr7ruGQuOoq9ifpGKQ4lAGyGnUdPoGYFuPisK9Si3+coekXlAy4TDKnhgFaGgewttoQF584832VM3wBMn75Dkl+Flex1g55RmmWoujoHeClB7/IbzgLI=
Received: from MW4PR04CA0283.namprd04.prod.outlook.com (2603:10b6:303:89::18)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 08:47:58 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::bf) by MW4PR04CA0283.outlook.office365.com
 (2603:10b6:303:89::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 08:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 08:47:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 02:47:56 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Dec 2022 02:47:55 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove evict_resource for sriov when suspend.
Date: Mon, 5 Dec 2022 16:47:36 +0800
Message-ID: <20221205084736.22864-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 66427484-2fc4-4e6e-945a-08dad69d68ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpuIGhR+OQMEC5cHNLrqSUN3G8SUdHtNQgzlL3vagL3h6grrLsNRZKs8wibMPc3s9yvA/mlJsfNT/SO4KbvOPKSQ5npjeAIaRnC/wp954ZIdrnZHvj4Hf84+6PJIcjrBHsNGuuuE0V0Kjc6Qi0v7oQVQfh01hDrND7Rd+UHuCKtMgE+1YU6w8WN/2+SobybjWndxOHMz9XDRUOyzn2SHw6BVfxGhaIpCajw/1iFTkIkgmZUjZh/sVwbi4MifYALnRMZn/H6PEf1DsDGXg2r7HwRlCGjPr+bZaihvHAcDrp/6UUK1a9aHPs5t4utOlSiXkjyFSgVAcrgSPmhMGQDHqn57YtiT4+Jx3QqMopCc7xG8PUOepYMrfw5sdo2GZAvu5HGCb3s6cukIYXvCtPpGlM73S8e/qEK1aOmwlN1BVhUfsIcJqrR48D1p4ptKyY2Vu3PdjWMu3K0DfOWvQgQacnQ9nmR32Tf9FOEPl0r/VpZwBlcUCWNVJuXQorstBN6y+KFNLszTHg1SSk2ABLRThkes//7RC3AxyfQP/dz0Cil2UQMzHa2ntlXdKQzfw9snF9WLTaNL0rB72Hfq40I5Ur9RNhTmqfzjbtiVP1OYTNaeLHxmvmqo/+yOTurTN2FUObxMXhZg7puPJ+wLv1Z4JnmyzFzy8f6NSmmWYO/3HupcSKt/SPrwgDFB6STzZpaKFMOZbcVYyDs6CbAKDlKljVoAB4BYrDb6nrfzR+Pvl44=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(40480700001)(36756003)(40460700003)(86362001)(478600001)(7696005)(26005)(6666004)(5660300002)(8676002)(4326008)(44832011)(4744005)(41300700001)(8936002)(316002)(2906002)(6916009)(70586007)(70206006)(82310400005)(36860700001)(82740400003)(356005)(2616005)(336012)(186003)(1076003)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 08:47:57.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66427484-2fc4-4e6e-945a-08dad69d68ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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
Cc: Shikang Fan <shikang.fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- There is no need to evict resources from vram to sram for sriov
  because GPU is still powered on. And evicet is taking too much time
  that would cause full access mode timedout in multi-vf mode.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 818fa72c670d..55fe425fbe6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4135,9 +4135,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
+	if (!amdgpu_sriov_vf(adev)) {
+		r = amdgpu_device_evict_resources(adev);
+		if (r)
+			return r;
+	}
 
 	amdgpu_fence_driver_hw_fini(adev);
 
-- 
2.25.1

