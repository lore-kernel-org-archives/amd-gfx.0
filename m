Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71D4CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 10:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5686410E251;
	Mon, 25 Aug 2025 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3K7vkHe";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5347E10E251
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 10:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8ZzGjDNJ+GfB1UrLmLh8ytiXTzBhDFbkp8cu27dScnIF5s14AEDyJIy5ooqWjBi8ivFfQOnbO1ACaywwG2BHAokkOMF4R1WwTPDOjoq4rj5RxUCSFq2Q4KseqFSfsGT39HHy3LLAMz6rQGY5OEytsJTSysye3/14C72E928tkUcig2Ifvl1UXythnDQG731it+g27ulCH16dLc0Or9kdCDv2/zi2XcZ1XPJ/gFc/O5FKXvPxzZ0kqF35aUQC8Sexnz3WTFu5PLTnoODJ+VTqDmprKd7upjG33PQ0dBRQ5e3BxOu+dDkEcioji5QA+2r4LDjEDxmASJvUCAz/vot1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA5o1E8F3Mq5YAqL/80o4Jv59ANlSYMIR958FallmKo=;
 b=NYEma+LzIwIEnb52VE81FpzghqcXHtvvLpuZYTlOvmLycxkPC1ZEmq+wcSIComB6XBWHdOk6pL9aGpxrHROftc+ENqLovlgR2R4TuBLCQUcFR/cE4wlNA2q357PNl9OzRFiPeRk8l/83MwApY8pD/aAyOuzlrMhxPnGXCUMc4JPJyYXOqMp6y28J0oaQ6N2KFb/dvi9dGmuR7rDGwhdKDbutDlYEQELVMGNDLZW1Z4vhTmxqkaHSk/+ufxR5D966JmjOVpnmXkd3QpdZRI9cG1g72cDN3lSL3UPDMJdWFfki35xjGjAtbHQBggDrLtUbL9sRs88vGLVFqM94k/Gkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA5o1E8F3Mq5YAqL/80o4Jv59ANlSYMIR958FallmKo=;
 b=d3K7vkHeOXJ2RKZB3e7MFKK0tOhkec5l78N8LKjFDqB+/DjfotYraK/z12m81YxU1VDdrmkG6Kvx0Z6kgXNEQP3vc4iFDsqDfl6Ib6NOdJMZyfGY9ZW6raiBngj7kiw/I7GS2tJKt4HRyuYjszDxuD8yHC1LZMoxo+eblVZggos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 10:22:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 10:22:29 +0000
Message-ID: <aef0cc62-cea9-48ab-955e-033ee8b173ad@amd.com>
Date: Mon, 25 Aug 2025 12:22:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/4] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250822194749.362771-1-David.Francis@amd.com>
 <20250822194749.362771-3-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250822194749.362771-3-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: db4e9302-af2b-4d16-781e-08dde3c14b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWdBT2ZaSWFSVHhFcDhISFcySVBKTDNpOXN3cXcraS9IVnBPeGI3WDJNM21w?=
 =?utf-8?B?TXlqSXpjSHVHYWJlL241di9EQTZwKy9tNHg1Q0JkazFISWQ5bnh1UEc0T2FS?=
 =?utf-8?B?UnAwUTJTdG8wYlVHYjRONEdlU2FQZzI1SzlKVUhLRTZEWWkxQUJmOTNIK1p6?=
 =?utf-8?B?cko5ZDhLM1NMR1ZFZHc3U1lIRU5ES3YyV2tBVytSVTZqQ0FXdEZLK0wyQmJK?=
 =?utf-8?B?VnRtdlhaenhTWFVCYmlhT2F0L3NvTWU2UEszS3RvVWxIdXk2M1VGWTFtdFBR?=
 =?utf-8?B?cUtyVmFWb2hpL3R0WW1aNE9pcjRHTkxIVUdTQ0NEcTAwT2s5WDNZS0FsNVMw?=
 =?utf-8?B?WkpYOS93ajVYNjFaMXlpNHM4TGg3aVRWM2hqK0Z1UDRLRGNoM0szY2RIcitE?=
 =?utf-8?B?RW1iNmNFNTlhK2I2b2JpN0JWZUdRM21neitFOGxJTnl5dGl2eEpYQjRTU1lC?=
 =?utf-8?B?NnBPYzBjdnhZR3Y4ZnVpT0dWSmdNdmRQY3RSSFY4c2lXcUFTSlhzZXc2bnJR?=
 =?utf-8?B?d2JKK3MzSHRCSXNxREtmOWdRNnZ1VHRzMTlkdW1HV3Y2NTFEeVBwUkU3ZDRR?=
 =?utf-8?B?UjIwNlFpdXBUNXRhOEdwczlvbWgxSDFHR1AzaitTb0RGeGxQaHFEQStoOHcw?=
 =?utf-8?B?dGVVeHA3am9FazEyRElMN2dGTk9Yc2dJcm1uZkFMTGxnay82b1M0TlpXczlS?=
 =?utf-8?B?TUdhREdHcGRVYy9UY3RIVmNacnFDc2t0Y240MVZGN2dhV0lQME9WZ0pMdGoy?=
 =?utf-8?B?NGtrVG02eFVuRmp6cE5pWFJ5RmZheWxWcFU4dkdoaTV1SmwvU0h3UlRGdGpr?=
 =?utf-8?B?TGpuSzBxZmEvMHhmNlI1YzBGMGtndC91UHJQejlVeE1EMHFQTEZUVFhMUUpq?=
 =?utf-8?B?R1kxbkZmQkR5Y0NWNG1sL0FaVkhxelk5SFczQXo5TjI3Sk5GVVByTnRzWUtQ?=
 =?utf-8?B?QUFtUjg5T0hkTjhLbnQwMFV3WXBLb2w0NE5RZm13VjF4dHhVbkl0WnRKSENW?=
 =?utf-8?B?UU0rU3hsV01OejRXZm1Ja1ZKdFF1MFFTcVJGWmxSNTV2UHdueUoxazJLTDlt?=
 =?utf-8?B?cHMwbGtVTnQ4N0RJMGpPb2M5enhaWmtPSGJrdnl5TkNDL1Q0R2w3eS91TE5Y?=
 =?utf-8?B?ZDI4TFJjLzVpSHdrZHZGaVc5M0ZhQ3pwOWJGRGlUWUJNU0tmM21JcHNvYlhl?=
 =?utf-8?B?RHlDTHRGd2M0YThrd3lyd3ArMWlRRXJYTTBvdVZxNWFRZ1BnWWdpd01YSDRu?=
 =?utf-8?B?TVNCSnNiU0xyUzFDbm1kMWszMWhPbWNoeVJkc2ZmYVFlREtCNHpTY0Z5YnE0?=
 =?utf-8?B?aG1iaW5ZdVppdkZSaklHbFA1QkxDMTA2cjdTN1BKZGlnQStaVzZ3NW0wZFhs?=
 =?utf-8?B?OUlpUVZEQURMMVVacDhKOG5nRS9ycVAyTThpMjJ4SThiRDJ5WmwrTXRXQ29K?=
 =?utf-8?B?YTdBc1pBUjZiYzV3d1RxN3pjZXZhVnk2Yk1QakpNVTVlemlHdEdhOGpPNWNs?=
 =?utf-8?B?MVdLK1pLdURuMnZhM1VjUnNnYUtzU21KZWZhMXBQQTFZWmlnZUNqa3RsWVhX?=
 =?utf-8?B?K1d0U1BjLzVpdG9pVnJKYnRBT25RVnBLOE1mck1vZ01BRFg3b1d2L041MWMy?=
 =?utf-8?B?WmhXckY5V3VmSWRoN0duQS9DTVhUeFdac3M5T3dkeHVTS2VONUZXL25VNzF6?=
 =?utf-8?B?RXBlV0pHTDJuUzh1M3RMeEZtTkx4YTduaDNUeHhpNkx3UE9vTWZRMm9uN1M0?=
 =?utf-8?B?THFsaVhqMnoyZkczVzliYi9EUnFRVEdBZ0psMjBKMzhYRkxHaUFRdkcxK3cz?=
 =?utf-8?B?RFVwUEV0TGIzSnJZck91OFVyYmRWOEZoUXN2Qm1OcUFISFgyeWtZUzlLYmFN?=
 =?utf-8?B?eExMazN4OTk3UEs1WEgrdGdibmF4UjBrdy9PNTJuZU40RHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBSeEREMmRPQms5L1JLMDRPTlQ2SEp1SmNjQlh1ZFQ1cUdzMXJCZzZNT0hI?=
 =?utf-8?B?TTRkUjRoVVloWWF0bStnQ1BiN3VuZjJidjROMTlrTkloRzAxZnZOZ2wvQjds?=
 =?utf-8?B?dGd2SFp6MGtwb0VHT2dKZzBNWW1rZkgvK1ZEMmkrdDZVdWh0dnBuMkh1S2pF?=
 =?utf-8?B?ZHhTOTM2Tjhva21PVHZQYTZaaEVPREpUdy8wN2VyMzZHUlNuT2dGK3kzU2ll?=
 =?utf-8?B?OFVMRHh6RFM5VVowV1Zwd3RLWE9nQXg0MWg4MmkwemwvYWxnZE80ZmJCaGIr?=
 =?utf-8?B?UE5XM0lmc0dzU1Qya2hlSFpHd2pmbVU4V0ZWRzRMNnBxYnZYQmtyU1VUVG1C?=
 =?utf-8?B?bE5yMmtkd3A5YTc4Z1RQQVNURVdwSVRpWkpSU0V3NW96OFpIQTIvSklDK3RM?=
 =?utf-8?B?aG9HaWxwNm5Ca1Q3QzFOa0JuQTNlcWt6dU9EQWhLNER1ckpZVDd1ZS9MM1Zl?=
 =?utf-8?B?TlRZaWNiR1hvNFk4YnJ5STBvek1mcGMwaEhTOHNiMC9Db2UzRUJlWnRJZnR6?=
 =?utf-8?B?SHUvb3JnUWVoT3ExckQ2dndjWU1DZlFnejBWVk9vV1NVaU5ZMCt6bENlZlR1?=
 =?utf-8?B?VnVXZEpVQkhLQXJOWjhlaDNqM0ZiaUl3TVhGWHE0SERvWnJnbU95QlBPTFFF?=
 =?utf-8?B?QjllZEdoVnIxaDRkZmpLZXBWMmJpUUZsbzFacUN3SU1rTFNBSVI0VDBxMFhw?=
 =?utf-8?B?OVNJMDc2QnYwRTYrV3MwOTRlZjl4VzFISkhaVzJRREpDKzlUa3NRYnFEVFNR?=
 =?utf-8?B?V0VoaG8yS1ZZZHZhaUc2dmdGTUc4UjM5bk1xbEozTEkxNHhWZS9oWDNhVGhn?=
 =?utf-8?B?R1lqOFRlTm9PSEFrbU50Z3ozSXd6Y0lRT3pUSzFWM25xTHF4RmhtRi9PSnNa?=
 =?utf-8?B?Z0FqOTRzK3FQS2tKM1U3NHVwRUY0R2JlSkd2bGUxZkFzRmliZ2daeUNGTGlQ?=
 =?utf-8?B?eUJaTnZ4TjYwR09DYkpBdnJsa3RJMGt2TTNVRHVDRGRKSUl4RURMaFBDbUVE?=
 =?utf-8?B?S1NzYmRITDkyeXRxNkhoTDhYcFpHVUthd0tSRFM0bXU1cStnYkVwVDhHSmQ0?=
 =?utf-8?B?MWFNVDcxeUZNZmxVODFIS2YzdU1LNm1uWW4vS3l6NXFURlYvZjNtaFdtdWFE?=
 =?utf-8?B?ZzNZMzJNb1krUjRRcy9oQ09CQ0ZBcTdNbExwY0RKQTlnS1Fyb2tyZXpvUStp?=
 =?utf-8?B?M2d4SUljTnJoUzA3c29wcHpJc3FUSXY2Q3pCWFBkamJYaGdkeEk2NDNlMm50?=
 =?utf-8?B?NExkRVkwY3ZVOHRuZkV1VFlZalk4czN1SEd0dW5TTDFtekNyWkRQR1l5czZp?=
 =?utf-8?B?N2tvbFUzNk9PTEl3OXB3MlRhOXZwcWhVcllycU1La292Qi9XUjg2K213V0xv?=
 =?utf-8?B?Y080c0hHcmhoaVlJaHlkRVRFNksrZVRUaTl4OGNmZkkxNmM5TnJUYlpDTGsx?=
 =?utf-8?B?b1BvWHUrZEVxb3ZvTTNzeUx4STdtakk1Q1RSdEZidVJzSXlZQlNTNXhvTkNL?=
 =?utf-8?B?YUJzSVFIUk1iclBLa3lNQ09uNnBadWwxMUNQWXRTUk9kV3lPTjE1dm9CaEFV?=
 =?utf-8?B?Z0xURk9tQlhiK1drM2R3WUR2UmpyS25xU0tVR3BZampJb3BaR3NEcWk4K0hM?=
 =?utf-8?B?bjdiU2VoM2szUDRTNk43M2ZPZHF4ZEx3bUNhaEZzL0ordGxMRXFVZytSMzl3?=
 =?utf-8?B?dkJuU2JlS05sYmk5NHl4NkR3V0t2YUIyTEw2ZE4ySnZPa2xQWFA3MndwTXVj?=
 =?utf-8?B?OG1pZ25FSzJvYzRhOWRydGtPV3NtbytHNGFETEhrajF3R1FsNGZ6dWZjUTlW?=
 =?utf-8?B?a2hnL0FZLzM1SjdoeG1pdXQwUjBKVWg5UEdsQzljZ0d4WE56TkVkdWxFSmQy?=
 =?utf-8?B?Q2NydTVEL2Jra09RTlNGaEFWN1g5SjlSMXdISXMxeFV0M2NhSHFnSGlNR2Yw?=
 =?utf-8?B?aUkrODg2M3A2WE04d0wxQVB2QTJEZ1MwemcxMlc4cGlsakhiSVRzRUFQVmM2?=
 =?utf-8?B?S25mVzUrTkRvTnU1WnkzTEd0ajUrYmtKbDRLd1h1enBIUnBEQjNVbzIwdVBR?=
 =?utf-8?B?Y3VKSVVLaUk5T25QeDdnMUhnYVJjVFhjdDBVWENQOS8zM2tFeHFLcGFRQkRM?=
 =?utf-8?Q?mCEzkkd9+FBQXnf7L8o2yCb2o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4e9302-af2b-4d16-781e-08dde3c14b77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 10:22:29.4338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM6Jy81KMkEatXa4aLC8t0j76aLmqQH29xYnBRF0cb7TejJnzLU+501L1uK/vAwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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

On 22.08.25 21:47, David Francis wrote:
> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
> 
> This ioctl returns a list of bos with their handles, sizes,
> and flags and domains.
> 
> This ioctl is meant to be used during CRIU checkpoint and
> provide information needed to reconstruct the bos
> in CRIU restore.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 80 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>  include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++
>  4 files changed, 117 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..f19795dddf9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index aefae3a9e6f4..e6741d6c9a55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1024,6 +1024,86 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_list_handles
> + * @filp: drm file pointer
> + *
> + * num_entries is set as an input to the size of the entries array.
> + * num_entries is sent back as output as the number of bos in the process.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_list_handles *args = data;
> +	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
> +	struct drm_gem_object *gobj;
> +	int id, ret = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&filp->table_lock);
> +
> +	if (args->num_entries < num_bos) {
> +		args->num_entries = num_bos;
> +		return 0;
> +	}
> +
> +	if (num_bos == 0) {
> +		args->num_entries = 0;
> +		return 0;
> +	}
> +
> +	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
> +	if (!bo_entries)
> +		return -ENOMEM;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
> +
> +		if (bo_index >= num_bos) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		bo_entry = &bo_entries[bo_index];
> +
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> +		bo_entry->preferred_domains = bo->preferred_domains;
> +		bo_entry->gem_handle = id;
> +		bo_entry->alignment = bo->tbo.page_alignment;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	args->num_entries = bo_index;
> +
> +	if (!ret)
> +		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
> +
> +	kvfree(bo_entries);
> +
> +	return ret;
> +}
> +
> +
>  static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  				  int width,
>  				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b3047d73fe07..338fd6d6423c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *filp);
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp);
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bdedbaccf776..e5d1c24cabcb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ		0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  
>  /**
>   * DOC: memory domains
> @@ -811,6 +813,38 @@ struct drm_amdgpu_gem_op {
>  	__u64	value;
>  };
>  
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
> +
> +struct drm_amdgpu_gem_list_handles {
> +	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> +	__u64   entries;
> +
> +	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */

Please drop the "IN" here, that is no longer an input only parameter.

With that fixed, feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +	__u32   num_entries;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_handles_entry {
> +	/* gem handle of buffer object */
> +	__u32 gem_handle;
> +
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* Preferred domains for GEM_CREATE */
> +	__u64 preferred_domains;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;
> +
> +	/* physical start_addr alignment in bytes for some HW requirements */
> +	__u64 alignment;
> +};
> +
>  #define AMDGPU_VA_OP_MAP			1
>  #define AMDGPU_VA_OP_UNMAP			2
>  #define AMDGPU_VA_OP_CLEAR			3

