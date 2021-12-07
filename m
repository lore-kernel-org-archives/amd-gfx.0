Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE6AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 01:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCED6F8D9;
	Tue,  7 Dec 2021 01:58:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BCD6F8D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 01:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN/7YMnUCAvVGlc38WIAaFGx3tNxHSZyrU+22B8Vm3WPoTbi7K3lGdGFWAb6bvMEJaXlbLfJHVk9bCkzbaS5yBFbTmWgPFa/jYBGKqZdPUiZaLcL/r0yOH1lsOri58Iv5dziHiZiuTLs9VvtPtCAS0CF8bwR4QrBz+jaxqTgfM7o7sm/9l/j+kz45sagJdhzUdo9hQ+AWcCJh2HrlOzq+/Xdo4glQKT9inOr8yZBrQDQQH/t+gkqSVEWH6eUuQL9rmfI8wD1sdSAMjytX7Z8+LXjg7wr7CC8BegV2QJzHt9zT7kQOLlK3Yuv+9trPLFmTBgyL1yy31DFpwydvTVTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz9WEN8GGh6AV1exZtFL56RcoLhBKgj0WHZZvW1V9WQ=;
 b=JxrI2vyL1iP8b4dMDRtBKG3Q7PcEaN3XIE1mNoz8Xe6IzL0UWdgFYua8Jk236dmSXfJPiTxb3pdQLlM2q87+pQfpapmLSglFWZgBzt4tF59Py7zGnQ+kW8MggXA1vzOGNXITOAOQMGh57kyZFOjVbD+JH2X+LrpY3gMhlbILDZFRNbF2+ZFNdyCmCjJTz3HZ8uzn1ulJ/kbLU0Str09WSasySqhR5BKEqt7GrGbTjoB3jC3Dtr6OGyXXPlv+oGKvsiIrwSJERUpe1DbMtWJ79ed4EZmowaV2ubQy+5XqxQ6uQVdHjP8nXErPYRHkgJ5bUBnfg0FkELq4fj5kSvkSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz9WEN8GGh6AV1exZtFL56RcoLhBKgj0WHZZvW1V9WQ=;
 b=VrwMmGd/Ivo21++nj3a8h2s646EkD0JT9mPyRHivURe7ToL2MHq+KrSWpaO85+pY1vxYZe9VW0WN0ld9kCnxhZ5YRn/xxpVGck4jtea7li4O7cnbF/D3xtbuyiOtS4O0wRQmrikIhsh32mao8hWUHpevcTcYkGOmdvNWy4B0jr8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.19; Tue, 7 Dec 2021 01:58:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 01:58:36 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Thread-Topic: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Thread-Index: AQHX6ow26UqxvGY2l02X+RiFlqjqt6wmRj1g
Date: Tue, 7 Dec 2021 01:58:36 +0000
Message-ID: <DM6PR12MB26194050848510738D3DF81CE46E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211206084551.92502-1-christian.koenig@amd.com>
In-Reply-To: <20211206084551.92502-1-christian.koenig@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-07T01:58:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3e0cada1-35e9-44d1-9ad9-dea70b5ee1bb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27a7bf14-7224-414e-f775-08d9b92514c6
x-ms-traffictypediagnostic: DM6PR12MB4058:EE_
x-microsoft-antispam-prvs: <DM6PR12MB40582631957CF1F4C30F8B14E46E9@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yMdEp59EzaPlPK63bzWF+PNKUSeOW98Sxw0rzYz6IdVjhtHUmf2aYk/Ylgd3WjAFRfCs6YT+RFoewfbze2BUp9+yNcfQKFdkEJvejvqoHgwBy4rG/TqqAi5R1MHGzd2fBmQum3lZ7+Ig48DBNx0QFvJSgUjhBuP89Wa2q4PWw1B/iVk46cSL24idHJGqLvGH3q2CqfFvQb3SSBMApSRbxjgPWI2tFB7bIQmV8b/U9/eV1LGFenYNHjITDO4Ix3H7MqMfs1z35b90H1gM08fHjGF3JfAMxlK6yWGHZCf406su/ClLkacZTtu972CInGXSoMRF4viYjOOU6HFI95IQ9WS8+lFfMMkl6wk/L4ziLGRpWWaiPHSXAMOjZ1BZ4IObvcP+t0Pu7IWZK+wpsUgXt0ee99mi/x+4QJUnGxtwGXtGhb7KDeJdI35/sltocgFrotBJF9Wtm3UtkTQE+OtViTNtZeakMQUoI8Hlpl6Yew9P2mcDN/DOA933qAMFfWJnJIcj1eYqijn366zrkeLGMMzOFQJ8akGS3JaKkbsp3YJQlWS4Z30Y9ItnqyNWOpRTFVVIkgB278q0bhQeb7kEO1QF8+N14rFIYh827olPCrKGtQU6Ce9sc++jc0HSxDc+KSnTE8w+fXinRERHNv97CEeRDab/7+1czhPiWBLOfEVlPfG4kX0dTD1JIArFa9VN19rVhRw5SliI766F+59qQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(4326008)(110136005)(5660300002)(2906002)(316002)(9686003)(8676002)(33656002)(7696005)(8936002)(66556008)(64756008)(66476007)(66946007)(6636002)(71200400001)(52536014)(6506007)(53546011)(66446008)(508600001)(186003)(26005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW9nWVhKTTRyMmlSZUFYcThZYXRIUFExdGw3MFVpMGFFUEpNWkZBTmdTdXdC?=
 =?utf-8?B?b2JjSjdrcGlCMSsxVDgvVEp5bTBoTWovelVEWi9WdHpTS1FqSGlCN3lDRm1j?=
 =?utf-8?B?Z2xEYTA0am9FQkQ3dDZzUzltYVNkOEpEV3doODZxNkZiUVpVUERycXcrRkJs?=
 =?utf-8?B?UE5rakxFUGEwck4vTjI0OWd2dXpsNVBDK0VhZTRLZmg5TG9mUDE0M2pLbnV6?=
 =?utf-8?B?a0RXVHE5VXVxOURzbnA5T1RrZlJ0QzBEWmxkZGh2ak1MRitXUFBSSWMyOFgz?=
 =?utf-8?B?YzV0VjhrcGpPVWovTkwrRENsZlBVeDdPYStmcUIyNWtHWWJFVDZkTEF5ZzhY?=
 =?utf-8?B?VnhXVS9KRVVqMWVBTEpQci9HeUJZNG5STjhBTWFWSjdEU3dwMzMzUTRTWHp2?=
 =?utf-8?B?dGlSMEtQTmNMUzJiV1FUbGhtQlV6OG1NWG0wYnB6UmV1KzZ0QVRKOHFYTmkw?=
 =?utf-8?B?RkpNa1pxUWduTExkZ0xpa1V4NUwvcTNHZDg4L0FnZkxzN1M5eHR3RGE3K29X?=
 =?utf-8?B?SXZYV2h5K0paaVhkclJUSWcyNnVkeFlxT0tRRWZYcXBMWFVkYi9yVzlhMC9G?=
 =?utf-8?B?MEM2Y1BkMmJFN0RINmZheVp3RUN4Y0p3QlRCMEc4WmZYZCtwdTN3VDZmNEVi?=
 =?utf-8?B?dWJublVYbFA3amx3YW51OWFsSU5FY2NYSnoyQjNKYXovZmJsOXBlejQrREwr?=
 =?utf-8?B?c1hra3c0ci9EZzV6QnZpak03d1ZTd0VsQUkycVNlaGVCSTQwUURsZTZtQmhD?=
 =?utf-8?B?SmN1VStZRkJxaE1SZXVkU3NJRnp5emFKODc0eEFzWHFZc1pnMWlRSEIxcjVY?=
 =?utf-8?B?ODlublVSaVZpcUdkZW1CZ25abitWWXlCSVhKVnhlcCtsb09iYUVNNnRFc0Vq?=
 =?utf-8?B?eEdBT1VvRE94M0Y3ajBTeEI2Y3pLQkVTQVZ6cXBXSzJoaENSVktqcDVyUlJL?=
 =?utf-8?B?TUJEMjdVT0dGdERrSHF5OFBUM1pweDUxZThOTGMrUEozeHNEdHE2RG5Wb0NM?=
 =?utf-8?B?SnYvcWRLZnNtZ0ZWTVpZdnYrRnNuWGRPSkFBaUs5ZlNZMWJ0UGo1Q3dxdHhv?=
 =?utf-8?B?RmRYMkNzNDdXY2VueXd3ckNqQmkyczYwclMrdUx4aTNGQysvdTV6MlI2Wndh?=
 =?utf-8?B?TmE1NU0zVjJ1dEpQUFJLam51Rm1CVTlUa0dwYkVZL3JkL094QW4yeDBFYmlT?=
 =?utf-8?B?SmV4OWVRcUVNS2RPc0NmWHVYSDJYcVZlZmQ0MlkzekxKZGZqRjdhMHdYV2NI?=
 =?utf-8?B?SmVWeW8wamJwclZYUng2K0V5enc2RmNIdUozbzlxMlF4d0U0SmtZRm5vTjY5?=
 =?utf-8?B?bUY4bmdhMDhRT0llYmpJYmIxOHBsbFZNSkZ6UXJ3K0JMMzFZN0VESUhmOTNw?=
 =?utf-8?B?dy9wMk1OVHJGdlhqcDdxQXlrcUFNRlRzWGt6OWY1REx6WEtPK3ZzS3dvUXRT?=
 =?utf-8?B?aVl3b1hzSFNCOGo3UXVhRkdPWmp0eVpEK056Sy9PUStKZDI2eHNPKzMzaVZT?=
 =?utf-8?B?RkVkazYvNTdQOVpKU2RHM0NtZENmZ05lSUNaV0FnTkwraklHZHlOaCtXdXJv?=
 =?utf-8?B?cDRvek92RW40QUozQ1JhM3BTZlQ3aXhjdGE2MDgxaVEyT3pFTVNDVDdjU3dT?=
 =?utf-8?B?V05temR0enlVK3NGdnFHc3F0QnNXZFNkeFRnazFlQW40cWJaWW5RVklVWDVN?=
 =?utf-8?B?TnduRzl4YkJiN1RKa2JhcTRtNk1ray9HcE9Cc3A0TTVLclBLbmY4dVNqWE01?=
 =?utf-8?B?alZFcDM4N2Q0d0tLNlJyakE0QklnWGVqNURwdzh2MG0wSnJQempZVDgyTzhw?=
 =?utf-8?B?ZkVHM0VLWXd4V3JCUmdTUHB2enRCZWNuM2RwR2tDNWdyazMrUWNKYWRlTmZG?=
 =?utf-8?B?NDVzQWFEYXJKYm9McGxUS29KLzlsQnNvS0Fxb05aNXNpd0FmcWlDVHZrN002?=
 =?utf-8?B?SEVrdnNjY21rNkNXT2M4Qm5LakkxYmpPYnFMbmVuZVpOTXV2UGJFRTV5SjJM?=
 =?utf-8?B?NEVRUU9ibHE3WUdZUmgyd1FwU3A1bU9ubnFxMlhpclV5NlZYZTlyYW1VbVhl?=
 =?utf-8?B?bUh3K3pCODAzUzJaNWM0ZE1iR2Jlb2kxTVVQRlBpSUJzZUh0TUN2NStCWTdl?=
 =?utf-8?Q?2LpM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a7bf14-7224-414e-f775-08d9b92514c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 01:58:36.1229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJxJt3yI/Dd3t/13UF3gFwMx46ZnMou7qeHSwxLoIXhiK97EHViiJnBwoolpaUBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSXQgc2VlbXMgbW9yZSBqb2JzKGJlbG93KSBvdGhl
ciB0aGFuIGJ1bXBpbmcgdGhlIHJ1bnBtIGNvdW50ZXIgYXJlIHBlcmZvcm1lZC4NCkFyZSB0aGV5
IGRlc2lyZWQgYWxzbz8NCg0KCXIgPSBfX2RtYV9yZXN2X21ha2VfZXhjbHVzaXZlKGJvLT50Ym8u
YmFzZS5yZXN2KTsNCglpZiAocikNCgkJZ290byBvdXQ7DQoNCgliby0+cHJpbWVfc2hhcmVkX2Nv
dW50Kys7DQoNCkJSDQpFdmFuDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFs
ZiBPZg0KPiBDaHJpc3RpYW4gS8O2bmlnDQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgNiwgMjAy
MSA0OjQ2IFBNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWRncHU6IGRvbid0IHNraXAgcnVudGltZSBwbSBnZXQgb24gQStBIGNvbmZp
Zw0KPiANCj4gVGhlIHJ1bnRpbWUgUE0gZ2V0IHdhcyBpbmNvcnJlY3RseSBhZGRlZCBhZnRlciB0
aGUgY2hlY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RtYV9idWYuYyB8IDMgLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZG1hX2J1Zi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYu
Yw0KPiBpbmRleCBhZTZhYjkzYzg2OGIuLjQ4OTZjODc2ZmZlYyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jDQo+IEBAIC02MSw5ICs2MSw2IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2RtYV9idWZfYXR0YWNoKHN0cnVjdCBkbWFfYnVmDQo+ICpkbWFi
dWYsDQo+ICAJaWYgKHBjaV9wMnBkbWFfZGlzdGFuY2VfbWFueShhZGV2LT5wZGV2LCAmYXR0YWNo
LT5kZXYsIDEsIHRydWUpDQo+IDwgMCkNCj4gIAkJYXR0YWNoLT5wZWVyMnBlZXIgPSBmYWxzZTsN
Cj4gDQo+IC0JaWYgKGF0dGFjaC0+ZGV2LT5kcml2ZXIgPT0gYWRldi0+ZGV2LT5kcml2ZXIpDQo+
IC0JCXJldHVybiAwOw0KPiAtDQo+ICAJciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoYWRldl90b19k
cm0oYWRldiktPmRldik7DQo+ICAJaWYgKHIgPCAwKQ0KPiAgCQlnb3RvIG91dDsNCj4gLS0NCj4g
Mi4yNS4xDQo=
