Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A317C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 02:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3014110E209;
	Thu, 20 Oct 2022 02:44:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB60710E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 02:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL3HYCQsmlBt5mkGbQ7a0fwLyf/2xl4CNm7fArwTeaRLg48z8bpDOmCZ+hf4+A7dVl4/RZmoKI2awWU+v2U4JGMUs8O2iRGqFcUzbD6yVqy+9+x1sMijOTf3Pw44i56qvorH7DRj0zznwFk3YylQBrsP08rwXcxRFmBjVPc9LjGrpSlOjXZMj2nOSMGj7Aok85ZAx/1ZKyuLZn1CLTqmZvcZInUXx2Cr9CdT83ZgnulwGqDbvl8Uzh6JeWO7PV0CBR/SLjCRf+9gKm6RTUztFj5LYjwTMFMK4DCie6mRVM/hTKL5RJMpxCwKWwO37wEHjsJnIpExP2sEZ+UETQI8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgK7oD791PlgCaEFrBlnsxelT33ar/1dA2vjREIjifg=;
 b=Ib8k+Ic+SsWg/YkkA1bABU80sEzQuBbJDPSJIFyTrczdp3I9gjn1fDgRw6mfAPCtY9ZxOtxZDZGp9qmaAzwLXt5CErLBh+OHDnJxHGrhb8WXDv1QtQ3MUQnY+6qE9RHYKbiyDV64ocy6EH4nuKzgELsGAK9THBhqH49OadEq7QWR1e6gp5hykZExkaLBbKQ5Irwwi/f2AvOIgLmT01/Yc9Kn/9cQf5vuSAUb5eZ+H5yrvPCGZd53qX3M6QOrL1Hq3E8ThfZ47LuBl+74vUd3ZYVWLPYyH5uhjD62A8xQzfcvrrR47A0KwokvaDc8CJM76A4NXIuqDjZamrqy1ynblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgK7oD791PlgCaEFrBlnsxelT33ar/1dA2vjREIjifg=;
 b=5FQ17H1PMFxt2jn3Jt6inxAiWPzSQ0bBD+NdZNyJH8z/ovWi2Z7TGPCHAkat/DgI+baX6UVyWOoJuVK/3FaYhn45T/6gNU4fDNkQlcQh92LGfZriY94IgbPSJjqMl44MxuMFUicoiB7AdgXId54cWY42Zh7Yv8rZYqcMo/iTFN4=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 02:44:46 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::180b:27cd:cf18:beea%7]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 02:44:46 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Thread-Topic: [PATCH] drm/amdgpu: skip mes self test for gc 11.0.3 in recover
Thread-Index: AQHY421FXC8+id4OoUiwRisi6tOO3q4VFb2AgAF9s+A=
Date: Thu, 20 Oct 2022 02:44:46 +0000
Message-ID: <DM6PR12MB30351752EF3AEFBF898B868AE52A9@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20221019034519.1558366-1-YuBiao.Wang@amd.com>
 <555e8453-d609-a78e-36a8-dd52b63332ac@amd.com>
In-Reply-To: <555e8453-d609-a78e-36a8-dd52b63332ac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Hawking.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|DS7PR12MB5862:EE_
x-ms-office365-filtering-correlation-id: 3c4587e7-7d1d-4425-10f9-08dab2450cfa
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buDVsQigAlEhCAftCftah/z/Va4vIvhzvUDQzTDEH500U2fCAQLVEja7QcCZDkQTOc3j6XFy1smrFadauW3FhDxMgEYP0w2cJqVxYP6m1YuiDn8dQLAM96u5lSrsoEgc5za5Te3gV+KZaxIe2bodk+11UwxFn0WPRH52nwgtkGqloNLBiFP2Xv81IVRnNKInY6iXJQWlcoTfGSi5h8ZUMbTvS2I8TznOGU7CyvcoWvyPczpJKtXb1N6bgJbIkP3eX3vfDzDK+z7BQxpvy7MKOvG1AUrJzz6n1fzIeiHRw7NSlMJPrHVaXY+snD1gKVsOUK47JdbWcvAgZZzEyHXE39gOydUqtT2ehOUmXAQxmocxon7tTulbybNMtVYc4KAZslY1Y6vx+gMX1Pi6aIc7p06N+HqmYgpfPUGEC77oMqmLhf3JhbK4pZDIcZvqRc9nS0JHFlit+RYtOpkg6SrOpdbxLNHwtQXWZYIht7ZtmQ/OE5NCHTv0QgEeoCndYlsOK1srt6ic4QiCRdLmXP/XIfvhxakYSWoOjFhle+XfPs/C6jAr4/tpNnOd62vN1ZlwmnNjvFnGvAEgi7lx8g1usvZkMIRUVYjMt32M7Kpr87lf9BjCVJlLYlL5Vsp5LclM/BKx+q+qsBwpfW2mJ1evMtfMzg1mhPXZEFUMw9zgL6fbfBzehH9CkpBWn2Tn3KLdYVLsNLAERHFq1Siaiix2JWLqrUUYWCB8iY9KNHNju2IDITPtZBl1JH+Yp2FmVNaiwYRZ4HZWChNJu9ierbH31w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(186003)(4001150100001)(2906002)(71200400001)(33656002)(122000001)(478600001)(38070700005)(38100700002)(86362001)(6636002)(54906003)(66946007)(66446008)(66476007)(66556008)(64756008)(8676002)(4326008)(110136005)(76116006)(52536014)(55016003)(8936002)(53546011)(6506007)(7696005)(26005)(41300700001)(83380400001)(9686003)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Njk5NmRoano4N2M4N2xEdWx6bHF5QVB5eXpqbnpHRU9xTGRYZXRvblZocFZp?=
 =?utf-8?B?WEI5cm5id3kvdGFYYjFPTWFQRXJNY2R6UnhjQkdxMUZGMS9URWh3UGg0TlVt?=
 =?utf-8?B?Zk52TTlXeG1ZR3d4SmVZbmpLQmJyak9VTklEQU1wb0cvWER0dVV5TEYwS3p5?=
 =?utf-8?B?Z25xMk5IdENIWHVsNlB5MjB6REVJRmZEbm5BS3FGb3BkV01OTjBnZ2xEYTky?=
 =?utf-8?B?RTM4YjlEM00xUzFGc2o3VzFSTGtiZmV1YmpSUkFqZis5VmkxanQxeXIwM3py?=
 =?utf-8?B?SHhkNmkwWXpIaE55YXJpY0NjZ3NWSWdTMjBTZllBVGJESlE3RkRzTy9oNFlR?=
 =?utf-8?B?WlBGZSt1QVQvQkFCWlVpb0FhdXBuYzlBK1dBdGYzUEZDMmZmbmZqdm41M2NI?=
 =?utf-8?B?aVZDeGk5eHM0M2NwODlVd2piSjZTSEJ4WEVUbnNoNkxlaDdnSC8vUUJiMFRi?=
 =?utf-8?B?UFdBUXExYTZ5VFUwSll1OWpXc0ZDUDcwZjZHQXFWTzVuOVNaZHE1TERMemlX?=
 =?utf-8?B?c1p6aFUyMXBFUTJxdGdvdWhZMUN2bU55N2NOby9rbTJCR2RKQ2ZjditTTyty?=
 =?utf-8?B?K0Jxb052ckhCZTBLbXAzN3h1WklHWUthekVxM1JxZGovdXl3SmtMUXY5YWQw?=
 =?utf-8?B?ZnVDSHdhZ1pVb2hjcWxkZHgxNnI4RmVONmpIMW5NRlpnK1Y1bmlXaE9tQm1Q?=
 =?utf-8?B?RTRlN2JNRDZRN1hsRVBneElnQlNPejhxdU5rM3FoUm5wdE5TeFJ4bGlveUw0?=
 =?utf-8?B?cDlEWXdsVjV4cHQzQnA5VWxXQnlUQ1h0aTREWXRxL3NaZUJOczM4RFVWNzha?=
 =?utf-8?B?SXlFQkExcUxIQzVVTlFOVWRVNEpCZzZPYzhHZEtYUGZHTUtHZVJNWVFXY1l5?=
 =?utf-8?B?ZzlycnBkc3lVNm1KeGdlcGJwZjRWMXoxV05MMTdTUjBkTmpZRDVNcDhkNjJz?=
 =?utf-8?B?SUE3S29XSVE1MHhwUEF2TC82REE3aUZmWnNOZXJ1YkVrdVVFYVZFSFdteDRO?=
 =?utf-8?B?cUVMOGxnSFlpOENzNytEZTlUc3RWNk5JNURCZHcrVlduc0NhU29FNE53WWZm?=
 =?utf-8?B?WXVoemU4SzgvV0hKZWRKd2VQbWZ4Zy9DaTZDM0wzN1V4dVdoZ1V3TTMwVzBX?=
 =?utf-8?B?LzBYa2dvZFRyM2dXY0xGa2NrbmZtVnI4V3oxYVNTSzhzOFhDTTNtM1BaTTV0?=
 =?utf-8?B?T0RKNHJHRnJ0amNoM2NQek9nOXVTMzB4Vis1RktNcG94b0NnQUoyYVhJdmJG?=
 =?utf-8?B?N3dVenk2eXFYVDhJMEMrVmtTNHdqV3h3RG5ZTG9mM2lPcEZkTFBkTDkxay9w?=
 =?utf-8?B?Z2pVa3NiQzdoV3ROTytWbDRKNWhTNVo3Q1o1MmZMTEdCQkdybG9ZWXZXZmVy?=
 =?utf-8?B?UXNUcjk3bTlZM1lYSEQwc3dtYnk4bFZjaTZBNGZ1MG1DYVFxVGFmQzBDVTNj?=
 =?utf-8?B?T1BMT0hLSlkyZmRESDFXY3B2ZXVFalR6dVpIZEVWeEtaeVh0VVNBMEFEKzhG?=
 =?utf-8?B?dWFnUjAzMG1McHFhdjZoeDYzVlFEdTZ6UWJqMG03VWFMS2NQTlVTMEFiTWVw?=
 =?utf-8?B?aGlDMExHM2NCR2lOZFpjRWVSMWIyT2tjVUNFaG1RTzNHczN3VTZURVRQZTZW?=
 =?utf-8?B?bFF4c1NrWmcxcUUrUnlOUW43NHZXWnpHeDVrZlpEUUFubWlFbmt0VGlhcStI?=
 =?utf-8?B?VnpKSXdCZjNRODlxOXQ3TVhhZHZWUUxua1hENEtpWmdqYlNQVFJzM0VtMkVy?=
 =?utf-8?B?TTgrQUxWWWJtSHFuOGFFa1VaTjYvb2dFQzJPTyt3cUcrVldDZ0VzMzJvcXVQ?=
 =?utf-8?B?dnVGYzd0NmZ6ekc5WHM0R1pRMlNuVXFlWUE0dG1BWllmZ2IzdnNhTnZ1M0ZZ?=
 =?utf-8?B?OUFzeWl2NldlNTFLK0lGZFFSNGNqZyt1ZGRnQTFmdnV5YzR5d25RYkc5UndL?=
 =?utf-8?B?VkZRQkhKZmNqN3ppTVBlbFQ5NGIzei9JMXcwVU05dHNxdCtUTStGRFdVYllD?=
 =?utf-8?B?YTBlVFhWQWZtc09iMjB1dW1YeHRvK0RJQVhIZDIvcis2S0NxNVdacFYrUDYz?=
 =?utf-8?B?T0xIaDZnbGVrSUJwVDlrSW5BTFBOY0Y5YmZibG1kWk44RzNScWJBSUFtVEJR?=
 =?utf-8?Q?0iQRbgS3fvZdAR79/Pvs43Txe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4587e7-7d1d-4425-10f9-08dab2450cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 02:44:46.6080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gz+NpxoE+m1NaSGD9sedZ4rhE1OLZBYWfKG9A16vfQZVclyaLEgY7uespRxi/qIPXNcgeQOsLNwXZ+Xdy1HpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTHViZW4sDQoNCj4+IElzIHRoaXMgInRlbXBvcmFyeSIgYXMgaW4gIndlJ2xsIHJldmVydCB0
aGlzIGNvbW1pdCBsYXRlciIsIG9yIGlzIGl0ICJ0ZW1wb3JhcnkiIGFzIGluIHRoZSBjb2RlIGV4
ZWN1dGlvbiBpdHNlbGY/DQo+PiBJcyB0aGlzIGp1c3QgZm9yIHRoaXMgdmVyc2lvbiBvZiB0aGUg
SVAgb3IgdGhpcyBhbmQgYW55IG5ld2VyIHZlcnNpb25zPw0KDQpJIHN1cHBvc2UgdGhhdCBpdCBp
cyBtZWFudCB0byBiZSByZXZlcnRlZCBsYXRlci4gVGhlcmUgaXMgYSBzaW1pbGFyIHBhdGNoIGlu
IGNvbW1pdCBjMjVhN2E4YmYxOWE5ODU3OGFkMjdhYWFhNzgwODIyNzZlYTE1NTdjIHdoaWNoIGFs
c28gdGVtcG9yYXJpbHkgc2tpcCBtZXMgc2VsZiB0ZXN0IG9ubHkgZm9yIGdjXzExLjAuMyBkdXJp
bmcgbWVzIGxhdGUgaW5pdCwgd2hpY2ggd2FzIHJldmlld2VkIGJ5IEBaaGFuZywgSGF3a2luZy4g
TXkgcGF0Y2ggaXMgdG8gYWxzbyBza2lwIG1lcyBzZWxmIHRlc3QgZHVyaW5nIGdwdSByZWNvdmVy
IHNpbmNlIHNlbGYgdGVzdCB3aWxsIGFsc28gY2F1c2UgZmFpbHVyZSBkdXJpbmcgcmVzZXQuDQoN
CkJlc3QgUmVnYXJkcywNCll1YmlhbyBXYW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4gDQpTZW50OiBXZWRu
ZXNkYXksIE9jdG9iZXIgMTksIDIwMjIgMTE6NTMgQU0NClRvOiBXYW5nLCBZdUJpYW8gPFl1Qmlh
by5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEdyb2R6
b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2
YW4uUXVhbkBhbWQuY29tPjsgQ2hlbiwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0Bh
bWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpdSwgTW9u
ayA8TW9uay5MaXVAYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgV2Fu
ZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kZ3B1OiBza2lwIG1lcyBzZWxmIHRlc3QgZm9yIGdjIDExLjAuMyBpbiByZWNv
dmVyDQoNCk9uIDIwMjItMTAtMTggMjM6NDUsIFl1QmlhbyBXYW5nIHdyb3RlOg0KPiBUZW1wb3Jh
cnkgZGlzYWJsZSBtZXMgc2VsZiB0ZXNldCBmb3IgZ2MgMTEuMC4zIGR1cmluZyBncHVfcmVjb3Zl
cnkuDQo+IA0KDQpJcyB0aGlzICJ0ZW1wb3JhcnkiIGFzIGluICJ3ZSdsbCByZXZlcnQgdGhpcyBj
b21taXQgbGF0ZXIiLCBvciBpcyBpdCAidGVtcG9yYXJ5IiBhcyBpbiB0aGUgY29kZSBleGVjdXRp
b24gaXRzZWxmPw0KDQo+IFNpZ25lZC1vZmYtYnk6IFl1QmlhbyBXYW5nIDxZdUJpYW8uV2FuZ0Bh
bWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMNCj4gaW5kZXggZTA0NDVlOGNjMzQyLi41YjgzNjI3MjcyMjYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTUzODEsNyArNTM4MSw3
IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiAgCQkJZHJtX3NjaGVkX3N0YXJ0KCZyaW5nLT5zY2hlZCwgIXRtcF9hZGV2LT5hc2lj
X3Jlc2V0X3Jlcyk7DQo+ICAJCX0NCj4gIA0KPiAtCQlpZiAoYWRldi0+ZW5hYmxlX21lcykNCj4g
KwkJaWYgKGFkZXYtPmVuYWJsZV9tZXMgJiYgYWRldi0+aXBfdmVyc2lvbnNbR0NfSFdJUF1bMF0g
IT0gDQo+ICtJUF9WRVJTSU9OKDExLCAwLCAzKSkNCj4gIAkJCWFtZGdwdV9tZXNfc2VsZl90ZXN0
KHRtcF9hZGV2KTsNCg0KSXMgdGhpcyBqdXN0IGZvciB0aGlzIHZlcnNpb24gb2YgdGhlIElQIG9y
IHRoaXMgYW5kIGFueSBuZXdlciB2ZXJzaW9ucz8NCg0KUmVnYXJkcywNCkx1YmVuDQoNCj4gIA0K
PiAgCQlpZiAoIWRybV9kcnZfdXNlc19hdG9taWNfbW9kZXNldChhZGV2X3RvX2RybSh0bXBfYWRl
dikpICYmIA0KPiAham9iX3NpZ25hbGVkKSB7DQo=
