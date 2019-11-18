Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C505C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 14:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA25520656
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 14:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA25520656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707B66E0D3;
	Mon, 18 Nov 2019 14:17:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536576E0D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 14:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl+mfHjTfUuK0ki0fvUHY6aWkRahrJmr4bc42BZ6ChZpQ5H8k+ei5M7pBWb3JKJkli5ooyd9B/oYrMpStsd+otwxa9T/FXBKzt4Hnk7gOs7fXGHYTFXO1UEUd0A0I7nP3Etp9qsr/ghU2M0SVrO1z7hXToTxHN1x/QN6lB1iCgR+z2dFR99EmdZiNiJwG7nvMkMAfUrAXjMxJp1MEj8Uq32UPjqXUX1E6xaDuaM7B4ex6U7wzUxP/nWg+iFrqeji3YnhRak67yTn+h9uMWs2a3nMhax+YinJgDLll4ElWshniAnhLypPp6NJw/naajC8w4DowEdXYMeNUC8aQvrYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9rk5ms6vsOiFGiSK0Or0iXU5PWqQgqAUO4bfnlMESo=;
 b=UltEvPNwDnfZTS2B76Tb7Uw1wj+OuPurYfAK/bnVwAiHBfKYzm3cEnrH+7VUH1xyr28HX1yI/oq3Og82+JuqHlYHTxbRbDjQwSUTIJ9UryIY498oeqJ8oLRTks1JAqpysajFdk64JOwqm/s0FEXztdeD3031RMw27vZ82LBLq5bmNs+Wo9i0PURNNSXlaWbJOvLexF0PpSpcq0osSOjqAtfaREbgWi/UpfmteKWJMmeCEIQbqQ5hCxTqmql51enXZN3rF9ZZoP0hAJB0E5tXEC5I0SdoPJ6mhdEXxSSsNUBW9ghk2hrTZRNSgWpbiUL+QsshFZOFCAg78NmsJ8rdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 14:17:35 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 14:17:35 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/ras: Extract amdgpu_ras_save_bad_pages
 from amdgpu_ras_reserve_bad_pages
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
 <MN2PR12MB3054761DA7F4EDEC9975F8AAB0710@MN2PR12MB3054.namprd12.prod.outlook.com>
 <63578cfb-83c2-6887-b7da-7715ef6ed3a9@amd.com>
 <9ac78bf3-664b-ba1a-8579-bb802e3860e4@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2f19f3e7-d367-b6ba-0c93-f156213cfbf5@amd.com>
Date: Mon, 18 Nov 2019 15:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <9ac78bf3-664b-ba1a-8579-bb802e3860e4@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1ee9f8a-9381-4594-60a3-08d76c320e9a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB173766A7306C8582CB1A8AFD834D0@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(13464003)(76176011)(31686004)(14454004)(478600001)(2906002)(2870700001)(25786009)(99286004)(6486002)(6436002)(486006)(52116002)(110136005)(58126008)(2486003)(4326008)(316002)(966005)(54906003)(14444005)(476003)(6246003)(6306002)(23676004)(6512007)(446003)(5660300002)(36756003)(50466002)(46003)(8936002)(53546011)(86362001)(6666004)(11346002)(229853002)(386003)(6116002)(31696002)(6506007)(2616005)(65806001)(65956001)(47776003)(8676002)(81156014)(81166006)(2501003)(7736002)(305945005)(66556008)(66946007)(66476007)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1737;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwR4V8LZpaBckrZAPNVtmVv3MtzxHWJd49i+jhup6XaZ3i2FRr+3kboMZNj5IScNCE+S4uV1bZ91f0fPdphGv/rgExQ50q2NvhjGz25d+ww3eiOluyNMrUzs3HCgG19xShVnJg0WGWzYa92ZAXW1RCK8036ZIG4UUy04WoMpC5A6DV//Vn7QwKeANA/g+weJh9AorQ3l4z9AMj6HGsHRBUf04M9nCJVq0/NJQv80QDeYeNz6uVsLFIhM0TYziIGLBPxLGL3fkRIHoyE0/Oyf9OD/mLQV1Hd5eAebXCV+PAfT8ScxI7DAUVZAyknIV3zy8Xs2GvUoI8vVe82nTbpJWwEP30qzVIxoPbtwUqoJQZi67O/fXcml46q4n/L1P45vs6hANh0i1wnDjFAGGkAvRMGDCX26UXfPa7Yt4SSGaNMAkZsdS827hQdKpnyGKSYstkAO4AqJLxreSHh2h0GXZboCNRZWjqeCbK3V/O0F1B4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ee9f8a-9381-4594-60a3-08d76c320e9a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 14:17:34.8566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+0slrSKAY4MmRiVWXn5lNX0yaTQKsUNEaqIGE8DSu4REIqw38Sxwi3Aon/mdxY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9rk5ms6vsOiFGiSK0Or0iXU5PWqQgqAUO4bfnlMESo=;
 b=1oiSPbwVGp7e3u9IhftZCALBu+yr3bAis22gMzawrtiz6Jpg+yAdJnLDpQjh33dbeR7sQzPswXLlbFZi76t2AIq+29uzfEX51efF6B/Fjybtdjv37+kkv5o06utV8CZSwSD4NQTJudcd7mX3qQdrsGjiHqk8nYTBbd6PsS6hWmY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118141727.7noWWeDB2zXshyFvkyEKpVXE0b7O4pL9K3ESOpJDYyU@z>

QW0gMTguMTEuMTkgdW0gMTU6MDUgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBDaHJpc3Rp
YW4gLSBwaW5nLgo+Cj4gQW5kcmV5Cj4KPiBPbiAxMS8xNC8xOSAxMTo0MSBBTSwgQW5kcmV5IEdy
b2R6b3Zza3kgd3JvdGU6Cj4+Cj4+IE9uIDExLzEzLzE5IDEwOjA5IFBNLCBaaG91MSwgVGFvIHdy
b3RlOgo+Pj4gVHdvIHF1ZXN0aW9uczoKPj4+Cj4+PiAxLiAid2UgbG9zZSBhbGwgcmVzZXJ2YXRp
b24gZHVyaW5nIEFTSUMgcmVzZXQiCj4+PiBBcmUgeW91IHN1cmUgb2YgaXQ/IEkgcmVtZW1iZXIg
dGhlIGNvbnRlbnQgb2YgdnJhbSBtYXkgYmUgbG9zdCBhZnRlciAKPj4+IHJlc2V0IGJ1dCB0aGUg
YWxsb2NhdGVkIHN0YXR1cyBjb3VsZCBiZSByZXNlcnZlZC4KPj4KPj4gWWVhLCBub3cgdGhhdCBJ
IGFtIHRoaW5raW5nIG9mIGl0IEkgdGhpbmsgaSBtaWdodCBoYXZlIGNvbmZ1c2VkIGl0IAo+PiB3
aXRoIEJPIGNvbnRlbnQgcmVjb3ZlcnkgaW4gYW1kZ3B1X2RldmljZV9yZWNvdmVyX3ZyYW0gZm9y
IHNoYWRvdyAKPj4gYnVmZmVycyB3aGljaCBhcmUgcGFnZSB0YWJsZXMgb25seSBidXQganVzdCBm
b3IgVlJBTSByZXNlcnZhdGlvbiAKPj4gc3RhdHVzIHRoaXMgbWlnaHQgYmUgaXJyZWxldmFudC4u
LiBDaHJpc3RpYW4gLSBjYW4geW91IGNvbmZpcm0gVGFvIGlzIAo+PiBjb3JyZWN0IG9uIHRoaXMg
PwoKWWVhaCwgdGhhdCBpcyBjb3JyZWN0LiBUaGUgQk8gc3RydWN0dXJlIHN0YXlzLCBqdXN0IHRo
ZSBjb250ZW50IGlzIGxvc3QuCgpZb3UgZ3V5cyBzaG91bGQgbWF5YmUgY29uc2lkZXIgbW92aW5n
IGFsbCB0aGF0IHN0dWZmIGludG8gCmFtZGdwdV92cmFtX21nci5jLiBJdCBpcyBmYXIgZWFzaWVy
IHRvIGhhbmRsZSB0aGVyZSBiZWNhdXNlIHlvdSBkb24ndCAKbmVlZCB0byBjYXJlIGFib3V0IG1l
bW9yeSB3aGljaCBpcyBjdXJyZW50bHkgYWxsb2NhdGVkLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
Pj4KPj4+Cj4+PiAyLiBZb3UgY2hhbmdlIHRoZSBiYWQgcGFnZSBoYW5kbGUgZmxvdyBmcm9tOgo+
Pj4KPj4+IGRldGVjdCBiYWQgcGFnZSAtPiByZXNlcnZlIHZyYW0gZm9yIGJhZCBwYWdlIC0+IHNh
dmUgYmFkIHBhZ2UgaW5mbyAKPj4+IHRvIGVlcHJvbSAtPiBncHUgcmVzZXQKPj4+Cj4+PiB0bzoK
Pj4+Cj4+PiBkZXRlY3QgYmFkIHBhZ2UgKHRoaXMgdGltZSkgLT4gc2F2ZSBiYWQgcGFnZSAobGFz
dCB0aW1lKSBpbmZvIHRvIAo+Pj4gZWVwcm9tIC0+IGdwdSByZXNldCAtPiByZXNlcnZlIHZyYW0g
Zm9yIGJhZCBwYWdlICh0aGlzIHRpbWUpCj4+Cj4+IEV2ZW4gdGhvdWdoIGlmIEkgYW0gd3Jvbmcg
b24gdGhlIGZpcnN0IHBvaW50IHRoaXMgaXMgaXJyZWxldmFudCBidXQgCj4+IHN0aWxsIC0gV2h5
IHNhdmluZyBiYWQgcGFnZSBpcyBmcm9tIGxhc3QgdGltZSA/IFNlZSAKPj4gaHR0cHM6Ly9jZ2l0
LmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXgvdHJlZS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmM/aD1hbWQtc3RhZ2luZy1kcm0tbmV4dCNuMTQzNiAKPj4gLSB0aGUg
c2F2ZSBjb3VudCBpcyB0aGUgbGF0ZXN0IHNvIGFzIHRoZSBjb250ZW50IG9mIAo+PiBkYXRhLT5i
cHNbY29udHJvbC0+bnVtX3JlY3NdIHVwIHRvIGRhdGEtPmJwc1tjb250cm9sLT5udW1fcmVjcyAr
IAo+PiBzYXZlX2NvdW50XSBhcyB0aG9zZSBhcmUgdXBkYXRlZCBpbiAKPj4gYW1kZ3B1X3VtY19w
cm9jZXNzX3Jhc19kYXRhX2NiLT5hbWRncHVfcmFzX2FkZF9iYWRfcGFnZXMgd2hpY2ggaXMgCj4+
IGNhbGxlZCByaWdodCBCRUZPUkUgYW1kZ3B1X3Jhc19yZXNldF9ncHUtPmFtZGdwdV9yYXNfc2F2
ZV9iYWRfcGFnZXMgCj4+IGluIHRoZSBpbnRlcnJ1cHQgc2VxdWVuY2UKPj4KPj4gQW5kcmV5Cj4+
Cj4+Cj4+Pgo+Pj4gSXMgdGhhdCByaWdodD/CoCBTYXZpbmcgYmFkIHBhZ2UgKHRoaXMgdGltZSkg
aW5mbyB0byBlZXByb20gaXMgCj4+PiBkZWxheWVkIHRvIHRoZSBuZXh0IHRpbWUgdGhhdCBiYWQg
cGFnZSBpcyBkZXRlY3RlZD8gQnV0IHRoZSB0aW1lIG9mIAo+Pj4gZGV0ZWN0aW5nIGJhZCBwYWdl
IGlzIHJhbmRvbS4KPj4+IEkgdGhpbmsgdGhlIGJhZCBwYWdlIGluZm8gd291bGQgYmUgbG9zdCB3
aXRob3V0IHNhdmluZyB0byBlZXByb20gaWYgCj4+PiBwb3dlciBvZmYgb2NjdXJzLgo+Pj4KPj4+
IGRldGVjdCBiYWQgcGFnZSAodGhpcyB0aW1lKSAtPiBzYXZlIGJhZCBwYWdlIChsYXN0IHRpbWUp
IGluZm8gdG8gCj4+PiBlZXByb20gLT4gZ3B1IHJlc2V0IC0+IHJlc2VydmUgdnJhbSBmb3IgYmFk
IHBhZ2UgKHRoaXMgdGltZSkgLT4gCj4+PiBwb3dlcm9mZi9zeXN0ZW0gcmVzZXQgKGFuZCBiYWQg
cGFnZSBpbmZvICh0aGlzIHRpbWUpIGlzIGxvc3QpCj4+Pgo+Pj4gVGFvCj4+Pgo+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mCj4+Pj4gQW5kcmV5IEdyb2R6b3Zz
a3kKPj4+PiBTZW50OiAyMDE55bm0MTHmnIgxNOaXpSA2OjQ1Cj4+Pj4gVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4gQ2M6IGFsZXhkZXVjaGVyQGdtYWlsLmNvbTsgR3JvZHpv
dnNreSwgQW5kcmV5Cj4+Pj4gPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+OyBDaGVuLCBHdWNo
dW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+Owo+Pj4+IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+Cj4+Pj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdS9yYXM6IEV4
dHJhY3QKPj4+PiBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzIGZyb20gYW1kZ3B1X3Jhc19yZXNl
cnZlX2JhZF9wYWdlcwo+Pj4+Cj4+Pj4gV2Ugd2FudCB0byBiZSBiZSBhYmxlIHRvIGNhbGwgdGhl
bSBpbmRlcGVuZGVudGx5IGZyb20gb25lIGFub3RoZXIgCj4+Pj4gc28gdGhhdAo+Pj4+IGJlZm9y
ZSBHUFUgcmVzZXQganVzdCBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzIGlzIGNhbGxlZC4KPj4+
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNr
eUBhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYyB8IDE0ICsrKystLS0tLS0tLS0tCj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5oIHzCoCA0ICsrKy0KPj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPj4+PiBpbmRleCA0MDQ0ODM0Li42MDBhODZkIDEw
MDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+Pj4+IEBA
IC0xNDIxLDcgKzE0MjEsNyBAQCBpbnQgYW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKHN0cnVjdAo+
Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4gwqDCoCAqIHdyaXRlIGVycm9yIHJlY29yZCBh
cnJheSB0byBlZXByb20sIHRoZSBmdW5jdGlvbiBzaG91bGQgYmUKPj4+PiDCoMKgICogcHJvdGVj
dGVkIGJ5IHJlY292ZXJ5X2xvY2sKPj4+PiDCoMKgICovCj4+Pj4gLXN0YXRpYyBpbnQgYW1kZ3B1
X3Jhc19zYXZlX2JhZF9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4+PiAraW50
IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+
Pj4gwqAgewo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9IGFtZGdwdV9y
YXNfZ2V0X2NvbnRleHQoYWRldik7Cj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcmFzX2Vycl9oYW5k
bGVyX2RhdGEgKmRhdGE7Cj4+Pj4gQEAgLTE1MjAsNyArMTUyMCw3IEBAIGludCBhbWRncHVfcmFz
X3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdAo+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+Pj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgcmFzX2Vycl9oYW5kbGVyX2RhdGEgKmRhdGE7Cj4+Pj4gwqDCoMKg
wqDCoCB1aW50NjRfdCBicDsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKmJvID0g
TlVMTDsKPj4+PiAtwqDCoMKgIGludCBpLCByZXQgPSAwOwo+Pj4+ICvCoMKgwqAgaW50IGk7Cj4+
Pj4KPj4+PiDCoMKgwqDCoMKgIGlmICghY29uIHx8ICFjb24tPmVoX2RhdGEpCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+IEBAIC0xNTQ4LDEyICsxNTQ4LDkgQEAgaW50IGFt
ZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFnZXMoc3RydWN0Cj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRl
dikKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+bGFzdF9yZXNlcnZlZCA9IGkgKyAxOwo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBibyA9IE5VTEw7Cj4+Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4g
LQo+Pj4+IC3CoMKgwqAgLyogY29udGludWUgdG8gc2F2ZSBiYWQgcGFnZXMgdG8gZWVwcm9tIGV2
ZW4gcmVlc3J2ZV92cmFtIAo+Pj4+IGZhaWxzICovCj4+Pj4gLcKgwqDCoCByZXQgPSBhbWRncHVf
cmFzX3NhdmVfYmFkX3BhZ2VzKGFkZXYpOwo+Pj4+IMKgIG91dDoKPj4+PiDCoMKgwqDCoMKgIG11
dGV4X3VubG9jaygmY29uLT5yZWNvdmVyeV9sb2NrKTsKPj4+PiAtwqDCoMKgIHJldHVybiByZXQ7
Cj4+Pj4gK8KgwqDCoCByZXR1cm4gMDsKPj4+PiDCoCB9Cj4+Pj4KPj4+PiDCoCAvKiBjYWxsZWQg
d2hlbiBkcml2ZXIgdW5sb2FkICovCj4+Pj4gQEAgLTE2MTUsMTQgKzE2MTIsMTEgQEAgaW50IGFt
ZGdwdV9yYXNfcmVjb3ZlcnlfaW5pdChzdHJ1Y3QKPj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBhbWRncHVfcmFzX2xvYWRfYmFkX3BhZ2VzKGFk
ZXYpOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gZnJlZTsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0ID0gYW1kZ3B1
X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhhZGV2KTsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJl
dCkKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHJlbGVhc2U7Cj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGFtZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFnZXMoYWRldik7Cj4+Pj4gwqDCoMKg
wqDCoCB9Cj4+Pj4KPj4+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+Cj4+Pj4gLXJlbGVhc2U6
Cj4+Pj4gwqDCoMKgwqDCoCBhbWRncHVfcmFzX3JlbGVhc2VfYmFkX3BhZ2VzKGFkZXYpOwo+Pj4+
IMKgIGZyZWU6Cj4+Pj4gwqDCoMKgwqDCoCBrZnJlZSgoKmRhdGEpLT5icHMpOwo+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKPj4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAo+Pj4+IGluZGV4IGY4MGZkMzQu
LjEyYjA3OTcgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5oCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5oCj4+Pj4gQEAgLTQ5Miw2ICs0OTIsOCBAQCB1bnNpZ25lZCBsb25nCj4+Pj4gYW1kZ3B1X3Jh
c19xdWVyeV9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50Cj4+Pj4g
YW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZWVwcm9tX3RhYmxlX3JlY29yZCAqYnBzLCBpbnQg
cGFnZXMpOwo+Pj4+Cj4+Pj4gK2ludCBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsKPj4+PiArCj4+Pj4gwqAgaW50IGFtZGdwdV9yYXNfcmVzZXJ2
ZV9iYWRfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+Pj4+Cj4+Pj4gwqAgc3Rh
dGljIGlubGluZSBpbnQgYW1kZ3B1X3Jhc19yZXNldF9ncHUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
Cj4+Pj4gKmFkZXYsIEBAIC0KPj4+PiA1MDMsNyArNTA1LDcgQEAgc3RhdGljIGlubGluZSBpbnQg
YW1kZ3B1X3Jhc19yZXNldF9ncHUoc3RydWN0Cj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+
PiDCoMKgwqDCoMKgwqAgKiBpMmMgbWF5IGJlIHVuc3RhYmxlIGluIGdwdSByZXNldAo+Pj4+IMKg
wqDCoMKgwqDCoCAqLwo+Pj4+IMKgwqDCoMKgwqAgaWYgKGluX3Rhc2soKSkKPj4+PiAtwqDCoMKg
wqDCoMKgwqAgYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhhZGV2KTsKPj4+PiArwqDCoMKg
wqDCoMKgwqAgYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyhhZGV2KTsKPj4+Pgo+Pj4+IMKgwqDC
oMKgwqAgaWYgKGF0b21pY19jbXB4Y2hnKCZyYXMtPmluX3JlY292ZXJ5LCAwLCAxKSA9PSAwKQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZHVsZV93b3JrKCZyYXMtPnJlY292ZXJ5X3dvcmsp
Owo+Pj4+IC0tIAo+Pj4+IDIuNy40Cj4+Pj4KPj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+Pj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
