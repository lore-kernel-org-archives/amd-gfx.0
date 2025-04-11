Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D5C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B3D10EC43;
	Fri, 11 Apr 2025 16:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OAqTT9SX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4877510EC39
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J96tguwGcrFnThcCKd4s9gYPuajd2se55U0jG4nictrUWGkc8rg+usFIjzEhQfDGBprhr2xJgudeETmUYQSoi1W+vCsWJ/v3wTC94/c0maxLG19eERrEp8wOVjF4Hfj1/BIRr+mFXGfPAegswCXK7dZaQpoyl1RolCjsHoiV0k3QUVSERshVADc2fNBd47omnQlfL610Ij5e7z5SK6fWf0TrlCzHxmvqMDn8mGd+NUF9lv6NWyvHvxMGq3Q3tGTOJqGZWHQ8TIjaZF9klmAVmwkvy/+MxnZlKS/tOEOWNBGiv+eovBxRDw12IOUcb9gy1r8LLQMeL/YQKVwd/RxepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gczDd/H6TUEJ+vo3W5K44jmN6F7ks8ErA+aZARDia/A=;
 b=k74deQNcKNJ/DDOdcVOgnf+gOSy+Jf+v6E/IkDzOBotZcLkLgdNi88hpmwjuPQwID8+LK0K/61wJA38ZXIRWSClcbtJbKfooadJ5y8yUhBx/F2qgI7SnC8H0LsFDBkcjs10qb2e5m8V0vaEVt2Pw6oThTvA1xw6HmxRoivLCuLiZBtoQQV8gnoSHj6mHajs5xBqznEiQMcWNzIONwhVUUwHwW7ZS95Yr7m/b+H4NQP5z1AJ9rU2UAt85MJAeLFP7pxp8g03iMnYDS9T+FWT23TJy3CSYtSh1llp9bjJoffeLVcGFkGEcP/SwaTx+R9XLO77XaXwshh8fLGFte/8oIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gczDd/H6TUEJ+vo3W5K44jmN6F7ks8ErA+aZARDia/A=;
 b=OAqTT9SX8wc0nuShztJXHNv6ExAu8k8UWvrK9fbHsESjeUGFpuZi8nHfPbMx4TWY7lEF46hnT0ETQqTlU24OiPTh9442m+t0tVyZ8UndxCGMQ+W9V8bifPuGtvsEcXEO/bOb24zGzueaSmF8rvjVaG05hNPFvBbLSf3SUDPl10g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 16:57:39 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:57:39 +0000
Message-ID: <54b186a7-3e36-4277-aad4-ca1672d92445@amd.com>
Date: Fri, 11 Apr 2025 22:27:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/userq/mes: handle user queue priority
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a78a97-6dc4-4193-c7ad-08dd7919f76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTlISVJOdXFZM2ozU3dYL0t6NWVMWkxYR3lNVHQzNlVtYXZaME96Z0psSGNU?=
 =?utf-8?B?SjI5eHc4TzZkZ2ZwazFEWVRLS00rbHAxZldrditLSFB5S2xCeEYvamMwNm9B?=
 =?utf-8?B?U09YZEw0c1lmZHNNZHhQdFc1bkNoN1A2WlJ3SmZjbW9RV3oxVmEzSHFqaTJu?=
 =?utf-8?B?MFlvcklyUUJEZHhrd0lSMWJoZDg0UGJveDV0WGFxczJyWnNCTDZvMnc3dkhL?=
 =?utf-8?B?M0QxcmJ4Q0dJbG0venJkN1ZJZlIybmUwOEdQbHdDN0RheFllY0tSU0Qxc0lZ?=
 =?utf-8?B?bkdmSS85T2c0Z3pGUk9VYi83bm5wQ05YZkRxMW51YXhmMUMwRFFFbG1EL2px?=
 =?utf-8?B?T2FzRE9TMWxGQlIzbVFUdTU0bmFHWHdLSFdDOStZMCsxWDVQb2lMQU5sL1Zs?=
 =?utf-8?B?T1A0cFZmKzI3RjFjTlFQRG5IZGM0aU53RHpLaEE4UzZ0ak1JQmg0WHA4UE5Y?=
 =?utf-8?B?VVRWM0tNQmNHNldxQ09ILzM5NlZpa1lCTW1HQ2tIeTdralZHNFExLzI5TW0w?=
 =?utf-8?B?RE5hZHlsUjYwREcxZ0praVJKQ0l6bnZsREd5blBsSmxxbzFQNmh2YnQyRks2?=
 =?utf-8?B?Vko3Y29DVXB5OW1nbCsyRW5xK05xL01EdkVxZ2tUOExVeWYxMGRIVG1SSmpE?=
 =?utf-8?B?b3ErVmNkVjd4WEIxd0Q0Y2lHb29ZMVI5MkNBa2ljVEJSaGcyWUI5T1hrbVNr?=
 =?utf-8?B?SmcwQklieTlWeW5PbFNFM0tmUm04SzI3Z3dCbU92M0J5b2FNM2t2UXp3aHAw?=
 =?utf-8?B?Wi9aaW5FMkxFUlhJUC80QU5jMTlSWkNNdVFKN0E3UnRLN2JER0RoNFNhVmpv?=
 =?utf-8?B?ZVlHWWRSVjZ5cXZ6YjZ4L1NqR2pNSlZBbWEvTGk3OTlVSkNiVWE0bHo3ekxV?=
 =?utf-8?B?Zm1qN0tMUkIzaTBUTmc4Q1VpOXNHUHA1d1BTa29pZHNqRytUWDBlZUJnNWdZ?=
 =?utf-8?B?dXlyc1JhTzdYd1JEUkg5Mi9ienlzbFROZU1aYmgvcmJrY1IwbDZKUzVMN05X?=
 =?utf-8?B?RFBvcWVlMFY3QWl6SklDSkZjcCt0WmpINjdZVVBIN2VyaERtT25UQW9xUm1P?=
 =?utf-8?B?eXlGN3BLN3Y1OTFKSnRsajFGS1NoN0xKZ2UzVmdZYnlSZHBHbVlOdnNjZDc2?=
 =?utf-8?B?NGoyamRtU2N2N09MQUl1ZWhzbEpqYWY3Nm5iSkd0aUllQUh6ZkZpbkJlVHha?=
 =?utf-8?B?cFZiYVYrQmVvQUZ6Ri9Ecld5Y2FsQ0x1Z1k5R2Q2eVpyaDEyZXJidWtKb05G?=
 =?utf-8?B?ZmVSeXpMMXBPSFpld0piOXhXREpWZHhUVHg2YVluWnpDeUZha09RYUZFYWtu?=
 =?utf-8?B?TktzSGZXLzk0dWhMZnh3OHZqbUwwR0pST240UHo0OHM0RE94czRXYWg0L1lC?=
 =?utf-8?B?TjJKRDVPbFdmUFpieWcySlhJQk81bXcwdUdSbDBBMGFQNFEzRFR5RjlsU0h0?=
 =?utf-8?B?N09JNEU3RUE4Zi9nU1E0K1h0N21BNURqTHFNL1NqeThhclkxcUZmNkVza25X?=
 =?utf-8?B?VHhaSFVRUG1lTnZNTjhHdmJ1Z3FLUEI2M1Y1c0djd0cyZ2lGcExNTFpCaVhR?=
 =?utf-8?B?U3E1MXcxa2VmbDZxbXdocnlkMkp6dkd6cFA2elBRVXZOdkpibmdtenEyUHc5?=
 =?utf-8?B?QWFkZzE0dXZmaFBZMzFtZ0pjM2pSMndkQnBCa1pOak0zRWhDTWVBazZIemJp?=
 =?utf-8?B?UmdXUE1lNW9SSXdUUUpKUmRoZktyNHpjYjJHRTBZdmxaTmpFNE5VeW4xVHlF?=
 =?utf-8?B?a3BlcExFck1NZzhEOWRicXk1ZnB3TDFZcGJkaVp5b2NzZ0VIQVFqVHEvOElM?=
 =?utf-8?B?NjdVUDZ3c0NQRE93ZjNBZjJoRU5XajdXNnN4bWw2SXBXMDRNTEFxSkRSaHZ5?=
 =?utf-8?B?Ump6Wmo3VEhabG91TFBTSlM1T1NlaHo0MUxVMHlKa01CaVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVwRkFNdnFUb0RrQ0Q2UFBUNEc2UGJNU3VWMlZIeTBUbWw3Q1ZMbGZORjhn?=
 =?utf-8?B?L3dxbWd6REF1cllvLzBMT1JuSm5na1dIYSsyUy9ST2pXVHZiNkdVOUZGZWxM?=
 =?utf-8?B?K24zNk5QOWNaMjZLd1dIbW5KSU9rUW5pNktJTXJEZDdUZTU1enJUSHZoaENp?=
 =?utf-8?B?eEpwQjVWOUo0cDNNdGZjUi9JTnVFZTRtdFJESFc1cE9kekxrQzJwMFhEekI0?=
 =?utf-8?B?Q0FnUGNXUlZpU1hHZXNyRE96b3N5RmJET1hZeHA2K0hzSDg2ZnZnditwcnd1?=
 =?utf-8?B?aklOeVZCUW9qUmpWQ09JclVLWTI2SSsyTjlWbnFCbDhaTHpScW9FVlR2SU9i?=
 =?utf-8?B?TXV0YUNJNUdzc202UWE4K3BMeDhpcUVERTB6MUV3NnRZRlU0eHNFY2dCcVZs?=
 =?utf-8?B?YTZiL0pmNlk1blovMElvRjBoWTJEUEpBOUs3ZzJ5Uk0rcWVucnFLeUNoNG9G?=
 =?utf-8?B?ZVgyTXBUY2JSUTYvUC9LYnlkamJ5Q0VyN2FEeGxUSWJrNk1Edkt3V3hxbWZi?=
 =?utf-8?B?aFJBNXdBMmNWMlUwZ3B6Z25Ic1hDcnh2S2ZnaXNhaHF1NWRFeHFCMzJkRlpy?=
 =?utf-8?B?OVVldm1nTTJSdW9iWXJ6NEFHL0YyS2dFZjlMNWpSRE0ySXdIOUY2RW5wN3F0?=
 =?utf-8?B?NnBSYmhnWDhnSTdKd2J3MHhjR2RoeHVBZnBHWkJ0Uno4STJuOUYrSTNOa3FW?=
 =?utf-8?B?Uk9ZTlRKSGtoQnBLL1AzZlE3REErVDJVL2VsMHV0TFdkTFE0anhQREVUQ0Ev?=
 =?utf-8?B?c3JQYlFzdzdNejU1RVB6Vld2SkVKS1NrbEQ5VHliVUl5WmJIbnM2RlpyMFls?=
 =?utf-8?B?dXZjYVQzTldmWStEYzNZeWhqanNnQ0M3SkRxam8wNEpYemx1YUtsNHdLY3hC?=
 =?utf-8?B?d0FmYlR2alZBU0FzVElhNDdGOGllcVZ1NlVDQm9NQVYzRUV6ZjY1aFZEOGF1?=
 =?utf-8?B?RlBYMlM5a3lJb1ErclphMVgwY1UvZm1tbGlyZTNNc2RJOGJsWlZPZDdGU3d4?=
 =?utf-8?B?Y3hzdEhYYzFtQVRmOXZ5RkRsY3J3OXlxK3FsU282SHVqeW9GWVBmWU83Ykh4?=
 =?utf-8?B?U0VYVGljV21KSGZpSmFGbGlSWkVhUDRUa1RqN215eFc1TWl1ZUIyNHdSajV5?=
 =?utf-8?B?SnpvVXNlV3k2MS9sZTQ2b2c3OWd4NE5jSnU5R0Nwb1FFWVBSYk5GNlVVMFla?=
 =?utf-8?B?K0xpaGVJdHhheHJEUkJGNkZ6SDNRa1hwdDc1RVlXeWVZVlRZK0cxbEFiOUlI?=
 =?utf-8?B?a0FkU2ozZ203WFpXc1BETld1eHQvbitSTEc0VktKd2ZRb0lNdnIvNXd1QkNO?=
 =?utf-8?B?MUh2WGlJTFByVTNmcmsveXAwQkVHSzBubmFmNEVpNUdBK1YrZjBIamw4QXhV?=
 =?utf-8?B?Z1BxWTJwMHQ2TURyRVJ1dnYyckczRUJyY1NzenNuc3Ntb3RxNGxKcVA4T0U1?=
 =?utf-8?B?RHdOdDVGRWFSYmVXUC9QMHpaSktSY1h3OG44Ymh5K2dVTCtXcEVsZEZYdkxI?=
 =?utf-8?B?Y2ZESE5KbVdFcjI3aE5RVXFSYmVpTFpTU3NzTldESUF3aU81RGVxK3JHeXdT?=
 =?utf-8?B?YXo4QWFtTUFnMVBSL0ZtbWhIUjhqSUU2cjk2SEVEV2ZYTGl6cGo5eUpKTDlX?=
 =?utf-8?B?ak81d3djTjVPWEN6dWJHRlJJOVZuMXBJMG1yc2ZkOUtuU3Bjd2YzNlRGZ21J?=
 =?utf-8?B?ZWVhZWlyZ0xSWGEzM3FxckZJb2ovWEFaNDR0WTlTWFR5cGtpTkI3TDlZUkpO?=
 =?utf-8?B?aExtMTFzV1JYOFZEQVlFak9uRmJ2M0FQeC9UUjczYklxRkhvcklRWER4K2ZR?=
 =?utf-8?B?aVMrMCtRSWc3QjF6VW9NamF0Z1JOdWliVWlqL3ZLNFBNblNDeExIa0hCTVRr?=
 =?utf-8?B?NGNzZHdQZEw2eHR0Vk0vVWxRczNKVjIzNWlkcGUvQkd1c3dSL2YwUnVLQVBV?=
 =?utf-8?B?T1RwWXhsN2dhKzAxS0lyRjRMQlhxd1lLUTUybU9NMzRCZ1IyVUZwdS9SODMz?=
 =?utf-8?B?NUlyRG5vS2pOaDdIaXJmZVRmRnArL1hXdGQ4dFgydW90azRKTjJMb0ZTenB4?=
 =?utf-8?B?ejk3S3ErTHVOZ0E2TVdsNTVOSjluTExrUkI0djFhWk5WTkl6ZmtUNm42dlRk?=
 =?utf-8?Q?nWbh4I8/yzvewvod4h+12yTOu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a78a97-6dc4-4193-c7ad-08dd7919f76b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:57:39.2807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9KR1IawUEGvzgnyarhxy30F5UQSgUeL3MKjC61YjvJ0dqfgbCEB4yTgoS+yEue5GAs90HYNwWa6gLlbm11PyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Handle the queue priority set by the user.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e3c3fc160b799..f406a9a29bda5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -97,6 +97,21 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>   	return 0;
>   }
>   
> +static int convert_to_mes_priority(int priority)
> +{
> +	switch (priority) {
> +	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_LOW:
> +	default:
> +		return AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW:
> +		return AMDGPU_MES_PRIORITY_LEVEL_LOW;
> +	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH:
> +		return AMDGPU_MES_PRIORITY_LEVEL_MEDIUM;
> +	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH:
> +		return AMDGPU_MES_PRIORITY_LEVEL_HIGH;
> +	}
> +}
> +
>   static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   			 struct amdgpu_usermode_queue *queue)
>   {
> @@ -122,7 +137,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	queue_input.process_context_addr = ctx->gpu_addr;
>   	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>   	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> -	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
>   
>   	queue_input.process_id = queue->vm->pasid;
>   	queue_input.queue_type = queue->queue_type;
