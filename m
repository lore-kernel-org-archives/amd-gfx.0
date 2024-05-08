Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12BDC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC8E11313B;
	Wed,  8 May 2024 17:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lRSjfAef";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11955113139
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+gEGLj5QPBdbE4YCUoY8aBCtTQ4jM+jMuei9sTiQGhkLreBrC1JMyxIDeRzvaJVDwAE+2Z6TFFyKb2NRmFEq1em+CfSznOjeUxg2OSqA8PVTDQmYST0G7CarXlwkzO1akJH/0YAJUdig296p0nLJgHIdjiiT3ptM8Xf9nZwBhhiw8G1ctZB0bHof4cYdlJP3mr23/IlJ6ZGeiRF61bkpQPBmG5+xM3FRddH4I7RLBmRcSDhd8TY/aph8v7lBbfJl8dJihb8GMTPzvTmJxI3qSchzqgdD+gduLW5wm/Ws08VPjKtOG0MZZNTjlHfgiWFaGC6R5v5otLR0PTOfpKpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdBHBt3/zHyTXMlloVGmnQ7LG/iLGMbcO5D/CZLfxr8=;
 b=oKSria3ri7bD4B+2kSGSLHKEIuaYr4yo7+aGlutRQD4t/xRzgwQJfHkTNTElcyu09rE1Pp+Bz4buYyAoPImxTymOD/qOijHwcuwb0FdWys0D+3ifNZbUfZtZ7Y3eQ/2rMV5iWpue2LiAQKzynrOs+jzuqU6w4nOxTF0tcg5uNp3iqwEvO4DpQR57ZCs9HnFVoLKzQqfKSbGyDEYuTtX32aYIHiaPvoGj1I/pQXqolyi1f7xxr63LCkNrkRltW5b4CkaDlPkpa2BeHx6VDgR8XefW0Twev1j75NzHtYGv5VYdHsC2VdsgM4QaIiO5/yIql5u2jtjMo2firAawRcxLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdBHBt3/zHyTXMlloVGmnQ7LG/iLGMbcO5D/CZLfxr8=;
 b=lRSjfAef1vVbMmYLjpu0nzSV1GKaqXLWP3J9FwYisSDEa63U1SE0Aq5PiXEdqUyVE3m8MELy4bMb29/LPKpZrlO4iuH6Auj20AiExi7dM/klyalASm007QNeq4gpxgg2zTGhBIVIozd7zr1OwYEuYuBGlIWVu4KVZQ1v59VOmJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:25:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 17:25:40 +0000
Message-ID: <d35c5f43-0c88-4437-b0fa-1e303ba41c96@amd.com>
Date: Wed, 8 May 2024 19:25:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel@daenzer.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240508131916.981456-1-michel@daenzer.net>
 <CADnq5_OUpzEi=gjbkaMg2ZueEbcvPB77v2W1dHiU=TE2o_C17Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OUpzEi=gjbkaMg2ZueEbcvPB77v2W1dHiU=TE2o_C17Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0234.eurprd08.prod.outlook.com
 (2603:10a6:802:15::43) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e84af8-5d0a-4622-f7fe-08dc6f83e214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTl0VjFUbVBueTQ3amNDRWU1R3VtVUpmd1RXOGN0bk85V1JjejVZQU84WjBN?=
 =?utf-8?B?WHkrUGdOVm1IVlB2VmdmZlgwZlRZTFg5ZTYwRHJNRlJDbnJoV05KUHF5Y1I0?=
 =?utf-8?B?V0ZYMFEySjRoUEZEeFBwYUhRcDNEVGdtTVFzV0NtZWFqdmY5Z3RzdEY2YXlj?=
 =?utf-8?B?N3V2eGxsWUNveS80NG1ZQm84eVErSnlrMlk3NEdkb2Ztb00rVTBpbU10Zysz?=
 =?utf-8?B?Qis2SUlhZ0tiOVMrQXgvLzNHVE40a2tlb1ZaYVEwNWxtd3F3eUNvMkVESEhy?=
 =?utf-8?B?RmhobFQ1Q3NKY0dFNXFnMlc5Y01UUWVEM0RvcDN3N0xaK0NPYTRScUs5cTVW?=
 =?utf-8?B?SUllNVhnamhwZmUzR2U5UHMzMlJ1Vi9ZbkVuQS8rVm5zcmhZbUhJRlAyQXNU?=
 =?utf-8?B?Q2xhRkIrUjUzODNONHZ6S3VaWU5VR21mZlpGZ2E1N3ZhSmFsSUJnME9oMmFF?=
 =?utf-8?B?WUthL0VYQUNEOXk3SjlsNDA1cC96QVZnQTA0M0p4QlBBTDZ6dThtS2FySjZU?=
 =?utf-8?B?Q2l2L2NOR1dGemxkeGJTeWVOeWFyTnJSVXJEN0xCQUFGWFNvMkdQU2JvWmVa?=
 =?utf-8?B?dTcyaVUzVWRRZFJVNTFzcmgyQ0J6bXcrMnNybzF2eDVGaDZJYk1vMFhtQ0Y2?=
 =?utf-8?B?RnI0UnJwb05wVHRmayt5WUUyekVGc1JQR2tPUnFCSzkzZWFHSE9vQzA3cVJG?=
 =?utf-8?B?R0Qxc0ViYkFHTEVscTltcVovajVudUoybldvc250OU5lUGl2S0RmV01ldkRo?=
 =?utf-8?B?aTlYREJSMXBYQmxhSGg3TmhLYkkwM3ltam1qL2R1NnpVWThPdHdSVnU5QjJR?=
 =?utf-8?B?OTZTcnEyMlVmYkR2SVhrQnVaL1hFSkJxdjQ4Ym9HNk0zeXJ3a1UrMWsvaENq?=
 =?utf-8?B?RG1tT3FkOStWT3l0eVpza3hTOTFJcDFkMks1dzh1YTZuV1hsd1JYVmRFWDQy?=
 =?utf-8?B?M1VRMHpoRTE1dHBhbDdVRVF3Wmxuci9NR002ZUNXVFZqUitHVVh0Vi9nVVhq?=
 =?utf-8?B?bGJNdDVqaTMrQXJ2MHFwL1VSdjBtN1YxOE05U3lkODFrbVJjV1BoZ3JlUGlS?=
 =?utf-8?B?WFBKR2pFcjlZUnYra3UvSHJWK3BMR3pYQWNxMDhLTFFzZEVyM2ExQlFlUE90?=
 =?utf-8?B?enZDWjN1c21GMjVOT0I1RFNISFY4UkJPUWF5Y05YMG8yYnR3Q20vRk5iWFEw?=
 =?utf-8?B?LzZFMm9ET0tsTGNtZHRYRmY0ZFQ3dUtUZElGaTVWZ3RqMXl3UXIxbXJCOVBK?=
 =?utf-8?B?WmtrMEhVNXlOcmw4YkhreUc5eXBQQXhVNFQwcEx1Vm9QSzFqVHVSQkphRE9y?=
 =?utf-8?B?Q0c4czlZc21GZ2ZHNXd2NWswZ0l5cXJDNURRaitFOFFBMGFEUWdNcGZWT2o4?=
 =?utf-8?B?Y01ZWjJVb3FOamJINDBEbGFYNjNQTm14a2lJQms4Z0lTNEd2R1VhU3VyUU90?=
 =?utf-8?B?S1NaZWVCeDhkZmgwRG1nakpOV1lCWmN0bjZ1eXBTMmtOTm1pSXJVVDRRTkw5?=
 =?utf-8?B?YzJVRTFJd2p4cmZIMEtzb2NKNUM3MkdZV1dWSTlWTytySTE1a2JrWTN1bzJZ?=
 =?utf-8?B?SG1yMW1mNnpvZnRaTzVtd2lCeWtncDhuZU5lUUxBVVQrdEtEaUQzaWxVTEdo?=
 =?utf-8?Q?65r01146/L+DOUYZg5j2rpe6DOK6axdWoajMpxeKRKLk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJYRHR1TzgyMWtGV0J1eEtrdGpCU0lsTTlLRm5EdDFCc25Ld3N6bkI2MnVv?=
 =?utf-8?B?MElZRFRjZTM2VU5qOUd3WXZReTFYZjB0K2VBK2VNQnZVckRpWnY1S0VtejYv?=
 =?utf-8?B?VkoyMi9Yd1ljQ2RZOGJscENoT2p1Q2s3V09XMUhVaDk1Y0t6L0ZENDhtQUda?=
 =?utf-8?B?RTJrZS9wN3RUR1hmVFBRN2EwaGMrUi9xcDRNVmM3SE9vWUF0MkRoV1FCc1A3?=
 =?utf-8?B?a2pkOUFUbW9lT3p0bEZwQWVnRHgzSFk3WGFuNlY5R294T04yaU03L01RbUpm?=
 =?utf-8?B?R3lZYWNXOEFub08vNWcwZVB2VUVaeGRTR3N5RkxoajlWd2RRL2JBTjB3Q0Nj?=
 =?utf-8?B?NHBzd1pYdmcyalFFc0x2SFV5S3RTdm5Pdi84OVBQZFJxK0Y4SDNMT1I5cVNO?=
 =?utf-8?B?ZmZISG9ja2RlMElJOU5ZWEcrWTFlU3lpckNobHZSN3puMXlvZWZJV3pjVW9P?=
 =?utf-8?B?V3E4U0FrUmdIUkp2cHRGRE14cllpeVB5ekZ5cUk5bHFydnQrYkdxS2tUeU1r?=
 =?utf-8?B?c3RvNTRSajhmNmFaRE1iZXpBNWtMNlFSTGJZcHRnZXVqWFNDT0V4eHN5OWZj?=
 =?utf-8?B?d1lSbnhEdGl0VlpITUZnVC9hVnVBdkJMaHViU3BiNFdJTXRvaGdWU21WNGlS?=
 =?utf-8?B?ajdJdzh2cm1VNFk5UzdpVUhpOUFzY1g4bTdzbjFROEt4WHkyMG9lNFlEMFM2?=
 =?utf-8?B?ZkFUMXRIOG5Oc2lHd0NzeVAzQzVYNXo3aEgvQlByaG85di9rTjArS2V6RThu?=
 =?utf-8?B?MnJaUzFJaEZsK1AraEFhUE82YkxYdFUrYkJmUEcyTHFScENRZnA0WXpxRUZQ?=
 =?utf-8?B?ejlxVjl0NkI0d2tOY2tsVEcySnZoOGpGTDkvV254OWRNTnk2SnY5NENaVnZT?=
 =?utf-8?B?aDB0N292ZmpLblBFWjBsQkRqMm9qN29adi9PQ3VkYmV0NUZ0MWtCU3MrQ1k3?=
 =?utf-8?B?NVZCU2R2b0RMcW1UUUhwSWh6S3FGcGJleFVmMUtoTWJJOWZrM2U4TTVXcDlM?=
 =?utf-8?B?Y0pjdG00cnBLZmlJYjNBTy8yNm9jamsrZklta0VCZ1ptT0MyMkN4UEMrUVpP?=
 =?utf-8?B?MzVMK3NJNnhmdzJxUlA2WkRtQ3J3a0JEK3ZrY20yTmh0Skc2dFM5eCtHejIy?=
 =?utf-8?B?c2RZZmtQWjhFdnI5WUh6dmdzZnU1UEZyUzZrSnlFRWRSUE1kV3piZkF0NjI4?=
 =?utf-8?B?U2I4T0t1OW91UWVNdDYrSEs1Q1V3QjVGb1pOUEd5WGYyMjRWUHhyU1U0Y3Br?=
 =?utf-8?B?Q1JUUFlaT1NiUU11cVIzaHJ1WWlJYjhmNkVRMm03U2ZLaWNWcUNqUFJ4Sy9y?=
 =?utf-8?B?WXZZazM1R2UwL0ZuR3BMaWZJN2Zvb2FZbXJKMURjLzJEZFpWL3BrNFg5MDFG?=
 =?utf-8?B?TXlNTHlYYW9GOWpaQ2xzQmhmWElxaWd3YTQwcVpLZDlBRElaVitZM0g2dzZm?=
 =?utf-8?B?NFZTOExLb29rSUoyTDMySmQxcHhVcXNhUjJyTVRwaEhxVjRqbXVxT094UmRF?=
 =?utf-8?B?Zjl6Y0dWV1FHUE4wOFN6dlRSQSt3MUt5QmJXVnluUzFVOEZvSmVCSXkwMDFB?=
 =?utf-8?B?K2xOOU8xNThZek1wT21JSm4vTjhGL3ZrVjk2dTQyeFNTZVovelJVdjQvTS9B?=
 =?utf-8?B?Z3IwM1J0SjZsSitNZVVXcXZBTlNBR3FpUHFya2JGTXVhQnZkeFppSjFiRU1q?=
 =?utf-8?B?a2tSQVZGMnhzZnRsdEdJcUNtaVk1MGtvOTVYQngwVHdUZjdKSWJ1eHNwMG1C?=
 =?utf-8?B?MnRhU3d5MDQyS3F2bk80aXpzYmpVM21HRGJVOTVQaHBTekFwNDRJVWUrWDdK?=
 =?utf-8?B?bE5ySXJySzdDL3NQU1VONHVUazV5V1NXMFlQNFZha0xaL0xSYloxZTZ4M2xR?=
 =?utf-8?B?Rzczeld2QStwWFNhWFVCUXh1ekQ1VGd3REFRRzhGOGZOamUzVzlkRkN6SjNT?=
 =?utf-8?B?b3Faa1ZSRTJsNGtRRHVkaDlGRHpOYnFXSmlhd0d4QWpHc0pPdWdQODFkdkpI?=
 =?utf-8?B?WXFqNGtWbnZhZFBVUkNGemE4ZGUvNFpxbjJ0alJZQ044Z1poYVFDaTFOVmtq?=
 =?utf-8?B?QXU0ckJCUkxSWkIvQWxkeG0zNjk2RHB3OTEranlnUmJNR2taNTBlN3c3NFZj?=
 =?utf-8?Q?zomaRhSaOZCMNQmaFOZyZxm8s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e84af8-5d0a-4622-f7fe-08dc6f83e214
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:25:40.7409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCKVyMyi5Jv42NTVqERMw0AHjfK+7hOUUChm9TEx49x5JA+hy68fskWgsp3bu+Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

Am 08.05.24 um 15:45 schrieb Alex Deucher:
> On Wed, May 8, 2024 at 9:25 AM Michel Dänzer <michel@daenzer.net> wrote:
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> It incorrectly claimed a resource isn't CPU visible if it's located at
>> the very end of CPU visible VRAM.
>>
>> Fixes: a6ff969fe9 ("drm/amdgpu: fix visible VRAM handling during faults")
>> Reported-and-Tested-by: Jeremy Day <jsday@noreason.ca>
>> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
CC: stable@vger.kernel.org

Christian.

> and applied.  Thanks!
>
> Alex
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 109fe557a02b..29c197c00018 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -427,7 +427,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>>
>>          amdgpu_res_first(res, 0, res->size, &cursor);
>>          while (cursor.remaining) {
>> -               if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
>> +               if ((cursor.start + cursor.size) > adev->gmc.visible_vram_size)
>>                          return false;
>>                  amdgpu_res_next(&cursor, cursor.size);
>>          }
>> --
>> 2.43.0
>>

