Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D92C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA1D22AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA1D22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8526E85F;
	Sat, 12 Dec 2020 15:46:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9854C6E85F
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPlRffGVReiLjFU4H/nlyDM0ancejQlsY062y2NEMoay3JqmYAf0Aw6unetL/1QhHKyfmkxVQiNj1YYDtyWegRZfuwdeqNleZwJo1acdot9IACEMPweqyq41j6DbWHujfmmWgaHzEa+xwNaCMZzS/VhG2SBsd+oUGTtL/Xau5gwcuUtEiWFppYr2A7BmpKZG7LDkGR56FNbCn39rbvvR5bx5M/NqAKEFIhOwVczLQnp/mx1yC5t+i7zE97DsdgvfIVBmoUwStF5ixivTsQy2caPN1uXGp0xSO+RPGThJNOqcH3MFEUMNO9X+9TvW/CNvlhoKumbuV8lTkXWMRbCkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnL8RqdvFnU1A81F2beMR4PYPkh1jJkH5QLDSa2jlC0=;
 b=WjBQx+4snJOl/8Fcjqz5U/NkNg8VI8klQJpwpcTpAh7vGCFBJb/KKyAonXw2/LU1mvRpFG8HnSvJxbfAwjRgE8T+FbtGHpiQTudCbQD+OYQQh1TmJ+pEfPyKImMipQoU5bozTlFNnFmLLwqy+OKJoufKdgvPHtEereOHJdfWvbh2M9drro5km44/Y6Nj6GMYH8EsFHJTYyJyVPzNLPd7a5km4tTaa2W79PVtSvsiu/fHV13YQjMmIVy6JAD3h2NYPokh8sdBokHJZ5UWnK8zlztPzegh2jTq3M35cC4VN9cftvS+gHuGpP6/FegotqDbTxiNH2aY3CMdbRmI8PVQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnL8RqdvFnU1A81F2beMR4PYPkh1jJkH5QLDSa2jlC0=;
 b=E4OFLz4VXgeNzsKdWS16a7Pb8b3r13YgUn5JTYuSJV4XVWPMRjcrzKO1UbaBt2NqbZAuxef7m2nGroMASkPBAbrJZggHSLjcCkgCXuhyAaMQB0CT65H91xsblPJACSQ3GHHXDI2mgU+afuk6/P4GNrPuNxHdwsP8KjGl54jF2uk=
Received: from DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15)
 by DM6PR12MB3387.namprd12.prod.outlook.com (2603:10b6:5:3a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 12 Dec
 2020 15:46:16 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::f0) by DM6PR17CA0002.outlook.office365.com
 (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:14 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:12 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 03/27] drm/amdgpu: add helper to enable an ih ring for vega10
Date: Sat, 12 Dec 2020 23:45:36 +0800
Message-ID: <20201212154600.21618-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2f3e11-28d1-4916-938b-08d89eb50f77
X-MS-TrafficTypeDiagnostic: DM6PR12MB3387:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3387B76135B28763B3BAD125FCC90@DM6PR12MB3387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X/SIuM6gO0zrc5rgkFzcjH0t+gxpzRnKU5W1h0UHNhlJAK9m1LNARzN58aZAt0wbEiYt9alRqkwqsLArXEMz3/l44AjoIPplkjUVQVCLbmEL63gYMjKR3cM3jIiFLQVrRLUoyJo2l5O/b0h1Dr7/GkW1gn2ViZn+93LYPDrMd/KRjfECvmgu7Pov3ZWnwa7O24ISibYpqktm0KSAKC8G5YZpCwsFiBxYXWlQFw68tz8yK+lBeMEy0xs2yVNU+H5yNJ7PkR4Sm1M1ba02puOHFWwdO/YPMpyCFEGiThsaabjxb/vjfm5UphWvTIP9RD0s111xSCSkmCIL8lDEWBvqnFtHvP7RsNQf02eDaruiR6xm8gT0os/gMcQEhfxFPEmnrs6eqg3Unzpgyf2B+8miHjBOKJonpdG9HvzKa2RgW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(2906002)(2616005)(70586007)(356005)(70206006)(426003)(508600001)(8936002)(86362001)(8676002)(26005)(5660300002)(36756003)(4326008)(110136005)(6636002)(81166007)(186003)(1076003)(47076004)(7696005)(336012)(6666004)(82310400003)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:15.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2f3e11-28d1-4916-938b-08d89eb50f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3387
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

dmVnYTEwX2loX2VuYWJsZV9yaW5nIHdpbGwgYmUgdXNlZCB0byBlbmFibGUgYW4KaWggcmluZyBm
b3IgdmVnYTEwLzEyLCBSQVZFTiBzZXJpZXMgYW5kIFJFTk9JUi4KClNpZ25lZC1vZmYtYnk6IEhh
d2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRGVubmlzIExpIDxEZW5u
aXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCmluZGV4IGExMTU1M2EyMzUzOC4uNDJl
Nzg5N2YyYmJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBf
aWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwpAQCAtMjU1
LDYgKzI1NSw1OCBAQCBzdGF0aWMgdWludDMyX3QgdmVnYTEwX2loX2Rvb3JiZWxsX3JwdHIoc3Ry
dWN0IGFtZGdwdV9paF9yaW5nICppaCkKIAlyZXR1cm4gaWhfZG9vcmJlbGxfcnRwcjsKIH0KIAor
LyoqCisgKiB2ZWdhMTBfaWhfZW5hYmxlX3JpbmcgLSBlbmFibGUgYW4gaWggcmluZyBidWZmZXIK
KyAqCisgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAaWg6IGFtZGdwdV9paF9y
aW5nIHBvaW50ZXIKKyAqCisgKiBFbmFibGUgYW4gaWggcmluZyBidWZmZXIgKFZFR0ExMCkKKyAq
Lworc3RhdGljIGludCB2ZWdhMTBfaWhfZW5hYmxlX3Jpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCisJCQkJIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpCit7CisJc3RydWN0IGFtZGdw
dV9paF9yZWdzICppaF9yZWdzOworCXVpbnQzMl90IHRtcDsKKworCWloX3JlZ3MgPSAmaWgtPmlo
X3JlZ3M7CisKKwkvKiBSaW5nIEJ1ZmZlciBiYXNlLiBbMzk6OF0gb2YgNDAtYml0IGFkZHJlc3Mg
b2YgdGhlIGJlZ2lubmluZyBvZiB0aGUgcmluZyBidWZmZXIqLworCVdSRUczMihpaF9yZWdzLT5p
aF9yYl9iYXNlLCBpaC0+Z3B1X2FkZHIgPj4gOCk7CisJV1JFRzMyKGloX3JlZ3MtPmloX3JiX2Jh
c2VfaGksIChpaC0+Z3B1X2FkZHIgPj4gNDApICYgMHhmZik7CisKKwl0bXAgPSBSUkVHMzIoaWhf
cmVncy0+aWhfcmJfY250bCk7CisJdG1wID0gdmVnYTEwX2loX3JiX2NudGwoaWgsIHRtcCk7CisJ
aWYgKGloID09ICZhZGV2LT5pcnEuaWgpCisJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9S
Ql9DTlRMLCBSUFRSX1JFQVJNLCAhIWFkZXYtPmlycS5tc2lfZW5hYmxlZCk7CisJaWYgKGloID09
ICZhZGV2LT5pcnEuaWgxKSB7CisJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9SQl9DTlRM
LCBXUFRSX09WRVJGTE9XX0VOQUJMRSwgMCk7CisJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJ
SF9SQl9DTlRMLCBSQl9GVUxMX0RSQUlOX0VOQUJMRSwgMSk7CisJfQorCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikpIHsKKwkJaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBpaF9yZWdz
LT5wc3BfcmVnX2lkLCB0bXApKSB7CisJCQlkZXZfZXJyKGFkZXYtPmRldiwgIlBTUCBwcm9ncmFt
IElIX1JCX0NOVEwgZmFpbGVkIVxuIik7CisJCQlyZXR1cm4gLUVUSU1FRE9VVDsKKwkJfQorCX0g
ZWxzZSB7CisJCVdSRUczMihpaF9yZWdzLT5paF9yYl9jbnRsLCB0bXApOworCX0KKworCWlmIChp
aCA9PSAmYWRldi0+aXJxLmloKSB7CisJCS8qIHNldCB0aGUgaWggcmluZyAwIHdyaXRlYmFjayBh
ZGRyZXNzIHdoZXRoZXIgaXQncyBlbmFibGVkIG9yIG5vdCAqLworCQlXUkVHMzIoaWhfcmVncy0+
aWhfcmJfd3B0cl9hZGRyX2xvLCBsb3dlcl8zMl9iaXRzKGloLT53cHRyX2FkZHIpKTsKKwkJV1JF
RzMyKGloX3JlZ3MtPmloX3JiX3dwdHJfYWRkcl9oaSwgdXBwZXJfMzJfYml0cyhpaC0+d3B0cl9h
ZGRyKSAmIDB4RkZGRik7CisJfQorCisJLyogc2V0IHJwdHIsIHdwdHIgdG8gMCAqLworCVdSRUcz
MihpaF9yZWdzLT5paF9yYl93cHRyLCAwKTsKKwlXUkVHMzIoaWhfcmVncy0+aWhfcmJfcnB0ciwg
MCk7CisKKwlXUkVHMzIoaWhfcmVncy0+aWhfZG9vcmJlbGxfcnB0ciwgdmVnYTEwX2loX2Rvb3Ji
ZWxsX3JwdHIoaWgpKTsKKworCXJldHVybiAwOworfQorCiAvKioKICAqIHZlZ2ExMF9paF9pcnFf
aW5pdCAtIGluaXQgYW5kIGVuYWJsZSB0aGUgaW50ZXJydXB0IHJpbmcKICAqCi0tIAoyLjE3LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
