Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF89C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 10:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859FB11A35A;
	Thu, 25 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ikTJP93T";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18F111A35A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 10:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzV2ZJxcpXDZrMybZ+xIxwWHDtC18EgcFg5b1kK4K5VbUgknyNLERCviPUjw/lqJlqEHDQDlXwZY+U+juad2f/Ycieav2NRxab7RD3sh4Bs9tj8HMUl/1N1RtOihnMxPfm1ktFW0ss3kRjjEMVRLlrUJRCG5VroE8OGuCJ8CIGJ0tEh066xMZVtykB/19hcJBVeqIReB3Ib+qY5TbyOCa22R4dCUVZ7MzRuYt1srjWjTHohbH5/yoHtSP5kL0w4gQqdi5xmsJNY9Y4xVKKupnk5e5e+WFYH+1yvz+MKK7oLtPHen92cIyWsuSH3G6t2o31bPhVJGSMPa7iOscQNfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R59ZO8Jr3Rs9i5c4Voz4ERqu1tKnH6u34Q4rD3MbXmc=;
 b=MsIX8MWdX4OQhiu4cPIGSWLRtO9D1v6Fpmjz7IAaBIwBECuj8DpTqWnBGJVxFcGUZDULYup0ScoLqPOkt2pJD5XvHkhJrRH5pnDUh+fXW73umdq3uMJm6DWN3U4VihwjyoPoohJb1AOK5kNWU3qwPThqpQhXrDSqU7V0ocwfokZuiT9/bR5SqkfTXPFCBX9/ZhjaZxeBfZe2C7UOjXdUhoHzlOI3v+zpSI8/8ElCX4aSyqGWGYmIQXAsxZcgEvg9R+VzaMAXNYh5bA8ShelO7egNnTfmDxV5QVd0SnZYnIqKAQTMODzw4Pu46f1eSTmnG9lSDSoA9v7LQMMLnZdiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R59ZO8Jr3Rs9i5c4Voz4ERqu1tKnH6u34Q4rD3MbXmc=;
 b=ikTJP93TFpClRdR8LpNwgeWw4rm+u0PnyPLOieP0R3ixU6SVrqDaXUsBnAssTvqb4y3lzqd9Mv4KuEU1KFKl8rrpkM4c+LIKbEhYgjcDmRwDCP62fAV6lgH3G8XT6JmHppLYQ9pTbSaWmHNiDNzBaZfLmAZI6FQyWwzKjSeTjDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 10:10:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 10:10:25 +0000
Message-ID: <c9813334-3ec0-4095-930f-e4ecea3125b0@amd.com>
Date: Thu, 25 Apr 2024 15:40:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Fix the uninitialized variable warning
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
 <20240425100027.637016-3-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240425100027.637016-3-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b029c92-3113-4194-1030-08dc650fec96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWdIbkZkRWhFWGlraUtZRnFUTjRUQjhVd2ZER2dlVC9MYlhhT05qeWxQUnpU?=
 =?utf-8?B?OXBSSlBmRHVmczJpbUc4S1BPQjNHMmx0UEZZOGhyN1djaVVQOTg2L2J5clo1?=
 =?utf-8?B?a2J3cDRWK0h1elJ1ODZQaGNUQ0tuMVpXdkFPZXlMZE5oZlZuOHhGaGFoa0xU?=
 =?utf-8?B?bktwUVdQRzlFWCtpNmZ3b2FkT2tXWTdsY043QU50TGkyY1pZNllYVXIzTGlZ?=
 =?utf-8?B?QUZSWnVlTWZ5SUhVRytOVEd1SUNFWXFad2tKbFJFT3BTdDhwVE1zcDhsYzVT?=
 =?utf-8?B?aXQ5bEtkVFdsWFZ1ZzB4MFVhT0pieGVtMUpFSnlZNit0aHFBZkI2T1VYZ2Nj?=
 =?utf-8?B?VWJqTTluM3BQVWQwR2tKYVhnL0gwVi9oelBjMi9XeE5jTUkxMCtuci80VUxq?=
 =?utf-8?B?STlwVVg0TjRaSE4wQk9oM29uN3VZYnNWWk83dXplN2ZJaHJvL01id2QyWU1t?=
 =?utf-8?B?aXhjb0dWZHdUWlQ3VHg1aE1nNTEwcnBveGJ3QXdpSWVSS081NXFPbldlQUQr?=
 =?utf-8?B?VUV5dmM1OENmdDRyMmJFRFhNR2pOeWRoMWp1UnB3d3BmVHNnV0J6QUwvVDZj?=
 =?utf-8?B?ZDNrU29sQmFxZS8rYWZQVFFoOHJUWGJ1aVpxYnBHd1p3UTFUYW9Ub09YaDRU?=
 =?utf-8?B?U1NBSks3NVlVMHFhSGlOUUIyQ0FHZGxDbG5sNFIxZ3FUNHFmeExxcDdRMjFT?=
 =?utf-8?B?U2JNTVpIQmFaWHI1UFVrR1RraTNBbWhvU0RLbVE4QmtmWkoyVlowZlJ1WUVo?=
 =?utf-8?B?Z0dJL25vd2tLZHgrUGZUMGhPbWpsaFhubGtxRk41OE5vOEFWbG1saDI5VWpw?=
 =?utf-8?B?OVdtZGRHYU5OT3V3cU9QWHNhd0lhUG5MdWI1WEJVdnFjOGw0b3J4M3NTdW9t?=
 =?utf-8?B?ZXV5UldyVm1UOTBIcDZ4dXdHYTlhZ0dVOVhPY2FmV2NHcnNMT1Iza1RNQ3c5?=
 =?utf-8?B?WHBNMndhb2hVOG5RcjhGLzgydEswNncrTHhzYnF0cGo3VElldWc5Z0VpRDRF?=
 =?utf-8?B?by9uOG4yNmQxNVdzb3VJcVg4ODdBeVN1VGdJcXBQSEY4a1M3K3Q4RkZKY2xh?=
 =?utf-8?B?c1lVMVpUbkFTOHVYUFlXQkZlN0Z5ZU9IZjRra3pvY2tsRUxYVHBWak1VemFa?=
 =?utf-8?B?djkrRHMveWg3QkdTM0plL2JQWXZTdDRSOFdyOHoyYWRQRjFnS093M1BQc2hq?=
 =?utf-8?B?bHZUdWlsTUY0SkJ6WWVsTEVsKzNMSXhQZEJZeTFsZFgwZnBTYnozN1c2WTM4?=
 =?utf-8?B?ak1rM0ZXM2NIbFN0eVpzUjhzdGhtRmZyRkgxVjZ1ZEM3RVVMQmhWdEtrdkNw?=
 =?utf-8?B?dFREMFdjTlM0YThwd3Exd3VTNE1RUWkxWHJQZjNwM3JaRHdOQWRuaHdlaXlK?=
 =?utf-8?B?MU9BTzAwclQyVVF1eGJsZVBNMlJpcklHOFhoVzlyRlZwOHlVQnE0Z21STTBk?=
 =?utf-8?B?ZkhXa1Z3cFlMa01lZTVYWFp6WitBS05LVmxKYjBJVjlFV1JFVEh4elRjQ0N4?=
 =?utf-8?B?L2lBVll3Qm1yWHdmd3VObzFuaENhYlFWaDdudnpkQjE2Qm4rMVVRZHVCWi9U?=
 =?utf-8?B?ZjZNNk1SbzVRdGI5SWs0TGdiTEs1K0J6TzFIMlhjWGtWVzI0NDI3elBoWlZG?=
 =?utf-8?B?eW1oaUMxZ2VqSVRCZVlqTHRydEFRL3NuUkhIL1JvMjBjSkpacXlFNVNGR21Z?=
 =?utf-8?B?TkFtVGdaWXlxcm9Hb2pvRkV5OFg4WWsxTngvTGkvM3ZJdUluS3VMQnNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9nSTQwZ0ZHT01mTzdqMWZIMUNnVWpUakJUN3ZON0FSaTZ6ZldnaFdheXlV?=
 =?utf-8?B?U285RHo2aUxiVkJ2YTVxWE5SNzd0M0ROVFFRSDhFVXpCL2hXK3hDNER0aCs1?=
 =?utf-8?B?RjQzN1pLUm5haFZTM0tGYi9qL1Q3eU9jMU83ZjdCTnd1akZWays4c0QwL0tY?=
 =?utf-8?B?ZU9vN1lrZnorbStNbC9aZk80RFIwZnlRZXU3ekR5Y1EzeHh2Mzk0anoyNjY0?=
 =?utf-8?B?KzZobnVFODlOcDdBWWNMZkdQVnYybDdRWUlpTEJGY1ZmMDY4blB1UElXTmZU?=
 =?utf-8?B?eWx6N0ZjYWwyRk9raVN4bWVaWWw1Q041TExlTTB2TE1RS2ZDRXhWRmY2WmxU?=
 =?utf-8?B?N0VjZnpPNW9BRTZBditZY3Y4cUNRVmF4Z1VvUGpveC9acVdrbnFyQzIzS2dQ?=
 =?utf-8?B?MFRzQkxNR0dtOHlSTGF2Rnk1LzdkSTc1em5hNHNIOURpbWN6WHFmeCszbWJu?=
 =?utf-8?B?c1MwRnRlYkFoQzFZTDFRYk9ndHp5aDhDazI3c2Q2SGxoS2xEc1JETlRFOCtt?=
 =?utf-8?B?U2VpR0hPcThOVFpDQzRxQ1k3aUJ4MFZNRG1BYjBBQjUxREh4emNQOXVtNTlv?=
 =?utf-8?B?bHVmdUdzQVBGQ3RJMzhQaDZZTWhvRWdEZkVEK2FBSHNkOW9qRXRkWDFNRW11?=
 =?utf-8?B?WHkvZXRxeXJBZXNINW11YVMrTGc4ODZMSzZ1RHNLdjBybm84cG9GZ1FXN29S?=
 =?utf-8?B?Z1dWRUNuR1g3dmFvd21BUlN0dVd1cmxYdlc0S0JuVVVwUUxoVVd3SUtMRzZm?=
 =?utf-8?B?V1J2Mjh5SllEV2N4N0c2TDlBeC9KTE5LeWhLdTB5UmVFYkljMlZpdithUSsy?=
 =?utf-8?B?cFRiMTNVdEZQS21SaU5TcE5ZUk5kenpzYlpqU1d3cTk2S0RhNGpVdFpxK2hp?=
 =?utf-8?B?cUxMUUdWVXdDOUJxdFp5aXZsZGgrb1BaOWIxZnFkdllNcVR0bjlZV0M3SmhN?=
 =?utf-8?B?bFlnSkdMd0RRRG1NMTlTZHRTY1FsY1dhcUJUSEdqOFVMZGFEb2JNRTBhUVVZ?=
 =?utf-8?B?djJxRzd5YUlsc2svdk9Lb2R2MUgzWmRSYlY5RkgrWHpIblloYXJ6TXpSc1Nh?=
 =?utf-8?B?RFZuZWVKUmtCYkc4SGUrKzh5RWJ3R25SOWJqRHQxQmRENmUzT2pIZEFET2tY?=
 =?utf-8?B?L0QxVjhiK0o3RW9LY1ZQRUU5NldTUjV1NVdXbTVuNTZEa2EyakxnRDFDNkk1?=
 =?utf-8?B?dTlpbWZYNnVYOVJGbURQR2FEcEZGVmRHZWVlNG92ejU3ZWxUTHZTRVl2QWta?=
 =?utf-8?B?Nkt4NmV6M1NNamhad3hmb0lJSEpTSlpud3Z2dFRUbFlFTWV1b3hPY09xREhO?=
 =?utf-8?B?S1hEb01VNmliUXplT285Q3NVekhETjZYaWZUdUFVY0NpVm1xVGo1L1NUeHJa?=
 =?utf-8?B?bW5nVjhTSXloWjBHYkdQbzQwZTgraHFaZ3JZTjZsZFMrYWF1ZTRiUWhsNDdv?=
 =?utf-8?B?U1VCL2lQNFU3MXN5enJoYkJXcnQ2MUMyM2dxL282eWtWYmx0M0V4RVNEUmJI?=
 =?utf-8?B?cngzQVV0RnN0STZnejJ3L2tZYXJEN2xUT05oQ3VqRkxQY1NyTWlKZ3BEQkdh?=
 =?utf-8?B?YWJWS0Vqa2o5QW80bDBKczg3WC9FTzMzQXVzQWtXdnpHYW5QYy9GVGhpWGNT?=
 =?utf-8?B?UmsrRkNISDBLMXF4UE4vWDl0ODBWMHBZellpRGd2RGFMbmd3S2lKRDlMdHhh?=
 =?utf-8?B?czZGOGMwR2R5U0xjTlh1bURvOEdQZzNsa0E2OGlBaFRSQlJ5aVd2b29oS2k3?=
 =?utf-8?B?aWZOc24vT0NjdnNlQTRYSitVZExTRzd4ZkV0M2ZpVFVsUTRIR1ZJdmF4bGpT?=
 =?utf-8?B?UmREeEZOODc4akVpdjB5WXRwNFdlaXowWHZWRnF1M3RyeWlzV3VRVWpMUGpK?=
 =?utf-8?B?QWMzRk5xbGZSZmZWbVA5Sldrck1nNTJjMkRDblAwNDhwV0JDWUxiNzM1WnlF?=
 =?utf-8?B?d1dWUmpzaWtZV0JtSENyYTgxTXI3TmczdVZHSmZ0WVViUmRLY2JVQXBzNDRV?=
 =?utf-8?B?c29LQ1ByWW5qQlA1V2ZRbk8vNEhKMHdSb3pwai9pbUpmWVVjWnNubmNwcC82?=
 =?utf-8?B?SnRsZElsK29KQUhMSUVjM1RlUGQyeDMwUDJQY1pOeXlwakIrRGRFa01la28x?=
 =?utf-8?Q?sbaHttwSu99dhzQBlg2ZUt2A+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b029c92-3113-4194-1030-08dc650fec96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:10:25.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRN4/sOhaxPyIOHSafZTxynXr578Lt9wHhRPpNdv2vXArchzK3EVM7jjKVsaAL0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
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



On 4/25/2024 3:30 PM, Ma Jun wrote:
> Initialize the phy_id to 0 to fix the warning of
> "Using uninitialized value phy_id"
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 8ed0e073656f..53d85fafd8ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -95,7 +95,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>  	struct psp_context *psp = &adev->psp;
>  	struct ta_securedisplay_cmd *securedisplay_cmd;
>  	struct drm_device *dev = adev_to_drm(adev);
> -	uint32_t phy_id;
> +	uint32_t phy_id = 0;
>  	uint32_t op;
>  	char str[64];
>  	int ret;
> @@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>  		mutex_unlock(&psp->securedisplay_context.mutex);
>  		break;
>  	case 2:
> +		if (size < 3) {
> +			dev_err(adev->dev, "Invalid input: %s\n", str);
> +			return -EINVAL;
> +		}

Better is to check the return of sscanf to see if phy_id value is
successfully scanned. Otherwise, return error.

Thanks,
Lijo

>  		mutex_lock(&psp->securedisplay_context.mutex);
>  		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>  			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
