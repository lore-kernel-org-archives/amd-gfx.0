Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5D606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ecpd97qi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7741510E056;
	Thu,  5 Nov 2026 02:09:36 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D900F10E056
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 02:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZaVdZU3rZ+bcdEtobZWSx408SzGIopiARh5JDtRWhASbcdHiR6wCcflw6eIvUlsGIZiGEi2HhZ/ZkU/zju6Ss0HvrP9Aix7agTBDCMHsRbkcKeKbn9RbRHa2ASUfMow11uCRyLf8FY/BZmoOeym3dvKn34AuciE9665KKzXShwHht1NsLvHDDhUHrc+higgS3nxC7Bb8uJ051m4ooAEK8NJ9eRT4EvmXqD7isdt6sPzNXnSyWQlEHzXdiT+Lc7GA87EOpIU52J+O1wv0C1H49ZlBCE1Md8I/b8x82q9IqJ48a7SKih+yN+aOtvlPACle7izvnc7HrxVTHICFxrj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iajYfTz0Q42Tnbi4dDDDb+sUt+g5fPBp9H8y0YB8ivs=;
 b=wV+uYPogbHWwJaTE7x0YcHc0rq02XnPCn4y88JN6K9CorYKc/RTQTO1nW+Cvs3QBWgMmI8t7rKrZKKegKv/bG7lumdHxlL0FY+d74iRemsuDwxbAkQzX1A613EIIslLrNr35+7A/iqA0gfscLr7Z++Rca2JGRN+aGZ4UlLagMA+XUHSE0sgBM6lb5v5UYO6xR/ojXCZpz4I6ndL54xOVjDarVhoIjcHXQTXz9x5xH3HE9f9dkbzU42DAfpIuwi+bbT1HyZ8+BoSu+DoPgK8kgPa9nRkHxpF6XVwecu0yf5cbZmWVzaFC8Im1/WmCI+AG1OWQ26pOZwMOIImKvhaJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iajYfTz0Q42Tnbi4dDDDb+sUt+g5fPBp9H8y0YB8ivs=;
 b=Ecpd97qiZoOCkyGNgn3g05W8icIwofABmmo6wD5o7cd2ke6/pJ6HLPMfee3aIViVloN0lUumr9baSi3hHPPuoF80V6hRQnutXBJ5tnLpb/9jjML8cjTyZ4exE4u8EGr5TUQsg/UueDXrUpUWbiTQt59CjjBPUR4MMjyQ/pVqubs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:09:27 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:09:26 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence at the end
 of a multi ring reset
Thread-Topic: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence at the
 end of a multi ring reset
Thread-Index: AQHdZrpmwcaBtj0HX0SqByryvYgRvrcc0cQAgABsSBCAAVExgIAANtDQ
Date: Thu, 5 Nov 2026 02:09:26 +0000
Message-ID: <DM4PR12MB5152D797B071B435A47CC599E3772@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-2-Jesse.Zhang@amd.com>
 <d744c7dedfc32ba6f1a66731eb9aa196f46af941.camel@gmail.com>
 <BL1PR12MB51441296195645049FBB4763E3682@BL1PR12MB5144.namprd12.prod.outlook.com>
 <837f5db76982c9d84f45bc5ecd04e0bd9de16a4d.camel@gmail.com>
In-Reply-To: <837f5db76982c9d84f45bc5ecd04e0bd9de16a4d.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-05T02:02:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB8712:EE_
x-ms-office365-filtering-correlation-id: 2756a118-4984-47fa-3ba1-08df3ae1d14c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006|261028144727099003|261022075727099003|261026140227099003|261102123227099003|261026121527099003|261009223327099003|261009223027099003|261021121427099003|261009220027099003|261009221727099003|261022105027099003|261009221227099003|38070700021;
x-microsoft-antispam-message-info: 1UiQS3SeaopnipVOVBFJhAiYjEG6A9UYpL9xrtT2Li6lvxRuzUwv5rBcXggHgfsoAzd7Z9KWTvjl/7SjsNJuZCvTm9443gKRkgMMZvuPxFUU9VXXHbIF53bJp7a1gN4rM4YoBgS5P7v9/F8b3PFJnOPZ9LI4qed5YfoWRNjgIq+h7tUZ+wN6r7bVVELuG+D2dbeDcui6+GOqskDeI+3AoXFWnQEcwhS1BCwzS1WJERGWoCga8FQL+twfZEqH2rPUFVhRDslu5+Y3BrLYds4VTpFEhk1jaEyp+cEIcbC9DnXmo87EP1YjwhqmL3k5l5HQi9l8hhSNqFPyi4jl3A4w39pFNHMf4KalnmZ5KYqMLlURyAxtqR1ElAYmVqvt/NBVMvUz1LKtccfTuqBdaLPRjx75SnSy6+rr4jfkQTgH3udZdnAtwNwVmlklsLs4mq61QMEH/5ur8buiv1kwCQ4him3X2L3/K237gBSYMeh8ydyaCeeU9R4inQgi1sFm6r5CRsWXAO1fLvxlTPQIRFQYNNG7r0lMl8e1PQxHx0Vib/abdvAGW4BeQ4Y3oNzSkYjLnWRFWKHTSyfvuNA6T4u5nWhY0zeSr2yjTzbAN8Jy+MxLzmauRj8qNfoBmuCzSeNh0GGAg6MX2vqqmU1WUlixZugfkBKr2bzCcf/4PNshwu4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261009223327099003)(261009223027099003)(261021121427099003)(261009220027099003)(261009221727099003)(261022105027099003)(261009221227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0hGQy9id212Yk9La0EzcXNqdUNPVXZFa3psRXU3emNkbSt5TmdNNXlOWTBy?=
 =?utf-8?B?M2lvZCtkZkhXcExKL1NycCtSU2FjZlgrU2p3RGNNUFVYTGQ5TkI0UUtUenlj?=
 =?utf-8?B?NWgrTTFxZFVkTXprV3BLTHYwcDBCRWlMZUNhVEFKV3NVM1BTMzdSb0RVM2ht?=
 =?utf-8?B?MVFicnBmSzFPbXp4dldJd2VrR1h3UmU0OWMyWUNsL2VONkNha2t5b1IzRFE1?=
 =?utf-8?B?RTc1T0gzMmZJQTYwWnBWNXdsR3lBTHF0QlNjMVRlNWtvZXEwd0U3WVJva2tw?=
 =?utf-8?B?eWM0OWRDdnI4Yjh4aVlGNzl4NmpBaVYyNGIwVmNraHRqb3c3SW9CREwvMEJM?=
 =?utf-8?B?aWNzSHZsUEgzVm9ZaE1QTklkSVVVY3pJcVByT3p2K2RhTGduSWVWUnJGSkF3?=
 =?utf-8?B?NHpwQW1mSWUrczUzVHJ0aER5RmxNSDFmSGs4NFhaNUE1TmxlbDBaWEFLZUZl?=
 =?utf-8?B?SktFRkcrUkRiVWZRTk1uNGc2K3EyNm9Oc1drT0MvbTBBancrcHZ3c2xRbTRS?=
 =?utf-8?B?a1pqU0xaWXhmZ3B5c0tvcC9QSmtNNHNqZ1R0K0Zqb2JnOEFCazNvdHNpME5T?=
 =?utf-8?B?dVA0T1hBS3piV0dHUjYwSEFCMTcrbnlIdGNYbjk1N0RnWTdRTkN2MWlsNVll?=
 =?utf-8?B?WjF3VmVObVJKQkl2dUZWK0twODl4THo5aHhQbHM2OTlSOU1IR3pqWUtlNCtz?=
 =?utf-8?B?R2FReDRLbmdCek1vOGtGYmJlMFgwcFQ5RVl5emwraVJNQjZ2dlZIaVNxcTFk?=
 =?utf-8?B?bXlORC96ODd0MmZzT0wvMTdibGVrOU5rMXRxaEdLNHNsNUp5ZGVFQzJTRFla?=
 =?utf-8?B?Q0M3Uk4yMmRyMEdTb3ZzZitCc3ExQURSQWd5Y3NpV1VSMWk4aE9zRi94dTFh?=
 =?utf-8?B?Qk51Mm4zdG9mUWNWV2QzemYxVHYxbi9yNGNNanVZK1ZMdFFaME1tVXVzL1d1?=
 =?utf-8?B?MFp2UkdHMXAzajhrSWx0M1psdUNqek1Zb1JZNEZOVDlrbFBUd0pTaklydkFj?=
 =?utf-8?B?alR6aGtFSW51ZjRCVzM4OThMWVMxN2JnOW5QZ0pkSm4rc2g0bVpsT1hqdUFP?=
 =?utf-8?B?WUplTEkxa0kwWVJTOGUyUllFQXdPcXYwaU92UlR0bHpoQk5jaWFlQjRxZlQv?=
 =?utf-8?B?MmlobmYzeThVRU9CQW5XQTRZaGk4dWtkYytnaUhFQlNyVGpNV2ZHUXpkS0Y2?=
 =?utf-8?B?VU95c2wvNW1BUHhVV0ZwUXpMZDlIRGRtWEtoQTVpOTJxMHBkYzRibHduNm9Y?=
 =?utf-8?B?RFNyN2MvUW1hZGpxc3U3ZkU1THJkVjB4ZDZvN2dPOVhTTGNOLzBXNEJWWk1H?=
 =?utf-8?B?Ykh1V1F2OEZuS25lTmJjbDhOM1J4ZmlOTmpyY0wwazFISGppUEhTM2ZrcmxE?=
 =?utf-8?B?VW83YW5wb1laS3psSEZCU05aZmlSS1YrN1ZtdTA4ZUEyUWo3YlRwaS9KVTdF?=
 =?utf-8?B?ekFwbFRhTXpGMnJOSm8weHRaZTBvbVp1MFhiRTFTZXdJM3NMREJlVlJmSWMz?=
 =?utf-8?B?cnBOK3hQU2xxcm5vRWEzSFQrdk5ycjRsbnVPbkF2OUhVRzVUdU5GK3ZKY0ln?=
 =?utf-8?B?RGpnRUpHUXlnOFo4UmtjRUN5Qm9IaHlJaDA3ZUhDRlNxTDVHcG9wdEovK3Fl?=
 =?utf-8?B?RWhyQ2ZtT296RUx3bS9iZm9qbnJaSHhGZFdWd01kTTFJekVsKzVFalc5RUp2?=
 =?utf-8?B?STVWY2tCazJiclphQ2owQVduRFFpekRSd01IakdvcllmekNpbmdST3RFOFZr?=
 =?utf-8?B?RHlFTm5xYjQ2RUl4S1p2S3pMbnUyblhaNTVNWnBreUZsTjZPeFExQ3BvUFZD?=
 =?utf-8?B?NlBQRnpyaDlwcUY2VWdGR2FmZFpjRHlJM0xkeHdvOHFyTyt3emxNWXIxWE51?=
 =?utf-8?B?ZTBuN2g2U1VRZlZsa1F4SllRdnVlUTJHZTh3MFBmR0JCRk1OM2V6L2RWLzlK?=
 =?utf-8?B?MVpqdER5R0RlS0VuRmtYc3NzaFE2NDZWd0hhVTNNOGFnQ0c2azUrbkdPcnM1?=
 =?utf-8?B?T2dnVDlxWlhXbjBsV21CdmpHaFAraG5tQUhiOEh1ekRuUUtCdm9FNzJaV0lS?=
 =?utf-8?B?VXVVdllDbDM3aHVRbUJEMlJYT1ZTdXVIaHErTW85WmZ0S3RndWlHL3RSVFkx?=
 =?utf-8?B?SEpESnRyRUhlZmZFdDNTWmVJR3V0SDN0NzdHZXFlL0dOby9WSGJJb2tUODhF?=
 =?utf-8?B?SjVOY00zQ29Sa214aGV1TEhmYUVXa2FMemV2WTNQQjR0Y2tpZDQ5alhHSWln?=
 =?utf-8?B?SkhnY0laVUhxOTRHaFFXU0RNZmZFYzNvUGdSKzdXS1dwVlVaS2w0MiswaGVV?=
 =?utf-8?Q?4zI9N0GYuif95xEdCP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2756a118-4984-47fa-3ba1-08df3ae1d14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 02:09:26.3367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2ZRyoxzloHus15F7fwxsnC+kGlVPr1UIqAryXe3rumnvoDKfo2l6Gd1Y5ZHMt0hAMFoTdTbcUuGV3LcLXq+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
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
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBO
b3ZlbWJlciA1LCAyMDI2IDY6NDcgQU0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5a
aGFuZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENo
cmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8u
TGF6YXJAYW1kLmNvbT47IE1hcmlvDQo+IFNvcGVuYS1Ob3ZhbGVzIDxNYXJpby5Ob3ZhbGVzQGFt
ZC5jb20+OyBSYXN0b2dpLCBNYW51DQo+IDxNYW51LlJhc3RvZ2lAYW1kLmNvbT47IFpodSwgSmlv
bmd5dSAoSm9leSkgPEppb25neXUuWmh1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgMDIvMTVdIGRybS9hbWRncHU6IGNvbXBsZXRlIHRoZSBndWlsdHkgZmVuY2UgYXQgdGhlDQo+
IGVuZCBvZiBhIG11bHRpIHJpbmcgcmVzZXQNCj4NCj4gT24gV2VkLCAyMDI2LTExLTA0IGF0IDAy
OjQ2ICswMDAwLCBaaGFuZywgSmVzc2UoSmllKSB3cm90ZToNCj4gPiA+ID4gKyAgICAgICAgICAg
ciA9IGFtZGdwdV9yaW5nX3Jlc2V0X2hlbHBlcl9lbmQocmluZywgcmluZyA9PQ0KPiA+ID4gPiBn
dWlsdHlfcmluZyA/DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGd1aWx0eV9mZW5jZSA6DQo+ID4gPiA+IHJpbmctPmd1aWx0eV9mZW5jZSk7DQo+
ID4gPg0KPiA+ID4gQ2FuIHlvdSBoZWxwIG1lIHVuZGVyc3RhbmQgd2hhdCB3YXMgd3Jvbmcgd2l0
aCB0aGUgbGluZSBiZWZvcmU/DQo+ID4gPiBJIHRoaW5rIGd1aWx0eV9mZW5jZSA9PSByaW5nLT5n
dWlsdHlfZmVuY2Ugd2hlbiByaW5nID09IGd1aWx0eV9yaW5nDQo+ID4gPiBubz8NCj4gPg0KPiA+
IFVzdWFsbHkgeWVzLCBidXQgbm90IHdoZW4gdGhlIHNvZnQgcmVzZXQgZm9sbG93cyBhIGZhaWxl
ZCByaW5nIHJlc2V0DQo+ID4gb2YgdGhlIHNhbWUgam9iLg0KPiA+ICBhbWRncHVfcmluZ19yZXNl
dChyaW5nLCB2bWlkLCBqb2ItPmh3X2ZlbmNlKQ0KPiA+ICAgIC0+IGFtZGdwdV9yaW5nX3Jlc2V0
X2hlbHBlcl9iZWdpbihyaW5nLCBGKQ0KPiA+ICAgIC0+IGFtZGdwdV9yaW5nX2JhY2t1cF91bnBy
b2Nlc3NlZF9jb21tYW5kcyhyaW5nLCBGKQ0KPiA+ICAgICAgIHNldHMgcmluZy0+Z3VpbHR5X2Zl
bmNlID0gRi4NCj4gPg0KPiA+IFNvIGJ5IHRoZSB0aW1lIHRoZSBlbmQgaGVscGVyIHJ1bnMsIHJp
bmctPmd1aWx0eV9mZW5jZSBubyBsb25nZXINCj4gPiBlcXVhbHMgdGhlIGd1aWx0eSBmZW5jZTog
dGhlIGJlZ2luIGhlbHBlciBjbGVhcmVkIGl0Lg0KPg0KPiBJIHRoaW5rIEkgc2VlIHRoZSBwcm9i
bGVtLg0KPg0KPiBJIHJlLXJlYWQgdGhlIHF1ZXVlIHJlc2V0IGNvZGUgYW5kIHRoZSBoZWxwZXJz
LiBEdXJpbmcgYSBxdWV1ZSByZXNldCwgaXQgbWFrZXMNCj4gYSBiYWNrdXAgYW5kIHNhdmVzIHRo
ZSBndWlsdHkgZmVuY2UgYnV0IGlmIHRoZSBxdWV1ZSByZXNldCBmYWlscywgaXQgZG9lc24ndA0K
PiByZXN0b3JlIHRoZSBjb250ZW50cywgYW5kIG9uIGEgc3Vic2VxdWVudCBjYWxsIGl0IGNsZWFy
cyB0aGUgZ3VpbHR5IGZlbmNlIGFuZCB0aGUNCj4gYmFja2VkIHVwIGNvbnRlbnRzLg0KPg0KPiBV
bmZvcnR1bmF0ZWx5IEkgdGhpbmsgdGhpcyBjb21taXQgZG9lc24ndCBjb21wbGV0ZWx5IGZpeCB0
aGF0IGJlY2F1c2UgdGhlIHJlc2V0DQo+IGJlZ2luIGhlbHBlciB3aWxsIHN0aWxsIGNsZWFyIHRo
ZSBiYWNrZWQgdXAgY29udGVudHMgb24gdGhlIHNlY29uZCBjYWxsIChzZXRzDQo+IHJpbmdfYmFj
a3VwX2VudHJpZXNfdG9fY29weSA9IDApLg0KPg0KPiBJIHRoaW5rIHRoZSBjb3JyZWN0IGZpeCB3
b3VsZCBiZSB0byBtYWtlIHN1cmUgd2UgZG9uJ3QgcmVwZWF0IHRoZSByaW5nIHJlc2V0DQo+IGJl
Z2luIGhlbHBlcjoNCj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL1ZlbmVtby9saW51
eC8tDQo+IC9jb21taXQvODZmMmJmMjIyY2FlZTBkYTI2N2Y5ZDllMTIzNjI1MTNmZTRmN2Y5ZQ0K
PiBQbGVhc2UgdGFrZSBhIGxvb2sgYW5kIGlmIHlvdSBhZ3JlZSBmZWVsIGZyZWUgdG8gdGFrZSB0
aGF0IHBhdGNoIGluIHlvdXIgc2VyaWVzLg0KUmlnaHQsIHRoZSBzZWNvbmQgYmFja3VwIGFsc28g
ZHJvcHMgdGhlIGNvbW1hbmRzIG9mIHRoZSBvdGhlciBqb2JzIG9uIHRoZQ0KZ3VpbHR5IHJpbmcs
IGFuZCBza2lwcGluZyB0aGUgYmVnaW4gaGVscGVyIGlzIHRoZSBiZXR0ZXIgZml4LiBXaXRoIGl0
LA0KcmluZy0+Z3VpbHR5X2ZlbmNlIGFsc28gc3RheXMgdGhlIGd1aWx0eSBmZW5jZSwgc28gMDIv
MTUgaXNuJ3QgbmVlZGVkDQphbnltb3JlLg0KDQpJIHRoaW5rIHRoZSBjb25kaXRpb24gaW4geW91
ciBwYXRjaCBpcyBpbnZlcnRlZCB0aG91Z2g6DQoNCiAgICAgICAgaWYgKGd1aWx0eV9mZW5jZSAm
JiByaW5nLT5ndWlsdHlfZmVuY2UgPT0gZ3VpbHR5X2ZlbmNlKQ0KICAgICAgICAgICAgICAgIGFt
ZGdwdV9yaW5nX3Jlc2V0X2hlbHBlcl9iZWdpbihyaW5nLCByaW5nX2d1aWx0eV9mZW5jZSk7DQoN
CmNhbGxzIHRoZSBiZWdpbiBoZWxwZXIgb25seSBmb3IgYSByaW5nIHRoYXQgd2FzIGFscmVhZHkg
YmFja2VkIHVwIHdpdGgNCnRoaXMgZ3VpbHR5IGZlbmNlLiBUaGUgb3RoZXIgcmluZ3MsIGFuZCB0
aGUgZ3VpbHR5IHJpbmcgb2YgYSBzb2Z0IHJlc2V0DQp3aXRob3V0IGEgZmFpbGVkIHJpbmcgcmVz
ZXQgYmVmb3JlIGl0LCBhcmVuJ3QgYmFja2VkIHVwIGFueW1vcmUuIFRoZQ0KbGF0dGVyIHdvdWxk
IGV2ZW4gcmVwbGF5IGEgc3RhbGUgYmFja3VwLiBUaGUgZ3VpbHR5IHJpbmcgYWZ0ZXIgYSBmYWls
ZWQNCnJpbmcgcmVzZXQgaXMgdGhlIG9uZSByaW5nIHRoYXQgc3RpbGwgZ29lcyB0aHJvdWdoIHRo
ZSBiZWdpbiBoZWxwZXIuIEkNCnRoaW5rIHlvdSBtZWFudDoNCg0KICAgICAgICAvKiBBIGZhaWxl
ZCByaW5nIHJlc2V0IG9mIHRoZSBzYW1lIGpvYiBhbHJlYWR5IGJhY2tlZCBpdCB1cC4gKi8NCiAg
ICAgICAgaWYgKHJpbmcgIT0gZ3VpbHR5X3JpbmcgfHwgcmluZy0+Z3VpbHR5X2ZlbmNlICE9IGd1
aWx0eV9mZW5jZSkNCiAgICAgICAgICAgICAgICBhbWRncHVfcmluZ19yZXNldF9oZWxwZXJfYmVn
aW4ocmluZywgcmluZ19ndWlsdHlfZmVuY2UpOw0KDQpJZiB0aGF0J3Mgd2hhdCB5b3UgbWVhbnQs
IEknbGwgdGFrZSB5b3VyIHBhdGNoIHdpdGggdGhhdCBjaGFuZ2UgaW4gcGxhY2UNCm9mIDAyIGlu
IHY0Lg0KDQpKZXNzZQ0KPg0KPiBUaW11cg0K
