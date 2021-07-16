Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA50C636C9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94DB6115B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94DB6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B086E8D5;
	Fri, 16 Jul 2021 01:25:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201C76E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOWdwmfTrgTBXhCn7C958K2FhiNX0blD3as6uNikQ13jPXueVX5n8nNjOpweMnk+NjGurzBf1nimUsqeJwIwT07grfGC9ODap4lR2ie/jPnxhZ1IZxjPdeLlT0bYS/z6EtBVN81Sm2VS4TrfZeduKXXUwqtnhPC9UXMopsRcaBISXtkbnyVbH2LM7WtRt+OIzWnLTH8Ekauiiupte81WGV4SKDz8lst6DQhGjLKsAHUsqn7RGAjNDzFYvZV1+QvlZOccphobuTw9p7/R3fsFyz342ITkmAdIxlO4L0QwuVNQAqAPPPRz98+2LoXcBdeDe4ufmIoQ/vJhR9HeN9FvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkXAwOJj+mIlFi0mQvFOs4aHsTFQVGQ3edN6QRX4uN0=;
 b=ny8TSgGh1jyUTHrGwfgNWY3OkUBcs4q9gubTgs3tRFxTLKdKXvZl9voQCGSjBLNWyBYAckx3YxAHCHjPI8vIgTIkRgqUnLF0X8mZG67v+3baYZb/uhUqwqUluXxLrQfPRESi8F0gaEq4tY+4vy76me9j+weBBPHwd4ZcY4IZ8trzH10OFhGV8rjVW+lehMJntv5d2Pty0dws/1F2u9vxjOBcH5WyoX2WGRk5f7JxBza8p4fGxc9vy+6o1dT7BMKj7PUZrGQvUMaUnPcgf3hHu5TOqQPMDb/O3eQ2UHrWtpZ4YYNJghXCVoeE4lTtDhrA/Yh4JGC6a6iyCNGVwAfKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkXAwOJj+mIlFi0mQvFOs4aHsTFQVGQ3edN6QRX4uN0=;
 b=Yd3fsIkmDEgKHvoj+r7YDAAzoLzaAFQZxNQB85RfhK8c255SDWXeENnL6LpdJ/sjef33dgjVb8i7NWCVCutc6JpDPfzU8VBOvu/4OuVXaBvvMHbwhMAQtS02f4e0o94it6n/GDO65TDLgJ7pGJuCyfjYTWA1NdFqmoWhPyj8Le0=
Received: from BN9PR03CA0242.namprd03.prod.outlook.com (2603:10b6:408:ff::7)
 by MWHPR1201MB2479.namprd12.prod.outlook.com (2603:10b6:300:df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 01:25:24 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::2c) by BN9PR03CA0242.outlook.office365.com
 (2603:10b6:408:ff::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Fri, 16 Jul 2021 01:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:25:23 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:25:22 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Change a few function names
Date: Thu, 15 Jul 2021 20:25:12 -0500
Message-ID: <1626398715-6419-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd7bc933-fd53-431c-0276-08d947f895bc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2479:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2479A054BBB0D067930F817E80119@MWHPR1201MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrl3haavSh3SpmEXhurIJxckjXD1gTModQI9a033xCSfXE+dvPuf9gK9KfzE1VOu38zxdUO09+5cOS1ASfV848yoZFLNoDtu6/zxxPBlhqzZgg9toChvsfdd+xPQlZf5PNz25BHo5NGPUVmJrgz4I/NueqCT3RQprhc4SCPdxw8q0CLK/9tGRjOXFsCRSdA2HzH8RiRstPQ4IjvWlWOn/udPSPwv0jnEVQKtVEa21baNAzw0gerjtnX4fsEvUv60NvvvBX2y1H5hsOfLjEQAm9CnFzR51NXMGrDkKlL431yzXfKe8CKu0g09iHJW8sMXBZks/iltstxKTLlfEl3516EBivfkMghwCBkWWxP8bao2q1az64J9nfJJw5KeR5GRtBnqmdFqIzt9HqVCGQYVgqBwW/WMegGtmE5IiJvpdOJfVf/sG87p/VM6bxon7AmRnnn2CK2enSNFBcNzV4CQj4EuJcmHkFEAB2ih2dEOgMSd8HUN7moUS3IJ1eAKciJSQ/9zlToaPQvMae7L0bXvp8AU6wjbJd1wH0mOfcBs9XsvTP8XxxRyEPi7lv8wKBhAkHqcg3dvMPqGJgjiCGJQCCTtbY+UaFyQlK0qM3Q4wWH85Oj5ATEphJz6IirznwnCP970EGFEnPMRvidYbqq0gFctnG2x7EfUHYJrkCr7BvvGmC37qy5nKIwgByc/3BLTPgT95GcHRhVx3+fCe8Zv1LkMIfNsdsA1lXZRsPFeZFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(426003)(81166007)(70586007)(6666004)(82310400003)(70206006)(8676002)(7696005)(2616005)(336012)(478600001)(86362001)(16526019)(8936002)(54906003)(36860700001)(83380400001)(26005)(186003)(4326008)(2906002)(356005)(6916009)(5660300002)(36756003)(316002)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:25:23.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7bc933-fd53-431c-0276-08d947f895bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2479
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Function name "psp_np_fw_load" is not proper as people don't
know _np_fw_ means "non psp firmware". Change the function
name to psp_load_non_psp_fw for better understanding. Same
thing for function psp_execute_np_fw_load.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9ddb2c..8d1e2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2351,7 +2351,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 	return ret;
 }
 
-static int psp_execute_np_fw_load(struct psp_context *psp,
+static int psp_execute_non_psp_fw_load(struct psp_context *psp,
 			          struct amdgpu_firmware_info *ucode)
 {
 	int ret = 0;
@@ -2387,7 +2387,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		}
 	}
 
-	ret = psp_execute_np_fw_load(psp, ucode);
+	ret = psp_execute_non_psp_fw_load(psp, ucode);
 
 	if (ret)
 		DRM_ERROR("PSP load smu failed!\n");
@@ -2442,14 +2442,14 @@ int psp_load_fw_list(struct psp_context *psp,
 	for (i = 0; i < ucode_count; ++i) {
 		ucode = ucode_list[i];
 		psp_print_fw_hdr(psp, ucode);
-		ret = psp_execute_np_fw_load(psp, ucode);
+		ret = psp_execute_non_psp_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 	}
 	return ret;
 }
 
-static int psp_np_fw_load(struct psp_context *psp)
+static int psp_load_non_psp_fw(struct psp_context *psp)
 {
 	int i, ret;
 	struct amdgpu_firmware_info *ucode;
@@ -2488,7 +2488,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 		psp_print_fw_hdr(psp, ucode);
 
-		ret = psp_execute_np_fw_load(psp, ucode);
+		ret = psp_execute_non_psp_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 
@@ -2565,7 +2565,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (ret)
 		goto failed;
 
-	ret = psp_np_fw_load(psp);
+	ret = psp_load_non_psp_fw(psp);
 	if (ret)
 		goto failed;
 
@@ -2765,7 +2765,7 @@ static int psp_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = psp_np_fw_load(psp);
+	ret = psp_load_non_psp_fw(psp);
 	if (ret)
 		goto failed;
 
@@ -2863,7 +2863,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 	ucode.mc_addr = cmd_gpu_addr;
 	ucode.ucode_size = cmd_size;
 
-	return psp_execute_np_fw_load(&adev->psp, &ucode);
+	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
 }
 
 int psp_ring_cmd_submit(struct psp_context *psp,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
