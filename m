Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A5BC71134
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 07:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D94A10E347;
	Wed, 11 Jun 2025 07:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqpkB+rf";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1914210E354
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 07:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtmZPbWOt8tkSgETbQ5dVDM3xhPKyCYobTz9TfgLhY/t04lVye+n5UwO8V2jQFiWMLlhvBBYWrHeJb2U7HqIkv1MbPiksqE4lyN/VFFs0FU3VfQiUHa7wnK02Um6rbYQEqsy3iuYVVDNBpVdmCXXhSAe3VIymf9Ktm/XiFbRI0TiRzclyrEnXdR8vBLBYWePGvO0mzW7Wbuu2Nm8mlLys51cA9dskmjJkUkKfbZO9quE4UdePFM/e7CkbuQ0BfmjPj4LBZqNCLCcnJiYKgB2HsH+zwH72xdKMjwOuEAf5kvf2eOxsYyz86bBIsw4tkAar/ZdicYNKfZMaBSuVtSYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fjech3SjvxBFjtzIrR3mkOLYXdJGSLAUkZ3PPc96TI=;
 b=THHlerbNhdwCBuqCSzmnAgBjR6xP6USTr42IvqAC2AXwITejzFeiV5o4UuaN2zhd//FFEmxqbSUB5CrquctzsXgmyS8Xvsd536gIqAPbmBIk2uw3FMRbErRfqAIi9sUeUXXmR65ZH7WULTidhL8YoPGXgg/DPKAGdLHXz6+YqYf+uYl7IZeADEGarmn+PjKUe+0KWAM/1e8EsX64MSm+NBra6sJl/9dIa4Finw5t2NvODYR3TggdvAfG6mpSkuGl50Q22d2zGIenBvEdD8OjwQUgY1JY9RJg9rHmUdofIKbuHHCUYyJ15fGG9nyeQBZudzHaJzbyXMAixZzGG/Uo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fjech3SjvxBFjtzIrR3mkOLYXdJGSLAUkZ3PPc96TI=;
 b=BqpkB+rfdAIsNWq+YKPxZKPre/SOu477QRtQ96ZFvA0IG8M38eu0vUyTBI48NaQATDqckpOMiGgeZHiTTbIWDPWkxJjRd4JNPzjcLDW0hDZIgPFpUXYgjvgc2w45rDvf4NhxdlxGoWT+QKkBYfZQKXeVUrEvN9YISsYSoF3v/iA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 11 Jun
 2025 07:11:32 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.019; Wed, 11 Jun 2025
 07:11:31 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Implement instance ID remapping for
 harvested SDMA engines
Thread-Topic: [PATCH 1/2] drm/amdgpu: Implement instance ID remapping for
 harvested SDMA engines
Thread-Index: AQHb2pWNXqaZ6t6dEkW5RGRA5LaTG7P9ex+AgAAPQNA=
Date: Wed, 11 Jun 2025 07:11:30 +0000
Message-ID: <DM4PR12MB5152B5E2D0340A399B5E7738E375A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250611055604.3303818-1-jesse.zhang@amd.com>
 <6dd9bb8a-cbe2-4428-b0bd-266ab706d83b@amd.com>
In-Reply-To: <6dd9bb8a-cbe2-4428-b0bd-266ab706d83b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ec180e90-e3ca-4c2a-a5af-f92e94482195;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-11T07:09:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ1PR12MB6218:EE_
x-ms-office365-filtering-correlation-id: 9759eff4-a5ca-49b6-5d20-08dda8b730eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UWJmZXl4UThkUi9PTm14Qm00NzVXSDVrRHBObXhsSmJpcjdxRXNKQ1JiRVho?=
 =?utf-8?B?NzFZS3h6Q3B3QktWS00yNzZiZjBrMDZaelo2K1NTYjdtS05Hc3JudzlVZ1Fw?=
 =?utf-8?B?K2xhajlUSWJEL1J0ZXJnd3NnKytFSC80WXFtb3d1a3YyUE9FcytRdkcrNUxV?=
 =?utf-8?B?ckdueFdwKzBTcmlNbkhoS3BzMGpsT3V2MUlGZ0lWeHFIUm5QSm9heFMyRW1I?=
 =?utf-8?B?d3lmeWtoK2hNdktTVE9mUVlvOXhqd3pmNENqYzBWdWtsa2I2azNwYm1wSThQ?=
 =?utf-8?B?ZnQyUUNYb1QwVFNMQ2xpR2hremJyWWJ3OE9ZdXZBdmtZUys2L24vMHd5VENs?=
 =?utf-8?B?ZTNKc01JU3NVdmhwcUJrZTBhS2hZNkpoajZ5RXdmWjhqa1Bta0hFSGtVcVNW?=
 =?utf-8?B?WkJ4eEUySVBxTmZoRUFWRGZLNzhYSTMvUTljVmlnYUZYbno3RUM0aU9EdVRu?=
 =?utf-8?B?QU9IUUlCMVh6SHVnZzZnQVQ0dzUrVXBVUG55K0NNWjBqSGk1R0l3MVBIZ2FU?=
 =?utf-8?B?UFNoSmdpcFFPcktUM2FaSUNTYWpCN1BVZlVhdVg0S3NIMnZrTVJkZDhBSnhW?=
 =?utf-8?B?aW1BRWkxdlM3Yk0zYmg0UFFzOC9GKzU1OTVQTEhBU2FCc09tVUNteHNLQXg1?=
 =?utf-8?B?bnVhdERMTFZDT01wK3ByaTN0S3k1cGxNZklHQ0srOTV1aUp2eS82TlY1VTVt?=
 =?utf-8?B?bzI1ZU5SZVJoUlM5YlZ5T2hNVmlJd3FMckZnSkk3ZDk0N2ZQVDJ3M1hnQW05?=
 =?utf-8?B?UURyNmtRQWU1U3NDdXVRRGR2ZXA2bzdwM2c1RkdxcTFKNlVZWHQzNkozaUo3?=
 =?utf-8?B?a2Zxa25jZmtMZGx3OFp5VHV2ODhmOS95Mjc5ZldVZlc4ME4wd0JjbFlJU05m?=
 =?utf-8?B?VGtSdnJNWGxId09EUjZXYjcySllGRXcybFhrcE1KZ2h4WVk2anN4WXRHUkJu?=
 =?utf-8?B?V3g4NHEvMGh5bk0ySkNCKzJaMDZDQ2FPVTFpaWoraEdWY013TlhXU3VLRlZ0?=
 =?utf-8?B?azV3S1JPaVdtOE1ST1R1aXdSWUlLcGFGaWo3MnMzYXQ3NWZCSnpPa3NwNFJu?=
 =?utf-8?B?dDdZdk5NSGZPc0NBMkNFTG83NElBSjdEOTJqUEN6bEQxdkxqQTZTcmxCVEgz?=
 =?utf-8?B?RjhQRmVOQXlZTXZ6cVg4Zi9KelhxZXBxOGl3a3h6czlnSzRjQmNUakJMeWZz?=
 =?utf-8?B?OXpUcWZ1YVdLb3ZHaDdvUXNZV2tYRHVHOENFNnU0ZGxPUE9oREhUbndHV3R5?=
 =?utf-8?B?TTFFWFJwZzU1UmhuWGFLTi9mREtFSDVTNG9VZmJhSHN2STBQNFFka1YzQ3Bq?=
 =?utf-8?B?bEcyV3VVc29WNEM0ZVViT2FGa2VmcklzWUV0U3p6SEVzRVRtNEh6MVZvR3cz?=
 =?utf-8?B?Q3EwTW9JMXdwRG9XVk1RTURsOWhqdGZLbm5rWUZxV2NOb2VCRjlodlNYN3c3?=
 =?utf-8?B?TUVweWJGL2xTajlwYSs2MUVDZ1BCZVJsTHNVcmFueHltWm0xNlhNUlR4U1JY?=
 =?utf-8?B?TXNpYW1KUUJXTUlKbE9ISHZWSjRMaDlGRmxySG5ITTMzNmlJdWRObmpUZXdM?=
 =?utf-8?B?enVFSmFrenQxQnVqTDBCUTc4SXVlUDJJZkhrQ1piREtqaXNuMC9mWjE0SUt1?=
 =?utf-8?B?cW9mTUoyU01IZlNGdnpMM0x6Y3JWTktJbmZDdjM3dXNwbHBZUFpHMzYrV3Ur?=
 =?utf-8?B?OTlCa3lCSG1sK0p0Nmx5UE91RG9ZNTAySEFhM2VEWUhTOElTZlAvZVJiV3RG?=
 =?utf-8?B?eTZWWnpDTUFxYlRUZnZlSnVrL0RGdm40cjNVQ3VLZzRRUk0xQ1hLWEFoOGFS?=
 =?utf-8?B?M3JGSERvajZQUW9XaTJ1VHJxYzdQQ1RjVFRSK3lxNTJNWWpXRVFwMlVGZWdL?=
 =?utf-8?B?Zzd4TEZUQlpWNSthcWdSSGhCeVJ5enZ5ZllnU0l5UHdmdnppT0dIT2FXajhr?=
 =?utf-8?B?M0tOWVlCWW9JRUZ0WjBmN2ZzaEd4c2tCMTlELzVldjRoR2VaNmtYbUlJb2NF?=
 =?utf-8?Q?VU84zJo/Fy/PRVZSYEPgJh/IDL/om0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDBQUjBJNjZ2cGZvU1JmNUZiTVhHa0dxRlcxVTdFQzRLeHVuYTMxaC91aDg4?=
 =?utf-8?B?Qjd4Yzc0L3grdHlrRFRwNUljZVpwTEU2UVNMbHdMV01jT3lUYjg1YUFXcXhP?=
 =?utf-8?B?YUNUUURWU3B0VUYyQ2ZHVkdwMDJPZGduclIrTDlIOGtWVVBsR0VYK3NkVVN1?=
 =?utf-8?B?Y3RvWHVyeEZkSkpQSVFYazRiZ3hUN3ZrNVErK0M0VmZ0QlFRYnZVYlRaK1h0?=
 =?utf-8?B?dVBDWnJXWDZ4bnhwaEZpako3QUo5MEZxeEcwMVhqblcybGhWSmxCNG0vMndO?=
 =?utf-8?B?UnIyMnNIS1ppK3lrTVoxTnNQcU1KaGk5RDhDMGtnUXg4WjYzY1FMeGZWZ3dG?=
 =?utf-8?B?WmtjWG13c09FbERPWjdmSDJnU1poaFFPRzhvK2dNNmxpZGlGcUhwTUFVQUlD?=
 =?utf-8?B?SCtteUU1VnluVTNKcm1rYmdQTXRqOWdBV1NhZ3FhMmNzNk85UG5NUWRWdUhu?=
 =?utf-8?B?aDZWajVaL09mMm9GTGVScjFjQno2YTNYTHhoQ1hFTWRCc2tHeHJqbFc4WVJo?=
 =?utf-8?B?NnVQNzQxb2lDSWdaWjA5Zy96QW94ODk5cGpROTN2UHFVdzZyVExVbmpadi9x?=
 =?utf-8?B?REZSSkZIOEg3d3M3aitzVVBJK2RDTHU3bFJudXByQ2svWkpBSHYxV01HanBq?=
 =?utf-8?B?anhiT09qMUd6bnNvWnh1ci9QQVJWSHd0QjVsTXpUV0V4elVyUHJ3Z0RwcCtX?=
 =?utf-8?B?MlU2c0w0dkxGejNsT3NsMURtUkZGbTlnbTdtN1RLYnNuYlAvNHIrNTF5TFNU?=
 =?utf-8?B?dEhZVHYzRWxSY3FTQTNmNUtvNCs0MlBhajFxOWRMaW1XaWZNSnV3S2xMT1pG?=
 =?utf-8?B?SXhrdTFBbTlBRVo5dWp2Q1JmUVUrZVBoTlN4MGpZdzNaM3pHQWxRUzg5WWpp?=
 =?utf-8?B?dWhGWitNdkFwdkZkSjFieEU1b1RhTTJ5RURXNlNiL25rTkMvVXpQS3NaZzg3?=
 =?utf-8?B?czVwZDZDYlRPN2xPV3hudGtLQnJvejZ0SXNjZHdTRUxOcnp3cDV3YnNkMTBK?=
 =?utf-8?B?em1XUjYxeXgvb2lnaFZxTnlBRHgwL3ljQlVSWmtxMmorZmxLL2YybEkzQS9s?=
 =?utf-8?B?d3YzZ1ovbERlNi9Cblk1SUtkVFZGbktPMWkyeENKSWFtSXZ5dTREQ2lNM3Qx?=
 =?utf-8?B?aTR2TFRFa0pmZG9Wb2tEaHpQK2haNExTdHM3ZDBjMXhMdjBGM0pEdnJ1VzhU?=
 =?utf-8?B?Rnd2Tk9zb3pPUCtUUkVsemIvQnpUbjFQVE9RWE81MjhBODZOQ2JKUmFGS09a?=
 =?utf-8?B?NW14VnFscDJ6SWdoSGNlZWVkaFhLVXc5c0w2QWZxWmNveWN6QWRSUSt2RGxJ?=
 =?utf-8?B?azVtMlg0c2VNaVNLSXhmYXRKQUlKcU5TUWQ1Y3Fyc2VJWXNaakRuOUhncGhO?=
 =?utf-8?B?dWpINkwyY2JzblFYRklUbXE3bTE1YkhaVCtPM0JXV1YrNmlITTFPZVVxMUFk?=
 =?utf-8?B?SmlhM2tic3VmWXIvQnVTV2JUS3p0a1p3Z0lmM3lvb0ZicEFWaTNocG1RUUlN?=
 =?utf-8?B?RmpQZTY2U1NhZHd3bnVxZmtUeTVsUUU5bGhZN3NZR0V2NlN3SlVPdmRjeEVD?=
 =?utf-8?B?QWVYdzVZc0k2VTMvQk5NRE1MVjFtMkJqTVZYYnlWS24vSjVLOVRwY0VNcjZM?=
 =?utf-8?B?N1A3WE4wUWh4bmNHcy92UDNMbE9zZExJbkNFTHhzb1VSMGYvL21wY2Vtbkxm?=
 =?utf-8?B?ZWdpaEhEQkVnT2tWNGVZaGdiS1c3aDdVYTVjNVJBY0xNUlIyRG1sRlNuUTl6?=
 =?utf-8?B?TlZBbU9VdGREU0Q0bmJyQTMwOHNKQkNsSlZmYUU5aVAxY0gweHpqRkRPS0lt?=
 =?utf-8?B?b0E2NmRiYUllVlo5UXVEV0IyMHpWd3NRWUNRdlBSYlVSM1ozUVFGWkFxUjBp?=
 =?utf-8?B?TVI1WXQ5cGIwKzhOOEg5dkRKUFNGTDlJZTdmVHpkRHhIQmR0M3NvVHlrTGJi?=
 =?utf-8?B?c0JqQ21JakJraDJ6aHNjaFFGVHRKUVNrN0xrOUZpend5dU5iLzhDTWhLd2I4?=
 =?utf-8?B?Qld4cUhnTEhEZ2NrR3RRaWoyUFFPcURub2U3MXd3WGNKTFBDanBFNlFoTHZv?=
 =?utf-8?B?YnNkSFVSTDFxMStFQWxqZkFub1c5UVRWU3RlM2NDeFFObGJycHUwK3FQQTk0?=
 =?utf-8?Q?Tnjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9759eff4-a5ca-49b6-5d20-08dda8b730eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 07:11:30.9273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BsF0MKmivVrwv4ZKh9G5mOWy589rnlVeFKUo5pIJ6KgplwIaivWsZBPVd7GZUsqC51OXRlYwTBYpJPsgIGkSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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
Cg0KVGhhbmtzIExpam8NCkFzIHdlIGRpc2N1c3NlZCBvZmZsaW5lLCB3ZSB3aWxsIHJlbW92ZSB0
aGUgaGFydmVzdF9jb25maWcgY2hlY2suDQoNClJlZ2FyZHMNCkplc3NlDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0K
U2VudDogV2VkbmVzZGF5LCBKdW5lIDExLCAyMDI1IDI6MTUgUE0NClRvOiBaaGFuZywgSmVzc2Uo
SmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEtpbSwgSm9uYXRoYW4g
PEpvbmF0aGFuLktpbUBhbWQuY29tPjsgWmh1LCBKaWFkb25nIDxKaWFkb25nLlpodUBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IEltcGxlbWVudCBpbnN0YW5j
ZSBJRCByZW1hcHBpbmcgZm9yIGhhcnZlc3RlZCBTRE1BIGVuZ2luZXMNCg0KDQoNCk9uIDYvMTEv
MjAyNSAxMToyNiBBTSwgSmVzc2UgWmhhbmcgd3JvdGU6DQo+IEFkZHMgbG9naWMgdG8gaGFuZGxl
IGluc3RhbmNlIElEIGNvbnZlcnNpb24gZHVyaW5nIFNETUEgZW5naW5lIHJlc2V0DQo+IHdoZW4g
aGFydmVzdF9jb25maWcgaXMgYWN0aXZlLiBUaGlzIGVuc3VyZXMgY29ycmVjdCBwaHlzaWNhbCBl
bmdpbmUNCj4gYWRkcmVzc2luZyB3aGVuIHNvbWUgU0RNQSBpbnN0YW5jZXMgYXJlIGhhcnZlc3Rl
ZC4NCj4NCj4gQ2hhbmdlcyBpbmNsdWRlOg0KPiAxLiBBZGRlZCBpbnN0YW5jZSBJRCByZW1hcHBp
bmcgdXNpbmcgR0VUX0lOU1QgbWFjcm8gd2hlbiBoYXJ2ZXN0X2NvbmZpZw0KPiAgICBpcyBub24t
emVybw0KPiAyLiBDb252ZXJzaW9uIGhhcHBlbnMgYmVmb3JlIGVuZ2luZSByZXNldCBwcm9jZWR1
cmUgYmVnaW5zIDMuDQo+IE1haW50YWlucyBleGlzdGluZyByZXNldCBmbG93IGZvciBub24taGFy
dmVzdGVkIGNvbmZpZ3VyYXRpb25zDQo+DQo+IFRoaXMgZml4ZXMgaGFyZHdhcmUgaW5pdGlhbGl6
YXRpb24gaXNzdWVzIG9uIGRldmljZXMgd2l0aCBoYXJ2ZXN0ZWQNCj4gU0RNQSBpbnN0YW5jZXMg
d2hlcmUgdGhlIGxvZ2ljYWwgaW5zdGFuY2UgSURzIGRvbid0IG1hdGNoIHBoeXNpY2FsDQo+IGhh
cmR3YXJlIG1hcHBpbmcuDQo+DQoNClRoaXMgc2hvdWxkbid0IGJlIHJlcXVpcmVkLiBXaXRob3V0
IGhhcnZlc3QtYXdhcmVuZXNzLCBkcml2ZXIgd29uJ3QgbG9hZCBwcm9wZXJseSBvbiBNSTMwOC4N
Cg0KVGhhbmtzLA0KTGlqbw0KDQo+IFN1Z2dlc3RlZC1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhh
bi5raW1AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5n
QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jIHwgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2Rt
YS5jICAgICAgfCAzICsrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Nk
bWEuaCAgICAgIHwgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVy
eS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+
IGluZGV4IGEwZTliZjliMjcxMC4uNDI4MmY2MGEwY2VmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IEBAIC03NTksNiArNzU5LDcg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X2Rpc2NvdmVyeV9yZWFkX2Zyb21faGFydmVzdF90YWJsZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfigxVSA8PCBoYXJ2ZXN0X2luZm8tPmxpc3RbaV0ubnVtYmVyX2luc3RhbmNlKTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgIGNhc2UgU0RNQTBfSFdJ
RDoNCj4gKyAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnNkbWEuaGFydmVzdF9jb25maWcgfD0g
KDFVIDw8DQo+ICtoYXJ2ZXN0X2luZm8tPmxpc3RbaV0ubnVtYmVyX2luc3RhbmNlKTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgIGFkZXYtPnNkbWEuc2RtYV9tYXNrICY9DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIH4oMVUgPDwgaGFydmVzdF9pbmZvLT5saXN0W2ldLm51bWJlcl9p
bnN0YW5jZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2RtYS5jDQo+IGluZGV4IDY3MTZhYzI4MWM0OS4uMGJm
ZDJjMTM4ZDI0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfc2RtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1h
LmMNCj4gQEAgLTU4MSw2ICs1ODEsOSBAQCBpbnQgYW1kZ3B1X3NkbWFfcmVzZXRfZW5naW5lKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCBpbnN0YW5jZV9pZCkNCj4gICAgICAg
Ym9vbCBnZnhfc2NoZWRfc3RvcHBlZCA9IGZhbHNlLCBwYWdlX3NjaGVkX3N0b3BwZWQgPSBmYWxz
ZTsNCj4NCj4gICAgICAgbXV0ZXhfbG9jaygmc2RtYV9pbnN0YW5jZS0+ZW5naW5lX3Jlc2V0X211
dGV4KTsNCj4gKw0KPiArICAgICBpZiAoYWRldi0+c2RtYS5oYXJ2ZXN0X2NvbmZpZykNCj4gKyAg
ICAgICAgICAgICBpbnN0YW5jZV9pZCA9IEdFVF9JTlNUKFNETUEwLCBpbnN0YW5jZV9pZCk7DQo+
ICAgICAgIC8qIFN0b3AgdGhlIHNjaGVkdWxlcidzIHdvcmsgcXVldWUgZm9yIHRoZSBHRlggYW5k
IHBhZ2UgcmluZ3MgaWYgdGhleSBhcmUgcnVubmluZy4NCj4gICAgICAgKiBUaGlzIGVuc3VyZXMg
dGhhdCBubyBuZXcgdGFza3MgYXJlIHN1Ym1pdHRlZCB0byB0aGUgcXVldWVzIHdoaWxlDQo+ICAg
ICAgICogdGhlIHJlc2V0IGlzIGluIHByb2dyZXNzLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NkbWEuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9zZG1hLmgNCj4gaW5kZXggZTVmODk1MWJiYjZmLi5mZWQwMDg1NGExYTIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmgN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3NkbWEuaA0KPiBAQCAt
MTIzLDYgKzEyMyw3IEBAIHN0cnVjdCBhbWRncHVfc2RtYSB7DQo+DQo+ICAgICAgIGludCAgICAg
ICAgICAgICAgICAgICAgIG51bV9pbnN0YW5jZXM7DQo+ICAgICAgIHVpbnQzMl90ICAgICAgICAg
ICAgICAgIHNkbWFfbWFzazsNCj4gKyAgICAgdWludDMyX3QgICAgICAgICAgICAgICAgaGFydmVz
dF9jb25maWc7DQo+ICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgIG51bV9pbnN0X3Blcl9h
aWQ7DQo+ICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgICAgICBzcmJtX3NvZnRfcmVzZXQ7
DQo+ICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIGhhc19wYWdlX3F1ZXVlOw0KDQo=
