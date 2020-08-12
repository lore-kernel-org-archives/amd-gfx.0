Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07BEC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD29206B2
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ffq4+bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD29206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344F16E0D0;
	Wed, 12 Aug 2020 12:36:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C346E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 12:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/hBD4Gs9G/F4KL3k3bnT90JuHVwrAX8XWSJOb/Uc0XC/jgyU3gYWE8NlD6yRH6m6gFM8ISgxqXWQzF0UfuyzuOlq1TLtCdeu2SzkvwVYq1HJJXt8FqJNINbWZxwI8FL4j1eaDN9EQN20dlbMh1SiK7JQff31BGJ5LyFYd7v3yAa/6Bm1gQKNtbSAWAXiEunl0rDSU8Wd05QFfq1BDxN6BTNb7IqcTIhQ21aez0NFb05Bv5xfN/O7nwn6PY8cnTJX9L5cqX3Hema8q7w5DMSIdHS4DWQ5GU8A05TiW9kBMMhCcnqa44JDOV3q7iWo/JTFikrJ+vgR1Mz5zaTr84tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSNrjnikrCh5MkDni9rWI3xB2DcGD3dkaWlVE4MF7Qw=;
 b=ZARfRJYqV9FGON5ZeZtXDd6TvSezygY4CsPug7Jdj/SSpHMeSTI3nBFNXdLJdBiY38jftCv0hVl4+E71Y94T/T3GJCbBcJ07OhFETP1NxboUUti9ILJQoCBi029jdf+MlUXXOPcI46z/Rh1j4V1OLPh9WBckTAt835PcRLbedp2z/HvwJ6g97Ww/Iuj9FBbsoHenUE9X258pTfvsYY3H5rAdpyR47LTWLjrBxTQjURfnTTy6Lq9Kp6vL8F+dXGzS7Lg49Mas1JGa7d8mk2JN3DDOtKP7XBSQjID0TJ64cYHImYKbkt8/YZ9iB3IHrux6l0XAwgiKvHQbzPkI+iHhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSNrjnikrCh5MkDni9rWI3xB2DcGD3dkaWlVE4MF7Qw=;
 b=2ffq4+bJVxddJuzz6UzU1+JJ5VZ7FALEYNa+SPNv4YDldgwG1rbgFyPqk8KIUT79GOHfQwLaagRD21lVnatO/tH0n0edg3hpEeStlxkjJYplsDL1KnnOT1flRQZ/Bi9w8aXpk8FLgaIpTUuLGQQGe+MqProbl1hoBU+O8Jnywk8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 12:36:44 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 12:36:44 +0000
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200812122030.215907-1-tom.stdenis@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <6352188c-e508-37d4-a021-02c31e6ca855@amd.com>
Date: Wed, 12 Aug 2020 14:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200812122030.215907-1-tom.stdenis@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::28) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.126.106) by
 AM0PR07CA0015.eurprd07.prod.outlook.com (2603:10a6:208:ac::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 12 Aug 2020 12:36:43 +0000
X-Originating-IP: [217.86.126.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 244eee40-07bf-4a10-49f6-08d83ebc5efc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3914:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3914A98D33BC88409DE6BF0B8B420@DM6PR12MB3914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3wnENP0AD7J/sX79Om+QlhRJ0cnCm1vgsmkXaYXeu0z17/kTg0oK6jYckFgPU6pz7c/oMaFcALTU2eneQxMxqA20IKSuVE8UZ6yexoOwQQIQIguQH8sEnP8XrIdqh3wruYt/QT39Gr+hFyxxHT92ggnZmfzIVgn+y1yruvDP9xPnv5yZFIBSLJdm0vm1dRY0jODBKU+nTO57wtX0+JJdNzVWrLs6M5hScbwTPW4T+Sd9N6jNQ1AVEew3TfajcsmMXjG0II846qA1s9bd4X5HYwsFQ2CoI3/hC0G2kYcSl8a3oKGd5Cro3ey+Kn+177AaqMiGlbZHZfk/JsWsjhjSURxrxk9aExodfEoJWPn8iQlPX1NO8u+0vdDsUnKqkyz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(5660300002)(956004)(66476007)(26005)(66556008)(186003)(66946007)(16526019)(31686004)(6666004)(2616005)(2906002)(8936002)(8676002)(478600001)(36756003)(16576012)(316002)(31696002)(53546011)(52116002)(83380400001)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wUa7ug2Sz80e6qP2vmorP4GH5Y4e6p3KYNGcE7kgX8uZSTUSniy57c1zyFZH/I5bA8g6Zw5jXYyTvlXMi8Y6npjnHOFNAU83zhyu+D9HFTd7Fhrkb++dNsNCPKsTaho1QXS8yIdmMFXnXiOTgK50eMiK+Kz8awE2t35ZtNgNylyzHG0L2HLE6u2xQVHLQVNzPparu3x1oLqUqL1cTOd8CRM3QMq4tKg4X/SV7FQTl/td3J5lHHb9rOEFv/ODb9CN6cHLYfNkeT3uhki5aLzA7CrtMimppzLg1pAnzgiXW35pYWF8edaNGmsVrLR42GQo9aas8Ih/wbKT0LOtbi1sTOoq+TU0TyBC8bo1Api/lC91DakMPJ0sNqHFdh0UrjFRtBomP91G9YbgYJH+C7UlKfMmkkR6UhFDhGlzPbqpyJyaFbLBxOL0erFlUIRA2iOOWWs25VE1jHs0IAhxvMu4uYsD4NtLXJktxkHqhWxNymww+CTLzyrCJjI6yqXmLseDgAWSFJlK/udUZmQAmmAAg/r6xxBhwOs8Wu5wGz5hPk6ey3mlcXGZOKsdfn78DlmyrAXj/k3S4W+byeDQEEC5VFT44MfE7jTSoipcPAnHKugu575rJJRKv34bnSr/O8/biU4+/Bt/abxTBaexrzTq4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244eee40-07bf-4a10-49f6-08d83ebc5efc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 12:36:44.4729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nvwdgd0bfya9FsQxboF6GER83vfpElh7A/pwQJpdBEo/EeJYHXNtevjIpaGrKxBkme6g92xxTwWH6XJIdth6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3914
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

Ck9uIDgvMTIvMjAgMjoyMCBQTSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+IEZpeGVzOgo+Cj4gICAg
Q0MgW01dICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG1fbXN0X3R5cGVzLm8KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dl
cnBsYXkvYXJjdHVydXNfcHB0LmM6IEluIGZ1bmN0aW9uIOKAmGFyY3R1cnVzX2xvZ190aGVybWFs
X3Rocm90dGxpbmdfZXZlbnTigJk6Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG93
ZXJwbGF5L2FyY3R1cnVzX3BwdC5jOjIyMjM6MjQ6IHdhcm5pbmc6IOKAmHRocm90dGxlcl9zdGF0
dXPigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJl
LXVuaW5pdGlhbGl6ZWRdCj4gICAyMjIzIHwgICBpZiAodGhyb3R0bGVyX3N0YXR1cyAmIGxvZ2dp
bmdfbGFiZWxbdGhyb3R0bGVyX2lkeF0uZmVhdHVyZV9tYXNrKSB7Cj4KPiBieSBtYWtpbmcgYXJj
dHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoKSBhc3NpZ24gYSBkZWZhdWx0IHZhbHVlCj4gKG9m
IHplcm8pIGJlZm9yZSBhbnkgcG9zc2libGUgcmV0dXJuIHBvaW50IGFzIHdlbGwgYXMgc2ltcGx5
IGVycm9yCj4gb3V0IG9mIGFyY3R1cnVzX2xvZ190aGVybWFsX3Rocm90dGxpbmdfZXZlbnQoKSBp
ZiBpdCBmYWlscy4KPgo+IFNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNA
YW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVz
X3BwdC5jIHwgMTIgKysrKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FyY3R1cnVzX3BwdC5jCj4gaW5kZXggOGIxMDI1ZGM1NGZkLi43OGY3ZWM5NWU0ZjUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwo+IEBAIC01
NTEsNiArNTUxLDkgQEAgc3RhdGljIGludCBhcmN0dXJ1c19nZXRfc211X21ldHJpY3NfZGF0YShz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwKPiAgIAo+ICAgCW11dGV4X2xvY2soJnNtdS0+bWV0cmlj
c19sb2NrKTsKPiAgIAo+ICsJLy8gYXNzaWduIGRlZmF1bHQgdmFsdWUKPiArCSp2YWx1ZSA9IDA7
Cj4gKwo+ICAgCXJldCA9IHNtdV9jbW5fZ2V0X21ldHJpY3NfdGFibGVfbG9ja2VkKHNtdSwKPiAg
IAkJCQkJICAgICAgIE5VTEwsCj4gICAJCQkJCSAgICAgICBmYWxzZSk7Cj4gQEAgLTIyMDgsMTUg
KzIyMTEsMjAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0aHJvdHRsaW5nX2xvZ2dpbmdfbGFiZWwg
ewo+ICAgfTsKPiAgIHN0YXRpYyB2b2lkIGFyY3R1cnVzX2xvZ190aGVybWFsX3Rocm90dGxpbmdf
ZXZlbnQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCj4gICB7Cj4gLQlpbnQgdGhyb3R0bGVyX2lk
eCwgdGhyb3R0aW5nX2V2ZW50cyA9IDAsIGJ1Zl9pZHggPSAwOwo+ICsJaW50IHRocm90dGxlcl9p
ZHgsIHRocm90dGluZ19ldmVudHMgPSAwLCBidWZfaWR4ID0gMCwgcmV0Owo+ICAgCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Owo+ICAgCXVpbnQzMl90IHRocm90dGxlcl9z
dGF0dXM7CgoKSSB0aGluayBpbml0aWFsaXppbmcgdGhyb3R0bGVyX3N0YXR1cyBoZXJlIHNob3Vs
ZCByZXNvbHZlIHRoZSB3YXJuaW5nLgoKPiAgIAljaGFyIGxvZ19idWZbMjU2XTsKPiAgIAo+IC0J
YXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LAo+ICsJcmV0ID0gYXJjdHVydXNfZ2V0
X3NtdV9tZXRyaWNzX2RhdGEoc211LAo+ICAgCQkJCSAgICAgIE1FVFJJQ1NfVEhST1RUTEVSX1NU
QVRVUywKPiAgIAkJCQkgICAgICAmdGhyb3R0bGVyX3N0YXR1cyk7Cj4gICAKPiArCWlmIChyZXQp
IHsKPiArCQlkZXZfZXJyKGFkZXYtPmRldiwgIkNvdWxkIG5vdCByZWFkIGZyb20gYXJjdHVydXNf
Z2V0X3NtdV9tZXRyaWNzX2RhdGEoKVxuIik7Cj4gKwkJcmV0dXJuOwo+ICsJfQo+ICsKPiAgIAlt
ZW1zZXQobG9nX2J1ZiwgMCwgc2l6ZW9mKGxvZ19idWYpKTsKPiAgIAlmb3IgKHRocm90dGxlcl9p
ZHggPSAwOyB0aHJvdHRsZXJfaWR4IDwgQVJSQVlfU0laRShsb2dnaW5nX2xhYmVsKTsKPiAgIAkg
ICAgIHRocm90dGxlcl9pZHgrKykgewpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
