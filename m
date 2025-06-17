Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600B9C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 11:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA2110E61A;
	Tue, 17 Jun 2025 11:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="weBlBG/n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1401E10E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 11:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC8lw2iCIf9ugYOmt3hjlVsntFsK+oId64JqylPWp9UIuKGaBeMUybM0uxHUw+HZbLWHXFEnqdfxXlh60tJ43ytSlm8kp/ZB4BmUZ4ic7P7/YgdCRm9OVRmRNGus/D756/w6KF0w3VNRHbAWr6qAAookLKFskhDbmFkjmI8u5pO1F+gA7I2asrjaa7Ru4GFQ2KqoUDTNDqFeDNYwqVTqI9N7CoNG5gYjfCbFkwjxzaqEWw1tj7mKJoUCTSMBturCvNagbrr1vneP7IMnHxkyKC/0dJInyhUVrRcjALLW6WMN7Qx6VVRbaw4QGZGjsDz5wmZleNzPhAosx+YcnrJksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMm5SorGpN9HZI1LahzL+B2zmDeT5tk4UFxXzaXXl+s=;
 b=d0Z9c2UgeUCRuJWS07XOj2+V9IqtDLHkll9DIUjdA8XlAMv9c9jB6Cjr7mdhnZmIpvng/UKTQOqimzfGPO2vzQXA2lZQXWFP4VuG+P9TijmMXYTCwNLk9rXKsdHfo5bRf0ZJVJDLn/n1JrTlaqlKs9KfkHByiukn3AAihHRJXYMRg2zIVQWsqsy887AqyjcT15v7zRdnpwI+lJ4iRrHhlhUjrG6S1oHBs63b6p8KvdbBaSKErYBkTNfa5UpDc27KEHmO+V7NSvPa0nWoEhTZIKwOl27hfIkgTxO0kmlOP6U2A7dTgGYnfxGPMVCOpRPONLZSY5FraQ9gCfUTgFESpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMm5SorGpN9HZI1LahzL+B2zmDeT5tk4UFxXzaXXl+s=;
 b=weBlBG/ndvVZ4cSeU5wqVWFgmQTb5ZpoTgYbeWKadIyIhWuYwQLNXq+6ujBk9pzlZrJjHuHj3yhP+ESNFjja26iX4R4BzAvxDtVf6J9VgYg+PhJJy4JkyRBDT26tVm9DTmtWoUL3Xl69JlmypV96lbu5k0wHjwTi7bQjGpvv0CE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 11:44:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 17 Jun 2025
 11:44:47 +0000
Message-ID: <81b40a5b-2747-41ef-ada5-7af0f28b33df@amd.com>
Date: Tue, 17 Jun 2025 13:44:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/36] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 4110093d-5788-4139-1c49-08ddad945c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1R3d1Z4bUd6eUxUM1B4NlFic3hBM0E1VXRDYWFRSDhURzI1SU1OVnY0NlBm?=
 =?utf-8?B?c1RNZFVQZkdnRmhkd0VWbWw5ci85cUpqZU1IZkU0b0IrOUZLcUNsYkUwbnFw?=
 =?utf-8?B?VXpXRWJhSHhqdXRMb1M1dEZ2ZzRIZWx3dTNPcmkxZkRJbTVkNngrTloyWHc2?=
 =?utf-8?B?VWtkY3JZZHVxMSt4TEhtSWhtdzdrTXhMZ0sxUTlvUGFqeFRwd0lTdktJZXE2?=
 =?utf-8?B?YnJ0MmJORVQ1bFhMQnpqL0pkVnNOLzNpczVVZnp4NzhQZGM2QXNocVRCdWxW?=
 =?utf-8?B?Qlh1UVdDSW1EdFIzRUo3VmdkeFhKMEpBNDREYlUycFpOVGZNM3BDRUI0bzlQ?=
 =?utf-8?B?ZTJzdkJrYU1Vcll6dTVjS3JLcUppTmZSNEtERzg0TWgrY002RXFYYVlMVTlO?=
 =?utf-8?B?MVptdkF3VndPQkd6MEZSeWRYN2ZzTlYwSGpBamdjazZyRlJiRU9nSm1HMVUv?=
 =?utf-8?B?L1VpeTdPcm9qQlFvRm53N1JxMlFqQW5lMVRtekpPZHovNy9YbWZWUjN5emd2?=
 =?utf-8?B?Zkw2U1dUY2dQeXQ1Y2p4SnNrRWozUzdRaDlxcVZZZmQrbklhbUZ2ajZNRHdF?=
 =?utf-8?B?LzBWUEE4a2VlTE9ITEJzZ1VVakM5aXFDWWxycFJMNGN0R2FmQXM3dTdtN2lF?=
 =?utf-8?B?eWZuYis4YzdOSlA4dFR2L1lSVzEwRUxvQmdJZW4xWG9QTXZ2RVhVajFia0Zs?=
 =?utf-8?B?QmpHNERrMEdXaUlOY01SdGhQZmNKck5tSHp4cDNNVFAvWVc4aFV0b1VrdlRt?=
 =?utf-8?B?ZXYwVll6dDNFOThOREF0aDJWRkdBZVgvVzJVV0o0ZUR1SEVKV04wOGpYS3JC?=
 =?utf-8?B?Y2ZJSDVmb1NtVTlYSlV1NWhJTkIxWjJ0UmpaZmxITTN2blBDdWNFcE0rN3Iy?=
 =?utf-8?B?aG1FYkloWGgxUlh5bFNiVTNzK25HZWo2djJsZnpST05GdGlMTVErM1VtTHh0?=
 =?utf-8?B?UHViL2NDc05zVThLSVVoNEpuQUJ4bmZuQnN1ZEZvRXQzZzQ3dlBOTWpIK1I3?=
 =?utf-8?B?eS8rUlUxNmw5b0h5ZGlnVnd6SzJadDZkbmtSY2ZoRCtCZEJvSmhnT0FCN2Rs?=
 =?utf-8?B?Tk1MV3ZkaVFTUzJVR3REQ1IvZkV0MlhONmo4QlFyRlVPbzBKaFpSb0VkR1dI?=
 =?utf-8?B?bVVjaTk0Y2puTXl0NFNvdE1wRCtFV05oQ05FTWNTelJZaHltblB6QnZPZ244?=
 =?utf-8?B?NnZSdFIzQklKTlhhV2JqaEpvdXkzT0QzYW4zYTcwclptVy9USnRsTkY3and6?=
 =?utf-8?B?RzZabCtxcUNtUTR5VjRITzhhN1QvcmxZakh1eFpXU2RTc2lNRjc0NUtsWmF2?=
 =?utf-8?B?NGxlNDdvczVYS1lzTm9nVnpieHRiTm1uck5zczZCMUhwZG1sWXNlYVVyZ0g5?=
 =?utf-8?B?MlljeEpEU045WkxCS1JRSEtyZFZ6bWVMcEJrY29tREZBb09DMjViems3emY5?=
 =?utf-8?B?Zjk3Yk9zVTJaSnFKcWFxNkYrUDMzaFVFa2FHT3lxQW05WFdWbkdaOU5tb1RT?=
 =?utf-8?B?a1hrV20rRjg3LzBaY1RGb1laUU56MHJiU3NiOWJXenFSejRZNHRHbWxZbFNp?=
 =?utf-8?B?KzFGNHB0NEg0a2ZBZ2pzVmZsRldLZm9TNkNYbEJaaTFyMGNzUnFWcnJ3ZjFP?=
 =?utf-8?B?aFdnZlZCSitITE9zUmc2K1c4NzU5NzBRZGVSclVqQys1UiswMnR0ZFR5US9y?=
 =?utf-8?B?ODJkY0d1UnBwRzIyTEdWOSt6TkZqMk5PcEx4RWdVc200Z0ZpSzFVWk0xRUZE?=
 =?utf-8?B?bVoybUcxM2JXd0ZvR2xJQ211RjhKUE9WeXgwaWRCWXNNVE5QaGppdDljaG00?=
 =?utf-8?B?ZWNXdjQ3Y3ppNy9WUlpVQnhHZVljbnVlZEhkL2x5cHd4MjliMXp3eWgzSFUv?=
 =?utf-8?B?LzJnSkM0Y0xESS9kcEEwTnAvSlJVWWZKN0IxdGN5b0tQVHY2QzE3QW13U0hl?=
 =?utf-8?Q?63OIDthQ2zE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RnZVg3cnFlaVNndGVwMmJ0R0c2eElXcWlteWlQV0xzWFVXRHljM2tBbHkz?=
 =?utf-8?B?b3F3UWVkRlAvWmJUbGdNTFRaaWM3L0pqQVk1aWVRZ1YzaHpBNzgvcXk5WDVw?=
 =?utf-8?B?dC9oQ3pvYmZGRlo2MU5DWnZQeDlsakV0NVhOVUt2eW9paUVBTnk0bFFFSWIz?=
 =?utf-8?B?R3MrdnVGY0RDdVppY0ZaM3JJb3NTNGovallYWDhtUUdnSW9GdG5kS0RYSVJn?=
 =?utf-8?B?K1NiLzFWRUtlMXJITTY4WWk0a0tWYi9zV2VNdzBERkJ0NkVYUU54aW9qd0tw?=
 =?utf-8?B?clA4cWxURHFTWlllYk8vVXA0K3JEY2l6WlNPdERPY2xaM1cvaUZkVTVpcGpH?=
 =?utf-8?B?a3Y4MElaUnI4NGF5YllFR2k3VW1sUkJCM2tSTE5HOVJwS0VkVkhvQXJZU0lF?=
 =?utf-8?B?K1FET2tueE9YendlTCs4SW5ScndVVk5xalBqZThJaWplbmhNMFNQSFJpd09O?=
 =?utf-8?B?ZnBySlFlRFNHa09ML3V4dnhEMlpLL2lUekJ0OHJhQk1YQ0dKVGhkSE1kMk1C?=
 =?utf-8?B?Wjl5OUQxYXF3MXVQbWE5OHErbmhuNDBGeVl4NmNmTEpxcjJwUllCRkx0aXR4?=
 =?utf-8?B?cWppNXBaajVjTld3MjJYQVVtcThob1hVTG5RVVg2eVN4YjI3N2U5bEF2cTY1?=
 =?utf-8?B?QllrUEs5cHltNkp1ai9PSDIvSEJ5KytrVG1vR3g5aHY2K0tNVkRqcERDejZl?=
 =?utf-8?B?bWUrWFpPcVRpMU93bTJ4VlQ3ZlVqRHJjdUVid1R4WEJoUXZMdXRPRm9lRWE3?=
 =?utf-8?B?d2tzT2pPZmhLT2ZLNTVCdWNQSHg0MitreG0wRW8vUjIxMnp1U1prZXh3RVJQ?=
 =?utf-8?B?KzBvSTlxMDA1TXU2ZUwxT3dLM1R1SzRiSnNGeW82cFJLUCtaaDBVSVhwZGJ5?=
 =?utf-8?B?YmE4YzlDbTYySzI2RzljVnQrMFJHSXZxZFZjVzA4WDJvUXRvd1FXRFBnNUFG?=
 =?utf-8?B?REVTRU0vTjdONWkwRk1IMG9HUUl4Z0FyeEZEaTQvZ3pqampLbEtTSi9pdVNS?=
 =?utf-8?B?Um0vWEVGQVozRzRXTFQxalc4aWZnWjBna3M1L0FUallId291MXFjVHVzajZG?=
 =?utf-8?B?TlBtZHZjWnNuMXNRYnRycDRhQ29wclIyWDBtTkU1cG1SVEl0QzJ6N05nWTcw?=
 =?utf-8?B?ejJReEdUTjlEeG0vU3U4SWVkSldrUWNpTHcvQ2NtV0VuRHJMcWJhZ3p5SlU1?=
 =?utf-8?B?TXhXR243YkV4aDVSQ09KNjRVbTZMNEh4UVRJMDFMNStITHpNanZzU1BHNEFT?=
 =?utf-8?B?QlhwbmpMZUdZUUk5OXBXQmJDQWpjTjFDb2N5bzlsWElwVlpDMDFoMTVwVkMy?=
 =?utf-8?B?NlUyM1I3V0cwaHBWV3pESlZCd3hueFFNNnFYb2RldzBrVENIZVFlNHprM3dE?=
 =?utf-8?B?M1AweGtoYk11cU42SXlRMnNkcHFEeUh6dENnTWJxajRub2QrcmRTenJCckNt?=
 =?utf-8?B?MWRIZ0xpQW9UUUtIUGMvTFVma29UVDFnUG4yT1dEYW9Gd0cxOGEyYnlqN1pT?=
 =?utf-8?B?SE1hTnRVcjFoLzl1Mmt4UVdkSU82dGtUZ0I4bWlMQ2hhMjY1L2dnS0p4VmNT?=
 =?utf-8?B?TFpsVGVmTkNBb3pUcWVPR2Y3bWhtOFhNaWYrOGJzWTFGMzZmMUNtbXR1Mmw0?=
 =?utf-8?B?QmJuU2lWY3RmV21IMVptdlplVnJVemdwSnhzTkd4blltY2pqTUlxTHpNS2Mx?=
 =?utf-8?B?d0h0cXdhZ0szMmJyL2ZLdlZQREE0WEh1S2J0aXNVUVFhOUJFcHplb0d5Y0Rt?=
 =?utf-8?B?ODZWMmJHWFN3L1krZnFITHptRkxXL1krSFhmalF5dnRkcjFpZHdqWTlvWWw5?=
 =?utf-8?B?K1pDVjNudmxMZ0l2eGJGbmtCRzBqc0lUU3RIVGxSbkFhOVRXMHhWOExnTXJT?=
 =?utf-8?B?K2MySkpFWkxIRG84eGl6OVRQUnJxTVNMOW1Wa1ZxUlJoUktDaGUya003dVc2?=
 =?utf-8?B?dVlOZTBqRFhONTlzYjh0aERLb2lQOUpTcFdkdE5YZEwybGpMcytJci9SODRR?=
 =?utf-8?B?S0ZjMmVxNG9DYWFLdzRIOTZrd2hjYlpheFNKUzAvcXBKRHFyZlRuaFgrMmZJ?=
 =?utf-8?B?a1NqM0FUTnE4U1hHdVRqVGRQeDVqVnM3OXp5SUJKSmxQdnZvQ2tUZ0FCYVVK?=
 =?utf-8?Q?WnJiYS9P4P5KVL1mYJzHVwycu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4110093d-5788-4139-1c49-08ddad945c46
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:44:47.4492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPQLyAiAtgm6jcFqV9SN96M4OJbWBIjbQCymx1QdBrzrqtzN5TwaGrfk/MViO6Dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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

On 6/17/25 05:07, Alex Deucher wrote:
> What we actually care about is the amdgpu_fence object
> so pass that in explicitly to avoid possible mistakes
> in the future.
> 
> The job_run_counter handling can be safely removed at this
> point as we no longer support job resubmission.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 36 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
>  3 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 569e0e5373927..e88848c14491a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -114,14 +114,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>   *
>   * @ring: ring the fence is associated with
>   * @f: resulting fence object
> - * @job: job the fence is embedded in
> + * @af: amdgpu fence input
>   * @flags: flags to pass into the subordinate .emit_fence() call
>   *
>   * Emits a fence command on the requested ring (all asics).
>   * Returns 0 on success, -ENOMEM on failure.
>   */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
> -		      unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> +		      struct amdgpu_fence *af, unsigned int flags)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *fence;
> @@ -130,36 +130,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>  	uint32_t seq;
>  	int r;
>  
> -	if (job == NULL) {
> -		/* create a sperate hw fence */
> +	if (!af) {
> +		/* create a separate hw fence */
>  		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>  		if (am_fence == NULL)
>  			return -ENOMEM;

I think we should remove the output parameter as well.

An amdgpu_fence can be trivially allocated by the caller.

Apart from that looks good to me.

Regards,
Christian.

>  	} else {
> -		/* take use of job-embedded fence */
> -		am_fence = &job->hw_fence;
> +		am_fence = af;
>  	}
>  	fence = &am_fence->base;
>  	am_fence->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
> -	if (job && job->job_run_counter) {
> -		/* reinit seq for resubmitted jobs */
> -		fence->seqno = seq;
> -		/* TO be inline with external fence creation and other drivers */
> +	if (af) {
> +		dma_fence_init(fence, &amdgpu_job_fence_ops,
> +			       &ring->fence_drv.lock,
> +			       adev->fence_context + ring->idx, seq);
> +		/* Against remove in amdgpu_job_{free, free_cb} */
>  		dma_fence_get(fence);
>  	} else {
> -		if (job) {
> -			dma_fence_init(fence, &amdgpu_job_fence_ops,
> -				       &ring->fence_drv.lock,
> -				       adev->fence_context + ring->idx, seq);
> -			/* Against remove in amdgpu_job_{free, free_cb} */
> -			dma_fence_get(fence);
> -		} else {
> -			dma_fence_init(fence, &amdgpu_fence_ops,
> -				       &ring->fence_drv.lock,
> -				       adev->fence_context + ring->idx, seq);
> -		}
> +		dma_fence_init(fence, &amdgpu_fence_ops,
> +			       &ring->fence_drv.lock,
> +			       adev->fence_context + ring->idx, seq);
>  	}
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b39..206b70acb29a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_ib *ib = &ibs[0];
>  	struct dma_fence *tmp = NULL;
> +	struct amdgpu_fence *af;
>  	bool need_ctx_switch;
>  	struct amdgpu_vm *vm;
>  	uint64_t fence_ctx;
> @@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = job->csa_va;
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
> +		af = &job->hw_fence;
>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = 0;
>  		gds_va = 0;
>  		init_shadow = false;
> +		af = NULL;
>  	}
>  
>  	if (!ring->sched.ready) {
> @@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>  	}
>  
> -	r = amdgpu_fence_emit(ring, f, job, fence_flags);
> +	r = amdgpu_fence_emit(ring, f, af, fence_flags);
>  	if (r) {
>  		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>  		if (job && job->vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e1f25218943a4..9ae522baad8e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
> -		      unsigned flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> +		      struct amdgpu_fence *af, unsigned int flags);
>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>  			      uint32_t timeout);
>  bool amdgpu_fence_process(struct amdgpu_ring *ring);

