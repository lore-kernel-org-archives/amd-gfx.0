Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD9CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 19:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0E110E31E;
	Tue,  4 Nov 2025 19:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gi9DhqMF";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B1510E31E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 19:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7eH7GoDNz6fv/4bhXla+UvAuYN7Bdj32S1OW68bU4h5W2cs0se37fDJGVpoRb8fJ/qhG2K57SVvtJeXrUY8Kr60T5QYgbRWGKLC7deAjOrrVhIDohJzZ6udMSdubyY2dmxRwAeLYdR3BLeenYsWMOeEYkPO/Wt82hKfV8NkNnuBD0Wt3GSeIJ36uu0ydNHQgMlFN44BljtOy++JYwkVKMF0N6Ls0Swa7pySaRuD5ZGRvsyqlTeQGb4RZLHJQXw/JyXzSrYPA8inHHYjCRjWXZar4SqDGU2QToWiRNAMR/bPPT2hnavQZ/MIH17NJ64pL8yr41EE7OJ3Vo/rwC1mJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRhUGz96EFoSddXdK7vC7EZWDflYcTdPf4b1JsRNDK0=;
 b=HeC09D8daoq/AvXz/0CckIDGj4d23fJ0i288HelRbs2ITAyn15dg564Jdf+R2lS6IcW6gtbLkxj2ODuC77s4RD/TlB+C5XX+erEcPCOovGbBSVVDmw+UMzLxjqWRvp+TK0rPQdksfLv5txV+Rxj01BJZhMbPFJhBq+Cz9EJKcoh7OvXXGue4YlvEE4gprA90x/JqLAAfCQ1Kd2GveLZWAeBILsgbZaFH3QV55zNNPUe4UbU4iRgqJhYPHGT08+X1PKSw2PWK/iCOzYMBrzUcYqbK3vKY+RBz4LGsF9HDi2uABhpyfsAhppIV2bzLOT4W/ePxlbct/mMRhs3QwTzVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRhUGz96EFoSddXdK7vC7EZWDflYcTdPf4b1JsRNDK0=;
 b=Gi9DhqMFloa33aGtvrHA55Rqs6tDIbHeMaYLIqOVL8Toyyzuj3zBJajp4c+s3M/yzwdeEP0700b1kBE+Mdiik+eTwX5p0G8//Wp3Ta5BR9Iv+OD0PRTExg2sA6yULBrTR4RkmmbwcwlFjGYiO+LH7xJx0NWlK5OnDOMC5AY1Bp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 19:07:06 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 19:07:06 +0000
Content-Type: multipart/alternative;
 boundary="------------sinC7NNb4nmD7qEDhwIoEVKr"
Message-ID: <041129c9-7c63-49af-b618-6265531f98f6@amd.com>
Date: Tue, 4 Nov 2025 14:07:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: need to unref bo
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com
References: <20251104163932.263193-1-David.Wu3@amd.com>
 <20251104163932.263193-2-David.Wu3@amd.com>
 <CADnq5_O2pf8w8NbK8QEhPDtFgqrhXsGPv4U_i-+Ov4UzLLUb9Q@mail.gmail.com>
 <d7569ba6-a915-45fb-b025-e9ab1047c616@amd.com>
 <CADnq5_NLi7Xyb=dTyNRSA0pVfN+Bdkx4LopHLebieNiXfem-bQ@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_NLi7Xyb=dTyNRSA0pVfN+Bdkx4LopHLebieNiXfem-bQ@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::16) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f4fa7f-7fbf-4485-ea58-08de1bd55889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnlHMjdtUFczQVdrcHdXK0FBL3NPMEZ2c1ZiVHFoeDdsVFgvUWY2cXlFMUY0?=
 =?utf-8?B?RnFUTU1XUjlpTFM0L29NL2h6WFh0N2xFYy9vcGdUekgySFhhWE5jK2d3S0hw?=
 =?utf-8?B?Qjl0VDVWdG9NQm0ra2Q2SzVIbHVYUCtGc0Q4aFRRWlNMK0YyWDBYbnk2NG9V?=
 =?utf-8?B?L2czSjZGNGNBZjJXMWJlTHZueFRTVkRPRHloalZyNGEyK1RJOCt6bXFsRmRm?=
 =?utf-8?B?SW1mRmZnWjJnM0tHajZkRkhYdmFsRGRYbE52cGNDdGFlZTY2REhJYzE4bUNB?=
 =?utf-8?B?YXMwckxXYUdiUkZIa3dXUDFuZEIva0cxZDNtSUR5RFZreTRmMk15UGdVTHgz?=
 =?utf-8?B?cVViRy92Sk5UL0t3dHZsY1JMYjk2SisrLzVzUWxNNUU0TnZWSlhLQVYwM003?=
 =?utf-8?B?dkFwTGVYM0J2bmNOVDdqQUk5NnRTQ3dIb24vYVFjSGNlQ0gyN1pYcE43dUN2?=
 =?utf-8?B?SW8zTkFaS0ppNFAyeEJEeW1nOCtlYm8ycmp0dW9tKzBVY2tDajJ2b054SHNW?=
 =?utf-8?B?bEYxU1ZKNEp1d2IzUlc4L1NrSnpRU1pnYXo1M1hiRXZqaFZjTUphVlRVQWo4?=
 =?utf-8?B?Q0VXZkQ3Vm53RUZYS3lXNllaRW1vd3l5RkV2QTBBaVhUYW9qbnhnaldLUzdz?=
 =?utf-8?B?dUY4OW5BeTREUWNFOEN5K3V0NGRUbnY1bHpDWmV1dERuc21sQnB3ZzdzMDFX?=
 =?utf-8?B?UFh3d20rRlUrWW9GQjFpcktleERweGVtMlV2MUR2WTJrbjNVdDhQUkRraG1V?=
 =?utf-8?B?R3VvZGpuYk53cTNJUWFqbjFzenpVKzFXTHIrcUFjS1dXZ29wc3ptWVNraU5i?=
 =?utf-8?B?eWIyS3lPV2tZWkxJNHVRUVFwVy9QeDlJTHEwcjh1U0VYVXBNK1pEQWhGSzdi?=
 =?utf-8?B?Zzh2OXhJUm13bFNCNFZCczhqSzBjT1JhZUNSeEc5enp6RTFIR0hkWS91RWdk?=
 =?utf-8?B?dmxmWUdUQkl0M3dsSXZySW1vSnJhbWhkb29VczQzZzN0SWp0T3hRNkhneXBX?=
 =?utf-8?B?MVZuYWFHSkxSVXlRakRweStpNmpSY3kvUFM5WWhJc1VydDZHd1B5MXZxM0N2?=
 =?utf-8?B?Nk1naTI1azd2VnFUNW1tZXExdmt5T0xDN09HTm9WSXQ2bzdUeHhDK0FXQk5i?=
 =?utf-8?B?Qy9FSmd3dHpuaWR5K2lIOWxkalliMlRSNXZxejN2dHNVaU1QNFh5b1RZd1Zw?=
 =?utf-8?B?R0cvVVd0UW9ybWh0TzdBbUVWVWI0S3ovVHVSVXV1SFFtcGVRamphTm9PMmFP?=
 =?utf-8?B?NHJPWXJTazhIbkNtYWthYm13aE5oRnJabGRrRDE3TGUyQWJJTGk3alJBWllX?=
 =?utf-8?B?S3FxZk9DSitmZmtXQzZmMUZhT2RKZnNnOVZBRTFRMFZpd0Z0RTZtTVlsR3dK?=
 =?utf-8?B?cUs2V0VPbkVuVHdDOXhobHB2T1dhVHgxWWVhZDRUdmZveE9pcGNrSWtUSCtJ?=
 =?utf-8?B?dEI3NUM3T3YrY3lIT1EraHRqNElxMFJzclBnVVJ4TTZ2b0Y0OURqcEpMK2Y2?=
 =?utf-8?B?ZjNDZk9WRVVWbUVVbVp0N0VnOXk5OXhkcVZIM1I1eUtjK0p6TW5xTkpETnRC?=
 =?utf-8?B?bXcwc0RTcy9iRU1HMklSOVF1aVdTTGhOSlFhTkJrUXVJdEhlZkFna1JsN0s4?=
 =?utf-8?B?RDdoQndBTXU0bURRU2Q1UHJVQStLeG5XMVFPd1FjUVUzZkh6WEpDaldCY0F0?=
 =?utf-8?B?L202NDVMWjdjL2RVeGFmMDZtSFJPaUd3QTRUellnZHNSTk51SGphTDBKQVRk?=
 =?utf-8?B?UEwreVhrenBhZVNLYUUyWmtEVHBRQ3RtOHA2MXc5OUprNHBVdytmdkk0cFVz?=
 =?utf-8?B?bXQ0ZVIrRWtCRW4rNmFJVXRrMDBXZUU4eGtuay9wTE9xWE1rMmdJK05nbDY0?=
 =?utf-8?B?MHp0cTd5aGkraWZ6dVZaZXVBU3hCa2czZXFXaGx0enBlY1pTNEZJZFViYmVi?=
 =?utf-8?Q?p7IhuyIAGADYC7dOr4gq+8UFM15EgtH6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZmeFdRWmFWMDhTS2hVWUUrSml5TkNYdXhzWEYzYXg1YWZUZTQ3OXBaQStO?=
 =?utf-8?B?NzhrL0RNcEpxVmFCaXR2ZngwRW9ENHlQaUM4SWdqWjUwUkRxOU41ZHhBeTd6?=
 =?utf-8?B?MU04eUtrdGdlSG1iV2ZJMmxGUkZRZEF6MndVOEd5Nmc4S0xJVWZvS0JhUFI0?=
 =?utf-8?B?YlJUbThhM2E3NGQzejdYN3NaaU1rblFmTm9EZHYrOWFpVHpLQ2F2dVBwU0dW?=
 =?utf-8?B?aVdZTzhSUnVKQzJSUkhFT3ByZ2p6azU4ckdWY2lBVGJZMnZ0SFM3ZVYwUFBn?=
 =?utf-8?B?TnJZTkZzVEVjVG1QTW5OSWw2d1dLVmV6QUFzL3FkZFFtOWJ4N0pnSnNESUhQ?=
 =?utf-8?B?aTNVck15bXVuRmo1QzJBdkIvdkl5T3UzbmNjTmZ2Ym5WYXRCOW5YUjhvOGpl?=
 =?utf-8?B?emlVUWNsOFBQWDJtZGhvRHBUUWVvUmdNeG5od1VERGNhYU5HRTFzZVl1V1kz?=
 =?utf-8?B?NVJCbUlSanJIKzA5OG8zNlhKN3NBUzJLYlhSNy9LbytmLzc3TUlJT2U5bmNC?=
 =?utf-8?B?cU5KRGd2YWlUL3V3WTF4ZVB5Z1pOcm1LK04zajdJblFhNk16Slp2NElHRWd0?=
 =?utf-8?B?L29HVllvdmljSmhFdkM4L1owa2lrS25rcnlYSkpyWCs5bWhuMjJTOGtSdi95?=
 =?utf-8?B?Z1FUdVJhZzlVWDd5eGdya3k0UHkvbk9Yb1NiTFRlYW9Kc1JGaGs3NDIzNnhN?=
 =?utf-8?B?amtTYlVBVmgwSHl2OU13R3pXSG5WV2NUeVpNVGlReWRWZ3JZOWNkd1gvc1BV?=
 =?utf-8?B?d3VkSm0wM21TYTUrZWNtbUw2MnlCK2VIb25mRzZGUnQwOVBvR2VpbXYvUVkw?=
 =?utf-8?B?dTVFaWFNVlBoRG9QY2pSUmxmWmdvSFlpaEtydkNGdzdoNU5Md3NOYVZPdVlp?=
 =?utf-8?B?MDNoSWN1cGk1NThtQnZNMlpQcTBHdGIyWUFvSTFvQXd5STdmL2ZIaTBsZXdH?=
 =?utf-8?B?VXlnT3JOTHIwNE1XdHVjNS9iTTk1OUlnNGFLMTg3L0F6VFo3SzJqeURCRkN5?=
 =?utf-8?B?RUNwKytEbFh5TTRlRmphTEZmQVYxVjBUWDJyU25iZGNBK1g2UCttcC9JWmNI?=
 =?utf-8?B?Z0ZmNHU2WDkzTTNXRGhRWGx4K2dGTnJ4NXRwTkJmY1o0UHo2My9MK0pYTXdH?=
 =?utf-8?B?cTFLT0pzR1lCeDMyY1Vpc255SnFob2I0b0dOVTdFUVZDMi80ZEVzV3lKOTVj?=
 =?utf-8?B?QXNrd0RJTGovSHZLQVdEcnpsME9jVUpJekY2eXRUQmxZd1E4ZWR2ai9GVHVK?=
 =?utf-8?B?akZsc0s3Tk5YUnBlMmtyekhCVVJSSGFiQlhjNUxDbDl2QUZBRjYrRSs3dGV3?=
 =?utf-8?B?Z25PQkUwTVQ4WDJ6eTFoR01FdnBQdS9TSlQ2MlJRZ1dvRG1sYXkxUDMwR28w?=
 =?utf-8?B?UGM2ZzBhTGNETDUvUDlNdE14VFV2OWRRbk9WOEtxamFUVU5XNTBrR25GQ04y?=
 =?utf-8?B?Y3ZrMGN1SUpXS0NjeWM2N2cwTHJDemxRUXMvYWJKSVM0NksvZzByMlpCVU1P?=
 =?utf-8?B?bGUwellucUxIQXorUjl4VExuK0hDRUlVaER1elNScmFCUG0wWC9xMUxPdkNW?=
 =?utf-8?B?dGlMS1lRNG9QcVh2K1ZoelJjTU1mMGlGVmFQeFBBbVpyL1R5czdZQXhUNmRw?=
 =?utf-8?B?ZXhpdjVyYTFKUjAyRTNqaFY3K1A2aTBCRzBTM0NialJTTGo1SG81YW1Za1BR?=
 =?utf-8?B?RVpkeHM5U0ZlcGRtZFdURjRlYjVNQkRyVms1TmxqSGwza2JPb3VPcjZTT2tj?=
 =?utf-8?B?YjY1YVFVRWlpT3lidDdYbXorZGVBYVhmN2ZRYzhhNTM0ZEZLTEZyUEpmKzFP?=
 =?utf-8?B?ZmNDMlZnd3lleTUyV1htS1BHWlB3cTYzbXVVUzloMHRmeTV2REtLamRFTG50?=
 =?utf-8?B?RWdEZnpka0VJUDNKbCtHUDNNRUJvdUYvdzNZb0JSd3h4MlBjM0pGbE1oMDVs?=
 =?utf-8?B?c3BkQ1lQZnR0Z1cwWGNaTDQ4WmpOaXNqOElOS05zY1ZLSFcxSUdYcUUrZXNi?=
 =?utf-8?B?U2F6VUpDQjkwMWtkN2R0L1B0OW12L3dBSFVGZFI3RFE0SFhyd0I3MXpIeE54?=
 =?utf-8?B?b2xVL0NNY2k3cTZkNVNQQWVNN29jZm8yTGtFWWwzRm9tWHg4MDJjZjVkbmY2?=
 =?utf-8?Q?uVIi/zncZ/clOwwhhMkowpShV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f4fa7f-7fbf-4485-ea58-08de1bd55889
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:07:06.2572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF/sk/Tmc/O2yNecwqXohIL91M2hbUGCxlHnEYQqiT/F6kS4Nsge3YuvUH+KYA6PJoXcKeD15uoHKq9iN3GE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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

--------------sinC7NNb4nmD7qEDhwIoEVKr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

no worries - also fix the typo ( amdgpu_bo_unreserve -> 
amdgpu_bo_reserve). Thanks for review.

David

On 2025-11-04 13:56, Alex Deucher wrote:
> On Tue, Nov 4, 2025 at 1:52 PM David Wu<davidwu2@amd.com> wrote:
>> On 2025-11-04 12:06, Alex Deucher wrote:
>>> On Tue, Nov 4, 2025 at 11:46 AM David (Ming Qiang) Wu<David.Wu3@amd.com> wrote:
>>>> unref bo after amdgpu_bo_unreserve() failure as it has
>>>> called amdgpu_bo_ref() already
>>> The other error paths need to be fixed as well.
>> hmm... do you mean "map_error"? it has the amdgpu_bo_unref() already.
> whoops, yes, sorry.
>
> Reviewed-by: Alex Deucher<alexander.deucher@amd.com>
>
>> David
>>
>>> Alex
>>>
>>>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 2aeeaa954882..99ae1d19b751 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -386,6 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
>>>>           amdgpu_bo_unreserve(queue->vm->root.bo);
>>>>           r = amdgpu_bo_reserve(bo, true);
>>>>           if (r) {
>>>> +               amdgpu_bo_unref(&bo);
>>>>                   DRM_ERROR("Failed to reserve userqueue wptr bo");
>>>>                   return r;
>>>>           }
>>>> --
>>>> 2.43.0
>>>>
--------------sinC7NNb4nmD7qEDhwIoEVKr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>no worries - also fix the typo (&nbsp;<span style="white-space: pre-wrap">amdgpu_bo_unreserve -&gt; </span><span style="white-space: pre-wrap">amdgpu_bo_reserve). Thanks for review.</span></p>
    <p><span style="white-space: pre-wrap">David</span></p>
    <div class="moz-cite-prefix">On 2025-11-04 13:56, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_NLi7Xyb=dTyNRSA0pVfN+Bdkx4LopHLebieNiXfem-bQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Tue, Nov 4, 2025 at 1:52 PM David Wu <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com">&lt;davidwu2@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 2025-11-04 12:06, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Tue, Nov 4, 2025 at 11:46 AM David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">unref bo after amdgpu_bo_unreserve() failure as it has
called amdgpu_bo_ref() already
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">The other error paths need to be fixed as well.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
hmm... do you mean &quot;map_error&quot;? it has the amdgpu_bo_unref() already.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
whoops, yes, sorry.

Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
David

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Alex

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2aeeaa954882..99ae1d19b751 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -386,6 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
         amdgpu_bo_unreserve(queue-&gt;vm-&gt;root.bo);
         r = amdgpu_bo_reserve(bo, true);
         if (r) {
+               amdgpu_bo_unref(&amp;bo);
                 DRM_ERROR(&quot;Failed to reserve userqueue wptr bo&quot;);
                 return r;
         }
--
2.43.0

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------sinC7NNb4nmD7qEDhwIoEVKr--
