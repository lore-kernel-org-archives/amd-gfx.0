Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C90C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E339C20715
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E339C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00706E9CE;
	Wed, 20 Nov 2019 17:39:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680085.outbound.protection.outlook.com [40.107.68.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F066E89B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 17:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd2dMgXDtMI1Yxtr0xJFC0pld5630BCYoSM4T/c+2bLW0VTg3oufvJdUv5mELjJR0YPc+EIK+8kjA0z8m/mlhujRso6/11jFS8N02Gq9VIVA7YUKE9B/16oo+Lv3LrzDw+H7mYa41YpNWPoxHsNTL0EBDgvOMfuLbKH+qKkA06cxx83jg1zbraRA3V01IafnyR932zrSnzNtJqanKxG+g2HowA8ZEds+MEnFsZ3mrMoXkaS1AeL/rji+yyWRNBAWoveLeeoU5RwuYfwmQ4quu3f4X+GulKxrPuNeC9s1xlg9HNeUVtTkG3F2smZi7jW3fguAN7v9QU4qa+VysiAQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV9C1ZcOkCrd4nNRyJdopWH0lYPRfNQxRI57tfhCgLg=;
 b=jSwbJQvFq/Y4K8jT3GihnjS75IFpWOyPSh9F9lFslfvsFZnmmfh4EewEQ/0d6U2IWnYpPhoKKoztiWKqsqDrOEjSuYqyo10x9kyWa4NTbOt/8QmKyqz8qa28FM7z8agZl9ZK/kvg9deBsxtNPMB1L5xdfNOkve69F9bQE8SupMk7OYPSo4Wh0CABAvsAuvCZo8xoX3EZ5GjeK5pOUNMJWI3/kurBxcM4D+N8s7rWFzmBux6qiuNKUrlr1iVJBp9n1KljrDwjTrB7fWdVHwXezWWqo9EZQlOOhg/RznnNBv+naZQXuG4dzOR8T6DS1XMGagHhxaTw8oog/m9jkoBZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2548.namprd12.prod.outlook.com (10.172.120.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 17:39:50 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 17:39:50 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
From: Harry Wentland <hwentlan@amd.com>
To: Luben Tuikov <luben.tuikov@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
 <3e6f8c10-6cfe-73c7-c656-1b2ad69f5eb2@amd.com>
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
Message-ID: <afdc8874-9683-e3d7-427b-c2e3a833c2b7@amd.com>
Date: Wed, 20 Nov 2019 12:39:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <3e6f8c10-6cfe-73c7-c656-1b2ad69f5eb2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 873ebb4e-5eb1-444f-d07d-08d76de0a47e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2548:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2548634FB7ED350BA6D1E8258C4F0@CY4PR1201MB2548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(386003)(14454004)(76176011)(966005)(52116002)(6436002)(6512007)(23676004)(26005)(6306002)(2486003)(6506007)(53546011)(6486002)(31696002)(47776003)(65806001)(66066001)(476003)(486006)(478600001)(36756003)(81166006)(8676002)(81156014)(11346002)(6116002)(446003)(229853002)(6246003)(3846002)(5660300002)(2906002)(7736002)(14444005)(186003)(2616005)(65956001)(8936002)(4326008)(2870700001)(25786009)(305945005)(99286004)(316002)(31686004)(58126008)(110136005)(4001150100001)(54906003)(66556008)(66476007)(50466002)(66946007)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2548;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUbtV4StBmCNKWPQYx4lfz9J1RhFovGk14XnpxpQTxJP5b4qZe8UlZSo87JkqxC1i8W+3drGHU0i9nUIFpcnuzJjhhW+Mb+mX7p46XWlqapNqOJnOTt800CUHrlIq7QQ2RdBrmpfAzDDNgoH3AaLRHo7dDN1RQakKW5SzRW0DHyTqBqoyv/Ntl4PDF9RBUUgaHYGRuzItC7Ljyb47LS6ONGcd0RR1LeG/K7eKGmqF9lHrq+2GddAmBjzFVWjBfXJNNmSMOSOVbTxQ/LzfRNDML29bbyd02X05if05NjBxqMFcSdPW/IaWNulSTGzY3Cnw7eO0IilUmwosnfyXfDyw6Ba1u/AswbS7E5G1uIkF4K/wtSiy4BtoHdsd7iVl+RH96Y7+IUQN5wGOVrefvrPUtwfzn0WpdBQ5KwQyyqn36bOWYOnGLFjXM/Roomp8yzidWTpcaJK5hMbQL5iui0vVCP9nEZbSSHpYu51A7FNJMM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ebb4e-5eb1-444f-d07d-08d76de0a47e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 17:39:49.8649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apwGxekkGtgvQpKbGmBxC5pHpTV5YxMMXzSfNc+BABsZSw4/8tg3nk6hpE0yd0k/NBw7W2EgxdyVG0C6Mu0Ixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2548
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV9C1ZcOkCrd4nNRyJdopWH0lYPRfNQxRI57tfhCgLg=;
 b=qvo+CuRL/oEt39R1B/SrPkZwqof+SXqxKX0h/KyMSKzTOHhFJ5lmV+S9OtoNFTLCs4BpEuSdXlrVbTwOLKUjPvxHMDjDmlUJBWKryddpXZC+zXNQ1CH7dcN4FBYN9FXJdsWi7CNgdeAxaM7DFMu/Rpqqszs/6ziu+QP9OIqrkIo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120173947.fVyhvNM0S3-TuaoRhqQw1d-9w6hIV2IpkhuwLXoW6XM@z>

T24gMjAxOS0xMS0yMCAxMjowNSBwLm0uLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPiBPbiAyMDE5
LTExLTIwIDExOjQ5IGEubS4sIEx1YmVuIFR1aWtvdiB3cm90ZToKPj4gT24gMjAxOS0xMS0xOSAy
MTo0MSwgTWFyZWsgT2zFocOhayB3cm90ZToKPj4+IE9uIFR1ZSwgTm92IDE5LCAyMDE5IGF0IDg6
NTIgUE0gTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbSA8bWFpbHRvOmx1YmVuLnR1
aWtvdkBhbWQuY29tPj4gd3JvdGU6Cj4+Pgo+Pj4gICAgIE9uIDIwMTktMTEtMTQgMTA6MzQgcC5t
LiwgQWFyb24gTGl1IHdyb3RlOgo+Pj4gICAgID4gRnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdA
YW1kLmNvbSA8bWFpbHRvOnJheS5odWFuZ0BhbWQuY29tPj4KPj4+ICAgICA+Cj4+PiAgICAgPiBU
byBhbGlnbiB0aGUga2VybmVsIHVhcGkgY2hhbmdlIGZyb20gQWxleDoKPj4+ICAgICA+Cj4+PiAg
ICAgPiAiQWRkIGEgZmxhZyB0byB0aGUgR0VNX0NSRUFURSBpb2N0bCB0byBjcmVhdGUgZW5jcnlw
dGVkIGJ1ZmZlcnMuIEJ1ZmZlcnMgd2l0aAo+Pj4gICAgID4gdGhpcyBmbGFnIHNldCB3aWxsIGJl
IGNyZWF0ZWQgd2l0aCB0aGUgVE1aIGJpdCBzZXQgaW4gdGhlIFBURXMgb3IgZW5naW5lcwo+Pj4g
ICAgID4gYWNjZXNzaW5nIHRoZW0uIFRoaXMgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gcHJvcGVy
bHkgYWNjZXNzIHRoZSBkYXRhIGZyb20gdGhlCj4+PiAgICAgPiBlbmdpbmVzLiIKPj4+ICAgICA+
Cj4+PiAgICAgPiBXZSB3aWxsIHVzZSBHRU1fQ1JFQVRFX0VOQ1JZUFRFRCBmbGFnIGZvciBzZWN1
cmUgYnVmZmVyIGFsbG9jYXRpb24uCj4+PiAgICAgPgo+Pj4gICAgID4gU2lnbmVkLW9mZi1ieTog
SHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbSA8bWFpbHRvOnJheS5odWFuZ0BhbWQuY29tPj4K
Pj4+ICAgICA+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20gPG1haWx0bzphbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPj4KPj4+ICAgICA+IC0tLQo+
Pj4gICAgID7CoCBpbmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCA1ICsrKysrCj4+PiAgICAgPsKg
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPj4+ICAgICA+Cj4+PiAgICAgPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2Ry
bS5oCj4+PiAgICAgPiBpbmRleCA1YzI4YWE3Li4xYTk1ZTM3IDEwMDY0NAo+Pj4gICAgID4gLS0t
IGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4+PiAgICAgPiArKysgYi9pbmNsdWRlL2RybS9h
bWRncHVfZHJtLmgKPj4+ICAgICA+IEBAIC0xNDEsNiArMTQxLDExIEBAIGV4dGVybiAiQyIgewo+
Pj4gICAgID7CoCDCoCogcmVsZWFzaW5nIHRoZSBtZW1vcnkKPj4+ICAgICA+wqAgwqAqLwo+Pj4g
ICAgID7CoCAjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fV0lQRV9PTl9SRUxFQVNFwqAg
wqAgwqAgwqAoMSA8PCA5KQo+Pj4gICAgID4gKy8qIEZsYWcgdGhhdCBCTyB3aWxsIGJlIGVuY3J5
cHRlZCBhbmQgdGhhdCB0aGUgVE1aIGJpdCBzaG91bGQgYmUKPj4+ICAgICA+ICsgKiBzZXQgaW4g
dGhlIFBURXMgd2hlbiBtYXBwaW5nIHRoaXMgYnVmZmVyIHZpYSBHUFVWTSBvcgo+Pj4gICAgID4g
KyAqIGFjY2Vzc2luZyBpdCB3aXRoIHZhcmlvdXMgaHcgYmxvY2tzCj4+PiAgICAgPiArICovCj4+
PiAgICAgPiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUTCoCDCoCDCoCDCoCDC
oCAoMSA8PCAxMCkKPj4+Cj4+PiAgICAgU3R5bGUhCj4+PiAgICAgVEFCIGNoYXI/IQo+Pj4KPj4+
ICAgICBZb3UgaGF2ZSBhIFRBQiBjaGFyIGJldHdlZW4gIi4uX0VOQ1JZUFRFRCIgYW5kICIoMSA8
PCAxMCkiCj4+PiAgICAgRG8gTk9UIGFkZC9pbnNlcnQgVEFCIGNoYXJzIGluc3RlYWQgb2Ygc3Bh
Y2UgdG8gYWxpZ24gY29sdW5tbnMhCj4+PiAgICAgSWYgd2hlbiB5b3UgcHJlc3MgVGFiIGtleSBh
IHRhYiBpcyBpbnNlcnRlZCwgYXMgb3Bwb3NlZCB0byB0aGUgbGluZQo+Pj4gICAgIGluZGVudGVk
LCB0aGVuIERPIE5PVCB1c2UgdGhpcyBlZGl0b3IuCj4+PiAgICAgVGhlIFRhYiBrZXkgc2hvdWxk
ICJpbmRlbnQgYWNjb3JkaW5nIHRvIG1vZGUiIGJ5IGluc2VydGluZyBUQUIgY2hhcnMuCj4+PiAg
ICAgSWYgdGhlIGxpbmUgaXMgYWxyZWFkeSBpbmRlbnRlZCwgYXMgdGhpcyBvbmUgaXMsIHRoZW4g
aXQgc2hvdWxkIGRvIG5vdGhpbmcuCj4+Pgo+Pj4KPj4+IEkgZGlzYWdyZWUgd2l0aCB0aGlzIDEw
MCUuIFRhYnMgb3Igc3BhY2VzIGRvbid0IG1hdHRlciBoZXJlIGZyb20gbXkgcGVyc3BlY3RpdmUu
IEkgYWxzbyBkaXNhZ3JlZSB3aXRoIHlvdXIgbGFuZ3VhZ2UuIEl0J3Mgb3Zlcmx5IGltcG9saXRl
Lgo+Pgo+PiBCdXQgaXQncyB0aGUgY29kaW5nIHN0eWxlIG9mIExpbnV4OiBsZWFkaW5nIHRhYnMg
b25seS4gVHJ5IGl0IHdpdGggRW1hY3MgYXMgZGVzY3JpYmVkIGFuZCBnaXZlbiBpbgo+Pgo+PiBs
aW51eC9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdAo+Pgo+PiBzdGFydGlu
ZyBhdCBsaW5lIDU4OS4gQW5kIHByZXNzIHRoZSBUYWIga2V5IG9uIGFuIGFscmVhZHkgaW5kZW50
ZWQgbGluZS0tbm90aGluZyB3aWxsIGhhcHBlbi4gTGludXggaGFzIHRyYWRpdGlvbmFsbHkKPj4g
c2h1bm5lZCBmcm9tIGxvb3NlIFRBQiBjaGFycyBpbiBhbHJlYWR5IGluZGVudGVkIGxpbmVzOiBs
ZWFkaW5nIHRhYnMgb25seSBtb2RlLiBJbiBhIHByb3BlciBjb2RlIGVkaXRvcgo+PiBwcmVzc2lu
ZyB0aGUgVGFiIGtleSBvbmx5IGluZGVudHMgYWNjb3JkaW5nIHRvIGJ1ZmZlciBtb2RlLCBpdCBz
aG91bGRuJ3QgaW5zZXJ0IGEgVGFiIGNoYXIgd2lsbHktbmlsbHkuCj4+IFBlb3BsZSBtYXkgc2V0
IHRoZWlyIHRhYiBzdG9wcyBkaWZmZXJlbnRseSBmb3IgZGlmZmVyZW50IHRhYiBwb3NpdGlvbnMg
YW5kIGluc2VydGluZyBhIHRhYiBjaGFyIG1heSBkaXNwbGF5Cj4+IGluY29ycmVjdGx5LiBUaGUg
bW9zdCBwb3J0YWJsZSB3YXkgdG8gYWxpZ24gY29sdW1ucyBpbiBhbiBhbHJlYWR5IGluZGVudGVk
LWFjY29yZGluZy10by1tb2RlIGxpbmUsIGlzCj4+IHVzaW5nIHNwYWNlcy4gKE9mIGNvdXJzZSB0
aGlzIGRvZXNuJ3QgbWF0dGVyIHdoZW4gdXNpbmcgc3BhY2VzIHRvIGluZGVudCwgYnV0IExpbnV4
IHVzZXMgaGFyZCBUQUIgY2hhcnMKPj4gdG8gaW5kZW50OiBsaW51eC9Eb2N1bWVudGF0aW9uL3By
b2Nlc3MvY29kaW5nLXN0eWxlLnJzdC4gKHdoaWNoIGFsc28gc2VlbSB0byBiZSBzZXQgdG8gOCBj
aGFycykpCj4+Cj4+IEl0J3MgYSBjb2RlIHJldmlldywgdGhlcmUgaXMgbm8gImxhbmd1YWdlIi4K
PiAKPiBNYXkgSSByZW1pbmQgeW91IHRoYXQgZnJlZWRlc2t0b3Aub3JnIGhvc3RlZCBwcm9qZWN0
cyBmb2xsb3cgYSBjb2RlIG9mCj4gY29uZHVjdCBbMV0uIFRoaXMgYXBwbGllcyB3aGV0aGVyIHRo
ZSBpbnRlcmFjdGlvbiBpcyBhIGNvZGUgcmV2aWV3IG9yCj4gYW55IG90aGVyIGludGVyYWN0aW9u
Lgo+IAo+IEkgZG9uJ3QgdGhpbmsgeW91ciBsYW5ndWFnZSB3YXMgb3Zlcmx5IGltcG9saXRlIGJ1
dCBpdCBkaWQgY29tZSBhY3Jvc3MgYQo+IGJpdCBzdHJvbmcuIFBsZWFzZSBjb25zaWRlciBob3cg
eW91ciBzdGF0ZW1lbnRzIG1pZ2h0IGJlIHBlcmNlaXZlZCBieQoKSnVzdCB0byBjbGFyaWZ5LCBh
bmQgSSBkaWQgaW50ZW5kIHRvIGhpZ2hsaWdodCB0aGlzIGluIHRoZSBwcmV2aW91cwpzZW50ZW5j
ZSwgSSBkb24ndCB0aGluayB0aGVyZSBpcyBhbnkgdmlvbGF0aW9uIG9mIHRoZSBDb0MgaGVyZS4g
SSBhbQptZXJlbHkgdHJ5aW5nIHRvIHNheSB0aGF0IGxhbmd1YWdlIG1hdHRlcnMsIGV2ZW4gZm9y
IGNvZGUgcmV2aWV3cy4KCkhhcnJ5Cgo+IHRoZSBwZXJzb24gdGhleSdyZSBhZGRyZXNzZWQgdG8u
Cj4gCj4gWzFdIGh0dHBzOi8vd3d3LmZyZWVkZXNrdG9wLm9yZy93aWtpL0NvZGVPZkNvbmR1Y3Qv
Cj4gCj4gSGFycnkKPiAKPj4KPj4gUmVnYXJkcywKPj4gTHViZW4KPj4KPj4+Cj4+PiBNYXJlawo+
Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiAKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
