Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6A7C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860AD2168B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J7+E9tBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860AD2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F4C6F959;
	Fri, 14 Feb 2020 14:55:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB46D6F959
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaFZ0ZfEYjwWCCxH+Xx0/OP4nvJ2v7OmOVUyiQu0uyZzNSxyeGCSROCg87gJi2XYJhBStJ100AbkhRyKd8S5EPqngDlF1LnFXxGA2mRlJQQOyuzMGVt4fuHGL+MjZBxo2oi2u3488WOOmN1aTPj4+r+9iYdNtIO7vN/W0DE3gCoCUe8eV71+hQQkCBS6kXDtvBAu6DTuaBDE9/Gu5Oa1C7LRyDn83dD4yDz8VqC3Jnoxvd11RzXJzi8V47yaL4UiBBRFP7/u2fQ29ZmZHsMA7rwRAroxInXOrax62rBPhkf7YwTO/+N5tF864kdKhe7G+y8NNYYSxMNOUZJZUq3ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpL3ggdK2pa0Blx03CBMT9XrvRDRrPYewW2ADmeX3eE=;
 b=DOINhRycfigt8lYOrVhMcdAnabDLwdySwxfQnxKV3muDmHkvCqerLi2LNZcxw5/Q5r36tSIJzOQRrYvhe5bCNnoK8z26SXjYIDNb3jT7HRX/NW0BOlAaIW9XxBR67IJ4e5FycGE6Gx4lZatDjPw4s4XTx4yETVtsBOt9yQWiVlgBd0es8lKUw0ZvFkZD52IWjJelKm7p1oTiTzBcvShPy/xsh40CvRYm1I9dknsGl2fKWT7yaMHNbXScfmlQfL3ubUnyGqObi7/DT1016UqX1L1D0uJO8WTjASviuEOC1b5mqmxho/65FY81kRix39649MEFTDb53b1CrLVivyEAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpL3ggdK2pa0Blx03CBMT9XrvRDRrPYewW2ADmeX3eE=;
 b=J7+E9tBRB6B0D2HvXiwg9gWhls7ZbSwBsabKg/jLpScWop+Nb6hFzNli2WmPJzg1FJWi2bCR8v7Zxsw+V7IuyXBeYo3u+oaESqiXr/7EmlDu8DX0gdqQE3IsNGm76YXGcJ9SfS8jLyC0mM3RBDJq+ozCb97mFVsQ/VwIVX7WPSE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB3294.namprd12.prod.outlook.com (20.179.81.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 14:55:32 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 14:55:32 +0000
Subject: Re: [PATCH umr 1/2] rename mmBIF_BX_PF_MM_* for nbio 2.3
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200214145034.16582-1-xiaojie.yuan@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <2a6a39da-f3bd-70f9-2b83-d95c03188345@amd.com>
Date: Fri, 14 Feb 2020 09:55:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200214145034.16582-1-xiaojie.yuan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:404:8e::17) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:404:8e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.12 via Frontend Transport; Fri, 14 Feb 2020 14:55:31 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b30ba38f-09ab-4368-f18a-08d7b15df068
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:|MN2PR12MB3294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32940E00E5F4F35AE272BB6EF7150@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(956004)(31696002)(6506007)(186003)(16526019)(53546011)(26005)(6512007)(2616005)(36756003)(478600001)(66946007)(66476007)(8676002)(81156014)(8936002)(52116002)(316002)(66556008)(31686004)(5660300002)(81166006)(2906002)(86362001)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3294;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYhAYU3gDb0gmPLOlok8Pzzj974NLQsmbFWh49XIeLVLaoQ/bH8B9jXrBFzGhbe0wLfD7O2FtAqe+HE4bAkttHsJWxcEyWOohuVapwYTxhzatbR9D2qtPv7t2wfRMy0lQy/DfSkZu8LrhWH/hZHrKnghoC0itQW5RsxA5RfWB1HWxPFkGg6f3iYGHwZoKlcmeCz46ZuacjAZuMP/BvpEPJqKFWXNgm/6xKH01BDWoJqVUaKn6+WXygVWiLsG/DsiwqPvztKXE8nWKcFRRzLQRoSJ3Zj9sl86c26aJeXuhjIUoRemMToOr1NCUZV0wpPOoifw4m7vxukzsWM8pvtJc4MB1XndcrokNqqepH8tfv9Zqc7BI+/YmZHBjbFt4C+lOx2fGRmYKnhlMsykA9wGNncxAJFDkU3QaLErBH4V/meueyhIDKw1TF9M/yuvMF/j
X-MS-Exchange-AntiSpam-MessageData: UPsi825eNMd7iHEfaqOYE6UY/ggn98cpuF/aeOerABh24szHDmEPUxGd24r61FqB7WWzkHOreRw9eVU9Gkn+IsXBEkVDfNBwK3iohm1rMKGjtZhasHlFHrifSX9t/b+0MSPPfjwMFWe43rE34t0Rxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30ba38f-09ab-4368-f18a-08d7b15df068
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:55:32.2457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fs+2u1nxaD+oRij+I9ugq3U7xWxpV+VGmhVni83QmAa1cdfJXljrs7bH432P5HnNK8iuzoHgKX9qSBiK3gn40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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

SGksCgpUaGFua3MgZm9yIHRoZSBwYXRjaCBob3dldmVyIHNpbmNlIHRoZSAqLmkgZmlsZXMgYXJl
IG1hY2hpbmUgZ2VuZXJhdGUgCkknZCByYXRoZXIgbGlrZSB0byBhdm9pZCBwYXRjaGVzIGxpa2Ug
dGhpcyAoc2luY2UgdGhleSB3aWxsIG5lZWQgdG8gYmUgCmNvbnRpbnVhbGx5IGFwcGxpZWQpLgoK
VGhlIGlkZWFsIHNvbHV0aW9uIGlzIHRvIGVpdGhlciBwYXRjaCBzcmMvbGliL3JlYWRfdnJhbS5j
IG9yIHRvIHBhdGNoIAp0aGUga2VybmVsIGhlYWRlcnMuwqAgVGhlIGtlcm5lbCBoZWFkZXJzIGFy
ZSBhbHNvIGxpa2V3aXNlIG1hY2hpbmUgCmdlbmVyYXRlZCBzbyBwYXRjaGluZyB1bXIgaXMgcHJv
YmFibHkgdGhlIGJlc3QuCgpJJ2xsIGRvIHRoaXMgbXlzZWxmLgoKSSB3aWxsIGhvd2V2ZXIgYXBw
bHkgcGF0Y2ggIzIgb2YgdGhlIHNlcmllcy4KClRoYW5rcywKClRvbQoKCk9uIDIwMjAtMDItMTQg
OTo1MCBhLm0uLCBYaWFvamllIFl1YW4gd3JvdGU6Cj4gRml4ZXMgZm9sbG93aW5nIGVycm9yIHdo
aWxlIGR1bXBpbmcgZ2Z4IHJpbmc6Cj4KPiBbQlVHXTogcmVnIFttbU1NX0lOREVYXSBub3QgZm91
bmQgb24gYXNpYyBbbmF2aTEwXQo+IFtCVUddOiByZWcgW21tTU1fSU5ERVhfSEldIG5vdCBmb3Vu
ZCBvbiBhc2ljIFtuYXZpMTBdCj4gW0JVR106IHJlZyBbbW1NTV9EQVRBXSBub3QgZm91bmQgb24g
YXNpYyBbbmF2aTEwXQo+IENhbm5vdCByZWFkIGZyb20gc3lzdGVtIG1lbW9yeTogT3BlcmF0aW9u
IG5vdCBwZXJtaXR0ZWQKPiBbRVJST1JdOiBBY2Nlc3Npbmcgc3lzdGVtIG1lbW9yeSByZXR1cm5l
ZDogLTEKPiBDYW5ub3QgcmVhZCBmcm9tIHN5c3RlbSBtZW1vcnk6IEJhZCBhZGRyZXNzCj4gW0VS
Uk9SXTogQWNjZXNzaW5nIHN5c3RlbSBtZW1vcnkgcmV0dXJuZWQ6IC0xCj4KPiBTaWduZWQtb2Zm
LWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPgo+IC0tLQo+ICAgc3JjL2xp
Yi9pcC9uYmlvMjMwX2JpdHMuaSB8IDYgKysrLS0tCj4gICBzcmMvbGliL2lwL25iaW8yMzBfcmVn
cy5pIHwgNiArKystLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NyYy9saWIvaXAvbmJpbzIzMF9iaXRzLmkgYi9z
cmMvbGliL2lwL25iaW8yMzBfYml0cy5pCj4gaW5kZXggNTA2Y2NiYS4uZmQ1YmFkOCAxMDA2NDQK
PiAtLS0gYS9zcmMvbGliL2lwL25iaW8yMzBfYml0cy5pCj4gKysrIGIvc3JjL2xpYi9pcC9uYmlv
MjMwX2JpdHMuaQo+IEBAIC0xLDExICsxLDExIEBACj4gLXN0YXRpYyBzdHJ1Y3QgdW1yX2JpdGZp
ZWxkIG1tQklGX0JYX1BGX01NX0lOREVYW10gPSB7Cj4gK3N0YXRpYyBzdHJ1Y3QgdW1yX2JpdGZp
ZWxkIG1tTU1fSU5ERVhbXSA9IHsKPiAgIAkgeyAiTU1fT0ZGU0VUIiwgMCwgMzAsICZ1bXJfYml0
ZmllbGRfZGVmYXVsdCB9LAo+ICAgCSB7ICJNTV9BUEVSIiwgMzEsIDMxLCAmdW1yX2JpdGZpZWxk
X2RlZmF1bHQgfSwKPiAgIH07Cj4gLXN0YXRpYyBzdHJ1Y3QgdW1yX2JpdGZpZWxkIG1tQklGX0JY
X1BGX01NX0RBVEFbXSA9IHsKPiArc3RhdGljIHN0cnVjdCB1bXJfYml0ZmllbGQgbW1NTV9EQVRB
W10gPSB7Cj4gICAJIHsgIk1NX0RBVEEiLCAwLCAzMSwgJnVtcl9iaXRmaWVsZF9kZWZhdWx0IH0s
Cj4gICB9Owo+IC1zdGF0aWMgc3RydWN0IHVtcl9iaXRmaWVsZCBtbUJJRl9CWF9QRl9NTV9JTkRF
WF9ISVtdID0gewo+ICtzdGF0aWMgc3RydWN0IHVtcl9iaXRmaWVsZCBtbU1NX0lOREVYX0hJW10g
PSB7Cj4gICAJIHsgIk1NX09GRlNFVF9ISSIsIDAsIDMxLCAmdW1yX2JpdGZpZWxkX2RlZmF1bHQg
fSwKPiAgIH07Cj4gICBzdGF0aWMgc3RydWN0IHVtcl9iaXRmaWVsZCBtbVNZU0hVQl9JTkRFWF9P
VkxQW10gPSB7Cj4gZGlmZiAtLWdpdCBhL3NyYy9saWIvaXAvbmJpbzIzMF9yZWdzLmkgYi9zcmMv
bGliL2lwL25iaW8yMzBfcmVncy5pCj4gaW5kZXggYWI1NzM4NS4uMjdhNjQ0YiAxMDA2NDQKPiAt
LS0gYS9zcmMvbGliL2lwL25iaW8yMzBfcmVncy5pCj4gKysrIGIvc3JjL2xpYi9pcC9uYmlvMjMw
X3JlZ3MuaQo+IEBAIC0xLDYgKzEsNiBAQAo+IC0JeyAibW1CSUZfQlhfUEZfTU1fSU5ERVgiLCBS
RUdfTU1JTywgMHgwMDAwLCAwLCAmbW1CSUZfQlhfUEZfTU1fSU5ERVhbMF0sIHNpemVvZihtbUJJ
Rl9CWF9QRl9NTV9JTkRFWCkvc2l6ZW9mKG1tQklGX0JYX1BGX01NX0lOREVYWzBdKSwgMCwgMCB9
LAo+IC0JeyAibW1CSUZfQlhfUEZfTU1fREFUQSIsIFJFR19NTUlPLCAweDAwMDEsIDAsICZtbUJJ
Rl9CWF9QRl9NTV9EQVRBWzBdLCBzaXplb2YobW1CSUZfQlhfUEZfTU1fREFUQSkvc2l6ZW9mKG1t
QklGX0JYX1BGX01NX0RBVEFbMF0pLCAwLCAwIH0sCj4gLQl7ICJtbUJJRl9CWF9QRl9NTV9JTkRF
WF9ISSIsIFJFR19NTUlPLCAweDAwMDYsIDAsICZtbUJJRl9CWF9QRl9NTV9JTkRFWF9ISVswXSwg
c2l6ZW9mKG1tQklGX0JYX1BGX01NX0lOREVYX0hJKS9zaXplb2YobW1CSUZfQlhfUEZfTU1fSU5E
RVhfSElbMF0pLCAwLCAwIH0sCj4gKwl7ICJtbU1NX0lOREVYIiwgUkVHX01NSU8sIDB4MDAwMCwg
MCwgJm1tTU1fSU5ERVhbMF0sIHNpemVvZihtbU1NX0lOREVYKS9zaXplb2YobW1NTV9JTkRFWFsw
XSksIDAsIDAgfSwKPiArCXsgIm1tTU1fREFUQSIsIFJFR19NTUlPLCAweDAwMDEsIDAsICZtbU1N
X0RBVEFbMF0sIHNpemVvZihtbU1NX0RBVEEpL3NpemVvZihtbU1NX0RBVEFbMF0pLCAwLCAwIH0s
Cj4gKwl7ICJtbU1NX0lOREVYX0hJIiwgUkVHX01NSU8sIDB4MDAwNiwgMCwgJm1tTU1fSU5ERVhf
SElbMF0sIHNpemVvZihtbU1NX0lOREVYX0hJKS9zaXplb2YobW1NTV9JTkRFWF9ISVswXSksIDAs
IDAgfSwKPiAgIAl7ICJtbVNZU0hVQl9JTkRFWF9PVkxQIiwgUkVHX01NSU8sIDB4MDAwOCwgMCwg
Jm1tU1lTSFVCX0lOREVYX09WTFBbMF0sIHNpemVvZihtbVNZU0hVQl9JTkRFWF9PVkxQKS9zaXpl
b2YobW1TWVNIVUJfSU5ERVhfT1ZMUFswXSksIDAsIDAgfSwKPiAgIAl7ICJtbVNZU0hVQl9EQVRB
X09WTFAiLCBSRUdfTU1JTywgMHgwMDA5LCAwLCAmbW1TWVNIVUJfREFUQV9PVkxQWzBdLCBzaXpl
b2YobW1TWVNIVUJfREFUQV9PVkxQKS9zaXplb2YobW1TWVNIVUJfREFUQV9PVkxQWzBdKSwgMCwg
MCB9LAo+ICAgCXsgIm1tUENJRV9JTkRFWCIsIFJFR19NTUlPLCAweDAwMGMsIDAsICZtbVBDSUVf
SU5ERVhbMF0sIHNpemVvZihtbVBDSUVfSU5ERVgpL3NpemVvZihtbVBDSUVfSU5ERVhbMF0pLCAw
LCAwIH0sCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
