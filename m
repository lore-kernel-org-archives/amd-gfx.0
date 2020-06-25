Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD042C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7B22089D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P49St2XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7B22089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5944A89FF7;
	Thu, 25 Jun 2020 15:58:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED5789FF7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdUlLGoQrMjE2iis2Dd4lUp5QQgc79sKRO7TRVDUdj1p2xD1iKe7aEivZrAmFOHZQgZc6ciSsi2fwvL44D6dqIpQQxSXe8vsjO5YJVIO2amQmK+FZolBehFoIr1kpwLXFJb7OM37fbSUiWabtReqkAX+4LYdAuWxT5Tbm6TkI2I4sk7XZu76fNkijJnOGgnxwYCd2UN1TGOEH8PojIV37NdKZKKGd5vt6VHGtfQiJJ2Mo3uwANXOpHs9vYHiSq/YoLZOPOd1WkAZTjIkFAftKYuPnXAaDJ3o+JcomzDzvUrIPH8ZgkAdDt75O1poEZTNdGUxUE/FDnW+W8ek0PoAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmueIrGVqrWYa9ndAbgRXA65QpcLQIno3Z3ULDaAYRY=;
 b=W1WhLV52kgWVV6mh0f1CjIn98qyy3YwZnQ5/6PWbFmuYcnKpN8VvZKBWoeU8sSNpTqT86rkg5U79EFNtO7rtwdZzJ06hNq6mljUbl16cxNFS/1Gj5kyqMq0zpj0r/cS87Uibo29iE9Wu3HsKhATE7I/vpSt2z2TuhBYLPox1lVv6SueP+D9fYt8crnraT+ZhgENeHd6b2+I3YIugQSf5Vsq5ZJCaGY9sSn31N36e5ZsC6i4DgPRIszxJsATt8l1vJB3uW26J7lQxrAJm/VJ9F19q6LquQ6ycb+4SC3ATExhzaPF8/shGSOhRWNrJ71kJNZ56UdZxeUQoD7EFi3IbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmueIrGVqrWYa9ndAbgRXA65QpcLQIno3Z3ULDaAYRY=;
 b=P49St2XH3ld0Fagsk/s8n+JO0Gw2Qb2F8iofoDKzyt7agJjXaDU5jsiHtQ2oyfC++RtJDgVLsxdZ2EQRMDG5Kn65lh7P5xN09R27pIqiTSNDzqLMznE/V11L0OFnhD8smlwaC4vEXbU3bEYGWyjnEWWvR7RQs5MEyzoowEn6n8Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 15:58:21 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 15:58:21 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
 <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
 <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
 <abdd1def-1407-65f0-33b8-981efd5c6817@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1960cd33-03f1-f79a-7dd1-320577ae4121@amd.com>
Date: Thu, 25 Jun 2020 11:58:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <abdd1def-1407-65f0-33b8-981efd5c6817@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Thu, 25 Jun 2020 15:58:21 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24291cbd-3191-4873-512f-08d8192095ac
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45922342AA786E11809B899C92920@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYc6BqLj+4rGD0OaEIsEotNhkdYQ+pRkQXyDeO4TtRc5ArxB6YWqjMMlFZqeMTQ3UoK5C4OJ7Z40r4o+sz77RkswaraCnW+PFkYuFXzFDijvLrr9svxH4eN4CzHi3AuB4G0v9u2t09UktlB75pAdjcRGjg07ih3+CkgylClR514nmnWNeAJggiQcEIinShAFT1ZMXxMaC9cZN8bAZQ7HiZUimqfkex8e4x/9tgul9KU2r0iu4wG3v/ufDrhKYqpnF4KXEz9EczP9Q6qUDdlXY4t/KsE+jhrR9fvEsWc+NcCp1rGApb/V3cCV/HgISg4lvQRfx09aKlH07YbDYGDUfXeMqqugKv85GVgdDtMraJ9FSt+KWE48gexk1ETV+f2S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(36756003)(66946007)(86362001)(52116002)(66476007)(66556008)(316002)(478600001)(83380400001)(16576012)(8936002)(8676002)(6486002)(31686004)(956004)(2616005)(2906002)(186003)(16526019)(31696002)(5660300002)(44832011)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T57xJO99uB95cmRsnNXGwcSSD/HRZ5P7+KgV8QAsMqbvQ/YvgDvjA90Dg7ZlubJayV0X5daxaqWX4HJ5EZADi6Gq69wgBLPXqI9N3GDhQiclT/lxmIgk52uJUMOn4VBGyNW+tYeVZWQoeE9l+FREVBV7ywo8HkgIsAfv/gRduSCwRAJGRLE9jWXhGrdBjkgGzWigj4UUNOkwrxbz1gDO1xwi742oOzeZL2Amh2ypUUNiyBUsWMFf2VSL0NyhhH5tTLPLTsdqLpD9y//zG4qIf+TMLzVhEQB9nSKbbpksiKsygJ7pwSXAsgHwzLkkyaZx1vmJGhZ4ZogM+dImF/0JC3vcJS5oCUlljd2jQTKLnhRdVOKk2mx6E4Gbd9Gpn/GIHJ5GV2Zs9Qv/fwCVGwTDt4WzwVPIdPosAF4NeCSsf7INPz/vjaCd/4LtwKRpICId8W6RO6CK1HTizkUk4170sn+ESPgcje3VdqnWff8qOJhV00pAoxDtwpYrR40pQb3j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24291cbd-3191-4873-512f-08d8192095ac
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 15:58:21.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcNvnjAihe3nH3uz9PQkFxptXKddGj+6yU5UaFyWgDcK+eAiGCb/beEXbnX70Z849BZmaL8SVZKqd03aIYH1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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

CkFtIDIwMjAtMDYtMjUgdW0gMTE6NTAgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4g
QW0gMjUuMDYuMjAgdW0gMTc6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gQW0gMjAyMC0w
Ni0yNSB1bSAxMTozOCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+IEFtIDI1LjA2
LjIwIHVtIDE3OjE1IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4gQW0gMjAyMC0wNi0yNSB1
bSA0OjE5IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+PiBBbSAyNS4wNi4yMCB1
bSAwNToxOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+Pj4gV2hlbiB0aGVyZSBpcyBubyBn
cmFwaGljcyBzdXBwb3J0LCBLRkQgY2FuIHVzZSBtb3JlIG9mIHRoZSBWTUlEcy4KPj4+Pj4+IEdy
YXBoaWNzCj4+Pj4+PiBWTUlEcyBhcmUgb25seSB1c2VkIGZvciB2aWRlbyBkZWNvZGluZy9lbmNv
ZGluZyBhbmQgcG9zdCBwcm9jZXNzaW5nLgo+Pj4+Pj4gV2l0aAo+Pj4+Pj4gdHdvIFZDRSBlbmdp
bmVzLCB0aGVyZSBpcyBubyByZWFzb24gdG8gcmVzZXJ2ZSBtb3JlIHRoYW4gMiBWTUlEcyBmb3IK
Pj4+Pj4+IHRoYXQuCj4+Pj4+IElJUkMgdGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgd2Ugc3RpbGwg
dXNlIHRoZSBjb21wdXRlIHF1ZXVlcyBmb3IgcG9zdAo+Pj4+PiBwcm9jZXNzaW5nIGFuZCBub3Qg
dGhlIEtGRC4KPj4+Pj4KPj4+Pj4gU28gd2Ugd2lsbCBuZWVkIGF0IGxlYXN0IFZNSURzIGZvciB0
aGF0IGFzIHdlbGwuCj4+Pj4gQ29ycmVjdC4gUG9zdCBwcm9jZXNzaW5nIHVzZXMgY29tcHV0ZSBx
dWV1ZXMgYW5kIFZNSURzIGluIHRoZSBHRlhIVUIuCj4+Pj4gVkNFIHVzZXMgVk1JRHMgaW4gdGhl
IE1NSFVCLiBJIGJlbGlldmUgaW4gTWVzYSB0aGV5IHVzZSB0aGUgc2FtZSBWTQo+Pj4+IGNvbnRl
eHQuIFNvIGNhbid0IHRoZXkgc2hhcmUgdGhlIHNhbWUgVk1JRHM/Cj4+PiBBaCEgR29vZCBwb2lu
dCwgQnV0IHdlIHN0aWxsIG5lZWQgYXQgbGVhc3QgMyBWTUlEIHdoZW4gVk1JRAo+Pj4gcmVzZXJ2
YXRpb24gaXMgYWN0aXZlLgo+PiBJIGRvbid0IGtub3cgYW55dGhpbmcgYWJvdXQgdGhhdCBWTUlE
IHJlc2VydmF0aW9uIGZlYXR1cmUuIFdoYXQgaXMgaXQKPj4gdXNlZCBmb3I/IFdobyBpcyB1c2lu
ZyBpdD8gSG93IG1hbnkgVk1JRHMgY2FuIGJlIHJlc2VydmVkPwo+Pgo+PiBJZiBvbmUgVk1JRCBp
cyByZXNlcnZlZCwgdGhlcmUgd291bGQgc3RpbGwgYmUgb25lIFZNSUQgbGVmdCBmb3IgdmlkZW8K
Pj4gcG9zdCBwcm9jZXNzaW5nLiBUaGF0J3Mgbm90IGlkZWFsLCBidXQgSSBkb24ndCB0aGluayBp
dCB3b3VsZCBiZSBmYXRhbC4KPj4gQnV0IGlzIGl0IGEgcmVhbGlzdGljIHVzZSBjYXNlIHRoYXQg
Vk1JRCByZXNlcnZhdGlvbiBhbmQgUk9DbSt2aWRlbwo+PiBwcm9jZXNzaW5nIHdvdWxkIGhhcHBl
biBvbiB0aGUgc2FtZSBzeXN0ZW0gYXQgdGhlIHNhbWUgdGltZT8KPgo+IFZNSUQgcmVzZXJ2YXRp
b24gaXMgdXNlZCBmb3IgZGVidWdnaW5nIGFuZCB5ZXMgdGhlcmUgY2FuIG9ubHkgYmUgb25lCj4g
cmVzZXJ2ZWQuCj4KPiBCdXQgSSB0aGluayB3ZSBuZWVkIGF0IGxlYXN0IHR3byBmb3IgZHluYW1p
YyBhc3NpZ25tZW50IG9yIHdlIG1pZ2h0Cj4gcnVuIGludG8gYSBCVUdfT04oKSB3aGlsZSBnaXZp
bmcgVk1JRHMgdG8gam9icy4KCkkgZG9uJ3Qgc2VlIGFueSBCVUdzIG9yIEJVR19PTnMgaW4gYW1k
Z3B1X2lkcy5jLiBXaGF0IHNob3VsZCBJIGJlCmxvb2tpbmcgb3V0IGZvcj8KCgo+IEJ1dCBJIGNl
cnRhaW5seSBuZWVkIHRvIHRlc3QgdGhpcyBhcyB3ZWxsLiBJdCdzIHBvc3NpYmxlIHRoYXQgMSBW
TUlECj4gaW5kZWVkIHdvcmtzIGFzIGV4cGVjdGVkLgoKSSBjb3VsZCBydW4gdGhlIHRlc3QsIGlm
IHlvdSBkZXNjcmliZSB0aGUgcHJvYmxlbWF0aWMgc2NlbmFyaW8geW91IGhhdmUKaW4gbWluZC4K
ClRoYW5rcywKwqAgRmVsaXgKCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4KPj4gVGhh
bmtzLAo+PiDCoMKgIEZlbGl4Cj4+Cj4+Cj4+PiBJIGRvbid0IHRoaW5rIHlvdSBjYW4gZ28gYmVs
b3cgdGhpcy4KPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+PiBSZWdhcmRz
LAo+Pj4+IMKgwqDCoCBGZWxpeAo+Pj4+Cj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4
IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoMKg
wqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDExICsrKysrKysrLS0t
Cj4+Pj4+PiDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYwo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jCj4+Pj4+PiBpbmRleCA2ZTEwYjQyYzU3ZTUuLjM0NzA5MjllNWI4ZSAxMDA2NDQKPj4+Pj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+Pj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+Pj4+IEBAIC0xMjQ1LDEw
ICsxMjQ1LDE1IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+
Pj4+PiDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAqIG51bWJlciBv
ZiBWTXMKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgKiBWTUlEIDAgaXMgcmVzZXJ2ZWQgZm9yIFN5
c3RlbQo+Pj4+Pj4gLcKgwqDCoMKgICogYW1kZ3B1IGdyYXBoaWNzL2NvbXB1dGUgd2lsbCB1c2Ug
Vk1JRHMgMS03Cj4+Pj4+PiAtwqDCoMKgwqAgKiBhbWRrZmQgd2lsbCB1c2UgVk1JRHMgOC0xNQo+
Pj4+Pj4gK8KgwqDCoMKgICogYW1kZ3B1IGdyYXBoaWNzL2NvbXB1dGUgd2lsbCB1c2UgVk1JRHMg
MS4ubi0xCj4+Pj4+PiArwqDCoMKgwqAgKiBhbWRrZmQgd2lsbCB1c2UgVk1JRHMgbi4uMTUKPj4+
Pj4+ICvCoMKgwqDCoCAqCj4+Pj4+PiArwqDCoMKgwqAgKiBUaGUgZmlyc3QgS0ZEIFZNSUQgaXMg
OCBmb3IgR1BVcyB3aXRoIGdyYXBoaWNzLCAzIGZvcgo+Pj4+Pj4gK8KgwqDCoMKgICogY29tcHV0
ZS1vbmx5IEdQVXMuIE9uIGNvbXB1dGUtb25seSBHUFVzIHRoYXQgbGVhdmVzIDIgVk1JRHMKPj4+
Pj4+ICvCoMKgwqDCoCAqIGZvciB2aWRlbyBwcm9jZXNzaW5nLgo+Pj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoCAqLwo+Pj4+Pj4gLcKgwqDCoCBhZGV2LT52bV9tYW5hZ2VyLmZpcnN0X2tmZF92bWlkID0g
ODsKPj4+Pj4+ICvCoMKgwqAgYWRldi0+dm1fbWFuYWdlci5maXJzdF9rZmRfdm1pZCA9Cj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMgPyAzIDog
ODsKPj4+Pj4+IMKgwqDCoCDCoMKgwqDCoMKgIGFtZGdwdV92bV9tYW5hZ2VyX2luaXQoYWRldik7
Cj4+Pj4+PiDCoMKgwqAgCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
