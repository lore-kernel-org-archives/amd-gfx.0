Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB48C47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 13:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E79510F7AC;
	Wed, 31 Jan 2024 13:35:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1097D10F7AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 13:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnFH0RU7PQyG5YNQwooTY3NRSwYGNTbBodlWmb9M6I4OoAofFX4KxQJpbDeAuSXfPT4ulAuCs6F/OvR1YL2dxgzybS4ufEla3ZOex1B92PIZ8+i9cVEj9wPJZAurrT5dEZMAiRjGUwzxChcM6Wki3gqNXiPDRe2di2mu4rLAVXODP4jRkOmwRhJMcevhb3k/UMaGjUdYCHBDXUojFlzdQzxLU7yFc5DleWC/Zp/l7qmB7vAWVkGNqM8rV8RnNAGHhv6fp8ohXA21RWwd2c/LqCgvN6n89ItrwJI9UU905z7sg9QzAutIrSg5+4KWYoFxhzRjdvBCh83en0wM3vBFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xme/BfXrazexxLyH/kmCnPdOQWqxVXnC/mwdOGoLz8=;
 b=P1qEioGOjSpxaJZtEkKLNGAqZOM8+qYHu/wgj8sJ6XqdDMax13CkmdAXyzG4P8f+z7or/zj8ScimpIE/AO2duvS3YQkHopyhSsI5wH5WP+1n6spWq8wvOhR2Q6pCpcYzUQ18iEf5LjIvg1r5gKJ7UwlfofvWug6HFWN+QlwRCPlnkqCvGWKPBO9yYaLLLst/Ipxpxn1q3n5T9fmD7izy4CFkTtnf117M7/juClgWOveSj/8bj0nOaYm3QPCNq0CWqlzLlmZM9/xi8IxnDFqf0Fyk+dLwj3p1rYBGTy2Cgx+Z7WIw9AwfMDKXT/LEfWe6KSoinZcj3bOaZIN50M0SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xme/BfXrazexxLyH/kmCnPdOQWqxVXnC/mwdOGoLz8=;
 b=FdmgDRNAcyvnHGFRncGMzkS7kMK4zlcOwPkAarlZ3wLE9gXoLDLFw/IMtlmYvIsiWXLLoE2BYBR1Za5PfojAlX0QpkFTcl1qINHD1iptJgViULOMs+EDX2uRk3Xuw6ZeupNbb7aJC9ICypSuRPYBZ9Y8Dvg+lmkSkYo+2ueoAEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 13:35:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 13:35:25 +0000
Message-ID: <7ee708a4-fe48-4152-aa8d-fdbd98d97f3e@amd.com>
Date: Wed, 31 Jan 2024 14:35:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reduce VA_RESERVED_BOTTOM to 64KB
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240130200810.2434013-1-felix.kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240130200810.2434013-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0006.eurprd03.prod.outlook.com
 (2603:10a6:205:2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: d627df0d-7aad-48be-cb05-08dc22617b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzs9yHr4Uk39/m7tk3+nu9sensAa8/qam8hX018QJIs3XjtQXWDJHboJfx+ynNSWYL1Se25fDNqcnG2eV05KuLTRLnS4cF39PrdvHT2JSkJtztUC260pn9r5hcFcjD+zHBidMeUG8ssdXmZKvszYrmWxDuBr8ttNk4kQVcyII02lsNF+KUNDdD4iLVE5trqmXLhc//Nqu2ctTVOqEhzZcIOCAzhAuSa5O3Oimtg4efS2Ub3mw52BR3K/WVkPZ4/p4XZtY4OLm1rax4dIzUdFvlcbVdnkIF+1YD3U+Fccu+yfyliF5QXrHj5kDl4l0xJYmiP8lP5SjDzZAlh31F3Yu9jrHJlamrTcMKYEneLx9OCDaPNRHcbRZqe/TDW1gc0Hh9j1PXZjnZF1QL5OSZ06ygGSPD5oz+9uoQTSP/2ImWkWOuFDS/jwQJp2wyT87T8bEatorPCMRWE4QCPrc/pzzaZNXDP7kZWKmwZWeaIHEAclio9sCCj3b1ey/Op2b+ASZLnnFTh0sQL8XQpQWusfTh9KodR9Jj3PxU2S3e0IkuDvZMzYeZ0MjZ68jm01rsNteqAZBY6+MoWnZTcPOT1dcfjAlzvrVo6L4EYrnWMILM4/87wsoGSaNaK8LMEW0W1huzxOZiBth99y9TIxuWwOIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(6486002)(2906002)(6512007)(6666004)(5660300002)(66946007)(8676002)(8936002)(2616005)(4326008)(26005)(66556008)(316002)(66476007)(66574015)(6506007)(38100700002)(478600001)(86362001)(31696002)(41300700001)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE8xU1ZJa21MNmtDVWhTcEN0djBGdnkzSnNDZ0dBSDQ3bFMyQXZIVGVvVHlt?=
 =?utf-8?B?S2tVSXh2NkZRZmNLeXB0Rzl3d2tzOGVmR2dmYU5xS3I5S2lCbW9PSUgrZUFz?=
 =?utf-8?B?L2hkTjhjQkhNSVV5dU56K1g1Y0lkdmFkRVU4WERJVUcyR3crSHNZMnV4ckVo?=
 =?utf-8?B?cVRDVjE4blVKQWsraHZ0UlprazQxYVVqZHB5aDNPY1lFUmJnUVJ3V0t4ZVN6?=
 =?utf-8?B?TGFNY1dWT2NwS0FxejhEMUNYaWROVFdCR3JNZEJEdGd1UVMya3ZYRml5M1pP?=
 =?utf-8?B?b3JxNUs2aUg4SDQ5V3hkREdxVEJwUFEwS2kwWGFtVDFzWWxSUVhTaGwxSHBU?=
 =?utf-8?B?QXlrblFlM0hDQjZ6RU5WNjRmT3A2Tkh5MFJpTFNRU3diRzVUNEdnM1E0Z2JD?=
 =?utf-8?B?NWVsYmg2T3lhNnFiSm1UNjZ2enJrZ2F1cW1iOW9VZXZGUEVIMnIzcXJqbStQ?=
 =?utf-8?B?T1BWcE9TSlNSREo1ZUZuaTNvR24yd25yK2t2TG8wc0FkVmNJTFY1aUdiWXo3?=
 =?utf-8?B?SXNWcnV5RXg5NWRJK3J1NGw3elNNajJUMTF3QmlYVDQrTnRnejRZUTUyQThP?=
 =?utf-8?B?QnNJcFluVHY0RGFFYVU3UVFTQUtWUWMrVlhDK2JxM1dPREVnSlhhUDBZcmhu?=
 =?utf-8?B?bGlpM2RCZTg3OWpjbkxZeWxKVGZkb2VRSm1RV05ESndKeHdQMEFmeTRVVHhQ?=
 =?utf-8?B?T3pZUmMxOE9MdmZmcXFGMit5SFduZGtFQy9Ra1NNMFhDY05CVHI0YTNHbFdP?=
 =?utf-8?B?TnBqZkxvZmhkZHgxQWM3Z1dJUHBYTlN4WlRMUGhORElqQjUveEJ3R1J1ZVBC?=
 =?utf-8?B?SHhSM01wcWRHajVTbDBzejNsTDF3enZFaE5QWmN1MkttdHROQjY1cmthOXFx?=
 =?utf-8?B?cXN2Y0pBbUNTcjRaa21WRVlMbWdJV2h0N2R5cTN0bVUxRm1KRGZGcTlYNm1i?=
 =?utf-8?B?UkRRRXdkaUd5bk8xd0N6Q09NMDFCNDV0YzI3M0RKemtYVWRraEoybmZ6RXA4?=
 =?utf-8?B?THdsNUxjR1VuZEwwbmZQRHlSdC9OVW1VOGdocXFJTGlXaFoxRENQZnI4Nmxs?=
 =?utf-8?B?UUs4T0dmNDZ0RmIrRzFjcWtIVVMxcmo2Skk5ZTJHZGx2TS9mUVhOVWtFejFG?=
 =?utf-8?B?MWxHS1d3VGtrempKZllRNTYzV3laTythZyswWGFybDJibU5nVTAyTmtydmxL?=
 =?utf-8?B?UFZoVGRJY2JJN2pyYmN3K3I5eFp2Z1ZJbitVTGh5RnVFUzBoY0xvSTFJQVd0?=
 =?utf-8?B?ZFB6U3I5d2UwTzluSlg4dXk2V3RTZnlFd1FRcWM1WUpIS0xXMHcwMDFsNFdM?=
 =?utf-8?B?ZTRobW83RnBhai9kNUhkOFRoQzFzWC83VytHRy9QR2tKdU1hYUw1ZEFyQVpH?=
 =?utf-8?B?LzhHMVZUZGJZNkNDZmZDZmpSNk5rNVB3M0hnZWdNWGR0T1VGekN2bllzeDFQ?=
 =?utf-8?B?bGhpOWpQdmNEaGJYQlo4QmJCNzJWUFNQTGhRZGlDS2ZOaklOZ050bThwM0hH?=
 =?utf-8?B?dUN2c0tkSEFqVmdDNjFSQm55alo3aVJYNVNTMy9mZTZMUmgyREh0QUdUbzk5?=
 =?utf-8?B?WEFNbUpwbVA3aTc3TWJycURIcUxpcUpmYzEwT085VUFvc3FIL0tCcDdPR09z?=
 =?utf-8?B?UUtubktGaGJYMy9mcmxUdFBESC9wbllGWTh1QWpXNm8wY0V6NHh5bjlYVGNy?=
 =?utf-8?B?WU52TUJsNHhWd2trMG9lZm5SZ1B0dDM3dnBiL2RiNHppQXpGSGl3NUFlK1ZJ?=
 =?utf-8?B?RU9meFQwelJQc000a3ZsellwaDUzNDdJVzlIOGg2ellEdnFQWUhDK2thSkMr?=
 =?utf-8?B?V1oyZFBFRkNDTy93eTgySjFsVDQwVjJBdUU4WncrY3dzT0s3Wk9OYnBhQ25G?=
 =?utf-8?B?ZkZJZzI3cTBEL0F2OU5ZUW9CclJHT1cxQmMzSFY2NVFOSFNCMWtSWEtHUm5o?=
 =?utf-8?B?Rk9BRFpudVNOcFFud1NFRkJWWlkwWHljOVNUYXJFNDd2cGI4Q2pPbnRncmZ6?=
 =?utf-8?B?aDB2NklBcHlhMnJ4N3V2K1hZMHloaU83YXZkc1M2M1lZaTR5bUtmd1NkQm1B?=
 =?utf-8?B?bEUvdkVaT0xERElBd3hHYW5RSWJmUldJbVp5bWxtWUhrcStGQnh5YTFmaTF6?=
 =?utf-8?Q?3slY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d627df0d-7aad-48be-cb05-08dc22617b2b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 13:35:25.6307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbzzktV04SpMDWx5OfRAQZfFa0njdlTeNNejV+EWv+Ue3RXxzDgj22JsaQncsv5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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
Cc: jay.cornwall@amd.com, lang.yu@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.01.24 um 21:08 schrieb Felix Kuehling:
> The reservation is there to catch NULL pointer dereferences from the
> GPU. Reduce the size to 64KB to make sure that shared virtual address
> programming models can map all CPU-accessible virtual addresses for GPU
> access. This is also the default for CPU virtual address mappings as
> seen in /proc/sys/vm/mmap_min_addr.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 666698a57192..2c4053b29bb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -135,10 +135,10 @@ struct amdgpu_mem_stats;
>   #define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < AMDGPU_MMHUB1_START)
>   #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
>   
> -/* Reserve 2MB at top/bottom of address space for kernel use */
> +/* Reserve space at top/bottom of address space for kernel use */
>   #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
> -#define AMDGPU_VA_RESERVED_BOTTOM		(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
>   #define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>   						 AMDGPU_VA_RESERVED_CSA_SIZE)
>   

