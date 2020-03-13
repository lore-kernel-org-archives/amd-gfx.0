Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4323C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2B8206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kxltex4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2B8206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579CE6E2B0;
	Fri, 13 Mar 2020 13:19:50 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1856E2B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrL/SLbzvDadAmg5+kxPEoYYP3ZlP6Cmm6VAMmMQ8t3Y07jIMWVLOTXDAE7WrYTnzyJXprfSR5OngSTXavv48LlQxIoRMCpYXuOP2JSQJZjOxP1lpv93pku0BzC+QYhChOL8pAxzc7GMkRGOdypvnD+LvYrWzyTqjQLPArgpvSR3RA1dYKTImiXXq2PWrc0ki0B7pOz3KSrg8S4VBnhMAgcvBh+O6Ubp7i75h6MehzisA/nKTMvGFsLS/I/ZLQrFEyRyRR0dYqahUqdV3GPNpznDBYpDtjYtaWOlvShSWIo+f0+XccNawo8jKdac1uijFbIlCfzpelGe2sRdhfF77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2DvKzPTas4twa6xs6Nm1zgdbMQCeTM+4j6pf21YAyA=;
 b=JYz2D0GcU8gprcG0VzH/u9b/GkKdR4Ofs+CdV2/4nIZo41badru3kbvgX17nV9ygs+UPD9oZT1yY43dtnHK7iCpZj/RCYGVvO6FfHONozkuga2TsxNXHDpHHUgLiNaSpZ+rIUpZPPQcX6grC5dPu4OKCh4m9iDd7MxpRa3evOHrnEpiyCNTkiQ1XKnev5SuvO4ziEDGBwkfqXj7+/xTyr57oZwcyddPuWWJzUVsvsRqFVL0qt1JbEAcKvq4KAeCz+lG5R+3T3YiUEdLvKdapgZGXOxWUDIeDZVtnTkFT8AA2JtvZSDtpvmovRxOEYiq507EDTC76ik3su/mqq8afUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2DvKzPTas4twa6xs6Nm1zgdbMQCeTM+4j6pf21YAyA=;
 b=Kxltex4/ufGc+GP4dQna0HE8bUYHOhzyHi7qHq30bNtkVv5PNjzoZwnDWZBIcieB216DPlpPCSyvLMyAQVaEdR6IeYcp3Xg8/LEKSnOckK4IydRUoADOLdK1m2ipAQLZ/goTyUxJd+9FQAKO65aHlaYdb2JFnnr3MYY1nbxXDsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2750.namprd12.prod.outlook.com (2603:10b6:805:77::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 13:19:47 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:19:47 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: Add job fence to resv conditionally
Date: Fri, 13 Mar 2020 21:19:17 +0800
Message-Id: <20200313131918.29721-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313131918.29721-1-xinhui.pan@amd.com>
References: <20200313131918.29721-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0182.apcprd02.prod.outlook.com (2603:1096:201:21::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 13:19:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c13805d-735e-4e9b-b935-08d7c75133db
X-MS-TrafficTypeDiagnostic: SN6PR12MB2750:|SN6PR12MB2750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB275039E424EAB461A060D45A87FA0@SN6PR12MB2750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(66476007)(16526019)(7696005)(186003)(316002)(26005)(86362001)(2616005)(36756003)(956004)(66574012)(81166006)(54906003)(52116002)(6666004)(2906002)(8936002)(478600001)(81156014)(5660300002)(6916009)(8676002)(66556008)(4326008)(1076003)(6486002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2750;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKeDSdDYLx43MxdxLBA/6WBDf8iahpNZ8HHTpaJNT6qqJv1v+iZLizO7kyJu2ILRv2bvgaT9E0Z8YNabMEZI25tMMRdcvLs2k1bhVnfVteITS6KWjkDseUklrlOeaVfV7N47jyQjWwJVzrHSdG8eaiSWNwxlkQ7a++PIvSi8ONMxw2XQBzqXhC6d94wQ3o0VywPUdbkGwNMUW5OHfYQZU9j2KQZMpH7jL6lhcQbqbXtX+dpgMdXJTIGYw7WsEhhlaemy2xpqs8OWUsmwhxGza5S0rNWt/RJER2aobasNR53ERjmVQqnMuk9spip4hCB0pvAQz5DQ/hNGBxcbZh54vGGk84z3vvva4ITqf83wkKIDPmYHzMJH5r6P3KzzgKkqIJLMoXVDtqPP2+Q7wXOtcuhK638uRffRmspq9u2n1P47kRSXQ0Nw0Cb1vjSTMk6p
X-MS-Exchange-AntiSpam-MessageData: /xD6p9sMtWHB/8yBNVQJSbLC9dTZjJw8TBQcAZGXQyAPozB54RiLyz2+2PqeEbGC60e0ZBlel5n6NJfPKihda08Asla1H0w9IulK5KwD9OJjmOCo4Hw8LuLoe26d355hQsAPA8NE/q3vvPu/CFu4TA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c13805d-735e-4e9b-b935-08d7c75133db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:19:47.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKVX7b7Jp1h+CYaDKFgEWtnRJzkHGUdIeN5d5FIxyi5bfyCDYjyrmyhlToHD0Y9X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWYgYSBqb2IgbmVlZCBzeW5jIHRoZSBibyByZXN2LCBpdCBpcyBsaWtlbHkgdGhhdCBibyBuZWVk
IHRoZSBqb2IgZmVuY2UKdG8gc3luYyB3aXRoIG90aGVycy4KCkNjOiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4KU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+ClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCAgICAgIHwgNSArKysrKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyB8IDkgKysrKysrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5oCmluZGV4IGI1NzA1ZmNmYzkzNS4uY2E2MDIxYjQyMDBiIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaApAQCAtMjI2LDYgKzIyNiwxMSBAQCBzdHJ1Y3Qg
YW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgewogCSAqIEBudW1fZHdfbGVmdDogbnVtYmVyIG9mIGR3
IGxlZnQgZm9yIHRoZSBJQgogCSAqLwogCXVuc2lnbmVkIGludCBudW1fZHdfbGVmdDsKKworCS8q
KgorCSAqIEByZXN2OiBzeW5jIHRoZSByZXN2IGFuZCBhZGQgam9iIGZlbmNlIHRvIGl0IGNvbmRp
dGlvbmFsbHkuCisJICovCisJc3RydWN0IGRtYV9yZXN2ICpyZXN2OwogfTsKIAogc3RydWN0IGFt
ZGdwdV92bV91cGRhdGVfZnVuY3MgewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9zZG1hLmMKaW5kZXggNGNjNzg4MWY0MzhjLi4wY2ZhYzU5YmZmMzYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwpAQCAtNzAsNiArNzAsOCBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9zZG1hX3ByZXBhcmUoc3RydWN0IGFtZGdwdV92bV91cGRhdGVf
cGFyYW1zICpwLAogCiAJcC0+bnVtX2R3X2xlZnQgPSBuZHc7CiAKKwlwLT5yZXN2ID0gcmVzdjsK
KwogCWlmICghcmVzdikKIAkJcmV0dXJuIDA7CiAKQEAgLTExMSw2ICsxMTMsMTMgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fc2RtYV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1z
ICpwLAogCQlzd2FwKHAtPnZtLT5sYXN0X2RlbGF5ZWQsIHRtcCk7CiAJZG1hX2ZlbmNlX3B1dCh0
bXApOwogCisJLyogYWRkIGpvYiBmZW5jZSB0byByZXN2LgorCSAqIE1NIG5vdGlmaWVyIHBhdGgg
aXMgYW4gZXhjZXB0aW9uIGFzIHdlIGNhbiBub3QgZ3JhYiB0aGUKKwkgKiByZXN2IGxvY2suCisJ
ICovCisJaWYgKCFwLT5kaXJlY3QgJiYgcC0+cmVzdikKKwkJZG1hX3Jlc3ZfYWRkX3NoYXJlZF9m
ZW5jZShwLT5yZXN2LCBmKTsKKwogCWlmIChmZW5jZSAmJiAhcC0+ZGlyZWN0KQogCQlzd2FwKCpm
ZW5jZSwgZik7CiAJZG1hX2ZlbmNlX3B1dChmKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
