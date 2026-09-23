Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB14C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 14:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99B310F092;
	Wed, 23 Sep 2026 14:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9p1zhq8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1E510F095
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO04VVQsAmfyAGLvaqbwTSPa+eVXjX7db6HF2J3AzEQlv+nJRZHZOGKhgPsZEfKmSj4tzn9JVUb7bZcrIv7IXRUYML3ajXIwBl0skoVOQZzdnZJMPzk7/XL62u2bTqdsZga6HIU6HvhDrQen1IWjsexVscMJyF3641xuLZVXp9WEzlQIBOlvNkiUmnZiy7kpmJQMTg1SZSz1OLKLs03tcv3KmMIpIaCysXMzUCZl0kAmGAnP3w5uDOHhz8Zm2nawzBtQSX9LlZnR4AT6yjWn16VjA3JPs/XI/rPL1VsypSo9GKMf+LngYwGrwJdS8GCHT9/QTmoroV3hpslylE7eFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUQs3y8J6iNVPq4PXqZJR21+6gTUbLQvMrmr4Z84LC0=;
 b=D1mOhevah9ZgPQ2VP/iWxWQybb/P3hha2wMfvGwIhQBirOpmYV8oiT3iVA1wJDDX+qhCKmOOUcIdDnS4b+7NBLntleIPwmfwOrotudk/Vs0u3XP3v9Rj96WZpE1TShBkbJNPtygyvln1lUkD/JTgZFluqb2Fij+cfBvNXjIsGAndQg4hh03l+zmq0uFhSnYk3ZE780RtFfoNLlyoSERPj0gs4KiywD6C++gyeHoWaC2ieslV/5ealo3Us1MsPC+qpLIdaJ+xGkmwyyzP8t3CI7YjEs7LaE+vsTQ4jQCPPkJ3axxyfC/gJosaWGZnP/Ye5BmkLUshTS1oZDY6y36Nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUQs3y8J6iNVPq4PXqZJR21+6gTUbLQvMrmr4Z84LC0=;
 b=G9p1zhq8GTg5jcQLHWoyJnwiNsPjndiJJ7uvLaNZTrPAEWr7kVcYmP7Vplv6dkgNp9I6i2dCeomV4sMRWS1/jr/OIKlXbxe8US4MEQ92gqoLgJQLoPhh0u+AtsTCbXNDNRo+lYHyPQ8T3HI6XQlKvgVv5/HqejLd2Sfd97UD9wU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:13:03 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:13:03 +0000
Message-ID: <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
Date: Wed, 23 Sep 2026 10:13:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260922093436.596947-3-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::24) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: be7b072f-7bac-4020-de00-08df197cc7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: LJrdkXrC1H4Dxn2/zhZj7mzVx8MKtsyU86kbV5YNfq5nAaEapP0Ngl8qrKPt/o9x8faSNBusWYAmhKUeowAIw3p7jSbmAElQFmLO5nFz77TxfhWe4fq6OwZCa+85fm1tJ4YRq8xcMDRJwWZoDC2NuQnvyJzh8pKxdq3Li//GQGK/pAZmvfIJKwKMBFQp9W9w4s9qz7ahUlZbirQBv1kNbpVkNJiRX0y0SgRBG8sIAwJv1BVfqLco6rcCblWdLJfwy33yggDcDQni8btqL22aNws7uODC4Os9maZWhRlUn1McdgjDl7lSS+Xxh+tK818MwF2U0WD8nlvmnIm4ZuWb3JJVWPcTDkovF4iRy+eTZEMffQwH5dLcQ5iHSNzKqx30SncdniksRuw2H1NLlXsn0bkvNSVgyO0fltdRj9SpELqC2cCiH5P6lL12OUXMrfSe/b9UtZgnFQJ5C4r1RzewSEHlsJFfzrgWTOYRr9Y5ytFSLs89H7lFiMvmwoeDumDOaA1IIgA8m5mbO09ocl4IKgOrIxD5Sd69nGUsyy16ocHeMpfVslwEAu3OwIF18+BAhUFYiRMpoyqQZB0fXhLvn6+gYlSP8P9+m/1jRjvf/DEAjH2KCQDfSdW+IA6YBpphGIHJPLlLAP52kqw3Q7QR6OkfE4nnV3VK+dzXGSixGaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxac2Y0WktVRTRxWjNCNWFFRjQwdWc4eWJBb0pocjM3RXlINUJmWWpaZHFx?=
 =?utf-8?B?T2ZjUHRWOWpNWkVGUnBnK2FnS3dwcmViSE82bGpndERjVWxuTWVVcm5HMWN5?=
 =?utf-8?B?OTdwKzBUZkJPL0xlZVhkb0YzSTZidGJVNjhGa3hsaUNUTC9YTXZpTlJrN3lX?=
 =?utf-8?B?YkVUc3RFSUlaWGtBRGREaStKNENzMkl0RzY2TGxyZjJKVW1EL3g0NGZpRXFX?=
 =?utf-8?B?ZWVHNHFZYWlvcDBJUStJQXFJYktJTWNRNXpXRlV6b2V5MWJlY0oxK1lMZ3NI?=
 =?utf-8?B?RzJyWGlhYmZsSmhyU0xOeU1UdDkxSlAyUTdsSFBTTGlIaEptOVlyZFAyN0xj?=
 =?utf-8?B?MnppQzh4ZjVpVldnQkRlOXJPTWVaVkF2MmhNMWJrVklhZE5RdkpHQjJGVTV6?=
 =?utf-8?B?MkZLNkNrNzZXUU9IVmkySFl4VlV5dkhrYnRmVEtaTXpBOVZ6VTZaNi9STmU1?=
 =?utf-8?B?eXhydy9rYTRVKzR2VEdEUG96OUREZHdla01DaHB4M2l2Mk5jNmNvT0pkOHNX?=
 =?utf-8?B?SHdLdnVBZU9vMFJNUUlBMEViQmhUQS9OQ0FoNVIvb002L1AwczNpdGlpVU9y?=
 =?utf-8?B?VGJIcDBsTzRJSkhYZkZHS201eStWUm9GUldwUDdlb3NJV3pxN29sOFl6ZGMx?=
 =?utf-8?B?bFVodGhJaTNBd2lFZFE3eTRqazJDcFpvL2tEWmR3R0puUGdRT05VQk12SjRE?=
 =?utf-8?B?bDhmY29mZFpFZkZaYm9nQ09mcjg3S0FCaGZXVGE1dWtuTGdSMzJ0Qk9pYVdv?=
 =?utf-8?B?bFB3L05pZkVZclV0RkcwdzBtRC9hRUdNeVJwNk02VUR3NzJBVGMzUFdxSFJj?=
 =?utf-8?B?ZlVNK0lDT29VQ3ZUdXlGVW5TOTRiUXo0T0lGU0NYOXgrVTFkUC9vYjJVeFVW?=
 =?utf-8?B?RU11RVkwUkJ3dnlwdDluWWRuNW1FK3hoSmEzWjlHQ1RIdTZTN1FGOWNxNS9F?=
 =?utf-8?B?NkdmbFI0WVpuRVlaVUkrTmZkdnJIamx6TUFjOGRBOFBYeENQZ05NTUM0b1Rr?=
 =?utf-8?B?aFd5Y2ZwaHpaSDRaOERWQTBxSkhwSGhyaWJxVG5LN1diMTIrcm5HdFhzSklj?=
 =?utf-8?B?ZHFxNGtTdlZoT1BPR0loQWd6QnJxcTZEcTBjVXFRZDdFY3I2Q2s0UG1OdUxQ?=
 =?utf-8?B?NkxLV1RjMDQzMTV0UmxZRnpEZzA4cGd0eTFJTFBiMnptbVNyTjJyVzlUaWNY?=
 =?utf-8?B?UUpaNUI1NXhTNHE3bVd5VHJJRGxLbTd4d3FnakZieWFUSmxwNmdOTFQyOTE4?=
 =?utf-8?B?QXExTFAveG1YWnVLcEd6MDYwV0FoVUlsRVlXNllGM2V3bjVtNzBVVHZKeTMy?=
 =?utf-8?B?a28xY3FTYXZQekZqQXBCL1NPTWtqMXlzRHEvbXlYcjV0N0pTSmpNMWVFL2F0?=
 =?utf-8?B?VHV0VW1lWGlLMldiVUQ2ZmtIRldIK2VHYWpuRWh3a0lTRnlUbVJjTGhsK1RZ?=
 =?utf-8?B?d2VkcFY0NGhXQ0NZUDNSRXJ1ZkhzcUFIZTlyeU1GNWFGWVhlMTZ1WHhKQmZv?=
 =?utf-8?B?UU5JN0IraUsrNmdMakdNVWwxaVRxNnlYOWpWcEJDeitpTFFuVCt6anNXVVhw?=
 =?utf-8?B?SW0rK3dtWTZEaEZ4dkdwRUJGb2dFS3FrdXh2Zis3ZVBiV2dMUTR6NWpIa2U2?=
 =?utf-8?B?cFVXNnQrbW1pSFhQTCt3RnNXL0xNVk9NU1NWbnp4cjJMQldZeDFySzRmb1lJ?=
 =?utf-8?B?RUVDdDdDOTdqQWw1YjkxVGl0RURIem1UQzR3bnhvaXk1S05mYzU2N3NxaFYy?=
 =?utf-8?B?TGhaSlZranJ1S2JaaXBFY3M5UVpBU0VLTXVXV0N2MGpQaEtwbzVBdVdBalNp?=
 =?utf-8?B?T2ZXSTA0OG5vd2JJeHA0NUVpWGlBS2lZSndrbSsvN1JaSm9CbWRKSjNRamFZ?=
 =?utf-8?B?VXlLYmRJcDNZZnBCdHFKNmJpdUpVOE8yRm4rYjlBcVhvWWxFN2FUSzdrajRF?=
 =?utf-8?B?UVdObUdqZndkUzcvT2N6cG00bFhFa2RMdC9mSjl5bEU4MHdsemNUUDBnend3?=
 =?utf-8?B?SEZpUVdiRWtUU0ZZMW9WWFVXOFNSQWIzZXA2c3hxeExBNFVSZXZka3EzcXlr?=
 =?utf-8?B?MjlBREJhZEpsYlZQejJXZE9OTXpnbHZrdEpFUEpEQnQ1bjV5M3JLRWVwTWVr?=
 =?utf-8?B?ZDRGL0Npd1d3UVBMRkhSbWQxdnZRMVdOQTNScTZEM25DdkRzcng1WHBUS0ZY?=
 =?utf-8?B?cmZaU1hPOTNETUptb1d2bkl4bTM4Y0h6d2s1SVdZZWZoRFZ0YTVKdHY4VEh6?=
 =?utf-8?B?TUNFU1N1MWJIbmhZSWt2SVlSWDg5ZmNIenEzOWRUdm9qUVR4cmFqY2p2a2Yw?=
 =?utf-8?Q?MD6suQs18g1OiY07p0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b072f-7bac-4020-de00-08df197cc7a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:13:02.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8XylwWQaCx76ExwdbwnFHMtZtqCfSeV0B5Xqohp9WcafrGwIkKZPm7blFMUa9W5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
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


On 2026-09-22 05:34, Zhu Lingshan wrote:
> This commit implements a device-wide PMC config
> for amdgpu, which including the profiling owner,
> and the profiling enablement indicator.
[JZ] I think it should be render-node wide, not device-wide
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>   2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8eff6b9ebe81..45897dca802f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>   	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>   };
>   
> +struct amdgpu_pmc_profiler {
> +	struct mutex		lock;
> +	struct drm_file		*owner;
> +	bool			enable;
> +};
> +
>   struct amdgpu_device {
>   	struct device			*dev;
>   	struct pci_dev			*pdev;
> @@ -818,6 +824,8 @@ struct amdgpu_device {
>   	 */
>   	struct xarray userq_doorbell_xa;
>   
> +	struct amdgpu_pmc_profiler	pmc_profiler;
> +
>   	/* df */
>   	struct amdgpu_df                df;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c924a55fd16f..74ed42e53264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->pm.stable_pstate_ctx_lock);
>   	mutex_init(&adev->benchmark_mutex);
>   	mutex_init(&adev->gfx.reset_sem_mutex);
> +	mutex_init(&adev->pmc_profiler.lock);
>   
>   	/* Associate locks with lockdep classes for ordering validation */
>   	amdgpu_lockdep_set_class(adev);
> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	kfree(adev->pci_state);
>   	kfree(adev->pcie_reset_ctx.swds_pcistate);
>   	kfree(adev->pcie_reset_ctx.swus_pcistate);
> +
> +	mutex_destroy(&adev->pmc_profiler.lock);
>   }
>   
>   /**
