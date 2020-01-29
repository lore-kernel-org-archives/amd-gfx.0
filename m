Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB9BC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4D7206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IsXAEtnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4D7206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443C36E42B;
	Wed, 29 Jan 2020 18:51:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38996E42B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 18:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaLEsyyqr7CgyRRep9crKWZFHwkpxAGWJBU2/GqyBOg8mWYYgnm6Jcuf1sedK9TehI1yQF4lYetstyQh3nhB61291TcZKOIZGIdd2xelmM+izCMYY0ohlbTLgNFpgKI5SM3r/kaCY498E8E7Uv/4hoz0ZOSsWJovPwtYmzolYTaqwGpx6W6cCEFSVaXGcfTlfPQ1DpkMm3yB3xcPf7nuYFAT4UKUKRWG09wOMzJqiJ/9F9Q2qhwAvQ5vcZWje412XnlpdmvkU+V/qtQnvB2SsfCiQv74SZ0U1gnDGRhqJADXtDr/3lzJUrQ8iJ1QFfzd8gTnNHZls1F15RE3mu2rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zwJV6obIs+rXM8euWVEJft8eOsGf76dxQeiUFX1IpU=;
 b=hxsnhW6yIQk/SHNyCnYGMpz/6sbrbama9ZwbQGG3u7L1cN7fuS+k0RcTlx2wxavlUJqCpUzyvLQQZRaVj2nMSABQiUJm9aGDDyW7bxpjt1f5QH3Q09oPhjAOvvx2hHzL+Bw4M4aWUKVLqofW10Tqxupp0eZbsnt4bBLpQDFsDFKlMgAc3AHatf7y4lE8eIofpq8KgSmnh1XE+aDzamqRUduBOkcxCiM4OOdrlVKazDILvKPJVP6rF0j6BeCRWUnGAxqE0n2RO6iCltvMPB4jnp+0t4mckAJwurKh5hHThQ0CNnqu0Xat63KSYRBqiMGUUGrHKkjXNwao128jaVU3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zwJV6obIs+rXM8euWVEJft8eOsGf76dxQeiUFX1IpU=;
 b=IsXAEtnH/qLeEPQI8hwp0NRLG+k05TAaczE8fiNFrlt+U+GRJoJZmlUnbk7Y933Na/w6INbAAd8UBK2UHBGqyHRhoNbztDW0YM+1IP8hZvBuJOS/JjY207ZFcjWDXZFVta627jshNqFJjSvg12O/MLDI5hIc5ArV9vYnq3irdgQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3504.namprd12.prod.outlook.com (20.178.244.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 18:51:34 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::dcae:63d1:58e3:4c4]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::dcae:63d1:58e3:4c4%6]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 18:51:34 +0000
Subject: Re: [PATCH] drm/amdgpu: correct vram mgr node size calculation
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200128195543.8286-1-Philip.Yang@amd.com>
 <fc39545c-7372-480d-2961-f8b899404a83@gmail.com>
From: Philip Yang <philip.yang@amd.com>
Message-ID: <14530f50-d8c6-f67b-309b-fdcb5ebfd0c2@amd.com>
Date: Wed, 29 Jan 2020 13:51:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <fc39545c-7372-480d-2961-f8b899404a83@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 18:51:33 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: feb7357e-31b7-4de0-6be4-08d7a4ec42ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB3504:|MN2PR12MB3504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3504915D49A4451137D442C9E6050@MN2PR12MB3504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(5660300002)(52116002)(26005)(66556008)(44832011)(66574012)(53546011)(16526019)(186003)(66476007)(6486002)(8936002)(16576012)(31696002)(36756003)(81166006)(81156014)(316002)(66946007)(2906002)(8676002)(2616005)(956004)(478600001)(31686004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3504;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fxum7qcYa2HeYfueRrfy+5V5iN2G3aTf77ZVkle2hy2VYmZoNIvhWo+zKQbKhYatx//oOubujeeIPKm3mWPGK5ERcJVCZo9DE5vWT4Qe7ejlsl9VACpUr2HAWawL1dODPr88nK4C6dH/lJSV5co+OIGTHafkg/PMhry3SeUs9gL0EzGQa+3+Squok391Zz5JSAaHJDgzGp6rsrwpXR7LSmQ3eaq7VneNb37q/d75J2NEnOaYXewrks5kRs+ruzoPnmFoSWz3M5wmGe4uMYVLrlwsv9e8olpP6kEEARCetFf+BqDFn/OHOhObmczkbh09lPXsN8zAVCUu9JFWDeXBpVxM9xKOL2/w51bQTfsVHn8hpZv3NwP4v5qs8t3b1PfDvF3UuW5g2f65BS3JZb/9NEyo2feEWSH1zyfMAzFash9ZzgB9KL7co2A5OaEGsc8y
X-MS-Exchange-AntiSpam-MessageData: GTA+viW/nhmO6Ysro3J3MsizZxlan50R1UVpf4Y/EO7++0+e2gB8N6vqs1ktbk7j6qnQFcAyV92UceHjlsFRXtwfz4ss9FQexJRpgH2i7ArKram4/PRCkNv6xBRZMecVARoitvgu5B0rmkAWS0KQnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7357e-31b7-4de0-6be4-08d7a4ec42ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 18:51:34.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vN0h7k23LY3LLPFtIjDZosxxDPJdKUHKYaMdho5BEmXkeV9xmoPYK0PJkTsFBNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3504
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIGFuZCB1bmRlcnN0YW5kLgoKUGhpbGlwCgpPbiAyMDIwLTAxLTI4IDI6NTkgcC5tLiwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyOC4wMS4yMCB1bSAyMDo1NSBzY2hyaWViIFBo
aWxpcCBZYW5nOgo+PiBVc2UgcGFnZXNfcGVyX25vZGUgaW5zdGVhZCBvZiBtZW0tPm51bV9wYWdl
cyB0byBhbGxvYyB2cmFtLCB0aGlzIHdpbGwKPj4gaW5jcmVhc2UgdGhlIGNoYW5jZSB0byBnZXQg
dnJhbSBub2RlIGFmdGVyIHZyYW0gZnJhZ21lbnRzLgo+IAo+IE5BSywgdGhpcyBpcyBpbnRlbnRp
b25hbCB0byBhaWQgVExCIHdpdGggY29udGludW91cyBhbGxvY2F0aW9ucy4KPiAKPiBUaGUgZmFs
bGJhY2sgdG8gdXNpbmcgcGFnZXNfcGVyX25vZGUgaXMgZGlyZWN0bHkgYmVsb3csIHNvIHlvdXIg
cGF0Y2ggCj4gc2hvdWxkIGJlIGNvbXBsZXRlbHkgc3VwZXJmbHVvdXMuCj4gCj4gUmVnYXJkcywK
PiBDaHJpc3RpYW4uCj4gCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAu
WWFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZyYW1fbWdyLmMgfCAxMSArKystLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPj4gaW5kZXggODJhMzI5OWU1M2MwLi42N2E0
NTRmNGMzN2EgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92cmFtX21nci5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
cmFtX21nci5jCj4+IEBAIC0zNjksNyArMzY5LDcgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9t
Z3JfbmV3KHN0cnVjdCAKPj4gdHRtX21lbV90eXBlX21hbmFnZXIgKm1hbiwKPj4gwqDCoMKgwqDC
oCBzcGluX2xvY2soJm1nci0+bG9jayk7Cj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgcGFnZXNf
bGVmdCA+PSBwYWdlc19wZXJfbm9kZTsgKytpKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBsb25nIHBhZ2VzID0gcm91bmRkb3duX3Bvd19vZl90d28ocGFnZXNfbGVmdCk7Cj4+ICvCoMKg
wqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBhZ2VzID0gcm91bmRkb3duX3Bvd19vZl90d28ocGFn
ZXNfcGVyX25vZGUpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGRybV9tbV9pbnNlcnRfbm9k
ZV9pbl9yYW5nZShtbSwgJm5vZGVzW2ldLCBwYWdlcywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZXNfcGVyX25vZGUsIDAsCj4+IEBAIC0z
ODMsMTUgKzM4MywxMSBAQCBzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IAo+
PiB0dG1fbWVtX3R5cGVfbWFuYWdlciAqbWFuLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZXNf
bGVmdCAtPSBwYWdlczsKPj4gwqDCoMKgwqDCoCB9Cj4+IC3CoMKgwqAgZm9yICg7IHBhZ2VzX2xl
ZnQ7ICsraSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBwYWdlcyA9IG1pbihw
YWdlc19sZWZ0LCBwYWdlc19wZXJfbm9kZSk7Cj4+ICvCoMKgwqAgaWYgKHBhZ2VzX2xlZnQpIHsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGFsaWdubWVudCA9IG1lbS0+cGFnZV9hbGln
bm1lbnQ7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocGFnZXMgPT0gcGFnZXNfcGVyX25vZGUpCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFsaWdubWVudCA9IHBhZ2VzX3Blcl9ub2RlOwo+PiAt
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByID0gZHJtX21tX2luc2VydF9ub2RlX2luX3JhbmdlKG1t
LCAmbm9kZXNbaV0sCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHBhZ2VzLCBhbGlnbm1lbnQsIDAsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhZ2VzX2xlZnQsIGFsaWdubWVudCwgMCwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGxhY2UtPmZwZm4s
IGxwZm4sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG1vZGUpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHIpKQo+PiBAQCAt
Mzk5LDcgKzM5NSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgCj4+
IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2aXNfdXNh
Z2UgKz0gYW1kZ3B1X3ZyYW1fbWdyX3Zpc19zaXplKGFkZXYsICZub2Rlc1tpXSk7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBhbWRncHVfdnJhbV9tZ3JfdmlydF9zdGFydChtZW0sICZub2Rlc1tpXSk7
Cj4+IC3CoMKgwqDCoMKgwqDCoCBwYWdlc19sZWZ0IC09IHBhZ2VzOwo+PiDCoMKgwqDCoMKgIH0K
Pj4gwqDCoMKgwqDCoCBzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKPiAKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
