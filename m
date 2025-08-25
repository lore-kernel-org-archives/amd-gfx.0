Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DEFCA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13A910E247;
	Mon, 25 Aug 2025 14:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dc7xkxhN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB2410E247
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rta0ggMfDgPBF6d23zO0n0ZcyWwCdvun37BUl2I/zX3n++rIZYl+NwgjIE1hsgIgb8Mko1e9AiHU0e/XIFRvZuzOqYszCyMc7Emyh9EuAVo88AK3ut4ejWYEqVeQNSkePUvQoGdBFSXyMOVuJs08yQWyDNn2+UJ5GeKJeh8M0FBink8ywCt+vDwQ1dvfv2Jzc2uxdFIGnrdpYV9KqDKERuI8C1xSmsa+7R0UOxuL5PKadrXhU20DAGcmlCjy15X94kWq4ilPD5dydyBM1J5GkG7CzDdt+/I1jEDqjcuucIZBhPiXW9H3VSb4GDIkmSP0mwBClaqEIKmelcKux9RuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcuuvNhkNpeiL9Ncj2/e8qy14jUOQDGH/6pbZcoDpYA=;
 b=URTnkekbZDrMorwpPujNb93NSiLRnbM54S4sfbWko2tkAMl5ZgAHHlKcy3gpbH6EAxYXgegLivsN2MJueXaAmnvuXyAudw55no9khx2CNa/1oiCM1zfH/98/B7MgwErE7SXrqV5C2WMeQX14/3OoNssG3UAArizRF0pY1p1L1zHJJH+s9x8BkWujlqVHXN63GS9fCDsXqXh5ibgvVu7bJpmzOt3fcznwAIbeyloeJmi9qDm/TFdLZqKK6itfiikblc3BlkOC9TJIz6i2GlyyROuCASW8aLW2ovjKP5O3tgrKnzipSDrp0Y7wK2QWcsxo8wonwl/Ia7vlPXxMDrsq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcuuvNhkNpeiL9Ncj2/e8qy14jUOQDGH/6pbZcoDpYA=;
 b=Dc7xkxhNv9DXo07m5CjtqFOBcgA07PCLskmAELYqTdrKF1wf2LqipallErUm4gqiHHFSPXjTy9Xiqfe8gefZDGlBLV04gCPg4jEZKE7r1T12pl8l97t0heZDxCKWhRGninqH+mZa88qvgwOBp+PHhbElGFnkjqo7ogUeXRrXJ7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 14:48:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:48:53 +0000
Message-ID: <d8a79250-9d8e-4afc-81eb-2b5ca3125bed@amd.com>
Date: Mon, 25 Aug 2025 16:48:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] drm/amdgpu: Create Singleton MMIO_REMAP BO and
 Initialize its pool
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-7-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820113254.3864753-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:208:32a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b360992-9cf5-4368-796e-08dde3e6829c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2Erc1hDYmlxTHJwL1F4Z0t0M2VhN3lPSlFoc1FPdFZUS1QwWm01aUYyd3o0?=
 =?utf-8?B?N1BjdnNzY2JqZWdmNy9QMWtvVGhDY1o0RjllREVJTDQ2QThzdjNXY09weHhD?=
 =?utf-8?B?Z01JWldUdDUvQVkrMEY2cFl1ZktFVWRYN0hwUjhTQmtlVmt6azR0SVd3NzY2?=
 =?utf-8?B?YmlOdlZlYTJoeG9yVG1lbFVBVndzd2RHZDdXd0t6RXdESjZhSVErZE9CT3lj?=
 =?utf-8?B?bkorN08wT3JETkNRSWNLdGRsbFhUbWwvN2xiR3kyMmNFZDMyQnlCRDNJdUY1?=
 =?utf-8?B?U0ozN25naEt6OFM4RGVzR1YzNVgwYm4rVHQ3RHI0RWt4MFFheDQxNEFuVHlR?=
 =?utf-8?B?L0Q5TTVoMTV1RUU0T2ZIeUZ6T3Erd0lES1FzNjlwa3MrV1pCVlNBbWRLT2FF?=
 =?utf-8?B?cU5yNGlMdWY1K1U1UWZXUUxqeWtGLytXOVJ5S2NRWXJGTXB4eWpZc2c0ZmZx?=
 =?utf-8?B?dENpeU5XNXJkN3BWNk5ZYjRPaEFKbnVYVFNGMFBTa3hnTG5UQ1ZzQVJoU01L?=
 =?utf-8?B?U2Qxb1RnRHN1WkNsc3ZZSDdGdTdUazBQcGduSys0L29YSGdWTzZYdWF0aHF6?=
 =?utf-8?B?R09xaytEb1Fucm1vR0ticnJhNS9hMGNvdFpVWFRPcjFHSEs3SitEMlg1OE82?=
 =?utf-8?B?ekV1Y1NVeUdaQ29uck1JTkRaM0x0QzhkQkUwS3Jjb3FlMlNkTnp4REoxNEUr?=
 =?utf-8?B?MFlnemdaSWVieTdCTDRUd1lkWGFkOUFKOENjR05KcCtHRlJrejdDdlc5c3Ar?=
 =?utf-8?B?YzZVcEhJeEs1bmVvTG15MVpwa2cyb25KcDluQjJ1a2Rkb1IrMzlmSkhXZVdv?=
 =?utf-8?B?WWtyenVqZXJKMVZoU1gyWUppS1BvN2RpZ0ozYjcvb3hnL1A4Z1lERVJSYlR5?=
 =?utf-8?B?dlVkMUVENm1Hd1pZdk02aEllUmtNOGtEcXJybTRFQSsrL0p1bHh3Mjk4YU1z?=
 =?utf-8?B?ajJKVmFjS09id2ZzcS9WUFV4Q21ZV0hOUUxlUkwxOVpiUWRpTE1uUk8yWlpj?=
 =?utf-8?B?ckdTc1pYWDhhRjdzRFFmK3ZKd2pWdEhub1drdVZlTUFrKzQvR3kybXc5MVlR?=
 =?utf-8?B?bFY0UmJ1QngreGhlamdHWlRIMWw1anBJT0tqeUtKYWpGb3NCK1RXdXdURGRJ?=
 =?utf-8?B?MGlTMzR2S0xxdHVJQ0ZBaUZVdU9sU01aY2s2YlB6bUlqOEV2NFFaVDlrZlVa?=
 =?utf-8?B?NW1VMiswQndXS0VqTlQwUktLMEp4TjN2K05CeVh5RGt1ZzJsQWU0UllyMlpa?=
 =?utf-8?B?YnFkbWdQalh1bkFxYzlYZUZiSG5IQWhQdWozcVZFWDUvdUF0a01YWVlrRmRP?=
 =?utf-8?B?SmQrTUQ0blRJMUxnVEZDdnpiRHRqTDliaTY5Z1d3ZEpTU1JERW9qNm5oTnJB?=
 =?utf-8?B?QlNjcitzNi9xQ1NqeGp4cTBWcXN3K3hPaVlWaXpBbjg0c0dFZUJOem9KTW03?=
 =?utf-8?B?MW84K2lWQnNYY0lTMHN4dE5mdWs4WUF1UTZ3YThMSVdqWHU5VjJnQ1hiRG1C?=
 =?utf-8?B?Qnd4cGJyWVhrTVVMaXd3aTB5bTB6Vm9COW1mK0ZaWk1uejBHUjBtak5Uc3Nt?=
 =?utf-8?B?KysyZXNYRmNSVWQwS1V0SUpFT3dDRkk0OVFFVlZnb295TWNKRG54eHNoSk1I?=
 =?utf-8?B?NlBCclVNWjNDbEtTMVN1UXczaWtqZGwwTDlBL3lHRHQ4cHVaT2Q0RjV2SzFv?=
 =?utf-8?B?RVBJN09UMVZBMzVURnE5aklYMWNIWEFMOHUzcHBNeXAvMVM2aDZ2cnJoL3lL?=
 =?utf-8?B?SHdzbWJmVmtRMWZUbVBUQ1czN1lrd1M4TEZ2OGVsS2R1OEVDOWNwMjc4ckNx?=
 =?utf-8?B?TzE3STJQSUMycnVRWlJxb2lyV0IrbExwYkNLU2l4bTVJT1paZmVScXU4MVUv?=
 =?utf-8?B?b1l0SWpqYTFzdGNPUVZzS28zcldaUHZhMERJQVhxVXo1TW5qN2UyRnFPSEVr?=
 =?utf-8?Q?nsIat9wZG40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDkxR21aUXZXNUZQaTM2ODA0N1NkMWVSUnhRdEk5VTlZRDJoTjZBTE8xWWpT?=
 =?utf-8?B?ZEl0akZ5TTVFZXdFSXlhTU16cHdQWlBtK3lBdTVEbkhYWWNlR3h5WG9janZ3?=
 =?utf-8?B?U1R3QTc3SE0xZkpTdUxoMURBVWRsZ25PQU1BbDZ6ajBqY3NrK1VUeUhsMWFX?=
 =?utf-8?B?TFZkYTcxS0ZWeWdjL0ozdlFId0REQ1NxZVQ4NFNjdjJXWHZxSDQzblNDRTYz?=
 =?utf-8?B?akpuTTd2M1k4ZkxXb3FMRkd2M2RsMVNzNEdBbGpiV01Ic00vQnBmV3VoT0FY?=
 =?utf-8?B?dkdaRkVDOXE3ZURCaDl0TWtjN3NzM29CSEUyeENieWpWbm16alB2S1NqSmRp?=
 =?utf-8?B?bzFKUTdydWJ5VUZOZVJtNUhNT241RjUwTStCbVQ2TmI2emdmRzhXbmo2eita?=
 =?utf-8?B?aWZRb3pTZWM2cWIxblBiWUxYSFZ1RlF6Q3RJRFlteXFVeDRzc09INWQ2RFdx?=
 =?utf-8?B?WWNsbFhwSHo0STVGV2gzcm9ZUTcyeDdxZzlBUUVDUStWa3JhNEtpQW44ZWpC?=
 =?utf-8?B?N21OUnhvSm8ycUFUUjVOWG9saDJJODZxOER3cjhuSlRMMVNHQjNYOG5sdWsz?=
 =?utf-8?B?V3RVUVJrbmV4bFZYR3V2aXFiWWlicE1IREg3T2dVZW5qSzlXcDR1RXRlWHhI?=
 =?utf-8?B?RndzT1JhOHg2TG83NUY0MCs2SDJyWjB4L1lSdXJQTEtienJYZUFxdTFjMkZW?=
 =?utf-8?B?WTlWeHlLSnVPQldsd3gyTkNpYjJlb0ZlV2VlTTBBcUZZS1NFc3ZoVGgvdzBR?=
 =?utf-8?B?ZW1OR3RadUswRzQwenN3NVV4NTkzWGhweHdwdTFBWG1MMEhwL01pSGNycHdE?=
 =?utf-8?B?T2RKNkFVWTRtN0xCY3FCZVdJYWllVmREdDI0NTNOdWp6MDdYc0l5eGJuck5l?=
 =?utf-8?B?KzlCb3Fwam5RbE52OFFqOHJ5aTJSc21zKzYwajFMbnNob3ljMm9Gb2dPT1Yx?=
 =?utf-8?B?REgvMWNzY1hkSVJFZ0p5YjZqamUxeHN1MVByYkhVRnBVc2xhTzdPbWFvb3g0?=
 =?utf-8?B?dGlWNnhFWSt1R0psTXlpanZ1VTZhNlFMcVFlWndHTm5xWUNyVTBkQktlT0FC?=
 =?utf-8?B?VGxCQXBnLzFDZkpRVDhramVXRUsybmgyUWNkR3hwY3BZV1pSSFlZRWczSnl3?=
 =?utf-8?B?OWR6ZXZtbHNxYVNucWloaHQybzNBSFRPQXBaRGdWMnF4b2k5NVhLd1RSeEVE?=
 =?utf-8?B?UlVQaDJGMk12eGZJcFJaTUpCa1RodmxuT2tIMGkzL0dTV0NNVXVDM3luL2ZC?=
 =?utf-8?B?blk1Ykc5d2NPbXRwQ1RXaEgvSjZGc0o3c2FHTmxSZWYwemJCbXRaS21GVGYy?=
 =?utf-8?B?WnRpZ0xpYmJZQk5RbDFVZ0g4YVNZK2sva3NRK0J1ZDk2Ump3dGE5MjJsR0tT?=
 =?utf-8?B?Sm1iRFFGTTJJQ1NyV1h4VDZGbkNVd211eXk5Y3pGeEJTY1RVMW5XdEF1ZzBs?=
 =?utf-8?B?UnMzTTVwZnBzMnJGdmEwNyt5d2NoT1RscjlzS0VZZHdpSVZjY1UycXJQTXYv?=
 =?utf-8?B?elNmVDZZczBFdEtyb3ZHZVZTNnJtQ1I3MHE3dzZLMlF2cVpQSjlsd1VxNjMw?=
 =?utf-8?B?aVBnVHBEZmx1UXRFQ3hJRHZDcmpNVGlRaDZVZzhNMTVqN3pLZ3lzcFN1N2xU?=
 =?utf-8?B?Ukh3eGdpaFJoeWNxRE1uNUpMNTZBQzA1QmZxZ25abGs0dlB3VTRMcmJUMGlj?=
 =?utf-8?B?L1laMjJGQitGS3c1SFFqcU90aDlvUENySEhOMHQvSUNKK0NGckdMcG5YVHRY?=
 =?utf-8?B?L0ZxRTVxdnVUcktpYnhTdnRIdjF5U25qaXdYbjdaZ2NjUW8wR1p1ekFQVVl0?=
 =?utf-8?B?c0FwYk5OanpLSkVBR3FNcVdmbWRZSXNEdjh2MHg3TFVYdytZWW8yTGxYM0lP?=
 =?utf-8?B?bXBDbWJUKzF0VStLSEhNMUxqVE5iblBRUzkyQUVZZUwvUWF4UmpWdkJxZERY?=
 =?utf-8?B?aWNKVHZzYTllZ2RLYkFGdUZTa2ozUzVEbVhCK3dHZHJkek1RMVIxTk1DSU5G?=
 =?utf-8?B?VUJnR0k4L0hQSmxRS2hueGxmakVQMnJLNnJjdGhLeUtlU1JFci9mZFFCNlgv?=
 =?utf-8?B?eTE3WlZIdnBwUkxoNHBoci84WTJzR0pjbEpVSWs5bGxvdUFkZkd5ajFydXI5?=
 =?utf-8?Q?fWaTaZ8bG0Mea7XLq+ZKFjaLL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b360992-9cf5-4368-796e-08dde3e6829c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:48:53.3298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXRA67en8r/lcCRec/nCs5Kt/+qJZrrEFC+U0dZ12JNXMktDNF/p1dFt1rTtgHrT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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



On 20.08.25 13:32, Srinivasan Shanmugam wrote:
> Create the single-page MMIO_REMAP BO and initialize a tiny on-chip
> range manager for the new placement:
> 
> * add amdgpu_mmio_remap_bo_init()/fini()
> * in amdgpu_ttm_init(): initialize AMDGPU_PL_MMIO_REMAP heap and create
>   the PAGE_SIZE BO
> * in amdgpu_ttm_fini(): drop BO and tear down the range manager
> 
> This isolates lifetime management and error paths for the remap BO and
> ties them into the TTM bring-up/teardown flow.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 86 +++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 157a5416a826..ab93fbec2a34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1859,6 +1859,73 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>  	adev->mman.ttm_pools = NULL;
>  }
>  
> +/* ================= MMIO remap (HDP flush) singleton BO ================= */

Please drop those =, either use kerneldoc a just a comment.

> +static int amdgpu_mmio_remap_bo_init(struct amdgpu_device *adev)
> +{
> +	resource_size_t bar_base, bar_len, bus, off;
> +	int r;
> +
> +	/* The ASIC code should have set this to the absolute bus address
> +	 * of the remap page (inside the register BAR).
> +	 */
> +	bus = adev->rmmio_remap.bus_addr;
> +	if (!bus) {
> +		dev_dbg(adev->dev, "MMIO_REMAP: no remap bus addr; skipping BO\n");
> +		return -ENODEV;
> +	}
> +
> +	/* The register BAR base/size were established in amdgpu_device_init() */
> +	bar_base = adev->rmmio_base;
> +	bar_len  = adev->rmmio_size;
> +
> +	/* Sanity: page must lie wholly inside the register BAR */
> +	if (bus < bar_base || (bus + PAGE_SIZE) > (bar_base + bar_len)) {
> +		dev_err(adev->dev,
> +			"MMIO_REMAP: bus 0x%llx not in REG BAR [0x%llx..0x%llx)\n",
> +			(unsigned long long)bus,
> +			(unsigned long long)bar_base,
> +			(unsigned long long)(bar_base + bar_len));
> +		return -ERANGE;
> +	}
> +
> +	off = bus - bar_base;
> +	if (!IS_ALIGNED(off, PAGE_SIZE)) {
> +		dev_err(adev->dev, "MMIO_REMAP: offset 0x%llx not page-aligned\n",
> +			(unsigned long long)off);
> +		return -EINVAL;
> +	}
> +

Please drop all that. The code here should not check anything but just creates the BO at the specific location.

> +	/* Create exactly ONE kernel-owned BO in the MMIO_REMAP domain */
> +	r = amdgpu_bo_create_kernel(adev,
> +				    PAGE_SIZE,                 /* bo_size  */
> +				    PAGE_SIZE,                 /* alignment*/
> +				    AMDGPU_GEM_DOMAIN_MMIO_REMAP,
> +				    &adev->mmio_remap_bo,
> +				    NULL, NULL);

That won't work like this. The difference between a kernel and an userspace BO is that kernel BOs can't be mapped into userspace.

You need to use amdgpu_bo_create() here, lock it and kmap it manually.

> +	if (r) {
> +		dev_err(adev->dev, "MMIO_REMAP: BO create failed (%d)\n", r);
> +		return r;
> +	}
> +
> +	dev_dbg(adev->dev,
> +		"MMIO_REMAP: base=0x%llx off=0x%llx size=0x%lx (BO created)\n",
> +		(unsigned long long)adev->mmio_remap_base,
> +		(unsigned long long)adev->mmio_remap_offset,
> +		(unsigned long)adev->mmio_remap_size);
> +
> +	return 0;
> +}
> +
> +static void amdgpu_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +
> +	if (adev->mmio_remap_bo)

Drop that check.

Regards,
Christian.

> +		amdgpu_bo_free_kernel(&adev->mmio_remap_bo, NULL, NULL);
> +	adev->mmio_remap_bo = NULL;
> +
> +	return;
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2026,6 +2093,20 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	/* Initialize MMIO-remap pool (single page) */
> +	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
> +	if (r) {
> +		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
> +		return r;
> +	}
> +
> +	/* Create the singleton MMIO-remap BO (one page) */
> +	r = amdgpu_mmio_remap_bo_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "Failed to create MMIO-remap singleton BO.\n");
> +		return r;
> +	}
> +
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
>  	if (r) {
> @@ -2088,6 +2169,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	}
>  	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>  					&adev->mman.sdma_access_ptr);
> +
> +	/* === Drop the singleton MMIO-remap BO === */
> +	amdgpu_mmio_remap_bo_fini(adev);
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>  	amdgpu_ttm_drv_reserve_vram_fini(adev);
>  
> @@ -2109,6 +2193,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
> +	/* Tear down the tiny range manager for MMIO-remap */
> +	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
>  	ttm_device_fini(&adev->mman.bdev);
>  	adev->mman.initialized = false;
>  	dev_info(adev->dev, "amdgpu: ttm finalized\n");

