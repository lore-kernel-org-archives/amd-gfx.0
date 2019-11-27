Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EBC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281582070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281582070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C231D6E4DE;
	Wed, 27 Nov 2019 09:15:51 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700041.outbound.protection.outlook.com [40.107.70.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0214D6E4DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHDDeUlJ/+cICY3o7Fi1tYpnGyWKoIEmPWq6oItmmOvTJ6HowKgOJnXoh1QAWc3w0ck9ckd9BPixeSXXo9x27TBlFxVZGNGxsknQU7o8Ny3u2JgOWMH/eUnOAos8n3HLrN1EVlLcjWMtMcTKm236HSAVp+PN6CudlujmaLyUXIVRCWOQJX2yvWtfkEE9QeLEM9L0QDeXQaR33R5HIjGVZJ0XZDuicP3Bv3KG3puvh7Eip+MN4n5bzoq56wt30BmveinubMY4Bp3o3BRgK4S2VZtALl+ndfwwfxy++k9cfhbTtLdpBXphfOiavDnZxNGefXwX/Td6K2L32p4gYiESUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcuemGbQYDhhwmyVgXi5DTF0+WfHS4OSZOXzDOhP75A=;
 b=aO3pmO4ioOxmg3xkVXRVU5tRGSvZkkle2HwpjbRtfxySM2oUnRcCt0pN+mfjF07JIeI+nVeyfPuWOq8M3xYijr0AR6xRkZbr/+zur3tlNzJHxBtOykyBsFz1VG6S9hsZIo7KMZKlBY5n49jw8mv/qPfIOSxJfV9kcLfPnX+bQocQiv42Hy/xdjdNSxpMwZ/Cohip3b6oMxIJiIDyXLKL3z5autDEVtR1csxjfqg9SKrD1qNF94dE4yMhSQi7B46byUtpDRkdJ4RJ4hShGu+vQl+1O3T70NRePtA+w4m6JxDiwOo3HViwsYHlKJ84qsHvzVaVIkRtba0xcCpj6QRJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0094.namprd12.prod.outlook.com (2603:10b6:0:55::14) by
 CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 09:15:44 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::204) by DM3PR12CA0094.outlook.office365.com
 (2603:10b6:0:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.17 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:43 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:42 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:42 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:40 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amdgpu: clear ras controller status registers when
 interrupt occurs
Date: Wed, 27 Nov 2019 17:15:23 +0800
Message-ID: <1574846129-4826-3-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(428003)(199004)(189003)(4326008)(186003)(2616005)(11346002)(446003)(478600001)(2351001)(36756003)(336012)(2906002)(70206006)(70586007)(6916009)(8676002)(5660300002)(305945005)(8936002)(81156014)(50226002)(426003)(86362001)(54906003)(48376002)(316002)(81166006)(26005)(44832011)(47776003)(51416003)(16586007)(76176011)(356004)(6666004)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3992; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13b26447-41e5-4b6d-feb4-08d7731a6134
X-MS-TrafficTypeDiagnostic: CH2PR12MB3992:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3992FBBDFB45F538D817EB81F6440@CH2PR12MB3992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5FitRhnX2f6o375QuRn/2njce66fQToVUAg+HcYNyYOyxzEf5UbH2mmHodnuwf5+4CuLx6B5b9YVmpVHIYPjWNBD4c5Q6IoOOFFfYD/vVQ5hvJqeNfdKM8aPMvEclnodawo0/am299937+oSONpo9poCNDlfE900pTuwXw4ZvgD2uLBFIpdef7wpIj9hA/WAUmyhoftNWmlHntFxeQOmT4WGx5TwJQAE8iE7Ua0Grfz5Do4r2QOtCj0UMheaF/1eSsYEV6tejkDIKQAeVTXMzbD0XtqJyfUBqaHGqkKk4yzbOqYSe0Sxqv2KgtBmVHRcuRCct+nTdywG3ye8Gw3aRlqSN709Qx4fyDpFVMnfnKE7V3W7BGqyEYoCbHjtC1tCLjxz6xZzLWWXjfDj6FrUh06jakUwKgQ7edYDkNFEk+ANqIS1h684xCIaYjgF+e5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:43.2580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b26447-41e5-4b6d-feb4-08d7731a6134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcuemGbQYDhhwmyVgXi5DTF0+WfHS4OSZOXzDOhP75A=;
 b=qYD3WGTTzpl9yhST5gKZHAetBM7FGq1y7WeroRCR5JTlXqRWGfpSaL9uoDXNY/Isdw0kkonBXKbLfBqLohl89vcoakp1KQL4vcHvLKz2Z8OVSAxpTNECpoMszEZRezHoZStDDyuqd/ZQg82HqPmf/JBdFDCmTrPPJHHGOLaD4Qk=
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
Message-ID: <20191127091523.NsRXHtshleZvPRYS1jyx2-twqNI_XiVP31tEy6GlzqU@z>

VG8gZml4IGlzc3VlIHRoYXQgcmFzIGNvbnRyb2xsZXIgaW50ZXJydXB0IGNhbm5vdCBiZSB0cmln
Z2VyZWQgYW55bW9yZSBhZnRlcgpvbmUgdGltZSBuYmlmIHVuY29ycmVjdGFibGUgZXJyb3IuIEFu
ZCBlcnJvciBjb3VudCBpcyBzdG9yZWQgaW4gbmJpZiByYXMgb2JqZWN0CmZvciBxdWVyeS4KCkNo
YW5nZS1JZDogSWJhNDgyYzE2OWZkZmYzZTljMzkwMDcyYzAyODlhNjIyYTUyMjEzM2MKU2lnbmVk
LW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbmJpb192N180LmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9f
djdfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMKaW5kZXggMjUy
MzFkNi4uOWEzYTY1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJp
b192N180LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMKQEAg
LTUyLDYgKzUyLDkgQEAKICNkZWZpbmUgQklGX01NU0NIMV9ET09SQkVMTF9SQU5HRV9fT0ZGU0VU
X01BU0sgICAgICAgICAgMHgwMDAwMEZGQ0wKICNkZWZpbmUgQklGX01NU0NIMV9ET09SQkVMTF9S
QU5HRV9fU0laRV9NQVNLICAgICAgICAgICAgMHgwMDFGMDAwMEwKIAorc3RhdGljIHZvaWQgbmJp
b192N180X3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
KwkJCQkJdm9pZCAqcmFzX2Vycm9yX3N0YXR1cyk7CisKIHN0YXRpYyB2b2lkIG5iaW9fdjdfNF9y
ZW1hcF9oZHBfcmVnaXN0ZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCVdSRUcz
Ml9TT0MxNShOQklPLCAwLCBtbVJFTUFQX0hEUF9NRU1fRkxVU0hfQ05UTCwKQEAgLTMxNCw2ICsz
MTcsNyBAQCBzdGF0aWMgdm9pZCBuYmlvX3Y3XzRfaW5pdF9yZWdpc3RlcnMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiBzdGF0aWMgdm9pZCBuYmlvX3Y3XzRfaGFuZGxlX3Jhc19jb250cm9s
bGVyX2ludHJfbm9fYmlmcmluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAl1aW50
MzJfdCBiaWZfZG9vcmJlbGxfaW50cl9jbnRsOworCXN0cnVjdCByYXNfbWFuYWdlciAqb2JqID0g
YW1kZ3B1X3Jhc19maW5kX29iaihhZGV2LCBhZGV2LT5uYmlvLnJhc19pZik7CiAKIAliaWZfZG9v
cmJlbGxfaW50cl9jbnRsID0gUlJFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0RPT1JCRUxMX0lO
VF9DTlRMKTsKIAlpZiAoUkVHX0dFVF9GSUVMRChiaWZfZG9vcmJlbGxfaW50cl9jbnRsLApAQCAt
MzI0LDYgKzMyOCwxMiBAQCBzdGF0aWMgdm9pZCBuYmlvX3Y3XzRfaGFuZGxlX3Jhc19jb250cm9s
bGVyX2ludHJfbm9fYmlmcmluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQogCQkJCQkJUkFTX0NOVExS
X0lOVEVSUlVQVF9DTEVBUiwgMSk7CiAJCVdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9ET09S
QkVMTF9JTlRfQ05UTCwgYmlmX2Rvb3JiZWxsX2ludHJfY250bCk7CiAKKwkJLyoKKwkJICogY2xl
YXIgZXJyb3Igc3RhdHVzIGFmdGVyIHJhc19jb250cm9sbGVyX2ludHIgYWNjb3JkaW5nIHRvCisJ
CSAqIGh3IHRlYW0gYW5kIGNvdW50IHVlIG51bWJlciBmb3IgcXVlcnkKKwkJICovCisJCW5iaW9f
djdfNF9xdWVyeV9yYXNfZXJyb3JfY291bnQoYWRldiwgJm9iai0+ZXJyX2RhdGEpOworCiAJCURS
TV9XQVJOKCJSQVMgY29udHJvbGxlciBpbnRlcnJ1cHQgdHJpZ2dlcmVkIGJ5IE5CSUYgZXJyb3Jc
biIpOwogCiAJCS8qIHJhc19jb250cm9sbGVyX2ludCBpcyBkZWRpY2F0ZWQgZm9yIG5iaWYgcmFz
IGVycm9yLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
