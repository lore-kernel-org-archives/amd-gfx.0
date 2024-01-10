Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDEDC4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 20:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D4510E656;
	Wed, 10 Jan 2024 20:54:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AB410E656
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 20:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvSVNPGOvR/juCmLVKENr6+SSPbMx5OkHkN36JMF8JjaxtzN844yuRpDmnTGzzLpvK6FgPW6ThmEfSfO7guo8cbX4dCOYWHOn8kpRbh3G3ywK26eoc6DfFiKKU5wpS+PKHj5SvcSSALzca5RxkfdI2/tj46FZoglf3cdHtuxMhzSsT30lk83xTP0AM7usLhj64U3rWGSMX6LsG3SSi4SCsAOeNIJ9ajOwqsTN3s8ZQ57etWRHZeCSMfnqNL2okiiatl/WOij2iTVnbh+0bsYUiliUUs/Fr7d9rrDm8UAtl+OxiiJS1J5SY9tTJNOO4Lc/Fa2mtLpgwCEQycqoR3RuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16INWVH5yKGLqUJPSWUfyU78wffVUMBNi1TwxjgIitE=;
 b=fypLoiYUjky1VFiOkWQbVjEsiiOb0cqqVMVRFLeg+ZqLUSzDn+OuTYe1ZgU30jHPWRzRs8zIV48+BDFCNxK8mhJ8cNarieWloWsKPanBAhVVAOr3wglTaS6vQoKVLqnYBf7hLo+nhfI1rq3mmdqWReQoUL4eYXbjq4iQaDLLC8nCvBJefFK13NXdI8bhAm0y9szwT6BxebTPBQR3yFeCGiNXU89IIrBRRUCiKA8VRFbkmUWlctF18k5xj5+5uVn1aCuU1lpWSSBF9zR0Fo/e/TZZ4FcdTDIkA4VK/GqKF6ITGvQnA2H7mXfSENXWy0dp6W/ioD+CCKVH5ckpgoaGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16INWVH5yKGLqUJPSWUfyU78wffVUMBNi1TwxjgIitE=;
 b=olkipTo71QFYLTyn68qON3D7VZEXpF3b+vQwDjpxjFfBE90PhVES0i2pmSoxPyuBIQ5dUoM8y9LO4kDdMbIzXA15sjFIZ3IxU/tNvkT7FaBBQxC3hELKRsI4ONWWKNbq0xYVMjB97FVF29MPmY0oXrTovisMGrPNMD0cCKjxOAQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 20:54:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 20:54:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alexander Koskovich <AKoskovich@protonmail.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Topic: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Index: AQHaQg5xcJeFw0AC60y3NTa3oyYX3rDQfpSAgAChyoCAATK6AIABI1hA
Date: Wed, 10 Jan 2024 20:54:46 +0000
Message-ID: <BL1PR12MB5144422FD5FD583F7DED1DC0F7692@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
 <V1DvhMMvcMsI7dtFmlkI47ANQn6mZIrZbA1ONvsXABCU-9Xfss9ULOs_9Ult1ydgnppu2fNEMqDlU00jrSEXdI8kh2ioGRqVTsy7IUstgeM=@protonmail.com>
In-Reply-To: <V1DvhMMvcMsI7dtFmlkI47ANQn6mZIrZbA1ONvsXABCU-9Xfss9ULOs_9Ult1ydgnppu2fNEMqDlU00jrSEXdI8kh2ioGRqVTsy7IUstgeM=@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cb3b377f-7ba9-43b5-ac88-9762e2831ed8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-10T20:53:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5732:EE_
x-ms-office365-filtering-correlation-id: 96624f74-1021-483e-7e9e-08dc121e60e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZ1tmU1tQu1ybH5u1m7G3Op95Ke9pOv8GsR7ISLPynwJhfjJselMAKLGRqip9c9PKTnK4ChqXCYpeU577x51B+6HoO/fmyDTnH3EoskRkCeSOKouXibbaQxPdlGNH72Xz8IA4P35rFHZA9z87rUZ58WQgOFtaus++74gEQnPbgxWEP49+46DvMjlzOInY7NmKeY81EFYtgNLRWVMyMkLI1qMXjZjWt7S5VKTSVw0V2kfdZAEpSyI1/YrQwv2/UHf9cxdsmwHs0nZHhU8Brwikgqpa3X7h5q/HWPyaFaLCXCU3g3qsVXhxNoguVuL/4grNvd0Wpb5uQCoCy0iedF2jQh0WP2MPtT0DdRD0OOrsmmdEi/LD3IN2R249LQshLa+Gp23gN4mijG3pT9mXiV8arKe5oj8RpnHrsPwmdYsuQ1m1tFmXh+6wpJpRScIlq86m68VpjcmUT+z9gdLIeHvi6Jmz2uClNTOvDpW6/RXUKJxx6WPfK8Q8Wa9nBKRcXHvuEkXccAgO/K+Rcks+4KGKqYdq5gypxvrYzGHhP/a2czqss2Hf8srcftuK0nqhlF2EXA0C2y6V/RCzCJ1inaTSFbZANz07qqvMKHcNqSykfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(66574015)(4326008)(9686003)(26005)(122000001)(38100700002)(53546011)(52536014)(8676002)(5660300002)(2906002)(966005)(66556008)(66476007)(66446008)(64756008)(8936002)(6506007)(71200400001)(110136005)(7696005)(316002)(478600001)(66946007)(76116006)(33656002)(38070700009)(41300700001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmtxZktnOHZPSW8rSS83V1JKcE52dkpGTlk1TEgxaG5RSE1sOFpWczZjRFlq?=
 =?utf-8?B?NVRDRzNvOEtIQWhYR0xDYmpxZjc4M3FDbzBtUlJwSWhVdUpHZ3NMd0JETXhQ?=
 =?utf-8?B?WUNiMDZkNmVXQ1VpV0ZaVy95cEZzbTAySjR4dUVWclRoM3JKQmNGK3YrV2Qr?=
 =?utf-8?B?b2VIOHgxaTNSbjFYZHdyc25ZWGswZFlvdnhPNVNRaEgyV1ZCeFhwY3JsVUgv?=
 =?utf-8?B?RUdEUmFFR2RPMVpobE1KYnU2S0ZOZ01xTjdQczBQcjZIelQrZDJIWmtEMUtq?=
 =?utf-8?B?TytucjQ0QVhoVUg4QkVmY2xETnJNbFNLOEhSU1pBRHR3Mk45ZytQYnZGL2lB?=
 =?utf-8?B?V3RVLzBxbFJIZ2tGQkwrOHdXY3c2WDh5YjlQSU9tYVVsVTVFZjhYejhwdldR?=
 =?utf-8?B?LzNweWMxTUgzWlBhS2RmRHI1TE9xcmVhbytuREY3RzJIQno2eUFGZm9wRXJQ?=
 =?utf-8?B?QWtQVjBjaERTbURaSGFLT1RIQXVOWGZWdFhxRnFpdWxDWENvbm5sc042Y0Y4?=
 =?utf-8?B?Y3RMcnFxZVJqbGlhck1MQkZPQU1RVk82ZTZ3TFFjN1MzZFhXMjdKSzlsZTJX?=
 =?utf-8?B?b1o2NHZQZGR0T2dqVEh1bklZcFl1cVpvUlUvTEw3UE8wTkNESGZMcTdYbkxh?=
 =?utf-8?B?TzFKTzZlTmZmZ0V4VUJ5eFc0cGpjRWFNU3VQcVByeE1BaGdSM2lxV0E0ckJI?=
 =?utf-8?B?SDUxb0RWRFFXWDRDaW4zRzFSRXlPa01ucEpmVXJRM1QwcmMweVV0RE5xc0Qx?=
 =?utf-8?B?SDJZdkpnMFY5Y1NPWnN2ajIzVzhNaG1OOVFxVGtBRVphZ2trdHEwL2lJVTJH?=
 =?utf-8?B?MGcwVlFtL1V1RXMvM29OSnBWNjVSYnljL2Z1VTlvWU54V3BxeTg3ODRzeTZt?=
 =?utf-8?B?YmhPZnJLS1dNTnphSTFMcUxpVkxBRElmcWdOMEQzamgyQ0hWemtCLzBEaTVn?=
 =?utf-8?B?bmpWdFBtaXFrMWZjRS83ZXEzM0JYMlYxQTZHWjFPQzU2aVhCajU0b0VHSFQ0?=
 =?utf-8?B?R0orS0xRREhBVWFpV0tDUUtzeWNzZHVJeHFab0xwQ0tqYXgvT3dHTlZHemJV?=
 =?utf-8?B?QzkrUHRvWkgyZk11RzZiTE8vTjVCRlAvcUtxUStkSEtROGVKOEY4aXIyN2k4?=
 =?utf-8?B?L0V2K1lySzNYNzhVaXdkS3doNUdhRmNBZEFyMk1MVzFEa0VPdmJZcXRhd2to?=
 =?utf-8?B?TUxyU1lsWTlCaFB6K1hxYUR0cGtNdzdoMGh5UVRjL1d3ejQ2VG56UDk5T2Ju?=
 =?utf-8?B?d3RMeklmUUgzdElUOE01V0dvT2c5My8yYnU1WVVEcFlaeTNXVFNMcjVTa0lv?=
 =?utf-8?B?SWE3U3BUdzduVVRlSER3V0RaY1R0M285YUIrd2pNUlRYQXhLbkpOUzgyVXBQ?=
 =?utf-8?B?Z3oxUlNSUXE5YUlDMy9GVVVPZmxGWVg5czk2bWd6YklRY3N4UGRQRUJFRWta?=
 =?utf-8?B?b0RjTWVkSW5PM1F1bnUvTHBYY3o0eFU2c0F0ZHZtL2kzTjF2QTZYR2trdEM3?=
 =?utf-8?B?K01IOTJ6ODkrbUxSUEUzQXVPaGZSd2tVUmJ6akk0ZTVYdTZNc2ZlVXBaeDUw?=
 =?utf-8?B?ZVkxY2loSFMzNGFOUWQ1aHhSVnRhR1hrY25icXNvcXA0aDBWdnRVL3lCVE5N?=
 =?utf-8?B?VVVzczBXdlYyVWxZSHMxYmd0QXFtT2RzTk9tVVFUMWxwWVdydUpaWXFOV3dN?=
 =?utf-8?B?WnRJTnF5dURzSFR4NFlaeERNQ2gxOHF6d3JvY2luYlkzeGRXWmxXSGl0UU85?=
 =?utf-8?B?UldpYnpmYis5T29aUU81QllqejZ5OFJkOHRhSnRMV3E0U0o2RVJ0RFBQL014?=
 =?utf-8?B?SkpsNk5JcHdmUjk0ajhzQzZtRE9lOEFRK1V1RjlQdENtQytaZTQzV2U0ZEs0?=
 =?utf-8?B?clBBWXlJeXdZY3YwYWFHcUJDc0FObm5HZG54L2RNdXUyc0VmekxrWE5LWjNL?=
 =?utf-8?B?S3grcnlyUXFuNWhQTTBabEtWOEJ6RHdYUWVUempvaE9uRFpoQjFPR1cvZDhL?=
 =?utf-8?B?NUhLQkJ2eUpXdTMxeTFRZUE4bmVOZHQ2ckU3bm1XNk1WVE5JU3JCQWNwaGI1?=
 =?utf-8?B?VFJEMUhaM1JjUjVZLzV0MS9ZYVNFNDVkV1o5b2JKQ2R6QkJESDZBMlFRdzk5?=
 =?utf-8?Q?4nmw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96624f74-1021-483e-7e9e-08dc121e60e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 20:54:46.3758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKyIkGnh3mG5VzzxXqovGLBFkjHa8XjkEv7DKO7SagOzH42eDeuSYQJh4Ahii3yw6XIl9I5TwNFcR2QAtfud3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4g
QWxleGFuZGVyIEtvc2tvdmljaA0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDksIDIwMjQgOToy
MSBQTQ0KPiBUbzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBS
ZTogRG9jdW1lbnRhdGlvbiBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5MDAgWFRYIChSZWZlcmVuY2Up
DQo+DQo+IEFyZSB0aGVyZSBhbnkgdXNlcnNwYWNlIHV0aWxpdGllcyBmb3IgY2hlY2tpbmcgb3V0
IHRoZSBBVE9NQklPUyB0YWJsZXM/IEhhdmUNCj4gbmV2ZXIgZG9uZSBzbyBhbmQgYWxsIHRoZSB1
dGlsaXRpZXMgSSd2ZSBmb3VuZCBvbmxpbmUgYXJlIHRvbyBvbGQgZm9yIHRoaXMgY2FyZCAoYXQN
Cj4gbGVhc3QgaXQgcmVmdXNlcyB0byBvcGVuIHRoZSBWQklPUyBmb3IgdGhpcyBjYXJkKS4NCg0K
DQpUaGVyZSBpcyBhdG9tZGlzIGFuZCBJIHRoaW5rIHRoZXJlIGlzIHNvbWUgbGltaXRlZCBiaW9z
IHBhcnNpbmcgaW4gdW1yLiBUaGF0IHNhaWQsIHlvdSdkIG5lZWQgcHJvYmFibHkgbmVlZCB0byB1
cGRhdGUgdGhlIGhlYWRlcnMgaW4gdGhvc2UgcHJvamVjdHMgd2l0aCB0aGUgbGF0ZXN0IG9uZXMg
ZnJvbSB0aGUga2VybmVsIGtlcm5lbCBhbmQgcHJvYmFibHkgYWRkIG5ldyBwYXJzZXJzIGZvciB0
aGUgbmV3ZXIgZGF0YSB0YWJsZSB2ZXJzaW9ucy4NCg0KQWxleA0KDQo+DQo+DQo+IE9uIFR1ZXNk
YXksIEphbnVhcnkgOXRoLCAyMDI0IGF0IDM6MDIgQU0sIENocmlzdGlhbiBLw7ZuaWcNCj4gPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToNCj4NCj4NCj4gPg0KPiA+DQo+
ID4gQW0gMDguMDEuMjQgdW0gMjM6MzIgc2NocmllYiBEZXVjaGVyLCBBbGV4YW5kZXI6DQo+ID4N
Cj4gPiA+IFtQdWJsaWNdDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gPiBGcm9tOiBhbWQtZ2Z4IGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmcgT24gQmVoYWxmIE9mDQo+ID4gPiA+IEFsZXhhbmRlciBLb3Nrb3ZpY2gNCj4gPiA+ID4g
U2VudDogU3VuZGF5LCBKYW51YXJ5IDcsIDIwMjQgMTE6MTkgUE0NCj4gPiA+ID4gVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiA+IFN1YmplY3Q6IERvY3VtZW50YXRpb24g
Zm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAwIFhUWCAoUmVmZXJlbmNlKQ0KPiA+ID4gPg0KPiA+ID4g
PiBIZWxsbywNCj4gPiA+ID4NCj4gPiA+ID4gSSB3YXMgd29uZGVyaW5nIGlmIEFNRCB3b3VsZCBi
ZSBhYmxlIHByb3ZpZGUgYW55IGRvY3VtZW50YXRpb24gZm9yDQo+ID4gPiA+IHRoZSBSR0Igc3Ry
aXAgb24gdGhlIHJlZmVyZW5jZSBjb29sZXINCj4gPiA+ID4gKGh0dHBzOi8vd3d3LmFtZC5jb20v
ZW4vcHJvZHVjdHMvZ3JhcGhpY3MvYW1kLXJhZGVvbi1yeC0NCj4gNzkwMHh0eCk/DQo+ID4gPiA+
IEl0IGxvb2tzIHRvIGJlIGhhbmRsZWQgdmlhIEkyQyBjb21tYW5kcyB0byB0aGUgU01VLCBidXQg
aGF2aW5nDQo+ID4gPiA+IHByb3BlciBkb2N1bWVudGF0aW9uIHdvdWxkIGJlIGV4dHJlbWVseSBo
ZWxwZnVsLg0KPiA+ID4gPiBJdCBkZXBlbmRzIG9uIHRoZSBBSUIvT0VNIGFuZCBob3cgdGhleSBk
ZXNpZ25lZCB0aGUgc3BlY2lmaWMgYm9hcmQuDQo+IFRoZSBSR0IgY29udHJvbGxlciB3aWxsIGVp
dGhlciBiZSBhdHRhY2hlZCB0byB0aGUgRERDVkdBIGkyYyBidXMgb24gdGhlDQo+IGRpc3BsYXkg
aGFyZHdhcmUgb3IgdGhlIHNlY29uZCBTTVUgaTJjIGJ1cy4gVGhlIGZvcm1lciB3aWxsIHJlcXVp
cmUgY2hhbmdlcw0KPiB0byB0aGUgYW1kZ3B1IGRpc3BsYXkgY29kZSB0byByZWdpc3RlciBkaXNw
bGF5IGkyYyBidXNlcyB0aGF0IGFyZSBub3QgdXNlZCBieQ0KPiB0aGUgZGlzcGxheSBjb25uZWN0
b3JzIG9uIHRoZSBib2FyZCBzbyB0aGV5IGNhbiBiZSB1c2VkIGJ5IDNyZCBwYXJ0eQ0KPiBhcHBs
aWNhdGlvbnMuIEN1cnJlbnRseSB3ZSBvbmx5IHJlZ2lzdGVyIGkyYyBidXNlcyB1c2VkIGZvciBk
aXNwbGF5IGNvbm5lY3RvcnMuDQo+IFRoZSBsYXR0ZXIgYnVzZXMgYXJlIGFscmVhZHkgcmVnaXN0
ZXJlZCB3aXRoIHRoZSBpMmMgc3Vic3lzdGVtIHNpbmNlIHRoZXkgYXJlDQo+IHVzZWQgZm9yIG90
aGVyIHRoaW5ncyBsaWtlIEVFUFJPTXMgb24gc2VydmVyIGFuZCB3b3Jrc3RhdGlvbiBjYXJkcyBh
bmQNCj4gc2hvdWxkIGJlIGF2YWlsYWJsZSB2aWEgc3RhbmRhcmQgTGludXggaTJjIEFQSXMuIEkn
bSBub3Qgc3VyZSB3aGF0IGkyYyBMRUQNCj4gY29udHJvbGxlcnMgZWFjaCBBSUIgdmVuZG9yIHVz
ZXMgb2ZmIGhhbmQuIGh0dHBzOi8vb3BlbnJnYi5vcmcvaW5kZXguaHRtbA0KPiB3b3VsZCBwcm9i
YWJseSBiZSBhIGdvb2QgcmVzb3VyY2UgZm9yIHRoYXQgaW5mb3JtYXRpb24uDQo+ID4NCj4gPg0K
PiA+DQo+ID4gSXQgbWlnaHQgYWxzbyBiZSBhIGdvb2QgaWRlYSB0byBsb29rIHNvbWUgb2YgdGhl
IEFUT01CSU9TIHRhYmxlcyBmb3VuZA0KPiA+IG9uIHlvdXIgZGV2aWNlLg0KPiA+DQo+ID4gVGhv
c2UgdGFibGVzIGFyZSBmaWxsZWQgaW4gYnkgdGhlIEFJQi9PRU0gd2l0aCB0aGUgaW5mb3JtYXRp
b24gd2hpY2gNCj4gPiBjb25uZWN0b3JzIChIRE1JLCBEVkksIERQIGV0Yy4uLikgYXJlIG9uIHRo
ZSBib2FyZCBhbmQgSSBiZXQgdGhhdCB0aGUNCj4gPiBpbmZvcm1hdGlvbiB3aGljaCBSR0IgY29u
dHJvbGxlciBpcyB1c2VkIGFuZCB3aGVyZSB0byBmaW5kIGl0IGlzDQo+ID4gc29tZXdoZXJlIGlu
IHRoZXJlIGFzIHdlbGwuDQo+ID4NCj4gPiBBZGRpbmcgSGFycnkgZnJvbSBvdXIgZGlzcGxheSB0
ZWFtLCBtaWdodCBiZSB0aGF0IGhlIGhhcyBzb21lIG1vcmUNCj4gPiBoaW50cyBhcyB3ZWxsLg0K
PiA+DQo+ID4gQ2hyaXN0aWFuLg0KPiA+DQo+ID4gPiBBbGV4DQo=
