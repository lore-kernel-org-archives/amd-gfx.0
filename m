Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC12C54736
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 20:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C901010E405;
	Tue, 27 Aug 2024 20:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLMyS5K8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1FE10E410
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 20:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZYJJFNlcBqiBayQeeSwtnpbICj8zqgakZDfvivYTIoqw3+Pzgj7GUat4j/TIW4Mx1yc7xcuogMuwLb+2y0lnLKjQONVJKOF8HKx+dG5s8EsTmZb4wEX/HZV7Rg86969gGf789iazSqjFC80A5Dmc+JiCxFXaofC7On/9oJEJUYb9JrsYkQKlQUKgWNQATEIrBzyQuzBrYNIys5NTjq00XpFZ1G8YQlvnpRi/ED3336vaw29Fxc2qTUP74jepsptzwk9clzKF9wxYnB11F6ZJvNM/OA684cZ5XCDSsfjKbafBYFErHQhxRQvegWIOmCKd6UJ3u2ibmqJNYaZCliVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OH6Umtau1rszqePtou/0HoDrPFwReX09pw49Mf+TEw=;
 b=Nl7r75ZOFHWmRbf5clCCwuWP4IEEdj3YLlL94aUSUjqk9G1NItVa9/DoAGGWpM0WC1kfVAQmVIJlIJeZ5d4denWdc0MSPyvXWroR0WIBsFMcEdZyclPcNDpdC/1VLyc/UOtP9ABkGP1UkVIQlQqBV7h5aCIL+ZoYRiL1JruU/HXDcU5KxcwQePgpPFPXmryd933i27InolBO/78/lsuBL7uDLMWNVLOQ/McYk2ABmWud7XIlFjHxhk02AWYpSlsDvpyLH2CFro61srDA6cQ9cPyb9VhaeKTqyPFtBgKMgCr/EHf7UWeGaiVdxzQ/U31YIx3g8SSrBCkOpYVGnH2/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OH6Umtau1rszqePtou/0HoDrPFwReX09pw49Mf+TEw=;
 b=uLMyS5K88MRz6j0e3fUpBgMWRwgiZVLqG7l4PA7kas008QNmxYv8+x/WpPC1eih86ZgO5zVAjCjyZhyFS1eXHVJHA21fV4KNWWYqFAcNcFw5C+BojQ63xV7VsXDQXMrGGZxJdo6038ROkngiP7IgdMiiF1qjQzT39Ck0bq1QjDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 20:38:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 20:38:35 +0000
Message-ID: <94137de1-b91f-489a-a5f6-5be49a19030c@amd.com>
Date: Tue, 27 Aug 2024 16:38:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Determine IPS mode by ASIC and PMFW
 versions
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: chiahsuan.chung@amd.com, hamza.mahfooz@amd.com, roman.li@amd.com,
 aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
References: <20240827195308.92171-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240827195308.92171-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b957089-d8a9-4fbf-6683-08dcc6d838dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtpZHQrSzYyeHRCUVJHWGlrMHF4aTB3dERiVFU2ZnNlbVQ4YUFpWW1ZbExT?=
 =?utf-8?B?QkJNaUlRMHBlN0puSGhTcVpRYXpJVlNSNkNPc3FxdkJrbmdhU1RSNldYamFx?=
 =?utf-8?B?SmZFVUxzT3huaWRQVXJBcVh3VWd3MnRuOE8zWm5wY3dKSC9GK3VDUTdXN3dD?=
 =?utf-8?B?c0FRY0tpZ3BDdHRhbEZnM3VqRjU1a3pzbm5SQTcyZW5IRnVQUm84aUgrOHly?=
 =?utf-8?B?Uko1UzlXRm16NGp2SHltYmI4NDB0RHAxZDZjcXIzTDJkckY0em5FL1RsM3No?=
 =?utf-8?B?UzQ3SUN0SENnSFRwN1NpOXByMlkrUkJXWjhNbWgzenMxMkpFMURPdmNacmZj?=
 =?utf-8?B?eWR3U2pTUnFHWFhneWMyY2UwWk5YRHpYSUJHZ09USWQzenQxemVpZDRCbnlx?=
 =?utf-8?B?aXVsUlNIUmNjYWlCQVpOSlE1TXpnTHJyVklmeHJaTTVONTFsMHgwZ3pVK0ZQ?=
 =?utf-8?B?eFNLL1plZzIwTWpxbFM0YWxTaDZDZ0dXV0xDYktlbUViWUZIeXI2bHBUSXZQ?=
 =?utf-8?B?UmxtdnhUSGd4RkhlNUdRYmhPaThVbHloSkhFcXYvMEJZZUZJc255Z2NtUExF?=
 =?utf-8?B?aFRSQzM3SGxqSXkra2pWNmJiVmVhQjJMRTRpbWt3elkzYTN5eXRFRWJLRGtY?=
 =?utf-8?B?ZVdnVlFCMms5WHNjbzFFTWJjSmJ0SXplOTV3NHhGM3FlT29GdllKUGZTY2Jq?=
 =?utf-8?B?WHBGanlHK0pVa0NvMkN3cEU4ZzdRTEJwNTVlTVZBV3lNcDFkckQwQ3RNdDlH?=
 =?utf-8?B?MStBZ2ZJNjFwTG8wZkpkVXY2UHhLOVdST3pLMU9tcVpNTXAxRC9qdUdncW9B?=
 =?utf-8?B?QjNkendNU0VDU3VtTGRNWmt5L0VDeWRkZCt4dEExK05BSFB2K0thcjU5bDY0?=
 =?utf-8?B?c21ETnhDbm5ZVVp3aVc4QkRDNzFmb1RoYUwwTjVVRUgzOFRGb0RybWhKZGhv?=
 =?utf-8?B?L0h3bUh6Y2ZMWWt3enJ1R1prYS9jdTdEUVkvMnlCT0Era2Z5TitkakNzdDM5?=
 =?utf-8?B?YVlxaGFOWktDWUZ4NmRQTTl2WEVkNEZZRjFOSE0wOTdPenp3WWE3WWZYb1hh?=
 =?utf-8?B?MEd2MmNiWDA1ckdkTFlDeGw0RlA1L0VFTDN0MmZQcm1WZ043U2ZYU3U5Sk91?=
 =?utf-8?B?SWFmWlhPcG9lSUFSN0NveUExZ3c0cGtHTmJHK3ZpUExRUzZTejRSdDRLQnVt?=
 =?utf-8?B?ZTh0TUwwU2gxaUpyV2xxcHdzZzZFdVJIMnNVZ3FRdjBCbFBJeHBKYkcvbGgx?=
 =?utf-8?B?NkszcHZHem5CMXBSRVd0VnloWXZoZDhZRUhvb3pOTXVYdUw4anBUZUJFWURv?=
 =?utf-8?B?V2dMZmdob3docFpEK2NFa3BMYmMrSjZiYzN0cko0bTUzYWZiS3ZFZ0NNbklu?=
 =?utf-8?B?V0VOR0NwQ3hCV0tnekVYRVZidFdNUm5EWEpmNFVBdVVuU1UvUTZHQWI4UDV6?=
 =?utf-8?B?bWdEL0w5eWQ4RU93ejU3aXFsTGkwVDJHcnlXMXdrbG81NkdOczhuOXBPeDRY?=
 =?utf-8?B?UHZucUFZZStPMUxCOS8rZmJoQWZxbFhZNGJ6bkI0Z0poVWI4TzNsemFuV3BS?=
 =?utf-8?B?WXJwRXRwN1RQVEV6K1o3SXA3RnRRQXd4cGsydXorcFArRjBGUHNrdTNqUGx6?=
 =?utf-8?B?RXdxS2l2ZWdLSy9VYmxQVTFXUVExamd5SStDRjBac1JMRnZLM0g0S2N1SEpn?=
 =?utf-8?B?eGN4eHFRcTUrb0hWbTZVY2pnUXBvNENqNUFGU0RNYWtGUTg3SDlKUXdmaHpT?=
 =?utf-8?B?eVM4MTBlY2xCNXYwM0NxS1I3ZzNuUkZxTnQ5MlRaazlZdHJDZU1tQ1ozajRy?=
 =?utf-8?B?b085Z2NDZ05ZQnpKSEtHUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2s0MkwxN3ppTHN5ODZJMlhxejdqSXVxMkg4dml0V2djMjB1bUxVeG1DcWNE?=
 =?utf-8?B?OVV4Zmg0WDFFc292NFRTcit4MlNFNVhjeFdKRktHZUh2VWVWeTdub2FLb2R4?=
 =?utf-8?B?MVRQZE9LL3NKTFNNd3lXV3ZKZ3MrWXN2RkN4TXVzdXZoWWpxWHBMaTcwc0xK?=
 =?utf-8?B?NUQ3c3FNV1EwWDQ2ZXRsWGEvR0lRRkNHTWl1M0FaVUxycm1sRTJndi9VdlFr?=
 =?utf-8?B?a3JVdWVkRUVPQnZmdHQ5VTFJN1VwajlPRHpiTlNMd01sOWRJak5KaE9DL3Bp?=
 =?utf-8?B?aGU2VklCQTJKRS9LcGw1NCs1SXdxbmZVZ0lXczhpNlRrem1ZL3poelZMUCtU?=
 =?utf-8?B?b05jVTdKbC9JYlpQWUN4U2NMcXFvMUhteWxZM0dpZ2xJL0RoQk5sVlVBRlha?=
 =?utf-8?B?RFBwSm9veWJYUCt0bVNjTGVIS1dWNUViNWZnK0E5M2JPc2xWY2MzTjRveDNw?=
 =?utf-8?B?bDVnVENiRHZtKzlIaXJHczhaUGZ6bmg0N1pIb0FoVkFNQWxmWXBzaW5MRXpC?=
 =?utf-8?B?YkZLYytSMS8wY2JVazV3eXVPQytZbGZveFp4UEhoVzJZNnpCQlcxWXJQckYx?=
 =?utf-8?B?QTJ6ZkVlU1E1cWJqL3JLUHZtZnlHUjRJMTl3UFlQbU1UTWttcUp0b2loWVBn?=
 =?utf-8?B?cE83bllPZzdMYW1aYzQwT3FPL2VGSHZPZ0xzWTBPTWtTRkZKckhIak9uUmJL?=
 =?utf-8?B?eUR2OUtlQm1mcTBpakhNQTRRMjdOVEdhcGR5UFhQRjgxMUJ6bmJuT0RBSHdB?=
 =?utf-8?B?ZHJTZFp4c1lzL08wRndOVUlwZ0FCYXk4SzdnYVFuY3J4UUhiaTkwYzBiQUhY?=
 =?utf-8?B?NGNCUUhhTjg0bndETkt2TDRxZWRZNk5pUlcxdE5BSlV1VFRrZFJ3aHlMdUtZ?=
 =?utf-8?B?dDV4d25xK0J2SXRFcHhvMDVyc3l2Mzl2bXFsUzZRejRRUm5ZZUxobVFaQ2p1?=
 =?utf-8?B?NXpVOXFvTDJRUnRadlJwMVdEY0hTTlpUSFQzRkFqN3R3Z3hjTzZPNDNXdm0w?=
 =?utf-8?B?ekF6cVkxVm9uMkFLQ051UTc1RCs0dTdndUxHWkRXSUVidmhOUUwzY2pSY3FF?=
 =?utf-8?B?dWNrVXd1MnFYVUxXQWlYaUYwRXJjelYxcVh1a1RUQVVHQ3ZXa2ZRTGxCdW9v?=
 =?utf-8?B?RFRLYjBkTzBwemFVZk85NHdwUSt3ZkFrbjZQU3JIbnB0ZzlUV2ZTREkxN0FH?=
 =?utf-8?B?L1A3REVMSWRJYnNudk9ONk5GMXJpT3ZGWnY3U0ZVaUVFSkkxaHd5N0NMbFdE?=
 =?utf-8?B?c1BXMTBjUURRRXVtWVNnRkthVzdHZXhWekFmbzh0ODhQS0JoQ3VDRWQ4OXlt?=
 =?utf-8?B?NFNXY3hiQm5LS1JCK0dOYUc5T3ZTdlVGUlFtU0hKUjk0TDBBNVNIRWJYOVRm?=
 =?utf-8?B?RjA0T3NmbkJLSzFqZ0UrS2JveGlIMUZsbVVIWlRyZFJiY3N1RFNENmpCMlBC?=
 =?utf-8?B?TEErb0doODc2aEhLbWd4MTVXaDN6WllnVG1HbGpBY3FFYTViaU5NZkQxd3hH?=
 =?utf-8?B?ZXRhMmR2ZVllRW5UN2w5ZGFwMWRjM1pZTWRCeEZWUUROMTRLL202c2t1d3Ir?=
 =?utf-8?B?UUtyclh2cHBWVEc3ZitQY3NuUEV1VzlwdW9oekp6YTlrVVlhL0J5c1hYamQv?=
 =?utf-8?B?M1N4UmphSG54K3NobXRXcE1uWGxUdklFZTNKVzNQb2g2dmpTemlhdWt0eVB3?=
 =?utf-8?B?ajZOcXBNWStuaER4REtoakkzSmQ0djdleXAvdnZtOGRTSFNOK1pRdU01SU5u?=
 =?utf-8?B?ckY1a2R4dTRiMUgvWGJ5WmZJZVcrZ2ZvQS93dkpicGtTajF0Q0hhS2J5NTFj?=
 =?utf-8?B?ZjlVQmE0TEp6SllrTmRzVlVYMkdsa1NpS0pQRUQvSHVBWXlFSGJLa2tTRVNh?=
 =?utf-8?B?OStsdVNFbTMybkthcXcwMzNqWHVuUHBZc0tmcHdYMjNXeEdWdzRuYWlEeGty?=
 =?utf-8?B?M0RVV2oxSkNMRjI0WEM1TElDUGJZLzdlZnk2aFhwUC84TFhCN3BmUkUyWWQ0?=
 =?utf-8?B?MUVBNGx1bVRyY3RQN1NwUlMrYXVpWDJGRUl1SWlpU3JxL2ZxRUxKRnVlYkF0?=
 =?utf-8?B?czh2RHRnNUhnNEtGNE0ybk14WlRDV1pwWVU3VnVLa00waU5sK2k5cFl4d2Zm?=
 =?utf-8?Q?CSyWqzeIhwHFbsC6ggGDJrHge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b957089-d8a9-4fbf-6683-08dcc6d838dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 20:38:35.2755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGePH2SxgenXn4jQ2YPcpH2JaYfaJf5g65YmXT8/T9Tp0Aorpq6rWamfk3xXCeQYhLY1w8qjHQOeCiJlbJMEdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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



On 2024-08-27 15:53, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> DCN IPS interoperates with other system idle power features, such as
> Zstates.
> 
> On DCN35, there is a known issue where system Z8 + DCN IPS2 causes a
> hard hang. We observe this on systems where the SBIOS allows Z8.
> 
> Though there is a SBIOS fix, there's no guarantee that users will get it
> any time soon, or even install it. A workaround is needed to prevent
> this from rearing its head in the wild.
> 
> [How]
> 
> For DCN35, check the pmfw version to determine whether the SBIOS has the
> fix. If not, set IPS1+RCG as the deepest possible state in all cases
> except for s0ix and display off (DPMS). Otherwise, enable all IPS
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a18ecf8607232..a2e4973a4f6e3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1754,6 +1754,30 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *
>  	return bb;
>  }
>  
> +static enum dmub_ips_disable_type dm_get_default_ips_mode(
> +	struct amdgpu_device *adev)
> +{
> +	/*
> +	 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
> +	 * cause a hard hang. A fix exists for newer PMFW.
> +	 *
> +	 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
> +	 * IPS state in all cases, except for s0ix and all displays off (DPMS),
> +	 * where IPS2 is allowed.
> +	 *
> +	 * When checking pmfw version, use the major and minor only.
> +	 */
> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 5, 0) &&
> +	    (adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
> +		return DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
> +
> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
> +		return DMUB_IPS_ENABLE;
> +
> +	/* ASICs older than DCN35 do not have IPSs */
> +	return DMUB_IPS_DISABLE_ALL;
> +}
> +
>  static int amdgpu_dm_init(struct amdgpu_device *adev)
>  {
>  	struct dc_init_data init_data;
> @@ -1871,7 +1895,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
>  		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>  	else
> -		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
> +		init_data.flags.disable_ips = dm_get_default_ips_mode(adev);
>  
>  	init_data.flags.disable_ips_in_vpb = 0;
>  

