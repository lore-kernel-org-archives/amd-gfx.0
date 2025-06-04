Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E844DC5B552
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 09:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4CC10E7D2;
	Wed,  4 Jun 2025 09:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dvL2Maio";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C22110E7D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 09:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDuUl4xUhkmHN+xDoH+VUUVtc3vTht6ehwW91vEyJGSfak+jNqLYt+jBSreHYElaHf2m0Ikw1lzrOMrxq50UgRdE3yL5DLSqtCc0k8C2B1zAeqYke9IntZVSTZV6AVdy54IKUX+jNWi8znjBEJ4ZnmULsp3d/xqoDgfHYts1MWtNos/uAu6K5YkhANWy6esejEk+3DcYbxAL05WKMRH/ojDWxUKo69H4IBMBITnBKO/H48WrYMDdUWWMBZprLtKDQrkmX7JBCFFXMGAzRSkj0BcIvjuPHsuhsxOxy1B4eEYr3QYgsbFabV12YOw3i5iPBRRPGYc24hSJakNQd1dYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TRH+eP6qiPWVUpMbEjOrkPmxWiIqSl7/PuVqcChW28=;
 b=kipQf+fGvuiXMTb7+NM7Fu76rL1A/oIv2Ph4nbsPtOW0oA8M6PCgOEJbO7Gmbv49gYmS6/YsUvmMZFpI8LDsePotSASFVw/fVNhC6xttUiEIvBfTt7g5/3uQyGQOIyQyWKpHk2tA1S1vFioRqY/By0A7dtmoXHvfk6d0IaUjOO3xCBppL9ZN2Sej7MmxpcTeT8sWC5TNONU1aMRWTVJ2j1x0FseDZOAl4pAlnleInjPcIlvo3kK8ujJQYbmH4K3FUdCTv1DguA0tmgildyJmqp+JG6FlfTXms0qrDyzHM2E4AqFNLyV9wpO9GC/aIVD2BMw3BYvrH1+L17DEBFkKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TRH+eP6qiPWVUpMbEjOrkPmxWiIqSl7/PuVqcChW28=;
 b=dvL2MaioFI2br1YKModZHF+oEMIG9ZIY7i20zPXG7I8NnEAoXYwiTVFyHBEyFATrhMcIDJ+gE3jL3LfqSuit84zXZX2XSPS7/DfZTZSqK957ZA47D5aT6sw4/CjrMbiLD/HEY5Sd6OS097zkMsKzDLafE3LztS0fj0jwrBil3xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Wed, 4 Jun
 2025 09:00:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 4 Jun 2025
 09:00:34 +0000
Message-ID: <becc0fd4-cb6f-49b5-8197-a755d3c5a359@amd.com>
Date: Wed, 4 Jun 2025 11:00:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/ttm: Should to return the evict error
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250603091154.3472646-1-Emily.Deng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250603091154.3472646-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: df5b8fc1-5005-4a78-e472-08dda3464445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFVSZ3kvTkJGcW03ejVPdTgvWE5ZOFJiajdJVmpmbEZVSDk4NVUvMzFza2hY?=
 =?utf-8?B?YjNMcnhXaXdHeFptRkE5VnJIdUNjckhWNDhTR3JVU1FTSjZXTnpoUVRPQzc0?=
 =?utf-8?B?Q1N4YmlGa3hoZE9Hb2JDOVduZlBSOC80QnZKZ0I0K0Nxem9BdDAxSnR2V2pa?=
 =?utf-8?B?ZEU1NVZWd3o2c290L3ExeGJDL1ZQVjhmRWdNRW1BR2pUdW1ENnN2UzUvMGwr?=
 =?utf-8?B?b01HdHhGU2VqWFUzUjNPd0hBc21iQVpxSTlOODV3cjlIdDZFQlNKRU9ZUS9v?=
 =?utf-8?B?aXpUSUY0NFRGM25ZVVhwRlRtYm0rNHhyMkxqa3FMenZRTzdOWFRCOG1aSGY1?=
 =?utf-8?B?bnd5ZXYzdmU2R3BZWG9NSm9ORkEzS0xTbEJPUWFETEpjNHY3cWZwK3FOYk1a?=
 =?utf-8?B?ZFlUTUxkN1VhS3hVVmpoS2x3NTdUblZ2ZUJSd1NLMU1lWE1yYittSDFLc0Jl?=
 =?utf-8?B?cjB4MWVLemJLQTNLZ2tTZ2U3Y3dhaTVTUHpabzZkKy9Ec1RLNHFITGZDVXJZ?=
 =?utf-8?B?aXRQNSs4YktTZEZwUEJjMmZQajI4ZUp4UVc2dFJyeFM1cHkyVGpQeStnZnFF?=
 =?utf-8?B?UGYwcWF1OUZYbHB2ZmxZdi82KzdGeGc4ZDVLZUlYcHBlbDZWVzdrSXBEa2xn?=
 =?utf-8?B?MVRXNFQ0cjhlMklEazZYTXZqekdGcEJERjRqZ3Nxbkx2MDFpMU4xaVVYeEF0?=
 =?utf-8?B?dGF5VUJ5U1JySGladmpkdytOblZlRHl0c1o2TUZzaGE5MFdhR3BMYUlZWkNu?=
 =?utf-8?B?YmJVbnRkQUQzTTJjVUVNQlBBbEpNcGkvVDBTN1FXWXFwU0gyVytIQS9oYjdX?=
 =?utf-8?B?djkvZWZORDJIKzFWd0g1YXE1bGhxSFc0SS83UnMreE9rOWZIa21VTEdUWWpk?=
 =?utf-8?B?MWI0MGQvT2d1Y2twcVpaUDhxTmxvUEFOR1lqUk44UTJXditqaVRvTWhhNkhU?=
 =?utf-8?B?OE9vMWk1ZXZRNGQrczc2Q0xIM2JHUjZXcjFGT3hpTlJnc1lqbnZrcDhMd1M3?=
 =?utf-8?B?bWxubEtSNjlLQ2dqeldZK0NvQ2htbFp1Zlp2TzdCODlJUmFsWm1ETHowVXdI?=
 =?utf-8?B?V29BQVpmN2JnbnZTMlFEVHoyd1dZT1dyMG01ckRvZnBXQWJNc1NETUhocHNI?=
 =?utf-8?B?WHYrRStPMWI0cDVSV2M5RFhTTnJnYVhMcUZnS0JxLzRrT1BYWkxzZmFkVEVP?=
 =?utf-8?B?NDFabnlSMkpqaWQ5dy9KMGVad0pVK2ZXaGQvTTBtc3lyODl4MVZlTTN0TE1l?=
 =?utf-8?B?cXBPV005RUlwMHFpeXF6L0ZlZWUvdHAzbnRqNE1ySjdKTnV6NzlrVFR5SWFp?=
 =?utf-8?B?Q1A4ZVBqZlVINEh4TkhvTUM0WDVSOGZRNDM0bk5ubzI1MmdiTDlOVlhLWW5W?=
 =?utf-8?B?OHo3MUdnanpZdDVIR3VhT2M5T2lXQlR6RGI5SmRzU1drU2RwNmlqY1dIT1d0?=
 =?utf-8?B?YjA1RjFZT3hVaGx4Y2NpTlVtRHJhNit5cTh5Qk9xaGdkYTRLNGRHcmR6ekRw?=
 =?utf-8?B?ZHJrRCtVTzZ0TkplalFuWjBISW1VQy9WdzhPZTJHTWVMa3ljRVJvRTZFeDhM?=
 =?utf-8?B?a0RnUldOUkI2Z1VHWGl6eTdOUk5uYzBKc2lOaFFGNVVDemVaYkwyTHdXa2hB?=
 =?utf-8?B?S21Jbk81bVhFTWV0VVBTVGFMam1qTDNUU1A3RFBhaHJ0UUhJWnl0emRjNjhk?=
 =?utf-8?B?cnZwVTlDY2ZBVXhsRDVhZmVnQ1lRbWFoVmdiL2N5SldLMTBIcWZYY0VUazFI?=
 =?utf-8?B?eEludWtHQVc0M2o4a1liTXc2cGFUdlFNTVNZajhUMFpTU2xvNk92SWFIUmVY?=
 =?utf-8?B?eDA0V1ZJZGtuOVZ1UHYxNGxCNnhXS2hTZmVBdm1yZzBJWTZxSkNNZWlWRUlM?=
 =?utf-8?B?V0Fpd0Fpc3A1M1NhbXlvUUhxRFlBTUV5clo1TU9GT05rbFJ2YThxZ001dWwr?=
 =?utf-8?Q?8mmGE1uKh1Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRuc3F0UG5nMC84OFRCbmNOREhVbG9DQlJmUjZJdnJjNGZXUk81a2xJMVl3?=
 =?utf-8?B?SXN1Z2pjYUNVTTVlSnQxUFFwV0JLRFhQa3ZkUXR0NEpTRXNUdklPRlc2YTFN?=
 =?utf-8?B?UVk5R201Z28wd2ZQWkMyd21tMkx1MjVPVXBCc2xBbkdkc3hzUHRUVVZabkR1?=
 =?utf-8?B?TFhuUnRSRDJNdExkTnl1ZVl0WkhPKyt6Nll2UWNzOWkyN2grOU95RElORUtP?=
 =?utf-8?B?ZDVLSStESS9XQnBLaU8xWTdHNXJ0U3NndFRlUi90QitXdTk1OHg1K1NGMjVG?=
 =?utf-8?B?bHdOVnBEbTMxdDM4NDZteGx1Um9kSjlmaGU2V0dRVHVOcXRHZ1l6bUpwc2ZV?=
 =?utf-8?B?SitwbUxIeDFWWHRVM09BM29KdmprSnVHQ0FtVjA0bVp3S0pybllhdHZPSmMv?=
 =?utf-8?B?cnQwZWYxeEZHV2hFUDRwU0dTblArdnNRa1ZBT21vdFFoSGU0dTQydk1BRitJ?=
 =?utf-8?B?Tlp2VHRXZFRjL3ZmNzdjL1NjSFpnTUJEeTF1MkZOUFc1MENoVE04WXRnS0s4?=
 =?utf-8?B?d1RiMUpRV0kvbnBjTEU4NGs4V0lPY3VRcCtrNmFxUlNMV2FvejAxVy9BREZr?=
 =?utf-8?B?VUhuV2E5RHhQREhHNkovTlR4ZE1HWHVhdk5JVDB1Um1wNG1qOWdncVpPNlli?=
 =?utf-8?B?b08zT05RN3JXdWY0cmhZbXUxcmlyL3pzMTl5LzJZR3BNcmhzdnRPaEpvK0Va?=
 =?utf-8?B?b2FBR21JYUdLaGRNTWhIdWd6T1JkWDg2SmZ0UWlZemJRV09mQWhDZTNpamhD?=
 =?utf-8?B?T1R0WDZ5eFJGK3ZsYXE0ajZNY0d0aE9YL1RJQlAzbTRtQVEwak5NejVXU2dF?=
 =?utf-8?B?dzQ3NlMzTm9sdTRqc1FMK2N6STVhS2pqVURIK2doVzZNRlJOc0k0ckJ2Lzdh?=
 =?utf-8?B?NlB5cjc4eDErQ05jc3VjdnFXNEREVCtFV3lFRS9URzZxazhMVU1Wa2ROcGdy?=
 =?utf-8?B?RTc0dHNSQ3NjTVovaWxacFJkVndteXBpSEhXeGpPSk1Hd1V0RU1aZEpueG9w?=
 =?utf-8?B?TDY1bldWRTMxcFBLdzRueCtWRjd4OTNsOXRRT2hyQzNacmxsdktuOCtjREFy?=
 =?utf-8?B?NndpVmtQb3ZETWNub09wbFNVZGNNaXI4YXYwNG5QQjRrbGFocFFiSEhsUEdH?=
 =?utf-8?B?amsrbVJFRzIrdEVFUThPQmVHdzd5NUtBSUdFaFZmbzk4M1JGamJNN0s4aXJs?=
 =?utf-8?B?ak9lMGVaSDNpSmVYaUN3RkhmeHN1ZDlYN0swTDkzdEFKbDhYNVZtTmVGbklv?=
 =?utf-8?B?U09NbXEwN29zRy9tcGFxMHR4enliaEFCQ1F3WkthY3BkYmhjWlJhR1FtUFBH?=
 =?utf-8?B?dHFRbWJaa1ptMWk5cm9qTHkvZmk0ZmF1N1RuZzdUNTNLbFozWVcvYkVnd3V3?=
 =?utf-8?B?OWw5eEtjKzZiS3VReXFTcmY2U2tYc2lCYmVxRHRqdjkwMjA5VDhyOFAvb3ZN?=
 =?utf-8?B?TTUzeFZ4OExOOUJZL1pVQ0IrRXV4NjJzUkpvUmlJVE5kWi9MR0hHVmtORTZo?=
 =?utf-8?B?OTB3ZnhtTHJpMnQzYWZxbEhvSnFjSnFHSmE1VnZtMytXNzJFS1J4NGg2M2Vq?=
 =?utf-8?B?WXdSQzdWUGdkbkpoRTJKdnRubXBOWXhYa3BsV0ZWc0lFaWZ3SE4xT3FXa0ZQ?=
 =?utf-8?B?aGlGTUtIczBaWTZMYXN6WllmMXNhSWQ2THBOU0VvaHJKUzU5a2gvaWJZeUJZ?=
 =?utf-8?B?Zy9rWXowaXJ0RUxkaU43blp0eHIzdEg5WnJQc05uaElCQlRzVDNCRGNKSHA3?=
 =?utf-8?B?RUgveUZMR1FkK1FmejNJVUloU3JBWldyRWZnemhtSkdEenYvY2RNdUVUWFVo?=
 =?utf-8?B?bGN2NFByN0xxNGhvMU44S0ZJSGFqaVU1dExXN3h6aUZKMDNTTDZnQW0wRTJD?=
 =?utf-8?B?NXFRR2tYWlJyakJHTkxaMUQzZ0d5RzFwZytyQWp0aFVjYmk4U25ZRkM4UU90?=
 =?utf-8?B?TDJnaXV1bzJ3c1BBdnhSdG5WdG1ncGZsTnFoMlMwU1VUenNUM1F5YnJjQXB2?=
 =?utf-8?B?Rm5ya2FuWmlPcXZnMXZEZVhQbGN5VDA4WjRGbldKV1FWUnlKR3Zacld2c3Ix?=
 =?utf-8?B?MUZXTDFDblkzTXNCNUEyTzF2MXBoUFBJSkNEeU5RVDRTUllmdU85OGI0bnBv?=
 =?utf-8?Q?XkC4Upqjl3tSUQrueUTHjBWus?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5b8fc1-5005-4a78-e472-08dda3464445
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:00:34.7696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnYKUiXZby3Zpq1LttKjmSfOFFjaNxmkDbVkChXaSSardmeqAuqIiDSKN9L5BAxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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

On 6/3/25 11:11, Emily Deng wrote:
> For the evict fail case, the evict error should be returned.
> 
> v2: Consider ENOENT case.
> 
> v3: Abort directly when the eviction failed for some reason (except for -ENOENT)
>  and not wait for the move to finish
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 7e5a60c55813..bb84528276cd 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  		cond_resched();
>  	} while (!ret);
>  
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +
>  	spin_lock(&man->move_lock);
>  	fence = dma_fence_get(man->move);
>  	spin_unlock(&man->move_lock);

