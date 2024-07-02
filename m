Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D1FC3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 05:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DABA10E028;
	Tue,  2 Jul 2024 05:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHfyc/EM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D04610E028
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 05:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrZxb5TXJ/yFawnNo7tYj+9k2Sfl9ibbI9bpoZKnxKgR0GIjfwK78wA240QGaJq73YxiXpwOXbZIxnbQ+Pn8XYPFkH0Zbb6LlLvRgHvPLw+i1afwYCuSEwSHQQ5MRMn0q81Stv5t91cu6PNi2YcLP/RDiT4X0RVX/y2XwCPD6NtRV3oTU5cN+iPmSt8kb13a6YWC3Rk7aR+DgHS0ErCy3DHP6/mVvdibni0ZRwu7NZgkyPBvhtQHyaK9NgKNwOB7havix7LlrtbYOtkh5H8vstkLykJj831reNWaHMukybKtMQiQDRH4uPZFdOoc2+ZBahFvUD172+cNH0PZ2VihFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfBS8fuCKdF9ZhFKaeMU/4JAaOIXyE6g059P1uLPBTA=;
 b=D284WHyYGI3huuT8wREQCrX37dILlOsbUkyjNtyrhgXz8B5qTkhmj4bph7+C9UZfQICNHfMfpGqx9sGDg2nyseznlGaae8l6KWHIQfLhjZeOCrH4ZpDUFK2Rbbw3FtNm7aO2F3edkf0YPK1IgytgHzkcPZpmNfl4Dp9RjYdyUTMn3ogtQGcif4p/GJONkZcubU4ilYXc0cdkWCT6rb8SprwY9IQkirAamOFoOBxB5cs+Ulgkc5pvjlZq5WmOLad/hqsfPnBoX6ogF3NZrQQkFKSbxla9p/72tnidEL35VHXSln45lXo5AP2sNpRPBYaz75uuahoGVBXs0nD+nMjJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfBS8fuCKdF9ZhFKaeMU/4JAaOIXyE6g059P1uLPBTA=;
 b=vHfyc/EMoG0grQsbuwIruRp+l/CCHWiekchNNx10SDfffegbQb4TjeVGcOhB5FuQMe2/aDelcKkoawk9wPnnWo0u/XdTWEjFLa3O11wQI8PdHCRgTulRbSCfWnXhHnV77G8GJoZ9E5VG/0LhfSLJ98BISAt8EFJ6hjByOCjUxKY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 05:56:22 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:56:22 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>, "Li, Humphrey"
 <Humphrey.Li@amd.com>
CC: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
Thread-Topic: High Power Consumption of AMD RX6800xt in Idle with Secondary
 Monitor Connected
Thread-Index: AQHay4RVTlnl7+gHV0Gd6k+6TcqzarHh+amAgADJWVCAABRGAIAAFnVQ
Date: Tue, 2 Jul 2024 05:56:21 +0000
Message-ID: <DM4PR12MB51652B525669A4001C1EF9F58EDC2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
 <CADnq5_Nx4=-uDR4hiaZxudEz4FJYddj_mO1RAMxiLrMeevPhTQ@mail.gmail.com>
 <BL1PR12MB5158CCFAE59B15D8D0228A4B8EDC2@BL1PR12MB5158.namprd12.prod.outlook.com>
 <CADVcqdzvw9i37Gf35TKrxTmiR7DoUWtVi9PMrWpn4t+uTuNfEQ@mail.gmail.com>
In-Reply-To: <CADVcqdzvw9i37Gf35TKrxTmiR7DoUWtVi9PMrWpn4t+uTuNfEQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Humphrey.Li@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8fc76c1c-4ef4-42a7-838c-616c526009f1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-02T05:40:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|LV3PR12MB9235:EE_
x-ms-office365-filtering-correlation-id: 23a1c4e6-9b68-441e-6f0d-08dc9a5bb332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXFyeElyTTQwODFlTzVudCtiMjRVY2JYeUNnK1BaM0ZTOFBWdmtMSVBtUkpq?=
 =?utf-8?B?RUVva1ZnTUlLakI1QlE4OE5oVjNVQ2dGTjYwUjI2aUZ0VkdJUzZucjdRZWgw?=
 =?utf-8?B?eEdHZVJIcTRyaFVpclpJdzdlTGtLTWFidS9SdHJWa00yMVdiZHdzT0xtajFH?=
 =?utf-8?B?TlplVVViNFM4OTV1elVpT3U4SzN5WGtEdnk0VmZNM1NubWdla01VVjc2UEgw?=
 =?utf-8?B?NEtxcHMwM1RxeVBVaGRTajJNOFM2bkxjeFA5cndjcEZob01DRWZLeGdGUEx3?=
 =?utf-8?B?RHpOa1UvUVVpdm9QUVBwcncyaEhjNjlSczNMUjk2NmN1VG85UlpqakIvc01B?=
 =?utf-8?B?RTAxSHBjU2U1OUdGU1NjaWtLYjZaOHNiczNzekVtL2dIOGJPakNNK0FxZGJz?=
 =?utf-8?B?OUFubUViU3RmWVV6dTF0Q2NpWitXUFQ3Tk12dFJkZE1VZ2I5NVY1YWJEOTgw?=
 =?utf-8?B?YjdETXNSVEMxZzUvYkl4M3VISFdOMUxGVWgxYW5FYlhEVWJGY0lVMjhUT1dJ?=
 =?utf-8?B?dkdBM01xMEFHTGlJZi9JUWRZTDhZRjVQOHFWWGNxalVFNWt3S3FaaXo1YXAz?=
 =?utf-8?B?Wk5uZ3UzY3lNdkJVS1JjbldidzNaU3ZKekJzTUpxY1RmRjNzSGlaZVIrVk9L?=
 =?utf-8?B?UTZUVlEwc2pFdDFTaWtXek9NcHJqb0wwelJLWTdMY0tXamI4NWg2UjU1Tnhw?=
 =?utf-8?B?UGlSdmxRWkRjZlZQQWp1VWhPR2tPYkluUUdYK3lTOHhIb2hLeForYTRzV3V2?=
 =?utf-8?B?c3ZXV2xhUlJXbCtjL0FuWHptdWJZVGw2aG1PYmFPN056ZVM2ckVEV3VpVTND?=
 =?utf-8?B?QWZEa2theXloUnh5OVR6eGNkNHk4c2phbjBxd3llOExWU0F3bFN1bE5TUFUz?=
 =?utf-8?B?dHZsQ29GQTZlN056RDRKcldRSUZ0dmtZRmZydFozRnRoRC85UUNCZzNjSFkx?=
 =?utf-8?B?WmtOS3U1ZU1wUmtxTlI3THE2VUZ2ODdzUGpiQWNyUUJjVGdMWG0zZmFxbTRM?=
 =?utf-8?B?TktPb0s3dnMxNG9tRnQ3S2xGQUZKN1FlNWZFMHlyQTFuQ1M5Q0wxdnFHY3Zp?=
 =?utf-8?B?eFU2QUozTy81YXlTTk1JYitqR2M4b2hPQ1BEaXdFb3YrNzM1ZjFwRXh4ZFFp?=
 =?utf-8?B?SWRmS3c2TjNiY2tteHRGWlZZbTVCdEdZbXRIV3V5TWYycHpsNFBtWVRQcndU?=
 =?utf-8?B?YjNwMGFsVlE5UmFrVVNHYmJwREZIKytyeEg4VEhFV2U3anFYY1Q2UWxPWVFn?=
 =?utf-8?B?UGl6ekRnVTF6dWlkbDV6TEhJZHJzdnFXdDlaRlY3ckNac1VpVzNLWnZaTkJz?=
 =?utf-8?B?ME1Za2pOblA2R3ZXSU84Uy92eis3czlNbU1sU2tET29tWG14L2R6WDZCcUZw?=
 =?utf-8?B?eFQvL0plZ0U0VzZwTzJjeTUrajJqb3JleUViT3FPMkh1M3ZrV3l5TzMwR0hT?=
 =?utf-8?B?NWRwbXBRa3NxUzlKRENxaitqMWI4UytLM05CZjROc010cGF6R1Q0b3RPaEdw?=
 =?utf-8?B?YXhZbitXRmIrUWd2emhLRHF5S1RCQXJZTjFwTHVNVkxEdjdZWGR2QmplWk5F?=
 =?utf-8?B?S2V0UXRRWWhIK1Fsd3dLZlBjMTc0TG5FSVduYmlhaHFoTVZ6NjcxeFhBRUk3?=
 =?utf-8?B?Snhjck9DMXVURHp6VVFwcnRneHhOR2UyYzFmeUVaa0dHVms0WVR1eWs3c1Nj?=
 =?utf-8?B?SFBRRVllZ1NINjhqNkRzcVNEcGVUUWJxSi9IUW1IQ2NwaUVQSFBLc0twZ0tj?=
 =?utf-8?B?bHMyNFBpS3hvdzlrejd5UVozZnMwdlVEc1pyUkJ3L1UweGFSMGw3ZGlBZWpU?=
 =?utf-8?B?RExLbW1SQ3JJeUN2d0xUQlB0SVRiMGdjNWU2bTBwdlJSdXZtZnhpenZSemQ0?=
 =?utf-8?B?QXBvQmVhZVhCRVhxakRsdW9Obm9tcnVtOXY0L0hXRDFFbGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU52d1ZUaDIweGpNaWpYY0Rjck5vU3didUpUa0dHRDFVeVZOMXlIOGJmWmFM?=
 =?utf-8?B?Z1lIWjBnTjJRMERWdXp5K3E4REp0bW5EcE56SEdqQUdCY2hsVHFBWVFHNTN0?=
 =?utf-8?B?MFhZb1JGWlNMVXZRZHpUbzIzcFhHTjh5eTZUOTc4WjlYalpLVVRxRllJTktI?=
 =?utf-8?B?Vm0yQUpCc21lVDkyY3JuanFFQVBWa0JPaGYycHlXWjIrb3NzellBaDAyZmpa?=
 =?utf-8?B?c21UREhpYVA1ZXdJTWZnVmpCcFNTWngzbnFqN1pCYWgwd2JWNm9NM3pHa1Zw?=
 =?utf-8?B?U2ZOQ21sY25QVXJOZ1JNeGRqVWgzMUtwMUdjeXVTRHdOZXBXYkNNWE9lbTdz?=
 =?utf-8?B?M2dSdFZybEc5cnRoQUMrSFdOU0tueDZOZEY3elFNQXVIVlR6OGorQ1FxcldH?=
 =?utf-8?B?TWFtOVhFaGR6ZTEvNGlzdmtXaURxN3B3ZEVhcDNuSEt4amFCR3hpRUEvVnBU?=
 =?utf-8?B?cFRua09yTVc4UE5QbHdzUUxERmdMc0J2Z3pTL3lIUmxSa2lEWDVUMGo1WHIr?=
 =?utf-8?B?OTNYU1R5Q1d1ZGRJOXJ3ODhsN0dSOGZKWnB4VUhNVGVLK3M2WlVCTkkvYTNP?=
 =?utf-8?B?enpKTzVIU09jR0JCVXI1dmFBM2Vic3ZIdHc3WkpkUFVJK3daZ1k3eXdkdkhv?=
 =?utf-8?B?MVUzWmMxUjNyeVFRVmQ4ckdFclVmRzdRWEJDVHBiNUt5djdqSE1ZWTZmMTh2?=
 =?utf-8?B?K2xXczExNGJIbytuNHNXUUZHZlc2bHVDeGExMThBMit5MVlnM3FUd3ZSUkZT?=
 =?utf-8?B?NU5VYStqdXZhdlJ6ZXp5MU9IQTA4UnF0MTNFOWFxWW1aak1la016SCt3SW5P?=
 =?utf-8?B?N3lxQ0ZkMnUyTERLY2FiOHNndWliVkswb0RjZkg2V3BaR1k1bEpDWld0T2Fq?=
 =?utf-8?B?aG0vWTBUekVlaDV4Si9KdS8xNGh6WWQ1VW04VmRNUGJUZG9wQmJKbS9Zc212?=
 =?utf-8?B?eGQ2MjJBVWlGUU9sZks4VkN1TTRHWFV2SEZSUW5ZRGV1Mm5YNlZRNHRuN1R6?=
 =?utf-8?B?RkFLSGZOQUREdm83V29ldUdleEprR2h3ZkRvNlNtRGxlRDRnWkVLUkdqS2lE?=
 =?utf-8?B?Y2pkTXJBWEVLeXdHYXFLN0dGZWpDc1hqUEtVQnVLbU5zb1cyOUFObDFveTgx?=
 =?utf-8?B?R2lSVFptQzNXbDJPR2NoaFR5RGNNQkphRnViT1h6ZHZ0N3o1TS9FclNwVG5W?=
 =?utf-8?B?VDcwczIrTTJxRGN3MEZQTXhGVzlGbTN1Q2FrTTlpNkRGcEdXUHpEQVRDaWZs?=
 =?utf-8?B?NHlOUWdad0ZkYWpjbVhzQXRHR2FrUHZpWFFoRW5EOFRqcmZrUWJsK09pd1VT?=
 =?utf-8?B?a3JhcTFzcUVGTFc0d2ExTEg3VHVJUjlRT1RYNEJETlB5dXVydlY3ZmVBeTRT?=
 =?utf-8?B?czJCRERlbEQxRno3RkZpMEt6RVZFZzhJbndQUzBWZlBRTDdHNmZwUU5nbGJi?=
 =?utf-8?B?SFRmRXZMWkE3Vm5sdWdlalNKYjJSTS93OTdTQ0NVUUcxY2d3cUs1ZlBjVHgx?=
 =?utf-8?B?OFdlTjJ1YUNNQmx1SnVzOTRaUDNUcVhXNnorb0NvYytLSm1DTEN2amQ2VUw1?=
 =?utf-8?B?WFFMRVRwclBCTFpKc0hKT0ZuMjN3Nis5N2d3dXFaamxEZGIxclBHUDdna1Bn?=
 =?utf-8?B?NVFVV1hZSTF0VWMvaEFqcU9QYzg2SmJiUkhPVTZoeEh3c2wxUERJUmRoS3Fz?=
 =?utf-8?B?S1g2UXhtSjFQbFNpUi9QTU9UTnl3WUg3enJWYXd2R3FaVHpUb0lyMjZmR29P?=
 =?utf-8?B?bFN4RnhsaVZycXBIYzdWcHdDdUlSRCtxQU43cFRoN1VBNU5DSjFNc3Yrd0s2?=
 =?utf-8?B?cEpWQ3VVeHpxN2ZiOEZrVDRvdTBsU2Q1WmdDc2pWTGRSR0w0L3RqK2ZEWWIv?=
 =?utf-8?B?ckkrbWYxMWg0aG93U0VSS01rRWNZcFFDRlByUm9DSmd2TWsvaFhHaHVTdS9t?=
 =?utf-8?B?MXhsbjVrT3ZhTHRUNVhZd3R6cHRHSFZvM1N3aldlNURMSlE1dWV2eUZNWWpN?=
 =?utf-8?B?TUU1Qy9lOS9XQmExS1VOK2xCTkN3dlZJSWJUdVYvZ3NMOEJrejJkNXQ2aXF1?=
 =?utf-8?B?SkJvWTdwSkJLSVo2c0pMSjR0U3lMelc5OVhlY0xQaUR1RU9keDNmVlg5amo2?=
 =?utf-8?Q?U0lU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a1c4e6-9b68-441e-6f0d-08dc9a5bb332
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:56:21.8757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3/QHrdNqmO96drRsNmXkN6HbCvzMrfGYiimMGaandh1DhImY6A9jLWmh/w8dz68
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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
Cg0KVGhlIHR3byBoaWdoIHJlc29sdXRpb24gcGFuZWxzIGhhdmUgZGlmZmVyZW50IHRpbWluZ3Mg
c28gaXQncyBuZWVkZWQgdG8gYmUgZml4ZWQgdG8gaGlnaCBtZW1vcnkgY2xvY2sgbGV2ZWwuDQpA
TGksIEh1bXBocmV5IHRvIGZ1cnRoZXIgY29tbWVudC4NClRoYW5rcy4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFyb3NsYXYgUHVsY2hhcnQgPGphcm9zbGF2LnB1bGNo
YXJ0QGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEp1bHkgMiwgMjAyNCAxMjoyMCBQTQ0KVG86
IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGRldWNoZXJAZ21haWwuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1
YmplY3Q6IFJlOiBIaWdoIFBvd2VyIENvbnN1bXB0aW9uIG9mIEFNRCBSWDY4MDB4dCBpbiBJZGxl
IHdpdGggU2Vjb25kYXJ5IE1vbml0b3IgQ29ubmVjdGVkDQoNCkNhdXRpb246IFRoaXMgbWVzc2Fn
ZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24g
d2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4N
Cg0KDQpIaSwNCg0KWWVzLCB0aGV5IGFyZSA0ayBtb25pdG9ycy4gQW55IHJlYXNvbiBmb3Igc3Vj
aCBhbmQgZXhwZWN0ZWQgYm9vc3QgZm9yIHRoZW0/DQoNCkJUVzogSSB0cnkgdG8gaW5jcmVhc2Ug
YmxhbmtpbmcgcGVyaW9kcyBmb3IgYm90aCBtb25pdG9ycyB3aXRob3V0IGFueSBjaGFuZ2UuDQoN
Ckphcm9zbGF2IFAuDQoNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gSGkgSmFyb3NsYXYsDQo+IEFyZSBib3RoIG9mIHlv
dXIgbW9uaXRvcnMgNEsgcmVzb2x1dGlvbj8NCj4gVGhlbiBtb3N0IGxpa2VseSB0aGUgbWVtb3J5
IGNsb2NrIGlzIGV4cGVjdGVkIHRvIGJlIGJvb3N0ZWQuDQo+IFRoYW5rcy4NCj4NCj4NCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IEFsZXggRGV1Y2hlcg0KPiBT
ZW50OiBNb25kYXksIEp1bHkgMSwgMjAyNCAxMTowNyBQTQ0KPiBUbzogSmFyb3NsYXYgUHVsY2hh
cnQgPGphcm9zbGF2LnB1bGNoYXJ0QGdtYWlsLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBIaWdoIFBvd2VyIENvbnN1bXB0aW9uIG9mIEFN
RCBSWDY4MDB4dCBpbiBJZGxlIHdpdGgNCj4gU2Vjb25kYXJ5IE1vbml0b3IgQ29ubmVjdGVkDQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gTW9uLCBKdWwgMSwgMjAyNCBhdCAz
OjI14oCvQU0gSmFyb3NsYXYgUHVsY2hhcnQgPGphcm9zbGF2LnB1bGNoYXJ0QGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBEZWFyIEFNRCBHUFUgS2VybmVsIE1haW50YWluZXJzLA0KPiA+DQo+
ID4gSSBhbSB3cml0aW5nIHRvIHJlcG9ydCBhbiBpc3N1ZSB3aXRoIGhpZ2ggcG93ZXIgY29uc3Vt
cHRpb24gb2YgbXkNCj4gPiBBTUQgUlg2ODAweHQgZ3JhcGhpY3MgY2FyZCB3aGVuIGEgc2Vjb25k
YXJ5IG1vbml0b3IgaXMgY29ubmVjdGVkLg0KPiA+DQo+ID4gVXBvbiBpbnZlc3RpZ2F0aW9uLCBJ
IG9ic2VydmVkIHRoYXQgbXkgZGVza3RvcCBjb21wdXRlciBnZW5lcmF0ZXMNCj4gPiBtb3JlIGhl
YXQgd2hpbGUgaWRsaW5nLiBJIGRldGVybWluZWQgdGhhdCB0aGUgaGlnaCBwb3dlciBjb25zdW1w
dGlvbg0KPiA+IGlzc3VlIGFyaXNlcyB3aGVuIEkgY29ubmVjdCBhIHNlY29uZGFyeSBtb25pdG9y
IHRvIG15IEFNRCBSWDY4MDB4dA0KPiA+IGNhcmQsIGNhdXNpbmcgaXQgdG8gY29uc3VtZSBhcHBy
b3hpbWF0ZWx5IDQwVyBvZiBwb3dlciBpbiBpZGxlIHN0YXRlIC4NCj4gPg0KPiA+IEkgY2hlY2tl
ZCB0aGUgIkdGWCBDbG9ja3MgYW5kIFBvd2VyOiIgaW4NCj4gPiAvc3lzL2tlcm5lbC9kZWJ1Zy9k
cmkvMS9hbWRncHVfcG1faW5mbyBvZiBteSBSWDY4MDB4dCBkdXJpbmcgaWRsZSwNCj4gPiBhbmQg
aGVyZSBhcmUgdGhlIGZpbmRpbmdzOg0KPiA+DQo+ID4gV2l0aCB0aGUgc2Vjb25kYXJ5IG1vbml0
b3IgY29ubmVjdGVkIG1lbW9yeSBmcmVxdWVuY3kgaXMgdXAgYW5kDQo+ID4gY29uc3RhbnRseSBh
dCAxMDAwTUh6Og0KPiA+ICAgICAgICAgMTAwMCBNSHogKE1DTEspDQo+ID4gICAgICAgICAzIE1I
eiAoU0NMSykNCj4gPiAgICAgICAgIDE4MjUgTUh6IChQU1RBVEVfU0NMSykNCj4gPiAgICAgICAg
IDEwMDAgTUh6IChQU1RBVEVfTUNMSykNCj4gPiAgICAgICAgIDg1NiBtViAoVkRER0ZYKQ0KPiA+
ICAgICAgICAgNDUuMDAgVyAoYXZlcmFnZSBTb0MpDQo+ID4NCj4gPiBTaW5nbGUgbW9uaXRvciBj
b25uZWN0ZWQ6DQo+ID4gICAgICAgICA5NiBNSHogKE1DTEspDQo+ID4gICAgICAgICAwIE1IeiAo
U0NMSykNCj4gPiAgICAgICAgIDE4MjUgTUh6IChQU1RBVEVfU0NMSykNCj4gPiAgICAgICAgIDEw
MDAgTUh6IChQU1RBVEVfTUNMSykNCj4gPiAgICAgICAgIDYgbVYgKFZEREdGWCkNCj4gPiAgICAg
ICAgIDguMDAgVyAoYXZlcmFnZSBTb0MpDQo+ID4NCj4gPiBUaGUgc2lnbmlmaWNhbnQgZGlmZmVy
ZW5jZSBpbiBwb3dlciBjb25zdW1wdGlvbiBiZXR3ZWVuIHRoZSB0d28NCj4gPiBzdGF0ZXMgaW5k
aWNhdGVzIGEgcG90ZW50aWFsIGlzc3VlIGluIHBvd2VyIG1hbmFnZW1lbnQgdGhhdCBuZWVkcyB0
bw0KPiA+IGJlIGFkZHJlc3NlZC4gWW91ciBhc3Npc3RhbmNlIGluIHJlc29sdmluZyB0aGlzIG1h
dHRlciB3b3VsZCBiZQ0KPiA+IGdyZWF0bHkgYXBwcmVjaWF0ZWQuDQo+DQo+IEl0IGRlcGVuZHMg
b24gdGhlIHRpbWluZyBvZiB0aGUgbW9uaXRvcnMuICBUaGUgbWVtb3J5IHJlY2xvY2tpbmcgY2Fu
IG9ubHkgb2NjdXIgZHVyaW5nIGJsYW5raW5nIHBlcmlvZHMgb24gdGhlIG1vbml0b3JzLiAgSWYg
dGhlIHJlY2xvY2tpbmcgaXMgZG9uZSBvdXRzaWRlIG9mIHRoZSBibGFua2luZyBwZXJpb2RzLCB5
b3Ugd2lsbCBzZWUgZmxpY2tlcmluZyBvciBhcnRpZmFjdHMgb24gdGhlIGRpc3BsYXkgd2hlbiBp
dCBoYXBwZW5zLiAgSWYgdGhlIGJsYW5raW5nIHBlcmlvZHMgYXJlIHRvbyBzaG9ydCB0aGUgZHJp
dmVyIGNhbiBvbmx5IGRvd25jbG9jayBtZW1vcnkgd2hlbiB0aGUgZGlzcGxheXMgYXJlIG9mZi4g
IEFkZGluZyBtb3JlIG1vbml0b3JzIG1ha2VzIHRoaXMgaGFyZGVyIGFzIHlvdSBoYXZlIHRvIHRh
a2UgaW50byBhY2NvdW50IHRoZSBibGFua2luZyBwZXJpb2RzIG9uIGFsbCBtb25pdG9ycy4gIFlv
dSBjYW4gdHJ5IGFkanVzdGluZyB0aGUgbW9kZWxpbmVzIHVzZWQgb24gZWFjaCBkaXNwbGF5IHRv
IGluY3JlYXNlIHRoZSBibGFua2luZyBwZXJpb2RzLg0KPg0KPiBBbGV4DQo=
