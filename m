Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7695C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 10:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E4D601FF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 10:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91E4D601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A026E423;
	Thu, 21 Oct 2021 10:12:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10646E423
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 10:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhuzWKBlK3zOd//HB1qegKr2CXZJSZJHyMwCucVfUAwunVCgahTP+ILnQx6BTqypOtgnxUkymG4zvtYnXDCuTS/kg2FCMDowaeMYPQ0zEtit2tFc157zboTFYpL3sxofwz4aQ7BsqofvlHCbOARnbjdQPxmSAU+Hokp5RufDoHpDbHSyzM67mI6IdkhRaHx8l7HAHc0LiqvN58FGP/it2ZLUTajFSx/QxugRG6fjYR6Xwa6SwwgF2c6B8BaD0ht4dwPNACllotRazCHany5EwJd8yOKg6pxbfAcexSrk/r5YlLINp+TlOrN6yQfchoRZ1Lup7feokOea008EFqoRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahG3jojD9Bsf2O0Gxr8ayyEFK0sNMBJWr/mnwQAR/I8=;
 b=lEuGctd5R08hBz0+eBjoFhRTIxgKoqNJxnsXa4eCNyH2WrAeO6T/UkoHPcrkx+/7KazfaplvbSIFc5xiXuWDJL2mohFAkAL4h/0zVbaeOav7BUl0EF9fkz0EWphExAK1CIyQNH9sj0+Xgbixzl0Jj5sviLuAJMjXXGgcOs54R7v71L0U6TDrJDQL+Fn70zz3DbRw0nAGibrcjA2qEBIuIP+OR4BsbOC2QIBezLmqrRseZgG0Zi0QmAlDD3v87jftrH+8L90bddS2i9BEUJyKIKzSG1M/+/GHOAzeIrcw6AVAja166FLIWS11U8UfD2hzHDpmgxSI0cshHXAeuzJYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahG3jojD9Bsf2O0Gxr8ayyEFK0sNMBJWr/mnwQAR/I8=;
 b=dKCuue2Otx28u9EEDUaHL6yxeyIDW62HruNMT+VLGf1uNzUbnLxfKBWiMpV5aOr4a0rSR5tDCdxhIYMofco8yrYLAsrk3Pf6xVIui6CRGXunpiEarV/uos5dtiAj8dS6JGFNSaPeGYQ8m/0XeF2+E/MlVI8R0FNwPECxtJfal2A=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 10:11:59 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::dc) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 10:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 10:11:59 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 05:11:57 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <horace.chen@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: add dummy_page_addr to sriov msg
Date: Thu, 21 Oct 2021 18:11:38 +0800
Message-ID: <20211021101137.1147917-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd748e4-c188-4400-24fa-08d9947b383f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25193901B4755F3B3AE15370B7BF9@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpdTkLNBh1tM2hkvmvLGp5/Z2LcHgUTIJUxwb5ULpyzno1HMF6esleQCHrzYcMR4OW8CG1SIaef3l1RAOG/7k4JyYrUT3aPBLvNOzd0V02mvgob+IkT6rGjUYb+zbDbZluPpnNRqw0tiBGT4LQsxBlxc2LvUQc2oBN+DL/dI5X+r3fzqBHb+NtSvLy+5Wu08lZeQ5hZf8JrXiilcoOKbBhuFiHg3afi6wDPaodPa0oh17cOVBmcsSWv6l/QBVQQQHzQU0fjTntiRFBMteuP2lPKTTK4fvyk3gzw3gIKTdW4/hXhKHMxVFjN9IOKrOGBI1EmHyIvchshdxFXRBFwjS90J/uOVErjGYUn3tcrPw6ThL9dIvypP/JATLdGYJC32yq0wbJqwwfzERNQTNN4K5ykOzt1dxt5D+UMlH6wExUTOYkU+dYR91VgwJNm1l7BMLq3xFmhgyIU0d12U+pnSH4Y40Ji9xE2HRI/gpcMUUBi8u+9Mxj9Idf5T28yow3ZGjY411xDFXjmY3LHfVIZkRgrGDo6r1ydiBGUuXxXNETlycx/zQgcY9neaWoVPUZZusbNQzWS6dL/tP8NFP8QPvFK0XkjuQBEcMTwXoEqQNzv3n/ZtvFHWFp2KGesxJro+cPmHQWsDDoFJL0saQT98y7qYYvHYer9kxozXFjnWmJDofIvcbBU+iByCabmxoqod7EokzBTj/BW1qTuZzk8H0/XxqMtF6CNIWjqkke4KJCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(2906002)(7696005)(36756003)(4326008)(5660300002)(6666004)(82310400003)(83380400001)(508600001)(8676002)(336012)(1076003)(81166007)(36860700001)(26005)(70206006)(70586007)(186003)(6916009)(356005)(2616005)(16526019)(316002)(8936002)(47076005)(86362001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 10:11:59.4746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd748e4-c188-4400-24fa-08d9947b383f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
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

Add dummy_page_addr to sriov msg for host driver to set
GCVM_L2_PROTECTION_DEFAULT_ADDR* registers correctly.

v2:
should update vf2pf msg instead
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 88c4177b708a..99c149397aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -584,6 +584,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->encode_usage = 0;
 	vf2pf_info->decode_usage = 0;
 
+	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
 		vf2pf_info, vf2pf_info->header.size, 0, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 995899191288..7326b6c1b71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -261,9 +261,10 @@ struct amd_sriov_msg_vf2pf_info {
 		uint8_t  id;
 		uint32_t version;
 	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	uint64_t dummy_page_addr;
 
 	/* reserved */
-	uint32_t reserved[256-68];
+	uint32_t reserved[256-70];
 };
 
 /* mailbox message send from guest to host  */
-- 
2.30.2

