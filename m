Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF15CD0BB5E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 06:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9681410E205;
	Thu, 24 Oct 2024 06:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKzE8iYh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E392E10E205
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 06:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re8YnnXBjLOD1UhRbXSlsuEbrBpMiFmRhquQCWvr5BtTExarndIzUO7ILiFSgZCgms4wT/OenwiIvYyh2ZYNoT4Qrhmio+1O4xmDfIWF8beW9Su4dAormxCO1tmy+WbfhbHvPlv2LnMqtIrUdnhaZpdQ9TKxVQVmbehxQNRBMraTZ7l8w7jOzaDGsfXhzVwehkgMGhGE5lKZnR8qZtoFCIK8p5PEhdz0FilGJj9Mjrf1WLRQKbWPk8VJliEtpxnUcPPNkbt03JdwK9sktxgELVehngJMotp9BsAg6ZiTRZgQS3rEHVhs+xtKsJxukIWOaP9uRNGpdbMnNgzy3yk+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrX066wfkTAfT5s5ihsaGebq0ks5Lmpk29CGjRu0tMo=;
 b=f1CaAauYToCyDBe/eIH84N5YIZDIMrXObY43nJMJ/DKO/hctqse03bfKs+JqiG+sR61J/NeVuBqoN8j78/YC3gBDZJklTueit4f+K9xwyGKcOJg5Uyrxtl4jW2yT9ObU0dvnghY8WU01uWNXzmW+QGTamZxI/MJSUPo+JZcYz2hcd4O2TVFW4Ddrs2zppNtL9Df/hpJFuvvy2Kl3Yag7oRAPIFuNXmQBtTT0Rnilm6jlot+hFZaQYDIuJZrsgPnmbdO2IOUnr01BwW/U1IdkLJh13xIADjskmlhT3fGkk25eLA6IlP6Wl+Sqm0KpjiSnuLpwzCpKZMV6zmijfcTs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrX066wfkTAfT5s5ihsaGebq0ks5Lmpk29CGjRu0tMo=;
 b=WKzE8iYhaFxKZzBK1jFjDDwBnW77G2Hl205K0zCbU2F+GBT6ldVucbqOUvkhAWyX2s2EQxqAbJPIK/dytCatusXxzSWhdRGABgQeINA2bymlzCkdRV9X96+Vmxm0upb7vTDT/aWUCKiWC+SgTHYnwPJyWhwvOSZrbQkJHEYTSBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.27; Thu, 24 Oct 2024 06:49:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 06:49:09 +0000
Message-ID: <cc4c4f4c-1b8b-4f0e-ac8d-6cf3af338bd8@amd.com>
Date: Thu, 24 Oct 2024 12:19:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip pci_restore_state under sriov during
 device init
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241024054920.3011641-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241024054920.3011641-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 655fa162-ecdb-4ed6-1f90-08dcf3f7f5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFJMUXI1eHJqRU81SmJ5VnNuNW11NFQ3Nk5vTDIxOWpZclpLd3YvSHQxZFFD?=
 =?utf-8?B?Q2RYUnlOS2l2VnI0OWEwUytQQmRQYjd2TXJrU3JEN3hDUm5JM1pLcG03eEVD?=
 =?utf-8?B?V3FSVGxiSFBidGdVc1hFMFI4a1Zlamg2QlM3a1FXRUFwQnFidDhIaTZOenR3?=
 =?utf-8?B?NUlQdlVIVTFjVFQxaHNsdFdCZTlnSm10STFlVzBsYWRwcVdDOVk2dTJYQ1pw?=
 =?utf-8?B?WFBzb1NMVUFmZFlxOFh4Qzk4YnArdWFOdXYzQ0JVTHpQQ3hhMFNNZ2Q5SVl1?=
 =?utf-8?B?U2lqZ01ncW95L2NIZzhyZlNvWU91cjluMC9aWlZxeVVBU1VmdnhOMy9BSlFm?=
 =?utf-8?B?UmgxTUV6QzZOYy9iSnZUS2lDRmhtTzBKRG9DVVc4dWtiVy9SZEpHdXJVZENK?=
 =?utf-8?B?WHAvOFh0S2JvTFVSdzZTNWV5Q3VlZ25wTW5yQ214REJnV0ZxaS9uQ0pndWxj?=
 =?utf-8?B?d0l5SFJoamc3UnZHcWxPT0tOaVQxYmtrbkJSRXpaSitjdmFpL3A1RUNzV0VZ?=
 =?utf-8?B?bHFKSWNubmZXa2F4eGVpUzZ2TjYrNGprSXpaYmU0bWtBOEJHYjNuMmxwaHJ3?=
 =?utf-8?B?ekxKUHBEZEJxaXdBVHZkcENtNG1QN3d4Rm50VEM5TDcrakJoMERDbXZzS1Nt?=
 =?utf-8?B?a0k5ZUY3Mk9mNDJGY2hUSlRoVjlCdTNpT1pwRHhyLzRRUG5FaWI3dGprck81?=
 =?utf-8?B?NnpNcTZERXFmZUErUGEzejVFQ1BrSnAwVERiTndrR0YyZVIzYXV3dlVxQzNm?=
 =?utf-8?B?V0lpSnJYTllkSzNBR2sxb1E1YzVWdGc2VHN1cmhoZlFOa0hPSklnKzJUNUZw?=
 =?utf-8?B?UG9PcTd6YVB0TFVBY3Q3cUlPVWNDbktaUGlIZEFSVk5oOGpOSW9XdFZNSi9F?=
 =?utf-8?B?RHlhOElCR0FLT1Q5OUVSeXduSnJZZ0R4Wk5uQW50aFlYalUxOFdlTVFnNnVL?=
 =?utf-8?B?UXBHVkUvbTJEZWRjQTN3cjQxanRpTmxKOVNyTG8rTVFOMllZYTV1YVdyRGd0?=
 =?utf-8?B?OXMzZXB0YUJzYUhibCtDS3I0NGpReXFjbHRkVWZtSlFnWjUwMU15QjA1WStS?=
 =?utf-8?B?RkNYbHhxU016Y080Y2pOUm9NZlpmbGxPVXpycW4xZkl6eTZaVzFkdXBvbWxM?=
 =?utf-8?B?WnA5SnpZRDI5T1U0N0JDaHlFQkNDUzVoclRTdStOWFM1UmszamhNeGZYZ05k?=
 =?utf-8?B?WEQzY2IvTkdiTGhKVDl2TTlKTGlqcjVwSUNoekpTRm9oNndqcXNqWUUwbWRk?=
 =?utf-8?B?SE1FNXF4alBwVnNuU0kvZWZVZ1M0d2JpTjM1cGd2SDVMTnVjK0RXWTBTRFdy?=
 =?utf-8?B?dHRCQnFXK21HdFVMNzEwMlN4VU5lVjhMOEw1Y0xMWnE4Tnp3YnJnTE9tc2lk?=
 =?utf-8?B?R2VIWFZUWU56ejVaeHZzVTY4OUEwYlZnQ0lOZ0k0MmRnY3lsL054WlZNQVlF?=
 =?utf-8?B?R1M4d2k5dHoxRXdZSFdJa3BsSlBwMGgzV015WUlza0VlVUcvR215Z0VEQmJF?=
 =?utf-8?B?em5mWFoxdFd3YXFGaW9wWmNWV1hVWXRHZ3gzZXJNNTQ3bVZmckNTSWpIcUd4?=
 =?utf-8?B?NzRlZ0ZlbXVzQUFSTDArb0NBKzJ2UUtoMHh3UDJMdkRWSWlNRkVTZVEyY0cy?=
 =?utf-8?B?Z1dQaERYR2hRUTRmWVpLRGNUTURCQmFYWmlMNUg5NExmYzVqNWw2VTc1VktH?=
 =?utf-8?B?S0JSS2hWTDhaeUYwVzcyd0twclhSaHpFVVBJU3ViRWRJVG1xR1lZWkJiZmdv?=
 =?utf-8?Q?D65CH6QWOe1XTb2V0DbJShW9LulEbI2md6y9pob?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFHTnBVNjIwRy9YWmt5Y2FqVXRnbDRkQTdNcURsQjAxWHBwWHpiYU1LK01k?=
 =?utf-8?B?RG9MdFM0V0pLL1NNR00yYThmeVFCdTNXSXhoV3lvTTJwNEI1S1hYYytsUUlZ?=
 =?utf-8?B?ajNlM29oUXNZWnd6eXlwaW5XYUtqZ1ZyUmQ2RlhxV2VacG15LzdSMVRhMm5N?=
 =?utf-8?B?UmtQNUJ3Nmp0TkozMDdHbVNFZVBRbk5waUFVcCtRaHRibU5CbDRWWktHMFln?=
 =?utf-8?B?VUszamkrQVFRTWpjZlpUUitVQ0RyUmw2NDNRRkdDR2FWSi84KzExdWVxU2Yv?=
 =?utf-8?B?RkFOV2tZUDRSYzRjaUdhVy9OUUJyNnRDUSt4WW1Oc2p3ODRmYm8vTUQrWVo1?=
 =?utf-8?B?b0h0RXFhbmY3Y2xYZGlxMUdpNmI3ZEtScWlQbExML0ZTUUZBWTBlVGpMbTRN?=
 =?utf-8?B?WjZJNlErWjV6SEgrRjdsVGlnMVZXczFuMllkZkd4RXd6WWVpdXNnZzlxc2kz?=
 =?utf-8?B?YUt3UW9MZnowWFhpbHZXZVlEOHQ4OXQvd2FrUytpV29rcC85d3JZRFZLWWd1?=
 =?utf-8?B?ZWtTQ29IZFpVQWlMb0hmd0hrNUR3dDdVSjBkNjBBczNmTmJ5L2F5VFNIMnlq?=
 =?utf-8?B?a1RTVmtBcXdVTnpGT0hrblNodUlFeCt5Y1lqanIzU0s2amtzK29YSHhiMXQx?=
 =?utf-8?B?VFltNjFWb0lXalFzRExDQ2xHenFQNmxxbWVldVhaUktZREN0TVM5ZVFHc2RN?=
 =?utf-8?B?K1IvUHF3QjRHb3lPS0JYTHVtQXVNYWhIM0ZQWjl4V0pnTjRwbDRvK0gxNjJK?=
 =?utf-8?B?WVVzRVI2YjZsQUUreEd1MHNQR3JEQ2Q5VkZqZFFQOU5YWkhaSmtnaUQ4Y0tG?=
 =?utf-8?B?aC9NVWx1d0ZwaHZpcEc1Y1lXbW1OMDVYMU1jY3J6OGE0Q1FaQWN6QS9zU2RR?=
 =?utf-8?B?Z1VPT3Y5RG1aUHV5bHVjWGVyb0FCUFg3Z1dEWjVjazlVelZlSTBUV3B4YUZQ?=
 =?utf-8?B?L2FRTmtPS09oT2dTWEQ4cHBXemtQR201WWc3S1lYbXRyWnRWdTNtOEYvWjlH?=
 =?utf-8?B?NmxyQ1hJZTI0c2tLeGFtZFI2ZHVvZGw3a1dOaW5ZdHljKytyT1prU2hsaUdS?=
 =?utf-8?B?akVnSStLNUFEaXhXLzBaeHBnRVJUeE5jTTBQdnNwaHF6WFhld3NMbTBPMFE4?=
 =?utf-8?B?N0dxMC83bEhkcGNMOXZuditGRE9sanhNQ3BQdHZWdzU2VkZnQmYvRDc4bEFj?=
 =?utf-8?B?SHJYbFV0OUZDbzFhMDRLa1ZwSHJ1UGZOYmtZTFhCRENYMVcrU0M2bjRQak0w?=
 =?utf-8?B?ZEEwSGlQVGZKVHpaTW1GK0VZaXl1QlUvdHJPSGJqS1phdjBlajdsOWE2RWVG?=
 =?utf-8?B?U1BUV2dDNVNiVXliS1QxcC9aNzFXa1B2VzJMSWdNeGFlMFpVMmN5N3VyTEht?=
 =?utf-8?B?eU1hSVovdXd0M2EzOVF1d1dnSCtVeHZzQUFHYk5nM2p2RFQwSGlsa1pHa0xm?=
 =?utf-8?B?a240VlJKWE5TUFZ3VzRyVmh4WjFObXpRWFhDekxOdWRvWnRWMU12TzA0cEww?=
 =?utf-8?B?L0w1dlBISlBxYTQ1L0ZHMEdURW5ueWlyQUM1QnRZOVRvNDFRdG5xQWtiOVov?=
 =?utf-8?B?blg5TFhtMnhkaW9nT0NEWE05cStGUVVSQnJxMkpTbFBIREJjVGxuV3p3UHQx?=
 =?utf-8?B?ZTVOMnNYZGZSNmJoRWZMTCt2SVNpL0ZrU3dsV3NTWHQ0RVA4M2xtRTk5WWZ0?=
 =?utf-8?B?bmxBTFdkUmpYK2tQYTE3MVliVGl6TDJkWnUxQW1heXlWdFRFMzFQWGQ0VFlS?=
 =?utf-8?B?WEhyWXdFZTVVYjZGbzZ0SUo0dERUSEJnRUtHaWR0bFpIMnZhQ0ZJK21zWUdu?=
 =?utf-8?B?OTBSNllDcFNWZ05MRTB0SDBXWDBoTmlVZWZNdjh2OXA3MmRvdEQ5L2NHdTFM?=
 =?utf-8?B?bk4wQms5SWtmNE5zbmVBNE0xdWZYeEJjZEZNejlhNERHdStaemR6NjVUTHNT?=
 =?utf-8?B?S1JSOHc0Ty9Pa1JqRjEwMVh6M3VoYVNYYStsL3RUYWM2QmFyS1JxSDdmTjRS?=
 =?utf-8?B?d0srVnRMbTVPMmJYdHdlKzJtemVhQ21QVldZenhWRVRET3ErVUFzUzd6aEUw?=
 =?utf-8?B?bWIzUTJqLzJYQlREdW9odXNvMWFOUkpNTDNEZDlKaUZnWnBObEZFY3hpV21G?=
 =?utf-8?Q?puAtSWnF8HwQWiOyvUKLSH3Bi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655fa162-ecdb-4ed6-1f90-08dcf3f7f5c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 06:49:08.8891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YajNHiCFG6LCd3eYE9H/ehiXJEUPJyk2C1wzWVi5V0uNBfFXjcSxFCJ9La5JDuE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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



On 10/24/2024 11:19 AM, Victor Zhao wrote:
> during device init, under sriov, pci_restore_state happens after
> fullaccess released, and it can have race condition with mmio protection
> enable from host side.
> 
> Since msix was toggled during pci_restore_state, if mmio protection
> happens during this time, guest side msix will not be properly
> programmed and leading to missing interrupts.
> 
> So skip pci_restore_state during device init.
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6c0ff1c2ae4c..52803cd91ef5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4524,7 +4524,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>  
>  	/* Have stored pci confspace at hand for restore in sudden PCI error */
> -	if (amdgpu_device_cache_pci_state(adev->pdev))
> +	if (!amdgpu_sriov_vf(adev) && amdgpu_device_cache_pci_state(adev->pdev))

This also prevents caching the state. If the intention is that way, put
the check inside amdgpu_device_cache_pci_state to make it explicit that
VFs avoid caching config space.

Thanks,
Lijo

>  		pci_restore_state(pdev);
>  
>  	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
