Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B2C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFB62184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFB62184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27FA96EA3B;
	Tue, 12 Nov 2019 00:34:44 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800083.outbound.protection.outlook.com [40.107.80.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD736EA3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRRwlN1SESfdd9vB2aigXI1SLeG8keWU1stLa2YLsCrRaQ1C7Twtkup/rNP/Zr1r/8Gw4XNhavRsIuXbuPuFLC7gpupT2+Q1K6Zd0MwGU8qqNnC/JnM8uJK2VGlmK/B0qPqDvs6KgRCKaF8AJPKpNgBpJmlGPKWfO2LmM2lCs2YNFh8fycmXA5gk7A/PHLfAcUd9zb4E917yufxgmVk9xol1V45Bg7e3CsmRMzNvkmxxHgIQ/k1Mr02rUWhx3zxzatWb5cUhdi9bqI5MmbUVGzE/cy9/kkYn5FNvER5DSqIiqMx2jaIZhySLz9ItCBXG4bSGb5x3uGlCWQA1naXTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3pzoxmg+J6Yk4HVliK5SP9+8IQc2rp8Hdn47iI1Xh8=;
 b=jfeulNrKa/cD1r/qQM33VWkSk3imSKox9hpgrnZnLjSy7rAGA2XSbo2AJvfNt1Ise0B5fC7OP38v7jjr0ZvFhoMJhT1rp3toK5idKn5V1xzplTaNoOFtqBulX2q7Gl8eTtOmJAYQrudr+50Sqh7GWtvXcikb3GdQ5ulZyu6pRcByOOdDCuWpKgTeJBB4Hqqv7T2LcILzNmiKRtu1Ze7Ye6j1pib7t+th3dZ1L7Dshd2qZSk7gNWS05AO5ZafCoZ0qyTd9RXJeQuffPfuMHUyzDU0vVA+yB6zWmwxzT+/kTX2V5UzAxzqwPQ5dmCbieheNUfGb7aahdwbvB1//FdI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2572.namprd12.prod.outlook.com (52.132.181.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/30] drm/amd/display: Add Navi10 DMUB VBIOS code
Date: Mon, 11 Nov 2019 19:33:24 -0500
Message-Id: <20191112003324.8419-31-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f2ef7be-3d2f-481f-14aa-08d767080663
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257202FF48AB036DC1F9426398770@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(6512007)(99286004)(76176011)(6506007)(386003)(52116002)(51416003)(66066001)(66946007)(66556008)(5660300002)(47776003)(36756003)(6436002)(305945005)(6486002)(7736002)(48376002)(66476007)(54906003)(50466002)(6116002)(3846002)(478600001)(6916009)(2906002)(14454004)(2361001)(186003)(25786009)(316002)(86362001)(50226002)(2351001)(8676002)(2870700001)(26005)(2616005)(1076003)(81156014)(81166006)(8936002)(11346002)(476003)(446003)(6666004)(486006)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRjuXj2OU4UTy4nPxuXm6Y3eIAIa2EFeVPMLO5HEzLAv8V4t2JLLjs3DdP9vHtJ4uM0vFhWSk0NVMIKOv4c0jyHsijo19yvthAVmwO0oxQSwgYUc3gNFuWFGrUy9wPDjykQtfGUiv7DC/Q1yVO0ml09v6qdrGTbQX8QKKI+4Fnn5CRb0r4dGcPJYVlw3mjNYgS1UNMjHCnLJkB1KoN2E/A1IWXmQDZOW7tU7Mz5ZvXl2ewt82lhRzdqGYWJXbwKMb5J5GCmZ+mEqSUrxuSupwKa1E+eYvLdziuTVeblJV/YLalPjwRIYv7s2ZBKAFcnhSibYPOr0mo3NAnq/BcuWM6o6NjlHBuDsofpC1Z2LYS74dJvAA9JQIMJpeHR2FIAra9Bam/zNDMXSAt38TRdSLQ7jANOhH8qLIwSzIvSMUeOsagXl16zVk3JF5wePsmKg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2ef7be-3d2f-481f-14aa-08d767080663
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:34:06.3738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbH/mK46hJV7NE7r8Q/VSMougtTsYkAma1EHz90rjupRgAd3aIYB9RsKZM9Lxx/Xb2A4rmHStuC29JkmPIzSOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3pzoxmg+J6Yk4HVliK5SP9+8IQc2rp8Hdn47iI1Xh8=;
 b=DjzWm3eQ6zBYCCSgkWzFBXzLN/HrTOrm5ce4yBlAHZrSeNiXyMVgmTQgpGKCFwdMkcDx0EqTQ6ErsQgl/rRNXPrSJy4SRMzRsAKafZ/Ip8ZCGUvHpppC5VSU6MWM59LMey0jBK1weo/WM1lBr7ZpP3GEYpFoqvlbNbR0P22q6ao=
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
Cc: Tony Cheng <Tony.Cheng@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Xiong Yan <Xiong.Yan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003324.whdgcPYuX_kqSftKHmWW82stI-U1gkRj_uTOewEy2NQ@z>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KV2UgbmVlZCBzb21lIGV4dHJhIGRtdWJfY21kX3R5cGUgZm9yIE5WMTAKCltIb3ddCkFk
ZCBjb21tYW5kIHRhYmxlIGZ1bmN0aW9ucyBpbiBETVVCIGZpcm13YXJlLgoKU2lnbmVkLW9mZi1i
eTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBYaW9uZyBZYW4gPFhpb25nLllhbkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9u
eSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogTmljaG9sYXMgS2F6bGF1c2th
cyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWly
YSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kbXViL2luYy9kbXViX2NtZC5oIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvaW5jL2RtdWJfY21kLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11
Yi9pbmMvZG11Yl9jbWQuaAppbmRleCBiMjVmOTJlMzI4MGQuLjQzZjFjZDY0N2FhYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfY21kLmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfY21kLmgKQEAgLTQ1
LDYgKzQ1LDE3IEBAIGVudW0gZG11Yl9jbWRfdHlwZSB7CiAJRE1VQl9DTURfX0VOQUJMRV9ESVNQ
X1BPV0VSX0dBVElORywKIAlETVVCX0NNRF9fRFBQSFlfSU5JVCwKIAlETVVCX0NNRF9fRElHMV9U
UkFOU01JVFRFUl9DT05UUk9MLAorCURNVUJfQ01EX19TRVRVUF9ESVNQTEFZX01PREUsCisJRE1V
Ql9DTURfX0JMQU5LX0NSVEMsCisJRE1VQl9DTURfX0VOQUJMRV9ESVNQUEFUSCwKKwlETVVCX0NN
RF9fRElTQUJMRV9ESVNQUEFUSCwKKwlETVVCX0NNRF9fRElTQUJMRV9ESVNQUEFUSF9PVVRQVVQs
CisJRE1VQl9DTURfX1JFQURfRElTUFBBVEhfRURJRCwKKwlETVVCX0NNRF9fRFBfUFJFX0xJTktU
UkFJTklORywKKwlETVVCX0NNRF9fSU5JVF9DT05UUk9MTEVSLAorCURNVUJfQ01EX19SRVNFVF9D
T05UUk9MTEVSLAorCURNVUJfQ01EX19TRVRfQlJJX0xFVkVMLAorCURNVUJfQ01EX19MVlRNQV9D
T05UUk9MLAogCiAJLy8gUFNSCiAJRE1VQl9DTURfX1BTUl9FTkFCTEUsCi0tIAoyLjI0LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
