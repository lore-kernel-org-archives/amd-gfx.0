Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43C5C36014
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 02:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6508C10E8EF;
	Thu,  3 Apr 2025 02:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBAyBfhF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0295F10E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 02:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwJangmdnB4wJPkmtLKhVilKfPoR2GwF1Z7HUniCRFGN+mppar8IntTrs+Ux4c3ijmBCURyyjDKUnJM/js6qJ6LLYUSxtClM+lxubnI1i1P0wybKqp54n2GxWe7ectFgLLrvze4u3vI2ifWZBNM4FSy1Fwe+iAp9KrC70k2Q3HpvKzDqxF3WGSkBUwLTzIRqiGewcLYqqinkBwoF8RgMFCUKsov8F28egGw9x73yej9VrVK8CZB6PRP5htROx7Pe6PxpZ1CokhxTPtcr/X6ld+JHMJfIEneN8+zFLKav98LntKpBt7sno6HcUMfGEKvFgyWqKmz0Z/9HJBUgB1QXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkHD6XG+v1BF4DJm7xXGNw1baCVd9ruRW/JYmpyJ28M=;
 b=l6h+9MkIN+Y8Hoz2/68VCj1QUAYFhO4Bf3NV8NMszi2SWFI1jinSiGGm0x7P+2fgHifWp6XaMLVy4C7zw+mKvqSCoWo8RBctH/6rvaTymSQ1PvoG+Q9id0SUj75Y55U/X9tdr02q2es7WptfzDokXMeJd9aN9xUsggvHrQY42bBX6a6YlqN47SBfdXYQEMTCeDHlGLzPN46KlMWFZd/xgLgasBd0C/k2tgXRwj/FJwhQl3FCuvquxcWxb8LM2yEPXAdi0weuzz4ZSN/GQ7h3mWgT7EsiUhpCj349pLF5PvYeCQWsapE7qlla0EvHJIkgOScqji2802ICj3TDXeOuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkHD6XG+v1BF4DJm7xXGNw1baCVd9ruRW/JYmpyJ28M=;
 b=RBAyBfhFmTiki90+i5dTUfd6dNz/axChhqurhIcqmGgsxThRdbC3kvvtr9J70sT73K8b3JJoxWHDtB64Mto800lPBHTuRiqHErDVt1Ypjq5Gic8PZMQRBkd8RRFBaCYT8siN0VyvnNbUyWZsYvrc8MxfNReCaPERBu53aMGzzEY=
Received: from SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 02:50:42 +0000
Received: from SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::6486:9a5e:4dee:8778]) by SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::6486:9a5e:4dee:8778%5]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 02:50:42 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>
CC: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
Thread-Topic: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
Thread-Index: AQHboi/O386mrN/XvkaHkADSKj6tK7ONJkwAgAEEhTCAAxX6QA==
Date: Thu, 3 Apr 2025 02:50:42 +0000
Message-ID: <SA1PR12MB6680D88546EA4385DEF807EDE9AE2@SA1PR12MB6680.namprd12.prod.outlook.com>
References: <20250331112634.81008-1-zhenguo.yin@amd.com>
 <64dcfc76-a973-40c8-b664-4191e9e8d266@amd.com>
 <SA1PR12MB6680A9D46F3AD83E56A69964E9AC2@SA1PR12MB6680.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB6680A9D46F3AD83E56A69964E9AC2@SA1PR12MB6680.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=37acd6ff-c5a6-4905-b104-2bffeac0ac1b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-03T02:46:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6680:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: 7c300582-a9b0-4359-a09e-08dd725a532d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QWUxWS85azFhL2JMNWh0Zm03OE0yQW5TM2dqN3ZuL3BTODNOOW1MZS9iWlJF?=
 =?utf-8?B?TmR6RjY5ZVFTK3FVNStoaUFwdDNPNnVWV1F5MURSK1NiL2hhVWJFM0hOaGJx?=
 =?utf-8?B?R2M3R2FDUlRubHZWbitid2MzV2hmK2xZL3V5K0FReUE2aTMvcStnY1RCQU9t?=
 =?utf-8?B?a3RXbDVlSkZXS3h2RWZqREpuTHQ2bHUvcEdtSzV5NUIzNy9aNHMzUWpRN2hr?=
 =?utf-8?B?dCtKallJRHNqaXVLZEIwVW44SEFiK1FiNEFLR3l2aGhsSHpRZm9BSDdDUmpI?=
 =?utf-8?B?Wm1wL0JiS05nck9temM0L1VJV0o2OWZURHA0VCt0elZDM29zK3p4TStlSUIz?=
 =?utf-8?B?d0xoSm1xVGY1SFVMLzkzaUdPVEdOQmdGdzZQRzUwais3TGRBbTNPY0s3WGxY?=
 =?utf-8?B?SW1KeWlNSzBvVEtlSllSSm95Y3Q4S1Y1Z1JoY3ZSNytRTTFNeE4xbTNubkR3?=
 =?utf-8?B?czZhL003MGhDK1dSNU1MNjl1ckV1eTdUVUFnS2JmWmJqTU85cm1DUUZxeS9P?=
 =?utf-8?B?QlRHSm91QWtSREZXQ081bE1vYUU1MGord2lGbFk1ZUxpaVN4TUZSVmdIVms2?=
 =?utf-8?B?YU94d1ZTMFYxelRTSXZpU1J5RHhJSEhjK3FhQnplWDVKTzdCTXhKRTdmdXBh?=
 =?utf-8?B?RHBmRzFKZUVkWUtwM0M0UEppWCswRTJxNU5kTUV0ekdJdWY3eTJaZkQ5cThE?=
 =?utf-8?B?STRIUDZLTy9lRTNwb1lmcmFMR1ZaVm9XWXEvcmRPaTM3V2tjT0xXczVCUk91?=
 =?utf-8?B?SEkvalpCTFdURXVxdEM0T25iWkxWZ2d2clJOdGJadmttRjYwN3RJVnFWcytF?=
 =?utf-8?B?WkdOWG14eWpXUVVUcXpYMlBBTG9qWnJkK25hZm1PR3dDZkJ3SHZjVUVGOWN3?=
 =?utf-8?B?ZzZKV0RsTkVTd0JrTEFDakVjdnhrY1ZvRW9WZ25CTGxmTGtNR2VuUi81c2lX?=
 =?utf-8?B?VmtNdGpPMTdCVUgzYnhxZnZ4aG5IaFE3c296aHYvdnF0SkdnOGc5Q1R0Y3dJ?=
 =?utf-8?B?SWFJTEg0bDhxSTdWTkc1eGZNQmZJSmw0WUZtbFlRMUNOVzZuQVgveUJNNmF6?=
 =?utf-8?B?dFlOcVNtbmVaK2l6UXRFQVpsb0dhZERQZiszaTVmTHBYUEhSSEtpaWQvdGJl?=
 =?utf-8?B?WGVLRDQ0NmpyMjZ6RG1aSFlPUDZ5YnA0N1I5aUM0SUJuUGViT1RSU2JLZk95?=
 =?utf-8?B?MUpzQmRmYzFYbi9QRlVGNGVwTkN1ajUwZlEvUzRBSGdWSzFNdTMwNGlJaWk4?=
 =?utf-8?B?MUlhTVFEUDc4dTVIMkdYUU9oNHFkS0dzK00wRTZEWkZwVkF6SUZrVFJ2Y0Jr?=
 =?utf-8?B?aStReWxndWF3MkozMEdvZ1lKOXhpMDlPeU5rN0VxY0FEN3FrWTRjdUhUbS9Z?=
 =?utf-8?B?V0hhT0thNkRmYmtGYnZENlBJNk90ODk1cXgyMGxhK2hCb2JjOGZhWlZ5bEE1?=
 =?utf-8?B?R2JhRkphVERBSFp6N1VOUGhQRnJLMUFOc09tV1BlQUZEYk5EOWZvS2d1b2lQ?=
 =?utf-8?B?dXpIRjdDWmtERW90dEZORE1uaUQ4ZmliL2VzaVorcXJlMGhWdFdLOWQyY1Fj?=
 =?utf-8?B?ZnVHeXk4UVJiYnc2TmluU3lKS1UyVU8vczc5bUhtWDRqdnFGQVJHVVYvNDZz?=
 =?utf-8?B?Wm9PMk8zS2MrbnBDc0hqbFNyL094bTVHMUp6cG1QaEg0OHRzS1N6c2RpVjJW?=
 =?utf-8?B?TGRwUFlWSmhEK0NwMFpKYnprUU1RNExDdi93eHNRNDlGTnp4VDNnMlpMZWF6?=
 =?utf-8?B?dDdjMTdJUjh4d1p2dTFOUXhHWlJWbXVmb2ZkYVpQVjU1U0RJTFphajN2SHph?=
 =?utf-8?B?cDRPZ0ptWFhhVkJCMy9GQzNzQ2doQmVYQVhSczJ4WFJEK3g5aGVwWG9lOGM2?=
 =?utf-8?B?cWVNbVQ4MDUveXVrOGdLMzNkV2RnODNKL2pLNTFWaUpOYW5FMDY5TUE4NVFE?=
 =?utf-8?Q?C4oWch+HYcA5pYckVOt+p0frTWSEoK/f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk1GallBVitPd1lMVE9DSXA5NXNSUUVGVHFyYkhONUlVMzVYWUU1TmxhN0dP?=
 =?utf-8?B?V0puWkFSY1N4WmY2UGk5QmdSdW16RDFONWdaUHZKbGRiU0pCc2F2T0xQL1ZU?=
 =?utf-8?B?Rnpwc0tUaWJKNCtjZTJySUc0R29LbVNrNHVCRzRsOWhKZktZczNLeEROTVhx?=
 =?utf-8?B?K3IxWXZiOFVsaHlRSnNHT1B3eU1RbFYwdDJWUUVDVUpPaG9hL0hkTytnTGFN?=
 =?utf-8?B?bU9rODRNU2dWbXFlOXZac2VJT1ZPLzVBVlV1VUNTVmtYOWZBUEk2YklGOWE2?=
 =?utf-8?B?Um0wT1Q3UmNyVXI2M3pXUGxaRG9sNVVyM3M4bnVXUUM3NmRDK1lvMStad1pQ?=
 =?utf-8?B?eGRNZmtVQzZVUDF4M0JSUVJ6NDBneW0vb3NwRlAzelpHNTZBZGlZRXJpR0Qw?=
 =?utf-8?B?eVpNSUQyL2NRcUplNFhyVGRHdk5Obnc1eDBYVWdEektUOVJuMFFlQmlsbzl1?=
 =?utf-8?B?b3ZWZ2JTdlhZajMwSytJQ1llZ1VFUjlvbXRQay8yYjdyS3VJV2V6aEdoVGVm?=
 =?utf-8?B?WXV0SFRQZnF2QkdibWRTZ0UxREFvVXlIVmNRNEw3UHFmY0JBK1RWSUxidVlP?=
 =?utf-8?B?cTZPbi8rTGgvak1MR2JINmhIU0ExYThoeFBKL3ZjUURZeE5NUVRNN3pVTDE1?=
 =?utf-8?B?dWRVaUpQNWtNWWZzdXhxYU5sb0dCanJ0cWtHK1Rzei95YXdITUpQbmo5Z2x4?=
 =?utf-8?B?R1RDaklET2FZeGV5UkpTZk1qSDBTWm1wYXlDdVJWUXY3cUdyZ0pwQzMzcU5U?=
 =?utf-8?B?R0x6VGo1STZVZzdtc0M0a0lCTExFZlBTeEN5dU1yTm1QazMyOWpWc0d0QWNz?=
 =?utf-8?B?MXdnQ2lTb2tCeGkzMDNTNVZGOXZUZWNXNWc0VVlaUWNGZFViSElyQ2s1UHZR?=
 =?utf-8?B?RHB3VE1CNmEydUVwZk9iSnBreHhmbkprNGZMOStRcjB6RnR3djIyN0U5LzRs?=
 =?utf-8?B?ai90Wjc5SUcxckU1cDEyN2lNNStwQmFaS040ajA2U2Mrb2grMHBpbHBUMWlJ?=
 =?utf-8?B?dTJhQnV2TEF3MWhpQkpXajRKaUhaRFNKb3E3ZFJReTJvVyt3dVgweTIrck5H?=
 =?utf-8?B?ZHk0d1BYRUdoVkFtaCtueU1OMXhIdUcxRC9aYm5tL0taWVVJb1NhcStvMnJG?=
 =?utf-8?B?R2JNYWJ3enk0WFpUb3RPemVhSGgxVlZXVWtBaFhFNTQyVnFCL1ROYzhFR2Uv?=
 =?utf-8?B?N0xSc3B0VE14SVpFeGgrQTBOcWcyeENPZnRsdUJ5djIzVUhMUFAwYVYrK08z?=
 =?utf-8?B?UnRzZVdGaG1uckZuL2RWNlZVc0RmQVZQbmUwdnR0U0Qxd0hnSEZ4WTdFRmRH?=
 =?utf-8?B?YmtoaDczZXo4eDhONmdUZDdadzJodFJGaXcyVW9pTFUxaFl2RDU0U1hXMGhi?=
 =?utf-8?B?ZFRLOHQzUGF5eHJqZXJPVm1BREJ4OHFNVXBYUC8xUGozR2hmLy9jUXE2Rlor?=
 =?utf-8?B?djFCS3JkUmNzOUlzVWtsdlNlVFBTeFJtQUxtUkJLby9iL3E0WmRLcDV1YXJo?=
 =?utf-8?B?dm9FSjBZNm9ucjV2WnJaQkxEYTFVWFNIUmNRUFRmbzE1a3ZDVnk1WHpSSlkr?=
 =?utf-8?B?UVg4NFk2ZisxV1k2VHh3K1B3aHpYLytWcExrOStzaGJPSSs0U0h1OHF4b215?=
 =?utf-8?B?d2lwTS9VS2g5MUM2L0s2Y2FLZUJsM3dWc014TTVkcmRwSXk1N01BN2wxdWcz?=
 =?utf-8?B?Sjc0SCt6LzJRUHhXdWdXZkgwVnhtVjBhSm5Uek9haWRldmx0Z0NnQ3V1QVR3?=
 =?utf-8?B?TUJYdjk1dlJtL0xMYUhSRGV0QmZTM2FBTDAyUGFuTVJxQmVJcXVBTlgxcWRS?=
 =?utf-8?B?MndKT0ZlamIrTC9WMWRtVWk2RkltVVRReW1LeGVObC9CdmdxYnlJcFR2Y254?=
 =?utf-8?B?Vmo0RFhnUGZjZk1iK05qTkpVYjBUZWlWbWgvQjh5d2daUmsrVzEreGRYaUc0?=
 =?utf-8?B?aU5uUGRKSkQ3aHExZmFwa3dkU1pSQlcybzROUzVrNVJLTytEM0RacTVCRmta?=
 =?utf-8?B?M3g4ckdiMGlUUllmQVJSSmJQd0RaR28vMkxyZkhyVmRVVi8vR3UzbmVkZHlh?=
 =?utf-8?B?M3ZMdHZMejN2WlpVWmlnWHoxOW1NYUIrL1FrK0dGRWlabnduRVhSK2thZVBu?=
 =?utf-8?Q?Y2Qw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c300582-a9b0-4359-a09e-08dd725a532d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 02:50:42.4567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: duqaALGXIWhnllPXj9hFCpkSur0lZsPFcrtGblvHPm29hvBa5R3IQHeDwtSETxzJL/ThwZXA4DGG/bHglhCDjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

W1B1YmxpY10NCg0KSGkgQ2hyaXN0aWFuDQoNCkkgcGluZyBMZXNsaWUgb2ZmbGluZSB3aXRoIG5v
IHJlc3BvbnNlLg0KDQpIb3cgYWJvdXQgdGhpcyBwYXRjaC4NCkxvb2tzIGxpa2UgbW9yZSByZWFz
b25hYmxlIHRvIHB1dCBkb29yYmVsbF9maW5pIHdpdGggbWVtX3NjcmF0Y2hfZmluaS8gZnJlZV9z
dGF0aWNfY3NhIHRvZ2V0aGVyLg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jDQppbmRleCBkNGIwMWVmMDAwMjUuLmZmNDgwOTZjMWQ4MCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQpAQCAtMzUwOCw2ICszNTA4LDcg
QEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpDQogICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX21lbV9zY3JhdGNo
X2ZpbmkoYWRldik7DQogICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfaWJfcG9vbF9maW5p
KGFkZXYpOw0KICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3NlcTY0X2ZpbmkoYWRldik7
DQorICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9kb29yYmVsbF9maW5pKGFkZXYpOw0KICAg
ICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBpZiAoYWRldi0+aXBfYmxvY2tzW2ldLnZl
cnNpb24tPmZ1bmNzLT5zd19maW5pKSB7DQogICAgICAgICAgICAgICAgICAgICAgICByID0gYWRl
di0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzLT5zd19maW5pKCZhZGV2LT5pcF9ibG9ja3Nb
aV0pOw0KQEAgLTQ4NTEsNyArNDg1Miw2IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pX3N3KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KDQogICAgICAgICAgICAgICAgaW91bm1hcChhZGV2
LT5ybW1pbyk7DQogICAgICAgICAgICAgICAgYWRldi0+cm1taW8gPSBOVUxMOw0KLSAgICAgICAg
ICAgICAgIGFtZGdwdV9kb29yYmVsbF9maW5pKGFkZXYpOw0KICAgICAgICAgICAgICAgIGRybV9k
ZXZfZXhpdChpZHgpOw0KICAgICAgICB9DQoNCkJlc3QsDQpaaGVuZ3VvDQpDbG91ZC1HUFUgQ29y
ZSB0ZWFtLCBTUkRDDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZaW4sIFpo
ZW5HdW8gKENocmlzKQ0KU2VudDogVHVlc2RheSwgQXByaWwgMSwgMjAyNSAxMTo0MSBBTQ0KVG86
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgU2hpLCBMZXNsaWUgPFl1bGlhbmcuU2hpQGFtZC5jb20+DQpD
YzogU2hhcm1hLCBTaGFzaGFuayA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBmaXggd2FybmluZyBvZiBkcm1fbW1fY2xlYW4NCg0KSGkgTGVzbGllDQoN
CkFueSBjb21tZW50IG9uIHRoaXM/DQpMb29rcyBsaWtlIHlvdSBhZGQgdGhpcyBjb2RlIDMgeWVh
cnMgYWdvIG9uIHBhdGNoOiBkcm0vYW1kZ3B1OiBVbm1hcCBNTUlPIG1hcHBpbmdzIHdoZW4gZGV2
aWNlIGlzIG5vdCB1bnBsdWdnZWQNCg0KQmVzdCwNClpoZW5ndW8NCkNsb3VkLUdQVSBDb3JlIHRl
YW0sIFNSREMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBNb25kYXksIE1hcmNoIDMx
LCAyMDI1IDg6MDcgUE0NClRvOiBZaW4sIFpoZW5HdW8gKENocmlzKSA8Wmhlbkd1by5ZaW5AYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogU2hhcm1hLCBTaGFzaGFu
ayA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXgg
d2FybmluZyBvZiBkcm1fbW1fY2xlYW4NCg0KQW0gMzEuMDMuMjUgdW0gMTM6MjYgc2NocmllYiBa
aGVuR3VvIFlpbjoNCj4gS2VybmVsIGRvb3JiZWxsIEJPcyBuZWVkcyB0byBiZSBmcmVlZCBiZWZv
cmUgdHRtX2ZpbmkuDQoNCkdvb2QgY2F0Y2gsIGJ1dCBkb2VzIGFueWJvZHkgcmVtZW1iZXIgd2h5
IHdlIGhhdmUgdGhlIGRybV9kZXZfZW50ZXIoKS9kcm1fZGV2X2V4aXQoKSBoZXJlPw0KDQpJdCdz
IGNsZWFybHkgZm9yIGhvdHBsdWcsIGJ1dCBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSB0
aGUgYW1kZ3B1X2Rvb3JiZWxsX2ZpbmkoKSB1bmRlciBpdCBhcyBmYXIgYXMgSSBjYW4gc2VlLg0K
DQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IEZpeGVzOiA1NGMzMGQyYThkZWYgKCJkcm0v
YW1kZ3B1OiBjcmVhdGUga2VybmVsIGRvb3JiZWxsIHBhZ2VzIikNCj4gU2lnbmVkLW9mZi1ieTog
Wmhlbkd1byBZaW4gPHpoZW5ndW8ueWluQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTUgKysrKysrKy0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IGQ0YjAxZWYw
MDAyNS4uYjQ5NjA0YWRlNmMyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+IEBAIC00ODA3LDYgKzQ4MDcsMTMgQEAgdm9pZCBhbWRncHVfZGV2
aWNlX2Zpbmlfc3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgIGludCBpLCBp
ZHg7DQo+ICAgICAgIGJvb2wgcHg7DQo+DQo+ICsgICAgIGlmIChkcm1fZGV2X2VudGVyKGFkZXZf
dG9fZHJtKGFkZXYpLCAmaWR4KSkgew0KPiArICAgICAgICAgICAgIGlvdW5tYXAoYWRldi0+cm1t
aW8pOw0KPiArICAgICAgICAgICAgIGFkZXYtPnJtbWlvID0gTlVMTDsNCj4gKyAgICAgICAgICAg
ICBhbWRncHVfZG9vcmJlbGxfZmluaShhZGV2KTsNCj4gKyAgICAgICAgICAgICBkcm1fZGV2X2V4
aXQoaWR4KTsNCj4gKyAgICAgfQ0KPiArDQo+ICAgICAgIGFtZGdwdV9kZXZpY2VfaXBfZmluaShh
ZGV2KTsNCj4gICAgICAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zd19maW5pKGFkZXYpOw0KPiAgICAg
ICBhbWRncHVfdWNvZGVfcmVsZWFzZSgmYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncpOw0KPiBA
QCAtNDg0NywxNCArNDg1NCw2IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pX3N3KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICBpZiAoKGFkZXYtPnBkZXYtPmNsYXNzID4+IDgp
ID09IFBDSV9DTEFTU19ESVNQTEFZX1ZHQSkNCj4gICAgICAgICAgICAgICB2Z2FfY2xpZW50X3Vu
cmVnaXN0ZXIoYWRldi0+cGRldik7DQo+DQo+IC0gICAgIGlmIChkcm1fZGV2X2VudGVyKGFkZXZf
dG9fZHJtKGFkZXYpLCAmaWR4KSkgew0KPiAtDQo+IC0gICAgICAgICAgICAgaW91bm1hcChhZGV2
LT5ybW1pbyk7DQo+IC0gICAgICAgICAgICAgYWRldi0+cm1taW8gPSBOVUxMOw0KPiAtICAgICAg
ICAgICAgIGFtZGdwdV9kb29yYmVsbF9maW5pKGFkZXYpOw0KPiAtICAgICAgICAgICAgIGRybV9k
ZXZfZXhpdChpZHgpOw0KPiAtICAgICB9DQo+IC0NCj4gICAgICAgaWYgKElTX0VOQUJMRUQoQ09O
RklHX1BFUkZfRVZFTlRTKSkNCj4gICAgICAgICAgICAgICBhbWRncHVfcG11X2ZpbmkoYWRldik7
DQo+ICAgICAgIGlmIChhZGV2LT5tbWFuLmRpc2NvdmVyeV9iaW4pDQoNCg==
