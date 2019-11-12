Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408BBC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237B22067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237B22067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5FE36EBAC;
	Tue, 12 Nov 2019 18:04:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAB46EBB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYGCz7zPu4ACkPxnogn1RUzB4WulMoBKL09hOsoBj3iQhaRnuPLVAjqo+eP8qiPeVrIYYyaJtYownDLz9evGslqOwFFZUbROLw4a99WOHb378gZnu8r5Pvyibv+6E/9pwFLXkjQ6F1H/oXyUXw5GZwXK/mtwsAcU9AQppi2b4W9kkBO1poHvsDvPnI5sYTbkxEw1kA4no6nERlaaPXclE164IZa3FKlilJcU/mOsDWkUf3HOnMX4/JoWOWBZXj4qdjKIHfdB5W2bsSgIZFIb1pEPrh1xWdn7JgSZnFMrEMN393uiYsVC5efSnOzEcTBLbm8CL2YwZI2hyHAYSrh6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IPjPj0/4IteMr56+BScE7iO5fqVNCQcbz1CmoTA4w0=;
 b=DLob4QtczmFwdIC0bxuStXYms/sYPgccdLRAaG2VnYj0wqKY9SNjoIrkiJOhVOFMqjn0N92IbJuIy6amqOBrLv7NPSdJkHsWCwjGAcfuVKvCxYKDOn8LlBtWHuh481Ys9zZkQVKTbRybPZWW/b64ig0QTOHThlcNH/SM1UMKw1c/OUbQgvgsiTjqmg5lRGkpgWKrrTReqR5HwhwLPq3UCT5m6FZgqqPxSDXl93TA1cNETniTKHByFa9AofsnblOqFf8kSAKK/MOWUyN8rwtKQfdcX95xsf7EKXLG0jknapn/OmpWbNRHQM3T8IMiseraynI8KMj/6+LzoFTOe8gC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:19 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:19 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/21] drm/amdgpu: enable Arcturus CG for VCN and JPEG blocks
Date: Tue, 12 Nov 2019 13:03:28 -0500
Message-Id: <20191112180329.3927-21-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0111ba4-abb7-42f2-8336-08d7679abd2e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1580ECB4FDD74570823C3D31E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(4744005)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(14444005)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bw4nUMWU0LX/jcMG3AtQlMO6DWirYzg5aE3YsvMn7uIegjM7de3k1cYrjuakXFhDdVU0N+FHEcyQUk/cbwYJ4IaMMtOqlgiGxx7nvt/OfC8roG0walcbhCln06wbJcIXXQyjOi+uYA2EIOh0iyQxtA+g/z+W3qAMdAsF2nsWnUNYXkoSAE2YJx2j4VlV3q6/KS0VGdmW5rDgVyj+7+lE0/9DrT7hw33YrT71EtUUQEPeItMod2d7fqJxhps+MjQjaUDeISrSTgSBKUhf1yJef+k6H1/ros/E/4YaBKzc+PRE/h29ObJcxXb/HSd+ZI9iRbccreSawIlyAPFm6pzqE870nboRKKvkOs6LnTmYP5+GnIdF24NKT98Jeq+HqIalkcyF/ja87MuD6+3lDFHJS4z6KC5jeL16KqcdUd7kwfO2W9KT8T9t13ariD6ScO32
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0111ba4-abb7-42f2-8336-08d7679abd2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:19.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuMg2XOWWkI0LQBy6oxCiEYuv58zD76YzYR115ioHjSe3qJjee1nnJ4UJiePNUd8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IPjPj0/4IteMr56+BScE7iO5fqVNCQcbz1CmoTA4w0=;
 b=1LbU/fxAxqG0Qjsee6fmWu4hJVnkMiQOenWm+K3DMd5mSOt0D1BUq5iOA6CG+f7/Xol1RTZDlBbV1Hp3dec8CaopbeFUrvfEqnoC7rrBCi/aAIWarqo52v1UZn9S9XT4EaUeypdyyXtKiJoQsOavePB8PSoiHnzHHS/Ft1V81Ds=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180328.BFzuiMDIiAlIw-KE38LYzZCWz0k62MWY42ZYyy48sCc@z>

QXJjdHVydXMgVkNOIGFuZCBKUEVHIG9ubHkgZ290IENHIHN1cHBvcnQsIGFuZCBubyBQRyBzdXBw
b3J0CgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
CmluZGV4IGYzOTc3YWJiZDFlMi4uYjQwNGI3YTZlNTkzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMKQEAgLTEyMTAsNyArMTIxMCw5IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2Vh
cmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9MUyB8CiAJCQlB
TURfQ0dfU1VQUE9SVF9NQ19NR0NHIHwKIAkJCUFNRF9DR19TVVBQT1JUX01DX0xTIHwKLQkJCUFN
RF9DR19TVVBQT1JUX0lIX0NHOworCQkJQU1EX0NHX1NVUFBPUlRfSUhfQ0cgfAorCQkJQU1EX0NH
X1NVUFBPUlRfVkNOX01HQ0cgfAorCQkJQU1EX0NHX1NVUFBPUlRfSlBFR19NR0NHOwogCQlhZGV2
LT5wZ19mbGFncyA9IDA7CiAJCWFkZXYtPmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJldl9pZCAr
IDB4MzI7CiAJCWJyZWFrOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
