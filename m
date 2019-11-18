Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F37C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 10:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0130320727
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 10:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0130320727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4ED8897EE;
	Mon, 18 Nov 2019 10:07:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E47189780
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 10:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHrGPNB9Xip/nZ2o5buzxVbJRFB2xVHITA5JnJQSb+v0G8YEV/iBf/CxOblCCcP/B8LwbToxwaoYjsSDFT8dKo7EjdA9dOpkx9xi1ojnLzZ37GGjVIgfM7OBybI3EKj1rHW1qNns0PtYiPcPTiJSm5B/g/5j2VPEHdUAERnw4Bo1SCHkHIvqfMkkQUJGoc13Ihdc2FlpFDS0WR2O+vL92s06E47XzFayRaNSjPkblfu5ur+UZK2+LL4G4cqu7zUsiuXuAwoYPnF8HsUYFE2iZyCnAjxl5jxVU01t+odVuGE7yPPwz/iTO8dRHO+rFzFjwcvgOdwazV6twXT8B4UjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IhtO0f1eVX762OeSBHvHGBUpH3IvhqqGhehYPi4IMM=;
 b=cgwfof4xBW1JGxZturtOYqjGGmf+JpaTGtmgNOb2WzKlAEmtMYb1PKxqCHsDS3qzej8D/lAj6wt0JbQGNQ+ROLJ+luVLNwixQv72n8kwO5U7M4IlLHshVbgoUzz/Jem0ixLPifWov3gRlxPZxUj9ZpQEvvFZgaGIWiPTsgfnO8V/IKXkfssD66Zw3KZWbTK3Xpo135nCu7b9hLcDsl3+TGKaUUUkM0PVLZvtMdcQvrvQe5qiSe0AQOatkiD6jIfoZlJOTXBI/LpSX29C3mhLzVBKoU5wWEk+w7raEblo4XgC0bzFCtjauUFxtOtqn0vT+Iio60VOLiI+w0Z7vB0Csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0043.namprd12.prod.outlook.com (2603:10b6:903:129::29)
 by SN1PR12MB2398.namprd12.prod.outlook.com (2603:10b6:802:26::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.29; Mon, 18 Nov
 2019 10:07:37 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by CY4PR12CA0043.outlook.office365.com
 (2603:10b6:903:129::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 18 Nov 2019 10:07:36 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 18 Nov 2019 10:07:36 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Nov
 2019 04:07:35 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 18 Nov 2019 04:07:33 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add helper func for psp ring cmd submission
Date: Mon, 18 Nov 2019 18:07:22 +0800
Message-ID: <20191118100723.19824-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118100723.19824-1-Hawking.Zhang@amd.com>
References: <20191118100723.19824-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(428003)(189003)(199004)(16586007)(8676002)(81166006)(81156014)(48376002)(50466002)(6636002)(26005)(110136005)(47776003)(50226002)(186003)(1076003)(5660300002)(316002)(486006)(426003)(356004)(6666004)(478600001)(11346002)(446003)(476003)(305945005)(70206006)(70586007)(2616005)(126002)(53416004)(8936002)(86362001)(14444005)(51416003)(7696005)(76176011)(336012)(36756003)(2906002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2398; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53e567a1-e58d-4823-fc68-08d76c0f2308
X-MS-TrafficTypeDiagnostic: SN1PR12MB2398:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23987A8AF886E970CEA436F3FC4D0@SN1PR12MB2398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9j3TdcVWfK+b7z2cRW81ZBDXjEbzFoCp4Q3Patw2fv4TweyPGavRTmTP0yqNInWJ4k2KwOwURAY9gwWq/zOL1CDrOn5N3ug4ktEjyh0fk2TGphIxW7TMxBFQVwiT5wdlEYb141eriw80K9HlTYAVKqbygWUqFp1StX0bRPhKad6XSFeHHyeiJ9a49R4lIerf0fP2oF1VWiRrPpwwB6siJrzQ9P7tOZq3XUgXVDV4admJDtudSNuItjv1XzGYoyFo9udpJEOKbrz1QWAVtL8FlK7pht3pVSvT90xr9s9win4f7vTZ4heNoXAjyXvxwoHvfNO5C1aMuVFcpEMkMVngkCFsWVerpYgCwRC6rx8taB8N8pEJrU0isdenRH3C9+7OG02n45wSMfxh3EZWrewl25vuJDwXfpBbePIt6FHDZqx2odI4gS/Uv1rTnAWnNVO9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 10:07:36.2704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e567a1-e58d-4823-fc68-08d76c0f2308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IhtO0f1eVX762OeSBHvHGBUpH3IvhqqGhehYPi4IMM=;
 b=NT3omXgodkSzNoVs/G0Yvaf43jmZyZy3rxdmuPS9ppGfROrJiNzydGxdDJqOfQEJKmQi1UydYrM5ZEci1fGkQyOBFMcOWwpRvu/ahsSsOSiIaDRalmRAjR3AXMFyFPAT9jrk/bhoUhnsX1nmb35AardeigSGvL4YNZAhGH+MBJc=
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
Message-ID: <20191118100722.ICNIORK7Scpn_8GGYwLRoFwZF4wVde6loW-Rrt899kQ@z>

RXhjZXB0IGZvciByaW5nIHdwdHIgdXBkYXRlLCB0aGUgcHNwIHJpbmcgY21kIHN1Ym1pc3Npb24K
ZnVuY3Rpb24gc2hvdWxkbid0IGJlIElQIHNwZWNpZmljIG9uZS4gQ3JlYXRlIGEgY29tbW9uCmhl
bHBlciBmdW5jdGlvbiB0byBiZSBzaGFyZWQgZm9yIGFsbCB0aGUgQVNJQ3MuCgpDaGFuZ2UtSWQ6
IEljNTlmMjJmNzYyZmM3NTgwZmQ5NDM4ZDg2NWQzN2Q1OTk2Y2U4Yjg0ClNpZ25lZC1vZmYtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmggfCAgNCArKwogMiBmaWxl
cyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCmluZGV4IDk2MjFlMjA3YTljYS4uMjI1YWJkNDJiOGRlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0xNzEwLDYgKzE3MTAsNTYgQEAgaW50IHBz
cF91cGRhdGVfdmNuX3NyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBpbnN0X2lk
eCwKIAlyZXR1cm4gcHNwX2V4ZWN1dGVfbnBfZndfbG9hZCgmYWRldi0+cHNwLCAmdWNvZGUpOwog
fQogCitpbnQgcHNwX3JpbmdfY21kX3N1Ym1pdChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKKwkJ
CXVpbnQ2NF90IGNtZF9idWZfbWNfYWRkciwKKwkJCXVpbnQ2NF90IGZlbmNlX21jX2FkZHIsCisJ
CQlpbnQgaW5kZXgpCit7CisJdW5zaWduZWQgaW50IHBzcF93cml0ZV9wdHJfcmVnID0gMDsKKwlz
dHJ1Y3QgcHNwX2dmeF9yYl9mcmFtZSAqd3JpdGVfZnJhbWUgPSBwc3AtPmttX3JpbmcucmluZ19t
ZW07CisJc3RydWN0IHBzcF9yaW5nICpyaW5nID0gJnBzcC0+a21fcmluZzsKKwlzdHJ1Y3QgcHNw
X2dmeF9yYl9mcmFtZSAqcmluZ19idWZmZXJfc3RhcnQgPSByaW5nLT5yaW5nX21lbTsKKwlzdHJ1
Y3QgcHNwX2dmeF9yYl9mcmFtZSAqcmluZ19idWZmZXJfZW5kID0gcmluZ19idWZmZXJfc3RhcnQg
KworCQlyaW5nLT5yaW5nX3NpemUgLyBzaXplb2Yoc3RydWN0IHBzcF9nZnhfcmJfZnJhbWUpIC0g
MTsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHBzcC0+YWRldjsKKwl1aW50MzJfdCBy
aW5nX3NpemVfZHcgPSByaW5nLT5yaW5nX3NpemUgLyA0OworCXVpbnQzMl90IHJiX2ZyYW1lX3Np
emVfZHcgPSBzaXplb2Yoc3RydWN0IHBzcF9nZnhfcmJfZnJhbWUpIC8gNDsKKworCS8qIEtNIChH
UENPTSkgcHJlcGFyZSB3cml0ZSBwb2ludGVyICovCisJcHNwX3dyaXRlX3B0cl9yZWcgPSBwc3Bf
cmluZ19nZXRfd3B0cihwc3ApOworCisJLyogVXBkYXRlIEtNIFJCIGZyYW1lIHBvaW50ZXIgdG8g
bmV3IGZyYW1lICovCisJLyogd3JpdGVfZnJhbWUgcHRyIGluY3JlbWVudHMgYnkgc2l6ZSBvZiBy
Yl9mcmFtZSBpbiBieXRlcyAqLworCS8qIHBzcF93cml0ZV9wdHJfcmVnIGluY3JlbWVudHMgYnkg
c2l6ZSBvZiByYl9mcmFtZSBpbiBEV09SRHMgKi8KKwlpZiAoKHBzcF93cml0ZV9wdHJfcmVnICUg
cmluZ19zaXplX2R3KSA9PSAwKQorCQl3cml0ZV9mcmFtZSA9IHJpbmdfYnVmZmVyX3N0YXJ0Owor
CWVsc2UKKwkJd3JpdGVfZnJhbWUgPSByaW5nX2J1ZmZlcl9zdGFydCArIChwc3Bfd3JpdGVfcHRy
X3JlZyAvIHJiX2ZyYW1lX3NpemVfZHcpOworCS8qIENoZWNrIGludmFsaWQgd3JpdGVfZnJhbWUg
cHRyIGFkZHJlc3MgKi8KKwlpZiAoKHdyaXRlX2ZyYW1lIDwgcmluZ19idWZmZXJfc3RhcnQpIHx8
IChyaW5nX2J1ZmZlcl9lbmQgPCB3cml0ZV9mcmFtZSkpIHsKKwkJRFJNX0VSUk9SKCJyaW5nX2J1
ZmZlcl9zdGFydCA9ICVwOyByaW5nX2J1ZmZlcl9lbmQgPSAlcDsgd3JpdGVfZnJhbWUgPSAlcFxu
IiwKKwkJCSAgcmluZ19idWZmZXJfc3RhcnQsIHJpbmdfYnVmZmVyX2VuZCwgd3JpdGVfZnJhbWUp
OworCQlEUk1fRVJST1IoIndyaXRlX2ZyYW1lIGlzIHBvaW50aW5nIHRvIGFkZHJlc3Mgb3V0IG9m
IGJvdW5kc1xuIik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCS8qIEluaXRpYWxpemUgS00g
UkIgZnJhbWUgKi8KKwltZW1zZXQod3JpdGVfZnJhbWUsIDAsIHNpemVvZihzdHJ1Y3QgcHNwX2dm
eF9yYl9mcmFtZSkpOworCisJLyogVXBkYXRlIEtNIFJCIGZyYW1lICovCisJd3JpdGVfZnJhbWUt
PmNtZF9idWZfYWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMoY21kX2J1Zl9tY19hZGRyKTsKKwl3cml0
ZV9mcmFtZS0+Y21kX2J1Zl9hZGRyX2xvID0gbG93ZXJfMzJfYml0cyhjbWRfYnVmX21jX2FkZHIp
OworCXdyaXRlX2ZyYW1lLT5mZW5jZV9hZGRyX2hpID0gdXBwZXJfMzJfYml0cyhmZW5jZV9tY19h
ZGRyKTsKKwl3cml0ZV9mcmFtZS0+ZmVuY2VfYWRkcl9sbyA9IGxvd2VyXzMyX2JpdHMoZmVuY2Vf
bWNfYWRkcik7CisJd3JpdGVfZnJhbWUtPmZlbmNlX3ZhbHVlID0gaW5kZXg7CisJYW1kZ3B1X2Fz
aWNfZmx1c2hfaGRwKGFkZXYsIE5VTEwpOworCisJLyogVXBkYXRlIHRoZSB3cml0ZSBQb2ludGVy
IGluIERXT1JEcyAqLworCXBzcF93cml0ZV9wdHJfcmVnID0gKHBzcF93cml0ZV9wdHJfcmVnICsg
cmJfZnJhbWVfc2l6ZV9kdykgJSByaW5nX3NpemVfZHc7CisJcHNwX3Jpbmdfc2V0X3dwdHIocHNw
LCBwc3Bfd3JpdGVfcHRyX3JlZyk7CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBib29sIHBzcF9j
aGVja19md19sb2FkaW5nX3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJ
ZW51bSBBTURHUFVfVUNPREVfSUQgdWNvZGVfdHlwZSkKIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuaAppbmRleCBkNTYyMGM0NmYzZmMuLjQ4MmU3Njc1YjdkYSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuaApAQCAtMzc3LDQgKzM3Nyw4IEBAIGlu
dCBwc3BfcmxjX2F1dG9sb2FkX3N0YXJ0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKTsKIGV4dGVy
biBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gcHNwX3YxMV8wX2lwX2Jsb2Nr
OwogaW50IHBzcF9yZWdfcHJvZ3JhbShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgZW51bSBwc3Bf
cmVnX3Byb2dfaWQgcmVnLAogCQl1aW50MzJfdCB2YWx1ZSk7CitpbnQgcHNwX3JpbmdfY21kX3N1
Ym1pdChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKKwkJCXVpbnQ2NF90IGNtZF9idWZfbWNfYWRk
ciwKKwkJCXVpbnQ2NF90IGZlbmNlX21jX2FkZHIsCisJCQlpbnQgaW5kZXgpOwogI2VuZGlmCi0t
IAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
