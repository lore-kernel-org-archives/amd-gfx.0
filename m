Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E88C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4130E10E606;
	Wed, 28 May 2025 13:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrbv562B";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5AD10E606
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM9O82jM3/egUnI6d3cz4Fv8LGDxz1MqLEA3ZeuAq/lwSQ18VgnLNSnbhQR7liJoGLbLYB9cllEJDcMP76bQGZkaQn67mzT4tauQ7HVh5TEcfzia9r11R+OKG68Ece7nA14P6/nKW2SLuRj1a+1VSiuRxYKWLUh6Z9YCX0SBntY4ojzTKbzBUUi9PPbkiIBNPqjwDnGXzaN0SQ0py8DY/IUFE+W68sW9hUyVOq8j+oOuObyUX807AFL7YnlaYT25ku+tfiDnZoFyhu5izYww2Sbk2x9VmgnKWQSfG8ILOwHntCi4qDTVp4J6vckJYaNFT09UjeNWGUsVWrd2xFUHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pbMtPqgQDANlrh0w9PC8LegGtLKw7RLXUEL0f1GYbc=;
 b=ZFlO+Lydr+s1JF9tpK8Lnq3XufnVHYX3oPVdIIBsvXiE8Z8m7P6Xo77V5hYVuL6dpHjVfwL9rSLnUezxvMQ3mlhmvSjZcaXtw8XRNQYe36+bQWoc2NyP3alXZpDJ9o8ZVjWPSYy0vYobvepXxV2g4guRULaZLAKC2ePmKyeQMHj60NGS4KmolPxeqorf1Ds/QWBy/CSu+xQiASQFzi2amc2gM4CsNh4Sz9wy/lcW+zP9mtQgaJWJqNh8E/0sCnb+CkLavC4MWZKEkRfuP0U9gKFLz7FPxXGoFYjS5x2mUBmvmJn5lD5vjDHAzdlFaEnPN52nh9mJ3fOKTzdbr0J4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pbMtPqgQDANlrh0w9PC8LegGtLKw7RLXUEL0f1GYbc=;
 b=zrbv562B92Q8tqmaOZbKae6KvyQIH9aXr4+AuGRNfH0hA8ItPRUex0GAlqDf/S0KnEQrMJneIyLRXFNqq4uN/8PnZ8ALnlJ9iLxyoFpIIkSgy23lkRj3w/sPeyPyhGSA4dka4v7URY+cA5IpbjyDgYTUOFR/RXdZjs49QKr1j8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 28 May
 2025 13:53:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 13:53:57 +0000
Message-ID: <4fa0334e-3ec1-468f-a282-2224bce17f36@amd.com>
Date: Wed, 28 May 2025 09:53:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Map wptr BO to GART unconditionally
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <Philip.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
References: <20250528015544.831374-1-lang.yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250528015544.831374-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: a3439309-8c5b-45cd-687f-08dd9def1752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHhBZVlMWGtpcnB5elpyaVVIWmlLSnFsOUdnb3FuUmF2Mnp3WFZJTlovdzl4?=
 =?utf-8?B?OHg4QllQS3BHejhoS2F3QkI2SWN0NVJ0UVAyTHp4VzVkblFTVmxLend5ZTdx?=
 =?utf-8?B?RTEwc2hHUDhYUmZlSEUrTnN2SFRBRXZzNDNEMVExYkNOZVh2R0ZEY25rZHVP?=
 =?utf-8?B?WGlZNlZGMlkrLzZxcXhmdEk1N3pLVzRqdFFZWXJ4K1p0YmNMT1RDRXdhMXYx?=
 =?utf-8?B?MloydENTY3lXZVN0RnVxMEFoODJUdEtTN1IyRnZQdW5mVWUwOWZoZkJZRDZo?=
 =?utf-8?B?cDZMQXFIVjZRK0JjblpBVVpiZ1N2Yzc2QXdFRXdQVmc0U3E0eE85NDNKcFFa?=
 =?utf-8?B?NCtXNlBHNGptNmF1VWdyUTh4bFdCM2ZxdDhtNTdnMktCWDlBMml3WDM2MjQy?=
 =?utf-8?B?bkdPeGJYeUtLNjdOdmRVQkdtY3VlcmZ6b3NWT2ozSFdQYzV1L1V1M0VTTjNR?=
 =?utf-8?B?cnZ0Tmp6bjRtOS9uUmRXK1lzSTBzZTliRUFNVEJ0VWM4NVZVcUVFTER1bFRG?=
 =?utf-8?B?cWU1R2RUYThVaStCYkdKYWtlS3lzZ3dLR3J3RXZZbnE3MEhLYVR1aG9PdHR1?=
 =?utf-8?B?VlZhVmtjZUtXUTBpOC9DOTQxdllOalRhOWlWT0Q3VFVsMEd5WFRHUkhja0hy?=
 =?utf-8?B?alpEUkRvcE95UURwcVczd2pEdWhiZkhhSGlIeGlodjd5em5heVc1WXVhc0hq?=
 =?utf-8?B?UW5VcTYrcUVTdGxFbFhNTFc4eERFeFZNbUpWWi9POXRnNTh0ZG96UTg5NC9o?=
 =?utf-8?B?RkZiUGVDdWlacVZFVWhZMzRQUHd5QUhFZ0ZXaVBrdXZ0ZGp6V1AyVEZ1ajNY?=
 =?utf-8?B?OXIxZExVQWEvK2NzeWRXMEFIRjRwajZmUFQrNmJaUVBhR01kTFN5R2tndWFS?=
 =?utf-8?B?SWhlVCsxS1BuWnZsSktmZW5aWjIzZGNTMkZ0Vm9PZitwNjZIbE1kVWtCSFdm?=
 =?utf-8?B?eWhxYUIzOHJLZTFXdGN6Wkd1dStOTWpoMzllN01EU3RpdUNxbmFOZzdJV29u?=
 =?utf-8?B?bVNqRUxqWnd1VGxDL3R1RWlibENPWGlNaEl6YlRFcVFDVmltKzA2QjhTaGEz?=
 =?utf-8?B?bEIwOG5TRnoyWGtyNVRubXRlV2ZkTWh4MEtZWFRlSHM4aWI5WWx1eHlJTnBE?=
 =?utf-8?B?eG9kc01iYXNUY083dHA1VmxNWGRxVWdmQzNpa2VDVUNzc0FWaURxWG9EQ1li?=
 =?utf-8?B?TU5TUWo5RkM3WUZOOUxyY3Q3dUV5VVFTWjhmTGFRUGJRM2RJbDJXZ042V0ky?=
 =?utf-8?B?aVBCb3ZwZEk1c3h4S0lXcnNlTkN1WDRJM29XNjJZQXhIWTRFSjVIZU01NWRI?=
 =?utf-8?B?M2YzU081RVFBNFZKZVhnRWxnU1FaK0ZvMHd3TnQvR2E5aGYxMG1BeGEydkRT?=
 =?utf-8?B?Ynp4VXY2VlpYRmpGcXRRdGQ5VkxRcStoN1lpY21ScGpoUFg4VHdkWFJndHFi?=
 =?utf-8?B?UG1TVlNDdDRibWsyV0l4UXdYc3poME5wd0NmZEdiL21pUnNwK3V2VFlyUk4w?=
 =?utf-8?B?OGFYTEdhOWNnWmV4RkpWejJteFcvTU0wRklDMXZMWTNyQnhTd3BYS2xUWE1L?=
 =?utf-8?B?UW5qczFhMHhXTUpCMTZsOWUxdi9wajIzTFpLV2xENnBFckxHQW1TYmlSeDRV?=
 =?utf-8?B?cGc5Wlp0KzRIYStyYlhOYUpNM0E0UWhrK3pVUnFGWmxqejZicUoyUUI2emhS?=
 =?utf-8?B?U2lIUW05V25qNnlSampRUFpDVFZObXpvdDZjaThNMjlIUkhaM3RvZ3diMUxG?=
 =?utf-8?B?QWwrYUVrdllHVEp0bXJTV1dnRllZdVljMklxUFBKVGJzY1VWSS9xRzQ2Q3c1?=
 =?utf-8?B?Zno0RFBXd3R5RFNqVFRwSHhyMStKNTIyTGkxWWhJVDQzSC9XQ0Fvd0IrY3Qv?=
 =?utf-8?B?Qk1seXBXZktETUZGRVdRT1p0bUxOSktaSDcrMEVOUWdMOXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm10UHk5ZkJZejg0L2Y4QmNzUkM3WlBUOWVIQklZamQrdENPbHg2OGxIamFa?=
 =?utf-8?B?ODlCNVVXUHRsNE03emV0WTF5OHpvZDV4c2NaS3NjYUlBN0g0ZStLL3BudDQw?=
 =?utf-8?B?SzRGdlZXbFA3em1qSVNXbG45eW1lbDF6NHEzRGdvUW8rdk9SMHJFYUNyV2F6?=
 =?utf-8?B?MGg1Um1KMHFyN1p4YXZRTHB1NzYyNlNOaG1kV0tuYnIyL3VEOURuNWxlYVlM?=
 =?utf-8?B?L3Rvb0JyTnpIQzFyWU1may9WQWpMZURFNTJGYzN6YVZxeGpVejhQRmJRbVdQ?=
 =?utf-8?B?bDdWZTJNVmt0VFpUM3NSVUlwYVAyQjZvc1l0M1BsbUgvbzJYaHovY0J2UmZT?=
 =?utf-8?B?Ynltc3lUbzhwa004NjVqMUF0cjhHZnl5KzFHYTFyNmRjNUtMNHZZdEhzTjVP?=
 =?utf-8?B?ZTFqWTAyeUZMWXVKUnpTajJwNjdhN2kzRmpWWUF0czhlTjNCV0hRZ3ZNVCty?=
 =?utf-8?B?Z1dpKzNvQUN3c2dNd2NTUWpDWStxOHRnK0o3TUZxV2VUVE5ML0pReG43UDRH?=
 =?utf-8?B?WXlMbHNwUEw2YWI0bnhPTkxZZVhMY2VyT3B6dHJMRlVNMXVFQlIxRndYS29K?=
 =?utf-8?B?aTB5clBVbEJocVRRbnZPbTRMSEtVMStNcEVYT2pFOEJiYi9BblF3c0I0Y1JG?=
 =?utf-8?B?WHZzQUNwMDc2OG5lK3ZYV2ZmVWJqaFNLMTRhUFZtSlZQOFJkMGRhQjd2MTFW?=
 =?utf-8?B?cm1yUFE3MENJQlRrOVhzWDJmQ2ZIQnRQZ1NmemYrL09wZXpacTUzNmpUdmhX?=
 =?utf-8?B?UUNYUWxFUnhWeUNzcENzRnI0S0dMbWVETzNyU1phaXViTCtqNTlWZjJIOXU0?=
 =?utf-8?B?Mi91amdrc0RGc3VRaDB5RGNVSG1Cd2ZKUEJZUEo1VzN4OXk2cDZodnk1b0NH?=
 =?utf-8?B?S1d3M0VZSU9jZVovRWRVR1dDWmRwbVg0SVRFUzZWelRTa1lYTUZOM2pXMTQy?=
 =?utf-8?B?d0UwUUNTaEpha0dQSnlDalJ2S2o0Wkxnb0ZFT0hMWlZDcHU5Zm5kTVFDM0tr?=
 =?utf-8?B?RGg1Q3MvREdXN1FnZGRnNHV6S1VKTDZIdVhRdDB2allWWDFkSHhhd29WYWU2?=
 =?utf-8?B?d016YXFjeEw2L3QvbzZUUzVwMFV1ZWR0NWRPMWl2d2dOeDVPOWxwS3pDL3dh?=
 =?utf-8?B?SWpMQ09BekxHamdDWDNLMXZFSVIyN1BWZHp4dURHMU5jRno5RTVuZmVObVlU?=
 =?utf-8?B?L25SdU5oeDNrVmJJVnErcTZZSVV1WEdHRnh4cExzVnF0UEIvQlUyMWZyeTJv?=
 =?utf-8?B?SVFNMmIwSmk2V3NjaldTSnVvd08xTks5dXpLZThqb2JlSjRpRE5OR0tJNERE?=
 =?utf-8?B?djVjZm1mVnIxMC9sTDhrWEZLeDI3YnBjWkZubm5qMENiSDh5dlliSXAvWjhM?=
 =?utf-8?B?TUtSenhZeDY3M25weERBVU9xNTd0WXVkQktnRHBtbXAxcFAxclR4VDFZeDBO?=
 =?utf-8?B?cCtOL1NvOVhNS3lEZ1JPVWZKelVDeGV6ZjJ0TUhrWGRwWVZ5NUZzaFJCdzdF?=
 =?utf-8?B?ZjYrVnlmdmJ6RWEwQmptS3JVSlcwWkRhSCtGcmdlQzJwMXpoSUI5ejQrbDVL?=
 =?utf-8?B?aC93aHY3VU8zSlFjZFJEWXZ3dCtuWDhnSFZPak1IeEx2ampWQWNhMGxUSC8w?=
 =?utf-8?B?THN2N01UWlZ1VGg1ZkYzTGkzNmM0TkRvSDZsYzFNekVJQ2RTT0VlcklCNmpH?=
 =?utf-8?B?bE5QajNJditBTENQY0Z6N1JRLzk2dnY2QmFZK1VIM3A1bXhzcjFVZlorRFlV?=
 =?utf-8?B?WWxOM1FTSTdpN29Ob1JuYk40cTd0NEw3bHRRWU1OUWVLMS9mTDRMdit5TGph?=
 =?utf-8?B?L0Z2U2xXUytUYTNzV2pEVVNBNDlXWlloZXNuZHRUU0RxRm5uVHVpS2pXaDc1?=
 =?utf-8?B?R2pUamVTblRRTHhBK1RpeEZGSVFnblZXV094YlRZY1lmU2tVVzJxYzlIREJk?=
 =?utf-8?B?R1kxa1RBWlJOLzNLcDNWOFJwRHZXOFc4ZUJjTDVUVDFISzR3Ujd1Ry8rZDBr?=
 =?utf-8?B?ZGszV2JzV1gzc2wvK2hQVDEyV3lldlJaSTdyRXZFVDVKeTB4TExZZGhMNUd4?=
 =?utf-8?B?VzZoSXVKOVNxcjdyTWJWTUd1Qm5hNVZRbGdXU1NlSm9Pd09hRUZkRU9ZSW9p?=
 =?utf-8?Q?vixTKQYRV3A+SlkCZ04rYmxCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3439309-8c5b-45cd-687f-08dd9def1752
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 13:53:57.2406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgk2z0ar1IA158AR5zHrUSoKHE5dC3eFR811KnK1ZwAFfrZEXUsHXRgQRa8AthQiPXmruIuW/uAsxVPnE58GHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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

On 2025-05-27 21:55, Lang Yu wrote:
> For simulation C models that don't run CP FW where adev->mes.sched_version
> is not populated correctly. This causes NULL dereference in
> amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart)
> and warning on unpinned BO in amdgpu_bo_gpu_offset(q->properties.wptr_bo).
>
> Compared with adding version check here and there,
> always map wptr BO to GART simplifies things.
>
> v2: Add NULL check in amdgpu_amdkfd_free_gtt_mem.(Philip)
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  3 +++
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 23 ++++++++-----------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 4cec3a873995..d8ac4b1051a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -368,6 +368,9 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
>  {
>  	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
>  
> +	if (!bo || !*bo)
> +		return;
> +
>  	(void)amdgpu_bo_reserve(*bo, true);
>  	amdgpu_bo_kunmap(*bo);
>  	amdgpu_bo_unpin(*bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6d5fa57d4a23..c643e0ccec52 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -279,20 +279,17 @@ static int init_user_queue(struct process_queue_manager *pqm,
>  		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
>  		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
>  		 */
> -		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
> -		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
> -			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
> -				pr_err("Queue memory allocated to wrong device\n");
> -				retval = -EINVAL;
> -				goto free_gang_ctx_bo;
> -			}
> +		if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
> +			pr_err("Queue memory allocated to wrong device\n");
> +			retval = -EINVAL;
> +			goto free_gang_ctx_bo;
> +		}
>  
> -			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
> -								  &(*q)->wptr_bo_gart);
> -			if (retval) {
> -				pr_err("Failed to map wptr bo to GART\n");
> -				goto free_gang_ctx_bo;
> -			}
> +		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
> +							  &(*q)->wptr_bo_gart);
> +		if (retval) {
> +			pr_err("Failed to map wptr bo to GART\n");
> +			goto free_gang_ctx_bo;
>  		}
>  	}
>  
