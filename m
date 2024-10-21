Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEBAD0E6DD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 10:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58A110E035;
	Mon, 21 Oct 2024 10:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlKxP48F";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D017F10E035
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 10:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aog1gZxeHEBg38SeYQ7XaY/UPdyZq+Gdj0+Dk/jjdYwpu+WTCq2FeF2IKwwtXbI3s52Y2uIKbk47eOEYaU1sd2Q+oMMSunNKVpCdOd7qbMrtn/RppcJu2RaRADpU8OC3C9OGD4WvS060pqfzDPtZBx52Kb22oEjLwu87MWruOCwcc3aZI1yc6xfzc5qgxDVmAgkIQkjbPF+Mvb2mYoqBhurN2ukyfot2ECSM4qtfLxtE82eBGDt9PGCTogdsdWDbUes0lJqfswxtJIQQSLiwcP4pWrydhJEGmBqAyyfPNeCpfVYwgTCtPAo6rE9Kh87McmhCFY9xl8i2DfVUSRk64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyruhbJtQbZh1o8wJ23wnaM+5ZsDwzhQ0NLnO4hbR9c=;
 b=PUTx4CJoQwXr6BU9IWK1eEOtmkJV3Kk8FUflWtOdGEkPydCmECJdtLcviYTPfsofBe5DnIUJyzPrniMyCp1NztmDXEqyTxTPlCoTcGiBjMDa/LtnjX2MPY7iwAxin06itTKbjjB4xQL34DoOD+ZRVY1ez16RDqiiXB8CaG7AmQncRc2DrTVE7z2AaeUr3hAvedwM2VaUnOgMNa+43qGCt//ZUkgHhNkprTdXpj487ddAfCuJfbZZrPsruX1Zi823v/JiB51LQrNTPKZESCZUL3i3ncpo689QouS2Fn40u7zsugxkxwPVOaH+dklsWhmNjbMW3N53WxQdFVdP6Jd54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyruhbJtQbZh1o8wJ23wnaM+5ZsDwzhQ0NLnO4hbR9c=;
 b=mlKxP48FG6uYeEd7Nia3ESwZqrEeQwJKBlBNz0NubIvpeHzuOQ34zAaiOmSGOoVEMUgnCu8uoAr6iwfUPsB1ahpSryQehYFOAx0ZUVQlbjJ8+QGR/2nqHV/h3QVb08oF+oFq7q00ip1mSteJIMjaBCr8OsT2080GqQa4Ptt77Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:10:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:10:55 +0000
Message-ID: <b5fc8472-95ac-4290-945d-b41d6b5e984d@amd.com>
Date: Mon, 21 Oct 2024 12:10:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add gpu_addr support to seq64 allocation
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241018132629.190295-1-Arunpravin.PaneerSelvam@amd.com>
 <c7f38b09-133f-444b-897b-ab628c6ba51a@gmail.com>
 <9934a196-f36e-47f6-a39a-4760503591bf@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9934a196-f36e-47f6-a39a-4760503591bf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b23a92-56fa-436a-2a79-08dcf1b8a6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUhocGR0UUpvS3BCN0swcmRvZU10SWxkTDZ4SVZ5Zi9WVlNQVlZFam0zcDRK?=
 =?utf-8?B?d0oxUlJadFovWU11aWlBeThkZXMrTEowbkdlQ0t2cXBNVWhwcnN1dC9sdEZL?=
 =?utf-8?B?WGVYbmxuMGJjNWhCUW5Td1RiZ2VhNXpmZnE4cDI0aHUvN25zVjY3NGZsL3Bk?=
 =?utf-8?B?N2l4YTZpdkNudW1hckltQ2ZSbGhpcTJXOWxtT1lrd3Fja0tJKzlYK1Q4THRN?=
 =?utf-8?B?WngyMnhvTEZUVVZRajFyTlo1dUtYRm16R2VqejVneWRidmFUczZPQTlwazIx?=
 =?utf-8?B?ZjV3REp6cTRJb0xsTm1kSFVuQnhpQWRLQmVrdFUyUHlpTU45eXlqQW02NEtv?=
 =?utf-8?B?c1J4RVlQS3ZMMkZ4dDBZRDZ6R29JZXprejlDRkJNL2NhalAxa2RYUnphZ2c4?=
 =?utf-8?B?UUNBbnRQRVc0RUtFVC9QYmpENHdacWdmKzdLOUtnU1IrMkVjS2lGN1BmNlVS?=
 =?utf-8?B?N0l1ZjBnRVRacE50ZFZCR0cxMGNhT0FNd0tnL24wbWtHUGdsb0ZsTXdnVCtx?=
 =?utf-8?B?RElrUEs4VUgrQ2lhRUpOREorVkl1NjlMdjJaNllYaHp4SEJLcHIrdG5CbExB?=
 =?utf-8?B?UEVFV1BVUWxqdk10Y0Z0TWlzNjY3RmNvL2toZFlMUnAxYm52SlNvOE05R1dT?=
 =?utf-8?B?Qm1yYU5qRHhDTDROQnJEVGlHaTh5VVVHZEphdWZ0NWdFMFdteTV6R3g2c2xk?=
 =?utf-8?B?L0hJN1R1dTFjOFBKa0l2bE5vNDBUQ0VreXVZMnNjam10YVRPVVNBdGlEVlll?=
 =?utf-8?B?K1ZSc3FwU0tkc0R4Z3MweDA2Wndhbm0rdlNORnFWQjFjZ2ZNdmlDWUJ4Ujln?=
 =?utf-8?B?QklCWDFSRnR4YVpmZFphV0dYcTZCZStIWlBWN1ZTbUF3cDFSQ29ucys3eDNG?=
 =?utf-8?B?ZW5NV0l0SlFYUVAxQ2plL1krVDNQMjA0L3BKR2lvZ2krVSt2cVVoNnRNZStZ?=
 =?utf-8?B?aG41SXZxYVhMRlgxWWE2L2FDUEc0eFA5SUd3ZGRQMnc4a3pkTVBQbDlRV0po?=
 =?utf-8?B?cFFBb3YwbjFKSWxmcnp3eUlNOUJtaGJDQjF1MU5pQmpIeFY3T0YrUlp0dmFB?=
 =?utf-8?B?SUhMTjJNTWVRWWJsai9sT252TTZISEZweHVVRys3L05FVlJud0k1U25Ud0px?=
 =?utf-8?B?YjdNODJzMzdGTFdzS1NZc0RpZnZvaFhnR0gzRjlSWXd2Z1FLY0tWL2tadzZk?=
 =?utf-8?B?Qm9jTTVNQTFIMzFRaDRMeWxyRnBMSUZONjh6Z1dnaGFlN1hySDVaMUhZZGky?=
 =?utf-8?B?V0hUOEpWUEg5TzluMklPMUIrS1Rxcm9GaCtFQzh5MitNRDJ0SEhvclpQZXdx?=
 =?utf-8?B?WGhhUGZVVVh0TUxUS2ZrelUvQXFYN0ZMaVh5aDRzNjFqSFN0elYrNGNBVGFu?=
 =?utf-8?B?WnBLOFdLOE14eG1FNlFndjBaUy9FcXlKeHYvVDRscEVTUzluWTlrQm83Mkhp?=
 =?utf-8?B?bW0wVUs1cmdyanVxeFRQdnZmNFY1SUtjUDQ1Z09uMFFTUjZTTXFITkJWNXov?=
 =?utf-8?B?c3RwdVFaTTRjWWZtckdFTFl4ME5YMzhsYldYRW01MEJMbHIzQ3pONGM4ZFd4?=
 =?utf-8?B?NHNhZWZDVFJ1L09XNFc4ZHF2ZHVRUXZHcVBva213MTd6TndsemtoRjFBUjg4?=
 =?utf-8?B?eWlsVUljdE9jdU53M002RlBXVVZUa2hKRGhzMDRJNTE4NGZueFIxWFRqa0hq?=
 =?utf-8?B?eFA0YmlTZmJITnBDS0VzbzVnOVB6VENYWkNaVHlYVHFKdi9YaEZZZWpCVkRi?=
 =?utf-8?Q?mdQoys/IRsI+HIhFzjChqNTzMkz+PVuqgm8lSnV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHF0OWd5aHpwaENGM0g1cDlSWGdiZW54bTZxeFBkelBTNjBlOXlQUGEranhj?=
 =?utf-8?B?TVkrM1E4SmQ3ellRWUJQWDBuUFdVTmFza0dabC9qWG81T1pzK09YOXVYbEQ3?=
 =?utf-8?B?d2xvZytCQ01Ta1FBbnRhY3Njd3NUcXhpekdLNWYxRGJralRGaFlsc3hVQXJo?=
 =?utf-8?B?a1RGcHg4TWFTTmNNN3BPUWtQQVk5VmM5cW9Ebng1bkpsZVdMWmkrdzhqUm9p?=
 =?utf-8?B?ZEVGbjJxY1RodThuSzBjL2o4Tit3NmRubEQwK3IycWxxb2RJQ0ZnWWV2eTJm?=
 =?utf-8?B?RFNaOWZPdFlVYmhyeDdWZUdtbEd0dFlkTTNleUhsOWduc0hkSmc5MVlSaXNp?=
 =?utf-8?B?d01kK1Z0cklVN25CaFJpUHJpanR3Q0VzTDAvbDlUSEppQkh1K01ZVXVVNDNH?=
 =?utf-8?B?bDNyeW1DOXg5bTFnOW9vWHJhcVVhYU4vSnJaazRLMXcyYUM3eUI1L05XanBJ?=
 =?utf-8?B?bW9EemNWaEhGb1lmK1VvZ2czb0JzOU0vU1U3SGtMZmF5SnpwUkhtVlJ5NDlo?=
 =?utf-8?B?d3RGQkhIRWZGaDZPOXFYV003S2t5K0tXS3Y1RGhSYVgwanpLSUUrcFNUZ0R1?=
 =?utf-8?B?NkQ3K0JEU1ZMdkp5QVF0R2lzZHBmbnpXZlZwVklpZUE3dWJZRyttaUxuWmRF?=
 =?utf-8?B?N2JnTXY0WE1GZzhMUmE2cTRFRitTS01KWE5BRlJhNmlaNmVFSlZ1VzZNc3Nn?=
 =?utf-8?B?WkJvaUdlTTZRdFovS1VxT3NiZTNTYnIxeEZqdlNsOFFJeW4zSXNSZWdIVHp2?=
 =?utf-8?B?MmxZRTBZMGNYVjhldTFGMGRwMnJiUVBobFVwNVdqZGtZUEZrYlJSK1BTTXJ0?=
 =?utf-8?B?TUNqTkMvZlpGOEE3Vm42VmxMM0NhZ0c0aHh1Z0ZMc1VjMlhWbjVOTDZld3Rr?=
 =?utf-8?B?NlQza2swTlU5Z2hzMkZGS244T2l1QkwycHdidUNoSVMrRjRJdDNEMGVpb3lP?=
 =?utf-8?B?eEY0WWY3T2wyZEdwdmJnOVNxZnhoeXpDSWwwcG5tMXlvSjdncFN2TnJSWGxT?=
 =?utf-8?B?RWVBVWJaSHJyeDBBek9jeW9BbkFQNzNUMzlhTmcxU0lrVnJVNHJxK3ByVm5M?=
 =?utf-8?B?bHFHM1FzRWg5QVFEZklWRk8zM2lkZlJIYzN4NFZtTW8vTGVJT29QZHZrTHoz?=
 =?utf-8?B?V0J4dDJvY0IyQ0hKTFFXc2VMNGtDc3kwOE9tV3dacld2SkVXaUFDWHBTSXpX?=
 =?utf-8?B?SmIwbVBiQUpnKyt5NEQyTDV4R04wK2JBUU8rSlBYeC9ZMDFpUUF2OEsxcW1N?=
 =?utf-8?B?U3gwdVBGamhvMDFvZzRyR3VRQ3ZIUEpmRFY5MHcxNDlsNC90MkExMHVZOU16?=
 =?utf-8?B?OElqa0FqcDBpS2liRXdSQzdENlJxa2ZYZ2hWT3IzcTJLN3JvL0dzUTh3VXQy?=
 =?utf-8?B?c2RodEIrOFJMTVpOQmVTZjY1a2lmMldTM2k2aGh1VUVpR0ZqeU1mbFpyN3Ru?=
 =?utf-8?B?Ty9hODVWaVZGditHdEpBbWxMeTl0ckVZQXFHSXY0d2R1MEpqeUN6VmZYcDlo?=
 =?utf-8?B?b0VlK0tRcVhES2Qzbm91dlZkc0c2YjZGMVhSTXlTaEpTMndhSkxtaG9PSm9u?=
 =?utf-8?B?YVBWKzcyOU15RnJwQUZqaWMzRFFaa0xOSWZPRDduK3VhQzRhRXNxMGJ1V2RR?=
 =?utf-8?B?aTNzY1RoT2piMk1TU2szdDZ0ZXZSUlozYnZsbXdVR3JJUEJ2Snh0Zkp5bkV5?=
 =?utf-8?B?eGhNcldVM0NDTDlHbUMrc2pvcTc2dGFDWlRNUVNtMGRXWHBiYmpZcmE4MjFn?=
 =?utf-8?B?aklERWEwVzkrOExud3V5bWlvU1REVzYrSUdBVjdSSk8yeWNPRWJtMVRIL3Ra?=
 =?utf-8?B?K2dVNHl1RmozZk5YLy9tUVNySjg5enB6cjdSRmtEVUVySVpnci8reS94dXpX?=
 =?utf-8?B?ajFTUGNuZTdLcytjT3FvV3I0Q2ZHdDQvZllOUWIrbkljZmFrNzdHeWVQckNZ?=
 =?utf-8?B?U2dYb0YyK2IrLzV3VXVZTFU1b3Q3dW01bUpieEd3MVhIQ0RyRkhhT2VTMDky?=
 =?utf-8?B?eTlDdU44Q0dQeGtwTy9RUUVrOENnM3ZCWnFLWnhyTFdVcnNvL2crUlNzWTNs?=
 =?utf-8?B?Vk1yMFc5emVJMDhWZTdqdGd3dkxVemU3SUloUWNmMCtoZkgwN3pUb1V0Nlh1?=
 =?utf-8?Q?fNsSOGpJU2klbQu+ELrurnS9Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b23a92-56fa-436a-2a79-08dcf1b8a6a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:10:55.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPGRO4wq5WVEx6yhF3uHBgTCBGR+vhOxjoNY9FaidPGfj2t5IP1tGHyG2GJjmV22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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

Hi Arun,

yeah better to make this here part of the userq fence patch set.

Regards,
Christian.

Am 21.10.24 um 11:54 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
> I couldn't find other users except userq fence driver which are not 
> yet pushed into amd-staging-drm-next.
> Should we wait and push along with userq fence patches or we can push 
> this one separately.
>
> Thanks,
> Arun.
>
> On 10/18/2024 7:09 PM, Christian König wrote:
>> Am 18.10.24 um 15:26 schrieb Arunpravin Paneer Selvam:
>>> Add gpu address support to seq64 alloc function.
>>
>> Looks good to me, but when adding interfaces you should probably have 
>> the user of this in the same patch set.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 10 ++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h |  3 ++-
>>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> index e22cb2b5cd92..0defad71044c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> @@ -163,7 +163,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device 
>>> *adev, struct amdgpu_fpriv *fpriv)
>>>    * Returns:
>>>    * 0 on success or a negative error code on failure
>>>    */
>>> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 
>>> **cpu_addr)
>>> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
>>> +               u64 *gpu_addr, u64 **cpu_addr)
>>>   {
>>>       unsigned long bit_pos;
>>>   @@ -172,7 +173,12 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>>> *adev, u64 *va, u64 **cpu_addr)
>>>           return -ENOSPC;
>>>         __set_bit(bit_pos, adev->seq64.used);
>>> +
>>>       *va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
>>> +
>>> +    if (gpu_addr)
>>> +        *gpu_addr = bit_pos * sizeof(u64) + adev->seq64.gpu_addr;
>>> +
>>>       *cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>>>         return 0;
>>> @@ -233,7 +239,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
>>>        */
>>>       r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
>>>                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
>>> -                    &adev->seq64.sbo, NULL,
>>> +                    &adev->seq64.sbo, &adev->seq64.gpu_addr,
>>>                       (void **)&adev->seq64.cpu_base_addr);
>>>       if (r) {
>>>           dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>>> index 4203b2ab318d..26a249aaaee1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>>> @@ -32,13 +32,14 @@
>>>   struct amdgpu_seq64 {
>>>       struct amdgpu_bo *sbo;
>>>       u32 num_sem;
>>> +    u64 gpu_addr;
>>>       u64 *cpu_base_addr;
>>>       DECLARE_BITMAP(used, AMDGPU_MAX_SEQ64_SLOTS);
>>>   };
>>>     void amdgpu_seq64_fini(struct amdgpu_device *adev);
>>>   int amdgpu_seq64_init(struct amdgpu_device *adev);
>>> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, 
>>> u64 **cpu_addr);
>>> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 
>>> *gpu_addr, u64 **cpu_addr);
>>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
>>>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm 
>>> *vm,
>>>                struct amdgpu_bo_va **bo_va);
>>
>

