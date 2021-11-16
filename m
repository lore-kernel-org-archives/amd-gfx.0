Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31411C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 11:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36D3611C3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 11:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E36D3611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B6D6EE17;
	Tue, 16 Nov 2021 11:58:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8B16E9ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 11:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql7ZbVBcn/uxSVXA9+GpEp/G34H4Tp+9L0cwBkzQQXnlwD78UYI/6ww5D+0FmumeYnSt0qHYHM0khQDx57EnOY2MZB+AHaUrXRLisZyZHDB/S+OmvdhjEQSrD4MmALJMGTdFs8a4LtXuoFFfjqM0T0Z/6CtTQP70k0YuBKrOaF34A+Xk94quAWonN2edaLsOmMOLMUXlrSVSPf/U7o+FFJt9TImSRf9NH90a2Tg3uKuu0FdPBDwP+JsMWKV0XHGaJZp0IZ2rsXm66o41kBB4Hq8BnNq18/jyuolNdKf4SL0B8KBq1Ksn7nfONaOCVYC5ePemXeZLyzn7csXwHt7Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8x6731QCnddca8AZgglRIaIsAFFhObLfD+0msS7inc=;
 b=U9hkkG1R7LpJpUhaN8zECnnUYTipyQ3E1f2ksFF/VJMWBH5ciskFZQGddL6eqQavT22xlCGT13DcvThxGu8QVg4Yq90WYtcHyPq9/O8g+fL+2Z0RaO5xicVrSHHoBiDQ0o+ZMmJ5c9Xqu4lpww+F1MaR2TmUH8TcnX7um2aBhMORWabMUZQCOYqLyUOXf/pqG6SYB8eNPHpctfcRXDlHxGTxJrlfd6lGJoGfipL/TYEEhGDEol1soeMZ2W7qNToiblU6+HKVCp0RhfradzM1yH9JW6ac9RTC2GoRIeBm6J7hw+3DAJNzjViqxwhWY8xOjBnAplZsnKS59KapqoQO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8x6731QCnddca8AZgglRIaIsAFFhObLfD+0msS7inc=;
 b=3ZMcbQLE3HXFvHH5YTKsrqmXVs/ClVHVWs+O6/O4iM63tC6v8EWbPFYtCMUN+NJdFOPEJ4IM4+wUH/dt/Tm+ovQrV27sEu+cVrnNCiEVtDD4oS+uzuHW7dpUaEJLWNnXkpwLZ6Kf6mT9Wrmffk72TVZK2dhAntzGoHbhg7RkbDQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25; Tue, 16 Nov 2021 11:57:59 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 11:57:59 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Thread-Topic: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Thread-Index: AQHX2tTsph2/hA8PrkuFB7dh3foFYqwF9x0AgAAVHeA=
Date: Tue, 16 Nov 2021 11:57:58 +0000
Message-ID: <DM5PR12MB2469D69E927B853AF290E68BF1999@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211116102855.3775-1-tao.zhou1@amd.com>
 <952fb07c-6215-5485-6ac1-a00c1429ba3c@amd.com>
In-Reply-To: <952fb07c-6215-5485-6ac1-a00c1429ba3c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-16T11:57:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=34770c26-f468-4afc-b1d6-9a8afe627914;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12396715-a046-4541-3ca1-08d9a8f8559f
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-microsoft-antispam-prvs: <DM6PR12MB49597C43AA5AEA554568787FF1999@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XE+7rUYiIPRlQdQks80olih/v0Xmeyucy06R0J03c2lxPOHIV9OyO2z5JeLxexfNdAdqFKxPxA1D8Cv2ePdd1cFbxb4/JjEFfO/MhKbn3VzvJepaLVLGK6dsezzEEIZ9zyHGJ/sV2sdr5NxKJdgwCkqyJe5sQiTVggj80asF0jSdsUabJSX5BgoP6OCnZwAPpAmSOJRf6skTJGWLC6MkvrVMAKcx7T7jW13nD//d29l7o4x1oemhzsN1VUvFI7/S2XhVI5Ywn+x5kOgtuvwM6pHOtd+1QiOLDt5qmpJZ34ZTMC5f4PkTr6Faimn1NolwyMY6gxtFrnz7o8ZX4nhEDIBeqleaHRxfLa4Ti+U6VzKwjchvX7gADcRr67HmAnKXzZ7V6OwI0/JCqLspVa++ZRfzztH3zEmhbFNvHP9ezYlpgQluiJ0u7szAK+mKeIkAdFV1HB4TBfrrZvmI5Jm3M1QwJCSWQFwQztlNX3atjpF/NM2Zsdw1tsbuSvHLQoHGFJgHpcZGsXAXUMmquwBTmFEM99AxTUff5Rfetqr/lmFUPY6g7+MHNnybLfcMNII8gdLcZzndKKymz/3Z6o0uzMZlgP50XFuIe7BsfH5+TuR0D1lCCVXTh6QcPbonSO28n33BYIpOn7EXCO/9s0aqPQ68oMpmlEupPH+uzUb1+toFtIrErRBxR5jMudlHgrF1V5Gg7R+bW55Adg5hzD6cSEv/6ckcOSNFnZu22wU6xhA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(186003)(52536014)(9686003)(71200400001)(7696005)(76116006)(5660300002)(66946007)(6506007)(53546011)(6636002)(26005)(316002)(66446008)(8676002)(64756008)(110136005)(33656002)(66476007)(66556008)(122000001)(38100700002)(2906002)(921005)(38070700005)(8936002)(55016002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NTcENROC9DbldKSUlwZ1RhcVJQclhSQm9Cc0psd3lXZUprU0FCNkJNaVRZ?=
 =?utf-8?B?OWgrcmFVdHF1bVBMNWNjVE1JdnpxcEpkK2czc0NGMVhRVXZCem1ZZ1kzeVB1?=
 =?utf-8?B?L2N6ekJlNkQyV0p1REg4ZXpoTTBzSkJOSmxQOVpYZzNPS3FGWmpWUVBxQzIx?=
 =?utf-8?B?Q0lBaXNVSTNRTGZMMCtwbDRERkg3RERnVVV0SjAzUGh2T1gvN2FEeU9KTmlR?=
 =?utf-8?B?YkNQS1hTQXdTQ2JwdU1xTmsxU245UnE0cy8ydHU5RWlmcWttVE1Qbi85cHhW?=
 =?utf-8?B?SFVPU2tPMVRueHRqNnVidWM0UGNaNkJ4K2NpYTRVUytNV1o2dUVzaE83eFBx?=
 =?utf-8?B?K1ZUc29TWHFnWkcvM2lJRlpPN0pRMlE0QXg5R0VCVEhNWUdoZ2pnc2xITDlr?=
 =?utf-8?B?clJhalpreXl2b05zOVA4aXM0THlaNzdvLzVkZVRFYjI1UXVmMzY2b1lTanZ3?=
 =?utf-8?B?ZytJOEhLWGV3OTZENU5sOUR5bGtIZnN1S20yV2toQzFSUmFTUElBYkc5dzFv?=
 =?utf-8?B?R1lRWTFEcmpqVERlaWU1MWdTRXBhQjRQRk12bkZaTHhCR1ZjN0k0VUxCYnJr?=
 =?utf-8?B?WjdaanFGZmV2L2dxUU5jc1R0QW80eXlVT0hFb2RoMFFyN2FXT0V4UnlvZFU4?=
 =?utf-8?B?UGtkUjJQZWRHQmpydjRCYWE0Z2txQUh3TXZKaGYySkQ0aHkwZGRFdDk3ZDBD?=
 =?utf-8?B?U2t6ODRnSUpXL0I4R1R6aHozU1JpeUtjMk8xWmxSdzNpSWJqVGZPMEMyQUth?=
 =?utf-8?B?bEVnR1V6eTIyakRuczVmL1R3WjM4TmtPS3hJSXdlTGRBU0l5WG9hWkxickgx?=
 =?utf-8?B?aTAxSVUwYVZ1ZFluU2ROWjZIZnZ6NnpadWVQOVlSVmJ1MUFmNHV3d2Iva1ZN?=
 =?utf-8?B?U28xUHl0bWZjODJSL1ZPc2JDRWhWMmNpQUZOYWVvQS90clFaV3pjMHZ2VUdK?=
 =?utf-8?B?VHh5YVdWb2QzTFFqSWFJTWsxOGZDRUZCazcrNHlyMngvVmhHemJYMjV5MTJT?=
 =?utf-8?B?S015aUo4R3lxK3NEZHhXY0RuTDFvSzZVVWxLNi9DRmd5V3hrUHBwRDFOUk5V?=
 =?utf-8?B?R0tQUDBteURTaVI5R095SE00bkZIK0thY3JFN1BZUjJ5d1dnSExwRGpjd1V4?=
 =?utf-8?B?c0RkdnVlZEJ2cVh5eTE5UnUzTURuVTh2QmJ4ZHdXWDR6OHJ4RjJGb1JaaWRC?=
 =?utf-8?B?MTh0eDVVNG52UXhhaFRReU0raUJNeUN3ODdXNlVHWElDOG9kTFh2WjI5UHBD?=
 =?utf-8?B?ak1DWDJKLzlIYllFVTBZSjVNTDFza1RVWjVDK2plam0wdk5YSzB0eStSMmlD?=
 =?utf-8?B?czZyMmV0VGRkLzBwN3NiZStlRjB1YTdobnBxL3d4NEZFZjRjM3BMQXpsWEY1?=
 =?utf-8?B?bG1RNmNFRWtLQ2RBTFIwWEV6aG9zeUswNDh6dmlVallJRzAyT3JkU0Q3Vm0z?=
 =?utf-8?B?cWRoWmhvbWJXbTVpd2lvY0I5SHR2Ykh6WEMrd285bk9QZTQxZU42b3JNZGJy?=
 =?utf-8?B?Y2lkOGg1WE9jZDJ0Rkc5aW5zaGN0ckhlUnJDOUJuR0taWnRNNCtoZUFkQ1pC?=
 =?utf-8?B?dTdIUlFKL2ErRWtaT1ZQU290N3hHcUxRNU0yM2t3dVVtV3V2UUozd2xPQUhF?=
 =?utf-8?B?VlNwK0t6a0YweitIZHZFcnZGTWowUVdaSkw2RGt2U0JoYTFYUmREcFpYUitz?=
 =?utf-8?B?M281Sk5SazFDSnlTeGNJdU5SL0wrSjRtNFNKNHRaRVRMZlhiUFkvaE15N1J3?=
 =?utf-8?B?S3o2bjBMM25NbldSZlNqOTFLNGE5c3lscTNSMmh0bEZMQm9nL3grTnlXQ3g5?=
 =?utf-8?B?QjBqVUZMSU9McjBGM3RJanlkd0NQdXFoY3I2THRFbE1EN0NJMXplZUt0STc5?=
 =?utf-8?B?Q3NRbkUwVGpTRXAyRng5UmxUOHYxT3pyR0NXdHFHUnY4aEFVaXV4NDBjUE9L?=
 =?utf-8?B?Tll0TmV2cWpJS005RThPRWppRzR6SzRxbmlZa25MR1NaZlBvN3ZKZVRZb3k2?=
 =?utf-8?B?aHdNUzZLZGlEVU9OMDI0ekQvaFNYN2pWbS9wN2dMRlluT2VsaEE5QS9qckxB?=
 =?utf-8?B?UThib3lvdTZUdXNPMmpPZTA1dWtQdi9MYUJHaDhaUGpnMWlRd3cwN3RFbFhE?=
 =?utf-8?B?MittanovczJXV2dhK05vc1U4S0t6N2JST1IyeTRUVVFvaWFINnBVS3VBckN4?=
 =?utf-8?Q?yT0YwgwzpO6bzVxqml7cF4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12396715-a046-4541-3ca1-08d9a8f8559f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 11:57:58.5434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOl//O7x+Ayx0BPqqaeA5QD6GUHG5yLAeUdBcofAKUDUNPUnY5kr1C3OLYPPeT9Sexry8QZpmCcz1oq/+i+aow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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

W1B1YmxpY10NCg0KQSBjb2Rpbmcgc3R5bGUgcHJvYmxlbS4NCg0KQSB7fSBpcyBuZWVkZWQgZm9y
IHRoZSBwYXRoIGFmdGVyIGlmIChzbXVfdmVyc2lvbiA8IDB4MDA0NDA3MDApLg0KDQppZiAoc211
X3ZlcnNpb24gPCAweDAwNDQwNzAwKQ0KPiArCQlyZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZyhz
bXUsIFNNVV9NU0dfTW9kZTFSZXNldCwgTlVMTCk7DQo+ICsJZWxzZSB7DQo+ICsJCS8qIGZhdGFs
IGVycm9yIHRyaWdnZXJlZCBieSByYXMsIFBNRlcgc3VwcG9ydHMgdGhlIGZsYWcNCj4gKwkJICAg
ZnJvbSA2OC40NC4wICovDQo+ICsJCWlmICgoc211X3ZlcnNpb24gPj0gMHgwMDQ0MmMwMCkgJiYg
cmFzICYmDQo+ICsJCSAgICBhdG9taWNfcmVhZCgmcmFzLT5pbl9yZWNvdmVyeSkpDQo+ICsJCQlm
YXRhbF9lcnIgPSAxOw0KPiArDQo+ICsJCXBhcmFtIHw9IChmYXRhbF9lcnIgPDwgMTYpOw0KPiAr
CQlyZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gKwkJCQkJU01V
X01TR19HZnhEZXZpY2VEcml2ZXJSZXNldCwgcGFyYW0sIE5VTEwpOw0KPiArCX0NCg0KUmVnYXJk
cywNCkd1Y2h1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIExhemFy
LCBMaWpvDQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNiwgMjAyMSA2OjQxIFBNDQpUbzogWmhv
dTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IENsZW1lbnRzLCBKb2hu
IDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1k
LmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikg
PEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBzdXBwb3J0IG5ldyBtb2RlLTEgcmVzZXQgaW50ZXJmYWNlICh2MikNCg0KDQoNCk9uIDExLzE2
LzIwMjEgMzo1OCBQTSwgVGFvIFpob3Ugd3JvdGU6DQo+IElmIGdwdSByZXNldCBpcyB0cmlnZ2Vy
ZWQgYnkgcmFzIGZhdGFsIGVycm9yLCB0ZWxsIGl0IHRvIHNtdSBpbiBtb2RlLTEgDQo+IHJlc2V0
IG1lc3NhZ2UuDQo+IA0KPiB2MjogbW92ZSBtb2RlLTEgcmVzZXQgZnVuY3Rpb24gdG8gYWxkZWJh
cmFuX3BwdC5jIHNpbmNlIGl0J3MgYWxkZWJhcmFuIA0KPiBzcGVjaWZpYyBjdXJyZW50bHkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQoNClJldmll
d2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQoNClRoYW5rcywNCkxpam8N
Cg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaCAgICAg
ICAgfCAgMyArLQ0KPiAgIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQu
YyAgICB8IDM2ICsrKysrKysrKysrKysrKysrKy0NCj4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvc211X3YxM18wLmMgICAgfCAyMSAtLS0tLS0tLS0tLQ0KPiAgIDMgZmlsZXMgY2hh
bmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3YxM18wLmggDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9pbmMvc211X3YxM18wLmgNCj4gaW5kZXggZTVkM2IwZDFhMDMyLi5iYmM2
MDhjOTkwYjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92
MTNfMC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL3NtdV92MTNfMC5oDQo+
IEBAIC0yOSw2ICsyOSw4IEBADQo+ICAgI2RlZmluZSBTTVUxM19EUklWRVJfSUZfVkVSU0lPTl9Z
RUxMT1dfQ0FSUCAweDA0DQo+ICAgI2RlZmluZSBTTVUxM19EUklWRVJfSUZfVkVSU0lPTl9BTERF
IDB4MDcNCj4gICANCj4gKyNkZWZpbmUgU01VMTNfTU9ERTFfUkVTRVRfV0FJVF9USU1FX0lOX01T
IDUwMCAgLy81MDBtcw0KPiArDQo+ICAgLyogTVAgQXBlcnR1cmVzICovDQo+ICAgI2RlZmluZSBN
UDBfUHVibGljCQkJMHgwMzgwMDAwMA0KPiAgICNkZWZpbmUgTVAwX1NSQU0JCQkweDAzOTAwMDAw
DQo+IEBAIC0yMTYsNyArMjE4LDYgQEAgaW50IHNtdV92MTNfMF9iYWNvX3NldF9zdGF0ZShzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBzbXVfYmFjb19zdGF0ZSBzdGF0ZSkNCj4gICBpbnQg
c211X3YxM18wX2JhY29fZW50ZXIoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KPiAgIGludCBz
bXVfdjEzXzBfYmFjb19leGl0KHN0cnVjdCBzbXVfY29udGV4dCAqc211KTsNCj4gICANCj4gLWlu
dCBzbXVfdjEzXzBfbW9kZTFfcmVzZXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KPiAgIGlu
dCBzbXVfdjEzXzBfbW9kZTJfcmVzZXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KPiAgIA0K
PiAgIGludCBzbXVfdjEzXzBfZ2V0X2RwbV91bHRpbWF0ZV9mcmVxKHN0cnVjdCBzbXVfY29udGV4
dCAqc211LCBlbnVtIA0KPiBzbXVfY2xrX3R5cGUgY2xrX3R5cGUsIGRpZmYgLS1naXQgDQo+IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMgDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4gaW5k
ZXggNTlhN2QyNzY1NDFkLi5lNTBkNDQ5MWFhOTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+IEBAIC0xNzY1LDYg
KzE3NjUsNDAgQEAgc3RhdGljIHNzaXplX3QgYWxkZWJhcmFuX2dldF9ncHVfbWV0cmljcyhzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAJcmV0dXJuIHNpemVvZihzdHJ1Y3QgZ3B1X21ldHJp
Y3NfdjFfMyk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGludCBhbGRlYmFyYW5fbW9kZTFfcmVz
ZXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpIHsNCj4gKwl1MzIgc211X3ZlcnNpb24sIGZhdGFs
X2VyciwgcGFyYW07DQo+ICsJaW50IHJldCA9IDA7DQo+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSBzbXUtPmFkZXY7DQo+ICsJc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9y
YXNfZ2V0X2NvbnRleHQoYWRldik7DQo+ICsNCj4gKwlmYXRhbF9lcnIgPSAwOw0KPiArCXBhcmFt
ID0gU01VX1JFU0VUX01PREVfMTsNCj4gKw0KPiArCS8qDQo+ICsJKiBQTSBGVyBzdXBwb3J0IFNN
VV9NU0dfR2Z4RGV2aWNlRHJpdmVyUmVzZXQgZnJvbSA2OC4wNw0KPiArCSovDQo+ICsJc211X2Nt
bl9nZXRfc21jX3ZlcnNpb24oc211LCBOVUxMLCAmc211X3ZlcnNpb24pOw0KPiArCWlmIChzbXVf
dmVyc2lvbiA8IDB4MDA0NDA3MDApDQo+ICsJCXJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnKHNt
dSwgU01VX01TR19Nb2RlMVJlc2V0LCBOVUxMKTsNCj4gKwllbHNlIHsNCj4gKwkJLyogZmF0YWwg
ZXJyb3IgdHJpZ2dlcmVkIGJ5IHJhcywgUE1GVyBzdXBwb3J0cyB0aGUgZmxhZw0KPiArCQkgICBm
cm9tIDY4LjQ0LjAgKi8NCj4gKwkJaWYgKChzbXVfdmVyc2lvbiA+PSAweDAwNDQyYzAwKSAmJiBy
YXMgJiYNCj4gKwkJICAgIGF0b21pY19yZWFkKCZyYXMtPmluX3JlY292ZXJ5KSkNCj4gKwkJCWZh
dGFsX2VyciA9IDE7DQo+ICsNCj4gKwkJcGFyYW0gfD0gKGZhdGFsX2VyciA8PCAxNik7DQo+ICsJ
CXJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211LA0KPiArCQkJCQlTTVVf
TVNHX0dmeERldmljZURyaXZlclJlc2V0LCBwYXJhbSwgTlVMTCk7DQo+ICsJfQ0KPiArDQo+ICsJ
aWYgKCFyZXQpDQo+ICsJCW1zbGVlcChTTVUxM19NT0RFMV9SRVNFVF9XQUlUX1RJTUVfSU5fTVMp
Ow0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgYWxkZWJh
cmFuX21vZGUyX3Jlc2V0KHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KPiAgIHsNCj4gICAJdTMy
IHNtdV92ZXJzaW9uOw0KPiBAQCAtMTkyNSw3ICsxOTU5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBwcHRhYmxlX2Z1bmNzIGFsZGViYXJhbl9wcHRfZnVuY3MgPSB7DQo+ICAgCS5nZXRfZ3B1X21l
dHJpY3MgPSBhbGRlYmFyYW5fZ2V0X2dwdV9tZXRyaWNzLA0KPiAgIAkubW9kZTFfcmVzZXRfaXNf
c3VwcG9ydCA9IGFsZGViYXJhbl9pc19tb2RlMV9yZXNldF9zdXBwb3J0ZWQsDQo+ICAgCS5tb2Rl
Ml9yZXNldF9pc19zdXBwb3J0ID0gYWxkZWJhcmFuX2lzX21vZGUyX3Jlc2V0X3N1cHBvcnRlZCwN
Cj4gLQkubW9kZTFfcmVzZXQgPSBzbXVfdjEzXzBfbW9kZTFfcmVzZXQsDQo+ICsJLm1vZGUxX3Jl
c2V0ID0gYWxkZWJhcmFuX21vZGUxX3Jlc2V0LA0KPiAgIAkuc2V0X21wMV9zdGF0ZSA9IGFsZGVi
YXJhbl9zZXRfbXAxX3N0YXRlLA0KPiAgIAkubW9kZTJfcmVzZXQgPSBhbGRlYmFyYW5fbW9kZTJf
cmVzZXQsDQo+ICAgCS53YWl0X2Zvcl9ldmVudCA9IHNtdV92MTNfMF93YWl0X2Zvcl9ldmVudCwg
ZGlmZiAtLWdpdCANCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92
MTNfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18w
LmMNCj4gaW5kZXggMzUxNDVkYjZlZWRmLi40ZDk2MDk5YTliYjEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYw0KPiBAQCAtNjAsOCAr
NjAsNiBAQCBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9hbGRlYmFyYW5fc21jLmJpbiIpOw0KPiAg
IA0KPiAgICNkZWZpbmUgU01VMTNfVk9MVEFHRV9TQ0FMRSA0DQo+ICAgDQo+IC0jZGVmaW5lIFNN
VTEzX01PREUxX1JFU0VUX1dBSVRfVElNRV9JTl9NUyA1MDAgIC8vNTAwbXMNCj4gLQ0KPiAgICNk
ZWZpbmUgTElOS19XSURUSF9NQVgJCQkJNg0KPiAgICNkZWZpbmUgTElOS19TUEVFRF9NQVgJCQkJ
Mw0KPiAgIA0KPiBAQCAtMTQyNCwyNSArMTQyMiw2IEBAIGludCBzbXVfdjEzXzBfc2V0X2F6YWxp
YV9kM19wbWUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ICAgCXJldHVybiByZXQ7DQo+ICAg
fQ0KPiAgIA0KPiAtaW50IHNtdV92MTNfMF9tb2RlMV9yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSkgLXsNCj4gLQl1MzIgc211X3ZlcnNpb247DQo+IC0JaW50IHJldCA9IDA7DQo+IC0JLyoN
Cj4gLQkqIFBNIEZXIHN1cHBvcnQgU01VX01TR19HZnhEZXZpY2VEcml2ZXJSZXNldCBmcm9tIDY4
LjA3DQo+IC0JKi8NCj4gLQlzbXVfY21uX2dldF9zbWNfdmVyc2lvbihzbXUsIE5VTEwsICZzbXVf
dmVyc2lvbik7DQo+IC0JaWYgKHNtdV92ZXJzaW9uIDwgMHgwMDQ0MDcwMCkNCj4gLQkJcmV0ID0g
c211X2Ntbl9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX01vZGUxUmVzZXQsIE5VTEwpOw0KPiAt
CWVsc2UNCj4gLQkJcmV0ID0gc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNN
VV9NU0dfR2Z4RGV2aWNlRHJpdmVyUmVzZXQsIFNNVV9SRVNFVF9NT0RFXzEsIE5VTEwpOw0KPiAt
DQo+IC0JaWYgKCFyZXQpDQo+IC0JCW1zbGVlcChTTVUxM19NT0RFMV9SRVNFVF9XQUlUX1RJTUVf
SU5fTVMpOw0KPiAtDQo+IC0JcmV0dXJuIHJldDsNCj4gLX0NCj4gLQ0KPiAgIHN0YXRpYyBpbnQg
c211X3YxM18wX3dhaXRfZm9yX3Jlc2V0X2NvbXBsZXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LA0KPiAgIAkJCQkJICAgICB1aW50NjRfdCBldmVudF9hcmcpDQo+ICAgew0KPiANCg==
