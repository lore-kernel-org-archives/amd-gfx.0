Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F54E95372
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 10:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CC510E14D;
	Wed,  4 Feb 2026 10:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vks1pv0p";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2761410E14D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 10:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ4L+sFoqhbdEWimguWq8LIzM6phCjd3JTibI9hi+y9eZX/GD7wHS+NexMLFwQUQrVVtZ2U0lY7ALG6VhMoL4o0DUAH6ASY9F0czFuTFTniT2DfaNF0BlDDCvyzDiZcbsurfl0IoMoBxQUL6WFXSJPHgQHAl79tepsrblqSy7fIzQ4I2VZj2jDcPJ1OQoVJfIaxiLIgg3dJnQHRA59Am3N4YucIVHMTBe/FkrnUQceHKtdZXCQOirbMD0j0BMMpTrpk4C+SDB7/MMjxEkjDibJf9So12XnNYXzJVAFGr2hD4kwAU/CZsyAY8WFnCTBPOblaJKrR5jkFLE/Tnks7Iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1HKuHpJxhjFhmZK204/He0Z8lZRf8QzRgh9SJqTraE=;
 b=wqaMUU0fd4xnqq85bvk8OZdd6q/5YwUWB2wGFTGqOXOE4Iw3fo4MQLteWJXLpSgDxKykWC29yWytqnjtUephw6ndyLAEg83R6D+4DcEcE24CrHxst8N/4Lcni4qTAWg9Pb6ZViTiH2cLqyDlEJ9C1XEHrA7RCCrN4QZRRvJxzxFpMFAqS4w6dDe3NG6YGBsqbI6tGq90pC2WL8zm6stnQAHEUbrA5tCqHwohnvY5ZfOg6giKUK7kN1Z0WfhWF1uWghLWsE7mKoZwH1AWJAKnuPZjsIL+nqbCpMjSzPBQ8z4X2qihwIs5yF+ny0hOqK7+9Jsb5LZKfFC2GwldoQyETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1HKuHpJxhjFhmZK204/He0Z8lZRf8QzRgh9SJqTraE=;
 b=vks1pv0pMTo5Qaf1SL2+4pyQospagwSl8KU/9vnppNFnx+dA4A3HcDB8p+6ReLeWelUDumMKOl5fl5pUWUc8ro2Mg9NQXaxbEwj2iTR60J1P8HRKcK3rFIazjbQzgYDe0m4Q7nWoiW+txezykoO3mCxeHAUKd+5KCR0v7wQmMFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:20:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 10:20:47 +0000
Message-ID: <6b1528bb-49ed-4363-bcd6-d7eb929b71b5@amd.com>
Date: Wed, 4 Feb 2026 15:50:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260204082547.3799740-1-asad.kamal@amd.com>
 <13ffc589-243b-41f6-b219-9136fbcaf09d@amd.com>
 <PH7PR12MB59970022C8B598A0111B4F478298A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <d9bf1860-36b8-40cd-a3d4-82a699ef9b60@amd.com>
Content-Language: en-US
In-Reply-To: <d9bf1860-36b8-40cd-a3d4-82a699ef9b60@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cef6fbd-66f8-4682-c608-08de63d70ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUlBUFJzdHJJdzRDQ1JOd2ExZlE2YWI0eVZ3Q3RZRDk5ekQ1YzBMK3JDUGtk?=
 =?utf-8?B?NFhOZm8zK1pVZVdSbHNXenRpbWQwUUpQNDkxWERHOTVsZTN2NFBqZndiNE5V?=
 =?utf-8?B?Sm5BVmFLYnZkTGZ5dlcvZ0wvWVVXWDhZMFozclZQcjdEQ2VNWlFsVHB2Vnpu?=
 =?utf-8?B?TmN5NmE5eU9BZk5UM0k2U2grSWhxR0djU2tVQmJWeUZ2cXFKK0xBTSsveVdB?=
 =?utf-8?B?aDZzaHpodGhmc2NEQ0dwR29pTE43aTdmUDdaYlZBem5GMVE0WGxuSFV0cHE2?=
 =?utf-8?B?c1dCRTJJRS9zYThySDhnazBkenJaeU1PdXRIcTRITFVvNFoybVMyOVlmYkNo?=
 =?utf-8?B?c2thZ2o3aGJUTFBjYW5LOGhkK0V0NElXK2FXL1hQeHFvT3E1UDY0S20zWXRs?=
 =?utf-8?B?Nm1EVEFhM0VvS0xWWVR0eEd6eWZLL2h0dnlRc1lDa3UrWmZYUHN3SUNTcVNK?=
 =?utf-8?B?QzlSazV6U01QREowM0FEc1hOVFF6K0QxNHBIS3BvQTgyQm42L1RBd2Fod0NE?=
 =?utf-8?B?MTNKcTJ5VzVBQXVpSi9xblpCVCtHcnV4V1JKbS9NK3hZZUxrRUNMSDA0OFM1?=
 =?utf-8?B?Q3N0Q0JZcnAvMzFJZk9INjZQRVhIU0NNU0k4NHNnTE44RmcwK0djcHFEdDhU?=
 =?utf-8?B?M3pWNXBKS0twb1JaRER3VXB4OHUzb0R3d0NweFBVZElLYVF6MEF3KzB2YlA4?=
 =?utf-8?B?NU5pWnNEc1NrYmtIdWdxdmJYL0tqK2ZpUTRMb3RUeFlpOG4xbkU5R0M4U09S?=
 =?utf-8?B?Kzh2dk4xNXNsTnFTYUZtVjMyVDhJOXUxWm5HT1hBb1lOcUdjckJMekEwam5w?=
 =?utf-8?B?WnFhRWpLenpZUit1L2haRVVIbDQ2clp4SVdlT0I2alVuVmJiN2twUEhDUEpK?=
 =?utf-8?B?YXFUcllLZDNUblJocGIrRUZoU0RjeG5TOTA4Q2lhZlY5SFdNbzVCTFBFVzhZ?=
 =?utf-8?B?K0xQdC9mN2tkOVkxN01nbkhjZi9PeUhHaWxSMll5ZGFFb0lyUFVERGE5L3o2?=
 =?utf-8?B?UGsrUncyMjg1WW9EaHJFL05sR0ZFR2gwU1NVYlhWUmNmWk9CUzdVd3UyVXJG?=
 =?utf-8?B?TTREM011UmVwTy9mb1RCVnA3NlBSaHJpdUkvcjl5Uno2UXVjVlAyQkkwZWM0?=
 =?utf-8?B?WEw1WitsT2JCSEtkTmJKd0diOHYvQityN2V1ZWdrdXlmQ0V3cFRyeWZUMTBW?=
 =?utf-8?B?K0txU0h0RTRhNm05OGhaUFR0YUJSSUNOckRMcURTMTlIMTRpQzJLdzVGS0hz?=
 =?utf-8?B?STNYRVNRcFlOTjZRZDBFdHhodlFoTzJCbmQ4SzFmL0VqWjhIcTVyTU15ZDV3?=
 =?utf-8?B?cHM4TnZKdS9CU1djUjM3RGtnaU1XNktYN2sxaDNGbFFXbW5RNGhqZURHbFVN?=
 =?utf-8?B?dmhtOTBOWnZFcGNCSEs5MkppeWQvSE5BSTFUTmY2dDkwZnRuM21rWk9jb0xL?=
 =?utf-8?B?RWYrbDQ3b2RrcnNwRzYxV21IbTNDakFJMzF2RW1ubW9yVzRRTElYaU4xVi91?=
 =?utf-8?B?QmNRK1NTanlXb29zQ082TUI0VzlHaU90ekFhdWpvbXNPQWpnbEVKK1lhdjFV?=
 =?utf-8?B?Y2lGZEFRQWNnd2hBdWs4TlQrR3A2d0ZPVmFJVVhEdHlVTktvY0l4ZmIzVlZE?=
 =?utf-8?B?amYyMU04dDRaTFVFdWJFOXdWLzYzM2kzQmlPUGxDc1JRbGNHRzZKQ2l3YnZp?=
 =?utf-8?B?Yk0wbG16eFlXSTd0Ykt6TTBKWFR0aE9nQVdCS2VLU1NKSHJ2bi9rOXl2MzBC?=
 =?utf-8?B?ZVBZOWFxbTJkZUt6ekhwREhEWHRpWTVFcVNCTGhwSHNOaGMrMDJzSk1ycXZJ?=
 =?utf-8?B?YkpZUTA5cmVRMktZS0Z4am5tbVJqRXlaU0R6d3ArdE5QQlhML0xGMXFJVjhI?=
 =?utf-8?B?eTN0dUN4V0RZMU5EY204NDJxcTBid2VIT0xZZG83VTNvU2ZqMEE4aWovT1ps?=
 =?utf-8?B?cHh2VUlqSDRabUcyQml6MGNDZ0ljdE82RGxjajQxbWZzM2NaL3p2UmgzMVh4?=
 =?utf-8?B?WVNQNkx4ZVZGSkNockt4V3Q5ZjlJdjZmeTVyVCtRVXArOE9VeGxOOG9XMEJE?=
 =?utf-8?B?OHo4LzZNN00yQjByWFdpMkg3TFBSR2lFZTV0UU4yelNwUW80am9VTHM0ZHB3?=
 =?utf-8?Q?bucQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJKd0s2MEU3eEZBNytiQ3VrRVRtTDZUVEVxUHpmdjhjdjI0a1ZtRzFHMDA1?=
 =?utf-8?B?VVRuaWt0VWlYOStQTFhTSzRhQi9VaG9QMG1UeG9paGVRaFNOSERuNHB0ak9T?=
 =?utf-8?B?NlVadStNQWlNUWx6a2lLMWVDd295bXhWYlZFRHNnaVpkcWJ3ZzFxMERaMDJG?=
 =?utf-8?B?UG85ZXFHNTB4WkY5empTNlUyY1FCdFpDcEY1M1U1WG13NEN2Z2tQL3BNNDc2?=
 =?utf-8?B?UENETThyei9ka0svam1EVFZ5SXlKemxtMi84UHVEc2lRVXF3d2RHVENkV0xU?=
 =?utf-8?B?SlFOSG5Wdzd2d1Fqc1oxRDRpVkV6OU14K0dDMEpoNFRJdjFla3hRVnNqVmFI?=
 =?utf-8?B?alVWWEZRcWtLY3lKaUVFUHp3VlhWclRhZmpOcHRzZnpXWU1YUFFFVmRTT1U0?=
 =?utf-8?B?VEV4Z29jZHBzOUp0MnBXVUx4TkhKK0xURjc4NUh2UzJnVGU0b3oxNmdzaTc0?=
 =?utf-8?B?YTExT1ZMSUU3N0thS0VaT1IvOVRLaGdQTUkyTFdLMjJFUWlxdHpPdlFqQmN4?=
 =?utf-8?B?Vk0vK1ZLZm1SS0xUMkhtVkhaU0tHZDZkMXFrRFBoYzA4ZkVBS1FVcFArWnpH?=
 =?utf-8?B?U2dnNUFyakRuZGNzM2R3Vzg5NUM2OGlTaEVQNUZCVmYyNWh1cEN4bG9pZzNS?=
 =?utf-8?B?cHFQOUM0OHJWRmRUMkdsSHIrdGVKdlc0enY2ckFRZkI5NFMzZ3ZRR3gwdXNx?=
 =?utf-8?B?MmVhWlZpTUN4RHZLOWJyQTJyOHBMbGp1UHVyTVdrbVhZY2dudW8wRElwZ3k5?=
 =?utf-8?B?UlpQenRTcVpnYkpZbFFDd2lEKy9ueFc3Rzc3Z2VMZVlyMm5yOEJDZWdMNzNR?=
 =?utf-8?B?cGpIVmZYVWNFdmtIdHJ3cjFqQVJaOXMwdzk1U2N3UlBlU2F3SjBnVGhreUVy?=
 =?utf-8?B?c01YM3YxNGNFa0d1czAxWHczblBlUWJGbHRGMkhhOFB5UHpZRDI2T3lOOEkx?=
 =?utf-8?B?NWlab2RRbFo5bWIyVFdQcmNSYlhyTzBpY2Radk5iZzdJS0c5RitPbXcvWWh2?=
 =?utf-8?B?dnhKOVZPSW9Zbkk4WVFwZVdzd2w4MTN2R3BBUkcwYUdwSmV2M3k3SGFLNnlT?=
 =?utf-8?B?Rm5zMlNUZENWRUpObEVDbG9FUTk4N083NENQUFNORmlZSkJ4TUNpb1FNbGo2?=
 =?utf-8?B?T3BCMGg4NEMrbXovZVAzaDFOVnVZZExOZGRDSXRrVmFCb0ZXMVNCTnVtMUFS?=
 =?utf-8?B?WUJ4b0R1d0d6c3pIWitmRFpFZ3ZFZjNKT3QybCswT0Q3ZjRhR280ZldFUzMz?=
 =?utf-8?B?M2Y4UmlEU1lMOWhaR3FXVTJnOGplVjNRSWZoaEFrYnUxNDBxZ3psVFFieUNC?=
 =?utf-8?B?c0RkTzhpY2RyRndZenQvbU82NGpQb0NzVWVVVW1BTVBGWXdnRnRoRTdMbDlu?=
 =?utf-8?B?VFIrTHZZVFNFc05wRkViRTYrNC83cHhmTWVoUURLNk41OWtacFBlYTRoSXRM?=
 =?utf-8?B?TnFGeGo5TGtoamU5NEhMK0xCbktPWnZDV2FKU3VWa2Y5UkxjRURydkxZWmpI?=
 =?utf-8?B?S1dnTko5SWNkUmp6em5tWUJKdWVlQ3Rrb2dnenJKS0dONFhUM0RhV0Z1RjA2?=
 =?utf-8?B?UDN5ODI1UXJrZGpVZEltZEY4TmJ6Rmo2OWQ3NSsyZWZQUDlUMVFwZ0I1eFRW?=
 =?utf-8?B?Vjd2cElWU2pQNlNhYk9DMDhsdW0xTFNGbEdSZ3ZONGh2YmVUUFgvcmgzSTgw?=
 =?utf-8?B?YVdlMEhvTFdGaW45S2lvNHYwcUpOR0lUcW1tRlhPa3k2b2RMeEtUcTNocHN2?=
 =?utf-8?B?V3N5OHphNUhBUmlUVkVuZkJEWW9xVDVlUnYvUlpoemJjUzNFRkxIQ3V6V2M4?=
 =?utf-8?B?ZE4wZlFSTDl0OVVodTIvS1RMcWppOXZkaW81VjFSZmdJdC9MOElYY2R5Vmdj?=
 =?utf-8?B?UWtrbjZBV0J4My9jNTFSWFhtcG5jRG16YzhMWlRzeVhlQmZpVjQ2VTA1bjlv?=
 =?utf-8?B?d3dWUXZ0ZnJjb05BeXZMY2NQcVdRY3BQSUtra29ESG1wRVRDTmdieVU2WU0v?=
 =?utf-8?B?bUk5UHZkZWZxR3ZLTENBajN1T2hSTjBqN0w2Vi9JZzJRaHJvR3l0US95OURK?=
 =?utf-8?B?UUJZZ0JmSGwxVDRnMmYrQ0wwT0tmajgySGlzYTVkTXRrVk9tWnltT1VEK3Rz?=
 =?utf-8?B?OTBITlRPMlZDN05ZNWJkV0lrQjN1T2h3anRlbUpsWXZ5SjJBc1hBMVJ3TmxV?=
 =?utf-8?B?bFE5ZkZsVXp1MVNkUnN0YjJxVnh2Tm95djk5MjFQT2J4c0pWd0FCVldSbVhq?=
 =?utf-8?B?ZExnb0tvK2dhT0RxeHc2d2RweE1ROUdBMCtqNGVTaXNJYk1JWU5peGlXTFNW?=
 =?utf-8?B?OFJ2SUpHa0R2U01EWU5JVlJ6Tmc0V1BEN0hkU08wcnErWUwxbGl4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cef6fbd-66f8-4682-c608-08de63d70ffa
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:20:47.4169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5y/uHGfvE13st5S1TtyHW60lch0n0nyfsy96EDx9Br3ZY2VTZi11jvugGpZa6Lf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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



On 04-Feb-26 3:46 PM, Lazar, Lijo wrote:
> 
> 
> On 04-Feb-26 3:35 PM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> Remove redundant and incorrect multi-vf check for pp clock setting, as
>>> the code path will never be taken. Mask check take care of same.
>>
>> I suspect there might be a misunderstanding of the code logic here. 
>> This is not redundant code.
>> Currently, AMDGPU does not support the multi-vf case, so no sysfs node 
>> will be created for it.
>> However, in one-vf mode, for security reasons, setting frequency 
>> information from the vf side is not allowed.
> 
> /* setting should not be allowed from VF if not in one VF mode */
> 
> This comment is not inline to this.
> 
> The logic before this change "drm/amd/pm: centralize all pp_dpm_xxx 
> attribute nodes update cb") also supported set frequency  in 1VF mode.
> 
> 
> -       /* setting should not be allowed from VF if not in one VF mode */
> -       if (amdgpu_sriov_vf(adev) && (!amdgpu_sriov_is_pp_one_vf(adev) ||
> -               DEVICE_ATTR_IS(pp_dpm_sclk) ||
> -               DEVICE_ATTR_IS(pp_dpm_mclk) ||
> -               DEVICE_ATTR_IS(pp_dpm_socclk) ||
> -               DEVICE_ATTR_IS(pp_dpm_fclk) ||
> -               DEVICE_ATTR_IS(pp_dpm_vclk) ||
> -               DEVICE_ATTR_IS(pp_dpm_vclk1) ||
> -               DEVICE_ATTR_IS(pp_dpm_dclk) ||
> -               DEVICE_ATTR_IS(pp_dpm_dclk1))) {
> -               dev_attr->attr.mode &= ~S_IWUGO;
> -               dev_attr->store = NULL;
> 

Ignore this. It is "(!amdgpu_sriov_is_pp_one_vf(adev) ||". Set is not 
allowed for these clocks in VF mode.

Thanks,
Lijo

> 
> Thanks,
> Lijo
> 
>> Therefore, the .store interface is removed and the node permissions 
>> are configured as read-only.
>> In conclusion, this segment of code serves a clear purpose and is by 
>> no means redundant.
>>
>> Best Regards,
>> Kevin
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, February 4, 2026 5:31 PM
>> To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; 
>> Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> Subject: Re: [PATCH v2] drm/amd/pm: Remove redundant and incorrect 
>> multi-vf check
>>
>>
>>
>> On 04-Feb-26 1:55 PM, Asad Kamal wrote:
>>> Remove redundant and incorrect multi-vf check for pp clock setting, as
>>> the code path will never be taken. Mask check take care of same.
>>>
>>> v2: Update patch title, Remove the check (Kevin)
>>>
>>> Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute
>>> nodes update cb")
>>>
>>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>>
>> You may drop any redundant multivf check in other attr_update calls also.
>>
>> Thanks,
>> Lijo
>>
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ------
>>>    1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index 07641c9413d2..81bef5c5aae9 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -2057,12 +2057,6 @@ static int 
>>> pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>>>                break;
>>>        }
>>>
>>> -     /* setting should not be allowed from VF if not in one VF mode */
>>> -     if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
>>> -             dev_attr->attr.mode &= ~S_IWUGO;
>>> -             dev_attr->store = NULL;
>>> -     }
>>> -
>>>        return 0;
>>>    }
>>>
>>
> 

