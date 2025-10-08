Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F1ECAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E291110E11F;
	Wed,  8 Oct 2025 15:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yfELTZ+i";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871DD10E11F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE+KDtquwsLhLRfP7kHyXT7PX5GKJwBMaUnJX4N3eDCXkepl/Uak8xBh6kI+uaYIrI6hZuksPj31XHI0NQmzmvYaOwL9v1s4OVZfOSrrE/IXpqbmoI6ZGp61suQKkVB+tFKspw3swsRimJFbf+hJVAlomTCKM9XYoyxX6jIrdH4Spc799JBPPShpujYs0IGi17x306jXO8+i7OqA37NWsxCg8kSTQPh/SVtF9ifelMjS9xYdHPi8fw0CB4zhNftgfJFfN+/rzhC1m2YDGvEiKL6euX+nYA/GuK2r38AIRBFrpprdc8qGHhyONCCAiurRBEXUlWtgbyH9uXqNfY+BrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmwnNTYSuKnDiPCdbutHO/rzhPmz9X6zlNvaFACDUlk=;
 b=yv3LomOY/nYKFY1TM0IJOORqufDC9TlMdrZPEBYjovs+yfjtQgQI2/hLPd4vZxd1b6G7Cmtn/wwEF3qehMS/SxZBdHyKOyrBqF0/vPLorqc28207NK8ErEk1bBaR648gwK1TkBlxbAudmff9EMaBxoDDmyrGqJTzSFjLYosi4+ZYEY5vsg9AEejkDNDfnkG19nWp+iOjXXb4IYCIDOot7Qp52oIwax9i0zkUOMiGkkNXWaYbOLT3s+SZpZPZanp1a6aPJPfDDbo+CCBcoQkuJtxMK1iD6l/92opOP/3Z6lnr7pe8zt4abEnRjAYL8uJ7GVRBKSZ12jsgxVNsaRi49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmwnNTYSuKnDiPCdbutHO/rzhPmz9X6zlNvaFACDUlk=;
 b=yfELTZ+i5wA2T/NaPLj8HAPVBmXFaw1CfYZV6u15DXoqkLErhCm3cy/p/mCrTnt0qjqsDuGSSIQDUHaXAk7GA4TKF7eQkPJgOAJJY0NCzSNf73io4ALQSrCFNLS3nQKq/5kR5ubh33G1xEjsl0gcAfBSagy/zRrXHRKbx36FauM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 15:18:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 15:18:09 +0000
Message-ID: <86195183-4a29-497b-b6cc-5ab711633ebf@amd.com>
Date: Wed, 8 Oct 2025 10:17:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Improve suspend callback usage
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:806:6f::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0957ee62-5ba9-4c19-fda4-08de067de3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTNBVDNEVlY1cVNZTFNkWEpFNlBIV1BUTkVkWndtUUdpQnJhbWNKQ2xra0RR?=
 =?utf-8?B?RlBYaHo5TFJ2U0VVSWFkdjkzQ05vbHk2V0N0Y2MvcklCSk5SVEMwS243K05k?=
 =?utf-8?B?TjNoQU55TGpWR092ekQrK0U5UTEvOTNlNmNVOC9wNUZFbHN3MFZwL1lwMDRX?=
 =?utf-8?B?QzM1TllvNFc1MnJKL1h2WWFKTVNBVHVsbkZOM3dJSEJyUDYzRWVHYUFWWTRZ?=
 =?utf-8?B?VGszOXFNN2txQUFrQWNManN1dm9Vb0srMUVmeE5FWGVwM1N2d3NNRWFKb2dS?=
 =?utf-8?B?bytjMThwVUhBMElDOEk0dGVDOGNNdjJQNXZvYmFjTzMxc1VOOERDN1NSZWZX?=
 =?utf-8?B?RnEzNTBGS3A3aDl3K2FYQlI4UisxejE4emZOMUNQREpiaTZYZEN3czV5WXA5?=
 =?utf-8?B?UHFUdXYzc24rRENDM1FSOUNjb2UvV2xiSEFXVVdJMElWRFh0RXMrQjhBVlNT?=
 =?utf-8?B?SkR1bFhzSHhoMGIwSkV5ZW8xME1KTVdaYnVQbTZsRkdMWXBwQjNyVnZOTWxu?=
 =?utf-8?B?ZDdnS2dscm5ZZWdRZ21ZWnVpQzFqQys3V0t3MjRsSWZYVlowY2R3c05SVTkx?=
 =?utf-8?B?a05ScGdtMk4xSHladjRNSFdSWFNnZVFGQzhRRlRFbUs4MDdhbzBwUkozWlV3?=
 =?utf-8?B?dW8wakUvMHNyOUFIbFJNWC9PR2RrQkNCcS9paElubytsc1NxcVk2bmlnODZW?=
 =?utf-8?B?Vmw3aXQ2dVNjNGU5eGpZVTFrVUdKTjdhTCtVRGQ0dThUaEVwazh6b1hwcCs0?=
 =?utf-8?B?cTRURFZsMzBwbmp3S3BTcXRKTFJ2VTBzRFNkMmZKVGRROVg3Ui9VM1ZuUmJv?=
 =?utf-8?B?RThZQjJKQ1JkWUxDR0d3TTVwV2tMRmI3bVo5ektUV0lzZzdCRjZIUHpGNEg3?=
 =?utf-8?B?L2s1UFoyQ3YrOTN2SWxwOUNyYlc2U2grUThNRUI3NmpvYkk4bnBNUHgzeXNR?=
 =?utf-8?B?L00vK2xlR2JabElaQjY0dm1Tb01NYWRLemhYaDJhTUtveDZHNXhGVDN6QzVJ?=
 =?utf-8?B?QVpmeHZNb1J6V1EzNXlmN2QxN3dqYTRwdmM2eXB3RmNnWXo0K1ZlZ3NEcXk0?=
 =?utf-8?B?YVN3MXRsMWRxRHF0L0pvTTRndjRwQW1SUS9WYVE4SWlxblhZZWg0U2dBaHhu?=
 =?utf-8?B?YmhGc0pXbjBobXBMNW9QV1RwejEyMUpkblhPRndGaEZOTHI1M1N6ZzlScU5X?=
 =?utf-8?B?N3E2b2VMemVrSTlaRE1yVzF6WTVqUGl2S2IyQzc2NW41bGJyWW9SaEVSajRo?=
 =?utf-8?B?YVZlN3Rlc2pxaEFxZWN4c2lmOFpVMllYR3NtRWQrT1dnVUpFRzhXMzk3RVNo?=
 =?utf-8?B?RXhOTmZyMUh2ZnAwaWs3a3VWM0lOSjdIeTJQRTJMSElERWtONUE0aEczRnhH?=
 =?utf-8?B?bzFET2pBS0dkdnBzK09LUG9TUnNaNnBRenNvUVNuQitrOEovOFhQY3dFQ2R2?=
 =?utf-8?B?TVBZa1J6OTdYK1JqMlNTTStkeU5sY1hRajJOdThLaVR2cmczM05zZm5rS1Jh?=
 =?utf-8?B?YnYwVy9oKzVXUU5oQ3FjSWxQR0hKN3dWNldwdFN4c0RHNW03Sk00anJmelBN?=
 =?utf-8?B?dFV2NEZzdEhxbDNrak5yanV2Qk1lbG8ranNDTVJpMXFpbHFwakNDL1ZpTTJ2?=
 =?utf-8?B?Q2M4enRPUGR2ZnFXN0duU2FBSzk2Yk1VMGp0Nk1DeUtHNjJHVmhNMWFIREd3?=
 =?utf-8?B?NnNCVGovSzFlTWdFcWx6aG1QZnA2aDdqNzMwZWNWb0dGVitOTTRGU3ZFbTQv?=
 =?utf-8?B?dWE1K28xQW8waERCMjJheE83MmphMEFZNnFQeE5vZGE4MmpFL1VrQnh0T1VT?=
 =?utf-8?B?R1I3NytEYTY3VjdDOW9VVHFwZSthWkNEK0VGUVFHNUw3d1lndThQbjRqRnl5?=
 =?utf-8?B?RGdZUnJYR21FVXloQWYrL0xPU0c4RWU4UFVJOGJtaUxzQVZMMGtlanQ2YUJs?=
 =?utf-8?Q?nSusXXD706MYPxoO895+CCJ6z3f2P2io?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlQNWtJVnpKLzhNc0kzc3lxMklseWdLZ2g2V1M0cVNpNHI5QWZud1ZTRkdW?=
 =?utf-8?B?Vk9CY2VTeFFWMmpyaEcwOCt6SVA3QkNqbVVjSGhqb3o2SndWZ3JiUXlycm9O?=
 =?utf-8?B?aUpGN21qRGRtVm5Yc1dnVEpEMm0rVGlFQTZZZ3BIVm1Ka2dQQ0xSM0kwZzlr?=
 =?utf-8?B?QW0ybWM5NU5wMklwOGp4OEVFR3o4cjBiRVRZV2NFM3ovS2FPR2NENm1TcXl6?=
 =?utf-8?B?SW1STWg0ODcwZnJSQS80VDNMQTVjRkE1eUFEWWlxa2pqd0c5QTE2R3ZFU3Rr?=
 =?utf-8?B?cllaNDQycDQrazNmamJ5Tk5scExUa0JzRjNFd1h2Q2ZVbjY1cThjY0NNZWNx?=
 =?utf-8?B?YWZYeU5Ha3Y2SUVOV25rT1J6R3A4alRWbEJCb2Z2anVDK0tUTEtRNzJLRTNM?=
 =?utf-8?B?VzQxOWREbmkyZzJlM0h2b3g3RDVVeGlyWWFnQ0UyZ2Z4RDN2YjcyVHdGbHBW?=
 =?utf-8?B?b1F5TjBJd0wxejBGKzZBWjdIYWF6ZFI5NnVsSWRiWFMrQ1grcE0rYk5PZDZz?=
 =?utf-8?B?aFBKN2MrV3ljNWVOeS9iazg2RlJVRWErVzdyb2F0N2xnNEJJaWxZZGROejlG?=
 =?utf-8?B?dGpkWkRHSEpLTnJIODN1eXpnbllFOHVDMEt1VkxOYTgwd2c3cGJoRTlWcmhk?=
 =?utf-8?B?YmM5ZVhZaWVSNjNlaXV0YUVEc29NdG1VMkJhMEV2cnJJVUc2L3dvMVhNUVRQ?=
 =?utf-8?B?ZXhkcTB6TmpVNEZ1WHpTME05clkwM2d2T0hjV1VncWEvT2lPem1QZHBpUktu?=
 =?utf-8?B?N1ZoeWlocWEyVW5Va2U3aDJ5bmJ6QVdMUDdLcmc5dU9UU1l5WGZnLzJiWm01?=
 =?utf-8?B?N3QyMTZIdTdYbnYwamlpR1pFYytkbGYrandKdFFoN3BtVFZUVHI1TWJaeXVC?=
 =?utf-8?B?aTJFdFVWL3BuYVdpcVJPcUVRU0lTZjEweHBzeEw5T2dpV203Y1JFckFjNVZL?=
 =?utf-8?B?SDJZbVczMWZ5Z05OWmg0NzBUUHNkOXFqaGRnb3o5ZlhCL2FmZXVnR25EVXJw?=
 =?utf-8?B?L0FGOFhDSEVRWGxock94UVY3L3Q0MElUbU9uMU9lbkF2NVYrMUM3Um5zbEJj?=
 =?utf-8?B?dXFRTjU3TG5KMXhHaXgyM202SDFFMEZLbFlxWjBFUnRFQVN0amJLSG0vc0JB?=
 =?utf-8?B?ZmR6NHVDeHBCcVV0cVg5eitUVkhBNmMvWlJzZWl1eUoxNWZOVGlkMjkyRklu?=
 =?utf-8?B?dThXZ0dYZFlwSnA4SXBLSkJjQnI3Z215cjI2SjN6YTAvMmh2Wm1zMEZnVURB?=
 =?utf-8?B?WW9pbmZKdnRoWUc1QlhUdmM3Q1kxOVhaK0JmcUl5ZWRIZHozQXpKK1RWUjls?=
 =?utf-8?B?UHZKbzUvM1hSM2VTRHJLM2ZEM05lNWxVMWhLbFNtZnl0M0xBN2dqTVVRSnFw?=
 =?utf-8?B?R1k4bjRRRFk0c0VEbytVNFR0L2JkWlpQYUl2N2w3UDNoV25mWDh5N0ZWTTRT?=
 =?utf-8?B?UUVVVEpIOHIzUlJjQmE2dUJLWjJZeXV4ZS9pQ0Q3dnN0R0RjQUxvQWVoN01i?=
 =?utf-8?B?azZYSCtZRWx5NTgrVWRiclF5MDFJOGpTa20wc1FLbHI1N3hRLzdTb201Zmpp?=
 =?utf-8?B?ai9rYi9SdjErQmZyRTZOQVpLTmxxZy9UTjhqSWFKK21sdDYzeFJnT0pWVGQ5?=
 =?utf-8?B?K1JHWVVtYnVZU20zUVhFUERZc1UxdUlNSXlyMlBlaTRXMFBJenRvUTRaUUhC?=
 =?utf-8?B?MU1UNng1ZzcxSTZtaHZHU2xOZDVkMUtxQksyTUxnTmlnbW82bEVaQnZqdnBP?=
 =?utf-8?B?aUNwOWpvSmc3K0xmQWx4THZ1R2JMd1ExL3ZETUNFZWlSKzFRSVFEQWZRMEYr?=
 =?utf-8?B?MlVCcHRReUNsMmRybDNJREJnVy82M2VOcUx5OUkzbS9LTGExSTRlWDZyZTVq?=
 =?utf-8?B?dUg2ek5vSGp5RnBhM1cxM1o0T3FzQXN1NjFaVm5zUzlNYlBTZkN1RXV1dnc5?=
 =?utf-8?B?K0lVNUVjMjV2TndiTnRrVUZDQU9WcWhoSEZKcmloZWlZNFlwL1owYzNiVVJ2?=
 =?utf-8?B?bGhReXVLRFZmV0VWSTdvZHdCaE1MN0t2eityUEZLVm81VW1ta3ZMZkZUTENa?=
 =?utf-8?B?b24vK1o2QjJ3dlVkY3g4R096WnJ0WWY4OGtkVko0aXBjQk1ESWZSamtYZTFG?=
 =?utf-8?Q?OWOZGdnbiYYKVqdA1j7O7dls5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0957ee62-5ba9-4c19-fda4-08de067de3a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 15:18:09.5810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQXjAIn9l7WUCOL3vbNc7XjrqJ7v9YYnh++kWmQc2o/iWsLS6pMTizwsoxegwA77Gqj5svaipyGYso7t+R4Stw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

On 10/2/25 12:42 PM, Mario Limonciello wrote:
> The shutdown() callback doesn't use the same code as suspend()
> callbacks. This series unifies them and then also improves error
> handling for all suspend flows.
> 
> Mario Limonciello (7):
>    drm/amd: Unify shutdown() callback behavior
>    drm/amd: Stop exporting amdgpu_device_ip_suspend() outside
>      amdgpu_device
>    drm/amd: Remove comment about handling errors in
>      amdgpu_device_ip_suspend_phase1()
>    drm/amd: Don't always set IP block HW status to false
>    drm/amd: Pass IP suspend errors up to callers
>    drm/amd: Fix error handling with multiple userq IDRs
>    drm/amd: Pass userq suspend failures up to caller
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 25 ++++++++++------------
>   4 files changed, 25 insertions(+), 23 deletions(-)
> 

ping?
