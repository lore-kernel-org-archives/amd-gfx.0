Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960E9C76188
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 10:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B2F10E8B7;
	Wed,  5 Apr 2023 10:28:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2908F10E8B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 10:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2zMyhiI0KUSFP1WqYoMFBbJcvYkRf8GzSSPN02z+N6gFFGGqdkpV/k//pl/9b3Ug0o/3VurfQDznlGm2swVWHKONiClECXepu0UDG7htwSC76pS3g/uXg1CJMCRuZkPXqDShl0rSsRDOr6lbgpQ01MjVEjwD/28FmuFwKyAE9BHZfAG6nKrsdMLEVwTjAVQKLd2VW5YAGBjaMBz/qdFFj9PFa3BJ2CJIqWqYIxAedmTGSpmwm4QzsLxl6ltqvwKm6HAK7P3oy0tVtB6XFWt2Bucfuw6n5r4B5EeML8gG7lvTdfnPBXTvINg78yn3YI/EdlV1o0JtWcSsUtqPXeeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eWekPzkNzDhjQXB5q2cGUgxYlPe+hDA6NkrOqOuP/Q=;
 b=edkg6s+fOoi69A2Nz1Kmm2AQP1hfWs+ImRCLyqgnwWwL//VCnfeMok1SlIP+n4fPt3WzX+ZvuWPkagHxnqsr/ydhGBepXK/oAYcBkRTisCAWgVomBQpzlG42FXEeQQwzen3zmShqM4HGGBEZEbedZqd+ZF+4fgzJIuijEiYYF35aGZzw2PI5e0t2LSqATAzx0BBlwJN2zxKfBO9BLiG8aVOm+/nIzoYeriR91GvOZmvp1l8lmYrUFlSQ+IHjq/QSIme3dV7+iIskIOElLPbYTRV86E4N2BDwqDAbcHLYzpuyhthe+tIv/7OHyHNovX94WagoCxMThOk4bWFlmLZtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eWekPzkNzDhjQXB5q2cGUgxYlPe+hDA6NkrOqOuP/Q=;
 b=YPMNlp55OlxAHvzft0ANwVdQ+C5lSFkBCDURcJI21KbIbNhiCmZWzgUCmjAjo3NZNB6uFHl7knQ15hzPLp/cNn2jRBJAYJ+zs1kGdVAKleuYmAtsF9BaKd4Olxu8wsWEXXaX4qdSwMkB2eiUIdzhnJUFrxYX0W2brq0hJLQd4GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 10:28:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 10:28:00 +0000
Message-ID: <01e6dbad-edb7-abcd-f4c3-8ed9b6849e44@amd.com>
Date: Wed, 5 Apr 2023 12:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix trivial style errors
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20230405041939.3781870-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230405041939.3781870-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7d4a0c-ab4b-4069-1d4a-08db35c06e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8OyPbSCLuom5S0h+rVBAxktJe2ml+hX/pGjeeWH4kBFl+Xg2rCkS2AZ0m2h1sWu9fqH5jF2LPvRhipr40qd6fcLUokC8knSNAPUBTLcyQN+Ru5ZQ9sxgGwv52lf0e8t/7feq5rI07s3/76lTjUTG/kPYtjP1SsKOe/RueNOXEZlH3H9fiqFiKk1185WO6VvX99bQLK3r6amQpLWwVNknlxW4pYvMHju4N8e8FpQ7LB+rHfIVvWoJ4MpfPhur25MCIl+sARp2sI3EaSKasTjntdXtvjnQv1XUjxOXfmKNTSL7+fa5LWLhjLCDRT3a6YoQn8mCh2+CPwWpQ4NEibSQG2bOTIAMdNvhvC/dggLJhgsaobzRMQ/nRDBJv6lDY/YEMhFHax7DOqOsj4awpDYu3+MJCJ5K/qBirkJKaigpoGBHAVGpDfNuLFrdBUft0YCd3WXSW7xrFT1m4OVVhfRdKMiznFxGjegqR33ZHaU+wR4yotEVAilSuNkneymTcLv6cDz0lAhgd3tU1GUDrb3T7JzDrpliKhbDKn4HI5qc/lhrtWg9lIMEMrGeS53vJYzNY0lT7snBV35TQlsyvs8fn27D78Ncr3coQipXbdcRDjgARmowRtsg5iMsROdnuf/vCYfpiFI5qYp5G1yxql9mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(2906002)(31696002)(36756003)(31686004)(86362001)(6486002)(2616005)(66574015)(83380400001)(186003)(6512007)(6506007)(6666004)(66476007)(8676002)(66946007)(41300700001)(66556008)(38100700002)(110136005)(5660300002)(478600001)(316002)(4326008)(8936002)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZMVDJLMzZma2lick0zc3B3Uko4UUtvYlUwZFpOQWl3aXdDc2g3aDExOCtx?=
 =?utf-8?B?ejRtQkpYMm1zeUlIZ1BIZ2FXdmQwMWRTWUNsUUFYNUc0dlFWQTc3eVA0MVlk?=
 =?utf-8?B?RWtUWDE4MVRzeVF5aU01WFNsV1hhTmh1THJxd29tc2VFbHQ5b1k2dENUbzJK?=
 =?utf-8?B?dmlnY2hFa3FFdXJMOTl5bUgxRGViek1xRUJNWlZWTFJ2TWVGV1IvSW01dm9L?=
 =?utf-8?B?UGJmekNZYk9tRjJ6TGN6U3VqT1JGaWl3TWtIYmpZRXl1dlpiMnhINW5IR1NE?=
 =?utf-8?B?RUFCcFBFeDBNYmhDWkY3UGxjZDRqMnNVSDF3NzAySGtJVnY1T3dQemtvWTZx?=
 =?utf-8?B?SGlqaGp2dU1jaWZ4UWRkUU9hNTFLempXaFJEWHE3RXpkNEZwVjAwMTlkelZu?=
 =?utf-8?B?S1ZURFJkbHZzMmNjTTJwTW5WTHdCZFJVUFNka3lOU3ZBWnowNzBpRS9taENK?=
 =?utf-8?B?ckI1a3RFZ3VmcjhxbmtSQ0poOFJPeFdjQnF4cjRoL1U4SlNrY3h4dSswS280?=
 =?utf-8?B?NWhNVmIzM0h3eGszTVJRMzNCR0JaeThZMEsxNFpLN3ZUYmd5OHhqdjBtQlEz?=
 =?utf-8?B?a1lLd2cvaXlEZTkwOThvcW1MMy9OK2lFYktqeXV3RERNQjJ2OHFkMmh1di9P?=
 =?utf-8?B?TjBvL0tHR0tyTXJHL3NZRGhaQjhEY0EzNWU1N2FVRmpHeXltUldpczlNTDl2?=
 =?utf-8?B?NHFCL0dCYXNBVC9qZE51b0tjREZ4UmZsZFpXTTFDY3NVblIwZEFTaHZPc1o3?=
 =?utf-8?B?NXMrVHE4cVlWWDVWSXg3MUtsV1lDS2F0M0dWalN3WmpTQ1VDb093RnpFQ1Vw?=
 =?utf-8?B?a3dXUHVTNFdCN01idEZuWXd3eHVRQklWcGdwdEhEbThud0pwN2szU0ZaTlZB?=
 =?utf-8?B?RGd2U05aZG12WDRnMDhNeGE0Y0tHZGxQWnZOV0IzUm1ocTczWFpSbGpYY2VB?=
 =?utf-8?B?MGZBeUtYbmcrTERKeDNpQ0dVTzJjNEpLKy8wYjNqWjZvd0t5YVQ0Z0NLMGlL?=
 =?utf-8?B?djR1SUpKY2ZTTExjdDY1WFA3RjRZdGF3SjBBTG1jcWFRSGdhK1lBNWYxVi9O?=
 =?utf-8?B?MHZ4TUhMTk1wSExDSlgrai9nc2MzaTY2WUhCdk52dE1nUW01OTZ5U2YzZXFw?=
 =?utf-8?B?Wmp1WmlZMzhuRWdGd0F0cmZnTm9nOS95YUNpR2J1emdYMmhxWE5pL1BHTHh6?=
 =?utf-8?B?cGdYbzcvcTFLeTh4Y2IxN2Fzd0ZTT0FoSGxLaVhGem90enE4Tis0U1AxZ2ZQ?=
 =?utf-8?B?UWJBWExnZXlpamJ5anlSTWViM01CRG5TaFVPb0xWL0xldlAwYmhPMEhtbTZI?=
 =?utf-8?B?WmJlNUJ3MWxVT0U1MDI5RVBHeVE4WkJMZ0ZyRm42RkNDdVdBU2RYeTkwSkhQ?=
 =?utf-8?B?c053bG5YNUVvb0x2NFZ1amo2by9VZ1JEK2UyM0VPdmgweE5jOTNNUXpyeDZI?=
 =?utf-8?B?aitMbERhanNKWlpqbU5NRGZieVB1ZERwcWtkOHN0MEpXQ3NWV1VKMEpQUXUw?=
 =?utf-8?B?Ull2Q3FTOEM3Nzdoc2Vmd0M2Um9ZVzIycWZ3QkRhVVhsUXE2d3d1ZHdkWWJs?=
 =?utf-8?B?ZWVKcldiZjdLbDRnbGZiRE1YUzBiNWNqUHVvRHdIR29QSE91UW5lcmlJbHRN?=
 =?utf-8?B?eTk0Z0hHaklremJ0dWpPTlgyVUlNTmJkRlR5MUs3T2NZR0dwQkZtemx4YXhL?=
 =?utf-8?B?bFI5RktNa0hZYUNOR3FMaXY4d3crbDg0TDJlSXdpSWd2c0JjR1BGcXV0cXBX?=
 =?utf-8?B?WG5HNmVPTktHcmNrUWZxc3BuOVFzRzRkRlpjbDBETWYrNWcxL0tvS3NGUk5O?=
 =?utf-8?B?T1gxeis1TTZVWWZGQlcvejl3ZkxZQ3VFY2Z6b2JDY3N0ZHAyMHB2Z3pER0Ni?=
 =?utf-8?B?UHlOamNaRnFwaDNEc0lFYkU4RGF0Q3ZhTkg0eEpqeE5WeTArQlVBei9oajI3?=
 =?utf-8?B?ZHNNaUJ4V2NzdmxVSVdQdjQ5TGpqLzYra1lIN0EwRThrNVV6dHViOHU3cE9j?=
 =?utf-8?B?dUJGY1pmRkp1QXFyamJXSkZHencvbys0cmFwY2pOb0ZWeDExOHgvTjNxajRK?=
 =?utf-8?B?T20rRkt6QUt4VjllNXBhZ1NhR2FkQXJVdFhSMk1zcmlRNkhtbitIN3UwU0I1?=
 =?utf-8?B?SzNoUFFnT0xWSmdkTUUzOGMwVU8xYTdYZlNTY2dnNXArc2F1UVpicWJ5UmVD?=
 =?utf-8?Q?JnrgQMxy0MXkjEg0BO0lfd7q1rmA8zHBdB3h3KHyb9Ot?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7d4a0c-ab4b-4069-1d4a-08db35c06e0e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 10:28:00.3361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zd8Ou1hR5wL8xASd8rJQqAbFZJIDeO4uyqEikDOtOn8TQ+A0jJoiNMtAiiVackN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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

Am 05.04.23 um 06:19 schrieb Srinivasan Shanmugam:
> Fix coding style errors reported by checkpatch, specifically:
>
> ERROR: space prohibited before that ',' (ctx:WxV)
> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
>                                                                 ^
>
> ERROR: space required after that ',' (ctx:WxV)
> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);

Since we don't do resubmission any more this whole parameter can 
probably be removed all together.

Christian.

>
> This patch gets rid of all above type of  "ERROR" messages in
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e652ffb2c68e..d2af86c2af2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -526,7 +526,7 @@ module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
>    * Set how much time allow a job hang and not drop it. The default is 0.
>    */
>   MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and not drop it (default 0)");
> -module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
> +module_param_named(job_hang_limit, amdgpu_job_hang_limit, int, 0444);
>   
>   /**
>    * DOC: lbpw (int)

