Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE78D33998
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 15:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3043E10E120;
	Mon, 28 Oct 2024 15:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8ME30vQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA810E4FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 15:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxjwDMxQFN4gYY/Q8rceA6yK6zTXrek2vRgAyRgT/xA22UsrPfGnMtz9DKAI2/BJqwkUZbKL8dVUPf5AHk2f9N/rEBzgURoCjYUWzSNFi1aIdVT8WhOqvuZo0RChpukq+dZ/LXMbpWYtNcrjPnP5q4GopES4Y/iPiavUxNo0vIY4jTFd8oJYZ4tZ1cG73A08bDNZmVWrIQWJqaEgHWf51Ymx+/58wGvNV9OfV55dgexOOpJb6w/e9JZCEpKKnPiiSREX7jzki1qSfPGiHKlMG+eTxMTty/csMbuuGxwaDz0WWt8f/LFx6s/DS5kI3kln7nzysO4j4L92JS8KhLH3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaTRIHJEYopxbNGpMG4KAbRb/FThAWHCJh9+LUJsHXY=;
 b=CFLMHofic8eJcjz2obPnlXVuuA6pPN+ZAdEQTdn3BQVLf/RkBNgQNPOtNVZgljG2ZK6fuHolKfY6PQtt3kWgtdv466+H4UZYtUXRU+SK5NhIRb7P/iO20bHOuvkRvY7xxI2EJtQmNsYGxzCnZXVf3CQvkAyYJ9TjtxcRbKgSl8zfCXB9Oz+6q5ygkjuqhdbmNd52vMb9+4laoBzv25OgHDShuLyesy09m931f2IwLQbeuxkZ9fh4/Hm3vXghClHGvAnl3DvXaYflT3W7ubH4ZExgL0gk65yYTXgQOYumVYt8FkE29FPdj4/YjCaRvcQCIXjYX1pV/zzQVh59MF+EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaTRIHJEYopxbNGpMG4KAbRb/FThAWHCJh9+LUJsHXY=;
 b=k8ME30vQ/FoFCT9mOQpyN7ACNXnjUCPlJMuxny0+sWikYXmzYDUe5pu2tVvGmASOS5dgX+qXzm7HszD7YGSxSi99o6eV8L4gWIEEhatlf9Hkju//5d7FxBQnQyxJCSkJHqQYh1FVAo/AKwfhdSXQ8+8CErjv0Tw8Ef2Kws8ux/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 15:40:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 15:40:59 +0000
Message-ID: <e0a3cc5c-d7b3-4bcc-b136-2f68513ccb7c@amd.com>
Date: Mon, 28 Oct 2024 21:10:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add ring reset messages
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241015181541.2457526-1-alexander.deucher@amd.com>
 <CADnq5_NHmJpZLbbrEsN75gkLOctFtS6nyNBHfgM-0=EpdyKFcA@mail.gmail.com>
 <CADnq5_MAExjgh8xYzfjSPxFUYV-17Tukh6DgH41ba9t6Pe8EoA@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MAExjgh8xYzfjSPxFUYV-17Tukh6DgH41ba9t6Pe8EoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: e3db02de-6e58-42d5-7c25-08dcf766eb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGgxTXIrUVB3V1ZPY25ZUDlKNEJHbXZxc3dOK1Fkb3dlT1I5SXNZNXZMYkFv?=
 =?utf-8?B?WEJ2U0xPenFQNTM1ai9MNFhQQ1Z5QSthMHJPdUdBQ01FWWlGTFhkS3JSYlpk?=
 =?utf-8?B?bnJ3NVNKeVEzT2cwbFNKcXJlelp6L3Q1RENTc1JLUXdFT1IyOU1lRFFJN0dj?=
 =?utf-8?B?M1hMQWtpUzFvNWYyZUVETXVNQTVYLzVFVnIvazV2TnQ3V3hiZi9UNUdKVHJj?=
 =?utf-8?B?QUdLYW1lQVp3S25SQ05Deno0c0JXekx0Y2NackROYzJZWVdFdlhWSEVMaVFu?=
 =?utf-8?B?SHcxYnB1ZkhUSC8vWDBFb0kxSytnUDUvcmhuQzM2Y1YrektpcXRDQStFRGo4?=
 =?utf-8?B?RW9YRUh1bUNqTGt2OEVBTGRNL2doa05aaDg1N2xjbFk0MzAyVHEwTnV1QlBj?=
 =?utf-8?B?R0RQajMzUlpuR3YvVTVEYWhnaldPZGR6aU5OL0RMNW5yMS9ibEFmVUtMQjFF?=
 =?utf-8?B?cmVCZGthNVgraFc0OVJVUVJxWWFIdDVmQ2JRQU4yeWZrZlg3RDNkWTBENkZJ?=
 =?utf-8?B?dzNyMDd4VmpDQmRaRmI2aVVLSzBGemtoSDBEQWZMVVoyR3d4TnU5ZFV0SGtF?=
 =?utf-8?B?VncxK3krN2JUbm1HS2ZGSkQ4a3RDcEJpUEdkaUVzSXV3dmFuQWlHdDRmejNC?=
 =?utf-8?B?WStFUko3Q1BtYUJiREh1SXhrN0RVRCtNYXFjeWpxN0pyYjhPNlZyRkRCSHZR?=
 =?utf-8?B?U2ZGTXd6RTNHaGEvZ3BwU2RVRmpPcXhpWFRlSGRwQVpCWHFLUzJmME1XUU1q?=
 =?utf-8?B?NTB6UDkrelNMd01waDE5K3hwKzZGUU9TSWt6RmQ1c0NKWVNOSkpMQmI3RWJI?=
 =?utf-8?B?WTY2SHBobysvNTVzUGJQb0p2NjJKd21DWVFuV01OazNRT1lrUWUrcmFEcDhJ?=
 =?utf-8?B?NmNTSm9Xejhwdk4zcVlPR3YySG4xRTEzbHo5N2p3cWtPaEpIRjR0M1BzM0hh?=
 =?utf-8?B?RzZCeDloQ0xNb1NiRFJpWExtei9MUUVoUnlia1dlenJBaGNHaVQ2cWtmd3Fr?=
 =?utf-8?B?UkM4aXFISXFXMkZFMzRUZm5hb0xuc2xyYkJrZmE4UktmNWxpOWpERitrK1pT?=
 =?utf-8?B?dWY4Mmt1bkJodEtFR2Z0RVpqUjAyNlhwRXFmMStLRUtsWFhTWDdSbDBmTjVN?=
 =?utf-8?B?Z3lmRXpiQWZkNFphOHhPUDhLcXR2bXRIZlB3TmlTbHp4TXVYZFBNRUQwT0hY?=
 =?utf-8?B?UUV3UHJnSTBQVmpQOWozcFJVNDlVdWg2ZTV3RWJ6YXI4SmNZVGllN3J2TXNu?=
 =?utf-8?B?TFNpaDdIWTlrQUpsL216alllRko3T0JQUGxCY1NMM0Q4Vm1wZEN1WGFLTnZN?=
 =?utf-8?B?dzB6cVA4MmFjK1R3UDRQNG5uNWNHY0l6VXU4ZUgyWG0yck5PMTVGZ3l6VlRt?=
 =?utf-8?B?ZGJBdjZ4Mk1nMlZ1TnBXYkF0MEMwYmJjMlF1NUZYc2h5eEtoYURZQnF5YTZj?=
 =?utf-8?B?eWVTWU5aRzdjZURCV3VRcGt3RWlNQUtNTjFyaWg1dHFObEZENDlBQ3EwbEp5?=
 =?utf-8?B?cUd2bmx0ZDZJdFhUK2pZL1BOOGhyMUdsWkk4R2I1Qk1Qd3h0cElOMElHaHpI?=
 =?utf-8?B?SGxMUzZOeDhsVzFmdGFiMDF1N2JyMDN3LytSVGpNYzZuTEdsYlZHN1V4VWJK?=
 =?utf-8?B?dzNLTDdoYml1bUgwdUo2U2pEMTFOQnROcE1aSXhqN0toc2pkcXZBWnhLcFd1?=
 =?utf-8?B?aXIvR3VBVDVwR1hDd3BXditueWF2QTJBK1VpWUdiWDZhWFpQU0ExWU1rR01S?=
 =?utf-8?Q?k+8dzgT9Z45IQjqxq1gOMqya2UYdjDrNAdRvjxV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNTdUU5bk1xVThkVm5lRFo1a08vSnlYY1prdU1KbmgxUTZ0eHJlQUI3ckZJ?=
 =?utf-8?B?Q2pSRGIxdHB0RUpOVDRnUGhmZnF4Ny9ZR3c2Rm5ydDdsb3ZXZ284VFdRbmp1?=
 =?utf-8?B?UmdHc0dMRmVNQ2JNN2h4QWdKTjhSbEg4NmNEOWp5R3UraCs0ZXJqZVdSM3J0?=
 =?utf-8?B?OGIvSXUzUlU2YkdKR0F5eURxdlhTaWNjRE1od1VPcjhJSGt4dXhKRHd4YU9B?=
 =?utf-8?B?UVNlMjNNWjJocW1WZHlSNzc0VTY1T1hYZmREYlFvZERoTVhYTWhJVWV4OFcy?=
 =?utf-8?B?enFtM29TdkdjcHpSS1p1ZmUrT1FkdExDWnVQR1JUMFZXS1NOUndwTXI4Qkho?=
 =?utf-8?B?TzkyQStJOGUxblBSa0dsdUM4UHkySHBJVUhvT1ZBa0poSlRQbC9jbTJSdTZw?=
 =?utf-8?B?dWVTOVZVZit2dStuaFdMWTYxbDNQY1FZMFNPWDIvU0NFVWJtMXRhK2tvZytT?=
 =?utf-8?B?cS9xekJjL0p4SkFKRm5wUFF6ZENMaDRVeG1jRzZXQU1OZ3NIVW51T21mZnZJ?=
 =?utf-8?B?ZGUrOWIzWWxOYlY4OVAxcW0zUzVXbmRRQW90K1VSU1ExUG1lVGFSdkZ6T3Y2?=
 =?utf-8?B?Ui8rcVFxMTBYanQ0ZXE0NVdybHN0QXBZM0k5WFdpU1djTWNGVk8rdXl0enBR?=
 =?utf-8?B?S01oNzhkN29XRlpsTDlKbmpjOENGOThkVmp0V09pZHRoQXpFOXJ5R3dGUlZr?=
 =?utf-8?B?RnpjcG44NnlKTWJ6U1Q0dTlqR0JCRnRuZFpZNGl0cTZockdtREVNdXd1VW1p?=
 =?utf-8?B?VE8zNWVWVW1XK0pyb3NZZStqUk1Fa1ZXZVQySW8xRjNRMGovL0E1RjBuZUFa?=
 =?utf-8?B?cFBWRk52Ty94WnAzemJtZ3dLQWhSaDNVa0trMUNtYXdFSDlxTjF1ODJXSTlm?=
 =?utf-8?B?ODVVRGRZSGF6SHZUV1daRVBZSTZZR1UwNGlrTDZjekZYaHFiRzdVWEYxeG11?=
 =?utf-8?B?UWJvQ01NWnBKbzdueVR1QUR5UVNZQkhRMU1jQlhlVWxUYmI0ZlBuSFhrOXBR?=
 =?utf-8?B?NG5RTlNIMFlaQW03Ky9SU1F1YWNhRHBSNTNGNmx3NXpVbmRpWlp2eit0eXZj?=
 =?utf-8?B?TWUvMmM1OUMwSS9IejlrTHorbFJsamtSN0NENzh2dlZtQk0yMVduQ2dYTExQ?=
 =?utf-8?B?MmtnR3hrbEttUjFsb0xLK0lXa3NucFJsUXRjTXQ5VjJLLy9lOUl3TXJIS1Fk?=
 =?utf-8?B?L3VONmJUTFcrMmZEMzJtaVBzSGVzZU9IMkc2WGpiOGh4c2xpM2NHNEMxbjN4?=
 =?utf-8?B?UE0waU1uc3JHWmNQaUlHWGF6TEYwcWQzL0FRWHBrajdrQW4yM3RsVjl1bGly?=
 =?utf-8?B?ZnhzTjR2RldKa2syeGdvdjFmVFZlYVJSSzRPQnA0ZHJFalRtZFBhUC9wMDFZ?=
 =?utf-8?B?ZHBVMWs4Q3VMMkphRGdrZnRNNHJmckUwVlg0QXc5cWcvMzRkak8rT3JuQkls?=
 =?utf-8?B?Y3VUT3VvUnFjWE51by8vaHVReWNVS1dHUTcvK0NRMnNIKzVVZGxoaU13Z0lP?=
 =?utf-8?B?dEtOOHdMOGxUZXBpRlhPUjZxNWw1d2JTUFM0NUFJVStNbkoxY0lTUkRSRDQv?=
 =?utf-8?B?b1J0UHllUyt1VVI5bkZoUWxwcG9uLzcxSUZsV3FPV0tnS1lnM25wVGFWQTFq?=
 =?utf-8?B?Y29rNzRUR1BOTmREOHVPd09RVkgzVGJPZWVKVVNYeVRKaGVTd0VUM010WVc0?=
 =?utf-8?B?b2cxY3RJM3FlbkExSVU0TW9yN3R4Zkl3MUx0VUQ1aXNydXViRXdqeldtb0d0?=
 =?utf-8?B?SEI3WjNYOGU0U3N4NG4vcmtBaWM3R05sdXhXZFFKUUM0bDdoWEN6L1R2L0xK?=
 =?utf-8?B?MmF3TG1sWHB0bXYvdytzYktKTS9nVk1GOGw3RDh2MlhFRVExUHNJR015ckNK?=
 =?utf-8?B?TURpdit2VHlIaThVazFnUEVZdERTUTFZbUQ1ZkhTaU84K0Vjb29RRjIvTEtP?=
 =?utf-8?B?KytsZUxjZ2FZL2xqYWFoYStvU2xzRVRVeXdzNE1wNEF0Tzh6aVY0UTlIYXow?=
 =?utf-8?B?RTNRaGJEcEdkVWs2OTIrU054YVhnSmZiSE9Vd09jdWlDSHEyQXVUMmk5N1NQ?=
 =?utf-8?B?ZGthTGF6aURmL2owVEIxR29aVEVUZFFDbTlHWjlKekU0czNaOGRxWWdFM2F1?=
 =?utf-8?Q?9cy+y9PtwCK25SUlFaACkNbEi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3db02de-6e58-42d5-7c25-08dcf766eb98
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:40:59.4807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlWu1K/ARLpTOEWaW/on6NpmzBjwd0Zf/A2cVeGKTA2GtW8ABGKbqZ0eM5wbsylJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
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



On 10/28/2024 8:11 PM, Alex Deucher wrote:
> Ping?
> 
> On Fri, Oct 18, 2024 at 11:47 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Ping?
>>
>> On Tue, Oct 15, 2024 at 2:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>
>>> Add messages to make it clear when a per ring reset
>>> happens.  This is helpful for debugging and aligns with
>>> other reset methods.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 102742f1faa2..2d60552a13ac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>         /* attempt a per ring reset */
>>>         if (amdgpu_gpu_recovery &&
>>>             ring->funcs->reset) {
>>> +               dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);

Is dev_err intentional or dev_info is good enough? Also, suggest to add
ring name to fail/pass messages.

Thanks,
Lijo

>>>                 /* stop the scheduler, but don't mess with the
>>>                  * bad job yet because if ring reset fails
>>>                  * we'll fall back to full GPU reset.
>>> @@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>                         amdgpu_fence_driver_force_completion(ring);
>>>                         if (amdgpu_ring_sched_ready(ring))
>>>                                 drm_sched_start(&ring->sched);
>>> +                       dev_err(adev->dev, "Ring reset success\n");>>>                         goto exit;
>>>                 }
>>> +               dev_err(adev->dev, "Ring reset failure\n");
>>>         }
>>>
>>>         if (amdgpu_device_should_recover_gpu(ring->adev)) {
>>> --
>>> 2.46.2
>>>
