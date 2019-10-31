Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C82CA9ECE
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CDE20873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CDE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBD06EEB8;
	Thu, 31 Oct 2019 14:42:51 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800071.outbound.protection.outlook.com [40.107.80.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983656EEB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQlXzBXdP9byMQ6d5nkL0H37Ul8U9uqjm5FZ1enoHttA/Lhv/94OMIxHYT4Uyx22y58UZ4E+z2OPdCLQ6GO5hMe4SKRvSI54GI0bbLX3qcycb9QkZST/EowcaTkDZUk7Pwl83JK1I+9zCIJuAgrcTQi9UIGkUZ3egZlCAtqX0ZQcIckfBRpMQOTdR5m9gIBlbWNHDcbZ69ic0IVt80XxTCRlUf1SYKbXwqhKpSqgdgyz2c/pP1eB386z8TJIOlCj+hao5j7DAkBR4jr0gUp5qacbHOHfOeO6PDgAmQtqZowV101Te007l7ItJH46u0qyNZHiJV6wbf2RxotxMe2ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HsRGIIuPyynNKU++cg0zmgt+fm5PFenZzmTqV59iu8=;
 b=YaQoaufZGhHWTqUE8rEb3viMMIEZz7ZWlX11Bwyht9LAtc2Cd/CZgsgRM0YwOPqmahlz7CDRPVByYklucSAmJ31BiN/S9KdINsijItvK0lk5cWE3aSuyFru+uzxXTLh6aqKYaawrtT/wVRSs4nI8/n6935eI5/ijocv30p8IjJ8swnJLjhc7ckd3FZx11K/nz2E2HBK2Y9yKXHlQv4tr4eGBaRvxMWXQTlBwQT2PzChjyTbeb1JIjugDe4IJFSXd2oLaNOFQ+koqH3y+XxyeQHI1wA7lNuTYElESU2+qZsbu36gX7NQvF63pbOZx4XHZAdrmYxvTOd9k6g+K0wi52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0043.namprd12.prod.outlook.com (2603:10b6:903:129::29)
 by BN8PR12MB2929.namprd12.prod.outlook.com (2603:10b6:408:9c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Thu, 31 Oct
 2019 14:42:44 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by CY4PR12CA0043.outlook.office365.com
 (2603:10b6:903:129::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.19 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:44 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:42 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:42 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:41 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/20] drm/amd/display: configure lttpr mode
Date: Thu, 31 Oct 2019 10:42:07 -0400
Message-ID: <20191031144210.24011-18-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(428003)(189003)(199004)(81156014)(11346002)(7696005)(51416003)(8936002)(2616005)(81166006)(336012)(76176011)(50226002)(8676002)(356004)(305945005)(446003)(2351001)(426003)(70586007)(6666004)(86362001)(6916009)(1076003)(126002)(476003)(70206006)(486006)(4326008)(16586007)(2906002)(316002)(14444005)(26005)(36756003)(50466002)(48376002)(5660300002)(478600001)(53416004)(47776003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2929; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4daaec2c-a574-4688-7010-08d75e10970e
X-MS-TrafficTypeDiagnostic: BN8PR12MB2929:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2929B6C191C3A2670966748CF9630@BN8PR12MB2929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PmLRoMfvYbfI8ShEVGPYeO2C98S05yz3PoEp/lQLCOsoyl5joHkNZJB1V1r8h9M9A3GCmlPWqLnOaz8h5+9bvxO8+hKh8x+6mQyKYClS9w7e8ACFUrqrX1fON1DT/1jd1nVi0UUk0p3Iix14Il+KVyOwI+FIGXSHkOdtPJ6wOFsjZ0HleS+gT7sQ6MUhiP7NWIYLVcSjPue8RooUgTi/7iBYuEVRe02ES1snfWOvavW9uRlCuIeyEtExmwJGgX61EZ7NIv6iPip8XBGVwviaHW8vn//hRUdiHBnblmEzIhFZaowf7Rt3Yu0OnV3Q6acDpfULuabOeH0PyNFZmmpalykERl8wZyX5W93TAsbwUiGMYuSh3j+r1Siwa/0PPhyfQiyVP7rVsFOlSqjD9l0elQZemzV6rL4BMmJSCGGv1sBvZ8MXZ5rfzXHk8kW7Q/b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:44.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daaec2c-a574-4688-7010-08d75e10970e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2929
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HsRGIIuPyynNKU++cg0zmgt+fm5PFenZzmTqV59iu8=;
 b=gp4vTajnn3vTDQI9qnVuIvEvgwPn6H2SKbOcMASElOfwuhVxtjXkmZiujz8ki8oPwKOaT5sxnw9lCeOREgjGjtFQj2aN1CzpNWmtw0T55HkPxkl6lGEr2nH8U7TxM9++O9NKdeiJuwvUpmckFErw4HxOlLp1ok2mLTWgFyjSuZE=
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
Cc: abdoulaye berthe <abdoulaye.berthe@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144207.6Nkrjw6_cSs9Ii5HwCQzEmEaXGVxUfEUeZGl-aEqKu8@z>

RnJvbTogYWJkb3VsYXllIGJlcnRoZSA8YWJkb3VsYXllLmJlcnRoZUBhbWQuY29tPgoKW0Rlc2Ny
aXB0aW9uXQoxLUdyYW50IGV4dGVuZGVkIHRpbWVvdXQgcmVxdWVzdC4gRG9uZSBvbmNlIGFmdGVy
IGRldGVjdGlvbgoyLUNvbmZpZ3VyZSBsdHRwciBtb2RlIGJhc2VkIG9uIGx0dHByIHN1cHBvcnQg
YmVmb3JlIExUCjMtQWNjb3VudCBmb3IgbHR0cHIgY2FwIHdoZW4gZGV0ZXJtaW5pbmcgbWF4IGxp
bmsgc2V0dGluZ3MKClNpZ25lZC1vZmYtYnk6IGFiZG91bGF5ZSBiZXJ0aGUgPGFiZG91bGF5ZS5i
ZXJ0aGVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFyaWMgQ3lyIDxBcmljLkN5ckBhbWQuY29tPgot
LS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jICB8IDQyICsr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCmluZGV4
IDFlNDQ4MGYzYmQzYy4uOTRkNWEwYWMzMDhmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCkBAIC0xMDU3LDYgKzEwNTcsMjYgQEAgc3Rh
dGljIHZvaWQgaW5pdGlhbGl6ZV90cmFpbmluZ19zZXR0aW5ncygKIAkJbHRfc2V0dGluZ3MtPmVu
aGFuY2VkX2ZyYW1pbmcgPSAxOwogfQogCitzdGF0aWMgdm9pZCBjb25maWd1cmVfbHR0cHJfbW9k
ZShzdHJ1Y3QgZGNfbGluayAqbGluaykKK3sKKwkvKiBhdXggdGltZW91dCBpcyBhbHJlYWR5IHNl
dCB0byBleHRlbmRlZCAqLworCS8qIFJFU0VUL1NFVCBsdHRwciBtb2RlIHRvIGVuYWJsZSBub24g
dHJhbnNwYXJlbnQgbW9kZSAqLworCWVudW0gbHR0cHJfbW9kZSByZXBlYXRlcl9tb2RlID0gcGh5
X3JlcGVhdGVyX21vZGVfdHJhbnNwYXJlbnQ7CisKKwljb3JlX2xpbmtfd3JpdGVfZHBjZChsaW5r
LAorCQkJRFBfUEhZX1JFUEVBVEVSX01PREUsCisJCQkodWludDhfdCAqKSZyZXBlYXRlcl9tb2Rl
LAorCQkJc2l6ZW9mKHJlcGVhdGVyX21vZGUpKTsKKworCWlmICghbGluay0+aXNfbHR0cHJfbW9k
ZV90cmFuc3BhcmVudCkgeworCQlyZXBlYXRlcl9tb2RlID0gcGh5X3JlcGVhdGVyX21vZGVfbm9u
X3RyYW5zcGFyZW50OworCQljb3JlX2xpbmtfd3JpdGVfZHBjZChsaW5rLAorCQkJCURQX1BIWV9S
RVBFQVRFUl9NT0RFLAorCQkJCSh1aW50OF90ICopJnJlcGVhdGVyX21vZGUsCisJCQkJc2l6ZW9m
KHJlcGVhdGVyX21vZGUpKTsKKwl9Cit9CisKIHN0YXRpYyB2b2lkIHByaW50X3N0YXR1c19tZXNz
YWdlKAogCXN0cnVjdCBkY19saW5rICpsaW5rLAogCWNvbnN0IHN0cnVjdCBsaW5rX3RyYWluaW5n
X3NldHRpbmdzICpsdF9zZXR0aW5ncywKQEAgLTEyMTAsNiArMTIzMCw5IEBAIGVudW0gbGlua190
cmFpbmluZ19yZXN1bHQgZGNfbGlua19kcF9wZXJmb3JtX2xpbmtfdHJhaW5pbmcoCiAJZHBfc2V0
X2ZlY19yZWFkeShsaW5rLCBmZWNfZW5hYmxlKTsKICNlbmRpZgogCisJLyogQ29uZmlndXJlIGx0
dHByIG1vZGUgKi8KKwlpZiAoIWxpbmstPmlzX2x0dHByX21vZGVfdHJhbnNwYXJlbnQpCisJCWNv
bmZpZ3VyZV9sdHRwcl9tb2RlKGxpbmspOwogCiAJLyogMi4gcGVyZm9ybSBsaW5rIHRyYWluaW5n
IChzZXQgbGluayB0cmFpbmluZyBkb25lCiAJICogIHRvIGZhbHNlIGlzIGRvbmUgYXMgd2VsbCkK
QEAgLTE0MjYsNiArMTQ0OSwxNyBAQCBzdGF0aWMgc3RydWN0IGRjX2xpbmtfc2V0dGluZ3MgZ2V0
X21heF9saW5rX2NhcChzdHJ1Y3QgZGNfbGluayAqbGluaykKIAkJCW1heF9saW5rX2NhcC5saW5r
X3NwcmVhZCkKIAkJbWF4X2xpbmtfY2FwLmxpbmtfc3ByZWFkID0KIAkJCQlsaW5rLT5yZXBvcnRl
ZF9saW5rX2NhcC5saW5rX3NwcmVhZDsKKwkvKgorCSAqIGFjY291bnQgZm9yIGx0dHByIHJlcGVh
dGVycyBjYXAKKwkgKiBub3RlczogcmVwZWF0ZXJzIGRvIG5vdCBzbm9vcCBpbiB0aGUgRFBSWCBD
YXBhYmlsaXRpZXMgYWRkcmVzc2VzICgzLjYuMykuCisJICovCisJaWYgKCFsaW5rLT5pc19sdHRw
cl9tb2RlX3RyYW5zcGFyZW50KSB7CisJCWlmIChsaW5rLT5kcGNkX2NhcHMubHR0cHJfY2Fwcy5t
YXhfbGFuZV9jb3VudCA8IG1heF9saW5rX2NhcC5sYW5lX2NvdW50KQorCQkJbWF4X2xpbmtfY2Fw
LmxhbmVfY291bnQgPSBsaW5rLT5kcGNkX2NhcHMubHR0cHJfY2Fwcy5tYXhfbGFuZV9jb3VudDsK
KworCQlpZiAobGluay0+ZHBjZF9jYXBzLmx0dHByX2NhcHMubWF4X2xpbmtfcmF0ZSA8IG1heF9s
aW5rX2NhcC5saW5rX3JhdGUpCisJCQltYXhfbGlua19jYXAubGlua19yYXRlID0gbGluay0+ZHBj
ZF9jYXBzLmx0dHByX2NhcHMubWF4X2xpbmtfcmF0ZTsKKwl9CiAJcmV0dXJuIG1heF9saW5rX2Nh
cDsKIH0KIApAQCAtMTU3MSw2ICsxNjA1LDEzIEBAIGJvb2wgZHBfdmVyaWZ5X2xpbmtfY2FwKAog
CiAJbWF4X2xpbmtfY2FwID0gZ2V0X21heF9saW5rX2NhcChsaW5rKTsKIAorCS8qIEdyYW50IGV4
dGVuZGVkIHRpbWVvdXQgcmVxdWVzdCAqLworCWlmICghbGluay0+aXNfbHR0cHJfbW9kZV90cmFu
c3BhcmVudCAmJiBsaW5rLT5kcGNkX2NhcHMubHR0cHJfY2Fwcy5tYXhfZXh0X3RpbWVvdXQgPiAw
KSB7CisJCXVpbnQ4X3QgZ3JhbnQgPSBsaW5rLT5kcGNkX2NhcHMubHR0cHJfY2Fwcy5tYXhfZXh0
X3RpbWVvdXQgJiAweDgwOworCisJCWNvcmVfbGlua193cml0ZV9kcGNkKGxpbmssIERQX1BIWV9S
RVBFQVRFUl9FWFRFTkRFRF9XQUlUX1RJTUVPVVQsICZncmFudCwgc2l6ZW9mKGdyYW50KSk7CisJ
fQorCiAJLyogVE9ETyBpbXBsZW1lbnQgb3ZlcnJpZGUgYW5kIG1vbml0b3IgcGF0Y2ggbGF0ZXIg
Ki8KIAogCS8qIHRyeSB0byB0cmFpbiB0aGUgbGluayBmcm9tIGhpZ2ggdG8gbG93IHRvCkBAIC0y
NzU5LDYgKzI4MDAsNyBAQCBzdGF0aWMgYm9vbCByZXRyaWV2ZV9saW5rX2NhcChzdHJ1Y3QgZGNf
bGluayAqbGluaykKIAkvKiBTZXQgZGVmYXVsdCB0aW1lb3V0IHRvIDMuMm1zIGFuZCByZWFkIExU
VFBSIGNhcGFiaWxpdGllcyAqLwogCWJvb2wgZXh0X3RpbWVvdXRfc3VwcG9ydCA9IGxpbmstPmRj
LT5jYXBzLmV4dGVuZGVkX2F1eF90aW1lb3V0X3N1cHBvcnQgJiYKIAkJCSFsaW5rLT5kYy0+Y29u
ZmlnLmRpc2FibGVfZXh0ZW5kZWRfdGltZW91dF9zdXBwb3J0OworCiAJbGluay0+aXNfbHR0cHJf
bW9kZV90cmFuc3BhcmVudCA9IHRydWU7CiAKIAlpZiAoZXh0X3RpbWVvdXRfc3VwcG9ydCkgewot
LSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
