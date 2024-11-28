Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C659BD6D25E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 04:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718BD10EC21;
	Thu, 28 Nov 2024 04:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00aAqepW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598CB10E0EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 04:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyArAP20q+9Auogj0fiH1O4QwNH1wydXwrYeKuswt7q+Z8KoDNwvsF00lbZogEzt6BRZd9mxRWDJjyCpsIdXWyfKFR012EUp6r2cpFrHrLotM/6C1jGBUs2sg/11hCpjSuY7TCZPcIAKGSOcg42bcDVICJ807fMllxHbnsGhNH0z1iNK9+0/fkCAPQ24Qu1zlXniwkHS86rSoHIJw9YB4Iiz5ddy0JZGT97lTrEWoDrkxd50kAab9kzI6tDrspWzHye7x/iWcrqdalb0csEa3KYFCg6m1V7rHWh/I5OHymYWErT1c8a17pbHDp4mi3ngr5Qglx54dfS6stDQoZuQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcXMDW1jKbGcJzt+EltZgvq6JYyR5uwnMf/efYB1CGw=;
 b=ZWKsCDiY0NhfmO45VX/k9h36Rl5J0RFIVBmBLy7ZkO7BFYApf1JAgpq3mslBJ36oDnQuXNydfDWECCABkuxrZvTtppa8OdnWYSwlSxUSnAsIQu8p2UyB+REPuUTfM2blVxRp67pW68Z4Aj2oU6yFxyJ/0F+ga2nlv9Z+g6isiOHZWTs7H06+WgAbjew68XtSeR6F+ztQhg2+28pMIDVAz49cMyeAEeddAxzqmIJsVtiPaoTvjXU+D4wxSGPQDre2fJf51jlq9pXP3Qy+aB0GIJLgSsSbNOCMC6N6EohsRq2Uq6gvziczYcQhE8OI2NiJst3GjzQghfUrkvqUSh+8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcXMDW1jKbGcJzt+EltZgvq6JYyR5uwnMf/efYB1CGw=;
 b=00aAqepWMKsdZrYQL+SZgd9zd5bja/6PJ//8MnhjysyjkNjoWopjw5MToUCeMzN9imN76oo4k/uoDUPF1Jndx7MOvN8B5Yiw4Z5qxEFmP3u/xLU2+Z0GtvBpktfSTsuImWodem5Y5tJfxw7NlRjcD45I+0knfKJggjbFwxqpK5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 04:48:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 04:48:15 +0000
Message-ID: <84597352-42b6-437c-a6d2-04f19b54f958@amd.com>
Date: Thu, 28 Nov 2024 10:18:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/amd: Add Suspend/Hibernate notification
 callback support
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20241128032656.2090059-1-superm1@kernel.org>
 <20241128032656.2090059-2-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241128032656.2090059-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: d003b02d-8493-4276-9577-08dd0f67def0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmtBVDN5V1FicFRzTUpvRmNrdXNBNjN0ZXViWTg5cFFpczRtZlBjWDJ0MmhO?=
 =?utf-8?B?eDNjNk80bU5BRjF2eUl0NDc3WDM1U0thOEUwT1kvOXRudmtQWWgzQ29LcXMr?=
 =?utf-8?B?aFphY2M3NEJnaDBhdkJkWHg1NFlHaXFlRHFZaFFtS09sdlkza25SbkhGVmhq?=
 =?utf-8?B?RkVpUHRRMHFEa3pRS282QkZ6TDUvcHNjdzVEN3F1NFhLL1hKR2NMZ1lxNFAw?=
 =?utf-8?B?Tlh5UU50d1AzQ1ZadjlKc1JEYnpEZkF2d2Z2TUM1eVFzK0d2Zlh6OWI5RWZ6?=
 =?utf-8?B?bG1GdUNmZnViNFF5cHVmOXJLSVFvWVZSQjVuTmNzUDlIS2hPbjBtUUJ0WXRB?=
 =?utf-8?B?dU00U3J6dkVqRUZpTlZrdGM1ek81OEhEaWNVZlBDNWYwd1pkc2R6bUtla3dV?=
 =?utf-8?B?VVRXbVI1U0JxTHB6MndJK3FIUVdrU283Z3hlVi9mS01NdjZhZnJKVUU4S3Q5?=
 =?utf-8?B?bjZsd2tNcnd6bG9BVlQwdkFtb1BBdHZuTVJ3NFcvMW1mT3A3NEZQYWwyRTFW?=
 =?utf-8?B?Q0Z0bWxlOFhnVSt0WFFudE5qK3NsTjdwVmhMY3BtaFlaNHNXVnQ5K2NIOUdN?=
 =?utf-8?B?T2xyaWcxLzNGNE5zK2ZxSVJyN0ZuZU9HcHZXZnJDWkpuZDFlMVYyeDE1KzJD?=
 =?utf-8?B?K3hkd1hScEpxRFZocXM5Ui9xZWNlWE5wVEI5K2F5REJWaktzdndWajFWWVQ5?=
 =?utf-8?B?QzFCbW9lQVlYdXQxQnp2b05PdlNBTi84WkJNZWNLRi9yc0dYaUd4cHlUc2lt?=
 =?utf-8?B?dGNiZ2dBTENsNzlvQmVGUmxDOE1ZMlN3Zm9vTDFJTFRNTm1mdDdZOUR3SDg3?=
 =?utf-8?B?SUVVaUJYZGdGRk5UWU9kSkVtZmlRTkJvVXQ1L24zbm53TlMvY1FTYVNodDlO?=
 =?utf-8?B?SEQ4WWxORGx4R3k5bWRKWTBPNEpIUmkzbGUweG9GVVIxaUdCamhaYU9RSFNx?=
 =?utf-8?B?TzBhTVJUaUs4cWk4Qk53enpGTlF0T2JyeDhLd0YxQXIzdFJVbGZIS0NjSGVn?=
 =?utf-8?B?RmxkNEw2SGFwVjVtUWVmclRudFR2eU1sYVBxZUNET3FaTXNXUG9yUkxIcjNt?=
 =?utf-8?B?Y2tyTzlFV0NjcW8zQzV5YXd4OXZHelRlZGNjdkdFbW1JVm5QTGR1MEMrUUEx?=
 =?utf-8?B?WUY1N2owSDZ6VGovQ09CdVBlaCtaZGxOSlo3STUyUVpQZEtwR01Rdm44MGx2?=
 =?utf-8?B?dHN5dFV6a1FCTHRENUVUSG9rdC9ZNjVKT0pSTkZHcjRCbjlUdUlmVThWbGxJ?=
 =?utf-8?B?TkpjQnVJcXU1TmVmbVFENno1ekxKYis4b3hmc21qaVhzNU9ITmZSOVZxMFgv?=
 =?utf-8?B?VHZ1N0QzaVBpVVJjb3ZOZ1Q0UmxSNWRHVUdoaWdGYzgzY3BZUXRsVDdOdjRj?=
 =?utf-8?B?UTl6eDRMSms1L3dCMDQ4V0d6dFNkenRQQVE3c0NHck9xV1dWZnZ2MmNDWVRW?=
 =?utf-8?B?Q2JmQjdKWDIrTmtDamErd3BLVUppQ1o4ZnYrVXI2eldkd1VLMnRvb3hsb2lE?=
 =?utf-8?B?TGRHdDFwUkpuNkxiVlg2dS8rZ2pPRlVNL3MxaWFDb0VUMWNQYlgzMXpTZER4?=
 =?utf-8?B?SDdWZzRwS1h2OUc0Vk96S0RtUTZQeE1rZUp6OUpkVzZTQTExc2QydVlwaGU5?=
 =?utf-8?B?QXgxdUVna01jQ1JiM2hCTGFwMUYxSTZvQ1k0cHNGVG5WVVdkdEY3M1V1ODBv?=
 =?utf-8?B?eG5TRnliL0hUQ29YdTFtNkNpMFdESW9OaFIzdjI0ZjA2RVg3REZyRFVZbFB1?=
 =?utf-8?Q?Mfvb2WSTwnwsgi8W99pHqbBUtHx1D4gkuyvj+z/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUpSYXdrUHpUZmZMTk9MTEN2RGZrRjJJODRiQ1dOSnhDOFpPYXJwYjU0V084?=
 =?utf-8?B?djVaWFRnNHd2NzlUL3hVYkNiZDB2Tk9pTG50VWlMaEJKMVJURGlRWHkwUjVN?=
 =?utf-8?B?aW9SdlMrTjByRHE5WE4rdnJROEJUbGVnQVUvTDdIWlRpWGRiV2EwNXFXYjFt?=
 =?utf-8?B?a0ZWbUZxTDY2M2FzUVdHMGZnWHdNNTYrUlE2UDlUdXJTWHRWQVpQd0M1TXN6?=
 =?utf-8?B?QmpyV3ZaMExENlhVdnRsdnFoRWpCYnZ2ZEdsbVdMd00yTzJvVkNJNk9vckJh?=
 =?utf-8?B?eXpNOTVYOUloV1plOE82cFFmcExHdStTWnZIbzBRQ3lQOGZXK0NTcEZyNFRG?=
 =?utf-8?B?ekFDaVpMRW5aWFBkWWdQNnBMQlBnbmQvWjFyRnJUNmRMeEM5bi8yUmpzdTY4?=
 =?utf-8?B?QjR5N0lXbGJRR1RsMkF0dHlDNWlEUG9CV245Ty9qaXduN1VSeW4rT2w4dVN6?=
 =?utf-8?B?cjAyaHdqVG9kN1NITE9hcDZaRGQ2dmt3WlpKQUVydkUrM3phRk10akEybGZ1?=
 =?utf-8?B?UHMyOENORzBkc1A3MGtxblFGczl1RjJ4UmJSRmZLc1VUQ2NBYTl3cE9YNko4?=
 =?utf-8?B?MkpvM2JqV3FUQitIWWNyczdVUVQ3VStyMG84R2FVbXJuSHhuR1FvU09ObWxJ?=
 =?utf-8?B?bGJjMWJYZi9BTE0zaU4vSURaRTc3TlArai9LU0dSVW5JKzJRZmJyOTVoOFVM?=
 =?utf-8?B?UkF2SnRqSTlkSDNsb3ZrcDZCOXc3cllFL3lEQlppQWFvTmlTS0dXd3d4bS9E?=
 =?utf-8?B?VWN0N0dyQXZ0TlZzeUIrdTlOMVNXd1g0TnlYK1VEcDFLZGExYStqUU9menhX?=
 =?utf-8?B?dmJnank4YVN1cHBPbHdibmp0aW9jbFpqSmxvSjlKdkp2WDZyWlgyWTB6RjBF?=
 =?utf-8?B?QUFCaDBNUUJJaTdOVTJJZzE1c1ZERnZJaEp5d25BaHczMjA2c0NRc0NqTU9K?=
 =?utf-8?B?N0tXNE1EUTNXSjBIQmovWGhLTU9zUkNIL1hKbUVDdjZFbEYzZm1KU2FjZlda?=
 =?utf-8?B?c0VYd0Y4SHFQc1hPQmplb0ZvaGtGUzEzbTQwZFJlN255T29VeloranNESVEr?=
 =?utf-8?B?UmQwSHY4NHJlMk5lUEYwaXBuQjUrUi8yUW5aZFZBWXBEaFNjOG96aDJGYkh2?=
 =?utf-8?B?Y1lGSGZ1UFYvSzZIU0Q3cnd6ZzFlNEZ4OVpVdjYrS3BmNDltYW04WHFwcVkw?=
 =?utf-8?B?ZlB4bnczSEdlU0VMZUlvQTJwN0plQ2dLMkJIdnEvSHRobmdsc1IrT1B4STMv?=
 =?utf-8?B?T2Rwd0xPUGlZMmVvV0g4TFcxaE5UcHkzSjlWNWNoczhNWUFqU3BEekdScWRx?=
 =?utf-8?B?MzU2VWs5KzVpR3RNMVlQSWNkY1BxQTNHbHcwVEcwTHNYMFJGL0NXdVVoRnVa?=
 =?utf-8?B?ZnoyUEpuMWJhRWNxSk8waG14dkhDUE8vaFErWHFCTzNzcHM2Qk1acGNWRk95?=
 =?utf-8?B?ejV3SnNzZ3RMNjUxdWV5ZHVLOEFtditHZEhMcC9Xb3RGMGF2angwc0pqbVR5?=
 =?utf-8?B?OURzaWovQTVYMGNrM1JLaHMvOXhMTDZWU2pwbEdiQlRjTWZ6SEtoTmtZdGFm?=
 =?utf-8?B?bEZ3ejAzVk96YjhIVWl2NTJsTnVzQURFdEhSMElZamJ6UGp3aTY2S0h2WjFl?=
 =?utf-8?B?UlkyaHZ3cjV4eXhOOGMweGlmNmJPVFRpNkZvcnhyV0V4NlZVUEJSeTNrQVJz?=
 =?utf-8?B?ZFQ2QTdZLy92SllWL2pBTloweER0U1pXSU9sdmZ4RWVCQTZ0Z0djcFpzS1RS?=
 =?utf-8?B?Q2cwRnJFMEsrNkhZWGlidXY3ZVZmNDBPWDEraUVRaEU3ZmpScFdSUTF5K0dm?=
 =?utf-8?B?dzJDSlNQcnJkekdIWVNsZm9OOXJQNXc3dW1CcFVvYlBEbVEvN1A1WUlhYklj?=
 =?utf-8?B?RGhORWg5S09sK0xHanJrTTIxZERJMGo2ZzMxZ1JMNVM4NEpNeE1rZE1DbEtR?=
 =?utf-8?B?ekZFTFdsMUJqZnNrV3N1WUlPZjBpeElBSHlIM00vRy9CRWQzdnIxS3dDS3Bt?=
 =?utf-8?B?d1JIbzFVd0E0N2JEN0R3U24weTBRbWJ2YlZDL1pWVXJpdk5hbEVFdlhzRXNE?=
 =?utf-8?B?Nk9KNFJaMzI5Y0daQUxFQlhFNEpCbU44N21zSDJsVFZvUW9hYUNyR1J1Zmlj?=
 =?utf-8?Q?K5It/3uqiKyTpjRKHRvUd2A2l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d003b02d-8493-4276-9577-08dd0f67def0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 04:48:15.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqyhe/LrKZWsJ0yJ+eiEXXbE1UjKfm30w8oQBq8WSa0UK1jE7G4/RSLi0FNRWfNQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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



On 11/28/2024 8:56 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
> In order to make suspend/resume more reliable we moved this into
> the pmops prepare() callback so that the suspend sequence would fail
> but the system could remain operational under high memory usage suspend.
> 
> Another class of issues exist though where due to memory fragementation
> there isn't a large enough contiguous space and swap isn't accessible.
> 
> Add support for a suspend/hibernate notification callback that could
> evict VRAM before tasks are frozen. This should allow paging out to swap
> if necessary.
> 
> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v5:
>  * Keep s4 set all the way through prepare.
> v4:
>  * Make non fatal, drop patch 3
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 -
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d8bc6da500161..79ec4ab8ecfc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -879,6 +879,7 @@ struct amdgpu_device {
>  	bool				need_swiotlb;
>  	bool				accel_working;
>  	struct notifier_block		acpi_nb;
> +	struct notifier_block		pm_nb;
>  	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>  	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>  	struct debugfs_blob_wrapper     debugfs_discovery_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 996e9c78384dd..dc6abeba61948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -191,6 +191,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>  }
>  
>  static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data);
>  
>  /**
>   * DOC: pcie_replay_count
> @@ -4553,6 +4555,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	amdgpu_device_check_iommu_direct_map(adev);
>  
> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
> +	r = register_pm_notifier(&adev->pm_nb);
> +	if (r)
> +		goto failed;
> +
>  	return 0;
>  
>  release_ras_con:
> @@ -4617,6 +4624,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  		drain_workqueue(adev->mman.bdev.wq);
>  	adev->shutdown = true;
>  
> +	unregister_pm_notifier(&adev->pm_nb);
> +
>  	/* make sure IB test finished before entering exclusive mode
>  	 * to avoid preemption on IB test
>  	 */
> @@ -4748,6 +4757,41 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>  /*
>   * Suspend & resume.
>   */
> +/**
> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
> + * @nb: notifier block
> + * @mode: suspend mode
> + * @data: data
> + *
> + * This function is called when the system is about to suspend or hibernate.
> + * It is used to evict resources from the device before the system goes to
> + * sleep while there is still access to swap.
> + */
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data)
> +{
> +	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> +	int r;
> +
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +		adev->in_s4 = true;
> +		fallthrough;
> +	case PM_SUSPEND_PREPARE:
> +		r = amdgpu_device_evict_resources(adev);
> +		/*
> +		 * This is considered non-fatal at this time because
> +		 * amdgpu_device_prepare() will also fatally evict resources.
> +		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> +		 */
> +		if (r)
> +			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * amdgpu_device_prepare - prepare for device suspend
>   *
> @@ -4787,7 +4831,7 @@ int amdgpu_device_prepare(struct drm_device *dev)
>  	return 0;
>  
>  unprepare:
> -	adev->in_s0ix = adev->in_s3 = false;
> +	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 38686203bea63..5e5ab0b2a7196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2552,7 +2552,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  	int r;
>  
> -	adev->in_s4 = true;
>  	r = amdgpu_device_suspend(drm_dev, true);
>  	adev->in_s4 = false;
>  	if (r)

