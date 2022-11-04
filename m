Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F6AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F55810E71F;
	Fri,  4 Nov 2022 09:35:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399D310E71F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu4MI/6uUeV0XDbeJltKfvmA4w/FPof6z9NQDwga753QTawg33mllotv5RmrX2SkNP7Uk2PtF2stQ5XV69JJCq6EBkcVxGluvTNwf7Dd0wgQ7wM66KphdSpSsyJ3vyjNDx3cmEO3H+ASpGdTrs4Qn8rIDTB6celzcTgVHljl5mLCaTyKJBtJnO5WT9jkP6jfsyUIEZHWxXNBd1K1ni2pZaeHOeZG09Dh84uxr+vFshyXO7NRY6PrNFQa9viVH1uM/fq9sUXlq+JVp9afCZcfGproc+JBx0pG68Yw4qFQO0A8UOMaV2S/ezUJNrRzt7wObQF1R0rnXY1DcZRg86icHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk9k7YHMUeUWkuebJ+l7uykerWksyOL0WGErUejXeuw=;
 b=f9NnXDPUtY1if/XJqNRyWazyGPDR1XRVaQwMQrbJ/5wodoCbXwrEaZ7VHvVgWsiG5UxmSjKgmXh/73DjPBrDqVTIHBQgS0AmbzaKEW0W0saOySYRmMEJbOqFIRGg0/roTP027Mm7fv556N7MaM+GXHfq/wqHqBGSfnLJsvy21pbRwvNuj8UM0HPzRtv2sZwCKys4t/Y7ZwmLfy6AGEp8OmI0gaz2k960T7MLaVBD0fP/MoTH+G4rgW0AfYFqa6Oyk539Kc4cwAHfi9j+NGgwvp8ObFIYhAFVJCFGpDemmgFqvZIgBJMRn1oz8sc69dKJJhLOfl+Jn3pe7DqjpnduxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk9k7YHMUeUWkuebJ+l7uykerWksyOL0WGErUejXeuw=;
 b=TS0eMDqGFu6foZDKwe4LY1bmrtlb/BA8hhRdUq2uuaLu8iTIxghsJI055P20vH8zsrEiyTRlFRlCRP7lCrkAk7IXC3DMEr9SazVBbA8HjsUQRkApbmC+gXYOTV/+FKsf4k1v2mhCLwL+gMAjTzd4u9LsgrphIw6IDkNFFPaeJzU=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:35:13 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::5308:d7ef:e3e7:db25]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::5308:d7ef:e3e7:db25%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 09:35:13 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
Subject: RE: [PATCH] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Thread-Topic: [PATCH] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Thread-Index: AQHY7+Tof+mdzPl2REOtBGoVqE9Gga4ufzAAgAACZVA=
Date: Fri, 4 Nov 2022 09:35:13 +0000
Message-ID: <PH0PR12MB541790C11A1EC2B318DFA1A58F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20221104003215.296666-1-Emily.Deng@amd.com>
 <87b6bd88-d747-bc3e-0ea8-b07cd4578f09@gmail.com>
In-Reply-To: <87b6bd88-d747-bc3e-0ea8-b07cd4578f09@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7daea7df-d75e-46ae-a550-a4c506d27993;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-04T09:34:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|CH2PR12MB4280:EE_
x-ms-office365-filtering-correlation-id: c6572213-3c8f-45f5-4f7a-08dabe47e001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMoEp+U2guIkgH7HUBrhC+5s/iLSdxovR0AUeXi7+8nG6NIjwdRE+totxgvAtD+TX2llE8mDS6FwYqcvDu7C+j/+CmhiSNmcilXgLkBraTxCs1+ex7qcbN7yaPh3sLU/ZD/8Kj1IymKn4FGL2XcK/j9xUueGBMxG3m7L0Pdnr/Rh+6Wxz/SEc12GDbn7mJYNcJlGMIEaW6eC64ePgb4fvpv26ARZQv9xGje82OAmR16iIyMOjQSAh6VA3Daiztz6BksVTVv76IMH6XDa1cIpWQXgxj+mZ1u3cUfpVJpJ6xtZyA0CtNSP+pLjIem10x2PMbt0/YDb3Kt7M2F0K6FcWplCP2fNOGnvzOjI70jQbAolXP3SwWOTUywTCrSntUZpQ+kLrFS/TUn5cVYGGprGDq0h0485ngYqu6nnoejha0K5DVjCHPe6B6fk6va+P7yGNT5xxKWfc/bhCx+MD8XA3FEpncv1ZgoXPHM3SR1FSa1jAyrMlrQ5oeV7IcNwJi8xzvMoerAtiVBWBU6AHOXW0J56+RZTmjNNWow83h/a2uGvRLMw6E1Xdv3D6UzPEX6Gavpyi+NnCuevrGvn2CKUdRExoMAZS/xKR/TwKiBKznC8yrWW6BIJyAVRhk4PFJ5NgLDerU/Vbk4Vz1H6GcH0kqL1yw8wVdf2BjyL0Ygc5JvhjDBXbil0RbDsQCwqu9lGy9OCT8C6vurLBDsMWDMKJK+OP8DAdImGwbQQQQLR/W+k7ub7gtpqeWLPT1a3CkoxJEfRAGu+v5CcaG98lmv3Ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(66946007)(55016003)(33656002)(76116006)(8676002)(66446008)(66556008)(71200400001)(110136005)(38100700002)(52536014)(66574015)(5660300002)(8936002)(316002)(122000001)(2906002)(64756008)(7696005)(83380400001)(26005)(9686003)(186003)(66476007)(38070700005)(6506007)(41300700001)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGdIbVFIb2ltbVc3UEQ3VGFhSGs4UmUyKzhEa3luM29sODlSOGkxRGVZaXA0?=
 =?utf-8?B?TlFha21SR09SUGQ3TXBrK0t4V0VxeE5iaDBFc2JRaFBKQmJyVHVpVzJIMW9z?=
 =?utf-8?B?S3FiU05sMzlFSllpdC8wMDhaYWI4TklML2NkcTR3MWRrTEpZSEdIRHBQNXoz?=
 =?utf-8?B?bi9oVDFaT3lKVFN0blRUNmE2WUo4eUEzY1hxdmdJWGV1NlNWQ3hvQ0R3WElY?=
 =?utf-8?B?b3FxbUNQVDRpaGo0YzdvQjA1TEtUL1o1WlBOelBsR2E0c0RWc2Y4Qk15NDE2?=
 =?utf-8?B?NVpNOVZtRWJqNnVqMTJrSnJhVzFVOWFZdlFDKytoMWRhM2JRMUxJR0ZGOWxC?=
 =?utf-8?B?VzlYVW9pNDhQMVZCUU1OajV0NEZIQWtuaUZmUHlyRFUrMHpyV2lWQU1uMEpF?=
 =?utf-8?B?SGJPbWYzRmV6djU4TVRsalJ0S1NZSjdCUlh5a01aRG83aTM2YzRGa1dNNVh0?=
 =?utf-8?B?QjZlK1RHMGNZV1hpVkJOTkd2UFNjQm1TUi9ncWt3S0hzSnVLWlpnT2dTZTRI?=
 =?utf-8?B?UzdIUzU5d1NGalVNcmxQVDRaZnhvazRMajhIWVpGQUhoUWROWTRZL3dUOVNH?=
 =?utf-8?B?U2ttYzRJZnFiMWlSNXNqUCsvYTBEWDB5bG9lWnhLMmxJUlZOcVdZMnAvSG1i?=
 =?utf-8?B?WEZQWTNvbUN6VlFUa0dqS09Fek1QRXlBUkk5ZmFqTDhmZkNjbjVvaFlYalky?=
 =?utf-8?B?VERicUMwRVUvVTFNbmkrQ0JnSmFzOWQzTUdiQnpldGhsTUlhVUtVbTYxYng5?=
 =?utf-8?B?aHdiU085SHM1N24zV3dvRlJYc1QxWFdNaFdmUEZOakRpcERIaGswK09TMndn?=
 =?utf-8?B?N2JiRm5vTVRGOXp1TjVVYUdjN2ZMRzBoZWxaRUFOZUtiQ2piREhUbGk2TE1q?=
 =?utf-8?B?c3JoSitOV1E1WWp6UG1tYk1kc3Rjd3VLYU9FQW5SOG1JOWJCOThCVVNIZDM5?=
 =?utf-8?B?T0d3SjA1RFRkaE5aS1FGVVhtcHlaRTFsMnpJV01KeE9GaGdTNmo0TmxReG42?=
 =?utf-8?B?VER1L3RTYmpsaEdZWldmUjZOTVJCMm5oc1pubUZ4QlpmdURma0hJWEZnSUo5?=
 =?utf-8?B?K2djdW12bXRlZG5nTHo3VEw1T0gvcFNsSHJNV0dYQ05UYmNHVHRVT0hvQTZM?=
 =?utf-8?B?MWFCMGdmbkxrTkxKbGJaSnRrWS9OMzQxMEN1SXFGRlkvbXN3b0tvZkwvbFRG?=
 =?utf-8?B?NUozQkt2dTFRa1draGNpZi9GNEhPb0licjYyUmEzSi9SQTk4M2gvWEozc3E5?=
 =?utf-8?B?a2dkaGlZdU1KSW9seUhsbGRxdTl6TUVQRmRMaXFFVEx0Zldpa1drQ1VHVUFR?=
 =?utf-8?B?eDBSbUpoSnBrSFh0bmhURFlPMXNQUFNBckt2VVFpYW1Kcjl4bWpiMFdEdHE3?=
 =?utf-8?B?cTFNTUFmRjVJaE1sZWowai92TmRDQzlRK1JOMjFCMi9RTGdQbzFhbTU5Rjdk?=
 =?utf-8?B?Y1ZTa0FEYllRcVlrMnJ2cWtuQmdIQXVXZ1ZzR3ZQeTUyNjdXWllIZnFicTFr?=
 =?utf-8?B?SUh2RVFTY3B6RWsycC9vOVhqR3hqN2gxaWgzOVFjNUF0eFFUNWp1YXU5SE13?=
 =?utf-8?B?MjZVT2VqUHRTSXRkdy9WODdPWURQWDNvTWNtT2w2eVE5OVI4ZmNOdXZEdDI0?=
 =?utf-8?B?WXNGTDZISXArSFR6Zm02MmpNRUhUajFaTUlQczRJR0F6RXI0cEEvUFVnTlFJ?=
 =?utf-8?B?SytweFU0WFBhUGxYaVBWektOYUQ0SFA1Ymx1TEc1UlFaY2o3bkRxS1lSNnpo?=
 =?utf-8?B?eWVZaFN2TWZtdUkwYmpJWnE0NENTS3ZRWUNSeHBRSzJGdG85Wkxib2VyRm9v?=
 =?utf-8?B?Z0RFTHp3N3NiTXBjOTRNZHN4a043ZzJleDdDbndCS2dVMmFzWHZmNVhlVEoz?=
 =?utf-8?B?WnV5QU1TdnNLME05MjlLTDNlV2Jubk50Mm1kSTVJMzNqMG5SQU5wS2N3S21w?=
 =?utf-8?B?cU5xRHNNc1B4MHI2Q2U2cm5BeFU3MytjUUNLZFlOS2l2WHdmakdWWWs5TVV0?=
 =?utf-8?B?L2F2bk1nZFRXMHZnWnFEeDNueGVoWWxjN0tjeEZQK20waWVFTnBwdzNxQTlm?=
 =?utf-8?B?Ump5TEwrdFFCd0N0M1dnRVNKY2w1dDE4YkN4elNCV2g3Ui9mSnNxZE4rUVRX?=
 =?utf-8?Q?Zh0U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6572213-3c8f-45f5-4f7a-08dabe47e001
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 09:35:13.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibc88Jr6AftC4Npr1F5w8E0T9A9A+mXK8507D2a/8kBJCrj/+dJoxeqN7MxMHylS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5A
Z21haWwuY29tPg0KPlNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNCwgMjAyMiA1OjI2IFBNDQo+VG86
IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsNCj5NaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0Pg0KPlN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBFbmFibGUgZ2Z4IHBpcGUxIGFuZCBmaXggcmVs
YXRlZA0KPmlzc3Vlcw0KPg0KPkFtIDA0LjExLjIyIHVtIDAxOjMyIHNjaHJpZWIgRW1pbHkgRGVu
ZzoNCj4+IFN0YXJ0aW5nIGZyb20gU0lFTk5BIENJQ0hMSUQgYXNpYyBzdXBwb3J0cyB0d28gZ2Z4
IHBpcGVzLCBlbmFibGluZyB0d28NCj4+IGdyYXBoaWNzIHF1ZXVlcyBmb3IgcGVyZm9ybWFuY2Ug
Y29uY2Vybi4NCj4NCj5XaXRoIHRoZSBwcmludGsgc3RpbGwgaW4gdGhlIHBhdGNoIEkgYXNzdW1l
IHRoYXQgdGhpcyBpcyBqdXN0IGEgZGVidWdnaW5nIHBhdGNoPw0KPg0KU29ycnksIHdpbGwgZGVs
ZXRlIGl0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1k
LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4
LmMgfCAgMiArLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyAg
fCA0MyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMNCj4+IGluZGV4IDMzMWFhMTkxOTEwYy4uMDA3MmYzNmI0
NGQxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMNCj4+
IEBAIC0zMyw3ICszMyw3IEBADQo+PiAgICAgIGNvbnRhaW5lcl9vZigoZSksIHN0cnVjdCBhbWRn
cHVfY3R4X2VudGl0eSwgZW50aXR5KQ0KPj4NCj4+ICAgY29uc3QgdW5zaWduZWQgaW50IGFtZGdw
dV9jdHhfbnVtX2VudGl0aWVzW0FNREdQVV9IV19JUF9OVU1dID0gew0KPj4gLSAgICBbQU1ER1BV
X0hXX0lQX0dGWF0gICAgICA9ICAgICAgIDEsDQo+PiArICAgIFtBTURHUFVfSFdfSVBfR0ZYXSAg
ICAgID0gICAgICAgMiwNCj4NCj5UaGF0J3MgYW4gYWJzb2x1dGVseSBjbGVhciBOQUsgYW5kIGFz
IGZhciBhcyBJIGNhbiBzZWUgYWxzbyB1bm5lY2Vzc2FyeS4NCj4NCj5XZSBkb24ndCB3YW50IHRv
IGV4cG9zZSB0aGUgR0ZYIHF1ZXVlcyBhcyBzZXBhcmF0ZSBxdWV1ZXMgdG8gdXNlcnNwYWNlLg0K
Pg0KPkluc3RlYWQgdGhlIHF1ZXVlcyBoYXZlIHNlcGFyYXRlIHByaW9yaXRpZXMgd2hpY2ggdXNl
cnNwYWNlIGNhbiBzZWxlY3QuDQo+DQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQo+DQo+PiAgICAg
IFtBTURHUFVfSFdfSVBfQ09NUFVURV0gID0gICAgICAgNCwNCj4+ICAgICAgW0FNREdQVV9IV19J
UF9ETUFdICAgICAgPSAgICAgICAyLA0KPj4gICAgICBbQU1ER1BVX0hXX0lQX1VWRF0gICAgICA9
ICAgICAgIDEsDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4+
IGluZGV4IDQ5ZDM0YzdiYmYyMC4uOTIxOWNkMjlhY2QzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+PiBAQCAtNDYwNiw3ICs0NjA2LDcgQEAgc3RhdGlj
IGludCBnZnhfdjEwXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpDQo+PiAgICAgIGNhc2UgSVBfVkVS
U0lPTigxMCwgMywgMyk6DQo+PiAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMywgNyk6DQo+PiAg
ICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lLm51bV9tZSA9IDE7DQo+PiAtICAgICAgICAgICAgYWRl
di0+Z2Z4Lm1lLm51bV9waXBlX3Blcl9tZSA9IDE7DQo+PiArICAgICAgICAgICAgYWRldi0+Z2Z4
Lm1lLm51bV9waXBlX3Blcl9tZSA9IDI7DQo+PiAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lLm51
bV9xdWV1ZV9wZXJfcGlwZSA9IDE7DQo+PiAgICAgICAgICAgICAgYWRldi0+Z2Z4Lm1lYy5udW1f
bWVjID0gMjsNCj4+ICAgICAgICAgICAgICBhZGV2LT5nZngubWVjLm51bV9waXBlX3Blcl9tZWMg
PSA0OyBAQCAtNjAwOCw2ICs2MDA4LDI1DQo+QEAgc3RhdGljDQo+PiBpbnQgZ2Z4X3YxMF8wX2Nw
X2dmeF9sb2FkX21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgICAg
cmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGludCBnZnhfdjEwXzBfd2FpdF9mb3Jf
aWRsZSh2b2lkICpoYW5kbGUpIHsNCj4+ICsgICAgdW5zaWduZWQgaTsNCj4+ICsgICAgdTMyIHRt
cDsNCj4+ICsgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKiloYW5kbGU7DQo+PiArDQo+PiArICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT51c2Vj
X3RpbWVvdXQ7IGkrKykgew0KPj4gKyAgICAgICAgICAgIC8qIHJlYWQgTUNfU1RBVFVTICovDQo+
PiArICAgICAgICAgICAgdG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUdSQk1fU1RBVFVTKSAm
DQo+PiArICAgICAgICAgICAgICAgICAgICBHUkJNX1NUQVRVU19fR1VJX0FDVElWRV9NQVNLOw0K
Pj4gKw0KPj4gKyAgICAgICAgICAgIGlmICghUkVHX0dFVF9GSUVMRCh0bXAsIEdSQk1fU1RBVFVT
LCBHVUlfQUNUSVZFKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gKyAg
ICAgICAgICAgIHVkZWxheSgxKTsNCj4+ICsgICAgfQ0KPj4gKyAgICBwcmludGsoIkVtaWx5Omdm
eF92MTBfMF93YWl0X2Zvcl9pZGxlXG4iKTsNCj4+ICsgICAgcmV0dXJuIC1FVElNRURPVVQ7DQo+
PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfc3RhcnQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgIHsNCj4+ICAgICAgc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nOw0KPj4gQEAgLTYwNjksNyArNjA4OCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2Nw
X2dmeF9zdGFydChzdHJ1Y3QNCj5hbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAgICBhbWRncHVf
cmluZ193cml0ZShyaW5nLCAweDgwMDApOw0KPj4NCj4+ICAgICAgYW1kZ3B1X3JpbmdfY29tbWl0
KHJpbmcpOw0KPj4gLQ0KPj4gKyAgICBnZnhfdjEwXzBfd2FpdF9mb3JfaWRsZShhZGV2KTsNCj4+
ICAgICAgLyogc3VibWl0IGNzIHBhY2tldCB0byBjb3B5IHN0YXRlIDAgdG8gbmV4dCBhdmFpbGFi
bGUgc3RhdGUgKi8NCj4+ICAgICAgaWYgKGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzID4gMSkgew0K
Pj4gICAgICAgICAgICAgIC8qIG1heGltdW0gc3VwcG9ydGVkIGdmeCByaW5nIGlzIDIgKi8gQEAg
LTc0MDQsMjQgKzc0MjMsNg0KPkBADQo+PiBzdGF0aWMgYm9vbCBnZnhfdjEwXzBfaXNfaWRsZSh2
b2lkICpoYW5kbGUpDQo+PiAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAgIH0NCj4+DQo+
PiAtc3RhdGljIGludCBnZnhfdjEwXzBfd2FpdF9mb3JfaWRsZSh2b2lkICpoYW5kbGUpIC17DQo+
PiAtICAgIHVuc2lnbmVkIGk7DQo+PiAtICAgIHUzMiB0bXA7DQo+PiAtICAgIHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0KPj4gLQ0K
Pj4gLSAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsNCj4+IC0g
ICAgICAgICAgICAvKiByZWFkIE1DX1NUQVRVUyAqLw0KPj4gLSAgICAgICAgICAgIHRtcCA9IFJS
RUczMl9TT0MxNShHQywgMCwgbW1HUkJNX1NUQVRVUykgJg0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgR1JCTV9TVEFUVVNfX0dVSV9BQ1RJVkVfTUFTSzsNCj4+IC0NCj4+IC0gICAgICAgICAgICBp
ZiAoIVJFR19HRVRfRklFTEQodG1wLCBHUkJNX1NUQVRVUywgR1VJX0FDVElWRSkpDQo+PiAtICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+IC0gICAgICAgICAgICB1ZGVsYXkoMSk7DQo+
PiAtICAgIH0NCj4+IC0gICAgcmV0dXJuIC1FVElNRURPVVQ7DQo+PiAtfQ0KPj4gLQ0KPj4gICBz
dGF0aWMgaW50IGdmeF92MTBfMF9zb2Z0X3Jlc2V0KHZvaWQgKmhhbmRsZSkNCj4+ICAgew0KPj4g
ICAgICB1MzIgZ3JibV9zb2Z0X3Jlc2V0ID0gMDsNCj4+IEBAIC04NDY2LDcgKzg0NjcsNyBAQCBz
dGF0aWMgdm9pZCBnZnhfdjEwXzBfcmluZ19lbWl0X2hkcF9mbHVzaChzdHJ1Y3QNCj5hbWRncHVf
cmluZyAqcmluZykNCj4+ICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICAgICAgcmVnX21lbV9l
bmdpbmUgPSAwOw0KPj4gICAgICB9IGVsc2Ugew0KPj4gLSAgICAgICAgICAgIHJlZl9hbmRfbWFz
ayA9IG5iaW9faGZfcmVnLT5yZWZfYW5kX21hc2tfY3AwOw0KPj4gKyAgICAgICAgICAgIHJlZl9h
bmRfbWFzayA9IG5iaW9faGZfcmVnLT5yZWZfYW5kX21hc2tfY3AwIDw8IHJpbmctDQo+PnBpcGU7
DQo+PiAgICAgICAgICAgICAgcmVnX21lbV9lbmdpbmUgPSAxOyAvKiBwZnAgKi8NCj4+ICAgICAg
fQ0KPj4NCg0K
