Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B60C63697
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A98120724
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kKGlqZbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A98120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E66E6E062;
	Mon, 23 Nov 2020 17:26:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86676E062
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 17:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZCD79cqehTx72ey+uxL5pjkmrR3rb08EvpVP5L/cYlyCW3uFt/5HPJsKRJKmJBFFpI/A1WlwZAOCZmVRkD9zdyrQpFwoXl/gEuxnRSdr6VJcVfN9lcsMQKdCHciVk3TkC9LhbjzYAX57Pz0sfjQIqjZ6W3h1DZHewPMttwCP84i++AFhjOzb0ioatnsDR1yegV8mX8D8/sqINDkAMq8jKnjX7M7lqS3Ujml+YbKYHMWKiuuGGJBwq6xOWD0gM301eYmWKUzl609IgVhk7ds4CayiWiJzegV/ioaHmwRpGKlE67AZql1jJHYSHPVD5F0FYXtzjvHL9ous22whSYs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprIlm7q2jpNxMqGkiuwCBzL6OcOl2ltyrqUofU07wY=;
 b=LwUc7Py5UFvJ1iXN3v0V8p8oDEUvFZuTsOsgfBwL2hdGAPriZ8bU14NwLgPQUBmr9CwLqWlNOfpXhoTCVw+8WRw4ebfVM+dZMb7Qh9WGGxNAGCaGabTsjPjwBvcWH2owGV1iKfOLM0FL66BjE03fNwIfqufani6hg7k6jHSYuCOUNDpa/g4iVoJ7e5DLa/UZbjI6mqDuEHwIClvXsK0M67AbEWfPbDu+hu1ossMws/Mxy6fDcHemmSDqB5ZrH/QXh5nI3UcKn6yUr78P0jUj6Yvtjh6YdlyutZJk1FLg2V0GIBr1giJb/+j/i7J31f98q3a0Htgpv7SZW8yMkX0vCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprIlm7q2jpNxMqGkiuwCBzL6OcOl2ltyrqUofU07wY=;
 b=kKGlqZbpOnKunGgOvxpaeRjfeQnSP6IWjHcZCLFQuUMLuTS8LXEvGgCPARI+zDZPfEWGh2q7+S8dRtOomw1Hr/3ke17Gpl4RteYMimHVYvgGK4Y03zcEC909t+PbLBrfWY5WbHX57QwAJ57F2/sfJOR1GVWxV5f26eWKtrbsZew=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Mon, 23 Nov 2020 17:26:27 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814%6]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 17:26:27 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf
Date: Mon, 23 Nov 2020 12:24:55 -0500
Message-Id: <20201123172455.19789-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: CH2PR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:610:55::39) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 CH2PR18CA0059.namprd18.prod.outlook.com (2603:10b6:610:55::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 17:26:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d3652bd-4479-44b9-c440-08d88fd4e8cd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15143E64077EB6B8B34E5E1BF4FC0@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1aZ+WCTOFL0371FWznpgPUfeZiSDPAF4JK/Bzgh6uYCxtH4p+3Ak+RyBbSlEL3JT+ShR05AnYAb/3K53uLvog9T6IG1a6geIU2fIjYqrLataFD9eLjC+pRbGF6jXEOQgNirECpkfNHx3652f4c+VKTavxDuJBBbyiEgtkWQOJlGpq2ZhgVoFjnLEVKvaCtgXPgjHJk1sqgtMo4wEafXK7su9AhEcYqLL12lkR/1AWpAKn+GKPXBjRKUBMYZocq7VQbjIb46GmSjoeU9cG8TDjjnHviUbJXm5KVR51MQ5v8+tgmiMbIk/AHYx6BAmA3Ogwjp/zodp9OP1lE5RKjA7+9NSBRNBkJbvqjlVKJyRgWt6STizqnPgiAeCDouOanL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(8936002)(2906002)(86362001)(316002)(66556008)(83380400001)(66476007)(16526019)(52116002)(186003)(6916009)(5660300002)(7696005)(8676002)(4326008)(36756003)(6486002)(2616005)(956004)(6666004)(1076003)(4744005)(26005)(478600001)(66946007)(43062003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SP8eNbGaQKwgWNBNawftKTmI0jvizWwJXVF8HBqavPxm4QgEx1v8+JCysNKDDGyTJ88tVRdzv7wkUwQoJXd49XEPDkux+hhut7rR6Rz/xU3tWZcDAe0QJsledv3a7mBLRe/bzTZkfOVgYTLMoi8ptBaZaW3RwNC2L6vlJxnFAQl7rhHvk7L32KMu03YvjHpONgmUAkFhuTg2kvRpJwfK4N00u5pVXu9mWpxQ/h2x9efpOKOfWAPPHpTLbQfTq+IokbIMRIXJr4WmTpV1ImtihduXCQ5rNKgcHajpbd/0al6cD66V0HUxC70Vu/G2+k+FJS40t+XCjV+lyKJyTGWVeyyH8EVgVCL5gMeIbw3qRnug9OhJnYbz6c4lNP7Giz0193vHTL9jMbtPfK3/iYeTeQG6z2f8GYmfvmfDZmN1UMO256RTtfau6XH+aSB34Nv5OYN4FqenyEnvZcJCcCm29HEcbUDZ0tJr9wLDDpH+cH1S4RInOmHHIFAYMCF1hVK2hymHuFqI96kSU7lJ4N8r5PyvG3ionlI+zfDRV9W8SUEf0K/6cxlhMzgjKDPNjCglvaIpseKLqBdN9Su+OrDhFIhKDnG0CCIWsojkcbNdUuGHHgt3uPwVNdA9ste+2TgxFCngBaAdWAdfhalL6JA4R6wzwAkXAtMFZ1zq4hsPSQjA3ToRA2QEgOpM2emOjv1GOlDyCIJj3zZ5yCgYQv7HNJz2mfrixZ9ZNMpXVRXAuX78hMnLFzVvKtCjiL3i8bkz9vrfH27W8mwxlAMx3fxm/TX3kJ8h3ddB975OJXYkeRcdJPr2z13/Tb3YMXUvHS39U+h/tzcrGZFrLvb77EOsgtHoovKeP4jT0dyZMFBWwKixos8n/1apcagZPd4ELHSJD6MzECo1OpCGXBzi8eqCNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3652bd-4479-44b9-c440-08d88fd4e8cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 17:26:27.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQBWsBlcDFoJxPQ+dNQEyvPEFvoDNceZsHaxUJnYJJjBDe3BMMs9Qv04/8rxomuHX9znse+UswU1yp//353tUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    This function actually control the vblank on/off. It shouldn't be bypassed for VF. Otherwise all the vblank based feature on VF will not work.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I77c6f57bb0af390b61f0049c12bf425b10d70d91
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b4d4b76538d2..ffcc64ec6473 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -139,9 +139,6 @@ static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		amdgpu_crtc->enabled = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
