Return-Path: <SRS0=dgkk=2P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD037C2D0CF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2019 06:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CAB20722
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2019 06:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gpRNwzyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CAB20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C0A89F53;
	Wed, 25 Dec 2019 06:23:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8886589F53
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2019 06:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYcOGUaAercQ+ZDYv818M7elFziZECYF7gV+7GIq8nVGJ8qRv0GX737QqL0Sv9OJPxHhBZ+5cC+ohUQ1CcJdziMR5nUzIwoKA3bVaQ4LyxoophisVaUZrjsJRK5qEjxc8/Cui9GG2gPd8K6rqJ6Cq20pJYn6vky8jZeKon6/dHWIWJfA7Nh8DJ5bp32cfviFFeuj0xjTsXknNpAHq+I+QAANfuQAcSg6Gekg0TxD7rGnx4IMJdnAfhhyoGgtwQ97N+NNqcFoq68REz217tenVoj0pOWZEg5c7VbXotnsE7s2OiszqkJ7u4kIwYThugYnIPK7zrGLcqzD9kNURFkcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2VlrlNgVuaB02gzT6BM4FVqYJ+XiHlhRum8Qkghihc=;
 b=JSNQmZqNBpLlKpcHAgiqee2g3HU0AWL1W96AxEyM/9YaUqNZhH6+SGVO+x7h0fHkfods96eIO7d0mCnDEdaw7R4vS8QKzcJ/gqikmZesgmT16cb2+BGpTXcYsiZStRQeQz7PpKwYu9SKPP4R077UvSHxzp+Y/lXi/wSZa+oIy2neLVtzEvtkGONSYr9bPcgGk+87eYzd620Pkqok/9v++Fz+eZuE9DRU+Wf1PR+fN3U7E9rD2bYiPRFN8lc1Dgjp9P28Z/cR82XZUefSpFy5373KbW/YU8eaJmyqjkjfTKa4W167/CTcbHjpC5AhxcW9Kvt0aGig/+LRYGmfyXYANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2VlrlNgVuaB02gzT6BM4FVqYJ+XiHlhRum8Qkghihc=;
 b=gpRNwzyw9L71sJQt2FxM5WmXPbCa/0afYTl/2a3p9OVO+SD6QGE595USVI79n9f7oAzjTT5eQ901Iu5y9KcumH55N/4O33FluS/JrFqxVSKO8XnWudTlgnah2E2na3kqQ4/i3Xcvwb1PsZ3WhcNz6CxJaSs9AMeoQjMMJwGziso=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4255.namprd12.prod.outlook.com (52.135.51.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Wed, 25 Dec 2019 06:23:22 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 06:23:22 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct RLC firmwares loading sequence
Date: Wed, 25 Dec 2019 14:22:47 +0800
Message-Id: <20191225062247.4115-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:202:2e::26) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:202:2e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 06:23:20 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a0b208e-1871-49a6-cc68-08d78902f0d1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4255:|MN2PR12MB4255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB425518B0C707D90D04391815E4280@MN2PR12MB4255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02622CEF0A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(36756003)(26005)(186003)(66556008)(66476007)(52116002)(81156014)(2906002)(316002)(81166006)(4326008)(7696005)(6666004)(8676002)(5660300002)(6916009)(478600001)(2616005)(6486002)(16526019)(66946007)(86362001)(44832011)(956004)(8936002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4255;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cC9sy5jzWdDwoh1gO9AcVQ8boq1aS1abT5kjv4Ssk6C1FPFuZ92GFJuSvX0ZSo7mlNRSYP1oHk3hPeSH4VcCecwGVfbs7aXJ9QofEZb/KThwE0QyO4+h0pMBuae+J8o1cF4TVDosnFNTt5lJcjMyXo2riOAHmtq0KwgNRkCPvuc9BH2foRCj15mDfA6OIw7p0v9lbYHiAHTGYTpr93EAvWWadRKbW5zqy8tS1l9zHtF/kj+SHTi/nn/Qbu7NlgB8AB6nUI68IliWUKBY4KEoltuRcSOdpycFXXDID16oVllGYapL7GEBM8JIo8tGC5btiRAUtdVK4ASxpdGcwS2VtTPXz66C/ePTNQSRoHf2yAIRzssYZWuSCg46qLEQn8NhxfpDSQ3OIDqIPhw9E5Ke43xyPSsmCs3pxcTPjJCcWjZQxA74Sib7SgxdRvO6IWTN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0b208e-1871-49a6-cc68-08d78902f0d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2019 06:23:22.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi/9zlza+4xgo1W1LWo8O6UU9Y3NVNp4v8WoWujemrzLWk/4w0RSyJ+1Dq0AZCyO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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
Cc: Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per confirmation with RLC firmware team, the RLC should
be unhalted after all RLC related firmwares uploaded.
However, in fact the RLC is unhalted immediately after
RLCG firmware uploaded. And that may causes unexpected
PSP hang on loading the succeeding RLC save restore
list related firmwares.
So, we correct the firmware loading sequence to load
RLC save restore list related firmwares before RLCG
ucode. That will help to get around this issue.

Change-Id: I4f5cad5e6bb2e5fd632957163516d9be9498234b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1b89bc3e2e8f..56540885f5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1466,7 +1466,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 		/* Start rlc autoload after psp recieved all the gfx firmware */
 		if (psp->autoload_supported && ucode->ucode_id == (amdgpu_sriov_vf(adev) ?
-		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM)) {
+		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload(psp);
 			if (ret) {
 				DRM_ERROR("Failed to start rlc autoload\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index eaf2d5b9c92f..b0e656409c03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -300,10 +300,10 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_CP_MEC2_JT,
 	AMDGPU_UCODE_ID_CP_MES,
 	AMDGPU_UCODE_ID_CP_MES_DATA,
-	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM,
+	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_STORAGE,
 	AMDGPU_UCODE_ID_SMC,
 	AMDGPU_UCODE_ID_UVD,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
