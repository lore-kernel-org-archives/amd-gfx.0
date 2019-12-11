Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D64C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 23:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC992073D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 23:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PxyEmHYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC992073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4002A6EC13;
	Wed, 11 Dec 2019 23:10:13 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C93E6EC13
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 23:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obshn9Nntxb5Sz9sew+eFHEjw5UIs8e+wa4LHv/x/Cs9ZGOMFnCJPeI27giaUqB60wNOt9clVaQ9ztmzxSRce0LqG9W71etVNQG99C63HyxkltmNpzSYJ0+8831MAghsn/daya881+shLeoo4z2NKjiIwkDQnlIeHjL2m8kEtdBDTgvnQ0e5trsdT+kuB+icn7GwNeJ69gqhJRG1zoLCgsFx4BNcTbOVExNbRC6U8BG7STyLbdTBEgRHpusDrkQPS9SKCjekiD6vtsVWJgej4t6zelXFt309C7jS9dzH/dx9ji2MAm8ckPc5bW4alheqSq9CA7xADVcWF1puoDAqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCH75ffuc6jsKqOxYHdIZ7TORuwVcfRiWpBVMMGS974=;
 b=c8fC/wbXykByk4Xv91jk3Smm+fhFf/LXMnQP1EYtQiZGY6Fp9fn5Rj25v8PzFIp2ghHY3Klnv0jzkSObp3JlvjsHGgTWjQr3Fb3XGJV00Wq4iVjLzgSOCgCecXbwOrXUYeVo/Z39mFWvFB4wSTWrHsYceJFzCx/ZhDHEEj95WgNyEFuLU24Aaj68TzB/6rpOlMFKMgBWl8X51nUtOMKIWbNWLjeZsXc9YijvHzE8oWmyZ5Mrt7Qk2TjunDubJdc+seeHSaZ5OhONuyZxvK4wNDrYAteduA21AEOr6cmfBnJfL83XaZe4yYe4apQ67MvNwX2+NWilizyVpx9U5Y5NPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCH75ffuc6jsKqOxYHdIZ7TORuwVcfRiWpBVMMGS974=;
 b=PxyEmHYUFyPmSdiPJc+iPyIda1NJ524bOF02B8b3p1YgMiq8hNZS/dOjH3Js1KCyFJfseMJMhfJ3JZnqB8orUkqi/+k8PWXdyfHLsIN7x9POUyaxzDqvmCo6oyX30sg9ERnlaLgOBP2DfbtaAJcnOWP32U/uC+DuSggB1JppU9g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0187.namprd12.prod.outlook.com (10.174.109.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 23:10:09 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 23:10:09 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add CU info print log
Date: Wed, 11 Dec 2019 18:09:58 -0500
Message-Id: <20191211230958.31523-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4df4ce7-7ccb-4d12-14cc-08d77e8f4493
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0187:|DM5PR1201MB0187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0187A4DBE11CA6D783811530F05A0@DM5PR1201MB0187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(4744005)(6506007)(6486002)(81156014)(5660300002)(66476007)(86362001)(316002)(6916009)(8676002)(1076003)(478600001)(6512007)(2906002)(66946007)(81166006)(66556008)(186003)(26005)(36756003)(6666004)(8936002)(2616005)(52116002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0187;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQOphT6GxH0WjYpP7gg75hyAG5Y+dq8k3YI1JLiHWZLTikWAWOb3IZ23F2soEKXURhnFgTGwxMMsa1UYugPHaZD2yZ9jDsTWq+d6DenSUnKgVH/r4We+FzJhtafVB7e5Zayi3vdXCMgwjFRMal1kf3wEmNPvQBMo/QOb3gvIUdNay3PcP1nkjvbDLpZf8x4iNTH8eM9+VYVX7tw4RAxOqHK/g8Gp1DRTk6D324xkTM9ogN1Y80b5grseS7tv0w9/rx0edt5wjLozONB9UQUar3ApC+7zX24HhSg0K5lQXABvWumndOgOiP/0fIiFQ4Ml0q7+w4qk9jISgQO3If7rebjZbDXXIpzd7qeLwG8tcgho59+Rd+a0mXsPvqQOLGrroyQUTG0h1NzEc4efxVTi+Rgg3rTuWvyj+T7teU3HYIt16u3es5W1Ql1LHoUX22mI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4df4ce7-7ccb-4d12-14cc-08d77e8f4493
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 23:10:09.5575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cnJ01R4MMyVv+kk6vPtJjEjvrDllQ5FOtZwX1ENxS2qRLkkz5iAxPljl2t93hfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0187
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The log will be useful for easily getting the CU info on various
emulation models or ASICs.

Change-Id: Ic1c914938aa3445d8dbfdf6a237bc1d58b0d5267
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8992506541d8..c778b6db5e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3032,6 +3032,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}
 
+	DRM_DEBUG("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
+			adev->gfx.config.max_shader_engines,
+			adev->gfx.config.max_sh_per_se,
+			adev->gfx.config.max_cu_per_sh,
+			adev->gfx.cu_info.number);
+
 	adev->accel_working = true;
 
 	amdgpu_vm_check_compute_bug(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
