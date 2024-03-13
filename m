Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C2DC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 13:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AA810F2EA;
	Wed, 13 Mar 2024 13:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlLpAEam";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8A810F2EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 13:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBtMuNuQZImp9pUcGwGhfFHqT+gqKH9Che6n7RUFqJfkxwTxUnVU8F/fqpkZk9K3TnRce9CadrP+cuKDyTe9rER9/6rbbqAhL12HpOsl/LYKewQ+Fr+JPJWlDh/RBEwf4lwGnOpIsxFzboaxlnCz3izybiEiwoG57wO7yr7jV05FxtKcXUpLOLH8odqGpqG21l6OI7vu4FUo/5yRYBcMYoh1dlx9+j2baWQsvQBj6vaJb+dqaDEEcjmBKG3jZs5FKqWi1baMyaxGj4/SGmh5qY8Ril8EhcGabFFUgxGdK+apRMp3deg4xTyF/6R8meRaDYKZeEb6LGCuWeNWkcLdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI7e0UWV7v00E8/yRd6kVPSoic1c7nd3TsYNo8jLvXA=;
 b=HvNBpU2Eyn5gd3ycSgPISapIxmA2lkVrwz6+gDGS1bRLoTaxWej/k+6w4dvnMSLN3n4HaZcl54OFIZzeNYUs6Tp3iTRcAW2K8FuL3js1HeD+Qb8Sue0eHR9yKuLFu1iJtEL1sbxB9DewaRfbTaO7JUxBXA6JcOxx1p/kXemPLwcvJwGqDrkhIt52/0YakG9SXPdli02VbVHMWhkB21y/EPhLY8GRIY8FXt0VVp5fJIGDAEn9TeskFrXuZ8umDPj3pdbGm6yzzse3NTsgKaWy2l2LWRMjYDt1QrFUu9otQI9WV0XLtxHfasJENXe+RO75Gk3XyIoTTkIVWUK4hinXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI7e0UWV7v00E8/yRd6kVPSoic1c7nd3TsYNo8jLvXA=;
 b=UlLpAEamy6nng4DGFepVv4xLM6N593sE8ymyw6C6mJIJqO/OkGXu4nbhxqiV99ttbFRGyxrQ6DhTyVW9xWFwaM83B7PV6XeT3vWfFnLRwaasNhDxNxWt/qu4Nt4mPSCFQIS8p7DrUPmbw7DPY1THL1Q0HiDb33qgTMxv9FM4P9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 13:31:28 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::12b7:626e:83ba:ce0e]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::12b7:626e:83ba:ce0e%6]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 13:31:28 +0000
Message-ID: <25b74f62-64ff-4a10-8d9e-db55428468be@amd.com>
Date: Wed, 13 Mar 2024 09:31:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Get min/max vfreq from display_info
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240312134728.14046-1-harry.wentland@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240312134728.14046-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::38) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d7bba1-1033-4376-3d42-08dc4361e2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRNHJzW1soMVLsn6fZHOek06Q/9GCviIZFzWJwh+0jo1NV2UTE2GW/RKEjbm0mH2HyWa+F0tsAuBi9pTAsuHTByQpY9zAFr9iDpns242M2GlNoz2BsTLAvP93cNydPPqK9Ge9/+LpxZH4cryBeAHbdTmdIkOIlcsYFp87eOB8y9tpsspZaWNPXPv382OagMCnPs8dONiNY9DsIwSWdFbY3hmB1XYJhCaysPHSBTwCgJOw6mt3gM0INvAOBxYWQ8IHTkfpt62oixj4JLUMbY1CJAzaH/UwvmrmodFfK8XJOx9L8FHNrQtWdzHZoEUMHjm0/ttNzkjIOVPir3Bv19XvQGQD/0t+QzfELIZR07TNq+E1lgrpKiqSfzuSm91AHPUkm5OlsrrafzTf/4CZ9QtRBG9dQsfjL8gsbDP+RR3cXxPLlUj4sLKXAo8oxJT84azAlNrPfF95vs2cQ0I0mvSR2MOGweF1aWCWepw5NkcCGtk/o2kMk3HNapz2p8WOWUD8rATZ8jffiHcSa+dih8OB0Oc32V90x/BDFRckh45VfjO4xuqq0R3Tsx6B85zPxyL9OemBjeWgHAa3kAHQFZyjTF4CRqabWcFDwdollLJKJ5QfK0mxM6fr1lIeq962YJmuUbI9KFT0GK+nVP+/XRo8/LR7MJUUTlYPeEK17zUcZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlPRXUrbEpPVWVlT3djTy9oL3VqVzFSVXNwNVN6emF2V29pV25KVFVGY05X?=
 =?utf-8?B?alRpOTBNSFpkSXhUSFB2a1ZHaGhONW0zSG9TUDA0Rm9wWjZvVkkwZ1Y3c1Z5?=
 =?utf-8?B?aEpiSXNmeHBNMmNWOHVQRUNHYWJOVFh0eEdvSUtDVG16WmRTRVR0TFE2Z21Y?=
 =?utf-8?B?VmZUZ3hyeWZJM3ZnaUdVVG9wYkN6WThUbitSdWE2NkpTS0FFM2Z2ZmxCZXRp?=
 =?utf-8?B?Q3Y1VDI2em4zcHpJMnhzOWd2U3huTHZPeG8xS1AyK1dVakx6c1B0OVprc2Yz?=
 =?utf-8?B?Y1ZQWlVzOFBLczQ5dXNuTHcvRjN5N1FrVFN4OTh0eVlrNkIxYkl6OC9yeWdN?=
 =?utf-8?B?L0tCVEhaQVNQYmthOGNYLzV3SGpCSStHTXI2NWlBOUV1NHNQOStpdU92WEFS?=
 =?utf-8?B?eG9DV3RuTU5FOWxYWStVa25mOTNRRU9rSWtmM1hNNkZaQjlhd0V3b0kyd3M4?=
 =?utf-8?B?bXBvSlVZMzQzTzNLVzhvaW5zNjg2VGdjL29IME9DOVZiRGZwV2kwSit4eWxY?=
 =?utf-8?B?SDMwdFJyN0dqVlR1ak1QaXVyZDJad3ZpZXgrUVNONlhXNExOWElPUlZQcVIx?=
 =?utf-8?B?T2hCRlFnK0RLbUNLdEtManVVWWxmZEk5RmZqYXAwdnhDMDQ2U1ZVVkYwNWxY?=
 =?utf-8?B?UzBrSS9zb2xRSHNPcHloS25aV3lNQmxKL3V2SUtTcnE4VE5NdTdpbVVLSzhm?=
 =?utf-8?B?WWI1a2hPdmdlQ0NOUTNQNWhFWlZuYVl3SGxGQjRidVhmMmRFQ2RQcEZUV0dB?=
 =?utf-8?B?MHFYZkVlY2Z2bU5rNjZMTzNOeXByQzNEdzlQaXpjVURwemtwZ3JXT2lEMkZV?=
 =?utf-8?B?VlhoblErQVdVRlpRandOUVA2RjJZQ2prbTc0Skw0Nk11SDR6azIrZWF2VmIy?=
 =?utf-8?B?YmI0ZWRTcHhpa0tBSThBSmY0K1BneE43RkNyY1F0NVd6QTd2bm1ncFlPV083?=
 =?utf-8?B?L0hpdXA4bW5VV2Y1TFA5NXRsRjVWUnp5VEJjZTlpMDdId1grdGJXa0Y0T3Uw?=
 =?utf-8?B?WmRza3ZJRGtzMkUxS1RjUDJWVkwwQTBJWTgyRWJGNk44S09LOGtPbXVOYnVq?=
 =?utf-8?B?QStBcDcyTkJ6SkdIYmNreTFLeWU3SEdpcC93L2J3ZytqQ2VJd1k5dHRRV3lS?=
 =?utf-8?B?R1AyaXpTZlBzYU4rcUJxZHIrYnJQaFlQcVhwQmk1S0liL1RlTWZwcjQyMS9i?=
 =?utf-8?B?TlYzTUt4Nzdidi9FR2pLRXBBL1dQUVFLOTdYZ0w1WVNUSXFPVnpVZTN6cHlX?=
 =?utf-8?B?MXVGeU5VdDl2aldQczNkdEVVWEdSTVZrV2xrTWVqMk0vcitUUmNkSjZhK21Z?=
 =?utf-8?B?YlV3b2tZbGhrYng2bGNxd3NlRlZmc2o1dHFXSFlDUmxOQ3grQURJZVFEWUxC?=
 =?utf-8?B?WEdxa0trYnlFMXJKaHl0d2J5RnBhN2VkQmtTSEJOZEh2RTFBSkt1YWNweTdN?=
 =?utf-8?B?bUZIMklEejcwWlJBNnhxWjZKZlowdGxWQjFQK0lYOEhUUXFXV3RXTjNINnBY?=
 =?utf-8?B?MzJVZy9NRlZjQldlT29TUWtBNUgrKzdJTFdMRnlUOVBMU3MvanNlODIrWWtP?=
 =?utf-8?B?dTZJL1dMSXViTENNTW1vRGhZcjc1VmMwRm5JdC8xMGl4Sm92amVaWGtkOGVL?=
 =?utf-8?B?SU9xWS91aWdDSFlHMnpMbnJtUnp5dFRaK3RXaFpCNFZZZ1dWZ25KSXRzQnI2?=
 =?utf-8?B?NS9XWDdNZGlGd3FmTk1nZGY5YXBiYmt4bzJ6akV0Vk9IV24yZDZaVzV4elpF?=
 =?utf-8?B?TDhFU0k2bTJVNDFpRWU1WVg4R3dYSU9hOWhhWmZiWjhoanpJaUZKTDg2bnhT?=
 =?utf-8?B?OWU1UHpEWDA0MHRHSUZ6eXhoazFOMFA5cldMdHVUWVpqQkpBeVF5MmV4S0hs?=
 =?utf-8?B?Rkc3Q0JyZjNOdHd0dVdxUVN2dzBuQ3EyM2x3SnAxenRKVDlMMUNQOXdBNnBu?=
 =?utf-8?B?OVZ5Q0pmTkhmZzF0S2VldUhHR2Jzc3VLbnVOMkV2b3M2QkdFb1NHZlNVK25D?=
 =?utf-8?B?U0FEQ0lzSUpzVUcyM2xXZWVFMmszOVpQa3JSREFPakFqZmJhVnRQNVExRnRJ?=
 =?utf-8?B?V3BtUCtEOXRFUjBjUlV5Y3hzc1hpOFU2SThiRUo2bVJDWkZiblB4VnJzQWU3?=
 =?utf-8?Q?Uo0ZS4CYsgvRtjUuDZa9g5i9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d7bba1-1033-4376-3d42-08dc4361e2f1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:31:28.0056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16kml1OYutXSccrpBXMjY3WJ8X6zylvY2sX0ur3Veee1vn7c8ET62N8kuS7wKbrJty+T6HKYdHilb7CXbWGGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

On 3/12/24 09:47, Harry Wentland wrote:
> We need the min/max vfreq on the amdgpu_dm_connector in order to
> program VRR.
> 
> Fixes: db3e4f1cbb84 ("drm/amd/display: Use freesync when `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found")
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b1ca0aee0b30..cffb2655177c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11278,12 +11278,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>   
>   		if (is_dp_capable_without_timing_msa(adev->dm.dc,
>   						     amdgpu_dm_connector)) {
> -			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
> +			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
>   				freesync_capable = true;
> -			else
> +				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
> +				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
> +			} else {
>   				edid_check_required = edid->version > 1 ||
>   						      (edid->version == 1 &&
>   						       edid->revision > 1);
> +			}
>   		}
>   
>   		if (edid_check_required) {
-- 
Hamza

