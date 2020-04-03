Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C30C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F7E2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PQTBXN3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F7E2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE5A6EB68;
	Fri,  3 Apr 2020 10:20:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278806EB68
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Zn03mP4s1VTvua8clpOF3GLoZL1MVIKQIR/8K2vsfnmUxHQAZ2RgrZgH3R8fGYs48Xx7bnQ2UaLlK42mmjgxCZtjMFQVIOQxxxAjA7fYOa1+D+TZXtHm/fmtzGRMDTYHKXW7cAtJfQ1i65olOZER2PvP+FgLCnbELNwoby9Gsxuhe8ISpx4RiTNwId8/WfLaz9dAZujmC3z3+MnmTfyJSACiXmuuk9T7e4qbWBvSu0qeyX+xGwngnWNoYfqt3/EduVxIJpWFjPt6IdMT9ljVvng31AHldVB4al4VuboWnJJylNARTgNzyNG3emTH2DSjgTcbe0QlvXxudVoycdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOaDX0VBgsiB7slOQ+ELy8A1+ImDPrBdiImyyvdn+U0=;
 b=IwCdMa72vCAOyO7/eO5Q3crVTrfXQhwx+t6muTXQ1vqwk6KNB2p66c2EAhtNAGxFhOjuvCeppMgWY9QUzP7x+FI2Lj+VdbB1P/C4nc1K+tzPkEwTPI26BsJswu2jT377DtGEgNAktKpFscEeCC+QCHONJBLa4GyHO1mPNguBGcPdRCYsltwvFPxVWIAMG4MOor3xPgFgxHAd7dCipHhh6oCXaoNX0/EeJ83q/TMgIDvACmee/cS7eITGRPxTQpMiRwOpDKhOHGpCZPpkz5lWxqbuI/7tZcciikfQ+xxMhODkH756Glc6bxKFPeJ1YhPtiKlspme+2OeDLNBAv3TEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOaDX0VBgsiB7slOQ+ELy8A1+ImDPrBdiImyyvdn+U0=;
 b=PQTBXN3qoY4RLBxffw46+C1U+CEnNAmjFhVVwBdtDJuI1rF2H12YF54MY+EwmF45GKlkstAs1KdBalLRt8aIlV2kiW4B6PM3jSDQ9SoH9ulxAs3B+/9bbQC/6Gy/virnlGNNkI5EiIvzTsde3y7xFvvOqy7+J0gm/lfEdHV4HUA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Likun.Gao@amd.com; 
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0021.namprd12.prod.outlook.com
 (2603:10b6:910:1a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 10:20:51 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::f836:6f0a:972e:da63]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::f836:6f0a:972e:da63%10]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 10:20:51 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
Date: Fri,  3 Apr 2020 18:20:02 +0800
Message-Id: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2900.2 via Frontend Transport; Fri, 3 Apr 2020 10:20:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22d05f0e-d27a-4eac-369b-08d7d7b8af6a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0021:|CY4PR1201MB0021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0021F0851849ED80512536A9EFC70@CY4PR1201MB0021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(6916009)(4326008)(6486002)(86362001)(52116002)(66946007)(66476007)(66556008)(44832011)(478600001)(956004)(8936002)(81156014)(7696005)(316002)(2616005)(8676002)(186003)(16526019)(2906002)(54906003)(5660300002)(36756003)(81166006)(26005)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOu3MW4JDWeJ7alTRU0dzaIyIP2CfKhyzdTsriDI0aUzjPkaNnetiiaeGUJ5/g3s3bTuS2QBSUHTwxC1Js+Ar9rLrgpHxJFT0R9zIDT98CK8WbUHNwvwDbVskVUlbCPc1I4XN4CnHpAUUrBS+JtpHIMeYOZGVQXQwmvB8Qp4T4deu3P4/S6pZ0IwlQ67GdCV2f76UH64TLm1ng10A0bZW9ZrbUejER846M/zKIZxmZpEovd7usqeLqgAxPbqA/t7L7kBfA+C80qVv6uxhZtNb9JVS/3pUd6V4Hq+g0o5IcJvEZvkIuWVegqSw5C0vo1Tqzqa3mOPk0LyPMC1VWWPbvGXOEAkCHp5aSSW21aG7rZNgzsYLVORLcO5vkxiySa2AiJ2nkpTdzdChaqsgDlfamRJRXTIjZ/uHhVnc/eWF96yVrf2V7JGHB8Xj5+Uwxfo
X-MS-Exchange-AntiSpam-MessageData: Qr+lId/imZyMh6FNSjNhHsni5BJWj/haUpFG2Gt5hGkk3JSqxSKR1p2nysoFKc6YVHQbKTRmfgaufvSWDSywSzlQxFz2mhJOcxx69wBfA1gyPo7RYlfoo9ttOhq8pWd7sIMwebnGc8vzLFYIVQHmIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d05f0e-d27a-4eac-369b-08d7d7b8af6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:20:51.9219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TnVu2ZBMXCEinYgnKljb15POQhYKf1m5tl/Fit9W9bI+HMdzaHbr0o3e7WMouNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Change SH_MEM_CONFIG Alignment mode to Automatic, as:
1)OGL fn_amd_compute_shader will failed with unaligned mode.
2)The default alignment mode was defined to automatic on gfx10
specification.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5a67306..d8f0c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -279,7 +279,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2_nv12[] =
 
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
-	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
+	 (SH_MEM_ALIGNMENT_MODE_DWORD << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (SH_MEM_RETRY_MODE_ALL << SH_MEM_CONFIG__RETRY_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
