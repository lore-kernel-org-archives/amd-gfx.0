Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C65C47DA9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 22:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9607010EA75;
	Mon, 29 Jan 2024 22:21:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECCF10EA75
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 22:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN5San7Bxg+XcOzmSsiOtULjTd6rLhZGxJVCAEBAydQ2gcPlGBJ7K+dOlm2jN4YJq4xHulKkefRcgOqtbJ2+eoJrUQa84fyaE2r3K09V70Vl+tBG3Yka1a35TeDWjaggsDHU1hasQ1uHv+ZJ53GH5sg/IfQpkvCryz670+247lAmjolSs6bvvTjLht/BTJDl1Sj2XXNAqE0mks6kisr4q6FvLfg2OJK4ys6s5+/I/3Eogk/nZIW3jFnVJtinBLE5tH/0EWTWvLr/Sds1QCegZFAopxWydL6zM8C0jx0KqbGgJdxqpyDBQRlPygS0vJ2jN0vR/p4RC2iOjPWUhmJVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9csHE/XaBIixucqP6LJx1p718thlh5MHujThOpgUqCM=;
 b=FPuOvnhcY6cz1uzqEglfnluAH/1ymNyJNDTgLngdeBCarLfHUCyNcro0Kxwx+bEq4F7qZmXE09lxFnQdD+Sir+YhI7HPo566SOaBVsoWWUwaes8KmjANdZ5ZFGUKxR44oANWj3NyyFKu1oSNfEl3t7pWXi++MZPIku4VA1/1XrYXZ7omhE5DdrSRzl9de1gVkWUE3kLpW0UyWJqCRhR/OJtM33ZFE3y28pAfl8toZwEI7te/oZdhKmNq5zkbq9FHnNFEMDu47Bl7O/mcIImwwdSd2eUGtIAns1g5gAuSqKZe6Z1n/GPTXixyOVYyTWNEXXQgyza0t6iHcr6CD4Uzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9csHE/XaBIixucqP6LJx1p718thlh5MHujThOpgUqCM=;
 b=AzmGa/y4ybLa+QWzg4lNvEi3ZjldAfUq6Q9bBAVQa3DPw+B03XGPw84gUg2RqengE+unlO0tMLdS3r8oZRg45l9W/0i2EATxd3hqoRMCTmmNflVl+m2WR6v0wMDOxnFi3gmGEnBnLO/X++/IGLw4k3vLvFfl2XMLnoEHW6fW+qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 22:21:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:21:25 +0000
Message-ID: <7f2b58c7-0b9b-411a-a9d5-978ed059d1f4@amd.com>
Date: Mon, 29 Jan 2024 16:21:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amd: Don't init MEC2 firmware when it fails to
 load
Content-Language: en-US
To: David McFarland <corngood@gmail.com>
References: <8bda643f-314d-4947-83a4-8ad536dfdc41@amd.com>
 <20240129221817.8797-2-corngood@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240129221817.8797-2-corngood@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:6e::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6e0e6b-fc55-42d8-26a9-08dc2118a162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAu1m0pogIwr4w3EzmlFCgS4flBaBRLU0qJKqNnJdkjSgSjgIkiTSgZjH6ezSAO866VLJ+5c4dQqscCejtkoKu2beDOqKPLARLrFNq8PX86nat/9YbndKf1jCmlpiL13dl0pbG5LFWc27wFLuI2hriPog0+17lZYkfgCmT2Zhc2PhJDoF82RSSPGHax6rf4fqw7qmEC2gSWg7XMQHAr6Gns9foo5K6WSS9PXoZ/ujxBtGEZY0aiINUYFj1EAH405mTCfRqmd/WwKIjg9Q9PxZPLbJfAqlw+R3cmPtU9GlQoaAwdJOMUXp+WvNEoPSvSvEJo2ESsdpjIsTdWNV+M9NP0CFlmTF8qCDCtVTqKwMfxhcICEW5gadSv4j4TA6+Mo5VBfK7A1OFRohxNfhKk4unYx1PrQlZYAUnkqWTFvbylufEPsJcIDV55Bh4CZ3K1U9qLeZ8LZU1+V0q1Q7H+5ARs0NdNJAnCZ/GeDZgv9AyB8FzCsEu52FXvZklTNPDyfTYaZ5lQXwllguFX22WQRyQi5SDdjWhRzps9uPqMYzKH5uhPUjewLdnpg15s90hMRB10xJon2nkPuhtZxIJfdM5h9XHPKS/Q8QykWxAxNnSLcYH3hFUt2jy0aXIOTDZ5cbb6OCmIONwoRC3jaMTTGdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(5660300002)(36756003)(86362001)(66946007)(66556008)(66476007)(6916009)(316002)(31696002)(83380400001)(478600001)(6486002)(53546011)(26005)(2616005)(44832011)(6512007)(8936002)(8676002)(6506007)(4326008)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NMZE96STY5WitDU3VhUk9KSWMrTTg5dWdUbk5sYTdGNWtkbGxuKzBBT01Q?=
 =?utf-8?B?QTU1Sk1XUXdFcHJkWnJLeVc0dVRaNXNiLzduSFNoeSthNnFheTFYQ1FIZEQy?=
 =?utf-8?B?TWw2cjVvbW5IaVlBUDJyMis2RkQyblpDOERKdkRMZzlvWDk1QldhZzVRcTN2?=
 =?utf-8?B?cjhVWmVZN2k1dVQrdHBOYVpBUWdQdGlvODYrNFRzNjBOOXRMVTZkSG9oTXRi?=
 =?utf-8?B?Ty9hU3F2amdTRU9jaTlyb0M3eVBLNWQ2VUNLTUlKM0YzdjBNMFAvemJRZ3hi?=
 =?utf-8?B?NnhDSUJ3a2F6SURpVC9xaDVMR3Z0eVJISnpvTko3bkR6WitzRDRPSnc0K3Qz?=
 =?utf-8?B?bEZwL3o1ZXZIcWE3RFBEaU1uQVl1RVJQSks4SmRnSXBDMUhRRGJnWTgzU01F?=
 =?utf-8?B?d3NGVms0RHU1d2Robzdud2dUVHFzU01PaXdDL0NXbGlFY1ZlSU91bGlYb3Zn?=
 =?utf-8?B?WWlOMFdHVkFQK05FdmJQRlJMMzJzZUpKMEV5b04wRDBMU2x3N0tuRzFoUU5t?=
 =?utf-8?B?aDl2RVNlRnc4STdJakRLbW9NaHJaMzk4V3JWNldrbG1tQ1pJcG45eWpLSGxi?=
 =?utf-8?B?TDJwRzM5WlJhbHMySWJ4RGYzN0t6OUlqOWtaSnpYZlczWHNRbGdZMms3d1do?=
 =?utf-8?B?OHR5YXBmUmo3b1FnckplYjJwTU5iVVN0akkvNm1Na2YvMDFFZ1NnQUQveWpH?=
 =?utf-8?B?dnRIL0pieUE0dmpKczdMaDgybDhGb1ZLSmVtdW5UeHVyK01KL3dFOG1HMVRE?=
 =?utf-8?B?WVUvQktFRklOOWk0N3pMeEdGSFlsS2crQmxZYlJiTStyMVozYnpRQllGcXNz?=
 =?utf-8?B?TWtkaldwS1ZMVFIxQysxZ3dvTkpSR1NQNEl1OGtLb3ZTbng0ME55ck93VWNF?=
 =?utf-8?B?NlJHQ1FHK25LWm1YU0JmczY0K24xb3k5ZDdSeFY4SHFHbVBOdjZOQkhhekZ3?=
 =?utf-8?B?VVVzMmRIL3pqQVJZcEg2ZlNES2NIajhmek5EVnFHUXdPVjA4U1VhQ0g5K1gr?=
 =?utf-8?B?VUtnWWdiT2Vpbm5IVER3NVBHMHQxR0xacnMvbGZDNkhlK3daMXhVUXFFeEwr?=
 =?utf-8?B?ZFNNNWh3aEUybktyTGJlRGFMVytjSVNaUXUrRWlDYWxJLy93Y0FsZnVkWTJL?=
 =?utf-8?B?MXdOcjZoL2ZzZzl1SXhvTVRSVGxaa1VIcE90bUIwVXh5SFprWEgyMWlma2hi?=
 =?utf-8?B?ZG9uV2NDcVRGUXB3Y2laSSswWEdrZ1JTVHJpQW45SVVkS2VKUitmRUxySFFy?=
 =?utf-8?B?L1BFZ2RYN21yT0lhRWR0OTl0aTY4dUdId0NwRTV5VTduSElNNmRCL1RWbElG?=
 =?utf-8?B?OXg2bXpxR0F6RFVSOFhTSDV5MHdaR2UrRHZNR0YrUU8zYkZFTDI1TUlqRG5h?=
 =?utf-8?B?Y29MakJwREtZTjgvdmR1Nmt6TXNHcitYK0Nnb0lXSGdIUWhEZC9yUU5weWxS?=
 =?utf-8?B?WWo5cmIvQ1QvZEVkQlkxMWJlZVl0WnUzQkpzVHN3andEVnFNQytaOUJ3REto?=
 =?utf-8?B?Uy9ZVEF4OTQxNzVuNnBoZ1ZxaXY5N3JlWFh0YWxFR2pvSUhuTjc0TnI1K1Zr?=
 =?utf-8?B?WWVRWmVhQTQzbWVBYW5UaENnS013bzBJUmNxazRlUU05S0hFZy94ZE1CQTVa?=
 =?utf-8?B?SXk0SnNkeWRvRVZDb0dxTlRiRUljZ1phRmMxN21lTm1kdXJpZ09RZ2hxVGp3?=
 =?utf-8?B?ajRlZldickpZZ2FmdjAwZ1FUcGlMVHRRSnlQUmZla2c4SVhFeUxXMGN0WFJk?=
 =?utf-8?B?ODVUS0tKWUdhM3J0QllZQVFPODNybkxxaHBiQXkzU3pPL1d2WnNFNGR0RTg0?=
 =?utf-8?B?WUxCUHU4RUkwSjVVcTFUWTZGdFo4UlVwUTd3RVEzOEMydG9PbTNzRmcyVDFQ?=
 =?utf-8?B?cDB2Ulo3aU5FeWNHalQ3NHNlV0d3dmZyK2pMT3V6NlY0bjlrNnVjU3czZWhq?=
 =?utf-8?B?T04yVzdQekFVb1FKV25adk43QUsvQzVqc1N3aWJuN2FyL0VYMzhNWXNKUGRs?=
 =?utf-8?B?TzZ5ZEpKL1Q3ZjV3SVprM1htdUliODlKeTE5cG16aHFpWlVZRTJWSjRSRkZJ?=
 =?utf-8?B?VlM4cFZ6dzRCTTRpVERSajh1dTVodlBWbDdqcFdNMUExZG13ZGlYU3dDdDZW?=
 =?utf-8?Q?7iPizpYBWXVxQrD50bBFvIrXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6e0e6b-fc55-42d8-26a9-08dc2118a162
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:21:25.1562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjz5Ztiv/DAR9wxsgjtKsPHTqxifefsjaiU8IFygtniQ+7TbHWu5zRI8/oq1B6azhH06Q+Mz7850BC/QJZw/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
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

On 1/29/2024 16:18, David McFarland wrote:
> The same calls are made directly above, but conditional on the firmware
> loading and validating successfully.
> 
> Fixes: 9931b67690cf ("drm/amd: Load GFX10 microcode during early_init")
> Signed-off-by: David McFarland <corngood@gmail.com>
> ---
> v2: signed off
Thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

And I'll apply this now.

> 
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d63cab294883..b0ba68016a02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4027,8 +4027,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>   		err = 0;
>   		adev->gfx.mec2_fw = NULL;
>   	}
> -	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
> -	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
>   
>   	gfx_v10_0_check_fw_write_wait(adev);
>   out:

