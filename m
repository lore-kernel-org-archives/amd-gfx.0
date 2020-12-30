Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE8EC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 11:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2A0207B2
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 11:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2A0207B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00CD8917E;
	Wed, 30 Dec 2020 11:51:07 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117F18917E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 11:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OESAnDdeM4avnkfVjUVEoNNhvtZZfVd0iNhvNQKBTBCwlYdIGvmwJJKqpwcD+LthbRsgamsVsnhx2XFgfO1LkNPMDtQJ/1lILrQbx3m0su9ihDB1QcNnYdZ1PMG6HGJeFCAcm51EQTV3jAXgtlmodYBHEgIN9hFPdu1ma+n/GICR9QSfFpiTv7yUdNhQ/ARxt4FMbPcJkU0h9uKrNDt7vV7rs6RY7BRk1qjdfZORtF6aTjDbFlXJzj2jAdjB+szQZpAna5FO7RVXZlieByI2vhesCo5SloTgaQ+021CLgVG9zKUIJTvcSIDYb6QyqFFGTzVmHajf2sW9M/STVMJ11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhj2s7fXxPBlmBI/3Dijcg+0XWyHNbc4CC46cJN0uZ4=;
 b=ajWVRT9PJZFGpkwotMKmieF2yJpxjsXFGwWCQbw6hE6TGiurQHPBOC3SbjuUW+Pc7++88iNuWbyMuTOKQZGicReEwdKInYemZulNUZlx7cvj1JqifS1lv5l+n77zVo0rYgs6WY2Nu33BnuuH3HvOEHcpptbOWfnyOdoGXu+ceyhbl66kyZ1Zaj8bAr5xoW88WtO2B95bFYl9qtl+VNVS2fD+vVJemnvkyJYqyjOCRedF95ux9NL2lRc8c9QQkHXN8ZiIoZZoyMdRlW8xKwmxB/1eN8pOPbN13eFWHbFnWT7udrGHM3HpQpeh6pfnrNsnqsqUFpYDVYtVjKUXyzeP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhj2s7fXxPBlmBI/3Dijcg+0XWyHNbc4CC46cJN0uZ4=;
 b=pYIgIf/6mvXzUx0zl65ji6QiyzZzhn0lilKHPLGqgV+KT2cVyFGyNJyl+tXlPEgFWy/CQasksCQJ6CSC9imxjCj41rxQol1lBSZxgjOjKbMCaAF/XeR3y5jaMPxNXSgc7nyGzuOiroU8DTnzxSZUuOi233Fm0F8t7eolZ6xikRY=
Received: from MWHPR22CA0066.namprd22.prod.outlook.com (2603:10b6:300:12a::28)
 by CY4PR12MB1317.namprd12.prod.outlook.com (2603:10b6:903:3c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Wed, 30 Dec
 2020 11:51:03 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::2a) by MWHPR22CA0066.outlook.office365.com
 (2603:10b6:300:12a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Wed, 30 Dec 2020 11:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Wed, 30 Dec 2020 11:51:01 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 05:51:00 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Dec 2020 05:50:59 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jiansong.chen@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix a GPU hang issue when remove device
Date: Wed, 30 Dec 2020 19:50:48 +0800
Message-ID: <20201230115048.11045-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d46dccb2-c0ba-4793-cbe0-08d8acb92e28
X-MS-TrafficTypeDiagnostic: CY4PR12MB1317:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1317DD59C59C6A08ACAA641AEDD70@CY4PR12MB1317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lgMYqilLmmzxtzPQIPvDdtdQ19UzqWF2c++dQ8s7UVdRObYj0icLuzpgq5d5cMgl0vZ0BUGTcCHJmJUBEQBO/GDAhwkCwihmslezCZar1oAzQOaKMnEuarBxxMwo+3nBFUTVYE681hQAUe9f1pRPNPUufTk/TwXRR68vBsDl9PaC+R8AzKvZltLoX3Z37ATxo7/fqN2fcTIf9Br2w+HncazG19VpLF10obNLMTOWheW3ruQCFI1KnbiQxi8j1jP2+JNv55t6ynorbkGaCSUC7ab7mmf9MvDgoL5sXnFOwporiYk1b8JX3cSKbXRmUf2WEP6cnN/FQqvRpMw/081nDMufG311VETcDJN2mzU4G9jKyVzTWPDLjhHKp4Q444Rluanygt+m9sTfLZK3WH/LeGNz0Hx9suBtbmGUBiKkzgphYxfuMIaunBtzjZJGAQzFfNDj9t5kE5c1UogZPY3PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(1076003)(186003)(478600001)(6636002)(26005)(2906002)(336012)(36756003)(8676002)(6666004)(8936002)(47076005)(426003)(70206006)(86362001)(70586007)(82740400003)(7696005)(81166007)(5660300002)(356005)(83380400001)(2616005)(316002)(110136005)(4326008)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 11:51:01.4678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46dccb2-c0ba-4793-cbe0-08d8acb92e28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1317
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When GFXOFF is enabled and GPU is idle, driver will fail to access some
registers. Therefore disable GFXOFF before unload device.

amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
amdgpu: cp queue pipe 4 queue 0 preemption failed
amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2
amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
amdgpu 0000:03:00.0: amdgpu: failed to write reg 2890 wait reg 28a2
amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I42431f5d0bf54909e1df888a0d72fc009d8e196c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e365c4fdcfe3..47d1291d5053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -83,6 +83,8 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev == NULL)
 		return;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	amdgpu_unregister_gpu_instance(adev);
 
 	if (adev->rmmio == NULL)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
