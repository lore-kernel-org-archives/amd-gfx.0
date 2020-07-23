Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D04C433E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 07:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9CF22CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 07:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mH7GsmUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9CF22CAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2A36E850;
	Thu, 23 Jul 2020 07:34:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A276E857
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 07:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEnycYOkbXQUD2G1Y7FGB+bSYYY6HICkN49JapKfovYl3id5QoppAXxyhbA9qtR+5OgREZ8yXF2AjcX17slnjNyqan9bSdvTgepT9e/zubsNuyIg0/6uiQ0CeSBXNBZ1LE+/akOHW2zDfbwn9ewfYyZ8kFbm9DaHHobpRfWkcxa0gSIOpuEUsRvgJD6GfVgWnwgvGclGs0iMT1RCqK7XM9MJOyOlQrKG3bNFwc7qGGJ47oTNdVaK25uvkPoydRLrLYxT5xjcj5pQT9Qu1qCyB0EqCyqnybADmZykXqo8sBaousWkrsfyWsgyhRXzpgBt4bq2XKPp7KxP0FdfuPUyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AktmdOkjZdUEy26o6JW7Syb0gvbBZI/K/AzmPt5rvoQ=;
 b=UiFYB+yhcbX+omRNHLCy0nlnt/ntd8PiKExI6lLKfLy+ETPfX0BaCIWUCCHN1tn3OyYZ46WT4SCpYQ07a5b8tL9SiBdhRXwQ40P3qhwQb+/3DFPi1sDur82e39khT28qgtlRpqeRyNNWSbkOtxxEZY6vD54FfV6vUbWjcB5k8F9WXU3S7flw7213h6X3oFSuH/ikuXOHB46/zybGyqIKj+SaqlOV7LM/jzYvi96nr9QGfmfwNzNtjAQQI+UGDH05Bls/rvkQ3IFw1u9DOCdd7RRMhf96QuKEgikR2TEipexffnMlURY+/Mxu/4++NExaRI5NK9chhWaMlrJtej3Z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AktmdOkjZdUEy26o6JW7Syb0gvbBZI/K/AzmPt5rvoQ=;
 b=mH7GsmUpSEF2HzDpJ2X5nfUy3C8t9jLD9JjS4fjivbbniM+2rGZ/6JgCFkZVOvb5oEA6lOBRaioqUeQj1hvaVLAAW7Xc1B9REvTuQQmu0WoMm8f3KBDcor/4jcvNuMeMlgwHFRdickOAk+657FKBiSwSMMAsGIA+4dU2hDXdA5g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 07:34:38 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Thu, 23 Jul
 2020 07:34:38 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Date: Thu, 23 Jul 2020 15:34:21 +0800
Message-Id: <20200723073421.362630-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR02CA0153.apcprd02.prod.outlook.com
 (2603:1096:201:1f::13) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR02CA0153.apcprd02.prod.outlook.com (2603:1096:201:1f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Thu, 23 Jul 2020 07:34:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 43c3e502-3fd9-458c-fdf9-08d82edadaa7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB450711A25E0CDAB36220E0CAEF760@MW3PR12MB4507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWqZpXUQ+Bo6y9dWaYkqUPy2A79pdxAi92a6dKsT6OKuFvuos2qSoxIyF05uefwHn51jXJjZoaELd1/I/uEKP1vTE9838Mg2S+jWtNB2T7mpKtBILUjh2LfIuhlhgFLp7LcyjtBx5+FS4U3ctNSiMrgy9n2rTOtBdqeMrb1kgyQPRQDuUD4xr+BboZUo7Qwt4bTPmxTYLh8QbUWAMA6gbndP+9JJY1Jrbvt/3o2oLKkjjkXScPZ0wMQIiqSbk2f1zQpfUkmooHVT7X5enAnCsvnIShHG2pOvEGa8+TIPS/2VyzFprbUBwN+SPkY6terD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(86362001)(6916009)(6666004)(2906002)(66946007)(66476007)(66556008)(6486002)(26005)(16526019)(44832011)(186003)(956004)(2616005)(7696005)(52116002)(8676002)(4326008)(83380400001)(36756003)(54906003)(15650500001)(316002)(8936002)(5660300002)(1076003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mexsSMcYBFQ3ZxB3P/NnKTPpJV3ZhgQIpPryFXZdw2dOj7wy+vhUfyeWIDP73xFVSDtg9v8UntQD24bmHRNUNckuNtvco47jPJSanPF+olifeKaXF0ERa4tmMtQsZ51EuQkmeEzzkIemEE/Q6X4tGDWd20ATaTVV/7DF+m911LQZCNsFiDpvIGSrsQQF/m1ojE+aD/Jlre2OMrxcD2VQjfCTo8YxQAmjmfoQUPDlCiq5S4OIdpOUo3pGxe+eVHWXrWZU4jfFeYD3n6LB+Irjxy+Y3/iXM1HJND0w4ZplMsq4eR1lvSBl8n3YZ72D8jc5XbMT2qU7D3luTIbmYGu37MeTIXvbuJ9eymT32MVFeAvCuFFid4rRwUL+WhEeTGNwpCbJY0TEOWv8QJsAxuyuYQrzInQuNYuQOG4wedTnFTJLGT1e9mtpW8DxJ4f3cow9DTHIIU6JrPUkSU3Jv8UgAMV7sVAYBisIqp3hirhJEfQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c3e502-3fd9-458c-fdf9-08d82edadaa7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 07:34:38.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pfTbaAfexFxlrk3CKMMtFdAhULIUmOyfo0K+M723TOiI528+cnPrL/GOXGh6MYt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Id71876180033eedc10ecbabe5317369676034e19
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 61e89247faf3..8344c3b0b9b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3082,7 +3082,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
