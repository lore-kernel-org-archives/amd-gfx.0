Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 10:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CEF1131FC;
	Fri,  7 Jan 2022 10:18:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0B81131F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 10:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVi2KMNOl+yVZXiI1RGR3W3+ydPuaIpvFTLpWFK2B7y0jux1jUNBgkqxoY43dUiiLGatAbZu7FZ3/cfTWtMwUyHZRzGrRkLBQnGGen9FFEfwM1fCXfENViviarTPc3KiUAzTWa/aha3+J/pZo9MNAqyBg+FfX4z9W0UxcwQvCmA0jqWoMYSIfcaSIwaIMZkzc+jsRcRCEgcIDHeF1KeaX3ADEN+vN64WMbs8YpIK5QSUxV34LLkzou4T+ezOXr4o7AFdp5jhosE+JupTWGnPbW24E5QTzRWH/D1KqT16FxvRsKwlFyKK/JJhR52JPjDOq9GIq+jLbY/3CEbZB5vXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEF4omx+9BnFRp/LxeeV/nHZVtbdBIowOqeTAOwFMcc=;
 b=F0aBcHX1uAMgUn3tnmMsQ+grG2ejICYJ9nnbYJJvdjTrOgHfWU1QUwnsR2ku2kf2u/Ee5OuXe8J4LcKHS46bAIXrNhk8FO8ajue3cg4GtDlHg4QcRYSxL67YylqSvPxHVSuaLdRLJcYax0iYFJEOdwHMl7Eng2poKPXITsZY6FK3uMUVEIpZ472B6Itj2QNGSLoMKAdoA7/WbrkSNFq6IV9etorSxRh347myWXwIqleoUrexxv/EZ/u2J6eKxop3go7K5UVfzSHR+vsSykNtGdjYrp2rci7CxBhg+BKdHu7Jro15FEPdPQRm+DeP27sEii8VKnndxN4haulbQ0MDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEF4omx+9BnFRp/LxeeV/nHZVtbdBIowOqeTAOwFMcc=;
 b=jHJQFTmm2McpLotqdXw01w4qDgP0mBP/lnGHZ1BsoHG58FNGwxfU6vV320HhliReNyt0OToiyS0NV7qejYsK4Zp4K6/Xpk5NXzxQjGTyo5bRIJiwQ/3neHwHjbMu10jbeedx/4F1UE43XttkW+cS3AphnaQhX/sTGm2YHzraQnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5552.namprd12.prod.outlook.com (2603:10b6:5:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 10:18:48 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 10:18:48 +0000
Message-ID: <4702ddb8-d16b-c330-db7a-d3eb18c9693e@amd.com>
Date: Fri, 7 Jan 2022 11:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] drm/amdkfd: remove unused function
Content-Language: en-US
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220107085115.8820-1-nirmoy.das@amd.com>
 <20220107085115.8820-2-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
In-Reply-To: <20220107085115.8820-2-nirmoy.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:610:53::27) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524a4aab-09a9-405d-ad06-08d9d1c7184c
X-MS-TrafficTypeDiagnostic: DM6PR12MB5552:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55525FE57A40A19656931CA78B4D9@DM6PR12MB5552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzINqyAGB1S1iqLM2BEkJQGGGSdhxR4oDR1nNbNLADTjQvFc2fglH5RwCeHE5gew4D6JpimUsORBXbkZ9vEL/r3GfudtBGkYj5w9YkvcRB30bw4T6aC+cN5S8BngazJLucGacme+e5ppnCqQsiJ4/DJu5Vo48RE7OfquAF7/ukszzqpdO31QRRNEtCcaJOULs9I3Db89eewQM5+jnK0Agzh3gq3zAmwNM2b1Fa2pHcZE8eC7NzHuRrF0ekZdO6Z8f4XZV+pID2AxSNc8mQ3ClIfN+CpQUzrss8ZvhBxxd8MCKNpuPAcNLF+6jamkdgxAmShOWmqqRnBy+ZPEkTcejKU0hBALwsjBShLiTi7SJ98xre4KmN5fKNUDEtwbWoOzfqrnxn38bEHbejO56C39k/t6c5AEEX7/P9SOQQ1FuQd+57TVzcHPOgRcPhUlj5iZjShfrjr1uRxHrtut4G38jc/vjBQELp3fni/YslgHctcJB1LvAC6fSE+XKfDF7YWSIefTI9dXwTz2BvkcmcjTgCCa9X0WmsvOtXgJWwWRm+AAe2ZjJWm++lyDRLIpstGIGlGuAj8D4Ouv8pPJxgraGWI1t/E4Pb+wZp82vxbtIFJscM1u9uUHon61LuMeTDYeSQqitEbW7Yu2Ad+AZoDc/XTCppMGVatW2RIhy6HflV9GCpM95S2mX4ZIZHGuBCfrTU3bYGt7z6AEaXkoCszFSAeKY3F2yvAKMdeZNjVeBxkAW+HYD0yAuV30oIMMrfk5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(6666004)(6512007)(6486002)(83380400001)(4326008)(31696002)(5660300002)(8676002)(8936002)(508600001)(186003)(6506007)(53546011)(26005)(2906002)(66476007)(66556008)(66946007)(316002)(36756003)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xLaVlrMDEwYXNZTkNjT3Z0UWJwYTdoT1hkKzlRQjFjc29tenMwWFpKSTNK?=
 =?utf-8?B?d0hwcWZKeTFPcE84c2puOStqc3Q1OXc3ckt3TzlMbSt5TFptUDVpUkowSTNp?=
 =?utf-8?B?ZG5GaHhVN0gvTk45TW1NQ3YyT2xIMWtwVVorN3Q0QU90eloxZk9ISzBpK1ps?=
 =?utf-8?B?RGFhbEE2dW5wQzE1RiswcHNCSDhyUkw5b2Q5akRKL1pXcU9yWkNHcTRjdEhH?=
 =?utf-8?B?NEplN0xQT1g0R2tpRDVjRjhDVlMzM2JFbFNSc1BISTZPU2l5M05Xd1NtTElr?=
 =?utf-8?B?QWs1YnQ1bzRxQkIxTmNXM3JRYlcrQ1laZkE2Qm9icE9XY0VoRlYzbjlEU3Vk?=
 =?utf-8?B?blNsSmowUmk0c2c5cU9POURUNmFJbUVYNWpDK2x2bXQvZndXdkRUcCtKWlFv?=
 =?utf-8?B?OHRFcDdNemdQSzQ5d3JVdjBybDhWYmEzSVVYZFJTVGM1S2hDbXZIaE9rMVAv?=
 =?utf-8?B?SmtPWVQwNzZjanp2TDZBQ0xCQ2dia3ozaUR1VmdaYTVQeTJNSFBFdk5YemNR?=
 =?utf-8?B?YlJWbmVyQTY2M0lmdkVlbTFGMHRpYStPbkw0MWRNODdXWkl0bS9DSjRESEFZ?=
 =?utf-8?B?d2liN2phVmJNYUlyMTU5T1dKSjI0N2hUU3YwUUhwTktORG1VVXBmV3NvWUw0?=
 =?utf-8?B?SUV1T0UvV3N6Q3J4SXRURHFqYjNSN0l5SnJTL3JIclJDU3lTUUJsdDM0SVNB?=
 =?utf-8?B?bjhkdUFRVzJLekFEUWwxa0hyc1hLYzM5OUJSaitGNzhXd2xJblowbWVaMFkr?=
 =?utf-8?B?TGd2R2oxL0tYNU9mZGdqUjN5YXlvYVdIVFpxaHNuMWRLTGdkenpZS0ZJUnRY?=
 =?utf-8?B?Ukt6ajdndVVkUzFKRWZ5NjVwL3ViLzQ0Ti8zL3ZLLzV3VzhCZWF2V3BjVGpy?=
 =?utf-8?B?bXdZWVc4Q1NOS2xYYVdMdk1QM1lBMWNZOFM5eWpRNGZFZTZDSENHc1VRbVlZ?=
 =?utf-8?B?dzJHYWxkQXlDcGR1OUdBV09vUzM1TS9ldTBqTFU2ZWpnMWxDTkJZVUlIUWNH?=
 =?utf-8?B?MVcrSEkwbVQxZjdEb0w5eG1QMlFvZ0JmeStzc091Q0lRbExmL2F5N3B1VlQz?=
 =?utf-8?B?dkg0RG5vSGFCeWRBbGI5VndaTFVHMlNRUTB6MlY5cmJ0aVJNbjVwWVhJQzhL?=
 =?utf-8?B?S0d0NWR4djI2QVc5Z3h0ZmJrZnFXSFlmUlBQamQ4YUthcjFCaVJGbm1lTjBI?=
 =?utf-8?B?bWhyN1IyWUN4ZU5mL0U2SThRWDQvWnMvRGRDaENKS1JMRWFLMU5aaE5obmxH?=
 =?utf-8?B?SjV4WGNQbCtOcGVsbFYwS3pDOHF2VG85c3laTnNMRk5LdndHM0dZelJBT21L?=
 =?utf-8?B?VVoyS2RjSjJYMTJpTzNOc2NmQW81Y1JaYmRCM2NkUkp4QWpkaWY2dlJReXht?=
 =?utf-8?B?aVYwRXYzZkdiVStYU05jYUg5SGl0eDE0V3hwWDZ6Wi9aL2t1MjV5eE9malhh?=
 =?utf-8?B?SEhoak85b2FuQURKNGRFQkh1emw0THcvVVpPblB5QXJmT0VzMTU1N0pLcDc3?=
 =?utf-8?B?YWlNR2R1V0JMNU5ZRC9rd3BQa1E3ZDNjUC81a3lDVThBNzdreHJkbzhmQ1ZN?=
 =?utf-8?B?c2hSenh5M3Vabk9rZDBKUUZ2UFRxOGNCMVNKd25YRlRERHc4RDZnMUFuZFpX?=
 =?utf-8?B?eVlWUmppcVU2ZWk0bzk0ZHFDbFdQVE1oNDJtMWI3bUt6b1VHUVQzSzJrZGcr?=
 =?utf-8?B?S2I1QTUrN0pVTGROMUs0Sk14SWhhRWFpaVdnUUhOM0tLcEsva3UrOWZvbUh4?=
 =?utf-8?B?ZzFwMmdCTGl0TTZ4RVlZMnNST3BPSUcyWDNHV1FWbVBjZXNJdmJ2Wng3ODhm?=
 =?utf-8?B?aFlwZEp4TUZQVXR6ZkhnaG9UVWMwT09sakRZY255c1I3emtySTZ1ZDg4Rkdm?=
 =?utf-8?B?ZlV0dDl1SmlFelYrUk5qTGRwdi85L2dZOTVCaDEwMVA5WHQvSE1qSkYxcGl2?=
 =?utf-8?B?U1AwU2RjOHBkMGt2bmJUUEQ4c0dyU29VY0FJcngvbTVWa1lIRmlFV3NrdmNa?=
 =?utf-8?B?Z0tpamhjU0N4NkQ3VkFNdjdoQW5oN0ZwZDUrUEJwZFozUFlvZDVpY0ovTHJC?=
 =?utf-8?B?cDkxQ05yZUFMdzBVSnYxbXhjY0ZZUmxoSE91Q1pLK2FQOHdLZkVlZUhTSlI1?=
 =?utf-8?B?M0ZUUm1yR01NbGREQzNYdE5WcmFaRXJKcGxjcTg1MVltVDBQeEtWODdJYWh1?=
 =?utf-8?Q?d3zT5A8PcJNPynrO+ACIMX0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a4aab-09a9-405d-ad06-08d9d1c7184c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 10:18:48.8261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKasoSGxTyM0qvX/7moJjK5X4ddUWSXU15tt9me5+a9arPjtY0p6lFIrb23ezC6klIFsOwsw2EeS/9aDQ8bd1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5552
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
Cc: andrey.grodzovsky@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Found the commit that removed usages of this function.


Fixes: dfcbe6d5f ("drm/amdgpu: Remove unused function pointers")

On 1/7/22 09:51, Nirmoy Das wrote:
> Remove unused amdgpu_amdkfd_get_vram_usage()
>
> CC: Felix.Kuehling@amd.com
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 -------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 -
>   2 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 776a947b45df..6ca1db3c243f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -514,13 +514,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   	return r;
>   }
>
> -uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
> -{
> -	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -
> -	return amdgpu_vram_mgr_usage(vram_man);
> -}
> -
>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>   					  struct amdgpu_device *src)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 61f899e54fd5..ac841ae8f5cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -223,7 +223,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   				  uint64_t *bo_size, void *metadata_buffer,
>   				  size_t buffer_size, uint32_t *metadata_size,
>   				  uint32_t *flags);
> -uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>   					  struct amdgpu_device *src);
>   int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> --
> 2.33.1
>
