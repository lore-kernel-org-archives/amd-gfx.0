Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB6BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DAF10EAE5;
	Fri, 11 Feb 2022 18:12:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D2A10EAE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8ByD0bbHWopvkdBss2P0KAKAmRzvbGySY4rS191q4TZyPhHcyvyanGxoGeYR4UJt03opZ1lTSbM45vbAiEaNgK2mGD74+yxzwB39Qit6QtTePu/0h3jVKAA8G4puDUlxuPFxcVU9whsC++Nigrxde6hZcZMhuy89V4/dLVE/BzcbVCnrHOh0qmNzyiW+2m1J8oHFaCEYx8wYAjRrf0RpFzQdzllAWbQfE475rDEvhjRbQ2O1VRa4x/eTpfcyRzP6oflk9S9SIj4APMJCCWUJ2WIET/9DI3qzmvqOGfhd1DKQtl86HFB2YDqxat04Iq153115jRm6sE3/CC44clwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YTbb+Og6gy+Paur2F5le50vOR+1FoVLjpbqUJRq0Zk=;
 b=V6cnqmWpvF+EmUy/cWWVBM9tWQroMwiOq78I0MtwbxApSR3kLSrF0yst9zCduLIv5ThZvfNkKx3+X3CvKF5eDi3TZt52eIYiEwamiQ0vQ/d/QTBip69ioEt2clw7C3vBcCZ9pYYBPJgiKar9q8bS1hzjQ/y4G/YoLHMRtf5ffV7kCL+3BPeup2LrkKsz98uLCFJWJycfogmiiYFWb82iOADihuJhl1J7BSWB3vI+lq1EzFV4w2vJXtXHlnQt2D+sXdz0PAEY2PcKAJCiDXwvzRovZDY5bziGWS2GlmWKY6wQ1iesvQc665lHTd9fO47L9njJjSsrWLj07rJwLaGaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YTbb+Og6gy+Paur2F5le50vOR+1FoVLjpbqUJRq0Zk=;
 b=oXG9wP2yNocWc2SaapMg0pMCv/v3KdSWIbOpleDYnF8NyBmr1z6/ho+F9OPELX++lftoZsRX5WyflAyznVQGhnIhM8CbsLArpC9qEQg4TdJRom6hTz9Wb4mi+BO2AREM8U/1ubA1KHzipMdmyhZmLDmB0wbf48qafqGJDQYplQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB3906.namprd12.prod.outlook.com (2603:10b6:a03:1a9::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 18:12:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 18:12:17 +0000
Message-ID: <8f5a1065-86eb-96b6-0e4d-776d4028d43d@amd.com>
Date: Fri, 11 Feb 2022 13:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: Fix prototype warning for get_process_num_bos
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220211043035.13284-1-rajneesh.bhardwaj@amd.com>
 <20220211043035.13284-2-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220211043035.13284-2-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94efe004-65c0-4bbe-5ead-08d9ed8a0988
X-MS-TrafficTypeDiagnostic: BY5PR12MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB390692B41C536575158AD84892309@BY5PR12MB3906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/R0lRMHsKGvt/1kbMbnOd9o4phEmI1h/suqNiRSRNZw4QCFcDGlh7MBWczs7Bt5FfdaNVR6APPS/FvZhdpmHbO5pL2IPqZCMd9b9wp0LIRIq5rj8B88giBsrUsCXeeV2YfHgSS2MYeKezRed6uVPTEVWF6Z15sAjAZZ8bC/1bXg2+Z0nTlQgFxb3zcaC5feYDeIwCHJDWFmYov29Qty5HMg1vjh4aHlEcnBxO3OqzdYj9WzCE9ayAZP0sjfj05iKNGGrTHWb0pU+EbvzYt7F1Rp5iIxezWmVLU8vh46H/2AIlnFJgQmmRYjV9l1bLSPRrtUg7Umv+ZPWclKdb79Cwabxl6JqRnJRnMyDF2Ava7oUOqkFcoo5zVRcG0sWB75MfXJl0SDOguO075uS0YSueVApPamcQ+4j1iVXM+3ZBCo18MKstli50dqFMX0FaQ6xwdbDecQ4M/XYVXpQTaTI1Ee8t/FpcFFtFArLT3Zre6kX2Hz/MGi1gC2RuAgDSE5ndU0BNAC6HgHN7mY2Znvrcyw0RPhx2KPtkfEcIlAhTET5saHQdI5v+Lb5SEGCKJM7F/e9Y0vzEVaekmwekfI37Y3cLcokhE7KKJ0Ghn5C6+plYXTI6BabA5Fkci8KvREVPcupU0Ik06/bJmE1ubunrw1/H1b7W4ToI+kTWRIabUtvSSPYYyijnxwuuxGdmADrFBh2l69NxNrD9XsPfuS0lvJCg8cq3TCwsbRQZVkh4oRAfewj6Gfu3qFVQd3VXkD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(38100700002)(83380400001)(26005)(8936002)(4744005)(66556008)(5660300002)(8676002)(66476007)(66946007)(2906002)(316002)(44832011)(6506007)(508600001)(31696002)(2616005)(6512007)(6486002)(36756003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFXenpmQ2Z3aTd3NnArTms4Mm1MbGhrOUgzRit5WGxjMXNwWStvRFFmUDJX?=
 =?utf-8?B?VjFUdnpqUkx5cWF6ZnhITVZGUTBwcVlKVEFqd1d5VHRQYXF2MjdielBZOVQv?=
 =?utf-8?B?U0xRNVVONi9vMWNPV0FBRERpWFRJd3l5ZW9NOGtyblJvek5YcWc2V3FGSG5w?=
 =?utf-8?B?LzY1VmVCOVFCZlo2MllobzBBYlVTaXJOUm9jaFJtY1ZWREZWTGxrOGU3dG1S?=
 =?utf-8?B?QmlKUDdPa29jbHNCeUp3eGF5REJzVVM3TndDcUFUd3ZlalMzbWFFazNHUUhq?=
 =?utf-8?B?eWNST2FXdTVoeUdQMWxNYkQ1Q0RFdEJTOFFqNHpoajQrbmdTemFvNE1rcXZy?=
 =?utf-8?B?UXYvajhFbjNGcU83UUszSTladDZ4V2J3TTRXTmpjQVdBSG1DSzFndE1CdDZB?=
 =?utf-8?B?SXowUC8zSytkNE5ndHJ1VCtGZEEwSE9tRUJIaVFSZW8zOFRZcE04alNVbDJ6?=
 =?utf-8?B?bW9GQlhFdDJFZkRpQU1aQnhWWXI4aTM0K1RxajJjZHVhWXRRZDkvTWk2QWx1?=
 =?utf-8?B?SWo3dG44VVNVeW1WZVdCWWJwajgrdDZtSGNTVnp4Sy9icTVHV3lURHNjK3lH?=
 =?utf-8?B?MzZCV1g0aVhwcjNlMFh2SlByMWJVa1VQNFRYQ2FkV2d1NTJKMm9DMHAza1gv?=
 =?utf-8?B?VjlRVjdzcUF5d1g0alZreHZQUkRaUXpXZUkxYmFHQzd4VmNEZjYwVmxmNjB1?=
 =?utf-8?B?Q2M5MnYzNE5oWGpQQ3VwZDhKM09leXhmVEU1VlE4MmNxTmEvNkdqc0VlOXJs?=
 =?utf-8?B?ZUVZNlRMamNFSTE5ZGE1cFNwTzRGM285UmlJWmphNTBVNnhVR2dLeG5STGRw?=
 =?utf-8?B?dEpKL2NySW4xTzlrN25NTitBeFI5dncxSnNYWHlOL2xDUHpDNjVCM1A3Sk8v?=
 =?utf-8?B?azZ4U3NJK2ZDZnRWRC95a3B6UUFCN2VpbUpvQXNRWi9iUUZuU05aMENxUi9U?=
 =?utf-8?B?OXlTazdYdUJVc1lyaG1TR3Nrc01POTYweUM5eHlPVGVlekxqeitjVldObEVq?=
 =?utf-8?B?TUpsZVNPU3V4TWNTQW5VR1dWK0VmOVhockI1bHQxVmpNWHJDWENDL2d3eVFV?=
 =?utf-8?B?eU96ZHQ5b2NxNXlueUxQOFJHaFpDdk5KOURpckFxQ21Qa01MVHdmeVJZdUEw?=
 =?utf-8?B?Z05ybHkrakZRUFpXVzg4emZVYkhncWJET3BIMjNnSVlUUVVEMHNOcitiUHJ2?=
 =?utf-8?B?K2VncnNxbnNuaGZhRzdMMmw4aUw0TGF2OWhBMThZS3A2bEZNUzNrTGNLMTlK?=
 =?utf-8?B?aDZxcWhadGRvODd2MC8zWEJxcU5scHluc0ZmYlJvRzJHN1NIMUppMUZDNEJi?=
 =?utf-8?B?UVJpK3A4MVRCci9LM2R6aVpvWXE4emhtc3FmWmc1cERIQnRWeStXYmVCT0Fx?=
 =?utf-8?B?R2pqZ2VWK0JhdktPNFBEL1llcG9ZSUVGSzA4b0k5U2dpelZxd201Z1dJaEJY?=
 =?utf-8?B?V2U3aTJ0dUFkc0p4SmRRYkdLUXcybE81UnZJSS9zOUd6REp5Z2FRSGhnSmQ5?=
 =?utf-8?B?aTRnTVdVWWIvd1U4QjZBQnpxOGtqZmc5cXdyS1BsaW1zOFd6SXBseEdiVklo?=
 =?utf-8?B?TDZya25DeVluLzZrd0h6Q0RQVU9qaWRtU3VNcFV4dm5UQkZiNlBna1grM1dl?=
 =?utf-8?B?b1RmcTZiRzFoNXc2WFFLUXZyZ2ZKcjlVK0NncC80L3hlUFpUc05uZmRPY1ll?=
 =?utf-8?B?YWc2UWJiL0FlejdzZHR5WlQxRFZVOEg1cmVZaVNFVDRsVi9QcG80RVFrVEt1?=
 =?utf-8?B?ZUQzRXNVOWE3KzZVUGZPSWN5MERPV2huUHhtSHY0Tzk3YlZBclppQTlmcXZB?=
 =?utf-8?B?ZjN6MWowa1BlVFNtRkFXQnlEdmNKWm9EZXhNVlNTSE1JZkpLZGtNZXJHaWl2?=
 =?utf-8?B?dHNadE5zSm4yNTZid0FOOTBBS3NpRHJTQmgveVRlV3QreUlDOEZacVVldUpn?=
 =?utf-8?B?cmYzZWlxaXFyRDBKUzd6UzYzMnhiNEpxWE5ZZjd4NmdJMDlOZ1FtZkM2WWlI?=
 =?utf-8?B?elRYVDdVbk96NjFUbFBFSWhTUG51U3Bpc0RCYjI3VC9VTUhUZ1JHNjRHVWc3?=
 =?utf-8?B?SXpJc0lwZHVwNGZ5cUszU3pGaEtTMlRXWTlUOWYvcGlKZDVKbUVBQXJEYU55?=
 =?utf-8?B?QUF4Z1RrVGozaEpmcXIxODQ4d0Jhd0JCcldTckh3VWRhUWRodWlJVWRrWmR5?=
 =?utf-8?Q?YeT0XugggYNSCFWZacqRQsE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94efe004-65c0-4bbe-5ead-08d9ed8a0988
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:12:17.1920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tM8KGVLDl5idRPCxy55hSYY6RDpTGtu4CZyh6anfuml6sie6SsolL1/iQPLLiyOO4JW+Quwk2cBcZmbKcI5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3906
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

Am 2022-02-10 um 23:30 schrieb Rajneesh Bhardwaj:
> Fix the warning: no previous prototype for 'get_process_num_bos'
> [-Wmissing-prototypes]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index d5699aa79578..54d997f304b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1648,7 +1648,7 @@ static int criu_checkpoint_devices(struct kfd_process *p,
>   	return ret;
>   }
>   
> -uint32_t get_process_num_bos(struct kfd_process *p)
> +static uint32_t get_process_num_bos(struct kfd_process *p)
>   {
>   	uint32_t num_of_bos = 0;
>   	int i;
