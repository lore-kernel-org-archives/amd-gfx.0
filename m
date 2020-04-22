Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2F5C55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 12:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022A92082E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZJhvygLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022A92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DD16E9EF;
	Wed, 22 Apr 2020 12:33:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12A56E9EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 12:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4WZGihRHsECwUKV2cwN94DlViZ1TKc6qZTA5DAvv4BMAiu3RzFBgqLVQhduP0O+0vXgyr/ioFcRl0HjHnNXo0KjfMOkeaSIkFvhgwgNSDTVG8CXDpA2CC1wDqxCEq5Xk+I5ecvQjI/zxJHqeu41n2wP4sjRFK/zKjIbDFF9luFqojmeDbKVB1oh5XSsIQ6Z8LVnnA8INbtpi7nBLomnkpKv0Q+2/rqQuKxGg0d16weHJunv6c61jeIXQuQp5ZXVcyPEBQIocHGHy1TLy2UC0jAcPF/EcC61O2lFsqpaZmpJ2gb0IM0HlJoUM8vYrpckaaSPV3ApSyTYf8lgXp8quA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+uzvKHbgWhuTgehWrD9nEA6tlG84FTZnL8D+BFF/eQ=;
 b=c9zTI+x3CMSJRZhTsSrTozo/thLFOxN1h+K+zKiv7QwcTaxiA8tlXtwSUlm9+swc6Cjf03rTSBqhnNVxmL9fU+Pco0vKLx9jQ7SGyw7DF/2garoainje+wdAQFFsWcUrrsajxZUvZnkXxUVixoEnANZbx3KZUoMqMw5R9Mm/b7D/eeHUyy7n9ImJFyWquP97qrWnSjXwHYPB9bGLCk5IPeNVWOnom3YQh5vXfAcCAljXA5EM87ndYgDJ6f2wa30c4XshL3dZ6GLDGdyXotEEqtJOLhKOdDHDerr7LtHCOK4nyMfeZEukyIXUw824tSlMZa9F5dfxmeUi0C0RG3Wq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+uzvKHbgWhuTgehWrD9nEA6tlG84FTZnL8D+BFF/eQ=;
 b=ZJhvygLKWic61F6qzzpGg/HyocMqcOgRX2vALK8ieJyfqJJ0nQ/lDwzD8c5xuBsswGJZlTsjhC86OCIwhS1Tv/bDj61dOfcjTf+Z+7iv3kChbJmgppn4WHfD71kdGlgyofblAvWwszzodv3GqSgtmOVrT5t569LU8Et4o9j0X9s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 12:33:19 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 12:33:19 +0000
Subject: Re: [PATCH] drm/amdgpu: refine kiq access register
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20200422092908.27434-1-yttao@amd.com>
 <27ab6479-5cee-60e2-aeea-cb2a156b508b@amd.com>
 <MN2PR12MB303908B7B6641EB69D30BD1DE5D20@MN2PR12MB3039.namprd12.prod.outlook.com>
 <d5984763-06b8-2460-24b4-18052f31bac5@amd.com>
 <MN2PR12MB3039E72087ED59AFAF5FC319E5D20@MN2PR12MB3039.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02f3f1a7-5bae-9aaa-47ca-74affe2b247b@amd.com>
Date: Wed, 22 Apr 2020 14:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3039E72087ED59AFAF5FC319E5D20@MN2PR12MB3039.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0080.eurprd07.prod.outlook.com
 (2603:10a6:207:6::14) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0080.eurprd07.prod.outlook.com (2603:10a6:207:6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.7 via Frontend Transport; Wed, 22 Apr 2020 12:33:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebd53575-3307-46a7-6e29-08d7e6b95640
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:|DM6PR12MB3483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB348357163F52B4EA378C39F083D20@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(66556008)(110136005)(316002)(4326008)(66476007)(2616005)(36756003)(5660300002)(66946007)(2906002)(6666004)(31696002)(52116002)(86362001)(6636002)(53546011)(186003)(8676002)(16526019)(478600001)(81156014)(8936002)(31686004)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AloYeN+MIobnHhdHYIQ9n0NiAFpm5S/tT05H9Qq51r27qYBlR/cCotd1Ux9iYmcQT6xf1SLRYk+NxzfCRbu2aMtWAqNFfCqcM42XbZTOTmc2/DNsFDy7J8sT1eVEtIioqBirIhhQLmh3RFS0MP8Gp1bGdmPzq33/DgxcLMLbEnZ4OBxl0jPLStaDhViBcBrym2vE627JHyeP3xZdoEf4ZvyYyrEmiYuNobklrnZYXZ49BwLZLCNj+F3b7nbU38OQp8jiTNo5yBqzVzu+IECYjT4DUE/8bth2wMRC6bQwDmrKTuXsVA37SnpQL53LwZgbwudWFO4XWcZskrXELzycSDRZ2yBC8+D0WwjnHEzzAalJ2Kb2uIKBD9iWfOAV59HQf9CT3a0OnfPb14a820epKKf2urnSF+Cqua+mU7B5Z/OuAVWWsRQAg0eDZDmN3SHq
X-MS-Exchange-AntiSpam-MessageData: 5Ama1AFrETUdZ0BYYxR4arNN2KaejkUukEvWxsPNyVAqHo5326PbtJHpFkPUQVwQxFH4m6U7zVp23EDBq6uGsXjNOCbmVy6a8M3xsyM2SvYV45uCo/p9n/QXuERbPJJ+x8lIsHww3guEM6VwWowqCXNECLin6xSNefclik0rHqGfHZqa9j0fZgWk7QmFSVlSJA+en/yMleEJKYHRBrWja6AUzazbNsR8n39osRbZugMGTxPOkiYBgkwcUjOnlMBjW4Z6TbdLqCLMisZCziA6dJuWiAeLoKPeYiLF5uCUajwPqgh8mvkor3PWM0yYDeJSrDlka0nyiQ6QYAXlQEn18BKBhBmvyIGlV+zYT7WvSdrsf/8NZRqP9jqKWW4tdolf6CS5r12lq0aZOuopm82A+qbNtuPVKNIx7w5EWgQFQXDzQyUPnFu1kzhnt5y8HohrjciWA8wKUpiM+BALTOSyoKiL/4BOUnNFbLSLSt7HeYSROCXeUrqxgaKhlPjw2kWxChb+Uj9Q9tD7M8wxzlq+QrV1doNgZUI3U7XNOhuPkmTWLDAOY62YyjIV1tN0db5OfoBV7rnazFpxVHImz53FLUsAMHtB7vWjf5tSF3+erzQ59SUoWXMPPbZl38/OT27OcP9h10qbV/JtiGq6rt/dQ/Duuetag8oJvlsrYxDXAkN9CdbzPD7fR494ApR7fKG43kqPE8nScIFJnI9y0V7YfKl6MDBVSCu+/dDnllCer0ixT4AXWSYTDpB+mJrocrDWe7Akx/t2O3THkPf8300aPl7f7foA5P8t7EWv1zQm+mKOyo1MzT4kfQS4nM96BNPrMBXOrHhYmJMbRLop5Y5MuQz3mGAUHrMwR5etOmWL5Is=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd53575-3307-46a7-6e29-08d7e6b95640
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 12:33:19.1205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhCy/Z0yltLzDe+7NKLZg7zFSG8afr70vtyq5YO4iwbvZ/TmQHG9ycOYf/kZRroK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDQuMjAgdW0gMTQ6MjAgc2NocmllYiBUYW8sIFlpbnRpYW46Cj4gSGkgIENocmlzdGlh
bgo+Cj4KPiBQbGVhc2Ugc2VlIGlubGluZSBjb21tZXRucy4KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+Cj4gU2VudDogMjAyMOW5tDTmnIgyMuaXpSAxOTo1Nwo+IFRvOiBUYW8sIFlpbnRpYW4gPFlp
bnRpYW4uVGFvQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVmaW5lIGtp
cSBhY2Nlc3MgcmVnaXN0ZXIKPgo+IEFtIDIyLjA0LjIwIHVtIDEzOjQ5IHNjaHJpZWIgVGFvLCBZ
aW50aWFuOgo+PiBIaSAgQ2hyaXN0aWFuCj4+Cj4+Cj4+IENhbiB5b3UgaGVscCBhbnN3ZXIgdGhl
IHF1ZXN0aW9ucyBiZWxvdz8gVGhhbmtzIGluIGFkdmFuY2UuCj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tCj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+Cj4+IFNlbnQ6IDIwMjDlubQ05pyIMjLml6UgMTk6MDMKPj4gVG86IFRhbywgWWludGlh
biA8WWludGlhbi5UYW9AYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47Cj4+
IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4gQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IHJlZmluZSBraXEgYWNjZXNzIHJlZ2lzdGVyCj4+Cj4+IEFtIDIyLjA0LjIwIHVtIDExOjI5IHNj
aHJpZWIgWWludGlhbiBUYW86Cj4+PiBBY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQga2lxIGFjY2Vz
cyByZWdpc3RlciBtZXRob2QsIHRoZXJlIHdpbGwgYmUKPj4+IHJhY2UgY29uZGl0aW9uIHdoZW4g
dXNpbmcgS0lRIHRvIHJlYWQgcmVnaXN0ZXIgaWYgbXVsdGlwbGUgY2xpZW50cwo+Pj4gd2FudCB0
byByZWFkIGF0IHNhbWUgdGltZSBqdXN0IGxpa2UgdGhlIGV4cGFtcGxlIGJlbG93Ogo+Pj4gMS4g
Y2xpZW50LUEgc3RhcnQgdG8gcmVhZCBSRUctMCB0aHJvZ3VoIEtJUSAyLiBjbGllbnQtQSBwb2xs
IHRoZQo+Pj4gc2Vxbm8tMCAzLiBjbGllbnQtQiBzdGFydCB0byByZWFkIFJFRy0xIHRocm91Z2gg
S0lRIDQuIGNsaWVudC1CIHBvbGwKPj4+IHRoZSBzZXFuby0xIDUuIHRoZSBraXEgY29tcGxldGUg
dGhlc2UgdHdvIHJlYWQgb3BlcmF0aW9uIDYuIGNsaWVudC1BCj4+PiB0byByZWFkIHRoZSByZWdp
c3RlciBhdCB0aGUgd2IgYnVmZmVyIGFuZAo+Pj4gICAgICAgZ2V0IFJFRy0xIHZhbHVlCj4+Pgo+
Pj4gQW5kIGlmIHRoZXJlIGFyZSBtdWx0aXBsZSBjbGllbnRzIHRvIGZyZXF1ZW50bHkgd3JpdGUg
cmVnaXN0ZXJzCj4+PiB0aHJvdWdoIEtJUSB3aGljaCBtYXkgcmFpc2UgdGhlIEtJUSByaW5nIGJ1
ZmZlciBvdmVyd3JpdHRlbiBwcm9ibGVtLgo+Pj4KPj4+IFRoZXJlZm9yZSwgYWxsb2NhdGUgZml4
ZWQgbnVtYmVyIHdiIHNsb3QgZm9yIHJyZWcgdXNlIGFuZCBsaW1pdCB0aGUKPj4+IHN1Ym1pdCBu
dW1iZXIgd2hpY2ggZGVwZW5kcyBvbiB0aGUga2lxIHJpbmdfc2l6ZSBpbiBvcmRlciB0byBwcmV2
ZW50Cj4+PiB0aGUgb3ZlcndyaXR0ZW4gcHJvYmxlbS4KPj4+Cj4+PiB2MjogZGlyZWN0bHkgdXNl
IGFtZGdwdV9kZXZpY2Vfd2JfZ2V0KCkgZm9yIGVhY2ggcmVhZCBpbnN0ZWFkCj4+PiAgICAgICAg
b2YgdG8gcmVzZXJ2ZSBmaXhkZSBudW1iZXIgc2xvdC4KPj4+ICAgICAgICBpZiB0aGVyZSBpcyBu
byBlbm91Z2gga2lxIHJpbmcgYnVmZmVyIG9yIHJyZWcgc2xvdCB0aGVuCj4+PiAgICAgICAgZGly
ZWN0bHkgcHJpbnQgZXJyb3IgbG9nIGFuZCByZXR1cm4gaW5zdGVhZCBvZiBidXN5IHdhaXRpbmcK
Pj4gSSB3b3VsZCBzcGxpdCB0aGF0IGludG8gdGhyZWUgcGF0Y2hlcy4gT25lIGZvciBlYWNoIHBy
b2JsZW0gd2UgaGF2ZSBoZXJlOgo+Pgo+PiAxLiBGaXgga2dkX2hpcV9tcWRfbG9hZCgpIGFuZCBt
YXliZSBvdGhlciBvY2Nhc2lvbnMgdG8gdXNlIHNwaW5fbG9ja19pcnFzYXZlKCkuCj4+IFt5dHRh
b106IERvIHlvdSBtZWFuIHRoYXQgd2UgbmVlZCB0byB1c2Ugc3Bpbl9sb2NrX2lycXNhdmUgZm9y
IHRoZSBmdW5jdGlvbnMganVzdCBsaWtlIGtnZF9oaXFfbXFkX2xvYWQoKT8KPiBZZXMsIEkgc3Ry
b25nbHkgdGhpbmsgc28uCj4KPiBTZWUgd2hlbiB5b3UgaGF2ZSBvbmUgc3BpbiBsb2NrIHlvdSBl
aXRoZXIgbmVlZCBhbHdheXMgbmVlZCB0byBsb2NrIGl0IHdpdGggaXJxcyBkaXNhYmxlZCBvciBu
ZXZlci4KPgo+IEluIG90aGVyIHdvcmRzIHdlIGFsd2F5cyBuZWVkIHRvIGVpdGhlciB1c2Ugc3Bp
bl9sb2NrKCkgb3Igc3Bpbl9sb2NrX2lycXNhdmUoKSwgYnV0IG5ldmVyIG1peCB0aGVtIHdpdGgg
dGhlIHNhbWUgbG9jay4KPgo+IFRoZSBvbmx5IGV4Y2VwdGlvbiB0byB0aGlzIHJ1bGUgaXMgd2hl
biB5b3UgdGFrZSBtdWx0aXBsZSBsb2NrcywgZS5nLgo+IHlvdSBjYW4gZG86Cj4KPiBzcGluX2xv
Y2tfaXJxc2F2ZSgmYSwgZmxhZ3MpOwo+IHNwaW5fbG9jaygmYiwgZmxhZ3MpOwo+IHNwaW5fbG9j
aygmYywgZmxhZ3MpOwo+IC4uLi4KPiBzcGluX3VubG9ja19pcnFzYXZlKCZhLCBmbGFncyk7Cj4K
PiBIZXJlIHlvdSBkb24ndCBuZWVkIHRvIHVzZSBzcGluX2xvY2tfaXJxc2F2ZSBmb3IgYiBhbmQg
Yy4gQnV0IHdlIHJhcmVseSBoYXZlIHRoYXQgY2FzZSBpbiB0aGUgY29kZS4KPiBbeXR0YW9dOiB0
aGFua3MgLCBJIGdvdCBpdC4gSSB3aWxsIHN1Ym1pdCBhbm90aGVyIHBhdGNoIGZvciBpdC4KPgo+
PiAyLiBQcmV2ZW50IHRoZSBvdmVycnVuZyBvZiB0aGUgS0lRLiBQbGVhc2UgZHJvcCB0aGUgYXBw
cm9hY2ggd2l0aCB0aGUKPj4gYXRvbWljIGhlcmUuIEluc3RlYWQganVzdCBhZGQgYSBhbWRncHVf
ZmVuY2Vfd2FpdF9wb2xsaW5nKCkgaW50bwo+PiBhbWRncHVfZmVuY2VfZW1pdF9wb2xsaW5nKCkg
YXMgSSBkaXNjdXNzZWQgd2l0aCBNb25rLgo+PiBbeXR0YW9dOiBTb3JyeSwgSSBjYW4ndCBnZXQg
eW91ciBvcmlnaW5hbCBpZGVhIGZvciB0aGUgYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZygpLiBD
YW4geW91IGdpdmUgbW9yZSBkZXRhaWxzIGFib3V0IGl0PyBUaGFua3MgaW4gYWR2YW5jZS4KPj4K
Pj4gIlRoYXQgaXMgYWN0dWFsbHkgb25seSBhIHByb2JsZW0gYmVjYXVzZSB0aGUgS0lRIHVzZXMg
cG9sbGluZyB3YWl0cy4KPj4KPj4gU2VlIGFtZGdwdV9mZW5jZV9lbWl0KCkgd2FpdHMgZm9yIHRo
ZSBvbGRlc3QgcG9zc2libGUgZmVuY2UgdG8gYmUgc2lnbmFsZWQgYmVmb3JlIGVtaXR0aW5nIGEg
bmV3IG9uZS4KPj4KPj4gSSBzdWdnZXN0IHRoYXQgd2UgZG8gdGhlIHNhbWUgaW4gYW1kZ3B1X2Zl
bmNlX2VtaXRfcG9sbGluZygpLiBBIG9uZSBsaW5lciBsaWtlIHRoZSBmb2xsb3dpbmcgc2hvdWxk
IGJlIGVub3VnaDoKPj4KPj4gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhyaW5nLCBzZXEgLSBy
aW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrLCB0aW1lb3V0KTsiCj4+IFt5dHRhb106IHRo
ZXJlIGlzIG5vIHVzYWdlIG9mIG51bV9mZW5jZXNfbWFzayBhdCBraXEgZmVuY2UgcG9sbGluZywg
dGhlIG51bV9mZW5jZXNfbWFzayBpcyBvbmx5IGVmZmVjdGl2ZSBhdCBkbWFfZmVuY2UgYXJjaGl0
ZWN0dXJlLgo+PiAJCUlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIGRvIHlvdSB3YW50IHRoZSBw
cm90eXBlIGNvZGUgYmVsb3c/IElmIHRoZSBwcm90eXBlIGNvZGUgaXMgd3JvbmcsIGNhbiB5b3Ug
aGVscCBnaXZlIG9uZSBzYW1wbGU/IFRoYW5rcyBpbiBhZHZhbmNlLgo+Pgo+PiBpbnQgYW1kZ3B1
X2ZlbmNlX2VtaXRfcG9sbGluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90ICpz
KSB7Cj4+ICAgICAgICAgICB1aW50MzJfdCBzZXE7Cj4+Cj4+ICAgICAgICAgICBpZiAoIXMpCj4+
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiArCQlhbWRncHVfZmVuY2Vfd2Fp
dF9wb2xsaW5nKHJpbmcsIHNlcSwgdGltZW91dCk7Cj4+ICAgICAgICAgICBzZXEgPSArK3Jpbmct
PmZlbmNlX2Rydi5zeW5jX3NlcTsKPiBZb3VyIHVuZGVyc3RhbmRpbmcgc291bmRzIG1vcmUgb3Ig
bGVzcyBjb3JyZWN0LiBUaGUgY29kZSBzaG91bGQgbG9vayBzb21ldGhpbmcgbGlrZSB0aGlzOgo+
Cj4gc2VxID0gKytyaW5nLT5mZW5jZV9kcnYuc3luY19zZXE7Cj4gYW1kZ3B1X2ZlbmNlX3dhaXRf
cG9sbGluZyhyaW5nLCBzZXEgLQo+IG51bWJlcl9vZl9hbGxvd2VkX3N1Ym1pc3Npb25zX3RvX3Ro
ZV9raXEsIHRpbWVvdXQpOwo+IFt5dHRhb106IHdoZXRoZXIgd2UgbmVlZCBkaXJlY3RseSB3YWl0
IGF0IHRoZSBmaXJzdCBqdXN0IGxpa2UgYmVsb3c/IE90aGVyd2lzZSwgYW1kZ3B1X3JpbmdfZW1p
dF93cmVnIG1heSBvdmVyd3JpdGUgdGhlIEtJUSByaW5nIGJ1ZmZlci4KClRoZXJlIHNob3VsZCBh
bHdheXMgYmUgcm9vbSBmb3IgYXQgbGVhc3Qgb25lIG1vcmUgc3VibWlzc2lvbi4KCkFzIGxvbmcg
YXMgd2UgYWx3YXlzIHN1Ym1pdCBhIGZlbmNlIGNoZWNraW5nIHRoZSBmcmVlIHJvb20gdGhlcmUg
c2hvdWxkIApiZSBmaW5lLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiArCQlhbWRncHVfZmVuY2Vf
d2FpdF9wb2xsaW5nKHJpbmcsIHNlcSAtIG51bWJlcl9vZl9hbGxvd2VkX3N1Ym1pc3Npb25zX3Rv
X3RoZV9raXEsIHRpbWVvdXQpOwo+IAkJc3Bpbl9sb2NrX2lycXNhdmUoJmtpcS0+cmluZ19sb2Nr
LCBmbGFncyk7Cj4gICAgICAgICAgYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgMzIpOwo+ICAgICAg
ICAgIGFtZGdwdV9yaW5nX2VtaXRfd3JlZyhyaW5nLCByZWcsIHYpOwo+ICAgICAgICAgIGFtZGdw
dV9mZW5jZV9lbWl0X3BvbGxpbmcocmluZywgJnNlcSk7IC8qIHdhaXQgKi8KPiAgICAgICAgICBh
bWRncHVfcmluZ19jb21taXQocmluZyk7Cj4gICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgma2lxLT5yaW5nX2xvY2ssIGZsYWdzKTsKPgo+IEkganVzdCB1c2VkIG51bV9mZW5jZXNfbWFz
ayBhcyBudW1iZXJfb2ZfYWxsb3dlZF9zdWJtaXNzaW9uc190b190aGVfa2lxCj4gYmVjYXVzZSBp
dCBpcyBwcm9iYWJseSBhIGdvb2QgdmFsdWUgdG8gc3RhcnQgd2l0aC4KPgo+IEJ1dCB5b3UgY291
bGQgZ2l2ZSB0aGF0IGFzIHBhcmFtZXRlciBhcyB3ZWxsIGlmIHlvdSB0aGluayB0aGF0IG1ha2Vz
IG1vcmUgc2Vuc2UuCj4KPj4gICAgICAgICAgIGFtZGdwdV9yaW5nX2VtaXRfZmVuY2UocmluZywg
cmluZy0+ZmVuY2VfZHJ2LmdwdV9hZGRyLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIMKm
ICAgICAgc2VxLCAwKTsKPj4KPj4gICAgICAgICAgICpzID0gc2VxOwo+Pgo+PiAgICAgICAgICAg
cmV0dXJuIDA7Cj4+IH0KPj4KPj4KPj4KPj4KPj4gMy4gVXNlIGFtZGdwdV9kZXZpY2Vfd2JfZ2V0
KCkgZWFjaCB0aW1lIHdlIG5lZWQgdG8gc3VibWl0IGEgcmVhZC4KPj4gW3l0dGFvXTogeWVzLCBJ
IHdpbGwgZG8gaXQuCj4gVGhhbmtzLAo+IENocmlzdGlhbi4KPgo+PiBSZWdhcmRzLAo+PiBDaHJp
c3RpYW4uCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
