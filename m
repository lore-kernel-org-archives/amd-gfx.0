Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9416BC001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 04:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A120610E12C;
	Wed,  5 Jul 2023 04:50:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D34F10E12C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 04:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsGH8U24bWtg5/QahVTw4Z2N6TYSUG6unHyeTAXhLFwypZ2NzO2VoDa0VoQj/OQTtwDX10NPvVnkT+PtbI5CP1opq4L+/SWO05tkFT4QP9x+9grUew5+Yl/XWgGb9nPFNbzaQuMv4IAjuk/lTwXrxQk+nou2bGQ5ZsMyNfzfgWjUfjomIUOtVGHFgTBnaEMnjzmqyoXd4wJM0sHTX2hoP9Bphkgp+XiYh4/Zb8F8FBcwSxQ1eDjdDij1bk7T3Fgr3/Ao4nXYRRu2R2aEHZbcA3tjBWxOJI6K3FUUbKXqs6U/A8b7FMgpR9mZ0DXxaD0lhA2VXuky4jq9GubvjLM1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD1EyI7ryU5JORtWq3wpryFdDarXKIeWq+kABGcKe+0=;
 b=Z8Js09LbmYTEjltqGuDCddcs0RGAPe0wBK0KaSIpVGuTbApoLjEQFdnXauXe+FwlI066haeDy2EAU6USlvsR1Ar17a2yRHick+86v2qS81HSrs94EelO8nrX3WMRFnaFsGFWP1VIdRDykVlXOSllUb+vPcFZzLeZjaHXjz8VGE3EWAEcAQSIOcA1gRF/zrRYc3pDvQZ1NNo2++njBRPKfZSumabv1dqdjzY3CRNSms0VA1hExwlO0BEX6WdKvLKBtOvkXv+VzBzss1OGF6jbjAcp60RJ0yLMbGViufz1+suWrI1ktKhdB/WQEVBIKOoAOMHsa2Iz4/BJVV0Kfn/YxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD1EyI7ryU5JORtWq3wpryFdDarXKIeWq+kABGcKe+0=;
 b=2f0F2ZvNjthbu1aCaPqyreC7B1ZhiwRT+u3bcRWI54enr7N2gy97QkgxmBxnzpIgWqJN5P5QnmNi0CbLajY08a8GRP71nhypOwxERUzoLxK/Ynz5CSYLVrE1gPDTBe/0/OfC8zv22lhVJ1UOg01DCtmxIesiyXlc8/pype1sfF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 04:50:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6544.031; Wed, 5 Jul 2023
 04:50:11 +0000
Message-ID: <282c4f8c-02fa-ece7-e164-13e8c432902d@amd.com>
Date: Wed, 5 Jul 2023 10:19:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230630112135.3347421-1-kevinyang.wang@amd.com>
 <PH7PR12MB5997E56F35376475F7EA0502822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB5997E56F35376475F7EA0502822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::27) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 10901b22-6a20-4def-4d71-08db7d135031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ppz3JPA2xihThityn4eHyPxt51d6z1U57WNkln9ubSgNS/ntZ3x9fO/hzPauRxmMG/ijMbp4n2Mb07cdEhApQOOHdxxOmWN0Af4/t8I/ZjR3fwNczM2PDhJKsTgQ7PhHmItgDXp9l+3m7KXRPZVle3r9q3LyC6MKG0Mt8lMmsvL5s9c6bfVxH+AsWWLQC4XWegS7OjaEkuAXYtllMXglIQsaY0LbnqDzNwWCIu2eMWtxGntM3lSHPnusvvx9y4/r2HAFp3pKlZi1Uruo8b5tMnII13nruG4jxYYLhx2mVAatp+gWyWBdXhYVzdlmXiRHjE/i+cc+Ifii6uusoJDWLUbbbu1jEIptVQxxcyM/tp5QzziTocdZ+HnHFKI9vJX/2skSRBZTI8ZwNT9wHRvmKfgeZgI9WgCUSa8LDMHk0cZwsDlihSa2YHYWgk3JkKLw4Iv82jf57BR6MRQIOBrsA5756cHuqI36NXyXhSPcJIIbvvvFbhcELJk5Wv+Iixj6N6coymQDDH8xD82zI8DZ7i1QJ9mkkgS64N/+tBGiftccF6s5btAfXmB5Ddl8DtlUlZk6H5EwGdoYtR/mJg/gc/yy1fOZgpRK1zAN0n2pKu00UJQiyJ8cQ/GWCArueoTapnvKvvPnH5/yOKnaD8wW3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(41300700001)(478600001)(6512007)(110136005)(86362001)(31696002)(38100700002)(6666004)(6486002)(36756003)(316002)(83380400001)(66946007)(66556008)(66476007)(2906002)(8936002)(8676002)(2616005)(5660300002)(31686004)(186003)(6506007)(53546011)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNkTCtXTWUvWEppcGlUQ3VSd3RRQjkxWWtuVTJZTEQ3Ty9xbEUzdTNNejc2?=
 =?utf-8?B?OWU5ZzN4b0lobUZSWUhMMkdXOTloMi8xRzQrMVV6cnVVZE1EclhwRUROUCtm?=
 =?utf-8?B?cXErbE5LUEFlTVFZODJMTUd6eUZJblVIa0htVkxSc2dVbWNKblF0Q1F3S1hs?=
 =?utf-8?B?SStFaCsyYlYxazNFZXpsd2Z2a0pYVWZMb0tFMFpuTTVIaUo4SFUzelJGSDRj?=
 =?utf-8?B?NFZDdFJhTmNqdnFXb1FHTnlRejl6K1M0SUs2OW4rem5GYW1MWVl1Vk5lak1s?=
 =?utf-8?B?clo4S1ErYXNFRlJieFNrVmM2MjloQ2xRbGowRnBPSzBXM3NZWTN5dWFkSGFJ?=
 =?utf-8?B?eGpZN0Myc0VmTldUZUhMYk9XaXBRVVVTSHBWMXJ0SU9zWHY2eERyYW5iVm1L?=
 =?utf-8?B?b1p1Nll5TW5SdjlrbUs3T2NZS2swK1hrcFpBYXZvZHBSc1lMN2E5OEZhTW1W?=
 =?utf-8?B?NHN1OTVyWHdvbWNvTmc4VTZsb0paQ1dNZytTV29ZWVVSYkRQM1lMV1VOUkl0?=
 =?utf-8?B?ODZySHR1UWVvRWlUL2MwMVJUSFZXRGxQQ1lmcGJuNlhQU0o1cWNaMWdCVkJT?=
 =?utf-8?B?Yis4QUMreTNOdlFSd1V0eVZIVVgyTmoyOXBudEdWVjczVUwvb2N2NndIR2lu?=
 =?utf-8?B?Mit1UWE3bWExN1AwY0NLVE54OWFoL3oyVU85M0h5VlovU2pJMzQ1ZlRhcURr?=
 =?utf-8?B?RHBRZ3BqZmYzT1hBL08zYi9JNFgvSzFQK3dCZ0VlVE9tSGJGQjkrL0IzTUEx?=
 =?utf-8?B?dVpXTlhJaTVxclh5TDdEMXNlalVLLzM5Z3U3R21sSW53R1ByUlJnaFR0a1gw?=
 =?utf-8?B?VzJPTjAwdHBFRSsyd2VoUjh3K0FXVUdOK0V3S1ZqNERDQmJ6Zk1aOWNsbTdG?=
 =?utf-8?B?UEo5Mnl5aTJXNW5vak9tZXo3VlRFZlZaNmJNRytUYnIrS0dDYVNEVHdwWkJU?=
 =?utf-8?B?NUtvRi9QUFRTcVJoMWlWUGpaaXdYYmUzNEhmNWRJcGJuZ2xEUDVaWG9Kb1VJ?=
 =?utf-8?B?cDNmbjRmTGd6K2FERHJyaXU1VTFCWng4c0U4cjlBUzZzSWNJYnp2WUJ4UjRR?=
 =?utf-8?B?Y2s0RERQNUVWVjRUNXRnOTNMeTZrZ3JyTzdSMjRQaG12MVFwZkVDcUgvOG9J?=
 =?utf-8?B?RU1TV3hybTNYMXpDa3h4eXUySGY1YmJhR1VrRU1jN2JIMm4vd3hWcnNrRWRX?=
 =?utf-8?B?Sm5WWXdydCtuQTNZZFBMVEJjNlZIdWtXZS8yNTFKUk5hVnQwdEovV1ludHhS?=
 =?utf-8?B?R0ZkYk5EcVNoWWVrUzljLzJLWFBHSGUzWWZ0ZUp0RjV5a2NqeEtWYXFYTGNQ?=
 =?utf-8?B?YjdHYzBYdWxSRzc1V3B4V20vaFdxK2Z5djZkcnZFVjZjY2RoVDAxMkFuUHVL?=
 =?utf-8?B?WXhPQmtVb3o2VXQwVE9zZkxocndkeElENTN6dHNKZUtVZFc1WnQwVytqcmlV?=
 =?utf-8?B?andZV1dibDcxWnJYUFAyTGI5NDZKY25paTVwWnRWRldPNGpVRUxjL0t1ZHpC?=
 =?utf-8?B?ZmQvOHowWXdRU256RkdNdnlML0V3TWdtTUc0TkNwaVNrbXBaYUJTM1NZVFBu?=
 =?utf-8?B?dTFVWGpYTVBnZWxpR3M0MFJWK2h0Nkwrc3ZNZ0haN3kwSlowNnNxb2tLQXpS?=
 =?utf-8?B?UkJrTUZmaXBuc09XdmxHR1RyUEo2NUxZY0gwcThhQndUd0FpZ1d2a2pBN2h2?=
 =?utf-8?B?eGVmSVR4bmIwNG5nY1V4QnpacFVlNjVxc1BnUnRSUVY3Nk1lRFRWOGExdE5m?=
 =?utf-8?B?aHNsVExSMEpxRzMyajJwVDgyQVVpa0djVzk3b3JBNHUranpESG4wTjdKcWxx?=
 =?utf-8?B?L0dMOEFmRkUxNmg1cC9TMzV4L1Byb3RjV2dNRy9MTXBiVVcwTGs4SG9YbjFB?=
 =?utf-8?B?WHdhY2N1cS9aZzk1TkxuOU02blc2VnJWRno1V2FMNlhGVGI0SnVvYVE4aDho?=
 =?utf-8?B?VzJIajUrelVPaWE4Qy9XVFZNbzZVeUF6UWlwcnU5UnNhRnNWYUYrdDMzRW5j?=
 =?utf-8?B?VUR2Y3EzKzFxeHpCd25nb25hcXZTN0czZ2NacTE1OFJ0ZWxrQ0lYdFRYNGhW?=
 =?utf-8?B?Tmgza0xKT2ZFazU5Lzk4eklONGRSbndXM3orLzRQMWpVaENHbjcyUUJ6UUg1?=
 =?utf-8?Q?GOnNtfAsluGRxE+8ES/ORfjip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10901b22-6a20-4def-4d71-08db7d135031
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 04:50:11.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1Yw4L+PdUJu5pzRrLbJ2wiDhAmDlG9Idt4vRGKXu2gwKyfvgMZ1urF+AirPOJCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

On 7/5/2023 7:55 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> [AMD Official Use Only - General]
> 
> Ping...
> 
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, June 30, 2023 7:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3 chip
> 
> the dceflck sysnode is not aviable on GFX v9.4.3 chip.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9ef88a0b1b57..5bf401533103 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2050,7 +2050,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>          } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>                  if (gc_ver < IP_VERSION(9, 0, 0) ||
>                      gc_ver == IP_VERSION(9, 4, 1) ||
> -                   gc_ver == IP_VERSION(9, 4, 2))
> +                   gc_ver == IP_VERSION(9, 4, 2) ||
> +                   gc_ver == IP_VERSION(9, 4, 3))

Isn't it better to replace this whole thing with 
!amdgpu_device_has_display_hardware()?

Thanks,
Lijo

>                          *states = ATTR_STATE_UNSUPPORTED;
>          } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                  if (mp1_ver < IP_VERSION(10, 0, 0))
> --
> 2.34.1
> 
