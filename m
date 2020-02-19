Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDA6C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D69A24656
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O/5AsCnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D69A24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B8D6E81A;
	Wed, 19 Feb 2020 15:07:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770083.outbound.protection.outlook.com [40.107.77.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F8A6E81A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgoxdIgscrQQJwHYftcVRIai3ogVHzzHP/jsb4cxDp52WyyDO488W9X9SOaZOANEQVYW9Es7Y546gOjjKYhj6YE/0xYjc4h7/v9MjsXqOAISuqbfM0O8x0OVCpEqOGo478l1BCRWH4qYFGHUM6hTFV4EknHCciferjwNLz226sSVL4YM6kN+UeI9Az7wh6nPrxk/Wz16C+OPkaWB4CdqgNB15n9ZObpycTyNpPXIzGlkDncXOPS/l5xL/O3FRbAZB4tYEK5cAl0hQezwNePKx5ToYOn8Qb8EYYTorOIH5jeqO9jUAUNjvKMlbVyEueZ37guP0CaCtSbFzHObo5S5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5tb167XSnHGDHsLTpkEpADQesJ6mYqLKwZ5C+SaLj8=;
 b=NjeZ61e5NGjklZFJx8kKGbSSETjLdDmTv33eZ9JO0spk1t4smTXw1UoBfphV/j0V25cHPFr7XVekEmPHGN+qDLLURTjc1QMI26imHYA90lafRT2AuOILzr3uWt43YXX2HwxQsdldGI+KnltKdLrPtl8hlNaQ37/or+yWlrZ73qqW9VBj4qs329Jq114hQl/WPZf1rzKfruIH1KpIKPAvti0qjtqHrt9p25qiM2DaRTNtZQ9dQSEkHARDzXybOszCq2c4e5+AuHRQpvzmDz/5XBDBp116pxeT8IsLXcCttpRWv416RNb2Cr/K37+XDfdmtA8SH0dIkAl9F7NdpXzgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5tb167XSnHGDHsLTpkEpADQesJ6mYqLKwZ5C+SaLj8=;
 b=O/5AsCncc5Tb5/Ox7V0CPw98dJ/42gRSjvFffWA26EIqoAlJRyclTGnNkcclDhJ2JQIe5jbKBfu2HcN5+9aq50Sa9dYOB+yE++zYx3ABElqPZUfjKLho6KkIryG+LvjtGi37VbRp/atywIEhBlv7UlCRS4lI3FjK2mqpqgs4yf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB4240.namprd12.prod.outlook.com (52.135.48.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 15:07:52 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:07:52 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
From: Tom St Denis <tom.stdenis@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 luben.tuikov@amd.com, Marek.Olsak@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
 <9c523b06-c952-d682-8347-c3bc29cd0e4a@amd.com>
Message-ID: <d587dc0c-6ced-1f46-30bf-341b2f3f0007@amd.com>
Date: Wed, 19 Feb 2020 10:07:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <9c523b06-c952-d682-8347-c3bc29cd0e4a@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Wed, 19 Feb 2020 15:07:51 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f03bfd4f-8319-4552-655c-08d7b54d7d89
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:|MN2PR12MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4240FA20DBB98C05DEAED92FF7100@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(8676002)(66556008)(31696002)(81166006)(15650500001)(66574012)(36756003)(31686004)(81156014)(8936002)(5660300002)(6486002)(66476007)(86362001)(2906002)(2616005)(316002)(186003)(6512007)(52116002)(53546011)(16526019)(6506007)(956004)(66946007)(478600001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4240;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bREWzm7qOLIJBHdo/YI4Uf91nDZRkCe89sGAy9uf9ioRxfAhQGDoSEGnwDjVSRrmjRIDPWvmx6TylCsB2MWLfazSczgpyiTEwayCOyq9YYZBH6l8wFtexCpm6hjURjLI+al7y6zyanhsBsLatuU/kn+uaiNXWXF7bx6Le8PwOGbciZdSnvfQx0u+uiQvDMTEXftzprTrUzL2MH41NKHZ4V16r6UjNZyTy55C37TRQawYWfNMbOQxsEJhTMOx5IKbHCjoGcw2vB3NvG9f2wBvXH0+KISrLZ/qVw2aLCMdfATNT2kQQ78QM7Oiz5eYeGJFpUKw7Y/pdtAB5YF+BKcM8NAE7mzPmP0HzyxwfGaP2KwUzfy2udC/ncTIq2QsSqdrFOKqLK1V8XG8FcUIWK/c2S8jJtOgCnUr2w1sRwLRXJY01oy02KDnoyWQ0sD2pdOe
X-MS-Exchange-AntiSpam-MessageData: H6QsdiUFyIWaJraBcQSllW401WJIr3Cb3P6lgzu2LjErvNaWzEMvMASGhdaFV7ps8cPCJ/cydCE2l4lyiglBHUhNcNY7NtjOAQX8hOYZ6DzDqIx1BSF+hSD+1cpkbn/BbK1YdDSddlDAC/16boGuIQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03bfd4f-8319-4552-655c-08d7b54d7d89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:07:52.1878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAZnc6UP13sEQWKbeDIYFeKdNtl22azhOOOi2Ow5a56zBM0d1k+6MCEJemvqbYtXX/9J7nSy4nJXanN1NSlqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

SWdub3JlIHRoYXQgbXkgYnJhaW4gd2Fzbid0IGVuZ2FnZWQgaW4gdGhlIHByb2Nlc3MuwqAgSXQn
cyBjbGVhciB3aGVyZSAKeW91IHdhbnRlZCB0aGUgcHJlcGFyZSBjYWxsLgoKClRvbQoKT24gMjAy
MC0wMi0xOSAxMDowNiBhLm0uLCBUb20gU3QgRGVuaXMgd3JvdGU6Cj4gSSBnZXQgdGhpcyBjb25m
bGljdCBvbiB0b3Agb2YgZHJtLW5leHQKPgo+ICsrPDw8PDw8PCBIRUFECj4gwqArwqDCoMKgwqDC
oCByID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCByZXN2LCBzeW5jX21vZGUp
Owo+ICsrPT09PT09PQo+ICvCoMKgwqDCoMKgwqAgaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJ
RCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKnJv
b3QgPSB2bS0+cm9vdC5iYXNlLmJvOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fZmVuY2Uocm9v
dCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib19mZW5j
ZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0cnVlKTsKPiArwqDCoMKgwqDCoMKgIH0KPiArCj4g
K8KgwqDCoMKgwqDCoCByID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25l
ciwgZXhjbHVzaXZlKTsKPiArKz4+Pj4+Pj4gZHJtL2FtZGdwdTogYWRkIFZNIHVwZGF0ZSBmZW5j
ZXMgYmFjayB0byB0aGUgcm9vdCBQRCB2Mgo+Cj4gU2hvdWxkIEkga2VlcCB0aGUgcHJlcGFyZSBj
YWxsIGJlZm9yZSBvciBhZnRlciB5b3VyIGJsb2NrPwo+Cj4gVG9tCj4KPiBPbiAyMDIwLTAyLTE5
IDEwOjAyIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFkZCB1cGRhdGUgZmVuY2Vz
IHRvIHRoZSByb290IFBEIHdoaWxlIG1hcHBpbmcgQk9zLgo+Pgo+PiBPdGhlcndpc2UgUERzIGZy
ZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3b24ndCB3YWl0IGZvcgo+PiB1cGRhdGVzIHRvIGZpbmlz
aCBhbmQgY2FuIGNhdXNlIGNvcnJ1cHRpb25zLgo+Pgo+PiB2MjogcmViYXNlZCBvbiBkcm0tbWlz
Yy1uZXh0Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPj4gRml4ZXM6IDkwYjY5Y2RjNWYxNTkgZHJtL2FtZGdwdTogc3RvcCBh
ZGRpbmcgVk0gdXBkYXRlcyBmZW5jZXMgdG8gdGhlIAo+PiByZXN2IG9iago+PiAtLS0KPj4gwqAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxNCArKysrKysrKysrKyst
LQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
IAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IGluZGV4IGQx
NjIzMWQ2YTc5MC4uZWY3M2ZhOTRmMzU3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+PiBAQCAtNTg4LDggKzU4OCw4IEBAIHZvaWQgYW1kZ3B1X3ZtX2dldF9w
ZF9ibyhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPj4gwqAgewo+PiDCoMKgwqDCoMKgIGVudHJ5LT5w
cmlvcml0eSA9IDA7Cj4+IMKgwqDCoMKgwqAgZW50cnktPnR2LmJvID0gJnZtLT5yb290LmJhc2Uu
Ym8tPnRibzsKPj4gLcKgwqDCoCAvKiBPbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9i
ICovCj4+IC3CoMKgwqAgZW50cnktPnR2Lm51bV9zaGFyZWQgPSAyOwo+PiArwqDCoMKgIC8qIFR3
byBmb3IgVk0gdXBkYXRlcywgb25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhlIENTIGpvYiAqLwo+
PiArwqDCoMKgIGVudHJ5LT50di5udW1fc2hhcmVkID0gNDsKPj4gwqDCoMKgwqDCoCBlbnRyeS0+
dXNlcl9wYWdlcyA9IE5VTEw7Cj4+IMKgwqDCoMKgwqAgbGlzdF9hZGQoJmVudHJ5LT50di5oZWFk
LCB2YWxpZGF0ZWQpOwo+PiDCoCB9Cj4+IEBAIC0xNTkxLDYgKzE1OTEsMTYgQEAgc3RhdGljIGlu
dCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICph
ZGV2LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxvY2s7Cj4+IMKgwqDCoMKg
wqAgfQo+PiDCoCArwqDCoMKgIGlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsKPj4gK8Kg
wqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5iYXNlLmJvOwo+
PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFz
dF9kaXJlY3QpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fZmVuY2Uocm9v
dCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFk
bWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0cnVlKTsK
Pj4gK8KgwqDCoCB9Cj4+ICsKPj4gwqDCoMKgwqDCoCByID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJl
cGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVzaXZlKTsKPj4gwqDCoMKgwqDCoCBpZiAocikKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3JfdW5sb2NrOwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
