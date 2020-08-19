Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6949C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B959020658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vGlRwo/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B959020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787AA89B01;
	Wed, 19 Aug 2020 09:59:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A286289B33
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 09:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS/erl+XpdhQjzhfkKNhO4qesiWdenYNj+R2T2BYH5iDTd1HYofJ7lu3abYCYq4tSDm4gO0yHFHsM593salvkyUJyQnFeuRlf6Oe8/yjxgkEVDTwzwuPA73u+lfbxILivS7i7f2ex2zaaKu/zAtSzDy4C8xxU1yAaPcZQ2MD9mPubwL5Il7Zg1PBeBBU3nYsIJAidMdNsr6tYlgFESobiU0czuR2G2GEJI1rp1KNe3r8dq9YqmSDWAxrztwFBbSxouZDnbvRTMl7uOSQ35/qWQzxXZeQlwIQa1sCyCq0FC1Pw0iJDrVC/Q0gIa1j6+3JO1M8x0L970eb9tUxc2OU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkR9+UPyTjah2kbWu7Jka0S+G5ZyzdxDWGlZ3bhVv+8=;
 b=gQCG4V5FNXwYZtECp+ewXlpoifctnuipDMICRWlhmGySdEehqESgPrMctelFFlVSGBZszMjdmdANVeZRxfvfiUaDWA+13FIjW4IA7w8UE+YPmnhN1XciVZ56mSVCYdJ61Oc5pgc03LbmqkoWeMui711ks085CatlnP0jMTlOZlBcxwTMLcM/G8OMmGCmJaRKgFerRu6nW25EpzKkaNEqNHNH1Cty3xQVu5VPp5kxGDHxy89PyiU0tWKi/+8qgR+NBPFGRSN9+l0M/jfeVwTXPYXHrB5sZRfh+KUixvpla2droaa7CynrWwfiCkYkyL8dXs+Sv06iur1EaTTiTh3zJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkR9+UPyTjah2kbWu7Jka0S+G5ZyzdxDWGlZ3bhVv+8=;
 b=vGlRwo/utRbs9eqvTK4tYqPcVclJO9MLwDGSkDqi+F8F173lVLDSK/GXx9AJn25ZVDcIHsk7jcNWj32/b6qVzYajOlvmKhedB6L8K3SjJp8WMwcSTA905PcgMPPxT8FMvf8OiGObkpc6Hilp+CxBFvRhPIc0+yDmn8x9rPedmLo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.24; Wed, 19 Aug 2020 09:59:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Wed, 19 Aug 2020
 09:59:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add interface for setting MGCG perfmon
Date: Wed, 19 Aug 2020 17:58:32 +0800
Message-Id: <20200819095833.11420-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819095833.11420-1-evan.quan@amd.com>
References: <20200819095833.11420-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 09:58:57 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 594e3129-6e5b-4fdf-ce49-08d844267e41
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02185FA64FC2D6013EC6DB78E45D0@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYKE7K5EXWwQgr7DMydOjRI6fdX6UTTZLSQtJjl0LGchMQ0JVXmEJNyQJsjXcYQ3BsPl5IEidNOSMdudnWzIe3TurhXwCoKdhHfrkyp2j2Sn5SfNdfJawmjGtTshfA5MGC32RRbOBeZtWAjXFQJmHNjI1hiRgijXuf8djbZLt+D9g1y3uJ0ubBkUNj2En1yuZRBOgLEXNt37lxkMUI1vAYuHu68gSfgTiK7IyI6Rz4zxYBVfTYoiVxuyCbDvaPRP0vP3U8a9iIPX7T86MVuaP5wbwqVG/4SPHyxYNX+FHovbwCQKix0xwJpeI5wbzDV7LxCHzquKP/JJuxTQ2LrU+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(2616005)(8936002)(8676002)(1076003)(956004)(66556008)(2906002)(66946007)(66476007)(5660300002)(6666004)(44832011)(83380400001)(4326008)(186003)(36756003)(6486002)(6916009)(86362001)(316002)(7696005)(26005)(52116002)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RomOgMcwN04LrVcw9J/nDM+A2Rgu6ni5F9zt4KLfla7Wr+WuNyUcpdygMTDiuVcBBLqz454Ny4hFKkq0RXXcFJ+w17zq03uwqXds/q5oie+6avgV5mC1cmW9dgVTkvh9jx+XgxaKO4La1yHmZ8iomsV3btpB/Oy8vI75Oggi5bPtwbTqpueKcqjVRyHi3YZXHpNV5shBUGYRIW8xuuSD5Nc+mhxqjXNToVaxlO2xf9rRYav3+6QisSjBZAko4FAppTCHy6PCpMzCdDADp1Clm0+vIrP6QRRcBhgXf0M7eXZYVH9EFRvb59Br4AX+Acy6LLDC7oShNGkPiiRai3nLlhqId6ZFZ0uDxe60jLfNaUwsqRheorPBqiSxrUjMWJBIhtPL9AHg6DYP1AnXjNRh+kArh28UetVYoaCnqNfYdCNjzf/wEG+hqYNrMWYjXoUTNL4U6FaJP1q2Mf0El2WTHrwSv3A/qTr3wEhR3mylHQyBrtIRHtdCkChADryJ+XFOG2qYd0E8PWuJ+kM1pvTzCwJkILA5QJa9ZyX6mTV2/NktrtXKkeP7hnpTtwCtZNWeUDafFzJa+cjJP8HfZ6hZYVi8eUimxGYbSbLYXZI42d064ZIQhXq24nbtkXk5/WRLz7cKfddobvswdlBrehJomA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594e3129-6e5b-4fdf-ce49-08d844267e41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:59:00.2266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+lQQxcdsI+wW3qFnmmv10Leae9O9dQWeHZh1TPfee7d9ilzNkiMsbLGMU84IkRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
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
index a611e78dd4ba..ab71f7327e50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -217,6 +217,7 @@ struct amdgpu_gfx_funcs {
 	int (*query_ras_error_count) (struct amdgpu_device *adev, void *ras_error_status);
 	void (*reset_ras_error_count) (struct amdgpu_device *adev);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
+	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e527be22a3d5..7e3ae68f4ad8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4156,6 +4156,21 @@ static void gfx_v10_0_select_me_pipe_q(struct amdgpu_device *adev,
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
@@ -4165,6 +4180,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
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
