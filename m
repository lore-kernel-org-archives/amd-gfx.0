Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B6C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 08:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4C4603E9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 08:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA4C4603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385C36E435;
	Thu,  5 Aug 2021 08:51:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D429C6E435
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 08:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZJDn0AbqlBrU06YyE8rW5FHslCSF9loA7lIvEqX+QUCFbBNhhR3BOIdTWMbDjFfrshSnsXlMckgZQAxRCOUMzJWxzjcKyTyoIe9pD0KA1dYe9Wl0w6vsNmab3BwMbxOsvzN3xZt7kggYYBy/xGkFjZVbEJzxUUMYwwgmTr8EMlDDPlNfBqlAkNpDkLEunocxvtGEchyJ4Jh2lcWVG88BVorngo7pW4wm0R2R9EX571aE6HNpVyik2aMMTOO6tb3BtTzknGCCMQ7s4+BMaR0NUBkeyGC8Uwbr/WT0lFWrOKzvMUnjSDWhiM9b8JqrnsaqNjT+v6cdbXT0EhYVQsERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrkhAEei3ik1iQxZBqu2zPpV2yj7pKTtdhs8l0NBd3k=;
 b=HoEp1c7RR7T8GdxX9xo8xmpsvWgZuRND/y8tgCySaCxa2tvQUq5I2cgqZPHFmSmX3SjjSCMuDMI3EQLcjwA5HDPnkcpg7KMiAEzXikPaUr16t3Kou6ehhmUAJkEgcszhmq60NJMWt2qQAK8wTJJ5SJSdA0riWs3kL95Qmcseym0i6pfhNEEAooyntS0tBjK2FnWuaWlknaQ3UvxfM3k4JHnFI1jSyyKNExvthODC7APz82yHTataPalmgIzrAk8BQJBm8RxHv20UayQpiAnA1aau1WITkaJ9PhAHun/q4PWu0Y796G5ZyydcUyxkXDwfrb5fgZIIKYnlE3vb9MjwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrkhAEei3ik1iQxZBqu2zPpV2yj7pKTtdhs8l0NBd3k=;
 b=TMIBEyZ8XZg99RZmEdy4otMafPkWZrRhzSDIQTpkHjj06tL3wI75E3URTRNsHoxF4HA5c9fnrj5h6S1PWO/LQNCE+Dzzdl1ObqERqGIW7EQsP8xIhejTBEHjw1yLkhnJE+BfoB7WFiobbwKJd3OFxURRp9wzJ5E5xhU9IShxayw=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MW2PR12MB2475.namprd12.prod.outlook.com (2603:10b6:907:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 08:51:06 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::4025:2a95:e126:53de]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::4025:2a95:e126:53de%6]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 08:51:06 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues
 for raven
Thread-Topic: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues
 for raven
Thread-Index: AQHXg3rmtKEx+TY52E2h7ROog0zEuatYcMKAgAw04JA=
Date: Thu, 5 Aug 2021 08:51:06 +0000
Message-ID: <MW2PR12MB4684ED779CA54E8C67D027CEFDF29@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
 <7d68484f-b293-31c9-15a8-6ed700777dc9@amd.com>
In-Reply-To: <7d68484f-b293-31c9-15a8-6ed700777dc9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-05T08:51:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6d3cb145-a01d-4be2-8da0-6159f1e5dc07;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db3b472f-50f9-441a-67c3-08d957ee29fc
x-ms-traffictypediagnostic: MW2PR12MB2475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB24753F5833503C25193CF14BFDF29@MW2PR12MB2475.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYWKaYyKNkNGK/ihfiznrFtCAo0dRr4XI6n7z9dq0abL3PtcZgpP6+EqAURgsFEcnJNcoTAgE5swzcQLZ7cMbSSdjncBTzXY92w5LHUDetMy+K8xZgOg17yIa3FCNYcTXfLFGGvMA/z7VYXWmey5jQkVAUxULeK0ubUjy+hO7fPG8bl61LSBbuKWM1akm5phBAf1u/2f9kb208WOqeWtJ1uh9NrYIbuhyPeKSjv6azQ2tWSs9KkfmWBY2rNMO3XAV987jg3z88dywzy2NPSlbprO9KyrL2jTUFgImVznNQgDjnFMnS0pGDqFxkzNDhQ0GQlw56f2IRMQ/XAMmrPJUArIIV7D0bAFTLkyaRlpIWavE7/irbLlg5MTCTsaIybvbffv1mmkOlg21najEHHH49QXbA5BaTa6ScNMJ4XFklpZmR4zwWiRtf1DunJHz2/rHqJr3W2pJzOP+PlsXAwcOcmQbN61tmQDUYngMb+PkJfbdudrPiy5mOUN3rWznzgsC0y6TdvfoAh4clYfVdzel9E12YnxniaUt6A6m2IH4fPxtwO2u87QrqPVWcn+APhCtkRBRcvVHZPlPjHeJwu0Qg3gigsZO9MCT5odgl4RExhAnyy+ryrfRqELWFTkca76QyqAgw/LDW3k+dWGcpRLqOup2uuk8Oi109YQuMExS7y6FVDJjTF/ydt+mIKGa2eYqbXYyltXl9RhYz5O2+h71g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(86362001)(8936002)(8676002)(66946007)(478600001)(9686003)(33656002)(71200400001)(52536014)(110136005)(55016002)(83380400001)(5660300002)(66446008)(316002)(2906002)(38070700005)(38100700002)(122000001)(53546011)(26005)(76116006)(186003)(66476007)(7696005)(66556008)(6636002)(64756008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkdIdTd2M3BaY2U4ZnBWSEkvSHRENFM3K1IyMktYWEswcTN3MFA2RzhTd2M3?=
 =?utf-8?B?d0pSTG1ZaUtteEVaY1F6UzZmZFYzZXJ6a2VhUEc3bUlBTnVCclNqd0Z2Z0xM?=
 =?utf-8?B?dlpHK2NXYktSaFdrNUZsYTFMQlZucTlGMEJacndEQWNuOGRHTEVrR1VXZlVD?=
 =?utf-8?B?VjBDVW5PVVFWWGswNXN1Y1dBV3VWUzFTR2dJR1RTbnEyTXpwclhDSkRkdkY5?=
 =?utf-8?B?SGI3YkhxazUzZm9iMkRTWWpNdis5clMzeThnYnA1RU5MNmRNMTVtdkR2ekhF?=
 =?utf-8?B?ZVhNeDZGNHFDdkJtb1F6alJscE9mZ2xyUHFsRDZRWkFFWmMrbVVZTFlYME5r?=
 =?utf-8?B?MHdRU2FVUVlEOW4xUWU0VVVBYlBzalluc1ZaMDhHWWkxeXV1dVpFb2pwdlVh?=
 =?utf-8?B?MUIwOFJFUksvSGM0VG5kbjh1ckNFaU96M2RnWGkzZ2U3WUlGUG1WaUlVaVJp?=
 =?utf-8?B?OVNvWGdOb0NTTUkzdHVIZzY4WTJXZ1F0WjZxWWNyaDFaZWZrUWRFbDN0L3Uy?=
 =?utf-8?B?WFBvUWNwY1h3V0lOQXBBTHE1SWhzTFJESEdwbmRJMWdPQVhYUjMvZEpkVUJL?=
 =?utf-8?B?VmZFcVlqVHVJVlh0YjI2dUlISzREMTl6SzI5MGZnZVlaaGFqTTNhb1M4c3k4?=
 =?utf-8?B?NWFPTGp6VlBycDlKNU41dmJxL3NqVFUwWStnTk52TEt1OEJyNW56THlEMFdR?=
 =?utf-8?B?UWNCL3VxSndaV0dQczhBYWVmeXFMOTkyRUNxdlhEakgzelRONzM5a1A1c04w?=
 =?utf-8?B?NWdSSmwxZzg3TVJlc00wUUcwSHRheForZnlYcHhjSzJGaC9kcE5rc1B3UFZB?=
 =?utf-8?B?WUhPWThyWWthcHhRUm8xSVY0Z0RyL0ZsNHVWK2dpSFpxaDNVQmxTMHY5UlFO?=
 =?utf-8?B?dG5SN2FkRDlLM2c4YXUwT1J0V3poVXBOa3lGM0JPalBXbkdSM0R2S0FDRTlB?=
 =?utf-8?B?RkNkWUl6blViekZvQzRKcStuUXN0TXh4UHJOYWtGcWVFV3BybFdBYjZqY1Q2?=
 =?utf-8?B?b2lmcUtkU0kvV3NGNFJVN3Z4dXNQcnh4QytscXlYVmtueGJwbjFkbElsMjBk?=
 =?utf-8?B?cktZcDBmd0ZVRXRpMjZRNmpDTlR0T1RmL2RCMXlSMm9VOUV6a0s4eDhKLzRm?=
 =?utf-8?B?cWVSOUtJc1BDRlhUT1dXZ0dlYmNzYjFPeGt1MzdJTFZpeXVyU2NOZk81QTBk?=
 =?utf-8?B?d1U1NjdUaDFMV3ZHVVJWL1g5elArSDExYTRsblF0Snc2UGdOb1lKUERQc09W?=
 =?utf-8?B?Ukh5R3ZSNStsNXVsa0R4M2FtMzFnbHJRaWxyV3VLVzgwQ0Z2OVFZVHNSOVR5?=
 =?utf-8?B?cE10VktKUTBZeFRwUGYzcU1tbUNwSis5Z1NJMU9GWDUxdnlseDBISmpaa09F?=
 =?utf-8?B?ZEpGMG9oaktoSkdQV2xwem1Xd2hFODZjREIrUjNWRitOWlpVOUFVajZLUjVt?=
 =?utf-8?B?Um5MbkFpZElOUnZQS0NZaHhhWkZpbHRGejJBcFBCMVE3Wi92U2lCSmZHZXp3?=
 =?utf-8?B?ZllQUTRXaHpuejJjb1p5UkNzdjdzbHJzYzU0Y3dmbHR2b3p4OXpRaE1FYlJH?=
 =?utf-8?B?M0RKcC9ZelAxVTE5MFo5MXNxbW11aU00cGt3Z2I3cFlkblA1ZjVBOWhSSk1w?=
 =?utf-8?B?aVU3bVUyRXJOa01YZ0xSemFYRFJZY1cvTUorSUNnWjY5aW8zM0gxRzQrajhi?=
 =?utf-8?B?Q1VOTWppTk54S2pQMTNManRuQklmaW13UitBTzN5ZUJEa05VbDhnOC9RVndw?=
 =?utf-8?Q?5OyjCpELd0iDLj4C7ua2RZwdfO1LQIigIyAzC00?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3b472f-50f9-441a-67c3-08d957ee29fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 08:51:06.6317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mm9yplXU/2oXZFyvklnHbleY/nDHGBAfSJLTOV0ZQFBF3uRKlk0emsktcWowAMG9wQ1S2bcvDSzwYMVE7VVLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2475
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgRmVsaXgsDQoNCkNhbiB3ZSBzZXQgbm9yZXRy
eT0xIGZvciBkZ3B1IHBhdGgoaWdub3JlX2NyYXQ9MSkgd2hpY2ggZG9lc27igJl0IHRvIHRocm91
Z2ggaW9tbXV2MiBwYXRoIG9uIHJhdmVuIGFzIGJlbG93Og0KPiArCWNhc2UgQ0hJUF9SQVZFTjoN
Cj4gKwkJLyoNCj4gKwkJICogVE9ETzogUmF2ZW4gY3VycmVudGx5IGNhbiBmaXggbW9zdCBTVk0g
aXNzdWVzIHdpdGgNCj4gKwkJICogbm9yZXRyeSA9MS4gSG93ZXZlciBpdCBoYXMgdHdvIGlzc3Vl
cyB3aXRoIG5vcmV0cnkgPSAxDQo+ICsJCSAqIG9uIGtmZCBtaWdyYXRlIHRlc3RzLiBJdCBzdGls
bCBuZWVkcyB0byByb290IGNhdXNlcw0KPiArCQkgKiB3aXRoIHRoZXNlIHR3byBtaWdyYXRlIGZh
aWxzIG9uIHJhdmVuIHdpdGggbm9yZXRyeSA9IDEuDQo+ICsJCSAqLw0KPiAgCQlpZiAoYW1kZ3B1
X25vcmV0cnkgPT0gLTEpIHsNCj4JCQlJZihpZ25vcmVfY3JhdCkNCj4gIAkJCQlnbWMtPm5vcmV0
cnkgPSAxOw0KPgkJCWVsc2UNCj4JCQkJZ21jLT5ub3JldHJ5ID0gMDsNCj4JCX0NCj4gIAkJZWxz
ZQ0KPiAgCQkJZ21jLT5ub3JldHJ5ID0gYW1kZ3B1X25vcmV0cnk7DQo+ICAJCWJyZWFrOw0KDQpC
UiwNCkNoYW5nZmVuZy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEp1
bHkgMjgsIDIwMjEgMTA6MjIgUE0NClRvOiBaaHUsIENoYW5nZmVuZyA8Q2hhbmdmZW5nLlpodUBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEh1YW5nLCBSYXkgPFJheS5I
dWFuZ0BhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHNldCBkZWZhdWx0IG5vcmV0cnk9MSB0byBmaXgg
a2ZkIFNWTSBpc3N1ZXMgZm9yIHJhdmVuDQoNCkRvZXNuJ3QgdGhpcyBicmVhayBJT01NVXYyPyBB
cHBsaWNhdGlvbnMgdGhhdCBydW4gdXNpbmcgSU9NTVV2MiBmb3Igc3lzdGVtIG1lbW9yeSBhY2Nl
c3MgZGVwZW5kIG9uIGNvcnJlY3QgcmV0cnkgaGFuZGxpbmcgaW4gdGhlIFNRLg0KVGhlcmVmb3Jl
IG5vcmV0cnkgbXVzdCBiZSAwIG9uIFJhdmVuLg0KDQpJIGJlbGlldmUgdGhlIHJlYXNvbiB0aGF0
IFNWTSBoYXMgdHJvdWJsZSB3aXRoIHJldHJ5IGVuYWJsZWQgaXMsIHRoYXQNCklPTU1VdjIgaXMg
Y2F0Y2hpbmcgdGhlIHBhZ2UgZmF1bHRzLCBzbyB0aGUgZHJpdmVyIG5ldmVyIGdldHMgdG8gaGFu
ZGxlIHRoZSBwYWdlIGZhdWx0IGludGVycnVwdHMuIFRoYXQgYnJlYWtzIHBhZ2UtZmF1bHQgYmFz
ZWQgbWlncmF0aW9uIGluIHRoZSBTVk0gY29kZS4gSSB0aGluayB0aGUgYmV0dGVyIHNvbHV0aW9u
IGlzIHRvIGRpc2FibGUgU1ZNIG9uIEFQVXMgd2hlcmUNCklPTU1VdjIgaXMgZW5hYmxlZC4NCg0K
QWx0ZXJuYXRpdmVseSwgd2UgY291bGQgZ2l2ZSB1cCBvbiBJT01NVXYyIGVudGlyZWx5IGFuZCBh
bHdheXMgcmVseSBvbiBTVk0gdG8gcHJvdmlkZSB0aGF0IGZ1bmN0aW9uYWxpdHkuIEJ1dCB0aGF0
IHJlcXVpcmVzIG1vcmUgY2hhbmdlcyBpbiB0aGUgYW1kZ3B1X3ZtIGNvZGUuDQoNClJlZ2FyZHMs
DQrCoCBGZWxpeA0KDQoNCkFtIDIwMjEtMDctMjggdW0gMjozNiBhLm0uIHNjaHJpZWIgQ2hhbmdm
ZW5nOg0KPiBGcm9tOiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPg0KPg0KPiBGcm9t
OiBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4NCj4NCj4gSXQgY2FuJ3QgZmluZCBh
bnkgaXNzdWVzIHdpdGggbm9yZXRyeT0xIGV4Y2VwdCB0d28gU1ZNIG1pZ3JhdGUgaXNzdWVzLg0K
PiBPcHBvc2l0ZWx5LCBpdCB3aWxsIGNhdXNlIG1vc3QgU1ZNIGNhc2VzIGZhaWwgd2l0aCBub3Jl
dHJ5PTAuDQo+IFRoZSB0d28gU1ZNIG1pZ3JhdGUgaXNzdWVzIGFsc28gaGFwcGVuIHdpdGggbm9y
ZXRyeT0wLiBTbyBpdCBjYW4gc2V0IA0KPiBkZWZhdWx0IG5vcmV0cnk9MSBmb3IgcmF2ZW4gZmly
c3RseSB0byBmaXggbW9zdCBTVk0gZmFpbHMuDQo+DQo+IENoYW5nZS1JZDogSWRiNWNiM2MxYTA0
MTA0MDEzZTRhYjhhZWQyYWQ0NzUxYWFlYzRiYmMNCj4gU2lnbmVkLW9mZi1ieTogQ2hhbmdmZW5n
IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5jIHwgMTUgKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBpbmRleCAwOWVkZmI2NGNjZTAuLmQ3ZjY5ZGJk
NDhlNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBA
QCAtNjA2LDE5ICs2MDYsMjAgQEAgdm9pZCBhbWRncHVfZ21jX25vcmV0cnlfc2V0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgCQkgKiBub3JldHJ5ID0gMCB3aWxsIGNhdXNlIGtmZCBw
YWdlIGZhdWx0IHRlc3RzIGZhaWwNCj4gIAkJICogZm9yIHNvbWUgQVNJQ3MsIHNvIHNldCBkZWZh
dWx0IHRvIDEgZm9yIHRoZXNlIEFTSUNzLg0KPiAgCQkgKi8NCj4gKwljYXNlIENISVBfUkFWRU46
DQo+ICsJCS8qDQo+ICsJCSAqIFRPRE86IFJhdmVuIGN1cnJlbnRseSBjYW4gZml4IG1vc3QgU1ZN
IGlzc3VlcyB3aXRoDQo+ICsJCSAqIG5vcmV0cnkgPTEuIEhvd2V2ZXIgaXQgaGFzIHR3byBpc3N1
ZXMgd2l0aCBub3JldHJ5ID0gMQ0KPiArCQkgKiBvbiBrZmQgbWlncmF0ZSB0ZXN0cy4gSXQgc3Rp
bGwgbmVlZHMgdG8gcm9vdCBjYXVzZXMNCj4gKwkJICogd2l0aCB0aGVzZSB0d28gbWlncmF0ZSBm
YWlscyBvbiByYXZlbiB3aXRoIG5vcmV0cnkgPSAxLg0KPiArCQkgKi8NCj4gIAkJaWYgKGFtZGdw
dV9ub3JldHJ5ID09IC0xKQ0KPiAgCQkJZ21jLT5ub3JldHJ5ID0gMTsNCj4gIAkJZWxzZQ0KPiAg
CQkJZ21jLT5ub3JldHJ5ID0gYW1kZ3B1X25vcmV0cnk7DQo+ICAJCWJyZWFrOw0KPiAtCWNhc2Ug
Q0hJUF9SQVZFTjoNCj4gIAlkZWZhdWx0Og0KPiAtCQkvKiBSYXZlbiBjdXJyZW50bHkgaGFzIGlz
c3VlcyB3aXRoIG5vcmV0cnkNCj4gLQkJICogcmVnYXJkbGVzcyBvZiB3aGF0IHdlIGRlY2lkZSBm
b3Igb3RoZXINCj4gLQkJICogYXNpY3MsIHdlIHNob3VsZCBsZWF2ZSByYXZlbiB3aXRoDQo+IC0J
CSAqIG5vcmV0cnkgPSAwIHVudGlsIHdlIHJvb3QgY2F1c2UgdGhlDQo+IC0JCSAqIGlzc3Vlcy4N
Cj4gLQkJICoNCj4gKwkJLyoNCj4gIAkJICogZGVmYXVsdCB0aGlzIHRvIDAgZm9yIG5vdywgYnV0
IHdlIG1heSB3YW50DQo+ICAJCSAqIHRvIGNoYW5nZSB0aGlzIGluIHRoZSBmdXR1cmUgZm9yIGNl
cnRhaW4NCj4gIAkJICogR1BVcyBhcyBpdCBjYW4gaW5jcmVhc2UgcGVyZm9ybWFuY2UgaW4NCg==
