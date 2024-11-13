Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DCCD41C00
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D6810E1F9;
	Wed, 13 Nov 2024 05:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X1eikJHc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F2E10E1F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6hdG7goxz18iEAwq/+jsv8rzUoIjSP9zenJM5K2WcNGAhJRP05JhmBQvR5DKaItXtCcv4/WjVouwFNO3ieZDsPROKAIXLe18dK3TOdax1DGazxkfQRkjmbNQyuAx06mvLdZvSiJvW05dG4bIDr4uD9r0tmWQB17kGLNITW/NsJYQIx8J8B/qv6ilcCtVslNRoBsIrp2EoT/UblFWbyuBTHAX6+weZweu7R7sLMBxLKxi9Ud04fhEeX7LJwDR5c952GwfPMNHXbGOBSZFvMu4fC0kb93awBD8HcIOh2Euw/6ELshMmLy3vgwaRHBomGKe8gCoUNV5ZKFgYogkUpDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjJDxoDis6LTghFBhgk3c3sF9Ktwj71POE5/Vg6EMyk=;
 b=YkOYeKX2MzL+gWjuut/j4zG1iFCPEdKZ/CBWslPh3eJ1RnAMyCGkMXBR12+oX1QCrJy/R2Oih+IBJHj++KNaI2ZvFBvtj/UfARqQDQToIAhDO5Kf6nYxePtALch71wbzgVus/v8bjF67iqMpeYhMsgsCN0dXRl/fqJYzWV8fsrfG+csXTZSBYWQtlDxNEft/NKw3UlFDeVMBAUAf1cjzmvK5TnDTy4PcRof86mPFBXoUxylr662uQ2oAxSFVWtDrtjLTIE156tfC/z1k7cW9B0QzkA/m6RSJXuomOwNmBEAf2qGYzrKWVrGAW4iL5dzTeXugK59Z3uSGEFmggFtRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjJDxoDis6LTghFBhgk3c3sF9Ktwj71POE5/Vg6EMyk=;
 b=X1eikJHcoJ60eJJkgBPu6wVjYAYXne9ojBNi+DqCGUuIgZAKr4lMxXJBwnDI1pu7Rvn5cxd03J+hAfy2YiJ03ij3QlXQXgZlVfveAE/PMfHkEd+0ByoZNItQsPIakrE6cMdFVAwKS1T8MZ/BRhSsDidlJTUOkvDw2H84theZZjg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 05:22:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:22:22 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
Thread-Index: AQHbNQ99LrE8j9qFyUWjXx01qON3ZLKzu1iAgADAVECAAA1UAIAAGwAAgAAEiICAAAUbgA==
Date: Wed, 13 Nov 2024 05:22:22 +0000
Message-ID: <DM4PR12MB515228EDB21BA5DDBBB62F89E35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
 <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
 <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
In-Reply-To: <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6a9eddfb-c59c-437f-a45d-7f915296b20a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T05:21:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB7365:EE_
x-ms-office365-filtering-correlation-id: ef9d37ec-b27f-4806-976d-08dd03a32717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ajRUaGNzUWg4RHgzRGNnL3oxVlkyMFVhMlJiY2ZLRVhNdGQvVWwwWmg1cElV?=
 =?utf-8?B?ODgyblQvV1dsaW5tdVBDaytpRGdSYWtha2IvT3YxOHNMT3gwZ09PS3laazRX?=
 =?utf-8?B?UUhsY3o3RzVBbXM0T28rallMd1ZaTzh2RmsrQURzZUloM0ZwQk5SZjlDM0c1?=
 =?utf-8?B?cSt3VmNwUVl3UjlJUDFTdXBiUmRYeFB4U3U2Tmg4Z2I3UExWRHdlZXVlSjVn?=
 =?utf-8?B?SjlhRmxXblNQV09NZnNVZkgyZlJPbEtBTFA1WGpHVU9FdnB2T1dxQ3B0ZTQ2?=
 =?utf-8?B?bDVUUTNQRlIrQmxJaHNHSnFGWUlVS3VWN3JjQ0k3VHdVSDc1ZjlYMFdnVmdU?=
 =?utf-8?B?Ykpzd1J0R3FoR2hVT1grZXlaeTJwSXAwbmVvdVdSZkwvd1lQK1JBSml1TUY2?=
 =?utf-8?B?NGdKNG1McG00bzIra2g2bTVBeS9namcxY3V6aUt4SG1PbEU2S2Nhd2p1cXNz?=
 =?utf-8?B?OTBDbVJzZ3pwSVk3SnJMK1kzQ25KSW0rYzNJajMyeU0wNXFHRURrUnN6cGpx?=
 =?utf-8?B?V2s4S2U1RFlLbDQxTVUyK3I3djkzZE9zTzVKQXBCRmpGWHRQbkp3RFRuYlZt?=
 =?utf-8?B?WlVGZ3pleSs2RGorU2M2VnFSazZSZE84UUlXWmZ6YjEzTG13RUkyNjBXWUJO?=
 =?utf-8?B?dGtvZ2FLdVlwMmJJdjRrdTJ6YllSRExuNkV5dzdoSnJoM0JjaVhFVTJWZXZs?=
 =?utf-8?B?dlE4NkVMcUpiR21XRldvbk1VZjQrVzA2Q3B2OUhFaU5GT01HNUdPTVlXN0Fy?=
 =?utf-8?B?LzloYzNMT2pnZU0yZ1F1eTREbjd4RUh6aWhwOFcrc290TVVCT05IYWxkMTA0?=
 =?utf-8?B?V2J1NlZOVExQb3c4SmpybzBaNklEU2xkdmJia1pqWlg1RG4zTjlaa0hHTW1Z?=
 =?utf-8?B?eW9DWXRrME1qWDJOaGFNUS8walp6ZFMrWUxiNXJUdlFJYm9CN2hPTXloSnl3?=
 =?utf-8?B?bXZYMmFuTXV6UHRSTVV0a0Rqejdrc2l5b21MdlY2akF3RDFyTnNaN3VDNjZ0?=
 =?utf-8?B?RGZFSGdFNHZyVkFuelRMNjZUSyt5YnFuNVRDRGZiVk4vNnhUdFRnV0gwQnZ5?=
 =?utf-8?B?ZTRSejluY0p1eE5kMXNOcGFDZS9IblNUUFJOZ2FNd1dZM1BiNjBlT0I5RU1u?=
 =?utf-8?B?RmtnV1pQZUQ0TEVreFBzSnY3dVVvMHdER3ZzWDYvVUFzbG1zNEp2S2hyMG94?=
 =?utf-8?B?cTE0NlBtQmlKSThxWGE5MVpPNmk2OVdzd3VRQURiT09UQWtaeXRsTHRvazZI?=
 =?utf-8?B?bGFTcGZCYnd0REdxWHgyaVp3QTQvS00yd0IxUEVmUmtQY29qNGZ4KzhReFJp?=
 =?utf-8?B?REVITnNnVW4xYmQ5ejM5TzY1K2c2eEZNQVRsNXdmZkFNOXp0Y1VZUkhRbE5v?=
 =?utf-8?B?ZGJ4NXZlVXNsMFFIdGZGZnRMTHBaT3BGUGo3N1grWjEwZzNhRHpjQ2ovZjln?=
 =?utf-8?B?cjJvMWFwR0t5bTZpN0poTkJZbEQ3cG15c0h3em1wOCt5b2FDNHZBVzltNVkx?=
 =?utf-8?B?T0VWNXd6S3FBMUZMUFZFNUwxZXNTN3MrWmFTRFZRVTRXRFRUR2NsOVpCUW10?=
 =?utf-8?B?eWdXYXc3Tkw1bnhCSDB3dUNkcTFWbk1nU0lxcUYxLy93TFhNS2diQndFMmRk?=
 =?utf-8?B?aXJvNFZycW1pSXhQV1lydXhJcEhocTNpQmpCNjNLQ0VBeEFhT3FMeTVBRDFh?=
 =?utf-8?B?L1QzcW9aWGw3MEd1UjdhdEFvckQ1WWhYVHo5T2IxVjh2ME1yMGhxdXdISjV5?=
 =?utf-8?B?SkFKYVIwTVp6M2F1eW1raTIyaWhkallOL1FKUkFobmlreUtXT3JiLzR1UWJh?=
 =?utf-8?Q?PD24i/0JrH2XhGKS0+A10PAE8dVUU1889T0aw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU9SV1l1L2ZBdjdvc2lJazY2K296YXR2alpUbUhHQkxPQU1MSHJYTTl4bkk3?=
 =?utf-8?B?ZjVYbXJjQUtWWi9SbnNWMDJieG1HOGNkLzU3UlR5MnZhTGxtRmpaRVhaRnZ5?=
 =?utf-8?B?aU01WHd2RGhTMW1FRDdFeUtaL3h4aTNHS0NXVlNpd2poT3UvN3NNbXR5cTBO?=
 =?utf-8?B?dFRnaVVwOHRISnozV29DcE5NUjlmK3BOSVJOYlBRYTVNSElQYXlOcVc5a0sw?=
 =?utf-8?B?ZzkzaE5WcW5HbytISjNGYXFUUW1BL3huQmx1NW14U2RCdzNheVN4aUk2am94?=
 =?utf-8?B?eDQvaDFuRVQ2VWdoSUZtOG44YWNWRnE4aWVJaXA5Y3RYMHJCZGtTdFk4Mmdw?=
 =?utf-8?B?SHFYVzUzT0x1OHRtb0N3bzQ4UzRYTE1TM1FsVjhWM0wxaG10SDhzMTRmSWtW?=
 =?utf-8?B?RXFXaWtiUU5kbnFEakFybWtGT2FwNVpFT1l1eFExYTJtT2JlbDRvR0kxTk1P?=
 =?utf-8?B?VHRlWmFmeGcydTM3NllSMFFDNlNCVDBKTXJpUXlUbzdiN2xjSGRQN1NKakJX?=
 =?utf-8?B?V01Oek11RHNHV2VjK29vMFNZRmhoWTlBQi95ekROZHdjLzVGMm1jODRlWm1l?=
 =?utf-8?B?VWFFazYzUlJjQlYwTU5PS0ZHMnoxeFZ2blFIUHI2SGdxVnVKTEx2MWc1RkNa?=
 =?utf-8?B?aXVVY1RyY0NLRnpCRExuL2VocW9EVEZpemdTTHhieXpiK1M3VXgyKy82YnNr?=
 =?utf-8?B?VE04dGlOWHRSNzA4L2lUbHY0RzJ3bU9GOGVCd3huYTBmU1Ywa29SM2NFWDU5?=
 =?utf-8?B?WFIwQ011NkpUSXVlbnpERzY3ZlNuK2FrTjJOS2FqMG1KeVUxQlgvbk01NDho?=
 =?utf-8?B?RlZ2eEVkUlVhWUxuY2xZS2ZwV0p3MGJPTTUxSEZXRURsUHNzSjBPSkhYZWxG?=
 =?utf-8?B?TlMwSEFQcXlOMUlKUEhUQXU2WHJBTlZqYWU5SzhxRjNEaHVVWWYxZno4M1d0?=
 =?utf-8?B?dnQxSm9xRnNZbngybGpicUU0NFlyb2piMFhtU2cwSytENXNIcm05Y1ZRWmwv?=
 =?utf-8?B?cnBYMC9oMlpTSUtxR0FkeU10MzZ1am1HZ08ySkJ5SWQ5NGVaSkRHalpBRjVs?=
 =?utf-8?B?TDI5US9UMEhtdWJ1SG5DWnVmUnFDYjJUaWJmdUNtT2EzbnkyL04xVWViOHQ3?=
 =?utf-8?B?cDNXUkwvZzFuNHJSRXRpN0NZTUVhb1N1NE5RaVdORHd4VlE3cTJrSkNySHZP?=
 =?utf-8?B?NUU3RUw1L3RUYkhmK0hjWDdJRDE1VkFBem1YYlhXT2FYVytwbW1rUWwxb0h6?=
 =?utf-8?B?aGQrZndlK2tEcUZCOExGTVcydVRjcGtpTXdYNlpSVHFkRWViUHNqY0crMDBJ?=
 =?utf-8?B?aURnS3YxUzRjeWExS2tjS1pjNVFPeGZDMU5aT1BEbnFaUjRPN00xd0JnelNl?=
 =?utf-8?B?Rnd0b24rcTM4OFVFakFXeDFJNE8ydUYzb045aDhtRXgyU0N6bkM0dklOR2xj?=
 =?utf-8?B?aG82N2NiNm9OVHBuclV5eUpYK3o4dWx0UmlZNGtjVitUL0VaQjZLT0V1ZHV3?=
 =?utf-8?B?czVKVm0zTDJxVUY1dEpaRWJDWjU4TFBBTjN3Rmg2QTlSSElLYjZ2NWRKdXZW?=
 =?utf-8?B?ZXBNaVNQd2pKYTh2cWNobHl4V21STnZQeDJxcDhvSkllZHp6ci9DdU9FVE1z?=
 =?utf-8?B?cUxYYi9VUjl0ek5EeC9ma29tT0VRMnltcjBPY2x0Q2t0T1M3bVJpcElxNVlF?=
 =?utf-8?B?NHgycGVsZnBHcy9Gc1NVZ0Q1T1ZDN1lySnhQcDY1aE9PR3hRZEVDczIyZ0tU?=
 =?utf-8?B?VUdEMDdCdUJoa1MrdFdjSWFLeDlsUFpMTlVQT1c5Q2RLWFdndEZLSzlFZkpI?=
 =?utf-8?B?N1I0TUJjTkhTYU9lQll6UlZjTUxibmJFekdCU2xoVURvbStBYlVnaFZFeUMw?=
 =?utf-8?B?SjBjNklLQ25aKzE5N2U1VEltY1Z2dWpSbHVHdVVZbjRqS2hTNlk1MXhDNkhr?=
 =?utf-8?B?MXJVZldvOURNY1NyZDVUQTRkQXNhZXlKa3JKT1dXMnlZZnl3aEFFT294ekdC?=
 =?utf-8?B?a1lkQWNwckU4cDY2c3BnVXdSeUw4VDQreXBSVFRPdFBlZHBpYnY2cjN4OGUy?=
 =?utf-8?B?eU1iMXVRMFNNRUU5UzJzQW50VlpBYkFBV0tSYVlibFVkN2ZPRURYcjloelZk?=
 =?utf-8?Q?03BE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9d37ec-b27f-4806-976d-08dd03a32717
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 05:22:22.6307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGP2Mth7939adIaXXdfVhHn5GGcyTVv7wBPB4DB68bm6d7tz5vaa/iIghLVRUvjS4N93zgXd/NJVsSAl3daR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
Cg0KSEkgQWxleCwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAy
MDI0IDE6MDMgUE0NClRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCkNj
OiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUHJv
c3lhaywgVml0YWx5IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPjsgSHVhbmcsIFRpbSA8VGltLkh1
YW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogZml4IHZj
biBzdyBpbml0IGZhaWxlZA0KDQoNCg0KT24gMTEvMTMvMjAyNCAxMDoxNiBBTSwgQWxleCBEZXVj
aGVyIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAxMiwgMjAyNCBhdCAxMDoyNOKAr1BNIExhemFyLCBM
aWpvIDxsaWpvLmxhemFyQGFtZC5jb20+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gT24gMTEvMTMv
MjAyNCA3OjU4IEFNLCBaaGFuZywgSmVzc2UoSmllKSB3cm90ZToNCj4+PiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPj4+DQo+Pj4gSGks
IExpam8sDQo+Pj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IExh
emFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+Pj4gU2VudDogVHVlc2RheSwgTm92ZW1i
ZXIgMTIsIDIwMjQgMTA6NTQgUE0NCj4+PiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpo
YW5nQGFtZC5jb20+Ow0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywN
Cj4+PiBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFByb3N5YWssIFZpdGFs
eQ0KPj4+IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPjsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFt
ZC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGZpeCB2Y24g
c3cgaW5pdCBmYWlsZWQNCj4+Pg0KPj4+DQo+Pj4NCj4+PiBPbiAxMS8xMi8yMDI0IDg6MDAgUE0s
IEplc3NlLnpoYW5nQGFtZC5jb20gd3JvdGU6DQo+Pj4+IFsgMjg3NS44NzAyNzddIFtkcm06YW1k
Z3B1X2RldmljZV9pbml0IFthbWRncHVdXSAqRVJST1IqIHN3X2luaXQgb2YNCj4+Pj4gSVAgYmxv
Y2sgPHZjbl92NF8wXzM+IGZhaWxlZCAtMjIgWyAyODc1Ljg4MDQ5NF0gYW1kZ3B1IDAwMDA6MDE6
MDAuMDoNCj4+Pj4gYW1kZ3B1OiBhbWRncHVfZGV2aWNlX2lwX2luaXQgZmFpbGVkIFsgMjg3NS44
ODc2ODldIGFtZGdwdQ0KPj4+PiAwMDAwOjAxOjAwLjA6IGFtZGdwdTogRmF0YWwgZXJyb3IgZHVy
aW5nIEdQVSBpbml0IFsgMjg3NS44OTQ3OTFdIGFtZGdwdSAwMDAwOjAxOjAwLjA6IGFtZGdwdTog
YW1kZ3B1OiBmaW5pc2hpbmcgZGV2aWNlLg0KPj4+Pg0KPj4+PiBBZGQgaXJxcyB3aXRoIGRpZmZl
cmVudCBJUlEgc291cmNlIHBvaW50ZXIgZm9yIHZjbjAgYW5kIHZjbjEuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzMuYyB8IDE5ICsrKysr
KysrKysrKystLS0tLS0NCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3Y0XzBfMy5jDQo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3Y0XzBfMy5jDQo+Pj4+IGluZGV4IGVmM2RmZDQ0YTAyMi4uODJiOTBmMWU2ZjMzIDEwMDY0
NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMF8zLmMNCj4+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jDQo+Pj4+IEBA
IC04Myw2ICs4MywxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9od2lwX3JlZ19lbnRy
eQ0KPj4+PiB2Y25fcmVnX2xpc3RfNF8wXzNbXSA9IHsNCj4+Pj4NCj4+Pj4gICNkZWZpbmUgTk9S
TUFMSVpFX1ZDTl9SRUdfT0ZGU0VUKG9mZnNldCkgXA0KPj4+PiAgICAgICAgICAgICAgIChvZmZz
ZXQgJiAweDFGRkZGKQ0KPj4+PiArc3RhdGljIGludCBhbWRncHVfaWhfY2xpZW50aWRfdmNuc1td
ID0gew0KPj4+PiArICAgICBTT0MxNV9JSF9DTElFTlRJRF9WQ04sDQo+Pj4+ICsgICAgIFNPQzE1
X0lIX0NMSUVOVElEX1ZDTjENCj4+Pg0KPj4+IFRoaXMgaXMgbm90IHZhbGlkIGZvciA0LjAuMy4g
SXQgdXNlcyBvbmx5IHRoZSBzYW1lIGNsaWVudCBpZCwgZGlmZmVyZW50IG5vZGVfaWQgdG8gZGlz
dGluZ3Vpc2guIEFsc28sIHRoZXJlIGFyZSBtYXggb2YgNCBpbnN0YW5jZXMuDQo+Pj4NCj4+PiBJ
IHdvdWxkIHNheSB0aGF0IGVudGlyZSBJUCBpbnN0YW5jZSBzZXJpZXMgd2FzIGRvbmUgaW4gYSBo
YXN0ZSB3aXRob3V0IGFwcGx5aW5nIHRob3VnaHQgYW5kIGJyZWFrcyBvdGhlciB0aGluZ3MgaW5j
bHVkaW5nIGlwIGJsb2NrIG1hc2suDQo+Pj4NCj4+PiBJZiB0aGUgc2FtZSBjbGllbnQgaWQgaXMg
dXNlZCwgaXQgcmV0dXJucyAtRUlOVkFMIChiZWNhdXNlIG9mIHRoZSBmb2xsb3dpbmcgY2hlY2sp
IGFuZCBzdyBpbml0IGZhaWxzIGF0IHN0ZXAgdmNuX3Y0XzBfM19zd19pbml0IC8gYW1kZ3B1X2ly
cV9hZGRfaWQuDQo+Pj4NCj4+PiBhbWRncHVfaXJxX2FkZF9pZDoNCj4+PiBpZiAoYWRldi0+aXJx
LmNsaWVudFtjbGllbnRfaWRdLnNvdXJjZXNbc3JjX2lkXSAhPSBOVUxMKQ0KPj4+ICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+Pj4NCj4+DQo+PiBXZSBoYWQgc29tZSBzaWRlIGRpc2N1c3Npb25z
IG9uIElQIGJsb2NrLXBlci1pbnN0YW5jZSBhcHByb2FjaC4NCj4+IFBlcnNvbmFsbHksIEkgd2Fz
IG5vdCBpbiBmYXZvdXIgb2YgaXQgYXMgSSB0aG91Z2h0IGFsbG93aW5nIElQIGJsb2NrDQo+PiB0
byBoYW5kbGUgaXRzIG93biBpbnN0YW5jZXMgaXMgdGhlIGJldHRlciBhcHByb2FjaCBhbmQgdGhh
dCBjb3VsZA0KPj4gaGFuZGxlIGRlcGVuZGVuY2llcyBiZXR3ZWVuIGluc3RhbmNlcy4gVHVybnMg
b3V0IHRoYXQgdGhlcmUgYXJlIG1vcmUNCj4+IGxpa2UgaGFuZGxpbmcgY29tbW9uIHRoaW5ncyBm
b3IgYWxsIGluc3RhbmNlcyBhcyBpbiB0aGlzIGV4YW1wbGUuDQo+DQo+IFdlIHRyaWVkIHRoYXQg
cm91dGUgYXMgd2VsbCBiZWZvcmUgdGhpcyBvbmUgYW5kIGl0IHdhcyB1Z2x5IGFzIHdlbGwuDQo+
DQo+Pg0KPj4gSSB3b3VsZCBwcmVmZXIgdG8gcmV2ZXJ0IHRoZSBwYXRjaCBzZXJpZXMgYW5kIGNv
bnNpZGVyIGFsbCBhbmdsZXMNCj4+IGJlZm9yZSBtb3ZpbmcgZm9yd2FyZCBvbiB0aGUgYXBwcm9h
Y2guIFdpbGwgbGVhdmUgdGhpcyB0bw0KPj4gQWxleC9DaHJpc3RpYW4vTGVvIG9uIHRoZSBmaW5h
bCBkZWNzaW9uLg0KPg0KPiBEbyB0aGUgYXR0YWNoZWQgcGF0Y2hlcyBmaXggaXQ/DQoNCg0KWWVz
LCB1c2luZyB5b3VyIHBhdGNoIHZjbiBzdyBpbml0IHdpbGwgcGFzcy4NClBsZWFzZSBoZWxwIHRv
IGNoZWNrIHRoaXMgcGF0Y2g6IFtQQVRDSCAxLzJdIGRybS9hZG1ncHU6IGZpeCB2Y24gc3cgaW5p
dCBmYWlsZWQNCk90aGVyd2lzZSBkdXBsaWNhdGUgc3lzZnMgd2FybmluZ3Mgd2lsbCBiZSBkaXNw
bGF5ZWQuDQoNCiBzeXNmczogY2Fubm90IGNyZWF0ZSBkdXBsaWNhdGUgZmlsZW5hbWUgJy9kZXZp
Y2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMS4xLzAwMDA6MDE6MDAuMC8wMDAwOjAyOjAwLjAvMDAw
MDowMzowMC4wL3Zjbl9yZXNldF9tYXNrJw0KWyAgNTYyLjQ0MzczOF0gQ1BVOiAxMyBQSUQ6IDQ4
ODggQ29tbTogbW9kcHJvYmUgVGFpbnRlZDogRyAgICAgICAgICAgIEUgICAgICA2LjEwLjArICM1
MQ0KWyAgNTYyLjQ0Mzc0MF0gSGFyZHdhcmUgbmFtZTogQU1EIFNwbGludGVyL1NwbGludGVyLVJQ
TCwgQklPUyBWUzI2ODMyOTlOLkZEIDA1LzEwLzIwMjMNClsgIDU2Mi40NDM3NDFdIENhbGwgVHJh
Y2U6DQpbICA1NjIuNDQzNzQzXSAgPFRBU0s+DQpbICA1NjIuNDQzNzQ2XSAgZHVtcF9zdGFja19s
dmwrMHg3MC8weDkwDQpbICA1NjIuNDQzNzUxXSAgZHVtcF9zdGFjaysweDE0LzB4MjANClsgIDU2
Mi40NDM3NTNdICBzeXNmc193YXJuX2R1cCsweDYwLzB4ODANClsgIDU2Mi40NDM3NTddICBzeXNm
c19hZGRfZmlsZV9tb2RlX25zKzB4MTI2LzB4MTMwDQpbICA1NjIuNDQzNzYwXSAgc3lzZnNfY3Jl
YXRlX2ZpbGVfbnMrMHg2OC8weGEwDQpbICA1NjIuNDQzNzYyXSAgZGV2aWNlX2NyZWF0ZV9maWxl
KzB4NDYvMHg5MA0KWyAgNTYyLjQ0Mzc2Nl0gIGFtZGdwdV92Y25fc3lzZnNfcmVzZXRfbWFza19p
bml0KzB4MWMvMHgzMCBbYW1kZ3B1XQ0KWyAgNTYyLjQ0Mzk5MV0gIHZjbl92NF8wXzNfc3dfaW5p
dCsweDI3MC8weDNlMCBbYW1kZ3B1XQ0KWyAgNTYyLjQ0NDEyMF0gIGFtZGdwdV9kZXZpY2VfaW5p
dCsweDFhMGUvMHgzNWEwIFthbWRncHVdDQoNClJlZ2FyZHMNCkplc3NlDQoNCg0KVGhpcyBpcyBr
aW5kIG9mIGEgcGllY2UtbWVhbCBmaXguIFRoaXMgZG9lc24ndCBhZGRyZXNzIHRoZSBsYXJnZXIg
cHJvYmxlbSBvZiBob3cgdG8gaGFuZGxlIHRoaW5ncyBjb21tb24gZm9yIGFsbCBJUCBpbnN0YW5j
ZXMuDQoNClRoYW5rcywNCkxpam8NCg0KPiBBbGV4DQo+DQo+Pg0KPj4gVGhhbmtzLA0KPj4gTGlq
bw0KPj4NCj4+PiBSZWdhcmRzDQo+Pj4gSmVzc2UNCj4+Pg0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+
IExpam8NCj4+Pg0KPj4+PiArfTsNCj4+Pj4NCj4+Pj4gIHN0YXRpYyBpbnQgdmNuX3Y0XzBfM19z
dGFydF9zcmlvdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+Pj4+IHN0YXRpYyB2b2lk
IHZjbl92NF8wXzNfc2V0X3VuaWZpZWRfcmluZ19mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0K
Pj4+PiAqYWRldiwgaW50IGluc3QpOyBAQCAtMTUwLDkgKzE1NCw5IEBAIHN0YXRpYyBpbnQgdmNu
X3Y0XzBfM19zd19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPj4+PiAg
ICAgICBpZiAocikNCj4+Pj4gICAgICAgICAgICAgICByZXR1cm4gcjsNCj4+Pj4NCj4+Pj4gLSAg
ICAgLyogVkNOIERFQyBUUkFQICovDQo+Pj4+IC0gICAgIHIgPSBhbWRncHVfaXJxX2FkZF9pZChh
ZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9WQ04sDQo+Pj4+IC0gICAgICAgICAgICAgVkNOXzRfMF9f
U1JDSURfX1VWRF9FTkNfR0VORVJBTF9QVVJQT1NFLCAmYWRldi0+dmNuLmluc3QtPmlycSk7DQo+
Pj4+ICsgICAgIC8qIFZDTiBVTklGSUVEIFRSQVAgKi8NCj4+Pj4gKyAgICAgciA9IGFtZGdwdV9p
cnFfYWRkX2lkKGFkZXYsIGFtZGdwdV9paF9jbGllbnRpZF92Y25zW2luc3RdLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgVkNOXzRfMF9fU1JDSURfX1VWRF9FTkNfR0VORVJBTF9QVVJQT1NF
LA0KPj4+PiArJmFkZXYtPnZjbi5pbnN0W2luc3RdLmlycSk7DQo+Pj4+ICAgICAgIGlmIChyKQ0K
Pj4+PiAgICAgICAgICAgICAgIHJldHVybiByOw0KPj4+Pg0KPj4+PiBAQCAtMTc0LDcgKzE3OCw3
IEBAIHN0YXRpYyBpbnQgdmNuX3Y0XzBfM19zd19pbml0KHN0cnVjdA0KPj4+PiBhbWRncHVfaXBf
YmxvY2sgKmlwX2Jsb2NrKQ0KPj4+Pg0KPj4+PiAgICAgICByaW5nLT52bV9odWIgPSBBTURHUFVf
TU1IVUIwKGFkZXYtPnZjbi5pbnN0W2luc3RdLmFpZF9pZCk7DQo+Pj4+ICAgICAgIHNwcmludGYo
cmluZy0+bmFtZSwgInZjbl91bmlmaWVkXyVkIiwgYWRldi0+dmNuLmluc3RbaW5zdF0uYWlkX2lk
KTsNCj4+Pj4gLSAgICAgciA9IGFtZGdwdV9yaW5nX2luaXQoYWRldiwgcmluZywgNTEyLCAmYWRl
di0+dmNuLmluc3QtPmlycSwgMCwNCj4+Pj4gKyAgICAgciA9IGFtZGdwdV9yaW5nX2luaXQoYWRl
diwgcmluZywgNTEyLA0KPj4+PiArICZhZGV2LT52Y24uaW5zdFtpbnN0XS5pcnEsIDAsDQo+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfUklOR19QUklPX0RFRkFVTFQs
DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0+dmNuLmluc3RbaW5z
dF0uc2NoZWRfc2NvcmUpOw0KPj4+PiAgICAgICBpZiAocikNCj4+Pj4gQEAgLTE3MzQsOSArMTcz
OCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9pcnFfc3JjX2Z1bmNzIHZjbl92NF8w
XzNfaXJxX2Z1bmNzID0gew0KPj4+PiAgICovDQo+Pj4+ICBzdGF0aWMgdm9pZCB2Y25fdjRfMF8z
X3NldF9pcnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4+IGludA0KPj4+
PiBpbnN0KSAgew0KPj4+PiAtICAgICBhZGV2LT52Y24uaW5zdC0+aXJxLm51bV90eXBlcysrOw0K
Pj4+PiArICAgICBpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaW5zdCkpDQo+
Pj4+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPj4+PiArDQo+Pj4+ICsgICAgIGFkZXYtPnZjbi5p
bnN0W2luc3RdLmlycS5udW1fdHlwZXMgPSBhZGV2LT52Y24ubnVtX2VuY19yaW5ncw0KPj4+PiAr
ICsgMTsNCj4+Pj4NCj4+Pj4gLSAgICAgYWRldi0+dmNuLmluc3QtPmlycS5mdW5jcyA9ICZ2Y25f
djRfMF8zX2lycV9mdW5jczsNCj4+Pj4gKyAgICAgYWRldi0+dmNuLmluc3RbaW5zdF0uaXJxLmZ1
bmNzID0gJnZjbl92NF8wXzNfaXJxX2Z1bmNzOw0KPj4+PiAgfQ0KPj4+Pg0KPj4+PiAgc3RhdGlj
IHZvaWQgdmNuX3Y0XzBfM19wcmludF9pcF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrDQo+
Pj4+ICppcF9ibG9jaywgc3RydWN0IGRybV9wcmludGVyICpwKQ0K
