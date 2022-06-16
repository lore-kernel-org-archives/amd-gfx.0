Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16620C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D76E10EDF6;
	Thu, 16 Jun 2022 21:31:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60E910EDF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVfSrStAwMCUY5RjVH1QNzj1dvxQUXQ8yna3wCdPWsKAWtQsq10C/2W5YgbpFWnT/2P7VI7Xr9m7kzHfVFLXmUqxeuIR5S3V7CPPoOwrAEJoof3h7ntLsh5BZXLEouswu+6GO1b5I73M9UjzneaKyousPzaXmgbWZQIK8RUI+G+Ql410ACxrckMCHzsBV7J+vVeom52BrSVb9uAT3lLFwYS8CoHXdr6NO9OaFsp2YN45bz1E/lThSqXvU31OdpidGmPEVrGEZs6ZhpId2eSl0qS3bZjPrfp0SOj4L6HSBsLFXS5b3sDyXAt/8vVw1Pf8JzkkMXoR3AbplIb2k2edQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaD/Y3n8PzA4ZRRV6bJ7ewDpvmDrBHV9aRDTOFK2AZY=;
 b=gFEO8FaAZdPnc9a7Bbuch/VHqjDbUqWYg9Ia3qsd7/t+veP0VNXYxsE39PkRWg7kMF7ECbPxnojqxjz6RbOd4v2s68pvLd62D7NxBG3XS9P08R+QbmhXqfHdFKjO5uM0EuGfNKkTVpuCS2EoNxlA1oYZMYXLapnpLie9zt0oAwQ3Srs2jQLIOPTVbYbjGLVJ/wt9rSwmvDTz4k7/stFRDEBgzu/2WjBprzuDFghxfsik8GiHRqmu+jzxDVdMw1kqc8c7DxUSl/zUZt2tDuZGFISgkM+Ut3CUMhJxqXRA7u3+26LjDxV6IWznBAkP7ZqsgNNdrkwAj50GJALxGZ+PNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaD/Y3n8PzA4ZRRV6bJ7ewDpvmDrBHV9aRDTOFK2AZY=;
 b=2TDEk/npmTExGZUFdGvQxNISAcc32W8g1gTW5NkRhwP3N3HN/jJzRT8IDc+Lvb1PoiG0ZVevfUZRseBjN6jhxPO60hu2Ar/pIUw3bRmk6lPKFy36Z8ekPr7czPpEmTY+74OxIS4cdEJUy+w2tRbrzmsmDB0wirT+Mpd1CcTTfSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BN6PR1201MB0099.namprd12.prod.outlook.com (2603:10b6:405:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 21:31:29 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 21:31:29 +0000
Message-ID: <24138d3c-1593-4d43-af76-5ad114e213b6@amd.com>
Date: Thu, 16 Jun 2022 17:31:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Simon Ser <contact@emersion.fr>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
 <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
 <CADnq5_Pp+xSJO1mR24PQmm5bHhjY1Q-wC8GG97pr6axvrkmZeQ@mail.gmail.com>
 <wXTO8YYCjZe9USXO-9_zGZeVtSuFwgspCcHzjSZk9xdRK3Q1JisYUroSqU4GUwhL4At_N8UZifT5EAQJMBu5ADnetH8zlrOJNrG0NKqv-4E=@emersion.fr>
 <CADnq5_N_TJPy+UumtFkCn7GOVZjFuk2KxQPcFdJ8uVayC0EBqQ@mail.gmail.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <CADnq5_N_TJPy+UumtFkCn7GOVZjFuk2KxQPcFdJ8uVayC0EBqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:610:e4::17) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa523721-b74e-4b54-5b46-08da4fdf9328
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0099:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0099FC573074115EB7F4517798AC9@BN6PR1201MB0099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l13ha/Ap4iokzBseJgMH1UpHeV35BMKfA8BpjfKfbgQMhkOzyZpR8d4Zz8a+8N/AvY9n4mcNjz9+B4nkRCd2vKTxEEkK20DXGkOP/JnEfz3KsnZVzCvv4KYnorjHOa2gaQ55qozhqz3u60JrfCAim5YBjPNAKZzfrGrki63XMQZT5ix2ye9fEJIZdsxjPJH9/4pI7gDH6ogz6VTAmUYBjziljuHPT1+9WqtPV+EbDrIB/3RxWDyplcrSBEM5kYo4LWKl6tHFByIcq0UkK6kd/BI0SG5pFZ+KSOftuXIz27e51MPSv3YlCWdw2syQVKq2GvZPGgryKMvBSRkQ6Sse4toN8p3aE5HuKvxupbnru0yQ0KinbcELoRVjjBhk9cama9cNhxd4gBB7ncCXkrG0U+P49B9Z6v6fh0xekxxFNgfUV1adnVX4XecWvvtwiZ8kRHS/BBdLWHDwjGQJb4vuwErxDxjbZd50NOntaM9L1GzhnJ45Qzt+o7789dXGH9ZxWV5BLVE7xFzowfKLtnL0VTNZ3TvoR5w4aKuFzWxloWHPbagk2crOo/l0NtUNUAYPYs/Bdwka41f3ZMtblP7T2fNy4sFMoJ9wywOQkTpCR5dXwBgSPLa2J934zuzc8Rshx+1QUqBdFdfmbjXJxuRwLAhq2EpEX8ulcEcWMsbluJZ75WTrNOIQ+ETv67Kv3sfuDbArvyLapuBbFmQQUYmrIqrfuUiawWRulJfA0QgeMTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(36756003)(31686004)(4326008)(8676002)(7416002)(8936002)(6486002)(66946007)(5660300002)(66476007)(54906003)(66556008)(110136005)(2906002)(316002)(2616005)(86362001)(26005)(508600001)(186003)(31696002)(6666004)(6506007)(53546011)(38100700002)(83380400001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U255ZlE0cC96cHljM2xZREF2U1ZaSzZlVXk0a0VVZWs5Y3JPNmxFYURhMjJi?=
 =?utf-8?B?VzBuUUJzUzRGQ3BMVFNwQ2F0aXZLa3V4QnRJY1RuZnJ4N3FKQkg5S1NVcmNV?=
 =?utf-8?B?Q3hsNXpJMkJOd0xSZG1GN3p6U3pqZ0U2b3VWL0M3RnU0VWxlQU83TEtoSnFL?=
 =?utf-8?B?NG55ckpqbzlzcUNYZkthTTZQRlVlTUZodEpoMG11ZGJVRFc2K2dOMTYvcWNT?=
 =?utf-8?B?cENYTERrWk9WNWRHM2lXUzdleWhsSWhLOExGYWNHUXVqcndtRnRLZW5PQjBk?=
 =?utf-8?B?MmR3b21OZW5PMmNhRGRRcVlha2ZRdW02a3dRMHJaVmQ2Q2I5eC9wN09RQm0w?=
 =?utf-8?B?c0Q3bldqd0FsYWlKWFhpaXZyeVZqNmJNMi9wc3lrSWZsbjhiOGZVcVAvdHJV?=
 =?utf-8?B?S1EzY2s5bzZ6TEl6MU9DaDBVcmJTbytwNHZqK3Vuc29RL2xhOXdLOVNxd040?=
 =?utf-8?B?M3diWG5ueUVDV1pRY25PK1pKVW9EMkFrMHF6UEt1T2V1OFJJZEtWVDZLQWlM?=
 =?utf-8?B?bksxVHliQzFTek9yTWJxZ1lKUkV2aVcvT2dhS3pKVG9yMUFyWnp2OTdWTTFI?=
 =?utf-8?B?QUh2a2hVdlh0QWt2Q2dxT2RBMVd6THJyRkFidDMzdDU0OUN5dktIZTB1WUg1?=
 =?utf-8?B?N1FJWStvVUZrbFlWUUdEQVZNNWNqUXZodVFzdVJXbDNlQU03U0dCbjFub3NS?=
 =?utf-8?B?V1g0Y2ZSR244cUw3Y3h1TTZpNDZtODIrQXRSVWNCbmxPUXZyRC92ZEgxMzF0?=
 =?utf-8?B?bUNqcGs1dzQ2SGc4SDJFVVFBOStYZWpicjhScDAwUTl5L3lmbWZmRUZsbXp4?=
 =?utf-8?B?TWt4djhNS2UyVCtnUlRFNVh5dlBtUDk3NWxKaUZya2RaSkZ2b0hEbmlkc2ZC?=
 =?utf-8?B?Mm1GZDlmMGJrREp0MW5hemtIR0c3TWtrNnduY1NzN09zYURDMWRodEg5QUlx?=
 =?utf-8?B?b01oSlJ0bXdUTGM0QjZqMUN5bzFhT3h6VW8wM01XN3p1anF6aEdna1ExZy9L?=
 =?utf-8?B?czNSRHFrVzYyY1FMN0NKT2tOVE16ZytwNUpyU0hoZDdJU0hiOGd2WGhPQTlk?=
 =?utf-8?B?VEZWc0ZlVUVpZkhyeFZXOUhVVnlWMXdLMXB6YkFwWEF3TjN5ZWx5eTV6ZWpx?=
 =?utf-8?B?MnBEcTM0QksraDFDRmFibnJvNFZyZXpBWWdVZ2RHZVoxUjBQbzhaSkFCdlky?=
 =?utf-8?B?OHhnczl3Q0JHbE5UZUhQQ1F1ZnJ4NmQ2ZTZSdlJSbVF4dWh4V0NkdHlJeW5T?=
 =?utf-8?B?NjN5S1NnSktJcWF4MmVsbGJyMG0yb3hHWjZJWlk2SStud0tTQTlRU29WMHc4?=
 =?utf-8?B?TytURnMyYlhydHN5ekZFRlNITnJ2UDdhSWh0ZWJDWVNGQUZ5R2Q2NUhCYlVh?=
 =?utf-8?B?VGU0Q0tGc0ZvT2tYeDlHWWJrTDYrM1V3NFZEbk1Nb2lEVTBMbEdQemlneWNp?=
 =?utf-8?B?ZElFaVpyYUJwWXp1d3U5OTU0WDhIempkM2h3TGdVbkltZExuY080OSt3TEZY?=
 =?utf-8?B?bVBwNXJTaEpoM3N2cm50UTJ1Z1NmU1BPdTJBVHhDemlKQlFPN1lsdDhGVDJQ?=
 =?utf-8?B?TndraWpBeE0vaEttQXlrQ2c3UjlSVjljTnlaWjQ4cVBuRHRrOGZMd3Z6RjRz?=
 =?utf-8?B?cnhMRWN6d2pmczRkMWpKb0N0ZTBnU2x2d3dGRSs1bWVwcFlmczVqVFpMdTZp?=
 =?utf-8?B?T0t3YlFISG05SW8vWkc0ejVUY3dpTkNFb0lQVzlWTi9uWmNUaU8yUVRINzc2?=
 =?utf-8?B?ZnhhWVRSczMrbjJ0TnVlSTA0Q1Y0WC9WdXpjOThrV0VXZnZxSDFzV0tSOW9S?=
 =?utf-8?B?ZlJVWW9qaGhpSUNRL0VhSzN5NElaU3VFWDNRZE45MHBCSGN5Tk1rWFMrZjVQ?=
 =?utf-8?B?YktOSTVBUTJVM2t4M2N0dUcrUGpJcFdrc0NxMTFLb1ExaXpBckdGM0tZVjVn?=
 =?utf-8?B?aHJYdVVURjNSS2k1VGEwNlJzMko0WWY1eFFIcTJVSVNGUWd4aTY2eE1HWDB4?=
 =?utf-8?B?aGRTTWcwaHpqTDlna3Y2N0N5QXF6by95TGlERllIaTBwMXB1Vm0wUlJwU1FC?=
 =?utf-8?B?eXRkbyswRExxUkVLVnluaUdKekpFQ213ZEQ5WmpmREJ3cExEZkxlN3pqVTlv?=
 =?utf-8?B?S21ZL3VzL3BobzRQc2RuNmRSVERNTURSNkxUeWlidFl0RnBRUEoyZjVMd0xI?=
 =?utf-8?B?c3ZzMmxwd1NiaWh6K1VvMUtOWDVpZ3V3MlBVbFVLWlRHNVN6RXhLWjVKcURG?=
 =?utf-8?B?UGNEQlBIUkNIdlR3YmcxelNhRDNsRzBPNVM5cm9aRGU4SWpPaTBaM3hieFlG?=
 =?utf-8?B?YXhZaUVvdmFnRHdYRXRlOVJFaDZncStLMTA3WEZMb3ZEQ2RRM0RwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa523721-b74e-4b54-5b46-08da4fdf9328
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:31:29.3418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J01/+mJHE6gdzYMvJGNS0u1mvBEzw3HQO911wIu2EbDYC4/V2TGz7QtaC9e++nOLAqUYtEiov0KFK8B3Bm8DnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0099
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
 Melissa Wen <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-15 10:13, Alex Deucher wrote:
> On Wed, Jun 15, 2022 at 3:47 AM Simon Ser <contact@emersion.fr> wrote:
>>
>> On Tuesday, June 14th, 2022 at 20:30, Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>>> On Tue, Jun 14, 2022 at 2:16 PM Simon Ser contact@emersion.fr wrote:
>>>
>>>> On Monday, June 13th, 2022 at 22:01, Rodrigo Siqueira Rodrigo.Siqueira@amd.com wrote:
>>>>
>>>>> Amdgpu driver is used in an extensive range of devices, and each ASIC
>>>>> has some specific configuration. As a result of this variety, sometimes
>>>>> it is hard to identify the correct block that might cause the issue.
>>>>> This commit expands the amdgpu kernel-doc to alleviate this issue by
>>>>> introducing one ASIC table that describes dGPU and another one that
>>>>> shares the APU info.
>>>>
>>>> Nice!
>>>>
>>>> Are there plans to keep this list up-to-date?
>>>>
>>>> FWIW, my go-to reference tables are 1, updated by Alex.
>>>>
>>>> Would it make sense to add a "GFX Core" column?
>>>
>>> That's what the GC column is for.
>>
>> Oh! Does this stand for "GFX Core", or for "Graphics and Compute"? The
>> glossary documents GC as the latter. If there is a name conflict, maybe
>> we can keep using the long name in the table, or document what "GC"
>> means in a sentence.
> 
> Both?  The hardware block is called GC, but I think different teams
> expand it to Graphics Core (as in GCN) or Graphics and Compute.  Same
> hardware block either way.  I guess we should include both in the
> glossary.


How should I add it? Something like this:

GC/GFX:
  Graphics and Compute/Core

Thanks
Siqueira

> Alex

