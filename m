Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F3C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3364247A8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MX7biw0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3364247A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C205F6E580;
	Wed, 28 Oct 2020 14:55:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEDE6E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 14:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx+ucjQJuiJlqXhTIQQGmbO1jdvcrHFqEOwu+nLeczBXhJUj+r5TxEw9aze9AjA7vLKp5huE2zPJYnmesOPXgqCTeT84TyPs2dh5rYewPcK+4snPYXtlvMmbpdRCb/FDnUD0JHJMlDdjaWixMqPEekK77bxdfrkDhYAJuMBuGWVUPqSqbzGjUZwqGqNKZdd30XeH+xGVjiAHLEUQvBu/YGnr4flDicvOr45A4Q5tba81j4er+wk1xBxdSKIMf3fmJgtq1G7PfegbQR28dIDwgkBO9pa/3wOKecEhN3Z/4UEINeGRiLoXq0U7Lg/1riBkCTLjagCTpjpoRr4II6jRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0BCswyv9wgqbarPE6ecj8frsQaEbFieqYIFeQjRk70=;
 b=VxOMJFO2LsSbuYTz5DWPWQIvE+WRD3B9CKEnndnWa98lXLc65QzMmMPN6yS1xvvmqlAY+l/fwe0G00CJ5YJGzf0i7UW+CifVvJehWARehZkac9uaOkH24YyjFU5AMobQHX1ykDzUqqW6k1pvg9QLLLrs0Y+OlesRkpCk4u5Py/J/g6Q3uYF4PnGVvpHtUoPIlYDfVUPwUJaPKYJvYpvBYpd3R/fblKUoRQouzjrM7WYmu9Ti5jDbS7UtlbP2ZEAUTYSJXOCzKeOy1t7W2HhDquxjG7IcEi5Z3jmSKflt/EqQthzT7o/X01Wig4XLy0fbjWijcvnUKQRjuRMWqNZ2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0BCswyv9wgqbarPE6ecj8frsQaEbFieqYIFeQjRk70=;
 b=MX7biw0K9u0fzGygai49v3UU9C7yfbcfVtPRUs6lYl2C+b/fHGcSxqZGoB4+F+Rg4GigOSDDi0PZHA7LZF+pXRZiUSbFsKpn/RF3cTW1fpMP3VHxpr6mKTqIR9BM/S48gl8CBZTbuyd/WtkVSipYsWDwv7KvmUT0pRBSqZYk9Ak=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 14:55:30 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3499.019; Wed, 28 Oct 2020
 14:55:30 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Date: Wed, 28 Oct 2020 09:55:02 -0500
Message-Id: <20201028145502.2703-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR07CA0158.namprd07.prod.outlook.com
 (2603:10b6:3:ee::24) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR07CA0158.namprd07.prod.outlook.com (2603:10b6:3:ee::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 14:55:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c8bca9c-8c7b-48ce-f28d-08d87b51833b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24487C3B8CD1DCCF1C58919FFD170@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcVco2b0Z6eC+qCkBsc58F+jy6dCwe0zvVE/oIn0oH0jV6GPhVVPa+TykBGLQQnzyWepkqmglwdXqJClVSXdnTP6grQEc9ClnyXCQKsF0n5p4gayieDmo0jOMa5J9FtZdIJjwomUUMXybbi202L8gOsBMfIJQxSlGxFUrqDn0EYAo5tT7MSGzZGwgg/HhiyvsVpN/8MwFCyXUlN3jwvrtLzzaySdksd1lVq5YLn3ik2ffet0Ym2R2vMnLKCrQ4z6CbuF9L7zAufzJax4bRoKQ2UWOaSixd3t9u3QbCTe3fykqtphyZkohkE2lGb5CX0hwZpdy0kkv8f7+X2Njv6ibw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(6666004)(26005)(66556008)(44832011)(66476007)(66946007)(16526019)(52116002)(186003)(83380400001)(6486002)(7696005)(8676002)(4326008)(956004)(6916009)(5660300002)(86362001)(2616005)(316002)(36756003)(478600001)(2906002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IT4sVmqVSBLYXEwHeET3uWbYattjtZ2/P1BVLzxiv60PCLD4yoYZPj0NWiZKg3g6XYpTernXPbKncYnRQP8TPfCa8cOw9pi10WObpDowe5c8NSBBVXjKO6Jq10FqawIHrmUUAZEudZfe964Qya5ryuZ4D7KzrXpx2tT7+Jjrv+HQAClRJRewbtKwXUuqMbhgdpgj34wqE9OOiBnkVnibJ4GW9TEK6ycWYd9zbo2jLt8yvD7MDyutn8OpqSv6RG8m68B7RvkNZy/3aJs7JkHgrsXktM1EN0UQyUUJr7vFe69V8wweyXYQ9ctva+ctpLse7k1wREUsSs766W/nDoImbcvRts2Gu66O1g5KTsEEfLj7JsibW9pqvW2oDardMjnefSJzPOOzOA0F0ar37gIwBfyu0Wfvx+1sJi11x2czkRiiyF8+FKULaTF4vcBuj/UXXtc0dV5YXp7q5/r73qUgpWLisl8t5MEqL3tvNPmx4CvOl51UTeIkChCEifp7y2yT1yAFpZKOUVsuRFju94IvyZJtFqGmDYTSnu6i4ARTa7cpMZ3mTsSLUUhWwQnGFkzGp9miRUia7TkDKfuCRnjTHjhY2wtvWC9YWDvX2efZ5L3Ag/h4auI8Yh1iklymWOT/Vvh1rY2IlEDYntcPof/sqg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8bca9c-8c7b-48ce-f28d-08d87b51833b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 14:55:29.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipdovuDwwdA/ChldnMWhmlXZAmrhnu5nEja+kGDcpbBAEem2+GZDLFOYz0sx+vgbrclNKBTWQ1IYiiH7F8BjRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By enabling this parameter, the system will be forced to use pcie
interface only for p2p transactions.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ba65d4f2ab67..3645f00e9f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -188,6 +188,7 @@ extern int amdgpu_discovery;
 extern int amdgpu_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
+extern int amdgpu_force_no_xgmi;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fe850e0a94d..0a5d97a84017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2257,7 +2257,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1)
+	if (!amdgpu_force_no_xgmi && adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
 	amdgpu_amdkfd_device_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4b78ecfd35f7..22485067cf31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
+int amdgpu_force_no_xgmi = 0;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -522,6 +523,14 @@ module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
 MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1");
 module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
 
+/**
+ * DOC: force_no_xgmi (uint)
+ * Forces not to use xgmi interface (0 = disable, 1 = enable).
+ * Default is 0 (disabled).
+ */
+MODULE_PARM_DESC(force_no_xgmi, "Force not to use xgmi interface");
+module_param_named(force_no_xgmi, amdgpu_force_no_xgmi, int, 0600);
+
 /**
  * DOC: si_support (int)
  * Set SI support driver. This parameter works after set config CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
