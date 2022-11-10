Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D24C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 10:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE4210E132;
	Thu, 10 Nov 2022 10:18:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9629610E132
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 10:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEdP7jHte4teyWVIqokWeyLyrEdE/NKVKbOlShqMv8txGrvXZAH8JO/45/t1mus89TywcClo852LwUar1ktDGIQKafwXmA04LyKe7+LHzFGUyaUn9DnyR9P+ql2T8fRG2K+eBj/Pm6hLCzoQi2fKmf1/ocFVfAEq5FXMcnL2A9gW1vCYNCi4bUcCaG24cck5mlNllfdSG9TeOEy1G45Xc/pWdcb5h4JDafBtYxCNpVtDj//UXQ5PGq0J4tf7yPcQ+1JkxI+S5JC/1nBv6RSPpoRsh8SLymYs6HYxw0YIhF1NjK9pXNklJQtXIsKMH6i/lvyZhF9XwZe989VXTQuayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOf/aa75L/Ho6O24SZhFGhJqI0Pbr567mGwb+ojgW3I=;
 b=Xs3VFsgXb2vIsGKm7QQAFFrIl4WrQ8XVUwgPiNgMzDCELtJMYUOeMgDo+hC4x0H/oybB/MikEegxHn1E1AWYKODHp9hrthhknZjq4S4hjKJQYG7sr4qb4IdVu/cLiPbMr3tCSimcCfwFHQCFCw3gf0zEfZz4iTK3GwaqGnpo8A90rjHH3vjj1hW4f2OXPf+tPWemyQZ5xypCaz+VaVgvr76zzFaqv6OQanY949XRXiMJCAysFp3fYRjW3TyNBaCxvfhNV9N5bBBSy8ROjB1P4dZlcLWJVbZ9lOW4ASs5v+v0P5CdhFOno1cXLqOTqIo5JSarSGsaJ92GDy2VU2oYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOf/aa75L/Ho6O24SZhFGhJqI0Pbr567mGwb+ojgW3I=;
 b=vs7WL0v3eUw2f8QTdKj05pSE23Tcu5r3Pp+ngZJfdQpGzd0heJRD1mj+b3tmv/NX4NhWAh0fXuEPkU+tiUElClUWaD0l3EOTftMExX5mMynr0pFP2vn6MxkgA6B701CPD/9wu45ujl8Z4M+GmMTYp91HKzpzaytJks4+gmr7oXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 10:18:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 10:18:28 +0000
Message-ID: <d7c99c50-c0a3-9c92-ec8c-2b3f5c8ec017@amd.com>
Date: Thu, 10 Nov 2022 11:18:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Bokun" <Bokun.Zhang@amd.com>
References: <20221108103236.8777-1-Tong.Liu01@amd.com>
 <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
 <444456c6-b66b-615a-f340-a5867073a496@amd.com>
 <DM6PR12MB49587BC1D9F0C46AC8646073813F9@DM6PR12MB4958.namprd12.prod.outlook.com>
 <c8b8b0ad-96b6-9ce6-8391-26f0189c758f@amd.com>
 <DM4PR12MB61341AD581900D4861E8DA3190019@DM4PR12MB6134.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB61341AD581900D4861E8DA3190019@DM4PR12MB6134.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b8311e-2281-4b53-fb31-08dac304e8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jMgWxnhzf4goWE+k4gJAjvYNeBMvfUBII+hz5lSga0enlPT4LQFTDKuBAQELZEJsRxYpidl3H+q7ttYm58hp2Ti9pHU6MT/ZmsbQHYKOB1NPySrox0rAQhuhQxVfwugl8k427dPZ+Ge9nzYuOe7QQqPZspdghdzW+M6Uhrl/h/pnh+d5lJrgkC68rllZCvepyLVg52VxPMLLieAH99Jh/mt2BLyH0G+Gm+510IxjNvouun7km7LHgh6v7eXM46iTYz1rXnDRo0509Ob4br6qFT14z2At+h59U0VDBCLgKsK5/OD5YHEdr8IP1r7zCXjxG9AJFAuEhGJUksnZR5u+Gpr/6aDbC30iw1JSGg7Ww1VWA0DULOd7ZzeO5G79TS934m2h/xt/EORdWDL333wcw33IJZw8spNxfmPWmvcTncu9UrhCzxvDq+aCZzDAiBssoCr4NOO+AyrzCVaVDjdD2w4v1TQPwckjN32dGsV+m0LeCvfSzmUivvJX7EQUfz/qKeVto5bZhDC4fURYEHrWLKRARuvoZ9f+XDBTs+PMfm7gFCOxfW8V86D0vqTlMGXzthRRe9bO/Zzt6T92DUq7vJPzj+IhGcc8Tr7mPC2U5OKbxeQlw0UUSYH1eb30JzBNieiz6FPdclVlwMRfIZLDP50zl6KPWgFsk7K8Y6CqOkYstPzZzdLwzCav9d26kC1QUjuJNRTESHAGVjwiMOtdmSm47IKRa2ZZl6/8EJ5bv+dN04TMGKKn7ex8xxH2/RfEfw3XZq+/uvsGlpvRkrf4vsBqrzwBoyZ2Y9n29LtMME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(478600001)(38100700002)(30864003)(2906002)(6486002)(2616005)(66574015)(186003)(6666004)(83380400001)(36756003)(6512007)(53546011)(6506007)(66476007)(66556008)(316002)(4326008)(31686004)(8676002)(26005)(66946007)(86362001)(31696002)(6636002)(54906003)(8936002)(5660300002)(110136005)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFphYUt6Tmhuc0FjV25TdHJrY2t1S3BNZzhKZWs0eURjekJRNW55T05iWGYz?=
 =?utf-8?B?UUp1U21rdXROT3VWZFNDWHFFYy9oVHlvSkdxeTRrRXloeUpJeWd0MmFXM0Rq?=
 =?utf-8?B?S0RQbGRlOWl3TzhDbFQ0bkg2SDFJY0xuUkNPK2xYSkIyYUFIL0pBMGhSemlp?=
 =?utf-8?B?QXUyTmJwRG4rSjBXaWdjby9qWTFkdXR0S0NzY3BydmtJdDNWLzhlbFBlTlZi?=
 =?utf-8?B?dFAwZzdjZjRyM2RmMGgrVCs0Uk9BWWoxb3dBcGlibFNtQ29LV0c5akZ1STRW?=
 =?utf-8?B?ZWwwa1BzaHJvY2xoekZBck9SYk5vb1k3TkNGc2tiTDh2OWJnWlJES2xhT2pV?=
 =?utf-8?B?by9sY1FJT3dwbGIrVWFRQ0dLTy90VHY5bjl6Q2NBclMxR2dDd3gxQ0tWcFVQ?=
 =?utf-8?B?SmNpMmNOQ05ZWFJuQmJFREVsS3NmL21lQW1JR0lzdTM0eThuSnRZL2NBZTZt?=
 =?utf-8?B?N0dsOVU5L095akFpNDA4eisyZVlMclFuS1JURUpkRWFsdnNQS3NTL0w0RW5N?=
 =?utf-8?B?cEFQNGtNV3UrVGNrM25EU3h4VkdkbzJBOGNRdlEzaEhyNzF1dXFZQUduU1FI?=
 =?utf-8?B?SUc0VnlJdVk3eDUyL2pidFNQWFpHYVU2OTE5a2RqM0xZcFFyM0ZrQ0VEQ3hG?=
 =?utf-8?B?YnZtZkFDY2tjYXFVNmhxZjRoTW1rcVZpRHh1OWxWbHRPcW5NQktDRTl6Q3g3?=
 =?utf-8?B?SjQvY1M1K1pqQmNzc0gwRUlrQ3hVL2RiV0ttRnVLNDZiZWtUWTJ4Ynh2cENk?=
 =?utf-8?B?RXplMTBEVDNYU2huZUJJL3lRRUhuSVRneDV1Z1JRK0FKRWd3c0l3dnZmNTIv?=
 =?utf-8?B?Um5xblBWb0tJL2lWKzM2S0xZT1o3SVFtcCsyZWoxVWM2Ty84MXV2a2pkYm9T?=
 =?utf-8?B?d1ViTDYwUUFtQTVKaFZLVEpabDZaVHFMM2YrajJwcXVFUEV6cTBIUjlkeXBw?=
 =?utf-8?B?V1NjSFdna09vR21ySk5kWGlxODJjcG81MXAyRDcrR0p4d1dPRjZ5OHM5R0dn?=
 =?utf-8?B?NUUxTWZIYVNDLzRMdWo1UXJSL2thbDhzU2dNcnVsYUFKUGFCNk5kcEVyODA5?=
 =?utf-8?B?d0NSWlBaYmpuRngvOVE0dkdsSDFYemRUdncvdjNSU3JaK2RSWGIzWTlFeS9V?=
 =?utf-8?B?S1hSQ21JQkpFZzJMM21zZWJKN0Y1c1JBandYVWxEUW9UeTBIN050eGZyWDFM?=
 =?utf-8?B?NVY1UkNmUEkrWEE0V2RlMnA3Tmk4UHptTlZUVm83VVpmbk9ENjB5ampQRXNJ?=
 =?utf-8?B?bnhkWWMwbUF3bDQ3YXVNMHNRd0lGb3RLVWtXYW1GR2Q5Rk1jaE50UkhLQjB1?=
 =?utf-8?B?ZGxxRXZJc1Q1dm00TVlvOUhSaHZyY2N4L2tHVDhvcGNKQVpEMjM5TGora05u?=
 =?utf-8?B?MXN4YldpR0lZa3V2cVpDNDJRSlp3MlBNNHZ2S09hZEdEdkx6ZHdiZFJEV0Yr?=
 =?utf-8?B?WGp5bEYzY3RZbnlSdzBQUEpmTGl1eWR5WnZyMU5OTGNFWHpUcHBiWVN2MzFO?=
 =?utf-8?B?VXgySFFkenIzSDNuMkIvNnQ5SEJPamUzUWlMSzRRRGNFQ1NEWXVaQnRqQTZO?=
 =?utf-8?B?U0tlSU5VQTFnb2p1K3J0aWlGRHdvY3Y5QzNxdXJKUHRwNGpZZ04xcGRxamtq?=
 =?utf-8?B?UXRDMTd0RWRIT09YWWpVTjU5bU81MjN5QlgxeWU0cFdWaGRoK0FEVGtEVGx2?=
 =?utf-8?B?aDV2djBLb1kydmtMK3cvR2xaUTIwd2QzcWR1ODRKdnAwZm9pWGtNeVFhUzRv?=
 =?utf-8?B?K1o1UVJISm1UWmNCbFVuU1Q5dkM0MzV0ODRrWERNM0NuZElSbUd4VTdoQmJr?=
 =?utf-8?B?Ykgvekt6YzgvYVkzQkgxNDM4OTE1VHVJZDdEOHlXaUVDa2FsSmlxSVVpY253?=
 =?utf-8?B?WEFwY2xpNlR0eEhCY01EYUkzcGp5cWsxZGZSbGx0NTR1TXN1UVluREw2dHR5?=
 =?utf-8?B?Y09EcnByY1dKbWdQWm9HdzBKdll6N1RTLzJQMTdzSmNqNkZGUTQvR1RFcGRr?=
 =?utf-8?B?aDZTQXI2Qjdvd1RHK0NpYTNVeU42Lys0a1o2b0luelpJTDhuN01Ha3FRTXdO?=
 =?utf-8?B?QW1WYTJ0QmhQQlU0cHptYVpBcVJ3TXprUnVSeDlCQUZybDl5T1FkRlcvczBQ?=
 =?utf-8?Q?YV/Vvs7pat8YNIY+uKZp2uqI2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b8311e-2281-4b53-fb31-08dac304e8e8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 10:18:28.3870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7Kegvz70fmrzM2EI5GhZL+nli0WP3zcT8VILOc20DuuXrLg261wg6et2FDzTicL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Sohail, Rashid" <Rashid.Sohail@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Feel free to add my Acked-by: Christian König <christian.koenig@amd.com> 
to the patch.

Luben might have some additional comments, but in general I think the 
biggest problem here is the mail settings.

Somehow either the mail client or the mail server are corrupting the patch.

Regards,
Christian.

Am 10.11.22 um 11:14 schrieb Liu01, Tong (Esther):
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> Please find the attached patch, thanks!
>
> Kind regards,
> Esther
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2022年11月8日星期二 下午10:04
> To: Chang, HaiJun <HaiJun.Chang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Bokun <Bokun.Zhang@amd.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Sohail, Rashid <Rashid.Sohail@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>
> Yeah, I mean the code looks correct.
>
> It's just that style problems are usually pointed out by automated checkers, especially things like dos line endings.
>
> So get that fixed and we can push it immediately.
>
> Thanks,
> Christian.
>
> Am 08.11.22 um 14:49 schrieb Chang, HaiJun:
>> [AMD Official Use Only - General]
>>
>> + Bokun to help addressing the coding style problem in MKM side.
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, November 8, 2022 8:53 PM
>> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>;
>> Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>;
>> Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;
>> Sohail, Rashid <Rashid.Sohail@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
>> vram_usagebyfirmware_v2_2
>>
>> Hi Esther
>>
>> well there are a couple of things which you need to address before getting this merged.
>>
>> First of all the patch you send out uses dos line endings instead of the unix line endings. Not sure how you manage to do that, but please use "git send-email" instead to avoid that.
>>
>> Then your patch contains a bunch of white spaces after code warning which checkpatch.pl complains about (after ignoring the dos line ending warnings). So this was clearly not properly checked with checkpatch.pl.
>>
>> Then the kernel coding style usually says that with a multi line "if ("
>> the next lines should start after the opening "(". In other words intend with tabs and the whitespaces. I'm not sure what editor you are using, but there are standard settings available for basically all large editors which does stuff like that automatically. Please try to use one of those.
>>
>> Regarding the casing of the values it's a good argument that you only move the code around, but the general coding style is just extremely questionable. The defines should use the lowest necessary integer type.
>> But it's correct that this should probably be part of another patch.
>>
>> Regards,
>> Christian.
>>
>> Am 08.11.22 um 11:40 schrieb Liu01, Tong (Esther):
>>> [AMD Official Use Only - General]
>>>
>>> Hi @Koenig, Christian,
>>>
>>> Refined as your comment. By the way:
>>> if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT))
>>>
>>> This part is the old code, I just move it out from the original function to shrink the function size as your comment before. And now I just removed the first uint32_t since if remove both will cause "warning: bitwise comparison always evaluates to false". And I tested the code after removing the first uint32_t, the code works well. Please review the new patch, thanks.
>>>
>>> Kind regards,
>>> Esther
>>>
>>> -----Original Message-----
>>> From: Tong Liu01 <Tong.Liu01@amd.com>
>>> Sent: 2022年11月8日星期二 下午6:33
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
>>> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig,
>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
>>> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
>>> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
>>> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
>>> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
>>> vram_usagebyfirmware_v2_2
>>>
>>> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve
>>> TMR region firstly to make sure TMR can be allocated at 2MB
>>>
>>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>>> ---
>>>     .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>>>     drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>>>     4 files changed, 192 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> index b81b77a9efa6..032dc2678d7c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>>>         }
>>>     }
>>>
>>> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>> +             struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
>>> +             int *usage_bytes)
>>> +{
>>> +     uint32_t start_addr, fw_size, drv_size;
>>> +
>>> +     start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
>>> +     fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
>>> +     drv_size =
>>> + le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
>>> +
>>> +     DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
>>> +             start_addr,
>>> +             fw_size,
>>> +             drv_size);
>>> +
>>> +     if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>> +             (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>> +             ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>> +             adev->mman.fw_vram_usage_start_offset = (start_addr &
>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>> +             /* Use the default scratch size */
>>> +             *usage_bytes = 0;
>>> +     } else {
>>> +             *usage_bytes = drv_size << 10;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>>> +             struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
>>> +             int *usage_bytes)
>>> +{
>>> +     uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
>>> +
>>> +     fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
>>> +     fw_size =
>>> + le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
>>> +
>>> +     drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
>>> +     drv_size =
>>> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
>>> +
>>> +     DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
>>> +             fw_start_addr,
>>> +             fw_size,
>>> +             drv_start_addr,
>>> +             drv_size);
>>> +
>>> +     if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>> +             /* Firmware request VRAM reservation for SR-IOV */
>>> +             adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> +             adev->mman.fw_vram_usage_size = fw_size << 10;
>>> +     }
>>> +
>>> +     if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>>> +             /* driver request VRAM reservation for SR-IOV */
>>> +             adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>>> +                     (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> +             adev->mman.drv_vram_usage_size = drv_size << 10;
>>> +     }
>>> +
>>> +     *usage_bytes = 0;
>>> +     return 0;
>>> +}
>>> +
>>>     int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>>>         struct atom_context *ctx = adev->mode_info.atom_context;
>>>         int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>>                                                 vram_usagebyfirmware);
>>> -     struct vram_usagebyfirmware_v2_1 *firmware_usage;
>>> -     uint32_t start_addr, size;
>>> +     struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
>>> +     struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>>>         uint16_t data_offset;
>>> +     uint8_t frev, crev;
>>>         int usage_bytes = 0;
>>>
>>> -     if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
>>> -             firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>> -             DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
>>> -                       le32_to_cpu(firmware_usage->start_address_in_kb),
>>> -                       le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
>>> -                       le16_to_cpu(firmware_usage->used_by_driver_in_kb));
>>> -
>>> -             start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
>>> -             size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
>>> -
>>> -             if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>>> -                     (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>> -                     ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>> -                     /* Firmware request VRAM reservation for SR-IOV */
>>> -                     adev->mman.fw_vram_usage_start_offset = (start_addr &
>>> -                             (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>> -                     adev->mman.fw_vram_usage_size = size << 10;
>>> -                     /* Use the default scratch size */
>>> -                     usage_bytes = 0;
>>> -             } else {
>>> -                     usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
>>> +     if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>>> +             if (frev == 2 && crev == 1) {
>>> +                     firmware_usage_v2_1 =
>>> +                             (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>>> +                     amdgpu_atomfirmware_allocate_fb_v2_1(adev,
>>> +                                     firmware_usage_v2_1,
>>> +                                     &usage_bytes);
>>> +             } else if (frev >= 2 && crev >= 2) {
>>> +                     firmware_usage_v2_2 =
>>> +                             (struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
>>> +                     amdgpu_atomfirmware_allocate_fb_v2_2(adev,
>>> +                                     firmware_usage_v2_2,
>>> +                                     &usage_bytes);
>>>                 }
>>>         }
>>> +
>>>         ctx->scratch_size_bytes = 0;
>>>         if (usage_bytes == 0)
>>>                 usage_bytes = 20 * 1024; diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 585460ab8dfd..4a73cb314086 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>>>                 NULL, &adev->mman.fw_vram_usage_va);
>>>     }
>>>
>>> +/*
>>> + * Driver Reservation functions
>>> + */
>>> +/**
>>> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * free drv reserved vram if it has been reserved.
>>> + */
>>> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
>>> +*adev) {
>>> +     amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>>> +             NULL, NULL);
>>> +}
>>> +
>>>     /**
>>>      * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>>>      *
>>> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>>                                           &adev->mman.fw_vram_usage_va);
>>>     }
>>>
>>> +/**
>>> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation
>>> +from driver
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * create bo vram reservation from drv.
>>> + */
>>> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device
>>> +*adev) {
>>> +     uint64_t vram_size = adev->gmc.visible_vram_size;
>>> +
>>> +     adev->mman.drv_vram_usage_reserved_bo = NULL;
>>> +
>>> +     if (adev->mman.drv_vram_usage_size == 0 ||
>>> +         adev->mman.drv_vram_usage_size > vram_size)
>>> +             return 0;
>>> +
>>> +     return amdgpu_bo_create_kernel_at(adev,
>>> +                                       adev->mman.drv_vram_usage_start_offset,
>>> +                                       adev->mman.drv_vram_usage_size,
>>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>>> +                                       &adev->mman.drv_vram_usage_reserved_bo,
>>> +                                       NULL); }
>>> +
>>>     /*
>>>      * Memoy training reservation functions
>>>      */
>>> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>                 return r;
>>>         }
>>>
>>> +     /*
>>> +      *The reserved vram for driver must be pinned to the specified
>>> +      *place on the VRAM, so reserve it early.
>>> +      */
>>> +     r = amdgpu_ttm_drv_reserve_vram_init(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>>         /*
>>>          * only NAVI10 and onwards ASIC support for IP discovery.
>>>          * If IP discovery enabled, a block of memory should be @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>>         amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>                                         &adev->mman.sdma_access_ptr);
>>>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>>> +     amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>
>>>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 9120ae80ef52..339838675b11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>>>         struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>>         void            *fw_vram_usage_va;
>>>
>>> +     /* driver VRAM reservation */
>>> +     u64             drv_vram_usage_start_offset;
>>> +     u64             drv_vram_usage_size;
>>> +     struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>>> +
>>>         /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>>         struct amdgpu_bo        *sdma_access_bo;
>>>         void                    *sdma_access_ptr;
>>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
>>> b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> index ff855cb21d3f..c0f56ae653f0 100644
>>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1  };
>>>
>>>
>>> -/*
>>> -  ***************************************************************************
>>> -    Data Table vram_usagebyfirmware  structure
>>> -
>>> *********************************************************************
>>> *
>>> *****
>>> +/*
>>> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
>>> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
>>> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
>>> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
>>> +    if( VBIOS/UEFI GOP is posted ) {
>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
>>> +      driver can allocate driver reservation region under firmware reservation,
>>> +      used_by_driver_in_kb = driver reservation size
>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
>>> +    Host driver would overwrite the table with the following
>>> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
>>> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
>>> +    } else {
>>> +      there is no VBIOS reservation region
>>> +      driver must allocate driver reservation region at top of FB.
>>> +      driver set used_by_driver_in_kb = driver reservation size
>>> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
>>> +      same as Comment1
>>> +    }
>>> +  } else { //( NV1X and after)
>>> +    if( VBIOS/UEFI GOP is posted ) {
>>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
>>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
>>> +    }
>>> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
>>> +      driver can allocate driver reservation region under firmware reservation,
>>> +      driver set used_by_driver_in_kb = driver reservation size
>>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>>> +      same as Comment1
>>> +    } else {
>>> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
>>> +      driver set used_by_driver_region0_in_kb = driver reservation size
>>> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
>>> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
>>> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
>>> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
>>> +    }
>>> +  }
>>>     */
>>>
>>>     struct vram_usagebyfirmware_v2_1
>>>     {
>>> -  struct  atom_common_table_header  table_header;
>>> -  uint32_t  start_address_in_kb;
>>> -  uint16_t  used_by_firmware_in_kb;
>>> -  uint16_t  used_by_driver_in_kb;
>>> +     struct  atom_common_table_header  table_header;
>>> +     uint32_t  start_address_in_kb;
>>> +     uint16_t  used_by_firmware_in_kb;
>>> +     uint16_t  used_by_driver_in_kb;
>>>     };
>>>
>>> +struct vram_usagebyfirmware_v2_2 {
>>> +     struct  atom_common_table_header  table_header;
>>> +     uint32_t  fw_region_start_address_in_kb;
>>> +     uint16_t  used_by_firmware_in_kb;
>>> +     uint16_t  reserved;
>>> +     uint32_t  driver_region0_start_address_in_kb;
>>> +     uint32_t  used_by_driver_region0_in_kb;
>>> +     uint32_t  reserved32[7];
>>> +};
>>>
>>>     /*
>>>
>>> *********************************************************************
>>> *
>>> *****
>>> --
>>> 2.25.1

