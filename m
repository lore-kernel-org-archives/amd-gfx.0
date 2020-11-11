Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88BBC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B40208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CRZ5yB6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B40208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6486E0BC;
	Wed, 11 Nov 2020 22:28:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C2D6E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 22:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IILuyVd1VyuJCceZzAnOi3zwoeJSX1oEu4DMwwLeRz0LUgK+uuEu+klA3lmFml2TuCT72qCVJGiiFu26210EDdaG9OWwMaYPbHett5c8eJWAq0Pf0G0/Wan5B7krHDy9yey/QVRqDG6ik+P7WJrA9oDYjCmJDAQdiaJ4J7DJ4secAomVuvfSVO9QOjTIHlTwaPUNAfBPW6Vz7hnrU/c0KgQRGNSY84gFH+uTfdQp9188wyy9HRSUzvB+4oeMq++v/u09+Pr5vfe+WU2WWg4qVpAtB9og47+pPeIfi5zo3rS8/Jdaa6Nbva6hBKH5Rb9IQQ8qD7/+PzfhmEip7lVUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A6dsWJMz2XUNSte0EOQAapEHDngLHZF3UB2tf1ZGY4=;
 b=Anss8KKJn+YR7z2FKy8+Zl3n3RE7AxQ3Z+/hUToD70Czm4bnXPvJCmelvR9rhcJwQaerWndgMjMMueodJjA8cFYNsyFdjqibWDrr6/uxE6rz+CMZrANngKSSCuh7UfLaUMHsI8W68FhoYqchmZcWsgJKSSHCvCedwlKX+skjB2ehM7D7e22rENGsxnoVyGZNmMT6bNLw38SCrFZIhDAekOqVmsj3m2+STo9AETEMURsB/yVTm5oCtLLTO1Eql+T35PWgNDpJyRxN/fHEAARIsdWVQsl/4upwjFJdiQ9SlzzR42dV3XCwcXiEdDG+FpvZon3sKzdjLc55BcnJUwHDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A6dsWJMz2XUNSte0EOQAapEHDngLHZF3UB2tf1ZGY4=;
 b=CRZ5yB6jjO9uPyvUaNnKc0qXplXWcuFl5Y09kWt7HpGVwLn+KW/i3uHT7+31jtVOX/lhHa7j26N7R4jcqTHIiaBuJdOhW5q66IuOfT5r4PizfzLPbGAHfAa6XYrTfhOjM3u+R9SL4/IfHdN2IZWfyb38ASkY9bYXCTCyub6YSxE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 22:28:01 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 22:28:01 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add vcn dec software ring enabled parameter
Date: Wed, 11 Nov 2020 17:27:50 -0500
Message-Id: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 22:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1c405b0-9dcc-4e23-77e1-08d886910cb7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB274694E9CFC56480B1C57A14E4E80@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++2fAGVrsL/zodOB43gw+IOsteyDSjhPlMpv0x0DBrM/m3RZA2GYjyQWLwPTz/8iFNGGXBE09hjDyFw9tTc1awBW+YaVREVUWwbv+D86LhuEsvwF8/rE7dnyvgX34NwZBcKlEWQ12K1xeGO//GzPupjlK69QrYg/nSJoW36cqG3CvEvgq6Hu01E4HHKwsCxN1o8kqK6+TJD/RHICW0fboZH6WhISZ/EUsJZ3VowXuP6WiQHrcGDljfdrFOVsC+soMxdFExaZpvKrpUPuZ5mik6y1RPpkob1JI2elCPErDPnfFrFOWXYsZoEPC3lgSCnlZUqPaWfk8k6dp4Yh2glIug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66476007)(66946007)(8676002)(6666004)(8936002)(2906002)(316002)(52116002)(478600001)(86362001)(6486002)(26005)(7696005)(66556008)(2616005)(186003)(956004)(6916009)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: S0knc2kEpYfvVdYXl/w+HbE1eAsUU8l+K13n7wQZkV2olgorf5qjR+E9ZtnHQSujghmsMh/UMcPHZzh20nkJvAUbdJaHUq9ycZUUOiKJ8mTuTStPrkiwRLM6233maXZ0i8AYDKthXQVjkZ5GAfMfW7zw8Un9u7RZDC6+Y1IYn657uUvsLF+nAgHNDAwc0U/hgfO15GzKAWLrQEbNoEfDXBiT98Qh47narPQQqVbSsf6kQGKRCXGVlwfLQ3ZWNCaGboRZvwczLJoNfc5o9zwAQomcOL3iomVpBRH6BFnavfvw8yG+Pw5nV7Su6M2OKE6bxq0wf2Vc/qHTiNBeeb0nJREBaTEHNmW2vRGu1o87VZwhBwuW5q1BG5TxLsZtzPtY8fi1rldM62DrfY6kMceEA0l4+7KOOUCOTGG7n3bxl/bN/pPqYv99u1NnDpL/NLA7CjPeIrAxrcH5rSpi8yP/SJYH+FRQyu65LKHPYD3ioLwNQeZJllMtgpR4UVlhCt7uBtXfJCfOGNGRcwUMpWaKceV9huMn2E7CjX88LS6HtQSQJlEdxvExtVcBCTCDnpIkDJHc7nnYGaDa7Ik1RgX63GMxMoLnGAyv8eEfJwelxnNGidiEfZDwZH/8lKJNqsjWVFEV3pXPCbf84bHSj6cBbu6/F9C+o8X5JuQOraB9Myr9C71U43Y2lWrznjWxb3DjEJeWP5QQU+SdWr28I+20v8x6eu63o88MP8FbHx5jja/rv1m46A1kGTkvPSGR0CX5pnyC6krhUoRqbU284Np+gnrIwYGIH0xlFZt0nvfDh14GMJ2kU+Vo9P90rvfWN27F8FAhXqiWMOaxD58h/z5fkw4/yfB3+J+H2KH9iDDPXMpBvA1W0niZ2niAZ5ALl331+jkNu0JL65zVLi60IAiWnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c405b0-9dcc-4e23-77e1-08d886910cb7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:28:01.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvRo8ESdwUZML62wkYPdHjJrkcCc9KwuM2wj/4y9WRampzjndzeuItwBoDHbn5o4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows us to enable dec software ring feature on VCN.
The default is 0 for all asics, and it is only valid for
asics with vcn3.0 and above.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 20400ec..cc47da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -209,6 +209,7 @@ extern int amdgpu_si_support;
 extern int amdgpu_cik_support;
 #endif
 extern int amdgpu_num_kcq;
+extern int amdgpu_dec_sw_ring_enabled;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 999f84d..570088f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
 int amdgpu_tmz;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
+int amdgpu_dec_sw_ring_enabled;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -806,6 +807,13 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
 module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 
+/**
+ * DOC: dec_sw_ring_enabled (uint)
+ * Override vcn decode software ring features enabled.
+ */
+MODULE_PARM_DESC(dec_sw_ring_enabled, "vcn dec sw ring support (1 = enable, 0 = disable (default))");
+module_param_named(dec_sw_ring_enabled, amdgpu_dec_sw_ring_enabled, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
