Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A6BD2A551
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 22:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3A410E21B;
	Thu,  4 Dec 2025 22:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qIA0Sq6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7454410E21B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 22:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3D+IK0EqRpx6TAx2C/abQh4bwdZ+2nYZB0xqbnr4Gj8Do8GWgD9oGIEn/4fQAO5Rc/7ttlPxOobi9KtkOEcS0YJ9HfQa3fMHeU32xTx1u2X98THGPEhrFfqSRGB6UFMFMhvjq+QhF7giO4HZWJyNzzTM3GgXiWWzHLmTgXjueTi8y/vq1rxhKqCd4IfGZSLZampheGozqU+9ZhxaLXjpQVbM8QV4AJtc1GHiO10YeNO113cZb6PjGnN26hNZ1biWLP77wMXwW+HrGMJwidXFz+ttV/zrK/9447y3CbFpM7kA/bNkyB7uqWLuehcC/GLF50l7nZIB06Gj4FZUbXbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCs0M9rk8k6k/DxT43TlLpX1uPBuYzBxEODsifdc4ko=;
 b=pJEoGGfTnt1skdHZc1RQ8ZrXHQYgqJJVleKBfkMwICLLDqiexejyhnKKlQQyjxataPSiqX+1JrOwKgmqripSE7a638InaxPygu+yQ9NnzgQHwMRoox4ByIosNbbDLwSDtPFf1xpDR8c1b41MVzGp24khDA5gk6AWthzDJERf1MqPypjpqgUc7flUYjY1uQNk19R/gQ+YF/npKVM7vNZP6pfbiyqkxIylKaLBMVnt6t80lMQcyIlrdm/XDLqgWeUW2VeMaDBPF14i/pHbfyyY5yep/jZcB+9l9S3uGVtbKLSGogIZpsjwfNZVoCPXG2cPzaM4F037HWYaX7LO2ro8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCs0M9rk8k6k/DxT43TlLpX1uPBuYzBxEODsifdc4ko=;
 b=0qIA0Sq6JlVrRXnsKZuARqXRxq0wbYPo+QL597Nfiryd0bNMW1T1cMsonUIHzlPcYFoEotsP1M8fRgQ6CuRWcDFNE8yqermK9hyexULadZOwd5+T8+FnZj/81b3/wIgVeKb2yjfBdYKMDbf1J6Wiw+GS+SGLwRu2jVVHHZXMfeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Thu, 4 Dec
 2025 22:51:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 22:51:24 +0000
Message-ID: <fec99fdd-a8b5-4c48-a835-31ac604f3755@amd.com>
Date: Thu, 4 Dec 2025 17:51:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-4-Philip.Yang@amd.com>
 <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 977f8251-fc6e-4716-1766-08de3387a6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akVEMUFtbnJqZmpyVkxSSlMrZHVCSngyUHZwRmNOZll4VHlGaFVUbHArRGxV?=
 =?utf-8?B?Z1I1RnVjR0h3RU01OVB1ZzdJdlF6eWszZnRtaCsrYVR6eGd2NzlncVVZRVJ0?=
 =?utf-8?B?R3o0OURpUU5qbkNtQ3NNL29uZVliS2hhNDc3Q1NBSU9xeTE0RVFNL0QvR3ZQ?=
 =?utf-8?B?U0Rqa1E1M2pkNE9kZ0Q2K0ZQSWtlNWc0Umw3ZFA2MWVuVmZhSDBxejF0Mnlo?=
 =?utf-8?B?em13YlFTNnA0OW1PdHQ3aEhQOS9idUo5bjlLa1d4STd2UTNxYUhtamNvUFNj?=
 =?utf-8?B?SVZyMjFjQXVuUThnb2NGSURyTFRNdytMbFkzMzNnTkhvWTh1ZlRPYldJcVNq?=
 =?utf-8?B?TWFNZ2ExcXdXY0tLUU1NbnhxU1lORGdmbzdMcng0aE1lYnVmazI4SEZIOFBh?=
 =?utf-8?B?MnpUUFhFb29tVHM2UW1XNUNmTEVPUVNFdGNFcDhuaDFrWDNma2o3UFBKZ0ZD?=
 =?utf-8?B?dUp0dEdGT2dLVzZ2M2NPUzNPSk04RUF5b3g5bXpZbXd6MjlQS1h1SWhlRkc3?=
 =?utf-8?B?TCt4cDNlcyt5ZU00YTlJVFhJSkl1VU9TeXdCaktQVnNFNmFqcUNFUGVlWmo0?=
 =?utf-8?B?dXJDTTZKWlBPaS8zQnBNa21zQnJkV3lka3krV2tXNll1QkdyQjVlQU1zeEJi?=
 =?utf-8?B?TVNsNGc3ci8yNG14eTBoWis1RUNpZWE2UytwS3lOYlZJTWpUVXdFSk5UYmlC?=
 =?utf-8?B?MzRVSjlvR09rUlVsWlpORGUwM25IUkJ2U2JyRitjR1VJTmtUR2o1YVBKZkNL?=
 =?utf-8?B?Rmx6SXVyUFRRNVdpYys1UmpZZ1VBZklhTXVZSlM1SVRPLzZxRWRuMVF5YXJM?=
 =?utf-8?B?QmNGVUFZNnhZMWlGUFRtb0lvNitXeXVjZGdyNEpaTUdzT2l5QmlNcGpJTDk4?=
 =?utf-8?B?WlllQWtvWVErenFxbE9lVzN4RTlPMHVLN1hMb3BoL29QOEgxUDk2SnBlVEsr?=
 =?utf-8?B?VjRWLzVBRytXSkJxRVFPSlVuMDBQU1JadGFNTjVjdTBjakpsUEticDlVV01a?=
 =?utf-8?B?SkQxd3NVRzRQMFd6M1BoNUp1M2d2NW0zWUtMU1lXbzFROVhOTDRqVk5XSXk1?=
 =?utf-8?B?UHVrdlByZGlvSGp6ZkJTODFkdGUwTlk0Q1ZCeE5Ec3psSEVSbUZWeXBJSG0w?=
 =?utf-8?B?WFc2WG92U3hHR2FPVmpnUFgzTlkwQ3k2Nk1GMDc0WmNWY01ZYm11WlRmZklK?=
 =?utf-8?B?dDRkVXhhTDNlbUV6ZURPMUFJWEJ3TkpvckRHTXh2K0g5TzNuMG45T2R0QjRi?=
 =?utf-8?B?Wlphd1VrUUZzQkVHWm5uYS9wd3JZc2NGTDlvSlNTa292WUoyMFBpRE00MWpk?=
 =?utf-8?B?MEFrcUk3czdEMHBid0tNWjA5bTVISEFva3E0Yk5ITEtIMUhvV01IR3BZQ3Rh?=
 =?utf-8?B?QWZOcmFaOU1nV0lmVkg2RjJZYlUvdFlaMml6c3ZwOUFYSlV1RFV0QXVhd0lv?=
 =?utf-8?B?WFB3VlRFZW1MVWE1ZTRyb3pXZVdsM0hsYmx4K3FrY3B6U0NySVhNM3VKWmJn?=
 =?utf-8?B?V0ZXYURkeTlSOUhwME1SU3ZrRUFpNFV1Q0V0cjFPZ1pqNE9NOTJrQjFLUFdZ?=
 =?utf-8?B?ekVNemVQY2dsN3VjTzZQekpKUmwzQlY1MFB1Y0QrTTZpdWkzcE5TMlo4Ry9S?=
 =?utf-8?B?UjNBdnBVTFFtWHVSdFdISFJlZEpKdjdzS0hETDJDcjBQcmw5YVdhU09FK2dQ?=
 =?utf-8?B?L0NwM0Fva3dlQTFFbkNHclhHY015a0x2WXFMeEVqcEZGazVFUVdsRmU2dHgr?=
 =?utf-8?B?Qk1aVmJqTTAvZ0ZuMmZFUmRkNHkrZXU3eWl1V2x1QVc0ZnBZQ2F1bCtSYi9H?=
 =?utf-8?B?bm9PNnVQcFg2b0hQZjlEdXJUa0YxMWs5cGdRVTVWVEJoU29uTndHRlZNWUZS?=
 =?utf-8?B?OFJOcFp3c1ZFeU9zdmwyaG1wbUQ3L09CZ1h3TUJIWFg1NmFjaXliK3ZtajRN?=
 =?utf-8?Q?/ndBY9ujzU+zmgHUkPQ6QzA+TP3dVITZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdCd0laVURmdTJ3TjlNbFhmeWxZUGVLR3o0bFhrUEJueEVXYjZKME5RNEMv?=
 =?utf-8?B?K0RWcGM1OEF6UzBNWWpMM1UvVDhUZHA5Y1BvdE9GaURFaFh3cmNYbVo4UHdL?=
 =?utf-8?B?YW54dE5ZRXlnTWU4eVNsNUF1NkpkVE0yRXZhRDVCTjVRMkRGU1Y5VTRxblRn?=
 =?utf-8?B?c2FOSThVQzlMUkxYbEE4azd1SzdOaVNJWlVSYW5PVFd4RmlTdEEwQUNjYzFE?=
 =?utf-8?B?RmdKRHlMdmREOW9KaU5raURMem9SWmUwZ0dUaUM2aVJyMUZBOS9YNGNFcTh3?=
 =?utf-8?B?RTBWeXlFbDdGd25BY21BYzQwbHJ1ODZuSHRqVTJ2eXhoK045V3VsODgrQ3pp?=
 =?utf-8?B?T2lDa1ArRVVLSlEwaklXU2UyWmhQZ0F6MHhlTjl0VDIvRlA0MUJqSTQ2akdi?=
 =?utf-8?B?Z05YQmJJQ1VXQWRtT1VhYVMrR21UV2h6TGpRWXN3V3N0cXF6WURaTStBOUFN?=
 =?utf-8?B?dmk0bWNjLzY2b2RJUk1XOGMxYTBkV3NGYUxpbXc4ZlZwNlVIVDNUeFUwbTJu?=
 =?utf-8?B?emNrb0lRd2NLaFdkSnZVQ0FTdWIzbTEyOW5XY3VXcVZkdDllTmJ6dm1QMS9i?=
 =?utf-8?B?dm1zL1BIMzVVc2M4bVFLeHNFSDVabFJTUFZYSUZoOTFTdlB1TFNyRVFVVHls?=
 =?utf-8?B?TjVjU3dxaE9GSXZPZUovTWgyZ0NiTUdqQzR2QTE3Uld0UHV4R3VDSFB0cWlQ?=
 =?utf-8?B?TlZqUEhZSkw4WENVSW10WUE1S3BETjlGdVFKT0tjY29BVE1DOUtMMEh1bVQz?=
 =?utf-8?B?NzVUaG5hM2RSSWtCNUxvT1V6d1VuWnNaMDlLQ1Z0UWVDV3NnNVlsYkdLWjdu?=
 =?utf-8?B?bHRSK2pIVk92RU5uakFtamoyVld2ZXVIZ2t2Rm84S21zSlNCRG5JT2VXamI4?=
 =?utf-8?B?R3J6N2pma2J4K1RLUk5xbEtDZk9IMEd1TWJqaVQzVGsra25BYmpXZVNqOVlZ?=
 =?utf-8?B?MGJwdVZZRmxMaVBxSldQQWN0Ykx0aFVXcTlOVDlSbmlzemNDMWhKODJqeit6?=
 =?utf-8?B?eXloT3MzMlJZRUZoSFozZllMNmw1QXlkK2tpS3UvNDJyczAzTEdtM1VaTXNj?=
 =?utf-8?B?RWI1a1R2VjI3TDRIM0cvcWxIZTRaTGk1Umc4alQ3aXVHcDhQL2tpVGFhUHov?=
 =?utf-8?B?TjZSK3FVZVV6OTVDRDNJdnl4QVdmanJMRDFUblRXVHA1NmtxVEtLazJnSStQ?=
 =?utf-8?B?REFmamhFMnB1SHNEckRhTVlLMjNJT0R0WjRhcmdvZkFSSkNSQXZ3YXJtcFNy?=
 =?utf-8?B?eXc4L2prZW5iTVFoa20zbHZKcnFWUngwMStKZWdnNWRmSngxNXV3R1R2OTBm?=
 =?utf-8?B?VTV4TWR0YlVIZksyS0RqU2kzVmlqdDVvVFdWNVFmelJMTHdkY3pSY0Z1SDl5?=
 =?utf-8?B?ZXhwMHM3eXdHSkRLNWRYR0JST3pKQWx6Tm5qazNkR2J6VDdGbDBRdFdqVlZP?=
 =?utf-8?B?cVZFZFJBTmx0NkRYTmF2M3BFeTU3cUVOdGRwL1RYSkxFWXhNWnlBb1M4Zk1j?=
 =?utf-8?B?ZndnSXlibkJFajRUSy9PQlNuNUsydDdmYVJCdGNCTUE1UVdreHZsSVJpZ3BJ?=
 =?utf-8?B?eDZJNEdiWXQvT21YclRGNjM4dFI5Y25zM1NVaEFIY0hBemhJbmpZUFdEYnZl?=
 =?utf-8?B?bElTenpuUnlYdm96a0RGcloyZnhjdmJ2WEhhUzlTZU9ua2dtRENSaExCRVd2?=
 =?utf-8?B?UTI1VVl5WEcvZk9hNlVTRkNyWDlRZG1QYlJqTVRyY1FBQ25QN0Y3VDFQMGVk?=
 =?utf-8?B?WDdNcVhpRldFWW5ib0pnZGJ2Z0oxT1BySExGRG9adHBMMW9NazhWdVVVMjYr?=
 =?utf-8?B?cGw4R0g0UElMNGFuenhZRU1LeXR1YlBSV0t2MHpwS3dyOWJHUWVHM2ZEVmNP?=
 =?utf-8?B?WDNJUkltVmZuTDUzV2s2NkFsOFgybytrUTV3VWRnTzBTR284TFl1TE1oOVFo?=
 =?utf-8?B?K25pMTdCRWxaVkJTdHhONXNlOGlyOWdMNzVJMGRtbStEaDF6VklZQi8vMG9O?=
 =?utf-8?B?RWs1aWpLRjUyWHdtdmVpUDNEb1MwOHlEdHV2dktURVlqdUtLWTZSMGhZR3J0?=
 =?utf-8?B?V3JQVDhmTHQvQlJONEZvb3ViSktDNlVwNXRIMnFhZzE3ak1VRlpzM1VkVWJV?=
 =?utf-8?Q?yRoI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f8251-fc6e-4716-1766-08de3387a6bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 22:51:24.5603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbAusQr/r2wYeFF7iLOEhhIeFuH7oqt9g9XHUY+oo3rrRsNHthcFRca6SNJdn0Z1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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



On 2025-12-03 12:55, Kuehling, Felix wrote:
> On 2025-12-01 09:28, Philip Yang wrote:
>> To reduce queue switch latency further, move MQD to VRAM domain, add
>> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages
>> using one buddy block.
>
> Why does it need to be contiguous? In the next patch you're mapping it 
> in the GART anyway.
Without AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag, amdgpu_bo_gpu_offset 
trigger this warning

     WARN_ON_ONCE(bo->tbo.resource->mem_type == TTM_PL_VRAM &&
              !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));

This makes senses because we pass the FB aperture address to CP, this 
should be contiguous pages.

Regards,
Philip
>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 9cd1660b8f60..c11e37915365 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct 
>> amdgpu_device *adev, size_t size,
>>       bp.size = size;
>>       bp.byte_align = PAGE_SIZE;
>>       bp.domain = domain;
>> -    bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>> +    bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>> +           AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>       bp.type = ttm_bo_type_kernel;
>>       bp.resv = NULL;
>>       bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index a489d43d5f64..c6945c842267 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>> kfd_node *node,
>>               (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>               ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>               NUM_XCC(node->xcc_mask),
>> -            AMDGPU_GEM_DOMAIN_GTT,
>> +            AMDGPU_GEM_DOMAIN_VRAM,
>>               &(mqd_mem_obj->gtt_mem),
>>               &(mqd_mem_obj->gpu_addr),
>>               (void *)&(mqd_mem_obj->cpu_ptr), true);

