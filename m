Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76227C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 06:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE8810E1F2;
	Tue, 21 Dec 2021 06:17:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA2A10E1F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 06:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzs0tN8o/kz3bUs5uO/icf0bM2ZlP1A2+7b8omHC1A7FGKBbkbUJQXjSZVCCXWMk2W25AavAADm0ST+64SkDYq3QoB/5cwsEBPcvRad+ZmC8hv2FBceTUSuI7HW2XlRC6VUY//fzmRXkGxI7GP0rpsFllnGbeRz/E9gP2dzBZLmkygyR3cPOmYuaz+0xAVKITgWNzUxhk07GZpJOYLrTuEzk7Y2C30IRrEHAvWgyz8DX8lpttydocoEVGw94d3/0biDHiUZWjfNgZX5ELUs3podOSu/WUWfzR/x7U2BPPQ07Is2nvw/KHhlPWULtiDpvQbcJMyoLgE15/fGRHiYsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C95kjHJ9syV7Lhc6VWVOkyR9AMzxqHkMTBH9GAF7ssc=;
 b=koA/t/kxWxUii4W6SfqYx8XFi59A4Zik6m+twP0kCg3SMaXQLh+gAFx4kj+qecn8/s1L59WTAR9xp6GsSX2QEb8v0vWSZdp5xe0uM+BGapOkt1t8T240K85LapM9CTkR4hUyJwP1KdihuQe91KuSkQWM95K/t4nLcNIqaGEzNXMgH7UeQBr5kyM3/LymqYXSgyDBFXB5C1V+DAn/gqwzUDBnT2NVjO6V9aifyqLIIzaQc6eADvA+zXTvrdqyH/Atxz6EHW5f1KquB3kmGzSwTReA3yQDzQ6SZtc3cIsDtBqhUBwrw/LrTlIc3z5OQoGFMxwzqv/GJEUumQi1uHAETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C95kjHJ9syV7Lhc6VWVOkyR9AMzxqHkMTBH9GAF7ssc=;
 b=1bOQg30pSD874yoGb5e6CqVXGvd7LtX2No5mWPto6hbpCdl08vYe4iYYbpaB1Tc0psvf/ZtbDuxW8q8UYxCI4JYZgBkA8lPvExP00IE7HhLJO8f6Ni+Ikh2oLnl+v57PVhqgrGBGgoT1dFJ17AbAYkP3FRSXERgzZXcG/wzjNac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 06:17:25 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 06:17:25 +0000
Message-ID: <bc61210c-1b95-1e90-20a2-2194b58316ed@amd.com>
Date: Tue, 21 Dec 2021 11:47:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V5 05/16] drm/amd/pm: do not expose those APIs used
 internally only in si_dpm.c
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211213035223.772700-1-evan.quan@amd.com>
 <20211213035223.772700-6-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211213035223.772700-6-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d63b9be-51c7-406f-3b2a-08d9c4498e5c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41375BA14723FD57EE4BC3EB977C9@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlKfIXfFB9C6bpGljKDxLbaf6IxfHvUlKljdF/UFRwOIgia+VCHbY0wM8+RwZAuJ+Loj/1X4Rp5iqqrgSI9zXk8KIwxyE3pOup/qlcsyg5mtZXTxuPmBqKodywYNfQm+/XOGYMP7v8mWlH+YmpMeH1mnDsVGRGmiSZW9Boj9nLf0JzY4xgshl4XKIbHFzExAVIKtcVt3aF0MyBEeaKRb9qoRJ2soZQn9KwMKHprgGGiQxfBGvNTYN2yLkaYHtLVivIjXtVbDAaZXIcjLr1yDI/gI0Sr+7xFnMZmpNpf02Zun1vxfbIN92UqvnMEHBV4DJmVhw5B0GljRBFViElImW4Jy1SjVd07KRcSVE+lCP4hxmFyokL2GgucKH+jHLY4V3SFZ14JSNM71vL5KfMAl4Errw+VP6g5PL7qXSJr0p7Hmhd/NS2uJJZmLuD/oAb1lDQDi2E9HG46qWHsbyKTKXfgzvBX/GtVTjBP7pojOL2pUZCJTlo/SQytwrDpT8TDbZ92nWaxATVfxsgi4kZxMsWQT35/iCRkO7NerWzhMNfJMFc50o2lfH5/aoVMGoZrlY+yQpgVZfQ8j81Zg7ekG7bG6/UneIh6oIdWVgWP+V/lldN4wOF8ny9VJd/5ZmAm2ZmFDNA3/9wICiV0/F4Ne3t2OimZ7IUf8eLNsrVFmpbFvgwZvd2lSmxvU+bPWS2wiWP24+yt43fUEwu00AW8P8TCpw20R+HQoueIlEPHO178=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6666004)(66556008)(508600001)(66946007)(4326008)(66476007)(8936002)(36756003)(186003)(6512007)(6506007)(53546011)(26005)(8676002)(5660300002)(38100700002)(316002)(30864003)(6486002)(2906002)(31686004)(31696002)(86362001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azNpZldoVWU0eHpRRjJHcjdwRWdCblNmVGhwcENHOWFkQmRaamNvbUZER1kw?=
 =?utf-8?B?MDF3aTVNS2FzUk5DdEN4Szd4UC9kZEtHKzAzVmRQbVB6aVE2Q3lRMEV6TjZS?=
 =?utf-8?B?NHQ1dEpIVWE1d0tFVFR2ODNwWEk5dG5raW5iM09QdUx4cnRzUElEVzdDYU1C?=
 =?utf-8?B?ZkhnY2U4VTRuQjkrQ1lJdktiSUxYNW9qb1c0UjBTVHUzbUgvdmxpZDNlcGoz?=
 =?utf-8?B?Z3cwVFVyYXlhSjVsNEVEeDNmOEdJQzVWbzYwWU45VVpscFNtdnhhUkN1MnhG?=
 =?utf-8?B?YVpxOXJaQ2xwVkV4MVNRS3lKMkMvNlpYOUF2QkUxUm14NFM3MTBNS3FuSDNK?=
 =?utf-8?B?Uk02VHNFb3NFZzNCMjh5NGVBV3ZxMWhPdDVDMlFXMGZnSWNIL2pFQVN3QlBC?=
 =?utf-8?B?Um1uK2luOUN6SGxjQWFDcmU1QTF1ajBrNUV0YmI0UHRubHlnd1ZzdXRQbVBC?=
 =?utf-8?B?Z2hCVFRQZTF6RndBZ3cvZW1BZGM4VjRXTjlvRWVpbCtia0c5WDV5N000bU9s?=
 =?utf-8?B?VzBSZUcxNWt3QUJBdC9ybVdydmRUT0hReFN1UDAyRVVncXFsVGkvVExyNGxI?=
 =?utf-8?B?dnFqdzFnVmFNaTFDcU9XZ1Q3RWFCempIM0RoVEJvZnVlbjAyS1lwS3E1dVli?=
 =?utf-8?B?VzN2R1lNVTVUZ1VyRGoyNlNaRG00UDBxR0duOVNEMFFUS3FYTWFJMXJLa2Jn?=
 =?utf-8?B?eVFZZ1lyOURYdm5PMHpTQWcvNFRRaHBpQUQ3TWg5RUgwTkhKc0FmMXMvbkky?=
 =?utf-8?B?TGc5THIyV3ZUcjVES3lKb3p2UUY0b21rNTVVaVlIUU9pM3lITXZ2TUMrN0tG?=
 =?utf-8?B?eUQ4WXM3U2w3Qi9mOUQwWFRYMEdMM2tQRkN6ZDZNdUt5SVBabXRaVC9uQzJX?=
 =?utf-8?B?SC9HMFJNUDhhUG1NTHVqSlZJdTFQVE1lSlM2bXcrbEhJUi9jbWhZOTJ6SUxI?=
 =?utf-8?B?dW9tTU53SGI0ODFjcFdkWG5Scmh3QUVrRzlLd25DVVRJdHMvRml4QU56OGg4?=
 =?utf-8?B?cU9IRkNjOWtaSDVHQWJDaWxWdmdRRjNnbHkrMUJwVWJMTlhCR2NrdTRZOFZU?=
 =?utf-8?B?N3VpWERXR0FSa2tLS0J6V1pnZ09BcEVhdEN1SmFUZjlHYWNWdVZxRk5hQ2Ja?=
 =?utf-8?B?dmZOVHEwSDFDMzBaZzViTzdJU1RoWG5qY2ZxQjF5Y3JWNHNFQmRGOGl3bDMy?=
 =?utf-8?B?azBJSnU5WkFyV1VlUm9NM2xrdHhBeWNZNXVQRkIwa3F6djZUaWR5MEFKb1FO?=
 =?utf-8?B?WDJUWThxdTMrZTFHY2dIRCt5Rnp1ZUdrUlBhTytQb241ZFhXTkpmRkV6eWpv?=
 =?utf-8?B?Q2h3S2MzdFVVMHR5dEY3SzFXK0o2bWphbW44SHpHLzJmOER1UnR3MkVwNDVw?=
 =?utf-8?B?aFZlY203Q0oyb1lzOHptRHpnNUlwS0kxWUljQi9zazgyVGo0VDJ6MHJaMjRl?=
 =?utf-8?B?OW56RXU5V3JTQTArVC9qSFdMc1FnWDUvVHhWb1ljSmRTUzY0MGl5dUNwekl3?=
 =?utf-8?B?cWRIVXFhZ2FyRklERVQ1MTgyeVkyY1JvVG9pY2M3MmRUWXRRaVNGa0JoYURz?=
 =?utf-8?B?NUc5Y2x2V25lNWZobThWM2pyUVlUd0JqUnRrVXJIeHRtdjhJRXk2RHl2VmFr?=
 =?utf-8?B?em5YLzdqdVpjWDR2SnpPbW9Ga1F2SVB3SDYzakRheUIveEQvYnN3YnEvbm9z?=
 =?utf-8?B?OFVuQmY2WVBxT1dFUVk1SXVNZ1ZTa3Ryakc4UzZJdnlnbEsvYUFWUkRVTzFn?=
 =?utf-8?B?Y0k4bDRBOHd4TmxtVEw4eUJ6Mkc2akR4TmNVM2tXVjU3Wmd5bG41ZkZoblpP?=
 =?utf-8?B?cDlkR0xURFF6NWNKSnhWbmNlUGRGZmoxZU1SK3pJY0Z4d0RhdW14ZnFRTk0y?=
 =?utf-8?B?K0YxSVZNeExGeHFRTEtQdjRUL2Y4cDdNQ29ucVhNS2hVbVR3emxjUUcxdURF?=
 =?utf-8?B?Tk54WVVXb29rWU8ySG1vN0lLUVUzNWx1L0x6VXkwL0xnSzgzYVptenNER1Vs?=
 =?utf-8?B?Tjd1cU5TWjFFeG1YOE1VMVZNckZSTkc0dW0yTlppa0xsMSsxTy9PYmYzTmJr?=
 =?utf-8?B?MHp0VWFzS0EvQ3kydFdpanYyMVhMREk4dlcvY0RwUi9DWEpGbXMxZ0QxUEw0?=
 =?utf-8?Q?k1U4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d63b9be-51c7-406f-3b2a-08d9c4498e5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 06:17:25.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5ssdlYlg87Jyg/w4u91r7uO5zmeOFe03SUmIZAJvwHg57C3+6LNLA5olkwSpC/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/13/2021 9:22 AM, Evan Quan wrote:
> Move them to si_dpm.c instead.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I288205cfd7c6ba09cfb22626ff70360d61ff0c67
> --
> v1->v2:
>    - rename the API with "si_" prefix(Alex)
> v2->v3:
>    - rename other data structures used only in si_dpm.c(Lijo)
> v3->v4:
>    - rename Macros used only in si_dpm.c with "SI_" prefix(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c       |  25 -----
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  25 -----
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 106 +++++++++++++++-------
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.h |  15 ++-
>   4 files changed, 83 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 08770888cabb..0f9e109941f1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -894,31 +894,6 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
>   	}
>   }
>   
> -enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
> -						 u32 sys_mask,
> -						 enum amdgpu_pcie_gen asic_gen,
> -						 enum amdgpu_pcie_gen default_gen)
> -{
> -	switch (asic_gen) {
> -	case AMDGPU_PCIE_GEN1:
> -		return AMDGPU_PCIE_GEN1;
> -	case AMDGPU_PCIE_GEN2:
> -		return AMDGPU_PCIE_GEN2;
> -	case AMDGPU_PCIE_GEN3:
> -		return AMDGPU_PCIE_GEN3;
> -	default:
> -		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
> -		    (default_gen == AMDGPU_PCIE_GEN3))
> -			return AMDGPU_PCIE_GEN3;
> -		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
> -			 (default_gen == AMDGPU_PCIE_GEN2))
> -			return AMDGPU_PCIE_GEN2;
> -		else
> -			return AMDGPU_PCIE_GEN1;
> -	}
> -	return AMDGPU_PCIE_GEN1;
> -}
> -
>   struct amd_vce_state*
>   amdgpu_get_vce_clock_state(void *handle, u32 idx)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 6681b878e75f..f43b96dfe9d8 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -45,19 +45,6 @@ enum amdgpu_int_thermal_type {
>   	THERMAL_TYPE_KV,
>   };
>   
> -enum amdgpu_dpm_auto_throttle_src {
> -	AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL,
> -	AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL
> -};
> -
> -enum amdgpu_dpm_event_src {
> -	AMDGPU_DPM_EVENT_SRC_ANALOG = 0,
> -	AMDGPU_DPM_EVENT_SRC_EXTERNAL = 1,
> -	AMDGPU_DPM_EVENT_SRC_DIGITAL = 2,
> -	AMDGPU_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
> -	AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
> -};
> -
>   struct amdgpu_ps {
>   	u32 caps; /* vbios flags */
>   	u32 class; /* vbios flags */
> @@ -252,13 +239,6 @@ struct amdgpu_dpm_fan {
>   	bool ucode_fan_control;
>   };
>   
> -enum amdgpu_pcie_gen {
> -	AMDGPU_PCIE_GEN1 = 0,
> -	AMDGPU_PCIE_GEN2 = 1,
> -	AMDGPU_PCIE_GEN3 = 2,
> -	AMDGPU_PCIE_GEN_INVALID = 0xffff
> -};
> -
>   #define amdgpu_dpm_reset_power_profile_state(adev, request) \
>   		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
>   			(adev)->powerplay.pp_handle, request))
> @@ -403,11 +383,6 @@ void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
>   
>   void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
>   
> -enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
> -						 u32 sys_mask,
> -						 enum amdgpu_pcie_gen asic_gen,
> -						 enum amdgpu_pcie_gen default_gen);
> -
>   struct amd_vce_state*
>   amdgpu_get_vce_clock_state(void *handle, u32 idx);
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 81f82aa05ec2..5bd7a24b70b6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -96,6 +96,19 @@ union pplib_clock_info {
>   	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
>   };
>   
> +enum si_dpm_auto_throttle_src {
> +	SI_DPM_AUTO_THROTTLE_SRC_THERMAL,
> +	SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL
> +};
> +
> +enum si_dpm_event_src {
> +	SI_DPM_EVENT_SRC_ANALOG = 0,
> +	SI_DPM_EVENT_SRC_EXTERNAL = 1,
> +	SI_DPM_EVENT_SRC_DIGITAL = 2,
> +	SI_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
> +	SI_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
> +};
> +
>   static const u32 r600_utc[R600_PM_NUMBER_OF_TC] =
>   {
>   	R600_UTC_DFLT_00,
> @@ -3718,25 +3731,25 @@ static void si_set_dpm_event_sources(struct amdgpu_device *adev, u32 sources)
>   {
>   	struct rv7xx_power_info *pi = rv770_get_pi(adev);
>   	bool want_thermal_protection;
> -	enum amdgpu_dpm_event_src dpm_event_src;
> +	enum si_dpm_event_src dpm_event_src;
>   
>   	switch (sources) {
>   	case 0:
>   	default:
>   		want_thermal_protection = false;
>   		break;
> -	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL):
> +	case (1 << SI_DPM_AUTO_THROTTLE_SRC_THERMAL):
>   		want_thermal_protection = true;
> -		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGITAL;
> +		dpm_event_src = SI_DPM_EVENT_SRC_DIGITAL;
>   		break;
> -	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
> +	case (1 << SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
>   		want_thermal_protection = true;
> -		dpm_event_src = AMDGPU_DPM_EVENT_SRC_EXTERNAL;
> +		dpm_event_src = SI_DPM_EVENT_SRC_EXTERNAL;
>   		break;
> -	case ((1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
> -	      (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL)):
> +	case ((1 << SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
> +	      (1 << SI_DPM_AUTO_THROTTLE_SRC_THERMAL)):
>   		want_thermal_protection = true;
> -		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
> +		dpm_event_src = SI_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
>   		break;
>   	}
>   
> @@ -3750,7 +3763,7 @@ static void si_set_dpm_event_sources(struct amdgpu_device *adev, u32 sources)
>   }
>   
>   static void si_enable_auto_throttle_source(struct amdgpu_device *adev,
> -					   enum amdgpu_dpm_auto_throttle_src source,
> +					   enum si_dpm_auto_throttle_src source,
>   					   bool enable)
>   {
>   	struct rv7xx_power_info *pi = rv770_get_pi(adev);
> @@ -4927,6 +4940,31 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static enum si_pcie_gen si_gen_pcie_gen_support(struct amdgpu_device *adev,
> +						u32 sys_mask,
> +						enum si_pcie_gen asic_gen,
> +						enum si_pcie_gen default_gen)
> +{
> +	switch (asic_gen) {
> +	case PCIE_GEN1:
> +		return PCIE_GEN1;
> +	case PCIE_GEN2:
> +		return PCIE_GEN2;
> +	case PCIE_GEN3:
> +		return PCIE_GEN3;
> +	default:
> +		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
> +		    (default_gen == PCIE_GEN3))
> +			return PCIE_GEN3;
> +		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
> +			 (default_gen == PCIE_GEN2))
> +			return PCIE_GEN2;
> +		else
> +			return PCIE_GEN1;
> +	}
> +	return PCIE_GEN1;
> +}
> +
>   static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>   				      SISLANDS_SMC_STATETABLE *table)
>   {
> @@ -4989,10 +5027,10 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>   							      &table->ACPIState.level.std_vddc);
>   		}
>   		table->ACPIState.level.gen2PCIE =
> -			(u8)amdgpu_get_pcie_gen_support(adev,
> -							si_pi->sys_pcie_mask,
> -							si_pi->boot_pcie_gen,
> -							AMDGPU_PCIE_GEN1);
> +			(u8)si_gen_pcie_gen_support(adev,
> +						    si_pi->sys_pcie_mask,
> +						    si_pi->boot_pcie_gen,
> +						    PCIE_GEN1);
>   
>   		if (si_pi->vddc_phase_shed_control)
>   			si_populate_phase_shedding_value(adev,
> @@ -5430,7 +5468,7 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
>   	bool gmc_pg = false;
>   
>   	if (eg_pi->pcie_performance_request &&
> -	    (si_pi->force_pcie_gen != AMDGPU_PCIE_GEN_INVALID))
> +	    (si_pi->force_pcie_gen != PCIE_GEN_INVALID))
>   		level->gen2PCIE = (u8)si_pi->force_pcie_gen;
>   	else
>   		level->gen2PCIE = (u8)pl->pcie_gen;
> @@ -6147,8 +6185,8 @@ static void si_enable_voltage_control(struct amdgpu_device *adev, bool enable)
>   		WREG32_P(GENERAL_PWRMGT, 0, ~VOLT_PWRMGT_EN);
>   }
>   
> -static enum amdgpu_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *adev,
> -						      struct amdgpu_ps *amdgpu_state)
> +static enum si_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *adev,
> +						  struct amdgpu_ps *amdgpu_state)
>   {
>   	struct si_ps *state = si_get_ps(amdgpu_state);
>   	int i;
> @@ -6177,27 +6215,27 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
>   							     struct amdgpu_ps *amdgpu_current_state)
>   {
>   	struct si_power_info *si_pi = si_get_pi(adev);
> -	enum amdgpu_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
> -	enum amdgpu_pcie_gen current_link_speed;
> +	enum si_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
> +	enum si_pcie_gen current_link_speed;
>   
> -	if (si_pi->force_pcie_gen == AMDGPU_PCIE_GEN_INVALID)
> +	if (si_pi->force_pcie_gen == PCIE_GEN_INVALID)
>   		current_link_speed = si_get_maximum_link_speed(adev, amdgpu_current_state);
>   	else
>   		current_link_speed = si_pi->force_pcie_gen;
>   
> -	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
> +	si_pi->force_pcie_gen = PCIE_GEN_INVALID;
>   	si_pi->pspp_notify_required = false;
>   	if (target_link_speed > current_link_speed) {
>   		switch (target_link_speed) {
>   #if defined(CONFIG_ACPI)
> -		case AMDGPU_PCIE_GEN3:
> +		case PCIE_GEN3:
>   			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN3, false) == 0)
>   				break;
> -			si_pi->force_pcie_gen = AMDGPU_PCIE_GEN2;
> -			if (current_link_speed == AMDGPU_PCIE_GEN2)
> +			si_pi->force_pcie_gen = PCIE_GEN2;
> +			if (current_link_speed == PCIE_GEN2)
>   				break;
>   			fallthrough;
> -		case AMDGPU_PCIE_GEN2:
> +		case PCIE_GEN2:
>   			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>   				break;
>   			fallthrough;
> @@ -6217,13 +6255,13 @@ static void si_notify_link_speed_change_after_state_change(struct amdgpu_device
>   							   struct amdgpu_ps *amdgpu_current_state)
>   {
>   	struct si_power_info *si_pi = si_get_pi(adev);
> -	enum amdgpu_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
> +	enum si_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
>   	u8 request;
>   
>   	if (si_pi->pspp_notify_required) {
> -		if (target_link_speed == AMDGPU_PCIE_GEN3)
> +		if (target_link_speed == PCIE_GEN3)
>   			request = PCIE_PERF_REQ_PECI_GEN3;
> -		else if (target_link_speed == AMDGPU_PCIE_GEN2)
> +		else if (target_link_speed == PCIE_GEN2)
>   			request = PCIE_PERF_REQ_PECI_GEN2;
>   		else
>   			request = PCIE_PERF_REQ_PECI_GEN1;
> @@ -6864,7 +6902,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
>   	si_enable_sclk_control(adev, true);
>   	si_start_dpm(adev);
>   
> -	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
> +	si_enable_auto_throttle_source(adev, SI_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
>   	si_thermal_start_thermal_controller(adev);
>   
>   	ni_update_current_ps(adev, boot_ps);
> @@ -6904,7 +6942,7 @@ static void si_dpm_disable(struct amdgpu_device *adev)
>   	si_enable_power_containment(adev, boot_ps, false);
>   	si_enable_smc_cac(adev, boot_ps, false);
>   	si_enable_spread_spectrum(adev, false);
> -	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, false);
> +	si_enable_auto_throttle_source(adev, SI_DPM_AUTO_THROTTLE_SRC_THERMAL, false);
>   	si_stop_dpm(adev);
>   	si_reset_to_default(adev);
>   	si_dpm_stop_smc(adev);
> @@ -7148,10 +7186,10 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
>   	pl->vddc = le16_to_cpu(clock_info->si.usVDDC);
>   	pl->vddci = le16_to_cpu(clock_info->si.usVDDCI);
>   	pl->flags = le32_to_cpu(clock_info->si.ulFlags);
> -	pl->pcie_gen = amdgpu_get_pcie_gen_support(adev,
> -						   si_pi->sys_pcie_mask,
> -						   si_pi->boot_pcie_gen,
> -						   clock_info->si.ucPCIEGen);
> +	pl->pcie_gen = si_gen_pcie_gen_support(adev,
> +					       si_pi->sys_pcie_mask,
> +					       si_pi->boot_pcie_gen,
> +					       clock_info->si.ucPCIEGen);
>   
>   	/* patch up vddc if necessary */
>   	ret = si_get_leakage_voltage_from_leakage_index(adev, pl->vddc,
> @@ -7318,7 +7356,7 @@ static int si_dpm_init(struct amdgpu_device *adev)
>   
>   	si_pi->sys_pcie_mask =
>   		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_MASK;
> -	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
> +	si_pi->force_pcie_gen = PCIE_GEN_INVALID;
>   	si_pi->boot_pcie_gen = si_get_current_pcie_speed(adev);
>   
>   	si_set_max_cu_value(adev);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> index bc0be6818e21..77614ff10df6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> @@ -595,13 +595,20 @@ struct rv7xx_power_info {
>   	RV770_SMC_STATETABLE smc_statetable;
>   };
>   
> +enum si_pcie_gen {
> +	PCIE_GEN1 = 0,
> +	PCIE_GEN2 = 1,
> +	PCIE_GEN3 = 2,
> +	PCIE_GEN_INVALID = 0xffff
> +};
> +

Better use the same SI_ convention for consistency.

Thanks,
Lijo

>   struct rv7xx_pl {
>   	u32 sclk;
>   	u32 mclk;
>   	u16 vddc;
>   	u16 vddci; /* eg+ only */
>   	u32 flags;
> -	enum amdgpu_pcie_gen pcie_gen; /* si+ only */
> +	enum si_pcie_gen pcie_gen; /* si+ only */
>   };
>   
>   struct rv7xx_ps {
> @@ -967,9 +974,9 @@ struct si_power_info {
>   	struct si_ulv_param ulv;
>   	u32 max_cu;
>   	/* pcie gen */
> -	enum amdgpu_pcie_gen force_pcie_gen;
> -	enum amdgpu_pcie_gen boot_pcie_gen;
> -	enum amdgpu_pcie_gen acpi_pcie_gen;
> +	enum si_pcie_gen force_pcie_gen;
> +	enum si_pcie_gen boot_pcie_gen;
> +	enum si_pcie_gen acpi_pcie_gen;
>   	u32 sys_pcie_mask;
>   	/* flags */
>   	bool enable_dte;
> 
