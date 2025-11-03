Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817BDCCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 14:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C0310E02C;
	Mon,  3 Nov 2025 14:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="feWKoy5I";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179E510E02C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 14:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h63o4LGV5dXOs5GvVXdcmI71unmEZv+zBtIww5N5lG0JBynus/nxxrDes1iMcow/hIZLT64ejcolRrvw7Xb+BiRqRNVsHyntm4y8NhwXB+th+jXXAFCj2U+7ZvPbI1esZ/njIaEt3s4HgjPgjPnmZ/itUI93jgdkcbKw1LjMvbr1RCoFwOpnuLsRv/J7F83DqL35BOK95UGL5rzBxE7JPLLyyGEWHWYDvVfq/AbpjzzsEx2jNmr5V6n/nWcN90N1JjbuUzJbL9DXFw3kMjh4wrLaaFTfuwf8p/C0ZnH93uT6BCnyq0JN0y9zvyZFAvn0wdQ8jyfRhVpE2icQ5BXvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/qftlgyaWHm6YpEyNTbYaiV8+49UapTxmLLk3YMRJQ=;
 b=rYIKACEzIHtqyoB7/NHp7hAhK/YKgFFXrz115XdEc4VQv7WgXxcHSTBG6aZ6npua90laJrIRz3Ud6wAK4S3AjufPwHqt/siC9sZeYkaxpDN2y7ArP6gX50hxrkkB7IfX93foNOGHw0vfoXqVKAD4jUw9NnTymOyy24LfbGWUWs78WhJe/LJI31vACAHzuhyHjTl+L7oYfDczWHuQ8rD50LciWDWCnHuu8l1Xo81P0Sjk09ZTC95w4Zb1/QUTnULqdfDgABkfm/aYuVtxC98wXwPNiTCoj0z03w9NgpuIJHOdakchKRBcgATvEHn/OLHfYXltmu1hEuWkwcv+Neee+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/qftlgyaWHm6YpEyNTbYaiV8+49UapTxmLLk3YMRJQ=;
 b=feWKoy5IUqhkhwixZUF5GBnoGKkjnkUgHY+Ucxu1qzx4p6AiYXbshugiEJ/b1lL61rW6mlx/MteI6V8dsztoBahteikUAYDSHvttnvf2uVSNuw0S0HdE8pVU0yo0iFgQ0SDQa7b5Lnrf3w2WEqstAwofnbMiHtO0O1jHs7lH6l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:14:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:14:03 +0000
Message-ID: <7f084eaf-296a-4a5d-8eae-e30476655818@amd.com>
Date: Mon, 3 Nov 2025 15:14:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix wait after reset sequence in S3
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com
References: <20251103113635.733891-1-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103113635.733891-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3f6aa4-a6b4-407b-c5f1-08de1ae33dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejNSRThnbGJ3YytKdWwxYktkbWVKYzF2WHJZbURIT1V6YUs0cDIwZldyVEkw?=
 =?utf-8?B?WG1oWEVJZ0RBWHdYTmc4cURHMCtSbVMrd0xDTU1Ka3R3RlZYVzNyQWhGemFY?=
 =?utf-8?B?T3k4YnBZR1gwbi8wY2pzaFVlMVhockNOZmtCSVhOMWFJcWUra1V6aWpWMFFK?=
 =?utf-8?B?cFMwUEtBTHZObFU5QVlqYWFSQ294d2ZmbUdyN2w1MFk0T0ROcjdqM1B5VWcy?=
 =?utf-8?B?RkpXLzJqZGRvTDVKZi9GcFlQSkgybGc0dW43bXJqc1lScTIwVFB3NklnQVBZ?=
 =?utf-8?B?Qy9WMUFMc1o5cG1KVHhQVFJYcjZRbXBUYi9DQmlGYUROTmFUMFhSaDJ0Ly9S?=
 =?utf-8?B?RkJKMDBiQm94SEJ2ajFXb1daUVVBRVkyQzR1WWdoNFg3c3FKUVdUaEh2blpk?=
 =?utf-8?B?bkRVdGFxRVp6MUR5UStoam9uT1cwV0Jnd1ZaRkJpTkswUjJ5U1d5bmxrUHZX?=
 =?utf-8?B?VHVQNlFZYjJwSkhIYnAyQVdqREhpbGNHV1pUQ0R3NGJLeXFYMVRuZ1owQUE0?=
 =?utf-8?B?OGFNQjBYblJoNGl2L2hMZll2dVdiYVQxQ0djMFdaclNzTitaa3pWU2o0Z3Jr?=
 =?utf-8?B?WlJIc0w3UzRJR3ZWaXE5M0pKZ3VWdlRtYXVOazVqMFk3ZnFTdHZBTnRXcEZT?=
 =?utf-8?B?c2VNalI5V05MVFhQenU1c25MYWtpcEZrOTJGeUhEZG9MNk9XaTV2d3BJVFY5?=
 =?utf-8?B?WkJZVU9abG9ES2xqckNFaXozK0l0NVYyTS9OczhhTnBUa0lYMEVyUzVzbkhF?=
 =?utf-8?B?cmNqTWVReTBJV20yZ29teVlpZmJnUmc0QUQvVlY2MUF4TmtWcTNTdGJyUFlz?=
 =?utf-8?B?MHhTNHlwSG5NeWRKUTE5Ty81SjhGeE9DUE5yclE1TmY3Y0xCaUJPN2o3MHd6?=
 =?utf-8?B?UTRJTEttdXRZdFBzNUpzMG9xeTJranZ0MEtLbTdLc3hUZGVwWUlQaWltTEMz?=
 =?utf-8?B?MlJJcFE0SnRENHJCcEVzeExuUTMySmlabHJyZDhQUHp6ekV3aFZ2VklHSVNJ?=
 =?utf-8?B?dmFiNmtFM05UNFN0VytkNmRnQ3QvWkptdmd0eGgrSjBwMy9PK2dwbTJCZFhu?=
 =?utf-8?B?WWZmVUczRXlCUUZYZ3NORWFWcjc5dnkrcnVES051S3JaaFl5MWl3bU1hZ1I1?=
 =?utf-8?B?RGNmUXZFeXd4UkVPQkFaSEV2bGl5ZUhpQTVhWkM4M2VUL2lXU1ZqZmQ1dENZ?=
 =?utf-8?B?Y0xpWTdLOFlpWFZxaS9GQ0hGb282SFpIWmZJVmFRR2tnZFN0Y09VVnVKeWpM?=
 =?utf-8?B?M0UxQmlXc3hXdU5GZWs3b0M4MnNucXA3bUhzUkNJQWRxcjBzZWtBdTRkUGpJ?=
 =?utf-8?B?VXFsTEJEUTY5TTlZeWQwWldNTmhBUThDWGtITzFyTU4rb3IvaHM2dzBXb1ox?=
 =?utf-8?B?MVp3ZnozcVA4cEtxV2JBSzlLb3N0RnBDanRlTis0TGpjT2c1SVVFaElyQzlq?=
 =?utf-8?B?UG5WaS9nZHdqZWFHcGRncHE1ekJPOTg4a2g3dGtOdjI4WDA3N2VLa2JrM29N?=
 =?utf-8?B?NHJQMVpTZzJYOCt0VHM0Q0xkd2hORHdSZTFCN1IzU3FPNXR5Wk44bk1sWlRW?=
 =?utf-8?B?aVhqN05Fazh1R2VuaTdIZHQ5SGc1akk2N2hVdjJ1djByWk1STGwwRHVMRWV4?=
 =?utf-8?B?UDZxUXZVNTFha1N2emJQWnY5MXhJSlpiZ2hlbktmejZlczNYZldhaEdNSVRN?=
 =?utf-8?B?Vzlid2FQV3hNL014bno5TzR5M0FaTWM5R0lYT3VFTk5kUWVJVm5ROW14dlVq?=
 =?utf-8?B?Qm4vRTNVbStiQ2RWeW8vTXBMTEorczRCcERvQVhTeHNvWTMxa1hZVENyaE5H?=
 =?utf-8?B?SWF4U3EreC9GQ0lNY0Vac1Z0Q01Pc3VPcEk4MlU0M0p5a0tuVDlKbzc0aUdG?=
 =?utf-8?B?MzhROVN0YUhjN1cwZHV1OEhOelJnZVFuTWsvZDE1b2g0V3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzF1MjluTDV1WG1hczdYZ1daYUJ4QlhrMVRVdUpvY3RsNG05RmhkMlJsbEZl?=
 =?utf-8?B?NVh6UTkzTU5zcjBRVGYrUTJCVlRCdG50RHdFVWFvUVBmQ2hGTllYeWI5VDVw?=
 =?utf-8?B?UkM0R1I3eEVwWHQxTFB3dnZyZVUrMzJUK0pjeHZYRW1qTzVyUEx4YTlGQ3Fu?=
 =?utf-8?B?ZGUrSUFYQmdtaGltRVlxRVVDWTZ0MnphNUo2THdkNWJPa3VGNUYvNzVCeHQy?=
 =?utf-8?B?NEFIZlZKMjE4ajZ3bTV2dVhjN094dlZGN01vSW95WG9DT1FZeloyelVKNEov?=
 =?utf-8?B?SnV2azcvWEhTczEyZVJ1bWkvN3JGM0w3eHg2akUwY2VrNjFjQm9SR2k1UGZL?=
 =?utf-8?B?UThYZFJPeFUwMHMvVzZ0ZFRsRkszLzljaEttc2NGVmR4K3Y5TVVIaXk3VDJz?=
 =?utf-8?B?VjNsT2I1aDdZMUF1ZlFSRmd2VTNOajZ0UnE3UjA1YzRkMXV0TjQxb3hMOFRH?=
 =?utf-8?B?cTlpWVM5c2Z6TjVHdHFSK1N5ZlBWQ0lXeCt6UGM1ZXhiYXMwdUhXV2NIa1hV?=
 =?utf-8?B?TjJtOEVFUWlKMkYzTWZoYmg1WmE5OWI0Z1J1dUw0NDRDaCszZmtKR004S0Vr?=
 =?utf-8?B?UFA1NUVvK25GeGt4Q2tteVhsejQycUUxalAxSHZJQ2NFWDNqMEFqNU9rdnVn?=
 =?utf-8?B?UFgwV1c1b3VyeGRNY0FwRHJIWFF6U25NazBobVpXRUEzbDVhRkVHM2JnbzJl?=
 =?utf-8?B?OU5JZkxjcGtPcUdnaGEwa3hyWDFxT3FaVlJRbGxpWnkzNXBzS0o1RHRHMkFh?=
 =?utf-8?B?WHhQUEx6djhyWWthTk8yTmRFK0hXcXlmV29Vd1p6VjhIYXM0Ukh4eVh0QUhM?=
 =?utf-8?B?M3FEcVUxNXErNjJPQkJHNDZGd1N3cm1uc1ZVbkoyd1ZDalhMR3lHRmZvWnkw?=
 =?utf-8?B?YmJPVFNuZHVBT1lrSE8xZ0lTcDY1eUNGQjRlelZHQm1kNkdkdkRYS1FIeVNz?=
 =?utf-8?B?V0k3ekhJK2JvVk5USnFQeit3UEszTmZSTUtTNFpCWTVSV1VYYXh1dVo1Uk1W?=
 =?utf-8?B?QlpaWVpwdHFkQzV4azhib25SWGVJWkZYQ0ZtSjE5dE1ZMDhBUUZzbGVGZVF6?=
 =?utf-8?B?VTlOL290R0FQTmdYRGY2TmNNM0lpb2ViY2JFcnlIMzBKTlhOWlBhRWdhNjAx?=
 =?utf-8?B?OVFFOVE2SFVSOCtmQmNmZllka2d2dU4rQnVFb2NzSjJ1SXJiNGljWUNhY3JR?=
 =?utf-8?B?ZTg0Ym1SWXdTQlhQeEhEWlU2SjFoZFB6SWlScW04dms0NCtVTXU2cktjeXYv?=
 =?utf-8?B?RnVCNHdmMGlvRWc1QytpRjhuUUlaTkxhT3RYTy80SGIrTjlMOHJCVEFvWHJo?=
 =?utf-8?B?cFBtVE4zRU1JYm1uY0hwV3c5ekYvUkM5NFByOEw4MUtYZjNReDVueFAwdVRp?=
 =?utf-8?B?S3FEUGVma0lwSXVkYzR6U2VjdFo0a0ZIZlcvS0YwOC9Saks5aUNTWGlBenpv?=
 =?utf-8?B?dC9sUkxub1Z0RzROMnArQzBRZ3NTZEdxaTJzSnJTU045dlVQd0RVa1dETER6?=
 =?utf-8?B?YTc1WndZVVBSWW4xMTdmMmp1SzU5MDVFYnQ4ZmtDK21wMmQ4eU1HaWpzQm5V?=
 =?utf-8?B?Mi9hSy9PbW5pZDdYMlNoa0c5azd3dmZkemlvcjdEajFvUUFKUlZwQXJGaWJL?=
 =?utf-8?B?eEpKWW1wVDJSZWc2NUp6TlZjRTdmVTVXaHlQeDkwL3BXVWNsU1NPeGd4WXc5?=
 =?utf-8?B?RHN3TWlaS0J3ekRUdlNvSjhlOGczazFDQmd2am40R004bjhRcnU5bTlhNlNw?=
 =?utf-8?B?LzFRVzh1eVdMK3FTMFdhc0pCU3ZSclJBOXQ5UW13dXNvQXM4TnBpQ04xV3pu?=
 =?utf-8?B?QzEyUTczdndZYlpxaHJaMElXcndOWUt2S1NqWmNJaXVnWmxiMFVjLzlNa0Vh?=
 =?utf-8?B?c3NjcnZYVHZYelgxU1laOUFmemtDVWZuSnlzSEFuRm5mdjVOaHpBVlpCc3Iw?=
 =?utf-8?B?TEx3bTU1dzJubFNDUXRqdEsyNzJ6NnpOLysrUDdyWFhpdXNqNnhGSTJMZlNO?=
 =?utf-8?B?dlJyNCtSUGxncHpVZFMrWkh4STlWMEhoM0VCcnovRjFuYnVVc2FyamVLbFRr?=
 =?utf-8?B?Z0tPVFR1azBEVEp5R0VpbGFjS1UzUW0vcS95SytmUEsvb1lQa1RERjFIUTdj?=
 =?utf-8?Q?1wNwC2oSDXm7vQPHflNuqJVNN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3f6aa4-a6b4-407b-c5f1-08de1ae33dfe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:14:03.5372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWaxDSSMQxAjteDTBaCuPIizZKum0ZKZZtohKlAiHZHdAaz2/9P9klrcprzozYJa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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

On 11/3/25 12:36, Lijo Lazar wrote:
> For a mode-1 reset done at the end of S3 on PSPv11 dGPUs, only check if
> TOS is unloaded.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4649
> Fixes : 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader after PSPv11 reset")
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 26 ++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index cee90f9e58a9..3f42cf7c6193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2627,9 +2627,14 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +	int r;
>  
> -	if (amdgpu_acpi_should_gpu_reset(adev))
> -		return amdgpu_asic_reset(adev);
> +	if (amdgpu_acpi_should_gpu_reset(adev)) {
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
> +		r = amdgpu_asic_reset(adev);
> +		amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +		return r;
> +	}

That chunk here looks reasonable, but it would be even more cleaner if we push the reset to the reset queue.

Otherwise XGMI might not work any more.

>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 64b240b51f1a..a9be7a505026 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -142,13 +142,37 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>  	return err;
>  }
>  
> -static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
> +static int psp_v11_wait_for_tos_unload(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
> +	uint32_t sol_reg1, sol_reg2;
> +	int retry_loop;
>  
> +	/* Wait for the TOS to be unloaded */
> +	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
> +		sol_reg1 = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +		usleep_range(1000, 2000);
> +		sol_reg2 = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +		if (sol_reg1 == sol_reg2)
> +			return 0;
> +	}
> +	dev_err(adev->dev, "TOS unload failed, C2PMSG_33: %x C2PMSG_81: %x",
> +		RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_33),
> +		RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81));
> +
> +	return -ETIME;
> +}

I can't really judge that.

Regards,
Christian.

> +
> +static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
> +{
> +	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  	int retry_loop;
>  
> +	/* For a reset done at the end of S3, only wait for TOS to be unloaded */
> +	if (adev->in_s3 && !(adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev))
> +		return psp_v11_wait_for_tos_unload(psp);
> +
>  	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
>  		/* Wait for bootloader to signify that is
>  		    ready having bit 31 of C2PMSG_35 set to 1 */

