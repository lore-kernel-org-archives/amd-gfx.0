Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45027C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 16:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F6510F62B;
	Wed, 27 Apr 2022 16:04:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4F510F626
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 16:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDRvVP29HSeFkw8J9sTvt3ce+HaBVvWg0wZuFh4hls+w6At+zT3Y2nOdhZ+gqqGHvzvYt6CEZn0iWGyeUMmjikRceL0A0xGbyFLHnKfz8DaYmrC4+Q7MAnFVoEuctyLht12WfSsokFDz0C7RGFs3XxfO00D1m3ttXmB9URv9PomDbdkp4xYFRDTTDovPRu1mqtGtNHJkjBekZ2lr17oYu42MNTcrqVk2BrKah3TYsEdqeo8Y3NHWWudOqnajCDRjK4mk6g3se+nl8/03RFvX93NYLjVc5LIVo/P7rrj9WMYgyo3mQAM2ShlvA4Lqe1kbNnzOaHnaGa0iJwLOLKB9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MVrT7BUPb4aitdtqJ2rXtzkgSwQAzn7+JYbSf4l+I4=;
 b=PEMkWjXg9DA2HW/8bpZFwrQ79G25w+iylD1mhsqgnZ2iihg/YK5jebSLeZjol9kFPeMkmNsFLzqCCOKtj2fM7SWbxpyCGrQ9wQpNNNPywEP4lX0oNfo3EJ2TDmJj/JuCkLcQTKNHo8qjNZa5Ss5P6ELrlovlElDwIfxo/9cvH88ai2D69OVDJX8dC3ejSSEia7OpNs3Mzz+pLzcnvhnIyGcSnBPc74p9I9dioiYxoH0OlGbt8vmymjCPxuQWCgff/qIEyjt/RJFAWPgSFr9kfMrsQm7vk0AMde5A7jfnTgtc6MIcrX2WRRZn++IVlgnVSTihFRIV//Gxb+cKM5fQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MVrT7BUPb4aitdtqJ2rXtzkgSwQAzn7+JYbSf4l+I4=;
 b=4SwLHezegpEuzeu1EnpdYW+hdof/utFVftcBel5Lsc2ef02byFopFQkG+44I7yB9uCLRMmYA0Q4mnFcOWVFsDU8IZS3+hM9/y6RzdhHncfIk5DAEwTcL41G2hceZRHx0391a056aqCJfPV6hO9PvYvMQMfZO7fMYOGOcjRz5wow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Wed, 27 Apr 2022 16:04:06 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:04:06 +0000
Content-Type: multipart/alternative;
 boundary="------------j90eeYIplYIxbo7kFgo026lH"
Message-ID: <66bf32d5-1636-ecdd-8a49-24c6254079bf@amd.com>
Date: Wed, 27 Apr 2022 12:04:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
 <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
 <549246A3-B326-47CC-92FD-608708E1876B@microsoft.com>
 <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
 <0d99be40-f6b9-b191-feca-d74344f03bf2@amd.com>
 <FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com>
X-ClientProxiedBy: YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00125432-c082-4233-5e03-08da28678e46
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6288669866CDA9B856CB923BEAFA9@DS7PR12MB6288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aPg4uhGhnsJlD7H8U7cM5rJLr2pdtJjK2weNK4NNpJq6qtjlncTJ3Qd6ZK1gFMsQf0vHS8n6xfAywKRZjDn8ZPn3t1AOTm5lL1UCDiXyYhQdoPzkkR0IA+N3qBFRSqmIJsyI94dTAfAUTTD7Wz8FcedzVyDC0oO2GCuo/THvG+Rf2L+QbLB0+ZlL80dlHLMw2yXsIgsjzn5SPRb2x0oM09Uv3yUNPtCX2L6vbJuhuclBFSavj3w843fG4jlekwMuHOoLC8/I8JspOl+yZkMjAd/jzQcGy3dE7gCAakCdi+eQvnToRXiTpy0uLQYq/z6afYhHWcBB4hoPbSGPiu3Bv7vYdnWiBhD0h6mzn/ZoR/TOQLWoWDEYtujXbD4H612VHOmbtDg++puxxcT3hAB+4ZVUpfch+c7n/OzAIfAzTmbmQJ/b/7Slr1zEsJlj9+TeGzOFILSazjr8wLnzWcxfSQOCxZ0A4fS67clg9qpU74VCXbhqN1olyw09qJipFc8w6swk/Khrzdoc3id1nvRksmBt8MhmUkS2Hzi/z+cm5aXJ/C5B3rXrclRu6zczsIshUWo8Lhe+9PRHavdWkbridtKMG85ty2CUAprR2Aq5lQWOQaCQkcX7orf285GQIdWGWnNGrG8C3exKFonka7rmB+EHNgH9fwbwugVt3g7phY3NtEf8PLalQIjMzDJhEqbCt+2gZwgRGGEd6tiTon4HdwYOd8DYZf3FVidFh0mWabPaQsFAYC35zoHVT2C5QYNBrzQD7bQuqela4utP3i8baM18OZC6+DXez2paHezp6k46APA/nb9/R7gVcv8Aam2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(316002)(8676002)(4326008)(166002)(6916009)(54906003)(66946007)(31686004)(66556008)(66476007)(36756003)(30864003)(6512007)(6666004)(2906002)(6506007)(44832011)(83380400001)(31696002)(2616005)(5660300002)(86362001)(45080400002)(186003)(8936002)(966005)(508600001)(53546011)(33964004)(6486002)(43740500002)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRRV0RTanB5S05xdEFrMEtCczRpdmgzaUxaWWF4bjVtenF3MEpzZ3RPZE94?=
 =?utf-8?B?V1RicjlSWGt3K0FnUzJDaGIzeGU5OFQvbGRBNEJTOFhtNkV5bkdSSmZYS1lV?=
 =?utf-8?B?aUZ4bXpmS1AwQTA5VTNVa2Q2WHNFWWZwb1ZvK2s1U3lvempRajBkSUpndjNp?=
 =?utf-8?B?SkkrODBIeVRRQitXY0hzSklXWjdidjVSQ0M4dXA5S2xNc1V2WGJ2ajB6TGdt?=
 =?utf-8?B?ekFJRWhSdW5BQWppU0s0RUZYSkVvR2Q0SjVuSDJkK1lUbUlDVDlzZkN0SjdO?=
 =?utf-8?B?a1huWjE0WUphODVQZWQ3a1ljeUk0eHFDbHpTYmt3MVlJZWhxTHVIRXBjV3Yv?=
 =?utf-8?B?RnNhYUtXUW5XdkxBS2tYRWZpMmNMZ3hXK1hreUFjNEdmK1JCVEZ0VHZrM0Ev?=
 =?utf-8?B?SDNEQlNSc2syZktteEhaRCtsOWhqUHpMUkpIZjdCRzZlcGFuMERJS3dlNExt?=
 =?utf-8?B?WXRDSTBFeHZMOUZxR3ZiaDRvaEhPeEhUUUM1SlZ6Q2hKR2k3S085SGFWMXM1?=
 =?utf-8?B?cWhzUFRwV0NKbzl2NEJZYmxVN1NtZmtkRVpJM0lkU0pCTmg1RTc4RkVhbW95?=
 =?utf-8?B?aVFYYzU5cytkb2xRblFoVXQ0WGVka3NDZTBSeFlqRlpMTGdvTldlVXBrc2s1?=
 =?utf-8?B?TDVRMklodGFWWWVlT0EzYU5oNHIwRVBJZDBaQWlKL1hLY2NhRnZTejZQOURs?=
 =?utf-8?B?dUFScWRaVi9iL2VJRUNwSGxDMjJwQnNPSkZCdlpuRS85YWgrZEJlbWJVRjk0?=
 =?utf-8?B?T0h4L1pqOFhZRDFScW9CVnA1NzJoL0VFWC81RUxMbkV1VG1aN3RlQlcyK0ZG?=
 =?utf-8?B?RVpNcCsyQ3NYTElLeGczNmZxTE1UOFVlZktQdWhVbVhrUjF3NzdTalBMcDZ6?=
 =?utf-8?B?b1VpbHVBWGJmbWJBTFFNaDZXVkd5OVJoblE1N0VvOUltSnNEQTI5UkdUdWgy?=
 =?utf-8?B?RnYvNTBLbkpXeUZCWjJZTWxrWStlNzJ4N2lycllZWnRNVWc3UjJhNDJyQXdS?=
 =?utf-8?B?bFVYOE4rRHJ1alZmaU5MWENFOUI0VVJWazJWbExDREJKZkl4Q0dGWWJFeHZ6?=
 =?utf-8?B?OWpJT0d0YTR6SVdEVTN1YSt6YzJuWFBxV0FQQ3dpVmxIV01IWThTYnRxNXBQ?=
 =?utf-8?B?TUVReWxlOWxQeFRDVmVTZGNFMmxIeGhwbjB1NDZOZDc3SkpsRTFCdEhINUlM?=
 =?utf-8?B?SEFZbFRQZmtYSW96TkNCclZ4VEJiMlpqb2RUNGVGclpobko1ZFM3OXFzbjV6?=
 =?utf-8?B?TjJHZ05Ud2l0Z2N2MjBWWVA2QXdWVFdHeUZHeUkxZmNlSDQyVk5LRkJrRm1O?=
 =?utf-8?B?T3dRNXkzSm1jZ04zT3dJZVU0NGNiU2FOdS9aeXB0Z1B0MEJLRXRVWk1ZcWJG?=
 =?utf-8?B?NytVUjhXaFJPOUFhVlNEN1d2ZUZsb25aTFRQOWE4K282LzdnbkwxdXh4Wjd6?=
 =?utf-8?B?WHhEWmYwUHBTY0FlODE2L2JxUWRhS0Z5RXhUVVpLUjMxWHdxenJINTAvU1Zs?=
 =?utf-8?B?RHZWOEQ4YURBSTQwVllDeEs5b29FZ3dpSW04QlZjSnZFcGsvTWFjSmpZQTVV?=
 =?utf-8?B?RzBBUzhoQXU2Y0pKemJYbUZUOFN6WWk5TkJMZzFZWDlST00vcUJ5SnJrck5T?=
 =?utf-8?B?L3ZTWWM5V1ROMytaSnpwQWM5WStEV2FkenhQelVHTDdiZWFkenpjbVV6MENC?=
 =?utf-8?B?SjgrdzczWlVTTTBpNWtaN054ZFQyZGRNQzFiZ1daOFQ0bXlNOUlteXg2Zk9q?=
 =?utf-8?B?ejBxYXpTR1l5VThReTExL1dOY1VUVCs5VGxSZUx5cUMxYnhWeWtLbjlNd2tB?=
 =?utf-8?B?OERhR0h3V09Kc0xOUmJJMVFKbHAzVTVoZE92NUlGOXhDWWdNaVRjSkhZa0Rm?=
 =?utf-8?B?Mk56MzZVSHhXOXlFUk1wQWxXVm41V1pqL0pLVXlmQytlKzB1Y1EreFhNNU96?=
 =?utf-8?B?QmtSTU5TVWNaMjRHajQvM3NlWS9Mb0psMTZzdXF6YUFiWVRwN1VxTjBsRitD?=
 =?utf-8?B?a0Q0TnhINFNJZ2FJY1p2azBtbkR2SmhoNktpSTNJdTFQUkF3Z3hxeTZVeWlS?=
 =?utf-8?B?Z011WTJEUWFxZ2g2WWlvd2tFY0JkdzY2NmNBblc4M2xKUnFzeSttWi9hekVT?=
 =?utf-8?B?WkdTem1iWStMV1ZSSnRlaFZMUk5MVStRNm5ZUnBYYkpBdk1SQzZhNWE1NDBP?=
 =?utf-8?B?eHVOVFZkUVF2dmJuaU1mSWdQMk4vT2lJdDlWNHUzcmZ4c1BSSi9IVzQzQkNt?=
 =?utf-8?B?c1d5YTVaZ3p5bFFma3pDQkovUURyUTdBaUxXOVJIODI5ZWQwWWh1Q1RXajFx?=
 =?utf-8?B?UjBaSGRLVVoyTmxYTzVkYTFGZnlxMFFxaTI4UDFnd1VySWZxRGhOR1hGTkFu?=
 =?utf-8?Q?4NVPpG3XVEALJtpcYGh4U15FVmzJlHFsYuxUyQgZQipl1?=
X-MS-Exchange-AntiSpam-MessageData-1: 5kQu5X/6wqjASg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00125432-c082-4233-5e03-08da28678e46
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 16:04:06.3502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM7KnjgU3SiX4qWlVCGnNJ4MiYnGv2BP8bkI7ywnhSWDWmJF6pvjJ9y1v8hyfUlMNBf6zjTd3+DKXNA90kmLBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------j90eeYIplYIxbo7kFgo026lH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-04-27 05:20, Shuotao Xu wrote:

> Hi Andrey,
>
> Sorry that I did not have time to work on this for a few days.
>
> I just tried the sysfs crash fix on Radeon VII and it seems that it 
> worked. It did not pass last the hotplug test, but my version has 4 
> tests instead of 3 in your case.


That because the 4th one is only enabled when here are 2 cards in the 
system - to test DRI_PRIME export. I tested this time with only one card.

>
>
> Suite: Hotunplug Tests
>   Test: Unplug card and rescan the bus to plug it back 
> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
> passed
>   Test: Same as first test but with command submission 
> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
> passed
>   Test: Unplug with exported bo .../usr/local/share/libdrm/amdgpu.ids: 
> No such file or directory
> passed
>   Test: Unplug with exported fence 
> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
> amdgpu_device_initialize: amdgpu_get_auth (1) failed (-1)


on the kernel side - the IOCTlL returning this is drm_getclient - maybe 
take a look while it can't find client it ? I didn't have such issue as 
far as I remember when testing.


> FAILED
>     1. ../tests/amdgpu/hotunplug_tests.c:368  - CU_ASSERT_EQUAL(r,0)
>     2. ../tests/amdgpu/hotunplug_tests.c:411  - 
> CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2, shared_fd, 
> &sync_obj_handle2),0)
>     3. ../tests/amdgpu/hotunplug_tests.c:423  - 
> CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2, &sync_obj_handle2, 1, 
> 100000000, 0, NULL),0)
>     4. ../tests/amdgpu/hotunplug_tests.c:425  - 
> CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2, sync_obj_handle2),0)
>
> Run Summary:    Type  Total    Ran Passed Failed Inactive
>               suites     14      1    n/a      0      0
>                tests     71      4      3      1      0
>              asserts     39     39     35      4    n/a
>
> Elapsed time =   17.321 seconds
>
> For kfd compute, there is some problem which I did not see in MI100 
> after I killed the hung application after hot plugout. I was using 
> rocm5.0.2 driver for MI100 card, and not sure if it is a regression 
> from the newer driver.
> After pkill, one of child of user process would be stuck in Zombie 
> mode (Z) understandably because of the bug, and future rocm 
> application after plug-back would in uninterrupted sleep mode (D) 
> because it would not return from syscall to kfd.
>
> Although drm test for amdgpu would run just fine without issues after 
> plug-back with dangling kfd state.


I am not clear when the crash bellow happens ? Is it related to what you 
describe above ?


>
> I don’t know if there is a quick fix to it. I was thinking add 
> drm_enter/drm_exit to amdgpu_device_rreg.


Try adding drm_dev_enter/exit pair at the highest level of attmetong to 
access HW - in this case it's amdgpu_amdkfd_set_compute_idle. We always 
try to avoid accessing any HW functions after backing device is gone.


> Also this has been a long time in my attempt to fix hotplug issue for 
> kfd application.
> I don’t know 1) if I would be able to get to MI100 (fixing Radeon VII 
> would mean something but MI100 is more important for us); 2) what the 
> direct of the patch to this issue will move forward.


I will go to office tomorrow to pick up MI-100, With time and priorities 
permitting I will then then try to test it and fix any bugs such that it 
will be passing all hot plug libdrm tests at the tip of public 
amd-staging-drm-next - https://gitlab.freedesktop.org/agd5f/linux, after 
that you can try to continue working with ROCm enabling on top of that.

For now i suggest you move on with Radeon 7 which as your development 
ASIC and use the fix i mentioned above.

Andrey


>
> Regards,
> Shuotao
>
> [  +0.001645] BUG: unable to handle page fault for address: 
> 0000000000058a68
> [  +0.001298] #PF: supervisor read access in kernel mode
> [  +0.001252] #PF: error_code(0x0000) - not-present page
> [  +0.001248] PGD 8000000115806067 P4D 8000000115806067 PUD 109b2d067 
> PMD 0
> [  +0.001270] Oops: 0000 [#1] PREEMPT SMP PTI
> [  +0.001256] CPU: 5 PID: 13818 Comm: tf_cnn_benchmar Tainted: G       
>  W   E     5.16.0+ #3
> [  +0.001290] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS 
> 1.5.4 [FPGA Test BIOS] 10/002/2015
> [  +0.001309] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
> [  +0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f 44 
> 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 09 
> 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 2e ca 85
> [  +0.002751] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
> [  +0.001388] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX: 
> 00000000ffffffff
> [  +0.001402] RDX: 0000000000000000 RSI: 000000000001629a RDI: 
> ffff8b0c9c840000
> [  +0.001418] RBP: ffffb58fac313948 R08: 0000000000000021 R09: 
> 0000000000000001
> [  +0.001421] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12: 
> 0000000000058a68
> [  +0.001400] R13: 000000000001629a R14: 0000000000000000 R15: 
> 000000000001629a
> [  +0.001397] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000) 
> knlGS:0000000000000000
> [  +0.001411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.001405] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4: 
> 00000000001706e0
> [  +0.001422] Call Trace:
> [  +0.001407]  <TASK>
> [  +0.001391]  amdgpu_device_rreg+0x17/0x20 [amdgpu]
> [  +0.001614]  amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
> [  +0.001735]  phm_wait_for_register_unequal.part.1+0x58/0x90 [amdgpu]
> [  +0.001790]  phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]
> [  +0.001800]  vega20_wait_for_response+0x28/0x80 [amdgpu]
> [  +0.001757]  vega20_send_msg_to_smc_with_parameter+0x21/0x110 [amdgpu]
> [  +0.001838]  smum_send_msg_to_smc_with_parameter+0xcd/0x100 [amdgpu]
> [  +0.001829]  ? kvfree+0x1e/0x30
> [  +0.001462]  vega20_set_power_profile_mode+0x58/0x330 [amdgpu]
> [  +0.001868]  ? kvfree+0x1e/0x30
> [  +0.001462]  ? ttm_bo_release+0x261/0x370 [ttm]
> [  +0.001467]  pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]
> [  +0.001863]  amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]
> [  +0.001866]  amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]
> [  +0.001784]  kfd_dec_compute_active+0x2c/0x50 [amdgpu]
> [  +0.001744]  process_termination_cpsch+0x2f9/0x3a0 [amdgpu]
> [  +0.001728]  kfd_process_dequeue_from_all_devices+0x49/0x70 [amdgpu]
> [  +0.001730]  kfd_process_notifier_release+0x91/0xe0 [amdgpu]
> [  +0.001718]  __mmu_notifier_release+0x77/0x1f0
> [  +0.001411]  exit_mmap+0x1b5/0x200
> [  +0.001396]  ? __switch_to+0x12d/0x3e0
> [  +0.001388]  ? __switch_to_asm+0x36/0x70
> [  +0.001372]  ? preempt_count_add+0x74/0xc0
> [  +0.001364]  mmput+0x57/0x110
> [  +0.001349]  do_exit+0x33d/0xc20
> [  +0.001337]  ? _raw_spin_unlock+0x1a/0x30
> [  +0.001346]  do_group_exit+0x43/0xa0
> [  +0.001341]  get_signal+0x131/0x920
> [  +0.001295]  arch_do_signal_or_restart+0xb1/0x870
> [  +0.001303]  ? do_futex+0x125/0x190
> [  +0.001285]  exit_to_user_mode_prepare+0xb1/0x1c0
> [  +0.001282]  syscall_exit_to_user_mode+0x2a/0x40
> [  +0.001264]  do_syscall_64+0x46/0xb0
> [  +0.001236]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  +0.001219] RIP: 0033:0x7f6aff1d2ad3
> [  +0.001177] Code: Unable to access opcode bytes at RIP 0x7f6aff1d2aa9.
> [  +0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS: 00000246 ORIG_RAX: 
> 00000000000000ca
> [  +0.001170] RAX: fffffffffffffe00 RBX: 0000000004f542b0 RCX: 
> 00007f6aff1d2ad3
> [  +0.001168] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
> 0000000004f542d8
> [  +0.001162] RBP: 0000000004f542d4 R08: 0000000000000000 R09: 
> 0000000000000000
> [  +0.001152] R10: 0000000000000000 R11: 0000000000000246 R12: 
> 0000000004f542d8
> [  +0.001176] R13: 0000000000000000 R14: 0000000004f54288 R15: 
> 0000000000000000
> [  +0.001152]  </TASK>
> [  +0.001113] Modules linked in: veth amdgpu(E) nf_conntrack_netlink 
> nfnetlink xfrm_user xt_addrtype br_netfilter xt_CHECKSUM 
> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 
> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter 
> ip6_tables iptable_filter overlay esp6_offload esp6 esp4_offload esp4 
> xfrm_algo intel_rapl_msr intel_rapl_common sb_edac 
> x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi snd_hda_intel 
> ipmi_ssif snd_intel_dspcfg coretemp snd_hda_codec kvm_intel 
> snd_hda_core snd_hwdep snd_pcm snd_timer snd kvm soundcore irqbypass 
> ftdi_sio usbserial input_leds iTCO_wdt iTCO_vendor_support joydev 
> mei_me rapl lpc_ich intel_cstate mei ipmi_si ipmi_devintf 
> ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel ib_iser rdma_cm 
> iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi 
> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic 
> zstd_compress raid10 raid456
> [  +0.000102]  async_raid6_recov async_memcpy async_pq async_xor 
> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear iommu_v2 
> gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper drm_kms_helper 
> syscopyarea sysfillrect sysimgblt fb_sys_fops crct10dif_pclmul 
> hid_generic crc32_pclmul ghash_clmulni_intel usbhid uas aesni_intel 
> crypto_simd igb ahci hid drm usb_storage cryptd libahci dca 
> megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]
> [  +0.016626] CR2: 0000000000058a68
> [  +0.001550] ---[ end trace ff90849fe0a8b3b4 ]---
> [  +0.024953] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
> [  +0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f 44 
> 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 09 
> 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 2e ca 85
> [  +0.003255] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
> [  +0.001641] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX: 
> 00000000ffffffff
> [  +0.001656] RDX: 0000000000000000 RSI: 000000000001629a RDI: 
> ffff8b0c9c840000
> [  +0.001681] RBP: ffffb58fac313948 R08: 0000000000000021 R09: 
> 0000000000000001
> [  +0.001662] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12: 
> 0000000000058a68
> [  +0.001650] R13: 000000000001629a R14: 0000000000000000 R15: 
> 000000000001629a
> [  +0.001648] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000) 
> knlGS:0000000000000000
> [  +0.001668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.001673] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4: 
> 00000000001706e0
> [  +0.001740] Fixing recursive fault but reboot is needed!
>
>
>> On Apr 21, 2022, at 2:41 AM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>> I retested hot plug tests at the commit I mentioned bellow - looks 
>> ok, my ASIC is Navi 10, I also tested using Vega 10 and older Polaris 
>> ASICs (whatever i had at home at the time). It's possible there are 
>> extra issues in ASICs like ur which I didn't cover during tests.
>>
>> andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test -s 13
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>
>>
>> The ASIC NOT support UVD, suite disabled
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>
>>
>> The ASIC NOT support VCE, suite disabled
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>
>>
>> The ASIC NOT support UVD ENC, suite disabled.
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>
>>
>> Don't support TMZ (trust memory zone), security suite disabled
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>> Peer device is not opened or has ASIC not supported by the suite, 
>> skip all Peer to Peer tests.
>>
>>
>>      CUnit - A unit testing framework for C - Version 2.1-3
>> http://cunit.sourceforge.net/
>>
>>
>> *Suite: Hotunplug Tests**
>> **  Test: Unplug card and rescan the bus to plug it back 
>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>> **passed**
>> **  Test: Same as first test but with command submission 
>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>> **passed**
>> **  Test: Unplug with exported bo 
>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>> **passed*
>>
>> Run Summary:    Type  Total    Ran Passed Failed Inactive
>>               suites     14      1    n/a 0        0
>>                tests     71      3      3 0        1
>>              asserts     21     21     21      0 n/a
>>
>> Elapsed time =    9.195 seconds
>>
>>
>> Andrey
>>
>> On 2022-04-20 11:44, Andrey Grodzovsky wrote:
>>>
>>> The only one in Radeon 7 I see is the same sysfs crash we already 
>>> fixed so you can use the same fix. The MI 200 issue i haven't seen 
>>> yet but I also haven't tested MI200 so never saw it before. Need to 
>>> test when i get the time.
>>>
>>> So try that fix with Radeon 7 again to see if you pass the tests 
>>> (the warnings should all be minor issues).
>>>
>>> Andrey
>>>
>>>
>>> On 2022-04-20 05:24, Shuotao Xu wrote:
>>>>>
>>>>> That a problem, latest working baseline I tested and confirmed 
>>>>> passing hotplug tests is this branch and commit 
>>>>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6 
>>>>> which is amd-staging-drm-next. 5.14 was the branch we ups-reamed 
>>>>> the hotplug code but it had a lot of regressions over time due to 
>>>>> new changes (that why I added the hotplug test to try and catch 
>>>>> them early). It would be best to run this branch on mi-100 so we 
>>>>> have a clean baseline and only after confirming  this particular 
>>>>> branch from this commits passes libdrm tests only then start 
>>>>> adding the KFD specific addons. Another option if you can't work 
>>>>> with MI-100 and this branch is to try a different ASIC that does 
>>>>> work with this branch (if possible).
>>>>>
>>>>> Andrey
>>>>>
>>>> OK I tried both this commit and the HEAD of and-staging-drm-next on 
>>>> two GPUs( MI100 and Radeon VII) both did not pass hotplugout libdrm 
>>>> test. I might be able to gain access to MI200, but I suspect it 
>>>> would work.
>>>>
>>>> I copied the complete dmesgs as follows. I highlighted the OOPSES 
>>>> for you.
>>>>
>>>> Radeon VII:
>
--------------j90eeYIplYIxbo7kFgo026lH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 2022-04-27 05:20, Shuotao Xu wrote:<br>
    </p>
    <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com">
      
      Hi Andrey,
      <div class=""><br class="">
      </div>
      <div class="">Sorry that I did not have time to work on this for a
        few days.</div>
      <div class=""><br class="">
      </div>
      <div class="">I just tried the sysfs crash fix on Radeon VII and
        it seems that it worked. It did not pass last the hotplug test,
        but my version has 4 tests instead of 3 in your case.</div>
    </blockquote>
    <p><br>
    </p>
    <p>That because the 4th one is only enabled when here are 2 cards in
      the system - to test DRI_PRIME export. I tested this time with
      only one card.<br>
    </p>
    <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com">
      <div class="">
        <div class=""><br class="">
        </div>
        <div class=""><br class="">
        </div>
        <div class="">Suite: Hotunplug Tests</div>
        <div class="">&nbsp; Test: Unplug card and rescan the bus to plug it
          back .../usr/local/share/libdrm/amdgpu.ids: No such file or
          directory</div>
        <div class="">passed</div>
        <div class="">&nbsp; Test: Same as first test but with command
          submission .../usr/local/share/libdrm/amdgpu.ids: No such file
          or directory</div>
        <div class="">passed</div>
        <div class="">&nbsp; Test: Unplug with exported bo
          .../usr/local/share/libdrm/amdgpu.ids: No such file or
          directory</div>
        <div class="">passed</div>
        <div class="">&nbsp; Test: Unplug with exported fence
          .../usr/local/share/libdrm/amdgpu.ids: No such file or
          directory</div>
        <div class="">amdgpu_device_initialize: amdgpu_get_auth (1)
          failed (-1)</div>
      </div>
    </blockquote>
    <p><br>
      on the kernel side - the IOCTlL returning this is drm_getclient -
      maybe take a look while it can't find client it ? I didn't have
      such issue as far as I remember when testing. </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com">
      <div class="">
        <div class="">FAILED</div>
        <div class="">&nbsp; &nbsp; 1. ../tests/amdgpu/hotunplug_tests.c:368 &nbsp;-
          CU_ASSERT_EQUAL(r,0)</div>
        <div class="">&nbsp; &nbsp; 2. ../tests/amdgpu/hotunplug_tests.c:411 &nbsp;-
          CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2, shared_fd,
          &amp;sync_obj_handle2),0)</div>
        <div class="">&nbsp; &nbsp; 3. ../tests/amdgpu/hotunplug_tests.c:423 &nbsp;-
          CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2,
          &amp;sync_obj_handle2, 1, 100000000, 0, NULL),0)</div>
        <div class="">&nbsp; &nbsp; 4. ../tests/amdgpu/hotunplug_tests.c:425 &nbsp;-
          CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2,
          sync_obj_handle2),0)</div>
        <div class=""><br class="">
        </div>
        <div class="">Run Summary: &nbsp; &nbsp;Type &nbsp;Total &nbsp; &nbsp;Ran Passed Failed
          Inactive</div>
        <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; suites &nbsp; &nbsp; 14 &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp;n/a &nbsp; &nbsp; &nbsp;0 &nbsp;
          &nbsp; &nbsp; &nbsp;0</div>
        <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tests &nbsp; &nbsp; 71 &nbsp; &nbsp; &nbsp;4 &nbsp; &nbsp; &nbsp;3 &nbsp; &nbsp; &nbsp;1 &nbsp;
          &nbsp; &nbsp; &nbsp;0</div>
        <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;asserts &nbsp; &nbsp; 39 &nbsp; &nbsp; 39 &nbsp; &nbsp; 35 &nbsp; &nbsp; &nbsp;4 &nbsp;
          &nbsp; &nbsp;n/a</div>
        <div class=""><br class="">
        </div>
        <div class="">Elapsed time = &nbsp; 17.321 seconds</div>
      </div>
      <div class=""><br class="">
      </div>
      <div class="">For kfd compute, there is some problem which I did
        not see in MI100 after I killed the hung application after hot
        plugout. I was using rocm5.0.2 driver for MI100 card, and not
        sure if it is a regression from the newer driver.</div>
      <div class="">After pkill, one of child of user process would be
        stuck in Zombie mode (Z) understandably because of the bug, and
        future rocm application after plug-back would in uninterrupted
        sleep mode (D) because it would not return from syscall to kfd.</div>
      <div class=""><br class="">
      </div>
      <div class="">Although drm test for amdgpu would run just fine
        without issues after plug-back with dangling kfd state. <br>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I am not clear when the crash bellow happens ? Is it related to
      what you describe above ?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com">
      <div class=""><br class="">
      </div>
      <div class="">I don’t know if there is a quick fix to it. I was
        thinking add drm_enter/drm_exit to amdgpu_device_rreg.</div>
    </blockquote>
    <p><br>
    </p>
    <p>Try adding drm_dev_enter/exit pair at the highest level of
      attmetong to access HW - in this case it's
      amdgpu_amdkfd_set_compute_idle. We always try to avoid accessing
      any HW functions after backing device is gone.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com">
      <div class="">Also this has been a long time in my attempt to fix
        hotplug issue for kfd application.&nbsp;</div>
      <div class="">I don’t know 1) if I would be able to get to MI100
        (fixing Radeon VII would mean something but MI100 is more
        important for us); 2) what the direct of the patch to this issue
        will move forward.</div>
    </blockquote>
    <p><br>
    </p>
    <p>I will go to office tomorrow to pick up MI-100, With time and
      priorities permitting I will then then try to test it and fix any
      bugs such that it will be passing all hot plug libdrm tests at the
      tip of public amd-staging-drm-next -
      <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/agd5f/linux">https://gitlab.freedesktop.org/agd5f/linux</a>, after that you can try
      to continue working with ROCm enabling on top of that. <br>
    </p>
    <p>For now i suggest you move on with Radeon 7 which as your
      development ASIC and use the fix i mentioned above.<br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com">
      <div class=""><br class="">
      </div>
      <div class="">Regards,</div>
      <div class="">Shuotao</div>
      <div class=""><br class="">
      </div>
      <div class="">
        <div class="">[ &nbsp;+0.001645] BUG: unable to handle page fault for
          address: 0000000000058a68</div>
        <div class="">[ &nbsp;+0.001298] #PF: supervisor read access in
          kernel mode</div>
        <div class="">[ &nbsp;+0.001252] #PF: error_code(0x0000) -
          not-present page</div>
        <div class="">[ &nbsp;+0.001248] PGD 8000000115806067 P4D
          8000000115806067 PUD 109b2d067 PMD 0</div>
        <div class="">[ &nbsp;+0.001270] Oops: 0000 [#1] PREEMPT SMP PTI</div>
        <div class="">[ &nbsp;+0.001256] CPU: 5 PID: 13818 Comm:
          tf_cnn_benchmar Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.16.0+ #3</div>
        <div class="">[ &nbsp;+0.001290] Hardware name: Dell Inc. PowerEdge
          R730/0H21J3, BIOS 1.5.4 [FPGA Test BIOS] 10/002/2015</div>
        <div class="">[ &nbsp;+0.001309] RIP:
          0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0
          7f 3f 75 ae 0f 1f 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01
          00 10 75 0d 4c 03 a3 a0 09 00 00 &lt;45&gt; 8b 24 24 eb 8a 4c
          8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 2e ca 85</div>
        <div class="">[ &nbsp;+0.002751] RSP: 0018:ffffb58fac313928 EFLAGS:
          00010202</div>
        <div class="">[ &nbsp;+0.001388] RAX: ffffffffc09a4270 RBX:
          ffff8b0c9c840000 RCX: 00000000ffffffff</div>
        <div class="">[ &nbsp;+0.001402] RDX: 0000000000000000 RSI:
          000000000001629a RDI: ffff8b0c9c840000</div>
        <div class="">[ &nbsp;+0.001418] RBP: ffffb58fac313948 R08:
          0000000000000021 R09: 0000000000000001</div>
        <div class="">[ &nbsp;+0.001421] R10: ffffb58fac313b30 R11:
          ffffffff8c065b00 R12: 0000000000058a68</div>
        <div class="">[ &nbsp;+0.001400] R13: 000000000001629a R14:
          0000000000000000 R15: 000000000001629a</div>
        <div class="">[ &nbsp;+0.001397] FS: &nbsp;0000000000000000(0000)
          GS:ffff8b4b7fa80000(0000) knlGS:0000000000000000</div>
        <div class="">[ &nbsp;+0.001411] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
          0000000080050033</div>
        <div class="">[ &nbsp;+0.001405] CR2: 0000000000058a68 CR3:
          000000010a2c8001 CR4: 00000000001706e0</div>
        <div class="">[ &nbsp;+0.001422] Call Trace:</div>
        <div class="">[ &nbsp;+0.001407] &nbsp;&lt;TASK&gt;</div>
        <div class="">[ &nbsp;+0.001391] &nbsp;amdgpu_device_rreg+0x17/0x20
          [amdgpu]</div>
        <div class="">[ &nbsp;+0.001614] &nbsp;amdgpu_cgs_read_register+0x14/0x20
          [amdgpu]</div>
        <div class="">[ &nbsp;+0.001735]
          &nbsp;phm_wait_for_register_unequal.part.1+0x58/0x90 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001790]
          &nbsp;phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001800] &nbsp;vega20_wait_for_response+0x28/0x80
          [amdgpu]</div>
        <div class="">[ &nbsp;+0.001757]
          &nbsp;vega20_send_msg_to_smc_with_parameter+0x21/0x110 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001838]
          &nbsp;smum_send_msg_to_smc_with_parameter+0xcd/0x100 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001829] &nbsp;? kvfree+0x1e/0x30</div>
        <div class="">[ &nbsp;+0.001462]
          &nbsp;vega20_set_power_profile_mode+0x58/0x330 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001868] &nbsp;? kvfree+0x1e/0x30</div>
        <div class="">[ &nbsp;+0.001462] &nbsp;? ttm_bo_release+0x261/0x370 [ttm]</div>
        <div class="">[ &nbsp;+0.001467]
          &nbsp;pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001863]
          &nbsp;amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001866]
          &nbsp;amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001784] &nbsp;kfd_dec_compute_active+0x2c/0x50
          [amdgpu]</div>
        <div class="">[ &nbsp;+0.001744]
          &nbsp;process_termination_cpsch+0x2f9/0x3a0 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001728]
          &nbsp;kfd_process_dequeue_from_all_devices+0x49/0x70 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001730]
          &nbsp;kfd_process_notifier_release+0x91/0xe0 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001718] &nbsp;__mmu_notifier_release+0x77/0x1f0</div>
        <div class="">[ &nbsp;+0.001411] &nbsp;exit_mmap+0x1b5/0x200</div>
        <div class="">[ &nbsp;+0.001396] &nbsp;? __switch_to+0x12d/0x3e0</div>
        <div class="">[ &nbsp;+0.001388] &nbsp;? __switch_to_asm+0x36/0x70</div>
        <div class="">[ &nbsp;+0.001372] &nbsp;? preempt_count_add+0x74/0xc0</div>
        <div class="">[ &nbsp;+0.001364] &nbsp;mmput+0x57/0x110</div>
        <div class="">[ &nbsp;+0.001349] &nbsp;do_exit+0x33d/0xc20</div>
        <div class="">[ &nbsp;+0.001337] &nbsp;? _raw_spin_unlock+0x1a/0x30</div>
        <div class="">[ &nbsp;+0.001346] &nbsp;do_group_exit+0x43/0xa0</div>
        <div class="">[ &nbsp;+0.001341] &nbsp;get_signal+0x131/0x920</div>
        <div class="">[ &nbsp;+0.001295]
          &nbsp;arch_do_signal_or_restart+0xb1/0x870</div>
        <div class="">[ &nbsp;+0.001303] &nbsp;? do_futex+0x125/0x190</div>
        <div class="">[ &nbsp;+0.001285]
          &nbsp;exit_to_user_mode_prepare+0xb1/0x1c0</div>
        <div class="">[ &nbsp;+0.001282] &nbsp;syscall_exit_to_user_mode+0x2a/0x40</div>
        <div class="">[ &nbsp;+0.001264] &nbsp;do_syscall_64+0x46/0xb0</div>
        <div class="">[ &nbsp;+0.001236]
          &nbsp;entry_SYSCALL_64_after_hwframe+0x44/0xae</div>
        <div class="">[ &nbsp;+0.001219] RIP: 0033:0x7f6aff1d2ad3</div>
        <div class="">[ &nbsp;+0.001177] Code: Unable to access opcode bytes
          at RIP 0x7f6aff1d2aa9.</div>
        <div class="">[ &nbsp;+0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS:
          00000246 ORIG_RAX: 00000000000000ca</div>
        <div class="">[ &nbsp;+0.001170] RAX: fffffffffffffe00 RBX:
          0000000004f542b0 RCX: 00007f6aff1d2ad3</div>
        <div class="">[ &nbsp;+0.001168] RDX: 0000000000000000 RSI:
          0000000000000080 RDI: 0000000004f542d8</div>
        <div class="">[ &nbsp;+0.001162] RBP: 0000000004f542d4 R08:
          0000000000000000 R09: 0000000000000000</div>
        <div class="">[ &nbsp;+0.001152] R10: 0000000000000000 R11:
          0000000000000246 R12: 0000000004f542d8</div>
        <div class="">[ &nbsp;+0.001176] R13: 0000000000000000 R14:
          0000000004f54288 R15: 0000000000000000</div>
        <div class="">[ &nbsp;+0.001152] &nbsp;&lt;/TASK&gt;</div>
        <div class="">[ &nbsp;+0.001113] Modules linked in: veth amdgpu(E)
          nf_conntrack_netlink nfnetlink xfrm_user xt_addrtype
          br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE
          iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6
          nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp
          llc ebtable_filter ebtables ip6table_filter ip6_tables
          iptable_filter overlay esp6_offload esp6 esp4_offload esp4
          xfrm_algo intel_rapl_msr intel_rapl_common sb_edac
          x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi
          snd_hda_intel ipmi_ssif snd_intel_dspcfg coretemp
          snd_hda_codec kvm_intel snd_hda_core snd_hwdep snd_pcm
          snd_timer snd kvm soundcore irqbypass ftdi_sio usbserial
          input_leds iTCO_wdt iTCO_vendor_support joydev mei_me rapl
          lpc_ich intel_cstate mei ipmi_si ipmi_devintf ipmi_msghandler
          mac_hid acpi_power_meter sch_fq_codel ib_iser rdma_cm iw_cm
          ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
          scsi_transport_iscsi ip_tables x_tables autofs4 btrfs
          blake2b_generic zstd_compress raid10 raid456</div>
        <div class="">[ &nbsp;+0.000102] &nbsp;async_raid6_recov async_memcpy
          async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0
          multipath linear iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm
          drm_shmem_helper drm_kms_helper syscopyarea sysfillrect
          sysimgblt fb_sys_fops crct10dif_pclmul hid_generic
          crc32_pclmul ghash_clmulni_intel usbhid uas aesni_intel
          crypto_simd igb ahci hid drm usb_storage cryptd libahci dca
          megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]</div>
        <div class="">[ &nbsp;+0.016626] CR2: 0000000000058a68</div>
        <div class="">[ &nbsp;+0.001550] ---[ end trace ff90849fe0a8b3b4 ]---</div>
        <div class="">[ &nbsp;+0.024953] RIP:
          0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]</div>
        <div class="">[ &nbsp;+0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0
          7f 3f 75 ae 0f 1f 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01
          00 10 75 0d 4c 03 a3 a0 09 00 00 &lt;45&gt; 8b 24 24 eb 8a 4c
          8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 2e ca 85</div>
        <div class="">[ &nbsp;+0.003255] RSP: 0018:ffffb58fac313928 EFLAGS:
          00010202</div>
        <div class="">[ &nbsp;+0.001641] RAX: ffffffffc09a4270 RBX:
          ffff8b0c9c840000 RCX: 00000000ffffffff</div>
        <div class="">[ &nbsp;+0.001656] RDX: 0000000000000000 RSI:
          000000000001629a RDI: ffff8b0c9c840000</div>
        <div class="">[ &nbsp;+0.001681] RBP: ffffb58fac313948 R08:
          0000000000000021 R09: 0000000000000001</div>
        <div class="">[ &nbsp;+0.001662] R10: ffffb58fac313b30 R11:
          ffffffff8c065b00 R12: 0000000000058a68</div>
        <div class="">[ &nbsp;+0.001650] R13: 000000000001629a R14:
          0000000000000000 R15: 000000000001629a</div>
        <div class="">[ &nbsp;+0.001648] FS: &nbsp;0000000000000000(0000)
          GS:ffff8b4b7fa80000(0000) knlGS:0000000000000000</div>
        <div class="">[ &nbsp;+0.001668] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
          0000000080050033</div>
        <div class="">[ &nbsp;+0.001673] CR2: 0000000000058a68 CR3:
          000000010a2c8001 CR4: 00000000001706e0</div>
        <div class="">[ &nbsp;+0.001740] Fixing recursive fault but reboot is
          needed!</div>
        <div class=""><br class="">
        </div>
        <div class=""><br class="">
        </div>
        <div>
          <blockquote type="cite" class="">
            <div class="">On Apr 21, 2022, at 2:41 AM, Andrey Grodzovsky
              &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
              wrote:</div>
            <br class="Apple-interchange-newline">
            <div class="">
              <div class="">
                <p class="">I retested hot plug tests at the commit I
                  mentioned bellow - looks ok, my ASIC is Navi 10, I
                  also tested using Vega 10 and older Polaris ASICs
                  (whatever i had at home at the time). It's possible
                  there are extra issues in ASICs like ur which I didn't
                  cover during tests. <br class="">
                </p>
                <p class="">andrey@andrey-test:~/drm$ sudo
                  ./build/tests/amdgpu/amdgpu_test -s 13<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  <br class="">
                  <br class="">
                  The ASIC NOT support UVD, suite disabled<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  <br class="">
                  <br class="">
                  The ASIC NOT support VCE, suite disabled<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  <br class="">
                  <br class="">
                  The ASIC NOT support UVD ENC, suite disabled.<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  <br class="">
                  <br class="">
                  Don't support TMZ (trust memory zone), security suite
                  disabled<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  /usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory<br class="">
                  Peer device is not opened or has ASIC not supported by
                  the suite, skip all Peer to Peer tests.<br class="">
                  <br class="">
                  <br class="">
                  &nbsp;&nbsp;&nbsp;&nbsp; CUnit - A unit testing framework for C - Version
                  2.1-3<br class="">
                  &nbsp;&nbsp;&nbsp;&nbsp; <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C5a4c0dad2eca4483f42808da282f3370%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637866480459680617%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mRW%2F7DvAdcJ5JRvxst5MRJ%2BV68b4lPfuPxSzGWbgXlc%3D&amp;reserved=0" originalsrc="http://cunit.sourceforge.net/" shash="afv2gau6xD3ns2Bab8U6BEq3m8vGWv9KLfdx/jV8/e1FbeRiKfd5Mqxr2LbnxEunCt0uDDZVQPARqfgf7OauV8LZ3yjav6eSxUyOvVl7eevtDKdcZXVhUs3sMo2Lg3rOoLbdLgy6BHZohRsGZgbOLsQhlqvI22F18jwx8aLubVY=" moz-do-not-send="true">
                    http://cunit.sourceforge.net/</a><br class="">
                  <br class="">
                  <br class="">
                  <b class="">Suite: Hotunplug Tests</b><b class=""><br class="">
                  </b><b class="">&nbsp; Test: Unplug card and rescan the bus
                    to plug it back
                    .../usr/local/share/libdrm/amdgpu.ids: No such file
                    or directory</b><b class=""><br class="">
                  </b><b class="">passed</b><b class=""><br class="">
                  </b><b class="">&nbsp; Test: Same as first test but with
                    command submission
                    .../usr/local/share/libdrm/amdgpu.ids: No such file
                    or directory</b><b class=""><br class="">
                  </b><b class="">passed</b><b class=""><br class="">
                  </b><b class="">&nbsp; Test: Unplug with exported bo
                    .../usr/local/share/libdrm/amdgpu.ids: No such file
                    or directory</b><b class=""><br class="">
                  </b><b class="">passed</b><br class="">
                  <br class="">
                  Run Summary:&nbsp;&nbsp;&nbsp; Type&nbsp; Total&nbsp;&nbsp;&nbsp; Ran Passed Failed
                  Inactive<br class="">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suites&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; n/a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br class="">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tests&nbsp;&nbsp;&nbsp;&nbsp; 71&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br class="">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asserts&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  n/a<br class="">
                  <br class="">
                  Elapsed time =&nbsp;&nbsp;&nbsp; 9.195 seconds<br class="">
                </p>
                <p class=""><br class="">
                </p>
                <p class="">Andrey<br class="">
                </p>
                <div class="moz-cite-prefix">On 2022-04-20 11:44, Andrey
                  Grodzovsky wrote:<br class="">
                </div>
                <blockquote type="cite" cite="mid:34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com" class="">
                  <p class="">The only one in Radeon 7 I see is the same
                    sysfs crash we already fixed so you can use the same
                    fix. The MI 200 issue i haven't seen yet but I also
                    haven't tested MI200 so never saw it before. Need to
                    test when i get the time.
                    <br class="">
                  </p>
                  <p class="">So try that fix with Radeon 7 again to see
                    if you pass the tests (the warnings should all be
                    minor issues).</p>
                  <p class="">Andrey</p>
                  <p class=""><br class="">
                  </p>
                  <div class="moz-cite-prefix">On 2022-04-20 05:24,
                    Shuotao Xu wrote:<br class="">
                  </div>
                  <blockquote type="cite" cite="mid:549246A3-B326-47CC-92FD-608708E1876B@microsoft.com" class="">
                    <div class="">
                      <blockquote type="cite" class="">
                        <div class="">
                          <div class="">
                            <p class="">That a problem, latest working
                              baseline I tested and confirmed passing
                              hotplug tests is this branch and commit
                              <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C5a4c0dad2eca4483f42808da282f3370%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637866480459680617%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=46BBfjOQueTxTXx921QRShZS7cznCZXGxE%2FEG8M6F70%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6" shash="KVG3wy3Hyu0De7/Ws65ytbANo6V8qXAyheJ0nRigcIEhn7TShfYQr1DXaXemV1gnomzUJwongr/UeEhKwr5M2Wq8xsDsPRAPiyI2UCVRZYw8fyTnrLG1IuZ+2r8Bx4tsNbHDz9l+CWo36VFbUUfTQu7cxRrIGwqhlnwkRTOeK7Q=" moz-do-not-send="true">
https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6</a>
                              which is amd-staging-drm-next. 5.14 was
                              the branch we ups-reamed the hotplug code
                              but it had a lot of regressions over time
                              due to new changes (that why I added the
                              hotplug test to try and catch them early).
                              It would be best to run this branch on
                              mi-100 so we have a clean baseline and
                              only after confirming&nbsp; this particular
                              branch from this commits passes libdrm
                              tests only then start adding the KFD
                              specific addons. Another option if you
                              can't work with MI-100 and this branch is
                              to try a different ASIC that does work
                              with this branch (if possible).</p>
                            <p class="">Andrey<br class="">
                            </p>
                          </div>
                        </div>
                      </blockquote>
                      OK I tried both this commit and the HEAD of
                      and-staging-drm-next on two GPUs( MI100 and Radeon
                      VII) both did not pass hotplugout libdrm test. I
                      might be able to gain access to MI200, but I
                      suspect it would work.&nbsp;</div>
                    <div class=""><br class="">
                    </div>
                    <div class="">I copied the complete dmesgs as
                      follows. I highlighted the OOPSES for you.</div>
                    <div class=""><br class="">
                    </div>
                    <div class=""><span style="background-color:
                        rgb(255, 38, 0);" class="">Radeon VII:</span></div>
                  </blockquote>
                </blockquote>
              </div>
            </div>
          </blockquote>
        </div>
        <br class="">
      </div>
    </blockquote>
  </body>
</html>

--------------j90eeYIplYIxbo7kFgo026lH--
