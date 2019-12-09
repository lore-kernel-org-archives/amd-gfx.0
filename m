Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50F7C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 01:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62972206DB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 01:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62972206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CFAD89EA6;
	Mon,  9 Dec 2019 01:42:45 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEA189E63
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 01:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZgRBS684VqtEVCI9DpLtgKk1CNuIAfOEZawow2+CgGaUJXpqFNo63nRNPBOz3oH2+g5vmjf9CRNQuivF2pcSYSVdqG5Gp6msiTE1b/NRGe5V9ZSt9tVIHBKqPVfOkSWuAxzsAWh7fHaGhFZGSy6yn36l30QGrI/uWCAEcE4JiU6peTWIygQ6lhD4gUy/fztErsVEac5fIMbsQjGj6Md8lTSDdqlqUNElaOUEE9Gvp+1CuwzRoZ8w41M+3b0b9hn5PwV8plXMAgREGwoIW60nOhGWpO2AlR2LATHe5ZlSiJ0YvCTUidM7ULvtq3v4MwrNr2D4LIzFhReOsoHOV0kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUlkoqovFmZbG8FFkCxtqa31YoAfrx4jWok+qpLEttk=;
 b=dWR8eviw+p+TnItujG91Cnw0JMLx0R9xxsVTTGmLpvSrdO+8frHPHDkrezKSw7vAyKiwZWiqrvJXweDOdG6+ZV+DQm1yQkr3jLJmywRc21F2bu4JICbnteNKoOv2R5FmGbFX7j0Y++TQKcGRHQof73ZtRJ1Ktgbo+V0dp6iBSfeLR1vlMsm/eqDP2jeaXmi9Hd/OFYBaUsKbI42Jt/O5nG0qAj2EkRH1Cuv+jeHXUk9grmVrKBm7oQnMoUcCOOrXDQxTZtzgJdQGYv5r9zTrQ+wS5k9IfOpq558YV24Le1qiM35lp0K0N+axmPVdvKsCeRTd8pVEhxdYxkqhsbpiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3869.namprd12.prod.outlook.com (10.255.239.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 01:42:39 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 01:42:38 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit V2
Date: Mon,  9 Dec 2019 09:42:18 +0800
Message-Id: <20191209014218.29887-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d732c1d2-492f-4435-5402-08d77c4912a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:|MN2PR12MB3869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38698CAB415E2C7651EA818DE4580@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(305945005)(2906002)(2870700001)(8936002)(6512007)(50226002)(6916009)(81156014)(81166006)(8676002)(6486002)(316002)(48376002)(86362001)(36756003)(50466002)(478600001)(1076003)(99286004)(52116002)(5660300002)(186003)(26005)(6506007)(44832011)(2616005)(4326008)(6666004)(66556008)(66476007)(66946007)(51416003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3869;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TGwNU4nHZ+RI7BszQrTTKnDFE0ogrKKLTeH6jLN80S/HEt/ykk9XBj+IAAGxhR0mwP1izxfCe4tF8ORCEft+mHYn8gMOTbSt0Y/v7+mOD5QFLTO1R2xaU4zGsFFYCeB/zXH3k7edBGcyuOnSx+OHtYirnqazMb23E9/aqhoInZGmfst+PmG6MiC7geQtUAXTH7v+EtmRe9sq74oJp4cXfKsFsw67akztZJMGqvwCFxLG0C+iQu5C5xveXcqrMfwwpOxPYJCcR6Cmj9jRmoWEU0RYIG0YFVcxTT/kuW86ISaFrAm+gv3C8bOkKSPh8GlbSxwajln8YWzMOAogwdfMJG3rXdedi5lk1xIQu/istw+qPFV9hFp1SWwnFtlfscm/4dqCoTWnIrHRdzOVrPWwKtUGRZcErOYVOUyzjY6SIj5tf6XBGE1bQw1QcG5SFes
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d732c1d2-492f-4435-5402-08d77c4912a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 01:42:38.6947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P18TBPvW9q54ejvZS5E7rJkWqca8rreg7fY2Yu2m+I6VUAHarQbY27XyDGyqLpPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUlkoqovFmZbG8FFkCxtqa31YoAfrx4jWok+qpLEttk=;
 b=veFhkhr18nbM4tHQ1spRQhYz3gU+Tve25UQcaN+x7pLDq1Ak56qMfPTvhfKp8YHPsX4R/r1kCDy54lIJhh2jGDhOyi91mY4GLNM6p9NZd4gdta1eFF58Db8E4ErVKdn2eufWVSG++OLzkyBOlDw+zEA3hOFxS3qGa2G+No0BQxM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Zhigang.Luo@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBuZWVkZWQgZm9yIGNvbWluZyBhc2ljIGluaXQgb24gcGVyZm9ybWluZyBncHUgcmVz
ZXQuCgpWMjogdXNlIG5vbi1hc2ljIHNwZWNpZmljIHByb2dyYW1pbmcgd2F5CgpDaGFuZ2UtSWQ6
IElmMzY3MWEyNGQyMzllM2QyODg2NjVmYWRhYTJjNDBjODdkNWRhNDBiClNpZ25lZC1vZmYtYnk6
IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvc211X3YxMV8wLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVf
djExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCmluZGV4
IGY1NDY5YWQ0MzkyOS4uNzc4MWQyNDVmOGVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfdjExXzAuYwpAQCAtMTY3NiwxMCArMTY3NiwxNyBAQCBpbnQgc211X3YxMV8wX2Jh
Y29fc2V0X3N0YXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9iYWNvX3N0YXRl
IHN0YXRlKQogCQl9CiAJfSBlbHNlIHsKIAkJcmV0ID0gc211X3NlbmRfc21jX21zZyhzbXUsIFNN
VV9NU0dfRXhpdEJhY28pOworCQlpZiAocmV0KQorCQkJZ290byBvdXQ7CisKIAkJYmlmX2Rvb3Ji
ZWxsX2ludHJfY250bCA9IFJFR19TRVRfRklFTEQoYmlmX2Rvb3JiZWxsX2ludHJfY250bCwKIAkJ
CQkJCUJJRl9ET09SQkVMTF9JTlRfQ05UTCwKIAkJCQkJCURPT1JCRUxMX0lOVEVSUlVQVF9ESVNB
QkxFLCAwKTsKIAkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0RPT1JCRUxMX0lOVF9DTlRM
LCBiaWZfZG9vcmJlbGxfaW50cl9jbnRsKTsKKworCQkvKiBjbGVhciB2YmlvcyBzY3JhdGNoIDYg
YW5kIDcgZm9yIGNvbWluZyBhc2ljIHJlaW5pdCAqLworCQlXUkVHMzIoYWRldi0+Ymlvc19zY3Jh
dGNoX3JlZ19vZmZzZXQgKyA2LCAwKTsKKwkJV1JFRzMyKGFkZXYtPmJpb3Nfc2NyYXRjaF9yZWdf
b2Zmc2V0ICsgNywgMCk7CiAJfQogCWlmIChyZXQpCiAJCWdvdG8gb3V0OwotLSAKMi4yNC4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
