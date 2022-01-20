Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D961C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 15:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8870810E4C0;
	Thu, 20 Jan 2022 15:44:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8340910E4C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 15:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMtx91f3pjebX2jjCgHSDluzfIhKY0Etuos14N4UpKIY5P7wN+pNo8lQdLjEHl1mglUteTs/QOLstuX/ufXTFi++EX9ctwa0lv2DILnCuU4hQvg0ToXERI957sHHG6X8qWyr3JpryRwzXzxQxA/RqynvHpvHw4aYoy5zPbYksTRhjcY7YOyruP0x4vdfRU5amf6A7IUB7e+Rpz9o404KOU5X1aIZDCi4JMl0T45QmZIFbM3kCWSBPLut8y1o78r9SRhYCEqb8m/GQx5z0GkmrWP0LMpSZjHXu2+r6kdu0R/hb9zXcBBOgH7YA/irdsVWqtP0SyJAhRJsvn3ZUUsPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBucI6ttNlK8UgAcNPM2hB83Hqw/+xCmXsLEDD1UmTc=;
 b=OgxE0qFO8BwGB8lWb/fcD7o1ivlVDUcHXWvuBzzvlpPO1HR+02GoJJxoovz2bLShJJfrcu/Ly3W94zLRhQ/92owckqyKydg4a9veO3cyUnD0izAnab0Oypn9jVhsCL1Aclps4dC05bPT5UTgvaZFsYhBfs9XSB4WAplSLv0u/O4jdoqYXZAr+S2FUxoYiDo2iIF5cHc/pLrpKsYCG6kQJGzrG04jKgP7KU7iFNgZAtzt0zoy+s13e2eBdqkc1u8wpAheU8keGV4vdJihnShagGXqRG0F2Ape0NkWSmMBJEU8VnaFI80R/nN83BifnuKfM+1imnbgwBVZvovvLIjSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBucI6ttNlK8UgAcNPM2hB83Hqw/+xCmXsLEDD1UmTc=;
 b=zm+3xsUwgRO5Je5jpEROQIXNFWJRP8XKxb86ybDqJQ/mVM2l40NENCqU8UUG/VROZoj067cU9MqArB+EWDcsa0whe2ka0Ho5Tiej5IW4Y+hmwS9aFOjEtimnhTeknvotRCeiBlhrfbrlkAPUD0plKp9WNgA/4X1BzxMpC8Wkjek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2664.namprd12.prod.outlook.com (2603:10b6:a03:69::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 15:44:17 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 15:44:16 +0000
Message-ID: <d1d17376-a51b-90af-5481-f6e839da0d8d@amd.com>
Date: Thu, 20 Jan 2022 21:14:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/9] drm/amdgpu: add helper to query rlcg reg access flag
Content-Language: en-US
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18)
 To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a0b70bf-5b07-4e41-f165-08d9dc2bb724
X-MS-TrafficTypeDiagnostic: BYAPR12MB2664:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26647126A34BDA1980FDA3D9975A9@BYAPR12MB2664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu/NHmAna8qsfSsDk4sU8w9EJXLjskK95VGQVuxNkYUcr9pqHsIDSx9P99ZsMRLfgfmT+g/yp+kY0iS2bOQppKAUimpxAUcL8MMiaoqx8cdox/q85kmLFhm7hy8MpR8M7urHU7YTIi65UfBNwsOw2C8r2AFB8Dl26Wg+hw2hYpDr2890MDj9LwGV/ZoiH+BMnMSPCDNMAW05USpcl6V/wzNdoIDO+grbyAVyC0XEzhMtTLVXVyRcjdKaQRgvVwggDztxveRg9jLwqS4v2BDyUMO1H2Dg2iIyVjBATS/C79rMOlnnTYVTp1qkRfIYpi6pM6ffMv7Foo0T0TI/tgnqSrkhzSxmeTYNvg3gYAxFSirwy2MWXzaq/p5Y+qzCy9j1/vQ87AAhQNU5GP6ukh/JBOwImFJzRsQzeFgh43UsD77r2/sCXJUpQvjtQL+5VRN54UzobqsS+Kx1x6oDIl+f1BfiTllaZn3r3ywFc0nM5JzcIOsOtBFwjRMZz8vNCwSyLH2S5Ic7e3yzFmLJza2cM8kjAtR5MTcCASIFDKF4JSqxmZ5M1FMo8SEl9zSG4jVqM+HUbxiNuGPktbYHotT4iTG4qB9MqHfXk2bGbMx1GfzSDhPsjIur2bwiyM9zIVGyZNka+pH8pLIqzf3tfl9CVpq1VS/hdIDCz9ra/09dNkDzGOUYy+IW58Wbxihu97a83vdVx9MIGSqNmnrJ/76UZLftDGx8h2/wSo6YsDDuVMuBvp2enIuuuzHKw1J18k2O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(6486002)(66946007)(31696002)(53546011)(316002)(5660300002)(66476007)(66556008)(508600001)(6512007)(26005)(6506007)(31686004)(8676002)(86362001)(83380400001)(186003)(36756003)(2906002)(2616005)(6666004)(8936002)(110136005)(66574015)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RysrRnNVK28yU1VsNUh0SjBQVXo5a29QWXlJY3orbC90aElQQUlsbzI3c1oy?=
 =?utf-8?B?akVwWUdFYnlJNDJwQytHQ0ZtVDRIaFpKL0M0ZmdWbVA3R1Jod3I4b2dyOW93?=
 =?utf-8?B?TUJxbllPb0lnejBwaWZVa1Q1Z2lnSnlBK1lDdngrcWFBN1FpL3lvODFOZnhO?=
 =?utf-8?B?a2V5bE00RlV2Y1BVNTFTejkvS2djU2tlVDlPWDBuQTlaTU1wSnhwcXhLNG42?=
 =?utf-8?B?SDVpcE5zUXRRR1Jtb0l5V1gzNnRrbXpVa0k3Q1dDbDh2d2thcmtTMEcvUTJk?=
 =?utf-8?B?M01EWDJCZkxoTEN1RDNOdU9BbTE0cFdzQURFR05xYURXWkh4WjEyRnd2bTdl?=
 =?utf-8?B?RmFqS0pOWmcrTXFjSERtSUs0YW1WQnp4RjN1NVdlQ00vaHd5TnlWams2VUls?=
 =?utf-8?B?QWg4UngwYVdib1NNaDJRL0YwWE1aa055cm1ZaW9EWFVDSXRGNzZvdHFXTThm?=
 =?utf-8?B?S3pnMW5STC9kOWJIZjJUeVhFKzlsWU9yZE9aNWtMRFBqTEh6dEFFbTVkZ1R6?=
 =?utf-8?B?NDhYbUxhY29tVEpVUHZaSjE2N1o2V0dtZ1FLTmpXRmNXZWpXMlVuMGpVSWtH?=
 =?utf-8?B?UWFwVndSTXJqbVlialdqTExyS2pkV2d0aURjR21OZ1RzSUhTTncybk5PSWhT?=
 =?utf-8?B?ZzZMcFVxQ3dTdjRZaHNVUWhsbXhQYzBYeVRKYmpkeVBrd1M2VGFOdWVVanJV?=
 =?utf-8?B?NXJWSy9iZld0eFJUNWRQQ0ZyWjBTSThETmFmZ1VWNlpsWXhNdjF6dFdSaGQw?=
 =?utf-8?B?aTNSWVdDdTJoTVBiZU1ybGNaa21KeXJKQlNpN2JGWE5XN2NtTFBBU2cvWjVo?=
 =?utf-8?B?NEFoQml5bUdZRGY3ZHErbDBidExhNTBqL3dpMHZjdWxFOU53dXUrSkUvVnJ4?=
 =?utf-8?B?VXFsaitXeThDZWJ6VHgxR3BXZlhQZUZZK053LzdWdk12NTJJQ3I1NHd4eHJx?=
 =?utf-8?B?VDdJcUFtb3ZPdE5KNTYrTWtuam5SRkcwUFNUY29PaHd5RkQwQUUya0JnT2FO?=
 =?utf-8?B?Ry9jVVhGcmExaUY4SEh3eE5uTnBrSjErRXloTkRDVXpZTnZoSEF0M3Iwb1JM?=
 =?utf-8?B?SnNZQTVKdStIRVA5UGEvb2J6RnV2M3MzbExoelpuQjBUM3lrNEI4aUdEaTlN?=
 =?utf-8?B?S2pzZEpRVHJQVk0yS2pUNFJrSm81MlBWTTFzQTdkLzd3L1VwRWlhVXp6aXF1?=
 =?utf-8?B?aEhDemljY0tIN3NkOUZJRnlZQTluZlB6M2czQ2VPMyt1TW1wV3RrdnFqeFBq?=
 =?utf-8?B?V3RWUU01MEV3YVd0OTMyY1NZS0tnelZOQm9EbDFodHBRSXRMZ1czbktWN0FZ?=
 =?utf-8?B?L0lORFVzNlAwcTN5WFdlSVJrU2pCeUJ1QjJkTFlPQ0dtSnFzek0vM0NFWVcy?=
 =?utf-8?B?Wk9ZMnhqb1JoeE9EYjhZVHExdk80NVloaE05Ry9PQUZPNmZrWW11TVNrS3Q3?=
 =?utf-8?B?UUxZM05mZ01vek9xZEo5S3NZVUFNR2JuWUxyQXVQNnR1bFdhekJUeDNRQ1d2?=
 =?utf-8?B?ekw4MDMxQzY2dUJxOU83OU9IeEVsei9xc3lnWVJEdTFhME5WOWUrSWNmQ1BL?=
 =?utf-8?B?aVlBM2h4ZkhKdUs1ZWkxNW1OQ0R3dXh4eUNqVGJEWFhJWVBpT3NoalZvNXd3?=
 =?utf-8?B?L2RDMWN3SXV2R3FwK1ZTU2cwRTMzakJXOWJHTzhZS0w4SHNHVGdVZWVEOGl5?=
 =?utf-8?B?emRGS0hJYmZROFVPV0EvTyt2TThSQlFVQW1VSHNHbEtINmQ5cDZrMEdHNVRX?=
 =?utf-8?B?MFBidjJmK2p6dVIrLy9BZVNiS3hJaTR3WTRMSE5TWTlxYUFwMVVRS2hXVG1x?=
 =?utf-8?B?RXN1SmpKSFlzZlhId0cyMXdHWTlSTjBCZ3c3NXA2UDZlWWk4OXcrbzIzSTJR?=
 =?utf-8?B?WlRNOFI2a0dBTlVPZmRSMWN3bCtDRXVvOHNlQUZ2c1dabVllT0tSQWZkTkgy?=
 =?utf-8?B?aml4S0xRd0l4bW83YThRdkEwb2lzTGpJeXhWU3FzcWNRelJGeVN5cUM1alhq?=
 =?utf-8?B?TUlSVHpGYkZTTlc0YzgwUkcvV3JOcGgyUDgyeGVpd2JCa0tsYkRIdFhKakNF?=
 =?utf-8?B?eVlzUjhpdENkT3N3STR4dGtickVJNTM2ZWExZGNtMkMvL1ZjR3lHcVp3TDBZ?=
 =?utf-8?Q?MgLU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0b70bf-5b07-4e41-f165-08d9dc2bb724
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:44:16.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4V0hScQiFH3m0ZSLBQ3AqQ2DMsDA4xYkDPwnsu7NgA1H6zorcM5+s8Gh01XTHo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
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

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

On 1/20/2022 4:48 PM, Hawking Zhang wrote:
> Query rlc indirect register access approach specified
> by sriov host driver per ip blocks
> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 35 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  8 ++++++
>   2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 07bc0f504713..a40e4fcdfa46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -820,3 +820,38 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
>   		}
>   	}
>   }
> +
> +bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
> +					  u32 hwip, bool write, u32 *rlcg_flag)
> +{
> +	bool ret = false;
> +
> +	switch (hwip) {
> +	case GC_HWIP:
> +		if (amdgpu_sriov_reg_indirect_gc(adev)) {
> +			*rlcg_flag =
> +				write ? AMDGPU_RLCG_GC_WRITE : AMDGPU_RLCG_GC_READ;
> +			ret = true;
> +		/* only in new version, AMDGPU_REGS_NO_KIQ and
> +		 * AMDGPU_REGS_RLC are enabled simultaneously */
> +		} else if ((acc_flags & AMDGPU_REGS_RLC) &&
> +			   !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
> +			*rlcg_flag = AMDGPU_RLCG_GC_WRITE_LEGACY;
> +			ret = true;
> +		}
> +		break;
> +	case MMHUB_HWIP:
> +		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
> +		    (acc_flags & AMDGPU_REGS_RLC) && write) {
> +			*rlcg_flag = AMDGPU_RLCG_MMHUB_WRITE;
> +			ret = true;
> +		}
> +		break;
> +	default:
> +		dev_err(adev->dev,
> +			"indirect registers access through rlcg is not supported\n");
> +		ret = false;
> +		break;
> +	}
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 9adfb8d63280..404a06e57f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -32,6 +32,12 @@
>   #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pass through for VM */
>   #define AMDGPU_SRIOV_CAPS_RUNTIME      (1 << 4) /* is out of full access mode */
>   
> +/* flags for indirect register access path supported by rlcg for sriov */
> +#define AMDGPU_RLCG_GC_WRITE_LEGACY    (0x8 << 28)
> +#define AMDGPU_RLCG_GC_WRITE           (0x0 << 28)
> +#define AMDGPU_RLCG_GC_READ            (0x1 << 28)
> +#define AMDGPU_RLCG_MMHUB_WRITE        (0x2 << 28)
> +
>   /* all asic after AI use this offset */
>   #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
>   /* tonga/fiji use this offset */
> @@ -321,4 +327,6 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>   void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
>   			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
>   			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
> +bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev, u32 acc_flags,
> +					  u32 hwip, bool write, u32 *rlcg_flag);
>   #endif
> 
