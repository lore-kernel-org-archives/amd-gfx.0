Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1D4C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A335010E535;
	Mon,  7 Jul 2025 19:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OklOEawt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6711810E535
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1hhGtDwzG/+f9Z25sUBcpxNoEj3ZTUeqIA5Lsgs5LLoFtEuep1P11+igf19WYXuA1I86xZtWfNd6ty4bFyFcNacpAcrLYyWBnAPyZ6GiAV9RBuZ/4QveraU4nd7gwmQI3qBpiZmAT05T3THuRWmoMzzeD8P+Q3gzMWV3nGQuwU+A53piWIgZ5Vi4bg22DHUpRejdVXkKJ/qBMq7ZgcuPdMbpjhWAZSrPVeI2K1cujOTlNaXyLAA49CreO7UKEyp6mjJ56bXzlC+HHb8cBP2469JxWZ5nFTkuQJOQvk6k4cXQOAOVP1wYM2AyBxJQZEjILvb0qsIzM/pb+mTba5vDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+8BUifAj7anFtLj/Tmj5oURCWpNWpKYpbZ0NiGhICc=;
 b=IClXZ+ZFQ0HUeer5BpjSXVpj354sMzfhNlJ/NBpWvCLhRv01cjRf/PnYLpuxSMe7zusNKU2bfpuBtv26gaA0K4SpmRf69sGbvdud7tB81JxJgyisa8YdkgWhY4hIsgsKLC/hWecR9xgB1VC4hvddFWNJ6oQ72gwxoi5xrxZqSTSjH/w8AHgJIq2bu2WcHviZ27RsN9un3sYdJHbgDPTccHy9gSqYWA4s3upgsjvtShrkfaOsTrtbMrVNCEiSBOAXvbvH/RlCurp8Qmmjk8a81TZwiV05oPtAqj1as62sPCv/ekSubdVbkk7Gy49agbT2PE+nZ4Abgcz3wF3DGp9Rng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+8BUifAj7anFtLj/Tmj5oURCWpNWpKYpbZ0NiGhICc=;
 b=OklOEawtHiLCZwktzERxlTNxjsG3bEzRrJGWLb3AzjlD49gweARssXoFt8VsRhG1cTuQ2wzxpLoneh40B1Hq93FXDCrM992teqGedxrFW+W0TKS1zCI272SpXvRUxpt9AuZAcX9/5Ye7HkNB26WFJZcm798PesLxpH2dEyJuixA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:05:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 19:05:15 +0000
Message-ID: <09ae676d-a559-4b73-92ea-0c9031822b51@amd.com>
Date: Mon, 7 Jul 2025 15:05:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/36] drm/amdgpu/vcn5: add additional ring reset error
 checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250707190355.837891-1-alexander.deucher@amd.com>
 <20250707190355.837891-11-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250707190355.837891-11-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ada26a-d5b7-4141-5c83-08ddbd89352e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGNPR3JNRXNMTkd5UWdIMVk3STlYajkzaUxCdGNNWVNNejBBRXZyTE15MXJE?=
 =?utf-8?B?SU0yS1RqZFlDM2NiWVhRQWwraWlLUlZpT1J6bXJtaTVIQ29LVlBrejdNUElX?=
 =?utf-8?B?WDBwY3pQbHZLUGhtOExzdnlWd0VZK2srZ1BZZDlTK3ozYlZDakxzNDBhR29p?=
 =?utf-8?B?NXREZ041TnRvTU03M1kxcXlCMnZyYm8yblJCYUE3c3VlbE13MmxBa2xyNHkx?=
 =?utf-8?B?MlB2OVpuSFo0L1hQa2tVTDFSZktQaEgzdkpSbXkxMk9HYll0WEpGWCtUQ0I2?=
 =?utf-8?B?dmF0NjlaQ2FSZFZWYVZQNEF3TUgrTm5lZ3VPbkkrRENDL3pkSHBIMGkvWEpO?=
 =?utf-8?B?VytSbk1QVEZBNVFjeEJMY3pZWktwR0ZTR2R4dzRTamZMUmEvTUxzVHV3QlBx?=
 =?utf-8?B?Zm9ERHFHL3laR0R5eWVVcDl6Q21qREw0dmRjbEVKV2V3cUhoOEVkSWdCR05O?=
 =?utf-8?B?R2hHRHA4Sk1EZmw2b3RUR0Vnbm1uVnp4OXJZU3Zqb3AyYk02ak5YejJLaFBT?=
 =?utf-8?B?NTU2NkZOenlGTnlFSHpORWlpVjErcythZndjTUFOaTE1dDAweFh1L2NkUHJX?=
 =?utf-8?B?Q0g0RWtUUjFqSUxaWW5HMzVBemZGb1cwWkYxVnR3US9pbVhHVEhTVTRjaHRB?=
 =?utf-8?B?RnUwZ0VKeGR3dzF3SFdHbGlqU2diSHU4U05RQmg5Q0szM0xQOG9BY1Z1NDVt?=
 =?utf-8?B?SzV2djJYSjJaYUVIeDlhcFh1aWpGZUNXU2Z6Y3h5K0pvenBCZ2tqeEtxSHpk?=
 =?utf-8?B?RTBJYjZZV3lsY2JLZnAyTjUxL2NlM1l3TGFsMjZTU256aGk2TC9rTUw2bFp6?=
 =?utf-8?B?L290Sk1tRXBGeEVOMGlQNlk1NkxTT0s1Rjc5eXFsSmVaYVFBOG9GZDMreDNT?=
 =?utf-8?B?RlZPcWR1NG9FdmxCQWtDaW1ZbWRnZ2h5SU1Bb2JtSzFaOEpkVnhISlAwaWJW?=
 =?utf-8?B?R24wWEdheFpsN0d2alFtTXM4L0hSRXFDMDQ3aDRlMWdTQVhiV2NtSlI5QXBq?=
 =?utf-8?B?aDJQc2FKQ1duYzdQV1FzeHRZOFJ2T2tuMWxPZi9FNGthK0FaazZ0YUt0Nmtv?=
 =?utf-8?B?bmlnT0ROb2VEYTVmQnc4NUMwaVJGVm5hVW9Mbmx2QkpNZm51djRKTlNHQXZU?=
 =?utf-8?B?OGtnVFpWSTBsSTJGOUxZQ1Q0bzlZcGZxTWw3cFIrNFdMRkhRbjl6M3ExNzJU?=
 =?utf-8?B?UVEvOVF2ZEhRcHMwSjFMU2VrMjNBblRxZmIweDNnekc3QWRJZjVFWmUrYk1S?=
 =?utf-8?B?dmRrYkxXRkQrOUpueEkvRzRKcmxKSTdnM3dyQ0xwT2U1L1BGbm9Sa0J0aUhM?=
 =?utf-8?B?OW5HY0VtN3E1M3d5VmRrblZFYkY1RFVZRXJmejA1WlBsNDNhRVQ4SjBTMlRE?=
 =?utf-8?B?Q2QxQjlzbVRMN0ZlQ01uMnZvb3UvRzlVaFZHNnVUYUY4TnUwYytsbGZtVWtF?=
 =?utf-8?B?Rk1iR2h4a2ZiNXhSUy9uOXhBY3hBVTdPMGs5ckUyV3U1ZXlJRVRQeDdDdW0y?=
 =?utf-8?B?eGVvYk42NkU1Yy94MkxKUUxOVlJ2eUV5WThsTFFITlo4eU9lMk1GQ3dqVS9Z?=
 =?utf-8?B?TFJXOW90elkyeDFOekRjQlVkZkIwYlBiSWpPRlg4SjRPcnVLNjNSbXNodmxS?=
 =?utf-8?B?T3ZMZVAwWUZsd3VDdWNoUWp6ekdTQjlEcHczVUVCdmZ6dUEyYlcxWVd4TDJC?=
 =?utf-8?B?Q1VvQUM0a0JDSWdFMkp3NFZxaHo5YVVQWlJTelVwSThML1RMN3hhc2ZHcWox?=
 =?utf-8?B?ajVaWFZyMWlUcnZtUWdMbW5sYlE1NlVNN3JWZHgwakp1MWFmS1p5WE5GN21B?=
 =?utf-8?B?R3ZadXRIM1BUZUlONHdSbWN1Nm9TVWpxSzc4UjR1aDM2Y0l3cHp4N0xrSDdj?=
 =?utf-8?B?dThpK2NIWHhMZjhpK0JYMUxvWmNDeFJuTXllaUR6bUpTWEdjZTZWWGh6QmdR?=
 =?utf-8?Q?udN1faI9e9A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1pbEdaRWZEdS9lVzJOZUxPSjEzL0ZlSE85YnlhaUZZSmVGMlZZSGszQ2Y5?=
 =?utf-8?B?emNpOTE3Vi96MElPNExTOXhIV0dwckoxVUZLRUU0eWNoaXVjc1Jnelg2bVVZ?=
 =?utf-8?B?eVFRYS82TEQ3MVpNZTd0eml5c2VhUEg4d1JSOUx6WHJZcXVRMGFGaUQxaDd0?=
 =?utf-8?B?SXFiWGd0M1VDVk4yQTc1OVhORFpENmJDRFYzYUVZZVB0MDNISkxVTHBheHBO?=
 =?utf-8?B?ZW1QM29OcGpZTU53endiWG12azVZYnlYeWJ2OWZqREpRY1BMMTNZVDUzQmFK?=
 =?utf-8?B?TEdZMlh2TkR0NFNHaHdVV0pDbUtEdUtKa04zUElORUM1MHJvMEsxTy9NYk9E?=
 =?utf-8?B?UHBIeEhsK09RVlMxTUFmUER1WHdCMEF1ODRPbGRsQjlOUHFvMlk1QlZxVlY1?=
 =?utf-8?B?UGRzNy9mZFJxeFVUV1hiSHNlMVhpZENBUEg2SXcvVjVqeGZHRjBWNThPclEx?=
 =?utf-8?B?ZzZCZXd2Uy9RVGtLYSs0Q1RxWnAwZ1hsU1oyNlZoaUxoNUxDVkV2eUtLd09p?=
 =?utf-8?B?L0h1ZmFYcHZEUEVQMzJRMm5MSzViMVFlOHBEdVdIN2lqNHExMUY0d24zaitj?=
 =?utf-8?B?WWczOTlXaWZZbnF5eWtrd3BTWm1DWGhibFhBanJBQ0tGWWs1dU8wakVWMklK?=
 =?utf-8?B?ZXRTbGdkV2F3L2E1RGZwN0t1UmgxQWY5V29DTUI4RmtXWEx3dURXNlVycFlM?=
 =?utf-8?B?Tk9yemcyZHBibHg2bUxSeFZuR2JabFhEaDB1YzNzcnI1UE1yY1Z2THdLYnlH?=
 =?utf-8?B?aWZVQS9OMEZLTFBsUWdWbmNqb2kwMWVFQkMvRXFZbWVqRHViWmNsTTlONWU5?=
 =?utf-8?B?d0VndWV1WERoeitzZFYzMys1aHE5aVRocHJHSTJDYlpzaU1NZ01wZlJ2MTd6?=
 =?utf-8?B?aHRPTUlybGJTNVpKTlA0cXlxTHZBRXB2NUlLdkV0alpsNkgwbmlELy9mR3hS?=
 =?utf-8?B?WStUVTlnSFZJOXdzakgzaE5KVFNXT05FeXgwSHJUNnFjNFpWdDQ0am1IS2l6?=
 =?utf-8?B?ckFxV0NuY2FCcHJ6OFU4UXFqQ1c5UGR3dktjOFF5SUg5cGpJaTZaN3NId2lH?=
 =?utf-8?B?M2ZLN0x2d2NETFNtK1RSTWszYm9wRDYxaFVhd0dDWTlBMXAwUlJoSlJya1A0?=
 =?utf-8?B?OVVRTFdFSXhTSXdVSnFPQlJmcVdnd241ck83K1NHMkRaUXp4ZVVYdUl5bTE0?=
 =?utf-8?B?L1BBRVJ1ZVNML1Q4QXlZYUhTcUJxUXk2YmlwblYzVVNORzdmSHYyQXM2WU5O?=
 =?utf-8?B?WkV1N09JazhSMzNnbHJweXA4cEJJU3VMdit3RmlxamxZcmYrWURjUjZ2SUdQ?=
 =?utf-8?B?N2FhdkpYUWpmK2t2VWJ1OElianZ1cXRZcG9NYTlZVzJzS1ZKelJuejBJNEJT?=
 =?utf-8?B?UkxuL2RrbGU2NlVLd0NtQmk4OGZrT2c0SjF4REhlVFJRL0xPaTUyZXJSZjJ6?=
 =?utf-8?B?ZkdMNXFTVkloSGZYZ0RsWU1nQk52dmQwUStGQ2Rwa0JPeDVGZzY0bStrZDNQ?=
 =?utf-8?B?WDNjQ1dzdGNPUXF5cVZScy92M0tWRVZReXpLZ0N6U0xTWU5VR2pVUmFOMktQ?=
 =?utf-8?B?QmlURTVIMm1KWFlPYXlpelFqSk1QSU1UUzZGVkZtZnRWcG13bHlVT3FZR0li?=
 =?utf-8?B?SjdKVXV3NVZVeXBqZUs4OUFkQlVhU3pMVWNrbTJZWlptWERzdVlBaGRsUkth?=
 =?utf-8?B?K2JITFo1U01NUHVIL1l0MFdBSWdOZ3FWSVhaOEtLVlN0bmMzRVZqWFpzaW1W?=
 =?utf-8?B?RllkQ3RhcVZzWDMzNmp2REF2WkEwZVMzSFpMYzlrMGMwK1JyZ2hNRFlhRW5r?=
 =?utf-8?B?ekZxT0FPMHNPaWI0QXBJSWd3MzBIc2FIeW4zNm1rMmhnRmQybjc2T05tVVpS?=
 =?utf-8?B?amRmbnVEWmJjNFl4bW5BNS9tcEpFLzZsdi9MMVg5bTF4ekRJTDF3ZTNLd051?=
 =?utf-8?B?NlFxRGo5Yjgza1dBdmNVNGJ0Q3d5RWxlN21EZGlxWmUzV1I5YnFxcHpEcWxn?=
 =?utf-8?B?bWQ3NzdvbDEzcVprUTBQR3FIQmd6OFNCelBnUGlmZ25RVzBpTFhXcjVFanJ2?=
 =?utf-8?B?SWtrekM1bC8rNVRuREFCRTZvM0lyZjg2cHpNZElEM1FCL0V6aVIvRmZOb29v?=
 =?utf-8?Q?MtNq488GcVgEY7oDvTFFSGB3c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ada26a-d5b7-4141-5c83-08ddbd89352e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:05:15.8432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCtKDy0gNGjjF5VMK4qcwYWickNNd7KfYH+N//9UAy7xAordM9fyi8rpLU7S1rXHHCozv++DhDaXmkptdGUGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
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

On 7/7/2025 3:03 PM, Alex Deucher wrote:
> Start and stop can fail, so add checks.
> 
> Fixes: b54695dae995 ("drm/amd: Add per-ring reset for vcn v5.0.0 use")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello <mari.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 47c0bcc9e7d80..3d3b4254bd729 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1204,8 +1204,12 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>   		return -EOPNOTSUPP;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
> -	vcn_v5_0_0_stop(vinst);
> -	vcn_v5_0_0_start(vinst);
> +	r = vcn_v5_0_0_stop(vinst);
> +	if (r)
> +		return r;
> +	r = vcn_v5_0_0_start(vinst);
> +	if (r)
> +		return r;
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)

