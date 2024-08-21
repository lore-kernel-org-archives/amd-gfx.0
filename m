Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDA0C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 20:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567B610E6C6;
	Wed, 21 Aug 2024 20:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7maNSOF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5234B10E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 20:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svEqf6LR6J+dOvmKAOJx1a6P8YYRuIbJXqbe2NgO/cvfumQR4NNKGkhQqLDzbSqeU11CpnIqvzPmwbHOChN7bU6mtfZhBcsvzoJQyt0/YZC/XQwdrQL1CS2H6eb9qZ3GSM+A8taJ3/lAUm3TqHgG++amnYfbD+YDfdou7H+UUoiTTq9cEZmBc58pi5Rx51ASIMKcaRuFaXElwK4PLMCSJmr3qKfMTgiOkMEJ77NcD7OB2HVYZk9KgGvO3cjbm1TavwwLCHmWT5AtFYaGEEPYe9E4dj1xp9GBY3W5R8NIs3LgKf4lCG3iHwoWECx6TfKId7AsYlAhNjet6pYiAcmNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/AWUMRrp2fs+GDk9xgH3Pf/UpO93SQikXu9Ar8ulqQ=;
 b=o0TDVQ0BXGOoUobAlkROsdfy2E7GUnEBn+/Jx6dZqCZeuMBBZUOXN5STou/9zeyrQUf6x6KucjhQV8d2QWkbo2227PYfX3bTZX3dN2A+OfLK2BpPnZYgxqwRHWe2Ekivz4rAon6AS+gfFkU6CuvXF0XwRkSMKMF5kILHhkxR9k2EuKULnWkIaqdfMRbJw5uEfpeO1cMJo201qw+ggCCy/UASM6jp6flC2Zm77XzbmEmdAIic7UeTCb0a9idSkb59IVmHIOnkRMmboBZk9kjyfe+0wltNB03NvnOL5dAbShGPInyqybHaWfA62EfBof6ONQjfSsJLsR3HOxA/1INrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/AWUMRrp2fs+GDk9xgH3Pf/UpO93SQikXu9Ar8ulqQ=;
 b=m7maNSOFSI06mp5xzzB02TzpVIAIP2y1xL+JGda661/kbyYw+5b7NryOrF0pK3328gWlBlFjbLJWCggZpQip9YL1DUlOLZn0O0Qhk5LXPvxb4fqIw1UknYgdh6K2gPHn+vq2/nNzQ25jdKumHz0VRXHGHKJCxJ54rauK/0UXpe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 20:01:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 20:01:09 +0000
Message-ID: <a511a28c-13d7-452f-96bd-911148c4d175@amd.com>
Date: Wed, 21 Aug 2024 16:01:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: sync to KFD fences before clearing PTEs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 friedrich.vock@gmx.de, bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
 <20240821120324.4583-2-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240821120324.4583-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::48) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ac5b80-a1cd-4975-d2f0-08dcc21bfff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2ZqM2MrcUZmckp6dTI0eHd1bWtramlPck1qNkFMRWd4VE1aeXZ3cHhWY25k?=
 =?utf-8?B?d1h6WTRnWlYvWUpBM0Rkc3RxRTU2aGxXVGJNMnpsQjJZU3pucFphd1JkcjRQ?=
 =?utf-8?B?NTdMWG5BSEZDeU5aNWpKaDBwemRHT09ZZnZQS2IwaGZyU2NUK0FYbUpCSWl2?=
 =?utf-8?B?NDRMK0NYRDZ6SVNsd2NMR3FPUjFTQWptalArSEtsbHJkRWJSUE83dEhmODly?=
 =?utf-8?B?TnJUeG96MTF4a3UwbGg1QVY1NXJYYXo0Y1lYenZKcVk3S0VVc1FCVGNkdVBJ?=
 =?utf-8?B?eUlPYWdZVjZqMGZjbUVaaDZack13QWFCZXhXU2JVMXlGOFBveWFlZHJpbHhC?=
 =?utf-8?B?emg1ZWwzL1RuR0RqSm9mNVByVmpESDl2YUFzRU95QVI0TGRvSXFRcWNkZDh2?=
 =?utf-8?B?c0lkNlN3RmRTcWpJNlBUaWdST1dybjFHWkFzaVVPanpHQnlxMTVac3d2UjFD?=
 =?utf-8?B?UTNNNERnb2U4aEtZNjhOWkt4eEp1c1lHWEprRkpoQ1kyU3BZWXVRbm1LK2tU?=
 =?utf-8?B?VDdLRU1UbWhFT2k5VC83aTNzbXBxZUFpZDhoT1d4c3BBSGxOTWpWOHJ1SjBk?=
 =?utf-8?B?WElDb2xkS0h2M3B5bk5iY3F3QklRa0FPWFNOVHFFUHpRR01TTWR0ODRaM091?=
 =?utf-8?B?K0FMVVdXQnNuMVB4MFlQQlVIRldqOFc2TEZkUWRtaWxOKy9lMjQrblREeFY4?=
 =?utf-8?B?UVNLUHdKUkZNSExuTXdubi9VTmxvdUtZSGN5Z29hWFVWd2pwYVNaYXNEWC9a?=
 =?utf-8?B?Sy80TzFLSW9UbkorTEZtMzZCMXYyRzV4dEp1NkFRQmd2cDRHdk9ITzRPQ1Ev?=
 =?utf-8?B?WlE0Tm93OUl6NWUxK1JhaWVxTW1aVXYzOGpKNUl0dmlQMTRmYVFoVk1jWTJh?=
 =?utf-8?B?Z0R2WEtNUmVsUEJQdmxmNWpZT2VyL3JpTU5JVy91cndjR2k5MG1jbFl3azk5?=
 =?utf-8?B?RjRISUR3SlJPWG43NmVjOThYQXJaYzlMVW8rWkRJdnJXRHl1YWFyeWRQc3hG?=
 =?utf-8?B?Qms1ZEwwVS93QXA3UVduZnJuZFdzY2JoVUl0ZFBBOWc3UzJtTEt0eklidzJH?=
 =?utf-8?B?UzBjY1g0d1NXSFA3VkJ4V2FtNWdsczh1TGMvbDhrLzdvbkd1cFVYQUR3dWxn?=
 =?utf-8?B?Q3ZOSFBDUDBNVk9ocjh6S2l4SWhYSWQrK2xUZ1Q3OWFkWHYvT2hQajMyZjU2?=
 =?utf-8?B?U05lbHlhTVB4OXMwZTd1RlZYSEZmdEZJbW94blJsK0MyWWxNbW5Zais2VFNa?=
 =?utf-8?B?ZjM4T1VOdnVld2xnVEFZT25RK2NNUTJ1YVBTZ21sTzFZeEFHZmROZWtuNnBV?=
 =?utf-8?B?K2JqV3NMQVFtN20vc2VwZDZWdktzRVZwS01wenp1VUM1bkpQN2xWalR4MUFY?=
 =?utf-8?B?aE9sTmFIRGJ2aUtFbkR2R2JNLzRMWDFhbm5KeXY0QStmU2ZSS0QzRnhLdGRt?=
 =?utf-8?B?UjJMWlFrU1FCUUJRTWZtNFkvZE5WYjY0OUNuNjBjbE1lNkxqOS93U3cyaVg4?=
 =?utf-8?B?QnQwVmR4R1dCVStjQ2RZa3ZBd003YmhKVlM3M0Urc0tUTTRSajhLdTJjWHdS?=
 =?utf-8?B?anVWNWx2c05wbFZlT3NaK3h6eDU2MzZwc1NsaDFSTWVoUEVJZmNzamU0UzIr?=
 =?utf-8?B?azR3WU10Nkh0R3FlaUJEdlIveER1VjIyNzlEU0wyNDVYcHN5QUpZRk9BTWor?=
 =?utf-8?B?N0V0UHdidEpBSWJiZEdKdmQvNms5cXRacXZ4VTZpeURVRzZ6d0x5L3FlOWUz?=
 =?utf-8?B?cW50cVlCdWxZd3RicnpKWnJPNHdMT0pSTmFnTzVhVVFkOHZmeGF5VEs4MDRy?=
 =?utf-8?B?ajVYYzM0THlBSUlFRFBzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdWQjJSekoxMklVRUFXam82eGptaUNvRkd3eHZRTDhCNVRGR3NVdSsvblhN?=
 =?utf-8?B?bmN4OFNRa0NrM29yTTlxcjJ0Q092Y2Z1eFZvZVlsWVJOQVZXU1JWcmdlNFl2?=
 =?utf-8?B?WWl6ejlYMTBreGo2eWlPYTRlTERhWi9LZmZ3dEZWU0JSY2tuT0Nod0FOdEZW?=
 =?utf-8?B?WUh5bCszZkw3WFEwcy9URHoxL2VvU1JPUW8yb0YySHZnZXNQeVNjNEd1ZmpG?=
 =?utf-8?B?U0dNajNhYk1lSTRKUEwwdzVHS1lTRWt4NnFDZDVLNjBlRkF0b09kcVJCUDBl?=
 =?utf-8?B?UU5wc3YvVnNYbnJsdlI2R0lFLzlHcjRlUVVMaS9nU1g0UjI2d3JSTlhFWTN5?=
 =?utf-8?B?ZGRENjE2SkpWcWhJSTNQVTRqLzN2ckw2Z3F1c1gxUkJ5TkVTK1F1UmZvbnUy?=
 =?utf-8?B?OHpGVkRIVnE4NzNwMUY4MlZiNytmbUNnREF6UWVXcnBKTXB3UVQwdDVJK0ll?=
 =?utf-8?B?Z1FsZm5KeURIeGYwM1VGU25MR0ZobkhhWndFY1NhTW10WHZhRnY4S2gzWjJn?=
 =?utf-8?B?bkV5TlN3SmFGdXhjMDBYQlhNR0lLTm5FT0hPdWZZbGR2U1FvNlNVcjRLNUt2?=
 =?utf-8?B?cExJek5wbS95eXdDWHo2cFVqaUNLcTlnazZpMS9zUXFmL1FteHRsdUwvMWhx?=
 =?utf-8?B?dlJ5cndyZ3FuVWhkQXJsdUo4b0hucWgwQmJKOEZqRldKalhPMGNzYlJ0UkpO?=
 =?utf-8?B?dEpTTUxpQUFEdmY0UEZyRUhEY2lPWFI2bnRjeUprQzBsR3hHQnNJTUhlRFdm?=
 =?utf-8?B?bW5INW9LMWVZTGxBMTBNUzBneGRxQkVtM05XQjE1VkFjZm9YaWV2NlJEQk1v?=
 =?utf-8?B?a2E4c0ZMMkFob3gwRUl0eUplbUVUejJpN29ZSlJtemVBcWZsUzJ2MkVNQmJ5?=
 =?utf-8?B?U2w3Y2c4bjlCdndheFFNZzg1eFVFK08zZDMrYTI5MjJUd1VPcFpFQ0YvZlhP?=
 =?utf-8?B?b2dDOC9jTG5SemJMMkRsUElCRzFsZ2RicjlPOFBnQmZVYWFSMnBSUDJWVGEw?=
 =?utf-8?B?enpwb2d6dzJpNUE0SDQ3cnRvbXNKcFZJZkJWaUcwZmx6aGFOb0FnQ0dOY2hp?=
 =?utf-8?B?UUlaeUVHQzMvUHQvYXZYV3ZUMzU0MzJINEJSWVFBcnIzTU8vWXdNc1pWcVFm?=
 =?utf-8?B?Q3U0WGQ1Y09aNkRHR0NWVEgrU3AzNjI5UGZYTFR3RnpudGk0cXZ5dENXVERD?=
 =?utf-8?B?RWlCczB0bjRsRWtXMTdCVW5VbWhlc1lTTFBUaWFQU1lwRGltTEp6bnFKWTVu?=
 =?utf-8?B?RlJyWDVsZ1l4RzlieXdwYXJ5aFo1QTl4N2V4bmJhUmpEV015emN4ZzRNQ2cz?=
 =?utf-8?B?TjF2R0M0eHNkUHROUmhoYm5ETzJFNFM1bE5wRkdnS09DcmtQaVlMdmNXZU5i?=
 =?utf-8?B?SDQxY3E4WUFReFdIbHZRVWQ5enhQaUZoTXJxcmdZOTJjeHhZcmEvbTN0T1NQ?=
 =?utf-8?B?TndGSjNwcEdiTjJQMERNYzBKWElEYUE3ZDl4YzRXdzl1cklLRlRtNml3b0xz?=
 =?utf-8?B?UlRNa2I5bU5BVzFLUkRwb2JXSVJLKzhXYkFRQk04R2t5dzIvZmh5VkQrY2FQ?=
 =?utf-8?B?MXNkZDhQZzdLYmIvT0EySCtZdXNybSsrUjdhdDEvQnoyTXphdlUxRldtR3Fj?=
 =?utf-8?B?aTYrSCsvU05XV2FmSC9uMU1QdS9kQlZlcyt0NEU2OU12YXNwVit2L2h6Zmgz?=
 =?utf-8?B?aEFhRTM5WkcremU1YVc5UEROaWQvczlYdWNpblpnMWxlak9XdytHbFN4bUhO?=
 =?utf-8?B?bSsxRzd6bktGRGZhQmVtWEltME1jNFNSODdKR0FoeW5UTEhtK3FuRTZaOTk0?=
 =?utf-8?B?bU5wdkpnbmV6QnJuc0hmekdmbWJmcEVFdmIzWVlEZTMxSjdzUWFadHhXNjQx?=
 =?utf-8?B?QUROemRaMWNPY2tleFpJaDlORmpWU0syQWZITE5USTBrWVl3cUl3OW9oSk4r?=
 =?utf-8?B?U1lLMXh5UDlqM1h2TDFnVjZrTlp4akJaL08yZEFya1p2b3lTbWdMekVxUy9G?=
 =?utf-8?B?R2tMU3JDY3FLTGdPR3JaelVHSzJ2bGhJTVArWHBUS2NESVg2NXllbzJINFI0?=
 =?utf-8?B?cGk3TlNyVW05L0hqMUZxMVpJQzlHWGZ4cm1wbkhEdEVhZmhoMTB4M0lMRUF3?=
 =?utf-8?Q?hoFnoRqg2n7Bi2/jotrbruced?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ac5b80-a1cd-4975-d2f0-08dcc21bfff1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:01:09.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCccLk5jnuORHRJrox1lO/qip0Ipnuo6wzOOL8leS3SZk9cqHBjLtkCH81E6IZVrn0JccWOZBfyUzBu/fXf2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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

On 2024-08-21 08:03, Christian König wrote:
> This patch tries to solve the basic problem we also need to sync to
> the KFD fences of the BO because otherwise it can be that we clear
> PTEs while the KFD queues are still running.

This is going to trigger a lot of phantom KFD evictions and will tank 
performance. It's probably not what you intended.

Regards,
   Felix


>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 30 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  6 +++++
>   3 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index bdf1ef825d89..c586ab4c911b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -260,6 +260,36 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_sync_kfd - sync to KFD fences
> + *
> + * @sync: sync object to add KFD fences to
> + * @resv: reservation object with KFD fences
> + *
> + * Extract all KFD fences and add them to the sync object.
> + */
> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
> +{
> +	struct dma_resv_iter cursor;
> +	struct dma_fence *f;
> +	int r = 0;
> +
> +	dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
> +	dma_resv_for_each_fence_unlocked(&cursor, f) {
> +		void *fence_owner = amdgpu_sync_get_owner(f);
> +
> +		if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
> +			continue;
> +
> +		r = amdgpu_sync_fence(sync, f);
> +		if (r)
> +			break;
> +	}
> +	dma_resv_iter_end(&cursor);
> +
> +	return r;
> +}
> +
>   /* Free the entry back to the slab */
>   static void amdgpu_sync_entry_free(struct amdgpu_sync_entry *e)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> index cf1e9e858efd..e3272dce798d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> @@ -51,6 +51,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
>   int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>   		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
>   		     void *owner);
> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
>   struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>   				     struct amdgpu_ring *ring);
>   struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ba99d428610a..13d429b91327 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1168,6 +1168,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   				     AMDGPU_SYNC_EQ_OWNER, vm);
>   		if (r)
>   			goto error_free;
> +		if (bo) {
> +			r = amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
> +			if (r)
> +				goto error_free;
> +		}
> +
>   	} else {
>   		struct drm_gem_object *obj = &bo->tbo.base;
>   
