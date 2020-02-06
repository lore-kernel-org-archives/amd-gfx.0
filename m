Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14760C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD4C20659
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tAAhIbXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD4C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925EA6F9AA;
	Thu,  6 Feb 2020 02:40:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2628F6F9AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 02:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCgKGGw1qHEhDytkyDRsZZQTbtgTLewKDEJlDTCCf4QJkYJIkLt0BGQogjf5/Mdu5yEW0+xAJWerPjvthCeH2DoTN7jmjN9sS5vowrnZ9NMrtNufS+mK1HRmt0atsxN9rxB9q9kj2wt7Xb4/A9SPqD2tIOZSguoFrVLvhHMFQpC0RxYZSMpN45qUdrSwwHkOUsD+x6kJKSwoO0ga1s4ZVj37TYo77MOJEbuEf1QJgm7kXXN2z38OQ6T9jfo5YwyybkvL5fvb74ZfL9sbekJHk4VmzEVu1mqTYB8xtX+BXNgK+RCDJGXfWnsp7lNy4gX6Q2BjNV+C6CPH656uG7eILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLh+73FH8E9TsHPEpewn/NKVsuml9z766tveN154PJc=;
 b=I4UjPEpq4FmGq/FSINk/BYEnE8vYyJopayyKxd9DknmMiJlCFB+2XRAa80S5xcBTg8tmMR0FfxqkQp28X+MqdFkpK1hnFybgY5aZ/H5qigAwkMq14yxHl13u4YN77fwHI1RvcBZVNWA1fjgWtHuZACfiwrbgiv4FMnfxedw8mugjB4g1re0ht5zaCtHrPQwVGf7gIFMEckS2OtSUMqkSsNo3MnxSvSsDsR56A++2JXmZ2NYRXhKpCOd8JJ5A42Kzovx9FJkaat4DV8cVSfQi0I8TvGFN7adojBJz+jjhSkOHevTq1Ojefd7kkOM9tEoFr6lkzYaxMpnOLOC19+p8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLh+73FH8E9TsHPEpewn/NKVsuml9z766tveN154PJc=;
 b=tAAhIbXXSt1lSc4XxJ6Ti/U6fugFVijzPoRtWx5v9Iha3jYmOj6q6aT/DqEeNhiXX8cpgSNAhpvTDfNKpg5z+6wky8nX3Hwl8buwFJ5BGsIpRsJLTvdw1p0gdociP5oXoEelJO+8B8FCvLC3Yjq+c+Mlcvy6i/E9F3orAz42VHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0204.namprd12.prod.outlook.com (10.174.104.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 02:40:18 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 02:40:18 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jonathan.Kim@amd.com
References: <20200205152238.45258-1-christian.koenig@amd.com>
 <20200205152238.45258-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <332b7d9b-a964-b8a7-2313-883c7108d2b1@amd.com>
Date: Wed, 5 Feb 2020 21:40:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200205152238.45258-2-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 02:40:18 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5cb8f6a-b121-42a3-485b-08d7aaade797
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:|DM5PR1201MB0204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0204C5213F0B5049049EA94B921D0@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(5660300002)(16526019)(186003)(2906002)(86362001)(6486002)(498600001)(16576012)(53546011)(31686004)(66574012)(26005)(31696002)(2616005)(956004)(36756003)(6636002)(81166006)(36916002)(52116002)(8676002)(81156014)(8936002)(66476007)(66556008)(44832011)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0204;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CE+4Xt8XMTyS5zkM5adWMxUuUGeDOdAIknC48jYFmRPgDtTzIN0PaMDcmU5YZ8C9n2QWPK/Dm3II9ApCbVkTMJL+HkPD8CMZcNzZVNEKFdYU3MUEdDLyt6GqH/4uV9zt9a1WDQkipWUjsNQcAaXpZwwP4DogXZ0ILAfJpzgIcPS5dtG9D+ITGsp6qP6z2rDs1EqxKZe+KzGksJZZlQ2jq4Yn5xqSsR8ZaHvuqlX1X8PjYFP1H2wzLrTWr1cN+I04akLskwrf3YflJgRofE7abnovF6B0zXlxsjcq1zb9ho2bRC5dbHnppax58jU42zUCeQtvk75v2IZOaqNIPQsNAzthQ9jNqtltIv3a8qtKJX3lNSuF0cDIzGXWN0gI04XGhUeLZW7dSNJdY79J4+2nKzCbZN17FZc6CmpnyD/Ae7kxROiLC2ctXq6m5G1SNfU8
X-MS-Exchange-AntiSpam-MessageData: 6WBH0Z7rdNJy9wM4XW7xqeEXi7HVKI6j6FV+fwRZ1aQJnUFt/EpLRPhcM+YCq/W35uIZlTTsLi4UeQkdsEgkec0UgnRgcMaWEAoGQABoAKDmAyd8zqcK5DwGkxcAYQIVXcwhFeILrJML9P+345OpGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cb8f6a-b121-42a3-485b-08d7aaade797
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 02:40:18.8829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCc2B8DLiXt9kM5HtuItCMfH2HgPwdOaDwqTpwVW8KmL9D2eqOdXSsmLJQYcn4hmBwC74RRHu55RjgFk+XtVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
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

SWYgd2UncmUgdXNpbmcgdGhlIEJBUiwgd2Ugc2hvdWxkIHByb2JhYmx5IGZsdXNoIEhEUCBjYWNo
ZS9idWZmZXJzIApiZWZvcmUgcmVhZGluZyBvciBhZnRlciB3cml0aW5nLgoKUmVnYXJkcywKIMKg
IEZlbGl4CgoKT24gMjAyMC0wMi0wNSAxMDoyMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3Rl
Ogo+IFRoaXMgc2hvdWxkIHNwZWVkIHVwIGRlYnVnZ2luZyBWUkFNIGFjY2VzcyBhIGxvdC4KPgo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8
IDIxICsrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBp
bmRleCBkMzk2MzBlZGRhMDEuLjdkNjVjOWFlZGVjZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMTg4LDYgKzE4OCwyNyBAQCB2b2lkIGFt
ZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGxvZmZf
dCBwb3MsCj4gICAJdWludDMyX3QgaGkgPSB+MDsKPiAgIAl1aW50NjRfdCBsYXN0Owo+ICAgCj4g
Kwo+ICsjaWZkZWYgQ09ORklHXzY0QklUCj4gKwlsYXN0ID0gbWluKHBvcyArIHNpemUsIGFkZXYt
PmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSk7Cj4gKwlpZiAobGFzdCA+IHBvcykgewo+ICsJCXZvaWQg
X19pb21lbSAqYWRkciA9IGFkZXYtPm1tYW4uYXBlcl9iYXNlX2thZGRyICsgcG9zOwo+ICsJCXNp
emVfdCBjb3VudCA9IGxhc3QgLSBwb3M7Cj4gKwo+ICsJCWlmICh3cml0ZSkKPiArCQkJbWVtY3B5
X3RvaW8oYWRkciwgYnVmLCBjb3VudCk7Cj4gKwkJZWxzZQo+ICsJCQltZW1jcHlfZnJvbWlvKGJ1
ZiwgYWRkciwgY291bnQpOwo+ICsKPiArCQlpZiAoY291bnQgPT0gc2l6ZSkKPiArCQkJcmV0dXJu
Owo+ICsKPiArCQlwb3MgKz0gY291bnQ7Cj4gKwkJYnVmICs9IGNvdW50IC8gNDsKPiArCQlzaXpl
IC09IGNvdW50Owo+ICsJfQo+ICsjZW5kaWYKPiArCj4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJmFk
ZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiAgIAlmb3IgKGxhc3QgPSBwb3MgKyBzaXplOyBw
b3MgPCBsYXN0OyBwb3MgKz0gNCkgewo+ICAgCQl1aW50MzJfdCB0bXAgPSBwb3MgPj4gMzE7Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
