Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6B3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074906124B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 074906124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F6F6EDE1;
	Fri, 24 Sep 2021 05:35:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EACC6EDE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5y23Ux3mcWStEMa3a0YTuWH2SZBXWMhw3iHlM6sO+4N2lVTpERUESrdkj67Y+2jUyNdI8qeCOLRjy6hWrkfuD3DmIcciPTDHKZ7JjivYPSSlRqisIS2hkFnVfJa5XGJ0pCh+xnRanmbCfDFjiM1wuT8jHDZoI9apg91oQ5C/SqvChNoCtvyk/mlls1B6etXhPQCBSBvvXhsc8swqgJ3WLJAxOMQ7cUh4NAHrCVsuY4uPArOFna7BQOxJ851SH51Y/xrYVA869mF4otvuljrTy7qP1s8x7DMGEtQEFNtQKjDA6zMtOFUaX8Tl6KqA93qWSEjvljLbkOGfQDIwZA9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=la3hSzJScqGyYHeySvwe6VYRo1zE+buywBFY0xcuTtE=;
 b=b/V3i88Sm2RV5uwHplHEff5YAYlT/h5t9dpJu2KMpWy65SY0QIc42anzxDCcCDBM/7b6CacSycu9c9g2jXS5QcIvsqmxN+NFzPBO9oIEuGACLoHM2sBmVIsrI9pcpaZlEXaIlnDrHOGcl1YxUnIVvwGmO3+GzAXBrFpVm0FPxE2HoadC7aBL9F0daBh5ukk6jN9MW31dkoh4mAGMwxB3YrJ1eMINUPkQsC1jZhW10xMjOvhHpCszSRLXbaOGkNJq3jPyXOM2ebepexlKdpoLE7Cln6ePIVejprdnHrptuYmbV/QJbVflVyaF99SINCHHsv3R538Ys8LLjP6irwGPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la3hSzJScqGyYHeySvwe6VYRo1zE+buywBFY0xcuTtE=;
 b=REbvCijLSLXshDT5A1fpWuyCxKxAppoEiI5bntou//71sU2AptgrLWqNNDKIo1+c9AD997QWGXokW0WWJCqn2uettMXw7RZk+uvbJGQLKaIq71795/10wIU5Hx707XcZPufzKCTu+G2iZPF0AjqMN8p5CmuhdZBlfHdAXxT7HFk=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Fri, 24 Sep 2021 05:35:31 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:35:31 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcCAAEl9AIAA2vzg
Date: Fri, 24 Sep 2021 05:35:31 +0000
Message-ID: <DM6PR12MB42507A698C0E2EA590D003F7FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <aae7844f-8d15-b8be-86c0-463572a9d931@amd.com>
In-Reply-To: <aae7844f-8d15-b8be-86c0-463572a9d931@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T05:35:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8e6b6b9c-2e8b-4650-b5a5-3a25ea4919a2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 953ccc7f-6e56-42bf-f83a-08d97f1d2028
x-ms-traffictypediagnostic: DM6PR12MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44994DEABD8E8508A4A186A1FBA49@DM6PR12MB4499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxOoP/j/ou0eQ4q0uJn/pTlHDMNFN6r6xAkx+8PYpqmIAzWJx1cLy93T9ycs1oWKSSRp21fAfPwy/MpGGZ+cCZ2V9KOW1fm3L2bvQm2KjF3Uf8wi4oKFIwFCAwJWJeVks6IMfZ3qYoDfAdkcPHtKJqGjQ2/qnZypUYm75U7f6hbZWYf6Mi2Nt8vN3rOEAwWK1f/aCViF7DIv1UC1TeIzIspUZd6mSrHtvkLPuz+R9qweyTiob9REheh9aMUJvzlQntMni8OEVKIhqJ/YrLoc7J7xjInbm+MPeLhMl0wT9/oeG9rohOzYDMUoG4krWDSJ8TIZIxeL5OLeuCoNjg7M9ms0QHmBvvkt64A4WXkAaDNFULcejhVv5AZhwCVWikmtEXnUEw1lDRl1WPMUbFMxRWfWjrudIyDB4N6aLVEKVGjdl12lTWr8Q4HL28bkwsDVgJfBOexXGN/wFH+0lGQDObncn01tlWJiTIjrcT9lumHpmCI5KrVcrt6Q6jRKMpZnSSsQEnBmrooY1Bg6iJuoDHmcLtm9J34FvL0MJXPj5/Sc83AdkjJeWkqGcZQ+T4CfpOHFZlk9/auQbFlM/JreGu3f9Dn/Cj6Mp1aK6lJv1zA23moO1nxAVQVu2hMEh0GtRmpDHzkYAlWDdJZRqk+LgrlXfFS1H9SlsLWXWZjEFxUsng7DUkEaP3zlb7jcpV2A9rXYKSc0wre69w1MYkqlZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(2906002)(186003)(83380400001)(8936002)(316002)(76116006)(52536014)(33656002)(5660300002)(4326008)(6506007)(26005)(9686003)(53546011)(71200400001)(8676002)(86362001)(38070700005)(7696005)(66556008)(66476007)(122000001)(64756008)(110136005)(66446008)(508600001)(66946007)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnJVNW9STVpxVnhKTHZNV0Q2MGEvbTZZbkEzMmhzcUNaSjdnQmZkR1d1TEk3?=
 =?utf-8?B?MVJPb0RWSFZ4T0wxYmFIaDQzQ2FkTDFLSW5URkE2aVFjVGp3TGo1Q2N0elBH?=
 =?utf-8?B?ZUZZZkl3cTlCVWxBMmlaM25VdC9QR0F0Q2U5dkNFTGpCTStpTEVzdFJwQndJ?=
 =?utf-8?B?aHFreTU5emF3L2pmR3hGSVI3elF4eldoKzNVa3RKWUE1czE5MFNVenR5eWlY?=
 =?utf-8?B?VG5vVXRmZnpyY1g5RGZNMnVYckJQbVF3YmptRnhwZUZjTVZ3TWl4aStFMTRM?=
 =?utf-8?B?VTBIZ295dFlySlZ0MnJ6Sy9FMmpobU9FK3p4WUdLblc0N3BrR2piWVh4bVFD?=
 =?utf-8?B?RXVPZ0dwMlR6VFVrdlJQZGdtOGVIYVY3UjBIaWE2cGZTdjZtd0ozR1RyVGV3?=
 =?utf-8?B?dkV2RGk1L1ZYT0h1VVY0TTJzYnAwQWd3QUhVMnlhT1ZiaFJuNE9Qd0MzbmQ1?=
 =?utf-8?B?YzJBZE81MGJRK3hCa1BwVFJzc3BhSmtOQkMzMWV4MklpMHJTOHQyR05qMzkw?=
 =?utf-8?B?QWp0MVdIM2xYMlVYbG95aUo2Zk1UWkJ3NStNNGVudFR1N1J0YUxWZVRTZ0VP?=
 =?utf-8?B?aGxtb25rMWpzVHZwNTQ3TE5SY3V4Z3hKeWE3SlMzekhXbTFTV2d5dFdFQTVT?=
 =?utf-8?B?V3dIUmdGMFNVUTBFb0JwK1p6V0l5WmsrcDUzWmt1K0V2R0tSQmExT3BTUDVS?=
 =?utf-8?B?eWlnRDRpa0JSSDBXMk0wMGk0TmtyVC84QnpTS1BzNmRrbFFpUHVTeE1UYU5M?=
 =?utf-8?B?N3JEVGJaT01iY3R2WVZKdUhVWG5nR3AxQ0wrYm14bGNObWNzMjY0cDlvYUs5?=
 =?utf-8?B?SnpEdnZLdzlYbzJ6L1IzWlk5Y2MrZkxVLy9jU1RsUnVIRlJibGNqaGRSakpV?=
 =?utf-8?B?WjNzTldldUpkZ1dEUXJPUFA3ZWdESTI5UEVjc1N6SlRvZThPbW9YQjJiS1pm?=
 =?utf-8?B?K1VTVWVuUUgvZTVaa2d1anM4eUxxR2ZMaU50RXEvUXo0YmNSbnRBczNGeDYx?=
 =?utf-8?B?NTNsQit1dWxURkpDbFAwd3FzVEc3RitsRmJNWUlWK2VuTHk3dHZuUktoUGMw?=
 =?utf-8?B?TExuOFI4T3BSMVgwaWp2OEw4RGZ4eWhVaElWNW5acUZGKzZhTVFVREdXUDkw?=
 =?utf-8?B?WjBuSTdHZTlEWituQ1B4R2l0NFNjU1dka0QrcnVDWWNuZS8vK2dUbDRmczFN?=
 =?utf-8?B?ZUtXYkZCdXlrLyt2RjZuZ1ZZMXlNcUVRTEFQMFZ0YVpXcTNqU0hZTEZLQ0VF?=
 =?utf-8?B?UUZ3SlE0bW9BWnRLS0dPWkFIR25HUzJiY2JGSmxsQXBtVUluamdvSXhKR2d3?=
 =?utf-8?B?emtXcnQzUkFMejgwMFE0cWZSM0Y2eDlJN1hZMGxha2ppQm15VUo2ZEowWlNG?=
 =?utf-8?B?SGdXZGYyMGdtMEQ4Yi9ZUkJ1V01hakxWbnpBVFdzQldpZzVFWnlkb3JEdHUv?=
 =?utf-8?B?QUZSalV6SUVXSFdMd21GOS9aMHZsU2ZJN01OOEo5MER2c1kxMG1nb0xVNXBI?=
 =?utf-8?B?VllYTXFZQXl0WFVZSFNpd2ZkaDkzbVBVSkFZekpycUFoVVhRSVVHMCs4QnI3?=
 =?utf-8?B?RVYxQWsxSGlaMjJsOEVwZ1ZBR0hPTDUzNzlPdnRlMHVEZzFnSlZOUDJCa1I0?=
 =?utf-8?B?Z21aTzcvbFN6OUhmcjlTdVZTRlVndWxqNnBzbDNDSklUdTI4WVI3bTRMbjZy?=
 =?utf-8?B?SmVNMzVHVkJrUnFFS2ZhV3ZtN3RnZ0VyWmE4cHFjTGRQdDczKy9DdjVmV2ds?=
 =?utf-8?Q?DTW4Vd2nWxKOqMlXXsfhG1ll1YvFxa71XcnfjEa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953ccc7f-6e56-42bf-f83a-08d97f1d2028
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 05:35:31.8985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Jx70JOZZun7MmV5Z7z4H98URHRCHabg+EKcaa/eNlTb6jVRLcA61tpklxeVspjrGiiZo2qid8XIoWylK0OnHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TZW50
OiBGcmlkYXksIFNlcHRlbWJlciAyNCwgMjAyMSAxMjoyMSBBTQ0KPlRvOiBZdSwgTGFuZyA8TGFu
Zy5ZdUBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj48Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogSHVhbmcsIFJheSA8UmF5
Lkh1YW5nQGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2tmZDogZml4IHR0bV9i
b19yZWxlYXNlIHdhcm5pbmcNCj4NCj4NCj5PbiAyMDIxLTA5LTIzIDg6MDkgYS5tLiwgWXUsIExh
bmcgd3JvdGU6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4NCj4+DQo+Pg0KPj4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIz
LCAyMDIxIDc6NDAgUE0NCj4+PiBUbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT47IENocmlzdGlhbiBLIG5pZw0KPj4+IDxDM0I2Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+Pj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2tmZDogZml4IHR0bV9ib19yZWxlYXNlIHdhcm5pbmcNCj4+Pg0K
Pj4+DQo+Pj4NCj4+PiBBbSAyMy4wOS4yMSB1bSAxMTo0NCBzY2hyaWViIExhbmcgWXU6DQo+Pj4+
IElmIGEgQk8gaXMgcGlubmVkLCB1bnBpbiBpdCBiZWZvcmUgZnJlZWluZyBpdC4NCj4+Pj4NCj4+
Pj4gQ2FsbCBUcmFjZToNCj4+Pj4gCXR0bV9ib19wdXQrMHgzMC8weDUwIFt0dG1dDQo+Pj4+IAlh
bWRncHVfYm9fdW5yZWYrMHgxZS8weDMwIFthbWRncHVdDQo+Pj4+IAlhbWRncHVfZ2VtX29iamVj
dF9mcmVlKzB4MzQvMHg1MCBbYW1kZ3B1XQ0KPj4+PiAJZHJtX2dlbV9vYmplY3RfZnJlZSsweDFk
LzB4MzAgW2RybV0NCj4+Pj4gCWFtZGdwdV9hbWRrZmRfZ3B1dm1fZnJlZV9tZW1vcnlfb2ZfZ3B1
KzB4MzFmLzB4M2EwIFthbWRncHVdDQo+Pj4+IAlrZmRfcHJvY2Vzc19kZXZpY2VfZnJlZV9ib3Mr
MHhhMy8weGYwIFthbWRncHVdDQo+Pj4+IAlrZmRfcHJvY2Vzc193cV9yZWxlYXNlKzB4MjI0LzB4
MmUwIFthbWRncHVdDQo+Pj4+IAlwcm9jZXNzX29uZV93b3JrKzB4MjIwLzB4M2MwDQo+Pj4+IAl3
b3JrZXJfdGhyZWFkKzB4NGQvMHgzZjANCj4+Pj4gCWt0aHJlYWQrMHgxMTQvMHgxNTANCj4+Pj4g
CXByb2Nlc3Nfb25lX3dvcmsrMHgzYzAvMHgzYzANCj4+Pj4gCWt0aHJlYWRfcGFyaysweDkwLzB4
OTANCj4+Pj4gCXJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IExhbmcgWXUgPGxhbmcueXVAYW1kLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDMgKysrDQo+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+Pj4+IGlu
ZGV4IDJkNmIyZDc3YjczOC4uN2U2OTNiMDY0MDcyIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+Pj4+IEBAIC0x
NTY3LDYgKzE1NjcsOSBAQCBpbnQNCj5hbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29m
X2dwdSgNCj4+Pj4gICAgCXByX2RlYnVnKCJSZWxlYXNlIFZBIDB4JWxseCAtIDB4JWxseFxuIiwg
bWVtLT52YSwNCj4+Pj4gICAgCQltZW0tPnZhICsgYm9fc2l6ZSAqICgxICsgbWVtLT5hcWxfcXVl
dWUpKTsNCj4+Pj4NCj4+Pj4gKwlpZiAobWVtLT5iby0+dGJvLnBpbl9jb3VudCkNCj4+Pj4gKwkJ
YW1kZ3B1X2JvX3VucGluKG1lbS0+Ym8pOw0KPj4+PiArDQo+Pj4gTkFLLCB1c2luZyBtZW0tPmJv
LT50Ym8ucGluX2NvdW50IGxpa2UgdGhpcyBpcyBpbGxlZ2FsLg0KPj4gSSBkaWRuJ3QgIGdldCB5
b3VyIHBvaW50LiBJIHJlZmVycmVkIHRvIGZ1bmN0aW9uLSJ2b2lkDQo+PiBhbWRncHVfYm9fdW5w
aW4oc3RydWN0IGFtZGdwdV9ibyAqYm8pIiwgd2hpY2ggdXNlcyBpdCBsaWtlIHRoaXMuDQo+Pg0K
Pj4+IFdoZXJlIHdhcyB0aGUgQk8gcGlubmVkIGluIHRoZSBmaXJzdCBwbGFjZT8NCj4+IEkgZm91
bmQgdHdvIHBsYWNlczoNCj4+DQo+PiAJcmV0ID0ga2ZkX3Byb2Nlc3NfYWxsb2NfZ3B1dm0ocGRk
LCBxcGQtPmliX2Jhc2UsIFBBR0VfU0laRSwgZmxhZ3MsDQo+PiAJCQkJICAgICAgJmthZGRyKTsN
Cj4+DQo+PiAJcmV0ID0ga2ZkX3Byb2Nlc3NfYWxsb2NfZ3B1dm0ocGRkLCBxcGQtPmN3c3JfYmFz
ZSwNCj4+IAkJCQkgICAgICBLRkRfQ1dTUl9UQkFfVE1BX1NJWkUsIGZsYWdzLCAma2FkZHIpOw0K
Pg0KPlRoZXNlIHR3byBhbGxvY2F0aW9ucyBhcmUgY3JlYXRlZCBieSB0aGUga2VybmVsIG1vZGUg
ZHJpdmVyLiBUaGVyZSBpcyBhbm90aGVyDQo+Y2FzZSB3aGVyZSBhIHVzZXItYWxsb2NhdGVkIEJP
IGNhbiBnZXQgcGlubmVkIGJlY2F1c2Ugd2UgbmVlZCB0byBrbWFwIGl0IChpbg0KPmtmZF9pb2N0
bF9jcmVhdGVfZXZlbnQpLg0KPg0KPlJlZ2FyZHMsDQo+IMKgIEZlbGl4DQoNClllcywgdGhlc2Ug
Qk9zIHdpbGwgbm90IGJlIGZyZWVkIHVudGlsIGEga2ZkIHByb2Nlc3MgaXMgZGVzdHJveWVkLg0K
SSB3aWxsIG1ha2UgYSB2MiBwYXRjaCwgcGxlYXNlIGhlbHAgcmV2aWV3LiBUaGFua3MhDQoNClJl
Z2FyZHMsDQpMYW5nIA0KPg0KPj4gUmVnYXJkcywNCj4+IExhbmcNCj4+DQo+Pj4gQ2hyaXN0aWFu
Lg0KPj4+DQo+Pj4+ICAgIAlyZXQgPSB1bnJlc2VydmVfYm9fYW5kX3ZtcygmY3R4LCBmYWxzZSwg
ZmFsc2UpOw0KPj4+Pg0KPj4+PiAgICAJLyogUmVtb3ZlIGZyb20gVk0gaW50ZXJuYWwgZGF0YSBz
dHJ1Y3R1cmVzICov
