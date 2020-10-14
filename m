Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A9BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3397A2078A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v9AXW9T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3397A2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E756EA16;
	Wed, 14 Oct 2020 07:18:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FBE6EA16
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqG0q855MJ3t3U1AMRwwNDquhkEUdc4jyOFbbziB+5AxsPBrMQ+ND5hCGv/hBfxDwQAkd+lJfGI6c8FIKJwDEUhlG87hse7b36DJYL76HDKfcgP2sJJ+6LGKMrwYLmIPNdxoXTbQWdVtE8w/mUmt1dPU8NXPmScGhHW6OQxXlhwZ1RshdRyhk0TgD9+W+G8VZtdEhQFBPXUQIzjITX6DUorZe9s4gAygEkjhFEQgBb+QiINg+QtD5zJl6Pb5XKkPpSU7LA/APaySI5lyRHxeOqIeY2EUJvnzOIecOq2UJslVeFsIK1eMo6v1+k9FfGNZu79Hh5Ujz6chdVeNVWWSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yko3qT9BUS53yXZuOTlO0YH5jK9T1oRF3DCsJyvRwzc=;
 b=CNSVJd9o4pAxc/X8bWDiIxKeweYx5hb4kFwjAGRZFEBvQNnrEiuy+mNBrMPNjKbmNUIawi+Y97rAEA4gHIotygZusCjfIS6A++6vpUmfv2sbXRCoqLWTGBuLHUkDvXhADvxFvl2kYfRYV9GAiuPJ10iSMfNMJNXuVocLB7HrA1hcRBCY3/sAlvbjDam3wTZ+Bk6R0KXKWmgbLxXlbhTZt4HBitgm0R6ZU5/qmvRhI9Ct6lu/ZXXcKFC7Cs6X4mqW9kFrQxJTjl5Bo/nMcmL/SlFhqoGgsvgKx14J2oegxbqSuMLY5mgOYC/Ik8ldp6fkI+5JjOw+Fxc7EMS+3dmbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yko3qT9BUS53yXZuOTlO0YH5jK9T1oRF3DCsJyvRwzc=;
 b=v9AXW9T2FASnZE6hYtzR3HXxqwiIEVmT58pYuNANAS1FAeUIl4bGhYDlyC4Ivt65wtNNABWepTo5CmJ6Xi9bPU4wQi0A/Wm4swJbD8tds6L5LOuuwvO3CcmYdxonS95KCMoXvQI2rryL2DxicskeA169fwhZC/kfaQBoDFtYIxg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Wed, 14 Oct 2020 07:18:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 07:18:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: add interface for setting MGCG perfmon
Date: Wed, 14 Oct 2020 15:18:10 +0800
Message-Id: <20201014071812.8396-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014071812.8396-1-evan.quan@amd.com>
References: <20201014071812.8396-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 07:18:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 447fd9c6-fbdd-472d-5d25-08d87011600d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891C4614B36C8901FFB149FE4050@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4jHbJJWNMEHtU1LEu1QVHuAaXt1iukp4EluRV0Qd1B2SDdizsBaKCYqU2bQ+RxL4VkDODuFvFMqdgviDx5Mrr9uFK9IUoYQhQCZLBI6W38VYl9WegaYjvCGyIgiNG2F6M7wBOyMjJ6m1Y4nS/1j8CVVJHlPgw9Hwr5T/KXB5A49sRTlOR8c7FZ1TeIh4BqufqIs7IdXdqMhoTZYdARubig+q6j4Wf7LnVhoQT084orGMgvze0N6coHoRq2mQLJ5y+NrV5Fs1bOiPyi0b/WGkPp72VSGPITh3kk5MjBChBZK5/iNXWjO+YWmB4QuQqlUBLCXxWpbQsg6znMsz+wxgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(376002)(136003)(44832011)(4326008)(7696005)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(6666004)(26005)(16526019)(316002)(5660300002)(8676002)(186003)(8936002)(478600001)(956004)(6916009)(2616005)(2906002)(6486002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Hu1k63rRYabwtlPjd3i2lk7TnvMarLqH1rV9C+cDN7d9GJ8uDneJuAEhUDOK0gI/IxJpPaYR+75clPJGwhYECObyxHpFDTiZsd7dmLymUp74CP9HIF9YqOPXCJOl6WmF+lYykSDIK3ytexctck+CihLwCJ7FuDinVPkX5Dtp5CdJDcNcSLnPAY8GKlIXSGJHF9JdrNbxutfLUuJoYuOoBw0iI9yxtH+6XNirbpmg6xI1wZh9D1d6MJspprULA5Xd+KIALESiLRL24owwIA1XnuKmRUK4cSgjmvJtGcKceS/yEs7Yy453RZLIVRZSnEhNkG99BxSeTbTZitr9b/QpTi568p7+QXuTh89mSTgsFbbNC2e7WCv/dhicnUfnwOd/rpD4Lw0XsdVjr68vH9cEmCgJIgrGywwWJzTwyiJAuVTNEOdpVe5bgtMru/kxprWqi6iDIzGzuGsQMZVZyLz3Qnzsp4aIBfpC+zMCqgCSuLvChYqn2i3hcbny+8TIR70o0b3LMqwP9YZl7V1pfUVsJu/xhAH0j21/SiW4FSoiqzg/RM71DhNhintNbye4UfFxCidjohfU1NNmgVgNBwveud4nerRSi/0OdFkdfBcoxGIfolYRXhwpIvrEY40Ixojbo9YuTAu1hkPWTKT2tFEwgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447fd9c6-fbdd-472d-5d25-08d87011600d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:18:40.4546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDI1LN4SlcH1Q/2bEGwP8xXWYEIFezOptAoVEW431a8xWJoZMwaeaXzpSYD+gkQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable Navi1X MGCG perfmon setting.

Change-Id: Ifc860a798becbe372f974f7eb537a4a57ac4943f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 258498cbf1eb..190753930b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -218,6 +218,7 @@ struct amdgpu_gfx_funcs {
 	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*query_ras_error_status) (struct amdgpu_device *adev);
+	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9d31f9339e02..df787c86b538 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4272,6 +4272,21 @@ static void gfx_v10_0_select_me_pipe_q(struct amdgpu_device *adev,
        nv_grbm_select(adev, me, pipe, q, vm);
  }
 
+static void gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
+					  bool enable)
+{
+	uint32_t data, def;
+
+	data = def = RREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL);
+
+	if (enable)
+		data |= RLC_PERFMON_CLK_CNTL__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &= ~RLC_PERFMON_CLK_CNTL__PERFMON_CLOCK_STATE_MASK;
+
+	if (data != def)
+		WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
+}
 
 static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
@@ -4281,6 +4296,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v10_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
 	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
+	.update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
 };
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
