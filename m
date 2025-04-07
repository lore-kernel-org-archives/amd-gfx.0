Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054E2C369A2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AE310E4F9;
	Mon,  7 Apr 2025 15:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XON2oKQg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C7D10E4ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 15:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/QcbuDXDk4EmPEXLvUMLdjhlgx9HRe9312S2uusJ0ktsuxaKb2IBBUsazmuMxNYMOsMAjSgbEprMHlcTJXnQmZo1QDLnlFGxcnMTxXg8h9qTx5WnJLnRQOcWuLqIMaKav7NIR4K9BQ7f8NGHmUtvTlUTGsCB53yLBTKuaYJKYq1yf5PzEQAMoJ3lJUeQ5VhIhokPkWQVrZJ2EdUoCCpwUWUZavi0Wwv7Lt4jl3GV8SW/XJ3sja6oPz3pMGOfxQLQGzZd0Lj4RguQAp2/SPMQxnkrdqLhza1OddGZL9udjkDQkhRli+dBfXggdRTIFL3x2QtlMDgCmndn+FALxHAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g75NFfz/vMSPnQGyAmb77N8BPASrlP962UDQkG0qbU=;
 b=aG5RXL1qL/zwp7GgLcncJuZHvG+UGYtRvVCj+hcKj2dtoivWYqI61uzOQejS0Ngq4n41cDsiic74d/Qyf9AJ1BgCF9LaOpLkHhLbWAWFxcor6e6dFuhKnUhNRX9v9iMcCw3lkexry7ygybikPM6EBf2yMYLKjPaWXAIBbqWGA6/n8K2zsLR5Bstd4xT0Fx6OmxGs72XVCiJn+3n0nU8rfOT46NkkoaXhpE5mbzhEtl8NncrSLJg9pgpRPKiyClGviSOb91yH7jEk0lys2lA02XKfBwQVVqyELUIHEPmmge5MqJ/NYNMe75ISqzwKLT2j6kmHhOJU9DMp/1XUyi1zdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g75NFfz/vMSPnQGyAmb77N8BPASrlP962UDQkG0qbU=;
 b=XON2oKQgWZMkJCEwHQNKMnE+m3PAvNgXNiqTWGcAiMDslFH0u1bKaiagXjMSRi7QJJcqFqFayzfi09jqON9PXfHPEY6XirkmtzwlfjQyMZ+RLJqrlds07vyNdQurV06bEQILlI35Aa6Zl5g0oeVVZF/asE3LDBRePQs0nEFFvps=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 15:12:07 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 15:12:06 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: optimize MES pipe FW version
 fetching
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: optimize MES pipe FW version
 fetching
Thread-Index: AQHbn+KddSPvoYGnPEi29QMitU3TVbOYT7yAgAAPOdA=
Date: Mon, 7 Apr 2025 15:12:06 +0000
Message-ID: <CH0PR12MB537278FF78EF8BD39465B455F4AA2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250328130857.4071486-1-alexander.deucher@amd.com>
 <20250328130857.4071486-2-alexander.deucher@amd.com>
 <CADnq5_Maeuqh+ywWsoR0LcSOnggT3ALtE3uwL-9GHfFhc3L9+Q@mail.gmail.com>
In-Reply-To: <CADnq5_Maeuqh+ywWsoR0LcSOnggT3ALtE3uwL-9GHfFhc3L9+Q@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a9dedf51-5233-4460-84f5-8ea69c1266dc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-07T15:11:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SN7PR12MB7978:EE_
x-ms-office365-filtering-correlation-id: 8a222e65-0b4a-4ca9-3c82-08dd75e68f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEdEb2E5ODZLNDJBcUxIcmFGTmZZQ0trZGlIMnUrNHM4S0dKdkVENlg3RlNi?=
 =?utf-8?B?T2dmM1dndVFvRnEreVlCcDFvTkZNUFcwNGQwTXlaYkdlOWlmM0x2SU5CWEdu?=
 =?utf-8?B?M2NUcHJpNk1ncVh2UW5hVzc2Ky9iZHh4c1ZHL3I1SXRlck1yRWNYb3lHLzN1?=
 =?utf-8?B?UndlaGgvWllEUWFFTk1Wci9FSjRaMlp0eFl1L3drS2J4STFIVHB5bjdCVGdE?=
 =?utf-8?B?ajBNNFhKR2wvUG94UDU0NVJITnQwRThaN2hCSHVvNjlrTzFzWkFBdVQyQTRP?=
 =?utf-8?B?VGJFWmlRZlEyR0FtZzJ1enB0eTNOanRkWHA1RHp1OEgybjRHTmNScjNSUDZn?=
 =?utf-8?B?OVVESGRxMERMMzBsT1UwaE1QNzJKcFVreTJyWVF2NnpsNGw3Snd3dU9XU3JE?=
 =?utf-8?B?ZEg3ZzRvOHZNTE9QZHBLRzF3d211VFhWWWZaRnBzRkd2ZFhkcXpKVFlsU3ZW?=
 =?utf-8?B?R3Jqa2VUQlVneXA0OFROZXVCZENrN0dSWHR0L3NYd2J2M05lZC8zM2lvNW9L?=
 =?utf-8?B?QnFvRkl1cVdzQjl4WWZTalIrazVrK3ZseFlZcjZSSFBaQlB5MHFPQUthWExw?=
 =?utf-8?B?OXc5UWNoaERyQ1U3cXFxMm93aGMwdFliLzFSUWUyKzllVHRjY2RRaTMrVExI?=
 =?utf-8?B?TWdyaDRaUVd1dVhaUDRuTG82bldnaEYwRENYMmhmZSsrTjZ3akR6UlMvWnIy?=
 =?utf-8?B?ZnIrbFhyOWd5WWxiU1psWm80bkVDbnJPQlhUQXVlYi9UZ0VLV0M5S21kUE10?=
 =?utf-8?B?R1lEU0xETzFWUGVwOFRDYjhwL2VYcWJTUnZRSTlmeWhkbnArYytOY0I4SE9q?=
 =?utf-8?B?bTVVQ0ZuYjR4YnRJR0k0M3dsUWlTeWFldVdYa1VmZVRYWHVQYjVEaXVNcTFw?=
 =?utf-8?B?eHl1SmlGd2FFdFY3VXUxVmpxc25BYm5kcWl5M3ZEOVJHYWZjQWM4TXp5cmI1?=
 =?utf-8?B?R1pPSk4wMVVLMjhUbWMySE1NSEN2RHdnckI4OWJEc05najBYMERna2gyKzNV?=
 =?utf-8?B?YnVBNzZ1MjUramk3NlBXY2lMRmd0dzdFTCtMTFNKdjNYM1NMcjhMYlR4MDN1?=
 =?utf-8?B?TzByeXBsVTBic3BxNXNtcTh0WE1LMWpPUU9sN2Y3NGZKc0RuOE1ySHU0amIr?=
 =?utf-8?B?U0JJTlphYzRMSVUvRW1KQ0NNaGRIL0d3RWdIZFo3ZE9oY1NyRm9YWHhEc1BP?=
 =?utf-8?B?M3pLTDdKcldrNGoxcmwvcEZuRTZRcTFDWUMrMlFNRFBIVHVKS21MdTV5Skx6?=
 =?utf-8?B?bTEremhtbzByVUN3TEppZnZFRUlWaG9RYS90TC81a2RRSElIeGJ1dDFFRGdu?=
 =?utf-8?B?bllqQ2s1VC9EaXJaZDBpNlJjNUxLNU53WDJYcHJtL3hyL05GdkNtZ0ViY1ho?=
 =?utf-8?B?WmZWMDVaYU0xUVA0Mm8yRnA4SHFXUHFlYUFiYnhjWS9zZHBNZ2dJcmFNZTU5?=
 =?utf-8?B?MUpFQzRVRzByNU1GOWZKS0RkL0pxZUVKTjhncC9zRjlnTUxzbW90aE9odWNn?=
 =?utf-8?B?bllHYVpTRmdDSG5aMFF4K1FkMFExVitCTmRMOThXbjNBMGY3VFh5TGU5RVUy?=
 =?utf-8?B?QmdsQWFGS0dZVXhTeEFJQzQ3bHhsN09MM2VJOXFtK1VvMXJ3aWJEM1U0ZU5X?=
 =?utf-8?B?cktUSmpFQlFlRDBNN2ZrUnhEVGRab1pMNEFWNmVZOHhTVmlTc2FJT1VHYmFz?=
 =?utf-8?B?clQxU0VGaWJKUm5NUFV0U0R5VzBCckpkak1ONkdZcENWQldyMXMwNXNibi9W?=
 =?utf-8?B?ZGVGVGpXRkxPZkVBVXAxeE8xWkM1ckhZWk92VUlOcHhpYVpXdm5KbFMxRVBu?=
 =?utf-8?B?Z0s4bE9XWWpSbFQxY1NKcCtoY0J3ZldBK0FGcUFMeDF1ZEJlZFFENG42Si82?=
 =?utf-8?B?SEw5UmJjcTFiRENQL09CUTQ2MmtuWmMrYzFNSEJOSlo2cG5qYXdSYzVxbEE3?=
 =?utf-8?Q?plFPn2SQdLwmLnZhYhsUMb1YequmEO9c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1dERGVZaGxQdWtPeVVKWFVZUnJaNVN5WUNDdmJjbm1yTzdVeUhpZDdvRTh5?=
 =?utf-8?B?RGl0K0QvU1cyaXp6UU5kR1JxVHFzZWFiSjc0cGgwbm9ybG4yUnBBMzJZN0Jh?=
 =?utf-8?B?dEtVNjZLdXU4ZFFoS01QMVIwdWN3aWwxd0NGS3E3NEZCd3FHR3pPWHJsRG8z?=
 =?utf-8?B?UmpOTVNwTnM3d0ltYU1rTEI0bWc0ZnRHMTVXdkZIaWtEc3ovSzRrN1VSUnpH?=
 =?utf-8?B?Q3RXWVZ5bFdQaSt0Z2crZm1vQXRvYmRMVUJzUWdwdnlZRWtyaTNCcnhCalh4?=
 =?utf-8?B?YmlDeVpxRlozeEtHL1pLVHZ1V1N2NHo0L0ZaQW1PSEpDZkZ1L1pqRnkremtV?=
 =?utf-8?B?ZWY1REp1N1llUjVDNGxnek14aWFwYnBHKzFkakpkTVYwTzY0RTEzOXhuQjBV?=
 =?utf-8?B?VUR3MDVxQW9BQXRxdjlhQ1JreEZVVGNsSjlveFNqRXY3djA5dU1jNjYvdEN1?=
 =?utf-8?B?NktrSlNXbkU0bDg5OFByTHBCcEc5Q2c5KzJOdWtsVlpWa2JqU2xXVEo5Z2U3?=
 =?utf-8?B?cy9jUEtuVkJzckZIY0JJOEhONWdPRVpJMTFzNGQ2UnNmcXRtMFdYWGNRNGFI?=
 =?utf-8?B?dVZrV2czTjNTL1JRU1hmZVU3cy9USzNxVWtVdGlDNnRZWU9salhPbVNrQy9S?=
 =?utf-8?B?aFNFdkt2R2YxblZXVlhsdUdMWEEyNEsyRzZtdFMxV2l3SEdBamNQOFUwMXRt?=
 =?utf-8?B?YmR2RDlSNi9aTml1akpwZ0pBZlhTME5SR29WUyt3U3pLcnU2d1U1Vkd5M3ha?=
 =?utf-8?B?d2NFQ3M4cUhZM1pPaDNuVi9FbTk2VnNyaHVkZXREaGpQVXZoQmNud2FmcUNJ?=
 =?utf-8?B?alFjb1BKcUpDWHpuWTdrUHJlVlh3SE05MEFBTStMeDd0MWVJMWFobjFKMEM5?=
 =?utf-8?B?OGdaS3R3cDVLQWVDeHJGTFltSGUvTFBDNEZNa1ZiY2JBTHdqTU4wbmxnZkwv?=
 =?utf-8?B?SE04OHRzeElkQlBnSjFXWWNwa0FsNHltWktTN1JxdzcrcE5zMjFYUnNvU1FV?=
 =?utf-8?B?SE9MTTNxOHU4SkQ2MjJtWTdWbEY2Z3MySjhJVSt6a3lZMjNMNE5IL2oxcE9z?=
 =?utf-8?B?b1hpc09LT2NjR3QzQnNkbFF2NXFDUTVJRUVyS3JPTER0cUlOMytYaUZydlB2?=
 =?utf-8?B?SlNGVUI0QnR4VW5OeUVSM2s3eDgwdDVKVnM2SGRuWTVWUGZQY1VQanlKZVpj?=
 =?utf-8?B?SW5rdldPQi9uZWlkSitPL0hUTmwrU2lLM2M0VjRBWG5YWGlDQTU3ampDZU1j?=
 =?utf-8?B?ZXBXMkdvQUJXNHRVSnJETmZUN2N0TDl1VWd5UGg0NHVuRnhuUUhWaElHY0FQ?=
 =?utf-8?B?MXRCQmVjaWcxdkRDb1JqL3A1ZmU5SmRtcEdCTDJKZytIV3hXcTRxMkVaWndO?=
 =?utf-8?B?WXVOazAxbkpqTkY1MTBNY2NISFNCS3dPRmRqRldZOWt3QVZyZ0hLaEh6TUE0?=
 =?utf-8?B?eUJhNVZuRTN5dldGQTNyZXZBakpuUHdpKzhGOEQ4dDEzd1JaeUxCd3RuUkhw?=
 =?utf-8?B?QmREbXFyNFdHVGJNbVI4TTdUMlZIRWQxLytlbUcxWG9HNFZGa1ZPT0k3eTZx?=
 =?utf-8?B?ZVZleTh1TnU5ZUJEL2xUYytQa2pSZGtrQmRDMmVWbTNTbkoxSTB0V2tYOUZV?=
 =?utf-8?B?NFFNb1pTS3ZoMVZTVXJHbHhuUHFvdlExVXNzdEZoSDRjaGU1aW9BY1k2VC9j?=
 =?utf-8?B?K1VxN2F4YlAyMHdBbHFrMjQvY1JaS2haeFgwL21JMXllVnBTODY4dE8ySzUx?=
 =?utf-8?B?ZFBGV1h6NkRCZkVRcVlmMzdBVWsvbzlZbEpBeGgyM1BrWUhlejM4cm1mcGRI?=
 =?utf-8?B?S3BKb3B2aitSUUM0Q0RkUjc2c1g3azZPUktpMVpLTi9vMHBYMlNIenJUZm1y?=
 =?utf-8?B?SUpPWisrbFUxM1F3ZDhiMnVTRE1DaTN2dUZBOGZZWUx5NUtUOWdRVVdvbE5I?=
 =?utf-8?B?VHdyRzlsMHpBOTA5MTZlWnhlTG5vNkNwWjBVaVhaOFVWcVBPbUdqOVdJZ21U?=
 =?utf-8?B?cGJwQXRJUXJwMERtd0JNVFowQWpRNFltanprR1dJYnFjVzhBWFpxWHFyLzNj?=
 =?utf-8?B?alZJQWs2ckVGRVZOR2hsdEYzNHJpaVFCdkEzd1JmQ1lHemRmY0JQbmZEdmFX?=
 =?utf-8?Q?I+sg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a222e65-0b4a-4ca9-3c82-08dd75e68f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 15:12:06.5030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 875ZklXtOKHwWcQOF3ZnV7dq6c0WKE8StENFrZEJXXXV6gtz+I/QwWEm39VxCrVfbJeAU5JAtxe23+PAux06VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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
Cg0KTG9va3MgZ29vZCB0byBtZSAuDQoNClJldmlld2VkIGJ5IDogU2hhb3l1bi5saXUgPFNoYW95
dW4ubGl1QGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQt
Z2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Yg
QWxleCBEZXVjaGVyDQpTZW50OiBNb25kYXksIEFwcmlsIDcsIDIwMjUgMTA6MTcgQU0NClRvOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1k
Z3B1L21lczEyOiBvcHRpbWl6ZSBNRVMgcGlwZSBGVyB2ZXJzaW9uIGZldGNoaW5nDQoNClBpbmc/
DQoNCkFsZXgNCg0KT24gRnJpLCBNYXIgMjgsIDIwMjUgYXQgOTowOeKAr0FNIEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IERvbid0IGZldGNoIGl0
IGFnYWluIGlmIHdlIGFscmVhZHkgaGF2ZSBpdC4gIEl0IHNlZW1zIHRoZSByZWdpc3RlcnMNCj4g
ZG9uJ3QgcmVsaWFibHkgaGF2ZSB0aGUgdmFsdWUgYXQgcmVzdW1lIGluIHNvbWUgY2FzZXMuDQo+
DQo+IEZpeGVzOiA3ODVmMGY5ZmU3NDIgKCJkcm0vYW1kZ3B1OiBBZGQgbWVzIHYxMl8wIGlwIGJs
b2NrIHN1cHBvcnQNCj4gKHY0KSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdjEyXzAuYyB8IDIxICsrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+IGluZGV4IGJjYWJlYmQxOGZlODQuLjg4OTI4
NThjZmQ5YWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192
MTJfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+
IEBAIC0xMzkyLDE3ICsxMzkyLDIwIEBAIHN0YXRpYyBpbnQgbWVzX3YxMl8wX3F1ZXVlX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAgICBtZXNfdjEyXzBf
cXVldWVfaW5pdF9yZWdpc3RlcihyaW5nKTsNCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAgLyog
Z2V0IE1FUyBzY2hlZHVsZXIvS0lRIHZlcnNpb25zICovDQo+IC0gICAgICAgbXV0ZXhfbG9jaygm
YWRldi0+c3JibV9tdXRleCk7DQo+IC0gICAgICAgc29jMjFfZ3JibV9zZWxlY3QoYWRldiwgMywg
cGlwZSwgMCwgMCk7DQo+ICsgICAgICAgaWYgKCgocGlwZSA9PSBBTURHUFVfTUVTX1NDSEVEX1BJ
UEUpICYmICFhZGV2LT5tZXMuc2NoZWRfdmVyc2lvbikgfHwNCj4gKyAgICAgICAgICAgKChwaXBl
ID09IEFNREdQVV9NRVNfS0lRX1BJUEUpICYmICFhZGV2LT5tZXMua2lxX3ZlcnNpb24pKSB7DQo+
ICsgICAgICAgICAgICAgICAvKiBnZXQgTUVTIHNjaGVkdWxlci9LSVEgdmVyc2lvbnMgKi8NCj4g
KyAgICAgICAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOw0KPiArICAgICAg
ICAgICAgICAgc29jMjFfZ3JibV9zZWxlY3QoYWRldiwgMywgcGlwZSwgMCwgMCk7DQo+DQo+IC0g
ICAgICAgaWYgKHBpcGUgPT0gQU1ER1BVX01FU19TQ0hFRF9QSVBFKQ0KPiAtICAgICAgICAgICAg
ICAgYWRldi0+bWVzLnNjaGVkX3ZlcnNpb24gPSBSUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0NQX01F
U19HUDNfTE8pOw0KPiAtICAgICAgIGVsc2UgaWYgKHBpcGUgPT0gQU1ER1BVX01FU19LSVFfUElQ
RSAmJiBhZGV2LT5lbmFibGVfbWVzX2tpcSkNCj4gLSAgICAgICAgICAgICAgIGFkZXYtPm1lcy5r
aXFfdmVyc2lvbiA9IFJSRUczMl9TT0MxNShHQywgMCwgcmVnQ1BfTUVTX0dQM19MTyk7DQo+ICsg
ICAgICAgICAgICAgICBpZiAocGlwZSA9PSBBTURHUFVfTUVTX1NDSEVEX1BJUEUpDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGFkZXYtPm1lcy5zY2hlZF92ZXJzaW9uID0gUlJFRzMyX1NPQzE1
KEdDLCAwLCByZWdDUF9NRVNfR1AzX0xPKTsNCj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKHBp
cGUgPT0gQU1ER1BVX01FU19LSVFfUElQRSAmJiBhZGV2LT5lbmFibGVfbWVzX2tpcSkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgYWRldi0+bWVzLmtpcV92ZXJzaW9uID0gUlJFRzMyX1NPQzE1
KEdDLCAwLA0KPiArIHJlZ0NQX01FU19HUDNfTE8pOw0KPg0KPiAtICAgICAgIHNvYzIxX2dyYm1f
c2VsZWN0KGFkZXYsIDAsIDAsIDAsIDApOw0KPiAtICAgICAgIG11dGV4X3VubG9jaygmYWRldi0+
c3JibV9tdXRleCk7DQo+ICsgICAgICAgICAgICAgICBzb2MyMV9ncmJtX3NlbGVjdChhZGV2LCAw
LCAwLCAwLCAwKTsNCj4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmYWRldi0+c3JibV9t
dXRleCk7DQo+ICsgICAgICAgfQ0KPg0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAtLQ0K
PiAyLjQ5LjANCj4NCg==
