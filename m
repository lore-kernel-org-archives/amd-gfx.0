Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEC3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 15:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82836EB10;
	Thu,  2 Dec 2021 15:01:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F7B6EA6B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 15:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbS4jZhqp+kdClLZYqcNdtFwaK98SxunFLD0/HNsxPjG/D9AXwjwdC+p8lcHMQsTipOXQ05q8g4vc7x48ZKso4/fqZmIdPUjusm+MOyV1O11sNsnqXvqoW9d7tM0yz4Drrxm++1pX8JO0T1zWz52Fyb8yriVCmzZzkf26704tErDtxSDdLdLX3yxXIwBYoBX2bjIgX7oroMdY7/YNhGzdeT44xycYBozrb7+fkSchzzKYYH3JZu0IwphiV35pZwdqPo81dlksr/RvEsJOOOkeLQtEpKjTVl/aA0pzmNs8Fn/8qghdcPn33wHBIyFQN+7QkDlxYXXe1o7428hQcW/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1GhjnBneGoxIkHPe+G6xM0NvCWNN+8FK0AfpBLO3j4=;
 b=CKKURXVKzrTwvvJ4aEw6Y2YOj5yjgyKlRCmRDf+pdcFZ3iwvpNf4G5tu0RkxtJ5MCv5IrxXHjHHzYoY26P7dRoQnSD1eu1jY8wrlwwiSadg/9R4E1A5aFDPmFTmwyD3FLMdBnv7Y4NkOGbIERv1Pa0arwE3UGwqm3b8SRyGglVrWcWEwLbWVBUppicVoO5lQ1g5aNpg+xqh+DNVL5NwgItzlRnUQRc3x8TbYln+92ho8Kw0ACF3udyLgtyIRC99GC7YNbINE6ngEy4eTl1UX6cnDcZRIiQHNlnBNVjrzf0CKfI8ua+v2tfr+1/am7xUXWTAr9r89zqCfh507+vXu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1GhjnBneGoxIkHPe+G6xM0NvCWNN+8FK0AfpBLO3j4=;
 b=5B7jc9v+JMlv8exRYaOlTXMCNgLoakEwj05QOX3b/CtkkWQ2IHCdPl17SMEnVvNgfW5228ZzHFuwx27xoQo0gwUqf6TULg7B1s5ZlXjmHA6aCmDmS1y/OJjp6EHBs1esqZeiqhn37cxcRWHBbCJUlcNyoPRXlU5fv7NQAz6fz08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Thu, 2 Dec
 2021 14:45:26 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 14:45:26 +0000
Message-ID: <7311776e-025d-5a26-30ef-c291306e2803@amd.com>
Date: Thu, 2 Dec 2021 20:15:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 09/17] drm/amd/pm: optimize the
 amdgpu_pm_compute_clocks() implementations
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202030930.1681278-1-evan.quan@amd.com>
 <20211202030930.1681278-10-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211202030930.1681278-10-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bf::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Thu, 2 Dec 2021 14:45:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 007970b8-b7c6-413d-b528-08d9b5a2606f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30202D8BE0A0936FF99DC77497699@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lp5nuT0qCIqvZnUTx5252DPnVbWf6ujHWsHVyEkUk1mtqgV1WTdKgBSthJoOuEnLnk1dl8tngk7wXyArbY42FG11Okp+p6JgX8SKrr9Dfigb2CVYqqnZwiVzBaoaPPnc7olSTrHSgma4yXm3ca9QHREFGHP9ZwlKjhUijuDBdN9j8j+SScNTHBlrmr92PI0y2VGg9auhYBHrcD2aN/wgDbyjjPgE+tiEEtO5J1o1fUn3bIYE9LkiPgu33NeFdiXk67qbJZKF8XpqzU5cfQV6t6IfrEHzSJ+YwGiUS7sXCO9WYeptVrkU+gyYfFphHza+vtRfo9EKd9y1Cr+UtfZhuPW7YrJzBRfBaleAd23bOlfkCHgeTCTwBiqvPALcuJszZkQyGEVhfNl9vJD0+hTi4yieEXshHsKBiSCeok5gwT2xbdnCoZsdQu8E58zCHTExWSgprlgSaIfBs5stke4I4cbQynQhw9jYJOydjcMQinQUOtlvC8g09xFWdx1Wu8swy2UZg95sTujWr7KOHkBhDbH1UJib00HJJaEH8Il3fr4IesBOnWm7R+vPDDjhnV0/4UG2/lPfPA1mOti0EJnb3I2Zq2yXI1lTisVkMSEUAo6uRQawfNn9Xv27DXZ956SNc8lxRebmt0bVBtUA4QD1cI1vFP/TKEGPyef0jiIE/sF7kB8Hg/kMh4FoqzjLJRXuNMWQv0I99PTJ2du4uqlp0CZlO8mF9ekPnuV5UYN63ZCD42bLB/WEHa/f7Y56Y0xR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(86362001)(956004)(36756003)(38100700002)(508600001)(31696002)(8676002)(5660300002)(2906002)(4326008)(66556008)(6486002)(26005)(8936002)(186003)(316002)(16576012)(66946007)(66476007)(30864003)(53546011)(31686004)(6666004)(83380400001)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBTcWFqVFRGYUZjNlg0U2prcTVKUjhpbXdJMUpkTExtaUxQZkFuZ3NjUG9V?=
 =?utf-8?B?VWlIZmNGYTRzTzNrWTRxSU5xQVk0TzdaVmVBT3FOb0lkTTFhMmFQQ1FYQXU5?=
 =?utf-8?B?a2o0Zk1vSDBiclR4VXdNTWtwMHd4Z2padnVXcXJNM1lzQmwxNDZpSUFjVlAx?=
 =?utf-8?B?SDc0UUc0NkUrNVZWTUM2NWlRdnk2NUFyN0hrSE1XVVNWYnpkekJQSm42WjhP?=
 =?utf-8?B?RVF0bjJka2NPU25lSFBHNXVVRGtPTTRQMjdoWG92dkJGeXNBZnFNdEVBelZX?=
 =?utf-8?B?eGdaVmJ5cnhCYnNQc2hKbGp6Ulc1c3BhOWM0OHorcWRwaG9iMHRzTlFWNXgw?=
 =?utf-8?B?U28vak1abFdpc21DZ2xTYk1icFlXRkZUNmpSWUtiVUtueGN6NWE0cGdIM3Ux?=
 =?utf-8?B?OFVvUnlOY015MDFIOUlWT0dsNmJ3aDVEaXVaQ2Z2QXhGdnJjWGtFSlBkRVhF?=
 =?utf-8?B?Q2dicC9NendWTEdIZDYzL0xERk5taDk0UHNqOEJvaEVialE5RDc3NUpOenZj?=
 =?utf-8?B?UEh2T1hUWFoxVkIwU3pBbEE3TXpyWlhONFlIV2ZZMmhvZldibnBMd0ZPVDB4?=
 =?utf-8?B?V0NENmJQNGpUNEN4a1BTS0lNdlV1YTJFY3h0b2JnbE1PdjZ1M2hxRUhqU0JC?=
 =?utf-8?B?ZnNtTTZwKzFRWTB3c3daWVRwOHZicXJ1YjhwQWs3cjF0UnI3WTZlUVlPWlRi?=
 =?utf-8?B?b04rL2poWExxS1hpcUF3TlZhYVdsL21vZHRqRi9iS1ZPdEhHT2ZLUjFOcW96?=
 =?utf-8?B?TUduQU96TXZpWENDa1hnbW9VNnpwa2JyMmZXRGk0L01uTW1SOVdiUXQ2Q3F4?=
 =?utf-8?B?RFZnWXhlRWtaUC9zZm1tR3pJaUh2VjE2K2szdE14N3VGNVlhb2ZZZDhlbEFI?=
 =?utf-8?B?eHpBTXNnVDBwSjcrcVc1bkpaZ0xnTFFqbnlyUDllQnViOFVxU1NYWW11MDhs?=
 =?utf-8?B?MXUwOVhUbzhrTkFScU9XNThWQ1JQS0Mwc1RQWkwybnRuUCswSWFJdm5heWdp?=
 =?utf-8?B?OWpsSWh0WEZoRWhYVktMTTFyVEFMWk11MUlQNEUxdGFOMGtOQkZ1YWJHV3dm?=
 =?utf-8?B?dzdRcUVMekZ4aTliZGFERysxRkZQazlKUWk2N29NcC84bzRTWjl4WkhVTWkr?=
 =?utf-8?B?L3oxVlF5SjlJanFtb3Z0b2ZyNzZsTWwyYjE2UWIxTTgrU3JLWGxtNnFNdkMw?=
 =?utf-8?B?T1AvZXJCNVZ4TVFhbytOZTFPSnpwdFA3b0xiNkpUcHZaaktMU0NIdm4zNjBC?=
 =?utf-8?B?dmd0VVN0TW1FU0x0RndlMmtaTlhmV1FFNUkvK1dZbnFIN1Z6R3dLSzhFeTls?=
 =?utf-8?B?RnZIQ1ZWUXNiaHNPMEdxYmwrV3JSOHB2OUZYR1N3NmJ1TzVNR1dIZHdMTjUx?=
 =?utf-8?B?N2dFcUsxSzZLYTJNRXBZckx3M2lmMWpJSElwTTAza1dUMitFZVZoVmQzaGJk?=
 =?utf-8?B?YjdqNVRqNlZrNnZKOGRWcHM0ejg2ZWkzQjdZSnZENkc5dnhlZndENnF5VFk5?=
 =?utf-8?B?aWxCQW81WnM5K2d2cHBCeFpRcmx1cTMvZ2tEUDNlc2txUG5yQjI0UktiZ0xE?=
 =?utf-8?B?c051cnVuRU5peWtleERTV2JFMmdHbC9zOFdISy82VHJpRWkzeE4vRmJoOXIx?=
 =?utf-8?B?bGp5aTZDdjdrTlJhY2ZqSmFuRUtGeDZEYlhteUtDSWxxRGFiZGszQURZM2U1?=
 =?utf-8?B?VUZWMVdhK3d3NUVYaE1UZUkvRTFsVXRmcndQMkNXTXJjdTlXQjh6emtCVFo3?=
 =?utf-8?B?bUViaEZEL01CaXRUb28yVXNFKzN6UUlDekxkbHZZTHJlYUVoanVEWlE0SER0?=
 =?utf-8?B?ajZnbkIwUTFNMnFkbW94aXZpelFGNkdXb3p2L0dwTWRCVlUzNEZWYlF1cklX?=
 =?utf-8?B?UlBqWGMrNjdYampOTE8xZGkxOTF3QnBUU1lSOTNyQXl0SFU4eWNFcGpSMVVS?=
 =?utf-8?B?QjVmV3FPdFdnWEpsVjNIZ1BtUUU2NXBkdWF3ZnpQSUFGZkVadE00eisrUEJB?=
 =?utf-8?B?VDBWUjVmTmhZYktSWis2UER6K1FFWUZ2b2p4Rkd6c3lSRVpuQ0lPKytzQTRK?=
 =?utf-8?B?QXVTRjFCYTRNSlRGSWdSVEVxYjZPODZXUTd5RWg4cWNKVmVyYmw4R1l4eXFO?=
 =?utf-8?Q?gkdY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007970b8-b7c6-413d-b528-08d9b5a2606f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:45:26.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRfWKea3xh5x6caReOG66kmat7FhQ4LF3jCNXvo/XUTBVsRIbC7faRFXQK6Vd5Z2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/2/2021 8:39 AM, Evan Quan wrote:
> Drop cross callings and multi-function APIs. Also avoid exposing
> internal implementations details.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I55e5ab3da6a70482f5f5d8c256eed2f754feae20
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +-
>   drivers/gpu/drm/amd/pm/Makefile               |   2 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 222 +++---------------
>   drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |  94 ++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   2 -
>   .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  32 +++
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  39 ++-
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |   6 +-
>   drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c |  60 ++++-
>   drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h |   3 +-
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c     |  41 +++-
>   11 files changed, 295 insertions(+), 208 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
>   create mode 100644 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index cdf724dcf832..7919e96e772b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -404,7 +404,7 @@ struct amd_pm_funcs {
>   	int (*get_dpm_clock_table)(void *handle,
>   				   struct dpm_clocks *clock_table);
>   	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
> -	int (*change_power_state)(void *handle);
> +	void (*pm_compute_clocks)(void *handle);
>   };
>   
>   struct metrics_table_header {
> diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
> index 8cf6eff1ea93..d35ffde387f1 100644
> --- a/drivers/gpu/drm/amd/pm/Makefile
> +++ b/drivers/gpu/drm/amd/pm/Makefile
> @@ -40,7 +40,7 @@ AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
>   
>   include $(AMD_PM)
>   
> -PM_MGR = amdgpu_dpm.o amdgpu_pm.o
> +PM_MGR = amdgpu_dpm.o amdgpu_pm.o amdgpu_dpm_internal.o
>   
>   AMD_PM_POWER = $(addprefix $(AMD_PM_PATH)/,$(PM_MGR))
>   
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 9b268f300815..e0ea92155627 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -37,73 +37,6 @@
>   #define amdgpu_dpm_enable_bapm(adev, e) \
>   		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
>   
> -static void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> -{
> -	struct drm_device *ddev = adev_to_drm(adev);
> -	struct drm_crtc *crtc;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -
> -	adev->pm.dpm.new_active_crtcs = 0;
> -	adev->pm.dpm.new_active_crtc_count = 0;
> -	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> -		list_for_each_entry(crtc,
> -				    &ddev->mode_config.crtc_list, head) {
> -			amdgpu_crtc = to_amdgpu_crtc(crtc);
> -			if (amdgpu_crtc->enabled) {
> -				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
> -				adev->pm.dpm.new_active_crtc_count++;
> -			}
> -		}
> -	}
> -}
> -
> -u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
> -{
> -	struct drm_device *dev = adev_to_drm(adev);
> -	struct drm_crtc *crtc;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -	u32 vblank_in_pixels;
> -	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
> -
> -	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> -		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -			amdgpu_crtc = to_amdgpu_crtc(crtc);
> -			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> -				vblank_in_pixels =
> -					amdgpu_crtc->hw_mode.crtc_htotal *
> -					(amdgpu_crtc->hw_mode.crtc_vblank_end -
> -					amdgpu_crtc->hw_mode.crtc_vdisplay +
> -					(amdgpu_crtc->v_border * 2));
> -
> -				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
> -				break;
> -			}
> -		}
> -	}
> -
> -	return vblank_time_us;
> -}
> -
> -static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
> -{
> -	struct drm_device *dev = adev_to_drm(adev);
> -	struct drm_crtc *crtc;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -	u32 vrefresh = 0;
> -
> -	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> -		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -			amdgpu_crtc = to_amdgpu_crtc(crtc);
> -			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> -				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
> -				break;
> -			}
> -		}
> -	}
> -
> -	return vrefresh;
> -}
> -
>   int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> @@ -432,111 +365,35 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>   	return ret;
>   }
>   
> -void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
> -{
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device,
> -			     pm.dpm.thermal.work);
> -	/* switch to the thermal state */
> -	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
> -	int temp, size = sizeof(temp);
> -
> -	if (!adev->pm.dpm_enabled)
> -		return;
> -
> -	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
> -				    (void *)&temp, &size)) {
> -		if (temp < adev->pm.dpm.thermal.min_temp)
> -			/* switch back the user state */
> -			dpm_state = adev->pm.dpm.user_state;
> -	} else {
> -		if (adev->pm.dpm.thermal.high_to_low)
> -			/* switch back the user state */
> -			dpm_state = adev->pm.dpm.user_state;
> -	}
> -	mutex_lock(&adev->pm.mutex);
> -	if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
> -		adev->pm.dpm.thermal_active = true;
> -	else
> -		adev->pm.dpm.thermal_active = false;
> -	adev->pm.dpm.state = dpm_state;
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	amdgpu_dpm_compute_clocks(adev);
> -}
> -
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   {
> -	int i = 0;
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   
> -	if (!adev->pm.dpm_enabled)

Isn't this needed? The callback implementations don't check this.


> +	if (!pp_funcs->pm_compute_clocks)
>   		return;
>   
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
> -
> -	if ((adev->family == AMDGPU_FAMILY_SI) ||
> -	     (adev->family == AMDGPU_FAMILY_KV)) {
> -		amdgpu_dpm_get_active_displays(adev);
> -		adev->powerplay.pp_funcs->change_power_state(adev->powerplay.pp_handle);
> -	} else {
> -		if (!amdgpu_device_has_dc_support(adev)) {
> -			amdgpu_dpm_get_active_displays(adev);
> -			adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
> -			adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
> -			adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
> -			/* we have issues with mclk switching with
> -			 * refresh rates over 120 hz on the non-DC code.
> -			 */
> -			if (adev->pm.pm_display_cfg.vrefresh > 120)
> -				adev->pm.pm_display_cfg.min_vblank_time = 0;
> -			if (adev->powerplay.pp_funcs->display_configuration_change)
> -				adev->powerplay.pp_funcs->display_configuration_change(
> -							adev->powerplay.pp_handle,
> -							&adev->pm.pm_display_cfg);
> -		}
> -		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
> -	}
> +	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>   }
>   
>   void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> -	if (adev->family == AMDGPU_FAMILY_SI) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (enable) {
> -			adev->pm.dpm.uvd_active = true;
> -			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -		} else {
> -			adev->pm.dpm.uvd_active = false;
> -		}
> -		mutex_unlock(&adev->pm.mutex);
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
>   
> -		amdgpu_dpm_compute_clocks(adev);
> -	} else {
> -		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> -		if (ret)
> -			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> -				  enable ? "enable" : "disable", ret);
> -
> -		/* enable/disable Low Memory PState for UVD (4k videos) */
> -		if (adev->asic_type == CHIP_STONEY &&
> -			adev->uvd.decode_image_width >= WIDTH_4K) {
> -			struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> -
> -			if (hwmgr && hwmgr->hwmgr_func &&
> -			    hwmgr->hwmgr_func->update_nbdpm_pstate)
> -				hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> -								       !enable,
> -								       true);
> -		}
> +	/* enable/disable Low Memory PState for UVD (4k videos) */
> +	if (adev->asic_type == CHIP_STONEY &&
> +		adev->uvd.decode_image_width >= WIDTH_4K) {
> +		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +
> +		if (hwmgr && hwmgr->hwmgr_func &&
> +		    hwmgr->hwmgr_func->update_nbdpm_pstate)
> +			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> +							       !enable,
> +							       true);
>   	}
>   }
>   
> @@ -544,24 +401,10 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> -	if (adev->family == AMDGPU_FAMILY_SI) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (enable) {
> -			adev->pm.dpm.vce_active = true;
> -			/* XXX select vce level based on ring/task */
> -			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -		} else {
> -			adev->pm.dpm.vce_active = false;
> -		}
> -		mutex_unlock(&adev->pm.mutex);

This mutex lock is dropped when implementation is moved to callback.

Thanks,
Lijo

> -
> -		amdgpu_dpm_compute_clocks(adev);
> -	} else {
> -		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> -		if (ret)
> -			DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> -				  enable ? "enable" : "disable", ret);
> -	}
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
>   }
>   
>   void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
> @@ -723,10 +566,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>   {
>   	adev->pm.dpm.user_state = state;
>   
> -	if (adev->powerplay.pp_funcs->dispatch_tasks)
> -		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
> -	else
> -		amdgpu_dpm_compute_clocks(adev);
> +	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
>   }
>   
>   enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> @@ -896,12 +736,9 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>   
>   	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
>   
> -	if (amdgpu_dpm_dispatch_task(adev,
> -				     AMD_PP_TASK_READJUST_POWER_STATE,
> -				     NULL) == -EOPNOTSUPP) {
> -		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> -		amdgpu_dpm_compute_clocks(adev);
> -	}
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	return 0;
>   }
> @@ -925,12 +762,9 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
>   
>   	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
>   
> -	if (amdgpu_dpm_dispatch_task(adev,
> -				     AMD_PP_TASK_READJUST_POWER_STATE,
> -				     NULL) == -EOPNOTSUPP) {
> -		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> -		amdgpu_dpm_compute_clocks(adev);
> -	}
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> new file mode 100644
> index 000000000000..ba5f6413412d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> @@ -0,0 +1,94 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_display.h"
> +#include "hwmgr.h"
> +#include "amdgpu_smu.h"
> +
> +void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +
> +	adev->pm.dpm.new_active_crtcs = 0;
> +	adev->pm.dpm.new_active_crtc_count = 0;
> +	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> +		list_for_each_entry(crtc,
> +				    &ddev->mode_config.crtc_list, head) {
> +			amdgpu_crtc = to_amdgpu_crtc(crtc);
> +			if (amdgpu_crtc->enabled) {
> +				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
> +				adev->pm.dpm.new_active_crtc_count++;
> +			}
> +		}
> +	}
> +}
> +
> +u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	u32 vblank_in_pixels;
> +	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
> +
> +	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> +		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> +			amdgpu_crtc = to_amdgpu_crtc(crtc);
> +			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> +				vblank_in_pixels =
> +					amdgpu_crtc->hw_mode.crtc_htotal *
> +					(amdgpu_crtc->hw_mode.crtc_vblank_end -
> +					amdgpu_crtc->hw_mode.crtc_vdisplay +
> +					(amdgpu_crtc->v_border * 2));
> +
> +				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return vblank_time_us;
> +}
> +
> +u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev = adev_to_drm(adev);
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	u32 vrefresh = 0;
> +
> +	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
> +		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> +			amdgpu_crtc = to_amdgpu_crtc(crtc);
> +			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
> +				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return vrefresh;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index b7841a989d59..b0791e855ad3 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -420,8 +420,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
>   int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>   			   void *data, uint32_t *size);
>   
> -void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
> -
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
>   void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
>   void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> new file mode 100644
> index 000000000000..5c2a89f0d5d5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __AMDGPU_DPM_INTERNAL_H__
> +#define __AMDGPU_DPM_INTERNAL_H__
> +
> +void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
> +
> +u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
> +
> +u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 20cb234d5061..d57d5c28c013 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -31,7 +31,8 @@
>   #include "power_state.h"
>   #include "amdgpu.h"
>   #include "hwmgr.h"
> -
> +#include "amdgpu_dpm_internal.h"
> +#include "amdgpu_display.h"
>   
>   static const struct amd_pm_funcs pp_dpm_funcs;
>   
> @@ -1678,6 +1679,41 @@ static int pp_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>   	return 0;
>   }
>   
> +static void pp_pm_compute_clocks(void *handle)
> +{
> +	struct pp_hwmgr *hwmgr = handle;
> +	struct amdgpu_device *adev = hwmgr->adev;
> +	int i = 0;
> +
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
> +	if (!amdgpu_device_has_dc_support(adev)) {
> +		amdgpu_dpm_get_active_displays(adev);
> +		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
> +		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
> +		adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
> +		/* we have issues with mclk switching with
> +		 * refresh rates over 120 hz on the non-DC code.
> +		 */
> +		if (adev->pm.pm_display_cfg.vrefresh > 120)
> +			adev->pm.pm_display_cfg.min_vblank_time = 0;
> +
> +		pp_display_configuration_change(handle,
> +						&adev->pm.pm_display_cfg);
> +	}
> +
> +	pp_dpm_dispatch_tasks(handle,
> +			      AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
> +			      NULL);
> +}
> +
>   static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.load_firmware = pp_dpm_load_fw,
>   	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
> @@ -1742,4 +1778,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>   	.get_gpu_metrics = pp_get_gpu_metrics,
>   	.gfx_state_change_set = pp_gfx_state_change_set,
>   	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
> +	.pm_compute_clocks = pp_pm_compute_clocks,
>   };
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index eed89835231c..72824ef61edd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -3088,7 +3088,7 @@ static int kv_dpm_hw_init(void *handle)
>   	else
>   		adev->pm.dpm_enabled = true;
>   	mutex_unlock(&adev->pm.mutex);
> -	amdgpu_dpm_compute_clocks(adev);
> +	amdgpu_legacy_dpm_compute_clocks(adev);
>   	return ret;
>   }
>   
> @@ -3136,7 +3136,7 @@ static int kv_dpm_resume(void *handle)
>   			adev->pm.dpm_enabled = true;
>   		mutex_unlock(&adev->pm.mutex);
>   		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_compute_clocks(adev);
> +			amdgpu_legacy_dpm_compute_clocks(adev);
>   	}
>   	return 0;
>   }
> @@ -3390,7 +3390,7 @@ static const struct amd_pm_funcs kv_dpm_funcs = {
>   	.get_vce_clock_state = amdgpu_get_vce_clock_state,
>   	.check_state_equal = kv_check_state_equal,
>   	.read_sensor = &kv_dpm_read_sensor,
> -	.change_power_state = amdgpu_dpm_change_power_state_locked,
> +	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
>   };
>   
>   static const struct amdgpu_irq_src_funcs kv_dpm_irq_funcs = {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> index 67c84b7ad8e7..3c6ee493e410 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
> @@ -26,6 +26,8 @@
>   #include "atom.h"
>   #include "amd_pcie.h"
>   #include "legacy_dpm.h"
> +#include "amdgpu_dpm_internal.h"
> +#include "amdgpu_display.h"
>   
>   #define amdgpu_dpm_pre_set_power_state(adev) \
>   		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
> @@ -949,9 +951,8 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
>   	return NULL;
>   }
>   
> -int amdgpu_dpm_change_power_state_locked(void *handle)
> +static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ps *ps;
>   	enum amd_pm_state_type dpm_state;
>   	int ret;
> @@ -1022,3 +1023,58 @@ int amdgpu_dpm_change_power_state_locked(void *handle)
>   
>   	return 0;
>   }
> +
> +void amdgpu_legacy_dpm_compute_clocks(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i = 0;
> +
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
> +	amdgpu_dpm_get_active_displays(adev);
> +
> +	amdgpu_dpm_change_power_state_locked(adev);
> +}
> +
> +void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device,
> +			     pm.dpm.thermal.work);
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	/* switch to the thermal state */
> +	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
> +	int temp, size = sizeof(temp);
> +
> +	if (!adev->pm.dpm_enabled)
> +		return;
> +
> +	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
> +				   AMDGPU_PP_SENSOR_GPU_TEMP,
> +				   (void *)&temp,
> +				   &size)) {
> +		if (temp < adev->pm.dpm.thermal.min_temp)
> +			/* switch back the user state */
> +			dpm_state = adev->pm.dpm.user_state;
> +	} else {
> +		if (adev->pm.dpm.thermal.high_to_low)
> +			/* switch back the user state */
> +			dpm_state = adev->pm.dpm.user_state;
> +	}
> +
> +	if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
> +		adev->pm.dpm.thermal_active = true;
> +	else
> +		adev->pm.dpm.thermal_active = false;
> +
> +	adev->pm.dpm.state = dpm_state;
> +
> +	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> index 7ac30f1aed20..93bd3973330c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
> @@ -32,6 +32,7 @@ int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
>   void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
>   void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
>   struct amd_vce_state* amdgpu_get_vce_clock_state(void *handle, u32 idx);
> -int amdgpu_dpm_change_power_state_locked(void *handle);
>   void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
> +void amdgpu_legacy_dpm_compute_clocks(void *handle);
> +void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 35d287903aea..e3b58249c6f4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -3891,6 +3891,40 @@ static int si_set_boot_state(struct amdgpu_device *adev)
>   }
>   #endif
>   
> +static int si_set_powergating_by_smu(void *handle,
> +				     uint32_t block_type,
> +				     bool gate)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	switch (block_type) {
> +	case AMD_IP_BLOCK_TYPE_UVD:
> +		if (!gate) {
> +			adev->pm.dpm.uvd_active = true;
> +			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +		} else {
> +			adev->pm.dpm.uvd_active = false;
> +		}
> +
> +		amdgpu_legacy_dpm_compute_clocks(handle);
> +		break;
> +	case AMD_IP_BLOCK_TYPE_VCE:
> +		if (!gate) {
> +			adev->pm.dpm.vce_active = true;
> +			/* XXX select vce level based on ring/task */
> +			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +		} else {
> +			adev->pm.dpm.vce_active = false;
> +		}
> +
> +		amdgpu_legacy_dpm_compute_clocks(handle);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>   static int si_set_sw_state(struct amdgpu_device *adev)
>   {
>   	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
> @@ -7801,7 +7835,7 @@ static int si_dpm_hw_init(void *handle)
>   	else
>   		adev->pm.dpm_enabled = true;
>   	mutex_unlock(&adev->pm.mutex);
> -	amdgpu_dpm_compute_clocks(adev);
> +	amdgpu_legacy_dpm_compute_clocks(adev);
>   	return ret;
>   }
>   
> @@ -7849,7 +7883,7 @@ static int si_dpm_resume(void *handle)
>   			adev->pm.dpm_enabled = true;
>   		mutex_unlock(&adev->pm.mutex);
>   		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_compute_clocks(adev);
> +			amdgpu_legacy_dpm_compute_clocks(adev);
>   	}
>   	return 0;
>   }
> @@ -8094,6 +8128,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.print_power_state = &si_dpm_print_power_state,
>   	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
>   	.force_performance_level = &si_dpm_force_performance_level,
> +	.set_powergating_by_smu = &si_set_powergating_by_smu,
>   	.vblank_too_short = &si_dpm_vblank_too_short,
>   	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>   	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
> @@ -8102,7 +8137,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.check_state_equal = &si_check_state_equal,
>   	.get_vce_clock_state = amdgpu_get_vce_clock_state,
>   	.read_sensor = &si_dpm_read_sensor,
> -	.change_power_state = amdgpu_dpm_change_power_state_locked,
> +	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
>   };
>   
>   static const struct amdgpu_irq_src_funcs si_dpm_irq_funcs = {
> 
