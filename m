Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB297C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822412173E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822412173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6936EC02;
	Wed,  6 Nov 2019 06:57:10 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800045.outbound.protection.outlook.com [40.107.80.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E434B6EBFD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwNegCPs7lTU0TT60rtUoe7ndEq8yU7LSlCO1PQ5RLhOVucBjCsAj5RHt1XRYGZiVC2DZdWO2szUJVMABGbq41XTm3aW9aP31B+Szu4pmIFpOH7NprUaIgtv/pOO4SUdZVnqeAw/oE0yKvZj/cN/vUWaxIomX7+C3m5sqkAgU+UJcqoX7LpGWYn01ohZMVUUmrU3ZemU3BfHfECKu7PqT/SMsuWPYrowvbrK200snqP/yuE1SE4V1wzftSXRXua9F5Iqf4sYUrB3HykEMkskdS+JyV2Ldtcnjq9FqakK9DtoQaH7BSse3G1z6BLDHL7he9clITtJPy6lIllWaCN9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW+iANClN7HR44ru1F6o1G+lnj39UjM0b/2J3yFUCmY=;
 b=hTCQIy4nT+QfJMrSsfCIRhe7Tjg9sYoTCwqpe0ywYgpxBik4Ldy8xXfkLPtLJ8r2hcgprystpYbZkzmKF+UXPGr23sE6fTWOC6vaA0AWyQ1ShGfn1ZZMdXGoKzKhWMV2FSyNV0Y+cRGmI5/c8z9P/kT24+xpOxApoKW5Xp/KGGsUYraNP7NG5T7SFctmgTa3qMTYY1w+nSdLxrEzNZMhY0V5DzKCBWKKYMMSZBJlcmHZwEEt4MJrILOLDHDy9o1ixIUniHGgBXxwqe25koRfNqMAMqFr5eltNx9Upr2W0ttRNyu6Ji61jypi/7IPFYHXIO//T6p8s0cH3qUEWqqYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0037.namprd12.prod.outlook.com (2603:10b6:903:129::23)
 by BN6PR12MB1412.namprd12.prod.outlook.com (2603:10b6:404:1b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Wed, 6 Nov
 2019 06:57:05 +0000
Received: from DM3NAM03FT015.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by CY4PR12CA0037.outlook.office365.com
 (2603:10b6:903:129::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 06:57:04 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT015.mail.protection.outlook.com (10.152.82.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Wed, 6 Nov 2019 06:57:04 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 00:57:03 -0600
Received: from jesse-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 00:57:02 -0600
From: Jesse Zhang <zhexi.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add mutex to protect IB resources
Date: Wed, 6 Nov 2019 14:56:56 +0800
Message-ID: <1573023416-10462-1-git-send-email-zhexi.zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(428003)(199004)(189003)(81166006)(8676002)(305945005)(81156014)(53416004)(2351001)(186003)(8936002)(51416003)(36756003)(316002)(86362001)(14444005)(47776003)(7696005)(26005)(16586007)(6916009)(4326008)(50466002)(48376002)(356004)(6666004)(478600001)(2616005)(126002)(476003)(70206006)(70586007)(2906002)(5660300002)(486006)(50226002)(336012)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1412; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c09fa2a-1001-44aa-50aa-08d762868838
X-MS-TrafficTypeDiagnostic: BN6PR12MB1412:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1412C1E64E92DA9E1581A550EF790@BN6PR12MB1412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpUaOtFb8CarHSmKyXcEN5XN4BqxVJURIuEMS5rXsWT6Y6zEsaYmAewBpDwEa9AYYCFw9NFFRYtrAUqWKJR5WRAZHO6HVhbJyh4e/rGFsKJF71fKy3dPijTzvkixpzxGr8OG0AxM2NWBxOrH+YY/jX0DDkIQxXq/2DwpxmMN0IYlo9MpUPtaxsnBb4r4LJ5cgOL01+yg9s4nIT4H62+1PZWL1xa8i6wHA1Csg++Zi8pSsN26KB6j4ODhqDy5ffDyccbDZkOcO+Ysmyi6dVJGmNLX8MXKw/SW2W8nKpS1SdKSt+SEPjw5ludrQGF6tYECQ0t7kSGVUX8vTVCdpLCd7YQj7Qo50K0bzB193VonRKQjF92cHLmh2e+lwdVyr54zvnsbGFN1qlej4rPQajEyCNFl3zwpU6QkwOH5rG8nmzzTxRhUA0VCrD7jInkoNgMa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 06:57:04.5905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c09fa2a-1001-44aa-50aa-08d762868838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1412
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW+iANClN7HR44ru1F6o1G+lnj39UjM0b/2J3yFUCmY=;
 b=1QSOA/GTG2qKxxIAqqXyOQvVAownNb9yXzgmC1FUjMFvOB2U9JLO918XbATkTal7nLa0uzDjD9A9644U5hsKCW/RsZMsYOXA5yO2Q6IKaHRX/ZIuxnsCxtY2CvleDc6fsYr4/Yby2Ld4OEd76sRHKjuuH+KQU06d/rgOxpO8QQ0=
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
Message-ID: <20191106065656.y0OOsLxPXm5aRRp9TQ_Q9OzMovqkOgUSsWmwJDJubms@z>

VW5sb2FkaW5nIGRyaXZlciBoYXMgY2FsbCB0cmFjZSB3aGVuIHVubG9hZGluZyBoYXBwZW5zCjJz
IGFmdGVyIGxvYWRpbmcgZHJpdmVyLgoKU2luY2UgcmluZyB0ZXN0IGFyZSBkZWxheWVkIGFmdGVy
IGluaXRpYWxpemluZyBkcml2ZXIsCml0IGlzIHBvc3NpYmxlIHRoYXQgZHJpdmVyIGhhcyBiZWVu
IHVubG9hZGVkIGJlZm9yZSBvcgp3aGlsZSBkb2luZyByaW5nIHRlc3QuCgpBZGQgbXV0ZXggdG8g
cHJldmVudCByaW5nIHRlc3QgYW5kIGRyaXZlciBmaW5hbGl6YXRpb24Kb2NjdXJzIGF0IHRoZSBz
YW1lIHRpbWUgYW5kIGNoZWNrIGJlZm9yZSBkb2luZyByaW5nIHRlc3QKaWYgcmVxdWlyZWQgcmVz
b3VyY2VzIHN0aWxsIGV4aXN0LgoKQ2hhbmdlLUlkOiBJMjdiNTJjMmM2MzBhZDM4NTNjNjM4NGU3
YjY5MDZmMGZhZTU5MGVhZApTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8emhleGkuemhhbmdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAg
fCAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDEgKwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgICAgIHwgOSArKysrKysrKysK
IDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmgKaW5kZXggMDQ2OWNjNS4uYjgyNWFkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmgKQEAgLTkyMyw2ICs5MjMsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7CiAJc3Ry
dWN0IGFtZGdwdV9yaW5nCQkqcmluZ3NbQU1ER1BVX01BWF9SSU5HU107CiAJYm9vbAkJCQlpYl9w
b29sX3JlYWR5OwogCXN0cnVjdCBhbWRncHVfc2FfbWFuYWdlcglyaW5nX3RtcF9ibzsKKwlzdHJ1
Y3QgbXV0ZXgJCQlpYl9sb2NrOwogCiAJLyogaW50ZXJydXB0cyAqLwogCXN0cnVjdCBhbWRncHVf
aXJxCQlpcnE7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5k
ZXggYjJmMzhiMC4uOGFkYmIyNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwpAQCAtMjgwNiw2ICsyODA2LDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAltdXRleF9pbml0KCZhZGV2LT5sb2NrX3Jlc2V0
KTsKIAltdXRleF9pbml0KCZhZGV2LT52aXJ0LmRwbV9tdXRleCk7CiAJbXV0ZXhfaW5pdCgmYWRl
di0+cHNwLm11dGV4KTsKKwltdXRleF9pbml0KCZhZGV2LT5pYl9sb2NrKTsKIAogCXIgPSBhbWRn
cHVfZGV2aWNlX2NoZWNrX2FyZ3VtZW50cyhhZGV2KTsKIAlpZiAocikKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2liLmMKaW5kZXggZDEyMWJiZC4uZWY1MzM5ZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKQEAgLTMxNywxMCArMzE3LDEyIEBAIGludCBhbWRn
cHVfaWJfcG9vbF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICovCiB2b2lkIGFt
ZGdwdV9pYl9wb29sX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CisJbXV0ZXhf
bG9jaygmYWRldi0+aWJfbG9jayk7CiAJaWYgKGFkZXYtPmliX3Bvb2xfcmVhZHkpIHsKIAkJYW1k
Z3B1X3NhX2JvX21hbmFnZXJfZmluaShhZGV2LCAmYWRldi0+cmluZ190bXBfYm8pOwogCQlhZGV2
LT5pYl9wb29sX3JlYWR5ID0gZmFsc2U7CiAJfQorCW11dGV4X3VubG9jaygmYWRldi0+aWJfbG9j
ayk7CiB9CiAKIC8qKgpAQCAtMzY0LDYgKzM2NiwxMSBAQCBpbnQgYW1kZ3B1X2liX3JpbmdfdGVz
dHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZyA9IGFkZXYtPnJpbmdzW2ldOwogCQlsb25nIHRtbzsKIAorCQlpZiAoYWRldi0+c2h1dGRvd24p
IHsKKwkJCURSTV9JTkZPKCJEZXZpY2UgZmluYWxpemVkLCBza2lwIHVuZmluaXNoZWQgcmluZyB0
ZXN0XG4iKTsKKwkJCXJldHVybiAwOworCQl9CisKIAkJLyogS0lRIHJpbmdzIGRvbid0IGhhdmUg
YW4gSUIgdGVzdCBiZWNhdXNlIHdlIG5ldmVyIHN1Ym1pdCBJQnMKIAkJICogdG8gdGhlbSBhbmQg
dGhleSBoYXZlIG5vIGludGVycnVwdCBzdXBwb3J0LgogCQkgKi8KQEAgLTM4MSw3ICszODgsOSBA
QCBpbnQgYW1kZ3B1X2liX3JpbmdfdGVzdHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CWVsc2UKIAkJCXRtbyA9IHRtb19nZng7CiAKKwkJbXV0ZXhfbG9jaygmYWRldi0+aWJfbG9jayk7
CiAJCXIgPSBhbWRncHVfcmluZ190ZXN0X2liKHJpbmcsIHRtbyk7CisJCW11dGV4X3VubG9jaygm
YWRldi0+aWJfbG9jayk7CiAJCWlmICghcikgewogCQkJRFJNX0RFVl9ERUJVRyhhZGV2LT5kZXYs
ICJpYiB0ZXN0IG9uICVzIHN1Y2NlZWRlZFxuIiwKIAkJCQkgICAgICByaW5nLT5uYW1lKTsKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
