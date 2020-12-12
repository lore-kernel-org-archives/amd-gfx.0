Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D7C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B2422AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B2422AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF8E6E88D;
	Sat, 12 Dec 2020 15:47:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E326E88D
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNBnlwnI8IjEiJeerlB3ro4zVXutwG1Z2VhwbA4wn24JdrMDX+aqIBiwQV3bilkRmanPXmMlMg0yHd34W/8Ut1+xg2/+TXlCkUOf58ncQDB7KA68OqTs/9pb0LHHyg+hKP+5wB0S+mz/EoJBGBvR8AWFOSKr7p2VKGflUNqiCL3iIpMs9aQTaAizrXez/rCzM4KpPYq59R193S8t2D2RX0Nw23OSdRKxKCXj6fV2XVrSvNmI5Lv+8lLxWP0NetMSXw1+qgYlxs/cIJpDysuye05qQxbHuAUkdWVIp0hN9NS5Rzkb3tQLGptnObALww+EvLC8CySK8doJ71l5eUeCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycS3AeAcu891K6RpNQ8pO9SPh9TcbdTX1gI7aBaakPY=;
 b=dTpCfSfkGuykeUyGb9ne8N2JGqt9HeWIYlV7el+hz70/QH09k6c+INYt1DjaS1BEJql6nQ4zeQUWKfBu+G+6EiX4DoW1jJHNRmqZJwk8DuDCNtb8QHYTlAfUXRdcoZyOxVhIYfqyvLfNfYIYNh8fLJKkZOayEAN+IFXrbOISxNPw6/ndw/HrxfCrYHZvNJUWHExKomlvBd3K/PLZdlh/nB3OAf3HoSgAXBsngNgwg6ZaiBIYczcIJ7m5Umk9x4l9l941RO2RHqM5GBoCjoCaZEkGWLj95JbaqIWk9FdjMYACFaWv/ME415v1+7sBzaU/l32Kx77GkPe3rgUyokLjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycS3AeAcu891K6RpNQ8pO9SPh9TcbdTX1gI7aBaakPY=;
 b=raBzM0QtFTkzRhcOjVHzDaVwA4KxpF6j8T+c1J71e0hH6hgK1eGhjyVKN+LLjD746FyLcvcQV+onY6DsynVvYHxPUlrmIEEk+LUixpE0BZFsy2WIvskeRm4X8sqMjrbBZrUtrWH6rOG/WGfP+mr9Uw0oMdid7fkE8SWqawW9fqY=
Received: from MWHPR17CA0089.namprd17.prod.outlook.com (2603:10b6:300:c2::27)
 by BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 15:47:26 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::45) by MWHPR17CA0089.outlook.office365.com
 (2603:10b6:300:c2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:24 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:24 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:22 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 21/27] drm/amdgpu: reroute vmc/utcl2 interrupts to ih ring 1
 for arcturus
Date: Sat, 12 Dec 2020 23:45:54 +0800
Message-ID: <20201212154600.21618-21-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0673191-44d0-4395-460e-08d89eb53920
X-MS-TrafficTypeDiagnostic: BL0PR12MB4995:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49958CD4E7F27DF7218E0848FCC90@BL0PR12MB4995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mpo8aA56ETAfoF1SjMlEszIZgGmDpAO/pz4Dty2KgLBX92BZRtD0EqrbS16Mk2Tu218msTXn8NMnENJ2rK3THQ4Rdc1DfVfGemoMwz+zRPFp3RqNZ75g/k2wYCbBui6+tgAbLz9dqVsXkYxc50umkSIDrjbPB686DPJOK1LwKvcq0J4mgGRbYaX9FMTxXNadf2JQuLIALMoSMFv1jmMddI7hOTPBt6ClRvuFAL4w3T/D6VizdVIHA7OnNrTd2VezZaMBvLBGTo6fkaS2OWoZi4HMde0xJl0ftUGxswxkAcdVy2HJmMAOoyiZdQH/UZLU3i3hs8UGVYAhZG1015CltVJ5e7KaNxv0yEqwJ9eqRWeeZtwJpJjrQPPDv7+eKBqNahdsGwACrvhwIO2RwqYOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(8936002)(86362001)(426003)(1076003)(5660300002)(7696005)(82310400003)(2616005)(26005)(110136005)(4326008)(70586007)(186003)(336012)(70206006)(47076004)(36756003)(508600001)(6666004)(6636002)(356005)(81166007)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:25.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0673191-44d0-4395-460e-08d89eb53920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YXJjdHVydXMgYWxsb3dzIGRyaXZlciB0byBwcm9ncmFtIGloX2NmZ19pbmRleC9kYXRhCnRocm91
Z2ggbW1pbyBkaXJlY3RseSBpbiBjYXNlIHBhZ2UgZmF1bHRzIG92ZXJ3aGxlbQp0aGUgaW50ZXJy
dXB0IGhhbmRsZXJzIGFuZCB0aGUgZHJpdmVyIGxvc3QgdGhlIHZhbHVhYmxlCmludGVycnVwdCBp
bmZvcm1hdGlvbgoKQ2hhbmdlLUlkOiBJMjRjYTZkZjYwZWQyYWUxZmYwY2EyMDhkOTA1MzEyNjhh
MzBmM2E3MwpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWlmZWkg
WHUgPEZlaWZlaS5YdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zl
Z2EyMF9paC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmVnYTIwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYwpp
bmRleCBlMTg5ODlmZjUwYTIuLmM0ODFmZjAwMTUyYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmVnYTIwX2loLmMKQEAgLTI0OCw2ICsyNDgsMzggQEAgc3RhdGljIGludCB2ZWdhMjBfaWhf
ZW5hYmxlX3Jpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJcmV0dXJuIDA7CiB9CiAK
Ky8qKgorICogdmVnYTIwX2loX3Jlcm91dGVfaWggLSByZXJvdXRlIFZNQy9VVENMMiBpaCB0byBh
biBpaCByaW5nCisgKgorICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgorICoKKyAqIFJl
cm91dGUgVk1DIGFuZCBVTUMgaW50ZXJydXB0cyBvbiBwcmltYXJ5IGloIHJpbmcgdG8KKyAqIGlo
IHJpbmcgMSBzbyB0aGV5IHdvbid0IGxvc2Ugd2hlbiBidW5jaGVzIG9mIHBhZ2UgZmF1bHRzCisg
KiBpbnRlcnJ1cHRzIG92ZXJ3aGVsbXMgdGhlIGludGVycnVwdCBoYW5kbGVyKFZFR0EyMCkKKyAq
Lworc3RhdGljIHZvaWQgdmVnYTIwX2loX3Jlcm91dGVfaWgoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCit7CisJdWludDMyX3QgdG1wOworCisJLyogdmVnYTIwIGloIHJlcm91dGUgd2lsbCBn
byB0aHJvdWdoIHBzcAorCSAqIHRoaXMgZnVuY3Rpb24gaXMgb25seSB1c2VkIGZvciBhcmN0dXJ1
cworCSAqLworCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgeworCQkvKiBS
ZXJvdXRlIHRvIElIIHJpbmcgMSBmb3IgVk1DICovCisJCVdSRUczMl9TT0MxNShPU1NTWVMsIDAs
IG1tSUhfQ0xJRU5UX0NGR19JTkRFWCwgMHgxMik7CisJCXRtcCA9IFJSRUczMl9TT0MxNShPU1NT
WVMsIDAsIG1tSUhfQ0xJRU5UX0NGR19EQVRBKTsKKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAs
IElIX0NMSUVOVF9DRkdfREFUQSwgQ0xJRU5UX1RZUEUsIDEpOworCQl0bXAgPSBSRUdfU0VUX0ZJ
RUxEKHRtcCwgSUhfQ0xJRU5UX0NGR19EQVRBLCBSSU5HX0lELCAxKTsKKwkJV1JFRzMyX1NPQzE1
KE9TU1NZUywgMCwgbW1JSF9DTElFTlRfQ0ZHX0RBVEEsIHRtcCk7CisKKwkJLyogUmVyb3V0ZSBJ
SCByaW5nIDEgZm9yIFVUQ0wyICovCisJCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0xJ
RU5UX0NGR19JTkRFWCwgMHgxQik7CisJCXRtcCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1t
SUhfQ0xJRU5UX0NGR19EQVRBKTsKKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIElIX0NMSUVO
VF9DRkdfREFUQSwgUklOR19JRCwgMSk7CisJCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhf
Q0xJRU5UX0NGR19EQVRBLCB0bXApOworCX0KK30KKwogLyoqCiAgKiB2ZWdhMjBfaWhfaXJxX2lu
aXQgLSBpbml0IGFuZCBlbmFibGUgdGhlIGludGVycnVwdCByaW5nCiAgKgpAQCAtMjg5LDYgKzMy
MSw4IEBAIHN0YXRpYyBpbnQgdmVnYTIwX2loX2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCiAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoaWgpOyBpKyspIHsKIAkJaWYg
KGloW2ldLT5yaW5nX3NpemUpIHsKKwkJCWlmIChpID09IDEpCisJCQkJdmVnYTIwX2loX3Jlcm91
dGVfaWgoYWRldik7CiAJCQlyZXQgPSB2ZWdhMjBfaWhfZW5hYmxlX3JpbmcoYWRldiwgaWhbaV0p
OwogCQkJaWYgKHJldCkKIAkJCQlyZXR1cm4gcmV0OwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
