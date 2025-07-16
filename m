Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8B6C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 08:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F3310E262;
	Wed, 16 Jul 2025 08:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0lNVyUhB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A9010E262
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 08:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXlWtRq257o1jWtxJ7binRlbdy2qXC23rk2i7LzjZfNcm0MQkpeShA4D5aqAfMCa/m2zsJRN7ey1PRaKidGnaNGsKsN4nFtVd7bYzmfrfOSiJmfPRSp8P94eFAiuJxFN3dTS0fQ0fHEJccn9sOiivXtsy2dHFK4HVuHUSGAxFrSG5S3SmWJ7d9WIEpjciinDTyQnTbPwEWk2eajPlK5vAp9Dge/zE0YCX5GLWwvvRnwLW2m4fJ24ppMCvxwfHnngQIjlTJfBXac04Yp/3AzVeg0CQnk0OnwQvhlvE1lhEuW4AXzZhZS+1WtcBVUJc9YycZxiY2BzWViTXj37GU7aiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNblJ2S1X97aew50ADNRcy1sG5x6ceAMn+tzokaSp3I=;
 b=aWkvQYBWNTF89A3ivwYF9Dcvj+u87DNc01rsfhjyuIAETThqT4malA8uzs52I64tkM+W5Lha9v/BgdX7B7QQlDAC/mPhmYOZuukMZC8tXUtrUwsDs4jwpdVu8KT2Kg/JIl+JznPqGy2bxspu89rK2KTqXXKgQPtCr4sWnrk7YK7O1xZg8TWYU5iKNCidpasOq5Wc2ZU7GqUbq/f0ZjuaXhOAhvYTtH+C/KgVjKXPzishYx32iiSEsnyw6QgDnnaI78ipFBmYTtR47GBHFWya01hoTNXlJ8szgcKTNq4GnGXjyOJLHvHhOB50i5cfPQdG9ft408Wr+Q0w5io3hBVYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNblJ2S1X97aew50ADNRcy1sG5x6ceAMn+tzokaSp3I=;
 b=0lNVyUhBWx8yc4eDytF3QyneaenuS6zOkqZdF3WPtyb1cMWlUYq/Q2QgCiN20kBaE2li9+jrPLWsT9IGPONPG+7Cj06UOmAvV1ogWTAC36N7d7QvkVX4aRImrMKOqOxoDs3f00QP28YmoJGK5Mulr/aVUeU80S4HtXpK6NYMd4w=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 08:40:48 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Wed, 16 Jul 2025
 08:40:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
Thread-Index: AQHb8q3/nm1gXMxGl0GXuYOfxGKnCrQ0K78AgABInqA=
Date: Wed, 16 Jul 2025 08:40:48 +0000
Message-ID: <DS7PR12MB60058FF28CFE6FB8326A24E3FB56A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711215122.23288-1-alexander.deucher@amd.com>
 <20250711215122.23288-2-alexander.deucher@amd.com>
 <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
In-Reply-To: <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-16T08:37:33.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6355:EE_
x-ms-office365-filtering-correlation-id: 06724b4d-b1c7-4222-068f-08ddc44476b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWduQ3VLMEJUR1dsTFNLWjNJd1V6dy9SaytJeHIvVjFzOUlnZUNCdDl4UjZk?=
 =?utf-8?B?Wmg4UXA4N2VFeTNmQ24vQnBNSnFybk1UNzZuM0llU2xCYW5iZzJINzRVcUhz?=
 =?utf-8?B?cFdDSnd0RXFRWHJ4dVpMZDZxZWZFN2xhNmNDeEZaZCs0OEZxSTBrYVhhOVg2?=
 =?utf-8?B?a0ZOV2NkWkFwQVFxdVBVTmdBQURNSUZtbzFXVjU4dkYvaEg0Nlk2REpKbzYw?=
 =?utf-8?B?ZlV5N3dsR2x3NXJjb0NYNkdCMVpOcVpuVHlkOVVPK0s3c1V0VW1PMnppQnpy?=
 =?utf-8?B?dWZtd1lrNjYzWmZMQTdKSjVnc2JGcU9YZGN1MnZYUEZPSGxtNm5LRXZiU3pa?=
 =?utf-8?B?akE0ZzdEd1ZxaVdpNk1md2lvSUdBRGJmZWR1QkpOQlFINHFvS1dkY2RwUG4v?=
 =?utf-8?B?NENjUlRaM0R0MEhOcGpUWjFEeEJhK0NrWVIvaTlVTENFUGp5OVBxMEFzOHlw?=
 =?utf-8?B?WDVDcmR2Tlpoa0d4VnI2T0dTYitNZFNpYUZ2bkR0T0JseWhJNjk4MUtaZ2JI?=
 =?utf-8?B?Y2pqUXpRbTQvRS8rYkZtR0pKNGErUGFYdXppZlpXcmNNZ3ZwaXlONU5VYUJK?=
 =?utf-8?B?NWxHbHZVWUxxNEN4aVhFUTRIVVNTTGN6YUVqU2ZvU3hwemROaGJQVFVCeExL?=
 =?utf-8?B?bzc5QTVabm1aZ1U2emlvNWxGRXh3MEZNWTU2QmlVdkw0ZWtTOHVXYUJ2T2tK?=
 =?utf-8?B?VFk5MXY0ZWZoOVhvaEZsc3V4dG5lZG5GWnpYNVI3S3dXYkRlTGZjTE9ES1Bo?=
 =?utf-8?B?d1ZQMTdDcFJsMlRWMmNaSmxaRHdHbWFBUnY2bXhOdm5IUHFDenZsOU1EeThl?=
 =?utf-8?B?MFBzREhJR0Q4aGM1WnVSbGR3NWZINzl0dSs4NlBtRjlFWFJFUW40Ujd3RHpw?=
 =?utf-8?B?ekF1TGRYUXFnQ2pKRGpyZGlJYzNrL0ZUcjFWamsxQmIwTGxLUFMwNHhYL1Zy?=
 =?utf-8?B?OHkwUENRS1U2QUhtMVd2bWMxQ0lwKy9rN0pSdTdFS0FuVXFGMWJ1ZlpBUVBN?=
 =?utf-8?B?OExBWWdxbEtsem1mVVV3L0ZkSFdXZmhuUmRmQTd5YVQ4eS94ZTJqQnBtUWxD?=
 =?utf-8?B?Wi9MS2diZEZUL2c2YkMvVDZKRkZqNFdGSmNNdkU4T0VwTHV3VHRZaDdmWUVV?=
 =?utf-8?B?VjUzTTYwdW42NUw4T1g2b0hPSlBUajdIb2dwWCtwb2lndTFvNC9JRVZwMk9E?=
 =?utf-8?B?WlI2ek56VWI2WC9NVFF5MG5nVFV0OUg4VGlyLzFkOVNJNGNqaGcvTlYxOFNM?=
 =?utf-8?B?cjBXWFhvdGdmR1d2WXJGbXROby9sUnRYamRSUENiT3ZsbVZrTU8vbkdQUlhV?=
 =?utf-8?B?WnVmUXRkNFRkaW5rSXo5WDQ2ang3SUIrb1dUeHVMR2l5ZkRDekhRRWJQemsr?=
 =?utf-8?B?Y2hJTE04aG5udllscGErNWtjYWMvQ25OWEVjbjFPQURnc2I0cTlVTnlZUEJ5?=
 =?utf-8?B?RG1QcFI1eTB6WVVlNE9CZ1VtVGNWdkFlajM4Sjk4cHI2V1I2TUVDVU1RMmxZ?=
 =?utf-8?B?S1ltWjZjVVJuOUwza09NYi9lQkZEQlI1eVoyeXFFbEt5Q2szVENBb1hrZFQy?=
 =?utf-8?B?OS9yYXRwcXEwUmVBY2h5QUZxdG1ZbUVab0p0ai9meVZveU5CejNVODB6OHRO?=
 =?utf-8?B?V0h6RGE3dncyM3lYRzVZQlFYZEhrTktCVDBhRTlMR0ZTc1l1c21FcWdzSjQ0?=
 =?utf-8?B?a2JMbVZjQXNSWGp5ODVXdzhzbkZMTDFMaHovRURKVEh5NFcwdzR4MFpsT3kr?=
 =?utf-8?B?bWhGeEV2dnphWVNmTSt0cFNYZFlmT3FvQld4aUJrTzVrYkdQZUQ1a2ZRRzcv?=
 =?utf-8?B?ZzRvMGQxN2VhVk9tR0N3K0VUZlU0YmhhdmJCd3pIR3NDOTNkbC8rMkVHbXFw?=
 =?utf-8?B?aUxqRkQzVTdIeHlvc01TUWg0VTBVdTN5S1pYeHpMV1N0aWJYWFJXRXFlMyti?=
 =?utf-8?B?T29OLzlYcjRHaFNaZ2Y0TE8xNW9LU2lrRzZzSzBrZ0p2SlFTVTNUMy9PSTBa?=
 =?utf-8?B?Qm9UeUpxQU9BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWlEUDkrQlI4RDdZektselJSYTZVZC95WjZ5RnhpakJMTFI0K1JrRXB5SndG?=
 =?utf-8?B?djRoVWsvM2U3SlBhOGJWOTI2eUZSUjdSL1NLSGpZV2krSmU1WnlFLzFMSkZG?=
 =?utf-8?B?QVNkQmlvMHhKM3UvSi9vV0xhZjl2eWtlVFV1MnVDNmpQbmlsMHVpMWxyREoz?=
 =?utf-8?B?VXAxcEhnVzlydGRvNFN1V1ZJelNuaHZrZSswSVE3dUJ5ZXZSSW05ZjY5ZlFJ?=
 =?utf-8?B?RzFVMlJJc0dOVEJFblpZSE4wUEhTUzEyV0VkalUvNms4QXk5ZC9NUkMwNlJv?=
 =?utf-8?B?Y0pvNHQ0VGErWFp2a0VYUVBwKytVL2dFb0Vta0hJbG9KVUtVRDJ0T3VzRjUy?=
 =?utf-8?B?b21IaWFCRXpQTGN1aHV6Z1dSVVdWbUNSaFdXY2dKOXltQTA0MVJ2d1pJdXhl?=
 =?utf-8?B?TWlGNW9GaDdhQmZFc2s5alh3M21NdjdheTdNelV3NGtHdVlhTEp6ZnFuZjdX?=
 =?utf-8?B?RE1kZlc0ZUpyNmlSZVYrM2lBRzJqTWZOTnB3QW5IbGVueVkxMGFIVWl1dEFX?=
 =?utf-8?B?b0FzdlZnNGNIVk1jUUl5aDJIWldUMUJISmRocE5UZDYwMFVhQ3dRWHArYnBo?=
 =?utf-8?B?M2d2SE83MS9qQ29ZcXJxeEU2Wkx0N2h6N1JZMjR4OVZ4K1ZlSit3ZXd1amZq?=
 =?utf-8?B?QnJKVWtrUUdhc3NWQTJxMm5XOUthYnI1c083ZGhrL0VDbUV0N2FxM1hTbkRy?=
 =?utf-8?B?MFJZWXJCemgrMEErcnBSWUNVMzNYZFRYRUcwaDF5aHZNT2t0VXlQODI4OUtW?=
 =?utf-8?B?SEZhWFRoTURCTnBkQzJFR1dJYjVrUzNyWHphbTcwaWNkaVY3d1p5ZGVhRmd2?=
 =?utf-8?B?Q0s3V0RaWlMyN2FQQXRqaHdWWjdQV1cvZW5makEvNDhvVWVoOE0xdzFKbkdL?=
 =?utf-8?B?TldEVzVuaEZmOW9heExBSXlRWWlUbGdaQ3NHZXhlNGJJZU9tRVN6dWZWWjVo?=
 =?utf-8?B?MzBoYUFsS3BMbVpFZmRmamZFdDdMNnZhQ2I4Uit2dm42b3dadU8rTy9xc29G?=
 =?utf-8?B?emthbmI4eXZzQXJ6ZHFLY1g3NzZWaUVlbktERXM0UmkvVkxsdlBNOEp2SGxy?=
 =?utf-8?B?eG1zc2ZWdmpQVFc3MGZEd3NmN0M5ZEswblhEWTZuVDBqT3h1SzdvYk1UaWtM?=
 =?utf-8?B?YXNob2lMcy9GaVNuNDRhaDFVdHRSVi9mVHpic1JrZGFqa2dUb25VTXdTeTNO?=
 =?utf-8?B?blpIdk0rYXFuWVkxdktNQWtFYVdXaU1raXdGSTA0V3FmL0U2eFZ0V0huMGN3?=
 =?utf-8?B?cU11M0N2YVdxL2R3emxnVEVXNnlNcllYSTVVK1VMbis4MDBVV1piSEhxemo1?=
 =?utf-8?B?dmJ6R2o2K01EUDlVTHJKbzE0RG5WZCtZUklma0k0a3hsWmxGTGtsQWhDb3ZT?=
 =?utf-8?B?c2hqV3ZmZ2lOYWtRaVN1WjhrWGpXWUl6QVlrd0lyZy9KSmZ6bVFHMGg0QUlN?=
 =?utf-8?B?OGhIWVNsYlVmY2FZNWRGc2k1TE5vd1ZVUytnUmtrdW94T0ZUMEV5bmZUOU5m?=
 =?utf-8?B?ckVlaEVPYVBvM1VoZ25sTGxobkxHYzdYZksyclI3N0g5UEJadkxOTXFYS01K?=
 =?utf-8?B?emxFN01HUVg2ZnZQaUNiaFpXQzVPdFpxNkI4Zm5saVltb0Y3ODQ0dmdhS1JW?=
 =?utf-8?B?MGJPZnV1TTNCK0R5OGtScXRxc2VGMjRkdFZ6R1Z3ci80TkJWeGpVYnVtRlA1?=
 =?utf-8?B?U2hQcll5MUYrRkdmbytGQUZwdFg3UXJaZzBwTitHSUd1dG54YVRZMXlLTzlJ?=
 =?utf-8?B?M3pzc0puM2VaSHE1eXBFL1QwWlBDdXRrcU9xUE5ST0tEbDNCb3dnbWJPVmRV?=
 =?utf-8?B?bVFKeDNaaEVvRFpjWWxpVEFCRzVxbDlkcitaOTlBTjFwanR1VWUvNUh0RWI1?=
 =?utf-8?B?ay82bVlnUTJhaWJQUFBzeXRWWDluZ2R0YzZCYi9saUVqS1lZdHdqRTh1Y21z?=
 =?utf-8?B?Q01kclphdHZzZkROSmpaNlZwS2N5d1RRc2xuc051bk5GMDE1dFRacWgwaUxO?=
 =?utf-8?B?ZStUNFZyYnl5aGxMRXNFclZUaEtCNFVpV2NTais0S0tQbVAwZDQ5VmZmdVls?=
 =?utf-8?B?a055MWJESWkrbUVyNUhMUDl6SzFhdzVEUFN3TlJwbmllY3RoQlNPNFNqU1dk?=
 =?utf-8?Q?7Bdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06724b4d-b1c7-4222-068f-08ddc44476b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 08:40:48.4922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIP+1DXestkj+/Vd4tpOcqKP1q59yrEANioAQpmq+ymXTcJJFA7iSsYtVzQB/YUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIExhemFyLCBMaWpvDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVs
eSAxNiwgMjAyNSAxMjoxOCBQTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvM10gZHJtL2FtZGdwdS9nZngxMTogc2V0IE1RRCBhcyBhcHByaW9wcmlh
dGUgZm9yIHF1ZXVlIHByaXYNCj4NCj4NCj4NCj4gT24gNy8xMi8yMDI1IDM6MjEgQU0sIEFsZXgg
RGV1Y2hlciB3cm90ZToNCj4gPiBTZXQgdGhlIE1RRCBhcyBhcHByb3ByaWF0ZSBmb3IgdGhlIHF1
ZXVlIHByaXYgc3RhdGUuDQo+ID4NCj4gPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCA4ICsrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gaW5kZXggMzdkY2VjMmQwNzg0MS4uYjli
YThiMjJhMTA3MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjExXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFf
MC5jDQo+ID4gQEAgLTQxMjQsNiArNDEyNCw4IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX2dmeF9t
cWRfaW5pdChzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LCB2b2lkICptLCAgI2VuZGlm
DQo+ID4gICAgIGlmIChwcm9wLT50bXpfcXVldWUpDQo+ID4gICAgICAgICAgICAgdG1wID0gUkVH
X1NFVF9GSUVMRCh0bXAsIENQX0dGWF9IUURfQ05UTCwgVE1aX01BVENILA0KPiAxKTsNCj4gPiAr
ICAgaWYgKCFwcm9wLT5wcml2X3F1ZXVlKQ0KPiA+ICsgICAgICAgICAgIHRtcCA9IFJFR19TRVRf
RklFTEQodG1wLCBDUF9HRlhfSFFEX0NOVEwsDQo+IFJCX05PTl9QUklWLCAxKTsNCj4gPiAgICAg
bXFkLT5jcF9nZnhfaHFkX2NudGwgPSB0bXA7DQo+ID4NCj4gPiAgICAgLyogc2V0IHVwIGNwX2Rv
b3JiZWxsX2NvbnRyb2wgKi8NCj4gPiBAQCAtNDI3Niw4ICs0Mjc4LDEwIEBAIHN0YXRpYyBpbnQg
Z2Z4X3YxMV8wX2NvbXB1dGVfbXFkX2luaXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHZvaWQgKm0sDQo+ID4gICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUFFfQ09O
VFJPTCwNCj4gVU5PUkRfRElTUEFUQ0gsIDEpOw0KPiA+ICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxE
KHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsDQo+IFRVTk5FTF9ESVNQQVRDSCwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBwcm9wLT5hbGxvd190dW5uZWxpbmcpOw0KPiA+IC0gICB0bXAgPSBS
RUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsIFBSSVZfU1RBVEUsIDEpOw0KPiA+
IC0gICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsIEtNRF9RVUVV
RSwgMSk7DQo+ID4gKyAgIGlmIChwcm9wLT5wcml2X3F1ZXVlKSB7DQo+ID4gKyAgICAgICAgICAg
dG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QUV9DT05UUk9MLA0KPiBQUklWX1NUQVRF
LCAxKTsNCj4gPiArICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BR
X0NPTlRST0wsDQo+IEtNRF9RVUVVRSwgMSk7DQo+ID4gKyAgIH0NCj4NCj4gQXMgcGVyIGFib3Zl
IGxvZ2ljLCBvbmx5IGtlcm5lbCBtb2RlIHF1ZXVlcyBhcmUgc3VwcG9zZWQgdG8gYmUgcHJpdmls
ZWdlZC4gSWYgc28sDQo+IHdvdWxkIHN1Z2dlc3QgcmVuYW1pbmcgdGhlIGZsYWcgdG8ga2VybmVs
X3ENCkFjY29yZGluZyB0byB0aGUgQ1AgZ3V5cywgdGhlIHByaXZpbGVnZWQgYml0IGNhbiBiZSBh
cHBsaWVkIGJvdGggdGhlIHVzZXIgcXVldWUgYW5kIGtlcm5lbCBxdWV1ZS4gU28sIHdlIG1heSBk
b24ndCBib3VuZCB0aGUgcHJpdmlsZWdlZCBxdWV1ZSB0byB0aGUga2VybmVsIHF1ZXVlLg0KTWVh
bndoaWxlLCB0aGUgS01EX1FVRVVFIGJpdCBtYXkgb25seSBzZXQgZm9yIHRoZSBrZXJuZWwgcXVl
dWUgb25seSBlbmFibGVkIGNhc2UuDQoNCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gICAgIGlm
IChwcm9wLT50bXpfcXVldWUpDQo+ID4gICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0
bXAsIENQX0hRRF9QUV9DT05UUk9MLCBUTVosIDEpOw0KPiA+ICAgICBtcWQtPmNwX2hxZF9wcV9j
b250cm9sID0gdG1wOw0KDQo=
