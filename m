Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BDEE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A077F10F050;
	Fri, 13 Dec 2024 15:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lxx5HyEM";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0775910F050
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2bsCxhJobhqSe7Pz2UOZVJcaLRO5HjBTOLI7hM4EAMHlRfl2dfrauXJZ5Q8ECxKT0n9bb9szIdsWH7cAijmsrTb8TERGd8cx6Oi2Md1QEWGCe9NxWqrtN0+7nzN/SSwDZIZBvYkOQeYvNpb+4i+4oUJLiutDdX8Lj5t0mNw357/wkd/l2QgJgv1uz4BAdnVpD/w8Zv4PWcatEj6Bw3uagYbojAooRu1h6vu9xnYRrxKXnyrC8I2wQDZ/5cHN6imvR+fhq9IpOEn3iPLjADqyjZ9e85EjZdB5doLCMN4JZJhTh/4y5vLFS+l3f4HkwNkKA6+DnU9AOnVZfT3AIw46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnygg+xESBvuLbrpL1qyBsU/wb92KWuC49QBwqB+bhY=;
 b=gQPUnO0594AZNARoK8xYFDHjOM0QAkTx4XMIV9Z/3ZSdHVIr5qZ1BjBipTPfxbCdHBKu5hiXSxmlPzqgZvhnEJD1f/W6f3TjRZ2UeFs0rm+bi84R9bLfoQ15zJIa+briaXAV7GaCnjbR8cuFQWy0HqPVigerkliwlMb00KF2PDEB6p3GepqtLTewwrLSXF/0GWb0UGzE/cotj2rVkWzsPJdRmiS6AJ23A0JBV9tuqjCc5rvx2k58nRJiOMm7yiFHMT3mZ5AbEoQ6QERrllc9jtIt7Ui9FGuY7197nRozAp45yYYY8v2pw6Cc5YCYsqaWbByS0vrcQtU4Iph0n9vwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnygg+xESBvuLbrpL1qyBsU/wb92KWuC49QBwqB+bhY=;
 b=Lxx5HyEMI6hEhAI/LSwPsyQY/q9QmU8TnF2EZMLQI+7XqNP0sBhm5yguVyNxRulMIsP6zR7L2Adl6yfwZmC6wilJPckDhd+VuH8V7dA15/CpRUKXmC98lHHB5ibC/ilB1FQHM04OdY7m8Eoe1riWnZLC1/mJq5RBySrNZ0Hkn1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Fri, 13 Dec
 2024 15:32:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:32:00 +0000
Message-ID: <07f2d76e-4844-4462-91a2-478a5ecad8a8@amd.com>
Date: Fri, 13 Dec 2024 21:01:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Use device wedged event
To: amd-gfx@lists.freedesktop.org
References: <20241212190909.28559-1-andrealmeid@igalia.com>
 <20241212190909.28559-2-andrealmeid@igalia.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241212190909.28559-2-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a312dac-cc4c-4de3-306a-08dd1b8b494c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akNvRTluOXl0bnYyYThySzhzU2RiUFNnYnV3VmpMSmxjOFN4REc5bVZPYVVJ?=
 =?utf-8?B?bzgvdEtVeUQ5bGM5Zm1ET21la0h5UXZ5OWZKZ1FkbVU2a2o1VHlOa3FqdzQx?=
 =?utf-8?B?SDQweTI0TUdxOTdkUWgvZllZdDZ3dlh2MHA5RE9pY1h1QUJPTC8wdFgyZnQr?=
 =?utf-8?B?WW9xcmRhQ0JidHNWblNwT2UrUGJlM2VnZ3UwdkRXdE5tNWJHSXkvM0ZTVWIv?=
 =?utf-8?B?RDdLM3lUc0N1OWNHcXZUUzExWFBlYnZTbkp1MFkwcTBHUkowTnhRQlVOdEVE?=
 =?utf-8?B?SlFDank0d0p6RE1mQi96bG8rcVlESTdZcjAyQ3YwUi9NK0E1U2xUZkkrd0FV?=
 =?utf-8?B?d01QMHNsOVRJQ2Z4K3lUTlVKaDBnTCtRaXFMeW14b3FmdHdHbG9Mdmw1NVZB?=
 =?utf-8?B?NWsyTHhua3F2d1NpMTM2OTF2OXNOYkgxcDh5Tk1jZllnMkIyaGtsdmVFMnRC?=
 =?utf-8?B?U3JxcHRLYUxTVGdIN1A4eVNiZEROMTNiUEx3Wno0YmhsdmJ6bTUzeFNndjUz?=
 =?utf-8?B?VHJuVnhqSW4zTkdUN2VXdTVrd1lGS29Td1dYUGNObTFWZHc1dklnT2JEVlNv?=
 =?utf-8?B?MDJla3ZiMWpZdWxoNFBpN3JiTU5Cc05vMGRYVzczbW90SjUyNlpOTmdUaUJQ?=
 =?utf-8?B?NDBhaW9TQnpMNUMwUVZDWER6QW1mNEw4S3pmTGc2aFRaa2VnWEhSN0hhbUpL?=
 =?utf-8?B?M3VuSy9ranZ0eXJOclhYbjZEVWpVV1R0dVJpMzB0Q1dxSUFxNUNFVXJPeU1W?=
 =?utf-8?B?VDhOK2FnamlYWHJqVk13TEg4TkN3STMvUGU4NUhWN3Q0WU85THVULzhFMUFk?=
 =?utf-8?B?eXBuWXcwTmJWYUh5S2hMSkQzdWEraUJRQzgya0xocmltMUdsUytheTlpTXY0?=
 =?utf-8?B?eVZYTG9FY0lYblNDQ1d5VDdiSlZhbkxmRVB3b1Y1Vzg3QWk0SzRMbGFUMTV1?=
 =?utf-8?B?MEpRUnUzQzBJTVM1M2Q0ekwzRHBucWFDNEVyOW0wcjJHRllncFJweFAzOEVu?=
 =?utf-8?B?QU9nSFl6WnVqc1cvNWRNdXdtdVFnc0QrQXdzVG5hTTRRa0NWdU0vczRJQXF3?=
 =?utf-8?B?NG5Za0RtckZqdS9jWVd6S01kYmVMaDlKV1p1K0pmZlNkbCs5SlFnem5uNXJX?=
 =?utf-8?B?SC9uNm93a1pNc1lEcEhLZytSNm1nUWxRd25jTDVFSEFYQWxpMVZLSmN4bTRF?=
 =?utf-8?B?RTd1aE5OTnpJZG5Fc2hxK0Z2Vkp5b1BsR1ZaQ2ZpaTBySHFNNVlXUjJpYzNG?=
 =?utf-8?B?WkJHODBvTlZxNDFjVTVhRGp4SER5VGlDQXBtT1RIcWFVSHAzN2VadWp3SXFU?=
 =?utf-8?B?WGhxY0hsZEUvcHJkV3FVRTBkbWhGY3lxYnR3am8wcHBFZW5adGQ4N0NhaCto?=
 =?utf-8?B?SHhQN1ZaM3ZSOXRzOENLMk1YbmtoN1d2RERkaTdoOGY0blo3c2NSV2FKYjJu?=
 =?utf-8?B?OXp3YWlxc1U4UDF3U0Q2K1MxN2xGTjdyQ0xtNzNZaU5GS3VnUHpDSXRUMTJL?=
 =?utf-8?B?czlRVmJLSXdONXJSM1F1OVdPZjkwZU5UMVRWS2NFQytvd0NrVmNRNHY4RVo5?=
 =?utf-8?B?NVpoelRkSldwbTUwQUtncUtQa3hYd09RQ0l3YmZleHRkbHFlTmFwT29nNjVK?=
 =?utf-8?B?Qm1xL0VVaTdjUUU1TTNwbHB4WlVicytkaHNSb3h6aGUydjkwczFWWjg5MWhj?=
 =?utf-8?B?aEFyTUFlZ1l0MFVZMUpHTlpLTHlLZVlKVDlVTWFZaVdBc1M1ajZ6OCtHMm5O?=
 =?utf-8?B?QytITHFPU3U0NkpwdFY0N3dKcXBLbm1VcjhzY0FkWmd2MEg5YVNha2MyNThP?=
 =?utf-8?B?emZqSk9mQ2V3VW41TUFLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZZSExGY3hBWm1EYjZJc1pRVys0V0tMZlRjTVVhUzh3UEFuVisyK0ZxdzVH?=
 =?utf-8?B?NjRmeGpmNUd5b0VmdWJ5eTc1RjIzdDNDWEdTOFJ0ejRvOTdHc1ZpMUJIemsw?=
 =?utf-8?B?cWtRWms3RGQzWlFTNm5BVnNvUC9WMUM1Rkhrc2dzVDk4T3NQRXZnRldsMDRo?=
 =?utf-8?B?TmpPa1l1WHhiSE1EWCs5TEdjUTNQWjVwaE9OcVYxZFpYS0hNWCs2bWpJU2Mv?=
 =?utf-8?B?cFhEM29tNUNiWURFeHZTNTdmMEVKSGZzbW5leVYzZXd5V1R4TTZYd1cwZmJw?=
 =?utf-8?B?ZzhhSHNUSjR5WW1SYkhJZndmeGk1Q2Y4UkFBTmZwQkpUY0tCdXpDRW5yVEdY?=
 =?utf-8?B?M0ljNDZjZGF4U3BWQ1pPY1BhcC84NkJaQjJTalI0bjJYNUhDRGJvNXRXVDY3?=
 =?utf-8?B?bHQ5SlN5MFVtcDVNa0wrMmFvUFpFWnhReWR3Zk9tMGdaWXRkSW9naGtESDda?=
 =?utf-8?B?T0tMaUNFbmhMZjJjTWdvTDAva1RzVHhPL3ZzYTdhczUwSFhFdjUweW01T1VL?=
 =?utf-8?B?RUFmam9zMW11WDJQRUJEdk1TU0tDanF3RVo0VHdaUWxzRHNOY3B0L0czQ284?=
 =?utf-8?B?aVBwS0NqQjJsbXlyVGVYcnJpWmJHUTVLOXFRZVFUaHhVcThGTGgwTmltZ0xR?=
 =?utf-8?B?dG4xcWxYdlY4eUJWSHZBejJiTzRZNmNPUHpmcms3WFBnT1NTc1EyZG9ZaVpa?=
 =?utf-8?B?TGdjQjk5TFdxYTdjT1ZtTUpiWWtlQXpJd2FoQkFRcksxNHloamtuNlgxTGZ5?=
 =?utf-8?B?SjU5U0NmSTBmQ1NwY04yUlkvU0w2Nzh1WjltbEptcUI2UW1Ca3JVbW1ZRTJH?=
 =?utf-8?B?YjRzaStkQnF3UkJBVkpiallXYmlFRjFJZDlKeGlCemJoL3lVc1JYWFhORmpo?=
 =?utf-8?B?VXNxc0ppY2g0SnFqY0JQdmpWYzZWRUtJUi9GZ1B5LzJmYlF4MmJtNjdGRXRI?=
 =?utf-8?B?OFFicEpUTG81TFFmYXZjTFBkd2RkeEVKRG5QL0NJcndTYVNlV0Z3dTVJWDhZ?=
 =?utf-8?B?ZnNjODZJTWwwdTRhTlEyTUYwd1VnME40R25XRXhVaE1Ham16ZzJGcjBOL3BV?=
 =?utf-8?B?Wlh4YXhGeXdaSzhvcWtnTTlKSzFHMHhKSlRhRWRIVHhqalVvOVFSSTFoQitM?=
 =?utf-8?B?dkJqUzEyTTlvTlYySHp4UHBHMkZPdCtYM3UvVytWcTZPZWJOb054SXNNVFBp?=
 =?utf-8?B?dXliZ3NuT2xSVUEvT0hlbnF0WWhlYm5POFRWdHlyUnlCSXM5TWRWUm5ZTm4w?=
 =?utf-8?B?QlJkemorOXZWLzlyT3lNcE50bUVJTUNIRS9WdnFxcWZLdnovUWtCYUJZQlE5?=
 =?utf-8?B?MWdiRTVZVTZldGxXTnhVcGZJWWs3Vy9uSUw4SFV3UEtuUTBtQm4rSW8wNzV3?=
 =?utf-8?B?cEx4ZHBCNkRmZ0N3MUN4dzNhaXQzNlJEdXRzNG15aWdwQ0psaG5iYTZjREFE?=
 =?utf-8?B?UmhPRTFDKzZyaUZoN2kvRU9udjk5SGxOeTNDRUN3aHNONlRMRWV2U2JSR3Nq?=
 =?utf-8?B?S2wvMHVUcHViaHNSR1p0eVIvQS9JdGJFeFBJUHFZRU5tQVBabFgvNm94ZzNZ?=
 =?utf-8?B?cjlJcG5FODdaOWdra3FSZmEyU2F2ZDA4elFZZUZMbm8zdGRQQU5wT2ExTzJC?=
 =?utf-8?B?azBVUTk0OUhqMmhrcHpIb1Z4SnJVTnl5bXRMclAwZkxVL09xTDdGMGRkZTNC?=
 =?utf-8?B?Uk5iWFlad3RweHRmODFLOVBjRWUwcUlLTTJTNFAzQzduMUZVRDhjYWpYNmht?=
 =?utf-8?B?d1JkOVAwVHZCWlpZTE5ESXZwRmpzbkVKRWk1NXBwMFVYMDhyS1hKcDBQL05Y?=
 =?utf-8?B?eUNJTWtGVTV0cm5JeDRQZ0tpUHRTTE84cHFyQXlFS1JCYjBKZUJWWHJra0x6?=
 =?utf-8?B?U2IySm81TUtSWldyblZsSDdhOFNTNmVlL1NaOXJETW0zT0xwNEcwL0drR0dO?=
 =?utf-8?B?ZUMrVnVCaEdoNVE1VTlBNmJDczNoRFpnU0RIQk1tbytRRFhnaS85RmJzMUFk?=
 =?utf-8?B?M0ZuUHU4R2xKMHBPbzFmSW4zWWc3dWZPQ2xLZHFRSnRKWlZRWVlVM2tQN09H?=
 =?utf-8?B?aHNaVHZGTkI3a0gvSEhQcmdSYlBpWkJkZ3hCdUNKdEdZbEZDeUVoQmNiRnQ0?=
 =?utf-8?Q?Sn9WzujWZgjDqzaIzJkjard3y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a312dac-cc4c-4de3-306a-08dd1b8b494c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:32:00.4706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C31y499cka69PF2ak8qOCZR1OGp2JSpsNLTCHCxgji+iUiXlJ+g5un+wHbNogp0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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



On 12/13/2024 12:39 AM, André Almeida wrote:
> Use DRM's device wedged event to notify userspace that a reset had
> happened. For now, only use `none` method meant for telemetry
> capture.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 96316111300a..19e1a5493778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6057,6 +6057,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
>  
>  	atomic_set(&adev->reset_domain->reset_res, r);
> +
> +	drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);

The usage we have in amd with a different mechanism also provides with
the user a reason of the reset. Is that mechanism available in this? It
seems this only states device has taken a reset with no other context.

Thanks,
Lijo

> +
>  	return r;
>  }
>  

