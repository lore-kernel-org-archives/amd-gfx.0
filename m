Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA4CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 09:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2EF10E6D8;
	Wed, 20 Aug 2025 09:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DVjuiK/g";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5811F10E6D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 09:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwfw/Lscvg/jaDOZt7Mt0+9I/0GddTRutW/bsRjVXT6iJaKVeR15aZ7BemFsw+nrzSHqcgEuEbkLdXTYDKO76EPnM1HtlK2nYv+1+lZ3YA6TRNwqEzqzi6A6I4GwuAKfNXtDWYmMq5IiPszmxNdFgyAVTY9qGqTqb3qno1TQl6WuWY1LvJyddfLD/gBeldFz82YYImgiWe6TzKMRopSt/EiUYmrLg4RwYoPbNm9JQQKvUz9xMmw1E65ytlqr59M5wKlXVoGGSJG4ORo3fg5Pw+aU6RtP6X/rDLYaxduXVg4rAnsw9/8AOmKbqLM9Uxp1NnMGf3UgRhJJjChtjJyNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8YYbuVbkspOCvgc3r/HxyJHsqAx4J3ZjeYPXb6wdKQ=;
 b=S0CaBGeL7mxTZaakDzUs36glf51OfumZl79ZbRAi34IYXzRNqkrN0HIbeldDx2AnrhSHrLKTBp5HmNW8HupBN5gd9osgenYY1VKaUKXu+mICy6B1qqft4xbYJcHzTPaRVz9lqgo9xfwnYv/vZHTwkrvVLu9A0riS9mUMserSGDtGBDPfaqXZ3Yzo1Lr+Zwb28j1OsU9jhGKPfb8AcJ8nXxDh+KeqmsEG5SZRw27OvF9BmC9j1gV86asW8kvN0jUB76oWJgWLsP35+LDjHGKV2mz/kp1oXp43xfFWRSzFYCcWzjjhKfY7O1vKz+nfUHbCtLdRmYFgl+yC8b2E4jKlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8YYbuVbkspOCvgc3r/HxyJHsqAx4J3ZjeYPXb6wdKQ=;
 b=DVjuiK/gGiZmDwF6etJiijtGe/OuVrHutE8nfNN9UzdYjMbsx4D34JRdK/e6qFjpHjNm8qFxoefDFT6kjrwiY5Snw7GZwVkMquqa/1C7BgeWppZNF30xe1KWJsmyx6kX3WjfizTH29ujCOD5QeIljo3LTHrcqpg6h5M990AM4tA=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 09:36:44 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 09:36:44 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
Thread-Topic: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
Thread-Index: AQHcEaSOfGOqVXxPOUe2eTGHxBHAabRrMWSAgAAVORA=
Date: Wed, 20 Aug 2025 09:36:44 +0000
Message-ID: <CY5PR12MB6369AF40DA64EB5477D24A49C133A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250820073100.3500205-1-yifan1.zhang@amd.com>
 <274e7416-371f-464d-8d66-f9d81414bd4f@amd.com>
In-Reply-To: <274e7416-371f-464d-8d66-f9d81414bd4f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T09:29:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CY5PR12MB6382:EE_
x-ms-office365-filtering-correlation-id: 78102acb-4ba3-40a0-68f5-08dddfcd1365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Y3haUzhGdFFZOVhsam9xWVphU3F3V2hpL0txb3c2NWczMnFaQ0VMZXZUNmNs?=
 =?utf-8?B?UzFTdTZ6aGp4SXQ0bUkwM0NVdjZ5d3R0aFg3bjdYWDJnOWhmanQzMzZlUzJO?=
 =?utf-8?B?T2ZpZDgyTHNVVk01VWVKdW9keTRUZDgvVFpCSm9xWElyRzYzRmF1aExtaDJp?=
 =?utf-8?B?MFJ6a1hObm9hT25uVnBQcDRqa1djN1NucE8wSGx0YXNFUDd2Z0VQZjMrejJW?=
 =?utf-8?B?bkpjUEtrUFkvY2dtd1UvdHcrakQxZW9TRTB5dDZsdEQ0M2FvNzNBemJqbEFW?=
 =?utf-8?B?OXRyUnRNNUUyM2o5ZW81NDdvY3dndWorNC9Tb2lIVi9Vd285TFpJTC9LYTJ1?=
 =?utf-8?B?c1g0MHF0dG1QN0l5Z00va1F5S1U1Ym4reGVHSEE1ZXI4SDRXSStORDMxS3ZH?=
 =?utf-8?B?eWNZSi9wSU5YTXZiUEd1cjA3dkNNdnRhQ0h4eUFuNnZvdXR6Q3Bac1lnZm02?=
 =?utf-8?B?RytObFIxbEt6RnRPcC85NnlQN1FFTmhXVkJpcFFwZnRqY2xIV1hQNGttZXpX?=
 =?utf-8?B?YURURmdEZC9FRDVWcEpkZUlWS0U2dU5wRUl2dW9GSnhPUDBsNjNPc2dWbFVm?=
 =?utf-8?B?TlJjdzZ6VE9TbEhrQWQrMFgrb0ZmV0tWdGJQK3hhemw1by9LZ3BsOWlHcWpI?=
 =?utf-8?B?cENhWHQ4ZGJlRVB2WTNmTUpOWGxvQ24vT2ZwZXprMUVTNHVzeVFQc3VpZkph?=
 =?utf-8?B?WThWa0xIYmtuR25uS3l5dW9xSEVHakk5YWFFSTJqYTBpSTdXUU1RZlBDTUo1?=
 =?utf-8?B?dW1qK0h4cEtFaGUzNXR3MVFMWmp0NU1nSVc3anBnNGpXVkV5OUpSWVh5MGxv?=
 =?utf-8?B?cUI2bGZQdE9IMVVVNG5adldEUCtJbWo4eTM2RUcrbkhzV1FPMnhKekxaWFdm?=
 =?utf-8?B?ZWNjelZad21pRFp5UVRIYmhobmFQV3dTMVBCVFpKRG9CanJBa3d2bzQ4bi9i?=
 =?utf-8?B?MllWaDdMd3RxTmNCZVl5Rmw5bjRmdDJuc3k2K2hqSmQ0dHQzeWFvNjl1c3ZD?=
 =?utf-8?B?bTVLWjljUlpCUlZpaUl6MUZkMlErWGhQYnVaWitpYVhseGFDNkhaWFYyYnIw?=
 =?utf-8?B?RE5OWDJMOUhEM0dPYmJyVFZQNjNaTi9pdkxCR2tsTlZjOE1LaTRvaDd0WUtP?=
 =?utf-8?B?MUxQQy9xWm55SFd6bU1YdGNXQ2pZTW5LTFMreEV1UHE5OHM5QTZqWW85U2xj?=
 =?utf-8?B?RVdXclpPSW04Q2IxazNsYXFvOHFHSzdDNkRjamFxYVRQNHlSYi9TOGZhK01n?=
 =?utf-8?B?N0swM21wbUwrY0t0VGVMUWRvRldZaWdkVE8yajlUSGU2U0gwaDBIRUNMbGl0?=
 =?utf-8?B?UE1Ba3pUanZIdE5saDNkOHdRcHpNbWZ3U1duVW54UU9EYlM4MjdGSTJMMFBF?=
 =?utf-8?B?UHV4WVBkd1JhUXNrQkxoUVhzaW1pc0dEKzl1eW5NcnJLRzVsaFVMVjNFaFRz?=
 =?utf-8?B?Z3RJTkMvZTNHM2d4ZW5MV3liampEMkxyYlA5OEVlRDdUbHJPMHB6cWx2QkpQ?=
 =?utf-8?B?Q2dTT3g2YTdqaTFhaElhQmozWnNTS1dwNGk5Vm0vN0NTdFZYdDZnREFCTXNH?=
 =?utf-8?B?YWxyOXJDbWVHMHNaNEdGamxpT1cxVkVva2d6R21DRjlEL0IyWDdDOFRycXF1?=
 =?utf-8?B?Qm85TndsZ2gyeUI3WWFlVlBzOGN2L01QbWxRZWZxYTZCaTVLNWlTQTZpbFl3?=
 =?utf-8?B?dVFmSmdTNFFwUmozYjdrU3c1aWhVYWJDdExuQ1VtTnIwMlc1ZUVndXRFSW9O?=
 =?utf-8?B?TzBzd0MwdjN3eXBVODBXblZVejEyR0tUQnNvTzdGN0dsZ21oRS9pM0tJaUhX?=
 =?utf-8?B?MkhaZjZzbXp1YitvNGVGTDc0bTgzTUlVNy9ZejRlTzlGTGNsWFhXamFwTzZW?=
 =?utf-8?B?WlphdFBjYnFjeHRlTWsvTGlSckJyRTUzdGNmNmlHVVpaRDg3VUpGNmphU3hj?=
 =?utf-8?B?ZENyTy9sdDBoVUI4RWlkMTcxNUpaakpGQ3lYN2xGQ2VrTk5CQ1dSZCtmcll5?=
 =?utf-8?Q?CwugWB/ed4a2r91PE68HbnZlPKGWGs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUtaa0NYUTBQYUdWNUV2SkE3SUt6RkNVcTRJLzdBQzA5WXhGeGY1NkhTK3dn?=
 =?utf-8?B?WDIzQmZ5cHIvZDZRQVl4Vy9CcU5Rb3Y4T25Zd25qQXpIdGM3aDV6bHFXcVhM?=
 =?utf-8?B?WlBwaG1NOHB6T1JBRFIyVlU2bFZFMFN4VVJWQi94L3VyQlZqR3NUOWs0TFI5?=
 =?utf-8?B?V3dNVmFCOElVSCs3b1crY0ZXU3Q5QlUySS90NHpoeDdHR3I2TUdrbER5b253?=
 =?utf-8?B?Z1pCTlQwek02a092aTEvSUQvU1g1TXRBZC9nVHExTmdabWVzNDFncG44elIv?=
 =?utf-8?B?UjlxejlHWWJTUTMrZVRMRnBiR1ZNNTVtRkQ2WXNuWDNvL2ZrOUZsenZxK2FV?=
 =?utf-8?B?dURlS0hhNXdFdFFtMDI3bUpwOFF1VnN4WXZYd05Lc1pUUXVWejJobmJQTjBk?=
 =?utf-8?B?VjVoZytFR1ducTJvRmd2RXdvblJUc1pGU3hTOGJZZ2ErTXh1UURlOFZKNUd1?=
 =?utf-8?B?UkpEMXZiZ2hWK1QvSXFPbVd2S3lOa1l0UWJ5OXlSSW5XRGhoaGxsT21ZS2s3?=
 =?utf-8?B?MEJ1c1ViaG9TcDIvMlZoalhXV3EreVdNTG0xOTU4MkdlMVJFdWNiNCtrN3FB?=
 =?utf-8?B?T2xkTnRBRURwQWtyTW1HeHhTNDZXQ0hRVDN6NWNKR2svMG02cW42YjNXL1JC?=
 =?utf-8?B?Mjg4d3NnMXUxK3oycUg0YjZXK2R2aExyMFJ2N1ZwL0ROL2JvUi9CRjNQSjhU?=
 =?utf-8?B?aER2OE83N2xva0I1Y01KdUpxQXZyQUtRKzFzcG43OTlpSkw3ckxsN051NE1G?=
 =?utf-8?B?YzZsWk5ra0Rrd1BoczZHcnpTU0IzeGZhbzBPOE1Ib092Rjh5VHBXOWN4aXZp?=
 =?utf-8?B?bGg5WGxmbGtMdHdkRkpLTUI0VWJjVnNyMHJGd2dVbUZDQVRFWkQwcTVkSXJG?=
 =?utf-8?B?Z1BDNGE3aGEzd2JIamtwRHlhdUMyVVFGelZLN01CTjhaV0ZmUytsaHA0dHlJ?=
 =?utf-8?B?eXdaVXg1dms4MjVWZGRUVFBQUExsVThWY3RZVWtyWlRDTDBoK2poeUJkdGl3?=
 =?utf-8?B?MWgyZmk4cXgwVkZqaFFnYkdEdEhTY1U2dGwzdWZ2YVFTL2NGZitzTjJ5aWRp?=
 =?utf-8?B?NTg4NDRGSVNPNWh4dFpyNnVVZ1RDZkExdXIwWmtzV0VxaUg3YW5reXRvc1hn?=
 =?utf-8?B?YjhNS3R6NUxhTVdUNDladWNBOHIxb2MvbEZWRjVqUS9RcHcvbWVaRzcydnA1?=
 =?utf-8?B?OFJxOWtHaG50WjE4U3BMeHpad21CSENlQjJqUTFqbVlVMWhZYkFqYkR6YlNi?=
 =?utf-8?B?bW96K2YrbUZNYjBFTStZdXpLL2w1alFRczVvVnUzUFRTdk1teDVqSG4xWTcv?=
 =?utf-8?B?STNJN0NJdTAzVUdHcml1RmFrTk9uaUtldzBPTkY3WHhkMnNObkw3Z0VHQXJ5?=
 =?utf-8?B?UlpSRmFIT1lJeUx5R2t3K21JOU1BbW4wVjhpczYvUkNTL2ZaenliczAzNGsw?=
 =?utf-8?B?S21uZzVVYnJ5QWt4aFlDQXlwRzM4WE9SanZaL3ozQ3FDMGEyQmxNdTNtQ241?=
 =?utf-8?B?REU3VDFEdy9EMXhGSElEb2tGdHNoQnBscVRzajZtNmNUZnB4M3VBL3RSdDFi?=
 =?utf-8?B?V1VvdXh2Um1HRjlhL1BiRU9Sc291TmJFbitmM0cwOHl3WnRFbUtHL0wrNUJy?=
 =?utf-8?B?R3ZaUFNaK3VyRWpmeTB6NjBIUTVKWGdwb2pQUHhGKzVBc0EvL05YS1NodXNM?=
 =?utf-8?B?ZWMvSm84SzRGVStzRFlXM1VPa3VyWmd2alRKZU55cHdqMnFzbnl4TzVPWS9S?=
 =?utf-8?B?VlhBcnpCRzZDN3VNdFl2dWk3ZnR6aGY0emJHRUo4MCtPdUNodEt1TFV1RTZP?=
 =?utf-8?B?b1djWGs1QTR3NGVvcG9KNVpyRDN2bHIyc3Z5bUdYemtxSy9HaHJUaVVDbmp6?=
 =?utf-8?B?NkkvOVVQS0JpU0E5SkkzcGdOOUxzZDJjWE9wVllTZ1B2bmZUL3YyQkorVHUr?=
 =?utf-8?B?N3hFQVcvcHpJWVc4LzN5MXRvNXNtMmlmd3BaUlREUGNQeGdFb2h2WmFEcHox?=
 =?utf-8?B?cmNqOUFKS01lY2xiaWh0NXcySU5qQzZ6dmR0eHhHZjZLRmdaSDNiU3luT25X?=
 =?utf-8?B?b2l3cDhJR2xscEdubURmcUxuNVdIN2ppVGVMUm1xbUVyNHI3cmxIcHE4amN0?=
 =?utf-8?Q?hDTo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78102acb-4ba3-40a0-68f5-08dddfcd1365
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 09:36:44.2588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgUSuHO++1jPhuTyp6FgQgs6L17mQluiO2NbAFS0FKBm/8XEMxWYsDehFAjHgAjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUkUNCiJUaGUgb25seSByZWFzb24gSSBjb3VsZCBjb21lIHVwIHdpdGggd2h5IHdlIHdvdWxk
IG5lZWQgaXQgaXMgdG8gaGF2ZSBlcnJvciBoYW5kbGluZyBpZiBub3QgZW5vdWdoIFZSQU0gaXMg
YXZhaWxhYmxlIGZvciB0aGUgVE1SLCBidXQgZmFsbGluZyBiYWNrIHRvIEdUVCBpcyB0aGVuIHBy
b2JhYmx5IHN0aWxsIGEgZ29vZCBpZGVhLiINCg0KVE1SIGFsbG9jYXRpb24gb25seSBoYXBwZW5z
IGluIHBzcF9od19pbml0LCBzdXBwb3NlIHRoZXJlIGlzIGVub3VnaCBWUkFNIGZvciBUTVIgYXQg
dGhhdCBtb21lbnQuIFJpZ2h0ID8NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFdl
ZG5lc2RheSwgQXVndXN0IDIwLCAyMDI1IDQ6MTQgUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFu
MS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiByZXBsYWNlIEFNREdQVV9IQVNfVlJBTSB3aXRoIGlzX2FwcF9h
cHUNCg0KT24gMjAuMDguMjUgMDk6MzEsIFlpZmFuIFpoYW5nIHdyb3RlOg0KPiBBTURHUFVfSEFT
X1ZSQU0gaXMgcmVkdW5kYW50IHdpdGggaXNfYXBwX2FwdSwgYXMgYm90aCByZWZlciB0byBBUFVz
DQo+IHdpdGggbm8gY2FydmUtb3V0LiBTaW5jZSBBTURHUFVfSEFTX1ZSQU0gb25seSBvY2N1cnMg
b25jZSwgcmVwbGFjZQ0KPiBBTURHUFVfSEFTX1ZSQU0gd2l0aCBpc19hcHBfYXB1Lg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgIHwgNiAtLS0tLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDYgKysrLS0tDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gaW5kZXggZGRkNDcyZTU2ZjY5Li4wMWY1
MzcwMDY5NGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IEBAIC05
NDYsMTIgKzk0Niw2IEBAIGVudW0gYW1kZ3B1X2VuZm9yY2VfaXNvbGF0aW9uX21vZGUgew0KPiAg
ICAgICBBTURHUFVfRU5GT1JDRV9JU09MQVRJT05fTk9fQ0xFQU5FUl9TSEFERVIgPSAzLCAgfTsN
Cj4NCj4gLQ0KPiAtLyoNCj4gLSAqIE5vbi16ZXJvICh0cnVlKSBpZiB0aGUgR1BVIGhhcyBWUkFN
LiBaZXJvIChmYWxzZSkgb3RoZXJ3aXNlLg0KPiAtICovDQo+IC0jZGVmaW5lIEFNREdQVV9IQVNf
VlJBTShfYWRldikgKChfYWRldiktPmdtYy5yZWFsX3ZyYW1fc2l6ZSkNCj4gLQ0KPiAgc3RydWN0
IGFtZGdwdV9kZXZpY2Ugew0KPiAgICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAg
ICpkZXY7DQo+ICAgICAgIHN0cnVjdCBwY2lfZGV2ICAgICAgICAgICAgICAgICAgKnBkZXY7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gaW5kZXggZmEzZTU1
NzAwYWQ2Li40MTI1ZTczYTA2NDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMNCj4gQEAgLTg4MCw5ICs4ODAsOSBAQCBzdGF0aWMgaW50IHBzcF90bXJfaW5p
dChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCj4gICAgICAgICAgICAgICBwcHRyID0gYW1kZ3B1
X3NyaW92X3ZmKHBzcC0+YWRldikgPyAmdG1yX2J1ZiA6IE5VTEw7DQo+ICAgICAgICAgICAgICAg
cmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwocHNwLT5hZGV2LCB0bXJfc2l6ZSwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQU1BfVE1SX0FMSUdOTUVO
VCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVf
SEFTX1ZSQU0ocHNwLT5hZGV2KSA/DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSA6DQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fR1RULA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBzcC0+YWRldi0+Z21jLmlz
X2FwcF9hcHUgPw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEFNREdQVV9HRU1fRE9NQUlOX0dUVCA6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwNCg0KTWhtIHRoZSBsb2dpYyBo
ZXJlIGlzIGFjdHVhbGx5IGNvbXBsZXRlbHkgdW5uZWNlc3NhcnkuIFlvdSBjYW4ganVzdCBzcGVj
aWZ5IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gfCBBTURHUFVfR0VNX0RPTUFJTl9HVFQgYW5kIGdl
dCBWUkFNIGlmIGF2YWlsYWJsZSBhbmQgR1RUIG90aGVyd2lzZS4NCg0KVGhlIG9ubHkgcmVhc29u
IEkgY291bGQgY29tZSB1cCB3aXRoIHdoeSB3ZSB3b3VsZCBuZWVkIGl0IGlzIHRvIGhhdmUgZXJy
b3IgaGFuZGxpbmcgaWYgbm90IGVub3VnaCBWUkFNIGlzIGF2YWlsYWJsZSBmb3IgdGhlIFRNUiwg
YnV0IGZhbGxpbmcgYmFjayB0byBHVFQgaXMgdGhlbiBwcm9iYWJseSBzdGlsbCBhIGdvb2QgaWRl
YS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnBzcC0+dG1yX2JvLCAmcHNwLT50bXJfbWNfYWRkciwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcHRyKTsNCj4gICAg
ICAgfQ0KDQo=
