Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D76C636CA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB83613FB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB83613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391C46E9BA;
	Fri, 16 Jul 2021 15:37:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962176E9B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 15:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYOA5CDrD52ZJ7w0aoJoTq1ooO25yPf1RMTVIvPdG23GxOj+JxyVvvqz0OEUUTigf6p3+Xw2KSSlJzh5S8dmUi/lO4Lz2lH489Z0Sn5gGwxAtrapXsGp/T+Bvj2+gdPHjSss8wVn+4ED8uE0k3r4Ef71OyNJVabUNkGdZnM1a/yj8rT3ISmx1tdLubZ/GG/WTjOpLfmDHrSGRqwKLo+ddmr8iLj4BJYvpuRaZqRY9WSSKlt1/c//v4X1DULKMSYyXfV7dM/T38HqEyjXXAItRl7Uln72G8cnDEvd1hMR7CR74wtj2MevNZ19vzbVSp8XI9DYFM6JVJMkISIUyQNocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sYY4pTXEqCtGs/pdZWFM3433lTNYps5qBWKOBhvJxY=;
 b=bSI2znSMFYauWKNiJvZuJ3W3FopLHTAsY/rtN8rTxLUhAD2xXdeTk8q5QXt2Oo3erlriDj9eoeTL48Rv2OCaXkQ4klJknkq3pQOL6lQaYU0UpmcgS78BH61RRYvj6smHskhROpWg3KpatVgMPfiv4jsjgctaK+GoCP5U/hgYWkJBoN41gSmw8/Msx5W2LTjZJ3rnUWzNGkt0ZO/R+OPoqUyAeMd3ZXjsuVSaL/SkCh2l0Hk0NC2qQimAAhszg4hlVoRFHsxmuh7V7JLwjKoKQ1u3fynDE6iplJqKAyhoTHStbFgmh5NqPjFqufYWddbcc6VndALr0L3/BXe7IsObUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sYY4pTXEqCtGs/pdZWFM3433lTNYps5qBWKOBhvJxY=;
 b=MEzOtjxVJ7rSrOU0vELaprX/kW+gBoefeCS2ftEW25ylgQuSm5QPv0atiT7v4m3jv95JEiu67uplU24ph0KyYAYgdSUr3SDcJ8VUaWB/1Y+/9WYf5YAOSxF9On/h5zwz00mFmM9i3+L8kApRQTbB0B8c5sMkaJiUhYU19zdiEaU=
Received: from BN1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:408:e2::13)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 16 Jul
 2021 15:36:59 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::29) by BN1PR13CA0008.outlook.office365.com
 (2603:10b6:408:e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Fri, 16 Jul 2021 15:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:36:59 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 10:36:57 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Change a few function names
Date: Fri, 16 Jul 2021 10:36:47 -0500
Message-ID: <1626449810-18044-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
References: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 105d7259-3d09-4abe-0b55-08d9486f8d24
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5333556C6ED11AE66002746780119@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZMFdOcNBF4CXYm/pMQHb+XRQqlun3ex/xvr4shQSI1ookn/P02y4Lj5Vx7yvsdYTPgtq6IisseuL/hPoE6LazGzP2G8Stb45EY9INRm1JLBcCxUfPaW55kYF5nbnJN/JcWcqctTHYDms9CbLEB6X5KhmE3qO1ph4x1dvs6G3KjkqbCfNF2eZaWvjeFGcgJFQZxsBReEz/wUl36vyoAGvNHWqxzdrsA4YFyky4FEhI5hmf7xLiDuL5nV8HM1+ZeskwEkktUztOmB9eXmgB+VtgDteytIcsEB5mr6LMn0evkC7rPs6jDsrrSFGLYbrBOU27JbXPg7pHBhax+Mobom2YHu6FnZ0i5U8SmpcXU3UAF9zMNLUH1RxvgWxIRBjg9Mq8zd3U7yWw2ns5lBQeNxejJLgbe8PUhL2Iw6QT802Z2H+8PYNj5Hy1MPN8iT59yaZvyX76HhS1VDW6oV/Gsa9V9Xlz/CGzgaqupEyesb9Z2kKahGnF8cpMzeXIUQ74I657CRjqKyu/1Eg+e+hYOcdEkccva4StD5P+jUH83vrErROTV407X2UlxOBeJtbc8KdN+OTe0Fm9KoEV/tgJlapdNzsceYBCjnMjfhiV6wg1KsYYQpWwCMxZ9Y7reeIEaNz6X2QY5T11+FzjVxuq90SwmC8+P1EBo3ZZx4Nv53rNDOiONOtWfrv9dSKGMJtfQ+b9+fg6qVdmvKcpf/tEbBtHIzULgkWvX9K/kIjift3kI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(70586007)(6916009)(6666004)(2616005)(86362001)(336012)(186003)(5660300002)(16526019)(478600001)(4326008)(26005)(426003)(316002)(36860700001)(70206006)(82310400003)(83380400001)(82740400003)(8676002)(36756003)(356005)(81166007)(47076005)(8936002)(7696005)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:36:59.5635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 105d7259-3d09-4abe-0b55-08d9486f8d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
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
