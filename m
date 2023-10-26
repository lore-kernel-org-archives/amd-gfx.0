Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46F0C25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 11:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0C810E7B5;
	Thu, 26 Oct 2023 11:40:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03EA510E7B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 11:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFspXB8eQsxLZI/TjuJYjVB661rBOjHSCMEQAS93Ulv0JGY6RpMxjfucwHlyOLaheB8IDBaRMzAm878Sx7g7hiSo6Ce4kOzse0CXEAeJ8IEuM3X9b3lE50n1oPem3UlEZSXYUlSmq6TrkCxVQRIZ8TbKyMMmQQAmmqlPHlVdQcTYQdLqeXZs6OiFqvq5qjrAtYku85tbvnyrmYOHkAeoy6CgrH93GJbrsGt+s7y+uBFMUg1ghnceLhpl9D/0JKsEoT1lm7jXTaJ+OGcvyZO84KZDjJqm8OdqBNTCIl75K9UDdaQd706GXhTairExOLICsca463vSEwVbODmNeqRPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vcAJBYP19ha+xCHT6PstZ16+EiUxhxaPul6ZoH2rW0=;
 b=Lw0BfrvSzJIUfnIUCbbFnKPHFB2voD+DDFSLkGKr9b5dfRmSTTsZXHwEAty3iVlvBGtSy+V97Gc2xJRQlEtCZVqezGWWsqG0lIjw/eTtjKMH4PxiQUsGZldAoZvW08PFgT45OzHRkeoj0Uq3d6tOHVYteRPvuACXxvZDlsteVLr1eH01pbxYs7zAnQUz0esXr0NG4WjXU6P1qICHmC8aLKOlhsn2GZldAFbMylsjSznlxgk9bimP/SqCOwW8JuRWcX6KkcSWU4/uBHa6DCOUrffD2kbBVAzAkmBJYUKZmnO2dNLC2tMNuWVlErKQt7y5lTkS2kPe3nEAWgoYpLNVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vcAJBYP19ha+xCHT6PstZ16+EiUxhxaPul6ZoH2rW0=;
 b=mll3cpU+5ccXEwVCbm8X/e7ghNyhyuYAWc2CzWTRsEvV7Z6iqlT2WlTxAiZn3ocZWA/684z/OQ2SDi8jTE9aSczxZXs0XDp33Y/lRoZtx6AxuJBLXsk+fNhzF/wgGF2sfnBBV0kV46DwaGd46+nZcScOFUl8uD6k4RVQAn/IA80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 11:40:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::af19:f731:8846:68ba]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::af19:f731:8846:68ba%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 11:40:36 +0000
Message-ID: <382f8b84-f889-4899-b17a-0989a771b7c2@amd.com>
Date: Thu, 26 Oct 2023 13:40:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove the seq64 map sequence temporarily
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231026102402.206783-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231026102402.206783-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2fb7ba-45dc-4295-3083-08dbd6185ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eNTVzIqpjjglWPmW0PfNu8n9WMX9pmmY2UaKgB+776i4Oqm9RWf/RebpkmYBhnjHwidHVkTgEbQ1mLJYAXdiz3hwPaDQ1hefsmacm7XBYloykbLJw3sA0/U4vtN5phNkbOf9iIaglv/MnFuIAt4fsjgLdNqyGk3Rk1cDSE3pMfsPaCwRqkUVP6EHDrWaNetprR4uAt+G334OCiFfCxk9z4sW0QP8wq9gFsBMLBUGm+yaV4QqgmuidlHp0AFN2UhjCpSYdTZpYHKq87d5MMLEZUH1GkkDrvtg25WL6pJi/RdfxW4QGAA+8VMVwcxPQ3YBQs2/U6CeFfmITvvxgK76zlmwzC3JL0uydeMpm/bW28UNC3DG4SFs3vGD20n8lyISEtKFUMjVlh3FX9m4llH7wHJZfS0O5ybVoayAIrhHGF5oLFwq8VfpDTT7/Jb1ezlz75HAcURc19KT6M7Kejk5XxIu+Aw0na4VzHjxv3TDdrff1TKodk+lEurufCsC1gWs84mCn2cVR9oKRMLUZKvg4WnVSunRk9AkFtNVP2FxXRwkrOA93t28IGnXtwloDr3uA3cba9PPd1Xz+G4aYU+JQzuvs+mIoK/WN141RuyZjKwAOVEThH548eZPmJX1CAhMrMVnfWsmIxPygQ07oXCZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(5660300002)(41300700001)(86362001)(31696002)(36756003)(2906002)(38100700002)(6506007)(26005)(6486002)(2616005)(6512007)(316002)(8936002)(8676002)(478600001)(31686004)(6666004)(4326008)(66946007)(83380400001)(66476007)(66556008)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpaeVJoeDBKenBXdk5NQmU2dUV5TndtNkdsaE1OZFdvai80cUlkYTBwRDN2?=
 =?utf-8?B?MEcvQVIrRjZFNlhUN2tiVXRKQlIraXUyL1A4YnFQYTJ3RWpDbGdjRVFGZTFT?=
 =?utf-8?B?R3pod1BhQzJRamJUbTRYL0FiZ1Vyb0ovMUdmSXFNeFBRdGFpTjF6Wll5UXNz?=
 =?utf-8?B?T25kVkVVN01PZHBMK1VRcjhnN2w0Sjg2ZXBZSXdmWGFwMkRBMFR6Vzcrd1Ar?=
 =?utf-8?B?L1E3UkpBUW9JZ3NicUpnWkRDbFJHYU9uUURzcFRKenkzcmVNN0dQcDNabitq?=
 =?utf-8?B?dW5lVWI5VDl0UUtIK0FYLzNSUG0zcDNnVHlFeEZldnIyaVBDSVpqL2xPdXl4?=
 =?utf-8?B?WlJFN0FvN2N0cWtza0xMNzhtS0c4TmRvNDZFWmxvem5uUzVGUVhmYkhXSTcv?=
 =?utf-8?B?UWNkL1BjYjlUTlRtN0FHYjJnQ2pzZ3RwRERnZ1RvM21xRXZIWVFja3Bqays2?=
 =?utf-8?B?YjUzZ2xoSmNBM0UrcnlUOFJGb2JXWVRXL1U4d0VMdjBmb3daTDExTGxoU3lw?=
 =?utf-8?B?a1pOTTdUUHJuYWdaQVFhNklNZ2JrQ3pOcEZHQnIxWkFUbXZtUmE5OFc0dUxM?=
 =?utf-8?B?amhydnZOUXhody8xa2RXeGFzZUxsdjdJcHJpbXpvQThFenFGNXdvcGU4Y1Nj?=
 =?utf-8?B?b3NzbGNXcE1zL2pPVlRjN2VRRE12ekNndGVuTmpNeHczVGtCTmUzSFord2Yz?=
 =?utf-8?B?ekF2Y0o5MnE4Lzc4RE1PZmFtcVlET3ZVLzUza0tPeHlUc3FJUCtRRUkzdE53?=
 =?utf-8?B?ajd6Vm1DQ05vUE9xUVBEeDF2akROUmd6RlUwbkYvQU5LTjZtalhKZGFYaysx?=
 =?utf-8?B?WUU0UUp0YW9ic1NqUExZUkFlSk84aVhJWXUrT2JyMUpKS2R4M1FRaUFmeDlm?=
 =?utf-8?B?ZFpINk9kRXNoZkk1QmtJdEo1M2xyRElyS1BiTit5Z3EzdkVEZVhYQ21GbWJL?=
 =?utf-8?B?ZEdEUjhtcDc3NTRLSGJlNmordFBnYTdkcDgyVGozaVdDbEFtdTA1QjdGdTUv?=
 =?utf-8?B?VlVLWHRQVHdKNEkvR2hyWFFoMU9xV0d4bzRkTm41TjJOeU5adFFLSm04MUU5?=
 =?utf-8?B?SWNtSHdUdlU4TGtaSkFhTTFNdWlVY3g1WXFTLzhjWE5Cb0VPMjJ6Z3BKZnI2?=
 =?utf-8?B?MmRLb2ZXOUJiSnhwbkNjOGFNYnhnQ0lURGUrbGZKL0svT2pES1hYL08rc1RB?=
 =?utf-8?B?bndoM2ZLWENBMjVjRlExNytjZkdnK2UrdEZ2NTVvcmp2SWttMDJleVpFcFdt?=
 =?utf-8?B?dXhoR1ZaOHYvNTI2aXFmRjZUSnBudlRCdU9IVjNNQUxKNm5GK1FGUDI2alNC?=
 =?utf-8?B?emZvN1JsYXBIQktVN2UrZkR5WU9lNVJHcEdTVWxxZ01FSm5ISW1PNkdJNkU4?=
 =?utf-8?B?T0ZlRFg0OHA1UkZyNjhDUTFhWGNPN29DZDBLMHFhY21heXpHYnJrRUVzOXB0?=
 =?utf-8?B?MjQrendxUUpXZWlUTTRXUERqcnZ4bjFGV3grQ1NUTXZFUWhWWGpvRFo5RDZK?=
 =?utf-8?B?bWpqWWFzWXBwM1BVQ2JLVTZqWDBUdER4Vmo5ajkvV1ZOS1l2SHF2eCtLSG9E?=
 =?utf-8?B?S2xaWFFuc1k0d3BUVG1nZS9Zc1EraE1LQnBDeHZDUlZRbDBWQ252dW5JS3g0?=
 =?utf-8?B?ZGJtNTNpTVdiSW0yKzRONklvcFEzYUZ4TUozOUxCSzdDMjl3eXp3b2E3S3JZ?=
 =?utf-8?B?c2JCaDhuNDRRVE9ZRFVHeHB4VkRjWS9URDV1dEtETmVKRyt5OVZnQmtqdE44?=
 =?utf-8?B?WG1UUDYyTHg1QXFKeG9JL1ZBMy9KdmtMcnBaK0VhZGhicmpYSU1Bc3dRZTRn?=
 =?utf-8?B?OEh5dmdSVmluYVFFbkltekpqWVZaMXFvTXVIaERSdFFkSjBaYmQxUkIwVUFN?=
 =?utf-8?B?TzlqRVJPT2xqemlJVG9sUnh1ZWJqNURpSlNpVnVwbHlLV3MwVDlJaGhxN0JV?=
 =?utf-8?B?MFVQUUREZnZ4MjU3U0l1M2RQRyswZy9zNXhxN0Rua1VQejFRNjcyQVl2ZEFJ?=
 =?utf-8?B?WDE1T1hmbU1KdUpDL2lrSTJuU2U0VWI1SU1QRkVENWRQR0FIQWFqaFdGaHUx?=
 =?utf-8?B?bHZCTEVMZFdzZ1hja0lTdjBLS295Lzh4MVNmdjJZNFNVTS93ZDV0YWgzK2FU?=
 =?utf-8?Q?tAQM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2fb7ba-45dc-4295-3083-08dbd6185ea8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 11:40:36.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+iaGZFaTVWY++bTTrZnmQALkY+N5BHLqS81bylDngiRmSI0RTtr7l5/VkN+AD6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.23 um 12:24 schrieb Arunpravin Paneer Selvam:
> Temporarily remove the seq64 mapping sequence.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Please push to amd-staging-drm-next ASAP and ping Kenny when that's 
merged (or if it doesn't merge automatically).

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 55fea7564758..b5ebafd4a3ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1365,12 +1365,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   			goto error_vm;
>   	}
>   
> -	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va,
> -			     AMDGPU_SEQ64_VADDR_START,
> -			     AMDGPU_SEQ64_SIZE);
> -	if (r)
> -		goto error_vm;
> -
>   	mutex_init(&fpriv->bo_list_lock);
>   	idr_init_base(&fpriv->bo_list_handles, 1);
>   

