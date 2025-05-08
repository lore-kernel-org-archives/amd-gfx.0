Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70232C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 07:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A2F10E8C8;
	Thu,  8 May 2025 07:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8VQ+4rd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D28C10E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 07:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDio2mExFyf0ggZs/HPch/FOVHuskO6/L+iUgx0xYixzBdDjFIAMPK483t6R4D1L2+VwrnZyIY8PhIcGqaFvc1pIOSytqLPUt1txAeJ4qy8btCwBxPHzdtYw64wDAgbWWcW+k8fcHlQjyvZtFRGVndfjVLO2D7PTqrWqm3YPqC3YeEUnsIHaUtvAKOTNAcGySWT0Vcw1eAX08V37MhnPHHHC9iW+TUK8rDUiLiLNiSiKlHcGfj7GqJISYxXTV5J6sJ4XfIZ5zErepJVySw0P6QhCLn8Q+TpECYyINrRfrUM9kPLfoc0sfgbJ6xpt6E3UQCwrzXvRCLCZeN0wTdH/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Bcdvdjr+CwCh581TGtfaXDJMAOJwHn1/D5x7w8fEU=;
 b=dL8MXaSbTOIHTbaBGL7dPyKy1Sc9t5EmmMmiaVR3bmRhBdtSBI+zf0al7uk2tk+epKfz37t1QWof2FxA8oU9AaEzTfC76wb/FYsbZTWWYYuTCe9HqcB4cB38gYU26DDcUvpuUn/q99VrR7f6y98eJNllyQhggkLPR+nt6S5+Wkj8Iwl2Mc68e8p45lDMTsF1F7hi1L+8axUFamTCdC+vkzGr5/QocP9QQ5yPpvE8zN1oQQ06vL3hPNCHg8jFHTkT1wzoOIdCk5Z2Rfp9KyYmCwAh8hTDBT05xb8SnTSzZiFVkAqd3cvaOsZ0nI0h3UTH8YAwQYwd4bO+Lj54B1EPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Bcdvdjr+CwCh581TGtfaXDJMAOJwHn1/D5x7w8fEU=;
 b=J8VQ+4rduw9nJhQ9yfqxcEvB/V5o1ggdRUjHR8FAz0g9rsZ5BJSXSbwE+NkLfDXq6jyeq5NhlKRlbqOyssMPVmoBOkw1fHhEvmaT5LoqLYHFUlfl+w3wiDVTvWD6lpA/ug0VE+rXO/8aX+4fFmA3RRtz342HnlZBnSCmRi1BgXw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Thu, 8 May 2025 07:08:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 07:08:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
Thread-Topic: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
Thread-Index: AQHbuXlYV72zWkIYkEm/msCIUTRZELO8HE2AgAkuSkCAAAbzAIADB6dw
Date: Thu, 8 May 2025 07:08:05 +0000
Message-ID: <DS7PR12MB600529CF3069303E7F088C35FB8BA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-4-Prike.Liang@amd.com>
 <62a987a4-d865-4b64-8cb2-a664e7969233@amd.com>
 <DS7PR12MB6005615C194915A4C862CBF1FB892@DS7PR12MB6005.namprd12.prod.outlook.com>
 <3747fa9a-032d-45fd-969f-d4744fa4b466@amd.com>
In-Reply-To: <3747fa9a-032d-45fd-969f-d4744fa4b466@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=73cf4618-7619-426b-b069-2b9a6be3681b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-08T06:54:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS4PR12MB9610:EE_
x-ms-office365-filtering-correlation-id: ba197806-6260-46bb-90f1-08dd8dff1498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YitwV0IvRGhMSDUzVXcvbVR6d2Ztc1ByUDRTWlpsdG5NN0NWanFGQU5kYTRn?=
 =?utf-8?B?WmI5SWpwWEdVWE1ZVkptdVdvc1VZcjN0K3NSUUlqbCtpeUZhajVsUzVXU1Nm?=
 =?utf-8?B?UE1WdUFRUm81aXZCTzI5UkltMFJYQWhlQys4ditWajZObzRsUkFPUVRqb25y?=
 =?utf-8?B?MEtFaXI0RCtJZ3NrN1dYUFk5eXVDenVieng5cEQyNTl5ZDBwMnJhQ1M0SnY3?=
 =?utf-8?B?L2I3UzhPTkM3c0NpM0o5dGJOeERNaCtjMysyV2FiNmgzQml5SWFMdVMzdzUy?=
 =?utf-8?B?QmV2cC9QQ3AzanBHTGFMRjNaQ1VrL2l0dXltdkIrZjMzZWJXbS94UVJHeGh0?=
 =?utf-8?B?bU1lbVplaE8vbHZFTWNLSkhLaDlQUGVuSU1odzdoZU5qTVVocGZGdHg1ZTVD?=
 =?utf-8?B?b041Z2w1RXpyMGF4RlRJTTlZMjBvRjRmNWFQRjB4aEdsM2RDSGhqd0tsTENr?=
 =?utf-8?B?YjNxbG9UNThOdmRmc2R1NW1hVE5YOVhXakp3dW5kQmwzVkFUUlJvem9XWW8r?=
 =?utf-8?B?Y0V1NHlwb1dKRm05L0ZrbFVuYlVPOE43ZnpZTytUd3JQdHJzaVkxM3o0RUhO?=
 =?utf-8?B?UkF4SlQ1UTJNQkRKNjF3NlZZTUh2WGhOVTVUN09aajZ0MnBhbW9jcml6ZzBT?=
 =?utf-8?B?QWFBVlFOTUcwNVFOQTdFVnp3R3dyZGN5dlpsV2M2TUNuUVJzM3BnZDQxUVln?=
 =?utf-8?B?WnUwZC8zTUFVWWdaZDdlN2RwT3oxUXV1RVRYS3BhbE1KUEVhQ3RIclk0WHVk?=
 =?utf-8?B?dWdlNm5RRDlER0V4MnhnQ3h2M0RFcTNyS2J3RUJGL2VucjIzNEw5QUM3N3BN?=
 =?utf-8?B?cENiZG1PSWpjVTloTTQ5ZkxaekJXUWU0aEIrYkp3SFVVQzRxWFdiT0VlQ2Z2?=
 =?utf-8?B?dG9VMnRCWDZIdHhiQ1E1QzNaaUhWNXJ4VmEvS3Z1UEZ4WkxoVGpLSTZob0Z1?=
 =?utf-8?B?Nm1JWDA2djZ3cWQxNDJZQndMNHh2TnZTWDVLL2RXZ2lZUnR5cVJRVGMzbytx?=
 =?utf-8?B?dHc5V29Ja0ZkNkUwYkpHQzAwR3VLQXFWWXl3dGRoNng3Qk1vTmU1ZU01VElu?=
 =?utf-8?B?VWo1K2I3OGhVY2pBUmlqQzJvNlpJaGtpUHF6eXZTVi9SamtaT1NiaHhtOE0r?=
 =?utf-8?B?REpnRjFXdHlZRzhOM1l5TkFka0tOS3NPNlZXY0wzZmxzRTZqaVZpbEIvMW1s?=
 =?utf-8?B?NFFLRUdwc0l5Y0taUndQamNXZU1EWHhmakxVcVRGK2o3MXhucHZoaWQxRXMr?=
 =?utf-8?B?S3I2a1RKTHp2eTc1MWVoQ0RCbXZTUTlQUG9HNHpDOER6S2xaVzZ4NVR2SnJW?=
 =?utf-8?B?MEN1OC9udGRQc0IxMW1tLzB0VkZlVm1zYmx0YXZ5cWkzTW0xSXNmNkFTeVky?=
 =?utf-8?B?bjBCRE10M0MwK2FNVlBad1FESVRkUC9yUjl4R3ZreG8ya1crYkVCeUhiK1FE?=
 =?utf-8?B?NTFMd3RjZ3hzZVJzNExsSTJrSEwrODhUdGdmUVFDVFJTMVJZR00wc2cvNTBZ?=
 =?utf-8?B?cjg5ZEdLVVFyck56U0x2REFCZTBDWTFidkdNd2d4YjdNOHNVOXpIdXh4Vlll?=
 =?utf-8?B?dXM0aDJWejJObWorZXhoNUYxWHBiTExSbzNDTE5idnRqS0NTWTNtRE82dHFj?=
 =?utf-8?B?aC9DSmw5UmdZVzRrREJGcm13cmQ2Sm1udEh2ZFJrUVVldmVMTldlN2h6T0Rl?=
 =?utf-8?B?cU5GNFFpTkMrVVNibE8xQTdrWFpENkN4V0gxTlpHM0gxNzBKYXVFS1g5aHkx?=
 =?utf-8?B?N1ZLc1djbEV6V0JWakxYOUpieWdFUlNJUDdtcFIrMFZScXJ4VWUyYUdyVmFE?=
 =?utf-8?B?Z3pDTDlUQzdFREN1cXRwd3o3Q0VRazA2WXg3c0t0V20xY1d4eWlQYXp2Wjlp?=
 =?utf-8?B?RzBlZStmaytjK0M3MDhUVGVzTlRUZGtLWWYrRnRWVk5qenpRRXExTDRSRHI1?=
 =?utf-8?B?eDczdGdrN2xla3VSejBRWWM2MTNEeVZyVmJQcmVZNXkvMGFXVkw5UDEzWlNn?=
 =?utf-8?Q?Buv/hh0vwGJWkUubcMnlXNKq09IvmE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2gvSlp5T2Z2a0dJSUZkcFB5ZkhuenBhNFRaQjl3bVBJcVJqQk9XZVR6Nmox?=
 =?utf-8?B?T1YreTRaYklsclBmcVhZTWlIWmdENmRSS1BIbVQxNUN0b2RUS1pIQUJlYXFJ?=
 =?utf-8?B?dTY5dnlXWkVRK2dVUmtGdWoyQVcydEdmZmRuOWtzMjJXR2ZWM1dLMUJYNmhH?=
 =?utf-8?B?TTZURmtPL1BkU0hkKzM5Mzh2eGNyQVJnaWh0cnkwdGVOU1VrUW5OSmdGVk50?=
 =?utf-8?B?RTlCeXpIQ21pdXovWVJnamNTV1J6aUUybWhrNDgxYWpoUjhFbkxOeURxTDlJ?=
 =?utf-8?B?LzQ5TmNCU0pHZ2VTT3lXMTFnTjd6RjlCK2ttTWhSUjU1QXo0RkQrbFRYZEx0?=
 =?utf-8?B?cld0NzgxNjlhMzZCblR0TXRMa1VQRFpyWnBMSU5rdCtXYitXVG1NM2hKMnlo?=
 =?utf-8?B?S2YzQzhRR0ZYZXhXRFI5TnNwcjNhYWJ1L1ZYU3dBOE80cXlHeStESWZaWktQ?=
 =?utf-8?B?SkVidXhlTWhRdFJhdUFpaTh4N1dNd2RoNUhXcnpmL1hRN3hwSFcrZ0VhU2NP?=
 =?utf-8?B?T1hWQUgzUUVWczU1MGJpTjM4eEMwZFlYNUZWbDZpN3pUMit5cG1jK3ErU1cr?=
 =?utf-8?B?TnFvOFdEMnNFMjNPSUFkU3RRV25GUThyUGw1SEdFSVpzQ1Z0cTU3aVBENFRJ?=
 =?utf-8?B?UjlYR3U5SThwQzJiM3hMLzhPMlJLTW1UQXM1TG50SmJuWDBmejI5YTJTendn?=
 =?utf-8?B?NCtWSW1hTDA1QXlCSlVaaW4xK01SUjFvMFhzTVUzRGkrMzJPVHlFMVBNeE9X?=
 =?utf-8?B?c01YRDA1V0pKeEIzYnk4QnVYbG9oK1F4aml6UzF6cml6bkZHUE43cjZPSTFu?=
 =?utf-8?B?U3M2dGpUV0U5TllRVXhTdDVyMGc1TVd2WUhEM0UreGJMays2VVVQV0NFTDE2?=
 =?utf-8?B?UW1zaGRyYjJ6NUgweUJUVU9KUVBLa3hYTi8vRlUxSEkwSmp4alo5TVVySmNL?=
 =?utf-8?B?bThJOGtmV3AySzAwMG5xcDVaNm9HL25yR0d5bmNFK2ZtdXdnTnFZdGJkRDZh?=
 =?utf-8?B?ZHNHRjdBSjhqZzRKWVJyUVJ5cEI4WXJ5TVRDdUNVMGZ5VVhpejFPSU5rOHBP?=
 =?utf-8?B?WXB5dnFlSmZhTGtLYjcxWHN2MUsyOGZGNnFRYkMvLzJpazF2TkdpclBvcWx2?=
 =?utf-8?B?dnJCbTBJc245Wis5aU9DNG5QWHlwUUFMOEFOeFV5ZGJMclNnc05Odkp4cDI5?=
 =?utf-8?B?UE9ESi9BNTNLZWJMQTJabnNJdUljREs0Yk53OEZhUytKeVUya2lMeUxXeHVN?=
 =?utf-8?B?TXo2b2dwbWdDZkpnQXNHbXRVZXh0RmpPdVV6MFZQRE9zQStRWS9xSGxYd1Aw?=
 =?utf-8?B?R1J5Y3FiOXNoSFgvQVZsejJzNm94UVJWcHlsTjFHLy90S1VINStsLzJZWXh5?=
 =?utf-8?B?VWVFRmhVUXB3dVJIM0E4a2xqd2tkQnplS3BPT2QraHBVRXhjSjhIZGpFWER6?=
 =?utf-8?B?UENiSjdaM2dkNlFPM01YQm9rb0U1N2h1ditiWTdWaytoaGZuNC9HRWJudjRx?=
 =?utf-8?B?djBsUU16UnROMW13VVBubFIwWDJCOGJ2M0I1ek93cWxJWm9qRDdZK1IyWWJE?=
 =?utf-8?B?SVhmYWxsVTVhcVBFdTducmtZUGVaWi9WTHJiTUY2dFYxY1Z5SnBiRXQzNWJJ?=
 =?utf-8?B?bTdQWVJNQVZTZFd5MVJxcGtvQVYvZTlCOWpvc3B3YjBJRCtOYzFZdVZvZlNu?=
 =?utf-8?B?d3dweDVSYkg4R0wxUHF2VHZNRU80MlI0a05WaXNlRHJBczl6OFk1MEl1WWV2?=
 =?utf-8?B?UnFxalNIWmdMSzF2dVhoT0FSeVY3MVpKZUtkb3FlTkFTbXBZbzNBdkIrTUdk?=
 =?utf-8?B?ZG1wcndvNVFWM1hwK2VRZWR0OGN3QlErK2dQelB6QXlEaUF6ejBnNVh1MGNO?=
 =?utf-8?B?MDhjdk41Z01KWnBtQ1BkeTNUaEt5eXRhZURBZWkySUhnK2dHd1JuRFpGYWhL?=
 =?utf-8?B?dzJRQ0F3NVJPN3VxY0VuRGUwWnZHWGdZd0Mxb3A3bnQ0RlBwdjZocHl3WStB?=
 =?utf-8?B?ZnhCQnRzN1U2Y1l6ZENuVldFaG9sNitZMDRQM2NZMUc2dWV2czJraGV0cTNk?=
 =?utf-8?B?L2dqbkpGVHk3WHBxSExzYzkxWTVweEZDNU01d2dYcWtWRlhDU0FTYzY1d0ZQ?=
 =?utf-8?Q?R9/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba197806-6260-46bb-90f1-08dd8dff1498
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 07:08:05.8044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /W4GwI3luM5FxbU5aK5AZvLqQ5qA+sxP58m7iCZsadTmwbdHajE09XegFsEeJiWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgNiwgMjAyNSA0OjM5IFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvNV0gZHJtL2FtZGdwdTogdmFsaWRhdGUgdGhl
IGV2aWN0aW9uIGZlbmNlIGJlZm9yZQ0KPiBhdHRhY2hpbmcvZGV0YWNoaW5nDQo+DQo+IE9uIDUv
Ni8yNSAxMDoyMiwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+Pj4gLSAgIC8qIGF0dGFjaCBnZngg
ZXZpY3Rpb24gZmVuY2UgKi8NCj4gPj4+ICsgICAvKiBhdHRhY2ggZ2Z4IHRoZSB2YWxpZGF0ZWQg
ZXZpY3Rpb24gZmVuY2UgKi8NCj4gPj4+ICAgICByID0gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2F0
dGFjaCgmZnByaXYtPmV2Zl9tZ3IsIGFibyk7DQo+ID4+PiAgICAgaWYgKHIpIHsNCj4gPj4+ICAg
ICAgICAgICAgIERSTV9ERUJVR19EUklWRVIoIkZhaWxlZCB0byBhdHRhY2ggZXZpY3Rpb24gZmVu
Y2UgdG8gQk9cbiIpOw0KPiA+Pj4gKyAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShhYm8p
Ow0KPiA+PiBBZGRpbmcgdGhpcyBoZXJlIGxvb2tzIGxpa2UgdGhlIG9ubHkgdmFsaWQgZml4IGlu
IHRoZSBwYXRjaC4NCj4gPiBBcyB0aGUgZXZpY3Rpb24gZmVuY2Ugd2lsbCBiZSBpbnZhbGlkYXRl
ZCB1bnRpbCB0aGUgdXNlciBxdWV1ZSBpcyBjcmVhdGVkIGZyb20gdGhlDQo+IHVzZXIgc3BhY2Us
IGhlcmUgaXQgcmVxdWlyZXMgdmFsaWRhdGluZyB0aGUgZXZpY3Rpb24gZmVuY2UgYmVmb3JlIHRy
eWluZyB0byBhdHRhY2gNCj4gYW5kIGRldGFjaCBpdCB0byB0aGUgcmVzZXJ2YXRpb24uDQo+ID4g
SSB3aWxsIHRyeSB0byBkcmFmdCBhIHBhdGNoIGZvciB2YWxpZGF0aW5nIHRoZSBldmljdGlvbiBm
ZW5jZSBhdCBhdHRhY2gvZGV0YWNoDQo+IHNlcGFyYXRlbHkgd2l0aCB0aGlzIGF0dGFjaCBlcnJv
ciBoYW5kbGVyIGNoYW5nZS4NCj4NCj4NCj4gTm8sIHRoYXQgaXMgY2xlYXJseSBpbmNvcnJlY3Qu
DQo+DQo+IFNlZSB0aGUgZXZpY3Rpb24gZmVuY2Ugd29ya3MgbGlrZSB0aGlzOg0KPg0KPiBWYWxp
ZGF0aW5nIHRocmVhZA0KPiAqIENyZWF0ZSBuZXcgZXZpY3Rpb24gZmVuY2UNCj4gKiBQdWJsaXNo
IGV2aWN0aW9uIGZlbmNlDQo+ICogTG9jayBhbGwgQk9zDQo+ICogUmVwbGFjZSBldmljdGlvbiBm
ZW5jZQ0KPg0KPiBBdHRhY2hpbmc6DQo+ICogTG9jayBCTw0KPiAqIEF0dGFjaCBjdXJyZW50IGV2
aWN0aW9uIGZlbmNlDQo+ICogVW5sb2NrIEJPDQo+DQo+IERldGFjaGluZzoNCj4gKiBMb2NrIEJP
DQo+ICogVW5jb25kaXRpb25hbGx5IGRldGFjaCBhbGwgcG9zc2libGUgZXZpY3Rpb24gZmVuY2Vz
LCBubyBtYXR0ZXIgaWYgbmV3IG9yIG9sZC4NCj4gKiBVbmxvY2sgQk8NCj4NCj4gVGhpcyBvcmRl
ciBpcyBuZWNlc3Nhcnkgb3Igb3RoZXJ3aXNlIHlvdSBicmVhayB0aGUgbG9naWMgaGVyZS4NCj4N
Cj4gQW55IGFkZGl0aW9uYWwgY2hlY2sgd2lsbCBjb21wbGV0ZWx5IG1lc3MgdGhhdCB1cCBiZWNh
dXNlIGl0IG1ha2VzIHRoZSBvcGVyYXRpb24NCj4gcmFjeS4NCkFzIHRoZSB1c2VyIHF1ZXVlIGV2
aWN0aW9uIGZlbmNlIGRvZXNuJ3QgY3JlYXRlIHVudGlsIHVzZXIgcXVldWUgc3VibWlzc2lvbiwg
dGhlIGV2aWN0aW9uIGZlbmNlIHdpbGwgYmUgTlVMTCB3aXRob3V0IHVzZXJxIHN1Ym1pc3Npb24u
IFNvIGRvIHdlIHN0aWxsIHRyeSB0byBhdHRhY2gvZGV0YWNoIHRoZSBudWxsIGV2aWN0aW9uIGZl
bmNlIGZvciB0aGUga2VybmVsIHF1ZXVlIGNhc2U/DQpJdCdzIG9rIHdpdGhvdXQgdmFsaWRhdGlu
ZyB0aGUgZXZpY3Rpb24gZmVuY2Ugb3IgdXNlcnF1ZXVlIHdvcmsgYmVmb3JlIGF0dGFjaC9kZXRh
Y2ggdGhlIGV2aWN0aW9uIGZlbmNlLCBidXQgaXQgd2lsbCBjb3N0IGN5Y2xlcyBmb3Igd2Fsa2lu
ZyBvdmVyIHRoZSByZXNlcnZhdGlvbiBmZW5jZXMgYXJyYXkgaW4gdGhlIGRtYV9yZXN2X3Jlc2Vy
dmVfZmVuY2VzKCkgYW5kIGRtYV9yZXN2X3JlcGxhY2VfZmVuY2VzKCkuDQoNCj4gUmVnYXJkcywN
Cj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFByaWtlDQo+ID4NCj4gPj4N
Cj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0aWFuLg0KPiA+Pg0KPiA+Pj4gICAgICAgICAgICAg
cmV0dXJuIHI7DQo+ID4+PiAgICAgfQ0KPiA+Pj4NCg0K
