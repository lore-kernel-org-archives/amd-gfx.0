Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD8BC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 07:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E1F206DB
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3/2Nmiig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E1F206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F216E8BA;
	Wed, 12 Feb 2020 07:25:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EE46E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 07:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6AuXSmXFO/wTncRA4eiZRtgxjziTNtv19/ZhqO9oJGRlTQKaRKritK4tqjbrlC0CtbVNnzJ7aGzZGBAGENRTv+4rCBQ9qIc7yyw+iEyuRzpwIpUT+M4IYooPshLtu+kBli1qu70cFSlnO4n/s7UBOu0fPHa5TJjRmSRSr43Ox87XE2qU54X7X2SjsQCQcYSSacZdXyai3ZVyDBqC2LfCBawYVbJVK/TzdkUVJ0cBpWoy/SNb5nDTXctZi5OZ3HIhB8/i+ZWZ/aPsNWC6v2Ug3LKv4zzvsOuq14BsLazU3/O/GNgEKv4SvoYhUTIOt08KtZI1pt+6L5dt5p6bWdMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNjbcuklBk8yoCumJy3AQWJi0mJF3wR8cslincpu3DI=;
 b=IGo7RfUM+RAvnh1Cdy08jC2+Lmik+61UpQJFBx3KIPviFEMM4FRDYjsPqqogOAjb6FLll3ZsoQ+CEIVRZ6aEyDqbafxky+zXh0nvJGpYuXnYBzCNjyik7ufGs2Io5kqvbGEkOL4o+ou3D3L3XHIswHHEo0upXo5KF/ZsN2mUVRTL/22BIw5gyqRkAZhOIdRtpdnxELElEm4XOW1aZJ/WjE7O1UWDSEy0s0sl+s0oojtc432CNQEMZxvjqV7vZTWTnkdBV9aL//BK3p34KpFE5vvSe4ROtNaP6BoQsjgXle/NdhCNq4NSwp/cX4lb5tc2NfuTiNllaZ/Fm2CCuVGMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNjbcuklBk8yoCumJy3AQWJi0mJF3wR8cslincpu3DI=;
 b=3/2NmiigJsIoFirstf0GYPqa8hpF3ULaEBK+15zrSO/kQCEhgXn0BhVaf3r3C/WUugWhIpDPh1Sq6Cm10ct0lw4WG64Iu0SeLKlSKLfKoqZRC7nl1pIcqCY1wgbmvTZoBj8RlTPBk4gcC40xvrQb33Yy6bY+/HI7dsc70q7kihc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from BN8PR12MB3329.namprd12.prod.outlook.com (20.178.208.93) by
 BN8PR12MB3588.namprd12.prod.outlook.com (20.178.210.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 07:25:08 +0000
Received: from BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::1cbf:1b1e:ad9c:c83b]) by BN8PR12MB3329.namprd12.prod.outlook.com
 ([fe80::1cbf:1b1e:ad9c:c83b%4]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 07:25:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct the way for checking
 SMU_FEATURE_BACO_BIT support
Date: Wed, 12 Feb 2020 15:24:47 +0800
Message-Id: <20200212072447.16743-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To BN8PR12MB3329.namprd12.prod.outlook.com
 (2603:10b6:408:61::29)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.30 via Frontend Transport; Wed, 12 Feb 2020 07:25:06 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4a4c428-ca0a-46b4-6b53-08d7af8caff2
X-MS-TrafficTypeDiagnostic: BN8PR12MB3588:|BN8PR12MB3588:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB35887A9891C980089ECACC9AE41B0@BN8PR12MB3588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(478600001)(6486002)(66946007)(6666004)(66476007)(26005)(66556008)(4326008)(44832011)(2616005)(956004)(316002)(2906002)(36756003)(186003)(16526019)(8676002)(6916009)(86362001)(7696005)(81166006)(8936002)(81156014)(5660300002)(1076003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3588;
 H:BN8PR12MB3329.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7d3K1ZmTwOEdDWYxKBkXpDouuqZ4qesRZqWCpyFVVkPlskMUmug/GkmrmhA1ccfomtK0CKGIHmcqONgM3kBN9WLEDLGtUBoMagzt/j8DFRB2xAB9FrxnavHULTA3WMDux9fZiuWhvbATk6CLElBnDe+pJEopdsYqxC0C8szalUNhAwEGDwrhSb75Vz4p7myL6ZiZ7eC6IrEm0bYutD03+VXRCS6cyMPJH4pIjFJT4Y1oHeXlka5ZMclK3KFV5iFLUAN/R3695oMj0HVNZ9HmMRrhyJSMDI0tMM++AITpRsi2LCQEWTBUBOqXrk3QQeQ9f7YAjGmp0UiSFRlkAsEK6lap+MEgH5mAvYR7TxYh5fHKWBxepEJIc2tTpVW4q31dAvButbRqrhhyoVxc8A/MDCAMAQaAJ/gikQ6f06floblJUtNuv0bWKXuLTizFuXj
X-MS-Exchange-AntiSpam-MessageData: 5RK/eVubYJ6xcbzC1tvavAYuQ6kxN6hqTkVAv9xPCYXfPG3Ap2BgBb3bQzvtis/HLsqrxhMCeuY26EVXy2wsswbWUwGvRwXx5vjjT7wQVC42hHRUY5J8Ygu2Y6T12Qw+ToJr2ZGQboK0rcqMQUW06g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a4c428-ca0a-46b4-6b53-08d7af8caff2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 07:25:08.1295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdyfPQoiBfUqb20MvZ8gOTqr3JUspGbMZB1JJei5x0Dhy3QmGgJW1oYYJ8MmlpE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3588
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

Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will always return
false considering the 'smu_system_features_control(smu, false)' disabled
all SMU features.

Change-Id: I73956ffa51d6da8375c7c377895a221e13d31594
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 7c84d48c19e6..6d4c99b016f9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1489,7 +1489,18 @@ static int smu_disable_dpm(struct smu_context *smu)
 
 	/* For baco, need to leave BACO feature enabled */
 	if (use_baco) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
+		/*
+		 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
+		 * is supported.
+		 *
+		 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
+		 * always return false as the 'smu_system_features_control(smu, false)'
+		 * was just issued above which disabled all SMU features.
+		 *
+		 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
+		 * now for the checking.
+		 */
+		if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0) {
 			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
 			if (ret) {
 				pr_warn("set BACO feature enabled failed, return %d\n", ret);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
