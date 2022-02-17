Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DECAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 04:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D3F10E996;
	Thu, 17 Feb 2022 04:58:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA77710E995
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 04:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg9VzvRpRolPLtYkuwdRbhLOgt77KO5oa5C7Z9Gj0ieJPqFoboDuvjjZo/RLM2RRW6SqoOqGRYnwjVkZDz32D1hCYb5x3mC/+lax06oa5q88vz5FZAyj0YlDQsE1MQt7mRjHW+ZboKGz3D++0UoN5+H+sEoW2OrLXCMgwN6tDs2SPcu/E0LarIfefRea2Le4DWz3uuX32Mm3G14cJq4gyi2LAwVLYihVhrs1y7eJ4Xc47Yw/qKOKanjBgBmUNvO0HWwBcRKedrpofRodcZppSLcnO9wB+Jm6s52ZaffYD065mkzENPhQ0I49I31Xg63v6HUCRShOVXbcw67zVNy8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K720Dfde8eNdla6YtQq81OJTg+BT6uss25dJWpCnnXU=;
 b=ETWV4CvDPwD8slR1v1flS83Nu4mQlFxqjJF/sRvwfw4r3D7NsLP6+r77c7x0QGKUtbsZdAcw/7a7GGoMzqNoOpiEmSQ9FDnBnxQRqc2PmlpolDAqShDro9SqSe3c6GQFyRQTqieHLa9MBEEfw8YJ6/pxE8bv8vikxiidEWFIIG4ax1S7dY3huRX/TwkFd9LrGdOZ2NrOorzKSktNA05hnMA6y4jmEfRo7+mXViQJjLKlD49Tul60nt9GVuXqOTrMSInB5KbZFdL89Z3aGxynsJ/8SWWuv9Ipg7UfDMU3IBebORzpkSAo7pxaRx79mAq20RTyrACmeQvPBna2Xn1Wkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K720Dfde8eNdla6YtQq81OJTg+BT6uss25dJWpCnnXU=;
 b=w30gpccyTtdSgugqUGKG719AD7s+3nrcEwUmo/IAaUR9w4YFlcMROWdeI5nN5N0vauIkmGg0GjN/U1LAj1iobwHP2Rb5L2oTurR9TK6waumWJzFB6CwiZzm0hT08JQtJHPpZo6agD9sNQJjlOd4iKz4o59GUSEqwA1yzqT2i6zI=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 04:58:48 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%4]) with mapi id 15.20.4995.014; Thu, 17 Feb 2022
 04:58:48 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Check if ASPM is enabled from PCIe subsystem
Thread-Topic: [PATCH] drm/amd: Check if ASPM is enabled from PCIe subsystem
Thread-Index: AQHYI7DfLeTMCHRif0WMlhKJ7xSOKqyXLIyAgAABIXA=
Date: Thu, 17 Feb 2022 04:58:48 +0000
Message-ID: <BL1PR12MB5157B914453FD1DCBAF5B5A3E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220217034608.14733-1-mario.limonciello@amd.com>
 <cec9eb28-a5ff-52e4-8753-5d8ef0a669b2@amd.com>
In-Reply-To: <cec9eb28-a5ff-52e4-8753-5d8ef0a669b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T04:58:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d2619e65-9edd-4b88-9c4a-d24abb897073;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-17T04:58:46Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6f331f67-0cfb-41c7-81b3-f275f2010fb7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0c6e7e2-1d17-4626-74b3-08d9f1d22ef0
x-ms-traffictypediagnostic: DM5PR1201MB0026:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB00269527A70EDF195D12889EE2369@DM5PR1201MB0026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caj8zp9R1fGy65wtgdKrNpXjgUqYWxOuoFTWsmupuxPNYA/aR7fJCH5mwfwuvl15ZcsEIh9NGu27Waw+cus2noHVuaXFz8/hpLxY53Ffa0gaPg5jnMxgXOXGqvi6gJfIHpeDIgkpTCguhSMEHDtgK91zqEtFxdlQSOJlkrH98AGlLHpBMrrATzoq82N/JlxzAjfQIv05T7BiVK3vI5KeNeoaMLwBjEamPS4jGDPl6jZqb5K5RC13fJ+a+L/+NSZBCqxr8GK/EthlXHB9JNtpyfSXuG4YJ0kjfl5D7INkA1ANG5tBVcJP+JRcJ0mZBEb4KAwzY85l1ufSlYtglIeLIsGqBdmU+uzJGtyUiNQo8rXAOW9jnYTyjGWASPYAFO6Aeeldma5J0uWRDV/tAAFmyVZAnp2mdxw9wyHDn64lMQUB630M+fV2jpgE7ieTY9jL+lG8NoSrJ0sD4apvTCLjkg9UA8WxbimEP30TZJ5HyBgAo2A/fL3ELYlszoDzOeHEnZ/X14mxDyjAw2Wtl9QdjPQLT7bUT6NfzhynBdiJRJ5E2vZIBCyrEUgbRNg1hCymNfGkHHy7sKmnwQuHEpWXVwogRK6W+QVO78m1huPWLQrv9Dvn8BTehwzHSBbOiPYjwV5uMTe5ERzbZKutZxOtPouhaG5BbF8bVZuzyONVZxQ7xMymTPcxLHhrHnAmKY9UAZY2XpEuPNyM7M5s2bL1/n/p+AyQWGsqWQM0tIxCSGhtDkFybd6hs1+y+/hbl4EveWcNCgnIOkV9xGjOC5Z/z2Xg6Bs6jzKC8PpYBV9SaDA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(8676002)(66446008)(66946007)(64756008)(26005)(186003)(66476007)(38070700005)(4326008)(122000001)(508600001)(966005)(86362001)(71200400001)(2906002)(110136005)(9686003)(5660300002)(8936002)(66556008)(316002)(33656002)(55016003)(76116006)(52536014)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3UxZ3IwSGhNS1N5dkpxc0g1Sm5YRGpvaFBmZkx1WnNJU0ppYnE1S3VYK0lV?=
 =?utf-8?B?Mk9JRkpsY1BudlpPK3ExeEdRb1g0UnVVbGVrSVRKMitPTGlGNk9sRzBvVmJU?=
 =?utf-8?B?Nmo2c2dSMml5YkJ3ZUU5SnU4THNrYVg1clVTQmNYRHRFamhEdC9JYitpR1NM?=
 =?utf-8?B?dWdCK1pMU05nejRNNGRVOUVsQ0FCR0sxeVRoMUNyM2YxdzFPaks1Y2ZoUkdG?=
 =?utf-8?B?SkpoUEprVVJTV1ZsQ1J2cGJBQ2FROXM1MmxNY2ZLczZwaHZPa1czV3AveW56?=
 =?utf-8?B?end5QUpjY2ZtdEhtUUhFZXA0bXBUWUZ5NW14cVVjQWE1VGhTbDhYQW44RDdU?=
 =?utf-8?B?STFMM3c2RU8vamdUemgyWlpsVkMwU3dYeE9FcUxuVk1xMTdhYmZQNG94dmow?=
 =?utf-8?B?elgvZnBLZGErMzU0VmxKOW5RaTlUcTFsVzNqTzd0QTZUOCtOWUFFK3pHNnZD?=
 =?utf-8?B?SitFbHJ3SWE0c21uZlFnTGlXOG9nS3Y1dXE3UzNMdmR2bGUzcE9TVDEyVUQ2?=
 =?utf-8?B?SnFYM2dDQjFvaUpuQTA2TmoxSGtDM2NzUGZpSElLVDdsZlI0dmZWRHRpRlp2?=
 =?utf-8?B?TUtLNGViRWF0Q0ZDZ3ZIVmxsaTY4U2tLR2N4TTByN0JFY0JLN1A0VkErOE52?=
 =?utf-8?B?dkZpekE1UUQrYXNmbG43UTNoS2N4YVRIc044ekJpdlk2QzV1a1l5TndMT1Vv?=
 =?utf-8?B?T0loOTFOci9LSGViWEE0UCtnOGRhNVhwVElubU0xUlhKL2tFZDByRzllMnVq?=
 =?utf-8?B?TDYxMzZlazVMNWJXTGUyMGI3Z015TmI5WHo4UDhyTVQ3S090ZVE1Yks0UmJP?=
 =?utf-8?B?OXJmdE85dGkxck82ZUgxcW5UdG5oT1Y1VEErY2NJOE1QMGltVWpOSXNYU2xF?=
 =?utf-8?B?SEJYQUh0YXEzeVFuM3JWVnVWNm8xOG1ZQ2J2eWRldkRJZ1g3V0RFYS8vOFRZ?=
 =?utf-8?B?VzF5cVpBT3JrQkh2eTBsMmRUVzhseE5oVWI0ZFFyZmJoWlFnMFVCYXRjdVll?=
 =?utf-8?B?YzJ2a2I4S0dIME8xQmZTM2gvT1E1Wm44REdJZU4wWEdmOUhaWmhaOEpGbnN0?=
 =?utf-8?B?UHplWkNOUXFxS2l3QXU2QTdFTzlySmNhY2RJcUhoQ0xiUWZua1Rjejl1bjFB?=
 =?utf-8?B?MXlFWDEyQmlJNlNKMUZVbk5WVENxVmxDeFpOKzR6MmJGOUwyaDhPcTNHZ0xK?=
 =?utf-8?B?YVFud3RyVGd3RkRhRnRZcGRibGVRa0pTaVRrV3RpVVRFcWs2WFhzS1hGVDVB?=
 =?utf-8?B?RVo5MmxPM0wzZzh3Qkt4OFRVMXk3WEo3MkJLenBxMXluQll1WWZDaHFMTFlQ?=
 =?utf-8?B?OGFqUDdNeFpYaGpjVjBoeDFPUkk0cFZNZ0dXeVQrR29pSGpyQmdwSXFIdEhj?=
 =?utf-8?B?RUIveElGNjg1N1draFN0RXNoU2R4RDdoRkFCM25WSUk5anNDcXBWYjlCcmV0?=
 =?utf-8?B?bEd2b1JnRGZCNU9qQmxWdTUxYXg5bUVqTEQvTWlEU0RxMkgwd3BSTlFGL2ZO?=
 =?utf-8?B?Z2JWQnArNlJwUHl4RTFLUmtGVjFEUmRnZmkvdnZhZzBGeWkxR05UTnAvVC9Q?=
 =?utf-8?B?VG5hdk9NM2xUcmRKSTA1LzFPSHNsZ3hoSUp5cm1xaDlQVkY2ZE5NRUN5K0Zs?=
 =?utf-8?B?aFBLNUFiandSMEpjZ0FTOEJIZlVJUUwveTlqZWFoZWIwUUd2SHFkcXNVYXBN?=
 =?utf-8?B?VzdhbDA5aGRmQUhwZk9TSUxreC9VKzVqMjg2S2pqR0FQRGJiREthdW5DTTdB?=
 =?utf-8?B?T3g0U0lxRkl4ajZGUVN1azlkVjIxRzdBUzhJRXpRV0lYeFRPYXF3MUdLWFBk?=
 =?utf-8?B?Q2VnSmtqTmIzRnA5dWE3Z2M3SFdoczVKS2dTaFMwc1QwaG9CR3JEVzVZdERW?=
 =?utf-8?B?T3hQeGNSNk9PcjRMUjNzMmg2ODVGQWd1MVZOQ3NTc3FMQTl4dzlqN2pSRGpj?=
 =?utf-8?B?SGJobTk3bnd4MmhKWXR5QmN4ejF6MjdHc1Y1c1hSVHVTbUlFekl0QnBieXE0?=
 =?utf-8?B?MnFWK1VnOWZSajJLYVFwdkZmOWVSeFFrQjNkRG42Zm9qc1g4ZFRZVU9IVzJQ?=
 =?utf-8?B?ZkZBanFrdEVXeml6VjJseW1uY09Vd3ZJMDZVRUFBUldUbTg0d01ycG1mMjNS?=
 =?utf-8?B?RDZoZmNuMDZUZStmNXRiYVhydmtiMThDMVB3TWtTRkxtNGZ2ZiszOGZpRThl?=
 =?utf-8?Q?erbS8LwsWQz+Q/DMbZW8RLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c6e7e2-1d17-4626-74b3-08d9f1d22ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 04:58:48.1791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72CFLQ6IZ+DwngtnBT/tpfG9dihvgOO3grKAQAD2WUBGHkUCwynwo2Cdg35BBu2UZsjC4Nf9oBBnfBH+09IxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: "koba.ko@canonical.com" <koba.ko@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiA+IGNvbW1pdCAwMDY0YjBjZTg1YmIgKCJkcm0v
YW1kL3BtOiBlbmFibGUgQVNQTSBieSBkZWZhdWx0IikgZW5hYmxlZA0KPiBBU1BNDQo+ID4gYnkg
ZGVmYXVsdCBidXQgYSB2YXJpZXR5IG9mIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb25zIGl0IHR1cm5z
IG91dCB0aGF0IHRoaXMNCj4gPiBjYXVzZWQgYSByZWdyZXNzaW9uLg0KPiA+DQo+ID4gKiBQUEM2
NExFIGhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgQVNQTSBhdCBhIGhhcmR3YXJlIGxldmVsLg0K
PiA+ICAgIENPTkZJR19QQ0lFQVNQTSBpcyBvZnRlbiBkaXNhYmxlZCBvbiB0aGVzZSBhcmNoaXRl
Y3R1cmVzLg0KPiA+ICogU29tZSBkR1BVcyBvbiBBTEQgcGxhdGZvcm1zIGRvbid0IHdvcmsgd2l0
aCBBU1BNIGVuYWJsZWQgYW5kIFBDSWUNCj4gPiAgICBzdWJzeXN0ZW0gZGlzYWJsZXMgaXQNCj4g
Pg0KPiA+IENoZWNrIHdpdGggdGhlIFBDSWUgc3Vic3lzdGVtIHRvIHNlZSB0aGF0IEFTUE0gaGFz
IGJlZW4gZW5hYmxlZA0KPiA+IG9yIG5vdC4NCj4gPg0KPiA+IEZpeGVzOiAwMDY0YjBjZTg1YmIg
KCJkcm0vYW1kL3BtOiBlbmFibGUgQVNQTSBieSBkZWZhdWx0IikNCj4gPiBMaW5rOg0KPiBodHRw
czovL3dpa2kucmFwdG9yY3MuY29tL3cvaW1hZ2VzL2EvYWQvUDlfUEhCX3ZlcnNpb24xLjBfMjdK
dWx5MjAxOF9wDQo+IHViLnBkZg0KPiA+IExpbms6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9kcm0vYW1kLy0vaXNzdWVzLzE3MjMNCj4gPiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xNzM5DQo+ID4gTGluazogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTg4NQ0KPiA+IExpbms6IGh0dHBz
Oi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzE5MDcNCj4gPiBUZXN0
ZWQtYnk6IGtvYmEua29AY2Fub25pY2FsLmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExp
bW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKysNCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCA1YWNkMDQ3M2VkMDEuLmQyNTQ4ZmFiNTFj
NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4g
PiBAQCAtMjAwOCw2ICsyMDA4LDkgQEAgc3RhdGljIGludCBhbWRncHVfcGNpX3Byb2JlKHN0cnVj
dCBwY2lfZGV2DQo+ICpwZGV2LA0KPiA+ICAgCQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gICAJfQ0K
PiA+DQo+ID4gKwlpZiAoYW1kZ3B1X2FzcG0gPT0gLTEgJiYgIXBjaWVfYXNwbV9lbmFibGVkKHBk
ZXYpKQ0KPiA+ICsJCWFtZGdwdV9hc3BtID0gMDsNCj4gPiArDQo+IA0KPiBEb2Vzbid0IHRoaXMg
ZGlzYWJsZSBhc3BtIGZvciBhbGwgZGV2aWNlcyBldmVuIHRob3VnaCBvbmx5IG9uZSBvZiB0aGUN
Cj4gYnJpZGdlcyBkb2Vzbid0IGhhdmUgc3VwcG9ydD8NCg0KQXQgbGVhc3Qgd2l0aCBob3cgaXQn
cyBhIGdsb2JhbCBwYXJhbWV0ZXIgdG9kYXkgSSBkb24ndCB0aGluayB3ZSBjYW4gZG8NCm11Y2gg
YmV0dGVyIHdpdGhvdXQgYSByZWZhY3Rvci4NCg0KQXMgaXQncyBhY3RpdmVseSBicmVha2luZyBw
ZW9wbGUgSSB0aGluayBJIHdvdWxkIHByZWZlciB0byBnZXQgdGhpcyBpbiBhcyBpdA0KaXMgbm93
ICh3aGljaCBjYW4gZ28gdG8gc3RhYmxlIHRyZWVzIHRvbyksIGFuZCB0aGVuIGRvIHRoZSByZWZh
Y3RvciBhcyBhDQpmb2xsb3cgdXAuDQoNCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAg
IAlpZiAoYW1kZ3B1X3ZpcnR1YWxfZGlzcGxheSB8fA0KPiA+ICAgCSAgICBhbWRncHVfZGV2aWNl
X2FzaWNfaGFzX2RjX3N1cHBvcnQoZmxhZ3MgJiBBTURfQVNJQ19NQVNLKSkNCj4gPiAgIAkJc3Vw
cG9ydHNfYXRvbWljID0gdHJ1ZTsNCj4gPg0K
