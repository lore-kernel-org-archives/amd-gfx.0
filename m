Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F010EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 16:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD3810E58B;
	Wed, 12 Jul 2023 16:15:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7125A10E58B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 16:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSNiqgjew/ouB1QcvIMYv5FAeTn4fHIrFXK5Ss2Ec7t7Mkp9MuHtt2c6yWBBE0N8WmVhh2rtG0C8q4i+SwGDme1JDg0xdnd9mfcRrxRbNeU0cLh7b02Ru2R4lRmynkpk66gEseI5PSCFBm0sJm1jSqrm3GVRby/hpErxo3skudiMBEktu0IlxOw64ojIytwYqYIT9hPQ8+kmSCAn/Bynpf8CHJM+t7hv8fWk4sW+XX+bJ3jT0/HmM6yq6x0QCchTOrilGfG4Sp2ikW4lL/7WhKRQMWnlseLnetZmTi8l2hjvU1lKHNdlQp/ig9d7WTWltHQnf3APkqhTEx3jHl9eZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q1HpckDvFzXIvxmL4/deQpAaEMEVBTJLRBvG0l+rkc=;
 b=NJTXTdv+CamUPG4pZIv6rWkkCxFoUzWP94jolRxLaQGps8QEm4nvISfaADzaF029z+a04b8PqiuwHIpn8DrSzKhCWcVwpGZwBB1bhjEDv1/tt8srO7Wp4ORCQdVoi2/0vRlGOoN3x3W72MRqFx3Wcq0zeXfgWpCBJFbayzZN4UhSf80fVMAPbVpYirA9vHpouyw6CluHG8Q86z70+TwOju47oReyMA32iv9YkYC6l9uXmuWPAvx7DcWmTr9hHX71peW+eVofylWZxLsecFpfcJZGZAEE6ECM543CTcIqXdvFu1FoS8DgcP1XsXywePc7qccZ4KrGsVxxLUSwbB1I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q1HpckDvFzXIvxmL4/deQpAaEMEVBTJLRBvG0l+rkc=;
 b=t1vD/o7bzC89Er+PUuVeIjyFn/KdV7hqowkCkXXnCcdVY0sJUiCi7zyYzHljAGlBVS5oIE8oDyOm8V/WsyEM4xoutsCYqUTHMavzbcmtbmPUyGN7AD80zcojiz2I8IpzKUnwd9peib2jw4GLsuPN2lSwmD27saE2KDeOyyq33WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:15:50 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%5]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:15:47 +0000
Message-ID: <862e16d6-a4bf-ab45-0960-3bce0406f197@amd.com>
Date: Wed, 12 Jul 2023 12:15:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amd/display: Remove spaces before tabs in
 amdgpu_dm_hdcp.c
Content-Language: en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-3-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230629044635.2266729-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3202df-da60-42b2-624d-08db82f340b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98xR1cdLVGHd0FOLEe81XDdVMXUQrVILItODczWpCqSXGdJ6qv6P7QLx3GBGN3ZZlRBr4VtIwao12I5R0TRmCYqTcZ4OdtRUZcKgB/vud9gACgmw6yn+fC/4p6zttdEKFef9zdcaFswhSEAvfdu7rxg+In+Tpt0AwBQ71iEBxoryrMaqf0hEGtsK1+tEGc256GpuaEeTt9vDVSsoZCWqPhZhv4VxG3Q0hLqI6YbptaCcbaFwnz76uVKFiW9ufhRyqpsmRg5sW04I4tsfi/K6yW9FNmN4YGHW9S+ycY4qL8DZVR9lUCPje9QimYNVxIc34HyT/f8ews9O4WZ7hN9RQOvneaMDEziIvkPmIedSVLsc5dmyBv3ubUFIMctCMSa/nxSqEas9sU7ab1lHLP4skycoRqB9MWazNGKONA4y3lpjr84G7uLserQTf6xW1Pb+LzSGnFrAneoMiXj4seQs6+RgkcaN93CzW9a4ek4VW/i0Qu4LJnnY4sK2NXFy567b+2cnu6a06J+EqVJkd7NJO5sCtPG9N/HkH56mbNxl2z4FpfbSE6fisdHy4sGDTu8flmoMeVhBFQAC5wNx6+n+BF6wxbPhutRlNeb7doYx+BtDPA/uLfB3uxCYzMy+oIvEWUyU6e0Ld8Tkuh5g95kl3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(6486002)(186003)(86362001)(2616005)(31696002)(478600001)(110136005)(53546011)(6506007)(26005)(44832011)(316002)(8936002)(8676002)(36756003)(41300700001)(31686004)(5660300002)(83380400001)(6512007)(66476007)(66556008)(66946007)(4326008)(38100700002)(6636002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXNPMWRWekljcEIvL0R2ajkweXI5Ni9WVjJjcE9XcWxoOVc1eHRIa3NvLzlZ?=
 =?utf-8?B?UnlyamxZeUpPYkx3dFowQjdnWnZCdk1BeForUE4yRlNIMmwrREUxSlVHdWZs?=
 =?utf-8?B?TnVPSDVVZXNsMXZ3WHd1Q3FIcW9naFVsbTNIaWN4YWw1UDVSRm9lQkJsbDF3?=
 =?utf-8?B?UkJzRTlJNk9TOUlNN3NweURSS0tGbGs5bzRJbE1NRng5UGdCd1FLb21IYjMx?=
 =?utf-8?B?ZDNOcTVJOGgvK0JjKzJiVENwS2YzWW80TjJ2QURLajd6TzM4Q2dERGpYU3Yw?=
 =?utf-8?B?MDdvZnJLcTJvdHp5bmVEQTJCNjlySk5iMWdER1dDWHNTOVNKaEpIMjFyRWFs?=
 =?utf-8?B?UkpDMTFPanZRc1ZKUGhSNHVmL0ZkeTVLemtxMEh5WE5JRDh1QzQ1aThGTUNN?=
 =?utf-8?B?eUFYQTUrVUhKSFZFdWJCN1RUMHFXdWZDSm1nK3JnV1lEdWRPL0ZjRVdEYW4r?=
 =?utf-8?B?L2MwTGxYTWkraTA2RWR4bDJIYnVpU2hZcytjek5hWjZUc1dMSFplbGxmRm1o?=
 =?utf-8?B?bUwxWjFBbHJLVE9waXZKdEtEMGFtWHVCQUJpaTRCWExDQjlVL3dYWWdsN0g2?=
 =?utf-8?B?VFphQmg4OTZhd0UveFFZSzhDL0cvdXVIZGU1RlR3L1VaQ1c2RHFwcDkyUnhB?=
 =?utf-8?B?bUhxRnAzTTRqSGN3OTQ5Z1g3OFo5OFlQbC9TVG13UkErc2NYS0RuZ2YwRTQv?=
 =?utf-8?B?d253cFQySkgvMm83NFBodmtGSmo5aDYyQnNMREZ3aklqUjRiTkczRGd5dGN6?=
 =?utf-8?B?aU9ucnp5NUM1SndNSjJ5ZnVrZFlzOHhIV3o2bWVOV21nTTM5N0pPRktsbjNT?=
 =?utf-8?B?Y2V6Um1vbmFHQmtqRERDYW1UVWF1UWtqYlp6M0N2UUpPa2dGSVVnYjdCWWIx?=
 =?utf-8?B?eHJyMHdwSzdPT3BhRzF0cDdUR0QrSXJEMkFqNTlRZVJ2UGJScWh5cVEybFIr?=
 =?utf-8?B?aS9JZVFqWHBYKzZINUF2YndkcnF4L2VaanU5VFlUUzAzMTVYeVNvRmNJQW96?=
 =?utf-8?B?L3FTTnhNNEpUdFVFZVZEQUxNNm9rSzVHOFJVdUFDMkxBQWtuZi9DY0FHUm1P?=
 =?utf-8?B?aE1tajBBd1RZMm9aT3RSbUErcnRXV2NVZkkzRjh6WU9lZ2dQaXFpZkNXN2Ev?=
 =?utf-8?B?a3I2QUZhVWdrZXlUNUphT3NuSktGeGpYSlpwVWdZbFlXMUdBVTZqaHZ3Zzlq?=
 =?utf-8?B?RVpHM3pnTUF5NzJQejYwUVVnN21WZ1NTMDEzYmU1bVZWWXV5Y0JGb21ScVFG?=
 =?utf-8?B?dkc4QmVlemZETmZjTEJhMitrYkZ4MzFwRVFtcGFVNktxbkJhSzYvR1J4TEhW?=
 =?utf-8?B?NHl5aFNNM0R2S2J2Mnc5SlNXNWtKWWtlQUJkRk5PTlFoWVM3MjZxcUd3V3Fj?=
 =?utf-8?B?cGVZT2g0T01WQVFXZmRtQmZTNGlzM2VyZnUyd2lkNUNCWUpJTmdrVUZ5b0xo?=
 =?utf-8?B?SnRZeHVjT0tRREdyc0M2anV6SHM5amluUENCQ2Y3WVNmdGdUTkNBa0lhUmxE?=
 =?utf-8?B?akZWVDJyVCtxSFJpK0Q0dVVuc3o1clRPb0djUUZEVGRrdUR4SlhUdDNBemln?=
 =?utf-8?B?RVQ5SUpGckFVdUNyMllWWk9OQm9OL1FRTkJNeFZlUThBSzIxM21QSHJISytN?=
 =?utf-8?B?OTVmcSszbmY5Y0M3ajBENFk5MjJBWHFpZWs0bk4rNUxHRTVTVFoweDdOZDA0?=
 =?utf-8?B?bnFDSlZ5L0VrVjZBOGlTU3p4ZndMT1NmMjdaa1pCSk9KSkRsVkdYYXM2bVo2?=
 =?utf-8?B?N1BEZjAxMEFvcVZZaEQ3emd4TFBRMTBOOGtSQ0ZGVkVxUVkvREFXV3dXWGNy?=
 =?utf-8?B?VmY0ZDFCejQrY3RkM0FNczdvaFNVOTRTdTNMcW5ldFI1d1ZCSEpTVk41c0N0?=
 =?utf-8?B?ZHBOMGtKYzlVTHRiT0cxRkVmSXZYRnFWNG9iOFl3MWM2aktFNEVpeDF1c2o2?=
 =?utf-8?B?MkpGSGt1SmFLbjZKWlAwUnBmWFI3UXAwa3pYOFFQWm4yYnNORm5vMXZ5VlBh?=
 =?utf-8?B?ZUxqYm9wd0Nsd0pzZVZ6eDlLVUNBUXcyaG0wdVFBM1BMSzV0Wkp4a3NzaHl6?=
 =?utf-8?B?NzZlVmZkb0ZKT3lQcHZ1Yzl4T2RMZlN6OE03SkdFejBkMWpad1ZnTzgrd3JV?=
 =?utf-8?Q?lYGjlaRwGIIRD44dgKWoSHs22?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3202df-da60-42b2-624d-08db82f340b2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:15:47.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJjzkdnXXodqzJv4z0ZE2dLtI9Q0V6fyOswvNn1/noL6HXSwmY34TijOuIKeNVH1arNZMV3SaEJf2C6PlS6t0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/29/2023 12:46 AM, Srinivasan Shanmugam wrote:
> Conform to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: please, no space before tabs
> 
> And promote sysfs entry for set/get srm to kdoc
> 
> Suggested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 50 +++++++++++--------
>   1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 5536d17306d0..308f2b0687b5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -576,7 +576,10 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>   }
>   
>   
> -/* NOTE: From the usermodes prospective you only need to call write *ONCE*, the kernel
> +/**
> + * DOC: Add sysfs interface for set/get srm
> + *
> + * NOTE: From the usermodes prospective you only need to call write *ONCE*, the kernel
>    *      will automatically call once or twice depending on the size
>    *
>    * call: "cat file > /sys/class/drm/card0/device/hdcp_srm" from usermode no matter what the size is
> @@ -591,19 +594,19 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>    * cannot throw errors early as it will stop the kernel from writing to sysfs
>    *
>    * Example 1:
> - * 	Good SRM size = 5096
> - * 	first call to write 4096 -> PSP fails
> - * 	Second call to write 1000 -> PSP Pass -> SRM is set
> + *	Good SRM size = 5096
> + *	first call to write 4096 -> PSP fails
> + *	Second call to write 1000 -> PSP Pass -> SRM is set
>    *
>    * Example 2:
> - * 	Bad SRM size = 4096
> - * 	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
> - * 	is the last call)
> + *	Bad SRM size = 4096
> + *	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
> + *	is the last call)
>    *
>    * Solution?:
> - * 	1: Parse the SRM? -> It is signed so we don't know the EOF
> - * 	2: We can have another sysfs that passes the size before calling set. -> simpler solution
> - * 	below
> + *	1: Parse the SRM? -> It is signed so we don't know the EOF
> + *	2: We can have another sysfs that passes the size before calling set. -> simpler solution
> + *	below
>    *
>    * Easy Solution:
>    * Always call get after Set to verify if set was successful.
> @@ -612,14 +615,14 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>    * +----------------------+
>    * PSP will only update its srm if its older than the one we are trying to load.
>    * Always do set first than get.
> - * 	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
> - * 	version and save it
> + *	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
> + *	version and save it
>    *
> - * 	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
> - * 	same(newer) version back and save it
> + *	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
> + *	same(newer) version back and save it
>    *
> - * 	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
> - * 	incorrect/corrupted and we should correct our SRM by getting it from PSP
> + *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
> + *	incorrect/corrupted and we should correct our SRM by getting it from PSP
>    */
>   static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
>   			      loff_t pos, size_t count)
> @@ -681,12 +684,15 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
>   	return ret;
>   }
>   
> -/* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
> +/**
> + * DOC: SRM should be persistent across boot/reboots/suspend/resume/shutdown
> + *
> + * From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
>    *
>    * For example,
> - * 	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
> - * 	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
> - * 	across boot/reboots/suspend/resume/shutdown
> + *	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
> + *	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
> + *	across boot/reboots/suspend/resume/shutdown
>    *
>    * Currently when the system goes down (suspend/shutdown) the SRM is cleared from PSP. For HDCP we need
>    * to make the SRM persistent.
> @@ -699,8 +705,8 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
>    *
>    * Usermode can read/write to/from PSP using the sysfs interface
>    * For example:
> - * 	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
> - * 	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
> + *	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
> + *	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
>    */
>   static const struct bin_attribute data_attr = {
>   	.attr = {.name = "hdcp_srm", .mode = 0664},


Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
