Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD94EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 21:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E61112CC0;
	Fri, 10 Jun 2022 21:01:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D099F10EE58
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 21:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYkaqWzahwmCBTqCWYHg/usQPa7xftuwYy8sFLs/20P5q0ti2lua4jNiynGwapDv8whf7ybEUP2GSMr/wsxmQTz8f8lkPRLyXSaq+ynq0ALELiEmXwDfxkXr15Gj1Ubb6L/pWbs3XmEBIpDPrFUIFPr9rvpLsHUy0skEx6Ne0GZJJ0G2ACA4unqxmgOlo6RF3y3WsMc6yQjBn609apsFvWl8rwBNwb7kpkf0+sGYvh0b87DN/ykYz2PuEh3wtt2qMYhqpvo5ZdTK4fVLbKbUzGIS+NUU/GIV58nox17zpCrDZ8C+TVY58XhXQF87jDvlb1hETno4dOgVK3zO/zsIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dNnq1dYjheMPGi++YULvAmvyzD7kq12d5WMOqQTbBs=;
 b=NRFoYwTxrk14pNkw5ILBEy4kQoKVc/qOIjNUt0QeuM7tFr91DqoXxsfsvAbxfUl642saPU3kEzOqrRjZXiReb+ty2s7s1wn10I94oYbT5exOKii79MCCvj543CAU7+ez771XigQSY/nQKW07YdXnOYIHpDPOmGyoY032WdWAp884bvAPaBgtpAIYGjTHtX8Dx5GNTS9CeZoJMVbO4u9Fr10yMxFdryopCcb8MHTCTVb/eKD9q5dDrsLvpZCy9gJ3oBIKr8hf/szBp05GgRa5LLbOWkfQNz0ads0C5o9N/Irpg8Tc3GJt5aFOPTAYvyVXG0ykbu8PaGvyBKY/KwDqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dNnq1dYjheMPGi++YULvAmvyzD7kq12d5WMOqQTbBs=;
 b=4tmd4RcNCBlFx3RrOyA4UI77UlryhEZzTpPCNZmMjJO/ZJQbrUBTYtH2/Jd7mNzJjbjkSuipRhksFZatg/7WPd69HPNDUe3cgslBgB0u9OU9vnKKYyYf191aHNWbESk2ySbNZWP6rlNzkVlVjuW0REuYC4nAehYTi/knQiQQibU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1129.namprd12.prod.outlook.com (2603:10b6:3:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.18; Fri, 10 Jun 2022 21:01:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.015; Fri, 10 Jun 2022
 21:01:26 +0000
Message-ID: <32cdbb5a-abcb-aac6-5882-2a828a8a1773@amd.com>
Date: Fri, 10 Jun 2022 17:01:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdkfd: fix warning when CONFIG_HSA_AMD_P2P is not
 set
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220610154604.338282-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220610154604.338282-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea915d7-861e-447b-5356-08da4b2461f2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1129926D08E0D1AD9A0BAD6F92A69@DM5PR12MB1129.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzZcFYtYOyl6I7mwKZn8XAqG1HFLkvnKJGuJfB+OttwgSlwRktbUINXuMfZnqxGCBEYhbsi+/906jcSkeAfTXWNzVoQ7Ww6bTYvkmFl0HtRosbqWBWIHW9uDPgvDU7yTFtNE7MkMP81BEgBQDHdTruEAmmeFtEsc11uCcpa6Ktq0OLpMM2inycZubAKhOGV3+jNmyiWNmX3mu6lbHWCyDyngOCakqCKTSRXqFKpWl4hTkJ7JMvcC2fr21NA0acCqR+7bTiiFhE9VBDDcyFMJ0Sefld3LapzJPCRrW/KeWGx6VsaFD2hzyPsC/tfb8NTBXhbZ0qHJgpLl4zmV5d+1cTYpIT0trzIVfdLLCOhiK1r9BTxvQQBb5s70vUlNHVFXlijVnYQtoRPEEIS1O8O3kFmsWwR6MhjoXISy+F3p7TmjUU5Zs6/05iIJf/gdHxEGlArl2Zyf9YO8YyILO8btffKNSlCQjRKQw4QSSEfqSqpWIYghmkRDztjPKuPyS9SkVL6gEQ6vpg+jo/0Y+c+xQjPqQw9GGSLP7dCdoI84jPJHHHhN1g9EnnWjN2QV/eKRUp6RhJloh7TUEhDqBSjre5OgTPR5I4cQRO+JI86xopWDB2LnTPN3JjaRHuNquRjLDyqnbWXxd7KPb44+M9vBZI0m2dkWglyO9gB35VEm+kxv3V9nMcaKpADIlokQD6gS/aCyOLrcSHXu3wt3hZ6DJRs2nlxh4zXavgWi3wSJVj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(38100700002)(6486002)(5660300002)(83380400001)(2906002)(36756003)(508600001)(316002)(31686004)(186003)(6506007)(4326008)(8676002)(2616005)(26005)(86362001)(6512007)(8936002)(44832011)(66476007)(66946007)(66556008)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVEN3ZxeHRSZkJ2cldzT1pxNjNieDBoY0R3T2Z2SEZWUDVqUk9FQkdMMjFw?=
 =?utf-8?B?OTE3Z1lQT1lZTU5IbVljNGU1VW4wK04vYXV4R0xQamJzek82cVhwTy9Fd0dp?=
 =?utf-8?B?cmNNeitWUlVoRnc1RkZyM25VV1EzRUFHU0lXV2FlUXhBcXlWL2JOZldhQkVS?=
 =?utf-8?B?S3BZS1hlOU9EWVVuemNJVzRSSVYrcjZUNkZ4aTVYN3RYK3R4QmlYZUlMN3B4?=
 =?utf-8?B?bHp2aVNUdllwVWJ2bFZuem9FdnV1WWk2ZE1CSFhNS2E1TVhyT3UySjA3cGtQ?=
 =?utf-8?B?VGM2T09qU2ordVdJUzdWcGlsYWZCYncvNGRZaFNaMDZrRlpMRE9vbXEwYzJO?=
 =?utf-8?B?Tkdjd01xUi9jb1d3U2JvNExJR0hSUGdaWktEWlEvbGlCMGpVUS8wWVdERStI?=
 =?utf-8?B?bGVGUWdmcTJIUVZDUkdnb3NzTk0weWcyOXQxZXZHS1lKN2ZPOGtDME5aczRx?=
 =?utf-8?B?TDhUb3VjbExHRU56TEozdnVTWjFGTGw2eVhGOW9MWkZ3Z0wveWVSbDB0VCtH?=
 =?utf-8?B?V2RNREVkWXUyVXp2dFZjRzVMUTR4OC9IeExXZWRzdmU4YVpwbWVXa2RlMG9N?=
 =?utf-8?B?a0phOU01UTh2K2l3OWN1Y2ljSS9GcDZnaFVUb1VRUXlXTURRN1ovcksweWJq?=
 =?utf-8?B?ZURxeTR6RjlCRTNuNzVmNGluWk4vVnlLdWtRVDJIYjVHMG9YTjYxanZwWG9J?=
 =?utf-8?B?c25la3l5QmplWGh1MXp1dWp0OHMvR3Q4RWlpNmd0cG1Td0NFQjdkRkcvUTVp?=
 =?utf-8?B?SjVRT3FlVVE4dGxzdjRYOHhtUWU3YitTUDBuM21QOGRCTmdHL1pMSWw5OXND?=
 =?utf-8?B?SnhWemZQZStTUFNYSUlxd08yUWRzaGJlODRoUEFRcUNVS2pEYWNWdXZ6UUwx?=
 =?utf-8?B?dlpMOHNrbTFZZnJnWS9yTXorQnpwR3ZIUEVrdEFwUGFldHFpZXRySGJ6Q1pk?=
 =?utf-8?B?R2tPQk1kR2l4dTlaYWVBRlBwdHRGUkNBM1NIV3BiSXc0UmhqdVlEa3A2MXJE?=
 =?utf-8?B?R1FPeHhRbDFQeEdVN1ZWYmV5eHM2NG5jdlhRd1lsa1ZnK3drZXRXQy9XVTN2?=
 =?utf-8?B?bGhjRDFYWjQwNlp6Uis3RlVURnhnM1laeW5xNjI2ZHhwam9OYmI4dnVmZlF6?=
 =?utf-8?B?RitORnY1d0d4UjdhenF1emZwZkdQNjY0bEl0OGNWL1EwZnk5SEpZa2loZzBB?=
 =?utf-8?B?S3RwR2lxSTREdVBpTlhLVXEzSWxBTFFnMU1UZ3JhNFBQTVJWVGJxTHlOTjZl?=
 =?utf-8?B?aTB3TUNKalk4U1JoV1lFT093dTdnblVVV1NscDVaUTBTNzZsd04rYTB6c2gz?=
 =?utf-8?B?VnRWWTJPeXlVN3ZQK2xHdFE4SDc2aEJyVVBmWTVFZ0YyNHhzOXdTVkl6SEhT?=
 =?utf-8?B?UkRhWW8vM1JtWExjYkg4ekNaU0ZxRUhESVRjUkxPUG9CWEZxMWhzeHMzZGYz?=
 =?utf-8?B?UzBZVUx3TGViUGlYRHYvRlNPZ25JVGppZk00eEpjMlBmMDh1L1N1VDJsSVNH?=
 =?utf-8?B?dlE1d1FRL3VNUFpqMmtwaG4yZ1JCVDJjMFNscDRhSVg5OSs5Qm50dzFLR1lT?=
 =?utf-8?B?dk1PdjVvcmNEdExvRlU4R1pQbWxqQTBucms4YWpaQjBMcXBzaTlwVDVkSzBG?=
 =?utf-8?B?RlN1aGhsREpUb2hxU2tQZkIwbE5INzgvbkhGbHlaZit0RVRjTDBkYkVWVlFN?=
 =?utf-8?B?NXZMQXZjZDFscFppd3RoQXZaOFQvLzFZeXlRWUp3VXFLNW9EdksxUklLSjJH?=
 =?utf-8?B?S1NJWHVPZzFYTDFRZ3Q5bzhYUGRhQzlqUVlrSWFNT0IxTTlYYi85MThkeUp4?=
 =?utf-8?B?OGYwMy8vMFFlV0J4SnMwRnZBMCthSkdCWXRCYlRlMTM0VmdOQzZJMmI0WTBG?=
 =?utf-8?B?UWZWejZWdmtHM3VSMUU3NWdhL3NiVlRHaHkwUHNBdXBuSFBNejRJZGh2WnRY?=
 =?utf-8?B?ZEUvZnVoM0E0M3l1c01tSHBZajBZYWp6bFpHeGxZNTVBcHV2VTVyQkJIRDdm?=
 =?utf-8?B?Q2F4T2hLMVJxNys5STZCcG5TNDRsRWlSYlMyVFAzMU5wZHZWaUZzNUh2MmEr?=
 =?utf-8?B?cTAxc3JBSmVwQkFVRExkeGozOStaMzZOVjRENWlQbzM2NVBTbW5od2xiUVZ3?=
 =?utf-8?B?SXJwZjNSbEI5NXZ4TWh1d3BpL0tSOWp6enoyN2V4dWFYL3gySm9wa0tvYW5F?=
 =?utf-8?B?QmVsZ0c0ODVLWndKaGpsbTgxMTZscG8vOFU4TzBNTHl6dlpIZnhCMU94RVR5?=
 =?utf-8?B?NUozcmVJcTlXMWNtR3hBTHRGRGQ3Y2Eybm5pN2k4bE0zN0ZUQTFDamtrdFFy?=
 =?utf-8?B?MWxjeS82ZS9jb2hCa1krVDEwTW9ucW5zOEthTGRvY3ZxUkI1MCtJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea915d7-861e-447b-5356-08da4b2461f2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 21:01:26.1929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukHIlf+EwiEZw4iP/oBVyj2kAFAG6TWQ5iB3xdxjACB/pf48Q2r91aUgYtxlyZyIJy0Tm+3w+5065gCFg0yJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-10 um 11:46 schrieb Alex Deucher:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11:
> warning: variable 'i' set but not used [-Wunused-but-set-variable]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thank you for taking care of this.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3e240b22ec91..411447357196 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1539,7 +1539,10 @@ static int kfd_dev_create_p2p_links(void)
>   {
>   	struct kfd_topology_device *dev;
>   	struct kfd_topology_device *new_dev;
> -	uint32_t i, k;
> +#if defined(CONFIG_HSA_AMD_P2P)
> +	uint32_t i;
> +#endif
> +	uint32_t k;
>   	int ret = 0;
>   
>   	k = 0;
> @@ -1553,7 +1556,6 @@ static int kfd_dev_create_p2p_links(void)
>   		return 0;
>   
>   	k--;
> -	i = 0;
>   
>   	/* create in-direct links */
>   	ret = kfd_create_indirect_link_prop(new_dev, k);
> @@ -1562,6 +1564,7 @@ static int kfd_dev_create_p2p_links(void)
>   
>   	/* create p2p links */
>   #if defined(CONFIG_HSA_AMD_P2P)
> +	i = 0;
>   	list_for_each_entry(dev, &topology_device_list, list) {
>   		if (dev == new_dev)
>   			break;
