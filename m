Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7D606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3o1ytfAH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C25410E467;
	Tue, 27 Oct 2026 19:38:00 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210EB10E467
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWVEFdVIZLfMKWfho6dmWak1JDAMyl8H2MuKc3S4xjpcHHba9CdrB+K+C/lAur7HHhcf1yjikBZPr91IC3k5H7/RTy3U5SPW9bvnSHkpotq3uUFGLfwl6qkYkP6dKN+U1Ga4TKOzEAAzcAGYvP6YEpSn1t+Lvg2PQgh9TdLk/WGvCUP5RD+TiAT47TWmYgozEKCd6FwuqDEtAZG9pOIbgZAEVOfQbX5WKY+DILPqrryuNHWia0xlIpkQfWgDlrFc7Od6BZkpbxVBjm9Uw90CTELuSXdm/rmDc2ACgAOS4+d/xYMqWbL6qTnurgB71YMJjk2hX0CfqkfCJNGxJXVWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZK3EvCERR9AoqqBE7J5zXxzXS6WwJcXr6QaGT0qRZU=;
 b=hl9Sph10Kc9cN/kUlAYr5voUwxEVj4KTUKkn9JKJtXj/XXUU3IayzEFodFbppXEJ3HhNvTV38+SMNbY9L44nGRG4lRE+Me0zPpo1Qn2skYi+ECznzD5MybcsQR4efPbbV1B84yBRDal0Yzm7NwY0jgbi21RIU49gin55YZKLTCyMIAs8LeqS9hnDVzYxsMwuVojj+Ev6I1tzCmS6vEISxV5utSDC71W3E0/M87+VQ2apOhnjtoRAlLBVIN44+Vv9HVtphSH6XfX9r5Z7hRkXGLdMc6iN8ZqfEa9z+l19Z/LLA68SVK86rpRZgn3JX2Gk1C+D4e3mC+E9d7cJKRgFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZK3EvCERR9AoqqBE7J5zXxzXS6WwJcXr6QaGT0qRZU=;
 b=3o1ytfAHOn13jyPy2OxChKDgfFm7aw/W/d01M2eJanBI9W730uS9DtxB84q26/HQOlgmhMV7Ow/h8wJh3+u0w+u522/8ib6ELjpC4QskUKudO9Z2KW7+XQlImmxT4jaoDCjuE1+kkrGxegiwQBFOXdy/rNBRINWBzOM8lb8B460=
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 (2603:10b6:510:3da::21) by DM4PR12MB6397.namprd12.prod.outlook.com
 (2603:10b6:8:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:37:44 +0000
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766]) by PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:37:44 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Thread-Topic: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Thread-Index: AQHdYnBrCHeGDhr58kyCSwRJSWXzmLcQEg2AgAG+KtA=
Date: Tue, 27 Oct 2026 19:37:44 +0000
Message-ID: <PH6PR12MB345224A6EC620222994D43711C85602@PH6PR12MB345224.namprd12.prod.outlook.com>
References: <20261022215738.3248641-1-kent.russell@amd.com>
 <65de1f6f-df69-417d-b31e-8e1731c12ca8@amd.com>
In-Reply-To: <65de1f6f-df69-417d-b31e-8e1731c12ca8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T19:37:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH6PR12MB345224:EE_|DM4PR12MB6397:EE_
x-ms-office365-filtering-correlation-id: 4f4b3d5d-ad1d-4dd7-e673-08df3461c599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|261026121527099003|56012099006|261022113327099003|4143699003|11063799006|10067099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: J4AXc0IORpXLCOlRmmVxWcFECZigrH0zbVUwHxH0GF/2QyZ8EvGe3IQ/Zu1/6PMLI3tfxT9W+aCMS9JBEUBUvFwbeVGSSuTWvaLmVWG9065GRXwuv9cJy7nQsWW5ZFOcBWBdvjmsJzz3PoJ4aFrFdlEgFNaWw9SUmEyok0FaEu3EvuUNNWzwhlJ48ocgRc8vkrhwmx5gjtOhKqOREaMGgcm+PouhX8cFDVG9NPERRe6B/xANXHDysn7ZtNKOW0G3+soi90xpesb9CY9ws7qV2gfT3CbE/JOs9GCmOu9OPvzWBxoY+mSkyvQ+1dgqPH2bxoPkH2VSJs1TwGqM+AWfv0OO96DGXo8DzbRFo38TK14GgL/rdyjnEvX3pGIOreElxaADrJTvvrDMmFXv60hhoAr8m9oeV6B0YMISrhYMmh+xYzUrzT/Qea+X1Cn4ypnBNGjkcQNsZQDCNgDn2k7uoVfhuzwwluR2oZ5eoB0/D80wNBo25rxuJE1GHlP9aD5+cSF906DKEprGws4wFXaEZ6t7U/v5aPeCPLVjrtvsZCXTexIfeeboE/crdPIUnk35I0guTWJzZi84Bf0XWJVqVSsEk0ymCvPKhAIM0CDmTHVLUDBRDzkJ+818LsxUaYmaTKPULNecY65XePl5btGHt6TDLFo6CDhkpRP78RKq5v++fFvawHh6EhdQZMRTGDWNm+WzERt/xIlqmfPxYYEn9ObvffWiPa3Dezh3wzNbFvw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH6PR12MB345224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(261026121527099003)(56012099006)(261022113327099003)(4143699003)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0dJOTZCcWFkWlhnWHkwMmw1R29tUFlXdTIvVXdYS0V1UWRwajJlYURzVWJB?=
 =?utf-8?B?UlRsS3N6MFZaWURFT1dxaDBHQmFaemV2UUt2VElNeksvd1NGQmVHV1JKbVBx?=
 =?utf-8?B?ckUwN2JIek1VN2hZbGF2UHUxcUZ3cHFBSWtGeDZ2dzBNYWpXSEI0STEvMGpC?=
 =?utf-8?B?WU4rYUNSZEZBVSsvN0gveTY3MDR2YnRzbThDZ3lpVnJDMzBqOFdqVWJXRlRP?=
 =?utf-8?B?NmUwcHIxWlB6UEE0OGw2b2gyZEI4RWxsM1U5N3JZUEhxTU9LeVdsTG9nZEs4?=
 =?utf-8?B?bDR2R29FL3V6WHlzVlM4RHEyVlN1STczVTB2U2FMOVNudys0QjJmRi9aR0du?=
 =?utf-8?B?UnlFM3ZmTi90Y3VQb011bnU5eEZ2TXU1VmVrZ05WLzM5NzFDVTgvU1M0eURL?=
 =?utf-8?B?WUk5c0Rrd2lWSmZMUndtWVdRbk92c1p0NFl4akZyTnF1SFZ6cmZkYVpMZXpW?=
 =?utf-8?B?c2c3RWVUSWYweGM3L1FBcGRQc1ZxdVFtYTl3SU5OS3lrZDAxa2RZZXJ0ZkpQ?=
 =?utf-8?B?V08zS3ExNDZhS0RiMDdjb2t6Z3hocFI5bHhLdEE1QXZtMEt4bzNmbEZMK1JI?=
 =?utf-8?B?aWFJUDc4Rm1ReVRBQ294NGQ1NFpBMlpiU2QxL1gwVnIwU08zL2poNUNRQVBp?=
 =?utf-8?B?TzNTYUd2b2Ixc3B3NHF0WldRc0tuUG5UQVFhWWZDV0F3cHFwbEpwN3l4RG9M?=
 =?utf-8?B?dkF4K0dQVkpRUU04emowSjBTelFiOUJwaUN3SDcrSHE4YnVaUzRiYkJhVVVQ?=
 =?utf-8?B?YTA0WFJ2eWFnUThJcFBHTHBWR2xCOWZCVnlpcWV3TUxLZ1l0V1RDTG81K2tk?=
 =?utf-8?B?bnVqaXEvUUx0Zk8vMGViclYrTk9KZE9vQmE5dVMzYmdvb01wY1VqcDZUUkY3?=
 =?utf-8?B?NHNiVDg4NWpRVGxKTGZKQnlYUTduWUZXai8zMW5VcElteUt2SDFxY2ovcGVZ?=
 =?utf-8?B?R0tsZWRLVDZQSDFYZWtRQk5OSHhBRnppTk5iL2NCWjNMcUJhcDNSZDBsZS9q?=
 =?utf-8?B?R3BNWEdzVTlweThrOUxBQWlSRGlZbXZXKzM4TDZoWUZxLytSZnZvL1VTaUV2?=
 =?utf-8?B?blloNW9JdEFBbmFodGFsZjdha09vVlllWEFRajFnU2ZXUCt1dnJuRzJkaWpW?=
 =?utf-8?B?QUQzUklMSURpUFdvazV4RG1QbjBUUnNPRG40RGNmaU5mdVFhaXRFdHRReVMr?=
 =?utf-8?B?ZHRLdEkrWG9xNUtDQUg3eTRNNEFaRytyeXVlc3lhejR1cTlvZjEwdHdpaVVx?=
 =?utf-8?B?ZFNWUmZUaXZPZFZGU2k4QzlsRldBb2V4ZmNxMHUzUmR0UTAxWXI3NktqQkRJ?=
 =?utf-8?B?MkwzNE95anVkMitJaWxveE9HSTY3ZmYxQ3pZTWh5eFNCalNrZVlFckd1a1gv?=
 =?utf-8?B?Qk9nSW9NNHM1bnFsK3dnQk1CNDBsVTl5SWlneU1DV3VyUEZBRVEyYThVRllR?=
 =?utf-8?B?d2pDZE54M1k4L0hTZ3F4M0pmSVoyR0RRRjFNa1FiTFkxTGtFMHgrbm1hRHlO?=
 =?utf-8?B?eEw5Tk5ldlNKZHdjWDNiOGdzYVBmakNJMmdOdDRKKzFkakNrSW1PZGx3U1Y0?=
 =?utf-8?B?L29EK2VsMUNsa01MSUM2RGpqbC9YaDNValRnaHBRbEk3MVowWWdZbG1wYmJl?=
 =?utf-8?B?QUdubnAyRWh6UDJrRzdSbXhPNzBJOGJMYUZwcjV0ZVREVlAyOFlxeHVmNUpF?=
 =?utf-8?B?UDh0VTFTQ0FWMUpMOGh6WHUyeSswcG4vZEtTU1RZODkwV0FLTmFKdlJITDEy?=
 =?utf-8?B?SkVjc0VHOGhLRkZKS1NZTlh0R01RaVNjcjREY1d4N0lIVVM5c00zRWpqRFpG?=
 =?utf-8?B?QzRYZ0JMOUNoMlZFNW9BQmpVT2dFYmFhR3BMbjgzakYvTElNbVMrV2xYbU5v?=
 =?utf-8?B?NHBZcGNScWlodUFMSnlWUkt5bWdoRlVXNUZYQTJZMjAzMWZOUjRnMm9uRjdj?=
 =?utf-8?B?dmJCMHdTcEIwS2Y0M08zT1ZxRnZCRHkzQ2dtWE5IUmE3cXU0L0tpdGtKeHJ0?=
 =?utf-8?B?RC81dXNiTStITWJOSG9JWjZYMGlyTDYrTkMzVnExV2srZjYzWitVS2ZXUTBx?=
 =?utf-8?B?anN5VzJERnkzcmdoWkNDNHE1YjVhbFNGbk1pT3ZKQXNhRmxsdWpGSTJqWUxV?=
 =?utf-8?B?MnVEN3AyaXJ6T2lDVnY2Rml6OVY0UWdGN0lBOVV4RFVTQ1hlbTQwQ2t0M0d5?=
 =?utf-8?B?a0dIdEU3RVYrRTdmRS9rYk5Wa0ZVY052aWl2UE1TaFZ4dUNoVUxDY1RYWTVR?=
 =?utf-8?B?RGg4ZmJocDV3NGFxdkUvbGhtZytMdEtyVmdrWGFJajVHa09nQVk2ZTRlYW9O?=
 =?utf-8?Q?Tm3AM/cEuRNkWcOMgG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH6PR12MB345224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4b3d5d-ad1d-4dd7-e673-08df3461c599
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 19:37:44.1151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7scr0HZlodd78neUULnr5Xh65rWADT//9KwPBe9WkD3JJPs2ZL1I+Y23cVG/v2rFeR6RsFjodzIYyq9i4LYxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KVGhhbmtzLCBJIHNlZSB0aGF0IGh0dHBzOi8vZG9jcy5rZXJuZWwub3Jn
L3Byb2Nlc3MvY29kaW5nLWFzc2lzdGFudHMuaHRtbCBoYXMgY2hhbmdlZCBzaW5jZSB0aGUgbGFz
dCB0aW1lIEkgcmVhZCBpdC4gSSdsbCBhZGp1c3QgaXQgYmVmb3JlIHN1Ym1pdHRpbmcvdjIuDQoN
CiBLZW50DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBPY3RvYmVyIDI2
LCAyMDI2IDE6MDAgUE0NCj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IEVuc3VyZSB0aGF0IGhhcnZlc3QgaW5mb3JtYXRpb24gZ2V0cyBzZXQNCj4NCj4NCj4NCj4gT24g
MTAvMjIvMjYgMTY6NTcsIEtlbnQgUnVzc2VsbCB3cm90ZToNCj4gPiBBZnRlciB0aGUgZWFybGll
ciBwYXRjaCBleHBvcnQgSVAgZGlzY292ZXJ5IG9uIHByb2JlIGZhaWx1cmUsIHRoZXJlIHdhcw0K
PiA+IGFuIHVuZXhwZWN0ZWQgY29uc2VxdWVuY2Ugd2hlcmUgaGFydmVzdCBpbmZvIHdhcyBub3Qg
cG9wdWxhdGVkLiBUaGUNCj4gPiBlYXJseS1leGl0IGluIGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNf
aW5pdCBtZWFudCB0aGF0IHdlIG5ldmVyIGNhbGxlZA0KPiA+IGFtZGdwdV9kaXNjb3ZlcnlfZ2V0
X2hhcnZlc3RfaW5mbywgd2hpY2ggaXMgd2hlcmUgd2Ugc2V0IHRoZSBhY3R1YWwNCj4gPiBoYXJ2
ZXN0IHZhbHVlLiBUaGUgZmlyc3QgdGltZSB3ZSBjYWxsIGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNf
cmVjdXJzZQ0KPiA+IHdpdGggTlVMTCBpbnN0ZWFkIG9mIGFkZXYsIG1vc3QgdmFsdWVzIGNhbiBn
ZXQgc2V0LiBUaGUgMm5kIHRpbWUNCj4gPiBhbWRncHVfZGlzY292ZXJ5X3N5c2ZzX3JlY3Vyc2Ug
aXMgY2FsbGVkLCB3ZSBiYWlsIGVhcmx5Lg0KPiA+DQo+ID4gVG8ga2VlcCB0aGUgbG9naWMgb2Yg
dGhlIGZpcnN0IHBhdGNoIGludGFjdCwgZW5zdXJpbmcgdGhhdCBvbGRlciBrZXJuZWxzDQo+ID4g
Y2FuIHN0aWxsIGRpc2NvdmVyIHRoZSBJUCBibG9ja3MsIGFkZCBhIHNlcGFyYXRlIGNhbGwgaW4g
dGhlIGVhcmx5LWV4aXQNCj4gPiBzZWN0aW9uIHRoYXQgc2V0cyB0aGUgaGFydmVzdCBpbmZvcm1h
dGlvbi4gVGhpcyBzaG91bGQgYmUgdGhlIG9ubHkNCj4gPiBmdW5jdGlvbmFsaXR5IHRoYXQgaXMg
bWlzc2VkIGluIHRoaXMgZmxvdywgdGhlIHJlc3Qgb2YgdGhlIGNhbGxzIGVpdGhlcg0KPiA+IHdv
cmsgZmluZSB3aXRoIGFkZXY9TlVMTCwgb3IgdXNlIHRoZSBkaXNjb3ZlcnlfYmluIGRpcmVjdGx5
Lg0KPiA+DQo+ID4gRml4ZXM6IDNlZTEwNjVlOTgzMCAoImRybS9hbWRncHU6IEV4cG9ydCBpcF9k
aXNjb3Zlcnkgc3lzZnMgb24gcHJvYmUNCj4gZmFpbHVyZSIpDQo+ID4gQXNzaXN0ZWQtYnk6IENs
YXVkZTpjbGF1ZGUtb3B1cy00DQo+DQo+IFRoaXMgc2hvdWxkIGJlDQo+DQo+IEFzc2lzdGVkLWJ5
OiBMTE0NCj4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rpc2NvdmVyeS5jIHwgNDUNCj4gKysrKysrKysrKysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gaW5kZXgg
MTZlMzEyOWRiNmExLi4zNDJlZGJkMDI4ODAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gQEAgLTE0NjksNiArMTQ2OSw0
MSBAQCBzdGF0aWMgaW50IGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNfcmVjdXJzZShzdHJ1Y3QNCj4g
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4g
PiArI2RlZmluZSBsaXN0X3RvX2tvYmooZWwpIGNvbnRhaW5lcl9vZihlbCwgc3RydWN0IGtvYmpl
Y3QsIGVudHJ5KQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYW1kZ3B1X2Rpc2NvdmVyeV9zeXNm
c191cGRhdGVfaGFydmVzdChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4gPiArew0K
PiA+ICsgICBzdHJ1Y3QgaXBfZGlzY292ZXJ5X3RvcCAqaXBfdG9wID0gYWRldi0+ZGlzY292ZXJ5
LmlwX3RvcDsNCj4gPiArICAgc3RydWN0IGlwX2RpZV9lbnRyeSAqaXBfZGllX2VudHJ5Ow0KPiA+
ICsgICBzdHJ1Y3QgbGlzdF9oZWFkICplbF9kaWUsICplbF9od19pZCwgKmVsX2h3X2luc3Q7DQo+
ID4gKyAgIHN0cnVjdCBpcF9od19pZCAqaHdfaWQ7DQo+ID4gKyAgIHN0cnVjdCBrc2V0ICpkaWVf
a3NldDsNCj4gPiArICAgc3RydWN0IGlwX2h3X2luc3RhbmNlICppcF9pbnN0Ow0KPiA+ICsNCj4g
PiArICAgaWYgKCFpcF90b3ApDQo+ID4gKyAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiAr
ICAgZGllX2tzZXQgPSAmaXBfdG9wLT5kaWVfa3NldDsNCj4gPiArDQo+ID4gKyAgIHNwaW5fbG9j
aygmZGllX2tzZXQtPmxpc3RfbG9jayk7DQo+DQo+IENhbiB5b3UgdXNlIHRoaXMgaGVyZToNCj4N
Cj4gZ3VhcmQoc3BpbmxvY2spKCZkaWVfa3NldC0+bGlzdF9sb2NrKTsNCj4NCj4gVGhlbiB5b3Ug
ZG9uJ3QgbmVlZCB0aGUgZXhwbGljaXQgY2xlYW51cCBvbmUgYXQgdGhlIGVuZC4NCj4NCj4gPiAr
ICAgbGlzdF9mb3JfZWFjaChlbF9kaWUsICZkaWVfa3NldC0+bGlzdCkgew0KPiA+ICsgICAgICAg
ICAgIGlwX2RpZV9lbnRyeSA9IHRvX2lwX2RpZV9lbnRyeShsaXN0X3RvX2tvYmooZWxfZGllKSk7
DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIGxpc3RfZm9yX2VhY2goZWxfaHdfaWQsICZpcF9kaWVf
ZW50cnktPmlwX2tzZXQubGlzdCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgaHdfaWQgPSB0
b19pcF9od19pZChsaXN0X3RvX2tvYmooZWxfaHdfaWQpKTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICBsaXN0X2Zvcl9lYWNoKGVsX2h3X2luc3QsICZod19pZC0+aHdfaWRfa3NldC5s
aXN0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlwX2luc3QgPQ0KPiB0b19p
cF9od19pbnN0YW5jZShsaXN0X3RvX2tvYmooZWxfaHdfaW5zdCkpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpcF9pbnN0LT5oYXJ2ZXN0ID0NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbWRncHVfZGlzY292ZXJ5X2dldF9oYXJ2ZXN0X2luZm8oDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LCBpcF9p
bnN0LT5od19pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlwX2luc3QtPm51bV9pbnN0YW5jZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICB9DQo+
ID4gKyAgICAgICAgICAgfQ0KPiA+ICsgICB9DQo+ID4gKyAgIHNwaW5fdW5sb2NrKCZkaWVfa3Nl
dC0+bGlzdF9sb2NrKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQgYW1kZ3B1X2Rp
c2NvdmVyeV9zeXNmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgew0K
PiA+ICAgICB1aW50OF90ICpkaXNjb3ZlcnlfYmluID0gYWRldi0+ZGlzY292ZXJ5LmJpbjsNCj4g
PiBAQCAtMTQ3OSw5ICsxNTE0LDEzIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zeXNm
c19pbml0KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICBpZiAoIWRpc2Nv
dmVyeV9iaW4pDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAtICAg
LyogSWYgZWFybHkgaW5pdCBhbHJlYWR5IGNyZWF0ZWQgc3lzZnMgaW4gc3RhbmRhbG9uZSBtb2Rl
LCBza2lwIG5vcm1hbCBpbml0DQo+ICovDQo+ID4gLSAgIGlmIChhZGV2LT5kaXNjb3ZlcnkuaXBf
dG9wICYmIGFkZXYtPmRpc2NvdmVyeS5pcF90b3AtDQo+ID5zdGFuZGFsb25lX21vZGUpDQo+ID4g
KyAgIC8qIElmIGVhcmx5IGluaXQgYWxyZWFkeSBjcmVhdGVkIHN5c2ZzIGluIHN0YW5kYWxvbmUg
bW9kZSwgdXBkYXRlIGhhcnZlc3QNCj4gaW5mbw0KPiA+ICsgICAgKiBub3cgdGhhdCBhZGV2IGlz
IGZ1bGx5IGluaXRpYWxpemVkLCB0aGVuIHNraXAgdGhlIHJlc3Qgb2Ygbm9ybWFsIGluaXQuDQo+
ID4gKyAgICAqLw0KPiA+ICsgICBpZiAoYWRldi0+ZGlzY292ZXJ5LmlwX3RvcCAmJiBhZGV2LT5k
aXNjb3ZlcnkuaXBfdG9wLQ0KPiA+c3RhbmRhbG9uZV9tb2RlKSB7DQo+ID4gKyAgICAgICAgICAg
YW1kZ3B1X2Rpc2NvdmVyeV9zeXNmc191cGRhdGVfaGFydmVzdChhZGV2KTsNCj4gPiAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiArICAgfQ0KPiA+DQo+ID4gICAgIGlwX3RvcCA9IGt6YWxsb2Nf
b2JqKCppcF90b3ApOw0KPiA+ICAgICBpZiAoIWlwX3RvcCkNCj4gPiBAQCAtMTUzNiw4ICsxNTc1
LDYgQEAgc3RhdGljIGludCBhbWRncHVfZGlzY292ZXJ5X3N5c2ZzX2luaXQoc3RydWN0DQo+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4NCj4gPiAgIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovDQo+ID4NCj4gPiAtI2RlZmluZSBsaXN0X3Rv
X2tvYmooZWwpIGNvbnRhaW5lcl9vZihlbCwgc3RydWN0IGtvYmplY3QsIGVudHJ5KQ0KPiA+IC0N
Cj4gPiAgIHN0YXRpYyB2b2lkIGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNfaXBfaHdfZnJlZShzdHJ1
Y3QgaXBfaHdfaWQgKmlwX2h3X2lkKQ0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3QgbGlzdF9oZWFk
ICplbCwgKnRtcDsNCg0K
