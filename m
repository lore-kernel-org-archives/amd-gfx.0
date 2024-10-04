Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F88ACF8843
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 14:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229FF10E0B9;
	Fri,  4 Oct 2024 14:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VRkaCKau";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABEA710E0B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 14:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hECrAUREqZAm1o1AnKEAUfRxtZTNAFK/xANO/vMYe8cuq07qIpuP+ovTI62ye2WApk4bROcOD91vEhqIdph3c3Zxy094yZ1KDu4SevriMBvBHJbGBUHb0mnh5SHZ0ie3pf3+3rZI3ZtECl0OApiS0cvQS45bIfRQQfnWJxEkSie4cuhvdDtb+UyzwCakMQqUlAzMs5ml1KPXTUEsYIcEI3JdG7vbJt5LVJhM2ODky+bSS5HKh5K01vCM4iDipUHU14sPO353ocSNwK9CNp0d+o3OKinDnJDGrr4CG9NK0/BK3DU2Z1wPWtA0uBF4RWFR/Fyjs9CokTxVkjZTdfTmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Ry3RthtM/0Swj1GSkLVxgMyZxtopRUdNHcmr4Q9uc=;
 b=eLBh29t9fZGLddsOX2QvXweiEbN0eojYhbY65qlPbafkkkkdj5OzcIjx8lenAjmahYtN1ToKRhMKcy2UR+0tDfpA7tMei8wwk2p5JRosGp/bDtUvRAkBBrK2hInj6pJUxQBvhixrIiHt96JW0avwsAm+06juxu3woOjpOLELO8GM0wzTl9450OvDPu1hudePazyV/P+p33eGZA/ia5PXIzwOJ+IRVgKAstQqcreFJBqMO8eZv3U/ZCkA6aSMUbGt+QPYCS2UXv5O7aRaUPtlLllLrjr7k/YAxqLmnOaQ1mbWR+6nR3JA93NENmYFqjJwtCiEi7qHlaSuZirJZmOjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Ry3RthtM/0Swj1GSkLVxgMyZxtopRUdNHcmr4Q9uc=;
 b=VRkaCKauRgz/vNImtCQeXt4f6Y3cLWcZWOWW0mH/ZKnMo6bj/C03kdP9SVRUCvq+hqRHvHMMTC1nAj2mK8u00j4A/c4YqVSfyRrM59N3mZ5otXsiUuTOLQERJPcL7HdRajvZaLDoDUOhYjG755TbERrRUNv0EdF0RJllrpK31QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 14:46:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 14:46:05 +0000
Message-ID: <643e7a9a-4c6b-44ed-9c70-8f44aca552f9@amd.com>
Date: Fri, 4 Oct 2024 10:46:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>
References: <20241003205526.35748-1-xiaogang.chen@amd.com>
 <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
 <0e3ffe8d-da8d-4932-99f8-8241d17573f6@amd.com>
 <BL1PR12MB5898A00B1AAFFE27CEBB6FC685722@BL1PR12MB5898.namprd12.prod.outlook.com>
 <BL1PR12MB5898C4E23831524B7A8F132285722@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BL1PR12MB5898C4E23831524B7A8F132285722@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::23)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 512cb6c1-dd80-450e-e38c-08dce4834684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTBBZUQvOTlCNU9EY2lPNURncTNTQ0d1M2NxVG8rb1NRTUJzcVBhbDMvd0pE?=
 =?utf-8?B?c0pFdUtuS3drajNXTVI1UDVSZlJnZ2k5WkYwZHIrTzg3eGVIT05zUHI5THZJ?=
 =?utf-8?B?UmN5QVJrcWNjNlpMSkRmempsZnZXLzRzSjU5VSsrc2h6VlNBQ1ora0RYTWVJ?=
 =?utf-8?B?ZVZlZUtQN0RNb004cXFiWHZSSGxMQ0kwZEh1dDNYdkYrYURQYjAvSHhsbWor?=
 =?utf-8?B?eVpaRWxYR0dJbm5ZSmExTVhqekVySVhwQ2dTYWF1aS9uU3Y0N2xiMDNiejFF?=
 =?utf-8?B?Q2VwYmZoV2hIQ3Z3RzlKS1M1d2xWelBkU0R0U0V6SmtQTTJBazB5N0Y2SGdq?=
 =?utf-8?B?MjJsdjFCdEhmN2J4MVZuYUZ0OEpTUWZpbzBxUmxkQ2c0TkJIM2Y0UDJEMkl4?=
 =?utf-8?B?bFUrNkZKMGM4d2pXcEJMNmNTU1RrODIveUk1QjRvTmRZQ3J4OGZFamZQMnEv?=
 =?utf-8?B?TkxKMGNRZ3lmZUplRlR6dGpURVJmWG5yMEV1OGlxQTNMK1Y3OFZOTkM3VmdP?=
 =?utf-8?B?SEloREU1bHE4SHBpbGhKaFpLSlFhQXZlQWQrK2JlYmtCMExYRVIrR2JwTVFS?=
 =?utf-8?B?NWZDQlFhSnFMcVN0bVdPaE4xT3VuQUtjdXZrN2FGTE1WUFZNWWQxRnlVMDg2?=
 =?utf-8?B?aWVxcmgxQnpQL3MwNHVvL2VFTjlnQTkxT3lhcEo2Y0hpZmtRSUszK1luZU1G?=
 =?utf-8?B?YUVYRzdrZ2ZoSmVhQVNqYnQ3N1krbE1OZDB0Slo1WUc5bDE1WnpWN1RwcEsw?=
 =?utf-8?B?UUFuWlY5SWJMV2thcHNOTE9VQnY3NmxEVFBOTGdsZSsrOHZWb2x3Rmt4aWt2?=
 =?utf-8?B?cHBRU2hQRkhrZFN5NmZsc1Vxem42OG8xTEc1R0NqaXB3WloxaXZUT1dyand1?=
 =?utf-8?B?L3hIMnl4RzdldE00aU9lQ2xTcmFySlNHeVJlZ0Z1UlpSdnFxM1VUWFQ0QXRl?=
 =?utf-8?B?MlE3cnVHdG9DaWNlb3BVdVJCZFI1Tzc4aVh2TWs0MHNpZzJVR2dqM3lyTVl4?=
 =?utf-8?B?UkphTDJEM0o1YnpJMVJKbzhzemkzSm9zZmo1UHlCUU1SVXhxeTlKbFFaVmZr?=
 =?utf-8?B?bk05ZlVSRzRaOHpuRTVMeTZwdzFxWlNzTTQya2NnS0NYRXhGMGJBWjI1UCtM?=
 =?utf-8?B?UzZSSjEwTmxtUDZ6Q3hMOC9IWDlTekhFclR4RGxlUk45UjVYeDl6dVFaTFJ4?=
 =?utf-8?B?N3ZUM3VHSU5hTjI0U3pWdWRIZVpVcnBQTXk1amVNcDBpby9OM0o0SjF6cnlh?=
 =?utf-8?B?MlFTYkpvV1NOOGRYL2g3RHFIZGNtOVFGaVdYejhrVWN6MDNLZXVjb0Z4Ly85?=
 =?utf-8?B?U2VFQTB3MmMwbnFxSjdhS0VMREUzNWFzaERVWjN6V2hIMnJEcFBCeWFmblho?=
 =?utf-8?B?NEtqVCtEWXNBbXVRRGZ3cFFxbXFuS0c2ZFpwaVRQSWczMVVqaTRVdTJmUlZD?=
 =?utf-8?B?OCtId2pHN3hVYWF0bjlEb3lkMFJmNDdIaHBNT280SnppTUpvcC9MRDIxN3U0?=
 =?utf-8?B?aDU2LzVSeFZXOTNncE5NcmVQQ2gyY2ZjNmN4OVB0c0Q0aXVKdUxpMFdBcFFm?=
 =?utf-8?B?MGlZaTZVdXVUVWNieUkvQ1pNaS94cnZNNHc3K3BmQzQ0aERqT2xHUkY1YXpH?=
 =?utf-8?B?R0ZnOTgzS0d4RlJLN2ZCTGluVzJWKy83bXF2L2FydlZtRS9zeGxWQWtucWpi?=
 =?utf-8?B?YTNRQi9YZ3Mra2tVaHdRM2hFcTEvWkh4aTdQekRVQVJ0SXRZZWFQTHNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZOaTVqSmkvV1FQWjNzN3pzR3djWHdBMm51cE5ydXFvbzMzb0lYUktMZXRy?=
 =?utf-8?B?RHdjcnhVU1B5YUlEb3ZYS3ZPdmdPOE5JU2kxMFNLVUFaTnpEdStLcGtJQlhY?=
 =?utf-8?B?TTB2YkRpMXN5T3F2SmwxYm5uK0JsbWxhdEhTUTZvZHIrMXRWR2dYV1VkbFJD?=
 =?utf-8?B?bjJlZGQvWHY2UCtrZ09KOWZPT2lncW84dys5VlZZWWZtUlRHQWl4T1N0TTlI?=
 =?utf-8?B?a2gzZ3dQV2RJRFE5Z3R3VzlyUmNwMUhReFZCMHM2TmtEWmwxMjZkVm15UHcy?=
 =?utf-8?B?QnF2VHF4ZlkxVHRYd0tXL2c0WG11SFNBdlBKMDFwNWFQMHZyL1lSVUhIcUda?=
 =?utf-8?B?VjdBNkdrdHVmdVpLd21Kd0JYdDhCT2ZXanFINmM2WTZvaU8ybGhuaU1HbFY5?=
 =?utf-8?B?c3kyTnh5VVJOZDFYeTVsU09SR1FEejgwOGozWXZxNFJnSTZLUVBFcWFLK3hM?=
 =?utf-8?B?NjlNVkZRUjFnMmxnbDFGSHJGM3JJN2F0bDhXRXM0OEZJV2tHV1gvRXB0L3Ar?=
 =?utf-8?B?THdpdzlMOXFIMU85ZWl6SFhlL0srNnJvbWFlbkdoRGlqUGErNG5CTWszZHM1?=
 =?utf-8?B?OExZMmxRaEFHVFFoUkZWakJORURGbmcvTVRJSkRqbHFGZjNUcFc3VWdHTGFU?=
 =?utf-8?B?SlRSaVZBSVBQRWFWbHhyeWM5OVpTb2ozWlBaNUt0TEF1Q0xWcStXcjJoK1gz?=
 =?utf-8?B?WEVtYkwvOUpMc2NNYzMySHFXSUladWR0cUZKZERKU0h2NUZRL0xpOWRyaDdG?=
 =?utf-8?B?dW5BN2c0ZzM5VjRHeitxMmlVc2hWRStLdXUwaWxXRDZrN3VobGs5a2Y1MmR1?=
 =?utf-8?B?NDQ1eTg4NnAzNUg0b2tnWHJzYTc3bVE0L0VjQURHMGIrdUFsLzdiWEFhZG9z?=
 =?utf-8?B?VjFEWDhLRjB1NHY0RHhFbG8rbjNZYmNkK1hUVVRWbTdNUUxlS2xmV1A2dVli?=
 =?utf-8?B?NTlxRVc4ak0veVZ1YjV1YnR1UWpuODRZSzcvQ29RQzFHeXExbUZTVlBMcFhW?=
 =?utf-8?B?VFJYTnZNakpRMUNRRE9JT3o1UFhwUnc4TG1JaHdSK1Z4TGFBOXlaSE1qMkJ2?=
 =?utf-8?B?Y3RkSHpFbThnclQvRFVYNE9acE85QUw0TG9hV2FSNWk1WDFJT3dJM21pSENY?=
 =?utf-8?B?SW9rckJCV3lOQjBRZDl5YXI0NFE4TFcxY0oza1ZYc2MxWDNlUG5IbjJ6TmhT?=
 =?utf-8?B?RkZndERiNGZ5UlVJV2ROMHpMMEk5a0F0dURhK21FbC9IYmZWQUxldFpGZmU4?=
 =?utf-8?B?NzBXbnROOXQ2MDdReHgxdGpsNTdVb1oxc1UxamN6NHk1ZFo2VVBlUVpoVzNK?=
 =?utf-8?B?K1hzVE9UOXpJa1lCVW1LNkdCVTZKditVRmxWN3VqOU0wUW1WclBWUkMyMXpw?=
 =?utf-8?B?djlseUMveTRSaWloWWVGOTgrYndETWFzMThIUnBmZk1qU0xXemoyTy90azN4?=
 =?utf-8?B?SEc0cWh0UW5mbmdkS2JtZlBlYWVOeDFRWG45OTBVRlR4THZjV1I5YWJNelJ1?=
 =?utf-8?B?aUlYbUZvcUNXa1VxcmwwLzE4YXY3dXJTZ24rOWdXUHlkYWlZbWY0cVlVc0xC?=
 =?utf-8?B?YXZHOSs4UDdBWlJMS2pPKzBkZEZvQ2VxRXg0RGFUdHZXeGdRTTc0dlZFNmVj?=
 =?utf-8?B?cVFGSUdKTExkMkZGSHRJMG9nZ0VqRnpvUHJUVVFuMU1qblJXc2F6aTNna1g3?=
 =?utf-8?B?Nnd5bXdwTVNlVWhZY2xLYVR4TEcvWEFoSi9MNlFOTCszQ1VYRTdwbU9OTXMw?=
 =?utf-8?B?N1BvZHVJWGVEejNNWDlUL0poOWY0QkpkU25EdEU3TllyREw2MU9Ianp0djBZ?=
 =?utf-8?B?WXk4TXVFbmpOUzBCZ1FWSzRidnBVM2dEQ0t0dFJ1bDExa1lUVW40QkZ3cmFi?=
 =?utf-8?B?L25YWkZxQTJlK2s2S0t0RUV1UG9URmdVVldFUDhvbEpRd0wwY2xObGRuUWNP?=
 =?utf-8?B?S3gxUjBVL2RFUXhVdk9ITVltTGR2bFJ1d0RTMjJIQ3BmREJEVG1JYkJ3dlRx?=
 =?utf-8?B?dDduSDJDYTJoM3FuZkxTbUtZMGd2WXdtMk1ZbUZyNDJ3azFnbEluZWVQckND?=
 =?utf-8?B?K0U5ZGJJcjJwUnE0U0xnVVBQUUQ5WURJdEVvY0VXRXlQMjgzRXh4VzNFME9Y?=
 =?utf-8?Q?RqHL3H5Jk7nWeq5jHmqFBQy7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512cb6c1-dd80-450e-e38c-08dce4834684
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:46:05.6469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OKZUfHI2LHkoqo0SIMrtkHVpo/PXGAA2KFT7srdd5ucSf1YiaMPrtit97n8RCJ4dt3h/s8YFmBsyFFh/5PW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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



On 2024-10-04 10:39, Russell, Kent wrote:
> [Public]
> 
> My mistake.
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell,
>> Kent
>> Sent: Friday, October 4, 2024 9:53 AM
>> To: Chen, Xiaogang <Xiaogang.Chen@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Yang, Philip <Philip.Yang@amd.com>
>> Subject: RE: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process has
>> been removed
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen,
>>> Xiaogang
>>> Sent: Thursday, October 3, 2024 6:11 PM
>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Yang, Philip <Philip.Yang@amd.com>
>>> Subject: Re: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process has
>>> been removed
>>>
>>>
>>> On 10/3/2024 4:11 PM, Felix Kuehling wrote:
>>>>
>>>> On 2024-10-03 16:55, Xiaogang.Chen wrote:
>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>
>>>>> When kfd process has been terminated not restore userptr buffer after
>>>>> mmu notifier invalidates a range.
>>>>>
>>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>>>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index ce5ca304dba9..1df0926b63b3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct
>>>>> mmu_interval_notifier *mni,
>>>>>           /* First eviction, stop the queues */
>>>>>           r = kgd2kfd_quiesce_mm(mni->mm,
>>>>>                          KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>>>>> -        if (r)
>>>>> +
>>>>> +        if (r && r != -ESRCH)
>>>>>               pr_err("Failed to quiesce KFD\n");
>>>>> -        queue_delayed_work(system_freezable_wq,
>>>>> -            &process_info->restore_userptr_work,
>>>>> -            msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>>>> +
>>>>> +        if (!r || r != -ESRCH) {
>>>>
>>>> This condition is always true.
>>>>
>>> so sure why this condition is always true?  kgd2kfd_quiesce_mm can
>>> return -ESRCH when it cannot find kfd process correspondent to mni->mm,
>>> then above checking will be false, then will not queue restore work item
>>> into system_freezable_wq.
>>
>> If you expand the 2 conditions, it becomes "if (r !=0 || r != -3)", which will always be
>> true for any value of r.
>>
> I got this wrong. So it's either r==0 or r==-3 (I need some caffeine). The function returns things back up from evict_queues, mqd_destroy, and can eventually return EIO or ETIME in the hqd_destroy function, so r can indeed be different values than 0/-3. Sorry for my confusion here.

It's (r == 0 || r != -3). So yeah, I was wrong, it's not always true. But it's still confusing because (r == 0) is redundant. I guess you could just write

	if (r != -ESRCH) {
		...
	}

I don't know if that matches your intention.

Regards,
  Felix

> 
>  Kent
> 
>>  Kent
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>> + queue_delayed_work(system_freezable_wq,
>>>>> +                &process_info->restore_userptr_work,
>>>>> + msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>>>> +        }
>>>>>       }
>>>>>       mutex_unlock(&process_info->notifier_lock);
