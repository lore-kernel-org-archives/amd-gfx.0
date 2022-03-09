Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3BFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 21:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBBF10E4BB;
	Wed,  9 Mar 2022 21:46:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D7010E4BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 21:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAfE1wb0EuiNctyIteAAU7FwF4XdtrzIFRGTnUHiBjyO/Gxmu5p5D31a9aNREMdVBk5PNxakCuMfzvItC3A3MX1L2N3vBWtGkWc5q6ebXyJs52ijyouRO4qlkQ/RZ5IA30zDXsihAoMNo6UBb9akGCH7nZFiS91IeqBp/3YKrZhhX8CpvQpN8YFTn/BOhpsfg9vfXyW2pynWmiw8cvWwp6784sKPVco1xzmpHiD0IUEhoIbGz9cbtvq0MOgX5uQO4hp17A/OHEvC8jsOrkDeA+UtVcErKu8z7UoJltJjPZicbGtBjK790sQtrBi9+9cZVv6fJeZo13NG62IiFQ24IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0qbyI5duq1IXVBw0+VeckMRVVc7gUVqI1L0HJOkHlg=;
 b=b98ZUDZyUhSJ2yILx+k6NxzUH7WSKBjI89Kzl/F7bhpixTcLVeviLdY6rSxXlTetO/603vYSTp+aJuerMiOPcMk32UEPiQWMO9K2X3WHXJD21CJYq04ik99pumlXnkDik7lfLutt6J2u+z1PXL6YTQTt1Rp9C6Ec6+iZo3XDYi+EFz0eMVx4fg4pKe0BJRyJEoop9hx8P15A71khf+Y7s53FPUFEe743bGpXWhF7HqRQ/FNATSFhKPgGUnbPhFVlKzvLbxS0gaeLN5v5pSJi9PZuN1HoKaQDyTkEUXoJ04EUMjshTo6GmhF354qtt7ifnJSdWnT6vQLHPjhEKa312w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0qbyI5duq1IXVBw0+VeckMRVVc7gUVqI1L0HJOkHlg=;
 b=Ph/XsZZlzzYEcmRjwKeY0Eki+7mTA8QxGQb4dmgpYwC2Cv1cfN04hvih2GCLp/cucT74F+Y8FfMiqkfscknp+IZe+z4CQQUnJRW1VlntowdA/jeOts6Cxyq04oI9NkrH1l2TTxKkGA19Q4Cu53Brxa+txzP5VpDlkZQ3tvQK2KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 21:46:38 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 21:46:38 +0000
Message-ID: <239aada1-4888-aa81-bd7b-c05f0bb731ce@amd.com>
Date: Wed, 9 Mar 2022 15:46:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: drm/amdgpu: only check for _PR3 on dGPUs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220309201245.1328201-1-alexander.deucher@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220309201245.1328201-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:610:33::18) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef02f35-3be0-4b1e-1760-08da02164958
X-MS-TrafficTypeDiagnostic: PH7PR12MB5927:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5927A9C5DA155E54942B5CADE20A9@PH7PR12MB5927.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Q7cx3FHdQEUaTxdc4BgDX1efGpVNDYqXTrY05yvqQj7ag+wIodNj7w+nN+Fi+wB0nP/FvQd7j0L2j6bkrO26sdJBzoK4ck6zHWR2QNwIFGEeqOD3Dpj7h0HSlW1M7kRGL9YPbUVdUjMUfUqGU45vHTGoO1aFQDBTU/zj77ngUJrxlbvhZqsTXJfTLqRQY27AYOVgGUwMJeESWAzDHH8+hb8SiowWjC95/LviSxQzAPRmN60rS/2XRS4kUGfYiJ7vhu3aDhQ7pWKudZi7QJVfdnT0cjgxFvcTrUAMi1yyisxoZQvkvy2g28ncKCRaYdl4IhvqqJchlswenYXrsPE20/TVeqt1TTQRuQLvNAuG5zDL/HNcHuwt73u2dEY7PzsL1FCBSjG2n3S2p+tykzsdzqsJ/3exWfH8sizQS0emWSfCfnqTRtuDnQLusbXEaZTN8Bu5Gciqb7km9Zpkba5z+2dBwFqa3deudtgwfQk53MHAQKLNbH/Sj1tlCQb1J7oTi5HGnv/iYiWbmDlDZLRiC9jYE6mmgle90GLMdhcoXCDHckQmqfTK47l39aJiSd6ztFd7dJKDT+z7Si6vKrRgbE0lVaLipayzJdrTR5A0in1KW/BBJyQhIfcVk8jiCUiJDpEhkWbtmeEoNBnrXmM0Am4J0UZZhqkezltXKlMpPLfzIf7WpGFjxIbR4gYHCGrMvFHUp42ICDRmkR1GSm73wuR8QfvpryMQuDOrFL1W30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(53546011)(316002)(86362001)(5660300002)(38100700002)(31686004)(31696002)(6506007)(6666004)(6512007)(8676002)(2906002)(36756003)(83380400001)(26005)(66946007)(66476007)(186003)(2616005)(66556008)(6486002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpFRnllWW1oK3VkWUVKc1kvWVh1V1Y3c1pnT21GeDArQ3pqVkIvMDltR1dx?=
 =?utf-8?B?NzRURGl3VmMwWFc0VWlqT0JXRDl2UERDTmx5TkMvWHJKYXFrWjhNVzMvUW42?=
 =?utf-8?B?N09memp5VmNodUYvVnhVeHh4TG5ONURXditiWllXTmZzSm00TncwWE9rZGZj?=
 =?utf-8?B?L1psWHBlTWRtNm8xMnJFcWFmR1p1MGttNWh4U0l5dWliUnBSZ1ZaQjYwcC9a?=
 =?utf-8?B?aWpJSFczc3FYM0Fpcjh0TkpGTnc1QVFEb2R2VnQ2cWJOK0RkeWZYVjFQV05Z?=
 =?utf-8?B?dHd1QzRQUnBZN0FINnVZTkZQa2lra2pMMk15Wk5OTEFtYXl5a1EvRWNuUGFy?=
 =?utf-8?B?SEp4VWhkYnRrNDhVZXpobWxraUU1blE3SDVLMnZHMW5IMG0rSDY4SG4vazBl?=
 =?utf-8?B?NWdPZHZDK0R0Q0luek5lSldlbkRzTVQwOERWTHlrV3BzUDZtNzNjbE5uOFU0?=
 =?utf-8?B?UFNxRjVUSVgxeTRjSWg1WThwd2QwNmhxSWZRdXpNWTFEdGpYVWd2UVRlcGhK?=
 =?utf-8?B?Z1JSWUUzVTlWdk5QQjJWNFFMWDQzVWFJaXQxT0xHTStxN3FIWEQ4bUQwZGtU?=
 =?utf-8?B?Z2VvUFVMUzhXQW1ndDk1ZjlrYzBkb291VmpyTTZMTlN5TWxBZ3crTGpHMURI?=
 =?utf-8?B?enZ4bHkrTXhzdzFudHJtSWYya3dSQzNBSHBJYWxJRHloajVTakdaaHRwMXJy?=
 =?utf-8?B?d01PNlVxc0xIaFBiSnpxQlBwbUcvYXFNcU9pZDljOXBSSlBMT1JEQ1VucVY0?=
 =?utf-8?B?VmwwTGRWbzFGaStVVk03TEx3NXk3U1ZpV01aTHN0RDZtSE1Bdjg3Ri9zMk1z?=
 =?utf-8?B?RE9UWVgwWWdsY2J6dXY5a0JWL0hhZDF0UE1seGJyVVFoRWpKUTZnM2ZGTHJJ?=
 =?utf-8?B?clJMMnZwMFJQa29YVXIzUWc2U0QrZVkrcFZlcWJtL0pjMHVMUmNjU25MYW5m?=
 =?utf-8?B?cVM0cTZnVVJ5dVN0UzY0ejhveG8xQ3ZsS3lyN2tHaTFQUCtaaWR1ZGFvcWRV?=
 =?utf-8?B?MXVQdkxqaDZRL3Y4KzlseDcvTmRCcUh0d1J6Tzd3c0UwQlBYRHF5eFViRjhZ?=
 =?utf-8?B?ZnVkSHF0d2VFSnpkcy83V0RpWDN3Q3FaWVMybzlra1lTY1Y0TWNzN005Z2c4?=
 =?utf-8?B?ai9abGw4bnVnWWp4WVM3eTQ0QU4yL0FTSjc3ZEJKN3phTHRoUi85czZkeUMy?=
 =?utf-8?B?N1J5RFVYZm5GSlQ5TzVWdnp1UWdpM3JaVHcxUVRDNlFjN3Z6UmJObmVSakNF?=
 =?utf-8?B?c0FxNXc3eFg2aS9PRi9uK0ZKc3JBTlJwVFpuaDBEQnl4SU5Bc3EzNG42SkhT?=
 =?utf-8?B?dFQ0NjFKY042QkxMaTg4SXVxWmpoRlJudFF4ZWt3V3hXbW9DODZzNmpkLyt2?=
 =?utf-8?B?YUpvck5tQVVISDZyOWFaL3dGb25xVU5aRkdnaWtNVkNZMjZqMDRkd1Z0NXFk?=
 =?utf-8?B?ZlgxaVdKaGJ2RUVma1ZpMUIwL3dESjZveUlUS1lySGU4akl3YlRoVGtOZFEx?=
 =?utf-8?B?VVJkUC9qYTdWczdMVitic1hmVUtqeTNNZDJwYTBjMUpla2xLQ1hRYUxxdDJI?=
 =?utf-8?B?OExia21Nd3BqM1JDV2dLZmZJRVA1VjNibjE3WTg0QnRTc3B6cmxwVjNMRGNV?=
 =?utf-8?B?QzFxYUo3OTc5L3VPSURTRTVORzJVeDkyYWE0MnFUYUt0MlpMa0xzUC9KaFls?=
 =?utf-8?B?YkM4TE5HdnRWUmdud1R0anJxMStTMDNDRHRMNitDcE1KQmJ5VlFQb1VOODZl?=
 =?utf-8?B?dmd1aE9lcUhtcU9aMDdaN0J5VTI2dnhVb2dnK2hLdTlSbSsrMXR3NVNhQnZh?=
 =?utf-8?B?aDZtaGUrME00Zm9FZkpvSnAvZUcwVHlLSmI1ekdma3R2cWpocTVoMkN3T2FU?=
 =?utf-8?B?eGJGek0xMHZTbjZIalBBNXp3ZXMvYldIUm45U0hLYWFUNDJ4OUhVbWc1M0dq?=
 =?utf-8?B?b1JRelBEdm5qNnk5U0x1cVBBUFdpeUZRdWc5cVNGWXE2aFJhV2F6V1doWnRH?=
 =?utf-8?B?MWRqRWFhQjk5MWN4VG0xVUlRTURVQWdnTVl4VEh2NWJhZVlMY2pZdEluVjhq?=
 =?utf-8?B?MTdRWjR5UUpDSDlCRVgvY1p3TGFrK2V1NHA1dm1NeVRKZHNLNUYvWHJVWXZY?=
 =?utf-8?B?a0NJYU50b1duTDV0Slk3V1YwR21qbXpPNXdFbkI0WmU0NjM1RkVlbHlWRG10?=
 =?utf-8?Q?QpZ5fWWUxDQ5gSpCxdjQHog=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef02f35-3be0-4b1e-1760-08da02164958
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:46:38.5327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO83OM7kg8sJivGRY3cJYtUBRXR/T6symG3kq5iI6ETv2k00zFcn74M+DeJwcHW6CkgkPlkljiSuNYB35Ubhpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

On 3/9/2022 14:12, Alex Deucher wrote:
> We don't support runtime pm on APUs.  They support more
> dynamic power savings using clock and powergating.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ddc5cd61af58..1b313a95c7e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2159,8 +2159,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
>   		adev->flags |= AMD_IS_PX;
>   
> -	parent = pci_upstream_bridge(adev->pdev);
> -	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		parent = pci_upstream_bridge(adev->pdev);
> +		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
> +	}
>   
>   	amdgpu_amdkfd_device_probe(adev);
>   

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I also confirmed this fixes the smartshift bias attribute from exporting 
on an APU program it shouldn't.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
