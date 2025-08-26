Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F67CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 21:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D710410E2EF;
	Tue, 26 Aug 2025 21:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lewi4s9q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4028510E2EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 21:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBcb9JQYwJSVfipVosD9Nua6ApSE4/63Aso3fcFExPgHbyJ2eVEFFSq4PXrySTzgIG8xjbF2fHtIPhsEEYPYwUp1i06DS4+O6AQxOjA6YuXZcrppP7016SKAj5+rfWYXqh+8oWtzye0R1z9ofA83pSDp2/t28Nx5fAuQm0Xu+FMb+p/zE14D7hb9YudRlmrD6M+++bv0H9aHemcWx9bVhf9Z3x2aHYDayEQTKhA5hQRfvH8gLDnk2QMkFhvOdMMVoo/CmV39x+oPWYqp/4sHUg5daS1vdehCOyTvffg2HD05DMAe9ct1/gc8HNCO0stVODhx6L46BRHS/ibJDpgLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7KR1olShsLiRVJRaS9n81wX8IpSlUwrtYNAdDfryQg=;
 b=ohSDGghq+PfgYLYULgxfetZQNsJYi93/gRwtsTzOcb4ut9GktUBEMbCNKCC0djz+mzph8Z4A9J8C5h5uYOxMTx8fxOI8gnw6SUrvvcLMKwCClOf0uLkZ+gNL8pynzRtZAQoN5bu8jJg0XlFJgwR9SjyUZBkX4cuhbpNP4WLQ8YAH2R94+y0hzVbLOMgCyHdoDz/UWeLj45Q5ONyfaniSMSufiaPJqg8pgOQ6WhErM5ZxTWj1QQ+8nlTxGuUyBf8Wr89WdXVUQGAFMAgStMbc0Hgdf1aRsGxmbiv7wJ5Pp5tyysy5/3Iqx/qWwp47cGZJWCuXKsAetNHKElxu4RgX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7KR1olShsLiRVJRaS9n81wX8IpSlUwrtYNAdDfryQg=;
 b=lewi4s9qrVoTIlo42gJ22u94vjf01ZqDET/+LVY03zpRwuQtJvlGIkQe88TXOsg7mfkz3ajXJGrxJl80+w8dFvYZ/aQI6u4TATyHywffKI8k+WWWwiy0vB8NwfZdjG0bFNn5z+65kM527NTgvG6DQfrd5mjGfqhl3NUmY8aOraE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 21:57:42 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 21:57:42 +0000
Message-ID: <e5d8b64b-9a26-48c7-9a28-1a6805b3ca43@amd.com>
Date: Tue, 26 Aug 2025 17:57:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: protect potential NULL pointer
 dereferencing
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250826193821.869445-1-David.Wu3@amd.com>
 <20250826193821.869445-3-David.Wu3@amd.com>
 <CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com>
 <1b21a8e5-7aba-48b0-8201-2db619c1e3fd@amd.com>
 <CADnq5_MjdGMc_a4N1YJMbgSMAReqe6nQD68=8cOAXWMYRA_DXA@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_MjdGMc_a4N1YJMbgSMAReqe6nQD68=8cOAXWMYRA_DXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::10) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: caa90539-f621-45ec-9f65-08dde4eb94ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmU1ZHRKR2ttbGM5NjRyWittR0IwemVkbTduWWs2NE9jelpucnZ4UHBFQXZm?=
 =?utf-8?B?MHk2L2ZTdEZaUnhNMlBTaVdjOE54a0RLZjNhTklGU05wOFZ2NXYwZmc2RlJp?=
 =?utf-8?B?Qnp5cnRrb1RVck9vRTJQU3NEMXZDZXV5b3dsdDRNN0dOL0E5eFdMajV4bVVH?=
 =?utf-8?B?V0p3OHNuQjlUbFh1MEdYL20zNDU3ZHVUNXFFbC94d1Q2MlhZVjVtUzl0aFJE?=
 =?utf-8?B?bjZxVkdSTTliV1FFQStTY1g1cVBIVHJLdkswNC9iSVIyNTYxdDIvekZtckx0?=
 =?utf-8?B?d3pqZDN2bUVkMmdpWFNKdWNiZDdJL002ZWpLNUs4N0d6ZExyQmlXc1VsL2NV?=
 =?utf-8?B?enZqS2J6U05qdGhFTTF3U1liQmpvSlFnelJtT3NOUnJOM3I4cFBFM21zMjFy?=
 =?utf-8?B?THd5WDFSeHZLdW5YV1VVT3N3Qmpxa3JwVE5UQmZsS1UzNG9ndkV1MDgrNGQr?=
 =?utf-8?B?TlE0L2xiYmJFc1VtOTZucmtQUndZWDVBMkE3aW1CUk9MODZ1WXZEcWdEbytD?=
 =?utf-8?B?MlMwc3pmN0dORVdWd0RQOHUrTlJISFJldmo3YUNTK2NGZlR4ZWtBRXRJbUlB?=
 =?utf-8?B?VTVTcU1xNmpSaFZaVnhoNGFFRiszSDRIRlFYbVh1dkoydWg1RWk0eU1JNUdB?=
 =?utf-8?B?VEtiRS9rNHd5bitKWXpEQW1qUVFZeE9iRXZidGExWlIzdVJpclg0ZVByQXJU?=
 =?utf-8?B?dUwycWJ2djBpQisxdUlZdG1DZXdhR0JHK0FQeUxvOE1wQnl0TWJlS0ZzNVh0?=
 =?utf-8?B?dlFlQkY1M0xPNVB6UENUMTIzR2VUWU1MYmc2TEU3L2hRbnVialRKcThxV0Ju?=
 =?utf-8?B?TG9wektXbktSMzVoL3dtUzlYK3Z1Z3ErdEZmS09tT1pZZzFzbXlaV1pxU1g5?=
 =?utf-8?B?QTdxTFViMk9OVGRML2V1SWp5eHduMXVMQnNhZnFRa0RJUHBDZnRQR1ZoR29m?=
 =?utf-8?B?bzJLb2tzSElmRmx2Njk2WGRFOWtTYlhvN3Vra1M0ell3eUk4VlBCSTY1N2c5?=
 =?utf-8?B?ejNZckRaaXFSRUZQTVZ6bzRDS09TdHRsM0VtMXZVbnM4dGhlU2JYcTMvRlRs?=
 =?utf-8?B?QklRZU5FdE1FNHBub0Q3SVpxSFlieW5FWEdNV1h5aG1NTTlHMm5Ud3lWaWc0?=
 =?utf-8?B?c0NZN2xKQXJnVVhWaDJDcnZwQmwvQXZiRnB1c2hyMEVlSEVKVTFLMUdKcTBI?=
 =?utf-8?B?ckdMeVp6OWUxQ1lhSUdKSzFtQjN0d2sra3BBbnFZb1cxSVViei80NW81SHNi?=
 =?utf-8?B?QktuYTg0UW1BRXI4dFE4ZVpZOUlkOUh4TWxURVRCdzNrODEybG5wU1dhaXBJ?=
 =?utf-8?B?Tktjak9NNC9vTTVCN1p6clBNZWovKzlsQXhFK0J5QXIvMU9NRGY2aXBPTklH?=
 =?utf-8?B?a0VBQVhmb20rKzRDcHhpSW56aEswbzZMRTZiU21oZDVsT1lVcVNCUUl4cUJM?=
 =?utf-8?B?WnNzS1hsZXYxRGRWandMVVAyckYxd004VWxrS0YxYlQ2L0F4aHNHV3BFeE56?=
 =?utf-8?B?bk0vM0hFWDZyd2EvZGFrdGRaaVQrWk11THo3czBmWE5adnJudkJpRmNpQXdE?=
 =?utf-8?B?NzJxYU1lWFhDZUhjaUFPU1RmaFBkd1ltS2VxTVpjQ0w4Q1hqTmlkd1lzOVN5?=
 =?utf-8?B?djZNa2k4Y0tPUllHcHN5S09rWnZlTXpINXVpQmhjcDZ0ZEtXRGRtVVBqc21H?=
 =?utf-8?B?akJYN2dvcCtsWGlrbjl3RlJJUVJ0dERFVW8rR0d0NXB3cDFrSkVMaEZtTWRu?=
 =?utf-8?B?a1pucGJ1QStQSFFWV1FFRzFQSjJmSGd5RjhlODN3MzVGZnZ0b2JWM1FlVEph?=
 =?utf-8?B?OWpRQzcvbFo5MU1jSnVIRllaUVN5YnlZMEVUMGhJOWRVWDNKaEJqRDQ3b1JB?=
 =?utf-8?B?emhlOVB6dVFKb1YxdUhHcVFyNkw0dmVqQmtqMlJxY2EydWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJKanplNG1YL2c5TjQwYnRHRWcvQ2dFMVlaNnNkUmlNTy9EQkxyRThKUU9J?=
 =?utf-8?B?dW1YMFh0WDQxNExiTngvRkN0YmtOd2RnMFlZNFV5d2tvdFArbWNJR2xqSnZC?=
 =?utf-8?B?bGFjTTdDMUJ4N1FOT2lJWmdDb084ZUtTQUd6WUIwQ2c5QkpRUFpESXNBdGJl?=
 =?utf-8?B?cHphK1cya2w5bUtoTUgxS0J0YWFReVVLMXRUbS9oZ0o0N290eFc5MkNaMWwz?=
 =?utf-8?B?VUh1eEtJcUpKcmZYVWc2RVJCcytPa20vNzRZd2M2bDFCVzQyY3pFTDFVMWZN?=
 =?utf-8?B?R09jMnFESGkwYWhmVFRBMmkyanFmd1Fkc3ZvZTVFNUlNRmN3eEFIWmFjOUVC?=
 =?utf-8?B?andHRUVPRjY5SmhSVUJrN1FLNjhoc3g5bysvaDlsOG1vcVhIRmNVODVzb2d6?=
 =?utf-8?B?WVNBRy9pQmwrWDN5TE13YmlFWVQyRGVxQTdJcGx0amhObUhpQkpKWWdvRHV1?=
 =?utf-8?B?OEl0cUxRYnRUaXhGdnNONHZoK1RZOUVnLzczMGk3RWJ2QVlMSkdKbHZQY2JD?=
 =?utf-8?B?a1UyQ2pITUF5SXZzWU4rT002WHpqZkNrTkEzNzNDVWpaTnRVMjhCaHRvbXow?=
 =?utf-8?B?VUYwYUpxOWQyd05CS0FldHAxQmRad0dSU2Jmc1JId3B1OW92L1NDelFrV2ZB?=
 =?utf-8?B?b1lPTFJXOTFQbmtZb2ZEYkdYUVFLd3JJTzZScWo1aHVSemY1RHArc3lJT3Vj?=
 =?utf-8?B?U3ZxK0tmY2pnK0pRTlM0L1NjZjU3VDZVbWtCa0lLQWljZUdWbHduTGJvQ3dO?=
 =?utf-8?B?RTJjcExXRklWNXlWVGVsRjdTL3FsemN1U3hzS0hraDYrSDlMb2ZMT0dSckZH?=
 =?utf-8?B?emRhVE0wSjZsM1lpN05uR0pHUmJmbXNzZUM1bWV4TEpsUTlFMjlvYmx0ZmR0?=
 =?utf-8?B?ZnZGOGNjSjVOQnlSU2dRKys2WCtoWjh6NlJpWU03N2k2SlBTOWVWYTByVHVH?=
 =?utf-8?B?cFY1Zy9HaFpkdGJtd2tGbmJMd29hd2phejljdms2aEV0N1hIbTEvbTAyd1VI?=
 =?utf-8?B?MVFFU2Q1MTRmRnpndFFoMWNnQ0wvTCtYckhEU1U2UUpuWTBVa2dlQkVDem91?=
 =?utf-8?B?SEoxc0VtM05WUTdkQzJPS0l5dkdJclFaVmUvaDRLb1F1WXNyUjFmZk5iTVI1?=
 =?utf-8?B?cU13b2I1dEx6WXJGTzVNQXlUdUxFNmM4eFJQMUUrK05RQzRpWHJhckV4Wi9N?=
 =?utf-8?B?NUltc2JGNGFEZlhuQ2tTL1pEbm1waWdIQjFqOHZjNDM1ZmdGOVBjVVFLRUtz?=
 =?utf-8?B?SGkwRmUvNDVmeWh3cGlrK0Q2aEpmL2YvQkQrb0VpYUZRaWo4ZGV4U2pCZjdw?=
 =?utf-8?B?ZmNkS2pHdnlidHI2UENVeHpVYXNhaDBLS3Q4Y0tJNkx5M0REKzdpS2dyak9w?=
 =?utf-8?B?RFJ2ckZNK0d5ZGpaMzNaMlNKNnYwV3VGWHYwWS9yMFpRNFV6azJrYUhrT09J?=
 =?utf-8?B?d0J2TFM0eHpwYVRqR2pZUGdaZ3p0d1llbWdSdHppOWRFNHUwcEV1ai9WWHlL?=
 =?utf-8?B?R0xPN3RZUWhjZ2NUNXpkTkNyT3pKdDhCMzNFMnV4MWlpb09rUytFOWVieTJj?=
 =?utf-8?B?MnNWN2hLazZKWDlsQjJZSnNPdE9SWko3d0RRRjVnVmZNVEd1ZEtHNGtzMmJh?=
 =?utf-8?B?SXJNOWR6UWJFdDFQcHB0SUpjNEh2c2ZHMFRxWG01YVVwYzFVbk9sbHlMOG9i?=
 =?utf-8?B?UCtpRFk1YWw0Vkkrd2NtbTZWc2tYaGozMFBKd2VFMWQvNlM5NFNaVHN5Y1Fj?=
 =?utf-8?B?dTd3YlA0N1pvcHNpQkpJSFJHV0kwMU4rU2ZKS1NWVDhUMGR4OVllc1N6a2E2?=
 =?utf-8?B?YkJuTUd6M0pReEswNFYrSXZLNVFVVHM0SFAzNlkyN2x1dWJuMnpTQzdYWVA2?=
 =?utf-8?B?dmkwQXVNdkV2OTBYdmFpckptbERiMXZRSnNOcVYyeG56aVR2WVB5OHdtYmx6?=
 =?utf-8?B?T3Y5bTNNdjM1KzVnQVJuY0hVamtTNHhXREIvendwREt3bkk2aHo3VFdXZFpW?=
 =?utf-8?B?VVRaMVhHbW9FVGt0RXRCYTBZRVNibTJiUFVvMDR4Wk9Vb3FQak9lWFNVdGlY?=
 =?utf-8?B?dUt5ZGRRVlV5dFdOYVhYODhSZU5XRWJURmNwbkduUExtanRvNlU1SHpNQmJR?=
 =?utf-8?Q?IcNWU2u4rd5Am5RXiOpaVjSz7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa90539-f621-45ec-9f65-08dde4eb94ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 21:57:42.0891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDFFarugU4aIvPb3BbcAtD5nPagh8P1K1GAHAiGcolX6jKoSowVDBAuQ55+dG6BhqM0Gax6e1GLMcXnOuK49wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

On 2025-08-26 17:20, Alex Deucher wrote:

> On Tue, Aug 26, 2025 at 5:11 PM David Wu <davidwu2@amd.com> wrote:
>> On 2025-08-26 16:58, Alex Deucher wrote:
>>
>> On Tue, Aug 26, 2025 at 3:48 PM David (Ming Qiang) Wu <David.Wu3@amd.com> wrote:
>>
>> to_amdgpu_fence() could return NULL pointer which needs
>> to be protected for dereferencing.
>>
>> I don't think any of these cases could ever be NULL.  The amdgpu_fence
>> is a container for the dma_fence so it will alway be present.  See
>> struct amdgpu_fence.
>>
>> hmmm... but - the function could return NULL based on base.ops - see below
>> if it should never happen then we should remove the checking. I doubt we
>> will ever return NULL, however someone knowledgeable PLEASE fix it properly.
>> The patch is only to protect it just in case.
> if you look at amdgpu_fence_emit() the fences will only be created
> with either amdgpu_job_fence_ops or amdgpu_fence_ops so there is no
> way it will be NULL.  It's a false positive.
My proposition is  there is no guarantee for future even though it is a 
false positive now as the original code is not
confident either about the condition should never met. I think there is 
no harm to protect it. Or better I can come up with
another patch to remove the checking - I feel keeping NULL without being 
handled is not acceptable (at least to silence
Coverity).
Alex - please suggest - either removing the checking or do nothing. I am 
fine either way.
David
> Alex
>
>> static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>>
>> {
>>      struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>>
>>      if (__f->base.ops == &amdgpu_fence_ops ||
>>          __f->base.ops == &amdgpu_job_fence_ops)
>>          return __f;
>>
>>      return NULL;
>> }
>>
>> Alex
>>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 2d58aefbd68a7..1432b64d379ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -160,7 +160,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>                  }
>>          }
>>
>> -       to_amdgpu_fence(fence)->start_timestamp = ktime_get();
>> +       am_fence = to_amdgpu_fence(fence);
>> +       if (am_fence)
>> +               am_fence->start_timestamp = ktime_get();
>>
>>          /* This function can't be called concurrently anyway, otherwise
>>           * emitting the fence would mess up the hardware ring buffer.
>> @@ -387,6 +389,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>          struct amdgpu_fence_driver *drv = &ring->fence_drv;
>>          struct dma_fence *fence;
>>          uint32_t last_seq, sync_seq;
>> +       struct amdgpu_fence *f;
>>
>>          last_seq = atomic_read(&ring->fence_drv.last_seq);
>>          sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
>> @@ -399,8 +402,8 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>          if (!fence)
>>                  return 0;
>>
>> -       return ktime_us_delta(ktime_get(),
>> -               to_amdgpu_fence(fence)->start_timestamp);
>> +       f = to_amdgpu_fence(fence);
>> +       return f ? ktime_us_delta(ktime_get(), f->start_timestamp) : 0;
>>   }
>>
>>   /**
>> @@ -417,13 +420,16 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
>>   {
>>          struct amdgpu_fence_driver *drv = &ring->fence_drv;
>>          struct dma_fence *fence;
>> +       struct amdgpu_fence *f;
>>
>>          seq &= drv->num_fences_mask;
>>          fence = drv->fences[seq];
>>          if (!fence)
>>                  return;
>>
>> -       to_amdgpu_fence(fence)->start_timestamp = timestamp;
>> +       f = to_amdgpu_fence(fence);
>> +       if (f)
>> +               f->start_timestamp = timestamp;
>>   }
>>
>>   /**
>> @@ -827,7 +833,8 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
>>
>>   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>   {
>> -       return (const char *)to_amdgpu_fence(f)->ring->name;
>> +       struct amdgpu_fence *am_f = to_amdgpu_fence(f);
>> +       return (const char *) (am_f ? am_f->ring->name : "");
>>   }
>>
>>   static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>> @@ -847,8 +854,9 @@ static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>>    */
>>   static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>   {
>> -       if (!timer_pending(&to_amdgpu_fence(f)->ring->fence_drv.fallback_timer))
>> -               amdgpu_fence_schedule_fallback(to_amdgpu_fence(f)->ring);
>> +       struct amdgpu_fence *am_f = to_amdgpu_fence(f);
>> +       if (am_f && !timer_pending(&am_f->ring->fence_drv.fallback_timer))
>> +               amdgpu_fence_schedule_fallback(am_f->ring);
>>
>>          return true;
>>   }
>> --
>> 2.43.0
>>
