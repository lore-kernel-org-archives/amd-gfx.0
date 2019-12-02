Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A43C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 06:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F00F20715
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 06:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F00F20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA5C89F3C;
	Mon,  2 Dec 2019 06:03:52 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790080.outbound.protection.outlook.com [40.107.79.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B7A89F3C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 06:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic0sKUhIgt8NdmmL2UrDOUU38JvfWWDaSQjc1rYw8mIWbU1fu0F4AfgQHpC4axxLeAP+zmPQKTf3nq53RG1GAb78p702ON8Sq3yg5w7t+fiVpQndY2jzCKKysX4IpSS+aC3P7Jwqg7uZysG51JPXDg4+2DrAXDdJVHxr/lHZg6XMk2F12Rz8qR1u/p3UH4WyKgYpfyRIzf9dzrclnfeox1I0zMBWD6RjIvwY3DfTqIpw11juljN+AlqkpXjXthkcaX7A/29vN6iskgHdSIJt+W7Qi21mwCbiFgumtHYuEqm94h6q2FFems9R94fgGVb7JCNNtZlmN97QWc2mzqQEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKdW8fCQkvd9Ysa4r6wBjTp0i3khBYcykjEgw9mwwOk=;
 b=DlPTCwp8f8ee36MArxMNw3x9XyjXKtDIkU7WupfYKAUbugA96bwXGUbcixCxI8kp3iR5NfOkBulw0En0/Krf3mA5g+Ew5ap6Ey4Y19ycmQTtYK71+Y42wGy1De7FTPw1Uxhi8kmBJ0I3QgxfBTYYajT2q6QAbOwcHC7kgrqK3IBz84xsmbQR8bVIupXwMsJH7D/gwHHvNAQNC4kUYSsqZej36Njyqm8KD35IHNaO/Ya2TKy0iT4XNtFyZO/Z2cY4rCj86nWptctZupXFPZNsltjYaKXJy2BkO0zf1gFEKCmbEzkjSKvu+t/rcmDUWz1aAbK3WbWCXBst/bSWdLNLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR12CA0039.namprd12.prod.outlook.com (2603:10b6:405:70::25)
 by DM5PR12MB1273.namprd12.prod.outlook.com (2603:10b6:3:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Mon, 2 Dec
 2019 06:03:46 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by BN6PR12CA0039.outlook.office365.com
 (2603:10b6:405:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Mon, 2 Dec 2019 06:03:45 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 2 Dec 2019 06:03:45 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Dec 2019
 00:03:45 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Dec 2019 00:03:43 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Min Frank <Frank.Min@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: drop asd shared memory
Date: Mon, 2 Dec 2019 14:03:35 +0800
Message-ID: <20191202060337.22435-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(428003)(189003)(199004)(6636002)(186003)(86362001)(50466002)(48376002)(53416004)(478600001)(5660300002)(70586007)(51416003)(7696005)(70206006)(36756003)(81156014)(305945005)(8936002)(2906002)(110136005)(81166006)(356004)(6666004)(50226002)(16586007)(316002)(2616005)(4326008)(426003)(8676002)(1076003)(26005)(336012)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1273; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aec5c28-b276-4cd8-eda2-08d776ed644d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1273:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12738694F0D764F42CB4897CFC430@DM5PR12MB1273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISMmC9s1lV14PzksmO5Hvo0gq05eI1VY1sPQN1pUG8xbQ8Ihd4CjaHooERf44ZuknlLioJApMlOOyd8u7KVTjiclq6SsRtveiJs+90B0SAi1FT52ATOzO/c8z83yVc6TwPWDhbclYBISCZ7+PG5c1mIO7hYO+suUsCN5CCFxE40/OOHLrTBu34Gh85G9rGsuK2Qr3yfPTtJY2m9hxDEKlPwGqetuE5q8w0cqcH5noixN55vU2xMh6ljrySAV/mYa3zDnWjKqkDzUytL5DZTb77SCPcJ0G4a+ScWiN/MKD6nCnLwibc+mCnOFuU0Gmi41TPF+CndmjKCX52ryxu97xrmaHHsTja14DcX1p35UKsFYGB2c6AGmikdORL2z7mwF6gbEZnBjOYIIQc/EZ6jb9vNGuBj85RnF78mwC2mgm72bjpq7gfgCp6GHtpaYVuye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 06:03:45.7929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aec5c28-b276-4cd8-eda2-08d776ed644d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKdW8fCQkvd9Ysa4r6wBjTp0i3khBYcykjEgw9mwwOk=;
 b=1eiqwu7pdLxS3nekwZGaU0uM9rXUMs712Vv5Vk5V5cVym9rbBKYt2TcmJJpPh604emiMi+kc5BoXjNtkj2FqiGx2matqM+PFuuAGvtG9JrZQZN/6f62aPCGvHJGxiDgvKhYaWRQ0fv5g8bIx0Z0D4kBfscnj5Q0Yd1Usn2Qod+c=
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YXNkIHNoYXJlZCBtZW1vcnkgaXMgbm90IG5lZWRlZCBzaW5jZSBkcml2ZXJzIGRvZXNuJ3QKaW52
b2tlIGFueSBmdXJ0aGVyIGNtZCB0byBhc2QgZGlyZWN0bHkgYWZ0ZXIgdGhlIGFzZApsb2FkaW5n
LiB0cnVzdCBhcHBsaWNhdGlvbiBpcyB0aGUgb25lIHdobyBuZWVkcwp0byB0YWxrIHRvIGFzZCBh
ZnRlciB0aGUgaW5pdGlhbGl6YXRpb24KCkNoYW5nZS1JZDogSTcyOGFmYTRjN2U4YjY3YmMwNjY3
OGIxMGU5MmFjMDY0YmExMDE3M2UKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyB8IDQ0ICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuaCB8IDEyICsrKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCmluZGV4IGQ4ZWY3MDk4ZmZkZi4uYmRjOWU3YWU0ODkyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0zMDksMzUgKzMwOSwxNyBAQCBzdGF0aWMg
aW50IHBzcF90bXJfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAlyZXR1cm4gcmV0Owog
fQogCi1zdGF0aWMgdm9pZCBwc3BfcHJlcF9hc2RfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRf
cmVzcCAqY21kLAotCQkJCSB1aW50NjRfdCBhc2RfbWMsIHVpbnQ2NF90IGFzZF9tY19zaGFyZWQs
Ci0JCQkJIHVpbnQzMl90IHNpemUsIHVpbnQzMl90IHNoYXJlZF9zaXplKQorc3RhdGljIHZvaWQg
cHNwX3ByZXBfYXNkX2xvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAor
CQkJCXVpbnQ2NF90IGFzZF9tYywgdWludDMyX3Qgc2l6ZSkKIHsKIAljbWQtPmNtZF9pZCA9IEdG
WF9DTURfSURfTE9BRF9BU0Q7CiAJY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX3BoeV9hZGRyX2xv
ID0gbG93ZXJfMzJfYml0cyhhc2RfbWMpOwogCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9waHlf
YWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMoYXNkX21jKTsKIAljbWQtPmNtZC5jbWRfbG9hZF90YS5h
cHBfbGVuID0gc2l6ZTsKIAotCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJf
bG8gPSBsb3dlcl8zMl9iaXRzKGFzZF9tY19zaGFyZWQpOwotCWNtZC0+Y21kLmNtZF9sb2FkX3Rh
LmNtZF9idWZfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKGFzZF9tY19zaGFyZWQpOwotCWNt
ZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuID0gc2hhcmVkX3NpemU7Ci19Ci0KLXN0YXRp
YyBpbnQgcHNwX2FzZF9pbml0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQotewotCWludCByZXQ7
Ci0KLQkvKgotCSAqIEFsbG9jYXRlIDE2ayBtZW1vcnkgYWxpZ25lZCB0byA0ayBmcm9tIEZyYW1l
IEJ1ZmZlciAobG9jYWwKLQkgKiBwaHlzaWNhbCkgZm9yIHNoYXJlZCBBU0QgPC0+IERyaXZlcgot
CSAqLwotCXJldCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKHBzcC0+YWRldiwgUFNQX0FTRF9T
SEFSRURfTUVNX1NJWkUsCi0JCQkJICAgICAgUEFHRV9TSVpFLCBBTURHUFVfR0VNX0RPTUFJTl9W
UkFNLAotCQkJCSAgICAgICZwc3AtPmFzZF9zaGFyZWRfYm8sCi0JCQkJICAgICAgJnBzcC0+YXNk
X3NoYXJlZF9tY19hZGRyLAotCQkJCSAgICAgICZwc3AtPmFzZF9zaGFyZWRfYnVmKTsKLQotCXJl
dHVybiByZXQ7CisJY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9sbyA9IDA7
CisJY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9oaSA9IDA7CisJY21kLT5j
bWQuY21kX2xvYWRfdGEuY21kX2J1Zl9sZW4gPSAwOwogfQogCiBzdGF0aWMgaW50IHBzcF9hc2Rf
bG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKQEAgLTM1OSwxMSArMzQxLDE1IEBAIHN0YXRp
YyBpbnQgcHNwX2FzZF9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCW1lbXNldChwc3At
PmZ3X3ByaV9idWYsIDAsIFBTUF8xX01FRyk7CiAJbWVtY3B5KHBzcC0+ZndfcHJpX2J1ZiwgcHNw
LT5hc2Rfc3RhcnRfYWRkciwgcHNwLT5hc2RfdWNvZGVfc2l6ZSk7CiAKLQlwc3BfcHJlcF9hc2Rf
Y21kX2J1ZihjbWQsIHBzcC0+ZndfcHJpX21jX2FkZHIsIHBzcC0+YXNkX3NoYXJlZF9tY19hZGRy
LAotCQkJICAgICBwc3AtPmFzZF91Y29kZV9zaXplLCBQU1BfQVNEX1NIQVJFRF9NRU1fU0laRSk7
CisJcHNwX3ByZXBfYXNkX2xvYWRfY21kX2J1ZihjbWQsIHBzcC0+ZndfcHJpX21jX2FkZHIsCisJ
CQkJICBwc3AtPmFzZF91Y29kZV9zaXplKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihw
c3AsIE5VTEwsIGNtZCwKIAkJCQkgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CisJaWYgKCFyZXQp
IHsKKwkJcHNwLT5hc2RfY29udGV4dC5hc2RfaW5pdGlhbGl6ZWQgPSB0cnVlOworCQlwc3AtPmFz
ZF9jb250ZXh0LnNlc3Npb25faWQgPSBjbWQtPnJlc3Auc2Vzc2lvbl9pZDsKKwl9CiAKIAlrZnJl
ZShjbWQpOwogCkBAIC0xMTk4LDEyICsxMTg0LDYgQEAgc3RhdGljIGludCBwc3BfaHdfc3RhcnQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJCXJldHVybiByZXQ7CiAJfQogCi0JcmV0ID0gcHNw
X2FzZF9pbml0KHBzcCk7Ci0JaWYgKHJldCkgewotCQlEUk1fRVJST1IoIlBTUCBhc2QgaW5pdCBm
YWlsZWQhXG4iKTsKLQkJcmV0dXJuIHJldDsKLQl9Ci0KIAlyZXQgPSBwc3BfYXNkX2xvYWQocHNw
KTsKIAlpZiAocmV0KSB7CiAJCURSTV9FUlJPUigiUFNQIGxvYWQgYXNkIGZhaWxlZCFcbiIpOwpA
QCAtMTYxMSw4ICsxNTkxLDYgQEAgc3RhdGljIGludCBwc3BfaHdfZmluaSh2b2lkICpoYW5kbGUp
CiAJCQkgICAgICAmcHNwLT5md19wcmlfbWNfYWRkciwgJnBzcC0+ZndfcHJpX2J1Zik7CiAJYW1k
Z3B1X2JvX2ZyZWVfa2VybmVsKCZwc3AtPmZlbmNlX2J1Zl9ibywKIAkJCSAgICAgICZwc3AtPmZl
bmNlX2J1Zl9tY19hZGRyLCAmcHNwLT5mZW5jZV9idWYpOwotCWFtZGdwdV9ib19mcmVlX2tlcm5l
bCgmcHNwLT5hc2Rfc2hhcmVkX2JvLCAmcHNwLT5hc2Rfc2hhcmVkX21jX2FkZHIsCi0JCQkgICAg
ICAmcHNwLT5hc2Rfc2hhcmVkX2J1Zik7CiAJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZwc3AtPmNt
ZF9idWZfYm8sICZwc3AtPmNtZF9idWZfbWNfYWRkciwKIAkJCSAgICAgICh2b2lkICoqKSZwc3At
PmNtZF9idWZfbWVtKTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oCmlu
ZGV4IDZkZTBlZTk3ODYxZi4uYTRkNzY5MGVhNTc3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5oCkBAIC0zMiw3ICszMiw2IEBACiAKICNkZWZpbmUgUFNQX0ZFTkNFX0JV
RkZFUl9TSVpFCTB4MTAwMAogI2RlZmluZSBQU1BfQ01EX0JVRkZFUl9TSVpFCTB4MTAwMAotI2Rl
ZmluZSBQU1BfQVNEX1NIQVJFRF9NRU1fU0laRSAweDQwMDAKICNkZWZpbmUgUFNQX1hHTUlfU0hB
UkVEX01FTV9TSVpFIDB4NDAwMAogI2RlZmluZSBQU1BfUkFTX1NIQVJFRF9NRU1fU0laRSAweDgw
MDAKICNkZWZpbmUgUFNQXzFfTUVHCQkweDEwMDAwMApAQCAtMTMwLDYgKzEyOSwxMSBAQCBzdHJ1
Y3QgcHNwX3hnbWlfdG9wb2xvZ3lfaW5mbyB7CiAJc3RydWN0IHBzcF94Z21pX25vZGVfaW5mbwlu
b2Rlc1tBTURHUFVfWEdNSV9NQVhfQ09OTkVDVEVEX05PREVTXTsKIH07CiAKK3N0cnVjdCBwc3Bf
YXNkX2NvbnRleHQgeworCWJvb2wJCQlhc2RfaW5pdGlhbGl6ZWQ7CisJdWludDMyX3QJCXNlc3Np
b25faWQ7Cit9OworCiBzdHJ1Y3QgcHNwX3hnbWlfY29udGV4dCB7CiAJdWludDhfdAkJCQlpbml0
aWFsaXplZDsKIAl1aW50MzJfdAkJCXNlc3Npb25faWQ7CkBAIC0yMzgsMTUgKzI0MiwxMiBAQCBz
dHJ1Y3QgcHNwX2NvbnRleHQKIAlzdHJ1Y3QgYW1kZ3B1X2JvCQkqdG1yX2JvOwogCXVpbnQ2NF90
CQkJdG1yX21jX2FkZHI7CiAKLQkvKiBhc2QgZmlybXdhcmUgYW5kIGJ1ZmZlciAqLworCS8qIGFz
ZCBmaXJtd2FyZSAqLwogCWNvbnN0IHN0cnVjdCBmaXJtd2FyZQkJKmFzZF9mdzsKIAl1aW50MzJf
dAkJCWFzZF9md192ZXJzaW9uOwogCXVpbnQzMl90CQkJYXNkX2ZlYXR1cmVfdmVyc2lvbjsKIAl1
aW50MzJfdAkJCWFzZF91Y29kZV9zaXplOwogCXVpbnQ4X3QJCQkJKmFzZF9zdGFydF9hZGRyOwot
CXN0cnVjdCBhbWRncHVfYm8JCSphc2Rfc2hhcmVkX2JvOwotCXVpbnQ2NF90CQkJYXNkX3NoYXJl
ZF9tY19hZGRyOwotCXZvaWQJCQkJKmFzZF9zaGFyZWRfYnVmOwogCiAJLyogZmVuY2UgYnVmZmVy
ICovCiAJc3RydWN0IGFtZGdwdV9ibwkJKmZlbmNlX2J1Zl9ibzsKQEAgLTI4MSw2ICsyODIsNyBA
QCBzdHJ1Y3QgcHNwX2NvbnRleHQKIAl1aW50MzJfdAkJCXRhX2R0bV91Y29kZV9zaXplOwogCXVp
bnQ4X3QJCQkJKnRhX2R0bV9zdGFydF9hZGRyOwogCisJc3RydWN0IHBzcF9hc2RfY29udGV4dAkJ
YXNkX2NvbnRleHQ7CiAJc3RydWN0IHBzcF94Z21pX2NvbnRleHQJCXhnbWlfY29udGV4dDsKIAlz
dHJ1Y3QgcHNwX3Jhc19jb250ZXh0CQlyYXM7CiAJc3RydWN0IHBzcF9oZGNwX2NvbnRleHQgCWhk
Y3BfY29udGV4dDsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
