Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD6C217F4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="owhXQ39c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD6C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FD06F892;
	Wed, 22 Jan 2020 19:27:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767C26F894
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 19:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnplWzV9hHrBCc61JkAS+dBcBBXRPqDZqOPEfGpKTl3b2cDTuEFc78CxNalBxkUYKGkRS/all2mxKDBcM3wVVRsJSKhUUGLa6sNMuPQ6enB83omqWgSqU3rZJnVfsu0n+T6q5a4JTqVG9IOiwGgysOlXvt81Rfsh5eL5kQBCpY5lEsMdlxM78AQaeVEXM0zKh/5rrLDJgYN1V2QhCB150LzpdAV/TZbmIJhLO3X+vXakzRF1YZty+fV10Lj6lqbzFaPGem8aeQlVdJPrjaMIGd8NvaTsfOoZSWPMtqZZ/1BbnL6BR+eh4jOycbYSpSwBP2WG1uXDyZCdXKgMNGJhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F4ds87A1ZREjj/NXyjp4r1Q/au3PplmqKEZtQ+6d2o=;
 b=h2SwVM9LBg85sr6lrDK2ADfsMtMvub85eb4z/Fl2ryvUCOJ3JfkDoZB795pgpuS0zGgbs1g0rQ6+3tGZFuMAOrPDZjzyqfsygEIyK308rtguX/baCLBBoBuXnk9yxG9zv0F8qBFHtAiI2QSmTkCWcWJskFsxHj/HpBn6Pag1hr71lFccyyBlx/8rR0T/vCoOICjPAz/p/0TI6mfM7noUODg+cejXep9+uLOFFdXBz7hdZYJax7/T4D+BaLilUP4V6/odyLMM2IuhxQIozjRr7AS4gL49vZPNGWjcT/Imgnr6qVJdARacHKPgtsczWElIt6FQjN+ONaem4rB3l8m0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F4ds87A1ZREjj/NXyjp4r1Q/au3PplmqKEZtQ+6d2o=;
 b=owhXQ39c7ABPk5I72Z+SwEJDnDdNhBhXn0PIL34Bo9QZcTpJ7rA6fEQM9b+/CBQSuhnJenA81G3COsc+JTLQ1zav6z5HjXa7iLU5AkVytndEQYKZXZHv6Ktmry03xvfFIq5Z6ZKjyHOggs3DalmIORCtOa3RGn2TvBdhEf/S58U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB2546.namprd12.prod.outlook.com (10.172.110.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 22 Jan 2020 19:27:55 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2%3]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 19:27:54 +0000
Subject: Re: [PATCH 0/5] HDCP SRM interface
To: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <55a3fd2d-c2ed-4af0-543e-9850118b722a@amd.com>
 <CADnq5_NO49aT6eSDywE20h6XZSF_D4WvCyQo30cXwRMvU1YmoA@mail.gmail.com>
 <7eca48bb-d1e8-a1c4-0812-665438a38ecb@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <67fb6764-7add-372c-95ae-8294c6e1c1e9@amd.com>
Date: Wed, 22 Jan 2020 14:27:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <7eca48bb-d1e8-a1c4-0812-665438a38ecb@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::35) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 19:27:54 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b013c8f-58cc-46b6-f96c-08d79f712dce
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2546:|BN6PR1201MB2546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2546C0D9DB645AFDB0CA4C5C8C0C0@BN6PR1201MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(8676002)(54906003)(4326008)(31686004)(2906002)(478600001)(5660300002)(81166006)(81156014)(8936002)(66476007)(31696002)(66556008)(53546011)(6486002)(66946007)(16526019)(186003)(52116002)(26005)(966005)(16576012)(36756003)(110136005)(2616005)(956004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB2546;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyUKNO3mK0HJzu87yXQ690KexhkcK6ZwnIStNM/Ythe2Q50Vn0n4N/FdhlxMJs5kOXBwUcfwPocUfQsrBm+al1InBSOwephJPnr1U4iKe83jjfektE4RzxhFElc+dYtS3Gw8hXpNT5KlBZdC0CB+lywsX7L4dp+SA9cjhTHIxB6ULWlu9NvEnQEqvIb7f9+a6D8iYRpyW3lY3u2dCDQklAuA17cidvyzvtz1348lDtECtyZhsLIvOp9p7DxBXpCXmo1Dic4CxtZypkOfJsrNFjnvlyLq1IiyKFnhbJh4Gjk/2THo3d9ncOR8hSUF/h2H+qbi4YqHV4v5Anm+N+LLY0/B7M25AZHAeH0QCfnqCKHmkLCNYmu/9fycBZNnlhku/DV2BLU8CNqsPSIh0arFIZ3v4jurOwJuYC3yRM3OYxUNoNk+ZiwljvPyMmEyf+BiCdP1Hgwpcb+qRmPesO63mfUiKZfnsmtgZAJ0cgbPL0w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b013c8f-58cc-46b6-f96c-08d79f712dce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 19:27:54.7783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il9J0yewGrLZifmS2BC6QSPe6wZNMy/WshgRPvQxIz1tOooOc6vZ+2Bm0v5oIKO0qMxlDG7XlR0GF6SBA8r+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2546
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIwLTAxLTIyIDExOjQ0IGEubS4sIEJoYXdhbnByZWV0IExha2hhIHdyb3RlOgo+IAo+
IE9uIDIwMjAtMDEtMjIgMTE6MjMgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+PiBPbiBXZWQs
IEphbiAyMiwgMjAyMCBhdCAxMToxMiBBTSBIYXJyeSBXZW50bGFuZCA8aHdlbnRsYW5AYW1kLmNv
bT4gd3JvdGU6Cj4+PiBPbiAyMDIwLTAxLTE2IDM6MjkgcC5tLiwgQmhhd2FucHJlZXQgTGFraGEg
d3JvdGU6Cj4+Pj4gVGhlc2UgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgZm9yIFNSTSBsb2FkaW5nLiBC
eSBwcm92aWRpbmcgYW4KPj4+PiBpbnRlcmZhY2UgdG8gdGhlCj4+Pj4gdXNlcm1vZGUKPj4+Pgo+
Pj4+IFNSTSBoYXMgdG8gYmUgcGVyc2lzdGVudCBhbmQgc2luY2UgdGhlIGtlcm5lbCBjYW5ub3Qg
ZGlyZWN0bHkgd3JpdGUKPj4+PiB0byBzeXN0ZW0KPj4+PiBzdG9yYWdlIHdlIG5lZWQgdG8gcHJv
dmlkZSBhbiBpbnRlcmZhY2Ugc28gdGhhdCB0aGUgdXNlcm1vZGUgY2FuIGRvCj4+Pj4gaXQgZm9y
IHVzCj4+Pj4KPj4+IFdlJ2xsIHdhbnQgdG8gZWxhYm9yYXRlIGEgYml0IG1vcmUgb24gd2h5IGFu
ZCBob3cgdGhpcyBpcyBkb25lLiBBcwo+Pj4gbWVudGlvbmVkIG9uIG15IHBhdGNoIDIgY29tbWVu
dHMgSSByZWNvbW1lbmQgdG8gZG8gdGhpcyB0aGVyZSBhcyB0aGUKPj4+IGNvdmVyIGxldHRlciBp
cyBsb3N0IGFmdGVyIG1lcmdlLgo+Pj4KPj4gWW91IG1pZ2h0IGFsc28gd2FudCB0byBjYyBkcmkt
ZGV2ZWwgaWYgeW91IHJlc2VuZCB0byBnZXQgbW9yZSByZXZpZXdzLgo+PiBJJ20gYWxzbyBub3Qg
Y3JhenkgYWJvdXQgaGF2aW5nIHRvIHVwZGF0ZSB0aGUgZmlsZSBpbiBjaHVua3MsIGJ1dCBJCj4+
IGRvbid0IGhhdmUgYW55IGJldHRlciBpZGVhcyBvZmYgaGFuZC7CoCBNYXliZSBhbiBpb2N0bCB3
b3VsZCBiZQo+PiBjbGVhbmVyPwo+Pgo+PiBBbGV4Cj4gCj4gVGhlIGtlcm5lbCBjYW4gb25seSBz
ZW5kIFBBR0VfU0laRSAoNEtCKSBhdCBvbmNlLCBzbyBpZiB0aGUgZmlsZSBpcwo+IGJpZ2dlciB0
aGFuIFBBR0VfU0laRSAobWF4IFNSTSBpcyA1S0IpIGl0IHdpbGwgc2VuZCBpdCBhZ2FpbiB1bnRp
bCBpdHMKPiBmaW5pc2hlZCAodW5sZXNzIHdlIGluY3JlYXNlIHRoZSBwYWdlIHNpemUpLgo+IAo+
IEZyb20gdGhlIHVzZXIgc3BhY2UgaXRzIGp1c3QgYSBzaW5nbGUgY29tbWFuZCB0byByZWFkL3dy
aXRlCj4gCj4gwqDCoMKgIHNhdmUgdG8gc3RvcmFnZSA6IGNhdCAvc3lzL2NsYXNzL2RybS9jYXJk
MC9kZXZpY2UvaGRjcF9zcm0gPiBmaWxlCj4gCj4gwqDCoMKgIGxvYWQgZnJvbSBzdG9yYWdlIDog
Y2F0IGZpbGU+IC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9oZGNwX3NybQo+IAoKUGxlYXNl
IGFsc28gYWRkIHRoaXMgaW5mbyBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gb3IgY292ZXIgbGV0
dGVyIGFzCndlbGwsIGluY2x1ZGluZyBob3cgeW91IGl0ZXJhdGUgZm9yIGEgbGFyZ2UgU1JNLiBB
IHNpbXBsZSBjb3B5LXBhc3RlCmZyb20gdGhlIHNoZWxsIHNjcmlwdCBzaG91bGQgc3VmZmljZS4g
SXQncyBhIGJpdCBoYXJkIHRvIHNlZSBob3cgdGhpcwppbnRlcmZhY2UgaXMgYmVpbmcgdXNlZCBm
cm9tIHVzZXJzcGFjZSwgZXNwZWNpYWxseSBhcm91bmQgdGhlIGdldC9zZXQgaW4KY2h1bmtzLgoK
SGFycnkKCj4gSSB3aWxsIHNlbmQgaXQgdG8gZHJpLWRldmVsIGFmdGVyIGZpeGluZyB3aGF0IEhh
cnJ5IHN1Z2dlc3RlZC4KPiAKPiBUaGFua3MKPiAKPiBCaGF3YW4KPiAKPj4+IEhhcnJ5Cj4+Pgo+
Pj4+IEJoYXdhbnByZWV0IExha2hhICg1KToKPj4+PiDCoMKgIGRybS9hbWQvZGlzcGxheTogUGFz
cyBhbWRncHVfZGV2aWNlIGluc3RlYWQgb2YgcHNwX2NvbnRleHQKPj4+PiDCoMKgIGRybS9hbWQv
ZGlzcGxheTogdXBkYXRlIHBzcCBpbnRlcmZhY2UgaGVhZGVyCj4+Pj4gwqDCoCBkcm0vYW1kL2Rp
c3BsYXk6IEFkZCBzeXNmcyBpbnRlcmZhY2UgZm9yIHNldC9nZXQgc3JtCj4+Pj4gwqDCoCBkcm0v
YW1kL2Rpc3BsYXk6IExvYWQgc3JtIGJlZm9yZSBlbmFibGluZyBIRENQCj4+Pj4gwqDCoCBkcm0v
YW1kL2Rpc3BsYXk6IGNhbGwgcHNwIHNldC9nZXQgaW50ZXJmYWNlcwo+Pj4+Cj4+Pj4gwqAgLi4u
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHzCoMKgIDIgKy0KPj4+
PiDCoCAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmPCoMKgwqAgfCAx
ODIKPj4+PiArKysrKysrKysrKysrKysrKy0KPj4+PiDCoCAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbV9oZGNwLmjCoMKgwqAgfMKgwqAgOSArLQo+Pj4+IMKgIC4uLi9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNwLmjCoMKgIHzCoCAyNiArKy0KPj4+PiDCoCA0
IGZpbGVzIGNoYW5nZWQsIDIxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Pj4+Cj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPj4+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
