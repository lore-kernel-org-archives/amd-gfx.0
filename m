Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D87C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DED220818
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DED220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E126EBFA;
	Tue, 12 Nov 2019 21:46:54 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800045.outbound.protection.outlook.com [40.107.80.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578C16EBFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+3BKb40Ul8w64WhKXzaO/GWFlh4FCGIsBq9+0ETkx+s84PiEA7mxwAL2UYl2YwkWm6erOe4nBM4P7a6koBzA0aCLVc2y4v8IJQxLmoYgNF2z/QT83l2+dDD6qARU44x1YaQBZmgPW+aQsH9ZSTkP9+i9+F+aeHRUqw17rheCkcaa/k3FPK3hZA75zGMT13VY3RoF3sE1gGLfOychPCJa8jNGDiMYxE0YweqS9pSIf9Rt9MRuEzqVuIKz2UNXo9Ukyc9AucrR7NJe1zoIQMmMVGuuU+zGQqNqtQM9pByJuiO1nIb5LaL1vJHMli7FU8oWt4we0tvpU9klNrvaahynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYRx2ZjeKgADqV2ebjXMaQ7v0TzmABheNYJ1+2Z14ko=;
 b=TjFphvfM9qlBskfdjIpYs8i3JhlWhcIfKQJdyzxjt+PPMK/ky/WQpiB+zmx29aQ2OMda4h4NeqUnhUS1jkl0bhg4avzn9Wf45OuSAFWnzrwTmLWaRcPQ3ZXy1/S0bTC1pvWQmrUBOgYJLjy960OuxwH5Vor8p5ZESLAp15kCYA4RragxhUJHoBmGRHqy0zStMdB826KU+dfsf3wW+J0Ln5GvaiAXwn4Ed6Hi/xRK0koMWUwILqYDInm5OyJGY51hKeyhZjegYzinQf+Lg8vMaITvo1jF7KgL+3VHN8JzE3KdPTyVZDd3sxm/FR9Ty4gqROTSeJ1+c7W53GV6MS/WCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3710.namprd12.prod.outlook.com (10.255.239.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 21:46:49 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:46:49 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Stop using GFP_NOIO explicitly for GFX10
To: Yong Zhao <yong.zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191112212641.4643-1-Yong.Zhao@amd.com>
 <20191112212641.4643-2-Yong.Zhao@amd.com>
 <4e5a3723-4b61-e76c-dc96-dafdec51f099@amd.com>
 <e585e540-5edf-52b1-4fcf-48f1e98a2dd2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <8e94cf6d-c2bd-46d6-87e2-9663aacd33da@amd.com>
Date: Tue, 12 Nov 2019 16:46:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <e585e540-5edf-52b1-4fcf-48f1e98a2dd2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d65943b6-7842-48cf-7e8c-08d767b9d240
X-MS-TrafficTypeDiagnostic: MN2PR12MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3710DA714D8F4B7AC92BF46392770@MN2PR12MB3710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(8676002)(23676004)(2486003)(36916002)(58126008)(8936002)(6512007)(52116002)(486006)(44832011)(305945005)(14444005)(7736002)(81156014)(81166006)(478600001)(476003)(99286004)(446003)(2616005)(6486002)(11346002)(36756003)(6246003)(50466002)(6116002)(6436002)(2906002)(66066001)(65806001)(3846002)(65956001)(26005)(25786009)(229853002)(5660300002)(386003)(186003)(86362001)(316002)(76176011)(66946007)(66556008)(31696002)(4001150100001)(66476007)(14454004)(31686004)(53546011)(2870700001)(47776003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3710;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/AVStLHZisTVD54doOl/ZKjpcFYHnM2jF26unFB/AafE0xq6wFqXXC7aKdl5JRWyr79V3LU5w8xMifQqe9XbhJsq4npR0vtWu+rpTus7F2HJVQXb/RwBZiikfO/sC8bfNAlMxeN0xnz3qRPC7os8nMNsnoqJGyUIp4lPixefiQk+ZApTZhUYvt7sLMkrqvBmq0ESrS96VqvE7hsmdyN32aDYxq5fZmfCMQjxOLctH+klXLvHTpaU/mjdaWITUSL+xcTFfAyT3yH/YwAOgP1phk2CcQoa67uM0QxvspQ8s+IePi4ZL0Xvykr+7xyRVn8wrErMSi4uCWbxz+aB3Z2z/xwiKXoLf5aisXMJV9qgtIPtVzZ0YQcELZNkB/Op55BWQiQtYhDkyfpy2pR5sGvnKCpcdoh6d+x1VYcBEJUvOHtZMhM4kuAoiYin/xob2di
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65943b6-7842-48cf-7e8c-08d767b9d240
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:46:49.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwdXhXL3+H2/rcFdEna/2zqLh6Xu1rDBcsCqS+gND7DJNYL3dbak/MYZF68GXoKPqSt/TmDUq4IIug/4ydiXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYRx2ZjeKgADqV2ebjXMaQ7v0TzmABheNYJ1+2Z14ko=;
 b=AGuVUFKnIiFby5bPx1ttOAbG1J9ZiHGCvRCA/YIc4vhUtPnqWQTGFyGhk++ScxDZmy0ssSP9QkuiL+jk1On0g3rg/R7KcMqByLgJzEUpujdpxirJ3dmoHtlOc/lu30fRa3/CgQU2icUgH0+1NeG+nsBznkLKlo5cdfH/FsOBAhQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112214648.GPYFsSmA1Jnk3OkrSpBsp5NSZDoM3L9ten3QyhjVDas@z>

T24gMjAxOS0xMS0xMiA0OjM1IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBIaSBGZWxpeCwKPgo+
IFNlZSBvbmUgdGhpbmcgaW5saW5lIEkgYW0gbm90IHRvbyBzdXJlLgo+Cj4gWW9uZwo+Cj4gT24g
MjAxOS0xMS0xMiA0OjMwIHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+PiBPbiAyMDE5LTEx
LTEyIDQ6MjYgcC5tLiwgWW9uZyBaaGFvIHdyb3RlOgo+Pj4gQWRhcHQgdGhlIGNoYW5nZSBmcm9t
IDFjZDEwNmVjZmMxZjA0Cj4+Pgo+Pj4gVGhlIGNoYW5nZSBpczoKPj4+Cj4+PiDCoMKgwqDCoCBk
cm0vYW1ka2ZkOiBTdG9wIHVzaW5nIEdGUF9OT0lPIGV4cGxpY2l0bHkKPj4+Cj4+PiDCoMKgwqDC
oCBUaGlzIGlzIG5vIGxvbmdlciBuZWVkZWQgd2l0aCB0aGUgbWVtYWxsb2Nfbm9mc19zYXZlL3Jl
c3RvcmUgaW4KPj4+IMKgwqDCoMKgIGRxbV9sb2NrL3VubG9jawo+Pj4KPj4+IENoYW5nZS1JZDog
STQyNDUwYjJjMTQ5ZDJiMTg0MmJlOTlhOGYzNTVjODI5YTAwNzllN2MKPj4+IFNpZ25lZC1vZmYt
Ynk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Cj4+Cj4+IFRoZSBzZXJpZXMgaXMKPj4K
Pj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+
Pgo+Pgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdjEwLmMgfCAyICstCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
bXFkX21hbmFnZXJfdjkuY8KgIHwgMiArLQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyAKPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4+PiBpbmRleCA0NmRkYjMzYjYy
NGEuLjU3OWM1ZmZjZmE3OSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4+PiBAQCAtMzkzLDcgKzM5Myw3IEBAIHN0cnVj
dCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92MTAoZW51bSAKPj4+IEtGRF9NUURfVFlQ
RSB0eXBlLAo+Pj4gwqDCoMKgwqDCoCBpZiAoV0FSTl9PTih0eXBlID49IEtGRF9NUURfVFlQRV9N
QVgpKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+Pj4gwqAgLcKgwqDCoCBt
cWQgPSBremFsbG9jKHNpemVvZigqbXFkKSwgR0ZQX05PSU8pOwo+Pj4gK8KgwqDCoCBtcWQgPSBr
emFsbG9jKHNpemVvZigqbXFkKSwgR0ZQX0tFUk5FTCk7Cj4+PiDCoMKgwqDCoMKgIGlmICghbXFk
KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+Pj4gwqAgZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jIAo+Pj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+Pj4gaW5kZXgg
YmUyN2ZmMDFjZGI4Li4yMmE4MTljODg4ZDggMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMKPj4+IEBAIC05Miw3ICs5Miw3IEBA
IHN0YXRpYyBzdHJ1Y3Qga2ZkX21lbV9vYmogKmFsbG9jYXRlX21xZChzdHJ1Y3QgCj4+PiBrZmRf
ZGV2ICprZmQsCj4+PiDCoMKgwqDCoMKgwqAgKiBpbnN0ZWFkIG9mIHN1Yi1hbGxvY2F0aW9uIGZ1
bmN0aW9uLgo+Pj4gwqDCoMKgwqDCoMKgICovCj4+PiDCoMKgwqDCoMKgIGlmIChrZmQtPmN3c3Jf
ZW5hYmxlZCAmJiAocS0+dHlwZSA9PSBLRkRfUVVFVUVfVFlQRV9DT01QVVRFKSkgewo+Pj4gLcKg
wqDCoMKgwqDCoMKgIG1xZF9tZW1fb2JqID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGtmZF9tZW1f
b2JqKSwgR0ZQX05PSU8pOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1xZF9tZW1fb2JqID0ga3phbGxv
YyhzaXplb2Yoc3RydWN0IGtmZF9tZW1fb2JqKSwgR0ZQX0tFUk5FTCk7Cj4gW3l6XSBUaGlzIHNo
b3VsZCBiZSBrZXB0IHByb2JhYmx5LiBXaXRoIHRoZSBsYXRlc3QgY29kZSwgCj4gYWxsb2NhdGVf
bXFkKCkgaXMgY2FsbGVkIG91dHNpZGUgb2YgdGhlIGRxbS4gU28gbm93IHRoZSBzaXR1YXRpb24g
aXMgCj4gZGlmZmVyZW50IGZyb20gdGhlIG9yaWdpbmFsIG9uZS4KCk1lbW9yeSBhbGxvY2F0aW9u
cyBvdXRzaWRlIHRoZSBEUU0gbG9jayBhcmUgbm90IHByb2JsZW1hdGljLiBPbmx5IG1lbW9yeSAK
YWxsb2NhdGlvbnMgdW5kZXIgdGhlIERRTSBsb2NrIG5lZWQgdG8gYmUgY2FyZWZ1bCB0byBhdm9p
ZCBGUyByZWNsYWltLCAKYmVjYXVzZSB0aGF0IGNhbiBsZWFkIHRvIGRlYWRsb2NrcyB3aXRoIE1N
VSBub3RpZmllcnMuIEdGUF9OT0lPIGlzIG5vIApsb25nZXIgbmVlZGVkIGZvciB0aGF0LgoKUmVn
YXJkcywKIMKgIEZlbGl4Cgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghbXFkX21lbV9vYmop
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR2YWwgPSBhbWRncHVfYW1ka2ZkX2FsbG9jX2d0dF9tZW0oa2ZkLT5rZ2Qs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
