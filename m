Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EEAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085A110E315;
	Tue, 30 Apr 2024 13:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqofupWS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD9210E315
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvfEgO9VDKYLxi5Kj2DUKQQOwXJwm15Y/qiGV3y2AStCfPw4hHswEyF3XVS9mti+SRTY0FggwliRbqWnH9NJgVKPR3WSHKnXSaoffR1MZaizot/ClmFghTvqNIe6feenjxjxgBAY0nF4I9NxrsfPf47FS0FG0ZsETC4ocZ03M9eiMDip3MW9LEA+hUbXVLWPsQxALO2pB7hM6VI8JoqTPs7oOQTYImYcjQlzJFgcMhyswkBC0+wh014FcFH2f3rPO+Kas13/No84+TQUNLv+j/BAKJpfLLvXSuUQobx5I7yB9BnuR92AQdg+A5f4VJSFjzFusj+FFQkd4d/BqyuLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xqouyVJE91jjdC78jb0dVSoxth7KjC1Zfbuln66jgc=;
 b=DaMzCWDbTHQ1EWudC+migdzX1IMUdBrDElVxmwFCO78qvjLfT4yZ16XkNHBaDfg8NylP/hAqTZf8+PrbUJIifksy2VIX3uVu0qWsIKKR9XiA5nc7yloIA7j/yoUUq860dhN8m3D6Kuz94PwtPRYz+EV99505HUzrnTNlXPlQw3rWGuDr5MqR2DeDogo3FyPHn5xbMuv9K8xcDgvOj0JBybeTL2dKj7vFA0ZehJ1pedHijy0zLEkPYlmARFAgS1N7pCH2oUzSHqhyLYpq0yI2HSjoSQ+GWmYBL/A3BX5KyGxk8cvx/MIl3pKp8q4cVbHeMlJd0NxkyUVccn8/GLlNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xqouyVJE91jjdC78jb0dVSoxth7KjC1Zfbuln66jgc=;
 b=VqofupWSDKUGXFHrEIsbyTOn0Gfj0waNd4u104of+oW5Jn8/MhTQKoaL1jHJK5wBBNvpeCNpZoMZAZQp5dJug/ModT2H0V2boVP7PzKWt/tLq3BVgk0G3WbhFXPR6uCVuP/wKJ2Mmqx5Y1npzWf/0JnaofQFrX1yXvVEFmNKbc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:57:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 13:57:55 +0000
Message-ID: <92fd7bdb-2ef0-4b92-a117-146e2ae86f7e@amd.com>
Date: Tue, 30 Apr 2024 15:57:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdxcp: Use unique name for partition dev
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, james.zhu@amd.com
References: <20240430113620.322882-1-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240430113620.322882-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 199e116a-daeb-4d46-1f9f-08dc691d88b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0Z0Z25lSWVlM0tGQ09UVERENUYvSjlmakprR2piWndmcVV1M241NlVDalZR?=
 =?utf-8?B?YVExelBBVDlZT1owSy9QU3A5U3JSRWhiZk9GeXd2Q05FM29lU0hkOE40c2tO?=
 =?utf-8?B?TU5abnlGVzkzaE9DQjl5UmlhNXYyVXNuckgwVzF3WitZLzBSMlFMNVpEaHVL?=
 =?utf-8?B?OFgvY0N2Nklac0VEcVVzQzFONXVrWnp6ak1OeFVDeGU3MFloc3U0eWxiU29E?=
 =?utf-8?B?TnpDVGREQnJRZVFDdEd5aGdlSFUvaklua1BjZlIyMVlsemJXS1NQSUo4YzlZ?=
 =?utf-8?B?R0laV2xwRDRDQ2VDTUhHOTRVemF2aWJaUENYM2FTRFg3TTNRS3hqbnJnNEVa?=
 =?utf-8?B?aWtNQzFOYXB5cW81d2twQTNtT1NxcEF1NzQ1dHlMRmFvUVlzRjdkR0xzeTU5?=
 =?utf-8?B?aG5zckdreVY4SUtZTy9qdVNuOEdhTGxKZkxPR0QrazJKc0tyUVpGUittVGVT?=
 =?utf-8?B?a29YMDRUZFNlUDdQa1N5SXF5QXE1aXE2ZlVHblZmQXRQaEwxdHVGSGRjYUJM?=
 =?utf-8?B?M25rQWtDNU9GZy9EaUZqMHJWa0dBeEJRdmNPa3pBbkF5bHMxUkh0Y0E5TEt4?=
 =?utf-8?B?OWNyaWtJZzdFbTNJNjVRR3BnU2FFcEhhWGRkWk8xOTlLclp3ejBHMm5LU29X?=
 =?utf-8?B?WUcxRFE5Qmh1M0FtVE5icElSamhkbHlqY0hxMFdGWmkzUGh0TVo4SUx1QS9q?=
 =?utf-8?B?R21pbEgyR0xOS20vcXJvUEZIekRIR0o3S0FxMkdoWXlWWlQwdFZ0ekxJYTVa?=
 =?utf-8?B?eFh0dnZLeEJOUFBSOHJhSGZCV0FYOEVoN0JSU2twY3l0NTFWVThCWCtUQVM5?=
 =?utf-8?B?eTJla3ZXbW9kaUxncVhybThyVGwyQS9WcytzS0dSVCtkc0xDazBVTmc4UWdt?=
 =?utf-8?B?c0s5bXI3TmppMlFSaDladFdSRDVvY3hFamc5MW0vNXlqa1RjMEczVHRHeURu?=
 =?utf-8?B?ZkVVdDdVUllDUC83Wm1nbnNULzl2Ri9kZmpXRS91R1lRVEE1OU1oaTMyWkxP?=
 =?utf-8?B?SEpQRXhOaFpCdmFQTENvalZLbHRlb1gzcnNNZFRKM2Vyc2NQR0IrNzJTbDZp?=
 =?utf-8?B?WG9Tdk5IUTRTVnRyd0l1TnBCdVNaaEkvQi83M2lBZ3IwM3ZUUkd2dTl1T1Rz?=
 =?utf-8?B?N0orQmdLbTZESE5LKytwTXdBeS9RMEQ0elhPb3lDckdLaStZbHlEcjRiZEFM?=
 =?utf-8?B?U3lyVGQ2MTVyaGkzVFBDK3VMUUxIbE5LdVhmWDJ3M3FJR0NxZEZUL2doWGdh?=
 =?utf-8?B?M04vOHBsV0JHVGN4L21aa3p0TTdMdHlXYU90MkpqWEo4ZXpqcE85SXZQS2Rv?=
 =?utf-8?B?eVZTcXR5bXZlTjc2cUdiazlvOHN6c1BQSGFkeUV4bG9Ob0g4dEFMc3JBbDZM?=
 =?utf-8?B?dGl6VktCbWNUaFl3bWxCTjV4Tmt6eWhVRytrRk1FVUh2bUV5Y3hKUVdjdnBE?=
 =?utf-8?B?YzdVWnJpaTFYM0FvT1NRcE5IODYrZHpLYTlwZElRZTBQU2xQa1B3ZmNKeDJB?=
 =?utf-8?B?YzlQdmh1ZnFPYTJ5cm11dXRBVkVwY0tCYnAvZURCTUhtZzBEV24vTjdOR2J3?=
 =?utf-8?B?TDNscG93dnZPelJUcVF6bXdYc1FTejA3L2JEK1l0WE5PQ3A5VUI4KzIrYU9R?=
 =?utf-8?B?VVoxbGhQaHpkblo1U0pVLzBPZnBnVFNvZ0xlUU1Pa096Ny9Bb2Q2aUl6L25B?=
 =?utf-8?B?ZFdiaWFGK0wrODZYVWRHTE9XSVJTVTVXRFoveDV4SHEzSUZFM0l1dExRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNNcGhWeFNSVk84QnRtZzl4Q0haSjFJUmFNcEVwd29qMXlJMjFtSHI0R0E3?=
 =?utf-8?B?OTI0OGtJcy9RNTUvQVVlOUh2Wmc1cmFpemhiMVQ1LzV4S0FRd1JmZ3VKOWFH?=
 =?utf-8?B?NFJVYTI5SjgyeDFXb3UrRmoxeW9vRi9hRnNJcWdmWXQ5Vk11S1dhakhOdXBu?=
 =?utf-8?B?K003ZEJlRVF6amdzS01TWUR3SVI3VHJSOUZmbnRUR0dTNUJMWXlIUnlmejFE?=
 =?utf-8?B?NG52YWxaMXFxM1NwTFVPS09EK21pNFc4djMwOWVoakQ4YnJvZnA3TEFVc3ht?=
 =?utf-8?B?czlZYm9QWEJLTG15OFIrNm1BRjBmT2NKMi9oNUkrWWxWekZpaXFBZDhEQkZm?=
 =?utf-8?B?YjZZaWEzcGRqMlhoM290VWtSSklOSzRDQ04rVW1FWXltb0d0aGxoWFdXTFRE?=
 =?utf-8?B?WGlPZ2RFYjgyQVRBVjN0dk92N2NKckllOE03anNWamlzczFpclVubDdjbUdO?=
 =?utf-8?B?eWhkT0J4YmhEQ2FqZ0IvYlNrUVVsWmtTc0VUdWdsdnM3dmxSZlpuRENFNitQ?=
 =?utf-8?B?K0plOGhlNmFoOUZTcXhZNE1Wc1FvekN0T0tPRUdrYXZDVDVoNllJZ1VtYUh0?=
 =?utf-8?B?TVQ2d0FCSHliY0tzQWRWNmVZZTNpd3EzbjhteTRwcXlIL1RWYkYzT1ludEtP?=
 =?utf-8?B?cVVxWG9qeFpxZGFPaERlQlJmUmxnaktNejVKV2RJS3ZkcXA3WmNubE1ackpH?=
 =?utf-8?B?dWxoTWllc05XL0phbU9VRzZlVWp3alJJdFI0bkc5bmRadFUyK1ZSK1A5M2RX?=
 =?utf-8?B?UTRjUGIwUUt6ZUxQd3dQUlB5ak55S0ZDRUxBQzZpd1FnaWtqYjZvcDg5c24x?=
 =?utf-8?B?dElaSHM5dy9rdGhNMDljeG1UdUNVSmFwVmxWKzhxZEpNUTh3OHRrbm5PV0Nn?=
 =?utf-8?B?aXVrMzErb21QOC94UVF0YTlxKzBVdG5PNGxJRm80Z2tBcWtmbWdZb29lY0g0?=
 =?utf-8?B?NUw1TkFITVBLazZhVmV5WWxqZWozTDhPaE5WS203MXBWRzNuS0dURG1vT1dU?=
 =?utf-8?B?cEphZHlIQ0pzc2NSNy9sWktXY1czbXUxTS8zdTdueHhLTlkvOEpkQnRpaDhN?=
 =?utf-8?B?M3E3TlpHYTV5anIraU1BS1Q4T25LZkJNOWg5OUp6bmJXY3ZCakNRaGdpMnVV?=
 =?utf-8?B?TTVuMVQwTUNaam02NUtmSk0yRDM5RkJLY1Byemc3MXNlSDlyTmNpbE5lOFV2?=
 =?utf-8?B?dGVkMlRKMVpIU3FaVHpGZmdiQnBlckhpdkI2OVpwTDVpZkZmbWxSRkZvcitZ?=
 =?utf-8?B?emh3YTY2T3FHZ0RIeEFLSWpHeElUcWZWeHQ4QlRUZDd6QVJ4Z1hJZlord0l5?=
 =?utf-8?B?R1QrLzFiSGhCZHp4ZktiaFRpa2E2R091NndEdGJYNkhzUTlNWUZWRnZYNHVG?=
 =?utf-8?B?b3pMa2FaOU81NjdZMnVWbVJqdE9LQ3c2MDJNcjl4dmY2RWxtMmlqODNKVDFD?=
 =?utf-8?B?UkIxU3A4VkpDeGErOGJwQ0poVkdTdnJvNVRWWkIvbHl0SEVVTE1HZ2VLQmEv?=
 =?utf-8?B?L2V2VExSUWdDaEJuMkZkZDJMZk5DVXJ3NS9xV1d0OFdacHlYVnNJNnBJTXlj?=
 =?utf-8?B?MUxGd2VDQVBTSjZPNGxxejNXR3JraHZzbW12UUZZRnFUeUpGd29hUWNvT3M0?=
 =?utf-8?B?MU5XZjlzT0Z3SjJlNXJCd0tsVzY0Unp1dmJ0SThtZ290RVFXdDNYRmdVUWpY?=
 =?utf-8?B?YnZXSXQ2V1BiM1BaelVvOTdBSEo1L3c1eC8xSjE0OU9nVlEzSjQyWjBrbzRQ?=
 =?utf-8?B?VDJqc1R3RVlKckIvdzVJREZOTzZuZGhvNnA0L1FxN2taZC9GN21OL1BOeUlJ?=
 =?utf-8?B?dVZzdU1HSnYwTlhlNG0ybWF2ZHlkaWtCSnVpckFMSDJWZDJRY1VSY0ltWDVC?=
 =?utf-8?B?czJma1ROQit1eUoraVd0SytDYVJuekZ0c1F3RkJrL29xOFRDclF0bUg0QmZK?=
 =?utf-8?B?YTRKcFkzSk1JRzd0SXY1OHA1VDl1dzBySVpmNG5yTHp4c2ovcncyTVMvSHdL?=
 =?utf-8?B?eGFCcTA4T1p1YkF3V1ZxSDhpTmtOVkhEdFd1dXNEUE43MmQ2SnBIc3ROcmxG?=
 =?utf-8?B?dGFuMk5VMEtWV0I5bkJ4WTRXRVp1QlNZZStrUVhjeERlRnJJdERtMUgyajlS?=
 =?utf-8?Q?dc/9bEV8Dc/hMHvPBYjdTrHEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199e116a-daeb-4d46-1f9f-08dc691d88b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:57:55.0870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkCs4yOjL4QRt/Ygz9JjCXOPeOxKI+iSc8rwcoaJk+uZBetG0HoickPpI4x8GrJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

Am 30.04.24 um 13:36 schrieb Lijo Lazar:
> amdxcp is a platform driver for creating partition devices. libdrm
> library identifies a platform device based on 'OF_FULLNAME' or
> 'MODALIAS'. If two or more devices have the same platform name, drm
> library only picks the first device. Platform driver core uses name of
> the device to populate 'MODALIAS'. When 'amdxcp' is used as the base
> name, only first partition device gets identified. Assign unique name so
> that drm library identifies partition devices separately.
>
> amdxcp doesn't support probe of partitions, it doesn't bother about
> modaliases.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index 90ddd8371176..b4131053b31b 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -50,12 +50,14 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>   {
>   	struct platform_device *pdev;
>   	struct xcp_device *pxcp_dev;
> +	char dev_name[20];
>   	int ret;
>   
>   	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>   		return -ENODEV;
>   
> -	pdev = platform_device_register_simple("amdgpu_xcp", pdev_num, NULL, 0);
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>   	if (IS_ERR(pdev))
>   		return PTR_ERR(pdev);
>   

