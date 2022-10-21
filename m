Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2092C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 14:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D087510E092;
	Fri, 21 Oct 2022 14:11:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B5810E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 14:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDITYlQEj7a5sOyMVh6BODFQCGC9pUQR+hQjy/l+lpiSdPhJUxE0KvGONXZd9soB1W+WxAc8QxjjmzO3E+OQ+lQuKWIwwKPOp72Nf0exGltQc+0bVC+eNTHn1QWEMb/kIeWLSF2YO8LyxkprTXBSK+xeXIamzYuyb530Tsnc75ULHRMfdcFIbc5mR8xF3bEKBqKvFSuHAaN39DWjQK7jwvluep70hvker9uhOQDocS5s9ktO/C4Dkmd2IJVaY6z04J6txUo0mGTTHSWlR2WpXYB2zhUo4HWXep84mNopFbnTJhTts7Ov9ilY1nRYtCP+fhTjJbc3lnGp2q7u4Mtc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbss+eBZ1XnlrQftSh2gJWaga8QCzfHanRmmQ+zWQok=;
 b=TEHLvlLqBr/mhRtw93otO08Mkh7G2Sx/vHwib77jCVUQ+KyjRUEotHlbvBzm8wFxXDXVrGA62tY3qJXt3+2Oku87WUBGbdhmFtbZijOgT5xcrt3x1YoO4VUcVVu7qMpTg4PuZMdDsEo6RGlz9HVOZy7SBD9tEDjdMvtKq0wUIPawh3YauKG+Svahfs5SbyV881kFsHkF87OFZcTt5bmtc2wgGyo7vgoB73QBfgQQjwhTM4uQR/CsoQldJGPI6gDfhgO4Y2Wl0MCdvz3wANgKnlbQ4JsoOWOe1SO3qOhIxodDFr5uwaDP0v3YvdIqVpy1MzS4dm+ts3Be7ybax7zYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbss+eBZ1XnlrQftSh2gJWaga8QCzfHanRmmQ+zWQok=;
 b=2KpmQY3Frb7kakX3b02vOOEpJcGyedUtWoCX0aPzne6Bi7Fh3ygYNVROwO6gDCElQH7OQ6KrrjhJmXLXQSojelBt5GErkI2fPFbtXCn5pW5pYow8FeNHP8+I2iIzuh6Pnqq9r2hHLr52m05AA3NlvxgYHSHKK2TWfAKLuQ/inkQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Fri, 21 Oct 2022 14:10:52 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::922d:e78b:3a15:9098%5]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 14:10:52 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: disallow gfxoff until GC IP blocks complete
 s2idle resume
Thread-Topic: [PATCH] drm/amdgpu: disallow gfxoff until GC IP blocks complete
 s2idle resume
Thread-Index: AQHY5PUF2YrQRgpxJEac5az6bAwNW64Y2vyAgAAGOHA=
Date: Fri, 21 Oct 2022 14:10:52 +0000
Message-ID: <DS7PR12MB60050448182F4713F3D7908AFB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20221021022956.2775675-1-Prike.Liang@amd.com>
 <CADnq5_Of6R-BtZ5dz-e=nPsgNG4g4VqzsbnYznqfi7AKc1DXrw@mail.gmail.com>
In-Reply-To: <CADnq5_Of6R-BtZ5dz-e=nPsgNG4g4VqzsbnYznqfi7AKc1DXrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=513ecfc0-6e06-4570-924f-c333e98539e6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-21T14:01:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB6327:EE_
x-ms-office365-filtering-correlation-id: 88d39a43-a86e-44b3-5fbe-08dab36e1020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcsAysIm+nzDzedHaCKZL363k/5pnoADMSjwfRLK5IRTwqP6cPfzfuqltXJOxoiH1XvbbuA9kp+rs2LQC+TSADBLrwEtsq7sXwrh57UEMqyqfL/VM2UjNGF0BXyLECgGZYMN35mJI0Ypc21c+JYNTEBJBb1n/sILaGzfcUeOsQA0qbi9d+sW4aWvUY1/IO5SWXy8nHiMeKni+EMEwcAy/yGphsoQVl8Lj0Vw68RycztE3xfnLOYmPXJKGvshe+vZvKKPpSqK6r4Vy790axgO/osrkg6STw+xFL3khj2jkU4lsmUlEnQNO+yINazJ9z3xxwlhfoIXysHlhCHVDGjTygyYDcgtyDBy6kSg4CUByS1ccy/w+2aTtjbpza1mXsbxIPbO791MGxdnM25iNbRS3zKBdMU8oUjj48iG4nF8bX51VvH9TB3bRafFAQUxl8Pe/D+L+5uPr8bSm9AX4ZjVs59EqIs2TQWCzCXscsS2btXcF8bilVjH7qQCvqlVAATQVqOSHpe1/zullVZMLQnSiRc+Hgzlv+DLdAmHNyiqt0bjXXh0GwMguJrJCZ7IQ3gvlJzJCS81zSgxvjaZHFl8HxiHhGlSZq4eMDPbclIF5lWAtfzAY521nsVlnbJrllriXxdGp0PQQU2GPXSB82i+4BwLNpvSgnBCI/jXX8REJQsXlfbZctAmfcbUVCw7s2pmLMuRVB34tTAe/lgfKXeKxBLSdYrKH99JuFzJ8mWf5sBiD1EATXobq9LdtmPB1lbf8pMcltm2+5QTo+4iW7cYWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(186003)(38100700002)(71200400001)(478600001)(6916009)(38070700005)(54906003)(122000001)(52536014)(8936002)(86362001)(76116006)(316002)(33656002)(2906002)(66556008)(7696005)(66946007)(9686003)(55016003)(26005)(41300700001)(8676002)(66476007)(66446008)(5660300002)(64756008)(83380400001)(4326008)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUluSjZHa0lCTVhLeGluNkI1WWQ1T1VRZ1dmT3pQMkNTSmZ1Ung3VlN0RUNn?=
 =?utf-8?B?RUdtbEFKNno0am1hOUVPOHdoMWtISDR3MDVDUHVNMFJ1bW1saFVNMnpUUUFm?=
 =?utf-8?B?YUV3dTQzc1BYRk8zSDJ6OVhPMmRyZDBTYWJreEJEdWJkaFZ4STA1K0hFVG8x?=
 =?utf-8?B?TWt2MVl0TkJnbEpoWitrdFVPSHc3blpzV1NQOEU5cjN3aEVMdVB2ZndHdi9F?=
 =?utf-8?B?OGxqZnFESFh1R2dLcTEwdHhRZjM1SUhLdHRMelNXN3QxeEoyQzNFbXFsZlcx?=
 =?utf-8?B?b243bjVYaTM2SUFkTWJyQ0EzQmVEc3VZRWZuR0NpbFBvSzhZNDFPOHZzektL?=
 =?utf-8?B?RkFiQ1R3S24wa1AyVXVjeGtKZkVaZ2w5dm9LNDJ1U3Ivc3QzRjZVWVQzQjNK?=
 =?utf-8?B?MzRJRmFxM1Q5SHFLU1lrcllNQkp1a2FyTVpuUGcwTjBHcDk0N1JjYU1ScUho?=
 =?utf-8?B?aWdjR3RHeGM4WDlnNkVQUmJrTnNzaXN3aXpNQW9aS3FubXpzRGd0MVNIdnRl?=
 =?utf-8?B?YWtRU2JGV3ZZL2k0S2xweGE0VUVoQ0JwUWg5c1ZBaHJyTlNiMlN6eEZkY1ly?=
 =?utf-8?B?SmJCL1JEanJsRHpZRnZsRmJmQVdWRzNNNHJnRmhxLzVyUk9kcG91T0dydkFk?=
 =?utf-8?B?enFXSXdXaGtEdkpMQUJjaHJ2NDVUbTRLeW1DdjhFUVFCTDNlbTFGaWdhUC9Y?=
 =?utf-8?B?UXUzd3dBaVI1cTErWUlYcFJTc0RPbkM5NHZnNEUvdkozT29XS3pPS2VDYnZi?=
 =?utf-8?B?dkFQUCsyQWdGMlJKOFFCWm5BV3N3R2RLZDM4dVNqTkgxcllmN21KN1kyekNu?=
 =?utf-8?B?d08veGt3cThqbDVpVHBwQ2R4UEs0VHkyTGNoTnl2c3JmNGxaVkwzYXBEaEhL?=
 =?utf-8?B?WnNQRHRzZFJoTjAya051M3ZaNmVldjk1cmhrelhwTUtPOTJQTVNVMWN6YkVE?=
 =?utf-8?B?K0c0M0xCRitSTzVUeWgyeGVxRm1nNU04Sy8wSE84ZWU5S2JodmdVVkZyZFow?=
 =?utf-8?B?TjRxME5qeElnRE1IUzNlUzBpUXdMQ0RaK3h4Q1RIWTQ5S09HdURIb2o3bm8z?=
 =?utf-8?B?Yi9XWC9LOEVGMkx5MGhvTlQ3U2NURU5XMzByeEJmWFBjRzVPYVkyTHJyU3lw?=
 =?utf-8?B?MEJCc1JFSFhiN01JdWtGcHU4dHhqdUVPb0JJUFRoSnk5S1dDVTJBKzM1Tll4?=
 =?utf-8?B?dlM3c3IxSHpFdkdwZTdLcktKdjRSUDVUME0xWlp2dWErdUFESWp2WkZrY2I0?=
 =?utf-8?B?U2hhS3dkWWpDdnVDMmxMbjZ3eE9zK2F6aFJrQ1NzcS91VlpPVHRHY2lzTVFH?=
 =?utf-8?B?eDBqeHozM0VrN0V2Q01oTVh0S2gzTDhvNytRWE1UYU00Vk80U2pJT0tCbldo?=
 =?utf-8?B?K1hMcS83b3J1MlNwaFoxUUplaXorY2JOZ1dtNEdvYTJScEEvZmZRN2xaWHhx?=
 =?utf-8?B?Qnl4T0xNVlBiY2hVVjFjWEt2c3RXNHRJT3EwaVVzL3NodWJndnZKQ1d0clQw?=
 =?utf-8?B?cGNmRVpMUklMNWxZQXVTeGRlQWxrbmVScmtaYzhYaXA5YW9QWExNeU9yNmR2?=
 =?utf-8?B?bE1DcG5hbWwveEhQUmMrQ2MxYTUzOVR2aCtQRjBBVWZCTW1lMlhyZ3NpQzJZ?=
 =?utf-8?B?ak9tWTVPcGcvWCt1cUl0bi9nR1ZiUW4wVzUvdWZCQ3hiZG5nZDU2eEg4M0Ju?=
 =?utf-8?B?NjFIVGZ6N09Pa3hCb0c4K01KUXpvdzZHZmVVRm1UaUlzMEsxN0NjQUNxdVRO?=
 =?utf-8?B?SlhyM2cyQXBOUGNYQW9qcnZMKzRZVi9ZQ1VRd1JsMjB4R2JPcnJzd3lWMmxq?=
 =?utf-8?B?bWU1b0o3enlkVnlvanZydXhVTEhzbjEvWWxQRXV6WXZiOWZQbFFXY3RUbHds?=
 =?utf-8?B?Y2g5cnNEdksvT0RpK3NTSkdhcUxmU2tZV1kzNCtBZmtYTEJWaW5IbjIwOWZL?=
 =?utf-8?B?dzZsVUdTcysyWHRKdlQyOXk5RGxFKzhHc0VSRG80NmZrKzJKVHhSekZmOTBL?=
 =?utf-8?B?N091K2N2UFhTbW1JcGtFVUNLTzBHdHJybUJxTzBDQ056Z3NBZmIxUXZLbXpp?=
 =?utf-8?B?eHhVNjgwRUszUGQ4RlE4TWZsUzZqN2NiN1pTMmVnNGkyVnNYVXo5Q05Zd3hH?=
 =?utf-8?Q?o2v8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d39a43-a86e-44b3-5fbe-08dab36e1020
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 14:10:52.4053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaIl+/hkS4vOa96OcmTpXwiKLtGa5NxKJ0XUBGl9TqRtYq9GJtSMw0IahN5srE48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogRnJpZGF5LCBPY3RvYmVyIDIxLCAyMDIy
IDk6MzkgUE0NClRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZGlzYWxsb3cgZ2Z4b2ZmIHVudGlsIEdDIElQIGJs
b2NrcyBjb21wbGV0ZSBzMmlkbGUgcmVzdW1lDQoNCk9uIFRodSwgT2N0IDIwLCAyMDIyIGF0IDEw
OjMwIFBNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gSW4g
dGhlIFMyaWRsZSBzdXNwZW5kL3Jlc3VtZSBwaGFzZSB0aGUgZ2Z4b2ZmIGlzIGtlZXBpbmcgZnVu
Y3Rpb25hbCBzbw0KPiBzb21lIElQIGJsb2NrcyB3aWxsIGJlIGxpa2VseSB0byByZWluaXRpYWxp
emUgYXQgZ2Z4b2ZmIGVudHJ5IGFuZCB0aGF0DQo+IHdpbGwgcmVzdWx0IGluIGZhaWxpbmcgdG8g
cHJvZ3JhbSBHQyByZWdpc3RlcnMuVGhlcmVmb3JlLCBsZXQgZGlzYWxsb3cNCj4gZ2Z4b2ZmIHVu
dGlsIEFNREdQVSBJUHMgcmVpbml0aWFsaXplZCBjb21wbGV0ZWx5Lg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA0ICsrKysNCj4gZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgIHwgNSArKysrKw0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBlMDQ0NWU4Y2MzNDIuLjE2MjRlZDE1ZmJjNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBA
QCAtNDE4NSw2ICs0MTg1LDEwIEBAIGludCBhbWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LCBib29sIGZiY29uKQ0KPiAgICAgICAgIC8qIE1ha2Ugc3VyZSBJQiB0ZXN0
cyBmbHVzaGVkICovDQo+ICAgICAgICAgZmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT5kZWxheWVk
X2luaXRfd29yayk7DQo+DQo+ICsgICAgICAgaWYgKGFkZXYtPmluX3MwaXgpIHsNCj4gKyAgICAg
ICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7DQo+ICsgICAgICAgICAg
ICAgICBEUk1fREVCVUcoIndpbGwgZW5hYmxlIGdmeG9mZiBmb3IgdGhlIG1pc3Npb24gbW9kZVxu
Iik7DQo+ICsgICAgICAgfQ0KPiAgICAgICAgIGlmIChmYmNvbikNCj4NCj4gZHJtX2ZiX2hlbHBl
cl9zZXRfc3VzcGVuZF91bmxvY2tlZChhZGV2X3RvX2RybShhZGV2KS0+ZmJfaGVscGVyLA0KPiBm
YWxzZSk7DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2Ft
ZGdwdV9zbXUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5j
DQo+IGluZGV4IDRmZTc1ZGQyYjMyOS4uMzk0OGRjNWIxZDZhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiBAQCAtMTY2NCw2ICsxNjY0LDExIEBA
IHN0YXRpYyBpbnQgc211X3Jlc3VtZSh2b2lkICpoYW5kbGUpDQo+DQo+ICAgICAgICAgZGV2X2lu
Zm8oYWRldi0+ZGV2LCAiU01VIGlzIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5IVxuIik7DQo+DQo+ICsg
ICAgICAgaWYgKGFkZXYtPmluX3MwaXgpIHsNCj4gKyAgICAgICAgICAgICAgIGFtZGdwdV9nZnhf
b2ZmX2N0cmwoYWRldiwgZmFsc2UpOw0KPiArICAgICAgICAgICAgICAgZGV2X2RiZyhhZGV2LT5k
ZXYsICJ3aWxsIGRpc2FibGUgZ2Z4b2ZmIGZvciByZS1pbml0aWFsaXppbmcgb3RoZXIgYmxvY2tz
XG4iKTsNCj4gKyAgICAgICB9DQo+ICsNCg0KSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
cHV0IHRoaXMgaW4gYW1kZ3B1X2RldmljZS5jIHNvIGl0J3MgY2xlYXIgd2hlcmUgaXRzIG1hdGNo
IGlzLiAgQWxzbyBmb3IgcmF2ZW4gYmFzZWQgYm9hcmRzIHRoaXMgd2lsbCBnZXQgbWlzc2VkIGJl
Y2F1c2UgdGhleSBzdGlsbCB1c2UgdGhlIHBvd2VycGxheSBwb3dlciBjb2RlLg0KDQpBbGV4DQoN
CltQcmlrZV0gSSBtaXNzIHRoaXMgYW1kZ3B1X2dmeF9vZmZfY3RybCgpIGlzIGEgZ2VuZXJpYyB1
cHBlciBsYXllciBmdW5jdGlvbiBidXQgdGhhdCBzaG91bGQgYWxzbyB3b3JrIG9uIFJhdmUgc2Vy
aWVzLCBzaW5jZSBvbiB0aGUgUmF2ZSBzZXJpZXMgd2lsbCB1c2UgYW5vdGhlciBtZXNzYWdlIFBQ
U01DX01TR19HcHVDaGFuZ2VTdGF0ZSBleGl0IGdmeG9mZi4gQnV0IGl0IG1ha2VzIHNlbnNlIHVu
aWZ5IHRoZSBvcGVyYXRpb24gb2YgZXhpdGluZyBnZnhvZmYgYXQgYW4gdXBwZXIgbGF5ZXIgaW4g
YW1kZ3B1X2RldmljZS5jIGFuZCBJIHdpbGwgdXBkYXRlIGl0IGF0IHBhdGNoIHYyLg0KDQpUaGFu
a3MsDQpQcmlrZQ0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPg0KPiAtLQ0KPiAyLjI1LjEN
Cj4NCg==
