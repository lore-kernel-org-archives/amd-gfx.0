Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053F1CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46C810E3F1;
	Mon, 13 Oct 2025 08:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t12XIh+E";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D7010E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deVnlxuJTqXApxI9CYEr4twkFVlArVb0cGplWGJHJ6ZsMpuj+XV6uNRYXpDl93PlZJ3YYxn3fcmGSIUGoUqBYJhZJ+w3CaZGbRoXl/VOWKK8SuI2Fkk38qylOAx6WoV0ZG6njCyBDyQ/Ly1d9QPLqK+ao1ac+RtNFN/C1l9bguMAYLjRpRJTfdO9DA+eGAoP2g724BV6TZF74W6y0qxI0EjGO6tVutl3Nsod6j5VTK9nkKX6ZPDiI4R53pZvH4sny6AjtRcNIPYdP2K2B0x4Q9JWSGLU/K2XebHAxY8DKfi9uMPW8rkvhxnDW5d/u6fe9XcEViC0G7gj/mhHcHFdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wxuQw/qbJePyS9z1GF1vyDNoXalNARWFErW7OhRL58=;
 b=PjR2elx/r5vRbjz/jGdoBgZOrIEP4K8xkyq+dt2erSiLkn33kGPoaul742RJCKsc266L9ZyRNrGGrX8dP9PY/eKY3aJRN8y9dGx4ipRtSya7gP7nh/nf7x1rCRy43rZiROC5rV/HZR5Cw9wO5D67TvLmeOr9Gv6E0EEO85RB4UMQ3WCeR8pjmBm6MIHTl472Q3ol1lGG7RGQeLtq0rlj4bKokepP4Ow9trAe5bByw67ywcWiZFIscDymlP/Oxm96bzOK+iQBZ/Af1yuL1UdUYVkhFg6QzjLw2lNbFdWJJURgBi76jFhDrOGmQbo8d5IOgH4rsRm6VFbhKB1Jj2mSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wxuQw/qbJePyS9z1GF1vyDNoXalNARWFErW7OhRL58=;
 b=t12XIh+EznCpqS68VbkxzFp6o/y23ZflLQQj0wcp9JbIpnKI7tTGBZvXZJjaRAl2Ev9zloHgIls7vuYjVujN8dV+Igqnz/DAmlpnTy58TRkctwphPHmeIVnEc8sEIiiu3iU+ty3yXx/ZSCm68/5pR/CNoA7uzMgLptzs8qlF15s=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 08:20:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:20:16 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: Fix NULL pointer dereference in VRAM logic
 for APU devices
Thread-Topic: [PATCH v4] drm/amdgpu: Fix NULL pointer dereference in VRAM
 logic for APU devices
Thread-Index: AQHcPBe5S0V2fWBP8kaznPoHT6O/qrS/u7aQ
Date: Mon, 13 Oct 2025 08:20:16 +0000
Message-ID: <DS0PR12MB7804F4A7B43C72081B689EAC97EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251013080212.1722494-1-Jesse.Zhang@amd.com>
In-Reply-To: <20251013080212.1722494-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T08:18:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SJ0PR12MB7081:EE_
x-ms-office365-filtering-correlation-id: 3abc5e4b-a87f-42ff-4035-08de0a3156f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dy92aC9BNHY5K2FvSzNoMldUNWp6N1M4ZjNtWmM2TlJaZmE4L0I3UHJ3MEZY?=
 =?utf-8?B?TUtMVE9ZbDI1NEJldW53eFJLRzNJOXNyaWQvWThoSkI4K0w5TkNoNDVRajRT?=
 =?utf-8?B?M2tsTWVCUVE4ckg2MTdNSUJDZ09LYUxQeW9PdUI4VTFndWJoMk0rNGNWZ05l?=
 =?utf-8?B?dnhkWEZSZkE2cjJXc0gxbExRcXpXUG1hOFNuZFEwNGdmbVRuTnRiKzBJR1Jn?=
 =?utf-8?B?RkJFaDRWdVRZTHRrNGRvNlE4c0F5bm11LzFjb3RSS0tLSHlsWjBJL3lDMEtu?=
 =?utf-8?B?N0ZmZGhBNDQ3TUJBU3IzVlVrRDMxV2dCbDg3YUV3cWVJQjlvRHoyelFDUXMv?=
 =?utf-8?B?Um15b0xGQTkyUm1uUGFhU1ZzKzZxOVUxc2RjRzF6a2E0SXdNelNQMGZjQmlx?=
 =?utf-8?B?Vi8wZTJqNFhpSjlIU3c4cEdqbDdKT0h3Q2RLZXVWa1IzQTRkZDc2Qmx3Ym5y?=
 =?utf-8?B?NG8zd1l6a094UnRwUDVrMmN4a0gybkJTZ1FoTVp5dHhuSTBrOVNpcW9sZVdK?=
 =?utf-8?B?MmFmYW9GQlVDUHhweDJuWGZzcjJ6SDk2dDByVUtoc01uWnhhRkhodTEwbVJX?=
 =?utf-8?B?SWRvc3pTMThYUFdNaVRaUHZpdS95QWg5a1N0UDVRWGhoYnRVRjBOeW5jNGIy?=
 =?utf-8?B?T2JHV0kzTFBJZzJaQmVxY2QvNnpva29tcURMNCttM0t1NXNaa3J1bjhCMWY1?=
 =?utf-8?B?VlFwYzdDUVlOMExIc1VCamluR0lJUWxCaDE2Rkp1NDJHaytWYU5hRG8zMkhM?=
 =?utf-8?B?NXlNOURVVE5pSTJoR2ovVHVJOHp0YWFITCtHUU1LNEJqUk9ucDFza1pFVS9v?=
 =?utf-8?B?bmNFUW1jejdFQURTZDVPTTVUZlQrTmVIbUVtYXJHZHdCaXhCUHV5Qk9aRy82?=
 =?utf-8?B?T2ZncmdjVUJhMzdKNlFGY1JENXNmakwydjJSVmlHOGpBMmNkeEFubDZmQnBH?=
 =?utf-8?B?NGY5ZVBETDJUUGc5b1FPU25nTlNSTmFYUWg2VDF4TnU1Kzl2REJUd1EvSTBR?=
 =?utf-8?B?VVBaUFVFRDBKcjBWQzM3YnEydjNUaFJZdW5tTmNJSzZFLzJ6amoyTHdLWVll?=
 =?utf-8?B?RmMwYjBlczBkSmVTQVlrUGRiR08vU1FrK3lLUTRrbGp3UUp6UmRkVlNMb2tl?=
 =?utf-8?B?ZUs3SWFZaTQ4YzM5aGVRUDRJekRld0NCMFhkMGxhVy9vY2lNR0FOcFhpdEpu?=
 =?utf-8?B?R2drek5jN3F0ODFyOFdVbmVGZFV5bkwvUWZQVHVPb0dVbWFzcUsxc29rZ2ZC?=
 =?utf-8?B?dVhSWjN2WUxBQUx5eUxaMVd2d1hsSDY1YUI5dElxNHBOOE5lSkFXeE9YWS9v?=
 =?utf-8?B?QkNib1FIQWc0T3pzTnFxNk9VekZpRDZPdE4xbVpmOVlpMTNZaHdncUdoQjFi?=
 =?utf-8?B?NXY2cTd3akxJMGJJaWd1S0tPWWJlSW1uY0hDSVk3WnBVT0htUlJ5VE9CT0VC?=
 =?utf-8?B?UkFXSDNhQmVZWEdoZUVwODVQdmErZVhUbzVwMHM5UVpBWHY1MDFlSXZSbVRS?=
 =?utf-8?B?Vk5uck5MQTFYT1ljT0NuWERHYWNteDB3UEFXYkFkaTF1OWJVNko0aHJlUmY3?=
 =?utf-8?B?R04wK0U0bUt1VUpTVE44RkJBMjVoSmFqSEk2MFMzdU9MbTNBcFdLS1l4NHA0?=
 =?utf-8?B?N3VtTnlWdi91M3MxN0hOcWwvNzRHWVowckJhU1FyRUNhbUNLVzBoczNoNXN6?=
 =?utf-8?B?Q2xFaEZXUmZxcWNUS3R1SzJxUWxzNHNGUkE1OHRXdWVBenNEN2xNQnEyVVdU?=
 =?utf-8?B?TFhPdmFDa01MTE45SUcxQTVMTUhnYkNIWnZTQmRvbG90dmhzN3dpVFZJVlQ0?=
 =?utf-8?B?R2E5NlNKaEhQYlE1WDFpNWQ5NitNQlpkM01DdTd4NmVraE1DOG0xQjJsVFpH?=
 =?utf-8?B?YzNyR0Jzc21iUGJ5ZndSVCtYQUNZNHRkck4zcXVzSk82a0NKdWlMblF6dmVN?=
 =?utf-8?B?QVRsd1hubTQ2L2hOVm5hbTdPUmNMcHJhM0JwZXpZdVg0aTFPNnBzbWZMMDk4?=
 =?utf-8?B?SkNoaFIzbGlaR0ZodTNicEdWNU5xREU1bnZRY2ZsVkFEWUhtQm9pRm1yU2Zk?=
 =?utf-8?Q?2Q8F6c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajVtYURSQnRYbVVKU1gvSWRTeWRKcWJJdDdqUzQrTm5rakJTTUMvNGpENVoy?=
 =?utf-8?B?dTNlcjZOcG9RUm5xVzNDNUJyL3I3a0toN1RaRldIY2ZLV2F6dkl3S21GMUxY?=
 =?utf-8?B?U0hRdUFpdWRyVzdrU2ppZVI4V1VYSmt2cVJBTk1Penk1NWt1MlZNMjhYQ0l6?=
 =?utf-8?B?K3RaVUlnc3N0ZjNmaldwbWw2cmZPN2RpTTZlajc3SytVNFZSQ1FucEVmUE1o?=
 =?utf-8?B?alY0UXB5THlNSkRSTlhackRVaEx6dGZmUXdFcXRsWTRSc1BRc2lhakNRNzVo?=
 =?utf-8?B?R1lYTTQ5NzR5VEVSMlVMSmN1VjZSMG15M2loS1o2bm8rUjFST3BneDRaRUV0?=
 =?utf-8?B?RTN0VExLVDBzQk5Ocnk2d201VUVUUmVueVZEQjF6NWtkTnl3WklORUJScm5k?=
 =?utf-8?B?ZGpsMm80SC9aOC9TTHRDYjl2aGxSTzhVdHVZREFuTzFBMm54aDNDVHVIeUR6?=
 =?utf-8?B?M0w2TXpIWHY3QTVXeVIvZEJCdG5Sdk5jWlB0QTRzZ1BUZ05rR0dSVmRMMHpY?=
 =?utf-8?B?MkxUZUdiZ2ZlZ0RoclpYVzlyWEEweXV5VjBvNlk1SFB5K2dOSVNwcFlmWHk2?=
 =?utf-8?B?dWFtazdvSUhRUUNUU2MvTjE1OHFpdDhjekt5V2V6ZFZ6aEc5OEpiYWd1TjAr?=
 =?utf-8?B?NWlpODVYcVFxaGN3MzhoMnZKU3dvRnQwOGFYUVNkMEJDeXBpMExPajEzTkRh?=
 =?utf-8?B?enRZT2orM3kvQm9lbGNldVFramVUQlI0SDlMcDVBdkZROFRUTlkvUGl6YVV3?=
 =?utf-8?B?Nm1hYVV4MXMzUEQzODdVQXA4RzM1S1BYM2U0RmlSWDE5YmRTSVhpaFY4Vlgv?=
 =?utf-8?B?d2RGRVdVNU52N3NRTG1mTFdMc0tnc1VTbEwwc2xVNEJxUnBEd2h4S0diNTJY?=
 =?utf-8?B?bjhOVGozWlJnVkhvb1pxQ1BtR3BpbFU3aUpuK3AxdjZJaHEzTjFpdkIxQTRC?=
 =?utf-8?B?Z3ZPcWEyU3BlaGRPd3EzQWpoVE9ZQ0NhZ0hYcUVhMWtJdDhQMTl4SHZ3YU84?=
 =?utf-8?B?djBjVkNlSzVVUnNqWjVNWEtud3Yyd240dHFvVlYwMFluQWx6WlVSWmFzTXdI?=
 =?utf-8?B?UG1Wa0k5K0ZQU1dmejBVY3FKSW4xV3MxUWhOYVVBK2FmTHFqbXM4bjhGUmky?=
 =?utf-8?B?V3RmS3QxRWJwU2ZRNnhlT2RWTFpRQlN3UEIzT3BaVDdlQVBQYi91Z3pGcWww?=
 =?utf-8?B?cjJOYUNHaDhYcis4bERNVzZIR25EelJQTEZnclZNQ1hMZ0pFNk9JTER3Q2FY?=
 =?utf-8?B?REpwTWdTYTN5MzhhU1ltamR3STFYaGxDSDFYWUhaNCtaYkg4NGNwdFUwWnlZ?=
 =?utf-8?B?NTZOeFY3U3BSUzNQUUV5OVpXcHNKbENJdVU0ZXJWaU0zMVpGMmc3Zkcyczlr?=
 =?utf-8?B?d1h5dGhFKytJS1NCeVpZVzZpTlI0QThoVnR5bEtOUVR5YmJXSWtBWDVlZ016?=
 =?utf-8?B?VFRWK1g5VjBvSmptWXNpeGdKTUs4Sk5tRkFRNjFaa1ZpaDYxZXh0c3BneWd4?=
 =?utf-8?B?VXJFSWw5azZzcmlvVWpoanNna3NkNysxcFJOb2xoZHdhRGU1VFRheDFubUNU?=
 =?utf-8?B?eDhyZlpzN01IbHN3cTRyTUVSemxHUUdQcnVhc0RrVThGR21CQWp0SFUzS2Jz?=
 =?utf-8?B?L2dNR3JZVndza2hyTXJ6Y2xKNldoU3BUZU5QT0RaRUY1aG5GT2d5TTJ6RW93?=
 =?utf-8?B?emU1Z1IwTjRzeUw0d0ZPVXQrTHY0WTdMS0c4VXlBVkt3ZWZBWGRPcFRNazFM?=
 =?utf-8?B?VGdxYWZzL2F0dm1oRFQ1QUJUbU5rNnNVSjY1WGg3Ly9qSXFPMVhXZVhlbFpy?=
 =?utf-8?B?czc5SHdhZUczeDZ3T1dYUk8yclYraWhxUGY3enBtZlo2UFptWlNZaFRISExx?=
 =?utf-8?B?eFhvaEc5N2EySnY2S2NwS29NbE9LaHNjZExwcElOczBHVko5R3BYTzFaRVlu?=
 =?utf-8?B?Vm96c1BudEp6Yko5YjF1Uktza0NCcUx0TTBDMEt1eXp4TlYwTUtzaDU4ZmE0?=
 =?utf-8?B?Y0s3VXh6Y2d0ZkV6TjZuRlNoN3VycWg2L1JHVHR1UmJvMjRTSkIwZjRXOTZt?=
 =?utf-8?B?dndvamlmVW5XODh0aFR0TEFlQ2ZKSkVpVlFXRWVZREZ0TTE2RExIb3FrWkR1?=
 =?utf-8?Q?rPLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abc5e4b-a87f-42ff-4035-08de0a3156f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:20:16.1327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iibvhtDqZ8o3eWBK30Z55Gg+k/dkTomIg62oicCL5IyepXV+rFI4hM004Z9EeaQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+SmVzc2UuWmhhbmcN
Cj5TZW50OiBNb25kYXksIE9jdG9iZXIgMTMsIDIwMjUgMTozMSBQTQ0KPlRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPjxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj5TdWJqZWN0
OiBbUEFUQ0ggdjRdIGRybS9hbWRncHU6IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4g
VlJBTSBsb2dpYw0KPmZvciBBUFUgZGV2aWNlcw0KPg0KPlByZXZpb3VzbHksIEFQVSBwbGF0Zm9y
bXMgKGFuZCBvdGhlciBzY2VuYXJpb3Mgd2l0aCB1bmluaXRpYWxpemVkIFZSQU0NCj5tYW5hZ2Vy
cykgdHJpZ2dlcmVkIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluDQo+YHR0bV9yZXNvdXJj
ZV9tYW5hZ2VyX3VzYWdlKClgLiBUaGUgcm9vdCBjYXVzZSBpcyBub3QgdGhhdCB0aGUgYHN0cnVj
dA0KPnR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW5gIHBvaW50ZXIgaXRzZWxmIGlzIE5VTEwsIGJ1
dCB0aGF0IGBtYW4tPmJkZXZgICh0aGUNCj5iYWNraW5nIGRldmljZSBwb2ludGVyIHdpdGhpbiB0
aGUgbWFuYWdlcikgcmVtYWlucyB1bmluaXRpYWxpemVkIChOVUxMKSBvbg0KPkFQVXPigJRzaW5j
ZSBBUFVzIGxhY2sgZGVkaWNhdGVkIFZSQU0gYW5kIGRvIG5vdCBmdWxseSBzZXQgdXAgVlJBTQ0K
Pm1hbmFnZXIgc3RydWN0dXJlcy4gV2hlbiBgdHRtX3Jlc291cmNlX21hbmFnZXJfdXNhZ2UoKWAg
YXR0ZW1wdHMgdG8NCj5hY3F1aXJlIGBtYW4tPmJkZXYtPmxydV9sb2NrYCwgaXQgZGVyZWZlcmVu
Y2VzIHRoZSBOVUxMIGBtYW4tPmJkZXZgLCBsZWFkaW5nDQo+dG8gYSBrZXJuZWwgT09QUy4NCj4N
Cj4xLiAqKmFtZGdwdV9jcy5jKio6IEV4dGVuZCB0aGUgZXhpc3RpbmcgYmFuZHdpZHRoIGNvbnRy
b2wgY2hlY2sgaW4NCj4gICBgYW1kZ3B1X2NzX2dldF90aHJlc2hvbGRfZm9yX21vdmVzKClgIHRv
IGluY2x1ZGUgYSBjaGVjayBmb3INCj4gICBgdHRtX3Jlc291cmNlX21hbmFnZXJfdXNlZCgpYC4g
SWYgdGhlIG1hbmFnZXIgaXMgbm90IHVzZWQgKHVuaW5pdGlhbGl6ZWQNCj4gICBgYmRldmApLCBy
ZXR1cm4gMCBmb3IgbWlncmF0aW9uIHRocmVzaG9sZHMgaW1tZWRpYXRlbHnigJRza2lwcGluZyBW
UkFNLQ0KPnNwZWNpZmljDQo+ICAgbG9naWMgdGhhdCB3b3VsZCB0cmlnZ2VyIHRoZSBOVUxMIGRl
cmVmZXJlbmNlLg0KPg0KPjIuICoqYW1kZ3B1X2ttcy5jKio6IFVwZGF0ZSB0aGUgYEFNREdQVV9J
TkZPX1ZSQU1fVVNBR0VgIGlvY3RsIGFuZA0KPm1lbW9yeSBpbmZvDQo+ICAgcmVwb3J0aW5nIHRv
IHVzZSBhIGNvbmRpdGlvbmFsOiBpZiB0aGUgbWFuYWdlciBpcyB1c2VkLCByZXR1cm4gdGhlIHJl
YWwgVlJBTQ0KPiAgIHVzYWdlOyBvdGhlcndpc2UsIHJldHVybiAwLiBUaGlzIGF2b2lkcyBhY2Nl
c3NpbmcgYG1hbi0+YmRldmAgd2hlbiBpdCBpcw0KPiAgIE5VTEwuDQo+DQo+My4gKiphbWRncHVf
dmlydC5jKio6IE1vZGlmeSB0aGUgdmYycGYgKHZpcnR1YWwgZnVuY3Rpb24gdG8gcGh5c2ljYWwg
ZnVuY3Rpb24pDQo+ICAgZGF0YSB3cml0ZSBwYXRoLiBVc2UgYHR0bV9yZXNvdXJjZV9tYW5hZ2Vy
X3VzZWQoKWAgdG8gY2hlY2sgdmFsaWRpdHk6IGlmIHRoZQ0KPiAgIG1hbmFnZXIgaXMgdXNhYmxl
LCBjYWxjdWxhdGUgYGZiX3VzYWdlYCBmcm9tIFZSQU0gdXNhZ2U7IG90aGVyd2lzZSwgc2V0DQo+
ICAgYGZiX3VzYWdlYCB0byAwIChBUFVzIGhhdmUgbm8gZGlzY3JldGUgZnJhbWVidWZmZXIgdG8g
cmVwb3J0KS4NCj4NCj5UaGlzIGFwcHJvYWNoIGlzIG1vcmUgcm9idXN0IHRoYW4gQVBVLXNwZWNp
ZmljIGNoZWNrcyBiZWNhdXNlIGl0Og0KPi0gV29ya3MgZm9yIGFsbCBzY2VuYXJpb3Mgd2hlcmUg
dGhlIFZSQU0gbWFuYWdlciBpcyB1bmluaXRpYWxpemVkIChub3QganVzdA0KPkFQVXMpLA0KPi0g
QWxpZ25zIHdpdGggVFRNJ3MgZGVzaWduIGJ5IHVzaW5nIGl0cyBuYXRpdmUgaGVscGVyIGZ1bmN0
aW9uLA0KPi0gUHJlc2VydmVzIGNvcnJlY3QgYmVoYXZpb3IgZm9yIGRpc2NyZXRlIEdQVXMgKHdo
aWNoIGhhdmUgZnVsbHkgaW5pdGlhbGl6ZWQNCj4gIGBtYW4tPmJkZXZgIGFuZCBwYXNzIHRoZSBg
dHRtX3Jlc291cmNlX21hbmFnZXJfdXNlZCgpYCBjaGVjaykuDQo+DQo+djQ6IHVzZSB0dG1fcmVz
b3VyY2VfbWFuYWdlcl91c2VkKCZhZGV2LT5tbWFuLnZyYW1fbWdyLm1hbmFnZXIpDQo+aW5zdGVh
ZCBvZiBjaGVja2luZyB0aGUgYWRldi0+Z21jLmlzX2FwcF9hcHUgZmxhZyAoQ2hyaXN0aWFuKQ0K
Pg0KPlNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPi0t
LQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyAgIHwgMiArLQ0KPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgIHwgNyArKysrLS0tDQo+ZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyB8IDQgKystLQ0KPiAzIGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMNCj5iL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+aW5kZXggNWY1MTVmZGNjNzc1Li4yZmE5MzFh
MjA1MzAgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMNCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYw0KPkBAIC03
MDksNyArNzA5LDcgQEAgc3RhdGljIHZvaWQNCj5hbWRncHVfY3NfZ2V0X3RocmVzaG9sZF9mb3Jf
bW92ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAqLw0KPiAgICAgICBj
b25zdCBzNjQgdXNfdXBwZXJfYm91bmQgPSAyMDAwMDA7DQo+DQo+LSAgICAgIGlmICghYWRldi0+
bW1fc3RhdHMubG9nMl9tYXhfTUJwcykgew0KPisgICAgICBpZiAoKCFhZGV2LT5tbV9zdGF0cy5s
b2cyX21heF9NQnBzKSB8fA0KPisoIXR0bV9yZXNvdXJjZV9tYW5hZ2VyX3VzZWQoJmFkZXYtPm1t
YW4udnJhbV9tZ3IubWFuYWdlcikpKSB7DQo+ICAgICAgICAgICAgICAgKm1heF9ieXRlcyA9IDA7
DQo+ICAgICAgICAgICAgICAgKm1heF92aXNfYnl0ZXMgPSAwOw0KPiAgICAgICAgICAgICAgIHJl
dHVybjsNCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jDQo+Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj5pbmRleCBh
OTMyNzQ3MmM2NTEuLmIzZTZiM2ZjZGYyYyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfa21zLmMNCj5AQCAtNzU4LDcgKzc1OCw4IEBAIGludCBhbWRncHVfaW5mb19pb2N0
bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkDQo+KmRhdGEsIHN0cnVjdCBkcm1fZmlsZSAq
ZmlscCkNCj4gICAgICAgICAgICAgICB1aTY0ID0gYXRvbWljNjRfcmVhZCgmYWRldi0+bnVtX3Zy
YW1fY3B1X3BhZ2VfZmF1bHRzKTsNCj4gICAgICAgICAgICAgICByZXR1cm4gY29weV90b191c2Vy
KG91dCwgJnVpNjQsIG1pbihzaXplLCA4dSkpID8gLUVGQVVMVCA6IDA7DQo+ICAgICAgIGNhc2Ug
QU1ER1BVX0lORk9fVlJBTV9VU0FHRToNCj4tICAgICAgICAgICAgICB1aTY0ID0gdHRtX3Jlc291
cmNlX21hbmFnZXJfdXNhZ2UoJmFkZXYtDQo+Pm1tYW4udnJhbV9tZ3IubWFuYWdlcik7DQo+KyAg
ICAgICAgICAgICAgdWk2NCA9IHR0bV9yZXNvdXJjZV9tYW5hZ2VyX3VzZWQoJmFkZXYtDQo+Pm1t
YW4udnJhbV9tZ3IubWFuYWdlcikgPw0KPisgICAgICAgICAgICAgICAgICAgICAgdHRtX3Jlc291
cmNlX21hbmFnZXJfdXNhZ2UoJmFkZXYtDQo+Pm1tYW4udnJhbV9tZ3IubWFuYWdlcikgOiAwOw0K
PiAgICAgICAgICAgICAgIHJldHVybiBjb3B5X3RvX3VzZXIob3V0LCAmdWk2NCwgbWluKHNpemUs
IDh1KSkgPyAtRUZBVUxUIDogMDsNCj4gICAgICAgY2FzZSBBTURHUFVfSU5GT19WSVNfVlJBTV9V
U0FHRToNCj4gICAgICAgICAgICAgICB1aTY0ID0gYW1kZ3B1X3ZyYW1fbWdyX3Zpc191c2FnZSgm
YWRldi0NCj4+bW1hbi52cmFtX21ncik7DQo+QEAgLTgwNCw4ICs4MDUsOCBAQCBpbnQgYW1kZ3B1
X2luZm9faW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZA0KPipkYXRhLCBzdHJ1Y3Qg
ZHJtX2ZpbGUgKmZpbHApDQo+ICAgICAgICAgICAgICAgbWVtLnZyYW0udXNhYmxlX2hlYXBfc2l6
ZSA9IGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSAtDQo+ICAgICAgICAgICAgICAgICAgICAgICBh
dG9taWM2NF9yZWFkKCZhZGV2LT52cmFtX3Bpbl9zaXplKSAtDQo+ICAgICAgICAgICAgICAgICAg
ICAgICBBTURHUFVfVk1fUkVTRVJWRURfVlJBTTsNCj4tICAgICAgICAgICAgICBtZW0udnJhbS5o
ZWFwX3VzYWdlID0NCj4tICAgICAgICAgICAgICAgICAgICAgIHR0bV9yZXNvdXJjZV9tYW5hZ2Vy
X3VzYWdlKHZyYW1fbWFuKTsNCltsaWpvXQ0KDQpGb3IgdGhpcyBvbmUsIHByb2JhYmx5IHJldHVy
biBtdWNoIGVhcmxpZXIgaWYgdGhlcmUgaXMgbm8gdnJhbSBtYW5hZ2VyIHVzYWdlPyBGaWxsaW5n
IGluIG90aGVyIHBhcmFtZXRlcnMgZG9lcyBub3QgbG9vayByZXF1aXJlZC4NCg0KVGhhbmtzLA0K
TGlqbw0KDQo+KyAgICAgICAgICAgICAgbWVtLnZyYW0uaGVhcF91c2FnZSA9IHR0bV9yZXNvdXJj
ZV9tYW5hZ2VyX3VzZWQoJmFkZXYtDQo+Pm1tYW4udnJhbV9tZ3IubWFuYWdlcikgPw0KPisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0dG1fcmVzb3VyY2VfbWFuYWdlcl91c2FnZSh2cmFt
X21hbikgOiAwOw0KPiAgICAgICAgICAgICAgIG1lbS52cmFtLm1heF9hbGxvY2F0aW9uID0gbWVt
LnZyYW0udXNhYmxlX2hlYXBfc2l6ZSAqIDMgLw0KPjQ7DQo+DQo+ICAgICAgICAgICAgICAgbWVt
LmNwdV9hY2Nlc3NpYmxlX3ZyYW0udG90YWxfaGVhcF9zaXplID0gZGlmZiAtLWdpdA0KPmEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KPmIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KPmluZGV4IDMzMjhhYjYzMzc2Yi4uZjk2YmViOTZj
NzVjIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
LmMNCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQo+QEAg
LTU5OCw4ICs1OTgsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV92aXJ0X3dyaXRlX3ZmMnBmX2RhdGEo
c3RydWN0DQo+YW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgdmYycGZfaW5mby0+ZHJpdmVy
X2NlcnQgPSAwOw0KPiAgICAgICB2ZjJwZl9pbmZvLT5vc19pbmZvLmFsbCA9IDA7DQo+DQo+LSAg
ICAgIHZmMnBmX2luZm8tPmZiX3VzYWdlID0NCj4tICAgICAgICAgICAgICB0dG1fcmVzb3VyY2Vf
bWFuYWdlcl91c2FnZSgmYWRldi0NCj4+bW1hbi52cmFtX21nci5tYW5hZ2VyKSA+PiAyMDsNCj4r
ICAgICAgdmYycGZfaW5mby0+ZmJfdXNhZ2UgPSB0dG1fcmVzb3VyY2VfbWFuYWdlcl91c2VkKCZh
ZGV2LQ0KPj5tbWFuLnZyYW1fbWdyLm1hbmFnZXIpID8NCj4rICAgICAgICAgICAgICAgdHRtX3Jl
c291cmNlX21hbmFnZXJfdXNhZ2UoJmFkZXYtDQo+Pm1tYW4udnJhbV9tZ3IubWFuYWdlcikgPj4g
MjAgOiAwOw0KPiAgICAgICB2ZjJwZl9pbmZvLT5mYl92aXNfdXNhZ2UgPQ0KPiAgICAgICAgICAg
ICAgIGFtZGdwdV92cmFtX21ncl92aXNfdXNhZ2UoJmFkZXYtPm1tYW4udnJhbV9tZ3IpID4+DQo+
MjA7DQo+ICAgICAgIHZmMnBmX2luZm8tPmZiX3NpemUgPSBhZGV2LT5nbWMucmVhbF92cmFtX3Np
emUgPj4gMjA7DQo+LS0NCj4yLjQ5LjANCg0K
