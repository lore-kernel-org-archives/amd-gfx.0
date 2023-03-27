Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1BAC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 18:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A0D10E0E1;
	Mon, 27 Mar 2023 18:49:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891A810E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 18:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFuDB+orSiP3qlj8i7J5G23lg09xxga8ChAi5jgbIsvC4+dluZ9olN+zuKFlDj9flEcP+sLkbyzCm5Faq7XTteB+ZNsxjY9ImpRV3ehcqYJEhFNP1+US1h6JXRY092Nc2eAYfS/FpdSqjko6H73T5cNWxf4aiocuFbyKhb7m1DkGnAOiE6E29/9ybwa9ra2UFhDGMIy0hjIj+isX2PXmRE/+syzq1WLcyVRpPKxl9HL5xEh82lnT9zaR9b9UVji/0N93QHwPsnjOHcOq655u2NkqSGK/TGuah8jrmCgdz3NCi9tSl6m/Z3HaWnMW/WAh29WL44wVDyfMz/QT+M0TYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyWio4Avg71XBREMCspM00UGuCTy5tTXjP5KE5uaIn4=;
 b=K7fM3IjTUbB1YlEifFokQbYzovEvPq6gHFAo0NgN7OC6KDdrEFL1STix5fDtvZg/EdZLtfgY4ZPM0BU0owDGaOa3knTmR4IWBLCJMHkpvAbYmbv7nIsauW2W4DBTcfVpeEgXK5qBCh8gerNNl95MyPbjOmRIoPFAK0HJqiAzhnjxUXG49pw0unxOkUOx1dmUTrShKn5AcV+QGXlbeN8Gy9LylNcov8e2TMf1VJ0VrkfSnhKRPhKevxaXQRKkPEahjqvrg1TKM+An5qvb+kiwLk9tPxdqKQAvZfqEtKCCzK4Z/c9BbBXQYQlk/k49tUvtJ0mB8RUUqlqvjgeydrSveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyWio4Avg71XBREMCspM00UGuCTy5tTXjP5KE5uaIn4=;
 b=QChpRhYxl9VYJ0w3Aox/9uja7FfEvbF8QwA9q1VfLBzFXy0HBPxAh6hjKNYkhBR67DwX+nTy160zPJqvfgrX3xzeHIWtJGODsX1Z/4aTx0asm67ELLE8AyqaISpYMnPXBAJXvNJtVoAjz1qU0L6q4IuaJ1/EqLoE7ks8v+DXtGU=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 18:49:23 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9365:edd0:6096:4ffc%6]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 18:49:23 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Remove initialisation of globals to 0 or
 NULL
Thread-Topic: [PATCH] drm/amd/amdgpu: Remove initialisation of globals to 0 or
 NULL
Thread-Index: AQHZYNeG3W0cE++OyEG1Nk6985hKr68O9eyAgAAB7rA=
Date: Mon, 27 Mar 2023 18:49:23 +0000
Message-ID: <MN2PR12MB4128EF61B70815883F56B16B908B9@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230327181040.1972784-1-srinivasan.shanmugam@amd.com>
 <CADnq5_PkQyPDk7xTEOTs7anXKZz+GKBkBn8N8hLukrPVuFLkTg@mail.gmail.com>
In-Reply-To: <CADnq5_PkQyPDk7xTEOTs7anXKZz+GKBkBn8N8hLukrPVuFLkTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-27T18:49:22Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f0f3c149-9738-43d2-8d18-35c09dcaa758;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|PH7PR12MB7018:EE_
x-ms-office365-filtering-correlation-id: aa7b4445-a910-4632-8758-08db2ef3fbb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YzCytxfwJrPhsMDQKFIANZ7vxr/4PpGFP9JeDOGQudgwpGpbMrHOh0kPc/ul9H5r4WafkH75QqNWLvu8Iojiu3kdaTM6J3YjvyJ2E2PQheysYPMdpiOrI2aDMLwUbCd8L+58bmg5hmasO09RjezRKzIf2IyUQHus7N3ApNkLOq30wIotgJS+Bg90g2cEhaeka/QCILOlVgfZxCsvAdPT7kpZL5SZ+zu2prGG3Y2fAWj2lRCPYDrjnIUBP4dDXJbi3XH3DyOmF6SoqNJ3GIRZdRtkwnU/iSAEn9fTUEFWVYQlKDEcrq+c3bjrQpT63/F8V6F/Z8/HZXkne1GzokBHmcUNXEJQmWZbucBTOZa1m/cTYPTLDjJpuxtbwpF+Ta+vvWNKoKmfQFbQ+eVEMG2eUkZFawn++HLhfLf60nFHt5Fg4H+4v/Lr5Z6OvcTKFLQRpoe/SZaDnjK09/oRl9BuQB2/8fybE755lF+kn8d2X7NXQ9CEHPd8Dh7PlZ6VyJiJAtKeG3014aqtxDMYP8Un/kw6NFul0i4DsNG58CEUoRK21w+iVW9M9udRkAXEMH8J5DKO6SvQ291/s7sA3GgX9pAZQMrRBpzW41UTlkGxDppcFnedJdAecGdXjEJQAAw/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(6916009)(4326008)(54906003)(66946007)(316002)(8936002)(122000001)(5660300002)(41300700001)(52536014)(26005)(186003)(6506007)(83380400001)(7696005)(66574015)(71200400001)(478600001)(53546011)(38100700002)(9686003)(55016003)(38070700005)(86362001)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDRJcXovQWtIS0YwZVZDeGJsZjVVaFBSWFpEUXJWKzgyRFhiL2ZHcGs0VE02?=
 =?utf-8?B?WkllN0Z4cXJZZzdwRU5PU082cVdaWDgzbzVsL2pJTGgxTDNQRzZ4cVdnb0My?=
 =?utf-8?B?U2xVZUs3cTlVcHF4VGkyTGNzVlZBQjkzVFBlVW1vUlJOUFVJMjBMOWo0TEtO?=
 =?utf-8?B?emthSXJUcmNleStPb0t4QWNjZGNLSjhCRlBGdm4xWGxub09DTUtCQjRHTWhi?=
 =?utf-8?B?UENSdGQ3Q3BkYmZKeVZwM1NKdG5ISkJneVg2ZThWWFBUb2lsWThCVkJoNW8y?=
 =?utf-8?B?ZVRTQ3pnT3FaRDFYbVJuU0VvOWVlODA0SWxnWHgxVVpJZ09wdWJLbzZUM0N2?=
 =?utf-8?B?S2o4TDJKZTJkMmRydUpabDU5eCsvV20rT3dsY1RYRXM1Zk5qbE5rOWRLNTJQ?=
 =?utf-8?B?QWluTGFoU3FhUHZqM2F3QkVZYjdYVktjeVdqWnB6L1BidHNuYnlzYmd0eXRU?=
 =?utf-8?B?RlN3d2tSQ3doZUExOXJRb1d3dDd0UXBqRE9pZWVVRDZtcnEwajRVMnl6dGJD?=
 =?utf-8?B?RnhvRVUrU3gzVEVweXRmWFc3dGJ2ZHVKdURHMVViYkh3WU1aMnBQendDcnZt?=
 =?utf-8?B?RHVFd1JjWmxxOWNDZVFpS1g2bG1lMEE0bnhQWGU1T3JlQzVBR2FpTkNlUVpz?=
 =?utf-8?B?VWxnVjJzV3c3UWxFbjhFc3BUNy81YTZFR0llcXNvcENudWNuQjVRV0psWEQx?=
 =?utf-8?B?QXBaSnBLVHpZY2NoV1loYlBadUQ4eDVmS1lUc2N6VlRNTzZCNEdTZTdnVGdx?=
 =?utf-8?B?QWdmYmxkUDFRUlBzRXRIdGZ4bDF6YWtFdlhURTM1Mno2SFB1WmhyNW01WDli?=
 =?utf-8?B?UnhnWmpGVjhDc240c2VxVzNBZ001Nnp3eTNZY1dGcTJuNzJjcmx6a0crMTNo?=
 =?utf-8?B?djNZNlFPM0pNWEozck9tKy9UYXE3cEQ4aS9NUmM0ZUxEakdBMDJHZU9nRDRN?=
 =?utf-8?B?VnFhckh6cnR3aWtmMVZETEJGTGN6NjFtdWNzQ0h6OTliendaZ3JoUHpwdTRE?=
 =?utf-8?B?T2JSc0dlckJSZDlYY0l6Q0p5Qzc1ZEE1RTlhcjhzSk5uQjMwam8zaU1aQk96?=
 =?utf-8?B?dXZYVUloMTF1clhFUnZiZ2hqT2xMay81dm9BbDhIT3FSOFhCd1NKUVRaUGJX?=
 =?utf-8?B?OWVyS09ydlRLMnhhSnEyd3VPVVFSMEMwbkRxaURGTHhhbTdpKzd2ejhDZWlK?=
 =?utf-8?B?b1BNZHF5eGtacGs0WmsrTUZPZ2Rld3FFbm5VaVdsTUZnYzYzcU1mMXJwS0hL?=
 =?utf-8?B?ZHN1YkRVVUlQZXJReXJDbEJNeGFDUUxadWJqbUp3aGNpVlMydjNCenNzWWYv?=
 =?utf-8?B?SXRCbkJkVHRvRlVqM3RycnJMWWhMbSsvN3FpV3VaQTl0ckd2ZWtTMmYvdDBQ?=
 =?utf-8?B?WEZKVnNIVWFLZzZRaXhENUxCTlN2MGdpcUZlRms2UGFUNXNoNHFTTzVIcVVl?=
 =?utf-8?B?UUpEZjlyUFNoRHBDYTRzcGNBd01FcjdmVnBVZ2JWWFphMjFPZmZkSE5JWkt1?=
 =?utf-8?B?WjZoanczenY0dDRVeEtEQXJyLy9oQ3FFYSswK3lKWXl5NjF1d2F5bW9wd2xT?=
 =?utf-8?B?M1BUK0srR0lpc2JzYVBZdGEvaWFDUDF0R2M1SVFURCtIQ1E3eVRZRERuOS94?=
 =?utf-8?B?bTdMZ2liQzBFUW5EeFZ0a1J5UXNyUjcxVTlMaDliby8zR0pVT0p0VmZkdUMv?=
 =?utf-8?B?YVU4MExJMHdEc0lBQUVrek5OUGZGRldRWGdrRGlJZDdWbDlBTnkyV0djWEc2?=
 =?utf-8?B?cWIyME1zNHc3RzRUVWRZdkE3UUcwbkRxNEUwcGxPcFo3MmdwZmZ6enBuNWZz?=
 =?utf-8?B?Y1cvd2h5M1FiSG9ZKzZRaERUK1RDYURpN1RkNFZWTnBVS25KUlgvQURibGF1?=
 =?utf-8?B?R0sxYlZtMzIzWEpVVlZJQXRGTjN6WitOak5TOHlaUW9QQ1BPekZLaGVoazhM?=
 =?utf-8?B?UVplazFhV2JBLy82M3MwZVdXM085MXVIaHppZ01hNGR6Ukg5TTU0Uk8vL1pW?=
 =?utf-8?B?Y1JSQ0xpVVZZa29oZmhTOEVoQytTZDk0NmpGckVjQXJxOFFhenVMS0IrL0kz?=
 =?utf-8?B?R29VcjdhUWxaOHRFNmtkR21OelFaaDhaYVp1bTZEQ05iMENqZkVvVWpXdG5L?=
 =?utf-8?Q?C4Uc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7b4445-a910-4632-8758-08db2ef3fbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 18:49:23.8020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+rrbiFPK6Vx0LTjp3Jd0uA/5Tb5LzgATHITrYkJyq889+aG3NN/oZ6TDYYNph3x2t+cFRG6YTbxpevszl4wIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCBBbGV4IGZv
ciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQpCZXN0IFJlZ2FyZHMsDQpTcmluaQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+IA0KU2VudDogVHVlc2RheSwgTWFyY2ggMjgsIDIwMjMgMTI6MTIgQU0NClRvOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpDYzogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT47IE1haGZvb3osIEhhbXphIDxIYW16YS5NYWhmb296QGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZC9hbWRncHU6IFJlbW92ZSBpbml0aWFsaXNhdGlvbiBvZiBnbG9iYWxzIHRvIDAg
b3IgTlVMTA0KDQpPbiBNb24sIE1hciAyNywgMjAyMyBhdCAyOjEx4oCvUE0gU3Jpbml2YXNhbiBT
aGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBHbG9i
YWwgdmFyaWFibGVzIGRvIG5vdCBuZWVkIHRvIGJlIGluaXRpYWxpemVkIHRvIDAgb3IgTlVMTCBh
bmQgDQo+IGNoZWNrcGF0Y2ggZmxhZ3MgdGhpcyBlcnJvciBpbiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmM6DQo+DQo+IEVSUk9SOiBkbyBub3QgaW5pdGlhbGlzZSBnbG9i
YWxzIHRvIE5VTEwNCj4gK2NoYXIgKmFtZGdwdV9kaXNhYmxlX2N1ID0gTlVMTDsNCj4gK2NoYXIg
KmFtZGdwdV92aXJ0dWFsX2Rpc3BsYXkgPSBOVUxMOw0KPg0KPiBGaXggdGhpcyBjaGVja3BhdGNo
IGVycm9yLg0KPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBD
YzogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBI
YW16YSBNYWhmb296IDxIYW16YS5NYWhmb296QGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNy
aW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KDQpSZXZp
ZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgNCArKy0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBpbmRleCA5MTc5MjZj
OGRjNWY1Li5lY2U4MDMzZGJhZDI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jDQo+IEBAIC0xNDksOCArMTQ5LDggQEAgdWludCBhbWRncHVfcGNpZV9sYW5l
X2NhcDsNCj4gIHU2NCBhbWRncHVfY2dfbWFzayA9IDB4ZmZmZmZmZmZmZmZmZmZmZjsgIHVpbnQg
YW1kZ3B1X3BnX21hc2sgPSANCj4gMHhmZmZmZmZmZjsgIHVpbnQgYW1kZ3B1X3NkbWFfcGhhc2Vf
cXVhbnR1bSA9IDMyOyAtY2hhciANCj4gKmFtZGdwdV9kaXNhYmxlX2N1ID0gTlVMTDsgLWNoYXIg
KmFtZGdwdV92aXJ0dWFsX2Rpc3BsYXkgPSBOVUxMOw0KPiArY2hhciAqYW1kZ3B1X2Rpc2FibGVf
Y3U7DQo+ICtjaGFyICphbWRncHVfdmlydHVhbF9kaXNwbGF5Ow0KPg0KPiAgLyoNCj4gICAqIE92
ZXJEcml2ZShiaXQgMTQpIGRpc2FibGVkIGJ5IGRlZmF1bHQNCj4gLS0NCj4gMi4yNS4xDQo+DQo=
