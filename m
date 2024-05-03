Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B02CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 06:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C541410E73D;
	Fri,  3 May 2024 06:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="215z+kpT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8617510E73D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 06:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4mkyQQ17GeN4xfpyhtpuqk6AcJDBv9O7H5IpoZiLnuY/KBpyOJYf8mYh3Xp1MklvCRa34/3uMuZEREkT0Oq9ePDp8GvdG/oORN/fdjoQ3jqqWzdQzntr69wUov8K5pfNWchRSlYL0hjaaZCX+XPKEQ1wCqvbRzfSVIPEEHU5hxgqUyF1BjW4/oM43NlkWcKVidK5T5r+eYmAAu2w97nJyohaJ+nFdyJ2O2pcIklPz8kC275xm5xTm7r9CBAvRmFH+M4BfVIZeRmVU7sHeVTor1K8a5SvQtKHR/4EysKdrry1iMdKKxLHj5HeP1Qh4KxeU+sPah8eAk+izdL/FOs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQfNu4y7cnJ0hiQQaW5XEVqGG4/Kauebfcp1bmMM7H4=;
 b=TPv0PjxNbX+UaXRa2BtKQQ31Yk9WSwseeMnuE/4eXofEwUh4rxa/ABhocH72RqWHE8IavNh4rbi7rqYsmxziIck9htW2sq50KVSj9sb040oAlSQYTudApEBfhqVuWLV8sWBznwT7G7VDTWBzUi4rYChlzFdITcV9IQgyCVVhXQUNlUQ6QeP5gXnkmwi+uumfVleKMvgkCrw4RasqlKATI54VXDjzhzCbvU0KBnX4UE6N9sssY/dcC/4Shif/01un9v1dlSIusaqWLwarUuI/jRAWmxc1OaH58n0J8dAn20m1gvRuq4X63e2+1wndatrgp4VXIQahMdUaxMIMBCnhyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQfNu4y7cnJ0hiQQaW5XEVqGG4/Kauebfcp1bmMM7H4=;
 b=215z+kpTMVu8VbGVkj61OLsvgzKvty6yj1BcUyqp/E2ne9HRnyDC91coWfTR9lk2FVJFzNBVZtNasZOCOUw+iEeuFYaBcfuEtx5XGoIqcHjY+nrCzB9cIoE2rx2NFibX7hvIiPpNYRNCfMbnxo4gDtGW1OJQMmq+H2yzbyPyFds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 06:44:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:44:11 +0000
Message-ID: <cdc0d944-1c24-4b53-b654-0ca77b620ce1@amd.com>
Date: Fri, 3 May 2024 08:44:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/14] drm/amdgpu: add kernel config for gfx-userqueue
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
 <20240502163152.1382-15-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240502163152.1382-15-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0255.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a98c8fd-8eeb-4c47-1f47-08dc6b3c70e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlV3b0YwdVpJOXMvNVJTa1BEQXBhenJXTXZXSkFHcWU3d2UwaGZOK05OM3pX?=
 =?utf-8?B?eGtaN0paWkxKS29hc2Nhck1xYVZyOHFWVjFUYmtUQkFrOHRTbG9hUmlURHlF?=
 =?utf-8?B?enJYWFVSc2MrNVNIUEs4aVoxUmVHSXZQV0U4R0FxeUNndlJvbzdKMzZZLzhx?=
 =?utf-8?B?TkR3ZVo3UkwzTU94RW5UWG5sWDJzckN0aUNEdnJSeFo0VnVQdjNSNXlHUURG?=
 =?utf-8?B?Z3I5cGNaY3ByVXZBbm5mNFgzbDhQbU1QMWhLd2JUSVZTc3p1QkV4WnZXS1Qw?=
 =?utf-8?B?cnFnWWR4bG95RVBaMWtJTFB4OWZHbVBXYzVaSWY2bUpDQ0VKdnJmd1BxZzly?=
 =?utf-8?B?TXdCcFlpSUdlSXFBV29tekw1VFE3a0lzQnFoVnFVODJnZndLVkd6Y0hwc3FE?=
 =?utf-8?B?WDMyd2RmWW5Bc0NqeDVXS1FCS1NacUhIaVZBWHZNSHQvWDlzSDFhRm5Ob3NB?=
 =?utf-8?B?aVVhaERyUUdESlRCdzQ0YXZkWTdKUC9UbjA5RFJBbGw2aFFaQWhFNEt5M21i?=
 =?utf-8?B?eFg5cDNnbzFNTzNkdWpMTGhHL1l0NFcwOVdpdjBqN0tSMlVBaXV0RTJjQ0hn?=
 =?utf-8?B?dE1lQm9QaGdlbXRoWVRqZVJmbUpta28rOWY1UlRwaHZNTmwwQUxwM2FHOEIy?=
 =?utf-8?B?QjNCUFl6Vm5WVEJPUEV0bXdLSXJ2SktKUHA3RncxcldRaVNYNW9HS3R2ZDM2?=
 =?utf-8?B?M3RncU9PU3o5N0I5NlRwTmtsazRlMWlVVHc3clNlMk5yaXQrUm9HNWk4eGZC?=
 =?utf-8?B?ZmVGUDIybWZpcS9FOVVSRHVWVVJvQm1oOGpuL2ZCNjQxam53b3U3SFNlUnJO?=
 =?utf-8?B?T0RxQ0FSMU4xWXZDS1hQMVdtY0JYcGE3anV0RTVtVWV0cGZNYVJDTEcxTXFU?=
 =?utf-8?B?T2xDRWlMWU1JajZ2V1RMRVFtUm1WKzdkQzVGclZyb3ZqTTdZTzVLZ3loSnlm?=
 =?utf-8?B?OEF0RGZ4b0hwUDQ0aEdIM0hlZWh1aEdlU2dvN0pDRmJsS2k5SnJXMWtrSGc5?=
 =?utf-8?B?bVplZWVMRmxSQ1J3OXpqZ2lUTFRsNVVleGU1UWhPc240Z3JPeVJqYzVKUkRl?=
 =?utf-8?B?dFAzcXhwVmlndlQ2Mjg1WG02c3hxMjlZRVFCMnNhVGovSDRMVVMzZ0xNeG5F?=
 =?utf-8?B?UWkvaDhPYW5UQlJZcFk0SkpLemMwRXoxU3R1YmFTVDNCWW1HZ1d1V0dVbStK?=
 =?utf-8?B?L1lwV29iVjgyZlliMElRY1l0Sk8wKy8raGo3UURad2JONDZ3bk12Y2sybXRX?=
 =?utf-8?B?MG9PWU5kc3FEMWpBQmdaNC9vdmNkQ2tVNVNvWFZ2TUo3ZTJMM25UZkpXUC9r?=
 =?utf-8?B?WUQzS1orZDZwdXNMSkNHbElvd1hFZGdOWHE5KzE0UUxmeWZCRDNEWnRZaFBU?=
 =?utf-8?B?enAxTnpXc3gzNGtmTE9ON0dULzVwdldEa3BQUFo2Qm5RemtIcUtWWDZVQjky?=
 =?utf-8?B?clFUVFRjcnlNUkdKVnlUcCtGMFhPODA0VjM1azhuMmFPZ2hlTlkvdzhheFJw?=
 =?utf-8?B?QjExbytoOElvbUgzM21JbUFiOGhOTzhFTmNROHQ2M2ROWU0zeTd3L0NUSkFZ?=
 =?utf-8?B?Y3NNblQwMTNKWFhLMDdkRVN1SDRpOVFaNDN6MUhKNEQrUi9CcG5IYnVaejhY?=
 =?utf-8?B?Z0poL1FsM21RRnk5QUhKc0RydnJtV0swYTlRQW91WFVGYVZWODRNR1BEN1V2?=
 =?utf-8?B?UEkrMmtqNTJ6bHJGSElNK015M3Q5bFNRdStVdTlZU3FaWmFJdXhjeDdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNzc0RvTVd4RXZ0OTFXazd4eWhsUnJlUUxPWVpIdUVzams1b200R2NSR1Nx?=
 =?utf-8?B?OFNpMVk2YUsrQmpwZW1yS3F0R1VCZXU3UmN4S0d4cFgyTGlYdW9QaGFrU0xa?=
 =?utf-8?B?Nzd3V0xPLzNJOGxOVjVSMWJ3d2lFRFdTTHNLZFI1UU5sRnQ5WmdmL2sxUFVx?=
 =?utf-8?B?cm90SVJJSjk0RW9oTEJXR2dObFdnVDl6dlptRnJEc2lBQ1gvUDJtT1VmN0xa?=
 =?utf-8?B?MC9rNEkvVjNkWHJpZk5XYU1QT3luQlBsNWhwUG5EbXQ2bStRUXByaC9pQ3Np?=
 =?utf-8?B?a1VWSlNqY0RhNWo3SHJjV3lTWXRwek5qbGlpZ1lYMTlxazFTakE5eXVtNlFw?=
 =?utf-8?B?YkdJa1duK3VjM3dCWXVZREMvS0tjU0haZi8rRTB5OVBuaXYxNWJzM0FNU3RY?=
 =?utf-8?B?UlpHNTd3bkhldEoraWtRTlZXS1libEFLWmRBQkROcG9XSGRtdlB2V09mb2dO?=
 =?utf-8?B?NWtTQm1pNHBZYW9pdUh2bkQxcWZCWmZIQkc3cTFBTlhqU0pocVJOQ1NFaUgr?=
 =?utf-8?B?b01lUVVQc3FjYkhXM1RDRS8ydHJhWG56dVRwZTB2c0lNSzdDVEcxbW9uWGtq?=
 =?utf-8?B?UXdJbzZBdExJQUNxVmZFazRYTTNYeTJUcHdVeHBsUUsvUVJGVTQ2VkhlYVVB?=
 =?utf-8?B?OHEwUEoxOHF1TUV0dTlVODRCdVpOZmhsOEJYTHBaVnZpaUptVWd1dDZ2b25r?=
 =?utf-8?B?VFk2NlR2UzVlUUJJNmV2YlpoR1ljVTFVUEpFejJyQ055WTlmdndRaVJjbCt6?=
 =?utf-8?B?UFRmN2ZCK1l2OXJOdE1DT0FlQTVjUDdUSWhJRXNTZHVnN3IzczRkSW9lWWVP?=
 =?utf-8?B?N2dKS0RBY1pEbjBPdXFtU0NCcHNnK0d3a2hmd3VBMHhLZjVIcUNGdlVhQ3pr?=
 =?utf-8?B?Zy94b2NYSnpYRHgzT1VMejQ4bUxaSXM1REdmN2hsZnczWEFKUzJsYkhiZXB2?=
 =?utf-8?B?aWo2TDJvMXhVaWtPekwxRlkwSUVsM3pLN3g1YUdHUzk2OXlhZUlOM2tuakZn?=
 =?utf-8?B?TEl3My9zNzFMMFYrUUJ0ajc1VDdRT1lrc013b3B1YjFqN1FHNk80RXV2aklH?=
 =?utf-8?B?dXRpWHhYeFRDU1dQR1BjdThveDBCN1VQaGRlZ2s2dDJ6bENXZGw5ZkliaitD?=
 =?utf-8?B?WExEaWJ2VW1aTzJaVjMwUDl1cmVmdnJkS3FMRFJzSWhxYjdVeUt3MzNQVmkv?=
 =?utf-8?B?Y2ZQM1lCdHVCSWxEaURzek5OT0pnSjdVZi9XcEhEbjRseDExdW1sTkpyY0lj?=
 =?utf-8?B?Z0lHVE44NzFNci9iNGxnWWtydzgvbUZKTUZJREFCaFo3bkZLcUlSTkppd3ZT?=
 =?utf-8?B?VXRnTHkzT3hqSzNuQkxvNktlelZWNmo2K2F3a1ZJaEpTR0RXdVplYmphaytC?=
 =?utf-8?B?NFF3TEVNV0V1YXh4eFpsdVdnYUNobVoyOHByMHk2QTFhTkpEYnVpU1preTNr?=
 =?utf-8?B?cmNXYVJKeHhGMjB2djlVU2g0V3AvTFJYcmNKSTVVUXMrc2dnR01Hbzl6eUJi?=
 =?utf-8?B?cHovNjZSd3ViYUdpNjhzTytVZU8vV0hORTdFVGZLWlZtQW5JNUZvUmlkWW15?=
 =?utf-8?B?Y2k2clkwR1liWDdoN1JLZ3lpTlBkbWs4bW9mMGVsK21BU3BxZklHdnFOUDFa?=
 =?utf-8?B?VnkyUzN1UTZkZ3Vac0NQV0V1Zm5DZWh3UXcxZ0NuRkJya0RISjh0OGdyMndY?=
 =?utf-8?B?NWFIUDhTYzdWVEJSZGNZQW5ONnlrQlRIKzJNaFZiSDVBMWhaSzZReE9COEhE?=
 =?utf-8?B?TWNmcjNFQmhyckM0aHRvcUp3bkpBK1lUUVpGdDhMQnRKcGpxR253bTVFU0dO?=
 =?utf-8?B?cGMvODNHVGd3ZTdabEUwTlBRbDRzc0lPYmNSNERiMk5qeTZHQ3BBSzkxT1ht?=
 =?utf-8?B?ajNiajU2c3M5WDdyTVRwVWtqMXd2QjBPRXM0ZllzNjNCZ0JadmVRUTZjZmlQ?=
 =?utf-8?B?WGdZWVNFZXAvSHFvR0xiWDdhcDlpUGxQWW8wbjhVN3d0enU4TkhvbFNPbGF5?=
 =?utf-8?B?WkFBbnJwcDMyNzlNdDRNZmhWZXhJZFZJVGlIa25zYVhnMkN1NEJQOWV0Q0Jh?=
 =?utf-8?B?bWgzenhUUkduZHQxK3BZRDdsY0pjTGdITnBjMGlQMjhETmwzM0FsQ1Z4Q0wx?=
 =?utf-8?Q?C2wkH3ImkxmuIbAvm2SJBZH5B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98c8fd-8eeb-4c47-1f47-08dc6b3c70e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:44:11.8811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1ZOZWHiLdpLK2PSz8C/f2xDnchdUvhoqH92tJ8PekTeCutOoeDq7DglcxJZ7aLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

Am 02.05.24 um 18:31 schrieb Shashank Sharma:
> This patch:
> - adds a kernel config option "CONFIG_DRM_AMD_USERQ_GFX"
> - moves the usequeue initialization code for all IPs under
>    this flag
>
> so that the userqueue works only when the config is enabled.
>
> V9:  Introduce this patch
> V10: Call it CONFIG_DRM_AMDGPU_NAVI3X_USERQ instead of
>       CONFIG_DRM_AMDGPU_USERQ_GFX (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/Makefile    | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>   4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 22d88f8ef527..a7c85eeec756 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -80,6 +80,14 @@ config DRM_AMDGPU_WERROR
>   	  Add -Werror to the build flags for amdgpu.ko.
>   	  Only enable this if you are warning code for amdgpu.ko.
>   
> +config DRM_AMDGPU_NAVI3X_USERQ
> +	bool "Enable Navi 3x gfx usermode queues"

Yeah, you are right that we somehow need to distinct that from KFD user 
queues.

I think we should stick the name, but maybe mention here and in the 
helptext below that this is for user queues on the DRM render nodes.

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

> +	depends on DRM_AMDGPU
> +	default n
> +	help
> +	  Choose this option to enable usermode queue support for GFX/SDMA/Compute
> +          workload submission. This feature is supported on Navi 3X only.
> +
>   source "drivers/gpu/drm/amd/acp/Kconfig"
>   source "drivers/gpu/drm/amd/display/Kconfig"
>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 987fabb2b2c6..0a64f2c57def 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -189,9 +189,11 @@ amdgpu-y += \
>   	amdgpu_mes.o \
>   	mes_v10_1.o \
>   	mes_v11_0.o \
> -	mes_v11_0_userqueue.o \
>   	mes_v12_0.o
>   
> +# add GFX userqueue support
> +amdgpu-$(DRM_AMDGPU_NAVI3X_USERQ) += mes_v11_0_userqueue.o
> +
>   # add UVD block
>   amdgpu-y += \
>   	amdgpu_uvd.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 46304d09c4bd..5c4bf243ed04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1348,8 +1348,10 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_mec = 2;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +#ifdef DRM_AMDGPU_NAVI3X_USERQ
>   		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>   		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
> +#endif
>   		break;
>   	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 4):
> @@ -1361,8 +1363,10 @@ static int gfx_v11_0_sw_init(void *handle)
>   		adev->gfx.mec.num_mec = 1;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>   		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>   		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
> +#endif
>   		break;
>   	default:
>   		adev->gfx.me.num_me = 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 0989400d0afe..f6a2c2daa00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1274,7 +1274,10 @@ static int sdma_v6_0_sw_init(void *handle)
>   		return -EINVAL;
>   	}
>   
> +#ifdef DRM_AMDGPU_NAVI3X_USERQ
>   	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
> +#endif
> +
>   	return r;
>   }
>   

