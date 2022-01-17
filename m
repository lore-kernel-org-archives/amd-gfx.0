Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 10:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F3D10E273;
	Mon, 17 Jan 2022 10:01:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF8010E273
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8w1Arrg4/Lwa+cnwMaadLCk1W8g1Zq1wc4M5cP4Otr56okxZCvsRe/i0BXfikL4VTIjknuh5pVQ38OyT+pHaDr1g9LrYVH1GySFbHOczqtRmxcW6WGaRuEUb5BPjw0w2AWMV0cmQBd4ZDhfJ5+TE2U4J8O9lNQTAhJGBEB6B+oB2vxxxy/3NPysz49ZSQ7Uhv15AnUIAGp58ISQ+S7tSGy/C+JFe8xQKzy9zSJt8utSLBPFHkBASprj1n4hv7AWIItO2w1XWmcplqXCklx+4sXLbhaLBne0FyffGEzu+SvwAedI1rrgJUE8piK5nHPCkRMIZUeJvw4YNpUDeCW60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAM9tEg13mhKLFmfkHjhnfKVEyDxVfPASDLjoslwa7c=;
 b=mtwv/+sScJ7NHR4GeFTeJHFGM4HBYNHy4MigZpiFPsYYfZqb7QCS+S9hcn9tnlNpqzmpFAQ+QfJKmy455zUSuii4pezrPJQe1kLcwRKfl73uxNjTghBHjEARtmugYTdLdLYn/e36eWVl4WyY/nV4k1A0ngxduopf0S21UnFMP3546NH22KK2HW6+bhivcOWuV5iWtXB3Nw20ElCcW7tUPMu43cl0DTopxWPM9Kg5tu7K9vBU1ORFCIKV/4ltQDmz/jGW/d2dPNu18FUed9BjcMfjkXwpJvmF5v2ZfWYzCiyHYhZsVOMQQcz+UF6aN5/8WFFTYm0PBV9HR5l47AWv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAM9tEg13mhKLFmfkHjhnfKVEyDxVfPASDLjoslwa7c=;
 b=LNUWdeySh+HUvtthFGbFY686JWn6NSFb624na/UKiQBZiZZxOPzL4kYX+fS54zsSMy1yVGMYCRKDDgIETZl2YknSyxoWqBSIdkhLuir8jnhsUrwHF5yhDrf2h5sHPSAI9gerur30HsR9bqoa4wBZRPEFtJ4ulJil+2Uuq+h/u/o=
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by CH2PR12MB4023.namprd12.prod.outlook.com (2603:10b6:610:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 10:01:11 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 10:01:11 +0000
From: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Thread-Topic: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Thread-Index: AQHYC2w+rfMcQPxVFkGtUB910RQ1vqxm0HAAgAAqRGA=
Date: Mon, 17 Jan 2022 10:01:11 +0000
Message-ID: <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
In-Reply-To: <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-17T10:01:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=763f0294-13cb-4011-a421-f7d14f24d209;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-17T10:01:04Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 71ae82e6-99cd-4c39-b98b-8997e80053c0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81320e30-c69c-4527-b5c8-08d9d9a04a38
x-ms-traffictypediagnostic: CH2PR12MB4023:EE_
x-microsoft-antispam-prvs: <CH2PR12MB402324C06CFE9F10E53E7918F8579@CH2PR12MB4023.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BlpVFk/qod2+WB3ZZb9dBE++Uk9b9iEMlrn5XqPKLPHJ1vR5ku3BeANgaUzi07gD7anKCDn7cvzzemfW6Y85XeaqADbggkI6zwJbq2YvLi9EnnelwykpCfhgQcUk8d6TtTXq5MFSVlquaJadYcX63zEG/J7t49bwH+LB6awDUnXMEERP/OAwc9JDGgdZg1kDXGeXyo8OjCpeUeMe8l/3IRHETRAZp3Pq5LHXjUJG8uXNbV8td2Rn+72MIuSQqhVrxPBih51oxLRQkjuEOpjjMAaEA8AApOCGk75ogbMyA+lH3x9Md2ab7GccaMt0EKtGiZ70VOWow3d3+Y5AtbMk/VW207jgyaXGz2nmSQmdAwIIuiF0UXq6evWhAEmuDzL9fUVtoAw1As76CHhHaOEBFJ/o4xQVhUsb/0/TZ1aB/wdZiJb05FoTznZ4RatICI4I6mTEPkcBPMxO+rW/jGH0cFW3lLhEwtKwiQ5ONzZaQfwgu3/P+YrO9Fe72wQl5wMTljmElfFG3VVwsq7+S8xdJwTej2U0geR+Sy/pibp2X0UdyNJyRmjs15ZRdCj8gD2LO0mz8V5xbJMF84W2kfKzksahoDkqVfFz+RpytKzLHjExBi5ksNS7eFamQNDIxGwCc3V4sBZTGhgF+r34mt0gbH+sANrnpmqQC+gGgMw4WJ/DdmkG3/KtQz53GMrM4ONs+P88holoYpmnmJBsOsYGSZIsAoGcXkyuJZLqKEB/tbpBGzkIfOJCIEFJsF2rxGjW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(66446008)(66556008)(122000001)(71200400001)(55016003)(9686003)(4326008)(7696005)(54906003)(316002)(38100700002)(110136005)(2906002)(5660300002)(66476007)(6506007)(53546011)(86362001)(26005)(508600001)(76116006)(38070700005)(33656002)(8936002)(83380400001)(8676002)(66946007)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVCMS8wem1CTEF6UnhmNUtJTVhkZGtjTTYzNWh0bU9tc2ZycHVDdXRsMjYx?=
 =?utf-8?B?VnJqTlJiaG1ZMWJRTU9QZVRaeFZOUXlXcVE2Uitpc0RKZGdjMUNTSWRDQnB6?=
 =?utf-8?B?a0VuemJHb0trcjJyZzJoTDZFV2VJUnJlMmt3T05LTzdDM3ZydDB0dFU2WlRE?=
 =?utf-8?B?SmZOUVd3ZTA5MXA5Zjd1Um9NeWdaMmRYY2lGVTdMSmpUZm56TDhqUmVUYXFj?=
 =?utf-8?B?dG85dVF0cmFycDBHbXl2cVV1akJUUWVyc25qaFBsS21sWEZnOUZTSmZvRXR3?=
 =?utf-8?B?c3pNb0xjMzdjM0tFRjdTaGRYL2x4T3UrbjF1MlE1ZnNiS1VmSUJjUCtqUkh5?=
 =?utf-8?B?V3ZLeUJnaFA0YXZQTGFpaEdoMnhQWWlrdkpIZGE1NnN5NUtNUHdxdTQ2Rm5Y?=
 =?utf-8?B?K1ZwVGViL0Rralh6eElWNWphSWdybFNmL2lML0FwZnAvVVJwNStqaTJGeEtV?=
 =?utf-8?B?cG5pejRyQXU1TGZBRmcrTUs1MjUxRmVhYUwvRzg0TUxsbytnd09FWXMwdlIz?=
 =?utf-8?B?YStUVXpleTJzS0Nhc3BKQVlEaTVvUlM3MDJ2bXFUOUtjSTh4TS9xTXZlMUlh?=
 =?utf-8?B?cGRtS243bTVEYkcwL1VPM1RUais4SExnRWRVb29seTgrUWIzNSt0WUxQMUU4?=
 =?utf-8?B?Si9hZWxjUW0xcVZzdUtnV056Tlg5TW5nVldLRE9BeG5rdk9nWXo4eXQwT2Z4?=
 =?utf-8?B?eDFRUGpoTVRMV2R2Wkx2TXZqREd0TjRMbXhZcnB6ZXI2SnU1Zk41NUQ1Tjc1?=
 =?utf-8?B?eGpDbCt0M0JXaVY5bDJKN0o2eEl0cTlqVXYrTFY4VDk3RklnS2lKSVJuVzVx?=
 =?utf-8?B?VGxJTmJ2R3BrczRTZHZBcVFJZWVEbHJpMmUwSS9TdEFYbU1YcVhycGdDZVE3?=
 =?utf-8?B?WjVDSGZWSC9wNDRseDgwRHEwRDJOQnBwOWZ2UUJaUExKOEpIYWtLNTJ6R3p3?=
 =?utf-8?B?aUUxZmcvS2dKcjdrWjMvWFZvd3BtTjBTMkFmSTI4WU9iQUtqaGZQVVM0NkMv?=
 =?utf-8?B?eTBGTlorMDlsK2VRVko1NCttak11TURoS2Q0VWdkMWdmSWNKWVdQS0RxUisv?=
 =?utf-8?B?YkdvdlVzaVU1dVdPSDlwdjFlZGdFblQvYTB2L3puc3hRVlArVmM1SGZZMnJL?=
 =?utf-8?B?dFFYYWdVWDFUR0FCRUM3QnFsaWpyZXUyREl2dWw3U1cyWDBvUnExdG1qTzhy?=
 =?utf-8?B?eXlZZmYvQnNSTU4vY2I4MjZLbHJ2WktBZHlpcTIrQnM1MHRHb3d4U3oyd1pX?=
 =?utf-8?B?VkljNS9QWFRaQTJWNmRNWWh0NENjT2pwNWpxcmI5czFMUFNZUFYwaEIrWFB2?=
 =?utf-8?B?YU5ibllacEpSbjltVjNmZVZabXpKUTh3TEdvRngvd094SlpUYmpKWVIzcno3?=
 =?utf-8?B?dmRpNThsK1lNNThnMEpOMlZsWWE1UitkQUJBWXpBT2U2bDF3RkRKMTRpR05V?=
 =?utf-8?B?a2g3VU16SjdWNlZCZnZrQmpwRVJqVldLTlNWR1Q4em93d0g4V3dqNlhZS0p3?=
 =?utf-8?B?UXpFSFloQ1ZCa1c4dms3cVR3UmpwOFRob2Y3SXFwanJLaDVSQkFSdWxLUkdY?=
 =?utf-8?B?ejRrdERmaGh0ZFFaR2NrZ0VSV2t5blhzaFprMVJxMyt2Sy9wUTBrQkdoSlFa?=
 =?utf-8?B?MzRuR0tOUXg0SUE5V3VQdXVCa3VqbWRFaG50ZXViUktLWHpWSzc5TnkzUDVy?=
 =?utf-8?B?TTVBNXczZGN6L01obytEMmlEUDFqWDRnYVRRS3lLdElYdHFDcWtHWjRZQzk4?=
 =?utf-8?B?aGptVkw1ZVVHRjVGOVVVRWRxa1FpUGQ2VEE0dUJRZlZYd1NjRHlvREMyanlB?=
 =?utf-8?B?dHFXNnI3a1NxbUNxSVdSWW1FN0xWZkpyNDhIQzRDNXBSTlI2RUcxZkt0aFRR?=
 =?utf-8?B?TnBSVmRoc0pINFBZYWMvVVN2T0tMRTU3T2ZNbFN0TDJPOCtRZjZ0SlZXZzdY?=
 =?utf-8?B?MklwMGh4ellhOHFPbE11cHUyQ1JtMFp3NGQ1MVZxUXV4WkI2ckZ4aHFJVkMy?=
 =?utf-8?B?WGxuQUNVZ3FWZjVOaVNxMldiQzFTdEpiYlNENlRudHFXRGpvYzhiSEU3WVhy?=
 =?utf-8?B?NHdhZzZJSCt5ZDFOSE9tenhNUDBBWWUvVGhxb0k5UTdUbmVpYmh3UFVQV3B3?=
 =?utf-8?B?ejdEbkFTT1kxVkRNcEk2UGI0NGtjd1NGbHpTNkV5Mm9PNGtxVlNGOGZzN1hw?=
 =?utf-8?Q?hCR9+yREJCLXuW//ZHRymvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81320e30-c69c-4527-b5c8-08d9d9a04a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 10:01:11.1923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg57Z2jThImNB1XkHHS7PzbnYOzhS+GOopJUa2XswYULiVldAPj5Lph2wGAuGSwCq6FP5t8lYjy4VPRP7wfZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4023
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiANClNl
bnQ6IE1vbmRheSwgSmFudWFyeSAxNywgMjAyMiAxMjo1NyBQTQ0KVG86IFNvbWFsYXB1cmFtLCBB
bWFyYW5hdGggPEFtYXJhbmF0aC5Tb21hbGFwdXJhbUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBhZGQgQU1ER1BVUkVTRVQgdWV2ZW50
IG9uIEFNRCBHUFUgcmVzZXQNCg0KQW0gMTcuMDEuMjIgdW0gMDc6MzMgc2NocmllYiBTb21hbGFw
dXJhbSBBbWFyYW5hdGg6DQo+IEFNREdQVVJFU0VUIHVldmVudCBhZGRlZCB0byBub3RpZnkgdXNl
cnNwYWNlLCBjb2xsZWN0IGR1bXBfc3RhY2sgYW5kIA0KPiB0cmFjZQ0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTb21hbGFwdXJhbSBBbWFyYW5hdGggPEFtYXJhbmF0aC5Tb21hbGFwdXJhbUBhbWQuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgNDUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252
LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBpbmRleCAyZWMxZmZiMzZi
MWYuLmI3MzE0N2FlNDFmYiANCj4gMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L252LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KPiBA
QCAtNTI5LDEwICs1MjksNTUgQEAgbnZfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAgCX0NCj4gICB9DQo+ICAgDQo+ICsvKioNCj4gKyAqIGRybV9zeXNm
c19yZXNldF9ldmVudCAtIGdlbmVyYXRlIGEgRFJNIHVldmVudA0KPiArICogQGRldjogRFJNIGRl
dmljZQ0KPiArICoNCj4gKyAqIFNlbmQgYSB1ZXZlbnQgZm9yIHRoZSBEUk0gZGV2aWNlIHNwZWNp
ZmllZCBieSBAZGV2LiAgQ3VycmVudGx5IHdlIA0KPiArb25seQ0KPiArICogc2V0IEFNREdQVVJF
U0VUPTEgaW4gdGhlIHVldmVudCBlbnZpcm9ubWVudCwgYnV0IHRoaXMgY291bGQgYmUgDQo+ICtl
eHBhbmRlZCB0bw0KPiArICogZGVhbCB3aXRoIG90aGVyIHR5cGVzIG9mIGV2ZW50cy4NCj4gKyAq
DQo+ICsgKiBBbnkgbmV3IHVhcGkgc2hvdWxkIGJlIHVzaW5nIHRoZSANCj4gK2RybV9zeXNmc19j
b25uZWN0b3Jfc3RhdHVzX2V2ZW50KCkNCj4gKyAqIGZvciB1ZXZlbnRzIG9uIGNvbm5lY3RvciBz
dGF0dXMgY2hhbmdlLg0KPiArICovDQo+ICt2b2lkIGRybV9zeXNmc19yZXNldF9ldmVudChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2KQ0KDQpUaGlzIHNob3VsZCBwcm9iYWJseSBnbyBkaXJlY3RseSBp
bnRvIHRoZSBEUk0gc3Vic3lzdGVtLg0KDQo+ICt7DQo+ICsJY2hhciAqZXZlbnRfc3RyaW5nID0g
IkFNREdQVVJFU0VUPTEiOw0KPiArCWNoYXIgKmVudnBbMl0gPSB7IGV2ZW50X3N0cmluZywgTlVM
TCB9Ow0KPiArDQo+ICsJa29iamVjdF91ZXZlbnRfZW52KCZkZXYtPnByaW1hcnktPmtkZXYtPmtv
YmosIEtPQkpfQ0hBTkdFLCBlbnZwKTsNCg0KQXMgSSBzYWlkIHRoaXMgYXBwcm9hY2ggaXMgYSBj
bGVhciBOQUsuIFdlIGNhbid0IGFsbG9jYXRlIGFueSBtZW1vcnkgd2hlbiB3ZSBkbyBhIHJlc2V0
Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQpDYW4gSSBkbyBzb21ldGhpbmcgbGlrZSB0aGlz
Og0KDQp2b2lkIGRybV9zeXNmc19yZXNldF9ldmVudChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0K
IHsNCi0gICAgICAgY2hhciAqZXZlbnRfc3RyaW5nID0gIkFNREdQVVJFU0VUPTEiOw0KLSAgICAg
ICBjaGFyICplbnZwWzJdID0geyBldmVudF9zdHJpbmcsIE5VTEwgfTsNCisgICAgICAgY2hhciAq
KmVudnA7DQorDQorICAgICAgIGVudnAgPSBrY2FsbG9jKDIsc2l6ZW9mKGNoYXIgKiksIEdGUF9B
VE9NSUMpOw0KKyAgICAgICBlbnZwWzBdID0ga2NhbGxvYygzMCwgc2l6ZW9mKGNoYXIpLCBHRlBf
QVRPTUlDKTsNCisgICAgICAgZW52cFsxXSA9IGtjYWxsb2MoMzAsIHNpemVvZihjaGFyKSwgR0ZQ
X0FUT01JQyk7DQorDQorICAgICAgIHN0cmNweShlbnZwWzBdLCAiQU1ER1BVUkVTRVQ9MSIpOw0K
KyAgICAgICBzdHJjcHkoZW52cFsxXSwgIiIpOw0KKw0KDQogICAgICAgIGtvYmplY3RfdWV2ZW50
X2VudigmZGV2LT5wcmltYXJ5LT5rZGV2LT5rb2JqLCBLT0JKX0NIQU5HRSwgZW52cCk7DQorDQor
ICAgICAgIGtmcmVlKGVudnBbMF0pOw0KKyAgICAgICBrZnJlZShlbnZwWzFdKTsNCisgICAgICAg
a2ZyZWUoZW52cCk7DQogfQ0KDQpSZWdhcmRzLA0KUy5BbWFybmF0aA0KDQo+ICt9DQo+ICsNCj4g
K3ZvaWQgYW1kZ3B1X3Jlc2V0X2R1bXBzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+
ICsJc3RydWN0IGRybV9kZXZpY2UgKmRkZXYgPSBhZGV2X3RvX2RybShhZGV2KTsNCj4gKwlpbnQg
ciA9IDAsIGk7DQo+ICsNCj4gKwkvKiBvcmlnaW5hbCByYXZlbiBkb2Vzbid0IGhhdmUgZnVsbCBh
c2ljIHJlc2V0ICovDQo+ICsJaWYgKChhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1JBVkVO
KSAmJg0KPiArCQkhKGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNfUkFWRU4yKSkNCj4gKwkJ
cmV0dXJuOw0KPiArCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tzOyBpKyspIHsN
Cj4gKwkJaWYgKCFhZGV2LT5pcF9ibG9ja3NbaV0uc3RhdHVzLnZhbGlkKQ0KPiArCQkJY29udGlu
dWU7DQo+ICsJCWlmICghYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzLT5yZXNldF9y
ZWdfZHVtcHMpDQo+ICsJCQljb250aW51ZTsNCj4gKwkJciA9IGFkZXYtPmlwX2Jsb2Nrc1tpXS52
ZXJzaW9uLT5mdW5jcy0+cmVzZXRfcmVnX2R1bXBzKGFkZXYpOw0KPiArDQo+ICsJCWlmIChyKQ0K
PiArCQkJRFJNX0VSUk9SKCJyZXNldF9yZWdfZHVtcHMgb2YgSVAgYmxvY2sgPCVzPiBmYWlsZWQg
JWRcbiIsDQo+ICsJCQkJCWFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+bmFtZSwg
cik7DQo+ICsJfQ0KPiArDQo+ICsJZHJtX3N5c2ZzX3Jlc2V0X2V2ZW50KGRkZXYpOw0KPiArCWR1
bXBfc3RhY2soKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgbnZfYXNpY19yZXNldChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICB7DQo+ICAgCWludCByZXQgPSAwOw0KPiAgIA0K
PiArCWFtZGdwdV9yZXNldF9kdW1wcyhhZGV2KTsNCj4gICAJc3dpdGNoIChudl9hc2ljX3Jlc2V0
X21ldGhvZChhZGV2KSkgew0KPiAgIAljYXNlIEFNRF9SRVNFVF9NRVRIT0RfUENJOg0KPiAgIAkJ
ZGV2X2luZm8oYWRldi0+ZGV2LCAiUENJIHJlc2V0XG4iKTsNCg==
