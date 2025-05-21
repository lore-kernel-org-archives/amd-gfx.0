Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CFAC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 12:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B52910E7AE;
	Wed, 21 May 2025 12:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQK81S2m";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E2410E78E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 12:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn59iUnheWzLRMfpImx6O1/RILach2pRwemG6jSM9PqzWvMtlp7shau+/XsEPr2fb8vMBk/AP5znQTj+INPyOVOyQA0kL8NlWQsLjUYzKlADXygYy++RAWuH/icU+RC/hfGhCydjKDnt/1J/CJ/WviCEiKfDlo949dDoRibiA+Z2PPObZPUWz6VtgzAmHYIFZ7yD30rKLYOmjVB1mdwLyqqYGoIHr7ZEkHBqWsayyedQsS7JJX1QtO4ytYxCRiAH7Kebj+WC/in+MTfqH+BCnC2KCzYl5mXZ3oDxTJ53MQU9/4EThO2x+D3YQjnf6Sk8KN2fGKgAJ97xZzvRTu2veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7/eLS+4yAClABoDkNUKh75Q5jz3xRQxd98mEjbBatQ=;
 b=DqcIgVlPj+iU+IKQKnIloGsOAYAWNdWHpN/qQFp4e86Y18W7Eiu2Hl4+Wfjr/dgNWUk99PRm+Po3R+Y3DO4Dbejt6JHDKirsLddDgCvdMh1JPTRQdLxXoxt3CGeik2RRwLCQ9pSOXZ/EiI69EUtWNw9QxCEenTd+zEvdv+dr6Q21/bu6MqJPJ/eOS/ZjEkeZcebFi5pQOP13sjWNkzWMOdcRNPlp6Tpb1oQnyfYV0doi12BuLgGLf+Q6hlJrt1hUqJd5llesajwP1MfEb+49LH8a/stR9jKlxEeCamVmnmJXunxTYs8taoZ0FMSdlIXhiZ04yeu8dNG9Wm71RQkAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7/eLS+4yAClABoDkNUKh75Q5jz3xRQxd98mEjbBatQ=;
 b=BQK81S2mIqgZT/e3vXebxKtsPBkyetYcDjVTzr+hME1EmQjASkI0sXXNKLAWS5mkTPzSn4U5H7ytSm+kz6CLhxmvWbt7ScTJVOie9nbVFLLD7T9alqDsW4mTaz3Y9XRryF3r+++QSfaanqZZsl4v3+Y7IKtJJDnGk4JCzBhK3pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 21 May
 2025 12:01:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 12:01:03 +0000
Message-ID: <938e4e19-c594-427c-bc1f-73dda305fc44@amd.com>
Date: Wed, 21 May 2025 14:00:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
 <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
 <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
 <67fc5bc0-e1a7-4074-ab4e-bd7735b60cd1@amd.com>
 <8b2ea507-403c-471a-a3d4-db23f3d2f096@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8b2ea507-403c-471a-a3d4-db23f3d2f096@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc4cac3-0ab7-4ff8-bdae-08dd985f2923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzFKNGthQXdMTWVqSWRseTZrRWdyd1NFci91aTBwa1ZiVjIzdGdoUmhhSHZV?=
 =?utf-8?B?RHpRSkVrWE1HRmUyWWJpT243aHF0Qms5U2lkeG9tUFdyaE5RS2hNclhPYkov?=
 =?utf-8?B?RFlOdjl6bG9IWXZkOUp2MzFnZVg1MHl6TkNvbW1NQmhkM1ZxQUlYZG9OcEZq?=
 =?utf-8?B?TzdCYUhxRFV2c1BLemdMNUFwZzJwemVzTkZvOElBTnFsWmYrZ3ptK3p0blJY?=
 =?utf-8?B?UHZOdzlIYjVDQU5SZ2FoRDNSc2IzWGhkbGRqcVdMNXBVcENuaSs3WHZ0cDVL?=
 =?utf-8?B?dXhHbmJBdEhYb0ZEOFJPdk9iVC94M1BIcHIrbERuTmpjNkRHcW9lejk2Y05h?=
 =?utf-8?B?bkQvcjgzcTg5YkpYWTdhUzRHcWZ6MzJqNkR2YkR5eWxJN1lPZHZXQ0dBU0ZX?=
 =?utf-8?B?andqQi9yNmRHWEFwTnJCSXBzdVhSZFJGOWlvbGRWMVZZcVI2RVVYWmlZMGZy?=
 =?utf-8?B?Nnl1Yk5MVWkzSVdXeldjZWdLR3p6d1R4dU9IT3ZnZXUwdEtaT05GL1ZSZENV?=
 =?utf-8?B?WkNJL09BNkZOOFRPRCtjWXBLZnBpSzF4cENVaFlJV3lDYUhKQk84RS9iQklT?=
 =?utf-8?B?aTl4RHFFK3NqVEljSE1ETnRXM0dVWk5XM3pjejRURVNaeVlOQi96ZncrS1Zs?=
 =?utf-8?B?eXRFcUFhK2Y5c0g0d0hpQ2pyM0w5WVZ2RzdJb1A3NUFlTTI5bS9paHFBOGRz?=
 =?utf-8?B?VnZKb2NNYzNoYTdPZnVmbzB1WHNTc1kzaEtDMW1qcUdIK3JLbkc1YlAxUi90?=
 =?utf-8?B?eDl6SXBtc2xxTGtwcmdIZWtIS3hXNk9oVGkyS3RoTXlZSE5rMmJnZmYyOHVq?=
 =?utf-8?B?cWI5NXI2dUpWczI4djBlWDYwNkJEc0Uwb2NaVUtFTXY2dHRmendnVXRmSjNJ?=
 =?utf-8?B?Y2RJdXJCby84RGVIbit5d0JabnBGWXh1dGsrd3NuQjZKTGx6emhaNGRJWFJh?=
 =?utf-8?B?ZWtzbmgzTVMxcGE0SGN3SVFCeU9WeUdsaE5FeXlqU2d3bURrVlEyVEdsL2pU?=
 =?utf-8?B?NXp1Yjl0SmVtcUU1a2x5cnJFNjdtU1NTU2xLWUV3Vlp5VW9pVWNBV0pxTEgv?=
 =?utf-8?B?M296b1Y5WFdoWkdiYnNoNlVJSnAwdlJxTkc2b0FCSWVYekJYUTNsdU1BMXVa?=
 =?utf-8?B?dlJGcXVqWmR6dUFCclZncng0YnhTTmFnQW9NM2xhdHdKZmhQM1hJWCtkVDMr?=
 =?utf-8?B?REtCemMwaVI0U2NBWEhmZjJNWVJ1RE4xeGpGOXFFNTh2ZnhabFBUQy9hZElP?=
 =?utf-8?B?bmQ0bENrdkxCUlN3NGNzWFVuMFY1ZGpreCtoSm1Oamxsc2k0TEkyMW9OalQ5?=
 =?utf-8?B?ZlNSYXh4bmgxTFhaUVlQNmFzWHo0dFRhOFV0dmVOeFJTQ0p5UXpVQkZubWFv?=
 =?utf-8?B?M1VmbUtWcGhOR3JHbU9LTjY2cStHbXpxcGk4bUVuK000YUt5azFIdjFFOGM3?=
 =?utf-8?B?MTBsMEg3ZGp1ZDY5cm9ZUzFpc3VjdS81ZGlqTXhsbnprbDlleDNrTy9sckYz?=
 =?utf-8?B?Wk1VL2d0bmYwRHQraGR4T09pK3lXcjArQTQ0ZStJS3FBalcvTGxocmdlNTJY?=
 =?utf-8?B?aGF1d0tOZW5DbFczakZyRjJrRGNxdElsN3J1NWQvRVZRQll5VnlBU1E2WTly?=
 =?utf-8?B?QWlFVnNjOFpuVkRGMyszNis1VXE3T1pLNjR5aUVTOEo2OWcxdEd5TU1QenJY?=
 =?utf-8?B?ak51S3dFdHd5S3NGUVEwdG43Z2VxdUZHWDlVNUwrN0RtRTBOaEtSazFiRFZ2?=
 =?utf-8?B?YzQ3M3FVaVU3OFVPUHBMclZiS0tnSEUxdnlUSjlMUzNFejI2Q3pGNzVrK042?=
 =?utf-8?B?ejNpMm84U3RRZzlVSzduZGJaY240U1d3ZnNGK05CRHRWbnA0V0t3dVZFb1VF?=
 =?utf-8?B?aDFSN24zOU5KWkwyZTNLU0VkTTNiSzd1c1FVTEJYQkNwSlRTNWZqQWtod2ll?=
 =?utf-8?Q?YP/Yk3TnH/k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJUQ1lMT200cmJMRlA4U1d3aFQ4empxTkpYMEgwS01uV0JDbi9GbkhqZ09q?=
 =?utf-8?B?T3JITS8yZDNESVVsREh3L0ZtSy9nUEZVS1JhdzFnaG0xeVhkSlRHaHZpSE4x?=
 =?utf-8?B?bWIwUHp1UU15THdCR1VENTFQTnZKUHpVMEs2R2h6MkVnaUR4THc1Z3l1OERt?=
 =?utf-8?B?Wk81TWdjQUFIQ294NFNWN3NuTkh0QnRQNHpZRXZJeElBc1NJSVFpVUwxK0lH?=
 =?utf-8?B?UENWd1F2Q0ZORHF3dWpXU2d3UnkzRHBXaUE0YjY0Vjd0TDA2ZW5ZNFAwTTNO?=
 =?utf-8?B?N2dwaklXbVJ6NFZRL2UwT2hxMlZISmxzMkdjNzl4R0xGVXNOZ1pwRlA1Rkhq?=
 =?utf-8?B?MHo0SVNwdkdtT0tsNGdIZUxjSk9icTk4cTNiMkxTeUg3T3kwUGQwM2dSRzFv?=
 =?utf-8?B?VjZxaTNxd0FRNmFQc1I3NGpEN3VJTTlSeUsyNUhLMUJPRlF5MzdLbzhmL0lk?=
 =?utf-8?B?Y0U1TDJBVkExQmJ4QW8vMjFJcjhFS2NyU3FjL3V2Rm1wZlhYL05XdlU4RXNq?=
 =?utf-8?B?emY2M2NmbFVKUU9lYjFWMjZrdHZRQTBSVW92Q3lxUWNwUmxUTHVPdUpMK2hn?=
 =?utf-8?B?SVhNSlYwWm1zU243bEtwRXpXU3RMZ2pLNzBEblY3ektUNWk2b1Y5NGdPQU91?=
 =?utf-8?B?VUhSQzh5Q0Y2Y2YydEZxYUJmSWJZTkU4dUFwRExaSFlFVWZkbHRYQXUzRnhw?=
 =?utf-8?B?U3hMN1dMN04rV0toOFFQTHlrMllRcEx3TFlIUys3NmFxQ1ZCcWJCSW5TL2Nt?=
 =?utf-8?B?RzRKbFVYQjBMRWczTEk3OStQL2FKSWMzWnhFK0VSNmVxUitzNTFNNENReUN5?=
 =?utf-8?B?TU1mbUJHUUVLSXZxY0VOWVhUL2licFUxbnluMWNYc3A2em5MQThoUTJPemxz?=
 =?utf-8?B?cFl2RDA5b2ZCZWRveVFIMVlHd0JGQUVPVWsvcFkwVVFaMy80N1BxWG9JUXIw?=
 =?utf-8?B?SEhQS0x2VHRQRnBmanVzTXM3cWRaQWFYVFNqR1lmOFRBbzZpODJSNDNpM1hN?=
 =?utf-8?B?QWVsRVZld1Q3NCs4MWlRMDYvejI0Y0dzWVIrOUFVVm92cXdvYjloR1dPMkJD?=
 =?utf-8?B?KzM0OWtnclBMOTN3dDVjZGpZb0ZPdjl5QTgrcDZwRmJFMG9BVzJGMWpVRE8w?=
 =?utf-8?B?NUlWVkEzbGhHZWl4WlFLci8yUEVwd0c4dGtiTW1yamYzMm9jMzRtTFJZNjV2?=
 =?utf-8?B?d2NFN0laZGgvY2UyWjh5U0tYWm5wSkJYa2ltVCtZNlBWY3BiaWVmVjdvZDdN?=
 =?utf-8?B?VElmS0JvZFpKTmtlNEc5WFh6Y253aWkxOThFYmZ2OTFQUlA5ZnNhODg4dTZ4?=
 =?utf-8?B?VC9LZjYzUHZXM2Fjdy9jRW9rajNYNDNFOVBpaWtMcWo1WnFKNW1XUm04Q1ho?=
 =?utf-8?B?dHNuWVFEUElGMFNVeTdTWHdsOVhNQUxQR1ZpV2hGc2pTb1cvcEtsL2NkYzZm?=
 =?utf-8?B?L0NUMW4vblNMK0NBYS9SNDVYMGY3bWQwc0k2MmFSN2wvZkxhN1FRSFozcTNu?=
 =?utf-8?B?N0hWUjRjaWUxclRDc2FyM1grcnZhNW9lZ2FQeFNDK1IzbjZnQWFIalFWbTIy?=
 =?utf-8?B?YWdrR0VXNzRsbXFzWVZwV2ZRU0lhL3Bsb2hvOG1PZkJPOVZGdHA0MWFsV2d0?=
 =?utf-8?B?d2xrMlBxVzliOHVGczUydmpoZUdHZElNUmFxb3p5NlNtS3dhMGR2bzRyMnhK?=
 =?utf-8?B?UU5SNzRpVHNZUVFCMVB3a2oyS1NXd1VUV3dYQWhmOFhSeER4dkwwemFPTDli?=
 =?utf-8?B?My9hUzlWdEdJM295QW9xUE9vbFRST0Q0aTBIbmYrdGkyOXVZOXlpT3RMa2VG?=
 =?utf-8?B?dm42KzVaWTAvSEJZc0UwdkZTbzBRem1ISE9BL2VZR0w3TlZtUjRqQUJmWmd0?=
 =?utf-8?B?bHpkZkFmYlhWeE5PbkNRVE9uQnh4QWd3a29ZTXFIUUxiQWt1OGpXR2VDVmYv?=
 =?utf-8?B?QkM4NjdLYmJpZDdPNXhheGhUZUxKL2hIVnpqMDhLY0FPaENpVHNiZll3Zy9y?=
 =?utf-8?B?dFV6cWczdG0rUFZ0Ly9iY25qVm0wSk42bjUyZEdBcXZCZVdhTnJIeUZVQ3VL?=
 =?utf-8?B?TDcyOTNFZkVjdFhmL3plMC9yZ1UwUkIxU0Z0WTFxQ1U0L1pwY3pGMy9JWmpy?=
 =?utf-8?Q?oHPVVAU6tHZjKg0fM1WrT49yS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc4cac3-0ab7-4ff8-bdae-08dd985f2923
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:01:03.8289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFp6iNWG/LBjLu4olBP7hlRculLn09T/hO3pOx49jQ3BnTdfrhgI1h3B0GFJpOjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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

On 5/21/25 13:55, Zhang, GuoQing (Sam) wrote:
> 
> On 2025/5/21 16:06, Christian König wrote:
>> On 5/20/25 07:10, Zhang, GuoQing (Sam) wrote:
>>>>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>>>> +            /* set mc->vram_start to 0 to switch the returned GPU address of
>>>>> +             * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
>>>>> +             */
>>>>> +            amdgpu_gmc_vram_location(adev, mc, 0);
>>>> This function does a lot more than just setting mc->vram_start and mc->vram_end.
>>>>
>>>> You should probably just update the two setting and not call amdgpu_gmc_vram_location() at all.
>>> I tried only setting mc->vram_start and mc->vram_end. But KMD load will
>>> fail with following error logs.
>>>
>>> [  329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M
>>> 0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)
>>> [  329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M
>>> 0x0000018000000000 - 0x000001801FFFFFFF
>>> [  329.314385] [drm] Detected VRAM RAM=196288M, BAR=262144M
>>> [  329.314386] [drm] RAM width 8192bits HBM
>>> [  329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate
>>> kernel bo
>>> [  329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
>>> block <gmc_v9_0> failed -22
>>> [  329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init failed
>>>
>>>
>>> It seems like setting mc->visible_vram_size and mc->visible_vram_size
>>> fields are also needed. In this case call amdgpu_gmc_vram_location() is
>>> better than inline the logic, I think.
>> Yeah, exactly that is not a good idea.
>>
>> The mc->visible_vram_size and mc->real_vram_size should have been initialized by gmc_v9_0_mc_init(). Why didn't that happen?
> 
> 
> [Sam] visible_vram_size is set to 0x4000000000 (256G) from
> `pci_resource_len(adev->pdev, 0)` in `gmc_v9_0_mc_init()`.
> It is set to real_vram_size 0x2fec000000(192G) in
> amdgpu_gmc_vram_location().
> 
> Should I update the 3 variables inline and not call
> amdgpu_gmc_vram_location()?
> 
>          mc->vram_start = 0;
>          mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>          if (mc->real_vram_size < mc->visible_vram_size)
>              mc->visible_vram_size = mc->real_vram_size;

Yeah that seems to make sense.

> 
> 
>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>>> index 84cde1239ee4..18e80aa78aff 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>>> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
>>>>>         top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>>>>>         top <<= 24;
>>>>>   
>>>>> -    adev->gmc.fb_start = base;
>>>>> -    adev->gmc.fb_end = top;
>>>>> +    if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>>>> +            adev->gmc.fb_start = base;
>>>>> +            adev->gmc.fb_end = top;
>>>>> +    }
>>>> We should probably avoid calling this in the first place.
>>>>
>>>> The function gmc_v9_0_vram_gtt_location() should probably be adjusted.
>>> mmhub_v1_8_get_fb_location() is called by the new
>>> amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().
>> Oh, that is probably a bad idea. The function amdgpu_bo_fb_aper_addr() should only rely on cached data.
> 
> 
> [Sam] Can I add new `fb_base` field in `struct amdgpu_gmc` to cache the
> value of `get_fb_location()`?

No, please try to avoid that.

> Using this approach, we don't need to set fb_start and fb_end on resume
> any more, since the reset of the 2 field is caused by
> mmhub_v1_8_get_fb_location() calls from amdgpu_bo_fb_aper_addr().
> Please see the code change below.

What is wrong with setting fb_start and fb_end on resume?

Regards,
Christian.

> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -259,6 +259,7 @@ struct amdgpu_gmc {
>           */
>          u64                     fb_start;
>          u64                     fb_end;
> +       u64                     fb_base;
>          unsigned                vram_width;
>          u64                     real_vram_size;
>          int                     vram_mtrr;
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1527,7 +1527,7 @@ u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> 
>          WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> 
> -       fb_base = adev->mmhub.funcs->get_fb_location(adev);
> +       fb_base = adev->gmc.fb_base;
>          fb_base += adev->gmc.xgmi.physical_node_id *
> adev->gmc.xgmi.node_segment_size;
>          offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
>          return amdgpu_gmc_sign_extend(offset);
> 
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1728,6 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct
> amdgpu_device *adev,
>                                          struct amdgpu_gmc *mc)
>   {
>          u64 base = adev->mmhub.funcs->get_fb_location(adev);
> +       mc->fb_base = base;
> 
>          /* add the xgmi offset of the physical node */
>          base += adev->gmc.xgmi.physical_node_id *
> adev->gmc.xgmi.node_segment_size;
> 
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -45,10 +45,8 @@ static u64 mmhub_v1_8_get_fb_location(struct
> amdgpu_device *adev)
>          top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>          top <<= 24;
> 
> -       if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
> -               adev->gmc.fb_start = base;
> -               adev->gmc.fb_end = top;
> -       }
> +       adev->gmc.fb_start = base;
> +       adev->gmc.fb_end = top;
> 
> 
> Regards
> Sam
> 
> 
>>
>>> mmhub_v1_8_get_fb_location() is supposed to be a query api according to
>>> its name. having such side effect is very surprising.
>>>
>>> Another approach is set the right fb_start and fb_end in the new
>>> amdgpu_virt_resume(), like updating vram_base_offset.
>> That is probably better. And skip setting fb_start and fb_end in amdgpu_gmc_sysvm_location() for this use case.
>>
>> That was done only because we re-program those registers on bare metal.
>>
>> Regards,
>> Christian.
>>
>>> Which approach do you prefer? Or any better suggestions? Thank you.
>>>
>>>
>>> Regards
>>> Sam
>>>
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>   
>>>>>         return base;
>>>>>     }
> 

