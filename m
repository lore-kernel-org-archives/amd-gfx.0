Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A960DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5699A64DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5699A64DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AAB89B67;
	Mon, 15 Feb 2021 12:27:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660A789B67
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 12:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrqOma8y//rwulNJsmr9E+5S1TPQX3WbR8upT0ULxUnutHavTYyfjxy3UmHzOaTEzrnROYMe5scj1p9tFeeR8y1iegTxXKuSRZ8h1fYDi/VroRV89yb5efayZrvcwdRl8OQ5dnB701bJBrhR77x52RvoWNcRsfckDQNTtES2KFDEl4bIMk/rgGEkUUQJNtj7ed362X0IONCUElVxIDFAzcwWH/C/1nA83Sf/C7Y7zV1SmzClU32UQmALqw/O1qPBmfmlEhO3iicxDL1aCQgewfXChbjDBAuvJgHgRfa7EkdvG2PrvY68hSFhk+C4HEYfS42GrSf6FpajimftqH183g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go8C1M2ZNfHtFaunA7O9tkQ64OJlELbjwbz2C4SVt8Y=;
 b=K0hKbkBBF1G20RRBVdIsynrPY5P+5CqJkvMLTQDbri0d5uOoN3Xm1gYPrUtqIF6oWYmuFzqsGAqTRcqojUtbPDu/t60FLNVKDZJ5GpKSbiv6gLXQp7nIngq3W13L6tt7+VxFMYIxG01rxdB476ZF5FQMncrSnXYETlr5RL6Fun9HUegh78ns00YZwr+yDKGMY2sS+otH+YBdV/8NnPZ57p1YL/hxKbN0mFy/LNkKiexKfpLoEEp3r6WgAsU2lW8ZpVdaLlI/Ry/amfARPgO83OcEQ+eny9UjK6Wd6Fsm49HETbVLi8cF1NBi1+g5eC66/PTAY2hwV0aQST6KxdM0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go8C1M2ZNfHtFaunA7O9tkQ64OJlELbjwbz2C4SVt8Y=;
 b=XuAr6EnOn5QcK1a2/a68/ZB/2gOWcEztEKBOkxa032Fqww6F8LDRSNZsdop0oANA/34KxMwim398BZ/ut4wrKXqGxtt2gJlvlFBQ7S9IXmClp/f9bq78029CAIVKMpMePmOEMWTq31P/Dx93O6IRNonfNgtHs0hKVvluosWp5Vg=
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB3511.namprd12.prod.outlook.com (2603:10b6:a03:132::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Mon, 15 Feb
 2021 12:27:12 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3846.034; Mon, 15 Feb 2021
 12:27:12 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
Thread-Topic: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
Thread-Index: AQHXA4/OvkxYljVW+E6PlGu7w51m96pZGLiAgAAK9DA=
Date: Mon, 15 Feb 2021 12:27:12 +0000
Message-ID: <BYAPR12MB3126F7B79F9EB3510813A837F2889@BYAPR12MB3126.namprd12.prod.outlook.com>
References: <20210215114336.89977-1-christian.koenig@amd.com>
 <0a679d74-6066-0ed8-26f8-2d02b6db5210@gmail.com>
In-Reply-To: <0a679d74-6066-0ed8-26f8-2d02b6db5210@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-15T12:27:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dce9b59f-f065-4d11-8114-3a81df629e44;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2bcbfc5-d68c-42a8-69d3-08d8d1ad0586
x-ms-traffictypediagnostic: BYAPR12MB3511:
x-microsoft-antispam-prvs: <BYAPR12MB3511CE7FA71A621DA967DADEF2889@BYAPR12MB3511.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCKTNTWq/ikdYJ+SOnZIC9gMSpUxXaieZE7vX7eIkKUBXv3ESWOvYJyNpMHodk/w9dyTH7zysDu48dc+lNuM3fU/qRKzVeDiB5k08hLFjh8vFI+OCJA2oNt/+QD/3FWCW1QBEWIRYVi9vOVRNeXKkbrF1z61zdjGEcl3e1xiYo/UcENG6Y6/Qs4QRL7gg+lvugjgvwOGD/axhqpOgeCdpTYI5anfVdHcZitcqY91YNYdcS2WSYWRJP6iv1uUkhfg6W5okK/ZO0JuDLoZnc+ylRN+9r3T3ELtfsko3bmm7JIaDe2XbrqVC/FRjWIx+Y92egVNb8wwClTTtJrC6xQBnsmUHYTdNIsw46Syp/VCkx/AMHLA9k+ZqPvplD3Lsk1t/tkoTPUHA2NXpzeR0IvDX5SpC+a7K72SjbgX1leBaJllC8WlFfVXSebkYDtSN44M7fy2ePqpyme+tiQqwtLP9L/GFYGtOIyHSvE/cICprAKX8O71Ig+1k0RP1+IpRd5yx3q166cqMFgM2TeUoVpKfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(5660300002)(71200400001)(53546011)(55016002)(33656002)(52536014)(83380400001)(6506007)(26005)(2906002)(186003)(110136005)(66446008)(316002)(86362001)(66574015)(66946007)(76116006)(7696005)(8676002)(8936002)(64756008)(66556008)(66476007)(9686003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?REZkd0lpR3l2d0hJOHk2QWs5dS9leEdwd3kwZmdJeVhxRGJlSFRaZ1VoT3o2?=
 =?utf-8?B?TlZSVkFFR2YyWllrNDJzUnBoVlE0cms3aGZoNnpnYXF0N2pVM1BVUDhvNGJN?=
 =?utf-8?B?NEl0MXlmeXlKa2JCVVVmZDh4S2lXSG8xOU9JTlRzVzYwc1B6SE9NSy8wREVs?=
 =?utf-8?B?SVY5b29nbE5EVXJ0azBaeWRPdktiZTRRQ2FDZmtMUU1nQmYzTlNiR0EvZk8w?=
 =?utf-8?B?b1hSYXdpN3NIVEhCeU9lbEJaT1Y4V2xpN3JQSGpxa3NYR2RRMzMxTC91bDQy?=
 =?utf-8?B?Y1VRNFY0RUZwM0Y0cXpuSlRuUzdzSFVLVVdVS3hNTTNUQ0dTMXIrZEJkM2pL?=
 =?utf-8?B?Sy9BRzFMclMwZWdzejJHT3hqalFjTGRZU2NVbitUZXNkcnVoSytDTUZLQi82?=
 =?utf-8?B?ekRlQUExMVVUSFd0VTMyRnlvaTg1YXd2UnoxQTBESkQvcnNkWVJDczJtdW5z?=
 =?utf-8?B?SDE4VFh6dXk4VXNkSHZxNGFTalc1VnZPcXIrTGR0NExtMTQ1WVp2UzFZWGN1?=
 =?utf-8?B?WEU4ODdvNUplT0llakRkWTRvZlhzVzNMV3FtNjNQRENtZTdHNFNMUEZyM1U5?=
 =?utf-8?B?NjJOYU1FWVI3WkpZc1Rna3VFd3kxT0FSazFrRkxCQVJwTHZZMTI4NGxQT2ZI?=
 =?utf-8?B?OHFuZVNWanJqMk15bVJ5LzVYUHJuL3BlVU43dHhzV0RJUHUvazdDZm05OFM0?=
 =?utf-8?B?T0p1SlcrV3ljaU5RL0oxQzdNbmpWZ0tnSkZ1RVlQd1JSYWEzSVJTVGdMd0R4?=
 =?utf-8?B?SDRDamg1a0xyZ1lWS2RGVW1OcUNJRU52RzF3amFSQXZQRHkzSkIyR0xJZ2VP?=
 =?utf-8?B?eElWYmVlOFcybm1OejVBY3pLTTZPcDQrSmkxRW5tVjhXY0ZGbmE0ZWp5N2h1?=
 =?utf-8?B?YjRNN1hxRXJkYmJNL0JLYndac1JiU2pWcUZ1YkZLeUIxaS9QdmFTc3MxbG9w?=
 =?utf-8?B?aitVbnphaXJzSFFVU3FGdTVWR3NBa2VhQUwveTk1VytZUWlFR1lZQzdZemJF?=
 =?utf-8?B?dzljbVpsQjI5Q20vREdpZ3BwRm1pY1c2bnBzbG5UNkgyZlBxOHFiZXVwdFVP?=
 =?utf-8?B?VFpaVkRIY0RZYnpNY09EMDFSMUJBSnFxKzBkN3lQN1E0YTRZZklQZjBUMExr?=
 =?utf-8?B?TGxFZ0ZPclByUm9BbTJaNDNSakVSUEoxazNpdjZ2M3Q0YVZBVkZUVnFKdkpH?=
 =?utf-8?B?Vm9rZGRoVldUbUluTlBoNWQwNUFKLzdpZjBNb3VZY3NtV29wR1NSUzd3ZkVV?=
 =?utf-8?B?WUZLWjZicWwwa3JkOWF1MGZVVlpMSDkyK2I3bUU1Z0Rod1RLTmd0dG4vOWRI?=
 =?utf-8?B?TVl4S3VJZERWM3ZnTEdBNzNGdkxEemNWUkJxeFJMYTZEQlZ5TFFkcXBycnky?=
 =?utf-8?B?TGZ5b09rODVKVDh2V2IycEZGY3o0aWtrNjk4SlRXb2VUalFDMHZaOVZlT1dK?=
 =?utf-8?B?bmc4L3ZmUER2bjh5aCtQV1FkV3lyMEc3NXlNSlllUWRFcVNrdFFyM0ZYYjAz?=
 =?utf-8?B?SlhnWlYvcVJWWVBTRTJ0eDEralJLYlRxMlFzUXZETStuKzRVY25kYy9TTXFv?=
 =?utf-8?B?aDlUMjRhR2dwdzVyOG9VckhBZlFySDh3ZzhYeVhXL2ovK1lpaVF1RU5GR1lu?=
 =?utf-8?B?Y0FWOTBoK1NFWDZ4YzI5ak8rRDZOSjFHSWpNYmJUU3U4SmR2SzdXMVd4cita?=
 =?utf-8?B?Y3dFRTIrSTZweDUxYUhQNEZwam9wR0NxOWJwU2RLSEVuZTRicWN3OW1PKzZr?=
 =?utf-8?Q?Jgz/v3i7OOH3Lg1+TuSM9Fg8yfeC+xTtc8wfLCH?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bcbfc5-d68c-42a8-69d3-08d8d1ad0586
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 12:27:12.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ix//8MloFNkFVObw7qrbR3j/8dG+yAJZHReyn21U1tLkuiwHkRlXS0Np72Zs+CH2WX2RqeJ486B++4UjGw0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
ZWxsbyBDaHJpc3RpYW4sIA0KSSBqdXN0IHRlc3RlZCB0aGUgcGF0Y2ggd2l0aCBYb25vdGljICsg
UFJJTUUsDQoNCkkgY29uZmlybSB0aGF0IGl0cyB3b3JraW5nIHNhbWUgYXMgcHJldmlvdXMgdmVy
c2lvbiwgZm9yIHRoZSBGcmVlc3luYyBzY2VuYXJpbywgaWU6DQotIFdpdGggdGhpcyBwYXRjaCwg
ZGlzcGxheSBmcmFtZWJ1ZmZlciBjcmVhdGlvbiBpcyBzdWNjZXNzZnVsLCBmbGlwcyBhcmUgY29t
aW5nIGFuZCBWUlIgcHJvcGVydHkgaXMgZ2V0dGluZyBzZXQuIA0KDQpEaWQgc29tZSBuZWdhdGl2
ZSB0ZXN0aW5nIGFsc28sIA0KLSBXaXRob3V0IHRoaXMgcGF0Y2gsIEZyZW1lYnVmZmVyIGNyZWF0
aW9uIGZhaWxzLCBubyBmbGlwcywgIGFuZCBWUlIgcHJvcGVydHkgZG9lc24ndCBzZXQuIA0KDQpS
ZWdhcmRzDQpTaGFzaGFuaw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlz
dGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IE1v
bmRheSwgRmVicnVhcnkgMTUsIDIwMjEgNToxNSBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFNldCBHVFRfVVNXQyBmbGFnIHRvIGVuYWJs
ZSBmcmVlc3luYyB2Mg0KDQpIaSBTaGFzaGFuaywNCg0KY2FuIHlvdSBnaXZlIHRoaXMgcGF0Y2gg
YSB0ZXN0IHJvdW5kPyBJbiB0aGVvcnkgaXQgc2hvdWxkIHdvcmssIGJ1dCBJJ20gbm90IDEwMCUg
c3VyZS4NCg0KVGhhbmtzLA0KQ2hyaXN0aWFuLg0KDQpBbSAxNS4wMi4yMSB1bSAxMjo0MyBzY2hy
aWViIENocmlzdGlhbiBLw7ZuaWc6DQo+IEZyb206IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsu
c2hhcm1hQGFtZC5jb20+DQo+DQo+IFRoaXMgcGF0Y2ggc2V0cyAnQU1ER1BVX0dFTV9DUkVBVEVf
Q1BVX0dUVF9VU1dDJyBhcyBpbnB1dCBwYXJhbWV0ZXIgDQo+IGZsYWcsIGR1cmluZyBvYmplY3Qg
Y3JlYXRpb24gb2YgYW4gaW1wb3J0ZWQgRE1BIGJ1ZmZlci4NCj4NCj4gSW4gYWJzZW5jZSBvZiB0
aGlzIGZsYWc6DQo+IDEuIEZ1bmN0aW9uIGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5z
KCkgZG9lc24ndCBhZGQNCj4gICAgIEFNREdQVV9HRU1fRE9NQUlOX0dUVCBhcyBzdXBwb3J0ZWQg
ZG9tYWluLg0KPiAyLiBEdWUgdG8gd2hpY2gsIEZ1bmN0aW9uIGFtZGdwdV9kaXNwbGF5X3VzZXJf
ZnJhbWVidWZmZXJfY3JlYXRlKCkNCj4gICAgIHJlZnVzZXMgdG8gY3JlYXRlIGZyYW1lYnVmZmVy
IGZvciBpbXBvcnRlZCBETUEgYnVmZmVycy4NCj4gMy4gRHVlIHRvIHdoaWNoLCBBZGRGQigpIElP
Q1RMIGZhaWxzLg0KPiA0LiBEdWUgdG8gd2hpY2gsIGFtZGdwdV9wcmVzZW50X2NoZWNrX2ZsaXAo
KSBjaGVjayBmYWlscyBpbiBERFggNS4gRHVlIA0KPiB0byB3aGljaCBERFggZHJpdmVyIGRvZXNu
J3QgYWxsb3cgZmxpcHMgKGdvZXMgdG8gYmxpdHRpbmcpIDYuIER1ZSB0byANCj4gd2hpY2ggc2V0
dGluZyBGcmVlc3luYy9WUlIgcHJvcGVydHkgZmFpbHMgZm9yIFBSSU1FIGJ1ZmZlcnMuDQo+DQo+
IFNvLCB0aGlzIHBhdGNoIGZpbmFsbHkgZW5hYmxlcyBGcmVlc3luYyB3aXRoIFBSSU1FIGJ1ZmZl
ciBvZmZsb2FkaW5nLg0KPg0KPiB2MiAoY2hrKTogaW5zdGVhZCBvZiBqdXN0IGNoZWNraW5nIHRo
ZSBmbGFnIHdlIGNvcHkgaXQgb3ZlciBpZiB0aGUNCj4gICAgICAgICAgICBleHBvcnRlciBpcyBh
biBhbWRncHUgZGV2aWNlIGFzIHdlbGwuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNo
YXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDE0ICsrKysrKysrKysrLS0tDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5j
IA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMNCj4gaW5k
ZXggZDM3MjdmM2FiMjc3Li5hNTRhODcwZjAwNmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYw0KPiBAQCAtNDIyLDE0ICs0MjIsMjIgQEAgYW1k
Z3B1X2RtYV9idWZfY3JlYXRlX29iaihzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZG1h
X2J1ZiAqZG1hX2J1ZikNCj4gICB7DQo+ICAgCXN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IGRtYV9i
dWYtPnJlc3Y7DQo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYo
ZGV2KTsNCj4gLQlzdHJ1Y3QgYW1kZ3B1X2JvICpibzsNCj4gICAJc3RydWN0IGRybV9nZW1fb2Jq
ZWN0ICpnb2JqOw0KPiArCXN0cnVjdCBhbWRncHVfYm8gKmJvOw0KPiArCXVpbnQ2NF90IGZsYWdz
ID0gMDsNCj4gICAJaW50IHJldDsNCj4gICANCj4gICAJZG1hX3Jlc3ZfbG9jayhyZXN2LCBOVUxM
KTsNCj4gKw0KPiArCWlmIChkbWFfYnVmLT5vcHMgPT0gJmFtZGdwdV9kbWFidWZfb3BzKSB7DQo+
ICsJCXN0cnVjdCBhbWRncHVfYm8gKm90aGVyID0gZ2VtX3RvX2FtZGdwdV9ibyhkbWFfYnVmLT5w
cml2KTsNCj4gKw0KPiArCQlmbGFncyB8PSBvdGhlci0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFU
RV9DUFVfR1RUX1VTV0M7DQo+ICsJfQ0KPiArDQo+ICAgCXJldCA9IGFtZGdwdV9nZW1fb2JqZWN0
X2NyZWF0ZShhZGV2LCBkbWFfYnVmLT5zaXplLCBQQUdFX1NJWkUsDQo+IC0JCQlBTURHUFVfR0VN
X0RPTUFJTl9DUFUsDQo+IC0JCQkwLCB0dG1fYm9fdHlwZV9zZywgcmVzdiwgJmdvYmopOw0KPiAr
CQkJCSAgICAgICBBTURHUFVfR0VNX0RPTUFJTl9DUFUsIGZsYWdzLA0KPiArCQkJCSAgICAgICB0
dG1fYm9fdHlwZV9zZywgcmVzdiwgJmdvYmopOw0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJZ290byBl
cnJvcjsNCj4gICANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
