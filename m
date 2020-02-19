Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B14C34022
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 21:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CC924654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 21:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vY2WmNJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CC924654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B23F6E87B;
	Wed, 19 Feb 2020 21:40:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DED6E87B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 21:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBxEmtGzY5yzbNX6HLlqkXaiJ9c5InoeRxK7UueHfArS/hhayCYmKpNK9xiJdbdwPZJU5peSVgEm2vi8sD2ZyUCAKdwrWqeyv97bPCzSmFeDnMtMk20nJlnNF0Srmi6ypRokEUDjjMbKyj2FBRov0s8PW8YiBN4ZnllWMk/UnZEFicR58zWGYurKpTfqqJembjumcPPPCRXIwAZ9UYVpAH3pzqKS53OHWiER8pQTAE8VYzS19VbBDuirZj7EGp9XxECr8YVvXo7SYpU/GVbsIXU82Sn8PzsCqboa0Tf/haLwv+OhZhIJlifohReoM38NXVGd3OY24cZQRE5ntiBRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR8I9hOrjVvv/egCvJWM5m/saLDAf6HA5r+sPcq4Pnw=;
 b=llOU/fg2YUzIJNy0gqkX/KeALU9Isyeyvwy4MiZfQq6zzvPjlyrzHr81cq/9sLYwwyvhzT143DzRLCfbRK0N2ciOiyhjubL3RMqPgs/RudA4Iwl+eDtOg8lsajNQfaE7vpmIgAxLGFDN0XbR5sWtmf5Tj5XTmXG2URRUXbkADuwDJHNKHoZf9G7WAp3JnKZ31FRmhFFndBsEoJG8ttM/GZdk8GeWNft8bBc7nHseYbVvgdtQ7T+jZznFwlsfjzeab2T7t2dte1qH69bDcCdnQUfnLp708fCjYoZZcxsQIUAAj+w5k/BjONomF2+EaelAQ0z35n5fGpP2JBWkhDQc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR8I9hOrjVvv/egCvJWM5m/saLDAf6HA5r+sPcq4Pnw=;
 b=vY2WmNJs8fYYaBzc2/lfdeFlTu8iDuqPd7TIbRMkVGej0wk1CaHxKS69S0oFXog+O1xnVzsLERtipSzw4mKiGJsAji4R1gS8WUy5AhSYAL6RWSe21GeUUAnsdysJbvLv8GORNlCgvJQiAHzrY2wcKOeFmBUnCoKQeY2LkhUhBLA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3836.namprd12.prod.outlook.com (10.255.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 21:40:36 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 21:40:30 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD
To: christian.koenig@amd.com, Tom St Denis <tom.stdenis@amd.com>,
 Marek.Olsak@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200219142014.25386-1-christian.koenig@amd.com>
 <1fde8a92-0b9b-4b0a-e319-7b407810d36c@amd.com>
 <45c48a55-9374-78ea-4bbc-a2c564ca5001@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2373cc05-185b-9738-8613-2383556c891b@amd.com>
Date: Wed, 19 Feb 2020 16:40:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <45c48a55-9374-78ea-4bbc-a2c564ca5001@gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 21:40:29 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba2b609b-7d1f-4951-c845-08d7b584571e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:|DM6PR12MB3836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3836AB626059A3285F7A85AC99100@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(5660300002)(15650500001)(44832011)(31696002)(31686004)(36756003)(478600001)(26005)(66574012)(8936002)(16526019)(186003)(81156014)(956004)(66946007)(2616005)(6512007)(316002)(66556008)(86362001)(6486002)(2906002)(52116002)(81166006)(53546011)(6506007)(8676002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3836;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7hsp412oc/RYhU+JO3ynZ6T3gLAjLxT5V3ts55RQsNTKETtLMG5vUFH2DZdU6DXzCl2HGRRh3RAH8cuVlppfBhUhAZPWinlWh91vdhJJxedJMrZHXclKNggEE4oJP9Ux0jz7uiUBocay5PdGZC8z4njn85Ba/JbV9obB542mTeuTn4U8Lm12Y26W4Pw6f4qJkFMDnEw/tk8yassO1lGuFiWggEd81EuoUKtNxXznCNFFNCBZ8ZzVny8RCOCaut09oJbATgAXwQs8uPcG6SJQiKt7NqRGtE/YzzT+3aEEtQZ3MgvHrvLgxbgKgl0B3KtwhRdMxvNr1aDioseDH93nQKRITjPq6vVA8gWuMupa4Na1wq8pfJbo30j89v2i0g5A4v7GRURjiGhrOnNZ/Q46UmZWf6FHXrTuS93swV6Aml1dNPfyAky+k00Ux6kdmaY
X-MS-Exchange-AntiSpam-MessageData: bWVg1C4AQzjAw1/3c0ikqq1iEGp5qyf8u3Yl9K7iniiQ5QaOu9yKWgNUd++iyVg6fXi4jlFrYAF9YvpBwSqRFTRtBXd4a788XMZTyMJuvRiY9uov6OJ5F/Ufjva+zPSczDkzQPuP5ZLgll5f+h3vrQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2b609b-7d1f-4951-c845-08d7b584571e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 21:40:30.5715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqYS3HrC3ltOgEV0oMvpFwy4dciqvzg6FI3zP6yz2P0UR6e2Lk98rMZy0H+H/tj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0xOSA5OjQ0IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2VsbCBp
dCBzaG91bGQgYXBwbHkgb24gdG9wIG9mIGFtZC1zdGFnaW5nLWRybS1uZXh0LiBCdXQgSSBoYXZl
bid0IAo+IGZldGNoZWQgdGhhdCB0b2RheSB5ZXQuCj4gCj4gR2l2ZSBtZSBhIG1pbnV0ZSB0byBy
ZWJhc2UuCgpUaGlzIHBhdGNoIHNlZW1zIHRvIGhhdmUgZml4ZWQgdGhlIHJlZ3Jlc3Npb24gd2Ug
c2F3IHllc3RlcmRheS4KSXQgYXBwbGllcyB0byBhbWQtc3RhZ2luZy1kcm0tbmV4dCB3aXRoIGEg
c21hbGwgaml0dGVyOgoKJHBhdGNoIC1wMSA8IC90bXAvXFtQQVRDSFxdXCBkcm1fYW1kZ3B1XDpc
IGFkZFwgVk1cIHVwZGF0ZVwgZmVuY2VzXCBiYWNrXCB0b1wgdGhlXCByb290XCBQRC5lbWwgCnBh
dGNoaW5nIGZpbGUgYW1kZ3B1X3ZtLmMKSHVuayAjMiBzdWNjZWVkZWQgYXQgMTU5OSAob2Zmc2V0
IC0yMCBsaW5lcykuCgpJJ3ZlIGJlZW4gcnVubmluZyAnZ2x4Z2VhcnMnIG9uIHRoZSByb290IHdp
bmRvdyBhbmQgJ3BpbmlvbicKYW5kIG5vIHByb2JsZW1zLS1jbGVhbiBsb2cuCgpUZXN0ZWQtYnk6
IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+CgpSZWdhcmRzLApMdWJlbgoKPiAK
PiBDaHJpc3RpYW4uCj4gCj4gQW0gMTkuMDIuMjAgdW0gMTU6Mjcgc2NocmllYiBUb20gU3QgRGVu
aXM6Cj4+IFRoaXMgZG9lc24ndCBhcHBseSBvbiB0b3Agb2YgN2ZkM2I2MzJlMTdlNTVjNWZmZDAw
OGY5ZjAyNTc1NGU3ZGFhMWI2NiAKPj4gd2hpY2ggaXMgdGhlIHRpcCBvZiBkcm0tbmV4dAo+Pgo+
Pgo+PiBUb20KPj4KPj4gT24gMjAyMC0wMi0xOSA5OjIwIGEubS4sIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4+PiBBZGQgdXBkYXRlIGZlbmNlcyB0byB0aGUgcm9vdCBQRCB3aGlsZSBtYXBwaW5n
IEJPcy4KPj4+Cj4+PiBPdGhlcndpc2UgUERzIGZyZWVkIGR1cmluZyB0aGUgbWFwcGluZyB3b24n
dCB3YWl0IGZvcgo+Pj4gdXBkYXRlcyB0byBmaW5pc2ggYW5kIGNhbiBjYXVzZSBjb3JydXB0aW9u
cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgMTQgKysrKysrKysrKysrLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IGluZGV4IGU3YWIwYzFlMjc5My4uZGQ2M2NjZGJhZDJh
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+PiBAQCAt
NTg1LDggKzU4NSw4IEBAIHZvaWQgYW1kZ3B1X3ZtX2dldF9wZF9ibyhzdHJ1Y3QgYW1kZ3B1X3Zt
ICp2bSwKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgZW50cnktPnByaW9yaXR5ID0gMDsKPj4+IMKg
wqDCoMKgwqAgZW50cnktPnR2LmJvID0gJnZtLT5yb290LmJhc2UuYm8tPnRibzsKPj4+IC3CoMKg
wqAgLyogT25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhlIENTIGpvYiAqLwo+Pj4gLcKgwqDCoCBl
bnRyeS0+dHYubnVtX3NoYXJlZCA9IDI7Cj4+PiArwqDCoMKgIC8qIFR3byBmb3IgVk0gdXBkYXRl
cywgb25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhlIENTIGpvYiAqLwo+Pj4gK8KgwqDCoCBlbnRy
eS0+dHYubnVtX3NoYXJlZCA9IDQ7Cj4+PiDCoMKgwqDCoMKgIGVudHJ5LT51c2VyX3BhZ2VzID0g
TlVMTDsKPj4+IMKgwqDCoMKgwqAgbGlzdF9hZGQoJmVudHJ5LT50di5oZWFkLCB2YWxpZGF0ZWQp
Owo+Pj4gwqAgfQo+Pj4gQEAgLTE2MTksNiArMTYxOSwxNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92
bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgCj4+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3JfdW5sb2NrOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+
PiDCoCArwqDCoMKgIGlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsKPj4+ICvCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKPj4+ICsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9k
aXJlY3QpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX2ZlbmNlKHJvb3Qs
IHZtLT5sYXN0X2RpcmVjdCwgdHJ1ZSk7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFk
bWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSk7
Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+IMKgwqDCoMKgwqAgciA9IHZtLT51cGRhdGVfZnVuY3Mt
PnByZXBhcmUoJnBhcmFtcywgcmVzdiwgc3luY19tb2RlKTsKPj4+IMKgwqDCoMKgwqAgaWYgKHIp
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxvY2s7Cj4gCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
