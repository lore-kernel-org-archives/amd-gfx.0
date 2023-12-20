Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A9FC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 05:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E966110E310;
	Wed, 20 Dec 2023 05:40:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7090910E310
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 05:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAw4NfOCuahVKON3/ErDsNVq0c8KtdD0rsTT+xxKRXeTnExn3hDof+fzFrygvjzdhIT3P6KWtFQFOyloLWcDx0U91swUKuAP9IKe8cyQC69qU3BFNvGVaFteNZbNHGGKNJBIH4AKCy/6L4cdfY0yT8MQSlUbito/NwZP9nnjnAONyt4fsG5ohuZ6WDqvm2K/ook5BxYWYvA4bedK7cPHdzH2r5E77vs+Pcoxryk0agIqt9QgLrc1lqt+sxLP9gxVA0Owq2nStRfm7z03t6rT1VApEf3nCGoBLGQQpAmnIkMRVoqIUnSb2XlYSHIsRQArVIHDuRAePxN8u4PvjaCWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cspL+L5FJXorebC0c0oLFkSe1VtWZoswwtkJfD31cQ=;
 b=KEWMFop2zUOpdRzY0EYpPYVpURgr6RJMNoRnUx2fgLxt663T0bdQq8j6FSf+Wwm8N+REixsGDyQdKuUmjSWtOBUcf6q6OqH9uB26RUqQ5j5cFW5bgEArVoXtO2DBa9wN6W8Gqg6wJTAcUfJPGZ5edSOVJAR5IKSVtFKf0WlnbYzAT0FVa42avpvnymOuX7qG12A11Ji7EaKlkgItu9sSMENU0PQa1FpKwV53QX2vbA7l+ksshCosYoaAjIsz3B2BO7hpq+WeRdQ9+4Rn7RjQWXwd2hyBZhy2fQmVJHcCK9fPqfroH+u1x97h7+3mh+pbUHm1nzCRdAJ3LFf2m9+hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cspL+L5FJXorebC0c0oLFkSe1VtWZoswwtkJfD31cQ=;
 b=QfIXY0vEnqJHhWX3bMZVycH8rs20LMiljhZBZHamAk9Xi3AswzACnRNJEBNq9AMsK35kzJd72OqtLMKpQKeJgDITJxjHrzd9MS4Sx5zD69i6tkFvju46EO2KPST5JQpQcChk9OCjQI+prRuL7jhtyAjuBBOFqAr1ym2q/X3HRJM=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 05:40:42 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 05:40:42 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu : Add register read/write debugfs support
 for AID's
Thread-Topic: [PATCH v4] drm/amdgpu : Add register read/write debugfs support
 for AID's
Thread-Index: AQHaMwM8rF2UiSM/FEaigQ/I/H2S3LCxp96w
Date: Wed, 20 Dec 2023 05:40:42 +0000
Message-ID: <DS7PR12MB60717D470174A55B46A67E558E96A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231220051234.2234962-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20231220051234.2234962-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cb6d3f48-9e29-4155-8ef6-6c72296727ec;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-20T05:39:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|LV2PR12MB5775:EE_
x-ms-office365-filtering-correlation-id: 5eff797f-9275-4ac6-a4fe-08dc011e34cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JiFfN0F6urhvmRFgx/YFIcAQnBtPSoKoYlqX2KyS3EunqL/W+Ygmf0/XjwxUCAxA7swUKo8Aad2B07lUZK4t6ZNV+RpyPy78aLqkAzezs3fUkYsm+jnMbbuH5aaO6CyyK3buqTph/on94Hgw2v3xpQPyRKpguAhXHOJOl7gLbQXKt/96C6gkglzsIGsGnDSc0PODYY4OmOdjkDK2Tfh6vajJZNlcDYmNVTEUgQ5fXHqHQOcZQH6deeBt4ZPuYoOD+pj1wcmDUBM8qEHyPR6+IW+6kP/UgFmtI5xWEr0nH/4fe9X9snzYN5ob9BZ1oFG6uss3FbJwcdwc6+CL4oxWLVhppGKpTQNF1zjSib6OzOO/lw4F+AzYEH2YwvgJs123ImLvp6uf3v7BZdltAQ8l9oPOwEQvfd6JmQeWnsIueCWJErLR4Q3hjSngI3BrpVTRozk8RTfYkUUkbPlJZHIo3NdeN4COFRl+IApZrqajS/yKgOgl5BwdwEzjd2ZVDnjeX2NwhK+LUyoitktdPI3G7ynW1501foszUNZ3eB6hDTxc9RtXPVwq7HnMkI0pj5HgrJ64VB717xmtWMq5gVstTekK7tcFNbno6gIFZXQciORshSf/Q3qIhxeRk+3kdzR5/f3NxbaqMqQC5CZ9rfD97R8TVAsGkQXCZ0d2WVyJvMo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(26005)(66574015)(86362001)(38070700009)(38100700002)(33656002)(9686003)(52536014)(4326008)(5660300002)(83380400001)(6506007)(53546011)(71200400001)(7696005)(110136005)(76116006)(8936002)(66556008)(316002)(54906003)(66446008)(478600001)(66946007)(64756008)(66476007)(2906002)(122000001)(8676002)(41300700001)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWErRzkxTUdjWGQxTFlLKzFSdHhPOWtQUUpuajk1dlg5azR6WkNtTDJzakJ2?=
 =?utf-8?B?MzJ5SGNBYnFHREpzNDZCWG96YUhpT3Y1TUJSQlFFeDlwTjlRWHhTSk4yQWJR?=
 =?utf-8?B?bFpMVXF4WGNvaEZuSnNVLy83YUd6dmwvdDNYY2s0SWt5K3ZOWS9ZV1p0OUJ4?=
 =?utf-8?B?NC9SQU5UUkVGUTI3Q0M0bHFnY3ZkVnJHMnJZWGNGcFJvU2lHWVIybFJoZ3hh?=
 =?utf-8?B?bVlwK1ovc2hwR1lzZWp0N3E3Q3Fhek5GSFM1ME00REpJalRjTVUzR3JaZDRJ?=
 =?utf-8?B?aGpBeTdydlpZSDV3UXJjU1RKZFhUc1BtUXdHdkgxdjJGR1prd2tkNDVuWFBm?=
 =?utf-8?B?dXlud1d3YUNMZ3l4R0JFNVBvVjZ1MUNNekRkcDM4TnRCcm00Q3NaSXdZb1dS?=
 =?utf-8?B?ZHFzZXlqS2pHYkVlUmlkc2xGYUtEait5S1hrSFVHQ3ZVQTl6YUU2azM4bnBM?=
 =?utf-8?B?T1V5bERoTGtqNE9nVkJTS2k0eVRyZS93RWZwMWVFK2ljUGttV1orUW1BWGdy?=
 =?utf-8?B?RkpqaDFHWUNHaHBoT25mdldWcnNDOExIbXZyVUppMDJWTDl4VC96M3RjZ3JR?=
 =?utf-8?B?S3dUZHZ2VFlUa2JWUnhHenJLSGozdG5BTDJkR2lNSDcyUzhiKzljS1E1Z0xC?=
 =?utf-8?B?ZGlxWGtQY3RPUWwwd3l2dWE5RjlJbE1xL1BLNjh5TGtRTlFCTVpHMmtSNTZy?=
 =?utf-8?B?Zmd0VGdQYnBhQTV0amNxcUZTM2tJN0plUnhYQ1NEM0JlZVdIZGtGT3VBM1pC?=
 =?utf-8?B?cnJtMC9sNWZ0N0FkbnNGWm5mQlhXRmluemxCTXJEeDJSbGozOTRVZ2FOcDJN?=
 =?utf-8?B?REswd3E5cGlnaHozL2xvUytiaTNPODE1UTBQNm4ySElmbW55bEl5N0RSRDNw?=
 =?utf-8?B?NVVJN0hvUzBqTFU5Y0RYK3VpdlhBSTk0WHhhWE40NEx0emNoSnRLQnhVeHZS?=
 =?utf-8?B?WlNNYXp4K2kxM01tSmx2VHBMMHRnOStNblFNS0lQMGpBM0lPNjNoQkdjK0pO?=
 =?utf-8?B?Y3BHc2FwOHVJeTIzK1p1Z29vRjdZL0xtc2lzVTA2b21oQXRTcVd2enVOVi92?=
 =?utf-8?B?clBBc3dONk9MQjF4ODVhVkZpdElzZ1hBdThUZEJCQmZaSWZ5R3RUZFFBd1JL?=
 =?utf-8?B?MEhyS3lkSDJXUTJmNEFUdXMrU1ppb3plTjF4cjhTRytXR3lKSEE0aEZQTnRy?=
 =?utf-8?B?d1UzaU0vYWp0Nm96U1lzR2dwOXZlL2Z1UGFuYjErblJ1M3hzY0ZKZXVTdDNK?=
 =?utf-8?B?R3grWTg5bGJxcy92aGttYjRTcitJTDVLMEJia1gxWFZZZ3RySlBJbGd3NDNj?=
 =?utf-8?B?Q1VtdForS3RDQWZSRW5lenZBV21UdjlkMDBpYlFoR2tYekpXSXZTbVlRV21s?=
 =?utf-8?B?cnpZMk5vbGpWQlZqZDdpYkVuOGpRTmNabU5JdUFlbFhFUGhha2h2ajRjS3ZB?=
 =?utf-8?B?QllidHNkR25jYmNhSzVuTVJsTzY3UXZ6QnBlZEhpWHlicUhYTS9GYUZINk9C?=
 =?utf-8?B?a3VtbGtwMFozYmpEaVNLcHYzQVNDZ1haNFhLVERXRGtINmQvYU1lczMvd2l1?=
 =?utf-8?B?MzdPdEN3bEVuaHFDRlpFRVBYdUpqMS9WVXZYTHlnL0p5WXl3UjlWS0wrd2sx?=
 =?utf-8?B?VHRkZUJFTCtkRGJoZmEvZUFsTVd1T3ZzMzZDUythNVFDL1NDbGFoa3hyK1l1?=
 =?utf-8?B?TTlqR082QUZaTGVjbktDSVNEWjFSbndldEFaem5RcmFMWlZBZXN3MWVJelB3?=
 =?utf-8?B?QmVtOGVXdlVvOE5UZ0RzWG1mL2I3Ky9uSEMzWkpLOTZSMkpGbFdPdnZvcUtk?=
 =?utf-8?B?Zzlpam1kRGRJdm5pMjkvQlpTM1N5OW5CcFZkcTB5OTROcStUVXl1QlZ0akUz?=
 =?utf-8?B?bXplT3MzMVAxT0F2aTBGODZ2b2hzQ25xM3ByTkYyL0NSc09SNmRnaTdHQTI4?=
 =?utf-8?B?SEROZU96dSs4YVZMUmZwU05vdGZjZUVBKy9HTllicnZ2ZzdYaUtVVy96cTln?=
 =?utf-8?B?ODFnSCtmaTlMd0d6WnNXQy9sYTJwbnpWQ3JITUtZU2ZpZE5PaXZPNEM0Rytp?=
 =?utf-8?B?MEwrTDM2UFNYa09NUnZESjd6WFpkQWhRZ1k2QWRHVVNLaWE4ZCthZWtGREU2?=
 =?utf-8?Q?OHEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff797f-9275-4ac6-a4fe-08dc011e34cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 05:40:42.5755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uiXNVjO89paY7s2kZe66GZOeAyTWM6/2QIrHXY8ZmvCH+JZl7OLGrwCvHlOHlxQDoLg6e1fkiHn9Ei7x1yCmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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
Cc: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBBc2FkIEth
bWFsIDxhc2FkLmthbWFsQGFtZC5jb20+DQoNClRoYW5rcyAmIFJlZ2FyZHMNCkFzYWQNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNYW5nZXNoIEdhZHJlDQpTZW50OiBX
ZWRuZXNkYXksIERlY2VtYmVyIDIwLCAyMDIzIDEwOjQzIEFNDQpUbzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBM
YXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KQ2M6IEdhZHJlLCBNYW5nZXNoIDxNYW5n
ZXNoLkdhZHJlQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KU3ViamVjdDogW1BBVENIIHY0XSBkcm0vYW1kZ3B1IDogQWRkIHJlZ2lzdGVyIHJl
YWQvd3JpdGUgZGVidWdmcyBzdXBwb3J0IGZvciBBSUQncw0KDQpTTU4gYWRkcmVzcyBpcyBsYXJn
ZXIgdGhhbiAzMiBiaXRzIGZvciByZWdpc3RlcnMgb24gZGlmZmVyZW50IEFJRCdzIFVwZGF0aW5n
IGV4aXN0aW5nIGludGVyZmFjZSB0byBzdXBwb3J0IGFjY2VzcyB0byBzdWNoIHJlZ2lzdGVycy4N
Cg0KU2lnbmVkLW9mZi1ieTogTWFuZ2VzaCBHYWRyZSA8TWFuZ2VzaC5HYWRyZUBhbWQuY29tPg0K
UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
Ci0tLQ0KdjIgOiBBZGRpbmcgaGFyZHdhcmUgZmFtaWx5IGNoZWNrIGZvciBjcmVhdGluZw0KICAg
ICBkZWJ1Z2ZzIGludGVyZmFjZSBmb3IgUENJZSByZWdpc3RlciBhY2Nlc3MNCnYzIDogSW5zdGVh
ZCBvZiBjcmVhdGluZyBuZXcgZGVidWdmcyBpbnRlcmZhY2Usbm93IHVzaW5nDQogICAgIGV4aXN0
aW5nIGludGVyZmFjZSB3aXRoIGFkZHJlc3MgcmFuZ2UgY2hlY2sgZm9yDQogICAgIGNhbGwgdG8g
YXBwcm9wcmlhdGUgaW50ZXJmYWNlIChMaWpvKQ0KdjQgOiBVc2luZyBhdmFpbGFibGUgaGVscGVy
IGluc3RlYWQgb2YgZXhwbGljaXQgcmlnaHQNCiAgICAgc2hpZnQgb3BlcmF0aW9ucyAoQ2hyaXN0
aWFuKQ0KDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIHwg
MTEgKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMN
CmluZGV4IDk2ZDYzNGJmYTQ0OC4uMzkxYWY4MDYwNzA0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KQEAgLTU1OSw3ICs1NTksMTEgQEAgc3RhdGlj
IHNzaXplX3QgYW1kZ3B1X2RlYnVnZnNfcmVnc19wY2llX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNo
YXIgX191c2VyICpidWYsDQogICAgICAgIHdoaWxlIChzaXplKSB7DQogICAgICAgICAgICAgICAg
dWludDMyX3QgdmFsdWU7DQoNCi0gICAgICAgICAgICAgICB2YWx1ZSA9IFJSRUczMl9QQ0lFKCpw
b3MpOw0KKyAgICAgICAgICAgICAgIGlmICh1cHBlcl8zMl9iaXRzKCpwb3MpKQ0KKyAgICAgICAg
ICAgICAgICAgICAgICAgdmFsdWUgPSBSUkVHMzJfUENJRV9FWFQoKnBvcyk7DQorICAgICAgICAg
ICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUgPSBSUkVHMzJfUENJRSgq
cG9zKTsNCisNCiAgICAgICAgICAgICAgICByID0gcHV0X3VzZXIodmFsdWUsICh1aW50MzJfdCAq
KWJ1Zik7DQogICAgICAgICAgICAgICAgaWYgKHIpDQogICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIG91dDsNCkBAIC02MTksNyArNjIzLDEwIEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9kZWJ1
Z2ZzX3JlZ3NfcGNpZV93cml0ZShzdHJ1Y3QgZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXINCiAg
ICAgICAgICAgICAgICBpZiAocikNCiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
DQotICAgICAgICAgICAgICAgV1JFRzMyX1BDSUUoKnBvcywgdmFsdWUpOw0KKyAgICAgICAgICAg
ICAgIGlmICh1cHBlcl8zMl9iaXRzKCpwb3MpKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgV1JF
RzMyX1BDSUVfRVhUKCpwb3MsIHZhbHVlKTsNCisgICAgICAgICAgICAgICBlbHNlDQorICAgICAg
ICAgICAgICAgICAgICAgICBXUkVHMzJfUENJRSgqcG9zLCB2YWx1ZSk7DQoNCiAgICAgICAgICAg
ICAgICByZXN1bHQgKz0gNDsNCiAgICAgICAgICAgICAgICBidWYgKz0gNDsNCi0tDQoyLjM0LjEN
Cg0K
