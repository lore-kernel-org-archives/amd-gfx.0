Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D3C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 03:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D7E206EE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 03:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jg8mo3q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D7E206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE026E152;
	Wed, 18 Dec 2019 03:25:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0405B6E152
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 03:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt/LxD2hXoyLLNXOQRI2H94PCr81hBm7A39FpBzQRbbMj3kLNA4yHzl8HXWxh0EhiassD/adacyhBKrZARJyf0ld2DxGKiRl5+sSVv+xwgVdlsI8BSxUNQy3Qz2wTpJKVoolgcOREI2ytovSlEwS1EphdCrvj8sllieKUIUOrgwC53Tu5pCVk0ISoFQw+sST/m/y+Mvpx87SuSKXbY8+eCkuiz5DU2DD5/v1jED/dD99bVG6Al+WXjF23GBGsJ5ZjOR5Km6bz7GDP3oOQwxsGq/GLFsatT2MUXeM8G/39lhPFL25S0OV4wbmpYvBWG+Ip16Ue2MjF/YSbrzJ/OUu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz1t+UU9eEDnJco0qcwwTb3ZZZE2GUDNmq6PdACog7E=;
 b=GN8NvWeWUSMWyM2l5xQuj+z5Euw66ISV56QVGtwgddiuoLT5Z4HMwufq/3EVzKZcTUNQ48hq+UaRzSxXp1UfEJbP7hBTje+gxsxnrQEf9jYA/dXkLdzpyBDWKAMb4wojDR8SM4AHoPQvjgv1aO2LeCHoYxXPCf29HJwYLb2SNgtwyMbU6F/EcLw3S3W3FQEOUeKBgcUSNYAL0Z1hNz1VknsaY0++Tsnp6wSLj/PEnfYzaPJTxcOWz5X4pqK/NsuDDV8cnItRwA/uxXE36Qz+ZzkNrVIdp3vUGgZfXcm5GssbWxEGLcxBw+Cp9rsekOQ9bHJev55iomkE76dRmTLLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz1t+UU9eEDnJco0qcwwTb3ZZZE2GUDNmq6PdACog7E=;
 b=jg8mo3q7vEvThjk2iYZOY4cTa9bhN4+eISNQK5AG00chzZCdbr3pb1lncs6o52GdYfWDFnQXybNNGR8cByWvRglZqF4oef6EnIvYl9i8WHFoxjEo3qkciFu6TXQnCHuZuVXpsjuIfEKITKH2PHkO8vpwqYn6KpG9j16UAMbHdSE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3662.namprd12.prod.outlook.com (10.255.236.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 03:25:55 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 03:25:55 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correctly report gpu recover status
Date: Wed, 18 Dec 2019 11:25:34 +0800
Message-Id: <20191218032534.28482-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Wed, 18 Dec 2019 03:25:53 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdc1ec48-3aa2-417a-1d4f-08d78369fd93
X-MS-TrafficTypeDiagnostic: MN2PR12MB3662:|MN2PR12MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36621AE8D5DF8B2F82270D00E4530@MN2PR12MB3662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(2906002)(7696005)(66476007)(26005)(6486002)(956004)(4744005)(66556008)(5660300002)(86362001)(2616005)(52116002)(66946007)(186003)(81166006)(316002)(6666004)(1076003)(8676002)(478600001)(4326008)(6916009)(36756003)(16526019)(81156014)(8936002)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3662;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXOG6Ua2YwSwNkJYUmsvkw4zfdwkLBCxhwkvJyuwN6WW/mFAbOQrjjrFfDdff8yW1jo3PEaFrVXQVO8x2mvAzJYNZvtx1NlAdHo7+YSNGvECh+8dSii2kfoiaYOoJtrKISoeIMbSgl0gu02cb76MN06R6t5D1f6r4j7TKXjzcDPRGSRnfH0ssXIA6AWqW5lk7z3b//uL5x8QFsywtVLwf28QDnlpy1rH8km6om2CX0OE5ESmNlAuaV/uCGkAutdV2Rz0+mlU9b/hKH1AOktLc7o4O8AoDF5xrsv+eWujTCxxhvh2xpBlKvr2MHim6vKjG2v4odCJTxK1xlGlLXFP00IDA07klI16IYMTxyBc3CLzKt7peYgKtLglEMG/din50ycM7Ta8HUyNCRkBSzI0eUUkmVfvryQUZi73VnBx7QkrjehLqXh/k0yezAb+67eV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc1ec48-3aa2-417a-1d4f-08d78369fd93
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 03:25:54.9843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k423Jgb82hLLYlUSp7tEc4V8ffdf8QCyOuSdH+bsvtjn2Rh2XrFIJnxHlnxQ9pxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Knowing whether gpu recovery was performed successfully or not
is important for our BACO development.

Change-Id: I0e3ca4dcb65a053eb26bc55ad7431e4a42e160de
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index e9efee04ca23..5dff5c0dd882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -743,9 +743,7 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 	struct amdgpu_device *adev = dev->dev_private;
 
 	seq_printf(m, "gpu recover\n");
-	amdgpu_device_gpu_recover(adev, NULL);
-
-	return 0;
+	return amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static const struct drm_info_list amdgpu_debugfs_fence_list[] = {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
