Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F101C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 03:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102CA2084C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 03:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QViCsn9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102CA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1066E17D;
	Thu, 28 May 2020 03:05:40 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7E86E17D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 03:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMWoRneJPauFRKNtO5K2fWNm8owWGb/e1kcN6ooTdOxfknzZ49/0xCszM3G/woGa5DaC4p3ko5cGTr4b9IXIKE756PlFXNMGveTHG7bpmac+ELGgHsbyODQ8y44E8uUE4MMQi0qvbSajG+tZlVsvCwwNxjFZq3KzmwRT5VUtmTmSyOOUzfWtzIcc+EjRsHJoN0Hxd22JMOx7/1UIrt4OT325/H8IGM40fHBSNwIYDlnx9Yg/RhL8bfLZLmo749N8xPPoBkeCij5TU6e5iZNAHZULzOZDxGVqlGBo2bzTG/fPzbFAi3Ab3si7Owhy5Xrp8bkMbqNPPN/5cbbJOkaBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2L7cO9BrUTWGGcMJIjDd89Jxwx7EH359SA8hrvse4U=;
 b=meZgeyZ6acJpfITai7cF4f0yjDxhuS1qUTD4Fn/AHfWy9dHHA5R/xqXoPk4jRxn38pdd28PijWO2Pms9ufZTTo7X3cV7MMxqCdA3a11//Y6xxKxf0fzqvhjk85ZzqReds8XSag8r9rNsXap9Id8y5EBLLCQpy/BCf8fjL2IFawBlXBx05p+2IaeRYqrU0O22dYMbpW6x7YblZdz7nTnY/vRZKC81demk3vTEbk1iS+p4Yr6xc9pUi8TGc4U4GMhmb8Ko01EBr3RFKrtLdFB9RtcuQBFSVWYnY6lnjGViDhhzk8k0/BiTz/wMDuST1eLLtxwcQdb+597v6fIvXEw3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2L7cO9BrUTWGGcMJIjDd89Jxwx7EH359SA8hrvse4U=;
 b=QViCsn9VSZmh3ymgEsQEu/9gKyK4a9yK2WbkTR5A6zH+P9jFtpdZHTgf5dS3cpntflWUU20J5ETtlUrdt7iMADTrTVP2m07kbDNOgTHocCN3CdltXASBEenLjj6gfpH5sCa9sxq/yfBXbwmV8ouqqOrNbkIdAO7Y2ATMciTqygY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Thu, 28 May 2020 03:05:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 03:05:38 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: enable thermal throttling logging
 support V2
Date: Thu, 28 May 2020 11:04:43 +0800
Message-Id: <20200528030444.28735-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528030444.28735-1-evan.quan@amd.com>
References: <20200528030444.28735-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 03:05:36 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 267a5c68-0d2b-4f17-6c92-08d802b3ff59
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3963F8F23D68AF1C0E2FC856E48E0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDzvXX2pjbOKqqZEFye8+MWF5b1jsdoi56INGduj0fpveT+WrnlIY40DqrLX1mEtjeS9FuKCM2TDD8xKT/qyQweGU7866lLKRH/jVqkwKDAV22Bd87I0XQsj7iDaP6B07ldDPZ5D0LN1A0vjUE+7l++e2Mbue2089il4znrRJR6oEoSJ6EtIsIgYxUhNTsHopQ/RmAZDIOvVvZV59xoWMbZyGIqTERFQib7N46+BbKLECXGkY16xe4cdrNCqZXZBj0vmHzemN9cSdpI7gSsbrbFV91SmXQwAWKfCDRNUL1DVRMegRFzEkFGHqCnGOW8e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(36756003)(6916009)(54906003)(478600001)(6486002)(86362001)(83380400001)(316002)(186003)(16526019)(26005)(1076003)(66946007)(66556008)(66476007)(52116002)(956004)(5660300002)(7696005)(2616005)(4326008)(6666004)(8936002)(8676002)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HjqmPdJLnfLeqLZ6bY803pS5ngk92bXLTFqE2a59hcnt7bIW8OHV5eM/ODozhc9WXWbP7zeZBB5FmgmUI1/cHvPX204+65D3SqBr8QNTSCyXEE8OQeWnKS95fJDBRNWtscY55H5Ivu1aDF0vcrmV4VC0oEsY/4P0o9BS6X6xmZDoM8DPNEDhb1BzAqdQafK1JO71Hhfbn/gAgc6HjG68rFu2E8aLSuR5Uqh1ZVG4ahptvAcDsR6SllSgkiAvwyI1IkO42x2GvaLB2trLywb+9SRxf5uFu7lDka/Cxnz2v72pf/WVwYBZV+INEVFJSjS9RKjhJrxrIDOPfI4MTlnh9czP0EVqbnilwRXiGOkmUTahJicLCCMzAgkuQAgAfeAVGU5Y92pkVVcjSDJxfHYkKNc3TdFzp2jH8/yqJIsLlJUpaN8ioelr4RyTNptp0FBWwWg9LC/O+oOHfgcBF7CgGNBWSl/nryvDzxVkzxFpJOJU5xq/9VaQa/qnS1Pc/U9m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267a5c68-0d2b-4f17-6c92-08d802b3ff59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 03:05:38.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCot3kwKFp2t7REDRiY6fHG2epzbCf2xEz/TqXNgqvwlkB2nKYc2GmSKDkS/pKCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q3VycmVudGx5IHRoaXMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgb24gQXJjdHVydXMgb25seS4gUE1G
VyB3aWxsCmludGVycnVwdCBkcml2ZXIgdGhlIGZpcnN0IHRpbWUgd2hlbiB0aGVybWFsIHRocm90
dGxpbmcgaGFwcGVuZWQKYW5kIGV2ZXJ5IG9uZSBzZWNvbmQgYWZ0ZXJ3YXJkcyBpZiB0aGUgdGhy
b3R0bGluZyBjb250aW51aW5nLiBPbgpyZWNlaXZpbmcgdGhlIDFzdCBpbnRlcnJ1cHQsIGRyaXZl
ciBsb2dzIGl0IHRoZSBmaXJzdCB0aW1lLiBIb3dldmVyLAppZiB0aGUgdGhyb3R0bGluZyBjb250
aW51ZXMsIHRoZSBsb2dnaW5nIHdpbGwgYmUgcGVyZm9ybWVkIGV2ZXJ5Cm1pbnV0ZSB0byBhdm9p
ZCBsb2cgZmxvb2RpbmcuCgpWMjogc2ltcGxpZnkgdGhlIGltcGxlbWVudGlvbiBieSByYXRlbGlt
aXRlZCBwcmludGsKCkNoYW5nZS1JZDogSWE0NTM0NzAwZWUxODNjMTZiMzIzMWI0NjEyMDhiZDAy
NzdmM2I2YTcKU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQWNr
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDExICsrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X3YxMV8wLmMKaW5kZXggNTQ3YjBiM2QxY2Q0Li43YTJlODU1NjA4ZGUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCkBAIC0xNTI0LDYgKzE1MjQs
NyBAQCBzdGF0aWMgaW50IHNtdV92MTFfMF9pcnFfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIAkJCQkgc3RydWN0IGFtZGdwdV9pcnFfc3JjICpzb3VyY2UsCiAJCQkJIHN0cnVj
dCBhbWRncHVfaXZfZW50cnkgKmVudHJ5KQogeworCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0g
JmFkZXYtPnNtdTsKIAl1aW50MzJfdCBjbGllbnRfaWQgPSBlbnRyeS0+Y2xpZW50X2lkOwogCXVp
bnQzMl90IHNyY19pZCA9IGVudHJ5LT5zcmNfaWQ7CiAJLyoKQEAgLTE1MzIsNiArMTUzMywxMSBA
QCBzdGF0aWMgaW50IHNtdV92MTFfMF9pcnFfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAkgKi8KIAl1aW50MzJfdCBjdHhpZCA9IGVudHJ5LT5zcmNfZGF0YVswXTsKIAl1aW50
MzJfdCBkYXRhOworCS8qCisJICogaWYgdGhlIHRocm90dGxpbmcgY29udGludWVzLCB0aGUgbG9n
Z2luZyB3aWxsIGJlIHBlcmZvcm1lZCBldmVyeQorCSAqIG1pbnV0ZSB0byBhdm9pZCBsb2cgZmxv
b2RpbmcuCisJICovCisJc3RhdGljIERFRklORV9SQVRFTElNSVRfU1RBVEUocmF0ZWxpbWl0X3N0
YXRlLCA2MCAqIEhaLCAxKTsKIAogCWlmIChjbGllbnRfaWQgPT0gU09DMTVfSUhfQ0xJRU5USURf
VEhNKSB7CiAJCXN3aXRjaCAoc3JjX2lkKSB7CkBAIC0xNTc1LDYgKzE1ODEsMTEgQEAgc3RhdGlj
IGludCBzbXVfdjExXzBfaXJxX3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
CQkJZGV2X2RiZyhhZGV2LT5kZXYsICJTd2l0Y2hlZCB0byBEQyBtb2RlIVxuIik7CiAJCQkJc211
X3YxMV8wX2Fja19hY19kY19pbnRlcnJ1cHQoJmFkZXYtPnNtdSk7CiAJCQkJYnJlYWs7CisJCQlj
YXNlIDB4NzoKKwkJCQlpZiAoX19yYXRlbGltaXQoJnJhdGVsaW1pdF9zdGF0ZSkpCisJCQkJCXNt
dV9sb2dfdGhlcm1hbF90aHJvdHRsaW5nKHNtdSk7CisKKwkJCQlicmVhazsKIAkJCX0KIAkJfQog
CX0KLS0gCjIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
