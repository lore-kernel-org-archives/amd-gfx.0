Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF5BC3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B97520848
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dGx0tW44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B97520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C026E313;
	Thu,  5 Mar 2020 13:33:25 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E126E313
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWtf/TVbIFUMx9kI6tw2ACWeb8Zu5sHFWUwreQojqCW3M+i9k8CoDYhoNS0DpVaUBzWuE+ZSp6gkFpGqOLU8Yg16111ANMi+6SNfdQCu7M7+6ikgo1igd77e8i7sXiSPzJ8RPxkGEIOwJ7rNH/desBDWmqeueAByZh7NXKQbOonUOzjLb4sZ7KVVEerffT5hm6ryHElpk3H0j8ywRglUDq06/IP3OQjsWHBvzdwMcX3ff+WecK7seUx0oOra7Drn4uf2nwHxfTastPoqtNyA6HyGVjyimkg/9UoucL3iGVX7lHsEIPg4nQBGN4ZJ97zcj65wvNpUGekNEFfYbK7GnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv1Blk1TBfsJBqCM7AnYgjCeeJLMnyENvCZD3Z+yQ/0=;
 b=PODBCf5/rr3koJMO5KuG5bGBVmDaz9/7XdfW+6u8u0id8+mGp8J6tpkhMZBn+8p9zRAZ98SZQ85l3FlQ5xWjl/RqQzAB5HSPeSgAOzOyYT4jGT29feq1Fu0SrwIj5oR46B/8kytd3pOzP55QZn9LbkwIITP+u/frAttf79G/dSo7qraoVVFmQERcq5duAwsWAHRoeheanyk7JX0bCjHYOCoeQao9G/1QVo/F7x0MbkFgrRZ1srk/V1bPBbzjpdEFo/8WplKleEjWGsMrIzIZAVXCZtbCLEsu06l/EZdNhe+vKWINVTauqg5nvhNy5wRKDq4rJFKz00XRlCcCUbb+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv1Blk1TBfsJBqCM7AnYgjCeeJLMnyENvCZD3Z+yQ/0=;
 b=dGx0tW44nNlJSSYJ1aH4hdAfd3o5UuVVxKewLi5ZGjcBDCbwZA/4cIHFrexi0O4ApPqF2wD4b5fKymoWRXAYx4BO9Lr1TokfUA+2SqAkovvt9qBmS63gyPMfyylJFl5GuQURMIy+iMRB+McKRFJ1RsRKh7inwXckUY7G0/EFlwY=
Received: from MWHPR14CA0049.namprd14.prod.outlook.com (2603:10b6:300:81::11)
 by DM5PR12MB1642.namprd12.prod.outlook.com (2603:10b6:4:7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Thu, 5 Mar 2020 13:33:23 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::1b) by MWHPR14CA0049.outlook.office365.com
 (2603:10b6:300:81::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Thu, 5 Mar 2020 13:33:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 13:33:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:21 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:20 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 07:33:20 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [enable VCN2.0 for NV12 SRIOV 2/6] drm/amdgpu: disable jpeg block for
 SRIOV
Date: Thu, 5 Mar 2020 21:33:03 +0800
Message-ID: <1583415187-16594-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(189003)(199004)(81166006)(5660300002)(81156014)(426003)(8936002)(7696005)(186003)(8676002)(336012)(26005)(316002)(2616005)(4744005)(4326008)(86362001)(36756003)(356004)(2906002)(6666004)(6916009)(70586007)(70206006)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1642; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79adb37a-1e26-450c-4b85-08d7c109c67e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1642:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1642697FFB0A9D543A2C600884E20@DM5PR12MB1642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M98gl4b3r+xpr09MpeLVuDZzcQbUsXJctN8V4zH4L2SPbW2I3ZFyXz4vNzViX5caKMRlIL9XezbqTipTZbqHgRL6GD8i3L5w7uRBmpf5N/JaYppLEZcSC1kQ1ilq1itx0n/FsctCxSuaEir0d3AK2CjGgbCe27ZaoD1EnPY6kkrVz2oPW/ppoyZKIBykR8V+CoBZTfiTHPhCjLAxQr2cTMzwFQ+a9ZBbPzPcV6CxyaT3wUZjbYwASFBy5Q4rNtgUCf4pqbx8BKCsmd05/yLhPnN800hWszFQbn5PSfWbRYrmzGAzuRyRoci0XgjeIdkVSAE04wVLx7dUAwkbz8bKp/RcRved4r/Af390tivb17SvuAViyhgUgUIAd+sqrS4gCv8g1JTvAK5B9/WMCQb+dw1a8DGrnc1Q72qr86A7BsC4m3Mjpf/MaaCr9tHI5X8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:33:22.3657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79adb37a-1e26-450c-4b85-08d7c109c67e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1642
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2d1bebd..033cbbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -516,7 +516,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
+		if (!amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
