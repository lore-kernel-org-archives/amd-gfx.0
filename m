Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2034FC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 12:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BA510E0C5;
	Thu, 21 Dec 2023 12:57:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16AF310E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 12:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmlGhdDy3J2EngYcjC8SkitKMbFQYhk3q9y9qvSe+cc4CftrIR1kENAodgyvHz/5WfcwFjBGFcsE1AN2gS8U3dmKXjGeYaiZaJZ8evCn69Wm6cq/lvMnNreR0R9TJSBiWuY2QGApUqCG/Y8sq+iDYe7/XM10kWU6B+GQlXxC9p+iJyNx8VcsziBCtV/MFjPaQ+q4+SP/yUZcw95RMdQoGfMp8s1r4i3ixnCAAS2ncu/eMPu9nr373DpLCbksWsyZu8BPExy0gm1258hOTdk5k7vIelH4w5vsGIs9mvflZpPMhr6JFzrTRRBNoc9sVkEZMQOzUeFrOPATYUgv0n/pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeKxVL0RQ0ZjDcrZ67IMNwk6Pj9PUFZgsYbpN/qAC8o=;
 b=FWZvZpxIhxKMz4NadkeorUS2g31ts0iUf7/IL9o6vVF76+M+NuNTo3ytpkMbHc6pnX/sdkgdtI7BPnMR22XUfqhcfbWXzfVQPGe6BBVuYKRTAIIYOeoUMecokg/8S5ht/azfgCtV3lI5iPOWgR8PiBsYqKANS+l9uJMQtRzFOumW9+3rW1jBdyhO+ZHXo8fMT5skEs+jLrFUq71WnfBqBY6Xbq+Mp4rs9eOdnMGdqwDJno0BJvfQgsziU4DrXLY/5s8bNcYdY/MQl4UZR0XOVPB652p0j+6j7360HFh+4j3ffUZCzGgttJGbhjrlRjZTMzhxRsVWeb0+1PkH3fLGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeKxVL0RQ0ZjDcrZ67IMNwk6Pj9PUFZgsYbpN/qAC8o=;
 b=2lyEJOlKs0cB0ne1Gi8GaEzRTpTiFY0uZ+EUILzJeRdswFga7rsXx/Vjqijaf1wSEADnBPb1Xbcw6UlFkOOCJYbwC6hLpV9Ld4EJKWgQyJbOxZX7WHrjsUmRcIjd68a8nDy/C7xV2147RL2cEam8W3hpxziqTmWW8CikHfHXlvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 12:57:47 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3f12:7d3a:398d:b7e0]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3f12:7d3a:398d:b7e0%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 12:57:46 +0000
Message-ID: <987749cb-b6e0-4e46-ad1f-3b45b9d0a635@amd.com>
Date: Thu, 21 Dec 2023 18:27:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
Content-Language: en-GB
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20231221124505.1319447-1-srinivasan.shanmugam@amd.com>
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20231221124505.1319447-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: ba049a72-bd09-4b44-7418-08dc02246dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Qy2r/AAZju3PvCde8r9KiOkIxle/yNSYYw87Vz6VpXtIxlFipTVaakRtJF+zQWTaoORpZEVBq782U8WbfOKp3uOFUuBS0BY/QKFSEUU8J2iFyAiAydlSd7N71U2QjDtc9sm1HrATYnb4ZCslLfhUJSW88o/xcPS3wIdzEaBbM/cDhD7PW2ahaNPUudxy3BHqHjG2Uj8XNOxEheZ7fRbpeoPDhHTsufYsWnWS0zhUXw+PQJswHuF1c6hlFbMJVozaSpKK7PgzprP5DSDwmrZRNvtU/UIXodPUopbYj7aCVFIz9/iWXy8TgWdzUaui1yJpAK6QTJX2WFeLaMYPSItYGpWx53JmCg6wFkzG0p59e0G7Tlglfrr2GZ5+m/t44D7jKDO/rQwLq+bQAqDu35ldUKg97O56PwT/n1ImJCHlGeoi1BDxy+gxQswEQhM/+xAFeJn/4zZ2EuFvbGZ2p4JWE1r3cvZlbqPZPKoEG3Q5IYQp0Na6eNVufC4mZmfJpWjuiPlAKOdQo+uEAwUsCDKwPBYTDl89IJ0eCoI+7eGIqgPcYLP31cKzJqTlRvLNdDmyvN08EndMiYsGHYM9TAb1Gd9Npe0xK5pSErkh6kMSsLU2V5VSXjhHHrHPtYKym56hkCDiz1UtHbthtTHpvdIkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6636002)(66476007)(6486002)(66946007)(66556008)(6512007)(53546011)(6506007)(6666004)(478600001)(31696002)(36756003)(83380400001)(2616005)(26005)(66574015)(31686004)(2906002)(5660300002)(8676002)(316002)(8936002)(4326008)(110136005)(86362001)(38100700002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2YrMkYxSE1QN2FNOStUc0hiNW53S1d0M29UT3VQZjJpYitZLzBDWWpYR1lS?=
 =?utf-8?B?L2VrNHIvam42N3M2eWlBb3F5TTdUY3piZlNXL3c5bHdqRHRyVTRGVmoxaXJl?=
 =?utf-8?B?YVBLTjF4Tm13MTAxa053SEdSdHhqbFUzaG05KytaVGNHd2xtYnBld3Y3Z2Vh?=
 =?utf-8?B?d1l4dXhvRnBOT0trWkZLVXpYd3lBbE1HL1djc0JrdG14V1MyM0dmMEtFWVVl?=
 =?utf-8?B?MG1JUzBVZGpkRlVyT09QdWY2L2tLYXNWYjllMGVxQWtMOGZDeU9GMFNxTzFB?=
 =?utf-8?B?aEoyemN0Z3VrbHBCMStlTitXN1lDeFQ0c1RKNXBZUkVJU2dnKzNQaE5DYU5u?=
 =?utf-8?B?VU1kNzAzZDFITzBLTnYzWGNPQWVxc0dCNGRBM0dkbWlQTFFtQUE1NTdLS3ZY?=
 =?utf-8?B?UTRWVm5mM1RhWVBlditTNTVxcTRheXNtb1gvT3kzTWtEYnVaemNoNkhoUEpp?=
 =?utf-8?B?eS9abXU5dWVIZWtzTVl4cVpKYVB3dVIxZngzaXYrS0VtRFIzRnVpNEp6QVVC?=
 =?utf-8?B?a091SUltbU5NL3pkUVg0VkdiVjc1b2tzNnRpS1RkQXY1WXY5M2t2RExlNUgv?=
 =?utf-8?B?TU5ubGFvN0lhYWMrNmpNUE9lMDRNOU0yL1lXa0VGWU1YSDRIRG5wdVhtd1kw?=
 =?utf-8?B?SVJ6N0VURlNUWE51UEp0MUlvY3RGMld3RTExQ0xNczBSVVlqVEF2aGZ0Zjhr?=
 =?utf-8?B?VUV0dHp1VUY1MjdpM3o3NjZTOURZemRjZENuRWhxVzhsTUJtQnc2VGVhN0px?=
 =?utf-8?B?bktEQlUwMFVXZCs0UDIwMHN1Rll0VnJOV09GTUQxQ2dFZXU5MTNmMytaa3lR?=
 =?utf-8?B?N0VFbFZRMmhhY0x0U1FGQ1Z0TUFCRDhhMlVEQnM2TG5ueDAyVDd0b1dLeHg3?=
 =?utf-8?B?bW8yYy9NQUVKTjJjMDI5YTExNlFBbHNMZ1JteG9vV3lteG5GaFZ5VjVhRGVj?=
 =?utf-8?B?NWNvd0ozbVdhOVZ5TWpQcVB6M2lEbXE3dGhOOUVWZFFnRU5rcnNBcm0yc2I0?=
 =?utf-8?B?aHViTjRPbTNqdktobHVraGRGR0Y2ZE1KbU0xSy8rYi8xeTk1eWppWTNyY0xi?=
 =?utf-8?B?M2N3KzlzTGV6MEM2N05vK1NZdTdoRk8xOXhMZWFFRDE0YVJaWUp5UUNISEhQ?=
 =?utf-8?B?Q1hWRE0xdHlVM080UEZ3RjRxZ2pQaGpIWHArMzROQTdMd3R3YnRtYThIeDVT?=
 =?utf-8?B?UXh3dElFb2Zvb0JFTXVrWUZ3QklMMU1FeGNpTWQvRXNxeWRjR3F5emZrMVhP?=
 =?utf-8?B?N0FxbWlGRUhLU28zY3lBSWptQWFjZkxET1UzNytPWnVVRHM0MHZoVDBENWx5?=
 =?utf-8?B?NENyekl4VGNjZ2hKcGpoc1lMUkc2dU5tYUdRaXljMEdDVlZmenJwV3lhcGtY?=
 =?utf-8?B?WlZmWVhadFlDaEFmTW13WHhOYjlJU1M0VjhUUHNGVHdGMzdRZ3NOUVhTcnZv?=
 =?utf-8?B?dUJwc1JSM3hyQmlHQ29IUjQzOVZ5S096VkptcEdaZjJMTUJVS29tTkxjci9m?=
 =?utf-8?B?Vyt6c3YvR2NJTDBaSkJneksxVTV3bWJUR0VONzc4Z2d3SW9aTHlYcG9lUXYx?=
 =?utf-8?B?M2hIQ0ptdTFKVlNjZTlyY1VmVmhkSHNseitMaG5BZ1FsMW5OSGI4R1JtNW5y?=
 =?utf-8?B?UjY2Q1JmRjdGSDBaWTloM01nVk9PZFBVYzFZZm9LbC9VQlRwMjM4dThQZmhL?=
 =?utf-8?B?dlQ4eTJpVkFPOFltNHVHbjNMTjVCZy9lM08ySGFyY1htdURFRHJ2bmN0OWpi?=
 =?utf-8?B?RFNsRnJUQ1k4R0ZTZEZlSUk2VmF6SUtWMy90cVNET0I2bWgxdVUxUGFUTmth?=
 =?utf-8?B?bmFicld5L0o2emwzcGY5aHlBd295Ky9VMEtwNzNWUHV0UWgwY3NEUUlYeVVS?=
 =?utf-8?B?alZwdE9nSGFCMDhZWXpqL0RGTDhxbE1RelZUZlIxWjFNQ3N1MGhwWjJkdVZL?=
 =?utf-8?B?UE9UdENzRTZQb1JJb2Y2d2FsNCt2aTFWaEE2Tmg2bUpXYm1XR3M3cThYMjBI?=
 =?utf-8?B?VGMzK2xzK0VsNDQwZ0srcElmRkx1RWxJK2pOV3V0eWxiVHpUMXk4OEUxeW9n?=
 =?utf-8?B?NnNnVGhSVUwydUdMRDI4ekM4ZWYzckV0Z0dVSkZaaCt3NlAvUXBnUzRrN01L?=
 =?utf-8?Q?zFFwIFqJZuM6ykFL/5Y61UMFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba049a72-bd09-4b44-7418-08dc02246dcd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:57:46.7897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03ShZBg9WQmixqFWaqVJ6iYy9nhFx8eIiwqXVWdOkgNRurhK+V0Rz5+BPygSu0U8QWwJead93uPmVAzS561qAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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
Cc: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry, there seems to be a problem in the logic, will resend v2 onto this.

On 12/21/2023 6:15 PM, Srinivasan Shanmugam wrote:
> In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
> 'adev->pm.fw' may not be released before return.
>
> Using the function release_firmware() to release adev->pm.fw.
>
> Thus fixing the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.
>
> Cc: Monk Liu <Monk.Liu@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4b694696930e..669e6261b707 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1544,6 +1544,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   				return true;
>   
>   			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
> +
> +			release_firmware(adev->pm.fw);
> +
>   			if (fw_ver < 0x00160e00)
>   				return true;
>   		}
