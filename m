Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FADC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032FA2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032FA2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF166EA44;
	Tue, 12 Nov 2019 00:34:10 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730089.outbound.protection.outlook.com [40.107.73.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D148E6EA3E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnQl4PNPSDtwoVYTyX27TCswA1/UIdma364gan6F2+c4xy34tM8R32KYNxe21w9OQI+eFP7xGxP7YGtY4oIcIA9//7i0j8X3Lrrrlyyu6fp5LldJzn5ujdGw4lMnC39btSxA5h02vMeZq3yGiraudUaY8vN4myWgM9rcGfg5Ly+bCAWb7I6TqrI0zl/0cEjbAjGntDoGU4fAAyMJ2iL7y1wt5AkzLc/3kO8Aj1cZi6osqvFYAh+i2WqldcU7B+vQUdKbVsqTYTr/14+DASSVlxS/H4p0dpLhTD0freVlWYyDUDlz6mnsLRbshLLvO9h8/jqW+7MQiZJFk+rBTkV1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUMLdtIEheHq7m//O8q/lwTBCq9Zo8BK/QeFRB6G7EQ=;
 b=aFNnfWqTMdzcVgyOGoUSPl4XfG44WBlplZse8nrmSkRc+GUVGKVpw4RTcxaXAtUEPw+I9af46DSVMSJHQuvYGnz/TgKSbSOk9eOCbIADeWMzw61uUOC1Zep1HylvwftuzI9PZPZ5QdLWIBaxtZXEB3dSY3Mf2FMjZ8bs5FMD5cTHHsoUAXZKAIs4z/YRxn14NiBhe9bIH0lZ1JQfT46j0elTpdpO0ZVVMNY/ISvM+MomRo6y4h8g3BsNz8RHhBSxz97ilETuVx4zm3hA2MrSSjJzehth4MDQ81RcfmnhZvwszlHivcWIcceYb6bB2x8TIrjbNdd33FPORuqy4iXpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:06 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:06 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/30] drm/amd/display: Add DSC 422Native debug option
Date: Mon, 11 Nov 2019 19:33:23 -0500
Message-Id: <20191112003324.8419-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08befd24-aeb8-44ce-0711-08d7670805ef
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255495D229874124B09C488698770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(1496009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/+6WLZDTGHa9E1QiQuf/QQap8MSGTZnWKGZe2G5msql8VFVcEa8cglSDj66K3V4tBgMgn+ocJh36KHnMwopKXLQkUAxrxRN3t+czem1ZSRimmE/99TWOy0hvHRkOPWI++CpFTvGp2vdQN1+W8Wb9ciu1otTWM+m/RQBMdsYAUnsIc3A+eTW5yDjdB1YI+fIs5j9nDb6UWY97LWauEYGUPB6Ohto10LOAFlSvzmgFV96WVF3d7BMenfe6OqS+0MUUNaulf6s0oai44ZYmEmTMV92v9bMCjgl4nRrEgzqZ1Wx/K95ARKuybI3BJpiAy3qbC+1i0GgJfOMFfbP2CoVgDM+iRdpfQoSpD8O70zVMr4ydZ0Z6/6FjDTV+mtvlkpg9oLlCpcg4g8crXq5fDxhJcBPjBN5hBDwy5MXZOJVqflEY2qdl9hwMpCOlhq+Jki8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08befd24-aeb8-44ce-0711-08d7670805ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:34:05.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiNacYth2qgzzaS8RaMDh11yXBGUDL1ONJIp4QwpyZLbjNXErZBeVHMJebxzUrvtB9iHgUE9r3uiLDxDANhGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUMLdtIEheHq7m//O8q/lwTBCq9Zo8BK/QeFRB6G7EQ=;
 b=maS5wKvFglvUNUjF6cP63kWFJvF67jx509sgj+lKnyEeHyvj5tH3CJ5wyyAXW3y4PpfqifKqZdghcyFOCAdm2JKOLf6dVcohjVeMxrCmtlypO2GXaxX4lwn/Z+PGADPeb2UNb4QAYxNvbWQjtrtJ827qL+/FKZLzyP8+zWDm4ZY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003323.uRJm-foxyxvNbZyj_1oCz1cZmI8lU7dvZqoovfJMa60@z>

RnJvbTogSWx5YSBCYWtvdWxpbiA8SWx5YS5CYWtvdWxpbkBhbWQuY29tPgoKW1doeV0KTmVlZCB0
byBiZSBhYmxlIHRvIGVuYWJsZSBuYXRpdmUgNDIyIGZvciBkZWJ1Z2dpbmcgcHVycG9zZXMuCgpb
SG93XQpBZGQgbmV3IGRjX2RlYnVnX29wdGlvbnMgYm9vbCBhbmQgY2hlY2sgaXQgaW4gdGhlIGdl
dF9kc2NfZW5jX2NhcHMKZnVuY3Rpb24uCgpTaWduZWQtb2ZmLWJ5OiBJbHlhIEJha291bGluIDxJ
bHlhLkJha291bGluQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaGFybGVuZSBMaXUgPENoYXJsZW5l
LkxpdUBhbWQuY29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWly
YUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oICAgICAg
ICAgfCAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kc2MvZGNfZHNjLmMgfCA2
ICsrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCmluZGV4IGYzMGM3N2U0NGJiNC4uM2U2MTMz
ZjhjZGM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtMzYyLDYgKzM2Miw3
IEBAIHN0cnVjdCBkY19kZWJ1Z19vcHRpb25zIHsKIAlib29sIGRpc2FibGVfaHVicF9wb3dlcl9n
YXRlOwogCWJvb2wgZGlzYWJsZV9kc2NfcG93ZXJfZ2F0ZTsKIAlpbnQgZHNjX21pbl9zbGljZV9o
ZWlnaHRfb3ZlcnJpZGU7CisJYm9vbCBuYXRpdmU0MjJfc3VwcG9ydDsKIAlib29sIGRpc2FibGVf
cHBsaWJfd21fcmFuZ2U7CiAJZW51bSB3bV9yZXBvcnRfbW9kZSBwcGxpYl93bV9yZXBvcnRfbW9k
ZTsKIAl1bnNpZ25lZCBpbnQgbWluX2Rpc3BfY2xrX2toejsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kc2MvZGNfZHNjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZHNjL2RjX2RzYy5jCmluZGV4IGRhYmQzYjdhNGNkYy4uZWM4NmJhNzNhMDM5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZHNjL2RjX2RzYy5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kc2MvZGNfZHNjLmMKQEAgLTI1
LDYgKzI1LDcgQEAKICNpbmNsdWRlICJkY19od190eXBlcy5oIgogI2luY2x1ZGUgImRzYy5oIgog
I2luY2x1ZGUgPGRybS9kcm1fZHBfaGVscGVyLmg+CisjaW5jbHVkZSAiZGMuaCIKIAogc3RydWN0
IGRjX2RzY19wb2xpY3kgewogCWJvb2wgdXNlX21pbl9zbGljZXNfaDsKQEAgLTIzNiw4ICsyMzcs
MTEgQEAgc3RhdGljIHZvaWQgZ2V0X2RzY19lbmNfY2FwcygKIAkvLyBUaGlzIGlzIGEgc3RhdGlj
IEhXIHF1ZXJ5LCBzbyB3ZSBjYW4gdXNlIGFueSBEU0MKIAogCW1lbXNldChkc2NfZW5jX2NhcHMs
IDAsIHNpemVvZihzdHJ1Y3QgZHNjX2VuY19jYXBzKSk7Ci0JaWYgKGRzYykKKwlpZiAoZHNjKSB7
CiAJCWRzYy0+ZnVuY3MtPmRzY19nZXRfZW5jX2NhcHMoZHNjX2VuY19jYXBzLCBwaXhlbF9jbG9j
a18xMDBIeik7CisJCWlmIChkc2MtPmN0eC0+ZGMtPmRlYnVnLm5hdGl2ZTQyMl9zdXBwb3J0KQor
CQkJZHNjX2VuY19jYXBzLT5jb2xvcl9mb3JtYXRzLmJpdHMuWUNCQ1JfTkFUSVZFXzQyMiA9IDE7
CisJfQogfQogCiAvKiBSZXR1cm5zICdmYWxzZScgaWYgbm8gaW50ZXJzZWN0aW9uIHdhcyBmb3Vu
ZCBmb3IgYXQgbGVhc3Qgb25lIGNhcGFibGl0eS4KLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
