Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9760C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 01:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465FF10E720;
	Tue, 25 Jan 2022 01:48:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2892C10E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 01:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA3Z1S7I943JISqT9hSQSjckFQ1z1Opcpygq9BfHH2x7YKtApeOd59wfXutadLGPFSF2rToS9gO2CUfzlKmODHpe1P68OB/hl0pm9EyxQs2jf6Im0/L1JucrliyklkesirrU05TzK/McFEulT/V/ggH+nFd6dqycrBxQ+VL/X6MuvzLdpi1cHru1repxwLBYj+T6ZociTEgx0z4kiBveyltLewpPkpuCmKjXpe+2Jnp8p+J6jSsLC0E8teW04/2QtKWMAPNGMs2IByIlns2BB5Hz35zWGwgZYkwJN/gyaqye46G9VrSyjzJ99+eEfp6gSr757bitJdC5MAn0YMkIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkeEa7nQuQxL2QPi4UTas8OBl0LGpWhbtVUE7zPPM+A=;
 b=Ub2XuZBZYxRzok4vtjIAqr/eJCKI5Cmb5dMdm1Pc3eSTRdzPbf6Z1bWMt4QP2knHDmOj+z948rcdc+oHjIbF8qesJDCBFdt7/gjC0zI62Aigh2lLX/uqPqAMDbU53QDSMzk2cv9RkX1qU4XgA0pGE2GQidV7sMkgllWMQCKHyqkwh/fB/qO05qd5fbkMnIwSXDb0OVMVvm7haowY4PvyYXJnM7aA101IAcGK6Z6pt2UeZtJGPB4bCVG79O+nEX8Md8EQUOcpUTEtLNSUFxpaUg/Na4GLh4s7A/kxNaG5lBIN9RwGGzq0tvwJYKFjevTcTjrnY36a2MK/1eT1iF6j3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkeEa7nQuQxL2QPi4UTas8OBl0LGpWhbtVUE7zPPM+A=;
 b=Ax4gqkmJXiOo+qG8Ag30DiWuR3Wb7IZeKDj9XZ46tK/hcKADhsjBHyu4YevXaRjRWhByQtNacV2GBaR5NF8swncRV2KecG9kQufEceDyNImPRHqClJj8fQKfhMGzHLOGA0qNxng/Ml3gPzavRElrgMMysBfxTgKoi8bpObnz8Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 01:48:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 01:48:27 +0000
Message-ID: <7b8013aa-55a8-aad7-6ca4-1e162c289f00@amd.com>
Date: Mon, 24 Jan 2022 20:48:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>
References: <20220119031610.832211-1-KevinYang.Wang@amd.com>
 <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <95be3a20-ac92-9acd-9600-3caf9223c67a@amd.com>
 <CO6PR12MB54735F709AACC151C3B66900825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <0a753643-dffe-8560-8923-4e4cfcbfd7e1@amd.com>
 <CO6PR12MB5473612CFBEC14CB9D6315E0825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CO6PR12MB5473612CFBEC14CB9D6315E0825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5fe5c06-57ae-4757-0dcf-08d9dfa4c812
X-MS-TrafficTypeDiagnostic: SN1PR12MB2589:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2589CFFCFB622113C1668B8E925F9@SN1PR12MB2589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPKUeUdw6rwj+GwV/4RAWVwU9PdSTwC6RNJlm2yPZfxnM2weZmLLLzG48QYT7BLIRQGN+zd7JtFnCSBOJu1SxodjXCApUqdkrXSvbXSaNHzggnbPQG1hk6Ayd3IjMo2d6wI5fetoZ+H01/ByjF4Ya3tQFdK9tj7mF1eZQr9hq0YINp9MCfQCKW7+MeLWGnzEFG6kKGdSY7m6LIXX/HXzHh28939dI753X0NGFVyiL06yGscD0OF4iDI+IyDcd8N2hapIKhdawC0jDZ5rEpQlzyfN+vr/qfLXdKoDtocT+yxvYECQi0JGTUbAlWfyz2ROkYNkq/BkFkaZYONKsDLLQkJkhF86/RYg5BcR6M9BZo4bzdSZt4SxuCzb2Kb9Ksfi3yIInZT+sPJzcr+k+b54f7wbSPglm/OnASX4NAOWZs0nuKaYAn4HOWjJ83ZS9P8kgjZiuX8MvlhvshcNV5rJbQ+1HrOuMcQ6hfUUTm8kslH/oTvTWzpVIzTQUfYgmsDv+iDN4ov6R31v3HkLWYsMd/Kzx+mSiSOBfe1+wZFAK3UVlMG8x5DujdCagNIyvE4JrG+EYz+NienH8XipNKhNMoeb9jNtrOD1E7jU94rC1SDyBg2tqfPDLrdY/SfRw8V9+tXDT9hSHnqSx5tj56xKxjzCz9K4We9cS7GeP1TZslHh7EtlmZB4ezb3oensscAajGP4G5tv3/aHUJGGi1XIxwKUbXgqjeTLERFwZCU/4RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(31696002)(36756003)(5660300002)(26005)(66946007)(2616005)(8676002)(186003)(8936002)(31686004)(6486002)(86362001)(54906003)(38100700002)(66556008)(110136005)(316002)(66476007)(83380400001)(508600001)(6512007)(15650500001)(2906002)(6506007)(6636002)(4326008)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZStnUzdjT0N1NW9MbnF6OHFySnFINTJOQlBYaHdkV1NvQWpFbzNSR2E1TllO?=
 =?utf-8?B?MHU2bnFmajZka25LbnBFUEIvK3c3MVZBMHpWOUpGNWZkTWhpMkxHQjl6VC9i?=
 =?utf-8?B?ZklEeURCWFBTT2tIRnpVZit0YVYvUmNjZjZBOStjNTBmS21UN0ZQQXBjYTJr?=
 =?utf-8?B?eVFkQldMTGUzN0tyZ0ZrOUlWb1Jua3ZiUEM1eVFvVXRQL3ArbHNjdzhXNzFp?=
 =?utf-8?B?dFVFeUZkT001UStmaEpENFFmL2Z5b1FVUWwwZW00OVNidWJVdUcxOTUrSkpG?=
 =?utf-8?B?dGIyeXByMHB0d21rcWlUd25PaVpOYjRFTUpKTlRNbDhSangrVFFyNXdvbEZu?=
 =?utf-8?B?NXdjY2MyWUVGYnAxdUVsT1RTazNudUNTNTR5aGs3Ni8vRkZkblFDaUI5OHVu?=
 =?utf-8?B?SzdRQloxcVpVNHNYOFZGMHpEUWpOanlPZG5qanEwMnNETGNnTkhqNFdNa2Jh?=
 =?utf-8?B?WUxIUmk0OTdubnpBR0NGUE9IWjNCeCswZGNyWkNPSUFkUmk5dTAySGdVeFpZ?=
 =?utf-8?B?NVhGbWpOTjBnWCs5eUNNS3N3YjJnNmNBcENWZll2dWtuNllTRmN4RFExajQ5?=
 =?utf-8?B?cnY3MGdqZzFxSGgyYSs3dnluRkk1TG9FSmRCVkFXa2FVQnVKNTR0RFBxRkNz?=
 =?utf-8?B?Z3lwYmFiODV3TUdpTWVyWWdqNzYzNkVkNGtnMnBOd0FhNk1ldUNzRHpJV0xy?=
 =?utf-8?B?KzFZVkN0V2VpZFJLYkRpMEViOWpYbG5tRzlKcGJQamk3QityV09MYU5oQnRC?=
 =?utf-8?B?QlFsZTFpZTVuOVFZaFJNQ0V5cmRranpER2Vpelp5T2xkTHVuRmVESkt6L2ZH?=
 =?utf-8?B?ZmoyZER2NVgwUWFIUHY1d3IvWWlrOW9UOTdOTHpDVnlrQlNibjVhMW80WlBI?=
 =?utf-8?B?cVdRNWs2cnRITnAzQlFkZVBzNnBXSllTemdyeFZXd003TmhMK2tOSjUwUFF3?=
 =?utf-8?B?R0JkNktrWVpQb0ZZNHBmL1J4UE1MWS9aSzBnaUovN01UKytISUdMdTg2Q1kw?=
 =?utf-8?B?Y3JzdmF3WkVONm1qYUdvWlJmVGsxSkhHUUpqb2VPdndjK2c0T09YVzYrN1lp?=
 =?utf-8?B?VlA1UkNxZUZNaFhjbU4vUFR5dUkzNjVQby8zRmRBUlVxb1B5c1FDaXgvN3Az?=
 =?utf-8?B?TEtPWFdvYUh2WFpua1hPa2ZDdGx1WkR6d0pRYXFEc1RwZzlhcitnTVZJcGJW?=
 =?utf-8?B?ZnNTWkg5NEdsRFhxZmJiaHJyS1Ryd29jRDUyMWxzb2czNDRac2FDY2dkRkQz?=
 =?utf-8?B?M3dJYkNXMzYzYTJtN3o1UW9NaVFSTHoveC93Uk1lb3FBSjVlbndLeWNjV1Jm?=
 =?utf-8?B?eVBZRlk2Vi9qVXpzS1Jnd0ZOaWtBMm5HUWRldld4MHZFRTBJTjZ6NjJKWnN6?=
 =?utf-8?B?am1vcUwyd3A3ZUlZcVJ1ZGZGRHlGK3ZGUHYvcUxETldiM2l2RVRFYkVBblVH?=
 =?utf-8?B?cEFPRGdaU09XUHNEOGF3WngzSXlXUUZETzNaZGsyUXFKNlBYbjFGRExvYjYz?=
 =?utf-8?B?ODNDWWIveGlBMExFMDNjcXpVVUswMzJOeXFLeHFRZU1xeTJVek1YMitCbU92?=
 =?utf-8?B?NmhrMW1BaXY3SUswWlhSSE5aOUpUWmRDYy90Yk4vM0FhNTlnaGJlTC9lNEIy?=
 =?utf-8?B?Y200VGVoNzF3V24rSE9oNUtKQjlDelF4Y2Y0OVpsNmtqTVRiV0VMYVdYMlRJ?=
 =?utf-8?B?ckJSNmRpTE0xY1ltYXc5Umo1aXFueTJheDVxUW5GYXA3QkQrVkhZSUxhTXlG?=
 =?utf-8?B?SUxTOERkSStpbnBaenRXMjQ2b2Z6bkU3d0RsWGVvTE1Rc1pvWkU2NWpMVHB4?=
 =?utf-8?B?azN6ZXlQQTh6VklLdTNQWU1jaVo0ZXlCOFlNUWtwb1ViZEMxZ2dWcTlmaGkx?=
 =?utf-8?B?emJHUU5DRDV2NDJLZFBkaEJpemk3NVJscEtjS0xqaTloQkVQUzdTYXBNMzRl?=
 =?utf-8?B?ZXF6a0IzLzRDbW41dGV4bm9TUEpVNERyeXczMVdIcGZxZU5IczRyWHQ0Qllw?=
 =?utf-8?B?WnF2K2lFUVBPRmVnSWFMbGlkbmRLOFRiM1ZTREViTEpPc1EyWVNZVGI0aCtR?=
 =?utf-8?B?VkM5am04M0d4WnhDSWRzQkQ4MjRaY3NmcHB4TFJLbUlHN2RIeGRUQks4Qnpo?=
 =?utf-8?B?OWdNS3MweHJXTXNiNFEyMGNWaXk2eTdJbEdOQ3FuQ2JROEVYMDVEUmQ4T0c2?=
 =?utf-8?Q?rBKNLhGKia5tm8qdk/5o8ys=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fe5c06-57ae-4757-0dcf-08d9dfa4c812
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 01:48:27.5611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q80x/KD4YWhr0+BsbrPhWDXfa2FT2QjIlNPCVwrZPcqnMhtCY7ewv+l2SoPDDPmIynjpWGVoH9dBRduVOEYFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I made a related fix for HDP flushing under SRIOV a while ago, and that 
was confirmed to be working at the time. What changed since then? Is 
this on different HW or with a different BIOS? Or are you missing this 
patch? For reference:

commit 6295c4064d8d18c4480636076dbd5afb48885c02
Author: Felix Kuehling <Felix.Kuehling@amd.com>
Date:   Thu Nov 4 16:15:43 2021 -0400

     drm/amdgpu: Fix MMIO HDP flush on SRIOV
     
     Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
     to the fixed address of the VF register for hdp_v*_flush_hdp.
     
     Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
     Tested-by: Bokun Zhang <bokun.zhang@amd.com>
     Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


Regards,
   Felix



Am 2022-01-20 um 04:39 schrieb Wang, Yang(Kevin):
>
> [AMD Official Use Only]
>
>
> [AMD Official Use Only]
>
>
> Thanks @Koenig, Christian <mailto:Christian.Koenig@amd.com>.
>
> Best Regards,
> Kevin
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, January 20, 2022 5:11 PM
> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk 
> <Monk.Liu@amd.com>
> *Cc:* Min, Frank <Frank.Min@amd.com>; Chen, Horace <Horace.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: force using sdma to update vm page 
> table when mmio is blocked
> Hi Kevin,
>
> well at least the HDP flush function has to work correctly or 
> otherwise the driver won't work correctly.
>
> If the registers are not accessible any more we need to find a proper 
> workaround for this.
>
> One possibility would be to use the KIQ, another is a dummy write/read 
> to make sure the HDP is flushed (check the hardware docs).
>
> The third option would be to question if blocking the HDP registers is 
> really a good idea.
>
> The solution is up to you, but a workaround like proposed below 
> doesn't really help in any way.
>
> Regards,
> Christian.
>
> Am 20.01.22 um 10:07 schrieb Wang, Yang(Kevin):
>>
>> [AMD Official Use Only]
>>
>>
>> Hi Chris,
>>
>> yes, I agree with your point.
>> and another way is that we can use KIQ to write HDP register to 
>> resolve HDP can't R/W issue.
>> but it will cause some performance drop if use KIQ to programing 
>> register.
>>
>> what is your ideas?
>>
>> Best Regards,
>> Kevin
>> ------------------------------------------------------------------------
>> *From:* Koenig, Christian <Christian.Koenig@amd.com> 
>> <mailto:Christian.Koenig@amd.com>
>> *Sent:* Thursday, January 20, 2022 4:58 PM
>> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com> 
>> <mailto:KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> 
>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>; Liu, 
>> Monk <Monk.Liu@amd.com> <mailto:Monk.Liu@amd.com>
>> *Cc:* Min, Frank <Frank.Min@amd.com> <mailto:Frank.Min@amd.com>; 
>> Chen, Horace <Horace.Chen@amd.com> <mailto:Horace.Chen@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: force using sdma to update vm page 
>> table when mmio is blocked
>> Well NAK.
>>
>> Even when we can't R/W HDP registers we need a way to invalidate the 
>> HDP or quite a bunch of functions won't work correctly.
>>
>> Blocking CPU base page table updates only works around the symptoms, 
>> but doesn't really solve anything.
>>
>> Regards,
>> Christian.
>>
>> Am 20.01.22 um 09:46 schrieb Wang, Yang(Kevin):
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>> ping...
>>>
>>> add @Liu, Monk <mailto:Monk.Liu@amd.com> @Koenig, Christian 
>>> <mailto:Christian.Koenig@amd.com> @Deucher, Alexander 
>>> <mailto:Alexander.Deucher@amd.com>
>>>
>>> Best Regards,
>>> Kevin
>>> ------------------------------------------------------------------------
>>> *From:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com> 
>>> <mailto:KevinYang.Wang@amd.com>
>>> *Sent:* Wednesday, January 19, 2022 11:16 AM
>>> *To:* amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>>> *Cc:* Min, Frank <Frank.Min@amd.com> <mailto:Frank.Min@amd.com>; 
>>> Chen, Horace <Horace.Chen@amd.com> <mailto:Horace.Chen@amd.com>; 
>>> Wang, Yang(Kevin) <KevinYang.Wang@amd.com> 
>>> <mailto:KevinYang.Wang@amd.com>
>>> *Subject:* [PATCH] drm/amdgpu: force using sdma to update vm page 
>>> table when mmio is blocked
>>> when mmio protection feature is enabled in hypervisor,
>>> it will cause guest OS can't R/W HDP regiters,
>>> and using cpu to update page table is not working well.
>>>
>>> force using sdma to update page table when mmio is blocked.
>>>
>>> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com> 
>>> <mailto:KevinYang.Wang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index b23cb463b106..0f86f0b2e183 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm)
>>>          vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>>> AMDGPU_VM_USE_CPU_FOR_GFX);
>>>
>>> +       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && 
>>> amdgpu_virt_mmio_blocked(adev))
>>> +               vm->use_cpu_for_update = false;
>>> +
>>>          DRM_DEBUG_DRIVER("VM update mode is %s\n",
>>> vm->use_cpu_for_update ? "CPU" : "SDMA");
>>> WARN_ONCE((vm->use_cpu_for_update &&
>>> @@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>>          /* Update VM state */
>>>          vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>>> AMDGPU_VM_USE_CPU_FOR_COMPUTE);
>>> +
>>> +       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && 
>>> amdgpu_virt_mmio_blocked(adev))
>>> +               vm->use_cpu_for_update = false;
>>> +
>>>          DRM_DEBUG_DRIVER("VM update mode is %s\n",
>>> vm->use_cpu_for_update ? "CPU" : "SDMA");
>>> WARN_ONCE((vm->use_cpu_for_update &&
>>> -- 
>>> 2.25.1
>>>
>>
>
