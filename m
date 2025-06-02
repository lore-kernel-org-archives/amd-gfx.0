Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA10C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 11:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9378A10E202;
	Mon,  2 Jun 2025 11:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aGiqw44A";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090C710E202
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 11:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB7GMYkywLT8nJoBiSpZrhE9rDVsOH71YbkHC2Yb5vO2G/QbF71F725T7SB8s2+2W7DmEE/XrBqQH19pfr5Y7Hj4RDDP3NKP2McGJ23Bo59RAv6eiZUCo05uOt1Y2pMnx2fT68v9XMJgE3QGlQ0lo6cCscfUmOkcUg3BTjOdb5sQRm22wngjjDX2nvpUqWgcV5aJI3aiwfOk+k51pJT86nFcCLPlbAXVqduL8PTAX0tpdYj6f3AFycg78uE6QDoA9dFUv380ORemyRp7Vf1xWE/D26LbUmuBJTBYblvS4JYWIJudbFjkWaB07dCuYJN4ZvPNI5GAkAdEz8UAk1WJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzuIXrGS6sXuBtLQ7COUf4FEWNRTRIvgAZgv5kK1aM4=;
 b=va71jCi9jQp4DeGtMAF6C8jeJNuhg6Nykm+lcJr1eH4C8EcKJ6zEZFreINNsQPbRcNdnugmakKqq9zcVXZbm1BXl9wBvkp+I/2XiWd8pXdVXH/11hAgD33/2vhpIVVobm5sQfOqMmxompfYlOr93c2ItlN0YIw6zJmPT/e61P04wkmjUvQAE9MPjnxooGwqKhn1gIM/jrtV0FVO3EzZLzOpQoKEehRnKezth65530cUO3dQyldVwDxFh8vPzpKnhYWKQhUbHAzVY/SuVa3paTYBNFSp8B0aqLnukh2K58Mg6j/4LpqQfMWN6nhCnKSpNcIg6erS8VTuln5buVi7qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzuIXrGS6sXuBtLQ7COUf4FEWNRTRIvgAZgv5kK1aM4=;
 b=aGiqw44AXheEL8X+DrGcBnvHvc1k0Q2YYcfIiME5wInf51vEeZNKAR3u13eXURNVnhTjUTWAMulXHmY6RTmJphA7eKBcs6hz3BspU+5foKaKRB8/2Wa4pqCGPFAM2j5ZMTuJimTRK6wWcCB0piS8ri8Rxm2NmBxLzRi8F59wi8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 2 Jun
 2025 11:06:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 11:06:29 +0000
Message-ID: <a6c54eeb-17c7-4084-99ce-b4102aeaf3b6@amd.com>
Date: Mon, 2 Jun 2025 13:06:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu: add userq object va track helpers
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-5-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250530075505.882004-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ea67c3-c21f-4d70-95fa-08dda1c5865f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHV2eXgyVUNYR2R4djlKVTFvZUhNY3BFajNlOS9WcFVRSnNRRzNpejduUitl?=
 =?utf-8?B?Z1hWRWt0ZnpBWldvc01qREhDY2poZEkwMXE2eGpDR0c3T2kxZ3ZXUVhXWTF1?=
 =?utf-8?B?M2l0bDBHLzJtcDBNZURxaThIQndOdlo0UnhjTGRwaGw1Y0M5QzlLbGFQZnN3?=
 =?utf-8?B?Y0xmTlpWQzB0aWdTSExMVkg3MHQvSjVkbEhIcWxHV3FHMXVpQTEzNjRqcXJk?=
 =?utf-8?B?VERJcjFtdU5FV3RZMW5BZGVTWVYrL1M3eFM5VnNBcTN4MlJpNXlQREs0eDdK?=
 =?utf-8?B?dFZFM2E2UTcyaFJNUVFsM3RHYmtTeTJmdWdUcFkyZHgrTmpURHhwMkxFbUNu?=
 =?utf-8?B?Uy9nd2YxZjVmQ0VGY3VtL3ZOckhnUU1UVEEzTkN3WlFGSW9vZCttdzUxd1Vu?=
 =?utf-8?B?RXVhYXhwaDF4S0l3OUkwbjBsR0wxK2RNQUhQWHBqTjEzV1JJNDNCVUxDZW9R?=
 =?utf-8?B?anNUR1ZhSzhXcDNZS1REeTMwSXFUMTlZdHdZaHloZ2dJN2Z1OU5FQzJIdCti?=
 =?utf-8?B?cCtTMkFzOHhkejNTOEVoZDFYRTRaSVdhc3BIdzZwRGwzR2V6VUluSDIwOUhx?=
 =?utf-8?B?TjUyTEhkRzZzbEQ1R2dBY1ZMbEdOdEZmTE03NmFsSzEwZWtCQUY2NnJJTUJp?=
 =?utf-8?B?QlczTHRZcEtBUlVZVm1QTVFlMDZobk9hTW8zemVpbmxRRmlxNi8rUkQyQWti?=
 =?utf-8?B?OXIxTUtIM1hYb3pVckYzbUhEbHJlcHpPZks2aUZncGYzcDBNazhxRGFmQkZ5?=
 =?utf-8?B?YUFheDNCbkRoSWxUcWlvMXhyeGNuVVJLQWM5ZDVFU2dubGE4L1VMVUl6eHZM?=
 =?utf-8?B?ZHNLSDZlMk1hL2JIRDhBRVlBUWVhNWxvQzZCOThTcVAzRXdmcExEbVhjelB6?=
 =?utf-8?B?dnhlSHZZTVlsQVRWc3VHeXFEWnJYZVU0NlUwclgrcHN4NjJYdk0wZGZSb2Zs?=
 =?utf-8?B?bWVRVTJlUHpsNmx6dVZGc0lRQ1FkQlRTUURDdE5KYkxYMkdOcWwxcHA3YnpS?=
 =?utf-8?B?T1JCaDR5QjUycklhUTNzeHN0YnZmK1YyY29vMWx3aHRMNitNc09KTFNmVnFB?=
 =?utf-8?B?ck1zQU15cjh1Q0hzcHlBaDFhejNuNWpkRGJVTlg0QkVZMUJtSGdyL2g1WjlY?=
 =?utf-8?B?emRHRmdLdk1OaUUzblV2c0lBb0U0WXhiek9WQk15RWhrR0J1Q2dtNzFyWTg0?=
 =?utf-8?B?OUUzTlBQeXBnS0xabHJoVEgrT0pKT2Z4VWp4SWYvSmdTVll0azBOUHphc0Ji?=
 =?utf-8?B?ek04WTNBWm5mZkoxYTNJdFhaV0hsYmFqK3hoNnFrd2t3VFFraFpzR1pEYWkw?=
 =?utf-8?B?dUdmN2hScDQ1QnJHV2JTNlNXS3NhcWZvQjhHUW1mMjg3NDN0RWlNeml0cU5w?=
 =?utf-8?B?ZVdVclNTUzdHOWZEMndQdEk5WFdkS2dubWNvWmZTWTdqUlBvdUV1SkdIYzMy?=
 =?utf-8?B?TG9oczJSTmt0VmR0RE5TdFZBekRiUGUwUTg3K3JTdmQzVFhzQ1drQVd3Ymoy?=
 =?utf-8?B?VlB5NWdoKzd6RFhRdkdYZElIUXd6VERKVGpHVjZCMHJVR2N2cllDOE9KYVI4?=
 =?utf-8?B?YTZ4UEczemRLZjdHZjhCbTY4aHBPQXRuTWFwRGxnY2hmWmRDcUUxUzJHc0Nk?=
 =?utf-8?B?UGZRUVkza2JkeDZDUzdOVVlMUW9WdEh4MXRsL05ZOUY0ckpRMGo2R25pWVhS?=
 =?utf-8?B?dHpOcGhYbHRMVTFwakkyR1lJajVZRkE1SURBL3NyN0lKRmJLQnNYbVZLQ05U?=
 =?utf-8?B?Ym1sc3lTL2x2MGtRakNSMll2cEM0MGl6cTljNGowZE1VV0dOdnBwaGtld1ND?=
 =?utf-8?B?MEFFN0JNWE9qbXNKVzRkSDJkMWczWWJyOXNEcVR0bkZGbFZaeXk2eEQreG53?=
 =?utf-8?B?STdLUnMvc3VDMUYrRGUzcDVEajJoRm9SVit2THdFU0l1Zlo2aHh1RTdpSlJk?=
 =?utf-8?Q?9LXiFzD/Xg0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGlCK3JNWWs5bUpacnlVNUN1ZU1LVldsejBkRCt5LzZNekY5YU1oQllXRnhD?=
 =?utf-8?B?OWpQYVNhb0hiMTl6NVNhOTM4ekRxZHJGbU5xRnY4SGFRaHlJeXlyUElsMm1O?=
 =?utf-8?B?bFl5UXJDMTZ5RTRPcXEySnZFYmVCREZ5S2toVit2R2RqbTl1ViszTzdNR1Zk?=
 =?utf-8?B?MlJ6dmFDY2NOTDFLSWFKTVlhbVRBUVdNNWZGdmdZR3JQRGRGVmxTTG5QNG9C?=
 =?utf-8?B?UDk0VmV0SjZMaml6dTU2aEU3b1h0eW5mTGZBOHRxSzVkL1VyVittb1N1Y1NR?=
 =?utf-8?B?MVZVVVZyWDJ2VjF0N3ViVjVWUGlhdmVqT3VPTG4vcG1XaFUyNFJMOFNlaHVT?=
 =?utf-8?B?NmpmL3p1QzBOTk5JR0RWQ0UwTDVkK1Zkc3R6K3M0cnI3V3hrQ2JNcFBHWVZp?=
 =?utf-8?B?RjJSZVgxVFVMRlRodEEvc2g2dzRNL3l2ZGdSNTFtYVZQaWlPb1BlTVROV2Jo?=
 =?utf-8?B?K25GNVFjTWt2dURjL1JiSjJORk56ZHliN0x6RGJ1SWt0aC8yc0ZVVFVpY05C?=
 =?utf-8?B?V0s3UmlGTjZqREEzbUlBN0NUTUEzK3pDWVd2ZFVQb2QxU2dNWTJ4c1dDdnow?=
 =?utf-8?B?cVQwRkNmU2p1enZ5Wi9EZUJPUjlLSUtPM0N0aENwUVBYMFluU1g1NjZ4NzBD?=
 =?utf-8?B?dVdiMy9UYTJ2NEpNdlRmc2twZHc2dTBacURld1VLbytMN3lXQTBOWGhVaGMr?=
 =?utf-8?B?clROem4wd2tXcW1BMnhPMzdhR2piTkpzb3B3NjYxMGEzNEVJTWs4MHJ1ckNB?=
 =?utf-8?B?V2haU2N0c0huTUxibFhNTDJ4aTdMa1drc3pRdmUxZU9SOTVtUDIvM2JuUmJt?=
 =?utf-8?B?RWFBRDBTMHpEMXJ0Y0FnWkx0ZFFXZG41eDZSMWlEZjA1QVF1Q1BMSmM4dmlL?=
 =?utf-8?B?alRZdlBzcmdsbDZHMWVVekpWU2NvNFUrRW1zRUltcE9CSGxMMGo1bEI3aU9l?=
 =?utf-8?B?aVpaM281WXVkdlRiTHh4MlJxSXJFNFk0TE1CZEpaUzE0L0ZvYjlzbGZwL3Rw?=
 =?utf-8?B?K082MWlqdmlSY2xzeVRQYTBNOXdWeUhYbTNIY0JBTHo0OVhGYjBSenVJNElP?=
 =?utf-8?B?eXdnZGRGYUhGNy9NWEJxQzhTZ3MwVWk5ejd0dmdlRFZOQWpaVnk5U2sxMTBl?=
 =?utf-8?B?WFQ5RjNUc1Myc1N2MUdRRWpUYVZTUkd2aGcwbklxOStIcno3RkV2RXp4QnBq?=
 =?utf-8?B?Y1FRSE9oL0w1ZkJZRlo4T1JWaldCWndDTGdLcWRKODQvRmV6OExWZXhCNk1M?=
 =?utf-8?B?elZqSVc4K2xjSUg4NEFzS2RZNUk3QnlTSGpXY1lGNzlyeTlPSmZLZ0UzcWk1?=
 =?utf-8?B?eFRxbkNsbVdqN0I3akFWZVhITWo1ejhtVFR4SE5uZWptZ1JuMjkvWTJWeDZR?=
 =?utf-8?B?TFl1eWtQSkhmVXJmcVJrWTNiNnJGRmVCTTdJRVkrTE1rdVFrTkY0TUFuV1pv?=
 =?utf-8?B?VklJenZ5Mjh1RFdJcDIvU0lQa3p1U3VmNFRnWHdCVlhYOEpZNEJkR3p1R0hv?=
 =?utf-8?B?bndsYW9JRXA2dlpLNzladjFDdDhLbTh5Kzl3WGlVK29lSnhFdnp0QVozblFy?=
 =?utf-8?B?dWZaVUwxamlJU0dPeU9aOW55UVk3TUdQemZzNkhsdEpyTm01bjRET2ZMd0hh?=
 =?utf-8?B?ZW1TUE1vTmZhcHdGQTIyVzVkbDNNaXR4dTBNendFT2FMRDZiOWJ3b1pLV3NS?=
 =?utf-8?B?eVFCWitEMHpYTUJaRmxFb1BQMktacVdZQXVrVzNFaGJ4Y3o4eDAycmhBZng5?=
 =?utf-8?B?SHZjZWhLakhwY3Q2d0t6My9TbTZjQjhEck5IVjZtVzlpVlFmWDRpTlViRW1p?=
 =?utf-8?B?Wmdvd0JTeFFYL0xWeU1RNmJrNUpTZ3FuRDhrQzA0MWpvdkh5WGZobjdleTJt?=
 =?utf-8?B?TzIxaDUza3BHL0dYUWVMVnRDbGNSdHJsUVB6aHRyVjdlNkJ4U3JqcjJKRXkx?=
 =?utf-8?B?Z3B4U29KMmdWNTBja1djTE50UUZQcC8vTVFqcEsrSGlmRnJUTGpPMmhIQWFQ?=
 =?utf-8?B?dldDb0ljYWVSZjFiSm1iU1Vrd0hrdFdoZitTZG5sWWdBVHBQZUwrNndJb1po?=
 =?utf-8?B?SnpyOXcxQ3dzaml6ckttdEI2MzgzQWZYcVpmQ2NFWWYrMFlsV0d5aGJaMlN5?=
 =?utf-8?Q?K705CXBW2/kwdXlcFoMm0jgYL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ea67c3-c21f-4d70-95fa-08dda1c5865f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:06:29.3997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0kDqdvDZOImHEHcHlAjCZ98ekX9eNvEyYNHACfDiP4xdOr6bhYKdsQqbdKb/Bhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

On 5/30/25 09:55, Prike Liang wrote:
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 120 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  11 ++
>  2 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 32e88064bdea..3854b1696d4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -79,6 +79,122 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>  	return -EINVAL;
>  }
>  
> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	u64 user_addr;
> +	int r;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!mapping)
> +		goto out_err;
> +
> +	/*
> +	 * Need to unify the following userq va reference.
> +	 *  mqd  bo
> +	 *  rptr bo
> +	 *  wptr bo
> +	 *  eop  bo
> +	 *  doorbell bo
> +	 */
> +	//amdgpu_bo_ref(mapping->bo_va->base.bo);

Please don't use // in kernel code.

Regards,
Christian.

> +	mapping->bo_va->queue_refcount++;
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return 0;
> +
> +out_err:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return -EINVAL;
> +}
> +
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	u64 user_addr;
> +	bool r;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
> +
> +	if (amdgpu_bo_reserve(vm->root.bo, false))
> +		return false;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > 0)
> +		r = true;
> +	else
> +		r = false;
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	return r;
> +}
> +
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> +			struct amdgpu_usermode_queue *queue)
> +{
> +
> +	if (amdgpu_userq_buffer_va_mapped(vm, queue->doorbell_handle) ||
> +		amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
> +		amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
> +		amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va))
> +		return true;
> +	else
> +		return false;
> +}
> +
> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	u64 user_addr;
> +	int r;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!mapping)
> +		goto out_err;
> +	/*
> +	 * As the GEM userq bo will be unmapped by amdgpu_vm_bo_unmap() which is
> +	 * invoked before userq is destroyed. So if we want to reference/dereference
> +	 * the userq vm bo, then ensure the userq vm bo dereferenced  before
> +	 * amdgpu_vm_bo_unmap() or fallback to unmap the userq vm bo at amdgpu_userq_destroy().
> +	 */
> +	//amdgpu_bo_unref(&mapping->bo_va->base.bo);
> +
> +	mapping->bo_va->queue_refcount--;
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return 0;
> +
> +out_err:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return -EINVAL;
> +}
> +
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> +			struct amdgpu_usermode_queue *queue)
> +{
> +	amdgpu_userq_buffer_va_put(vm, queue->doorbell_handle);
> +	amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> +	amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> +	amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> +
> +	return 0;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -451,6 +567,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
>  	queue->priority = priority;
> +	queue->queue_va = args->in.queue_va;
> +	queue->rptr_va = args->in.rptr_va;
> +	queue->wptr_va = args->in.wptr_va;
>  
>  	db_info.queue_type = queue->queue_type;
>  	db_info.doorbell_handle = queue->doorbell_handle;
> @@ -481,7 +600,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> -
>  	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>  	if (qid < 0) {
>  		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 375fba639c94..65f9bd91ac73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -52,6 +52,10 @@ struct amdgpu_usermode_queue {
>  	enum amdgpu_userq_state state;
>  	uint64_t		doorbell_handle;
>  	uint64_t		doorbell_index;
> +	uint64_t		queue_va;
> +	uint64_t		rptr_va;
> +	uint64_t		wptr_va;
> +
>  	uint64_t		flags;
>  	struct amdgpu_mqd_prop	*userq_prop;
>  	struct amdgpu_userq_mgr *userq_mgr;
> @@ -134,4 +138,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  
>  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>  					u64 expected_size);
> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> +			struct amdgpu_usermode_queue *queue);
> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> +			struct amdgpu_usermode_queue *queue);
>  #endif

