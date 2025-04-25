Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E85CC369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0369A10E8AC;
	Fri, 25 Apr 2025 07:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OhFucB5q";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D8E10E8AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDHCv3X0VPaqd5oMxd7/YCWiHWWz/PlTCwlwXEHs5xoBt+D/C6eZ1fxJ1N16ErwnponTX2sjZePDPbuTr+EWWvKtBRufz2bil2Mnc5FyOk45IWGCegnQn/kchuJ9aZNAdjaBTt58vo5qJVamGDfdKHCrhHZvjGaOdi07CkNY71ayjSmiTmJKZgp+scpZSl5gIz8MaV2+G/5oZZkwIF7IFJM1t3lgZOIy/Z929Xtt0NnyhrtQVi1PgBKuvGD9k3aN0bcDB5L6Tc6HVtvK3RN5yp+99l+aPiK1FoS5k7XgunvYO/EAeQtAIWA71KcaLU3Fl/uu0aExxKMigtLSRf4tJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cHj8KFQv/M5RfkVvjthRlmKmnh2dG2uRUzYi0ZucUU=;
 b=PAn+MxBGqOxiW/YTGen6h8bPgzlbV55ehhKwNnGPtAO2B2F6SVsa1r0WGHE6PGv3+mw6/7HVhyR0BGFcQNy5wmR+EuotXse2kpRMJY1BEpEqUqK4ONpYPGhPt+wyl/yVa9Axj6O5DwIWTyD/xNfYKf2r7qWHQNQOqZuWyF7/x/8E/1BB4MyuM7VxaISLvo0RDFRVvOIQqjSRPFrWR2Y/bx+Udx9qrJ8d9Dqiq2P5Hhu3+RprtpNuCGIqk0jaBFzrS9XJLEgrsd1zo2HNxmo24iR+EBK2pLAbDwLC0SFEi2X/1v0gxmFZ0CtuXNOMzM/kb+p8QV8YNC3BxV8Z836UHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cHj8KFQv/M5RfkVvjthRlmKmnh2dG2uRUzYi0ZucUU=;
 b=OhFucB5q1DQFofEqFTGXTeaZXFNum4lXTpTUdScvx1zkMnofa1Fw6SzgT5BKi6ZH4u03Fm2qimus9CRO3C6m2JzwZ5w6iF0TvnlwK5QM429zpBDdVo1z9KgDjikcWOmo6j6c8zftSfZkd0uX34w8oZ41fRB2h7HG7Zup8s+zp50=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 07:44:15 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:44:14 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Topic: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Thread-Index: AQHbtbC+ccKGxg3NBU6MKAwb+Y5nY7Oz+dSAgAAFcQA=
Date: Fri, 25 Apr 2025 07:44:14 +0000
Message-ID: <DS7PR12MB60058C12C12F37C34ADE31E5FB842@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <b7011f0d-cdda-9318-ddd7-6c36f6581ad9@amd.com>
In-Reply-To: <b7011f0d-cdda-9318-ddd7-6c36f6581ad9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d8f7ffc9-2498-4640-b2ca-bd8a7b92e982;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-25T07:40:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN0PR12MB5979:EE_
x-ms-office365-filtering-correlation-id: ab56c35b-c670-421e-4ad4-08dd83ccfa0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M2cvZDZZNDk3aUt1cTFDM3pPQ2NFeG1JN25lSFNiVU9ZVDdVMGN2eHozRHps?=
 =?utf-8?B?eHA2dGRJRHlIZTZlelpUaVNlMUNRcyt6NkxyS1lBMGNpUWtPeU5YV082a3dz?=
 =?utf-8?B?VlBqaTVieEJPc0hqMFZGYkkwOUdjZ1AwSldLL25MdU1lQ2NwT3E4ZDdrRFVB?=
 =?utf-8?B?U1RYT05LbTNBdnNGdzlxNWNuY3RXS1hhVS9IU3htdU1GOHNvNE5ac2VoVTNv?=
 =?utf-8?B?ZG95VjVCKzMzRDNaVW9lci84Q1JWVDFQQU5VS1RYbTNNZHd0Zno5OXhrdWpB?=
 =?utf-8?B?U0tUU09leWt6SHFSMjFaSzIvelNyUVVGeVE3NjVnVTVjdDh1WnNWU1ltbjlo?=
 =?utf-8?B?YWY0UzZJdVIyS0hkWStjaThDZ3FXZjRuTXplaGpaSGZ3WFRENXdGR3hZOGZi?=
 =?utf-8?B?S0toKy9RMkVOeTc0bFpReW5QdDlvTHV6aHJQeHJ4Vkx4L2VWZ0p4a3JpdzhD?=
 =?utf-8?B?YjlsL3RUbFgwMkMrSTc4S0lrQ1pDTXBRYTgwVG45V0RkMklld2JLSmt0eUVM?=
 =?utf-8?B?Wko5SUdZU0RYWmE3c3dDcDhWSnhDejNnMnI2c1BCZHUyRXNTaFFqeW9aNncy?=
 =?utf-8?B?dEdyTWpXZ1pWZmlzSnhOV1lxVHg2eFpOZi9pKzJudmdpU1N0V2NFT29tZnJj?=
 =?utf-8?B?NkNGV3JRNW94dVM0V0dyN0JLOFMydUhleGh1VUh4K0N4UjAwRUNpd1p3Ni9U?=
 =?utf-8?B?TlFvZUk1bEVvaVN6bDU1a0l5WXZ3eUl3d1ljdS8rZzllWVJydjRNTmpHRkh0?=
 =?utf-8?B?UWNUcGQ4STByOFhWZU4ydk1Sa1owa1poSlJnb2c4dGdvUGVKUjY2Tm5BOUFz?=
 =?utf-8?B?SXZrZ3FkMUhzT2Z6SXArMnVYVnJJdDlHekNVR0ovSXkrTlY3UG9HWlk3UHNQ?=
 =?utf-8?B?OEQ2NisxdUI5R1NSNnNTZ3dlSW5NcGh2K25qcmZXeU1nU3FOY0toakY4YzEy?=
 =?utf-8?B?Z0tGMVF3Y3l1dU11NURUMkpwYWQyTUx2QzBiN3M2UHdjMUxneHNzUW5OMVo2?=
 =?utf-8?B?azh1L3FjWGNZMEJTeExQazZXM3NpcXFVaStXcEtVNU01djdoUHNyV05HQjJL?=
 =?utf-8?B?SGtGdzR0NkQrNlA3Y1dodlozeVAzcUh6OG56UllVU0tnb0xCa0xKNkJ6NU9G?=
 =?utf-8?B?NHA3WDcxWFowODlISnlvMXl0TUJUUHdxYmx1dDM0WEwySmdzbWIvamxJNjlv?=
 =?utf-8?B?UVFZdzdlYURRdU9QTm9hMzlKVmxubVlRdzZweXVERDJUbHhqUzFYS3QrcG9m?=
 =?utf-8?B?QzFxcDFHa1U0K1Fjc1FYeDBmZlBHVEUvNittUXJ1NFhmc3RWVzI1VmpYUGhy?=
 =?utf-8?B?NkxpV3hJL3REUkRsRy90T1F0Y2JTVUwydzFPcHhPdGFlVUZEUGNTVk45ckRt?=
 =?utf-8?B?cFV3RlJJTnhNME4vVXBsZC96MVF4MGNrbUdVRFQ3TTJhdllYLzIxbWFQL05u?=
 =?utf-8?B?THBZN2Y0YzE5ZmxZVTNTZmx4MFFmU2VsUnErNldnU1haSFlJREI2QWN6b1l3?=
 =?utf-8?B?cTY2eWxvbE14TnVDSnc4ekg1NEx4S3g5dTI1RE5rT05ZYWV3TURXdGx1THMv?=
 =?utf-8?B?aWFNOWZ6R0p6eDZ5M09OWmtmUHRHTkpUTE43anNZc0pJQUMyZjBjV29nRUlZ?=
 =?utf-8?B?Wk5vMy9SZERIVTZidUtnUXBvSFkyOTAzU3I4a3NUODBGb2xFOHB6dHZZaUFR?=
 =?utf-8?B?eVlkVDNYQU1TUlFiZDVBc2dOMXZhaTQ2Q1VQaHlqZm1UNy91M2RwSW9xazZR?=
 =?utf-8?B?V1VOVzU2dUpoRHFIYmVRWTFxb1Q3SVFnNmJQL2NuODJ5aVFKMmFWdzBRNThi?=
 =?utf-8?B?akpzQy9yUm9obkNZbWNUUEQvbDRyNWtXa09wRnJldVp1MTZXUS9hRDViVXNq?=
 =?utf-8?B?blgzV3Y4S3BpS21ZUGJabVpwcUNVeVZFYzl1d2o0bHVmTnRESmJ0KzRUR1Br?=
 =?utf-8?B?OXRBYmd2NUZjQTA4clRqWFNyYlJPbFJpRzBXVUhJWFlNZktTdzgrNGltVDEy?=
 =?utf-8?Q?vbK8So4aEtE2JpvAAZyoCR+PCvmyBQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pLRWZWZmxmY3N5ak1RYVBhWkhWSHJTTm9DWTRZeXdBSjlsSjlZZG9EbnhP?=
 =?utf-8?B?U2dYS3RxMGxhWDlRcmtuQlV1M1BRUEMvV1VVY2QyaWRDaERhU2dMRUFUWjkw?=
 =?utf-8?B?L3pUMmxGSEozOVVGMmJXT1Q4ZVg3cHVtd0ZUSEtHS0N5b1hGL0ZBb0NxSnN0?=
 =?utf-8?B?V2ZsV3pZVllENDkyVlVVUkFvVmFFRzZUYXB5MzVkbjFLQ09WMHdadTV4MWth?=
 =?utf-8?B?ZzNXOGdlSi8xdndFbWFjMWREUGxnclhSTjF6OWQwdU0yRTYyOE9PMnZTNzB3?=
 =?utf-8?B?MUxmZUVZd3lKbEUrQzJld0ZXdllwS2hFbFpDQThxWE5UM1hXUk82aGRCU2l6?=
 =?utf-8?B?V29IWVZpOTdTRHNOQVk1Q0gwUUlnKzIvN0ZLRThYZGdMdzErTDJtVzJjenNy?=
 =?utf-8?B?SEZYVlJVVHpGQmRBNklScDd2bkVVVUtyNnJaYWJNSk9kRkhMYk9RZ2xvbTh0?=
 =?utf-8?B?WlZmS29Cc2xiejRubmtnL3NzSzFqaDI4N29WS2lHSWJXUFdEUkhkdmI0aFZT?=
 =?utf-8?B?MzFRMGY3TVpwZm9sdUFaT1VDNkNBb3cvUEFsWWsyNVg4VXJTT1R2elNrSFZ4?=
 =?utf-8?B?aFFLVnREUWRWdDhWTVVjKzRZczkycWpyaGNIZEVUdXdLVndhNklYMFBTMUNv?=
 =?utf-8?B?TU9lUG1oWFYxdW1RQXNaVlFVWjR6bTJxUXVyMFIzalRLMFgxOXNjekg0QVBt?=
 =?utf-8?B?elpWbzVBWGlndnMwSy9SOVFTY1VyZWJnM3FoRU9PSEpSRzN3WURSckZzbEdm?=
 =?utf-8?B?eW9MQ2JCWWtNZzNSS3ZObW81QzhuWjNMYVowdHFmN0hlWEtvSmt1SXdMTGUz?=
 =?utf-8?B?Vzgzb2djR3hZZ2d4a1R6cnBSU0EzMjk3SjJqKzFlaXRqaXlsRTRlNjN2Rko5?=
 =?utf-8?B?RkRaWUpCYXhsSTdWVW1OZXhiT2JjNDJGTmYzNzZjYTM1RHQ1YUdrQzNqRUlG?=
 =?utf-8?B?ZE9zWk8ydnRSUCsrZFBFMXZwejAvZXZKUWF6NVpUbkFvcU1oZ2VuVERwbU9x?=
 =?utf-8?B?SEwxSmt4RThlaUFaY1dDc2JhWGNvMFVEdVg4dTFoNjdndDY4SU5tL25oaUNr?=
 =?utf-8?B?bktSdXhGVlNIaHZ0UXp6ZHUxWkZFSlZwUTF6V25LU0Z3RVNzMkZYUnFzL09h?=
 =?utf-8?B?c1pBRVZuQmprY2srU0diYXQ3VEtnNC9FZjc4VXBkU1loTGxyaWoxMHUxL0pB?=
 =?utf-8?B?ZytSbHVwOUVsYXZjYTJoNkZFM0pWWlkyQXRveEJ5RmY3SFROdmRXVncxRjNw?=
 =?utf-8?B?V0E0Z2tZb2pOU1JTd2x2YWtkWFdXNDFEeGFJak1uWk1WK29GMGRCa1BFL0xs?=
 =?utf-8?B?MHFxTUdvQ1NuSTlvR0dCY21zUzRkTWd4dUtqa3pZamFWelF1dEw2cVgvdjN6?=
 =?utf-8?B?ZHAwSVAxaDcvakNDMy9tME5PSTRlYXQydVBsSTlrQUVvdjVYWjJqY0QzR1E5?=
 =?utf-8?B?Z09YY0xvdG8zZTBtUXkyUGp4TGhJRnFZeHNXdFl0YXNBUGI2NHBFVThvSXJ3?=
 =?utf-8?B?d2c0Vmo5YUlVMXEwT1BLd3c4UEpmbXU0RFR0bE0zMXYyWXNidDA5S2NpbTJh?=
 =?utf-8?B?REVjNG0wMzM1amExd09zMkgzODdhTlJXRERzdHIvRzhVWjVyZzdFTmdKQUhZ?=
 =?utf-8?B?RGozR2NRZ3ZRYWJEQkdMbkRkSkJPc3ZyTkJlNmlQZTNMSkc1TmhtWUM1K1Y4?=
 =?utf-8?B?TjF1YUluQUkzVURJN01TVk1IUGxyWUk2NzE3NEV1bDdDR2hDVmZqRnNEajBR?=
 =?utf-8?B?alo2TXBhclVIVDQyVzJSU0wxTVoveGxSZmVvay9kUmdqOEdGc0I5M0R1bGl3?=
 =?utf-8?B?OGtIZHZyUW8wekNydm15aVovbXgxYllFeVorVlU3TU04Skhwd0loNmlNT0Jj?=
 =?utf-8?B?SHVHSGJwTWFva0dibkFQZHRTKzcxT0U2cWhWZW55am1xN25rbUNJS0FZM2tx?=
 =?utf-8?B?RGYzeGhteEFhakJWbTJKRFp2M0IwMWRBbXFUQURFQjR2SWtHVC9sbVVwTFEw?=
 =?utf-8?B?M2cxSHg5ei9pKzAwN2JiczA4Z0xiaXNVNk02RFRhbGk2d2NOVWd3MURwVmVG?=
 =?utf-8?B?MDBKZWVGZVZBZlF3MTIzMno4MDVJQWo5c1dOUUVZRzJuazJGMW1vRmhpR3ZK?=
 =?utf-8?Q?tFFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab56c35b-c670-421e-4ad4-08dd83ccfa0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:44:14.7730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFk0e1rlK9XZDMs+MULa3AXLtGSLwrUFintNgg87peHKzLZkj9I4tvMkRhne5EFz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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

W1B1YmxpY10NCg0KPiBGcm9tOiBZYWRhdiwgQXJ2aW5kIDxBcnZpbmQuWWFkYXZAYW1kLmNvbT4N
Cj4gU2VudDogRnJpZGF5LCBBcHJpbCAyNSwgMjAyNSAzOjIxIFBNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGltcGxpY2l0bHkgc3luYyB0aGUgZGVwZW5kZW50
IHJlYWQgZmVuY2VzDQo+DQo+IFRoaXMgaXMgcHJvYmxlbSBmb3IgVExCIGZsdXNoLiBXZSBzaG91
bGQgbm90IGRvIHRoaXMgY2hhbmdlcy4gSGVyZSB3ZSBhcmUgdXRpbGl6aW5nDQo+IERNQV9SRVNW
X1VTQUdFX0JPT0tLRUVQIGR1ZSB0byB0aGUgVExCIGZsdXNoIGZlbmNlIGFzc29jaWF0ZWQgd2l0
aCB0aGUNCj4gcGFnZSB0YWJsZSAoUFQpLiBXZSBhcmUgZW5zdXJpbmcgdGhhdCBubyBwYWdlIGRp
cmVjdG9yeSAoUEQpIG9yIHBhZ2UgdGFibGUgKFBUKQ0KPiBzaG91bGQgYmUgZnJlZSBiZWZvcmUg
Zmx1c2ggYW5kIHR0bSBibyByZWxlYXNlIGFuZCBkZWxldGUgYm90aCBhcmUgYWxzbyB3YWl0aW5n
IGZvcg0KPiBCT09LS0VFUCBmZW5jZS4gUGxlYXNlIGRyb3AgdGhpcyBjaGFuZ2VzIGZvciBldmlj
dGlvbiBmZW5jZS4NClRoYW5rcyBmb3Igc2hhcmluZyB0aGUgYmFja2dyb3VuZC4gU28sIHdlIG1h
eSBuZWVkIHRvIHRlc3QgdGhlIGZlbmNlIHdoZXRoZXIgaXMgYW4gZXZpY3Rpb24gZmVuY2UgaW4g
YW1kZ3B1X3N5bmNfdGVzdF9mZW5jZSAoKSBiZWZvcmUgYWRkZWQgaXQgdG8gdGhlIFZNIHN5bmMu
DQoNClRoYW5rcywNClByaWtlDQo+IFJlZ2FyZHMsDQo+IH5hcnZpbmQNCj4NCj4gT24gNC8yNS8y
MDI1IDEyOjM3IFBNLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBUaGUgZHJpdmVyIGRvZXNuJ3Qg
d2FudCB0byBzeW5jIG9uIHRoZSBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCB1c2FnZQ0KPiA+IGZl
bmNlcywgc28gaGVyZSBvbmx5IHJldHVybiBhbmQgc3luYyB0aGUgZGVwZW5kZW50IHJlYWQgZmVu
Y2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
c3luYy5jIHwgNSArKy0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfc3luYy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfc3luYy5jDQo+ID4gaW5kZXggNTU3NmVkMGI1MDhmLi40ZTFkMzBlY2I2Y2MgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCj4gPiBAQCAt
MjQ5LDkgKzI0OSw4IEBAIGludCBhbWRncHVfc3luY19yZXN2KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiA+IHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywNCj4gPg0KPiA+ICAgICBpZiAo
cmVzdiA9PSBOVUxMKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0NCj4g
PiAtICAgLyogVE9ETzogVXNlIERNQV9SRVNWX1VTQUdFX1JFQUQgaGVyZSAqLw0KPiA+IC0gICBk
bWFfcmVzdl9mb3JfZWFjaF9mZW5jZSgmY3Vyc29yLCByZXN2LA0KPiBETUFfUkVTVl9VU0FHRV9C
T09LS0VFUCwgZikgew0KPiA+ICsgICAvKk9ubHkgcmV0dXJuIGFuZCBzeW5jIHRoZSBmZW5jZXMg
b2YgdXNhZ2UgPD0NCj4gRE1BX1JFU1ZfVVNBR0VfUkVBRC4qLw0KPiA+ICsgICBkbWFfcmVzdl9m
b3JfZWFjaF9mZW5jZSgmY3Vyc29yLCByZXN2LCBETUFfUkVTVl9VU0FHRV9SRUFELCBmKSB7DQo+
ID4gICAgICAgICAgICAgZG1hX2ZlbmNlX2NoYWluX2Zvcl9lYWNoKGYsIGYpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKnRtcCA9IGRtYV9mZW5jZV9jaGFpbl9j
b250YWluZWQoZik7DQo+ID4NCg==
