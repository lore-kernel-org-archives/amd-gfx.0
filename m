Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1208D2AB33
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 12:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D66210E657;
	Tue, 29 Oct 2024 12:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4DiX6VO";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964D810E658
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 12:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRnlOqiopCsqrUqLYFM7FoPdy4FTZt4H2Wy5grUbL4qlSKQwfdY7qlK2fI0jd6/WPu9mMgdqT5snRPgrbqOilKMJWvhRJX6EY+VprlIkp2pzc5RmSidGUYIb9NQ0eRiJiAgAQnN0xbYQeTE0khOexJGgG/FzMVxRjG8Iy+NxuErStdalyO/IgmntBfnkB8tSwxlDjpIH6yywP9G50FT6BCb/jpR6WMblbun1ZeUBzkgFz9gtPwytdLn9EXNpywkOgGCL+DWcv8MeI5KZkMvRggQqC/8yhUok5q/OtfdLYkkYydwx8Cz6gsNkrez6gHBuryFIy/ZxhKZduua+Qco6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlrGaxtUuul8441YZUjabR2iHpFoozQ/FgTv8MuqQiU=;
 b=N5pumsPbdbJZaEM1dql62PhOJfBs5AnPNqTkU5zJ5udbW1+XTzTsz9txAExHLcYilEZfh2qhkZGWSJ1TcGHGKV7WWPrv+jnWRbG38+hMbL0G2ToKPfuKxIZNTxMuaAEGWXQMglq6NmKsP/MNODgS13eeGIGgAalhCFkpokq/86quoSIkiWUYPk2uTBaI+Rvwy8tO2JMM0yDedTF3bZsWDt3nqtliqgjEAO43efQLn36jCD7iKWNg632byBTN8phccZmscG/kq0rpom+Zre+YrMpjpOfHgN3Hs+BeKM2Ym1qUPoza/BRcgkuWF8GwHckTIeOm8VfDdYmGA2ifyqSnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlrGaxtUuul8441YZUjabR2iHpFoozQ/FgTv8MuqQiU=;
 b=D4DiX6VOKnrb+BuOS/4FG3lpLxuDqieaemREqk3tw9ahhrzfKAbDKAZ9qMGl/ZxCD08ZvdEPyiImpqWOgqlCsoZXqLgZYvKKumtrwHyRtqEsV6pF0TcRC7tmBkZ9FbZbivFtyF0ilVpxrKB/uZy6GARiSN7AXbamWt3TsJCAXmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 12:14:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 12:14:48 +0000
Message-ID: <12212461-e3b5-4bfa-8df5-2c8b751001d5@amd.com>
Date: Tue, 29 Oct 2024 13:14:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add userq specific kernel config for fence
 ioctls
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241029110039.12005-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241029110039.12005-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df2c351-4db3-48ad-d62e-08dcf8134888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVhSYjhjejhRRkJVTGRyaVRKVjlmVURoelh2U1BTaHd4OW9xblhkVmxCM3ly?=
 =?utf-8?B?ZVdiYkljR2NTYnV6T05EdWVrcnRTZkJKbDRDanFBeko2anZwdUlRZ2RKcG1P?=
 =?utf-8?B?UkY1M0JMcXd3ZU55aUFyWGFBdytEeWdIL1BPMnRYWEc2TFRWOWxlaTlWMmpI?=
 =?utf-8?B?L05UNnZVYWF6QzU5NFZoMHh1VUh3NmpHU29DNWh4eVc4YXJMNWNibUErQUFi?=
 =?utf-8?B?WjRuQm1LeE9yQmNwbFNZRGZ4dTZDM3VHWE9vVkFDOFJTV09USEMxU2lBb0ZU?=
 =?utf-8?B?QkZCRk90OHRDODNSL0dKT1RodUFmTS9Vem54YTY4VnJDcmF4UHdVckZJQ0ha?=
 =?utf-8?B?ek51dDVoUmthV2tvTmdEaGVTQXEzZFYyTWlEdGVRZTRSWjFQbFovVzJucHo3?=
 =?utf-8?B?RDQ3QlNqaW9UQnJMRVZzdWdwd0I3OWdFV2UrSTJRK2VPTGlPRzRZV2lKZ1Ft?=
 =?utf-8?B?Y3VvTS9hUEtrYUZTRUZBa0VCSTF4bW5HQzlSdm8xLzRCcm9qam5JWk9ZN21w?=
 =?utf-8?B?bnQvM3NlYUJDbDVES1RjQ3R1S2Z0Z3Y4YzB3WTRrS2xnUEEvRWVnNHFTazhE?=
 =?utf-8?B?ZFNvTnMxc0VmYmFIdlhQdzR0amx5QmowWjI2V2NLTnFaRUtab2ZkaW80d0pa?=
 =?utf-8?B?c1ZVUjRHTW0zRnY1VHlXWWlDclMvWW5lNWlHNXBBYWhSb1lhdjBwSDg1T1h2?=
 =?utf-8?B?TUxHOERLYWJGcmxkQmJZemlpVjJSSGxWVUdrbzhuMEk2dGhaVDBaamlLMy9D?=
 =?utf-8?B?NEtjVHRnSTBPamJ5Vng5aTJ0d3ByY1hvUnJUL3pMVWlZT1FJNmRCT2Nyb2NS?=
 =?utf-8?B?VFVWTjh1ZEJCSldiRHZ2RVo1QTFxZ09uQmZ0WnRINmxudFZoeWVpb2R4eU1q?=
 =?utf-8?B?YStPV2lvclMxVnpJVVFCQnJMUUI3Y3RaNmM5OFM5d2ltbGZqVGZmbVVvNDV3?=
 =?utf-8?B?YytDSURnaGdtOW15TFB6MWNaYUIwbjloeFZOdkhnL3o0d0l5Um9TNzcxdnlV?=
 =?utf-8?B?N2d0c1lQMjh5TG9Qdzl6OEpXSEduVjFqZElaL1BKdEpRbFB0eE5ld3E4ai9i?=
 =?utf-8?B?ZXpmeUlkWTNhY2NRcnpSaGVGZVhhYytQQU5CMWg3ODZnNm5pVzRIdGZqcm5O?=
 =?utf-8?B?WVpHV0dNeXZMdHBwd3FxeVVCWEFyamlzOW1YK0ZZQmw5VkZYeUtnazNYMXRM?=
 =?utf-8?B?S1FoZ1JpZVZnYkN0UnpVTCsxa2lMQ0JNM1hYdzJ0bGpacFhUeDY2aytQN09y?=
 =?utf-8?B?QnVYQ2M1MHdqTEk5dWNDL0UxL3IzaDlGUnNyZHdyVXo0MUhadUJNZVB4QVlv?=
 =?utf-8?B?TWFCSmN0U1RKYTdJRU43dEhQSmtEbTNQY0pFSlF4NkFlYVByNWNGa21ER0Yx?=
 =?utf-8?B?WkpXdGRoSzFUR0NybGFLQk40Z3ovZThuMWl2a3FESEtNMkVYcXBlU1BjUzND?=
 =?utf-8?B?L3E1TGNkTjhRL0Q0bUtoaG8yYTdyekNKT3JFbUtqTHdwNlZJcnFTRFU3TVFH?=
 =?utf-8?B?UVRXck5WYmVRczk1U3V3aUUzM09HMTRxYnNiVlB0QnNwamJkYXNHS0crQjZN?=
 =?utf-8?B?bkdPaFdlQmN2TU1PK3dMbDlpTzdYenBGVTRYVHNXT3VRZUgwQ1VKZForT1ZY?=
 =?utf-8?B?aVhIbDFiUCsvbVJMSTVDR1kxTEZlS3VQQnBobjZuLytqR0lFNjgvVTRyMEox?=
 =?utf-8?B?T0kwUmRkcUpUUTAzR3NsaEFYWXBLbmR2QmYyVWU1L1VoemVpMzRMNVQwWGZ4?=
 =?utf-8?Q?w9mvy/vCq++yplgbQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1rOXZma0hBcjUwTDBvc0ZLM1dEdW95RGZQblpxWHJVeUVneDAwMTFXN3JL?=
 =?utf-8?B?R3lGOWxFYlhRaU1PT1FUUllGaGxNa0ZEcGR6bFpaL2QrU2NiVE1YcTRWRmZT?=
 =?utf-8?B?YXQvbmJsYXdFVTVhRmpXS0swcEFtbXc0SWFHVDFnVldwS0NsVDhrNkhTQS8y?=
 =?utf-8?B?cE16SWw3Mkc2UmJTbVJHVWpaeEZGakNSL3ZOOG16UVhXeUxzeWt0UGRnQU9S?=
 =?utf-8?B?RnZQa21zN0VwOFZPUC9halhtRitrMys4dVFIUjFzeWZLTDJGeXNMbU5lcG8v?=
 =?utf-8?B?ckl4Sm9NTjNnOTRMUno4M1BBZ1MwelhqMlRZWXpidHZ4REFYZGNOOEdtaStS?=
 =?utf-8?B?WUZ6aW9iUmZzQkxRS21ZTkVjYXhzQ0FoQ3hWdUpoaUg1Nm1VanNoemJCdDBK?=
 =?utf-8?B?eWtXRVkyZUdSbFhuY3BQM2NkeHhvV3kvcXBGZU9EVkN6WVFnQTFjRWtVNnl6?=
 =?utf-8?B?ZHRIRlRIU2hMbFlNaGdLMFdJenBGaVdSS2R0d2pvb09OVVl1Z3JhMEp6dW9z?=
 =?utf-8?B?RkRGU1FIOVBQbStIb0c2a0RiUmcwak1PL2xCOHBkZ1V3dEo2SzVJVWlPeFRL?=
 =?utf-8?B?S0w1d0JoVkhnaTlhQlZuWVdNa0NIZmNuUGZVTldWcnVVaVg2aVBLWVNOZ3U3?=
 =?utf-8?B?NHIydjI4aXkvNE5ydnpIaStaRXpDRnptNHcvL2VXM1g0dHg5dGVqMS9WL2FG?=
 =?utf-8?B?OStrSHRsYWptT2pQbEFtSFV2bGlzcmQ2dHBaL3hQNFI2SEppUDRONllhQ0pi?=
 =?utf-8?B?QjBCay9iREdSSkJKV252eG1TVHgvMHZqNjh6U3hDQ1hOVGhsMXNVYTlubFBH?=
 =?utf-8?B?Yk5mSCtha2lOV3RhNHNYdXlZRHN3U3hHUW03WXFqOTJNNDg0VVhyRkRIZ2NR?=
 =?utf-8?B?MjFsNXRZVUYyTGszOHFzTUlwcm1RbjZwQVhmUkIrU1NCekpWODQyZ1V3dERX?=
 =?utf-8?B?amsrQVcrRmhRUFBLZ0Rhb2ZUVXlMU0ZLOHBZTmEvekF1QjNzLzNZbWIyL1Y0?=
 =?utf-8?B?dHpGUUY1a2NMRDROZlF4VDlHU3pPRkVqNHdTTGNKQmlOTjBrYTdwcHRlcEc1?=
 =?utf-8?B?YittbGdqUjU4TDl5ZWlzNSs2Qkh6ekJEWFRvV1prR3BHVnJ4UFV0SWc2VGND?=
 =?utf-8?B?MGc1L1RVNUhBTEd0UVdhM3hydFlaNVFrUFhsSVp2bFBVMFovUXQ1QlJ1NVQr?=
 =?utf-8?B?c3RLakdheEpKNzVJeTg2TGIxYk9vNS9JaU5mMktQVXByU1ZHR1NveTF1Sk5r?=
 =?utf-8?B?NnRtRGxybGZ4MTQyU2hkQ0hudU10TmhkTUJqNUVIaEVnalpISGhzeXBscnlx?=
 =?utf-8?B?UTlsbXNPRVdta2dwbDN4WVR6RER6TVMvMVVURGdYVTN0RzJMTTZ2b1NKOThh?=
 =?utf-8?B?QnIvdkFDeXk0TFdBK1BYYXl2MVNYbGMwdWd3ZDZuWWRGS24yaHYxZTJWYVhC?=
 =?utf-8?B?Tk1DTHNtVmNXZm40Vm5DT3ZMODgxazZIeFN2QWtCbklnTFBDWFQrVW0zR2hp?=
 =?utf-8?B?c1hFYStZWGl3eWNGQWVLTzc2bktKSXNnTTFVc1RzdTJLWGdNYzhkaWNvaTA3?=
 =?utf-8?B?UW5PSUdKWHBFSUFkZFJLQy9VdWYxZlp0ZkNrYTZlQlJZaFRwaVgvUG55Wkh0?=
 =?utf-8?B?V09uYWFNZ29Xd2prbDFrbmp2Q3Z5YXVGam1Sa0FRUE0zZzFhdDVkL2NvOWhF?=
 =?utf-8?B?ZnNOemRkdVYzY2ErQXRUQjdxQ21WUGJSdEhRbmlqYXBWYWk3K21mWllzOXl0?=
 =?utf-8?B?ZGFFNEhPVnhaMmVGM0ZmNUdXOFpxRmlLNS9mSS9ZSGRxclE4QUVFMWN6RHls?=
 =?utf-8?B?Y0RCTEYwWTV4SllkMEtWTmg1WDdmemF2YlpnVW45LzNFQzl4K25SdmxlVEdB?=
 =?utf-8?B?ZHNOU0NTVUVjRHkxNHBpdFArZUZ5Z1J2V3UzckRIK2FuUUJMZDh5Yjk2bEF3?=
 =?utf-8?B?SnV1Yk9CUDhKQXgwOU5aMXlEWFV6VUp2dkR5enhqL2t0ZUNQYnV6ME01SUpG?=
 =?utf-8?B?YzRaaERHUzRFVDU1MHZNOHpTZDJKUTZYRFpsa2JxWVUxcmdDbERpbFBRc2Z3?=
 =?utf-8?B?bHhPY1RwYll5cFBIMVRoSGJTYTF2WWlqRkYyVmxYY2N0K3VyL3NmVVQwaHVO?=
 =?utf-8?Q?sHDR4Slkh1XnFy9xFUnNQG9LH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df2c351-4db3-48ad-d62e-08dcf8134888
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:14:48.7919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBqequeq7R2BB0t7Kxa2acwBMGQDZEtd4StLMLEComzJvUHi17KCsPL/NPMODCRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466
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

Am 29.10.24 um 12:00 schrieb Arunpravin Paneer Selvam:
> Keep the user queue fence signal and wait IOCTLs in the
> kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.
>
> v2(Christian):
>    - Remove the userq specific config added for kernel queues fence init
>      function.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 279dece6f6d7..bec53776fe5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -318,6 +318,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.release = amdgpu_userq_fence_release,
>   };
>   
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   /**
>    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>    *
> @@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> +#else
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	return 0;
> +}
> +#endif
>   
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> @@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> +#else
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	return 0;
> +}
> +#endif

