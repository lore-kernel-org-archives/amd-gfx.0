Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E530C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 22:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7892465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 22:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MZ3z+qHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7892465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843276F91A;
	Wed, 22 Jan 2020 22:22:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712656F91A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 22:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwGb2Qle6MM2wVIaqVmHwDFkbt9iw8U2OcLKQ0kymMizHqx6CQH/xHgb6okWZhg4YTaHpaBAMz+J+/sYIa9vAyum++jn/aZXBvTyKnmyij6VO9CKbfkNDbWHRrBK+w+prwjydvRoNyfmCPF/+Wiq4ttoJswNwWRq9AbDeCbyG86mcTph2fFM19SusWAKbG+IYEt1dYBymCbTTBZhg7y/Jh1D/+5t+08nGdoZOJSDecIh/IVc1OPf5exZ1c2xJz+FPwJ0lt06Ul2ZlA5YQmwnzOTx145jlb2HDxgRa0PbzsPkAmU63/wJi2QqryMySrvyBvm0sKfF8K0AUs0dfq6NMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AknAVV4UbcT6RyYrDTWaHYB0Ki6K20E+4bbuxTkJUE=;
 b=iCLyY1+sFMTDnt0UCiB2tuRXPwg8NODfYYt+8WCu+B/OMupTmHqheZF6z1eLpkhFbEU67PD9jyyfDWx4aZR/Jvab+S9Y8j6VyEMm0cSBb0wCvRqlCsg0IpDnMy+pN2+Eevt+oQF4fBbceHq4bRWnQflXlS5e+qtx1UyTCqzK1MtnXfrJu7cftvOH2HvYcIuldyget/Re+eIV1OdGAJ6I+M+lEaKWdY2W51LJuaxotF5XFfeReTC3UvCKqKePJ2TDORztE+JujjaubXqnsghPzVGRftFEQrmVgtxTByuDO1zX4sRix26gu8yHp1Atd5HALnnbSpJ9Bo2fEVoYfa94ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AknAVV4UbcT6RyYrDTWaHYB0Ki6K20E+4bbuxTkJUE=;
 b=MZ3z+qHJPwaUiujgaRLzwzVXSGu1kJDe8010JnheSzMwmuPxchCQBolDZs0fBr5rmOkr+wxUpO3Dr27L+zKXe3/g2xOMDGF46h7yYxQ09E+r6KkMiylE3ja4KkdzfQVpHtrqhbbonplcUj2lRwqAI1Ts+KcvN6PCwXKJrMyH3m0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (10.174.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Wed, 22 Jan 2020 22:22:32 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 22:22:32 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: allow higher level PD invalidations
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org
References: <20200122140303.14411-1-christian.koenig@amd.com>
 <20200122140303.14411-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4146d693-86bf-2b07-6eec-a6f8731f53c8@amd.com>
Date: Wed, 22 Jan 2020 17:22:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200122140303.14411-2-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::37) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 22 Jan 2020 22:22:32 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be2ee31f-6396-4740-ffa0-08d79f8992f6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:|DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020370815555E1AB15A507DA920C0@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(31686004)(186003)(16526019)(26005)(66476007)(478600001)(66946007)(5660300002)(2906002)(956004)(2616005)(44832011)(6486002)(66556008)(36756003)(316002)(53546011)(16576012)(36916002)(8676002)(86362001)(8936002)(81166006)(31696002)(81156014)(66574012)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0203;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTuPqVYst1CHtLePqxXktTKnpZdHMMgCc/wgGSp1VvaCG4Bl/r4ONPVnM/ec0gTDSZKjqPLvEITIM0rYM2qZUbNx9wgqxcevWvRXRHpeEAzNEej5RcbZUxa+NcpvMpJs9mrPZ4A1Kw+Nd4BAaLgSAaPJbxTPVCoYwfiGTsNIpnXpqutIF2XDi2caQwVszDVcuffYqIHqonZ6w1X9H4Iiyz8TxTJtfkFWoUYXupMUMgnjowB+saW4DMq9+VZAQrkkQRIxC4QLKMq4Vspf6PRKytLGriyS7GVKOsWkEBDFesuLgGrrCuRqLY+fDxa7p6XT0J3LSd3MRCiJe9fnoRrlo4ksBZV9axhqrVIqen4q0UdRpuqHu+s2eZEefi9adYGflbSZGyajji5RVhOtYh3Kj13vw5XZJlLDqmHUlEUeRxB3Fcxwh1S3PbjI+c3B/A1q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2ee31f-6396-4740-ffa0-08d79f8992f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 22:22:32.3680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+8ozHjQZIwhZe3HRUVFYN5/N1FtX/iLPo6CwSJlTF8sor1wNVpjzcdN3esL/Km2QL9ifUcK/BZin368X3X0Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

VHdvIHN0eWxlIG5pdC1waWNrcyBpbmxpbmUuIE90aGVyd2lzZSB0aGUgc2VyaWVzIGlzCgpSZXZp
ZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpPbiAyMDIw
LTAxLTIyIDk6MDMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbGxvdyBwYXJ0aWFs
IGludmFsaWRhdGlvbiBvbiB1bmFsbG9jYXRlZCBQRHMuIFRoaXMgaXMgdXNlZnVsIHdoZW4gd2UK
PiBuZWVkIHRvIHNpbGVuY2UgZmF1bHRzIHRvIHN0b3AgaW50ZXJydXB0IGZsb29kcyBvbiBWZWdh
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMg
fCAyMyArKysrKysrKysrKysrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwo+IGluZGV4IDgxMTlmMzJjYTk0ZC4uMGY3OWMxNzExOGJmIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMTQ2Nyw5ICsxNDY3LDggQEAgc3Rh
dGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFy
YW1zICpwYXJhbXMsCj4gICAJCQkgKiBzbWFsbGVyIHRoYW4gdGhlIGFkZHJlc3Mgc2hpZnQuIEdv
IHRvIHRoZSBuZXh0Cj4gICAJCQkgKiBjaGlsZCBlbnRyeSBhbmQgdHJ5IGFnYWluLgo+ICAgCQkJ
ICovCj4gLQkJCWlmICghYW1kZ3B1X3ZtX3B0X2Rlc2NlbmRhbnQoYWRldiwgJmN1cnNvcikpCj4g
LQkJCQlyZXR1cm4gLUVOT0VOVDsKPiAtCQkJY29udGludWU7Cj4gKwkJCWlmIChhbWRncHVfdm1f
cHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkKPiArCQkJCWNvbnRpbnVlOwo+ICAgCQl9IGVs
c2UgaWYgKGZyYWcgPj0gcGFyZW50X3NoaWZ0KSB7Cj4gICAJCQkvKiBJZiB0aGUgZnJhZ21lbnQg
c2l6ZSBpcyBldmVuIGxhcmdlciB0aGFuIHRoZSBwYXJlbnQKPiAgIAkJCSAqIHNoaWZ0IHdlIHNo
b3VsZCBnbyB1cCBvbmUgbGV2ZWwgYW5kIGNoZWNrIGl0IGFnYWluLgo+IEBAIC0xNDgwLDggKzE0
NzksMTkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92
bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gICAJCX0KPiAgIAo+ICAgCQlwdCA9IGN1cnNvci5l
bnRyeS0+YmFzZS5ibzsKPiAtCQlpZiAoIXB0KQo+IC0JCQlyZXR1cm4gLUVOT0VOVDsKPiArCQlp
ZiAoIXB0KSB7Cj4gKwkJCS8qIFdlIG5lZWQgYWxsIFBEcyBhbmQgUFRzIGZvciBtYXBwaW5nIHNv
bWV0aGluZywgKi8KPiArCQkJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkKPiArCQkJCXJl
dHVybiAtRU5PRU5UOwo+ICsKPiArCQkJLyogYnV0IHVubWFwcGluZyBzb21ldGhpbmcgY2FuIGhh
cHBlbiBhdCBhIGhpZ2hlcgo+ICsJCQkgKiBsZXZlbC4gKi8KCk5pdC1waWNrOiBUaGlzIGNvbW1l
bnQgd291bGQgdXBzZXQgY2hlY2twYXRjaC5wbC4KCgo+ICsJCQlpZiAoIWFtZGdwdV92bV9wdF9h
bmNlc3RvcigmY3Vyc29yKSkKPiArCQkJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCQkJcHQgPSBj
dXJzb3IuZW50cnktPmJhc2UuYm87Cj4gKwkJCXNoaWZ0ID0gcGFyZW50X3NoaWZ0Owo+ICsJCX0K
PiAgIAo+ICAgCQkvKiBMb29rcyBnb29kIHNvIGZhciwgY2FsY3VsYXRlIHBhcmFtZXRlcnMgZm9y
IHRoZSB1cGRhdGUgKi8KPiAgIAkJaW5jciA9ICh1aW50NjRfdClBTURHUFVfR1BVX1BBR0VfU0la
RSA8PCBzaGlmdDsKPiBAQCAtMTQ5NSw2ICsxNTA1LDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1f
dXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gICAJ
CQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+ICAgCQkJdW5z
aWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+ICAgCj4gKwkJ
CS8qIFRoaXMgY2FuIGhhcHBlbiB3aGVuIHdlIHNldCBoaWdoZXIgbGV2ZWwgUERzIHRvCj4gKwkJ
CSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4gKi8KClNhbWUgYXMgYWJvdmUuCgoKPiAr
CQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPiAgIAkJCWFtZGdwdV92bV91cGRhdGVfZmxhZ3Mo
cGFyYW1zLCBwdCwgY3Vyc29yLmxldmVsLAo+ICAgCQkJCQkgICAgICAgcGVfc3RhcnQsIGRzdCwg
bnB0ZXMsIGluY3IsCj4gICAJCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFn
KSk7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
