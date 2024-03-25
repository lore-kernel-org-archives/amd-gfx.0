Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B449C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 18:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CDF10E60A;
	Mon, 25 Mar 2024 18:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JRdXgF9F";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC9310E60A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 18:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDGJtEp+GfkbRyc+Zon5SzsYVg2PIzcWKUKQk5CjLZjj7zMMkcE6d7ihGtrehPbCVMjk3VGoViCG3yQ31bDSjS4pxDaZLgBsEwUehCyCoqyC4b9d3KaG1j8flnL87Nd7HHnr0JFzKAE6uWpOvlIfCJBzlNoUByFiBC+q3ISpUitb+S4l0lw7ao2tpGFrnSjNEeYe7aDBc/ES4wN1ccXUOiz4TkHG0OcPXacxofHu0Bo761Td8SpopfTmla5O0IMQ7JcqJY39qXLv6cj4t6PkleARQuVOP4uN+ob2888SPMzvfNKc4ZJFlD/+tIIHyzsI25/rC/qvXdvsg2vmlq07LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZXyQaNefyTj+8ha/tMuzbwZ+3mM/wtpDiIrXRY+QvQ=;
 b=QQh9W1VvIqa2rdXxPwETqLQfHEm3nE+wFPyQsTZrBZq5RuzPwgcJP3MVX9Tt6zrqnxyayc8ObQqTfgRCsB1qpAJOaxxA+vwVgM1ftSKZ9l3IIGRemzRefRnamRqSfgimUCtt0MLV07NH3g5OBNzUkTQ7QkBpV4zPknKyouMKGlxabOrOBclQsvPT8+zoPjYJXSaqQ7ZdZBKdSVdnlmztEEfc0BE5sqehIRfaSqOJnGaJQkfrEtcD0ljPGIeBx4SD+msqJVXauOapttOh/4mtzmuLinPyUNrW8nj6ygP4O752o2LV3SbphZ6v0HdQnAyIR6+ISDOd/z71jgZfu+21bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZXyQaNefyTj+8ha/tMuzbwZ+3mM/wtpDiIrXRY+QvQ=;
 b=JRdXgF9FcTUHk04Cw1sH7hoCMm+uq4cVhgZfeEgYr9ligPe3pi+jijMFoAJN5nZCNsbmBRJ91NJlTlZosngeZ6WE2dMVLODA/MCTYpQQIPsttIIyYbw0RjBkZJ8megw2Wc3m7x4yVm72aT3VPkglEPVgFqAK6kpVM7aAZnBnyDk=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 18:45:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 18:45:52 +0000
Message-ID: <4fb3033b-a025-45ea-846c-bf97566d41e0@amd.com>
Date: Mon, 25 Mar 2024 14:45:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amd/amdgpu: wait no process running in kfd before
 resuming device
Content-Language: en-US
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com
References: <20240322195737.30795-1-Zhigang.Luo@amd.com>
 <20240322195737.30795-2-Zhigang.Luo@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240322195737.30795-2-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB8215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2lM2YZ/+uuBuk0YEZG30VqZ8ywy3UmuyIrTgbigGfmhmPJsmPqI63OMeAScVXBIQ0IxAhEYbbPVkHMpGfbHCFPqV67B8kdHye4qYoAAVAiyq1amroKFpEqXEEEHd/t+llaxFhT1/o0yq4/Ze/l4k2dC1sYnD3ihU/bCt+yBvtdz32T/rAov3fUEISLAoH3CBJ1e0leqo4L9hSC8c4vYCobO8Yp7GTj/gdUKpSO4InW9Ee2x6/nXmNhQ+AQRSzQKQbzPj0iRSJ1a3ADSWLS7VVjatvUTCBQCRdvdiD2aEYEZud4oD8mL66aYOFnBABHnb8Nq1zHXuTWIOo/A1AuTONLeTx2J0awcXWi3V7zmwQu5a9isovJ5r3jQo7zf75aCs/736xCbTmyjWPXyY76k0ncQfTVq4aYL/94p3yfAAgphQQxMZmANarFhypHEJRhy+xrlEAT9pdP3PuY5/TkdrQymDO1dO09Vkj9FHLEcegsfAM0E6E2Vo47IZCOgfUj320is8oDZdVhtGRrJ0OeoqVZnm72pPlfKluCginUl6qQTNwRQNcUZ/DDddAWfPC8h9iCcxh6ezdm81KbrR592tdKKrJcGm6g+otgeR0yuzd/fgAEzTyENPYU8+7E+d2FIc5rzf2qxd+B7tTjWch3CJYmbwk0W6YqB5A74ef7VSvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS9OWFpOdmdHeDFHTDA3TFNuU0I2Mnp6c0NkSTBVdHJHYXA2TDVZVFYwcVF5?=
 =?utf-8?B?OStJaVkrVHJrYTN5Tk5pZFZqMG01WHh4UHd1QVlHOWh2UkJsQ3ltUXR6VFR1?=
 =?utf-8?B?cE1mVjJaMmRIUjNmZkp2S1BXQ2pCTDFYMHQxQmhndnVoblhXRndoeGY4Qmh4?=
 =?utf-8?B?dS9vazFseVZ2YmRydzNnVTgzNmtJTHdSQ2xnVm1jSmQ3Vk5UTDdmb2RnMysv?=
 =?utf-8?B?Qy9GSEJxWTROSy9zK2lDNm1YSEZvUTJNb004dVIwOGcyODNSdTE3SDduNGRQ?=
 =?utf-8?B?aW5WMERFOVozK0ZPVEVESUFqdUFjN2tGblJPWGF5NmpZVThqTEd3aUx6cEsv?=
 =?utf-8?B?WVpXOWtUUUdXQ1YxVzd0cEMvU29PelVRTmJQWjdvNStIdnVsTGp1bGFDM2JG?=
 =?utf-8?B?TXllYWtTWEdUaU5WUWhURmVPZWhMMEZOUkJGTUhKOVRZVU5sNUVXSXNtbkFp?=
 =?utf-8?B?R1FoM1M5bnJkK3BrYW1CcU1ZSEVLNEJuRHhCUWI2YUlvWklpbWJBaTNBQXpt?=
 =?utf-8?B?L0I2YWRCb3hmcktHN1MrY3IwSXYzQzFYQUpJOHpqc0k2ZW0zZnZKOVowa3dT?=
 =?utf-8?B?OWg0MDk4MDA4ekhNeWp6d1RkamxJTnZoem1XdlFlOXo3TG1sOTFoVGVNRVR1?=
 =?utf-8?B?VWsvN3BqM3VmOHdidWkxc2MyVlYvbFJBY3JwdmZiSkJDdW5ZMXJUWXBuUFdo?=
 =?utf-8?B?bGRnUXN2ZEdpdCtkejVLN1RkSloyNjBFcEFEVnJRV0RZK3Z5R3lGSWpJN2pR?=
 =?utf-8?B?NUV1YzZ0Wmw3RDJWR0ljZWE1SkdTMWppZFhaazBZb3c5RUdZaVQ0aGpFWkRV?=
 =?utf-8?B?OG1RR1hveWNBYXE4amppb0ZsRDBlbFNkbnlMd1l4eWZDNE9hZTFjT285SHo5?=
 =?utf-8?B?QU4wVm9HQ0YvbkMvbDc3T2R5NDVURmZaa0lKY0h0OUJQOTVnaGphMFpJeHpt?=
 =?utf-8?B?bW5nekVpY1dwL3k3Q3BIc2IwREtpRE9vbjliWllVaWJPNkp4ejQ1NzBaanU3?=
 =?utf-8?B?UjhLdVMwWVQxMWp4TlVLQ2RNSkdXaGNPV2V0K2JRbUYvOUJWL1h3K0JQMm5X?=
 =?utf-8?B?U0UyMjQ5QXlRZGxnTGJXT1ZranRZemJjWmRyQ0VTK0hIN2xENXluRDJ0eHBa?=
 =?utf-8?B?VEM1MVVVSVM3TEVqcGYxV1RXTjhpVzFYaFhrZlVqUFE5T2NGaUdQZkNIZ0w1?=
 =?utf-8?B?bVZDQjFsS0p1U2xNeGpGUWJTL0RUZU9FVVJVRmRIMEFTL0xlbVBGVjRVTVpa?=
 =?utf-8?B?bU41Z3pZNUxJTXZPVFd4bGxPUmY4TjZYd2ppbXpQYzVCeWhqUUJ5OGVYVVlK?=
 =?utf-8?B?WXRmTjMwNTJEdi9EUjNETnhFUWdwbjVQZ0lxcm5TZFdzQ08vdE56c1F3ZlpJ?=
 =?utf-8?B?cFY4dVhzdkxoODNwdEFweEM4U2tOUzhyWWJjQ0d4NWl5RWRGdTZyWFpRRHNF?=
 =?utf-8?B?dXVDT0N4cjNPQktSWjV1SzhPc1ppOWZYUkNhZ3NKV2YvWUVGYnVmS0dUUHZq?=
 =?utf-8?B?MlR0NFU4eHhWZ1FZNmtvdWl1OUUzMkZ5N0Q3WjZHS080QUwwdERjNWVhSlVY?=
 =?utf-8?B?elQ4NFVjWkxycU9IVVdBV3BHL05ITWJJZS9HTlFHKzJqbGpuNE5wcWtCemhF?=
 =?utf-8?B?VTVVWmJpc1JPWVlMdGpvbXZRTWUrcjM4R25IY2lNa1Vod2hFckZtL01MK3FZ?=
 =?utf-8?B?aDJ3ZnU3RWxpU0xFQjA5V1U1WHhDNGZOc2VLUk8rOXdYWDlUZGxLR1ROMHdL?=
 =?utf-8?B?bXN6NDc0cU1OeWZVNk9EQ1E2OXdmK25XSnRab2gybjFqZGIza2pCdFNqaW1l?=
 =?utf-8?B?UTBpdUhHNmJkL3dtcEdOSnBvdjFYbzZOOHgxcHM1WjI4cU1KbnZldDNaT0R6?=
 =?utf-8?B?NiswSEpQSUtKSTdsUFpGNGI5VmNTMnZ5MHBrWWtjOHFHdFJ0UFpBbHJlZm85?=
 =?utf-8?B?b0U5bGdtVTJIVVlHQWxRNEcrTXRqSlBCYkc1YUMrTGdxZ2VoekFmTk85czRu?=
 =?utf-8?B?WlFOeFNqR1BNMEM3ODFPN2hKT25TRHJ2OUtZVUxPRGpvQnBTUUVrSEU0RXd0?=
 =?utf-8?B?SGY1a1Z6dTgvd09pT1I3MDI3aTBuZnliQlByNk5SVnA3d3lXVkxYelQxTDFu?=
 =?utf-8?Q?+Edn2JOgxLCegg8s1gBnzR/B1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2143f260-5eb0-4aa3-e5c9-08dc4cfbcbbd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 18:45:51.9923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubOobHs+cT75vABR7lYAcEcQsQFV/w19QIHpndPJpPD/trsTp6tBkR4ZLWPZABCtk8sH0BdO8d5D6LSM8Sk5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

On 2024-03-22 15:57, Zhigang Luo wrote:
> it will cause page fault after device recovered if there is a process running.
>
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 70261eb9b0bb..2867e9186e44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4974,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   retry:
>   	amdgpu_amdkfd_pre_reset(adev);
>   
> +	amdgpu_amdkfd_wait_no_process_running(adev);
> +

This waits for the processes to be terminated. What would cause the 
processes to be terminated? Why do the processes need to be terminated? 
Isn't it enough if the processes are removed from the runlist in 
pre-reset, so they can no longer execute on the GPU?

Regards,
   Felix


>   	amdgpu_device_stop_pending_resets(adev);
>   
>   	if (from_hypervisor)
