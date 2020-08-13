Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78502C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1112078B
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 07:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BDOsQb44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1112078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF63E6E595;
	Thu, 13 Aug 2020 07:59:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770083.outbound.protection.outlook.com [40.107.77.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AEB6E595
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 07:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbiV2kwrh0KPvlZD9N+aWhfCVLW7OORPv34LBroE4ybykI5FZ9cQ9areLw/1zRP7V2dsTdkg6zW4ZMCnK7UjpejGnBtUYLNTaVVNR5GCvXU84lfqovl9PPAmOTURJGBYcDQ2/Nj345tk0aSyBE+KNwN3r7hOntk6IgthQeHsTlwK+V5S0ucKCyLy+Dkg/piho81XJUZB83EHnCLsAjnytxs5oSX522K1dTMJbxYZQq9tIjVdsMUmydTYyx2dK1H9WQHTfzjLeKOGrnAvFf1pY2iwg1f+wPb2g38w3WksARIg1HZu4Ay5ImkVbC/2+mrPZJNPz/deXzmEgzegOWcEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD1fbLRWcYSRcLsvHQOw/hYcNbmJdAXG8Cv0UQXJjL4=;
 b=gD+paDLDCeRdxB73aXObRLUO2dj+MAEBQva+3Kk+NHKVqCI7aFf8XQ+lijRo5I+2Jh7xi4q7It6yz5g5cPfBA+CoBKoJi9Oq4roUUpeXVcRHkB3rMhpylwGfFwRqXr1IussnZXNeCOQymQVNhVaOVgoxfqRlqmajZ3OewHwyiuwuits0KYwONv0UbGnl+WMpjEIsjrzU3moNIfd6DYjoQkRh+SF5fOc3ls2Z2pzqSpGbu39ECXPfyQkXLw/nhGaKvUHUE4oKjUy/kCpI1twLX2RRZcuGiDVNRspFSlTKmISf2eSoH6IC8mG8AzXRyPimO9S2S7vTzkvhOvnZsTdd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD1fbLRWcYSRcLsvHQOw/hYcNbmJdAXG8Cv0UQXJjL4=;
 b=BDOsQb44SKMfvATRfyadC2Fum/7SREsk4DCb2IROV8KbRF7PQZ7oztGhOTMRhj9uKTWVpzWLe3oDHS2W/4DwVKBJUL12fcVnDSQmNFwGMAS7M/EBQ8m1vB7RlMP1HoG23aSGWEf/F50Qt5e9BJFtOP0TKOmtaLOh00jp/V1DC2M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 13 Aug
 2020 07:59:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 07:59:02 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
Date: Thu, 13 Aug 2020 09:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200813030414.188468-1-shashank.sharma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.15 via Frontend Transport; Thu, 13 Aug 2020 07:59:01 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1df38e26-7a49-4117-6fd1-08d83f5ebdfa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41572C0DFB1231088BA81E4B83430@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Yi20sJZ93D/mPtKFPDfTyFg238DGMyBh70RLg1+K8+ab/GNCL68DhxQHRLPMA1sOjJw+5KBsLSaCmvTFwwpugXOsl7AkKEx2ZAjB+cBgelIrcN3iS4bjWgIX5cc9KU/Norw6NH/PqlLVGAs4RAjnbHmCpfSbvHjbKliZ/2ssvJg0zb1C4c92dpnKPIAxd+pxnLG0tmVnWEJRuRsOV8ZogCt9vOrnfEKjfwkKfNlpnNyE5iT18PgB7ALZhnHaIgxMvlgBpyDRul1hla6UhmW7zY6PZwJ0dHwTRhVdlp4CJMW12DEUcSd7oOxffyq7qDil4Kz2NypikVqwdn1jvCQcLe10L8wFJygAXs53tmPwTnrLYGRAGC7rY/7dN35WL+b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(36756003)(16526019)(86362001)(52116002)(6666004)(316002)(66556008)(66476007)(66946007)(186003)(15650500001)(31696002)(2616005)(478600001)(31686004)(5660300002)(8936002)(83380400001)(4326008)(66574015)(8676002)(2906002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: a7Knk0B2uVciY/PE1m6rwxCT/ZZkj+X6yqmkBDgUDQybCZn0Dds1pEbfdFhtoqX/5c73UxS+OAiGs76WZoV6GKy3sabCyUueq5oINmjTgMMmQF3W4BEx1wN/3ei5N/1RedVqk0Ez+MzQa3DCjr/tW+8zzj3EBtV7EkVCfDJQAkgt3mJoldQaGIxpTzaXAyXGUf8gjV4TTm16ynhFSih0W/859bckFf76OMe1znCy1FEPzEdUdxgvQIyD7PXlIrQ45Q8C3RMO/97T4cjuRYPXWJ9oJSiD0AnFg8C2mwQ+MDN37DHIrYNV3VtTxAVp3qsz7ARG9Ui6exC+pHcY27OUrMzGy0bwE2SGy6eVsvFPUGK7vRwtvmhhaHrWWD6JqACRbQeYGu9Bg9rSh6qqqOZduTFfa+H/TrfupJIQR9CdMDW9dg5TWkc9n1j1uYqsMIIHzOJwyLb1oNmMtrS3Y+7bS1OGzGYP/cXsKS8dANqmZ7S88ay4KiGl1eG8H/uKLiC0hpvNuM9YSlAgs6pe/F88oUyk/5A4mxUaCTf/m7STQGTBUiL6sv+rhgnu/7JvEAbdqzO8fZZKuQTUVpMqdIImVjCeYtbKnvfv1Y12L037/gYOds9zsVbQP+5PRg5fzmy8dcVEU+wcJFol7UvTAP3LdcTOAwCWydbOQZ2FYTkaJs9tqfOIM6y7z6KdQ4iZli0aPfDlPuTFmvXbv/dYboNtKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df38e26-7a49-4117-6fd1-08d83f5ebdfa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 07:59:02.6183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfiB7JkgbOaQPF8S/uZEJTJsN2soEJ0HPqSln2X2Pxzi5T9tdmuyNwn/jICKzxjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDguMjAgdW0gMDU6MDQgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gVGhpcyBwYXRj
aCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRlCj4gZXZlbnRz
LiBUaGlzIHNwZWNpZmljIGV2ZW50IHdpbGwgcHJvdmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+IC0g
c3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4gLSBIVyBlbmdpbmUgZmxh
Z3MgZm9yIHRoZSBtYXAKPiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPgo+IFRoaXMg
d2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkgcHJvZmlsaW5nIHRvb2xzCj4g
KGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRhdGUgZXZl
bnRzLgo+Cj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJlc3MgbG9va3VwIGxvZ2ljIGluIHRyYWNl
IHBvaW50Cj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5Cj4gICAgICBhZGRlZCBu
cHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPiAgICAgIGFkZGVkIHBhZ2Ugc2l6
ZSBpbiB0aGUgYXJnIGxpc3QKPiBWNDogQWRkcmVzc2VkIENocmlzdGlhbidzIHJldmlldyBjb21t
ZW50cwo+ICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+ICAgICAgdXNlIGluY3Ig
aW5zdGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4KPiBDYzogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8
c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHJhY2UuaCB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8ICA5ICsrKystLQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPiBpbmRleCA2M2U3MzRhMTI1ZmIu
LmRmMTJjZjg0NjZjMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHJhY2UuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
cmFjZS5oCj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9tYXBw
aW5nLCBhbWRncHVfdm1fYm9fY3MsCj4gICAJICAgIFRQX0FSR1MobWFwcGluZykKPiAgICk7Cj4g
ICAKPiArVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzLAo+ICsJICAgIFRQX1BST1RP
KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPiArCQkgICAgIHVpbnQ2NF90IHN0
YXJ0LCB1aW50NjRfdCBlbmQsCj4gKwkJICAgICB1bnNpZ25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90
IGRzdCwKPiArCQkgICAgIHVpbnQ2NF90IGluY3IsIHVpbnQ2NF90IGZsYWdzKSwKPiArCVRQX0FS
R1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAo+ICsJVFBfU1RSVUNU
X19lbnRyeSgKPiArCQkJIF9fZmllbGQodTY0LCBzdGFydCkKPiArCQkJIF9fZmllbGQodTY0LCBl
bmQpCj4gKwkJCSBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4gKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGlu
dCwgbnB0ZXMpCj4gKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKPiArCQkJIF9fZHluYW1pY19hcnJh
eSh1NjQsIGRzdCwgbnB0ZXMpCgpBcyBkaXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVt
IG1haW50YWluZXIgd2UgbmVlZCB0byBhZGQgdGhlIHBpZCAKYW5kIHByb2JhYmx5IHRoZSBWTSBj
b250ZXh0IElEIHdlIHVzZSBoZXJlIHRvIGlkZW50aWZ5IHRoZSB1cGRhdGVkIFZNLgoKQ2hyaXN0
aWFuLgoKPiArCSksCj4gKwo+ICsJVFBfZmFzdF9hc3NpZ24oCj4gKwkJCXVuc2lnbmVkIGludCBp
Owo+ICsKPiArCQkJX19lbnRyeS0+c3RhcnQgPSBzdGFydDsKPiArCQkJX19lbnRyeS0+ZW5kID0g
ZW5kOwo+ICsJCQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOwo+ICsJCQlfX2VudHJ5LT5pbmNyID0g
aW5jcjsKPiArCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKPiArCQkJZm9yIChpID0gMDsgaSA8
IG5wdGVzOyArK2kpIHsKPiArCQkJCXU2NCBhZGRyID0gcC0+cGFnZXNfYWRkciA/IGFtZGdwdV92
bV9tYXBfZ2FydCgKPiArCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDogZHN0Owo+ICsKPiArCQkJ
CSgodTY0ICopX19nZXRfZHluYW1pY19hcnJheShkc3QpKVtpXSA9IGFkZHI7Cj4gKwkJCQlkc3Qg
Kz0gaW5jcjsKPiArCQkJfQo+ICsJKSwKPiArCVRQX3ByaW50aygic3RhcnQ6MHglMDEwbGx4IGVu
ZDoweCUwMTBsbHgsIGZsYWdzOjB4JWxseCwgaW5jcjolbGx1LCIKPiArCQkgICIgZHN0OlxuJXMi
LCBfX2VudHJ5LT5zdGFydCwgX19lbnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywKPiArCQkgIF9f
ZW50cnktPmluY3IsIF9fcHJpbnRfYXJyYXkoCj4gKwkJICBfX2dldF9keW5hbWljX2FycmF5KGRz
dCksIF9fZW50cnktPm5wdGVzLCA4KSkKPiArKTsKPiArCj4gICBUUkFDRV9FVkVOVChhbWRncHVf
dm1fc2V0X3B0ZXMsCj4gICAJICAgIFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRfdCBhZGRy
LCB1bnNpZ25lZCBjb3VudCwKPiAgIAkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBmbGFn
cywgYm9vbCBkaXJlY3QpLAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
aW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0xNTEzLDE3ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFy
YW1zLAo+ICAgCQlkbyB7Cj4gICAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwg
ZnJhZ19lbmQpOwo+ICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQp
ID4+IHNoaWZ0Owo+ICsJCQl1aW50NjRfdCB1cGRfZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVf
RlJBRyhmcmFnKTsKPiAgIAo+ICAgCQkJLyogVGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhp
Z2hlciBsZXZlbCBQRHMgdG8KPiAgIAkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4K
PiAgIAkJCSAqLwo+ICAgCQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPiArCj4gKwkJCXRyYWNl
X2FtZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4gKwkJ
CQkJCSAgICBucHRlcywgZHN0LCBpbmNyLAo+ICsJCQkJCQkgICAgdXBkX2ZsYWdzKTsKPiAgIAkJ
CWFtZGdwdV92bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBwdCwgY3Vyc29yLmxldmVsLAo+ICAgCQkJ
CQkgICAgICAgcGVfc3RhcnQsIGRzdCwgbnB0ZXMsIGluY3IsCj4gLQkJCQkJICAgICAgIGZsYWdz
IHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsKPiArCQkJCQkgICAgICAgdXBkX2ZsYWdzKTsKPiAg
IAo+ICAgCQkJcGVfc3RhcnQgKz0gbnB0ZXMgKiA4Owo+IC0JCQlkc3QgKz0gKHVpbnQ2NF90KW5w
dGVzICogQU1ER1BVX0dQVV9QQUdFX1NJWkUgPDwgc2hpZnQ7Cj4gKwkJCWRzdCArPSBucHRlcyAq
IGluY3I7Cj4gICAKPiAgIAkJCWZyYWdfc3RhcnQgPSB1cGRfZW5kOwo+ICAgCQkJaWYgKGZyYWdf
c3RhcnQgPj0gZnJhZ19lbmQpIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
