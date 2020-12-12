Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56570C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E53D22AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E53D22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF706E865;
	Sat, 12 Dec 2020 15:46:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46BF6E865
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJzlwzJzOxfBEIvYaOmv6AZdYFtuPz5fQVobq1DLiBbB9MxuNMxGcfrKajAqTl4r8KzAs6GBFJde7vcZDqwx75JnuShtYoK/xVgLeGLdG4FmWPpmAg6QWvUCqN/cZTviijU41ClcbEXqQrhSIBLpwv+mhA2YYmiIKzogIAWYfDh+bPvzqPUE6ewPE6GpaTuZrMBeUbMS7ha0TQTdEisB4q5BzIKjU4syJDC7CK8HvxJg8csys1cRMvvjvfD4mo/kvA12EQqTsw2xFEm4jZHvplMd0Yx66+cs7I8nKdXeeKKMsvEg6B638m+DSAv8Pa3b9rMlLQ4TcVW9Oz6igxOjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86LvMFRD1erHpri2IzgEU6Yncdi7rmseZsGXGZdVcqs=;
 b=WRASOSk2b83HtWEFR0XOy7NhvLFBSA6dRzs8RqqHUoDsKx5zX95WB2J10MrB5oEz53t74IYxmh9NuHm7lJtsMtA7tmvLUxa96cwOTeCGXqKSLOmpkY8ba5wUwMpGacgy2NqHsdAl8Gzq8pvxRzin3dAO5yottGGk/COY00L4K6umdvQO5+vxtYCEOGRKswA+UMI/dTwNOSGv7iWurR5cD5zQFNAU8nGSnC3uk1yNd6A4SkRS2Xr3xpiU83clbUDwSLXABaedTbHfh1IYnMkMhB/kjwPUWTrrBNqwHyyBQG1hd1Nvk1ibZ+MaGiACy181yrPxhjAt4fd4c/CIRCOPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86LvMFRD1erHpri2IzgEU6Yncdi7rmseZsGXGZdVcqs=;
 b=SOy7vyhclcd2RLIhUo2lNCVica0vorKBL+zfsua3k16KkRP1u6zQzJvktPcvvYm0eD0mQ3mLovQNdae2a2N4rSxoNLD06LET1V6KztEX2B0ZBc+f2PThxPNpjd9M9SJoFn5ndU4PIQaARv5nGNn5MIVaa7r5W476oDzituEiVCo=
Received: from BN9PR03CA0202.namprd03.prod.outlook.com (2603:10b6:408:f9::27)
 by DM6PR12MB4764.namprd12.prod.outlook.com (2603:10b6:5:31::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 15:46:32 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::54) by BN9PR03CA0202.outlook.office365.com
 (2603:10b6:408:f9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:28 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:26 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 07/27] drm/amdgpu: switch to ih_enable_ring for vega10
Date: Sat, 12 Dec 2020 23:45:40 +0800
Message-ID: <20201212154600.21618-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdde343c-b8eb-4183-927b-08d89eb518ff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4764:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47644B4C97AB316433721763FCC90@DM6PR12MB4764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnU6LuFMCpn43cG1AIwEp+YoHsIZmwuJ534TAAsUYEbxg2NVHTvC3ppcmMbj/YO5fWhCe0B1qlVjoHZbtW+cRCO/StZEtMVov8hG2gGqLYICyyPtbVZUONCgoJ8ewL8rv2QoebQ1e/gwBAM9Y7d8vHssBaZ4z7cRsrAmvt8+VN1X3iDiG6bp6TnnT5PZV8gxfzkQvkZ0A0RvTKbxdRyqlXLp+v2LFMibKQchg6jtlNrDWNvt3aqcAUbex/X/5vuid2Hu+MlkQywt+IEsNuoqZ5RTqYiehhFl43Fi/4hwOo8PBawSS03ufWQXUD9wIU3LJCEkVD2MiGz+MKLi216F0Eg/2VfDmajc7YwRSvDdVwSYWXmCDdADkbhR+iT9BhON87AYKT023MvjBaThCdEWSMcDPFb494yjJYqt6Gs16uE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(46966005)(36756003)(70206006)(6666004)(5660300002)(356005)(508600001)(81166007)(6636002)(8676002)(2906002)(70586007)(186003)(26005)(426003)(7696005)(86362001)(336012)(8936002)(1076003)(83380400001)(2616005)(110136005)(4326008)(82310400003)(47076004)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:31.8146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdde343c-b8eb-4183-927b-08d89eb518ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4764
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

dXNlIHZlZ2ExMF9paF9lbmFibGVfcmluZyB0byBlbmFibGUgYWxsIHRoZQphdmFpbGFibGUgcmlu
ZyBidWZmZXJzIGZvciB2ZWdhMTAvMTIsIFJBVkVOCnNlcmllcyBhbmQgUkVOT0lSIEFQVXMKClNp
Z25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTog
RGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVp
ZmVpLlh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2lo
LmMgfCA5NSArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgODcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdh
MTBfaWguYwppbmRleCA3MjZkOTU4NTQwYzMuLjcwZWRkNWUxNWUxMSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTEwX2loLmMKQEAgLTI2MSw5ICsyNjEsMTAgQEAgc3RhdGljIGludCB2
ZWdhMTBfaWhfZW5hYmxlX3Jpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAgKi8KIHN0
YXRpYyBpbnQgdmVnYTEwX2loX2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
ewotCXN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWg7Ci0JdTMyIGloX3JiX2NudGwsIGloX2NoaWNr
ZW47CisJc3RydWN0IGFtZGdwdV9paF9yaW5nICppaFtdID0geyZhZGV2LT5pcnEuaWgsICZhZGV2
LT5pcnEuaWgxLCAmYWRldi0+aXJxLmloMn07CisJdTMyIGloX2NoaWNrZW47CiAJaW50IHJldDsK
KwlpbnQgaTsKIAl1MzIgdG1wOwogCiAJLyogZGlzYWJsZSBpcnFzICovCkBAIC0yNzMsMjQgKzI3
NCw2IEBAIHN0YXRpYyBpbnQgdmVnYTEwX2loX2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCiAJYWRldi0+bmJpby5mdW5jcy0+aWhfY29udHJvbChhZGV2KTsKIAotCWloID0g
JmFkZXYtPmlycS5paDsKLQkvKiBSaW5nIEJ1ZmZlciBiYXNlLiBbMzk6OF0gb2YgNDAtYml0IGFk
ZHJlc3Mgb2YgdGhlIGJlZ2lubmluZyBvZiB0aGUgcmluZyBidWZmZXIqLwotCVdSRUczMl9TT0Mx
NShPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRSwgaWgtPmdwdV9hZGRyID4+IDgpOwotCVdSRUczMl9T
T0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRV9ISSwgKGloLT5ncHVfYWRkciA+PiA0MCkgJiAw
eGZmKTsKLQotCWloX3JiX2NudGwgPSBSUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NO
VEwpOwotCWloX3JiX2NudGwgPSB2ZWdhMTBfaWhfcmJfY250bChpaCwgaWhfcmJfY250bCk7Ci0J
aWhfcmJfY250bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJfQ05UTCwgUlBUUl9S
RUFSTSwKLQkJCQkgICAhIWFkZXYtPmlycS5tc2lfZW5hYmxlZCk7Ci0JaWYgKGFtZGdwdV9zcmlv
dl92ZihhZGV2KSkgewotCQlpZiAocHNwX3JlZ19wcm9ncmFtKCZhZGV2LT5wc3AsIFBTUF9SRUdf
SUhfUkJfQ05UTCwgaWhfcmJfY250bCkpIHsKLQkJCURSTV9FUlJPUigiUFNQIHByb2dyYW0gSUhf
UkJfQ05UTCBmYWlsZWQhXG4iKTsKLQkJCXJldHVybiAtRVRJTUVET1VUOwotCQl9Ci0JfSBlbHNl
IHsKLQkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMLCBpaF9yYl9jbnRsKTsK
LQl9Ci0KIAlpZiAoKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTICYmCiAJICAgICBh
ZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfRElSRUNUKSB8fAogCSAg
ICBhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SRU5PSVIpIHsKQEAgLTMwNSw3NCArMjg4LDEyIEBA
IHN0YXRpYyBpbnQgdmVnYTEwX2loX2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX0NISUNLRU4sIGloX2NoaWNrZW4pOwog
CX0KIAotCS8qIHNldCB0aGUgd3JpdGViYWNrIGFkZHJlc3Mgd2hldGhlciBpdCdzIGVuYWJsZWQg
b3Igbm90ICovCi0JV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9XUFRSX0FERFJfTE8s
Ci0JCSAgICAgbG93ZXJfMzJfYml0cyhpaC0+d3B0cl9hZGRyKSk7Ci0JV1JFRzMyX1NPQzE1KE9T
U1NZUywgMCwgbW1JSF9SQl9XUFRSX0FERFJfSEksCi0JCSAgICAgdXBwZXJfMzJfYml0cyhpaC0+
d3B0cl9hZGRyKSAmIDB4RkZGRik7Ci0KLQkvKiBzZXQgcnB0ciwgd3B0ciB0byAwICovCi0JV1JF
RzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9XUFRSLCAwKTsKLQlXUkVHMzJfU09DMTUoT1NT
U1lTLCAwLCBtbUlIX1JCX1JQVFIsIDApOwotCi0JV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1J
SF9ET09SQkVMTF9SUFRSLAotCQkgICAgIHZlZ2ExMF9paF9kb29yYmVsbF9ycHRyKGloKSk7Ci0K
LQlpaCA9ICZhZGV2LT5pcnEuaWgxOwotCWlmIChpaC0+cmluZ19zaXplKSB7Ci0JCVdSRUczMl9T
T0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRV9SSU5HMSwgaWgtPmdwdV9hZGRyID4+IDgpOwot
CQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0VfSElfUklORzEsCi0JCQkgICAg
IChpaC0+Z3B1X2FkZHIgPj4gNDApICYgMHhmZik7Ci0KLQkJaWhfcmJfY250bCA9IFJSRUczMl9T
T0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSk7Ci0JCWloX3JiX2NudGwgPSB2ZWdh
MTBfaWhfcmJfY250bChpaCwgaWhfcmJfY250bCk7Ci0JCWloX3JiX2NudGwgPSBSRUdfU0VUX0ZJ
RUxEKGloX3JiX2NudGwsIElIX1JCX0NOVEwsCi0JCQkJCSAgIFdQVFJfT1ZFUkZMT1dfRU5BQkxF
LCAwKTsKLQkJaWhfcmJfY250bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJfQ05U
TCwKLQkJCQkJICAgUkJfRlVMTF9EUkFJTl9FTkFCTEUsIDEpOwotCQlpZiAoYW1kZ3B1X3NyaW92
X3ZmKGFkZXYpKSB7Ci0JCQlpZiAocHNwX3JlZ19wcm9ncmFtKCZhZGV2LT5wc3AsIFBTUF9SRUdf
SUhfUkJfQ05UTF9SSU5HMSwKLQkJCQkJCWloX3JiX2NudGwpKSB7Ci0JCQkJRFJNX0VSUk9SKCJw
cm9ncmFtIElIX1JCX0NOVExfUklORzEgZmFpbGVkIVxuIik7Ci0JCQkJcmV0dXJuIC1FVElNRURP
VVQ7Ci0JCQl9Ci0JCX0gZWxzZSB7Ci0JCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JC
X0NOVExfUklORzEsIGloX3JiX2NudGwpOwotCQl9Ci0KLQkJLyogc2V0IHJwdHIsIHdwdHIgdG8g
MCAqLwotCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX1dQVFJfUklORzEsIDApOwot
CQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX1JQVFJfUklORzEsIDApOwotCi0JCVdS
RUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfRE9PUkJFTExfUlBUUl9SSU5HMSwKLQkJCSAgICAg
dmVnYTEwX2loX2Rvb3JiZWxsX3JwdHIoaWgpKTsKLQl9Ci0KLQlpaCA9ICZhZGV2LT5pcnEuaWgy
OwotCWlmIChpaC0+cmluZ19zaXplKSB7Ci0JCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhf
UkJfQkFTRV9SSU5HMiwgaWgtPmdwdV9hZGRyID4+IDgpOwotCQlXUkVHMzJfU09DMTUoT1NTU1lT
LCAwLCBtbUlIX1JCX0JBU0VfSElfUklORzIsCi0JCQkgICAgIChpaC0+Z3B1X2FkZHIgPj4gNDAp
ICYgMHhmZik7Ci0KLQkJaWhfcmJfY250bCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhf
UkJfQ05UTF9SSU5HMik7Ci0JCWloX3JiX2NudGwgPSB2ZWdhMTBfaWhfcmJfY250bChpaCwgaWhf
cmJfY250bCk7Ci0KLQkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewotCQkJaWYgKHBzcF9y
ZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBQU1BfUkVHX0lIX1JCX0NOVExfUklORzIsCi0JCQkJCQlp
aF9yYl9jbnRsKSkgewotCQkJCURSTV9FUlJPUigicHJvZ3JhbSBJSF9SQl9DTlRMX1JJTkcyIGZh
aWxlZCFcbiIpOwotCQkJCXJldHVybiAtRVRJTUVET1VUOwotCQkJfQotCQl9IGVsc2UgewotCQkJ
V1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyLCBpaF9yYl9jbnRsKTsK
Kwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShpaCk7IGkrKykgeworCQlpZiAoaWhbaV0tPnJp
bmdfc2l6ZSkgeworCQkJcmV0ID0gdmVnYTEwX2loX2VuYWJsZV9yaW5nKGFkZXYsIGloW2ldKTsK
KwkJCWlmIChyZXQpCisJCQkJcmV0dXJuIHJldDsKIAkJfQotCi0JCS8qIHNldCBycHRyLCB3cHRy
IHRvIDAgKi8KLQkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9XUFRSX1JJTkcyLCAw
KTsKLQkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9SUFRSX1JJTkcyLCAwKTsKLQot
CQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX0RPT1JCRUxMX1JQVFJfUklORzIsCi0JCQkg
ICAgIHZlZ2ExMF9paF9kb29yYmVsbF9ycHRyKGloKSk7CiAJfQogCiAJdG1wID0gUlJFRzMyX1NP
QzE1KE9TU1NZUywgMCwgbW1JSF9TVE9STV9DTElFTlRfTElTVF9DTlRMKTsKLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
