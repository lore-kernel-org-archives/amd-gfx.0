Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A93DE80AAD
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 14:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829B910E541;
	Wed, 27 Sep 2023 14:12:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74FE10E542
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 14:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAQf2qk6K/freWVy9K8R92PG6JmPaBCUMtduDKEkQPn/d6156yVupMYGXCJNtoQk6bre2QSAN1pYanyipL/5ge4G83HtQI3EGQ4DLjTrcaM3UEMNm2NMQjWEcs7px94gHSXTrKghaut889A238WwZwZstqz8BOCNRO2u5RqWu2ECZ/FfGHSaw54Xpu2/IVm1WUjPZGuBxZ+gAikur6qG+VMc77+A/qb00Kkzy140/TfPr5tFZvmOwC/EeqXwSrEtVhcSSc7ArN5+BZaBVMfaGW0yRI+IcYskApobuiZGAzlB4aJc+fG3DO7bLFv5ipuSqOOJr2hQ35Kf8/f3QTEvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkvcbz5HlD3AhQmeK83r0iWUzYLXt5zg+NTZbwmSt0g=;
 b=hIH/9l5LHMMLJlpn1tJoAzIz8OSGAebmVTaAw0dHdeA6cbC2l6Zyr/5xT2UL5PkENXicPOJ4GXHx5/sBB0wy0ogXmIfMt5FLLnmMAZyhaFHEL9c0zHWroBWhwcI2Ko09/j1pFJ4vIoJ9sRAUBrJiUiyxdPv1rQ9WgvBoympw1LiPKVPKx8vrA+B0KP4CHWJmREzPEeGUPXBh4d7YQMT6sFexXiBZ2se4TNr16DeecieCnCjtWrL3qgeokHinRqGB5ta57kkEf/nmsEGUv449D32FHmoidgZjTSZ9zQh7Zu5GM4XYqD8shO6M3CpIMuL3LEwRZfSyrN9E6AsaHvnh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkvcbz5HlD3AhQmeK83r0iWUzYLXt5zg+NTZbwmSt0g=;
 b=4DCnVTiEgzHsFvHDgakBZ01+/tJntCCv8gCelj2r5RaNMDPrwUzOb+PtOQw5Zr+2vWfv+keBQ7Cft/Ei6elL9fT7gGtDSi9kb0dq4VKfQjJp76IGRRTVTPwif36Ipp700F60mDYDea+s/PAwehw66BWjuyAOxDDEC0o2f9sxuTk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:12:34 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 14:12:34 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
Thread-Topic: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
Thread-Index: AQHZ7NRGx5yus7gvEUuy7fHvrI0fLrAtZJ6AgAFa52A=
Date: Wed, 27 Sep 2023 14:12:34 +0000
Message-ID: <PH7PR12MB5997A8E2D5B246DBD8896EEC82C2A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230921214019.926691-1-alexander.deucher@amd.com>
 <CADnq5_OSqC1MbV1MJr778CEJsLx5HyaVHDsGae7phReoKMCnuQ@mail.gmail.com>
In-Reply-To: <CADnq5_OSqC1MbV1MJr778CEJsLx5HyaVHDsGae7phReoKMCnuQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5d4625a6-61ef-40a7-8861-d2723e00c76d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-27T14:12:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7323:EE_
x-ms-office365-filtering-correlation-id: f45586a2-6d62-439d-b6d2-08dbbf63cbcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJaoQVotqFVXGgsmDKFYWtAN4YIVQ35Dbrri1gYnny5nrRHOpQrZSfWAtiMvseJaRLxJ2569pPQNXsLDgc9mP9ubYkg7ozT6EA6b9ISDSQtvxBjcQV/kTu2Pf5HSexAKg5KBKOVFyk6LSbDXuOjYrBqj4EgpGLtiR+9pPFYD3zIHlMv+mtH4k9YfisO8x9W3MIPrRxQBmwOljYRHpoCX2QtI7lU2bF6lOoJ2Xjxqsk/97NJDnU5VQyzZV8fLyKKFEmbtqkCEe5JR0ATUXFjpGDBB47oMZjCTsGv31WJ598f/+jU7dxahBiXFjeQUfoP4CgGw00OUL4j2ZbWzBy4TaxcdQUkGORut41TYsy+BNxihEvUtK62JMXwkVHJHtvzhGCnnxF4WPM42S3eyWj6YyClfrKgR4vHvPJGFByKlA2PXzEZoqy7DB+gKhEQMzy7j8wXgXawiSP9GncoXeengk9/qavh+QpH/D6AEXKYEjp9iMf7O9K9SVWC7LF+7k5Voqz0HNmcsdTm8btAAS6F0vSdS2Tvr4mUSZENp83kbSeW0NN0484ZYyCmz94G7WfXgzliFBooCeGYzDnUsMxebVqpwodetoaCCf9V/l1zKS5QXAsNk/sJMuxz97aMScREN2Y99csRLm6Wo0aCMMdPBfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(2906002)(110136005)(66556008)(66446008)(66476007)(5660300002)(76116006)(52536014)(478600001)(64756008)(71200400001)(53546011)(9686003)(66946007)(7696005)(6506007)(26005)(8936002)(6636002)(316002)(8676002)(4326008)(41300700001)(83380400001)(38100700002)(38070700005)(86362001)(122000001)(33656002)(55016003)(43043002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTFPaVUyV204SkMzaitVNGgyMk1iSm1nL2RsWGhhVW5welFzMFlsVjBENGxi?=
 =?utf-8?B?ZzlWTWZDTHZtbEwwdGhVd2ptVTlKUDRoN2UyNmNnc3A2UXZpNWxvWUQ4dVRE?=
 =?utf-8?B?bVFWS2NyRkpnNEdoWmd5Z2xNcnhva1JwMU5OclBxQk04Nm91Z2tCYmJ2bEE0?=
 =?utf-8?B?NXNkRWFlT0FrZnNhQ3d3YS80TUxmd1pnOFVQeFlqa3pYWmdjSkxKNWpOaFFY?=
 =?utf-8?B?aEp1aWRaWXQ4WWFDeFhUT3lUV2FXaEZEQy9sclIvZU54eFk3Zm9wNEs4MHBJ?=
 =?utf-8?B?YmNPZnErQktyM2Jrd2FoUWUyeWZWWkQ2UVFJbUhwUmdqdWxYejVMRnV3SndX?=
 =?utf-8?B?QTAzRDUrNkZCblZ6Z1N1ejlnOUltcWlYZEVLUTc4MW5oektldHJ4dkVsOHNz?=
 =?utf-8?B?dDFGbW03NVczNWhHS3MzQnZEaW1RQmFqS2hhVnFmaWpEU2xJZDlJYzBRa1dj?=
 =?utf-8?B?TGpWU3RUYklnL01LeWtsa245VEVTZmlSdzdZdVZGMGZvMDZmeStnYlBjb05B?=
 =?utf-8?B?NnBkY3Jrb3RpSW40MitBWnNhY2ZNOUpkMmErMm1RcWhzZm00aitBendvUnd2?=
 =?utf-8?B?U3lFK2JMNmNWdzFxMFNueHdzT2NkbGQ0eDl2R2Q0Zzd2cXBwTkxMcVlnZ2hx?=
 =?utf-8?B?elZpSzF3aHZueFNEcEo3M3dwTnpIUG1tRHhjZDRYbVY5V3M3VXA2eUdLbEU0?=
 =?utf-8?B?b25ISGNITTIxL1QxV3ZjTHZpTmRCdFFMZzY3NFp6Rzd3bm1sMDNHbjRmcUJ0?=
 =?utf-8?B?WkR4eXZaZklzanhCa1dhSzYvam13WW9nNHRoWkpxNzR1b0VhbkhuMGlONmVq?=
 =?utf-8?B?cDlkc3YxcmxtUkgycWcwNFRRc0JVOGJKRzBLWTBjK01wYVJvakNkeEtPQTM3?=
 =?utf-8?B?aFN1OER4RFpTV2QvUzJxeDZESzlUaFdvcjJyaTVuVlJUbW1UYUFQZSthN0p5?=
 =?utf-8?B?RTM3L2E1czZyeDRsb0RZMWxWSDBLT09zV2Y3dEFoMG5pUDJCOU9SUGM3c2tG?=
 =?utf-8?B?TElvUlJEb09Fa1hhb0NOU3VQTmRBcFpTOHJXT09FL1NuY3FiSjExVkRORE4y?=
 =?utf-8?B?RC9FZlBKVmJ0cWxJY3FGUXFvaDlYMVdtYkx6K2Z1bUduTVZlUHJXUCsxemFV?=
 =?utf-8?B?dEdJMlFzaEVMZTQxTmxlR3hjbldCNDZSRXVYa21vNjFlZjhEYWFOQVJXcTZJ?=
 =?utf-8?B?eHdza0J0WUdlTk9EM0Y0R0ptc3F2Z01JNE9rUk1HNVh4bCtaRGh0eGtsL2Nr?=
 =?utf-8?B?bFJzOGRBR1hPaXgvcUkyczc3WlhSMnJnZ2x5K1pXRkNsNU1SVm91MFJkbGNL?=
 =?utf-8?B?NW5oaCtBV0s3WHMvSVJDSXpUZ1pySGIrN2RzNzBhbWpsNXFpMFlXTThKOWtv?=
 =?utf-8?B?dTk3V0RsTHd1Z3JPRWF5VW5aOENnUXprYkZQN2dYWXpSZGUwVUM5cGhyMTR2?=
 =?utf-8?B?Rnhlb1pscnFxUUVnZE0rby8venArdGt1WTM3dENWUjNLQksyaEl4NzN5U0Na?=
 =?utf-8?B?Nk5sWGcvVkovZ3E0azM2ajFQNVJyWlVDTGV3ckhOdk5xT20zWllEMFYrc2Rv?=
 =?utf-8?B?dTZrd0hPN2t0Ym9EY3EyeUVzekpJMDRIMXdqV0pvemdlK1dkU25HYmprbTVj?=
 =?utf-8?B?ckZ6U09jUUZtVjAxWmFmcnVuZEhYY3RLRjg0TDJ5Z2x4dHh3bDExT09jYTE2?=
 =?utf-8?B?N1NnU2lNelR4Unh2aHlZOVFnUzRaaERRcXdZZ3p5Wk9ialQzNjJhR3dNZ0Fy?=
 =?utf-8?B?RDk2T0xTOHhKcVVmcm5QdmM4cWNkL1N3YVg4UEhxVTVOSm00dHlaaXBta3Y0?=
 =?utf-8?B?M2pWOVROakNFR1FrdzREOCtlV2xUWTNLRXVWMlY1aFppNHVLMVBObklEcG9H?=
 =?utf-8?B?K2VtYWo4aGxKMVhXSERrNnZXRTdSdlJIUGt6bEk1bnFzQmZPZUxhZG9aSndE?=
 =?utf-8?B?SWNJVkpZcWJ0VUF0bmR4SSsveFRVM0p2SmwrM0gxVlBUaUEyR29UbndMNW1E?=
 =?utf-8?B?dGhRMGlkVnFJWDFzbm5nd2lIdjluYVJXek1ZRFhJamlmSWt5bkVaWWZ6ekdU?=
 =?utf-8?B?dyt6MVNzaFJTNUplYktrRzU5Q0NQYm9vUHFmWlVSSDA3WFZmaHVBa3B2ekdv?=
 =?utf-8?Q?pXpE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45586a2-6d62-439d-b6d2-08dbbf63cbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 14:12:34.5113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnixIhC8gpQuZ2jfF0Oge8iu3sGNMM3fcmA/TF/xVhvjhpeM5PD2BwGjvpCv1wVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClNlcmllcyBpcw0KDQpSZXZpZXdl
ZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KDQpCZXN0IFJlZ2FyZHMs
DQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1
Y2hlcg0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjMgMTozMCBBTQ0KVG86IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRn
cHUvZ21jOiBhZGQgYSB3YXkgdG8gZm9yY2UgYSBwYXJ0aWN1bGFyIHBsYWNlbWVudCBmb3IgR0FS
VA0KDQpQaW5nIG9uIHRoaXMgc2VyaWVzPw0KDQpPbiBUaHUsIFNlcCAyMSwgMjAyMyBhdCA1OjQ2
4oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4N
Cj4gV2Ugbm9ybWFsbHkgcGxhY2UgR0FSVCBiYXNlZCBvbiB0aGUgbG9jYXRpb24gb2YgVlJBTSBh
bmQgdGhlIGF2YWlsYWJsZQ0KPiBhZGRyZXNzIHNwYWNlIGFyb3VuZCB0aGF0LCBidXQgcHJvdmlk
ZSBhbiBvcHRpb24gdG8gZm9yY2UgYSBwYXJ0aWN1bGFyDQo+IGxvY2F0aW9uIGZvciBoYXJkd2Fy
ZSB0aGF0IG5lZWRzIGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dtYy5jIHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KPiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAgOCArKysrKysrKw0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+IGluZGV4IGY3NGE1MWE5M2ViYi4uZDFkOTg0
ODgzNzNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+
IEBAIC0yODcsMTEgKzI4NywyMiBAQCB2b2lkIGFtZGdwdV9nbWNfZ2FydF9sb2NhdGlvbihzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9nbWMgKm1jKQ0KPiAgICAgICAg
ICAgICAgICAgbWMtPmdhcnRfc2l6ZSA9IG1heChzaXplX2JmLCBzaXplX2FmKTsNCj4gICAgICAg
ICB9DQo+DQo+IC0gICAgICAgaWYgKChzaXplX2JmID49IG1jLT5nYXJ0X3NpemUgJiYgc2l6ZV9i
ZiA8IHNpemVfYWYpIHx8DQo+IC0gICAgICAgICAgIChzaXplX2FmIDwgbWMtPmdhcnRfc2l6ZSkp
DQo+IC0gICAgICAgICAgICAgICBtYy0+Z2FydF9zdGFydCA9IDA7DQo+IC0gICAgICAgZWxzZQ0K
PiArICAgICAgIHN3aXRjaCAobWMtPmdhcnRfcGxhY2VtZW50KSB7DQo+ICsgICAgICAgY2FzZSBB
TURHUFVfR0FSVF9QTEFDRU1FTlRfSElHSDoNCj4gICAgICAgICAgICAgICAgIG1jLT5nYXJ0X3N0
YXJ0ID0gbWF4X21jX2FkZHJlc3MgLSBtYy0+Z2FydF9zaXplICsgMTsNCj4gKyAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiArICAgICAgIGNhc2UgQU1ER1BVX0dBUlRfUExBQ0VNRU5UX0xPVzoNCj4g
KyAgICAgICAgICAgICAgIG1jLT5nYXJ0X3N0YXJ0ID0gMDsNCj4gKyAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiArICAgICAgIGNhc2UgQU1ER1BVX0dBUlRfUExBQ0VNRU5UX0JFU1RfRklUOg0KPiAr
ICAgICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgICAgICAgICBpZiAoKHNpemVfYmYgPj0gbWMtPmdh
cnRfc2l6ZSAmJiBzaXplX2JmIDwgc2l6ZV9hZikgfHwNCj4gKyAgICAgICAgICAgICAgICAgICAo
c2l6ZV9hZiA8IG1jLT5nYXJ0X3NpemUpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBtYy0+
Z2FydF9zdGFydCA9IDA7DQo+ICsgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIG1jLT5nYXJ0X3N0YXJ0ID0gbWF4X21jX2FkZHJlc3MgLSBtYy0+Z2FydF9zaXpl
ICsgMTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIH0NCj4NCj4gICAgICAg
ICBtYy0+Z2FydF9zdGFydCAmPSB+KGZvdXJfZ2IgLSAxKTsNCj4gICAgICAgICBtYy0+Z2FydF9l
bmQgPSBtYy0+Z2FydF9zdGFydCArIG1jLT5nYXJ0X3NpemUgLSAxOyBkaWZmIC0tZ2l0DQo+IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+IGluZGV4IGRkMGVkZTc1ZTVkNy4uZmNlZjA1
N2I5MjEzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+
IEBAIC0xOTksNiArMTk5LDEyIEBAIHN0cnVjdCBhbWRncHVfbWVtX3BhcnRpdGlvbl9pbmZvIHsN
Cj4NCj4gICNkZWZpbmUgSU5WQUxJRF9QRk4gICAgLTENCj4NCj4gK2VudW0gYW1kZ3B1X2dhcnRf
cGxhY2VtZW50IHsNCj4gKyAgICAgICBBTURHUFVfR0FSVF9QTEFDRU1FTlRfQkVTVF9GSVQgPSAw
LA0KPiArICAgICAgIEFNREdQVV9HQVJUX1BMQUNFTUVOVF9ISUdILA0KPiArICAgICAgIEFNREdQ
VV9HQVJUX1BMQUNFTUVOVF9MT1csDQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgYW1kZ3B1X2dtYyB7
DQo+ICAgICAgICAgLyogRkIncyBwaHlzaWNhbCBhZGRyZXNzIGluIE1NSU8gc3BhY2UgKGZvciBD
UFUgdG8NCj4gICAgICAgICAgKiBtYXAgRkIpLiBUaGlzIGlzIGRpZmZlcmVudCBjb21wYXJlZCB0
byB0aGUgYWdwLyBAQCAtMzM5LDYNCj4gKzM0NSw4IEBAIHN0cnVjdCBhbWRncHVfZ21jIHsNCj4g
ICAgICAgICBib29sIGZsdXNoX3RsYl9uZWVkc19leHRyYV90eXBlXzA7DQo+ICAgICAgICAgYm9v
bCBmbHVzaF90bGJfbmVlZHNfZXh0cmFfdHlwZV8yOw0KPiAgICAgICAgIGJvb2wgZmx1c2hfcGFz
aWRfdXNlc19raXE7DQo+ICsNCj4gKyAgICAgICBlbnVtIGFtZGdwdV9nYXJ0X3BsYWNlbWVudCBn
YXJ0X3BsYWNlbWVudDsNCj4gIH07DQo+DQo+ICAjZGVmaW5lIGFtZGdwdV9nbWNfZW1pdF9mbHVz
aF9ncHVfdGxiKHIsIHZtaWQsIGFkZHIpDQo+IChyKS0+YWRldi0+Z21jLmdtY19mdW5jcy0+ZW1p
dF9mbHVzaF9ncHVfdGxiKChyKSwgKHZtaWQpLCAoYWRkcikpDQo+IC0tDQo+IDIuNDEuMA0KPg0K
