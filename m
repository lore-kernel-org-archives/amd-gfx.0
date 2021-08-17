Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBDC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 07:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9337C60F39
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 07:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9337C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D83898ED;
	Tue, 17 Aug 2021 07:27:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE0E898ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 07:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv0FkM7aS8cH9ApwWkUy8/pPThldZ3nodlfJpX7K/G9/ClRjJQRjKqfZydkjIDfj7w6f/0LNoVnpyrezLUTvqUUqQhaBJQHlUrBNtsiXfXn0M7A7Iru7EnI1edBGvOWaTyjdrghMTas5rXvBNrmXldAnRt0gayoD+a1/i9qJtFBAOHvmuZPxFdzdTI9v54rMMhoN1v7q2BuOBl8W7LUZuuszp6fEBQQhn8U1Me+aqelrINotCw+u+7o/MUZbpepRL7mo3OabTgpa3mqjzIglYB8Q5SPDn53Xdz94hU444Bkkhvter01fY+0RNgBsvNQJFSi3cpZg0st5gj3SLoOwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwPFbRatOKT8fpF4/oUtmLafI9HZMxGLDhWIvXfgJ7w=;
 b=WzRbl7t8sfxU+eBx/kkh6GfdjB1bGPYmu/AqWWCM175ty4kEheGW6O+7HZkGFZQEkh+FgyzwbdsAfHGfjghpCfuT5nGClPOiUud6OpN4lVpAEc2doyUO5SnHe5FU6uQ7Ncbjms7VOMIKOFfuOakYvK7pkvxgzuDpNmsBeTBcFtop7kaMkN6RxQXI+0gvKdqI4sh13hBBOY0kLZcc88DcIb0XA2oVdWy4v2/SEz1zF6yxy5NoWR8Z2Afbtq88WtNRPzen5Yfun/BeXeWeAJ3XhUBz16wPK1Jb9j1UevnuyCtpdnY59Wy6BaNRspTVhcLkjzxaSQ8OOsCPsXfD603YTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwPFbRatOKT8fpF4/oUtmLafI9HZMxGLDhWIvXfgJ7w=;
 b=iBTj/1RJjsnMKKwsslh61GCdJk7TFNqH6UIJzSeQRa+IoJaXgqCVIrMVmkyl8x6filaENALEwj9xX/BT99q0cKILO07aS/bwW7MmgAWKDE/hyuaJqUzR/41o4Okt+BF4+OqXVj0MSZHr3qCSk4rQSFUTDaMPYMAKH/i9C0RHtCE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 07:27:51 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 07:27:51 +0000
Subject: Re: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Guchun.Chen@amd.com,
 xinhui pan <xinhui.pan@amd.com>
References: <20210817064005.1437328-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <374e0b56-e81f-b4c6-ae97-0ade2c0f5b36@amd.com>
Date: Tue, 17 Aug 2021 12:57:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210817064005.1437328-1-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 07:27:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92ed0ef2-76bb-432b-7d9d-08d961508563
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB555688E8157175656B2BAAD597FE9@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDwDjwjjMwODQ1dH99/q2SGoCkPCfXXNHfDEsd6zrhfPMrpjVuEhSU9FSqBh6L4Y49YIojeJSKGE5mDcuOXrTlsNKSh+5EPNXgJ/Nd0zpehojSuGrQFRYEg34EoyvMQ9sa5fAuVeIpq8bbmnJpXaDCb0+E0M16ozP0pBWFLUsi3jgKzKCd++8cXtB1oJig9FxnhwU1p+TqyouxEA+UsVTkFha2S4QCDAFRiO/SRMZjlNefKo6V8CDhfOcsZaz3HiSwBGoCvJtITXJEr8gFjg5FTZKw8Ro7y7aXioT+nA9CtHt+5WsAwF/Sid2fyAi3hVQ+48EpOcl4V5WMZSHryWzndrRKvKUMejAWEaeXnPnXjHSHYQBk0k9k0OKmhjA+kaTod1kGp0351VCyFqCuYOGnWOba63BwQUM0DDxcgPAj7gCpkTM5a4/4mCvjFOcXlnUM18ZdWsRTg8X1OJwYAMN+hFXSTPaNL+8ccnxlfhyW8EwNgnj3jdWZdHRCQ9SmcC4B6Z6SA1gXFYFeDkzYayE0h5HNvOCMkuqAUnVrccW4VesJm4XLFxJRUJ7al8G7mEXa2zDzYzKtbHEYzZ5LmINGnQyfG4tkNXmI46YFYtFh9QuiFtRO50EfEdAiA080hk2KiL8jQM2R3N8Z9xIjQq/PgLpYNNn/hoUFH404witp7jX8vC0ylLwaFt/ZtozbAPZxYWI5V+7a0PpYpjOq/6Aj76COuQ8pdnx5vKSGuJJTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(16576012)(316002)(31696002)(15650500001)(4326008)(66476007)(66556008)(6486002)(26005)(5660300002)(2906002)(83380400001)(956004)(2616005)(6666004)(38100700002)(8676002)(66946007)(36756003)(8936002)(478600001)(186003)(31686004)(53546011)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elFyM2J1Vm9PRXFSNnhiYzBCZThEczFRcm92ZnMvc250V05NMnhqc05lKzhB?=
 =?utf-8?B?RWhHTUFkbG1PWkhtN0NXeEdMYjVLRHNzc3VtNzR3eExwa21aeUI2WmZ4Q2o5?=
 =?utf-8?B?MWoveTdIL3p6aGhZNmdqVVI1dEtnUzFqbjdZZ1NQTTF6SzdFcGlxUHkxc05r?=
 =?utf-8?B?OGZsTzl6Rk1VV0pMSTJFai9WMCtkSTh4d1dqOFZXTGdrcXNXN0Z3cWg0WEd5?=
 =?utf-8?B?ek4xTTlRaDM3QTZGWlhTWFlNZ3VraFE4NGhLZTRwREkwRkZ6UmZqK25mMmFk?=
 =?utf-8?B?eDJyR1BtaW05cStLa1NaOTEzbE81TG1SS01odUU0TE9Md01PWU85VGJMQ3R3?=
 =?utf-8?B?eGRsWnRUdTNXTk5jN2trTmF1b3F3ZHVMWjVxemdjWCtWL0FCeGliM2xMTkpp?=
 =?utf-8?B?ZURITmpUOGVlNzVlQkZqOFFGbFNSblJzeG5ZRGgyV2NZckl5Q1lBN08vcm53?=
 =?utf-8?B?UzFpYXNEbWxLdFlQOVB0WXF0STFvUk1nb3pOSWJ2YUVoR0tjVXNvS3IzcXZN?=
 =?utf-8?B?T1N0b1k4R0k3WFZQSkJGazVFNHN3SzduUTd3OFhzSVdCM0x1ZWVGSlExRWhl?=
 =?utf-8?B?OTlsTVhZNWRXcmdVTUNBQkdMOGVKZ1VwMCt0U3oyR0EyM2Fsa2J1blAwMkE5?=
 =?utf-8?B?MldzVXREc3pYQmxOZlQ3aUNFOFVrMXpDYUlBaXRrajJkT3BadWpkTDR2Y01Q?=
 =?utf-8?B?MytBbnFOL2Z0cSs3U2QwVkc5LzY0aGlwaWFFSVF5d3RNd1BIeU1VVDYybytm?=
 =?utf-8?B?RklqZmRKUGxXTWJGdWxzR0dNU2dsS2tTWmNERjc3L2dUVEphaHdHYWlWcDB6?=
 =?utf-8?B?U1VNeWFENTJwK1E1MkptN2I4YU4rS2g3Wmpyc1BuVHpQbWJ1T1JxWndpTlBv?=
 =?utf-8?B?QWNDcmFURWdMRENjeXBnSXdZTmt1RWNMWnNHWFRqY2U1cDdzOEUzK0I5QzhQ?=
 =?utf-8?B?UTN0NHJhbnhwY1JBOVYrbUgrSHNYbHIrTkU4UU5zbUplUkVxTVh5bDgwdCtr?=
 =?utf-8?B?bTQ0ZjVDRC9BOWpadWpleUttMGg3ZElYcTdpZE5jcWF1WVZuRmRiTHAwQW5M?=
 =?utf-8?B?QnJWa096NFZkQ3ZJL1djSHk4U2pvS0JkQVV4ajhWem9YZnQ5U3d6Y0h6dDVw?=
 =?utf-8?B?Q2k4bnkrTkVIcmxqSk5pUFppR1N4UENFKzc0OW96OXUzMU00a3E1SXNYOGsv?=
 =?utf-8?B?UFJRTzJjdXlPMlBPbUU5Rzl3aGhVMkE1RWVlalhrVUwyRmZCOVE4WjRvV1FY?=
 =?utf-8?B?MlVveVRlZ1k5RVJxdktIcEQzVWZQOEpiOXM1cW1RSWlXZ1ZIcEY3UUt6cU05?=
 =?utf-8?B?RHNjL2xqSkNJY21ncC9FNityLy8wai96ZEcrbThRRkZpUU1pa2tEbms1YWph?=
 =?utf-8?B?aHJXcm1iTnhUM2wvWnUySVRHeVkyQjNySTNFQTBtVHFpRUJzbkZQbDN2eCtS?=
 =?utf-8?B?WitaR3U4Z2orVWZRUnVveVp2OWZZNXM1VjdHR3N2UlhkSHgrN3pTZS8zeHRC?=
 =?utf-8?B?dzJmMmc2NE9Wb3Q3ekYzMlQrcDZ5UTluRGVXWlZuOGNIalZqNUx1SGF1RE0y?=
 =?utf-8?B?aUk4OUdrVTgrb0R0dEhWcTU1eEhKblppQVIzUnUwMmpNcWF3OW92NllPM1ZJ?=
 =?utf-8?B?d1JONjhTY01ZVFVLT0R0K3BvUlR2aGVvQ3JrWXpRSlRZQXRjL1hmbDRoUXRj?=
 =?utf-8?B?YTlDQVVNK29BQjVJQTR5T2o3dEhWUWY4d1prOWhDb28zMUwyb01KSGhVTXVn?=
 =?utf-8?Q?zp/en32PPfEwOGzCVg72LdZV8YJ0CzN8oOn0k0K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed0ef2-76bb-432b-7d9d-08d961508563
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 07:27:51.4376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taSgPMEJE00YofUI0NpaxljylczFUL7xwruBA5Inx3Ou3H1+2uOfGT2Ct7wYfr2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
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



On 8/17/2021 12:10 PM, Evan Quan wrote:
> If the powergating of UVD/VCE is in process, wait for its completion
> before proceeding(suspending). This can fix some hangs observed on
> suspending when UVD/VCE still using(e.g. issue "pm-suspend" when video
> is still playing).
> 
> Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 5 +++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 4eebf973a065..2fdce572baeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -554,6 +554,11 @@ static int uvd_v6_0_suspend(void *handle)
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	/*
> +	 * If the powergating is in process, wait for its completion.
> +	 */
> +	flush_delayed_work(&adev->uvd.idle_work);
> +
If running idle is a prerequisite before going to suspend, then 
something else is missing here.

Otherwise, the hang looks more like a pending work launched after 
hardware is suspended and trying to access hardware. As the hardware is 
going to be suspended anyway, doesn't it work with 
cancel_delayed_work_sync - making sure that nothing is going to be 
launched later to access hardware?

Then this may be a potential issue for other suspend calls also where 
work is pending to be launched when hardware is suspended.

Thanks,
Lijo

>   	r = uvd_v6_0_hw_fini(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 6d9108fa22e0..f0adecd5ec0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -503,6 +503,11 @@ static int vce_v3_0_suspend(void *handle)
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	/*
> +	 * If the powergating is in process, wait for its completion.
> +	 */
> +	flush_delayed_work(&adev->vce.idle_work);
> +
>   	r = vce_v3_0_hw_fini(adev);
>   	if (r)
>   		return r;
> 
