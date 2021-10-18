Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 07:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C7360E76
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 07:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86C7360E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099036E08E;
	Mon, 18 Oct 2021 07:57:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D75C6E08E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 07:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdMLkFFIBpUuQRvOIrC86YqXjwj0WzCWnYxqt+cYx4F+/87FJYniKhU8harXH32lVELS4/2bDd3R3oFgAMWbotOZWa5CzAyBtnsLp5gLO1cOg2EcBMja+krfk8BaaBK+mTZccXaUCcQaPasK7brmpa2VVOQDn2MDQzkuLTONCFK/eFG8d91/eDXsc1suoALtQfQaxrWDctUpRb4XNyR7O9ZX2a+4DNsSI+MRzFgGzcpIhhi42/DGoBFxbab/cgN5pC8KY4T6RQzPLB5z1Q5PRg21a1lHZ6Ox23sPBAapyqI0XxgPQmH+fBDy/XSk4SA5vP5A34hBnhEnFEvR4ALqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z7N7l68wIfB5we78wgmF/9ER4hIjh3RTfWcP8EU+H4=;
 b=SYx7Xt0Sj5e//5MpV0k112hqkRcJQmXvRsQntKDCiurjYZxhoIEN6e3BFJHqGXB/29KhVDFDpVtOiIkGaEW0O/6yKCLDgpNfG+aMsMuAHQnFlx7npGe1RRRojVlnWJpVM9q0jmHwiCd2CoSYm+viuKyVg/TZysif/p+DWlbbNp2AGUvz+fzwG0FAN5pijBp8nMODYqUE1zZX2l7V7kCkYh05SQRc6N7OI+CMqt7jAKnI13VpPRwRsaX6gYP8QZ+Qs6LI27+V+w2mbyyS7mOgza9VcTvdAJtgu906cgulgl3RK4otiE47+XErP+CMtFPrFVZozHcB7lf8QB4ZJyAjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z7N7l68wIfB5we78wgmF/9ER4hIjh3RTfWcP8EU+H4=;
 b=VzB+tU4NaMIVVU5jA+Y4ROaLF2T42B0puwUj6kFFUeq0UXY0Q9LHOqBKFQbjkCksTTIIG2TY/ni8mzGfeiAj99kJ5CXjn+r6NrthGo4NjG6NiGeMkZOAbPDOsEJoBLhBmgEmx/SRZGtPCoLIRC+vQyU2A/HJvdGzwT2gKAT/4rI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 07:57:49 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 07:57:49 +0000
Message-ID: <c995c339-1b9d-2a8d-930b-ae48ffe44b99@amd.com>
Date: Mon, 18 Oct 2021 13:27:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, bp@alien8.de
References: <20211018073432.1525697-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211018073432.1525697-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:96::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 07:57:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8d2826-eaa4-4003-6a2d-08d9920cfa4d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB183353FBD0A187246126873E97BC9@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zn8i7Zf0QvSS1AfxuHtnnOb8bLCt/BdY4fzFoxBO659kzb8zG6Vhm+sgHZZC2UADKluo6aZ69cArsksa8V2f8dwpXAugVnDhnAAtNGioGyxyCk1x4F+Fj9umBwdgJWLzswHKEOtxqPkaYpJsZC0UCR241EbJMAuRhCk53v0lf1Q7EhY4BFXeArOn4rBEoI41I8osaj+bGKId99ZhtkPoDvgVPR8pSV059U8mTfhMZwm+ZoSBk52ei2rizQ33IXt85rSQPTOJVGuZMAjPregPgH4Nfumuu2nygzROIOJ35UhK+Qg0MCsy97qho35u6X7GIYTBySHFpZt4GVt/3Evzb1c765SaJ7w/GBiO2kHu82VMbNu2dy2Bp/gKi13OITtENTzb+4t9ioi8oWPweSpv64xcZ2HBw1bC83DrIv+Sk3txdg4m8X+QkbPdM/lCwze9qBYcCHjbtgdkWrcve3gfhubUPWWhlf9atbw4U/8FUdsVsu82Oln9ymaqOkZfqKzUE1E4i2/9/33W9bdRezdmXy2xwunFopiMY0wQHS/KBj8nsHTABsq9L93wPHfAOAbARYUwCsFfTXiQNlM+EmwS91Wzqumk3bBC+oZqM5Sd6qAFVS9I0RFD1nfjJsPKJLkZfG7ewG5Yah+ZywUgyakzMSe73kJNhZFPIqzcpNTnlskA7uHYP39dXpvS6IzK3TP8O3yPnnThHEBgdTTf63SM/1R7c6FapkAv3B5r5R91pBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(8676002)(26005)(508600001)(86362001)(66556008)(186003)(6486002)(53546011)(31696002)(66476007)(83380400001)(36756003)(66946007)(4326008)(16576012)(15650500001)(31686004)(2906002)(6666004)(956004)(38100700002)(316002)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhQelpacG4yTEpJSCswQVNacjJHLzVyNCtBcHo5NWRPUFU3Ykd6MTRHZXdK?=
 =?utf-8?B?Vmx0QnR2NGRodG9rRmZ6RGhsUGQ3UlhGK1MwZURJZ2hWc1RXVEU0MlZCUFFL?=
 =?utf-8?B?VEFRd3hGRlNHTmNPMHlGd2IvMnFSc0U5c1RvSnZTSFR6bktWWjVrdW96OGtU?=
 =?utf-8?B?QkVmRjlvUkpCUGVDVHUraGZLRVRWLzJ3OEFSMU9ZOGxZd09teFFnK1gwYzRG?=
 =?utf-8?B?aDlIemwwZy96SlpJaUxObDNIbFNEYXR4S1NWQVNxazBqNmZaYU90dUNSVDZt?=
 =?utf-8?B?SkVBNE5ybnN6RHFvd0ZzWVAvRmVvdE9zekREYUlQazNRdGNvNCsvRldSNFRu?=
 =?utf-8?B?aVR3ZzRkWklZOVMwUU5VQTB1TUkwL213elFRUDVuaGk1VDFZU3RoVzQ0QXdM?=
 =?utf-8?B?UVg4U0JwMHJkem5UeFR2cmQweEp6cEtKRHNMcHJnai82TG9RWXk0SzVpY21h?=
 =?utf-8?B?TUFwV2NKbWRSaHRUNnJqb0p0QisrSU9qb2xhSWs1ZnZDOXlLT3FWdE0xUVJJ?=
 =?utf-8?B?Yk1lN2hNRGhBSlNOc3J3NVBiRnhJVjRSTFJHYzd0QWRjVjlrSkVmbllWTjEw?=
 =?utf-8?B?SE11bHlVVXJDWHV6NjNUUHNGSkE3NzdBUVBaVUswMGVaeFlXZFFWanFuN3Fy?=
 =?utf-8?B?UnRXeU15a25XYmNtL1RZTnJBdjRlMkdUeEtOa0lFTmFjQUhIUUltcmdiV20v?=
 =?utf-8?B?RnFpL2NvY0J4dG44K01mT2NjL29LYiswbDc4c3VSOEQ5QlN0SVlWK3lOTndP?=
 =?utf-8?B?SW5hR0dwZDdLK3RvTkpZM3RhdWEwUXFuZWpGc0lLM0dJUmhNblZpcUMzM01L?=
 =?utf-8?B?MWR5a3YvdXFEWFp3RWdDN096elowd3o1TnN5Y3lyeGhxRGkzRjg2WnB3K2lq?=
 =?utf-8?B?L1ZUR21VTWk3MWFBUncweW1FanNOWFdCQmFFNUVQMi9JZWZqQ0JsMExVT3NR?=
 =?utf-8?B?L0JuQ29IMWgrTU5JalVRb3ZxWko4OVdjVDFYYjNQMzQzY1dTUnJWSFdCdHdr?=
 =?utf-8?B?OWJCd2lEeitlRklHdWpGOUQxemR3Q1JBMmpjSzd5NElaUHNaRDhtNzliVExi?=
 =?utf-8?B?cFZnSmFIMUl1cmpqRkJ3Rm9CZVppTjgzdFVIU3o4NHl1TVMvODZybzI1VU1Z?=
 =?utf-8?B?d083UFMxemhkak1rLzVzSzhTRk5ZYWFwRFEzMEF1MU1LckFVL1JMSk90REFS?=
 =?utf-8?B?R2dqZHYyV3hXSklnZmZ1VVNTTjc3TmQ0bDI4dk1zMDFUZ2tYa1pVMmYzVE9p?=
 =?utf-8?B?VUhXaFgzSUNoSDJUSXVqclJyKzN6cG4vblpoMXJMQW55NkpCbWsvZkJpZjRl?=
 =?utf-8?B?RHV2dTkwZUtvTTRJam9EZnQ2clJDSUdkN3BCaTlaUUhMdTlKeko4R2xBR0VV?=
 =?utf-8?B?cFh4SHh2cnd6Ty96S3VNZjQ2dVdFblBHbUlXYTNtdkZwNnczaDFxbDJwcWpM?=
 =?utf-8?B?aktmdEN6TGlFMmxpc1hXMFJyMFpIQnRvakt0VzdtbVd3bkRMRFcvclJDNG9a?=
 =?utf-8?B?bllWNStDRENOUldLMWJwLzFsT1lPUVloUG1vU2toWjR4ZGt6N0JzZGRMRzVP?=
 =?utf-8?B?aXhjSnl6SjNHdnUwK1FINzgxOHZaMVZSQXN1WDNzTmVHL0cxdTdxWjNRK0NG?=
 =?utf-8?B?aXhXMkhzNUdQQTdxd3dKeDl4eEJWcS92OWFqeXEycWpDbHRmdHRUc2RZR08x?=
 =?utf-8?B?eXcvVXZ5bzYzZm1kOVV3VUNrRDROVXdlNkxzZFk1aUhENG1jRG1sbzRvSHlL?=
 =?utf-8?Q?Od4QdFO3dMHlXZgMAWTPb5R8RagwtYwMOnGZe8w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d2826-eaa4-4003-6a2d-08d9920cfa4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 07:57:49.0013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu56MUIPNqum4LOjZl1Xmxd14PJQHsjw11nsgTPowmeRQ1yIjuLzwy63sV3najZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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



On 10/18/2021 1:04 PM, Evan Quan wrote:
> It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
> will power off the UVD. That will make the succeeding interactions with UVD on the
> suspend path impossible. And the system will hang due to that. To workaround the
> issue, we will skip the UVD(or VCE) power off during interaction with SMU for
> suspend scenario.
> 

The original issue reported by Boris is related to sytem reboot and 
hw_fini calls (SMU is hw_fini before UVD/VCE). Boris also mentioned that 
it got solved by reverting the disable DPM calls during hw_fini. So, I'm 
still not sure how this is related to suspend path.

Thanks,
Lijo

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I7804d3835aadbc7cf4b686da4994e83333461748
> ---
>   .../powerplay/hwmgr/smu7_clockpowergating.c   | 20 +++++++++++++++++--
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++++++++++++--
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |  4 ++--
>   3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> index f2bda3bcbbde..d2c6fe8fe473 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> @@ -57,7 +57,17 @@ static int smu7_update_vce_dpm(struct pp_hwmgr *hwmgr, bool bgate)
>   
>   int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
>   {
> -	if (phm_cf_want_uvd_power_gating(hwmgr))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with UVD are still needed on the suspend path. Thus
> +	 * the power off for UVD here should be avoided.
> +	 *
> +	 * TODO: a better solution is to reorg the action chains performed on suspend
> +	 * and make the action here the last one. But that will involve a lot and needs
> +	 * MM team's help.
> +	 */
> +	if (phm_cf_want_uvd_power_gating(hwmgr) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr,
>   				PPSMC_MSG_UVDPowerOFF,
>   				NULL);
> @@ -82,7 +92,13 @@ static int smu7_powerup_uvd(struct pp_hwmgr *hwmgr)
>   
>   static int smu7_powerdown_vce(struct pp_hwmgr *hwmgr)
>   {
> -	if (phm_cf_want_vce_power_gating(hwmgr))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with VCE are still needed on the suspend path. Thus
> +	 * the power off for VCE here should be avoided.
> +	 */
> +	if (phm_cf_want_vce_power_gating(hwmgr) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr,
>   				PPSMC_MSG_VCEPowerOFF,
>   				NULL);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index b94a77e4e714..09e755980c42 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1247,7 +1247,13 @@ static int smu8_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>   
>   static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)
>   {
> -	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with UVD are still needed on the suspend path. Thus
> +	 * the power off for UVD here should be avoided.
> +	 */
> +	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UVDPowerOFF, NULL);
>   	return 0;
>   }
> @@ -1301,7 +1307,13 @@ static int  smu8_dpm_update_vce_dpm(struct pp_hwmgr *hwmgr)
>   
>   static int smu8_dpm_powerdown_vce(struct pp_hwmgr *hwmgr)
>   {
> -	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating))
> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +
> +	/*
> +	 * Further inactions with VCE are still needed on the suspend path. Thus
> +	 * the power off for VCE here should be avoided.
> +	 */
> +	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating) && !adev->in_suspend)
>   		return smum_send_msg_to_smc(hwmgr,
>   					    PPSMC_MSG_VCEPowerOFF,
>   					    NULL);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index bcae42cef374..4e9c9da255a7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -1683,7 +1683,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
>   						       AMD_PG_STATE_GATE);
>   		kv_update_uvd_dpm(adev, gate);
> -		if (pi->caps_uvd_pg)
> +		if (pi->caps_uvd_pg && !adev->in_suspend)
>   			/* power off the UVD block */
>   			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_UVDPowerOFF);
>   	} else {
> @@ -1710,7 +1710,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   						       AMD_PG_STATE_GATE);
>   		kv_enable_vce_dpm(adev, false);
> -		if (pi->caps_vce_pg) /* power off the VCE block */
> +		if (pi->caps_vce_pg && !adev->in_suspend) /* power off the VCE block */
>   			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
>   	} else {
>   		if (pi->caps_vce_pg) /* power on the VCE block */
> 
