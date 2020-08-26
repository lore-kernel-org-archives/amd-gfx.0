Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7BC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5452078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YRycrV51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5452078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81BB6E135;
	Wed, 26 Aug 2020 14:46:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF30C6E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZAibxBEiSApc/Jwrp2wUVnb9kEtfUiibsZILFMY/IKPKbjJEgBoXQESkGwwe+1Q49o6EpwI3aLjulQezPAG3p66SoVtNXcrhfbGxFhep5u16fhg0j7z2K1awL1j6wnHleRxAWjxk4Xev+oec89zpwMkS87TLarOTDj5mAR6k/tGpuZ4qPQA2OSLcocWxG2OGnHVUEFbZOHIz0IAv2BU1sTsEyxnJzIfFP37TaL5gskK51jcn4jmE0x3Al+W0pzl825UlFtjymTHWBpX8gJrXTITGCAAOj6TMdNDVnPc6tR1CFlXfGcFA2fMw+ussOWRvUXKtKT579j95h1nO9x8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sib1+5HJ61ILjP1p+rs/+eplVtACAKG5fP/6ReHjHeo=;
 b=RM0Pv5O0fOljhBAHRuP5coM60woDr97y+ChrzwxbSteosDJ8qRDksiLqYFdOir97MjkNes2zXZeIqchh9nCH7rgZkmMlm6FsLeOowI/hGSAi8Tnm3uXLIL1KkVFqnjhA9zz0y+1Yy1h7oy+AVicrXT/9k0HtW/9tUMoiO6FDUS1z8J6bMOs+xkQCA3EQk2UgexuYfWA0m8/1v9X+Dv0sXqIgz3SogsZaq7zAp+mss6qPHc+vZJstv56Ap8mVgKtt6XHCpjnXOz87uqFO4aqumtbEXdZ/o7pi6VlnGqiLlR+Q9QVPN9atlQPDsB7aqpqM7S3+5KiOUf6lSy19323SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sib1+5HJ61ILjP1p+rs/+eplVtACAKG5fP/6ReHjHeo=;
 b=YRycrV51nSDLtbXdeSQgjdEU35DEqVNPiD+5UGVcLEzch6jYaX2rZxI23CYTqLXWg+Ak5K+A2vREK5aG74vjfWlIbSJaCES7RldWRkks7GhVZJ6n3sv0yy86muPeZLL5iW9CLmLrMK5vJrv0t6Fjs1IuLhOqTVad2zOgISMQuR0=
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by BN8PR12MB3393.namprd12.prod.outlook.com (2603:10b6:408:46::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 14:46:34 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::89) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:31 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:31 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:30 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] Implement PCI Error Recovery on Navi12
Date: Wed, 26 Aug 2020 10:46:15 -0400
Message-ID: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ddcbff9-7b7f-4133-d2f0-08d849ced2ef
X-MS-TrafficTypeDiagnostic: BN8PR12MB3393:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33930D78EBDBCFFE76726B78EA540@BN8PR12MB3393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kubgcb0sVD3ZrlXXap74Mh3WA60ciSSRFeu4rX6PeQT2ovUxsZ11prKvfu4GQTjoMHBTZBgH3WxMhzfvD5DN9pjrYZe49sMXS8ZUidLhxCB1V8MbAJJGeSXmERwrG1aQbKXlayL75w7FvTt/9JI59MagcIbn4VDF1u0TdYprMxebB0HMj+31lCP9eHAw0rx3ligtGzFWn8XHQvxCoz1NekNa2D/HRd0I70BuqdHnJXiU2aiVheeZoVRTE2ujl3SwxEziUdM4uagbsZ77hf8+vZ7RRlG7rtCz+JuEXp6O9D32eeQ5hLi5zas2KoY1gUcFfS5JY/GLdmDETONTrNshjj80djp2PtemjIahCXf0dpEOFpK2fm4Bl4LhGBjqHyNAAuJZYs6irnHkNp3TDV6pj0pr1PBvM9bwXVdlpUjxgYuUC98HKWKZS8GBO95YZqSi619B7xqm29HoMdSh5igO3v4mlvRol1EZz57eXe9iik=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(83380400001)(6666004)(8676002)(70206006)(8936002)(70586007)(54906003)(478600001)(966005)(86362001)(5660300002)(6916009)(316002)(2906002)(336012)(82740400003)(47076004)(186003)(26005)(2616005)(36756003)(426003)(44832011)(82310400002)(7696005)(81166007)(4326008)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:32.2339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddcbff9-7b7f-4133-d2f0-08d849ced2ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3393
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TWFueSBQQ0kgYnVzIGNvbnRyb2xsZXJzIGFyZSBhYmxlIHRvIGRldGVjdCBhIHZhcmlldHkgb2Yg
aGFyZHdhcmUgUENJIGVycm9ycyBvbiB0aGUgYnVzLCAKc3VjaCBhcyBwYXJpdHkgZXJyb3JzIG9u
IHRoZSBkYXRhIGFuZCBhZGRyZXNzIGJ1c2VzLCDCoEEgdHlwaWNhbCBhY3Rpb24gdGFrZW4gaXMg
dG8gZGlzY29ubmVjdCAKdGhlIGFmZmVjdGVkIGRldmljZSwgaGFsdGluZyBhbGwgSS9PIHRvIGl0
LiBUeXBpY2FsbHksIGEgcmVjb25uZWN0aW9uIG1lY2hhbmlzbSBpcyBhbHNvIG9mZmVyZWQsIApz
byB0aGF0IHRoZSBhZmZlY3RlZCBQQ0kgZGV2aWNlKHMpIGFyZSByZXNldCBhbmQgcHV0IGJhY2sg
aW50byB3b3JraW5nIGNvbmRpdGlvbi4gCkluIG91ciBjYXNlIHRoZSByZWNvbm5lY3Rpb24gbWVj
aGFuaXNtIGlzIGZhY2lsaXRhdGVkIGJ5IGtlcm5lbCBEb3duc3RyZWFtIFBvcnQgQ29udGFpbm1l
bnQgKERQQykgCmRyaXZlciB3aGljaMKgd2lsbCBpbnRlcmNlcHQgdGhlIFBDSWUgZXJyb3IsIHJl
bW92ZSAoaXNvbGF0ZSkgdGhlIGZhdWx0aW5nIGRldmljZSBhbmQgcmVzZXQgdGhlIFBDSSAKbGlu
ayBvZiB0aGUgZGV2aWNlIGFmdGVyIHdoaWNoIGl0IHdpbGwgY2FsbCBpbnRvIFBDSWUgcmVjb3Zl
cnkgY29kZSBvZiB0aGUgUENJIGNvcmUuwqAKVGhpcyBjb2RlIHdpbGwgY2FsbCBob29rcyB3aGlj
aCBhcmUgaW1wbGVtZW50ZWQgaW4gdGhpcyBwYXRjaHNldCB3aGVyZSB0aGUgZXJyb3IgaXMgCmZp
cnN0IHJlcG9ydGVkIGF0IHdoaWNoIHBvaW50IHdlIGJsb2NrIHRoZSBHUFUgc2NoZWR1bGVyLCBu
ZXh0IERQQyByZXNldHMgdGhlIApQQ0kgbGluayB3aGljaCBnZW5lcmF0ZXMgSFcgaW50ZXJydXB0
wqB3aGljaCBpcyBpbnRlcmNlcHRlZCBieSBTTVUvUFNQIHdobyAKc3RhcnQgZXhlY3V0aW5nIG1v
ZGUxIHJlc2V0IG9mIHRoZSBBU0lDLCBuZXh0IHN0ZXAgaXMgc2xvdCByZXNldCBob29rIGlzIGNh
bGxlZCAKYXQgd2hpY2ggcG9pbnQgd2Ugd2FpdCBmb3IgQVNJQyByZXNldCB0byBjb21wbGV0ZSwg
cmVzdG9yZSBQQ0kgY29uZmlnIHNwYWNlIGFuZCBydW4gCkhXIHN1c3BlbmQvcmVzdW1lIHNlcXVl
bmNlIHRvIHJlc2luaXQgdGhlIEFTSUMuIApMYXN0IGhvb2sgY2FsbGVkIGlzIHJlc3VtZSBub3Jt
YWwgb3BlcmF0aW9uIGF0IHdoaWNoIHBvaW50IHdlIHdpbGwgcmVzdGFydCB0aGUgR1BVIHNjaGVk
dWxlci4KCk1vcmUgaW5mbyBvbiBQQ0llIGVycm9yIGhhbmRsaW5nIGFuZCBEUEMgYXJlIGhlcmU6
Cmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L1BDSS9wY2ktZXJyb3ItcmVj
b3ZlcnkuaHRtbApodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzg5NDU2ODEvCgpB
bmRyZXkgR3JvZHpvdnNreSAoNyk6CiAgZHJtL2FtZGdwdTogSW1wbGVtZW50IERQQyByZWNvdmVy
eQogIGRybS9hbWRncHU6IEF2b2lkIGFjY2Vzc2luZyBIVyB3aGVuIHN1c3BlbmRpbmcgU1cgc3Rh
dGUKICBkcm0vYW1kZ3B1OiBCbG9jayBhbGwgam9iIHNjaGVkdWxpbmcgYWN0aXZpdHkgZHVyaW5n
IERQQyByZWNvdmVyeQogIGRybS9hbWRncHU6IEZpeCBTTVUgZXJyb3IgZmFpbHVyZQogIGRybS9h
bWRncHU6IEZpeCBjb25zZWN1dGl2ZSBEUEMJcmVjb3ZlcmllcyBmYWlsdXJlLgogIGRybS9hbWRn
cHU6IFRyaW0gYW1kZ3B1X3BjaV9zbG90X3Jlc2V0IGJ5IHJldXNpbmcgY29kZS4KICBkcm0vYW1k
Z3B1OiBEaXNhYmxlIERQQyBmb3IgWEdNSSBmb3Igbm93LgoKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICAxNiArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIHwgMjg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgICAgfCAgMTMgKy0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyAgICB8ICAgNiArCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgICAgfCAgIDYgKwogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYXRvbS5jICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jICAgICB8ICAxOCArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbnYuYyAgICAgICAgICAgIHwgICA0ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jICAgICAgICAgfCAgIDQgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1k
Z3B1X3NtdS5jICB8ICAgMyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4u
YyAgICAgfCAgIDMgKwogMTEgZmlsZXMgY2hhbmdlZCwgMzQ0IGluc2VydGlvbnMoKyksIDE5IGRl
bGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
