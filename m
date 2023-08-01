Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684E5C04A94
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 01:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF21D10E305;
	Tue,  1 Aug 2023 01:41:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA7910E305
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 01:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOz4MENjkrTHsl4I4hV4nX4AoQT7hP1gfcWw3XdhD96NQuwfhOKik32q1NH5yZrzdJBNe7qWWJmV33dhKZECf+t9LmgPyAUus4b2YOvcdcFVh+Zqq7pNTWcKtbtgJlyrrR4W8DwaG5NhK1WVRderzSqDDj7UfD2Kg6OSxtctTVh73YHexDR8yJbtlzywsv+IEPbHBtWppuNo3Kua6PsoIk5jLrNtkWLVWa3xQ9XoFz05zPCtvOq1QShUEO+GaW0eV+RxGKZ/GVnF0KcW15cOIG1HPtZJAVzsbEze/pHTa6gCBrebKXODRuB2RDVXOZZYBku1YDru3yAj5Kpr0Sh95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1hq/DK5ldlFC0TFFVEMCkwISVyEVeqKEeIrjvwXOoY=;
 b=LuWwdN9Ucz2p7Tppc8h/sPlQg036sBXOMxr9IPlv1x7b4bfesMmuEhYWWFP3eRPEA1M9Joaz2ygzVdTl/nSguY3uEL0eydOZWNTLTb3ifYg7gQOWGNifn6MKFi7FXpbY+0E7YxG0D9IkFYydquEt9c7kFUf4hM9U+l7N4LK58Gi2byHwceRGAc6Gphmcfy8g/W9M4FBOyQ8jE2O4mPM2TqUjyJrg5SsczTqNV3bsXvmIbD3q7OWy2zPnpVtFDaqffWhKDReVrbA8SmqKl9dt+uZkQ8SlXhEGDKR3x2UyrOx59u6JmrVYtWxxjmitAC0WiVTDm/MRQ1vb3zm2+OEhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1hq/DK5ldlFC0TFFVEMCkwISVyEVeqKEeIrjvwXOoY=;
 b=uIIBbAdkiLPsIkoUbPcWjgihoVtVAPsh9XXTRK7UdD4Yv7uNNZTiFiacz0SV281aKFWy8rKaTr0qGTL/s9FGquLlpjJb0ENSoaM+yXC3zBzK1lnXOAmX4ABkpqeusz367qmAcyex0yN6dY2SZBz9kaqlFnBg6a174YgzeCcLt14=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43; Tue, 1 Aug 2023 01:41:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 01:41:30 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/radeon: Prefer dev_* variant over printk"
Thread-Topic: [PATCH] Revert "drm/radeon: Prefer dev_* variant over printk"
Thread-Index: AQHZw6csLEKH8TxNtU2/ARz8l0Xkt6/UqsIQ
Date: Tue, 1 Aug 2023 01:41:30 +0000
Message-ID: <DM5PR12MB2469C8A6AB6B5D659FB0B45DF10AA@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=46440ed1-ed35-45c6-9433-8fe46d2cac52;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-01T01:39:42Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB7656:EE_
x-ms-office365-filtering-correlation-id: 1d0163e0-3aed-4d00-8961-08db92306e20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wm2EUq9GLqxFDg20Y/D8LrNrrTj1MK19Lnyij84Wj+9oWpv1iONGf2ZZ+W98xk0fnalGlcACUIMFd67XKPIcwBzJk/122KFC5GQy5whJMMQb5ouF77vTofp3xGV0nK0ePS4s8p+BI5TgIlsGG+lawL5THQj8EQfLJSdQ8hixoB3hh+C3WqNXPaTywqycSckJ3pbUqtamTx7EjiBMDffJFfu0glzHwB82S55PmHjCaov5INn3xaZv8NKzhA3FWxF1bZLm8QDvLcifsC5JeM6jX/UJaib/pMSfND7ONNcolmmZuv/0tIttKGT3rpo1qRHtJW19/Z6UBbW8G4rV+tWSY5KAqGROtN/MuUIAWfiAD9qkbymmQi+H95CLNc95Akex6qT1Ab5we1ZNKgw6QO4qClkDkNvu6NCo+7DIzoun2k36ege5NLNtYvG4H/aKVlkY7emc4jxhXW3KgprOtDqrmIoPZ3w01lmR+aZq0mSGPlDys1zkoKCLyn1EmDFnpm9LBVXmc/1fYw54YHr7wI0dnZ2rl7QXVbKDskOPDmXNrY0SP+vXxZ4IBQyjQHysoQzvlXY8CLe4lh/grAJOFJ8MOZJHsXRaSRYT1bFkCnyYLCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(38070700005)(478600001)(38100700002)(122000001)(55016003)(86362001)(33656002)(966005)(9686003)(71200400001)(7696005)(53546011)(186003)(26005)(6506007)(8936002)(8676002)(76116006)(52536014)(5660300002)(6636002)(4326008)(66556008)(66476007)(64756008)(66446008)(66946007)(2906002)(54906003)(41300700001)(110136005)(316002)(66574015)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWE4UDh5Vngrc3JKeXBiQSttK29TT3pkSXhhcFlySWo2aVhNMlZ2emUzM2Y1?=
 =?utf-8?B?eUZ3U3RCZkxGTTExSjRIdWRoM0puZE5wZEthTCtBWW1iNDVlTVpuRGN1cEU0?=
 =?utf-8?B?dENUNDlmZmxGNDcwZnV0U3dyV0hSQTAvN3o5TjAyUCtOdVhZdGVqVnVaSXdD?=
 =?utf-8?B?M2VLa1d2MmVLSmw3cjU3dkVtbVo4cVdOd2o4M3dnQ2IvdmMvbHFKWU8yUkFt?=
 =?utf-8?B?MG10SXhBcyt6a1VzckpqcUZ3MC9Ndm1NelNCMXBmaFMxT3ZSWmVnaVQ3Ynhq?=
 =?utf-8?B?ZTN3MXhIU0dvVVNhRHQ0K2ZEOUJLNC82dlIwWmx2MmxCM0tVeHZyL1pmMzM2?=
 =?utf-8?B?ckh4Nmcrclh1eEZzdTJnSUpoalZpR0o2bWI1byt1bWpQZUNkdSs4ZFZmaXE4?=
 =?utf-8?B?ME5PbC9sUGo5VWtBN0pZQ0JOK0IyOTVxS1RsbDB6aC9neDNGano4Qk9WQ3Fj?=
 =?utf-8?B?N20yUVdoUEIrMVNlOE9CM1BEVWNZN1J0RTFNc3RqbnAxY0dxcElTaVY0eFBa?=
 =?utf-8?B?ckE5V0xyMU5pU0VwZnRoYWpld3NTYU9mZGlVbkp3Sk0rdnpodFNqRWtMNGcz?=
 =?utf-8?B?V2NuOEpnc2xLMjRRelBTVTUvMG5MUytiT2lDMGRjVW5kZkNVQzExbCt2eG9H?=
 =?utf-8?B?Z081OWNRT0hNUmNEMkZzVWtGRFBseFp4V0lZR3MyOTBhS09qVFdicnRTN2pv?=
 =?utf-8?B?UmZlR1lGZk5CZ3k5bVRmRmhmSFVBcHo0N3h6T1RzdDFLcS8zVHF6azc1OHow?=
 =?utf-8?B?V3lXOVU5djlVUmlVL2hGYitkL01PYTNYTGltVGVHMEh3R3dNZ2pBSFhzS283?=
 =?utf-8?B?SkNNK3NwSUs3bEQzM3JjTGE4OGJYMDBHUUdhZm02RnYxWFJYNWdYMDNYVDBy?=
 =?utf-8?B?QUNVdGZIdGU2MEpudlpMOUsydXNNTWYyN0ZmeFJ2OHpNeEsrRUlsOTBMNzZK?=
 =?utf-8?B?ZHU0TjluVWNmZXlvamliZzJFTnNDbExxNkJEclViaE5mMVZGU2FKSTMxeUI1?=
 =?utf-8?B?MjdRU25xOHQ2MDM3L0k2M3JGM3hjY2ZRYmxJMW41dmZrYTduS2RqQ3U3YlUv?=
 =?utf-8?B?VTA1NEhZUFRySzI0aTVhOGtkSGlRMVJMbFNIbHdQbXUrcDZ4dGVnemZCTG5q?=
 =?utf-8?B?Q2VFWURvN2xpdkJFNDJjSEdSR2JaelRVVGhGaXIyeUdqNFJJMWo3L3BtRGlE?=
 =?utf-8?B?R3drL1o5TUs1cUpwRXZ6SnpHSU90WmU5Tyt2eURlZnN2S3dNMjkxbEo4dWla?=
 =?utf-8?B?RXRhMVhGR2M0VW1hNW4yVlB2Nk45MVI0ZVZ2bXVWOUNCZ1BGL056TWhDUEdn?=
 =?utf-8?B?UitzWWVkQlNLdE5BM21wQjRjVlNFd3BUcm5paEFBNkpMNnU0OGxsWTBGYTQ3?=
 =?utf-8?B?NExyRUxOMDY5RGgwSjByMGt0VzNXeXh6RklDSUQxSjFIaUIzVE9xUTlYYk9E?=
 =?utf-8?B?dzQ0K3dIQ2F0VVdXUi9Zbng3MzQ2S25LOFl0THNXeHMvNXNjYlQvQWY3R1A5?=
 =?utf-8?B?SDBZUDM0VjFUZmRML3dHM3U2QngxVi9tREt3aG5rNkMwWjZQZS93dnZiUUo4?=
 =?utf-8?B?aG51cFAvQXZMZFV6RGhKNTBhZzhUYUIwUkJ1UThLMEh6YThIRTMycWI3dUw4?=
 =?utf-8?B?T1kyZGtBZ3o2aGZodFY4TWtVRTJ3L2Q1UXNvOFhjck5NemdUR0FINEM0Sm8x?=
 =?utf-8?B?OW4zanYxRGI2d3I5L21vd2ROWmQxMm1SM1hPVkV2d1IwOGYyeXBOMW9WZFFt?=
 =?utf-8?B?Mlo3N1NLVmZ6UVcreTByRm9nSFhnRGd3eUV5RWllWm50UGVJVnFxRC8zYndo?=
 =?utf-8?B?QmdjMGVteE5GRGNIU0lDOFJlZzVYaThKUW5WR0RtZEVpQUpBN0lyQldscmZ3?=
 =?utf-8?B?V1NVVkhtZWJsanJMT2t3dzBLVVB6MmZ6M0hpaFI5WnJZOU9tM1NiUXJVTURr?=
 =?utf-8?B?TVh3RFdrMFMrd1VYdWh1KzlxNm1qWDlQc2l3b3JIZC9kZUZkZUNTdWt2OGJZ?=
 =?utf-8?B?VGhoVnd4Z2Y5dVZXbzlhcFVuSlNLZzhDVkQ3MmtOUVF6cjFOWkJDdy8xWlV4?=
 =?utf-8?B?ais3eDkrS1NyYWNwZWdXNVJ6SURVWklmb1VwVjVXdzNjMGlMT2s4T2c0ZC9t?=
 =?utf-8?Q?bfrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0163e0-3aed-4d00-8961-08db92306e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 01:41:30.6741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFnZGctTyqaASCKirdLVF/int5mxb57UXCbVEbaGPhvcrAtMQ+XY6jPMO52WBmoZEn0KIPLbZ0hgTgyR/G4+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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
Cc: Bert Karwatzki <spasswolf@web.de>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgSnVseSAzMSwgMjAyMyA4OjA0IFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0K
PiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IEJlcnQgS2Fyd2F0emtpDQo+IDxzcGFz
c3dvbGZAd2ViLmRlPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIFJldmVydCAiZHJtL3JhZGVvbjogUHJl
ZmVyIGRldl8qIHZhcmlhbnQgb3ZlciBwcmludGsiDQoNCk1pc3NlZCBjb21taXQgSUQgaGVyZS4N
Cg0KV2l0aCBpdCBmaXhlZCwgdGhpcyBwYXRjaCBpczoNClJldmlld2VkLWJ5OiBHdWNodW4gQ2hl
biA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQo+IFVzYWdlIG9m
IGNvbnRhaW5lcl9vZiBpcyB3cm9uZyBoZXJlLg0KPiBzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYg
PSBjb250YWluZXJfb2YoaGFuZGxlLCBzdHJ1Y3QgYWNwaV9kZXZpY2UsIGhhbmRsZSkNCj4NCj4g
UmVmZXJlbmNlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1
ZXMvMjc0NA0KPiBDYzogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+IENjOiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IENjOiBCZXJ0IEthcndhdHpraSA8
c3Bhc3N3b2xmQHdlYi5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0g
PHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fYXRweF9oYW5kbGVyLmMgfCAxMiArKysrLS0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdHB4X2hhbmRsZXIuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0cHhfaGFuZGxlci5jDQo+IGluZGV4IGZiNGQ5
MzFmZGYxOC4uNTk1MzU0ZTNjZTBiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9hdHB4X2hhbmRsZXIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9hdHB4X2hhbmRsZXIuYw0KPiBAQCAtOTQsOCArOTQsNiBAQCBzdGF0aWMgdW5pb24g
YWNwaV9vYmplY3QgKnJhZGVvbl9hdHB4X2NhbGwoYWNwaV9oYW5kbGUNCj4gaGFuZGxlLCBpbnQg
ZnVuY3Rpb24sDQo+ICAgICAgIHVuaW9uIGFjcGlfb2JqZWN0IGF0cHhfYXJnX2VsZW1lbnRzWzJd
Ow0KPiAgICAgICBzdHJ1Y3QgYWNwaV9vYmplY3RfbGlzdCBhdHB4X2FyZzsNCj4gICAgICAgc3Ry
dWN0IGFjcGlfYnVmZmVyIGJ1ZmZlciA9IHsgQUNQSV9BTExPQ0FURV9CVUZGRVIsIE5VTEwgfTsN
Cj4gLSAgICAgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2ID0gY29udGFpbmVyX29mKGhhbmRsZSwg
c3RydWN0IGFjcGlfZGV2aWNlLA0KPiBoYW5kbGUpOw0KPiAtICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmYWRldi0+ZGV2Ow0KPg0KPiAgICAgICBhdHB4X2FyZy5jb3VudCA9IDI7DQo+ICAgICAg
IGF0cHhfYXJnLnBvaW50ZXIgPSAmYXRweF9hcmdfZWxlbWVudHNbMF07IEBAIC0xMTcsOCArMTE1
LDggQEANCj4gc3RhdGljIHVuaW9uIGFjcGlfb2JqZWN0ICpyYWRlb25fYXRweF9jYWxsKGFjcGlf
aGFuZGxlIGhhbmRsZSwgaW50IGZ1bmN0aW9uLA0KPg0KPiAgICAgICAvKiBGYWlsIG9ubHkgaWYg
Y2FsbGluZyB0aGUgbWV0aG9kIGZhaWxzIGFuZCBBVFBYIGlzIHN1cHBvcnRlZCAqLw0KPiAgICAg
ICBpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykgJiYgc3RhdHVzICE9IEFFX05PVF9GT1VORCkgew0K
PiAtICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGV2YWx1YXRlIEFUUFggZ290
ICVzXG4iLA0KPiAtICAgICAgICAgICAgICAgICAgICAgYWNwaV9mb3JtYXRfZXhjZXB0aW9uKHN0
YXR1cykpOw0KPiArICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGV2YWx1YXRlIEFUUFgg
Z290ICVzXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICBhY3BpX2Zvcm1hdF9leGNlcHRpb24o
c3RhdHVzKSk7DQo+ICAgICAgICAgICAgICAga2ZyZWUoYnVmZmVyLnBvaW50ZXIpOw0KPiAgICAg
ICAgICAgICAgIHJldHVybiBOVUxMOw0KPiAgICAgICB9DQo+IEBAIC0xNTksOCArMTU3LDYgQEAg
c3RhdGljIHZvaWQgcmFkZW9uX2F0cHhfcGFyc2VfZnVuY3Rpb25zKHN0cnVjdA0KPiByYWRlb25f
YXRweF9mdW5jdGlvbnMgKmYsIHUzMiBtYXMgIHN0YXRpYyBpbnQgcmFkZW9uX2F0cHhfdmFsaWRh
dGUoc3RydWN0DQo+IHJhZGVvbl9hdHB4ICphdHB4KSAgew0KPiAgICAgICB1MzIgdmFsaWRfYml0
cyA9IDA7DQo+IC0gICAgIHN0cnVjdCBhY3BpX2RldmljZSAqYWRldiA9IGNvbnRhaW5lcl9vZihh
dHB4LT5oYW5kbGUsIHN0cnVjdA0KPiBhY3BpX2RldmljZSwgaGFuZGxlKTsNCj4gLSAgICAgc3Ry
dWN0IGRldmljZSAqZGV2ID0gJmFkZXYtPmRldjsNCj4NCj4gICAgICAgaWYgKGF0cHgtPmZ1bmN0
aW9ucy5weF9wYXJhbXMpIHsNCj4gICAgICAgICAgICAgICB1bmlvbiBhY3BpX29iamVjdCAqaW5m
bzsNCj4gQEAgLTE3NSw3ICsxNzEsNyBAQCBzdGF0aWMgaW50IHJhZGVvbl9hdHB4X3ZhbGlkYXRl
KHN0cnVjdCByYWRlb25fYXRweA0KPiAqYXRweCkNCj4NCj4gICAgICAgICAgICAgICBzaXplID0g
Kih1MTYgKikgaW5mby0+YnVmZmVyLnBvaW50ZXI7DQo+ICAgICAgICAgICAgICAgaWYgKHNpemUg
PCAxMCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJBVFBYIGJ1ZmZl
ciBpcyB0b28gc21hbGw6ICV6dVxuIiwgc2l6ZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBw
cl9lcnIoIkFUUFggYnVmZmVyIGlzIHRvbyBzbWFsbDogJXp1XG4iLCBzaXplKTsNCj4gICAgICAg
ICAgICAgICAgICAgICAgIGtmcmVlKGluZm8pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgfQ0KPiBAQCAtMjA2LDcgKzIwMiw3IEBAIHN0
YXRpYyBpbnQgcmFkZW9uX2F0cHhfdmFsaWRhdGUoc3RydWN0IHJhZGVvbl9hdHB4DQo+ICphdHB4
KQ0KPg0KPiAgICAgICBhdHB4LT5pc19oeWJyaWQgPSBmYWxzZTsNCj4gICAgICAgaWYgKHZhbGlk
X2JpdHMgJiBBVFBYX01TX0hZQlJJRF9HRlhfU1VQUE9SVEVEKSB7DQo+IC0gICAgICAgICAgICAg
ZGV2X2luZm8oZGV2LCAiQVRQWCBIeWJyaWQgR3JhcGhpY3NcbiIpOw0KPiArICAgICAgICAgICAg
IHByX2luZm8oIkFUUFggSHlicmlkIEdyYXBoaWNzXG4iKTsNCj4gICAgICAgICAgICAgICAvKg0K
PiAgICAgICAgICAgICAgICAqIERpc2FibGUgbGVnYWN5IFBNIG1ldGhvZHMgb25seSB3aGVuIHBj
aWUgcG9ydCBQTSBpcw0KPiB1c2FibGUsDQo+ICAgICAgICAgICAgICAgICogb3RoZXJ3aXNlIHRo
ZSBkZXZpY2UgbWlnaHQgZmFpbCB0byBwb3dlciBvZmYgb3IgcG93ZXIgb24uDQo+IC0tDQo+IDIu
MjUuMQ0KDQo=
