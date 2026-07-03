Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8CDC43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 18:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A624610E651;
	Fri,  3 Jul 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QukbkTXF";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3F910E651
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 18:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzHZ8b/TXmhAOOJNR/JgGoWwRTtBVan9/VF3aXqrrhhMgq8bNPAhmsaE9DV92y/bz5mDyzwF+qubBpsO7PlsteZ6+9uJ31H3ywwDRSNhYtkUdHOHXG+GtuFi+84371m4SaX88ulCMf7ygPn7+yPp3kcH4AIL6QJp70ZL4TmB56ynI37ykIUe3VcoBg72w+6YEfEzSY0nA2AuFKpywW2lyfQ2gqhYJYUo1KvOdH+iIi5e7skopgBJxTfaD30N3MWc3GlT2ukv8JeT+Gr8YlspH0t2dwssHbinFx5WQnTdZUjn+DVdMw+eD00TI5Wtha8CET4rFizSXwkaP68AkXfm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSapHfJfWZfnlcPmXulVML+7Snsr0GUO1dPRSEeTw14=;
 b=LeBH3zk/DzRfj1m9zCHz0f/B4H+UKYWFhosBYsVvrgEqDEy3xEe3rd/MR5gA7jWcDfnsP4SJW9OrfdpHeO8OXiZKovFaebWtPWLyrxaLuRED4hhlTsY0/0IYeI0zMrYMRCMhhQoYNkAGun6WSNAiwNHKZSSPZi6bBgoCNgFOMLxDgUMSvulExmWyoD9ZNMoPUsK2gWPUNm+RhvVGfcHB4KU9/vvWsXXW0SL3SSZNd6bsm8CP+idFYv5dvknqVfhvuDiXr/5AG/juT1ZylrSw2pdSr1umnT4NkbV0EB9a5GakQF5y3fvWNMcq9uF+ZyP0BC0PRGn5En2zanZDu+suZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSapHfJfWZfnlcPmXulVML+7Snsr0GUO1dPRSEeTw14=;
 b=QukbkTXFlsugPYhJkjEhcsziA8bNfZFMYAgwoojXJV5rlZK7otvuwsrjt1mW7eT42IAvtnH1s1S5ncBHU/eS3OPLCDYD61o9zwMJIoXqGQDNdEvXynaMX7Lm/DBbpFBuJZl99vKYJWyQC+JvTw3gUn31Z6H9xRitLnpIWeNmgwE=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 18:11:59 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 18:11:59 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 "Shetaia, Amir" <Amir.Shetaia@amd.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Thread-Topic: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Thread-Index: AQHdCXUtrYxinPp64U66GHiN0PlGWLZaBssAgAIUbyA=
Date: Fri, 3 Jul 2026 18:11:59 +0000
Message-ID: <BL3PR12MB6425A9D4631A637C778F6BACEEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
 <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
In-Reply-To: <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T18:09:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ0PR12MB6806:EE_
x-ms-office365-filtering-correlation-id: daccc23e-3f27-45aa-27ba-08ded92e9327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|921020|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: Xst0MTMs9k25bIpI4MqGDMl3tsVt1o1rSw0sFfdZ52c4JSsDUvBkCAJ8yO4NbytOHjQVF28oHR838T/rt1yY3nNGaiOu9j8bfngNBbWkJVfJfRJ4EDE/UNkYEGE8insZA80dhrHacNrY1WvT9Jqg5t6N/ZrKUAEYC4lB93wNbGsU+tF/DxreFxkfjahNQtBIcXCdQ940pTw2xW1eiLlNjIg25ZwtHbxfoL6e/FNiR4csfMTSlOrYgK83atGczXTrD4kyed+PU/QSH9bF04ChszRnmpjhmH0pi4TQLHjDlZhB0DvRXGKPrB17qkEhiRZ50LAP9/7ALDye6Z1QIhgLYVa6eYI/FkQi3kHmQbfHLdZctDW71fCuFXIaG5hfbYMh2s/S81fpuPKt4Oe9xNnw25/he/pP2QkXEP+OAgjBdq8WgiktNENoHEbPsTzR2TcJknR15Mkgp1IMygP3kiUUPV9zEfEp9zAYJNWbh2jVXRkE5kudU2uGxwt48SicgjIJKwTg93GkHvqzP+0rmbD93zFnWzMiIykAsrvhbWlKS9ULGntO9wF0tfHoov9LRS3v6/GskxVuGrv7VVqLnsJNUniT5evO3SKt6BJIlJpAEPGNAQskhfhx7iY8Vjj0M5TedAU0S/TLrR6QMLwp0g2AqHR4qc06xDgjpj77CmQKfkMY6NtnORiaXDpYvkE3FbBoejdw9cy96iuUTIDAlc9A0YmvnUx2GLEEdZTAItxWVJIOklfJ49R7JBl/tj/fLdMe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(921020)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTluTjh6ZWpyOEUwamlIdzh4SXp5enUzVDBnYlZjb1JQUkZPbHNuYVpIa3g1?=
 =?utf-8?B?d3JhamhFUWRGQ2oxaGRJTzljNkFZQk9hQXN0U0hlZVM2N0ZOd20xKzJYZWVW?=
 =?utf-8?B?eGlGSGtoUkdxQ3NjMk1jV3gvTk9ad1lUQW5vNWJSUDN3VnRKSnNuNlViVG9x?=
 =?utf-8?B?WW5meWdPSHA5VGdMMlFCbUUxTXlsdHowUmVjcVJUV3d6MVk3dHczTi9zNnJj?=
 =?utf-8?B?NzNTc25ITlcxYjBPUWNiMUdaQVBxeEZqSnRLM2JBQTJoSi9Bb0dEbXZNOGNM?=
 =?utf-8?B?d0dIVkxmSXg0bTBqM0M2bjZvaUV3NmZOS3prdldGMDlYNjhzSGppU2h6YStz?=
 =?utf-8?B?b29Mblc3RmhVRzd0N09ERXA0QnNtQ0ZDMTZ2ZTNyYW52c3NQZ0RqazA5MTdt?=
 =?utf-8?B?ajRIWlY2T0JkTnRQdXJvQmRvSUtGWEQvWkRjdHBjSExocHNacWVIeWVkUEE1?=
 =?utf-8?B?YnlraW1OOSs5SSttSGVXUmF4NjZzOXJHMHV5N0ZtblJ6cXN0MUVhczRQb21W?=
 =?utf-8?B?NjVSMndNSWFSeng5dytLSENmY01RaGNwbE44OGZNNTI2MWl3QUxoOG1oMHNw?=
 =?utf-8?B?Y05nREFKUy9kT2x5K1NYRkI4OTdLUFM4dDVDeEN4SHdhZ2ZJZFovaFJxdDFa?=
 =?utf-8?B?WVAxTVFMZWlOWXpvQSsxRnJDbjdIdGhGbHB4YkRnWG1WeFdMREd3OGNxdFZD?=
 =?utf-8?B?TTNwSGZhZXYyZzArR250bGxRU3AwZ3FSOWt5RlJpSGlIcnZIVkZkQUFlSjJ1?=
 =?utf-8?B?bEtIVlpBdkVQaTJuOTNkYW9oMkJNVjlPZllVNkI3Q0IvdjZUd2xKL21RaFBO?=
 =?utf-8?B?SzN3QmQ5em1RU01id3MzcXE4ODBXZFBoSkhaNS9kaFZqeDF3cUU1L1BISFU3?=
 =?utf-8?B?YkJJWU9FR2l3ejk5cHdxL1BtWnB3Y3lHTkRNaWxpb1FoZWFaNWR2eWtVME4y?=
 =?utf-8?B?SFJUeXRDSHZXVi8zTVpuQnBtQjFZT0tZdEFjckhoVmJWRTJzMTZqb1pVYjBD?=
 =?utf-8?B?V3lwMldJQ2hpQ0JJcnA4VFhsWjBsVUoxSzJ6cy9haUI4M1g1ZU5OOXZQVnJV?=
 =?utf-8?B?Y2crdTQxQldWSko3MHgwdms5WGlYUWwrRGtkSEJ1WUlDaTN4aEZqdHl2cXNm?=
 =?utf-8?B?eXJyN1NoWWlOZ1BCTy9PN0FIL1BjOSt0cnA4dmJyMWtDb0hqS2YxNmhoaXQr?=
 =?utf-8?B?RDhxYXg3cStSS1Vvd09GalBlVE9mWC9oZTg1L284ek5VTkJzZHpDaENIMjVV?=
 =?utf-8?B?S3IxRkdLK09GSEdjUS9ZZ3JuL1RKWS9hTmZZNU10WDRKSmlDdWFYNWVvNWQy?=
 =?utf-8?B?K3hWbFFTcm42T1pXQ3JhVEZZejYzekxNeG5sMG00a1lUVjVoOEVYL3BhM2NJ?=
 =?utf-8?B?dXdWODVDZ0NobTlrZmV4RFpqdkY3Z1ZOdkdQWFppVWxiT0dkT3RyV3RoUEY2?=
 =?utf-8?B?ZTlsd0FUQ0FGdTlqaExVSWk2RGVXeEhQbTIwQWg5UlpjMzkvZmlKcUQ1bUNI?=
 =?utf-8?B?TTljeml6UjJwY0JnUitjcExMVEV6d3hYRWRHMVVmUGZ3ckdpc1NSZkU2clEx?=
 =?utf-8?B?LzIzSHhIdVAzV0svUFQrcHhqanVZalNpTFBqdzRPeXJucXpiNW1nZ21LSVFh?=
 =?utf-8?B?bGZSWVBjUEtrV3JaSWl5cHpoazFYT0x1bjBDVFVIOUU2QXl3ay9lVEdSK25q?=
 =?utf-8?B?VnlOZEZYY05CWENLT3pmOVVWR0w3bmtBWHRzODRBS0ROMzR1cUZqaVFVRGxF?=
 =?utf-8?B?dkRKNXdsMmM3dFU1NnEyN0xjdE1ua3Nua0d1M21PdUZhSE1rUEtsWXRlQk8x?=
 =?utf-8?B?M1R1YUVFc2dacFR6TU1mbTM1dXpOOWlualNMb1pMcWdVWWpMcmJCSzRwTWdt?=
 =?utf-8?B?SGtiRkNYRis3MDdUMmZVUlJjdXNENmpYclJuVWxHY2FCR2MvbVBoRTdJQ05u?=
 =?utf-8?B?dzRReEplUjEwaWdVVWxmNSt0TlVRT1NjTG85Q0lXTElpd2tWcGNZaU9RTGwz?=
 =?utf-8?B?Y1dPZWFuNkhMSDYwUTZIMFVwdmNsbzN1UjlwUm5KMHFkZ2pjaVp1Z3BrVXBj?=
 =?utf-8?B?Z0VYSGJqWjFJOGc5MytXR1dibk9GTk1ZWjVJLzBVRGVKTitNMHVyN2YvZ2Zo?=
 =?utf-8?B?NDVqVnowSEJxZHNuN0VyYXlRTisydzdHdlZraW9tRW83VVJrcHhWbUNhSEVZ?=
 =?utf-8?B?V0dzMHdQSWFDRU1CZW54NE5iWEg0ZVlUVmJlZ1kzMVVOSGRaOUpZR2VCdnZl?=
 =?utf-8?B?aXYzL1J2YzdLcE1xNXhueWhnVkgybHFQRDVwdEFLRGs5TTJza3poZE16cFp5?=
 =?utf-8?Q?X+VASUck0aXmxlcc+I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daccc23e-3f27-45aa-27ba-08ded92e9327
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 18:11:59.3205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ME91jvL50Mi3vDxhJ2Av+drieMoHVK4M3vghJrqPMoZAiTMiHe9D45Wnb0Q+KsPHfAbV1Apujv144DjE8pG8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgSnVseSAyLCAyMDI2IDY6MjQgQU0NCj4gVG86IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlz
dG9mQGdtYWlsLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBOYXRhbGllIFZvY2sNCj4g
PG5hdGFsaWUudm9ja0BnbXguZGU+OyBTaGV0YWlhLCBBbWlyIDxBbWlyLlNoZXRhaWFAYW1kLmNv
bT47IE1hcmVrIE9sxaHDoWsNCj4gPG1hcmFlb0BnbWFpbC5jb20+OyBMaW1vbmNpZWxsbywgTWFy
aW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+Ow0KPiBUdnJ0a28gVXJzdWxpbiA8dHVyc3Vs
aW5AdXJzdWxpbi5uZXQ+OyBLdWVobGluZywgRmVsaXgNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgSGUsIFNpd2VpDQo+IDxTaXdl
aS5IZUBhbWQuY29tPjsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsgSm9zaGks
IE11a3VsDQo+IDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEx
LzE0XSBkcm0vYW1kZ3B1L2loNi4wOiBVc2UgTU1JTyBBQ0sgZm9yIHJldHJ5IENBTSBvbg0KPiBJ
SCA2LjANCj4NCj4gT24gNy8xLzI2IDE4OjE3LCBUaW11ciBLcmlzdMOzZiB3cm90ZToNCj4gPiBU
aGUgZG9vcmJlbGwgaXMgbm90IHdvcmtpbmcgb24gTmF2aSAzMS4NCj4gPiBVc2UgdGhlIElIX1JF
VFJZX0NBTV9BQ0sgcmVnaXN0ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW11ciBLcmlz
dMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+DQo+IEFja2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+DQo+IEkgc3RpbGwgaGF2ZW4ndCBm
b3VuZCBhbnkgZXhwbGFuYXRpb24gd2h5IHdlIHVzZSBhIGRvb3JiZWxsIGZvciB0aGUgQ0FNIGlu
IHRoZSBmaXJzdA0KPiBwbGFjZT8gTGlqbywgQWxleCwgRmVsaXggZG9lcyBhbnlib2R5IGtub3cg
dGhhdD8NCj4NCg0KSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIHdlIHdlcmVuJ3Qgc3VyZSBpZiB0
aGUgSUhfUkVUUllfQ0FNX0FDSyByZWdpc3RlciB3b3VsZCBiZSBhdmFpbGFibGUgdW5kZXINCnZp
cnR1YWxpemF0aW9uLiBBbmQgd2Ugd2VyZSBzdXJlIGRvb3JiZWxscyB3b3VsZCB3b3JrIGZvciBi
b3RoIGJhcmUtbWV0YWwgYW5kIHZpcnR1YWxpemF0aW9uLg0KDQpSZWdhcmRzLA0KTXVrdWwNCg0K
PiBUaGFua3MsDQo+IENocmlzdGlhbi4NCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaWhfdjZfMC5jIHwgOCArKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9paF92Nl8wLmMNCj4gPiBpbmRleCA2NWU1ZDIxNzUzZjkuLmE5N2M4NWIwY2I5
OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9paF92Nl8wLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9paF92Nl8wLmMNCj4gPiBAQCAt
MzA3LDYgKzMwNywxMSBAQCBzdGF0aWMgaW50IGloX3Y2XzBfZW5hYmxlX3Jpbmcoc3RydWN0IGFt
ZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+ID4gICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4g
PiArc3RhdGljIHZvaWQgaWhfdjZfMF9yZXRyeV9jYW1fYWNrKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCB1MzINCj4gPiArY2FtX2luZGV4KSB7DQo+ID4gKyAgIFdSRUczMl9TT0MxNShPU1NT
WVMsIDAsIHJlZ0lIX1JFVFJZX0NBTV9BQ0ssIGNhbV9pbmRleCk7IH0NCj4gPiArDQo+ID4gIC8q
Kg0KPiA+ICAgKiBpaF92Nl8wX2lycV9pbml0IC0gaW5pdCBhbmQgZW5hYmxlIHRoZSBpbnRlcnJ1
cHQgcmluZw0KPiA+ICAgKg0KPiA+IEBAIC04MDcsNyArODEyLDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBhbWRncHVfaWhfZnVuY3MgaWhfdjZfMF9mdW5jcyA9IHsNCj4gPiAgICAgLmdldF93cHRy
ID0gaWhfdjZfMF9nZXRfd3B0ciwNCj4gPiAgICAgLmRlY29kZV9pdiA9IGFtZGdwdV9paF9kZWNv
ZGVfaXZfaGVscGVyLA0KPiA+ICAgICAuZGVjb2RlX2l2X3RzID0gYW1kZ3B1X2loX2RlY29kZV9p
dl90c19oZWxwZXIsDQo+ID4gLSAgIC5zZXRfcnB0ciA9IGloX3Y2XzBfc2V0X3JwdHINCj4gPiAr
ICAgLnNldF9ycHRyID0gaWhfdjZfMF9zZXRfcnB0ciwNCj4gPiArICAgLnJldHJ5X2NhbV9hY2sg
PSBpaF92Nl8wX3JldHJ5X2NhbV9hY2ssDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQg
aWhfdjZfMF9zZXRfaW50ZXJydXB0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
DQo=
