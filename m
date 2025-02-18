Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DA0C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 05:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CCD10E60B;
	Tue, 18 Feb 2025 05:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ys9CGe0t";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2278A10E60B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 05:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQKeQSKkUHi7dugkFuEGS1a/gahB6/jgcjMHQgc1x1vyurg+Kr1SBIKhfvnriZOovYHomKRl6P1IT5eRaK+9SXoWzLiUVTreAuhwKQySafe7obd3gHcADlw+zYnpejpEzImH30EhBZsqKIZATvPgJoPAe2bxoL7cD4I/nAEkiUqURF3tp/NEDYmKhvIUTG2bg4iWiILYblfnR110xW6FfH3gtN4YPE1M/FMv+DhC7sZy4S0gLEXDl/LOV1wYo3gX7DriqZb5fHYghwDkxFQ4FRtBlKrUye4b/y5Iu8Eq7EBsCvEGgVQ1qUU6FtqNaayXWEQ+922SQiUWBQBxMnYTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZqQnsSR0vCzFKyM0dM3j+t9at2WHB4+u0W8TldXjtY=;
 b=u4OtQIAChxigN0G83Z59vY7a5pFqc1f3kz1RN9erqBUqDwsmLLotPgIPdgNkMJ3H7unC6m3bxypvaslUl7ave/RBAGX0T8vLrIJ4hGggmnqfg+kU3BZkUEJ5fFMSWTxMNWHkRO4H3eDjyOcy3mkOYictsbzM2s+HZQ7tyHaNL+LSHencmgVISV3cTK51FH8L5+iAzrfiaCaAkd4EZtxtORMh131VO2svH1q8xXYcwLLIvDWbf26pSFuWRLetGUHC39syix1wPXyfnnvfY63LRCdYGxvlHkCnEYdx8HJYNtjVJ356ozygJqIX6o0AhsLWMVc8sGD/T0sNhn03XyJpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZqQnsSR0vCzFKyM0dM3j+t9at2WHB4+u0W8TldXjtY=;
 b=Ys9CGe0tupNo86Hsz3NqVnDlpFlt1Y6xCTm+iFtiU3/IsyfoW0sZ1U7c3DaacjVfyuCv0TgxkwVtR6F0HEtHjIs33u1mUwJo/zjOcTP+3+u4BMdptlZPziFDWwF7z0MmGZTqik4BE8WrPgpG5tSunZPc6IFC5szeIzAYZBXSPm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 05:09:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:09:27 +0000
Message-ID: <e767530a-7393-4371-9b39-1b835ca6a27f@amd.com>
Date: Tue, 18 Feb 2025 10:39:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use firmware supported NPS modes
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Amber.Lin@amd.com
References: <20250213130308.2028349-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250213130308.2028349-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: b24ae840-e579-4985-2d73-08dd4fda6b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1hSY2hQTXRHNWF0dm5tL3ozM0hjTERoaXlDbGV5ckUvaG9ER2pUYkhNZE5x?=
 =?utf-8?B?aWFHSEk0K2tyb3ZkOE9VQnExZkNZTm5uYnlFdFVwYzF2KzFaMVkrZHUxZTFs?=
 =?utf-8?B?MEk5bXRqRjJ1M3RBbkVpZjA1OXBLMFFSV2JKMzFhcXR6MWoyNjJRd0R4RG5y?=
 =?utf-8?B?UngvTlYwYlI4V09Jem1mUlh6N2FVcHB1UmFVM2pzajdZQVRpZzFCM2RMNjVr?=
 =?utf-8?B?QjVVVjkzcGg5NUdlTDNFNlZiUldXbGpFM1IrZUNwbnc2VWdYa0xiSTVnME9S?=
 =?utf-8?B?alJuck0vVTQwZnlWSlpFZHJMTWRjRVNVdW5Wa2kwaDNKb3RJNitlYW5KMVJz?=
 =?utf-8?B?cDY5QnA4Z3MrNVh0ZEFCaWEyN3BIVU9lNExoLzdhRzB3TzdUNUpHRlp3U0pw?=
 =?utf-8?B?Q2wzQjNLdWxJM2hmS1h6OWRLbmhuSE52Z0k2eHZYNjg3T1BRZ1o3RjNHWE1B?=
 =?utf-8?B?UGcwWUpPRXR5UHNvMVQ0MWU5bnk3ZnUyOTk2ci9vRnRZTkJ0UEJ5THlqZFhB?=
 =?utf-8?B?Tm1lUkhYV3VER2lRRjI0SzliOXR5enRNL0Z5UElKSTJWaW56VllhM0hYUXAw?=
 =?utf-8?B?cGRNa3d4TjBDQVhkQmNqNUtodjdyZlFTYTVWVlZ1cTducnI1TkIrcVo5NklZ?=
 =?utf-8?B?cW90NHA1SjhzR1pvSnBrR3Z3YUtMUzQwS25yLy9OSU5PcFRLK28veUd2T2gw?=
 =?utf-8?B?dXFoTjBGMmVHQ2NSVjd5TWVxaVdyVVdXNmU3TkJWc0Q2VmNFMkVldURrSkFS?=
 =?utf-8?B?RDg5QVZSZ0RocVlkUXpSUG9qRWRCc04wcEwzVWVnUUJsVzNHOHlSMVlaZVdS?=
 =?utf-8?B?Nm1MdFMrdE8xQ2ErbzZuak5nelVjbzNROEYrZGN4Z0xNa2pkSENrWCtJTWl2?=
 =?utf-8?B?ZmlhZUpOaDdTVkVRQXJhQnpFVTkwcURoMlp2QkV4YXIyZ1Nhanp4a2pCVkgw?=
 =?utf-8?B?Smh0NXo4WFVLcmZqZHU5NWRxaW4xZXFlamNVaFMra0tRbHVqVW02NDkwT0lN?=
 =?utf-8?B?eCtRTVVKc0Qvb1hqeU1UZXVtWGI2SzR4WGFhRnRPaUtXNE1Zak1BdUFhVkJ3?=
 =?utf-8?B?Z0xoN0VaUzZUbE91WFYwVy9YQ2djSWZGZGNCNHVES3JQS2hmYVJ2cDJOb29Q?=
 =?utf-8?B?ejl6em1Famh1Z1hzdG4wZXhOVit2WkQ1bnBCSnZJMjY3OXhuYUE4WGJkTGZy?=
 =?utf-8?B?R1BJYzViUlRxWUtmS1dwUUhTcWhaMnU0amZiRmtXVDhCRTVLZ1VHNkN1dzlw?=
 =?utf-8?B?bzhtaUxZSU9FTWRwMWtOc3J0bmxLUCtGMW9WTllXV2tGaWZmWEZXcm95ZGIx?=
 =?utf-8?B?SXhTcmRXb0t6SzlkaVdWQlgzSHB1bzZjc1lxaEM4aVIrWGhON2FiUUxDWk90?=
 =?utf-8?B?cllWVklhTE5ZRlV5NCtNU2VrbGZ0c0lNY0dsemdYMDN3TmdaNGRwTG1FNlYz?=
 =?utf-8?B?S2kvMFp0bDg3SDR5blkweitmK0ZKNGNFSlJSdjdzdy9WWGhpSjhscW82a2sv?=
 =?utf-8?B?WnlnUW53ZnRpVWR6VElLZk5rZUhPekhxbDM1V3JnK3cvMWdSazFaQkZ5MG51?=
 =?utf-8?B?aERISW42TGgyemhOcG5xR0lyQXFSYm56Nm5wVUNuQzgzbXpWdnZZMEZzQTNU?=
 =?utf-8?B?bkRJcHdHbnRSUlkvakNqMkEva05mRTM2SW9YOEtZWFpLYjJOZVVDSFEvODhC?=
 =?utf-8?B?MXNzMzZraG85VjZwNlRKSjlZVTFFb0pNdG9LbjNpU29lejVwem5tdTByT042?=
 =?utf-8?B?bDN3cGxPSE5yVDFUNGJJbHlMRmtrblNiYlkwQUFqWVl3ZTBBK0h6RnJYMEgx?=
 =?utf-8?B?d0wybTF6bUtrb1dSUFpoMUc4RWQyTjJHRGRmYkloUFE3dEp4cmZid24wZWtq?=
 =?utf-8?Q?A20cw6RDdAcDl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlqTGZPcVV6VFdOallvOTArNVY5ZlMwYkQveVRuSk5qNHRIa1pqZXpld2sv?=
 =?utf-8?B?YS9zSFdrQ1FQRllUVEd4NThNVktlOSs4V2ZsbEg5N29CaGRzMHRxR0xSME00?=
 =?utf-8?B?d2FvKzdKbWU4elAxak9MZ1V2b1UvdTF6VU5HZ3RMQmtwT1dCcGdTODllQmt2?=
 =?utf-8?B?R3RRY08vL3RQZVVRei8vVlpsTUlzSFNEcXZrZGZVcGFURmFRUkQ2V1BULy9V?=
 =?utf-8?B?c2tURjVCelEybDh2MVN2TUJpSXpSWW5XUkkydWFRU0tBZEgySUhtNWtwR0Vi?=
 =?utf-8?B?Y2F1Z1pld1RpVHE4RkdLQitTU01IOW9LQStpQUxINDJpZjk5a3VNM3E3RjBk?=
 =?utf-8?B?YlRDMmc4M2JXSTh1SnF0ei9mcWVqMU9RVGxlck5ndW1Hc3dCOVpwWDUveXFO?=
 =?utf-8?B?ak9wbU1BQjZyZ1VpMFBnc1JUaEVHVnhHdHZ6TWVLYzlJMk5ybDZiMU0xaEo2?=
 =?utf-8?B?dms1TEFaaWRjSHFuZ1d6RU1DU2xvMVpxZGF2TU53Mm16NEQrYjcrSGdxRjJq?=
 =?utf-8?B?RXlaNW1qa2dMZGd2aTFpWURhSmNKWjlzOGMvK1kvUTFCdDBWRGJodzc5VHlW?=
 =?utf-8?B?NWN3OGx4S0xDSmJnYmRkNWF4NndROTV2TDdiOWZnODR5bnBIZzdJdDh5NXBR?=
 =?utf-8?B?Tm9SbDkyVWM5REMyc2daTUVmQ0x5TmdRbnE5MnVUcUUwWXhSckRVcENlZTB6?=
 =?utf-8?B?cTUwaThrVTFFM29MS25CaFdPMXJNdWtsaHg0aW8rNlZxczBHZHRpczVZZitO?=
 =?utf-8?B?VUV1ODBFQ09rRVZwVG5zZWcxTkEwSWhiK1pJQ0h5d2I3WWc1b25YU1RFb2JB?=
 =?utf-8?B?Mjc4R3dBNGlJdGxGdGxXRnlZMW9BLzdpQTgxZm1STXVmc0dsMkJGSGhvZ21D?=
 =?utf-8?B?YlpZNkFDNzBaMU1jV1V4UW1VQU8xcVJBZldkWFROSzltT1ZwT3o3d3o3NEhZ?=
 =?utf-8?B?UUQ4RW8vai92OGZNR0xlYzBTemkyTlF4dWFQc0NoYjJRdGFwSE0zNFF4Nm9v?=
 =?utf-8?B?bWVlWWRtYWJNNEJDUDJiYkIwWG81dVdQY2RBSGYwNGtLbVRQUFhpYkdITGFB?=
 =?utf-8?B?Zm94OHA5UkRVczdoQ1ZuVUsyM0hDYU5EKzl3bGtYbFBWTTJycHoxenFaRkds?=
 =?utf-8?B?MmkxZ1hldVFJVitkZndqaXM3c0FtVkRhUXg2T214U1RucEVwWFl4RUtMaTlr?=
 =?utf-8?B?dk1VdkJwd0JnckRXOGowOTFkTGExQjBieHNGdytwUERKTG4xYzVaT1ZqWCs3?=
 =?utf-8?B?NUJSa3FUV0VVQlNsY2tCdUNmamZDOGhRRTRHbDhYRmZLOFhUSzB4NmhENXRy?=
 =?utf-8?B?cEhXUms0UnkyU2hkeGRwcDNTdFQvS0xkQnJ5RG5aVFRiYVovaHF0cnpMckRO?=
 =?utf-8?B?ZGdxL2dQYXdnWUN1QWFDa2Naek96MGRVbGgwMHNNbll0TnZ1TFo3OStsU0Rn?=
 =?utf-8?B?Z0ppa3ZmK2ZUTitzZWY3U29RVC93OUFnRHpveDZFQUNDY3R0VzdrWjJHWDJr?=
 =?utf-8?B?aVRNRkZoaGlaNUdWcEsvWkpWQ2xBSUtRc0V4bWV0U2xjMDdsYnF4S1RNYkMz?=
 =?utf-8?B?QUYwSVVUT0N3cDJTT3d5M1NoNE92cUh4T09mSFFIa0VsQ0FUYVZvSElRMzFQ?=
 =?utf-8?B?dGZwZGpwSjVHVWdYekN5VjFCSTRLVXBEeE1RVGVCUWw4YVZaQWNXOFR0R295?=
 =?utf-8?B?dW4wOUZNRDVndUVpOEx6b2VaYXBMMHBsODVaNk91YmdhWFhIemM1RFlUQ2tV?=
 =?utf-8?B?Y09KRkZhLzNGRkxYcmlqc0t2clpHZVNKdk15MnZFdHl3RUJNbFBSSmYyY0xq?=
 =?utf-8?B?alloSUp1MkFJQ2p3YWx3TVpNTGxsMU9NSmtKaG5XZisxekUydXh4dkNCYksz?=
 =?utf-8?B?dDR5UjZqS3BnWUd0WFZTdTdQUWFDSFZLY2J1QWVZTWdlaU1YSmhoZ1RJZ2gy?=
 =?utf-8?B?NC80aU00Q1JFeWdyTDRiTUFwUjdrdEFmQ0dtUStBNmhEZzBNWUNySEFOMklC?=
 =?utf-8?B?VFlGVkVjV09xcEd2L2NoMXQ1czRHT3FlZ1czSlhaMUNaVE1rL0FTWjVSNjI0?=
 =?utf-8?B?alBVaVlhbnBiRGh3cytFQVViRko5aWl6c0lzd1V0U3NlaXRuRkJNK2NmT2oz?=
 =?utf-8?Q?qVW0XoC7sVNl/44tBA9P1Et4g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24ae840-e579-4985-2d73-08dd4fda6b14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:09:27.7859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnXR9i5mvYiImWNUifHB7tnet4Or5jRvdCNNJfzhUn15YjjBKXUAKMDCXp2aw0Bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

<Ping>

On 2/13/2025 6:33 PM, Lijo Lazar wrote:
> If firmware supported NPS modes are available through CAP register, use
> those values for supported NPS modes.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 36 +++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2aa87fdf715f..4f3ce6d22386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1594,23 +1594,39 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
>  
>  static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
>  {
> +	enum amdgpu_memory_partition mode;
> +	uint32_t supp_modes;
> +	int i;
> +
>  	adev->gmc.supported_nps_modes = 0;
>  
>  	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
>  		return;
>  
> -	/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
> +	mode = gmc_v9_0_get_memory_partition(adev, &supp_modes);
> +
> +	/* Mode detected by hardware and supported modes available */
> +	if ((mode != UNKNOWN_MEMORY_PARTITION_MODE) && supp_modes) {
> +		for (i = AMDGPU_NPS1_PARTITION_MODE;
> +		     supp_modes && i <= AMDGPU_NPS8_PARTITION_MODE; i++) {
> +			if (supp_modes & BIT(i - 1))
> +				adev->gmc.supported_nps_modes |= BIT(i);
> +			supp_modes &= supp_modes - 1;
> +		}
> +	} else {
> +		/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
>  	 * supported modes as 0.
>  	 */
> -	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -	case IP_VERSION(9, 4, 3):
> -	case IP_VERSION(9, 4, 4):
> -		adev->gmc.supported_nps_modes =
> -			BIT(AMDGPU_NPS1_PARTITION_MODE) |
> -			BIT(AMDGPU_NPS4_PARTITION_MODE);
> -		break;
> -	default:
> -		break;
> +		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +		case IP_VERSION(9, 4, 3):
> +		case IP_VERSION(9, 4, 4):
> +			adev->gmc.supported_nps_modes =
> +				BIT(AMDGPU_NPS1_PARTITION_MODE) |
> +				BIT(AMDGPU_NPS4_PARTITION_MODE);
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  }
>  

