Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0AEC28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EA410E726;
	Wed, 12 Mar 2025 08:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aTbsej21";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498A210E726
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCuvsGoKR+TcLKzz83NtgzuZezPKkdp2JLPy6M0+k9YgOoFMuh4AkUPTJQHdjnzkL2shpGJ3GU6ejYXO/8ij3A9MXnTSYzdZVhnhdkcHn1CLqkgW9oMsjEgrgxFrqcZ/XVuHmOLz7Lz8yaCGgRtlkiQ0JBRXiTIboAU2y9qN5rc/f6SW0iILWf/FfAc7aZ3fsZ5p4wtiBYDaSlinrMJboTNmJvxCSFXeoUCRdxRvumn/IVnEBQnRIvkBUomutgrqrVflBpdGddSv7fUDbsU0Pi6eKrHEwBdVydhFkUGSKABlUQBBKfSweq22lFcZwYtZ8X9bnoY4Ql6kEP+/k2HyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3mJ+V2jfdgUtA4QryR2XicRxjPpBSqELvb7Sj/PncM=;
 b=jZGBdolJH8e6p8AowldYd3dMArSplMng9AsGTRh5YK4TZdGjTNjvVDtxrj2VYh/HwcH6CCpTg7jOw9jFer48Ce1m2i9Ue1ngmEPv8FmO1EldnhIACpMYbqZfWTz4UVrcJgy90bkXlegWEcqpJmrKRPJKvV0tJChpshX5ZX1tBINnIddep1+anb0lTAwBfzmRcKZRm0IYgiH7/CiWDsUwI+Gn8whXId2sGUIQ8Gx23g4ILdCrn42rQEQjiFQUfDQMcR1cwwSsRYnkBICci9FkitQPx+EwbYazW09FdNBPNT1pOD0Lnr7l49qggFlGSCTNGOytbRLzEYDi+RMbAbGezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3mJ+V2jfdgUtA4QryR2XicRxjPpBSqELvb7Sj/PncM=;
 b=aTbsej21BgeYDOIMaAeo3INR+bddnuKBUg+l5AFvmeAs2VfMQtGCpWmDEFUq7vxiD3Rxe3F3EQQZyPnx1P1GUybxEoOYLvfL78QnRqKnu8SLFvWLmG3wVgIiJBb4CI5LCXfFifxroXWA24QaTzxCyqokA/lnSVHYIMUnReIqfKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:06:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:06:38 +0000
Message-ID: <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
Date: Wed, 12 Mar 2025 09:06:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9694a0a7-e2ef-4cfd-139a-08dd613cd046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTFkNkpoWjVEajJIMEtyZkJPUitjajh4V1hWM2E1ODFvUjlWSkk0ZWw0VVYw?=
 =?utf-8?B?NUpwNC9xTU94NnB1c3V6dzhXSEpZMi8vZE50cmlIVER1U2tXL2lCN25JNUNl?=
 =?utf-8?B?M0FuelFCS0xjQW5NV0JZTU40dk01RVRTYUhWakF1R1NlRGxMM2FKS1J0RC9x?=
 =?utf-8?B?RkthcEtXN0pvVGwvNTNCMENCVkJWL3ErcXoyRmk0TjFmTGl6OHErRzhiY01F?=
 =?utf-8?B?TmlQSVZucTFyRE9FSWllTm1RZ2FLLzRsbTcvK21INUh1cFkvZDM0cVgzcjN1?=
 =?utf-8?B?MWoydXZxb0s4VUxhYlEwaHR0WkZuNVNJTEdkRjhSTm1PY0twekwrbEVEMFVB?=
 =?utf-8?B?VEVCejYweUpoelg4Z3UrUy9VZmhDODFWcWpERTJWTVFBdVJMNTQ1YlZraDBO?=
 =?utf-8?B?N0NxN1kzamhJOWpNbkczMVNDS2hqd25MMzQ4RE9zUlg3S1RzTWwvcnpyMHNk?=
 =?utf-8?B?ZzVMUzZmL3VsNkRLQXFFRE9qSmY3MzBBK2h2WkVhZHl1WmVzV3crTnB3NzA1?=
 =?utf-8?B?TkdKTU5qZWc5RnpiMmFkT3NITGRxLzljNWRjUmQ0RTZGb25BNDNuWkhYcjR5?=
 =?utf-8?B?dHg1UW1rUjJtNkNzUWNVcGpsY01xZW1VWGVIZ092YjZyVVJwRXJITlBRa2tH?=
 =?utf-8?B?aDJDSWkrRmR3ZkRtVTU3VDRUUzIzNmNnU0lrUUJJazd0TFpmaHZEdTNWaVI4?=
 =?utf-8?B?ZGRsREYyb0Ntb0E4QjZleU5TejJvZWEvdm1RN295NVpaMXYyaEhLUE5HaEdU?=
 =?utf-8?B?Q1VYTkoyZUNNZ1o5NlBVNnBxZ0UzTkp5ZHdxa01JMmVMUWdieVoxZHN1UTBy?=
 =?utf-8?B?dXB2bHRVYWVjMFRDbWs0UFJtV2ZNSSt5bGNjNnNtTXo2VXN1bUYvekRoR21X?=
 =?utf-8?B?VmR1RFk4bitUbFJHNWhzYWNhWjRzaXZWVDdMTXRTSE1udWN5R052N0lMQUlr?=
 =?utf-8?B?ZzA2T09VRDFlbWJtNGFTVjFFdnNLalI0cTgvQUNnQUVmRGpXNm53bGx1TWpw?=
 =?utf-8?B?RHkxR0hLbU1ER3BzTmVqREhXeWdoQlY2OXYzQ2dqaTdqOW1obmxydngzU1BD?=
 =?utf-8?B?S0ZvTHZzSUZiTGVOV250RE5kL2JaSlY2QUhsb1hGQTVVVjgvMy8xYkNUVmtx?=
 =?utf-8?B?OGZiZDdid2xKanZSbXdvd01oaVM4R24zL1FnR2Q1cVl6MGlqK0ljTE1yOUwx?=
 =?utf-8?B?aHRLRWFVUUo3REJYb3dZZm9wWWd2UDBsb1cyNitSSlNBcHdmMFpKOHdoZTho?=
 =?utf-8?B?U25raFlFQ2ZCekFQV3Y1cVZORWJXb29JTXowM1ljaktYditVeU95a0VEZE5D?=
 =?utf-8?B?VzJQVEhPd21meDM1NkY1RFVZanZtLzBQWDI5Sno5R1Q1VUw4M0h2K2RyWWgy?=
 =?utf-8?B?aXRFdXNlR1hwbkUvNi9rR0pmRGlSMGlCeDNnUGFwYTdPZlgyMnRQZVluMEhS?=
 =?utf-8?B?L2dtMHFjNGUxN3dQUjcvT2dNQm1zNjdMYzhsc0xCalhjWnlGQnRrbk5yM2VM?=
 =?utf-8?B?TXhKaUk2SWJoN05IcHl3MEJ0M0hHUEtzYlZ0eGNRRDRhcS9EbTZjcWpGUlJG?=
 =?utf-8?B?SGNXSmZDWkoxQWFRVk5aa0MwTzM5SEVFYW5qR0l2Rm1VMkZxVVN1SjlTOC9Q?=
 =?utf-8?B?SzVzRWZXRWFURUhybDlYQThJd2gxYnRjbHJuQVJtNHlMVTIyNFZKM25heFhO?=
 =?utf-8?B?OFBwVWd4azJha2U2SjJ3MjJzWkNqQm1Ma1VOdGNZVXRIT3pKM3I5b1BkeDVq?=
 =?utf-8?B?ZmJpZ0QwbXkyM2FoL0tiMEt5ay9TMmlQcVRSMWNYR2ttUnRPYmV1ZW1sYVlp?=
 =?utf-8?B?MjVod2dlbE4yKy9hUjZUNS9GWjJEcjhsYk5OOS9KQUtJSUNYNmNsSnd3VjJ3?=
 =?utf-8?Q?5BfM36hRAeAOx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBVR0Nmeng1ZnJZM3MwbU8vS3NYZXN6b3gzUDF6VngxOW15aFRMSGk1bUcw?=
 =?utf-8?B?Q2FmSU5kSzB6RExjLzJpTVhLUWw2NVdicDNOa0hjN1ZXQzZqei93NjF2ZDhh?=
 =?utf-8?B?eTk0ZmxlbDFKK2orcGk3a0RMeU1obzVBT2ZxVFZZS3ZxRUcxSTFwdXJQQW9w?=
 =?utf-8?B?dHROcVdvQ0dnUXUvMkpHUHNiUThkbXJTU1RrUUN6QVE4bHo5SzVmMVY0dzRs?=
 =?utf-8?B?cU40QWluVVlXVm9jRnptdm1vWlFMVG5wUk1wVXBQWUFSMHJLRjRUTC9VYUl1?=
 =?utf-8?B?bTE5M29UaEFwdndibUhKTVJMN0kxSWpUSnB6Y1U1emtJVnEyK0VLTERTRkpO?=
 =?utf-8?B?UGVoWFI5V0RZME84bHdicHFSQzZIWWREQ1F3aGJBQ3gwRy9nbStUUWlKVGhv?=
 =?utf-8?B?WFZjTjJia3AvOE1hRVg4ZEt3Qkl3NU01NVlvRHRnWjVlSUtHMHBrQ1dGTVZn?=
 =?utf-8?B?dFg4cU1mL3h6OXdpdFc0Vmd2VnFDcTZZc0dTNGF2R2RxbE15SVhkTmFIeGFl?=
 =?utf-8?B?U1E1QTVlRHUyMGxTTEN3cktMWHFtcEpRRlpKSWdKeUZjZEQ5Y21DT3JHL25F?=
 =?utf-8?B?OEllV0ZXVjJORkYzZnBGdkhaNWp5YVBZYno1OEpITlZSMW4yb0hqKzB4dEZ2?=
 =?utf-8?B?SWZ4dWxCM0JqM2E4Z0d2V25aRFVQRTVTNy96NjRwZ2RYYnlVa2V2S3ZodXhH?=
 =?utf-8?B?YVB0cXI4K3ZhcWtpblpmR0JXdFdJcHR2akVkc0htSDlDYXM3NmVReTJCclAx?=
 =?utf-8?B?NlpjUUYrL0hhYlJJY2czMElmTFZHS0tHbENDWmNndmhDazBMSm1CSCt1N2Z3?=
 =?utf-8?B?T3VhMzNFcU1SZE5CdERudmErWG83Mm1yRW84cEFGeWxYQ1AyT1BNUE91aEtI?=
 =?utf-8?B?ckhiOHB5ODZYZzk3bGxtSDhlRkZSczlSUjhZcTRibTF0a25oVGFrd2pZdk5M?=
 =?utf-8?B?RzQ0NFZhN3ZXK0g5WTY5cyt3WHJYWDN0a3J1Sk5wK0pTWGZiWXdibjE0L1Jn?=
 =?utf-8?B?Z0RBZ1pGdy9nOGoybURuM1Y3UVVObjhzZmdYNUcvRWsyU2tBRml3UFlQdGx4?=
 =?utf-8?B?bGFLNEhSV0Y0NExSbWIyUTljUkhuRjNKWG1YdDlPSkFHaDBQcjBGRkZlVkY1?=
 =?utf-8?B?M1N0TXgyclUzV2JhdmVJZzhhVHpCWUZaa0pFejVvazh2V29XbkZIUU5OajBr?=
 =?utf-8?B?Uk1aQ3dDa1V5V2JBMWVBQy9kQllqWnpwM0xrdUlFR3E2SGJ0SzMvQVFBb2I2?=
 =?utf-8?B?bnFNenkzRlB1eGZUdkJqWm5lbFNNanRZQ2lPdHJlNHJpV0YzeFlWSE9WRHpF?=
 =?utf-8?B?WXl1T3k5TFhNQkpESzJRaU5rWlhkeXBCa3NKc29KbjgwRFE4VnlDck80WEli?=
 =?utf-8?B?VjAwMlhIaTRZOUhQTzN0TGFycmpLUVJQKzZUeGlqeU5JUCtxZ0loMmFWTFRy?=
 =?utf-8?B?NW0wNDNvWHZLdktlK2lST1gvWlRJSE4wR0JrZlVLYTEyZzBBTTRrbU1CWWdW?=
 =?utf-8?B?ZkFIa3ZIM3M0YnJpYzA2STNXZytpcnEzQjZxRjFhWDVkdlorbU9DdU5ZY3dI?=
 =?utf-8?B?cjQrdjlEVzFHMmtYNE9EZjU3NSs3dnlKTlN4d3NzNVFFWVpobHhpMTU2MDNr?=
 =?utf-8?B?OG5MS0kzRjE3WFV5endmME5tLzhRRHYrdVhGUCtQejdyMEZ0ZFdENEdUUDVl?=
 =?utf-8?B?YkZGSXQyaDJIbCtnZXVMWTBDS3ZaakoydmhZbHEvVjZZcXFQQWQrVnUxNGgr?=
 =?utf-8?B?RkF3Qit3anZROUJwMWJ4OWxEcExyNWoxZFZqbWFpaEs3VytBUmVnYXc1Z1Av?=
 =?utf-8?B?Z1N3RG1WT29lZWxiS3N1U1FIS2IvRUk5OTJCSE41Sk1YZEhyUlhjSWNkLzhH?=
 =?utf-8?B?Ti90Z1lpb2VaVWVnUlFlYjZ3aXVpYk5HL2o0NnF6SzJnTTBwTkdpZGRSdHEx?=
 =?utf-8?B?WXRsd3dlUU05ZTVKbFE5eTQ3cDVDUG85U3lKcXBsWWJERjV4TlRteGNibWR4?=
 =?utf-8?B?VGptUkxWdnl1c0MwczVZeWE4bEpzaEhUVk9tNzFnamhqTGpKTXh0a0tlWnh0?=
 =?utf-8?B?VUdGMEdLWjgzNUptSUFmSFM4eVg2OHg4OW1ZY1RZQkFmcmVZc2VucFpMblhC?=
 =?utf-8?Q?U1Upa/oGljq+IKQS7yy6r6a50?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9694a0a7-e2ef-4cfd-139a-08dd613cd046
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:06:37.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTn40IUyuCbuMZNif2dWu8LLLNS9MoPY1BmHp22tHuhuM2vOj9ZKs6wvhe+kjx+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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

Am 12.03.25 um 08:59 schrieb Jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
> we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
> This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.
>
> The current SDMA reset mechanism uses a dynamic callback registration system to allow both KFD and KGD to register pre-reset and post-reset functions.
> However, KFD no longer registers its callbacks, and the reset logic is now entirely handled by KGD.
> This makes the dynamic callback mechanism unnecessary and adds complexity to the code.
>
> 1. **Remove Dynamic Callbacks**:
>    - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
>    - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.
>
> 2. **Add `stop_queue` and `start_queue` to Ring Functions**:
>    - The `amdgpu_ring_funcs` structure is extended to include `stop_queue` and `start_queue` functions.
>    - These functions are implemented in the SDMA version-specific code (e.g., `sdma_v4_4_2_stop_queue` and `sdma_v4_4_2_restore_queue`).
>
> 3. **Prepare for Deprecation of Dynamic Mechanism**:
>    - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 ++----------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 ++
>  3 files changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e..1c52ff92ea26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
>  	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +	int (*stop_queue)(struct amdgpu_device *adev, uint32_t instance_id);
> +	int (*start_queue)(struct amdgpu_device *adev, uint32_t instance_id);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>  	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..b1f4a11ad0c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -534,16 +534,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   * @instance_id: ID of the SDMA engine instance to reset
>   * @suspend_user_queues: check if suspend user queue.
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues)
>  {
> -	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
>  	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> @@ -571,19 +565,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>  		page_sched_stopped = true;
>  	}
>  
> -	/* Invoke all registered pre_reset callbacks */
> -	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -		if (funcs->pre_reset) {
> -			ret = funcs->pre_reset(adev, instance_id);
> -			if (ret) {
> -				dev_err(adev->dev,
> -				"beforeReset callback failed for instance %u: %d\n",
> -					instance_id, ret);
> -				goto exit;
> -			}
> -		}
> -	}
> -
> +	gfx_ring->funcs->stop_queue(adev, instance_id);

Yeah that starts to look good. Question here is who is calling amdgpu_sdma_reset_engine()?

If this call comes from engine specific code we might not need the start/stop_queue callbacks all together.

Regards,
Christian.

>  	/* Perform the SDMA reset for the specified instance */
>  	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>  	if (ret) {
> @@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>  		goto exit;
>  	}
>  
> -	/* Invoke all registered post_reset callbacks */
> -	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -		if (funcs->post_reset) {
> -			ret = funcs->post_reset(adev, instance_id);
> -			if (ret) {
> -				dev_err(adev->dev,
> -				"afterReset callback failed for instance %u: %d\n",
> -					instance_id, ret);
> -				goto exit;
> -			}
> -		}
> -	}
> +	gfx_ring->funcs->start_queue(adev, instance_id);
>  
>  exit:
>  	/* Restart the scheduler's work queue for the GFX and page rings
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..c1f7ccff9c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> +	.stop_queue = sdma_v4_4_2_stop_queue,
> +	.start_queue = sdma_v4_4_2_restore_queue,
>  	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  

