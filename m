Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F46CC0219B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8696910EA90;
	Fri,  7 Feb 2025 10:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfL+61JM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5FC10EA8C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heeEGV9QDGZWTYpTsVclVeG9QdBhRW6sRkt2qmS775T0iOhJQCYTqvN+QGCvtJpx1ubfykOXep3N4EzAL7Cp2bnSSNAoYhdSFnrOPVI9P2F0Vr9bk/foccIO6mF4QiAJvK1vKYdxQj+AaNLjonIR6sw8+4132lJAggM/TkZrcOFvoz4WytF2VU5YfHs5gxuv3x0DQhODbpgKU01Cj/j0vqEGOT+2bcg6MKBW/8HtysfdEh2NNv3TbkhMdtPxReZjdOPjkhdb863Jxv60mVJxQ+IO8/ns15soEWuc4VIfFxFEBkLGAnZQhkcjD9v3fvzI2mAdBfP2xpJfce8fMVypMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM7V/ziba/3PrQzoMyDOy6OQS+P/lAX5asGSf+tAYNk=;
 b=nosPHaQNIxXEM3Hs2LalxRGM8yVAu2z6fX1mtZtCDQPGLqXd9G9ZPzks85zcvmXy2FHoPAI5Zolo2OvumLqIOmJEt1X+keLd86kq0yjiCcNmmg0IkPtlhkzXs3z+/877hqWymp5AocRTTIGbX+M8CL1sovI2NC9JXRCvKoMXVqBpinj6CQoAlsh3F1jmGDmienOgJbk1ODbpYKjk+l4wnZnHJHdxsbWq4tjWaiV7md5svBBVF2kgrsaEUxw0BUifLMAGqq4/ZQRpI/mEwf5E1mGSpNxPTCxahIro3+a27KH3aj+2Avz7ov5QFtxsMOxhc2eGcK9bPF0L4bGZSlATuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM7V/ziba/3PrQzoMyDOy6OQS+P/lAX5asGSf+tAYNk=;
 b=bfL+61JML8bhKY7s+dMEWV+mJ/jz7XgxNET2Vt0DlyNoanhgEP0P66QeX7gdHyW8zEtTTCPcJUUTuc59gL6Cjir3PXUqnW52ixfTUQBL5IGoHtZDsxg4htjnfhQAIA8gBNsR7JeBJ4qJKhyjj4WtpTarTRGiynqnZHbhj/pGY+k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 10:04:46 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 10:04:46 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: Add cleaner shader fence address handling
 in MES for GFX11
Thread-Topic: [PATCH] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Index: AQHbeUD4NWXzaWIr90+ZsWWbpxUba7M7kCqwgAAMa3A=
Date: Fri, 7 Feb 2025 10:04:46 +0000
Message-ID: <PH7PR12MB5997B2ED08002071915F94BE82F12@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250207091548.1096804-1-srinivasan.shanmugam@amd.com>
 <PH7PR12MB5997944BE641E92602AD492982F12@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997944BE641E92602AD492982F12@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b1c705da-0c90-4301-9731-b01820d95136;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-07T09:19:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB6653:EE_
x-ms-office365-filtering-correlation-id: fa794d68-fc21-420f-a645-08dd475ed9c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MUF2bjFwaHNDcW5BMGsxVDZUQlZ6Qm0vd1pKbmd6bUQ5TThHSnQ0aGlnVUd4?=
 =?utf-8?B?RnFpV01iMjBoWExUc1hUdWdubVBqVUlibG9iVzgyRVIwejQ1d25CR1dzTGhT?=
 =?utf-8?B?MW1sdzk1UnFkWUNqV3RFaWpyd0R2RWZlSUJxa2xHOVdKV0tyNkRJRlN5dHZo?=
 =?utf-8?B?UXUrK3FidWg4djUxcThreG9Ib2lBeXNhZnhlSlBVdzJ5V3JldFNSZzBKR01v?=
 =?utf-8?B?YTJHckxhMTZUTlFYelY4NklvV01qWHRicmlHVS83dXE4bjh5bS80S2FoWTdU?=
 =?utf-8?B?dTVPcUVTcXE0eDh2c0IvZ0gzdm1FNkxmbjRpNVgzVklKcldsOUY1RVMxakZH?=
 =?utf-8?B?QmNGT3NobjFqVEkwb3pycjVWK1Z4ZkxidTFSRFlzZmd4em1nN3dtS0ZaYlQ2?=
 =?utf-8?B?RENSQmtsa0JUZTViak9NdWlhbkxVZ3lQa3VWSWVTMHRsSE5ZcHN0YlAyVmly?=
 =?utf-8?B?OGxJL0NmMGVoR1JOV001YVZwZ2tMY0g3ekM5WFlERHd5dlo3UXdEVm5Idkg2?=
 =?utf-8?B?NzkzZk0wOHpXV0lVUDE2QU9RRUszR0JlM2xxckhSUlp6RXYzcDlpa3h2UDYz?=
 =?utf-8?B?M0VuS0pRMVJzSGs3YmFhL3NwZnJmcS9nZjB3V0NXTDh4cnU5bGxmc2Vtc3Z0?=
 =?utf-8?B?SW55QlhSQ1RIWk16bkkzb2FIemR4SnZVWTV4bkxBR0EyYnQ5VmdvaGE3NW1D?=
 =?utf-8?B?SmFMOUt2WHdXM1B0dXZCb1NxTlFHSVNuT3RGN2kyZmF2RTN5dERyTXhZWW5a?=
 =?utf-8?B?L3cxNGRraDJoeXhGbVoxalVnNVNVWFFHOU9lWGk3SHNJdzNmcEFLUzV0M3Jv?=
 =?utf-8?B?ZWhrK2IxdTZDQi9CTUxxajJ6QnY2dG1NQUxuNjdPSU9IRDNvQU9qaXVjQ1cx?=
 =?utf-8?B?L2FpaFN6a3BzMGs5dHI4aWR3c3BKKzBqUlpTNytXWXpacjdBZElKWVJpb09Q?=
 =?utf-8?B?akl6M1ZtYm5CQ1o4eW1aa2lGU3lHbzNzdENjc1p3OUxWVDQzbTBVaStMNmRG?=
 =?utf-8?B?eFBNUGlFN3ZpR2VuaXNXUit2cjUweVp5MkZPUnpnMUtnTno3TnRLangrYnFt?=
 =?utf-8?B?OCtEUXh6MEhtUTh0bmEvRTVTOS9VRnRqMHVuaUUzM2dKNHhiWTRqVDVGRVhn?=
 =?utf-8?B?SWthZnMxU3NIa1E5b2xWNDJzMGVTL2xuNGFLeFE2UlJCVGE5bTljTFdkSHNa?=
 =?utf-8?B?UDBSczZJcXV3SEttUkNpbXlXU3J3WHAxcndkS1Ezb3ErbGd2Nzh3V0RhQWtl?=
 =?utf-8?B?WE93cDk2N0Z2QStveDViNks5T2F0YXNvQ3VvVFNETFZyN1c0RDVYK1ZxZE5h?=
 =?utf-8?B?SWlNaTFxR2ZqMEJsK3c2bS94NldXQ1lTSFdDclJwT0RER2xUUVFtMXd0d29V?=
 =?utf-8?B?Z1JmRmNFcElObDljK0QxMmUvWlRyK3pyYkROWUlnQk5jV295OVZmeVVFVGJX?=
 =?utf-8?B?Ykt5V2dJeGVaRVY0eXpINkRMTktPMkRhZ1ppOGNqQXhRVmM3VmpaWjlqTWhr?=
 =?utf-8?B?NXpyVWNERGRNWFNPM3NVRHFtSWJ6dGFHMU85Y1BxbzBObEdrVld2czRXYyts?=
 =?utf-8?B?TXpFRkZMWEZ3aWFQRWZaT09xTWI5TXZMMWZ1RXR6Q0lOdHU1M0psOTFjQ1dK?=
 =?utf-8?B?NHUwMW5aZHhqS21kN0toYWhsei9WVVBFL1BtSDRyWlhzWTBHZzc2RDFwYVgw?=
 =?utf-8?B?ZHJkdnE2eFJvUVVXeHMxdlY1a3VaVEU1ODk0YjlmNk9lTW51elo0OUkxVjNE?=
 =?utf-8?B?K3QzTTNVTEpLdGxzZC9ZUXRJTGt2OEUycEgxS05GV21WelNJOWRvM2NyelRp?=
 =?utf-8?B?NTE2RU5nVnRWTzNacXNNNkFVaUVkcGp6Rlp4S1h3NDhFRTRqbjZ3UjA4MUVs?=
 =?utf-8?B?cUxyRS9aUElubnZ4NVNRR2hZOUZtaWZNYnN6MVoxVlVqRUpXYml2MS9JV003?=
 =?utf-8?Q?5OLlvfOfVX6sunsk5UyxJZ08gJjn0vMd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VStQWmxLL016ejdkdGc3M21HWlJISDZid2F3Y3B2SDR1QTRuV2s4OGU0S1ZF?=
 =?utf-8?B?Q2lTWEpyak1iUzIyZmszcm0wQkVZVnY0Zko3K3JNMlhQSzJRdHU5YnUydGNZ?=
 =?utf-8?B?cWhjVEdPL2xaV3VQVk8wTkZkNS96dDdGUlBnWHlUZDFxaERoSS8zTnVnSjBK?=
 =?utf-8?B?SWJ3SlcrUWxVS2JaQzJjVWVTYXhOSTVOMkxMOXNmWkVJUmczeWJGeTFrSi93?=
 =?utf-8?B?dGhlcFdzTmVDdUFsRlRoMmFaMFFRRkkxRmpzOHBXS3U3cXVRVTY5cnZTU1JX?=
 =?utf-8?B?VTRQMTFvcE8va2FvNGd2ZWRhVzVHREVhZHoxMVFtME5oS09YWE05ZzhDUUIw?=
 =?utf-8?B?c3gzWm1IYWVkR0w0dE5YZ1dHSHM0Y3BmS1QvT1U1cE5UWER6QUJCUE55NHEw?=
 =?utf-8?B?d0JyNGFhOFE1N3ZjQXh2Z1hxZU84a3Z2UlowVDhqM2Vwc24vUzdmRU9raEFV?=
 =?utf-8?B?VjRheHphMVNYVDF3NDFnNWlZWmdJbG9zVFcwLzNDc3ZLdGZmRnJlRXAxcm1a?=
 =?utf-8?B?YmlpbkxmWUpKOXJ0SW1SMTZ1SVRZTmsvOEZKRUN3ZkZWSVZoQjdhVno1MXV4?=
 =?utf-8?B?U3VmOU1NWHpIdlRsN0EwN05nM0dESXQzelZwM3BGWm1JWHBNSmpNQVZJcklr?=
 =?utf-8?B?b29tdGQ0TkdwT1ZNeDdhb3FDaTBsM1FVNEJGWGRBZHUrS1JLSjM1QXRxb2Fm?=
 =?utf-8?B?Q2xZNm91OEkyRHZJNCttMGtCdmpjdW1PWEpRZWpBNkV1d1dXeUFJNC81K2lI?=
 =?utf-8?B?dXl0MlV0bEFGUExTbW1COU5YY0pqK2Ywb1lzT1ZXNnpZNVYzQ1YrYUhwWC9n?=
 =?utf-8?B?Mzd6c2d1QnNRcE5nelFUVUtMSkFSQWF6L0VFYitLUWs0c2pKdm50R0tRNEx2?=
 =?utf-8?B?QXFrc24yQW5YN0FEVUlONUxIUEJWejlkaVB1YSt4c1pma3lITEZiejdSQVBn?=
 =?utf-8?B?ODFKUG5xUVBmY1Q4WU1JY1dRNWh5cXhMVFMxWFRTZFhOZmJjdksxQTVDUEJm?=
 =?utf-8?B?YXJoNmYvZVQxNmFlVEN6MlhrT2cvWVRJNHJCcWlMeklTNFN5M3RqaXMxLzFt?=
 =?utf-8?B?RUxQYlozY0JYaC96bHBJYkR3TVV6WjNVWmcvMEFSNW9JVnVMOWR6elNGSEtC?=
 =?utf-8?B?TWI2SHdYeFN5ZC9CTU83RDVqRkREUUFqdzdjSXF0WnBwc2VXekNSYnk5QWpl?=
 =?utf-8?B?L1hyTmJLMGFzWG10VE9pblVJWmtyWTJtZXpZRkRXTkdlUU1neU90SWorTDAx?=
 =?utf-8?B?MmgrVHYxUERma0lUKzZEMC9vUHFiMGV2ZStJUFlTa0pyeWZJL25hNkpyNlM2?=
 =?utf-8?B?dnRxTitxR1Nra3Q1SWwrZW1oYy8za1h6bVJUKy9rNzdMdk5lcjMwdlFvR3BN?=
 =?utf-8?B?S3FRNkRmbjVicWNraStaVXBMWXhHRnV1VHlSYjFnZEVDWUdWUDl5NmI0Zk9m?=
 =?utf-8?B?Wk5jelM0VEZ2VEpVbEo2OUw4azloc2xFa1ZMeDVaUlVDeUZERldpWHZoUXV3?=
 =?utf-8?B?TFVzWVpzdkR2NUQ0N3MyYkNBcSt6VTh0MXV3NXJhZFN1S1M2SVN1MWxlVE5L?=
 =?utf-8?B?WFcyRm1QZjB4WWo5WjV6eWc5cnF3eHExczBodEFDNkZGKzAwSENDVjE0Mk5p?=
 =?utf-8?B?Y0NhTDFjR1JIYmJ2U3hSZXV5WTNodUdYRXQ5U3VPQmtqMURPOGNLb1A0VGNy?=
 =?utf-8?B?QzJ0YmtZVnBPMXh5MVR0Wk1ndzE0RlZhSDZNYnBCR040YmJrZm1FRnEyQklB?=
 =?utf-8?B?Z3BXelc1TDBQUlA1KzJuc09Qa3RsanJZaEVjUzFxc2VoWFUyWmZsQnJOMkFz?=
 =?utf-8?B?cHJnaWZTaWZlSUtzdzFqcjkzT0pGcXlIZXJNcW9wNGlIaVRlMnpjVFlQOUlB?=
 =?utf-8?B?ZDhiOStZSmFieUFzYWUwTTZFb0IwNG5XV1hGNU84c1FMSnRtSmxiWEFZT1BD?=
 =?utf-8?B?TlVtYVY0WXIycExWQ2lObnYvUmR1YlZJMGdJWEZvS2lNTDVZOGd3a3Z1VDBk?=
 =?utf-8?B?amJQZ3JlTnN4VmFWRWZCOXpOV09Sc2VxL1NHUkt6MkpER1dWUi9McTg4K1Nj?=
 =?utf-8?B?djJOTFpvaXRkOXFJQllsSHJjWVdRajN5Zi9xaEpNWDgray82RXp5MU41VjRa?=
 =?utf-8?Q?riis=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa794d68-fc21-420f-a645-08dd475ed9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 10:04:46.2026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEqsr2PmkKO65EcwLYMBr+s40soySasMSANXiWQJRkUP0e/om8HCu9JoCJ0wj5JG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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
Cg0KdHlwbzoNCmFtZGdwdV9kZXZpY2Vfd2JfcHV0KCkgLT4gYW1kZ3B1X2RldmljZV93Yl9mcmVl
KCkNCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBC
ZWhhbGYgT2YgV2FuZywgWWFuZyhLZXZpbikNClNlbnQ6IEZyaWRheSwgRmVicnVhcnkgNywgMjAy
NSAxNzoyNg0KVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1A
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNB
Ti5TSEFOTVVHQU1AYW1kLmNvbT47IGNhbywgbGluIDxsaW4uY2FvQGFtZC5jb20+OyBDaGVuLCBK
aW5nV2VuIChXYXluZSkgPEppbmdXZW4uQ2hlbjJAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hh
b3l1bi5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHUvbWVzOiBB
ZGQgY2xlYW5lciBzaGFkZXIgZmVuY2UgYWRkcmVzcyBoYW5kbGluZyBpbiBNRVMgZm9yIEdGWDEx
DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9u
IE9ubHldDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgU3Jpbml2YXNh
biBTaGFubXVnYW0NClNlbnQ6IEZyaWRheSwgRmVicnVhcnkgNywgMjAyNSAxNzoxNg0KVG86IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1A
YW1kLmNvbT47IGNhbywgbGluIDxsaW4uY2FvQGFtZC5jb20+OyBDaGVuLCBKaW5nV2VuIChXYXlu
ZSkgPEppbmdXZW4uQ2hlbjJAYW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1k
LmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS9tZXM6IEFkZCBjbGVhbmVyIHNoYWRl
ciBmZW5jZSBhZGRyZXNzIGhhbmRsaW5nIGluIE1FUyBmb3IgR0ZYMTENCg0KVGhpcyBjb21taXQg
aW50cm9kdWNlcyBlbmhhbmNlbWVudHMgdG8gdGhlIGhhbmRsaW5nIG9mIHRoZSBjbGVhbmVyIHNo
YWRlciBmZW5jZSBpbiB0aGUgQU1ER1BVIE1FUyBkcml2ZXI6DQoNCi0gVGhlIE1FUyAoTWljcm9j
b2RlIEV4ZWN1dGlvbiBTY2hlZHVsZXIpIG5vdyBzZW5kcyBhIFBNNCBwYWNrZXQgdG8gdGhlDQog
IEtJUSAoS2VybmVsIEludGVyZmFjZSBRdWV1ZSkgdG8gcmVxdWVzdCB0aGUgY2xlYW5lciBzaGFk
ZXIsIGVuc3VyaW5nDQogIHRoYXQgcmVxdWVzdHMgYXJlIGhhbmRsZWQgaW4gYSBjb250cm9sbGVk
IG1hbm5lciBhbmQgYXZvaWRpbmcgdGhlDQogIHJhY2UgY29uZGl0aW9ucy4NCi0gVGhlIENQIChD
b21wdXRlIFByb2Nlc3NvcikgZmlybXdhcmUgaGFzIGJlZW4gdXBkYXRlZCB0byB1c2UgYSBwcml2
YXRlDQogIGJ1cyBmb3IgYWNjZXNzaW5nIHNwZWNpZmljIHJlZ2lzdGVycywgYXZvaWRpbmcgdW5u
ZWNlc3Nhcnkgb3BlcmF0aW9ucw0KICB0aGF0IGNvdWxkIGxlYWQgdG8gaXNzdWVzIGluIFZGIChW
aXJ0dWFsIEZ1bmN0aW9uKSBtb2RlLg0KLSBUaGUgY2xlYW5lciBzaGFkZXIgZmVuY2UgbWVtb3J5
IGFkZHJlc3MgaXMgbm93IHNldCBjb3JyZWN0bHkgaW4gdGhlDQogIGBtZXNfc2V0X2h3X3Jlc19w
a3RgIHN0cnVjdHVyZSwgYWxsb3dpbmcgZm9yIHByb3BlciBzeW5jaHJvbml6YXRpb24gb2YNCiAg
dGhlIGNsZWFuZXIgc2hhZGVyIGV4ZWN1dGlvbi4gVGhpcyBpcyBkb25lIGJ5IGNhbGN1bGF0aW5n
IHRoZSBhZGRyZXNzDQogIHVzaW5nIHRoZSB3cml0ZS1iYWNrIG1lbW9yeSBiYXNlIGFkZHJlc3Mg
YW5kIHRoZSBjbGVhbmVyIGZlbmNlIG9mZnNldC4NCg0KLSAqKk1lbW9yeSBPZmZzZXQgUmV0cmll
dmFsKio6IFRoZSBsaW5lIGByZXQgPQ0KICBhbWRncHVfZGV2aWNlX3diX2dldChhZGV2LCAmY2xl
YW5lcl9mZW5jZV9vZmZzZXQpO2AgcmV0cmlldmVzIHRoZQ0KICBvZmZzZXQgZm9yIHRoZSBjbGVh
bmVyIHNoYWRlciBmZW5jZSBmcm9tIHRoZSB3cml0ZS1iYWNrIChXQikgbWVtb3J5Lg0KICBUaGlz
IGlzIGltcG9ydGFudCBmb3IgZW5zdXJpbmcgdGhhdCB0aGUgY2xlYW5lciBzaGFkZXIgY2FuIHN5
bmNocm9uaXplDQogIGl0cyBleGVjdXRpb24gcHJvcGVybHksIGFzIHRoZSBvZmZzZXQgaXMgbmVj
ZXNzYXJ5IHRvIGNhbGN1bGF0ZSB0aGUNCiAgZXhhY3QgbWVtb3J5IGFkZHJlc3Mgd2hlcmUgdGhl
IGZlbmNlIHdpbGwgYmUgbG9jYXRlZC4NCg0KLSAqKlNldHRpbmcgQ2xlYW5lciBTaGFkZXIgRmVu
Y2UgQWRkcmVzcyoqOiBUaGUgbGluZQ0KICBgbWVzX3NldF9od19yZXNfcGt0LmNsZWFuZXJfc2hh
ZGVyX2ZlbmNlX21jX2FkZHIgPSBhZGV2LT53Yi5ncHVfYWRkciArDQogIChjbGVhbmVyX2ZlbmNl
X29mZnNldCAqIDQpO2Agc2V0cyB0aGUgbWVtb3J5IGFkZHJlc3MgZm9yIHRoZSBjbGVhbmVyDQog
IHNoYWRlciBmZW5jZSBpbiB0aGUgYG1lc19zZXRfaHdfcmVzX3BrdGAgc3RydWN0dXJlLiBUaGlz
IGFkZHJlc3MgaXMNCiAgY2FsY3VsYXRlZCBieSBhZGRpbmcgdGhlIGJhc2UgR1BVIGFkZHJlc3Mg
b2YgdGhlIHdyaXRlLWJhY2sgbWVtb3J5IHRvDQogIHRoZSBjYWxjdWxhdGVkIG9mZnNldC4gQnkg
c2V0dGluZyB0aGlzIGFkZHJlc3MsIHRoZSBNRVMgKE1pY3JvY29kZQ0KICBFeGVjdXRpb24gU2No
ZWR1bGVyKSBrbm93cyB3aGVyZSB0byBjaGVjayBmb3Igc3luY2hyb25pemF0aW9uIHJlbGF0ZWQN
CiAgdG8gdGhlIGNsZWFuZXIgc2hhZGVyLCBlbnN1cmluZyB0aGF0IGl0IG9wZXJhdGVzIGNvcnJl
Y3RseSBhbmQgdGhhdA0KICB0aGUgR1BVIGlzIGluIGEgc3RhYmxlIHN0YXRlIGJlZm9yZSBleGVj
dXRpbmcgbmV3IHRhc2tzLg0KDQpDYzogbGluIGNhbyA8bGluLmNhb0BhbWQuY29tPg0KQ2M6IEpp
bmd3ZW4gQ2hlbiA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQpTdWdnZXN0ZWQtYnk6IFNoYW95dW4gTGl1IDxzaGFveXVuLmxpdUBh
bWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4u
c2hhbm11Z2FtQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
djExXzAuYyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KaW5kZXggYmY1MWYzZGNjMTMwLi5k
OGU5OTJjNGFkZWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
djExXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCkBA
IC03NDUsMTQgKzc0NSwyMCBAQCBzdGF0aWMgaW50IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2Vz
XzEoc3RydWN0IGFtZGdwdV9tZXMgKm1lcykgIHsNCiAgICAgICAgaW50IHNpemUgPSAxMjggKiBQ
QUdFX1NJWkU7DQogICAgICAgIGludCByZXQgPSAwOw0KKyAgICAgICB1MzIgY2xlYW5lcl9mZW5j
ZV9vZmZzZXQ7DQogICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gbWVzLT5hZGV2
Ow0KICAgICAgICB1bmlvbiBNRVNBUElfU0VUX0hXX1JFU09VUkNFU18xIG1lc19zZXRfaHdfcmVz
X3BrdDsNCiAgICAgICAgbWVtc2V0KCZtZXNfc2V0X2h3X3Jlc19wa3QsIDAsIHNpemVvZihtZXNf
c2V0X2h3X3Jlc19wa3QpKTsNCg0KKyAgICAgICByZXQgPSBhbWRncHVfZGV2aWNlX3diX2dldChh
ZGV2LCAmY2xlYW5lcl9mZW5jZV9vZmZzZXQpOw0KKyAgICAgICBpZiAocmV0KQ0KKyAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQogICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5oZWFkZXIudHlw
ZSA9IE1FU19BUElfVFlQRV9TQ0hFRFVMRVI7DQogICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5o
ZWFkZXIub3Bjb2RlID0gTUVTX1NDSF9BUElfU0VUX0hXX1JTUkNfMTsNCiAgICAgICAgbWVzX3Nl
dF9od19yZXNfcGt0LmhlYWRlci5kd3NpemUgPSBBUElfRlJBTUVfU0laRV9JTl9EV09SRFM7DQog
ICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5lbmFibGVfbWVzX2luZm9fY3R4ID0gMTsNCisgICAg
ICAgbWVzX3NldF9od19yZXNfcGt0LmNsZWFuZXJfc2hhZGVyX2ZlbmNlX21jX2FkZHIgPSBhZGV2
LT53Yi5ncHVfYWRkciArDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKGNsZWFuZXJfZmVuY2Vfb2Zmc2V0ICogNCk7DQpba2V2aW5dOg0K
VGhlIG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzXzEoKSBmdW5jdGlvbiB3aWxsIGJlIGNhbGxl
ZCBkdXJpbmcgZHJpdmVyIHN1c3BlbmQvcmVzdW1lIHN0YWdlOiBtZXNfdjExXzBfcmVzdW1lKCkg
LT4gbWVzX3YxMV8wX2h3X2luaXQoKSAtPiBtZXNfdjExXzBfc2V0X2h3X3Jlc291cmNlc18xKCku
DQpJbiBhYm92ZSBjYXNlLCB0aGUgY29kZSBzZWVtcyBpbnRyb2R1Y2UgYSBuZXcgbWVtb3J5IGxl
YWsgaXNzdWUgd2hlbiBjYWxsIGZ1bmN0aW9uIGFtZGdwdV9kZXZpY2Vfd2JfZ2V0KCksIGFuZCBu
byBwbGFjZSB0byBjYWxsIGZ1bmN0aW9uIGFtZGdwdV9kZXZpY2Vfd2JfcHV0KCkgdG8gcmVsZWFz
ZSBpdC4NClBsZWFzZSBkb3VibGUgY2hlY2suDQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCg0K
ICAgICAgICByZXQgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBzaXplLCBQQUdFX1NJ
WkUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX1ZS
QU0sDQotLQ0KMi4zNC4xDQoNCg==
