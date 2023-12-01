Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D2C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 15:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EFB10E0C7;
	Fri,  1 Dec 2023 15:15:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C450B10E8B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 15:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8GfZuq0JjlQYZQf/kkNAMJQ+8utmoQy8Sim7vE/gOfOXeKXUqE0zJ8iVyJkODj4PU854oMAAQz44TlBsGpJ1ky4pgIGUJaXJSm77XsnksWnaaUWYJFXRS5fNFBRqAMUREjdU8gHamy0V1fLF7YRP99fLAcfb6etOZFuNUdDmoayc2e1LCJKQuBqBBQ6rf/L57AOTu9QmV40/fzDXoEwjCaDOTJ76N4LuQm6tHQXxiC04QndWnWiLNUor4faXNYsHej3cSpB8+T6eIRqcmpYIaAhSlcvy9KsZZ+vEYllBDlT9uz3tVdY/J1kTzLgDXTWAUNeF522CUHFMISWe0I9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IZutJti7ENAGQSqMluy0gH+tf9xpxr18XX0L3Yl2LA=;
 b=RnYM0lSkc0bVdt4BDMHPZLb/DSdsWjPL5p7cSfdDjWBJ/gqMjtAqkYrDZwdDP7DQAeiEEc/ThzS689Pd7gpj89id5S2d2OrzfNIl8Yw7e1lOaShCxsEk+i6+fb1SnSuS1QiBARgXn6hpcdt93hSoGdc9D3AwmEBe6JmEXlBZazT0tCnXGHGEDbvJKqnDUBhiT8MYRV2Q67yiMedb9hjKUl8rFovWFtFYv7UUgtCE/Mqvah3Q7uZRHMoDnytKHWVuCFt/REaA24ZonIrFaQv/bVnLYW+WGOmppNhyRWym2FFEOWloloTwCPlLqvPTJ1awHhecMRLk/gho+7WRBi7QHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IZutJti7ENAGQSqMluy0gH+tf9xpxr18XX0L3Yl2LA=;
 b=KhIp6B5KIi1wp1P8A8DoySBbbYXl7ax7gvBg1AwpHhgKD5Oth73F8XX2L/875TpNB/M9yOvqUXvCQ1gB7C9IQJlRhgyV7Z9vHvQoiVFqRxMITulgq7J2yUgmPOiQniHnPZLBwyTA7RK/35ajFHwCXR0ymmMF0UYjAdKchS+kA0k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 15:15:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 15:15:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status
Thread-Topic: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status
Thread-Index: AQHaJCk+QlAGi2qYLEiRUd1OXnBTSLCUdQyAgAAVBm0=
Date: Fri, 1 Dec 2023 15:15:25 +0000
Message-ID: <BL1PR12MB514427F6E383ECA9FC85F5EDF781A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231201073636.1190113-1-lijo.lazar@amd.com>
 <20231201073636.1190113-3-lijo.lazar@amd.com>
 <CADnq5_M7WdSgJc2Gd8zZi2Pb-2RxWMryN5diFk7CjCbUTNcmyw@mail.gmail.com>
In-Reply-To: <CADnq5_M7WdSgJc2Gd8zZi2Pb-2RxWMryN5diFk7CjCbUTNcmyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-01T15:15:25.076Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY5PR12MB6408:EE_
x-ms-office365-filtering-correlation-id: 6304e711-ceb5-4384-f201-08dbf280583d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qN/EBBvIlEQp8fsOT4fu35MFIhqvWMJyqFXxNjBI1iOnizc5FXoHc5FB4cuHW5unearnJKazYJbeqivIEK89w5LMazfwxJRrW3BauQJNYnkcg3IvhnVKcIbmWm4489f34xNpsB85w1aWjMzJoT9Q4zmf0RjTVIREabnFPLT/LsiSxBvEP/WR5HZAISfbXIoMeuhIGzEPhq8PisgEIiVAFVvFaSIeF1ohMlpBZ2s0qf1Ha+47EklFsXahFB8z/pX0U9hD+nFgkLIxgJwheDX244HqJxsf+qGxKPR4QD9DOivIYehVvnVCR/BRW120O76F7tH3AyNPyR0+4ZyN2XPkSQVy5Xz+7owDoj2uGW3UqN3KbQN6A5XtOmI8cuxvrNRCjRfYenTw1d4ZyqoBH8s26Q4A8b/nKIJO7N5HeryXx74Zo3eZttxmMGBjKYgbRXSU5JU2VbON88cP2micmxWnivbvFNFchGf8hAWRHqqNDbulGtApPi89yOb9guTlA+jyCgEVhhQLO7Tv1orUQddGZYlQaWzTDfdiFZVNBFmCZ9zKJOcUzOpwbKMr7opnNlwQQwseshpVQG9KCFv4iYwwOWUOmxgR9ZYekME9NxsEbWZlZfPiP3KWicOjB2hEDEXG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(4326008)(52536014)(8676002)(8936002)(19627405001)(55016003)(26005)(110136005)(91956017)(6636002)(316002)(41300700001)(54906003)(76116006)(66476007)(64756008)(66556008)(66446008)(66946007)(5660300002)(9686003)(53546011)(6506007)(7696005)(83380400001)(38100700002)(122000001)(86362001)(33656002)(71200400001)(478600001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU9PWmVJRGFpb1dWelVhUXNyK0VwUDJXeUgwazBVVUQ3UnEzMWdWNEJuV1d4?=
 =?utf-8?B?RVlJZ3ZZYkp0dnVGaGF3UjhOdktIWUswZkJvVFV0Y3M5M3pvS2lrV0JXdEZk?=
 =?utf-8?B?WDN0MW4zc1RhWDQwdjltQzVvRklPL25xbUZOV2ZTZVRGNFdvUG1VSEMzbE0v?=
 =?utf-8?B?anVZRS9DdEV3UmZGWFdIMVdpS0xsVFY0WVhLR1JhdWR0bWtwMVNSbWJ0WmR5?=
 =?utf-8?B?S09iRzhOejhMclNtRnJYbktBbzhkT2I0NXhVWmlYbUdmdnZpV3BkMzEzZUdm?=
 =?utf-8?B?SGtHRWRMZFZxSmorU1ExUlExMmVJczFkRzRzeFpxVnZZY0FBbkVtaWhmZUs1?=
 =?utf-8?B?eVZWQ0hJalYvdk5oa2NWeE42ZXZRVGZmYzQ2c3dPQWJXaFl2UnR5YVhEVEFl?=
 =?utf-8?B?ZUg4Y1dkQ0tXbmp0UFJIK1F3OEFpWWoxalNiMEYydGdsa1hqUnhQWUtncHM5?=
 =?utf-8?B?TXJMcXl4MThOMGNBTUxlMmJpVTZ4cHlDUVNVaHdNZDNpY2h3WEVtM1Q4clAr?=
 =?utf-8?B?L2dXbjhUU0lwTTIrVnQ4S0YxNmlPdUhjT1hpcEEvSDQ1MHpya3BFTTFTS29M?=
 =?utf-8?B?ZUZXNkhwYW9TTTc0aU9hK1FCMUpoR0dmTWwwdE80RE40c2RyL2Y5QXJraHN0?=
 =?utf-8?B?TG5hVWdDZmtESVQwVjMvQU8rY3ZySzNiMEJ4Und2YzgyTVdrNWZDNk1hY1NL?=
 =?utf-8?B?V3dxVUtta2tVNE9hZUR6WTNjc2pxOU1TMi9PTHhQR295NEZIM3dvMFhDTnVs?=
 =?utf-8?B?eXVlN1NhVlFVTmdGQTBuWFNpR08xS0NLcnRReHkvbUM4YzYrNGhjMloxWTMz?=
 =?utf-8?B?dDkrWjl2ZjFoRC90OXNlZEtmdzZmbmtTaTR5UWU5eWtsZElWZnk0Z0piQ2Rp?=
 =?utf-8?B?Q1BadFFaVlM5S1ViY0twM1cyKzlxZXh1Nnluc2tFSUVMS25yZUM2b09FNUtX?=
 =?utf-8?B?RkRzOXhDRmlvbVRqOGJ5bUZqVnBYb1hvZkNGQVRNMFpoRU5zSmpydUxOdnpV?=
 =?utf-8?B?SjYrUU5WSjFLSkpwZ3JRQzRpa0N5ak1aU1Q4Wk9vVlM4T1ZQVmZBb01VRDY3?=
 =?utf-8?B?VkxGSjFUUGV1M2pMckorc3hNbnU4bUU5RVcyYVUwU3NUbzlLS2paNHp6VUFM?=
 =?utf-8?B?eEU0TG1OVFJxbWpDZHZLSE5wRVhqZ041OThPNHJZTUFkbHZXSmx4bDRhZzh1?=
 =?utf-8?B?eEFYZGlpRnJ3QXNINVYyVkwxUllQVTZONDZkQmpUa0txSUhiM2ZwM2pWWmFm?=
 =?utf-8?B?REcreERncDU4K2ZqYTg0dG16Q3lDNjZjQVNiSXY0ZlQzSWV2VWxpTUFhQUw4?=
 =?utf-8?B?SjI2SzBzOGZCSlVIWWxFNkdGZjNoR2Ztb3UxMG5JZUlNWW40TEZCNForZ0xn?=
 =?utf-8?B?OHdmRC8xM29sN0ZvMWpmOU9PRnpFT2pNK3pReW9mbXIxK0FsVk54QTJlWDI3?=
 =?utf-8?B?Vkl2ZTA0WlN3bytKcDhIbUNJcmhBSkhoU2hqSjE5WE1Xb2Z3NHdubXExVUt5?=
 =?utf-8?B?Y2lwRnVhdjB2ZGcxWEU3TDRwMDVZOHZneFFUUnZWZkhueUNDdmlIZmdtdEtU?=
 =?utf-8?B?VkRldlI3TUtsenZqNzRSOTVNWHVpL3VzY1RFRWM4N05raHlpUGkrQ2lsOHlF?=
 =?utf-8?B?YzhTVlowa0FOOU5GRElicDk4dmkyV1ptT3IveUE2VTdCdzN3N3g1YStVdGtL?=
 =?utf-8?B?VDY2NXFNdmg4ejYxbm1NMlBKOTRwS2xPQkRuZVBjdE54L2dnKzU4eGZEdFpR?=
 =?utf-8?B?d0w0ajBWWEFIKy9qeGFIODJxSzFnekU2OVdwQ0loNFk1VlNzNW1JWmFZZ1Rw?=
 =?utf-8?B?bXpQOUU3bjZKL3l1MEx6NnhCSzhzZTZ0VC9ONG44KzJrcmMzaGRWdGlhRkZi?=
 =?utf-8?B?L2NNUjNmcGRrVG9GRUNLN3lQNzlDYjk5NGU0VEwzMnBCSHYvOWJ1Y1Vra2VR?=
 =?utf-8?B?WHltWmhTby94YVdMajJvdWF6Y0FCay8vOVZDSzVxeEY4TlVqNmQvMzU3NkRH?=
 =?utf-8?B?NTFiQitOY2xvUXRpK1FoS2hxM0hySjJjV05kYkptcU5aRVl5RzFDczdIekFj?=
 =?utf-8?B?Y05XbmdwZzBBRVlIMDVEZGlvNDViQWp1UHNGOFVYNGF6ekl0MjZDSG1jNFls?=
 =?utf-8?Q?UAEk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514427F6E383ECA9FC85F5EDF781ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6304e711-ceb5-4384-f201-08dbf280583d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 15:15:25.3140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMohDXfaZLs26dQ9veHhHccjjCPXeSHWr7cZOvyp031gGlZwAsBNBieznPAA6/EGxnPF0xMor1nQVukLvu44/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514427F6E383ECA9FC85F5EDF781ABL1PR12MB5144namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkZvciB0aGUgc2VyaWVzLg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogRnJpZGF5LCBEZWNlbWJlciAxLCAyMDIzIDk6MDAgQU0N
ClRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZGdw
dTogQXZvaWQgcXVlcnlpbmcgRFJNIE1HQ0cgc3RhdHVzDQoNCkFja2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCk9uIEZyaSwgRGVjIDEsIDIwMjMgYXQg
MzozMuKAr0FNIExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IE1Q
MCB2MTMuMC42IFNPQ3MgZG9uJ3Qgc3VwcG9ydCBEUk0gTUdDRy4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMNCj4gaW5kZXggOTA0M2ViZjFlMTYxLi4xNTAzM2VmZWMyYmEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMTUuYw0KPiBAQCAtMTQzMCw3ICsxNDMwLDggQEAgc3RhdGljIHZvaWQg
c29jMTVfY29tbW9uX2dldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsIHU2NCAqZmxh
Z3MpDQo+ICAgICAgICAgaWYgKGFkZXYtPmhkcC5mdW5jcyAmJiBhZGV2LT5oZHAuZnVuY3MtPmdl
dF9jbG9ja19nYXRpbmdfc3RhdGUpDQo+ICAgICAgICAgICAgICAgICBhZGV2LT5oZHAuZnVuY3Mt
PmdldF9jbG9ja19nYXRpbmdfc3RhdGUoYWRldiwgZmxhZ3MpOw0KPg0KPiAtICAgICAgIGlmIChh
bWRncHVfaXBfdmVyc2lvbihhZGV2LCBNUDBfSFdJUCwgMCkgIT0gSVBfVkVSU0lPTigxMywgMCwg
MikpIHsNCj4gKyAgICAgICBpZiAoKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE1QMF9IV0lQLCAw
KSAhPSBJUF9WRVJTSU9OKDEzLCAwLCAyKSkgJiYNCj4gKyAgICAgICAgICAgKGFtZGdwdV9pcF92
ZXJzaW9uKGFkZXYsIE1QMF9IV0lQLCAwKSAhPSBJUF9WRVJTSU9OKDEzLCAwLCA2KSkpIHsNCj4g
ICAgICAgICAgICAgICAgIC8qIEFNRF9DR19TVVBQT1JUX0RSTV9NR0NHICovDQo+ICAgICAgICAg
ICAgICAgICBkYXRhID0gUlJFRzMyKFNPQzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1QMF9NSVND
X0NHVFRfQ1RSTDApKTsNCj4gICAgICAgICAgICAgICAgIGlmICghKGRhdGEgJiAweDAxMDAwMDAw
KSkNCj4gLS0NCj4gMi4yNS4xDQo+DQo=

--_000_BL1PR12MB514427F6E383ECA9FC85F5EDF781ABL1PR12MB5144namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bDtmb250LXNpemU6MTBwdDtjb2xvcjojMDAwMEZGO21hcmdpbjo1cHQ7Zm9udC1zdHlsZTpub3Jt
YWw7Zm9udC13ZWlnaHQ6bm9ybWFsO3RleHQtZGVjb3JhdGlvbjpub25lOyIgYWxpZ249IkxlZnQi
Pg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdPGJyPg0KPC9wPg0KPGJyPg0KPGRp
dj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9z
LCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+
DQo8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFw
dG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgY29sb3I6
IHJnYigwLCAwLCAwKTsiPkZvciB0aGUgc2VyaWVzLjwvc3Bhbj48L2Rpdj4NCjxkaXYgaWQ9ImFw
cGVuZG9uc2VuZCI+PC9kaXY+DQo8aHIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3dpZHRo
Ojk4JSIgdGFiaW5kZXg9Ii0xIj4NCjxkaXYgaWQ9ImRpdlJwbHlGd2RNc2ciIGRpcj0ibHRyIj48
Zm9udCBmYWNlPSJDYWxpYnJpLCBzYW5zLXNlcmlmIiBzdHlsZT0iZm9udC1zaXplOjExcHQiIGNv
bG9yPSIjMDAwMDAwIj48Yj5Gcm9tOjwvYj4gQWxleCBEZXVjaGVyICZsdDthbGV4ZGV1Y2hlckBn
bWFpbC5jb20mZ3Q7PGJyPg0KPGI+U2VudDo8L2I+IEZyaWRheSwgRGVjZW1iZXIgMSwgMjAyMyA5
OjAwIEFNPGJyPg0KPGI+VG86PC9iPiBMYXphciwgTGlqbyAmbHQ7TGlqby5MYXphckBhbWQuY29t
Jmd0Ozxicj4NCjxiPkNjOjwvYj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgJmx0O2Ft
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnJmd0OzsgRGV1Y2hlciwgQWxleGFuZGVyICZsdDtB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tJmd0OzsgWmhhbmcsIEhhd2tpbmcgJmx0O0hhd2tpbmcu
WmhhbmdAYW1kLmNvbSZndDs8YnI+DQo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtQQVRDSCAzLzNdIGRy
bS9hbWRncHU6IEF2b2lkIHF1ZXJ5aW5nIERSTSBNR0NHIHN0YXR1czwvZm9udD4NCjxkaXY+Jm5i
c3A7PC9kaXY+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9IkJvZHlGcmFnbWVudCI+PGZvbnQgc2l6ZT0i
MiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB0OyI+DQo8ZGl2IGNsYXNzPSJQbGFpblRleHQi
PkFja2VkLWJ5OiBBbGV4IERldWNoZXIgJmx0O2FsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20mZ3Q7
PGJyPg0KPGJyPg0KT24gRnJpLCBEZWMgMSwgMjAyMyBhdCAzOjMy4oCvQU0gTGlqbyBMYXphciAm
bHQ7bGlqby5sYXphckBhbWQuY29tJmd0OyB3cm90ZTo8YnI+DQomZ3Q7PGJyPg0KJmd0OyBNUDAg
djEzLjAuNiBTT0NzIGRvbid0IHN1cHBvcnQgRFJNIE1HQ0cuPGJyPg0KJmd0Ozxicj4NCiZndDsg
U2lnbmVkLW9mZi1ieTogTGlqbyBMYXphciAmbHQ7bGlqby5sYXphckBhbWQuY29tJmd0Ozxicj4N
CiZndDsgLS0tPGJyPg0KJmd0OyZuYnNwOyBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NS5jIHwgMyArKy08YnI+DQomZ3Q7Jm5ic3A7IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSk8YnI+DQomZ3Q7PGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmM8YnI+DQomZ3Q7IGluZGV4IDkwNDNlYmYxZTE2MS4uMTUwMzNlZmVjMmJhIDEwMDY0
NDxicj4NCiZndDsgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYzxicj4N
CiZndDsgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYzxicj4NCiZndDsg
QEAgLTE0MzAsNyArMTQzMCw4IEBAIHN0YXRpYyB2b2lkIHNvYzE1X2NvbW1vbl9nZXRfY2xvY2tn
YXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLCB1NjQgKmZsYWdzKTxicj4NCiZndDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFkZXYtJmd0O2hkcC5m
dW5jcyAmYW1wOyZhbXA7IGFkZXYtJmd0O2hkcC5mdW5jcy0mZ3Q7Z2V0X2Nsb2NrX2dhdGluZ19z
dGF0ZSk8YnI+DQomZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFk
ZXYtJmd0O2hkcC5mdW5jcy0mZ3Q7Z2V0X2Nsb2NrX2dhdGluZ19zdGF0ZShhZGV2LCBmbGFncyk7
PGJyPg0KJmd0Ozxicj4NCiZndDsgLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBpZiAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgTVAwX0hXSVAsIDApICE9IElQX1ZFUlNJT04o
MTMsIDAsIDIpKSB7PGJyPg0KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGlmICgoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgTVAwX0hXSVAsIDApICE9IElQX1ZFUlNJ
T04oMTMsIDAsIDIpKSAmYW1wOyZhbXA7PGJyPg0KJmd0OyArJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IChhbWRncHVfaXBfdmVyc2lv
bihhZGV2LCBNUDBfSFdJUCwgMCkgIT0gSVBfVkVSU0lPTigxMywgMCwgNikpKSB7PGJyPg0KJmd0
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKiBBTURfQ0dfU1VQUE9S
VF9EUk1fTUdDRyAqLzxicj4NCiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgZGF0YSA9IFJSRUczMihTT0MxNV9SRUdfT0ZGU0VUKE1QMCwgMCwgbW1NUDBfTUlTQ19D
R1RUX0NUUkwwKSk7PGJyPg0KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBpZiAoIShkYXRhICZhbXA7IDB4MDEwMDAwMDApKTxicj4NCiZndDsgLS08YnI+DQomZ3Q7
IDIuMjUuMTxicj4NCiZndDs8YnI+DQo8L2Rpdj4NCjwvc3Bhbj48L2ZvbnQ+PC9kaXY+DQo8L2Rp
dj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_BL1PR12MB514427F6E383ECA9FC85F5EDF781ABL1PR12MB5144namp_--
