Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736EDC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BF610E17C;
	Fri, 11 Jul 2025 12:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PcPXUcGW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCEC10E17C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i30IkBpe5YXXwz986f77piJ7/0droV4fIN3nslWWQPIyO2oAulkmut7fABw6Phd/rZNxXmxGBLl0LJrbXBGO+jdl9GmPoMG3Mn1Xx94hYqwoP8R2Ipw7uVPFsybYd6dY4DV13OmNOIpqfhE7ulbGKw8Ja/glIXainC918CI72PIZmPRXwe+D9W/Uup6jfo0AdkvT5M7tKajXw4/MAAwXV5iDe8bS+R1WHWmb7B7p+pECekZmNk+EGfWiBge6tN7tHlYkazcKAebxP3R9RPtPtrUE8jHCrz38Ng58Pi7HZ7DSwQPKbTnMjeCKCuXjZ3JP/wlud2Jn8t0uqSro/L+5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS6idp+dLPpIx4P7MLlgzypY8m8tlBhy8oBs4JU2XKg=;
 b=vJ/uSBlbvMCB73fyuCpbnfm9NSQOETTGR/PwrhVDxUw8UKuLTEChf7a7ti1elfhniy0XQm3gh68fxSxqz+2vybGE4owzDl6nNLbfonpvbPevB9G/wAM7U/fUiNHOj5lfecT3WZXA9cPBTBYRHU+kHN5QxXrYvuS1y5slA3zeQ3zYxACOR/m497RuHcXHVAPvgc0HdPcPctpxvBX3aDibFtsMfln5Ta0yBu7yejI54atAVNttjMjHbM8Qfo2TDVo3yHfbrUAFY7JA5xYomnQ5zabABDJbcauygf72nLQghgMDZVoOAIAEs0/USpVW1gYxEiwd8VCZchbwkslT8K9yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS6idp+dLPpIx4P7MLlgzypY8m8tlBhy8oBs4JU2XKg=;
 b=PcPXUcGWq437wWO/2arDjiq90K9sNHGudauLco1scvtQMQvNi1UJzP18anYjG8UN7xU4Du9F1LFu3mtk7GLlD7XHoNUuqUZKEgLyi1gRgjJXJAoGJo+XkUlS2sc+P1BMGVyzhHQD9HeAZmj6hvu4KSLcvzWE50he9PIppyy8PXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Fri, 11 Jul
 2025 12:00:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:00:45 +0000
Message-ID: <064e192d-feb5-4772-b947-d1557f83a7a2@amd.com>
Date: Fri, 11 Jul 2025 14:00:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
 destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711093930.1411470-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3cef28-82d4-46f8-3399-08ddc072917d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2ZNblp6RFFPdEJZT29HR01aWVYrYzNXa016MjhuSmdoOThMNGJzNDdYSjVP?=
 =?utf-8?B?N05SeThURVRVMnQ1SWpCTFFwbG5yeHJodWNYYitBckJtTGNEZFhUVSthWjNi?=
 =?utf-8?B?eG5OQytCRTVzNVNKL21CMjkxdWxNbEVjVlNzU3VrK2tQU1oxTCtpUDMvZ3FT?=
 =?utf-8?B?OThFeFBNaWEwU2VpbnlnZzlJMHFjQWRueW45VUd1VE1ma2xUU2w1b0FjaUlw?=
 =?utf-8?B?Z3hNMnJtVldZWE1CamtQeWc1TDR0QUpzWUphaVgvU0x4VHRxWkdwYXRKSzlS?=
 =?utf-8?B?eUh5dE5IZTdIdDA4NGNudGV1TlZ2RVVKZkx5aDFFY29HSE5lTXhrUGtrWm4r?=
 =?utf-8?B?d3pjZVB2U0N4ZDhsU0lkOUhzRlRhM3lmdlBMbEJDY1JacWEwbndTZFd0b3di?=
 =?utf-8?B?d1lCN3BqQUlmd2tUOFg3SWo1ZVY2MHU3LzZLZ2pDcGFvOEh0QWw5aHozN0tT?=
 =?utf-8?B?WHJJR1M5NndRRG5Ca0RJLy9sZWdDYmFjWElTaDFQNU5Pbmx2ek1renhLWk1G?=
 =?utf-8?B?MTJyS3VDbGYrdUg4TStEWXdzSXNkUVA1QlN3VjJ1elZnZ0ZTNGpvTWxCOEoz?=
 =?utf-8?B?OENKZVdMNFBRTGRDQkwrYUtueHRoYzIvcjN1ZnlXeERQTHo2dEZ5TmhKb1Ri?=
 =?utf-8?B?Wm13aG9iWHRaeWxtay96VENhU0x2MCtuMFF1cEhJcHI3UjB2UmtYRFgzaDJY?=
 =?utf-8?B?U256ZG4wU2VZR2piRmFNWHhaZ2M2b29oWkwxd01UT3VTVlg0Z1lHc1Q0MnFJ?=
 =?utf-8?B?amhyWXJldnNyZS8rbFNpYzlLbU1lUkRoZnhjSk5WbDd2bEJaNXVIZEx4d3Qz?=
 =?utf-8?B?VnlJanhvYmJUaU42TDZwRTdTTVBsNzdtcDNSL0R2V3VDVW9PM2o5Mm1HTHI3?=
 =?utf-8?B?RTAzVCt6NnZPNjc0M0U1SjJTR00wWVlZVVZpdnM4ZVMrS0x3Ly9LbXNYc3kr?=
 =?utf-8?B?Vk5GTllCbkpvYk13bE1CSmxLZFE4YzJLa3p3MGUvT2VycExaZllDUGR0eEpk?=
 =?utf-8?B?OGdFN21Tc2dqck1SNFltWGVnWjRLQnhwbmQxNk9UM3NNbEFralZ6MkNZZk9p?=
 =?utf-8?B?SHB2azR1bzhVT3J6UmVGMWxScVpmMS8yN1ZUYzdXcEJNcWJHYmNUa2hQWUpF?=
 =?utf-8?B?U1AxbXo4emlIbTd1M1lCUzNpTFdNd3p3dzZPMjJmMGRxU1R3N1FZY0VuNWxp?=
 =?utf-8?B?aHRSV1gxSDVldklaRnhodVVZTFIvRHJpdVg2L0VWYlp6eEFVWjcxMEhXMitK?=
 =?utf-8?B?bHhWb1MwaHFQSjlLMFl3aEE4TnRXRmVNclozNlZSRnZ6aG9XTGF5b3NRK3pC?=
 =?utf-8?B?YkZUTUV5VjV4K2JwYVFkRS85eUJSTlV6ZGpVZzFNQTU3T0Q0bXZpbjFPY01N?=
 =?utf-8?B?Y1NQT2pzWGhLMmwwT3o5VUVudjVLeWI2Zmt4ZGFhM3FWR2grU1p1NTBKRWNJ?=
 =?utf-8?B?SlJOUkhlT0ovSnVoYjlHc2pxOGtOWFFnOTQ1TzJnc1hCaWxQNk5XRmtwSGQw?=
 =?utf-8?B?R2pqcC82RVJqd2hqTTZ2enl3UFUrVHZrRkJtOG1hYUF3bkJJTEZVYkVMWDdu?=
 =?utf-8?B?VXBTSzRuNEJiZHNrTjRMb0NxZGZvZzlpR1hqS29DOS9MeUdzeGtzaVQzSXlx?=
 =?utf-8?B?TndPMFhHZGIyUEIrMHU2cFhNbmNCWnRHQURZTTNqdXAvNExzWUY5WTc4NVJv?=
 =?utf-8?B?SVNDenJ6ZDgwbFliWUdsRloyVlhzS2hveWdCR0dlMGFOU245ZGlzZk00a20z?=
 =?utf-8?B?MXdPQkpqbkNIQU5tcjlVekU2ZkxmTGpvWlNqcHptWGpQbUVGVGdmdTVEMFFV?=
 =?utf-8?B?RUZiME15SlVwblAxaUJSTlRyV3pTdE9pT05Dd2Z4cEU5OXRIckF6TnpNanBq?=
 =?utf-8?B?RlBLeWNyRHpWUWZPU25XUVZWb1Uvd0ErdzdBZzZDVXJKSVV1eHN3MkFrSSts?=
 =?utf-8?Q?osEfcZCrUIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZhbDIvcmwxNjZDU0krelRzVHdsTDRNVlJmS0E2WVpIdVpiUFRlaCt6S3V5?=
 =?utf-8?B?cnRxVnBjY3d1R0FRTDZaOGZlV2VQSGUzN21vNTdEbW0zc3hkUDM5ZHZKVjhR?=
 =?utf-8?B?cS9WbGtHNWlXOFdmbklHdG85bGx2ZXQ5ME4rMXZLOFdwTG5WR0xtMTVhTkZV?=
 =?utf-8?B?a0dURyt1RFNCQUtNWEh3dGxJc3RYblJRU0ZnNXhaSzNyVmVhazBpWG5XY0Z3?=
 =?utf-8?B?bVlmb1ZwOXhUYlRRNnh4eFhuOTllc21aOForQlVWRFRJaEcwbUMwZXNUYUlI?=
 =?utf-8?B?OENFYVZ0ZDJkNVNmSVEvbnFtZ1Y0Zmd0RjVLREdHK1dvSjZUKzF6bDlYNXY5?=
 =?utf-8?B?S25EcVVIUEoySUpQekNlbWtPY2w5S0FlalQ5cWlCbHNGT0UzVnlpck5QeFQw?=
 =?utf-8?B?UHVYS2FTMXdYVVlIeGgxNnVUcjRkdElHbWpsaG9uZ0FwNkFGcDZ2TmpxcGRI?=
 =?utf-8?B?VERBM3pRMEpNQXRScG9RR0JqYVNWVjU5SVZKaEtOM1N5ZjNJd1A2L3h4eUFW?=
 =?utf-8?B?RWltUWU3dlNmRGtMcTFFbzh0WTJzK2xxQnNGUG13VEJKcnFDYzF6YjdWZlcx?=
 =?utf-8?B?Q0xsbUJkNzNINHVUSjNNWk9vMEhaZHFVc2w3R0NOWjNqSW8wT3ZCS0JVVWFO?=
 =?utf-8?B?YVJaTExBVDBabmZJTVZTb0JoUkQ5V0ZrNktCR3J3d0VWeGxOejRDS2labk5M?=
 =?utf-8?B?d0pZZk5lZjVzT2JWWVFNcHlWenMwRGRFaGhjaTVoVUcrOVNDWDdwbURQY2ZP?=
 =?utf-8?B?blVvdUdLM01vV2VyV1pETzlDMldCZ1pGUU9SZ1V6TVcvNExoSmdIYjU5b21i?=
 =?utf-8?B?UzVXb3ZiT0dzZ2xPUjFTd0pJZGZER1FITmNpVmQ3ZWR3TnBoM1pFYk80bldi?=
 =?utf-8?B?ckEvVTBsaFJ6bGxvZndNcWFIQ3ZQbnJ0emdLazMrYWtSa0RPRGthUDZVRnVC?=
 =?utf-8?B?WlN6czlzQnBFbzYwYVo2Q3M4VHFkVmkvL3VGcjFZUFFjdGdpbmE5OTA3RmMw?=
 =?utf-8?B?bis4U1h4RkQwQ3BEdU1MVG1KazFmUHpqWDRIZXBxbm40S2VPenFURkt1enVO?=
 =?utf-8?B?RkozN2RoK3Mwb3BpdENmVUpTSkI3M3FTWFJwYmU4K0RZWnNHamY2SndTbi8w?=
 =?utf-8?B?cDcyK2t4cThZTGYyN2grMUdEUjZHbGNhVFJZRW5XWlB0TlZITUc3T3RDTlMz?=
 =?utf-8?B?VFJFSG83TnlVK0dtZ2c5UkhsVWR5SlhnR1BjZzJ0TFAxZjhNZmw0M0x4MjhG?=
 =?utf-8?B?M0k3UjdGSFFIVForZ0RZOUcydmcxd0dmUkRPSXRRWDhUZkNWMW5nTDVGSitn?=
 =?utf-8?B?UTNlZk5vUjE3dnNwaHA2UUwweURITGhhSEdzQjdYcEUweitzbytpZ0lnOW9a?=
 =?utf-8?B?dVkweWFTMGYyZVRHd3hyQTFLMmthYkVJd1B5R3JZT1ZZTXMvL1p5NEJibHcw?=
 =?utf-8?B?VFdRRFZsMnpWZEZ2SHNZYUhNaUljS1NzOVNpejFDMElqOHFxTG1lbTAyMlg4?=
 =?utf-8?B?ZUIvb0poK3lGMUxYMUFSeWNKbTFsRkJQazVLem9YVHAzN3BVZjUwUVpGcDFZ?=
 =?utf-8?B?ck83UllDMTVkTWpMSWpzMFpFeWpBRG82MENhYkptamZNOTA3YlQwbndxM1p5?=
 =?utf-8?B?TllMUFVidjBGZHVIcWtJYzBud1l1L3NIaEk5L0JIZ2RWa3dMZ3JINERDOHFq?=
 =?utf-8?B?ZTN3WXJUdjF6VXNOQ2FyQkNRYTIwMzhpYWREdmFQNlpObUpva2dSWktxMnhI?=
 =?utf-8?B?TW00Tm14c29Oc0lPemMwNllUL3lWTjBFTnlRaUIvNlhYZEZDNTBSQ3dDWkww?=
 =?utf-8?B?TmVkWVNiT1hQL2ZiVXJoTVpKMXlvRDQ3Zm5BRGwxdVVRdUZqLzRDdEtEM1R1?=
 =?utf-8?B?WmFIU3lYRjMrT0pVOWZvUUc2Mm80OFlDTmNIYmNoU2F1eGhXbVptckFLL3Y1?=
 =?utf-8?B?QWw1TXQxSVc0bkF3d3ZUVTl3QlBVZHUxS0tSMWNXSlMwTTdpaFRwMGZoMWxh?=
 =?utf-8?B?QTRBR0NHb3RaNkNJbkJheTJHbUJWRjdJRGJKTTBjNlR3ZWNjK2lwZUVkVjJB?=
 =?utf-8?B?WnFLcmhlS3YySXdRbzROZytCV0JvT3hkQUlMUklUbnpvL3RTeWlwMHQvN1d2?=
 =?utf-8?Q?n+io=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3cef28-82d4-46f8-3399-08ddc072917d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:00:45.8242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdU6S6anp5nmYS/7No3s9XQy5R+No0HdD3jRtouHocaN0f6Uu/r97yMCZ10YKMZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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

On 11.07.25 11:39, Prike Liang wrote:
> This patch aims to unify and destroy the userq doorbell objects at
> mes_userq_mqd_destroy(), and this change will also help with unpinning
> and destroying the userq doorbell objects for amdgpu_userq_mgr_fini()
> during releasing the drm files.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3d2a7f8946cf..15e833b1b3e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -312,12 +312,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		return -EINVAL;
>  	}
>  	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> -	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
> -	if (!r) {
> -		amdgpu_bo_unpin(queue->db_obj.obj);
> -		amdgpu_bo_unreserve(queue->db_obj.obj);
> -	}
> -	amdgpu_bo_unref(&queue->db_obj.obj);
>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	/*TODO: It requires a reset for userq hw unmap error*/
>  	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1457fb49a794..15aa1ca67a11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -336,6 +336,13 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>  		      struct amdgpu_usermode_queue *queue)
>  {
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +
> +	if (!amdgpu_bo_reserve(queue->db_obj.obj, true)) {
> +		amdgpu_bo_unpin(queue->db_obj.obj);
> +		amdgpu_bo_unreserve(queue->db_obj.obj);
> +		amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
> +	}
> +

That makes no sense to do here. The pinning isn't done in mes_userq_mqd_create() either.

In general we should avoid pinning the MQD in the first place, that buffer needs to be fences instead.

Regards,
Christian.

>  	kfree(queue->userq_prop);
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }

