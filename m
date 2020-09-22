Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8944C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 09:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001542086A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 09:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Slpqvk+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F6E6E841;
	Tue, 22 Sep 2020 09:10:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE15E6E841
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 09:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxsNpUrAKIaSMIuojV/MgNn0OtQeWPcAXLgfYTexLW5BqIlp4V96lyJhsxVSNQNHokxfGGEqC8kbe6nTIw8+8IarUWOU04IizoxzavGjLx0oXg11Ap1LdrYeyZ5P6bSo8tdf9KbMevMNV2baE75oIEU5Ea1Vtu2RkHDDQmhR8Ars1C+CaoWoLAT3Ax2Bnn/Wo0F0yWfljpmFsNQ7JkP/Wb7/XTPW9Awm/JA3gDwobrxANuvLd4+6EmzYdqkvzawZryEJdG72yUCLoVU3Dya1YRFDrXVZWT/i6ICetz54S9g9ead1Ay5BVzf4zSDjdBntPk0BUS7yZ1I5KGpx9OafhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkpDuuAZNT2zazM8GOpXaJgZfr7hIP/cyIihVbb6RiA=;
 b=fehxktMXkq7rQn1HK05rWeydZGp+L9WAT2lYVufmkUGA8RNK0TaTTHXxK4U0d2SPIXpeG1mmO/aDl8VJxqKCpZUTN3x/6sIYa8R+Qzpvs4rEygQWZOYEPaKXqMEVDdfoC67xyKgnKi4bCX+/2cbpIenusBmX65heYQKReZx3ltI9bbjk/M7aGR92t+nQtRT0nGlPC/24FJE7W9zZTGeBI/pQbYkVabClL3QRkJ/X+qVqcTC9lnFekGRbnhkgnk/KZTzCZSEPYjQ2l4TwIc3YqQqh0yCAjWFXCG47F+biDMUxzQmiuOUKKAtVx3chZuu4F9YESpNI09oK5aOamq4Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkpDuuAZNT2zazM8GOpXaJgZfr7hIP/cyIihVbb6RiA=;
 b=Slpqvk+dCNksufzHRdY1mbc5Vt8s1c39EGrcuwB0rJLPzrxguK6z04+ahJSluKLLJk3FJb4WvSNDfkZFUSePgayPaeJ2kymstefo3YyH1sqWN4zv7vhq1bnYR/RM+qr1qGnONt4R10vhAo+nCYwwvhSCNs5sdXPPJ4YBsqryyFw=
Received: from DM3PR12CA0061.namprd12.prod.outlook.com (2603:10b6:0:56::29) by
 MN2PR12MB3166.namprd12.prod.outlook.com (2603:10b6:208:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 09:10:27 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::65) by DM3PR12CA0061.outlook.office365.com
 (2603:10b6:0:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19 via Frontend
 Transport; Tue, 22 Sep 2020 09:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 09:10:26 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Sep
 2020 04:10:25 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 22 Sep 2020 04:10:24 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: fix hdp register access error
Date: Tue, 22 Sep 2020 17:10:22 +0800
Message-ID: <20200922091022.31676-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f51e4b-9126-4394-b2e1-08d85ed75856
X-MS-TrafficTypeDiagnostic: MN2PR12MB3166:
X-Microsoft-Antispam-PRVS: <MN2PR12MB316680D6AD684C36D3C437529A3B0@MN2PR12MB3166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PMbp4CfHrLn+LuPGQU01lM0KVQTpZpCM+UpbDZ3ButTmwF0EPHAqqCcaBpCDiKOmdi1pG/wKopcW1RHNHJmNvlWbZGeAgM9BILG6AABdUHzq/iLpltCOKTHPsKhVNvsSfoRjKHXMd3aBNX+8kxuuZ8EZANTwuPzqHxgUUXaEO3KmVB18p+MQX5+7KQVWKukN6Q7F/G36BMamivC1RiQZHeIg/te81O9qoiZgEwR3ZGXQcVZTOgDn+zu1y/rJuj7/Cn3PU/JDXv5lwurthQv+y6GO9Uyuw5ZC2ZfEc6cKnP3fUhzokzo+qo3YoGFcT4bnCsgkA+LTE2QI+ZVEH4SewdMOEaW1xdYNvJqw83Qjpy8go0HbRnKa90tB0+gGqzV1YC0OcZxdpv4n9rDqojzihUUHA8cW2/izD41cDuI2ped6nww4pBrtZnS5m3R8wRs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966005)(83380400001)(70206006)(86362001)(316002)(47076004)(336012)(478600001)(426003)(2906002)(2616005)(4326008)(8936002)(81166007)(36756003)(1076003)(26005)(6916009)(8676002)(4744005)(186003)(54906003)(70586007)(7696005)(356005)(5660300002)(82310400003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 09:10:26.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f51e4b-9126-4394-b2e1-08d85ed75856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3166
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mmHDP_READ_CACHE_INVALIDATE register is in HDP not in NBIO

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I4375a8a67d3a13f9605479e169169e22dd5833d1
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0ec66030bd11..bc894cfba60c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -621,7 +621,7 @@ static void nv_invalidate_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(NBIO, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
 	} else {
 		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
 					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
