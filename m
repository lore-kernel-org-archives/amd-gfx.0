Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A7C3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3DD20732
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jt5PXjmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3DD20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24806E3EC;
	Mon, 24 Feb 2020 10:06:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232306E3EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIO0kBJEgAHXv2zevC7x4aRlYzcJs/aRdKF8Vmx5KuONwWc+y/sHK1OtiB8dflJef2yID+jOXVVYJ8nlC9Qth7dSTNYk9ykxK8sWaQ+pUvIDml8IVYKmyipsh5muIyeCLXnYgtd3RM1dFDRUO3hEobWDNqrawQH4qiLjUSggKOzmcbOtA/+VfTpp1Ivq4V24yqWJFYXOSLqCPW7+Acy19tIb0twTvQ+h74VPbTvoZdbZZj3Diuxy5wS5jSezOcJ2znipxU1/8iIq2QIwsth75OCKytgB3fesRlFRJd9mU2Eqc2Xb+2xMASgw41PFIw2KGj+sNCkL9H1youq1uLOe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCoueGjm8exRF6Xv41Rax0gVpxVQsfgVRAmwtEoVtRg=;
 b=hyiwhysxOgUsDRDlu6/ued80P/fkyiZJhW8Miim7v1bdPw5n1PGQpcFu5HttBmNpCXmUD8iEEEzzsKXqOaNjIXPFiwq2U+0xTEZddwRtml0KDzE1ix8V8HjuhXFVI2ICuAd6vqZZlngsSAjlcI4o9Do1LCAKMckTfNcwYIxqihre6Hqv6HqDiZ4nPPKTUCKBBjqvuZ/WwADnIkJklm/Y3WSa7XOBKQXtYsIw+Zk/CiEuDn/6jNvXXPHmknSAgwQ4YsDuynyQf3d0iHES2NqTbnNZQ9o4QF7cG7qpGSjPLsr04Z4v8F/G+pFCQWVzrH9xhFlQz7VoFEUmfZW1zOJo7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCoueGjm8exRF6Xv41Rax0gVpxVQsfgVRAmwtEoVtRg=;
 b=jt5PXjmxv2jUTiPMsCogtfN5JdHKCdAWK+5qbNNeSpg55OxiZqIK4UykRnA+qlNrbtDvLf/xGknhpEy34Jcgl/W4nhwYDzSJTlMiOncp67Qb/W9erQl/zjoL+JOHsgYiEdqIKpk0FihUJi0F98zTre9O6rPbK0FiaDXWd0Vs3M8=
Received: from MWHPR12CA0050.namprd12.prod.outlook.com (2603:10b6:300:103::12)
 by BN7PR12MB2676.namprd12.prod.outlook.com (2603:10b6:408:2d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 10:05:58 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::b0) by MWHPR12CA0050.outlook.office365.com
 (2603:10b6:300:103::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 10:05:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 10:05:58 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 04:05:56 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 24 Feb 2020 04:05:54 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <Kenneth.Feng@amd.com>, Evan Quan <Evan.Quan@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add dpm helper function for DF Cstate control
Date: Mon, 24 Feb 2020 18:05:48 +0800
Message-ID: <20200224100550.13722-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(428003)(189003)(199004)(110136005)(316002)(1076003)(478600001)(5660300002)(8936002)(81166006)(6666004)(356004)(8676002)(4326008)(81156014)(2906002)(86362001)(426003)(26005)(336012)(186003)(36756003)(6636002)(2616005)(70206006)(70586007)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2676; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba70a20-11f2-42c7-b106-08d7b911251a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2676:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2676239C22622A09D92A4B6FFCEC0@BN7PR12MB2676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1QVNrdUzZSrh3aUOKH9/SynyVXFIT3NYNG9aM0FeOdfR1vU8kUgdxDWW3Yo/scdNX1PggClRMpybg21Jd0i6xtB0F+Mtl04mU+rvOoFNPd9i7Xg/wsi+vwhfW1UX0l+SezeuTAz9A1GFaHnuHIse/F0Za5DqZ7G4oGa3hfDF0/qvt0pBaoLPMCeyyD6z8VgWRSL+jXCSNyGRS7+Fn3nUmWmgDKwgFKxUy6NPdn3gsnNUpymp6q/aMGNuc6Sc6gMrf6BoFGykVp4E5rr4eMzWqKKEGRHbtzwCJg207Xvnuxeh03NBlVxSo3xd+Tyj1VyLm+QJfTU9TPNDMJQCuLnbGWdW78gET2dcAge5F5N7498cCrolYfipZKRSIMDWCFxqpyRCsAgGmnrfydlPBr+WVgF/eSg9ltIONB+/iCH+peX2o8CB38XfdnPAea4YTMH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:05:58.2724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba70a20-11f2-42c7-b106-08d7b911251a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2676
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The helper function hides software smu and legacy powerplay
implementation for DF Cstate control.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index a2e8c3dfb4f1..ba1bb95a3cf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1171,3 +1171,20 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
+			     uint32_t cstate)
+{
+	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	struct smu_context *smu = &adev->smu;
+
+	if (is_support_sw_smu(adev))
+		ret = smu_set_df_cstate(smu, cstate);
+	else if (pp_funcs &&
+		 pp_funcs->set_df_cstate)
+		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 902ca6c00cca..168579492a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -533,4 +533,7 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
 
 int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
 
+int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
+			     uint32_t cstate);
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
