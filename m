Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642AFC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211612075C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211612075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D586E186;
	Wed,  6 Nov 2019 06:31:10 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820077.outbound.protection.outlook.com [40.107.82.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242616E186
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6PFacpK2bJjXQygri5dic2Cj5jGGh27Xh/TJoNv2PSJuXrcXMPCI4Ht2Vs8CbXohhymlfGwucviY9gFPDIbfMmp1baMOJFdWNJrZsQ1f6jONC5lNgIhsEH9m1Xjza0CovouiS2OVur1TPMz8QCZ+pYkqaer5MjvEJ+HHLf5Vjz6UewK0sM5sxA9gUWNfP+dn8qH3iO2yuBdHKUCLyD3NoLhcjz+xqGEcMjfcobckZTJxnejQ0qddw8TBk/B/xRHC9F8w0t8ymFdk6KdGBvtb6kEDWTGDrPcctxZSxTCSFjGcSLnkG7Ib9u6YCTFNJD0ZTqXBEr0K3oWoHcfXSX4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZw9I8EP8FGkVRUO8amdQTSPHfEFf3LP8vjdrO0sbmE=;
 b=HVu6/rloBBHO3+C4jzJRyN59zitd28RG1fYiy0VkAGG4QJHBrlGrdi4VZ+x7awWmoChXwbZOQqi8E/kicdVKveo4GZ/dWbJVP9yX4HrSNzp+3+Cb0SGcERKs+g7RQI0Axx3gHErFvWpOsLAzeC9gxekY7bABQ6TzidujOQRZPZENWa8Xw5CQVaR5vRn5ZFUBHh8VKIB15/zddwxhrlXuJ8MmUuyZlr8yNzQxUs/dLvH+7l9o/NTZlNW3T/qggoDUu2UQZ7lXeq5+wxc1wopJ8Btu6nit9/FVq4YbG2BdY5VBn77SFFLpFtlSMnlGtxIveBMKeQpJggCu8Ex6Nuubxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CH2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:610:57::38)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Wed, 6 Nov
 2019 06:31:07 +0000
Received: from CO1NAM03FT047.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by CH2PR12CA0028.outlook.office365.com
 (2603:10b6:610:57::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 06:31:07 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT047.mail.protection.outlook.com (10.152.81.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Wed, 6 Nov 2019 06:31:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 00:31:05 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 00:31:05 -0600
Received: from jesse-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 00:31:04 -0600
From: Jesse Zhang <zhexi.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: Protect backend resource when unload driver
Date: Wed, 6 Nov 2019 14:31:02 +0800
Message-ID: <1573021862-10078-1-git-send-email-zhexi.zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(428003)(199004)(189003)(426003)(86362001)(7696005)(51416003)(2906002)(486006)(48376002)(2616005)(478600001)(6916009)(16586007)(47776003)(126002)(336012)(50466002)(26005)(356004)(476003)(186003)(316002)(50226002)(8936002)(81156014)(81166006)(2351001)(8676002)(305945005)(14444005)(53416004)(70206006)(5660300002)(4326008)(36756003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4105; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 605e0e05-6cd4-47a0-8a52-08d76282e7f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4105D38C4B1E72EED5F663DAEF790@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPEs6LkznhIBnS3iXnKaZrYO+CM4lN22/CxHxLXPi89VvlKEvEKApKqnrw9VdNaRlVb/KPdyBJd3VwRjYSjW4kD2WjIYRKQMP1OyXWf3lLi7wuIAWyWJ7c1Kpl0xvNq0XjHzBivF+2H5mPLcSXaTOADUcEZSeDrk/HR3i3V/XzTQITFsaWSi9V5X6+tSQPz7vRiwy/DaAjYdIlJwTspE0zQjWewB8/TZe6xLmZVVfoJ1hn6qb6I2kfFfwOtKG8nRSo9vWKb2+dQPLwJxOzIAdF/tFFyf3K6odJirUn4DCjLrWXejyk79j9GeqO0dzvdk5EhWgmBolFvQJvmMga3Qp/r9jfyBseM3qf2F3JH5fElGY1BoqNF1PduUd3Mnf1ZFmateeObEGTfZQapYKr1bchqDfV54J6scy1C/MQntL/6H/TpCT1WxgAcA0XQRPW7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 06:31:07.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605e0e05-6cd4-47a0-8a52-08d76282e7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZw9I8EP8FGkVRUO8amdQTSPHfEFf3LP8vjdrO0sbmE=;
 b=y8kl2Xh5qwpBCJeviEK+aLZInWdbv4RayiNTaMg9ZfLnQWBmecxi3/Ajz3Q5j9G8zMj/l9gVh3z1UJHKeu8QTzjpM0luwZiNSqlPTTUNrOiWsHHvCaX3PK5mVV9QWOm3kIs23FMl+FwyDrKi4vnNPkx8iW/1fZeIHrHirs5g1qk=
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
Cc: Jesse Zhang <zhexi.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106063102._qPogCRa7DpvGJuOWa7JmQiAAq7GkGHFM5E2kQ8-LF4@z>

R3Vlc3QgZHJpdmVyIGNhbiBiZSB1bmxvYWRlZCB3aGlsZSBlbmdpbmVzIHN0aWxsIHVzaW5nIHNv
bWUgYmFja2VuZCByZXNvdXJjZXMKd2hpY2ggd2hvdWxkIGxlYWQgdG8gZ3Vlc3QgZHJpdmVyIHVu
bG9hZCBmYWlsdXJlLgoKTmVlZCB0byBhZGQgbXV0ZXggbG9jayB0byBwcm90ZWN0IGJhY2tlbmQg
cmVzb3VyY2VzIGZyb20gY29uY3VycmVudCBvcGVyYXRpb25zCgpCZWZvcmUgZW50ZXJpbmcgcG93
ZXJnYXRpbmcgbW9kZSwgVkNFIGFuZCBVVkQgbmVlZCB0byBjaGVjayBpZiBiYWNrZW5kCnJlc291
cmNlcyBhcmUgc3RpbGwgYXZhaWxhYmxlLgoKQ2hhbmdlLUlkOiBJY2MzNGY5MzgxODc0Mzg1NmM0
ZWZiYmJmOTQ4MGU0ZDlmMmUwZDFlMQpTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8emhleGku
emhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93
ZXJwbGF5LmMgICAgICB8IDQgKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdt
Z3IvdmVnYTEwX2h3bWdyLmMgfCA2ICsrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bv
d2VycGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5j
CmluZGV4IDAzMTQ0NzYuLmM4MjU3MGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTEzNCw3ICsxMzQsOSBAQCBzdGF0aWMgaW50IHBwX2h3
X2Zpbmkodm9pZCAqaGFuZGxlKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaGFuZGxl
OwogCXN0cnVjdCBwcF9od21nciAqaHdtZ3IgPSBhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlOwog
CisJbXV0ZXhfbG9jaygmaHdtZ3ItPnNtdV9sb2NrKTsKIAlod21ncl9od19maW5pKGh3bWdyKTsK
KwltdXRleF91bmxvY2soJmh3bWdyLT5zbXVfbG9jayk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTY2
Miw3ICs2NjQsOSBAQCBzdGF0aWMgaW50IGFtZF9wb3dlcnBsYXlfcmVzZXQodm9pZCAqaGFuZGxl
KQogCXN0cnVjdCBwcF9od21nciAqaHdtZ3IgPSBoYW5kbGU7CiAJaW50IHJldDsKIAorCW11dGV4
X2xvY2soJmh3bWdyLT5zbXVfbG9jayk7CiAJcmV0ID0gaHdtZ3JfaHdfZmluaShod21ncik7CisJ
bXV0ZXhfdW5sb2NrKCZod21nci0+c211X2xvY2spOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7
CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ex
MF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3
bWdyLmMKaW5kZXggNDY1MzgyMzMuLmY3MmJhNzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCkBAIC00NjE2LDYgKzQ2MTYsOSBA
QCBzdGF0aWMgdm9pZCB2ZWdhMTBfcG93ZXJfZ2F0ZV92Y2Uoc3RydWN0IHBwX2h3bWdyICpod21n
ciwgYm9vbCBiZ2F0ZSkKIHsKIAlzdHJ1Y3QgdmVnYTEwX2h3bWdyICpkYXRhID0gaHdtZ3ItPmJh
Y2tlbmQ7CiAKKwlpZiAoIWRhdGEpCisJCXJldHVybjsKKwogCWRhdGEtPnZjZV9wb3dlcl9nYXRl
ZCA9IGJnYXRlOwogCXZlZ2ExMF9lbmFibGVfZGlzYWJsZV92Y2VfZHBtKGh3bWdyLCAhYmdhdGUp
OwogfQpAQCAtNDYyNCw2ICs0NjI3LDkgQEAgc3RhdGljIHZvaWQgdmVnYTEwX3Bvd2VyX2dhdGVf
dXZkKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUpCiB7CiAJc3RydWN0IHZlZ2Ex
MF9od21nciAqZGF0YSA9IGh3bWdyLT5iYWNrZW5kOwogCisJaWYgKCFkYXRhKQorCQlyZXR1cm47
CisKIAlkYXRhLT51dmRfcG93ZXJfZ2F0ZWQgPSBiZ2F0ZTsKIAl2ZWdhMTBfZW5hYmxlX2Rpc2Fi
bGVfdXZkX2RwbShod21nciwgIWJnYXRlKTsKIH0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
