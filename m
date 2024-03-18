Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A75C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 13:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA64F10EF09;
	Mon, 18 Mar 2024 13:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQFEYv0g";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C2D10EF09
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 13:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYvEPsMY0t4aut7dZlkpk96WcM2ZRiyCp+EUtEDNjYEw6TFalr33J1lQ3+np/z236VA6jdpzem6flmPKoBv2etTrx5TV/SyH6/P3b/ZkE8O5hUjW6sJvenhpM6Ea0fit+WTrYwdKAKyfkqIwrH5F2lidiLHZCAhoejUYyLUuLu36RbhAeMmY4Tb5fq6DdXlBOZpYhOfO+BitnuZqrCjFChqo+oW3Aksc4kU13sRVuvfjJZpv/NMKws5RVRq3WAOnL+epMypSoY7VlmXJgrxZLSWDknR4AYGtDWu4Mg1bZS7+E0IXKHHHJqjmfq6IlZwAj/eqXodBM3KQorDJ5Hafew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbvlW/W/N/1DxHiEXSJEOdoNc/gBw8jeHS2a/v+YmNk=;
 b=VvM985FXQujhfFOXxyjmpk4eYJHxN2nM9WsZcTGXPF9eEZEksRhw9Nvpq3Nv5Z0d25lL81fwi1u2TZK19licnQpGfyYU9/KzxvfvuT+tJVKkvlodRT62VdXnjf9++V9taIlLgUufLPD8gRameq2io3dRltVKwdBOV0fjtXm4IWGDyns6iB8B0yH8f0k6EuX2E1rwan6wmsectxctNN7e4H/hox8O6nYSI8Rthil7YqH8EV0XuMcoI5YD35OUC13+V+L7djEvchRN4WIbtrrcs08xehUuTaH7aE+2gdBZRJj0n4wu3usiJCx6v2jgL9JPNECc9yzLPeq87zpQ+f9ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbvlW/W/N/1DxHiEXSJEOdoNc/gBw8jeHS2a/v+YmNk=;
 b=cQFEYv0gf0xSx1J3dtli7g2AGFIFGwgSmJx5QXD5uDiysU1MXmNEQT27pNC5U328iE+rJSOI9QPY/n13HHLdjijHOuozCk5BU17RhjOKKtI+f+10qWy7PCEXA5g8s7jXqzrnxk2eGQgMLD2ciWm+WCzE6G/j0DEofP9oJzTQp/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 13:05:22 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 13:05:22 +0000
Message-ID: <b094279c-e40a-4827-87e6-39acb9350014@amd.com>
Date: Mon, 18 Mar 2024 07:05:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Address kdoc for
 commit_minimal_transition_state_in_dc_update()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Wenjing Liu <wenjing.liu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20240318125027.2238100-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240318125027.2238100-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0704.namprd03.prod.outlook.com
 (2603:10b6:408:ef::19) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dc26f4-79ba-48f0-e850-08dc474c11ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CovmFHWC+RYn3MeiyyF65WuIbP61PSWtyx69DGfmLJnWUZ5zPomRoMP+nFk97ISj6bh2mmaJTlcplJvqGq8/W+beUTQloI0oT0BCnHsa3vBHjrLpTZ2XmPKy9queBWzhJ25utK9YaD3wgb2cWq96wLl6zFpSSj2AWYDgVMUQ0hvRRcJ6bWleMjZ20QTr9B7cEyPKw/wITtU2xJ2rqtZX9nOJpUEvpbj/pVzvEuFTY5vg2O/mmMqFGG5DRtfPuIFBqZGGycJfsyySmaitgtxgjkQEX3QiEYmOQRzmShhONQaX0zF95H2k8f6unVPMForX9iTgLNojGQarQhZ2vVgBVTgDGft51cMj+nU7q8OeI2Gq41sCoSbNjI2wgDAxyeYkMoIIiBYMwaQXtqEiYU5dB3Da2woaatMQBuyOTPhV8mdtJuUlSyp1xCnbHWsp+WpwMJ806889+vZBjL6/V0gY/e1pZpa1BOoKU3Sj2OSDaqBpKrE3LwW2/vK0yVe31XlN+v4fm29H+D71k4/0ca3X2cWJv0A8/c6DVZsyqrvC4HWHnJpMBdBO4t6JlyGYyRkIgLR3EgAzoi+Xb91Dt/uHXzbCsfzs0Sh2WO8NyyOSlsWqNqh/DP0hvHW/ljtVMdAI1sNODIx1sF+AIshCbffmbEemRkCsrXMc/pc48OzeQQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRjdk9XZnJGZms5dURROU5jcXJ2bXE5MHpibmJIUjRGNkp2YkdaUUZVOUd1?=
 =?utf-8?B?ZUg2NWJJTjFFV1ZxMlVqekg4MmtRQVZFQUlCMmtBd29pT1F1NmFLdTczUUhD?=
 =?utf-8?B?MGFCUjhSY1h4a3k3MmQyTUtHeXYybEcwS3hZWlVkeDhDMHQ4SjFONEFyM1dr?=
 =?utf-8?B?cVpUYzdVWFpOU1AxbmVNMG92cFN0TThHcTI3ZkxOVXBQOHhvMW1LTTJOaDRs?=
 =?utf-8?B?aHpCRDBIUG1PL0ZnaFlqa3JsdVRIS25SNkFYNjBVbjFuWGltdjIwdUFITHgv?=
 =?utf-8?B?MC9MK3BSNWFKQ0orZWlMeFovUUpHOUlmYTdEQWRjTGlWWElqek9sUGxiOWxE?=
 =?utf-8?B?cDBXc3FMRFJWR01NKytSdWU1YS9pZ1h0R1dNb3hlVzd0OEJTTmdJeTJHWTlF?=
 =?utf-8?B?eW5hUzMyS2RLUEZVMkxYTkZmVTJENjNxZWorcmJDdGJzZHpjMHQ2c2J3aGNL?=
 =?utf-8?B?TkRNckpRdVF6MTZXbkJGWXFCRGxVdTdxdFIrWkxSdTBXaVJwVjNlUEZ3KzNZ?=
 =?utf-8?B?UTdVQm8zWXZYZmhFemNBSjhWT3Z6WjZmdW1mR2RZWnNPOUwrY3lqeVRsZGNx?=
 =?utf-8?B?TG9Td0hFbVNuQ1owQmhYdnpMeUFxNm5MVmhMblNYeG1iVGhrT2tsSWNRUm83?=
 =?utf-8?B?R292Y0UxK1BqQUlVaVNQcEd4S0o0T3dUZ0JqNTZDQlZyQTREcGlaeVlySnpj?=
 =?utf-8?B?VGZ0ajZyM09FSUpVUHRXRkxvTVJGYVRaaEF5Wk9NcnUrYTZtK0lHWjBlVVho?=
 =?utf-8?B?YUpYWjVlQks5c2ZENHc0TUVqdEoxLzBCTVVwZHBaVmNRZFh6SGIydTRVd2M2?=
 =?utf-8?B?bUZFWVU3OWtIMEJBWm4vb1A4WFMrMVZDUEdoY3FPZmJWS2JHNVN0WFY5Uk03?=
 =?utf-8?B?eU1qVFQ4Z2ZESE5qWENCM3FQc3BEZXJuTTE1R1I5OXgzUTJNdDdZMXJqTzFz?=
 =?utf-8?B?bTNocVZWWi9RL21uMWV4anFKQmIxWm1jbE5uNTV4cWdJUzQzV0RVZnk2d0NM?=
 =?utf-8?B?VnBBKzEvbzNEYm1ZWERvOFg1c2JJOUhRNFFsdDAvQlYwcWoxS3FEenV0aTlH?=
 =?utf-8?B?d1I3NmF0eGJVWWpoaEtHZlpUdXFpdHB2Ri9xS3ZvR1NyNHEvUndUb2JwYlVV?=
 =?utf-8?B?QVRSTDlDdks0aW9nZUNoMVd3cTFjdHBuUHNjQ3FQK1pKQzRoYUtwdW1BQ2Q2?=
 =?utf-8?B?M2RiQ3g5L3d3dnFXWEVibHFFbGlxTlJkbHd0UFFiczBjaE5Lc2xHdFd0UW5L?=
 =?utf-8?B?VGxER0Q3cC80NWxweXFoSldyLytNSDF0WEc3SHBMVktrUmE4ME5hQVhaZ3FS?=
 =?utf-8?B?UXZtaENFNk1BdklObDY0UHJmOGhWemc4cjcra0U0eVkrT1hXbUluZ1pQS0JP?=
 =?utf-8?B?NklvOHFOY1hCd20wUThTQ3VwVGJWVmYzZDFwTE12MlFGR25UL2sydVM3ek9v?=
 =?utf-8?B?bE5YUFV0REZXdjArdlROd0VTNFhMdXZ6VldqcUZwdkszbjh3c0UwS0RWbE5o?=
 =?utf-8?B?K1BYK2ZrZ1lRcFRidmhiZmVYOG1WQS9iaHB6ZWF4T05DWDRUbFdBTlRFV2R4?=
 =?utf-8?B?U0kyTDM2U0NadTR3V1l1VGgxMGxySVp1RVc2NGppS3BTU3ZNYVd2K0pkSzBE?=
 =?utf-8?B?NitsVGY1VjJ1ME84R3g5N3dnYkV4d0pvYWh3dDlTSmxqRkpyT3czSnZ2NlBs?=
 =?utf-8?B?QWxVUTFjS1p3RE9kVG1QOFRMcU5NNzUxajR6SThhQ2hvM3pPelZKNy9CbFlt?=
 =?utf-8?B?ZzNpRlFuS3JXNEs1aUl6aHh3eitLTXg4R1lBdFJLYlBvSmxpUjNuVjNIMDVS?=
 =?utf-8?B?ZkRmL3liL3RmZ0pQbGJ4dmpqcENuaXBOWVZ0TFNuU2FhaW5CYWFVRVgrc2xk?=
 =?utf-8?B?M1c2SmhaamFMTWpPTm85TmhkNHdDTlBzVmVhNG5ZbThmOFZlVzFIanRsS3hS?=
 =?utf-8?B?L3NnWjdQbkZiMGt2R2o0aitpaE1lSnBMM1hJbUxFa2YrWUtvdmR5Z3FtczBx?=
 =?utf-8?B?RmtOZjRLRXdiamU5YnNZN2EyY1p4dmhZS2I4cE9LNGMyVnZlRnlSZWxXQkQ1?=
 =?utf-8?B?ZXE3S1hvVmF0M2U2KzVYZ3ZyMFhFUW9mejRjUjRVTHEvTUFYZVd1R2hqNFNy?=
 =?utf-8?Q?axjR/H5CSgc2Ja0dNEWN+tbdQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dc26f4-79ba-48f0-e850-08dc474c11ce
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 13:05:22.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKFI0sMBIfFIJi1/ZPBnacYpSBJ12Jqw1kUnof5GcK1XBwAyzF0HmbLdhZau+Pi9elSnab3Nuf5vQSsjpobkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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



On 3/18/24 6:50 AM, Srinivasan Shanmugam wrote:
> Adds descriptions for 'new_context', 'srf_updates', and 'surface_count',
> and removes the excess description for 'context'.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Function parameter or member 'new_context' not described in 'commit_minimal_transition_state_in_dc_update'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Function parameter or member 'srf_updates' not described in 'commit_minimal_transition_state_in_dc_update'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Function parameter or member 'surface_count' not described in 'commit_minimal_transition_state_in_dc_update'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4411: warning: Excess function parameter 'context' description in 'commit_minimal_transition_state_in_dc_update'
> 
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 119eee2c97d4..08ca97bb4160 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4391,8 +4391,10 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
>    * on current or new context
>    *
>    * @dc: DC structure, used to get the current state
> - * @context: New context
> + * @new_context: New context
>    * @stream: Stream getting the update for the flip
> + * @srf_updates: Surface updates
> + * @surface_count: Number of surfaces
>    *
>    * The function takes in current state and new state and determine a minimal
>    * transition state as the intermediate step which could make the transition

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

