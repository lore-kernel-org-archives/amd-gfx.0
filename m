Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D102ECCFA1A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 07:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEBF10E316;
	Mon, 10 Nov 2025 07:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wNU8pVMB";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1DF10E316
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 07:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbVPxkQ1th9DEf5PmPt2FhsCQe2g8tEqX2xVDKcUxHy5+T/2CR9/+VZTA/X/gNMGB57TcyvvwR5lbhmMPZATDJVDIzlsWNsInkFfJl1d1C1MT4JNTOK6/TX+jqDTlJG7+pv7GRgv0jRZOhuEc4SNa84WCZsUQXWucIauFQD6x2agqGu1Ngv2lRgsOeunGoY7IxON8Fm2jQOV13D2aaoKRp0QX8rdhj7Un8R2dIby7ikcntdWQJrfvqUoAv9Vbs0eADgdQ2kCRjUuysQIQ9NwgHYhOTCx6cNAKauOEtxJza/EF9ourUP1fmENphQu3cbtr4Cz81YeAP3Rkvq5G1ANsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vqfhrH1He1mE3JKrYTzCgeBGmkNwfFMxEd7VtUaAvg=;
 b=SjtFXS/tIMfussXXT+yGr5MvJ4dJv9MGTqQPy7Y0/LT/hLvUpDdO03GwVQzhCuJrN7ycGee/g5wfLUg2oLz9rc1orMVXXIO5FI4pZkng+odEn5vPMPaUgT2qXVIWQiyNWiA/HwPxIRDQvkVPPCs4wGSTQMrXpaaSINAGNSA9+XDTyECRoauCsel3CqGuiG0zt6ycmQ3CFh3YVdk0+vIinqajNUMfvttUk2U3BvdhbhW3MlHVerzDIvx5zHzOP9Wexj0RVIOxqQc1VsD1WG/BcPVeUWZwupcVXwI/Z3DTQuQxMQ1xP6ZG2ftglcPcO5gD/BUMIHo1Cwd1Wn3cDTwn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vqfhrH1He1mE3JKrYTzCgeBGmkNwfFMxEd7VtUaAvg=;
 b=wNU8pVMBa3dfSxlCboqVjBL9PTolcKfcSc9lhjnna3QrGyd77dwkE5nBt55R3nv0+bgLWB1Z8GwdhRfggb3udCf275FwKDbxc5i/+wghfcgYtFe2/AoS/HNmIRn26P5Pibi0fc7TC76ihtFQ/LPPqPJWlOm6fFgmwnn8aEgfFxs=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 07:58:39 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::1f8c:661:11b5:86fc]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::1f8c:661:11b5:86fc%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 07:58:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Thread-Topic: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Thread-Index: AQHcT9l6lhKSyqqNBESeJGRaQcPs4bTnQAGAgAPnbACAAEEzgIAAJZxA
Date: Mon, 10 Nov 2025 07:58:39 +0000
Message-ID: <PH7PR12MB600056AA1340272EF04E129CFBCEA@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20251107112704.4080134-1-Jesse.Zhang@amd.com>
 <CADnq5_MtwYtWN-63DAyeRHnLNKG=4qH5PMXdqfBAtXeoe7aFVw@mail.gmail.com>
 <DS7PR12MB60051224A2E188939C4F100EFBCEA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DM4PR12MB5152AD32901F715486DD54FCE3CEA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152AD32901F715486DD54FCE3CEA@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-10T01:44:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH7PR12MB6665:EE_
x-ms-office365-filtering-correlation-id: 2b452b8b-37ff-4e77-f308-08de202ef58a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TGoxVzBKNllmcVVWSXQzc0tXTm8wdHYwc0xmM0dGOHJQUXJrbTF2RDFNSHlI?=
 =?utf-8?B?VXNGQWYrQ2FhUTdqeVdoMjRFTTBldFAvVUM5MUlXa3hiOE5ITy9IUU1MODFz?=
 =?utf-8?B?TERRemRFaWMxTUdyeCs0K2VPblVWdXZuOGNWRU03TVEybDYvMDFDdmtkUExE?=
 =?utf-8?B?VHRob01LNWU3UUxHSWVvMkVYRGU3WG5ZMUdBRjlMTUQ5NlBhN3dxOG00TStZ?=
 =?utf-8?B?TnAvRU1jSzdCbkE2NHFsUWJkcUZYeXRyYno4V3BYTWNNK0ROeXlyRWZKWWNk?=
 =?utf-8?B?Qlp4NWZaL08rd3pIZ0lrNDhTS3RGNkNUK29MemMzYVY0MEc5am1WLzZoajFP?=
 =?utf-8?B?eS93aURBdnpOQ3dqa0FEN244MWtVdHBpb0pLR0Z4QmdJejZRdzF6aGdnL2lB?=
 =?utf-8?B?SUFqV2J5REplRzl6ZElYSnpOYmUvZHg2a3VCei9hcndIdHYwRU9wM3ZkNVRr?=
 =?utf-8?B?dlRzTFFiSWIwd0RKdTJJSThBMUhTOVJKZnZBYUZESVV3YnA3WU5qV3FUSGZC?=
 =?utf-8?B?d05PT1BqZzFMRjM1U0F6T1RMMis1Sk1iMXJjU1FaUS80c2lvOFFxT09DRGF3?=
 =?utf-8?B?dGhPNld0R0dWR3h6TFR4bGRSTFN1aER2RXFBNE5DKysxb3BxMldIbVl4ZmVw?=
 =?utf-8?B?dENXL2ZxZ3ljc3M0MmNjYytrNkNFbVBLQURlay8vNVNHTjQ0R3p0OWhjTkRM?=
 =?utf-8?B?dDVpSkZDMnVVWGRhRUtjQytzMEt3RWp1dUgvYVF3bXUveCszRXFBblRVb2xM?=
 =?utf-8?B?Y3NGL1E3TjEzak4wK1ExNGRROUdzdlp1c2lEZ2tVUHN3SzUrUGE1ZGZFZEMr?=
 =?utf-8?B?N05ucmdVeFBzUFhHYjhGOWVVUmJUMjZBc0tGTlFodlNBNzBvMzdrb01JNS9Y?=
 =?utf-8?B?T1RkTitNZEpRYlZ2MXhrck9xc21TbXNkb08rSFUyQSsyNXV2K0hsM0xjUi9D?=
 =?utf-8?B?M0g0TnlHRWV2dzh4WXpLQlRWVHQ4dGtNVHJ0SDQ5d0tLSk1FSHlIZ3pHUURP?=
 =?utf-8?B?R2xQUCtJSzVwZFZna0hHdTdrNS9jRWh2WWtGK0pKcHNobjlrclVYYVdUTGVv?=
 =?utf-8?B?RUJVdjdIREkwU1BOU3VXOTAwN01BelpsOEtvYjdHdEV0MjNXT3VIVll3c01q?=
 =?utf-8?B?QmpYMitGM0RmdUVvWmVxMHhlN3RMREdoRW5mTHNsSVhXQWkvWGxGQnp0bjdZ?=
 =?utf-8?B?b0M3MjlQRFc2aXliT25oMkRQaDdLeC9pMG04OVRwSVcxemNJNGYvclhEeHZw?=
 =?utf-8?B?RXRUMm9WY2FoK1Z2VHl0K2EzY3lIa0ppblp5aUdtYThNUUx4UHB4L1BOUUla?=
 =?utf-8?B?UHBqZys2VzhsWUhhWFJLb0hqVkdlQkhMTzVvYzAwa2tCbmtzTUsyeU1VVy9o?=
 =?utf-8?B?SGxXT2tNeTdxY2w4SVRsa2poVDJ6RzQ5SmFqVVpGTGFHcGRMUkNHck12bUx4?=
 =?utf-8?B?NlBMNEFkaTY3Z0cvWWxpaE91WC9tc0ZvUFpldFhxcjYzVmpFSk1jN2VCbTZZ?=
 =?utf-8?B?RUEyNnlRR0xoWE9UWXg0dVIreDl4U3VIck1KcVZnTjhST2hLOTYxSCtrbmdD?=
 =?utf-8?B?cjNibGcwMGJaeTVIVndpMmRHd0lYa2lKTVhESUl3TDRWR24xd0ZPKzlDays4?=
 =?utf-8?B?cFBaeFZiUEhoSnB4VW50M0VQUXJnMmpSSE1RUzlhOStTbTlvdTJPV0IyeTI5?=
 =?utf-8?B?dDRNL2ErZWY0c3NERXU4cFQ1UzlVQ1FOY1dNV2FTVWRiU3dhZGQ1S21nMlNP?=
 =?utf-8?B?V3gzRWp5d085ckRxdE96SFlOYW91bXllOWx6b2ZWVEdBOXhXV3V4TGNoR2ll?=
 =?utf-8?B?SFp5bnpkN0dOU3Q0TjZ1SDhnaTc3N2N6anBiM1FrcW14NVdCUW5qKzdCeGc5?=
 =?utf-8?B?dlVIYW5TQUtiUE43T2tOcDYzTGs2L2VqRDVqdzNhdEUyZ01aZmt1RGhzNWYz?=
 =?utf-8?B?YjRDMzdnZFBseVZNU3JOMFNqNTNuNjJOeWxBbnMwL3I4MG5UM3VNVXFJQlV0?=
 =?utf-8?B?d2l6WDhHWXllYXdHWkQvM3lSNldmMDdLNG5HT2tobHk1eGNPbGcvY053T0Ni?=
 =?utf-8?Q?uB1LQm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEpGMDZ5b1MvUXlUcWZpSVYweVUweUg0Y21rV3NmbFBCb09kVkFkZ3ZIbUZU?=
 =?utf-8?B?RHJuS2RUR0ZQakEvdER3WW1HZU9nMjJvWEJNL3hVRVU2K0toTW9VdmdVVDBL?=
 =?utf-8?B?amcvTllueEZjM2xRMk0vdnRjK0ZDdEFIM1RMdVBxUWRHU1hEalJ2WUE1cmdm?=
 =?utf-8?B?ZTl6Ukkxdklnb3huL0FKVU94RTJKeXF6TFhScjUyck42dzlnK3YySEQyK0R3?=
 =?utf-8?B?SDNqNXpha1BBZ3NvcitPUUJrUDIyY2ZCQ2F2T2Q5ZDh4VVMzYWp6MVFUTVBH?=
 =?utf-8?B?VDlPam1zVG5uSlNQaUt3OHJhYXlicENPZGphS09XekZQQ0E3d1pvb2hWRmlT?=
 =?utf-8?B?dGJXOGQzRmFOcVhIbVpkcEMyVDlTRUN1SjNtc0s1R2hreWQzNXByNjNsSEtY?=
 =?utf-8?B?aUZrOGYvbXVhQVhoWlpER3Z3T0pqSy8xS2Z4d2xDY0JrWU94bHBxVzE2amE2?=
 =?utf-8?B?M2FiQVV1MXFpZkNyaTJSOG9NL2U5UnNBZWpFR0paQWdkZTJOQWVCcGR1RTJK?=
 =?utf-8?B?eDZLS2NWWFJxdkJiL05MNTlUQk8yamlVOFlLUk55L2J5VTFKL0VXTTJ3UHhD?=
 =?utf-8?B?ODcvaXNQOVBCUmZ1ZE9GdmJBUStUdHZ3aExPZVZVNVNEWWVnYmFJL3VIU0lI?=
 =?utf-8?B?bHU5RWxrOGVReW1rUnFPWHpzZEMrbGY5SVBVR2NjM0tFSWVxS3VjU1ppRjJ2?=
 =?utf-8?B?Z05kdGpYa3lLclFJRjhvbXR5OC9uS0lLM3AzRHE3cWxWQTBQUUFwVjBBVHZE?=
 =?utf-8?B?ZGVxZlkvTXBlaDNVSWlrU24wSU1rZ0tQRWVqRWpaTjI0ZTZ1cGRPOExMSy84?=
 =?utf-8?B?cEhML3Znbk1VT0V3bzNvN1JtNkhocTRhV0wzQVllUkNwOHhXNjBKeTRBN2ta?=
 =?utf-8?B?bUdPaGtYK2R5ZllJVG9tU0p6eUt6UWZjdVo5a2FBYjI3WVVBemU1K1drb3BE?=
 =?utf-8?B?REttd1BvTS92cmxIVFBHYVNjTEo4UENyU0VBRUprNFFDQU9DTm5YaTdsdFBx?=
 =?utf-8?B?ZVdOTFRjOExGMUVPSm13UGZsZGtqemVZbklsZ0FUejZFSXN4b2prcHNsblBx?=
 =?utf-8?B?L1FlODdvT3hZWWJkclRMQ3oxa01uaTFTMWJDMisrYXNJaWRkVVJzcm9VM0Fl?=
 =?utf-8?B?R2hKUm5QRllvTlArVnNMbTBqSi9zNjByYWU2bUhzZGpSNVpYU0VacGFLMTk0?=
 =?utf-8?B?WU1mejFWNGNhdm9Da2VZdWRnWnVwbGU2QUdRc0V5REh2WXMzbXlNbU1TM0NY?=
 =?utf-8?B?TDZSUUVaRlRWdjg3VHZPbkEwcDRvcUNiV1dHN1hZR0tsalY4L0srTHJEcWhC?=
 =?utf-8?B?SkNydWowK1ByNVlPakNhdU90ZUtQdVlJVUNaTm1vYkF3anhKdjQzcjBEaEwx?=
 =?utf-8?B?QW9rMFBhWHFxSzlmcG5JM3U0ak03eEhhbHZzLzF0K1kxTGNxTUdkbEF4amNx?=
 =?utf-8?B?WGxPTURhNUJWUWg0clE5MWxzYW5LNFJrTHJ6UHhSdTdvTjBtSTA3bk56d0hQ?=
 =?utf-8?B?WC9JZWJrNUF0cXhGVFJOc3ZrQVJ6My85LzBCNFd4cFVVWVdwSyt0Nm53TUZF?=
 =?utf-8?B?SElpNnpaS3JnOUNjRmE3cVBicHNTU0pTZkJqNTMyRFo4SjZMditCM0ZkNHdo?=
 =?utf-8?B?UWc3L0V6bHo1d3ExazNGOFNvR2xFVkFubGFPeUF4bTB2RzZEYmV2cTN6eEh4?=
 =?utf-8?B?Ymw5bStnOWlCb09CTVYvV1c0cnhMT2lTdDJVdG1oSmFXaW9vekpLYlJNWXBo?=
 =?utf-8?B?UzBvNDVHalN4QVBEYy9xbVppbStQSjZQb2J5S1d2TTU5NGtsLzltRmczbkxu?=
 =?utf-8?B?aFhNbVYxODBwcTRhN0EwUzdlblNBNU43Uy9ONnRZNFpXTFkzYTVxcFpORDdo?=
 =?utf-8?B?TS8yQzZhejZscS9XMEw5RGxWZlovdkl3MHU1RUJzYy8zdFhRbHJHSnB0VXl1?=
 =?utf-8?B?TWdtL3ZrampYY2haVzJON1hMOTRncWV0RzBiMjhQNEZvVVkxQWd5a1RLN1BI?=
 =?utf-8?B?UkxWTlBISk92WVFRd2MvQ1FFaDRlazJ5YU5ZUEh1SGl5OVZpOUF5ZFA0cldn?=
 =?utf-8?B?aGRtTG94d21JK3ZZMFExZlI0eU13NUdaZXd4N3VldUhQMHJWdUJ2cjVxODBW?=
 =?utf-8?Q?uBXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b452b8b-37ff-4e77-f308-08de202ef58a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 07:58:39.3138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtkuZ8YDJX2zbORclK+DPd3HbE1yBPuP2UH6Eb4L0AZsMxmhFc6ykzAtq9nvcFJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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
YWdlLS0tLS0NCj4gRnJvbTogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+
DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTAsIDIwMjUgMTozOCBQTQ0KPiBUbzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgQWxleCBEZXVjaGVyDQo+IDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hl
ciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogcmVzdW1lIE1FUyBzY2hlZHVsaW5nIGFmdGVyIHVzZXIgcXVldWUgaGFuZw0K
PiBkZXRlY3Rpb24gYW5kIHJlY292ZXJ5DQo+DQo+IFtQdWJsaWNdDQo+DQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFt
ZC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMCwgMjAyNSA5OjQ5IEFNDQo+ID4g
VG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgWmhhbmcsIEplc3NlKEpp
ZSkNCj4gPiA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlc3VtZSBNRVMgc2NoZWR1
bGluZyBhZnRlciB1c2VyDQo+ID4gcXVldWUgaGFuZyBkZXRlY3Rpb24gYW5kIHJlY292ZXJ5DQo+
ID4NCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gT0ssIHNvIHRoYXQgbG9va3MgdGhlIHF1ZXVlIGlz
IG5vdCB0aGUgZnVuY3Rpb25hbCBzdGF0dXMgYXMgSSBwb2ludGVkDQo+ID4gb3V0IGluIHRoZSBs
YXN0IG1lZXRpbmcuDQo+ID4gV2UgbWlnaHQgdG8gY2hlY2sgdGhlIHF1ZXVlIHdoZXRoZXIgaXMg
cmVtYXBwZWQgb3IgYWN0aXZlIGJlZm9yZQ0KPiA+IHBlcmZvcm1pbmcgdGhlIHF1ZXVlIHJlc3Vt
ZS4NCj4gW1poYW5nLCBKZXNzZShKaWUpXSAgVGhlIE1FUyBmaXJtd2FyZSB3aWxsIGNoZWNrIHRo
ZSByZWdpc3RlcnMNCj4gcmVnQ1BfR0ZYX0hRRF9BQ1RJVkUvcmVnQ1BfSFFEX0FDVElWRV9BQ1RJ
VkUgYWZ0ZXIgYSByZXNldC4NCklmIGFsbCB0aGUgcXVldWUgdGhhdCByZXF1aXJlcyBiZWluZyBh
Y3RpdmUgb3V0c2lkZSBvZiBmaXJtd2FyZSwgdGhlbiB0aGF0J3MgZmluZSB0bw0KYWx3YXlzIGtl
ZXBpbmcgcXVldWUgcmVzdW1lIGluIHRoZSBkcml2ZXIuDQoNCj4gVGhhbmtzDQo+IEplc3NlDQo+
ID4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gICAgICAgUHJpa2UNCj4gPg0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiA+ID4gQWxleCBEZXVjaGVy
DQo+ID4gPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDcsIDIwMjUgMTA6MDcgUE0NCj4gPiA+IFRv
OiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gPiA+IENjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+ID4gPiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogcmVzdW1lIE1FUyBzY2hlZHVsaW5nIGFmdGVyIHVzZXINCj4gPiA+IHF1ZXVlIGhhbmcgZGV0
ZWN0aW9uIGFuZCByZWNvdmVyeQ0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTm92IDcsIDIwMjUgYXQg
NjoyN+KAr0FNIEplc3NlLlpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPiA+
ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBlbnN1cmVzIHRoZSBNRVMgaXMgcHJvcGVybHkgcmVzdW1l
ZCBhZnRlciBkZXRlY3RpbmcgYW5kDQo+ID4gPiA+IHJlY292ZXJpbmcgZnJvbSBhIHVzZXIgcXVl
dWUgaGFuZyBjb25kaXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IEtleSBjaGFuZ2VzOg0KPiA+ID4g
PiAxLiBUcmFjayB3aGVuIGEgaHVuZyB1c2VyIHF1ZXVlIGlzIGRldGVjdGVkIHVzaW5nIGZvdW5k
X2h1bmdfcXVldWUNCj4gPiA+ID4gZmxhZyAyLiBDYWxsIGFtZGdwdV9tZXNfcmVzdW1lKCkgdG8g
cmVzdGFydCBNRVMgc2NoZWR1bGluZyBhZnRlciBjb21wbGV0aW5nDQo+ID4gPiA+ICAgIHRoZSBo
YW5nIHJlY292ZXJ5IHByb2Nlc3MNCj4gPiA+ID4gMy4gVGhpcyBjb21wbGVtZW50cyB0aGUgZXhp
c3RpbmcgcmVjb3Zlcnkgc3RlcHMgKGZlbmNlIGZvcmNlIGNvbXBsZXRpb24NCj4gPiA+ID4gICAg
YW5kIGRldmljZSB3ZWRnaW5nKSBieSBlbnN1cmluZyB0aGUgc2NoZWR1bGVyIGNhbiBwcm9jZXNz
IG5ldw0KPiA+ID4gPiB3b3JrDQo+ID4gPiA+DQo+ID4gPiA+IFdpdGhvdXQgdGhpcyByZXN1bWUg
Y2FsbCwgdGhlIE1FUyBzY2hlZHVsZXIgbWF5IHJlbWFpbiBpbiBhIHBhdXNlZA0KPiA+ID4gPiBz
dGF0ZSBldmVuIGFmdGVyIHRoZSBodW5nIHF1ZXVlIGhhcyBiZWVuIGhhbmRsZWQsIHByZXZlbnRp
bmcgbmV3bHkNCj4gPiA+ID4gc3VibWl0dGVkIHdvcmsgZnJvbSBiZWluZyBwcm9jZXNzZWQgYW5k
IGxlYWRpbmcgdG8gc3lzdGVtIHN0YWxscy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+ID4gPg0KPiA+ID4gQWNrZWQt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiA+DQo+ID4g
PiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1
ZS5jIHwgNyArKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
ZXNfdXNlcnF1ZXVlLmMNCj4gPiA+ID4gaW5kZXggYjFlZTk0NzNkNjI4Li42ZDFhZjcyOTE2YTUg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2Vy
cXVldWUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNl
cnF1ZXVlLmMNCj4gPiA+ID4gQEAgLTIwOCw2ICsyMDgsNyBAQCBzdGF0aWMgaW50IG1lc191c2Vy
cV9kZXRlY3RfYW5kX3Jlc2V0KHN0cnVjdA0KPiA+ID4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
PiA+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgaHVuZ19kYl9udW0gPSAwOw0KPiA+ID4gPiAgICAg
ICAgIHVuc2lnbmVkIGxvbmcgcXVldWVfaWQ7DQo+ID4gPiA+ICAgICAgICAgdTMyIGRiX2FycmF5
WzhdOw0KPiA+ID4gPiArICAgICAgIGJvb2wgZm91bmRfaHVuZ19xdWV1ZSA9ZmFsc2U7DQo+ID4g
PiA+ICAgICAgICAgaW50IHIsIGk7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgaWYgKGRiX2Fy
cmF5X3NpemUgPiA4KSB7DQo+ID4gPiA+IEBAIC0yMzIsNiArMjMzLDcgQEAgc3RhdGljIGludCBt
ZXNfdXNlcnFfZGV0ZWN0X2FuZF9yZXNldChzdHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsg
aSA8IGh1bmdfZGJfbnVtOyBpKyspIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChxdWV1ZS0+ZG9vcmJlbGxfaW5kZXggPT0gZGJfYXJyYXlbaV0p
IHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcXVldWUtPnN0YXRlID0NCj4gPiA+ID4gQU1ER1BVX1VTRVJRX1NUQVRFX0hVTkc7DQo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvdW5k
X2h1bmdfcXVldWUgPQ0KPiA+ID4gPiArIHRydWU7DQo+ID4gPiA+DQo+ID4gPiA+IGF0b21pY19p
bmMoJmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4gPiA+ID4NCj4gPiA+IGFtZGdwdV91c2Vy
cV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihxdWV1ZSk7DQo+ID4gPiA+DQo+ID4gPiA+
IGRybV9kZXZfd2VkZ2VkX2V2ZW50KGFkZXZfdG9fZHJtKGFkZXYpLA0KPiA+ID4gRFJNX1dFREdF
X1JFQ09WRVJZX05PTkUsIE5VTEwpOyBAQCAtMjQxLDYgKzI0MywxMSBAQCBzdGF0aWMgaW50DQo+
ID4gPiBtZXNfdXNlcnFfZGV0ZWN0X2FuZF9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwNCj4gPiA+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+
DQo+ID4gPiA+ICsgICAgICAgaWYgKGZvdW5kX2h1bmdfcXVldWUpIHsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIC8qIFJlc3VtZSBzY2hlZHVsaW5nIGFmdGVyIGhhbmcgcmVjb3ZlcnkgKi8NCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIHIgPSBhbWRncHVfbWVzX3Jlc3VtZShhZGV2KTsNCj4gPiA+
ID4gKyAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAgICByZXR1cm4gcjsNCj4gPiA+
ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi40OS4wDQo+ID4gPiA+DQo+DQoN
Cg==
