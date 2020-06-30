Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B98C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 07:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F2A206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 07:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UNeoxzv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F2A206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510C689A75;
	Tue, 30 Jun 2020 07:01:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5639689A75
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 07:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJa8Dky1j53w+eu7fr7JWdq1eCEpSaPuFXIC6V+6ugOqZKN58t3UwaKQdVEu7eaqgm/BsV8ZZFCzS6cmjlqW3ew8LA6LwpkBnJqjyKS3mH6qYvx+DkDO8Xlde4XZjov5xiWOHctMd6nK8TBXai/h15W9IsTA+KUKTHfdvXxeY0A2jqMSEOCUnTJFHFArVqn2E8tKwNhd740YG34FxpDXKxwO8BXNjvPJawu+d6D0RRvfRSgMf4yKhGYzs1z1N0o/C+eceNGsZpiIGGlA9VTW1vLj2x0xZBf7BULu9Zg9xpKkDtZcKxNcv6wuOh2Qs0FVOCf+xQnolDOsUB4h3D3NUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z7pKM7HPELxBIyS6m6kyVtSfy6VD2CFjtlrz9UAbPM=;
 b=lAKVEcwBz1EJRsBmWOnpGNMRBbiZEwl3w9JGz6jydaQqaHFD+Wq1uaYwlKWqdYxxoKApi2H39oejeDknqXfTOnj97mvE3RvCFeAMkt/NVM1szJTtOOZT3PsVpuP3kpYbEoaGTmnjPEWRU1Y1k60mjul+eQrZvrZTtqv9JbOhspuTiVYUmVTVUMNRZdD+BbHEgIqw3vzwoSYZcwvbY5SEl/CRwjv8O5Qt1lEBUW8f0GzZqKLLknDzjF1MdKoXpGv6BHsEccdemWhCg+6WQqAAe4wR20sV7JC3PTclraOj+4xEQrZ4DramBUsYxBGU5X2RpgpC40eEQBmvEhtS676Fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z7pKM7HPELxBIyS6m6kyVtSfy6VD2CFjtlrz9UAbPM=;
 b=UNeoxzv1IKfAvwS1rncFv4payAnMWCgXcUcZM+YG3mivJbpP0v3yXzydc9G439C+Qr6c2SvM2RckZ6fnXzQL2piFLS+YrQnxVI/3MVSw2RoY88eutJdvjdYeRYSolGtoCMfeAIf3D8wOOtwq/6TMqFbYE8epDQlGypifAfleoQo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 07:01:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 07:01:14 +0000
Subject: Re: [PATCH] drm/amdgpu: Adding wait time before reading upll control
 register
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Jivin <alex.jivin@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200626161239.19762-1-alex.jivin@amd.com>
 <a3c7780c-d891-4cf6-f49b-e72692803615@gmail.com>
 <5b07670d-ad6e-2378-062e-c33e3a73f5c7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <129c10a5-a531-96a2-83ac-d3bd760c426d@amd.com>
Date: Tue, 30 Jun 2020 09:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <5b07670d-ad6e-2378-062e-c33e3a73f5c7@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 07:01:13 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbe1942e-41fe-44bf-a8c0-08d81cc360ab
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4335C75C0253129DD362B2E9836F0@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GlwXh7KsTxXZeJRmTrYNr4/FLreCwbYimWE4+DMM5WxiOGK1CCVDFF3LCkKvctNN27iwUIeRE8paJ9xROHxbC534fACwAG6vvDEUDb1+mvC2ElamPzqpvEoMEuzDnWOM5YB53z2zC4tyzgjSnFVjmBGK2bs39yYh0vhoSzj/7Icx4oYBIeFbb6mD97BCl9JIXShu/2Rgzw5hDIrihBCO/ITDfMvW7HkRvWnGaIRKlHFdNoZx6ehgO6pdsRFGp1GxlolTGx/dRgY+/nHdaIg0daYSwQywiCUWDSRkc33dq6WXBBu5HSdo+LOwJtnS7WRB8NcQEQQEF3VPIHd3ROZs5UarGcHyPeN4zukGgEa+fkd0K0pgkebD+sj7T86RAIc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(52116002)(53546011)(5660300002)(66946007)(66476007)(66556008)(110136005)(2616005)(2906002)(186003)(4326008)(316002)(36756003)(66574015)(83380400001)(31696002)(86362001)(8676002)(478600001)(31686004)(6486002)(16526019)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cF2YZg1t44YDipFcsbt+kegJGOp8tEg8rKy4Ek3f4yOJA04xzwF1UcSm2x0bZyi58pcBVl4SO5PgUTEqnRUaeI5i6Sl9PKZdGI/9Zi2qy5/cDq+YJ1yY+9zB3u94OGD/mKwa2wXHipZtolB7zYrpu5BGjKU18u1K1STXIADqBBfC8G+btwGvWbD9mEc+j8cdJMFaIF7uzJcYcF/R5JXewiTd4qmRJDGWuuIMKzOrLpLnwBESc9L4IFFUAqi4fq04KKeURe22Fom3aCSUx1eeHh8h2eGhrYkt2p53zgW0tYRfF1Xr0nNxEKawXD73RvhqwDQN5NcVwOpYJ8UJFgdLQnv9Lqb+qZujWgXAaLhWBiKDBkHLNXSZOiVZvgRbwBTZ59/d766T13l1Xjjkbj8SabH3tzeWcB9Kw7kXfy/kh6tcVvUjL+JilgDfdG30GJFFTXpk7Wt9HrAqQ7Hh9qy5p1/UX3A4m0oqK9GqhwlMhzQP1eiE5M6r7kPAqzZgoBgJetKxuNKHuEc3bwEvN8DnK+PyZ2g4Hi037K0Gum7z+Dfnhi037zbj1lhdTpRlBsYy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe1942e-41fe-44bf-a8c0-08d81cc360ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 07:01:14.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTdjZ7V1ROcez3E0SzdZv/EaK43VKXYVKUc3suriQglgR8iWrquVLw5mWoACfG04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

QW0gMzAuMDYuMjAgdW0gMDA6NDYgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAyMC0wNi0y
NiAxOjA0IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDI2LjA2LjIwIHVtIDE4
OjEyIHNjaHJpZWIgQWxleCBKaXZpbjoKPj4+IEFkZGluZyBhIGRlbGF5IGJldHdlZW4gd3JpdGlu
ZyB0byBVVkQgY29udHJvbCByZWdpc3RlciBhbmQgcmVhZGluZyBmcm9tIGl0Lgo+Pj4gVGhpcyBp
cyB0byBhbGxvdyB0aGUgSFcgdG8gcHJvY2VzcyB0aGUgd3JpdGUgY29tbWFuZC4KPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IEppdmluIDxhbGV4LmppdmluQGFtZC5jb20+Cj4+PiBTdWdnZXN0
ZWQtQnk6IEx1YmVuIFR1a292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYyB8IDYgKysrKysrCj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jCj4+
PiBpbmRleCA5ZDdiNGNjZDE3YjguLjQyY2RjMTRmYjc5ZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NpLmMKPj4+IEBAIC0xNDM1LDYgKzE0MzUsMTIgQEAgc3RhdGljIGludCBzaV91dmRf
c2VuZF91cGxsX2N0bHJlcShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgIAkvKiBB
c3NlcnQgVVBMTF9DVExSRVEgKi8KPj4+ICAgIAlXUkVHMzJfUChjZ191cGxsX2Z1bmNfY250bCwg
VVBMTF9DVExSRVFfTUFTSywgflVQTExfQ1RMUkVRX01BU0spOwo+Pj4gICAgCj4+PiArCS8qIFdh
aXRpbmcgZm9yIEhXIHRvIHByb2Nlc3MgdGhlIHByZXZpb3VzIHdyaXRlLgo+Pj4gKwkgKiBUaGlz
IGlzIHRvIGdpdmUgYSBjaGFuY2UgdG8gSFcgdG8gYWN0IGJlZm9yZQo+Pj4gKwkgKiB0aGUgZmly
c3QgcmVhZCBpcyBkb25lLgo+Pj4gKwkgKi8KPj4+ICsJbWRlbGF5KDEpOwo+Pj4gKwo+PiBNaG0s
IHRoYXQgaXMgbW9zdCBsaWtlbHkgbm90IGEgZ29vZCBpZGVhLgo+Pgo+PiBXZSBuZWVkIHRvIGlz
c3VlIGEgcmVhZCBhZnRlciB0aGUgd3JpdGUgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHN0dWZmIGlz
Cj4+IHNlbmQgb3V0IHRvIHRoZSBoYXJkd2FyZS4KPiBUcmFjaW5nIGRvd24gV1JFRzMyX1AoKSwg
aXQgc2VlbXMgdG8gYmUgd3JpdGluZyBhbmQgdGhlbiByZWFkaW5nIHRoZSByZWdpc3RlciwKCldo
eSBkbyB5b3UgdGhpbmsgc28/CgpXaGF0IHRoZSBtYWNybyBzaG91bGQgZG8gaXMgdG8gcmVhZCwg
YXBwbHkgbWFzayBhbmQgdmFsdWUgYW5kIHRoZW4gd3JpdGUgCml0IGJhY2sgdG8gdGhlIHJlZ2lz
dGVyOgoKI2RlZmluZSBXUkVHMzJfUChyZWcsIHZhbCwgbWFzaynCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgXAogwqDCoMKgIGRvIHvCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgXAogwqDCoMKgIMKgwqDCoCB1aW50MzJfdCB0bXBfID0gUlJFRzMyKHJl
Zyk7wqDCoMKgIMKgwqDCoCDCoMKgwqAgXAogwqDCoMKgIMKgwqDCoCB0bXBfICY9IChtYXNrKTvC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIFwKIMKgwqDCoCDCoMKgwqAgdG1wXyB8
PSAoKHZhbCkgJiB+KG1hc2spKTvCoMKgwqAgwqDCoMKgIMKgwqDCoCBcCiDCoMKgwqAgwqDCoMKg
IFdSRUczMihyZWcsIHRtcF8pO8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBcCiDCoMKgwqAg
fSB3aGlsZSAoMCkKCj4gYmFjayB0byBiYWNrLCB0d2ljZSBvdmVyLCB3aGVuIGRlZmVycmluZyB0
byBQQ0llIHNwYWNlLCBhbmQganVzdCB3cml0ZWwoKSB3aGVuIGluIG1taW8KPiBzcGFjZS4gKFRo
ZXJlIGlzIHNlcGFyYXRlIHRocmVhZCBvbiB0aGlzIGFzIGl0IGRvZXNuJ3Qgc2VlbSBjb3JyZWN0
LikKClRoYXQgaW5kZWVkIHNvdW5kcyBmaXNoeSwgYnV0IGFsbCB0aG9zZSByZWdpc3RlcnMgc2hv
dWxkIGJlIGluIG1taW8gc3BhY2UuCgo+Cj4+IEFkZGluZyBhIGRlbGF5IGhlcmUgaXMgcHJvYmFi
bHkganVzdCBwb3N0cG9uaW5nIHRoYXQuIERvIHdlIGhhdmUgc29tZQo+PiBub3RlIGluIHRoZSBk
b2N1bWVudGF0aW9uIHRoYXQgdGhpcyBpcyBuZWNlc3Nhcnk/Cj4gRmx1c2hpbmcgdGhlIHdyaXRl
IGJ1ZmZlciAoYnkgaXNzdWluZyBhIHJlYWQgaWYgbmVjZXNzYXJ5KSBpcyBkaWZmZXJlbnQKPiB0
aGFuIHdhaXRpbmcgZm9yIHRoZSBoYXJkd2FyZSB0byBwcm9jZXNzIHRoZSByZXF1ZXN0LgoKSXQn
cyBub3QgZmx1c2hpbmcgdGhlIHdyaXRlIGJ1ZmZlci4gVGhlIGhhcmR3YXJlIGlzIG9mdGVuIGJ1
aWxkIGluIGEgd2F5IAp0aGF0IHRoZSBuZXh0IHJlYWQgaXMgdHJpZ2dlcmluZyB0aGUgYWN0aW9u
IGluc3RlYWQgb2YgdGhlIHdyaXRlLgoKVGhhdCdzIGRvbmUgYmVjYXVzZSB3cml0ZXMgc2hvdWxk
IGJlIGFjY2VwdGVkIGJ5IHRoZSBoYXJkd2FyZSBibG9jayAKaW1tZWRpYXRlbHkgd2hpbGUgcmVh
ZHMgaGF2ZSBhIHRpbWVvdXQgYXNzb2NpYXRlZCB3aXRoIGl0LgoKPiBUaGUgY3VycmVudCBjb2Rl
IGRvZXMgZmx1c2ggdGhlIHdyaXRlIGJ1ZmZlciBieSByZWFkaW5nIGJhY2ssCj4gYW5kIHRoZW4g
ZGVsYXlpbmcgKGJvdGggaW4gdGhlIGxvb3ApLCB3aGljaCBkb2VzIGFjaGlldmUgdGhpcywKPiBi
dXQgaXQgbGVhdmVzIGEgY29ybmVyIGNhc2UgYXMgSSB3cm90ZSBpbiBteSByZXZpZXcuCj4gVGhl
IGNvcm5lciBjYXNlIGlzIHRoYXQgaWYgdGhlIHN0YXR1cwo+IHJlZ2lzdGVyIGNoYW5nZXMgdG8g
ImRvbmUiIHdoaWxlIGluIHRoZSBsYXN0ICJkZWxheSgpIgo+IHdlIHRoZW4gY2hlY2sgdGhlIGxv
b3AgaW52YXJpYW50IGFuZCBleGl0LCBhcyBvcHBvc2VkIHRvIHJlYWRpbmcKPiB0aGUgcmVnaXN0
ZXIgYW5kIGRldGVybWluaW5nIHRoYXQgaXQgaXMgZG9uZSBzdWNjZXNzZnVsbHkuCj4KPiBDdXJy
ZW50LCBhbGwgaW4gcHNldWRvLWNvZGU6Cj4KPiB3cml0ZSgpCj4KPiBmb3IgKGNvdW50ID0gMDsg
Y291bnQgPCBNQVhfQ09VTlQ7IGNvdW50KyspIHsKPiAJcmVzID0gcmVhZCgpCj4gCWlmIChyZXMg
aXMgc3VjY2VzcykgYnJlYWsKPiAJbWRlbGF5KDEwKSAgICAgICAgICAgICAgPC0tIGlmIGl0IGNo
YW5nZXMgaGVyZSwgd2UgbWlzcyBpdCBvbiB0aGUgbGFzdCBpdGVyYXRpb24KPiB9Cj4KPiBPcHRp
bWFsOgo+Cj4gd3JpdGUoKSAgIDsgYXNzdW1lIHdyaXRlIGJ1ZmZlciBmbHVzaAo+IG1kZWxheSg5
KQo+IGRvIHsKPiAJbWRlbGF5KDEpCj4gCXJlcyA9IHJlYWQoKQo+IH0gd2hpbGUgKHJlcyAhPSBz
dWNjZXNzICYmICsrY291bnQgPCBNQVhfQ09VTlQpCj4KPiBUaGlzIHNvbHZlcyB0aGUgY29ybmVy
IGNhc2UsIGFuZCBlbnN1cmVzIGEgdGltZSBkZWxheSBvZiAxMCBmb3IKPiB0aGUgaGFyZHdhcmUg
dG8gcHJvY2VzcyBpdHMgam9iLCBidXQgYSBkZWxheSBvZiAxIGZvciBwb2xsaW5nCj4gdGhlIHN0
YXR1cywgYXMgaXQgY291bGQgYmUgZG9uZSAiYW55dGltZSBub3cuIgoKVGhhdCBzZWVtcyB0byBh
c3N1bWUgdGhhdCB0aGUgQUNLIGJpdHMgYXJlIG5vdCBpbW1lZGlhdGVseSBjbGVhcmVkIG9uIAp0
aGUgd3JpdGUuIEhvdyBkbyB5b3UgZ290IHRvIHRoYXQgY29uY2x1c2lvbj8KCgpQcm9jZXNzaW5n
IHRoZSByZXF1ZXN0IGNhbiB0YWtlIGV2ZW4gbG9uZ2VyIHRoYW4gMTBtcyBkZXBlbmRpbmcgb24g
d2hhdCAKaXMgZG9uZSwgd2hpY2ggcmVmZXJlbmNlIGNsb2NrIGlzIHNlbGVjdGVkLCB0aGUgdGVt
cGVyYXR1cmUgb2YgdGhlIApoYXJkd2FyZSwgc2xlZXAgbW9kZSBldGMgZXRjLi4uCgpGb3IgZXhh
bXBsZSBzd2l0Y2hpbmcgdG8gYnlwYXNzIG1vZGUgdXN1YWxseSBjb21lcyBpbW1lZGlhdGVseSwg
ZS5nLiB5b3UgCndyaXRlIHRoZSBDTlRMIHJlZ2lzdGVyIGFuZCB5b3UgaW1tZWRpYXRlbHkgZ2V0
IGFuIGFjayBiYWNrLgoKQnV0IGFzIGZhciBhcyBJIGtub3cgc3dpdGNoaW5nIGZyb20gYnlwYXNz
IGJhY2sgdG8gbm9ybWFsIG1lYW5zIHRoYXQgd2UgCm5lZWQgdG8gd2FpdCBmb3IgYm90aCB0aGUg
cmVmZXJlbmNlLCBmZWVkYmFjayBhbmQgb3V0cHV0IHNpZ25hbCB0byBiZSAKbG9naWNhbCBsb3cg
YW5kIHRoZW4gaGlnaCBhZ2FpbiBhdCB0aGUgc2FtZSB0aW1lLgoKRGVwZW5kaW5nIG9uIHRoZSBm
cmVxdWVuY2llcyB3ZSBnb3QgaGVyZSB0aGF0IGNhbiB0YWtlIGEgYml0IG9mIHRpbWUuCgo+IEFz
c3VtaW5nIHRoYXQgV1JFRzMyX1AoKSBmbHVzaGVzIHRoZSB3cml0ZSBidWZmZXIsIGFzIGl0IHNl
ZW1zCj4gdGhhdCBpdCBkb2VzLCB0aGUgaWRlYSBoZXJlIGlzIHRvIGdpdmUgdGhlIGhhcmR3YXJl
IHNvbWUgdGltZSB0byBwcm9jZXNzCj4gdGhlIHJlcXVlc3QgKGZyb20gd3JpdGluZyBhIHZhbHVl
IHRvIGl0KSwgYnV0IHdoZW4gcG9sbGluZyB0byBwb2xsCj4gYSBzaG9ydGVyIGFtb3VudCBvZiB0
aW1lLgoKTm90IGEgYmFkIGlkZWEsIGJ1dCB0aGlzIGlzIGJhc2VkIG9uIHRoZSBkaWFnbm9zdGlj
IGNvZGUgYW5kIGFscmVhZHkgCnVzZWQgZm9yIG5lYXJseSBhIGRlY2FkZS4KCkluIG90aGVyIHdv
cmRzIHRoaXMgY29kZSBpcyB3aGF0IHRoZSBoYXJkd2FyZSBlbmdpbmVlcnMgcmVjb21tZW5kZWQs
IGlzIAp1c2VkICptdWNoKiBtb3JlIG9mdGVuIG91dHNpZGUgdGhlIGRyaXZlciBhbmQga25vd24g
dG8gYmUgd29ya2luZyB3ZWxsLgoKPiBJIHdvdWxkJ3ZlIGFsc28gbGlrZWQgdG8gc2VlIHRoZSBt
dXRleCBidXNpbmVzcyBmaXhlZAo+IGFzIHdlbGwgZnJvbSBteSBvcmlnaW5hbCBwYXRjaCByZXZp
ZXcsIGFzIGl0IGlzIGVhc3kgdG8gcHJvdmUKPiB0aGF0IGl0IGlzIGFsd2F5cyB0YWtlbiwgc28g
bm8gbmVlZCB0byBlbWJlZCBpdCBpbnNpZGUgdGhlIGlmKCkuCgpUaGF0IGlzIGluZGVlZCBhIHNv
ZnR3YXJlIHByb2JsZW0gd2hpY2ggc2hvdWxkIGJlIGZpeGVkLgoKUmVnYXJkcywKQ2hyaXN0aWFu
LgoKPgo+IFJlZ2FyZHMsCj4gTHViZW4KPgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiAgICAJLyogV2Fp
dCBmb3IgQ1RMQUNLIGFuZCBDVExBQ0syIHRvIGdldCBhc3NlcnRlZCAqLwo+Pj4gICAgCWZvciAo
aSA9IDA7IGkgPCBTSV9NQVhfQ1RMQUNLU19BU1NFUlRJT05fV0FJVDsgKytpKSB7Cj4+PiAgICAJ
CXVpbnQzMl90IG1hc2sgPSBVUExMX0NUTEFDS19NQVNLIHwgVVBMTF9DVExBQ0syX01BU0s7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
