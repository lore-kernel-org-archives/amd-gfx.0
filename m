Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A65CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECA810EB0C;
	Thu,  9 Oct 2025 20:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Awm8lwuP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A6710EB0F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT5j/Ss2XIEMsaz6c8qZgro98ue72kkFcRoB6GVW6M8HPsadRre/qrldiLdnqR5/eK7aGrxecyhCqBBPADyBCuvwqsqDccLhF2STTArRLO3t9OWOewQwQit8AkkiTNtCmAkB3hSbXUOW9Yv1p1MrEI3fC7UHH5PWHdK7YpVYf77ll+wYCkjudgsgxzTx5t6+0RiWbe1styjAdPoA/Q+06BkD+bITOwh5W6MIV77QZ0GxSP2iGOFRDLcVcSSQqfHYIli1XS2EKM3rFYv54ZxZG5jxKEugSqh+wCAbDcuwT36icpjSseDZxUzUdPQT6NU1YrkBY+IovH0+gTRNprkrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMRravBACqOA4fOWkrsO8247B5RbofXsCZKMu4wPPbo=;
 b=uTylhDOFWLvYX12FPZJi0klEg3Z7aVI8vdFOcIHI3tP58GR8MH1ndZhKAD3VuikvVhx8WSgvBARKw+t1nnbt6KeGBKCjPCGpxM1DtXBnrCHQnJ7dOyar1iY1AUWeWuIAJlSgeJ5FoNHNZuyx/zGQVLZpGs+YAax1+TUcMNgcaM0DPV40KKTu75Vo/flOryVHo31b5Fqf+arPBMx5MB7ydV6B44PFfjQesH+BT+apBFCn9vQ0jqPUIbZThf0hYdzEnZJ1LRuvGcBlvXEq+PPiSSCC9/4SkxtJtqLT6tHHVxHZWOX1HuKFFvjSW8PVEhKcLkfLobq482/N3KTiPtGcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMRravBACqOA4fOWkrsO8247B5RbofXsCZKMu4wPPbo=;
 b=Awm8lwuPkfFL0D3YpyQ+8ni8YPfdA8Y4G4i2M9Nx2ocAinIgAUK5UAZk0PPdan5zHReQt1Diic5h7xWc/dUU6/vJcEAtWGrZB2wiuuBrIJ8xFHm0DQ2kmGfCVO+g8wfx9u4X/x7bSgfWBk/BD4KcUxoLo3Amc2xTW7Jc3N3Zjs0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 20:36:15 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:36:13 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>
Subject: RE: [PATCH 5/6] drm/amdkfd: fix suspend/resume all calls in mes based
 eviction path
Thread-Topic: [PATCH 5/6] drm/amdkfd: fix suspend/resume all calls in mes
 based eviction path
Thread-Index: AQHcOU2Ev2HprOW7J0GhOfVpjfrMKrS6LiOAgAAX2RA=
Date: Thu, 9 Oct 2025 20:36:13 +0000
Message-ID: <CY8PR12MB7099B8302BF005585B3D144D8CEEA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-6-jonathan.kim@amd.com>
 <CADnq5_NB1Tm951Spi60HEBFYykAVGCWtGyNU=ckbqz=Q9qMhRA@mail.gmail.com>
In-Reply-To: <CADnq5_NB1Tm951Spi60HEBFYykAVGCWtGyNU=ckbqz=Q9qMhRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-09T20:35:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|IA1PR12MB7591:EE_
x-ms-office365-filtering-correlation-id: 7bbc38ab-2f65-46c6-8fae-08de07737d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T1Y0MVdaZDhWVkRkR0RYS3E2Sk8yK1RTaWl4SWpqdldzTTh1ZzAvRkhTL1hO?=
 =?utf-8?B?dVh2dWdQT3lKZFYzOXVyNVJjTElLcnJTWjZzcEkzams0Wkk5b0htWnM1U2xP?=
 =?utf-8?B?M1BTQ2FDTi85YVZJeFNXVUhwWjdXKzBONnRKU3NoWG1DYnhkajArdjllOHNG?=
 =?utf-8?B?M2VKWVlVSmttNExidWZnN1laL01zTmJ0QzROTUc4b2RHWlNuNzVaYVgxQ3ZF?=
 =?utf-8?B?a0RONVdoVml6UWh1YzZCdjJyUExUdHdFNkNmQnVsdzFacEV1THBkcnZMc2w2?=
 =?utf-8?B?NUgzL20xUE9ZV3pCQnVxaU42YmFhcFEvMXB4QlVkdHlKOWdhSVpJT0UwUTFu?=
 =?utf-8?B?aW5BWld5VWk3SXBLRkdnQitsZEI3NCsrM01IYzdrK2hiOTkrVHVCRVluekpt?=
 =?utf-8?B?aEpzbFkyd2VucWNzeGhaN0l3MGdGK2FZTjA1cnZhSUFHZEU1eDY0eU5NQmlG?=
 =?utf-8?B?cVFmMGpQWktmKzQrWHlMNEo1eGFtWEY3OXVHVUczUGI1Q3Z2dGNwdHQ0Nmw4?=
 =?utf-8?B?cTY2eDJiSXJsNEhsMzl0VlQ5bVBDcG5ZVm5mVEhRQnRCZHNpL1JCV1lTVVhn?=
 =?utf-8?B?cmFiU25KMkwyb0l5YWJDeEZoOTY4NXB4TFZRbm5aUVRPSWNuOXI4cmREYzBP?=
 =?utf-8?B?MWFLZUc2THFNRjNWRElIS3dBbm5Kbzl5aEtNT2tBQWRzbnZPUmYvTTBONjk4?=
 =?utf-8?B?MUY3ODRyZ1lwRit6Sk9PbC9TQnFiWjdkdXdacnROaFJ3cEhYVU02UHZKWHUr?=
 =?utf-8?B?SGFUbXo4MU5aMEIwWkE3R2duNlIrejhxM0N2M1g5bkRDcUE1cWFKb2ZGNkQx?=
 =?utf-8?B?WGNxZTRvMVQ0VUJkQXJSb3RWQVVoaGR3Vkc1VitSR1hEdTA2cUNBaktNbkhr?=
 =?utf-8?B?bExNZDBYczU1a0JzZzh5VzJZUk1VMDl1cDdtYVo5WjZvdjBOaktSN2pIREJT?=
 =?utf-8?B?alh3eVJOelp0MDBWUStBVldsMnl5SkZEZ3VyK24yNC9uN0l0b2tCNGswMEFX?=
 =?utf-8?B?RWJwYWVvM1QvSS9oR1NOME1vZUZCdVVuSkpnS1p3Y2pKd21HMkdHTkxsWWQy?=
 =?utf-8?B?QXhWYmYxemhaT0J1ZjVkZE9ydzdrOWdCdjcwTXFjVmdiT3BwSFNPdVVnVVh0?=
 =?utf-8?B?SzJsZlZwbVpjSXo4SmY1dElGQzBWcnRxK0R3RWZ1cXhXZHNxYmZ2ZU5WYXRv?=
 =?utf-8?B?elVCWW1sNWt3cFdVYkxGbTY0aUsxSVFCMVR3VlhlU3U3YXorWm51L09pdFZF?=
 =?utf-8?B?U1dTbVhHODI5bzJQQlZtcHdnRjY2SjJoTjdUcFcrSTJRNlVhcm5qckRjdmZX?=
 =?utf-8?B?MDZPK3lKZnhPaXJBRm9DcUhvSk9vcmtZc2tPeWhmQ3BpTTBsYU9IK3RmUUVh?=
 =?utf-8?B?cUVtMWx0eU1VbnduTmN0bUFPQ25Sblkvc3ZnQ3VXZmlwS3ppdWJXaC93bm1Y?=
 =?utf-8?B?T3hIL3NqUFQzdjdMMTlMT3hrZEQ0NUZtMnRhNEhNUDVCcFAvK25RMjRDeVBa?=
 =?utf-8?B?TzlOS2VXbmlsdy8vYzA3cEFIZU5YblNuZHhkUWtwUjVIWUtYQmpEcFZvSUor?=
 =?utf-8?B?dllmQlpKRzRtenNxNVZLYXNpVEh5VFBITDdMalFDaFZuVTlRSW1WVzFQRjl0?=
 =?utf-8?B?VVNFYmEyQ3dkUktaVlBKZGJ4a251YndoMFZtdlkzTWI0K0YzNHhuMVJFUnVi?=
 =?utf-8?B?RERMWTNBNk1Idm5TL0N0TTRQQUlENmhhRnU5aEM4cCtsQklGaldIT3VEWFkv?=
 =?utf-8?B?TzczL0I4Vmx2TytrWW9LZ2FlNUdUb2t0Vm1RaEdOellhNmlFYVhpVG84ZWZy?=
 =?utf-8?B?aFkrY09ROHE0bGg4dzQyU3BZbEZrRG02eTRLM2dneDFXblBPaVkvMXN4eWZ5?=
 =?utf-8?B?TUxCZkI3aE1SVkVmTkw1VFdWOXlVNHpGaFFkNXZoTkx6Rm9xQy9EbUJrZkZN?=
 =?utf-8?B?RXRjcUpqUnhFWGpGVGgwNmZZanhCV1hFdVllMlpnSTZWNm5TRk5HRk9pT2hi?=
 =?utf-8?B?WUliMkt6VlZQcTNFL1JnUlpEY2JMYVFJeDRtWGtrU3F5eGRlN2tFZ1FjQlBa?=
 =?utf-8?Q?2cWWqf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVV1UjhIUUhuVGYxL1d0M252cFcrckIrbmNmNXlFaXhySXdiMzQvYzIyWk81?=
 =?utf-8?B?Zy93YkNrZTJsYmYyVGRhTytQWHl4RThRekRXTlZDQVpCUytHNVBXWWZYb1Qy?=
 =?utf-8?B?RGQvaWRWVm1UWEJhWDg2akgyWWlUcUFZWEV1MTBXb25hV2xVTUtVYk5OVGlE?=
 =?utf-8?B?eWZlSWNkZXVzTXh2LzdWV3FNZDFoZ2NWOFVYQTBxSGFNelNiYlRPTFBQQnp5?=
 =?utf-8?B?VkZlNmdOMU1SR3FEVGt4dE5xUGNQTjhRT29FV3pWbVNieEprZ3JrQjNHMWZR?=
 =?utf-8?B?ZlZWTEl2bUk1OFhrWlNPUzZpODBMSmkrRXhoeVM5TE1OQUpSWjZoVFZ3RTM1?=
 =?utf-8?B?eU9QSFJ2NWk1a09SMEZ2U2lKdFovNmRjT2hWMVFabkpnUzZvOEZiOWpxZFN2?=
 =?utf-8?B?Z0gwd29Lc01IWW5wSUdPVkh0Y0I2VGNlWllvTjdiVDlvQW1PVlhuSFo5NnNF?=
 =?utf-8?B?TFA3ZkhkbTNZRVhZMlNadGFuM3NpTnJNREN1VTFZSzB3YnZCdHQvWHUvK3FG?=
 =?utf-8?B?V0hOODRPYVlad2VHRGxyT0prbHhST0FrZThlQ3hHcEFtYkdlWEhydjRzV0xF?=
 =?utf-8?B?a1F2b2U0Q0JJd2FJaTl0eUdTMDNyWTdYd1gzSnp5dGRvNnI1cmkzUlgza2JQ?=
 =?utf-8?B?K2dqWTZJTXp6Tm11eFoxYmFnaU14VGVYV0hKZVl2ZjFzbGs3QWhURS9SZUly?=
 =?utf-8?B?byszSG5ZQXpXK0Y4TmQ3bnNsVVFyY1QvY25hMkNFNEdTZG9JbWg3N242MHZl?=
 =?utf-8?B?bDJjakorTncxbDhiaGphaGpQMmFhOHBrbWNpN3RlcDZaNGpCTzN3MGIrTFFZ?=
 =?utf-8?B?aHFlVkc3ekszNXM1Z3VmRHZhV2lpSkVrWDNiQjdhNEgwOUFyR2VEbWkvNGhE?=
 =?utf-8?B?TzU1M1NqdFNMK0VMcHRzbEhxQXVReUlaRTZ2SFh1QW1STXpwNXdSY0h2cG5p?=
 =?utf-8?B?QjBpejVRZ0xkY3JseG9XdGVwSGFPQkpScnlkU0hlOVhvQWg0Vi9hb1ZDQ3FV?=
 =?utf-8?B?K0NOQU9vZDAyVWR1L2hXVWFTL0J4Q3lGa2dqUVR0YnJvaGZlUUx5WC9RemtI?=
 =?utf-8?B?Sm1iUUJhdm91Y2RZaGF4ZEs2SWxlNC82Ulk0eE9kTWxvTXVUZmJlMFN0TDQ2?=
 =?utf-8?B?bjAzL2dWM2RsOUowN1UxcUtWQmpMSndJRE5uU0Q2UGpVaE1HWUd5WkY4bzRJ?=
 =?utf-8?B?Q0E4SUVHd3VtTHJhc01YU1VnanU3VWhSeFpyeEZmM3JkTW1BZWNnYzFMU3hi?=
 =?utf-8?B?b0F5dU9BT1gwZXhJeFV5bzZJQ3Y5bjZTM1I5cDJvdFUxemgzREUrNStUUVZr?=
 =?utf-8?B?aVRzZjFDM0g0eTJWQnowU3E2bVJzR3prSFlVblQwUSswL0VuZS8yc2Jlam1r?=
 =?utf-8?B?dHFTM1RsS2M1TTExTnlZaDU0R1ArWkZCZVl0TVo4OXFkckpwWE4vVWFZcTdN?=
 =?utf-8?B?VDV3WjBnQ1VlZDloMVAxblRCK0g1WXJFcVdiR3lxNEU1TDVQSEE5ZDAwMnhS?=
 =?utf-8?B?OFErMDl6aitjOUxZUjFjSWV1SytiTzd6UFNuQXlrWTJRQVppbHZrcnNTcDlY?=
 =?utf-8?B?UENjYUc3VjBLdE1IWEtOSXVHL1lyd3BkWHpVWWp0OVBzTmpSMzdVREV6czhW?=
 =?utf-8?B?cTJobCtZNWVMUkhlQk5UcXgzM1pnMGdDVFRmQmZPWUJzcTBwaS9XdmgycDFT?=
 =?utf-8?B?MGR4NjQxeUNFYWVINXA3QmU4QnMxOXYzMjlzMVd2UDFkLzUrZWJLcE04eUYw?=
 =?utf-8?B?R1MzSTBXY1A4UGcyS0xscnU3S1orMVQwN0oxMUZlTWY1SVFlTDNlMUJWSWpn?=
 =?utf-8?B?MGxXS0RFcDBHb3hrem85aVpWWHl3STZtSWlIaXpRV1h1Z1JJS1N5ZTBJbm10?=
 =?utf-8?B?WHVtU2x2Ri8vWndPdjFBNkxzWks3OWc4Q0JvQi8reWFSdlhSb2NWWDBkYTNJ?=
 =?utf-8?B?c0NCQXppK0Q2ZGFmTldNbHVaalU2dGU4ZitVVlpZRHQ2QXA0T2x3anB1NlpJ?=
 =?utf-8?B?NVF2WDJEUDJ6S1U5MkNDMVN4dG44RnYvYWhKYWNSdUd6VDBzWVpoait4cGNF?=
 =?utf-8?B?djRqTkdRRjh4aTZQTTJxcmxhSmt4WGFxSDF2Y1IrQ0YxV1M0ZytGeERkN01B?=
 =?utf-8?Q?sYOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbc38ab-2f65-46c6-8fae-08de07737d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 20:36:13.7537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9vyUn9/+zq5YJlJbXGX/1iU4cqsscwrMkb+UgXN2M9dtMvTpmZ7y6lI3E4VB8gBjiY9MuJfpVsYuebibQ7y3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
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
Cg0KUmV2aWV3ZWQtYnk6IEhhcmlzaCBLYXNpdmlzd2FuYXRoYW4gPEhhcmlzaC5LYXNpdmlzd2Fu
YXRoYW5AYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
OSwgMjAyNSAzOjEwIFBNDQpUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+
DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1k
LmNvbT47IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFt
ZC5jb20+OyBMaW4sIEFtYmVyIDxBbWJlci5MaW5AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggNS82XSBkcm0vYW1ka2ZkOiBmaXggc3VzcGVuZC9yZXN1bWUgYWxsIGNhbGxzIGluIG1lcyBi
YXNlZCBldmljdGlvbiBwYXRoDQoNCk9uIFRodSwgT2N0IDksIDIwMjUgYXQgMjo1MOKAr1BNIEpv
bmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBTdXNwZW5kL3Jl
c3VtZSBhbGwgZ2FuZ3Mgc2hvdWxkIGJlIGRvbmUgd2l0aCB0aGUgZGV2aWNlIGxvY2sgaXMgaGVs
ZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNv
bT4NCg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cg0KPiAtLS0NCj4gIC4uLi9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YyB8IDczICsrKysrKy0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRp
b25zKCspLCA1MiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gaW5kZXggNmM1YzdjMWJm
NWVkLi42ZTdiYzk4M2ZjMGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+IEBAIC0xMjA5LDYgKzEyMDks
MTUgQEAgc3RhdGljIGludCBldmljdF9wcm9jZXNzX3F1ZXVlc19jcHNjaChzdHJ1Y3QgZGV2aWNl
X3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4gICAgICAgICBwcl9kZWJ1Z19yYXRlbGltaXRlZCgiRXZp
Y3RpbmcgcHJvY2VzcyBwaWQgJWQgcXVldWVzXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGRkLT5wcm9jZXNzLT5sZWFkX3RocmVhZC0+cGlkKTsNCj4NCj4gKyAgICAgICBpZiAo
ZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKSB7DQo+ICsgICAgICAg
ICAgICAgICBwZGQtPmxhc3RfZXZpY3RfdGltZXN0YW1wID0gZ2V0X2ppZmZpZXNfNjQoKTsNCj4g
KyAgICAgICAgICAgICAgIHJldHZhbCA9IHN1c3BlbmRfYWxsX3F1ZXVlc19tZXMoZHFtKTsNCj4g
KyAgICAgICAgICAgICAgIGlmIChyZXR2YWwpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2VycihkZXYsICJTdXNwZW5kaW5nIGFsbCBxdWV1ZXMgZmFpbGVkIik7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAgICAg
IH0NCj4gKw0KPiAgICAgICAgIC8qIE1hcmsgYWxsIHF1ZXVlcyBhcyBldmljdGVkLiBEZWFjdGl2
YXRlIGFsbCBhY3RpdmUgcXVldWVzIG9uDQo+ICAgICAgICAgICogdGhlIHFwZC4NCj4gICAgICAg
ICAgKi8NCj4gQEAgLTEyMjEsMjMgKzEyMzAsMjcgQEAgc3RhdGljIGludCBldmljdF9wcm9jZXNz
X3F1ZXVlc19jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4gICAgICAg
ICAgICAgICAgIGRlY3JlbWVudF9xdWV1ZV9jb3VudChkcW0sIHFwZCwgcSk7DQo+DQo+ICAgICAg
ICAgICAgICAgICBpZiAoZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVz
KSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGludCBlcnI7DQo+IC0NCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgZXJyID0gcmVtb3ZlX3F1ZXVlX21lcyhkcW0sIHEsIHFwZCk7DQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dmFsID0gcmVtb3ZlX3F1ZXVlX21lcyhkcW0sIHEsIHFwZCk7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChyZXR2YWwpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBldmljdCBxdWV1ZSAlZFxuIiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHEtPnByb3BlcnRpZXMucXVldWVfaWQp
Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHZhbCA9IGVycjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4gLSAgICAgICBw
ZGQtPmxhc3RfZXZpY3RfdGltZXN0YW1wID0gZ2V0X2ppZmZpZXNfNjQoKTsNCj4gLSAgICAgICBp
ZiAoIWRxbS0+ZGV2LT5rZmQtPnNoYXJlZF9yZXNvdXJjZXMuZW5hYmxlX21lcykNCj4gKw0KPiAr
ICAgICAgIGlmICghZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKSB7
DQo+ICsgICAgICAgICAgICAgICBwZGQtPmxhc3RfZXZpY3RfdGltZXN0YW1wID0gZ2V0X2ppZmZp
ZXNfNjQoKTsNCj4gICAgICAgICAgICAgICAgIHJldHZhbCA9IGV4ZWN1dGVfcXVldWVzX2Nwc2No
KGRxbSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFw
ZC0+aXNfZGVidWcgPw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgS0ZEX1VOTUFQX1FVRVVFU19GSUxURVJfQUxMX1FVRVVFUyA6DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBLRkRfVU5NQVBfUVVFVUVTX0ZJTFRF
Ul9EWU5BTUlDX1FVRVVFUywgMCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFVTRV9ERUZBVUxUX0dSQUNFX1BFUklPRCk7DQo+ICsgICAgICAgfSBlbHNl
IHsNCj4gKyAgICAgICAgICAgICAgIHJldHZhbCA9IHJlc3VtZV9hbGxfcXVldWVzX21lcyhkcW0p
Ow0KPiArICAgICAgICAgICAgICAgaWYgKHJldHZhbCkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsICJSZXN1bWluZyBhbGwgcXVldWVzIGZhaWxlZCIpOw0KPiArICAgICAg
IH0NCj4NCj4gIG91dDoNCj4gICAgICAgICBkcW1fdW5sb2NrKGRxbSk7DQo+IEBAIC0zMDk4LDYx
ICszMTExLDE3IEBAIGludCBrZmRfZHFtX3N1c3BlbmRfYmFkX3F1ZXVlX21lcyhzdHJ1Y3Qga2Zk
X25vZGUgKmtub2RlLCB1MzIgcGFzaWQsIHUzMiBkb29yYmVsDQo+ICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gIH0NCj4NCj4gLXN0YXRpYyBpbnQga2ZkX2RxbV9ldmljdF9wYXNpZF9tZXMoc3RydWN0
IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IHFjbV9wcm9jZXNzX2RldmljZSAqcXBkKQ0KPiAtew0KPiAtICAgICAg
IHN0cnVjdCBkZXZpY2UgKmRldiA9IGRxbS0+ZGV2LT5hZGV2LT5kZXY7DQo+IC0gICAgICAgaW50
IHJldCA9IDA7DQo+IC0NCj4gLSAgICAgICAvKiBDaGVjayBpZiBwcm9jZXNzIGlzIGFscmVhZHkg
ZXZpY3RlZCAqLw0KPiAtICAgICAgIGRxbV9sb2NrKGRxbSk7DQo+IC0gICAgICAgaWYgKHFwZC0+
ZXZpY3RlZCkgew0KPiAtICAgICAgICAgICAgICAgLyogSW5jcmVtZW50IHRoZSBldmljdGVkIGNv
dW50IHRvIG1ha2Ugc3VyZSB0aGUNCj4gLSAgICAgICAgICAgICAgICAqIHByb2Nlc3Mgc3RheXMg
ZXZpY3RlZCBiZWZvcmUgaXRzIHRlcm1pbmF0ZWQuDQo+IC0gICAgICAgICAgICAgICAgKi8NCj4g
LSAgICAgICAgICAgICAgIHFwZC0+ZXZpY3RlZCsrOw0KPiAtICAgICAgICAgICAgICAgZHFtX3Vu
bG9jayhkcW0pOw0KPiAtICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+IC0gICAgICAgfQ0KPiAt
ICAgICAgIGRxbV91bmxvY2soZHFtKTsNCj4gLQ0KPiAtICAgICAgIHJldCA9IHN1c3BlbmRfYWxs
X3F1ZXVlc19tZXMoZHFtKTsNCj4gLSAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAgICAg
ICBkZXZfZXJyKGRldiwgIlN1c3BlbmRpbmcgYWxsIHF1ZXVlcyBmYWlsZWQiKTsNCj4gLSAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiAtICAgICAgIH0NCj4gLQ0KPiAtICAgICAgIHJldCA9IGRx
bS0+b3BzLmV2aWN0X3Byb2Nlc3NfcXVldWVzKGRxbSwgcXBkKTsNCj4gLSAgICAgICBpZiAocmV0
KSB7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkV2aWN0aW5nIHByb2Nlc3MgcXVl
dWVzIGZhaWxlZCIpOw0KPiAtICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+IC0gICAgICAgfQ0K
PiAtDQo+IC0gICAgICAgcmV0ID0gcmVzdW1lX2FsbF9xdWV1ZXNfbWVzKGRxbSk7DQo+IC0gICAg
ICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiUmVzdW1pbmcgYWxs
IHF1ZXVlcyBmYWlsZWQiKTsNCj4gLQ0KPiAtb3V0Og0KPiAtICAgICAgIHJldHVybiByZXQ7DQo+
IC19DQo+IC0NCj4gIGludCBrZmRfZXZpY3RfcHJvY2Vzc19kZXZpY2Uoc3RydWN0IGtmZF9wcm9j
ZXNzX2RldmljZSAqcGRkKQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBkZXZpY2VfcXVldWVfbWFu
YWdlciAqZHFtOw0KPiAgICAgICAgIHN0cnVjdCBrZmRfcHJvY2VzcyAqcDsNCj4gLSAgICAgICBp
bnQgcmV0ID0gMDsNCj4NCj4gICAgICAgICBwID0gcGRkLT5wcm9jZXNzOw0KPiAgICAgICAgIGRx
bSA9IHBkZC0+ZGV2LT5kcW07DQo+DQo+ICAgICAgICAgV0FSTihkZWJ1Z19ldmljdGlvbnMsICJF
dmljdGluZyBwaWQgJWQiLCBwLT5sZWFkX3RocmVhZC0+cGlkKTsNCj4NCj4gLSAgICAgICBpZiAo
ZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKQ0KPiAtICAgICAgICAg
ICAgICAgcmV0ID0ga2ZkX2RxbV9ldmljdF9wYXNpZF9tZXMoZHFtLCAmcGRkLT5xcGQpOw0KPiAt
ICAgICAgIGVsc2UNCj4gLSAgICAgICAgICAgICAgIHJldCA9IGRxbS0+b3BzLmV2aWN0X3Byb2Nl
c3NfcXVldWVzKGRxbSwgJnBkZC0+cXBkKTsNCj4gLQ0KPiAtICAgICAgIHJldHVybiByZXQ7DQo+
ICsgICAgICAgcmV0dXJuIGRxbS0+b3BzLmV2aWN0X3Byb2Nlc3NfcXVldWVzKGRxbSwgJnBkZC0+
cXBkKTsNCj4gIH0NCj4NCj4gIGludCByZXNlcnZlX2RlYnVnX3RyYXBfdm1pZChzdHJ1Y3QgZGV2
aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4gLS0NCj4gMi4zNC4xDQo+DQo=
