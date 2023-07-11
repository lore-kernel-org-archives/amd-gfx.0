Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8F4EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E189410E41B;
	Tue, 11 Jul 2023 17:26:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CEE10E41A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 17:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/3TzcfzSSkvrnzErkPlNfmPnUq3nJhiiGO/97IXH1QbiEvUKed39kICi9EQRyIlDH4NO+BCt04FYkd868/jqNePdpgRO0v2xIvzSRRTVBabmAJfZrexrPP/Xgs7mkKpT05MbCQ0QVugOOzG/W6X3P2vJs0XTgmz6SKQy/q9fu2Yykuz+yAJRt9C0r92GeDlgZ2Pk1ULotedAD2foLmSGnF3uhGujyZzNFnfwvbCHy4EGiYSDLma1KjF3koIfFDuBHJUkU6wCX1uq2UZz0wZgf2nXP4GDkWI1a+KOl+XWSsLMAQvG2+vJ2CqieqUNKhFabixoxWs0ZfwVcsuYvE0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z1FBAacI/e8ui2NZLJlr3PMzmMdxDZgZnHxXIvhG5Y=;
 b=VJgKUeRcf1VcW7qJ3uH0yHXOP2SAHMYdQLmF2DI4dYOnqoEDvwdBzqhO6KIJthI29x9yDHJrjyU1NxFsMQMF4rmOXvx7WykLyNbYP/9d6OqWAYXwSqK4Agjog0O+LVZceOs1WAOsr6vW6Uk/Mc8zsFcwjcYiSsaL56da3pSNTGhly8I2AvGas0B2BJAS6Gf/J/gvrl7NXKm9iGXRoQ6T1BFaptYjZArGcswn8Rm1WGE4KWJx7h7rnvJ+vYesfv/s83TtgRMk/IT+gQflAqLCNL/O1xwAw10LS9zAXzo2t6ZqYfXbcX1R2hKM517R57W45LcfLnJmMtGRvKiqMFvbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z1FBAacI/e8ui2NZLJlr3PMzmMdxDZgZnHxXIvhG5Y=;
 b=uCMOYJo27GhCkQPh9RkscrlbjJPdF/7GJHXJo9McryLopNC2TD3Putjp5W5azANn0E5/vranH1ErDIJ9+R+AGTWTHcN05bgQjaI0KV2C1l6lTd3q9pItlgZUgAIVMzhJXdntOX8zvoF4a5spS6kFuso7VAR9X/M/UNRlyASmN3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Tue, 11 Jul 2023 17:26:14 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::68b9:3f7d:ca38:31ba]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::68b9:3f7d:ca38:31ba%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:26:14 +0000
Message-ID: <9ba47227-09d2-e7ad-3fce-2fe206eceb21@amd.com>
Date: Tue, 11 Jul 2023 13:26:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: enable/disable PSR feature at run time
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230711072837.41854-1-shirish.s@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230711072837.41854-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd445bc-c1a3-4721-c1c6-08db8233ed58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuK9SVevpiPi2CY5PmJNMchqbnJcLzft6pb0oCIdJ6XpI95a6trNdBBkxlf/3clbE4TnZuZu2+9EFDdPytMJsRsZlqC05+Cu0ILCC/LYtzfqAe6J8Xzf6UlLADGpXiCe/QHI2NXTWJRdixE8iGOW15KPEPfxS5rmcr9qRDztjiuzgjLLDfZ4YqaO3cxRKXUErG6/2y5ffeweJAbyY5CjQDFH7wqgdkdZMOOVUyrpjg5TRq+2Fx0uuBrEUJlwv3VNFJyUz45mi8HJfXQpq9pFrWXa7eL5P4IvGH4fcmxUYUYcJsUci80gRkqSS7sJXU+CoUcyDhtORr617NeSf9ORv6bKf/1kogBCtaDcX2+LzUWpDYAlIEJRPeTMprPP+g79zLbJv4oP1l+w+F9WXHKbRTuAF8tbLGpsQO6AeUD4AnJU86YTyXjqPKj5kkyjmbwzzEAtKVENQwoFgXKkBiRkxzdfjOO69NhplsSUOT3Bce91iNvnHMS7aCP2tuLvOSR8QcrrMLKxQe0K2TRZRsBA2/UFAUSlFWk1REjf6xkk27B/OKmhaQQD0CIRJ9cMKS8zEvVIorekL+7bVhXOWHRxrjZQ1eEbiWbsI2EKLgqdxMXi/uWKA/QTr9hqFp4ac3zsy5qPTeh809o9yS1treuPoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(6512007)(316002)(6666004)(6486002)(44832011)(4326008)(110136005)(38100700002)(478600001)(6636002)(36756003)(2906002)(66556008)(66476007)(66946007)(2616005)(83380400001)(186003)(5660300002)(8676002)(8936002)(31686004)(31696002)(41300700001)(86362001)(26005)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckg2TFFuZVk5V1pWU3MwOVFkcW9TbDdiYzV6b3NqV1JsaFFuRXhsZ3NnUFNX?=
 =?utf-8?B?bHgvZlZjV2ZoU1FsUTc4dExodGYrc2diUWtDZUtmNllhYkJHQTdVL1FUNXZp?=
 =?utf-8?B?bUJ1M2RNQXpZMjNJemw0QzdNckZDRmlaeEgrbXdSa2VIZVNrTitROFROUXow?=
 =?utf-8?B?UjN1NkpEa1RlbkpDV3E0R2FxTG91WG9vRHZ0YWJzREl2YVZZbVVZWFlTV0tj?=
 =?utf-8?B?NXVSelJxaXFPa0tYZE1hbE9zaW1rWmxxSVNsSVVUYU5ya3p4WHY5c1pFSWtu?=
 =?utf-8?B?T01lNHV3ZFZuSURWN3lRTkZ4WkhlMlhJNFZXaERGZWFTSEN6MzVWVFFQTUJi?=
 =?utf-8?B?TEY5aGVWUWphOWhVbzBueFlXQzBUekQ0OFhidU5WdlVJS3NzdEZWL2ZHOWZV?=
 =?utf-8?B?VVVQZjRGeWRIeUZsSHN2clMzWmMwci93ekp5cGlEeEF5N1pCK0lKc3duWHF3?=
 =?utf-8?B?ZnIydzh6Z0lyTlplY0E0WmtLR2duVmRZOXNTS3pMOHdUSHBIS2w3SGtzdUtS?=
 =?utf-8?B?ODAvY3hsSE1yN01SVnR1UFVxYjlEWHZQL2sxVXhzOC9LMmloSSszajB6VzFI?=
 =?utf-8?B?RHkyNzZPbWgzUWI3TE84VDB0c2FRdVNTR2syYTM3QzNiZVBwbXc4WDFQazZs?=
 =?utf-8?B?NmdhanQ2RFF5ZTBzTEc4MXA2MktONThiMkZhL1pZRUprbVMxVGFld09uaVR1?=
 =?utf-8?B?RE0zUmNJdGhvYjlvTy9RaU5YMDhWbzQ4RHhKRFZtMFZMVWdjOVA2YVNkdnEv?=
 =?utf-8?B?QlpRUlpaL1M0ZzhXNHJrdU5rVVIwajJOTGxxN2V6b2NKOEJKak42NG9qYkU3?=
 =?utf-8?B?NG1vZkE1S0hxcTN2NVBNV2MvUzN6Ynk2aDZWSnNGakxVVllBV3Q3ai8xWlE2?=
 =?utf-8?B?UHU0NXkzbytxNmIveVNkcy9JT0REZi80d0laNVhHKytKMUxOQTJFUllTZU9a?=
 =?utf-8?B?Z2dJN295dFRpWHFwZDJrMitCWWQ4ZjJnV0t6RHM4U3Y1bGtndFBDR3VibUZW?=
 =?utf-8?B?MjE5T0Vnb2NLeGFjak9nYU11ZFF1VjBycnFrVVpDNnl2TkdNWnN5S0Zlc1Zh?=
 =?utf-8?B?elo3eSttUG81ODM3eTVwYVc5bXY5RmtGVUYrRmpmUExFRTVPa1VKQ0l3U1FP?=
 =?utf-8?B?MGs3UWJGeHBMYzRMOWNsL2ZIV2ZaT3NzS2E5T2hhenZPN0dlZDhFNEJrTGp0?=
 =?utf-8?B?MVZ5R3ovc1RQeVFJTFJGb3NXV1BZS1habklObWQ1U000NGV5UEZUUzkrRFov?=
 =?utf-8?B?VXA2eWxEN01XbW5yVEtoVU5NOXBJa1cvMHBPYmEzaGlxdEpyR3EyNHg5T2xK?=
 =?utf-8?B?bDh6czhDc1BTaVBURml3eFpJdzFQSlAwdGNvSDJZZ2pnUWpyVnBUUmNqN3NF?=
 =?utf-8?B?NUVUUmVvR3QwZkVuZzZWVHNWdEdmR3pzQy9kbDM5UStvTXdPbG9PWUFuanlV?=
 =?utf-8?B?eUI1MjBhb3hQcTdzSWRCTnErMkwrV21tbklZdnRnT1E1NnE5bkNDd1diTlAr?=
 =?utf-8?B?dTNJUHBNYmY4cGI1b0ZRUGxSbGJTZ1I4UGtUT01EeDZQS0h6bWtySGQyMHpT?=
 =?utf-8?B?dWZNemQ5UFBFd1c4dW5Yc1RrLzYvWXByRmZOV2RWQVhwOGhxdDFFSTZoSktG?=
 =?utf-8?B?Q29paW5ocUpHZDNBYzRyQ0dyVHVyZmJuK3hGVkdlOUpKS3Z2L1ZnR0l1OEJz?=
 =?utf-8?B?MDMzK0FJYisrVlgrSGRKTW5nMjlJeUhoUTdxTVZsNkZDOTFHR29WWDFzKzZo?=
 =?utf-8?B?S05tcXluZGMrblpCZjl5Y0sySlRGcTZUWjRRbHpodjBVemxhQmR0cEpnRVNH?=
 =?utf-8?B?bTNEY3JGOEMwQWFRTXpMRUJZNjV2Mjdad1ExQTdyZ3lLYXU1UjBlTUtmRm9x?=
 =?utf-8?B?YTBEMStkM0Y1bEhPSjk2Yitrb2Jkcy9tcWVHNDZFazRLU3RMZXhoVGttS0gy?=
 =?utf-8?B?YzBIK01qTWN3LzErYVZaNW1KdkF4WXJ2ekFnRkMwcVFhVnljcDFmVVZSeVFF?=
 =?utf-8?B?UnJ2dFFUY2l6VmhxUlBZUVhmY3l2cEJPWTRlbU9PQy96R2E3dnZrbDA4RThw?=
 =?utf-8?B?Y1pwb1AxMXQ0QjBvMy80ck1scVNBZXlmTlRxSW42Z3Z0UTBHYUl1WHpQbjdO?=
 =?utf-8?Q?6EWlJqsRFkknAexnduuL6hKbV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd445bc-c1a3-4721-c1c6-08db8233ed58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:26:14.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjB+rSlZivxEfiTHeE0s9wTR8AhClsVTFS37UGc2q3TjK+HJ1AYpC7nyDVdiJpnsq/PsECZY9QcI8xponE5kZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 7/11/23 03:28, Shirish S wrote:
> [Why]
> Per current architecture, PSR feature is disabled by default for DCN < 3.

There were issues in the past with enabling PSR for < DCN3 ASICs. So,
unless we can prove those issues are gone I don't think this is advisable.

> This makes it impossible for those pre-flashed device users to try newer
> (psr capable) panels without altering OS (boot params).
> Also on Chromebooks its not sustainable to have custom dc_feature_mask.
> 
> [How]
> amdgpu_dm_set_psr_caps() in its current form does a decent job to evaluate
> and discard links that are not capable of PSR feature.
> If the current implementation has gap, going forward it needs to be
> addressed either by adding appropriate ways to detect and discard the
> panels or by iteratively blacklisting the same.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++-----------------
>   1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 073bf00c6fdc..0fcafe1a071d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4313,7 +4313,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	s32 primary_planes;
>   	enum dc_connection_type new_connection_type = dc_connection_none;
>   	const struct dc_plane_cap *plane;
> -	bool psr_feature_enabled = false;
>   	int max_overlay = dm->dc->caps.max_slave_planes;
>   
>   	dm->display_indexes_num = dm->dc->caps.max_streams;
> @@ -4405,24 +4404,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   			      adev->ip_versions[DCE_HWIP][0]);
>   	}
>   
> -	/* Determine whether to enable PSR support by default. */
> -	if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
> -		switch (adev->ip_versions[DCE_HWIP][0]) {
> -		case IP_VERSION(3, 1, 2):
> -		case IP_VERSION(3, 1, 3):
> -		case IP_VERSION(3, 1, 4):
> -		case IP_VERSION(3, 1, 5):
> -		case IP_VERSION(3, 1, 6):
> -		case IP_VERSION(3, 2, 0):
> -		case IP_VERSION(3, 2, 1):
> -			psr_feature_enabled = true;
> -			break;
> -		default:
> -			psr_feature_enabled = amdgpu_dc_feature_mask & DC_PSR_MASK;
> -			break;
> -		}
> -	}
> -
>   	/* loops over all connectors on the board */
>   	for (i = 0; i < link_cnt; i++) {
>   		struct dc_link *link = NULL;
> @@ -4471,8 +4452,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   				amdgpu_dm_update_connector_after_detect(aconnector);
>   				setup_backlight_device(dm, aconnector);
>   
> -				if (psr_feature_enabled)
> -					amdgpu_dm_set_psr_caps(link);
> +				/* Determine & Set PSR caps*/
> +				amdgpu_dm_set_psr_caps(link);
>   
>   				/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
>   				 * PSR is also supported.
-- 
Hamza

