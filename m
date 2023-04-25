Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932CDC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 01:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2039C10E1CF;
	Tue, 25 Apr 2023 01:13:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F8510E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 01:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxjhb6kbAkOi1jX1qYY0aQR8tlnHDXzZCJb6i5vl3yDuJDjc6XRk6FcZxsudvwP4OwLGZV3Xatu3e5jWRjyyds4Y6unecXwjw6OXmG5ru8TYIF0pIJ23fQatVaLmsOWLj+5LCQWpdrLAJmfRVg82VyX+oVEHhiawZBd34NJOEzJ0bwLei6K3urJwX2eaKvpiIEQSpqi4JFsHk1+NS+4KEei13H528zoP7lGB4JvlWFh1OO0Wwy5a6leHb9m1GhJkBHHzTJFgTXKxeB2B75FPreOEG6wln6vBFwbjKdTKQ7N4e6HACZXz0qCHX3cHvVaN8wTobdKYn2Cowfr67Hvulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ/qoP1jU5zEGae2kdRRUS/6IsRz8//s2Mk/liToJcA=;
 b=WBMTwK9iChMlfrY25pvGZKSIANTyQELEJsW6eyqySlRboSsYzsv/C7MIuVMaKoh9i1J5oklFfqHwF/vn2+gFRsdmlh7xjlsEx94xTJ8ukNRcBWZqIPaw02pgfFtbgy+ntfPd7a92JYZgqHiZIhzMYcEWZ+YUq6yu/G/n6syvKu1HtoeJH0ZbXx12cvqyiaR5wr78G7nyFxwavxzK2upBYnRYGfO6oRpFjixcm0CikDH4LgbpdT6CZed1iUYrxhSkct+dL9cphX1PEWPWwT2qJMqANfk6fuV3Ds8eMb4Jw32cHdOHXkBtvcMZONwkj4G62kE72jb22NqiTHqospasOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ/qoP1jU5zEGae2kdRRUS/6IsRz8//s2Mk/liToJcA=;
 b=TlvSv6Vb5c2wwpYlV7ZKwJii7izXJMgFajHYEEBTLvzDzCycHq3Bb0eNlW/1d0R3LSftytv1h3djh7Ws/01KGuNLv8Yp8x5ccOo5Oygpvcp1S2qwSiNupksTPVm0kV+rZXAjIF/bu2QA8P56GELzB7a0h7+0yppfdib/8Cqo6HQ=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 01:13:33 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::f262:d6ec:3b24:2390]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::f262:d6ec:3b24:2390%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 01:13:33 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Topic: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Index: AQHZccK2MAMJ/oR9T0GoKmG29Z3qLa86NNYAgAAXPwCAADxEAIAAVTuAgAATL4CAAD7TIA==
Date: Tue, 25 Apr 2023 01:13:32 +0000
Message-ID: <BL1PR12MB52378B1F4549126C771815E7F0649@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230418065443.878721-1-shane.xiao@amd.com>
 <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
 <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <DM4PR12MB52615C85D3EA998E157686AD9D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <ac04f565-8336-fff6-e93b-a3021613558e@amd.com>
 <CADnq5_MFCad6wRFV=tQ6w+QFDsjbQB614dE=-6Hx+9qf++aSUw@mail.gmail.com>
In-Reply-To: <CADnq5_MFCad6wRFV=tQ6w+QFDsjbQB614dE=-6Hx+9qf++aSUw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=62087c47-4f62-4d39-bf69-580cd699039e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-25T00:04:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|BN9PR12MB5242:EE_
x-ms-office365-filtering-correlation-id: 6608cfe2-ea08-4c3e-00b3-08db452a4985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GM5G70xuX3D7KYRXkywIV2WcppsN0r78GPa7yOWqYW1CiEzhexS4UMpSJIW4mUJvM42hiyG5iJV7voCLD/OsWyGt86VUkEeRZD/9fQ/eEDkzsxcBh6fbYPfJjcZ9+eiK5/wahI4u2NkwWrnX0nSv4w9PAlnIT3fX+iPzY9fQbPYlxVTwQ47c5+qdOveC65C8kXNKMI8nVfGTjLRWWq0iOzB7bITHwhGCse2jgzB/bylOGELfmgUy1GpoGin0k05BaELuAQdPJz8jPvriA4Nvn56qZVZjDuROn1xjqKqtvIXVOA56FyDHQ3nxGY1wcDet7OlmhUlPrmjOCfdrJp4ibMtH3ugtVdpLKMr83AQDqnpnjWc0oEHT7EwhVQem2Ir4SGrWoMLFlp6pHua8KAlTs0niMldbL7r/TY8h4X6OKRGR1zdu/P+w2q0u+F5VLzYkJQYo1i6hHEXJIqAelkaLNWY/422I+1G53BerMIREPiXU2eMvpGT59RnqwVjI+rfF+NWSkXxtijzGvR3zMs777cfn/q0yzMKwQmLAgVDtYlAPd93uJI8b+ygFMsfN2K7SmavnRkwIMtx5QCtogU/+gk8ElDkRBEx9cXXj5eCFnV4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(71200400001)(7696005)(55016003)(6506007)(9686003)(186003)(53546011)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(8676002)(8936002)(41300700001)(4326008)(316002)(26005)(478600001)(6636002)(52536014)(5660300002)(54906003)(110136005)(38070700005)(122000001)(38100700002)(86362001)(33656002)(83380400001)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzdFWHE3Z2pBRGhTTFRxSW51RGlOdWprazc5R0VJdlFJZ1Y2dXE0a0lWeFo2?=
 =?utf-8?B?MEtvb3BPUEFwb0pYY0ZPUTRzU20vUGMzbWxOeElTcFBNT25MTWcvOEUzU2FT?=
 =?utf-8?B?TXJVTmVJd1AxU1VLdWg0VWJ5OUU5aGswMmNCcVY2Z2k4UDF5M3NvSnFCVmdk?=
 =?utf-8?B?b2tyQkJPZ1R2NzlzRlk2V2JmRzFSQVJ2cHJRRzkvcXBDbVhka3o0dmFwc2tP?=
 =?utf-8?B?MFB3RnZMUEF4QXJIZFVLd0lWQm5MRXFGalNMUU5wNEVERlg2SXA5dVNIR3Z0?=
 =?utf-8?B?TTJ1TGdKU0dJOUpZeXcvTkpzbE51aXQ3cGdvdUdtUW1RYVVCTzZYWHJhZGhu?=
 =?utf-8?B?Ly9ZZ3lpazdLSnE5a0dldVd6czIraklHSXp1OG52WkN6ZVZNRVhXcmhsSTM2?=
 =?utf-8?B?K3lWb3pHcGRycVNoZEtNT283SC9NNkpGRXlCY3JWQWFMd05BbXBlaExiREFo?=
 =?utf-8?B?YUZFbWR3MGhRT2g1RnZUY21vcGlGeTE5bFhZU3lQUVVUUDBnVW44aXJkOEtI?=
 =?utf-8?B?U05UMGhpc0swd0JFZ0ppTnV6TEVKeDlab1FNZGNtRFpEWmxsRDF0WWJ1aVF2?=
 =?utf-8?B?cUYxb2VlQ2hNS25vZTJvOHpOYkpLanZXaXAvUFhLQ1pMeVU0ZFRvTFVzRWRk?=
 =?utf-8?B?amxYemNXMXhOWGFSREE4Q0hXVlhIeW16YVphYU0xQWVJMXZXYkIva01PUEZx?=
 =?utf-8?B?NXg4VStPOFhpeitQTXl6ZjBJeVEraEpPd1VrNitzdnJjcFZHejNkWGlIYTlh?=
 =?utf-8?B?T3crTExiVE9hZElhK2d1Z3FDM0hmSVZ2SkJ2Z1FOV3lJTWJqQ1hoK0UvL2Fq?=
 =?utf-8?B?amtha0hOZVpoODZYVjVCdlNuSUZnMWlsYlUwbFpwR1p0NHNsS1hkYWMyR0tG?=
 =?utf-8?B?cS9HcGh2RnNaY2IzWmVidnRLMEVSQVNrOVdkOG52enJWNktaYlorTGJCNDBl?=
 =?utf-8?B?bGZ1U09xV2pjZkRVUk9Td2tHcU1Cd3Z4UnNSU1hOSy9DL1dubmIrSEJOUi9m?=
 =?utf-8?B?RVYyS0E1K0Q1WTNYMG1SczgvTHQvYnpqOFBHRFBHd2FHbU9icFNXMnpnbFBB?=
 =?utf-8?B?bTJlKzNUVFhrY2ZHZENuVFlFMHM3aEV1Szlmbmo4Y1V6dDNBa1Y3cGx4L0Zq?=
 =?utf-8?B?aVh2Wm5zYS9acmxtak9XdG9VZ0gvcm56ajFnZGNlajdNdnd5blcwYTNkWnNz?=
 =?utf-8?B?K3RNQjRFQ0VpcXIyKzBQUXJaVVYrZEY3V3c3dkFuVCtFd1A3SDVzMmNGeERs?=
 =?utf-8?B?WVY2bG5rVXQrVkNvc3k1c1QycWc1VnNGUlVKUEZ3V0RLUUZzNjRZSkZ2YWgx?=
 =?utf-8?B?N3FlQkNtb0ZqNEdwbWMrRWkvcFFhTXJaK01tYjlLZXNzTDVGNUJLTy9sQis2?=
 =?utf-8?B?NmNGZkVZUjZBMDJyZVQ5bUthUWVWdWIrSk04enRKSnI4V1NoeGJ6QXNLTE5Z?=
 =?utf-8?B?Rm5IYUNzZ2NSYzYySURDem9GVHNSSTdCVER1R0VWY3AwOFdDRHFMVm1XVitV?=
 =?utf-8?B?aWNWOGoyNGg3clNSc3AxazlMbXdzRGFWZ0Y3SmdjVzhrSmNrWmRicS9rRjQv?=
 =?utf-8?B?aEJ2U01QL1JMZDZINDc4b3pWWGNvWkxRRGlzaUtZdWJNc24rV3p1Ky84TVAz?=
 =?utf-8?B?WW12UjY4dkI0SE1oVXVtZmR2anpxRWQwQUFKTkFNazJ2QVpQa1dRQTExa09n?=
 =?utf-8?B?cCtSaXp1c2Zyb0IyaC82dVdScHZMTFM3RDQwekFXcVFmaHhYSFd3MXdQMWVn?=
 =?utf-8?B?c1NnQXEyOEN2bmFYaUFxNmd4VXByYkJIOHNQTjNEY2lEY0tpMjhJYVRPRkpY?=
 =?utf-8?B?WG9NUXhYblNTbGUzN2RORjU0SWpPUU5mRFkxN3hSd0p5RWFpRldDUjhHT0sx?=
 =?utf-8?B?Q1pNeDRSUXFnSExrSjYwYTd2bkJ5TFoxUVpJVlEydE96cnduUHcwUXo3WUY2?=
 =?utf-8?B?MFNrcHpCTjZCUGZydWl0M3hLbXJUODY0WmdEYlQ4NHdyeTBlcitpcUFoVTFW?=
 =?utf-8?B?Q0xKaXN3eVFsTlU3aDhnYnU4cWx5T01nbmF4Zm1yU2pQMm9QL3VzMGF0RGUv?=
 =?utf-8?B?UkRLamJHN25GZkQyZmFPbnR1Y1ErejE5WDNQcms2MVBqUWRYTnQwWjRWWnVV?=
 =?utf-8?Q?SYTs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6608cfe2-ea08-4c3e-00b3-08db452a4985
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 01:13:32.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kylBSkgHBHV9sT7udH6nCMYpscIyexezcKYlOOqrCWtMLj8jtdAZkHdEFNyAmpZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
Cc: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Xiao, Shane" <shane.xiao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDI1LCAyMDIzIDQ6MjAgQU0NCj4gVG86IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IENjOiBYaWFvLCBTaGFuZSA8c2hh
bmUueGlhb0BhbWQuY29tPjsgQ2hyaXN0aWFuIEvDtm5pZw0KPiA8Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcN
Cj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT47IEhvdSwNCj4gWGlhb21lbmcgKE1hdHRoZXcpIDxYaWFvbWVuZy5Ib3VAYW1k
LmNvbT47IExpdSwgQWFyb24NCj4gPEFhcm9uLkxpdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBFbmFibGUgZG9vcmJlbGwgc2VsZnJpbmcgaWYgcmVzaXplIEJB
Ug0KPiBzdWNjZXNzZnVsbHkNCj4NCj4gT24gTW9uLCBBcHIgMjQsIDIwMjMgYXQgMzoxMeKAr1BN
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gd3JvdGU6DQo+
ID4NCj4gPiBBbSAyNC4wNC4yMyB1bSAxNjowNiBzY2hyaWViIFhpYW8sIFNoYW5lOg0KPiA+ID4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBYaWFvLCBTaGFuZQ0KPiA+ID4+IFNlbnQ6IE1vbmRh
eSwgQXByaWwgMjQsIDIwMjMgNjozMSBQTQ0KPiA+ID4+IFRvOiBDaHJpc3RpYW4gS8O2bmlnIDxj
a29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT47IGFtZC0NCj4gPiA+PiBnZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPiA+PiA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nDQo+ID4gPj4gPEhhd2tpbmcuWmhhbmdAYW1k
LmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gPiA+PiBD
YzogSG91LCBYaWFvbWVuZyAoTWF0dGhldykgPFhpYW9tZW5nLkhvdUBhbWQuY29tPjsgTGl1LCBB
YXJvbg0KPiA+ID4+IDxBYXJvbi5MaXVAYW1kLmNvbT4NCj4gPiA+PiBTdWJqZWN0OiBSRTogW1BB
VENIXSBkcm0vYW1kZ3B1OiBFbmFibGUgZG9vcmJlbGwgc2VsZnJpbmcgaWYgcmVzaXplDQo+ID4g
Pj4gQkFSIHN1Y2Nlc3NmdWxseQ0KPiA+ID4+DQo+ID4gPj4gW0FNRCBPZmZpY2lhbCBVc2UgT25s
eSAtIEdlbmVyYWxdDQo+ID4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4+
IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
Pg0KPiA+ID4+PiBTZW50OiBNb25kYXksIEFwcmlsIDI0LCAyMDIzIDU6MDcgUE0NCj4gPiA+Pj4g
VG86IFhpYW8sIFNoYW5lIDxzaGFuZS54aWFvQGFtZC5jb20+Ow0KPiA+ID4+PiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPj4+IDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPiA+Pj4gPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4g
PiA+Pj4gQ2M6IEhvdSwgWGlhb21lbmcgKE1hdHRoZXcpIDxYaWFvbWVuZy5Ib3VAYW1kLmNvbT47
IExpdSwgQWFyb24NCj4gPiA+Pj4gPEFhcm9uLkxpdUBhbWQuY29tPg0KPiA+ID4+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBFbmFibGUgZG9vcmJlbGwgc2VsZnJpbmcgaWYNCj4g
PiA+Pj4gcmVzaXplIEJBUiBzdWNjZXNzZnVsbHkNCj4gPiA+Pj4NCj4gPiA+Pj4gQW0gMTguMDQu
MjMgdW0gMDg6NTQgc2NocmllYiBTaGFuZSBYaWFvOg0KPiA+ID4+Pj4gW1doeV0NCj4gPiA+Pj4+
IFRoZSBzZWxmcmluZyBkb29yYmVsbCBhcGVydHVyZSB3aWxsIGNoYW5nZSB3aGVuIHdlIHJlc2l6
ZSBGQiBCQVINCj4gPiA+Pj4+IHN1Y2Nlc3NmdWxseSBkdXJpbmcgZ21jIHN3IGluaXQsIHdlIHNo
b3VsZCByZW9yZGVyIHRoZSBzZXF1ZW5jZQ0KPiA+ID4+Pj4gb2YgZW5hYmxpbmcgZG9vcmJlbGwg
c2VsZnJpbmcgYXBlcnR1cmUuDQo+ID4gPj4+IFRoYXQncyBhIGdvb2QgY2F0Y2guDQo+ID4gPj4+
DQo+ID4gPj4+PiBbSG93XQ0KPiA+ID4+Pj4gTW92ZSBlbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdf
YXBlcnR1cmUgZnJvbSAqX2NvbW1vbl9od19pbml0IHRvDQo+ID4gPj4+PiAqX2NvbW1vbl9sYXRl
X2luaXQuDQo+ID4gPj4+IEJ1dCB0aGF0IHNvdW5kcyBsaWtlIGEgYmFkIGlkZWEuIEluc3RlYWQg
dGhlIGZ1bGwgY2FsbCB0bw0KPiA+ID4+PiBudl9lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoKSBz
aG91bGQgYmUgbW92ZWQgYXJvdW5kLg0KPiA+ID4+IEhpIENocmlzdGlhbiwNCj4gPiA+Pg0KPiA+
ID4+IFllcywgIEkgZ2V0IHlvdXIgaWRlYS4gQnV0IGFzIGZhciBhcyBJIGNhbiB1bmRlcnN0YW5k
IHRoYXQsIHRoZSBnZngNCj4gPiA+PiBodyBpbml0IHdpbGwgdXNlIGRvb3JiZWxsLg0KPiA+ID4+
IElmIHNvLCB3ZSBjYW5ub3QgZW5hYmxlIGRvb3JiZWxsIGFmdGVyIGdmeCBodyBpbml0Lg0KPiA+
ID4gV2UgaGF2ZSBjb21lIHVwIHdpdGggdHdvIHdheXMgdG8gcmVzb2x2ZSB0aGUgaXNzdWUuDQo+
ID4gPg0KPiA+ID4gMSkgU2VwYXJhdGUgZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlIGFuZA0KPiA+
ID4gZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlLiBIb3dldmVyLCAgdGhlDQo+IGVu
YWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZSBzaG91bGQgYmUgbW92ZWQgaW4gKl9jb21t
b25faXBfZnVuY3MtDQo+ID5sYXRlX2luaXQuDQo+ID4NCj4gPiBJJ20gbm90IGFuIGV4cGVydCBm
b3IgdGhpcyBwYXJ0IG9mIHRoZSBkcml2ZXIsIGJ1dCBvZiBoYW5kIHRoYXQgc291bmRzDQo+ID4g
bGlrZSB0aGUgcmlnaHQgd2F5IG9mIGRvaW5nIGl0Lg0KPiA+DQo+ID4gQWxleCBhbnkgb2JqZWN0
aW9ucz8NCj4NCj4gWWVhaCwgc2VlbXMgcmVhc29uYWJsZS4NCj4NCj4gQWxleA0KPg0KZW5hYmxl
X2Rvb3JiZWxsX2FwZXJ0dXJlIGFuZCBlbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdfYXBlcnR1cmUg
c2hvdWxkIGJlIGluIGNvbW1vbl8qX2luaXQgaW5zdGVhZCBvZiBnbWNfaHdfaW5pdC4NClRoZSBv
cmRlciBvZiBleGVjdXRpb24gb2YgU2hhbmUncyAxc3Qgd2F5IGlzIDoNCjEpIGNvbW1vbl9zd19p
bml0DQoyKSBjb21tb25faHdfaW5pdCAgLT4gZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlDQozKSBn
bWNfc3dfaW5pdCAtPiBhbWRncHVfZGV2aWNlX3Jlc2l6ZV9mYl9iYXIgICAgICAgICAgICAgICAg
ICAvLy9UaGlzIHJlbGllcyBnbWMucmVhbF92cmFtX3NpemUgdG8gZGV0ZXJtaW5lIHJlc2l6ZV9m
Yl9iYXIsIHNvIG1vdmluZyBhbWRncHVfZGV2aWNlX3Jlc2l6ZV9mYl9iYXIgdG8gY29tbW9uX3N3
X2luaXQgIGlzIG5vdCBhIGdvb2QgaWRlYS4NCjQpIGdtY19od19pbml0DQo1KSBjb21tb25fbGF0
ZV9pbml0IC0+IGVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZQ0KDQpUaGUgMXN0IHdh
eSBsb29rcyBnb29kIHRvIG1lIGFuZCByZXZpZXdlZC1ieSBtZS4NCg0KPiA+DQo+ID4gUmVnYXJk
cywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPiA+IDIpIFRoZSBmdWxsIGNhbGwgY2FuIGJlIG1v
dmVkIHRvIGdtYyBodyBpbml0LiAgQnV0IGl0IHNlZW1zIHN0cmFuZ2UgdG8gbW92ZQ0KPiBuYmlv
IGNvbmZpZ3VyYXRpb24gaW50byBnbWMgaHcgaW5pdC4NCj4gPiA+DQo+ID4gPiBJZiBuZWl0aGVy
IG9mIHRoZSBhYm92ZSBtZXRob2RzIGlzIHN1aXRhYmxlLCBjb3VsZCB5b3UgcGxlYXNlIGdpdmUg
dXMgc29tZQ0KPiBhZHZpY2Ugb24gdGhpcyBpc3N1ZT8NCj4gPiA+DQo+ID4gPiBCZXN0IFJlZ2Fy
ZHMsDQo+ID4gPiBTaGFuZQ0KPiA+ID4NCj4gPiA+PiBCZXN0IFJlZ2FyZHMsDQo+ID4gPj4gU2hh
bmUNCj4gPiA+Pg0KPiA+ID4+PiBSZWdhcmRzLA0KPiA+ID4+PiBDaHJpc3RpYW4uDQo+ID4gPj4+
DQo+ID4gPj4+PiBUaGlzIGZpeGVzIHRoZSBwb3RlbnRpYWwgaXNzdWUgdGhhdCBHUFUgcmluZyBp
dHMgb3duIGRvb3JiZWxsDQo+ID4gPj4+PiB3aGVuIHRoaXMgZGV2aWNlIGlzIGluIHRyYW5zbGF0
ZWQgbW9kZSB3aXRoIGlvbW11IGlzIG9uLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFNoYW5lIFhpYW8gPHNoYW5lLnhpYW9AYW1kLmNvbT4NCj4gPiA+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+DQo+ID4gPj4+PiBUZXN0ZWQtYnk6IFhp
YW9tZW5nIEhvdSA8WGlhb21lbmcuSG91QGFtZC5jb20+DQo+ID4gPj4+PiAtLS0NCj4gPiA+Pj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgICAgfCA0ICsrKy0NCj4gPiA+Pj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCA0ICsrKy0NCj4gPiA+Pj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMgfCA0ICsrKy0NCj4gPiA+Pj4+
ICAgIDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
ID4+Pj4NCj4gPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
di5jDQo+ID4gPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgaW5kZXgNCj4g
PiA+Pj4+IDQ3NDIwYjQwMzg3MS4uZjRjODU2MzRhNGM4DQo+ID4gPj4+PiAxMDA2NDQNCj4gPiA+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCj4gPiA+Pj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCj4gPiA+Pj4+IEBAIC01MzUsNyArNTM1
LDggQEAgc3RhdGljIHZvaWQNCj4gPiA+Pj4+IG52X2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShz
dHJ1Y3QNCj4gPiA+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiA+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGVuYWJsZSkNCj4gPiA+Pj4+ICAg
IHsNCj4gPiA+Pj4+ICAgICAgICAgICAgYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxs
X2FwZXJ0dXJlKGFkZXYsDQo+ID4gPj4+PiBlbmFibGUpOw0KPiA+ID4+Pj4gLSAgYWRldi0+bmJp
by5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFkZXYsDQo+ID4gPj4+
PiBlbmFibGUpOw0KPiA+ID4+Pj4gKyAgaWYgKCFlbmFibGUpDQo+ID4gPj4+PiArDQo+ID4gPj4+
PiArIGFkZXYtPm5iaW8uZnVuY3MtPmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShh
ZGV2LA0KPiA+ID4+PiBmYWxzZSk7DQo+ID4gPj4+PiAgICB9DQo+ID4gPj4+Pg0KPiA+ID4+Pj4g
ICAgY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIG52X2NvbW1vbl9pcF9ibG9j
ayA9IEBADQo+ID4gPj4+PiAtOTk5LDYNCj4gPiA+Pj4+ICsxMDAwLDcgQEAgc3RhdGljIGludCBu
dl9jb21tb25fbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gPiA+Pj4+ICAgICAgICAgICAgICAg
ICAgICB9DQo+ID4gPj4+PiAgICAgICAgICAgIH0NCj4gPiA+Pj4+DQo+ID4gPj4+PiArICBhZGV2
LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdfYXBlcnR1cmUoYWRldiwNCj4g
PiA+Pj4+ICsgdHJ1ZSk7DQo+ID4gPj4+PiAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4+Pj4g
ICAgfQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jDQo+ID4gPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMNCj4gPiA+Pj4+IGluZGV4IGJjNWRkODBmMTBjMS4uMDIwMmRlNzlhMzg5IDEwMDY0NA0K
PiA+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+ID4+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+ID4+Pj4gQEAg
LTYyMyw3ICs2MjMsOCBAQCBzdGF0aWMgdm9pZA0KPiA+ID4+Pj4gc29jMTVfZW5hYmxlX2Rvb3Ji
ZWxsX2FwZXJ0dXJlKHN0cnVjdA0KPiA+ID4+PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ID4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZW5h
YmxlKQ0KPiA+ID4+Pj4gICAgew0KPiA+ID4+Pj4gICAgICAgICAgICBhZGV2LT5uYmlvLmZ1bmNz
LT5lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoYWRldiwNCj4gPiA+Pj4+IGVuYWJsZSk7DQo+ID4g
Pj4+PiAtICBhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdfYXBlcnR1
cmUoYWRldiwNCj4gPiA+Pj4+IGVuYWJsZSk7DQo+ID4gPj4+PiArICBpZiAoIWVuYWJsZSkNCj4g
PiA+Pj4+ICsNCj4gPiA+Pj4+ICsgYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3Nl
bGZyaW5nX2FwZXJ0dXJlKGFkZXYsDQo+ID4gPj4+IGZhbHNlKTsNCj4gPiA+Pj4+ICAgIH0NCj4g
PiA+Pj4+DQo+ID4gPj4+PiAgICBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24g
dmVnYTEwX2NvbW1vbl9pcF9ibG9jayA9DQo+ID4gPj4+PiBAQA0KPiA+ID4+Pj4gLTExMjUsNiAr
MTEyNiw3IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUp
DQo+ID4gPj4+PiAgICAgICAgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+ID4gPj4+
PiAgICAgICAgICAgICAgICAgICAgeGdwdV9haV9tYWlsYm94X2dldF9pcnEoYWRldik7DQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gKyAgYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZy
aW5nX2FwZXJ0dXJlKGFkZXYsDQo+ID4gPj4+PiArIHRydWUpOw0KPiA+ID4+Pj4gICAgICAgICAg
ICByZXR1cm4gMDsNCj4gPiA+Pj4+ICAgIH0NCj4gPiA+Pj4+DQo+ID4gPj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0KPiA+ID4+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4gPj4+PiBpbmRleCA1MTRiZmM3MDVkNWEu
LmNkNDYxOTA4NWQ2NyAxMDA2NDQNCj4gPiA+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzIxLmMNCj4gPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzIxLmMNCj4gPiA+Pj4+IEBAIC00NTQsNyArNDU0LDggQEAgc3RhdGljIHZvaWQNCj4gPiA+
Pj4+IHNvYzIxX2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShzdHJ1Y3QNCj4gPiA+Pj4gYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIGVuYWJsZSkNCj4gPiA+Pj4+ICAgIHsNCj4gPiA+Pj4+ICAgICAgICAg
ICAgYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsDQo+ID4g
Pj4+PiBlbmFibGUpOw0KPiA+ID4+Pj4gLSAgYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3Ji
ZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFkZXYsDQo+ID4gPj4+PiBlbmFibGUpOw0KPiA+ID4+Pj4g
KyAgaWYgKCFlbmFibGUpDQo+ID4gPj4+PiArDQo+ID4gPj4+PiArIGFkZXYtPm5iaW8uZnVuY3Mt
PmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShhZGV2LA0KPiA+ID4+PiBmYWxzZSk7
DQo+ID4gPj4+PiAgICB9DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gICAgY29uc3Qgc3RydWN0IGFtZGdw
dV9pcF9ibG9ja192ZXJzaW9uIHNvYzIxX2NvbW1vbl9pcF9ibG9jayA9DQo+ID4gPj4+PiBAQA0K
PiA+ID4+Pj4gLTc2NCw2ICs3NjUsNyBAQCBzdGF0aWMgaW50IHNvYzIxX2NvbW1vbl9sYXRlX2lu
aXQodm9pZCAqaGFuZGxlKQ0KPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1k
Z3B1X2lycV9nZXQoYWRldiwgJmFkZXYtDQo+ID4gPj4+PiBuYmlvLnJhc19lcnJfZXZlbnRfYXRo
dWJfaXJxLCAwKTsNCj4gPiA+Pj4+ICAgICAgICAgICAgfQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+ICsg
IGFkZXYtPm5iaW8uZnVuY3MtPmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShhZGV2
LA0KPiA+ID4+Pj4gKyB0cnVlKTsNCj4gPiA+Pj4+ICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
Pj4+PiAgICB9DQo+ID4gPj4+Pg0KPiA+DQo=
