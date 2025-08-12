Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69A9CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 08:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FED010E5C4;
	Tue, 12 Aug 2025 08:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fwxvdm8o";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F11810E5CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 08:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdQmEXEsBOoT9ldmyTLR7BWp+pCJu0wOe9un2V9LUqHJMtMgt68Bj7efflpP/jAeUQYJhZubtGsEkMiLU1pGjuUbJMQKMTZgrGeGS5POmq+fhUB/QtxZAq7aZ74iiEqAvdMF9oqLTPia2DpPnFsFiZByjONbHr2T9g+fyBUS6j180aYpdyEyc+Legj9ifoklYnaeI2L9bowk8vgiWW365jSjgLF9mi8nHIax3lQOJm5Gh74ksWy5Qh/Dr54IfpAerGuvT3HmylJER53292vQah9pTp3P4D1p49WHtDxsLwTgNf1Z7sOFG2xNqMU6TQ2L88Lq3Op3tHbfDZSTMbXMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HYLBMqxD6UxBCrWpE0qRwGfiUMRJ3uw+g7o53hU8Us=;
 b=NexLn7C59a+QNR1GocLoaohiWmwxXlEE+IlkKXYwLW7+kkvdc9uIDuGHHgGwxKjnFUuuNsHvu+c9bgyWcItUXAerev1LNmpTogFVMeO2fK1lpaPeYnuWa3qJCC2rsm4McRUDN6mKByq3mZ7DlGFF2sWXLgPM2nu1j/lKzFBNybhX+llvsivUCYcnHvIU7iHswWMljedRd4zvi+cdNyF6/Bu5nIMB2lskrDptsp1HeOSPr7zWJlTNCkScgmME7bIBa2yRwYmLiUjDJAJo4MAM5+RvTphWyNG0mDBnjzXyrrsjY/HQ9oOya/4Hai8V+98rvIKBIm8CQQrcgSStPwPv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HYLBMqxD6UxBCrWpE0qRwGfiUMRJ3uw+g7o53hU8Us=;
 b=fwxvdm8o777xfFBrQL88F1XkN9sPmJy0ttvIE6p6L83xDkO1X5nkrEcFWjiNiG0DqubqYG1nJWIpIQc7Lb+QkXE21Aar4Xl5BqZKxXWeSFZ5N2ici01NWodLupQfRs1weVxSCVtErahRVrMSgmI1xBbt7hBv5J4SoT+fWYtipyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 08:47:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:47:32 +0000
Message-ID: <856cdff1-cdf1-4e90-978b-e090a2ac4195@amd.com>
Date: Tue, 12 Aug 2025 10:47:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix task hang from failed job submission
 during process kill
To: Liu01 Tong <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
Cc: gang.ba@amd.com, "Lin . Cao" <lincao12@amd.com>
References: <20250812083116.4091828-1-Tong.Liu01@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250812083116.4091828-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 560f9c4a-fd70-4c1e-5f66-08ddd97ce01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWV2N2IrSklKc2EvaHdaNDRXOEFNYWZkNUlWampMVDk4c2QydkRka2gxK09R?=
 =?utf-8?B?dWVnNmh3QWNHR2N0emprRnJnbk44YU1tZ29meHh4dFFtOHN5NXpCV2pIN2pK?=
 =?utf-8?B?TUFmL3hTZGdSTDJvTnZPMSsyYUhWK3k0VnZ1eG5LWk1jWHp5UDMxa3Vwb2lY?=
 =?utf-8?B?N1NzNWI5MU84UE81RlNGa2YvTXJMSjlPaHNBMXk2NTIrbXJJZEFtL1c0ajJy?=
 =?utf-8?B?ekNHM1JTdEpEWnd5cHI1S3JrQUhlV2U3Q25LK2I4dVJ6ZC93T3lZQlc2aUJ6?=
 =?utf-8?B?b1hHN3ZHNmZzZ3hiaTdKUHh6QlBpZTZYdUdFY2c5SEFwMHpEZGMvdGQwS0Iy?=
 =?utf-8?B?ZWszcDlSUXg0OSs0UkYzNDhsSHZzWHE5dllKVjZRWEoxQzVPeUZnRGI2VDRj?=
 =?utf-8?B?MlkyVVdHaXhBMTUwQXVHd2FBVFhENjJaZzBsTFUwV3FZVmgxMkZDYjA4R3VO?=
 =?utf-8?B?bjZqRVErTlhpc1d0SVp3eVEwVFVsQjd5Z2VPQzJSTnBhNGxoanNBcG1nVXhU?=
 =?utf-8?B?bFZGNFhSUHlyc04ySmpCUkdoVXNtT2pXdzN4QnNyUzNKMWc4MjIwL2ZmMXhX?=
 =?utf-8?B?ODlHSkJ2MldDb1dzWHB4WW52MnRMalN1ek9pQ1prdUl1YW5ocU5EWWRleFls?=
 =?utf-8?B?WHV5bWEwTWt2REVVNmcrcVc0SjVNTCs0aDJ3WG5VaUh4TDlvS0ZmQTJyMXNI?=
 =?utf-8?B?TXV6cFNpQ0FtcXdLdFd2NDJhNHhUSmpzSmpvVXZ0YTdHZmp2cW1YUG56dHg2?=
 =?utf-8?B?Wm1MREVjMWV6N2djK2VUZjJ5L28yb1ZWVU5sd2VzTkRTNFozNEp2cmdFMlNu?=
 =?utf-8?B?dEpqalFsU1p1SXRuNER1R2kyR2FUWmFjTVRndklCa2JzNG42ZEJoMS8vL3I5?=
 =?utf-8?B?Rnl4Q0hLd3h4SWJ0NTdqQWY1L0xKZ09QaWpCaloyK1JYdkF1alVxV2xzUE1K?=
 =?utf-8?B?bXlYVXBINnlzN2ZrQ0xxU2hWd3pobDhJN1hiR1RjNkN6eHJKMzFLVUpxQjJN?=
 =?utf-8?B?S0d1VUJNc1FJUWhGU0sxMmdWK3dNUjZtcXF4cnpnWnA4Um1CMUkvRXZFd0Uw?=
 =?utf-8?B?V0pab2c0a3RZOGZsWDdlc0s5M1Y1SXFRSHI2UE5zakw1Q3d1bUE4ZGQyVnFQ?=
 =?utf-8?B?UTlCam4yc1AxVENWVHFKSmkweENWTENtTWVzcitya3loQXRHNzArNUdSLytz?=
 =?utf-8?B?S0EyUWNCTkpEb3ZsMWVDaDBBbjl5WDRnK0FXR1dDaUFjQlBsdVkyOWNKOXhC?=
 =?utf-8?B?NEdtOUlNTEo0WURUb3orQUpmWUpjTnhYQW95L3RtTEFxakpZWHJ5cnBFUHRp?=
 =?utf-8?B?WVZMYXZzb2YzV21uMVZxV3hyb1BiNlRjUWdSYzdxUW5KVGJPRHIxVFAxM2E3?=
 =?utf-8?B?Q2QvSm9kbDYxM2hVRWZhT3Q1NldVUTFpdE1rbDQyZ3hVQlBDQiszUWZNMnVz?=
 =?utf-8?B?cW1BMVdDcXNCZitzTHpUb0NhZDMzZTBkMVo0UUtyclkxNFYyU1VLR1JVbzNQ?=
 =?utf-8?B?REx5OUhWQlFuU3BIczF5czU0T1pwUzZCRW1mZVRWRElSd1gwVWdoMXhVRlRj?=
 =?utf-8?B?MU12aTFLKzZ0Rnc0WkplZmZsNkhnQWxZMkNFUmZqcWd4Zm5IekF0em5oQXBs?=
 =?utf-8?B?T3lBbW9GTTVZUFJPM0ZlcFozOVEwNjc4UG9YV0RLYm4zUmEzWlNtamVaWGR3?=
 =?utf-8?B?eWE5ZU1NWVIzdjZKZ295bDBjbWtRRUlia3gvL1F3ckQ4QWJtdFg1Um5LbUdH?=
 =?utf-8?B?SWJXSXBaS0FXNW9FQjZZczJoaHQwN29Jdml2N2tvaVgxWW9aY2VvUlh1dkti?=
 =?utf-8?B?cUJTTFpwaCthWSs4d3dveVdJbURrMW51Y0MrdGd2UzliMmkyMTVBL0NwbXFk?=
 =?utf-8?B?OFRseDJ2Z0J2aml6dFJMR3I5L1pZc2tvNzhid2NneXJuTkFzeFp3K1o4VFNi?=
 =?utf-8?Q?W1pHO44sFgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U09DdXV1UzZnVFJwN1FsNDZ4dnpwaEFvTC8wRkZNRFJCNUp3OVorN1IraXdB?=
 =?utf-8?B?UWZCUUkvUjdKNnhmQXhrZGNLM0hneDNadi9MaDlOSDZQc2hOL3pmYjIzNGpH?=
 =?utf-8?B?TW12RGpjd1VWUGFnWk9zRHYrdVhxbkNqMTFLZVdxMHhsN1lYYWJaVkU0Wlcx?=
 =?utf-8?B?b3BEK0dvRHd1ZUZsbXkrd0JRcTQ5RGp1SWxTOTJrWURlUy9hRGh3VzkvV2py?=
 =?utf-8?B?ZERISnZ4MWhPaWtMT24zTVpwSk50V2FORjhzb0RJSHZuQUZMZHhQaE1sYkps?=
 =?utf-8?B?Y0pOV1BNdDBQOFhIeWhUL2RxZ3hIcnpSUDR1RWZ2VFRXbjdNL0c4T3hZMVV0?=
 =?utf-8?B?TjNUYzljVUNQUVliQmY4WDFEQkwreGxDMDhVM05MaTBsUHo1djlJU3B0M2xE?=
 =?utf-8?B?eE5US1NFdVh1Z2JxNTIwa0lmU1NxQjhXekk1VExxcjRMekdza1Y2ZkVFZStU?=
 =?utf-8?B?cmRLYnhRQmJ6Vm1hTTFlNGNXR2pHQ01VdGJDYkhnRFgwUjJDLzNoZjI0aHBp?=
 =?utf-8?B?dHNBQnBubDlVQVV3WGZma3ZHYjhFc0hjSUhTZjFuQXRpTXBINFlTelc4UmhS?=
 =?utf-8?B?Q0crN1Q1d2p1djlndFRyS2luYVl0UklqanlMdTk3NVFEZmtPMXQ4NXVYYXhq?=
 =?utf-8?B?eC8vamhoY00rS095YUlVdmtTM2dSTzh4YWROdW5ma1NteTE4ZmRrV3ppbFlm?=
 =?utf-8?B?UVRPRWdPbWFOa0xuZ0VtaEllRnZ2R1J3aXpJYTBaVTMxaUFtVkZDYUk4RkFI?=
 =?utf-8?B?bzlXRkp0eG5yNDdjckNyZGFaZHM4VDMwT1ByeWZKOHBzbGhUamtVVWtHQmZD?=
 =?utf-8?B?MHRtUUJGcmFWU3dFZXlNQTUrWkdacDhOOWZsYVpweHhGVjEvUC8xdDd0aHpY?=
 =?utf-8?B?Zjh6OS9ENFJiRVUyYjJ5ZnJVWjBNK0xkTlZzTGptbnU1UVhseU5RWFgyKzh2?=
 =?utf-8?B?dkFRcUcwRURPVmk4em4wSmoyVGpnLzYxUjlDOU1UdmpkUldqcGdEdWIzTnpl?=
 =?utf-8?B?M1Qyc3Rodi9EWkI2b00wWklEVlQ1UjRmWkMxbmhOTW1WclpHUS9Kd1VRY1BR?=
 =?utf-8?B?OWRXK1JkeDMxdDBuNnM1RTNFR3lPS3RVdlVDeFFsU1o0MjRqM2Z4SUMyZ09r?=
 =?utf-8?B?RjQyYi9YbnF3SGZUOTgwbis2eURLenYyQ21mU1ZLeG9yOFdJNjNGWXF1WkY1?=
 =?utf-8?B?VVBCbkRuVXltdEJUV3VjK3RhRVVFam1JWFlCd1llUGk4N1U5NDczdGhBVVhF?=
 =?utf-8?B?U3h6Mkxqbmx5c1NSWE55RTRYWGtkV0o5N0dpOWZybTJ5SEdiMEp3TXlLTldV?=
 =?utf-8?B?Q0hmK3ZzdGtJNDBiMDdqMno0WENEWU8xMmE4VWRhUjlOQXNCUEhhMlZRQ3c1?=
 =?utf-8?B?NU1JOTlOOG1Yd2RsTlBDaWN1c3RST1ZFay96bjZCOHhhc0Y0Tjl3U2dhRFRE?=
 =?utf-8?B?MzBreFVrWVhxQjdBM0pTSnZhb3VqV0VsVXhBU2UxZHJ3c0xTYjAwRWlnQzBr?=
 =?utf-8?B?NFhkU0toUmdWWXZOU0JoU0dWdkFNbUJBMnhEdW1sSWdERDJHeHlHNmo2cndD?=
 =?utf-8?B?ZWZFWnlyTE1wblNQdWNWbWJNSFRVZk54RGtqVkJuNHBoYjVPc21JeVg4TURI?=
 =?utf-8?B?QkU5ZGU3cm5DRnZxYlh6VVhWVzFkUk9oMnRyTjZIUHF2N0hGNFpWcC83MnR2?=
 =?utf-8?B?U3BUcHBXU2RqakdNNkx5bTVFdHF1R2NPNDFUVVRZdS9YZGZZNjRvKzdJN0pB?=
 =?utf-8?B?aGwvMDVrbnF6ZE92dUhjNzJMMFZEOURZeHZMUDZCWlQxdTBPVlR4WVZYdkxL?=
 =?utf-8?B?WGRaWW16N1dzYW04aTEzNUZjb3I2U2p5N3ZQb1hSNWUyVGtncTIxSURTd2NF?=
 =?utf-8?B?eW8yc1llRERlVjQwd3Y5aVR3bllHZWdXS0U2Wm5ZcEp2bHlvbWpPbXIvaXNP?=
 =?utf-8?B?UlVmYnJqUkpOdDNLTW1jay9vc2ZDV2greXZwTmpaMTZCQ1lnRW1vN0JzV3Qy?=
 =?utf-8?B?ZDFyVmNQRXRlVWFibWJpSFN3TSt6RFBkazE2VzFwVFIvaVMwS2dGQi9VQkh2?=
 =?utf-8?B?Q3VqS2JHMmVOWUZBWVNpVTFyK05aeHFyZXZDekRVQUxaTzZsdmNVa081bXJr?=
 =?utf-8?Q?E0tHyDacXvTHVFg7OoRaHkc8j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560f9c4a-fd70-4c1e-5f66-08ddd97ce01e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:47:32.1529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFtcVOw1UhxknPsfol2QcnnBoFZOlg2+K9sSTMt+pMBKTpjaBRyP42m7L+ym7Diq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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

On 12.08.25 10:31, Liu01 Tong wrote:
> During process kill, drm_sched_entity_flush() will kill the vm
> entities. The following job submissions of this process will fail, and
> the resources of these jobs have not been released, nor have the fences
> been signalled, causing tasks to hang and timeout.
> 
> Fix by check entity status in amdgpu_vm_ready() and avoid submit jobs to
> stopped entity.
> 
> v2: add amdgpu_vm_ready() check before amdgpu_vm_clear_freed() in
> function amdgpu_cs_vm_handling().
> 
> Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
> Signed-off-by: Lin.Cao <lincao12@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index e1e48e6f1f35..cdc02860011c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1138,6 +1138,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  		}
>  	}
>  
> +	if (!amdgpu_vm_ready(vm))
> +		return -EINVAL;
> +
>  	r = amdgpu_vm_clear_freed(adev, vm, NULL);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 283dd44f04b0..bf42246a3db2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -654,11 +654,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   * Check if all VM PDs/PTs are ready for updates
>   *
>   * Returns:
> - * True if VM is not evicting.
> + * True if VM is not evicting and all VM entities are not stopped
>   */
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  {
> -	bool empty;
>  	bool ret;
>  
>  	amdgpu_vm_eviction_lock(vm);
> @@ -666,10 +665,18 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  	amdgpu_vm_eviction_unlock(vm);
>  
>  	spin_lock(&vm->status_lock);
> -	empty = list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->evicted);
>  	spin_unlock(&vm->status_lock);
>  
> -	return ret && empty;
> +	spin_lock(&vm->immediate.lock);
> +	ret &= !vm->immediate.stopped;
> +	spin_unlock(&vm->immediate.lock);
> +
> +	spin_lock(&vm->delayed.lock);
> +	ret &= !vm->delayed.stopped;
> +	spin_unlock(&vm->delayed.lock);
> +
> +	return ret;
>  }
>  
>  /**

