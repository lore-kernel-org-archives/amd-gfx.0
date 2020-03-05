Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6FC3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6CC20801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vhjqls83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6CC20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360396E34E;
	Thu,  5 Mar 2020 18:46:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59A16E34E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 18:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiVk7Z+dh3ZfUc7a8BY/CYFBKtOneuOxXT48DnNSRH98QXzVCxpN9b78bvD0ThvTGJA8eOXRaktbLEK2e4UzfI2hzthb90WehQoMa7Ids8SiOjXQs/VIKmWomnBvjkG9AsFBbNWiq7DGF2ZiGk/ywCQF9e1MiUj1iXt/zwGG+Bv5XQJZ4VcGd42yNTmnBqQS7GWZo8GWXcU6mRYv6Ali2frGCRdoHc8KBEqFWdw2GuiNt5nRW9BNq7hqjhMPXMLBF749sQ/1BGboEYtE30QkfQwUILVepzG4PiWsVkJwvtQc/NIxZKYgT6EaV5FyLjIW5n005KxE5OpeqV9jijiqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnJI4LkObI26+OhX55FkIwtOplNcZWVQPt9V9sNA1nc=;
 b=UC/9Jmk0khhNyvNqyoWO4ETnGs0aq742mb3K3w79Kjr2p/JXzLYuGCQABR5C1PZ8PCaKxzKyx603uvpGdcSR5L0MvyfNuGoR1unkEkS4CQN0QNaLAURli7zIG7/XKezQrTzfMNaoYNiSg4elVqwLPBWUS2W8clZYhavU6eDnOGnypz180OoeP7TT/nfAC+BR77Wyn6MTxgfs1lafKzwHTVXN2ptpb0pzt/aK6lX7Cco3vqKBEA/aRlEeeUrAQwez4+YtaoggFrar67mQFkX3wx5x8HRMK8E/Vp5ltNStC4r6GbdrXr0hYfJNz5ig0etKZhCfNEeTq28NuekpwujMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnJI4LkObI26+OhX55FkIwtOplNcZWVQPt9V9sNA1nc=;
 b=vhjqls83cD1bsqjVDkIGrsUEeFCFBhq73KbJwqxAn46aObDYYdn2nnF7e9YRjh3kX2NEx2u3PMt4dIH19Fz4lekH90M0ItHdNRIx1yd5dd1wsQvdRnuOqw2TgqKeSOdt0kssN40X1/gm3HP5HSmljhARaiHfg07fqjg2DdgHf4U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 18:46:29 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 18:46:29 +0000
Subject: Re: [PATCH v2 2/4] drm/scheduler: implement a function to modify
 sched list
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-2-nirmoy.das@amd.com>
 <dbbe81d7-ff99-b85d-ddfd-1f3f13322d53@amd.com>
 <d9b7b57c-0b62-8503-658d-97d8492e23da@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2f894a8d-8894-9b6d-d8c8-1df89570e8d2@amd.com>
Date: Thu, 5 Mar 2020 13:46:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <d9b7b57c-0b62-8503-658d-97d8492e23da@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::47) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 5 Mar 2020 18:46:28 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9b24344-02f6-4eb8-dfa0-08d7c1358419
X-MS-TrafficTypeDiagnostic: DM6PR12MB3593:|DM6PR12MB3593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35935CC9094167DC3C2FB2CC99E20@DM6PR12MB3593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(6486002)(66476007)(110136005)(16576012)(16526019)(66556008)(66946007)(2906002)(5660300002)(52116002)(186003)(26005)(66574012)(53546011)(4326008)(45080400002)(478600001)(316002)(966005)(8936002)(31686004)(44832011)(86362001)(2616005)(956004)(36756003)(31696002)(81166006)(8676002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3593;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbCjnUoTZcPQf7iovPynmsMc6Z0HWspzUiDIVVC3Otv8O9DnPksRA/X9dcr2iFZyoscHfSpTfwt+llxIr+RLK8UtROPXymxKuEsEnh7UaBhdGaTIYGhDRTiWb3kINE5ix9PZmoiNWC4cPIHxcP12NpV8xF6Uyg5MEb1qJJc31uLUHa+G6hF9FZD7gewdwOW1tWq/BQEWA0UorNz60ucoiFCTrnL4VaLZU0wjb+en1E7fXe817DVv+7IWXlAbJQktzoQPrG9+h6tVu6RsYNod5CXAq7k/M9TLmk3PfLqkxkBtLyta2nVPlOS2DnJdXx8cVs2vMMLYGm+Z0c/PwvMCLiXnCKarWBrDot+LlFfX+fXrTTLxqXGb+0xPI/5M+b/ODMjWXzTTqiq5/KiV47yz5HPfn+1c4dqll3jw1tmYeVZWre1QfKR8toXHzw9LDH8TtLBSEx1IygOOAdfbVK8WUB2VXCBFZ7camm/05x21cDw=
X-MS-Exchange-AntiSpam-MessageData: SQuFLFS6t31cGvVWUXmO7O1Gemd7hpec8TUZa3c9DQFbxkdb/D3vF6yZ8OtABsBn8Oh1NYW6E1C20r8qNHoHmAf6TVe+kA9w+E02PT3B1/0lqIKnNDbnFyRCmoz/bAywTsIuE80igQvApkhK3c6ljQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b24344-02f6-4eb8-dfa0-08d7c1358419
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 18:46:29.4927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZUQo+Wql/ir3wexBpXgsezIE+7EkV0lIJ1Lb2+b7LAtooa49gHUP6ZDTCgxvU2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMy0wNSAwMToyMywgTmlybW95IHdyb3RlOgo+IAo+IE9uIDMvNC8yMCAxMTowMCBQ
TSwgTHViZW4gVHVpa292IHdyb3RlOgo+PiBPbiAyMDIwLTAzLTAzIDc6NTAgYS5tLiwgTmlybW95
IERhcyB3cm90ZToKPj4+IGltcGxlbWVudCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZCgp
IHdoaWNoIGNhbiBtb2RpZnkgZXhpc3RpbmcKPj4+IHNjaGVkX2xpc3Qgd2l0aCBhIGRpZmZlcmVu
dCBvbmUuIFRoaXMgaXMgZ29pbmcgdG8gYmUgaGVscGZ1bCB3aGVuCj4+PiB1c2Vyc3BhY2UgY2hh
bmdlcyBwcmlvcml0eSBvZiBhIGN0eC9lbnRpdHkgdGhlbiBkcml2ZXIgY2FuIHN3aXRjaCB0bwo+
Pj4gY29ycmVzcG9uZGluZyBodyBzaGNlZCBsaXN0IGZvciB0aGF0IHByaW9yaXR5Cj4+Pgo+PiBU
aGlzIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBzdGFydCB3aXRoIGEgY2FwaXRhbGl6ZWQgc2VudGVu
Y2U6Cj4+ICJpbXBsZW1lbnQiIC0tPiAiSW1wbGVtZW50Ii4gICJjYW4gbW9kaWZ5IiAtLT4gIm1v
ZGlmaWVzIgo+Pgo+PiBBbHNvIGEgc3BlbGwgY2hlY2sgc2hvdWxkIGJlIGRvbmUgb24gaXQgYmVm
b3JlIGNvbW1pdHRpbmc6Cj4+ICJzaGNlZCIgLS0+ICJzY2hlZCIuCj4+Cj4+ICJ0aGVuIHRoZSBk
cml2ZXIiLCAidG8gdGhlIGNvcnJlc3BvbmRpbmciLCAiSFcgc2NoZWR1bGVyIi4KPj4KPj4gQW5k
IHRoZSBjb21taXQgbWVzc2FnZSBwYXJhZ3JhcGggc2hvdWxkIGVuZCB3aXRoIGEgcGVyaW9kLgo+
IFRoYW5rcyEKPj4KCkEgZGlmZmljdWx0IHRvIHNlZSBjb21tZW50IG9mIHlvdXJzIGFib3ZlPwpX
aHkgbm90IGFkZCBhbiBlbXB0eSBsaW5lIGJlZm9yZSBhbmQgYWJvdmUgeW91ciBjb21tZW50cz8K
QXJlIHlvdSB0cnlpbmcgdG8gbWFrZSB0aGVtIGhhcmQgdG8gZmluZD8KCj4+PiBTaWduZWQtb2Zm
LWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+PiBSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4gLS0tCj4+PiAgIGRy
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgfCAxOSArKysrKysrKysrKysr
KysrKysrCj4+PiAgIGluY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaCAgICAgICAgICAgICAgfCAg
NCArKysrCj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIGIvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4gaW5kZXggNjNiY2NkMjAx
Yjk3Li5iOTQzMTIxNTRlNTYgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX2VudGl0eS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCj4+PiBAQCAtODMsNiArODMsMjUgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlf
aW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+Pj4gICB9Cj4+PiAgIEVYUE9S
VF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9pbml0KTsKPj4+Cj4+PiArLyoqCj4+PiArICogZHJt
X3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQgLSBNb2RpZnkgc2NoZWQgb2YgYW4gZW50aXR5Cj4+
PiArICoKPj4gVGhpcyBlbXB0eSBsaW5lIGlzIHVubmNlc3NhcnkuCj4+Cj4+PiArICogQGVudGl0
eTogc2NoZWR1bGVyIGVudGl0eSB0byBpbml0Cj4+PiArICogQHNjaGVkX2xpc3Q6IHRoZSBsaXN0
IG9mIG5ldyBkcm0gc2NoZWRzIHdoaWNoIHdpbGwgcmVwbGFjZQo+Pj4gKyAqCQlleGlzdGluZyBl
bnRpdHktPnNjaGVkX2xpc3QKPj4+ICsgKiBAbnVtX3NjaGVkX2xpc3Q6IG51bWJlciBvZiBkcm0g
c2NoZWQgaW4gc2NoZWRfbGlzdAo+Pj4gKyAqLwo+Pj4gK3ZvaWQgZHJtX3NjaGVkX2VudGl0eV9t
b2RpZnlfc2NoZWQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPj4+ICsJCQkJICBz
dHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKipzY2hlZF9saXN0LAo+Pj4gKwkJCQkgIHVuc2lnbmVk
IGludCBudW1fc2NoZWRfbGlzdCkKPj4+ICt7Cj4+PiArCVdBUk5fT04oIW51bV9zY2hlZF9saXN0
IHx8ICFzY2hlZF9saXN0KTsKPj4+ICsKPj4+ICsJZW50aXR5LT5zY2hlZF9saXN0ID0gc2NoZWRf
bGlzdDsKPj4+ICsJZW50aXR5LT5udW1fc2NoZWRfbGlzdCA9IG51bV9zY2hlZF9saXN0Owo+Pj4g
K30KPj4+ICtFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKTsKPj4+
ICsKPj4+ICAgLyoqCj4+PiAgICAqIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZSAtIENoZWNrIGlm
IGVudGl0eSBpcyBpZGxlCj4+PiAgICAqCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZ3B1
X3NjaGVkdWxlci5oIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+PiBpbmRleCA1ODli
ZTg1MWY4YTEuLmY3MGE4NGFhYWY3YSAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvZHJtL2dwdV9z
Y2hlZHVsZXIuaAo+Pj4gKysrIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+PiBAQCAt
Mjk3LDYgKzI5NywxMCBAQCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVk
dWxlciAqc2NoZWQpOwo+Pj4gICBpbnQgZHJtX3NjaGVkX2pvYl9pbml0KHN0cnVjdCBkcm1fc2No
ZWRfam9iICpqb2IsCj4+PiAgIAkJICAgICAgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRp
dHksCj4+PiAgIAkJICAgICAgIHZvaWQgKm93bmVyKTsKPj4+ICt2b2lkIGRybV9zY2hlZF9lbnRp
dHlfbW9kaWZ5X3NjaGVkKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4+PiArCQkJ
CSAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2NoZWRfbGlzdCwKPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0KTsKPj4+
ICsKPiBUaGlzIGdlbmVyYWxseSBkb2Vzbid0IGhhcHBlbiB3aXRoIG15IGN1cnJlbnQgdmkgY29u
ZmlnLiBJIHdpbGwgYmUgZXh0cmEgCj4gY2FyZWZ1bC4KPj4gQWdhaW4sIHRoZSBhcmd1bWVudCBs
aXN0IGhlcmUgaXMgdW5hbGlnbmVkLiBQbGVhc2UgYWxpZ24gaXQKCkFub3RoZXIgaGFyZCB0byBz
ZWUgYW5kIGZpbmQgY29tbWVudCBmcm9tIHlvdS4gV2h5PyBXaHkgbm90CnRha2UgdGhlIGV4dHJh
IGNhcmUgYW5kIGRpbGlnZW5jZSB0byBhZGQgYW4gZW1wdHkgbGluZSBiZWZvcmUKYW5kIGFmdGVy
IHlvdXIgY29tbWVudCwgc28gdGhhdCBpdCBpcyBlYXN5IHRvIHNlZT8gV2h5IGRvIHlvdSBkbyB0
aGlzPwoKSSB0aGluayBpdCBpcyAiZ2VuZXJhbGx5IiB1bmFsaWduZWQgY29taW5nIGZyb20geW91
IGFzIHlvdSBjYW4Kc2VlIGluIHRoZSByZXZpZXdzIGluIHRoaXMgbGlzdC4gQ29uZmlndXJlICJ2
aSIgb3IgdXNlIHNvbWV0aGluZwplbHNlLCAiRW1hY3MiLCBldGMuCgpSZWdhcmRzLApMdWJlbgoK
Pj4gY29ycmVjdGx5LiBUaGUgY29ycmVjdCBpbmRlbnRhdGlvbiB3b3VsZCBhZGQgdGhlIG1heGlt
dW0gbnVtYmVyIG9mCj4+IGxlYWRpbmcgVEFCIGNoYXJzIGZvbGxvd2VkIGJ5IHRoZSAwIHRvIDcg
c3BhY2VzLCB0byBhbGlnbgo+PiB0aGUgYXJndW1lbnQgbGlzdCB0byB0aGUgZmlyc3QgYXJndW1l
bnQgaW4gdGhlIG9wZW5pbmcgcGFyZW50aGVzaXMuCj4+IFRoZSBMS0NTIGRlc2NyaWJlcyB0aGlz
IGFuZCBhbHNvIGhhcyB0aGUgc2V0dGluZ3MgZm9yIEVtYWNzLgo+PiBJbiBFbWFjcywgcHJlc3Np
bmcgdGhlIFRBQiBrZXkgYWxpZ25zLCBhZnRlciB3aGljaCBwcmVzc2luZyBpdCBtb3JlCj4+IGRv
ZXMgbm90aGluZyAob24gYW4gYWxpZ25lZCBsaW5lKS4KPj4KPj4gUmVnYXJkcywKPj4gTHViZW4K
Pj4KPj4KPj4+ICAgdm9pZCBkcm1fc2NoZWRfam9iX2NsZWFudXAoc3RydWN0IGRybV9zY2hlZF9q
b2IgKmpvYik7Cj4+PiAgIHZvaWQgZHJtX3NjaGVkX3dha2V1cChzdHJ1Y3QgZHJtX2dwdV9zY2hl
ZHVsZXIgKnNjaGVkKTsKPj4+ICAgdm9pZCBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dwdV9z
Y2hlZHVsZXIgKnNjaGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKTsKPj4+IC0tCj4+PiAy
LjI1LjAKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlz
dGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NsdWJlbi50dWlrb3YlNDBhbWQuY29t
JTdDYmU4NDQ1OTQ1YzE5NGJkOGIzY2MwOGQ3YmY3MTA5YzUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUx
MWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTg4MzY0NTU3MzU0MjE3JmFtcDtzZGF0YT1VQXhW
Mk50a05jajZWWEFQaERiazRHbGlVT25QRWZ1TE9INEJWdU9ycWR3JTNEJmFtcDtyZXNlcnZlZD0w
Cj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
