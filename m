Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20989606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u87Ioz+e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32DB10E055;
	Tue, 27 Oct 2026 19:35:43 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6688E10E055
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2GUgssQmUUFJz32GYNCytPAtAcVlKIZy+1c+K8NuhiUnrPR1qg2Rg5HdGdX9oE1+wI4N2TYM9eA1z/oMzdcSuKj9C7sU4dnTXKr2GuM0wzks2xJIdJq1Fweoi8Nel3xAnJUEjAAO6tXsrSRCQzPXJ+NPNiLP4YElEEsVCeZXKh/6IVRwVv8AEr409hP20QI7IhA5ITdXTLLQ9bkE1pqLx66ML/BVyrv1oO1q9OYDEBaarbgmJOotwwAXKHiYawbcDGXa/zcZIrm9txokKPhDcYFRV5wm9mG93jyZqzp0GbuZj4gak/WUwhUPpAaoMJGAb+RNH4tiHb6iv3XV0eVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgNDCdZrCPqgc3v5hyink7EaTBH7096QbzAF+20W6Ms=;
 b=bgtCKSysRami74B3FbyePX4/2OHwsuJHVXF98L66cZnqK8/qKNqGICSlNvPPDrfHKOBt7jZD40sducbMYftGuVmMmPdaRKAnAOK80sVvMrnLvZswPlq5Zzlct/inQCas4lh9Ytiy6jrUN/WWGt/djH8ZSOb0EDuPX3pG5ChN94wS/XhX71u/WTzmU/pKr9ys2QNfeKO7ge9NmL9jx8uU1ZGZzNCPYgjztBksxVmcBxKm4p0T2KS4Blr52rX1AgIGF8GNhjiU7213ssRqcT1uXbR2wOo0A4fYIZ0y8mzbaU9P1MMTJ7Igc2B2uD72xTY5mdW5BdTcrrCaVAUWSO+ZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgNDCdZrCPqgc3v5hyink7EaTBH7096QbzAF+20W6Ms=;
 b=u87Ioz+ecr5Poh/94MvWKmsuwgYmP3K13dvl6vxN8bv6QGZFUjrP4M7K2Xg40HIRbk+ZJFpf97ux2MwqxQGgqPm348G0yuX2ufxJoYNrQVcfGCE4eua6Na8FMvKAKNSZ+RI0e92pzUqXfosCVJeonUUGOj76HW5dgkPz4vqumds=
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 (2603:10b6:510:3da::21) by CY8PR12MB7658.namprd12.prod.outlook.com
 (2603:10b6:930:9e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:35:34 +0000
Received: from PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766]) by PH6PR12MB345224.namprd12.prod.outlook.com
 ([fe80::ea89:cfbe:14c3:3766%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:35:33 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Thread-Topic: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Thread-Index: AQHdYnBrCHeGDhr58kyCSwRJSWXzmLcQGi+AgAG1QtA=
Date: Tue, 27 Oct 2026 19:35:33 +0000
Message-ID: <PH6PR12MB34522446B9651758FCD1200C4785602@PH6PR12MB345224.namprd12.prod.outlook.com>
References: <20261022215738.3248641-1-kent.russell@amd.com>
 <CADnq5_NXH7MVG7tYKdesk9yQ0Z9UrNY7d9PtD=SSP8DLJTvKSw@mail.gmail.com>
In-Reply-To: <CADnq5_NXH7MVG7tYKdesk9yQ0Z9UrNY7d9PtD=SSP8DLJTvKSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T19:34:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH6PR12MB345224:EE_|CY8PR12MB7658:EE_
x-ms-office365-filtering-correlation-id: a906a5cd-2c74-44dc-2989-08df346177a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|261026121527099003|10067099003|4143699003|11063799006|56012099006|261022113327099003|261009223027099003|261021121427099003|261022105027099003|261026140227099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: 78amZ353J+G+IyBKYJ8eOMrrruv9EUohuMaS5gJq3wLNTXvnRDbrwvKC4noEjsX8f4WyobLUb/1mbUfrwLIwVy8Sgx/HgYa8n4Hc803E99Yj7u4320bF2FH2quevzKYmITRW5FQX1UFivVEujZUPff+UvJUZodSm913+yXdw0RTUYBjfn1Bn4PCNm/46Nlp1Gg00esQqKPSEmA9aSFF4w/CP5Nd9hFEiQ/GQ5X9LKfUC77FLWMVdNiDqXsUQJh/Gtvifjq1l1WNq6Bbwp96EkU7yIUMgzhHFkTAzB86U4TUv9jWgV4b+/yLiGEmlS+Cpt9n+Sc3vIDXyHUzq/TqGUAnPZypfxt/W26KTSEVuqJb70E08hFrO4TLgrFvByLmlpgSoL0/utuljPDDeVVKzJA/P8cBVikKcQlRsywYQVbYrpYbi5mWgciyGsgXtrfAF7pZYIIxT92R19FbXFzMl81XhZ6w2vI+AYcwllDQiBGOlkqbORT6a7vTZcRWRIRY1hGhkvlPitQO6o6j/Swc0GUY4quXk21ph/sWAAQubL96yCAbwNxdeIJMNvM0cbuyhZHPpYxaBygRYfdQ2P8vXqxb2hK83wYVLAkFrIJ7gNOhdAa75q6g1qahLiTd9fdJAqjBnf5CSsUz/zH9M22gsiAkwYiXJuyUT32FdCinjxKVE2L7W2zYbJ4p/lwk0ODaP9KDo4gC5NcGAB6m/MMyzbj46b+VAYdFE00BEDpzPCQk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH6PR12MB345224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261026121527099003)(10067099003)(4143699003)(11063799006)(56012099006)(261022113327099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3k5WWp6K3FNS1JqQ01KelYrVVZ5Sm8vWWVVaHFDT0JkcUZxMU5CdVRFeEVX?=
 =?utf-8?B?UVNHNER1WW1TTzVpVHdDVUthMXU4MWpaNzdzVlk2VlZxT1Z3OWZ2azZUKzE1?=
 =?utf-8?B?SW56L3RKZGZUMGlKeGlBa3RBUzA0L2JMbEFmdHRLRzRMMTh6ZHJCT0NBMWdw?=
 =?utf-8?B?aVM2TGNBTE1UZy8yUU8rTTFuK3dLNkVwUXcvZkxBOSt2NElkblFGMFprbURj?=
 =?utf-8?B?aFljaDJFZEEzWmVBMTlYMytLZis5OEJ3bGxla1dXa3EzSVFoam9LeXhaemxO?=
 =?utf-8?B?a3BjdXNTMVptSWRZQ1RiTHVpZEljcThRUVRCVWRJaW5qOUVmUGs5WGVIcC9o?=
 =?utf-8?B?aWprVFRlcXhwRVlrTFYveHYrbzZMSFo2Y2REOGRsVkppZ1c3a08rZzdCOXR1?=
 =?utf-8?B?OUZvaEJ1VjZUS2EyNTQ1MTdmWW92Q1BQd25PT0FCWWxkUmQ3OHRDQjBiZjhu?=
 =?utf-8?B?QVd3a3o5STQ2SFdPN3prMEUwaUIwTlhSK0RVcUdKcDR4QTJTYVllb0ljcTQw?=
 =?utf-8?B?MzBFSWNFTTk2M1NZU2k5UHV2Q0dqWnFVYS8xMWZ3cjJDbW5xWnhCbE85cTJu?=
 =?utf-8?B?dnpFQXVPOC9YSS9zNnhvTlNKU2t0UEpjUTNjK3NENDVjNVNHSCsrT1RZWlBN?=
 =?utf-8?B?SFJGV1ZsSEEyNmpsU0JMTFZJRWRETWZmbm03QmhOM3RoUXlaSGVoeUo1bEVM?=
 =?utf-8?B?dDJ4SHBEbkVsNGE0L2RTMEJ1NjZkUytaSzdRc1o1R2diWFRBYjhDWGQ4Z096?=
 =?utf-8?B?ak90K0I4ZWNhelZ6R2VKOEVPRW9yQXd4T1ZrN0ZQTHlCazJuQWxXaEMxZDJK?=
 =?utf-8?B?ckkyUWRLZlV1WTJNWWhjN0lNbWpWVVdXODh2QlBhK2lJMjZIOVNiYVBFZ2tl?=
 =?utf-8?B?WTRMN1JLVjFEZU93VldKOW4xaFk2NnR0bjdsN292VGE0RDM3eUtuVWcvM3hk?=
 =?utf-8?B?RzU4MUlKWDR6clJYQjdGMlNsSHc2NERGdjc5RWlWaGFLNHgwSFlUeXlaM3J1?=
 =?utf-8?B?N1hZNTFOL0c2L09xcEg4aitjeHVUd0ptMFhyL0UwUHhNVXZFSlJUSVZFZDVG?=
 =?utf-8?B?UzlFNkFpZnZYTG1pWmkxNWFwM1Rzc1phb05WbHRYZ2w5azhBOGI0TjU2RVUy?=
 =?utf-8?B?MHZnZ0p0ZUZ0NUlyOGE4TWlEWVJiZjg3T1BsZFkyaUFFZ09VYTJ5aHI2bHZB?=
 =?utf-8?B?VmRpa2F1a283SlhnSUtwbkt4Qyszbmx5MFAvRzgyajlrWXo2dGxBcTBPdkFj?=
 =?utf-8?B?eVBzcm92TTVWMk9DMFZLM0ViVFU5aEx0ZnlGdGl0eE5DcjN1d1FVa01KeDZB?=
 =?utf-8?B?L1JxdGs4U2RRVVp6WWFDTjRTdGVraUV1ZmhwTVVkRTBUSTFIUy9ncUJSQnpO?=
 =?utf-8?B?b0d0NHlDL1crdisrN3dTRWZ6MWFwWkVPb0hOQTdHSEpvSVpKVzVjVVk3NDI0?=
 =?utf-8?B?Z3RtZnJINEptdWVZUG5pZEVlTVFVTGE2UWhtM3dUNDVIR2QweXgrRzV0UGpR?=
 =?utf-8?B?bkNEMS91UG96VzZ4T1RDQWdpT3FLcW80TmFhbkVMeUtmZmRPcHBJMk5rQ2hH?=
 =?utf-8?B?eGZKVnNZd1B6Q0tzS1BnUGg3ZE4rZlVvUG5mYnpwQUcxd3R0Sk9FakpTQ0Nk?=
 =?utf-8?B?TUhneW1DWXkrcmFQRXRCQnBqY3p5UjdHN0d1T2RoL1NCdXNxbnRFd1hiUXB2?=
 =?utf-8?B?MjE4REw1Z092RWRpOGJpcllXRnozN2Z0UWJRcEpCSitMY3BaY3NaT2svOTJW?=
 =?utf-8?B?d2U5T0Vwak9hR2lTUW5aMm1pNlJjUm1sMkp5UHRjR0NtamloZmxSb2d0NW05?=
 =?utf-8?B?ZmpTdXFVMys4WFdKRHJQMzJtKy9iZmJ3NHZIUmlDVmJweWEyZHVXQkhSSDlH?=
 =?utf-8?B?dkdnL1JWSXBDc3lhWW1ubGtFd0ZHWkxjWEJ0WnNsTElIbHlpVHphR1NZV0xu?=
 =?utf-8?B?dTZGN0s2Mzhzb01aaFRIL08wUmZxMXgyQVF5OVRpNFBJeGN2OWFNZkNXb3dq?=
 =?utf-8?B?a09EcUZUbUFUQlpadXJSMUZGcEtHN0pPeU1WTkt4c3E1clN5OHlUVGZzeVhq?=
 =?utf-8?B?RnJxZUpZaGJHa3NDdnVBV2xHZko2YmYyNjhyOFowNHpnSXlpOURMYWRSSU1j?=
 =?utf-8?B?MFd4ME05YytLWVRnYjhNN3Y1UXUzbHBoWWVvU0dJU3Z0alg2UHVWNEt0azdk?=
 =?utf-8?B?d283UG9NbUt5QWxYOWI4c1pSMFQ1bkZVVUo4QzdDTG0vN1pQZjVPY2JKZkJV?=
 =?utf-8?B?dFZqZnJjWVVFblBnbWVlSDJFdTNmVzQ4NFQ2YVVCOGR3blQxV1RYaTVGaE1x?=
 =?utf-8?Q?TLXraAgbdIaKAND5S/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH6PR12MB345224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a906a5cd-2c74-44dc-2989-08df346177a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 19:35:33.3855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U62zdwFEYwxlcc4Z9IHiX2nbWvHgayXX/eha84IzldyGNUpEyZHDWJZEKT3aM1/eKmF0ijJaRglGspZpArLUfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogT2N0b2JlciAyNiwgMjAy
NiAxOjI5IFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT4NCj4g
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4g
PE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBFbnN1cmUgdGhh
dCBoYXJ2ZXN0IGluZm9ybWF0aW9uIGdldHMgc2V0DQo+DQo+IE9uIFRodSwgT2N0IDIyLCAyMDI2
IGF0IDY6MDbigK9QTSBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEFmdGVyIHRoZSBlYXJsaWVyIHBhdGNoIGV4cG9ydCBJUCBkaXNjb3Zlcnkgb24g
cHJvYmUgZmFpbHVyZSwgdGhlcmUgd2FzDQo+ID4gYW4gdW5leHBlY3RlZCBjb25zZXF1ZW5jZSB3
aGVyZSBoYXJ2ZXN0IGluZm8gd2FzIG5vdCBwb3B1bGF0ZWQuIFRoZQ0KPiA+IGVhcmx5LWV4aXQg
aW4gYW1kZ3B1X2Rpc2NvdmVyeV9zeXNmc19pbml0IG1lYW50IHRoYXQgd2UgbmV2ZXIgY2FsbGVk
DQo+ID4gYW1kZ3B1X2Rpc2NvdmVyeV9nZXRfaGFydmVzdF9pbmZvLCB3aGljaCBpcyB3aGVyZSB3
ZSBzZXQgdGhlIGFjdHVhbA0KPiA+IGhhcnZlc3QgdmFsdWUuIFRoZSBmaXJzdCB0aW1lIHdlIGNh
bGwgYW1kZ3B1X2Rpc2NvdmVyeV9zeXNmc19yZWN1cnNlDQo+ID4gd2l0aCBOVUxMIGluc3RlYWQg
b2YgYWRldiwgbW9zdCB2YWx1ZXMgY2FuIGdldCBzZXQuIFRoZSAybmQgdGltZQ0KPiA+IGFtZGdw
dV9kaXNjb3Zlcnlfc3lzZnNfcmVjdXJzZSBpcyBjYWxsZWQsIHdlIGJhaWwgZWFybHkuDQo+DQo+
IEFyZSB0aGVyZSBhbnkgb3RoZXIgSVAgZGlzY292ZXJ5IHRhYmxlcyB0aGF0IGdldCBtaXNzZWQ/
DQoNClRoZSBvdGhlciBibG9ja3MgYXJlIGFsbCBjb3ZlcmVkLiBUaGV5IGVpdGhlciBkb27igJl0
IGhhdmUgYWRldj09TlVMTCBjaGVja3MsIG9yIHRoZXkgYXZvaWQgYWRldiBhbmQgdXNlIHRoZSBJ
UCBkaXNjb3ZlcnkgYmluLiBUaGlzIHdhcyB0aGUgb25seSB1bmlxdWUgY2FzZSB3aGVyZSBhZGV2
PT1OVUxMIHdhcyBoYW5kbGVkIGRpZmZlcmVudGx5Lg0KDQogS2VudA0KDQo+DQo+IEFsZXgNCj4N
Cj4gPg0KPiA+IFRvIGtlZXAgdGhlIGxvZ2ljIG9mIHRoZSBmaXJzdCBwYXRjaCBpbnRhY3QsIGVu
c3VyaW5nIHRoYXQgb2xkZXIga2VybmVscw0KPiA+IGNhbiBzdGlsbCBkaXNjb3ZlciB0aGUgSVAg
YmxvY2tzLCBhZGQgYSBzZXBhcmF0ZSBjYWxsIGluIHRoZSBlYXJseS1leGl0DQo+ID4gc2VjdGlv
biB0aGF0IHNldHMgdGhlIGhhcnZlc3QgaW5mb3JtYXRpb24uIFRoaXMgc2hvdWxkIGJlIHRoZSBv
bmx5DQo+ID4gZnVuY3Rpb25hbGl0eSB0aGF0IGlzIG1pc3NlZCBpbiB0aGlzIGZsb3csIHRoZSBy
ZXN0IG9mIHRoZSBjYWxscyBlaXRoZXINCj4gPiB3b3JrIGZpbmUgd2l0aCBhZGV2PU5VTEwsIG9y
IHVzZSB0aGUgZGlzY292ZXJ5X2JpbiBkaXJlY3RseS4NCj4gPg0KPiA+IEZpeGVzOiAzZWUxMDY1
ZTk4MzAgKCJkcm0vYW1kZ3B1OiBFeHBvcnQgaXBfZGlzY292ZXJ5IHN5c2ZzIG9uIHByb2JlDQo+
IGZhaWx1cmUiKQ0KPiA+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDQ1
DQo+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gaW5kZXggMTZlMzEyOWRiNmExLi4zNDJl
ZGJkMDI4ODAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc2NvdmVyeS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc2NvdmVyeS5jDQo+ID4gQEAgLTE0NjksNiArMTQ2OSw0MSBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9kaXNjb3Zlcnlfc3lzZnNfcmVjdXJzZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRl
diwNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArI2RlZmluZSBsaXN0
X3RvX2tvYmooZWwpIGNvbnRhaW5lcl9vZihlbCwgc3RydWN0IGtvYmplY3QsIGVudHJ5KQ0KPiA+
ICsNCj4gPiArc3RhdGljIHZvaWQgYW1kZ3B1X2Rpc2NvdmVyeV9zeXNmc191cGRhdGVfaGFydmVz
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4gPiArew0KPiA+ICsgICAgICAgc3Ry
dWN0IGlwX2Rpc2NvdmVyeV90b3AgKmlwX3RvcCA9IGFkZXYtPmRpc2NvdmVyeS5pcF90b3A7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgaXBfZGllX2VudHJ5ICppcF9kaWVfZW50cnk7DQo+ID4gKyAgICAg
ICBzdHJ1Y3QgbGlzdF9oZWFkICplbF9kaWUsICplbF9od19pZCwgKmVsX2h3X2luc3Q7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgaXBfaHdfaWQgKmh3X2lkOw0KPiA+ICsgICAgICAgc3RydWN0IGtzZXQg
KmRpZV9rc2V0Ow0KPiA+ICsgICAgICAgc3RydWN0IGlwX2h3X2luc3RhbmNlICppcF9pbnN0Ow0K
PiA+ICsNCj4gPiArICAgICAgIGlmICghaXBfdG9wKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm47DQo+ID4gKw0KPiA+ICsgICAgICAgZGllX2tzZXQgPSAmaXBfdG9wLT5kaWVfa3NldDsNCj4g
PiArDQo+ID4gKyAgICAgICBzcGluX2xvY2soJmRpZV9rc2V0LT5saXN0X2xvY2spOw0KPiA+ICsg
ICAgICAgbGlzdF9mb3JfZWFjaChlbF9kaWUsICZkaWVfa3NldC0+bGlzdCkgew0KPiA+ICsgICAg
ICAgICAgICAgICBpcF9kaWVfZW50cnkgPSB0b19pcF9kaWVfZW50cnkobGlzdF90b19rb2JqKGVs
X2RpZSkpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgbGlzdF9mb3JfZWFjaChlbF9od19p
ZCwgJmlwX2RpZV9lbnRyeS0+aXBfa3NldC5saXN0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaHdfaWQgPSB0b19pcF9od19pZChsaXN0X3RvX2tvYmooZWxfaHdfaWQpKTsNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9mb3JfZWFjaChlbF9od19pbnN0LCAm
aHdfaWQtPmh3X2lkX2tzZXQubGlzdCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXBfaW5zdCA9IHRvX2lwX2h3X2luc3RhbmNlKGxpc3RfdG9fa29iaihlbF9od19pbnN0
KSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcF9pbnN0LT5oYXJ2ZXN0
ID0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2Rp
c2NvdmVyeV9nZXRfaGFydmVzdF9pbmZvKA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFkZXYsIGlwX2luc3QtPmh3X2lkLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlwX2luc3QtPm51bV9pbnN0
YW5jZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAg
ICB9DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBzcGluX3VubG9jaygmZGllX2tzZXQtPmxp
c3RfbG9jayk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVy
eV9zeXNmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICB7DQo+ID4gICAg
ICAgICB1aW50OF90ICpkaXNjb3ZlcnlfYmluID0gYWRldi0+ZGlzY292ZXJ5LmJpbjsNCj4gPiBA
QCAtMTQ3OSw5ICsxNTE0LDEzIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zeXNmc19p
bml0KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICAgICAgaWYgKCFkaXNj
b3ZlcnlfYmluKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+
IC0gICAgICAgLyogSWYgZWFybHkgaW5pdCBhbHJlYWR5IGNyZWF0ZWQgc3lzZnMgaW4gc3RhbmRh
bG9uZSBtb2RlLCBza2lwIG5vcm1hbCBpbml0ICovDQo+ID4gLSAgICAgICBpZiAoYWRldi0+ZGlz
Y292ZXJ5LmlwX3RvcCAmJiBhZGV2LT5kaXNjb3ZlcnkuaXBfdG9wLT5zdGFuZGFsb25lX21vZGUp
DQo+ID4gKyAgICAgICAvKiBJZiBlYXJseSBpbml0IGFscmVhZHkgY3JlYXRlZCBzeXNmcyBpbiBz
dGFuZGFsb25lIG1vZGUsIHVwZGF0ZSBoYXJ2ZXN0DQo+IGluZm8NCj4gPiArICAgICAgICAqIG5v
dyB0aGF0IGFkZXYgaXMgZnVsbHkgaW5pdGlhbGl6ZWQsIHRoZW4gc2tpcCB0aGUgcmVzdCBvZiBu
b3JtYWwgaW5pdC4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKGFkZXYtPmRpc2Nv
dmVyeS5pcF90b3AgJiYgYWRldi0+ZGlzY292ZXJ5LmlwX3RvcC0+c3RhbmRhbG9uZV9tb2RlKQ0K
PiB7DQo+ID4gKyAgICAgICAgICAgICAgIGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNfdXBkYXRlX2hh
cnZlc3QoYWRldik7DQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsgICAgICAg
fQ0KPiA+DQo+ID4gICAgICAgICBpcF90b3AgPSBremFsbG9jX29iaigqaXBfdG9wKTsNCj4gPiAg
ICAgICAgIGlmICghaXBfdG9wKQ0KPiA+IEBAIC0xNTM2LDggKzE1NzUsNiBAQCBzdGF0aWMgaW50
IGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4gPg0KPiA+ICAvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAqLw0KPiA+DQo+ID4gLSNkZWZpbmUgbGlzdF90b19rb2JqKGVsKSBjb250YWlu
ZXJfb2YoZWwsIHN0cnVjdCBrb2JqZWN0LCBlbnRyeSkNCj4gPiAtDQo+ID4gIHN0YXRpYyB2b2lk
IGFtZGdwdV9kaXNjb3Zlcnlfc3lzZnNfaXBfaHdfZnJlZShzdHJ1Y3QgaXBfaHdfaWQgKmlwX2h3
X2lkKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICplbCwgKnRtcDsNCj4g
PiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=
