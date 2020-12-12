Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5384DC433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130A122AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130A122AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02686E86B;
	Sat, 12 Dec 2020 15:46:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBE36E86B
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwAoJT9ZhMSVcqJ6cLfqiZdWMpsYNGHYWCJDUosAFMJPJxDnbWjGymibLvY+kbsLG2HNFyeDI4uKfRzIBLj7Kel3kMqivndCvk5NCrShWfSdJmq2ZE6Z0KX7/VDT89mkV7jj5CW3eBtdf5T80GFCD/OsGH28D4mOmH+AzLVh7J1MlxHXCMz2zvwfEjFoFyjfXbdSJlk9/+ovj2YTJHW65xmgdOsUFyZnQBnu8H0PSysvYf8fW1he75BBXyfEBxeI08UdbEaKk6lQX0p7fEolZmhRjmNeOFPw9eOmdx74PkQ/3fNvnLwaKWX3VWJ1aQ1ZFfjyI/oFQFfIChAp4avGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNxB3mtJuQo2wvqlhmO6fpuM5L2E75BuEePwu24Qcns=;
 b=gC6e+JBRn/8huuEb8LI+5G8p7iJJTjTwZ1E7oVn0e6SPBby0ioh0fy5dUBwwgVdnA2Udb9Et9Bbc68+itGAMI4/elA3YEaq1wv2P2B6ROGqMx99zNrEkcRY4WEyIMQ/2IX+mQnyCeo76aIs3GBKkJXK/w59qB9z6Sr25u9WOUyhGUgolOfhZsae+yY9HD67v7zTXTV3lLhBKmtSO2NwXrFcyQTasbSaX1k1pQGTVFb5ltAdQvfRNm2BlkvVy9v6D1EmtQD+A+fQcPFBK/8CDTiX8cfyy5KSpDO0NFIwQ+TNXFPB7FyLsJDZ6aJKAyOfokyPnWmwOgfSdKlvg3cV/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNxB3mtJuQo2wvqlhmO6fpuM5L2E75BuEePwu24Qcns=;
 b=jlXn0jzlby39MYj1yYpLsSHKl6SGMCvvgO8hSTYvsabbI9cVPJZsGXKD0p0FaY8YRwOt4rMUI6Nm4ttA0il1w4o2eD8A1TOH1MJHQEnKxgxrl7nFlvu+IAT2WrtKv1VPlJpdp8xbGBmr6tOEYJkXfUn/3zkuDY2nhAVWcJxL/08=
Received: from BN6PR16CA0025.namprd16.prod.outlook.com (2603:10b6:405:14::11)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Sat, 12 Dec
 2020 15:46:42 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::58) by BN6PR16CA0025.outlook.office365.com
 (2603:10b6:405:14::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:41 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:40 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:39 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 11/27] drm/amdgpu: add helper to enable an ih ring for navi10
Date: Sat, 12 Dec 2020 23:45:44 +0800
Message-ID: <20201212154600.21618-11-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea68c522-cd7a-49d7-2ab4-08d89eb51ebf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44884DA684C99DCD97AAA9E5FCC90@MN2PR12MB4488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfWnnYlGK+jLFE21rN9QRYEkEzzRcicHz+ZC21k9kQBJ1miahgLlv07EHtvjWoL8wljkTZe4/MvihW29FKZSpCEGLUw1O7MZrfvKwQBbLcxDYNtbkGGL/LJr63N9bDtgmOzo0DCJlmO174ZIXjY8DDga8gwrf1cG1fAa6/eLz7UcS5CHTpQDeir227kinmOzkPtuXWc0j8g/n77XYxVs2Wvc30kBf0UqHwGDFEttyvHLs4VOGvf9G+2OuwF+O7uAsLIfXf5Wzp+AVjn9pJx0GRuzsj8wg13t8oHmrhamJzP5jE82/WE8bnTetjIx0lTkTRzorivbzhkYuskyFzYmuwEZ9jqvH+JnKtM9Orxj54WrBk5HS5L7hApG5ULL0KL+3bv1doolkcGElivJ2aJcRoQ2oy0nCSa89iELRDwflW874IW+kDp9lwBgEXCkKJ7MoQL3X5zS/sCkingbk3GDqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(7696005)(336012)(5660300002)(47076004)(4326008)(8936002)(2616005)(82310400003)(6636002)(508600001)(186003)(110136005)(1076003)(6666004)(86362001)(2906002)(36756003)(70586007)(426003)(8676002)(356005)(81166007)(26005)(70206006)(309714004)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:41.4589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea68c522-cd7a-49d7-2ab4-08d89eb51ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

bmF2aTEwX2loX2VuYWJsZV9yaW5nIHdpbGwgYmUgdXNlZCB0byBlbmFibGUgYW4KaWggcmluZyBm
b3IgbmF2aTF4IGFuZCBvbndhcmRzCgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9uYXZpMTBfaWguYwppbmRleCBiNWEwMzI3ZWRhYTMuLmMyYTAwNmQ1NzgxOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKQEAgLTMwMCw2ICszMDAsNTggQEAgc3RhdGlj
IHVpbnQzMl90IG5hdmkxMF9paF9kb29yYmVsbF9ycHRyKHN0cnVjdCBhbWRncHVfaWhfcmluZyAq
aWgpCiAJcmV0dXJuIGloX2Rvb3JiZWxsX3J0cHI7CiB9CiAKKy8qKgorICogbmF2aTEwX2loX2Vu
YWJsZV9yaW5nIC0gZW5hYmxlIGFuIGloIHJpbmcgYnVmZmVyCisgKgorICogQGFkZXY6IGFtZGdw
dV9kZXZpY2UgcG9pbnRlcgorICogQGloOiBhbWRncHVfaWhfcmluZyBwb2ludGVyCisgKgorICog
RW5hYmxlIGFuIGloIHJpbmcgYnVmZmVyIChOQVZJMTApCisgKi8KK3N0YXRpYyBpbnQgbmF2aTEw
X2loX2VuYWJsZV9yaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJCSBzdHJ1Y3Qg
YW1kZ3B1X2loX3JpbmcgKmloKQoreworCXN0cnVjdCBhbWRncHVfaWhfcmVncyAqaWhfcmVnczsK
Kwl1aW50MzJfdCB0bXA7CisKKwlpaF9yZWdzID0gJmloLT5paF9yZWdzOworCisJLyogUmluZyBC
dWZmZXIgYmFzZS4gWzM5OjhdIG9mIDQwLWJpdCBhZGRyZXNzIG9mIHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIHJpbmcgYnVmZmVyKi8KKwlXUkVHMzIoaWhfcmVncy0+aWhfcmJfYmFzZSwgaWgtPmdwdV9h
ZGRyID4+IDgpOworCVdSRUczMihpaF9yZWdzLT5paF9yYl9iYXNlX2hpLCAoaWgtPmdwdV9hZGRy
ID4+IDQwKSAmIDB4ZmYpOworCisJdG1wID0gUlJFRzMyKGloX3JlZ3MtPmloX3JiX2NudGwpOwor
CXRtcCA9IG5hdmkxMF9paF9yYl9jbnRsKGloLCB0bXApOworCWlmIChpaCA9PSAmYWRldi0+aXJx
LmloKQorCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkJfQ05UTCwgUlBUUl9SRUFSTSwg
ISFhZGV2LT5pcnEubXNpX2VuYWJsZWQpOworCWlmIChpaCA9PSAmYWRldi0+aXJxLmloMSkgewor
CQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkJfQ05UTCwgV1BUUl9PVkVSRkxPV19FTkFC
TEUsIDApOworCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgSUhfUkJfQ05UTCwgUkJfRlVMTF9E
UkFJTl9FTkFCTEUsIDEpOworCX0KKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmIGFkZXYt
PmFzaWNfdHlwZSA8IENISVBfTkFWSTEwKSB7CisJCWlmIChwc3BfcmVnX3Byb2dyYW0oJmFkZXYt
PnBzcCwgaWhfcmVncy0+cHNwX3JlZ19pZCwgdG1wKSkgeworCQkJZGV2X2VycihhZGV2LT5kZXYs
ICJQU1AgcHJvZ3JhbSBJSF9SQl9DTlRMIGZhaWxlZCFcbiIpOworCQkJcmV0dXJuIC1FVElNRURP
VVQ7CisJCX0KKwl9IGVsc2UgeworCQlXUkVHMzIoaWhfcmVncy0+aWhfcmJfY250bCwgdG1wKTsK
Kwl9CisKKwlpZiAoaWggPT0gJmFkZXYtPmlycS5paCkgeworCQkvKiBzZXQgdGhlIGloIHJpbmcg
MCB3cml0ZWJhY2sgYWRkcmVzcyB3aGV0aGVyIGl0J3MgZW5hYmxlZCBvciBub3QgKi8KKwkJV1JF
RzMyKGloX3JlZ3MtPmloX3JiX3dwdHJfYWRkcl9sbywgbG93ZXJfMzJfYml0cyhpaC0+d3B0cl9h
ZGRyKSk7CisJCVdSRUczMihpaF9yZWdzLT5paF9yYl93cHRyX2FkZHJfaGksIHVwcGVyXzMyX2Jp
dHMoaWgtPndwdHJfYWRkcikgJiAweEZGRkYpOworCX0KKworCS8qIHNldCBycHRyLCB3cHRyIHRv
IDAgKi8KKwlXUkVHMzIoaWhfcmVncy0+aWhfcmJfd3B0ciwgMCk7CisJV1JFRzMyKGloX3JlZ3Mt
PmloX3JiX3JwdHIsIDApOworCisJV1JFRzMyKGloX3JlZ3MtPmloX2Rvb3JiZWxsX3JwdHIsIG5h
dmkxMF9paF9kb29yYmVsbF9ycHRyKGloKSk7CisKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIHZv
aWQgbmF2aTEwX2loX3Jlcm91dGVfaWgoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJ
dWludDMyX3QgdG1wOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
