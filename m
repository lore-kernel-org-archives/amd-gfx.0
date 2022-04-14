Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 14:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0FC10E0EC;
	Thu, 14 Apr 2022 14:52:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE79410E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 14:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl/uWklOCX7mppgISIV3Slwp3Pgf+9xFjsUxEPvNNcFO8O/rnHx/RkUsH/Bsur2qLPRg7FLi7jguj1w7H7v1GOle7zAOpON18ooOO3Ykzl3Uu5TzeEjj2yxAQ8zc8fTe/d3eBc9PPh71NbxxpIHquVtw3FlQdQJME0/wOdOezpEXf+5mGca1LV12LajdLpUWDm5uhDFfYtKBKV/N382kCd9SZkOw79rWejQe8D/hcIpueZZNuzg/jZo0RBCAXwDqvdFn3QmhWkAiB4gLpu1UqXBqkY1CwD/+81IJPN7g1RK5wAVX3JtVUKPUMxbinbpl/l9cReW/0j4XYwC9qflbZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V27uAmi6icZltoS67xZwJYL5f2Wj2hdCGtRa0DUPbY=;
 b=eznRq+wigbCfehDiJoI6yqxUFWp3U9rVmmZmd02sSclYxHU7y/SS/HwxmFbQP+hyzggMBgg5wdPAlFDLgotn+i1+C0vZDUe7q+9FtulT7C6sh2667gBV38HuqKjfdnatIEcOC4C3dh1by4W41aValBOMZg56zozBPI/KXh9jbNrMA2A7KvuLiz6+dCzu8IxbeYohbDvvCzyOu48B3bCekCR9gDXNue6ux0WLKA6vKXaG8lzOdl2opWmxgqYNj7fuUI8KBsRIs118xAMeA5FVPL5cUvzjYvJ6xFyACoZ2SEaL/olC1l9PohEcrbOVWl4Da+zz3dvuLXuRfFaWHH3Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V27uAmi6icZltoS67xZwJYL5f2Wj2hdCGtRa0DUPbY=;
 b=Is/GAn+H5e2Tyye1rGSxKWfUEwiMAJT4yL6es6zvdiIHdSK6+SOe8Sl0MmqRifolrGDeNP/E8sBakQ/jJWKFAcL5w8taEEErg0c7vLVJUJ4UZVdSHDjVGrt7/aXp055PtgQCJZOAgyfTzL5xyU/Y2idWnnYHXCBNyuceQk+CD/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3820.namprd12.prod.outlook.com (2603:10b6:5:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 14:52:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 14:52:02 +0000
Message-ID: <e9eb2603-4997-30e1-ce2a-bd3ae0bec7e1@amd.com>
Date: Thu, 14 Apr 2022 10:52:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Content-Language: en-US
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220413155145.861750-1-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220413155145.861750-1-david.yatsin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e1ae10d-b079-4948-3f70-08da1e2655fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3820:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38205CB384B81E7AB8338AF192EF9@DM6PR12MB3820.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKayFiQJhSn9dQkM2Pfvn7sIo6v2OrLUoWoqdg1SlHoywSQFOxa1Az+CTTsZRgJARQW8kG6TBnjMA1hpeec0HJvyYfEpFVnng51JezJOi1kr8krpVuu9cGpp3usAZpZ680yzRrpC+Ft1LccLzzeXdl3YW2TxU9GJSBwXESWV4ZzeNm25LlObFxptYU2nE3IG+EcC9cSVaZ95w9WdAj6PezMzlDo7GfPMlXbK3AcoL2cGrFr0Wg/WMWh/LsXUiMCNl/bo5tvLNK9fSpGG0JNSpHz3K0jsMTnr/jEDenu+CIkF+gcJCNqnINeHssTDcFa0zUhYE4Sj17TkJgpVC41KE7La7q0Uo+eK/F53MibGgu1LWeBHkztZfJ33rC+To+iDB1Vr8G9M9SvNWaXke0lNJsVZdgXZ22Ne3bRcqasbg4Ayxc0iZpUkSVHSHDJUTdgEvynWPlxv9QXIKn0sgXlgkmpMo1rYeghBC3WGOd7A+Ahz2iHg+eYzQW9LYUtK5IQcA2FCcSQuRLHVodBo4IE3iv2tUwucIr8XV9ZhZ/BXNbgR/kdbGqVOy0rPwCC7/5H2kPCMvG3/MrBpRFh8JD5tDObgsKZmOJ+wBnDtXmL+nKdWpGQBbHqAJFg/Ue3HXgR0RLIUQ2FXCg89qCKaD/rhGPLLnC2f/yedx+C+hlfBT1czq+9XhnOJXmfhYTxDNR9rF9Lab5RlpFGGm777KOMXhFOlRLufG67Kf9+omM1le9RJzgsFZPMxkBL0IEYSY18/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(8676002)(31696002)(31686004)(66556008)(66476007)(66946007)(6486002)(316002)(6506007)(86362001)(6512007)(2616005)(83380400001)(36756003)(8936002)(26005)(186003)(2906002)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BjQXhBSVVnamV6MWtYZndQUjR5OHA3clpZcThGTGRaVkVKTGh3ZVdFQXBT?=
 =?utf-8?B?a0lPUFJzR0FRajhNUHZsb2ptb1pUVi8vTG9GdmsxYkhBMkZKbkFzUWNhTzVJ?=
 =?utf-8?B?NGEyeStLVXJWSmlGaGNLeVRHY2FZUnRRNXMySWI0MGFROG43d3NLYzJGU0lx?=
 =?utf-8?B?bEJaMDlxTldjVFVZN1VDUzNPdm9ZQnJKTFpERnhBNHd6WjdleEQ1dU1VL3Nn?=
 =?utf-8?B?dEpabE5SM2RxeEZ2L0tzMHFvbmNtTDJaNldoSFVzK2FueUdiTVdWRzZVd0RM?=
 =?utf-8?B?ZThsNm1Ba1pSOXZPQzdLNGxYWUpzRTRVdXptd0k2T3NCU1JLZG5ZMTBGdm1m?=
 =?utf-8?B?cDFZUU5tWFVnVEw0NkcyeTlFY0tKWGFXTUdYOXFBMlpCeDlwSXE0TG1ua2xC?=
 =?utf-8?B?OEdBdDY2YmtyWVg1cHRZSmtIaFFhbkNmd0w1eXcvVDY0QWEzODJOL2ZjZnly?=
 =?utf-8?B?amdEQ0JEN2JTM0QvdjZDdm9naUdoOHNvekZjcS9IemxRWXBGN1dkK3ozWUxx?=
 =?utf-8?B?ZVVGRVpPQ01DemxRTDNEUGlHY0g5eWpPd3VRcEtrZ2NLQmIwbmFaY1NYSW95?=
 =?utf-8?B?WDdlaFp6SkoxQW9qUWRaOUlCUHlvNkRuSysxUjh4QmJtQnNrVVBXb3JlRnhD?=
 =?utf-8?B?RGRyaldUMVp5SWtGUzRpWjBYL254WkRadkx4bWZJQjJ4UVNMVXlGRWowM0o3?=
 =?utf-8?B?NlpuSzkyc2tndnhsRDllRU1BVEtybERqcGRUVHJaQUdkQXlJdEpzWTUwckRG?=
 =?utf-8?B?Ri9nSWdsSHlUdXJoYmNUWGVDR3ZJb3VnQVVrbWxaZlVtNXNZSHVJS2QzcWg0?=
 =?utf-8?B?N1hTUVRWWFhrM2hBWTdaTFpBTlB1bnJ2Rmo5dDM4ckluTlJQSzB1NTcwcGhN?=
 =?utf-8?B?ZWZVUXhlSkJ4OXRUUHNzOTZBZzFuMWQrVkxTK1FnTmhzYkM1eHdVRFRKS2lV?=
 =?utf-8?B?eUZzN3pvMWl1QUk5Z2Z2c3hEbHg2SDN4cHVqemtjNUNIVVNhRzh1NURzL0JC?=
 =?utf-8?B?RHZTclNwUm1VaXdrUW55ZDlIQUFKRC9obnNWWkxzY09UY2R6QkVvREtITnB3?=
 =?utf-8?B?R0VLWWJhSnJxSEF3TEw2VnY1YVR5dGlXS2Y5NTM3ckNpR3BrZkJKeFFuL1k5?=
 =?utf-8?B?RUNCQmxyNW8rVVcwY09BYUlXOGF2RXZMVTVIVW01MU8xSUtUSFdqQ3N6eTVy?=
 =?utf-8?B?Y2ZmM2c5aTFGRjdqYnBwVldYRTN0L2tJZGpraDFVNi96NVVaS1JVVlgwMnQv?=
 =?utf-8?B?aXZQL21xS011dnNYamo0OGVNOWw0ZTNmbVhOTm9qRHVQL1lzb0tDK2JoenBW?=
 =?utf-8?B?ay9TTXYvaWpOdkp5RnIrSTAxVkNUanIzR3N4dnVLVjAzVUhDeFQyMU1CNFV6?=
 =?utf-8?B?K1lNNm9NbmU2Y3JqOFNNRy8rK2pwZjNlOHBRZkQ1WVo0c2lqTHRVUG56bnRE?=
 =?utf-8?B?Mm1keUFTQTJVQjRlSm14bENudEhEdEtHcTZ0VVV4bzg5aFc0ays3eG43VzNw?=
 =?utf-8?B?UVNISHE1cDZVbDFOenRmNnU3ZWQ2NXp3dWtTdHpZMVl0RUtiakJHeGF1NG0r?=
 =?utf-8?B?U0RTQm1sZkhEZlNGY0JPelFYUzdEZkthQWZsQnF2MWhLcVhCVFZWeThGbWRP?=
 =?utf-8?B?akpQZDVlajluR2VZMXk3VS9DbzFPd256a3oyZjV6clZZMXU1U040aVdrd1My?=
 =?utf-8?B?bEdId3l6cUxYMUpESUdFWFNmSWNmT2pocnlJejhHc2NLaWpnQll1Zk9lK09T?=
 =?utf-8?B?dXdaZEk1Z1BUNHNONm5DaUdxY2ZyTjc3VHhRV0RndlRZU0E3Y21INkdXVHdP?=
 =?utf-8?B?TnZwS1VEZ0o3c3lFYVU3aThYb2krNGxZMitVKzVwTERVSjNSTUN5WHJ6M2c3?=
 =?utf-8?B?M0FTaDdrczFPL2E3aENvTmYyRjNzckg5VlBCeC8ycm40SlE5WlRhcUZSeVZS?=
 =?utf-8?B?L0lCQ2FEZW1JM0ErY0ZXT0kzRWw5eWRFelVRTEF0My80NC9qSDZQNzJDOUVs?=
 =?utf-8?B?K29CdW80bmk2RlZodEhndjROKzFTZnBSdGZLR1IvU1R2ektwTFFIZVBLdlBu?=
 =?utf-8?B?aTVBSVRpN1ZQRG41M3FyTkg2cWV6bGVHcC9aRVRheDVmbTFTUGFLMHZxUUEz?=
 =?utf-8?B?eTF2Vmk3aGw2djY4S0xmZW4zSDhoL0VxWVNGRDBLditwUStyL0tBMW9HZ0xz?=
 =?utf-8?B?N25uY0dZVmwzYUx2OWhrY0gxQ0tNNGh3UWdUK0tTKy9KUjdhbUQ5U2NhMFRP?=
 =?utf-8?B?YmQvWWNEY1BCNFhZRnZ4eWtwM3NQMndLUW8zUDlSUXBXSlpUd3owZVR5RXgy?=
 =?utf-8?B?ZHVxaVRGd083NHFyUGFldDhkUnl1eEdqeUVHZmRmY0o1OG5XV2NFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1ae10d-b079-4948-3f70-08da1e2655fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:52:02.7715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8vgJmHSwKjXoSzhu3z6msFJsaX0zgLIWHKV9chntBzMT7Tum7wRXx1jLR/jbLuwctWGcs+QCLg9bbqE7nRQPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
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


Am 2022-04-13 um 11:51 schrieb David Yat Sin:
> Queue can be inactive during process termination. This would cause
> dqm->gws_queue_count to not be decremented. There can only be 1 GWS
> queue per device process so moving the logic out of loop.
>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index acf4f7975850..7c107b88d944 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1945,17 +1945,17 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>   			deallocate_sdma_queue(dqm, q);
>   
> -		if (q->properties.is_active) {
> +		if (q->properties.is_active)
>   			decrement_queue_count(dqm, q->properties.type);
> -			if (q->properties.is_gws) {
> -				dqm->gws_queue_count--;
> -				qpd->mapped_gws_queue = false;
> -			}
> -		}

This looks like the original intention was to decrement the counter for 
inactive GWS queues. This makes sense because this counter is used to 
determine whether the runlist is oversubscribed. Inactive queues are not 
in the runlist, so they should not be counted.

I see that the counter is updated when queues are activated and 
deactivated in update_queue. So IMO this patch is both incorrect and 
unnecessary. Did you see an actual problem with the GWS counter during 
process termination? If so, I'd like to know more to understand the root 
cause.

Regards,
   Felix


>   
>   		dqm->total_queue_count--;
>   	}
>   
> +	if (qpd->mapped_gws_queue) {
> +		dqm->gws_queue_count--;
> +		qpd->mapped_gws_queue = false;
> +	}
> +
>   	/* Unregister process */
>   	list_for_each_entry_safe(cur, next_dpn, &dqm->queues, list) {
>   		if (qpd == cur->qpd) {
