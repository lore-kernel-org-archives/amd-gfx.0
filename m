Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B42C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 06:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C853310E47F;
	Fri, 14 Feb 2025 06:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRTJzWdW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C2010E47F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 06:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZY6mdzbPLGBbIKqXbyNQDIswPFZCu/D9vQEduhNySVzgK9JayWGmm7Ps38aTyxqvx0V3FcFLRHFvHh87/G4xTv7Z8hXKZZ1NEOPYUZZU1yIRad7ARlGWFVrNnbr9CdqLjRcakOxNGSnqLZe2kF3Upy8dm0VwtiVWMQOZ4yxksRdhT5+9JBUzC1siDadc9VIrpg8gpkgEcIxVgFMt3tHCg9fpC+XYwCIJZN23hjoO2HjLVpafKEyUY0efdzIE1EifXQSWsun0y3ZEXoe1xh0UNUkfPxhTJoox6BPk2fzStftYf8QwZTA+gRFtRE9rWrO6+634EgXK3N3NyZD6vHkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X22qKQ1G6RyGWDn2UCmf2DbtrM/4QPm9BIS7Bgv34BI=;
 b=xygiR2mE28IkU6/VDjutW04XUnH7G6wU5PLTujF0OWmqk/gr/ZlDzskfZ2H7BlLJM8XjyWXYXbOlS8kPd3zxu8iiiokyPbPtPVbFRXAdumpYB9+hEwM+rrji/c3vAj/9LvhKrdo+cccE9b59+Iqxwm5EG9M3tD0iC1XKQiEG0WVC3dUKa7exKF7eiTgJ78DnBZ72+rCDHNNpxxCIebpQVpLwQ4i++0cMh78hDersFQozsxbNGgskTXcrmSwiOj+3VerfO0ypzp0IeHdnE6BmYjw31MN5sWQPH34ETQGua13T9rjjU0WGk556Sjb0kQef6dXvFcKwSIZFose5q1grZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X22qKQ1G6RyGWDn2UCmf2DbtrM/4QPm9BIS7Bgv34BI=;
 b=mRTJzWdWc2Z59F6CDaQ2fbIeoPkqbk7/PN5g0picFc4aSRCWuRJ1EHso8AuYYF1en1V3CSTwxUxjsnfmnAKe0YYNZc3A8lM+CjX4KPAAH4vFeY9/OJcDC2HWpWui18wr3rEUepJgoJRMYaoJOEABqD925zdQpXyiTzRFWN0RjwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 06:54:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 06:54:00 +0000
Message-ID: <6c3c7cc5-c08d-4b17-95d1-43b926944713@amd.com>
Date: Fri, 14 Feb 2025 12:23:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
 <989be73f-bc25-46a6-bd28-3a2576fdc73f@amd.com>
 <BL1PR12MB51446E8E4C516978889145F0E3FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB51446E8E4C516978889145F0E3FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4817d6a5-14aa-4373-21bc-08dd4cc45c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXR3aHZTTUFMOVhuL2F2NFZtSlFjaGlCU1pqRUdqU0djMmMxZUF3RXMrakVW?=
 =?utf-8?B?bnZtTUhwNVVmRzZ1UXh3bDRLNFpqem1UZHBha3RyQ0hxekRnKzJTZUJST1Vv?=
 =?utf-8?B?a0luNW05ak5LeVIxaEZIakFScEhSSkNkREx5NlV0RjNVSmVWZzlwYjJmZlQ5?=
 =?utf-8?B?NVFPUmQ2WHQ3Z3VGYUNzS0ZRQUpiZE1LTy83aVlsWUhMK1VLRHgzeDg3SnRk?=
 =?utf-8?B?REtETTJOUmNkL2JNSEtBSEdyVzM2ZW5LVU5HMGhIZVNuazA2bWRONzU5bGpP?=
 =?utf-8?B?YWtkaS9tTlRrcU0wQUluSG1jU0xFTDBrb3h2VjIzSU9LUmQ3UzZ6Q2VIa3NK?=
 =?utf-8?B?MCtmR0FpaGpUVjZHRFQ5VEhqS1NtQ1pCU1k0UkFUOWg5Zy9aM0pTakNncmZj?=
 =?utf-8?B?RWhNQjFabkpQNzR0bmgvOUJqakZ0aW5BSDA2bXhIVDdmcG1TVTd5Q0VteGEv?=
 =?utf-8?B?aExZc0RYZkM4cVdPWlVyaWd4T0JvU3hEWHVWejFuR09vSWJDMjViR0twTmEx?=
 =?utf-8?B?Snd4UUdKRWg0N3NJK3p1ZjYwT2hnWU5vVThmRE5BdTE0akU0MlIzQnZWd0dw?=
 =?utf-8?B?KzhLenNVRHRBMkY0aFN5aDNFaHd5L0xPTm82UjBoanNOL09hRXdsZFRoOUda?=
 =?utf-8?B?R3VMQzZnTWsreGg1ckRtVjJISlBnem1pcndIYTNicWpLZ0hZMDBxVVl3Riti?=
 =?utf-8?B?aldGREFMMGhHdlowTmxBTzMxR0lhMlRhQWJPYTh6SFQwMG9sWGdXcFFmN3VC?=
 =?utf-8?B?Q0ZpQVB4QU5UVUVpckx3dEZiQjFmNXdDWmhiVndmMTQwcUtOUXBnZzNaaUQ4?=
 =?utf-8?B?VU9OUDJwNlJnTEk5YW9VKy9PM3g4M0VPRXZ2VlNvVVc3UFJXTWorS3g0UkFn?=
 =?utf-8?B?TEhrbk85dE10YUtCWkRWODd4MEh4Slo3R0xhUlYrZHFGSDkxVVFPMnhOVktn?=
 =?utf-8?B?RTFhb1VTeVBGR3JmODREOE41MXhkL2EydkNRRndFS0FVaHpDVURNUzljeERB?=
 =?utf-8?B?SkN0OG5GUUJydEtHZGhTWWYrS2FNTEtYK0o5QW9HYlJtUHF3d0g1bU83RjY0?=
 =?utf-8?B?ZmF4Ujh0Qk5Ma3dEb1NrMFphTEVuK0o0RE9MWEgxREFYRlpRTzQvTUlQREFT?=
 =?utf-8?B?LzBSQS9CcHJNaGFwMlFCQm5RYURzWVZCU0VFUVNYTTluTSt4cDYxeWtYWHA4?=
 =?utf-8?B?YUJpaHdObmJQckF1eWRicjZEMmZSTEd0R210WGhvcDZmcy84U0RiYVRJc1ZB?=
 =?utf-8?B?L1NNdHEvSUxVNWY2S28za0RqS2tWcmRYcVJSd3Vsc3F4VjZsYmNRdnlWam5C?=
 =?utf-8?B?UmljeEF1Z0dSb0tNTW5yS05xMTlVS1NqR2RIQmkrMk9Rc0ZMV3A1M2xucFhk?=
 =?utf-8?B?YjVITnNIK1pTLy9CZGpFVUJxT3lZM3hLaTY0SHJNTzdmQmU2Sy9adWJHR1hD?=
 =?utf-8?B?S3M0Z1pmUmY3a05rL2t5bXpyYUZHV2doTjllbkxIWlNVeWhhRDhFRzhkb2pB?=
 =?utf-8?B?YTRtOFFrWmdwODNCMkJWTVQvS1p3K3J3eFlaVklrc0lnSExkbnhxOS9oUXNI?=
 =?utf-8?B?VG9qTHNBKzc0TUZVT3duWStEK3l5aWpzMHRnNktrUGZYOGxHekRQeStKMXpy?=
 =?utf-8?B?dnRqWHVPYkkxSnMzdGRjcjFra1BWcHZaUElKMXdkRks1emwwWXNib3EzbzR3?=
 =?utf-8?B?ZEVKbEdZdlZ5eUQwWG1HMkhiTWkxa05zMUdad0l5VnRPMXE5bVdJS2FKcGRw?=
 =?utf-8?B?VE5rd1lYR2ZUbWZWT2lOL0RUeFEzVEErR1Uza0tFV2lNbGhwNHg1MXdTYXMw?=
 =?utf-8?B?TE1pR2cyYlFnUzdTRS9FOHRhWkpvWlBiS0ZXL290MTFSWU92emgvRzRQM0Vy?=
 =?utf-8?Q?U9F2OkPiXLrOi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXp3cDJ4YVNudXMxbzVtOC9JaHFBcmdFZ1NJOHpXam9HcHluWUNZd3h4dERJ?=
 =?utf-8?B?NHdaZW9NdUk3eTh3REVRalJkV083d1NZNU85a0p5ZTN4eUNiR2hONkw1dFRj?=
 =?utf-8?B?ZWliaFNtWnJZS2FmenM4dmo5aDdHcVZaTWs5UThkZlZMbmx1cU15L3l6cmhK?=
 =?utf-8?B?NVN6amhycXpidkhKMkJBZHpBSFoyVHdTSXRoK0tkQjMzSmRvQW1CYnRpNHc0?=
 =?utf-8?B?RFdvRmlWYzR2aXVKdnZ1VE9UeHJuTVpLSUx5RDhhSERHd25FS0d5aTVDWnlK?=
 =?utf-8?B?TjlNb0prSTFGdGZhbkhad3d0MG9rWWNEYU1oWlRRUUZxQk1uTWhPbWYwMFEr?=
 =?utf-8?B?eFQ5bFJSN0RjNW5IcWRRZlFMcXBpeTNIaFBsT2pYbFZSU3ZMWkZXOG1UeHQ3?=
 =?utf-8?B?UDdiRjdxRy8yc0pJdlZXN0tBSWZ2SGcrd1psZzhDMUVTVkhUd0JEdHNPMmdZ?=
 =?utf-8?B?SmIwZGticEFzblZ1SUgyQjlPdUVZV0Y1emRJNFhjam5JUGNwTWl2bkJ6SWUz?=
 =?utf-8?B?VWo3d3J3alJPUGdpQ2Zza3RWVWdDVXdIWlpEN0c3M1Z4UStZMEs5THVSUE9n?=
 =?utf-8?B?dk5URXI0K1E3VENQRU9ZK0txUXBEVDVaSG5oNnFBaUdDN2N1RXNPUmhCUFNz?=
 =?utf-8?B?UlpLUUQ2dWZZMDVjVDFCRGc1TzNVZndscFpUSUV2NnAyVWxaYUtzOHYreUJU?=
 =?utf-8?B?M2NuT3ZHZG1qYXlDQlg0Mmljb3h6blRZMzg1SDFhMkxtRVFjQlVhRDJ0Kysv?=
 =?utf-8?B?YlcvbHJXRU9EK0ovNWNUS2podkp1blFuZWNKMUYrdFZDVkptbkNoaXYwTmlB?=
 =?utf-8?B?dWp6S2VxK3BmM29NcUpzWS84bHlWbzh5WjZkZXAvTllJRzZtTTl2TFdYVU9V?=
 =?utf-8?B?UWg3cXBBSk1XRHhHNVdLS2VVa3ZaaC9VY2V1RTYrTXNKMnNkZFJDSVBJSkZm?=
 =?utf-8?B?RWZjaDMyS2wyL3RFT2pXZXNYaE1ESlhuUXNEWUplOFg2UVcvM0I0RW5vUE5B?=
 =?utf-8?B?eXMvZzBrb1ZOOUFZa2NOL0srV3hEU0JaVXc2ZVhOWGlINldpYnVDbTAxaFlR?=
 =?utf-8?B?cWhCKzhQY0xma2c4c1FiSDFGSGFKT2NWMmpMSzduL0piZXB2ZUlEVXFURXJB?=
 =?utf-8?B?ZitMR1N2dFdkYXV4MjJhU25EWjdMZ251RG5hQWVubDJuSjVFQVpQeUFRZWRK?=
 =?utf-8?B?RTdJOW1DZGYvdVh1Qm9LUUVxeGJnN01yWjVSMEkvb1djNFBoM0lLMWNYQ1pT?=
 =?utf-8?B?YzNhUTdrUEgwTko0YnlpQkxpNVMyaEJJZmlkOFhxeE1QWDkwOXlXM2dSaXBN?=
 =?utf-8?B?Q29VbDJ0empNNHZMMEI0RmZDc3hEVjNMZ1BjTXZBbFZseUpaQXZHcHA5QXNi?=
 =?utf-8?B?dW9TUW0zK3VTbVhtSERXT0RCcVo4a1RZRUhhbmNzbFZ2UDd3YzhCNm9MV29t?=
 =?utf-8?B?dGEwMXN4UGprVVBQUWxGQldiUUlVSkErUHpvZS9XMlhOT1pWaDdrTWJFYUUy?=
 =?utf-8?B?dDFqR0RxZkxLZCtZU1FEaW00bCsrekdnbXlzK29lZGZ3LzFVaWRyMFpjcUFh?=
 =?utf-8?B?MUtMbkMxbllzRUEvN1VuSVluZkMzV3p1bHBJb1NTbzJSVnFMM1d0N2luclNO?=
 =?utf-8?B?MFJIM3lRQTFBbS9XVFVmNEdNaktzNzMxQ0lTRVBpOG5PcUttSWFNSStGMjd3?=
 =?utf-8?B?MHlRbS84Tmx1dDF1OFh4anVXMVlIQVdaZlU3VWVtMWFlNm0xWGdqVjVPMUtO?=
 =?utf-8?B?MDBHUk8zTy9MdkZsUnZCUEFBT0p3cTc0eWVGUFFCeldQN2xNYm9MKzFBcmhl?=
 =?utf-8?B?MUQzMzA1RkhMN2NHRHQxK1Myd0FjVVpNZHh0MUtuQ04rN1FQUmFwVlZSUDR2?=
 =?utf-8?B?blRPZVhWdEVwUUY5Wlg0eG9aZENsS2wyOFYzNXROMlNNMVZ0U3R0am5ld3Fn?=
 =?utf-8?B?NlVlU00xMVg5Y0xEQmliRlpQaFZKRVFUaHJWcTFpdXYyUDlPWm1GckhteUl1?=
 =?utf-8?B?NEptTUQ3MWU1K3NrRmhlNFJXMnBtUTd3TTJqYWIwZENFNUFTMkJ0VkxlcGha?=
 =?utf-8?B?SWxjNmFYOHN5VFBVWStMRGNGRUFRdTRIZ2JnQVRSUXZzU2cwcS85NytYT2FC?=
 =?utf-8?Q?SYkA6F0fJzH0na1I9d/XDjejd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4817d6a5-14aa-4373-21bc-08dd4cc45c60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 06:54:00.7871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZkphIUy6XX/N23rJufbG8nC880tuZD8qyFjecoFA73a/8yxD2qXwF62/lo/LYMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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



On 2/14/2025 12:14 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo,
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 14, 2025 2:10 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
> 
> 
> 
> On 2/14/2025 11:25 AM, jesse.zhang@amd.com wrote:
>> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>>
>> This patch updates the SDMA v4.4.2 software initialization to enable
>> per-queue reset support when the MEC firmware version is 0xb0 or
>> higher and the PMFW supports SDMA reset.
>>
>> The following changes are included:
>> - Added a condition to check if the MEC firmware version is at least 0xb0 and if
>>   the PMFW supports SDMA reset using `amdgpu_dpm_reset_sdma_is_supported`.
>> - If both conditions are met, the `AMDGPU_RESET_TYPE_PER_QUEUE` flag is set in
>>   `adev->sdma.supported_reset`.
>>
>> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index b24a1ff5d743..e01d97b96655 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1481,9 +1481,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>>               }
>>       }
>>
>> -     /* TODO: Add queue reset mask when FW fully supports it */
>>       adev->sdma.supported_reset =
>>               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
>> +     if (adev->gfx.mec_fw_version >= 0xb0 && amdgpu_dpm_reset_sdma_is_supported(adev))
>> +             adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> 
> This function is reused across multiple IP versions. MEC fw versions aren't the same across those IP versions.
> 
> In fact, the user queue relies on MEC fw and pmfw when the sdma queue do reset.
> So we need to check both of them at here  to skip old mec and pmfw.
> 

To make it clear -
MEC FW >= 0xb0 is having reset support for say GC 9.4.3. With GC 9.5.0,
MEC FW 0x20 may have the same support.

Thanks,
Lijo

> Thanks
> Jesse
> 
> Thanks,
> Lijo
> 
>>
>>       if (amdgpu_sdma_ras_sw_init(adev)) {
>>               dev_err(adev->dev, "fail to initialize sdma ras block\n");
> 

