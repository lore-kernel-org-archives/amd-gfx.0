Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDE1C5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 21:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B1210E034;
	Wed, 19 Aug 2026 21:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjSV+MRs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010028.outbound.protection.outlook.com
 [52.101.193.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCC910E034
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 21:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2RHkVer1jb1bNb5hDbQxl5xUNzy3Aii+OM0tfrscQRsSn3eieLFO/YnlewEB55OeQjexWbjghFijY7G95fBVm9wNHmxSUmsyWW/vKaFPzDEDpEMqieLMwwGiR5hEXVUM/jLGT5nA2Hm6l90XYct0mnuHHVtIj48wBpBjN+0d9qAW7C2HxnXS+kHgXm04D2vqCXwMOiAbiyk+KlWBf5Yus2WxYPYRY6IK0tysIrLeSYRjE5bMBwcNiKWg0x798DeLTgVHuAUCrN+eFYg0syK7C+IKH4rD5Za2I672wwPXuXEpNLehoYJIWdisbR+guSBJwNyaJu3vFaoK7Mcf1p0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DNeqgevD+9E985zj3kXbAnY2/lsyvKSTmtoZ1GqwAI=;
 b=pPuE+VK/WAG0jDjtFTjHHXILOFYNndpySrN1m9nwbbnWm9TzBDJnYQd3o6g8JhHiTXS5zzVSKZH4LxGaA4w/nvc6c0zbXv9uIcyrparmC9IRwDAs/8MaNu0NU49gRevQiWXJL0sClI+3YQ7j++xdc3nC/pBETEgfZyQbuWv7OXCUBIkccdSK/nAiZpvHXhO7XQkPCnQDtu0+5mx/aWIzpXokBlpdAHtMEXRv3AX218ixuOIJaCevyVFFgwY5z1/YealrPIEACm2CcRspVXZdsvR18v51QbwGjTGJGKN7VRcAii6/aAw7hBhOqIT2Lb98qjcFxkO189FG9mRptMifTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DNeqgevD+9E985zj3kXbAnY2/lsyvKSTmtoZ1GqwAI=;
 b=mjSV+MRsRSliKjFViomRYT2lyTms3RDQJe+Lu755vNPUJn9ulrnd4AgKjHQyEHsTc33/dMcVIzSpKedri4/CGIYZkiLrrc/Oh9hfQkbw9oX8TL8SCDDCadsRkgI685Ph3Zc+y9ibRqYo54NUfZC19GTRVW68do7gv5ICc1Q2xKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by BN5PR12MB9538.namprd12.prod.outlook.com
 (2603:10b6:408:2ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 21:51:30 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 21:51:29 +0000
Message-ID: <475f3cc7-ae96-4a2a-bfac-4c65c4d8def7@amd.com>
Date: Wed, 19 Aug 2026 17:51:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: Check cpu page faulted vmf->page got
 migrated to system RAM
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260817135918.228397-1-xiaogang.chen@amd.com>
 <20260817135918.228397-3-xiaogang.chen@amd.com>
 <ce510a57-f99d-4a2f-9af2-132e388260aa@amd.com>
 <5192fdec-ea47-4d04-b879-47b38d857fea@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <5192fdec-ea47-4d04-b879-47b38d857fea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::15) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: a82393db-03cb-458e-e45b-08defe3c06b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ABheMFGDHi5jZ6eldCvBAzMHk4IW02gL7iM2CXdj97EE34BPYWgyuTPr87z3XuG4nlr0LJvkJ1xa+QneXGIbdC4Yy5HLF7mGfJKeUS85HsiPgUVGtZIvbsHu85Mv9JKLAc7xoev4K5uyp6BkLCv7vICUb01F38GfW3Y1wJTwkwHNGZ5GQ2gTc0035ggTXIXVMur8SYiZHc1ONaBTTqgvPX4xQX17N/vNEjLddiDEbpiey0RBn+bJ3GOX+5bKFGCpJP/OReu02zqAjXviFu0y6gswP0NMNaXDxBtdDQeUT+3em+kShMLewbO/BGFi7/Ur5fP/jiGJJgn2n20nxoBsR908E5duUncZiS3VgH0hjZm84LYYkW/viZi9P4fxnqpLDTfRScIeNdTTz4ZRZ1WsSyldWvWQdh4ejcb/AFGHXpSIxiO2C8mQATOc4k/DYhq0635SjNjFJruj6d0YHU5x1R/XVbEOxMTTlLM6JKvQXYfs+1PTiSn/6ss1lnITbNIrOvmSm++RUkLaFllcQLZ1nlW2kJa+Vkq6ADtZ61X2cW7k7cxqVY3mytGzMQClsGlmHNUIhlP1SXC98YL9TY9CJnM8WVc4y/1YAFwLzajhomh4FwGK4OYSI98dmMySIby7uSBdGTV/Y0ofXaiRhDhyxAk5lkuV7qho+SZhot/bii0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpjNld0czJaNEVGeEQrZWZZMlVmVGYweGFITGVna2Y4NkhpYm1oRWtaOVNZ?=
 =?utf-8?B?RTdwNlBmWEMzb1I5aCtQNEQ0dDk4V2loTEczU1JxRmUzVXc5WHBLSk1IVklC?=
 =?utf-8?B?ZUUzWTdBbDRza1JjU0hGQnByMlpnbW9TNnNnODhTMFpDRHNnUlphMUN4Sytl?=
 =?utf-8?B?Rm52WmhTcWNWZitlanYvR2dzRnpUSU1vZC9TU29FL0tvTUdYNmRPMGdYTVhZ?=
 =?utf-8?B?N0d6aGNxRXRWRm5kais1d2NhZ0tDdEgyMnB2eFZVaW0wVlFia1VhV1QzN1dw?=
 =?utf-8?B?YlNaeUtENHRnREt6RXJUMkNaSXFTYmNoNjVnWmZEVnhpM0hsc0swZUNVcU5o?=
 =?utf-8?B?OHNuTWNLa1VxQmlqTEtJNk5EUHM1VWg0Z3QrKzlBODR5VllXUnhwbkh2MXFk?=
 =?utf-8?B?SWlZK3BoaXJOY1N6OHFOVUFqZE5WdWJ4VlJOcjlGckFKVzZzRFhjcXBsRGJN?=
 =?utf-8?B?ZHJ3WGFLdFZWUFl0TExxZVdTbkFYYy9sbjFpSmV0alY1SW1zNE5OQzEvK2RW?=
 =?utf-8?B?UmZTRlNORENZMERMYkdzR3JucjVBNW9HWENSQVRZSHFxM0dYaXdjR0RFOUk3?=
 =?utf-8?B?SFdhYkZZdnlyWXBHTjg1L3l2b0VkSGRzNXJxUzF3WExRSkh5Q1lFZkR1WlNI?=
 =?utf-8?B?NlN3TUVTQ3RnWTdpeWJmeGtZWk1zM052Tjg3T01aOVR1NjBidkt5VkZPZjN6?=
 =?utf-8?B?dDBsQlozTkFIQWZJcHFteUdwNWRhYlgrSTkrN3VkODZhVDFqWHloejBodEpX?=
 =?utf-8?B?OVliWEQwZzBLTlgzTUg3TmMrTXB6cytQdU5RMWpWTFNRR1RjcFdKTExuQ2la?=
 =?utf-8?B?SUhiYS9YMlZPSWpya25qQmF4bEljYkxTWDRlSHJVdFhHMkRGNmJ2WXpoTHN6?=
 =?utf-8?B?d0tBdmJORUJxOWlCMUdUTTlESDNlT3hQVllxTTQzSWhNY1g5RFlQYmdCZXRB?=
 =?utf-8?B?d2xVZ0t0SVc4YVZxN1pnaDFHRjFvU3VVRXhPYUdEWDVOWCs1K281QWVFdlBF?=
 =?utf-8?B?cGlVNUtuZlVscDhORHlkZDR1T0tqb09XZGJGYWZGeUFhZmQ3TWxPY2E4TWda?=
 =?utf-8?B?NVdzTkttRjdNZEIwVE8xdjlOaXpzUmFXelhkaHlhL2dsWk13Tll1L1FMd3VC?=
 =?utf-8?B?ZmRZRWhMSC85SVZ3eEhzUGFHMkdDVTBVdHlNNVkySXJJWjc2dHRIZHlBUnd4?=
 =?utf-8?B?dWVoSEtaZWpJUmN3NXVYQW1sSllKQVJ6eUZIODB1S2V6WXpaWWtRL3pEUHda?=
 =?utf-8?B?Zks0MzZrZDgyUEVLTThGeFVLS0tCb1Uwc1Evc0kvbHlZRzNQUnFIWWN2eGVp?=
 =?utf-8?B?OXFBMklqd0I3TDNJVU1EZncwY0FHQ1pROWFDNWJ0LzBEUFcvbG5sNXp0TUVu?=
 =?utf-8?B?aW1CSW5nSGpkaE55QVVwMnhVOWc4YVRUUU80c3gxY0h3YlUzWCs3dnNqSUxO?=
 =?utf-8?B?SjFXeEo3Q3dpaE5zTHh5NmFGVmR6THE1Wk9nWlNSaUtiQVI0S1pGamIrQjRv?=
 =?utf-8?B?azBLelRwTWtPd3FrRDdtQnhTaU9Ka2JQWU1xZGwrVzRpSUg0R2dPQ3QyRGhS?=
 =?utf-8?B?cUNPN3BnQXhuTzM0RkV5Zi93dE9mNWdibVphZExYK2o1d21tbEQrVnQzL2wx?=
 =?utf-8?B?WFliemc0K1ZoN1hwQ2d2Vm5JVGJ1VGdFSENDaDRrVHA5M2dGUy9obnZFSFpB?=
 =?utf-8?B?cFoyWVRrdXpQdWErMnVXWUcwRHdaUENyZTgvRWhpcEVwOXpxVitOcCtaQ3FF?=
 =?utf-8?B?Y0NINWhta3JUUHB0L0N6c0l4NHpaRnBqbXZyZkUrOFpsTmZJajNYSTQwUDI2?=
 =?utf-8?B?TkgwQTdSRVAyREVtQ1FzeDVXYVpkTm5uU1dMSHZ3ZmlLRFV3THI3L3ZjeU1G?=
 =?utf-8?B?enc5cUhKTGkxWStOek9CQWN6TldOTW5zdlBKOXJwa3VFTDUwdHFrKzJER2Z4?=
 =?utf-8?B?Wm96ckxQN1hSK1ZBdFhxeXhpQlZRMGl3SGIwUTg5OHN0UG1IU1Aycldrcy9S?=
 =?utf-8?B?SjBGbGhXWEVLYW5TQ3RFdER0emtNWWZyNEhwc0RqWGJua1IxTlNHQkpEeEhY?=
 =?utf-8?B?Q1pkUjJ5YlFzUWFwdW9uWXNrS3N1aUpjVnRnYkpsZk1HdFFtZHpoSzQxR0FL?=
 =?utf-8?B?RUNNZGVZTjNiMFQ3dldNajRYQ09sanBVa1BVNGRScm5XVXMvMENYNzVJWWY1?=
 =?utf-8?B?WVpyQnd6Q2xBc1JkeHVhMmFHTzVkS3J0aWhTVFdja1JXV2dWc3VDQ3VvU3Vt?=
 =?utf-8?B?ejhQbzBNR21xQUFIUkNVYVFCdFQ5YlZQZzNJT0JJVisrQ3FCYmkxRzd5RVl5?=
 =?utf-8?B?Qkc0RTVwQjNLZmpldDN6OHpsaklRVjFCWFNidVVSZm9rR044aXA3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82393db-03cb-458e-e45b-08defe3c06b3
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 21:51:29.8451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t73AOXWlEX/6E/izJ+NH3Nfm09KYu+ePBB0taBj60wYS+H/RSlq1PynVKSF0AyfVME0vMhnxld2Yt21LZSPsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538
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

On 2026-08-19 11:16, Chen, Xiaogang wrote:
> Maybe you said retry fault handler inside kernel is a better way: we 
> let driver return VM_FAULT_RETRY for pinned vmf->page, let kernel 
> retry handle_mm_fault, then hope the pin will be drop soon?

I agree. Pages should never be pinned for a very long time. In other 
words, I believe this is all working as it should and this patch is 
unnecessary.

Regards,
   Felix

