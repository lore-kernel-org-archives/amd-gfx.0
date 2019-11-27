Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3ACC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EA12070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EA12070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D066E4EA;
	Wed, 27 Nov 2019 09:15:57 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820044.outbound.protection.outlook.com [40.107.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18EE6E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVq1za4vfBK9bNrwrNt9vx4orzTTN3fcJ/HGUorZRZNpXchX4qA4YrzWoPSN8Ud/z1gbudTBTH+6tG444USZG2Ul/Ok5g4DMyMajgxTX6LA7O+rTPwDR9TBCne+eN6VfdZG376/a9ITEFhwz6Epupz5u41mRtHqM4NBwvA/k0i9+6IAFHBM899iWHrXsI7OpPHjsIeJgIOqAg916+PsEQnadmEc+ZM1SnfoKJsJCRBVAgb+6sBC9Uj8u/JF1b1HucWP6/TmTwDDGWUwBeANCssRVT4yn3+qKnUFzg+8F0t5Ks0nZfygGIaOq6X3FogQImZbgfiMMNIkk/lZkaNxEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZLIOCiguN+ToZ1bmL1EX9P2QPreRi1XwyYNRjxJAao=;
 b=Yj8qONAY3kyS1xOwcUYJQxJHGBz2/TJdVYHhVFz0WU2kWNDDD6UvbRCR5+wDndoC602BdOwroRBZIKzbNy9RTIIbgVTokt2GxS1ACtRYrbDZBZCB0OcnXsSopwo4R/g3PzF341Pi0ac720ADb5QJ50FiL0J+A0ALS0G8rYVCXl03ODCTmHD6S8FqjneaMPnvoYSRxM4UPUUPY91u9LzycYZnLqmvsZ/WG7qzf/M5aQVypTvQ/Tzwy4zJTUB+kfnKspucfUHi90ZEV8VCLUQ/X9n0IdObdL3MmV97lLd3quaN8P3WECNwIyafIrVnW88kVA9aFF1vHrV21GUZPb0uVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0071.namprd12.prod.outlook.com (2603:10b6:802:20::42)
 by BYAPR12MB3304.namprd12.prod.outlook.com (2603:10b6:a03:139::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Wed, 27 Nov
 2019 09:15:54 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by SN1PR12CA0071.outlook.office365.com
 (2603:10b6:802:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:54 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:53 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:51 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:48 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for XGMI
Date: Wed, 27 Nov 2019 17:15:26 +0800
Message-ID: <1574846129-4826-6-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(428003)(199004)(189003)(47776003)(2616005)(478600001)(316002)(50226002)(186003)(5660300002)(44832011)(6666004)(81156014)(81166006)(50466002)(14444005)(426003)(11346002)(446003)(336012)(36756003)(8936002)(305945005)(356004)(2906002)(16586007)(70586007)(86362001)(4326008)(76176011)(48376002)(6916009)(26005)(51416003)(70206006)(54906003)(2351001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3304; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aeee1ed-7e7e-4227-56a6-08d7731a6788
X-MS-TrafficTypeDiagnostic: BYAPR12MB3304:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33040010FBADF6810D3BB3E9F6440@BYAPR12MB3304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJfHsRzwdqbkz1Hn3vBKQNmzMkibEYa0KtPAnB5vy+Wxc+Uf98GNJoQVUSVo6+SezZNnATOxYj1c51EPmOPMWCUlDycQcrl1t4TadAriWynKpfa14j9JIhuwU6KpPR2BJKH5cCj5pPvzMDIPtffQqNpoRVEXpOKABvbXBcf9E6Qe6EAZXudmfobZA5OwAM3IpaU4UlUoJRiw+9wAv7dIWIjp6I/TvNziT/nha1l18TPS+HX4qOCtIvff5U8dFT1gP9zEBF+1k0fTdud3wMqOvg5U/VHZ74DBhYsQ8CVqHEoZdHvaiDbm8sv3SDBzYRfu3cOnkBbC+zrhZBgVOaGaKiGenUWXGY0MkvgV1FxSrmgaJ+h/OcJZ+jO8iJeVw4PZdPc2UslFSXXPG9SxAJBC4aNrBbH7e8FCG5HBVFN9GTT0XQ82GBxjnPT92s8wbX2H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:53.8436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeee1ed-7e7e-4227-56a6-08d7731a6788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZLIOCiguN+ToZ1bmL1EX9P2QPreRi1XwyYNRjxJAao=;
 b=SvWSybrnJzFfbywlvf9Z3UkWAfWO3wLQNCwrPZFTskyPWOSH6xJ2zVTydjdpQDBQ1eWo9VZ9eBdaVa7qQl4u2ipzIlYK7jtP3iFD7QgJfR0gpnY++RNL8Of9RzK+XmZkcxPt4zD7eYkuDvaVbdM0j9Ck96DZvrpHt65rr+mfmqE=
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <le.ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127091526.EFMToiY4AeVccw0XI9P7UComvxJqeHYUo2G8F1igVwg@z>

Q3VycmVudGx5IGVhY2ggWEdNSSBub2RlIHJlc2V0IHdxIGRvZXMgbm90IHJ1biBpbiBwYXJyYWxs
ZWwgYmVjYXVzZSBzYW1lIHdvcmsKaXRlbSBib3VuZCB0byBzYW1lIGNwdSBydW5zIGluIHNlcXVl
bmNlLiBTbyBjaGFuZ2UgdG8gYm91bmQgdGhlIHhnbWlfcmVzZXRfd29yawppdGVtIHRvIGRpZmZl
cmVudCBjcHVzLgoKWEdNSSByZXF1aXJlcyBhbGwgbm9kZXMgZW50ZXIgaW50byBiYWNvIHdpdGhp
biB2ZXJ5IGNsb3NlIHByb3hpbWl0eSBiZWZvcmUKYW55IG5vZGUgZXhpdCBiYWNvLiBTbyBzY2hl
ZHVsZSB0aGUgeGdtaV9yZXNldF93b3JrIHdxIHR3aWNlIGZvciBlbnRlci9leGl0CmJhY28gcmVz
cGVjdGl2ZWx5LgoKVGhlIGRlZmF1bHQgcmVzZXQgY29kZSBwYXRoIGFuZCBtZXRob2RzIGRvIG5v
dCBjaGFuZ2UgZm9yIHZlZ2EyMCBwcm9kdWN0aW9uOgogIC0gYmFjbyByZXNldCB3aXRob3V0IHhn
bWkvcmFzCiAgLSBwc3AgcmVzZXQgd2l0aCB4Z21pL3JhcwoKVG8gZW5hYmxlIGJhY28gZm9yIFhH
TUkvUkFTIGNhc2UsIGJvdGggMiBjb25kaXRpb25zIGJlbG93IGFyZSBuZWVkZWQ6CiAgLSBhbWRn
cHVfcmFzX2VuYWJsZT0yCiAgLSBiYWNvLXN1cHBvcnRlZCBzbXUgZmlybXdhcmUKClRoZSBjYXNl
IHRoYXQgUFNQIHJlc2V0IGFuZCBiYWNvIHJlc2V0IGNvZXhpc3Qgd2l0aGluIGFuIFhHTUkgaGl2
ZSBpcyBub3QgaW4KdGhlIGNvbnNpZGVyYXRpb24uCgpDaGFuZ2UtSWQ6IEk5YzA4Y2Y5MDEzNGY5
NDBiNDJlMjBkMjEyOWZmODdmYmE3NjFjNTMyClNpZ25lZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8
ICAyICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDc4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA3MCBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmlu
ZGV4IGQxMjBmZTUuLjA4OTI5ZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBA
IC05OTgsNiArOTk4LDggQEAgc3RydWN0IGFtZGdwdV9kZXZpY2UgewogCWludAkJCQlwc3RhdGU7
CiAJLyogZW5hYmxlIHJ1bnRpbWUgcG0gb24gdGhlIGRldmljZSAqLwogCWJvb2wgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcnVucG07CisKKwlib29sCQkJCWluX2JhY287CiB9OwogCiBzdGF0
aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNlICphbWRncHVfdHRtX2FkZXYoc3RydWN0IHR0
bV9ib19kZXZpY2UgKmJkZXYpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKaW5kZXggYmQzODdiYi4uNzFhYmZlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjY1NCw3ICsyNjU0LDEzIEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV9kZXZpY2VfeGdtaV9yZXNldF9mdW5jKHN0cnVjdCB3b3JrX3N0cnVjdCAqX193b3JrKQog
CXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0KIAkJY29udGFpbmVyX29mKF9fd29yaywgc3Ry
dWN0IGFtZGdwdV9kZXZpY2UsIHhnbWlfcmVzZXRfd29yayk7CiAKLQlhZGV2LT5hc2ljX3Jlc2V0
X3JlcyA9ICBhbWRncHVfYXNpY19yZXNldChhZGV2KTsKKwlpZiAoYW1kZ3B1X2FzaWNfcmVzZXRf
bWV0aG9kKGFkZXYpID09IEFNRF9SRVNFVF9NRVRIT0RfQkFDTykKKwkJYWRldi0+YXNpY19yZXNl
dF9yZXMgPSAoYWRldi0+aW5fYmFjbyA9PSBmYWxzZSkgPworCQkJCWFtZGdwdV9kZXZpY2VfYmFj
b19lbnRlcihhZGV2LT5kZGV2KSA6CisJCQkJYW1kZ3B1X2RldmljZV9iYWNvX2V4aXQoYWRldi0+
ZGRldik7CisJZWxzZQorCQlhZGV2LT5hc2ljX3Jlc2V0X3JlcyA9IGFtZGdwdV9hc2ljX3Jlc2V0
KGFkZXYpOworCiAJaWYgKGFkZXYtPmFzaWNfcmVzZXRfcmVzKQogCQlEUk1fV0FSTigiQVNJQyBy
ZXNldCBmYWlsZWQgd2l0aCBlcnJvciwgJWQgZm9yIGRybSBkZXYsICVzIiwKIAkJCSBhZGV2LT5h
c2ljX3Jlc2V0X3JlcywgYWRldi0+ZGRldi0+dW5pcXVlKTsKQEAgLTM3OTYsNiArMzgwMiw3IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2RvX2FzaWNfcmVzZXQoc3RydWN0IGFtZGdwdV9oaXZlX2luZm8g
KmhpdmUsCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKnRtcF9hZGV2ID0gTlVMTDsKIAlib29sIG5l
ZWRfZnVsbF9yZXNldCA9ICpuZWVkX2Z1bGxfcmVzZXRfYXJnLCB2cmFtX2xvc3QgPSBmYWxzZTsK
IAlpbnQgciA9IDA7CisJaW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKIAogCS8qCiAJICog
QVNJQyByZXNldCBoYXMgdG8gYmUgZG9uZSBvbiBhbGwgSEdNSSBoaXZlIG5vZGVzIEFTQVAKQEAg
LTM4MDMsMjEgKzM4MTAsMjQgQEAgc3RhdGljIGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1
Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSwKIAkgKi8KIAlpZiAobmVlZF9mdWxsX3Jlc2V0KSB7
CiAJCWxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYsIGRldmljZV9saXN0X2hhbmRsZSwgZ21j
LnhnbWkuaGVhZCkgewotCQkJLyogRm9yIFhHTUkgcnVuIGFsbCByZXNldHMgaW4gcGFyYWxsZWwg
dG8gc3BlZWQgdXAgdGhlIHByb2Nlc3MgKi8KKwkJCS8qCisJCQkgKiBGb3IgWEdNSSBydW4gYWxs
IHJlc2V0cyBpbiBwYXJhbGxlbCB0byBzcGVlZCB1cCB0aGUKKwkJCSAqIHByb2Nlc3MgYnkgc2No
ZWR1bGluZyB0aGUgaGlnaHByaSB3cSBvbiBkaWZmZXJlbnQKKwkJCSAqIGNwdXMuIEZvciBYR01J
IHdpdGggYmFjbyByZXNldCwgYWxsIG5vZGVzIG11c3QgZW50ZXIKKwkJCSAqIGJhY28gd2l0aGlu
IGNsb3NlIHByb3hpbWl0eSBiZWZvcmUgYW55b25lIGV4aXQuCisJCQkgKi8KIAkJCWlmICh0bXBf
YWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgewotCQkJCWlmICghcXVldWVf
d29yayhzeXN0ZW1faGlnaHByaV93cSwgJnRtcF9hZGV2LT54Z21pX3Jlc2V0X3dvcmspKQorCQkJ
CWlmICghcXVldWVfd29ya19vbihjcHUsIHN5c3RlbV9oaWdocHJpX3dxLAorCQkJCQkJICAgJnRt
cF9hZGV2LT54Z21pX3Jlc2V0X3dvcmspKQogCQkJCQlyID0gLUVBTFJFQURZOworCQkJCWNwdSA9
IGNwdW1hc2tfbmV4dChjcHUsIGNwdV9vbmxpbmVfbWFzayk7CiAJCQl9IGVsc2UKIAkJCQlyID0g
YW1kZ3B1X2FzaWNfcmVzZXQodG1wX2FkZXYpOwotCi0JCQlpZiAocikgewotCQkJCURSTV9FUlJP
UigiQVNJQyByZXNldCBmYWlsZWQgd2l0aCBlcnJvciwgJWQgZm9yIGRybSBkZXYsICVzIiwKLQkJ
CQkJIHIsIHRtcF9hZGV2LT5kZGV2LT51bmlxdWUpOworCQkJaWYgKHIpCiAJCQkJYnJlYWs7Ci0J
CQl9CiAJCX0KIAotCQkvKiBGb3IgWEdNSSB3YWl0IGZvciBhbGwgUFNQIHJlc2V0cyB0byBjb21w
bGV0ZSBiZWZvcmUgcHJvY2VlZCAqLworCQkvKiBGb3IgWEdNSSB3YWl0IGZvciBhbGwgd29yayB0
byBjb21wbGV0ZSBiZWZvcmUgcHJvY2VlZCAqLwogCQlpZiAoIXIpIHsKIAkJCWxpc3RfZm9yX2Vh
Y2hfZW50cnkodG1wX2FkZXYsIGRldmljZV9saXN0X2hhbmRsZSwKIAkJCQkJICAgIGdtYy54Z21p
LmhlYWQpIHsKQEAgLTM4MjYsMTEgKzM4MzYsNTkgQEAgc3RhdGljIGludCBhbWRncHVfZG9fYXNp
Y19yZXNldChzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSwKIAkJCQkJciA9IHRtcF9hZGV2
LT5hc2ljX3Jlc2V0X3JlczsKIAkJCQkJaWYgKHIpCiAJCQkJCQlicmVhazsKKwkJCQkJaWYoQU1E
X1JFU0VUX01FVEhPRF9CQUNPID09CisJCQkJCSAgIGFtZGdwdV9hc2ljX3Jlc2V0X21ldGhvZCh0
bXBfYWRldikpCisJCQkJCQl0bXBfYWRldi0+aW5fYmFjbyA9IHRydWU7CiAJCQkJfQogCQkJfQog
CQl9Ci0JfQogCisJCS8qCisJCSAqIEZvciBYR01JIHdpdGggYmFjbyByZXNldCwgbmVlZCBleGl0
IGJhY28gcGhhc2UgYnkgc2NoZWR1bGluZworCQkgKiB4Z21pX3Jlc2V0X3dvcmsgb25lIG1vcmUg
dGltZS4gUFNQIHJlc2V0IHNraXBzIHRoaXMgcGhhc2UuCisJCSAqIE5vdCBhc3N1bWUgdGhlIHNp
dHVhdGlvbiB0aGF0IFBTUCByZXNldCBhbmQgYmFjbyByZXNldAorCQkgKiBjb2V4aXN0IHdpdGhp
biBhbiBYR01JIGhpdmUuCisJCSAqLworCisJCWlmICghcikgeworCQkJY3B1ID0gc21wX3Byb2Nl
c3Nvcl9pZCgpOworCQkJbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xpc3Rf
aGFuZGxlLAorCQkJCQkgICAgZ21jLnhnbWkuaGVhZCkgeworCQkJCWlmICh0bXBfYWRldi0+Z21j
LnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMQorCQkJCSAgICAmJiBBTURfUkVTRVRfTUVUSE9E
X0JBQ08gPT0KKwkJCQkgICAgYW1kZ3B1X2FzaWNfcmVzZXRfbWV0aG9kKHRtcF9hZGV2KSkgewor
CQkJCQlpZiAoIXF1ZXVlX3dvcmtfb24oY3B1LAorCQkJCQkJc3lzdGVtX2hpZ2hwcmlfd3EsCisJ
CQkJCQkmdG1wX2FkZXYtPnhnbWlfcmVzZXRfd29yaykpCisJCQkJCQlyID0gLUVBTFJFQURZOwor
CQkJCQlpZiAocikKKwkJCQkJCWJyZWFrOworCQkJCQljcHUgPSBjcHVtYXNrX25leHQoY3B1LCBj
cHVfb25saW5lX21hc2spOworCQkJCX0KKwkJCX0KKwkJfQorCisJCWlmICghcikgeworCQkJbGlz
dF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xpc3RfaGFuZGxlLAorCQkJCQkgICAg
Z21jLnhnbWkuaGVhZCkgeworCQkJCWlmICh0bXBfYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2Fs
X25vZGVzID4gMQorCQkJCSAgICAmJiBBTURfUkVTRVRfTUVUSE9EX0JBQ08gPT0KKwkJCQkgICAg
YW1kZ3B1X2FzaWNfcmVzZXRfbWV0aG9kKHRtcF9hZGV2KSkgeworCQkJCQlmbHVzaF93b3JrKCZ0
bXBfYWRldi0+eGdtaV9yZXNldF93b3JrKTsKKwkJCQkJciA9IHRtcF9hZGV2LT5hc2ljX3Jlc2V0
X3JlczsKKwkJCQkJaWYgKHIpCisJCQkJCQlicmVhazsKKwkJCQkJdG1wX2FkZXYtPmluX2JhY28g
PSBmYWxzZTsKKwkJCQl9CisJCQl9CisJCX0KKworCQlpZiAocikgeworCQkJRFJNX0VSUk9SKCJB
U0lDIHJlc2V0IGZhaWxlZCB3aXRoIGVycm9yLCAlZCBmb3IgZHJtIGRldiwgJXMiLAorCQkJCSBy
LCB0bXBfYWRldi0+ZGRldi0+dW5pcXVlKTsKKwkJCWdvdG8gZW5kOworCQl9CisJfQogCiAJbGlz
dF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xpc3RfaGFuZGxlLCBnbWMueGdtaS5o
ZWFkKSB7CiAJCWlmIChuZWVkX2Z1bGxfcmVzZXQpIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
