Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD74C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 02:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E90110E5D4;
	Tue, 22 Jul 2025 02:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNsXImUl";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9A010E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 02:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGaLcnxifDCHQZ8CyNYFAeQoE4zHE2Vp460GCIUxvMnOzSWQYj07nld3RVM/j/zedrp4q92nBqNLQH+gp/cIIhDztN5QNjikrw4Y/OqS/d76curlI75P68zCsM8W0rcTixAi8TwH7SRR/zyFLHohIyntA/DiwMBxYgBlmVlQhDIToTiKfWL1F6Wj76Pbmj4pSowTyA6KavTg31IpxHK0woXyWXeftKhbqP9fW42dQYluu5cFarJDQkdO+A3CzgCm+td+zMdU+tzyF/hJO5CvVWYYg6mwb1HcXv+ihErMFOdTBizKZMtLlaXjR91GOSTikmHKFde+pPrVRStUjmsVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nLpI5GH4SSOV8MzdwJSckzp4Ilh5VJH3W65PedKOO8=;
 b=FJAtWY1H0bAnXkAiThM2OS6gebIsn5FJjAFGf99vn/oNVf8bUGAVdv84dYmKNjO8Tnxyvm3ca7Y64LposwDp9Fp+ORKNdpBgUivQmlKbCBwYJoRC+R5cuwMGHuPsPeIRj0jztOaUgTEDT79QGTA7pCI9gc2hbFiZ78Vh1BmWYQWe+arK4q9ALuqdxLw/d+sUe7insSN/yGGeGINakWpClIv7+iQ4KRqBBuPBbsZQiN9igGwaB2y4TwuSkfAyCRiZYa66gbFgyuX989r1Bp9kx3C8+QVvKeft49v6xeok4QqjlQ+ZONq1BQB+TmyWUyrARuCzIiOv4vuZUe+RWe41FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nLpI5GH4SSOV8MzdwJSckzp4Ilh5VJH3W65PedKOO8=;
 b=uNsXImUlRxmfzeqEc5AVKnUpy8UmNE8x/OxZpcGy/pa64/nP/ICLpeO+N5AKaHs1UHOpwOrL+pZSUGy+fJzo1wKbhxrDdLYMeYR/0s+H8VrTNm/rFKT3hN0ft9ahNr04ZN0e0UEhgTRmpbM01sdesy4PpyPzpUfJYpZ7FinKjJk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 02:38:06 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 02:38:06 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 types
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 types
Thread-Index: AQHb9p04fojfbh/6M02fXfMrrWtRW7Q9dcSg
Date: Tue, 22 Jul 2025 02:38:05 +0000
Message-ID: <DM4PR12MB5152FD2E9D0CB1289DCC5B59E35CA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
 <20250716220115.3872837-2-alexander.deucher@amd.com>
In-Reply-To: <20250716220115.3872837-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-22T02:36:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA0PR12MB4352:EE_
x-ms-office365-filtering-correlation-id: 947826ea-9b05-4cfa-c8a8-08ddc8c8c965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YWwrRHY2WDhNQmZVQW45cnlFRnNMU05yRklxbXFHVDBDb1gwWlk2dGJrUC83?=
 =?utf-8?B?cUFtOVVaUm5sWVJlM0EzVWhqRmJJRTdMRjNEZVh5azVyNC8zTklSV3JPbGVJ?=
 =?utf-8?B?cjE2bWoySEE4TjBVUWhuMThoWlgrM282OFUwZjJIOEM5TWI1TkZ3WU5PeVh5?=
 =?utf-8?B?L1crd0tmZkUzRDhDWFN5ZXVLRmJaNlZuQkVDVFU5ZndoaDNIeUVmVzZYalBB?=
 =?utf-8?B?Z25GdkFEbXQ2ZlVSWnJ3ZXk2ZjYxZ0dkMmZVUTF3Z2tPQVdZVjZJYWQ2bENw?=
 =?utf-8?B?bEJBSVZxUis1MDgwbDNoTnFiSk9Eak9wTWs4N0Z6QlI3R0lkY2Q0UzRVOENG?=
 =?utf-8?B?M2RaWnBEenhSWjlSZFRycUpRSC9yb1B1RGIyNUE5UFh0dURtZ2Uyb2RZcjlj?=
 =?utf-8?B?OUVZRVRTeVN1NmJXcVJwR1c5Yk9KUEt2elJ1V1VwbzZ4WnB4K0FTZmNSZHEw?=
 =?utf-8?B?THBsRjI1WW8yc0o3VGhMOVlFTk9xck5BMVkvODF0bUdzUDJOU2hGUDAzaWsw?=
 =?utf-8?B?QVhOb0xQdGpSaHBranlNYkNZbXdaWmQzekVkc0k0V3VKdVZRL2ZaaVNCQW1p?=
 =?utf-8?B?Tkp0YnhnVXd3eHpTUUM1TURNVXlFbVE4V1RVNm1Wc3pZS1BPQVVKYjNhT3lI?=
 =?utf-8?B?cmFnTWNsb1FRVjM5NXFWbjNZR2xHUEpBTm9aNW9iU25sY2w2d3UwRmFrNEdT?=
 =?utf-8?B?Mmo0RkdFZGN3SWxmd2Zzby8vSFpGZ01aRUQzbC9ZYW5wL0hCbTEzS0ZCVmtB?=
 =?utf-8?B?eU0weFdLVlJSTnkzcVFCMllaeXNNRG1qTk5USDRJT1JUY2VadGxDQ2tsSGhk?=
 =?utf-8?B?MHBVUFZjTngwZG5JT1YySXdjc280RDZlZmtrM21CY1lXZFY1WWxaRUUzckJx?=
 =?utf-8?B?V09LbDR2N3NUdWhUMTZBdGdycW9iSlVIcnh5TDloVTNOWWFuMU9lZTllMWd3?=
 =?utf-8?B?MlpzTHRRaDhya2ZnMlAyT0FqNnczR3JuRkgvaDNSN2lDKzhTUFlzengvUVNi?=
 =?utf-8?B?MnRGaEFWK25wNHFmek5EUkh4eWkxY1owUVpuUHltTEQ0d0hlMzh1eTJKbDdm?=
 =?utf-8?B?TElLRU5VdStjcENHYmZOc3RSRE00NGlIYS9pMnV3ekJMS2g1cHgralplMTA2?=
 =?utf-8?B?aXFPOVZDNGEwSzhabXpydG5DS0oyUHhselNxWmh0cVhXTFhjM3daKzNxYUpX?=
 =?utf-8?B?VUR3WllrZnVRejAvckY4TWphNktWOGNXM2dMVlZFZzVEQUhGTi9BdVAvTjFo?=
 =?utf-8?B?dGcxUDdycmRtVjYyWm9UQy9hcTh1amlEZ1R1NHRoTE54M09qbGZ6MjFDUGtF?=
 =?utf-8?B?M0k0a0o2ZHVXOVppWkcyRytEUys3K3VmaFU5QnlFRlE4Szl1QWJRSUFDQjgw?=
 =?utf-8?B?d0RIR2xIYWFmWnVMRGFrcGFXRVk0ektCckJNZCtUNGRKdUl1c3c0aHFvb0RU?=
 =?utf-8?B?TTZ3NTBmc0tXWHNGZFlaVXppQkNQeUpOMisrL1oxTW5UcVkybURqbnNzVDIy?=
 =?utf-8?B?Y2d1bUpLM251TDZGSkxrOE5qZlczbXVROGwvejBjbHlsbVU2TVlBeTgzWHBH?=
 =?utf-8?B?U3dtaXkyY21zZmo4eWl2eWlNODBORHhicE1sV1hnc09OMDNESnFESmVlSUhY?=
 =?utf-8?B?SW05ZytYQWxYRTBUSXRaMWZmbEdmNm5GS1NBNlh3ZGtHZ3JiN0pQbWtUZmpu?=
 =?utf-8?B?RFVWNyt0U3A0ZDRManlmU0NIWTQ2VWVNRTZtbHJSWlNzVklmT2gyeE1kTXc1?=
 =?utf-8?B?c00zdlgrV3NHb3RNaEMzR01uUHh6eng1SktSc2dMamw4b1I1RDE1TGc1d0pF?=
 =?utf-8?B?OGV2K1NrajdkMG96TDVPdGFoVzBUK3FpRTY3ai8rTnlJMTdjR3ExT3JHU3hm?=
 =?utf-8?B?WVNCYU5zeFFnVHBKU0pHNUZ3cVA5SW5ReDZlL1lNdldkUHRxZ0w0eWVlWFJq?=
 =?utf-8?B?bzdFY2tpTFpjUEVLaThlZTlzdVRJd0JPZVpyODFkcWlMKzdjWHVhMUZYZjk3?=
 =?utf-8?B?WXc4MEkwbWxRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnZvNUNzMC9jclpHNVNFb1o3V084MGtGVG1vSm9VYTBDK1Z4amJsS1F2TzFz?=
 =?utf-8?B?VnArTUMxOUFKdm9SeGs1QlFVTTE2RFp6cXRCUmF2Wm90QXo3dHBXeHkySk1j?=
 =?utf-8?B?eHNSengvUmcvZEsyMDhIQ1F3V2VEQzRpa2I0V0FNM2xsVk5ERVROZlJZRk1U?=
 =?utf-8?B?REhxQXV6ejFkRjVST2ttTWJtVVozWEdhbEN2dTdrZFJ1OS9FTmhxaW4vMlVu?=
 =?utf-8?B?cWk2UlZidVBPQzFHbkczcWV6b0ExVmVlN1RlRFIrUjJKdjJKOUVhYzZOaGk0?=
 =?utf-8?B?bEJzSXdzRngwOWZBVllES1NNT2w5K21HaXo1NFo1U1FObFZxVDEzUHozUUhH?=
 =?utf-8?B?NTJuNmZpcjA5VlZrRkZEaE1FZGlhZ3p2MUVPR0dXaDd3MjhUbzlSU09WaW1F?=
 =?utf-8?B?b0ZvRjlNbGJTOGJHU3lQREFBUVZwa1Q0Tm4yV3IyZWZaaElHMGp2bkhSN1JW?=
 =?utf-8?B?THpRRFNpUGViOFRBVVdNUENjY0pTdDBxSGtWdzBORE1oZUZqOGR4dWd5M1Ry?=
 =?utf-8?B?UHFuaTQxTDFxdnJOVXVYSjFFdHo0UFVoVlAvT3VKVDkxWThFSTlyV1IvNVoz?=
 =?utf-8?B?d2lPa3FpTCtKMlpaZmFhUHFaZ0IzbW5IVWQyZzNqK1RQbzFZei8zZmZlcmZu?=
 =?utf-8?B?UHg2S1U1cDgyWmVncHhRbGo4cWxOSWRlSmNDNkxpOGp0UEhEMWRrTUgrNmRB?=
 =?utf-8?B?c1lYRTdvQmIrVkxMQytBUzJZclA2K3ZWOVZGcE5BUWRFYlJQOUxxQTk1L09p?=
 =?utf-8?B?VTloeGZwOFArTzc0VWlvL2tBTDhjUDlTcTNzdTNrKzZ5dGlaWTFlb1I3cWVC?=
 =?utf-8?B?b1pQaHlwbVN2SS9KajFrVWk3aGoyK2Fad1cxWkc5eEM4QmhNQWJUbzNKdU5D?=
 =?utf-8?B?TW5LcWVvTU9QQVVYTkY4RFBjVHJjUEg3eUl5Z1JOZG1pWTZJaDdHT3ZxMm5z?=
 =?utf-8?B?SW4vRVRVSjFpNVRtVWVVTVc1SUNXSXp0UHY2dVAvZEwxa3pkQWhyV2FCZi9x?=
 =?utf-8?B?NGEvR240Q2ZRSW5VbFgyZWVLc1hqWEdPQXgrZ2I1RVRHQzBwVWw3NlNiZlVv?=
 =?utf-8?B?dEIzZTRhWDRUcUFNemsxbDZLeDAwM05odVR1MFl2MmM2b1BrbHl0R0ZweXhL?=
 =?utf-8?B?V3dPbFQ5UWFkK3JSV2tleXBqbm1ybWNaYVUzYm9zdmFrMVg5RTB1R3JMaVhG?=
 =?utf-8?B?eVRlRnF5cERpWHpaeGFEanZwUnQ5eTZiaGNBZXRhRWkzaTRobHNSc0kyWTlv?=
 =?utf-8?B?NkRsUVBLTGx0Z2ZUMmZWZ1c3N1FRSGxqRG50MjF4eFM5bDBPUEQrWXFDOWpY?=
 =?utf-8?B?bHFhNEZHYWhDdG5mdWM0Wk42VzdhYUdZOVo3RnVLMWE3dS9UMFZKUWJWQVV2?=
 =?utf-8?B?OGpLUkNKZFpRQVI0Nkk0STZPV0JtL2lwOGgzM0VRaEJPdXQrVllXbXlac3Fl?=
 =?utf-8?B?Uy9mRWlVR1dPZFdoLzRUSzYrclV0NmNKeVFLQ2FObjl2ZTZnOUdReWZBZDJw?=
 =?utf-8?B?R0RINksxVTUwYTg2WDRJcWtVK2ljTEsxNXAzK2FKdVR6VlhjQ1A3Q240Yndq?=
 =?utf-8?B?V3ZWZGI3cTBkdXNYcU85L1FmSG9tNGlTQkFpQVNBV3lBVzREVm44cjV3TitP?=
 =?utf-8?B?YUlPajQyOVJ4c093RVZXZXJGNEhyVkJXZ291aVB4MjlIQk1ZK3MzYUpabVpx?=
 =?utf-8?B?eUlldmNZdk9SMTZsTlZ0U1hTMWxVNC8yMERWN1FWWWtEWEVocWNJNTFYcUtH?=
 =?utf-8?B?c1l6d2FuUlQwaDRFMGluRlJWLzBIbzZyREY5QmppV0hBYVAwZ1BQK1dYTGNV?=
 =?utf-8?B?VHBPYlZPT1prVlQ1VGx0RSt6MmtrQlllT1ZieTZjM04yc21RY2llQ29sQVVO?=
 =?utf-8?B?Z2FRN3Ezb0dFVHdMdnd0TXZUMHU5NDRZNlFFTUtZaDRJUTBOWDFUdGI5N1B3?=
 =?utf-8?B?MjlvV1B3WmFzY2NuTUNVczF6OThMU2psY0JBdmpleGh5QS8wZFlncmdWMUQx?=
 =?utf-8?B?NUxOV090NTdsSVArTEdVQ21yaGhhdHJvUkdMaWZRMVJ5aW14ZFdFN1p2cVVG?=
 =?utf-8?B?WGkrT0NKVEQrN1IyMFNtcVBpQmU4WTZmSEJEelZzYlJsQUkyYUN1QkQ1dGd0?=
 =?utf-8?Q?o3Fk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947826ea-9b05-4cfa-c8a8-08ddc8c8c965
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 02:38:05.3801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1YCzLyNVfz1OBNfoIFIm78YmhOTNNyws5QJX487Zsz8fYIa7UzZCrsHngiM7a/J2SMRn3MOCBmCVp7hO+ywvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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
Cg0KSGkgIEFsZXgsDQoNCldpdGggdGhpcyBtcWQgY29uZmlndXJhdGlvbiB3ZSBnZXQgbWFueSBj
YXNlcyBvZiBpbGxlZ2FsIHJlZ2lzdGVyIGZsb29kaW5nIGFuZCByZXNldCBub3Qgd29ya2luZy4N
ClNob3VsZCB3ZSBjcmVhdGUgdGhlIHByaXZpbGVnZWQgdXNlciBxdWV1ZSA/DQoNCg0KTG9nOg0K
W2RybTpnZnhfdjExXzBfcHJpdl9yZWdfaXJxIFthbWRncHVdXSAqRVJST1IqIElsbGVnYWwgcmVn
aXN0ZXIgYWNjZXNzIGluIGNvbW1hbmQgc3RyZWFtDQpbICAxODAuNDI5OTcwXSBbZHJtOmdmeF92
MTFfMF9wcml2X3JlZ19pcnEgW2FtZGdwdV1dICpFUlJPUiogSWxsZWdhbCByZWdpc3RlciBhY2Nl
c3MgaW4gY29tbWFuZCBzdHJlYW0NCg0KDQpUaGFua3MNCkplc3NlDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogVGh1cnNkYXksIEp1bHkg
MTcsIDIwMjUgNjowMSBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyLzNd
IGRybS9hbWRncHUvZ2Z4MTE6IHNldCBNUUQgYXMgYXBwcmlvcHJpYXRlIGZvciBxdWV1ZSB0eXBl
cw0KDQpTZXQgdGhlIE1RRCBhcyBhcHByb3ByaWF0ZSBmb3IgdGhlIGtlcm5lbCB2cyB1c2VyIHF1
ZXVlcy4NCg0KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4NClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jIHwgOCAr
KysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQppbmRleCAzNzJkY2VjZWZm
MzU5Li45ZGQ0OWIxY2FhNjA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMV8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFf
MC5jDQpAQCAtNDEyOSw2ICs0MTI5LDggQEAgc3RhdGljIGludCBnZnhfdjExXzBfZ2Z4X21xZF9p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB2b2lkICptLCAgI2VuZGlmDQogICAgICAg
IGlmIChwcm9wLT50bXpfcXVldWUpDQogICAgICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVM
RCh0bXAsIENQX0dGWF9IUURfQ05UTCwgVE1aX01BVENILCAxKTsNCisgICAgICAgaWYgKCFwcm9w
LT5rZXJuZWxfcXVldWUpDQorICAgICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAs
IENQX0dGWF9IUURfQ05UTCwgUkJfTk9OX1BSSVYsIDEpOw0KICAgICAgICBtcWQtPmNwX2dmeF9o
cWRfY250bCA9IHRtcDsNCg0KICAgICAgICAvKiBzZXQgdXAgY3BfZG9vcmJlbGxfY29udHJvbCAq
Lw0KQEAgLTQyODEsOCArNDI4MywxMCBAQCBzdGF0aWMgaW50IGdmeF92MTFfMF9jb21wdXRlX21x
ZF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB2b2lkICptLA0KICAgICAgICB0bXAg
PSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsIFVOT1JEX0RJU1BBVENILCAx
KTsNCiAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QUV9DT05UUk9MLCBU
VU5ORUxfRElTUEFUQ0gsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJvcC0+YWxsb3df
dHVubmVsaW5nKTsNCi0gICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QUV9D
T05UUk9MLCBQUklWX1NUQVRFLCAxKTsNCi0gICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAs
IENQX0hRRF9QUV9DT05UUk9MLCBLTURfUVVFVUUsIDEpOw0KKyAgICAgICBpZiAocHJvcC0+a2Vy
bmVsX3F1ZXVlKSB7DQorICAgICAgICAgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQ
X0hRRF9QUV9DT05UUk9MLCBQUklWX1NUQVRFLCAxKTsNCisgICAgICAgICAgICAgICB0bXAgPSBS
RUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsIEtNRF9RVUVVRSwgMSk7DQorICAg
ICAgIH0NCiAgICAgICAgaWYgKHByb3AtPnRtel9xdWV1ZSkNCiAgICAgICAgICAgICAgICB0bXAg
PSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1BRX0NPTlRST0wsIFRNWiwgMSk7DQogICAgICAg
IG1xZC0+Y3BfaHFkX3BxX2NvbnRyb2wgPSB0bXA7DQotLQ0KMi41MC4xDQoNCg==
