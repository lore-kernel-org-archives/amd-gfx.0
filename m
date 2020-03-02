Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD6C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E784246B4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rZHTtksg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E784246B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAF86E23D;
	Mon,  2 Mar 2020 09:49:54 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700040.outbound.protection.outlook.com [40.107.70.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D0E6E23D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3RGKaQcv5xclKL8SJ6COvEg+wdwzR++mzotGqsnbmIgdevSqWLVkueyBa3ohgYeSB/JR/MBbxsXoD5R7/GPl6z25SmHONW0vHS6IF7mF+AHHY6DTKh5uigHn6mSXRaRpH4ri3xR/uRg0Hhd4XKUoBKI/bcf/Xw7y4ae4fwyXfFcTevkuf4ftP3QSjJsTTsliTn8/JhTty7TGgDPvX2OSSgWQvtM+Boi0kHyIEfDIdHJ4AtTrgFGSXS3HUcCsja5a9KsUTLdmmQqBJZu2TSKItVEL2WOEPDaTcsS8WPZiR10U3F57a/XmH+69hMj4Qy4THdkKPtbljZE9wYywjmpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1qyv9ZrpFZqIGuIZMpPghWsQGoMG7rYI9xWCeD7H2M=;
 b=gmYkS6i6LqcgyAiD1y1O0n5pvE7IOq32ehqBa8Of5qMd3HZF0vss+XQ71mf0yYZYUAM5vsqv+KsTYP9kocsiT71u+lSsxFln2lKY1P473mbxT6chTbZyoBE2TXpTbpY85aU0SZHCP7uTG+iqpzgBmZzeBDhYkJwUFwMj189i2Q/udyX5N5Qd5vn4aJ/XjIk6x2q/hD71tB5727YujEm6+WOYsWuQQMmCQCyxhckHtJ7PFYWn+1iAy3+wplaW03gse4nFytudJ9b5tlu/A7PAz7kavWgHifUyPFfkwBct6rCs/tQLpjCMkCYdqVyKB6aZm0jrjn8TyOokrzsEVfPMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1qyv9ZrpFZqIGuIZMpPghWsQGoMG7rYI9xWCeD7H2M=;
 b=rZHTtksgepuI/K5n0o/eq3lUyexDYcDTtN546ET6Z4I+9zlsrY1s1zOhjHIXjU9SbH4zVgXjCHtwblqkn+xHB0J9k6UV7j476EVHDLaO/lY8goNyY9xcAgtqTzxtA7NqpzwaXptPgOsxnyzieZHAyQCO7jOPBCXidozuHhudyaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1675.namprd12.prod.outlook.com (2603:10b6:4:5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 09:49:51 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 09:49:51 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: fix IB test MCBP bug
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
 <63e00945-68e3-f128-5a78-51c1d87bc778@gmail.com>
 <MN2PR12MB3933638FC598F979E2F3E65384E70@MN2PR12MB3933.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dd4754ee-054f-48b5-582d-29c58ba38d68@amd.com>
Date: Mon, 2 Mar 2020 10:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3933638FC598F979E2F3E65384E70@MN2PR12MB3933.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::39) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Mon, 2 Mar 2020 09:49:50 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfa38b95-324b-4d49-8e70-08d7be8f0d4c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:|DM5PR12MB1675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1675AFDF5A46D8DBA5213FEA83E70@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(66556008)(66476007)(66946007)(110136005)(2616005)(316002)(2906002)(5660300002)(53546011)(8676002)(81166006)(478600001)(6486002)(31696002)(8936002)(31686004)(36756003)(6666004)(81156014)(86362001)(186003)(66574012)(52116002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1675;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+CN8vjp78OPmfKixM+Tlz2xhZInQq8M/snpvL36kt9PxCVI0WPqWtBwQoYdB3BZs4K9sVPQPh8LeHw93u0eqwMA5rspC0Fw5lF2BnEZw35QtyhzA4XRKlLT7T/oW3warzVE1u4iqFQ8+60FQi5iMOMLOZIgJsoBCGlm7PmLsHrxvKPGJsIbJvPrUmiufTlSmWa02T5n+PqzjOxs1uZrzorqDrBf/ZS7bdsfhkLAA4onz3SpubnyOGzgICR77RSiv3fKfv2nWOey04zi2GqnGI6dbZBafM1nN1OmIpGZQTZtgU8EwELA9W/60B/ttcvXFTxaBmhx/9VfpG1LdKEP4f/dBJbv0njDn11rr3HwJusgVCS7+uG8wiA1cROl+nhp3rUbFQe6Ywe27eoUIQGr8SckCIjFyR8upeR2L6uLmwkjBrr4Bla4aSgS/+iUfWT0
X-MS-Exchange-AntiSpam-MessageData: MVQz8y20aXdRjttzgk7nYpkGgIVMnRT5yomLUpNrc/cl1eMACBmqzT/FDhudPmxdiEaIme3Xy1ulYpXbDFgeUD3n0Z/HGMJ1STZxwxNP4zeVfSG57+HnoZqawY70wQ4rZTF21V4WzvonMZ3Lz6wkkiLu9xwtjR6yPpCKkpsG0oEw2z4LsLcirlnPUntj9HfdfzNcKt3Vm+wffPPl2Z/1rA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa38b95-324b-4d49-8e70-08d7be8f0d4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:49:51.1285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MrWlHs6qxiDq/gLzHRv4Yq+vy7SO+2W+hI82TOp7ZPYPDGdCwXXiTaM+wyEwe58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
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

QW0gMDIuMDMuMjAgdW0gMTA6Mzkgc2NocmllYiBMaXUsIE1vbms6Cj4+IC0JCWlmICghKGliLT5m
bGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKSkKPj4gKwkJaWYgKCEoaWItPmZsYWdzICYgQU1ER1BV
X0lCX0ZMQUdfQ0UpICYmIHZtaWQpCj4gS2VybmVsIGNvcGllcyBhbHNvIGRvbid0IHVzZSBhIFZN
SUQsIHNvIEkgdGhpbmsgdGhhdCB0aGlzIHdvbid0IHdvcmsgY29ycmVjdGx5Lgo+Cj4gRG8geW91
IGhhdmUgdGhlIGpvYiBhdmFpbGFibGUgYXMgd2VsbD8gVGhhdCB3b3VsZCBwcm9iYWJseSBiZSBi
ZXR0ZXIgdG8gdGVzdCBmb3Igc2luY2Ugb25seSBJQiB0ZXN0cyBkb24ndCB1c2UgYSBqb2IuCj4K
PiBbTUxdCj4gVGhlIEBqb2IgaXMgbm90IHBhc3NlZCB0byB0aGUgZ2Z4X3YxMF8wX3JpbmdfZW1p
dF9pYl9nZngoKSByb3V0aW5lIHNvIEkgdGVuZCB0byBtb2RpZnkgYXMgbGVzcyBhcyBwb3NzaWJs
ZQo+IEJlc2lkZXMsIGZvciBrZXJuZWwgY29waWVzOiBJIGJlbGlldmUgdGhleSBhbHNvIGRvIG5v
dCBzdXBwb3J0IE1DQlAgKGNhbiB5b3UgcG9pbnQgbWUgdGhlIGNvZGUgaW4gc291cmNlIG9mIHRo
b3NlIGtlcm5lbCBjb3BpZXMgPykgLCBzbyB1c2UgVk1JRCB0byB0ZXN0IGlzIGZpbmUgKFRvIHN1
cHBvcnQgTUNCUCBvbiBnZnggcmluZyB5b3UgbmVlZCBhIHNldCBvZiBhZGRpdGlvbmFsIHByZWFt
YmxlIElCIGNvIHdvcmsgd2l0aCB5b3VyIHdvcmtsb2FkIGlCIGFuZCBrZXJuZWwgY29waWVzIGFw
cGFyZW50bHkgZG9uJ3QgaGF2ZSB0aG9zZSBzdHVmZnMpCgpBaCwgc29ycnkhIE15IGluY29ycmVj
dCB0aGlua2luZywga2VybmVsIGNvcGllcyBhbHNvIGRvbid0IHVzZSB0aGUgQ1AgCmJ1dCByYXRo
ZXIgdGhlIFNETUEuIFNvIHRoZSBjaGFuZ2UgaXMgY29tcGxldGVseSBpcnJlbGV2YW50IGZvciB0
aGUgY29waWVzLgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4gZm9yIHRoZSBwYXRjaC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBUaGFua3MK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTW9uayBMaXV8R1BVIFZp
cnR1YWxpemF0aW9uIFRlYW0gfEFNRAo+Cj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
Pgo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMiwgMjAyMCA1OjM1IFBNCj4gVG86IExpdSwgTW9uayA8
TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGZpeCBJQiB0ZXN0IE1DQlAgYnVnCj4KPiBB
bSAwMi4wMy4yMCB1bSAxMDoyMiBzY2hyaWViIE1vbmsgTGl1Ogo+PiAxKWZvciBnZnggSUIgdGVz
dCB3ZSBzaG91bGRuJ3QgaW5zZXJ0IERFIG1ldGEgZGF0YQo+Pgo+PiAyKXdlIHNob3VsZCBtYWtl
IHN1cmUgSUIgdGVzdCBmaW5pc2hlZCBiZWZvcmUgd2Ugc2VuZCBldmVudCAzIHRvCj4+IGh5cGVy
dmlzb3Igb3RoZXJ3aXNlIHRoZSBJRExFIGZyb20gZXZlbnQgMyB3aWxsIHByZWVtcHQgSUIgdGVz
dCwgd2hpY2gKPj4gaXMgbm90IGRlc2lnbmVkIGFzIGEgY29tcGF0aWJsZSBzdHJ1Y3R1cmUgZm9y
IE1DQlAKPj4KPj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Cj4+
IC0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2
ICsrKysrKwo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgICAg
fCAzIC0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyAgICAg
fCAyICstCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgICAgICB8
IDIgKy0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgICAgIHwg
MiArLQo+PiAgICA1IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+
PiBpbmRleCAzNTEwOTZhLi41NzJlYjZlIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCj4+IEBAIC0zMTk1LDYgKzMxOTUsMTIgQEAgdm9pZCBhbWRn
cHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgIAlmbHVzaF9k
ZWxheWVkX3dvcmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKPj4gICAgCWFkZXYtPnNodXRk
b3duID0gdHJ1ZTsKPj4gICAgCj4+ICsJLyogbWFrZSBzdXJlIElCIHRlc3QgZmluaXNoZWQgYmVm
b3JlIGVudGVyaW5nIGV4Y2x1c2l2ZSBtb2RlCj4+ICsJICogdG8gYXZvaWQgcHJlZW1wdGlvbiBv
biBJQiB0ZXN0Cj4+ICsJICogKi8KPj4gKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQo+PiAr
CQlhbWRncHVfdmlydF9yZXF1ZXN0X2Z1bGxfZ3B1KGFkZXYsIGZhbHNlKTsKPj4gKwo+PiAgICAJ
LyogZGlzYWJsZSBhbGwgaW50ZXJydXB0cyAqLwo+PiAgICAJYW1kZ3B1X2lycV9kaXNhYmxlX2Fs
bChhZGV2KTsKPj4gICAgCWlmIChhZGV2LT5tb2RlX2luZm8ubW9kZV9jb25maWdfaW5pdGlhbGl6
ZWQpewo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+IGluZGV4
IDBmMzU2MzkuLjBiMTUxMWEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9rbXMuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfa21zLmMKPj4gQEAgLTg4LDkgKzg4LDYgQEAgdm9pZCBhbWRncHVfZHJpdmVyX3VubG9hZF9r
bXMoc3RydWN0IGRybV9kZXZpY2UgKmRldikKPj4gICAgCWlmIChhZGV2LT5ybW1pbyA9PSBOVUxM
KQo+PiAgICAJCWdvdG8gZG9uZV9mcmVlOwo+PiAgICAKPj4gLQlpZiAoYW1kZ3B1X3NyaW92X3Zm
KGFkZXYpKQo+PiAtCQlhbWRncHVfdmlydF9yZXF1ZXN0X2Z1bGxfZ3B1KGFkZXYsIGZhbHNlKTsK
Pj4gLQo+PiAgICAJaWYgKGFkZXYtPnJ1bnBtKSB7Cj4+ICAgIAkJcG1fcnVudGltZV9nZXRfc3lu
YyhkZXYtPmRldik7Cj4+ICAgIAkJcG1fcnVudGltZV9mb3JiaWQoZGV2LT5kZXYpOwo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+PiBpbmRleCA5NGNhOWZmLi4wNTU1
OTg5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
Ywo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+PiBAQCAt
NDQzMiw3ICs0NDMyLDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3JpbmdfZW1pdF9pYl9nZngo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+PiAgICAJCWlmIChmbGFncyAmIEFNREdQVV9JQl9Q
UkVFTVBURUQpCj4+ICAgIAkJCWNvbnRyb2wgfD0gSU5ESVJFQ1RfQlVGRkVSX1BSRV9SRVNVTUUo
MSk7Cj4+ICAgIAo+PiAtCQlpZiAoIShpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19DRSkpCj4+
ICsJCWlmICghKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKSAmJiB2bWlkKQo+PiAgICAJ
CQlnZnhfdjEwXzBfcmluZ19lbWl0X2RlX21ldGEocmluZywKPj4gICAgCQkJCSAgICAoIWFtZGdw
dV9zcmlvdl92ZihyaW5nLT5hZGV2KSAmJiBmbGFncyAmIEFNREdQVV9JQl9QUkVFTVBURUQpID8g
dHJ1ZSA6IGZhbHNlKTsKPj4gICAgCX0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jCj4+IGluZGV4IDM5M2ExMzIuLmIxNGY0NmEzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMKPj4gQEAgLTYxMTYsNyArNjExNiw3IEBAIHN0YXRpYyB2b2lk
IGdmeF92OF8wX3JpbmdfZW1pdF9pYl9nZngoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+PiAg
ICAJaWYgKGFtZGdwdV9zcmlvdl92ZihyaW5nLT5hZGV2KSAmJiAoaWItPmZsYWdzICYgQU1ER1BV
X0lCX0ZMQUdfUFJFRU1QVCkpIHsKPj4gICAgCQljb250cm9sIHw9IElORElSRUNUX0JVRkZFUl9Q
UkVfRU5CKDEpOwo+PiAgICAKPj4gLQkJaWYgKCEoaWItPmZsYWdzICYgQU1ER1BVX0lCX0ZMQUdf
Q0UpKQo+PiArCQlpZiAoIShpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19DRSkgJiYgdm1pZCkK
PiBLZXJuZWwgY29waWVzIGFsc28gZG9uJ3QgdXNlIGEgVk1JRCwgc28gSSB0aGluayB0aGF0IHRo
aXMgd29uJ3Qgd29yayBjb3JyZWN0bHkuCj4KPiBEbyB5b3UgaGF2ZSB0aGUgam9iIGF2YWlsYWJs
ZSBhcyB3ZWxsPyBUaGF0IHdvdWxkIHByb2JhYmx5IGJlIGJldHRlciB0byB0ZXN0IGZvciBzaW5j
ZSBvbmx5IElCIHRlc3RzIGRvbid0IHVzZSBhIGpvYi4KPgo+IENocmlzdGlhbi4KPgo+PiAgICAJ
CQlnZnhfdjhfMF9yaW5nX2VtaXRfZGVfbWV0YShyaW5nKTsKPj4gICAgCX0KPj4gICAgCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+PiBpbmRleCAwMTU2NDc5Li5kOGQy
NTZlNiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
Ywo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4+IEBAIC00
OTg1LDcgKzQ5ODUsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9yaW5nX2VtaXRfaWJfZ2Z4KHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZywKPj4gICAgCWlmIChhbWRncHVfc3Jpb3ZfdmYocmluZy0+
YWRldikgJiYgKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX1BSRUVNUFQpKSB7Cj4+ICAgIAkJ
Y29udHJvbCB8PSBJTkRJUkVDVF9CVUZGRVJfUFJFX0VOQigxKTsKPj4gICAgCj4+IC0JCWlmICgh
KGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0NFKSkKPj4gKwkJaWYgKCEoaWItPmZsYWdzICYg
QU1ER1BVX0lCX0ZMQUdfQ0UpICYmIHZtaWQpCj4+ICAgIAkJCWdmeF92OV8wX3JpbmdfZW1pdF9k
ZV9tZXRhKHJpbmcpOwo+PiAgICAJfQo+PiAgICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
