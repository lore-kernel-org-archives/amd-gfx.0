Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D283FD8741
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 11:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1780410E073;
	Tue, 17 Mar 2026 11:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqtxVa4V";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8E010E073
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 11:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idgjriw21DujcfEk2TZJG0vKbxwKXPTom8L/hoIiXwAvj3dkAU04bAj58AUcAHfrMJU+XWdyxqUkH03AegPB/5n68rV67goGhwjgwBMc6e1ueUvLEylZuaYLlo2eO8UhCKx9ZW88o3NgyonK08beaLg4l2fEqWwNR9EV6BZhG9G5ufkAeqdOFoGAJM4e1BrX7feouNm4JCsfC4hykoi/5AlwnYZIAsWco2wke65Z5KC87qg3HSnBw+0siryqHldLM0qZUGhti4thDCp42utnknuiXZKqu/H7hDGaZ520PPqlK8jlmfzBS1NJYwRKiiXOI8jLWB6gnbhhu0EkAUV//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYXgIvb4gNmnL5wd8N6tJMiTg9LIdffva6khnj460mo=;
 b=aUGVlST15TCGFPumkpQHdTAtp0v9EZXH6Ema5MXntoAwVmfNOfF2oriVhK0bAKQ1+NkBHGcYWpCJ98NhXqaUYnwXJW5xv3IwzWJcuYaaLilxtZyRkQ/9Z+3qzCOQ5o0OUyLFAH/tB1AROAtQNHRBE/2vEGq1r1LoMk4xinjfR+kIqfjv04ON/7VVG017tzHbzycia8wESDXasSeVYhL+ceCQPpE4Yl4sLWxMBOrL04q1hNWCEwup7dM/WZ3j5Qj0Mg73h24jpv/SPlk292X1lfiUumQxnuGHc9qobYRrtZ+JacrM0P2cCXZ8rR21g8J4NtK1kl8zOv4QOEoRFY83ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYXgIvb4gNmnL5wd8N6tJMiTg9LIdffva6khnj460mo=;
 b=sqtxVa4VbTadaaoEY4S4tzhu5etLUaMUgjYYi7WJ3fVqvJOoJiQT6akOFjrQFbjGMfOJEXB02DhBGoVeAWT8lhvmdDSwGICXcF2qI+MtS6AhlWsuc2t+Wx3/xzlGwzRiyiX74RpMNVxQgXbXQ2WIoet1A4kWdOjtHMkshdRAuGE=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 11:54:59 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 11:54:58 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "tursulin@ursulin.net"
 <tursulin@ursulin.net>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
Thread-Topic: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
Thread-Index: AQHcsMICsYz9P8UxbE2MvZq1Ifr0IrWsGghAgAZtW4CAABR/YIAAA4iAgAAHyWA=
Date: Tue, 17 Mar 2026 11:54:58 +0000
Message-ID: <PH7PR12MB60000372310681CE954671C4FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
 <PH7PR12MB6000407BC326A3D9ADB2AC48FB45A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <074594f1-59d1-4cd7-9b2a-997106b76167@amd.com>
 <PH7PR12MB60009290374F2995C51FD4A1FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <9bc4dbbc-1900-4620-9525-fd34a50fc565@amd.com>
In-Reply-To: <9bc4dbbc-1900-4620-9525-fd34a50fc565@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-17T11:51:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MN2PR12MB4127:EE_
x-ms-office365-filtering-correlation-id: 174a5023-237a-4c29-fee4-08de841c039e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|38070700021|56012099003|18002099003|7053199007|22082099003;
x-microsoft-antispam-message-info: 1dLH/FgD4WhGENkc7yLZkUcMEVnNKNAOZpV/1st55mB9bs6ve6kMhsALm6RAgKBhxLSte9qK1940HR8l2O0MJktJgq7OiSCFds5AHGvwr3+nVuNIrrZ9uSDLfKfHnycFgknjrsUSI9AMoBw6SxD//byW9yot7XWN+3o5R5s9PGBGiCBMcctegyL9gFIJs2zsVWaalUWXDgQX+fx4DOW7mnKqZ3fK6P4S/J37VZsiPvKY0+/NrgecI2h+PQkctwjN4PUMsii5b3zpfe27Bdh7+yGm+5FISkiGZq9MtPz8O8GJW86MAHVbj9VEBBpjNKQN9OwJCNk04wRvg0sV38d+m7osf3mIgXda1KJqD3k/zzKPj9XwWIstra1X8R53nLw12nwk0G1UVWDKG/mL//yp0mLGtFTaIzSrGu2BDmKRadZ9hgVwUuaEy399l+vM8VEbKU6Ye3NrQ0A/f424cC6xrCqyqFf+jPa+3+ajiWZpi99b6EIiQb261iRMzkxqzqizQB8m3Z4qyGDDPPjtxTbY2UGa4BLvcVjwCAdY1aUdAM5aI3Xs7rb6tc0xCV5t3AMJM7fIgGViH2Is5rBcP2VHRTj3FEJg85V0hlNnX5KBykKvNikR7i8+siLPIDwRKFfky/uTHPqyQ9mtlXtzNvOXlzohrMBNGxi5fgy3MyX2ZQ+B38WZalxZA4rtb4ncscX9FLbdyxYpUn9BxncXrRSP0uxHE1qO35IZx4+NMg3VEpclGsbs1P6Jg72zBH5hDADdGgQ65sobv0qCVLVSK8fK5N2AKRgU7AmTeJAKzn0J0XPcSDagC92EhMltInXvXE7o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700021)(56012099003)(18002099003)(7053199007)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3M5cmRQcFZCV2IzR2VxMFUyWS9kaERiS0ZUb0E2dmRzcHJuTENCR3JwenRI?=
 =?utf-8?B?NTZMbTJxeUtiM3lXczE1dllkbHVhWmNoZ2FtcEtjOGxnQlgrNVcxWHBiSXdp?=
 =?utf-8?B?T1RUSVhOL3lac3YyRExma2FSYkxRbDJnck90d29nNklkbnRWK0N5UWIzN0c5?=
 =?utf-8?B?TE9sN2xSSGFCSHlOWUtvUmZ0WU5ER3Bic0dGU2NaWHJudjJWTm0ySXgwWWln?=
 =?utf-8?B?WHAwdWN4VXhVeW5ZWW5TSFhWMnhDTFFtbWliV1VNdjNCRTdacFRlcFZDUC9K?=
 =?utf-8?B?ZExqVnFVaGZLR2VZTFBjTksxQUdWUVRleVBOd3QvVkFCaElGSjdIenBKUXM2?=
 =?utf-8?B?aG9lamRsVWUwS05PemtRdHk1NDRpUmZUT01adTRBTndwT1RJNWVhUTBEb2Mr?=
 =?utf-8?B?Y29zano3ZUcvTko5RVMwNC9SdjBzWGlJcUJKcEZhUUdPNk1FeXNOKzQzN2Rw?=
 =?utf-8?B?Q1ErRWJnd3NpZHRYRWJ3TzhrWUZjY2wwQ3YweXRUVU1mSnFsYXZoMUVINEFT?=
 =?utf-8?B?VU1TM2QxNzljZjRLNlJpZWJhZXdsY0JFZ2RPMGgxcitKbzBrb1VKbTRyb3pP?=
 =?utf-8?B?RStJdHhGZGs4MmlYVG1CdzJ4NjJyOWxUajcxZWJ0Y1pXQ0g5NUx1NTZYR3Mx?=
 =?utf-8?B?SDJsbFdXT2NqUE82R2J2M1p0d2QyWVlWeDVlUUJGenRNYnk0WXdmczZPTkU1?=
 =?utf-8?B?U3hiZTRJSHdEOGhFU3JSSkhZR0NXQ1VPbG85UG9PSzlINjNqaUg4OWExeHEv?=
 =?utf-8?B?VFVIR2VHdDJBTm9ML20xZFVNSjl0c0tiZmw5Y09qc1JoQXNCaTlhL3lYNExt?=
 =?utf-8?B?cVBndFJGNDVib0lJVDlqeHROeUZQYTdJM290UnBIZ0xTM0JNdEFuRHZNOGE4?=
 =?utf-8?B?enhpdEM2cUhCNnIrUis1Qk1LQ1E0WWVIMXQ4VHhWeFZMZE0zY1JmVkVzK0Fx?=
 =?utf-8?B?c0laY051T2lUY0Y0a2N3OEE1TTdORWlHRmZLNGs5SllRUXZwUXNZdnpLZjh4?=
 =?utf-8?B?NFljMUVGUFZXR2pPQitGWHVCM2k4czNRS2pFME5meGM5TEhTWVRyT0UwV1hx?=
 =?utf-8?B?UEt3Q0JadVJybVpvZWdJS1psckt2b0RiR0ZFaXY3RForbGxqMy9oTEVpeHh5?=
 =?utf-8?B?YUhGRjhUaitZTnMyVEs2b3lhQ3F1RTFENFc0eUZGd2tpTkpsUlhCS2UvTkQ1?=
 =?utf-8?B?TWVGUVM1YzV6enFOYVhHUnJ5elFsb09YWG95N3p3M2FYMVgrVEtNMTZtUU5P?=
 =?utf-8?B?SHlBdFBQUlBvQ2hvNHlGSXVVS2lqbStOeXN5RWxHaFhpSlJLcllTVklYRVEy?=
 =?utf-8?B?anEyeDVkWVVURlEwTFBlbmxuNlphdVM0U1pmS1ZkQlQ2REVaWGROS2Judyta?=
 =?utf-8?B?V2hiYTJKNlFZcWNFU0EvN2Q1TU5mMklyTC9FRGliS3ZsR084RVFYYnBac3Er?=
 =?utf-8?B?clJvcEZhM1daTVFsdmcrVWRVWng3RUx0MG9Rb1RWdUd3NVk2MVpMemxUV2dz?=
 =?utf-8?B?WEVGK3pnVWU5K3llWFVkazZEVFI0N2NiUTJPOFRyWm5SeWR5NWtsbnRmb0I4?=
 =?utf-8?B?QlNkLzJVNDUwOStMS3BhZWxZaVlwWENacG16L1NtdHNNeWNzdklaVDYyaFdQ?=
 =?utf-8?B?TkExVjU0em5LdjlKa2gzZVlPam9VcWxTSlhRcTI4cDk4bzJmY3FKZkc4Z1RL?=
 =?utf-8?B?dm1KTzZOYlp0V3pqTlpvTzVMT2dyMzZtZXlIL3hZQStmTWQ0djFmZVQ0T0pO?=
 =?utf-8?B?Z2g1NWZuUnB4cnRKUEFIc01ucVNUbHZVckVoMHhiNWhNWFB6WlVNemxsYVJk?=
 =?utf-8?B?a0tBMU02VXI3dzdISFJnSFZsWEpEVUw1S1JWWVNYT0ZZaU5laStReFhySWsv?=
 =?utf-8?B?SkdJeUxoNkphNHlxd2tDUjAveXRackNqYTNZTTVqdmdFZjBQdXkxM0E2WXRP?=
 =?utf-8?B?RUJ3VVRVckcreTFPRy9LQ01CUnQ2NWlWNVl5bVFYTXE3WEZpNG9JRTAwVkRv?=
 =?utf-8?B?THdpSEkxTnZtZXlydUEvT3BzWWRja2s4ZTF2QmRpRkZvSU9xZExMaTlVOHRu?=
 =?utf-8?B?NzFaMExjei94VWpsT3IyQ014L1NKWlVoOVEvRlNoRU5aQTAwcmdoQjFkakNN?=
 =?utf-8?B?VXY5UTdBWXUyTUNLU1l5dWZVWXZzZWtJZkx2SDJQc1crMlhPeUttUS8ybzMv?=
 =?utf-8?B?R0lxUHZsdU9iUjAzTHowMkF0bUJnTGhwSFMvL2RhLzdNdWtvdDVCT1VWRzNv?=
 =?utf-8?B?RUFOQkJQZzVjR2pqWVpvWFRLYmVMN24xSkVJbUVRU0h2bUZjZzVneEJOeXk0?=
 =?utf-8?Q?h1lvAXGdJhBsvzHO+P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174a5023-237a-4c29-fee4-08de841c039e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 11:54:58.7382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTPuelrL7NB4wXgJObdENs7rfxViq3pO876Rb8A5wtvE/jgA/wblyyZPGnD7KImn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTcsIDIwMjYgNzoyMyBQTQ0KPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgdHVyc3VsaW5AdXJzdWxpbi5uZXQ7IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE1vaGFuIE1h
cmltdXRodSwgWW9nZXNoDQo+IDxZb2dlc2guTW9oYW5tYXJpbXV0aHVAYW1kLmNvbT47IFNIQU5N
VUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IEtoYXRy
aSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPjsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNC8xMV0gZHJtL2FtZGdwdTogY29tcGxl
dGVseSByZXdvcmsgZXZpY3Rpb24gZmVuY2UgaGFuZGxpbmcNCj4NCj4gT24gMy8xNy8yNiAxMjoy
MSwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBSZWdhcmRzLA0K
PiA+ICAgICAgIFByaWtlDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4g
Pj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTcsIDIwMjYgNTo1NyBQTQ0KPiA+PiBUbzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgdHVyc3VsaW5AdXJzdWxpbi5uZXQ7DQo+ID4+
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE1vaGFuIE1h
cmltdXRodSwNCj4gPj4gWW9nZXNoIDxZb2dlc2guTW9oYW5tYXJpbXV0aHVAYW1kLmNvbT47IFNI
QU5NVUdBTSwgU1JJTklWQVNBTg0KPiA+PiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47
IEtoYXRyaSwgU3VuaWwNCj4gPFN1bmlsLktoYXRyaUBhbWQuY29tPjsNCj4gPj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNC8xMV0gZHJt
L2FtZGdwdTogY29tcGxldGVseSByZXdvcmsgZXZpY3Rpb24NCj4gPj4gZmVuY2UgaGFuZGxpbmcN
Cj4gPj4NCj4gPj4gT24gMy8xMy8yNiAwOToyOCwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+Pj4+
ICt2b2lkIGFtZGdwdV9ldmZfbWdyX2F0dGFjaF9mZW5jZShzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9u
X2ZlbmNlX21ncg0KPiA+PiAqZXZmX21nciwNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8pIHsNCj4gPj4+PiArICAgICBzdHJ1Y3QgZG1h
X2ZlbmNlICpldl9mZW5jZSA9IGFtZGdwdV9ldmZfbWdyX2dldF9mZW5jZShldmZfbWdyKTsNCj4g
Pj4+PiArICAgICBzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YgPSBiby0+dGJvLmJhc2UucmVzdjsNCj4g
Pj4+DQo+ID4+PiBCZWZvcmUgYWRkaW5nIHRoZSBhdHRhY2hlZCBmZW5jZSwgdGhlcmUgcmVxdWly
ZXMgYWxsb2NhdGluZyB0aGUNCj4gPj4+IHJlc2VydmF0aW9uIGZlbmNlDQo+ID4+IHNsb3QgZmly
c3QuDQo+ID4+DQo+ID4+IE5vLCB0aGUgY2FsbGVyIGRvZXMgdGhhdCB1c2luZyB0aGUgZHJtX2V4
ZWMuDQo+ID4+DQo+ID4+IEFkZGl0aW9uYWwgdG8gdGhhdCBpdCBpcyB3YXkgdG8gbGF0ZSB0byBk
byBhbnkgbWVtb3J5IGFsbG9jYXRpb24gaGVyZQ0KPiA+PiBzaW5jZSB0aGF0IGNvdWxkIGN5Y2xl
IGJhY2sgYW5kIHdhaXQgZm9yIHVzIHRvIGF0dGFjaCB0aGUgZXZpY3Rpb24gZmVuY2UuDQo+ID4+
DQo+ID4+IFNvIGJ5IHJlc2VydmluZyBhIHNsb3QgaGVyZSB5b3Ugd291bGQganVzdCBjcmVhdGUg
YSBwb3RlbnRpYWwgZGVhZGxvY2suDQo+ID4NCj4gPiBJcyBwb3NzaWJsZSBwYXNzIHRoZSB3cm9u
ZyBmZW5jZSBudW1iZXIgdGhyb3VnaCB0aGUNCj4gYW1kZ3B1X3ZtX2xvY2tfcGQoKS9kcm1fZXhl
Y19wcmVwYXJlX29iaigpPyBJIHNhdyB0aGUgZmVuY2UgbnVtYmVyIGFzc2VydA0KPiBlcnJvciBk
dXJpbmcgYXR0YWNoaW5nIHRoZSByZXNlcnZhdGlvbiBmZW5jZS4NCj4NCj4gWWVhaCB0aGF0IGlz
IHBlcmZlY3RseSBwb3NzaWJsZS4NCj4NCj4gRm9yIGtlcm5lbCBxdWV1ZXMgeW91IG5lZWQgdG8g
aGF2ZSBzb21ldGhpbmcgbGlrZSBudW1iZXJfb2ZfZ2FuZ19tZW1iZXJzICsgMQ0KPiAoZm9yIFRU
TSkgKyAxIChmb3IgcGFnZSB0YWJsZSB1cGRhdGVzKS4NCj4NCj4gRm9yIHVzZXIgcXVldWVzIHdl
IHByb2JhYmx5IG5lZWQgMSAoZm9yIFRUTSkgKyAxIChmb3IgcGFnZSB0YWJsZXMgdXBkYXRlcykg
KyAxIChmb3INCj4gdGhlIGV2aWN0aW9uIGZlbmNlKS4NCj4NCj4gTm90IHN1cmUgaWYgdGhlIGNh
bGN1bGF0aW9uIHdhcyByZWFsbHkgY29ycmVjdC4NCg0KV2UgbWF5IG5lZWQgdG8gcmVzZXJ2ZSBv
bmUgZXh0cmEgZmVuY2Ugc2xvdCBmb3IgYXR0YWNoaW5nIGV2aWN0aW9uIGZlbmNlIHRvIHRoZSBy
b290IEJPIGluIHRoZSBhbWRncHVfZ2VtX29iamVjdF9vcGVuKCkuDQoNCj4gUmVnYXJkcywNCj4g
Q2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IENocmlzdGlhbi4NCg0K
