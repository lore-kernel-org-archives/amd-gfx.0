Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC52861039
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC52861039
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1AB6EDE2;
	Fri, 24 Sep 2021 05:35:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0148C6EDE2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUEXxWU+csPQzOnPVYcR5hU+GMqJGMx8bKOuM122QuuIEZhD34qOrGawTNqQCG97rhEdbQB/FQEwL6Tzzo0uHSYmd961odOtlsASkkODzJkKb1vllb3LjrHC1+lknf2HXJztXP7KItSTvbHMUVK1phX7hTzekuIPCDUacUr7C1+n47WUoGaZ+0A26X2YPpOY/mQpomnw3b8rNqjVCA0UI5+OWbRr4KyXk6SNulJPid2aCTh3iKzOzlWb8/+ZRn11GdpFHXqScTxGAIOOYqeCk2NpYtV/F4o/S0nPBduHX33W+0BB0mthjrKixCAGCvcHUjbFBZUn4fb4u+bE0HS4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aIFPJ6x50SNDP5vUQEttAgod4NwhRdcCEES5kFfxf+Q=;
 b=bvqKy1geQ31ex4QVEjMyWUSNz3pR+g4ZXgx6kAWJK322ktop5X26Vpwh2LbTU+iaF14M8BZCT3TRHrEkuMg4fWhD7FEq2bzakzPk5lZOsrw7vBB/Nj7wm4eO3gPI0vHVXJh1YDyV1pbRfFIPmAQXkUYelyx0PRm3SxBd5r1DOWslUwqh7smT5DKnR+o4kopUIqIHIBNIAz501kKPW4cpc2Zcy/u71iuabL2xcb4b0XNY8cevWMZctJrKLpNCocNC+z3rkS/PVT2U/Fpm94kw6B6MwYzOGWdbNgkrILogUA+A+xS6D96MrICxG3IqRmFpJEMUNh57EzIh9ubK/vl6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIFPJ6x50SNDP5vUQEttAgod4NwhRdcCEES5kFfxf+Q=;
 b=i0CN1qL088i1Q6pt+AyDLFfaEO1m3yN+xckLqzKkBgMczgj3OhQzfD+nRDslNR6pp1rtJtpJPPQS2jj0NeCsinowdiQLlCaNr5wAgzvmn6IrB6wPktuBLtbSRHTHOLF7xn+1K4OmFZjzI6XXOXUkcKD7X7AbzFpOTZlfaOX0HiI=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Fri, 24 Sep 2021 05:35:54 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:35:54 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcCAAAcjgIAAFGOQgAAVHgCAAPVIwA==
Date: Fri, 24 Sep 2021 05:35:54 +0000
Message-ID: <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
In-Reply-To: <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T05:35:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dea6bced-d935-4c27-a81f-192339a13971;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d02ecf7-67fe-480d-abc1-08d97f1d2d7f
x-ms-traffictypediagnostic: DM6PR12MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4499CCEF672A4DE881672A88FBA49@DM6PR12MB4499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u12hA1O0WeZGipXAhPuDqYxzyl7EAbWLbK1GFme9O5MiSdYo904NQZDPSD/Kbx4vNAfcNZ6bey09zGDHALEbufKJU4a1wHgD8joz3HKuvQHDTs+PHs+ESh3zir6WcddNmdrxyzToMeMPBoarnC3KiDiLh1e4sVzZru8FQZrP+Is5UKzcr/xrNEIdEY/L+AhqUqglZt5Pqv+VleL7kKFkWYlRE4jzHYx/GjOA+clNRv2IDsiRpueOrCqO2t/UDE+3docig74cjdWw07LUU6GPcu3UTPXHN02O23PM58IraJHq4yt4ct0Zx5/Tw2Fvt6D6fUMhU+W5CaKQ9snlm9193aSf2DYIz8HoDcrPlhQKvT5NQUSK4TJM2O/ti29/KGDkTTXlNEhaeW7AxmNeE8l49RUkkkn4n5nFhfUVF7M4AhZuVO0FmaGwhO1E/AtHhd2gAiKDN/GynrS1Vc4SEo5vzWdGRkdnz38SVWQwQVGY8axs4Ve/JkGPz92TEmbQq/gthtAd0Vq2KtEU49JLduArR7qEKFq6DuLIhOeKyz21Yf9VycypN1Sif3eDr+ZExgec7q3gmNK1czSVmD+xCdb8AthTdcfvJwu0KRjHNU/4LlYu9ZRsze4XxainQlV8mJATdLeplw3I0mebn7m0vavuR0Es164zH3IND6vgXjXLilwXUa69BicTexh4wqcTJofOoYOGK7135bl50iad1EAfHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(2906002)(186003)(83380400001)(8936002)(316002)(76116006)(52536014)(33656002)(5660300002)(4326008)(6506007)(26005)(9686003)(53546011)(71200400001)(8676002)(86362001)(38070700005)(7696005)(66556008)(66476007)(122000001)(64756008)(110136005)(66446008)(508600001)(66946007)(38100700002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0VUMWJFQ2JvMnAvZGZONzVXcjQvdUE5WU1zRC94dG1iWlFVU3gyTDYydjgy?=
 =?utf-8?B?MUl4cWJqYmpQcmZXNFRlNkFvcVloRHI3aTlvSFExa0lKYXBZQTdVaGx3WWYy?=
 =?utf-8?B?QUhBOThGam5uZHBHV1BqemVtTG1Zb0ExV2R5Y3IyOEhqV3crRE5zQ21wdjEx?=
 =?utf-8?B?Sks1S0Zmd2UwbEZMREtvSlJnNHp0M2JVV0w2bzRlcDVKK3QyTjBabWluZDNB?=
 =?utf-8?B?T05nd3hJQ0N2aXh0YjA2UW1zU0dnUkVCWkJzQlZEdjMxRW8wV2lGeS9teUJ0?=
 =?utf-8?B?OTk2N1U5UkxIcVdZSXdOcFoyMXh0WVJPVDViS0k3Y001Q3NncEo3MWg0OXcw?=
 =?utf-8?B?NEdvSksrM1RKVGpnSjJmNlJQY3NMUTRycHUyQzh5N214QUwyT01qRDh4enFz?=
 =?utf-8?B?Mm94c2x3c3J0ZTU3Z2ROSFU2ZTBlUFZOU0x0UGplUzlRdzEycUJqRGErMWFX?=
 =?utf-8?B?RGg5eGhKQmJEYjJ4UW1HSXZSaXAxUkVRRm9CWHNNdzQrMmQ3YmpLcDF1bG9S?=
 =?utf-8?B?Q3JXYUQ5dVJjd2VOWjNoa3RLajBLdWZtNG5RWG5ZeHJPUUlQWTcvVDJyT0tS?=
 =?utf-8?B?Tm9rYTJUM0dkSFFGc3hlTG84U2JDalY0ZVBsRE0rcFZhRnFJMDhndVdsRldK?=
 =?utf-8?B?T2Y3RHpONHd3QzVFalI5RHdSckJpVEZWaUZ0d1dqMnZmc2cxSmRzdWI4WlNp?=
 =?utf-8?B?TmZma1FaTmE3NHRRT2pxVlVVaVBYYXJsS2FVbkhNUE1TaUl1dUlFSlUxYnVu?=
 =?utf-8?B?bVUwVTJWQUxlaVB2WFI2eUNrQlJEOHF0NFd4WVVnc2hkSkVYenRXeVZDdVg4?=
 =?utf-8?B?VkhrZHNMaHArQXdiMGVDaW9oa1NmTklCU1E5bm9lRVdCL2w4ZWR2Wjh2QTls?=
 =?utf-8?B?Q2RkYkRtMTg0dldXbi9hT0FwOURFMnNHYTh6My9hdy8rUmZCQXRDM2JVMVcx?=
 =?utf-8?B?YjBja2tPU0g3NUZ6QjRkaDZlOHlqV0dEQXRrZUkzdXFIVllxUXNsYWY0bUxo?=
 =?utf-8?B?NVM1YzFSUEZBd3hVOTdkZllnazU1VHZyVENTRnRaQy9OZTlGanFobjhWc2o1?=
 =?utf-8?B?cDZrR3lNVlZta1ZHKzFrWjdncUVqeFM5eGtVaHY0QWNta1pEUFRvb1FTNHhW?=
 =?utf-8?B?eW5nbEo3QkkrcmhuUXEzLytoOWpzZ3FpaVkzU0RLVlI3ZCtxcjgya1p2MEVt?=
 =?utf-8?B?a1F2M20zajdtSC9JcjZ0Vjh2cHVRR09lV29jSFl4MERnQ1RwSkJxc1pubWI1?=
 =?utf-8?B?S1hpd25qVTh4S1dzNE9zRzRlU2dZNENkcm5HZXg5YWs0WHlKbEV5NE84Zzdq?=
 =?utf-8?B?V0pBVjZKWFI1WVlZdzVsczRVSzk4Q0dwM05UWVFxSG9mRHRKVWxSa2lyUlY2?=
 =?utf-8?B?MmpMUCtUMVNlQTBzZ1Bya2plUjdhTkdiNHJnaXJLM05OSVRGanF0dWZZejdo?=
 =?utf-8?B?T0RPWVk2QkJiQmp6VGNaMEIrbjE0ekdVY25lNytnMEpXMEZiMnFsK0xjMkwv?=
 =?utf-8?B?ZFNuTVdUWDFjc1dPdHhMSjVWQklHK2FSM2FWR3FWZWJoRGpJZWJSRFh1RzEx?=
 =?utf-8?B?TWM0ZllYTnlnSkN2M2xpQlkvK1k3dWhGMWJxV0IwQU9BajZhQml2RTVuaUtq?=
 =?utf-8?B?VmllUjJkenpSNWQvbkhrQ0VqTTVxQS94RytvMk95V1MybWtzenc2MytSa1N6?=
 =?utf-8?B?Mm53NnI2RUxLZjZRZ1NRQ3I4SDBSaG8xOXEweFc1Rzc0eDk0U3ZVQnpYeWhp?=
 =?utf-8?Q?6KkQP4CvRYUdaCjaWB1pPhtPfzq4aCLMQGhWMW1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d02ecf7-67fe-480d-abc1-08d97f1d2d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 05:35:54.3139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQ6EFA/OQjtD9yEU5AibMpTYZuAl5HGYwX3V9nbTZDWr4ULije4j3dLl3UJtbNmMSAgkZsFuK4QBSyjPnd1Zsw==
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
LQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMywgMjAyMSAxMDo1MiBQTQ0KPlRvOiBZdSwgTGFu
ZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzog
S3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgSHVhbmcsIFJheQ0KPjxS
YXkuSHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0va2ZkOiBmaXggdHRt
X2JvX3JlbGVhc2Ugd2FybmluZw0KPg0KPkFtIDIzLjA5LjIxIHVtIDE2OjI0IHNjaHJpZWIgWXUs
IExhbmc6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIzLCAyMDIxIDg6MjQgUE0N
Cj4+PiBUbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+Pj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT47IENocmlzdGlhbiBLIG5pZw0KPj4+IDxDM0I2Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsg
SHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2tmZDogZml4IHR0bV9ib19yZWxlYXNlIHdhcm5pbmcNCj4+Pg0KPj4+IEFtIDIzLjA5LjIx
IHVtIDE0OjA5IHNjaHJpZWIgWXUsIExhbmc6DQo+Pj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHld
DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+
Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4+
Pj4+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjEgNzo0MCBQTQ0KPj4+Pj4gVG86
IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPj4+Pj4gQ2M6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IENo
cmlzdGlhbiBLIG5pZw0KPj4+Pj4gPEMzQjZjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+OyBIdWFu
ZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9rZmQ6IGZpeCB0dG1fYm9fcmVsZWFzZSB3YXJuaW5nDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+
Pj4+PiBBbSAyMy4wOS4yMSB1bSAxMTo0NCBzY2hyaWViIExhbmcgWXU6DQo+Pj4+Pj4gSWYgYSBC
TyBpcyBwaW5uZWQsIHVucGluIGl0IGJlZm9yZSBmcmVlaW5nIGl0Lg0KPj4+Pj4+DQo+Pj4+Pj4g
Q2FsbCBUcmFjZToNCj4+Pj4+PiAJdHRtX2JvX3B1dCsweDMwLzB4NTAgW3R0bV0NCj4+Pj4+PiAJ
YW1kZ3B1X2JvX3VucmVmKzB4MWUvMHgzMCBbYW1kZ3B1XQ0KPj4+Pj4+IAlhbWRncHVfZ2VtX29i
amVjdF9mcmVlKzB4MzQvMHg1MCBbYW1kZ3B1XQ0KPj4+Pj4+IAlkcm1fZ2VtX29iamVjdF9mcmVl
KzB4MWQvMHgzMCBbZHJtXQ0KPj4+Pj4+IAlhbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5
X29mX2dwdSsweDMxZi8weDNhMCBbYW1kZ3B1XQ0KPj4+Pj4+IAlrZmRfcHJvY2Vzc19kZXZpY2Vf
ZnJlZV9ib3MrMHhhMy8weGYwIFthbWRncHVdDQo+Pj4+Pj4gCWtmZF9wcm9jZXNzX3dxX3JlbGVh
c2UrMHgyMjQvMHgyZTAgW2FtZGdwdV0NCj4+Pj4+PiAJcHJvY2Vzc19vbmVfd29yaysweDIyMC8w
eDNjMA0KPj4+Pj4+IAl3b3JrZXJfdGhyZWFkKzB4NGQvMHgzZjANCj4+Pj4+PiAJa3RocmVhZCsw
eDExNC8weDE1MA0KPj4+Pj4+IAlwcm9jZXNzX29uZV93b3JrKzB4M2MwLzB4M2MwDQo+Pj4+Pj4g
CWt0aHJlYWRfcGFyaysweDkwLzB4OTANCj4+Pj4+PiAJcmV0X2Zyb21fZm9yaysweDIyLzB4MzAN
Cj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPGxhbmcueXVAYW1kLmNvbT4N
Cj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jIHwgMyArKysNCj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+Pj4+PiBpbmRleCAyZDZiMmQ3N2I3
MzguLjdlNjkzYjA2NDA3MiAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+Pj4+PiBAQCAtMTU2Nyw2ICsx
NTY3LDkgQEAgaW50DQo+Pj4gYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUo
DQo+Pj4+Pj4gICAgIAlwcl9kZWJ1ZygiUmVsZWFzZSBWQSAweCVsbHggLSAweCVsbHhcbiIsIG1l
bS0+dmEsDQo+Pj4+Pj4gICAgIAkJbWVtLT52YSArIGJvX3NpemUgKiAoMSArIG1lbS0+YXFsX3F1
ZXVlKSk7DQo+Pj4+Pj4NCj4+Pj4+PiArCWlmIChtZW0tPmJvLT50Ym8ucGluX2NvdW50KQ0KPj4+
Pj4+ICsJCWFtZGdwdV9ib191bnBpbihtZW0tPmJvKTsNCj4+Pj4+PiArDQo+Pj4+PiBOQUssIHVz
aW5nIG1lbS0+Ym8tPnRiby5waW5fY291bnQgbGlrZSB0aGlzIGlzIGlsbGVnYWwuDQo+Pj4+IEkg
ZGlkbid0ICBnZXQgeW91ciBwb2ludC4gSSByZWZlcnJlZCB0byBmdW5jdGlvbi0idm9pZA0KPj4+
PiBhbWRncHVfYm9fdW5waW4oc3RydWN0IGFtZGdwdV9ibyAqYm8pIiwgd2hpY2ggdXNlcyBpdCBs
aWtlIHRoaXMuDQo+Pj4gV2hhdCBhbWRncHVfYm9fdW5waW4oKSBkb2VzIGlzIHRoZSBmb2xsb3dp
bmc6DQo+Pj4NCj4+PiAgwqDCoMKgwqDCoMKgwqAgdHRtX2JvX3VucGluKCZiby0+dGJvKTsNCj4+
PiAgwqDCoMKgwqDCoMKgwqAgaWYgKGJvLT50Ym8ucGluX2NvdW50KQ0KPj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+IC4uLi4NCj4+Pg0KPj4+IEluIG90aGVy
IHdvcmRzIHdlIHRha2UgZnVydGhlciBhY3Rpb25zIGJhc2VkIG9uIGlmIHRoZSBidWZmZXIgdXMg
aXMNCj4+PiBzdGlsbCBwaW5uZWQgb3Igbm90IGFmdGVyIGFuIHVucGluIG9wZXJhdGlvbi4NCj4+
Pg0KPj4+IFdoYXQgeW91IHRyeSB0byBkbyBoZXJlIGlzIHVucGlubmluZyB0aGUgQk8gd2hlbiBp
dCBpcyBwaW5uZWQNCj4+PiBpbmRlcGVuZGVudCBpZiBzb21lYm9keSBlbHNlIG9yIG91ciBjb2Rl
IGhhcyBwaW5uZWQgaXQgYmVmb3JlLg0KPj4gSGkgQ2hyaXN0aWFuLA0KPj4NCj4+IFRoYW5rcyBm
b3IgeW91ciBleHBsYW5hdGlvbiBhbmQgYWR2aWNlLiBJIGdvdCB5b3VyIHBvaW50Lg0KPj4gQWN0
dWFsbHksIHRoZXNlIEJPcyBhcmUgYWxsb2NhdGVkIGFuZCBwaW5uZWQgZHVyaW5nIGEga2ZkIHBy
b2Nlc3MgbGlmZWN5Y2xlLg0KPj4gSSB3aWxsIHRyeSB0byBhZGQgYSBmbGFnIGludG8gc3RydWN0
IGtnZF9tZW0gdG8gaW5kaWNhdGUgd2hpY2ggQk8gaXMNCj4+IHBpbmVkIGFuZCBzaG91bGQgYmUg
dW5waW5uZWQuIFdoaWNoIHdpbGwgbWFrZQ0KPj4gYW1kZ3B1X2JvX3Bpbi9hbWRncHVfYm9fdW5w
aW4gY2FsbHMgYmFsYW5jZWQuIFRoYW5rcyENCj4NCj5UaGF0IGlzbid0IHRvIG11Y2ggYmV0dGVy
LiBUaGUgcmVhbCBzb2x1dGlvbiB3b3VsZCBiZSB0byB1bnBpbiB0aGVtIHdoZW4gdGhlIGtmZA0K
PnByb2Nlc3MgaXMgZGVzdHJveWVkLg0KDQpZZXMsIHdpbGwgdW5waW4gdGhlbSB3aGVuIHRoZSBr
ZmQgcHJvY2VzcyBpcyBkZXN0cm95ZWQuDQpCdXQgd2Ugc2hvdWxkIGluZGljYXRlIHdoaWNoIEJP
IGlzIHBpbm5lZCBhbmQgc2hvdWxkIGJlIHVucGlubmVkLiBSaWdodD8NCg0KUmVnYXJkcywNCkxh
bmcNCiANCj5SZWdhcmRzLA0KPkNocmlzdGlhbi4NCj4NCj4+DQo+PiBSZWdhcmRzLA0KPj4gTGFu
Zw0KPj4+IFRoYXQgY2FuIGxlYWQgdG8gYWxsIGtpbmQgb2YgcHJvYmxlbXMgYW5kIGlzIGNsZWFy
bHkgaWxsZWdhbC4NCj4+Pg0KPj4+Pj4gV2hlcmUgd2FzIHRoZSBCTyBwaW5uZWQgaW4gdGhlIGZp
cnN0IHBsYWNlPw0KPj4+PiBJIGZvdW5kIHR3byBwbGFjZXM6DQo+Pj4+DQo+Pj4+IAlyZXQgPSBr
ZmRfcHJvY2Vzc19hbGxvY19ncHV2bShwZGQsIHFwZC0+aWJfYmFzZSwgUEFHRV9TSVpFLCBmbGFn
cywNCj4+Pj4gCQkJCSAgICAgICZrYWRkcik7DQo+Pj4+DQo+Pj4+IAlyZXQgPSBrZmRfcHJvY2Vz
c19hbGxvY19ncHV2bShwZGQsIHFwZC0+Y3dzcl9iYXNlLA0KPj4+PiAJCQkJICAgICAgS0ZEX0NX
U1JfVEJBX1RNQV9TSVpFLCBmbGFncywgJmthZGRyKTsNCj4+PiBXZWxsIHRoZW4geW91IG5lZWQg
dG8gZmlndXJlIG91dCB3aGVyZSB0aGF0IG1lbW9yeSBpcyBmcmVlZCBhZ2FpbiBhbmQNCj4+PiBw
bGFjZSB0aGUgdW5waW4gYXBwcm9wcmlhdGVseS4NCj4+Pg0KPj4+IEdlbmVyYWwgcnVsZSBvZiB0
aHVtYiBpcyB0aGF0IGNhbGxzIHRvIGFtZGdwdV9ib19waW4vYW1kZ3B1X2JvX3VucGluDQo+Pj4g
c2hvdWxkIGJlIGJhbGFuY2VkLg0KPj4+DQo+Pj4gUmVnYXJkcywNCj4+PiBDaHJpc3RpYW4uDQo+
Pj4NCj4+Pj4gUmVnYXJkcywNCj4+Pj4gTGFuZw0KPj4+Pg0KPj4+Pj4gQ2hyaXN0aWFuLg0KPj4+
Pj4NCj4+Pj4+PiAgICAgCXJldCA9IHVucmVzZXJ2ZV9ib19hbmRfdm1zKCZjdHgsIGZhbHNlLCBm
YWxzZSk7DQo+Pj4+Pj4NCj4+Pj4+PiAgICAgCS8qIFJlbW92ZSBmcm9tIFZNIGludGVybmFsIGRh
dGEgc3RydWN0dXJlcyAqLw0K
