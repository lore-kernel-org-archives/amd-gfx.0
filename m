Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4F9C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 06:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AB710EA25;
	Wed, 15 Feb 2023 06:44:27 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F2710EA25
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 06:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD3+uk6lLZshnILKeQKdrovqyk9xDCKNlp6sUKfTkXN3JcvEP8zPnwA+YzN9yNKXOyLh8/FGIpE6t1iUZv6Jf5hcATQXYgUnmRpRaSRhoyyC4B2pxx+7fPwdcmSl3LgrMvNQkbMLLcxX2cBg7TyfuNcdlE+6vel+mo8Z2Ib+zAbv0J/i3iuEgVzE/aZ1FYVCLgCzE4sAhssYap5TNC53+Wiy6B8aKBuwwaCgEX2XW7ESOrpU9KBqs973wCuwxmGL7AG464Evtd/XxrLvFljZ4N1RY0hwhs+2Ebyzya42otmr6PrH86vZHG/cnGi2uax1yy4tPK2TPf/GEaeDOXIA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbduPS5eetpZuQUIvtphiTXwNSI/xXgZtfMqCWG3mDs=;
 b=GMIPwy//sEh80VxCskvLmiICEtOmupdRUqwgbavtaYbKCCrNIBN0m64fb+k1WT2dT1aFPVCN8dhvoC86pWRKF9+fpa1lW0xq8VNwp0O6+p6OeQJZRFbEOoupbNCblwF7Fz2lUPuWb8F2hLNfFC0pM99J8wBkCePS5EMMsyZDyaP4jo9yP6i6fQWpUjCdAU1cxqPtS9THk1whCQGOQBa77vVopAPWrs6pQHdBYfKB+SG8OXSRjOrtZOft7FBI2w2mLIQnrQ2nxWKZ02MGJjENXTc7IFsxH179WQHF85CLv/Wf5sBW86lxMi1S0zUpdaYe6WdFv7xOTREY5Hj/SlJlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbduPS5eetpZuQUIvtphiTXwNSI/xXgZtfMqCWG3mDs=;
 b=FMv44IMc/0p5aiuPYPHsgUujzul0CU8CXP826Mf96j/1pDN2IIsB5Oi4q1hiHzTdydVZPVudbBiuiyzSGs25kbGIga40KG/7OqGvBlW2a7uogzK8VDBm1frgbbYnqPm6hwYYbx7oxePa1bc3U9TfU+hvMAJMG4GFoNbyWPKZXv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 06:44:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 06:44:23 +0000
Message-ID: <644c8e5c-15b4-225d-7e4c-83a9552c9e25@amd.com>
Date: Wed, 15 Feb 2023 07:44:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: remove TOPDOWN flags when allocating VRAM in
 large bar system
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230215052548.2995968-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230215052548.2995968-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfc3ecc-d38a-4920-af7a-08db0f2012cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0PYP+i5T+vyo6kEmbyzPprpnY3nQZcbec6JVb/YMr3chx+PSU3lSzowe2EGo4/zANzAvKLJb8H+e1G9rTF/4PlMKDVahX+MX9WWs28nzyjGIJVp3UODUMg0FsuDSlY2/MQa/GXyx4uy/0Na3thIJx6srkM2aZgD4rycV7MEgX+Mc9RjrOhXmVQYh9waeJVtTLyqHqmmdH+qw9Wcrkbj78AVm4A6IHIGI+LE4JrLv6vROP1/rGYwo9lB+w1Z7GAPNQMBYXwnujUhKuADijLgZXOxwRuM9156F4yuekfOEftIaVP9ACTSbJEyAQchakvho/hbvmoswQvNYEyJaYsElyKq4vJt3vG3Tv/Un8TMgJX8e3G45O2wMWjoVdrzgCURZ5kE4wKey1iieG5Mgci3piUTvkS6OMpIr6JlbPMn7BmTKacIBNtxNAHqyKpnyMMuRZeJDjvTx7ogqwfCtU354UKf1J4PAHWvGyqEUPc03J+AcUEklUwLPGjkjZ9rad58fu6XasbJUP5ObuTCjrp414znMAxG59jr5bh6UPrHe68Mh2sGDQjS98TIYIYhqnpSkMJLDi/gypJ5c3qM8WZgfhc5C8B4GBQmQv9KF/Hy0tGGQwDrb+mc99fMstcYu+QILL84vBRT56YvCJbSkzPm/8hc9YmlfNc43b8YPnPWfgimkK1YmXniV9wE3zor0X4Y6M9sanJqXLK292BrOrpoCr1wkCCi68E4OYtbtPoUsOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(83380400001)(2906002)(8936002)(41300700001)(5660300002)(36756003)(4326008)(8676002)(66946007)(66476007)(66556008)(316002)(6486002)(478600001)(66574015)(2616005)(31696002)(6506007)(6666004)(6512007)(186003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVtV1Z6eUQwMTR3QzQ4WlJ2TnRoUGlUQm9DcklFWFdMOGZzZGdHU1NoMDVh?=
 =?utf-8?B?U1R1N2dIcXdhTmdRRHBWNE1iU0twZGdqMVQyc3JvbXM0WEtGWDhrOXhSRzd1?=
 =?utf-8?B?RGdvMnFxWUFZSFBiZ1dWUk85Rm5NRGpxNXBOOUFhNjJDUEdKN1dqZjVRQytC?=
 =?utf-8?B?bXR4bVA1ZXdCSWQ1eG4yZTcxSGN1SlJiU0o0bThiOXMwRDUxZlRNM3dsQjZo?=
 =?utf-8?B?NHFjK05ySEJIaDJiUThRbmovSUlid2tvZHNsZWphOGFvR2k2Y1JBTVoyWFNV?=
 =?utf-8?B?T0Q0Sm90VHFnQ2VuZDY4bElqd2p6bHNpYW9ocnpmSHVDUEZaUG80UGZXbUdW?=
 =?utf-8?B?OWN3MVMxUGJnZzlFVHIvaWNYZndkaVVMcEhMcFBVY2VmOFdZdUNrV3JyblJ5?=
 =?utf-8?B?eE93R2F0SU82RzlzM3RrUW5Tb3RkUDBySi9FWXlYZFUvaU5XbWdzSEhjTEp1?=
 =?utf-8?B?NWRWcU96SWJLVXNybHdIZ2dyN1EzeXpYOGZsMmNPY1dwNW9LY096YWltYVMr?=
 =?utf-8?B?aC9SVXV4WFRPcUJKOVBaN0w4UmhRcnpQNk5hRW5KL2JnbUFIaFFGL3grWjg4?=
 =?utf-8?B?K2daQVhBR2JBK1F1azFPMkNBUWkwamhLZUhkbjRraVpacDJXZExkcFc5ZlRP?=
 =?utf-8?B?SXR0VjlEMU5DaWR0OXd2MlVTblQ5Z2N3cVhVLy9DaHYvQ2xva0RqRGp4RlY2?=
 =?utf-8?B?emZWTzMzejJkR2FNWGRhaUNVaklnU1pBWmlGWVlFakZ2ZURXemFlZDhrYnE5?=
 =?utf-8?B?d3lRRnphWThLbStzQXVGWFFRR01zL1pRWE1NcnRnaTRJaVNoczdMdHA0TjYw?=
 =?utf-8?B?QkdsZHFNZjRiV29RUjVkUkZIR05aL1AvWEdxMEJ3bWpHMjJWQU9YLzFtQ25Q?=
 =?utf-8?B?bXlselR6ZTBwQlFSUk1jV1cyZXk1Z1JqczdMZkdtTXJQUTZQSkJDdnpqVjhv?=
 =?utf-8?B?VmRPa2tNQnVSa3laN1JXSkd5VXBJRVdFQzZmNG95bU9lUWwyM2dReDFpT0ZH?=
 =?utf-8?B?OStKM1JTRW5Banc4Y3JqTktseGRIK3d5OW9FV0xKVUtZbmUySmgrS29uanJ5?=
 =?utf-8?B?V1RQNU1oQjRpbzlNY1FZTllIZ01rSnlNdjgxMVJLUTFoMkVHNVB6ZnkydjlM?=
 =?utf-8?B?Z2NVUnNab0ZIbjNZOWFKOUZsMDdZaUhXRTJQL0ZEZUl1a0NRRkRlZUptNjlo?=
 =?utf-8?B?M0VaUGhqMU16M000M2hDWlh0Qlg1eno3VXZhRVVheENXd0thWDVSSWdJVlMx?=
 =?utf-8?B?M0dTMmRqeStKTmc0c2ZHeUZyc041WkJ0WWVVOVB3NXNRMkh5T0VGcmFLUEl4?=
 =?utf-8?B?WXJFdmRUb2IzSjVyQlNXc3FkM1lPUkFSR0ZsQjdaazB5N2xSZU1mNDZNU3Nw?=
 =?utf-8?B?WlVOaVliVnJ2U1RvMDhZUnZzL3N4amJ4MVZlcGtDM2M3bng3aitZekt0K2VL?=
 =?utf-8?B?dTZSQmUxMHFNU3V3WVl4MG1iZ1pGRy83QjlkLzZuYXJTaVdXNE15WVFiMENq?=
 =?utf-8?B?K0NWUDU5TWpNMHR1YTUwUlBjL1ltVTRoQi9La3lmVFVUbzdITkRab3FhdXQw?=
 =?utf-8?B?M0dnQytFQlU1aWY5aDExVXRuOFlZbUxmbW1JemV3cnJwd1Q2WW03V2djYk1C?=
 =?utf-8?B?dWJ6R3RpNkR4UFBsdEdLRThxUmNOZklkRUxRM2JCK2xUUEdNQmlMdHFhdXdt?=
 =?utf-8?B?d1hQYTRmS1J1amJabWJVWFIra2hDQlowbmFhaVpScUJKNEJnQ3ByeGxGc0FX?=
 =?utf-8?B?N21lbjN2TDQ0bGtPOXJoQjg1U09MaGVSY25OWWtlako4b040d0VXdlhkdm9z?=
 =?utf-8?B?TnN4cU9pS2J3eWRNc21qbitUc3g3ajU4YkduNEJ2VHFieTFTQTArcXo1OUpF?=
 =?utf-8?B?bFEyc0k3alZhc2lSWVZndEJBM2R0alQ5ak5UTzloOU9zUmNlcFNaNHVPSWxK?=
 =?utf-8?B?YUxxNXIvTC9QMXBtei9TQnNEbUY4K0NaSFJ5Y2ZpQmtZb2tTM2lPZmVWbEl2?=
 =?utf-8?B?NXZPWE9sZlRsVE8rVytsakExdHFWMEFBMTF2bHltb1dNbGplVUdLVk80RCtT?=
 =?utf-8?B?WDdWN2ZoZWNBZHFLUnlyUVMvZ2VWd2dyUTRSalRiRzUvSHQ3UnRXTEhIb2VF?=
 =?utf-8?B?R0o3Lzk5YU5kNEloT3FNTURnb0x1TTVMandmbXE2Z0ZUelVPYnRuc1lJR1dR?=
 =?utf-8?Q?SRhpmFMVmwasbZYWlEwwE8/9ghoaekYqJSmlBctYYcqR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfc3ecc-d38a-4920-af7a-08db0f2012cf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 06:44:23.4371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g1ER49GthHpxRl60uusBwrgfNbbS/mDwcujKG0aIIyP0WL6N3Bef7QwlkzSMtWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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
Cc: aaron.liu@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.02.23 um 06:25 schrieb Shane Xiao:
> Since VRAM manager is changed from drm mm to drm buddy, the
> TOP_DOWN flag should not be set by default in the large bar system.
> Removing this flag helps improve drm buddy allactor efficiency and
> reduce the risk of splitting higher order block into lower order.
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2d237f3d3a2e..1c3e647400bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   
>   		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			places[c].lpfn = visible_pfn;
> -		else
> +		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
>   		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)

