Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D680C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 04:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C772068E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 04:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C772068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AD26E388;
	Tue,  3 Dec 2019 04:42:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB3E6E388
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 04:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRuEBA7V6n5KLinPBLr3dLp9zzCOg5O/8EzHd81XdVuPtcrjdDrraCxD0wTpDfiD2A6m8zwVklAhtWEaymUfM44kpf0946gx+CjwTERB+5KtmlgGXwPI8fVtyNWr2cy/lLOaGLMVwk/MmPZAnD58TjZ75VeCihSFLcTtTWS6co8v8iTmnekCyzmp4VKO3iWlhfs7oToQCdcT5HpHuVZB8WTJrUtn7twesQPCpNw5aOXA7k390djevlyeeGmDrUy24AD18DbzYLuQetqthE3pzatAYJPfWeZi4CcGwwnPynpApP6fELcwyY9zHxyQMJhspMWpD8tGygrsb2kFGr2WRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euiJ0OaKpYldhNV28ZIizhSD/TdmvpW5K5Y3hzwYuEI=;
 b=kh9ydEq087LBkUvrKrS19X6OcCfDpTDVgDhUDNoS3Hb9xxJs3JQ/yn0jeaEmx5JYB/uZQcRux2kyCWFmzW3SlLOGFOBN9Qjad4rH1ugFSmpoaBWL4OdP09DGCQ8go48gr64+Y7YaEAVPnj1ex1IAHKpGGDmbzGjWe8bUsrokXq1omrMM92Y+FX2FJc0voMXJnX6go0+D6RHmCC/OKXKW5rQWmpSGlhK3ExF/Uv1SwbsCjjmsvB7Tjy57GVRO8C/ejZLIIsIplulRH/GzmQmiqQ6HTDH7U0ZQGCF7noVAq2Iy0GoDPO2k5kx1qdsga6rmeVsGsaTwDU7F55RhAdcUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0058.namprd12.prod.outlook.com (10.174.104.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 04:42:29 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 04:42:29 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Contain MMHUB number in the implementation
Date: Mon,  2 Dec 2019 23:42:14 -0500
Message-Id: <20191203044215.29605-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4e38b3e-f6f7-4481-6e63-08d777ab3390
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0058:|DM5PR1201MB0058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB005883BD0576593CB3A5F245F0420@DM5PR1201MB0058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(50226002)(8676002)(2351001)(8936002)(81156014)(81166006)(6916009)(305945005)(7736002)(14444005)(86362001)(6666004)(386003)(6506007)(26005)(2616005)(186003)(14454004)(52116002)(478600001)(48376002)(36756003)(6486002)(25786009)(16586007)(316002)(50466002)(99286004)(51416003)(2906002)(5660300002)(3846002)(6116002)(66946007)(66476007)(66556008)(6512007)(2361001)(6436002)(66066001)(4326008)(1076003)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0058;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFXLNmz9g9NkbKd97QdoN8QOap155q6SbL5EOwwJCJi3Vau49m+Ti7/RFuBU2IfSEcdSK39BjYmY0EXktLHuhm2/RnTBOtzFUfYoS4LkTXz4eEq9i3UOq9TL30/WMsbHPFsBx5cTtgUNoJtKZ5tJkCufmcMbKkU7vtyqiTv2PodOoG4/cVJqUiz9mOnrK84dPfPSvvrYCibazjCv86gfVwkAT/MFaG1vZLiEt8bWClHcJovpF+E3Nvi3/7VALO6EQBewbngM1yV8RektEO7GyYDfr/HkEoGqSqJicGbSijiswnOxL6jkT2iF24Ua8Irp8qLV9OxZiQGXgOCloRLNolk1UD6fRffphZ0vTLfgaCJNTtnPKKxKjmXgv69aRYp2oVFpT+7HZJbzJImEOGnTKkGjwN15eu8/+cVLPQ4Nzr1U4/rl09LyvMDC1VD1KZ5F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e38b3e-f6f7-4481-6e63-08d777ab3390
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 04:42:28.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfJ9LoQ98mFtowyzOBNzcHiDPdpsuigQdi0ivZsw0bRTIhsEm4vpf0KDAqzSPNO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0058
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euiJ0OaKpYldhNV28ZIizhSD/TdmvpW5K5Y3hzwYuEI=;
 b=WiTZtZDr7ban7sDL3pHHwM8QllfuSM7M4EUvd2HT7v/rRXJHdo7XAlXVG1Ke9hNVWH4DP+FtnbHXj+XRzbMwKultGlyTcKrWVftS5A4ZGhhS9RGfNsHwN6armrz13D+4OH6fke+4353/XCrD1685UrfwkXL/4xMBPZepBGYl2O0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRqdXN0IHRoZSBleHBvc2VkIGZ1bmN0aW9uIHByb3RvdHlwZSBzbyB0aGF0IHRoZSBjYWxsZXIg
ZG9lcyBub3QgbmVlZAp0byBrbm93IHRoZSBNTUhVQiBudW1iZXIuCgpDaGFuZ2UtSWQ6IEk0NDIw
ZDE3MTU5ODRmNzAzOTU0ZjA3NDY4MmIwNzVmYzU5ZTJhMzMwClNpZ25lZC1vZmYtYnk6IFlvbmcg
WmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyB8ICA2ICsrLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuaCAgICAgICAgICAgICB8ICA4IC0tLS0tLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgICAgICAgICAgIHwgMTMgKysrKysrKysrKystLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5oICAgICAgICAgICB8ICAyICsr
CiA0IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jCmlu
ZGV4IDQ3Yzg1M2VmMTA1MS4uNmYxYTQ2NzZkZGRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMKQEAgLTQwLDcgKzQwLDcgQEAKICNp
bmNsdWRlICJzb2MxNWQuaCIKICNpbmNsdWRlICJtbWh1Yl92MV8wLmgiCiAjaW5jbHVkZSAiZ2Z4
aHViX3YxXzAuaCIKLSNpbmNsdWRlICJnbWNfdjlfMC5oIgorI2luY2x1ZGUgIm1taHViX3Y5XzQu
aCIKIAogCiBlbnVtIGhxZF9kZXF1ZXVlX3JlcXVlc3RfdHlwZSB7CkBAIC03NzQsOSArNzc0LDcg
QEAgdm9pZCBrZ2RfZ2Z4X3Y5X3NldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZShzdHJ1Y3Qg
a2dkX2RldiAqa2dkLCB1aW50MzJfdCB2bWkKIAkgKiBvbiBHRlg4IGFuZCBvbGRlci4KIAkgKi8K
IAlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpIHsKLQkJLyogVHdvIE1NSFVC
cyAqLwotCQltbWh1Yl92OV80X3NldHVwX3ZtX3B0X3JlZ3MoYWRldiwgMCwgdm1pZCwgcGFnZV90
YWJsZV9iYXNlKTsKLQkJbW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKGFkZXYsIDEsIHZtaWQs
IHBhZ2VfdGFibGVfYmFzZSk7CisJCW1taHViX3Y5XzRfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCB2
bWlkLCBwYWdlX3RhYmxlX2Jhc2UpOwogCX0gZWxzZQogCQltbWh1Yl92MV8wX3NldHVwX3ZtX3B0
X3JlZ3MoYWRldiwgdm1pZCwgcGFnZV90YWJsZV9iYXNlKTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192OV8wLmgKaW5kZXggOTcxYzA4NDAzNThmLi40OWU4YmU3NjEyMTQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmgKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuaApAQCAtMzYsMTIgKzM2LDQgQEAKIAogZXh0ZXJu
IGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3MgZ21jX3Y5XzBfaXBfZnVuY3M7CiBleHRlcm4gY29u
c3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIGdtY192OV8wX2lwX2Jsb2NrOwotCi0v
KiBhbWRncHVfYW1ka2ZkKi5jICovCi12b2lkIGdmeGh1Yl92MV8wX3NldHVwX3ZtX3B0X3JlZ3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCi0JCQkJdWludDY0X3Qg
dmFsdWUpOwotdm9pZCBtbWh1Yl92MV8wX3NldHVwX3ZtX3B0X3JlZ3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCi0JCQkJdWludDY0X3QgdmFsdWUpOwotdm9pZCBt
bWh1Yl92OV80X3NldHVwX3ZtX3B0X3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGlu
dCBodWJpZCwKLQkJCQl1aW50MzJfdCB2bWlkLCB1aW50NjRfdCB2YWx1ZSk7CiAjZW5kaWYKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwppbmRleCA4NTk5YmZkYjlhOWUuLjBi
NjIxYmY4YmJkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJf
djlfNC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwpAQCAt
NTQsNyArNTQsNyBAQCB1NjQgbW1odWJfdjlfNF9nZXRfZmJfbG9jYXRpb24oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIGJhc2U7CiB9CiAKLXZvaWQgbW1odWJfdjlfNF9zZXR1
cF92bV9wdF9yZWdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaHViaWQsCitzdGF0
aWMgdm9pZCBtbWh1Yl92OV80X3NldHVwX2h1YmlkX3ZtX3B0X3JlZ3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIGludCBodWJpZCwKIAkJCQl1aW50MzJfdCB2bWlkLCB1aW50NjRfdCB2YWx1
ZSkKIHsKIAkvKiB0d28gcmVnaXN0ZXJzIGRpc3RhbmNlIGJldHdlZW4gbW1WTUwyVkMwX1ZNX0NP
TlRFWFQwXyogdG8KQEAgLTgwLDcgKzgwLDcgQEAgc3RhdGljIHZvaWQgbW1odWJfdjlfNF9pbml0
X2dhcnRfYXBlcnR1cmVfcmVncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIHsKIAl1aW50
NjRfdCBwdF9iYXNlID0gYW1kZ3B1X2dtY19wZF9hZGRyKGFkZXYtPmdhcnQuYm8pOwogCi0JbW1o
dWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKGFkZXYsIGh1YmlkLCAwLCBwdF9iYXNlKTsKKwltbWh1
Yl92OV80X3NldHVwX2h1YmlkX3ZtX3B0X3JlZ3MoYWRldiwgaHViaWQsIDAsIHB0X2Jhc2UpOwog
CiAJV1JFRzMyX1NPQzE1X09GRlNFVChNTUhVQiwgMCwKIAkJCSAgICBtbVZNTDJWQzBfVk1fQ09O
VEVYVDBfUEFHRV9UQUJMRV9TVEFSVF9BRERSX0xPMzIsCkBAIC0xMDEsNiArMTAxLDE1IEBAIHN0
YXRpYyB2b2lkIG1taHViX3Y5XzRfaW5pdF9nYXJ0X2FwZXJ0dXJlX3JlZ3Moc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgKHUzMikoYWRldi0+Z21jLmdhcnRfZW5kID4+IDQ0KSk7
CiB9CiAKK3ZvaWQgbW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAorCQkJCXVpbnQ2NF90IHBhZ2VfdGFibGVfYmFzZSkK
K3sKKwlpbnQgaTsKKwlmb3IgKGkgPSAwOyBpIDwgTU1IVUJfTlVNX0lOU1RBTkNFUzsgaSsrKSB7
CisJCW1taHViX3Y5XzRfc2V0dXBfaHViaWRfdm1fcHRfcmVncyhhZGV2LCBpLCB2bWlkLCBwYWdl
X3RhYmxlX2Jhc2UpOworCX0KK30KKwogc3RhdGljIHZvaWQgbW1odWJfdjlfNF9pbml0X3N5c3Rl
bV9hcGVydHVyZV9yZWdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgICAgICAg
ICBpbnQgaHViaWQpCiB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
bWh1Yl92OV80LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmgKaW5k
ZXggMzU0YTRiN2U4NzViLi4xYjk3OTc3Mzc3NmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tbWh1Yl92OV80LmgKQEAgLTM0LDUgKzM0LDcgQEAgdm9pZCBtbWh1Yl92OV80X2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IG1taHViX3Y5XzRfc2V0X2Nsb2NrZ2F0aW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAgICAgIGVudW0gYW1kX2Nsb2NrZ2F0
aW5nX3N0YXRlIHN0YXRlKTsKIHZvaWQgbW1odWJfdjlfNF9nZXRfY2xvY2tnYXRpbmcoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiAqZmxhZ3MpOwordm9pZCBtbWh1Yl92OV80X3NldHVw
X3ZtX3B0X3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCisJ
CQkJdWludDY0X3QgcGFnZV90YWJsZV9iYXNlKTsKIAogI2VuZGlmCi0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
