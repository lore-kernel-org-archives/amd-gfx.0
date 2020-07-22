Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5DC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D1D207CD
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zPYcdJST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D1D207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFC06E15F;
	Wed, 22 Jul 2020 03:14:47 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE566E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 03:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cirBhJVJlshNIfWCw1Z+/W4/t64Ukp7qiuKobPcTfuDE/EXN8yitlHnNeZvMN/YQzrU6xQmTYcLf3SdS2Vp5enRtcnNblyoi3gczf/IgcO2NiIy+IzOQL4fu+Nd+5cBZzccCGHTJDcrNTpbJt7ksE+nbdyEWRzHmcbp4WrmWrJ082SkjipmUwBX3bSkXsQd+ckBZwGE15lptl9xxeT+CmExNa4YzeYpBH2FB1zE2Gr55VmBd7qw6Z/Dot1PUr1Pz8vxJuU0El5dQ0pkjR8lPEFk17FNLeP2a/yqAD/XRQphEbuk1k01RHPowsYNFqc8AXsIaOPzQVvikzoCQB3FquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW+ateQnKeeWjjRu0o+wIcciBiqPFvpNR8JGQGUzOXY=;
 b=n2Zy+oP4h/eo37HURq55wojii4jTFFMA7WfwKlG8RA4NoRnid9qQryo0cTWi5pxTKLxFVw62xtnbcKaqVprRYTtdwwTg3M4uccN/eAIsvdc9Sw2NQSAxto6NVcY+2/7u4CuYHUDzFO08OskgComphdw2IZv1ocxHp9H+u+Ih8jt3Osa3Qo3z7xfSb15rfxqxhro/EQlxstqASSIZ3Mn11bRxWZr9AwgGamuhTv4lawgmZWkXLsfpX+GzGHuYvwJZ+B7ziRsOFgMfk2Uak3CPKUMzT9O0WRtbRcpE5peFaPJjZrUen7IfIE60aQk4IN+0I8gau84e20bhYhagYorbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW+ateQnKeeWjjRu0o+wIcciBiqPFvpNR8JGQGUzOXY=;
 b=zPYcdJST8eLsYxF1LgZwOr+iqkw5+CQObhSFu9pHo8v/uaVG+gTqkYTtXWFtCLDpim4ndHv5/k6GeQMywoZdvKfKNS5dT/BTLQPJuGroz1rVtJP1qVyBrz1xaj71qE3E++iyH9jmDZ3HgfWxaPET4OcpJ9K0yz+UKPQqYK43svk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 03:14:45 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.025; Wed, 22 Jul
 2020 03:14:45 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module
 parameter
Date: Wed, 22 Jul 2020 11:14:11 +0800
Message-Id: <20200722031415.4792-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722031415.4792-1-guchun.chen@amd.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 03:14:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23611ec5-2ca7-4dd3-c0af-08d82ded622f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1909DD5122A22D26BCB4CAADF1790@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwS6x/7TwLfA92fLYWC7A2DjvzB/rnoGiUBRT042p3z3Mr2sxw1uY7aiGIEY8E6U58iTwt9xCz72jFzv7OFQyRi/mHGGeu/6D9R/QvW+7GrdeigDTGnU3yfEliKU+qRgB4yLAl2XkvvOub3fcFAc7uptJiTrOvNcA3CVYnt1R1bcqu0IEB3ZI7YQRNAwOZgRAoMkVcVzOAjYapmL7JA0esELbBsfXhomVz6P8Q2Lh6TsLgp6MzPSxM23JRX5lSRRmlh+yrUf9arb7wDKHHHCp0uXYxBQvwf06EBy57h0bD6iJBV7mp+qqWmxwdwHcYB/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(36756003)(1076003)(52116002)(7696005)(2906002)(66946007)(8936002)(8676002)(6636002)(66556008)(66476007)(5660300002)(26005)(6666004)(6486002)(83380400001)(44832011)(2616005)(86362001)(956004)(186003)(498600001)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QP/NhryUtHPiSWSpW0pQyjznFi6opioNPk619w3Tk92J3ocC9s4Oxfpg8V4/r1PUQNstrzmCkLhX35btMe1GUuOwpg8M2RybaaKEHg/NdxwQP2SjjQFy/T6s6Wn13nzD3kBRcO9ik4KAf5ynlYdEF6WqOhGU3M6gAKRHKq+QVUsgf5RjZaOiLWTASK+O3u+YskbTVr9D0SYY2VGCkAJxltVoRrsN6LEEK0wRRxtZT65LqDALwz+R8r7cQ/usYZuZuR7WT//DIdvU6UHs9TtfcaO/+NFR5rkc9ymASVmabNTMejyLMvodMYjnhjmbbUkiu8lqDoHnQjaglTYIQzslcYc+nPiU2jBul46H9rIfxaYXpczrb7FLfc9gCzSIoiop4e9zcftk55E7AY783hydsgsn5GF7IX0HRBhhErna1Ds8sxanp+QCrWktPCOCBNrk2gak+SkzCi37oGejrlnKj6etJot7xJ0MgCHGki6z8duM+bnKa88p9xb8R4Fz34cF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23611ec5-2ca7-4dd3-c0af-08d82ded622f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 03:14:45.3189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBj8fZtUSwkYe9ZGMHWIwTt4Hyh2F6efKJiJ3irXBKsEP1TnBc1WeVaTrHiCDPKHmuI7E86UdKv5sBAXyt+H0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

bad_page_threshold could be specified to detect and retire
bad GPU if faulty bad pages exceed it.

When it's -1, ras will use typical bad page failure value.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 06bfb8658dec..bb83ffb5e26a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -181,6 +181,7 @@ extern uint amdgpu_dm_abm_level;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
+extern int amdgpu_bad_page_threshold;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d28b95f721c4..f99671101746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -161,6 +161,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 };
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
+int amdgpu_bad_page_threshold = -1;
 
 /**
  * DOC: vramlimit (int)
@@ -801,6 +802,16 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+/**
+ * DOC: bad_page_threshold (int)
+ * Bad page threshold configuration is driven by RMA(Return Merchandise
+ * Authorization) policy, which is to specify the threshold value of faulty
+ * pages detected by ECC, which may result in GPU's retirement if total
+ * faulty pages by ECC exceed threshold value.
+ */
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default typical value))");
+module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
