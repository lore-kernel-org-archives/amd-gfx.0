Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B0DCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 07:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0AA10E6AE;
	Wed,  4 Sep 2024 07:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XAd9vlCG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8A510E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 07:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO5xe+tvZVGeMfNh+plA5QEqv74Mjk6e4jBuFYplMHwr7VTdluT4JOD6/xBKkE3rPZzygU8pYcce2zf9WYu7EIJjwnSwsDZtTyoTd1HjbmDxPPJnNIdKdei/Nu5ZhWbYLregJaCm+q53fWJ8ZmMFX4sPj174qDWjT7noDvKE/mP83sllz2RsvF4OiyPV40DKnEsEkrg0PJLfZrKj+sFYURiDrLAZuucsB2pFm8oC7Tr1Fp0S95ITzwTgYql2nV4m0NTPFbdPNfWqHxWv3kuon4N6Zdm7KkTBSg9MfKykiwb2xE4Q3gDCfcMrwTNTW423K/IKryD44P6YG7mzvoiNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmyq+oRxtYPImOGrn89DbEhxQdmCG7J2PIXyUGld9bA=;
 b=w+DzAPK1yrWbi44i8ifQ9aviiKJ5EfV853FKjonoM3xRAZ0UmkDTskI8oMMS8WQtTYq4V+7iUqfvFoCi03j8+gRXgdwiIf6TshqGH1s8jHRxbntgBGQngMY72LazapHv/D2+JQmf0akgOveHslHWLtK2mRlKIkQmwF0zepw0bcZXRZsMm2qHqGMunzrtfEblM+t53Be8uswRV2QFZAxRtx1cSYJx9NfQ2/ELBJKwbHYZavuISL9zzkPj2qpfietPtWMOaftF/rlgTemFQg1yc68mq9dubY8F8gqueWrWLA0H4/4Yz4ud2DnylcP6kWirYMZe+Mtxr74Qxq7FmzIwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmyq+oRxtYPImOGrn89DbEhxQdmCG7J2PIXyUGld9bA=;
 b=XAd9vlCGurwNsRN3bFRoKRmqtO8FxwiVSaWkudvLGiaAmETsz52A5C6bqd/y6+SHTtcJb2sA6vldehBdipt2Sa2ftYvkne/joURDksMhzH2Jrg2xO5RZCcOKql062CEqicfN08axm9+93R2rhx2nid5ojST5CWPtFc/GG3kX09E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 07:56:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 07:56:22 +0000
Message-ID: <e1937023-bc7a-4250-a924-b56a047157af@amd.com>
Date: Wed, 4 Sep 2024 09:56:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace 'amdgpu_job_submit_direct' with
 'drm_sched_entity' in cleaner shader
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240904071229.1702075-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240904071229.1702075-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfdf043-758a-48d7-2775-08dcccb71130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0tVTjg4cG5GQU5sMEhVTVg1aGdUanQ2R2t6ZzNhUWFuVEEyWHdvVDlhYzA3?=
 =?utf-8?B?bGxnYjMxK2NWT2FmdGpYZXZQLzdDaU1sd3VvMUFiQ2xWcHFzQ0hlTlNRYmlO?=
 =?utf-8?B?Tm9VOHhOU25YbEdRaFhoekdTMkwvTHBwUGdyMXdjVmZPajRtOHhHQm1wMVlu?=
 =?utf-8?B?L2RHa1FrUWplbldIcGtiUHNmYmFZMDhLcDFoN1h2S0paNmY5L3NlQTI0d3ZI?=
 =?utf-8?B?a3Z6aG42cFgreGhOb1hmakw5YjFzTXl0OFIrVkN2WHhLNzFGaWl1bDJ1bFNH?=
 =?utf-8?B?UTF3RGVvby8ycFl0VDV4K3FVQWpJSUoyZ0h4bk1wd2wyZ3ZNdmNIS2E5VWE1?=
 =?utf-8?B?WUJkK0VrNDMwT3N5cDQ4TlVvWjcrRjQ1aVJBR2dRN01pNHNHU0NrdVJNb3hp?=
 =?utf-8?B?M0dOTkdVdVk3dSs3dVZ3TTRyaEJYaDhRWlkzTUY2NkV2d1d5TW05N2lVUkEv?=
 =?utf-8?B?Z2Z4QXRsb0NFNDIvcXNjQVVUT3F1RTJjWXlTeHBNTmg1U2MzR2hxSC9nd3I0?=
 =?utf-8?B?TXJtQWUvRys0SGY2WnRxZGlzSlNPMnFTOTlvdWRqV1JtaFVNM0s2VnRmOGkw?=
 =?utf-8?B?enFQRVhabFk1UnZZT1JzemdJRGdBWFRYUjR2elpoNW1tQlp0OHlEaFNmbXFn?=
 =?utf-8?B?MlRoMEVxdDZaUTMxR0lFUDdkZFRmRmVDWmhTS0FtNkRNT0MwRSt0QUtFTVRu?=
 =?utf-8?B?WnZ1azFpcU81bm5MMnZ0b0xWWm9sYWN4S0FabkRsaldSZG9ta1lSdFMzTlYz?=
 =?utf-8?B?YWo4SDZWZkFWdVF3L3VWRWhOYTBwakd1UFlRU3BWNGs2d0xsci9nWUxrczdV?=
 =?utf-8?B?Zm5ueEtwdUNxNHRkWjRNSE9TUVpEYnBoOGxZYzdSbnltMVlWQk5TaHVoV3Rj?=
 =?utf-8?B?Y01KWVpyTTVTWGVOL0pEK0ExWmI1cC9MelNIQlkyQjFnaUh5dGE1Y2tpUkVq?=
 =?utf-8?B?ejBGQTU4MmtqUktjZnhqL1piSWdaSHp0WmROTjRDWE15aFhKYk91NHNZc1lj?=
 =?utf-8?B?UllIMEZxNGlFWWNkbElhL1ZSbUlyVjkxbEsxbXp3YWwzNXIrTjlMRWh5ajBu?=
 =?utf-8?B?bEFWMDlHekZ2a1EzSSt3bU5EQkVwVlhZaldLdXJKWkZyZTRkT3NQdHhZV0RG?=
 =?utf-8?B?cG9aN0pCQXd2RFRudEI1NXJ2NkRrZnp3dWxwTk5YblRHVmdXeHByNHZsNFFw?=
 =?utf-8?B?Q3lPR1dWUHBmd0QxTHdPbjRvTmFoelAzWHFvZURVSG1QR2N5RUdBT25saXc5?=
 =?utf-8?B?eFBrcnVZTzcwaFIya3hKMEZVemNtWDNOVEI3VGd3dzQ1ZDZzN2lkUTNWT1ZH?=
 =?utf-8?B?ZzRtQTlUOEZyM1F1ZzEydWlhTUFiSFo0a0lBd2RXOWVKU0xDcXZsNVRzckVn?=
 =?utf-8?B?cFYvTG5EWDYyTmpjS0swTDQ4VWxoeEk4RkU0MzI0REJJVVZ3TkR6NWtRaTJ1?=
 =?utf-8?B?ckJkZERucTg5dEF5bkxMdG4rRGd1U25MbXFVMXlWL29oZWZEdkVpZ25HZXQ2?=
 =?utf-8?B?eEJwVXpFRzNDV3M2YnpaUkEvb0Y4Y0s0bEJHTzRIZ3h0SU1GRC9YcUkvY21G?=
 =?utf-8?B?UEVRbzBFRkpIR0ZVU0k3eE52SnJRemwzUFVwNWliZE9zRVRMdGgwczNYZFdW?=
 =?utf-8?B?M0FiTnFvc2xKTE9Gc0NYSU9abU5EVDNuVTUxVm12UzlRcUpJTHdpWkVQNHFT?=
 =?utf-8?B?VlpOTTVSM0lrRnNCS2tGTUEvWWQ3dG5VNUVxSVVEN1VZOS8xaHBBOUpDMGpj?=
 =?utf-8?B?R055UENzWFNjd2RnTXYxdW9KOWpmdlBlZTFVOE1aNHVVU1JRc0xuY0F1ZXRW?=
 =?utf-8?B?YjBDNXIraGMzNldORzM2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FSRWVlNTEvZUNUN2xhSGo4eFZ3UWlpdWpXNnhxRE4zR1I2azBYMGJyNUQ2?=
 =?utf-8?B?TS9IRWZwZUlyOHpsTjVBYkhzZUhBQlN0Qk10eEFxUzlRY1lFR010bEM5Yk9N?=
 =?utf-8?B?d1EvK2ZGanFFYzdPRG1xOXRxVHFTOW1yaGhheGt0eDVLd1JuRllVNmNkVU1v?=
 =?utf-8?B?UEtMTmNCMWlDSmdSVzczVlc3dVN6YzVOLzE0cUd1dysxdXB6cE5qVGhtTHFm?=
 =?utf-8?B?ditYR1F2YXpPclNwWDVxYnA5aUdoRUlUWHREYnprSTdyc08xeERyMWI0VzVl?=
 =?utf-8?B?M1NERmg2ZkdMZDl1Y3hXaTF1Q0RSVVdKSmdhSWtJMm5JQUluMG4vR2FXK3Fn?=
 =?utf-8?B?WHhwK002TmlzdzAxLzVXRkozdlhrcjRVYW55WVVCZy9uU3gyOHhXNitxQlJU?=
 =?utf-8?B?NUdINVcrNHdSU3ZET3ArdHdLMVBSczJ5WlI0dnVZbEVaTUcxSjNsMUZNd2Fp?=
 =?utf-8?B?bmQ1Q1VUc3crRWV3U3lIUmJaYkNBZTNsVlVZRTVNRFBsOHM4TlZObDBtVHJP?=
 =?utf-8?B?NFpBaWh5c3VqVjVzU3JoNU9oNFlKRmRCUlNOZkp6ejI1ZUVuTVFjUDUrUU9R?=
 =?utf-8?B?RU5nMHYvay85ZDB5d2E2N3A1REFlbU4ydFNZMWFTUU5tdlhjVkZ0SGZRb3gv?=
 =?utf-8?B?STNrZWo5VCttWmRLam5Gb3N1eVdHRTdlSkVJc2ZwWnZwY1ZnSjJrUEtERndH?=
 =?utf-8?B?MVphT0tZUmp6NVRRVVdvdnJsK0lSZVJnWkpIOTZHMlVzajJTRE0zQWhyQ0Vw?=
 =?utf-8?B?VHQ5UjNFTHAvcHhKZENENzh4bUFvdWJ0S1dvOUMwMmFPRUhYMkJaejBKZ2pq?=
 =?utf-8?B?MG9JRFVOTzRYWlp0QURYZ0crOEpza1dGTjlzNm5GeEE4V2pDWHlpbDBwMFhk?=
 =?utf-8?B?U3ZVWmJrQWxlSWp6RjNHd1BrbWx1eElBaGRSdmMrak00TjFvSXgxeFF2WmU3?=
 =?utf-8?B?eC83bVAzaUl5MnZXRWhQWlNDczJJQTVFT3M4SmZkellaU3VDWFZXL2p6SG1J?=
 =?utf-8?B?d2xmTFJUa1lpSUk5Y2U5a3ZWZnNlMi9NcUxLbFlRUnBGQWlWZTBqaEJnQUJZ?=
 =?utf-8?B?S0xCKzdONEIvdUdEbG9VT0Y5N29NcHRrN2ZwREwzZjhsOGdRcTJzbXlyT3hE?=
 =?utf-8?B?U2RoanhJRDdrbkxwVyt1OG9waFpSN2tCQWl3YzJaaGhGQUZ4Y1Qycy9DYUQ3?=
 =?utf-8?B?azVLN3ZXTTI1WFpjZzROOFhRUTU3THUxbVB4N0dnOXVYclRaV01PRkdTaXhP?=
 =?utf-8?B?Z0ZHQzYyZWxpOUlReU1HckNGajBOTXdFeUxNTkE1YkxHc20xbGMveFhyTVln?=
 =?utf-8?B?cTRBeEpicHNkRDZTZE9nc0lZcm93ZlZtYnFZM2tDOURDTERaN1BjQXhhM2VO?=
 =?utf-8?B?TEJ6bUlpdGkzQnBaZzlUc2tjZVBFTU52OEl4UWxFUFE0NUtkdHRBRk5zOXF6?=
 =?utf-8?B?NTJLRkxkbzljZFh3K29HZjdWUzFOYXZ0QlhBc1pBdFRjS0M3b3IvSHBURnV1?=
 =?utf-8?B?SklDb0RtQjVPZkY2TDRHQU4rYlo2VHc3dTN2eG1XajdmcXEwemhvUHZFblFD?=
 =?utf-8?B?d0oweVVmaDZLaW9xT1JIYmNlcklHZU9yUUs2U3VxUHlGa1BhSTRHVHNXNjky?=
 =?utf-8?B?QnJ6OFdKZzVYa2haRXo3cmREbXlpZ3MxS0cxQSt5RjduNVVBb1FiZllVWE1k?=
 =?utf-8?B?U0twbTRsRXd2MEMyaWVSWXlKMFYrc0NVZzlBVjhqS2tQN2owZ0VsSU11T0l6?=
 =?utf-8?B?UWJzUXc5NVdabnZ2cDRZL3liOXViNUhkWTVJdFlib3VoTERDcW1sR1AybWZa?=
 =?utf-8?B?RGY0b0EzOElVSzhqQ0lCaVIvVFZUOTJnSnRYUFl2WC9rQTQ1cU5DQ3h2TlAr?=
 =?utf-8?B?SHJLMjVpTjMvbTBWMUlTU0JBOTJlVUdtV09OSGVHSk85SU1UeldaK2wySVIr?=
 =?utf-8?B?ZWU2UUwxTEFSVHpHTEtJYUNQWUdZZ2xKU3FXeWtzVVcyeGJlYldvUTlTVHpy?=
 =?utf-8?B?b3dNbExpdlovdXhGSnBnSkh0ckNSWmRhUWFweE1DYmtmWERNazRFTVJ6aWpP?=
 =?utf-8?B?bVRJSTF2KzE0aGNXNVNLUEtEdTBsam1VVW1qY1F0elIyRmducmVqT0ZTNkx0?=
 =?utf-8?Q?Ma9u4vQ0LHpQOVta2G6NqJqTR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfdf043-758a-48d7-2775-08dcccb71130
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:56:22.1011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAV9MlyLaJDX37N3l1RvrVmzKViGA3BDEBESTd4sDqxr0h0SFxx51GzXMeEr2AOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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

Am 04.09.24 um 09:12 schrieb Srinivasan Shanmugam:
> This commit replaces the use of amdgpu_job_submit_direct which submits
> the job to the ring directly, with drm_sched_entity in the cleaner
> shader job submission process. The change allows the GPU scheduler to
> manage the cleaner shader job.
>
> - The job is then submitted to the GPU using the
>    drm_sched_entity_push_job function, which allows the GPU scheduler to
>    manage the job.
>
> This change improves the reliability of the cleaner shader job
> submission process by leveraging the capabilities of the GPU scheduler.
>
> Fixes: f70111466165 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 32 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
>   2 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b779d47a546a..149939c4eaed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1397,14 +1397,22 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
>   static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	long timeout = msecs_to_jiffies(1000);
> +	struct drm_gpu_scheduler *sched = &ring->sched;
>   	struct dma_fence *f = NULL;

Please drop that default assignment of f.

>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	int i, r;
>   
> -	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL,
> -				     64, AMDGPU_IB_POOL_DIRECT,
> +	/* Initialize the scheduler entity */
> +	r = drm_sched_entity_init(&adev->gfx.entity, DRM_SCHED_PRIORITY_NORMAL,
> +				  &sched, 1, NULL);
> +	if (r) {
> +		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
> +		goto err;
> +	}
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->gfx.entity, NULL,
> +				     64, 0,
>   				     &job);
>   	if (r)
>   		goto err;
> @@ -1416,24 +1424,16 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   		ib->ptr[i] = ring->funcs->nop;
>   	ib->length_dw = ring->funcs->align_mask + 1;
>   
> -	r = amdgpu_job_submit_direct(job, ring, &f);
> +	f = amdgpu_job_submit(job);
> +	r = dma_fence_wait(f, false);

Where is f assigned?

>   	if (r)
> -		goto err_free;
> -
> -	r = dma_fence_wait_timeout(f, false, timeout);
> -	if (r == 0)
> -		r = -ETIMEDOUT;
> -	else if (r > 0)
> -		r = 0;
> -
> -	amdgpu_ib_free(adev, ib, f);
> +		goto err;
>   	dma_fence_put(f);
>   
> +	/* Clean up the scheduler entity */
> +	drm_sched_entity_destroy(&adev->gfx.entity);
>   	return 0;
>   
> -err_free:
> -	amdgpu_job_free(job);
> -	amdgpu_ib_free(adev, ib, f);
>   err:
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5644e10a86a9..3c268476dec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -472,6 +472,7 @@ struct amdgpu_gfx {
>   	struct mutex                    kfd_sch_mutex;
>   	u64				kfd_sch_req_count[MAX_XCP];
>   	bool				kfd_sch_inactive[MAX_XCP];
> +	struct drm_sched_entity	entity;

You can't put that into the amdgpu_gfx structure. The sysfs might be 
called concurrently.

I suggest to put it on the stack.

Christian.

>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {

