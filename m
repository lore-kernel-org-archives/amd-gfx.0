Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9BCC47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 04:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5BB112384;
	Mon, 29 Jan 2024 04:51:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9730D112384
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 04:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebt+puSUGT2Dn9LdWicLczSkQ5Ten4W/Asc4FWjI9O7iVpQl//KzbtDLrj7LSt7/pLKpCxUWzp2Z4RpE3VWlBVqB7m1HUI5pzV530z2b+oVbx6Mnpqi7CG8PY2njmfVVkGCkrhS83dJjRMUiDNrimJy3LVj/qv5sK6c2z8K0whVif44TNbl6mlQhtRz29BHeXQsrjcm5kXwyEPAfHvIQpOZMekdARDZO82M5ldYJ+ItqI+f0nE/ipUjvs+NIiQpswqGP1LKKqguwxvD6SQjuuuDSLxaItEm/PIy/Df3SVTDcm+wMDq1PkG99QFD/cIjyKIGQyNISM645PlYxX39DEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NlQAETQzc+XJg4iY+4w9Imigb8Z4RHqMYP8DnIedCg=;
 b=Ee5uqESBhtGySfsLvFTFgUG72+7mOlFo/o/zBs9C4fos946J9neWwWvLNIjgJNn9Wm7QKmnn6z5UVzKN/a2WlR3nQ0QuqgBZvyVISCeYLeQhtcVSb+PxnhiFppE7teJXshl1+Io2jPok8adJtZXEZhK5sqVEaggM7h50zsiw65GclioIAeaqANVdDTqUiDyGqKK/JYVOAdnqbExlIk4IZGwILyVeEOyaEpisItKSRHQYr0RSQDtgtCE27dE1FK/s7V3hJqn9KjU2Nf2+kVjOtsJApoajinCj/qAAKORpp9nhTFKi+jh+ZYmpDrOFVeJVNYlL+XG5IHmCDcOU6MO/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NlQAETQzc+XJg4iY+4w9Imigb8Z4RHqMYP8DnIedCg=;
 b=T4rsmHPdpjswtcwVlGReV8GO7kpN+A9XsMDMSrMQVlyCg5+xHWyr+RTppr11zunBZ2Z85Ral7yQLTYML2NUTRsfBwG1pcSpumTw/V9mzp84qIRUrYeiJ/3EdzrlqJGQ0xGhwY3O2CwaC2jA892MtquPODvvX5Neb6PaoYTcLAzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 04:50:52 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e5fc:a681:fb1f:de6e]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e5fc:a681:fb1f:de6e%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 04:50:52 +0000
Message-ID: <06db8582-ae7f-46ca-ab39-3c116959351e@amd.com>
Date: Sun, 28 Jan 2024 23:50:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Two patches to improve gang submit with reserved VMIDs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
References: <20240126155440.2022-1-christian.koenig@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20240126155440.2022-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::11) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: e3646868-a547-464e-ae34-08dc2085dec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTZObRdti90SGT2quT8ZFHwaRhG4IVZ3qneLuUdS5Q/d78NjanaZv6Ye2VymIynJeGuRVcebqiIWkbFD0f3EJ9qhBxT2e+TQ+/NczEOggw78NWSndIVbOrstBe0w/bvIWSpDgkBQCkPEHfDGIa75tw1CZOZ316yBRJaPSc0u0dzzAAWU2HuRkXLQzQDOPcfbrX2useSjdrg1VEQcDBKpwej1NpgmHddyR3KfWP75OYsYaNdk/JoQlpZvazSxoq2Cu1RF70I7hQz3EGy1feINPvCCTPOdx9+RTyzzV+zfcYmYI7HkjtwmMZddWng8dZhCp153do5pdsuZqN+JUTFZ7lBaBb84PDxWhROGEMOILcQ1vxr0fL5HSJzBqUv7PmvM9Wt90zCrMjH5XP6lYHC/pG2QCc4U+bU2H0k/5FBfV9CHqeanijWJUilr0V165UR14QgfMFfVhWugJ5plfsPervhxxQtshJDunWf4FSjrCCEqbabGoiK+G6gu/6r+WVJMC+IaWEtM89MVEyMF65v8GRgNrqmSyOm8IIp89i753CrBjZwuVnIefC/oLwEIUXjA5kuPdi14NW96k4z6sGvqoKhoIHoqZQkyXFFy/KtFd13Z3oXIRDkBAyTjr8FmmpALU5ui28qjgP6l1l7XjLyoHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(83380400001)(26005)(2616005)(6512007)(6506007)(53546011)(6666004)(478600001)(6486002)(316002)(31696002)(66476007)(66556008)(66946007)(8936002)(8676002)(5660300002)(4744005)(2906002)(36756003)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3o5QnJnelptT245RlF0LytFcjl4NEI2cEJkTkJvQkluNXl0WWkvbVpURW1R?=
 =?utf-8?B?NmpVNDB5b284UnEzNnhDTkFLcWh6R3gyamNkTHJycnlPYXQ5QnpUMElTVk5E?=
 =?utf-8?B?aU9NNURQVFNST1QrTnVQd0d4QmkzRXA4Tm5yaW8xQzhaYkNUMWdvb1pEemVN?=
 =?utf-8?B?SUlCd0x6SER3YnNIUmxIVkRFd1QxbCs2OFVuR3NNMUxIRk5mcm5zL2FDdFZn?=
 =?utf-8?B?c252OXhiVjJZTzRPMjVDbFFSRitNSTFHbklVVHRDSkMwZk1jM0o4MGlwQkxM?=
 =?utf-8?B?MTlid0dINUhNYU51TkhiWU8xOXNEMExxNGxRNHNNTUtmVEhSZ2psRTJZZmhH?=
 =?utf-8?B?WVlvNXhPUXZKOFBiS1pydVJ2VjMzVi9Pb2xOZ1RzbEVidjhwUmFsdzd2RDNr?=
 =?utf-8?B?NU1xQUhJd3p5T1FUQk12aHprazhnMWM1YVJYWEQwM2gvK0dRVWhrWitvT3Ni?=
 =?utf-8?B?RDdmVTJXZDUvaXg3ci9keUlpaFNLSjFRTkptbEhqZ2dzbkVGZkYvQWJZTE0w?=
 =?utf-8?B?Ynpoc0J2NUtqNzVDWFdmcVU2UHIzUXB6c2dxWW5NUGxvdjR4c0orS29FeVRv?=
 =?utf-8?B?L04rNkhZQkZtdFN1Y292UE9xMG0xSk1Rc1VpTjBLMkd5dEZmRG9oUUh5eDM0?=
 =?utf-8?B?Znh5bGk3d0JnczNqSnhXRUpkUldSc0E0SytYd0NsTzJTd2ZTbkVURDBkNjh3?=
 =?utf-8?B?Qlg3OEJ2TDBKNWo3aTJvTWEwWDZOM1EvSmlSOEZFNjFFUFlYRGthclkxelFF?=
 =?utf-8?B?Y0ZJR21iMDlwQXpWK1k1QnBKWjVzRUJYZ0lFR3hRakR6ZTl0NnJLTXJKMk42?=
 =?utf-8?B?M25haGRxSFNFRzIwVjZ6MFZQeW5QelVrSDdiSjdEWS9qUzZkVU1lSXNqc0Ns?=
 =?utf-8?B?akVOVVNuTllOTFR1QTZPQ1p4Zy9lMGZMcEV1WDZHWU5sb1dENFJWR0FWTWhJ?=
 =?utf-8?B?bk90aWxETjZVR283TjVCUnZBWUJ4QzdJMkN3TkdCMTA4UHpjSFZZN1F6ZXlh?=
 =?utf-8?B?Unh3NkEyMTByWEJRYTN3N3A4UmpISGY2L3pCYTdSV2oxTjVRdGdpNXlyaFh2?=
 =?utf-8?B?R0RSb3dHYkFLTU5SOUl1OUI3VjlQVXRHZGZLckdNRzBKUjV2cWJkcjlZRzRW?=
 =?utf-8?B?Qk03R3ZqMk9NQmR4RzhsVENzY3EvWTFTZnBqbHRhR0Q4NmxlL1NPNVFZMzd2?=
 =?utf-8?B?Q0JpVWxJcENDSnV3akpwM1g5OFpPY2xib2NCRFJ5Q0hwajd3SDVkQnJ3V3I4?=
 =?utf-8?B?N3VlN0FRaURjbHJBWUdFU1MwVjhWQUJFQmtvNWRka2MxNFFYZlJLNWxSbm9E?=
 =?utf-8?B?YmowZ1NZTVhaL2o3bFR0NjJ0L0RRd21qd3hwRmZLUEIrRVpoOG5iQXhiazJU?=
 =?utf-8?B?eis1dVR6MjZFTkhMZk1kVThNdGhQYVdRUFpTdnA3RGsyODh4bzZJbnlMNllo?=
 =?utf-8?B?VGVJUXhxZWszVlE5VjdlSGlIa0Jmd3ZjaUxPRDBIQVlGbmFMa3czdnhpTUtj?=
 =?utf-8?B?enhIUHFvV2xiSTB5RHh4RmRyclYzUlFHNTBYMjFwUHZhTml2M01Hc0JMQnNY?=
 =?utf-8?B?ZWF6SFBlZk5wa3RYZjR1RWg4WHMzR01LUFlyWDBIRDMwaFk3clJ1cDVISVRC?=
 =?utf-8?B?K3lvZW1ENEVsTkdQejBrUWw5dXYwdDdEd0NnWVNhZ3RuaExTbkxqQVZTMzAy?=
 =?utf-8?B?MEJ5QzlMVjFkYnlEMm5jTG5nSGxJYTFGYW5KOFJ4V0lhdDFia3d6U3dNWFov?=
 =?utf-8?B?VUQyK1dLbXBWUW83VUZKYTA3NFV0dFJNOERMdHVUUmlTM1Bnc0J3ZkxRWmJl?=
 =?utf-8?B?MmYwSEloK0szRTJTV3UyMFRybzFsc0lXVjUrZ2lFRjFoVFhzdDVXeXRLUlBE?=
 =?utf-8?B?bjdSaTcwTkdDbG9MdTNYUUhHcmJWY0JyRlZTc2RwQkhFTU9kT3VyRDFJNlI0?=
 =?utf-8?B?RUhndjVsc25UMXhrd0tKN1lUN2h2L1l3MGZaMVplb1dDOXZvVnR3Rm9mdW5B?=
 =?utf-8?B?K25HNWw2MHl4VUtVT29MRE0wZ2F2QysyTEJYTmc1VVJhRUk5cWdiVDNvLzdI?=
 =?utf-8?B?aDRiRGVGSGkwQmEzeGxYNnNMRlVKNmsyOE94TlZNeDBva2t6Wmc1d1NWMkFL?=
 =?utf-8?Q?Z9asH4jK2bybLKIP3cDJ5s6Jl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3646868-a547-464e-ae34-08dc2085dec5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 04:50:52.1864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWgkbZmYSOZDdbNGAGk+8zN/nJaz71VSX8MzdFJou5dxp/VQbDlQifVlO/Y2IE3zSUhRHwKbKFkNQ261YtHZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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


On 2024-01-26 10:54, Christian König wrote:
> Hi guys,
>
> those two patches clean up gang submit. The first one should prevent
> crashes when gang submit is used together with a reserved VMID.
>
> The second rejects gang submits with a reserved VMID when this won't
> work because of HW limitations.
>
> Only smoke tested since I need more HW for this setup
>
> @Vitaly: If you have some time please test them with your stand alone
> gang submit test first and then we need to come up with a combined
> test case for gang submit with reserved VMID.
Hi Christian,

After applying both patches no problem was found with the basic and gang submit IGT tests.
When I modified a gang submits test ( added VMID allocation/free), It was rejected cs by amdgpu_cs_vm_handling(not sure here)

Based on the above things look correct. Let's discuss the details of gang submission with VMID.

Thanks, Vitaly


>
> Regards,
> Christian.
>
>
