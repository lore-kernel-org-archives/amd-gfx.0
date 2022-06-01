Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE17C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 02:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD7510ECF6;
	Wed,  1 Jun 2022 02:00:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FED610E332
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 02:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKF01aR0icyL4dXnKrweEruZoommBEGsQx+VmmEq6gBMGV+YdvQ1Itn1VzgGzpcSsNHqdQIyfoe+sWPQwI4kRz/qK3UH7A8ZW+W0v0ElaiEVuvt8U5kTWitSviEioCUy7spvWtwwVz6Kc5nm7hvJqinbrNhGYQPX4icdSlnlaj6nUcGN2uMZI7cmQGax+OCEiPi9QBuCPVCLFwtocJveoX3sB+/nGLpxF3DExGTq7BTOaPsmlN2wi56DKZg7kiaOiLlk8UuEbP0S/9J9/uQymXh/Ziej2Y4TSXDwPRZvux+qoY9oY1BDGT5JjUQuxnzLo9vmRAFN2AVlyd8uUY2g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBbzcOx7QTT+0OSmyd2J4kJc7YM8ywQFGn4WdKb8hpI=;
 b=KZjORCW3qabLhAzYU9nhaDqDOYZP/V0xaaYy19BuXtCRmDTIJIHET0+RvCbvN3Loee4tLUEHwzeMpI2bIAROvQG5myCZpNr+gg4Ou4M8aqtdwa8zr7Iuf04loCc2CDsR/KToL+Ia2zsqQlzeUjPs0u1YlN+n6IP8Tx/eqZSHH6alPW6GGsHgtIO1mIYtGeLSaW2NnXWQU12UmZKXUVru4YF+JGtdI7hTFg1tFv6h8MOud64uNwOb0wNH+MthIvnEHkFOCkwSgdyWW2pbfDvXYny9JhZ20yuH5H5fIDc4PADrEvCq8jvK6jYFxoBh5Ofgj8iPmvc+0rRLBarov5XNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBbzcOx7QTT+0OSmyd2J4kJc7YM8ywQFGn4WdKb8hpI=;
 b=VvJaBESUprrNOGIvhlibwgivUJ/SqvRGulCQ5U8x0rOyI4h6czZcPkTpfdD5oLD8e+Mhc1+xNcxHOAKDESmXd/+4Ykl9Hx4k6hrr2HGdqXO4zWkJnmRJPjf1YsH2IsxsjiFf7EkhVuIwG/73AeTz0yw9gVfumFPhHvUArJUrFtI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 1 Jun 2022 02:00:51 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 02:00:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: simplify the logic in
 amdgpu_device_parse_gpu_info_fw()
Thread-Topic: [PATCH] drm/amdgpu: simplify the logic in
 amdgpu_device_parse_gpu_info_fw()
Thread-Index: AQHYb9yE8hheluduLEOJJUx0kivdH605hs8AgABQQTA=
Date: Wed, 1 Jun 2022 02:00:51 +0000
Message-ID: <DM5PR12MB2469279FD91743078D7E7992F1DF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-2-alexander.deucher@amd.com>
 <CADnq5_NqOGL6g435kS6NmqiU8+wdbzpowVwbzBqoVCnYJj4otA@mail.gmail.com>
In-Reply-To: <CADnq5_NqOGL6g435kS6NmqiU8+wdbzpowVwbzBqoVCnYJj4otA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28001ba9-1c78-4d2d-5411-08da43728e0e
x-ms-traffictypediagnostic: DM4PR12MB5343:EE_
x-microsoft-antispam-prvs: <DM4PR12MB534325090C0580131DE6DBE7F1DF9@DM4PR12MB5343.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pCyacZkbLzIOmhtsbdhSDG/Lk0gZXkwYC6frnyFrBuxBDC4C9C3mKGEDYx7taL92VjKDMaEvBFqq06N5TSuMc/x1tPid84i2kFq383t/QXKpNV2K1qDDF93dBMoeP/1mmUI+RAkC0zmOU2/FN2dpcPJbULW5Tns4w8YnVp8/M1Tiu4ZWq5qJSKJv2+C9FD+TVXMZhNMA4Qmhs9gCq2V+XFecvAd1JoKukY6FFUnpvCq4wwDLtILTN0bkmfearr06Al633RQfU1CYDU4GrXJkQY/Z/oyWt+RtNZ1jdtuXsIBahQf9Wd+MHY3XmBezkaqdH8G73g+LontqtlG8br3JvoxO+rnoglqfEm/LDGH09AkUiIVYPWAzrvI/y3iHGeA6nX/RfzduB9zCB6UTbUG/4JZfUPKxmi2K9iW+G7QYAfVyAiKg1vluNxwfDeGzZtXp+dj9Q1zF8ywn7MSEoCRga3dJLNvQ3RxFwgNNcs6Cf5reCCfsBFA6RKnafW9d8/t/YcGjYZlOw+pGcLn0pvdtU82NUmfs+fTrO7C+utSUbQEzuy77XPNfsIrea7AO4DF4UAy7GbhiW27x7foTcoDcVOItd95ckDBF0BU2TiPMAlQl22xiJeVAKRs6Um/zRlRWCgPez4d+wV5OOS8/g1wo/3kQc/Hs1V0HySxWaefeUscyPKyvTgu7E0uD2zQkVBa0liN29yxJpUaqcD4JidObOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(64756008)(4326008)(66946007)(76116006)(6636002)(66446008)(52536014)(66476007)(110136005)(316002)(8676002)(33656002)(55016003)(86362001)(5660300002)(8936002)(508600001)(38100700002)(2906002)(122000001)(26005)(38070700005)(9686003)(53546011)(7696005)(186003)(6506007)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnJNa09oQXBjVGdCU3pzV1VUWGdlWi9DZE5DUFVBbUc5YWFackI2Slk5cnhO?=
 =?utf-8?B?b0pRUTlObVdWK29OeC9uc3NWbmg2WmVWNFBNY0lCY0dLT3E3QVVPR3FDYmVt?=
 =?utf-8?B?empmVXNpSU1UQTExWFdRNlBTT1lESCtHWXhaKzJIeUVJSk41SDRqZGgyV2pi?=
 =?utf-8?B?WGtOM1lTcS9nWmhDaWx6VVR1Z3hBUEdwb0ZvNkZPaGR3SmhoYU03YSthNm44?=
 =?utf-8?B?SWpwQ3hYcmtzMVgyOXdyV3lmWUYxQnFPalBObHdSblFaYVFDVGtMbUlnbEdY?=
 =?utf-8?B?ajNKcnNYdjlCSDl4WTlnODRsc25xb0F3TFhaYXY1UDNaYUxSUGdCdkVPTzhu?=
 =?utf-8?B?am4yeTFNakozc3hsUnRkNHVsYmRmL05HcWZiMlMzdEc3QmRBNVFNb1h5ejlo?=
 =?utf-8?B?SFk0SWp0SGJXb0lGam14Z09oV1VwNTd1QXRockFWNEYybVNmeWxSeVA4SHE5?=
 =?utf-8?B?bmwwV3IvUmZ4SEpJZnFKaTdvNXlwaDBXa3UvQUt1bmNkYkJsZm1BMDVCN2tS?=
 =?utf-8?B?UTRudE9FMm5iNlVRWUlXazdRb3BiWFBNck5sOHlLNWdpMWFGTjlQeXliMHEr?=
 =?utf-8?B?czlQZE5FbmtzZmtmcEhYTkxRSE1LOUs5QWJaRnc4NWdwMkNya3N3V2dTKzZi?=
 =?utf-8?B?K3BKb2lrd0ZqRjBnaG04L2ZROUFEczRTeWlXSWdmNXhqd2NFb3Y0THVOVVls?=
 =?utf-8?B?RkM1M3dGSHlzVXZObFF0U1JqUk1zOXAyNlBERnVhVDgyaGR0RDZTYSs4UUdN?=
 =?utf-8?B?NnVJOGJBTjg3d3d3V1d1Z0xlOW9yM2tCL3kxemFoSTBUd3FvTjNpeEpvaDZz?=
 =?utf-8?B?SG96QUNFUGZXU3ZMWXZLREhjYm5HMzNGcEVOYkpnRVBzU1JZZGxWbms5YlNx?=
 =?utf-8?B?M2hES1ZVb1R3eGpjRmUrT1EyMGZ3NHpyZDZkc3Y0Ny9GYzJCRExId2tYZHNZ?=
 =?utf-8?B?VzlRWGRGcEM4SnBLelFaSEpqcFJkZ0RWQzBZSG9OSllBMUk4YVowaisvVjFV?=
 =?utf-8?B?SHIxYjA3TlJIMVpnbXlwN0ZBUHBnM3dOQmd2NitmSnVBSlhXN0FpOFBQQjI4?=
 =?utf-8?B?N3NobVV5S2p3cWZZcEtZQVFFZHhRNC9uYk82a0ZxZGdxT3Q5VU5SM0x0T2k1?=
 =?utf-8?B?OWhKc2t4c3RTNTdnNEkxK3kyNndYbHpGa0Z0RDV1cDZDQXNycHJFYWpka0Qr?=
 =?utf-8?B?WVgrTkVpVXNkczNUc2VDVjFNOGpsdmd6bWlnZDdHaTNoY2VxT01SeUdlNDNN?=
 =?utf-8?B?eTZDcy9rSUJMTTlaNWF6Q1FuT3VZUytReW9aVEtIeDNmMGZDSGdrem5va0VN?=
 =?utf-8?B?MXE0K1QrWVBkWm51RzB2OFd3TU9FbzdGcVJSV0dTZzhHejJmY3NERFVGSXVP?=
 =?utf-8?B?Vy9HR3ljdU1PTlM3djFDRDltUnYxM0pQTTN1NnFCeG1lWWx5eVNtN1JvR0lB?=
 =?utf-8?B?QUIzOEZJOHZCZU84Q0pWRkZGWVp4anZMMjRTZEZIMTY2ZXZpSWR0UlpaNGhk?=
 =?utf-8?B?Qi9yMFM0L1hNa1hCbW5QQldjOTljNHBRQUUzY3M5Z2JnWkRkRnY3WVhPY3gr?=
 =?utf-8?B?bFd4WXBvNzdMd3J4SWk0Ly9SZGJ2Q0VHMzN6dnVDcFd0ZGhyTDV5Zm9NemJ2?=
 =?utf-8?B?OTh3Nms0eWlORTM3OVUrRWtzK1pZdjltUEQrT1ArS3FINlA3R3g1NURqVzB6?=
 =?utf-8?B?WDJMVEF3K3BUSTVTK21LUzllUHVzQnRpRWdlVm5JSk5ERnQ1TDlMR2Q2eWhs?=
 =?utf-8?B?RHd5YkIxT3lURjNCQlUyaTNzcGlVSWVaSHBReUhUNy9LZTVFUDhNNXNib3J0?=
 =?utf-8?B?SjNlRVllUk5oNTBQaDNXRFBQbVBmbk8vZGVNNGo2SCs3d2pXd1VUN3hPa0F3?=
 =?utf-8?B?VFBQOXNnc29wdTA2Q0FmRlZJTkxaTzEvUzFkWS9oeDdVVmdLNWttVUdCTjV2?=
 =?utf-8?B?bXBJVnRsUnlWaUNBSW42YnhvRXVBMTlwVGhOSlhPNStjMnBWMngxWVpQc0py?=
 =?utf-8?B?azkwSjBkYTFyUlZTaEtXdG9TMkg4T3VRYkg1N0JhNTc2UXFKUHlnMGpsTk1p?=
 =?utf-8?B?VzUvNjA1SXlZckNXdU9VQTVCMmM3WU14ZmpBa3oyZGFMMG9nbVRkUnR2VE5J?=
 =?utf-8?B?K1lJRWxFbmlNdW5VMGc4d2tRQzhENTFncDJmaUpNME05NVl6SEswS01FTWxI?=
 =?utf-8?B?Zmhxclg2bUJsS3pkWFczMHpxazdPVEx0ZWJhSW9wTUFhdGVlMU5LSitjTEVa?=
 =?utf-8?B?Y1NkUUgrK2YrT3dMOXVwT3RUZEpKQkcwVzYyYWZneEZLQjB4YlFwRXI0eEps?=
 =?utf-8?B?NTE5TW4xY01HU2xjcVd3VkpUNEVYajBhTDBMek1ETTNyanNjeUlXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28001ba9-1c78-4d2d-5411-08da43728e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 02:00:51.4670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HB4SbC7yupedwtVdnAyroJzgoD2ISB6S/ANDBHKWbjBehbKbdVD6XTajFOQl5bt6Cmrr7xfGVcTsTQCYXxXx2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBE
ZXVjaGVyDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMSwgMjAyMiA1OjEzIEFNDQpUbzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlz
dCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBzaW1wbGlmeSB0aGUgbG9naWMgaW4gYW1kZ3B1X2RldmljZV9wYXJzZV9ncHVf
aW5mb19mdygpDQoNClBpbmc/DQoNCk9uIFR1ZSwgTWF5IDI0LCAyMDIyIGF0IDEwOjA5IFBNIEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IERyb3Ag
YWxsIG9mIHRoZSBleHRyYSBjYXNlcyBpbiB0aGUgZGVmYXVsdCBjYXNlLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMjkgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDRk
YWEwZTg5Mzk2NS4uN2Y3ZDQ3NWM0NmI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC0xOTQyLDM1ICsxOTQyLDYgQEAgc3RhdGljIGlu
dCBhbWRncHVfZGV2aWNlX3BhcnNlX2dwdV9pbmZvX2Z3KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkg
ew0KPiAtI2lmZGVmIENPTkZJR19EUk1fQU1ER1BVX1NJDQo+IC0gICAgICAgY2FzZSBDSElQX1ZF
UkRFOg0KPiAtICAgICAgIGNhc2UgQ0hJUF9UQUhJVEk6DQo+IC0gICAgICAgY2FzZSBDSElQX1BJ
VENBSVJOOg0KPiAtICAgICAgIGNhc2UgQ0hJUF9PTEFORDoNCj4gLSAgICAgICBjYXNlIENISVBf
SEFJTkFOOg0KPiAtI2VuZGlmDQo+IC0jaWZkZWYgQ09ORklHX0RSTV9BTURHUFVfQ0lLDQo+IC0g
ICAgICAgY2FzZSBDSElQX0JPTkFJUkU6DQo+IC0gICAgICAgY2FzZSBDSElQX0hBV0FJSToNCj4g
LSAgICAgICBjYXNlIENISVBfS0FWRVJJOg0KPiAtICAgICAgIGNhc2UgQ0hJUF9LQUJJTkk6DQo+
IC0gICAgICAgY2FzZSBDSElQX01VTExJTlM6DQo+IC0jZW5kaWYNCj4gLSAgICAgICBjYXNlIENI
SVBfVE9QQVo6DQo+IC0gICAgICAgY2FzZSBDSElQX1RPTkdBOg0KPiAtICAgICAgIGNhc2UgQ0hJ
UF9GSUpJOg0KPiAtICAgICAgIGNhc2UgQ0hJUF9QT0xBUklTMTA6DQo+IC0gICAgICAgY2FzZSBD
SElQX1BPTEFSSVMxMToNCj4gLSAgICAgICBjYXNlIENISVBfUE9MQVJJUzEyOg0KPiAtICAgICAg
IGNhc2UgQ0hJUF9WRUdBTToNCj4gLSAgICAgICBjYXNlIENISVBfQ0FSUklaTzoNCj4gLSAgICAg
ICBjYXNlIENISVBfU1RPTkVZOg0KPiAtICAgICAgIGNhc2UgQ0hJUF9WRUdBMjA6DQo+IC0gICAg
ICAgY2FzZSBDSElQX0FMREVCQVJBTjoNCj4gLSAgICAgICBjYXNlIENISVBfU0lFTk5BX0NJQ0hM
SUQ6DQo+IC0gICAgICAgY2FzZSBDSElQX05BVllfRkxPVU5ERVI6DQo+IC0gICAgICAgY2FzZSBD
SElQX0RJTUdSRVlfQ0FWRUZJU0g6DQo+IC0gICAgICAgY2FzZSBDSElQX0JFSUdFX0dPQlk6DQo+
ICAgICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICAg
IGNhc2UgQ0hJUF9WRUdBMTA6DQo+IC0tDQo+IDIuMzUuMw0KPg0K
