Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BEC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 11:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D533F21775
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 11:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D533F21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E64B6E7D4;
	Thu, 28 Nov 2019 11:47:39 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740071.outbound.protection.outlook.com [40.107.74.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806C66E7D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 11:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/YbmozsprDINwH7TaYJMCPoVOP8Zd6XSI/2SmJbnM8j6eHvFsNfEjsbqx7sVX9CS0XORn8GS38ep1/f+lOYfByNUw25HNeAZQ6bQfIwg5zdoryCeBLjdy8rnqmQGzIABu9KdIrphM2kjpRmjAKFeyNBbZicEM0JMhd1clQli4rpRZD5pDsUtNBEMl7imxL5Bl5e98yHMI2j8DVWv0eBuLHUztPF0q0BVbdu5luJMhdXDfDnxM7bqVBXm1iuErdCrd1IAalbHXfxqmEX0F8gzERXRcV9bmIMduy9rlsmw10yeh6QbXxXeQDISb0Nc7t5KGA5/+yqDTB6MU2OhvkYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNItB+VscAze3NsvRM4FU8hm92V0Ot75bpY76+2Jr4w=;
 b=nu3Zpcke+R6khytCIhyJOseLebv+3s3rYbHrroK9liTCT8r06j4d0abYymXv3Kf/zc8EQImP9eyI6lCLcoK6IOTCD6ps/pMeqCOpM+pUy0jHe8O31lmnrqLbVZPqK4qB9wwcJDgxsSwmk82vuhyqzsXbZNDvQcSZr+30LCPaGQVX0PyLgeKJIU9+EXDmXNoSmuMqWghFroSLciDglRJz4+XqBjmKCbxeOHf4sjRzw+afKpBTVQ/3n781dnjdC3fIMTWY1YFXZIGpy91G1H1qQbrvI/7PCAtyeQqsH/Og+fts9CcXarzjTrIiQoovFxRKScaLRAar+4n2T2elq4g4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2424.namprd12.prod.outlook.com (52.132.142.162) by
 DM5PR12MB1290.namprd12.prod.outlook.com (10.168.237.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Thu, 28 Nov 2019 11:47:36 +0000
Received: from DM5PR12MB2424.namprd12.prod.outlook.com
 ([fe80::982d:8634:66c6:a09c]) by DM5PR12MB2424.namprd12.prod.outlook.com
 ([fe80::982d:8634:66c6:a09c%6]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 11:47:36 +0000
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amgdpu: add cache flush workaround to gfx8 emit_fence
Date: Thu, 28 Nov 2019 12:46:05 +0100
Message-Id: <20191128114605.5240-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.24.0.rc0
X-ClientProxiedBy: PR2P264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::14)
 To DM5PR12MB2424.namprd12.prod.outlook.com
 (2603:10b6:4:b7::34)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82f8b942-81b4-404c-e3cb-08d773f8c345
X-MS-TrafficTypeDiagnostic: DM5PR12MB1290:|DM5PR12MB1290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1290D51D4D98BF13F0AB55768D470@DM5PR12MB1290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(2616005)(66946007)(81156014)(8676002)(2870700001)(316002)(2906002)(2361001)(6916009)(6486002)(4326008)(50466002)(186003)(55236004)(47776003)(66066001)(52116002)(26005)(51416003)(6666004)(8936002)(66476007)(66556008)(25786009)(81166006)(6506007)(386003)(48376002)(5660300002)(305945005)(99286004)(6436002)(2351001)(7736002)(3846002)(6512007)(6116002)(478600001)(14454004)(1076003)(36756003)(86362001)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1290;
 H:DM5PR12MB2424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwFw6eVInIx3PMTBHtT5eoLtafh0mrdVHtGYuqlAS4sBHZxarkAu1U0YVDIbYz2yoz7nECRkz9wukIiwG+YUseskY5EOHyQR1c2pVuK0GNknS3DAIBq6NMJ0w2cZnutlQIerRIazdH0OMKdpijcJs7oXuKy8dkkUo2WuE55I/oJkq7A/BybqSV3aNtR9fdmvEr/vg1Tj0zKdeYgToCjSXCMl3jgvLPeXmw70kpMnmdztQiQqk8T+SPBG870stIONo+zxfJiIqFGrFAjDNUSjuktWSiVFhacnfJT/aXTtKdhWL/I7nAs/WfCf2vLji5rUuXgZ9TIaObpR8N9pPfqj7gbYR2abgcN0QK2MQorreYxLgBfPvUMQipw6QXrAY5uOn2Pckjdzc4vzlMHP3ydpixkKgFEdHIu5UuKDCQkI5wSumUAJAsnKMovcsCF4F9/n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f8b942-81b4-404c-e3cb-08d773f8c345
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 11:47:36.4953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boFYEBiyIaYh/a7KwYI55jkyKXFxdk7B7TwT2z5AFbfCwlgwrx/jslaG3lZISx46X1UVydd9bdH4BUBsjmmcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNItB+VscAze3NsvRM4FU8hm92V0Ot75bpY76+2Jr4w=;
 b=uRuA9VKZxmg5MYG+Z25i3C8fv1fVOKaYOG7JeswkEt+10GefWmUEm2UBLHv0gnwXnPtmigTrHx6BtXmCZzEmRzrcVuBnjpFu/MDR5IRFsuiPEObF8ECMrHZU/ghJKD/Nas9hS8MODQINtbmfQjWAVThuMC9ScsKQGC4MggCLxj4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128114605.DJJLvqpQMyu06nmskRYRfLFAcJ-JuqW18AXFgb7snBs@z>

VGhlIHNhbWUgd29ya2Fyb3VuZCBpcyB1c2VkIGZvciBnZng3LgpCb3RoIFBBTCBhbmQgTWVzYSB1
c2UgaXQgZm9yIGdmeDggdG9vLCBzbyBwb3J0IHRoaXMgY29tbWl0IHRvCmdmeF92OF8wX3Jpbmdf
ZW1pdF9mZW5jZV9nZnguCgpTaWduZWQtb2ZmLWJ5OiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXll
ciA8cGllcnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKaW5kZXggODBiNzk1ODNkZmZlLi5kY2Q3NDdiZWYzOTEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtNjE4Myw3ICs2MTgzLDIz
IEBAIHN0YXRpYyB2b2lkIGdmeF92OF8wX3JpbmdfZW1pdF9mZW5jZV9nZngoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nLCB1NjQgYWRkciwKIAlib29sIHdyaXRlNjRiaXQgPSBmbGFncyAmIEFNREdQ
VV9GRU5DRV9GTEFHXzY0QklUOwogCWJvb2wgaW50X3NlbCA9IGZsYWdzICYgQU1ER1BVX0ZFTkNF
X0ZMQUdfSU5UOwogCi0JLyogRVZFTlRfV1JJVEVfRU9QIC0gZmx1c2ggY2FjaGVzLCBzZW5kIGlu
dCAqLworCS8qIFdvcmthcm91bmQgZm9yIGNhY2hlIGZsdXNoIHByb2JsZW1zLiBGaXJzdCBzZW5k
IGEgZHVtbXkgRU9QCisJICogZXZlbnQgZG93biB0aGUgcGlwZSB3aXRoIHNlcSBvbmUgYmVsb3cu
CisJICovCisJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFDS0VUMyhQQUNLRVQzX0VWRU5UX1dS
SVRFX0VPUCwgNCkpOworCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIChFT1BfVENMMV9BQ1RJT05f
RU4gfAorCQkJCSBFT1BfVENfQUNUSU9OX0VOIHwKKwkJCQkgRU9QX1RDX1dCX0FDVElPTl9FTiB8
CisJCQkJIEVWRU5UX1RZUEUoQ0FDSEVfRkxVU0hfQU5EX0lOVl9UU19FVkVOVCkgfAorCQkJCSBF
VkVOVF9JTkRFWCg1KSkpOworCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIGFkZHIgJiAweGZmZmZm
ZmZjKTsKKwlhbWRncHVfcmluZ193cml0ZShyaW5nLCAodXBwZXJfMzJfYml0cyhhZGRyKSAmIDB4
ZmZmZikgfAorCQkJCURBVEFfU0VMKDEpIHwgSU5UX1NFTCgwKSk7CisJYW1kZ3B1X3Jpbmdfd3Jp
dGUocmluZywgbG93ZXJfMzJfYml0cyhzZXEgLSAxKSk7CisJYW1kZ3B1X3Jpbmdfd3JpdGUocmlu
ZywgdXBwZXJfMzJfYml0cyhzZXEgLSAxKSk7CisKKwkvKiBUaGVuIHNlbmQgdGhlIHJlYWwgRU9Q
IGV2ZW50IGRvd24gdGhlIHBpcGU6CisJICogRVZFTlRfV1JJVEVfRU9QIC0gZmx1c2ggY2FjaGVz
LCBzZW5kIGludCAqLwogCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFBBQ0tFVDMoUEFDS0VUM19F
VkVOVF9XUklURV9FT1AsIDQpKTsKIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCAoRU9QX1RDTDFf
QUNUSU9OX0VOIHwKIAkJCQkgRU9QX1RDX0FDVElPTl9FTiB8CkBAIC02OTI2LDcgKzY5NDIsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92OF8wX3JpbmdfZnVu
Y3NfZ2Z4ID0gewogCQk1ICsgIC8qIENPTkRfRVhFQyAqLwogCQk3ICsgIC8qIFBJUEVMSU5FX1NZ
TkMgKi8KIAkJVklfRkxVU0hfR1BVX1RMQl9OVU1fV1JFRyAqIDUgKyA5ICsgLyogVk1fRkxVU0gg
Ki8KLQkJOCArICAvKiBGRU5DRSBmb3IgVk1fRkxVU0ggKi8KKwkJMTIgKyAgLyogRkVOQ0UgZm9y
IFZNX0ZMVVNIICovCiAJCTIwICsgLyogR0RTIHN3aXRjaCAqLwogCQk0ICsgLyogZG91YmxlIFNX
SVRDSF9CVUZGRVIsCiAJCSAgICAgICB0aGUgZmlyc3QgQ09ORF9FWEVDIGp1bXAgdG8gdGhlIHBs
YWNlIGp1c3QKQEAgLTY5MzgsNyArNjk1NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1
X3JpbmdfZnVuY3MgZ2Z4X3Y4XzBfcmluZ19mdW5jc19nZnggPSB7CiAJCTMxICsgLyoJREVfTUVU
QSAqLwogCQkzICsgLyogQ05UWF9DVFJMICovCiAJCTUgKyAvKiBIRFBfSU5WTCAqLwotCQk4ICsg
OCArIC8qIEZFTkNFIHgyICovCisJCTEyICsgMTIgKyAvKiBGRU5DRSB4MiAqLwogCQkyLCAvKiBT
V0lUQ0hfQlVGRkVSICovCiAJLmVtaXRfaWJfc2l6ZSA9CTQsIC8qIGdmeF92OF8wX3JpbmdfZW1p
dF9pYl9nZnggKi8KIAkuZW1pdF9pYiA9IGdmeF92OF8wX3JpbmdfZW1pdF9pYl9nZngsCi0tIAoy
LjI0LjAucmMwCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
