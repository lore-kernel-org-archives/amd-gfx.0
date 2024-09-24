Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF48CF9C69
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 17:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E98310E8DD;
	Tue, 24 Sep 2024 17:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVvyVZ3/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B9910E8DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 17:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDCEKVMML4/NXQcnHmfc7EWl3j4m6UtHwCMJI8yS2rTkdWcfj1KO0VaQYEsQ+GBetPue05OLWtlgr+mi1pYcFYtghS3Dhw0ZFmc2w5YJlye5i+LIi7PFt0G+lBnxhDDYEA5KZuX8cQiC2hWRaE2z0jJGQBS8s2Yn22GgmEDlgmytJXuWICnabpFT7mdOPRJa77Eb0xCepKWWTstKXj8eKZ3qpyJE0idAZD0LVQ0p+6zEyNEDm0CfQsnMFxkQ7VrAykdHnssjx/AMLHqwGAy1ysj9NcNuiD4VhDZsrdrnJyzZf6Ln+E+AeUIS817miwsdrfFXKMp5Jcc90IjdDApD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpILNFrMaYUuswOma9hBNYh25BpGijNV0DvzaUTg5cA=;
 b=XoxTiq3KAG57EMS4yrb4Q7jwXmUParMNaLDN+vR2aMBEJCbRi7xieHq90lT3Q0NJxBH1G+sUeq4CGdaJ1ROc7LPPs/rk4aw6qoJ96u6+m94CwawSqgtlT135cRowWDE6G8xwYn9GDons/4DGO182IjXrVXY7friz6PonZ/eLfx2d4+hRboNIh1dh0T8YmNlSYKMR2pZHwbOwVSwyNvqIILZO6lxWHtWiu5FczpxbTWe+3TLPIrwc5Ov2H7631qC0llObsPTr8ryPOhbkrki93sF4mIaluvZh/OLZeXvt6PZVeucNT9alP4vDHk3/R2dD5DAkCD74fDc8XFH0U4m87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpILNFrMaYUuswOma9hBNYh25BpGijNV0DvzaUTg5cA=;
 b=IVvyVZ3/MhtjOhT7AVpCN7izy5xyBaVmA0TLSQ+flIXXbG43yfCwImBLHW4zh05W3A66NoZZoLyRjKbaJbXQDXBuES4RMwsqgpSS2bKmB1LP7t3aIvc9rHcl+fP8hisPjJ/ofxHNiXhTbbczBn3gV7QA4sYpjhwAObeKGXVO3Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Tue, 24 Sep 2024 17:48:52 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 17:48:52 +0000
Message-ID: <4ebb954b-8c6d-4118-ac27-ec28f67db186@amd.com>
Date: Tue, 24 Sep 2024 13:48:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Ramesh.Errabolu@amd.com
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-7-lijo.lazar@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20240924055652.2678433-7-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: b81f7cc3-1114-4c88-07a9-08dcdcc126dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVFwc1RQRGNuZExocVNNL0c3c3luZURYZndtcjJ3anF3Q2JUdkZ6R0VqWW1z?=
 =?utf-8?B?bTk3V0Qya2lBSUJsa3Jka1BlUkZLQU9nS1hJbS8xUEN3QzE2Ym53elZ5V2pM?=
 =?utf-8?B?Ui83ZFBJYjU3V1lzcmRnNTRDNExseHU3cXZ1djk2Z2xQVEEvcHZKK1VtdWpM?=
 =?utf-8?B?NFBOMFc5aVB3UUJnd1l2OGJoN0V1MGs1SmRCcmJkRmZCcWxXYUpGNnU3b3FF?=
 =?utf-8?B?RjVTWmFuYUZpRlhPaVJVR0t4TnU3TUpuVjRGUDNqZ0N6azVZYWpSc3h1b2cv?=
 =?utf-8?B?UzFScFhJNmYzcE9WeU5TUXZONXZBbnorb2Z6MEJHWGhnYitrSE9ORmNSa1Ns?=
 =?utf-8?B?Um03VEpTdWZ3QkR1S3lWdFVKc0F4OEFsU1JmSlBwWUQ3ZGc4cXB5MUdkcHk3?=
 =?utf-8?B?eEJIZVg2U2tBVXE0VWUxME44ZFp3ZEFkT09xOHdaakZYRHpGOUxieUNDRUNC?=
 =?utf-8?B?V2pLT21tdEVvNGVndEllakFmNTE3SGlCYm9oNXBZK0pjWmx2V3RjY29rdEtO?=
 =?utf-8?B?VkJwSS8rUXlXWms3WW9Ea3U3azhWKzFvaDVKUG9uZEEzUXovdDM1V2JwdTlX?=
 =?utf-8?B?cnJ2b3BWbG9JanljY01vNENkS2pnR1hLWjBxZ2lzMHFmSG9WMG1YOVhIS05L?=
 =?utf-8?B?SmttbG5oS1crU3liTTJ2WSt5ZU1vOC9kUVdtNXBianBRamNEdFJZZ3REOEZn?=
 =?utf-8?B?RmlUWlJRQjVPUTdLZWN4THk2ZGJrNm1QZlYrb2JPZitXUHY1N1JTVEREQTJF?=
 =?utf-8?B?dzVRTGpRcWNRemRSbnd3dmpPWVMxaitYVmFER2txUEVIQ2JSUW5VYmkzS0tR?=
 =?utf-8?B?eXBUYnVnRU9VNThMU25xUWZaSUU3enFSWjY1VFdpYlEvVTJyNkxwUlgvd1py?=
 =?utf-8?B?NFFSQ3BDRjcyeklIWWkraW5CQWpaQjQ1MjNTWU1uaWJuZDdjNVQvampCTWhQ?=
 =?utf-8?B?YWNJUFgzMlRPc3dsdGdOTUxWRFJBU1VOQVJJWWlzRHllQ0JUOWFsQ2ZldGdT?=
 =?utf-8?B?OG9qRFdwNk9EWkJpM2RIZWxVTjVEWUVHeHRLMHNHd2pjTk5NcHlmcWxLQlU4?=
 =?utf-8?B?NUlXcU5wMGxyMjZFNFJaem02RGlBR28wODlFc3kxdzFOK0EzN2d4WVJab09R?=
 =?utf-8?B?RTRkZUppS3lqVi9WV3BBZHJQY29tRWRtMlo1NFhxWEZSL3NucTRvT2ZNdnJY?=
 =?utf-8?B?N0RRcjY2SFF1cHVhQ1V1UWdRNGpVRjJLOGlXNEVOa3V3d1dpK1NNQkhWQkV2?=
 =?utf-8?B?RHpMUG1MMlRnclJGUUJpOEcxc0FpdDdMM3p2TUZydnJ6Vkp4WndHRHNWKy82?=
 =?utf-8?B?N2hTQXUvU2tTMFFsOCtqVVAwd0ZEaGdFZlczbGF4cXhCQzQ3L2dlemVIVi9u?=
 =?utf-8?B?TkRFQWVCWHF6Q014dWo0cUYzYjZlOVdiY285UnVyaVZTNEtJV3I5RzJkdUpL?=
 =?utf-8?B?NHNOUll6NTZHUTV0LzMrZ2ZJUUZLejg0ZllVVW8wamt4blFMeFdSWC9GQkpl?=
 =?utf-8?B?ZFplSlhGdnZHMTdXQVVOaW5Fc1BRZjlyckduNStTM3hiUDBsTHQyRlU2OU5o?=
 =?utf-8?B?U0p1N3p1QUtxZ3cvTkhCaHR4SkJNVHNtUnZrZ2I2ZHhCYU1keGp5anpGYWQv?=
 =?utf-8?B?RkZjYmFmQmFvYm1FRmlIOE1GSStjTk1OZ25EWVFZOGdVREVnWnJPZFU4b3dl?=
 =?utf-8?B?V3FaRXdsWlREbnlyMXdZcW8yY2dCeFdLMkNRVThSVlFxTXplcVpNc2E1Y00z?=
 =?utf-8?B?ZFN6TGp1d3dYSkd0bFk3N2tJVVcyOTBUU25yTGxRcnZTbVM1ZjJSYWYyWGR1?=
 =?utf-8?B?YnVYYXhLeFNKZ1pBajd1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZPQ3RvMGR5bXlQQUFhWldBc0thREtvQS9UWFMzWlp1cHdvcVVMelBLQWFw?=
 =?utf-8?B?cEdzdkxNdjdtaTBDeTFpMjVQbmFXbElSV0Joa24yaklQYUJtTnV6T0NsM1BF?=
 =?utf-8?B?aFh4SFRLRXlSWUJzc1B3RE1ad0M3TEp3a1kzcmhyaFg0TWNZR3RIVWdqM05L?=
 =?utf-8?B?QjU2U1B5QjlkS2cvUDdnNzUzMWh4N0dTK1RTQ2d6cnA5NXFKalE2aElsbjVP?=
 =?utf-8?B?dG9XdHU3aksvUDhXSTBZcmw4RTFrTzQybkhpY1MzcDhtY0FITUppT04wV0h0?=
 =?utf-8?B?REFDcGpaVEJIUkxWRHdhaVhRYUZWNFdkUVdVMGZabzRqcEd0czdmWHlXY1F3?=
 =?utf-8?B?cGFpdDg3SXNrQnBxa2JxWlNmQXZGRWpxaGZTdjA3c0U5NXhYRnhFc0s4b2tR?=
 =?utf-8?B?cUZVS1YwTUVJUWgyNW1xYXZxZzVkejMvTkdIZmJXWGZQdmgxR2x6UlNWY2lX?=
 =?utf-8?B?MWdKNldDVUhnNGZRVFQwZ29yKzhsNEFPU1pvbUpncEoyVy93YVhML1FMUE5s?=
 =?utf-8?B?T21qdXpYTUtpajNkRnk3Q0xtM3VXd1ZFZDJIS1dDU2orQ0NKQWV0NVRvOU5O?=
 =?utf-8?B?MjNLenU4U1JGL0ZIcVc1YUtGK0ZMcm5rSStXeHNnN056VzFYTzJrUml0b3JL?=
 =?utf-8?B?VUttWmV5YStZRjM1QnJ5Rks2cHRyVFZzaGR0SElUNlR4QThrOU52bC9CYU96?=
 =?utf-8?B?a3hiR25tQ3FadU11V3EzbVhNQW9rbVBKR0pFenRZVUxIRG5aNkR6YlJDZGk5?=
 =?utf-8?B?bDJUYnFHRVVMQU5iQTVtUWFnOXRBVmFhSTVpNG80VXg1T1psd0Zkc0JrM1lU?=
 =?utf-8?B?Q1dob3VuQkJwa2N1MWlMZzVOa1RROFJXTXBwVDF6NS9DaEcyOWlVT3NoN0tH?=
 =?utf-8?B?Wklra1B4T21BSXU3UXlhL2p6bzdTblI3ZjRYdkw3VW11bGlJUUtuKzdVTlNV?=
 =?utf-8?B?Z0Z6Y1BGUTI5bWpINTZ0U1lEQy8vNEg0OFhUSGtGQk5MWHRXUFRITjB2N3h2?=
 =?utf-8?B?ck1NMnY0bE1FTlFUNHdlY21XN1FnYjVra1VBeUszL25hUEg2SkhKZE03Ymps?=
 =?utf-8?B?eU56bjMzUzE3dW5LRlhtZ29xRFdaSU9lY0hobWlJdHRxY0VSMGVja2NPK3hM?=
 =?utf-8?B?ZXpHamxHV25FTW43L0x5UTlxdXk1ZTVrRUZRb2U0enlMOXVJdkd6K3pnNzVS?=
 =?utf-8?B?WUtYK1lZc3NSM0hOZ29Cdm45bWtRUkRiQXErWkYxRHYvekdPRnNkMllkWTU1?=
 =?utf-8?B?YzZZSXVUemgydGIwS0hkYWY1R0NsNjNBcCtCRjdBUTZwRWYxOUtCYmJLUUxO?=
 =?utf-8?B?NkFHSTFRY1BIN3o5ZXNtN3JWdWxFQmVQSUsxaXg0eDAreDVYekxYUUhMTnJw?=
 =?utf-8?B?NVhSelQyU1FpU1czdXp6TzZrampsQUlScXV3a0wvK05nT1VsMzJIdlIvK3Ji?=
 =?utf-8?B?ZTZEVkVQbmhySFROWXYvNG10UndUeTlUc095Vzk1QndZdGJvd1Z5YUszQU1z?=
 =?utf-8?B?dlVTWExMM0JMa2MzQ1lzWmltdjVRRDV5T1FkL3loWmNLSFZ2STE3bnd4clVr?=
 =?utf-8?B?SWVCSEZYQWdjZytpQXlNS042Uk1ySmJBS1c4NXM0dTd0eEVuajlyQS9PUFov?=
 =?utf-8?B?bUJYN0NLT3FiQ2k3bE5XY3lSTzFtSVlWWkZlZ3I5dnBVMzZONFlkSE52eUxF?=
 =?utf-8?B?OW9vWjh1Z2h2UTNMVVhsSjFDVE5wRSs5NFZ5YU11NTBtYjRqZkVuanpQbnRT?=
 =?utf-8?B?bUhJTXV3elErUjNjZnh6a1pFeDV4RnFoMEhObE9vUmlWY3dGMGtZZWhMVEtt?=
 =?utf-8?B?M0FGOEx0RzdzM01sdVd5RDMyN2lVZnRoYXJQS0tBU25JZkVPdEgzdHdydE1z?=
 =?utf-8?B?YzR6Z04vSjEza0xSaDFuVTBEaVRiZ0ZIOWdCTkh0RmE2eDRxbVJ2bmtEckVk?=
 =?utf-8?B?NkNscU5MWVdHYlFETmw0Y3hBSHBXMG43NEl5MzZqSXE1ZEdVNjhBZm5HTElJ?=
 =?utf-8?B?SkdVU1RnQ0VtN2d5ZXU2WnZ1VGwxeE50U2w3RTViejhGTGxLbU1adjdya2lz?=
 =?utf-8?B?QlhlVUQ1T20rN1o3aW8ra1JCWXp3M2lTbThmSGtzN2RxbWdMd1lhYTI1Y3pl?=
 =?utf-8?Q?+sVE46+VbqbRP4A+FtCn1kwVt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f7cc3-1114-4c88-07a9-08dcdcc126dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:48:51.9974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF7CTjeePieBj+LyJNzHYQA9M3IWNNkP8N9N0cgdP4mCy5U/J8mf9E3HLpv1NWqzEFT74/ajIFiXIyOdGE0ZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 9/24/2024 1:56 AM, Lijo Lazar wrote:
> Add a callback to check if there is any condition detected by GMC block
> for reset on init. One case is if a pending NPS change request is
> detected. If reset is done because of NPS switch, refresh NPS info from
> discovery table.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
>   3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 21f1e65c9dc9..011fe3a847d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>   	struct amdgpu_gmc_memrange *ranges;
>   	int range_cnt, ret, i, j;
>   	uint32_t nps_type;
> +	bool refresh;
>   
>   	if (!mem_ranges)
>   		return -EINVAL;
>   
> +	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> +		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>   	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
> -					    &range_cnt, false);
> +					    &range_cnt, refresh);
>   
>   	if (ret)
>   		return ret;
> @@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
>   			adev->dev,
>   			"NPS mode change request done, reload driver to complete the change\n");
>   }
> +
> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev)
> +{
> +	if (adev->gmc.gmc_funcs->need_reset_on_init)
> +		return adev->gmc.gmc_funcs->need_reset_on_init(adev);
> +
> +	return false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index b13d6adb5efd..d4cd247fe574 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
>   	 BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
>   	 BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
>   
> +#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
> +
>   /*
>    * GMC page fault information
>    */
> @@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
>   	/* Request NPS mode */
>   	int (*request_mem_partition_mode)(struct amdgpu_device *adev,
>   					  int nps_mode);
> +	bool (*need_reset_on_init)(struct amdgpu_device *adev);
>   };
>   
>   struct amdgpu_xgmi_ras {
> @@ -314,6 +317,7 @@ struct amdgpu_gmc {
>   	const struct amdgpu_gmc_funcs	*gmc_funcs;
>   	enum amdgpu_memory_partition	requested_nps_mode;
>   	uint32_t supported_nps_modes;
> +	uint32_t reset_flags;
>   
>   	struct amdgpu_xgmi xgmi;
>   	struct amdgpu_irq_src	ecc_irq;
> @@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>   int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
>   					int nps_mode);
>   void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 619933f252aa..97ca4931a7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>   
>   	if (amdgpu_psp_tos_reload_needed(adev))
>   		return true;
> +	if (amdgpu_gmc_need_reset_on_init(adev))
> +		return true;
>   	/* Just return false for soc15 GPUs.  Reset does not seem to
>   	 * be necessary.
>   	 */
