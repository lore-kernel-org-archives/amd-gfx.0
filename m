Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A85C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 01:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D17410E336;
	Fri, 21 Oct 2022 01:51:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A627310E336
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 01:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AppDOaMXcnfpZvuxJaw18RULxSESDAZOCDYGFNYIIB2SFg7RpWnbRN2Z76Epc49+0V+p1EIdafgBpR4aerTFLenMtJQlyBsQVmOZP/lrj7wNIMvR454ArUh/MipnahEKEhxW/d/i7rpqJ4drol8Dmd80FFTeQYeooxvmD0NN2A3nV3LIqpDnUuqPz1l2eu8Y9mpWvWzCU/iyzb+i9GspPoMjO7R9X0X4GyaYMGySrehbBVTw/NwdeIaBIgcFeG51J1ZfarSD2ZYinenNotIS0sDuUGOLgb6y40Fu+1svp5+6491Nj3p6ISevMbXQGEXnrxFFl0Ex6/MdYIV+wn3T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aVzYYN9EeNRp8t80Bh6DO4DtPhhroOu5WRG64jTwD0=;
 b=NVncj19wmFMN533LH5slimT4LFWE0eXYoSpeY1VQo1z+n1p6DID692Ww6Gq6zi3jnJNszbSCatB2cSGvexPG7pNNq01OXNN4WMtRIkV7AHo1KR9HBu/kfIxbKoONhnrxSmkkFS4WJFf5FRrOZD0/ZZWUmuyYhzFHYOvPA5+Fsn210Lm6+PaE7oYQvv3DwRdqiK6BF5T4QvvYAOAviBcoAmyiNW+AsCI5STw1MdbUFN0B5CyR0zzpSJvuIF64ls7+DtwmYgeyMaa9GSiry3TNBqOEUKQVjFFcaq502CoTg9+7lYUQUwreD5OH2NzWQwO/oBs1rB/nR65XBPl+lvnttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aVzYYN9EeNRp8t80Bh6DO4DtPhhroOu5WRG64jTwD0=;
 b=teLmlkLsF7609g+GjeKKxTPAoYBINl2Caii+NMN43y7Ga0WAu6eaBqhfcP+l5MLbmiFm0o1lSeaVM6/jKJ06BF8yAf1zN9nlLUQxpEXfk9jD220n98oFiyFhBsor9ea3FDMPjGCHFTRu9GxHv5S2E6EEz0UqCRjlC8jqXS606IE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Fri, 21 Oct 2022 01:50:54 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098%5]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 01:50:54 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
Thread-Topic: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
Thread-Index: AQHY5GR9Vo6yRCqP5keeMsOeNXWKUa4XcgGAgAChV/A=
Date: Fri, 21 Oct 2022 01:50:54 +0000
Message-ID: <DS7PR12MB600544275C2AB15530224DC5FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
 <e92f2184-73bc-eb3c-d903-5a46c5c34ac0@amd.com>
In-Reply-To: <e92f2184-73bc-eb3c-d903-5a46c5c34ac0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6df79761-8c5c-46c9-a767-3767641fb06c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-21T01:41:33Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS7PR12MB6238:EE_
x-ms-office365-filtering-correlation-id: 7b37f6ee-498a-4102-d086-08dab306b0b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWQE0rhdUTEEJm6IaXvu1M/NAMdQmuvGTFxQoNcI1fp/qTdVHlVE68FAW6C+5dSDEgY044eK0FtEHDxjgHFpmo3oc/9wiQ9vb+g5ZRu4lftFYZ9mvez8q8pHkLRT0XspaLi2Eq3dMNJtqXS647k1lzcEZfIDnsL1XJ9qT/jC9JNmXom2cHekhaCbNNXcETHaY81kGPFWPYpemiZDWQxvL4oB+sVrnXXX9GDjHKWEheeeyqTvg/1cIsc6noH+iXsmAvbCkmDJIY7YvIfkHw63AudivkEMYv4nyIQc3ee7EUt4ei9eGzKCy1zjWIGA/ngphQ9iFQODLNRGeLs8bCmsxlu2GGWgZq/AMQOcJ3OPKf/CNNlhmzsQPGvi2eWIMMYq38iinaFi3nx7MTfK0ScmBF6dN/tt6dpVGsdH1W8TRe8908N15uwZxvE94JgHVWavRmmWP1a8WUWEbL4pb83RPNbepDDnXjchGcBnpQ9gS+hKVpEYbUFb0ZnMN6iRDfmgeCBed49e9xcgIFqLJwXuKC0bWDCcndeXfwByStOqDV0kKXBlJGDEHOjJ6ZaWw8JLfxc8klHKTsHy9WWrsIJgv7VVUGCPqwr4bsMfT/dFH7YN9d/DTcnEUHSUXlUYtlz1vjrzMdihhprdlmRFm76J3LRN97ecm3ysMl6/TgWDnAOXI91X/Io3VoZYQ8MMzTAXCwoLKrk7oin3+qKLXhjqZV0yIdvC3g0tB7U/NH9lil3WbeY2A0DI35yciBP9lTDBxxHZXfmEMFEdJsllo0vg2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(71200400001)(33656002)(38100700002)(186003)(4001150100001)(122000001)(38070700005)(478600001)(66946007)(8676002)(64756008)(53546011)(76116006)(83380400001)(7696005)(54906003)(66446008)(110136005)(66556008)(66476007)(5660300002)(8936002)(9686003)(6506007)(4326008)(52536014)(86362001)(26005)(2906002)(316002)(41300700001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVZ5UDZlTHhFUUpMcVNTV0ovVENwK0hhNFRXNXM2ZDFpd0d5Ym5YQVlodEZP?=
 =?utf-8?B?UkUvRWdYZHpvN0RqM1BZeFZ5d2tXQzFESm1UUFlZMWZFSXpJbVJRWGEzZ1cx?=
 =?utf-8?B?M1l1VGgybmFNbGcrcE9MRzN5cUFISzZ5VjdOcnFsb0lQaWJVd2NzMERTNGo1?=
 =?utf-8?B?Mkp3RzZyVDJZWmpUVitvTWN6TWg0TjhVZDJCdTNWanRtbEd5ekpRcVFLYWJC?=
 =?utf-8?B?UjB5amxmMUR1dkJXRmYrWVU3c1Qxa2hWNk9VSjd4aE1ndFlCQWh4eVNwSTg0?=
 =?utf-8?B?NnIvZWk1SGJJdWJ2MHlJKzNPUlQ3LzR5TzU4b2tQdDQzZ0NJVDYvOXk3SEZz?=
 =?utf-8?B?enBpL1Ixcm10WGJpT3NlZ3g0ckRvKzJPV3BPa08yb2lPbnF4VDRKMzVEbWQx?=
 =?utf-8?B?YUJCUm1SRHZsWlBOZXNLQ1NYTnA0TWJ1K2tpQjNhY09RMHRIbzFMdjk4QjVr?=
 =?utf-8?B?QUphTDFQbTlPRCtmYVdFMVVQdnlEN01TZEJ5aVdKc3J2MjVxVDRWSEduMUsy?=
 =?utf-8?B?U3JjVnIwb2s5SGhwZzNNYzV1dEUycmM1dmVybFZGTDQyZTNHdklDWmpmQnAz?=
 =?utf-8?B?U2I0bWRrMVMway83NzFCQVZEdVM1QTJTYlJUNlNUSVVFdWpDTjNSV0tTVWcr?=
 =?utf-8?B?cHc3ejZFdStvVWV2bWxtTjQyaklMQkxFK1pWUGZmY0VLRUo4dkRLNm9sZlFZ?=
 =?utf-8?B?aTIxTm5SaVkyMmYwYkVPRm4vbVR6TkhYU1Y4eXZ4STRpNzlwdSs3K2EwRHpl?=
 =?utf-8?B?MUx0YzNCdTFHU0VYc0pDVzJZdjZnN1B6MHhzZXJkR0VHNG1CeDM2LzRxR3My?=
 =?utf-8?B?VUl1cVBOUW5UT0VoSzdpbktrcEJIMW1oOC8rTEc3bk5mOWlVZmpFOGlKQUp0?=
 =?utf-8?B?bGtwSjdOR3oyRzB0cHJqdDFGc0ZMMjFCZDJtZWlFbCtGM3ZqM2NOelN4ZGha?=
 =?utf-8?B?dDFnWVFRZkc5UmF2WjluYWE0NERtSUJDWEh2YmVsS1pyeUdsd0t2cXFHWVhk?=
 =?utf-8?B?Zi9kdy93RTdldlFkUXZ3ckc5dkRZSXowUDJOOGZBdG5YSDQ2R3RFM1prcERE?=
 =?utf-8?B?RkpxZHVTZE9JY1NGYXFHM3BIeXJQa0tVSmZsVytaaVQyK3hHMUhwdis4UTha?=
 =?utf-8?B?N01tZGJhb3pZdmcyc0dzOENpRmlCYXlmZ3pDMWsxMjI3QmEvdGptRjhaeGJU?=
 =?utf-8?B?dFpCaEIvRHVKWlF0Smc1OVFMZ25lVkErRVBsTkpFMmpPd3pMY3NyZkl4QTgz?=
 =?utf-8?B?QnlXREY3ZDRIcGZ6elFtRVU4MHB0NzdRdzlTbHJwL3FiL1ZWTXZ0eDRtVlhJ?=
 =?utf-8?B?ejI0YXhoSzdSRkRkb1V0TDlCamluUE9ON2dmT0cvZ0VJcEJjWWhjRGkvS2lY?=
 =?utf-8?B?Q00wWTU3bllqNG45TTg0NlM1d2tLWW8rUDhYOVdwMUM0WStMTTkxR05JMFRG?=
 =?utf-8?B?SUhRdURSa09nWmtKUmQxQmlmVGM5cy9MMlIrYTBDN0l0ZHdsTGNLc2tQY2VX?=
 =?utf-8?B?MkQ0NjNKWXVPaktxVzFKRlM4bnFMSWtWQmtsN3M0TmtpVVptWXdVb2ZqZzVs?=
 =?utf-8?B?VExiZVlEVzVuN0VvSHh3Z0t0Q3k4ZTQzdDBya1FTS25GcXdrMFVBWHNTanlr?=
 =?utf-8?B?eVozaUlMUG51N1JDNVF3bFdmdGhmUTNKYjJsT3R5UkhsbjA3ZWpvY1pQOXM2?=
 =?utf-8?B?cVlYOWdldkFuVWEyWG9ZUWVJbmkxRHhwaS9rRFJQQytpOWxyT3crQ2pHYlNl?=
 =?utf-8?B?T25Da0hWVW1xaHI4YUZTbU9Fbm5iL2dPa1AyZm9aOXMxaWJnVUEvOFBxZ014?=
 =?utf-8?B?a0hBY2ZsWGExc2pnUGFsUllLVXBtZHQ2VnA4Ky9GSS9mdWE0Z28xQ0dmbWRT?=
 =?utf-8?B?TjJmaG9vckxRVXV0STZOR05YNzJ3RnNRMUhCSjJUL1lvUzNzQjhGQktSWFdl?=
 =?utf-8?B?VVNrYjFDSzZ0MTBBKzZBS3ZLbmE1Q1N0K0c4bk5MUU0yTmt4Ti9WY2RmZG8x?=
 =?utf-8?B?ZllKR3h1REtqdzZuNjZ0SjVpRFRFNWxWZXU0Y0dHa2dBSHo3aWxKV3QrWkVJ?=
 =?utf-8?B?L2xacjF1YkNsenpGOUJvc1dabUMydnRtWjlHaFRUcUNmd1pTU2h0OTJ5TGNZ?=
 =?utf-8?Q?sfZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b37f6ee-498a-4102-d086-08dab306b0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 01:50:54.1652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BE+qqAniexjqkdiVClG4ONFiTsDdPt6AurOUyZNigFhbIcZ8mSzW91lgKsgpMk7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBG
ZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwgT2N0b2JlciAyMSwg
MjAyMiAxMjowMyBBTQ0KVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNv
bT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgTGl1LCBBYXJvbiA8QWFyb24uTGl1
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGtmZDogaW50cm9kdWNl
IGR1bW15IGNhY2hlIGluZm8gZm9yIHByb3BlcnR5IGFzaWMNCg0KDQpBbSAyMDIyLTEwLTIwIHVt
IDA1OjE1IHNjaHJpZWIgUHJpa2UgTGlhbmc6DQo+IFRoaXMgZHVtbXkgY2FjaGUgaW5mbyB3aWxs
IGVuYWJsZSBrZmQgYmFzZSBmdW5jdGlvbiBzdXBwb3J0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQ
cmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKyst
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gaW5kZXggY2Q1Zjhi
MjE5YmY5Li45NjAwNDZlNDNiN2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9jcmF0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2NyYXQuYw0KPiBAQCAtNzk1LDYgKzc5NSw1NCBAQCBzdGF0aWMgc3RydWN0IGtmZF9ncHVfY2Fj
aGVfaW5mbyB5ZWxsb3dfY2FycF9jYWNoZV9pbmZvW10gPSB7DQo+ICAgICAgIH0sDQo+ICAgfTsN
Cj4NCj4gK3N0YXRpYyBzdHJ1Y3Qga2ZkX2dwdV9jYWNoZV9pbmZvIGR1bW15X2NhY2hlX2luZm9b
XSA9IHsNCj4gKyAgICAgew0KPiArICAgICAgICAgICAgIC8qIFRDUCBMMSBDYWNoZSBwZXIgQ1Ug
Ki8NCj4gKyAgICAgICAgICAgICAuY2FjaGVfc2l6ZSA9IDE2LA0KPiArICAgICAgICAgICAgIC5j
YWNoZV9sZXZlbCA9IDEsDQo+ICsgICAgICAgICAgICAgLmZsYWdzID0gKENSQVRfQ0FDSEVfRkxB
R1NfRU5BQkxFRCB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENSQVRfQ0FDSEVf
RkxBR1NfREFUQV9DQUNIRSB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENSQVRf
Q0FDSEVfRkxBR1NfU0lNRF9DQUNIRSksDQo+ICsgICAgICAgICAgICAgLm51bV9jdV9zaGFyZWQg
PSAxLA0KPiArICAgICB9LA0KPiArICAgICB7DQo+ICsgICAgICAgICAgICAgLyogU2NhbGFyIEwx
IEluc3RydWN0aW9uIENhY2hlIHBlciBTUUMgKi8NCj4gKyAgICAgICAgICAgICAuY2FjaGVfc2l6
ZSA9IDMyLA0KPiArICAgICAgICAgICAgIC5jYWNoZV9sZXZlbCA9IDEsDQo+ICsgICAgICAgICAg
ICAgLmZsYWdzID0gKENSQVRfQ0FDSEVfRkxBR1NfRU5BQkxFRCB8DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIENSQVRfQ0FDSEVfRkxBR1NfSU5TVF9DQUNIRSB8DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIENSQVRfQ0FDSEVfRkxBR1NfU0lNRF9DQUNIRSksDQo+ICsg
ICAgICAgICAgICAgLm51bV9jdV9zaGFyZWQgPSAyLA0KPiArICAgICB9LA0KPiArICAgICB7DQo+
ICsgICAgICAgICAgICAgLyogU2NhbGFyIEwxIERhdGEgQ2FjaGUgcGVyIFNRQyAqLw0KPiArICAg
ICAgICAgICAgIC5jYWNoZV9zaXplID0gMTYsDQo+ICsgICAgICAgICAgICAgLmNhY2hlX2xldmVs
ID0gMSwNCj4gKyAgICAgICAgICAgICAuZmxhZ3MgPSAoQ1JBVF9DQUNIRV9GTEFHU19FTkFCTEVE
IHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1JBVF9DQUNIRV9GTEFHU19EQVRB
X0NBQ0hFIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1JBVF9DQUNIRV9GTEFH
U19TSU1EX0NBQ0hFKSwNCj4gKyAgICAgICAgICAgICAubnVtX2N1X3NoYXJlZCA9IDIsDQo+ICsg
ICAgIH0sDQo+ICsgICAgIHsNCj4gKyAgICAgICAgICAgICAvKiBHTDEgRGF0YSBDYWNoZSBwZXIg
U0EgKi8NCj4gKyAgICAgICAgICAgICAuY2FjaGVfc2l6ZSA9IDEyOCwNCj4gKyAgICAgICAgICAg
ICAuY2FjaGVfbGV2ZWwgPSAxLA0KPiArICAgICAgICAgICAgIC5mbGFncyA9IChDUkFUX0NBQ0hF
X0ZMQUdTX0VOQUJMRUQgfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUkFUX0NB
Q0hFX0ZMQUdTX0RBVEFfQ0FDSEUgfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBD
UkFUX0NBQ0hFX0ZMQUdTX1NJTURfQ0FDSEUpLA0KPiArICAgICAgICAgICAgIC5udW1fY3Vfc2hh
cmVkID0gNiwNCj4gKyAgICAgfSwNCj4gKyAgICAgew0KPiArICAgICAgICAgICAgIC8qIEwyIERh
dGEgQ2FjaGUgcGVyIEdQVSAoVG90YWwgVGV4IENhY2hlKSAqLw0KPiArICAgICAgICAgICAgIC5j
YWNoZV9zaXplID0gMjA0OCwNCj4gKyAgICAgICAgICAgICAuY2FjaGVfbGV2ZWwgPSAyLA0KPiAr
ICAgICAgICAgICAgIC5mbGFncyA9IChDUkFUX0NBQ0hFX0ZMQUdTX0VOQUJMRUQgfA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBDUkFUX0NBQ0hFX0ZMQUdTX0RBVEFfQ0FDSEUgfA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUkFUX0NBQ0hFX0ZMQUdTX1NJTURfQ0FD
SEUpLA0KPiArICAgICAgICAgICAgIC5udW1fY3Vfc2hhcmVkID0gNiwNCj4gKyAgICAgfSwNCj4g
K307DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBrZmRfcG9wdWxhdGVkX2N1X2luZm9fY3B1KHN0cnVj
dCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYsDQo+ICAgICAgICAgICAgICAgc3RydWN0IGNyYXRf
c3VidHlwZV9jb21wdXRldW5pdCAqY3UpDQo+ICAgew0KPiBAQCAtMTUxNCw4ICsxNTYyLDYgQEAg
c3RhdGljIGludCBrZmRfZmlsbF9ncHVfY2FjaGVfaW5mbyhzdHJ1Y3Qga2ZkX2RldiAqa2RldiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgIG51bV9vZl9jYWNoZV90eXBlcyA9IEFSUkFZX1NJWkUo
YmVpZ2VfZ29ieV9jYWNoZV9pbmZvKTsNCj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiAgICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMywgMyk6DQo+IC0gICAgICAgICAg
ICAgY2FzZSBJUF9WRVJTSU9OKDEwLCAzLCA2KTogLyogVE9ETzogRG91YmxlIGNoZWNrIHRoZXNl
IG9uIHByb2R1Y3Rpb24gc2lsaWNvbiAqLw0KPiAtICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lP
TigxMCwgMywgNyk6IC8qIFRPRE86IERvdWJsZSBjaGVjayB0aGVzZSBvbiBwcm9kdWN0aW9uIHNp
bGljb24gKi8NCj4gICAgICAgICAgICAgICAgICAgICAgIHBjYWNoZV9pbmZvID0geWVsbG93X2Nh
cnBfY2FjaGVfaW5mbzsNCj4gICAgICAgICAgICAgICAgICAgICAgIG51bV9vZl9jYWNoZV90eXBl
cyA9IEFSUkFZX1NJWkUoeWVsbG93X2NhcnBfY2FjaGVfaW5mbyk7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gQEAgLTE1MjgsNyArMTU3NCwxMCBAQCBzdGF0aWMgaW50IGtmZF9m
aWxsX2dwdV9jYWNoZV9pbmZvKHN0cnVjdCBrZmRfZGV2ICprZGV2LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrZmRfZmlsbF9ncHVfY2FjaGVfaW5mb19mcm9tX2dmeF9jb25maWco
a2RldiwgcGNhY2hlX2luZm8pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAg
ICAgICAgICAgICAgZGVmYXVsdDoNCj4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiArICAgICAgICAgICAgICAgICAgICAgcGNhY2hlX2luZm8gPSBkdW1teV9jYWNoZV9p
bmZvOw0KPiArICAgICAgICAgICAgICAgICAgICAgbnVtX29mX2NhY2hlX3R5cGVzID0gQVJSQVlf
U0laRShkdW1teV9jYWNoZV9pbmZvKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4o
ImR1bW15IGNhY2hlIGluZm8gaXMgdXNlZCB0ZW1wb3JhcmlseSBhbmQgcmVhbCBjYWNoZSBpbmZv
IG5lZWQgdXBkYXRlIGxhdGVyLlxuIik7DQo+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cg0KQ291bGQgd2UgbWFrZSB0aGlzIHJldHVybiBhbiBlcnJvciBpZiB0aGUgYW1kZ3B1LmV4cF9o
d19zdXBwb3J0IG1vZHVsZSBwYXJhbWV0ZXIgaXMgbm90IHNldD8NCg0KUmVnYXJkcywNCiAgIEZl
bGl4DQoNCltQcmlrZV0gSXQncyBmaW5lIHRvIHByb3RlY3QgdGhpcyBkdW1teSBpbmZvIGJ5IGNo
ZWNraW5nIHRoZSBwYXJhbWV0ZXIgYW1kZ3B1X2V4cF9od19zdXBwb3J0LCBidXQgaXQgbWF5IG5v
dCBmcmllbmRseSB0byBlbmQgdXNlciBieSBhZGRpbmcgdGhlIHBhcmFtZXRlciBhbmQgc29tZSBn
dXlzIHdpbGwgc3RpbGwgcmVwb3J0IEtGRCBub3QgZW5hYmxlZCBmb3IgdGhpcyBwYXJhbWV0ZXIg
c2V0dGluZyBwcm9ibGVtLiBUaGUgb3JpZ2luYWwgaWRlYSBpcyB0aGUgZW5kIHVzZXIgd2lsbCBu
b3QgYXdhcmUgdGhlIGR1bW15IGNhY2hlIGluZm8gYW5kIG9ubHkgYWxlcnQgdGhlIHdhcm5pbmcg
bWVzc2FnZSB0byBkZXZlbG9wZXIuDQoNCj4gICAgICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4N
Cg==
