Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF3DD7495D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 07:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96FE10E40A;
	Fri, 19 Dec 2025 07:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uR+392/z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FCA10E40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 07:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMifdnV5PWnEc4HEzKNA93EL1vOiwN2QcUPQK7jfJ1Kr2xE6Zqxn1WfdoYj8V1sY9VFDQyeflGqfXT376xufihRSs6wN8MHc5iTPVFWLt6AiLSvg6GhOJ4E6xNdd6y5vQb3RTTHWa6oyY5HxU9Zqk7cJpLq0KzquusTDco7CnB4rUXUEwAJrRlpkFChJ7VBDE3sd5NNjo6hjXpeVAK4ow4bvsk9Q6aQp6eNkXoYuTdkgiBU0A3JuKvF+vN8yR2phDxIccDYJmAUCshmvq1YM+a3S0LarA49HgPbtmYUdXvpzZGGRN2mwA/DvrVHZb6s9fn5zGGAXjcZwNq1cXRpwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj2xtoNCMMnJFRzvu7/3u2a04ePUNgWQrVW2gWd8HxM=;
 b=Eh9ANCUJ+ogzl4bM+oJcs1FbmnDO9CXWHcf9sF1sIqkM5SE8oYQNzvBZxAfx4pyv/b7Vj9VN6lDbnKLqKviwILdxNX3Ch2yJqRmzSvASsCU9cm2QFAOozJMDwzZpoXLGaLhjiJX5vV7oqvQRojye5GEBMze02lw0lj0A4lX8xV7h5mh7pqVfPhJZQg6rzMKXpA6iqpVzmcxZUwEUw5j4fS7UdmHEaB6VeHPo+B7eW5ptBVNcJlhvfr6+Ff9Sc/MndeKm0tNEpz9YJVvjsmn8oqlNuVZs4Wqkdtiwu3gxkBrcoR+X2OcFsdMrjxL7wjd+OthJw6sNPU/ZgJ/WgKlZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj2xtoNCMMnJFRzvu7/3u2a04ePUNgWQrVW2gWd8HxM=;
 b=uR+392/zs8xoBSbOg2E6P5seUfsR8y3IbPwG4LLOAwb2RRMprhFHny3mxseINDktp1zdZ7K/VoV2EZx4/G7PlZeP4nTN3h4w9vPkTBGKtgs2FFlvOBmpXhaPrRiluEh7fJb+GyeP0WhmVlbL5wp61TV7AeBCcOuWIJlWpSVtBBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 07:57:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 07:57:56 +0000
Message-ID: <732a0f53-d4ff-4dd1-9b4e-bc20c1a79925@amd.com>
Date: Fri, 19 Dec 2025 08:57:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218150405.80502-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: a512f84d-5852-4c96-a3d8-08de3ed45241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3oxcHRzZDVUc0hHU3BZODBYajZLNlduc0hEaWttRFBIckNqYkNjQmtlbkhp?=
 =?utf-8?B?WW9mTUFCV3doSkpaeUJpbTRRQ0p6QzNYRExVaWJNaXNnYlo1RnQxM2tiWUlk?=
 =?utf-8?B?cWR5L1QzV2tOSjNDaVVOdnViRG1SdmxEVmFJS2V0aDdwL3k3S202d0dPMG9w?=
 =?utf-8?B?VVhBNU9JV1VXM2U2NkR0VTRhL2RPeVQ3S3pzMkg5S2E1aHI2Z2tDOE5BdlhB?=
 =?utf-8?B?dlpzT3B3Y3FqWnBiQzYwY1cvRXF3NWtxUWcxV1Z4UGdXOFYwKzlybHVJd2Ex?=
 =?utf-8?B?Mm9vTHc1bWt3QXRRdm0zR0tOTFlsQmQ4SDRaR2VKc1ZvckxNM1d0T0hqeW8y?=
 =?utf-8?B?VjJBQUZZN2g0eHVjRUZTN1lZbU4rWTdUUlFncVBPZTc5VFJOUHF1eGI3Q240?=
 =?utf-8?B?NDl5RHpZaXZJUDRXUGJ3T3huMVQ5blQ4SjhUK1pxcm5Xb0Z5VmRybTRrd3Jr?=
 =?utf-8?B?MmtIUHU3U2lvbW1IQWdyVmRDWjVEdVhnTisxMTVXbWNNQmpMeFpaZ2dBTjJX?=
 =?utf-8?B?SlppM0Ixenh0WEFWblJrRGk4dzA5RU1yR3c4L1ZuVTFBSkgvSEZkS0xKWmpO?=
 =?utf-8?B?WFFVTzdaNlpvOTVHbHZ0cnZESGxJSG9Zajk2YmIvOXQvbTdYOVZsanRsS3VU?=
 =?utf-8?B?L0pHMDRjMCs3RkpXL0hNS0FPaEpLV2VObXBKRFFxRHdiZkFBMUd0bzEzYnZr?=
 =?utf-8?B?OWRqUVR0S1N5dWdLU2RiZUNwQ2lwaTdkOVRZZzBzK2lwUnU0dW9zUExvTndt?=
 =?utf-8?B?VE5ZTno3Z1c2ZGNRM1VVanRSQVRjMFlpa1lacWVmQjJvQUFUcUFLeVd1SFEx?=
 =?utf-8?B?cGlVYWxVMTA2WVZnOFI1YjRTdDdXRkk4aWVsU2MvY3Jmc09DSzZwTUpZV1dU?=
 =?utf-8?B?VE9GVk4rdWY5NStlOWZzZEM3czdFc0N5QU56RXRVS3FacnZFSFpGVkxGZDhi?=
 =?utf-8?B?ZWhUclQ2ZjNTTFE0Q2hCWlg0amtMdE9OZ3BaTzNQdXc3NmNQZ0dHbktLVW10?=
 =?utf-8?B?K0ZZSlJ4N2c5KzZWTC9rZXpmTmk0cDdTUlVIdGVwZHlmZVc5ZURyTWE5N2o5?=
 =?utf-8?B?NkErK0p5TnlFVk1aREo5djI0L0hvWUVacnVkNWQwYnBheXllNlVUeExIZDRU?=
 =?utf-8?B?VW5MOFB4UFZYYTVOWi9OaXBrY29MVFNLaHRiVy9aWGxoQWMrQU9ieFdiQnU3?=
 =?utf-8?B?dFhBS1BZVlcxVDd5Ry85OXhIZ1FmMmllRlhzZmZKYVZVMkx5eWJod2d5ZFVW?=
 =?utf-8?B?dkh4MXNKRE55ci84cEJYYUhvbVA5TUV1MUdEK0F4WEZKM21UYTN3eGMyUnFW?=
 =?utf-8?B?RFJlWW80OUdDSGpESURiZEJtdllKR09zcHF1S2JQVktTVytXZzc2RFJDRVQ5?=
 =?utf-8?B?OG5LbE5oNUV3ekpoT0pONzA1K2NNelplQ1lLKzFZdXZ3bzFzWkxvSnFsQzdt?=
 =?utf-8?B?SXRMdXJQQTZaWnAwSk12VFhzWHNGK1M4OXN2QzRNamxtYllFWnRMUG11NW82?=
 =?utf-8?B?RkpKaFNJc1hINlBaL0VIanVTcFlvWTBSRFhMaWhGUHNLbGs3bExOR1VXaWpS?=
 =?utf-8?B?KzBYTEpNRXFIblZJMlFYby9jblNMcXFhTW9BTUF5S3kraHZxRmk4NEhiVVJZ?=
 =?utf-8?B?SWhvL3R1enQrL3Jyd2JiQ2hLSFZ1TFdIQTVQbEVHQmpmTzQwNmEyNU1FOFFT?=
 =?utf-8?B?dUpuU0xPZDMrR09QTVJwMjBIR2YyZ01zdEhqVStUOHNpZ3RFdll2bUNpanE2?=
 =?utf-8?B?alE3bVMyd0JFd3YrVWFSZ0Q4RTVqajkyS051c2JQRXU2TmM3MDE2Nm90Z3Av?=
 =?utf-8?B?VEpqQnZnNUJRNWlLL3JpTGl5a3I4YmtIbng4b005VzlydGEzbnpCcnc5OGQ4?=
 =?utf-8?B?dkIwUGpnQnJtcUdWb1dDNnhoY1VSSGo0WGFKVGdvYW5ockFXQ1RqV2Q5R2Nj?=
 =?utf-8?Q?G/9CW+mZmeDIYYgZoDdQqm+JUFuNku3t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFJblYra09EVUlTeWRmLzZ4TlJ3S2pmRWEzNXoyRVNVUURyM25MZWhVQ1FW?=
 =?utf-8?B?RzE5VW5KYVBTYXpGRTJSV0lIQ3NDYmR5bTNCZ3RnSm1HSzN3MEgwcG9rWmo0?=
 =?utf-8?B?Nm8xRktpaWNIOEVwMG5qV0M5UG5oWU5QM2NQby9iVzVYcENGbWkxSmR0TGl6?=
 =?utf-8?B?bXBxOEMwbVJoK3dGT2tPWlJBQUlKc3NySG9iMUtkU1lRMDU0c3dSQ2NYU2NL?=
 =?utf-8?B?ZDVTSTZkVGtoSEN2Vm9KeEgzVFpKQ1VRakRhN2RNRVpsQkwwN3dnOEtaUTFm?=
 =?utf-8?B?TWk4NCtCa0JGa04vT0ovaUIzcmRpQ2JJemw0eVh2SXROR1JlWU8wWSt3ano2?=
 =?utf-8?B?V1BQVDMxMHVzSHFmc0ZnTndDQzhDSTFOTFBCYk92c2Q1cGJHNjVLMEhMQ1kx?=
 =?utf-8?B?R1BBSm5ISkFhWU5XZkhRR3c4dFltTEkrOGFzU1hTOFFyZkkyc1RQZU1BTnAz?=
 =?utf-8?B?cDJwQ081bVV4cXo4bCswT0hkU2VnZXJJcE90cjh6azFlSnljcGlyRTdKWUJE?=
 =?utf-8?B?dHE4YXVOT09qSmJaMW52aFlGWFlidDVIR2xsNFBWbE5JTVRKTSsydng1djdX?=
 =?utf-8?B?WmZHNlNlZ0loOWxFMnhRdis3SU9Cd3N0enNNbmp6ZWd0aUZaeXU3OXpEKy80?=
 =?utf-8?B?dHc1L3RGZ25OYXZUYTloNnlrOUxpaXJxNnlqWHlVM25UcGxrR3FtVk1zM3NY?=
 =?utf-8?B?S1M3OHUzbFpnZUc5d1F3bXlDdjJhYkc5L2FYR3JYdlY4MG0vS1dBclBLSDJG?=
 =?utf-8?B?V1B1TnVxMGxJOFN0eDBkajgyRjRoQ3NKbXRLWmE4dzZGd0VoNjJaQjZ5R1FQ?=
 =?utf-8?B?bkNJTXh3ZnBEaXhoWWtGbm5GTVd5WUdhaWFVN1cvOWJqbS8xdXlaUjIzQzFO?=
 =?utf-8?B?clhjNzNjNG9Ma045a2MyTWljWUQ2eTRzWTRsS0FyeXlsN1FxYWpob1d5c3Ix?=
 =?utf-8?B?eXVMOUY2K2Y2Z2hjOWhLalZQdnZQZFhQTlh2d3kzZFdNWWp4YVRrc3FvMnp5?=
 =?utf-8?B?VjNmZ0VJSjJCZWYyMUZpdmdIanF4TkoxeVFYaUNpbDBPQVUzeWFRakJ4TDhH?=
 =?utf-8?B?WDRWUXRvNDQzby9xb1gvMXRZUFRPY3ZlSkhaOXpvcDI2M3R6a1g3bjdzZ2Y0?=
 =?utf-8?B?YzVVRUhqN1gzMW16SzdEWnV3RXJYM0k5ZDlDa0VVeHBlNHhZN2pJNHBzKzlh?=
 =?utf-8?B?R2FMUmw1VzFBMG9IUFFBekplbVJBUTZJaUVERWZ6bE9NeUMwQzd1S3dkbTdq?=
 =?utf-8?B?bDEwOU05V0JxTHNDY3psME1SUVVUcjlrMkExZjYxZVR2Ry96d2kzUnlFeWND?=
 =?utf-8?B?QW4yUjhpa0EvNzVxWG14RVVhRWhjNm5hOStIMk5wUW00WkVuUWZtQUI4M05G?=
 =?utf-8?B?VzVUbHZTV05ncXRqbmxWc05lSll3b2hyajZsaDZmNGd5cXZEd1FvR1BwTVVG?=
 =?utf-8?B?bjRXazhrQWtlNUFkemlFWGJMTHJzQ3E4MWtuZU1JZ1pwZ3Q1WXRROWozTEds?=
 =?utf-8?B?bTY0cVBPOWthUlZLWFNRUU5OVXVvVVUxVGl4cHFCbmFlRUwxQURFSnppRnVS?=
 =?utf-8?B?amxyMFdOWE81bXZ4L0VSckVSR045SWVXUGo5TGZta0FXZ1haQW43ak0wY0Jl?=
 =?utf-8?B?c2lkTEp0SHpCdGVXQ2szUUxYalFlSXZPU1k1MTVkODFLMUlxMGJta3luRzFD?=
 =?utf-8?B?cG5oOUZheVp5V3hMbHo2YnpsejVmMWE5ZW15ZHBTKzAvMSt0cm1mNVFXaUZY?=
 =?utf-8?B?bVBDM1F4a3ZQQjNscGoxWDlJU1JBUG1XQ0lrWVEvR2RHbWR5SGVnWkQ1cVBT?=
 =?utf-8?B?WDl3UTlaNUVOKzFwcW5uRkdVYmZWd2ZNZDVHZGtJWDc0NStyeGVXbVV2cDZj?=
 =?utf-8?B?ckVMSmFqMHdpWG1BckZORzJCdGNaTlpNWkowT3V2S1VWVU9DNzVvR1FLaDh3?=
 =?utf-8?B?cTZhR1AzcVpRWmNnK3JYQXJWd2RvcE1sc1k3cGZHcmh4Ukx5V3FabWsvUzEr?=
 =?utf-8?B?bWIwUXNlZ241alptbFhwL0V5c1ROYjQrQVJXSkx2NGpzM2h3YkRYMWQ4eFNU?=
 =?utf-8?B?cVFrMHZoUFRsOWsvTXpCU2RWKzZsMzFMYy85RjhnV0NZQkNrUlFjMmVhNmNF?=
 =?utf-8?Q?H8oCOjqYW8KM4agXzqFQpv6ig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a512f84d-5852-4c96-a3d8-08de3ed45241
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 07:57:56.8548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgeV5+q7Gl+SsQTu7MTqO5VGLTSlmjxtRuaZkirWM0T+pEv47WaiTWS+O3CTWrqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768
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

On 12/18/25 16:04, Tvrtko Ursulin wrote:
> IDR is deprecated so let's replace it with xarray.
> 
> Conversion is mostly 1:1 apart from AMDGPU_BO_LIST_OP_UPDATE which was
> implemented with idr_replace, and has now been replaced with a sequence of
> xa_load and xa_cmpxchg. Should userspace attempt multi-threaded update
> operations on the same handle it could theoretically hit a new -ENOENT
> path. But I believe this is purely theoretical and still safe.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 72 ++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 11 ++--
>  4 files changed, 41 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9f9774f58ce1..0a5b802bd3c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,6 +50,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
>  #include <linux/pci.h>
> +#include <linux/xarray.h>
>  
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> @@ -500,8 +501,7 @@ struct amdgpu_fpriv {
>  	struct amdgpu_bo_va	*prt_va;
>  	struct amdgpu_bo_va	*csa_va;
>  	struct amdgpu_bo_va	*seq64_va;
> -	struct mutex		bo_list_lock;
> -	struct idr		bo_list_handles;
> +	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 66fb37b64388..628d32fd2fae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -149,31 +149,20 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  }
>  
> -static void amdgpu_bo_list_destroy(struct amdgpu_fpriv *fpriv, int id)
> -{
> -	struct amdgpu_bo_list *list;
> -
> -	mutex_lock(&fpriv->bo_list_lock);
> -	list = idr_remove(&fpriv->bo_list_handles, id);
> -	mutex_unlock(&fpriv->bo_list_lock);
> -	if (list)
> -		kref_put(&list->refcount, amdgpu_bo_list_free);
> -}
> -
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  		       struct amdgpu_bo_list **result)
>  {
> -	rcu_read_lock();
> -	*result = idr_find(&fpriv->bo_list_handles, id);
> +	struct amdgpu_bo_list *list;
>  
> -	if (*result && kref_get_unless_zero(&(*result)->refcount)) {
> -		rcu_read_unlock();
> -		return 0;
> -	}
> +	xa_lock(&fpriv->bo_list_handles);
> +	list = xa_load(&fpriv->bo_list_handles, id);
> +	if (list && !kref_get_unless_zero(&list->refcount))
> +		list = NULL;

Since you have this protected by xa_lock() now you don't need the kref_get_unless_zero() any more and can also drop the RCU handling in amdgpu_bo_list_free().

Alternatively stop using xa_lock() and use the RCU read side lock instead, but I clearly prefer this approach here.

Apart from that looks good to me.

Regards,
Christian.

> +	xa_unlock(&fpriv->bo_list_handles);
>  
> -	rcu_read_unlock();
> -	*result = NULL;
> -	return -ENOENT;
> +	*result = list;
> +
> +	return list ? 0 : -ENOENT;
>  }
>  
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
> @@ -219,12 +208,12 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp)
>  {
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	union drm_amdgpu_bo_list *args = data;
> -	uint32_t handle = args->in.list_handle;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct drm_amdgpu_bo_list_entry *info = NULL;
> -	struct amdgpu_bo_list *list, *old;
> +	struct amdgpu_bo_list *list, *prev, *curr;
> +	uint32_t handle = args->in.list_handle;
> +	union drm_amdgpu_bo_list *args = data;
>  	int r;
>  
>  	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
> @@ -238,19 +227,19 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto error_free;
>  
> -		mutex_lock(&fpriv->bo_list_lock);
> -		r = idr_alloc(&fpriv->bo_list_handles, list, 1, 0, GFP_KERNEL);
> -		mutex_unlock(&fpriv->bo_list_lock);
> -		if (r < 0) {
> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> +			     xa_limit_32b, GFP_KERNEL);
> +		if (r)
>  			goto error_put_list;
> -		}
>  
> -		handle = r;
>  		break;
>  
>  	case AMDGPU_BO_LIST_OP_DESTROY:
> -		amdgpu_bo_list_destroy(fpriv, handle);
> +		list = xa_erase(&fpriv->bo_list_handles, handle);
> +		if (list)
> +			amdgpu_bo_list_put(list);
>  		handle = 0;
> +
>  		break;
>  
>  	case AMDGPU_BO_LIST_OP_UPDATE:
> @@ -259,16 +248,23 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto error_free;
>  
> -		mutex_lock(&fpriv->bo_list_lock);
> -		old = idr_replace(&fpriv->bo_list_handles, list, handle);
> -		mutex_unlock(&fpriv->bo_list_lock);
> +		curr = xa_load(&fpriv->bo_list_handles, handle);
> +		if (!curr) {
> +			r = -ENOENT;
> +			goto error_put_list;
> +		}
>  
> -		if (IS_ERR(old)) {
> -			r = PTR_ERR(old);
> +		prev = xa_cmpxchg(&fpriv->bo_list_handles, handle, curr, list,
> +				  GFP_KERNEL);
> +		if (xa_is_err(prev)) {
> +			r = xa_err(prev);
> +			goto error_put_list;
> +		} else if (prev != curr) {
> +			r = -ENOENT;
>  			goto error_put_list;
>  		}
>  
> -		amdgpu_bo_list_put(old);
> +		amdgpu_bo_list_put(curr);
>  		break;
>  
>  	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 2b5e7c46a39d..0989f1090c63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -58,7 +58,7 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  		       struct amdgpu_bo_list **result);
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 6ee77f431d56..88f104041157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1445,8 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (r)
>  		goto error_vm;
>  
> -	mutex_init(&fpriv->bo_list_lock);
> -	idr_init_base(&fpriv->bo_list_handles, 1);
> +	xa_init_flags(&fpriv->bo_list_handles, XA_FLAGS_ALLOC1);
>  
>  	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
>  	if (r)
> @@ -1492,8 +1491,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>  	struct amdgpu_bo_list *list;
>  	struct amdgpu_bo *pd;
> +	unsigned long handle;
>  	u32 pasid;
> -	int handle;
>  
>  	if (!fpriv)
>  		return;
> @@ -1529,11 +1528,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>  	amdgpu_bo_unref(&pd);
>  
> -	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
> +	xa_for_each(&fpriv->bo_list_handles, handle, list)
>  		amdgpu_bo_list_put(list);
> -
> -	idr_destroy(&fpriv->bo_list_handles);
> -	mutex_destroy(&fpriv->bo_list_lock);
> +	xa_destroy(&fpriv->bo_list_handles);
>  
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;

