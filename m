Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E9C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B97C22AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B97C22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293FF6E87A;
	Sat, 12 Dec 2020 15:47:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDD96E87A
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnUmTEka+qZEDckGIC50q0KmM/DYd/o1ACsneOKHmbkryavLqk+KDkvTNZTFwEIv208tSpoARVq6ykOuA7K0qmZyl8R559hrPcXBYXcp1mqM57e8VBgv5kV0stMWyGcSlKQAMXEzdeii1mx0XDgIFeRDGbkctPXOBqCKXBF6sycg2BxZifxL8MlOfvmo2lmVPZJiRbi6RyPALNvrDU1VAZbN3+8Y2SVA3XqNrsT8lccc7bFO9yP92bWzff3YKf+V5iHILxqBp7/RnVElUiuqK+4U/LBASsxyf0x5YNqHvWR8/7mwLwjwCzvd7jyjoGDmDRqL/hphdh7NoAtJ9hbDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LEknkgcYBd+28VgD414QfiVlnNJ5UIe38TO5ZMQYp8=;
 b=lKOFeg5eIdmLbn3zM1CqjILjf7sj7081IUjAIuxOhJiUGRTqyIAUYvw0ULWiMPf1szikv83veZCCqy+M3SzR0rHNkNI8qjagoOkIXDM/DZ6kEXEgBHdkmBG2kp6wyBIJKHr7clH9hFNB1JbTpJAg7yXx9vUUMDQicywyy8jcAdybzpCpCoviddH8ICuW0XtQG7fLFkh7tqPepXNhnEXkuiJOhV6bKA2lFQtnQ0E2SYmh80BFUqWsqkYi+H5XRu9yp/In1Mwhph3HnImk26z8sA20ItyqGw1mPmWTmCXT4LGhvAG/rrwhK35ejY+Xq5piU9EXGrmMFHuJAVLWO6SuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LEknkgcYBd+28VgD414QfiVlnNJ5UIe38TO5ZMQYp8=;
 b=390gx3j1bADYE43wn1xWxKdezzbJ/yQZmmNIb3INlISYveE6WhwVNb+lNJ/ihoP9eKG9A3bCRBY/kKg8cfY9R6LFxA3hs6+5VSskrNMfRFBHG1/KTO6e9fLG13vVLdF3DaA8DLFKkYkPZr7IzSPwjO5VwBf/h0+WAZZ6UGas3wk=
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by MN2PR12MB3231.namprd12.prod.outlook.com (2603:10b6:208:104::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 12 Dec
 2020 15:46:59 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::b2) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:58 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:58 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:56 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 17/27] drm/amdgpu: add a helper function to decode iv
Date: Sat, 12 Dec 2020 23:45:50 +0800
Message-ID: <20201212154600.21618-17-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1166254e-1c5b-44ca-b057-08d89eb5292f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3231:
X-Microsoft-Antispam-PRVS: <MN2PR12MB323125973C24557384D79643FCC90@MN2PR12MB3231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SrztBsTH6qB6PAo5fgr2DeW0eOT/0IZo0viiZ6u3AMAP1k3WfPbaE3mhmbSXOyTZHBahjW3yUB+0P8TIEZtItOYx0sGgj84qXPS/lakQmVt2c16nxhjTnkGsbdpY3e1+LmXWhEbokbYrJttgTP97aBMUnloVT0C9NXqppM/LdEUnbYqsd8JzhKCP2n+Ac3TkEYXFej4ZDfSW2Mn48hrQn7KUprcB8VVqAzh9a4eB+EGj+S2MVwJvlv6nFgd0rdEYiKxqiGNoEB+YsSPvdE9kIhTns1CZL1TfBIg7BZzT/2iEYEBLF31RCRWrGuFEP6dAQz+qGm/wjpIh5PG2OmXpcSeTiWsl/BVQ79kqR+p6dgZqavAL4sENobUdNYZ3qhMt1L0b9wtIg4FopXCdKG3pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(186003)(7696005)(81166007)(82310400003)(4326008)(36756003)(508600001)(2616005)(5660300002)(2906002)(110136005)(336012)(83380400001)(47076004)(8936002)(66574015)(356005)(1076003)(70586007)(6666004)(426003)(70206006)(26005)(6636002)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:58.9735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1166254e-1c5b-44ca-b057-08d89eb5292f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3231
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

c2luY2UgZnJvbSBzb2MxNSwgYWxsIHRoZSBjaGlwcyBzaGFyZSB0aGUgc2FtZQppdiBmb3JtYXQu
IGNyZWF0ZSBhIGNvbW1vbiBoZWxwZXIgdG8gZGVjb2RlIGl2CgpTaWduZWQtb2ZmLWJ5OiBIYXdr
aW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxp
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jIHwgNDMgKysrKysrKysrKysr
KysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHwg
IDQgKystCiAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCmluZGV4IGRjZDliNGE4ZTIwYi4u
NzI1YTljNzNkNTFmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwpAQCAt
MjA1LDMgKzIwNSw0NiBAQCBpbnQgYW1kZ3B1X2loX3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpCiAJcmV0dXJuIElSUV9IQU5ETEVE
OwogfQogCisvKioKKyAqIGFtZGdwdV9paF9kZWNvZGVfaXZfaGVscGVyIC0gZGVjb2RlIGFuIGlu
dGVycnVwdCB2ZWN0b3IKKyAqCisgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKgor
ICogRGVjb2RlcyB0aGUgaW50ZXJydXB0IHZlY3RvciBhdCB0aGUgY3VycmVudCBycHRyCisgKiBw
b3NpdGlvbiBhbmQgYWxzbyBhZHZhbmNlIHRoZSBwb3NpdGlvbiBmb3IgZm9yIFZlZ2ExMAorICog
YW5kIGxhdGVyIEdQVXMuCisgKi8KK3ZvaWQgYW1kZ3B1X2loX2RlY29kZV9pdl9oZWxwZXIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwK
KwkJCQlzdHJ1Y3QgYW1kZ3B1X2l2X2VudHJ5ICplbnRyeSkKK3sKKwkvKiB3cHRyL3JwdHIgYXJl
IGluIGJ5dGVzISAqLworCXUzMiByaW5nX2luZGV4ID0gaWgtPnJwdHIgPj4gMjsKKwl1aW50MzJf
dCBkd1s4XTsKKworCWR3WzBdID0gbGUzMl90b19jcHUoaWgtPnJpbmdbcmluZ19pbmRleCArIDBd
KTsKKwlkd1sxXSA9IGxlMzJfdG9fY3B1KGloLT5yaW5nW3JpbmdfaW5kZXggKyAxXSk7CisJZHdb
Ml0gPSBsZTMyX3RvX2NwdShpaC0+cmluZ1tyaW5nX2luZGV4ICsgMl0pOworCWR3WzNdID0gbGUz
Ml90b19jcHUoaWgtPnJpbmdbcmluZ19pbmRleCArIDNdKTsKKwlkd1s0XSA9IGxlMzJfdG9fY3B1
KGloLT5yaW5nW3JpbmdfaW5kZXggKyA0XSk7CisJZHdbNV0gPSBsZTMyX3RvX2NwdShpaC0+cmlu
Z1tyaW5nX2luZGV4ICsgNV0pOworCWR3WzZdID0gbGUzMl90b19jcHUoaWgtPnJpbmdbcmluZ19p
bmRleCArIDZdKTsKKwlkd1s3XSA9IGxlMzJfdG9fY3B1KGloLT5yaW5nW3JpbmdfaW5kZXggKyA3
XSk7CisKKwllbnRyeS0+Y2xpZW50X2lkID0gZHdbMF0gJiAweGZmOworCWVudHJ5LT5zcmNfaWQg
PSAoZHdbMF0gPj4gOCkgJiAweGZmOworCWVudHJ5LT5yaW5nX2lkID0gKGR3WzBdID4+IDE2KSAm
IDB4ZmY7CisJZW50cnktPnZtaWQgPSAoZHdbMF0gPj4gMjQpICYgMHhmOworCWVudHJ5LT52bWlk
X3NyYyA9IChkd1swXSA+PiAzMSk7CisJZW50cnktPnRpbWVzdGFtcCA9IGR3WzFdIHwgKCh1NjQp
KGR3WzJdICYgMHhmZmZmKSA8PCAzMik7CisJZW50cnktPnRpbWVzdGFtcF9zcmMgPSBkd1syXSA+
PiAzMTsKKwllbnRyeS0+cGFzaWQgPSBkd1szXSAmIDB4ZmZmZjsKKwllbnRyeS0+cGFzaWRfc3Jj
ID0gZHdbM10gPj4gMzE7CisJZW50cnktPnNyY19kYXRhWzBdID0gZHdbNF07CisJZW50cnktPnNy
Y19kYXRhWzFdID0gZHdbNV07CisJZW50cnktPnNyY19kYXRhWzJdID0gZHdbNl07CisJZW50cnkt
PnNyY19kYXRhWzNdID0gZHdbN107CisKKwkvKiB3cHRyL3JwdHIgYXJlIGluIGJ5dGVzISAqLwor
CWloLT5ycHRyICs9IDMyOworfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2loLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaApp
bmRleCA5NGM1NjViOWVjYTguLjZlZDRhODVmYzdjMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2loLmgKQEAgLTg4LDUgKzg4LDcgQEAgdm9pZCBhbWRncHVfaWhfcmluZ19maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKTsK
IHZvaWQgYW1kZ3B1X2loX3Jpbmdfd3JpdGUoc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwgY29u
c3QgdWludDMyX3QgKml2LAogCQkJICB1bnNpZ25lZCBpbnQgbnVtX2R3KTsKIGludCBhbWRncHVf
aWhfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9paF9y
aW5nICppaCk7Ci0KK3ZvaWQgYW1kZ3B1X2loX2RlY29kZV9pdl9oZWxwZXIoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCisJCQkJc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwKKwkJCQlzdHJ1
Y3QgYW1kZ3B1X2l2X2VudHJ5ICplbnRyeSk7CiAjZW5kaWYKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
