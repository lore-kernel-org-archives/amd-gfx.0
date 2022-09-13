Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AB3C6FA8A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 15:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024A910E49E;
	Tue, 13 Sep 2022 15:07:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8394010E49E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 15:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2qW9csqKxjYm9Pd8wNQxSE1iT3/ruxJ7/oWJjNP043IUC7KYnfhf26Jg6q9eDBnWyPkl4VodTmPUcf6YKMf9+0+8m6Vgas9VYY8v6Yi/Bk5zEjFdqrl11ueEoAlJPpzE+pHkpTm5V0BX9/DeDW/n10YlG1rfBgL4CK6u6K64HIATL95THvk7aX+vw00KWsOQNFb5ubV5m1j+Re6vearUsKEnCRaU+vHHnKDCINXmlvbwjqvOy4Lk4ABsCVuJiZJlxPfkyuLvQZl/2OSDK4fsRd8ahUoiKq1dxBiw+sw6IlCzlcR7gSyt+oICfPm2sX34dS2cueqKLECeLPjHFzMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnWgYKdUi0iasXQwWw3YSo+6DAFyk1SGKwCXcIUG4oE=;
 b=cXJ1/CtsTM41obdZNY82YjUWDkkvJ5Qd6TC7Gg6E7jRSlDwFMc4ieAdz+Fb7Si76LwU1vfbOyb3SxBYWWY6JPRqw5Mf2LULbvBFc0ObtQwf8JrD1vm6JxxWKv0bdZIS/J7kCqi37RLG53gE9dQki10AtjgPQ4Omyy/53r/Kl4ZUpTBGEzgiaKaGWrZX4eqw/5YtOsNsW/XDsZ2tK0Vd5OHwdKA0aqtixM9/pMEs7g/0NZsKS2B9uHebu+o7dMRBIJKpYa9eU07cqZJmAh/DvKDUdcw+dM/cOtdvXTEFZJzupuifq5f3OGv6+wE4VqbrbH1kcIBf1PbXMJCRpdDupIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnWgYKdUi0iasXQwWw3YSo+6DAFyk1SGKwCXcIUG4oE=;
 b=dtY98omhZhCNdHSqjPBReZhe4zyFkg3wVSpYE78jgShVOyeKzsIk9avt+qaQ8rBME6iTHs7XdqnXha493sTp+3ofFX4Rm6n1yYAcA+SYJj6yqkGEI4Oqp9e/yEcI47jrzgA28zTZX+4rgd9eCyjH5S9CZFrj8QfGBYgh+eDyn/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 15:07:46 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:07:44 +0000
Message-ID: <14360d16-35dd-8b71-bec6-156ddc6c7526@amd.com>
Date: Tue, 13 Sep 2022 11:07:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <75db4358-feda-0a0e-415a-ad5edfd4bb89@amd.com>
 <a2482795-4be3-1055-e81b-aa0c8d985e4e@gmail.com>
 <88534536-4707-32da-5af7-04668b8cb4a8@amd.com>
 <7dbb161a-ab79-f694-9eb2-b932ff419fa7@gmail.com>
 <42b819a4-f6aa-074a-1c81-134e00a60841@amd.com>
 <7fdb53b5-cb21-358d-f582-756803d87aa1@gmail.com>
 <53807f46-1f71-8699-a4ea-3a65afe386ec@amd.com>
 <DS7PR12MB63330F119F240F3F62551174F4479@DS7PR12MB6333.namprd12.prod.outlook.com>
 <75d18161-e535-e35e-2fe5-693846e98b79@amd.com>
 <8b6c51f4-9e1a-2e02-2c93-00b80bccdc07@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <8b6c51f4-9e1a-2e02-2c93-00b80bccdc07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: acca7b5a-8107-4f8c-a5f8-08da9599b5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oN10W7L6R5GaRXYTh6EiVL5jD7PS8ZC6dZiDz/FHdg1ZI3HmOGFLkvRyg7mK5a4xZP0jkwm+8DCLr8t/JKjpqwNgC6J7YJ+vSqFRhyZ31qi2dPI+sIzxqtN4X9Detpi4XFq3S3Zu0zyVEkT06TbyM0A5dfxu20XWGzlg7caMd119JgVTqfYU+hArbIcezo/WPGQ8Og5TIbM0HukKNFyxQF1azocw32BvRX4PxREk+vP49BjQTvIK3jT+vbHKY0AHu497bM8RS2O17XqoF0q/qhR7gGqlbM8AQFF7lrejaRq6TQ3Lg7Q7qpl2m3BrGDQccusIZFWu02GzgM680MNYaEB7yNwpl9NWHVM4Z1nD4MMQIftDWAfL/RNKJumygACSFGfDFLVjkkCCdc7VAMymFsCC7IdoHzjhvzHuIgANuNM88F+WlUEq/LzyCRGkD6Dohhy2gAsu5c5Ev869ZB7FgP7cwWM1MK3ITjcJdBaYNzPBOAMFy7Rez/KUi87PXsVhg5E/BQqsvBa6OUeDimkD3ItgKmRIQkq0Jq0UY55nvPDyJmrWsJBt93mX6r0ySfnFPtXsWDTvX2luSYhqTn0JkwB9DAybbHPVutVPDkuDxywSrqMO8RWEsO1MGJW+cUzyo/wm5z/W2YwQY7m4Pj8mfpKezOPzhjzLOM+M3wOzhFe0xk3m/1LSPeea9KsrqvhtQaemBA1k9aRyxUcVO70uiJBdE6/SC5b6tCfDZiawI3do1zYaWwE6aJ3y1S2dWIDRCPBdDFiBgYpx2+BpZ2MvyDGqJvbZ/aRKtkh/UsBv+Qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(66574015)(66556008)(6486002)(4326008)(2906002)(66946007)(110136005)(8936002)(186003)(478600001)(6666004)(2616005)(36756003)(44832011)(6512007)(31686004)(8676002)(38100700002)(83380400001)(5660300002)(31696002)(4744005)(86362001)(316002)(41300700001)(6506007)(53546011)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHdGcW5OZHczdEJJZXNUUCtBdFdudC95STArWDFqMHlJZjVCUzNVWnQybGlX?=
 =?utf-8?B?bXNBN0pKdkErazlIbmdDeHdkWGkzcXVkRWtPdzdUTDZOYitJSFJ2STVacTlx?=
 =?utf-8?B?c1RnaGtVL2d1WFR5VEM0MGJOQXAvdytCdm5iNG42M2xtamhyNFFMbWwzOHBj?=
 =?utf-8?B?S1gyTjIvNGtZMm51WmhQeGhQZC9yOHVndzU0d3pSOEljT1A2R0hpdnYrMjFN?=
 =?utf-8?B?cW4wUnJCYVlza25CUjI4RGsxYVRHd0d5YUI4MlZBbm9PZm95NTNtY0FuYzdH?=
 =?utf-8?B?RUJtQjBGWVlOTDd4VXNPZzVxb0VOdHdDZXNVRlhrY2wxWGR6RVkrRW5hOUVQ?=
 =?utf-8?B?RnBxN3VKUHNPS1Vxd2xNc2trRlJGR3JsWkRnRGprcmFkOGoyaURycmxlRExK?=
 =?utf-8?B?K1grUXRFTUw2STMwb3R5ZW5haG9mMmxjMExjQmJyMkE2dUwxY1h0S21GclhP?=
 =?utf-8?B?b0FuN0FXUElYR2Y5TmNlSkdNQjU4RVZqbkthL3NKTWZpaVQwRHlIbXNJSlVL?=
 =?utf-8?B?dVpCSXhRRG9TanhOL2VQNldDWUxBTUJkRlNYdzJnV3gvVFpqWDZVVXVrMzRP?=
 =?utf-8?B?NHIrS2gzcVU1ZW96ZjRQRHl1TlBjOUNXTWMxNWQ0RCtUdkdlRjlPK20xd0pT?=
 =?utf-8?B?Yk95N3owWHJ5WG1NSmNhMVc4WkZJZERubXVBR0JCZkZHRysyRjZqV0tBWU1W?=
 =?utf-8?B?b0thMzhPR0lMMk10NmZibkY3NG1Kd2Ftd3BKaHNnNWF5dlB0VWJKZ3J4aGdE?=
 =?utf-8?B?MGFmRnNPeFdLTFBPNkhwRFRlMmYxVGJRakszb3pvbVRIQktFOEs0akV6Z3lr?=
 =?utf-8?B?K1Z1eFlIS1RlbXVWbmczcjFtSDhDM0QwZkVndG5rZkxtN0htYXNoOWxBczFP?=
 =?utf-8?B?YUxwYUkvQm1Tb2xZTDQyN2FlMmFhSTJqUnN3bnZUL2hlVDR3bHgybGU5aFNx?=
 =?utf-8?B?d0IwN3l3aFBJcndyTDJVaDgxS0l3ZkhWbmlGbzdqWmcvN3hyKzVBQndiVjc0?=
 =?utf-8?B?eGpWZTBidDNwNzhQak9GMEZGUTh5OXMzTUkxQXozSWdNUWx6eTAwb1UzVmp4?=
 =?utf-8?B?Y0hMNmpsZlZ3N2FtbXJtVDlpRGt1MEllQ01Zb3FJb3JCYlJkRUhyaFVNb0ZF?=
 =?utf-8?B?bzMvcks4OUlXK3BaYXI4ZG1Vb1pWdTQwTzVXY2tKeU9ZWldYZmwwcm1KdlY4?=
 =?utf-8?B?OFhzeTdsKzF1cEpobkM2eE1NRWZmbEFXb2N1MitkeWtFTURvK2FQcGRLeU1k?=
 =?utf-8?B?dUs2NU9NY2FqZE9nY0JFbS9MbDFJRmpDVUN6UHBnUWpCaHJkRHhyUnFZRkpM?=
 =?utf-8?B?WDI3UG5iemV0V3JuS1RnNzVQSS83ZHhPenhiNks0QWhLMk9xd0VsdlhJYXNq?=
 =?utf-8?B?N1lUUmt6czN1TUtaVUJkWUtSZXNEVjg5NWx4WXNjb1FmUmtYZlAzRDg1RE8z?=
 =?utf-8?B?QlYrbTVrN2toMlhRbTBseVI2Y25hM2xBcmtrdk1yc2M0alE2M2ZHS2JOVUNY?=
 =?utf-8?B?TnpNUDZsbTlMNk9mNktJU3hCMWgyZDE5R2ZCUmY5c1lqVFliUFMxeFBaTWhU?=
 =?utf-8?B?aEQwazZHbW1HZi9SNlNldWdrTlpjSzlVUXFHYUg2Y09xdkRnVTE4ZEhkYnJQ?=
 =?utf-8?B?b0FTTmx0TzFzdTg4bS9nb0Vza2hkV3k4Y0hSeW9hRmF5NVBCSk5OU3J6bGNS?=
 =?utf-8?B?eHlFTmtUSUVTYTRobFNMQmJPbThxcUFQdGVsa21kYVBPd29XQjluMWp3b2xR?=
 =?utf-8?B?cS94STdTN0FvOEc5WEpCb0lvcEgxZHF0K3dCTUl3UTFwcU9PckpPVFBsT0pv?=
 =?utf-8?B?RGFRdTNMcGFEQ3ZuRzZ1a1VSbVlXZVpIN1pNdHlRdVZpcXZpLzdBMmltVWVo?=
 =?utf-8?B?YTc1SExTTXZQRlVQK1RpK21zUDczUko5dEhiQVVvVmNKd3VHTzFWanBoWS9x?=
 =?utf-8?B?dlIvZjJZSzAxVy9CMDBmSkgzNVF5QjhHK2NyNlI5VVBzS2RFdWdEblRzZm1H?=
 =?utf-8?B?VEdsWTZMbm9zVnk2a1kxcFRvUzB3UUlBZW1jTCtNUWtxMVlhWkVIeUVCM2Jm?=
 =?utf-8?B?d2YzNkMxSXpPanhUSEl6VHVXZEFFNThWTDgyWE1CbkdQSGF5eE8xSEc5djZB?=
 =?utf-8?B?RWY3SkMzUVBMTk5oRVFiRXMwMk11OEordUFEcEN0djdMYUtoVkZhVTFoYzZw?=
 =?utf-8?Q?Am9pdENgAmFuFhSCAPeQZguRyLwy1dahYGh6IRaEPbMZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca7b5a-8107-4f8c-a5f8-08da9599b5cb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:07:44.2184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqIYNFLNCgzU0fnACBP/FW3zXRT8ez+Ne/ZtLBjOnpzmIZchbefdvIVJa6pOSz3hF8K+Smz69OhGhZ4bpYPZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I guess, but this is kind of implicit assumption which is not really 
documented and easily overlooked.
Anyway - for this code it's not directly relevant.

Andrey


On 2022-09-13 03:25, Christian König wrote:
> Am 13.09.22 um 04:00 schrieb Andrey Grodzovsky:
>>
>> [SNIP]
>>
>> You are right for scheduler mediated submissions (executing through 
>> drm_sched_backend_ops.run_job hook) , I am talking about direct 
>> submissions without gpu scheduler (using amdgpu_job_submit_direct)
>>
>> Andrey
>
> Direct submission is only used while initially testing the hardware, 
> during a GPU reset/recovery or for handling page faults with the SDMA.
>
> In other words when we know that we have exclusive access to the 
> hardware.
>
> Christian.
