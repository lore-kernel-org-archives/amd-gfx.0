Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505D9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 09:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8BB6EC9C;
	Thu,  2 Dec 2021 09:46:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CC46EC9C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 09:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsvLDx7o83vQObRTC0tcNM3tp9vydEh4ArCld5kDLwi+Tpv3P4Tzme4ApALJnDzBbfi0ITWSNJBCspuQP9pI4cEQhP09VQ/ww1ghqWpvTiItzFoq3x/CybgslqgMqrit+6P1sw9Cs6PdYiW1Jx9KSsbklLjhFSfVkc73RxeJtpfhgfIRccj3ynL1WmNBeNWHcC2YIkqy17+kxGDLwwjKs16Da7GIbrGGSGkieXWwNoB8yRldeJIIQPh58BshmLopBrYWi6gaB1aR7sHAUbCZHZGf+UPiQ7mynBysegXA5K4FbfEHHhN13f4Yp9jDMujm7RbEx0Pv2smEtfEkpLiijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ97XTcT2hsHscPfnpeRk+18u2soyvBbMBrYlHMGowo=;
 b=PrJ7LZj3l6Y5RrdAs9sG4yvBgVTAYaZgbAUpmLihKRiPpkVFrzVbAoQfHCssHDRGC9srHts7bTggyx3gQznBTYTFPufysJRTzMORGp71D8LPI5YDqB3I/7Y4AZuPbg7dMCtmFnrZ6oiIF+Z+4yOGpK8ibqwkUQO4xcndJu1hNsliB1u57oyZZb6WIeZ1yLFbB/hjjIf5jREO4PPscpAg1zUhOs/6YpgpWzPd0ldJSiaSX8zUxDq6kaNpLjp49pXDr99U299mx7r+06P9Hnulp3jj6IrGfcx3YAXaiBrZE/50O1WgjhfU6Hj9fOyzoSLwjDvy227yWSMmXieA1I8OBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ97XTcT2hsHscPfnpeRk+18u2soyvBbMBrYlHMGowo=;
 b=FZ/+tCH2yfsvkUUO3H30s/rSLEb64RVxzScvK+B635KlvCdOIhYeawp+v6BaAdtaXSKqfszd2+mCh9MkaJLrd6TkvBrNugEO199IbGdFl7yuIoLxlMIBnx8KZqMlKGCsjexNEa+JtcnmSVxaEa5vI8fBavyNAyie007/x1OC5aQ=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 09:31:38 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 09:31:38 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Topic: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Index: AQHX5pVcc3LghN55bkmOkF3w2Pkmd6wdXtgAgAATJuCAAALugIAABsDggAAEiwCAAAEbcIAAG3oAgAAvbYCAAO+NsA==
Date: Thu, 2 Dec 2021 09:31:38 +0000
Message-ID: <DM6PR12MB4250D9C0E076D01A68212790FB699@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
 <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
 <DM6PR12MB4250CB4C8DE2869BB8BD55D1FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0bf2d85f-d879-9402-a953-a637ece495d2@gmail.com>
 <e5572279-9c3c-f83b-e0ae-dce97592465d@amd.com>
In-Reply-To: <e5572279-9c3c-f83b-e0ae-dce97592465d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-02T09:31:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=315b7ec9-d685-49f6-85a9-06f99c4d8470;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-02T09:31:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 3cedb494-a32e-4872-a022-5170713724c7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2f37724-8764-43c9-285f-08d9b5768a99
x-ms-traffictypediagnostic: DM5PR1201MB0202:
x-microsoft-antispam-prvs: <DM5PR1201MB02023F3761641E46A4FC2CADFB699@DM5PR1201MB0202.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQxm23YUsEFOo/y7Uh1EUL/YCRQrIqNNQrFSuRgze+RZWXIqnBg8uQ+zkXW3I/dt069a/QXdHKZGgaziOGP30wNhF9jYYvCuK9gdRZVJ3s1t1BdgYDf+4XYMhoxx8TAwym2c/YJx0T8aRMqPV6rMgPobH/R9fh/h14345DNLIfvuwKjHWiEf5DjVi9Pv+g998t4lzj3HVkZOwoDNlCfjom0coglbOk/VoOPKri09qRwuUKF5WzQB2IBjA0UJnTQEEct3wqjN+2HjPNGiLfxoQpsd5PLOpNZQH1J1RvEJt6GgUSdlI9Iu1brZ6Mq7oYeoZY9hCWuKNe5U8TPP/XXE529A64j40hIyFAPUY6mguAg4Neo6KwIFB+sfxHvCQAPWQrs1fceAIQv7Hz8r6Tziy1TF/5kzFyCIwDQxHIVWehkStSq0AOb/kkZ2sUonmpVJ34JCQf5Vq+pfESQ4dMhgu6Plb8GPw+kNyj9p0I2NW4C4sxgUP4nBGqqSQjYmaZpZUaJTgTyMsU972tTTCcIw6+KJDbMmMyt8LOaPbv7mynTVMmPyRPAZ8UYFITDC/LA4+b/mD+q2qixsbieQlidpVjHF5FDgEvn8l1YfeQrVGIMyMZC23P4XjCIyQukWjLeOtqgQpZyLm5fAIbiTnbO+9ReGLkRbdvNYx982briUYbR9D36QxsSfGtTb71WsC58LW9EQAuIKtY0TpbPJq/p1ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(55016003)(9686003)(33656002)(26005)(8676002)(38100700002)(508600001)(122000001)(38070700005)(8936002)(6506007)(66946007)(86362001)(66556008)(66446008)(316002)(66476007)(64756008)(76116006)(71200400001)(7696005)(186003)(52536014)(110136005)(54906003)(4326008)(83380400001)(66574015)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlkrOWxWcmozQ2hIS3pSbm1uckNmaHVpaEVhRzMzeTI2QnBIVXNIN2FIOEZp?=
 =?utf-8?B?WHl5TGJpQTh1QTBWWEs1VXQzMmZ6a2puRUsySFdyMnV1TWhHS0hmV3VuWXRz?=
 =?utf-8?B?S25wYlowOG1rbXlRWEZiTitZdVpjVVllU1lESjZkZnZ1QXdkYzdaVHdyaUNG?=
 =?utf-8?B?OXRPL0pLYm9CZ1dFQ3NNb09seHRhWUJaaUNsRGR5ZkNNemxoc3UzSlc0VmVi?=
 =?utf-8?B?aEZJd0pjMnZiRkEwaVJ0V0w3R3ZuZ3l3MStyK1M4aWR5L1ZRSldYUitYYzBt?=
 =?utf-8?B?bFZlemFOanFZWjloQ0d0NlErOGNBNisyc211YWp1Q0ZrK04wd1JLcnhVS0ds?=
 =?utf-8?B?ZWpoTmZOSzA1MXJqdWF4SW1XUmszYm1lVS9aUnV5SEp5UGVlNWxvekdpL1N2?=
 =?utf-8?B?Z3MrbHBINWVDbmFrbFg3dFFDTFRMeGtxTGZqQTBaNmRIV3dDODNFaDM3RWk2?=
 =?utf-8?B?NW9jeEFaek9Xc3kvR1NydkJhdGIzTjltc2ZyMU1GRVJocG5vb2pnd3NpR3V5?=
 =?utf-8?B?K3hsN0gxbW1ob2h3Z3FNUjBGYjVsaUQ3U0RYeCtDVUZwcDl4YUJGdW1wWnUw?=
 =?utf-8?B?NU1tQm55VWdxVFlodDRJUitFNlZZbm42WUl0V0hTZ3VVTW5JNVBETnhXMlFU?=
 =?utf-8?B?QWdhKzRlcXFCL0pTZVlEMGplQ1llNkRWUEhaVk52eW5MM25BbTkxQjI0dU9O?=
 =?utf-8?B?WkRqR1hMU3RpdlRNclJuVlg0MjhlU1g3VDRyS1N5YllrajZRb2g0MzFBOWtC?=
 =?utf-8?B?d0RMVGYvNm0xOWtNRTA2MFNINTVQMWFMTC85T0EzTksvSDhDZS9TT3RTaTMx?=
 =?utf-8?B?VUpSZk53c2FPVTdDcjJyLytLd1EzZXA3M2phbmNqazd0a1IySy9CcmUvUDUz?=
 =?utf-8?B?eTAyTC9BR21nb2xRTGN0cVpnZjR1UVpIWDRrU1h1M1VaajJNMDFwT0puV1Vy?=
 =?utf-8?B?Ymk5Vk56eWlKaGZmRFR6eW8weHNLblBBMGhjWWREM294MGNjYzgrNzg3Q3Az?=
 =?utf-8?B?MmdwTVRDMGIwUWxtaXpCWFhDOTZHM21rM3VqVGRlT1IzaC9wYnJOUWhVZC9r?=
 =?utf-8?B?Q01mVktxd3BjMjVJQUM0djNtTVlwSG4yYXhGZzdYWWdwcGtKWnFwa3dzTHJp?=
 =?utf-8?B?YzVVN0NyeWFzMjB1MjNJWW54V0VzaTZpTjh6cnhnME9IZTFRN05SZ2hjVXJ1?=
 =?utf-8?B?RmZaYjVzUFNFdytUUlEyOUswNXVZRjZock5pSHBxSnV2eEVnOTQ3WWplc3dP?=
 =?utf-8?B?NGU0T2VnMTFrZlhsa1FwLzZ6b3l3Vmc1a2RzQjJMWTgycm84U3dmNm1XSXR6?=
 =?utf-8?B?V3R1TjQvZkp5TkxPK3NoWStXU0paeGl5VmhsZUJycG5WM1RGQjBGaU1Cc0hx?=
 =?utf-8?B?K1dDKzdMWVY0ZDNwbHF0anZsd2grNThKNklDLzU1OXpUY2U2aWUveEFua2ZB?=
 =?utf-8?B?YW9uVDV0UWNGRW1rN2tvVWgrdDdGdU5LNEZyUWdDRitHTUNnaVRrRThuS0V3?=
 =?utf-8?B?cXAxRU9YVVFDOVFjS2hJbExzQWZEbExoVmZvTWg3bXppOUFtOEU3ZDZGNzhz?=
 =?utf-8?B?Z1prcGtYWlVlcE5HNktwYXVMd3FxQXFNM1RnaVkwUDNuK0FrNHkxLzBsWk9L?=
 =?utf-8?B?OVJlMFJzbDczUTgwd05HVnZvOGdCcVdPNHVpOFZ2WnY5c21KKzI4Q2Z4d2Rz?=
 =?utf-8?B?NzVlUnorRFdEN2tiU09ydytSUFZZeUJzY251TncxaVJOTkZXNGJPRnU2T0R0?=
 =?utf-8?B?cVd3blhTS0h2MHZPTFovK1FaQWxoVG52dTVjc2NmWjV2K0NGYmxMVlI4anBS?=
 =?utf-8?B?MHFkOGlkdHNVMStEbUxzUzIzalk1WjF0Z1pIN3VsWUZKY0k0bDFPelRhRGpV?=
 =?utf-8?B?UXhaMDVtZ0FTdndnaGFvR0UyaEdnN0FvOU1RVUlXV1g5VC9wZ2V6empJWnU3?=
 =?utf-8?B?UE9iZkRhR0o2STJMWjV3MTQ5N29TU2hqWFk1K3J2cGJYUEpPQVBhSlEwVTdW?=
 =?utf-8?B?Y2JKdVUvNUw3eXVZMkM0aDlJMkRMRVRzUk9GN2tnZ0pFSCtLczBKc2ova3VB?=
 =?utf-8?B?Ylk1THE5Snp2dmhOWDFQT2RTekg2TC9QK1BkQTFiQmVlZlZwZjJhbTRlYk9j?=
 =?utf-8?B?b1lHc1dCS25kR09teHc0RndrUURqU0NCVXoyaC9jekhCK2xIb0IvVSs4QXlU?=
 =?utf-8?Q?OfJt58hgXYI5Uwu70YTUG3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f37724-8764-43c9-285f-08d9b5768a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 09:31:38.2919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoFgIfOW6FkDYIXzyOOMcGOVUUV1VYskOOlC8OzZW99j8VzFkhQZcV5UFXHAuAgm4GUyn/7zURXavQXFJaTQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4N
Cj5TZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMiwgMjAyMSAxMjowMSBBTQ0KPlRvOiBDaHJpc3Rp
YW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT47IFl1LCBMYW5nDQo+
PExhbmcuWXVAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBhbWQtDQo+Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMYXphciwgTGlqbw0KPjxMaWpv
LkxhemFyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgc3VwcG9ydCB0byBTTVUgZGVidWcgb3B0aW9u
DQo+DQo+DQo+T24gMjAyMS0xMi0wMSA4OjExIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
DQo+PiBBZGRpbmcgQW5kcmV5IGFzIHdlbGwuDQo+Pg0KPj4gQW0gMDEuMTIuMjEgdW0gMTI6Mzcg
c2NocmllYiBZdSwgTGFuZzoNCj4+PiBbU05JUF0NCj4+Pj4+Pj4+PiArIEJVR19PTih1bmxpa2Vs
eShzbXUtPnNtdV9kZWJ1Z19tb2RlKSAmJiByZXMpOw0KPj4+Pj4+Pj4gQlVHX09OKCkgcmVhbGx5
IGNyYXNoZXMgdGhlIGtlcm5lbCBhbmQgaXMgb25seSBhbGxvd2VkIGlmIHdlDQo+Pj4+Pj4+PiBw
cmV2ZW50IGZ1cnRoZXIgZGF0YSBjb3JydXB0aW9uIHdpdGggdGhhdC4NCj4+Pj4+Pj4+DQo+Pj4+
Pj4+PiBNb3N0IG9mIHRoZSB0aW1lIFdBUk5fT04oKSBpcyBtb3JlIGFwcHJvcHJpYXRlLCBidXQg
SSBjYW4ndA0KPj4+Pj4+Pj4gZnVsbHkganVkZ2UgaGVyZSBzaW5jZSBJIGRvbid0IGtub3cgdGhl
IFNNVSBjb2RlIHdlbGwgZW5vdWdoLg0KPj4+Pj4+PiBUaGlzIGlzIHdoYXQgU01VIEZXIGd1eXMg
d2FudC4gVGhleSB3YW50ICJ1c2VyLXZpc2libGUNCj4+Pj4+Pj4gKHBvdGVudGlhbGx5DQo+Pj4+
Pj4+IGZhdGFsKQ0KPj4+Pj4+IGVycm9ycyIsIHRoZW4gYSBoYW5nLg0KPj4+Pj4+PiBUaGV5IHdh
bnQgdG8ga2VlcCBzeXN0ZW0gc3RhdGUgc2luY2UgdGhlIGVycm9yIG9jY3VycmVkLg0KPj4+Pj4+
IFdlbGwgdGhhdCBpcyByYXRoZXIgcHJvYmxlbWF0aWMuDQo+Pj4+Pj4NCj4+Pj4+PiBGaXJzdCBv
ZiBhbGwgd2UgbmVlZCB0byByZWFsbHkganVzdGlmeSB0aGF0LCBjcmFzaGluZyB0aGUga2VybmVs
DQo+Pj4+Pj4gaXMgbm90IHNvbWV0aGluZyBlYXNpbHkgZG9uZS4NCj4+Pj4+Pg0KPj4+Pj4+IFRo
ZW4gdGhpcyBpc24ndCByZWFsbHkgZWZmZWN0aXZlIGhlcmUuIFdoYXQgaGFwcGVucyBpcyB0aGF0
IHlvdQ0KPj4+Pj4+IGNyYXNoIHRoZSBrZXJuZWwgdGhyZWFkIG9mIHRoZSBjdXJyZW50bHkgZXhl
Y3V0aW5nIHByb2Nlc3MsIGJ1dCBpdA0KPj4+Pj4+IGlzIHBlcmZlY3RseSBwb3NzaWJsZSB0aGF0
IGFub3RoZXIgdGhyZWFkIHN0aWxsIHRyaWVzIHRvIHNlbmQNCj4+Pj4+PiBtZXNzYWdlcyB0byB0
aGUgU01VLiBZb3UgbmVlZCB0byBoYXZlIHRoZSBCVUdfT04oKSBiZWZvcmUgZHJvcHBpbmcNCj4+
Pj4+PiB0aGUgbG9jayB0byBtYWtlIHN1cmUgdGhhdCB0aGlzIHJlYWxseSBnZXRzIHRoZSBkcml2
ZXIgc3R1Y2sgaW4NCj4+Pj4+PiB0aGUgY3VycmVudCBzdGF0ZS4NCj4+Pj4+IFRoYW5rcy4gSSBn
b3QgaXQuIEkganVzdCB0aG91Z2h0IGl0IGlzIGEga2VuZWwgcGFuaWMuDQo+Pj4+PiBDb3VsZCB3
ZSB1c2UgYSBwYW5pYygpIGhlcmU/DQo+Pj4+IFBvdGVudGlhbGx5LCBidXQgdGhhdCBtaWdodCBy
ZWJvb3QgdGhlIHN5c3RlbSBhdXRvbWF0aWNhbGx5IHdoaWNoIGlzDQo+Pj4+IHByb2JhYmx5IG5v
dCB3aGF0IHlvdSB3YW50IGVpdGhlci4NCj4+Pj4NCj4+Pj4gSG93IGRvZXMgdGhlIFNNVSBmaXJt
d2FyZSB0ZWFtIGdhdGhlciB0aGUgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIHdoZW4NCj4+Pj4gYSBw
cm9ibGVtIG9jY3Vycz8NCj4+PiBBcyBmYXIgYXMgSSBrbm93LCB0aGV5IHVzdWFsbHkgdXNlIGEg
SERUIHRvIGNvbGxlY3QgaW5mb3JtYXRpb24uDQo+Pj4gQW5kIHRoZXkgcmVxdWVzdCBhIGhhbmcg
d2hlbiBlcnJvciBvY2N1cnJlZCBpbiB0aWNrZXQuDQo+Pj4gIlN1Z2dlc3RlZCBlcnJvciByZXNw
b25zZXMgaW5jbHVkZSBwb3AtdXAgd2luZG93cyAoYnkgeDg2IGRyaXZlciwgaWYNCj4+PiB0aGlz
IGlzIHBvc3NpYmxlKSBvciBzaW1wbHkgaGFuZ2luZyBhZnRlciBsb2dnaW5nIHRoZSBlcnJvci4i
DQo+Pg0KPj4gSW4gdGhhdCBjYXNlIEkgc3VnZ2VzdCB0byBzZXQgdGhlICJkb24ndF90b3VjaF90
aGVfaGFyZHdhcmVfYW55X21vcmUiDQo+PiBwcm9jZWR1cmUgd2UgYWxzbyB1c2UgaW4gY2FzZSBv
ZiBQQ0llIGhvdHBsdWcuDQo+Pg0KPj4gQW5kcmV5IGhhcyB0aGUgZGV0YWlscyBidXQgZXNzZW50
aWFsbHkgaXQgc3RvcHMgdGhlIGRyaXZlciBmcm9tDQo+PiB0b3VjaGluZyB0aGUgaGFyZHdhcmUg
YW55IG1vcmUsIHNpZ25hbHMgYWxsIGZlbmNlcyBhbmQgdW5ibG9ja3MNCj4+IGV2ZXJ5dGhpbmcu
DQo+Pg0KPj4gSXQgc2hvdWxkIHRoZW4gYmUgdHJpdmlhbCB0byBpbnNwZWN0IHRoZSBoYXJkd2Fy
ZSBzdGF0ZSBhbmQgc2VlIHdoYXQncw0KPj4gZ29pbmcgb24sIGJ1dCB0aGUgc3lzdGVtIHdpbGwg
a2VlcCBzdGFibGUgYXQgbGVhc3QgZm9yIFNTSCBhY2Nlc3MuDQo+Pg0KPj4gTWlnaHQgYmUgYSBn
b29kIGlkZWEgdG8gaGF2ZSB0aGF0IG1vZGUgZm9yIG90aGVyIGZhdWx0IGNhc2VzIGxpa2UgcGFn
ZQ0KPj4gZmF1bHRzIGFuZCBoYXJkd2FyZSBjcmFzaGVzLg0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBD
aHJpc3RpYW4uDQo+DQo+DQo+VGhlcmUgaXMgbm8gb25lIHNwZWNpZmljIGZ1bmN0aW9uIHRoYXQg
ZG9lcyBhbGwgb2YgdGhhdCwgd2hhdCBJIHRoaW5rIGNhbiBiZSBkb25lIGlzDQo+dG8gYnJpbmcg
dGhlIGRldmljZSB0byBraW5kIG9mIGhhbHQgc3RhdGUgd2hlcmUgbm8gb25lIHRvdWNoZXMgaXQg
LSBhcyBmb2xsb3dpbmcgLQ0KPg0KPjEpIEZvbGxvdyBhbWRwZ3VfcGNpX3JlbW92ZSAtDQo+DQo+
IMKgwqDCoCBkcm1fZGV2X3VucGx1ZyB0byBtYWtlIGRldmljZSBpbmFjY2Vzc2libGUgdG8gdXNl
ciBzcGFjZSAoSU9DVExzDQo+ZS50LmMuKSBhbmQgY2xlYXJzIE1NSU8gbWFwcGluZ3MgdG8gZGV2
aWNlIGFuZCBkaXNhbGxvd3MgcmVtYXBwaW5ncyB0aHJvdWdoDQo+cGFnZSBmYXVsdHMNCj4NCj4g
wqDCoMKgIE5vIG5lZWQgdG8gY2FsbCBhbGwgb2YgYW1kZ3B1X2RyaXZlcl91bmxvYWRfa21zIGJ1
dCwgd2l0aGluIGl0IGNhbGwNCj5hbWRncHVfaXJxX2Rpc2FibGVfYWxsIGFuZCBhbWRncHVfZmVu
Y2VfZHJpdmVyX2h3X2ZpbmkgdG9pIGRpc2FibGUgaW50ZXJydXB0cw0KPmFuZCBmb3JjZSBzaWdu
YWxsIGFsbCBIVyBmZW5jZXMuDQo+DQo+IMKgwqDCoCBwY2lfZGlzYWJsZV9kZXZpY2UgYW5kIHBj
aV93YWl0X2Zvcl9wZW5kaW5nX3RyYW5zYWN0aW9uIHRvIGZsdXNoIGFueSBpbiBmbGlnaHQNCj5E
TUEgb3BlcmF0aW9ucyBmcm9tIGRldmljZQ0KPg0KPjIpIHNldCBhZGV2LT5ub19od19hY2Nlc3Mg
c28gdGhhdCBtb3N0IG9mIHBsYWNlcyB3ZSBhY2Nlc3MgSFcgKGFsbCBzdWJzZXF1ZW50DQo+cmVn
aXN0ZXJzIHJlYWRzL3dyaXRlcyBhbmQgU01VL1BTUCBtZXNzYWdlIHNlbmRpbmcgaXMgc2tpcHBl
ZCwgYnV0IHNvbWUgcmFjZQ0KPndpbGwgYmUgd2l0aCB0aG9zZSBhbHJlYWR5IGluIHByb2dyZXNz
IHNvIG1heWJlIGFkZGluZyBzb21lIHdhaXQpDQo+DQo+QW5kcmV5DQoNClRoYW5rcyBmb3IgQ2hy
aXN0aWFuJ3MgYWR2aWNlIGFuZCBBbmRyZXkncyBjbGFyaWZpY2F0aW9ucyBhYm91dCB0aGF0Lg0K
SXQgc2VlbXMgdGhhdCB3ZSBzaG91bGQgYWxzbyBoYW5kbGUga2ZkIHJlbGF0ZWQgc3R1ZmYuDQoN
ClJlZ2FyZHMsDQpMYW5nDQoNCj4NCj4NCj4+DQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IExhbmcN
Cj4+Pg0KPj4=
