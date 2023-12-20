Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C075AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 19:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B666710E601;
	Wed, 20 Dec 2023 19:54:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4983310E41F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 19:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpNbwgl3dCinaCkONgSSwWsCWuv1MDcLdgT6RHDGZWa5SNb2SaUfPd3GhbLUqzksk3GJiNXdcHFP6gsrC8HHGIZ27rxj8rdcItuD1L3Bbb3Gr9geBVIvfbeHxza6cnAnIhqLH8SJqXv9Qh4sftLoJGoOtTq9HWymmP6RflKNSC6++9ZD8qVJMzbmv0uyOVyjb9D2wmCi27QxQ8ysXFjJiQEqlsLwVVYOAFMK6uqklFYC1NfuMBdchOcsuS1vCZs4MrHJzc4dK+9pf5yCIroA+wKZoOg+YReIIhx7wKOUg1U3EKxEFscErdGf0tlvqv4KZu5pNpKcn4Fqz9+Gs3L2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZqJUjLlbi7xwdjOQ7z5R/tE6o8kvUCpDIfZW8sMmGc=;
 b=Zgnmw39/HH4nlRjkVy/BZsS1tOr1kYVeolR+sBHC2eEWQU5ZDGTfOSXwEu98NUI6IfeTDX52NCnO8Qx1jj6CJ9G5tu0Mi/Ke9fkXy0SEAStt5mB1zi/QaTUiASk3BEOD4okl97bz+LlQahlD/zLlQQw3tUggzSVuQoBABI73R5Jl/r/AO0k+qGz+izKUYfGBCQ89Lu9Pn60Mvcim2JZUcAHp9CyeE84WZ7Veq/8SOEzFHX6sRxfONapaZpW9Q7cAKEKaNjrWBxngsQULTgayY4MRGKTeTEe0MQBnGDSEv/76spsXwKkjw+M1LI2nEqW1jBnbDZdj+mK8BuTjiS7j7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZqJUjLlbi7xwdjOQ7z5R/tE6o8kvUCpDIfZW8sMmGc=;
 b=lifure+CYsQ4mA+RBdlib/S15z3HIFLzAsUVcxKgZrxDOLvSJBrtZBG0RROM6T0+2VuUp9w5t6ZMXgGl/p5Y2bDRPDbZAk1O58+vdrdHkGTMxhI2PsCO70UuiU0t4gsXm9Ac3auPNcQbGZn8ZgDacVLTIgQfcO4AUOYN0KB+c+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 19:54:05 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81%2]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 19:54:05 +0000
Message-ID: <e3e0e05e-cac0-4404-99b3-38eb170c3444@amd.com>
Date: Wed, 20 Dec 2023 12:54:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Disable IPS by default
To: amd-gfx@lists.freedesktop.org
References: <20231220193013.6897-1-Roman.Li@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231220193013.6897-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc7646e-9940-4a40-487b-08dc01956bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TfDLbx0JMrg24/yJXwGXGlHMkeg2Lkt0BM3sdFXg8SeH3HMtLGp7rUqiUm/imP6wRQD0bgLRjkMjwk/c+vFirmqIIcNGACBVONLaQwG9cQA4yjXHsir3tZrlKxaREul5d16uzUy/R3OZPxZ6nT2+Xia/eoHKDLTnbIe5IGy1ZPcl7Uev8cPqS9UXQSEnt1qj6lR/5iQKRYT5PCv875aLBI6mbBWGYfNeXNlWxXQz0Hp6vXCxTB8VFrZRo4YSy4eYHvkVjI4tnN66GddSz5GMGFzR9wdHAVoYeq2YywVDblWUDV904AG7ouAQ3SsJSRO4dsCUCQN/WeaKehy3ysx3DN+0TEWZsieF+eQffr8cTvEYj7E4OPrP7fE34SSrow7T7QglA8/L5FEIBjGmq41f1BEThBldSCFosiQOS1aXcp1PsSAID6ZevwuPbfJI3/bSB+A/nWsf8aNEsu2khVA0TEf4YFebGx1c/KaJwknySwBdE7DmLE2yAXX5gWuhbRN3TEO5dcRIDOo2d+77El0aiU0UvqBoA3HcS62T88JLP9KouMrxX0F9JTnjcfsuup8alkBGZbUdlPNAHI02FwmNvhxx/U50K0+Z1UoNqF3johLG+Ce3S7GZqM9t1m9EBshv/HnBNCY7tB8CNA6MlUC1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(86362001)(2906002)(6666004)(8936002)(66946007)(5660300002)(66556008)(31686004)(6916009)(316002)(66476007)(31696002)(38100700002)(478600001)(6486002)(41300700001)(53546011)(6512007)(36756003)(2616005)(26005)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJKZExYdHQ0ZFoxMzVhMHdQM2FZNGxCdjNlSUtNRTJkMDFyRGlSS1Q3Qmgv?=
 =?utf-8?B?YjNIblg2RUYxb1l4aElEbjJYUHNRNU5rcjZQNnFncEVYOHpMTytEZVh6Yngv?=
 =?utf-8?B?N21tS2ZHaCtCMGxWR0wvM2VWNFoyTFJQSzVyeWpYcGUvSkxVK3VGR1RyUndP?=
 =?utf-8?B?emZYbXd4ejZOclJNaUljbHFhQmJITGErdURoZWM4M2N3M1BzS2FGejJwUFZ4?=
 =?utf-8?B?RW5pUjhJS0w1QmFaK0IxUFNPV1BBOW5HUWZjZWFwNTFPK3h4eVlOSjVySnk2?=
 =?utf-8?B?NDlaNnV3TlpBN3dHK1V3WkVPMXZSZTlHN2ZDN202OWFPT2tSVUpxa01nUDU3?=
 =?utf-8?B?UGtDZXdqMVRRdlVlbzlFV1RaS0hSMzNLVXJ6TXIxVGg4TnFuSUFUa0NPdDdR?=
 =?utf-8?B?dVBsMVRUT1ZyR0dHN29IdXZDaGVUYjQ4RVNRczZ5ekJBOHBrQ1A1NkxzMVNT?=
 =?utf-8?B?QVYxSExldTNWZk4zSnVUNUtQNW1GenRMa1RwVGpCbjZ3Tnl2VzZGVUtvVE9E?=
 =?utf-8?B?L0xsL3N4UCtXY004bkM2aGU4OG0wYmhoZ29JOVloWXJMU1gwVnRhUXZleUd1?=
 =?utf-8?B?ckcyMjdUR09McHB5azNnbHRlT3JFbStUS3ArVjFpZnltajh1ZUl6MDYzdFJx?=
 =?utf-8?B?elp2Vm9sZVpkTHcyMlRGSkZWb0IwOXdyeWhGb1Y1YTYxSFBaV2d2WXhkeTk3?=
 =?utf-8?B?bUNmMXRJUnhmR2dzYTFsK3psOUR4VDJBM2JOWnIyQnJja0hMNWhzME05OXE3?=
 =?utf-8?B?Wm9IVzArUHJqUWlmbHRoaU1kcWR5YnhpK0UwN3oyR1hkR0lGV1NQeXdHazJR?=
 =?utf-8?B?ZEVBeE5sQ2p4ZWcwdWg1TjVXaDU5czFZUitGOHJENUxEUXdhNzc2VjBMM1hu?=
 =?utf-8?B?VFh0bjhQM2d0U0N2c0tZTEpyVFJLUncvR2M4MHIvUWhpUlgzbVV6K0JhM20y?=
 =?utf-8?B?RHVFU2haeGVQU3JKTGJLUndXRHNGVFp0T3NYYWtaczdtNTY5U2toRnRXOVFC?=
 =?utf-8?B?M3JnT0ZCNmcxZzErbzBPSTRDRUdhcno2Zm1nNk9EUkk3TlNBS21rTGxjK3Y5?=
 =?utf-8?B?cU45aGsvQUxyK1VmcHgxd0xRK0E1ZzhSd3RjcnRrd1F6RUEyVGYxK25pZ3Yr?=
 =?utf-8?B?QlIvVUo1MWNXcTZkRUhoTG53cW0vMldvbEZ4Qml1dVZHcjFKMG9ySjlHMFFZ?=
 =?utf-8?B?cWZSdDZWc2g3U1V5R3AycnZUbmt5M3p5OXMxeHdtb01jRUVKQ2QzbGo4U092?=
 =?utf-8?B?dW5ldHZqbGhqeUx6K1VnS2FINnQ4Y3AvRGFCVVRnbHdWLzY4YXNGT3crMmx6?=
 =?utf-8?B?S2N1SGY0WHdBSTBSTzIzUWF2K3E3V0VRWmcvY0dQY2RPWGlpN3h6azB5ZmhZ?=
 =?utf-8?B?RVkzUjN5Wmh0YjNIT0ZIOXByV0t1K1gzS1dGaDBmaXhSK1dtN3RtMzlZcTIy?=
 =?utf-8?B?aEo4eUtrRWNPR1krYVRqeFJhUDlHbHJVYjZBeFBETHZVRG9KT1JOU0NDbVdD?=
 =?utf-8?B?d1l1RUxjQk1VNlFQeGsxWWdOTGd4ZGNrS3NwQU05NFhqRUhHSjVETWZ5M0hu?=
 =?utf-8?B?R3lHcWVzNEZVM1VJNHM4Q05Oa0RkUkluMjVGTmtvRGt5aTVqdVNlYllYdDk2?=
 =?utf-8?B?UWhEVjY0ZHcrM2UrZFpwUGkwVTZvTWNvVlNQNWMwUWRxakJEelpXc1VnMzVo?=
 =?utf-8?B?YXRmYWlnZ3lkMTB6ZHZFbnJQWitYQ21QNTRudGtxK2JVdVZhQ0RVTnIxS0tq?=
 =?utf-8?B?OXVtU3BsVTY2aDI3Nm1DMnRGTTJYQ2daTFFBNDlFMFNxdTRNRXBmV21BV1gr?=
 =?utf-8?B?SUdibEp6aktjMzBoTWNJeUlJQU9zV3pYKzNWemJFNTh6RGRtNXYyRkhyNlBV?=
 =?utf-8?B?S2JIdUN6amhXbXZFRnZoY2VKNWJMbW81R2hOVGdnTUY3L0VoYXIyZUdWbGIy?=
 =?utf-8?B?Z3NWZWpEN3QyNFR2T2FkelZwTmUwN3Rxalk1T2dlekI4Vjl4YlNhMnkzcFFL?=
 =?utf-8?B?TmFvVXJ4UHhjRXlNK3NHQU1JTytNSVdLOHp5TmppcW82NkZtZHdrbDBkMkYy?=
 =?utf-8?B?TFpEUHVJNXNxZ1lVOEtDUDhoTElqcTVHcFp6cGxlUTZBejgrRTNoRS9ybmdv?=
 =?utf-8?Q?9yp8bfsDpXJ9v1TeZOxrtNvW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc7646e-9940-4a40-487b-08dc01956bbf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 19:54:05.1109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meIFlAi2Gn1l553oAG+FsXNzGKgdH67TIXgsOEeUu8K+OE9Qonixdn1dvj6ixqWTbrHKBMKaLc7xs3q6IWmpcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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



On 12/20/23 12:30, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> Instability is observed on DCN35 if idle power optimization is enabled.
> 
> [How]
> Disable IPS until issue is resolved.
> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2845c884398e..2cabe1b463bc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1710,6 +1710,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
>   	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
>   
> +	init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
> +
>   	/* Enable DWB for tested platforms only */
>   	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
>   		init_data.num_virtual_links = 1;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
