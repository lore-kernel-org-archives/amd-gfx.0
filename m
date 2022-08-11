Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C0C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 11:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB31BAB59E;
	Thu, 11 Aug 2022 11:22:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BC1AB5C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 11:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W27HJFdaXytYnE10Li4zvcNeKd7ieSpLCidwUvlsQs8cSPWVqXo71B3g0uk3kQ+QZWmiIqIf1+uMZeoAK55BeKYnRecx/yjCFUIbVaINJT8ESCVdMkcM9YAqLo6mt2kaXnqydMZx/PCImxh+KUR/YrZZgmEY4j+c7VVTz5/ztZuTu/+CCC7hHOe20tYGCU/55vOaqtlpo1L26vNNDs3PcMpakzZrMv9TvLx+zRtK+wPLlZu5Fxko5gF4FuYWu5swp7Z/8MAaGGJ76BdMaFDtL0tnHddh1554CnB/ZNEIDOoKjvRiX5A44nqSmJROQrt1hPSexZtOF0ENm3TbEtiPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGnNmp94JHNM6RZ0tz6ZhAYbsesn7zQHZ96SS449BZw=;
 b=NOVLSXefl8ubXCmpuCr9sgl7f0PX05ePhW/Tcheuf+tNdcvU5bztldz370v8JU1+wfKuHnIkVQJvy6iI4W5Y1ptnS7OIpyoz/CamuNVVEO8qDR58B/t2kJ047lxXq+6fmUwzRkUa6C2gOLm1Ge6/NlrhdyLX4JF0HnDvL6hD5jHxLbJoFFOMh/t1t3NvkHuqekUGogA9QrsHPEgrFkblZeHap5k2D41o2Omm/pvghs1F0kBZMQglHnGHsHs19LzQad/JFnSv9JTggDXR1UPOMtjogXDLGRHZeJTrW4Hk9wzFGJC4SG/DDWL+H/YX0qR1Lt0tjJoyq6yJSANqcUQzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGnNmp94JHNM6RZ0tz6ZhAYbsesn7zQHZ96SS449BZw=;
 b=1Ib/+CI1mcTnWVtTa1fpzf6DBInKw01IPmWTHaNA4M9veGLtJ3mOO48NADmR6Ey/uV+bCcYOOSIAFN1eoBlw3oB/00uJnSqV9/57FI32aemaF/llMIJYgoePy0v3Au8ZC/X+U9Bk+TWFwAySEClQuE3znbrI1uK4a71JQYaAJDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 11:22:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Thu, 11 Aug 2022
 11:22:18 +0000
Message-ID: <6d24ac92-7ea9-0c35-a97a-bfb53b84f655@amd.com>
Date: Thu, 11 Aug 2022 13:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/8] drm/amd/display: Introduce KUnit to Display Mode
 Library
Content-Language: en-US
To: Tales Aparecida <tales.aparecida@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220811004010.61299-1-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0017.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::25) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df2a312b-c421-4920-bcdb-08da7b8bc03b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CW5FULBaV9vRexyQZPbxrd1wXmZv+gpQJX07RIByu8Dn8rejDSFjDHwJ09KDq7bKQKQGcQ7wICWcBTArkv0i/rilaaVtkK9ZtKUNtKgIeG2VeVMGbiccUAZqg/sHw+froiK9KDAwPFMmMiEE30nXbx/bF7LVY6lnapC5Tr7L9SKu/t4XV++8d9nzcw5KqDIOFJFRzJ8VgBW+tEUVxskrG2PdJQqlmyNxit7ahJqYZ78sFkUO+sjb03iS2NcYP2GBug/On0hFX5EX8o2pqcMzQ2zvA/1OiWBvCjj0kmqsqtPUWkWvVWjcSMMkkdDR1RK62TYOZBGHeYKvHAschsGgno8r0QjKM316m0eSRhnEBQ1Lm7Vy21v1/B4JMP0W5Pk728vd+Dn4gGYTEdS9KDTQEy2F2tGGuFskGx7yfYv8oroE7E8PU6XAlLfOsSPNB8OsA2d96jhSVYCF5OyU+egCw58obOawkFpmtOvhvkznNSs9lsbmZjUSV+z0uIR++vKoZCJcCf/CyQOE7eZEKwA1M4DU4Et4aSXVT7R6GmqXffOkWZHRyYPjU8Oh3e0UyxqRCAl4xe8KsHzUvyNhqBMKsD9I9tqkOlQ2xPehjrmyiXwHyXQX6F1TMdJ/dPdiIN+40BQsG+59P7OcmZ2BbtTl5hXWzWIRAEdY3ETaXY0RqIGBAXqgFS3YhStOVr+OnEMD8LZJSGKwAm2CiU34z/rD/aJAwo/QsJyyK/VidED+BJPJLC4iXYNxeCmcxdR2KLP2JYPx7o5rK1n5hpzKDKVBH8BA8qI2Tix7HJaWiEY9SF7Pk5DiabNVEPG7/bGMWwBH3wpAmT0YzPYHqT4SFw43FHSOnzRFKaubqFVmsDw+3dAiEAJK8GsIfgvdl702ttr6XRVUA7DtbgWg22TV40JjRf88yGYAqcnbG4wQAVThQRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(30864003)(478600001)(5660300002)(6486002)(966005)(2906002)(66946007)(66556008)(66476007)(38100700002)(31686004)(8936002)(7416002)(921005)(8676002)(2616005)(6666004)(6512007)(6506007)(36756003)(66574015)(186003)(86362001)(41300700001)(45080400002)(54906003)(6636002)(316002)(4326008)(31696002)(83380400001)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVMQjV5eFRZSTZKODJQd2FIRmVkdmRyVHFhV0ZWdjk1ZXl0djd1RG5WcWMv?=
 =?utf-8?B?Nk5iQXRROFVvaWNCYTlEVkM4Z2xoYWJNcExra2R5cEo3UGpmOFNyMi8wcXht?=
 =?utf-8?B?TDc0bjVLYjdYZVYxeUZtSVJGUGFDcXJ4cmZsNmlwaElOT2M5b3RDV3J4RGwx?=
 =?utf-8?B?SkRwdnpNMitoSW5jVkkydHducGMwUUY0ekpUVmJOVHFmblQ4UjNCamF6QnJj?=
 =?utf-8?B?K0d5endNRFpNZThrS2E1VUthSDE4blcwNlJ4T0tOK29IL3B1ZW9NUmdXcXd1?=
 =?utf-8?B?RGFiVDU3dk9EWWYybFQ2ays4TklQOFNzSmZSSlpkVjlON0pKNXRnc3pMS1pa?=
 =?utf-8?B?YVBnY1Y1MVJKTCtqbVM1MEZ6TTgyUzZ0VzBKRW9xZ1QyK25LM2xaNkhJbzNE?=
 =?utf-8?B?ZEJRdEhjZFhJbXljZHJjK3IyWGJRb1kzZjY4MkRIbC96dVNGSWQrSVEzRFZo?=
 =?utf-8?B?RzVDRGw0UmdqVlRKaStYL3Zob3pvVklGdkErSXJheWtIL1BPd2FKRjhGSUxj?=
 =?utf-8?B?VEU0c0dIa1RoZ2dBVGc1RVVOKzR2MlB1MzR2UTF0aTZabVJaUmt4czRjTjR2?=
 =?utf-8?B?aXpyRjZQdDQrcUtVQUliVXVvK1c1cEpCSEt5S3lZY1Z4cnJld0VrV1hhSncy?=
 =?utf-8?B?YTU4L28vbGJkaEVBZ2E4RUFJWVBBRjFCOFVmY0xyK0hTOFd1TW5GVzFRa1hJ?=
 =?utf-8?B?QU54TXRUUlRBRm0zSzNIU0ZCZW5tS053OGRLY2xMWDRYdE0zSUloZnZUUmdn?=
 =?utf-8?B?OHhkNndnVE5pR3p6VjZGRkh2b1Ywd1FudWhKb040UjE0dG9ndlNhWE82QzYw?=
 =?utf-8?B?RUlzU0hVU1JFbXE1SjYydHlobmplVkY2bWRGN1MreUpvbXpqWmZzaDB0bW9t?=
 =?utf-8?B?eE1JRFI2WDdTRVBXVm1HcldkU0wzcng3VS9vT0VLbkRPWEp3MTIrMVN0dmti?=
 =?utf-8?B?dmhBKytzRm5IREI3OEc4MlVlYmk0QW51TDhJZlVwVkxmK1FOdTlaOEYzUWls?=
 =?utf-8?B?SVJjOE41U2tGTldtMnNOWWQ2SWEwdGMvcnJ6RXVaQy9FTUxXNTdqNXl5TnpE?=
 =?utf-8?B?WlRnVTFTQmFBNXFmOXNSeUV3SmFDbmM3NU5senZIRWVjaTNYckRWZi93SVZS?=
 =?utf-8?B?Q2FyUjZmdHc3c2JlT0xlNmU5dHBaaHVVNEhUUVdiaWlMZTY3MUtCZ1pDYkNG?=
 =?utf-8?B?U0ZRM285cDAycU5sRmc1Y1FvT1hWbmxUR3Z6QXgvUFplUGUwUnExTEp0NDVX?=
 =?utf-8?B?cmV2c1djSkRDb25CSktSYWc2UjBGZ0YremY4MkVUS0d1WWJadUpnUXpYN2cy?=
 =?utf-8?B?R2lmMjdmeCt6RVBmRGgxTEl1OUdPWUFYZ2pNcm5Pd0s5NDBlSWN4MFFxRTZB?=
 =?utf-8?B?QkNtNEk0aVE5SE9wbkJqdTFiTitVcUpwTmEwWWh1Mzk5aGJtczFYeTBjRHpP?=
 =?utf-8?B?OFBHVFcyQ0VDV2hpNG5PUW12NVVIZG5ZOC9Pc3NkQ0xkQUF0b1I1Z1BOMmFn?=
 =?utf-8?B?bDh2SGQyMVhwTXVWOHR3VXZabDZjQjA3R3M0WHRKcWlrUWVMUUJZY0MyRHIy?=
 =?utf-8?B?UlZnbkg4bUJmQjlYYXhVZkhHeUF4S1RQR1I0R2YzYkZhY2UwMk1US2lxeVVH?=
 =?utf-8?B?cEs1aGxIZG5URzVYU0xDQVB4MzEyM3ZOalVnbmVOUVdhM1pySVVCdDJJbXgv?=
 =?utf-8?B?K2JGejI1NytqV2VlVStvME1IYXp4REk0TkpBMFlMN3lXVDN5NkRob3ZjdzVE?=
 =?utf-8?B?SnpQSnY3b3U4SzdhZTFHelJWOTgzR2gya3VjY1F6K0hYV3MyTzV1Q2pXK0pE?=
 =?utf-8?B?ZlJRc3VTQUdaSE9wMjI2SW1zK3RqTnJscW5QTXhJYlVLN1g0NVdubkMvSWNO?=
 =?utf-8?B?MmlQRFNNZjRVVytCYlp3SklVSjdiOEk3alZpZktKcTNSS1QrKzVIb1FFaFNs?=
 =?utf-8?B?MnBPN2UwK0tEWHkzT3pXOGo1K2Y2Mmord1ErVVpLUDQ0Q1Q3S0pJTCtxZHlk?=
 =?utf-8?B?VkFleDI2R1k4RXB6dUJ6Y09QemhJMVZHODh3MGYrRDhzQ09LSlJTcitUamhD?=
 =?utf-8?B?VC96UDl5SSszenAxNXk4akJxRjNnUGpCZWt1ME5WandrUEdMSlB4c0dUcUsx?=
 =?utf-8?B?dnVjZktaWmo1T2lHMyt0aUZuZ0luZEJIcVdLdVhrRmZNWEU0ekFSaHdDOGVV?=
 =?utf-8?Q?n/j2yD1cgg7Jx4PYlbyVLgGbfsBskLrfk3r/fP4P5xTT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2a312b-c421-4920-bcdb-08da7b8bc03b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 11:22:18.5126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfMd48kBBG5fU8YP5rjtMPC2+2OCBmCzoJxAZIMv0IEhwIi1oLSkhXVNh4FV8wYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com, mairacanal@riseup.net,
 kunit-dev@googlegroups.com, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 11.08.22 um 02:40 schrieb Tales Aparecida:
> Hello,
>
> This series is the consolidation of an RFC sent earlier this year [RFC]
> bringing unit testing to the AMDPGU driver. [gsoc]
>
> Our main goal is to bring unit testing to the AMD display driver; in
> particular, we'll focus on the Display Mode Library (DML) for DCN2.0,
> DMUB, and some of the DCE functions. This implementation intends to
> help developers to recognize bugs before they are merged into the
> mainline and also makes it possible for future code refactors of the
> AMD display driver.
>
> For the implementation of the tests, we decided to go with the Kernel
> Unit Testing Framework (KUnit). KUnit makes it possible to run test
> suites on kernel boot or load the tests as a module. It reports all test
> case results through a TAP (Test Anything Protocol) in the kernel log.
> Moreover, KUnit unifies the test structure and provides tools to
> simplify the testing for developers and CI systems.
>
> In regards to CI pipelines, we believe kunit_tool[kunit_tool] provides
> ease of use, but we are also working on integrating KUnit into IGT, for
> those already depending on the tool [igt_patch].
>
> We've chosen what we believe to be the simplest approach to integrate
> KUnit tests into amdgpu [kunit_static]. We took into consideration that
> this driver relies heavily on static functions with complex behavior
> which would benefit from unit testing, otherwise, black-box tested
> through public functions with dozens of arguments and sometimes high
> cyclomatic complexity. Further than that, this approach also helps
> beginners by avoiding the need to edit any Makefiles. Other approaches
> are available and we would gladly receive feedback on this matter.

Yeah, that approach immediately trigger goosebumps for me. We should 
absolutely not do that.

The static functions are subject to change and we shouldn't need to 
change the unit tests when only the internals change.

Instead black box testing and/or exposing tests as a separate module 
(e.g. for the fixed point calculations for example) is probably the way 
to go.

Just my thoughts on this, essentially our display team has to take a look.

Regards,
Christian.

>
> The first three patches add KUnit represent what we intend to do on the
> rest of the DML modules: systematic testing of the DML functions,
> especially mathematically complicated functions. Also, it shows how
> simple it is to add new tests to the DML.
>
> Among the tests, we highlight the dcn20_fpu_test, which, had it existed
> then, could catch the defects introduced to dcn20_fpu.c by
> 8861c27a6c [dcn20_bug] later fixed by 9ad5d02c2a [dcn20_fix].
>
> In this series, there's also an example of how unit tests can help avoid
> regressions and keeping track of changes in behavior.
>
> Applying this series on top of the amd-staging-drm-next (2305916dca04)
> and running its tests will result in a failure in the `dc_dmub_srv`
> test, you can verify that with:
>
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
> 		--kunitconfig=drivers/gpu/drm/amd/display/tests
>
> ```
> ...
> [20:19:00] # Subtest: populate_subvp_cmd_drr_info_test
> [20:19:00] # populate_subvp_cmd_drr_info_test: pass:0 fail:5 skip:0 total:5
> [20:19:00] not ok 1 - populate_subvp_cmd_drr_info_test
> [20:19:00] ======== [FAILED] populate_subvp_cmd_drr_info_test =========
> [20:19:00] # Subtest: dc_dmub_srv
> [20:19:00] 1..1
> [20:19:00] # Totals: pass:0 fail:5 skip:0 total:5
> [20:19:00] not ok 8 - dc_dmub_srv
> [20:19:00] =================== [FAILED] dc_dmub_srv ===================
> [20:19:00] ============================================================
> [20:19:00] Testing complete. Passed: 59, Failed: 5, Crashed: 0, Skipped: 0, Errors: 0
> ```
> Full output at: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fshare.riseup.net%2F%23SOggjANeLfbibdiHu2e_Ug&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kiaq3dfpSMiFGkMIXKHhHsMyr7o%2FuvKgny0ifF%2FzrmA%3D&amp;reserved=0
>
> This is due to a known regression introduced by commit 5da7f4134357
> ("drm/amd/display: fix 32 bit compilation errors in dc_dmub_srv.c")
> [dmub_bug], which resulted in the struct's members being zero.  As an
> exercise, you can revert the offending patch and run the tests again,
> but that would still result in failure, albeit with a different output.
>
> Full output when reverted: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fshare.riseup.net%2F%23EEBgtgXjAmof5vZ_qs7_sg&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2Flv%2FAOosByeD8vPteKdqGqv2QHf50S6nTNTqma91fm8%3D&amp;reserved=0
>
> This regression is currently being worked on [dmub_fix], and this
> test-series will result in a success if applied alongside the
> fix-series, particularly the patches 1-13/32.
>
> ```
> [17:48:14] Testing complete. Passed: 64, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> ```
> Full successful output: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fshare.riseup.net%2F%23migyN1Xpy3Gyq1it84HhNw&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=zMOuzPypnx6oH9rMUYZwLpHELZd%2FaId4Tdh93LRr8bM%3D&amp;reserved=0
>
> This series depends on a couple of Kunit patches already merged into
> torvalds/master, which themselves depends on older patches:
>
> commit 61695f8c5d51 ("kunit: split resource API from test.h into new resource.h")
> commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> commit cfc1d277891e ("module: Move all into module/")
> commit cdebea6968fa ("kunit: split resource API impl from test.c into new resource.c")
> commit cae56e1740f5 ("kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)")
> commit 1cdba21db2ca ("kunit: add ability to specify suite-level init and exit functions")
> commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
> commit 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> commit a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
> commit 1b11063d32d7 ("kunit: fix executor OOM error handling logic on non-UML")
> commit e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
> commit 94681e289bf5 ("kunit: executor: Fix a memory leak on failure in kunit_filter_tests")
>
> You can get a for branch ready for compilation at
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fisinyaaa%2Flinux%2F-%2Ftags%2Fintroduce-kunit-for-amd-v1&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=hqIFUFjM1UDOTXYsckuoLP9nyxAvlVB4iCMs8FWkGnc%3D&amp;reserved=0
>
> Thanks in advance for your time taking a look and sending any feedback!
>
> Best regards,
> Isabella Basso, Magali Lemes, Maíra Canal, and Tales Aparecida
>
> [RFC] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220608010709.272962-1-maira.canal%40usp.br%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=XEk%2FNJacxlhjCymXuo3tVQHle9MtiSCKIOXyP%2B4Pa3M%3D&amp;reserved=0
> [gsoc] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsummerofcode.withgoogle.com%2Fprograms%2F2022%2Forganizations%2Fxorg-foundation&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ZxjFnl5bjczfWxzpHOEKDU314QS4hmbIxTgvjPxqmJs%3D&amp;reserved=0
> [kunit_tool] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fdev-tools%2Fkunit%2Fkunit-tool.html&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0jUQGUFKW8BVVgpD4sNkkLdqMn23X1S67y7Fj0RqZKY%3D&amp;reserved=0
> [igt_patch] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Farchives%2Figt-dev%2F2022-June%2F042895.html&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JmOfrDfQIWohsDCg%2F1BLyFckeG1CWfmM3NPwcpE5WFQ%3D&amp;reserved=0
> [kunit_static] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.kernel.org%2Fdev-tools%2Fkunit%2Fusage.html%23testing-static-functions&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=IWA0KRuA1T3YCZIpq9JD8wTxE8gTZi%2B9aLJywU1Os4k%3D&amp;reserved=0
> [dcn20_bug] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220603185042.3408844-6-Rodrigo.Siqueira%40amd.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=b7B7QscRHX2STfVGRiE09RxYSvZTDLW59vi7lQTPrM0%3D&amp;reserved=0
> [dcn20_fix] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220608164856.1870594-1-sunpeng.li%40amd.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=yQR9AxoguAvVR%2BGni9GUhSdhgHKujcUXujFL30QZqAc%3D&amp;reserved=0
> [dmub_bug] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220708052650.1029150-1-alexander.deucher%40amd.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752284993982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=WUb4zaBIhOd8oAjmcn19itKTbulUFepGfAtY%2FWLmrq8%3D&amp;reserved=0
> [dmub_fix] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Famd-gfx%2F20220805175826.2992171-14-chiahsuan.chung%40amd.com%2FT%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cb44787cd3628425b078d08da7b3213c7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637957752285150231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Z4AWumNHtXuHo8h7%2Fh%2Bdd0VqBQeywtbaD35pCKs0neQ%3D&amp;reserved=0
>
> Isabella Basso (1):
>    drm/amd/display: Introduce Kunit tests to display_rq_dlg_calc_20
>
> Magali Lemes (1):
>    drm/amd/display: Introduce KUnit tests for dcn20_fpu
>
> Maíra Canal (5):
>    drm/amd/display: Introduce KUnit tests to the bw_fixed library
>    drm/amd/display: Introduce KUnit tests to the display_mode_vba library
>    drm/amd/display: Introduce KUnit to dcn20/display_mode_vba_20 library
>    drm/amd/display: Introduce KUnit tests to dc_dmub_srv library
>    Documentation/gpu: Add Display Core Unit Test documentation
>
> Tales Aparecida (1):
>    drm/amd/display: Introduce KUnit tests for fixed31_32 library
>
>   .../gpu/amdgpu/display/display-test.rst       |  73 ++
>   Documentation/gpu/amdgpu/display/index.rst    |   1 +
>   drivers/gpu/drm/amd/display/Kconfig           |  25 +
>   .../drm/amd/display/dc/basics/fixpt31_32.c    |   5 +
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
>   .../drm/amd/display/dc/dml/calcs/bw_fixed.c   |   3 +
>   .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +
>   .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
>   .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   4 +
>   .../drm/amd/display/dc/dml/display_mode_vba.c |   3 +
>   .../gpu/drm/amd/display/tests/.kunitconfig    |   7 +
>   .../dc/basics/dc_basics_fixpt31_32_test.c     | 232 ++++++
>   .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 +++++++
>   .../tests/dc/dml/calcs/bw_fixed_test.c        | 323 ++++++++
>   .../tests/dc/dml/dcn20/dcn20_fpu_test.c       | 560 +++++++++++++
>   .../dc/dml/dcn20/display_mode_vba_20_test.c   | 227 ++++++
>   .../dml/dcn20/display_rq_dlg_calc_20_test.c   | 112 +++
>   .../tests/dc/dml/display_mode_vba_test.c      | 741 ++++++++++++++++++
>   18 files changed, 2613 insertions(+)
>   create mode 100644 Documentation/gpu/amdgpu/display/display-test.rst
>   create mode 100644 drivers/gpu/drm/amd/display/tests/.kunitconfig
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_fixed_test.c
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn20_fpu_test.c
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_mode_vba_20_test.c
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c
>   create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/display_mode_vba_test.c
>
>
> base-commit: 2305916dca043ed69bd464f74a886b0216780aa6
> prerequisite-patch-id: 83185f6c5da6070e7b0b608bc705a2d3bf295ae6
> prerequisite-patch-id: 65407777e3bb20dfe5051f4f4cc7deb6a3c2ed34
> prerequisite-patch-id: 60af3dadcfd4a778f10dd09fafbde6061d98528b
> prerequisite-patch-id: 92d9259125f2982da5945be995b4ae2af1ca7c32
> prerequisite-patch-id: f35acb6c07c0bd5496df919214351399d9aed5b5
> prerequisite-patch-id: 8a9637d89966e51adfe11e3fd3d17fcf1328b472
> prerequisite-patch-id: ea6f40f1cfb61fddb9d1562111897e184da49bf7
> prerequisite-patch-id: ae79651ae7b2e02520b18fc7eded463afea757e5
> prerequisite-patch-id: ba795b981f3e94890540f452e658e28408b500d2
> prerequisite-patch-id: abd5e51f483a9afb08af468db043e2ebc7ce6867
> prerequisite-patch-id: a31028824a461f8b4a6b9244035e246efbee9c71
> prerequisite-patch-id: a65dfe200981f8584ba3b1f9813faa4f0022a13e

