Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B14C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 16:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665E789F24;
	Mon, 22 Nov 2021 16:16:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9555689ECB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 16:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLbuqOcjv+rzQwkXtTppYA3sycvBGSmdRDEkm/MaNMSIlEPozClOxjbPyBhy3BvImrJ47s8WN5CQIR0/B/KHaJRcKbNdMm7bMrdhatb6oq6Brd9x5xdInkPizyzkrT+see6oUgqy8fytuY5mYEh8iZ0Whh+aDDVsmVnOIq4WuNLuN6DSmeT3npF02IvGvLxPY08OhsQAGvaERBPputTiV5mR9CHx8X+z7S6GWkmc1vXfUYpYQkgiRMDGapRAk9Pzwz4avFtNIcXuMWwM13JH3AKB96w/y0by62+Ql/+A+WXjcUbiQLtbkrt4tY7Fl2Dqun2fPURuulKBslp2GCTmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCOOg/hjoqATF6j1RMwJZRYzRcKUukAZgB9RXQySA6s=;
 b=OHZuJd9hr+OIWQwH/UuqqeDzgvJEMRcxO4vsm6EvvFBzu2cbeuKl6QMXfs+NO/d2I3Hy2LKdElYWVw8WXm5Zcc3SFyrf9lmnKPuBVGHqyMXJruvUzN0rNn2BjcPZIffFGeZBzPLlQOiXVcpY7kVanZ8suFK9xF4q/LGuk1muo76EXW24jtQCTmpvgV7NpSxb/x3FMWOxLU8G7xw0gXIv71/vmzg+3APvhdrtkkJZnevFqG2MWXVly9U8SZjQ2rpUJ9AxFtWU+5U+z99kzTwSzy30M+MGQpG/l84A8G7uw00N1XMi3nx7vqhbWwCvPNyHCAV/jJf7hzB8hu6CUPO34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCOOg/hjoqATF6j1RMwJZRYzRcKUukAZgB9RXQySA6s=;
 b=m+ArVczEeVRJYXWs1934uJm544/w269QBcCyPsROefUcSMY9FCyFc7KdNye0sbcvtQ8GotNCoze4CHeJaSekz+gut8jHfLBaRPkVD1udt+EA7zOvKNCTLgGE8z5JnN2Ktzq25ApFst1x5CGI43QzrQ1JqK1gco5cBbMcId7RA4U=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 16:16:55 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8%5]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 16:16:55 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Thread-Topic: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Thread-Index: AQHX3J1tejNjhD04q0aFu2fssW4xvqwPtVEAgAAI42A=
Date: Mon, 22 Nov 2021 16:16:54 +0000
Message-ID: <CH0PR12MB5372338AF20E1B11DF588E90F49F9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211118165737.27432-1-shaoyun.liu@amd.com>
 <9a6d5732-cdbc-1964-0b92-a7b64a7d529a@amd.com>
In-Reply-To: <9a6d5732-cdbc-1964-0b92-a7b64a7d529a@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-22T16:16:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1aeb1688-ac49-4980-a70e-4d2b542549e0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8e5dae-4bc4-4a54-c612-08d9add38037
x-ms-traffictypediagnostic: CH0PR12MB5372:
x-microsoft-antispam-prvs: <CH0PR12MB5372189237FB8F03BBF8C839F49F9@CH0PR12MB5372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDkJ4RqTatvHHHspvLxsJ32U2fLs1kmluOPBBUv1PNZ5WHXAYi9WpxnPDb4mM0SpICPHVmzMCqYUT2cE54Y5dqETdpW8BFq0fNDjooegZOMDSekBW1qAmQ8EsodyyHSKF0KrxT9Z4kYciyiDM57ppe1x7oqyAgwnwE+VoroG/k9ew8Uwymxtun1l1CfcZlx4EyGnj0k0pPUsQ0WDHFyT6FxUodbPptzR/9qxQfB0qs8DEVQEmih44dKJ5X5PSsDMrVuk947F7IOCgY9eiVZOsE7UZbL46dAOve/BXdYhfAvBW7fppYLJL+GtM3nJGEGXNWBIdQ67KPbJj0KtwhKaMGWC2DTauBYC3iKNJ+VnPtxei341AGTfAPbu82XCdMR7+iDCLh6k5X82eXASavjJL4G4dkqc6ySFdlJZDV5SS8zYy5Tm2AT5M9747AdaTir2SNPbd0S/JNuF7YYrO4usTgUKLz9SxTlb7xSdpVzFkhh2PXB/rcJ4cOV7yErL7ltY7MlZp4qza4UEDSOC82ub3Fl4pYg0/kWjjvU+xUulx/Gj3VZfH+TkwWfppsTbPJHZajHdBYHI+zvMej3UhsunSguaYUZvEdtm1y9Y2AH3n9FYj59VjK/pDcHnXh18zzlHxQon1/5AI0MNghMycvXdY+CMffNbRHEqDcWXnIhjPm0olKCDoaq9pU9c7OWUhOvCzk+5kbjr82MlulfEZbKBEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(186003)(66946007)(76116006)(6506007)(71200400001)(5660300002)(66556008)(110136005)(26005)(122000001)(8936002)(83380400001)(9686003)(38070700005)(316002)(38100700002)(4001150100001)(33656002)(53546011)(7696005)(52536014)(8676002)(2906002)(64756008)(66446008)(508600001)(55016002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE9scnl1UjZ2ajBtQ0dDS3ZMeG4xSWJXRS9IeFp3bFZIM2kxelh6MTlzNWRE?=
 =?utf-8?B?dFcwRFYvKzViYnZWSVRmakR4a3NSMVMzZGhRM1RPKzdmQkx3STdLbEdsNlhz?=
 =?utf-8?B?UENlMkQ2dnczbS9heURoSDdhSUNrMGJWUW9mTHRET1ZrRnF3bTRZTjRQWGV3?=
 =?utf-8?B?Z2V5cW1aWi91c252VjFuYVdKVHlaa01BNWlBWS9kRVVoZnNNdnoySE1uYVd6?=
 =?utf-8?B?TXc5V1oxT1QvZWtoelRFYnVIUmx3cTUwS2lHNWdmME1TNkNyMHl5dkMvR2ZO?=
 =?utf-8?B?dVVBVFFwOE43a2hiRmNPWVVSOXU2b3dPNm5Za0pjSEhxbHk5djYzUGRNN09Y?=
 =?utf-8?B?MDRUUklLZHVZMkczcmd1NEZTT1ptem9WbzNqNDFOYVNwWE5DMnR0cE41V1Rl?=
 =?utf-8?B?ZFRsSHh6QWZDVDliNmtxVXhFZmRaK2NmR1NtcWFJVEpQRFFCcUNEVW9XYUM4?=
 =?utf-8?B?eWZyQ3l0OGJUMEJsV3VPeGZlSmdmRVdZRi9QNW01WUR1ZTUvZVpNTWRFTHlG?=
 =?utf-8?B?OURRNVhTeFdrUGgxdGxDVGZXU21iWFJUYlRSRUJ6Uml1Z25pSjJ0NTcveVFS?=
 =?utf-8?B?RXNxaUtwb1Q4UkJ5dS92OUdhUjUxRzczR1psVkhiQ1FFYkZyMmd4L3JzVWlm?=
 =?utf-8?B?OEgvMkhrZGk5NjVwWW0zTk0rNXhZRUtqOUtJVFFQWTJpR2hQQjVBMkVpMzdL?=
 =?utf-8?B?T04xNlNhUlhaKzdPdVp4dTVCbEdMNWhXcmxBYXV3U0cxZ2hLQnlmZFQxMXZm?=
 =?utf-8?B?L2lhakIwRVh0S09tdVQ2cXZFVnJqbU1sUk45Zk9CRFdHZFFieEluZU9HK0pk?=
 =?utf-8?B?R1Ria2FyM2pCZ2R0VEJuV2hZUVBPL2h2TXhDWmdIV1ErR0R2TnFzT05XVVQy?=
 =?utf-8?B?dk5NUExubHpIZ2NXY1ZwRHU4WldnZE8zaHF1Tktpbll2eDd5NmNPcURTMFJw?=
 =?utf-8?B?a29vbjFncjFXSEVCU1cwVDZ2cHNsSDBma3JkZktNcEI5ZzVycnBRbFhMdDFq?=
 =?utf-8?B?SU9RNGJ1TkxSMDF6bFFiT3hiQWVnc0tZN2NLUnRESHR1dmhNc3FlZm1FSzZy?=
 =?utf-8?B?SFhCV0xYVXFpZW9hYmoraWRKNG1Tclcwa0xlODQvM2JNNmpxdW8wOSt5d09a?=
 =?utf-8?B?NzdoaXUvTC9BUm1scjNnMDdtSDVjdFhyb2FKbTE0L3hRNkJxRjYzcnpwd1pT?=
 =?utf-8?B?RlZ6WDZOdW03N1RoQjl3MDRCcjN5N3dGdTJRNXFSVDRLWkRFMjZMejY4aUd6?=
 =?utf-8?B?SkMzL3NtUUIvaS9xQkkyUTFSSEd1ZEU1YWwrN25mNkZjVHYvOWptOG9lKzF5?=
 =?utf-8?B?RmxpS2VzRjM2NlVsNHJKOENOMGhMQ01MSjZ2dE13Z3lDUnJHTERsRHVmUEhM?=
 =?utf-8?B?Vm40eU9Td1BSanZTaHRtb3dXYjBkR1BlWGFrS2lsdXRnbXJmbnExLzlBMGhs?=
 =?utf-8?B?ZzRMUnNhbVVCZDRGdDVwSEU1TUxSZUVqZU1tTk55OHRwd292SWgwaUZmRnNq?=
 =?utf-8?B?ZDhZVGtoaXB5T0xiTVg4OUtJMEFvUU9OWlJpN2Z4cG9KUW1sS1F6UEpEamRR?=
 =?utf-8?B?UnNjb1VhZjVmemhoalQ5M25JNERVRGJpendEdXNJS2ZOZElHL2dBaTAyUHBS?=
 =?utf-8?B?T2NQMFpDanNNaUFmb2hnVjFnWTBXaExFeTd1SXpwVmxtUnQzdkhFOXU4Ly80?=
 =?utf-8?B?L0lVTVdaMUI3a3BTWGg4dG9aZUhWaldxZnhuU2pRcTdrcU9ueDVsY2hEUGlh?=
 =?utf-8?B?RG9yWW5Mb0Era2tkSnRWREhOVW9nekd3SEJFaCtsS1huZHN3VXZJU0FWSzlq?=
 =?utf-8?B?TFBEcmIvc2IvWlY1bEM2VDRNRCtjbmFHVm5jYXFBNkp2VEVXWHFzMGUyYWhM?=
 =?utf-8?B?SHo2cmcrdGY2OHc0QSt3N21lUDNEL1krSGMwNTY2c0piWUVoQjZGcm9kR1E1?=
 =?utf-8?B?cFF5dTVlMkVUYkIrbE5EQWVKQmMzTUhOeDdYZUM4NFJrc3kvdXhkV3g3T0tv?=
 =?utf-8?B?dTZNOWJtVXU3b0R4N0U3eU5mcEVGM0tyL0FNZnRNa1pwL0xnUXZZRmZUSnl5?=
 =?utf-8?B?d200UFZYOWN1dWMvMkFXRjNFNzB5Y09rOHcvZkxIRldqQ2trYU5ZYkptV2M1?=
 =?utf-8?B?elYvZ0tmM1pQby9TVFVaNlQyYU1rNDNPQ3M2ckdPVDRtTFBFcjI4RzRQQUUz?=
 =?utf-8?Q?i5F0rwZFy/ds1cXQCzgOkIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8e5dae-4bc4-4a54-c612-08d9add38037
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 16:16:54.8687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBf2cNsaPuv3oG73Xg20Pj+PPGwRfQknvzwzyCDfEveWw3cIjpB7OXm3haPrR/1+XNHFVZFt9afB5/vaWj8l4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IC4NClRoZSBo
YXNoIGZvciB0aGUgcHJldmlvdXMgY2hhbmdlIGZyb20gZ2VycmlyZ2l0L2FtZC1zdGFnaW5nLWRy
bS1uZXh0IGJyYW5jaCBpcyA3MDc5ZTdkNWM2YmYyNDhiZmYsICBzbyB0aGVyZSBpcyBhbm90aGVy
IGRybS1uZXh0IGJyYW5jaCB0aGF0IG5vdCBpbiB0aGUgIGdlcnJpdGdpdCBmb3IgdXBzdHJlYW0g
PyANCg0KVGhhbmtzIA0KU2hhb3l1bi5saXUNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiANClNlbnQ6
IE1vbmRheSwgTm92ZW1iZXIgMjIsIDIwMjEgMTA6NDAgQU0NClRvOiBMaXUsIFNoYW95dW4gPFNo
YW95dW4uTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IG1vdmUga2ZkIHBvc3RfcmVzZXQgb3V0IG9m
IHJlc2V0X3NyaW92IGZ1bmN0aW9uDQoNCkFtIDIwMjEtMTEtMTggdW0gMTE6NTcgYS5tLiBzY2hy
aWViIHNoYW95dW5sOg0KPiBGb3Igc3Jpb3YgWEdNSSAgY29uZmlndXJhdGlvbiwgdGhlIGhvc3Qg
ZHJpdmVyIHdpbGwgaGFuZGxlIHRoZSBoaXZlIA0KPiByZXNldCwgc28gaW4gZ3Vlc3Qgc2lkZSwg
dGhlIHJlc2V0X3NyaW92IG9ubHkgYmUgY2FsbGVkIG9uY2Ugb24gb25lIA0KPiBkZXZpY2UuIFRo
aXMgd2lsbCBtYWtlIGtmZCBwb3N0X3Jlc2V0IHVuYmxhbmNlZCB3aXRoIGtmZCBwcmVfcmVzZXQg
DQo+IHNpbmNlIGtmZCBwcmVfcmVzZXQgYWxyZWFkeSBiZWVuIG1vdmVkIG91dCBvZiByZXNldF9z
cmlvdiBmdW5jdGlvbi4gDQo+IE1vdmUga2ZkIHBvc3RfcmVzZXQgb3V0IG9mIHJlc2V0X3NyaW92
IGZ1bmN0aW9uIHRvIG1ha2UgdGhlbSBiYWxhbmNlIC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogc2hh
b3l1bmwgPHNoYW95dW4ubGl1QGFtZC5jb20+DQoNClBsZWFzZSBjaGFuZ2UgdGhlIGhlYWRsaW5l
IHByZWZpeCB0byAiZHJtL2FtZGdwdTogIi4gVGhlIGV4dHJhICIvYW1kIiBpcyByZWR1bmRhbnQu
IEFuZCBJJ2QgYWxzbyBhZGQgYSB0YWcNCg0KRml4ZXM6IDlmNGYyYzFhMzUyNCAoImRybS9hbWQv
YW1kZ3B1OiBmaXggdGhlIGtmZCBwcmVfcmVzZXQgc2VxdWVuY2UgaW4NCnNyaW92IikNCg0KTm90
ZSB0aGF0IHRoZSBjb21taXQgaGFzaCBpcyB0aGUgb25lIGZyb20gdGhlIGRybS1uZXh0IGJyYW5j
aCwgd2hpY2ggaXMgd2hhdCB3aWxsIGdldCBtZXJnZWQgaW50byBtYXN0ZXIgZXZlbnR1YWxseS4g
V2l0aCB0aG9zZSBjaGFuZ2VzLCB0aGUgcGF0Y2ggaXMNCg0KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA3ICsrKy0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDEwYzgwMDhkMWRh
MC4uOWE5ZDU0OTNjNjc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQo+IEBAIC00MzA4LDcgKzQzMDgsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9k
ZXZpY2VfcmVzZXRfc3Jpb3Yoc3RydWN0IA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgDQo+
ICAJYW1kZ3B1X2lycV9ncHVfcmVzZXRfcmVzdW1lX2hlbHBlcihhZGV2KTsNCj4gIAlyID0gYW1k
Z3B1X2liX3JpbmdfdGVzdHMoYWRldik7DQo+IC0JYW1kZ3B1X2FtZGtmZF9wb3N0X3Jlc2V0KGFk
ZXYpOw0KPiAgDQo+ICBlcnJvcjoNCj4gIAlpZiAoIXIgJiYgYWRldi0+dmlydC5naW1fZmVhdHVy
ZSAmIEFNREdJTV9GRUFUVVJFX0dJTV9GTFJfVlJBTUxPU1QpIA0KPiB7IEBAIC01MDgxLDcgKzUw
ODAsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgDQo+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+ICANCj4gIAl0bXBfdnJhbV9sb3N0X2NvdW50ZXIgPSBhdG9taWNfcmVh
ZCgmKChhZGV2KS0+dnJhbV9sb3N0X2NvdW50ZXIpKTsNCj4gIAkvKiBBY3R1YWwgQVNJQyByZXNl
dHMgaWYgbmVlZGVkLiovDQo+IC0JLyogVE9ETyBJbXBsZW1lbnQgWEdNSSBoaXZlIHJlc2V0IGxv
Z2ljIGZvciBTUklPViAqLw0KPiArCS8qIEhvc3QgZHJpdmVyIHdpbGwgaGFuZGxlIFhHTUkgaGl2
ZSByZXNldCBmb3IgU1JJT1YgKi8NCj4gIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+
ICAJCXIgPSBhbWRncHVfZGV2aWNlX3Jlc2V0X3NyaW92KGFkZXYsIGpvYiA/IGZhbHNlIDogdHJ1
ZSk7DQo+ICAJCWlmIChyKQ0KPiBAQCAtNTE0MSw4ICs1MTQwLDggQEAgaW50IGFtZGdwdV9kZXZp
Y2VfZ3B1X3JlY292ZXIoc3RydWN0IA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgDQo+ICBz
a2lwX3NjaGVkX3Jlc3VtZToNCj4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZp
Y2VfbGlzdF9oYW5kbGUsIHJlc2V0X2xpc3QpIHsNCj4gLQkJLyogdW5sb2NrIGtmZDogU1JJT1Yg
d291bGQgZG8gaXQgc2VwYXJhdGVseSAqLw0KPiAtCQlpZiAoIW5lZWRfZW1lcmdlbmN5X3Jlc3Rh
cnQgJiYgIWFtZGdwdV9zcmlvdl92Zih0bXBfYWRldikpDQo+ICsJCS8qIHVubG9jayBrZmQgKi8N
Cj4gKwkJaWYgKCFuZWVkX2VtZXJnZW5jeV9yZXN0YXJ0KQ0KPiAgCSAgICAgICAgICAgICAgICBh
bWRncHVfYW1ka2ZkX3Bvc3RfcmVzZXQodG1wX2FkZXYpOw0KPiAgDQo+ICAJCS8qIGtmZF9wb3N0
X3Jlc2V0IHdpbGwgZG8gbm90aGluZyBpZiBrZmQgZGV2aWNlIGlzIG5vdCBpbml0aWFsaXplZCwN
Cg==
