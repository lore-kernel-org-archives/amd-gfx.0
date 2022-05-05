Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387CFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 21:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE59010FAE3;
	Thu,  5 May 2022 21:47:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E3610FAE1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 21:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch7sEEt2+fJddCocI7rVpBVkaSymCWcxlLtYTiUk8kAzZLo0S/96gqHlFursL+uaA7w1cKSNhbnql5if0y8tB3JhcwYpiEuYeuwgSpcZSAg4ztUHZMKNQHvZQGgC2zyNKbkoiqOzP71hnp8Us5q7+pv1eaccueAzU8iPO/a7br9AYDC1j7s8M3La4TYc4yXDupdH/1XUP7CN7sZ5roxKBCqlGc3vMvzEiD32X+BpO3mxkoRwGCYf+mz8h7lOrlpmT0TxDUdi/EZknmNjwOy0r6AN1u92U1aDaMvf8OIKPCNpaYxj8nNyWvIf2QTiwP9LRIs4h+h7MLpzcIZeIfSTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+IOK1R71nI+DtPPjcXYmiI0BA4w392CD0Xn0IrvNHc=;
 b=YxlHBDRPPmqdYPG81+3EbNOeBlZ6OumWHcbrc7vuY6X7XvfDNxnoE1MIyO3wvekm30eytAM5ey5iDFQochtXmUiGegHZU4SQaG4hVLjkzdvU7UigMiGIjAJkNIr/aDeD99xsosoASMEeTChS1C0TRpFIbsw9GwpKvn1G1jF2gCXaOwzR9dFEwAfuIFzEYh1wxVmp7Iq7knsWPHDpeaOhLVbLUrcfU+kcJBWmuSCyKPl0fc8sZoksdyXAdythfFZOADi5DT7NpEsOE2js0FkwVvOeaWM2USBuAXTv/epklRJJmXXAG3W+jipcWi7hhmg6iSc1kQaLxW++ash1Q6wzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+IOK1R71nI+DtPPjcXYmiI0BA4w392CD0Xn0IrvNHc=;
 b=qZasILjAZy4MXRa8qaXnfODTbCLa96rP8lhjDWg8A22naVA42ZLJoJiDHWJF8ijZZKM/lds+UF/zPre72JFaSwsSfWwht18fWXTvFhU3x7I0f7JfKqJFVcozmkOSO/FrhUV/fXgclYyO+wV1aQZ47TN68dJI2xHYbw+mPj2qfaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR1201MB2474.namprd12.prod.outlook.com (2603:10b6:3:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 21:47:28 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5206.026; Thu, 5 May 2022
 21:47:27 +0000
Message-ID: <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
Date: Thu, 5 May 2022 17:47:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:610:b2::12) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f3d5d00-b5b7-4669-2be3-08da2ee0d65e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2474:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB247408BFD89AFA9916BDE919EAC29@DM5PR1201MB2474.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrE4taDyxFdJJutv/u9FJkE9HPnORAb2IXE+vCqYaJbwJL9oyg9/VuyhhGbAFxe6Z5ruAZstWXLQRtqH1DJppdulzX60erg2Stqdg7mgPS8OS0KXIvqeXWxKR7bVfTLQfquwEyuCm6ahJP8CODirmVBRjBujtARlSzPm3K3bgLZK9Usuj6/BuXWv+8aDy92DqqRqXBNRpU7xr9hOe2gyWxG7eAonnkmbibDg0jSVlVyOa5MaKXyPcR6PogAHizV9PbvrUtZKoFV/kCMhtH0wqQjX2gzrKr7GG7PL2uovr5uoAIQeCfwShetl+6mvfYBC6gbT0OPzVKKjtihiczx2Mvzct0mBh5pcgusZjUnlWjONns0hvndp+dwFFUZ7GvPpj2g1H//5j26znPP3CZvhyWsU7E4kSh8G7T+/kANAf2Ef8bzg1+3Ugtu5Sn3zaFmiiGpmkZgsq6pTtKVrXumj0MC3zejjWBDon1VDl//hhUJjRvvx588hkyeLC6SvN0CgeH10YLhBOJzUN05aQEAeghqBrgcLRURgeIgZNrhIcEDkJS/6/8/10mI9F9Ix+gvbiRHWWf+5n1B7at2ySjgHGEgKr+SKoZCwhn2bWY/e0zr0QSc+PtC7xSp+rrkcU5do/+miSzDXO7Gr/jbfaUpLMXawn6zkX574qXl688VkimhY3NX+dvWwsNIr5aYEG/D+4bKZUou5YRzE1yyOY4ZZLPwViTLVmYSPl27Z90Pdt1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(316002)(5660300002)(8936002)(186003)(2616005)(38100700002)(6486002)(110136005)(6666004)(6506007)(53546011)(44832011)(66476007)(36756003)(66946007)(8676002)(66556008)(4326008)(83380400001)(508600001)(30864003)(31696002)(86362001)(66574015)(31686004)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellVTnRFVXEvRHVlMFdHRld1eGFBNGQ1RUdBWG5vNG5uTkxrRmtNZVFYOXFH?=
 =?utf-8?B?VU5DakJjTnlvYlRSTkdnZEV5ZDZvMkR2NXVSMVkvT1VOSXFSYklnR0hSWHkx?=
 =?utf-8?B?RnVIemNzTnIzUHFLTTBIUE1mSmdjTWVsODZ5cnhXV1h6SGxRaEluVlc3WE9J?=
 =?utf-8?B?cDdiTFlRQzFwS0ZoeExSaXJESG1QeWNWajFJQUE0YVYwNG9TWTV6cEdwTmp3?=
 =?utf-8?B?L0hhaktJeXdFbVlyaGo2Q04yU3dlZ01LTmwwYzVnRTQ3RDB4UVZ5ZURiZHQ5?=
 =?utf-8?B?clg0SDR6clJzYjV1L1FtR054SXVFUEJ4bVBQOFdETEljcFEwdVcwYStlK29M?=
 =?utf-8?B?SGRhdXVJMTNsS1o0RTFSeTA3SVZBSWJiTlFsSTRDakxkeTUrcVFNYTBORU9H?=
 =?utf-8?B?S1Y2alExd2doRGVrWXRmOXhiVHVRNVlSNFVwd01XUmd2L2dCUXR1enNPRlBI?=
 =?utf-8?B?T2FIRytMTHM0K1hGUXBnVFRpSDMyL2NVOEFIcjdUeDlCMlRqdTdhN3VmTFBm?=
 =?utf-8?B?VUhVQ3U1UGFHMUtDWDd3eERJVW81ZFFDNEtybXR2TVFheWxXSzRXeDJCaU9z?=
 =?utf-8?B?QUdYVHJyNlFpQW1UaEpqdVpINHcxbUNsUEZweml3emVIcTVWaXlLUU04R1FW?=
 =?utf-8?B?Y0lrNVFYODBHNGlhblRCLzQ5QWplam5yUGNBclpwV2o4QThRcU1kYVMvd0hs?=
 =?utf-8?B?ajdyUmdZK0FhNUlIMlg2bTBGbG1rVXN6MGtjNTdlaGZ4aVNTb1hlbGFEOE1t?=
 =?utf-8?B?clgwdTc4eFJEME4vTGo5WFBGMi9HMy9KeDZyUXMxR0lyVUNEcHVvUGxPbmVo?=
 =?utf-8?B?RmRhOWpRRFFXa2wwaFp1YThycVZIa3c0UTgrQUtQaXY0SmhxMkkwUlJKRTd2?=
 =?utf-8?B?Ry82RmwzR2duRFA3V2p1bU13TDdJZXhDWVpZelRyRVNWcS80blkwNE5SVUp0?=
 =?utf-8?B?aTM2MG9BTElxTmdINWIrSkF6UDlhTEgvaXoyelUvQldhbTlkT2xWSmJUTCt0?=
 =?utf-8?B?TUgxbjV2LytKOUlzNVhPTUtkNHVTaURud0p6UHdCUEVjbWljU1hMSEdxN0Fn?=
 =?utf-8?B?MklRU0FEaUxMbFRSek0zS2xlYUV1ZUVZd3RKVWptb2d3aDNXU3JPT01DUmtk?=
 =?utf-8?B?VWNtUXVCRGxHcW5mK2xOL1FMMi80UXk4WU50NlQzbHZLSXBLdzdNdWFidEo0?=
 =?utf-8?B?bXJpNVhaSTdOMWY4UXNDamZweFU5MndwZUlHUlE1eE9yTk1kaUd0Z1RNaldn?=
 =?utf-8?B?NUs3TDNWemcydGxDWXpPajdyUUhXbmllRnJyRzNLZDBYREtSWXBPVVVmdGFt?=
 =?utf-8?B?RFZCUnUzUksrSWJiRTU1SHlVb2VDWW5pTXRXVTB1ak0wVFBOOFY2ZDVGREhz?=
 =?utf-8?B?NHd4K0xod0oxYmxYNXc4WVNhNHRVVExoRUJFQVB2QmppMGNKbGZNOTFsYmlE?=
 =?utf-8?B?blorMGFXSWJqQXNmWklBOVZYbzc3SldVYldHdndnS0kydVRmK3V1TlRCSGhp?=
 =?utf-8?B?NnByb3BBRE0zQTlWVlp0RUZQZkRFYzN6V0RJbnFNUEVJMFdpakRpQWIxelBT?=
 =?utf-8?B?aVhBMDVFay8xamVuR24rWFdBUGpwY0dhT3VvajRnUGpQLzdLSXhqRGl6WURH?=
 =?utf-8?B?WU1jWXpuaFBDTjZxaEhGQy9YOTNDYkpRL3YvK2FKc1Z4NnUxRXlWT2FxM1lB?=
 =?utf-8?B?aHMvSzFQaTRScDZXOTgwblNVVFV4dnNyZlZVcjdSMWdrNnVYTVMyc0JDSkhr?=
 =?utf-8?B?TktTWW9KbE5MeHZmOFJwOFk3VVVFNStlNzkwK2t2NUFxa0tpdE5SWUxtc2RB?=
 =?utf-8?B?YTFKVEVKaVZuWW10UkZhd25WUE1zUGljVHR0aUlzUTZJRjBLQWUzd1lidnhX?=
 =?utf-8?B?eTVFZXlYV0YvQ3lmdzVFaFdwTHVId1dpaGpoQmpjMSsxT09aWjM2VW11dGMx?=
 =?utf-8?B?ZUtsVGkva2hQbUZMbHZYcklkTGhRenV5ajFDUmFrRHFyRHBQSGVON1NUdGFG?=
 =?utf-8?B?Z3l5cmhNVlNhb0lDRzliK0RYeVZZdVc4MTdvdndpdGU4bTIzNUZNMlc4c3RK?=
 =?utf-8?B?aXBvbzd1YXhtOWhCVFh0S2FPSWhPMTE0cWhmZStWODVsaVRid1NGTWtLRW1y?=
 =?utf-8?B?dDZkc28vR0tvSU5OZHlIWDRTVkg3Vkt2dVhEVk4yamNMNUd2d0YvY1ZKc2JD?=
 =?utf-8?B?UnZocmZuWVlzMHdDbFlVdzlFZEJxT0IrMHdHL1VNOStCWXgyRkZ1SDl2L29a?=
 =?utf-8?B?a3MyWTY1b0JOYmM4ekowYy9sc2Y1ajdUVFFRNExmNFh0enAzR2ViQytXNmhm?=
 =?utf-8?B?ZHM0Uldib3FlNGhJS3lvZW5UQXVFdjdQUzgwSG0zMjJ4ZTNYWUdILzNTb3VD?=
 =?utf-8?Q?qgRNlPKij3uvVwIPf9VeV8Z48hc4Oy2I6FL/Ug4/p4Cbt?=
X-MS-Exchange-AntiSpam-MessageData-1: G2PLZ6ggYXo/mg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d5d00-b5b7-4669-2be3-08da2ee0d65e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 21:47:27.8832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bJkG3Go06b5meyZ6bZkt32JqDUeLqHi5WRPXhpAoACeDV84YDHPiIspH3MTpCcua/6vq9x1HJ99VF94YYuRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2474
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-05 15:49, Felix Kuehling wrote:
>
> Am 2022-05-05 um 14:57 schrieb Andrey Grodzovsky:
>>
>> On 2022-05-05 11:06, Christian König wrote:
>>> Am 05.05.22 um 15:54 schrieb Andrey Grodzovsky:
>>>>
>>>> On 2022-05-05 09:23, Christian König wrote:
>>>>> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>>>>>> On 2022-05-05 06:09, Christian König wrote:
>>>>>>
>>>>>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>>>>>> Problem:
>>>>>>>> During hive reset caused by command timing out on a ring
>>>>>>>> extra resets are generated by triggered by KFD which is
>>>>>>>> unable to accesses registers on the resetting ASIC.
>>>>>>>>
>>>>>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>>>>>> such that the first reset jobs that actaully resets the entire
>>>>>>>> reset domain will cancel all those pending redundant resets.
>>>>>>>>
>>>>>>>> This is in line with what we already do for redundant TDRs
>>>>>>>> in scheduler code.
>>>>>>>
>>>>>>> Mhm, why exactly do you need the extra linked list then?
>>>>>>>
>>>>>>> Let's talk about that on our call today.
>>>>>>
>>>>>>
>>>>>> Going to miss it as you know, and also this is the place to 
>>>>>> discuss technical questions anyway so -
>>>>>
>>>>> Good point.
>>>>>
>>>>>> It's needed because those other resets are not time out handlers 
>>>>>> that are governed by the scheduler
>>>>>> but rather external resets that are triggered by such clients as 
>>>>>> KFD, RAS and sysfs. Scheduler has no
>>>>>> knowledge of them (and should not have) but they are serialized 
>>>>>> into same wq as the TO handlers
>>>>>> from the scheduler. It just happens that TO triggered reset 
>>>>>> causes in turn another reset (from KFD in
>>>>>> this case) and we want to prevent this second reset from taking 
>>>>>> place just as we want to avoid multiple
>>>>>> TO resets to take place in scheduler code.
>>>>>
>>>>> Yeah, but why do you need multiple workers?
>>>>>
>>>>> You have a single worker for the GPU reset not triggered by the 
>>>>> scheduler in you adev and cancel that at the end of the reset 
>>>>> procedure.
>>>>>
>>>>> If anybody things it needs to trigger another reset while in reset 
>>>>> (which is actually a small design bug separately) the reset will 
>>>>> just be canceled in the same way we cancel the scheduler resets.
>>>>>
>>>>> Christian.
>>>>
>>>>
>>>> Had this in mind at first but then I realized that each client 
>>>> (RAS, KFD and sysfs) will want to fill his own data for the work 
>>>> (see amdgpu_device_gpu_recover) - for XGMI hive each will want to 
>>>> set his own adev (which is fine if you set a work per adev as you 
>>>> suggest) but also each client might want (they all put NULL there 
>>>> but in theory in the future) also set his own bad job value and 
>>>> here you might have a collision.
>>>
>>> Yeah, but that is intentional. See when we have a job that needs to 
>>> be consumed by the reset handler and not overwritten or something.
>>
>>
>> I am not sure why this is a requirement, multiple clients can decide 
>> concurrently to trigger a reset for some reason (possibly independent 
>> reasons) hence they cannot share same work struct to pass to it their 
>> data.
>
> If those concurrent clients could detect that a reset was already in 
> progress, you wouldn't need the complexity of multiple work structs 
> being scheduled. You could simply return without triggering another 
> reset.


In my view main problem here with single work struct either at reset 
domain level or even adev level is that in some cases we optimize resets 
and don't really perform ASIC HW reset (see amdgpu_job_timedout with 
soft recovery and skip_hw_reset in amdgpu_device_gpu_recover_imp for the 
case the bad job does get signaled just before we start HW reset and we 
just skip this). You can see that if many different reset sources share 
same work struct what can happen is that the first to obtain the lock 
you describe bellow might opt out from full HW reset because his bad job 
did signal for example or because his hunged IP block was able to 
recover through SW reset but in the meantime another reset source who 
needed an actual HW reset just silently returned and we end up with 
unhandled reset request. True that today this happens only to job 
timeout reset sources that are handled form within the scheduler and 
won't use this single work struct but no one prevents a future case for 
this to happen and also, if we actually want to unify scheduler time out 
handlers within reset domain (which seems to me the right design 
approach) we won't be able to use just one work struct for this reason 
anyway.

Andrey


>
> I'd put the reset work struct into the reset_domain struct. That way 
> you'd have exactly one worker for the reset domain. You could 
> implement a lock-less scheme to decide whether you need to schedule a 
> reset, e.g. using an atomic counter in the shared work struct that 
> gets incremented when a client wants to trigger a reset 
> (atomic_add_return). If that counter is exactly 1 after incrementing, 
> you need to fill in the rest of the work struct and schedule the work. 
> Otherwise, it's already scheduled (or another client is in the process 
> of scheduling it) and you just return. When the worker finishes (after 
> confirming a successful reset), it resets the counter to 0, so the 
> next client requesting a reset will schedule the worker again.
>
> Regards,
>   Felix
>
>
>>
>>
>>>
>>>
>>> Additional to that keep in mind that you can't allocate any memory 
>>> before or during the GPU reset nor wait for the reset to complete 
>>> (so you can't allocate anything on the stack either).
>>
>>
>> There is no dynamic allocation here, regarding stack allocations - we 
>> do it all the time when we call functions, even during GPU resets, 
>> how on stack allocation of work struct in amdgpu_device_gpu_recover 
>> is different from any other local variable we allocate in any 
>> function we call ?
>>
>> I am also not sure why it's not allowed to wait for reset to complete 
>> ? Also, see in amdgpu_ras_do_recovery and gpu_recover_get (debugfs) - 
>> the caller expects the reset to complete before he returns. I can 
>> probably work around it in RAS code by calling 
>> atomic_set(&ras->in_recovery, 0)  from some callback within actual 
>> reset function but regarding sysfs it actually expects a result 
>> returned indicating whether the call was successful or not.
>>
>> Andrey
>>
>>
>>>
>>> I don't think that concept you try here will work.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Also in general seems to me it's cleaner approach where this logic 
>>>> (the work items) are held and handled in reset_domain and are not 
>>>> split in each adev or any other entity. We might want in the future 
>>>> to even move the scheduler handling into reset domain since reset 
>>>> domain is supposed to be a generic things and not only or AMD.
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>>>>>> +++++++++++++++++++++-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>>>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>>>>>       bool grbm_indexed;
>>>>>>>>   };
>>>>>>>>   -enum amd_reset_method {
>>>>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>>>>> -    AMD_RESET_METHOD_BACO,
>>>>>>>> -    AMD_RESET_METHOD_PCI,
>>>>>>>> -};
>>>>>>>> -
>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>       u32 codec_type;
>>>>>>>>       u32 max_width;
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>>       }
>>>>>>>>         tmp_vram_lost_counter = 
>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>> +
>>>>>>>> +    /* Drop all pending resets since we will reset now anyway */
>>>>>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>>>>>> amdgpu_device,
>>>>>>>> +                        reset_list);
>>>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>>> +
>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>>   }
>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>> -    struct work_struct base;
>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>       int ret;
>>>>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>> work_struct *work)
>>>>>>>>   {
>>>>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>>>>> base.base.work);
>>>>>>>>         recover_work->ret = 
>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>> recover_work->job);
>>>>>>>>   }
>>>>>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>>   {
>>>>>>>>       struct amdgpu_recover_work_struct work = {.adev = adev, 
>>>>>>>> .job = job};
>>>>>>>>   -    INIT_WORK(&work.base, 
>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>>>>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>>> &work.base))
>>>>>>>>           return -EAGAIN;
>>>>>>>>   -    flush_work(&work.base);
>>>>>>>> +    flush_delayed_work(&work.base.base);
>>>>>>>> +
>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>> &work.base);
>>>>>>>>         return work.ret;
>>>>>>>>   }
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>       init_rwsem(&reset_domain->sem);
>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>> +    mutex_init(&reset_domain->reset_lock);
>>>>>>>> +
>>>>>>>>       return reset_domain;
>>>>>>>>   }
>>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>   -#include "amdgpu.h"
>>>>>>>> +
>>>>>>>> +#include <linux/atomic.h>
>>>>>>>> +#include <linux/mutex.h>
>>>>>>>> +#include <linux/list.h>
>>>>>>>> +#include <linux/kref.h>
>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>> +
>>>>>>>> +struct amdgpu_device;
>>>>>>>> +struct amdgpu_job;
>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>> +
>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>   };
>>>>>>>>   +
>>>>>>>> +enum amd_reset_method {
>>>>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>>>>> +    AMD_RESET_METHOD_BACO,
>>>>>>>> +    AMD_RESET_METHOD_PCI,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>       enum amd_reset_method method;
>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>       unsigned long flags;
>>>>>>>>   };
>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>> +
>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>       struct list_head handler_list;
>>>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>>>       XGMI_HIVE
>>>>>>>>   };
>>>>>>>>   +
>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>> +    struct delayed_work base;
>>>>>>>> +    struct list_head node;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>       struct kref refcount;
>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>> +
>>>>>>>> +    struct list_head pending_works;
>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>   };
>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>>>>>   }
>>>>>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>> -                        struct work_struct *work)
>>>>>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>>>>>   {
>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>> +
>>>>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>>>>> +        mutex_unlock(&domain->reset_lock);
>>>>>>>> +        return false;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>> +
>>>>>>>> +    return true;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline void 
>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>>>>> +{
>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>> +    list_del_init(&work->node);
>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>>> +
>>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>>> +    list_for_each_entry_safe(entry, tmp, 
>>>>>>>> &domain->pending_works, node) {
>>>>>>>> +
>>>>>>>> +        list_del_init(&entry->node);
>>>>>>>> +
>>>>>>>> +        /* Stop any other related pending resets */
>>>>>>>> +        cancel_delayed_work(&entry->base);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>>   }
>>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>>>>>>>> sr-iov ready */
>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>>>>>>>> enabled on this GPU */
>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>       uint32_t            reg_val_offs;
>>>>>>>>       struct amdgpu_irq_src        ack_irq;
>>>>>>>>       struct amdgpu_irq_src        rcv_irq;
>>>>>>>> -    struct work_struct        flr_work;
>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>       struct amdgpu_mm_table        mm_table;
>>>>>>>>       const struct amdgpu_virt_ops    *ops;
>>>>>>>>       struct amdgpu_vf_error_buffer    vf_errors;
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>>>>>>>   {
>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>> amdgpu_device, virt);
>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           return r;
>>>>>>>>       }
>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>         return 0;
>>>>>>>>   }
>>>>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>> +
>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>> &adev->virt.flr_work);
>>>>>>>>   }
>>>>>>>>     static int xgpu_ai_request_init_data(struct amdgpu_device 
>>>>>>>> *adev)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>>>>>>>   {
>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>> amdgpu_device, virt);
>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           return r;
>>>>>>>>       }
>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>         return 0;
>>>>>>>>   }
>>>>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>> +
>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>> &adev->virt.flr_work);
>>>>>>>>   }
>>>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>>>>>>>   {
>>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>> amdgpu_virt, flr_work);
>>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>>> amdgpu_device, virt);
>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           return r;
>>>>>>>>       }
>>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>         return 0;
>>>>>>>>   }
>>>>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>> +
>>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>> &adev->virt.flr_work);
>>>>>>>>   }
>>>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>>>>
>>>>>
>>>
