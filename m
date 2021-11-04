Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9850061059
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9850061059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166A06ED6B;
	Thu,  4 Nov 2021 08:55:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17056ED29
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 08:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hggNw8yFwIvCjDod7ROBT9PrLHBzzngsmPS/7eh241u8jgtie6UrMI6Ip7+Vbdkj25ek69EjqURqza6lXsAX0k1teM4fVlhr4PiJ6kvYC5WYoBtZFNep2gwi96m4m/KbGyl+4iE7GcuqrJlV852kOu/b3c/efVfsGkdgcCHlb3QO/HGaqaWniXgLeBvsq/dUXC2vQVNKwNfAu6BzsHLBzmRjSqL8cR4uAi4g6kzdE2bCgmwTddg6oXF3/bcRfZoJFbgG/Pm2VPNl0KHeXPbknElrsog/hCDtWB8snVSFa+p6CUDDT/vZC2e6KJsK9YUklEg9P4FYXMKjqxbELCgi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drVOv8AfmZZ8fOiCq7ob9MxXnTMdM2tnRfzy19W7JXc=;
 b=XRBeojPOuNYd8zk8kqS0LXoiHpYbHALc2fk40Oe35I3oxqIIAOpzoCmpG/ZYh5aFtHqR2hiRR2oIbLgWN1TbELEEjXFTeMR83eLCXWzMC9/2yFt6UG9ojIq+zeb2sKo2xbzuG+ncM4c4ZPRJPqLv0HoLIz0So5ou7oKJG/1MTkEkZxLa2p7zuDQ+U7XiW/LhsOBW0zwiTTfHFneqA9D1QWGYSv3JT7CmsdCklHtOTwiYnNHdUl+CpfB2ttaREgrL+j41NyzJj8h6efdupxhKHh0THcCVLmAXmoN6DXZRAWQVhrtyzdNjYeKlZoRduMixj2M4jm5DSXDccm23/q2nVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drVOv8AfmZZ8fOiCq7ob9MxXnTMdM2tnRfzy19W7JXc=;
 b=NrRTQN4hhGlIVoYl0OE1rHzxi31OIBPqTxChoLOyQeRcqjOl+f+RRNm6h3zUeaMv2rAIPya+A04oF99nDjSO6Jukl9ZzAFxlIU2fgI4LjqfaiUUzAz7YnGeme6fOXgVc+Q2akSlNs2BbtZyPinH0h83JD5bRofKEWaA8RlDw7bw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 4 Nov
 2021 08:55:09 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Thu, 4 Nov 2021
 08:55:08 +0000
Message-ID: <675b8367-3b91-a565-f656-fe46ba65723c@amd.com>
Date: Thu, 4 Nov 2021 14:24:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdgpu: fix the Carrizo UVD hang on system reboot
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104081931.467399-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211104081931.467399-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::34) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 08:55:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ed8701-2287-4091-ee88-08d99f70cd96
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35164E5F5D7E4999CBAD826D978D9@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4zDv0QgEF2hVBow1PJk3yJ2vrTcUpjYpQoZCPQd3F6ZAzLOA6KV1S1+yhXPz7w8GlTStLG/21ivpfm005tuOD1kJgRNU6dYoUs2q3XdCCXhmwNSmYOvLxNi1t+h4tfajYRDFmLVy+5YHSwyIvCbKnor2SFSrA7TWiSCdRSLE3KUfqrDsB4b1LrNN9P6vDSXCAtxjz9VULY4qTJ57t5YTAMfhmO2H4vOadUn4eQDvWIpzxOtCDmqABKIGQIR/Zm2q6XH6LNya/Iram7lRTaowvkKvsPyu6UGYhe3Rk6KntfT3BQPNB4vcnEzjgPkbg6dW2ZjXoooIS2T2W73FXK+m++hABJH6CdURuSQiqSy5hoecKE/DRtYIDz1EjcOzI/Zyecz8qRcrloZDPnkSsceBAAy6Nze8SAytv20EZO+QGGYmlnVJRRLkLVfku9uZ9fYTH/MLie9130pyevuRIjcbFDxqN540cOo3WQNJNZvBX6fKp/P/PZFwRjBh4HJXQOKUfhTMlLTiDsOJ14V9XWUtjaTmRAdQVDvd7wtgnphTFN0eTGpQfnzVqtirlnp5Aaphl0ldJPNCvTWJDa59bmM2O8elalnm21S7K4/dKhd5kvc82irFpx8Uaiqz6gyBaWcd4YrvyPJUwyBZVR1ECdaackhaAHEQF+WcNrfhEz3QnoM4P2mXKnzoF3WsfIpN31meaZOzcQeuE5Df25YSDD97UfZr5loLy9niEWkSjoG4SM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(8936002)(2616005)(16576012)(31686004)(6666004)(4326008)(956004)(38100700002)(8676002)(6486002)(508600001)(31696002)(186003)(5660300002)(36756003)(53546011)(66556008)(66476007)(66946007)(2906002)(86362001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhGVWxhQVMwSkdLWGtHUFMxenlRVjdtd3JsUUFDOWhidEhUYU8vM1c5WVcz?=
 =?utf-8?B?aFZ1bFBjQkhlUFZkdXZiQXlwYkxxWFErbWEwOUZvUW1NbVdRSXdDdHI4K1RC?=
 =?utf-8?B?YVNVOE5VMFFQdzJVQm9tVncyQk9qeC9HV1ZFczRQQllGMVBPY0x6VDVqU3hZ?=
 =?utf-8?B?bTFmalIwajF5TTM3YWNBeUJLKzdzS0drUU5BcmkwM0hleFJTbzdxcm9zNnd5?=
 =?utf-8?B?WnNvRk44SmlnMzBrWlJvNkdIaFhaMllFd2FOM1RxVUFsRVlTSkM1WmhMOS9R?=
 =?utf-8?B?MXQ5ZmlMbjd2QU0rMWRRME5EQTdmL0hvM2tmUXlRSXY5WGIvSnNFSlJlcE00?=
 =?utf-8?B?Vk9YWnNmbXZSeTlPMGoxcFN3VkpGcmlQUktCZHVwL2N5UlpYeUlyVnVPOWJp?=
 =?utf-8?B?MS9XOHpNbXBGNWVLZStyaGdIRExOWHVlTUpER3RlczcySzk1dVNFL2MrMUFo?=
 =?utf-8?B?ejI5Sk9ueWtsOFY1dE9lNkNoOUxsSG9SeFNyZkpBS3hHRjRsakxnU0lpQmhz?=
 =?utf-8?B?N1RxdWFqTWxtN3FyUUd0YWRRWVpqN1FxT0wzbUlxTDJ5bGlIclVVUmhoMWtp?=
 =?utf-8?B?Vjg5ZTZYaHlLRU9OME9PNS9yZHQxZTdVUE5uN0NrTUpmUEdZM21pL1Bqb0hU?=
 =?utf-8?B?dEp1UGhTNXdmdWk1KzBuUENINW9QYUxIZnRib25nc2JGUENnYjgxdUVzUW5s?=
 =?utf-8?B?V0pUZ0FvSk16anYyUThadmVWUWttNnVOYjUxUFdReUdRWHBsQ2dwUHlPQjdT?=
 =?utf-8?B?S1dQSXhKYXdHT0xMQzVSRlhhOVdjcnd5UndBOGVRcWgyK09ZWUk3R2kzNmZ0?=
 =?utf-8?B?VUJ3U1REWGE5ZGRCcVNKaUh4b3hQUmxRcHM0S0VBekNaVnp5eWw2NUE5anZ3?=
 =?utf-8?B?RDdBcDBvTnZ3YjB5cEM2Q09MQ1p2bnFNOE1IZmxHbzY4RUgvM2lMY0ZnRnd4?=
 =?utf-8?B?RTQ3RnZERVdsL0ZKN3A4WlRHR3lhc1R1Y0xFVlZZb0FjRDVlMW4rM0s2aExM?=
 =?utf-8?B?WU9KS2JLK0MrZ0hSUnB4dm0zWlpQZHEyQU92aGc1MW1rWm9jOUpxd2ttOVNm?=
 =?utf-8?B?dkJCMFVxQjEzd0J5RElLVjViNU52c2lCc1RFWmhhSlFkU0xHaG1EQmRpM283?=
 =?utf-8?B?WHBjaDdGUDJ3MENaYWJWZldLODJHNUlQajROZkFMU3VGWENqRDBseDlGTjhx?=
 =?utf-8?B?QWx5M2xHb1FHVmswVGVCam9ybjA3UTR5cVZiUGdzeDdSb211d1hJa1FPV05n?=
 =?utf-8?B?S1dORUUxUTIzaU5zRkdaS0lKdFVuR0dpcTFxbnZTcjMvRzhMZzJSMW9XMVRv?=
 =?utf-8?B?S1NtbW1wMFVVdVFXR2dJMEk2SVB4YUZJR0c2ejI3RHF4R0tQdjRVUmVBL25a?=
 =?utf-8?B?ZnpTQ1RXMjVpY0RjOVAvRXc0Y1FWc3VEODMvRlFjbmUzRGRjSGJXOGJSUGlR?=
 =?utf-8?B?TDRVbm40Nys5RHBPQ1FYQXhidEw1N2x0UEFkL0ttQ1JZaHdEYm5iWmQ0RThy?=
 =?utf-8?B?UlA4a2p1V1hVMWRHYkQ1cUQ3TXdjZFltcm1QbVVJa2x5SkdRc1NYS3hXVnBn?=
 =?utf-8?B?TmJJSzI2RW5CRTFuTVB3RGRuem14OWZsWnlYc29TdTVpKzIrK1gzRG4zQ2p1?=
 =?utf-8?B?YU1LcFVEQ2tPamxubGhFYWt2am0wQUt1cUVMQTVVRXFqc0lXRHkwQnNoNWZ2?=
 =?utf-8?B?d1lYd2hKYUswQkRGM2NLMmU4VHdhUzVtME83a0F0aFdpOGMyM2RRd1Q1ZnFn?=
 =?utf-8?B?L3k0K1NxUHhhOHNPQXlGYW9vRDEzU3pOOTF2ekd1TzZnYTM4OUQ1bEJiWXZj?=
 =?utf-8?B?ZWlWVndMTE9mL3FQU0N2Z2lmQUkvMjQxTUV1MXpFQTkxNWhFNElha25oOFRF?=
 =?utf-8?B?aDl2VTAxUlo0aiswQzdYUVU2U2xIYjhQcTRIQTkzMXM3dVBqeUd6YndoZ2hs?=
 =?utf-8?B?akxWL2xLWFY1bnFRWGx3Q2pJOGxHVWF4QTlmanExM1BBUEsxSFBOZ2dyV2p0?=
 =?utf-8?B?V2RGdkZiQWMveWd1M05CZmJHNkFPbG1VR3pSTjF6NmhpS2piTWFMU3NZOVpO?=
 =?utf-8?B?LzVtQ25rZGtkZ2pzYjZjbWV6UGxjUEtFaDhkTnUrYUI4dTlreHVwc1EvUGJn?=
 =?utf-8?Q?fMxQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ed8701-2287-4091-ee88-08d99f70cd96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 08:55:08.7797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqtpuMlrXDsWw7n3g9Af02dV81hd7JKNYOCM9CL54cM6SjBF1cCV2lA54l5TOGtK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
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



On 11/4/2021 1:49 PM, Evan Quan wrote:
> It's confirmed that on some APUs the interaction with SMU about DPM disablement
> will power off the UVD completely. Thus the succeeding interactions with UVD
> during the reboot will trigger hard hang. To workaround this issue, we will skip
> the dpm disablement on APUs.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I4340cc2fb0fd94f439cbac5d4963fe920866bc13
> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 20 ++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 30 +++++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 18 +++++++++-------
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++++++++-------
>   4 files changed, 52 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index c108b8381795..67ec13622e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -238,15 +238,17 @@ static int uvd_v4_2_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);

If the idle work handler had already started execution, it also goes 
through the same logic. Wouldn't that be a problem? The other case is if 
decode work is already completed before suspend is called, then also it 
disables DPM. Not sure how it works then, or is this caused by a second 
atempt to power off again after idle work is executed?

Thanks,
Lijo

>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_uvd(adev, false);
> -	} else {
> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> -		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		} else {
> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +			/* shutdown the UVD block */
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = uvd_v4_2_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 2d558c2f417d..60d05ec8c953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -560,15 +560,27 @@ static int uvd_v6_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_uvd(adev, false);
> -	} else {
> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> -		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_CG_STATE_GATE);
> +	/*
> +	 * It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
> +	 * will power off the UVD. That will make the succeeding interactions with UVD on the
> +	 * suspend path impossible. And the system will hang due to that. To workaround the
> +	 * issue, we will skip the dpm disablement on APUs.
> +	 *
> +	 * TODO: a better solution is to reorg the action chains performed on suspend and make
> +	 * the dpm disablement the last one. But that will involve a lot and needs MM team's
> +	 * help.
> +	 */
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		} else {
> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +			/* shutdown the UVD block */
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = uvd_v6_0_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 67eb01fef789..8aa9d8c07053 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -505,14 +505,16 @@ static int vce_v2_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_vce(adev, false);
> +		} else {
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = vce_v2_0_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 142e291983b4..b177cd442838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -520,14 +520,16 @@ static int vce_v3_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_vce(adev, false);
> +		} else {
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = vce_v3_0_hw_fini(adev);
> 
