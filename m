Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5880FC001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 07:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBDF10E149;
	Wed, 26 Jul 2023 07:52:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7A710E149
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 07:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxEtWjVeuwrisdqSwlAP720QaoglYhGK0chpFfTD/2PS6zKz7BxiofZFmjp4ODza2YwxwmJgWDwIopn08RCYRwlKF1XCO2Is92xaPnLesVHFxpsPhv8A5NaHC290yctCg3DrG2vA3ZJejznvtwdLLDKjnXdfLMUusukTMYjRxNalGFSplwhXzyZNrFilrGQMKSsqKCQxkF/GIOF3YYTlAH8BiTrhKi5mMa5et2Z+4Ad8F0oxsfbOxaYZvj2pN6DjDXQSYCax4ezqt+0E7dPYW99RpGNDtAzIdFaQgrU3yCHXXAfBgecwaEy8J8W0QQLczN7FqLZuAIIYuOtPz6NJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaWSCTE1zHuAMFuFcaNQFClWKJGBTo2qdkjOoAQWxLQ=;
 b=mC0Lmnf/Dkb9TsCbXdOggOJD2/fAh3wbLgTNU1fA5Kh6zXBqddXcMzw9V+//C4go2NesPVDYM9ruIMxgy4VVG8xTZ2NjFOCQW6CDCv4mm5rCUR5yTYqlS0oB9y1TlJ56jstq8x/ofZKYbmeMpGPp+UtNotnXpFWr9NLCvLyIgdZiWnAc1aKUTwjA7C+qjAxZgQ/rfuqY1ytr8Q+WafNi/OGVB7XLsylJwvtONbHwGy6rYhHr4emepN1vGFm95ebyoyATMiE7hid8rwpo7TCobOLvl3rBGcCCX7K8OilXxXhscYVaTJ/8e8kboGkPysILFShyoTtGHaWq0Q4syRNDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaWSCTE1zHuAMFuFcaNQFClWKJGBTo2qdkjOoAQWxLQ=;
 b=qHH+Y/8sZUAT6tQTzpBoOYZOFt8/SHCudlhtV9z/iBM6GQmoYzfkFrAUIV71DKW4cFGTSqP5PVa5NzCNA3hJd/UcAxmU/mc+zMZ99iNVbPiZFqWo4DiNtJDns/MtXlF/6S8tXGBxUVZKY1Ev664UIhkSJXHhkp5hwTJ4FCe2LSw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 26 Jul
 2023 07:52:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:52:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix non-standard format specifiers in
 'amdgpu_show_fdinfo'
Thread-Topic: [PATCH] drm/amdgpu: Fix non-standard format specifiers in
 'amdgpu_show_fdinfo'
Thread-Index: AQHZv5L1dD0WCZMcxkiQXzyocpn+Jq/LrRJg
Date: Wed, 26 Jul 2023 07:52:53 +0000
Message-ID: <DM5PR12MB2469E06EC3286DF588D85931F100A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230726072918.2455771-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726072918.2455771-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=536a3dff-9ca7-4338-9ea5-01af1dbdbd85;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-26T07:52:26Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: da5eba4b-d91f-4db1-69e8-08db8dad512b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khnbgt+XG/7/57iVjsdGOtSD05lKb1hYyOoy3Py1/pPar2aGseNFd4yN0mJWcdpF9Msy/hfDpeIJY1NBq3PFAMO3/xG3Q3hZO1SlDfgLJPpJTGDD5aHUPEqV4hwImHQPf9b0MUR5OVx+HWqeMMGM8ikUEHAma94PwwQoL4dmheYZq9l2q9LKdH2MeZ+dquGfguXGLqr5qCLJ9zlq07Lv98uxSzysIrUcanFtNpDVT+/g7irtEBZzPFISV8pRBUbNg2e4vm4nF5TX0z75UC4gUzK9lwxyvaRBDm7h51ol+8GVffldMFwtNgPIdc6Dp1ZYjiaXBHSlLpKukztP7CBHni9YUX8e2DS92UamWblbriOgSg5NC3kJrbWgy6+LCOwHUwclqrk0nfq8QCkv05mpTGX8EoWBnv/htzet2EtJbVkTGchT3Otkrl1IIDSATmf9MFDtW1pnIpIY7QPlukhxUnpufDRzMYDW/ofFnln6WkKbD8+waRi1a/DHJ47sZ61PaRRNj4N3rcGLrdlgE1J/8rQqUOTzk2JBVDhG/Dhi3qIA0eLf47YtaarDb6WBNRjszAEezrf2DKGky1CxzxkilbWG6C/R1XzXc1d3w6yAkWvu/gFqEpr5je3JJxZlRnB9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(33656002)(41300700001)(55016003)(2906002)(66574015)(8936002)(26005)(186003)(71200400001)(4326008)(6506007)(5660300002)(83380400001)(53546011)(64756008)(76116006)(66946007)(6636002)(52536014)(8676002)(66476007)(316002)(7696005)(66556008)(66446008)(110136005)(9686003)(478600001)(38100700002)(86362001)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE83dVJDYXF2dTc0WUt4ckNvRkpxTHNzaDBxMTh0aVk5SjdsYTlqSGRhWEE5?=
 =?utf-8?B?VEN0VnFoV2NrTGx2a0NuQzVnZytRcHBkOXRzMkNoSTkrTlBJK2ZoUWJLdEJ1?=
 =?utf-8?B?VVRYTnp4eEhjUkU3Wk5PRFg1VHA0aTRtR3I1SlkwWkpYZW9KRXRneXdwOWhF?=
 =?utf-8?B?OHMySzlVVTloZFhYQ3FVb1dZMTlsNW1DblYxTXR3NnlaQlRJTGVYc3o3TldJ?=
 =?utf-8?B?Yzh5Q1cvSHk4WlYzeGZya2VrOENXa1NjbnUzcE9CZHArT1hTektiK2tBVmNL?=
 =?utf-8?B?TFh1NHI1VGtGbjZPRVRwcUhZcFVhTzVscVBYRHZvRUMwalRsVkp0dG5kNTho?=
 =?utf-8?B?UUlHK2JleVhUemNBSXk4NHU5MTZMZkJvSlc4Mi9SeEVodFJvM0hXVG9DL29V?=
 =?utf-8?B?YWQ3WERBZ3d2S0l2MTh3NFpZTkhxSjg3Ym9HdmJpMksvcm4wdC80MXViQWRH?=
 =?utf-8?B?ckswT0NyQnhPQytBampwQ0dzci90cDN3amRGVVNEdDVTRkFYVllYQmJsQTdo?=
 =?utf-8?B?RmNuajNMaXVmYXRmTEFpcFN2Sy9TeUZ3bXZQR0dWQ1VGUFRtN0RCTEVvQU5v?=
 =?utf-8?B?czhaVVcwWVZjMEZ1UlJHWkxZWk5pSVJWZXpqNW1pVW91dmQ4WHZoY3JORGt3?=
 =?utf-8?B?WFZ4WUV6NVcvYUEwaE1IK29XWVRGSmdqR2lodFJXRDRCMzFIcEJSSCthaGJx?=
 =?utf-8?B?d014MzVqMmR2eUw1SElKeWV0ZU92UlkvOUY3N2hqY2doTGlhU3g4U01aVVBa?=
 =?utf-8?B?NnlMQis1Y3VHMW9xRVh1S2NQb0I0QTJMRFJPT01ObjFoTjE1TWExNWZMRVlG?=
 =?utf-8?B?alJYeHlLaTZNTVlZcnBNazdPQUQwVVUzS3g5S2ZWRHptRFIwaCtRUkNwQ1RJ?=
 =?utf-8?B?QVEvc1JkcHZDUDNpT2NCQUNoUmVOL0FjSkpXZ3NGa0NsL0o0REMwUzZINlVx?=
 =?utf-8?B?dHNyOXBuWjRkZkNHd2Z3cTUzSG5KdlFucC9oUER1ZFVQand0WjBadW92TUlV?=
 =?utf-8?B?VzFTWFRlbVI4eVpDc1ZwS0tQQ3A5ZGkvZC9oWXpiNDlxMC9aK1JFUXFnem82?=
 =?utf-8?B?UFlIREdYNHZGVWFBdyt1KyszenpBajRIK0xzVUtlUS85VXhRU09SRFl5cm51?=
 =?utf-8?B?UlpRVFRyRXl0MlRQbC9KMm5QUjZEOWNxbk9Rc2J3cElleGpCcFZUNlFWN0d3?=
 =?utf-8?B?Uy91Y0RiVi91UnRiMnJwYllqcmpRWk1SM09GR2RCVzFiOEFSYUF2cUN5YWdY?=
 =?utf-8?B?RHpLM0NpNi8ycStFbGdtZ0ljZE8vRFlrSGRlVyszYzV0a1FqdFNsYkVTdjhI?=
 =?utf-8?B?SlkwQkxtbWQ3RHZubmV5Ynl3eVRPSk4wcXVHdU40V1QrU2pKNXFpaHF3QkpH?=
 =?utf-8?B?a3FQeGU5ZnRBMEJ2dmZKVkdWOWE1cnVEdUpobFFRUEtqWGtDaFdFVml6ZGhE?=
 =?utf-8?B?OGRaY2pucXR3VXYwaGltcVdaUkludmNBYnRiNHFkVFd6NXljYlNSSkhsRjIy?=
 =?utf-8?B?M1ZLVDdxcFlab2xSWFc4eHV6K3dRbkM4UGxFdHNpdU1oREhxaGxLVkhMdGl6?=
 =?utf-8?B?U21sTkZXcjNqMUJnOUJic3hKbjhmOTVZYUZsMTAxdVhsVlB6eExLNHlSY1ZB?=
 =?utf-8?B?QWI3V2g2ZmZCSUw2Mmd0SVE1NnBKK21WYW5rTmxGKzhXVjcySjhFT1RWUTIx?=
 =?utf-8?B?anhhL21SSmFtcUNEMnd0dUx0N1FBYUNHakF4cjJ6Qnp0dDE2MjUxSENZSVQ5?=
 =?utf-8?B?QktNQy9rVDlIcXU1MHNFeTlzOEF0N1RsNUpoWmVWYzZwR1ZXQXJ5WHVZbmdL?=
 =?utf-8?B?bHlzNDAyUFcyUnhyaUs3UDlSS2txRzFmSkw1dkdNQzY5a1NRWlA0d2FpY2pO?=
 =?utf-8?B?VWRLT2tsTVRROG4xYjBMVDdBM0MyekxFOUpFaTI3RU9lZHpWUGJhUWtuKzRC?=
 =?utf-8?B?eWlFMkVIYi8vaDJRaisyN1ZPSHBTVzNERSt5TGhpdER5RkxvODZyUWNWVi9D?=
 =?utf-8?B?VXZ3aVBmay8rNWN6NU1wMXVWWHJtRXJaOTg5Yk5QNTBQekN0akV2UHBySDdQ?=
 =?utf-8?B?eTFnN3BibHZMM3dxUWtWMllpazlnMi9kM3lndDMyYytTMVg0QitOVldEYlZy?=
 =?utf-8?Q?1wPE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5eba4b-d91f-4db1-69e8-08db8dad512b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 07:52:53.3142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhKnIM6b7iKPgD3kysZ31xVoXAb0juWtYuWbMP+FIKTqZWgIAiJQhKvPTKTf5QEmzxA+wiOrR+4ra53JuphXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNIQU5NVUdBTSwgU1JJ
TklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdWx5IDI2LCAyMDIzIDM6MjkgUE0NCj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxT
UklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IEZpeCBub24tc3RhbmRhcmQgZm9ybWF0IHNwZWNpZmllcnMgaW4NCj4gJ2FtZGdwdV9zaG93
X2ZkaW5mbycNCj4NCj4gRml4ZXMgdGhlIGZvbGxvd2luZzoNCj4NCj4gV0FSTklORzogJUx1IGlz
IG5vbi1zdGFuZGFyZCBDLCB1c2UgJWxsdQ0KPiArICAgICAgIHNlcV9wcmludGYobSwgImRybS1j
bGllbnQtaWQ6XHQlTHVcbiIsDQo+ICsgdm0tPmltbWVkaWF0ZS5mZW5jZV9jb250ZXh0KTsNCj4N
Cj4gV0FSTklORzogJUxkIGlzIG5vbi1zdGFuZGFyZCBDLCB1c2UgJWxsZA0KPiArICAgICAgICAg
ICAgICAgc2VxX3ByaW50ZihtLCAiZHJtLWVuZ2luZS0lczpcdCVMZCBuc1xuIiwNCj4gKyBhbWRn
cHVfaXBfbmFtZVtod19pcF0sDQo+DQo+IENjOiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1k
LmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZkaW5mby5j
IHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZkaW5mby5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZkaW5mby5j
DQo+IGluZGV4IGM1NzI1MmYwMDRlOC4uNWIyNTNlM2JlNTZiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmRpbmZvLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZkaW5mby5jDQo+IEBAIC05MCw3ICs5MCw3IEBAIHZv
aWQgYW1kZ3B1X3Nob3dfZmRpbmZvKHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0DQo+IGZpbGUg
KmYpDQo+ICAgICAgIHNlcV9wcmludGYobSwgInBhc2lkOlx0JXVcbiIsIGZwcml2LT52bS5wYXNp
ZCk7DQo+ICAgICAgIHNlcV9wcmludGYobSwgImRybS1kcml2ZXI6XHQlc1xuIiwgZmlsZS0+bWlu
b3ItPmRldi0+ZHJpdmVyLT5uYW1lKTsNCj4gICAgICAgc2VxX3ByaW50ZihtLCAiZHJtLXBkZXY6
XHQlMDR4OiUwMng6JTAyeC4lZFxuIiwgZG9tYWluLCBidXMsDQo+IGRldiwgZm4pOw0KPiAtICAg
ICBzZXFfcHJpbnRmKG0sICJkcm0tY2xpZW50LWlkOlx0JUx1XG4iLCB2bS0NCj4gPmltbWVkaWF0
ZS5mZW5jZV9jb250ZXh0KTsNCj4gKyAgICAgc2VxX3ByaW50ZihtLCAiZHJtLWNsaWVudC1pZDpc
dCVsbHVcbiIsIHZtLQ0KPiA+aW1tZWRpYXRlLmZlbmNlX2NvbnRleHQpOw0KPiAgICAgICBzZXFf
cHJpbnRmKG0sICJkcm0tbWVtb3J5LXZyYW06XHQlbGx1IEtpQlxuIiwgc3RhdHMudnJhbS8xMDI0
VUwpOw0KPiAgICAgICBzZXFfcHJpbnRmKG0sICJkcm0tbWVtb3J5LWd0dDogXHQlbGx1IEtpQlxu
Iiwgc3RhdHMuZ3R0LzEwMjRVTCk7DQo+ICAgICAgIHNlcV9wcmludGYobSwgImRybS1tZW1vcnkt
Y3B1OiBcdCVsbHUgS2lCXG4iLCBzdGF0cy5jcHUvMTAyNFVMKTsNCj4gQEAgLTExMSw3ICsxMTEs
NyBAQCB2b2lkIGFtZGdwdV9zaG93X2ZkaW5mbyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdA0K
PiBmaWxlICpmKQ0KPiAgICAgICAgICAgICAgIGlmICghdXNhZ2VbaHdfaXBdKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+DQo+IC0gICAgICAgICAgICAgc2VxX3ByaW50Ziht
LCAiZHJtLWVuZ2luZS0lczpcdCVMZCBuc1xuIiwNCj4gYW1kZ3B1X2lwX25hbWVbaHdfaXBdLA0K
PiArICAgICAgICAgICAgIHNlcV9wcmludGYobSwgImRybS1lbmdpbmUtJXM6XHQlbGxkIG5zXG4i
LA0KPiBhbWRncHVfaXBfbmFtZVtod19pcF0sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBr
dGltZV90b19ucyh1c2FnZVtod19pcF0pKTsNCj4gICAgICAgfQ0KPiAgfQ0KPiAtLQ0KPiAyLjI1
LjENCg0K
