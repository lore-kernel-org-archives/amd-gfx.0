Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED6BC2BA19
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 08:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C36C215A4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 08:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mquAFvQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C36C215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F3D6E154;
	Thu, 23 Apr 2020 08:13:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690086.outbound.protection.outlook.com [40.107.69.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95226E154
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 08:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMqn9bjqwcThks0Ldt3nk7jvdbQOmquNG7nk+Dfsus+r3Ujv3HeHZnnAi5nalvdVbM+cPPfAIyyR90r0ExKI8WcjDZj91VXO7UHfE+jQxlS5egAvCfhThLvK6Mny4gV0WOUgh5KBsCN+aOwd/YW+b++wx0q0dep6oUeqNzOFmVuKivdH5K9BoJKpr9KThAYXcp6DDHuIPKJWuIXfkeNSLr51O718fHCVXPURMn+bC4LGgGFXe8G10sqowCWXOFHwCGoIyjUrv+FpdD7rOGYCtPNoIO5cUBswwFewtYK3C3DLGecnjmDoo21UFhB/YzxaooyFBjHYrWo34HmaqlKT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijkHIfVwnocghY4S1OKbw3QHy9c8s2QlfHB3oCLUMNg=;
 b=OwLne1SYBSRwISUGjLy1J3SnpekhG+NnVM6Y+nUpG1NWBETPkQfLSGDpJTPRE7noSH7wkCCZTeuPAKm5OODgp7PN1R/KF41JwO6fuXGzqrUqc8VzyThks+GArsjXl7bOy3kKQCVnUZFV8kufCNvzudewP7iF5QVPZNnXHMsY9+MMy5NgVrfW3i7G22yZqu/9ZDqBE6wJ6PP+gqAbFy1G1+nue9E1eZyzZdhTU43gbH5n9uXdReDxPrqqUVroKCjlnImwnn0N/+DiWICT2ovMd+GxnmgXiDIzqrwDfvMUozdewfF0Vgbf5zCXNlULid3+Cy05GNiZ6vpciF3PUguVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijkHIfVwnocghY4S1OKbw3QHy9c8s2QlfHB3oCLUMNg=;
 b=mquAFvQA2l+ZNCSi/O1OMrQ6V0mYn/LsgcXhTxhy+GX49z2LPE2kjQKFsTeX8Ofw8S4C5q15UN9jllSDmtmo2yE0rF4Zs+Fu6DxRolMboPhC64vPaWLJXN2s+d5waeomqVsPLtQlay5MT6s6B76Ns7391LjwmdchT9/Cq6DD8XU=
Received: from BN6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:405:1::17)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 08:12:57 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:1:cafe::e2) by BN6PR10CA0007.outlook.office365.com
 (2603:10b6:405:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 08:12:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 08:12:56 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 03:12:56 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 03:12:55 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu:  extent threshold of waiting FLR_COMPLETE
Date: Thu, 23 Apr 2020 16:12:46 +0800
Message-ID: <1587629567-32108-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(46966005)(6666004)(36756003)(82740400003)(4326008)(8676002)(8936002)(5660300002)(81156014)(316002)(7696005)(356005)(47076004)(82310400002)(2906002)(81166007)(478600001)(26005)(2616005)(70586007)(6916009)(86362001)(426003)(70206006)(336012)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ee0802-4e8b-4768-1444-08d7e75e2166
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43892D63AA62C55B22B8502B84D30@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAeTUzugvDIJLOTJEFv/zAkxU+xx+vHWcaah5WVD4WjUlMu3W5XjVcQUy0rjQrC3d9Ea6VFZPW0/4HJz0HOgTrBaqpYF4rUkKrPfmUtAfsLXGVOx5cR1xFsLSUzb09vzsG2QFAIzCNs9cMEJgW9lTQbf7KklMxSoD3ylrkxamv9vD/fZlrGh1LwzdS4+QkjVuuKDs9m82pE+3dTfRnDu+iV0fXJMAHz/e0kzxH5t8bABVTPsLq8lcHNB4F7Jtr+Hyz6IP6Uq7eXU8dnk/cfmkuCYzl2CzX6GESQgAbkqF/r89KpVkh7QbUkxuAOSvUKtAdU9mJShRfy0u6eIb6/qLKhSI0qTrhqn+E8BRqbvqTku3DGSNHgp5nPPE0/NELL2pp58yEplkv0Tf3wRVt80KSkcSJ3C5hURSEvHXmnr8aSmArxLARoikiWiumNUbCOKK7UktNFdub2iW9OHW/e04XkliR8VEKHuR03riMsIVVtCy7+WlAme6whL2NRoeEMp+KbdUZAtUd5L4OzAdXyD4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 08:12:56.9064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ee0802-4e8b-4768-1444-08d7e75e2166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

to 5s to satisfy WHOLE GPU reset which need 3+ seconds to
finish

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 52a6975..83b453f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -26,7 +26,7 @@
 
 #define AI_MAILBOX_POLL_ACK_TIMEDOUT	500
 #define AI_MAILBOX_POLL_MSG_TIMEDOUT	12000
-#define AI_MAILBOX_POLL_FLR_TIMEDOUT	500
+#define AI_MAILBOX_POLL_FLR_TIMEDOUT	5000
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 45bcf43..52605e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -26,7 +26,7 @@
 
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT	500
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT	6000
-#define NV_MAILBOX_POLL_FLR_TIMEDOUT	500
+#define NV_MAILBOX_POLL_FLR_TIMEDOUT	5000
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
