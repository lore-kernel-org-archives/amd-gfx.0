Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5C9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 18:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0ED10E13B;
	Fri, 14 Jan 2022 18:47:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BBC10E13B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 18:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7Uk4cdMayy1utxi1bx54KpQ+my02Xl7K5r7EBfcxepFHgKCkUKfAKjYCBQHX0VeZETjYzzNx3J+QBWQrxjSO9HHaGrnRqpkbz91OZmvf1f+udyRP9w6owonmUZx2XD7D5irHLHUZ/DAueEs+bpaBSR0K1GQ5UoAIbeJabppqdkZ8V7wVtMknolvTpouPA7WUeVFkDsiO0hmKooA+or012pCgJNmvbhm4T2FHTvnBHccCLoLEwr/p3fY4XxH75aNsQFi1S45k5hkhuyj9qPBXTs6sZKnrtX0fvLkYfc3lLJX082JoEMYOWs/xzBWGuMbhPyhXOmYxdWIbHt41lk+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5GJwNiTrU6XcJQ3xd9hYIt9+Sct0BQ+aAx6N48QBYY=;
 b=RklNcIn10uoefunj6r/gjp5rgzklW4c3qpaQPazIS8OUepVlWIX+pNx3Mv1dLxHkjj93Qd4/Cwoitg3Iz3y46Fia0f6q1+sINlwOUVQx6t1Q9FbKhzonlQXMUoJMutKIdaunGlvxqBwwlMQPitG7WET2UCcTSeRyLXpH1PBjAauBTqC/q5TL6odsn1dSNXetP6/lXnVDdzxpDDFx8TtjQeBZUOEgl2xMfDoDNrYfw0nGn6XNo2HAcvLgsBbHv4XuYwjammKg7WxM0rtQe51tbMrw9/kGskMKqo6O4U7wqUB1EUNVqLKG2/BwAb+73Y3MdgxS0k9gCr6iVYzHAUonIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5GJwNiTrU6XcJQ3xd9hYIt9+Sct0BQ+aAx6N48QBYY=;
 b=Tsxda/HqtCVWpdh9jreXRalTKdJ1ESyH42MHCpYsJ1RNF5au/l9j50enRsONt0ue5LbRSR1Ku7v0237DACw12e4PdvbePqI/A+saL7l/WAptz02yYy9t+ZnBhlKqzNYhQYxUDw+w07z6WM0ub/7mWhNLrwe50xRaWp82t9jsHho=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 18:47:08 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 18:47:08 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, Chris Hixon
 <linux-kernel-bugs@hixontech.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Topic: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Index: AQHYA+aejevROlcgOU6dQwnYNuIzeaxXxwkAgAAeeiCACpYLAIAANTxAgAAUj4CAACDxEA==
Date: Fri, 14 Jan 2022 18:47:08 +0000
Message-ID: <BL1PR12MB5157D99E33BB70EF711EA66FE2549@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220107164959.12511-1-mario.limonciello@amd.com>
 <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
 <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <991bfaea-2978-321d-deb8-cefa4572877e@hixontech.com>
 <BL1PR12MB5157374DD79D0BF24D907DE3E2549@BL1PR12MB5157.namprd12.prod.outlook.com>
 <DM4PR12MB51821F1E18FB484415BACF31EC549@DM4PR12MB5182.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51821F1E18FB484415BACF31EC549@DM4PR12MB5182.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-14T18:47:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=df56ff08-9ecc-4e57-9cfc-9f6884e9433f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-14T18:47:06Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e75ecd14-96ae-441a-b1f9-1c76d9c568eb
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0525ee6-055b-471e-f313-08d9d78e4496
x-ms-traffictypediagnostic: SJ0PR12MB5487:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB5487B944AA598D5C2A1A47F2E2549@SJ0PR12MB5487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +FPg0JfOhtebplPgsRmcF4qO/Nrzjd9aInVq7tyyfBla+RSxpPhTgIuhdJteLDVQ2ltiac3T57KtGwZ7YeMZbGqz3DOI5KIVxEqclZmQ9l8M5ZVrf+qACjOoGCQI6yoMrY5x3SnZF5U/zSxfZ2Cik7/Bc63NavAniYNnhZSuKj0WtrSFX0ZKZYPeBx7+6nPsiOIn8XeIUdsAbO0Ly8eacy20i8SGK7eyYutSNqtZkIwwklYYN2UxD8zgRBnZXpstXdtN9HpmEq22tnMg/cgbKc56EPO1njZd0exWvYG2APZmZ1S5RQzzUnbWQkpGkv1vXv1KsH1TZ+I30OBbcowoA67vLip4VNfIoW4nVYS+wWtG2Vd9bTnCxUIj1nfBwe3FY0VnSOuRxP5LY4V4t25rbyJGV5xxfxPtN5pY2uKAAt0oBDISt5NVrIQThFxkAcUK1rv55tUrn7q8pKBJPaOeqlR2/jrPiS2Qhih86Jhe1j15JaNhyYx8clEDAQKBjQsNFL6VXVLmamxe2j2U9hIu/tneQGuLvPK5tHarv9Qk8i553bss/6ba55AkusndeOTMyVu1lbhsfKSTFUffYK1sdWOUeBXdfnM7IXl5Er9BGP6rXaqYvoDTClMXcBwHgqrbWe28kttzZBscH9didv90Bo0RAyiKDtPSWN1VNKLuJfTlbY4+J+msn+6sLR+SsjTpja7fQx4QpVoBFkQteAZjUh9DijEA+j4r0ldUUVEdO3A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(66946007)(55016003)(122000001)(4326008)(8936002)(33656002)(71200400001)(66556008)(7696005)(76116006)(6636002)(86362001)(64756008)(66446008)(5660300002)(66476007)(52536014)(8676002)(508600001)(6506007)(186003)(26005)(9686003)(38100700002)(83380400001)(38070700005)(54906003)(110136005)(316002)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnFITTkwa0JaUVhDTWtxNUdWeElzTHIrcFIrOUgrejJMM2JXWWVSb3ViQ2lY?=
 =?utf-8?B?QUZxWmlBOUpVTW1nQ05LR0VZNnpPbnZacUlVWG1kVTlqdlg5MlF1V3Y0Z1Ur?=
 =?utf-8?B?ckFMTVNqeGtsMVptMlN2ZlFlaTdDbmRjTmo0WURwNytpb1lsdHh4TW1PU040?=
 =?utf-8?B?SnZQUmxzaTQrSDBYbXpqS3pMVzA1YjJ3b1dlamtiTjJtRitXV0daK056OTRQ?=
 =?utf-8?B?WlFVR2Q3cVhwNXFqL2RXd2lBcHpIL3Vlam42d04vaExiNmsyU1l2WjUyZjJa?=
 =?utf-8?B?T21yVGZST2FFR2IwcENDbCtMRkxqdzRYUjgyYlh6bjFaeG9SbmpyVjBneStY?=
 =?utf-8?B?TEpjUmlTMjhPZU93K00yTjFrME5NUENobnRadTJ3QlFMNzR5TzJ3b1dYc1lP?=
 =?utf-8?B?ZUdMcmtsaGhZVDUvd2EwenJYOGFXSkVoL1JoSXBpMkZLSW8yTlVoanhjai9F?=
 =?utf-8?B?cDVCK0JzUXRxUU95R1BvcUhLUlljWm5ka1lzdCtvRDRpQU9jSzl5T3piS255?=
 =?utf-8?B?czFmeEpSeHRkM1Brcy9hSldMNzVtdFU5ZkkxQk1HdFR3dVkxU0JyU1A2MkNo?=
 =?utf-8?B?N2pYbUxzRCtSeUoyK2N5VmkwSEI2UXRrRThYK0d0bzlPSS9IS0VPeC9HY0lX?=
 =?utf-8?B?N0Zlb3M1WVRyZGIrNjd5bG1xVXpwRU1XL3p0Q3RTTXlucDhtY1VqS0ZaUHl2?=
 =?utf-8?B?czBzUXpXN0Y1bUJ0cnFPU3U0by8zdk1jL0tBZ3BaeG5jT3oydVNSeU84MjNC?=
 =?utf-8?B?YkJ5WmdIQzJrN1V4ZHBuRVNJRkU1ZlhqdVVlTjdMc21wWitJZHAxemhUVVJr?=
 =?utf-8?B?OXl1MkhRaWxKaStacHBGSGZqcFNYaHduT0RmUTUwOVhHc3hTUU5XME9ON3pW?=
 =?utf-8?B?NGlFQW1VTEdueFpCc3E5RFJ2Q1pTMnJvTjFFTllaQU5lNWlqb0REVDhZcGcz?=
 =?utf-8?B?OExsUG9LZzJVdk9aTXBBMkZFSFBiSWhHTU8rbnNkRjRuS0FOZmZZSENwbzcv?=
 =?utf-8?B?QWRiMytySDNsU3RKdVNISFJaZXFiSlptYmhRUVNtTHZiekdUMjBVMm1jMjRj?=
 =?utf-8?B?TE10V2YxLzBSeE1TNDNNdTRKWUZ4ZlpzdlMzanFyaWJ6ZnZFdTZqSVZBNHND?=
 =?utf-8?B?cUlpVVZFZE8wdEJkWVo1TDhNTEh2YnZwT1U1Y29HeVVKTSsrNWFCMGNJd3Iw?=
 =?utf-8?B?d0F3anZOUkx3K2E0MmtIck13VEV1TEVMRWRnRzhOV2ZEK0Q3VSsyUUFIRC9G?=
 =?utf-8?B?NkFFRUZFQ3JiZmIyV0lHUVdaZ1FJQlpJM1FjckxWQTZ2ZGQycWVkeEttak41?=
 =?utf-8?B?UEV3OVV5c0JlRldqYm5sSUxxYXowRlhiWFZoMU0yRC8wS2o1WjFnTVJjSzB3?=
 =?utf-8?B?amZ2Smw1S21tem9uOG03eStKVHlpYUQ4cmlHKzkxL1dyZkE5ZlcwT3Q0NFhQ?=
 =?utf-8?B?SmZEd2Jra2lKZTl1WHdFeDY0R1lTUmdBRjFDcWo4T1hoMkR6STB1RllycFFz?=
 =?utf-8?B?VE44R3BSbHB3Q3FoZ1c5YWJYUzc2NHhiQ01FQXNpNXRMTmU0clJaZGdVOGtX?=
 =?utf-8?B?NlVTUjhocSt6T0dTODhTNnhwZmpLRXJWSGs3TWkwMTRyNmtLUVQzQi9JckZ1?=
 =?utf-8?B?SW1ub2xEdExzSHdzWURrNnpSSUJ0SmZlTFJqcXRWOHRvZjNnanJ1d3VUb2dl?=
 =?utf-8?B?T3VDVmJMdVVsaXRBeFhXYkVNcG5JNXU3R09XbVFEUmpMNEtNU1FIN2VHODBk?=
 =?utf-8?B?S05McExOVHppOGlJK0dDSXRONVlmMWxOSS9DS1ZOaS93Vm93aVhIQVhMRTl1?=
 =?utf-8?B?TFoySmE1cFE4ZVliU09nNzB2T29tRXA1WGh4ZDRpME1LZ29HRWlmUmIzNEhp?=
 =?utf-8?B?YzBBc1FweHdidndRdXBOQkJtSHZQa1dhbjlYYSt4d2R6Z2psMEVyaGhqeUNi?=
 =?utf-8?B?amRuV25BenNYU2VLdTUwYitwTExLWWZaT0ltZzJ1Sjl4dmluK0VJdWEraHZF?=
 =?utf-8?B?dU9SS0EwdS81RTFMclpiUjZKeFJWNk1MK0tMZERrbWQxcm5uV3hzU1paa2Vx?=
 =?utf-8?B?Y0FoOTFEYzJ3VDBUVXhjSVI2QjRFek15d1owV256Yy9pZUQ0WTlpU0JlSjRm?=
 =?utf-8?B?RHpiVk1Qam5pbUZubk5UNkV0TStiTjJnQm9GZUhmNEREdEQ1MERndG9DdUFq?=
 =?utf-8?Q?oFkvQbHW7XFQFvC652sRl+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0525ee6-055b-471e-f313-08d9d78e4496
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 18:47:08.5238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VWXI9XfZbsM25clKEigodCyE27hHoZ4zlNdCFzH/ugftZZ0Cmr0XCsiB8KNk5YG0VVagHt7+GPXJ2cjNVNedQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPj4gSSB0aGluayB0aGUgcmV2ZXJ0
IGlzIGZpbmUgb25jZSB3ZSBmaWd1cmUgb3V0IHdoZXJlIHdlJ3JlIG1pc3NpbmcgY2FsbHMgdG86
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gICAgICAgICAgLm9wdGltaXplX3B3cl9zdGF0ZSA9IGRjbjIx
X29wdGltaXplX3B3cl9zdGF0ZSwNCj4gPiA+ID4+ICAgICAgICAgIC5leGl0X29wdGltaXplZF9w
d3Jfc3RhdGUgPSBkY24yMV9leGl0X29wdGltaXplZF9wd3Jfc3RhdGUsDQo+ID4gPiA+Pg0KPiA+
ID4gPj4gVGhlc2UgYXJlIGFscmVhZHkgcGFydCBvZiBkY19saW5rX2RldGVjdCwgc28gSSBzdXNw
ZWN0IHRoZXJlJ3MgYW5vdGhlcg0KPiA+ID4gaW50ZXJmYWNlDQo+ID4gPiA+PiBpbiBEQyB0aGF0
IHNob3VsZCBiZSB1c2luZyB0aGVzZS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBJIHRoaW5rIHRoZSBi
ZXN0IHdheSB0byBkZWJ1ZyB0aGlzIGlzIHRvIHJldmVydCB0aGUgcGF0Y2ggbG9jYWxseSBhbmQg
YWRkIGENCj4gPiBzdGFjaw0KPiA+ID4gPj4gZHVtcCB3aGVuIERNQ1VCIGhhbmdzIG91ciB0aW1l
cyBvdXQuDQo+ID4gPiA+IE9LIHNvIEkgZGlkIHRoaXMgb24gdG9wIG9mIGFtZC1zdGFnaW5nLWRy
bS1uZXh0IHdpdGggbXkgdjUgcGF0Y2ggKHRoaXMNCj4gPiByZXZlcnQgaW4NCj4gPiA+IHBsYWNl
KQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMNCj4gPiA+ID4gaW5kZXggOTI4MGYyYWJkOTczLi4wYmQz
MmY4MmYzZGIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kbXViL3NyYy9kbXViX3Nydi5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jDQo+ID4gPiA+IEBAIC03ODksOCArNzg5LDEwIEBA
IGVudW0gZG11Yl9zdGF0dXMNCj4gPiA+IGRtdWJfc3J2X2NtZF93aXRoX3JlcGx5X2RhdGEoc3Ry
dWN0IGRtdWJfc3J2ICpkbXViLA0KPiA+ID4gPiAgICAgICAgICAvLyBFeGVjdXRlIGNvbW1hbmQN
Cj4gPiA+ID4gICAgICAgICAgc3RhdHVzID0gZG11Yl9zcnZfY21kX2V4ZWN1dGUoZG11Yik7DQo+
ID4gPiA+DQo+ID4gPiA+IC0gICAgICAgaWYgKHN0YXR1cyAhPSBETVVCX1NUQVRVU19PSykNCj4g
PiA+ID4gKyAgICAgICBpZiAoc3RhdHVzICE9IERNVUJfU1RBVFVTX09LKSB7DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBBU1NFUlQoMCk7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgcmV0dXJu
IHN0YXR1czsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgIC8v
IFdhaXQgZm9yIERNVUIgdG8gcHJvY2VzcyBjb21tYW5kDQo+ID4gPiA+ICAgICAgICAgIHN0YXR1
cyA9IGRtdWJfc3J2X3dhaXRfZm9yX2lkbGUoZG11YiwgMTAwMDAwKTsNCj4gPiA+ID4NCj4gPiA+
ID4+IFRoYXQgd2F5IHlvdSBjYW4ga25vdyB3aGVyZSB0aGUgUEhZIHdhcyB0cnlpbmcgdG8gYmUg
YWNjZXNzZWQNCj4gPiB3aXRob3V0IHRoZQ0KPiA+ID4gPj4gcmVmY2xrIGJlaW5nIG9uLg0KPiA+
ID4gPj4NCj4gPiA+ID4+IFdlIGhhZCBhIHNpbWlsYXIgaXNzdWUgaW4gRENOMzEgd2hpY2ggZGlk
bid0IHJlcXVpcmUgYSBXL0EgbGlrZSBEQ04yMS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBJJ2QgbGlr
ZSB0byBob2xkIG9mZiBvbiBtZXJnaW5nIHRoaXMgdW50aWwgdGhhdCBoYW5nIGlzIHZlcmlmaWVk
IGFzIGdvbmUuDQo+ID4gPiA+Pg0KPiA+ID4gPiBUaGVuIEkgdG9vayBhIFJOIGxhcHRvcCBydW5u
aW5nIERNVUIgMHgwMTAxMDAxOSBhbmQgZGlzYWJsZWQgZURQLCBhbmQNCj4gPiA+IGNvbmZpcm1l
ZA0KPiA+ID4gPiBubyBDUlRDIHdhcyBjb25maWd1cmVkIGJ1dCBwbHVnZ2VkIGluIGFuIEhETUkg
Y2FibGU6DQo+ID4gPiA+DQo+ID4gPiA+IGNvbm5lY3Rvcls3OF06IGVEUC0xDQo+ID4gPiA+ICAg
ICAgICAgIGNydGM9KG51bGwpDQo+ID4gPiA+ICAgICAgICAgIHNlbGZfcmVmcmVzaF9hd2FyZT0w
DQo+ID4gPiA+IGNvbm5lY3Rvcls4NV06IEhETUktQS0xDQo+ID4gPiA+ICAgICAgICAgIGNydGM9
Y3J0Yy0xDQo+ID4gPiA+ICAgICAgICAgIHNlbGZfcmVmcmVzaF9hd2FyZT0wDQo+ID4gPiA+DQo+
ID4gPiA+IEkgdHJpZ2dlcmVkIDEwMCBob3RwbHVncyBsaWtlIHRoaXM6DQo+ID4gPiA+DQo+ID4g
PiA+ICMhL2Jpbi9iYXNoDQo+ID4gPiA+IGZvciBpIGluIHswLi4xMDAuLjF9DQo+ID4gPiA+IGRv
DQo+ID4gPiA+ICAgICAgZWNobyAxIHwgdGVlIC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL0hETUkt
QS0xL3RyaWdnZXJfaG90cGx1Zw0KPiA+ID4gPiAgICAgIHNsZWVwIDMNCj4gPiA+ID4gZG9uZQ0K
PiA+ID4gPg0KPiA+ID4gPiBVbmZvcnR1bmF0ZWx5LCBubyBoYW5nIG9yIHRyYWNlYmFjayB0byBi
ZSBzZWVuIChhbmQgSERNSSBjb250aW51ZXMgdG8NCj4gPiB3b3JrKS4NCj4gPiA+ID4gSSBhbHNv
IG1hbnVhbGx5IHB1bGxlZCB0aGUgcGx1ZyBhIGhhbmRmdWwgb2YgdGltZXMgSSBkb24ndCBrbm93
IHRoZQ0KPiA+IHNwZWNpZmljcw0KPiA+ID4gdGhhdCBMaWxsaWFuIGhhZCB0aGUNCj4gPiA+ID4g
ZmFpbHVyZSB0aG91Z2gsIHNvIHRoaXMgbWlnaHQgbm90IGJlIGEgZ29vZCBlbm91Z2ggY2hlY2su
DQo+ID4gPiA+DQo+ID4gPiA+IEknbGwgdHJ5IHRvIHVwZ3JhZGUgRE1VQiB0byAweDEwMTAwMWMg
KHRoZSBsYXRlc3QgdmVyc2lvbikgYW5kIGRvdWJsZQ0KPiA+IGNoZWNrDQo+ID4gPiB0aGF0IGFz
IHdlbGwuDQo+ID4gPg0KPiA+ID4gSSBhcHBsaWVkIHBhdGNoIHY1IGFuZCB0aGUgYWJvdmUgQVNT
RVJUIHBhdGNoLCBvbiB0b3Agb2YgYm90aCBMaW51eA0KPiA+ID4gNS4xNi1yYzggYW5kIDUuMTYu
DQo+ID4gPg0KPiA+ID4gUmVzdWx0OiBubyBwcm9ibGVtcyB3aXRoIHN1c3BlbmQvcmVzdW1lLCAx
NisgY3ljbGVzLg0KPiA+ID4NCj4gPiA+IEFzIGZhciBhcyB0aGUgaGFuZyBnb2VzOg0KPiA+ID4N
Cj4gPiA+IEkgcGx1Z2dlZCBpbiBhbiBIRE1JIGNhYmxlIGNvbm5lY3RlZCB0byBteSBUViwgYW5k
IGNvbmZpZ3VyZWQgR25vbWUgdG8NCj4gPiA+IHVzZSB0aGUgZXh0ZXJuYWwgZGlzcGxheSBvbmx5
Lg0KPiA+ID4NCj4gPiA+IGNvbm5lY3RvcnMgZnJvbSAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9z
dGF0ZToNCj4gPiA+DQo+ID4gPiBjb25uZWN0b3JbNzhdOiBlRFAtMQ0KPiA+ID4gICAgICBjcnRj
PShudWxsKQ0KPiA+ID4gICAgICBzZWxmX3JlZnJlc2hfYXdhcmU9MA0KPiA+ID4gY29ubmVjdG9y
Wzg1XTogSERNSS1BLTENCj4gPiA+ICAgICAgY3J0Yz1jcnRjLTENCj4gPiA+ICAgICAgc2VsZl9y
ZWZyZXNoX2F3YXJlPTANCj4gPiA+IGNvbm5lY3Rvcls4OV06IERQLTENCj4gPiA+ICAgICAgY3J0
Yz0obnVsbCkNCj4gPiA+ICAgICAgc2VsZl9yZWZyZXNoX2F3YXJlPTANCj4gPiA+DQo+ID4gPiBJ
IG1hbnVhbGx5IHVucGx1Z2dlZC9wbHVnZ2VkIHRoZSBIRE1JIGNhYmxlIDE2KyB0aW1lcywgYW5k
IGFsc28gcmFuOg0KPiA+ID4NCj4gPiA+ICQgc3VkbyBzaCAtYyAnZm9yICgoaT0wO2k8MTAwO2kr
KykpOyBkbyBlY2hvIDEgfCB0ZWUNCj4gPiA+IC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL0hETUkt
QS0xL3RyaWdnZXJfaG90cGx1Zzsgc2xlZXAgMzsgZG9uZScNCj4gPiA+DQo+ID4gPiBUaGUgc3lz
dGVtIGRpZCBub3QgaGFuZywgYW5kIEkgc2F3IG5vIGtlcm5lbCBsb2cgb3V0cHV0IGZyb20gdGhl
IEFTU0VSVC4NCj4gPiA+DQo+ID4gPiBJIGFsc28gdHJpZWQgYSBVU0ItQyBkb2NrIHdpdGggYW4g
SERNSSBwb3J0LCB3aXRoIHRoZSBzYW1lIHJlc3VsdHMsDQo+ID4gPiB0aG91Z2ggdGhlcmUgYXJl
IG90aGVyIGlzc3VlcyB3aXRoIHRoaXMgKHBlcmhhcHMgd29ydGh5IG9mIG90aGVyIGJ1Zw0KPiA+
ID4gcmVwb3J0cykuDQo+ID4gPg0KPiA+ID4gSXMgdGhlcmUgc29tZSByZWFzb24gdG8gdXNlIGFt
ZC1zdGFnaW5nLWRybS1uZXh0IGZvciB0aGlzIHRlc3Q/DQo+ID4gPg0KPiA+ID4gSSBkb24ndCB1
c2UgdGhlIEhETUkgY29ubmVjdGlvbiBtdWNoIGFuZCBJIGhhdmUgbmV2ZXIgZXhwZXJpZW5jZWQg
YQ0KPiA+IGhhbmcNCj4gPiA+IHdpdGggSERNSSBpbiB0aGUgZmlyc3QgcGxhY2UuIENhbiBzb21l
b25lIHNlbmQgYSBsaW5rIHRvIGFuDQo+ID4gPiBpc3N1ZS9kaXNjdXNzaW9uIHdoZXJlIHRoaXMg
aGFuZyBpcyBiZWluZyBkaXNjdXNzZWQ/DQo+ID4gPg0KPiA+ID4gSFc6IEhQIEVOVlkgeDM2MCBD
b252ZXJ0aWJsZSAxNS1kczF4eHgsIEFNRCBSeXplbiA3IDQ3MDBVIHdpdGgNCj4gPiBSYWRlb24N
Cj4gPiA+IEdyYXBoaWNzDQo+ID4gPiBPUy9EZXNrdG9wOiBBcmNoIExpbnV4LCBHbm9tZSA0MS4z
IChXYXlsYW5kKQ0KPiA+ID4gRlc6IGxpbnV4LWZpcm13YXJlLWdpdCAyMDIxMTIyOS41N2Q2Yjk1
LTEsIERNVUIgdmVyc2lvbj0weDAxMDEwMDFDDQo+ID4gPg0KPiA+DQo+ID4gTmljaG9sYXMsDQo+
ID4NCj4gPiBXZSd2ZSBnb3QgYSBoYW5kZnVsIG9mIHBlb3BsZSBub3cgKG15c2VsZiBpbmNsdWRl
ZCkgd2hvIGhhdmUgZG9uZSBhDQo+ID4gYnVuY2ggb2YNCj4gPiBwaHlzaWNhbCBhbmQgc29mdHdh
cmUgdHJpZ2dlcmVkIGhvdHBsdWdzIG9uIGEgdmFyaWV0eSBvZiBwb3J0cyBvbiB0b3Agb2YgYm90
aA0KPiA+IGFtZC1zdGFnaW5nLWRybS1uZXh0IGFuZCA1LjE2IGFuZCBub3Qgc2VlaW5nIGFueSBo
YW5ncy4gIEdpdmVuIHRoaXMgaXMNCj4gPiBsaW5nZXJpbmcNCj4gPiBvbiA1LjE2LCBhcmUgeW91
IGFtZW5hYmxlIHRvIGl0IGFuZCBsZXR0aW5nIExpbGxpYW4gZGlnIGZ1cnRoZXIgYWZ0ZXIgc2hl
IHJldHVybnMNCj4gPiBvbg0KPiA+IHRoZSBzcGVjaWZpYyBjYXNlIHRoYXQgc2hlIGhhZCBwcm9i
bGVtcyB3aXRoIHRvIHNlZSBpZiB3ZSdyZSBtaXNzaW5nIGFueXRoaW5nDQo+ID4gZWxzZT8NCj4g
Pg0KPiA+IFRoYW5rcywNCj4gDQo+IEkgdGhpbmsgaXQgd2FzIG9ic2VydmVkIGR1cmluZyBIRE1J
IGNvbXBsaWFuY2UgdGVzdGluZyBvciBmcmVxdWVudCBIRENQDQo+IGVudGVyL2V4aXQgb24gQ2hy
b21lLCBJIGRvbid0IHJlbWVtYmVyIHRoZSBkZXRhaWxzIG9mZiB0aGUgdG9wIG9mIG15IGhlYWQu
IFRoZQ0KPiBzeXN0ZW0gd291bGQgY29tcGxldGVseSBsb2NrIHVwIHVuZGVyIHRob3NlIGNvbmRp
dGlvbnMuDQo+IA0KPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIHVyZ2VuY3kgb2YgdGhlIHJl
cXVlc3QgZm9yIHlvdXIgc3BlY2lmaWMgaXNzdWUsIGJ1dCBpZiB5b3UNCj4gZmVlbCB0aGF0IHRo
ZSB0cmFkZW9mZiBpcyB3b3J0aCBpdCB0aGVuIHlvdSBjYW4gZ28gYWhlYWQgYW5kIHJldmVydCBm
b3Igbm93Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFz
LmthemxhdXNrYXNAYW1kLmNvbT4NCj4gDQo+IFJlZ2FyZHMsDQo+IE5pY2hvbGFzIEthemxhdXNr
YXMNCg0KVGhhbmtzLiAgQWxleCwgd2hlbiB0aGlzIHB1bGxzIGluIGNhbiB5b3UgYWRkIENDIGZv
ciBzdGFibGUgc28gd2UgZ2V0IGl0IGluIDUuMTYuMSB0b28/DQo=
