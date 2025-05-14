Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C04C3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 09:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0195E10E2BC;
	Wed, 14 May 2025 09:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PwW82Vj/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8A710E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 09:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TODZ6e6mNGH/7UUmy54zVzSv2iz6n75jFlEkqdOFK9olREI+1Moc60ahZ9Bhjo9D/VZBDCqJPHhoVq4EwmhOzVksczozuqS4hC1mQ54AQADTKgGoRWVmedZe0KzbpvjJh/6A+jvfNBcdCQEtm9ixVda3lkOkMr5UJ4jegXnzLuZ7TIePqt3XnSB/bayqjPKgxaW4nCYvhJxH3kNLRMW+Wbnw/ldrLqpIwpYn/57yJzpuBTJzN6L6bvd4Jt1zoD0u8ONHWvk0RwChlOv2ILSLzvvntdnGSnRt461bBqHUOC9A16tcgY9iV7SYgcyxtZwh8KiS+5zLh1nbFCMd4EMrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/I0LoMyrdYgUGlTOfvQurv+GgePW1QgdaGSBZiVUOE=;
 b=Megy4je6yQl72uusxwJiMgIdv3gPt7ECexVhkmsTCokCkWPa9HUdWmoP41J0pU6dMxlWtd44GaYjZcYUY1c9xhQecNqoSFl4MtsYZ/0ommEUDrtsI6oLECiM7FO+38RoCP26ax6GBmXlLFHR1wyUw53omV0WEOyAaJsLrNicE949PdEvweihh9vxFd9uL6m87dhDZlNc9pAE0wjbHLll7wOTJjqabenE868W7cOqLQ6biM40nrkoMhNUxamhf6ieoBmEK/tVJ7jc9jfu7/c60ep+boxwuFRyUvcC72sNBdEZhyHsPsKLiFE34USNu0/HPkq7BrPvTD0tYKEtHTP8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/I0LoMyrdYgUGlTOfvQurv+GgePW1QgdaGSBZiVUOE=;
 b=PwW82Vj/GETBxLqaR9Nfqv65nlfrH2I6/RUnJWA0XuGrmjFf5j6eSw4Rr9p5FqQRII3N/pV3F4ydI2s3k97lCNdURFDE7XcMgfxN516kFIRKbjM/XfPZvpsBhQ+jGXIq1xKwrGgzluDBk6XTkZ49E0cMW8UhbRzD9TaVzAMGVrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Wed, 14 May
 2025 09:44:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 09:44:42 +0000
Message-ID: <4b59c00c-8e1f-4a1e-af84-d982484b5102@amd.com>
Date: Wed, 14 May 2025 11:44:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix userq resource double freed
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250512073002.401719-1-Prike.Liang@amd.com>
 <afa44c90-2e7b-4fef-9a64-b869980d39b7@amd.com>
 <DS7PR12MB60054EE620EBE4EC5E00C161FB91A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60054EE620EBE4EC5E00C161FB91A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 460f6d9f-b155-42b0-ed7b-08dd92cbf3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDhlc2Q2WFZZaHVlSGpQa1M2eENWNjVwbysrZmxOdGtVc2VudmtoWVpFa1ha?=
 =?utf-8?B?eEsvR2RxUlZnMjlDeUYwNmZoekozSXNsajk0Y0RQRkNzM3Vab2RBSiszNURD?=
 =?utf-8?B?eVMrVXJaWWNRdUZ5blBzM0hJaVhMMUVEdXNCSWxwMUZNWkhJN2hDcmNmQlh0?=
 =?utf-8?B?MFcvZW5MM3lPSUozczIxWTRHY3RGSWxoeVFQQUExNlJoaWx6YnZ5OHFWYm5r?=
 =?utf-8?B?bGhmSFdwSVFRbGwwZDdQNG80blZ6Z1hLMnJIYXpTRnNEUXJDdmM1V0dzZW9Z?=
 =?utf-8?B?NkluNlllbGw4TlBML2pyT0JGdEFZWUlWYjNGTDgxeldRb2tRYjZTM1hRckZx?=
 =?utf-8?B?ZGVnM2M3L2Q0UmsyRmNwWEJmRWxVRHBkUUdUTUQ4R0NhOVZXRnRZMVJDYWs0?=
 =?utf-8?B?U2JQa0NKQStHVlpGVjhtRkkySTN2Rlg5U2I0dHY0ZzBOcUVOdmRuY1VTdXdm?=
 =?utf-8?B?bGFTMFZpbEpLOEgwT3pEVjFsdlBINjN3Y2FCaitlL2dTTXdvb0NHM3NGTm9v?=
 =?utf-8?B?Sm12UnhzLy9henVXN2Y3M0dPUjJkUkRsZTN0WnNveFl2ek1EeHpucjhlNE1q?=
 =?utf-8?B?MXM4SGtiNHJ0Y1BNWTZWdkcwSmp5NXNPQk1OV2tOekNXV05McEdUU1J4eE5i?=
 =?utf-8?B?TTBXQmRTd1AyOG00ckRiVXJBWHhJZXZlc0tWK1R6Z2hyNk45R0hsUE5OSkxX?=
 =?utf-8?B?T2hReG5pcEFmNVcxOFFlOVJyZDdsamFZTlF2c1Arb2N3WXlGMjhTR3BTc3M2?=
 =?utf-8?B?ZzZ6YXpmYlRXQnhBVjcvRWVKTUt6Q1U3S0tiYnB3cUpaelpiZi9ndEVzbkli?=
 =?utf-8?B?SFF2YWVCcXN5V09OOVZyaXpvY2FiVUxHUEduRnJ6NXNHeCtOcnlKV1VVdVN2?=
 =?utf-8?B?STBWWkdHdjBaRjdBMjdONGVHdERBeGloL3F0cDJja09jcjZFaDFPNmJ0SnJY?=
 =?utf-8?B?WUJzdnlqaUxGcCtETWN2T0NFajJaMEhmekZPdnBQVUJSZ0x1OGJZNDA4MzZs?=
 =?utf-8?B?Sm4xOVQ1eUJWOVEyMGFnUFBBMXI5UlN1VWJ2RnFuS2pjK0k5VHhrOEZkbU1m?=
 =?utf-8?B?MG5ucmVHb1BOdGhCWjZQQU1CU0hSdTJxREo4blpPeFltSEc5Y2NEczh6YjQv?=
 =?utf-8?B?UU0rMytEK1d6MWJmSHp4R1kzMTBaVnVqUDYvMEZBeXdqdUcwTkxjZm1YdTBF?=
 =?utf-8?B?U0QxVnovSFZJbkp4UFdBMlN2SWNLWmtPSmRUZmc5Y1VnNGErWUkxUU12Q2R3?=
 =?utf-8?B?SzNCZDJTeWJVZDNBeS9rVitSVnMwdmxzRWJhWm5qcUt5STFZNFE1TGNTRDFN?=
 =?utf-8?B?dytXMFdydkd2WmVVQzJjbTJjNTZDcUx6MmdLem9QR1Q2YlNRUnhkMnF4OEx0?=
 =?utf-8?B?Tmt0OFhPbGR6RDd3TDl6eG9ZSFBIeEZLMUVpRlZZZjBlaXpEdVZDbDkzcytV?=
 =?utf-8?B?NjBtWTcwYUlML0FnNFpyT3BWM2tKcHpyaitXZWFyODM4bFpKeWw4ZU1lZUFl?=
 =?utf-8?B?RVh3WDVMYndZUGJqWmNPVzhDb2xwZ29NVVdZdkt5Y3FOaDNBUHNXaU5GRTdZ?=
 =?utf-8?B?UEwrMmQ1UE5tZUl1UzRuSnZCRG9kQ0xDeW05bGRFb0hDTURTUFlVQkFHY1cx?=
 =?utf-8?B?Sk1zVVc3WCsyblY5akZTTkkxVjFsdy9GMHV4VEtaVmJIZUhCL2drNlQvOXZW?=
 =?utf-8?B?L2xobmg4SUNSYitHKzhVL2JVMFU3Y2JrU2RsNitoTE9XZE05c1k0Q1VreDFM?=
 =?utf-8?B?OThmcHhyTFh5di92bDVKYmthWCt4TlZCZjdabDdDTlhlTDF1MlM1OVpLeEx4?=
 =?utf-8?B?dVZ6QUx1MXEwV0h2bk1MWHNrTEphUklBUVh2bS91UjVJRWF4NGNLdkd1RERa?=
 =?utf-8?B?ZnVXdTRueWFpTzdqZEQ5SzRoblI4emNjajgxNnZaODlZUXlIQ2xZZmJVaWk1?=
 =?utf-8?Q?1Cxu02hkCpk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGRmUE1KNUJBbXJMOVBTOHVYNjhPM1N4RlhjVHdPQTdQOUVaZnhCSEpHTENx?=
 =?utf-8?B?N1NWNzJRTFI3bENLdSsrc3prMlNRdXM0eW5aeENWS01WeTlJbGYwK0JIbkpt?=
 =?utf-8?B?S0tGanRCdW1pcFhOUm1QVG15ZkJmcW8xaVhoNEpuSUZKaG9hd0wrUzJibkd0?=
 =?utf-8?B?Wkg3TkNkMCthdWFwVjFHWktLSXNSZ0wybkZ3Yjc0UmNOUERDVVdGc0RJTFR5?=
 =?utf-8?B?YTh6MWM3aTM2ZkxiakNIeU52a1ErWnZpbUZRK1RIeit3UlhvTU1ZVy9scGo1?=
 =?utf-8?B?MTJqWjNrR3JSSExmZFd1TUpwVHIzSkN0R3l3K3dmSkhvKytLaHdpVmt1SG1K?=
 =?utf-8?B?VHJvUm96cDVDa2VBQi9NakJYd0hyWEp0QVlnOHdHekFveU1PdnBPMTNKdlVS?=
 =?utf-8?B?NmJwbDRuYXhUMytRWmNSa2JoelMvY2FjTlBpSGMyRTZubHdHQUZCcU9xWTRa?=
 =?utf-8?B?aVdERDBhMFBCWXJ2UlJFWklUWEZkdEpnVDVXNXN3aFhYUDFYenpYQ0VzZXFm?=
 =?utf-8?B?MUNrNENaMzBJYUJWeFdxVVFXMkVSelN0K2RpME52MHdVRHBVZi9XaG9xZjdT?=
 =?utf-8?B?Y2kxenVKaVZ0ekREdWhnTHd6dFNkeHZNbDhCaFFEWm5iM0lOMEhGdVdXMUE2?=
 =?utf-8?B?b1JvMjJhMmZLaDRySTdieGhGWHZwalFOWGFCM1B0NnZFVzkwbnM0VTZPR0tQ?=
 =?utf-8?B?aHJHdURHQzNqc3F2UmgxNWhIRlNtVXhkeFhoR2VyYm9qemRxL3NmZklQT3FW?=
 =?utf-8?B?V09CdFoycFFSbW5nWWRpT2M4OWZ6a1J3YWl1dHB4VkxOUVNKOEg2Q1ZtVlJX?=
 =?utf-8?B?TllRUTF2ZE1kOVR2QTFWaG9QZ1hRTnJMajZ0MzBNNllGZzVQK2tFRlJISnZY?=
 =?utf-8?B?Zzk1OVlCL2dyWHRKKzRiTmtjNE5wKzRPZTZBamJreUovNWFTMUY0U3JZcHpN?=
 =?utf-8?B?eG55SGdnVGJ2K3JqcFA5NW5KYjVBKzBKOUtRdFQySlpXT2t6Y3RIVkJLWHJ5?=
 =?utf-8?B?UHJ5dHg3bUpsMENxQ3dvTldKWWlrRW5uTlA0WUpiTFlhZjhUUGZIbEkyblRI?=
 =?utf-8?B?RnBacVFmUHNXMm5oNzVJTE0vUGpVbU8rSVZnbXZHMWQrcVM5YzVWdnBJQVda?=
 =?utf-8?B?QWRlSDFpSStlWUNjVWl2ZmNXSmJQaGJESEMrREg2QjJ3UkNjUmQ4NU5JSTFj?=
 =?utf-8?B?VW5UNkluU2hsV3B6NU9XUkxQYmFUL2RxWlJ5bHFyazVOYmlkSCtGSHVYWmll?=
 =?utf-8?B?MmpuZmM5Wnl6RXhkTnQ4UUR2L1VFVXZUMHB5eUlNMzFuYW1NcFdUYXNPdm9C?=
 =?utf-8?B?YlhFZUFxK1RoM0dUMHJhMHF3TDJzTGZBYXI2VGJmdWpzU2xOeno1VzZaZUdr?=
 =?utf-8?B?ZzFTSDlPcWc5MEZKK2g2NmlzYTZqSEtOMXJwUC8xaC9WWkFSWGhtNGpHK2FR?=
 =?utf-8?B?RGIvNEl3aGl0eit1UmF2TzExVEFvSDNvdUExNGw2MCt4RlRKbnBtT3BTMVp6?=
 =?utf-8?B?STFGWFpWTzgwN1hFR3VLem1GdnpGVjE2WTZNYjEydVRxQWVISmJjcDU2UHA4?=
 =?utf-8?B?WWt6Z3hmb3d4emc3Mjl6ZTA4LzY5Z29kV1pRODdqYnRrSmFGL1d2bDJtWHhR?=
 =?utf-8?B?ZER0b0d0eXdZTnVLU1p5Ukc2V2podmtTYVBuY3NNVjFlRk5Kblp3S3N0bXdP?=
 =?utf-8?B?Qy9naTFJOVJFRGV0UlJ5QTFaVW1naDVrMmhEL2t0Q3lyUmppYXMwRUdlaFpq?=
 =?utf-8?B?ZlhtbCswUzk2ZE15L3hVRkVla01YOVYzZEs4bVd2VjRyRHN5RldUclBjaEJF?=
 =?utf-8?B?bGk4YXdZb3VYNFdKWEJWdDVDTFlVNlJzdEcxMVZ1OXhDQzVvdlFhMzk4VEY4?=
 =?utf-8?B?dGpHK1Z2M2lmQnJFMkk1SERRV05LR2E5NmVNMmVlL0FSZkNaRFNvQlh1cGs0?=
 =?utf-8?B?UVVxMndIK2ZnOUVtUk9XN2ZIMWZoLzl0ZE43cWc0M0hZN3RWeWZUYk5zS3ho?=
 =?utf-8?B?V3l4V2JnTnNTd01ZSDN6WGZ6S2ZXMlh2dmQwYWNPWS91T0orRkRQTThaNWdB?=
 =?utf-8?B?UVFRT20wL25Hd1MrTHdtaEJzWmhXc1BKelNhb3VJZVdIQTltME9FYlV1QlVD?=
 =?utf-8?Q?ZISHYp9bhmn8ijmtJIy0CPnca?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460f6d9f-b155-42b0-ed7b-08dd92cbf3f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:44:42.8676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugFW14fIOh24JdOawGJmlaWUux/OJ4PTLdargKCfNbnZy8Rmj4xpYoHjNX3NN0Nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

On 5/14/25 10:19, Liang, Prike wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, May 14, 2025 3:02 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix userq resource double freed
>>
>> On 5/12/25 09:30, Prike Liang wrote:
>>> As the userq resource was already freed at the drm_release early
>>> phase, it should avoid freeing userq resource again at the later kms
>>> postclose callback.
>>
>> Clear NAK. You are just hiding a bug.
>>
>> The userq resources should always be only cleaned up here and that function
>> can't be called twice.
> The original issue is that the userq resource is freed first at amdgpu_drm_release(), and then second freed at amdgpu_driver_postclose_km().
> At this point, it's more reasonable to remove the userq resource cleanup at drm file release phase and just keep freeing the userq resource at postclose moment?

Ah! In that case this code here should just be removed.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 8d4a2aed7231..cf0f35a7daee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1502,10 +1502,11 @@ void amdgpu_driver_postclose_kms(struct
>> drm_device *dev,
>>>             amdgpu_bo_unreserve(pd);
>>>     }
>>>
>>> -   fpriv->evf_mgr.fd_closing = true;
>>> -   amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>> -   amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>> -
>>> +   if (!fpriv->evf_mgr.fd_closing) {
>>> +           fpriv->evf_mgr.fd_closing = true;
>>> +           amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>> +           amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>> +   }
>>>     amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>>     amdgpu_vm_fini(adev, &fpriv->vm);
>>>
> 

