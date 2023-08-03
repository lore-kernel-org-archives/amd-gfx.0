Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4052BEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 15:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A904410E614;
	Thu,  3 Aug 2023 15:27:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332FC10E614
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 15:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8gY/6GUGX+0dttDdWpUfL9B7Lltfd0wxX7cAgYxKoshzBajdSgCHcT+CH1aEqeJqDemCVmpXiwoeG47WWX+bolz7xaKr1+rpvYaWDQpOMf8s5KzFj1AmHoFs7VprJpgXqMbajO9nCfGW5lVR1HY6vtR/hz6l2IB6rUU8PhyJYHAiwMTTEddrHQE4eCWg5x4RYnjFU+/SGSi9e278q/AVzOXQ+Xjlu12lL6Rho4Fa7EvG5dhrYTqX9lF7jDNo3YXzIB3Ni8vQuJnt0j5uN/nRGTGuqi6e/wJuAYKHTuQUqfbacV7rNlGkAbU3IFtRgZLikgHJSx3nEcepVbNPSII3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okBbdsc8ipz8d+A/BFXVBmfARqiWtSZ7isf6kVnui4Q=;
 b=WAk2CqZ/tMyqZgANxjM4F6kid8+8UbWTH5TtsVPaygR6UI4LXxKj8GNCrBjl6/56ruO1WVt0KhCXI9q35P+a/JL8kbza2bNKQa3uOa8Ewrbu5W4qeqqJWRSovFLUyFIiziziGPAZ6K0YrIxfDB59GvgJ6zELLK6cVB0CSBT9SUxiwvKeRsxeXRwnNzfiXd+h3sx1gyDnNiYXJkW0UPYaQ+roL5mNab+cVfiZV9oUn+vwwocjr9EFK5bwZ7pXk61aC+xBlw8ng07xVfIuaGEaYZHzhkslGDqHw8G8+8HKL/ckflNjuqKYzwjbnOOttbxEM+tTpv/CAtTQ6eqbD/YXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okBbdsc8ipz8d+A/BFXVBmfARqiWtSZ7isf6kVnui4Q=;
 b=1sLu+CVG9ywM1oWK4zHPdpa5AKB05J6QfatYDHcLRnH3eQ/WCjNLYKrc0gdqWuqnvTGDY8YCLymuOJFi2XrdPl08OlwI5TS4ysG94dYmOjos2cxLlGj0FIKRjn4JpSfcGbQ0EbQ9w7f/2GVwqhBbPioEOUu1ZyD1SY+xbTrpLnQ=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:27:39 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:27:38 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Thread-Topic: [PATCH v3] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Thread-Index: AQHZxEggN6LaBOW9JkSeeg+pkk6voq/YtUkr
Date: Thu, 3 Aug 2023 15:27:38 +0000
Message-ID: <DM6PR12MB4250A5E1A001AC54DCC0F471FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20230801071601.2124220-1-Lang.Yu@amd.com>
In-Reply-To: <20230801071601.2124220-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-03T15:27:37.9756850Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4250:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: 0330105c-2d28-4094-7b04-08db94362be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1BhpAo3mAR0BVJc2B7neorZlz3a6F0Ru/HF7+cq5hZ9NKHe2HpUTLVZkcQpzyd22ZMgXglDQqI4vyD31m5sKobhxBRKM7EzjX9yv0h6oj2tWHjZbrDq3VnPhxM9utnfPtDattj27IsoTHwgo9Bwphfa6QGtCJ9RxqbX2gzylP7ZAwm63DMyiEWtQbb4qEI79QB6ak7Ie633UashXeNVX409LpkqXU/urzj1pHKVVtLRqcPMjdhYGIsuH4AGABBW0/7szwlUd3AF7HHktWbpRJfG+FfTJli1nBmaPBxFGP/pvjYVutFIlOZkmVXJwtOEi97f1uqI7MvTfAuUMFNYlGpY98lQgMbeDaJ1ZdIxIXg9LY67Nl3mP/M8V71TfvPEA9w4gV82Dq9HW9Aj3Nb+esOFx7kf+JIM3vF18rHXnd4xaYyRcytHOnYWf9mFp/j/eYiXgIBMgsuVZoSq+nNRIosZ6VXofJPRmA9bo7YWdccmbkWkalEmWGKYoUlU/H1ywXi2D6p1FM9S+dQ3N6ezKaM6lgkzXDY42ZbMmBbFfnXsvRMef7UiGLvU/FHZE/lA0dIQv1N+4npU4x0mSckak9Cp4kAAPPPuNNbrn584AgClhq7or6SGtKPP63l2vPFKD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(6506007)(26005)(86362001)(38100700002)(122000001)(38070700005)(316002)(71200400001)(478600001)(9686003)(7696005)(66446008)(54906003)(55016003)(6916009)(33656002)(4326008)(64756008)(66946007)(66556008)(66476007)(76116006)(2906002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d0NrSzlQMGdsUVdlUzRaSlNRQzN4KzZnenJRUXNvWGFISUhnYTRKMGl5RWdo?=
 =?gb2312?B?RDBiVHVvZWlpZVY3U0haQi9CTTZrWXN0dGZzTEZJcDNGTkk5c3U4N0l3VEJW?=
 =?gb2312?B?MU05ZjhvNmdWZVNMTWM2eXU0bmNtRVlMUVNsTkpxSjNWNnBmVUI2RVVVNDRv?=
 =?gb2312?B?b1RUaGtXMHFPT0dCMFJUR0QraUpxMWtXcmRtS2Q4TlUrdkVPQUFtRWY4OUtm?=
 =?gb2312?B?ME5zcGxyVHEvclFGNzEzVEJ1OTNURmRtM1BRQisralc4TG8xbDVIVXRCVVla?=
 =?gb2312?B?Mmx3dkdrcHNaSXR5RmxOdzR2OFNXMGZsQi81c1BxUzBmVnh6OFNjcGo2czRl?=
 =?gb2312?B?L1lvQWVJWllQZzMwdWdBdXhwb3dxVDFmNlI4VmZFR2xmWi9zcWNBb3c3bWp3?=
 =?gb2312?B?azIreHU0WnRrVTl4L0M1Y3FWbmQ4SkUxWS9KZkIxK3lyK2xxUXFCSlcwZTZa?=
 =?gb2312?B?MU1aSnZ6R0xMMFoxREdIVzg4WU12RU82MHc0dU1oQjdLTFByVEFMckdXQ2Nk?=
 =?gb2312?B?K2t4SU9CeFpSWVdVdUY2MDR3WFQyMjlxbUZ0emErWEdmcUF3aEVzRHBOVlJ5?=
 =?gb2312?B?TlJaUTljVTVTS2E5eUZHZGkwSG5jdW9BUS9YU1J3V2R0TUNTWSt6VU9wclRE?=
 =?gb2312?B?RnR5ODRySC9rS25IRmZTSEZaTG5uNWIzUDU2T3NaYjZ5NTNuZ3M3T2VzUzN4?=
 =?gb2312?B?ekt5UGhjNHNJOVFEZkFZRHQ4d2tuM0xWbmlxckplVU5aMjNReU1RbzNpS1RB?=
 =?gb2312?B?QjF5R25FTlZDZ1puV25LRnJBLzlMVG9Jc2gyNEhxenJFSENvZ0pOSlNHQUVL?=
 =?gb2312?B?WXorQkhaejdqMlhCTW1MS0FwZDhjUVhySGM3bGxIUDZWb3N4VWpKajNqU0Z5?=
 =?gb2312?B?enNOWkNqRjNZNkVvUk9IeitUeDZERTBlVFZKcXh1d2txaWZPdXJ6dXJUTGZs?=
 =?gb2312?B?Y0xBNC93SjRFeWNxNmZERkNGcU9KczNuNmFGOFdJWUJVWXdpeURidnprWmhi?=
 =?gb2312?B?UzlXdHJ0eWU0eVErUFhuN2xQdWoxbGkrS3pNK1JMZTg0MVVqOW5oQkx5TU9T?=
 =?gb2312?B?VUFjRjRJYUNtSDBwVHY1cnBUbUtOakcrQU02eDhKTWF3cHJxcHNTZGlJSzRG?=
 =?gb2312?B?RjBaaHJzbDllaVhkandoS1hJYUl2U2dsMm5yeG9PSmhaN1NuVW1aYzhraXdP?=
 =?gb2312?B?RzZVSTgwL1p4aGovaDNxdjVrSVBaMXFONWhSSkFMK1RXelJBZ0dIVVYwUlZa?=
 =?gb2312?B?bVNJMEY0UnFkZVd4bmhPWHFSWW1GcDN6ckJmZzA5RGRmUHFWcDRFSHBZTUNx?=
 =?gb2312?B?ZWMvMk9XNkp0L2kySDk5VXZFTHJxdEFWY1djdTh4Qmt1RGxqMTJWMzVLLzE0?=
 =?gb2312?B?amR5MzhiMHd2TnAyNHJGR2JpcE5MbWJ3bG0zR1lSL3pkTlVvOXVRdkhFWjV2?=
 =?gb2312?B?RjBaVlRtRTJmano0WXVidlY4UGdHYWZFbUp1c1FpSVZ5dGNTZWxqZ1VOS2RZ?=
 =?gb2312?B?LzlQYVNsSHhrMGpmcnp5WjUyekIzYjdNb1Z0NHJ5MWRKelV4b2dNMythSjdX?=
 =?gb2312?B?THEyZGRjTzR4UEd0RENhY2hwSERmOFFuQUI5TzI5MDVxeUtIdGVQdDRUcHVL?=
 =?gb2312?B?dXRPTFNObE0wSHB4Q09sQ1F1dVRmNjF4TGxnVFlqRWhmQTZtTTNTdHcxdnEx?=
 =?gb2312?B?SnZoTVAyUnNNL0taclV4dVdnWWRFeTlXNytML3NsS2RYN3FjZjFYQ29keDNq?=
 =?gb2312?B?VkEzTmNCZVRlQ29iZWF6Z3ZVQXZidE9NejhWdGNDcXV5Y1FIRDRRckxaTTVp?=
 =?gb2312?B?ZFpnelVNOUN0ekd4dzRPNlZHaXhPS1lzZkN3Y1Brd1FKb210T2Y1UFdjbVJY?=
 =?gb2312?B?VnQ3VnozS3Rja3JHbEY3WUgwU21wMkxybS8zSDltVXpPWG5RRXhqS0VDMndt?=
 =?gb2312?B?Q0o3Um84TmI2WDQ1NUhlVlFLOFJqemI3VURDTGxNaVJNY3NwOU0xS3dNcW05?=
 =?gb2312?B?QW44My9pbGI0S2czOVpFUWdvSkNYRWtYOHpCdHpjUE9oZTNXV2g5VUNVdnR1?=
 =?gb2312?B?SkNCQzQ5SlZDeG1OMjN5SXpzK1hjUkhLUFRGMG84N3RqaVIxNVJrWDRmTCsy?=
 =?gb2312?Q?NMtuThCYUq39WgfUc579/gIS6?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4250A5E1A001AC54DCC0F471FB08ADM6PR12MB4250namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0330105c-2d28-4094-7b04-08db94362be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 15:27:38.8222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNqTPBPUuNgkUoGee81daPaeCaY4g9h3N7NgrlcmnkkSqD8loqfN59AX9Tdl28FJeV78Wu4Nl5l05UApRLwdog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Paneer Selvam, 
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB4250A5E1A001AC54DCC0F471FB08ADM6PR12MB4250namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KUGluZw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8
/sjLOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPg0Kt6LLzcqxvOQ6INDHxtq2/iwgsMvUwiAx
LCAyMDIzIDE1OjE2DQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCrOty806IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVucHJh
dmluLlBhbmVlclNlbHZhbUBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1k
LmNvbT47IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQrW98ziOiBbUEFUQ0ggdjNdIGRybS9h
bWRncHU6IHJlZmluZSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbF9hdCgpDQoNClVzZSBhbWRncHVf
Ym9fY3JlYXRlX3Jlc2VydmVkKCkgdG8gY3JlYXRlIGEgQk8gaW4gVlJBTQ0KZG9tYWluIHdvdWxk
IGZhaWwgaWYgcmVxdWVzdGVkIFZSQU0gc2l6ZSBpcyBsYXJnZSg+MTI4TUIpDQpvbiBBUFUgd2hp
Y2ggdXN1YWxseSBoYXMgYSBkZWZhdWx0IDUxMk1CIFZSQU0uDQoNClRoYXQncyBiZWNhdXNlIFZS
QU0gaXMgZnJhbWdlbnRlZCBhZnRlciBzZXZlcmFsIGFsbG9jYXRpb25zLg0KDQpUaGUgYXBwcm9h
Y2ggaXMgdXNpbmcgYW1kZ3B1X2JvX2NyZWF0ZV9yZXNlcnZlZCgpIHRvDQpjcmVhdGUgYSBCTyBp
biBDUFUgZG9tYWluIGZpcnN0LCBpdCB3aWxsIGFsd2F5cyBzdWNjZWVkLg0KDQp2MjogRG9uJ3Qg
b3ZlcndyaXRlIHRoZSBjb250ZW50cyBhdCBzcGVjaWZpYyBvZmZzZXQuDQp2MzogRG9uJ3QgcmV0
dXJuIEdQVSBhZGRyLg0KDQpTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxMYW5nLll1QGFtZC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAxOSAr
KysrKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMNCmluZGV4IGZmNzNjYzExZDQ3ZS4uZGY1YmE5NTA5YTQxIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCkBAIC0zNzcsMjcgKzM3NywzNiBAQCBpbnQg
YW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWxfYXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQog
ICAgICAgICBzaXplID0gQUxJR04oc2l6ZSwgUEFHRV9TSVpFKTsNCg0KICAgICAgICAgciA9IGFt
ZGdwdV9ib19jcmVhdGVfcmVzZXJ2ZWQoYWRldiwgc2l6ZSwgUEFHRV9TSVpFLA0KLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfR0VNX0RPTUFJTl9WUkFNLCBib19w
dHIsIE5VTEwsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV9hZGRy
KTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01B
SU5fQ1BVLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib19wdHIsIE5V
TEwsIE5VTEwpOw0KICAgICAgICAgaWYgKHIpDQogICAgICAgICAgICAgICAgIHJldHVybiByOw0K
DQogICAgICAgICBpZiAoKCpib19wdHIpID09IE5VTEwpDQogICAgICAgICAgICAgICAgIHJldHVy
biAwOw0KDQorICAgICAgICgqYm9fcHRyKS0+cHJlZmVycmVkX2RvbWFpbnMgPSBBTURHUFVfR0VN
X0RPTUFJTl9WUkFNOw0KKyAgICAgICAoKmJvX3B0ciktPmFsbG93ZWRfZG9tYWlucyA9ICgqYm9f
cHRyKS0+cHJlZmVycmVkX2RvbWFpbnM7DQorICAgICAgICgqYm9fcHRyKS0+ZmxhZ3MgPSBBTURH
UFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVM7DQorICAgICAgICgqYm9fcHRyKS0+ZmxhZ3Mg
fD0gY3B1X2FkZHIgPyBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEDQorICAg
ICAgICAgICAgICAgOiBBTURHUFVfR0VNX0NSRUFURV9OT19DUFVfQUNDRVNTOw0KKw0KICAgICAg
ICAgLyoNCiAgICAgICAgICAqIFJlbW92ZSB0aGUgb3JpZ2luYWwgbWVtIG5vZGUgYW5kIGNyZWF0
ZSBhIG5ldyBvbmUgYXQgdGhlIHJlcXVlc3QNCiAgICAgICAgICAqIHBvc2l0aW9uLg0KICAgICAg
ICAgICovDQotICAgICAgIGlmIChjcHVfYWRkcikNCi0gICAgICAgICAgICAgICBhbWRncHVfYm9f
a3VubWFwKCpib19wdHIpOw0KLQ0KICAgICAgICAgdHRtX3Jlc291cmNlX2ZyZWUoJigqYm9fcHRy
KS0+dGJvLCAmKCpib19wdHIpLT50Ym8ucmVzb3VyY2UpOw0KDQogICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgKCpib19wdHIpLT5wbGFjZW1lbnQubnVtX3BsYWNlbWVudDsgKytpKSB7DQogICAgICAg
ICAgICAgICAgICgqYm9fcHRyKS0+cGxhY2VtZW50c1tpXS5mcGZuID0gb2Zmc2V0ID4+IFBBR0Vf
U0hJRlQ7DQogICAgICAgICAgICAgICAgICgqYm9fcHRyKS0+cGxhY2VtZW50c1tpXS5scGZuID0g
KG9mZnNldCArIHNpemUpID4+IFBBR0VfU0hJRlQ7DQorICAgICAgICAgICAgICAgKCpib19wdHIp
LT5wbGFjZW1lbnRzW2ldLm1lbV90eXBlID0gVFRNX1BMX1ZSQU07DQorICAgICAgICAgICAgICAg
KCpib19wdHIpLT5wbGFjZW1lbnRzW2ldLmZsYWdzID0gVFRNX1BMX0ZMQUdfQ09OVElHVU9VUzsN
CisNCisgICAgICAgICAgICAgICBpZiAoISgoKmJvX3B0ciktPmZsYWdzICYgQU1ER1BVX0dFTV9D
UkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRCkpDQorICAgICAgICAgICAgICAgICAgICAgICAoKmJv
X3B0ciktPnBsYWNlbWVudHNbaV0uZmxhZ3MgfD0gVFRNX1BMX0ZMQUdfVE9QRE9XTjsNCiAgICAg
ICAgIH0NCisNCiAgICAgICAgIHIgPSB0dG1fYm9fbWVtX3NwYWNlKCYoKmJvX3B0ciktPnRibywg
JigqYm9fcHRyKS0+cGxhY2VtZW50LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJigq
Ym9fcHRyKS0+dGJvLnJlc291cmNlLCAmY3R4KTsNCiAgICAgICAgIGlmIChyKQ0KLS0NCjIuMjUu
MQ0KDQo=

--_000_DM6PR12MB4250A5E1A001AC54DCC0F471FB08ADM6PR12MB4250namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Ping</div>
<div dir=3D"ltr"><br>
<span id=3D"ms-outlook-ios-cursor"></span></div>
</div>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>=B7=A2=BC=FE=C8=CB:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> =D0=C7=C6=DA=B6=FE, =B0=CB=D4=C2 1, 2023 1=
5:16<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Pa=
neer Selvam, Arunpravin &lt;Arunpravin.PaneerSelvam@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH v3] drm/amdgpu: refine amdgpu_bo_create_kernel_=
at()
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use amdgpu_bo_create_reserved() to create a BO in =
VRAM<br>
domain would fail if requested VRAM size is large(&gt;128MB)<br>
on APU which usually has a default 512MB VRAM.<br>
<br>
That's because VRAM is framgented after several allocations.<br>
<br>
The approach is using amdgpu_bo_create_reserved() to<br>
create a BO in CPU domain first, it will always succeed.<br>
<br>
v2: Don't overwrite the contents at specific offset.<br>
v3: Don't return GPU addr.<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 ++++++++++++++-----<b=
r>
&nbsp;1 file changed, 14 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index ff73cc11d47e..df5ba9509a41 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -377,27 +377,36 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D ALIGN(size, PAGE_=
SIZE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_res=
erved(adev, size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM, bo_ptr, NULL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_add=
r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_CPU,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_ptr,=
 NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr) =3D=3D NULL)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;preferred_domains =3D A=
MDGPU_GEM_DOMAIN_VRAM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;allowed_domains =3D (*b=
o_ptr)-&gt;preferred_domains;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;flags =3D AMDGPU_GEM_CR=
EATE_VRAM_CONTIGUOUS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;flags |=3D cpu_addr ? A=
MDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Remove the origina=
l mem node and create a new one at the request<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * position.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_kunmap(*bo_ptr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_resource_free(&amp;(*b=
o_ptr)-&gt;tbo, &amp;(*bo_ptr)-&gt;tbo.resource);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; (*bo_=
ptr)-&gt;placement.num_placement; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].fpfn =3D offset &gt;&gt; =
PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].lpfn =3D (offset + size) =
&gt;&gt; PAGE_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (*bo_ptr)-&gt;placements[i].mem_type =3D TTM_PL_VRAM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (*bo_ptr)-&gt;placements[i].flags =3D TTM_PL_FLAG_CONTIGUOUS;<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!((*bo_ptr)-&gt;flags &amp; AMDGPU_GEM_CREATE_CPU_ACCESS_REQ=
UIRED))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;pl=
acements[i].flags |=3D TTM_PL_FLAG_TOPDOWN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_mem_space(&am=
p;(*bo_ptr)-&gt;tbo, &amp;(*bo_ptr)-&gt;placement,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;(*bo_ptr)-&gt;tbo.resource, &amp;ctx);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4250A5E1A001AC54DCC0F471FB08ADM6PR12MB4250namp_--
