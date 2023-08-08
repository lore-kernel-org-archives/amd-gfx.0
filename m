Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CD5C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 19:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F9710E11D;
	Tue,  8 Aug 2023 19:06:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C13710E11D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 19:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUgQ1F/mMfJKmjRptB/fCbNiibZGjv+tZ/JuTjkKZKsWKl/wIq1V1lLkNd64HQGKiKbAqz8cgSk28QIkEoPzpAzi6a7iZAon1shwEX/IOsV/dIkaXu9TJzmVCZRo5GBP3vAzCQWZxdecrJXyDN7NqN2FF0bf3yaAFoUOtgzoj0xIZT9ZNS26th1Ds47hf8Yzso+GksEcrYW+3R6AR+nVlzXsvXLDkflaE+dbAAphFDgul+hBFfgtyy2ciD6cOkDqg8KdAKhHoXDdwq5t99PhQcmMRyzalHWFXax0PWszCLEGnm6Htl8mqHiWeu06SxJugpx5kjEs3OXgM5U9/iKbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4OJEDWVi1CwJlItHu/e/JCi0ymALVy4bsUrfxePoUc=;
 b=dE6JIQ/1v/VaRuPUiqkKWNloYP7EdhiY2I2Wn+PIfJ2d/QmruvIQLJqO5u7qFPuqQFrQnJmDa8+IIwLRIl1vb5jpNhxMYnxZDt6e4gWLtYxEWE6HBxm87XuBWx08oYhVB1aJzH6ACrusomE8gQn87ZaMezjhjH75aCHkx8wpY03Uo/w5BQ8jogQfj5ZewVphwGI7gb2lX1yEHcaZyq/ZzH43KHau7+DUn1Satk0Y5rY2uZ94nB52ryoh9nJv7NQm44mDUurWy7ZGkw2r2b4mJvF5ENxblB1pCF8q7r4hF3exlR68G6g441smvxftV+DzHoQ+KQ9tX/ECPXNRtWz2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4OJEDWVi1CwJlItHu/e/JCi0ymALVy4bsUrfxePoUc=;
 b=v0+Q/zQiLlWJjapk562mG5BXYp77/DxIosMZWlwGuXW46nMF6y6wkUEJcMhKM65Cf5Q8XDiIkb2F+hEuVelcfWl0ysEp3esROCneUI0rC2ED/tY473xLQ7Un7rdik0RQ9Zc0g7HgXzt8KHfRoWeZMw+ZgBaTxkCc2U8dWUs19qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 19:06:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:06:16 +0000
Message-ID: <4ece2f63-aebf-13f1-c368-7c94b7471b42@amd.com>
Date: Tue, 8 Aug 2023 15:06:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/5] drm/amdkfd: ignore crat by default
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230807220545.1320198-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: fe06943d-a21f-4daf-0487-08db98428a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWjwg2qYwnH4VfvOXOaa9iqFLbY7uXsMz7OInOahxfki5cAAAWp4aDWj84DqhLPwbnfkUtHgMO83EDMOqH+W/XSCtRi9T4+VN1OQM/XIUBF9AVlBxfmwBMyIb8G524GzcXUfEUkXcWX44RZgQ4dRT6jZXCfgAQ0BEt7H0G/tKIOih1AEIP7H+fGAGxJ93kFQ0TZC1orsJEXZ5TeLCIT96+fB+vFlG9YB3iTVThlh6VG3m48xKDG43gcqWv9FqkrL7zymc4z5dw2KGY4mOgh7pWspNPkWmqk+wSsUIj/IeEfhpKKolnWIwzZ7Hs4AhxzWwWnj5PBDWvfkLoR8Ej0b8SwPTEpX9DG6Jx+dWJ7YJjdMXJR84U/BbPRr6ctJOIDS1vrzGMcz4MErn5qHvF7CnbPDSnaOvaJZQwcyrFap+en12qf+P4HoUpF+mN2UJawSLfVXxyc2yuvYbC7RyKQSoBTupRYvn8VxhTpPJUvp9E+X74YpRDyMfo8OSCcVM21cGjGSIufWSWHJy2kzPFlRENkEXBGo34I6svTCFpBQjnTskyXzQjKN8N4NpHGHkHc7g5dP1X3wPUfht8iy6NAgoDjZa/9lumlZTKalckM2dtH6/G7oNu5794ujov4XVK6CN+JslLJsZ0QZ6qqfa+KN3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(1800799003)(186006)(2616005)(36756003)(6512007)(316002)(86362001)(36916002)(38100700002)(6666004)(66946007)(478600001)(66556008)(31696002)(6486002)(66476007)(53546011)(6506007)(26005)(8676002)(8936002)(41300700001)(4744005)(2906002)(83380400001)(44832011)(31686004)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01XNDBzNVpyUUxna3ZMKzdJQU90dnF4NWZlbFVZRGlRcmo2MzZzcHd0dEFW?=
 =?utf-8?B?emFheEtoU2Faa0E0cjlnVGhMNkg0K3k0SzMwWHYyRGpRR3JiM2tIa0lCUCtp?=
 =?utf-8?B?Y1htRUhlSzR1TEZIM2dZUmRTM3VYVHN1bGZnNW01dXE2YXdlUW1GZHZJejZT?=
 =?utf-8?B?UDZ6V0xrL1dIWHpyaGRyU2dnc1NWcjhsM3Fyd0dEbGpMbG1EK0o2R2JZdFF0?=
 =?utf-8?B?akNRbmgxd3BKRjNHMm0vM2tqYk9qNDNHL2lRazY4SmdNWHM1RDcrRThmS21K?=
 =?utf-8?B?am5ESjFhWTlVSTNJTkVZM2lvbjI3N1lISkVJSk51Z3NXaHFZSHFaRzBTdmNP?=
 =?utf-8?B?YXI3RlN0dlVveU1lQ0hkU2NrNC94YmhmcmJLVjRVaUFOZkxnL0xrcUszZUs1?=
 =?utf-8?B?NVR2Q2F6T2t5QnNLQnNYTDBLa2daaElGcDdqOXJyOFZ0R1FMZUtmNXJJOHht?=
 =?utf-8?B?QmRZWi80MjZQclVjNmxKRlVqdkxYOVFHK0R5QlBoblk1dXZtNHN4UEw2ejMz?=
 =?utf-8?B?SkZTR2JKTVBJWTFqbWVuUE0zODJ4YUJneEFVend5K1dlczZSUWU5Q3I4bkNk?=
 =?utf-8?B?dmh2YjBkV1UyUWliaWsyK3J6NE90Ty9aci9UeUZOeFB1bHN1aWZJVGVCVXRE?=
 =?utf-8?B?aUFvWE1vdWErYkxoamhNVEtQdGFyOU9CN3BRWVdaSFBsZWRkMkQvdVNGNmVq?=
 =?utf-8?B?a2ZMY0tZT2NsNkRpOWRSekdlZnZ3RFRFRWg5Vk5zVzRpVDVHOGtUa3k3bDZu?=
 =?utf-8?B?Vk9COE5HNTMrOEpoNXZUVVZSeTdqeHRoL3V1WDZaWlhJQVRtTFFKc1BQMVR0?=
 =?utf-8?B?Y0I0SDYrZkt3elZXcVk3cUxid3EvWUVuVmtPbGt0MFc0V2NVSEFxTkhlVjJL?=
 =?utf-8?B?NldneFQvcmZSOStRQ3BFQlNHekpPOFBkRUd2bEthSDJDWDZYNHphUkliQy8y?=
 =?utf-8?B?Zm8xL3ZmRmlKV1FnYVNuNVpSYmlINWFRK2RKYnFuVDJYVExqMU9nUXE4YzdJ?=
 =?utf-8?B?RnA3eURvM1FLa25SK3ozMy9EUUZLRWFJdU5jM2hZS1g1U0hjS2hiVXI4VmQ4?=
 =?utf-8?B?RCs4NzRvcHluS3pVTUNscy9meGxjM1dSY2JaLzNYZkw4eWFFeW9sVnlKaGN6?=
 =?utf-8?B?RkFkUlp2YkVMMG5RUysxRDRXY0JoU2kvSWNyWWdDZGhBN0F5U3R3UmduZTlt?=
 =?utf-8?B?Rithc2o1NUEwNHF3MkVJYlBlZ0FBOE1ZU0NnRHcyaW03VzBvRjllMUFrVFpw?=
 =?utf-8?B?Q203LzdwVlhmSGQ3akZiQThzL3pqS2xsUmplRklOM1YweXFicDJTUVNDQVc5?=
 =?utf-8?B?WmlraVZpQVhEbjJ5UngreHNkSjg4amNVbVNhdWtkMFpGT2xUd2hIbzNhV3hF?=
 =?utf-8?B?blFvWEZTcmZwVXhpNXBYZmR1OC9iVjB4MFJsMVU3S0hVdWwxMFM5QUl2YWlP?=
 =?utf-8?B?bEwvb1h4ZTBZVjFsUnlBR29Qc0kxM0piWlh2Y0JGWW9oQkJHNlRGRll6ZFds?=
 =?utf-8?B?My9HRVNBeXNueUhXSjJjWmlBYVhaVzBwN3ZrSjd0bnJjVEhqZitzMGJ5RGZv?=
 =?utf-8?B?ZnBGV1EveFRacWZvRWhuY29yY0RSRU5ISFVFL1FsbWpwQjhLYVkyVTJqSDhW?=
 =?utf-8?B?RGlJMFgrOEZscXVKajZwNlRpbm9RTGo2L204Mmp0ZXV5V0FMSzhnZ09wSDFj?=
 =?utf-8?B?eXVjdEszZ0l2dExGbGZDaTkyT0RZRGFvRFRxZnZ1Z2FjSXhpLzVrbmd1SVE3?=
 =?utf-8?B?a2FzbmlWU0I3VVB4VDQ5OC8yQmxpNnpEcVFRK3k4Q3A0WU1Ob1dDQ1EzdlhS?=
 =?utf-8?B?UkdCMXRLZWUyTGxNaEtSejd2ajdvQ3lyc3NodFdOMVQ1dG5PZ0FYckVybUNp?=
 =?utf-8?B?Tkw0aUw3b21yWVpYQzdVanFWVlJscG85Zlk5bWtrY1NEMUJIbjF3bFlOaUNu?=
 =?utf-8?B?dEZHNXE1WnQwL3AwTkk5VnBBRTRsVEE2WDhtUU9OaHpyUVdZQ1ZldXMwZUdR?=
 =?utf-8?B?Zm0rU2pvYzAyUVVDU252dmRVa052THVXSGVsOEhrbFNxMmg4WDIzQzk1dUZ4?=
 =?utf-8?B?ZDdrVGtKK2ltUmR3RCtjYmZiR3ZDUmdzRUFwWDYxekNueUNBYkU1dmVGQ1Nu?=
 =?utf-8?Q?772yAQuuJfBpJCarsL6juYzXH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe06943d-a21f-4daf-0487-08db98428a5c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:06:16.1318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxOq3rxvKNv3v1GERPrlQfpHAZdc+6BD8PpygHJ8WPyhDK1wyTjKWZeNrI5W3sh09BLP/DVzbAPl9V30gUKFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
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

On 2023-08-07 18:05, Alex Deucher wrote:
> We are dropping the IOMMUv2 path, so no need to enable this.
> It's often buggy on consumer platforms anyway.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 49f40d9f16e86..f5a6f562e2a80 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1543,11 +1543,7 @@ static bool kfd_ignore_crat(void)
>   	if (ignore_crat)
>   		return true;
>   
> -#ifndef KFD_SUPPORT_IOMMU_V2
>   	ret = true;
> -#else
> -	ret = false;
> -#endif
>   
>   	return ret;
>   }
