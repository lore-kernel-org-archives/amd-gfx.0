Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA0AC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 06:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B1B10E8E6;
	Thu,  6 Mar 2025 06:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ni8AuUg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5FF10E8E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 06:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjQtqU6kzMkZEl/2tsHUcsqIW7rKQhYNPsMUfBz/yjCUlJYKRWo7DjfxJ6cq5XGySkxG0lrzDuAIcBo5H6OeZ0rAzz9hnUMPJlm/ud154S/WjNsPHxJx9Q2q0pZKkK9RxDFj0DFIyfLd92qsgmZAkZv17FRUSiIwkwwRs1sFP8izhA8Y5L6qg4Sqiq94/nS8RLLgsg/9HGt9DtHOJUiMn/fe/wZEFl+DSCVhGpSmmeEq9cluvLIrHfsSKT6AfD7vNMGmtxp8GN+F5+R+UbqQIlOPeJNOBlqLS7S6bLKUtGig21oIDwXkFGo5U4QqowcK5ftdHosuuhpAA0Kblc3+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkS9A4QvO7g8fLn5QtzQaGalQlK0ScZJxEzKLFn4LfY=;
 b=V+hfXRUBRIjtqtt40/EdJIfXvBPQ10h1/np1bKeDWzjfSe2NnFpx7OZ9dofGMzrd6d8GxqXV6/xDS0aDTXkxLA8uvl50l/1fsVBXNly+F2BCc4Cg4sU6Vvgr8xZHdbSJ3ZqjZ9xRKD7x5kpmL4JzLPLvt7kujSnd60lBxipVdnTq0GfzkpV/GP8daO39xTKUmxMwbAmSioX9+rIHpMg5lq7NveEdRjNskac+KzLScYSS7IbRhXUCb8JOjcDgNGmhHYleJl07YuIJKy+O6iRikaS3qb+1ZTsKSfekC0nVSYq2hDdcGVh2cV/gIoUKP0YTKQutaRt+TTzxIxfdEkh4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkS9A4QvO7g8fLn5QtzQaGalQlK0ScZJxEzKLFn4LfY=;
 b=5ni8AuUgg50oInq639wvtlymDmn0ycT63KAC/tcZCZdjDqWYiAq/Ff5t1nht8M1MYVzW5Z8D7TqYim4Qu+jV5kHDeSnDuYYLgi3z7vtwDqjM/o+kniSTZR5K4WEfs4zm8/7iBaJFIcAiHpXb+4lmf+Rv9+tqOLA2luPbsFQVrzc=
Received: from CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) by
 DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 06:03:59 +0000
Received: from CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f]) by CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 06:03:59 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Fix the race condition for draining retry
 fault
Thread-Topic: [PATCH v3] drm/amdgpu: Fix the race condition for draining retry
 fault
Thread-Index: AQHbjjqCrPLQlxZEWkSLlcwGfD0SFLNlkBgAgAAOZjA=
Date: Thu, 6 Mar 2025 06:03:59 +0000
Message-ID: <CO6PR12MB5411719913C7F92F3ACB461D8FCA2@CO6PR12MB5411.namprd12.prod.outlook.com>
References: <20250306015303.3221350-1-Emily.Deng@amd.com>
 <28614ac5-dcee-410e-b2c2-085d8de0d616@amd.com>
In-Reply-To: <28614ac5-dcee-410e-b2c2-085d8de0d616@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d2c81936-0ecf-4aa8-a0f2-58fd02da8d44;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-06T06:03:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5411:EE_|DS2PR12MB9565:EE_
x-ms-office365-filtering-correlation-id: 36a5e809-da83-4c0a-8c54-08dd5c74afe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NjFmcW5INkhsazhweENJWTZ1OG9aM1ZQUFhuL0I4MmpqOUM0cW1yRXdSWm5v?=
 =?utf-8?B?NTZjQVJEb21BSEVPcFZqR2pIZFp6WUx6cFFuNzJCR3FWZ1k3ODRDOTJSbkla?=
 =?utf-8?B?eUV6M1VXOWtSclk5cGhvckVWM0JQUElZOFVudlZzMkg3RE9OK0hEUk1GWCts?=
 =?utf-8?B?Y08zeE1QSDYycG8zRFRmTGNBbDZjcTF4NHFWWmhQUVpwcUdNZmF0YUoyR3Q2?=
 =?utf-8?B?QVY1TjRzTys4WEt4UzBGZzEvQWpsNVB2TFRvUFpiM20rdUNsdVIvWXZvMXk2?=
 =?utf-8?B?dzZyZ0JRdXZwU0J4ZG1KcWYraGRWUytlZEpWVXI2Y20xOUlEdHl6Q3RrY24y?=
 =?utf-8?B?QjFoS2ZLdHJ3b0xWdndCQUNVbDhnVGhpSXNBL1o3SGJPQVZGMUNObkVZZkZw?=
 =?utf-8?B?bHZ4bERBN2YxVGx2bE8wbXVySnhYMmltYjhZWTI1VHpNRU9WUFFHaGMzcWdI?=
 =?utf-8?B?akdSVTFHcWpFZHIvZDdDc1dqdlBmemo2MWxjV085L2xHV1JkYjZuSHhBb3l3?=
 =?utf-8?B?RHVZRGlrQXBpNUk3bzFxaXlJNlo0bGJKOWlEMWJjYkp4MWJJSDRKMytlQjhT?=
 =?utf-8?B?d0l3cVp3YzB2WW5Nb3ZNQlBRaEZZUytQVkQrbG53Y0xpbkF0bWpCMlBUR2Rr?=
 =?utf-8?B?VEthL3Q3eWdnUG9pSFM1dW91VVdkWTJTc1ljTlFwbzlkVXJHaS8xbUR3OFYx?=
 =?utf-8?B?RjlHUUJIeDhNV3pzQjkyQWtyamNwMU9vNW1reTVOdXNuQ1F6MTNPM1NvOENI?=
 =?utf-8?B?Sk4wMjJ4bERheFJzQTJ4dUEzZ3F2RmtUTy9sL1V2d1Q0NFgxcnNHSmZxdDZG?=
 =?utf-8?B?bVJ5K0VvSXBDZ3ovcjNFb1QvYmtidmR5bFhpZzlvU1E3cHExbkIxMC9rb3lB?=
 =?utf-8?B?KzJucFArZUlkWDNLSjN5WlAxSTRWbmxsU1dIcXJ3WGorMklnb1FyZlc0MFlX?=
 =?utf-8?B?R2YzRlE2a2Z2dzJXM1Q4elhidFl0MStuaFNBWjRuWVBrMXVtTm93K0lnc3Bw?=
 =?utf-8?B?OExqRC95SWV6S2QwZkhvVjE3ZU9JTHlEYzArdUZhN0tocGZNZ1RZOU9rSlkx?=
 =?utf-8?B?M2JHRVM0U0NTYTFRTXRuUlQxd3dqbUVERW11cXlsanlvMklEb24zM0w1SkxQ?=
 =?utf-8?B?Q05jTVVEWmN4TmpTTnpKaDZyVjdjSGQ3bWhsRDJldEJibGZTU05OYmYvbUVF?=
 =?utf-8?B?dkwvL2RVMm5CMEZBUGduR05WZTVjR2FJcEMxZ0hFa2dkSU01Y3V1cnU2YjRS?=
 =?utf-8?B?ZEoyWXVyZTNrQnZGVEFPNWxZMk8vRUNyNGY4MXpESWlINGd2K2FaRVI2MHJC?=
 =?utf-8?B?Y3RsZGxycDU1Rm12K1p2K0xTYTIrTXF3REtWWDlCcjFnY0ZpU1lpek92WEll?=
 =?utf-8?B?a2FqQUU4Q3BzMC9lYlJRRENjeHV6TDdBSHRvU3EvSUZ2RDJWVmJiSTFZOFVj?=
 =?utf-8?B?QVpvQmZZV2dza0pYVkZ3QkpmelgxRzVPQlRUSTFweFN2T2xWUGJPQXlJUXdy?=
 =?utf-8?B?T2JIaGpHQkFFdFFMQzM0dHc0bGNXTmYyeXNaR0grdC9LQ09uYkNZWWVabzI4?=
 =?utf-8?B?R09WY1dBd2F3Yzh1UHlPbENMM0Vjcy9tM0RGamgwZ05hWnA3Z2Z5M2xTaFRp?=
 =?utf-8?B?ZUtybTVIZVYvSGpSaXlBdzdEZk5rUS82cU9JclhhWk1VS20xUy8wd0ZMQUU2?=
 =?utf-8?B?Z3d6UERYQkliWjB4UEwxZUltVFpUajVFYlpLcG9LOHhTUTRMQ0hLNm9BODRZ?=
 =?utf-8?B?NHNNQ0syNG9rdDZwdGszaXA0aWU1QnVHM3BlajNqMElwT3hkekt3NHBWeGVt?=
 =?utf-8?B?eE5oUWdCd2c5VkZuYWZoYnc3YlQ2eXNzV1pROEw1U0IzZEY5K2NkTEdra2cw?=
 =?utf-8?B?LytFWGhjSWhJRlFVNGFQSWFPR3A4UXM1VGZIb3BtQWpkYVdkcGhDSlNOT2t4?=
 =?utf-8?Q?RuYUdqDp09s0ON156mpFu9ferk4GzOzA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEtxZkVLcTJYczNlejIyNE11SWhQV0grcTRIN3Z1dkJhUUdSdzBVWVd0ZHAz?=
 =?utf-8?B?RnM2cWlYbFdrTWtrazNSZFdQRllrQjZ0R3BDaW9PVGhWbFhpZkxVU2U5NkJ0?=
 =?utf-8?B?YkhDcFdyMWJqSU1oSGRlSDR3SXVwOThjQmpLeDhSeERFUlpnZkpoWWJ6dVRP?=
 =?utf-8?B?YUV6UGRHRnNxUzJXNnVZU2MwMXdZajJ2NnIxbDNPaldnSXNsZXUvRmVVWitx?=
 =?utf-8?B?cmh5SUVJenZFMWZjOTRrcjVqZjE5NEtlRGplb0tqeXRVRmM0Vm4wVTN0Smtp?=
 =?utf-8?B?T3pvWmZqTE1Bc0RDN2tHK1pZaGZLR01LQUJxR2ZXQmNScjhuUjZ5UCsxY1My?=
 =?utf-8?B?OEVaS0gxRGg4L2dleFBaZzErd0xCZUhwRU1HRkRWc1Q1U1EraWlQUEN3RFVq?=
 =?utf-8?B?K2RUVCszaHFlMUNwbmhjMGZJNnNVYlY2ckowMjZSQ09od2RuNXNpUi9XUERw?=
 =?utf-8?B?VW0vVVNKQ3lCMnB4WUdSd0o4QzF1bG5Sb0lxQzF3WWk4aDFKTGhBK20wQm1U?=
 =?utf-8?B?T2xlODdoTUZ6YmVXOXZldWNpSW84U0tybXkwZWFjVlVTTWxrRUJlb093TG05?=
 =?utf-8?B?d0xNZGxZV05HeTIycFJQLzAxbnZGcTd4YXpMMUswc2t3cUJiREpVMXZ2MVZ2?=
 =?utf-8?B?RWFwRklyUCtzdEpSVzRjU21ndjNITGtGMExKcmhrZDBjT200V1NTaklyUHRY?=
 =?utf-8?B?NjEvK0JsM3ZqQjdXZ3BBMkhBNi95VUZtZkxEekhPTWluV3NPNGJ3ak1wRHVP?=
 =?utf-8?B?TDJaV2tmWHY0RDN0Q2pTMGJHdUNQT3l5bHJVazEvZ3FlV0J2eGVrQmhwR2c5?=
 =?utf-8?B?MDJUdDhaRDExMG1LV1FGT09FRVV6T2YzY0FZUnNzME1sT0VHam85Q3lzaUIz?=
 =?utf-8?B?NU5DZDFuQXBwL24xK3FYQTdWT29vbGN3UjRVcXF3MW1jVk9UaHNpOGhVZWJp?=
 =?utf-8?B?Unc3dXA0S3JkL2ZCQmxZN1VENEwvYVlla056SGJURjRGdzJ2K1ZSR0c3QnFW?=
 =?utf-8?B?alBDTDlZQitkU2JEVDJrR3NaUDR4dlVBSlp5dnJBUEFCcDlsQmlzVFlqekFC?=
 =?utf-8?B?S0R0cG5HOElxVUwxbzd0ZUVzN1RqaEhGcFJkWmtxZmt1UVJaby9vY2xYSTBX?=
 =?utf-8?B?eGsrNnYyc24zNlZoOXRHMDliZGl4UGQ4R1lpMHJVeGtMV25NZFhIUm4rT3NO?=
 =?utf-8?B?WFdwMnNETmdIWGNGT24vWnBtRkJRUlVYam1zMEt4ekJFVVgzR0c4UzIyU0xq?=
 =?utf-8?B?SzBEUVV6QVIvRmpPZVNDZVJZNklvRVhJckVPM0djaTkxaUlaUEprUUpSWXVK?=
 =?utf-8?B?alU2UUhPajJQSEhnc25RWW1hWlFDWnNKVjdUNmI1REhmcTA3RjgzdDEwWWxx?=
 =?utf-8?B?YjBoenk4dXBPc3NrdC9RTEZ2dThCWVdzRnBpVFRrMm81bFI2UjlPVGg0TVdW?=
 =?utf-8?B?cS9sUk85RkUxdkYxdDhOSFVKQXp5YXBvOUsrYWQ3MjZqOVNsWkFjN0ZKZU84?=
 =?utf-8?B?dkFhKzFEWllGMUlvVWJtbEw3bVcxOHJzdUtvWWhYSFVzbC9mYnZ5Z0M3NXlH?=
 =?utf-8?B?ZC9zSUhpQ2tUT1BjeDVqYW5kZTVDS3NVdHFSZlQyQkpVRDE1dUhWRm4yWVdw?=
 =?utf-8?B?aXFUYWRyYlpTZGxSdmltcXhHazNpNUxvY3BNaEdEcUJyMldNcUpDQkhoTFpK?=
 =?utf-8?B?S09DQ1lCVzlzc3hpTFNoV3dSR2IrY0xNbWg1djBPRzRXa2JpMlNLYUtGRG5q?=
 =?utf-8?B?bFFkbU5VdzhycGhVRzM1WUFsbzIwQTlYREI2Q0pRczB6ZU8wb2hGUHJ3NVU2?=
 =?utf-8?B?bXJQbnVFUzlscUpIUnhQeElZVWZQVEpUL1oxTTErbU4wWDFsTmYwbFp0REVO?=
 =?utf-8?B?VVowSy9sK0hUSDg5U1YzZjdMTHQrS3MxeitTaS9FNjZtMC9aUHUwY0ZWNmZt?=
 =?utf-8?B?b0diZzJDeW5Ka3AzSzQ2WHNLWitPTThpTVc1N1NjeXB2ZzREWk1CZjNHS3Jx?=
 =?utf-8?B?UTQ3RjRLYlc1UTVRMjh6RlVESDd3T3d6bkpIL3ladEhraThwTzZCNENMNGMx?=
 =?utf-8?B?eVB2aGRNaG8rbEdCMEhUdUo2NmtNRVc5SERuWmNxTVd5NHdsZngzRDZHVXhk?=
 =?utf-8?Q?lMa8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a5e809-da83-4c0a-8c54-08dd5c74afe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 06:03:59.2734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ds7AZERN/vacKKTc+vL1Oums3cflC7cqdRqRKJPvOvs7lo2inqQQhAMHhSEMv+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF6YXIsIExpam8gPExpam8u
TGF6YXJAYW1kLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTWFyY2ggNiwgMjAyNSAxOjEyIFBNDQo+
VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRybS9hbWRncHU6IEZpeCB0aGUg
cmFjZSBjb25kaXRpb24gZm9yIGRyYWluaW5nIHJldHJ5IGZhdWx0DQo+DQo+DQo+DQo+T24gMy82
LzIwMjUgNzoyMyBBTSwgRW1pbHkgRGVuZyB3cm90ZToNCj4+IElzc3VlOg0KPj4gSW4gdGhlIHNj
ZW5hcmlvIHdoZXJlIHN2bV9yYW5nZV9yZXN0b3JlX3BhZ2VzIGlzIGNhbGxlZCwgYnV0DQo+PiBz
dm0tPmNoZWNrcG9pbnRfdHMgIGhhcyBub3QgYmVlbiBzZXQgYW5kIHRoZSByZXRyeSBmYXVsdCBo
YXMgbm90IGJlZW4NCj4+IGRyYWluZWQsIHN2bV9yYW5nZV91bm1hcF9mcm9tX2NwdSBpcyB0cmln
Z2VyZWQgYW5kIGNhbGxzDQo+PiBzdm1fcmFuZ2VfZnJlZS4gTWVhbndoaWxlLCBzdm1fcmFuZ2Vf
cmVzdG9yZV9wYWdlcyBjb250aW51ZXMgZXhlY3V0aW9uDQo+PiBhbmQgcmVhY2hlcyBzdm1fcmFu
Z2VfZnJvbV9hZGRyLiBUaGlzIHJlc3VsdHMgaW4gYSAiZmFpbGVkIHRvIGZpbmQgcHJhbmdlLi4u
IiBlcnJvciwNCj5jYXVzaW5nIHRoZSBwYWdlIHJlY292ZXJ5IHRvIGZhaWwuDQo+Pg0KPj4gSG93
IHRvIGZpeDoNCj4+IE1vdmUgdGhlIHRpbWVzdGFtcCBjaGVjayBjb2RlIHVuZGVyIHRoZSBwcm90
ZWN0aW9uIG9mIHN2bS0+bG9jay4NCj4+DQo+PiB2MjoNCj4+IE1ha2Ugc3VyZSBhbGwgcmlnaHQg
bG9ja3MgYXJlIHJlbGVhc2VkIGJlZm9yZSBnbyBvdXQuDQo+Pg0KPj4gdjM6DQo+PiBEaXJlY3Rs
eSBnb3RvIG91dF91bmxvY2tfc3ZtcywgYW5kIHJldHVybiAtRUFHQUlOLg0KPj4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgfCAzNA0KPj4gKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCsp
LCAxNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3N2bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9z
dm0uYw0KPj4gaW5kZXggZDA0NzI1NTgzZjE5Li40MmVlNDlkMTllZTkgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPj4gQEAgLTI5MTcsMTAgKzI5MTcsMTMgQEAg
c3RhdGljIGJvb2wgc3ZtX3JhbmdlX3NraXBfcmVjb3ZlcihzdHJ1Y3QNCj4+IHN2bV9yYW5nZSAq
cHJhbmdlKQ0KPj4NCj4+ICBzdGF0aWMgdm9pZA0KPj4gIHN2bV9yYW5nZV9jb3VudF9mYXVsdChz
dHJ1Y3Qga2ZkX25vZGUgKm5vZGUsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwNCj4+IC0gICAgICAg
ICAgICAgICAgICBpbnQzMl90IGdwdWlkeCkNCj4+ICsgICAgICAgICAgICAgICAgICBpbnQzMl90
IGdwdWlkeCwgaW50IHIpDQo+PiAgew0KPj4gICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNl
ICpwZGQ7DQo+Pg0KPj4gKyAgICBpZiAociA9PSAtRUFHQUlOKQ0KPj4gKyAgICAgICAgICAgIHJl
dHVybjsNCj4NCj5BcyBhIGdlbmVyaWMgY29kZSBjb21tZW50IC0gdGhlIHBhcmFtZXRlciBwYXNz
ZWQgdG8gYSBmdW5jdGlvbiBzaG91bGQgaGF2ZSBzb21lDQo+bWVhbmluZyBhbmQgc2VydmUgc29t
ZSBwdXJwb3NlLiBJIGRvbid0IHRoaW5rICdyJyBoYXMgYW55IHN1Y2guIFlvdSBtYXkgdHJ5IHRv
DQo+Z2VuZXJhdGUgYSAvZG9jIGRlc2NyaWJpbmcgdGhlIHBhcmFtcyBwYXNzZWQgdG8gdGhpcyBm
dW5jdGlvbiBhbmQgdGhlbiBwcm9iYWJseSB3aWxsDQo+cmVhbGl6ZSB0aGUgc2FtZS4NCj4NCj5U
aGFua3MsDQo+TGlqbw0KV2lsbCByZW1vdmUgdGhlIHBhcmFtcywgYW5kIHJlZmluZSB0aGUgY2hh
bmdlLiBUaGFua3MuDQoNCkVtaWx5IERlbmcNCkJlc3QgV2lzaGVzDQoNCg0KPg0KPj4gKw0KPj4g
ICAgICAvKiBmYXVsdCBpcyBvbiBkaWZmZXJlbnQgcGFnZSBvZiBzYW1lIHJhbmdlDQo+PiAgICAg
ICAqIG9yIGZhdWx0IGlzIHNraXBwZWQgdG8gcmVjb3ZlciBsYXRlcg0KPj4gICAgICAgKiBvciBm
YXVsdCBpcyBvbiBpbnZhbGlkIHZpcnR1YWwgYWRkcmVzcyBAQCAtMzAwOCwxOSArMzAxMSw2IEBA
DQo+PiBzdm1fcmFuZ2VfcmVzdG9yZV9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
dW5zaWduZWQgaW50IHBhc2lkLA0KPj4gICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICB9
DQo+Pg0KPj4gLSAgICAvKiBjaGVjayBpZiB0aGlzIHBhZ2UgZmF1bHQgdGltZSBzdGFtcCBpcyBi
ZWZvcmUgc3Ztcy0+Y2hlY2twb2ludF90cyAqLw0KPj4gLSAgICBpZiAoc3Ztcy0+Y2hlY2twb2lu
dF90c1tncHVpZHhdICE9IDApIHsNCj4+IC0gICAgICAgICAgICBpZiAoYW1kZ3B1X2loX3RzX2Fm
dGVyX29yX2VxdWFsKHRzLCAgc3Ztcy0+Y2hlY2twb2ludF90c1tncHVpZHhdKSkgew0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgcHJfZGVidWcoImRyYWluaW5nIHJldHJ5IGZhdWx0LCBkcm9wIGZh
dWx0IDB4JWxseFxuIiwgYWRkcik7DQo+PiAtICAgICAgICAgICAgICAgICAgICByID0gMDsNCj4+
IC0gICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gLSAgICAgICAgICAgIH0gZWxzZQ0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgLyogdHMgaXMgYWZ0ZXIgc3Ztcy0+Y2hlY2twb2ludF90
cyBub3csIHJlc2V0IHN2bXMtDQo+PmNoZWNrcG9pbnRfdHMNCj4+IC0gICAgICAgICAgICAgICAg
ICAgICAqIHRvIHplcm8gdG8gYXZvaWQgZm9sbG93aW5nIHRzIHdyYXAgYXJvdW5kIGdpdmUgd3Jv
bmcNCj5jb21wYXJpbmcNCj4+IC0gICAgICAgICAgICAgICAgICAgICAqLw0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgc3Ztcy0+Y2hlY2twb2ludF90c1tncHVpZHhdID0gMDsNCj4+IC0gICAgfQ0K
Pj4gLQ0KPj4gICAgICBpZiAoIXAtPnhuYWNrX2VuYWJsZWQpIHsNCj4+ICAgICAgICAgICAgICBw
cl9kZWJ1ZygiWE5BQ0sgbm90IGVuYWJsZWQgZm9yIHBhc2lkIDB4JXhcbiIsIHBhc2lkKTsNCj4+
ICAgICAgICAgICAgICByID0gLUVGQVVMVDsNCj4+IEBAIC0zMDQwLDYgKzMwMzAsMjAgQEAgc3Zt
X3JhbmdlX3Jlc3RvcmVfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4qYWRldiwgdW5zaWdu
ZWQgaW50IHBhc2lkLA0KPj4gICAgICBtbWFwX3JlYWRfbG9jayhtbSk7DQo+PiAgcmV0cnlfd3Jp
dGVfbG9ja2VkOg0KPj4gICAgICBtdXRleF9sb2NrKCZzdm1zLT5sb2NrKTsNCj4+ICsNCj4+ICsg
ICAgLyogY2hlY2sgaWYgdGhpcyBwYWdlIGZhdWx0IHRpbWUgc3RhbXAgaXMgYmVmb3JlIHN2bXMt
PmNoZWNrcG9pbnRfdHMgKi8NCj4+ICsgICAgaWYgKHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4
XSAhPSAwKSB7DQo+PiArICAgICAgICAgICAgaWYgKGFtZGdwdV9paF90c19hZnRlcl9vcl9lcXVh
bCh0cywgIHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4XSkpIHsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgIHByX2RlYnVnKCJkcmFpbmluZyByZXRyeSBmYXVsdCwgZHJvcCBmYXVsdCAweCVsbHhc
biIsIGFkZHIpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgciA9IC1FQUdBSU47DQo+PiArICAg
ICAgICAgICAgICAgICAgICBnb3RvIG91dF91bmxvY2tfc3ZtczsNCj4+ICsgICAgICAgICAgICB9
IGVsc2UNCj4+ICsgICAgICAgICAgICAgICAgICAgIC8qIHRzIGlzIGFmdGVyIHN2bXMtPmNoZWNr
cG9pbnRfdHMgbm93LCByZXNldCBzdm1zLQ0KPj5jaGVja3BvaW50X3RzDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgKiB0byB6ZXJvIHRvIGF2b2lkIGZvbGxvd2luZyB0cyB3cmFwIGFyb3VuZCBn
aXZlIHdyb25nDQo+Y29tcGFyaW5nDQo+PiArICAgICAgICAgICAgICAgICAgICAgKi8NCj4+ICsg
ICAgICAgICAgICAgICAgICAgIHN2bXMtPmNoZWNrcG9pbnRfdHNbZ3B1aWR4XSA9IDA7DQo+PiAr
ICAgIH0NCj4+ICsNCj4+ICAgICAgcHJhbmdlID0gc3ZtX3JhbmdlX2Zyb21fYWRkcihzdm1zLCBh
ZGRyLCBOVUxMKTsNCj4+ICAgICAgaWYgKCFwcmFuZ2UpIHsNCj4+ICAgICAgICAgICAgICBwcl9k
ZWJ1ZygiZmFpbGVkIHRvIGZpbmQgcHJhbmdlIHN2bXMgMHglcCBhZGRyZXNzIFsweCVsbHhdXG4i
LCBAQA0KPj4gLTMxNjUsNyArMzE2OSw3IEBAIHN2bV9yYW5nZV9yZXN0b3JlX3BhZ2VzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LA0KPnVuc2lnbmVkIGludCBwYXNpZCwNCj4+ICAgICAgbXV0
ZXhfdW5sb2NrKCZzdm1zLT5sb2NrKTsNCj4+ICAgICAgbW1hcF9yZWFkX3VubG9jayhtbSk7DQo+
Pg0KPj4gLSAgICBzdm1fcmFuZ2VfY291bnRfZmF1bHQobm9kZSwgcCwgZ3B1aWR4KTsNCj4+ICsg
ICAgc3ZtX3JhbmdlX2NvdW50X2ZhdWx0KG5vZGUsIHAsIGdwdWlkeCwgcik7DQo+Pg0KPj4gICAg
ICBtbXB1dChtbSk7DQo+PiAgb3V0Og0KDQo=
