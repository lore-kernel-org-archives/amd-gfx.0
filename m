Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED3CCA1013
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 17:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D627E10E276;
	Thu,  4 Sep 2025 17:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YsGBaC86";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC2510E276
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 17:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe/jKmxlSn5vzLyYBx+WHNwXEMtGXHh95AyN1XVZ/hHJ/7HRnGxgMQft8rstMbva3sw8fquAtwlprW6GBBEREOlbRk7cDo8VoyfszIynHEmvwZSwqXdjHtMvRmPR97L9NCAi+PkPGtuJZK0k/tVa6yffs7kiDk5WJWkHZsrCd7ID+ojwoeFIMY/bajM+AjJb/kQmCSZmGv8cqY/8w0LwaaO5mAAN/C9NSHtaOIu8Omp6rUJjh90fH6l55YRQcEjQAymkTHN4R0ZzdpeUaxmBsc65jtrHF0ng09GeDimZYdQx7jICDl76FdXohN1WyMXj2M3mha5kS29+NZH4zq2F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k1UxknbKJ+HUx9W+sZ2YPBm0kOmxXdIAKvQ4LIOpKs=;
 b=VxcXQ8szRZ/6KbGcZt8cjiFhrIYlL6Ssg5Lsmh7yPqLBvvuWOTGz/6WMNVqF5lDl+QmMShjO3x+cx/ausKUhNk3TtzHPbQQIcibxV2tROqbsSavtWDPGk3MnQpaDnqfbklQQN4TEiYtdu0JkqsvfQFAJRSVzIDS3lVPxblu1tioDifKvODH79Eg07Qth2lgLZpRJhgby76r9VVFALTEdRqF1RPc1o5iOCOhr0urDo2diLdFzGRpNczcdLJ/4EyhEnMqoQtWOfaoGMdmEWE1gB50Iho43nwks+cvsE9KsbshhKQjHyQoMUaCRoqKr9Uy2JzIGMmct7czzqgHGtbxKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k1UxknbKJ+HUx9W+sZ2YPBm0kOmxXdIAKvQ4LIOpKs=;
 b=YsGBaC865grT5kvCEl46ILlKux1MHGzqDOV0BGP2rUwhNBUjRj3cnQC+s5oWl8ZB07q9lsk1HqjvEc5YRADyh/i0blmHqhWITnYJmWEkPl/TMRsXoxZZJU4TunTmxQUp8X+KE2we+BTJ0vzx6KRSNf1tEWl5U4AfffeuZX6PtdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:28:32 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:28:32 +0000
Message-ID: <4ec67fdc-af10-46fb-aca3-b5933b306f54@amd.com>
Date: Thu, 4 Sep 2025 13:28:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: David.Wu3@amd.com, christian.koenig@amd.com
References: <20250904144546.59539-1-alexander.deucher@amd.com>
 <20250904144546.59539-2-alexander.deucher@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250904144546.59539-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: b82afa3f-1de3-4b94-f6ca-08ddebd87847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGRqaFBQRjJVWGVEMmZQNGpML29LNjhydWF5cVhpUmozSi95TmFybGZRM2M3?=
 =?utf-8?B?RVBXUlNvL2lFSG5NcDBnTXgraVRsbDlUSkF3VzNXSzYxQkxVMXVRdXdGNUtZ?=
 =?utf-8?B?OFBlUDBvWVpOL1ZMTEoxMG8rSkxJTXNRdll4NkZqaTJNMUhWZzRqTEYzOEdN?=
 =?utf-8?B?bWsyanNxY0k2OXEreWdlVVhUMXB2QWY4Sk8vQnBnUVdRYTdUYXFEUXhuQmVF?=
 =?utf-8?B?Vk5zWG5MVnVQeDlQc1owUzlRc08wdzM1QUU0TDhVZURRNnpOYy9EWHdVL2hr?=
 =?utf-8?B?NGsvOWMwUWg5cDlZckpCVmJoUXdZSXgwQjlwbkxCOXBWNis5KzNyd0ZIYVFh?=
 =?utf-8?B?UDFuQm1RNnhibHlxbTMrdVltdndveWRTQzl5YnRQL3NXWWpuUUFwdkR2VTRp?=
 =?utf-8?B?c3BKV3J4TE92UVNWV29nWllPTG1mK1Q5K1hCUUZuVCtTaW1VWjlhUXFtcjZu?=
 =?utf-8?B?NFFxSXMrZ25kbW5GbUVoVnBUU0NhQURyNk9HRGUxY3k4akJhL1ZwNVQxWkhZ?=
 =?utf-8?B?Sk94T3VKUmFpdG1yOVhnbVQ3dWQ3cmo2UWRwNXhEc0l3K0JnbGRkMXRReVZW?=
 =?utf-8?B?bVVHekNVeUlhMko4UXpsUFpuTVZVVWtNRjlsL2hEZmZBOGRyMmRsb3hMNWFZ?=
 =?utf-8?B?RzJzYVN0RGZmcFNxNXN0cC9SQmlHQkptbm1kYnhJaG5iTzVLNGxQM1NGL3Bv?=
 =?utf-8?B?cC9LcEsvNjRFbnJxanRnNVppSmZIcGhjbE82NXY2cjFIRlR5MmJ1WDF4ZWgz?=
 =?utf-8?B?cjlVWU1MM1lIcFYzT2J2TS96bVpLT2lNczE2YzFhSU1RMHVpalJhZjRtQlVl?=
 =?utf-8?B?bmI2OXk4U09uT1RMZ1VJcWR5cnlMTWdKTis0c2dUbGl0QjFmVkJBek9GRXVG?=
 =?utf-8?B?SnhZTGFWaHZSdFl5bU4zMVNJbklGeTE2SEtrRkxyREFhWUtiWUFZRG9KZzVm?=
 =?utf-8?B?ZmlFTkRWVjVjQnRiZHhUdDJFdFZWdkoxYnExYVhxSkNrdFRzZ3JhUXVzMEJq?=
 =?utf-8?B?UUxEeGhRT1Bqek96SXNzM2xYTG5oSTI1ZURqdkRoTzdpWENiUTdFcHVGUTY4?=
 =?utf-8?B?U3ZDc2g3MFNFMU92NnhNTTNSc2EzL1JWNWNxWDlod0MrcHdRUU1LUnI4Z3hZ?=
 =?utf-8?B?RVZMNGN3QlArb3pCSW8wak1Takg0dzB5Y0owbDZOUXUxOExjcWFNMUZXMUdG?=
 =?utf-8?B?dGxmYkhvTlpNdXB3TkY1Mk9FNXVCeXBtVlJuY2hvUnFUR0tYY0VxekIyV2h2?=
 =?utf-8?B?Mk9OM2xsRk5QWjArOTBOUnQ2cjUxYXUrckxIOVlqSDFCUzlPOHpEYjMwYXIv?=
 =?utf-8?B?MHRYQkJVbS9KbE53Z05QWFV3eVlTQ3V4eTlTc0NNdC9Jd3RDRFpCbDErbnZ4?=
 =?utf-8?B?a2ozZEl4UW1GTlZIOEp3UW41cUx2aG80aUVBWGVlb2o1bGtnL1Z2azg0dmN4?=
 =?utf-8?B?NC9pVTJVYmtUTVpRUHRhbStrdUlQTi9NcEwxOVBNUmVKNHI0VVA4bGc4N2k5?=
 =?utf-8?B?OXVGWGJhaVNBRk5uZnlUc2xzQ0NRdnZ2MTg1TDBhVnhEdnBNMkJ2bDhYOXg0?=
 =?utf-8?B?cVNxNkJiR1pQSDhua3NqdEIwMW9kdXhTVGNpdEpjUXpwUTBNNVNBaGZ0TFdr?=
 =?utf-8?B?Zlowa2xrckZkcDFUTmlmRUgyQ2VtUHlLSG0yMSthcXRsZnErTUVSWGN2dzFP?=
 =?utf-8?B?UVIveENmSGZCS2NzS2JQR2toRXhBaSt5eEJHRWdEMHh4OU9kU0lLUW5OV3M1?=
 =?utf-8?B?V3VEcU1UWDlESkNDMmUxaHV3RUMvWXZwb3h4WW9EckpaQXl6L0V3T0s2VHVa?=
 =?utf-8?B?R1cxcDUwN1QySTFoUEJGNGRPMlJyL25TMHZ4NkFranBKSlZ3ZER5bVQyckRx?=
 =?utf-8?B?QkdCU2tmSEpXL1ZQQlUyaksydDV2ckErMHNzakNJbVIxS0dCZ05PenRkemZ1?=
 =?utf-8?Q?8f8E7nTVoZQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVQxOWpDUjQ3ZXpaT1ArTDBOamVncjdZbnhkMEU0VWIwaEdYb1drTGlldEly?=
 =?utf-8?B?V1BqQWc0K3VneEh6MG1NWTByV3VHbDhLYUlraUtNbXlGd1dBWFUxdTUyQ3Mx?=
 =?utf-8?B?L1RsVG1EMjZtUk5kWjZyYVBhWndOSVJEWHR3bXNUbEhpZnZhbTdtejg4SjNj?=
 =?utf-8?B?RkZZOHBNM0tlb3ZHblNsVUh5Ri9ZTlZtRDgwMVRaZHRFcVhmaWhpRFRKc3VC?=
 =?utf-8?B?QnljQ1JFNVhqdXNCR0JpSVd3ajcwWG9zVE0rN3ZWRHJOUU9RR0Q4UEJ1N0JW?=
 =?utf-8?B?djU5WFJYYnA1ZjM2QnpmalVIcmd5UWU0OVlDRStxaWtuRy9ZKzgrcWpHU2xx?=
 =?utf-8?B?QVVrYy95Nkc2aXpDQ0pCeE14am11UWcxd1QrYWZFRFNscHJMVFkxNTFuM0ZP?=
 =?utf-8?B?S1lxd1QwUkwzVmIyTVAyeTFCblo0VE1ITnZ2Q0M2QkgxcmU3cnRINE5rbDFD?=
 =?utf-8?B?L2V2U29HKy9rRkJwcGRqNHp2alBlYlhOeXExQ0RueHJVem9qZ3FON1l5QUVs?=
 =?utf-8?B?bXJZeDUyZGlXZFluS2NNUC9YbnhDSDhiajBSazhCdmdwQURZU292dk1qSU5C?=
 =?utf-8?B?TUZLVkVLZThGWWduL3U0akFjSjIzNkt6S1YvOERtOUJLajZub0tVam9jbm9o?=
 =?utf-8?B?U1diRmdoYzR2SWtwRG1kK01HemQ2Y3pQbGQ0U1hNZDZKMStXd043OFltM20z?=
 =?utf-8?B?Y2UyUTU2TlhYWmtWTjFDanJNZWxnNHV4OVRWSnJRQmdLVmdZaUs3dHphcmgz?=
 =?utf-8?B?UUp1Rk5LeHkrYW13UkgxMWdPKzFKSmJDcm1UYURHRkdhYmpTdXQ5dytieXdr?=
 =?utf-8?B?eG91ZWZ4RzYyZEJjRTUwUFJzTmpMZFpaMzFyWkU2MDVJaEZmSnNCSTBLa3Nw?=
 =?utf-8?B?Y1JYN2VWbkMya3QxYnlhbXZSUmo4RDRBM2wrdVcrTTREOHI2ZnZvOWNVMVdD?=
 =?utf-8?B?UXBBTk9LTnRIUDI0bG80V1YxUlNaMzJzMjZ5MEptOTNvUUxwY2RwcjlaWWto?=
 =?utf-8?B?NzB0Y3Y1U2Y4TStLUUpiQm5ZZWlkWElkSDVuRTR0Y2h1VEdPQ2hKT2t6QUN0?=
 =?utf-8?B?WTRQb2krVWdMSDlRQ29Fc1R4YXc0MnRxcHlhaFd3dGx1OUdYYmlGQUdtYmVG?=
 =?utf-8?B?V3BvMlJoNW0zRnZCR05IWElNQXhtNERjMEg0N3ZTZFlpUi9iR1VnTWRCQTRK?=
 =?utf-8?B?Sk1vQnVwdXZVTklNSHY0V3VBWlhLSURJaDBOY1UzdnZwTnAxZUlYeUI4K2Yz?=
 =?utf-8?B?ZkxzNnljZDd4N3JIMUdxY2M3K3NXMzhHaG9ISjFUU0NvdFJmb3d4bG8zTkNk?=
 =?utf-8?B?M3BVNWRoSTRDN0ViczBldDR0YlFwNzdTSmFENUVzajR3aU9UOWswRlM1ZE11?=
 =?utf-8?B?TXBoZU1aY0k4SDk1WldqZ0lXejdoNU8yNDdzak5KbFgydFdkVW9XZzl4M1pG?=
 =?utf-8?B?UmpEWnl3UmVyUEJnQ1hKbEpNZGZ5aENoeCtlK1diRG9PRzc1Smx3c3YxN2Z0?=
 =?utf-8?B?L3QrY0s3YWhuY1hDVjVhdXRSQXUrT25zeXYxeE9UdjlLN0t1Qml0dVVWdzhZ?=
 =?utf-8?B?T0FEUlNrQWExNVZpcnZzVnlJUVg3NkpkSnY1cmF2R21BZk1nZkpGNGpEY3pa?=
 =?utf-8?B?WnpoVEZOS3d6WnJ6WmNiR2pGa0Y1SGlaOW5ZZjNRZWs2YmZmUjVib3UxMSs0?=
 =?utf-8?B?dnVaS3hQSU1RNkloWWpMcmlOZjV5RWdHVnhCZm1lQWU3aHNHQVRZSEc0ZzVM?=
 =?utf-8?B?VXNEMDNZdmtjZEFCbng3dHRiTXZ3K0hBQ1M2Rld4djMzTkNUaTMvbVl1Vy94?=
 =?utf-8?B?ZGE3UFVuSEdld2NLNW11OTRJSkNxMWJjQW04QStRSmxJOGhYcTJBSGt4RDc0?=
 =?utf-8?B?clZyTU01dFZHTUZlSWlJd0RobVFLYWVlaG9IUmVmM3BPTlNIRkp4UzRyMFN6?=
 =?utf-8?B?R1pUTldCR2ljSEJqenRjSmlwbHRReWFVaFRyYzFmbEN6RWpER0dJSkFQVzBU?=
 =?utf-8?B?Wk5HbHB6bUNJUFpVS1Z6WGFGTUlEV1VaRVo1VDM4VnhWU2lDMnFjblM4Ulcv?=
 =?utf-8?B?VHdqbVZDc2YwcmllVXdXZk1MMTZzdDFudEExUzZqQmtjcHBERTZWZGV4OUhM?=
 =?utf-8?Q?bFIxMHBqbNL/QIr2b05m/38uN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82afa3f-1de3-4b94-f6ca-08ddebd87847
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:28:32.1958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1ohf7o69VC6p2pK5jz1vGDSC5onXqJnzry7w0CSLD2hoibjpda0kRn4u5QNvpB+one2+2EDRIfZsOQBs57gmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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

On 2025-09-04 10:45, Alex Deucher wrote:

> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
>
> v2: Additional cleanup suggested by Christian
> v3: Additional cleanups suggested by Christian
> v4: Additional cleanups suggested by David and
>      vm fence fix
>
> Cc: David.Wu3@amd.com
> Cc: christian.koenig@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>   8 files changed, 63 insertions(+), 167 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0e6e2e2acf5b5..7119cf658de8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>   			continue;
>   		}
>   		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence.base) == fence)
> +		if (preempted && (&job->hw_fence->base) == fence)
>   			/* mark the job as preempted */
>   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b9e2f0293d617..79af75032d0e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!amdgpu_ring_sched_ready(ring))
>   			continue;
>   
> -		/* Clear job fence from fence drv to avoid force_completion
> -		 * leave NULL and vm flush fence in fence drv
> -		 */
> -		amdgpu_fence_driver_clear_job_fences(ring);
> -
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 *
>   	 * job->base holds a reference to parent fence
>   	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>   		job_signaled = true;
>   		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>   		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 1a2710f453551..85cefbe40aef8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>    * Cast helper
>    */
>   static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   {
>   	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>   
> -	if (__f->base.ops == &amdgpu_fence_ops ||
> -	    __f->base.ops == &amdgpu_job_fence_ops)
> -		return __f;
> -
> -	return NULL;
> +	return __f;
>   }
>   
>   /**
> @@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    * amdgpu_fence_emit - emit a fence on the requested ring
>    *
>    * @ring: ring the fence is associated with
> - * @f: resulting fence object
>    * @af: amdgpu fence input
>    * @flags: flags to pass into the subordinate .emit_fence() call
>    *
>    * Emits a fence command on the requested ring (all asics).
>    * Returns 0 on success, -ENOMEM on failure.
>    */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
> -	struct amdgpu_fence *am_fence;
>   	struct dma_fence __rcu **ptr;
>   	uint32_t seq;
>   	int r;
>   
> -	if (!af) {
> -		/* create a separate hw fence */
> -		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
> -		if (!am_fence)
> -			return -ENOMEM;
> -	} else {
> -		am_fence = af;
> -	}
> -	fence = &am_fence->base;
> -	am_fence->ring = ring;
> +	fence = &af->base;
> +	af->ring = ring;
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	am_fence->seq = seq;
> -	if (af) {
> -		dma_fence_init(fence, &amdgpu_job_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -		/* Against remove in amdgpu_job_{free, free_cb} */
> -		dma_fence_get(fence);
> -	} else {
> -		dma_fence_init(fence, &amdgpu_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -	}
> +	dma_fence_init(fence, &amdgpu_fence_ops,
> +		       &ring->fence_drv.lock,
> +		       adev->fence_context + ring->idx, seq);
>   
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -	amdgpu_fence_save_wptr(fence);
> +	amdgpu_fence_save_wptr(af);
>   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>   	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>   	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   	 */
>   	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>   
> -	*f = fence;
> -
>   	return 0;
>   }
>   
> @@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
> - *
> - * @ring: fence of the ring to be cleared
> - *
> - */
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
> -{
> -	int i;
> -	struct dma_fence *old, **ptr;
> -
> -	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
> -		ptr = &ring->fence_drv.fences[i];
> -		old = rcu_dereference_protected(*ptr, 1);
> -		if (old && old->ops == &amdgpu_job_fence_ops) {
> -			struct amdgpu_job *job;
> -
> -			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
> -			 * it right here or we won't be able to track them in fence_drv
> -			 * and they will remain unsignaled during sa_bo free.
> -			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence.base);
> -			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> -				dma_fence_signal(old);
> -			RCU_INIT_POINTER(*ptr, NULL);
> -			dma_fence_put(old);
> -		}
> -	}
> -}
> -
>   /**
>    * amdgpu_fence_driver_set_error - set error code on fences
>    * @ring: the ring which contains the fences
> @@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>   /**
>    * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
>    *
> - * @fence: fence of the ring to signal
> + * @af: fence of the ring to signal
>    *
>    */
>   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
> @@ -781,15 +725,13 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>   		}
>   		rcu_read_unlock();
>   	}
> -	amdgpu_fence_write(ring, af->seq);
> +	amdgpu_fence_write(ring, af->base.seqno);

af->base.seqno is a type of u64 - but the amdgpu_fence_write takes a u32 argument. Should we
cast it? (assume seqno never overflows a u32)

David
  	amdgpu_fence_process(ring);
  }
  
-void amdgpu_fence_save_wptr(struct dma_fence *fence)
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
  {
-	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
-
-	am_fence->wptr = am_fence->ring->wptr;
+	af->wptr = af->ring->wptr;
  }
  
  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
@@ -850,13 +792,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
  	return (const char *)to_amdgpu_fence(f)->ring->name;
  }
  
-static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	return (const char *)to_amdgpu_ring(job->base.sched)->name;
-}
-
  /**
   * amdgpu_fence_enable_signaling - enable signalling on fence
   * @f: fence
@@ -873,23 +808,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
  	return true;
  }
  
-/**
- * amdgpu_job_fence_enable_signaling - enable signalling on job fence
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_enable_signaling above, it
- * only handles the job embedded fence.
- */
-static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
-		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
-
-	return true;
-}
-
  /**
   * amdgpu_fence_free - free up the fence memory
   *
@@ -905,21 +823,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
  	kfree(to_amdgpu_fence(f));
  }
  
-/**
- * amdgpu_job_fence_free - free up the job with embedded fence
- *
- * @rcu: RCU callback head
- *
- * Free up the job with embedded fence after the RCU grace period.
- */
-static void amdgpu_job_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
-}
-
  /**
   * amdgpu_fence_release - callback that fence can be freed
   *
@@ -933,19 +836,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
  	call_rcu(&f->rcu, amdgpu_fence_free);
  }
  
-/**
- * amdgpu_job_fence_release - callback that job embedded fence can be freed
- *
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_release above, it
- * only handles the job embedded fence.
- */
-static void amdgpu_job_fence_release(struct dma_fence *f)
-{
-	call_rcu(&f->rcu, amdgpu_job_fence_free);
-}
-
  static const struct dma_fence_ops amdgpu_fence_ops = {
  	.get_driver_name = amdgpu_fence_get_driver_name,
  	.get_timeline_name = amdgpu_fence_get_timeline_name,
@@ -953,13 +843,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
  	.release = amdgpu_fence_release,
  };
  
-static const struct dma_fence_ops amdgpu_job_fence_ops = {
-	.get_driver_name = amdgpu_fence_get_driver_name,
-	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
-	.enable_signaling = amdgpu_job_fence_enable_signaling,
-	.release = amdgpu_job_fence_release,
-};
-
  /*
   * Fence debugfs
   */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7d9bcb72e8dd3..39229ece83f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
  	if (job) {
  		vm = job->vm;
  		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->scheduled.context : 0;
+			job->base.s_fence->finished.context : 0;
  		shadow_va = job->shadow_va;
  		csa_va = job->csa_va;
  		gds_va = job->gds_va;
  		init_shadow = job->init_shadow;
-		af = &job->hw_fence;
+		af = job->hw_fence;
  		/* Save the context of the job for reset handling.
  		 * The driver needs this so it can skip the ring
  		 * contents for guilty contexts.
  		 */
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		af->context = fence_ctx;
+		/* the vm fence is also part of the job's context */
+		job->hw_vm_fence->context = fence_ctx;
  	} else {
  		vm = NULL;
  		fence_ctx = 0;
@@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
  		csa_va = 0;
  		gds_va = 0;
  		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_ATOMIC);
+		if (!af)
+			return -ENOMEM;
  	}
  
  	if (!ring->sched.ready) {
@@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
  		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
  	}
  
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
  	if (r) {
  		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
  		if (job && job->vmid)
@@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
  		amdgpu_ring_undo(ring);
  		return r;
  	}
+	*f = &af->base;
  
  	if (ring->funcs->insert_end)
  		ring->funcs->insert_end(ring);
@@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
  	 * fence so we know what rings contents to backup
  	 * after we reset the queue.
  	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
  
  	amdgpu_ring_ib_end(ring);
  	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 172620880cada..55c7e104d5ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
  		   ring->funcs->reset) {
  		dev_err(adev->dev, "Starting %s ring reset\n",
  			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
+		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
  		if (!r) {
  			atomic_inc(&ring->adev->gpu_reset_counter);
  			dev_err(adev->dev, "Ring %s reset succeeded\n",
@@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  		     unsigned int num_ibs, struct amdgpu_job **job,
  		     u64 drm_client_id)
  {
+	struct amdgpu_fence *af;
+	int r;
+
  	if (num_ibs == 0)
  		return -EINVAL;
  
@@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  	if (!*job)
  		return -ENOMEM;
  
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_job;
+	}
+	(*job)->hw_fence = af;
+
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_fence;
+	}
+	(*job)->hw_vm_fence = af;
+
  	(*job)->vm = vm;
  
  	amdgpu_sync_create(&(*job)->explicit_sync);
@@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  
  	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
  				  drm_client_id);
+
+err_fence:
+	kfree((*job)->hw_fence);
+err_job:
+	kfree(*job);
+
+	return r;
  }
  
  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
@@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
  	struct dma_fence *f;
  	unsigned i;
  
-	/* Check if any fences where initialized */
+	/* Check if any fences were initialized */
  	if (job->base.s_fence && job->base.s_fence->finished.ops)
  		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.base.ops)
-		f = &job->hw_fence.base;
+	else if (job->hw_fence && job->hw_fence->base.ops)
+		f = &job->hw_fence->base;
  	else
  		f = NULL;
  
@@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
  
  	amdgpu_sync_free(&job->explicit_sync);
  
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
  }
  
  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
  	if (job->gang_submit != &job->base.s_fence->scheduled)
  		dma_fence_put(job->gang_submit);
  
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
  }
  
  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2f302266662bc..d25f1fcf0242e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,8 @@ struct amdgpu_job {
  	struct drm_sched_job    base;
  	struct amdgpu_vm	*vm;
  	struct amdgpu_sync	explicit_sync;
-	struct amdgpu_fence	hw_fence;
+	struct amdgpu_fence	*hw_fence;
+	struct amdgpu_fence	*hw_vm_fence;
  	struct dma_fence	*gang_submit;
  	uint32_t		preamble_status;
  	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 0704fd9b85fdb..5d44f1354c8d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -147,16 +147,14 @@ struct amdgpu_fence {
  	u64				wptr;
  	/* fence context for resets */
  	u64				context;
-	uint32_t			seq;
  };
  
  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
  
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
  void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
  
  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags);
  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
  			      uint32_t timeout);
  bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a42..76bae546df11c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
  	bool cleaner_shader_needed = false;
  	bool pasid_mapping_needed = false;
  	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
  	unsigned int patch;
  	int r;
  
@@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
  	}
  
  	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
  		if (r)
  			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		fence = &job->hw_vm_fence->base;
  	}
  
  	if (vm_flush_needed) {

