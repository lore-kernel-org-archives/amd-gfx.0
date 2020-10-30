Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E521C55178
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F3F2076E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ngkog62H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F3F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411076EDC6;
	Fri, 30 Oct 2020 15:05:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2C66EDC6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 15:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLsVcTGkXTZrz+Bq/MXykYvnyGIDMpuzuXPqLiwiUQ7lOzy1eXlEgsRX7S42IxbDoO8d8dn5N3MC0fb6DrVW/bfO71LcjzEz5Hj374pH1ADywfEo14JyzcCpTnoZCdUSbp1Ma4BNIk20380RpxNPlNVu/qoC5nK+BOpdCay8QxHlXwGn3xQ1m+B7Q1S9TfuN+5f1gmhICXpDLSFVIWlPw2EdK17mi23G+JGANOP3pTNBlldak7Lz8tCFeDiHuZ22w76eWtx1l0+47I2we0Shawzk9bVpj0/JD/mlPzkukhqSMnLOSowfPFiKRPJb1ezwhZAifQF2h1qPQihAMwkh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+OIES+Ib9oepGZZbikTupc2GejBvIYQ60dWblvYQmA=;
 b=CophqTOYL4cvkGcnvPafurwi5qm0J4Dscg5KMfXA6kS46xWmNt4tFETZJw5UJFsWodqIJQnIARHKnbN8SG7vH0Mm8+vPAKlOxtqQczk5zOT0BZX6QpKMfcLu67s6mLtLxEcR0BSG1CzpGHGgwjo2fs3glmC8P1L6tuXx6/OnXa4ZpnTVYCaQ3d+hQXgZpJc5NubqkFGLHoxnWR277aVLRI01r1bJzidxs1MCAZC5x8gRX98nLTnaKJVagUsmtZ+Y2aT98Lvb3h1Wfd3gl8iHOnsjWKfkJ5VZxKA81hkSfz8NRFjyWv3xnWzzOrLyaUq33fN3SyXgMUs3HIOfk9zRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+OIES+Ib9oepGZZbikTupc2GejBvIYQ60dWblvYQmA=;
 b=ngkog62HC++ybK3bucyRQnve3lfNzFxTsTwwPZExRDiAsHaDk+jD82UvAejPHtjubN3WawbtYc0NUjORFQ/iK9S00MR/jCBOVki/PCSffClrhtIOP65bpzDMJoM5Rgxe7LDRr/Wz4Wj2i2AHCnVaKa7XTgA2TvJ3gyp83VqC6r4=
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 15:05:16 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::36) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 30 Oct 2020 15:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Fri, 30 Oct 2020 15:05:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 30 Oct
 2020 10:05:15 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 30 Oct
 2020 10:05:15 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 30 Oct 2020 10:05:13 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy
Date: Fri, 30 Oct 2020 23:05:05 +0800
Message-ID: <20201030150505.133369-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906fc57a-a259-470a-24d0-08d87ce535b9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359642C0FC66FAA796680E9EA150@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnVoRki4B4fTEfr+/exy7anQcCqFFUY18XvsqYJ6DSwGnc0PhIfosbUe/p0HUMRSYuo+scuQpQqplz+joYtII+8uP/umvfR/ab4cJRfbkiWfQmJQi5We97oRD2jbHgKkgQb6nEhtn77EhWscknZXCI4fkUgmsckDfgr+H/XYrtO0fXX6tfXF1/M1OrVogddg736f3lfzcQdUaNLWbplJiXqG2sQ3pOtcQ/mTGZO3dXzmti2RWa0Tqlwavej4VIooTb48uZ/IXCHjQDB+pMhrwFmKY9WRE0Z8gsy8mZqdBniCckrHW+FnkzKQmdBY5bmByZfSO74NEeQtsSw8V3Zsucq23AKRTop/trRWZVZ0ateqGwq/bxBHEn1rhZS/bGfe4rWxiijYok1EGJ9v17kmVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(86362001)(82310400003)(36756003)(81166007)(6666004)(2906002)(5660300002)(70586007)(47076004)(70206006)(1076003)(356005)(82740400003)(478600001)(7696005)(4326008)(6916009)(316002)(8936002)(8676002)(26005)(426003)(2616005)(336012)(83380400001)(186003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 15:05:16.3176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906fc57a-a259-470a-24d0-08d87ce535b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>, james.zhu@amd.com,
 leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Toggle on/off gfxoff during video playback to fix gpu hang.

v2: change sequence to be more compatible with original code.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 277a8435dd06..62d4614d48eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 	} else {
@@ -370,7 +371,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	if (!cancel_delayed_work_sync(&adev->vcn.idle_work))
+		amdgpu_gfx_off_ctrl(adev, false);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
