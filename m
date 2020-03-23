Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCAEC4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 11:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA1F2076A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 11:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RProN2RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA1F2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229EA8940E;
	Mon, 23 Mar 2020 11:49:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D2D8940E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 11:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q72SVz3x5YTn0tvPRYrf4BA6VfSGWqAxa3K4oT+ouJtlKSt4XVNz391SBThTzXyNcuhBQRbr+bAornBs74dJuOwgqQ3jy5vreS9RgLFIuIsVWYeUx2IyWnKJ2EaJzyoU6c/gNLA3ERUAe23/TcQlHzKE6ri9oi9q5UN6Nj6pdG8z07D2gvrdtR+pwYpSratAZzodQw86lNwpmlsha0TnXqzr7NIlMMIyVPeZ2MsNUKUeLhijE3IZgUqPcQ+RMIkwCH8HCxXf5PYd6MPg58+c78Ke69IlcAQhb8yrfKjmUT1ANSmHXb/lUtcR7PARMgT1BVP4TzrcuClQeaTj/LT4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XiWB/ZwJIXOYCmfNEGiDWIZvNzl3Q7wPcsnph/VygM=;
 b=O63LFmZZvY4RYZqrSPrrIabvF3x/ulBPt4mFZet81dY92R3K+3A5mZtJ403wXGWop61c8JctYizgKPmTe2OwA0enNl6MtVs8lzB9AavPAKFPdbiqv9wqB9f5V+nNPizWlZC/K7gqiSnGP01h824DQZaTjTmF1DpdL7/qt8mthVfQHYzYiOMw/mRF6zAl+6RXNHvXVRIO0WwETW7QDb7fMV2jX7ozf0AKlt+tVZz9ElcdPR8+LzpQEOzQ6MoDVg8k/B2znxo46ypYkce5RTDDcATrSUz0C9whKs3+nzY31jQ8wmAir1I9657ZseaJA872IF4SiGhUHpvNd0o4o2n9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XiWB/ZwJIXOYCmfNEGiDWIZvNzl3Q7wPcsnph/VygM=;
 b=RProN2RFep3mcYkvvIFKoFoUw486Co7nCTYNrJ0S1V2PF7nzxG2XxKZc92JO7oKQu7OdU00n+L3e1Ks7r/qqYLBm25HIxAI6VVNuvCtbfbipRch2QCLQDWezOJKiIjvrSFafdOZ5PpDkr1kAWSZXo68IpV8GmQAdmDKBUeNABb8=
Received: from DM5PR06CA0040.namprd06.prod.outlook.com (2603:10b6:3:5d::26) by
 MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 11:49:36 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::e7) by DM5PR06CA0040.outlook.office365.com
 (2603:10b6:3:5d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Mon, 23 Mar 2020 11:49:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 23 Mar 2020 11:49:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 06:49:35 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 06:49:34 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 23 Mar 2020 06:49:33 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: hold the reference of finished fence
Date: Mon, 23 Mar 2020 19:49:31 +0800
Message-ID: <20200323114931.32010-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(199004)(46966005)(81166006)(8676002)(81156014)(2906002)(8936002)(47076004)(70206006)(110136005)(54906003)(316002)(7696005)(6636002)(70586007)(36756003)(186003)(2616005)(356004)(426003)(5660300002)(1076003)(4326008)(26005)(336012)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0109; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6311d33f-3995-46e7-ce84-08d7cf2042bd
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01099E8E3ECEB8840F69E940E5F00@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0351D213B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DI1j7Xd1LonjD/9ioGKTqr6AGLm2oA1Pyj1H1PXqA5SbIMJqXHns8UQid+j5lZslTba13vATKM81CbZY9NNd9zuRxhEEMLQFTXZNQ5PhGsInrcSeGXHH0jVVHt9x6lia41EmKD1MSoonhPI2gcrWbwDA2NXbHsHne8wR+txgSFntBavVmKlDvlBLc5Rl3v9eXP1v1esQVW9MKQXQrEgZwodn0vhWcYcKc9YLnBtL3M7nCC8Q1r+UXFlSvKihM1F92kfe8RkzsLatMTglvV+R5hKfDvD4EubPCu0dKIgaR5qWudn0m3q+EYP513obQzwGcxy476v6S4UKi4af2yPNiBFuUj0muhojmeYNtvA1kyulNrCzzSpruGkOCiZ5dnqyUpiBRtQMi6DrqZOAvDZcg8+GrpcrHqAGKVj9bYe2U4eD//HnJdWjSINn13fvCAoBqFfsCmcaRgyueNVPlmDqEoDYXrboW1DX55KTNq8nr6I3tu1w4fAM8YXtq1kbdBuBTszjw3ZOhCKea3uFs32ViQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 11:49:36.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311d33f-3995-46e7-ce84-08d7cf2042bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlcmUgaXMgb25lIG9uZSBjb3JuZXIgY2FzZSBhdCBkbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZAp3
aGljaCB3aWxsIHJhaXNlIHRoZSBOVUxMIHBvaW50ZXIgcHJvYmxlbSBqdXN0IGxpa2UgYmVsb3cu
Ci0+ZG1hX2ZlbmNlX3NpZ25hbAogICAgLT5kbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZAoJLT50ZXN0
X2FuZF9zZXRfYml0CmhlcmUgdHJpZ2dlciBkbWFfZmVuY2VfcmVsZWFzZSBoYXBwZW4gZHVlIHRv
IHRoZSB6ZXJvIG9mIGZlbmNlIHJlZmNvdW50LgoKLT5kbWFfZmVuY2VfcHV0CiAgICAtPmRtYV9m
ZW5jZV9yZWxlYXNlCgktPmRybV9zY2hlZF9mZW5jZV9yZWxlYXNlX3NjaGVkdWxlZAoJICAgIC0+
Y2FsbF9yY3UKaGVyZSBtYWtlIHRoZSB1bmlvbiBmbGVkIOKAnGNiX2xpc3TigJ0gYXQgZmluaXNo
ZWQgZmVuY2UKdG8gTlVMTCBiZWNhdXNlIHN0cnVjdCByY3VfaGVhZCBjb250YWlucyB0d28gcG9p
bnRlcgp3aGljaCBpcyBzYW1lIGFzIHN0cnVjdCBsaXN0X2hlYWQgY2JfbGlzdAoKVGhlcmVmb3Jl
LCB0byBob2xkIHRoZSByZWZlcmVuY2Ugb2YgZmluaXNoZWQgZmVuY2UgYXQgYW1kZ3B1X2pvYl9y
dW4KdG8gcHJldmVudCB0aGUgbnVsbCBwb2ludGVyIGR1cmluZyBkbWFfZmVuY2Vfc2lnbmFsCgpb
ICA3MzIuOTEyODY3XSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJl
c3M6IDAwMDAwMDAwMDAwMDAwMDgKWyAgNzMyLjkxNDgxNV0gI1BGOiBzdXBlcnZpc29yIHdyaXRl
IGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpbICA3MzIuOTE1NzMxXSAjUEY6IGVycm9yX2NvZGUoMHgw
MDAyKSAtIG5vdC1wcmVzZW50IHBhZ2UKWyAgNzMyLjkxNjYyMV0gUEdEIDAgUDREIDAKWyAgNzMy
LjkxNzA3Ml0gT29wczogMDAwMiBbIzFdIFNNUCBQVEkKWyAgNzMyLjkxNzY4Ml0gQ1BVOiA3IFBJ
RDogMCBDb21tOiBzd2FwcGVyLzcgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgIDUuNC4wLXJj
NyAjMQpbICA3MzIuOTE4OTgwXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQw
RlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS44LjItMC1nMzNmYmUxMyBieSBxZW11LXByb2pl
Y3Qub3JnIDA0LzAxLzIwMTQKWyAgNzMyLjkyMDkwNl0gUklQOiAwMDEwOmRtYV9mZW5jZV9zaWdu
YWxfbG9ja2VkKzB4M2UvMHgxMDAKWyAgNzMyLjkzODU2OV0gQ2FsbCBUcmFjZToKWyAgNzMyLjkz
OTAwM10gIDxJUlE+ClsgIDczMi45MzkzNjRdICBkbWFfZmVuY2Vfc2lnbmFsKzB4MjkvMHg1MApb
ICA3MzIuOTQwMDM2XSAgZHJtX3NjaGVkX2ZlbmNlX2ZpbmlzaGVkKzB4MTIvMHgyMCBbZ3B1X3Nj
aGVkXQpbICA3MzIuOTQwOTk2XSAgZHJtX3NjaGVkX3Byb2Nlc3Nfam9iKzB4MzQvMHhhMCBbZ3B1
X3NjaGVkXQpbICA3MzIuOTQxOTEwXSAgZG1hX2ZlbmNlX3NpZ25hbF9sb2NrZWQrMHg4NS8weDEw
MApbICA3MzIuOTQyNjkyXSAgZG1hX2ZlbmNlX3NpZ25hbCsweDI5LzB4NTAKWyAgNzMyLjk0MzQ1
N10gIGFtZGdwdV9mZW5jZV9wcm9jZXNzKzB4OTkvMHgxMjAgW2FtZGdwdV0KWyAgNzMyLjk0NDM5
M10gIHNkbWFfdjRfMF9wcm9jZXNzX3RyYXBfaXJxKzB4ODEvMHhhMCBbYW1kZ3B1XQoKU2lnbmVk
LW9mZi1ieTogWWludGlhbiBUYW8gPHl0dGFvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCAxOSArKysrKysrKysrKysrKysrKystCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgICB8ICAyICsrCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oICB8ICAzICsrKwogMyBmaWxlcyBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZmVuY2UuYwppbmRleCA3NTMxNTI3MDY3ZGYuLjAzNTczZWZmNjYwYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKQEAgLTUyLDcgKzUyLDcg
QEAKIAogc3RydWN0IGFtZGdwdV9mZW5jZSB7CiAJc3RydWN0IGRtYV9mZW5jZSBiYXNlOwotCisJ
c3RydWN0IGRtYV9mZW5jZSAqZmluaXNoZWQ7CiAJLyogUkIsIERNQSwgZXRjLiAqLwogCXN0cnVj
dCBhbWRncHVfcmluZwkJKnJpbmc7CiB9OwpAQCAtMTQ5LDYgKzE0OSw3IEBAIGludCBhbWRncHVf
ZmVuY2VfZW1pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHN0cnVjdCBkbWFfZmVuY2UgKipm
LAogCiAJc2VxID0gKytyaW5nLT5mZW5jZV9kcnYuc3luY19zZXE7CiAJZmVuY2UtPnJpbmcgPSBy
aW5nOworCWZlbmNlLT5maW5pc2hlZCA9IE5VTEw7CiAJZG1hX2ZlbmNlX2luaXQoJmZlbmNlLT5i
YXNlLCAmYW1kZ3B1X2ZlbmNlX29wcywKIAkJICAgICAgICZyaW5nLT5mZW5jZV9kcnYubG9jaywK
IAkJICAgICAgIGFkZXYtPmZlbmNlX2NvbnRleHQgKyByaW5nLT5pZHgsCkBAIC0xODIsNiArMTgz
LDIxIEBAIGludCBhbWRncHVfZmVuY2VfZW1pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHN0
cnVjdCBkbWFfZmVuY2UgKipmLAogCXJldHVybiAwOwogfQogCit2b2lkIGFtZGdwdV9mZW5jZV9n
ZXRfZmluaXNoZWQoc3RydWN0IGRtYV9mZW5jZSAqYmFzZSwKKwkJCSAgICAgICBzdHJ1Y3QgZG1h
X2ZlbmNlICpmaW5pc2hlZCkKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2ZlbmNlICphZmVuY2UgPSB0b19h
bWRncHVfZmVuY2UoYmFzZSk7CisKKwlhZmVuY2UtPmZpbmlzaGVkID0gZG1hX2ZlbmNlX2dldChm
aW5pc2hlZCk7Cit9CisKK3ZvaWQgYW1kZ3B1X2ZlbmNlX3B1dF9maW5pc2hlZChzdHJ1Y3QgZG1h
X2ZlbmNlICpiYXNlKQoreworCXN0cnVjdCBhbWRncHVfZmVuY2UgKmFmZW5jZSA9IHRvX2FtZGdw
dV9mZW5jZShiYXNlKTsKKworCWRtYV9mZW5jZV9wdXQoYWZlbmNlLT5maW5pc2hlZCk7Cit9CisK
IC8qKgogICogYW1kZ3B1X2ZlbmNlX2VtaXRfcG9sbGluZyAtIGVtaXQgYSBmZW5jZSBvbiB0aGUg
cmVxdWVzdGUgcmluZwogICoKQEAgLTI3Niw2ICsyOTIsNyBAQCBib29sIGFtZGdwdV9mZW5jZV9w
cm9jZXNzKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIAkJCUJVRygpOwogCiAJCWRtYV9mZW5j
ZV9wdXQoZmVuY2UpOworCQlhbWRncHVfZmVuY2VfcHV0X2ZpbmlzaGVkKGZlbmNlKTsKIAkJcG1f
cnVudGltZV9tYXJrX2xhc3RfYnVzeShhZGV2LT5kZGV2LT5kZXYpOwogCQlwbV9ydW50aW1lX3B1
dF9hdXRvc3VzcGVuZChhZGV2LT5kZGV2LT5kZXYpOwogCX0gd2hpbGUgKGxhc3Rfc2VxICE9IHNl
cSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKaW5kZXggNDk4MWU0NDNh
ODg0Li5kZWIyYWVlYWRmYjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qb2IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9i
LmMKQEAgLTIyOSw2ICsyMjksOCBAQCBzdGF0aWMgc3RydWN0IGRtYV9mZW5jZSAqYW1kZ3B1X2pv
Yl9ydW4oc3RydWN0IGRybV9zY2hlZF9qb2IgKnNjaGVkX2pvYikKIAkJCQkgICAgICAgJmZlbmNl
KTsKIAkJaWYgKHIpCiAJCQlEUk1fRVJST1IoIkVycm9yIHNjaGVkdWxpbmcgSUJzICglZClcbiIs
IHIpOworCQllbHNlCisJCQlhbWRncHVfZmVuY2VfZ2V0X2ZpbmlzaGVkKGZlbmNlLCBmaW5pc2hl
ZCk7CiAJfQogCS8qIGlmIGdwdSByZXNldCwgaHcgZmVuY2Ugd2lsbCBiZSByZXBsYWNlZCBoZXJl
ICovCiAJZG1hX2ZlbmNlX3B1dChqb2ItPmZlbmNlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmluZy5oCmluZGV4IDQ0OGM3NmNiZjNlZC4uZmQ0ZGE5MTg1OWFhIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKQEAgLTk2LDYgKzk2LDkgQEAgdm9p
ZCBhbWRncHVfZmVuY2VfZHJpdmVyX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Owogdm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldik7CiBpbnQgYW1kZ3B1X2ZlbmNlX2VtaXQoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBz
dHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UsCiAJCSAgICAgIHVuc2lnbmVkIGZsYWdzKTsKK3ZvaWQg
YW1kZ3B1X2ZlbmNlX2dldF9maW5pc2hlZChzdHJ1Y3QgZG1hX2ZlbmNlICpiYXNlLAorCQkJICAg
ICAgIHN0cnVjdCBkbWFfZmVuY2UgKmZpbmlzaGVkKTsKK3ZvaWQgYW1kZ3B1X2ZlbmNlX3B1dF9m
aW5pc2hlZChzdHJ1Y3QgZG1hX2ZlbmNlICpiYXNlKTsKIGludCBhbWRncHVfZmVuY2VfZW1pdF9w
b2xsaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgKnMpOwogYm9vbCBhbWRn
cHVfZmVuY2VfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOwogaW50IGFtZGdwdV9m
ZW5jZV93YWl0X2VtcHR5KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7Ci0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
