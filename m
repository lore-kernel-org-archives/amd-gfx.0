Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58929C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 17:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0098510EF5A;
	Wed,  2 Mar 2022 17:56:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC4110EF5A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 17:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfm62G/HzQclK70gpvfOOV9CC126tmdo/vyuL3z09t1N8VcYYNp8Rz38JVttGm4+brVUHxZ3SpyvwQWGXYPDEM/eWORnvsWKyxzXdhrHObIHGALH8Pe/6wP0nPUlUWuIBAv4YTYd6Wp8vBLAp0JZe6ZzrJM5Wxgi/tsqM46cXYQq5kSBNm7kcLKGlrpST7CK9ISA0Pc7wqVEb7PN805NjSVK7/UAxiNE6M41Qr+dvKDoeiBrB9jTpDZTpD0GM9RGTLk2uOe8BJR490+M8wBkAdLMRr4H9PxYfU5OCJf/bumEfHSi53J+VcSKJHC4hU3N81WjmyC+jbD5zb+F0Q+/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOwMUs5SC0+2qPM1uJ/vuLDt5J7QAmDV8YKcB7A4nRU=;
 b=BsuHKQ9SeWk3ikaup4uF6nnPHohSRYh7W/nZGDMgHvRhQkolGZBImBX2ATpXurUf10SxwoVrwcXuk3ykf0kNaAUv+U1dCKbPr1KLXampYSuO6IgujUPmQ9B1VBgCSWr0AfSf9gQaTWYegUgBtVi7Gd/WINeEvRhPFX84rQHT73B/Hz0PBy0DcRGN9pIHG9TKGmlOkIYfXcgrXig/B9YlXnRi5xa+3/HFq376ETvNs2ZJozhXHtIkU4gD/YypiZUP3WyL8s0FZRFRdNdqzm5Y7zP2gu0UI7v/f6kS7Q0fGaJrxk2fdpFVLdc0nXq2zTve7tGrqsgw9wCwu2mpfzLS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOwMUs5SC0+2qPM1uJ/vuLDt5J7QAmDV8YKcB7A4nRU=;
 b=tQmmyJI4DP1ujdr2sXEUaQMLYcHtNwsQE23Uq9F2g/oQSIGmXGkSG5D+YzvB0TeuMSAP7hD7jS4p4Tr8F8izbRSy9OKZqvSSPiZwJT7fcpLv33zfDcCRvNsog8RJSu2ky3rAotDgTp3n/kfirlj2nsFg/TDexN/egdgMQnbmpEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 17:55:59 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 17:55:59 +0000
Message-ID: <0049c754-2af6-0558-3278-620faa4ed7e3@amd.com>
Date: Wed, 2 Mar 2022 12:55:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Content-Language: en-US
To: JingWen Chen <jingwech@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
 <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:610:b3::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d38a2b2-731b-4cb3-1c3c-08d9fc75e81c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4421:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44219E6CCAEAA6A165CADF19EA039@MN2PR12MB4421.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wt618nNoPRv7D8vBPh2fVdURMCXBjRKwpv22ZFNS0Dn1DxtkltYc1rPYOt9pVW27pSmuDn2HdGvQ12LwDq907CkVleSUmdGqjW63zYm0vqF87pajf1XTuhrFu5dYBHgERMvyIvzG01N4ooCvH+RWfTipgG3AO6RJxrAJMksGEa03m0L16T7cJpKIFw5uYfKDdX1EV90ypWFvxOBw6WYhlLLSckOgUI2fsy8zPaEIsVm0WyyEGSBNE2RN368LCLgZJ5+P1qSqCgFknX/q+RCC1Zc6zEGxlk9v0PldiaavKcJ5GYvnABKiB9bqU4p2vU8vRXY1at9x0vosEICZjBm9mo2Zd9zSfEdGhx+WqeZtipWVDeB68M4k+R6e+7/9vMS61XJyBUWk/tnN5ar6+A5+CgGRpKGurlwvjygNOhDmCajcJzABdyZJwFx63V9f3mnQelC+ubQ45zllqRYUf9X+fkunR1mDOPHV4RjxU/63/j0Hud0ZpEWj+ZUg8Uq/AzlYiWl9LcpJbWNsmCI9CO78Uv4RVU2U5stYdoi+CYksXAOprHxDYe3XBrVzraKxdA9F6yAGiW4Oml59SIDi3tVF9w2oOm2Q9An/9YeidzCcfxcD2vtWGuYFq/9ooWckAYvlOBUXb8cTc88E+1ZB81Cnmk4C72tUZ8nHmBpZo10QdfEyEvBEpEteS9fr+U5m0MJ0MvUaFvUMB3Ck/POZacYMnDE41t0KVQisumfqlUqOWacPXKoGUrppbO2zAJEL1cn3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(31686004)(6512007)(6506007)(53546011)(6666004)(54906003)(110136005)(83380400001)(66574015)(8676002)(2906002)(508600001)(8936002)(36756003)(5660300002)(2616005)(31696002)(66946007)(186003)(86362001)(38100700002)(6486002)(44832011)(66476007)(66556008)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWMrSFhqWlR5U1pqSXhIRGFROTRkTkptVWVJemI0aExCWE1kS0d2RVhPcnBj?=
 =?utf-8?B?bjZXbEg2YVdyK3VLdlVIM0ZGanBuUDY5Y3c4YmhLUVhyVHJQYlRYbWFRZ2Ro?=
 =?utf-8?B?MUQvSXBNai9odHJNekhDUU01R2JqbTM3ekxRa3JGYVAyM3lTOVdZazM1dG1W?=
 =?utf-8?B?TmRZRTJpYktrVWUzN3JVVWcrQklZcE1oUERiUVRzYUN0bGZQZ3JDSVBWZjZ0?=
 =?utf-8?B?OVFmdXhMcVpyM1BPaUZnNGdnVHZ0M2pvT1M5M3FXZm9FUEdSNy9ZWFhqUUYx?=
 =?utf-8?B?SnMxa1JxcmxMTkUrMnJxR3R5dG1CUFJwVGkvaEhYY0xIc0Q1TzVhMEwxKys2?=
 =?utf-8?B?eTgrM0xtOTVTYVFlWUpUUncvbmtCMGgyQ21XdGkzSXNWR1ZrYnNPZEpjUjFz?=
 =?utf-8?B?Zjd1WU5Ia2xHS2lBOWN4dVRUbzFGV2JLK3RxS1lSVmRCRlQ1eTRnVnczUVF0?=
 =?utf-8?B?elhOZHRJMDR2cmFnaDhNSkNpaFp5bmNjSHJvaFBRN0F2SGowQXdYQkZBKzdE?=
 =?utf-8?B?ZU1ZckgrckxlSHRlUXBueGMvYjRRNDY3UE02MGVvSWRWUFBHNFpLSzh6L2ZP?=
 =?utf-8?B?TllTZ2xpc2NiaElHd3NDbGRXYXFPVmEzOU4vMWpqcEloTlg4dU91RlFGa1pz?=
 =?utf-8?B?N2N4ajFXSThTSEkwaE5OaGFIcmk5R2pkTEpPRzFmQmVHWUdBTFgySzlueEZQ?=
 =?utf-8?B?MzlDNFNtMGJlWHI4aHRqc3d1a3phc2l4R1R2THRqa2t1TGhFL2tsTFhlaWxt?=
 =?utf-8?B?UnNkbk5vY1hjK25IVEF3TnNpUkU0Vjgwajk0ZWNuM0hQSTUvZzIwNmFmcWpH?=
 =?utf-8?B?VjdwUHgyNktvQW54SmNrUk40d3VMTGpOeVA3VTVZbWJYS05EM3ZmUXFXOUgw?=
 =?utf-8?B?Z3pqQmEydUtGNzVIbGROb2VKM0tjN3pLNFlWQ2Q0Q3ExWUpKbGpnUWV2blVn?=
 =?utf-8?B?VDFNMFRpd2NQTkRwa0VQRkdsR2d1YVFXYzZzOVlFenVNRldHd1RBWUh0ZUFX?=
 =?utf-8?B?NHlxVDRnd3Nwd0dsdHI1YkJPUEVhMnFaVHNYSUxNTFEyeVgrT3dpVG5IeW1n?=
 =?utf-8?B?bjRrUEliWGhrenl3UndaTkJ3eU1GR3p6Nzd5RFBqRlNleEhyc1RtYWpwTitx?=
 =?utf-8?B?V2FYM2xjYzhMSFpjNU52VmQvS0l5SHlZZnR6MnpuTy9ONEZyYWR3YnFIcy90?=
 =?utf-8?B?VmkzcGJSMkVIN04yeDlFcno2dzNFYUhORjhFenBPbFhCOERCSFcvYzFRUHlx?=
 =?utf-8?B?aURyYnlBb2ZvaGNsNC8wWFVielgvT1hUZ0xJV1NIbm4wUkF2UHlyZW5XZnhn?=
 =?utf-8?B?cnlTM3RJNTZxK0FuNVVlK283bjFicmpFV1N5WVQwY2FnQy9INHZidk4vWDZI?=
 =?utf-8?B?ZDBCREpWK3poZ2lpcXdZYlV0bW5FR1lZRWRReE02Mkx6bVNBUHhQd2hYem83?=
 =?utf-8?B?SzRHc2FwV1AyYjYrRWVzNHB4L0F0S25Xa2tvNE5IaGZGOG53dVJuSzJ3S3lN?=
 =?utf-8?B?YVdDM3ExVE0zVDZ6TGtYTkM4RitOSURBaVpUSWowRHlVaTRiSzdIdmhESzlP?=
 =?utf-8?B?Qi9SaGhyOXlYcTBLVDFCRjlrVWJkOTZtbHZwYmQ2Vm56ZUZvRDZ5RHVYNTlM?=
 =?utf-8?B?NUg5a2E1SDNXdWdwMkUyRTFDUlBsSjdwYUhIVElZRGtjTjU1dWQzRmtZSThU?=
 =?utf-8?B?d0ZtMmc2VWRBVjVhNkpqRTZwWmovUW5USFlxUVltWkpqbHBRTW93L3phWUhJ?=
 =?utf-8?B?K3ZYeE9OanE0VVRJRmtUUTFiTmo3Sjk0K2ZFZVJhUFN5M3hibUNFdzVmSHR3?=
 =?utf-8?B?OVRBSExZN1UwVEY0S2FVY0xTclNqTURUaWI2TmZXTlAyMklDNGpqRnZQeWlI?=
 =?utf-8?B?TDdpLzQ1ejNsRTYyZWNHTE5JWG1GbXZSZ1VyK0FlblpySXFkSTlnanJ3UE52?=
 =?utf-8?B?YjI5WHhhV2JpVXRjeEJ0NkZNRVYvV0lSRURsd0ZFM1lYSnBRbUZadjlhbnp2?=
 =?utf-8?B?ek12aXhCRkdPSDZXTHdxWUdoV2ZPU2FRUS9SOHhaQ2xvOTFTWmNXb2JZemh0?=
 =?utf-8?B?NlN3SWpJYkl3T2VqcXlkY2xTVU1mUlg5REp4VEtnNWNHUkF1L1kxM1RDV044?=
 =?utf-8?B?VStDTktJTmVTUHlEdVljK2pWME1DMEM1cDVzMCtVYUJ6eTRqZHo0WlU2cnYr?=
 =?utf-8?B?OWx2emxEZDNndGdLdTBCVHNyU2I5WkFJZUpYN0RnRlROSjMxbEx5SzNVVzBQ?=
 =?utf-8?Q?6rwYXN5vOKtfhukZE5LBsqY2JlSxPbaXNuzo+18Tek=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d38a2b2-731b-4cb3-1c3c-08d9fc75e81c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 17:55:58.9071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8zRKPwN+NNrY3JuyxDPy+PtYcc/AnSMiAMXYvtGdQcK05XA0czElu1FECymMKwnphdb7QY08YBkPWsJMGWMsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch is acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

If you also smoked tested bare metal feel free to apply all the patches, 
if no let me know.

Andrey

On 2022-03-02 04:51, JingWen Chen wrote:
> Hi Andrey,
>
> Most part of the patches are OK, but the code will introduce a ib test fail on the disabled vcn of sienna_cichlid.
>
> In SRIOV use case we will disable one vcn on sienna_cichlid, I have attached a patch to fix this issue, please check the attachment.
>
> Best Regards,
>
> Jingwen Chen
>
>
> On 2/26/22 5:22 AM, Andrey Grodzovsky wrote:
>> Hey, patches attached - i applied the patches and resolved merge conflicts but weren't able to test as my on board's network card doesn't work with 5.16 kernel (it does with 5.17, maybe it's Kconfig issue and i need to check more).
>> The patches are on top of 'cababde192b2 Yifan Zhang         2 days ago     drm/amd/pm: fix mode2 reset fail for smu 13.0.5 ' commit.
>>
>> Please test and let me know. Maybe by Monday I will be able to resolve the connectivity issue on 5.16.
>>
>> Andrey
>>
>> On 2022-02-24 22:13, JingWen Chen wrote:
>>> Hi Andrey,
>>>
>>> Sorry for the misleading, I mean the whole patch series. We are depending on this patch series to fix the concurrency issue within SRIOV TDR sequence.
>>>
>>>
>>>
>>> On 2/25/22 1:26 AM, Andrey Grodzovsky wrote:
>>>> No problem if so but before I do,
>>>>
>>>>
>>>> JingWen - why you think this patch is needed as a standalone now ? It has no use without the
>>>> entire feature together with it. Is it some changes you want to do on top of that code ?
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>> On 2022-02-24 12:12, Deucher, Alexander wrote:
>>>>> [Public]
>>>>>
>>>>>
>>>>> If it applies cleanly, feel free to drop it in.  I'll drop those patches for drm-next since they are already in drm-misc.
>>>>>
>>>>> Alex
>>>>>
>>>>> ------------------------------------------------------------------------
>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> *Sent:* Thursday, February 24, 2022 11:24 AM
>>>>> *To:* Chen, JingWen <JingWen.Chen2@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>> *Cc:* Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>
>>>>> *Subject:* Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is ready
>>>>> No because all the patch-set including this patch was landed into
>>>>> drm-misc-next and will reach amd-staging-drm-next on the next upstream
>>>>> rebase i guess.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-02-24 01:47, JingWen Chen wrote:
>>>>>> Hi Andrey,
>>>>>>
>>>>>> Will you port this patch into amd-staging-drm-next?
>>>>>>
>>>>>> on 2/10/22 2:06 AM, Andrey Grodzovsky wrote:
>>>>>>> All comments are fixed and code pushed. Thanks for everyone
>>>>>>> who helped reviewing.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>> On 2022-02-09 02:53, Christian König wrote:
>>>>>>>> Am 09.02.22 um 01:23 schrieb Andrey Grodzovsky:
>>>>>>>>> Before we initialize schedulers we must know which reset
>>>>>>>>> domain are we in - for single device there iis a single
>>>>>>>>> domain per device and so single wq per device. For XGMI
>>>>>>>>> the reset domain spans the entire XGMI hive and so the
>>>>>>>>> reset wq is per hive.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>> One more comment below, with that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 34 ++--------------
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>>>>>>>>>       3 files changed, 51 insertions(+), 30 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index 9704b0e1fd82..00123b0013d3 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -2287,6 +2287,47 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>>>>>           return r;
>>>>>>>>>       }
>>>>>>>>>       +static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +    long timeout;
>>>>>>>>> +    int r, i;
>>>>>>>>> +
>>>>>>>>> +    for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>>> +        struct amdgpu_ring *ring = adev->rings[i];
>>>>>>>>> +
>>>>>>>>> +        /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>>> +        if (!ring || ring->no_scheduler)
>>>>>>>>> +            continue;
>>>>>>>>> +
>>>>>>>>> +        switch (ring->funcs->type) {
>>>>>>>>> +        case AMDGPU_RING_TYPE_GFX:
>>>>>>>>> +            timeout = adev->gfx_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>> +            timeout = adev->compute_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>> +            timeout = adev->sdma_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        default:
>>>>>>>>> +            timeout = adev->video_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>> + ring->num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>> +                   timeout, adev->reset_domain.wq, ring->sched_score, ring->name);
>>>>>>>>> +        if (r) {
>>>>>>>>> +            DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>> +                  ring->name);
>>>>>>>>> +            return r;
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>>       /**
>>>>>>>>>        * amdgpu_device_ip_init - run init for hardware IPs
>>>>>>>>>        *
>>>>>>>>> @@ -2419,6 +2460,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>>>               }
>>>>>>>>>           }
>>>>>>>>>       +    r = amdgpu_device_init_schedulers(adev);
>>>>>>>>> +    if (r)
>>>>>>>>> +        goto init_failed;
>>>>>>>>> +
>>>>>>>>>           /* Don't init kfd if whole hive need to be reset during init */
>>>>>>>>>           if (!adev->gmc.xgmi.pending_reset)
>>>>>>>>> amdgpu_amdkfd_device_init(adev);
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>> index 45977a72b5dd..fa302540c69a 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>> @@ -457,8 +457,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>>                         atomic_t *sched_score)
>>>>>>>>>       {
>>>>>>>>>           struct amdgpu_device *adev = ring->adev;
>>>>>>>>> -    long timeout;
>>>>>>>>> -    int r;
>>>>>>>>>             if (!adev)
>>>>>>>>>               return -EINVAL;
>>>>>>>>> @@ -478,36 +476,12 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>> spin_lock_init(&ring->fence_drv.lock);
>>>>>>>>>           ring->fence_drv.fences = kcalloc(num_hw_submission * 2, sizeof(void *),
>>>>>>>>>                            GFP_KERNEL);
>>>>>>>>> -    if (!ring->fence_drv.fences)
>>>>>>>>> -        return -ENOMEM;
>>>>>>>>>       -    /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>>> -    if (ring->no_scheduler)
>>>>>>>>> -        return 0;
>>>>>>>>> +    ring->num_hw_submission = num_hw_submission;
>>>>>>>>> +    ring->sched_score = sched_score;
>>>>>>>> Let's move this into the caller and then use ring->num_hw_submission in the fence code as well.
>>>>>>>>
>>>>>>>> The maximum number of jobs on the ring is not really fence specific.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>       -    switch (ring->funcs->type) {
>>>>>>>>> -    case AMDGPU_RING_TYPE_GFX:
>>>>>>>>> -        timeout = adev->gfx_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>> -        timeout = adev->compute_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>> -        timeout = adev->sdma_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    default:
>>>>>>>>> -        timeout = adev->video_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    }
>>>>>>>>> -
>>>>>>>>> -    r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>> -               num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>> -               timeout, NULL, sched_score, ring->name);
>>>>>>>>> -    if (r) {
>>>>>>>>> -        DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>> -              ring->name);
>>>>>>>>> -        return r;
>>>>>>>>> -    }
>>>>>>>>> +    if (!ring->fence_drv.fences)
>>>>>>>>> +        return -ENOMEM;
>>>>>>>>>             return 0;
>>>>>>>>>       }
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> index fae7d185ad0d..7f20ce73a243 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> @@ -251,6 +251,8 @@ struct amdgpu_ring {
>>>>>>>>>           bool has_compute_vm_bug;
>>>>>>>>>           bool            no_scheduler;
>>>>>>>>>           int            hw_prio;
>>>>>>>>> +    unsigned num_hw_submission;
>>>>>>>>> +    atomic_t        *sched_score;
>>>>>>>>>       };
>>>>>>>>>         #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
