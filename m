Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71267C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA4622AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA4622AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F265D6E882;
	Sat, 12 Dec 2020 15:47:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8216B6E882
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCt8NR6X7+tEDu8xSZtOQOuinFzRWgDCpn86vNtX1DHiSExalZ2SEafMNJSq2oeVFmQU/HFHvLvCXVYIFCrqzLQ4HQS2t+peFxDOsynOOk3Wzg4GO5XHFo2BFRyOZSx/FLlGH+0udqQDoxtB8Yzqdez4kaqTAc8dX1hk/tfQ85SAbPn3bc+Jzjb+Dv7bLTK2WG8Wfgmr/RNlWg3tBea92Lpv09COGWJm31hpsQ0HTCD85ABYGb9ldOJSGylIbF75o6ObDky9/r1XDqHJ8cMzTPTID/xdYx4G4IT/N+sEpMcWs8DuD4mdyh8WgelXzk41GQj/hD6r/HlVJiKlDSdhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBHaIJvVhvDbF1zq+SatGJFE4UII0T8sX+yf9qXwQo8=;
 b=J8GxhILp/ASEvxLjeGK48VO0J3aAofeolB58xXaJUZoHs5GiAhUuFxJFpN7v0337ehtvfNBDU1iBqifVq7GEeAFrnjOa8mZyWf93b08tcYbxvw9F24lH5Bs2D8OWnrsyiRh18pGhLxOlw5KveAiANjv9g2N4X8Zzhul1Wo+TIKcr4bgXazLnu5k7JhMYZaPQD4caQJqt81xyEplhG6OnmQ00nt7JLqW5uHkYo6hjTzc6CAP63Q08BQ+iQAyl+ICLmt8nxgvk8H/2Rc/M9cB4nfuxLKs3MGJGCnVAQPtq73IX9FeujUfcU/7zfO6r/Cfxk5EIEBjKRYMP+KTL+jufkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBHaIJvVhvDbF1zq+SatGJFE4UII0T8sX+yf9qXwQo8=;
 b=rukESZj+hOV4icaEGspavZ9dL/gfLmTauZSrC90PNH0VYLoi3ftvr0+6cTZqHmsY0D6dbK97ecgEZcqfkUhJovCJlib6inMJP8X5NfVtZ+KDGUkzcFFfbopWJcdfKLovT3BZ98ffjITMh6tPB3AWSixvkufvzHlxWd8kaVbqKMc=
Received: from MWHPR19CA0008.namprd19.prod.outlook.com (2603:10b6:300:d4::18)
 by BN8PR12MB3233.namprd12.prod.outlook.com (2603:10b6:408:9f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 15:47:03 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::23) by MWHPR19CA0008.outlook.office365.com
 (2603:10b6:300:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:01 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:59 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 18/27] drm/amdgpu: switch to common decode iv helper
Date: Sat, 12 Dec 2020 23:45:51 +0800
Message-ID: <20201212154600.21618-18-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a42743-233b-4ce8-28f5-08d89eb52b78
X-MS-TrafficTypeDiagnostic: BN8PR12MB3233:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3233EA8019722857F6DAE631FCC90@BN8PR12MB3233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWVEXc/OVwrniGnPv4NdFxPC4tz9K3Rp79G6ZVffGb8aphfoGCp7egx+fGZdFeEZE1/OHHGJzqyRPB67QA1C8QP+Uk/vgpjl6dfanQoZHeez+aCwX5AXsFnwjnd1rdf92dz05Rs/c+qAdpj/OQZDz9zSYRbU4kxdD2G8tQiWDYAl3mkF/XBa7Te3nm9IBy3Hy2ZvToEXBvhaA7pf2TQHNhPUxa5MPpOaDXIsUYBOiISjhwA54XUAAkDLsvXBpU4QuD/a9N67E2D2OPudrggeMDQF3VQckAzwYpSiZ3IT+Ff3tFTG7s5v8qIZkO3FL0v7/+uoSZWZD5sTvzw4XP43PSl6P+Gxwl4CBB5H/Q/X1jXAnh/B4dMPBehpKYUUlbkbb+diJKt+75afRW76RqdpqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(83380400001)(6666004)(8676002)(110136005)(4326008)(356005)(5660300002)(47076004)(36756003)(2906002)(336012)(1076003)(7696005)(70586007)(82310400003)(81166007)(8936002)(70206006)(86362001)(426003)(2616005)(508600001)(26005)(186003)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:02.6840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a42743-233b-4ce8-28f5-08d89eb52b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3233
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

VGhlIGl2IGZvcm1hdCBpcyB0aGUgc2FtZSBmb3IgYWxsIHRoZSBzb2MxNSBhZHBhdGVyCmFuZCBv
bndhcmRzIGFuZCBjYW4gc2hhcmUgYSBjb21tb24gZnVuY3Rpb24gdG8KZGVjb2RlIGl2LgoKU2ln
bmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTog
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEZW5u
aXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWku
WHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8
IDQ3ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMTBfaWguYyB8IDQ3ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9uYXZpMTBfaWguYwppbmRleCA4NjA3MmFiY2Q2MDUuLmEyNTBlNGY3N2YzMyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKQEAgLTQ1Miw1MSArNDUyLDYgQEAg
c3RhdGljIHUzMiBuYXZpMTBfaWhfZ2V0X3dwdHIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
CiAJcmV0dXJuICh3cHRyICYgaWgtPnB0cl9tYXNrKTsKIH0KIAotLyoqCi0gKiBuYXZpMTBfaWhf
ZGVjb2RlX2l2IC0gZGVjb2RlIGFuIGludGVycnVwdCB2ZWN0b3IKLSAqCi0gKiBAYWRldjogYW1k
Z3B1X2RldmljZSBwb2ludGVyCi0gKiBAaWg6IElIIHJpbmcgYnVmZmVyIHRvIGRlY29kZQotICog
QGVudHJ5OiBJViBlbnRyeSB0byBwbGFjZSBkZWNvZGVkIGluZm9ybWF0aW9uIGludG8KLSAqCi0g
KiBEZWNvZGVzIHRoZSBpbnRlcnJ1cHQgdmVjdG9yIGF0IHRoZSBjdXJyZW50IHJwdHIKLSAqIHBv
c2l0aW9uIGFuZCBhbHNvIGFkdmFuY2UgdGhlIHBvc2l0aW9uLgotICovCi1zdGF0aWMgdm9pZCBu
YXZpMTBfaWhfZGVjb2RlX2l2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAotCQkJCXN0cnVj
dCBhbWRncHVfaWhfcmluZyAqaWgsCi0JCQkJc3RydWN0IGFtZGdwdV9pdl9lbnRyeSAqZW50cnkp
Ci17Ci0JLyogd3B0ci9ycHRyIGFyZSBpbiBieXRlcyEgKi8KLQl1MzIgcmluZ19pbmRleCA9IGlo
LT5ycHRyID4+IDI7Ci0JdWludDMyX3QgZHdbOF07Ci0KLQlkd1swXSA9IGxlMzJfdG9fY3B1KGlo
LT5yaW5nW3JpbmdfaW5kZXggKyAwXSk7Ci0JZHdbMV0gPSBsZTMyX3RvX2NwdShpaC0+cmluZ1ty
aW5nX2luZGV4ICsgMV0pOwotCWR3WzJdID0gbGUzMl90b19jcHUoaWgtPnJpbmdbcmluZ19pbmRl
eCArIDJdKTsKLQlkd1szXSA9IGxlMzJfdG9fY3B1KGloLT5yaW5nW3JpbmdfaW5kZXggKyAzXSk7
Ci0JZHdbNF0gPSBsZTMyX3RvX2NwdShpaC0+cmluZ1tyaW5nX2luZGV4ICsgNF0pOwotCWR3WzVd
ID0gbGUzMl90b19jcHUoaWgtPnJpbmdbcmluZ19pbmRleCArIDVdKTsKLQlkd1s2XSA9IGxlMzJf
dG9fY3B1KGloLT5yaW5nW3JpbmdfaW5kZXggKyA2XSk7Ci0JZHdbN10gPSBsZTMyX3RvX2NwdShp
aC0+cmluZ1tyaW5nX2luZGV4ICsgN10pOwotCi0JZW50cnktPmNsaWVudF9pZCA9IGR3WzBdICYg
MHhmZjsKLQllbnRyeS0+c3JjX2lkID0gKGR3WzBdID4+IDgpICYgMHhmZjsKLQllbnRyeS0+cmlu
Z19pZCA9IChkd1swXSA+PiAxNikgJiAweGZmOwotCWVudHJ5LT52bWlkID0gKGR3WzBdID4+IDI0
KSAmIDB4ZjsKLQllbnRyeS0+dm1pZF9zcmMgPSAoZHdbMF0gPj4gMzEpOwotCWVudHJ5LT50aW1l
c3RhbXAgPSBkd1sxXSB8ICgodTY0KShkd1syXSAmIDB4ZmZmZikgPDwgMzIpOwotCWVudHJ5LT50
aW1lc3RhbXBfc3JjID0gZHdbMl0gPj4gMzE7Ci0JZW50cnktPnBhc2lkID0gZHdbM10gJiAweGZm
ZmY7Ci0JZW50cnktPnBhc2lkX3NyYyA9IGR3WzNdID4+IDMxOwotCWVudHJ5LT5zcmNfZGF0YVsw
XSA9IGR3WzRdOwotCWVudHJ5LT5zcmNfZGF0YVsxXSA9IGR3WzVdOwotCWVudHJ5LT5zcmNfZGF0
YVsyXSA9IGR3WzZdOwotCWVudHJ5LT5zcmNfZGF0YVszXSA9IGR3WzddOwotCi0JLyogd3B0ci9y
cHRyIGFyZSBpbiBieXRlcyEgKi8KLQlpaC0+cnB0ciArPSAzMjsKLX0KLQogLyoqCiAgKiBuYXZp
MTBfaWhfaXJxX3JlYXJtIC0gcmVhcm0gSVJRIGlmIGxvc3QKICAqCkBAIC03OTMsNyArNzQ4LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3MgbmF2aTEwX2loX2lwX2Z1bmNzID0g
ewogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9paF9mdW5jcyBuYXZpMTBfaWhfZnVuY3Mg
PSB7CiAJLmdldF93cHRyID0gbmF2aTEwX2loX2dldF93cHRyLAotCS5kZWNvZGVfaXYgPSBuYXZp
MTBfaWhfZGVjb2RlX2l2LAorCS5kZWNvZGVfaXYgPSBhbWRncHVfaWhfZGVjb2RlX2l2X2hlbHBl
ciwKIAkuc2V0X3JwdHIgPSBuYXZpMTBfaWhfc2V0X3JwdHIKIH07CiAKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmVnYTEwX2loLmMKaW5kZXggMzJjM2RkMGI2Mjc2Li42Njk0ZGY3MWY1NDUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCkBAIC0zNzgsNTEgKzM3OCw2IEBA
IHN0YXRpYyB1MzIgdmVnYTEwX2loX2dldF93cHRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCXJldHVybiAod3B0ciAmIGloLT5wdHJfbWFzayk7CiB9CiAKLS8qKgotICogdmVnYTEwX2lo
X2RlY29kZV9pdiAtIGRlY29kZSBhbiBpbnRlcnJ1cHQgdmVjdG9yCi0gKgotICogQGFkZXY6IGFt
ZGdwdV9kZXZpY2UgcG9pbnRlcgotICogQGloOiBJSCByaW5nIGJ1ZmZlciB0byBkZWNvZGUKLSAq
IEBlbnRyeTogSVYgZW50cnkgdG8gcGxhY2UgZGVjb2RlZCBpbmZvcm1hdGlvbiBpbnRvCi0gKgot
ICogRGVjb2RlcyB0aGUgaW50ZXJydXB0IHZlY3RvciBhdCB0aGUgY3VycmVudCBycHRyCi0gKiBw
b3NpdGlvbiBhbmQgYWxzbyBhZHZhbmNlIHRoZSBwb3NpdGlvbi4KLSAqLwotc3RhdGljIHZvaWQg
dmVnYTEwX2loX2RlY29kZV9pdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLQkJCQlzdHJ1
Y3QgYW1kZ3B1X2loX3JpbmcgKmloLAotCQkJCXN0cnVjdCBhbWRncHVfaXZfZW50cnkgKmVudHJ5
KQotewotCS8qIHdwdHIvcnB0ciBhcmUgaW4gYnl0ZXMhICovCi0JdTMyIHJpbmdfaW5kZXggPSBp
aC0+cnB0ciA+PiAyOwotCXVpbnQzMl90IGR3WzhdOwotCi0JZHdbMF0gPSBsZTMyX3RvX2NwdShp
aC0+cmluZ1tyaW5nX2luZGV4ICsgMF0pOwotCWR3WzFdID0gbGUzMl90b19jcHUoaWgtPnJpbmdb
cmluZ19pbmRleCArIDFdKTsKLQlkd1syXSA9IGxlMzJfdG9fY3B1KGloLT5yaW5nW3JpbmdfaW5k
ZXggKyAyXSk7Ci0JZHdbM10gPSBsZTMyX3RvX2NwdShpaC0+cmluZ1tyaW5nX2luZGV4ICsgM10p
OwotCWR3WzRdID0gbGUzMl90b19jcHUoaWgtPnJpbmdbcmluZ19pbmRleCArIDRdKTsKLQlkd1s1
XSA9IGxlMzJfdG9fY3B1KGloLT5yaW5nW3JpbmdfaW5kZXggKyA1XSk7Ci0JZHdbNl0gPSBsZTMy
X3RvX2NwdShpaC0+cmluZ1tyaW5nX2luZGV4ICsgNl0pOwotCWR3WzddID0gbGUzMl90b19jcHUo
aWgtPnJpbmdbcmluZ19pbmRleCArIDddKTsKLQotCWVudHJ5LT5jbGllbnRfaWQgPSBkd1swXSAm
IDB4ZmY7Ci0JZW50cnktPnNyY19pZCA9IChkd1swXSA+PiA4KSAmIDB4ZmY7Ci0JZW50cnktPnJp
bmdfaWQgPSAoZHdbMF0gPj4gMTYpICYgMHhmZjsKLQllbnRyeS0+dm1pZCA9IChkd1swXSA+PiAy
NCkgJiAweGY7Ci0JZW50cnktPnZtaWRfc3JjID0gKGR3WzBdID4+IDMxKTsKLQllbnRyeS0+dGlt
ZXN0YW1wID0gZHdbMV0gfCAoKHU2NCkoZHdbMl0gJiAweGZmZmYpIDw8IDMyKTsKLQllbnRyeS0+
dGltZXN0YW1wX3NyYyA9IGR3WzJdID4+IDMxOwotCWVudHJ5LT5wYXNpZCA9IGR3WzNdICYgMHhm
ZmZmOwotCWVudHJ5LT5wYXNpZF9zcmMgPSBkd1szXSA+PiAzMTsKLQllbnRyeS0+c3JjX2RhdGFb
MF0gPSBkd1s0XTsKLQllbnRyeS0+c3JjX2RhdGFbMV0gPSBkd1s1XTsKLQllbnRyeS0+c3JjX2Rh
dGFbMl0gPSBkd1s2XTsKLQllbnRyeS0+c3JjX2RhdGFbM10gPSBkd1s3XTsKLQotCS8qIHdwdHIv
cnB0ciBhcmUgaW4gYnl0ZXMhICovCi0JaWgtPnJwdHIgKz0gMzI7Ci19Ci0KIC8qKgogICogdmVn
YTEwX2loX2lycV9yZWFybSAtIHJlYXJtIElSUSBpZiBsb3N0CiAgKgpAQCAtNjk3LDcgKzY1Miw3
IEBAIGNvbnN0IHN0cnVjdCBhbWRfaXBfZnVuY3MgdmVnYTEwX2loX2lwX2Z1bmNzID0gewogCiBz
dGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9paF9mdW5jcyB2ZWdhMTBfaWhfZnVuY3MgPSB7CiAJ
LmdldF93cHRyID0gdmVnYTEwX2loX2dldF93cHRyLAotCS5kZWNvZGVfaXYgPSB2ZWdhMTBfaWhf
ZGVjb2RlX2l2LAorCS5kZWNvZGVfaXYgPSBhbWRncHVfaWhfZGVjb2RlX2l2X2hlbHBlciwKIAku
c2V0X3JwdHIgPSB2ZWdhMTBfaWhfc2V0X3JwdHIKIH07CiAKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
