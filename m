Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88AC2D0C3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F973206E0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MuQt6u5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F973206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE276E0C8;
	Mon, 16 Dec 2019 19:39:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14676E0C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 19:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiNuigsk6wQfThBG7R0AR6zoay8mjvX3iWAaMNIM7gULrIjs7CbtpKpGa1xoHJZ9laSP8De+VtKMAHfzHZasmJOwXd/HoQkYgcoNONn1fmlROmD/wOKy/J+GdSZCWYSnWZWCno82uVTB0TXindHhhKF7oiZN2ukqWI7FuJ3twl/LbEevi8/D68rToebueWcNysmtbiDL3JZaLsRSotCNNFn8OYW9iVpafS83it4WV3xiQd5iuQV0xUSwo80TijfSTMsoRaJQJWF8fMER5NeXM5IgbEqaiwyPSgVcNbAvekWWxsIXcHtPAtRLNx8WG38kiwRwAfJ0OGPs3LqvOatt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jjjKYBf+HrBh35UUiwkXdntYlcKyNz7Jv73S0Yvctg=;
 b=j6AHL7FUMDlqbS+yDkSv58q9QUNk1tFyZkZ1giqNsOdKsCculN/JRsmSdQJLPwSloQjfCALEOOZClX19F2hIMExM5n4TPWpWYaVLX2fSxwCcvrekWHpynylNyNT+UnjTuMBN2yrzNfK3PMV2E0BiXC4g6bmnJpy1Ao4f+LXo0XPCK8OWLjvHm5BCXDkfC3jRo5Za8/qi61GScx0SRC/enihCFHxhv53/ZdcvIFuShLpRkTfdR4Am601v29thm+5HskA/D9hVYN4iOcTCU0v7Quby+b1do8BUjI/HHPK18d1Wc2owNTjDNTO30svNLTKtJJoC8rg8L26SwL4+tGvCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jjjKYBf+HrBh35UUiwkXdntYlcKyNz7Jv73S0Yvctg=;
 b=MuQt6u5ziqqjBZYRH2dtg2vQhABjYIT8QiRMhohlXDdgEed7WS4X+OjOQdADuyZYW9la40LmZPnVin78/uNjqOpkd60yfoEqcaHogF4Eilfdwk+KSeus7+dHDdi/ppiKuiZ6EUiUz2PAAoqhVIgSnrkk4x62z3Q2NbbwQ5MiUeE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB4235.namprd12.prod.outlook.com (10.141.8.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 19:39:44 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 19:39:44 +0000
Subject: Re: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191213163807.27139-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <34c29118-32e9-3c37-9b48-ad33a0de8b99@amd.com>
Date: Mon, 16 Dec 2019 14:39:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191213163807.27139-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::14) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 237b9d1c-6596-4d99-dd96-08d7825fb34b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:|DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235B004685FC121D64D62A892510@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(31686004)(5660300002)(86362001)(8936002)(81156014)(8676002)(81166006)(4001150100001)(6512007)(66476007)(36756003)(316002)(31696002)(66946007)(66556008)(2906002)(478600001)(6666004)(2616005)(6486002)(44832011)(26005)(186003)(6506007)(53546011)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4235;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OktvQMLHeRLh+VPZ/iSnmzy86bLTaaldPaUNy/sauT3Dk1Twy41LcAmASVFM3Jx1KjqlIO43ueZe/SKNU9ImFUGTMiAoaILJCN/PfZqNLLAVn6k3qZCkciMiI+MoeVnJUh+orsVPpP+F91XiY8KRbIbMvrdwxxwBNQ8WPgftEbzziUIdnOAfpP2v0+eRfOatvd5pAHIldXU7nqv4zEO5l8CGjx68PH/+Y2W7v0FDvBFV9emEDxUbfNe6DicnavQjZ2s0L5m9qiFaeV4BsgTAEdyH39h8gPeAUjZVv0emJv5JKe6xyfRs/XLhuRu9L1MuAHBARatx8Wt3aqfgV1CZWe6q0pnInZdqLUxPtUkBrIZbmSEjTPdgQ6BswAEfWhXZNDc3+X+zGfj07ihRP/w24HfMkxLl1WXR76k03lV6+9s8Njhk72q8I40tJp3fQTUc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237b9d1c-6596-4d99-dd96-08d7825fb34b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 19:39:43.9721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAr9OaXe6U9wILepFBKhuPYiw59Shwj+looT8jLALki0SGhutfsLXgo0hzlGRZ3RgtNE8fxc8LSPdtnOi5xcrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

T24gMjAxOS0xMi0xMyA4OjM4LCBZb25nIFpoYW8gd3JvdGU6Cj4gVGhpcyBwcmV2ZW50cyB0aGUg
TlVMTCBwb2ludGVyIGFjY2VzcyB3aGVuIHRoZXJlIGFyZSBmZXdlciB0aGFuIDggc2RtYQo+IGVu
Z2luZXMuCgpJIGRvbid0IHNlZSB3aGVyZSB5b3UgZ290IGEgTlVMTCBwb2ludGVyIGluIHRoZSBv
bGQgY29kZS4gQWxzbyB0aGlzIApjaGFuZ2UgaXMgaW4gYW4gQXJjdHVydXMtc3BlY2lmaWMgc291
cmNlIGZpbGUuIEFGQUlLIEFyY3R1cnVzIGFsd2F5cyBoYXMgCjggU0RNQSBlbmdpbmVzLgoKVGhl
IG5ldyBjb2RlIGlzIG11Y2ggbG9uZ2VyIHRoYW4gdGhlIG9sZCBjb2RlLiBJIGRvbid0IHNlZSBo
b3cgdGhhdCdzIGFuIAppbXByb3ZlbWVudC4gU2VlIG9uZSBtb3JlIGNvbW1lbnQgaW5saW5lLgoK
Cj4KPiBDaGFuZ2UtSWQ6IElhYmFlOWJmZjc1NDZiMzQ0NzIwOTA1ZDVkNGE1Y2ZjMDY2YTc5ZDI1
Cj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KPiAtLS0KPiAg
IC4uLi9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMgICB8IDY0ICsrKysr
KysrKysrKy0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAyMiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2FyY3R1cnVzLmMKPiBpbmRleCAzYzExOTQwN2RjMzQuLjJhZDA4OGYxMDQ5MyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2Fy
Y3R1cnVzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2FyY3R1cnVzLmMKPiBAQCAtNzEsMzIgKzcxLDUyIEBAIHN0YXRpYyB1aW50MzJfdCBnZXRfc2Rt
YV9ybGNfcmVnX29mZnNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCQl1bnNp
Z25lZCBpbnQgZW5naW5lX2lkLAo+ICAgCQkJCXVuc2lnbmVkIGludCBxdWV1ZV9pZCkKPiAgIHsK
PiAtCXVpbnQzMl90IHNkbWFfZW5naW5lX3JlZ19iYXNlWzhdID0gewo+IC0JCVNPQzE1X1JFR19P
RkZTRVQoU0RNQTAsIDAsCj4gLQkJCQkgbW1TRE1BMF9STEMwX1JCX0NOVEwpIC0gbW1TRE1BMF9S
TEMwX1JCX0NOVEwsCj4gLQkJU09DMTVfUkVHX09GRlNFVChTRE1BMSwgMCwKPiAtCQkJCSBtbVNE
TUExX1JMQzBfUkJfQ05UTCkgLSBtbVNETUExX1JMQzBfUkJfQ05UTCwKPiAtCQlTT0MxNV9SRUdf
T0ZGU0VUKFNETUEyLCAwLAo+IC0JCQkJIG1tU0RNQTJfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTJf
UkxDMF9SQl9DTlRMLAo+IC0JCVNPQzE1X1JFR19PRkZTRVQoU0RNQTMsIDAsCj4gLQkJCQkgbW1T
RE1BM19STEMwX1JCX0NOVEwpIC0gbW1TRE1BM19STEMwX1JCX0NOVEwsCj4gLQkJU09DMTVfUkVH
X09GRlNFVChTRE1BNCwgMCwKPiAtCQkJCSBtbVNETUE0X1JMQzBfUkJfQ05UTCkgLSBtbVNETUE0
X1JMQzBfUkJfQ05UTCwKPiAtCQlTT0MxNV9SRUdfT0ZGU0VUKFNETUE1LCAwLAo+IC0JCQkJIG1t
U0RNQTVfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTVfUkxDMF9SQl9DTlRMLAo+IC0JCVNPQzE1X1JF
R19PRkZTRVQoU0RNQTYsIDAsCj4gLQkJCQkgbW1TRE1BNl9STEMwX1JCX0NOVEwpIC0gbW1TRE1B
Nl9STEMwX1JCX0NOVEwsCj4gLQkJU09DMTVfUkVHX09GRlNFVChTRE1BNywgMCwKPiAtCQkJCSBt
bVNETUE3X1JMQzBfUkJfQ05UTCkgLSBtbVNETUE3X1JMQzBfUkJfQ05UTAo+IC0JfTsKPiAtCj4g
LQl1aW50MzJfdCByZXR2YWwgPSBzZG1hX2VuZ2luZV9yZWdfYmFzZVtlbmdpbmVfaWRdCgpJJ20g
bm90IHN1cmUgd2hlcmUgeW91IHdlcmUgZ2V0dGluZyBhIE5VTEwgcG9pbnRlciwgYnV0IEkgZ3Vl
c3MgdGhpcyAKY291bGQgaGF2ZSB1c2VkIGEgcmFuZ2UgY2hlY2sgdG8gbWFrZSBzdXJlIGVuZ2lu
ZV9pZCBpcyA8IDggYmVmb3JlIAppbmRleGluZyBpbnRvIHRoZSBhcnJheS4gVGhlIGVxdWl2YWxl
bnQgaW4gdGhlIHN3aXRjaCBzdGF0ZW1lbnQgd291bGQgYmUgCmEgZGVmYXVsdCBjYXNlLiBTZWUg
YmVsb3cuCgoKPiArCXVpbnQzMl90IHNkbWFfZW5naW5lX3JlZ19iYXNlOwo+ICsJdWludDMyX3Qg
c2RtYV9ybGNfcmVnX29mZnNldDsKPiArCj4gKwlzd2l0Y2ggKGVuZ2luZV9pZCkgewo+ICsJY2Fz
ZSAwOgo+ICsJCXNkbWFfZW5naW5lX3JlZ19iYXNlID0gU09DMTVfUkVHX09GRlNFVChTRE1BMCwg
MCwKPiArCQkJCW1tU0RNQTBfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTBfUkxDMF9SQl9DTlRMOwo+
ICsJCWJyZWFrOwo+ICsJY2FzZSAxOgo+ICsJCXNkbWFfZW5naW5lX3JlZ19iYXNlID0gU09DMTVf
UkVHX09GRlNFVChTRE1BMSwgMCwKPiArCQkJCW1tU0RNQTFfUkxDMF9SQl9DTlRMKSAtIG1tU0RN
QTFfUkxDMF9SQl9DTlRMOwo+ICsJCWJyZWFrOwo+ICsJY2FzZSAyOgo+ICsJCXNkbWFfZW5naW5l
X3JlZ19iYXNlID0gU09DMTVfUkVHX09GRlNFVChTRE1BMiwgMCwKPiArCQkJCW1tU0RNQTJfUkxD
MF9SQl9DTlRMKSAtIG1tU0RNQTJfUkxDMF9SQl9DTlRMOwo+ICsJCWJyZWFrOwo+ICsJY2FzZSAz
Ogo+ICsJCXNkbWFfZW5naW5lX3JlZ19iYXNlID0gU09DMTVfUkVHX09GRlNFVChTRE1BMywgMCwK
PiArCQkJCW1tU0RNQTNfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTNfUkxDMF9SQl9DTlRMOwo+ICsJ
CWJyZWFrOwo+ICsJY2FzZSA0Ogo+ICsJCXNkbWFfZW5naW5lX3JlZ19iYXNlID0gU09DMTVfUkVH
X09GRlNFVChTRE1BNCwgMCwKPiArCQkJCW1tU0RNQTRfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTRf
UkxDMF9SQl9DTlRMOwo+ICsJCWJyZWFrOwo+ICsJY2FzZSA1Ogo+ICsJCXNkbWFfZW5naW5lX3Jl
Z19iYXNlID0gU09DMTVfUkVHX09GRlNFVChTRE1BNSwgMCwKPiArCQkJCW1tU0RNQTVfUkxDMF9S
Ql9DTlRMKSAtIG1tU0RNQTVfUkxDMF9SQl9DTlRMOwo+ICsJCWJyZWFrOwo+ICsJY2FzZSA2Ogo+
ICsJCXNkbWFfZW5naW5lX3JlZ19iYXNlID0gU09DMTVfUkVHX09GRlNFVChTRE1BNiwgMCwKPiAr
CQkJCW1tU0RNQTZfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTZfUkxDMF9SQl9DTlRMOwo+ICsJCWJy
ZWFrOwo+ICsJY2FzZSA3Ogo+ICsJCXNkbWFfZW5naW5lX3JlZ19iYXNlID0gU09DMTVfUkVHX09G
RlNFVChTRE1BNywgMCwKPiArCQkJCW1tU0RNQTdfUkxDMF9SQl9DTlRMKSAtIG1tU0RNQTdfUkxD
MF9SQl9DTlRMOwo+ICsJCWJyZWFrOwo+ICsKCkRvIHlvdSBuZWVkIGEgZGVmYXVsdCBjYXNlIGZv
ciB0aGUgc3dpdGNoIHN0YXRlbWVudD8gSSB0aGluayB5b3UgZ2V0IGEgCmNvbXBpbGVyIHdhcm5p
bmcgd2l0aG91dCBvbmUuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+ICsJfQo+ICsKPiArCXNkbWFf
cmxjX3JlZ19vZmZzZXQgPSBzZG1hX2VuZ2luZV9yZWdfYmFzZQo+ICAgCQkrIHF1ZXVlX2lkICog
KG1tU0RNQTBfUkxDMV9SQl9DTlRMIC0gbW1TRE1BMF9STEMwX1JCX0NOVEwpOwo+ICAgCj4gICAJ
cHJfZGVidWcoIlJMQyByZWdpc3RlciBvZmZzZXQgZm9yIFNETUElZCBSTEMlZDogMHgleFxuIiwg
ZW5naW5lX2lkLAo+IC0JCQlxdWV1ZV9pZCwgcmV0dmFsKTsKPiArCQkJcXVldWVfaWQsIHNkbWFf
cmxjX3JlZ19vZmZzZXQpOwo+ICAgCj4gLQlyZXR1cm4gcmV0dmFsOwo+ICsJcmV0dXJuIHNkbWFf
cmxjX3JlZ19vZmZzZXQ7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQga2dkX2hxZF9zZG1hX2xv
YWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
