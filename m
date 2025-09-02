Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A448CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 06:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F2F10E11C;
	Tue,  2 Sep 2025 06:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wRf6GeLp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F8110E11C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 06:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIkKw5b6QpjKvjxUfBKvVUlh8lJyAW4qmUhKJsuavH44pwsH2HU0MigK+aN9nV0Q8nZLSjrKYgKX0GktsmuNKiWyOERG4DligX4AmdOLs6FZliCeBukSD8f1s43xw0KDF/HGUnSNdrgYMl0ss6y7ADbkzQMIMmKNCQGMw2mAQewdoOL4ZY7I+laZQtJimdDC4nZgTKe/gcgjBP/oL4zccpwdzEpNFDaIQ7bUB5+MHgtutucLlpeGMb2MB6cJL60Y6MZ/ob6K0FXkmuC26ZHc9y694ZzOnpcYnCmpMaKB80hAYdBMPHiYkJZ1zFbMJyBACwNAgdSKjDPwJXCviLTUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCUI0z1Ev8KUUaYLaJiY64SVDOyNL7iJ6s3nu8Ozrng=;
 b=Dsbloknmt0auZkd3O7n2BvlpghRVbLyxgyXt4ul3EfQa+c+P8N5UBhzi546zEcihzvg9vW9dTZOnjEKGp2swtvDzj78OFREleA6rU41Zntlclq3eJjrx/Amj2EOtnFpOkzxKkg0LTMy8stTHPCfDkR6vugEpWIQSyO6iefau2IRuirCV1lPZatTr65KV6rvbZ6dkuee1v52bwJ0I+snSbR8iihhIAzgu1vcq4MTfZ7HsvfdJL4RmEf6XxjbufdQZDBxtcuBvtScuLlGYPwMnEOrwMDTYbOgiEotPtewbXcE73Qx6erti5mnZKT8s27Tv+w8RsWGIoIEtomWdrQ5xNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCUI0z1Ev8KUUaYLaJiY64SVDOyNL7iJ6s3nu8Ozrng=;
 b=wRf6GeLpIcz5q+0kNtoMsXk54wzCMrhN9JnUkZZxCoWV91GN1TjkKvd5I9+ti4hbL2JgPtAVGvRgj7ld4uVGb9Jj1FNxZN475kVNFtqHExW+mgjoiVSGozaEGFWRGC5bAw9w0ecNHvQNwTGPYtg6Azn+W0zMvIwSsj4MaTmEiuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 06:43:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 06:43:58 +0000
Message-ID: <b9c170d0-cbab-434c-a781-e0f5d379be83@amd.com>
Date: Tue, 2 Sep 2025 08:43:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: Clarify that BO size is in bytes in
 comments
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250901100012.439155-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: a69ae66e-3420-44e5-9a2b-08dde9ec1842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0RTNWFZZG1Cb3VIWlZYdC9tL3RtQjNxZzI1VGIvdjJPSkY3YTd5S2tIdGJL?=
 =?utf-8?B?WEM2b2pqSjl5KytWVXAxSHRUK0lOR1dhbVd5Sm8zTGNlK0pUZkhya1NVRkdq?=
 =?utf-8?B?QlRqQS9zT1I2czVxYmFQWEZzbWpyYU1EZnZZdW0rbkRaY2NZMWZtZmtzSGE2?=
 =?utf-8?B?L05HQ0liMTErd2xadnJEemZKSm1TS3BhUnprZHAyT2ZtcWRvV0tkVmhYSXBT?=
 =?utf-8?B?SnMwV0xESEJJTmEzamtrOTZjTzZNWi95dnVNWHlSLy9WVGExU0VlaEtuTkZI?=
 =?utf-8?B?Skd5dmY3WmFaU0FGRzRwdTUvd1NoL2x3dGIxeXNXT1ZGeXh1b2hrQ2t1VVpM?=
 =?utf-8?B?aVlmeGdzN25NbVAwVjdUbEhqZEtDUGlSamFvUlJOeW4rc0hLNWlwRTdNMGpu?=
 =?utf-8?B?c3NhU0pDZUNHdUlGQlQwUFMyMFRmbXVWbHpuaDhETjZzUGovbm5ySTNNTlpC?=
 =?utf-8?B?ZmJSVjdLZU5ZUWUzYjVCZHpXeFJzKzkvL1JYQjVwUEtCdm4yQ0lGS1Yyd21R?=
 =?utf-8?B?bjdrc1BUZ0xNcHl0TnV1M2xkQVFPUUJWd2RDc0hLdUcwZDBNTlh1TEZwYWRE?=
 =?utf-8?B?U2pVai9PRHc0ZkRTVFcvU2I3OGxVZk16TURZMXJKNlRra1hSWlhLQjBFTHdN?=
 =?utf-8?B?eGN5TkQzSGtpR04zbS9QWDNWeWg5ZEtuclg4TWczcjQ4MExXWjZ1eVVLNm1X?=
 =?utf-8?B?WXd6Rm4yWE5oa1d2ZzNaTmkxU0xZTTRwSUxjZkVwaUQ2SnlWSWtrbVIxNHZ2?=
 =?utf-8?B?TWlvYVZZUk1xbFM0NkNWbVliR2VzL1pNK2hrVVd3OVg2YVN0UFdWRVNNbkR6?=
 =?utf-8?B?MHFteldINGhpUlJZVW5BeGMrNTFLUEtDc05uYk5Ga0cyY3RSQzlsb0psS1Vp?=
 =?utf-8?B?YWNxQXJ0OGZMYzROTVJZMlk3ZUpPWjZjUmVacDB4bnF5ZXZVeVB2M0l3MUwr?=
 =?utf-8?B?elJBY2FwY3J2TFNpTGVLcDlHR3lFanhYaS9WcHJJN280b0ljaHlPdnNpMVcy?=
 =?utf-8?B?Y2pWY0VCaXhEYXRaOTlaaEdpM1ZIRVVDeGluTXJFbDVSR0tDWHYwaGpSZlZq?=
 =?utf-8?B?ZjJKM25saStZSVJ2MWl4KzlPcnFDaFpQYXRLMnNQQ1FqZEJVTjFZa2ZVZ0g4?=
 =?utf-8?B?UWxvMzIwZnVobmhMM3p6VGVaaTNMeDAxOTZwSXU4N2l0enJZSEpoV1pVZ3hj?=
 =?utf-8?B?MXFqRjdmQ0N2cXJQMGRTRE1wU2NzQUNlV2VoYUJZR0pHbnlPQURieUxYRkVS?=
 =?utf-8?B?cXRsQ0hZRGdodlEzZ2VRa0FYODkrNzZBUFNZR1lPVEt6a3JOZG9rZlNoQ0Qx?=
 =?utf-8?B?c1o4NmpLUDlyQnZmV3ppQVlWQmk3bWt6Y2ljUUxzWFBETDhsVVNWWjA2aVRj?=
 =?utf-8?B?WEtKUFd2dEt1b3JFNkRHOU1sdHJNZVh4dGNvb285OVZaZG5jUi8xaTJJOTcv?=
 =?utf-8?B?RGp5c1YvNnlWV3djWEZzTzRwelVicldZTjlEd3gzMUpWLyt1NW1DUEdIa3M1?=
 =?utf-8?B?ZHUvQTdBWEVUYy9pY2Z6NUZZY3l1WkxpSE9FeDAzMGFIWUJsV2Y2eXE1Tlcy?=
 =?utf-8?B?R1B1UTRqZEM3NWU4SUsxU0dBZ2RMd2ZNSmFHSmM2SzUyL2ZtM3YxK2QrMi83?=
 =?utf-8?B?QXE3d3VEek5yS1pYZXhyVXU2VDE5N1JBWEZ6dkM5K1FOUG81cUJnT3lxMGFr?=
 =?utf-8?B?R05EQWVHa2ZCbFFXYldXc2d1TlhCREs3VTlrYTAwTkdjRnl0RlRPYnY2R3pG?=
 =?utf-8?B?T2VqWVlTWldsREZkUkgxdW0wNnVkdVhqckdURk9ERTAvVmhjN2pQa1JxMkVC?=
 =?utf-8?B?UWhFOEFMRjhpcjZyVEUvMHhoZ3pYTmRheXJISzY5YlhGQm9kWlpvUEQxRjEv?=
 =?utf-8?B?T2VIR1l5UnlON25GK0FUVnRmZXJkWkJ6eWVPWnd2TExxNGNMM3FzSlcwZEs2?=
 =?utf-8?Q?M4AmE9RqQqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1B3WTEwTng5SlVWOXYrcjc4ZDZLRG1rdXF2SGJvUDg0WmwrclNlbXlybWdk?=
 =?utf-8?B?eWlkOXJ2TCtSeW4xbGx1TDg3YUdySVMxSEp6MnZWOVptdFVmN21seUlCcWlk?=
 =?utf-8?B?NGVKdHUwMUtxRFJEc05jdzhiQVdPU1VuVWZNenhuUWtJYk5qZFcva1lSelVL?=
 =?utf-8?B?NStVbmNveUFqdUtVUkdNbVZ0RzJEanR1MlI3ZEl5UEJ0RHpBaXJ0QythTlAv?=
 =?utf-8?B?eWE2M2thUFZVNS9KaUprT3J4dVNianVEbWR6YzRwZkVLbjFJZE1pWU9GUnJh?=
 =?utf-8?B?ekNvMGRoWHI2MXpkMWV1QU9LMVMzeUFVK05TUWJRQy9STTlLaXpOdnNySnN3?=
 =?utf-8?B?QkZCaWs5b3MyUTF5UkQ5K2NLa0NjWWM5SXQ4b092bksvT3hmNDhkMThPN1Vj?=
 =?utf-8?B?Y1dXSTdrc1dYN0pETUthRXRJRmJxSWZTQWFjdlBXWGV5NWppWjV0SC8rNWdT?=
 =?utf-8?B?dUt3OG9TQkRrNHJLMGZkOS9lbmZZbzBMSDZVcVIvOGNVK0FPL2dROUFjb0cv?=
 =?utf-8?B?cFVPSUVxbEU5ZTg1SmhrWXRQK2VpU0VVNXFwczl6OXZuazY1VjF5Uk9uSDRm?=
 =?utf-8?B?Y3FGRWJzbjdmS293ME1VZG9BNjVYOVhieXJzR0hlVnF6dWZoWlRTMmVkT3RP?=
 =?utf-8?B?WC9IM1QvN0xQZmw0ZTUyRU53L2c3Q01yOUlsNmlTaUhsVTZEbjhKNEsxN25H?=
 =?utf-8?B?SXdmcWdHdHhMUWptWHQ0WEVESGRnZFY1clgyZFVjSEw0OTMvSWZFZFVjanRm?=
 =?utf-8?B?cURqaFh4VGxzMEtjeElwWlRiUk9tcXhFOFl2Y3NYdDJoQTJKWFJHcGxMUUpI?=
 =?utf-8?B?RmNLc0cremYvTXh2Ylc2WG5WOVRIdVVSMFpZTisvR0ZZWW9XbDYwaTNjZXE1?=
 =?utf-8?B?d0NYVnNuQ3NNVkhldWJZK3dUMzluWWI3YkszZ0cyakQySDg3S2dpdjFXRXhF?=
 =?utf-8?B?ZFhWN2VIY3JIRlNITlZYemxGaUVsaTBSSy9EUTJPNGdLdDJEZkJLQkdycHhh?=
 =?utf-8?B?ZStkd0QrNDJlRHdtanFrMW1wTE5vclUxdkJTMmNVc2RsYVhDVjRFQ2Q0WnNj?=
 =?utf-8?B?VDBRTVR0eUdOTUJWRFFBT1oyRnlkeEN3eTlxcGJtdUJUREo4b2V5czM5di9K?=
 =?utf-8?B?bDUzWXc0bUxTcDJRMjJEN1E2dWNoVE4rMGVsNnJNL3pOZ1lsbXBRazZqR1Er?=
 =?utf-8?B?S0pxSFU4YVlTaEU4Ri8xRjFoT05zZGhub0ZXdWE1VVNoMWVTL3hDS0dYanVD?=
 =?utf-8?B?eVFHRjU3SjQ0MXR2eWozaEcyTWZJd2lKS2ZFNWxYUEZ5TDNrTkN6bXNvb05L?=
 =?utf-8?B?SEZmbHlJdEVLN1pFNFlBZ0Rwb1BKcGoyUGw5ektvTndyS2F1eEg2ZGtxdDJR?=
 =?utf-8?B?OUIwSUNNbEs0QWVHTy9scVcvUjB2RnVCL0lJMkZVSUJUbzFCeHZDRXR3S3pr?=
 =?utf-8?B?RjZweTl4TTV2OEFVNXVSdUtBdHh1c1VGSVNPME0yWDVpc09rYVBoTFJCbUNE?=
 =?utf-8?B?cHE3S1FiYkQ4ZXpiUWpUYWZHdC9ydVVXUXZEUzBTQkdGN0gxQjBmWjAvbWFv?=
 =?utf-8?B?Vk4weTRGaWFqZnZXemhPTUQ2Rnc0b3A2cVNuNTVRbnZlZFVwbnBZRC93aStz?=
 =?utf-8?B?VTdjNnlKTUE5eDNLNkM0a3A2Tjl1Y1JGdm9FWWdncG80bFdOTDJRTHhUcy9S?=
 =?utf-8?B?QncyNVJScTVINmZKYUQvV0UwMTdKVjBsZWdZeFdmTW1CN0Nob2s2T1I2Z1ZL?=
 =?utf-8?B?SWF5ZTU2NWZIZlNwaDhyYm1DZGdvNFZ4by9aUEoxajI1dTlhZ0xZTmlVa2RL?=
 =?utf-8?B?QUZGTDVodFR0ZThhdnRZcEY0OWVRNnRXVDhxVXNsWUorQ2V3Z0N5cStKL2pZ?=
 =?utf-8?B?cyt4eldXRkhqUWd2b0NuYkpBdmhaNlp5YkduRlRObVEvOVpDWnp6TnY1Z24r?=
 =?utf-8?B?TWtxaStGeHU3cG81Nkl3a2tqSnEwVm0vaHVsbkZES2dXTDIwRlorRVc0cFcr?=
 =?utf-8?B?TllGa3ArU0QxSmdnWXJRcmJWL05KaUJaSzV0K3hMck9GTXJqWDlGTGlIZVFM?=
 =?utf-8?B?YXF3eEN2V0ZuZE9XK2svNFBnUlFEaDNkdE1nS09ucGdPOUdFNVlGdTdkekhp?=
 =?utf-8?Q?BYEwvgO3UYAC1eOIWDqP3xWo5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ae66e-3420-44e5-9a2b-08dde9ec1842
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:43:58.7696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gvLswvM0d4sxZ7FObAIiJ+es3s0FYJ67MDhOkaIoU5a9Y3xTL/mHMoAslWE8QVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

On 01.09.25 12:00, Timur Kristóf wrote:
> To avoid confusion with dwords.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 122a88294883..9ffadc029ef8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -220,7 +220,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   * amdgpu_bo_create_reserved - create reserved BO for kernel use
>   *
>   * @adev: amdgpu device object
> - * @size: size for the new BO
> + * @size: size for the new BO in bytes

That is actually incorrect. The size is in arbitrary units.

For OA and GWS it is the number of HW engines they represent, for GDS it is in bytes and for VRAM and GTT it is in bytes but rounded up to a page size.

Regards,
Christian.

>   * @align: alignment for the new BO
>   * @domain: where to place it
>   * @bo_ptr: used to initialize BOs in structures
> @@ -317,7 +317,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>   * amdgpu_bo_create_kernel - create BO for kernel use
>   *
>   * @adev: amdgpu device object
> - * @size: size for the new BO
> + * @size: size for the new BO in bytes
>   * @align: alignment for the new BO
>   * @domain: where to place it
>   * @bo_ptr:  used to initialize BOs in structures

