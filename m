Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1AEC38150
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 07:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D6110E0B8;
	Wed, 10 Jul 2024 07:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rrbs5EYJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA7310E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 07:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ5lIdakJqO9A/9uglvkcRLKpu1LVTlBaiYq6zv/t2hR+2p3PNcKJ8OFQSml8E7HqgK7Pp15e/LROOvVrVEkNbRrzy55Hy8q7NcliYVxrH+/RcCqYgjC46Y6mg3FJ78PxWMo9YS1dLyHzR3Ylaqh8tWyjKnNuqdwQLVT1t8FJNtVArucFGgK7BX8dZOQbBJzUnDxHu2gb8j5HuDtKZiixAo6tLUeAg1G7Sdy5Orl5Y6ZTXoz+elgeN7EmQHuy7L40OpUnwAFKXu7MuhbRjZiO5hMGYptkdItQpRRYL8DYZ3ynI/3+zG1xW3hemlf4feNwDcVudyLhdRM2AF01KFiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tzG6OGnzVdpfHS3CRBrelBO+/ymVy5Den9ow4QeoEU=;
 b=Tq0s9Cx4/5llGsRJm11x057vCgj8mc8s8f91tRVrSM4Ys93YU2GvtRq+pDaOuTFVbOiKfSY+skgnnUCYwamkEZc6H1pGJIVvrkLpEfyLFiqu8/jiMdihyc2TKdUpEw0KYtKmtCdOHo0FO14BpRNbPxxhsWxRutkgZRya1PiLaGfGq4wPUHhv9bl6IPgefaL2Oa6U2WO9V2SEX9IbEMMFfex1D9eEoIDiXvpu9xVlY069PwEYr9q3Gd03akKvtBqe6lZsNmG+Lmd602C3Y15GvUOIaS3hksRF9iZCqH1twhOYjqD6ZLKw9U606aGUFRszqn6LrSiiDHQ206+7kd+GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tzG6OGnzVdpfHS3CRBrelBO+/ymVy5Den9ow4QeoEU=;
 b=Rrbs5EYJS8e9UZNoFc255qG+Z8jqHPWiGp0SE+XnJCoCGCmD0Mvpl0u5qgagkgwlQUruoQOrglLIgRUnNyquOqEaWIrJoE5TF2b4dCYAOMGPOT1Ga8PecW0x6c3V2Wj9na9GfWxZ0U57ptaLExbJ50PgaDLbA2bAk7MFpXY61Lg=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 07:54:28 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 07:54:28 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Topic: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Index: AQHa0mCWFUQC/0nImUSF+KOPpXpAvrHvjZmAgAAJeCA=
Date: Wed, 10 Jul 2024 07:54:28 +0000
Message-ID: <DS7PR12MB633361A48187FDC04193B93CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
 <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
In-Reply-To: <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6e9cbdcb-2e6f-4893-ba8c-860e956b64ff;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-10T07:51:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|IA0PR12MB7721:EE_
x-ms-office365-filtering-correlation-id: 88789af6-ce31-4489-e018-08dca0b5869e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmJOUkh4UHdVMm0xZURlWkVCNnJaaU9tVjJhc2FLMjJYVmNSUGUwbWNxVTJC?=
 =?utf-8?B?Q0IrYlZXWGthUUtJMHQzOWs4MlN1LzBSaHhoelVqUkMrSmUrOVVCN3pnNDA5?=
 =?utf-8?B?SXRJVWNLbFlHVWZiL0FCOHdQWmp1bkptOWgvNG4vVXAxblBSM3drcVdFclFw?=
 =?utf-8?B?V2JVZWF6Q1VwUFYxY3FveWNkZHp6Q2RwUnE3aWhOQkNyZXdBNmVvbGhBclQv?=
 =?utf-8?B?eHhEZWhISGtQOXpyMjhJNldUY21LQy9JL0ZhVitrd0VFNm4rRnBicGcyTTlW?=
 =?utf-8?B?YlU4eENaNUpUTlV0M25VMzlLL0IyY0NaMmpXVXRzVmhaUldXVWZpRnJSTTF2?=
 =?utf-8?B?RlFob2ZNeElsTWhRQjArQjFHYmNzeldzbUp2anZpTDlOSVBycHBYYjNJMEJv?=
 =?utf-8?B?QzRHS1VnaWNGeloyTXZ1akMyWTl5eHVlbzYvNXE4TzF4bkI1RmNMcUIvNGtk?=
 =?utf-8?B?dGF0ajRPeXF1SlpmUWN1M2cyNkN1ck0vOFlmekIvWCtxS09DVTBCVGhSbXU4?=
 =?utf-8?B?a3VhbWlvSWQrbytVZHVqZlhyWFlXZjJObUVCMEVYb2RySUVaZjNPTDJqVTNI?=
 =?utf-8?B?bEI0NVJkVXZGdDhpdWtxQmFoV2tXdm8wclg2YkdpR21TV0FKZnhQSGdkcVlu?=
 =?utf-8?B?MXkxL0FvcStyRW1KTmR2ZWllUnBUbUNUZkNVcUJLQnNKVGc2aVdJV2lhV1h0?=
 =?utf-8?B?ZG50bzk3Sm9kSlhGR0xyRmxCbFM5ZFlkaDF6aExqWkpjeGQ4MFlHemgrUThH?=
 =?utf-8?B?cHZzVDJGSmVSaG1oYkZUNGpzMUFHTG13Vk5pZTNqL042R1YzWE1yVUVPdXJr?=
 =?utf-8?B?WTh2VzJtU2k2NVZUM2lZdzMranMwRDE4R2NyeHRHK1ZUMFhFcitRc01qR1lz?=
 =?utf-8?B?U0tFM2VnZDJVL0xveDlzMWRWVFJlY0JCaWx6WWYxVE5uY1BZSVd1cUFLOHU5?=
 =?utf-8?B?ZitOV0hWdE9JK3dlZ2s2K2lta2hDUWQxdmpZaEM3d3ZPUFo1elI2d2Q1S3ky?=
 =?utf-8?B?SjdnUnJDVkhrdUtmQzQxL0loYnZ4VmxwTllmeXhyQ2xrQ1ZnUzFkcHlna0Nq?=
 =?utf-8?B?K1J2M3ZIOTRZNkVkL21IMk5HeUtsbEJ2UkJTSW1ycmZkZE9KeC9XN3RRdTRQ?=
 =?utf-8?B?V08rS3pRQy8zcmR5RlpBcmdvQUxsNVpQK1FUNWdMTk1FNkM5T1dzMmRrZ2ds?=
 =?utf-8?B?Ri9yU0FvNXo1VDdOczlxWFMxV053aVliQm9QZFlNeDZvUjByZzBCSWI0T0FB?=
 =?utf-8?B?a0F1Ym5EVVM0d0JwYVpmZms4dCt4ak9UZXZiSXZVZjRPM1NBQTdUWkRFNE5Z?=
 =?utf-8?B?WnBUbG9yeWUra1hpU2MvRlcwUjJ0ZjR0cFROSGhnTzlYUDkra2FkY1IyQUVE?=
 =?utf-8?B?YlhWK25obW4vSjdxM3pCaEFtMUc3QU5CUzZVQzhQbm43akZZVzZNTEdSYzEz?=
 =?utf-8?B?RkhQcjVrUmN5dTNKL3JJS2N2eWR6QXBLOTkvcEFMaDEyM1FPTDBsT0ozelh1?=
 =?utf-8?B?c0FWSW5pdDR0S0RqU29LZlhLS2l2K1h4VjEvNEpsVnFsSXd4cTFLTmwyaW56?=
 =?utf-8?B?Z2tCMU45UDlBUDBKMXcwRHZlV1IzWDZJTFIxSEFPUjZvd1U3azRkSEl6dWpV?=
 =?utf-8?B?T1Z0MVJlUlcrVjBsVnNoOEttblF2QnJQK1Rmb2ZaeThrK3YwVmxKZTF3ZW9E?=
 =?utf-8?B?bE5QSWhBWDAvUmM5a2FZaEptMm9LV1lyVFhxSVZNcWJJOUtpcWJvMEhaMFB1?=
 =?utf-8?B?dGRQOElkVXVZVlhKLy9PMWJoYmwxVERQRkFsanQxQVJubWMyRjd1L090cmo2?=
 =?utf-8?B?bEcvNGhvb3Jxazl6ZWY5aTh0dWhBVEhrVXc2cDAvYktRYWJYUXRhOVJkcndJ?=
 =?utf-8?B?YUswVDhaQnlHd0tmN3dXeVM0QkFDdTh4Sk1LbmppWlBwZWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRRTXBldlVZWHg0bS92YVIwL1YrOWMwSzAzRjlqTUNtUk9UejBrWENTdnQw?=
 =?utf-8?B?UU1yd2pySDVIb2l5S2RLajQ0K2lsUGhzaTczdDRGOEk2bHJRckVUbnpSZklQ?=
 =?utf-8?B?NjNITGx0eGJqQzVWaHdONzdPTlI1R3ljd3B2WVRaTE5lbSs5Ykt0V0VST2Fa?=
 =?utf-8?B?VmlnOGo4MGN1THNkS2c5c1g1S2dYaTNBM0xOZ2xPZkNVSzRCU0xvcGdha3o3?=
 =?utf-8?B?S2REOTFaQWVtZUkwNXp5OEo1NURwN252eGRESncvSjBVN21Fc1Q0dnErMGRU?=
 =?utf-8?B?ODV1NHorMVlOd2FGbzFGQUMvUTg2c2FIVTNoMWsyYUF6Q2o1ak04N3cwWTZh?=
 =?utf-8?B?WHZVN01GcDRtS2tsM09GSmhycTh3bXEydUNNd3JVbVpNVzUxZWUxNHh2MTAv?=
 =?utf-8?B?MlZOUnBSNVF2SnBvUlFHME9qZ1diMzNRSzlTWkw4Z0lGQlJBTUdOSU9FeDhW?=
 =?utf-8?B?K3lFS2lRS1V1QTQ4VEkzVmErU0hlZlZ1cm5NTExiNWVhak1Xd1F0aEVDQzN2?=
 =?utf-8?B?aGlLYnBOYVFoSGNrSVRsZmNNMWE2L0JaNlBjdTZUeTQwSFpJM3E4aFo2UTds?=
 =?utf-8?B?cVpTL2JNVHVXdmJoamZ5a3hVaHp5YTFKUGtma1g2TWxMSHZDKzRrdlBLMEdF?=
 =?utf-8?B?N29CdEc3QlE4aFJrZXVhVitMdXZ0WDVLcWFwUUFYaldUc1gweU5ERWxHdVNC?=
 =?utf-8?B?cUNzckhRNVBsc2pjd3F1Y1lucERYR2I5RDMyM0ttSzgwWWliMjg4a3BuK0VO?=
 =?utf-8?B?Q3Qzekc5VHRoZFFMOHcxazBEckNUTTZaWE53OWRhSkVsdWxSeEYvNnovcUZi?=
 =?utf-8?B?aXZwclVHb0F0bEVNdnlRdkJUTjk0bER6b1YzS1J2U24rY2M1ckNhVE1Uenl0?=
 =?utf-8?B?dk5uSkpwVzlDVzRiTHBqdlk0eXMvOTRHU2swTnB3alo1U1c1K2h4cG1vQUlL?=
 =?utf-8?B?enNUZGF6S1VJa0N1UjRyYy9DTnEwN2gwVXRBWWE0ZUpZM0pWRVJKSWdOVis3?=
 =?utf-8?B?SjBZN24rdjl3LzNVOTdRbDJRWXp2V3VTK00xekRzNWNJNENBa1ZoOXVidE16?=
 =?utf-8?B?bWRzQUlucFk4QnZ3Nk9zMVdsRmhRNFUvYUFCUHViUmxUSmlvd09rb2dKbzNl?=
 =?utf-8?B?cVB3a1ErY21yRm1oMHlKbGZtQVpnQTVMUnFmQ1l5MWllY0l1dFBOdmRQcEgw?=
 =?utf-8?B?L1JQUUY0YnFiVHp6aFBENTZrazBYTEhzNFMxQ25QTk9xNGgwNVhEQS81R3gr?=
 =?utf-8?B?b0NYQ1lKZXIyUGI3NFdkbHdNWFpZVGQwVUN5RXR4UURGa2FlYktKcHZUaEti?=
 =?utf-8?B?VTlZWUEvemtYNmJ2azBRRkZ6NGcvVk1OU1RUU3A5YWhsRFp5YkdhdU5nazJp?=
 =?utf-8?B?dDUyQ0xOaE13cXIrNUcwNVBaZUUxakhEV3RCZ0hVZmVNbGxmbVRsa3A5eXpP?=
 =?utf-8?B?UlpwK3drWU5wK1UwZzhQZFhlRmxJbFc5OWkrb3VRRkhOTUVlYVp4MzR3dHFH?=
 =?utf-8?B?L1R5T3pxZnM0MlNLM3c4V1FtdUNlVWNnUnVRRWxlaUVuMVI1ZllKb0w3OEJr?=
 =?utf-8?B?QjNZNUFSOWhxcldKM2NqTTBPbVYxRUpEemhKSFBLVlBhb0lHd1Rra2pCYWow?=
 =?utf-8?B?ZU1zR3Rmc3c3WjNHdkIxRnBtVW5IRFR5UnhLTkJrNko1U2w1aG5nVjVtQ04x?=
 =?utf-8?B?K2FLVFlRREtxbldabnN3U3J6MEw4bUxQZnFpWGRUdnkxcU1nc2F3VitXZkI2?=
 =?utf-8?B?U2RRbVE1cEJrWHFTZU9mQXY0di9Dem1DTlhFM0xHaE1qcW5jV2tlM2lLNENN?=
 =?utf-8?B?RHpIUHpvWEJqalZnMS9Zei9EZ1lyZURnbVJkSXlkY1B6amdGUjN0UndxYndy?=
 =?utf-8?B?YktuRzhjOHUyMEdsME5vTyt2YWcxd3YyNXVxcllwRXQ3QWZ5WXdoYktleXVG?=
 =?utf-8?B?d2NaQ3RMb0hXNW1mU1pMd0NHdnByM1p5cCtnNnlpaXNrelp4MSs2d1BVN3pn?=
 =?utf-8?B?ZTRPZk5TMCtsT0tJZzc0S3ByNUluTU9JV0RJOS9UVW9xZmhrYlgrVFBCSzFz?=
 =?utf-8?B?R2UwS1ZHbHZDVXhIZmR3dFZtTEFKQ1U5RXVIdlRHTlA5VktSWlFxdUpNZG02?=
 =?utf-8?Q?4iBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88789af6-ce31-4489-e018-08dca0b5869e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 07:54:28.7638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9vrpKrxOWjgsiiIZwTA9AtfJnSE0cEV7sSTYn49rNCqPZnnTBGXdtJS/ZjqtLJK9bq0kpQlzcCRt/hU03oZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmln
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDEwLCAyMDI0IDM6MTcgUE0NCj4gVG86IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGRybS9hbWRncHU6IHNldCBzdGFydCB0aW1lc3RhbXAgb2YgZmVuY2UgaW4gdGhlDQo+
IHJpZ2h0IHBsYWNlDQo+DQo+IEFtIDEwLjA3LjI0IHVtIDAyOjMxIHNjaHJpZWIgamlhZG9uZy56
aHVAYW1kLmNvbToNCj4gPiBGcm9tOiBKaWFkb25nIFpodSA8SmlhZG9uZy5aaHVAYW1kLmNvbT4N
Cj4gPg0KPiA+IFRoZSBqb2IncyBlbWJlZGRlZCBmZW5jZSBpcyBkbWFfZmVuY2Ugd2hpY2ggc2hh
bGwgbm90IGJlIGNvbnZlcnNlZCB0bw0KPiA+IGFtZGdwdV9mZW5jZS4NCj4NCj4gR29vZCBjYXRj
aC4NCj4NCj4gPiBUaGUgc3RhcnQgdGltZXN0YW1wIHNoYWxsIGJlIHNhdmVkIG9uIGpvYiBmb3Ig
aHdfZmVuY2UuDQo+DQo+IEJ1dCBOQUsgdG8gdGhhdCBhcHByb2FjaC4gV2h5IGRvIHdlIG5lZWQg
dGhlIHN0YXJ0IHRpbWUgaGVyZSBpbiB0aGUgZmlyc3QNCj4gcGxhY2U/DQo+DQo+IFJlZ2FyZHMs
DQo+IENocmlzdGlhbi4NCj4NCg0KVGhlIHN0YXJ0IHRpbWVzdGFtcCBpcyB1c2VkIGZvciByaW5n
IG11eCB0byBjaGVjayBpZiB0aGUgZmVuY2VzIGFyZSAgdW5zaWduYWxlZCBmb3IgYSBwZXJpb2Qg
b2YgdGltZSB1bmRlciBtY2JwIHNjZW5hcmlvcyAoYnkgY2FsbGluZyBhbWRncHVfZmVuY2VfbGFz
dF91bnNpZ25hbGVkX3RpbWVfdXMpLg0KDQpUaGFua3MsDQpKaWFkb25nDQo+ID4NCj4gPiB2Mjog
b3B0aW1pemUgZ2V0X2ZlbmNlX3N0YXJ0X3RpbWUuDQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKaWFkb25nIFpodSA8SmlhZG9uZy5aaHVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgMzENCj4gKysrKysrKysrKysr
KysrKysrKystLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2Iu
aCAgIHwgIDMgKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mZW5jZS5jDQo+ID4gaW5kZXggMmYyNGE2YWExM2JmLi43MmJiMDA3ZTQ4YzggMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiA+IEBA
IC04OCw2ICs4OCwzMSBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZmVuY2UNCj4gKnRv
X2FtZGdwdV9mZW5jZShzdHJ1Y3QgZG1hX2ZlbmNlICpmKQ0KPiA+ICAgICByZXR1cm4gTlVMTDsN
Cj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgc2V0X2ZlbmNlX3N0YXJ0X3Rp
bWUoc3RydWN0IGRtYV9mZW5jZSAqZiwga3RpbWVfdA0KPiA+ICtzdGFydF90aW1lc3RhbXApIHsN
Cj4gPiArICAgaWYgKGYtPm9wcyA9PSAmYW1kZ3B1X2ZlbmNlX29wcykgew0KPiA+ICsgICAgICAg
ICAgIHN0cnVjdCBhbWRncHVfZmVuY2UgKl9fZiA9IGNvbnRhaW5lcl9vZihmLCBzdHJ1Y3QNCj4g
YW1kZ3B1X2ZlbmNlLA0KPiA+ICtiYXNlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgX19mLT5z
dGFydF90aW1lc3RhbXAgPSBzdGFydF90aW1lc3RhbXA7DQo+ID4gKyAgIH0gZWxzZSBpZiAoZi0+
b3BzID09ICZhbWRncHVfam9iX2ZlbmNlX29wcykgew0KPiA+ICsgICAgICAgICAgIHN0cnVjdCBh
bWRncHVfam9iICpqb2IgPSBjb250YWluZXJfb2YoZiwgc3RydWN0IGFtZGdwdV9qb2IsDQo+ID4g
K2h3X2ZlbmNlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgam9iLT5zdGFydF90aW1lc3RhbXAg
PSBzdGFydF90aW1lc3RhbXA7DQo+ID4gKyAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGlubGluZSBrdGltZV90IGdldF9mZW5jZV9zdGFydF90aW1lKHN0cnVjdCBkbWFfZmVuY2UgKmYp
IHsNCj4gPiArICAgaWYgKHVubGlrZWx5KGYtPm9wcyA9PSAmYW1kZ3B1X2ZlbmNlX29wcykpIHsN
Cj4gPiArICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2ZlbmNlICpfX2YgPSBjb250YWluZXJfb2Yo
Ziwgc3RydWN0DQo+IGFtZGdwdV9mZW5jZSwNCj4gPiArYmFzZSk7DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgIHJldHVybiBfX2YtPnN0YXJ0X3RpbWVzdGFtcDsNCj4gPiArICAgfQ0KPiA+ICsgICBz
dHJ1Y3QgYW1kZ3B1X2pvYiAqam9iID0gY29udGFpbmVyX29mKGYsIHN0cnVjdCBhbWRncHVfam9i
LA0KPiA+ICtod19mZW5jZSk7DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gam9iLT5zdGFydF90aW1l
c3RhbXA7DQo+ID4gK30NCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAqIGFtZGdwdV9mZW5jZV93
cml0ZSAtIHdyaXRlIGEgZmVuY2UgdmFsdWUNCj4gPiAgICAqDQo+ID4gQEAgLTE5Nyw3ICsyMjIs
NyBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2VtaXQoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiBz
dHJ1Y3QgZG1hX2ZlbmNlICoqZiwgc3RydWN0IGFtZA0KPiA+ICAgICAgICAgICAgIH0NCj4gPiAg
ICAgfQ0KPiA+DQo+ID4gLSAgIHRvX2FtZGdwdV9mZW5jZShmZW5jZSktPnN0YXJ0X3RpbWVzdGFt
cCA9IGt0aW1lX2dldCgpOw0KPiA+ICsgICBzZXRfZmVuY2Vfc3RhcnRfdGltZShmZW5jZSwga3Rp
bWVfZ2V0KCkpOw0KPiA+DQo+ID4gICAgIC8qIFRoaXMgZnVuY3Rpb24gY2FuJ3QgYmUgY2FsbGVk
IGNvbmN1cnJlbnRseSBhbnl3YXksIG90aGVyd2lzZQ0KPiA+ICAgICAgKiBlbWl0dGluZyB0aGUg
ZmVuY2Ugd291bGQgbWVzcyB1cCB0aGUgaGFyZHdhcmUgcmluZyBidWZmZXIuDQo+ID4gQEAgLTQy
OCw3ICs0NTMsNyBAQCB1NjQNCj4gYW1kZ3B1X2ZlbmNlX2xhc3RfdW5zaWduYWxlZF90aW1lX3Vz
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gPiAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
Pg0KPiA+ICAgICByZXR1cm4ga3RpbWVfdXNfZGVsdGEoa3RpbWVfZ2V0KCksDQo+ID4gLSAgICAg
ICAgICAgdG9fYW1kZ3B1X2ZlbmNlKGZlbmNlKS0+c3RhcnRfdGltZXN0YW1wKTsNCj4gPiArICAg
ICAgICAgICBnZXRfZmVuY2Vfc3RhcnRfdGltZShmZW5jZSkpOw0KPiA+ICAgfQ0KPiA+DQo+ID4g
ICAvKioNCj4gPiBAQCAtNDUxLDcgKzQ3Niw3IEBAIHZvaWQNCj4gYW1kZ3B1X2ZlbmNlX3VwZGF0
ZV9zdGFydF90aW1lc3RhbXAoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiB1aW50MzJfdCBz
ZXEsDQo+ID4gICAgIGlmICghZmVuY2UpDQo+ID4gICAgICAgICAgICAgcmV0dXJuOw0KPiA+DQo+
ID4gLSAgIHRvX2FtZGdwdV9mZW5jZShmZW5jZSktPnN0YXJ0X3RpbWVzdGFtcCA9IHRpbWVzdGFt
cDsNCj4gPiArICAgc2V0X2ZlbmNlX3N0YXJ0X3RpbWUoZmVuY2UsIHRpbWVzdGFtcCk7DQo+ID4g
ICB9DQo+ID4NCj4gPiAgIC8qKg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfam9iLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9qb2IuaA0KPiA+IGluZGV4IGE5NjNhMjVkZGQ2Mi4uM2E3M2ZlMTFhMWNlIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaA0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaA0KPiA+IEBAIC03Myw2
ICs3Myw5IEBAIHN0cnVjdCBhbWRncHVfam9iIHsNCj4gPiAgICAgdWludDY0X3QgICAgICAgICAg
ICAgICAgZ2RzX3ZhOw0KPiA+ICAgICBib29sICAgICAgICAgICAgICAgICAgICBpbml0X3NoYWRv
dzsNCj4gPg0KPiA+ICsgICAvKiBzdGFydCB0aW1lc3RhbXAgZm9yIGh3X2ZlbmNlKi8NCj4gPiAr
ICAga3RpbWVfdCAgICAgICAgICAgICAgICAgc3RhcnRfdGltZXN0YW1wOw0KPiA+ICsNCj4gPiAg
ICAgLyogam9iX3J1bl9jb3VudGVyID49IDEgbWVhbnMgYSByZXN1Ym1pdCBqb2IgKi8NCj4gPiAg
ICAgdWludDMyX3QgICAgICAgICAgICAgICAgam9iX3J1bl9jb3VudGVyOw0KPiA+DQoNCg==
