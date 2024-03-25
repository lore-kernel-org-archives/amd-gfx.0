Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A999BC54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 23:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4600B10E0E1;
	Mon, 25 Mar 2024 23:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWdBLKYa";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2127.outbound.protection.outlook.com [40.107.101.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81D310E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 23:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E74P8z9RL9Vf+J2dt/7vzitOocGMYZGKrPnOMCFH8xXUMi1uub9tAlzyQU3neeJp5XWcNtVG30/aMQJZLZ06rk3QEf9xlTRCdNtUd2Ty+dazGeH6FQmdOGJU7n6Iy0GCSZGMViQpTjDJSAX4g+uZVQOtG3hDHkz1dXK+AygOS+jAiYiJmKqQZuSwepEAQJPUwa+8PvQqhgy5mmRNww2j69qvjVsacLJr+PNa/k73yck+VAFXt7OLyCI5tBQzfiYzamYx6NKvRdH81oFdkzEg/R5qUjLHM6f/phDKFXrcobf55oOUNFp6cYJ4Mkx9aJtt6QEvL9zPme5CW+kR+dGV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyz5zi6bXvFoZuAagw7PZ1oiOY+rGUabasiSh19OctQ=;
 b=DE3CZ2XsATOSukVQojrEeM2JNMSALjVuSin4JiekYqhzYG3GyoIBdlzAE1ERyspaWFWGEyAWY7idNOe/o+fUxPY8SSxd1H1yuvP7SwlzGxnwrrY3ykquP73WmiIahrLN6j+rKEZtfAs5/dVE7qBR0y8O+IPoeaOZ1cLx2Qcd+cuDHJ+C04kE29ORiH8vFrYdinL9Lykr3/iuoA+pRRlohJAvmciRVGlBQOlCnG5tJlsSNS+0yZo+VUv0VB/knmBPygvYnY7hqpu4IJ/of2FLnZNsT1FzndoS9pA2DtQLs0KcOktk0STRDko9OQBrQZjS3rfQ20gQRv18v67h1bwEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyz5zi6bXvFoZuAagw7PZ1oiOY+rGUabasiSh19OctQ=;
 b=xWdBLKYauX3Oje8cuDhJgX4mSXfCmMAu765BYpK3chmqDavxCq2ch+lExzKB5P3pattit0MYNx7hebEVmnuSE+s57DA5zfOSHUC9YKJp13BGNXYbPa32yTvN/5SmznBGYrRdY1sbc8YuR4rnJf3sTV6cQZ1su5lxj0dDdJI26z4=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Mon, 25 Mar
 2024 23:33:17 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 23:33:17 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Topic: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Index: AQHafHkE7VgplRr2nUa/aZd+99nt3bFI08YAgABMO+A=
Date: Mon, 25 Mar 2024 23:33:17 +0000
Message-ID: <CH0PR12MB5372C29628094DCF2C51D2BBF4362@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
 <1d3c4b3a-733e-4820-ba8f-0466cb26a45c@amd.com>
In-Reply-To: <1d3c4b3a-733e-4820-ba8f-0466cb26a45c@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9ed372c0-9ddc-4536-a000-65b27ae58abd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T23:30:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA1PR12MB5637:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+w+klFer9kMczPxe2KMJMQyvF1j+oOaZj1+1cdReSV0W6SwYyaFP9mYD6pKGcbyfa/U81tdnnTFlnEIrQ8U9HKhJILkdmVeeyJwU3mEz2BYIV5mAvHD9xR1xhi89e5gBi60G88c37dXhM9x++WnXZ4mFKgw5RIQzExjwln3+UTtyMBYTKcoYquWgcUkBpifTAxOMRo4okh5alz3617SwGUtHU8S6Oud4WdPqkEZV9M3qcRYKAZJP4AmTg5vafo/TlJX1fLyJdCDnXB9Bvb49KT6dFGp/J6RwCwh56NFEbNrwnI3RT9+pKMMznv9Ob3HuVQINBsOUOnu6orxIUhpedXQJdc27C7OlCCclCoYpYdwVgZaCmQJ4ljzDXuhMgL4wO0HQ/FDlWhtZXfsxL6lUGC7da6RKvqGNAtkYFlbgzZpwVJBTYrZVtoMhliJFyZOlDiVmKNYxLLBfTVmYMlHG8iqxgdQDkBYyrWIcBc9jQ0MFc6Dn//31Tt4S1dM4WMZFExI5/Vu0h+ijnqY64OtPqRWMdjyW0HVzVrF/XAwIz2uoAJHan+fcp3Qze6XEgaf3MOE7xEZc8PxgJ9gnEZ2RogojLXohETaF83nvHNIxRZ2UiRDpKQ6iGib6126GRvib1GcQu4+iP+O0kaK1GTC0L/6Pey5CWePcxYSuqnPkZ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHBkdDZaMi8xTHpvVSsvRHRHTEdZTVlXWDZSenBCSzBpNVpiekFPRlJBMzZF?=
 =?utf-8?B?SVg0RFBneU01RHdtanFmc3FiLzhlK0IrUURGZGwzNjN5dXNCL04yZkU3dnN0?=
 =?utf-8?B?UGw2Y3RUQ0U2NzFtOCtmNGNUcmwzbWd4TU1BQ2VqVzRaVnp2S1ZXSjBuc2c3?=
 =?utf-8?B?Rk13MElOKytoSnlZaWdvMFJQcU5WZnhqeXFISlhDaTBpeERmU2NsYy9wTS9Z?=
 =?utf-8?B?QitJdWg0UUp2SmgzVTJFZXB4L2RtMGVHaVluWTVnc0ozeVZuWnMwZTFCcGVL?=
 =?utf-8?B?ZmhSTEgzUHZ6UkFBNFdWTTlFRXZqVXM0bUhlbDJaN25rTEQyZEVZanEzNnFp?=
 =?utf-8?B?dkVQNzZlQmRsaXcrM1ZXTitNV3BxY1RLUk92ck5hdmlnTlY1ZlZOY2dXc1BT?=
 =?utf-8?B?R3B6cGZDMjQxS1pDK0MzTVBIYzJDMG9PdmZHMGJjSDJ5bVB1V1dZQjRqR2pG?=
 =?utf-8?B?VWFPOEtGVm9neDJIRUIwM3A1Zjh2Z3d2OEg2UkpNbncyejdSUkFrYWpxTk1u?=
 =?utf-8?B?WkFjQ200ZlptMC9HaGc2MFpPaHlKOXc3dnluYnNNL2ZHMTJoaHp5dUpyU1Mw?=
 =?utf-8?B?V3I0cll3MU12YjIxa2tYWHZQNGxkTGY3VThMUzRnSDUvTGlsZk9ZTGxRUVBC?=
 =?utf-8?B?Tk5pblpXL09pVGNLdmlBSEhSUVZjTzBRUDY0QldycjM0eEVmQXh6TzFTWEJ3?=
 =?utf-8?B?SjRUQktYM014TTV2WHpvL1hZWjRPR2xVcUFBc0lTZW5qRW1PTC85WFM2bHI0?=
 =?utf-8?B?NEtJelo1L1RMK05mVThPRUVRdkMwbEtOcUV2SmR6MkhMcEV2OGtpZHJPaTlS?=
 =?utf-8?B?S2hPM2ZRNmJldEF4azV5ZHRaUFVTOU5la3N2SW9iQmtuV1l4VTFVaU1pZXRk?=
 =?utf-8?B?WG1tUWVscWE4V1ZwNVFRU0xsL000WUhLQmlUeFRGNmVxT1JleW1PUXN4VXIz?=
 =?utf-8?B?SnRuajVTajlMckZDcTBMRlFXOE9aV1RucE5xUHFXTkhmcy9jZlg5WEoxS0Jz?=
 =?utf-8?B?TExqL2x1Q2Q1ZEhPbnZCRC9uRStmSHc1aTVyWFczeUEwREhvU25oVVR3akZ4?=
 =?utf-8?B?aXFGQnFjRnJjSnpXQ29BRW5tZ29FMllJZThMcjBWQVFZTGF6MG04Kys5UXJm?=
 =?utf-8?B?cDJTQU8ycUZscGkyKzZqZm9HVFpaSzJSTXRNQWt6Q0ZjeC82cGtWVytxOEc5?=
 =?utf-8?B?d2gwVG5JbzYxRnVwcmRhVFplcXg5Ym9CMndiS0Q0UTNEQUV5bjM5MDE1QkZX?=
 =?utf-8?B?N0hKNE9peWZPTCs5Mm81RGxtMWdEYU85VHY0OTdyTzdKTHpmOFQ1YVQwa2ZW?=
 =?utf-8?B?ZDVObXlFaG43WGFETzBuV2tzNHphblBBTkV6amNhWUNPR2RJazZ1NWQxdjVC?=
 =?utf-8?B?bTJTUllLZGJjbmZaaU1qeDFmRGZQUnpZL0EyNUxqcjhjVFpOaHpvajY0NTRN?=
 =?utf-8?B?N1RvTGhEdWg1b0dDWUJGYXFCR2laSkFZYnF0b2JDRGpJcndHOENqUThVakY5?=
 =?utf-8?B?bUVoaCtkd2RqMzJtL1R4RDFlMHVMUEpzRHdEMTg0eUpSTWdMdGx0ZFRaRFNa?=
 =?utf-8?B?RDcyYzJYV3BDd3kwYmhFdllvbVBTRjg3dm1hbmVpYzhCUWQ3K2xtcW5XM3li?=
 =?utf-8?B?Nlp3Z0Y2RFdDbTUySHd4dnB5TEZiYm5HRmlPK2Jua3FGRVljMzhmTElZeGJE?=
 =?utf-8?B?NlVDM3VvcHRJcVpSSHE5VWp4OHhpUG5ZcjAwTW9ULzBsYmJyZDVJZ0dMZ2sx?=
 =?utf-8?B?aEt4YTl0ZjJkeUxDaDhORWZYck52RGkzcllFaURwWHZxNWozdHpCeDdxZUNT?=
 =?utf-8?B?aFBDUnE0czg5d0NHc04rTFV4NHhOTFo0bENuYllSRUUwRE92MU1MTW5LWTZ4?=
 =?utf-8?B?bGsvQTJiODZZYkZmRU5JSmlZZjF3YUMvZHI0a3FnSm0vempLb1RYVm1rUEE4?=
 =?utf-8?B?TklaTytHN1JnYTFUcmtBWFFYSVl4RUNiZHgyTVFoaXhISFh5SjNydklJSXR3?=
 =?utf-8?B?dmVDbWxTeGNBZ3RGRkZmNVlTWmtDSlorMTBxRGRQaTZsbXgrV0pDVDdiWlpN?=
 =?utf-8?B?Y1lVdzlhazlaUzc1aVNKb1dXQmlOUHNaYVRDLzc5V3BQWVYxdHBOTGZIL1Zq?=
 =?utf-8?Q?LOsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f78a217-4f1b-4d93-1cb4-08dc4d23f311
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 23:33:17.6810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8fQAJgSWaix5nnpBUOb/0YuzaHZRAwu08MeQud1kqhiXBv4XK5C4zAeomS2KWXjUDt22Q2kSYACVBumklCHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkl0IGNhbiAgY2F1c2UgcGFnZSBm
YXVsdCAgd2hlbiB0aGUgIGxvZyBzaXplIGV4Y2VlZCB0aGUgIHBhZ2Ugc2l6ZSAuDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+DQpTZW50OiBNb25kYXksIE1hcmNoIDI1LCAyMDI0IDI6NTggUE0NClRvOiBM
aXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdSA6IEluY3JlYXNlIHRoZSBt
ZXMgbG9nIGJ1ZmZlciBzaXplIGFzIHBlciBuZXcgTUVTIEZXIHZlcnNpb24NCg0KDQpPbiAyMDI0
LTAzLTIyIDEyOjQ5LCBzaGFveXVubCB3cm90ZToNCj4gIEZyb20gTUVTIHZlcnNpb24gMHg1NCwg
dGhlIGxvZyBlbnRyeSBpbmNyZWFzZWQgYW5kIHJlcXVpcmUgdGhlIGxvZw0KPiBidWZmZXIgc2l6
ZSB0byBiZSBpbmNyZWFzZWQuIFRoZSAxNmsgaXMgbWF4aW11bSBzaXplIGFncmVlZA0KDQpXaGF0
IGhhcHBlbnMgd2hlbiB5b3UgcnVuIHRoZSBuZXcgZmlybXdhcmUgb24gYW4gb2xkIGtlcm5lbCB0
aGF0IG9ubHkgYWxsb2NhdGVzIDRLQj8NCg0KUmVnYXJkcywNCiAgIEZlbGl4DQoNCg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBzaGFveXVubCA8c2hhb3l1bi5saXVAYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jIHwgNSArKy0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaCB8IDEgKw0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+IGluZGV4IDlhY2U4NDhlMTc0Yy4uNzhl
NGY4OGY1MTM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfbWVzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5j
DQo+IEBAIC0xMDMsNyArMTAzLDcgQEAgc3RhdGljIGludCBhbWRncHVfbWVzX2V2ZW50X2xvZ19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICBpZiAoIWFtZGdwdV9tZXNf
bG9nX2VuYWJsZSkNCj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gLSAgICAgciA9IGFt
ZGdwdV9ib19jcmVhdGVfa2VybmVsKGFkZXYsIFBBR0VfU0laRSwgUEFHRV9TSVpFLA0KPiArICAg
ICByID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgQU1ER1BVX01FU19MT0dfQlVGRkVS
X1NJWkUsDQo+ICtQQUdFX1NJWkUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBBTURHUFVfR0VNX0RPTUFJTl9HVFQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmYWRldi0+bWVzLmV2ZW50X2xvZ19ncHVfb2JqLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJmFkZXYtPm1lcy5ldmVudF9sb2dfZ3B1X2FkZHIsIEBAIC0xNTQ4LDEy
ICsxNTQ4LDExIEBADQo+IHN0YXRpYyBpbnQgYW1kZ3B1X2RlYnVnZnNfbWVzX2V2ZW50X2xvZ19z
aG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdW51c2VkKQ0KPiAgICAgICB1aW50MzJfdCAq
bWVtID0gKHVpbnQzMl90ICopKGFkZXYtPm1lcy5ldmVudF9sb2dfY3B1X2FkZHIpOw0KPg0KPiAg
ICAgICBzZXFfaGV4X2R1bXAobSwgIiIsIERVTVBfUFJFRklYX09GRlNFVCwgMzIsIDQsDQo+IC0g
ICAgICAgICAgICAgICAgICBtZW0sIFBBR0VfU0laRSwgZmFsc2UpOw0KPiArICAgICAgICAgICAg
ICAgICAgbWVtLCBBTURHUFVfTUVTX0xPR19CVUZGRVJfU0laRSwgZmFsc2UpOw0KPg0KPiAgICAg
ICByZXR1cm4gMDsNCj4gICB9DQo+DQo+IC0NCj4gICBERUZJTkVfU0hPV19BVFRSSUJVVEUoYW1k
Z3B1X2RlYnVnZnNfbWVzX2V2ZW50X2xvZyk7DQo+DQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgNCj4gaW5kZXggN2Q0ZjkzZmVhOTM3Li40Yzhm
YzMxMTdlZjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tZXMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmgN
Cj4gQEAgLTUyLDYgKzUyLDcgQEAgZW51bSBhbWRncHVfbWVzX3ByaW9yaXR5X2xldmVsIHsNCj4N
Cj4gICAjZGVmaW5lIEFNREdQVV9NRVNfUFJPQ19DVFhfU0laRSAweDEwMDAgLyogb25lIHBhZ2Ug
YXJlYSAqLw0KPiAgICNkZWZpbmUgQU1ER1BVX01FU19HQU5HX0NUWF9TSVpFIDB4MTAwMCAvKiBv
bmUgcGFnZSBhcmVhICovDQo+ICsjZGVmaW5lIEFNREdQVV9NRVNfTE9HX0JVRkZFUl9TSVpFIDB4
NDAwMCAvKiBNYXhpbXUgbG9nIGJ1ZmZlciBzaXplDQo+ICtmb3IgTUVTICovDQo+DQo+ICAgc3Ry
dWN0IGFtZGdwdV9tZXNfZnVuY3M7DQo+DQo=
