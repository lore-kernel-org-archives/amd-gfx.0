Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDE2C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 11:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F7710ECFB;
	Fri, 10 Feb 2023 11:56:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E34610ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 11:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxGCDzd0teBLd7d1FKOC6wW9tpPfplEyXbbQ9GKKH+qfupCOmsPYotdk1AzV9Bt4lByK5snR+wb/6M6mVl179s7N+Vur0h+o1s3+24+IYvjCS4XGP1mcJGcjUlkjjEUuuBKnOh7ilUb4mDAmKHOkH6FcyXqI06xOIUN9pOdIF11GbsEzJKqU1TjOaQwJZng5h2GlczuBurXGNnAMyNq+ewJc0+eK/OlfpTYh//AK85EyJOoqXxcD2lAqzWyEDDDxzwmMmakXCf6mMOjEe0tCvahyhibI4z/Nn2I3i68YS5828DvNj5OYgGqy+e29H7CyC8hlnJCR2aGOxagcTxvvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYw0yXENmo1EVAZYEWbskZPzqnJcWLkCZLqlglQ8qbs=;
 b=ZvOv7vMnUuVAwR2L8Iu1pF5CEz2ASwzIxzC7SY2a9uIVpSQOQ8LH5Nmpg++aGRMiSGCjYYrUyPhZU+Ucs/2cgOF7NRX9gfquGwt2MngTPcGYZhKTQK/3ERKcngxm7EpUfh24xkm/JneoyDBZmQ2USNtqBOehwCHocdJoELvW4nFSBtcVaHxpPRqhPo/VjKhvSrxQjbBdH5ZyhiLIHfodVnlb4oDXlHxTMhB50c7+T6dMhaOkLgeDKjO23CMJoDMR7FNDYfcdkp9ijmRw9JsGXRs5zU2mnz3mpeWwk0sbBgmCMREZ/qb8oT+SV7kgvv6yHReBFTPwpgbQAZgHK+PDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYw0yXENmo1EVAZYEWbskZPzqnJcWLkCZLqlglQ8qbs=;
 b=ZDk1GaAxIpoRTibxBEgqnmvBsgXNx7z1zn9khh0iajXuKSIRg3UctwBk4dI0VS0x75OvPm+WZHD8+c7KofoWhw2Ucee0BKNcNxvxlbOiuM3/aeoONhr6CV8ojyEv3isDomgce5g6zHh8J9ExVDZBhEC3int4jmpDynRvKmfLliY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 11:56:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 11:56:24 +0000
Content-Type: multipart/alternative;
 boundary="------------ZY1y6C4cksZjmLD838fsR5t0"
Message-ID: <a1d6781f-00be-6723-b07d-195af5b7cd61@amd.com>
Date: Fri, 10 Feb 2023 12:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Content-Language: en-US
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
 <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
 <MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9cf6c24f-2b91-0431-6098-4ee2230ce57a@gmail.com>
 <DM6PR12MB26199592B7845FA8543B9134E4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <29f0cd30-9af6-0bd9-fa13-80c52d8209fe@amd.com>
 <MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <e188b6c7-2996-3f3c-9a7b-dc95c1b17697@amd.com>
 <MW3PR12MB44582E9B0204ADEA3FA128AFEFDE9@MW3PR12MB4458.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB44582E9B0204ADEA3FA128AFEFDE9@MW3PR12MB4458.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 156e1ce0-faa2-41d0-d2c9-08db0b5dd533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya5ti6YgJvHRhyvtXehPFypFexocgSK9YS33mfoqlQrOys6n+S4QBL8UY/ANVAnPZgCnyIgVbRbPQnvTZCCVp3ftUIeEz3VNPvY1RB4Tpl5d8hSzGhOyCmGFIzc/tZwEfsMuqlurbIYjzFmFgWg1sow/h0n2HmivlaTNXWTJccL5hCwOvBU0B+12bowAGQzr9A/D5BZ03oSKHpniZVZJF141pzlMvatnyUYr6bhy5tALDsbQRjm2C5Vglklh5oJGOeJYwZ5UM4iiVSlKMU3GfF79x/o+yoRUqvUT4TGCGPD+EAEb6V8vSbTCFeR2ADf7TzVstpoP9+q3QdFlvIaENksdgng2m6FJLOyHsyZPog+wSzqu6Beg4Ik71unyGSpqLr/FiVbFQlIBwS8l3MFzGP+/8gWMCn2ntRAOZwQSUQAse/fRPTo9oHek5BUl5+jug/eiRU2esRJxMi9FLGauAl7tk4n/ewOMEm/5IbPVa5ISl6VQIK/1jwvmiR83RXhXhYLYMPQQeXkKXA6jwScLvp60gw7omhlSSUxqUGiOz8RYcDCTsiUYpVWx20Gx0BC9LVDTEuU3soSMVbbExVfCJxGz2KxsNF3+dS0ZNUWrcK50incRn1uRxLuuVjl1IJA8p8OibX7wyes4+b29p8j25rJMRmT8a0gc4Z/D/+e58bRuTJmwl+kc1oFWX3cMB+Txv9ERfViuBCih4hY6KkRhdRv5FwcFBpeH7cy/QqJ6Tsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(45080400002)(31686004)(66574015)(6506007)(33964004)(186003)(110136005)(478600001)(53546011)(6486002)(6636002)(83380400001)(316002)(2616005)(6512007)(6666004)(41300700001)(8936002)(5660300002)(2906002)(86362001)(31696002)(36756003)(30864003)(66946007)(66556008)(66476007)(8676002)(38100700002)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9RbHhoZ0FhSVUrMzhkQlFaN08ySnBxWjBGY01GYk9FeVZ5ZWZvRVZPUXln?=
 =?utf-8?B?aEkrTFRuQm43Y1hqcmVWY0lvRGpvNm5lOWxuQ0tYWnJ2eWtXK1pzcUhQN0JK?=
 =?utf-8?B?UnVwK2oxcGhDb0xWRnhkaHhOUTNpZDdiQ3d0RWdmNVZmZWFnYWFRWjAweFFL?=
 =?utf-8?B?SnVXbm5IMzNzeUlhaE5zOVA5Q3ZkL1doSXZybmdycWh5NGtXQjJ6VXQ5KzNm?=
 =?utf-8?B?WFFieGM0LzI2SUVCcDg5QTR5SzNsUG9XTDFUa3ozSldFZjhTSUNHbUpOa0tO?=
 =?utf-8?B?Z1FxcER5ZzFVVkcrZHJMTmF3ZVhLanI3WCtJZEdmeEVxaVpraVgzUis1VkVC?=
 =?utf-8?B?OHpLMmFsU2lsZkVKeG12NklKc0l4ckJtWU1KTWZSS21yZ25JK2pVMGx3ZDJo?=
 =?utf-8?B?d0dVM2F5WkRsT2hjS28zWlo1V3JOY0ltLzRpZmh3NHBYMlRhYzY5cjlrUmhF?=
 =?utf-8?B?OWIxd2RXWjJQVzU3Ty9yVHdXTUJ6SmhmeCtCaDMrdWtFbGNWMmg0RGt4MnR6?=
 =?utf-8?B?LzlwSDRZUkpLTExFVG42VWZjR2Q5dk1wWVZiRjZrOWhLdVcya09uL3NxZk1Z?=
 =?utf-8?B?L05HZlF3U1ZRSW9YWXM5MHBuL3dadG82SFEvYWdoSVpzUEV5ell3dmpMRjRv?=
 =?utf-8?B?TVJPNW05YWNrN0JZelUrSngyWE1lT0x2SjZOUTgraTcyckxTRkUyWDJFVDdB?=
 =?utf-8?B?S08rMTRmSmZLcndJMWNGeVUxL0F5SlpHSktnOTAvUTdhazJvNGhnbFdZTGp5?=
 =?utf-8?B?Y3JySjJWL1QwNTZBVGorQU5qa2ZVNXRIdHlZNEUrblZWQzhGelByUVNOUlFi?=
 =?utf-8?B?TndUbEtQd002VE9nbFlkTnVnSTVHMFRUdnk3Y2s3a21NYzBCZy9VUUF2cFV3?=
 =?utf-8?B?STRXOVhWSGlSNE9FejlSWlpySVhLdFp1amgwRElBQzdQT3B4TStEZ0hLZ3Bz?=
 =?utf-8?B?TjRyWWp2OVcxMW15OFpnRmdXVHhybHpUc29UMHI1MDlVcEF5ZytWTjgvVG5U?=
 =?utf-8?B?YmxLU2cwMExYMlV0c2ZaNTNoVE5kcDJ2Sm5keXVSTmNkRGRjdEtDekt2dUtk?=
 =?utf-8?B?bm5PZHVDYkc4TG9ieWI1UGx6RVhhMnlZZDBFYzVNUmZZV2ttZjR0K1lnYk0z?=
 =?utf-8?B?YTVsKzJxcDBpVndYSHR6a3NhZWNlaUFvQ3RoWSs0RC9iZXJZVElVNHEyekJV?=
 =?utf-8?B?ZlQ3ejlaNWRqYnQxU3lzS2lWYmhZYWlNTWgvMW8yVnQwZmNQUkc0UWtPOFlp?=
 =?utf-8?B?S2RBdk43R09HRitLZGFzdHZ2REUzeFdBMi9FemU3K3hWcnhPNW10dkZWTFoz?=
 =?utf-8?B?T045cU5uM0VtbmJrN2RQeXlTOHc4ck1qbm5JTWFPSENLbTA1MEx6NXJrVkxJ?=
 =?utf-8?B?ajdRTUQ5ZFVNcVB0Q2VHcGExanJ2L0xCY2N6cW5JMFNLVXBFZmc0clZiMFFT?=
 =?utf-8?B?OERwNEIzQ0VaYy9zZnNGTHhWakZ5dnhFN2ttSkFxeGZVcCtzbGdTcVdmN1l4?=
 =?utf-8?B?d3A2cDVTOXNSZXo5a1RkeG1XR3F2Qk15eGlaYllSVnFsWTVjNm11TEZzSVQy?=
 =?utf-8?B?L05SL2lzbVhxR3hnSVpXTUs3cWhSbWltM0Y0VTNxemdnTGpDTkk0Nnp2TElu?=
 =?utf-8?B?MU5XMDlKUitVZERHdHhVTVZ1UTlXa3BqTFZ5MitUNUhFdXBYS0VFL1dGYlQ3?=
 =?utf-8?B?bDdrLzZNUFRQSTVadDJ1RENjNEplRWxSYWZLbjMrOTRZYzlFN0lqMEtRbENx?=
 =?utf-8?B?NjAvMXlqZnpWa3ppeDdFeWlTdHREcTlRTlBQclVaV1p5K05ZblRsb0VHb1ZI?=
 =?utf-8?B?U3pIS0E0dElNUWNZSVFNbXQxWGttcW5YaWJ3MTNJbTIwdzdGUHQzUFUzOW9k?=
 =?utf-8?B?YTBkeFhjbHI3OEJlT01Tb2xFTlViQk5BaU5hY3JjN3pRMnQ3V1phYUY3d0g0?=
 =?utf-8?B?ZTI0UWt1V0d6cnd4aHFRWUNVeGwrdEFHWDliNUptTERwQVVRS0V6QkY0YUVO?=
 =?utf-8?B?ZG9aWisvdjZEZWphRS8yYU5DSVFoUmIyRStDeFRwVG4zRGhLL0pieG1DYVN3?=
 =?utf-8?B?clVNV3lpTUl1US84TzZEMllIUFhUUVRUMkdmVzhabEU5Z2N2TUs3eWV0aVVF?=
 =?utf-8?B?WTY0V05MN3hJb3VZZGtVeWtCR09sZXZzb2hBZnNmbC9Jd1hocGp4STZMQWh0?=
 =?utf-8?Q?ArUVoFz3MVatcztwKJdn7jBkV8qgkYEV8EpwJYKKP/KW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e1ce0-faa2-41d0-d2c9-08db0b5dd533
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 11:56:24.3614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjLbbkg3ZTBmIJOMGRqkonh2+hr9AkgFVAbkjtoWpEPOQ217LwKGM4rZhs+zHIdz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

--------------ZY1y6C4cksZjmLD838fsR5t0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.02.23 um 12:30 schrieb Xiao, Jack:
>
> [AMD Official Use Only - General]
>
> >> The driver are resumed before the core Linux memory management is 
> ready to serve allocations. E.g. swap for example isn't turned on yet.
>
> >> This means that this stuff only worked because we were able to 
> allocate memory from the pool which isn't guaranteed in any way.
>
> Memory allocation failure can happen at any time, every programmer 
> should correctly handle it.
>

We are not talking about memory allocation failure, we are talking about 
the kernel calling panic() because it can't properly resume.

Regards,
Christian.

> If memory allocation failure is not critical error and can gracefully 
> continue to run, it should be acceptable.
>
> The memory allocation failure during mes self test should be the 
> acceptable one. It will not make system hang up and
>
> driver can gracefully continue to run.
>
> Regards,
>
> Jack
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, February 10, 2023 6:25 PM
> *To:* Xiao, Jack <Jack.Xiao@amd.com>; Quan, Evan <Evan.Quan@amd.com>; 
> Christian König <ckoenig.leichtzumerken@gmail.com>; 
> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA 
> is unavailable
>
> Hi Jack,
>
> Am 10.02.23 um 10:51 schrieb Xiao, Jack:
>
>     [AMD Official Use Only - General]
>
>     Hi Christian,
>
>     >> Allocating buffers temporary for stuff like that is illegal
>     during resume.
>
>     Can you **deeply** explain why it is illegal during ip late_init
>     stage which is a part stage of resume?
>
>
> Well no, I don't have the time to explain this to everybody individually.
>
> [Jack] …
>
>     In my understanding, after gmc ready, driver can allocate/free
>     kernel bo, and after SDMA ready,
>
>     the eviction should be ready. What else prevent driver doing that
>     during resume?
>
>
> The driver are resumed before the core Linux memory management is 
> ready to serve allocations. E.g. swap for example isn't turned on yet.
>
> This means that this stuff only worked because we were able to 
> allocate memory from the pool which isn't guaranteed in any way.
>
>     >> I strongly suggest to just remove the MES test. It's abusing
>     the kernel ring interface in a way we didn't want anyway and is
>     currently replaced by Shahanks work.
>
>     The kernel mes unit test is very meaningful and important to catch
>     MES firmware issue at first time before
>
>     issue went spread to other components like kfd/umd to avoid the
>     problem complicated, Otherwise, the issue
>
>     would become hard to catch and debug.
>
>     Secondly, for mes unit test is self-containing and no dependency,
>     it is a part of milestone to qualify MES ready,
>
>     indicating that it can deliver to other component especially
>     during brinup. It is likely ring test and ib test indicating
>
>     gfx is ready to go. After totally transitioning to gfx user queue,
>     mes unit test may be the only one unit test which
>
>     can indicate gfx is ready at the very early stage of bringup when
>     UMD is not ready.
>
>
> Alex and I are the maintainers of the driver who are deciding stuff 
> like that and at least I don't really buy that argument. The ring, IB 
> and benchmark tests are in the kernel module because they are simple.
>
> If we have a complicated unit test like simulating creating an MES 
> user queue to test the firmware functionality than that's really 
> overkill. Especially when you need to allocate memory for it.
>
> We previously had people requesting to add shader code and other 
> complicated testing and rejected that as well because it just bloat up 
> the kernel driver unnecessarily.
>
> If we can modify the MES test to not abuse the amdgpu_ring structure 
> only work with memory from the SA for example we could keep this, but 
> not really in the current state.
>
> Regards,
> Christian.
>
>     Regards,
>
>     Jack
>
>     *From:* Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>
>     *Sent:* Friday, February 10, 2023 4:08 PM
>     *To:* Quan, Evan <Evan.Quan@amd.com> <mailto:Evan.Quan@amd.com>;
>     Christian König <ckoenig.leichtzumerken@gmail.com>
>     <mailto:ckoenig.leichtzumerken@gmail.com>; Xiao, Jack
>     <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>;
>     amd-gfx@lists.freedesktop.org; Deucher, Alexander
>     <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>     *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when
>     DMA is unavailable
>
>     Hi Evan,
>
>     yeah, exactly that's what this warning should prevent. Allocating
>     buffers temporary for stuff like that is illegal during resume.
>
>     I strongly suggest to just remove the MES test. It's abusing the
>     kernel ring interface in a way we didn't want anyway and is
>     currently replaced by Shahanks work.
>
>     Regards,
>     Christian.
>
>     Am 10.02.23 um 05:12 schrieb Quan, Evan:
>
>         [AMD Official Use Only - General]
>
>         Hi Jack,
>
>         Are you trying to fix the call trace popped up on resuming below?
>
>         It seems mes created some bo for its self test and freed it up
>         later at the final stage of the resuming process.
>
>         All these happened before the in_suspend flag cleared. And
>         that triggered the call trace.
>
>         Is my understanding correct?
>
>         [74084.799260] WARNING: CPU: 2 PID: 2891 at
>         drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425
>         amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
>
>         [74084.811019] Modules linked in: nls_iso8859_1 amdgpu(OE)
>         iommu_v2 gpu_sched drm_buddy drm_ttm_helper ttm
>         drm_display_helper drm_kms_helper i2c_algo_bit fb_sys_fops
>         syscopyarea sysfillrect sysimgblt snd_sm
>
>         [74084.811042]  ip_tables x_tables autofs4 hid_logitech_hidpp
>         hid_logitech_dj hid_generic e1000e usbhid ptp uas hid video
>         i2c_i801 ahci pps_core crc32_pclmul i2c_smbus usb_storage
>         libahci wmi
>
>         [74084.914519] CPU: 2 PID: 2891 Comm: kworker/u16:38 Tainted:
>         G        W IOE      6.0.0-custom #1
>
>         [74084.923146] Hardware name: ASUS System Product Name/PRIME
>         Z390-A, BIOS 2004 11/02/2021
>
>         [74084.931074] Workqueue: events_unbound async_run_entry_fn
>
>         [74084.936393] RIP: 0010:amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
>
>         [74084.942422] Code: 00 4d 85 ed 74 08 49 c7 45 00 00 00 00 00
>         4d 85 e4 74 08 49 c7 04 24 00 00 00 00 5b 41 5c 41 5d 41 5e 41
>         5f 5d c3 cc cc cc cc <0f> 0b e9 39 ff ff ff 3d 00 fe ff ff 0f
>         85 75 96 47 00 ebf
>
>         [74084.961199] RSP: 0000:ffffbed6812ebb90 EFLAGS: 00010202
>
>         [74084.966435] RAX: 0000000000000000 RBX: ffffbed6812ebc50
>         RCX: 0000000000000000
>
>         [74084.973578] RDX: ffffbed6812ebc70 RSI: ffffbed6812ebc60
>         RDI: ffffbed6812ebc50
>
>         [74084.980725] RBP: ffffbed6812ebbb8 R08: 0000000000000000
>         R09: 00000000000001ff
>
>         [74084.987869] R10: ffffbed6812ebb40 R11: 0000000000000000
>         R12: ffffbed6812ebc70
>
>         [74084.995015] R13: ffffbed6812ebc60 R14: ffff963a2945cc00
>         R15: ffff9639c7da5630
>
>         [74085.002160] FS: 0000000000000000(0000)
>         GS:ffff963d1dc80000(0000) knlGS:0000000000000000
>
>         [74085.010262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>
>         [74085.016016] CR2: 0000000000000000 CR3: 0000000377c0a001
>         CR4: 00000000003706e0
>
>         [74085.023164] DR0: 0000000000000000 DR1: 0000000000000000
>         DR2: 0000000000000000
>
>         [74085.030307] DR3: 0000000000000000 DR6: 00000000fffe0ff0
>         DR7: 0000000000000400
>
>         [74085.037453] Call Trace:
>
>         [74085.039911]  <TASK>
>
>         [74085.042023] amdgpu_mes_self_test+0x385/0x460 [amdgpu]
>
>         [74085.047293] mes_v11_0_late_init+0x44/0x50 [amdgpu]
>
>         [74085.052291] amdgpu_device_ip_late_init+0x50/0x270 [amdgpu]
>
>         [74085.058032] amdgpu_device_resume+0xb0/0x2d0 [amdgpu]
>
>         [74085.063187] amdgpu_pmops_resume+0x37/0x70 [amdgpu]
>
>         [74085.068162] pci_pm_resume+0x68/0x100
>
>         [74085.071836]  ? pci_legacy_resume+0x80/0x80
>
>         [74085.075943] dpm_run_callback+0x4c/0x160
>
>         [74085.079873] device_resume+0xad/0x210
>
>         [74085.083546]  async_resume+0x1e/0x40
>
>         [74085.087046] async_run_entry_fn+0x30/0x120
>
>         [74085.091152] process_one_work+0x21a/0x3f0
>
>         [74085.095173] worker_thread+0x50/0x3e0
>
>         [74085.098845]  ? process_one_work+0x3f0/0x3f0
>
>         [74085.103039]  kthread+0xfa/0x130
>
>         [74085.106189]  ? kthread_complete_and_exit+0x20/0x20
>
>         [74085.110993]  ret_from_fork+0x1f/0x30
>
>         [74085.114576]  </TASK>
>
>         [74085.116773] ---[ end trace 0000000000000000 ]---
>
>         BR
>
>         Evan
>
>         *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>         <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>         *Christian König
>         *Sent:* Monday, February 6, 2023 5:00 PM
>         *To:* Xiao, Jack <Jack.Xiao@amd.com>
>         <mailto:Jack.Xiao@amd.com>; Koenig, Christian
>         <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>;
>         amd-gfx@lists.freedesktop.org; Deucher, Alexander
>         <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>         *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers
>         when DMA is unavailable
>
>         Am 06.02.23 um 09:28 schrieb Xiao, Jack:
>
>             [AMD Official Use Only - General]
>
>                            >> >> It's simply not allowed to free up
>             resources during suspend since those can't be acquired
>             again during resume.
>
>             >> The in_suspend flag is set at the beginning of suspend
>             and unset at the end of resume. It can’t filter the case
>             you mentioned.
>
>
>                            Why not? This is exactly what it should do.
>
>             [Jack] If freeing up resources during resume, it should
>             not hit the issue you described. But only checking
>             in_suspend flag would take these cases as warning.
>
>
>         No, once more: Freeing up or allocating resources between
>         suspend and resume is illegal!
>
>         If you free up a resource during resume you should absolutely
>         hit that, this is intentional!
>
>         Regards,
>         Christian.
>
>
>             Regards,
>
>             Jack
>
>             *From:* Koenig, Christian <Christian.Koenig@amd.com>
>             <mailto:Christian.Koenig@amd.com>
>             *Sent:* Monday, February 6, 2023 4:06 PM
>             *To:* Xiao, Jack <Jack.Xiao@amd.com>
>             <mailto:Jack.Xiao@amd.com>; Christian König
>             <ckoenig.leichtzumerken@gmail.com>
>             <mailto:ckoenig.leichtzumerken@gmail.com>;
>             amd-gfx@lists.freedesktop.org; Deucher, Alexander
>             <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>             *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing
>             buffers when DMA is unavailable
>
>             Am 06.02.23 um 08:23 schrieb Xiao, Jack:
>
>                 [AMD Official Use Only - General]
>
>                 >> Nope, that is not related to any hw state.
>
>                 can use other flag.
>
>                 >> It's simply not allowed to free up resources during
>                 suspend since those can't be acquired again during resume.
>
>                 The in_suspend flag is set at the beginning of suspend
>                 and unset at the end of resume. It can’t filter the
>                 case you mentioned.
>
>
>             Why not? This is exactly what it should do.
>
>
>                 Do you know the root cause of these cases hitting the
>                 issue? So that we can get an exact point to warn the
>                 freeing up behavior.
>
>
>             Well the root cause are programming errors. See between
>             suspending and resuming you should not allocate nor free
>             memory.
>
>             Otherwise we can run into trouble. And this check here is
>             one part of that, we should probably add another warning
>             during allocation of memory. But this here is certainly
>             correct.
>
>             Regards,
>             Christian.
>
>
>                 Thanks,
>
>                 Jack
>
>                 *From:* Christian König
>                 <ckoenig.leichtzumerken@gmail.com>
>                 <mailto:ckoenig.leichtzumerken@gmail.com>
>                 *Sent:* Friday, February 3, 2023 9:20 PM
>                 *To:* Xiao, Jack <Jack.Xiao@amd.com>
>                 <mailto:Jack.Xiao@amd.com>; Koenig, Christian
>                 <Christian.Koenig@amd.com>
>                 <mailto:Christian.Koenig@amd.com>;
>                 amd-gfx@lists.freedesktop.org; Deucher, Alexander
>                 <Alexander.Deucher@amd.com>
>                 <mailto:Alexander.Deucher@amd.com>
>                 *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing
>                 buffers when DMA is unavailable
>
>                 Nope, that is not related to any hw state.
>
>                 It's simply not allowed to free up resources during
>                 suspend since those can't be acquired again during resume.
>
>                 We had a couple of cases now where this was wrong. If
>                 you get a warning from that please fix the code which
>                 tried to free something during suspend instead.
>
>                 Regards,
>                 Christian.
>
>                 Am 03.02.23 um 07:04 schrieb Xiao, Jack:
>
>                     [AMD Official Use Only - General]
>
>                     >> It's simply illegal to free up memory during
>                     suspend.
>
>                     Why? In my understanding, the limit was caused by
>                     DMA shutdown.
>
>                     Regards,
>
>                     Jack
>
>                     *From:* Koenig, Christian
>                     <Christian.Koenig@amd.com>
>                     <mailto:Christian.Koenig@amd.com>
>                     *Sent:* Thursday, February 2, 2023 7:43 PM
>                     *To:* Xiao, Jack <Jack.Xiao@amd.com>
>                     <mailto:Jack.Xiao@amd.com>;
>                     amd-gfx@lists.freedesktop.org; Deucher, Alexander
>                     <Alexander.Deucher@amd.com>
>                     <mailto:Alexander.Deucher@amd.com>
>                     *Subject:* AW: [PATCH] drm/amdgpu: only WARN
>                     freeing buffers when DMA is unavailable
>
>                     Big NAK to this! This warning is not related in
>                     any way to the hw state.
>
>                     It's simply illegal to free up memory during suspend.
>
>                     Regards,
>
>                     Christian.
>
>                     ------------------------------------------------------------------------
>
>                     *Von:*Xiao, Jack <Jack.Xiao@amd.com>
>                     *Gesendet:* Donnerstag, 2. Februar 2023 10:54
>                     *An:*
>                     amd-gfx@lists.freedesktop.org<amd-gfx@lists.freedesktop.org>;
>                     Deucher, Alexander <Alexander.Deucher@amd.com>;
>                     Koenig, Christian <Christian.Koenig@amd.com>
>                     *Cc:* Xiao, Jack <Jack.Xiao@amd.com>
>                     *Betreff:* [PATCH] drm/amdgpu: only WARN freeing
>                     buffers when DMA is unavailable
>
>                     Reduce waringings, only warn when DMA is unavailable.
>
>                     Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>                     ---
>                      drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>                      1 file changed, 2 insertions(+), 1 deletion(-)
>
>                     diff --git
>                     a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                     b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                     index 2d237f3d3a2e..e3e3764ea697 100644
>                     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>                     @@ -422,7 +422,8 @@ void
>                     amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64
>                     *gpu_addr,
>                              if (*bo == NULL)
>                                      return;
>
>                     -
>                     WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
>                     +
>                     WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend
>                     &&
>                     +
>                     !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);
>
>                              if (likely(amdgpu_bo_reserve(*bo, true)
>                     == 0)) {
>                                      if (cpu_addr)
>                     -- 
>                     2.37.3
>

--------------ZY1y6C4cksZjmLD838fsR5t0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 10.02.23 um 12:30 schrieb Xiao, Jack:<br>
    <blockquote type="cite" cite="mid:MW3PR12MB44582E9B0204ADEA3FA128AFEFDE9@MW3PR12MB4458.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only - General]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&gt;&gt; The driver are resumed before the
          core Linux memory management is ready to serve allocations.
          E.g. swap for example isn't turned on yet.<br>
          <br>
          &gt;&gt; This means that this stuff only worked because we
          were able to allocate memory from the pool which isn't
          guaranteed in any way.
          <br>
          <br>
          Memory allocation failure can happen at any time, every
          programmer should correctly handle it.</p>
      </div>
    </blockquote>
    <br>
    We are not talking about memory allocation failure, we are talking
    about the kernel calling panic() because it can't properly resume.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:MW3PR12MB44582E9B0204ADEA3FA128AFEFDE9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">If memory allocation failure is not
          critical error and can gracefully continue to run, it should
          be acceptable.
          <o:p></o:p></p>
        <p class="MsoNormal">The memory allocation failure during mes
          self test should be the acceptable one. It will not make
          system hang up and<o:p></o:p></p>
        <p class="MsoNormal">driver can gracefully continue to run.<o:p></o:p></p>
        <p class="MsoNormal">&nbsp;<o:p></o:p></p>
        <p class="MsoNormal">Regards,<o:p></o:p></p>
        <p class="MsoNormal">Jack<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Friday, February 10, 2023 6:25 PM<br>
              <b>To:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Quan,
              Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>; Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing
              buffers when DMA is unavailable<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Hi Jack,<br>
          <br>
          Am 10.02.23 um 10:51 schrieb Xiao, Jack:<o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
              Official Use Only - General]</span><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Hi Christian,<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">&gt;&gt; Allocating buffers temporary for
            stuff like that is illegal during resume.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Can you *<b>deeply</b>* explain why it is
            illegal during ip late_init stage which is a part stage of
            resume?<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><br>
          Well no, I don't have the time to explain this to everybody
          individually.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">[Jack] …<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal">In my understanding, after gmc ready,
            driver can allocate/free kernel bo, and after SDMA ready,
            <o:p></o:p></p>
          <p class="MsoNormal">the eviction should be ready. What else
            prevent driver doing that during resume?<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><br>
          The driver are resumed before the core Linux memory management
          is ready to serve allocations. E.g. swap for example isn't
          turned on yet.<br>
          <br>
          This means that this stuff only worked because we were able to
          allocate memory from the pool which isn't guaranteed in any
          way.
          <o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">&gt;&gt; I strongly suggest to just
            remove the MES test. It's abusing the kernel ring interface
            in a way we didn't want anyway and is currently replaced by
            Shahanks work.<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">The kernel mes unit test is very
            meaningful and important to catch MES firmware issue at
            first time before
            <o:p></o:p></p>
          <p class="MsoNormal">issue went spread to other components
            like kfd/umd to avoid the problem complicated, Otherwise,
            the issue
            <o:p></o:p></p>
          <p class="MsoNormal">would become hard to catch and debug. <o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Secondly, for mes unit test is
            self-containing and no dependency, it is a part of milestone
            to qualify MES ready,<o:p></o:p></p>
          <p class="MsoNormal">indicating that it can deliver to other
            component especially during brinup. It is likely ring test
            and ib test indicating
            <o:p></o:p></p>
          <p class="MsoNormal">gfx is ready to go. After totally
            transitioning to gfx user queue, mes unit test may be the
            only one unit test which<o:p></o:p></p>
          <p class="MsoNormal">can indicate gfx is ready at the very
            early stage of bringup when UMD is not ready.<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
          Alex and I are the maintainers of the driver who are deciding
          stuff like that and at least I don't really buy that argument.
          The ring, IB and benchmark tests are in the kernel module
          because they are simple.<br>
          <br>
          If we have a complicated unit test like simulating creating an
          MES user queue to test the firmware functionality than that's
          really overkill. Especially when you need to allocate memory
          for it.<br>
          <br>
          We previously had people requesting to add shader code and
          other complicated testing and rejected that as well because it
          just bloat up the kernel driver unnecessarily.<br>
          <br>
          If we can modify the MES test to not abuse the amdgpu_ring
          structure only work with memory from the SA for example we
          could keep this, but not really in the current state.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal">Regards,<o:p></o:p></p>
          <p class="MsoNormal">Jack<o:p></o:p></p>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                  &lt;Christian.Koenig@amd.com&gt;</a> <br>
                <b>Sent:</b> Friday, February 10, 2023 4:08 PM<br>
                <b>To:</b> Quan, Evan <a href="mailto:Evan.Quan@amd.com" moz-do-not-send="true">&lt;Evan.Quan@amd.com&gt;</a>;
                Christian König
                <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                Xiao, Jack
                <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                  amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
                <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                  &lt;Alexander.Deucher@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                freeing buffers when DMA is unavailable<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt">Hi Evan,<br>
            <br>
            yeah, exactly that's what this warning should prevent.
            Allocating buffers temporary for stuff like that is illegal
            during resume.<br>
            <br>
            I strongly suggest to just remove the MES test. It's abusing
            the kernel ring interface in a way we didn't want anyway and
            is currently replaced by Shahanks work.<br>
            <br>
            Regards,<br>
            Christian.<o:p></o:p></p>
          <div>
            <p class="MsoNormal">Am 10.02.23 um 05:12 schrieb Quan,
              Evan:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                Official Use Only - General]</span><o:p></o:p></p>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p class="MsoNormal">Hi Jack,<o:p></o:p></p>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p class="MsoNormal">Are you trying to fix the call trace
              popped up on resuming below?<o:p></o:p></p>
            <p class="MsoNormal">It seems mes created some bo for its
              self test and freed it up later at the final stage of the
              resuming process.
              <o:p></o:p></p>
            <p class="MsoNormal">All these happened before the
              in_suspend flag cleared. And that triggered the call
              trace.<o:p></o:p></p>
            <p class="MsoNormal">Is my understanding correct?<o:p></o:p></p>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p class="MsoNormal">[74084.799260] WARNING: CPU: 2 PID:
              2891 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425
              amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74084.811019] Modules linked in:
              nls_iso8859_1 amdgpu(OE) iommu_v2 gpu_sched drm_buddy
              drm_ttm_helper ttm drm_display_helper drm_kms_helper
              i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt
              snd_sm<o:p></o:p></p>
            <p class="MsoNormal">[74084.811042]&nbsp; ip_tables x_tables
              autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic
              e1000e usbhid ptp uas hid video i2c_i801 ahci pps_core
              crc32_pclmul i2c_smbus usb_storage libahci wmi<o:p></o:p></p>
            <p class="MsoNormal">[74084.914519] CPU: 2 PID: 2891 Comm:
              kworker/u16:38 Tainted: G &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;W IOE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.0.0-custom
              #1<o:p></o:p></p>
            <p class="MsoNormal">[74084.923146] Hardware name: ASUS
              System Product Name/PRIME Z390-A, BIOS 2004 11/02/2021<o:p></o:p></p>
            <p class="MsoNormal">[74084.931074] Workqueue:
              events_unbound async_run_entry_fn<o:p></o:p></p>
            <p class="MsoNormal">[74084.936393] RIP:
              0010:amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74084.942422] Code: 00 4d 85 ed 74 08
              49 c7 45 00 00 00 00 00 4d 85 e4 74 08 49 c7 04 24 00 00
              00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
              &lt;0f&gt; 0b e9 39 ff ff ff 3d 00 fe ff ff 0f 85 75 96 47
              00 ebf<o:p></o:p></p>
            <p class="MsoNormal">[74084.961199] RSP:
              0000:ffffbed6812ebb90 EFLAGS: 00010202<o:p></o:p></p>
            <p class="MsoNormal">[74084.966435] RAX: 0000000000000000
              RBX: ffffbed6812ebc50 RCX: 0000000000000000<o:p></o:p></p>
            <p class="MsoNormal">[74084.973578] RDX: ffffbed6812ebc70
              RSI: ffffbed6812ebc60 RDI: ffffbed6812ebc50<o:p></o:p></p>
            <p class="MsoNormal">[74084.980725] RBP: ffffbed6812ebbb8
              R08: 0000000000000000 R09: 00000000000001ff<o:p></o:p></p>
            <p class="MsoNormal">[74084.987869] R10: ffffbed6812ebb40
              R11: 0000000000000000 R12: ffffbed6812ebc70<o:p></o:p></p>
            <p class="MsoNormal">[74084.995015] R13: ffffbed6812ebc60
              R14: ffff963a2945cc00 R15: ffff9639c7da5630<o:p></o:p></p>
            <p class="MsoNormal">[74085.002160] FS:&nbsp;
              0000000000000000(0000) GS:ffff963d1dc80000(0000)
              knlGS:0000000000000000<o:p></o:p></p>
            <p class="MsoNormal">[74085.010262] CS:&nbsp; 0010 DS: 0000 ES:
              0000 CR0: 0000000080050033<o:p></o:p></p>
            <p class="MsoNormal">[74085.016016] CR2: 0000000000000000
              CR3: 0000000377c0a001 CR4: 00000000003706e0<o:p></o:p></p>
            <p class="MsoNormal">[74085.023164] DR0: 0000000000000000
              DR1: 0000000000000000 DR2: 0000000000000000<o:p></o:p></p>
            <p class="MsoNormal">[74085.030307] DR3: 0000000000000000
              DR6: 00000000fffe0ff0 DR7: 0000000000000400<o:p></o:p></p>
            <p class="MsoNormal">[74085.037453] Call Trace:<o:p></o:p></p>
            <p class="MsoNormal">[74085.039911]&nbsp; &lt;TASK&gt;<o:p></o:p></p>
            <p class="MsoNormal">[74085.042023]&nbsp;
              amdgpu_mes_self_test+0x385/0x460 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74085.047293]&nbsp;
              mes_v11_0_late_init+0x44/0x50 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74085.052291]&nbsp;
              amdgpu_device_ip_late_init+0x50/0x270 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74085.058032]&nbsp;
              amdgpu_device_resume+0xb0/0x2d0 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74085.063187]&nbsp;
              amdgpu_pmops_resume+0x37/0x70 [amdgpu]<o:p></o:p></p>
            <p class="MsoNormal">[74085.068162]&nbsp;
              pci_pm_resume+0x68/0x100<o:p></o:p></p>
            <p class="MsoNormal">[74085.071836]&nbsp; ?
              pci_legacy_resume+0x80/0x80<o:p></o:p></p>
            <p class="MsoNormal">[74085.075943]&nbsp;
              dpm_run_callback+0x4c/0x160<o:p></o:p></p>
            <p class="MsoNormal">[74085.079873]&nbsp;
              device_resume+0xad/0x210<o:p></o:p></p>
            <p class="MsoNormal">[74085.083546]&nbsp; async_resume+0x1e/0x40<o:p></o:p></p>
            <p class="MsoNormal">[74085.087046]&nbsp;
              async_run_entry_fn+0x30/0x120<o:p></o:p></p>
            <p class="MsoNormal">[74085.091152]&nbsp;
              process_one_work+0x21a/0x3f0<o:p></o:p></p>
            <p class="MsoNormal">[74085.095173]&nbsp;
              worker_thread+0x50/0x3e0<o:p></o:p></p>
            <p class="MsoNormal">[74085.098845]&nbsp; ?
              process_one_work+0x3f0/0x3f0<o:p></o:p></p>
            <p class="MsoNormal">[74085.103039]&nbsp; kthread+0xfa/0x130<o:p></o:p></p>
            <p class="MsoNormal">[74085.106189]&nbsp; ?
              kthread_complete_and_exit+0x20/0x20<o:p></o:p></p>
            <p class="MsoNormal">[74085.110993]&nbsp; ret_from_fork+0x1f/0x30<o:p></o:p></p>
            <p class="MsoNormal">[74085.114576]&nbsp; &lt;/TASK&gt;<o:p></o:p></p>
            <p class="MsoNormal">[74085.116773] ---[ end trace
              0000000000000000 ]---<o:p></o:p></p>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            <p class="MsoNormal">BR<o:p></o:p></p>
            <p class="MsoNormal">Evan<o:p></o:p></p>
            <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> amd-gfx <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">
                      &lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                    <b>On Behalf Of </b>Christian König<br>
                    <b>Sent:</b> Monday, February 6, 2023 5:00 PM<br>
                    <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                    Koenig, Christian
                    <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                      amd-gfx@lists.freedesktop.org</a>; Deucher,
                    Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                      &lt;Alexander.Deucher@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                    freeing buffers when DMA is unavailable<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              <p class="MsoNormal" style="margin-bottom:12.0pt">Am
                06.02.23 um 09:28 schrieb Xiao, Jack:<o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - General]</span><o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;&gt; It's simply not
                  allowed to free up resources during suspend since
                  those can't be acquired again during resume.<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &gt;&gt; The in_suspend flag is set at the beginning
                  of suspend and unset at the end of resume. It can’t
                  filter the case you mentioned.<o:p></o:p></p>
                <p class="MsoNormal"><br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Why not? This is exactly what it should
                  do.<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">[Jack] If freeing up resources
                  during resume, it should not hit the issue you
                  described. But only checking in_suspend flag would
                  take these cases as warning.<o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                No, once more: Freeing up or allocating resources
                between suspend and resume is illegal!<br>
                <br>
                If you free up a resource during resume you should
                absolutely hit that, this is intentional!<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">Regards,<o:p></o:p></p>
                <p class="MsoNormal">Jack<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b>From:</b> Koenig, Christian
                      <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                        &lt;Christian.Koenig@amd.com&gt;</a> <br>
                      <b>Sent:</b> Monday, February 6, 2023 4:06 PM<br>
                      <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                      Christian König
                      <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                      Deucher, Alexander
                      <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                      <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                      freeing buffers when DMA is unavailable<o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt">Am
                  06.02.23 um 08:23 schrieb Xiao, Jack:<o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                      Official Use Only - General]</span><o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal">&gt;&gt; Nope, that is not
                    related to any hw state.<o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal">can use other flag.<o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal" style="margin-bottom:12.0pt">&gt;&gt;
                    It's simply not allowed to free up resources during
                    suspend since those can't be acquired again during
                    resume.<o:p></o:p></p>
                  <p class="MsoNormal">The in_suspend flag is set at the
                    beginning of suspend and unset at the end of resume.
                    It can’t filter the case you mentioned.<o:p></o:p></p>
                </blockquote>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                  Why not? This is exactly what it should do.<br>
                  <br>
                  <br>
                  <o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal">Do you know the root cause of
                    these cases hitting the issue? So that we can get an
                    exact point to warn the freeing up behavior.<o:p></o:p></p>
                </blockquote>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                  Well the root cause are programming errors. See
                  between suspending and resuming you should not
                  allocate nor free memory.<br>
                  <br>
                  Otherwise we can run into trouble. And this check here
                  is one part of that, we should probably add another
                  warning during allocation of memory. But this here is
                  certainly correct.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  <br>
                  <o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal">Thanks,<o:p></o:p></p>
                  <p class="MsoNormal">Jack<o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b>From:</b> Christian König
                        <a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">
                          &lt;ckoenig.leichtzumerken@gmail.com&gt;</a> <br>
                        <b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
                        <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                        Koenig, Christian
                        <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">
                          amd-gfx@lists.freedesktop.org</a>; Deucher,
                        Alexander <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                          &lt;Alexander.Deucher@amd.com&gt;</a><br>
                        <b>Subject:</b> Re: [PATCH] drm/amdgpu: only
                        WARN freeing buffers when DMA is unavailable<o:p></o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p class="MsoNormal" style="margin-bottom:12.0pt">Nope,
                    that is not related to any hw state.<br>
                    <br>
                    It's simply not allowed to free up resources during
                    suspend since those can't be acquired again during
                    resume.<br>
                    <br>
                    We had a couple of cases now where this was wrong.
                    If you get a warning from that please fix the code
                    which tried to free something during suspend
                    instead.<br>
                    <br>
                    Regards,<br>
                    Christian.<o:p></o:p></p>
                  <div>
                    <p class="MsoNormal">Am 03.02.23 um 07:04 schrieb
                      Xiao, Jack:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="msipheaderdf3d92d6" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                        Official Use Only - General]</span><o:p></o:p></p>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    <p class="MsoNormal">&gt;&gt; It's simply illegal to
                      free up memory during suspend.<o:p></o:p></p>
                    <p class="MsoNormal">Why? In my understanding, the
                      limit was caused by DMA shutdown.<o:p></o:p></p>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    <p class="MsoNormal">Regards,<o:p></o:p></p>
                    <p class="MsoNormal">Jack<o:p></o:p></p>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    <div>
                      <div style="border:none;border-top:solid #E1E1E1
                        1.0pt;padding:3.0pt 0in 0in 0in">
                        <p class="MsoNormal"><b>From:</b> Koenig,
                          Christian <a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                            &lt;Christian.Koenig@amd.com&gt;</a> <br>
                          <b>Sent:</b> Thursday, February 2, 2023 7:43
                          PM<br>
                          <b>To:</b> Xiao, Jack <a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                          Deucher, Alexander
                          <a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                          <b>Subject:</b> AW: [PATCH] drm/amdgpu: only
                          WARN freeing buffers when DMA is unavailable<o:p></o:p></p>
                      </div>
                    </div>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    <div>
                      <p class="MsoNormal">Big NAK to this! This warning
                        is not related in any way to the hw state.<o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal">It's simply illegal to free
                        up memory during suspend.<o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal">Regards,<o:p></o:p></p>
                    </div>
                    <div>
                      <p class="MsoNormal">Christian.<o:p></o:p></p>
                    </div>
                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                    <div class="MsoNormal" style="text-align:center" align="center">
                      <hr width="98%" size="2" align="center">
                    </div>
                    <div id="divRplyFwdMsg">
                      <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Xiao, Jack &lt;</span><a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a><span style="color:black">&gt;<br>
                          <b>Gesendet:</b> Donnerstag, 2. Februar 2023
                          10:54<br>
                          <b>An:</b> </span><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><span style="color:black"> &lt;</span><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><span style="color:black">&gt;; Deucher, Alexander
                          &lt;</span><a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a><span style="color:black">&gt;; Koenig, Christian
                          &lt;</span><a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a><span style="color:black">&gt;<br>
                          <b>Cc:</b> Xiao, Jack &lt;</span><a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a><span style="color:black">&gt;<br>
                          <b>Betreff:</b> [PATCH] drm/amdgpu: only WARN
                          freeing buffers when DMA is unavailable</span>
                        <o:p></o:p></p>
                      <div>
                        <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <p class="MsoNormal" style="margin-bottom:12.0pt">Reduce
                          waringings, only warn when DMA is unavailable.<br>
                          <br>
                          Signed-off-by: Jack Xiao &lt;<a href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                          ---<br>
                          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |
                          3 ++-<br>
                          &nbsp;1 file changed, 2 insertions(+), 1
                          deletion(-)<br>
                          <br>
                          diff --git
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                          index 2d237f3d3a2e..e3e3764ea697 100644<br>
                          ---
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                          +++
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                          @@ -422,7 +422,8 @@ void
                          amdgpu_bo_free_kernel(struct amdgpu_bo **bo,
                          u64 *gpu_addr,<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo == NULL)<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                          &nbsp;<br>
                          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend);<br>
                          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend
                          &amp;&amp;<br>
                          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
!amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);<br>
                          &nbsp;<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reserve(*bo,
                          true) == 0)) {<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
                          -- <br>
                          2.37.3<o:p></o:p></p>
                      </div>
                    </div>
                  </blockquote>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                </blockquote>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal">&nbsp;<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------ZY1y6C4cksZjmLD838fsR5t0--
