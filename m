Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11497606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UG4Z8MB6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9E410F931;
	Wed,  4 Nov 2026 01:45:56 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF39810F931
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 01:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzHO9hih575aFIpw4vLGK2tC5GlHuH9Jg8duzsxQC8j6MZM3kfoqrboqFvLRxOOlRBCoj7EMI4xj0YspKiyjg9R8Xw+c7LLHRXbkZl92qosFdwqeJHB0hZ7I2Fn38cSgt5P696k3Tl/Zs6qYj68t1GO7X3hTxhw5+Ek1cnf5+F3C4nb/wrIZuIEp+3F/E4h3+sWYwNSRuAI2LEgo8eR864k2u7ioQO+x2GP8cT0LArBDmhR1k8Qt3wxlejXfl9RfCUYUiRSY5szhwLhxvU3O39gElYv5+EnWQFphw3NK3pJ26bXAyC5dv9fRI0nug22eaih2RLun9A99e3BQ7woHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSkgRFWfRQPLfLyNiROqjD4Kk8NfBU+eceR67ZyeVwA=;
 b=nRTDrU8xd+4I0qE7BK7Z+YS7xy1ecN/uVGw7pIBX10UNMdi18/nNW3/yzXbUsu/mQMmLKWyOt7zcygOM94bcQngMJwhQsUfCZxqLx1Si2zD+ad4t2fdTG2AzZWcRF9ECexrjv4cG2PRw2ZiLekVD9SljkTFWeF3hCQL69sK37L30Vk6tYSlSCuAaL/4MwUhoVgHA4x89ZV0ZzQN1bpI5l3RQS0hxs9tJl/4qvxRD8DMFDOzguxReP1ktWxig+Xai1zeJuWKWUatapkOfzovyOA7p5akxosotHw7tlxOy95OWRF0CvyTGUgiYJ+35/oFSOVTpPD2I2k0zASL9qFZkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSkgRFWfRQPLfLyNiROqjD4Kk8NfBU+eceR67ZyeVwA=;
 b=UG4Z8MB6pvkwZX6QMfnHXP2tTbmGRJE5zodHKI6x7HVsQR8Ilog9IFcR5OjuMev0hW5cRUXZkMooldlTBqBj6zPE5Ort8reNBzmBDi0IEu49AnO6REomedY3oBl2owi6rOjr/FcgCIRxEMZ5EEv5QXM150brsStrNTIDZqSrmHk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 01:45:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 01:45:48 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring
 reset helpers
Thread-Topic: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring
 reset helpers
Thread-Index: AQHdZrpkNePgKZtMrk63p5BuaQmoZbcaBPsQgAD6yYCAAi7NcA==
Date: Wed, 4 Nov 2026 01:45:48 +0000
Message-ID: <BL1PR12MB5144F7B1AB8023E9E26E6478E3682@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <DM4PR12MB5152422F0100100566C3FBBEE36A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <c70939e1b39ec752697813c04eb641b21802cbb3.camel@gmail.com>
In-Reply-To: <c70939e1b39ec752697813c04eb641b21802cbb3.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T01:44:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DSVPR12MB664020:EE_
x-ms-office365-filtering-correlation-id: 8228d459-359e-41b8-a4c6-08df3a1559ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: dhTdjpXM9WFq0E1JcE6RECP80JCvl6GX5B8P6CMyGe1rWtjJpQPmck2LvpzfmnrfEyLJO/2llJPZqZrznLLjO6HdMM5S7J4MmUEqFkkHp9aXvJXpqrVkR1pzTy34Yzh2ttEpsCxRsxnlvPeLKRf/14obbJpEdR93CjFSv4rnhkMZOn8FKCmT4QjNgfkxeefchXQSMGp9tmCLgDlWKICMnI0CZXX3r8yuzSvui7u5ktRCKnNU4mux5bTHuxgTLEko6b9xxM/2GOaNyWjgDrvZfgMaxZUJFZnZlYvYOFbiX8Vtok3X4HqvgTD8Oo4xZ4Eq5Xy1uc7Z3dUtfCs6ESsJNznDXSupfXX+XlOdLIEFqZN3QSXauyN1Z+eTs5Y2um1D63KHVU5v8BYfafzzCojL+fplgtdVl58N9esSLWmorozHOV8W0b0vbZJZxuXFeQfvsI9y7ovWe/8URLAVHlVW4rIb2ySklZrLH6909594oeXpvZ49aOfP3+Pfua4NgYqu/2qcOJg+j5zuTVNH3YK26f+6z94pLbJQbd/BPpBndtpzgIPBQ/ZFxGYOfKcuvDEnJ7gzBiniplKZoNLZpl0CxFqy8Y2j55aquktMLl/UOSqMfeauHpXeCVXZUdiT7z+KLU0shK6EOx3kXX5YzBvHMWnnR0lsZGC6DD1qZTf8ikQ3SCkH27RkCcQSrPgzOQvj6v9bcP7E+A7XohiOPUm0/S08OOS4aXv9adoIctwdnZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWgzVkdhMmN2c1IrdUxRcVZxdks5aG5pYmx1NXRJM1gyQjllYldveXNZa3pi?=
 =?utf-8?B?OHBMZ0xqNWl2cDc5K0VZSnhKUU5rQ08raHgzYUxHK1VBeC9HRnI2TUY5N0Vv?=
 =?utf-8?B?RXZEVEN5R0xUM0x2L1R0UEtCRndmQ09Fck9jU3B5ZjVPa2puTCtGVVMxYlZD?=
 =?utf-8?B?VmZWQjcwTHVzWktCcGc2MEwyWTRiTEdIMnpxTVE4eGpCQndOalRMZ1hrNmRp?=
 =?utf-8?B?T0V5dGtmeFV2cGlLTDB1Y29yMzdlczdqNkZFSElYWUs2MXpCcWNJVkllSFZX?=
 =?utf-8?B?VzRUT0p4Vmp3UGJDK2hLQWNqbGxNenpQSHpNOENwMHVtQWlGNjhTQm02MjlV?=
 =?utf-8?B?OXdkRTFOVjNIOTNIQUxuVDhpNVg5OHgrWEsyRmxNZ2xZTU11NUlLZFZ1YTRN?=
 =?utf-8?B?am9QSDF0eEF3Z2plUkovc0VRV1pySlFWV3RQRnY5NEV5MnRQUk8rcWhzQXdQ?=
 =?utf-8?B?TFpQTnliY3IrOG94NzU2em9pcjJ6cDhLT0dLWDRPQjhENWhmU2tYVStjUVln?=
 =?utf-8?B?RjZHNlFsd01GaFhna0xuaUErbFRlOG1EWGYyNlpsOHFTQUM1d3BNTUl6bXgr?=
 =?utf-8?B?TkNZVFUwcGQ1S0MrQ2tCUTBJK0RoajZucTRwcm9zUEVXcXEyYTR2QVR0RXVG?=
 =?utf-8?B?U2IvcU9ESFRtTmFwVnlnQkVhVmRBMUJZL1h5REY2WEM0NS9hRFhxN0RsZFph?=
 =?utf-8?B?Z0JtMmtOZUpLVkNSd2daK0JKVFNRT3l2VGEwbjNVZjNQU0dHU1JkNWpBN1I5?=
 =?utf-8?B?VDZ3RjV3RXRxZ1RkVlh6bDBMNXZiWlMvZkRKWmViejZTb3I3bmdvdVNyS05r?=
 =?utf-8?B?QTlaMEMvTGNhOHAyejlTa3U2elM5MFNYWm56R3NOZmFrY3JGNVlPekVMMVA4?=
 =?utf-8?B?M3NtOFhrZ0xLWnVTOFdOZzJWSnBKSWRjS0RETVpXQVNRZUdHZXdJbjF1czJz?=
 =?utf-8?B?Qzg2TnYxbHd0RGpIdzhoUzI1WktBMld4UEhNYWVUZjZPeHQycVBQWmNMRzJG?=
 =?utf-8?B?eENaaHZKOVNORHJvZ0c1QUxwMk5wUzVWaVNiaXVzQUI2NTQ2YURCS1FkVGt4?=
 =?utf-8?B?STIwVG5ydjhZcG9ZTmg0T1o5c2Z3MHhuY2lxdXFDN0NlTC85SHQ2K0hJT3RT?=
 =?utf-8?B?N0x2b2h4U0VIeitjY1dMTGRtNDRpZnZtaWUwWjh1QmtRQjdRdmt5MjJEVlZI?=
 =?utf-8?B?bjYxQkNQak84Z0hKMDhCMVM4OGpVOGlteXc2OEg5Rkd0R2lKd2hRM0pRUG50?=
 =?utf-8?B?aXJhaStiSUJ6Wk1nZUFwVHAwNncxRjJZWlYxOTFCbjR1WWE1YUJWMXRRZXRJ?=
 =?utf-8?B?bjJrbmdveGpQbzVHN2YvMnFkZzA5MGdzNG9BVDc2bjZpV1ZnVUpLSmtWcEtT?=
 =?utf-8?B?bHZHTFhVUEVhbGRoUjhtdE5zemVhME1abGxJOXB5a296akhoRitXZXZPRHhT?=
 =?utf-8?B?R0dCd2pqcDNSeEIwMis5NXlLU3NyaEJ5NlZkZ0pWd1QvNk56TExITDZOc2lj?=
 =?utf-8?B?cFVIbkJqU09uemFkR3RONC9UTWpFS1RLY3JiOE9KbG4yUmhhZ2FUSVRxSFd1?=
 =?utf-8?B?Z3ZBVmhxUW5aQ1BvNEk2MmsxYlVLNkMvclBSNDNRaW40KzJLYUNsemFSNHBi?=
 =?utf-8?B?eXloa0tQdktRZXR2b2JDeENwbmxIQlhoMytEVTh6dFhQelI0b25JZU43L0Yw?=
 =?utf-8?B?V2ZmUEpVamNkVjBzVVJJMi9FaFZDK1F5RHpjMW1sTkYxdjV4dDJFMEVuTHBN?=
 =?utf-8?B?ZFRuWlR0cTJXUWJYK3JFTFU1UDU0V3BiQUt6cG9yaWpuYTg3Si8zR1pyN0ZK?=
 =?utf-8?B?b2lVQXlFL2lRamk4ZDIxdWRIS1RrbHA3Sy9aUDNKZ0JyL2t6eUtOUE9hSEw4?=
 =?utf-8?B?ZkxYcGk5b0dTbEpxeTFhM2VsL0xRYjFVTmI5RXduc1pwNzFqTGtZNDdrd25R?=
 =?utf-8?B?QnF3TjNCVmtQY0dCSWluT2tLc1BMUGU2RUdIbWFDbXkxU1p4alM1SjUvRVFj?=
 =?utf-8?B?TlQrSlR6U2RpV0txeU5pdk42OVh1eXB2c0FES0J2bHZ6YkdUZkg1STRScElP?=
 =?utf-8?B?MUVIM3ZiTFNMVnBxaDJJdHZoUUd6ZXpHcXRhNjJ0NEdUVE04dEZJNFVYZjZs?=
 =?utf-8?B?cmRVbThiMDYwV2xycHJOVlNRbE0zaDhqT1FNdUdIZDJtUUlzTTJOS1l4cGtK?=
 =?utf-8?B?NHM5R2E0OG9FMTl6Zno1b0xIbW1PMHR5eFhranVDNU10QUVsQzNLVVlEeUJm?=
 =?utf-8?B?TXdUMkhudzFVMGprazZndlN0LzRTbkhyNy9GaldKdGtlaHBTWmRaKzNuYlFy?=
 =?utf-8?Q?ZHBWxQoTirO3fjMwBE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8228d459-359e-41b8-a4c6-08df3a1559ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 01:45:48.2858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHPNC9nP/QysxTqzvHsUnXmsylU/GpnrFaMw3ymEwBz5vi+aq7jiF9QBqmwb/0LgfPM6J4WKOSXiCCURZlTLog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB664020
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5v
dmVtYmVyIDMsIDIwMjYgMTI6MjQgQU0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5a
aGFuZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENo
cmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8u
TGF6YXJAYW1kLmNvbT47IE1hcmlvDQo+IFNvcGVuYS1Ob3ZhbGVzIDxNYXJpby5Ob3ZhbGVzQGFt
ZC5jb20+OyBSYXN0b2dpLCBNYW51DQo+IDxNYW51LlJhc3RvZ2lAYW1kLmNvbT47IFpodSwgSmlv
bmd5dSAoSm9leSkgPEppb25neXUuWmh1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgMDEvMTVdIGRybS9hbWRncHU6IHBhc3MgdGhlIGRldmljZSB0byB0aGUgbXVsdGkgcmluZw0K
PiByZXNldCBoZWxwZXJzDQo+DQo+IE9uIE1vbiwgMjAyNi0xMS0wMiBhdCAwMToyOCArMDAwMCwg
WmhhbmcsIEplc3NlKEppZSkgd3JvdGU6DQo+ID4gQU1EIEdlbmVyYWwNCj4gPg0KPiA+IFBpbmcg
b24gdGhlIHNlcmllcyA/DQo+DQo+IEhpLA0KPg0KPiBJJ20gcmV2aWV3aW5nIHRoZSBzZXJpZXMs
IGp1c3QgbmVlZCBhIGxpdHRsZSBtb3JlIHRpbWUgdG8gZmluaXNoIG15IHJldmlldyBhbmQNCj4g
dGVzdCBpdC4NCkdvdCBpdCwgdGhhbmtzIHZlcnkgbXVjaCBUaW11ci4NCj4NCj4gVGhhbmtzLA0K
PiBUaW11cg0K
