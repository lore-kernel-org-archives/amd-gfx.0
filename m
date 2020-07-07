Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BAEC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 13:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B9A2075B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 13:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ylc70Foe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BC48813A;
	Tue,  7 Jul 2020 13:15:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00AA8813A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 13:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiApfbScMk/Ki7DSaxOepOnrLY1ckmGT1DHNtJLiZjojBwBtlqLFrE8DS/FX1VAttGDnlPrKnDBBXf0MQuoH7aTW3KhemG536Jy8ecWQ5eQ7JF8z86EMuhOVjhvfYjkemJxzQS/lIbu3K+JYkVwVySFQCMtn7az7sEiEcm3RK0TNvFkTxFoskF1l976UBiWlA3zsGg7O1+b3wsD3hD5D1o7WUCtMnynfdUlZOD2AA0t1Kp6YNylgfCXonpMyY9jFd/gy7cPoO1sypmE7S9bzaZfPLDH1mEvZKhp2T74TvPQRoTlK+znVyS3mHiKqK/dF2nzkBJ6jz6LNy1EN6j4A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFz6/TvSdM2pekrvxCwVYTxVStew+r3yoT46VRrDJww=;
 b=gDsfg4Ly9+ABOLeiBkessM31CWK8I0ht5OJ9sEv3O3fzNiQYL5RJWV1SjrWMY0bvCC+o6yjHKv1YC96l0KS337Ovy/vpedg4Q19ToaDd7rcqZ05eFr+Tmk+qoUJY9e0xiolG1tNhRYzttT//h+7mrykVYW1jyhMhz85IZPAwR7sKiJX95Kq/UEXiTaAMPIJz31ubbMGEVeZbibxmCY56lVMWJA/2naZsNem8nYLHbKwlqxTGdeMWoQtA17q0bmRgNGniXe4WprM/wnOzxdSECNDJcchTqwTgdvI09cctKC2o3JFUNf3Fja76CYgqEPa8DOk4eImwqnArmBdQGI5Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFz6/TvSdM2pekrvxCwVYTxVStew+r3yoT46VRrDJww=;
 b=ylc70FoeGcNZyGN2ZWJr4DpuxULKUwVq2uvSqiGfLjo5SBAZz1SzWd6gmttES8+2wvgypZytShIo1kb3WhSsaPjcbxfiTXUdlmAzVykVmu2nElvKXY49vBdFL8RGBQ0GI3G9jpoiAuhGVmiAsSMX/SmF1FGXEoCgVO4G5Z5mnW0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 13:15:20 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 13:15:20 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] tests/amdgpu: set emit fence flag for multi fence
Date: Tue,  7 Jul 2020 21:15:04 +0800
Message-Id: <20200707131504.2994506-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.15 via Frontend Transport; Tue, 7 Jul 2020 13:15:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 658ee1ff-81bb-48bf-2ec0-08d82277cc64
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24597C72175B771081039DFAEF660@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXhLIclNM8Ona0xltV19s113eWSOWqzoV5VZnH/SUrHMyIQQdg2TPRIfGtc/ATOB4rtryotmS9J/j+bN4O0fkVpbKgkF3n3GwnOyT43VxnP/jDhcDrnivyK9y0V1i2HA7H7CabDgr8ajcDSR0ZxAqe1R4+9b+B2ey/uvOFBTW37YTMxpCkXtOSiJpEO+6UsvMQjZ9T/2vr6a8JTrvGpIefONARmOq2AeuaZIiUr5YhB8uquqdnGaXIpGaebrOCK7302jQ3iKa1BxH2zTGLEJIas3ptF4es5PGO0BJnv6dxEwpMZCHBpyRn7fy62K6ap0+vzNjHn4bcwLdbkLXOKzRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(6916009)(5660300002)(8676002)(6666004)(7696005)(16526019)(186003)(44832011)(52116002)(36756003)(4326008)(316002)(66556008)(86362001)(6486002)(54906003)(26005)(66476007)(66946007)(2616005)(8936002)(956004)(2906002)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 00XvXoXkX8eJq/0VwyWxfbcG4vVuQW0LRwGUJtPkzpaWd8CcK00y/dHjdbX2XgqXz3TSz6h2DG3K/YzNtEF+3dvLxup8F3hgpg/c4dhEheLneVnsWrsS4kFGMGFqWpnNc6JcxHS5IzmLIIGEGqMP7OA/YK8CtBw+WIiaSKgtH0pVY/ibFDVfx1Un1VuddZEz3u2m0M07ld+lEBDDmhjZMC3A+Xb8prwnVRQ3yJ/rNqVRsfvpOnWXWLJfFMZBBX05crJmKeT6ksD8S+8c8dpJDl1NH8Lu7BJ4E/opwyr7d3cNerB3KlkQEZjEBbqcB5KP9YSz2aoeSLiZB8JE6Ea0TKOO7d5wCodm8Ol100SGEltH3AVjB3KoJJMraSOpMYwb28d5nnZKZLGGXkuJxtUwS3n0LQjM91Z+yrZ5mhFN7RRbTh8xdZUbGDc9yRAMGWMfqiS+LTzzGeWqHnT38QrXngE6zms4q7cMP9Fg8t7Rhs2i5222os9hotdbMYx73GOv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658ee1ff-81bb-48bf-2ec0-08d82277cc64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 13:15:20.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l29M916/WilSxs8EwjeDDxdAlTuO4HwWrLDXuSV4S2j+EVmcL1MfqqynC/QpVOQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Set AMDGPU_IB_FLAG_EMIT_MEM_SYNC flag for specific ASIC when test multi
fence.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I41e5cb19d9ca72c1d396cc28d1b54c31773fe4d5
---
 include/drm/amdgpu_drm.h   | 2 ++
 tests/amdgpu/basic_tests.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index 4fe35d60..8a4d7da9 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -586,6 +586,8 @@ union drm_amdgpu_cs {
  */
 #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
 
+#define AMDGPU_IB_FLAG_EMIT_MEM_SYNC  (1 << 6)
+
 struct drm_amdgpu_cs_chunk_ib {
 	__u32 _pad;
 	/** AMDGPU_IB_FLAG_* */
diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c
index 57496c82..c0f7ec33 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -45,6 +45,8 @@ static  amdgpu_device_handle device_handle;
 static  uint32_t  major_version;
 static  uint32_t  minor_version;
 static  uint32_t  family_id;
+static  uint32_t  chip_rev;
+static  uint32_t  chip_id;
 
 static void amdgpu_query_info_test(void);
 static void amdgpu_command_submission_gfx(void);
@@ -607,6 +609,8 @@ int suite_basic_tests_init(void)
 		return CUE_SINIT_FAILED;
 
 	family_id = gpu_info.family_id;
+	chip_rev = gpu_info.chip_rev;
+	chip_id = gpu_info.chip_external_rev;
 
 	return CUE_SUCCESS;
 }
@@ -1769,6 +1773,8 @@ static void amdgpu_command_submission_multi_fence_wait_all(bool wait_all)
 	ib_info[0].ib_mc_address = ib_result_ce_mc_address;
 	ib_info[0].size = i;
 	ib_info[0].flags = AMDGPU_IB_FLAG_CE;
+	if (chip_id == (chip_rev + 0x28))
+		ib_info[0].flags |= AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
 
 	/* IT_WAIT_ON_CE_COUNTER */
 	ptr = ib_result_cpu;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
