Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D850C54FD0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3417220409
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yPIFbL3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3417220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDDDB6E5AE;
	Wed, 25 Mar 2020 08:33:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0206E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkrUN49y+LprexfEObjJlJd2OEbLo9jvtc3vPrtMOj/dQE77WKLNyEB+Td2mRQ42XNa3n3yyhcQ15sm7vUZQ9DVh/ZHg9/xfS5qSSPPraea2AzQD/uPz3PzNpbCeA/sAVo4pXjMXmJxZzcb2V6yaqGYCIkier8qB0xX1DTrRXb1VJRX6B1MjXsNfCU9c3IMgM4Ts4+4tT8g702s9xwaMTHKUJsWrChBjgyNQadKVWMk0ToYiIwW0mlk9xyMW151AuqlRA3Ak92+PrfdOpayDK/RXAZYjFkedrLee0mlSy/zYNs6ympD9fEPW1f9etxF5/xvXVfCcIOFH3RscARZpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFW6SIcqnHK3B+RHroLiR10261RIclZIUtik0CeGglk=;
 b=D8Le5jmbLG8AQcZOCoK0jq0nEpSLUebx6tM49+jzuQem6fzx7nodSE5m7kv7ax6Sme20HZlGGcF/ZXBU0wmZIkcPWOEufVevNeFu7/bslppuR8Q4P68pxH95JrlO1GqVeFvD52bPlPsKXbzerfDv3mlqAfIj4jA5KH+fjU2qfWnlzhUbg+KUOPY/tm0Q4F0Qp84DYJndQS06SfT+Q7gRZSNw3XK8e58aYTALcdT9QRZSOW6wUeMTK8mDJUDBusEYRu/3AEh3AeMXGiiHtz6n2vjauYRXsJ2u7MZATysHmzO31GGDhhTaIOCXoa/vTLIpvlW7V85sZE5GKq/TESuSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFW6SIcqnHK3B+RHroLiR10261RIclZIUtik0CeGglk=;
 b=yPIFbL3WxiLMr72nA4jUM5H2XypUnRBOYCnT0v8tWxYqqzDMmnca8Efeedm+CocDdFBQmPi+XN5nhDpkR9y/DRmamnhWOHL+0B5ZKFwiOftlJLkwcItMkd4KNbwGOGwAe1w28QMsb1DvaEc8Zg56+98yvG5E6XCX1a5hs1tDFfE=
Received: from BN3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:400::19) by
 DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Wed, 25 Mar 2020 08:33:28 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:0:cafe::a2) by BN3PR05CA0009.outlook.office365.com
 (2603:10b6:400::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.12 via Frontend
 Transport; Wed, 25 Mar 2020 08:33:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 08:33:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 03:33:27 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 03:33:27 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 03:33:26 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] SWDEV-227334 - No need support vcn decode
Date: Wed, 25 Mar 2020 16:32:59 +0800
Message-ID: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(46966005)(70206006)(36756003)(70586007)(47076004)(5660300002)(7696005)(6916009)(8676002)(86362001)(26005)(81156014)(4326008)(4744005)(2616005)(336012)(2906002)(186003)(356004)(426003)(498600001)(8936002)(6666004)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4091; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b4ed5b-75d1-477a-8359-08d7d097310a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4091:
X-Microsoft-Antispam-PRVS: <DM6PR12MB409119E77F36007EF051F0708FCE0@DM6PR12MB4091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm0yIunwF+g9DSXe/VGamE2uz5OYhtKLN8TVviQlWJQ15fT8LZh8zZuF5irDnrjxraq6BS2R8QSQoRt9uT+HSplbl4j/c7o7z41O/PIqp4eP0Y3uMLFQSq/SWlzgpj5T/3o136047jp7lAHsJc+4SJkfTFenws8MkliUM5tGMXetWTEAAcn/XGRD4YeIr50ECPOlw06C1bePINf+dVr+5q5vchNBo/auFOd3C5FMpqZQbqarbtClJnxv5FHLsFVyzLBoFjjNPzfdSCiIePnQWI6SwM1ssGqsbWcfffd4VsPGr13ywx2IExZHPHgJLaoExwYCy9Z0YKdON51CwNrOzy5TIlTDMGik91NGrHjSC+/5hmRj+fV+TRneAsWyqCP5/XRAhfTMiPBESYQ1hZsZLjBpLNxxyiMtost/qb12+TM6L0lhlpEJIPjIvV/yuBHJt2UFZL85JvblLW+wS7HOHC2MQ2IcDqR2kMkEtnIhRH/um9zKn4dmo2Pw01c3ySXvjLhLK0RA68+TXrZ57vitQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:33:27.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b4ed5b-75d1-477a-8359-08d7d097310a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As no need to support vcn decode feature, so diable the
ring.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index ec8091a..febd4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -223,6 +223,10 @@ static int vcn_v2_0_hw_init(void *handle)
 	if (r)
 		goto done;
 
+	//Disable vcn decode for sriov
+	if (amdgpu_sriov_vf(adev))
+		ring->sched.ready = false;
+
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
