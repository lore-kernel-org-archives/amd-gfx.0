Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51C6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 11:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45212070B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yo9FZr51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45212070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611706E0D5;
	Mon, 10 Aug 2020 11:22:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1DA6E0D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 11:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhgTScM076jku0sO0EzEX5L/dq0mZH5duJUfUzZxlFW3OB0/2yKSAUjUi7j5674CMatjY5+7M/ow3NuRmx4CJdAnKJj2NbpyLPdj9t/ImgJtQY0ZihtPyR5JqgcU952FH1M3mQCEVyjtwL79UYbwsoFMmigEnoox+DN3j1wssUcAQUh/XiCX8hsm1YbXnxMrUsPN9lk/UbgjD32Qr3j1IgQJ106wo5tmcveJiwRRI4QfeU+b3gFDTsH496gbZm71UC2asQmW8YPa/A3a3E3d3BHsZtln9FmlUlTUpW3QZb1TGbk/+aDh8TyA56KgC4UqmPPMpNO1m0o4eGsG+X0oEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH99FXvOEdguG1pl4o758GWR3unS+XFzLzM5m92rmPs=;
 b=KS+Kk3WWBeahVXc5FqvsMH+BOb62SfTazwW986UhR4+wf+QCdN7hePy2Lrjfam+vneEc2+/P1i513tB/Y6YMwz5qiOPQL+slKy/2sonWSgQsBapT3quwOhvsan/SEKQwSdh83zWQWDSPiNxfj86WJBJs4AeZQJlaalbj9t2XVPDE58qqtx0IVgel+Sr3/M2P2rpzMGSgj1GbQG0W5B1IDUFkl34YeBMvkw1uiuQVKG0l66OxYzprlPfkt215rBbxOndklaqUQP8gHvCrIeFeVeZ3+7dN5O/SQ3QanYcAKm22W52jpD2w4Jq8nLW2VVX76haiD0m7MfALdBV4T9t5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH99FXvOEdguG1pl4o758GWR3unS+XFzLzM5m92rmPs=;
 b=yo9FZr51DJPEtxSnGKUsOoE/j/vmL10wvGXfwKVn0ngiHp0V1g8cK28qS3OJbB7Rg9/RQL6Xz9oE9oPF7x52aNTcm8bTTvrOtDV5l2LnTmb7QBLUmu0UFeSXEutXTI4M0ruuw6msq9J1EI/WjhZ/CSb8O7OEMyNdyp0/3qYUTMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 11:22:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 11:22:21 +0000
Subject: Re: [PATCH] gpu/drm: Remove TTM_PL_FLAG_WC of VRAM to fix
 writecombine issue for Loongson64
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1596871502-3432-1-git-send-email-yangtiezhu@loongson.cn>
 <20200808134147.GA5772@alpha.franken.de>
 <b7b16df1-d661-d59a-005b-da594ce9fc95@flygoat.com>
 <38857c24-25c4-cff3-569e-5bcb773bfae6@amd.com>
 <2f3fd325-8093-98e7-5bc8-75490258baac@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e0dbe1d3-b4a1-7065-43bf-67fbd052e62b@amd.com>
Date: Mon, 10 Aug 2020 13:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <2f3fd325-8093-98e7-5bc8-75490258baac@daenzer.net>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:208:55::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.17 via Frontend Transport; Mon, 10 Aug 2020 11:22:20 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d1babdd-293e-4b36-2f7d-08d83d1fa657
X-MS-TrafficTypeDiagnostic: MN2PR12MB4304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4304225BD70A1AE05CEDFE0F83440@MN2PR12MB4304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NizPEAp2pAtMGBlAIQv+Khk9qdw9DTNW6cNAoMcKcEhuUatUC6cH0TZOqs3PRhvHlb+y7rljUMWM6IbDQ8VirFNb1SCJBwLg0aYHakKSlIqVDvST7Vbfc/5oS5hnM82UDdQvKWNu4jY98f41DP+oglonqXxcUgt6oIhvd5Yi4SJpgY92JKaMaHFKwVSTDyLm5D4nUBv+p8tdINYenWbHSXXZg044J+SR8zL5XFk4VoP+I7GCQzk9wfamjYi1pUvSxZyODxOk0lTNj/Tf777PujA7kXfeGHxdkJRvqimQW91l045i4TFFo8m4TQyrKYqPsCshZVqTCQK6mUHH+GoYCQkcnNlVi6+v94skUaYsi9EQxgKzLTZBg2WEt+34dsj5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(5660300002)(66946007)(478600001)(316002)(6666004)(66574015)(86362001)(83380400001)(31696002)(31686004)(2906002)(8676002)(2616005)(53546011)(66556008)(66476007)(52116002)(36756003)(186003)(16526019)(54906003)(6486002)(4326008)(8936002)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: si6yk3rWi9zl4LUTWph4v9m3glxdACyWmhX0nvLq+4ah0hbCB/wcJ9vI1XdMA6TpE6U+ilouJmnAh40PJdEQjVnGbkOOwVRQ9741jfP+sUnPZURqa8yrlc3GsgqAld/DPydxZrHpK8kB3WXlR/lTINAhZvy7KYiMhiBuB9E5P633Z5WudgDwq38dWFXiOAWPZDaNwYVw3MOrOxVnWJz8InNRmg+pZEo95gq6nk+zjxx3Hga17ednqV8c2tUoq72ozQsR6NdEPnYXE5FQIgTycqLpPuK23qJONAqjZDlQK6n+V35OZZ90GL+q+UC1DRmX4qAcKffdEnDHxOy+LXBCL2/bDDxJ1D9is9WSaZl5o0oXHbkuE0QuZcF4y6okuHhwY/7ICC+Fyt8Pm3tuT6Nw0HV0QulMv8XnuTZmT/1JPHYuuneT9dwigGyD19d4V3zjN3QIchHCJmk81Bx2nAvIKStZQC9RE4fQeqF60/oYU/TbDFXYlNFblkqK0ml0VgJYNlcJ/cpyf3CBp4YPzdwsf8EDODH1g4nI/+NZgOfzUwNl0+fQRwflnhFXQeYT8G0wA7A8kPZd0/6xpun9idzrYlIkzCs3TI255w06+3087iUTh1T15Q6fgonYUmBiZQjleo1tYgbhkWYlqTdWH/tHRFjcYd0qoZvvS6ZA52ic1XBDuytRXRdfWxFyw81+D4IwQjjuvCFxZUvI4yz7Ho84dQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1babdd-293e-4b36-2f7d-08d83d1fa657
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 11:22:21.9086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ohO9xYwdUa/sTFdZQ9qPknNzrPXvMxsk58uLjA7JxvQg3NExdVRfXV6/F5KGlJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDguMjAgdW0gMTI6NTAgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDIwLTA4
LTA5IDI6MTMgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDguMDguMjAgdW0g
MTU6NTAgc2NocmllYiBKaWF4dW4gWWFuZzoKPj4+IOWcqCAyMDIwLzgvOCDkuIvljYg5OjQxLCBU
aG9tYXMgQm9nZW5kb2VyZmVyIOWGmemBkzoKPj4+PiBPbiBTYXQsIEF1ZyAwOCwgMjAyMCBhdCAw
MzoyNTowMlBNICswODAwLCBUaWV6aHUgWWFuZyB3cm90ZToKPj4+Pj4gTG9vbmdzb24gcHJvY2Vz
c29ycyBoYXZlIGEgd3JpdGVjb21iaW5lIGlzc3VlIHRoYXQgbWF5YmUgZmFpbGVkIHRvCj4+Pj4+
IHdyaXRlIGJhY2sgZnJhbWVidWZmZXIgdXNlZCB3aXRoIEFUSSBSYWRlb24gb3IgQU1EIEdQVSBh
dCB0aW1lcywKPj4+Pj4gYWZ0ZXIgY29tbWl0IDhhMDhlNTBjZWU2NiAoImRybTogUGVybWl0IHZp
ZGVvLWJ1ZmZlcnMgd3JpdGVjb21iaW5lCj4+Pj4+IG1hcHBpbmcgZm9yIE1JUFMiKSwgdGhlcmUg
ZXhpc3RzIHNvbWUgZXJyb3JzIHN1Y2ggYXMgYmx1cnJlZCBzY3JlZW4KPj4+Pj4gYW5kIGxvY2t1
cCwgYW5kIHNvIG9uLgo+Pj4+Pgo+Pj4+PiBSZW1vdmUgdGhlIGZsYWcgVFRNX1BMX0ZMQUdfV0Mg
b2YgVlJBTSB0byBmaXggd3JpdGVjb21iaW5lIGlzc3VlIGZvcgo+Pj4+PiBMb29uZ3NvbjY0IHRv
IHdvcmsgd2VsbCB3aXRoIEFUSSBSYWRlb24gb3IgQU1EIEdQVSwgYW5kIGl0IGhhcyBubyBhbnkK
Pj4+Pj4gaW5mbHVlbmNlIG9uIHRoZSBvdGhlciBwbGF0Zm9ybXMuCj4+Pj4gd2VsbCBpdCdzIG5v
dCBteSBjYWxsIHRvIHRha2Ugb3IgcmVqZWN0IHRoaXMgcGF0Y2gsIGJ1dCBJIGFscmVhZHkKPj4+
PiBpbmRpY2F0ZWQgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGRpc2FibGUgd3JpdGVjb21iaW5lIG9u
IHRoZSBDUFUKPj4+PiBkZXRlY3Rpb24gc2lkZSAob3IgZG8geW91IGhhdmUgb3RoZXIgZGV2aWNl
cyB3aGVyZSB3cml0ZWNvbWJpbmluZwo+Pj4+IHdvcmtzID8pLiBTb21ldGhpbmcgbGlrZSBiZWxv
dyB3aWxsIGRpc2JhbGUgaXQgZm9yIGFsbCBsb29uZ3NvbjY0IENQVXMuCj4+Pj4gSWYgeW91IG5v
dyBmaW5kIG91dCB3aGVyZSBpdCB3b3JrcyBhbmQgd2hlcmUgaXQgZG9lc24ndCwgeW91IGNhbiBl
dmVuCj4+Pj4gcmVkdWNlIGl0IHRvIHRoZSByZXF1aXJlZCBtaW5pdW0gb2YgYWZmZWN0ZWQgQ1BV
cy4KPj4+IEhpIFRpZXpodSwgVGhvbWFzLAo+Pj4KPj4+IFllcywgd3JpdGVjb21iaW5lIHdvcmtz
IHdlbGwgb24gTFM3QSdzIGludGVybmFsIEdQVS4uLi4KPj4+IEFuZCBldmVuIHdvcmtzIHdlbGwg
d2l0aCBzb21lIEFNRCBHUFVzIChpbiBteSBjYXNlLCBSWDU1MCkuCj4+IEluIHRoaXMgY2FzZSB0
aGUgcGF0Y2ggaXMgYSBjbGVhciBOQUsgc2luY2UgeW91IGhhdmVuJ3Qgcm9vdCBjYXVzZWQgdGhl
Cj4+IGlzc3VlIGFuZCBhcmUganVzdCB3b3JraW5nIGFyb3VuZCBpdCBpbiBhIHZlcnkgcXVlc3Rp
b25hYmxlIG1hbm5lci4KPiBUbyBiZSBmYWlyIHRob3VnaCwgYW1kZ3B1ICYgcmFkZW9uIGFyZSBh
bHJlYWR5IGRpc2FibGluZyB3cml0ZS1jb21iaW5pbmcKPiBmb3Igc3lzdGVtIG1lbW9yeSBwYWdl
cyBpbiAzMi1iaXQgeDg2IGtlcm5lbHMgZm9yIHNpbWlsYXIgcmVhc29ucy4KClllYWgsIHdlbGwg
dGhhdCBpcyBVU1dDIGZvciBzeXN0ZW0gbWVtb3J5LiBCdXQgdGhpcyBpcyBhYm91dCBXQyBmb3Ig
dGhlIApWUkFNIEJBUi4KCldoZW4gd2UgZG9uJ3QgdW5kZXJzdGFuZCBvciBkb24ndCBjb3JyZWN0
bHkgaW1wbGVtZW50IHNvbWV0aGluZyBvbiB0aGUgCnBsYXRmb3JtIGZvciBVU1dDIHRoZW4gdGhp
cyBpcyBhbm5veWluZywgYnV0IG5vdCBhIHNlcmlvdXMgaXNzdWUuCgpCdXQgd2hlbiB0aGUgaGFy
ZHdhcmUgZG9lc24ndCBjb3JyZWN0bHkgaW1wbGVtZW50IFdDIGZvciBQQ0llIEJBUnMsIHRoZW4g
CnRoaXMgaXMgYSB2aW9sYXRpb24gb2YgdGhlIFBDSWUgc3BlYyBhbmQgYSBiaXQgbW9yZSBzZXJp
b3VzIGlzc3VlIGZvciAKdGhlIHdob2xlIHBsYXRmb3JtLgoKV2UgY2FuIHdvcmsgYXJvdW5kIHRo
YXQgYnkgZGlzYWJsaW5nIFdDIGZvciBQQ0llIEJBUnMgb24gdGhlIHdob2xlIApwbGF0Zm9ybSwg
b3IgYmVoaW5kIHNwZWNpZmljIGJyaWRnZXMgb3Igb3Igb3IsIGJ1dCBwYXRjaGluZyBlYWNoIApp
bmRpdmlkdWFsIGRyaXZlciBzbyB0aGF0IHRoZXkgd29yayBpcyBub3QgcmVhbGx5IHRoZSByaWdo
dCBhcHByb2FjaC4KCkNoZWVycywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
