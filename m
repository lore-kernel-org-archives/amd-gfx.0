Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD26C52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 19:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817E110E537;
	Thu, 15 Aug 2024 19:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTm9JIFV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E020D10E537
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 19:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynE+4TfPqUMjblN2GBQIxCrryPV8xWLacH82y5Y8Q5qmMVfdwGNqnmxbPEjiy/z9v0lNauUEIjmYhNcY1ViPFemLCVi44R0PvQXJC8ej/jIF0YSynEkdEZ1k7U1ah27vMdQsQ+8kF4PxH/WS6+Gr3JjNlzz0S9w1SQa05TjSKah39gbeN8iHaEneGErzR8W9+2g3/YuhSBWC/7m7iJBDJhL3FmtvzjJ/sbANJL5MVX89GenZXbkkjgroP/Pi1TIA/JNJssW+jXY1DQLy4RyfjRFOvxgTzomGuPv5h9CTCJ91L16On1dqvftff/AgTIV9U1qVqBrSbNEkjGBZp/JcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIufNPJieSVbW0HPdiaG9OurHqW0SEKBUHG9FSYMVh0=;
 b=e74EJ7Hd/Fmfa4v27vCLxIw/6LjR8z/R+Ms1jm1EjKjq2p+dYz27qy08hBm0UiRcWKCUI4AG6etyS9ZML9HIf8eVrOp8GgCusI5+5r3yb7uG7jEdkhici0jjnoNVei/mH/+7Cd4Kh9PcljFsMyXHdBk9xCAOxJWZIl940B7kZhg5o0etVDbTe57z1FkTFMSeO8Uncj2CtSmDEEOsUWnSz8OR8n1ucXc38iMxhokyT+oNoqJhL5s3oNUPw6wKiKxhfV6qfRdg5ayF78s57vMRWCSLMO3GCwLoQpkUOjFuD8pS/Azs2T0YaKIFHmGLS5/Ejn+nkLVn+ix+CjvT1PIeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIufNPJieSVbW0HPdiaG9OurHqW0SEKBUHG9FSYMVh0=;
 b=PTm9JIFVmMMIwFga8yxg9IjooEPVp7+IFzSSmXsoocEUj77mGkiEft7VKyyMgMmLHcWohygez8vwuWpoH26cV0YIMr/rdqy9ZP8sGRwB4KuZInniM6PoyVjzTGZNWKPXAaK1sHhaJCS9CtpB+aa1WFc7g5H/v4Hybb7j1+XFEBo=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 19:55:46 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.7784.017; Thu, 15 Aug 2024
 19:55:46 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Topic: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Index: AQHa7qHAk2INKDfbt0eY0Mux7UCn/7Ioo68AgAAY4cA=
Date: Thu, 15 Aug 2024 19:55:46 +0000
Message-ID: <CY8PR12MB70998C66E432A5D8E53E9FB58C802@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <20240814232754.1119319-2-mukul.joshi@amd.com>
 <e60025db-2cf9-4976-9351-67a69973f6b5@amd.com>
In-Reply-To: <e60025db-2cf9-4976-9351-67a69973f6b5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=996307c5-e498-4f41-b2a9-72dd87548114;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-15T19:54:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CH2PR12MB4069:EE_
x-ms-office365-filtering-correlation-id: 74ed0d16-50a2-4d50-8268-08dcbd644117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3c5MHFCN0k5M1RJM1lVTjZNK1VJYnhvYTg2ZkVPWG8zNkwvUW9VREh6UnZj?=
 =?utf-8?B?aldQdUdSNU8vd2RKNjdJUW5JcEdOTFdaN00yczVNRy9HM3J2aktzYTRVQm1W?=
 =?utf-8?B?dkJPTVFPOWVUcWpLM1p1Wmo5d1N2ekJRSDI5ZGE5blRWNWNmMTVaVW45Mms1?=
 =?utf-8?B?MytIU012dW9UeENDMWl3R1BqR29mRDliZ01sU2hRVHVGU1hocFEwUWxWUXd3?=
 =?utf-8?B?UW43OEQxRWpiT0gvTGpRNUl0QldyNmxaWE5nbjkrWlFxVHNLY2ZKek5US0JD?=
 =?utf-8?B?VU1Gb2h4ZjJ1RUJ6VXN2dDFia0EwaDE4M3hxQm0xbUlNYzdlNzg4WnhJWU1x?=
 =?utf-8?B?bTQxcml5SndkWjd0L3UvV3V5QU5LVGhPTzlUbkdmdUFFOHh3c081ZEs4Wm1S?=
 =?utf-8?B?NzVoUUdYLzdUclhHeWNJbmRnQjZPcUthNkxUZE9Ta1lYQkZjN2NQNXZJUmxo?=
 =?utf-8?B?TWRBSTl0VlFaNFd1QjZEcGFzZU5MajRDb081TWF2M1YrbGdPK1NaNS9RTlFl?=
 =?utf-8?B?MlpCZ2ZRWEc5ZU94akpqaXZieTA4RmcxZEMvQUd3andhT0wxR1J6ZGFKdkhr?=
 =?utf-8?B?TUlKQmlGSld5OWV0dFNjMFhPSnNNdGovdVFuSTRheTNLZ05GZ1N4YmR1QkJL?=
 =?utf-8?B?NExFR1RtSU4wakRuTEQ2TWVSeUtWKzU2KytQRzZPeTh0STdSd2tPNHl2SWhm?=
 =?utf-8?B?dE1KS0lVdmtKNUkwVk40QWJiSUtOa2ZqS1NFQzdzL2IrOEZQVDFRaXRYSmp6?=
 =?utf-8?B?Y3FKZzBqc2FFSVhXUGRnZ3I0K1RKdTJ6Q2dYYkVqMWJDdmZNN1RWR3JjWWtk?=
 =?utf-8?B?WW8xRmlVcHlHRzBHNmQ0eCtpQ09YTjBFMEpuY0M0MWx1aTg2aU1CUVlkQjVE?=
 =?utf-8?B?aENIbDVBUmFkaTdqUGhraHR5ZXVpVEczZGxxbm0vaEpqRHRVcnZRalR5NnJ4?=
 =?utf-8?B?b2NPRjZoVXFsSTFEdDFJZEYrMkJDc3B0QXZhd3htai9hZ1VEQVdiejA2alZL?=
 =?utf-8?B?eVlBOFM5L08ySkR2MHlpT2F0cVJFd0xac09yZmF4cVgzcEdJUUtiMmFYZEdi?=
 =?utf-8?B?bUZnZCtPdklCQnZVNyt2YUFrOFhSMXpwNk5sMGl4ZENST0twZEJmYzFvMjVW?=
 =?utf-8?B?Ny9RTVoyb2pBemQ4NGZZbmVTamxEQUVxSDFsRDJ6KzJqcktuTWV6b0JvcWMx?=
 =?utf-8?B?N3g5aWFBRmdKUEVsTHNHSWlGTWNJc3hPTWxLVXpOSFZ4Rk5Hd1lqOWV5M3BD?=
 =?utf-8?B?Um5nTjJzb2N5U2RXS09ZbGFsSDUxTU1wbE04ajB4TzZ0Z2FWSGRhdXMwc2Qr?=
 =?utf-8?B?c293MW83TEhaaEVhaSs3S3VpblA4YVE3K1I5bUJ2Nm9oZ004TFNpallpSTBN?=
 =?utf-8?B?V3dLK1pQakhoSWxXaXpzSW9hcnM3c0NPM2JaNy9HSWJWOXl5VjdOZy9vV3B0?=
 =?utf-8?B?RStyMVRwOVd3S2w2VHQ5QWQyRE9EMlF5R2tWeVFrSlFRbUJlVnZ4dVdYVTlQ?=
 =?utf-8?B?RHo1M0h1MkZpREp4alJPN0s5RzU5OUFFbXFDck1jazRBQmtDL1REdmdDSVNz?=
 =?utf-8?B?dTRIcWxESThxZ0FNSktBWm8zYWFSTHBZa29wVFQyblFQMGhpdGRiTEFibFBz?=
 =?utf-8?B?ZEpKR1RvbFBvWjIzS0hIdEgrVzgwQ01nUTFaaUc0V1hsanpteGF5TmhvRUFs?=
 =?utf-8?B?d0h2SFNjd0JlSkUzaXJNUmwvakFPMCtsOThKbzkwbkMrYmc3dTBCSVllMEdH?=
 =?utf-8?B?Q3J4di9kdHhvR3ppaEQ2WkVxRkFKZHNuUy9mNk01MEJWYWFrZXRkZko5M0dG?=
 =?utf-8?B?Mk40ZGw4cWxBKzNXTkIzSGMyTmZrL1JoNkxHNmZHYVlSRnQxVzNOYm1FWHIy?=
 =?utf-8?B?dXk4cTRnKzhDZ3VKd09sSUxnbjhVWmdTQ0drVUxUbjgxRHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3NVNWp5RURIRENHT0tjc2p4UDh5eUQwREVvMUxjamFRYXlOaVVRd29LNUVW?=
 =?utf-8?B?LzBBU0dNTnIzTFhjMDV3eFJFbG1rM2VOZ1ZYK0ZiTXRUM2tQNjJjZEx0b2FX?=
 =?utf-8?B?d3FmUlhlN2dDV2EzNDJWOTgzeEVMVHhGTTB5MmJzNlBFSEU2amxSMUFYRlA0?=
 =?utf-8?B?dm1ITWFyKy80WXBsS1M4UVdGQmxqdzVmMW15dHF2blBVV0g2VGs2K2prS1F5?=
 =?utf-8?B?Y1RqNVZaRUhtUlhlTitxb3lOUDV3WEwzS3JHbTB4cmFERmx3VDNObHFkSHpO?=
 =?utf-8?B?VE5iSnVZUjlCVisyY2NqRk01UG1FK1cxRnM2bkNYYlI0TFI0REdDaC9FKzBz?=
 =?utf-8?B?UW91WVl5NVg1QVNEUTRZUENqYjlyZE1ReVVXbDNBc0o4V2tHTXFLWWdXL1N2?=
 =?utf-8?B?OUh1T1JleFBENHdCck9BREgreWVsTitKUmk3RTFFWmFWQzJoQ2FWUjhHUnNv?=
 =?utf-8?B?cnVCMTlja09GRjNxRzZWVlVNV0FoYzdYR2RHYndpTEdRWjJSUU1SeTgrbGVD?=
 =?utf-8?B?RHVpSVR5V2oxa2MzLzRPMnk4b0ZhZkpLd0E4dE1QdUJhc3VJZzJZK2NSdzJ5?=
 =?utf-8?B?aUVMSDNlcHNjK29oNmx5MFg3SXBzbnRzSFIyU1MzKzJtUWUzWkNITFZldHNt?=
 =?utf-8?B?YmNoSGUrUll2b1BZZ2xzQkVSUDcrc1dCSGo1VVRGbWw4VzY2SW54RjVadW9V?=
 =?utf-8?B?elBQT2Z4YU56d3k0VVNxOWJGbC82WFIrLzRTNHVvRkxZcXpSTUtlZi9tOENw?=
 =?utf-8?B?Yy9wT0F4NVJoSS93eVVydDl3em5SWVVsbTg5Y005ZCtpYWd2UytOdjl2T2Yy?=
 =?utf-8?B?L2dFcU90alIzMWdHbVVHK21aRHR0U0VBMWdXU3RvNnM2WHpMc0RXeFpMZFQw?=
 =?utf-8?B?em5sZkEwOFJZaXdocUlpN21hZ05iN0kwWC9BZHBFakxwUlJJY01BY09ZMzhS?=
 =?utf-8?B?R20wUnNUcncrLysxVXI0bzhJcE1sQzBId3NBd1V3ZzlOWENtWjdYQWgrNkZJ?=
 =?utf-8?B?bUtyOEVoMm40VlBvaXl5VXdSRlZkd2UwcXNtV0tnRlkzNllXZDloSDhMOUJn?=
 =?utf-8?B?VUpsQngyMXBiMjN3eXJBNlJCY25EWlFWNzI4dXZMb1g4K0RtOXRKQlpNWHY3?=
 =?utf-8?B?NTJlb3dheWY1OUJqeVcyK1NwblpiaVdBOXR5cXEvVHpoTWJHdThRSTFEY3oz?=
 =?utf-8?B?dE9UTVZaRUhoNUFSZmpaTjlMMnN5Z1d5SVF2V2N6SlpadlRIRmpoS0RSbnQz?=
 =?utf-8?B?cWxLTG1uQVhnS0dvdUluNnpOVGFrWnJMTFRpK2hvR3NFc1RDMjVlbEtPd1dn?=
 =?utf-8?B?OXI2L25JN0hsczNhenZLRitwZDJCYXRRbmlaUUZwcG1ZditMQm12YkxMeGQz?=
 =?utf-8?B?WTRrdzZ5L2IxbHoyb0RybzBpamdneTUwUmdOVi9TZGoveDAwVm9RN0ZjcElo?=
 =?utf-8?B?Z1h5K1NVMzEzVlRzeVdwcmJ0QXFoS3k0NG8xTVljTlBnN0pEemVhZVFpbnEx?=
 =?utf-8?B?MzNKQVdYTlhRd3FXQ2tBWHR3MGhNUzRKdnJPdGRFOEJVZk4vK1lOcURGS0J6?=
 =?utf-8?B?WVBvdjNoMmN6RHdOaDZDTXNpT3JBK1ZqUHFMY1hBTEtSM2UwT0E1akNLMDJl?=
 =?utf-8?B?dGczaS91VWYrQ0k2M09nZDFZS2dHajBldFpVQ1NnTzh4RWpEbG0yNXM1bUZI?=
 =?utf-8?B?TnpJckxranJSci90YXdidDVTcUthVCtCdlhHano1d0VoZCtVWEQvakIxcU5o?=
 =?utf-8?B?VFBPcHQySnpwSXNCMjRwcmErQ3JUeUJnNVY4b1pWWEMyeEhIT1dNWjJrMWU3?=
 =?utf-8?B?SFdwT3pLMlRWM29kWEhzR1RpQmJpaEZodlBUU2Z6cFVMR0tKZnFMd2pZVzhI?=
 =?utf-8?B?d2Y5UEZEYUNkNTk3YlVmc0JnZ3pzS25TREtmdUJjZzMxZzFzRlpFcGZIQ1Qz?=
 =?utf-8?B?bThhZkZxajhud3NoVVBnblVkOUxDUlE2czVmeWtPSW10RWRHblZKeWpXNmN6?=
 =?utf-8?B?Q0phR0UvNHN4NXI1VXZHYms2Vnk2bXNhY25PVjh4NExHQzB1dnZjdHZMelB3?=
 =?utf-8?B?SzFTQmRreDBOdGJtTkdLU1lhdkZiRTc1eURXTVZCYWt3enFoMDdsWjhJcFNM?=
 =?utf-8?Q?+yZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed0d16-50a2-4d50-8268-08dcbd644117
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 19:55:46.5347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjW4LI7w7L3yOqdBLdr+lrRPyeJVNOHFsTJbzl3kdZI5MsFessHfeLZdg1Vya3lUDkbJjSgvFJxUkI6HDoOoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBGZWxpeCBLdWVobGluZw0K
U2VudDogVGh1cnNkYXksIEF1Z3VzdCAxNSwgMjAyNCAyOjI1IFBNDQpUbzogSm9zaGksIE11a3Vs
IDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0
OiBSZTogW1BBVENIdjIgMi8zXSBkcm0vYW1ka2ZkOiBVcGRhdGUgcXVldWUgdW5tYXAgYWZ0ZXIg
Vk0gZmF1bHQgd2l0aCBNRVMNCg0KT24gMjAyNC0wOC0xNCAxOToyNywgTXVrdWwgSm9zaGkgd3Jv
dGU6DQo+IE1FQyBGVyBleHBlY3RzIE1FUyB0byB1bm1hcCBhbGwgcXVldWVzIHdoZW4gYSBWTSBm
YXVsdCBpcyBvYnNlcnZlZA0KPiBvbiBhIHF1ZXVlIGFuZCB0aGVuIHJlc3VtZWQgb25jZSB0aGUg
YWZmZWN0ZWQgcHJvY2VzcyBpcyB0ZXJtaW5hdGVkLg0KPiBVc2UgdGhlIE1FUyBTdXNwZW5kIGFu
ZCBSZXN1bWUgQVBJcyB0byBhY2hpZXZlIHRoaXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE11a3Vs
IEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPiAtLS0NCj4gdjEtPnYyOg0KPiAtIEFkZCBN
RVMgRlcgdmVyc2lvbiBjaGVjay4NCj4gLSBTZXBhcmF0ZSBvdXQgdGhlIGtmZF9kcW1fZXZpY3Rf
cGFzaWQgaW50byBhbm90aGVyIGZ1bmN0aW9uLg0KPiAtIFVzZSBhbWRncHVfbWVzX3N1c3BlbmQv
YW1kZ3B1X21lc19yZXN1bWUgdG8gc3VzcGVuZC9yZXN1bWUgcXVldWVzLg0KPg0KPiAgIC4uLi9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyB8IDc5ICsrKysrKysrKysr
KysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rl
dmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gaW5kZXggZjZlMjExMDcwMjk5Li5jYjViODY2ZWVlM2Ig
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVl
dWVfbWFuYWdlci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2VfcXVldWVfbWFuYWdlci5jDQo+IEBAIC0zMTksNiArMzE5LDQyIEBAIHN0YXRpYyBpbnQgcmVt
b3ZlX2FsbF9xdWV1ZXNfbWVzKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtKQ0KPiAg
ICAgICByZXR1cm4gcmV0dmFsOw0KPiAgIH0NCj4NCj4gK3N0YXRpYyBpbnQgc3VzcGVuZF9hbGxf
cXVldWVzX21lcyhzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSkNCj4gK3sNCj4gKyAg
ICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilk
cW0tPmRldi0+YWRldjsNCj4gKyAgICAgaW50IHIgPSAwOw0KPiArDQo+ICsgICAgIGlmIChkcW0t
PmlzX2h3c19oYW5nKQ0KPiArICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KDQoNClRoaXMgY2hl
Y2sgbWlnaHQgbmVlZCB0byBiZSByZWNvbmNpbGVkIHdpdGggdGhlIGZvbGxvd2luZyBjb21taXQu
IE1heSBiZSBjaGVjayBoYXMgdG8gYmUNCmlmICghZG93bl9yZWFkX3RyeWxvY2soJmRxbS0+ZGV2
LT5hZGV2LT5yZXNldF9kb21haW4tPnNlbSkpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87
DQoNCmdpdCBzaG93IGQ0ZWQxNmZhNzYwZTc5MjM1ZWYyMTQzMThhODM4OWVjZWRjYjlhZDYgLS1z
dGF0DQpjb21taXQgZDRlZDE2ZmE3NjBlNzkyMzVlZjIxNDMxOGE4Mzg5ZWNlZGNiOWFkNg0KQXV0
aG9yOiBZdW54aWFuZyBMaSA8WXVueGlhbmcuTGlAYW1kLmNvbT4NCkRhdGU6ICAgRnJpIE1heSAy
NCAxMzo0Njo1MCAyMDI0IC0wNDAwDQoNCiAgICBkcm0vYW1kZ3B1L2tmZDogcmVtb3ZlIGlzX2h3
c19oYW5nIGFuZCBpc19yZXNldHRpbmcNCg0KPiArDQo+ICsgICAgIHIgPSBhbWRncHVfbWVzX3N1
c3BlbmQoYWRldik7DQo+ICsgICAgIGlmIChyKSB7DQo+ICsgICAgICAgICAgICAgZGV2X2Vycihh
ZGV2LT5kZXYsICJmYWlsZWQgdG8gc3VzcGVuZCBnYW5ncyBmcm9tIE1FU1xuIik7DQo+ICsgICAg
ICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJNRVMgbWlnaHQgYmUgaW4gdW5yZWNvdmVyYWJs
ZSBzdGF0ZSwgaXNzdWUgYSBHUFUgcmVzZXRcbiIpOw0KPiArICAgICAgICAgICAgIGtmZF9od3Nf
aGFuZyhkcW0pOw0KPiArICAgICB9DQo+ICsNCj4gKyAgICAgcmV0dXJuIHI7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgcmVzdW1lX2FsbF9xdWV1ZXNfbWVzKHN0cnVjdCBkZXZpY2VfcXVldWVf
bWFuYWdlciAqZHFtKQ0KPiArew0KPiArICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWRxbS0+ZGV2LT5hZGV2Ow0KPiArICAgICBpbnQgciA9
IDA7DQo+ICsNCj4gKyAgICAgaWYgKGRxbS0+aXNfaHdzX2hhbmcpDQo+ICsgICAgICAgICAgICAg
cmV0dXJuIC1FSU87DQo+ICsNCj4gKyAgICAgciA9IGFtZGdwdV9tZXNfcmVzdW1lKGFkZXYpOw0K
PiArICAgICBpZiAocikgew0KPiArICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiZmFp
bGVkIHRvIHJlc3VtZSBnYW5ncyBmcm9tIE1FU1xuIik7DQo+ICsgICAgICAgICAgICAgZGV2X2Vy
cihhZGV2LT5kZXYsICJNRVMgbWlnaHQgYmUgaW4gdW5yZWNvdmVyYWJsZSBzdGF0ZSwgaXNzdWUg
YSBHUFUgcmVzZXRcbiIpOw0KPiArICAgICAgICAgICAgIGtmZF9od3NfaGFuZyhkcW0pOw0KPiAr
ICAgICB9DQo+ICsNCj4gKyAgICAgcmV0dXJuIHI7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9p
ZCBpbmNyZW1lbnRfcXVldWVfY291bnQoc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0s
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHFjbV9wcm9jZXNzX2Rl
dmljZSAqcXBkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBxdWV1
ZSAqcSkNCj4gQEAgLTI4MzUsNiArMjg3MSw0MCBAQCB2b2lkIGRldmljZV9xdWV1ZV9tYW5hZ2Vy
X3VuaW5pdChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSkNCj4gICAgICAga2ZyZWUo
ZHFtKTsNCj4gICB9DQo+DQo+ICtzdGF0aWMgaW50IGtmZF9kcW1fZXZpY3RfcGFzaWRfbWVzKHN0
cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgcWNtX3Byb2Nlc3NfZGV2aWNlICpxcGQpDQo+ICt7DQo+ICsgICAg
IHN0cnVjdCBkZXZpY2UgKmRldiA9IGRxbS0+ZGV2LT5hZGV2LT5kZXY7DQo+ICsgICAgIGludCBy
ZXQgPSAwOw0KPiArDQo+ICsgICAgIC8qIENoZWNrIGlmIHByb2Nlc3MgaXMgYWxyZWFkeSBldmlj
dGVkICovDQo+ICsgICAgIGRxbV9sb2NrKGRxbSk7DQo+ICsgICAgIGlmIChxcGQtPmV2aWN0ZWQp
IHsNCj4gKyAgICAgICAgICAgICBkcW1fdW5sb2NrKGRxbSk7DQo+ICsgICAgICAgICAgICAgZ290
byBvdXQ7DQoNCnFwZC0+ZXZpY3RlZCBpcyBhIHJlZmVyZW5jZSBjb3VudC4gV2l0aG91dCB0aGlz
IHNob3J0Y3V0LA0KZHFtLT5vcHMuZXZpY3RfcHJvY2Vzc19xdWV1ZXMgd2lsbCBpbmNyZW1lbnQg
dGhlIHJlZiBjb3VudC4gWW91IHByb2JhYmx5DQpuZWVkIHRvIGluY3JlbWVudCBpdCBoZXJlIGJl
Zm9yZSBkcm9wcGluZyB0aGUgbG9jay4gT3RoZXJ3aXNlIHR3byB0aGluZ3MNCmNhbiBnbyB3cm9u
ZzoNCg0KIDEuIFRoZSBjb3JyZXNwb25kaW5nIGRxbS0+b3BzLnJlc3RvcmVfcHJvY2Vzc19xdWV1
ZXMgd2lsbCB1bmRlcmZsb3cgdGhlDQogICAgcmVmZXJlbmNlIGNvdW50DQogMi4gQSByYWNlIGNv
bmRpdGlvbiB3aGVyZSB0aGUgcXVldWVzIGdldCByZXN0b3JlZCB0b28gZWFybHkNCg0KUmVnYXJk
cywNCiAgIEZlbGl4DQoNCg0KPiArICAgICB9DQo+ICsgICAgIGRxbV91bmxvY2soZHFtKTsNCj4g
Kw0KPiArICAgICByZXQgPSBzdXNwZW5kX2FsbF9xdWV1ZXNfbWVzKGRxbSk7DQo+ICsgICAgIGlm
IChyZXQpIHsNCj4gKyAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlN1c3BlbmRpbmcgYWxsIHF1
ZXVlcyBmYWlsZWQiKTsNCj4gKyAgICAgICAgICAgICBnb3RvIG91dDsNCj4gKyAgICAgfQ0KPiAr
DQo+ICsgICAgIHJldCA9IGRxbS0+b3BzLmV2aWN0X3Byb2Nlc3NfcXVldWVzKGRxbSwgcXBkKTsN
Cj4gKyAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRXZpY3Rp
bmcgcHJvY2VzcyBxdWV1ZXMgZmFpbGVkIik7DQo+ICsgICAgICAgICAgICAgZ290byBvdXQ7DQo+
ICsgICAgIH0NCj4gKw0KPiArICAgICByZXQgPSByZXN1bWVfYWxsX3F1ZXVlc19tZXMoZHFtKTsN
Cj4gKyAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlJlc3VtaW5n
IGFsbCBxdWV1ZXMgZmFpbGVkIik7DQo+ICsNCj4gK291dDoNCj4gKyAgICAgcmV0dXJuIHJldDsN
Cj4gK30NCj4gKw0KPiAgIGludCBrZmRfZHFtX2V2aWN0X3Bhc2lkKHN0cnVjdCBkZXZpY2VfcXVl
dWVfbWFuYWdlciAqZHFtLCB1MzIgcGFzaWQpDQo+ICAgew0KPiAgICAgICBzdHJ1Y3Qga2ZkX3By
b2Nlc3NfZGV2aWNlICpwZGQ7DQo+IEBAIC0yODQ1LDggKzI5MTUsMTMgQEAgaW50IGtmZF9kcW1f
ZXZpY3RfcGFzaWQoc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sIHUzMiBwYXNpZCkN
Cj4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgICAgV0FSTihkZWJ1Z19ldmlj
dGlvbnMsICJFdmljdGluZyBwaWQgJWQiLCBwLT5sZWFkX3RocmVhZC0+cGlkKTsNCj4gICAgICAg
cGRkID0ga2ZkX2dldF9wcm9jZXNzX2RldmljZV9kYXRhKGRxbS0+ZGV2LCBwKTsNCj4gLSAgICAg
aWYgKHBkZCkNCj4gLSAgICAgICAgICAgICByZXQgPSBkcW0tPm9wcy5ldmljdF9wcm9jZXNzX3F1
ZXVlcyhkcW0sICZwZGQtPnFwZCk7DQo+ICsgICAgIGlmIChwZGQpIHsNCj4gKyAgICAgICAgICAg
ICBpZiAoZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0ga2ZkX2RxbV9ldmljdF9wYXNpZF9tZXMoZHFtLCAmcGRk
LT5xcGQpOw0KPiArICAgICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IGRxbS0+b3BzLmV2aWN0X3Byb2Nlc3NfcXVldWVzKGRxbSwgJnBkZC0+cXBkKTsNCj4gKyAg
ICAgfQ0KPiArDQo+ICAgICAgIGtmZF91bnJlZl9wcm9jZXNzKHApOw0KPg0KPiAgICAgICByZXR1
cm4gcmV0Ow0K
