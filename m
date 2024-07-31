Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE395C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 15:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90EB210E669;
	Wed, 31 Jul 2024 15:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEq8bhZm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D71C10E669
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 15:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJjw87GjRZ3ANsG6Sl+f377Sr1Gh3COo9ZrmkEg7Jzpxa6CzFkx05SpDPCBwsMrQnybYUjTI/Iq0ppF+c6k+tBr8GHbmkZ75cqM0qrZL/yV59mi5LreC51B9owWOx7+Q6zjYas6gfjTSbbGvvy5UsSH0dmn9Rmns3ywqz4ylkWDU6lJ7aJOqRd+oinPfaxDhAYFlEZQ6siaz23grcgVObRs9EtR1iNfGEmJudt1VSr9fw7/a5w8trsfZmc3ZTUID/e7DrPoqMrsmnWEXFXEQl9TRHpgVf85n/l8qitYubXia5uxzNUtYemcDuGsbanIehZHBYjGG/XutfsHks69J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGBS7FVLdCXxG5BZnqq4mEc0raMnxaQBkhA6v4hX8+8=;
 b=x0CL47fOb+Dbh731QvQq3fBBamsjHhmXFJYxd9aAI28VMzRZJRTWaK/hqyoRl7aj7ou4/yPdOXJL+gcMexy8Wp9xqgmoUb/WKSKRocX8biD9xKIMH9hR8YCGyyMcuaMJksIJSNypm8eckDlmo3VxQXZqWLyEYkR4U51VFBxGNYU2LcHvLP5G+aMiD2PMsqzYDOc0gDkhIgGVK6mG/zQpyKvvv3c9OyNR62kZz/9tMClJ1dD9GTchZRBcNQX4IDDX5s0IIEI0Vzc6VMtkxl5Yve1ATFMMsT0sAemj9o2CjAoNr1pURLdCQZ5qQsWRSNOxkogVE47Dr9z4WRQtr2dhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGBS7FVLdCXxG5BZnqq4mEc0raMnxaQBkhA6v4hX8+8=;
 b=bEq8bhZm2rxdAlKF+FIt18bj5S+INUcmlN54LDhVtwAvOiPUCZqfRgCYoluazrB41WNPihAag6smCmtG2Z8fo1cqG9AYUA/yvUIUECtLpVfeMFFyKTkmyYbCRqGFG+vAB5hP3MHqg9l51tmvW4Dkiw/N7suYXov1eQrMqpv/Xok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 15:44:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 15:44:37 +0000
Message-ID: <80c4c0c0-6876-4ffe-acd8-792aaeb7b01b@amd.com>
Date: Wed, 31 Jul 2024 11:44:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: support per-queue reset on gfx9
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240731133715.1539633-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240731133715.1539633-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd87075-429b-4dc2-4667-08dcb177aee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVlaa1hvdG8rKzIxUFBNTGJnV3E4cktTa2dMak1zUllYN3NIWlNwMW1BSnJu?=
 =?utf-8?B?U2RlNExJbzJ3bXduSHNJMzdsdTJydWJ3NG5GK3NaVTE3V21DYVNlSktoUmJF?=
 =?utf-8?B?cnRGRk93dGlBY2RKSkQ2TmdsYVFUWnozUTh3dWRSWkZUbkhhdUJwWEJFSnN1?=
 =?utf-8?B?ZEtJd0ljakZQdmtGckxxNlNZN0RGam1oeTBMNHE5cXh6Y1dVRThWd0NXT0tz?=
 =?utf-8?B?cUcyWkk5WlJ5cEZOQ1RsZ01hZTdvQ3ZwczhzSkpHTlpZRTB2d0tFd210TU9o?=
 =?utf-8?B?R1VxYTZzbmFwdnlFZkJNRDVlcHJoNzF1T3hLcXZFQjZJdFFLZmpEY3RnRVI3?=
 =?utf-8?B?MDBBSGhVZ0NrU1VBOTNRRGYrMlBqK1FzZXVRd2Ruc2VtVGlYZ1ZPU2dhUVNP?=
 =?utf-8?B?Q0JwazN3U3BRMTlVRkJUQ2plSVJzeFp1aDhNaE94eWI1N1ZCSkd3YmxNeHdQ?=
 =?utf-8?B?K25rTnJGbnZCQk5XYkF5NEorN2RhWWh6TUo4MmNXUkc1U2VCd1lzdmhmYlFC?=
 =?utf-8?B?dUNWYURWVmIxTTBRSEY2S0VZeHdJSWRxYVNIWit3MGduVlkwUk5QTEdSUFh2?=
 =?utf-8?B?RWt3b2xnMTVTTU8xV2t1VnQzSjVSN21Mc2Jid0puaHZ5aktBY3NkWjhEVlBy?=
 =?utf-8?B?elFLSVpySXVWUlYzbDF2blVrU2VsRGF2SDZrOW43ZzZ6cDY2QzVqOG5MTE00?=
 =?utf-8?B?YXhacTlBTlJSUEJhc0xZZEo5UllFZjdVWFlndzdVNGZzOHNPbis1ZnlMN2pr?=
 =?utf-8?B?MXl0S1NTTkZLMmVFbGdUV1QvcXFDQ1BRUGFBeUMwLzVlMUtPUVI2TkdKcDVj?=
 =?utf-8?B?bjlITk9zSU5FZndWKzNKdFV0U3BhdWVYSlJEaCs0Wk56dytudVVLWW4rTUZW?=
 =?utf-8?B?VGhJMXNzNy9IZjV1V2k1UnFKZXc1WDJobUZwemlaZGEwaHB6UWJqSTJMYjFL?=
 =?utf-8?B?YnlWQXJWWlU2YkNGMFM2WUpad2dQaDlaR0pqUzRqbHZaU1lxRnB6dUY4ZTFD?=
 =?utf-8?B?L3VmT2k0WVVWWkx5blF3aE1OVjh3WWdwL0RLQ0tFZDZuTjJYSDVsSkJCeG96?=
 =?utf-8?B?ZlhUekpwSFlrQjNtQlo3NVVHbHJHSG1OZms1LzErYzR6Q0hlUTJUS2UyY2du?=
 =?utf-8?B?a0xCa1laMVFZUDBwSDNCRmREMlhnUnd5SHRZQ0MrL0FJMnArcjFXem9mcFRn?=
 =?utf-8?B?bkhmS2tIckRaNEw0OUVob2JpaU5JUkpIR3FjY1NYVDdOc1FvVCszVjFSNlVB?=
 =?utf-8?B?NExFRk5wMXVEYnNPc1RtY041bHF2d2lXQUx5VFhxZzJMMmttcXVScHRwZWdk?=
 =?utf-8?B?VTYwalNIWTljSXVwdUxocDRCZXZURHh2U3ZpSk5kR1NxSFI2M2VKb052cjd5?=
 =?utf-8?B?eDI4MWVoaXh3Tk81TXFaVERGWmxuckhNVXhFcHJ1cHVsbjN0NGFWa2dmTWE4?=
 =?utf-8?B?dkt5SUpJUGZRekQzWmZPV1pPRkxHSzZua3dtVG9BRGQvNmNhcE00K1g1RS91?=
 =?utf-8?B?S0wyRzNWelVyOHg5VTZpbFVHSktDQkJxSVhDOXVoZGNJOVZtaXI0b3ovcUJM?=
 =?utf-8?B?WDc2MVNaVFU2blJDNkFSay9LR1FZcTI1T0EzanhxU3gwRmtyN3lTM1pTS1VO?=
 =?utf-8?B?bm0yVFp6RC9SV1UyQVdjOElzYVAyK2ZjekRkSHZNbjBTeWg2QUxwS3JvOC90?=
 =?utf-8?B?QTRwbzBZbHVKY3d4ektmY2lyQlk5dmtjTWdJTmVaemJkOVIvOWhILytpcURy?=
 =?utf-8?B?dEhMSDdCK0hlb3gwTTQ5RGNybTBOWEZBZkdQc28xV3FXbC9XOGNlYzNpRUlU?=
 =?utf-8?B?Mks2R2tkWGNmYjByeUdYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1WcjR3UEE1Mk11SEdSNUdKcGhUN3ZIaW9mU3VWSGpseUllVXdXcEhQdGxi?=
 =?utf-8?B?MGh0cElZVHhpQkxaRlU4bENJMXE3STU0L1k2cE1EUHZabUswVzBicGxzbTQz?=
 =?utf-8?B?Uk5XaFJnVXpsSUpYR25UWHZGdjZxVEJCWEpyTFlNbkFTTFhzSU1aczdiUDFD?=
 =?utf-8?B?ZSthUkNSdDJoMFlnUjFGR1hnMGtTaEVDR0xPc004b280dTVkaXp2YU4ySDFs?=
 =?utf-8?B?Z1IwY1VxSmkvSnBSK3hFcTBvazI0aklOY2N4OWZ1b2RUcXlCYTRhZCtpT3dx?=
 =?utf-8?B?Rlc3NjNBYlZWbkxFNFF0K2kxMnVORmFXNnZpb0FiVXArR09aZitqK3NEaGZi?=
 =?utf-8?B?WlRoRkVKa0E0TDhrN1VKTmdPdGxvUlAxZmRGNzlQZnVCL3hNR0F1T2VYK3N5?=
 =?utf-8?B?OXNhaDdBU3VxZjhNTkhBMTRsV05IaGQvSGJ3QXhVYktpMDVncStqdGMyWTI2?=
 =?utf-8?B?T1ZsVDdyQjQ5YmtPbkxqTVo5QTZ2aHVYS0dtbGgzQkRiSmtxR3MwUHBvNXFX?=
 =?utf-8?B?THJRWFNRbHBJTlREL0U1dG1nOVdIcHV4eVQ4RWVjRkJQZ0lkU0txb2tUU2Jy?=
 =?utf-8?B?SXdpOFBSdDBQd1lNTlExdXR0OEQvR1ZMYndHKzVOYytnOHhoQWRBYXNYWHph?=
 =?utf-8?B?bDN0SmdnQXdwWHJML3hCK0R4anFUQ1lSTXdkNW9kMnhZTmwwRkZ3cVRNNy9L?=
 =?utf-8?B?SWlZRDNtc0VwUHQ0UlRpL0ttWlJaVkNYRXFyWTNFR29yZUFzRmEwNjFkTnkr?=
 =?utf-8?B?V1VwQ3FOZW9JQ01tZW0yTU1FWkNWa2F6VWtTNTJVcTBHQWxtRWVXRFRHNFpK?=
 =?utf-8?B?QW9ZYmhHbDlSS1RobXpucWZjWDJWL2syNlgzV1J0NGNxVW1tZDJWM1gwUW85?=
 =?utf-8?B?K3BRQ01HNXl5TFdKWG81VnR2NkRieEVVaDE3eDJyNUQrc3h6SGdiLzA4Skdy?=
 =?utf-8?B?akJaaUhoTWtabFB2aVJBZG1OS25TUm9uKzFMOHdpbEhMK1I1YWpxaEdmNW8w?=
 =?utf-8?B?UVJLeUhjYy9HUktXR1Q1Z2tXRE5PSzZBMUU3MUhWWVVneUZycU03T0xOSjNT?=
 =?utf-8?B?SjlDWWIxVFRVTnppRlMrRnhSZjBSRkVRYUhmYUVJTWJNK0thOFkwZllIU2V1?=
 =?utf-8?B?amczS1JSYjZUVU94cDhkMVU1dW4vQ3l6WVp0MFAwaG9mS2xoUjJ0WkFJVlNW?=
 =?utf-8?B?MmV4TFFyZU53b25FdFY5cnN1dExDejZ6Z3MvdnFWY2NIOElzZEdaY3d6c3I1?=
 =?utf-8?B?VktGeDlPM284NTJtQ0RycFBlQ1hoSWZ5WU9MaG1JM1RYZ1JyQmxyMDBneFFx?=
 =?utf-8?B?b2h1a1NWd05WSkFhWUdxYVBhVGZuSE1tcC9oNEdOenNoL0lIc1kwZExBR2ln?=
 =?utf-8?B?ZEp5WVJWRXpvMVRjdkI4QmJiaXRkcmVBNThkRllQQVBHN3gzWXJyWWcrZGJ0?=
 =?utf-8?B?L2d3aXo3aVRHeG56TlZFQnl3RDFvTUYySm5DM29oY3V6VHNlT0ovbURQSHFQ?=
 =?utf-8?B?Wmtza2hkR0RqY0lCSy9sZk14T0wyUXBkY3JjK1dtTzRtTFY2NmJOWTl5cTg4?=
 =?utf-8?B?Ullid3JiekU0YktmZ0ZqYXZRd2ZycEloQktRNk9TbUxYYzV1WnlIeFhjTjRs?=
 =?utf-8?B?ellqN3FFeDFGQWhDRzBQSG9CT0tjMytiSXlwUjNpWGMwb3NxWmNYdzVESU1R?=
 =?utf-8?B?cWk0bU00Kzc3a2tEaGVJZHFCYUxpM20wVGJDbzhBVG5lcXhSTkUwYm1uNExz?=
 =?utf-8?B?MXZ2Rk5ML1RaVEV2ZzRpWXpKSDdYTXBzeE52VHRMUWJhTlVWSWtMU2NyMnVJ?=
 =?utf-8?B?VUVNbHNOQ3NVVm4wZDR2ODVubWdERktoWXZVOG4vcTF1bHMxa1VkWWJQQ09L?=
 =?utf-8?B?Nlp4YzRRdXFuS1ZwRjhtOUpRWFhaWDNFb1JDQWZsRHpaZG8zV1pLV3BVTmNs?=
 =?utf-8?B?bEVoNjRYYVdmYkRaeDZNdWNqUDBsWWZFT1FES2R2NjZoanVXRFJxZTgyczRZ?=
 =?utf-8?B?RkhJZTduL0ZLNDhTWmp1RWdEdE5aSHBOTUNjR2QyQTZqRW8zamZ3WDI1ZVdC?=
 =?utf-8?B?VURnTDJ6dUlUTlpFSWlOK0FJdVZTWWZjTjY5VFYxOWh6YkdWaXZScDJoVmZS?=
 =?utf-8?Q?vDguS+ds7xxHHydPazL7J2IZ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd87075-429b-4dc2-4667-08dcb177aee2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:44:37.3886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou1Mtyf89/AyFCw1Twnzh54RuwNuV9FHMt6prWSuasHmU4tdtYzYKpcJ5+juQCZ8LAZjDmuZ4w2Gtrs1snM5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
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


On 2024-07-31 09:37, Jonathan Kim wrote:
> Support per-queue reset for GFX9.  The recommendation is for the driver
> to target reset the HW queue via a SPI MMIO register write.
>
> Since this requires pipe and HW queue info and MEC FW is limited to
> doorbell reports of hung queues after an unmap failure, scan the HW
> queue slots defined by SET_RESOURCES first to identify the user queue
> candidates to reset.
>
> Only signal reset events to processes that have had a queue reset.
>
> If queue reset fails, fall back to GPU reset.
>
> v3: address nitpicks
> - handle hang detect buffer ENOMEM
> - warn on multiple detect hang misuse
> - reset hang detect buffer to NULL on free
> - update DRM_ERR on reset to drm_err app warning message

I meant dev_err here to make sure we print the device identifier. That's 
what we mostly use in KFD. If drm_err does the same, that's fine, too. 
Looking at the definitions in drm_print.h, the only thing that drm_err 
adds is a "[drm]" tag in the message.

See one more comment inline.


>
> v2: move reset queue flag for house keeping to process device.
> split detect and reset into separate functions.
> make reset call safe during power saving modes.
> clean up some other nitpicks.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

[snip]

@@ -1929,6 +1966,135 @@ static int map_queues_cpsch(struct 
device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
> +			       struct qcm_process_device *qpd)
> +{
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
> +
> +	pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
> +	       q->properties.queue_id, q->process->pasid);

This could also be a dev_err(dqm->dev->adev->dev, ...) or 
drm_err(dqm->dev->adev->ddev, ...). With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +
> +	pdd->has_reset_queue = true;
> +	if (q->properties.is_active) {
> +		q->properties.is_active = false;
> +		decrement_queue_count(dqm, qpd, q);
> +	}
> +}
> +
> +static int detect_queue_hang(struct device_queue_manager *dqm)
> +{
> +	int i;
> +
> +	/* detect should be used only in dqm locked queue reset */
> +	if (WARN_ON(dqm->detect_hang_count > 0))
> +		return 0;
> +
> +	memset(dqm->detect_hang_info, 0, dqm->detect_hang_info_size);
> +
> +	for (i = 0; i < AMDGPU_MAX_QUEUES; ++i) {
> +		uint32_t mec, pipe, queue;
> +		int xcc_id;
> +
> +		mec = (i / dqm->dev->kfd->shared_resources.num_queue_per_pipe)
> +			/ dqm->dev->kfd->shared_resources.num_pipe_per_mec;
> +
> +		if (mec || !test_bit(i, dqm->dev->kfd->shared_resources.cp_queue_bitmap))
> +			continue;
> +
> +		amdgpu_queue_mask_bit_to_mec_queue(dqm->dev->adev, i, &mec, &pipe, &queue);
> +
> +		for_each_inst(xcc_id, dqm->dev->xcc_mask) {
> +			uint64_t queue_addr = dqm->dev->kfd2kgd->hqd_get_pq_addr(
> +						dqm->dev->adev, pipe, queue, xcc_id);
> +			struct dqm_detect_hang_info hang_info;
> +
> +			if (!queue_addr)
> +				continue;
> +
> +			hang_info.pipe_id = pipe;
> +			hang_info.queue_id = queue;
> +			hang_info.xcc_id = xcc_id;
> +			hang_info.queue_address = queue_addr;
> +
> +			dqm->detect_hang_info[dqm->detect_hang_count] = hang_info;
> +			dqm->detect_hang_count++;
> +		}
> +	}
> +
> +	return dqm->detect_hang_count;
> +}
> +
> +static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uint64_t queue_address)
> +{
> +	struct device_process_node *cur;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			if (queue_address == q->properties.queue_address)
> +				return q;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/* only for compute queue */
> +static int reset_queues_on_hws_hang(struct device_queue_manager *dqm)
> +{
> +	int r = 0, reset_count = 0, i;
> +
> +	if (!dqm->detect_hang_info || dqm->is_hws_hang)
> +		return -EIO;
> +
> +	/* assume dqm locked. */
> +	if (!detect_queue_hang(dqm))
> +		return -ENOTRECOVERABLE;
> +
> +	for (i = 0; i < dqm->detect_hang_count; i++) {
> +		struct dqm_detect_hang_info hang_info = dqm->detect_hang_info[i];
> +		struct queue *q = find_queue_by_address(dqm, hang_info.queue_address);
> +		struct kfd_process_device *pdd;
> +		uint64_t queue_addr = 0;
> +
> +		if (!q) {
> +			r = -ENOTRECOVERABLE;
> +			goto reset_fail;
> +		}
> +
> +		pdd = kfd_get_process_device_data(dqm->dev, q->process);
> +		if (!pdd) {
> +			r = -ENOTRECOVERABLE;
> +			goto reset_fail;
> +		}
> +
> +		queue_addr = dqm->dev->kfd2kgd->hqd_reset(dqm->dev->adev,
> +				hang_info.pipe_id, hang_info.queue_id, hang_info.xcc_id,
> +				KFD_UNMAP_LATENCY_MS);
> +
> +		/* either reset failed or we reset an unexpected queue. */
> +		if (queue_addr != q->properties.queue_address) {
> +			r = -ENOTRECOVERABLE;
> +			goto reset_fail;
> +		}
> +
> +		set_queue_as_reset(dqm, q, &pdd->qpd);
> +		reset_count++;
> +	}
> +
> +	if (reset_count == dqm->detect_hang_count)
> +		kfd_signal_reset_event(dqm->dev);
> +	else
> +		r = -ENOTRECOVERABLE;
> +
> +reset_fail:
> +	dqm->detect_hang_count = 0;
> +
> +	return r;
> +}
> +
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> @@ -1979,11 +2145,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	 */
>   	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>   	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
> -		while (halt_if_hws_hang)
> -			schedule();
> -		kfd_hws_hang(dqm);
> -		retval = -ETIME;
> -		goto out;
> +		if (reset_queues_on_hws_hang(dqm)) {
> +			while (halt_if_hws_hang)
> +				schedule();
> +			dqm->is_hws_hang = true;
> +			kfd_hws_hang(dqm);
> +			retval = -ETIME;
> +			goto out;
> +		}
>   	}
>   
>   	/* We need to reset the grace period value for this device */
> @@ -2002,8 +2171,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   }
>   
>   /* only for compute queue */
> -static int reset_queues_cpsch(struct device_queue_manager *dqm,
> -			uint16_t pasid)
> +static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16_t pasid)
>   {
>   	int retval;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 3b9b8eabaacc..dfb36a246637 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -210,6 +210,13 @@ struct device_queue_manager_asic_ops {
>   				 struct kfd_node *dev);
>   };
>   
> +struct dqm_detect_hang_info {
> +	int pipe_id;
> +	int queue_id;
> +	int xcc_id;
> +	uint64_t queue_address;
> +};
> +
>   /**
>    * struct device_queue_manager
>    *
> @@ -264,6 +271,11 @@ struct device_queue_manager {
>   	uint32_t		wait_times;
>   
>   	wait_queue_head_t	destroy_wait;
> +
> +	/* for per-queue reset support */
> +	struct dqm_detect_hang_info *detect_hang_info;
> +	size_t detect_hang_info_size;
> +	int detect_hang_count;
>   };
>   
>   void device_queue_manager_init_cik(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 9b33d9d2c9ad..9393ddc2e828 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -31,6 +31,7 @@
>   #include <linux/memory.h>
>   #include "kfd_priv.h"
>   #include "kfd_events.h"
> +#include "kfd_device_queue_manager.h"
>   #include <linux/device.h>
>   
>   /*
> @@ -1244,12 +1245,33 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   	idx = srcu_read_lock(&kfd_processes_srcu);
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		int user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
> +		struct kfd_process_device *pdd = kfd_get_process_device_data(dev, p);
>   
>   		if (unlikely(user_gpu_id == -EINVAL)) {
>   			WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
>   			continue;
>   		}
>   
> +		if (unlikely(!pdd)) {
> +			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
> +			continue;
> +		}
> +
> +		if (dev->dqm->detect_hang_count && !pdd->has_reset_queue)
> +			continue;
> +
> +		if (dev->dqm->detect_hang_count) {
> +			struct amdgpu_task_info *ti;
> +
> +			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
> +			if (ti) {
> +				drm_err(&dev->adev->ddev,
> +					"Queues reset on process %s tid %d thread %s pid %d\n",
> +					ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +				amdgpu_vm_put_task_info(ti);
> +			}
> +		}
> +
>   		rcu_read_lock();
>   
>   		id = KFD_FIRST_NONSIGNAL_EVENT_ID;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 66c73825c0a0..84e8ea3a8a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -321,8 +321,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct v9_mqd *m = (struct v9_mqd *)mqd;
> +	uint32_t doorbell_id = m->queue_doorbell_id0;
>   
> -	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
> +	m->queue_doorbell_id0 = 0;
> +
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, doorbell_id, 0);
>   }
>   
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
> @@ -624,6 +627,7 @@ static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
>   		m = get_mqd(mqd + hiq_mqd_size * inst);
>   		ret |= kfd_check_hiq_mqd_doorbell_id(mm->dev,
>   					m->queue_doorbell_id0, inst);
> +		m->queue_doorbell_id0 = 0;
>   		++inst;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b5cae48dff66..892a85408c09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -843,6 +843,9 @@ struct kfd_process_device {
>   	void *proc_ctx_bo;
>   	uint64_t proc_ctx_gpu_addr;
>   	void *proc_ctx_cpu_ptr;
> +
> +	/* Tracks queue reset status */
> +	bool has_reset_queue;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 9e29b92eb523..a902950cc060 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1851,6 +1851,8 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
>   			goto fail;
>   		}
>   		n_evicted++;
> +
> +		pdd->dev->dqm->is_hws_hang = false;
>   	}
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 6d094cf3587d..7744ca3ef4b1 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -318,6 +318,12 @@ struct kfd2kgd_calls {
>   	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
>   			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
>   			uint32_t inst);
> +	uint64_t (*hqd_get_pq_addr)(struct amdgpu_device *adev,
> +				    uint32_t pipe_id, uint32_t queue_id,
> +				    uint32_t inst);
> +	uint64_t (*hqd_reset)(struct amdgpu_device *adev,
> +			      uint32_t pipe_id, uint32_t queue_id,
> +			      uint32_t inst, unsigned int utimeout);
>   };
>   
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
