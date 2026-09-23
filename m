Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16FEC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2D510E339;
	Wed, 23 Sep 2026 19:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rn+ZodlG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB78A10E339
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb1pHM1WBYM/T5zGX+4INKgomSvu2DebPpVFLLDL87pVg05KNxqYxmKiKvdIJ2SZuNkT352eITx3rgY9ozr5X+q2NGwLhaHi4w2dlwbGgRDShbbNhCs+TTnAOd/PaneRCpvruCkA145czajYtabp0AP5W4WlmdrhO1N23B02CRn8A1RtIk46U+hpdl9NzCXxpHecYBtu1MUtkoHocnMAluAUJv/C08gewHEJePmb8c+U0a0aKjQltGSVCcouZjEB+9EeVip2qIBOw93YhMmTeYEi1baCO5IupUqPiYlfJX6bh+RB2HIIVAjB2563Ny2ZBE64aR7nmTL1fVI1TtUlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in8nVXyh2Nif9ocSNeH+20Sb6f8uxsdqm51BfPHIeE4=;
 b=TdY/4JJz7BAIag+5sx2+ypPZ1gf5cc99dLlaJpBN/vdDOdZ8xqVHXU1sEMqSn0Z2XxBLoiuxtlGx6uCmS5eGHtGcDIEM9x3lcNkXv4MZJMDaM86aAUuqk5NrtJj196oKS6+9FTKrgqJex6cK22Vg+jjRUODxzXrO1QzGEMsWjn6XEICaNy4Huzd8kwXuJXaD+ENSgTW/nVuujwlIa4J2Ff/rypE0DYOJlBHLcOy9s+9kYusUhYcCRZIcMdcJgstf1Blmmhdq3Udll4j4zqbLJtDvoV4ESY0k4EnY6ZWYldb3OkXlRrD+rS1zSlCmPsi1wzzDz3vO9qodmLlxHg32/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in8nVXyh2Nif9ocSNeH+20Sb6f8uxsdqm51BfPHIeE4=;
 b=rn+ZodlGJoCEfY5SIRc1PTDXnUUr0UgMl8+EHNx8Wzvwau9gR4PM4Wyr3/dblYsRDxQ9I0+uobhGC+DClgxxEONFrrQ4gsmR0E+EKofzBRK9thio9eVOBCthwxdkoZCk5eL0zG5fum2HXnsDQJp8C1aGWUDXevSfhKrlesLDs/w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 19:51:59 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:51:59 +0000
Message-ID: <68149c53-b185-488d-b162-e75b16c0ac12@amd.com>
Date: Wed, 23 Sep 2026 14:51:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/display: Fix fast updates on DCE 8.1
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
References: <20260923122033.1046651-1-timur.kristof@gmail.com>
 <20260923122033.1046651-2-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923122033.1046651-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:610:118::26) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd74b28-5c9e-4a9e-0c8a-08df19ac2158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: U+oRgD9Wa1ZcpmStlQBwwWoGd5scAnjbGoUoZIGyfeGTJhmcVExfypSnB/rps1GP9SkZLpf7vd0+g3IyjA/unmY9MadVjJZxfO46XfTC8TB8+Smx/Xpj9Vq3zk/eT8bMtnUGiFqsEEw74s80Lf3jNn56tfQbN0AMqLnQiHF7uOmb6fGCJmjJcScYpRP0JfXEF6SlXOhaXNHjnJkWYkZajeM7Fvub8kvfNePETXY8odjg32L8fa7/eQOzwR7TYkIcyoRKpEDKgZhuzio8Oc+u0lak86mQn2iud4MJnz2Hsn1NhCGZ3trOKkBJaT1vwA6KRSphwS7sSj5qCe7ibUDHLNmDu/2Cd01D5Aug+LqpU1i+bjmmzPw3BDYyBh34DrCDVm+RE7HK24cVGC9JM72cgGy9wZpcb1H4TWzumQ9mhxJNMCGaGJ1JwMJ1rjP2FQKA7iBw7UtBxHE5SDaZZ1n++dVkdOgWf3XAWNY8Iyx9qQ08NqrtP0rMDNzUEwIHG9kBujVuB5Y+ygdIDLuIpbny0LXDC1wvV+Ljm6WVq4jAa04DxP+pAtBcqVjXivWlbsCKewW2VhZzQSm0e+KYMDmZaxT6eOK2zIwID+JYzDfht3eIjAz6r5xHwpfiq6k8bJ/7iJPwK9Xmlf0Qr3KmetJdzK13QROIGB6s66xl5MK0G2rw8hTXVM88H3xYCuscEpkqPSgZEIwQ8b+AIzHXr5Daqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXZPd3ZhM2JkOGg1eFArVDVuRVVEZ0RZYUQ2dW1LcGJoMHNlRkkzeUhuYlZJ?=
 =?utf-8?B?ckx4ZkNJUE5XT0o4bEFwUlR1T0Y5ZzN5aWZVbDJTdWxVQmlpbTV5bU5sTkdj?=
 =?utf-8?B?TFMxbDVXcHFrY1gyZGlna282bEtWQ05PazZuK0RtSjVQem9lY2ZTVkJGck5m?=
 =?utf-8?B?ZFgwWUlwbjFjRlZ4RXJOL2hBb2NwaUxmKytmeFQ5MERqbnE3OFZyMjVRb2JF?=
 =?utf-8?B?cUlwbzRnaGcxNDkyR1IrTlh6Z0g0bEpkeENaUEpPSjM3SUx2clE5THFvblox?=
 =?utf-8?B?UDRnQWkzNVE3eXN3akhBMGpvYTF5ZjVxRTF4akhzSXlUNFBtKzB3bEhWWVhM?=
 =?utf-8?B?WXN1RDgrUW9nZkphSDlpUUZoYlRFRW53S09xYVI3R0dWVDJVbHBsVWhTNU40?=
 =?utf-8?B?eWlvTHZRYXdYY1V1ckhOcElBMnpXZWZoaG9VM3JYVFRHVDEzb3Q5Q2hUZnd6?=
 =?utf-8?B?ZlpGSVRYMENWa1hxanAzeTcyYTI3K21pZ2EyVUZJampzQkxtT3B5MkVMbEJw?=
 =?utf-8?B?U1UrRk1wU203VERHdkJlNlZJY2VtYUZVQVY4dzhZM2E0UWk2OXVGYjFOUUpO?=
 =?utf-8?B?N3k1Tm9UVHErK3RXT0VnRStEUGJ6ZUNNTmZUbDlubFZsRVVZYW5JSVdRdTlk?=
 =?utf-8?B?dmVPUXRFcTIrS2c5dllvcDFtbzNzN1V2VmNSZFFKb29kN08xclVLTHpEUWdB?=
 =?utf-8?B?RU1yZTNHZXJWNzZwbFFQZzNQcXF1OHpjeHVZKzlpVUNONWFmK2NKYW9hOWEy?=
 =?utf-8?B?WjhzbDJSV0RwTUVRWlpoVFZndS9wTDdXc092RVpFS0x1ZGxETzJyMDN4NzBn?=
 =?utf-8?B?Tjg4Rm9UUCtrcXhrcWpBbGtEZEg1UUNSOTBoQ0tMa3JQZG9NYmJ5ZDgvWmJR?=
 =?utf-8?B?akxLVi9uZFUrWXdmeExOSUJSbHU1YWxRbDBqVHU4azZIMVB5ZjNSb1VxdTda?=
 =?utf-8?B?ZEQ5VjVtU3VjZlZlQ2ZVL3pQbVB4emFnbW9vdVF0eGNRZjZaY1B2QXNuU0Iz?=
 =?utf-8?B?SjQ4a2xGSEZjVlZJOWlyMWZsbHZuZUFSZ2c0bVkzNS9iZHMvNDhFNUxQanV6?=
 =?utf-8?B?MmVzSW04WlpkUksxN0xMaDB4RTFZbjhQSlZnbGdHUlZ5ZGtLOWZkWmM2OEJo?=
 =?utf-8?B?aEY2cENUNUxTMFFjdTdOSWVXUGV1TEVmQTZhUHZ5ZDV1Q3FzTVVGQTZLOTNm?=
 =?utf-8?B?QVNyRENSeWEwYU5rdkZGdm5HaWlJckluRU5ONmdiZ21XQkJVcGhzSmFWaHBw?=
 =?utf-8?B?eTYxYTZ2Q1NENHV5bzdFWFd6QkFNdnJoTVpSOVZESWZSSDRRYnV5SDdHVjl6?=
 =?utf-8?B?VUVJWnZjUlpXRGNrNWZYOVR4RXJEZFNYS0RRaVI5TmczZzB2T0J6RTVtYjdX?=
 =?utf-8?B?QWUrNkg1MTZHL3RRVnhFald5c21CSE1IQ2Z0ODNXaUtoVlpTNGh1cW1Cbzh0?=
 =?utf-8?B?aEZKdlo3UitmTGtYa0tKS29kWktmc3dSOWdXYTU0MDkzaTA2R0ovV0J5citj?=
 =?utf-8?B?WW50Z1NhemZoRGdmT2xLNTFWMjdkWDJPcWlzaWZNV3pTU2pKWFVOV0ZtZDlr?=
 =?utf-8?B?K291NW1ZRHlxdHA0MUdNc2dsL2kxV285MGFPVTc2cmdrVFhXV0Q1Nkprcnpx?=
 =?utf-8?B?MUJNVzNIaVhWamNubkhWSDVxaDFpMnlWYy9VT3p0Znl6U2haM3h0TUNqNGZk?=
 =?utf-8?B?ZUpvZGRMelQzS1F6aUFjSUFKeVdnd0ZieEE0T2JObDJCcngxMUc3NzdhS3ZU?=
 =?utf-8?B?OXJiVTFTMHcxVDh6N1g3UFF1SWlha0k0a3JKWGlIYnh1YXYvSXpWeS9qMExK?=
 =?utf-8?B?ZlZ5WmZ5WXQ4b1RKRjVBQXlZQThRSjNqbTJiOUJ6N2JoSkdxREQxQ3pPU0t0?=
 =?utf-8?B?eU1QdE5PNTFkUi9BSnlpREF6a1lHV0VFOERKWUd2RjdzRndCQnFzbGR5NTlF?=
 =?utf-8?B?QjhWK0hnTVVGZTdiN083SnpXVFdlRTkzbVNTeWRQdlRNRFJxTE5hME5QVUhv?=
 =?utf-8?B?U21tRytmQjZaNVJaZC9kN2NPbzZNL201cDRCTXpaYWVUVFRUcW1QWGFmcVZM?=
 =?utf-8?B?SEwyNGtGREdBVEhwQ1Y4M1FGcDcrUm1iSDNWNVpXam1ncW9FbDg1NWhVSkFq?=
 =?utf-8?B?V1JwR3RXRE05YzdwcEQ0T3AzRG5NaEgwWGFLSHZlMG1HMkwwbWM5bHJuRGl1?=
 =?utf-8?B?Q29XOExGc3VCRm5OSEx6aXpMZTd6OUt2NTRvTzlad3p1S2RqNGxINEwzN3dY?=
 =?utf-8?B?a3hEZXp5ZW4vOXhHcEFhd1BxZFFvemVPdnNlRlI4eXJSMSt4cTJWMHZLLzJV?=
 =?utf-8?B?TmFSVzllZ204WDJHQ3VpWGNjS293MWRNNW5GNXpsYUVxT2dnZlFyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd74b28-5c9e-4a9e-0c8a-08df19ac2158
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:51:59.5749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ps459DYmPfLGd+F5tivjEACGDc2yt+SsqxMWxDTdEemY61dx5iXrTKGNr4arXHpnTuMAB1GD7lJLFgimzyRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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



On 9/23/26 07:20, Timur Kristóf wrote:
> DCE8 should use legacy fast updates.
> This was already set for DCE 8.0 and 8.3, but it seems
> that DCE 8.1 (found in Kaveri chips) was forgotten.
> 
> This fix should be backported to all kernel versions that
> have "Refactor fast update to use new HWSS build sequence",
> but this patch won't apply cleanly to older kernels due to
> another refactor in "Remove dc param from check_update".
> 
> Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
> Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> index 26820d35478a..2f4de697ec4b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> @@ -1148,6 +1148,8 @@ static bool dce81_construct(
>   	dc->caps.max_cursor_size = 128;
>   	dc->caps.min_horizontal_blanking_period = 80;
>   	dc->caps.is_apu = true;
> +	dc->debug = debug_defaults;
> +	dc->check_config = config_defaults;
>   
>   	/*************************************************
>   	 *  Create resources                             *

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
I'll get this queued up, thanks.
