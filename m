Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FAC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9614A20663
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fVvJN0Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9614A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889AC6E434;
	Wed, 29 Jul 2020 02:56:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AA16E434
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhLaIiOqP3l1v39LWB9+fyuRS85At8v4LftiH4dly+UnocKG1YJIxE6bPQU1OzJAkFFNvyk+K0CkzhnCPXDSBYMbpue3BqGTjqMzvKv50tQPoiPEE7Iudz0vGfBu+Fx0AMTMHAcZO39SZt0K95gMOf6OiZicbD51QcJfb3CM/jDSdThyr0s/kP49C42R34DHGmz8+Fk/kJh7qVY+oF2ew7gdYGqrxIDdCnouDha7xXCBOi+zqqwlJ6gCVjmSvYUwkxk4TPNl7j8u+wxuBZyzEqvzm5WyWSKDNhC0KzCPOxEHgsdq4qlgHZ5qbaaKLssvZxMButHMPW5nsIzHRDcpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0a0VlcHewAV3ianBPmO2ZUNo3iJMGhIKa28d4B1A8=;
 b=ANDg45zMHCjDO8IGkUfzvQ3uB8v8Ovx4Fj9W6/qyKH/xsQIqTtM9uyLOci5UcH3G/yweKjk3adQRw4LGJOLaasC2tVb8p7lc8ScJm8LUgAgSfHkzDPFZ56L3QoSNVf7N0DSivoHzkEWqVx2cAjJSZN2gvAoCD9YAF0nYdQdX2uUccMbY3wYlU+iccWYLxBwCIHr/MInhCnE0SI+Ag6JnwV1ciT3sbmLAssxTt9rRQMoe6EHnb3MGkYe8cIdBDf6Es+NLFmDYsup0KfYnhjGCeNc2PtwBXKc3FAgIKz9uJQDXiI0PB3968GgeMG7+C8xs2ERr48YwJVt6lW4PTPjpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0a0VlcHewAV3ianBPmO2ZUNo3iJMGhIKa28d4B1A8=;
 b=fVvJN0Z4TYs8M7zemIT2spy28coqA7UtKzVocfaAPTgv1QZSzCT5biWV6+1RG0LRKa79bip1K2qhrAByAv+VGfVOds2JtW7nst8b7vCN+xsZk3RsVX0pxws25nCPOY+HK8tZ87zZF93ZD0RHsaDfki3QlSyOMbG5X//0+Qq6SO0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:56:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:56:56 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 01/12] drm/amdgpu: add bad page count threshold in module
 parameter
Date: Wed, 29 Jul 2020 10:56:18 +0800
Message-Id: <20200729025629.19355-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:56:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d00d6207-3d2e-4906-2597-08d8336b0de4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB128502CC2AB432D427F1CDCFF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBDvPhtKxcroxuhdMBc2O00vL11VlTOs0au3RholUMnasyrN81zDMpGCaBMB0ugfxSiFQN7AawA/XFhHxANtSsfGDyrgwOzNsYhaV/51ZEu6Rw6fbmnAG5U9sqevuQtzTVRPvbi9e6G+iIdIA12bcDNz0CprtojU4H8IQj7PR2H5tGrW8eThdKQpWnkrjP+lkRF91dJ8pMRWGihB5XkPDLpsdGQB92Zd9hbLl7OGDFyGVLLLyE3crj4C+6TryX6+3M0eeDWMmwdKpv1t2dmNUnEc8X1Nx4gTwVcX7n3ZVn9kA2e37ll5HmXfdwfgbdO+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: poDhIuYRL924rshvWF9wY2tvwLypL8TrP0hVskTj++RNXeXhFJfwtp/KifvWtuW4+Q9Fky8+cATsvineBe+v3GF3ON72eGpmNh0s2GcYSRCWMZMK7OrRhxeoB6bwS1gEHdrx/c/MxgncpW/pkVibHlbk4sJxOhvqketZ7kROyi1SWzWuRpOkGNTZXgXg+z45STXguEYTUTqB0NS30AjpFxBR191XlyEyb8FLtGYEx+MrrRH+HJvvpKtDgnQxoWOSxrkN++NgYHQs8P0aIt7sV66Cr3l3hpgIrSCP1A+/GnptYDCrGhyfMk2EZyMbvJb0S+wmVa/6iFgbJX+aKRvXPHGzO3B0NwlLS2l3QgmNGynVtosb9fBOlCKa83vsq23097puZHZz3wHOWc06nfgJjtrmIIk4mgq60XhKH3bNAWKX6qNKGdIOU6YDKAk9y9BWnzuI3wC+oVjesNY3EQ+EI0BxjU/xG/IRh0aVM70vH6FaC+8wMZmpsXMPTLzEE6xW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d6207-3d2e-4906-2597-08d8336b0de4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:56:56.2587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6UbQDA372U1theiKFHZ86io9V2gEpSg+ls9ZCcijoFcooNqVmI8fzvJ/MRrkCxX9SUwyBsYzAtdTWjTD/+HCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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

bad_page_threshold could be configured to enable/disable the
associated bad page retirement feature in RAS.

When it's -1, ras will use typical bad page failure value to
handle bad page retirement.

When it's 0, disable bad page retirement, and no bad page
will be recorded and saved.

For other valid value, driver will use this manual value
as the threshold value of totoal bad pages.

v2: correct documentation of this parameter.
v3: remove confused statement in documentation.

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
index d28b95f721c4..820a28c9e957 100644
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
+ * Bad page threshold is to specify the threshold value of faulty pages
+ * detected by RAS ECC, that may result in GPU entering bad status if total
+ * faulty pages by ECC exceed threshold value and leave it for user's further
+ * check.
+ */
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default typical value), 0 = disable bad page retirement)");
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
