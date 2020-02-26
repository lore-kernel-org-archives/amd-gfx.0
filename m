Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE012C4BA1E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948F8206E6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aRQ2xa5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948F8206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4B36EB20;
	Wed, 26 Feb 2020 17:12:53 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0BD6EB20
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 17:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj388QwdyDMqOyZoOgJOi2j1qMvMrCgx3r/6UVtj9cJ0VZ8Hnmu+YGhBn/YimugSkHYuVdu6x4hts4brfayxQz5FjCdYVAMDv0LyYHt3wTZ4tfSmKdea66vtUlkK7225MHLc2KRAmvBjgB+12xC0qmZxCy2LWmwv+v9L5KkPmiOQbFL5+YT6wmbxdhJj0Q6GCojVDdtQPduu+I7zGbvF79l5+0srHcBLiFAvn90jqHTuH/9OaOjUGMXwEvon5Q0PKdr4Xj9VkHAv5LpW+3Xqvea/l4ACM0EIbjU1BOk78dRwwImhPrKZcpSkDeBimOZFgnOHsnXR98fh2GM+zW6CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vfAh0ViwJLjEyGWggIqEmuZoKkGoYNUpGOqw8ebbvk=;
 b=e3uqSo+Sr2WQjWrtYT69ajJqdSmmdy5qmtI0acIv5pbj5EmKfL7+oiTdv/41lkzZbgOaoejK6JWhgue/8i/YyzLFnmGq3wUKECdTE3z4b+eKQD28D6QXGNzn2dhHAv/tRn7SNi0vkpnFFeHUMRRkJDecoXtduNmz/Vu1ZVsaLhSRVrJP43+iQlWohYPzmJQpCDK7AXv4pAV7asFs/LYD08PDrEBrvdHBB5miBBBGefcFqvW5NDg1Fr2FVccVUtckMF6SA/f3Vr0jGtSq8H3jga94zIsxkXmS7kTOwHKrJUPV7fuU3wSeIS+xwNPlzl6IdIdHnFCaWtV4V3wPiIPDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vfAh0ViwJLjEyGWggIqEmuZoKkGoYNUpGOqw8ebbvk=;
 b=aRQ2xa5SfvxfkfinuQci3Dt0+JEyj8mJdvE4Avyoy2UP9C6mpyu01fDWtC6Sa9qt1Nb4OCVYehTzMYPi2a3UA9oEfFSEQoHOrZopCuWlZiRtB8bL8fLHxdvUKGBn7dCBI08lETw2rQWBWDnneInewDxaKwTHWhyzXR1/788KTaY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 17:12:51 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:12:51 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 1/1] drm/amdgpu: Fix 32-bit build
Date: Wed, 26 Feb 2020 12:12:10 -0500
Message-Id: <20200226171210.24347-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::39) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 26 Feb 2020 17:12:51 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdd85466-b294-4fc0-6296-08d7badf1c5e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:|DM5PR1201MB0009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB000986BDD8F5A8E211541EF592EA0@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:80;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(4744005)(6666004)(86362001)(6636002)(8676002)(81156014)(8936002)(2616005)(81166006)(2906002)(956004)(316002)(4326008)(186003)(5660300002)(16526019)(26005)(6486002)(66556008)(66946007)(66476007)(36756003)(1076003)(478600001)(52116002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0009;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pq+knvAl9b+8VdUBLqhrD/h8S6gh+84iRx5uV6PDp12Y+y5w5+mU4y5c2N33PzLuIGFdYiXJ285nEulKh+ma/IjdhchnrfOxH0SN0pSN4Ib/gw31DIYHhSZrQDNJWaelmLZTGST0b8l9OQXjaEGfrci5XVrYch3X0/bIxP5ERh6lj1Dx/EgTXRlR7SReSGdnUSiSc0K5Wy5xxHJpH7ibsmgYesW97xo41X7qTxd3bZwwSBBniBz6aMfNz5UPMbxQiCEEpBHofkKY1I3dxJqqdIL7dOTeT6G5W0P+aqrG5d07/OjD5lgqpsVDmeMhjRpJs4EVho/SVmtpBGUj7L2sWNIESTsJCTFGblfgjswk3+Ch1eY6Dk/w7ahzAw1YQ+7Z/vN1OsTX6xQOIFE4ZUjFoogJ6/qnoBy/7OZcLkXUZR8I6Ji57zflxmwBwhtG9a9I
X-MS-Exchange-AntiSpam-MessageData: x/FC4guUsDtLd4zzROrv56rLGKgp7azLiLsjJTTf2PG+ZSFiT4DS0d7/+aUzq1DFk9B8pyF6FwuM+Eqf8KIZOwTG+0Tbif/J3X9eymHU9gz3lEDyt3qHLs2n+ZP+i6uaHz+PizxsQvcjc23FtptcoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd85466-b294-4fc0-6296-08d7badf1c5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 17:12:51.5064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWIOBwMbd5PKZ6LOlVT3tgPWaatBSoB4b7Vm+DWndU1RTTsfBF3nMVHY+4wxp6M80IQYf7VjrzCN6MQ63K1WIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Cc: xinhui.pan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a dummy implementation of amdgpu_amdkfd_remove_fence_on_pt_pd_bos
for kernel configs without KFD.

Fixes: be8e48e08499 ("drm/amdgpu: Remove kfd eviction fence before release bo")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f30375c1b40a..bc2e72a66db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -681,6 +681,11 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
 {
 }
 
+int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
+{
+	return 0;
+}
+
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 					struct amdgpu_vm *vm)
 {
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
