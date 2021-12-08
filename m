Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 17:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D3E6F8CD;
	Wed,  8 Dec 2021 17:34:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D563A6F8CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 17:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/3Uvxu4zkp4EqLOHhKQXtfHb5MycygslKg3AEYfLhGZi4vo3sAEKxh1AMRSg2aWGLgsvG1/bsAinHyoshHHLbLL+AD5uKyafAXx+9TZpByjAyWH3JzfdEn6FNeXR0c/fF1eO5XeWsopc3QHeAMjLwSKO9yVtX7mj6IWQBJ1lgYW5v/2v8y0wfP7x2IkrpW/dvj9XU8tb/zjKZlYmyBRqmFqOXAyg8Zl4rvjRi/ysf+hHiZrWGW7s9zcnfLA8n1v89kC4FeFJX+MQ+FuWsTV0A97YTqiYWhaQFlkL4ND9iyhRRXbQZSBu9FJVsugnY/EW//NEo2HfrXvyPvWHG87nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrsmhtMDUEqRYoQclSlb1OFubgk8edtlxSqFf71cMQ0=;
 b=WmWyOi2LmU98TQJ+fA6+/gkEQGGnoF1zgrIYqASoHG3K3Ef878A+YmtSwEQQwjFIvI8dftyxg3mMDguOJUOIK14FpiBrJX3wuuxLIEwUXZPQIBSIl2gb9SBER4wSOtijKXZmRxy3fWycteQAkclIKZ/983SIMKV1Gmmjt503yiHLfctwqB5JUd6ol05iUX7tOrCg/dBgcDHS7VGePthbblebxXFmHb7HIA+4bRUgcRD0ZzGwSTr7Zuq77hzxvJc0StM+sY5czmH4u2JPH2s+yMCElFwn9XFX2M+o38jlajpBpldkLUp6T+0tPWviJCPePistViu9P6FFCiA8USeOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrsmhtMDUEqRYoQclSlb1OFubgk8edtlxSqFf71cMQ0=;
 b=BWzRYvf926cF7YNmrqygCyljnu5kbQGYUIunRdgexlZ2MMUe49SkCngoON79A9xJzWWh9X/WMI6zUMTN8LgAdOf6O9m59mY7+Zh+XN8VTd4Q/+r4myXfHwDBnZM0tq6nytmNjhmqj3Hnz4Tu8W47EOu+FFwwEALY4/q0zsV+zfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 17:34:29 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b%9]) with mapi id 15.20.4778.012; Wed, 8 Dec 2021
 17:34:29 +0000
Subject: Re: [PATCH] drm/amd/display: Add feature flags to disable LTTPR
To: amd-gfx@lists.freedesktop.org
References: <20211207173246.1554377-1-aurabindo.pillai@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <c7bdbc59-a783-d843-a7ca-f04011f5f60f@amd.com>
Date: Wed, 8 Dec 2021 12:34:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211207173246.1554377-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:610:e4::25) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48065954-0f93-4491-0bed-08d9ba70fd13
X-MS-TrafficTypeDiagnostic: CH0PR12MB5331:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB533139FE89022D55C945BFF88B6F9@CH0PR12MB5331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZiS1nvAaXLzq2AU7NNHpCnBehiGjKsGCN6BO7HnORsvmNnyZ7mVqxLVCY1qCI+FSRUKMTL2oFe6D6k/QT0ItxGQYivba8XP3HFLfyvT+83629iv7Ry83yx6vFD0MBudKkJpnmgM1Y0z4w9vxz2CuZYVW8b+N5UzYULTOTpQEi9qNpUdDG2T4osr6GneGPesJgilzbmpIJzxtTLTYlZkW8zJv5kU72KYrtQtanaWqpJH+rpWrRqsqjAAbczewxyh0YKeVxzyIMb2bJ4dE6UWZIn5AJZYAF7MVUO/aYNDB9Hhk7BI4Xwh7CLuW9r+dXiAtIs7n6p8x89KGnJTJmYBZ9y4V50F9GMhIiQ7p8OMLkRoMx6xZkNzTn4Nt7FyWGdE+bC6nAcsLx+pQJDoK2+JFcLLO21OnJPey9gEXfrY4ElxtRmjAP7EPz8Zf1BjybXLeGBUPzIrC4652OhCOGQ/SOgv4EPIjq+9cUphOu66B0ylnFVidXFFmx3PlzefB6cK5oVK1kv7PFJEHiYSiuXAAQ8UJwpSannVhaSg78xHBiERcYsyTG+2+RkerPTvudSaFhFDPqNWkOdH9nBoEridnM43BkVpZI7dAqbkG8eIVwuqcsDx8w4bDx6vrD7uqd44ML0QZp+UUBs1RXjdFM248GxD3Dg4JmO8hiuZKVfhik3fu+FIBFNzr7vg/1WN19YwmXsrGIVMKhEwVK981+qlXSSuPLwExpRwvnk3nXv69m6z7vuZy2+aioIzCPPpNOfU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6916009)(38100700002)(316002)(8676002)(5660300002)(36756003)(44832011)(6506007)(2906002)(66476007)(186003)(66556008)(66946007)(2616005)(83380400001)(31696002)(53546011)(31686004)(26005)(86362001)(6512007)(8936002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJnamhsanJSby9qR2xGSVp4QWg5OW5tRUVNdUJpYStHYzQxWFNEVXlkY3R6?=
 =?utf-8?B?NFlONlRkT2NhWTZkYSsrRk13RFRNUU5FUXdTMnBnWGhYeWE0Nlh3RjVYcmVG?=
 =?utf-8?B?M3lFZmF2Tk1MWjU3aFcyRndQM0YzNW00UittWmxqTklpZXRMQlhsQ3RqMGtr?=
 =?utf-8?B?ZzFoMng3bjJwU3cvM0pWaVZ3Sk01ZGNXcHNIQXJRRXEzQ3VaUSsycDB6MkRJ?=
 =?utf-8?B?WUxDam9zMy9QR3E0S2hRUVR4cXlZYmh0M09Za2w0Zk14UHRDSHk2bk1TT1dY?=
 =?utf-8?B?d3BBOTFzbXhjdUpGU2xJc2VrSFNpdTFoWGtsU3RDdHZGRnF5M3g3V0NZRnd5?=
 =?utf-8?B?azBrN2dDY2xpeEZoRytNSUs4Zkd1d1c5SjBBdm45NW5nN1I2eUF2SU42N011?=
 =?utf-8?B?OXVxUVJoV2x2R1d1aVZjV25HSGo5b0dsNXlpYVhQYXJmaFBRWWhCTC9wQnRL?=
 =?utf-8?B?SXRTZ2gvMFN2UHN2NE9acm5WcEJORHkwZUR6aFM0ZUIwTXdRdHBzZTBEdUI3?=
 =?utf-8?B?OG8ydmE2d2FnL0twUnlOaE4wSFNEWjMrWlJTZlp1UlQ5SlZOUjlSN0h3NkJ2?=
 =?utf-8?B?NnhRaXk2SG1jVFhRVGxRdFMvWFUzR1h2eG9xMHVOM1FzZGp4Z1dEelhUd0Rk?=
 =?utf-8?B?RVYxVXR0eDhSUWNFSHVJSktsNHYvOXY5b2t4VGRqMU15NEQyK1BCSTNSbEM4?=
 =?utf-8?B?aW5mZk0xQkRiL3IvTFQrcWFPWHM1eS9DK0htenQzVVArUFo4OG1Pcm92RzFk?=
 =?utf-8?B?U0N3RUtsNzJkU0lmaVlwU2FrTGJDOUN5aHRndlNqd1EydzJLbk9DUGVrUjg4?=
 =?utf-8?B?aThkWEpHb0xUQjc5ampoZ24vOFhJb3QzUTlGODMvU3h4cENhVHhqUE5JM1NO?=
 =?utf-8?B?ZUF5SDJITjFoZ001anpQNXFsL0g1Z2w3UjJCSEN3TU5RK1UvV2tIWWJHS25Q?=
 =?utf-8?B?VWdGaloxbVc4QjJjQWREbnFidW4vcmV4Tkd2NWM2ejN1M1BPK0RrT0JxZ2Y4?=
 =?utf-8?B?ZmRRdlM1alhKM3p5ZmllTnFGeE5VRUxqeU1XVldtempSL0ZWMW56VHQ2aEJY?=
 =?utf-8?B?MFBQYXVTaWJoL0I0ZHpRVjZCeHZFN1MvRUFrSzUyaFc3eTUrRnF6ODRFelVN?=
 =?utf-8?B?WEg5N0pwSmE4QUhzK0twTG83MlN2eTAvZlVKeWw4Umo4UGVWbC9xeWJiUEV5?=
 =?utf-8?B?WjVQMFg1bnEwdlJCc0dOQ1MzbTZrVEc1R2hTb1kwYngwZ2NjZm9NRjYrditQ?=
 =?utf-8?B?cWhhejBEMUdVdS9WOE9XVEpsclc3ZWtTVjBNNFI4YmgrelBmQllMZVluUVk3?=
 =?utf-8?B?V3JMLzlxTUVzTU5XbjJ2RDdkTFVtVFl4VlpJc1BDaFZHcjdXWEhoU3FUM0xE?=
 =?utf-8?B?aGZ2YXltaTRTYmRWbmJtWnE2STZVeVBRdXhrRXN0d0RRbklkbG4rR2RqbEli?=
 =?utf-8?B?ZUp6bW84UWtDZWZQbk5Ra1F5N2ZTMWYxWUI4Nm4xK3QrajRNNjFyV3RLSmxs?=
 =?utf-8?B?aGkxRGNNOFRRTk8zRkJvVWxMRU5GNThxTUt0M0FpdExNVFB6QkVVQjdJSkJk?=
 =?utf-8?B?ejB1WGxhZytmZWpUelcwSEtpU2poZWdTanVZbjhtVVlQOThqWU5rZkljZnN1?=
 =?utf-8?B?SFV4RjczaUNJRVJMcHFmSlRyNzBLMEovZXVaVGt5MmNZQ01XWWhIWHI2dkJL?=
 =?utf-8?B?RUpySFNuSDhKWlV0QnZ4UjJ1cUc2bE1UUkVrMXpuZUp2emFETnUzVStuUU5D?=
 =?utf-8?B?UzR4TzlsMEw5VjlrZVE3ajNpcU84bUxGTWc0WHNoMjl0UEp3ekFZT0p6Wkhm?=
 =?utf-8?B?MWRoN0o0UEdHd3MzQ09xRDNNUG1MYnMrc0s3Y3hvczcySzhXdERGTG42NXFG?=
 =?utf-8?B?ejJTTmhuaDFTaVdtSlZEaG9GajV1Vk16Q3p2ME8ybzdrY1VkOGdCRkJ5NGZB?=
 =?utf-8?B?eUFleXBFWC9hbUpKTElNckRiRlpWMnRCYml1a0NnQW5qMTBoZ1JuUEJyM1JU?=
 =?utf-8?B?a1ZvTEpoZVo0dUZQUWhUa3pleXJ1RnRFcnBad2ZiOWdNRXpodmEvR29HamEv?=
 =?utf-8?B?b09TUVlLSXhla3hzc0Z5QVRyK3JEd3NFeHpZWkRLZmZsTnJSRkRBMUFuek4w?=
 =?utf-8?B?clliU1lEbk5GeXBqU1ZCb2pWb253NlVid2JtZWZwQXRaUDFJS05nQmUrUzg1?=
 =?utf-8?Q?w1REfVb1y8vnz5krQXeARw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48065954-0f93-4491-0bed-08d9ba70fd13
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:34:29.5560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVQIqZ9c4EaUzDMAI6RRCj6v7avnPzJa4+o/7qABuww1DUBJJAzDBe9mHEED0jd8efAjkcwgPkzXCYWZ3Ox6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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

Hi Alex,

This patch touches amd_shared.h

Could I get an ack ?

On 12/7/21 12:32 PM, Aurabindo Pillai wrote:
> [Why]
> Allow for disabling non transparent mode of LTTPR for running tests.
> 
> [How]
> Add a feature flag and set them during init sequence. The flags are
> already being used in DC.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>   drivers/gpu/drm/amd/include/amd_shared.h          | 4 ++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d25e5be77dea..9433b9a660e2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1453,6 +1453,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (amdgpu_dc_feature_mask & DC_EDP_NO_POWER_SEQUENCING)
>   		init_data.flags.edp_no_power_sequencing = true;
>   
> +#ifdef CONFIG_DRM_AMD_DC_DCN
> +	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP1_4A)
> +		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP1_4A = true;
> +	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
> +		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
> +#endif
> +
>   	init_data.flags.power_down_display_on_boot = true;
>   
>   	if (check_seamless_boot_capability(adev)) {
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 4b9e68a79f06..3c72208b4754 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -231,6 +231,10 @@ enum DC_FEATURE_MASK {
>   	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
>   	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
>   	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
> +#ifdef CONFIG_DRM_AMD_DC_DCN
> +	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
> +	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
> +#endif
>   };
>   
>   enum DC_DEBUG_MASK {
> 
