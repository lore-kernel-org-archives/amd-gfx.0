Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5007C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 14:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E52610E22A;
	Fri, 31 May 2024 14:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0kSSq/v";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1183410E1F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 14:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTABfEEG5vm0sX6fwWfYVZMWQAOCrjt6KQ9tZA6XLcoW/isovXJlR8lfDMa1auzbK8pTPrQexROC1Xr+Q0+yt1DZZjsnGdfF7UOaOARxXjCthQC7mwKgeDutCm+3nJJ8lMDQyJ8gm8thPSFGOTGdqzohBwHuwUi76l+KHxGAu9oOddEqC7n175asXUf/9W5cYjQjOgc95CDH+OJ8+gE8g28wFAB0df+w8E9iU6lgUOfVL/uzyf+Serjv9i8SZyvrJIFu/8l0BqEnmdiUL67CKx0Qmss9fI6mSHz/MtN+Fkevefn3jTgZ+rNfYMzfi306HBMrvfntgm8G9pcPFMjRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgBIg1zsJa4qOU4O4bE+35bhe4A+FlsS8+uRSjHILTk=;
 b=BNnsOiYvItYp5o+qZLVMU4ERK7hX+EZOaENGME+3xmHe7RCOOYPlNoTyLvbECWnNT5wnvS7LO4XcHqNeKghdk39j72x4ijVwpN2w3iIZ/jOtaf4ogSu19+1DDa5xnKSY8lh1f0ZxrciPHBkHngn3Uwo2rtd3iNv4RCDAxciIKTRPjmq3aAXrnFqK0DyjOOUsSrFgLd+QKv68FfiPf0bcKR3lwo8fPTDQOLi4mBIZk9exPOStH7fo9nb1g/EpjmTHRT4nBSour8wYSvZYfpnbiq0b6pBuQMLgGtErP8vVNqsQxwebXtCtByh3seMwBWSlJAy1gw69JH7oOGuZj332xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgBIg1zsJa4qOU4O4bE+35bhe4A+FlsS8+uRSjHILTk=;
 b=l0kSSq/vaUJb3GAZ13g3Nykeg9psiXU21wB2Mdba7EQz0qg6WoeXSQKrQVNWKm4LsUlyGZmexzW1aZ6jalq2O5PyVU4wrVEvuss21ehEFhtkH63t1rtSSGFGIix6jjbliYNKHmEn30UCyJeIA8iCAQeh+436TqAuE56+5/oVIos=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 14:44:43 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 14:44:43 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Xiao, Hua" <Hua.Xiao@amd.com>
Subject: RE: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Topic: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Index: AQHasSPntTWyQJHFuU6/8azfL5MK/LGtw2cAgABwxYCAAAKugIAAA6MAgAADGYCAAAnmgIAAAQgAgAADwoCAAAiaAIAAHlhw
Date: Fri, 31 May 2024 14:44:42 +0000
Message-ID: <CH0PR12MB53721A7C3403982035E48639F4FC2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
 <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <ab92ab3e-b96b-480e-8089-b3949f453bd3@gmail.com>
In-Reply-To: <ab92ab3e-b96b-480e-8089-b3949f453bd3@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f5063a0d-28eb-4b70-a12c-1ff13ff90d4d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-29T17:07:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS0PR12MB9059:EE_
x-ms-office365-filtering-correlation-id: 5c5a9514-539d-4016-0d07-08dc8180354f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?TkJEVmY0cjROTDlmRmdRQlpjMnRxVnU5andmWkNzZHRpUTdSK3hENEtJNXBn?=
 =?utf-8?B?ODhJanpHNTlSUk94MEg4ODRnSEhOdlUvRjdsaG1LRnZMNlcwb0JIMm52Z2tu?=
 =?utf-8?B?dUFCMVlUQW5yZjkwVkMrR1ZLQ2xmQ0liUEJKT0ZyRVFYa1BDVXJKVnRYbjE4?=
 =?utf-8?B?ZTZOcjFER2JqOWpyWTVRbzRrZDdZbHc3VjFxdU95dXRZVURhZVBRQVZaRnZY?=
 =?utf-8?B?Wjh3OXFPd1JQN2ZlcVQ0ZDMrdmpKZ0lDMStuNVRmVkw3QVdpVWw5UHVrOHZU?=
 =?utf-8?B?NW1YdkR4Z0ZWTDVpT2lzdTF2NXNvd3dHMmdVSUEyMkY4NHRnRHZnVkJ6bml3?=
 =?utf-8?B?L3MvS2Z2dHJhSGRUeVlEdFp4eEcrRlVDZk5Dc1c5ais1dHVCZmp0TkhleHFE?=
 =?utf-8?B?T1J3c2F5TUlablhRYXpzdnNlOWhQOWFid1dlNEJwa1RKT1BOSjJDSVdJNmFF?=
 =?utf-8?B?N0Q5UzZ4MUJtQ0xjdFFiS3dDZEZwSmIxcTdtZEhrRWY1MGlyRUFnUmE2Rzda?=
 =?utf-8?B?akMyaXd5OG9uZmNQa2VNV3lNS04zQVVobVZMcTQvTW16OW9CV2EvVDFORjk4?=
 =?utf-8?B?ZW9TcTR6SnB2QmJGU01yZ1dFaGNvNUhhYVQwcHZCN2JlS3M1cmdINThnWXhq?=
 =?utf-8?B?RndCSmJuM2p1M1FRNUJmaGhlWlR2ZnZRanJHOXp6WFIyTVZTb2w2RFh2NzZa?=
 =?utf-8?B?aDhvTHVXYW5CTVFYMHV1N3haaFY2VGdTRUdOazl1VzFnK3VwZ080RVByNkJI?=
 =?utf-8?B?MGx1cTlaYTdma3IzV21ZRUNjY2lLTFJlMmYxZ3Z3ZjN1YTFKcDRLZ1hlRXdl?=
 =?utf-8?B?OHNSQ200UUh3am1sUDlzWThPRm1PTGNMWFVodzVCdHFJVS9VcE1GdGhOUVVy?=
 =?utf-8?B?VXQvUDdac0VVUm15LzhTai95UWNib25RVnA2dXNjdUtYNzluU3hGUWl2WFJw?=
 =?utf-8?B?KzBTVmZ2dHZVaTcrRk5OR21ZSkxjR3BBaTZzSHBXc2JRUy9iUjl2TWowakNq?=
 =?utf-8?B?Q3laU1U2bmt0c0JXMitpYXRwY3FkSDRqVFpiam9wdlAxbVgzREtjQjVJdWQv?=
 =?utf-8?B?RnpaVUM1NUc2TFlsQ0p0SFcvRVBqOEU4cEViQ1Q2ck1wQm9nSnhnbEo3aUx6?=
 =?utf-8?B?WVJVbDJlU25vbEJuU0ZzbWYwWHVoVXlYODAyOUhqSkNCN0pPZ2RyQU9oNkNN?=
 =?utf-8?B?cnpHOEpvRGVrQzNidjFyK1l6ajlDRkNhdUg2SU5Zb3A0K2VkNUxWaGw3RVFN?=
 =?utf-8?B?YkNhQVJCY1VXS1RDODZGZlJRd2dtTWNPNzdpUGJ6dmxxamxyMi9NdjV0VnVB?=
 =?utf-8?B?MUtRclVQUlA0elFoSlplcVowY1k2dEdnSjgrbjV2L3c3enMxS1dVUEladTdC?=
 =?utf-8?B?N2d5TUhNdS9zMDgrNm1xc1FCQ2RIb3IxaG5DVEZ2THA1TnlDbm9BVmFSalZI?=
 =?utf-8?B?b1Npc2c3OU9QRWhLbnJzd2lBK0JhR2FoMjV2bTY0Z3llNnd0V1kvb0dzMWV0?=
 =?utf-8?B?MUhnT1NkZlVaSDIzRmZEUVlITG9LajJFaEJuZFFDTEhHNWVrTG5kSWJjZTJT?=
 =?utf-8?B?SGJZYWZBaTY5dVFua3V3YXhrT0N5Tk5hMHpvZWNCS0VBeVpDbTA0NUIvSU84?=
 =?utf-8?B?QXdqQllqUkt6c244Skdib2t2NTI2MnlBb2ZEc295bnJqYmh1Tis2UHJLWE1r?=
 =?utf-8?B?RXo0VWtuTFlBeWlGcERVR2EzUjQ2Vk9rMVBXZmJKU0p1b01Sc0lLdCs4Rldy?=
 =?utf-8?B?YTArbGxFR2UvK0VVQzVXM2VUSGkvcHFQK0Qvb1k4anJIQXlwWmtmWkJnNVRF?=
 =?utf-8?Q?YD6BOshrjLi3yJhsb3Tlw5XiPIIP/2Tc6+/FE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(921011)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anlqV2RhUUxidGFKQ2V2ZFFoYVpYcUtPYmE0YTgrTzFrQXlhaGhNYVJZcnlC?=
 =?utf-8?B?NmMxQnUvKzcreGJaaDFIUlBXSlYvcU9uN1NhYys1aUY5YzBMRWJ3YW9kZlo1?=
 =?utf-8?B?UExFR2VJWVh6OUlmM2NhaE1OUWZpck1QT2NIekFxUGhVQy9jc01MM053QzJr?=
 =?utf-8?B?V1dmZDlxczJnUVNNTHd2WGQyTG0zQlN6NWpQbmtWSDlRVTFBKzFBdkJQNnow?=
 =?utf-8?B?YXluaWw3bmU0SmRnOTM0dUMrYzlpdkt6bTlBazc4UHk1Y3ZEODd2NHRoNVVT?=
 =?utf-8?B?TGh0SDFZUFRaWEgwL3dMeEcxRG8yUUl4VU1yUUdvb0VDTmJ3SE83UXVkblMx?=
 =?utf-8?B?UlkyTEFnUXBScGNHSThDRGdjaThzNUo4WE1nTFFIQVI3MGh4OWRjS1hNRHZ1?=
 =?utf-8?B?amdJM1hERk8zY000cGVWTiszbHRZQnJicUMzOUFSY2d3bE1GZCtpMmQyTmJs?=
 =?utf-8?B?ZklTbklvaUpoakJvenBzYWlseUJHWElDTmY3S0F6OUNXcnNLd3VyRjNhZytP?=
 =?utf-8?B?bGFSVWRPM09uNWtGQjI3R29wVHVRZkNLNWF4QThsNFNPKzlTclZOREUrajY5?=
 =?utf-8?B?N01uQUV2Y1M3cUI2U1ZPYTVSSXNXNnZrVFJ0cjU2RnFPL29FcEFKc1RCamRq?=
 =?utf-8?B?eTBVK1pURzFRY0FoUzkydzZ6bVEzWis3bU92akhoSUk0NENET2MxYkVJVDhX?=
 =?utf-8?B?bkVDN2c3aWpUVVEzaExyQ0pyUkg2WUltOFpJdGVRQTB3WFh4bzA3ZmZIamFi?=
 =?utf-8?B?ZnJaUWtvSkJIT3RyY0RJbnB0MjMwenY5ZXJLVEt4NjVLeU80Y3BscS82Vnh2?=
 =?utf-8?B?QU9OMTRZVnFXaWRDTHNoQVdwK3JaTTNudDRpbEZoWmp0cE50Sm9mN2NLNDRo?=
 =?utf-8?B?dTBmZDVTN0NqeDJCaUhVSklYb21OSWZVWFpWOWNXR3F4YzZOL2pKNzF5VjBa?=
 =?utf-8?B?NU5PaFJjb0R3WWwxYjc2YWxZaHRZelo1bTVXOVp5c0VHK0hDeWtlODdKQ2c5?=
 =?utf-8?B?b3FnSENJQkRKd2U2UEdIZzllR3o0SHRsa0lHZWlvWDJSaHJuRTQvNDNQMDB6?=
 =?utf-8?B?Zm1iVndONzMva1ZwNDhRSFcweDBPQk9xd0dQbk9IZDJ4b0V4a1VVNHBka3FN?=
 =?utf-8?B?ZmxjV2FDWHBmVENGayt0TUpTOU9ZMVVDRDdVdHlmS0Y0SDlvam1DUE5aT1B0?=
 =?utf-8?B?c3dxczkzbmlBMERJOXp1NUFZcll6WjBTS0E5RDkyMWtqc21WVFQwL0czSkdu?=
 =?utf-8?B?b0I5V1MrNkUrbVhNazltclUvM09RWVdoMytYMmRQVkE4WUg0RDR4TnRCSjhT?=
 =?utf-8?B?R0ZWdndNOTYwZWhpYTNxK3RSeWdFNmVlS2s3RFZjWlpCT0REZ0x1Zys4YkRK?=
 =?utf-8?B?UGF1REJnUU9QK0NreEg4VDhrK0dKeWp2TTRHMGZtSDhqVEVvdCtrOVd1NGN1?=
 =?utf-8?B?V2FWanNmNlNDZGVkcFNvajVId1RZVXM0Y2JOeFNDMUxzOGhGS1EzLzJ0NURt?=
 =?utf-8?B?NUxNYzZxQW5jL1FuM25zcTMwY1BRSkdmYzlOV091ZFZIa29PN3dSMS85bVpt?=
 =?utf-8?B?ZnFURGt6TmJwUEQ1Z0tmTU84bVFIMkZUVWc5VU1raGNPdStnR0NJd3U2Z080?=
 =?utf-8?B?ZU9MdXpEY3RJU3UwNE5NWXVWalBRK1dpZGVsNHNkRW5KNkJZTGxQSjI0RHd5?=
 =?utf-8?B?Um04cXVnM0lzNmVFNGdiRHJPM3Q2dUtGc1YrL3J4TnM0ZURaSnNVWnZPRlZD?=
 =?utf-8?B?YkduUkluL0FXWkZ1NlNCYVlUbndLNFNiU2pDSnBubkpCRUtOa1dwSldSS3Vo?=
 =?utf-8?B?aEdkOEMxSXpHL0l0ZHFzbHQrZjBBem9kL0J1QVBMRmxUalQ4cUJsVERMSzdL?=
 =?utf-8?B?dWtPS0E2cEFOUittZzkrbTRuYUM0aUNvUzFoMk83dWJJWk1EeGhOclB3Z3l1?=
 =?utf-8?B?L3FMeWIrUERTc2RDd0FWSnhrL2c4cHA2VXYxV0h3dHl6d2U2MThOY1JQSkJo?=
 =?utf-8?B?QUU2SjQxUVdXS3FhZXhvamlXdnJWKzl4YzlZRy9GRjh0eGJnQmpDakgyc0dx?=
 =?utf-8?B?eFEvNXpXVkhVb2NrYkljVGhTSmJha1FxdWhVRjBoMk9JMFVWdml3YjJ4Wk9J?=
 =?utf-8?Q?dgsc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5a9514-539d-4016-0d07-08dc8180354f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 14:44:42.9580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvYpCbgcemevlhr1VrXjz/gaXVoMOcY54TzVQIxQZWlxcYQWxFxxT+4nc2gRe4++ef57Mi1OaE7cPwvvk3cJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
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
Cg0KSGksIENocmlzdGlhbg0KDQpJIHRoaW5rIHdlIGhhdmUgYSBkaXNjdXNzaW9uIGFib3V0IHRo
aXMgYmVmb3JlIC4gQWxleCBhbHNvIGhhdmUgYSBjaGFuZ2UgdGhhdCBhbGxvdyBkcml2ZXIgdG8g
dXNlIGRpZmZlcmVudCB3cml0ZSBiYWNrIGFkZHJlc3MgZm9yIHRoZSBmZW5jZSBmb3IgZWFjaCBz
dWJtaXNzaW9uIGZvciB0aGUgIG9yaWdpbmFsIGlzc3VlIC4NCkZyb20gTUVTICBwb2ludCBvZiB2
aWV3ICwgIE1FUyB3aWxsIHVwZGF0ZSB0aGUgZmVuY2Ugd2hlbiB0aGUgQVBJIGNhbiBiZSBjb21w
bGV0ZSBzdWNjZXNzZnVsbHksIHNvIGlmIHRoZSAgQVBJIChleCAuIHJlbW92ZV9xdWV1ZSkgZmFp
bHMgIGR1ZSB0byAgb3RoZXIgY29tcG9uZW50IGlzc3VlIChleCAsIENQIGhhbmcpLCB0aGUgIE1F
UyB3aWxsIG5vdCB1cGRhdGUgdGhlIGZlbmNlIEluIHRoaXMgc2l0dWF0aW9uICwgYnV0ICBNRVMg
aXRzZWxmIHN0aWxsIHdvcmtzIGFuZCBjYW4gcmVzcG9uZCB0byBvdGhlciBjb21tYW5kcyAoZXgg
LCxyZWFkX3JlZykgIC4gIEFsZXgncyBjaGFuZ2UgYWxsb3cgZHJpdmVyIHRvIGNoZWNrIHRoZSBm
ZW5jZSBmb3IgZWFjaCBBUEkgd2l0aG91dCBtZXNzIGFyb3VuZCB0aGVtICAuICBJZiB5b3UgZXhw
ZWN0IE1FUyB0byBzdG9wIHJlc3BvbmRpbmcgIHRvIGZ1cnRoZXIgY29tbWFuZHMgIGFmdGVyIG9u
ZSBBUEkgZmFpbHMgLCB0aGF0IHdpbGwgaW50cm9kdWNlIGNvbWJhYmlsaXR5IGlzc3VlIHNpbmNl
IHRoaXMgZGVzaWduIGFscmVhZHkgZXhpc3Qgb24gcHJvZHVjdHMgZm9yIGN1c3RvbWVyIGFuZCBN
RVMgYWxzbyBuZWVkIHRvIHdvcmtzIGZvciB3aW5kb3dzIC4gIEFsc28gTUVTICBhbHdheXMgbmVl
ZCB0byByZXNwb25kIHRvICBzb21lIGNvbW1hbmRzIGxpa2UgIFJFU0VUICBldGMgIHRoYXQgbWln
aHQgbWFrZSB0aGluZ3Mgd29yc2UgaWYgd2UgbmVlZCB0byBjaGFuZ2UgdGhlIGxvZ2ljIC4NCg0K
T25lIHBvc3NpYmxlIHNvbHV0aW9uIGlzIE1FUyBjYW4gIHRyaWdnZXIgYW4gSW50ZXJydXB0ICB0
byBpbmRpY2F0ZSB3aGljaCBzdWJtaXNzaW9uIGhhcyBmYWlsZWQgd2l0aCB0aGUgc2VxIG51bWJl
ciAuIEluIHRoaXMgY2FzZSBkcml2ZXIgY2FuIGdldCB0aGUgIGZhaWx1cmUgb2YgdGhlICBzdWJt
aXNzaW9uIHRvIE1FUyBpbiB0aW1lIGFuZCAgbWFrZSBpdHMgb3duIGRlY2lzaW9uIGZvciB3aGF0
IHRvIGRvIG5leHQgLCBXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzID8NCg0KUmVnYXJkcw0K
U2hhb3l1bi5saXUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBDaHJp
c3RpYW4gS8O2bmlnDQpTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAyNCAxMToxOSBBTQ0KVG86
IExpLCBZdW54aWFuZyAoVGVkZHkpIDxZdW54aWFuZy5MaUBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzEwXSBkcm0vYW1kZ3B1OiBhYm9ydCBm
ZW5jZSBwb2xsIGlmIHJlc2V0IGlzIHN0YXJ0ZWQNCg0KQW0gMjkuMDUuMjQgdW0gMTY6NDggc2No
cmllYiBMaSwgWXVueGlhbmcgKFRlZGR5KToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFN
RCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4+IFllYWgsIEkga25vdy4gVGhhdCdz
IG9uZSBvZiB0aGUgcmVhc29uIEkndmUgcG9pbnRlZCBvdXQgb24gdGhlIHBhdGNoDQo+PiBhZGRp
bmcgdGhhdCB0aGF0IHRoaXMgYmVoYXZpb3IgaXMgYWN0dWFsbHkgY29tcGxldGVseSBicm9rZW4u
DQo+Pg0KPj4gSWYgeW91IHJ1biBpbnRvIGlzc3VlcyB3aXRoIHRoZSBNRVMgYmVjYXVzZSBvZiB0
aGlzIHRoZW4gcGxlYXNlDQo+PiBzdWdnZXN0IGEgcmV2ZXJ0IG9mIHRoYXQgcGF0Y2guDQo+IEkg
dGhpbmsgaXQganVzdCBuZWVkIHRvIGJlIGltcHJvdmVkIHRvIGFsbG93IHRoaXMgZm9yY2Utc2ln
bmFsIGJlaGF2aW9yLiBUaGUgY3VycmVudCBiZWhhdmlvciBpcyBzbG93L2luY29udmVuaWVudCwg
YnV0IHRoZSBvbGQgYmVoYXZpb3IgaXMgd3JvbmcuIFNpbmNlIE1FUyB3aWxsIGNvbnRpbnVlIHBy
b2Nlc3Mgc3VibWlzc2lvbnMgZXZlbiB3aGVuIG9uZSBzdWJtaXNzaW9uIGZhaWxlZC4gU28gd2l0
aCBqdXN0IG9uZSBmZW5jZSBsb2NhdGlvbiB0aGVyZSdzIG5vIHdheSB0byB0ZWxsIGlmIGEgY29t
bWFuZCBmYWlsZWQgb3Igbm90Lg0KDQpObyB0aGUgTUVTIGJlaGF2aW9yIGlzIGJyb2tlbi4gV2hl
biBhIHN1Ym1pc3Npb24gZmFpbGVkIGl0IHNob3VsZCBzdG9wIHByb2Nlc3Npbmcgb3Igc2lnbmFs
IHRoYXQgdGhlIG9wZXJhdGlvbiBkaWRuJ3QgY29tcGxldGVkIHRocm91Z2ggc29tZSBvdGhlciBt
ZWNoYW5pc20uDQoNCkp1c3Qgbm90IHdyaXRpbmcgdGhlIGZlbmNlIGFuZCBjb250aW51aW5nIHJl
c3VsdHMgaW4gdG9ucyBvZiBwcm9ibGVtcywgZnJvbSB0aGUgVExCIGZlbmNlIGFsbCB0aGUgd2F5
IHRvIHRoZSByaW5nIGJ1ZmZlciBhbmQgcmVzZXQgaGFuZGxpbmcuDQoNClRoaXMgaXMgYSBoYXJk
IHJlcXVpcmVtZW50IGFuZCByZWFsbHkgY2FuJ3QgYmUgY2hhbmdlZC4NCg0KUmVnYXJkcywNCkNo
cmlzdGlhbi4NCg==
