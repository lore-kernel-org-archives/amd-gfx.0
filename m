Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4F7CA9ECE
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3BC2087E
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3BC2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A0D6EEBA;
	Thu, 31 Oct 2019 14:42:52 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730062.outbound.protection.outlook.com [40.107.73.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E1E6EEB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfi9ITja/kZ31rJZLYfE3nFffXL0BxsXozZHrwVpK3syKoJdz9PmzgjkkpqWtb0XeWm4mOcUg4RVD1hrPsO7TmUGFeXzaJtme20I0QF+qxkRQx6C/tBejlGkzfRWwGPJK/Wgao4xux7IVhErwxakwUlN6RcxSM99AA11FmLQv7W8lOYNH3w3fs0UXJz2hbvT01H05504/dkSV3WrpG5hfyKxumie/GqSDrfBYOUGVk+MTSVnsCsHZOM5Os8fu3/xRvLPNgfJOy3pQY8myn2biTSQV9+thH9U6u6YE4oCyxnEQo05m8h7fT72DM5fQP/mR7elPxLe9jvm19/Wonqh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTVjUMwmkzCokpmS1o1BQIhfzQfid8rycT5O2uTiBlU=;
 b=ZcCQU0Nwp9RHJ3OdhuvuDcBK8626tF0jgLPcFcrYcCsOMN5aPF8rPX4h5n009bcLMgz2UhnTX+fC8+Ai59RYsVJaB7JUj4Z6/2V1bFTz+2JUGyHkz5sGLF3SU0iRtftNOi7IRV0o0YJf1pwdUyVj5y1nfAhn8TiY0ADKnpZe85PxFpIICjXTLtvcnrgVj7jbNwvqaLLEs6RwbAfr4sv4PDLCZX3THe+8U8UP7V5iimfK8etAe/FZQaj1N8bHGerJbOu12DjGc9iCv3AAo8bPUw3QSvtUWwR21SfAsUkxq4rID2zfxPQj6ruVxXEdEgrnSh25y8utZEHrQKHD+nkAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:301:4a::20) by CH2PR12MB3992.namprd12.prod.outlook.com
 (2603:10b6:610:29::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Thu, 31 Oct
 2019 14:42:43 +0000
Received: from DM3NAM03FT046.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::207) by MWHPR1201CA0010.outlook.office365.com
 (2603:10b6:301:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:43 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT046.mail.protection.outlook.com (10.152.83.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:40 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:40 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/20] drm/amd/display: Unify all scaling when Integer Scaling
 enabled
Date: Thu, 31 Oct 2019 10:42:04 -0400
Message-ID: <20191031144210.24011-15-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(189003)(199004)(478600001)(53416004)(50466002)(2351001)(316002)(16586007)(2906002)(48376002)(50226002)(6666004)(70206006)(356004)(70586007)(4326008)(6916009)(26005)(47776003)(11346002)(186003)(81156014)(5660300002)(2616005)(8936002)(426003)(305945005)(126002)(14444005)(86362001)(476003)(336012)(446003)(51416003)(486006)(7696005)(1076003)(36756003)(81166006)(8676002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3992; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b7460d8-da05-4c83-747f-08d75e10964f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3992:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39923D10F1C66967522F72DDF9630@CH2PR12MB3992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DufgR5Wm8VJNQBUptmVTgOsz0d83dxdSELhYXWx2K1qAry0xPXoXyyXL3xyKFqMfpIeBZgmWI1zaB9UcVeyMET8Un1faDJXla0fZBYUVBkL2nu7oOPbHtupLdGZVglh/w2FQG0jiyaDkiDjbam1WZaYV+EqXEEg61LN4ahx1/qUOCCINwAE0E/8WdVFHYOjUqTzZN5DdeXFwp2lukEs64KQoo/YpRqjLVxogihQe1J5uCCxz9Vko/jEhAZ10K5d3UnTajxq1nlutoveaIWJLc/rpFKqVLvXY/J4/rV4gamBAvnXC1qMdXjh5D4q/7FOdVU/xO7p4bNXt3PicOwoM00Hx2Gm7ecWtiXE/cQXInE9vBSWB/HRvJiSb7p2ujyMfWGo9PGow1l1n+YoXVOzUi+9hdc+jyatSm9eqJN4h31Ca/Pkomc8nLialnQZcvkQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:42.9510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7460d8-da05-4c83-747f-08d75e10964f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTVjUMwmkzCokpmS1o1BQIhfzQfid8rycT5O2uTiBlU=;
 b=3suQ5ZKrh9Wsqp1WgcZw4T1vN0gFv3tVYG2h9YpqLO1DM/5/mx0ByKDPTXvoucd8fROrh6hhKsRnQh8kKhP1iMGshr/mfk68x6/AYnApRAh9XSurBPhCYIrZAHmyVBuCYGq4LffVth6cXPioRc5jtyKkSvf3KADrmgTNaX45f8E=
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
Cc: Reza Amini <Reza.Amini@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144204._aimomGvdBH4MLQwc0mHqqe5k64dtBzubC1xUbm9GwI@z>

RnJvbTogUmV6YSBBbWluaSA8UmV6YS5BbWluaUBhbWQuY29tPgoKW3doeV0KV2Ugd2FudCB0byBn
dWFyYW50ZWUgaW50ZWdlciByYXRpbyBzY2FsaW5nIGZvciBhbGwgc2NhbGluZyBtb2Rlcy4KClto
b3ddClRyZWF0IGNlbnRlcmVkLCBmdWxsc2NyZWVuLCBwcmVzZXJ2ZSBhc3BlY3QgcmF0aW8gdGhl
IHNhbWU6IHNjYWxlCnRoZSB2aWV3IGFzIG1hbnkgdGltZXMgYXMgcG9zc2libGUsIGFuZCBmaWxs
IGluIHRoZSByZXN0IHdpdGggYSBibGFjawpib3JkZXIuCgpTaWduZWQtb2ZmLWJ5OiBSZXphIEFt
aW5pIDxSZXphLkFtaW5pQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5DeXJA
YW1kLmNvbT4KQWNrZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVldC5MYWtoYUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgICAg
ICB8ICA4ICsrKysrLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3Vy
Y2UuYyB8IDIxICsrKystLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY19zdHJlYW0uaCAgICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjLmMKaW5kZXggYjMzNjZjY2MyOWMzLi42ZDY1MGEwZWNiYjkgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwpAQCAtMTU1MSw3ICsxNTUxLDEwIEBAIHN0YXRpYyBl
bnVtIHN1cmZhY2VfdXBkYXRlX3R5cGUgZ2V0X3NjYWxpbmdfaW5mb191cGRhdGVfdHlwZSgKIAlp
ZiAodS0+c2NhbGluZ19pbmZvLT5jbGlwX3JlY3Qud2lkdGggIT0gdS0+c3VyZmFjZS0+Y2xpcF9y
ZWN0LndpZHRoCiAJCQl8fCB1LT5zY2FsaW5nX2luZm8tPmNsaXBfcmVjdC5oZWlnaHQgIT0gdS0+
c3VyZmFjZS0+Y2xpcF9yZWN0LmhlaWdodAogCQkJfHwgdS0+c2NhbGluZ19pbmZvLT5kc3RfcmVj
dC53aWR0aCAhPSB1LT5zdXJmYWNlLT5kc3RfcmVjdC53aWR0aAotCQkJfHwgdS0+c2NhbGluZ19p
bmZvLT5kc3RfcmVjdC5oZWlnaHQgIT0gdS0+c3VyZmFjZS0+ZHN0X3JlY3QuaGVpZ2h0KSB7CisJ
CQl8fCB1LT5zY2FsaW5nX2luZm8tPmRzdF9yZWN0LmhlaWdodCAhPSB1LT5zdXJmYWNlLT5kc3Rf
cmVjdC5oZWlnaHQKKwkJCXx8IHUtPnNjYWxpbmdfaW5mby0+c2NhbGluZ19xdWFsaXR5LmludGVn
ZXJfc2NhbGluZyAhPQorCQkJCXUtPnN1cmZhY2UtPnNjYWxpbmdfcXVhbGl0eS5pbnRlZ2VyX3Nj
YWxpbmcKKwkJCSkgewogCQl1cGRhdGVfZmxhZ3MtPmJpdHMuc2NhbGluZ19jaGFuZ2UgPSAxOwog
CiAJCWlmICgodS0+c2NhbGluZ19pbmZvLT5kc3RfcmVjdC53aWR0aCA8IHUtPnN1cmZhY2UtPmRz
dF9yZWN0LndpZHRoCkBAIC0xNjcyLDcgKzE2NzUsOCBAQCBzdGF0aWMgZW51bSBzdXJmYWNlX3Vw
ZGF0ZV90eXBlIGNoZWNrX3VwZGF0ZV9zdXJmYWNlc19mb3Jfc3RyZWFtKAogCQl1bmlvbiBzdHJl
YW1fdXBkYXRlX2ZsYWdzICpzdV9mbGFncyA9ICZzdHJlYW1fdXBkYXRlLT5zdHJlYW0tPnVwZGF0
ZV9mbGFnczsKIAogCQlpZiAoKHN0cmVhbV91cGRhdGUtPnNyYy5oZWlnaHQgIT0gMCAmJiBzdHJl
YW1fdXBkYXRlLT5zcmMud2lkdGggIT0gMCkgfHwKLQkJCQkoc3RyZWFtX3VwZGF0ZS0+ZHN0Lmhl
aWdodCAhPSAwICYmIHN0cmVhbV91cGRhdGUtPmRzdC53aWR0aCAhPSAwKSkKKwkJCShzdHJlYW1f
dXBkYXRlLT5kc3QuaGVpZ2h0ICE9IDAgJiYgc3RyZWFtX3VwZGF0ZS0+ZHN0LndpZHRoICE9IDAp
IHx8CisJCQlzdHJlYW1fdXBkYXRlLT5pbnRlZ2VyX3NjYWxpbmdfdXBkYXRlKQogCQkJc3VfZmxh
Z3MtPmJpdHMuc2NhbGluZyA9IDE7CiAKIAkJaWYgKHN0cmVhbV91cGRhdGUtPm91dF90cmFuc2Zl
cl9mdW5jKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jl
c291cmNlLmMKaW5kZXggMzc2OTgzMDVhMmRjLi4zMGY1NDM0ZmE4ZTkgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYwpAQCAtOTUxLDI1
ICs5NTEsMTQgQEAgc3RhdGljIHZvaWQgY2FsY3VsYXRlX2luaXRzX2FuZF9hZGpfdnAoc3RydWN0
IHBpcGVfY3R4ICpwaXBlX2N0eCkKIAlkYXRhLT5pbml0cy52X2NfYm90ID0gZGNfZml4cHRfYWRk
KGRhdGEtPmluaXRzLnZfYywgZGF0YS0+cmF0aW9zLnZlcnRfYyk7CiAKIH0KLXN0YXRpYyBib29s
IGFyZV9yZWN0c19pbnRlZ2VyX211bHRpcGxlcyhzdHJ1Y3QgcmVjdCBzcmMsIHN0cnVjdCByZWN0
IGRlc3QpCi17Ci0JaWYgKGRlc3Qud2lkdGggID49IHNyYy53aWR0aCAgJiYgZGVzdC53aWR0aCAg
JSBzcmMud2lkdGggID09IDAgJiYKLQkJZGVzdC5oZWlnaHQgPj0gc3JjLmhlaWdodCAmJiBkZXN0
LmhlaWdodCAlIHNyYy5oZWlnaHQgPT0gMCkKLQkJcmV0dXJuIHRydWU7Ci0KLQlyZXR1cm4gZmFs
c2U7Ci19CiAKIHN0YXRpYyB2b2lkIGNhbGN1bGF0ZV9pbnRlZ2VyX3NjYWxpbmcoc3RydWN0IHBp
cGVfY3R4ICpwaXBlX2N0eCkKIHsKLQlpZiAoIXBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+c2NhbGlu
Z19xdWFsaXR5LmludGVnZXJfc2NhbGluZykKLQkJcmV0dXJuOworCXVuc2lnbmVkIGludCBpbnRl
Z2VyX211bHRpcGxlID0gMTsKIAotCS8vZm9yIENlbnRlcmVkIE1vZGUKLQlpZiAocGlwZV9jdHgt
PnN0cmVhbS0+ZHN0LndpZHRoICA9PSBwaXBlX2N0eC0+c3RyZWFtLT5zcmMud2lkdGggJiYKLQkJ
cGlwZV9jdHgtPnN0cmVhbS0+ZHN0LmhlaWdodCA9PSBwaXBlX2N0eC0+c3RyZWFtLT5zcmMuaGVp
Z2h0KSB7CisJaWYgKHBpcGVfY3R4LT5wbGFuZV9zdGF0ZS0+c2NhbGluZ19xdWFsaXR5LmludGVn
ZXJfc2NhbGluZykgewogCQkvLyBjYWxjdWxhdGUgbWF4aW11bSAjIG9mIHJlcGxpY2F0aW9uIG9m
IHNyYyBvbnRvIGFkZHJlc3NhYmxlCi0JCXVuc2lnbmVkIGludCBpbnRlZ2VyX211bHRpcGxlID0g
bWluKAorCQlpbnRlZ2VyX211bHRpcGxlID0gbWluKAogCQkJCXBpcGVfY3R4LT5zdHJlYW0tPnRp
bWluZy5oX2FkZHJlc3NhYmxlIC8gcGlwZV9jdHgtPnN0cmVhbS0+c3JjLndpZHRoLAogCQkJCXBp
cGVfY3R4LT5zdHJlYW0tPnRpbWluZy52X2FkZHJlc3NhYmxlICAvIHBpcGVfY3R4LT5zdHJlYW0t
PnNyYy5oZWlnaHQpOwogCkBAIC05ODAsMTAgKzk2OSw4IEBAIHN0YXRpYyB2b2lkIGNhbGN1bGF0
ZV9pbnRlZ2VyX3NjYWxpbmcoc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0eCkKIAkJLy9jZW50ZXIg
ZHN0IG9udG8gYWRkcmVzc2FibGUKIAkJcGlwZV9jdHgtPnN0cmVhbS0+ZHN0LnggPSAocGlwZV9j
dHgtPnN0cmVhbS0+dGltaW5nLmhfYWRkcmVzc2FibGUgLSBwaXBlX2N0eC0+c3RyZWFtLT5kc3Qu
d2lkdGgpLzI7CiAJCXBpcGVfY3R4LT5zdHJlYW0tPmRzdC55ID0gKHBpcGVfY3R4LT5zdHJlYW0t
PnRpbWluZy52X2FkZHJlc3NhYmxlIC0gcGlwZV9jdHgtPnN0cmVhbS0+ZHN0LmhlaWdodCkvMjsK
LQl9CiAKLQkvL2Rpc2FibGUgdGFwcyBpZiBzcmMgJiBkc3QgYXJlIGludGVnZXIgcmF0aW8KLQlp
ZiAoYXJlX3JlY3RzX2ludGVnZXJfbXVsdGlwbGVzKHBpcGVfY3R4LT5zdHJlYW0tPnNyYywgcGlw
ZV9jdHgtPnN0cmVhbS0+ZHN0KSkgeworCQkvL1dlIGFyZSBndWFyYW50ZWVkIHRoYXQgd2UgYXJl
IHNjYWxpbmcgaW4gaW50ZWdlciByYXRpbwogCQlwaXBlX2N0eC0+cGxhbmVfc3RhdGUtPnNjYWxp
bmdfcXVhbGl0eS52X3RhcHMgPSAxOwogCQlwaXBlX2N0eC0+cGxhbmVfc3RhdGUtPnNjYWxpbmdf
cXVhbGl0eS5oX3RhcHMgPSAxOwogCQlwaXBlX2N0eC0+cGxhbmVfc3RhdGUtPnNjYWxpbmdfcXVh
bGl0eS52X3RhcHNfYyA9IDE7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNfc3RyZWFtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfc3Ry
ZWFtLmgKaW5kZXggZjhjMDdkNWE0MDU0Li43MDI3NGZjNDNhNzIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19zdHJlYW0uaAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNfc3RyZWFtLmgKQEAgLTI1Miw2ICsyNTIsNyBAQCBzdHJ1Y3Qg
ZGNfc3RyZWFtX3VwZGF0ZSB7CiAJc3RydWN0IGRjX2luZm9fcGFja2V0ICp2c3BfaW5mb3BhY2tl
dDsKIAogCWJvb2wgKmRwbXNfb2ZmOworCWJvb2wgaW50ZWdlcl9zY2FsaW5nX3VwZGF0ZTsKIAog
CXN0cnVjdCBjb2xvcnNwYWNlX3RyYW5zZm9ybSAqZ2FtdXRfcmVtYXA7CiAJZW51bSBkY19jb2xv
cl9zcGFjZSAqb3V0cHV0X2NvbG9yX3NwYWNlOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
