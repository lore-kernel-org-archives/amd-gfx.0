Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44556C17443
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 04:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C4220869
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 04:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C4220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A1A6E16F;
	Mon, 11 Nov 2019 04:42:08 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730052.outbound.protection.outlook.com [40.107.73.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62B56E16F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 04:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEW59AHqUDFn/WtMzeHZlJtD0lPpV3wJNqvoMpOsfWjxVmEh2l6gyPYeDMYGqDsm0YJD39R+beiFv4Ewaz05GYBVTSlsMU0DOp7V/h9+fHHVaO0mnc/6rN78NlblCKI725Pu+kO/03TpV9/Bben6HMwvdaEvfmwLb7zYTvmvRxSXrm751P/2CGQGETR3J6Jp93+/RB0UOgZMKK5XUIGWKtkheuhzWWY3+RJyLknB8ZBzZ1jdDkm0TN/gKHhN+QSJg1GGGhf2oYcNvpxFfYq4UKeDajuQD0BE3wQfk1jA9K1Oz06Meif+w5Uy/a+cEByHmQOaeY4E3ooehdJ/c9M9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl83OtmDs+61Fb4W7eHFSTB/amE1JPUi0MBhm9VU9Q=;
 b=AxuPhesydNDagXhoNPILK+s4I2fA2kC+PypVAYIxhGBSm+Mn0q3FlOqeEUD4X6uq9d7B0ZIgtLudXGkG6+faaf1GH6bEIvPSE26l1SVf5r5B3qvf70+u8NV8QOq+ZGsJte1oqVUVumbeIQDxPJNUi40K7MYxwfQTuIP5C6QJNw/Tm5zZdEJcWYac94aIhg5KUBjpQxPVUW6ar+7eIEzeZF+yJRZKAxu8w4xlPK1kY/tkXyNXyKDUUQCt7H55jyp3QxofQihdc4+SHSAyVJAWrAJ3xFlv4C581kaVCgktffUL73iLQ0jO8m/nHk5iqduycaXcvx878BP7wdRbYUB1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0056.namprd12.prod.outlook.com (2603:10b6:300:103::18)
 by CY4PR12MB1142.namprd12.prod.outlook.com (2603:10b6:903:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.26; Mon, 11 Nov
 2019 04:42:03 +0000
Received: from CO1NAM03FT007.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by MWHPR12CA0056.outlook.office365.com
 (2603:10b6:300:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Mon, 11 Nov 2019 04:42:03 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT007.mail.protection.outlook.com (10.152.80.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Mon, 11 Nov 2019 04:42:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 10 Nov
 2019 22:42:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 10 Nov
 2019 22:42:01 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sun, 10 Nov 2019 22:41:59 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Clements John <clements.john@amd.com>, Le Ma <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Date: Mon, 11 Nov 2019 12:41:57 +0800
Message-ID: <20191111044157.11356-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(189003)(199004)(7696005)(48376002)(50466002)(305945005)(47776003)(51416003)(86362001)(4326008)(81156014)(81166006)(8676002)(36756003)(8936002)(26005)(486006)(1076003)(336012)(6636002)(478600001)(2906002)(70586007)(53416004)(426003)(50226002)(2616005)(126002)(476003)(110136005)(70206006)(16586007)(356004)(186003)(14444005)(5660300002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1142; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6673425-bf6d-4c71-70db-08d766617f26
X-MS-TrafficTypeDiagnostic: CY4PR12MB1142:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1142848E6FED446E0146958CFC740@CY4PR12MB1142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0218A015FA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePQal34dF8cBMIw26nhfC21c930MyCFhIBcBtBlvN1HB3jqeDXv2jpQD2z5oWUesJ16aAWZp37QX7WpUf9A0FE4T6DZu9LfhFEDmwBoDE3Czzf538OeB7wXLcePRdF+5zcoWjW5k2dHFHhp2CqfBvoiMZky6CDfrqMEzH2DUZumzlzPVuwfkj9fDD2qNmI6FpMLa79216ED2Qlv8mQw2UuCkudAXi5nM3J6yRVsBckKCPykklrQknaL02z75B4nw2L76yLvCYNNh2xU1q/QtfZc0u3zvBw9e/9v4vyOjyAyW6u690YYlOuJVbgSj2tCeP77TpYsM/F/hVEwFyvudR+0j0nBa+hDOIFSevbfnTj/21KJTy655+MkPLOAmVgYDpb8etl+GpbXuDWTBhEB0RBWgm9diR+t3UGN/5P1ITqxjWmRHLS1U8K3cbdRIitUX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 04:42:02.5694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6673425-bf6d-4c71-70db-08d766617f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1142
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVl83OtmDs+61Fb4W7eHFSTB/amE1JPUi0MBhm9VU9Q=;
 b=m29zEsEdDmKYp8kaRboi6oVB2+kmEqwMs7F6Vu0V6KK7LZPC5mbXThxwHzXuldWcJqhYr0SJ/WfXDhJlbwjkTEVCk+7ZPVzXZFlvSpr6s6+PstXHltIR/vuPzxRJNyaCgIDesd2enDNgxQDTpAuamwGqSlKIPSG/ZEGNFGmZ9wM=
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
Message-ID: <20191111044157.DtSzW9Tz9uZsNnDcpbB-OoVxlOisdGESpPktfj4CkKM@z>

eGdtaSwgcmFzLCBoZGNwIGFuZCBkdG0gdGEgYXJlIGFjdHVhbGx5IHNlcGFyYXRlZCB1Y29kZSBh
bmQKbmVlZCB0byBoYW5kbGVkIGNhc2UgYnkgY2FzZSB0byB1cGxvYWQgdG8gcHNwLgoKV2Ugc3Vw
cG9ydCB0aGUgY2FzZSB0aGF0IHRhIGJpbmFyeSBoYXZlIG9uZSBvciBtdWx0aXBsZSBvZgp0aGVt
IGJ1aWx0LWluLiBBcyBhIHJlc3VsdCwgdGhlIGRyaXZlciBzaG91bGQgY2hlY2sgZWFjaCB0YQpi
aW5hcml5J3MgYXZhaWxhYmxpdHkgYmVmb3JlIGRlY2lkZSB0byB1cGxvYWQgdGhlbSB0byBwc3Au
CgpJbiB0aGUgdGVybWluYXRlICh1bmxvYWQpIGNhc2UsIHRoZSBkcml2ZXIgd2lsbCBjaGVjayB0
aGUKY29udGV4dCByZWFkaW5lc3MgYmVmb3JlIHBlcmZvcm0gdW5sb2FkIGFjdGl2aXR5LiBJdCdz
IGZpbmUKdG8ga2VlcCBpdCBhcyBpcy4KCkNoYW5nZS1JZDogSTQ5MzExNjk3MGZmYjU1N2YzM2Mw
NmRlMTBmNzg2Njg0ZmRjZWY4NWIKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BzcC5jCmluZGV4IDQ1NmFjMDRiMjQ2Yy4uOTYyMWUyMDdhOWNhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC01NTgsNyArNTU4LDkgQEAgc3RhdGljIGludCBw
c3BfeGdtaV9pbml0aWFsaXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXN0cnVjdCB0YV94
Z21pX3NoYXJlZF9tZW1vcnkgKnhnbWlfY21kOwogCWludCByZXQ7CiAKLQlpZiAoIXBzcC0+YWRl
di0+cHNwLnRhX2Z3KQorCWlmICghcHNwLT5hZGV2LT5wc3AudGFfZncgfHwKKwkgICAgIXBzcC0+
YWRldi0+cHNwLnRhX3hnbWlfdWNvZGVfc2l6ZSB8fAorCSAgICAhcHNwLT5hZGV2LT5wc3AudGFf
eGdtaV9zdGFydF9hZGRyKQogCQlyZXR1cm4gLUVOT0VOVDsKIAogCWlmICghcHNwLT54Z21pX2Nv
bnRleHQuaW5pdGlhbGl6ZWQpIHsKQEAgLTc2OCw2ICs3NzAsMTIgQEAgc3RhdGljIGludCBwc3Bf
cmFzX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKIAor
CWlmICghcHNwLT5hZGV2LT5wc3AudGFfcmFzX3Vjb2RlX3NpemUgfHwKKwkgICAgIXBzcC0+YWRl
di0+cHNwLnRhX3Jhc19zdGFydF9hZGRyKSB7CisJCWRldl93YXJuKHBzcC0+YWRldi0+ZGV2LCAi
UkFTOiByYXMgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZVxuIik7CisJCXJldHVybiAwOworCX0K
KwogCWlmICghcHNwLT5yYXMucmFzX2luaXRpYWxpemVkKSB7CiAJCXJldCA9IHBzcF9yYXNfaW5p
dF9zaGFyZWRfYnVmKHBzcCk7CiAJCWlmIChyZXQpCkBAIC04NTcsNiArODY1LDEyIEBAIHN0YXRp
YyBpbnQgcHNwX2hkY3BfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlp
bnQgcmV0OwogCisJaWYgKCFwc3AtPmFkZXYtPnBzcC50YV9oZGNwX3Vjb2RlX3NpemUgfHwKKwkg
ICAgIXBzcC0+YWRldi0+cHNwLnRhX2hkY3Bfc3RhcnRfYWRkcikgeworCQlkZXZfd2Fybihwc3At
PmFkZXYtPmRldiwgIkhEQ1A6IGhkY3AgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZVxuIik7CisJ
CXJldHVybiAwOworCX0KKwogCWlmICghcHNwLT5oZGNwX2NvbnRleHQuaGRjcF9pbml0aWFsaXpl
ZCkgewogCQlyZXQgPSBwc3BfaGRjcF9pbml0X3NoYXJlZF9idWYocHNwKTsKIAkJaWYgKHJldCkK
QEAgLTEwMzAsNiArMTA0NCwxMiBAQCBzdGF0aWMgaW50IHBzcF9kdG1faW5pdGlhbGl6ZShzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwogCisJaWYgKCFwc3AtPmFkZXYtPnBz
cC50YV9kdG1fdWNvZGVfc2l6ZSB8fAorCSAgICAhcHNwLT5hZGV2LT5wc3AudGFfZHRtX3N0YXJ0
X2FkZHIpIHsKKwkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJEVE06IGR0bSB0YSB1Y29kZSBp
cyBub3QgYXZhaWxhYmxlXG4iKTsKKwkJcmV0dXJuIDA7CisJfQorCiAJaWYgKCFwc3AtPmR0bV9j
b250ZXh0LmR0bV9pbml0aWFsaXplZCkgewogCQlyZXQgPSBwc3BfZHRtX2luaXRfc2hhcmVkX2J1
Zihwc3ApOwogCQlpZiAocmV0KQotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
