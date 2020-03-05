Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE1C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD882073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kRm4UDnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD882073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD86C6EBCA;
	Thu,  5 Mar 2020 14:34:32 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680077.outbound.protection.outlook.com [40.107.68.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88C06EBCA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 14:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi1Kvyj6ixou9KNQ3N8HsdOsTt8SV0bo/xiHXk0HoCqDOQNnCvRck+P7yTbFm250wbDEa0yyMKgV9nHsodOtr2RueCj1DlUtRQXnXeatOKCnXu/H7/5eRpYdDgZ8cwAAq/jduLAAvRcSTJ1avtd3aJ3dB/qgSU3EQDXwHqE5JypCKqK/EN3BNI5AdLh3YjjIgNF+MqjhQD4E1Rp4XYy8DXxiiDx4LPM4PIAJMHOlB9rp+5FHbr3z0rJjX3Mu38EQINtZ2BH354JM5p4jjTGgszCbbSreAR6aBA4xDVOknnFgrTMnbRo5De5t6yM7T2MNYX2RwN9Zh7HxNW6ACTZYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0MlVhG2uDO276YjSOYfoePBxSP0P1tiqlJ5VCrDBxM=;
 b=A5VngiO22GeH4jmvuCGT2/Mm3ApNglPwU0/2+R5JWLAZA8dRt0j1ODvTpCEu8NqR27l4MJIoHlzgEIbD+jG3Ps75Fy6Gn23YKxfYrII1MMLmDvN8kQxso5IFi+jLravF6ZPvFO70Ilg41YTbE1Cjuvvx+3+11FBKjHocumtnQiZOa3RtDCPQn5Oci4UDEl2pyYigSY/P66um0r2ygXTfnH1hahVw/0tqSEEN+C4mYNNlNV9IaCr/YFhB896c7DfUwSibK/M+O6y2ttr6aDweIxR/aYgiDy6bYRvikr6WdTCRvGVFodah0AomSdztEnYTx36HxeVUq21u5mNeyO0gOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0MlVhG2uDO276YjSOYfoePBxSP0P1tiqlJ5VCrDBxM=;
 b=kRm4UDnDBjpS//1fLWtRBsLdKD2MEO9G0NSASZyDwaE0CEpdddaaeTicKySCJvE87XK5qQ9iuCc8lfo4o3QMpMMrQIqFDawwBrFveDyoIeC0fL+ezH+Z2NIX47gwEGwl6ce4UKEXBXI7slMXKm3785V5h9XVn7hoqbGf0CmXSKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3637.namprd12.prod.outlook.com (2603:10b6:a03:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 14:34:30 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 14:34:30 +0000
Subject: Re: [PATCH v2 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
To: christian.koenig@amd.com, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583339699-11332-1-git-send-email-James.Zhu@amd.com>
 <9d50a60f-0b1d-ad1c-944c-7ff3a7b7cec5@gmail.com>
 <590f2f72-808d-cf35-49ab-2ed476780db0@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <1a6ced0a-5dfd-55ea-1ab2-a9f156c8295a@amd.com>
Date: Thu, 5 Mar 2020 09:34:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <590f2f72-808d-cf35-49ab-2ed476780db0@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 14:34:29 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18d19908-190a-4821-8e55-08d7c112501c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3637:|BYAPR12MB3637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3637B0A385DC7F9A1A3DD248E4E20@BYAPR12MB3637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(36916002)(6486002)(66574012)(26005)(16576012)(16526019)(186003)(53546011)(66946007)(52116002)(2906002)(66556008)(66476007)(5660300002)(31686004)(316002)(478600001)(8936002)(31696002)(2616005)(956004)(81156014)(8676002)(81166006)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3637;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDCwcu4WKVi3boMB6ZW2z1/1M8V0T4Z21Mz5+LOtM7G4lMk1te5gNBGHPIxRAbE7siBTqz9rAFg+Ycxo8Cscb8leqllgAHguhQP/g3j3TvlINwi5oSED7DKVklQcFsM1VRSGyuIZn0o1taIgvILfiKFBGnIi57xZxlISW0hu4G5jdIusute7c4/iU7iu/B7rrMsiEGUDpHUH3r3de2XQpC6xZQmx0xPLfbAs8W1kkYfdii7RDDMLdS3RnyWb2OG0aOgjTUq643aWr2bUVPg4TWnKcOhTojvgyyeSU/NjFpAgb+lnjxPKAa7ygat5Wfg5SQ0jmtyFei/mowbI9ZZxhRCBJU6GZfWsDN+KPTk88iy02T0+RrkD/IquT9kE3Bs22VPyjSG8WsSl0g8NbK9Fv0yFu3BhE/Zh5YU1AIpxAuOpvZCbzj4xh1ug3o30bHbF
X-MS-Exchange-AntiSpam-MessageData: Ztjy7fFtZ7cD+WViPtQANSoVg3qHCRjYlqYxWaLpVag2krtEY4UPLgJiqSdq/CAOUs3EWMyKKC0aPJPv9S28pIt7Qfe1RH2LpGq+xM3oqMoW3oGZIzXn6Gc5fRB8Qt/BjKngy5tb5aIGp3SuxFl1hA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d19908-190a-4821-8e55-08d7c112501c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 14:34:29.7453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 970Gs6tprwliWv5i+8Ob6H34FpV47FBGw8MNk0jvSb9KtydZYLy96lH3N6XUjLnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
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

Ck9uIDIwMjAtMDMtMDUgNjoyNyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA1
LjAzLjIwIHVtIDEyOjI1IHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4gQW0gMDQuMDMuMjAg
dW0gMTc6MzQgc2NocmllYiBKYW1lcyBaaHU6Cj4+PiBGaXggcmFjZSBjb25kaXRpb24gaXNzdWUg
d2hlbiBtdWx0aXBsZSB2Y24gc3RhcnRzIGFyZSBjYWxsZWQuCj4+Pgo+Pj4gdjI6IFJlbW92ZWQg
Y2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKQo+
Pj4gdG8gcHJldmVudCBwb3NzaWJsZSByYWNlcyBoZXJlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6
IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+Cj4+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiBPbmUgdGhpbmcgd29ydGgg
bm90aW5nIGlzIHRoYXQgaW4gdGhlb3J5IHlvdSBjb3VsZCBydW4gaW50byB0aGUgaXNzdWUgCj4g
dGhhdCBvbmUgcmluZyByZXN0YXJ0cyB0aGUgdGltZXIgd2hpbGUgYW5vdGhlciByaW5nIGlzIHN0
aWxsIHByZXBhcmluZyAKPiB0aGUgZW5naW5lIGZvciB1c2FnZS4KClllcywgeW91IGFyZSByaWdo
dCwgVGhlIGN1cnJlbnQgdGltZW91dCBzZXR0aW5nIGlzIDEgc2VjIHRvIGd1YXJhbnRlZSAKb25l
IGRlYy9lbmMgY2FuIGJlIGZpbmlzaGVkIGZvciBhbGwgZm9ybWF0cy7CoCB0aGUgcHJlcGFyaW5n
IHByb2Nlc3MgCnNob3VsZCBudWNoIGxlc3MgdGhhbiB0aGlzIHNldHRpbmcuCgpvdGhlcndpc2Ug
dGhlcmUgYXJlIHNvbWUgb3RoZXIgYnVncyB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkLgoKQnkgdGhl
IHdheSwgbWF5YmUgd2Ugc2hvdWxkbid0IGp1c3QgcmVseSBvbiBmZW5jZSBjaGVjayB0byBkZXRl
cm1pbmUgaWYgCmFueSBqb2IgaXMgbGVmdC4gV2UgY2FuIG1haW50YWluIGEgZGVjL2VuYyBzdWJt
aXNzaW9uIGNvdW50KHBhdGNoIDIgCmFscmVhZHkgYWRkZWQgZm9yIGVuYykuIGhvdyBkbyB5b3Ug
dGhpbms/CgpCZXN0IFJlZ2FyZHMhCgpKYW1lcwoKPgo+IFNvIHRoZSB0aW1lb3V0IHNob3VsZCBi
ZSBsYXJnZSBlbm91Z2ggdG8gZ3VhcmFudGVlIHRoYXQgdGhpcyBuZXZlciAKPiBjYXVzZXMgcHJv
YmxlbXMuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+Pj4gLS0tCj4+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCAxNSArKysrKysrKystLS0tLS0K
Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCB8wqAgMSArCj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
YyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+PiBpbmRl
eCBmOTY0NjRlLi44YTg0MDZiIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmMKPj4+IEBAIC02Myw2ICs2Myw3IEBAIGludCBhbWRncHVfdmNuX3N3X2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+PiDCoMKgwqDCoMKgIGludCBpLCByOwo+Pj4g
wqAgwqDCoMKgwqDCoCBJTklUX0RFTEFZRURfV09SSygmYWRldi0+dmNuLmlkbGVfd29yaywgCj4+
PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKTsKPj4+ICvCoMKgwqAgbXV0ZXhfaW5pdCgm
YWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+IMKgIMKgwqDCoMKgwqAgc3dpdGNoIChhZGV2LT5h
c2ljX3R5cGUpIHsKPj4+IMKgwqDCoMKgwqAgY2FzZSBDSElQX1JBVkVOOgo+Pj4gQEAgLTIxMCw2
ICsyMTEsNyBAQCBpbnQgYW1kZ3B1X3Zjbl9zd19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCDCoMKgwqDCoMKgIHJlbGVhc2VfZmlybXdhcmUo
YWRldi0+dmNuLmZ3KTsKPj4+ICvCoMKgwqAgbXV0ZXhfZGVzdHJveSgmYWRldi0+dmNuLnZjbl9w
Z19sb2NrKTsKPj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoCB9Cj4+PiBAQCAtMzE5
LDEzICszMjEsMTMgQEAgc3RhdGljIHZvaWQgCj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5k
bGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPj4+IMKgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5n
X2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+PiDCoCB7Cj4+PiDCoMKgwqDC
oMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKPj4+IC3CoMKgwqAg
Ym9vbCBzZXRfY2xvY2tzID0gIWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlk
bGVfd29yayk7Cj4+PiDCoCAtwqDCoMKgIGlmIChzZXRfY2xvY2tzKSB7Cj4+PiAtwqDCoMKgwqDC
oMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+PiAtwqDCoMKgwqDCoMKg
wqAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgCj4+PiBBTURf
SVBfQkxPQ0tfVFlQRV9WQ04sCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURf
UEdfU1RBVEVfVU5HQVRFKTsKPj4+IC3CoMKgwqAgfQo+Pj4gK8KgwqDCoCBjYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoJmFkZXYtPnZjbi5pZGxlX3dvcmspOwo+Pj4gKwo+Pj4gK8KgwqDCoCBtdXRl
eF9sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwo+Pj4gK8KgwqDCoCBhbWRncHVfZ2Z4X29m
Zl9jdHJsKGFkZXYsIGZhbHNlKTsKPj4+ICvCoMKgwqAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93
ZXJnYXRpbmdfc3RhdGUoYWRldiwgCj4+PiBBTURfSVBfQkxPQ0tfVFlQRV9WQ04sCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQU1EX1BHX1NUQVRFX1VOR0FURSk7Cj4+PiDCoCDCoMKgwqDCoMKg
IGlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHBnX3BhdXNlX3N0YXRlIG5ld19zdGF0ZTsKPj4+IEBAIC0z
NDUsNiArMzQ3LDcgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCAKPj4+
IGFtZGdwdV9yaW5nICpyaW5nKQo+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPnZjbi5w
YXVzZV9kcGdfbW9kZShhZGV2LCByaW5nLT5tZSwgJm5ld19zdGF0ZSk7Cj4+PiDCoMKgwqDCoMKg
IH0KPj4+ICvCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwo+Pj4g
wqAgfQo+Pj4gwqAgwqAgdm9pZCBhbWRncHVfdmNuX3JpbmdfZW5kX3VzZShzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcpCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5oIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNu
LmgKPj4+IGluZGV4IDZmZTA1NzMuLjJhZTExMGQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4gQEAgLTIwMCw2ICsyMDAsNyBAQCBzdHJ1Y3QgYW1k
Z3B1X3ZjbiB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAKPj4+ICp2
Y25fZGVjX3NjaGVkW0FNREdQVV9NQVhfVkNOX0lOU1RBTkNFU107Cj4+PiDCoMKgwqDCoMKgIHVp
bnQzMl90wqDCoMKgwqDCoMKgwqDCoCBudW1fdmNuX2VuY19zY2hlZDsKPj4+IMKgwqDCoMKgwqAg
dWludDMyX3TCoMKgwqDCoMKgwqDCoMKgIG51bV92Y25fZGVjX3NjaGVkOwo+Pj4gK8KgwqDCoCBz
dHJ1Y3QgbXV0ZXjCoMKgwqDCoMKgwqDCoMKgIHZjbl9wZ19sb2NrOwo+Pj4gwqAgwqDCoMKgwqDC
oCB1bnNpZ25lZMKgwqDCoCBoYXJ2ZXN0X2NvbmZpZzsKPj4+IMKgwqDCoMKgwqAgaW50ICgqcGF1
c2VfZHBnX21vZGUpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pgo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
