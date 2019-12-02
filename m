Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A2C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA9520848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA9520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB6F6E2C4;
	Mon,  2 Dec 2019 17:35:15 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820054.outbound.protection.outlook.com [40.107.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E7D6E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSr2w3WZUP1J2LyREzY+Hj0Dl3kYh9iKM0eDvs9LCKWzpqgOXEdRZNUtdnRfyP69iKzmQ1o/KdKujuDVZ3tNh/qXZLaLimqbQ5SJXWwEmsPLLCKuKx0l7zuUMTOLIhjgTawzlFr8C5po25I8CXdYAIUMRGU1DPES8TMK/JKdkzQBbHpAq+u9Mbx+vL7oIw+7cyZYDz5vK2bphrQEOOqGHhm3B2jcZPz6qcFXy4kjRBOLwJW66cOpUhSvKioI7kYT9VzkBZfUWbJNBaHCqaoDYNo3BWbEwd5ejkB+JUyH1VRDc68ivcsgYyciR+mW6SFWtB1RQVTyFb67TSdA584p9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCPKw9AQRuQs7lNCBx76G6C/tKzzTU5gOMjRDGnmYvg=;
 b=MV1tz9dY/S6flAEC/UAYEzm51oV4lcTt1mxNys9NmEAPmSI6JR8pITEFuKpWbV02492k0TiGYfWervYMto3yEw7yDCXdXb3KJJBcPD5npWUHJOxQBCrAO96OqiG1jtMhYCj212SmNNMK12M5sxTQUp4Ei9A+00nDVr106unuGZaoazysPfuir7bSlTd2EVSq8RHfRKgZbykIDr9vmt1f3abO4ZHCJLj14E8ojKAO8sSwPEZL4AGj3Td+7lCgiv92hKAET1AWznNEP6eMSBx/Q34fWQ8vDl+unA4s9rIMa+PlwO5HsnEUUCBzKBTdMSfkUkmaMUxU7dgXFXiocSQSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:11 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:10 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/51] drm/amd/display: Implement DePQ for DCN1
Date: Mon,  2 Dec 2019 12:33:39 -0500
Message-Id: <20191202173405.31582-26-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cdcd95c-1ec1-4f62-edd7-08d7774dfb14
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28022C2DBCCAEAD6378AE93182430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRVjJNDV/3CwSRuZJGiZyIcWSmYvUAxM5mpUndFf/LQbkXAfH4xjsyfwJADNGT5Fy6XI8i9r7ijPH2M253pzKg/F7naNRZLk760l3hJK4iQrNVT5tRxz8hJBr0U8hpS1OuelzTxSdcwvqSnnzi6cDUYLhXf4Wx/Vb8iqSuf+h2zb+ebE3CiID7gevHoQm3bm+on+t+uxTPCxFoqWKrRBbBeaz3FlDKleXUkqMMIcSvLIvGgzAZN7sqbaOkb1pGZlN45b9qz/n92PA45l2PfpK4tXQzuvd2XWBSjv7HWfUgK1tJLim4I+K7rgtWqJGTYZFgoqWQOSt4IZBGtafwIsZ5CNKlIfvsXKWnVw847ZSB4kdKlbz763F2OPJ7nJv5G5FYd7epANc4z0vlqr0JrcOj1v2PPQ40ivbcxQgUMY4Gdp6IP8zBQ4afzJWEk0koUD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdcd95c-1ec1-4f62-edd7-08d7774dfb14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:10.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLtX9PT2ZaID7OxGxeNvFX3ZANbaVtJ5TMj50gYYWl04z/Ln9/SCBzxmklUOUk6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCPKw9AQRuQs7lNCBx76G6C/tKzzTU5gOMjRDGnmYvg=;
 b=0bbOvnLgRig1NkDIU9xBGQRgI+u1IqPpHPMLg8RfoJePvedR6XtMZT1XwcRnyYrDnb3L0j1AHymcT4P5+bcfSpLRGHg+uEQZCnJgURvVMxAe+y30AGYrUYpiJ3y8qlsc3N8fw0lLF2NdGItrMWn512G107EufyUoFKMcFp74hXA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Reza Amini <Reza.Amini@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogUmV6YSBBbWluaSA8UmV6YS5BbWluaUBhbWQuY29tPgoKW1doeV0KTmVlZCBzdXBwb3J0
IGZvciBtb3JlIGNvbG9yIG1hbmFnZW1lbnQgaW4gMTBiaXQKc3VyZmFjZS4KCltIb3ddClByb3Zp
ZGUgc3VwcG9ydCBmb3IgRGVQUSBmb3IgMTBiaXQgc3VyZmFjZQoKU2lnbmVkLW9mZi1ieTogUmV6
YSBBbWluaSA8UmV6YS5BbWluaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogS3J1bm9zbGF2IEtvdmFj
IDxLcnVub3NsYXYuS292YWNAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBh
bWQuY29tPgotLS0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfZHBwX2NtLmMg
ICB8ICAzICsrCiAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMg
fCAgNSArKysKIC4uLi9hbWQvZGlzcGxheS9tb2R1bGVzL2NvbG9yL2NvbG9yX2dhbW1hLmMgICB8
IDM5ICsrKysrKysrKysrKysrLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMTAvZGNuMTBfZHBwX2NtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMTAvZGNuMTBfZHBwX2NtLmMKaW5kZXggNmI3NTkzZGQwYzc3Li45MzVjODkyNjIyYTAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9k
cHBfY20uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBf
ZHBwX2NtLmMKQEAgLTYyOCw2ICs2MjgsOSBAQCB2b2lkIGRwcDFfc2V0X2RlZ2FtbWEoCiAJY2Fz
ZSBJUFBfREVHQU1NQV9NT0RFX0hXX3h2WUNDOgogCQlSRUdfVVBEQVRFKENNX0RHQU1fQ09OVFJP
TCwgQ01fREdBTV9MVVRfTU9ERSwgMik7CiAJCQlicmVhazsKKwljYXNlIElQUF9ERUdBTU1BX01P
REVfVVNFUl9QV0w6CisJCVJFR19VUERBVEUoQ01fREdBTV9DT05UUk9MLCBDTV9ER0FNX0xVVF9N
T0RFLCAzKTsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJQlJFQUtfVE9fREVCVUdHRVIoKTsKIAkJ
YnJlYWs7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAv
ZGNuMTBfaHdfc2VxdWVuY2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKaW5kZXggMjQ0MGUyODQ5M2U3Li45NTUxZmVmYjlkMWQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9o
d19zZXF1ZW5jZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAv
ZGNuMTBfaHdfc2VxdWVuY2VyLmMKQEAgLTE0NjUsNiArMTQ2NSwxMSBAQCBib29sIGRjbjEwX3Nl
dF9pbnB1dF90cmFuc2Zlcl9mdW5jKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBwaXBlX2N0eCAqcGlw
ZV9jdHgsCiAJCQlkcHBfYmFzZS0+ZnVuY3MtPmRwcF9zZXRfZGVnYW1tYShkcHBfYmFzZSwgSVBQ
X0RFR0FNTUFfTU9ERV9CWVBBU1MpOwogCQkJYnJlYWs7CiAJCWNhc2UgVFJBTlNGRVJfRlVOQ1RJ
T05fUFE6CisJCQlkcHBfYmFzZS0+ZnVuY3MtPmRwcF9zZXRfZGVnYW1tYShkcHBfYmFzZSwgSVBQ
X0RFR0FNTUFfTU9ERV9VU0VSX1BXTCk7CisJCQljbV9oZWxwZXJfdHJhbnNsYXRlX2N1cnZlX3Rv
X2RlZ2FtbWFfaHdfZm9ybWF0KHRmLCAmZHBwX2Jhc2UtPmRlZ2FtbWFfcGFyYW1zKTsKKwkJCWRw
cF9iYXNlLT5mdW5jcy0+ZHBwX3Byb2dyYW1fZGVnYW1tYV9wd2woZHBwX2Jhc2UsICZkcHBfYmFz
ZS0+ZGVnYW1tYV9wYXJhbXMpOworCQkJcmVzdWx0ID0gdHJ1ZTsKKwkJCWJyZWFrOwogCQlkZWZh
dWx0OgogCQkJcmVzdWx0ID0gZmFsc2U7CiAJCQlicmVhazsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2NvbG9yL2NvbG9yX2dhbW1hLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9jb2xvci9jb2xvcl9nYW1tYS5jCmluZGV4IDli
MTIxYjA4YzgwNi4uYjUyYzRkMzc5NjUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9jb2xvci9jb2xvcl9nYW1tYS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9tb2R1bGVzL2NvbG9yL2NvbG9yX2dhbW1hLmMKQEAgLTE1NCw2ICsxNTQs
NyBAQCBzdGF0aWMgdm9pZCBjb21wdXRlX2RlX3BxKHN0cnVjdCBmaXhlZDMxXzMyIGluX3gsIHN0
cnVjdCBmaXhlZDMxXzMyICpvdXRfeSkKIAogCXN0cnVjdCBmaXhlZDMxXzMyIGxfcG93X20xOwog
CXN0cnVjdCBmaXhlZDMxXzMyIGJhc2UsIGRpdjsKKwlzdHJ1Y3QgZml4ZWQzMV8zMiBiYXNlMjsK
IAogCiAJaWYgKGRjX2ZpeHB0X2x0KGluX3gsIGRjX2ZpeHB0X3plcm8pKQpAQCAtMTYzLDEzICsx
NjQsMTUgQEAgc3RhdGljIHZvaWQgY29tcHV0ZV9kZV9wcShzdHJ1Y3QgZml4ZWQzMV8zMiBpbl94
LCBzdHJ1Y3QgZml4ZWQzMV8zMiAqb3V0X3kpCiAJCQlkY19maXhwdF9kaXYoZGNfZml4cHRfb25l
LCBtMikpOwogCWJhc2UgPSBkY19maXhwdF9zdWIobF9wb3dfbTEsIGMxKTsKIAotCWlmIChkY19m
aXhwdF9sdChiYXNlLCBkY19maXhwdF96ZXJvKSkKLQkJYmFzZSA9IGRjX2ZpeHB0X3plcm87Ci0K
IAlkaXYgPSBkY19maXhwdF9zdWIoYzIsIGRjX2ZpeHB0X211bChjMywgbF9wb3dfbTEpKTsKIAot
CSpvdXRfeSA9IGRjX2ZpeHB0X3BvdyhkY19maXhwdF9kaXYoYmFzZSwgZGl2KSwKLQkJCWRjX2Zp
eHB0X2RpdihkY19maXhwdF9vbmUsIG0xKSk7CisJYmFzZTIgPSBkY19maXhwdF9kaXYoYmFzZSwg
ZGl2KTsKKwkvL2F2b2lkIGNvbXBsZXggbnVtYmVycworCWlmIChkY19maXhwdF9sdChiYXNlMiwg
ZGNfZml4cHRfemVybykpCisJCWJhc2UyID0gZGNfZml4cHRfc3ViKGRjX2ZpeHB0X3plcm8sIGJh
c2UyKTsKKworCisJKm91dF95ID0gZGNfZml4cHRfcG93KGJhc2UyLCBkY19maXhwdF9kaXYoZGNf
Zml4cHRfb25lLCBtMSkpOwogCiB9CiAKQEAgLTE5OTgsMTAgKzIwMDEsMjggQEAgYm9vbCBtb2Rf
Y29sb3JfY2FsY3VsYXRlX2RlZ2FtbWFfcGFyYW1zKHN0cnVjdCBkY190cmFuc2Zlcl9mdW5jICpp
bnB1dF90ZiwKIAl0Zl9wdHMtPnhfcG9pbnRfYXRfeTFfZ3JlZW4gPSAxOwogCXRmX3B0cy0+eF9w
b2ludF9hdF95MV9ibHVlID0gMTsKIAotCW1hcF9yZWdhbW1hX2h3X3RvX3hfdXNlcihyYW1wLCBj
b2VmZiwgcmdiX3VzZXIsCi0JCQljb29yZGluYXRlc194LCBheGlzX3gsIGN1cnZlLAotCQkJTUFY
X0hXX1BPSU5UUywgdGZfcHRzLAotCQkJbWFwVXNlclJhbXAgJiYgcmFtcCAmJiByYW1wLT50eXBl
ID09IEdBTU1BX1JHQl8yNTYpOworCWlmIChpbnB1dF90Zi0+dGYgPT0gVFJBTlNGRVJfRlVOQ1RJ
T05fUFEpIHsKKwkJLyoganVzdCBjb3B5IGN1cnJlbnQgcmdiX3JlZ2FtbWEgaW50byAgdGZfcHRz
ICovCisJCXN0cnVjdCBwd2xfZmxvYXRfZGF0YV9leCAqY3VydmVQdCA9IGN1cnZlOworCQlpbnQg
aSA9IDA7CisKKwkJd2hpbGUgKGkgPD0gTUFYX0hXX1BPSU5UUykgeworCQkJdGZfcHRzLT5yZWRb
aV0gICA9IGN1cnZlUHQtPnI7CisJCQl0Zl9wdHMtPmdyZWVuW2ldID0gY3VydmVQdC0+ZzsKKwkJ
CXRmX3B0cy0+Ymx1ZVtpXSAgPSBjdXJ2ZVB0LT5iOworCQkJKytjdXJ2ZVB0OworCQkJKytpOwor
CQl9CisJfSBlbHNlIHsKKwkJLy9jbGFtcHMgdG8gMC0xCisJCW1hcF9yZWdhbW1hX2h3X3RvX3hf
dXNlcihyYW1wLCBjb2VmZiwgcmdiX3VzZXIsCisJCQkJY29vcmRpbmF0ZXNfeCwgYXhpc194LCBj
dXJ2ZSwKKwkJCQlNQVhfSFdfUE9JTlRTLCB0Zl9wdHMsCisJCQkJbWFwVXNlclJhbXAgJiYgcmFt
cCAmJiByYW1wLT50eXBlID09IEdBTU1BX1JHQl8yNTYpOworCX0KKworCisKIAlpZiAocmFtcC0+
dHlwZSA9PSBHQU1NQV9DVVNUT00pCiAJCWFwcGx5X2x1dF8xZChyYW1wLCBNQVhfSFdfUE9JTlRT
LCB0Zl9wdHMpOwogCi0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
