Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA6C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E06F20722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E06F20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B226E2F8;
	Tue, 26 Nov 2019 11:50:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738EC6E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 11:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbeLfQvyWJ1reAwx6izhVTybGpZCWYae5XxbUwpqmFKzAz3J4XjGtEigHlRYYZgFM+3UhM7as2mJ2WLUf+hItdhjV26ONAT39a1dmBYvti+SclYj256HOktkXnD/+dlbgRbZaJtKL9AyG18mC/URi1QfbXw82faV3SspTatr+MtJy4cPJQ7BensGxI0j0ZbUjSxqx3G7xRcuk6YrCP8eWz/cYpYp1oyMV23bIADLtEbSafNYnPXMuLwBoOfW3YqecbOe7dekVkQ/tYhR6TfUZjdlig6cfR3vCqyOuRCPVfflHhVYqmuwXpXXWuIJQ3nPRpoLQsQBZN1fB2ENRl7TtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbaGXdbM7esHmrms+kXv7M+4t3sEYLO7Hprc4wZ5QPQ=;
 b=Iq7qP4491dujdcY1jCW2xqYraVwS/KKvchjRcEfZ+2B5dE4br5yu4i1MkF8mPhiXu5SY4LM50usZyWGqIcXASJ1F1KhJbVjma0mzrhb+BbL4ETZzzuHSj9qFNvtgFNrGQgaTDILW4YDChsw9r9HzHTSyeBMp3hWd1YZwuXSlTzO8jDTDi29kQ82rIFjoGDVfA/yy4dbvEcRDaw2gf7S8OxGZ92OgKcXVMZAKtPCG7B5CNOfSQdkm3X3k0rCA/iK9TK/0BKyl7ZM5TOm1Su1oVRvo9zK+2NFZorfNv66Nya6map7wnEgYEovi223rMiir777RbqfY/e5Da01qxi4WQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:405:4c::20) by CH2PR12MB3750.namprd12.prod.outlook.com
 (2603:10b6:610:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 11:50:35 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by BN6PR1201CA0010.outlook.office365.com
 (2603:10b6:405:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 11:50:35 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 26 Nov 2019 11:50:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:34 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:34 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 26 Nov 2019 05:50:33 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: skip rlc ucode loading for SRIOV gfx10
Date: Tue, 26 Nov 2019 19:50:21 +0800
Message-ID: <1574769024-30611-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(428003)(199004)(189003)(356004)(6666004)(2906002)(86362001)(336012)(305945005)(2351001)(50226002)(81156014)(8676002)(16586007)(26005)(47776003)(5660300002)(186003)(14444005)(53416004)(8936002)(11346002)(426003)(316002)(446003)(2616005)(7696005)(76176011)(81166006)(70206006)(51416003)(50466002)(36756003)(48376002)(4326008)(6916009)(478600001)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3750; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b2f9fa2-9848-40ff-1daf-08d77266d948
X-MS-TrafficTypeDiagnostic: CH2PR12MB3750:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37503257BA279260684E498984450@CH2PR12MB3750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 0233768B38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vPps4uK4FEMqvoOnkW6bs5tyJVbBVGbFtZnwVuh/+dHWocJSfqmW2awqOrJT6EP/TzLzyWzxZ41LwwgnQRK+bY8Z93RXJBjRRZ6QZ8N3nAWjMkfoehNG/8JTCk6Y8YKLBm2qfP8AQjn5fQ14Wyy2zuvdptuYHHA+fW0cuh8BlSMIRYd7+X9Knfl+0viiaEHe0qZeht1KKSZfetr/mrnnsXQv0evXYMJbv7PXnFJw6xJPQy8gpwI7J3uWqsi8GRCGfXGhu5tCd4asBTQbx2e0lJwWpuSV1LSromiz5i/ER46iGW+NTrbHT3WneNdcHoMH42ebIgbMUFy6kYx/89NvyXbareiACm5zpVf6LouFH3a5iqpnECeXE40ee3bjS0VEjq4g2w4zGHTCaJ0d4TzhMINs7aj+9bs0Xiy2m5HAaA/RGYumxldnH7GnwJYwjSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 11:50:35.2216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2f9fa2-9848-40ff-1daf-08d77266d948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbaGXdbM7esHmrms+kXv7M+4t3sEYLO7Hprc4wZ5QPQ=;
 b=BFgM+/5TEOhnD1lX1W/PLbfxhBElTLZWvVL2JCE7P4TIBI27SdNCKR94+J2cKoVVH4lxlRTqoR26yKbRSSptn6GVykryhiuILKoej8TSLtN/I3jV08BDsJkeg6KjMBSWF4GPof4tvlHCMQcUDt1kbvBNRelc60i5CIF3in9Ab7U=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126115021.I_s-9E6Er4wtaY2fTTkD3fEqs91N4lGTz25uFqlhUl0@z>

U2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCA4MCArKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMzkgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCA4NzljMGEx
Li5hNTZjYmE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtNjkx
LDU5ICs2OTEsNjEgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9taWNyb2NvZGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJYWRldi0+Z2Z4LmNlX2Z3X3ZlcnNpb24gPSBsZTMyX3Rv
X2NwdShjcF9oZHItPmhlYWRlci51Y29kZV92ZXJzaW9uKTsKIAlhZGV2LT5nZnguY2VfZmVhdHVy
ZV92ZXJzaW9uID0gbGUzMl90b19jcHUoY3BfaGRyLT51Y29kZV9mZWF0dXJlX3ZlcnNpb24pOwog
Ci0Jc25wcmludGYoZndfbmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3JsYy5iaW4i
LCBjaGlwX25hbWUpOwotCWVyciA9IHJlcXVlc3RfZmlybXdhcmUoJmFkZXYtPmdmeC5ybGNfZncs
IGZ3X25hbWUsIGFkZXYtPmRldik7Ci0JaWYgKGVycikKLQkJZ290byBvdXQ7Ci0JZXJyID0gYW1k
Z3B1X3Vjb2RlX3ZhbGlkYXRlKGFkZXYtPmdmeC5ybGNfZncpOwotCXJsY19oZHIgPSAoY29uc3Qg
c3RydWN0IHJsY19maXJtd2FyZV9oZWFkZXJfdjJfMCAqKWFkZXYtPmdmeC5ybGNfZnctPmRhdGE7
Ci0JdmVyc2lvbl9tYWpvciA9IGxlMTZfdG9fY3B1KHJsY19oZHItPmhlYWRlci5oZWFkZXJfdmVy
c2lvbl9tYWpvcik7Ci0JdmVyc2lvbl9taW5vciA9IGxlMTZfdG9fY3B1KHJsY19oZHItPmhlYWRl
ci5oZWFkZXJfdmVyc2lvbl9taW5vcik7Ci0JaWYgKHZlcnNpb25fbWFqb3IgPT0gMiAmJiB2ZXJz
aW9uX21pbm9yID09IDEpCi0JCWFkZXYtPmdmeC5ybGMuaXNfcmxjX3YyXzEgPSB0cnVlOwotCi0J
YWRldi0+Z2Z4LnJsY19md192ZXJzaW9uID0gbGUzMl90b19jcHUocmxjX2hkci0+aGVhZGVyLnVj
b2RlX3ZlcnNpb24pOwotCWFkZXYtPmdmeC5ybGNfZmVhdHVyZV92ZXJzaW9uID0gbGUzMl90b19j
cHUocmxjX2hkci0+dWNvZGVfZmVhdHVyZV92ZXJzaW9uKTsKLQlhZGV2LT5nZngucmxjLnNhdmVf
YW5kX3Jlc3RvcmVfb2Zmc2V0ID0KKwlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQlz
bnByaW50Zihmd19uYW1lLCBzaXplb2YoZndfbmFtZSksICJhbWRncHUvJXNfcmxjLmJpbiIsIGNo
aXBfbmFtZSk7CisJCWVyciA9IHJlcXVlc3RfZmlybXdhcmUoJmFkZXYtPmdmeC5ybGNfZncsIGZ3
X25hbWUsIGFkZXYtPmRldik7CisJCWlmIChlcnIpCisJCQlnb3RvIG91dDsKKwkJZXJyID0gYW1k
Z3B1X3Vjb2RlX3ZhbGlkYXRlKGFkZXYtPmdmeC5ybGNfZncpOworCQlybGNfaGRyID0gKGNvbnN0
IHN0cnVjdCBybGNfZmlybXdhcmVfaGVhZGVyX3YyXzAgKilhZGV2LT5nZngucmxjX2Z3LT5kYXRh
OworCQl2ZXJzaW9uX21ham9yID0gbGUxNl90b19jcHUocmxjX2hkci0+aGVhZGVyLmhlYWRlcl92
ZXJzaW9uX21ham9yKTsKKwkJdmVyc2lvbl9taW5vciA9IGxlMTZfdG9fY3B1KHJsY19oZHItPmhl
YWRlci5oZWFkZXJfdmVyc2lvbl9taW5vcik7CisJCWlmICh2ZXJzaW9uX21ham9yID09IDIgJiYg
dmVyc2lvbl9taW5vciA9PSAxKQorCQkJYWRldi0+Z2Z4LnJsYy5pc19ybGNfdjJfMSA9IHRydWU7
CisKKwkJYWRldi0+Z2Z4LnJsY19md192ZXJzaW9uID0gbGUzMl90b19jcHUocmxjX2hkci0+aGVh
ZGVyLnVjb2RlX3ZlcnNpb24pOworCQlhZGV2LT5nZngucmxjX2ZlYXR1cmVfdmVyc2lvbiA9IGxl
MzJfdG9fY3B1KHJsY19oZHItPnVjb2RlX2ZlYXR1cmVfdmVyc2lvbik7CisJCWFkZXYtPmdmeC5y
bGMuc2F2ZV9hbmRfcmVzdG9yZV9vZmZzZXQgPQogCQkJbGUzMl90b19jcHUocmxjX2hkci0+c2F2
ZV9hbmRfcmVzdG9yZV9vZmZzZXQpOwotCWFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfZGVzY3Jp
cHRvcl9vZmZzZXQgPQorCQlhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX2Rlc2NyaXB0b3Jfb2Zm
c2V0ID0KIAkJCWxlMzJfdG9fY3B1KHJsY19oZHItPmNsZWFyX3N0YXRlX2Rlc2NyaXB0b3Jfb2Zm
c2V0KTsKLQlhZGV2LT5nZngucmxjLmF2YWlsX3NjcmF0Y2hfcmFtX2xvY2F0aW9ucyA9CisJCWFk
ZXYtPmdmeC5ybGMuYXZhaWxfc2NyYXRjaF9yYW1fbG9jYXRpb25zID0KIAkJCWxlMzJfdG9fY3B1
KHJsY19oZHItPmF2YWlsX3NjcmF0Y2hfcmFtX2xvY2F0aW9ucyk7Ci0JYWRldi0+Z2Z4LnJsYy5y
ZWdfcmVzdG9yZV9saXN0X3NpemUgPQorCQlhZGV2LT5nZngucmxjLnJlZ19yZXN0b3JlX2xpc3Rf
c2l6ZSA9CiAJCQlsZTMyX3RvX2NwdShybGNfaGRyLT5yZWdfcmVzdG9yZV9saXN0X3NpemUpOwot
CWFkZXYtPmdmeC5ybGMucmVnX2xpc3RfZm9ybWF0X3N0YXJ0ID0KKwkJYWRldi0+Z2Z4LnJsYy5y
ZWdfbGlzdF9mb3JtYXRfc3RhcnQgPQogCQkJbGUzMl90b19jcHUocmxjX2hkci0+cmVnX2xpc3Rf
Zm9ybWF0X3N0YXJ0KTsKLQlhZGV2LT5nZngucmxjLnJlZ19saXN0X2Zvcm1hdF9zZXBhcmF0ZV9z
dGFydCA9CisJCWFkZXYtPmdmeC5ybGMucmVnX2xpc3RfZm9ybWF0X3NlcGFyYXRlX3N0YXJ0ID0K
IAkJCWxlMzJfdG9fY3B1KHJsY19oZHItPnJlZ19saXN0X2Zvcm1hdF9zZXBhcmF0ZV9zdGFydCk7
Ci0JYWRldi0+Z2Z4LnJsYy5zdGFydGluZ19vZmZzZXRzX3N0YXJ0ID0KKwkJYWRldi0+Z2Z4LnJs
Yy5zdGFydGluZ19vZmZzZXRzX3N0YXJ0ID0KIAkJCWxlMzJfdG9fY3B1KHJsY19oZHItPnN0YXJ0
aW5nX29mZnNldHNfc3RhcnQpOwotCWFkZXYtPmdmeC5ybGMucmVnX2xpc3RfZm9ybWF0X3NpemVf
Ynl0ZXMgPQorCQlhZGV2LT5nZngucmxjLnJlZ19saXN0X2Zvcm1hdF9zaXplX2J5dGVzID0KIAkJ
CWxlMzJfdG9fY3B1KHJsY19oZHItPnJlZ19saXN0X2Zvcm1hdF9zaXplX2J5dGVzKTsKLQlhZGV2
LT5nZngucmxjLnJlZ19saXN0X3NpemVfYnl0ZXMgPQorCQlhZGV2LT5nZngucmxjLnJlZ19saXN0
X3NpemVfYnl0ZXMgPQogCQkJbGUzMl90b19jcHUocmxjX2hkci0+cmVnX2xpc3Rfc2l6ZV9ieXRl
cyk7Ci0JYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9saXN0X2Zvcm1hdCA9CisJCWFkZXYtPmdmeC5y
bGMucmVnaXN0ZXJfbGlzdF9mb3JtYXQgPQogCQkJa21hbGxvYyhhZGV2LT5nZngucmxjLnJlZ19s
aXN0X2Zvcm1hdF9zaXplX2J5dGVzICsKLQkJCQlhZGV2LT5nZngucmxjLnJlZ19saXN0X3NpemVf
Ynl0ZXMsIEdGUF9LRVJORUwpOwotCWlmICghYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9saXN0X2Zv
cm1hdCkgewotCQllcnIgPSAtRU5PTUVNOwotCQlnb3RvIG91dDsKLQl9CisJCQkJCWFkZXYtPmdm
eC5ybGMucmVnX2xpc3Rfc2l6ZV9ieXRlcywgR0ZQX0tFUk5FTCk7CisJCWlmICghYWRldi0+Z2Z4
LnJsYy5yZWdpc3Rlcl9saXN0X2Zvcm1hdCkgeworCQkJZXJyID0gLUVOT01FTTsKKwkJCWdvdG8g
b3V0OworCQl9CiAKLQl0bXAgPSAodW5zaWduZWQgaW50ICopKCh1aW50cHRyX3QpcmxjX2hkciAr
Ci0JCQlsZTMyX3RvX2NwdShybGNfaGRyLT5yZWdfbGlzdF9mb3JtYXRfYXJyYXlfb2Zmc2V0X2J5
dGVzKSk7Ci0JZm9yIChpID0gMCA7IGkgPCAocmxjX2hkci0+cmVnX2xpc3RfZm9ybWF0X3NpemVf
Ynl0ZXMgPj4gMik7IGkrKykKLQkJYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9saXN0X2Zvcm1hdFtp
XSA9CWxlMzJfdG9fY3B1KHRtcFtpXSk7CisJCXRtcCA9ICh1bnNpZ25lZCBpbnQgKikoKHVpbnRw
dHJfdClybGNfaGRyICsKKwkJCQkJCQkgICBsZTMyX3RvX2NwdShybGNfaGRyLT5yZWdfbGlzdF9m
b3JtYXRfYXJyYXlfb2Zmc2V0X2J5dGVzKSk7CisJCWZvciAoaSA9IDAgOyBpIDwgKHJsY19oZHIt
PnJlZ19saXN0X2Zvcm1hdF9zaXplX2J5dGVzID4+IDIpOyBpKyspCisJCQlhZGV2LT5nZngucmxj
LnJlZ2lzdGVyX2xpc3RfZm9ybWF0W2ldID0JbGUzMl90b19jcHUodG1wW2ldKTsKIAotCWFkZXYt
PmdmeC5ybGMucmVnaXN0ZXJfcmVzdG9yZSA9IGFkZXYtPmdmeC5ybGMucmVnaXN0ZXJfbGlzdF9m
b3JtYXQgKyBpOworCQlhZGV2LT5nZngucmxjLnJlZ2lzdGVyX3Jlc3RvcmUgPSBhZGV2LT5nZngu
cmxjLnJlZ2lzdGVyX2xpc3RfZm9ybWF0ICsgaTsKIAotCXRtcCA9ICh1bnNpZ25lZCBpbnQgKiko
KHVpbnRwdHJfdClybGNfaGRyICsKLQkJCWxlMzJfdG9fY3B1KHJsY19oZHItPnJlZ19saXN0X2Fy
cmF5X29mZnNldF9ieXRlcykpOwotCWZvciAoaSA9IDAgOyBpIDwgKHJsY19oZHItPnJlZ19saXN0
X3NpemVfYnl0ZXMgPj4gMik7IGkrKykKLQkJYWRldi0+Z2Z4LnJsYy5yZWdpc3Rlcl9yZXN0b3Jl
W2ldID0gbGUzMl90b19jcHUodG1wW2ldKTsKKwkJdG1wID0gKHVuc2lnbmVkIGludCAqKSgodWlu
dHB0cl90KXJsY19oZHIgKworCQkJCQkJCSAgIGxlMzJfdG9fY3B1KHJsY19oZHItPnJlZ19saXN0
X2FycmF5X29mZnNldF9ieXRlcykpOworCQlmb3IgKGkgPSAwIDsgaSA8IChybGNfaGRyLT5yZWdf
bGlzdF9zaXplX2J5dGVzID4+IDIpOyBpKyspCisJCQlhZGV2LT5nZngucmxjLnJlZ2lzdGVyX3Jl
c3RvcmVbaV0gPSBsZTMyX3RvX2NwdSh0bXBbaV0pOwogCi0JaWYgKGFkZXYtPmdmeC5ybGMuaXNf
cmxjX3YyXzEpCi0JCWdmeF92MTBfMF9pbml0X3JsY19leHRfbWljcm9jb2RlKGFkZXYpOworCQlp
ZiAoYWRldi0+Z2Z4LnJsYy5pc19ybGNfdjJfMSkKKwkJCWdmeF92MTBfMF9pbml0X3JsY19leHRf
bWljcm9jb2RlKGFkZXYpOworCX0KIAogCXNucHJpbnRmKGZ3X25hbWUsIHNpemVvZihmd19uYW1l
KSwgImFtZGdwdS8lc19tZWMlcy5iaW4iLCBjaGlwX25hbWUsIHdrcyk7CiAJZXJyID0gcmVxdWVz
dF9maXJtd2FyZSgmYWRldi0+Z2Z4Lm1lY19mdywgZndfbmFtZSwgYWRldi0+ZGV2KTsKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
