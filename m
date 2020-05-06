Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8066DC47259
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0A520659
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z876XpXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0A520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CF4897BB;
	Wed,  6 May 2020 06:23:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46AE897BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihfM3Xn7ANMUq5re5QxAITWMsVeu6Gk+NTY9nfxWldsXM4co/mG70cYl25MtjKnOiVPfmwYERGiMljyGamIADrxkF75Oy71yRMZgthJMMv+c0uVSgvGxiFTwzL2ySynxbTVp5Hmjew5An73hYc3pF3pRiNHq6tAWFP+3EGsWZBafJ8qNOK74BWJdKs3KEYZbbseL6grrB5bxUXpEtmIG9bqVk1AU5P1l87uvgxfAnQagkwUd7AKOYYATjFbvgJNPsS/xDbJS2Y1NReNrdwFKwB+jPFhmJ/nqurY2xulwKxDxKhWV/kOjoBHVwYH+nJicR2zG5w5NE9d0UC4MFxhUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY5JIGwzjAG3bemVLqj4/1BidlWxk3OH/Tcnx6ASG6k=;
 b=ZeFMMXGRGIbWgvq6c0bl5l8LDLjFUB27SaB/Epe9SGK/LMkrbDpno5wBZmyu94sXKJ+VJZ1IoSjmhaVLVxKlRBzPv206oLBnPUUZClxUaLBuJE7dWO+vC2yEvauhztKF9pHmW5q2GUaszt1jvroaXnaGKc2ybRJYW3p8nYrwr41wrtKI2xvYa1mLYQ0c9iKNBodqahjM6SDJJUoirORl3bnslU8YlGc1c8LSLs1oNl7nkODHCxiuWooCGaAPATb2FyooxYz30IKmCoj+R1AQsaw/FQFHEQ2f6pnNjyC77Y5mX5XS/9fZqWYE7ieZbVfQevYPgOaPiZE0sU9NdfmGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY5JIGwzjAG3bemVLqj4/1BidlWxk3OH/Tcnx6ASG6k=;
 b=z876XpXEnpeWAwH3E3LTaQUaDi89G9HYG7xfas6WL0o6yuHr6H7n2FNPTgQ0Z25KtjsEOJ6zzeSzhimk57i6uOJ9T83UVe87a1iebffEArWdnuEWBFkFOMuSLAZIIF5R3PCjTW2cDNCm2CxOVMJvyUjGyzpJne28EbhK668oj4I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 06:23:35 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:23:35 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add amdgpu_virt_get_vf_mode helper function
Date: Wed,  6 May 2020 14:23:12 +0800
Message-Id: <20200506062314.16040-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Wed, 6 May 2020 06:23:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fada967f-02e9-4053-d4d0-08d7f18601d4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4164:|BY5PR12MB4164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB41642CCFF1EC1A354CC331D4A2A40@BY5PR12MB4164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGmXGq/q5QPasNtciDVzrI3uQtuFLPVQOldCm+aGHwla6HTu0n1mkU4ApOagJSvQ2QCyLCeToga17hpwDLqBdAGaiq96yKWzLlQ7PKqKLmt5eurViCH7Bwgk7aX2ZLfFm6/NC5J6YD9a+ISnZEyA0ZQ+smu+hWXETABTHfWqJ7UzanDrcR67kmnVMkWGnzaagJlsQmDNipUGsX0083sd85gFoJloYjgjFty44bktQ42hAp4LlDDPvx6OBoTbJmZzCiAEYj4Su9xlBiOd87UpQ3MVJEH3iWCKknkP6vixFUq7oPrzAUrmBH+jnGXdH3OD98h6vlPbvM9qR7RTqoDP0V+gZoqavJBwMiy7eL/oSfldvy4gn3GiTbQRz2cpQrFxgCYqX8F+yJnGOtL6GmxNM9IzS0H663qhI6mWyrTHZzWKGGCJEGUMYhmyFYK7uy1f2t3fKqbc6k+9uUxAfZ8vh03psP2F7LHJ0Sw0+IIbVg3DNWgKPgxhKZKLDD2d3TdnjXkUB2KoFbjOr+exyWD82A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(33430700001)(956004)(33440700001)(7696005)(4326008)(2616005)(52116002)(36756003)(5660300002)(86362001)(478600001)(316002)(6666004)(186003)(6486002)(66556008)(66946007)(2906002)(66476007)(26005)(16526019)(8676002)(1076003)(6916009)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ph47rm7WXfv0ONrjSWaoWMIlMinwoyMJli0vUTCL2HX3+SrDH0OEZwUEeD1c0BCh3RLRRfS0BRWo1BkqKZfKPTBRxXEM8R+qWNPkTZ0On9H817ju6XA7kbx8yNlQH8zyn+bS8ZMGdBGU5pduZv72YvzPOSz5OP4ffjt2VEVjkklnL+OknELbuzPjIx96V0TqnQEGZ65YQ7K9xy80P36Fn59YRk/HDFmwxftuSuMKrbKugKkOT+aDdCtZ2R6+LL/3nJKmDPJ51r+x6BDp0Wpaf5uWN5tehNsdBRy7IXHHlb7O6h7wcDLRy5pffW4ISYHLb8aEmi4yqZaps31pDqJITfjhE0oBMl03T0Jjhu1H9zB+D74GlcdNUwWQ7m2rT5Xh5bweV9DRN7w93GrKRPF7cmS7387CuRQPt4PWArRy+Qc93EMxJgGrmWIS9dN3Ym5irP3ReD3/CSchTqyLmtzcM+QPD4Oc2fjHS3rT6gurz7jsM+Neh+SqG0eBJzQ0A2Zmu6Qr2Yrt6+rPHVgbkot1oK/g7kz9kpiBAwScB1xW1nBo+paMrhM7C39NsucHloLks9hrgy6/6AoyrZC0yHVu5VqT1EWVCIeE1/1zxbVuzFGx4h8CJDN+3JqwqTO71sT5kDfX8Qd/iI9uK//h6Q5cGbdTtuwMCUz7RKG/Fs7dbSxHkCniwbaSsubIA1w7PMdTzIR6atdXFHs/Omoo5dTrSY9nDnBNOjMiAcoVyUYUtQRZ/tEoF+AX01/gAQm9IYU4kYcNrsB0fXqj8/28nNiQSIfduRUqKtBGT5Udu6HRhMs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fada967f-02e9-4053-d4d0-08d7f18601d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:23:35.7490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt/SYzmk1kvn1pf6S+bzFJzLWqef0QKdm1+w7kYLyVB5pdC9VqneruFnnkuMdXHP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 kenneth.feng@amd.com, monk.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the swsmu or powerplay(hwmgr) need to handle task according to different VF mode,
this function to help query vf mode.

vf mode:
1. SRIOV_VF_MODE_BARE_METAL: the driver work on host  OS (PF)
2. SRIOV_VF_MODE_ONE_VF    : the driver work on guest OS with one VF
3. SRIOV_VF_MODE_MULTI_VF  : the driver work on guest OS with multi VF

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index cbbb8d02535a..f3b38c9e04ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -370,3 +370,19 @@ void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		adev->virt.caps |= AMDGPU_SRIOV_CAPS_RUNTIME;
 }
+
+enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *adev)
+{
+	enum amdgpu_sriov_vf_mode mode;
+
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_is_pp_one_vf(adev))
+			mode = SRIOV_VF_MODE_ONE_VF;
+		else
+			mode = SRIOV_VF_MODE_MULTI_VF;
+	} else {
+		mode = SRIOV_VF_MODE_BARE_METAL;
+	}
+
+	return mode;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index de27308802c9..b90e822cebd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -35,6 +35,12 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+enum amdgpu_sriov_vf_mode {
+	SRIOV_VF_MODE_BARE_METAL = 0,
+	SRIOV_VF_MODE_ONE_VF,
+	SRIOV_VF_MODE_MULTI_VF,
+};
+
 struct amdgpu_mm_table {
 	struct amdgpu_bo	*bo;
 	uint32_t		*cpu_addr;
@@ -323,4 +329,6 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
+
+enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *adev);
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
