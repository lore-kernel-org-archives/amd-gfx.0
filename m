Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB635CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CAE10E8EA;
	Wed, 15 Oct 2025 20:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2lLG21Oe";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DFA10E8EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 20:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6I02GRKNMil8lqAgQ3qnuZbQFBrGpMMVu56wtyi3xpIhoA3GkIYRm3m1djDOXEORonZc6fqqTsp2MJNnon6VYNnt6ki6XEo9XndG9iGqfyNZDFGKs9rajRcJg2aTQKHLasuGDWvv3SK/oU73Wk9jSCwjJj1ZPg3QzemlMDzR242wyItrogNtDdwGTkcdgNrazez/0J5KZJRqoGFTlQ/nL/9SwUgVZdxDukLHQg/UdJSjQdAyFdRjXLNwe6gD41IVMqAhfA7Icg3trYYxvmh2S3OD31GJ6mwlxrHwQBsGQy5y/e7Kfngtj9ODgSsaqnnNc2gkkbRb7ntvmtkfDSKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ddMflmSkvEHbuWgMNlaqRcdMs+EdIgfYJGuo7d1JM=;
 b=P+gz+MvJ5rFKJBTZQkvEE27sl+2o/oKU0dpwC/rw7nLyFUhKjmfbmN7PLgouVjJKG49WXM6H9q/nxkjLdNj3mV+dWl7z1oyhOrMx2RqltlUdc9v7GWKGw5HMSg89eqPfYyIKUnWwltfhe97WwglzJOdIV/k5DeSn00eKsNKlFNQxVcTgcATodAxmqkP28E7RUrIUmHlO0VyvAGKOd3dbLPVuS5ZlgHGyxmGI9LYrseuNYA4cCtU0m2ILP4jXkK4YEGfBFCfD0FztVXblr8pIjPvmVXnH/451GX9J1kPqdLbU2LQRUkpjczHchOr4UijpAUq3g1jbezOSX8aR4nrs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ddMflmSkvEHbuWgMNlaqRcdMs+EdIgfYJGuo7d1JM=;
 b=2lLG21OenNv0IOAkPk9Egsd/XYw0TTjYmNz11Qw/R5FHSH+ZWKsQCdo0Q2r4X0rHFZhatWqtxEQCjQz6DBdfYcLmUoWrhYUOof8QbSd6YdjcohJjcJqOUvmKIlawjQjL22xpZrUfexiIYMD4PIVZoPj9cuzomG5jdt2QMMME/7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Wed, 15 Oct 2025 20:40:25 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 20:40:24 +0000
Content-Type: multipart/alternative;
 boundary="------------fICO8bHvqIDRBs93uHDdzKHk"
Message-ID: <29dd1aad-26de-49ac-9d25-c3dffa862705@amd.com>
Date: Wed, 15 Oct 2025 15:40:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm
 released
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251015201134.2540-1-Philip.Yang@amd.com>
 <20251015201134.2540-2-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251015201134.2540-2-Philip.Yang@amd.com>
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2b44df-cc88-41a4-c848-08de0c2b1153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWtrWjd5UlhmUis2Mit1YmxuVTFVVDFDZU5HL0hzRFo3dy9McU0yZ0M3cTVo?=
 =?utf-8?B?T2ZXTmxVcGQ0ZE9heGJDM1h2UDdLOWxCRk0zWnpPcVpjRFdDNTBidUVXWXkw?=
 =?utf-8?B?djhYWHc2aEE0TUtUZFVSUU9FWGlPUGd4bmp4YmlUTkVkd2RBTU54UlovSDZF?=
 =?utf-8?B?cXlweHlJN2ZyVVRmK1AzcWRhWWo2N3labWRtcXlSVVdBMmpOT08xQ0F0MmI0?=
 =?utf-8?B?UmRJN1lFTjRMZG40NHRDNFZRNDBrZGVLMHNRZyt3SG1OaTFveVpqck0vL2Q2?=
 =?utf-8?B?UDg0bHlHUjFuRFphdGdjbndIUEFsWDgyR2tKdEdEUzZCTzdRNUFCanpZc0Rp?=
 =?utf-8?B?Z0VMR2lObWxwL3NJaXNHNCtpSTJpM01aZHlQZW5tWnlwOUhsVm8vRDU0RHND?=
 =?utf-8?B?RGZQUHpLcFhaY09MYThtVFJ0RU5vaHEyRmFvMlNtR0tkTmZIeCtrMnUwQzZO?=
 =?utf-8?B?TlpNZlVrUDVWM0tEMkdsb0ZielBFR0Q4MVhxWkRORUVkQm51K29Ma3BnMDBq?=
 =?utf-8?B?TGsrajBhWlJGNmFBcHp1cVgzcUw3aG9MUXBNMWF2ditQc1VZclhQQWNjQUVD?=
 =?utf-8?B?MkFFaVd4ZGZ1Y2lueFA5SnU2UHZDdkltN01hUVNsajBsb1J1dUZsM0R3OUtR?=
 =?utf-8?B?SzFxL2ppcy85REdNS0JtRkswYkpsWlpXWVJ0L3cyNmtuTmI5L3hCS2JZRVA0?=
 =?utf-8?B?UWZVWkpxd21xbVlwOHkwcnpSdjl5a1R2UWE2WHlhWmZmbkJTQ1Z1WXpZSDVm?=
 =?utf-8?B?VEpmMTFYQkgveCtpTnhNRzVrT0ZnNjNReWxDWnY1ZU5VL2tIeU5FcHRIQ3c0?=
 =?utf-8?B?N1UvMm5DS0tKTGdBZDhndGtPendjRFpFd0V3cmdyNHVZcm1FN0p5cGpjdE5o?=
 =?utf-8?B?a2E1VFpGKzJkcmJPSUdXMVNvaVhuTFJwMW1oRUlVNEdBZXkwbVZlc1RPelZN?=
 =?utf-8?B?TEVDSm5uTUI2a2ZBbXc3eE5pcUphWDdISUczM1lEYTVuSDA0VlpSZFNLUVRk?=
 =?utf-8?B?UGNJTmpsMGczNzlERTlIYjhsL3NGTTRQaXBDSEt0MHRHYlUrRDZkR2g3R01k?=
 =?utf-8?B?dnJSUVhaVVE5RjdudTRpMUw4VHIxcGZiM1gzV2EzNVBFQnpiQzQ3QStETlZ0?=
 =?utf-8?B?cUFtamdXZnpsU0k5VnJlNTJHMTBPVHZEUjVPNG5yblNZT0NmMjkxeURaOVFs?=
 =?utf-8?B?MC84U285S0FXSEMxekhxZTBJdGJMWHNsQ3N5Um9RUVEyblNEZVdyMnoyQW9O?=
 =?utf-8?B?akppOTBjbjFOdDJmcG04ckE3R1owY01yZ3VYajdyeFFua1YvYldJYkdqKzE1?=
 =?utf-8?B?M2FuOUFYRVVSWTJuYkQrT2txdmVsQ25yY1BjL0pIOHc1MlM2NVZqNytTdTcv?=
 =?utf-8?B?azdGa3JUQmxuQVNRYUhnYXZMK0w2RWZVR1R1dVp2RTNhTmo5NlYvcEM5bWg5?=
 =?utf-8?B?VHh0T0IxRWU0Z0xVajI2ekFZR01GM0FqS0c2TzA1U1MzQ2ppNWNrRnZSOGlz?=
 =?utf-8?B?SlJQenFyMDBFUGtHZTVEZDNpaXF0cm9PYkJ3MllicjVYQ0lmWGtrVHVqQUQ5?=
 =?utf-8?B?ZEVnS29qRXBmcGxFOFRzSTNDZk8vM1FuYkFiUEpTMExaSjM2Z2kwSTdKSUt6?=
 =?utf-8?B?V0xzOGNsWkN6NFBuK05DL1Jqb0QrTW0zcHNlV2VZV3d1UE94RWNBS2dUdzNL?=
 =?utf-8?B?QUJnVk0wd3k2czlSQVFvRlBlZ3BROEdvY1VacFJ0UExZcjAwQTZ1RU9QdXpM?=
 =?utf-8?B?T281ZjhBQnE2TndjdE1oTDFyMVE4dFBRZ3BRQ2g2Z1pOL1NoZW10REgrSktC?=
 =?utf-8?B?UXdTc1A1UUNNMHBJazlnWnpkRWcwTDBBZC9VclpURGFXNTltNEJBVE00RHE5?=
 =?utf-8?B?QzlMb2pWK1VBYjlubFhBZ3FrVzU5ZFlieHhweUdWSkl5UGI1bThTQXpKNUg4?=
 =?utf-8?Q?OmM1J9Q3CpsCqF8auw0x7dWpR+wKvqEC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhQK1Q2a2psVE9pRFVhR0dtc0ZjQUludUkwd3h4ckVYbmY5M1hoeENuUnB6?=
 =?utf-8?B?TDVOVnYxQk0xWFQybjhsUmVvY2xrUWZNR1Q0R01MbWJMUk0ydFkvMkJZalJu?=
 =?utf-8?B?WEJYQ3l1d1NvSzFZSkZuSXF0V0x2TGp0NU00Uk9KZXNoeHYxN3Y2ckZvNWlR?=
 =?utf-8?B?dEJZeGIzeWliOWY0NFJ2QzdxR0srbStubGlLNnQ2QmRnQXpub2JUVmlkRVMv?=
 =?utf-8?B?bGJ5WHlpUmE3VVpLM3dHZkpYb2NHUkRtUmpDVEJBVXJJdEZEQkxhZzlMK3g5?=
 =?utf-8?B?cy9DckNmWjJRR0ZiQ2hyUHMrcE1nR3ZaandKL1M2RThYcXBRNmRacXhtTUZY?=
 =?utf-8?B?azc0c2tQVEdQaDR0dlhZUGIxSkJHZXhVMGhFQStnUG5KbUc5VWpSdTFXTEY0?=
 =?utf-8?B?NTBpUHdvV0N4YTlXajNJY2hSNXRRQ3NDby9Hb0xqTFY3T1BheVNmMHhlOGg1?=
 =?utf-8?B?MUMvZlBzMlpwd0VWMTRCTVNPaDhsby9hTEZUTnJFdURMeUcxVTdsTGNwZlhF?=
 =?utf-8?B?Z3p1MXh3RUhoNjNXSVAvSTlPeXRUdThmUXIrTFJKTGUremFyTGxIRmhuK1lS?=
 =?utf-8?B?bHBTZ3BUanZxM05GTGNhNGJtWE1YUE1GVHFLVHphbWRrWnpvUXZEWnR6ZHZ5?=
 =?utf-8?B?ei9aaUhuNkJwcTVCV2s1UzBQNW1neTBIU1FOc3BLcXJCSUhEbXpLY053UGFa?=
 =?utf-8?B?cXNJaXEzQzhNcEpkeXZpOG1rMkdaZjVTTTJiYnFYNDNETUxSREFnMFMvcCtF?=
 =?utf-8?B?VEt2NVd1NldtRzBFVVREdkxVSFZhM1BtM3Y1cDlWempHbUJIb24yTXp3SkZ2?=
 =?utf-8?B?Y3l2V2V3bTJrWmM3bTZJVUI0OE9RT2xLQWRJVS9kRHFBQmNvVUVSd01MRGNm?=
 =?utf-8?B?NDJESWFDbFMzM3BzaW1sUG9oQVRHWHFtODNwZ2hOREFlZ0Ezb0F6NExtanNo?=
 =?utf-8?B?dmdtdTlQV0hGeTdOZVRyUWpoOVZ4citkdURPbjh5d2pZZjBFVk9RY1Q4Qkdu?=
 =?utf-8?B?bDdVVTRaRzlJaUNoZmppZWpKTnpwVmZtb1VpaFo1UGsxS3VKRS9sb3lXRDdR?=
 =?utf-8?B?WDBuMTNkN3dIRm9pUDRrZnBBKzdPTVJQTXpSU2JuS1l6WWxzOHdScjJ0RGFP?=
 =?utf-8?B?cEhrbTZLQWI2ZXUzUFNCdWozUVpqbjBrOE9zV00yNDFwT3pnYzVsMlRsVWpH?=
 =?utf-8?B?RWU2WHIxM1BucUplY01CeEx4aytJeXc1di9mTHk2L2pkWERIRDhPU2hxeGFY?=
 =?utf-8?B?Z1pLaW5nazVISzBpVmpyMW1IREVHZFIvOXVlQ0ZlL0F2WU9Od0ZjNWpCVVNI?=
 =?utf-8?B?cXpHS2RyL29neXVEblQ5dm1aN1FpWHliU21XZnE3aS93UjFUVkhzcTdQeXV3?=
 =?utf-8?B?Nk9mOUtmK3IyMXVKQ2wva3h6eHArYVlpcVFSUzZJekJYMmFLdGFvNkpuYWla?=
 =?utf-8?B?N2E3SmFuSmFwalFFUXBvZ1dObHp3QmNzSytFVDlDS3NEMlFLcm9HTnRWMmYy?=
 =?utf-8?B?L2ZndllURlY1bGJBamlwL1pUMG1HQmFibStQeXJhVEpvS0VPZGpBVm95V20y?=
 =?utf-8?B?eW42MmNnejVkMXNVM0Z3YXZ2Tm5PdDFXLysxTmtwcW1MMFpxaUtGZExwZDFP?=
 =?utf-8?B?d29hemY0bTlybzY3d09ENEw1QnRRWVFSUVNoV0c2SGx6Y1g5YTErODB5VWw5?=
 =?utf-8?B?cnJWVG1hQjhvNk9jS3Y5RjY0TnY2ajFlTnlCSDEveDh2ZU1mdlppZG14d0Rt?=
 =?utf-8?B?UVlSdVVQTHdnTUIrczE5OW9uZ2hYWC9xZTZ1R0kzTFU2WWVQQnB5a3dZc0Fh?=
 =?utf-8?B?TnRNQ1I0RCtGNUNDOENEVThFeVNqK0dQcndmNFpEdFZQM1RPNHArRisyNGl1?=
 =?utf-8?B?dnlwM0xRb1dJejE1L3VYV2dwZVFLYnJXWEtjR3VVNjZzUmZZN2xXeG5GUWZN?=
 =?utf-8?B?b0NDUkJNSUVJQzhNbFBSSm5ZMDVHNGlPc2VjLytiWWdjdzBCaXZ3SlBJS1VW?=
 =?utf-8?B?QnpkV2FwL0FveVFFVHJzWngxL1N6TGNFTmJMYW5kT1VheGM4TDFpL05VNkxw?=
 =?utf-8?B?RzFmak5uTjFoeUhEc3NIVDJXdVo2YkJ5MTg2RlVmQ3gxN00ybEhKK1pHQTM1?=
 =?utf-8?Q?TZrA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2b44df-cc88-41a4-c848-08de0c2b1153
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:40:24.8556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upbAx534+UtuI4AAh/wmmxVuddnV5Q2D2EMvk/MV/pnWWAw8nPu9WMGpC5XlDTks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

--------------fICO8bHvqIDRBs93uHDdzKHk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/15/2025 3:11 PM, Philip Yang wrote:
> In mmu notifier release callback, stop user queues to be safe because
> the SVM memory is going to unmap from CPU.
>
> Suggested-by: Felix Kuehling<felix.kuehling@amd.com>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0341f570f3d1..e2a0ae0394b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
>   
>   static void kfd_process_notifier_release_internal(struct kfd_process *p)
>   {
> -	int i;
> +	int i, r;
>   
>   	cancel_delayed_work_sync(&p->eviction_work);
>   	cancel_delayed_work_sync(&p->restore_work);
>   
> +	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);

Use warning message or debug message? I saw this WARN are used several 
places. If the queues from kfd process p are still running when come 
here we need to stop them. It is not error. debug message is more 
suitable I think.

> +	r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);

The evict reason KFD_QUEUE_EVICTION_TRIGGER_SVM is not good here as it 
is general kfd process release. Maybe need another enum value.

Regards

Xiaogagn

> +	if (r)
> +		pr_debug("failed %d to quiesce KFD queues\n", r);
> +
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
--------------fICO8bHvqIDRBs93uHDdzKHk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/15/2025 3:11 PM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251015201134.2540-2-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">In mmu notifier release callback, stop user queues to be safe because
the SVM memory is going to unmap from CPU.

Suggested-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0341f570f3d1..e2a0ae0394b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
 
 static void kfd_process_notifier_release_internal(struct kfd_process *p)
 {
-	int i;
+	int i, r;
 
 	cancel_delayed_work_sync(&amp;p-&gt;eviction_work);
 	cancel_delayed_work_sync(&amp;p-&gt;restore_work);
 
+	WARN(debug_evictions, &quot;Evicting pid %d&quot;, p-&gt;lead_thread-&gt;pid);</pre>
    </blockquote>
    <p>Use warning message or debug message? I saw this WARN are used
      several places. If the queues from kfd process p are still running
      when come here we need to stop them. It is not error. debug
      message is more suitable I think.</p>
    <blockquote type="cite" cite="mid:20251015201134.2540-2-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);</pre>
    </blockquote>
    <p>The evict reason&nbsp;<span style="white-space: pre-wrap">KFD_QUEUE_EVICTION_TRIGGER_SVM is not good here as it is general kfd process release. Maybe need another enum value.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogagn</span></p>
    <blockquote type="cite" cite="mid:20251015201134.2540-2-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	if (r)
+		pr_debug(&quot;failed %d to quiesce KFD queues\n&quot;, r);
+
 	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
 		struct kfd_process_device *pdd = p-&gt;pdds[i];
 
</pre>
    </blockquote>
  </body>
</html>

--------------fICO8bHvqIDRBs93uHDdzKHk--
