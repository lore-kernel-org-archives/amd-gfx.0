Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D1DC34050
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20EC208C4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gkNSTmBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20EC208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D636E7FA;
	Wed, 19 Feb 2020 15:06:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0E06E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHDHvSd/zis5HHQQf0LFNsQaXOadKZvasVjhNo8uAocHNdVPT1lADEujFuYrn+zEGoX49GpwEr0CAgiRslghqH0EHKtYLqEhRcZWIRGJRfu3E+AKGZ6Ex5K0lWB6G797d760M2v9g9qUF+AFCCf9pR+VFLTd9yUozi1k60newW1iUY+zGoHXTM68N8kNIcsPPz8DK3Y/3rR5RbJJPDGWXmMm4RYu2s+IbDDvecerLf/TTvqkVjSyJi65aMjDrX+yQQjj2dObB0uYfhH3AquPcGFO8u14tP8qpdoXv3ktgZCdDK24epRBUqWvmKYQQ9IMb8qOZQtF4n4qt2yyK41ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgyuGCbGkSNK7TxRWlqRrUI5dDBjrU8v/WY0bJkGbEQ=;
 b=X2sN3IiogMjmA7wfNTrVjtJp+xIVRPozvFKKJTQx03D7OwF1+os1M4oYE6h3qO4mK4V8YXdY+2DIKARZLdVE11SpXC2X5py8plEjMo2nNnqlg7fhC12wbD81q0kY+O1ysih9AG3NgarmwVDpyn4OrEosW9Mup9TMwR1gPkaYREQsTerNhxvNA0ylxar7s7tVw5QAWsgt14Rtz0gBXfFgnbCJmF7L/s267waJjTG5LUNyAZDV2gdjJuoGACVzpKEeSWC2ICIaf/fmN1wRIx7gmic9IqpXiLCRMj7PoE0+b74m8qLItPL7V4rZP66Js/TP0cb7ihCnCALqf7q/Ejj8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgyuGCbGkSNK7TxRWlqRrUI5dDBjrU8v/WY0bJkGbEQ=;
 b=gkNSTmBm2RvCOO5CpGqFZcb+lBQJjy0xz4C4M++38X1iqwnAPYqZ/P0yypKHnGi0eFSCo2Jp39JB6V1tDDmmEoRkWRqWrmwjSEln/fIn3Qx+rC8V0/+7HgaAXNjkAeT06rJM4/iFjhbasVPLN0geKDdnspshFVnpVI16Vk0sSCM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB4240.namprd12.prod.outlook.com (52.135.48.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 15:06:21 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:06:21 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 luben.tuikov@amd.com, Marek.Olsak@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <9c523b06-c952-d682-8347-c3bc29cd0e4a@amd.com>
Date: Wed, 19 Feb 2020 10:06:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200219150251.123917-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.84.11) by
 MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 15:06:20 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f5b16af-424f-47c6-af28-08d7b54d473e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:|MN2PR12MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB424039B8A87452F6C9288922F7100@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
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
X-Microsoft-Antispam-Message-Info: lPdNHYUMIKY+9o6d4pzuKW/BKo6jx2C4mbkj83MY9m2oaz8qXVbs30TVFsdOwr09ioWwoucfWdyRx4B708/wFC3Fn6BRoM+wcq/x4dHBJeGv6shvUAlYjkxS3vKhpifAiYJyDW4TnvY794cp7sSQKelWHL5rtCMBu0E7hKdjcRAM9RxmB33TibivFZFBNl7h17K/1PY8JZdt4fMEVd0mF7aX6bppq0Uwzhob4nnb8/FGRfipwwjaWv83/b1IQNwdrK5vi70o/T5K8etKGE6kLTN7vwmZ8atwU4bZCb2OjQpkkMoybyGxX7Pe1QRIDI2ORCKl/cc26bNkMEqLTbEJcBeGsATeT/rC6zTwPDu54rGUcsVFaKJt4hU8M7kWTBCigbflcQZQ9ttLPt2PAGUc7/hlBga+6oJ9UnFeaIeV+HAb9OfuQPMPq7GjjfqR2MWk
X-MS-Exchange-AntiSpam-MessageData: i1L1Rfip3nJ1sHom2v5umDyKHcM3ydDLmVepbva8uBd1ye4o9WknC+0yv3lFdOHI7K8fh1NX7jksldPlb+dqy0wUw9VHofM6fK7EvbxM97qS9xmo+q7T2dD7J/U3zaC5v7Z/nv/3HpYB70NOcYZPEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5b16af-424f-47c6-af28-08d7b54d473e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:06:21.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhRdSCuYZ5GTUWIOihHOiJditFUHQ3VcyBTGDqJsgJBRH9lV+VR5EIWZedDzrPzXHxG1JT2UfNSWBa8CZhxRoQ==
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

SSBnZXQgdGhpcyBjb25mbGljdCBvbiB0b3Agb2YgZHJtLW5leHQKCisrPDw8PDw8PCBIRUFECiDC
oCvCoMKgwqDCoMKgIHIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5wcmVwYXJlKCZwYXJhbXMsIHJlc3Ys
IHN5bmNfbW9kZSk7CisrPT09PT09PQorwqDCoMKgwqDCoMKgIGlmIChmbGFncyAmIEFNREdQVV9Q
VEVfVkFMSUQpIHsKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9i
byAqcm9vdCA9IHZtLT5yb290LmJhc2UuYm87CisKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib19mZW5jZShyb290
LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUpOworCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RlbGF5ZWQpKQorwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX2ZlbmNlKHJvb3Qs
IHZtLT5sYXN0X2RlbGF5ZWQsIHRydWUpOworwqDCoMKgwqDCoMKgIH0KKworwqDCoMKgwqDCoMKg
IHIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5wcmVwYXJlKCZwYXJhbXMsIG93bmVyLCBleGNsdXNpdmUp
OworKz4+Pj4+Pj4gZHJtL2FtZGdwdTogYWRkIFZNIHVwZGF0ZSBmZW5jZXMgYmFjayB0byB0aGUg
cm9vdCBQRCB2MgoKU2hvdWxkIEkga2VlcCB0aGUgcHJlcGFyZSBjYWxsIGJlZm9yZSBvciBhZnRl
ciB5b3VyIGJsb2NrPwoKVG9tCgpPbiAyMDIwLTAyLTE5IDEwOjAyIGEubS4sIENocmlzdGlhbiBL
w7ZuaWcgd3JvdGU6Cj4gQWRkIHVwZGF0ZSBmZW5jZXMgdG8gdGhlIHJvb3QgUEQgd2hpbGUgbWFw
cGluZyBCT3MuCj4KPiBPdGhlcndpc2UgUERzIGZyZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3b24n
dCB3YWl0IGZvcgo+IHVwZGF0ZXMgdG8gZmluaXNoIGFuZCBjYW4gY2F1c2UgY29ycnVwdGlvbnMu
Cj4KPiB2MjogcmViYXNlZCBvbiBkcm0tbWlzYy1uZXh0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gRml4ZXM6IDkwYjY5Y2Rj
NWYxNTkgZHJtL2FtZGdwdTogc3RvcCBhZGRpbmcgVk0gdXBkYXRlcyBmZW5jZXMgdG8gdGhlIHJl
c3Ygb2JqCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8
IDE0ICsrKysrKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
aW5kZXggZDE2MjMxZDZhNzkwLi5lZjczZmE5NGYzNTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC01ODgsOCArNTg4LDggQEAgdm9pZCBhbWRncHVfdm1f
Z2V0X3BkX2JvKHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAgewo+ICAgCWVudHJ5LT5wcmlvcml0
eSA9IDA7Cj4gICAJZW50cnktPnR2LmJvID0gJnZtLT5yb290LmJhc2UuYm8tPnRibzsKPiAtCS8q
IE9uZSBmb3IgVFRNIGFuZCBvbmUgZm9yIHRoZSBDUyBqb2IgKi8KPiAtCWVudHJ5LT50di5udW1f
c2hhcmVkID0gMjsKPiArCS8qIFR3byBmb3IgVk0gdXBkYXRlcywgb25lIGZvciBUVE0gYW5kIG9u
ZSBmb3IgdGhlIENTIGpvYiAqLwo+ICsJZW50cnktPnR2Lm51bV9zaGFyZWQgPSA0Owo+ICAgCWVu
dHJ5LT51c2VyX3BhZ2VzID0gTlVMTDsKPiAgIAlsaXN0X2FkZCgmZW50cnktPnR2LmhlYWQsIHZh
bGlkYXRlZCk7Cj4gICB9Cj4gQEAgLTE1OTEsNiArMTU5MSwxNiBAQCBzdGF0aWMgaW50IGFtZGdw
dV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJ
Z290byBlcnJvcl91bmxvY2s7Cj4gICAJfQo+ICAgCj4gKwlpZiAoZmxhZ3MgJiBBTURHUFVfUFRF
X1ZBTElEKSB7Cj4gKwkJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IHZtLT5yb290LmJhc2UuYm87
Cj4gKwo+ICsJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RpcmVjdCkpCj4g
KwkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUpOwo+ICsKPiAr
CQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kZWxheWVkKSkKPiArCQkJYW1k
Z3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RlbGF5ZWQsIHRydWUpOwo+ICsJfQo+ICsKPiAg
IAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVzaXZl
KTsKPiAgIAlpZiAocikKPiAgIAkJZ290byBlcnJvcl91bmxvY2s7Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
