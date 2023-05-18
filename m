Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA164C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 15:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DBB10E0F0;
	Thu, 18 May 2023 15:53:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B19210E0E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 15:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY4sci7Xdk2WsF+x2SBXlekTm1/rDMjmYfo2AV7lBKsA2aJ267fX56Bl3B7UcQEf5f8h+eAvua8uxRUgRWHcKgJjg36mUym7+LD1eljwJdb4YR4gKw0zgZ5Xub9ES/gTb+8FcPwSQUpZDPAvnMDY0165cOdt9ODsFjXja6qroykn8hXEwcSUn28gqT0XwwHPRHZJK61uln/RkubNYAogSwYnUpFEVHhhzfHNS/gYcGf8njYj85hyS1xalXDoK9rwg4fjIJ/+VhDlMXGg3wfr2NNdunX1zq+yy78Yjw/LruQWvTcTW6KyTikem81jfGNGadf4lRmZo9gUmVu/HT3bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxUyR1MuQyFHqcjxqvcw+KibTJoiQwvADMu1BIPDe5Y=;
 b=biogqhB/suKOdLim2ipYylyfoMBhpwl6jiyYvCEgB92NC6Fk4tcMtJ60Smb6mDnlwJ8Tc41unvigrXqqt9NjuF+5QcbzpZ6FLxEfBgMLTxMVZsx6b3fXTVZMKEIgcQT/YcVMWXA5NSkyOiytJ8S3DmM1Vfuf7DsQ/8hbsNtGnfqo+K0jjSADyBPfKslHa0mgcjD7PTWI5LrGYCMWcYpUSEno2ipBGTReHVZVCHsgX5u2RCFUYmtp3RdB6CJaujP6P5/JL/YFx4UqpZcX2dr9xrA5wVxeI+UYfY3fA4dDulhl6TFQ4tf2tVlAKsd0VRvBHa0+TxqYEMxYx10pqB3E+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxUyR1MuQyFHqcjxqvcw+KibTJoiQwvADMu1BIPDe5Y=;
 b=xKZ3nLxU6L3Q0av6rtWZP8YducIU+oWTFE1E/Eap/3bSh++S0A33mXwa3kQqwUdxUxT5PpMbWOLBfu2Oqpv14tHrC9iN6apEiGeDxqppcv2g59fAUxhAvf3HIVon3t2Au0hR33T0PFF+OtmYlnaY7vUOuO6Z2nOZg7WyiManWsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 15:53:54 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36%4]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 15:53:54 +0000
Message-ID: <8cacded6-6212-d38d-8f3d-cb7e9805ff06@amd.com>
Date: Thu, 18 May 2023 09:53:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/amd/display: Fix artifacting on eDP panels when
 engaging freesync video mode
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230518154528.345112-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230518154528.345112-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0869.namprd03.prod.outlook.com
 (2603:10b6:408:13d::34) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e20af2d-ebff-4f24-2208-08db57b814d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3qxyxEdj7Kwoq93c7I2GeGt0AQr66NXcVk3baJWyV9hoBldyq/nIz/KZ6TMv/lqSkFq8tDKkFmDERW+GzNZe4Gml0YgKgMlg6Gt+lehEtK70YbWAwCb/Esw7ow1cdQgRFQldzYhqjF+D3mB77sHadOTolDqRSq8Fh4RF9R+61FiKEHb/XUWYmHFKw+A27YYY+plACjxf08BGcaJIflxt5/NjjG0cWWfH1Fmyn3eGndYR2hBVor6asicEwBgwnnN/pQXiafPpcATusHbHBwMiZQXYScdjoWhV9QYTmKuC/qMrqGO51Ta4kSxUGJQKGFDWIFZ609OgV1CCHUdd4IBzi/FCjxWrkzldHGGgakt826Gn19VFsiHkfFI73prKMuxzJ/+G7esGI/3p4kGSqNMhk5iUFMO1cg/6faTDfUy/gm74iG0OLEnqVYzdP1cHaoeu62iNImG+W9sOuadeZ0wbpq5iU+hcTEkkISz1RJzijVcN/Rm+od/NCqhnhhgz+AWAGgOWujxwtvBR2aUUBlyav2OFDQ5L9sF9mfNDOOMD2zYe7jcDh/RohR6cO7SrOcN86B0wC1vNVQM384HCGukicU1R3BxyO2S2Pf1zIu42Ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(86362001)(31686004)(83380400001)(41300700001)(38100700002)(36756003)(5660300002)(8676002)(31696002)(316002)(66476007)(4326008)(66556008)(2906002)(66946007)(966005)(186003)(6506007)(6486002)(6512007)(8936002)(53546011)(2616005)(478600001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhmdjArSDVSeGpvL1drWDlFcTY3SVJMbTNJUFBTU1VNQ3pHQVN6ZmE2S1A3?=
 =?utf-8?B?QWtEOVJyVEtxZ0RienNzMHpYWklkTisrZzhkNWZqUWl6ZmZPZlBlK3kwU0JK?=
 =?utf-8?B?TXltK0xOM1V3a0l4QmJZRnlOUUltNW9SWTZ1VVV0WHE0aHRvLzdXMXZVaXFV?=
 =?utf-8?B?UWc4WXZ2SmFYTVZOamUvNWpBeHpZVCsyWTNkbEx6ZzBZU3lLY29DVUJubWR4?=
 =?utf-8?B?dUFqUmhHQ0JtRVRheUl4V3lKbmRqQWFXTW5xT0djSVljeGh0Y0p1L0xvaFEr?=
 =?utf-8?B?a0lzSEZTVi9DZlNuOVRaOXJMYUwvQmdodVFuZG54a2l5U3hkUXl1TzBXQ0Rk?=
 =?utf-8?B?eEFXZWx6OXF6NWovbTR1M2JQbERyd3NSNHh5eExBbkx4eEE1MFV5d1VZeG4y?=
 =?utf-8?B?QzNkTVdPTEFIenNITW9QTUd0cTZ3QS9ka0tuRUc2dkQwQVB6anRpUkx6cTFv?=
 =?utf-8?B?dWZuOWpuK1o4dnJsUkRraUU4OXJpN2RQZWhnVFMyZkRxYWVxWFlyODArZWxz?=
 =?utf-8?B?VXZuWTdDeExLZkF6V1hIU3A1TXl2eGJnRVJscDNDWjNvS3FlMXREUEszVXVp?=
 =?utf-8?B?Vk1sRE1FWGhFVnRVOUFZQkVYSXpua3B6bXk3NTdTZStMckt6cVIwTWIwNkNt?=
 =?utf-8?B?R0hYTER1WU51bWRFeHVxelZ0RTZBVFJXYk0yblBvY2pTVkhQenJZSWRCdU5R?=
 =?utf-8?B?Y2ttRGNTRXA3RkJUREtPMmJCRTVyeEM3MlljVm9rcDJTaXBpTFdrUkV6SzJo?=
 =?utf-8?B?bmh5TmhzL2lHKzhHeEt3bmlKeWVueXBkYjcvL0hLcE4xVmU1MFdRNEl3dGdR?=
 =?utf-8?B?V0lHUm1HVzFFLzhBYUQ4ajNKdEhkOUlxZFltb2pPWlFtVVhTaWxYaTNkZTZZ?=
 =?utf-8?B?Q0NaclE5VkxuZmNDQUsyMUtvZTE2RWd5a0hid0owV2xuQmx2THAyckw2TUtp?=
 =?utf-8?B?eTRQYkpvVXUyb2N4SHUzZkFCVE9ZYkJvRmsrTENWdmFCeS9sYzUxdEZheHJ3?=
 =?utf-8?B?Y0ovNW45c21WNzhXa3loSUJ1cC9vOExXalYyTWxZbnIxTzk3M2VPcnl5cVFN?=
 =?utf-8?B?SU42THBhYUsxNDNEQWhJTVdPN2l6b0lZRE1ySXpBeUFoT1djYU40cGRzc2s5?=
 =?utf-8?B?VlBCMHRyTGk5SCtuWW5WN2hEaTExYVhGZE94RWlQL1JieWRFSGh0VmFFaGRS?=
 =?utf-8?B?eDJ4cFJ6SUtOREpoZ2FPTERJR0dDNkF6ZG8vYmdSMDc0cTV6MlBvdVFMVE1W?=
 =?utf-8?B?cVdyY0ZLcU82TjAvZXB1c0oyWEJjZ3krb1lUR25QNXprc29JMEpYVDF5WnN4?=
 =?utf-8?B?eVpFNFJCcHJKS1RQeHUwU0txUDlWWTZkUzJYbUU3RXJoTnBtZUkyTGgxWWV4?=
 =?utf-8?B?SzFUUmQvY3NMbllMeEVxTlRBdE5YODRlaC9WaEFJbUFzK2YwbGM2R3ZxSnhY?=
 =?utf-8?B?T0dMUlAxVFltMUtWYldIbE1VbzBERXFCcjVUSm02Lzg4VVZLS0RSSDYzbzVS?=
 =?utf-8?B?dTZZbUNqZFBza2pWb1BhbGIzN01ybC8rSUhsOVNzbmVyd2NrUENUM0oxTDNG?=
 =?utf-8?B?OUlJMmthZy80ajA2MWdLRW1jbmw2WmFDT3ZVVGM0cHZBZFNEaHcydHB2bkxu?=
 =?utf-8?B?bERZaUpYdEozWGxPcFJYQms4ZHJ5UWxEMEF3RnUvTVFsZTd3dW1mVFgzUDk3?=
 =?utf-8?B?SUNkU1hwdnZjK1pReEhHbi81aTJuYkdFaU5zSzQzSkdCUGN0a3FyYUZpYi9P?=
 =?utf-8?B?V2pCREkybVVuVTFDQng3bnZVbkExWjdqdi80TmFVWVdNNG1aeXpKdHF4VDhm?=
 =?utf-8?B?b2JqNFkxZjAvbmxNbWJHYzRUMmpWbldxQW9naFJBRXhFbFBEWC9Zc0pIcHpx?=
 =?utf-8?B?bmIxcTc2WnFDRCs5UExpc1d6aDd4WE5vOGpER2JFeVJsNHVaOG1uQ2g4TVN6?=
 =?utf-8?B?S3NOTW4vRlNJUml5YW1vTWJLTDg1M0VFbmE5blo3VVZ6bmQ1N1JTR3hPODVj?=
 =?utf-8?B?VlRGU2FnRUxyNG5iYVJsVnBSenN4SmxnbVJjVjMvQ2svVVNmNlF5alZPS2Na?=
 =?utf-8?B?MGpIYWFKaU5vaXlaVmNPaEZYWEFIZXV3MzY0d2RZWGMxVEh5cWVoUi9wVngx?=
 =?utf-8?B?end3c3JMUm9xKzFJMFgvVGh5N1lJUVNmV21Da3VMQ1F1NzFacm0wVlh0VE80?=
 =?utf-8?Q?UzgDc+OoswcvdvC9zh34bSVRGuj5XpnyFvVAvYfHZtPb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e20af2d-ebff-4f24-2208-08db57b814d0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:53:53.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puXxvPv2BVrYRkp1jY2iIFqNIiPCXUe4PjjFEYVbbO2TM+2CplhDKHcOxSNH+ZpA5AJpMU0c4E/OPMWeAohPBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/18/23 09:45, Aurabindo Pillai wrote:
> [Why]
> When freesync video mode is enabled, switching resolution from native
> mode to one of the freesync video compatible modes can trigger continous
> artifacts on some eDP panels when running under KDE. The articating can be seen in the
> attached bug report.
> 
> [How]
> Fix this by restricting updates that does not require full commit by using the
> same checks for stream and scaling changes in the the enable pass of dm_update_crtc_state()
> along with the check for compatible timings for freesync vide mode.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
> Fixes: 541d54055b75 ("drm/amd/display: Fix hang when skipping modeset")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 14b296e1d0f6..7f322b18eda6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9285,6 +9285,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   
>   		/* Now check if we should set freesync video mode */
>   		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
> +		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
> +		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
>   		    is_timing_unchanged_for_freesync(new_crtc_state,
>   						     old_crtc_state)) {
>   			new_crtc_state->mode_changed = false;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

