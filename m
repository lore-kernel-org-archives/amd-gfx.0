Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128B1C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 01:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05A310E2AB;
	Wed, 16 Aug 2023 01:02:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36DF10E2AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 01:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTajRBOuxj+FQ3NB/xoM4qQQDIqYtmKZuCO5zPQcEcB9ucoka/mhtNt/QRdOoPKpC2MOY9CgpooN8lBCWm3UX2hUshSZr6522+IYfuVh6+jl2OXx4IEbqYaJQcmu0up04VcqHH7BNi+ZTDFWwD7wZVC8A3EEoTrPgExW8Nrhsu+TuOmnYv0bItQJzXiZKPO1+nOBzaVzQqn72pd4z9TcKlFjc4J7sIzcwQRmiJicj5s4vDC5UmyaG9xjXmj27OdLim2+3xDCxb2lxv+xiYfdlRCARDz2F6ghZwiHULTop4Yu0Pt/WurVxCyoDRhZRwg8qi4UhFmEezrvqkGzCD0+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjXFLycp39M24DlGJ7/ltQAZNoBBpT3LucXtqaTE1D8=;
 b=VrrJQTGd5ppsOKYl/2/gVfUMONfFN8AsLJHBWm0rsPxPkvgTPfh1hL45QeSldB0pTcM6nemHigYhbWN5/qSAoJx+Z+NHHgTcE7nu7i98+/qm4vqeH2A0r5/3p6bNRnsGBe2KGYHSx6DB7lnTngnnk4iQ6fpj7TXLzB4GB4i9zGDDJgPA+TVunevryOg6fhmy8I10B9PWhoZI7UdLcR7PGN4kDF44lr8NRw9zCUikmrdSjx0shSuJfA1U4A+Z+/cJOgJbu81VUE6GXySo8cEXxN7evncw8TXErkGH80X/XG9qXWoId8rkrprI4yUwPTmEHYoxJ/6IkGRP+/pN9yBf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjXFLycp39M24DlGJ7/ltQAZNoBBpT3LucXtqaTE1D8=;
 b=JOk9C1z6cDwsTG03crmPFlg5t8+j8gqdc67YgbIkt0GXQvPONh/ViaQX6a6rHtZe7p16qznhS2BtTEWxo2JQg8aWf7cdD6aOLBzDUK1jkgNb8Kjd4/H9I8+cjDe/HuUhq2B+f/JE2m+84f3aXFyo1/fQcEFvXb+IdergQXje07Y=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:02:10 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:02:10 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: allow the user to force BACO on smu v13.0.0/7
Thread-Topic: [PATCH] drm/amd/pm: allow the user to force BACO on smu v13.0.0/7
Thread-Index: AQHZz1Z+fYF17H7SdUWcMfAC4xA9Nq/rlCOAgACGPtA=
Date: Wed, 16 Aug 2023 01:02:10 +0000
Message-ID: <DM4PR12MB5165F86B0A31F1084FF5FC068E15A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230815085710.842188-1-kenneth.feng@amd.com>
 <CADnq5_N6436Mdqz+V4er+=VFm=6O_C=i5T3R2+Nkc_eqh8uZLw@mail.gmail.com>
In-Reply-To: <CADnq5_N6436Mdqz+V4er+=VFm=6O_C=i5T3R2+Nkc_eqh8uZLw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3b68387f-3c0e-4ee6-9ba8-367c66769a51;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-16T00:56:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW4PR12MB7192:EE_
x-ms-office365-filtering-correlation-id: d99bf5bb-319a-46fb-44da-08db9df46b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSkximSlUaV9vkfaKdz2D0nEzPeQoiuGdvl5SiZucnexTM9ypAAzPkMXfBYqyHE/W7F0Hum3x2YWi1/RQekhwHS4DESwLvQyrSOLZ64CMcQjggBtF//cNFTG7wwHooMqbGBrCueDGLBjBWEDRqJFOxC3LflukHHaBbmLkAy1Nc8FW66o/koIjtIOWaUQQQ72DjlteEHU4b0fJTnVxHEBy5TggQ0eB9Q9qUlwVCuja77Os1kLHbFHwknxmEaPR7UBQGSGZpWCPLMo5lOqTGDDaUC5Y/xg9VgYry0hUwImAknbJdfCYet8HqFwNp2RuTKwEHAz1ua5xgElPNThfbO6WMb1/uwbzijoJl5wc9rIARMIY+DKw65G5dhh48099tfuIoSbMXVYPIxBb6nRFPMYn+RVwkR+PigCWxNnYbZf+jCzqvAtUqcBa/sco8h710ScqrPbG4ZVg7Oc0zUhMZSyiahSHxszNWFbERzS3jOur4du0z+YhbBFct0/A0Ck5tKetziyr5XJ8h3mVSYhSXYcfbEanhRYQQlLkbeadKqABK/9p721p5ATGyp7eK5Xmy3UAm1unXp3fx0N94gqWjqYIv6t68gGesO5YhsG5KZqg5i7HOs33yahCuqO4pFi9dKK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199024)(186009)(1800799009)(6916009)(4326008)(122000001)(52536014)(76116006)(38070700005)(38100700002)(26005)(316002)(5660300002)(2906002)(83380400001)(66946007)(66556008)(66446008)(8676002)(66476007)(64756008)(53546011)(86362001)(478600001)(8936002)(33656002)(41300700001)(6506007)(9686003)(7696005)(71200400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZzMDJuYzE5L3JmMTBKZkpsWmhOV1B2Sm9HNTU3eTlJK3ZpNUFRZEhOUTBG?=
 =?utf-8?B?MmllbFFqeG82N2JaaGFLMFV1OWFWeWMrcndVZ1FNR0hRSDgrYWJGdDdrbEhw?=
 =?utf-8?B?bEpvLytyVFd6VFBZQ2pZY0N6bjl3Zy9CUlZBZEV4QzNobDdmWnp6WVczeEJL?=
 =?utf-8?B?c3NRVWF5VTBhYUdVMkFod1pva0pQNFZTaEltdU1mQ1JGQ3ozZ0Zzb1hiK2VI?=
 =?utf-8?B?TEh4UlNNUklBcERUaTVZR2gxQnl1MmppQlU4RUhiTHk1RU9LV3BrcVdJU2tS?=
 =?utf-8?B?K2hKUm5iV0dSdWl0TWNZaTl6YSs0ckhGWnFwdUVhUFdaeTY1c0JMV2M5Smo3?=
 =?utf-8?B?aHpBZmRpWXQ3NVhUTmY1eXBvUE1YWHNqRUVEdmNIV214WGhObUpjcEg4NXNT?=
 =?utf-8?B?Rnk2NWdNOHV3NmsvZlhiWmNKcDE4cys1RkZRTzhuM3VCWEpiNXU4bDlBMzgw?=
 =?utf-8?B?d2xBMTFiczRyRWZoV3VCenh5eCtUYzUxSFlFK1cxK1Nrb3QrU1ppUFhkMUhV?=
 =?utf-8?B?bGxnVVVQbkNTaW9FWXlFL0lHOUZPN1dVTGNCbUI1emtxZVJiMHBveS9xYWY2?=
 =?utf-8?B?VHp5cm82Qy9tUXpqRmMvZ3NybTdJMHhBNjBVeVhveVVKMmlzYm0vTXBhb3NG?=
 =?utf-8?B?SzM3RWhRZ3hOV3Q4YStvYlJ1a0hYVWl0ZmdDSDl2OHZQajRBbzF1bUxiMDBK?=
 =?utf-8?B?V1RXc2NFZE91cDBaSWNNQUtGc0JsRDdMV3pNdERCdXYrYWFwci9aQWswZ21y?=
 =?utf-8?B?cFcrT1JUWUE4eGJsRXhadTJGcHhqbC9jdjE5VmdpTlUzNiswZHUxS0kxdVhh?=
 =?utf-8?B?bDFpdCs2a2VQSDg3OUF1R3JLRG02SHFUVmI1YlRXTS91dndpdTRaem1VUkhP?=
 =?utf-8?B?dWNLczV6NDYrcVdCa1hXMkdoYXhOSlIwZDgxN3JJelJyaFpRaVJFOEVOZ01l?=
 =?utf-8?B?cFA5cDV4N2RTOSsxTWdMKzZidldXdHhpY2VEbWRnb0NuNHVzdXJITDFLTU9x?=
 =?utf-8?B?VlFNd0ZqQ2plTGhwVlozMk91YjRNV21ib3VKeWw3eXJ0WitCdU8zZ0l1Q3BO?=
 =?utf-8?B?M2hVVnd4cDQ3WXhBQlFCMUluRS9wWVdha01UaSsxaU53YTRGdmY1dkhxbjVN?=
 =?utf-8?B?WVBLbDhoTFVNclJCbWlrai9XazBIbWNKWTJ5eHFTT2xSR1g3NmxnWW9kYjR0?=
 =?utf-8?B?TEoyc3NIWHR3TU4vQTJTQ0pCbkZiT0dHRDRpSXhaNW83ZFMvTEdtTitzL1Ey?=
 =?utf-8?B?WTZpd1VzTHRBZ1JuYVZON0RWeHpRZllKTkI1K056T0txeW9VeWcxNjVjNlJp?=
 =?utf-8?B?cXVkVGxPY09ZWGpxL1Nkc0VBdXA1WitoWUs4Nm5iZ1FyZ0F4WUVrSEVRQUhX?=
 =?utf-8?B?YTV3ZGdCYW9PSUNiOFV6Y1JKdit4ZFFwaGIreDBWYXNLaDcyOGVhYzY0d2xZ?=
 =?utf-8?B?K2NGTUF4Q28xQUxLcnBKdnd5SHlRb01jblJqcnNTdDZiQklyU1RsNlU4TDMr?=
 =?utf-8?B?cWxyOWJpQkUyMk5Vdk9KcS9ITFhRenVsNlJud1RJcVFUUXdvU215MnNUaENK?=
 =?utf-8?B?dmVqNm5hSTMzQ0RkU3F2blVmcThZUk81WGtXU2pCaUErN0gyVXhMU3JFZ3NJ?=
 =?utf-8?B?bi9FdFJMenROTENuQW1RakpUeUhyeERQSU5UK2FidlUySnloaFYyYUhBV0hM?=
 =?utf-8?B?bGI2aFJ3RGlnMnZQWnBhaVRMc2pJQTJrdStBZnJPM1BhbTlEU3phbXhvOWxm?=
 =?utf-8?B?YW5EcWphZjVWMWxpaXFOV2kxb0ZjK0JHOWNnbnIzaGMvaUJlaWJaV0RaTmxD?=
 =?utf-8?B?UG1jOW1LMkU1MDh0d0ZqRzdtbUNRVGkrOXF5c0Q2SDI1MEpqaW5laVR0TkYx?=
 =?utf-8?B?SmxxNFFSWEJKYlEvWlEzOExyS2NCSVlKS210SFlwQUZ3NkRBZkhCd0hxOTBN?=
 =?utf-8?B?VVdhbmtDcE02bFJiRFh2YXMray9IV1dPL0dDdzdzZFVxcjAyZ0FSNVdCT1JH?=
 =?utf-8?B?MzZKUlNyTVI3TzZwYTZta3gzUzA0S1V2KzhjWGdncWxOSm83YmRzVmh4RkVX?=
 =?utf-8?B?SnBDdnR5Mm1tOWxYNVVxWTU0UTZDdU9qa0NUVW5CY0dsbDRIMGFSZ01GRWRj?=
 =?utf-8?Q?5+Ys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99bf5bb-319a-46fb-44da-08db9df46b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 01:02:10.0955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WP6Y37msaz5SiRAzSGkbtgRNprOdWxYRojYKvighOx0q0t4sYMhk13Xdrv3Or1Jk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQpSaWdodCwganVz
dCBCQU1BQ08gaGFzIGl0cyBhZHZhbnRhZ2UgZm9yIHRoZSBmYXN0IHJlc3VtZS4NCk1heWJlIGxh
dGVyIHdlIGNhbiBmdXJ0aGVyIGlkZW50aWZ5IHdoaWNoIHNrdSBuZWVkcyB0byBzYXZlIG1vcmUg
cG93ZXIgdnMgZmFzdGVyIHJlc3VtZSB0aW1lLg0KRm9yIGV4YW1wbGUsIG1vYmlsZSBkZXZpY2Ug
Y2FuIGJ5IGRlZmF1bHQgdXNlIEJBQ08gYW5kIGRlc2t0b3Avd29ya3N0YXRpb24gZGV2aWNlIGNh
biBieSBkZWZhdWx0IHVzZSBCQU1BQ08uDQpUaGFua3MuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2Vu
dDogV2VkbmVzZGF5LCBBdWd1c3QgMTYsIDIwMjMgMTI6NTYgQU0NClRvOiBGZW5nLCBLZW5uZXRo
IDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9wbTogYWxsb3cgdGhlIHVzZXIgdG8gZm9y
Y2UgQkFDTyBvbiBzbXUgdjEzLjAuMC83DQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpPbiBU
dWUsIEF1ZyAxNSwgMjAyMyBhdCA1OjA14oCvQU0gS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdA
YW1kLmNvbT4gd3JvdGU6DQo+DQo+IGFsbG93IHRoZSB1c2VyIHRvIGZvcmNlIEJBQ08gb24gc211
IHYxMy4wLjAvNw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVu
Z0BhbWQuY29tPg0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gZGVmYXVsdCB0byBCQUNPPyAgSXQgd291bGQg
c2F2ZSBtb3JlIHBvd2VyIGF0IHRoZSBleHBlbnNlIG9mIHJlc3VtZSBsYXRlbmN5Lg0KDQpBbGV4
DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3Yx
M18wLmMgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L3NtdV92MTNfMF8wX3BwdC5jIHwgMyArKy0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyB8IDMgKystDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQo+IGluZGV4IDg5NWNkYThlNjkzNC4u
NTJlOWM3NjExMDEzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL3NtdV92MTNfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvc211X3YxM18wLmMNCj4gQEAgLTIyNjMsNyArMjI2Myw3IEBAIGludCBzbXVfdjEzXzBf
YmFjb19zZXRfc3RhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgICAgaWYgKHN0
YXRlID09IFNNVV9CQUNPX1NUQVRFX0VOVEVSKSB7DQo+ICAgICAgICAgICAgICAgICByZXQgPSBz
bXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU01VX01TR19FbnRlckJhY28sDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNt
dV9iYWNvLT5tYWNvX3N1cHBvcnQgPw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoc211X2JhY28tPm1hY29fc3VwcG9ydCAmJiBhbWRncHVf
cnVudGltZV9wbSAhPSAxKSA/DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEJBQ09fU0VRX0JBTUFDTyA6IEJBQ09fU0VRX0JBQ08sDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwp
Ow0KPiAgICAgICAgIH0gZWxzZSB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiBpbmRleCBhNTg1N2FjZWU2NDEu
LjEyY2NjMTI2NTdkNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+IEBAIC0yMjExLDcgKzIyMTEsOCBAQCBz
dGF0aWMgaW50IHNtdV92MTNfMF8wX2JhY29fZW50ZXIoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpz
bXUpDQo+DQo+ICAgICAgICAgaWYgKGFkZXYtPmluX3J1bnBtICYmIHNtdV9jbW5faXNfYXVkaW9f
ZnVuY19lbmFibGVkKGFkZXYpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHNtdV92MTNfMF9i
YWNvX3NldF9hcm1kM19zZXF1ZW5jZShzbXUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc211X2JhY28tPm1hY29fc3VwcG9ydCA/IEJBQ09fU0VRX0JBTUFDTyA6IEJBQ09fU0VR
X0JBQ08pOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzbXVfYmFjby0+bWFj
b19zdXBwb3J0ICYmIGFtZGdwdV9ydW50aW1lX3BtICE9IDEpID8NCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEJBQ09fU0VRX0JBTUFDTyA6DQo+ICsgQkFDT19TRVFf
QkFDTyk7DQo+ICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHNtdV92MTNf
MF9iYWNvX2VudGVyKHNtdSk7ICB9IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiBpbmRleCA5M2IzZThmYTgyMzgu
LmYwYmNjNzk5NTk4MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQo+IEBAIC0yMTM5LDcgKzIxMzksOCBAQCBz
dGF0aWMgaW50IHNtdV92MTNfMF83X2JhY29fZW50ZXIoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpz
bXUpDQo+DQo+ICAgICAgICAgaWYgKGFkZXYtPmluX3J1bnBtICYmIHNtdV9jbW5faXNfYXVkaW9f
ZnVuY19lbmFibGVkKGFkZXYpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHNtdV92MTNfMF9i
YWNvX3NldF9hcm1kM19zZXF1ZW5jZShzbXUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc211X2JhY28tPm1hY29fc3VwcG9ydCA/IEJBQ09fU0VRX0JBTUFDTyA6IEJBQ09fU0VR
X0JBQ08pOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzbXVfYmFjby0+bWFj
b19zdXBwb3J0ICYmIGFtZGdwdV9ydW50aW1lX3BtICE9IDEpID8NCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEJBQ09fU0VRX0JBTUFDTyA6DQo+ICsgQkFDT19TRVFf
QkFDTyk7DQo+ICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHNtdV92MTNf
MF9iYWNvX2VudGVyKHNtdSk7ICB9DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
