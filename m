Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E47C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 13:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1047AD8F;
	Fri,  3 Dec 2021 13:42:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0454B7AD88
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 13:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH3kEf3Oi9dQdsVRwZt6h1jFr7edhn/2xoxDfFAeb8uCg31Wcz/odjfaOgatGqell4R3gw6M6HxdAr2PhKivHplgH+4efFs6KmXgxVml27fKCTPE0fjSHUPHGH9mGGgK0tGCpbfsLs6rdx4nje+a7B/yZSdJv9Twh5fWRIzmS3pH+ByY5/F+MKuuSbIOVS0DGlG0BvXL0k9o2e5FvYIIJ6t1V/bJta9Z1GB+2MPYUz3LqS/bekLzQG3JpCcH1k9lyamT147+ZiGZRsTFwO/mMywYqrSTXsmA6C2xpiYs93xxrlxKoaxXOBPYkXCH5dEBjb++Jt8I11L/Suli6R+fUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElMGInqz+rgHe5mB+h0hAwXV8QV9sdPJofvA1705/Mc=;
 b=IoYJkNITvS5O0R4DXQwp51cR2mKeWRtJCMroLWSn8Oa06LMMWjW58Ok6ONfllIz/6pzk3tcLWu/YdDsEr0LtrmRfIr9+qzhT+08t4r9asqDeBIlCnRMlxqXsDpuVY4wDrORRmhZ1itC/oqlFDojICofs9ONUI5ubDq0Q6XCCI9BO2gVW/0FsGN2T3egkgzEF98ui0X/GI3cbjPMZacR5bDFK3sDYlTGhmOFImg19cPrDLr+v+u/58feSKMTG6J0LsiP0gUnrY9h75lFumzNID0+mkBnuZU597ZdHsXxvQvXSDm+bWFUqv3kXkznD6rNjMpz/yuLFIU6lt6RBYXrvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElMGInqz+rgHe5mB+h0hAwXV8QV9sdPJofvA1705/Mc=;
 b=HO07Q509DYIvRAm5qpIoCtsiH5YJQPSMC4JXHu3SyS7pbyQuBxaevJteY2xmHPykwGcybotkfwLxmqn5hAqoMLGXNSON25DnLoIWXZXKOAebcsrNBBFa+7bfjJrT2UQdmUoTfo9twt1orSGaq0BuPqylJQ4chPvMVPH4KIdQ8qk=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 13:42:49 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::f97d:23d2:78a:2beb]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::f97d:23d2:78a:2beb%6]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 13:42:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [v3] drm/amdgpu: reset asic after system-wide suspend aborted (v3)
Thread-Topic: [v3] drm/amdgpu: reset asic after system-wide suspend aborted
 (v3)
Thread-Index: AQHX5uOwKDgLi/8IoEGk0PRX0RXCXKweCFwAgAKel1A=
Date: Fri, 3 Dec 2021 13:42:48 +0000
Message-ID: <BYAPR12MB3238A5912E60928BDBADE54CFB6A9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
 <0bf43968-25fb-7303-ad93-e7d79a0105a5@amd.com>
 <CADnq5_Pqbgvpmra2RPtgP4Ww8DUOCZ1hz7hwdmKoQLKOF=M1xg@mail.gmail.com>
In-Reply-To: <CADnq5_Pqbgvpmra2RPtgP4Ww8DUOCZ1hz7hwdmKoQLKOF=M1xg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=605bb67a-5de7-4760-85f3-006608d3d6f1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-03T11:39:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d63ede4-6e83-4a85-9b02-08d9b662cb98
x-ms-traffictypediagnostic: BYAPR12MB2677:
x-microsoft-antispam-prvs: <BYAPR12MB26770B23E131241BF0EFB14FFB6A9@BYAPR12MB2677.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7KoskMme3KPVKs6aSuAbG6fa+bgRILCk06VMmTjdiuDg0F+ZbDcgwYsN+RF4jEsWyf+WLHLGU901TNqml0OQRVms0OowDKQ2vfjFxgne3QsquXrLBjphvH0DvmBbYZ+HR6/D7inQBKdRmHsUvw7zzpQWOLE3d0FVuf6QFnHnObCkt3geXmF3oALXP9I3BAigFxuFDv9YDI2YkM3I3CzvnAanPe7hDYZdlpSChEIHtoPQ/xQqm+mlxBhWfk887fzhACW1qAOofB/u8OYgGvp015ZsEVG/g7Go7TWm4bPuxHm82zNy1qNZlV3LCBENUWQDckwZ8ZfFkjLkl//dxylNiJBRSNswgBGpEYKWAEPKFNuNsNLziaol83Wz2LN1/YuGTxMPpJewR+Uph2JOEPCoy4U5940ypjSSIMuzb2HWEHCvxJNLPqenAXN10yLy1cFbncZ/pmLJxf7fnBsrlxcTLNsgLk+wSwjxhKmqeYLt+UXxBtlM2kyi/Vc/hbvlUmGcQqUDQpZsY6X7AgfdPsF590ZYeV83WhmRnRyfdWdV99ILWS6YQ8GPNyZvCy/O3CH0ud2CNxYBSmaU5ieAp24asxgtEPFr4xSTgvvgd2oXzUAJ1WJ+fAtmgSvnHK7bCyrndS8gzhLz5tcqXQb23n3SUVexudyNrFMxI4rlMw/cQza/nNxa0iZo5HUqJylMWT8YcNyr5jNMULZ558ISVlJzpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(64756008)(508600001)(8936002)(76116006)(5660300002)(9686003)(7696005)(26005)(8676002)(53546011)(6636002)(6506007)(186003)(86362001)(66476007)(15650500001)(66446008)(83380400001)(33656002)(38100700002)(52536014)(54906003)(110136005)(66556008)(2906002)(122000001)(66946007)(316002)(4326008)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akljcWRoZzlubURyb3oySXVQMVdMNnp4VytpcU9uYjl2cEFWcnJ6c0RqV0hV?=
 =?utf-8?B?NUc4TGxwclRualMyRk9tT25mM1hxdW5rZjBtTE84N1d1dE5XRTZ2cXFxVVZD?=
 =?utf-8?B?NW9MZlJmenZXZzgwdGlNY1FVV0R2RnFUZEdTc2xsaTIwWW1wVEQ4Nkhidmtr?=
 =?utf-8?B?MXFqZlBpQzBmeHk1MGNxRGZYS0thM2w5UldYb0R1d2JJc0dWb0JlVGR4Vkt4?=
 =?utf-8?B?aVZCd3NSRlBnblJ3N0NYZEdTT091b1NmUnJ4anNKenFFWXpVbVpzK2VsN3VP?=
 =?utf-8?B?T1VMdVBHZlR6VFBUeXBONVJ0R2h1VTRuQUVzT0MyMWk4NHVwd2IzdHVRTHZm?=
 =?utf-8?B?UzYxQStBYzNSQVo3NTlBMkxwSmlHdnROL0RlMlpZQUpPN3NmYURIdm9hdGxa?=
 =?utf-8?B?a2tvV0dWcHFGaE8zNWQySHpodUpnSzRyQkgya1VFTzNyM3FqU2xwU2NodUJt?=
 =?utf-8?B?NDdERlZwY2MzK2QzZzEwWnF4K3JiVlhvdFNVRk1WS0VrRnZsNHdJL0hVNnk3?=
 =?utf-8?B?Z0hpYkdBYUFqV2RNVUQyQi8wOEtNUXRLck5rL0RRWHl2QmxCUnV0amoyVys5?=
 =?utf-8?B?dUc0WXpoRzN3NXIva0VDYmpPYUNIV2xmT2lIQkYrK1UveGhoeTlCQkIvL3RC?=
 =?utf-8?B?TUtadjBGS1lCWkVvbGxndER3WlVaZU9OdEpVSGR2VTZNVzRiY2lGTGlyMUFm?=
 =?utf-8?B?RlpubWU5aWRwSnFmcXdmWVdOdTVOLzFZNU5ZNCtBZWt1UXdOUUJMdEp4S2c4?=
 =?utf-8?B?U0N6VlcvcStpRE9KSzV2djlxRHJaUzVRVEk1cUNCUnBOek5JbnZUZEkzV2lT?=
 =?utf-8?B?TTNOSVkvdDBBWXhvMC9FT1FkZVRJZWZaSXVFa0dIS1IycVdrTHFaL08vQ0FT?=
 =?utf-8?B?Z3p1a0ROUGZEVjBzRE95QXZKWTJtRU1lbU1qcTh1NzVOcE9uemVrSW1IRDZV?=
 =?utf-8?B?VjI1ZnBsTjdyeHpnTGNMa1NoUTI2V2JWTjJRTGpWQ0ZmdEF0YlNGN0VaelJ4?=
 =?utf-8?B?NkJkNHRvNW8rZk05c0xOWERhK3Zkb3ZoSmNQSDJBM1hzYUJ4OGNOL3RBK084?=
 =?utf-8?B?Wmo2a3N3dXB0Q2dERExqYjcxMUFxZWttT0dCRUNBV1VicjhBUVM4K0lXTzZL?=
 =?utf-8?B?dUNLRmZlOHhSanZMK0pNMHhuSDNXT0MxcWo2YVpGb2VZZVRRT012MU41NHhE?=
 =?utf-8?B?ZEIwZFdtV0ZIbGR3ZEthNktpMlpqT1o4UG5KckFRQnJmRGU2UWxYMjgydGVr?=
 =?utf-8?B?UWJYcGN2NXlTTGlncXl3RE5sa0VZd3FlT00wVW94WjdneEM1Vm0rU2FJVE9K?=
 =?utf-8?B?MzY0ekx3WXVQTmx3SWRGSWVxVzBYdDZBN1BSN1B2UEdYcUtrb0swMjdxSzgv?=
 =?utf-8?B?U2NRMWdHV1gxaU12Tk12QWhCYUxqS0xUZ3JEMm9rUHFBMmZyOExyL3ZkS21O?=
 =?utf-8?B?Smg1cCtPSzdzdUtseWFMOWxtM1lPUVZuOFpFQnp3VW9xRStWS2kwYk9JbWhn?=
 =?utf-8?B?WlRtYkdqVWlHa1BjUnNRdWREZXlGdmpwT2VvZ1AyTU0wdVkxQmdlVVpSRTFJ?=
 =?utf-8?B?a21lQWQ0bERvQzJRWnZxSmQ1c0x1OFlsbWlhaElFc3JLR1VOOGNkcWNiYVRw?=
 =?utf-8?B?UEsyZ1ZCeGZQelY5ajBhYTh4czlDbGttQ1k0UGVVcm5pbmhkTXZDOFhZUzF2?=
 =?utf-8?B?N2w2bEJKdmptWjNUdDFhVmcwQ1J3VDc1V1gxMHlFdkRDNytQSTl3eWxBTmp3?=
 =?utf-8?B?azVhbTFLWDJIQ3dTZ2lxM2ZRcTFtMTJ4QjRwZWFIeHAyOFlNN0lXbjE5bzdo?=
 =?utf-8?B?aG9YUFJPdkNnazBpOHkrMzJhWnJMSXMyV1VtMUhOdUZmTG56L0oyK3haWGZy?=
 =?utf-8?B?ZXZRdUM3TngvMFJCRkhhY29Pb1NZcnFIMk9za1BnZ1BIRHBhZGkxN3lwdkdj?=
 =?utf-8?B?TlpNK3lGbFNCVHEzbG84U2lTeWZuNWRrZndMSyt3SWRoRkpZdURiQjJkejMz?=
 =?utf-8?B?alRzQ3dzSHh2c0RDZC9oYzd3WWhqTE5sSnBsQ3VaS0pobkU0R01uOTdRMFFp?=
 =?utf-8?B?czN1NGdHVW1GczlhYzNZdzY2Nkd1enA1OVlwcW13azN4RUhzTlVsbG1ZUlZX?=
 =?utf-8?Q?iMJY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d63ede4-6e83-4a85-9b02-08d9b662cb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 13:42:48.5453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBJH2oVHTf/h2rRawVgqoxCC5fW6uMxfia1qtq35H9IuRL26fvQRUHfRfu1fQUk+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVy
IDIsIDIwMjEgMzozOSBBTQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPg0KPiBDYzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsg
YW1kLWdmeCBsaXN0IDxhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBEZXVjaGVy
LCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMYXphciwgTGlqbyA8
TGlqby5MYXphckBhbWQuY29tPjsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbdjNdIGRybS9hbWRncHU6IHJlc2V0IGFzaWMgYWZ0ZXIgc3lzdGVtLXdp
ZGUgc3VzcGVuZCBhYm9ydGVkDQo+ICh2MykNCj4NCj4gT24gV2VkLCBEZWMgMSwgMjAyMSBhdCAx
OjQ2IFBNIExpbW9uY2llbGxvLCBNYXJpbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiAxMS8yNC8yMDIxIDIzOjQ4LCBQcmlrZSBMaWFuZyB3cm90ZToN
Cj4gPiA+IERvIEFTSUMgcmVzZXQgYXQgdGhlIG1vbWVudCBTeCBzdXNwZW5kIGFib3J0ZWQgYmVo
aW5kIG9mIGFtZGdwdQ0KPiA+ID4gc3VzcGVuZCB0byBrZWVwIEFNREdQVSBpbiBhIGNsZWFuIHJl
c2V0IHN0YXRlIGFuZCB0aGF0IGNhbiBhdm9pZA0KPiA+ID4gcmUtaW5pdGlhbGl6ZSBkZXZpY2Ug
aW1wcm9wZXJseSBlcnJvci4gQ3VycmVudGx5LHdlIGp1c3QgYWx3YXlzIGRvDQo+ID4gPiBhc2lj
IHJlc2V0IGluIHRoZSBhbWRncHUgcmVzdW1lIHVudGlsIHNvcnQgb3V0IHRoZSBQTSBhYm9ydCBj
YXNlLg0KPiA+ID4NCj4gPiA+IHYyOiBSZW1vdmUgaW5jb21wbGV0ZSBQTSBhYm9ydCBmbGFnIGFu
ZCBhZGQgR1BVIGhpdmUgY2FzZSBjaGVjayBmb3INCj4gPiA+IEdQVSByZXNldC4NCj4gPiA+DQo+
ID4gPiB2MzogU29tZSBkR1BVIHJlc2V0IG1ldGhvZCBub3Qgc3VwcG9ydCBhdCB0aGUgZWFybHkg
cmVzdW1lIHRpbWUgYW5kDQo+ID4gPiB0ZW1wcm9yYXJ5IHNraXAgdGhlIGRHUFUgY2FzZS4NCj4g
PiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgfCA4ICsrKysrKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPiA+ID4gaW5kZXggN2Q0MTE1ZC4uZjZlMWE2YSAxMDA2NDQNCj4gPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gPiBA
QCAtMzk4Myw2ICszOTgzLDE0IEBAIGludCBhbWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QNCj4g
ZHJtX2RldmljZSAqZGV2LCBib29sIGZiY29uKQ0KPiA+ID4gICAgICAgaWYgKGFkZXYtPmluX3Mw
aXgpDQo+ID4gPiAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfc3RhdGVfY2hhbmdlX3NldChhZGV2
LA0KPiA+ID4gc0dwdUNoYW5nZVN0YXRlX0QwRW50cnkpOw0KPiA+ID4NCj4gPiA+ICsgICAgIC8q
VE9ETzogSW4gb3JkZXIgdG8gbm90IGxldCBhbGwtYWx3YXlzIGFzaWMgcmVzZXQgYWZmZWN0IHJl
c3VtZSBsYXRlbmN5DQo+ID4gPiArICAgICAgKiBuZWVkIHNvcnQgb3V0IHRoZSBjYXNlIHdoaWNo
IHJlYWxseSBuZWVkIGFzaWMgcmVzZXQgaW4gdGhlIHJlc3VtZQ0KPiBwcm9jZXNzLg0KPiA+ID4g
KyAgICAgICogQXMgdG8gdGhlIGtub3duIGlzc3VlIG9uIHRoZSBzeXN0ZW0gc3VzcGVuZCBhYm9y
dCBiZWhpbmQgdGhlDQo+IEFNREdQVSBzdXNwZW5kLA0KPiA+ID4gKyAgICAgICogbWF5IGNhbiBz
b3J0IHRoaXMgY2FzZSBieSBjaGVja2luZyBzdHJ1Y3Qgc3VzcGVuZF9zdGF0cyB3aGljaCBuZWVk
DQo+IGV4cG9ydGVkDQo+ID4gPiArICAgICAgKiBmaXJzdGx5Lg0KPiA+ID4gKyAgICAgICovDQo+
ID4gPiArICAgICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQ0KPiA+ID4gKyAgICAgICAg
ICAgICBhbWRncHVfYXNpY19yZXNldChhZGV2KTsNCj4gPg0KPiA+IElkZWFsbHkgeW91IG9ubHkg
d2FudCB0aGlzIHRvIGhhcHBlbiBvbiBTMyByaWdodD8gIFNvIHNob3VsZG4ndCB0aGVyZQ0KPiA+
IGJlIGFuIGV4dHJhIGNoZWNrIGZvciBgYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3RpdmVgPw0KPg0K
PiBTaG91bGRuJ3QgbWF0dGVyIG9uIHRoZSByZXN1bWUgc2lkZS4gIE9ubHkgdGhlIHN1c3BlbmQg
c2lkZS4gIElmIHdlIHJlc2V0IGluDQo+IHN1c3BlbmQsIHdlJ2QgZW5kIHVwIGRpc2FibGluZyBn
ZnhvZmYuICBPbiB0aGUgcmVzdW1lIHNpZGUsIGl0IHNob3VsZCBzYWZlLA0KPiBidXQgdGhlIHJl
c3VtZSBwYXRocyBmb3IgdmFyaW91cyBJUHMgcHJvYmFibHkgYXJlIG5vdCBhZGVxdWF0ZSB0byBk
ZWFsIHdpdGgNCj4gYSByZXNldCBmb3IgUzBpMyBzaW5jZSB0aGV5IGRvbid0IHJlLWluaXQgYXMg
bXVjaCBoYXJkd2FyZS4gIFNvIGl0J3MgcHJvYmFibHkNCj4gYmV0dGVyIHRvIHNraXAgdGhpcyBm
b3IgUzBpMy4NCj4NCj4gQWxleA0KPg0KVGhlcmUncyBtYXkgc29tZSBJUCBzdXNwZW5kL3Jlc3Vt
ZSBzZXF1ZW5jZSBub3QgcHJvZ3JhbSBjb3JyZWN0bHkgYW5kIHdoZW4gYWJvcnQgdGhlIHMyaWRs
ZSBhZnRlciBBTURHUFUgc3VzcGVuZCBjYW4gc2VlIHNvbWUgb3RoZXIgZXJyb3IgaW4gdGhlIFNN
VS9TRE1BIHJlc3VtZS4gSG93ZXZlciwgdGhhdCBzZWVtcyBkaWZmZXJlbnQgc3ltcHRvbSBpbiB0
aGUgUzMgYWJvcnQgY2FzZSBhbmQgd2lsbCBoYW5kbGUgaXQgc2VwYXJhdGVseS4NCg0KPg0KPiA+
DQo+ID4gPiAgICAgICAvKiBwb3N0IGNhcmQgKi8NCj4gPiA+ICAgICAgIGlmIChhbWRncHVfZGV2
aWNlX25lZWRfcG9zdChhZGV2KSkgew0KPiA+ID4gICAgICAgICAgICAgICByID0gYW1kZ3B1X2Rl
dmljZV9hc2ljX2luaXQoYWRldik7DQo+ID4gPg0KPiA+DQo=
