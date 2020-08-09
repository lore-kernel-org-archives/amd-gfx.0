Return-Path: <SRS0=+Fjx=BT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B75C433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 12:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB09206D8
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 12:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZSd6umuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB09206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CC96E157;
	Sun,  9 Aug 2020 12:13:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2844E6E157
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2020 12:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRXFOOL9dQviBmuhHHmEzJGqIxYVjRbTYQhQT0dpg+Qy2ZDKDnm3odXtJnvEvnwsrAVJ07aDICGYYgvDjTlvV6+WVHJU20YxbLfbcnzQI5VVLKcAm5nezq4dE9QzIZP03TGlGI32HCN4CM+LGjPBdOWSOxrsMur5xxw10ohXpWLdK3De+IeVPOvhXvYuuUKCHmqYgf4PjEGspa6TU1Cr9uObSXcREEtUucG24Ef/b9B1N73RsWq9tcpdogPh8EgihcUVCv5t+gaT3pxIPBiL1isYlnpGd/k2muFE7ROJCPSBAcoIbWF+Hf4V+caaZ1ThPUE7AT87Lg1qf94266gpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqMl/ywsyFOJ1cIT3GhjhamVIVIYTPF9BSkLV7w3hZQ=;
 b=cxsHsYX8vEdtpQyTCx+fqpeVLMBU1ccdujYhiKx6z4BojOrJYbc54tm7uM8tNC7f/cIUlHUSqfF3XbXQ0fppapVheJ6VLrtMkmNnWMCXwt9N+qaq6FgREEgHInUurEljnPmRgt08TJtbhk3hawUqFUY7ChKQ2pYGbmDPXqGtBEe9Tr6rq3ynp4THibPDwG4QC0o2OFHRY+xTfueZBWSsCtobD5WGfhia3UppDXyZzV8d8TysqgAVurygi3S2caDixz+CM6LAZsottHUP65m/Wo3o+SWwTcpGwq3EGHT2BmBmRQD4jM8t7c6/xp/LHnPeDFQVuk/5pyQZmbkarE7jAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqMl/ywsyFOJ1cIT3GhjhamVIVIYTPF9BSkLV7w3hZQ=;
 b=ZSd6umuF6vKIE9BekmevIPrYMLxDxMDDmgR6kIiVghYJr4uC4EwJT8TlpeRXe6tH8WSXthOhKu4KWcpueMaSFjQ8vwfBtouGOuf04zNcYIM8AR8HkZX9WI96gxeCuVNAFczIugcWkmQO3cAIxVtk/VbGf5p1Myj7GZYHsInM6tU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sun, 9 Aug
 2020 12:13:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 12:13:23 +0000
Subject: Re: [PATCH] gpu/drm: Remove TTM_PL_FLAG_WC of VRAM to fix
 writecombine issue for Loongson64
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1596871502-3432-1-git-send-email-yangtiezhu@loongson.cn>
 <20200808134147.GA5772@alpha.franken.de>
 <b7b16df1-d661-d59a-005b-da594ce9fc95@flygoat.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <38857c24-25c4-cff3-569e-5bcb773bfae6@amd.com>
Date: Sun, 9 Aug 2020 14:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b7b16df1-d661-d59a-005b-da594ce9fc95@flygoat.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:208:ac::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Sun, 9 Aug 2020 12:13:21 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5c63698-e1d9-42ba-a989-08d83c5d9c88
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125AD19075424D0E5D970D083470@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uN8Y5xJg/KLD8QPvwgezJpZ0r4VCinFUcwfwimT/glg1ehEDVWmVdzI7rEiPHp6E0w6O3nSaHiLOi3furEHw4Q//bJXeNj+z0wUj/5KMTCuB5F/Btdmkp7vzs3kDwPEMhMuPDDjOT87NyE5sQOCGdjn1jq7yeHo54y0QBv+YabV7zUatCad4z0WH9cY31tpJICkw1t5ULPGOwhmtjulgMm9qnA4jUxPYnD/ZtxTRii52UJNSQYrHEkN+V05uT9JTfg2swssZn6gN2WyzVPxDt4Gxw3RPiyBJVawvVCry38TPLFpR4u4iSVrne/SR+Z0pRvTviwVlGQaW45dWI1TxkyZZEEvmiBZSMTeCZ1JB9xBQphlMSVet0/GjXZem8qwg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(5660300002)(83380400001)(478600001)(36756003)(52116002)(66476007)(66556008)(6666004)(6486002)(110136005)(54906003)(66946007)(8676002)(31696002)(2616005)(16526019)(86362001)(2906002)(31686004)(8936002)(316002)(186003)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2rj0ni+RFjrw9Vu3DRmSNHmtBsIxZKQMNJpdBqls7kK73gSEuu693TbiAJErpn0nT3Z9Wgzuw7K1I/tSaagnyaty3+42DIBrLs8WP5ZXES1Q++h6r7o2y+YeL4GLlx3IljMXOYgeAykbHYvkJeVX2sT7dv3qlX1X0fSGS+fiB+kwjfKPdLYYN7nDEXGqQLHkIxuHLgR6lM9W9yh9tK/CQ9nW0P59SwFqurLYWQ00sqjAOr4EUVQaXAEJtr5CS1AEGID46QILURR/xesSkCsmzp6nPI6YzKZBG0Uz2fpp778PP3uTksVnV5ZgrmVOM3p9v+W6FllzzC+OTbrs+toVHlu8Zq3dC/PPnXE4lAHYZFD/zTaRjAMwMpzlAyRkghUWxlW5Q7M/Vs2C0k/gkpP3Kq2MLPlgZWXxSQcM9P9jZ3gfBowZBL7md2eZq9/5Gm6iY8Wj2qPcKaLKfaizgepWeL1erjO+97kPCAmhhCHJbxyXQ9JU4Twa8gIIJlLwSouYmAUDx0vSD255Gp0g6QfzfrKnwKO/f5AP9aDHuGHDANps8kUiijfAZRwBmm1/khUR279E203fICA7jpNBW48Yuga1rDdTT/Zmyz38DDsL7BKezqBVcRVwkUabd6tEVD9FlI26poTUZDhNoqKX0/KkWz2vJDFR4QazwpP9dQ+ds+IzFHcC7CJXJLgLACb47qNrB5/ANAIqAxM291U1brdGbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c63698-e1d9-42ba-a989-08d83c5d9c88
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 12:13:23.7107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDgOsZI0O83TVmJ8yX7Cbzv04xALq9Z9fNvkiGf4J7qQpZ0EDjZnPoyvVZUtnrFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDguMjAgdW0gMTU6NTAgc2NocmllYiBKaWF4dW4gWWFuZzoKPgo+Cj4g1NogMjAyMC84
Lzggz8LO5zk6NDEsIFRob21hcyBCb2dlbmRvZXJmZXIg0LS1wDoKPj4gT24gU2F0LCBBdWcgMDgs
IDIwMjAgYXQgMDM6MjU6MDJQTSArMDgwMCwgVGllemh1IFlhbmcgd3JvdGU6Cj4+PiBMb29uZ3Nv
biBwcm9jZXNzb3JzIGhhdmUgYSB3cml0ZWNvbWJpbmUgaXNzdWUgdGhhdCBtYXliZSBmYWlsZWQg
dG8KPj4+IHdyaXRlIGJhY2sgZnJhbWVidWZmZXIgdXNlZCB3aXRoIEFUSSBSYWRlb24gb3IgQU1E
IEdQVSBhdCB0aW1lcywKPj4+IGFmdGVyIGNvbW1pdCA4YTA4ZTUwY2VlNjYgKCJkcm06IFBlcm1p
dCB2aWRlby1idWZmZXJzIHdyaXRlY29tYmluZQo+Pj4gbWFwcGluZyBmb3IgTUlQUyIpLCB0aGVy
ZSBleGlzdHMgc29tZSBlcnJvcnMgc3VjaCBhcyBibHVycmVkIHNjcmVlbgo+Pj4gYW5kIGxvY2t1
cCwgYW5kIHNvIG9uLgo+Pj4KPj4+IFJlbW92ZSB0aGUgZmxhZyBUVE1fUExfRkxBR19XQyBvZiBW
UkFNIHRvIGZpeCB3cml0ZWNvbWJpbmUgaXNzdWUgZm9yCj4+PiBMb29uZ3NvbjY0IHRvIHdvcmsg
d2VsbCB3aXRoIEFUSSBSYWRlb24gb3IgQU1EIEdQVSwgYW5kIGl0IGhhcyBubyBhbnkKPj4+IGlu
Zmx1ZW5jZSBvbiB0aGUgb3RoZXIgcGxhdGZvcm1zLgo+PiB3ZWxsIGl0J3Mgbm90IG15IGNhbGwg
dG8gdGFrZSBvciByZWplY3QgdGhpcyBwYXRjaCwgYnV0IEkgYWxyZWFkeQo+PiBpbmRpY2F0ZWQg
aXQgbWlnaHQgYmUgYmV0dGVyIHRvIGRpc2FibGUgd3JpdGVjb21iaW5lIG9uIHRoZSBDUFUKPj4g
ZGV0ZWN0aW9uIHNpZGUgKG9yIGRvIHlvdSBoYXZlIG90aGVyIGRldmljZXMgd2hlcmUgd3JpdGVj
b21iaW5pbmcKPj4gd29ya3MgPykuIFNvbWV0aGluZyBsaWtlIGJlbG93IHdpbGwgZGlzYmFsZSBp
dCBmb3IgYWxsIGxvb25nc29uNjQgQ1BVcy4KPj4gSWYgeW91IG5vdyBmaW5kIG91dCB3aGVyZSBp
dCB3b3JrcyBhbmQgd2hlcmUgaXQgZG9lc24ndCwgeW91IGNhbiBldmVuCj4+IHJlZHVjZSBpdCB0
byB0aGUgcmVxdWlyZWQgbWluaXVtIG9mIGFmZmVjdGVkIENQVXMuCj4gSGkgVGllemh1LCBUaG9t
YXMsCj4KPiBZZXMsIHdyaXRlY29tYmluZSB3b3JrcyB3ZWxsIG9uIExTN0EncyBpbnRlcm5hbCBH
UFUuLi4uCj4gQW5kIGV2ZW4gd29ya3Mgd2VsbCB3aXRoIHNvbWUgQU1EIEdQVXMgKGluIG15IGNh
c2UsIFJYNTUwKS4KCkluIHRoaXMgY2FzZSB0aGUgcGF0Y2ggaXMgYSBjbGVhciBOQUsgc2luY2Ug
eW91IGhhdmVuJ3Qgcm9vdCBjYXVzZWQgdGhlIAppc3N1ZSBhbmQgYXJlIGp1c3Qgd29ya2luZyBh
cm91bmQgaXQgaW4gYSB2ZXJ5IHF1ZXN0aW9uYWJsZSBtYW5uZXIuCgo+Cj4gVGllemh1LCBpcyBp
dCBwb3NzaWJsZSB0byBpbnZlc3RpZ2F0ZSB0aGUgaXNzdWUgZGVlcGVyIGluIExvb25nc29uPwo+
IFByb2JhYmx5IHdlIGp1c3QgbmVlZCB0byBhZGQgc29tZSBiYXJyaWVyIHRvIG1haW50YWluIHRo
ZSBkYXRhIGNvaGVyZW5jeSwKPiBvciBkaXNhYmxlIHdyaXRlY29tYmluZSBmb3IgQU1EIEdQVSdz
IGNvbW1hbmQgYnVmZmVyIGFuZCBsZWF2ZSAKPiB0ZXh0dXJlL2ZyYW1lCj4gYnVmZmVyIHdjIGFj
Y2VsZXJhdGVkLgoKSGF2ZSB5b3UgbW92ZWQgYW55IGJ1ZmZlciB0byBWUkFNIGFuZCBmb3Jnb3Qg
dG8gYWRkIGFuIEhEUCBmbHVzaC9pbnZhbGlkYXRlPwoKVGhlIGFjY2VsZXJhdGlvbiBpcyBub3Qg
bXVjaCBvZiBhIHByb2JsZW0sIGJ1dCBpZiBXQyBkb2Vzbid0IHdvcmsgaW4gCmdlbmVyYWwgeW91
IG5lZWQgdG8gZGlzYWJsZSBpdCBmb3IgdGhlIHdob2xlIENQVSBhbmQgbm90IGZvciBpbmRpdmlk
dWFsIApkcml2ZXJzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFRoYW5rcy4KPgo+IC0gSmlh
eHVuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
