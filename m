Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5B0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 09:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1136910E480;
	Thu,  8 Dec 2022 09:01:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0797E10E480;
 Thu,  8 Dec 2022 09:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4H1KUz/G5UDhsdZG3+Va/tQ6SLgVhjQL2bD9/Csf/eZdRM6szE2LULDdjWTa21/l05g4cnQw3NcC++EArN2pXcY/X54b1WeBF+aYtyCEIOQQ4GTwpCND4elko6yAnr1sfOBIbykGttXwwhSKXnyUHw/adQQWSlVm4C4pHfrCv3zehY3gmuPRFiZ8dIcCaoxuoytizm357d38X51Z0bxQ3j6r3sLoiGdRg1Kw796r0xFVzkiZGGRmur7We2TBO9jYjr3CFfiNpMAdp8pHDkW0LMO5Bfj2XlkoDKoHt6hxqAdC9KRYmOV+LPS2lBTUdJr91oC1mDU/3uT3mxEAH85bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uj226W5mKlt6IVBnDZyALmO/9k90EoeeXgznid8zdo=;
 b=jMQz3jtEjsp5MJpcA7Tbv6DU2qXn6xiTqGHGiw1uPOABuVXafiqgGqo/U/iEqy0Uxo9BNDro/dWtZ5jDqteYFVTtBqE59WJDpCxDrtkEg+bfnFVfjDrOk8TpN3xQ4zx5ipBc8m/PDdpP305y+U6yJ9Cmoyel+h/WorZBiKMHCKr+V26jaI/3Sz4Vn0Ufu0J2EQ2sh1OYMARkQTQ8T/r3ZzgEd1aVC7H5PCFZM3MBvGG1Gf9ZKI0MWss22HNnop214+j5PEw5jqszkA+KXWng4GXSd7KTI37YjWFrD0uwPTwAknz6a1ivYmmnDFTkCXgRxk2pJTNTE3oPkCGFUHvXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uj226W5mKlt6IVBnDZyALmO/9k90EoeeXgznid8zdo=;
 b=qmxbizaofAVgj2tDHJj78qyO4Le2aPrUXb83Ae7pQ1N1ASJAJ7nVMllWfo+6TSL2RQJpeas3jE+UgoEymptQjonIgRA+FeZykNbojvAZw8/dCD4RVAW4Vi2rB8z/Q95IweZqqv7p8NST9LJedFI9Cje3t15IOCs8FIqUo5ixBGA=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 09:01:37 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 09:01:37 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Thread-Topic: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer
 failed
Thread-Index: AdkKDSDFxSlpkC5gTnSZE4zebcKC0wAQPv2AAABvKoAAAIkXgAAAfQYAAACNQwAAABRqgAAAW36AABiUhGAAAH4DgAAItA8Q
Date: Thu, 8 Dec 2022 09:01:37 +0000
Message-ID: <CY5PR12MB636979CA7FF50C4FDBC8DF98C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
 <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
 <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
 <CY5PR12MB6369519F1EABAE9A86957850C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
In-Reply-To: <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T08:28:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e2ef9f92-205e-4f15-bc87-5c6382e647ea;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T09:01:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 57be0ad0-3f5b-452d-a258-f9e86b1db631
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH8PR12MB6772:EE_
x-ms-office365-filtering-correlation-id: 660a9585-44d8-41be-a24f-08dad8fad075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyJtzrhBQB8BPxV+Zi2Pm/o8yA6Uxv2I2KxeJbJXPemlHXS0MS7j2kGiHq4u46IARzcOfZHwFcaPF4zbWaSEXN/CVhpmWnmD/Z+w8zWHjfu4dWMOqJC8YinpHCGd0KAOaXrZY3oJSjIbaFsEackBb/FzGhTD+ytt23q02Gs9IuNCClmarumZrErfe6rn8ShvZ4luMMOX+LtQuoiWUsM4iOMOcmonvgHnl4y9SuzMzWn5E3pkFimrKovX55mgTGGKYb9sUzWCt0bUtrGuVk0Uylvwa7h9X4WqaVbN2t0TZKmSk2QGzuwvlEE4NA7yJ+kRtmf5li6AOCn7IDejZcGbsMEuMdwe+h974jO1g428iD6ogFpR1HP6N63pRo45gVxgisg1fSBLl2QLRBzGTzmsccaycDJH21srOBbjQ1MfBLFaLHMYcoxrZPQNw0MXQVAZEaANdtlesxKWUE4NNL7B0nm/sAQn0h9X57cBOphh1i4TcMS48DEQY8OI8aWNS/u8v6PdKRtO15AD/kinc0lF7fv4Mu2f8AiVVELLqJwuhmDVTyrkNAiSsXC16IHPnuu6WX9NIbDa7eiQmv8iH6WAyCQjB6s98Rbbl5bNfPPmevEwmsgmSOYaLY6gl3VNeNdft2xpAuq17zByeB1c8jUoBk5KjzoGk/ZeEDYfWUEVjpZGr2kkwk443Igr3p7/1nW+vtV9f3WOLevRZclrcHPvp8jC02JA5Mm5xgGGISu9hoplbscQmyyHdfitDvPv2BNi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(54906003)(2906002)(86362001)(8936002)(5660300002)(33656002)(4326008)(38070700005)(38100700002)(71200400001)(83380400001)(478600001)(122000001)(66574015)(66446008)(66946007)(66556008)(6916009)(316002)(76116006)(55016003)(8676002)(9686003)(52536014)(41300700001)(6506007)(186003)(53546011)(64756008)(7696005)(26005)(66476007)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnA4ZEtoUmtqZk4wMXYvckhqREwvN2tyK3lZM01PVCtpc0NML0lxVDBoeDhm?=
 =?utf-8?B?akZBK3BBT2VuSmdJRWF6MDFYaXV6YTVITGJFblNrWjhwWGZsOUtrR1A1NXMy?=
 =?utf-8?B?NUNzdkZGZmxSLy9vRWpkajZsOWFJNXREekRXUFpQRlcxY0ZaeFloYi9IQVR5?=
 =?utf-8?B?WloxT0tHR2VVZmN1dWlPbG9IYWN5NjhmZ24wSENiUlVtbEdZamVWazg1RFlL?=
 =?utf-8?B?UCtwclROMkpqbVZmOUlkMnpJUzdKdlNGc3kxam1NTE5DSlpqRmI3SU1PNmVB?=
 =?utf-8?B?Z3NUNnBEVTc4UENmYnZRL0xEWENzNGZtQTd6TVUzemtEajk5aU9jNmZ2c01i?=
 =?utf-8?B?bXBLSS8xOGZoSnY3aGwyMko3dk5DemZIN0tQRm5hRUNrKzZCbG1IdGQxUUZV?=
 =?utf-8?B?MjZKc25xaWQ5VVh0T0E2cGNSNm0zNklLd0dHRUVvRHVxSkU2bFpCZjF0alY5?=
 =?utf-8?B?aGZpZUYzVnlXL2prdlBEL2ZEMy9CNTBmZTlRTjJZRXNVSGkrekdnRGtac0VJ?=
 =?utf-8?B?R2VlczMySmUxS2ZvYXFEbUJKRjNseGNQNEpVc04rdjR1cENjU2lWMmdEeUJx?=
 =?utf-8?B?aG8xaGhpcFZoaE40S2tFOStPM1pCV0RuUTBveW4zbm1kT1ZoakdNNyt0Y1hB?=
 =?utf-8?B?TFk5a3RQQlZTY2twWkp1VThxT3N2Y0NCR3RtTXkvVTJ1Zjh5UXRHSnMxSE1a?=
 =?utf-8?B?QSt4bURRT0xkQTI0bnVyM1FGbkppM2c4RjhRdEljbGo5KzdScWR5djNKQ05V?=
 =?utf-8?B?dUlCcncxVFZ0elNLQWd5dGdJWDZ5ZUt1SGZPMTdFb2x1ckZpUlpiM1YvVURI?=
 =?utf-8?B?bmY3cW8yUm1BOUJ2YWN0QnhJL09IcU4vUVdncWVPMDVFV1MrNzhVSnJzMU94?=
 =?utf-8?B?WnFkZnhJUXNNV1gvSGY0WHFtZnAwV2R0N0pOM1E0NWJRTXhOYmw0bjFXYkcv?=
 =?utf-8?B?WEFPZmpnYWV5N1RHY0JvZ2V6a01uMDFSemZnUGQyTjY5L2xlR2tWZzh6cHpU?=
 =?utf-8?B?Q2thWitMM0tXSXFSdHhFVDZJWUhzV0VkUVV5eHJQaERCb0svc1h1N1M2cGpK?=
 =?utf-8?B?SHRQSGYzRGEwSWlCS0VIU09RVmJGdkxLNG9Ec0hpSmJ3OFpVMWl6bHdhc3Bo?=
 =?utf-8?B?T2FuL1pVb1lCck9rdmFrY203VVoxMlQ4aXZ2ME5UTmUrVDNaUjZaTE9rY2ht?=
 =?utf-8?B?c3NIOXlBdTFhUDVXV2RMVzcxak14NGVVUU1kYlpqck1kUjB6SERqRm5HRTMx?=
 =?utf-8?B?OTIxNFpkWmhvNElpdE1JMWdQb1FTWlQ5QUY3T3NFN3FlWHVJb1F3MThmejMy?=
 =?utf-8?B?eE9OWjNpQ3liYzhLYzhja0hlYk40UThaNmFmMGl4elZOdTFzcUtPNTZEdHE1?=
 =?utf-8?B?WnBIbzU3OU9KeVRtUzdXNzZpL3NGdEpQQzhRd0JXcVlsNHZwU212TnlXdTlF?=
 =?utf-8?B?VGg5ZDBRaVg2Wm9EeFZOM3B4dm1yTmpmUGovWVpKRXZHSk5FQ2tLZ3g2REtG?=
 =?utf-8?B?aTFRTHZNRGlZZkNOaG43aTNiNE9nNTRKYnVaWmJGdUFNWENjSVhoMGxxRi9h?=
 =?utf-8?B?S0xTUXErbnpab09qZ2JVMlh3RkZPdVkyVmdIRmtzQVJUYWxiZTh0VGZkMFlh?=
 =?utf-8?B?RWRJUVQzZHQ1Qm9iMzgxVEcybzlOcmM5RzN6QldwNEVZeUhHRUJQR1NtNzRP?=
 =?utf-8?B?RjBUMUNlU1c5K2Nqc1N3MlJ0bk9CRWFSR3lxbHpadzJ6b2N6QjhPMXd6SEx4?=
 =?utf-8?B?THF4ek1tb3FkSkJROTdMTWRqR3hSZUgxc1NrUmt5YmtHVU9OTVZyNmZsdTc4?=
 =?utf-8?B?cTY1S0JXYUVkUmx2RW4zaW84Q3hwQ3lmYWZicHBsMmJLSkNSUElpU3h3Z2d4?=
 =?utf-8?B?cE1rTUdxUDdrRnNCemgxb2ZnUTFNcG1MUUV2M28yS1lvMzBzMFdMWHZ2T2Nl?=
 =?utf-8?B?ekNsYitGTzR5Z0k4eHFLQk5SUUdDQkYyQXc3N2dsc1RVMktRR0R4UmNrUEdD?=
 =?utf-8?B?UU14MGIvWmFnbGdMN2xvZDFGL2pxa2xPVnhHbnlwcVBDQVdwTGF0Sng5RDFE?=
 =?utf-8?B?VmI3dlRNMTd4bUdXbVM2aDNDcnNWSW9sNU94R0w3c0lDTGJRTFQxNkRyZmMr?=
 =?utf-8?Q?wJKI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660a9585-44d8-41be-a24f-08dad8fad075
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 09:01:37.6984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmWtdxzZoEGsbzsI9fVhs2gUEsRjG3YK7nEQs0tmXtNQ3KauIbGN1cFY/5i+EvPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNClllcywgSSBy
ZWFsaXplZCB3aXRoaW4gdGhlIGNvbmRpdGlvbiBteSBjaGFuZ2UgaXMgbWVhbmluZ2xlc3MsIHBs
ZWFzZSBpZ25vcmUgaXQuIEFuZCB0aGUgVjIgcGF0Y2ggKDAwMDEtZHJtLWFtZGdwdS1tYWtlLWRp
c3BsYXktcGlubmluZy1tb3JlLWZsZXhpYmxlLXYyLnBhdGNoKSBpcyBhY3R1YWxseSBkeW5hbWlj
IGRvbWFpbiBmYiBhbGxvY2F0aW9uLCBpdCBpcyBnb29kIGVub3VnaCB0byBoYW5kbGUgbW9zdCBv
ZiBvdXIgZmIgcGluIGZhaWx1cmUgaXNzdWVzLiBKZXNzZSBhbmQgU2hpa2FpIGFscmVhZHkgdmVy
aWZpZWQgVjIgcGF0Y2gsIHBsZWFzZSBoZWxwIHRvIHN1Ym1pdCBpdCBmb3IgcmV2aWV3IC4gVGhh
bmtzICENCg0KQmVzdCBSZWdhcmRzLA0KWWlmYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6IFRo
dXJzZGF5LCBEZWNlbWJlciA4LCAyMDIyIDEyOjE5IFBNDQpUbzogWmhhbmcsIFlpZmFuIDxZaWZh
bjEuWmhhbmdAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT47IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29t
PjsgYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IFBhbmVl
ciBTZWx2YW0sIEFydW5wcmF2aW4gPEFydW5wcmF2aW4uUGFuZWVyU2VsdmFtQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHRyeSBhbGxvd2VkIGRv
bWFpbiB3aGVuIHBpbiBmcmFtZWJ1ZmZlciBmYWlsZWQNCg0KT24gV2VkLCBEZWMgNywgMjAyMiBh
dCAxMToxMCBQTSBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPiB3cm90ZToNCj4N
Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IEhpIEFsZXgsDQo+DQo+
IFdlIG5lZWQgdG8gYWRqdXN0IHRoZSBBTURHUFVfU0dfVEhSRVNIT0xEIGFzIHdlbGwgc2luY2Ug
cmVjZW50IEFQVXMgYXJlIGNvbmZpZ3VyZWQgdy8gNTEyTUIgVlJBTS4gUGxzIGNoZWNrIGF0dGFj
aGVkIHBhdGNoLg0KDQpXaHkgZG8gd2UgbmVlZCB0byBpbmNyZWFzZSB0aGlzIHRocmVzaG9sZD8g
IFRoZSBjb25kaXRpb24gb25seSBhcHBsaWVzIHRvIENaIGFuZCBTVCwgbm90IG1vcmUgcmVjZW50
IEFQVXMuDQoNCkFsZXgNCg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IFlpZmFuDQo+DQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgOCwgMjAyMiAxMjoyMSBBTQ0K
PiBUbzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+
DQo+IENjOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IFpoYW5nLCBZ
aWZhbiANCj4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeCANCj4gPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIA0K
PiA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyANCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHRyeSBhbGxvd2VkIGRvbWFpbiB3aGVu
IHBpbiANCj4gZnJhbWVidWZmZXIgZmFpbGVkDQo+DQo+IE9uIFdlZCwgRGVjIDcsIDIwMjIgYXQg
MTE6MTAgQU0gQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+IEFtIDA3LjEyLjIyIHVtIDE3OjA4IHNjaHJp
ZWIgQWxleCBEZXVjaGVyOg0KPiA+ID4gT24gV2VkLCBEZWMgNywgMjAyMiBhdCAxMDo1MiBBTSBD
aHJpc3RpYW4gS8O2bmlnIA0KPiA+ID4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
PiB3cm90ZToNCj4gPiA+PiBBbSAwNy4xMi4yMiB1bSAxNjozOCBzY2hyaWViIEFsZXggRGV1Y2hl
cjoNCj4gPiA+Pj4gT24gV2VkLCBEZWMgNywgMjAyMiBhdCAxMDoyMyBBTSBDaHJpc3RpYW4gS8O2
bmlnIA0KPiA+ID4+PiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOg0K
PiA+ID4+Pj4gSSB3b3VsZCBnbyBhIHN0ZXAgZnVydGhlciBhbmQganVzdCBhbGxvdyBHVFQgZG9t
YWluIG9uIEFTSUNzICE9IA0KPiA+ID4+Pj4gQ0FSUklaTw0KPiA+ID4+Pj4gfCBTVE9ORVkuDQo+
ID4gPj4+Pg0KPiA+ID4+Pj4gSSBjYW4ndCBzZWUgYSBnb29kIHJlYXNvbiB3ZSBzaG91bGQgc3Rp
bGwgaGF2ZSBhbnkgbGltaXRhdGlvbiANCj4gPiA+Pj4+IGhlcmUsIFZSQU0gZG9lc24ndCBoYXZl
IGFueSBhZHZhbnRhZ2UgYW55IG1vcmUgYXMgZmFyIGFzIEkga25vdy4NCj4gPiA+Pj4gV2VsbCwg
aWYgVlJBTSBpcyBhdmFpbGFibGUgd2Ugd2FudCB0byBtYWtlIHN1cmUgc29tZW9uZSB1c2VzIGl0
IA0KPiA+ID4+PiBvdGhlcndpc2UgaXQncyBqdXN0IHdhc3RlZC4NCj4gPiA+PiBXZWxsIGl0IHN0
aWxsIGdldHMgdXNlZCB3aGVuIGl0J3MgZnJlZS4gU28gbm93IHByb2JsZW0gYXQgYWxsIGhlcmUu
DQo+ID4gPj4NCj4gPiA+PiBXZSBzaG91bGQganVzdCBub3QgZm9yY2UgYW55dGhpbmcgaW50byBW
UkFNIG9yIEdUVCBhbnkgbW9yZSBpZiANCj4gPiA+PiBpdCdzIHRlY2huaWNhbGx5IG5vdCBuZWNl
c3NhcnkuDQo+ID4gPiBTbyBqdXN0IHRoaXM/DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4gaW5kZXggOTE5YmJlYTJlM2FjLi44
ZThmMDdmYTdhOTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfb2JqZWN0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4gQEAgLTE1MDYsNyArMTUwNiw3IEBAIHU2NCBhbWRncHVf
Ym9fZ3B1X29mZnNldF9ub19jaGVjayhzdHJ1Y3QgYW1kZ3B1X2JvICpibykNCj4gPiA+ICAgdWlu
dDMyX3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgZG9tYWluKQ0KPiA+ID4gICB7DQo+ID4gPiAtICAgICAgIGlmIChkb21haW4g
PT0gKEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gfCBBTURHUFVfR0VNX0RPTUFJTl9HVFQpKSB7DQo+
ID4NCj4gPiBXZSBzdGlsbCBuZWVkIHRvIGtlZXAgdGhpcyBjaGVjayB0byBhdm9pZCB0cnlpbmcg
dG8gYWRqdXN0IFZSQU0gb25seSANCj4gPiBhbGxvY2F0aW9ucyAodGhlIGN1cnNvciBzdGlsbCBu
ZWVkcyB0aGlzIElJUkMpLg0KPiA+DQo+ID4gQXBhcnQgZnJvbSB0aGF0IEkgdGhpbmsgdGhhdCBz
aG91bGQgd29yay4NCj4NCj4gQXR0YWNoZWQuICBUaGFua3MsDQo+DQo+IEFsZXgNCj4NCj4gPg0K
PiA+IENocmlzdGlhbi4NCj4gPg0KPiA+ID4gKyAgICAgICBpZiAoKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX0NBUlJJWk8pIHx8IChhZGV2LT5hc2ljX3R5cGUgDQo+ID4gPiArID09DQo+ID4gPiBD
SElQX1NUT05FWSkpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgZG9tYWluID0gQU1ER1BVX0dF
TV9ET01BSU5fVlJBTTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdtYy5yZWFs
X3ZyYW1fc2l6ZSA8PSBBTURHUFVfU0dfVEhSRVNIT0xEKQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsNCj4gPiA+DQo+ID4gPg0K
PiA+ID4NCj4gPiA+PiBDaHJpc3RpYW4uDQo+ID4gPj4NCj4gPiA+Pj4gQWxleA0KPiA+ID4+Pg0K
PiA+ID4+Pg0KPiA+ID4+Pj4gQ2hyaXN0aWFuLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IEFtIDA3LjEy
LjIyIHVtIDE2OjEwIHNjaHJpZWIgQWxleCBEZXVjaGVyOg0KPiA+ID4+Pj4+IERvZXMgdGhpcyBw
YXRjaCBmaXggdGhlIHByb2JsZW0/DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBBbGV4DQo+ID4gPj4+
Pj4NCj4gPiA+Pj4+PiBPbiBXZWQsIERlYyA3LCAyMDIyIGF0IDI6MjcgQU0gWmhhbmcsIEplc3Nl
KEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4+Pj4+PiBbQU1EIE9mZmlj
aWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+
Pj4gICAgICAgIGRybS9hbWRncHU6IHRyeSBhbGxvd2VkIGRvbWFpbiB3aGVuIHBpbiBmcmFtZWJ1
ZmZlciBmYWlsZWQuDQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+DQo+ID4gPj4+
Pj4+ICAgICAgICBbV0hZJkhPV10NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4N
Cj4gPiA+Pj4+Pj4gICAgICAgIGluIHNvbWUgc2NlbmFyaW9zLCB0aGUgYWxsb2NhdGUgbWVtb3J5
IG9mdGVuIGZhaWxlZC4gc3VjaCBhcyBkbyBob3QgcGx1ZyBvciBwbGF5IGdhbWVzLg0KPiA+ID4+
Pj4+Pg0KPiA+ID4+Pj4+PiAgICAgICAgc28gd2UgY2FuIHRyeSBhbGxvd2VkIGRvbWFpbiwgaWYg
dGhlIHByZWZlcnJlZCBkb21haW4gY2Fubm90IGFsbG9jYXRlIG1lbW9yeS4NCj4gPiA+Pj4+Pj4N
Cj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gICAgICAgIFNpZ25lZC1vZmYtYnk6
IGppZTF6aGFuIGplc3NlLnpoYW5nQGFtZC5jb20NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gICAg
ICAgIENoYW5nZS1JZDogSTRiNjJlMmZmMDcyZDAyYzUxNWY5MDEwMDBhNTc4OTMzOWQ0ODEyNzMN
Cj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4+Pj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4+Pj4+
Pg0KPiA+ID4+Pj4+PiBpbmRleCAxYWUwYzg3MjMzNDguLjA1ZmNhZjdmOWQ5MiAxMDA2NDQNCj4g
PiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jDQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBAQCAt
MzksNiArMzksNyBAQA0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiAjaW5jbHVkZSAiYW1kZ3B1Lmgi
DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICNpbmNsdWRlICJhbWRncHVfdHJhY2UuaCINCj4gPiA+
Pj4+Pj4NCj4gPiA+Pj4+Pj4gI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQuaCINCj4gPiA+Pj4+Pj4N
Cj4gPiA+Pj4+Pj4gKyNpbmNsdWRlICJhbWRncHVfZGlzcGxheS5oIg0KPiA+ID4+Pj4+Pg0KPiA+
ID4+Pj4+Pg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiAvKioNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+
Pj4gICAgICAqIERPQzogYW1kZ3B1X29iamVjdA0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBAQCAt
OTQyLDggKzk0MywxNCBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVjdCANCj4g
PiA+Pj4+Pj4gYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgYm8tPnBsYWNlbWVudHNbaV0ubHBmbiA9IGxw
Zm47DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICAgICAgICAgICAgfQ0KPiA+ID4+Pj4+Pg0KPiA+
ID4+Pj4+Pg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgIHJldHJ5Og0KPiA+ID4+Pj4+
Pg0KPiA+ID4+Pj4+PiAgICAgICAgICAgIHIgPSB0dG1fYm9fdmFsaWRhdGUoJmJvLT50Ym8sICZi
by0+cGxhY2VtZW50LCANCj4gPiA+Pj4+Pj4gJmN0eCk7DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+
ICAgICAgICAgICAgaWYgKHVubGlrZWx5KHIpKSB7DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICsg
ICAgICAgICAgICAgICAvL3RyeSBhbGxvd2VkIGRvbWFpbiB3aGVuIHBpbiBmYWlsZWQuIGp1c3Qg
YSB3b3JrYXJvdW5kLg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgICAgaWYg
KHVubGlrZWx5KHIgPT0gLUVOT01FTSkgJiYgZG9tYWluICE9DQo+ID4gPj4+Pj4+ICsgYm8tPmFs
bG93ZWRfZG9tYWlucykgew0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLA0KPiA+ID4+Pj4+PiAr
IGJvLT5hbGxvd2VkX2RvbWFpbnMpOw0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIHJldHJ5Ow0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAg
ICAgICAgICAgfQ0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgZGV2
X2VycihhZGV2LT5kZXYsICIlcCBwaW4gZmFpbGVkXG4iLCBibyk7DQo+ID4gPj4+Pj4+DQo+ID4g
Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiA+ID4+Pj4+Pg0KPiA+ID4+
Pj4+PiAgICAgICAgICAgIH0NCj4gPg0K
