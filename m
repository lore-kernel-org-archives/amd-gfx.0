Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB9C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FC3222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FC3222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2B76ED24;
	Wed, 13 Nov 2019 14:12:50 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820055.outbound.protection.outlook.com [40.107.82.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6506ED24
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 14:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTPO0im75l/QiiV0LZuFTQZasNNb/ttt2+WKcLK9uV2aETCll/jLh8DkWkYcYqsBLi9OF04hfqzxD8ChAYNSYRsMTmIgzYNA/J6vuTwUfeLlfqFCxbKH8scY0+8LpEel2urvKabgFfT8gCLGMCve7uYa5MCd+x2MBD02wPqlrWcGKbS1RXK6hyDMnguC7VgDaq3kthFrvsyIs7rXrpAhm6RhQbd0WzseafhHe0Oouiqg1ofgZvA89bxPtmvWvqwPFME/jMZCgsF6Khmc+KejpBR5WT7krYpuc0LE/U0DQw5M+cBP+zK/FDNARZ+ytr6HPgJvQHOEz75WYDWu5p4eCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF1N3UjY1BRbJrFbveWpKZxUwomgjqqHXOJ8bco7R/0=;
 b=h3an/Oak/x1kWKY7IGXu4KWQWEskFaYFeCcHReQDO0QRJACT+cLCKdslTBeCVjwtbqH4f4bqJjDZDr7Rn/GhEKmXBWXncyaYat+rCDXeKIOePZDUueoud68JeeTn31g3pZhJXUkhDweVTzugD2jUQXbXIZ/PK841ksHp9VFrOhpx8zcLoZOYkBrp37utbwHHMXZVZsIu0A5ooRIMQMosc90tckyWGpQQlpwOmF0TnLz0vRKXEwGnQvovD3h6qsQ387VvR1pZMP3CHtxPxp6bI+RC0rGB6lOPiBEkJWI3Tis4RQ6FvQH/HnCRe6toUuaec5dtSRaS5RHA86jpHdkEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1721.namprd12.prod.outlook.com (10.175.88.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 14:12:47 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:12:47 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/21] drm/amd/powerplay: add Powergate JPEG for Renoir
Date: Wed, 13 Nov 2019 09:12:34 -0500
Message-Id: <20191113141234.15444-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-14-leo.liu@amd.com>
References: <20191112180329.3927-14-leo.liu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a738dd5-9107-45fc-e16e-08d768438f46
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17215BAC4EAD64342FB491B5E5760@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(50466002)(48376002)(86362001)(305945005)(6116002)(7736002)(50226002)(3846002)(486006)(81156014)(81166006)(1076003)(6916009)(66476007)(8676002)(476003)(51416003)(66946007)(2361001)(52116002)(386003)(66556008)(6506007)(44832011)(5660300002)(2616005)(76176011)(2906002)(26005)(99286004)(6436002)(8936002)(66066001)(4326008)(446003)(478600001)(14454004)(36756003)(6486002)(47776003)(6666004)(16586007)(316002)(6512007)(25786009)(2351001)(11346002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1721;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j++HKppsxkE6dzIkjsocpmdCDFtnpLXoVDQODNayGaoKCXieYLUZPk/AQJYK/P3hih3esgFSlob2HdeAxEFI0cWeV0j5KUHflYmSSwqdmUSTir69vDLea3061Tu6L2P4rdWWXNoghSD7+TzjlXSEEqbBcOynXrPPywmYJwvVEX7zFZ87HlKCzzleBnd+EU7Nx4TJasTxKM/2+wCjTjx9R9APX9hwWzwIO/6YzuQovGfgDmWNPvv5fzAbup4ABjbnsBosH0IzR1O0iAPUqtBCZpEivKX+682gBF/8jF/yRt76vemW8cUsTXOsXOIk4n6nAx2fDqjPbW2ZzhQ2oLVkdS3y90c796xHFIi/Lf/cPRkUu73YCCgipme0BJxbOn5+lU4kAJw9sGpgvyhIKimMce1tyFE4fsilylj+BPeV5PeqM5sg8GKC0P2H0ElRG9iP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a738dd5-9107-45fc-e16e-08d768438f46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 14:12:47.3888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/J/C7YwVPi3y50f+XKFsMdFYQcNV4AwQDBbXU+AyJxTkXp3E3wFU61lKDxZmymP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fF1N3UjY1BRbJrFbveWpKZxUwomgjqqHXOJ8bco7R/0=;
 b=JvUvslCJj8Jd6VvtqQpt87zRhD3FurqTGivMPi8LiUK1/V3ekD8lA3CesqXNfT+WlaM2hNoeG/D0izcGOWc0yLL6ndqBvKTqEWoY0X7VseZHOzdgelz/XdUFkOaIpLbfynmKTXvRQOFzw2yOfBhVZspbqMMDZ9O6H5ADvI+VrFs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113141234.XZ83ROJymM3waIqLvWcA9Q0vcAI0BTjpqjhCKFkMzxM@z>

U2ltaWxhciB0byBTRE1BLCBWQ04gZXRjLgoKdjI6IGFkZCBhcmd1bWVudCB0byBib3RoIFBvd2Vy
VXBKcGVnIGFuZCBQb3dlckRvd25KcGVnIG1lc3NhZ2VzCgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1
IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jICAgIHwgIDIgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9z
bXVfdjEyXzAuaCB8ICAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJf
cHB0LmMgICAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfaW50ZXJu
YWwuaCAgfCAgMiArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMg
ICAgIHwgMTEgKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRleCA2OTI0M2E4
NThkZDUuLjIxMTkzNDUyMWQzNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYwpAQCAtMTIyOSw2ICsxMjI5LDcgQEAgc3RhdGljIGludCBzbXVfaHdfaW5pdCh2
b2lkICpoYW5kbGUpCiAJaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgewogCQlzbXVfcG93
ZXJnYXRlX3NkbWEoJmFkZXYtPnNtdSwgZmFsc2UpOwogCQlzbXVfcG93ZXJnYXRlX3ZjbigmYWRl
di0+c211LCBmYWxzZSk7CisJCXNtdV9wb3dlcmdhdGVfanBlZygmYWRldi0+c211LCBmYWxzZSk7
CiAJCXNtdV9zZXRfZ2Z4X2NncGcoJmFkZXYtPnNtdSwgdHJ1ZSk7CiAJfQogCkBAIC0xMjg3LDYg
KzEyODgsNyBAQCBzdGF0aWMgaW50IHNtdV9od19maW5pKHZvaWQgKmhhbmRsZSkKIAlpZiAoYWRl
di0+ZmxhZ3MgJiBBTURfSVNfQVBVKSB7CiAJCXNtdV9wb3dlcmdhdGVfc2RtYSgmYWRldi0+c211
LCB0cnVlKTsKIAkJc211X3Bvd2VyZ2F0ZV92Y24oJmFkZXYtPnNtdSwgdHJ1ZSk7CisJCXNtdV9w
b3dlcmdhdGVfanBlZygmYWRldi0+c211LCB0cnVlKTsKIAl9CiAKIAlyZXQgPSBzbXVfc3RvcF90
aGVybWFsX2NvbnRyb2woc211KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjEyXzAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2lu
Yy9zbXVfdjEyXzAuaAppbmRleCA5YjlmNWRmMDkxMWMuLjE3NDVlMDE0NmZiYSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV92MTJfMC5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjEyXzAuaApAQCAtNTgsNiArNTgs
OCBAQCBpbnQgc211X3YxMl8wX3Bvd2VyZ2F0ZV9zZG1hKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LCBib29sIGdhdGUpOwogCiBpbnQgc211X3YxMl8wX3Bvd2VyZ2F0ZV92Y24oc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsIGJvb2wgZ2F0ZSk7CiAKK2ludCBzbXVfdjEyXzBfcG93ZXJnYXRlX2pwZWco
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZ2F0ZSk7CisKIGludCBzbXVfdjEyXzBfc2V0
X2dmeF9jZ3BnKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGVuYWJsZSk7CiAKIHVpbnQz
Ml90IHNtdV92MTJfMF9nZXRfZ2Z4b2ZmX3N0YXR1cyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMKaW5kZXggMDRkYWY3
ZTlmZTA1Li40OTJhMjAxNTU0ZTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3Jlbm9pcl9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9y
ZW5vaXJfcHB0LmMKQEAgLTY5Nyw2ICs2OTcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFi
bGVfZnVuY3MgcmVub2lyX3BwdF9mdW5jcyA9IHsKIAkuY2hlY2tfZndfdmVyc2lvbiA9IHNtdV92
MTJfMF9jaGVja19md192ZXJzaW9uLAogCS5wb3dlcmdhdGVfc2RtYSA9IHNtdV92MTJfMF9wb3dl
cmdhdGVfc2RtYSwKIAkucG93ZXJnYXRlX3ZjbiA9IHNtdV92MTJfMF9wb3dlcmdhdGVfdmNuLAor
CS5wb3dlcmdhdGVfanBlZyA9IHNtdV92MTJfMF9wb3dlcmdhdGVfanBlZywKIAkuc2VuZF9zbWNf
bXNnID0gc211X3YxMl8wX3NlbmRfbXNnLAogCS5zZW5kX3NtY19tc2dfd2l0aF9wYXJhbSA9IHNt
dV92MTJfMF9zZW5kX21zZ193aXRoX3BhcmFtLAogCS5yZWFkX3NtY19hcmcgPSBzbXVfdjEyXzBf
cmVhZF9hcmcsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVf
aW50ZXJuYWwuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV9pbnRlcm5hbC5o
CmluZGV4IDhiY2RhNzg3MTMwOS4uNzBjNGQ2NjcyMWNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfaW50ZXJuYWwuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9zbXVfaW50ZXJuYWwuaApAQCAtNDIsNiArNDIsOCBAQAogCSgoc211KS0+
cHB0X2Z1bmNzLT5wb3dlcmdhdGVfc2RtYSA/IChzbXUpLT5wcHRfZnVuY3MtPnBvd2VyZ2F0ZV9z
ZG1hKChzbXUpLCAoZ2F0ZSkpIDogMCkKICNkZWZpbmUgc211X3Bvd2VyZ2F0ZV92Y24oc211LCBn
YXRlKSBcCiAJKChzbXUpLT5wcHRfZnVuY3MtPnBvd2VyZ2F0ZV92Y24gPyAoc211KS0+cHB0X2Z1
bmNzLT5wb3dlcmdhdGVfdmNuKChzbXUpLCAoZ2F0ZSkpIDogMCkKKyNkZWZpbmUgc211X3Bvd2Vy
Z2F0ZV9qcGVnKHNtdSwgZ2F0ZSkgXAorCSgoc211KS0+cHB0X2Z1bmNzLT5wb3dlcmdhdGVfanBl
ZyA/IChzbXUpLT5wcHRfZnVuY3MtPnBvd2VyZ2F0ZV9qcGVnKChzbXUpLCAoZ2F0ZSkpIDogMCkK
IAogI2RlZmluZSBzbXVfZ2V0X3ZiaW9zX2Jvb3R1cF92YWx1ZXMoc211KSBcCiAJKChzbXUpLT5w
cHRfZnVuY3MtPmdldF92Ymlvc19ib290dXBfdmFsdWVzID8gKHNtdSktPnBwdF9mdW5jcy0+Z2V0
X3ZiaW9zX2Jvb3R1cF92YWx1ZXMoKHNtdSkpIDogMCkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X3YxMl8wLmMKaW5kZXggMTM5ZGQ3MzdlYWE1Li4xOGIyNGY5NTQzODAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jCkBAIC0yMDMsNiArMjAzLDE3
IEBAIGludCBzbXVfdjEyXzBfcG93ZXJnYXRlX3ZjbihzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwg
Ym9vbCBnYXRlKQogCQlyZXR1cm4gc211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0dfUG93ZXJV
cFZjbik7CiB9CiAKK2ludCBzbXVfdjEyXzBfcG93ZXJnYXRlX2pwZWcoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUsIGJvb2wgZ2F0ZSkKK3sKKwlpZiAoIShzbXUtPmFkZXYtPmZsYWdzICYgQU1EX0lT
X0FQVSkpCisJCXJldHVybiAwOworCisJaWYgKGdhdGUpCisJCXJldHVybiBzbXVfc2VuZF9zbWNf
bXNnX3dpdGhfcGFyYW0oc211LCBTTVVfTVNHX1Bvd2VyRG93bkpwZWcsIDApOworCWVsc2UKKwkJ
cmV0dXJuIHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0dfUG93ZXJVcEpw
ZWcsIDApOworfQorCiBpbnQgc211X3YxMl8wX3NldF9nZnhfY2dwZyhzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwgYm9vbCBlbmFibGUpCiB7CiAJaWYgKCEoc211LT5hZGV2LT5wZ19mbGFncyAmIEFN
RF9QR19TVVBQT1JUX0dGWF9QRykpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
