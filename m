Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E75C98315
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 01:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D0E10E30C;
	Mon, 19 Jan 2026 01:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pjAdimJL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5632710E30C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaHdFjE2iIG8t7wIN/GTg9qsW6ZbOt+j5uGvSR0PpVXauhC3gWYUORsiVcRzMMpszeISvFsrV7KW3oNdTb/CwWhIONKW9gGl7ScHWZx0WE7b2XDCVsbBbZg4zWLA0uv5uZUD/PHZITM5s/DT0BZ+JHbV/QGiOUc3vdTiAYnMpZAk++n6CRGtVZX4esxreJqIhcictAtOFLC19sG5hUJQPWeClhT7VCt0/QaJ1BVwHnV0bIg72DZddT1AffOBLQlN4aerX1N9KvcMRMaNqRi21fFzAvFwlUdA5Ujhw+VKLM2EiKKPWHdoQjxwp4PA8aFREm5KmqIqLtSxLDo73/UXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnlEfzk7Ai7GNdE5PT9Ny4YUOL66y5GY0Rsc7ILAfmQ=;
 b=DuhwYFw7zH9kd5TJZTKxcFRYTU7yJgtALK7FXHtAuYwhlkhXHVD0jO4LYA9dpiYLW4wqBkIxO42Nxf0CiU2oFonZY4peME0uzFRlj0GXsf7Ftv6C2cinRG//14wJaCO0oXsbd+CzV7w8LVINoeJ26QriVPS3bB44dKUGG1dRZdQUMNa4xWoqqR4R94R0XYITqfgWbIYjYUteuWrfxz60zwUUvtGgkdyvvh0Oen2fV+oJgVKqjAS9PeOEW0tojqpkT6ZLBN7JI6PLZprfd8Kxih46Cj0Lh8J5w8URBgD4OMQE4VB4PVR5phDoG66xR7NNS6oVX6NLqZ1LUA69bR5t3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnlEfzk7Ai7GNdE5PT9Ny4YUOL66y5GY0Rsc7ILAfmQ=;
 b=pjAdimJLKjxElmCnv2ebuCIYLJiCEo0A0vUj5yhyj4ir9weDD7jzMf28NB78e3UI8QUwWIMQaZ2uvD5lsxxtcI0E2bzKyimzXW8oIuX7CaUL0gy5PlUydmzV0J4cBifdCoRPYyz1Cycf9ZCkVAoOfpIIOj5d8an4VK11D4C3uOs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 01:57:51 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 01:57:51 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Topic: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Index: AQHciHoQTQHvCiULiku9PJWO956CHLVYvGTA
Date: Mon, 19 Jan 2026 01:57:50 +0000
Message-ID: <DS7PR12MB6005F0626EDB392DA9F554E3FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
In-Reply-To: <20260118125746.40221-1-timur.kristof@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T01:55:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS4PR12MB9707:EE_
x-ms-office365-filtering-correlation-id: d5c298cd-98e6-4a95-224a-08de56fe2721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S1M3L3lUV3dqR1kvRmxUNjhsajNQV3BWeXU3YzI0bFBJUkh3TWpnTDMwVzVE?=
 =?utf-8?B?L2hkb3ZUQ0ZaQ01SUTc2WDBLaXZEMkFPSVYwZE0waTJqMmtnYlVnRHJPWmVh?=
 =?utf-8?B?VVBYWmpYT2lMMWoyMEc2VU1FQ1ltZmQwWjI5Zis3VlFtM0xkSFJuK2FBNitw?=
 =?utf-8?B?a1paSFAzQXNDLzZxTHcvTFRncHRYZ3hqZ1FNWG44bHFHeVc2akJGbFlhWS93?=
 =?utf-8?B?OFRIZ3FqSmI4WS9QVjllRlNSTk1zMWMvY3NnTkthc0FaOXhhMWlGU0VocS8y?=
 =?utf-8?B?Q2gyUFo4Nk5CVWtEVi9yK0xSa09qbGNva2VlanFvVXhXVkp0Vk1sVUY4NFc5?=
 =?utf-8?B?YjMvUXlZc1RiY0F1MmhoSjBycjRXUUFGQWtxcElUY3BRY2FyajRGQkRGN0Zj?=
 =?utf-8?B?RmV5TnRLTXlSa3FmcGoyN2orOTVIY2lKV05zZm9tcUk3RkJCYjQ2R29rcERM?=
 =?utf-8?B?ZVB0RjB4SHZuMENvaDR5RXhRZ1Z6RFMvc0FRb3B2dWRrTGNXSll0bHdaTUo0?=
 =?utf-8?B?UVAwbjJlMDRPRm55NDBXSkppeW1vOXAzNkxnMVJOOVdxOWFGN1JwbExtMy8y?=
 =?utf-8?B?b3BLSUJoODU3ZHZRdFlESVFMN0RNV09UMER5YnM3azhEK0llSE9PNXJnNTZn?=
 =?utf-8?B?MkRDc3E0TDU4VzFVTEszbFlreGdMM1c1M2l3QTZsNVVQTVRRN3BwZ21tL2dE?=
 =?utf-8?B?SFpBM1JDcmVlcGk4cEJORlRwYnBkQlQ3Z0tqcVJhU3EwTzRxWVBGY0lpa0Z0?=
 =?utf-8?B?R016QkVycWdBKzE0VjdSWk1McXhTc2J1QWZYRUdpUnd5d0JJR3pvam9NSHY5?=
 =?utf-8?B?Y21LTlpiOEdBNm03bEIwRC9IVmx6U2RUWlAxTmRWVkREQ2IxcHVObjVCZkJM?=
 =?utf-8?B?MDNmbmdLdVhvWEZ1RmFraWFLZCsrTWJWNmlKVWZsMk1KcW9mTjVQN1ljK3NP?=
 =?utf-8?B?Q1kvYXVtUWFvRzdTWjlLMWMrbE1kTFRxMGJZNjBCdThhWHYyNFFWRS8vUHBo?=
 =?utf-8?B?cHI2VTF3OURRSnJJdEFZcUVjOUNDcHpFRG5yOUpsUEVtalhxTTFnL1VGTnFD?=
 =?utf-8?B?TzNtcWpzQ3ZORFh4OGoySUhFODVoZjlqQjNLSzByUEVWbzFPVUJublU1RXla?=
 =?utf-8?B?dEcvTnVPQnRyblA5SlZKbzF6UDRadVB4MFUzb3Zzazk5TENQWWQyS01vQitR?=
 =?utf-8?B?UWR5eUFTUTF3RW1tbTRWT0R6SkZKTlFrU3NKRW5pLzJ3U2hEOG8rOEVsUzYx?=
 =?utf-8?B?bWJuR0kzODNwNjU4ZFJwMUgzR3o0czdFZTBhTWRMSWdYSjhrZjRLcSsrRjVO?=
 =?utf-8?B?OUVIL2FuN0Y2ajR3Mkgwa3RvOExNSzBxTWtqS0FNTmJBcnFjMkJhMldSZzFY?=
 =?utf-8?B?QVAzMFU3RW16dnpBenlXOHdNTUovdDcxbDRHSmFlRExVVG9sZlNRQ21Nbkpm?=
 =?utf-8?B?RjZUSFJjRTh3YzRyWHlNUzZlME5jcE4zM29Id21RY0pHNVlRVVhhcmN0dXNM?=
 =?utf-8?B?amJLUkFJLzI2VXBndWdPWGRqT2lqeGxRZ3pRMFl6am1yZk8wMzI5dmhCeVRv?=
 =?utf-8?B?NEZ6TXZISU1ZelBxcXlJY0FvYTY5KzM3ZHNSbGFiaGtLL1JhVjQzZFA1UU85?=
 =?utf-8?B?WUdsR2lYSUlBNFVxeFU2K2E0WUE1SmNqczBGZ0M5T2JiV2E4ZzBmNWM4WkZV?=
 =?utf-8?B?aDV4TmYrMEFLU1JUWCszZjRSMTRrOTZGbXNRTkZESFRYYndxZlRPTDljK3lQ?=
 =?utf-8?B?UU1EUmM2V0xiU2xQK0JIYk1hNDNKVUFlRUR6TmRab1NMQy9mYmxSZkoyMGVv?=
 =?utf-8?B?SllmRlorai9vVERnUFRoT0hjcEgyOVEzd0R0eFhVVmJpTkZUYkpRN3NmZzU1?=
 =?utf-8?B?SGNucVQreGVhMW1IS3JIblZDRzdUdXpRcW9XYzA5OEV1aU1mWG9YZkFTaTJ6?=
 =?utf-8?B?YndHYlJFMVRjRGlwRnRYQ01HeTdha1VKSnNXcm1OeGJxbzJCalZONEk5bllz?=
 =?utf-8?B?Q3gwdWJCWDRuZlB5NHBwS21Kak5pUE1BZ2kvUko0TEg3K2lHdnIvdUpmcTRP?=
 =?utf-8?B?bThQVjYrV2tmSUVJZndvNHcxYXVkaGo2bGRJNzlNWUVCWVl5SU0vK2R0NmxW?=
 =?utf-8?B?eVFIdXV3TDU4Wk1FWlVPMEVmekJKT0I1UkxVUGRRQnE5TDV5Vk9CcTFXYzN4?=
 =?utf-8?Q?SB3ciZRScuF7kzlPkAGaiAI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21hRzJOSnRjWHpRZW9seWxiUktwM3BxcFpxY1Q2cDZnbmJFS25SeHhNekhz?=
 =?utf-8?B?K1g1SmZ6Y1VmVUFFMHJlQ1ZhdnZJS2JnQUI3am1ZN1d5UGhRUHlXY2lJYXdy?=
 =?utf-8?B?QytweDZsWWFIN0x0UDQrZGlyY05oS2dBUlZ4dW16ZGJtaXo1b3FSVjIzcjVN?=
 =?utf-8?B?RzNPKzJ1TFdlYkMyQ3NZZ2RnWUQ0cm84VlppZzZ3eDJYYThPZ3NySDlBaFRL?=
 =?utf-8?B?QUV2RDBSaVIzZzJRWmduWnFJVjd5eVlHVW1RSmhFNDBVSFNmcTV4Y1ZhNXJz?=
 =?utf-8?B?THlOMmljOTZjRmJtNEZiUm5GY1FGN3pqcHN3UkRnNGNUUUdUY0RIVUZvQWE3?=
 =?utf-8?B?aEV0MGF2WDJGUVJ1QU50eUI5a05UbXc1V3N2UXFMSVFLY3R1WnprSXpHU2Jm?=
 =?utf-8?B?bVZqRGtFVzJHRVJXWVVmZXBhdExIb1F3SFlTSXFoaTU0cHBWYXdRRlpJeEN6?=
 =?utf-8?B?bVlqR2kzRmRZd2FrYkZ2dTg5bU1TM08yenVxZDIyU1M3cUcrNW1tRVBzbmZm?=
 =?utf-8?B?dW9obUxXa1FhNEthL3RzUVNhRWdSWVZZRkh0YUNJdDYzUWdGNGFxYThoYWg0?=
 =?utf-8?B?UGJvc2VWbjhxNUdYREIxL0RkS1VCTGpVeUNtSTdsWGs1U011T3hDeENQUVVE?=
 =?utf-8?B?K2J1WER5dk05Q1FvZjZBT2ZSZ3BXa2Juek5Mblk5Zy9vVXBkS1ozclduWVYy?=
 =?utf-8?B?M3F0N2F3Y3BLdW9nSVdKUHVXYjN6UHdveU8rcVNnVyt1RlZnc0ZaS252TFBh?=
 =?utf-8?B?ZGN2R0Y5ckUzWU8vUGJGd1lKblQ2ZjAva1gwMFBTQkt0N2pQVjRhT2QxQlVt?=
 =?utf-8?B?SUJOd1lBbE11OHdUQWJ5RWoraXREVUdacVZUZzRobHNQRnhXdHo0MmdidEJu?=
 =?utf-8?B?Tm85N1h3RWR0ZE1OSkpwemVIbEg1SEQ2cWFZcEU3aEJJMVhXVGg4QkxSa0hj?=
 =?utf-8?B?c2JGeHpNMGlBcGp3ejFITERXZVdJNGtpTWd4VGt2end5ZGJDb2lrdzFRcFV0?=
 =?utf-8?B?VUg5M0pCc1VXcjgzV05lRFdFSC9mYURQMTV4RW0vYzhSVVVYZ2wwODk3aTdV?=
 =?utf-8?B?aEljeTZYWmQwNXBCVEdyRE9ycXgwUGJkekVoamZ0NDB1THI1MXNUQzd4WmVV?=
 =?utf-8?B?Q0wwcXQvZDN2ekFoVzF2QW82UktsSTNBWUVVend6c2FXSXJaNnRKNUJqS0ZY?=
 =?utf-8?B?c0t0SzFIQi8rVG5tT3puaEhIY2tMcWQvM084MEhuVktKUlZxNnE1NUJZdW1E?=
 =?utf-8?B?UWdNakpOODNDNUVXZDFKUm8yc2IzTUpxNVZTUjdpK1h3VU5qVlBlMGlJVGlU?=
 =?utf-8?B?RVJzaGROeHppYldzcEVxbWNHbG5pdEFlOWQ2ajhHamNFUDJZQnA1c1ZWRVha?=
 =?utf-8?B?UHRYWkdXbTJOdU5KMklMM0ZuNXdUTlV5SVl0RFgrOUtxTTZ3SHV4R3JFQWZw?=
 =?utf-8?B?a0RZVlJkWjlsU0xUb2dWbFRZMVBWZVhnUEQ5aVA2NE5JejRneldPc3FMdWJ5?=
 =?utf-8?B?a0xPNFZ0c0w2Y3hnODhyamtocEhmQWl4WTFpSkZjbW9reUFlcUM2VHZRT016?=
 =?utf-8?B?a0k1Y2tvM3BSM0xVZ0dmR0V6R0lRT1BZWmswdVY5RU5GQTA4dmdGTmZSS21v?=
 =?utf-8?B?NjA5YUNFRXdyMEg4RjlRcml1cFJHZEN3UEtSZ1piZTc1Tk52WklqZHZxVldF?=
 =?utf-8?B?bC9mazlaVWVIa3M3WHY5SDhVU3g1TzdpUEN6clN2VmdxU2RxTjRLRlp4eUZL?=
 =?utf-8?B?dGJsS3BTcDA1SWl1Sjl5NlVkZjAyWVNaUFI1Q2JLa1Y5UjBXZkJING43NHFz?=
 =?utf-8?B?dHNsaXJyR2IyUVRLNVo4RUo5MlJhVEI2T0ZMaXBlZ1hCR05RQ01YMTJZWTNT?=
 =?utf-8?B?eDlRNm54VzZDRkVuODJkbnhETGp0UWl4NjN0bWg5SlgwRXlxYTd2Um11M3R2?=
 =?utf-8?B?TGZNSWNWRnpqYmFWb3FqQkRDMkY4Y1dEWUlWaERBTE5sYXltdWt5cE9mR3dr?=
 =?utf-8?B?K0xUWHhxem5keFQzOWFRNDhzOE9LZmpjZ0l3eGNhS0ljY3oyV1NYdWVBT1A0?=
 =?utf-8?B?dG5aS0ZqLzRROTlzSU16Tnc4bjZURllQTGluYlhGS0NDRjhHNGMxWUVhcDlH?=
 =?utf-8?B?Z2w0N0ZydDlUQ1E4QVJzQTB1SWFhVE1KYUNxR29lMHhJWUJYbHQ5LzhOcWlj?=
 =?utf-8?B?OTY4aWhaM3JGTmJpZUtZTHArMzExMUQ1SzZFWlc0T245bnQ5NmxLcWgxKzFD?=
 =?utf-8?B?NmErOTNFbDNzZDV1bDZDbWVCc0xrMjJCTWxrMDZOaTJpOWI4TVZlaDl2cWpx?=
 =?utf-8?Q?icxRQO42gvCY9Zk3or?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c298cd-98e6-4a95-224a-08de56fe2721
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 01:57:51.0537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOscfwU7BT78ahuMlphVszlav0h/M0CTVdl1H0FASobg+AQxQ7XO1xqg0snPwTSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707
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

W1B1YmxpY10NCg0KVGhhbmsgeW91IGZvciB0aGUgZml4LiBDb3VsZCB5b3UgcGxlYXNlIGFkZCB0
aGUgZm9sbG93aW5nIHRoZSB0YWdzPw0KDQp8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NCnwgUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAbGluYXJvLm9yZz4NCnwgQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjYwMTE5MDEyMS56OUMwdW1sNS1sa3BAaW50ZWwuY29tLw0KDQpSZXZpZXdlZC1ieTogUHJpa2Ug
TGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRpbXVyIEtyaXN0w7NmIDx0aW11
ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBKYW51YXJ5IDE4LCAyMDI2IDg6
NTggUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsNCj4gTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0Bh
bWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
Pg0KPiBDYzogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiBTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB2YWxpZGF0aW5nIGZsdXNoX2dwdV90bGJfcGFz
aWQoKQ0KPg0KPiBXaGVuIGEgZnVuY3Rpb24gaG9sZHMgYSBsb2NrIGFuZCB3ZSByZXR1cm4gd2l0
aG91dCB1bmxvY2tpbmcgaXQsIGl0IGRlYWRsb2NrcyB0aGUNCj4ga2VybmVsLiBXZSBzaG91bGQg
YWx3YXlzIHVubG9jayBiZWZvcmUgcmV0dXJuaW5nLg0KPg0KPiBUaGlzIGNvbW1pdCBmaXhlcyBz
dXNwZW5kL3Jlc3VtZSBvbiBTSS4NCj4gVGVzdGVkIG9uIHR3byBUYWhpdGkgR1BVczogRmlyZVBy
byBXOTAwMCBhbmQgUjkgMjgwWC4NCj4NCj4gRml4ZXM6IGJjMmRlYTMwMDM4YSAoImRybS9hbWRn
cHU6IHZhbGlkYXRlIHRoZSBmbHVzaF9ncHVfdGxiX3Bhc2lkKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgNSArKy0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiBpbmRleCAwZTY3ZmE0MzM4ZmYuLjRm
YTI0YmUxYmY0NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
Yw0KPiBAQCAtNzY5LDcgKzc2OSw3IEBAIGludCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFz
aWQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLA0KPiAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAmYWRldi0+Z2Z4LmtpcVtpbnN0XS5yaW5nOw0K
PiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFkZXYtPmdmeC5raXFbaW5zdF07DQo+
ICAgICAgIHVuc2lnbmVkIGludCBuZHc7DQo+IC0gICAgIGludCByLCBjbnQgPSAwOw0KPiArICAg
ICBpbnQgciA9IDAsIGNudCA9IDA7DQo+ICAgICAgIHVpbnQzMl90IHNlcTsNCj4NCj4gICAgICAg
LyoNCj4gQEAgLTc4Miw3ICs3ODIsNyBAQCBpbnQgYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bh
c2lkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MTZfdCBwYXNpZCwNCj4gICAg
ICAgaWYgKCFhZGV2LT5nbWMuZmx1c2hfcGFzaWRfdXNlc19raXEgfHwgIXJpbmctPnNjaGVkLnJl
YWR5KSB7DQo+DQo+ICAgICAgICAgICAgICAgaWYgKCFhZGV2LT5nbWMuZ21jX2Z1bmNzLT5mbHVz
aF9ncHVfdGxiX3Bhc2lkKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX3VubG9ja19yZXNldDsNCj4NCj4gICAgICAg
ICAgICAgICBpZiAoYWRldi0+Z21jLmZsdXNoX3RsYl9uZWVkc19leHRyYV90eXBlXzIpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICBhZGV2LT5nbWMuZ21jX2Z1bmNzLT5mbHVzaF9ncHVfdGxiX3Bh
c2lkKGFkZXYsIHBhc2lkLA0KPiBAQCAtNzk3LDcgKzc5Nyw2IEBAIGludCBhbWRncHVfZ21jX2Zs
dXNoX2dwdV90bGJfcGFzaWQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90
IHBhc2lkLA0KPiAgICAgICAgICAgICAgIGFkZXYtPmdtYy5nbWNfZnVuY3MtPmZsdXNoX2dwdV90
bGJfcGFzaWQoYWRldiwgcGFzaWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmbHVzaF90eXBlLCBhbGxfaHViLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5zdCk7DQo+IC0g
ICAgICAgICAgICAgciA9IDA7DQo+ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgLyog
MiBkd29yZHMgZmx1c2ggKyA4IGR3b3JkcyBmZW5jZSAqLw0KPiAgICAgICAgICAgICAgIG5kdyA9
IGtpcS0+cG1mLT5pbnZhbGlkYXRlX3RsYnNfc2l6ZSArIDg7DQo+IC0tDQo+IDIuNTIuMA0KDQo=
