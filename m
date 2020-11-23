Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F3C5519F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 02:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76712076B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 02:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IkUAjLVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76712076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9A189A88;
	Mon, 23 Nov 2020 02:32:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD8589A88
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 02:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h52Aa+yNKfw2vOoDqSujjfCidcjYFYEfO1RF4dfXR+ot7sBezK/MAHYRFdblPd6RjsinhA8WjY8nVDDa3UL5+K/e5NRlet4jrdSIT1+NKmoD/GdS1PiivlIa1zOp8oHQHWO3po6/QgN2tRdlLzNepxlrbGVuNUGgfetpLLrWoiRgPb8QEuIOjz52NsjOihtAll2xw935cesZi0eWBf5yHFaEvV0ArB04/P/hNhOlmMwq6iFcnhdOm3Cprg6tVpxB4kcrhHeW/7CMff4+iirttZ0kJz1pPLXS90PZXBiQK6Yau8nRvAoBFDBGIW/9mYVEhhJnsLsJGBbwAnjy8r4+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lgr4edUdNX5L2MjWldOwqJRay4njF1lJVCsh57a2UE=;
 b=gyGBKT8EvWgG06CnWFs/vnyTVZoGCppuyr6g/80Et3Nzatf3N8d4AsRqu9umNIHwB85/hDTw/CfCIb9GCTh465wJzuqqlbjiXEAZM2U6HvVpcU2mnDQHNTTpWApVhRhHp+1inW54IaizH6/4lu1HZSztCvWmdE+nrplEtra3LQSNe8zwo4/F4CGjcL3FqKbMydXIoLlWsFda30DIrrGu10GSUDgzT4BeSjp+TyGSGLpiIQUh1pASGA3+Tw2ctYq+JJMMSvQECKZqil/28qjvOyBw1/y6K7z+X98e0j1EgDSB4tUiaH+cRT3a7WhJJ9SkQLt86JmjiHHxfIdhKlVczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lgr4edUdNX5L2MjWldOwqJRay4njF1lJVCsh57a2UE=;
 b=IkUAjLVtPSpawbJMSlAgDD9gdWE1simaXTPfFnAl6RH/wCK8sTPn2fwyNAkEGYduW4XgHAq2uPb3LJE05mO89hkqUCiQTle+Sd02SFaRm8m9IMCVy7kA1PUNhKA+O4Vvf6PzsWTloNWm8C/fJKcOTkRAcWpDwX9BBMdOAnZGvy8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 02:32:20 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3589.022; Mon, 23 Nov
 2020 02:32:20 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Date: Mon, 23 Nov 2020 10:32:02 +0800
Message-Id: <20201123023202.120670-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0219.apcprd02.prod.outlook.com
 (2603:1096:201:20::31) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR02CA0219.apcprd02.prod.outlook.com (2603:1096:201:20::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 02:32:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1ba79ba-0237-4c0a-d11d-08d88f580094
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB452270074AC8B14608B80C08EFFC0@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIWa3EyeHv7BS72vkxrdxJAVf9kClH0CDZyEOLgQb9f0F9n4iz5OAGudoCsQXfzFZGyA7cPG05ickbwwuvaljgjL2vcg7La+f9MBPdIYQdOHfTSM59q9TRFTrdoh+wRdHX52hSgqxr6lFZUgIm47WmuYBch1HKHeigd2D6WXFbkQSaCvVSOzoydcTbWe1q3NBoTAzA3ILGrjU7DBwdOG5YkbMHhVTcSzFhx7wekt578yl4Fhdrl/UD7oDggHoX7jrQOAnagOCxQkSErV/SGTzThbLrG0EyPebzAV1+pKMHaWZwjdkYtAFnuNEffqgOM/tYaS5ssWUaba853EDX5Mfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(1076003)(186003)(26005)(16526019)(2906002)(4326008)(15650500001)(8936002)(8676002)(6486002)(6916009)(478600001)(316002)(44832011)(6666004)(86362001)(83380400001)(52116002)(7696005)(54906003)(66946007)(956004)(2616005)(66476007)(66556008)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5PjQ6kNAfCiZtCSgiOVx+S6+4z8HR+d6ffQfZ+mkLrgw0JY5Nr3qNfroPpWw6O7Q0LlOfBtazMM5WDH+xjF78aMSsJkPWeharKi1F+3/aK1ThmNy9DSKgT5b6LGiqjKy0x6qNPsIVUc9Xaytsb87RDdExS3JaJhk7R5NTqfBh+Ce90VXX39IOOYBx4QoJelNRoyfTnps6oXgcwemn9I6iPAoMkOv2GDMIuOfR5rd6mySty6jEG4TLGLGahf2z+59ZAZf9bYocIiSDDkbm84GONUNYxXL8FbIJMhg54rz/xR+Q5OZm8JTrclb6YG2IMihIOsi+FAAB0D0kLWxmwYzMN99oIJ9DQu7QLH4AT0CA7wAqkYeGckWDpvRavjqgMhqAC+7buOUCUkZlCNAhy3JwQijdMe/QzI9oLBzMYm1X38ahuiHflzvkt9b9KBW6E4v406hML6ckC/DeliP6Jk7o9Mvrf0o3XCx49KPVWUTBYix7LFOGFNd3qplbnwlDW+yM4/ZgrqpenzgyJ8jntiTuNCszVHXr4HLZTMl9yE7wLZTiaTvtVs+woLHbYzRjf+py40uAbZXGKTk4KhpH/R6X/1pHCfzlFI9BRv1i0Rmxj6yUeb1gNI7Ov/x+YtoIDxWW2Oaa8+6vvEs9MhllViLZjCY2aL+rcQBZdNbuXsm+6Z3bm9oHlAWUkCc6cY7DoqswWEhdeMxBmlM2Unf6S+b7N1/g0H1MrRAF+aPIYpI951PMm8BA1zqP3umwG0uRasces9eXmTJZYADAsg6/MdklsF7NJ5nnnltAXCLPdqpHA/NRcfgiqeLmwMWBRdc364KVq7UUol19aA1zcgPdFskuXHGmhggzDb8VZHTlHsyRuwU2WqPfz1FnWOwb4MMKtAY015dNwNcX6c16nfH7wtUEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba79ba-0237-4c0a-d11d-08d88f580094
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 02:32:20.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSYf8nxS+3gcdIafqQHLRVGXP1LBcWArgqy2xMV1ZmKDjfZyYIlrNYWTdoNsz/Ym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
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
Change-Id: I2f107ced1540c9ec145950cf8b58664c6127756d
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a6d03931f7fa..2bd6e40d5833 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3148,6 +3148,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0 ,mmGCEA_SDP_TAG_RESERVE0, 0xffffffff, 0x10100100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCEA_SDP_TAG_RESERVE1, 0xffffffff, 0x17000088),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
