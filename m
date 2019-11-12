Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37692C17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EC22067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EC22067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832B06EBB7;
	Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CC36EBB3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noGjKFo/nKr5EUXUudompH7ToXtzqdjG7nk6XgidkOloykMu0YTmBrk/MD0KPdaLgs/vOJ0FRtey9kBAFMToGB6yc/vSLSSBSL3IVcn+834QKcpRrEnQMtHVS4+t5XTjYb6w7xNJUE9pH07T4YWjGDP7Jo6JBLhwa0I08wvl9WONeoVEN9Dv52Qt6SdFCqjvsjN3cEZnwnsgoKwAl3eUyjsUVrel6OwzdcqMyGGQA18Ny4ao7KJ/9xSeTLutzyJ0oU+8zHp1lEUboYgIKQpkN+dv938X/hh2PkHgJylv2M+Tz38wzxTmROSTCknGAKVmz11BTyb+rKtdTRpUEBYZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ASrSdf7efr0PTRNP9U2aJFM+J+Sw9mCOHnwV+SrO7U=;
 b=arsCN3RcNPNcx2FRkSMbvn6eYYX4kDn6gZFWObOLz0wOk1G/tFyFrNfokQ1gmMDW7TbdG/wCC5tH60RlmiqqQRGT3pAVvXcYsQ8WvyoItpY2T0CFmASuJRdtJEzX9wJbLJa4kXzTPdHV1fbkMRLkRzCHSFVlW79f/sto7xW6n2hk7TrFsHaveNjCEk2uyRthyQjEJNh2yaTCldLUhcE/dLGR/aHQUo0mo5X+OTi11j4JrRoYbVzDcPFJwpP1WOpz2/0KIYuUe4CdehF3IhvgpTWM9zHeHPIvEoxDejR6sSmahmXEGYi5EOFPwLtYPV7+3HBdlchDo346fiZVpqxifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:18 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:18 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/21] drm/amdgpu: enable JPEG2.0 for Navi1x and Renoir
Date: Tue, 12 Nov 2019 13:03:26 -0500
Message-Id: <20191112180329.3927-19-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3bc0b2a-96ff-491c-13d4-08d7679abc6c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15809BF219AD5D0EB64FADE3E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkK4W1nUJze+xVoh9b5aAMthj/x7W+8kEfN+S34214E+Oc+uH7x+CgLrKwL0X/lm8zL/7EfGPj+s7qfgzwjgCguXZRd0T+RbNV1UnV3GCzQ9E5GNHVvdFOcmwuMdOawV/CAe/EXEgDQdcQOUzvM+o6qhuCsa7gRiifCohmrV8L1zwHtPTgmzdku7szg6vb3wt59+aH+PX9tIcjDwEfJMVqpUs3CruCUBVJq5SzO6ssGnb5QsFzuBD0JrUKAPY6moW3aLUvympLjlroZPSTvruXZrWUiYN95de70gUMsvGcSW/gSDhOaOd2q8Ron6RRFjR+1gL/aeXz9PpNdPQOnYsLJRWbSBtoGPK2O/5JTuWO19uF7Ih4Q/5FCStPJIh52Wh6xvABgYjHHc4oaLrQSEgBxJ+FdaxNI9naPm16xfA3q1LlNa+FzFVVFxQoSfdHCN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc0b2a-96ff-491c-13d4-08d7679abc6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:18.2367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IxNWsd87ICN+8VAWnH2iQ278FWsO/4XRzTZStMbtNiHBpSdKfDjO5wic45vNM7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ASrSdf7efr0PTRNP9U2aJFM+J+Sw9mCOHnwV+SrO7U=;
 b=fSJ86qa7Xed3zMFlxWVq8g4LcIO38ECMoJMmKv57O4UgxYoaqPCs+aG0kcgess7yYHwbox3VTwV+/qNFzOHl2fGiiFOj4on/IYQybxmK4POyS6aRdRrvXQG+r4e3Loucx8GAH7mmxmptkFcBlYNyIlVaipvAS92JrK5Yan1uYI8=
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
Message-ID: <20191112180326.780uL_z4Zl6jzNuOb5WWtMp6tSyekwsCqV6qv_sBdGw@z>

QnkgYWRkaW5nIEpQRUcgSVAgYmxvY2sgdG8gdGhlIGZhbWlseQoKU2lnbmVkLW9mZi1ieTogTGVv
IExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252
LmMgICAgfCAzICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDIgKysK
IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMK
aW5kZXggN2MxMDY4ZWZlNjUxLi5kMjk4OWU5NDg0YmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYu
YwpAQCAtNTIsNiArNTIsNyBAQAogI2luY2x1ZGUgImdmeF92MTBfMC5oIgogI2luY2x1ZGUgInNk
bWFfdjVfMC5oIgogI2luY2x1ZGUgInZjbl92Ml8wLmgiCisjaW5jbHVkZSAianBlZ192Ml8wLmgi
CiAjaW5jbHVkZSAiZGNlX3ZpcnR1YWwuaCIKICNpbmNsdWRlICJtZXNfdjEwXzEuaCIKICNpbmNs
dWRlICJteGdwdV9udi5oIgpAQCAtNDU2LDYgKzQ1Nyw3IEBAIGludCBudl9zZXRfaXBfYmxvY2tz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQkgICAgaXNfc3VwcG9ydF9zd19zbXUoYWRl
dikgJiYgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkKIAkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tf
YWRkKGFkZXYsICZzbXVfdjExXzBfaXBfYmxvY2spOwogCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2Nr
X2FkZChhZGV2LCAmdmNuX3YyXzBfaXBfYmxvY2spOworCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2Nr
X2FkZChhZGV2LCAmanBlZ192Ml8wX2lwX2Jsb2NrKTsKIAkJaWYgKGFkZXYtPmVuYWJsZV9tZXMp
CiAJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmbWVzX3YxMF8xX2lwX2Jsb2Nr
KTsKIAkJYnJlYWs7CkBAIC00NzksNiArNDgxLDcgQEAgaW50IG52X3NldF9pcF9ibG9ja3Moc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCSAgICBpc19zdXBwb3J0X3N3X3NtdShhZGV2KSAm
JiAhYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQo
YWRldiwgJnNtdV92MTFfMF9pcF9ibG9jayk7CiAJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRk
KGFkZXYsICZ2Y25fdjJfMF9pcF9ibG9jayk7CisJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRk
KGFkZXYsICZqcGVnX3YyXzBfaXBfYmxvY2spOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXR1
cm4gLUVJTlZBTDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDBjMzZjYjc4NDAw
OS4uZjM5NzdhYmJkMWUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTY3LDYg
KzY3LDcgQEAKICNpbmNsdWRlICJ2Y2VfdjRfMC5oIgogI2luY2x1ZGUgInZjbl92MV8wLmgiCiAj
aW5jbHVkZSAidmNuX3YyXzAuaCIKKyNpbmNsdWRlICJqcGVnX3YyXzAuaCIKICNpbmNsdWRlICJ2
Y25fdjJfNS5oIgogI2luY2x1ZGUgImRjZV92aXJ0dWFsLmgiCiAjaW5jbHVkZSAibXhncHVfYWku
aCIKQEAgLTgyMSw2ICs4MjIsNyBAQCBpbnQgc29jMTVfc2V0X2lwX2Jsb2NrcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vf
aXBfYmxvY2tfYWRkKGFkZXYsICZkbV9pcF9ibG9jayk7CiAjZW5kaWYKIAkJYW1kZ3B1X2Rldmlj
ZV9pcF9ibG9ja19hZGQoYWRldiwgJnZjbl92Ml8wX2lwX2Jsb2NrKTsKKwkJYW1kZ3B1X2Rldmlj
ZV9pcF9ibG9ja19hZGQoYWRldiwgJmpwZWdfdjJfMF9pcF9ibG9jayk7CiAJCWJyZWFrOwogCWRl
ZmF1bHQ6CiAJCXJldHVybiAtRUlOVkFMOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
