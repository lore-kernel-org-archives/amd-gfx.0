Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAFDC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 13:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DC010E073;
	Mon, 10 Apr 2023 13:09:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CB010E073
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 13:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMhj98B6COVdbd45TPjvZdap+0J6rUG4Aq+kY4sHdN60QZVSN1F4iIOjj1g9Xj56mGXSfTh3d2F9T9hwS+j7r15WJH1UgUr1qKUw3nx3B4+2KDYyRWsQSfx0BlIsQecUsH68rhhYi5tG+FR9XSL2xXu+C176JryXUWCNlFXKJHPHhHLCD2IhKeFQmAXAtjYe5gW+fUMKmbknJjc9OFjSxvE6QjDFlxEN+EWCjbDJkBi7wimsaEykuWDy27qZewJ1C4dzISMLvg0EXYaFvI/kHP8EOGdLXCtENXlSq3dUNRBcmPx5o5Osdzhf9xhsd8+66lntIXL0m+KsMjzef2FBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB0mGcQyr3/d6xgRps0RjITUJGwctrANB17k5VIEX3g=;
 b=Cfl8Ol0mCUcC8e6Li37hCrbjtQVl9lMq/MjS2nGayBd2bkzUL90NmXZ5hpcNIlEK5y2sJzrK9ckHeOw66Rd95N9/WkR6tcQrIZ6xkRapL/hGgGAeApAMHibz6qpbGyji1Qaar87wTnbhsBu3Xd+l0JYXhKOxJxuDSJnJFT4wW/y5Fc8eGwpdPhmYTmVL65pEK9n3O9jn2ITb34vEWJnjivPqmgLQ2k8HpjXcfluX9AIagPXIX8ZwAKrJqQsudQL7vlm7mhYGMc7xcIo5DQfxjkmtFyHdcaW1UrUxR/WHqLlaBVY6uQZ2k1hhI2VOeJBk5RcmKOtyii6Jv5/sjr8elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB0mGcQyr3/d6xgRps0RjITUJGwctrANB17k5VIEX3g=;
 b=qHXKHqVQNf/YXQeYaLZJAkt7AzziJLFAcgGf1gOduBP1MYuOI3cl7nfuecpD/MUCD787yTBJbEvMMASqZL4op5WNXs24QtYROYsXKIwSX4OIt/cT2xYeh3SnUESTVfIqgNmCKEaOD6cX6u2jVdIdIM7bCPZJnBL7tjc5t9ASnrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 13:08:59 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4077:8b05:f3f3:3d8e]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4077:8b05:f3f3:3d8e%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 13:08:59 +0000
Subject: Re: [PATCH] drm/amd/display : Log DP link training downspread info
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Li Sun peng <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20230409192108.1505595-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <da95d95c-d189-a747-b281-eb42d24b5cb6@amd.com>
Date: Mon, 10 Apr 2023 09:08:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20230409192108.1505595-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::18) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecd7690-a89c-430c-0100-08db39c4bf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dg7GNc2V2To7veczhXbOAbL/COHg1rl2d+AnJJ0IkdJMXixDQAbmJw7vfdvKwgmZcb3FN66V2gHCtRxuxa5ovlx5/JIYWauR4iSvtTbN0CePUGEK8/4SlK/vuvGLw7OqmtiKNSxlTIGCHtALy2D5WAHsHgVSG7Wyw8LUaEshyJPMABppwSeNnxMQ7sgsOvfgxwshfP+jNIo3EV6Lb3PhCwwYBdCryicKfbTH7Huocg9QVYVeLG+7vLTIvn8Lruuyv+GmBAz66Ky65EuYJ3ZJdJ6RzzQE9mohql/k9eDpav4USliyrkH0lx+uSWWHKL7OgS/7+tkTugLPlPUhlfFIvF7O1G36etZZ6vG57h9r7SPOSwZ9Knk8r4S4V3d9WtX4le0VzQ4T+UlesUQ/CrMPUoPEgHEcDe4YyqHsq1QeudxppgVQngruRqhk9dHixYP/tFYwgV/MIOB4aKBba7gKq7CNGU5wR/j0br+mBspoqEcKDa+McXA9puJzCYA5EFccB+1RLMrvfJi5cEkExOqmXqPM8BWRw4693HuCH+t/AoLUw/yKtv+7FDSGygpqAQQ5jGbSoEumoQFm4VGXYcNilT5zWhXaUwe//CxeYZ80bwlnemA1S2zzegoeSeDpY6ta3Uh/JQGYbHCyUF4EWvMeug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(86362001)(31696002)(36756003)(316002)(110136005)(41300700001)(8676002)(66556008)(4326008)(6636002)(6486002)(478600001)(66946007)(66476007)(5660300002)(44832011)(2906002)(8936002)(38100700002)(186003)(53546011)(6666004)(6506007)(26005)(6512007)(2616005)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklqUk1MOE01Ull5cnEvNHFwZWEvN3RhV1V1VDRaWE81QXZjRVI1djRMQTFQ?=
 =?utf-8?B?Zm1PZGdhaXpjWUhRTG9uRzZjZjdtNVhSL0ZxRUVaajFIYi9ZZGxTYlg3MEpy?=
 =?utf-8?B?TkcyWGpOVGxqUEZ2QzgxRzA2VDludXZWN2dNUVVSeUI3Y1ZSeUFxak5FTC9o?=
 =?utf-8?B?LzBXTWhXZm5adlk5VlZoKzNweURDVlRndGVMQU85bHFoa1hJSTVlaklFekZy?=
 =?utf-8?B?ZWZ4Y2dabUtyMFJoUk16cmhFM0FKWFlPcnN0ZzV5VHdOM3VXVFRDUEF4SnVE?=
 =?utf-8?B?ejRhVzRkQnNDTGY4NHJOcUJwbUxSL0dRdW4zMldpSHdnWjNFZDRQZ3ROdnRl?=
 =?utf-8?B?M09QcUd3OTBVeWpFMmdGVE1yV1owTFBNOU1scktYOGgrMnFmRnRHYWpHaG9K?=
 =?utf-8?B?ZU9iTk05cVhBOFVXMWhpZWMrMmxhUWVlam1CZWlIa3M1WmFvZWFKUzlzT3VC?=
 =?utf-8?B?dkV6bE50Rm0rZVBPbTR3RHhiZDhtT3dxYzJQVE13VnNyTWR6VEl2cjI3bDJW?=
 =?utf-8?B?SmZYUUVpYjBXZmMyOW1sc1NXam1wVk1TcThaNjZFYlJ0R1o0NnlySnZVdWxX?=
 =?utf-8?B?NUNYcnVqeWVrZGMrUmg0bEFpa2p5S3RTSmw4RlRmVjFTOW5SaGRWQXJSdWhI?=
 =?utf-8?B?K1lka2xkY2J1ZVU2MFh0dS8yZzQ5QmFyRlo5RXNRRC9lOG1TQWFqUEVzREZO?=
 =?utf-8?B?SlpsT0hSR3p1Zis4a2srckxQcEZib3F3SCtacEJjM1Nud2FDak1kV2pWVUhZ?=
 =?utf-8?B?ZUt6a3duY29jcU1wVGVtdSttVVl4RlRVQXYzZmRPaVBXSy9JaUVYaDVBZ2tJ?=
 =?utf-8?B?bFlYUFZTSlgzOS9HVUNPZFpCSjdnQldka1Nqdm13VVI0am0xOHMwTytETlho?=
 =?utf-8?B?eXVxdjRmZWJmTENTbVliU1Ruc3VoMmFlOG9XK3AzUHRNVmxzRW02eVU1cUVT?=
 =?utf-8?B?TlVNaEg1MzNtQitQZEFnNDNuTnU4NUxnMjJRZFlDNEo1V1luNGtkRmRIV2o2?=
 =?utf-8?B?S2lsQVFSTHJJSG5IZXdGRTNJYk5RSEhxeEtWL3o1aDZONHY0NVd4aThBcXN3?=
 =?utf-8?B?T2Z5QVJyc2wwZ0xuN1FZZFF0dy9MYndHdDlzeUx5NkMvdXlLSEttbXlFVXdY?=
 =?utf-8?B?ZEo5d1BNWG01TEZvTXg4di8rWldXTDRjOXRVYnJ5NEd2SVJaU1JQWkFzUHow?=
 =?utf-8?B?Q0Izemk1NXhhWFV2bjlZWUZoNHlDSkZBeHdjREdXdzNMYi95MWdDY3UyRWlF?=
 =?utf-8?B?eitaUWFreDNja2Q5cWx0OGdmbGRDMVlCempXRkJ6YnJ0cVROcWxtVlhucFNF?=
 =?utf-8?B?UlJnd1JVQWNGVDN3RnFUb2VWUVdjZ2tnMXhvSEt0WGdkVFR4cGYzMXVWWW5L?=
 =?utf-8?B?Z1dNMFZFcXQwZFJNcEtwRWsva3MxUEU1Vjg0Zk5yOE1CcTFBN3ptWVFpUmE2?=
 =?utf-8?B?YWcyeGVsRmpmMTAvRWNXNlkrZkhYZVhSRVRUL1kxNUY1eXJxWkR5ZnRCUmtK?=
 =?utf-8?B?N1FsL2JJT21ycTg1MXpzUlhtSEh4RW13aGtpQnlnelUxSFdzY0MycTJ2aTVM?=
 =?utf-8?B?ZjhjakZpU2Q4cnhEMTEyOThMZ2FLSXZCYTJXMC95dnoyVktUNXhsRVJ4MFkx?=
 =?utf-8?B?UGIwbzkwc3JHSFBFR0Q2aWJHZ3I3R2xWSzFTYkZycHJPMHNjU3FlQUg1OXpx?=
 =?utf-8?B?VVlGSDJqM05DbFhoRmNUOTZHOER4VEExbUR2UWZCVE9neStOdmdzS3R2aHZX?=
 =?utf-8?B?NVR5RzVjR1FMVHRSMnAyTFVLeXV2VVBLRTllUXdYNmg1SjRrQ1dyYVQ0T2F4?=
 =?utf-8?B?TUZZTC8xVkIyOXpmcDlrUEFNMlBBd1JiL3FJWExvOEpoTjhWUVk5MEExdHA5?=
 =?utf-8?B?L2V2dS80R1pSeEEySE92V004eEpzK3VZSklNYi9kdGVRNnUxSVYwRko5N0w5?=
 =?utf-8?B?c1VHdlZySUJUZFFJVTZNemVhNWEybkFLTjQxbjV4bGJRMHdtdzhacDFVYmp3?=
 =?utf-8?B?enhwMHJOYkRNa3NtdXJOKzdra3d3enRTazF5dHdGVmRHTU1CRlV0d1R1RURG?=
 =?utf-8?B?L0IwZEI3bXVLT1lCaVlFU3V0S3c0TmtWL05mWlQxK0dEZ01NTFdZdk9RY2Rh?=
 =?utf-8?Q?HLSXpt7e+Ln23iMb6Vq4LOlu4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecd7690-a89c-430c-0100-08db39c4bf93
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 13:08:59.5367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBqoVn7PR3wCzu8eCVGgix0gOYyaGae3qmRMa1Bs4oHsvbysbgubz0bnSoJkXmJffj24TSlTYx5NLVAjHdbPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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



On 4/9/2023 3:21 PM, Srinivasan Shanmugam wrote:
> Update the existing log with DP LT downspread info:
> 
> [Downstream devices shall support down spreading of the link clock.
> The down-spread amplitude shall either be disabled (0.0%) or up to 0.5%,
> as written by the upstream device to the DOWNSPREAD_CTRL register
> (DPCD 00107h). The modulation frequency range shall be 30 to 33 kHz]
> 
> Besides, fix checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../display/dc/link/protocols/link_dp_training.c   | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index 70fc0ddf2d7e..2d067a4a8517 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -1560,9 +1560,10 @@ bool perform_link_training_with_retries(
>   	j = 0;
>   	while (j < attempts && fail_count < (attempts * 10)) {
>   
> -		DC_LOG_HW_LINK_TRAINING("%s: Beginning link(%d) training attempt %u of %d @ rate(%d) x lane(%d)\n",
> -			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
> -			cur_link_settings.lane_count);
> +		DC_LOG_HW_LINK_TRAINING("%s: Beginning link(%d) training attempt %u of %d @ rate(%d) x lane(%d) @ spread = %x\n",
> +					__func__, link->link_index, (unsigned int)j + 1, attempts,
> +				       cur_link_settings.link_rate, cur_link_settings.lane_count,
> +				       cur_link_settings.link_spread);
>   
>   		dp_enable_link_phy(
>   			link,
> @@ -1640,9 +1641,10 @@ bool perform_link_training_with_retries(
>   				break;
>   		}
>   
> -		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) : fail reason:(%d)\n",
> -			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
> -			cur_link_settings.lane_count, status);
> +		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) @ spread = %x : fail reason:(%d)\n",
> +			       __func__, link->link_index, (unsigned int)j + 1, attempts,
> +			      cur_link_settings.link_rate, cur_link_settings.lane_count,
> +			      cur_link_settings.link_spread, status);
>   
>   		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
>   
> 

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
