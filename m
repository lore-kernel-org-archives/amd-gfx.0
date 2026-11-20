Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA9606A69C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R/3mLEbA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3037410E2F9;
	Fri, 20 Nov 2026 21:36:01 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B564410E2F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 21:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl3cLN/uKCD7Cbk4BSCONloedXiRQ9jGXkKiOH5ZZSNHbz8e0VvzL69e7goc91aXWY6Qqy3roxmdGcj8/YvthRRyhx6T4K7ybpKPMFL9ybpxbdVigUp7Ifi2ACIIPaXrt3IHS9lnzKfXuY2jvu4DapqV1LW9hgVfWLHuxUx4V3tW6qBA7v+qAj7AKDot5koiC66uB9ObXpMLXV5S1G/9SWn4ZKyOgQIyyKKaZJb8wznC/dy7ItoDQpT8RGGnAiRYb+aM2l52eYHBYDCVeOhrIfvpj13Je+xmZMcZ4QtvkIqfgPUj+LVTeWM9srVla8sBWWhl61JJplU2oTzicWchZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HBbyH2X/8jrU6oHMoD79f5wTIM6QeQmdFGLVFAC7eM=;
 b=XfM5lw3QECtzZz5S+B8keS85TWDBG2rwBXIN3VbQIRHMhLLWbTdkRm+HVbBbq49MCuKby2ThOZJ2LyERtBwBTwGNkbUmbx3lUBQr9whD+hKVaeNpKEU6mtSxHL0Kuu45oyBYVWkkXcrGV1D1sLGakFDMdq/PDs+w9gP/PEcZsgathGKN4crYTWZ0asZfzqLxOFjnuFXexLqyWV84LvVyI0ckyCHexDGXS1DMxg74WM7BP6cDItupHQ4lvteS3Ap1U2gTkAbN31LsmV+qZQ6GbXP3eydpvkKfJG5yy39hrWT5Vnn04FsefQZZO41J0nBxXwhEIK+KbVQzUAqljWa6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HBbyH2X/8jrU6oHMoD79f5wTIM6QeQmdFGLVFAC7eM=;
 b=R/3mLEbAAt9A0gI+4/gszvmdGtoGkoftE1o1dkD4i8V+YKSY7FoGEo6nPaVhjkm+ouM39jiI/xwQ01hSTkvTZluX5ayg6nd0+mtuJIfmgY7v++PcTM5oU/vTojWGX5jzyBusQEQpmR6vkct2Fy0hTSdTgMijcoL58UbOZG82Nqg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 21:35:52 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 21:35:52 +0000
Message-ID: <a33a538c-865d-415d-be37-e516e60b21be@amd.com>
Date: Fri, 20 Nov 2026 16:35:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdkfd: don't take p->mutex in
 AMDKFD_IOC_GET_CLOCK_COUNTERS
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, christian.koenig@amd.com,
 philip.yang@amd.com
References: <cover.1795014593.git.William.Palacek@amd.com>
 <459bad3a225aa415fa359d638046f8cd7d26b0ab.1795014593.git.William.Palacek@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <459bad3a225aa415fa359d638046f8cd7d26b0ab.1795014593.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0213.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::13) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc3f71b-341c-427e-b2ac-08df474e3fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|5023799004|11063799006|56012099006|261102123227099003|261021121427099003|261009223027099003|261021123027099003|261026140227099003|261022105027099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YOdNA1LWgiBF26QhS0q70APnFsD++PPtvRA+WLSe66nxqPEgr2ctZ/oRjN8bTT1aWsQM1bC/2IIHfyyoawiN4a9yA7sy+FVL1kew9yOHbfFA1yp5pfJAKDRaW1s0QHlxLZTJTgKdmgbyyr3mkJxhVNapMvFAjJNF0KndPkUhuQKJLSE9e0gtKF+ZwYefbG3QUk+Hy+hrEk6HWtbRB7aATk4VyJZQHkRi/4n1DnJFat9sXobmXodM/nnLx+H8VYGMgOTtu7rBkAYP5qZkLQVsCdEIDErZEAy+Q0TlLfX9ieqCxZZaRbGAZXS3aLu8TC2i6rk4trvWWqEXElgPFdyZpihqjIzl5eIss7FUHAKG4+xSzI9c3n9D4nMN+Ysr190E8lyTEbxdBlziuUyp2tgFjIFHZnV7wuGHNmXAxQK4Sgt0AnbzNGmYhCKxB7WzCxj5W/LkCPn6hLeB1cRoA7Azs3pCVy0taSh2Yf5HaR1jk3UXuPOeSv7/qcSQr0B2H2nJfvFkCF8YtFzDOfzKmSVRqb0uPJMb0NOApJKr+DHlya5pGjCpn0TEdi1ZbgKhiKSCPhH7uXWGIF2LdYcamqnckAokAFd8Ri9fgIdlXZxb5Cy+/rCCFcsP8W3DSoXVYmlXEJAkTaZcEokvF4jABAU3CjvqaAalW767ziA+QdDLi3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktadTZKOHlBRWpZRFFPT0xZUXFYRmozaGN5STF0VEMybXVDMVFTU3RPMXA1?=
 =?utf-8?B?eXBKVlZsUnpYSVJHVndaYjRudmE0NGN5bk9aUEVEMFdKMURja3VnK1dlUksr?=
 =?utf-8?B?dkhNR0ZtZjN5UmhaL0h0Mk1iRjFvdDRYbTA1d1krcTVWd240dE9haFplY0Jq?=
 =?utf-8?B?M0RTNlFIbVhrZ0lKa0FQcERNNW5ENG9KdEtZTWlRRjJFRVFWQlQyUGxqVXdo?=
 =?utf-8?B?QzVtWWdJRS9sYnp1UytTejFPcmp1VVdwTktSaHpVN2MycVNZNjlsYWZpcDd0?=
 =?utf-8?B?aUtJZHhNS0VHWk9KeFEyeXFJZU16Sm12RkhBSkM1M3poWW5tU0UyYlM2MmZL?=
 =?utf-8?B?VDJzWWU3TUdWa1B5NVhNdDBaRnhEdld2R25hbHZCU3NFeU5Md2orTmI2RlFX?=
 =?utf-8?B?VGJzVmxvY3NVSU5vZGUvRVh3elZUcS9xZ0hJSHBXb21NQlVheTNjNEQwQkV1?=
 =?utf-8?B?dGNvbkQ4WHZDNFBHNmVodGw0b1h5cjdUeVRidWs0WnlyeFd0ZndrMjdMbFVB?=
 =?utf-8?B?aU85L3E2eFFDSktHbTV6VUtEQUR6ZWE0N1pFeFhRNEhnbmoyWEZPQ2laSC9K?=
 =?utf-8?B?RFFKOFhTdmlJRFQ0Rm9paUpqZkxReHlrYkVERjV4RHBvZVozeEpseks1Zkpx?=
 =?utf-8?B?ejBuSkFWNE9qVW04c2xIOU5aMFc5NmRQYUhCenpsSUZhWEZiT1NNck1JRzBt?=
 =?utf-8?B?cUYyamdZYXJTR0JzR0lidEZ3YUZocGF2SkhRWFBaUS9JM2FmSHYwREZHWWdH?=
 =?utf-8?B?NHZPRHZGMksvRkdQRWRvaEUvTzZISThvT253d2pKR1dZWkwxTk12SHJCVmFn?=
 =?utf-8?B?Y1BhaGlNVWhXSWpWZ3FrQklyelhCVXJVYTErb1BvSHJQNkhWSFgrQmRjbTRo?=
 =?utf-8?B?RzZyR01FN2lnejBqWW5SY1NPSmlUNDBVYmhxYVdxVDJwVWQ0R011MnA4b3kx?=
 =?utf-8?B?bUFGTSs3U3JHQVlqVEZWT1FFVVVWcW5NYU5CR3UwbjNkMFJIS0tBa0liN2tt?=
 =?utf-8?B?OGtTNG1DYko2YllUY3pYTmZ6Z3YyS2JFY0ZCVWlRdC9yNFFpNmd4MUptTkNw?=
 =?utf-8?B?QlFUenM0U0J5cG16UkhHMXR5V2JQcDBqV3o4TDFtZFlxSXZVUk1LbDZlZ3VE?=
 =?utf-8?B?OHBZcGVZT1pSY1pVdCtTeFVjc1RiVGlzdGpIUkZXcVNJTGQvTXdlbjhndzRz?=
 =?utf-8?B?MkFIbDJGRDBFQjIzdmlqSEE4OC9ML3BNQlRKNklYOXRnc1hsZFZzU1NXUDNm?=
 =?utf-8?B?T2E0TlExeTdEeDZiRkQzUUxuak5EMk5LaWhEbVZUSjZENVFUYTVEektuSk5D?=
 =?utf-8?B?b2pCNG1VUDJtSkEzRm1rcVVKcFVxK3VXUHJ4dWhuY3cxYjB2bWo5dWdLd0d1?=
 =?utf-8?B?Uk1xamlOdHByZzZmck1SZXk3OXBBWVpTM3lJWkRKT0h6MURFWGhJckEwbm9D?=
 =?utf-8?B?SUlrb1FMa2lRanZsUGxKTEtSME5MRUJIdW05M1g2ckJwempUTmtzU25lZUxH?=
 =?utf-8?B?SW52ZmNsRXJRZFNZYVVTc1hOcjBkN1VZNElWZFc3Y0VxeWcyTDlPQ0l1QWdh?=
 =?utf-8?B?MEltNGdzM3FwaGJ2eXdJR2hlZDZvcGQ4blliekhKSjhiYnVRYjNlaWRKZDR6?=
 =?utf-8?B?bG5mbmNUaEsvMVhLYU45eHdqbm8xZVBrdThjbVhrY2xtVGVJUm01alREOFlF?=
 =?utf-8?B?dE00Sm16VHJsaUF3b21PNDltRG1DYnVaUjBkSUhyWG5VaXFJY2tXRjY0K0NW?=
 =?utf-8?B?YzdYMktEV2R6MEx5blhEOXBiZkw3SndMdXlhT0g4Zm1aZnVGR0hDZmRlNzBK?=
 =?utf-8?B?cDZqTFE3Ni83QTRYRmZFMnRmcXI2ekhTaXhyMWdNb0JXbCtJVjRJS2t5Zkwz?=
 =?utf-8?B?VHZ5L1F0WGFMbDNxb3ZuS1ROTjF0RjhqcjdBQWdDWkZCUmFnQ2Q3ZHRtR05m?=
 =?utf-8?B?NzFyamluKzEraHpMR2ZnUTI5ZngwWnBQVmZsQUdac1BjZ0h0V0NGSXRxOEtt?=
 =?utf-8?B?R3RiRGk5ekppaWcwWllSTHdnMVdDYXpGdUdSemltN21rNVRQUWh5UWZTTCtj?=
 =?utf-8?B?dnJ1dWllQy9RM252eUFaUlM3NnJGbkdmSThKaXJwSWNwNnRMSDdpdEE5WFEr?=
 =?utf-8?B?V25GTXdQb05Fc1dKUitsQnpIdG0wVURkeFc4Q0RxbXlsMnNLeVArWHN2cFI0?=
 =?utf-8?B?azBaUk4ydGxwcnp6Um1qWUlUOWROTUdWVldDdVBsZ09zdGJQZ2l1dDZTT3or?=
 =?utf-8?B?VmFVZnh4NGtBMnE4ZU83NHN2eVJmYlRqQUhaaUNpVGdiWGY1MDRsN2QwNzBJ?=
 =?utf-8?B?NU52RWY1THRPc3NwM041U1FHdzJnUXlMalFqYWV0UE9pdmU2Yk0wZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc3f71b-341c-427e-b2ac-08df474e3fcb
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 21:35:51.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlAhVoXQvxuaav31GmOfUofFOUpxFxryD/Rkdlysrwc5fNmcZwLDnixtFBnHpB08r58yAycL6CDKKGu2I7SLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-18 10:10, William Palacek wrote:
> The ioctl takes p->mutex only to look up the pdd. p->pdds[] is filled
> in create_process() before the process is published and freed only at
> teardown, and the clock read that follows already uses the pdd without
> the lock, so the lock protects nothing.

That's not completely true. kfd_process_device_data_by_id compares the 
gpu_id with pdd->user_gpu_id, which is updated under the p->mutex by 
criu_restore.

Regards,
   Felix


>
> It does serialize every clock counter query of the process behind
> whatever holds p->mutex. Threads submitting GPU work call this ioctl
> (seen in a PyTorch workload on MI300X), so while one thread registered
> and mapped a 32 GiB userptr, the others waited in it (205 ms measured
> for one call).
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d2136adb62b..9886bbd28ea2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -745,9 +745,8 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
>   	struct kfd_ioctl_get_clock_counters_args *args = data;
>   	struct kfd_process_device *pdd;
>   
> -	mutex_lock(&p->mutex);
> +	/* p->pdds[] is fixed from process creation to teardown, no lock needed */
>   	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	mutex_unlock(&p->mutex);
>   	if (pdd)
>   		/* Reading GPU clock counter from KGD */
>   		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->adev);
