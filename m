Return-Path: <SRS0=M3Em=GD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB2C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 09:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A12922262
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Dec 2020 09:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A12922262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B46F897F5;
	Thu, 31 Dec 2020 09:06:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271C5897F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Dec 2020 09:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxGFmhB8ENXlpPg+TXs6LT1ME3Gf2eK94s06cb2oahskm2DDMzOGzq86NRho6UbbwWQkdESwLuA3vQlJsRwpEFH26APZtcEzwAV4BdST61YYWtnzvmMal9hpvQJ+ug5qwSjbdIJnXBjTx9U7/htoEAPsPlYvQWjP5qcLoOz6LHXGPS/PrNQuPYnSqcDd8pxaaYu6DisZHQZ1eD/UUvnh6Z06YV6qjv0J6mq7Wpd4l13iUTLwcjd8mJPr/6Ug5a1lCqfCn9xf9E7KLSBx9LwCGBgIXkGxgwBRu4zWqm0rA7hND5Bqexqj0s09o31FhAz00q6sEB1qcy5oeLAfubB/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFiTzi63rklhZwa9FPC1AAWYtpBOjxy61BwdkGIGxdw=;
 b=QwZwDQHLmwOD9DAUXQMYQoO3AZYG9oFbbozOgmV8ofYNcUYSRWgxON6P1fCkwTJyMymdetHRB/UVh9qmHm5iRy04d80iMxAqdC231Rg78ao5ifRqi/7KODYlA+Nf+EuO1oT5VFC7Jx1KFoJLHgbYJNlFHuuCLzdn7XyfSwWzEvUGHWIeFZo9qw2+ywaSHM8OLRejPrud3gNvjPFo/DLpREETObaHM93XlMMCr93FU2RcWtiLddkpKEg4YQG8pNqZQ6NAEA5bFZXCbZi+n+a5+DQbfWdmZLz/8EKzRyLieCI0tQ4HLZdQVvBBWRi2SGZjmvkQuvxnlhibGQETWX2fRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFiTzi63rklhZwa9FPC1AAWYtpBOjxy61BwdkGIGxdw=;
 b=NT8MmLEM3gQRD5loxUmNrve4IARV/mAX0F/uXkUB7/dFNm7qCw2XhOkwWyhwah5S89B/8Nt0XQEwAsaxXVpUME8wMaVt/SQujvBW53OB4SkDSko3xiXXCsqnzyVaLEEJLYQmd7y5WwBwXYJKcV/U89Ee82/qjDqeTZiF5iSR4XA=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by DM5PR12MB1529.namprd12.prod.outlook.com (2603:10b6:4:3::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.28; Thu, 31 Dec 2020 09:06:28 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::52) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22 via Frontend
 Transport; Thu, 31 Dec 2020 09:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Thu, 31 Dec 2020 09:06:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 31 Dec
 2020 03:06:25 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 31 Dec
 2020 03:06:24 -0600
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 31 Dec 2020 03:06:23 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix potential memory leak during navi12
 deinitialization
Date: Thu, 31 Dec 2020 17:06:16 +0800
Message-ID: <20201231090616.14908-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c22f78d6-5005-4032-670f-08d8ad6b5a53
X-MS-TrafficTypeDiagnostic: DM5PR12MB1529:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15296E4E9CC40298A52819C8F8D60@DM5PR12MB1529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBFtCsu/0QCQIE8AnYZzKW864TXh3fZgOQiClHYjZw/1z2hsfbcGttK50ZzoFWu8HbggqhYZ5is/Nv6ilub88f2pZotEmkrcvC88xCbUlxdpzpmYCsiTboFw/jf6V9emDj1QE68m0rs1qnQxyLCT1hVh6/+32OHJrNo6Sj/ymW0eUFeJslmr8v0KqQBBHbXmoB4E3gjh6m+lMRE0BapLDz4T6x/Ol+m6KVYMbE0C6yiX40nmxwLEfz41ZQH4GYEvhOoSHJd0I5IvXPDm0Ho29/wFBzm/+Vc6f7mz0yMEZUP1EYUBxgmSSrwUcjlNxn7Lz/hNfTQc8eo4qUr6M4yQubpWaXt4tH2dPf0yRVUHeVWnMVwY7+y+6rcgQVtBF3D/NvRGL7nl5OaD0+KWKPfMjC62JYj0RtMpHHdYxtlazQiLo+4cvUsFU/8qktX9ASGdx03guqzA6yEH3vCGmsB5fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(54906003)(4326008)(70206006)(47076005)(2906002)(82310400003)(8676002)(356005)(26005)(81166007)(426003)(5660300002)(1076003)(6666004)(8936002)(478600001)(7696005)(186003)(86362001)(36756003)(6916009)(2616005)(82740400003)(70586007)(83380400001)(336012)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2020 09:06:25.9777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22f78d6-5005-4032-670f-08d8ad6b5a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
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
Cc: emily.deng@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Navi12 HDCP & DTM deinitialization needs continue to free bo if already
created though initialized flag is not set.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b44b46dd60f2..4956fbd512d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1316,8 +1316,12 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->hdcp_context.hdcp_initialized)
-		return 0;
+	if (!psp->hdcp_context.hdcp_initialized) {
+		if (psp->hdcp_context.hdcp_shared_buf)
+			goto out;
+		else
+			return 0;
+	}
 
 	ret = psp_hdcp_unload(psp);
 	if (ret)
@@ -1325,6 +1329,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 
 	psp->hdcp_context.hdcp_initialized = false;
 
+out:
 	/* free hdcp shared memory */
 	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
 			      &psp->hdcp_context.hdcp_shared_mc_addr,
@@ -1463,8 +1468,12 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->dtm_context.dtm_initialized)
-		return 0;
+	if (!psp->dtm_context.dtm_initialized) {
+		if (psp->dtm_context.dtm_shared_buf)
+			goto out;
+		else
+			return 0;
+	}
 
 	ret = psp_dtm_unload(psp);
 	if (ret)
@@ -1472,6 +1481,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
 
 	psp->dtm_context.dtm_initialized = false;
 
+out:
 	/* free hdcp shared memory */
 	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
 			      &psp->dtm_context.dtm_shared_mc_addr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
