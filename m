Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E883DC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 10:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9426B10E61A;
	Tue, 18 Jun 2024 10:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DPckizL2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189CC10E61A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 10:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX7K9Gk5vzJq7DZfWsO9w5MxZVNzu62Dxrfeze18dGrdWf1TWMot2ujN2WaMa4BzLBslHHqsoGaOgym8FCx7wHWfdTce46z+KfQt5Fd3/i1s9VQPTzWOvUyInW3ZGFxUFavCIbU2KLCwiKQdFephWGnZW48ZAtZN/trhmS4SuDni+oxjyowltSUofWdzf1NtzCMmxkAcASd/qE6wtMR2PWZ32GwbN+6syAozOA3dDefs4z03S85tp9VVPiUQRCkR+40OraOPOCgvXmNnZx6pCNll6wVDkr5XmmUerYRtqeyCDM3NmhnpR8OT/GHNhvzA7LXjn9X6GjYOsDtWEJ9H1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQJB3SJcBz0yfBB6hEDytjK3I2MrR06t1smGlwYfayw=;
 b=MQrqwLXtmfupoOFWzc3GfZfNpMiAgnMKmhncWJFdVoTk6YFnUe9sgLAAS0ipAYPzlcb0koQrydgiRvv6jCM7qVtSctR6WNlkhldhaWbSJKJi0Umvc3Ll1/QKpjPwNRgCLwqksOj/faYkuUcfIKd5nkaH65Ps3ayg63ilTuijm3lRnsQLb343GmnG9Ks96TXmYOH8TXIA+5TGpP+cYm8KFRPTsw+cob+oAZlwIf55fSnfFhKKT2XLirWHQ9WJulgm4IJN4XWhMacQG6knTtYZkavXWAQeCJvvzdAbrtD/dbLhs3+2cTIYV8xqMx3bQGy71bVP7vmK9R2AbAVKjo8s5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQJB3SJcBz0yfBB6hEDytjK3I2MrR06t1smGlwYfayw=;
 b=DPckizL2mv5rT+qOAfMv+xp5rX8ijn1kgJbVM2Ckuofibh3mcQ5iggkMQl9gu7DvBaR7KOEgJpPMB7BD8sS0Ubkbohj84S9skZi14vaX8f9oL9/W9t7T60ikbqUOOrvoNw1SKvSvw1OunQVmKJWR7wppGUr1Ksvm85es5tI7NhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 10:10:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:10:23 +0000
Message-ID: <cb616e09-aad2-433a-a7d6-a6a322687d17@amd.com>
Date: Tue, 18 Jun 2024 15:39:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-4-YiPeng.Chai@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240618063359.304293-4-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 552bc148-c9a3-4c26-71ce-08dc8f7edda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG5VWTZVVTc2VG9mSCtxdlkrbjZON2hnUEhwVStvWmRMVmxabkc4MlV0bHdU?=
 =?utf-8?B?a1hQdWlvaG95TElpYnQ4RXhacGZjQkNUMmlhRlNOVTN4VUFMOExCR01mV2tq?=
 =?utf-8?B?SkxtY0crMHBkcStKYmg2Z04vM3RoVzhMTU4vR05LWE5mbnZWMzNwS3lMaEFw?=
 =?utf-8?B?L1hzcGYvOHZvc3JlTi85NkVhcUFTRHBTTHluV2N5eGVVdU0vY01UUEE3aVRQ?=
 =?utf-8?B?WEc4VGp6STRLNHNUNThHTHk3enR3Uml1bDBya3VBQ1QwYXlCRUZlS1lWaU9w?=
 =?utf-8?B?ZzhrcnNRbjVHclJLakNFZDNRK1FWbVA3UmNQdlY5M2c3K0pwKzlDa1J4VGVE?=
 =?utf-8?B?MU1JUjZCS2R3RlhzZmpHWVBaVlZ2VnRVdmREc2s0ZnVmQ3NhQ2hYK1d5YWJm?=
 =?utf-8?B?VUFZUGNNaTdtWUdtV0R2NHRZS05CVUFhYk1jZVdNQmZONFppN2VJUTRKWlpX?=
 =?utf-8?B?U0NaZjVuN3pTanV2Y0Y3Nmp3YWdTWTYzRmU1OEcwL0NLNEFsa2ZIUC85SWhU?=
 =?utf-8?B?Q2VXMkpqWmQvMTZjU3dRNkkycTNLeEkrMGFTb1IvTTU4MTdsY0RLeWhXa3dv?=
 =?utf-8?B?SFRiSUVLR1BSN2hySkF6QkEzMThmSXliSmQ0SlJVV3VrM3piQWNVbmVzK0hZ?=
 =?utf-8?B?VWZOWDMrSU4vNVdOZ09aelk2NUtEMWFSd05SQUlTYjc5VWxqeGMxejV1OHQ2?=
 =?utf-8?B?R213WWY3dCtBU3JNRW9zK2hUMzR3QWJWcXhpSU84cFFaSlg0L0ZyWll4aXRj?=
 =?utf-8?B?MTRmVytNQlZtUmxRQVEwb1lHWkpQb1JIdGhUVnI3eXYrSjZzMVlJRHRUN3c1?=
 =?utf-8?B?djB4aUZXNTV4aHY2T1YzVUF6THlERmFaWDhXdkxDTVRmTWcxbXBOWWdkeEVj?=
 =?utf-8?B?UjROeWJYZDJzS1pJK1VBaXZsaHdlcmpKZUdvZDAzQ1NnWTZHM25XRVcvSmJr?=
 =?utf-8?B?SFZNWE5rcFBCdmU5QS9QeXNjQzFsbjRGOExzZWxUQmtFQnNMV2N6OFJFeHBQ?=
 =?utf-8?B?Mjk4YUxHK2FLMlYrWUZKUS90aklJMHpDV2djamU1VXQrSVdnbjJXK1czL09j?=
 =?utf-8?B?K0NzYVB4K1VyaUV6UE0yaGxjT0ZFSUZlTEtQbmMwMjhUNVNmQSs1NjNVT0Fl?=
 =?utf-8?B?cUIxRE4weUc1eWZYTmJrZG9HTGRYUGZWeUxyVHlBdEo1QzQ0eFkya3IwcEZl?=
 =?utf-8?B?MzZZWGxCRWdNWFFVSHM3cjk2RDZhOXB2dXNUa0NIS1hIR0phU1pFcHRHRngz?=
 =?utf-8?B?OHhZTXNnUi83Z1ZqeXNZZmxyR2JFWDRBWTRpQ2dQZmdBQkl6MXhhUFI0c1Nz?=
 =?utf-8?B?Z3oyU244SDFCbXcvYWtldDMrNmFVY0VKOFltNWxXazJDVCtDWFdMWXcxejVM?=
 =?utf-8?B?V0toVlZZUUVwYUt4ejlMNWR2bHJIZytHaEtxdzVPc1N0Y1QrL212MnRnTFpv?=
 =?utf-8?B?N1EyV2h1UEpkc0FrK2lmWnhvSElOZWJBVDFaVkFKa291T3pYZmJpaXJqUHpa?=
 =?utf-8?B?OWRuRFBqVkh1K1lPeFVTK21DZi8xQXA3RnhkeW12RU9RM0NnVlRNSHBmdnJw?=
 =?utf-8?B?S1FZSGNCbklKdzZxeVRSVXRDak9qN3RkWlhLWHV4SThseHlhOFU1WmMzNzZn?=
 =?utf-8?B?SVd1Mis1RmtWUncyWkE5Q05yZW16eXNqUTVtRFpOakFWWHNQZU9sQ0YvR3lu?=
 =?utf-8?B?U3pVMzQxQ1VMckJWVXZQSFpUSkhmYXYrYnRSMmVxczV1TFhuci9zYm5pY0l5?=
 =?utf-8?Q?e7nTkCowUSVZs0M9p0V9fiufdWiAHc53wX2uPB/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTl5eTNCWVpZZHdGWlprOU5LSGtYMWd0b1htWXhWcTdKNEpqTHAvUmhYN2dD?=
 =?utf-8?B?VTJ6bCtRcUVFWDRqWXlRZzRpRkVoUjVlU3hzV2lWMjNXKytoL2NNTVI0aE5K?=
 =?utf-8?B?ODV2SWM3N3QvTVViNU9xRG1XaHlvOUxEV0xYN0N4eXRFYTYweVJoSzdqbnpT?=
 =?utf-8?B?bGE2UWlaU0hzcUdHM09IOVUxZ3NLQWFlNHJqb0hORml6ZFRUaFkzTzJaRWpY?=
 =?utf-8?B?TlQ5V0RTd1kxYmRHSEd4SExnRFZwYkpMeUI5NEN5WFNZdGZiZE4yL3hqUnhi?=
 =?utf-8?B?ZE1RamI4SEF4N0JPL3BJdHlpd0tOZzNXTkJwU0ZTMFVyYy9qVjkwbG9idE5p?=
 =?utf-8?B?NUlJQVJDR3U0bGhFcEUvbEM0L2Y2S0FuR1A5SXI1YkN0ZG5yYndVWTZVaG44?=
 =?utf-8?B?alhUbkpiUGFEUC9kM2NxLzhEWGZ1VVFpWXdvK29MS1VOVmJtZXlSU0FWRHdh?=
 =?utf-8?B?TFIwSWdYbFVLOFQyRHgxeE5uU2w5QzJzYXppazlrc2Z2cG4yRWVtNUJyZm5p?=
 =?utf-8?B?em1vMks3L0RNM0FCbXpUaDZMYUJDQTZQanVpL3A5SlZnRVh2M2JORC8xUkpv?=
 =?utf-8?B?UE8vcTB5aW53dTA3dVhUWjhWcmRMd1RJYWl2OVQyejMrKzA2WlhlbEhTcjdE?=
 =?utf-8?B?YjRadS9wajBLTUFUekhsaytHMmQvcmdxV3pRWkRJUVBkKzh2blBSRzNhVnpT?=
 =?utf-8?B?RHo0Z3pMUEZWOGY5QXE0NTlqZ0pndUc2bTlRbEJyZXYxU2lQUy9FWlZ5d0pI?=
 =?utf-8?B?YnpXY213eVVBeUxTbGMvS3BuMjVxdVJCdUtWSWJ5VUJMWkloK3pjMjVuMitI?=
 =?utf-8?B?Ylo3Y01qOVhGUi9TZmxleE92MEpuRFlRQW1sUGZjUnFubVM3Y1hNMDdXZVZx?=
 =?utf-8?B?T01NZFlCNE5BODNpZWRpMzhpR081QkwzbUhUUmZQSTM2cW5FVkI0KzRZTnND?=
 =?utf-8?B?UWVsWndId1VxNlRqVExtbmx3K2QrMENQTElWL3FKOHh3QnJSUy9pN2xSRW5V?=
 =?utf-8?B?bGN4K252NXhTK256VmVYTDFxdkNXQXpFcVozWHVobVlob0VVWkF0bVYzUE0v?=
 =?utf-8?B?bFVEcWlPQVBWSXQ4RjhadWZkQnAxYk5mckdNSU5TSi91VUVxY3RIaDBFU01o?=
 =?utf-8?B?VEdraFVZQTNDelo3Nm5wVldVbHRtRWVNclFjZTliMVBrYUx1a3dRdFRCR2dK?=
 =?utf-8?B?QVFWNFFmRkcwTVU5SmVJUU5IWFFkbm5QaWhtUFU1Tk92S1FkVXVGeFVtWkFt?=
 =?utf-8?B?K3BIUWM2a256QWdDTjVyL3ZDRld0Q2hIYW5WUU1KYzhZTlFmR2tXd04xWmow?=
 =?utf-8?B?RENpNXFQUmpyNElUQTZCUG5QVW9aYmtMeFFDcDJDL25ocm42eFdMWTR0b2tS?=
 =?utf-8?B?WlBXTGZSV1NhN3A0bGtKMTNxTW5PL2J6aS9aRDBZM2MwNGFwOU9CNW9XQTlQ?=
 =?utf-8?B?bTRzZVJtTThzSjMxUFM5MzY4Tkh2Tk1lTVViSDFoMGtndCtvaUVzMW5LSkZV?=
 =?utf-8?B?WUlLRGNjUnVKTWYvdmlNMFdPZW96Y2x5NEp6djFaMXhEV2lxQTZ6Q0pXYUFa?=
 =?utf-8?B?STI4dWh3YnNjUlFjYWtmMXBJU29RMjRsQnU4NThyR0greEY0T2phMkhJTjlU?=
 =?utf-8?B?T094a280ZUtyOGtjdUtOL2I2OHRDbDZWbWw2VDZxbzd3NlhmUUN0cjJmNmNn?=
 =?utf-8?B?Y01MU0lmUTZ0aFRGTnYwOHZvaFh1R3lHeE1KVUxWTDE3Nk04RW1YcS9DcHpE?=
 =?utf-8?B?b3F4UXJaVVhBMVRVWGFEK0Fma2dyUnZwakNqak1jcm81eFVVWVZHcnkwTlJ0?=
 =?utf-8?B?QW1DOUJodGFpVDVIendabU9BV1JqSWpKM2lmbysyWHJYTElGa2wxODNBaVl3?=
 =?utf-8?B?SVg0MWRaRE9tV3FiVWQrWXpzUmVSeW0yWitteHRZREZINVcvdUxyTml5Vzhj?=
 =?utf-8?B?a28yZ3RsaVJVbEtBMU5UY21UY2k3RERqdjM0Q21YcVV6ODBEcFZsbVJKZnZq?=
 =?utf-8?B?TFpsVm5TRGZFdVRUbXhGQklkbGFuT016YWhtZjZuaTV1TWJFVHJzOFA0QmVZ?=
 =?utf-8?B?aXhqd2ZGZGZFMHB1emZkbTZmWkRvaTdIb0FzVjhpWm5iRFo2LzVLc2x0MVZ1?=
 =?utf-8?Q?cASxnLMHFZtqTuhoi9owZ5U3x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552bc148-c9a3-4c26-71ce-08dc8f7edda5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 10:10:23.0716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck92iayMX34hlVfnToHue1DWAU3kJgw0ExLgnlmWA2sginMXpZWLM+ULImAUfcKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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



On 6/18/2024 12:03 PM, YiPeng Chai wrote:
> Add completion to wait for ras reset to complete.
> 
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 898889600771..7f8e6ca07957 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
>  
>  #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
>  
> +#define MAX_RAS_RECOVERY_COMPLETION_TIME  120000 //ms
> +
>  enum amdgpu_ras_retire_page_reservation {
>  	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
>  	AMDGPU_RAS_RETIRE_PAGE_PENDING,
> @@ -2518,6 +2520,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>  		atomic_set(&hive->ras_recovery, 0);
>  		amdgpu_put_xgmi_hive(hive);
>  	}
> +
> +	complete_all(&ras->ras_recovery_completion);
>  }
>  
>  /* alloc/realloc bps array */
> @@ -2911,10 +2915,16 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
>  
>  		flush_delayed_work(&con->page_retirement_dwork);
>  
> +		reinit_completion(&con->ras_recovery_completion);
> +
>  		con->gpu_reset_flags |= reset;
>  		amdgpu_ras_reset_gpu(adev);
>  
>  		*gpu_reset = reset;
> +		if (!wait_for_completion_timeout(&con->ras_recovery_completion,
> +				msecs_to_jiffies(MAX_RAS_RECOVERY_COMPLETION_TIME)))
> +			dev_err(adev->dev, "Waiting for GPU to complete ras reset timeout! reset:0x%x\n",
> +				reset);

If a mode-1 reset gets to execute first due to job timeout/hws detect
cases in poison timeout, then the ras handler will never get executed.
Why this wait is required?

Thanks,
Lijo

>  	}
>  
>  	return 0;
> @@ -3041,6 +3051,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>  		}
>  	}
>  
> +	init_completion(&con->ras_recovery_completion);
>  	mutex_init(&con->page_rsv_lock);
>  	INIT_KFIFO(con->poison_fifo);
>  	mutex_init(&con->page_retirement_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 91daf48be03a..b47f03edac87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -537,6 +537,7 @@ struct amdgpu_ras {
>  	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
>  	struct ras_ecc_log_info  umc_ecc_log;
>  	struct delayed_work page_retirement_dwork;
> +	struct completion ras_recovery_completion;
>  
>  	/* Fatal error detected flag */
>  	atomic_t fed;
