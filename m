Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7BC2BA19
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 12:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4455A21D79
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 12:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tUoFdvbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4455A21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAAC6E340;
	Mon,  6 Apr 2020 12:31:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690046.outbound.protection.outlook.com [40.107.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D376E340
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 12:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF1UYhciusXKmeSjSki9XkeoYJHzbr1Tva4oPkIR0l+gvc7d2xG5SytLYz3y4sq6kM6yT+HHZaeKKEFPd6Rh4BXX9P0a0FIdF9hcbg+GY2QL4bxQafpsKyKNqG+DJBHPH/SMfac/wXPlGP6v/QeTA1vJpMJ0FZnoJ0ll3rDLYHCNGSJHPOtNhfbLRzVVDhCOvrxEIzAz0pAyoM/KnoqWug2qfxqF+7nEwM6JvsgWBpYzzF4BnpasgINvwQbWuXrzlw00XFdDxLf7ImM4odVmaEcIvEVGVCn+sT12ZHZ3nmHxt8hOnwRFGX0sdRb3oUbWj+uybhV6/od+ec0NPWqlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbvdvr0hNUKeRLq7TIKeDrSqPmIxC0CtKegxIxzulV0=;
 b=IsgG9Jqjx0mAyfKqmJZkyWFvQfb6G3N5vzc8ZBRcLLdTw7KaB0/OJrx9EHUt3OCMdZkGdibEb9dBYhAKc7sMF0tkD36yPnGaDGI3t2FJ3gH8m6KmfGNLc+sEUSQeZxXa7ZDVkHca1GLY5ixB101hti4dli5ipypztaW1FSGrJdnRjR6CXvMrcKwlCMnc2yvgUSYZCjBJbQQGe+suy8lXxtuPD9MTRNhC345fTWBpN8HGp2Rwk89ak4psGYyQdC4zolu2lXFF9gKQ6iWI89kk09FNMzw9aAbpkK9xUB612m6o63S6X7EsMM7LSOEWIztN7qnAlJXkVTCrMNxBsF87vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbvdvr0hNUKeRLq7TIKeDrSqPmIxC0CtKegxIxzulV0=;
 b=tUoFdvbrs2xpmt4ftuvHLRv7LL4F3Vtqcg3RnEn1fiu4UGfcI4HaZ9KakiKe7f4tGeakbHuXOgPvlWiRivlpI8zu5TEEsc6Sogvb0H8ta0NlhwUd9L5ZTgzmy4uQ9POoXHgCnx5eme7SAxUHiMa0UWT7Pou5/wOViTg+2l7tFd0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Mon, 6 Apr 2020 12:31:43 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 12:31:43 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: add shared menory restore after wake up
 from sleep.
To: christian.koenig@amd.com, Alex Deucher <alexdeucher@gmail.com>,
 James Zhu <James.Zhu@amd.com>
References: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_OwEiyjtfoy4ri+wMt9KTL7cZirrKJFhsQmYncPHSeH-g@mail.gmail.com>
 <62cc4dea-88aa-15cc-cc54-9f5fc5fdea38@amd.com>
 <fd093239-d748-a232-8f96-666753f99a82@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <faa6f7fd-b173-da00-4af2-c894932e795d@amd.com>
Date: Mon, 6 Apr 2020 08:31:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <fd093239-d748-a232-8f96-666753f99a82@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::23) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 12:31:43 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e205a83-8495-4ac0-e0c9-08d7da2676f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1674:|DM5PR12MB1674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB167438DD326487CBB27F0BE2E4C20@DM5PR12MB1674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(6636002)(2906002)(4326008)(66574012)(54906003)(110136005)(16576012)(36756003)(53546011)(31696002)(316002)(81156014)(478600001)(66946007)(52116002)(26005)(81166006)(8676002)(956004)(6486002)(36916002)(2616005)(8936002)(66476007)(5660300002)(186003)(966005)(45080400002)(16526019)(66556008)(31686004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUuNYEhGlrHsDwW/6zxtp/B9OXPbxvNINLOydnLKRi459riJ0NUXtkfdIY+i1XjFKuZI7zEybcWApAMyuRNJxbEHFTnkiTDKYCiAq6h5TEG6ZTnsTq7w5cgjaBIoPOBtXGYjuYecPjrAAVKKdV0mA13OtYWf4uzOWmR1KBVecrThpvD+HImQGZI+zxhiae7wTk5qTwaqDAuH3F1v2Q0RVIjNbfkRXLetN8YI/Rqv3ihXgVBIaolJusGcvCRhx1Mvr7fshON91pTXDLq9CkZF0h+XfBuT+afd2KqsABqPdb56lz8ZRTzdIkiYi3FAdknVc3l15FRBZ4dhKRV8EqEPJhutsTLFvZ72ThzP3hgs4ohq/VaSs+ykAdkDC5FRdaw9wvfyPQM9SVdPR03pZg0Cg9s8/KvLG+BV0egJhuaogUjQTq6sT2HqrWjwlDMcXLeOBvnFcT3kLO+AD3dghr3Wi0cEezgUwhj4V9e/5JS8BEw=
X-MS-Exchange-AntiSpam-MessageData: yeUuUOezq+JcGVHtcP5S15nPQh3RkU6bxOHZuJ1Rfc3+Rjj2tseZreS6WR2XyDhGsJLm+kNselBwKSYQ0YPUQsQEtoNEFZ3ZrkzBLRfpbxzATa0KHfND+zv6EcBXjpqO/epdyRddCbL2vPunXRfnqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e205a83-8495-4ac0-e0c9-08d7da2676f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 12:31:43.7703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r9lAytXRwgZsWlt8BAEb5kbZpdlsQxXxnHJzATvdJivGxBBGNCuVrK9DFtWy+d9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
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
Cc: "Li, Pauline" <Pauline.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDQtMDYgMzowMyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAz
LjA0LjIwIHVtIDE3OjU0IHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pgo+PiBPbiAyMDIwLTA0LTAzIDEx
OjM3IGEubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4+IE9uIEZyaSwgQXByIDMsIDIwMjAgYXQg
ODo1MiBBTSBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPiB3cm90ZToKPj4+PiBWQ04gc2hh
cmVkIG1lbW9yeSBuZWVkcyByZXN0b3JlIGFmdGVyIHdha2UgdXAgZHVyaW5nIFMzIHRlc3QuCj4+
PiBIb3cgYmlnIGlzIHRoZSBzaGFyZWQgbWVtb3J5P8KgIEl0IG1pZ2h0IGJlIGJldHRlciB0byBh
bGxvY2F0ZSB0aGUKPj4+IG1lbW9yeSBvbmNlIGF0IHN3X2luaXQgYW5kIHRoZW4gZnJlZSBpdCBp
biBzd19maW5pIHJhdGhlciB0aGFuCj4+PiBhbGxvY2F0aW5nIGFuZCBmcmVlaW5nIGluIGV2ZXJ5
IHN1c3BlbmQvcmVzdW1lLgo+Pgo+PiBIaSBBbGV4LAo+Pgo+PiBBZnRlciBhbGlnbm1lbnQsIGl0
IGlzIG9ubHkgNGsuIEkgY2FuIGNoYW5nZSBpdCBhcyB5b3Ugc3VnZ2VzdC4KPgo+IERvZXMgdGhp
cyBuZWVkcyB0byBzdGF5IGF0IHRoZSBzYW1lIHBsYWNlIGFmdGVyIGEgc3VzcGVuZC9yZXN1bWU/
Cj4KPiBTZWUgd2Ugb25seSBiYWNrdXAgdGhlIGZpcm13YXJlIG1hbnVhbGx5IGJlY2F1c2Ugd2Ug
b3RoZXJ3aXNlIGNhbid0IAo+IGd1YXJhbnRlZSB0aGF0IGl0IHdpbGwgYmUgbW92ZWQgYmFjayB0
byB0aGUgc2FtZSBwbGFjZSBhZnRlciByZXN1bWUuClllcywgdGhpcyBpcyB0aGUgY2FzZS4uIEZX
IHJlcXVlc3QgdGhlIHNhbWUgZm9yIHRoZWlyIHJlc3VtZSBwcm9jZXNzaW5nLgo+IElmIHRoYXQg
aXNuJ3QgYW4gaXNzdWUgZm9yIHRoZSBzaGFyZWQgYm8gd2UgY291bGQganVzdCB1bnBpbiBpdCBv
biAKPiBzdXNwZW5kIGFuZCBwaW4gaXQgYWdhaW4gb24gcmVzdW1lLgo+Cj4gQlRXOiBXaGF0IGlz
IHRoYXQgdXNlZCBmb3IgYW5kIHdoeSBjYW4ndCBpdCBiZSBwYXJ0IG9mIHRoZSBWQ04gCj4gZmly
bXdhcmUgQk8/CgpMb2dpY2FsbHkgaXQgaXMgdXNlZCBmb3IgRlcgYW5kIGRyaXZlciBzaGFyaW5n
IHNvbWUgc2V0dGluZ3MgCmNvbnZlbmllbnRseS4gSWYgeW91IHN1Z2dlc3QgaXQgY2FuIGJlIGFk
ZGVkIGludG8gVkNOIEJPLCB0aGVuIGl0IHdpbGwgCnNpbXBseSB0aGUgaW1wbGVtZW50YXRpb24u
CgpUaGFua3MgYW5kIEJlc3QgUmVnYXJkcyEKCkphbWVzIFpodQoKPgo+IFRoYW5rcywKPiBDaHJp
c3RpYW4uCj4KPj4KPj4gQmVzdCBSZWdhcmRzIQo+Pgo+PiBKYW1lcwo+Pgo+Pj4KPj4+IEFsZXgK
Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+
PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCAy
NiAKPj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCB8wqAgMSArCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jCj4+Pj4gaW5kZXggZDY1M2ExOC4uNTg5MTM5MCAxMDA2NDQKPj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+PiBAQCAtMjA1LDYgKzIw
NSw3IEBAIGludCBhbWRncHVfdmNuX3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnZjbi5oYXJ2
ZXN0X2NvbmZpZyAmICgxIDw8IGopKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+Pgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGt2ZnJlZShhZGV2LT52Y24uaW5zdFtqXS5zYXZlZF9zaG1fYm8pOwo+Pj4+
IGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+dmNuLmluc3Rbal0uZndfc2hhcmVkX2JvLAo+
Pj4+ICZhZGV2LT52Y24uaW5zdFtqXS5md19zaGFyZWRfZ3B1X2FkZHIsCj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICh2b2lkIAo+Pj4+ICoqKSZhZGV2LT52Y24uaW5zdFtqXS5md19z
aGFyZWRfY3B1X2FkZHIpOwo+Pj4+IEBAIC0yNTQsNiArMjU1LDE4IEBAIGludCBhbWRncHVfdmNu
X3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+Pj4gKmFkZXYpCj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+
Pj4+Cj4+Pj4gbWVtY3B5X2Zyb21pbyhhZGV2LT52Y24uaW5zdFtpXS5zYXZlZF9ibywgcHRyLCBz
aXplKTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYt
PnZjbi5pbnN0W2ldLmZ3X3NoYXJlZF9ibyA9PSBOVUxMKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiArCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IGFtZGdwdV9ib19zaXplKGFkZXYtPnZjbi5p
bnN0W2ldLmZ3X3NoYXJlZF9ibyk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cHRyID0gYWRldi0+dmNuLmluc3RbaV0uZndfc2hhcmVkX2NwdV9hZGRyOwo+Pj4+ICsKPj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT52Y24uaW5zdFtpXS5zYXZlZF9zaG1f
Ym8gPSBrdm1hbGxvYyhzaXplLCAKPj4+PiBHRlBfS0VSTkVMKTsKPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFkZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9ibykKPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
Tk9NRU07Cj4+Pj4gKwo+Pj4+ICsgbWVtY3B5X2Zyb21pbyhhZGV2LT52Y24uaW5zdFtpXS5zYXZl
ZF9zaG1fYm8sIHB0ciwgc2l6ZSk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiDCoCB9Cj4+Pj4gQEAgLTI5MSw2ICszMDQsMTkgQEAg
aW50IGFtZGdwdV92Y25fcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbXNldF9pbyhw
dHIsIDAsIHNpemUpOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+
PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnZjbi5pbnN0
W2ldLmZ3X3NoYXJlZF9ibyA9PSBOVUxMKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+PiArCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IGFtZGdwdV9ib19zaXplKGFkZXYtPnZjbi5pbnN0
W2ldLmZ3X3NoYXJlZF9ibyk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRy
ID0gYWRldi0+dmNuLmluc3RbaV0uZndfc2hhcmVkX2NwdV9hZGRyOwo+Pj4+ICsKPj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmluc3RbaV0uc2F2ZWRfc2ht
X2JvICE9IE5VTEwpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbWVtY3B5X3RvaW8ocHRyLCAKPj4+PiBhZGV2LT52Y24uaW5zdFtpXS5zYXZlZF9z
aG1fYm8sIHNpemUpOwo+Pj4+ICsga3ZmcmVlKGFkZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9i
byk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFk
ZXYtPnZjbi5pbnN0W2ldLnNhdmVkX3NobV9ibyA9IE5VTEw7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfSBlbHNlCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1lbXNldF9pbyhwdHIsIDAsIHNpemUpOwo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgfQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4gwqAgfQo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggCj4+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4+PiBpbmRleCBmNzM5
ZTFhLi5iZDc3ZGFlIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uaAo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uaAo+Pj4+IEBAIC0xOTQsNiArMTk0LDcgQEAgc3RydWN0IGFtZGdwdV92Y25faW5zdCB7
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkcGdfZW5jX3N1Ym1pc3Npb25fY250Owo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdm9pZMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpmd19zaGFyZWRfY3B1X2FkZHI7
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBmd19zaGFyZWRfZ3B1X2FkZHI7Cj4+Pj4gK8KgwqDCoMKgwqDCoCB2b2lkwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnNhdmVkX3NobV9ibzsKPj4+PiDCoCB9Owo+
Pj4+Cj4+Pj4gwqAgc3RydWN0IGFtZGdwdV92Y24gewo+Pj4+IC0tIAo+Pj4+IDIuNy40Cj4+Pj4K
Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8l
MkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NKYW1lcy5aaHUlNDBhbWQuY29tJTdDY2YwMGQ4
YmUyZTk5NGU3MTM4MTgwOGQ3ZDlmOGEwZDclN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3MjE3NTM0MTg0NjQzOTExJmFtcDtzZGF0YT1waklxdFdaS081NzY4
SG1CT2pIMWZoalpNUFNjdXlCVWclMkZwcnhIMlFXYzQlM0QmYW1wO3Jlc2VydmVkPTAgCj4+Pj4K
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0
cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdm
eCZhbXA7ZGF0YT0wMiU3QzAxJTdDSmFtZXMuWmh1JTQwYW1kLmNvbSU3Q2NmMDBkOGJlMmU5OTRl
NzEzODE4MDhkN2Q5ZjhhMGQ3JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzIxNzUzNDE4NDY0MzkxMSZhbXA7c2RhdGE9cGpJcXRXWktPNTc2OEhtQk9qSDFm
aGpaTVBTY3V5QlVnJTJGcHJ4SDJRV2M0JTNEJmFtcDtyZXNlcnZlZD0wIAo+Pgo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
