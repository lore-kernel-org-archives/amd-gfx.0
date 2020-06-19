Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C2C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E1B208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nUROlJVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E1B208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9BAD6EB08;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5B86EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue28DathgdF9f48mM1dUgVGgOWnFtBaB8/2T2k1X9quhwvrVqwDXk+z0N4sWPWuVjPBUn7pveVtAKJb+Id6APQsdRUDT00VqOAD6tbJbNeCmY1mR/YpxvIjvwniork3OYtXff5j/KTeMC/0srZAUB+aRZrHxQPFUy9O+k0jODQtMeCzHun1GHCsoJOiYLxNa7LI07AKYq5ppklid70rxkrCL5kpKMsIkatAnf4TaGEqW+dDQMSh5L+COVPqXZEnIwC39+zuXbqGPRoKKKVHqUI6rQhjFLo/x0i2BQSnVG/AZ8g0ZEQpl21KCwJukfmQznV8ePFtq9dlEXKgXzozqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/zgrIT+SEKjgcubXZ1gwv9G70fO4EsVt8CrOjf8KXQ=;
 b=oWNJYy/h8+SnzbUbdaycdNYZ3ulDxv8z6Dw6AqN9s7oqRgtPOrMdCBqGGe3R8o9c7sPCuQrFjUBADiz7yYLCHJoAJdTwS4Qak+bZkl9A9CJZ/Lxp87AtjPEJC7ud9FF6sdTVrlMxxrY9WIbrA5pTOuCXlQ4yXcP6mDhwg2vfHVMojjCVEzeaVD6bjPZm1Ux85JHgkkwgibQmGSPzu9XhZ0oFrFa/PTITouQAdev35I+jzhigrhzpsKIOEEuYVHiuOw2eSSg3WuAiiOn05VgRmt4vNLl8qvYa6RRhrDd3vs2lBg2QhXKg9r2bP2B3LceCB8+NAmh57H6YFAVb+IMXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/zgrIT+SEKjgcubXZ1gwv9G70fO4EsVt8CrOjf8KXQ=;
 b=nUROlJVJjeThj94yTVF5MyWG4EcaVYg80ynzLOiLbBH8GSilv+xwVy4/u2PlLzoS3x65NqONsEBjqoLku0VTW41LCbynsXYcuaZwjLsM6IPzc1A79FqmHYgTTG6cewwho8klfJWyKEugk5NFvorgiRRZoc8LFudTe5Qfsgz9myo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:08 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:08 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/30] drm/amd/display: [FW Promotion] Release 1.0.19
Date: Fri, 19 Jun 2020 16:12:20 -0400
Message-Id: <20200619201222.2916504-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:06 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18faa61a-c007-4f95-24fd-08d8148d2e25
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087793D6BFE26981720D30998980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkLxkrLH3387kxbevaUeXfzirnYXMRBpoaardZEQQYd07iIQJrXfaFNBWdPPw8mofE7dgHmYFoFnSI6PBWPlNo8iyBNJckRclB5eWDS14fMJWgEMnrpjLcRZA96Wh5/nxx/k+CD0JcmvixDecShWcFBWpbbACLAVUr04Gz0B9BPmlF2roMHp3198oUfG4IWBmuk2Gpze101h71O/zf8hUoH1xY3fjJX2NVvtiTAQsZgA5v7K+MzwHlat2Hr4RN0FLR1/hfSDakY7Nj8ngQ1emc0J9uqaMNq2Ib19I+GVbyIxDyxQrE1EIkifCU+LA3lU6+DJJcRY5f5LQXQB7N/grQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lbs3OxSF8YIqfydQwat5Nlo8wCd0XmGA2LIonG7lunav7UaX7KUpW7x4wrpVX7CHhbf6Vh3QTseZADhEs4/YRku17fovm2Jbyzz+AxkNnTmfdlx38O90rQWUVYksoEob2E3UUL0YWrZyk90Sq+y5cUWcwvv+bSdt8XpRbZ1WDU8ehBMlu3H0zUy/rg1dsWGFTL8XHVHLWuSgxszyXklpHRc0bvhKjQ4oyrbYSRmOErC5thSedpANSx3wpIfxOYmVi69nfUegH5Pdfwz5ZjDKyfNRXnWAjIinI+KZ9WbDN6+j48/IHO8ssMCx96JlXnwnxhg9FwwIlo2khCfbJUuTHqaNtNiG1ExClPrUsimREDl1aPT8ZveIoFR9fqDreAiwmsIpOC4/ViAs8Xf/d2fJ/Ja72Xy9VmV9GaZDCHrbdXlalqN+vSiav4g3NS8P7k2d/p5JgqOm0OQk/iQw2wZHKFoBgOt7wbBs2yyzF3Y3LA31BmZEiPm1/mrf9OxO+VBSCZYcF7utmPG+9xrBqteOng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18faa61a-c007-4f95-24fd-08d8148d2e25
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:07.1897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amE99QcHaxTlYAQAuE45ev3beHd2DcZatKyUJ2vAfyvRbKSDySwFLG8Z36OgU2wI9X/lffkw7JzGyA2XcEDbog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
- Add debug flag for psr to use hw locking mgr state machine

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 96e1379c4cf8..68b5fd811d26 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x67e8928df
+#define DMUB_FW_VERSION_GIT_HASH 0xf87bb940b
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 18
+#define DMUB_FW_VERSION_REVISION 19
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
@@ -86,10 +86,11 @@ union dmub_addr {
 
 union dmub_psr_debug_flags {
 	struct {
-		uint8_t visual_confirm : 1;
+		uint32_t visual_confirm : 1;
+		uint32_t use_hw_lock_mgr : 1;
 	} bitfields;
 
-	unsigned int u32All;
+	uint32_t u32All;
 };
 
 #if defined(__cplusplus)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
