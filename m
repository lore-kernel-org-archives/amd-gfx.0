Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40279C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063DF21929
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063DF21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03716E14B;
	Tue,  5 Nov 2019 22:03:23 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730070.outbound.protection.outlook.com [40.107.73.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7246E14B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 22:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAM2r4mElZTb+X3ttYLNwtuXdU6KakxNRBpI3qoq5gho87XVkyC0Po9KfpdHAlnGAAunkf3crI9I88Qc0XLR2Vo1K9RNv0LUMUXNCLO6wEnP4SfcVxTEzGGEQMDfsvqURTwAlm6w4B4VC48Ni804QI0Q08ZSUvwBYVmf4CgJL1tzqR7Mg2LG7jx+UQZ7oq3wJ0FQ2oa9lrpWx3yh6EirhnKw7L9t/VJjTT9sMsmvVYh81s05SALpu8ldWqG1PrdxonM326Hnm/+/xldg/+UQl1wtwypfUpUbfOWzETR5bf5TRI4+JIqVV8BbZmgGrV6kpEzuQe/ten4tP9ERvNXm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vna6WymmxJa2J46A7bpDLNY/vlFj740mAjj/tQGPLAk=;
 b=E4jW3DX8p6ST4UccBybO7VKEhoJOA4W8QU9KXMeyVqjP1mp7wp7KBzmh8DhEWJM6OT+fW7LlWz9WTQN1oh8sKQv9DRleVnZys6EaI3bl0X+iiBBwYcLVGi/rt9VS9abM92rC9KOsyNEwAIN03aQXSbEM3QE411nyjEJVKn2ZbIQ+aO61hC2tpJTwWVXYxi/Oih17mscGLtPgxNrTz0LByw0JdhFrtW0tUTx5FuRdfU0c+mLozSI21p4WFrGCNDZbGsHClIqxZSe4HOyFkONrYbO4B7XzGapb0H+w1jq/hYHwIPWN5IaHkJEvLfSuvuofxXkciT5Zyc0jtxseOUktMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1159.namprd12.prod.outlook.com (10.168.163.145) by
 CY4PR12MB1543.namprd12.prod.outlook.com (10.172.70.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 22:03:19 +0000
Received: from CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::cde1:b263:67e2:94]) by CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::cde1:b263:67e2:94%2]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 22:03:19 +0000
From: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCTVx9bG9gJ+/E2S0FH9h0Ut0Q==
Date: Tue, 5 Nov 2019 22:03:19 +0000
Message-ID: <1572991381-19907-1-git-send-email-JinhuiEric.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To CY4PR12MB1159.namprd12.prod.outlook.com
 (2603:10b6:903:36::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df9a44b2-6eb9-4069-8d13-08d7623bf76c
x-ms-traffictypediagnostic: CY4PR12MB1543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1543807FECE7785E2908712C827E0@CY4PR12MB1543.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(189003)(199004)(86362001)(5660300002)(186003)(4326008)(386003)(6506007)(5640700003)(99286004)(6512007)(2616005)(6116002)(3846002)(36756003)(14454004)(25786009)(66556008)(8676002)(52116002)(486006)(81156014)(6916009)(316002)(102836004)(8936002)(305945005)(7736002)(2501003)(66066001)(66946007)(26005)(64756008)(2906002)(71190400001)(478600001)(71200400001)(81166006)(50226002)(66446008)(256004)(6436002)(14444005)(2351001)(66476007)(6486002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1543;
 H:CY4PR12MB1159.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBhxEAYIgQr35bp9hokmExgvOnxX6fGTCnV6tMBKO2UPyLUzZ02XiRxoLmZUQm3CUr5I5Uam/t57HMa9NNi+Z0HrmQa2lVQ/uuS/mkqfomQ5JSyswevTYycmcLsQ24hSW/dSDsHVXtlB0JaeaWEYytHpmO7t+0yYBpmLEni82FudK3kR83lVfuxIYs7KYT68kbASg5f5XSR3NYUR2t9CX2ykWWMwHUK28jTGCb+Pm/WsrjZtksH/fR1Im9XheJ9PpHHV1jVqJCwxc6jDQioHSyn2N8RufX1QwHhnz4tK6fvLBwkXQBWmdFSAx9b9t5mr9TFyOkA0gk8pccG/8t24LNqK2TK6M5m4wy25c3EhjfniUGi+SkZVgnd50HFenPr785/SxINabQvSpACsLP6ydNpwLR+SG6hz+RhRfaOZGTz76qTC+Ynjpwcs9R4pc3lB
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9a44b2-6eb9-4069-8d13-08d7623bf76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 22:03:19.2472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTeGeuQ2J0YAG+IStHFVN1L6jaHGvxrn1zjNv7uCjmVk685qIL07dNeh1WTHsw1GuDXJLDaWlF4arib3Cxti8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1543
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vna6WymmxJa2J46A7bpDLNY/vlFj740mAjj/tQGPLAk=;
 b=A7RYhp5ki51JjW7ZwFkWIvFqU2itMWC89o/07yXeVeb2UBhvQQH5T0E9+gMN+B1d1HLa/Yim7QzFvNtWh3K1kqnMw2isX9tT+1w4epWbtBOlwRzvjlXCMSOhbaOgLrZlnDUYnMfSMrQHHtLEe/JtlkhUL3zAXDzxwJqnO0L+5a0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=JinHuiEric.Huang@amd.com; 
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105220319.u-SE4d7jM6qxgNHqYdpET24dVOpiXTiAe77YRkZlmM4@z>

VXNpbmcgdW5pZmllZCBWQklPUyBoYXMgcGVyZm9ybWFuY2UgZHJvcCBpbiBzcmlvdiBlbnZpcm9u
bWVudC4KVGhlIGZpeCBpcyBzd2l0Y2hpbmcgdG8gYW5vdGhlciByZWdpc3RlciBpbnN0ZWFkLgoK
U2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8SmluaHVpRXJpYy5IdWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxOCArKysrKysrKysrKysr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDgyOWQ2MjMuLjY3NzBiZDEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtMzg4NSw5ICszODg1LDIx
IEBAIHN0YXRpYyB1aW50NjRfdCBnZnhfdjlfMF9nZXRfZ3B1X2Nsb2NrX2NvdW50ZXIoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJdWludDY0X3QgY2xvY2s7CiAKIAltdXRleF9sb2NrKCZh
ZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4KTsKLQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NB
UFRVUkVfR1BVX0NMT0NLX0NPVU5ULCAxKTsKLQljbG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09D
MTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VOVF9MU0IpIHwKLQkJKCh1aW50NjRfdClSUkVH
MzJfU09DMTUoR0MsIDAsIG1tUkxDX0dQVV9DTE9DS19DT1VOVF9NU0IpIDw8IDMyVUxMKTsKKwlp
ZiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEwICYmIGFtZGdwdV9zcmlvdl9ydW50aW1l
KGFkZXYpKSB7CisJCXVpbnQzMl90IHRtcCwgbHNiLCBtc2IsIGkgPSAwOworCQlkbyB7CisJCQl0
bXAgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1JFRkNMT0NLX1RJTUVTVEFNUF9NU0IpOwor
CQkJbHNiID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19SRUZDTE9DS19USU1FU1RBTVBfTFNC
KTsKKwkJCW1zYiA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfUkVGQ0xPQ0tfVElNRVNUQU1Q
X01TQik7CisJCQlpKys7CisJCQl1ZGVsYXkoMSk7CisJCX0gd2hpbGUgKHVubGlrZWx5KHRtcCAh
PSBtc2IpICYmIChpIDwgYWRldi0+dXNlY190aW1lb3V0KSk7CisJCWNsb2NrID0gKHVpbnQ2NF90
KWxzYiB8ICgodWludDY0X3QpbXNiIDw8IDMyVUxMKTsKKwl9IGVsc2UgeworCQlXUkVHMzJfU09D
MTUoR0MsIDAsIG1tUkxDX0NBUFRVUkVfR1BVX0NMT0NLX0NPVU5ULCAxKTsKKwkJY2xvY2sgPSAo
dWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTFNCKSB8
CisJCQkoKHVpbnQ2NF90KVJSRUczMl9TT0MxNShHQywgMCwgbW1STENfR1BVX0NMT0NLX0NPVU5U
X01TQikgPDwgMzJVTEwpOworCX0KIAltdXRleF91bmxvY2soJmFkZXYtPmdmeC5ncHVfY2xvY2tf
bXV0ZXgpOwogCXJldHVybiBjbG9jazsKIH0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
