Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE1C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BBE2075D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dt12qDRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BBE2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2026E200;
	Mon, 13 Jul 2020 06:00:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE906E200
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 06:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/+AuFUFPtVoU+NHlwUuA5QQW1946eqEGAMz5VbeFVeUUzAWqYjWU1Wjv4pQWM4WsUnID++WVQ2CQaKmGeMh4htpsz0C+l47FILxenj8knqC+WNhujKwJUP8gUrWparsogJBPSHmvsO2s9oMS9DO530SBLaczL2SrK8scbvJSIgLSPxNG0CdK6wo8c+myt6qX4V2dxsj39s9J+sw5Z5t4ycl3zyAHh2I6ycSq5l9efe/F77nwtEGtRzt2cvtZ8KHtEJXSvqbOJ5WQ5sF+WQo2HHBkvZ3DuWCRJNUU7khoFABD3DyzTA7diiO8IJHCQBOZEdkVedIaXj1+sPgmeI06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN94RmoDEZNixHnBZfhhjaUytCtY+mFveVG5ogGRwPg=;
 b=WqButFPtFpEfFTNDpis6l0kPuMU6FTMVb3YCsvYpX/xwagFskrPpmn+tlvdfTvG7a04CfWEhIysjGrpWc1cNzYc345hw2HyMp02O86fafrmq2asr43Osg4n5rmOfTbm8gG3O/N5DmJAfZr/yGa0t0tqt0q7ekgRYuthbg0ADpKDJm5hZQ47buBF3stR7H3qoy+bPwT6d4U1mFkrwePldzWmWnPDFVGjDvpOEvmUTQE0pOjFj1mISKa+3WRq/+p2jcDWxc79eeGi7InmS+VNMSYSHHUX3aY7HCp33RQ2wwppOX+ZJQ1c7+dn+8UGjjhonHx4sHfPFIk8S5Nw2rvdZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN94RmoDEZNixHnBZfhhjaUytCtY+mFveVG5ogGRwPg=;
 b=dt12qDRFgIH/DB/fIQYnp2Wb6aWq4qAHILSOaApkinTIlyM+gcMBYr9qDMsK8cIMKuDmMK7dlFsl+xhOQ0ouQakrF0CSeC97QaeAHZumNE5r30wsN3/CuHy7eLk/DBjklpMt70bGIOoh4yE3wBLsPBQH/boE18fyZKfi0s29pXY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MWHPR12MB1438.namprd12.prod.outlook.com (2603:10b6:300:14::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 06:00:15 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:00:15 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
Date: Mon, 13 Jul 2020 13:59:50 +0800
Message-Id: <20200713055950.19611-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (112.64.60.245) by
 HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 06:00:13 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [112.64.60.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74efb75d-c675-4f53-0147-08d826f20322
X-MS-TrafficTypeDiagnostic: MWHPR12MB1438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14381A74CC8FCB855B283DEA89600@MWHPR12MB1438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7bM/En9pO/RrrQth6CPdC4rM8JPTO2LWrEv4mutGPy47v+CSdLT5GO0EhB6QaeIEAt2r0FnYAeIje5VUkJb6q78Qc60f2ixfsxeSfFCHGDNB1quppB7BupHMuAuliQjMbiy4iGTZ8dj3GVUcso+piayVQGObcD1egHIQr1ExtcG6X4cH8bvh6KkV8C9dghJJPdX29UPp1qbuDty7oBGHldaF/gMv0kMX+rGV+UCpOJ1m4HzDvwrjKELtCcY7SR3ohdzIl2zVaHzphy5lVAhOnY7uLicyYcjmJR9VUXsQGhIud0S4khBEZ6LuKAvGcB9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(66946007)(52116002)(7696005)(478600001)(26005)(66556008)(66476007)(44832011)(83380400001)(4326008)(1076003)(2906002)(6916009)(316002)(2616005)(8936002)(6666004)(36756003)(5660300002)(6486002)(956004)(86362001)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 83QUtdQcNQSLVDz3OM0keni0edMMAqdZKY/SpE/WAUCFjM0Jb+gdgd4V4+9JUDmSG4OYCbvV416RYIx/pqAjy08e5ciJA0q1BUJxLUVbzUQrPyR1UhAe8/Z4jJXCJrzxykExUer0wBM/xNV1cMoP4YIhrvByvo7BPBj5DM9nZ2jV6JrVtA55MZR6r2TCvHquSI3cQ2cmot3A8ZqIzRsxUjEi9oy+Z2Qzmg7XIvvrAFRgxwMfg5mxByHG0VE3TKRWfbPn/ae5Btp+pqjp3O2Q8SFKbTCDZJrypV7Er0KDc1yDPEFJbihg8GroLG51PPU0QceIXThuU7n/JtvBWEynR+SdBR3Gn2icC1p2ZlaPCmJMbVgvsW04fNrXLKWqeICLDI/OwN0AhU+tJ0hxTmoY8l5eAD8GD88FSvjHaKIC0ugbsPXv5a96+p+7Mu7hDPM4ujCh8jtXOxofYtcszWWWXiecPwMqwyHEPps5OZaNG50=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74efb75d-c675-4f53-0147-08d826f20322
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 06:00:15.3074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv9gK1ZUqn+n5ohRk0YyO8JCWYJFNH3cowwxRoubfV7sQT6P1vuFSxtDnubErWXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1438
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

to easily add new debugfs file w/o changing the hardcoded list count.

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b8ce43c28116..58d4c219178a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -781,8 +781,10 @@ int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	if (amdgpu_sriov_vf(adev))
-		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov, 1);
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list, 2);
+		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
+						ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
+	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
+					ARRAY_SIZE(amdgpu_debugfs_fence_list));
 #else
 	return 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 77d988a0033f..8c64d8d6cb82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -928,7 +928,8 @@ static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
 int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list, 1);
+	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
+					ARRAY_SIZE(amdgpu_debugfs_gem_list));
 #endif
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4ffc32b78745..dcd492170598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -468,7 +468,8 @@ static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
 int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list, 1);
+	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
+					ARRAY_SIZE(amdgpu_debugfs_sa_list));
 #else
 	return 0;
 #endif
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
