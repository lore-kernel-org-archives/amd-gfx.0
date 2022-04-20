Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1371C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 18:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5391A10E2B5;
	Wed, 20 Apr 2022 18:41:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC3510E2B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 18:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCjI/9/zdGknfYD/a5BdbdAhtJ7Gnhsi1zy/NTGZkbSAuCZxwZxfDxi/eaOoWtXro0bfF0pK7lbtmFlVnu1HgmmWzBIZ2Eu9NBFth8xvn0GZCSZm5I2IxqEwUUx+Fsz824ywkOF72DuT0CRQfpJNK4tY8A3A7RuUPfXaq7oO2i3cHKwHuL3eaJg+K3bZN5F2ac75Z8z/Nu5AT17bImlFtMrfS5UBAJtBfXTYVkQ8iMviwe8PPMBkGFjlBUWJnNv7MyjU20mWTqbWqUjSp3ZlJamAT4+EPyL9FWIxHcGsvfqVr0zVghGDhyiaxD4kgXgQNh2QXi9tersCrUoVadiKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYcK2l/oFWXq9BqantJ2GXWK+kvB16ii+KoPnECzH1s=;
 b=Scw8tsBt0dAEDUQM8EjuXA/Ebn95UpYbApxTqN7I1hEtKPS+rpCs2n6BEWp62FuqkBseQR+IpWN/evg/vY4U1asAOssLXciCYJ01kQTSNJ/32CAu2+QOXnxjS2r7iJOKsIMXz6gVGt7JS6rqtW89LZPOSflu2Fw7/1bsYh8kP54mSHk3eG7w3CBySp91wY2PN7cbKgONtI/EZ1mfkL6I2QXaXT0gm4+g+pOKT8SsOwt1xdpF9TfmULRMdwO+N8/COXpesVzaaol6Tdbs/p9Jo17rarhqRst9sGf1fCEZhM6ZeJkbavCO4w3rd54upfKHSKT6amowGeXW4asDM75yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYcK2l/oFWXq9BqantJ2GXWK+kvB16ii+KoPnECzH1s=;
 b=Y3F+O83OsECLcjklQutShppD1z7uCdanBcJCOVhz1mUuT6jd2aJQgzhrSysnx+5doIZIDQ5rVDN17WFt5dc0mZJk1DpeK510agWiunGS1/KhOI0pT4+RA8b0EEbhV4x9CZMTPthNBkJl5xU5b2GNxBkUuJHEpstaJECEybz2BLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 18:41:43 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 18:41:43 +0000
Content-Type: multipart/alternative;
 boundary="------------Nv37bljtfNIt7WmU9pkIsUiB"
Message-ID: <0d99be40-f6b9-b191-feca-d74344f03bf2@amd.com>
Date: Wed, 20 Apr 2022 14:41:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
In-Reply-To: <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8df018f7-e682-424a-e082-08da22fd6a83
X-MS-TrafficTypeDiagnostic: MN2PR12MB4032:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40325FEF7DD626F3E6E533FAEAF59@MN2PR12MB4032.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBjwJsNbHhswOQRann76BoZqojANE2qQUz3Utwl5nUa8WkqHH9dgZb5ufATWw/w5Z++IMSIEbEZIXxSXXQVKlwngZflSP2gFFvcIrWkb8OkJvAI18imlifEixzUliyfiWb0GQitUhXQrHH1qh7FjGd09W5Vd44EfIP50ZKdIVwINFTZirVKq9PNIZPJ9TGRTftAJ8VOnZaAGWJLL4BUrR9kpneuVzzQIgncLN28VqaSpB6UJGDSnqhaXDh3Y2aKsSFSFLiOtTadjuVRUrpq7d9FiEXlrYgYeH6oQCToQLlpqtNT4co2J9axsFRQV55PgN8STiSPqbMqFC0Ol5g41IFMdVN+pVpAsky4quca/BO/6ee+NKuIscw165pGxLgKDbsPKNBqUktk26TawvVXtAOp1kQ0vHSAKktfIFP6GVnH34mkTXN5Xt4ttL0h63fNlgAL91PX5v4ISrRxIDKak2SoZpPRg2Fbe+EdWzmhb6y7pEIM8fBz4m9CIaJSMYgOjruujm6MbVTOPlwl+4kfsOUThmcACGtgvdJflKIwgb2R8b6ttNiNNqdqBxS+P3zVQUGiyQThZb8w6yGy1q729PvS4eiiaoLSeRqs5pZrQ/9hgiFvGZoA4+VJSZOC+fKe2RP0c5ezMJ4puj+6Iy+c37eildf8Kr7fJOLTK56hOOebqDw+EkBGSMj55iUQZ0tPLcbvzEojdAWYUfRwWeX1kEbfMj4HjT26U1rO9HcsXbnE0IgXXNwgfZUfBneCJcIu045E5sV6LXj11FapUIiQX+zaz7cr1/OJQoNbbTab0GkWtuiFpibZczs4ZrV+RNK/J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(2616005)(8936002)(44832011)(166002)(186003)(38100700002)(5660300002)(2906002)(6512007)(31696002)(316002)(6506007)(508600001)(33964004)(53546011)(8676002)(54906003)(66946007)(66556008)(4326008)(966005)(6486002)(6916009)(66476007)(31686004)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJxeUd2Ym5tRml1eTJYQktQUVV2aEh6N3dFWm1sZVpHYzVFWVR1MDNRUk9Y?=
 =?utf-8?B?NmE4d1ZwZzVVK2szY2pjbjhUVGhVS1djbGFyeENJNmh3Mm9DWEFTcFA0Nk0v?=
 =?utf-8?B?V3JnbXUyRktidngzV0Z3bUJxaGUwV0UxWFg2UTd4UThHUGl5WmF3VjZuYzB3?=
 =?utf-8?B?bUdvc1Q4SUdjOWkzbmRFM0QwRWdBTWljcWQ3NjZBVEdXL1BOY2N1V2l6RVJi?=
 =?utf-8?B?bnNtallmUk5FdXh1SGR6cXFSTTZwMVRyUlpGM08zWEZwWEVDamgwNXNkb2hh?=
 =?utf-8?B?ZHo2OEhyY1grTGJIckt0TC83eWd1ZzFXS0s5enN3blFsbEpTTXZBWFlqQzFj?=
 =?utf-8?B?QnZFd2poOFhld2xZZmI3WVpZMUNuclkzZ2Z1L1dKbkUwdUdYTDhwRTkwSWtZ?=
 =?utf-8?B?SW5kLzhRdDJrK2JaanMrTlYwZW5jMHdTc0Jkb29SVHY0YW9Xck50UDNFL2FJ?=
 =?utf-8?B?Qm9iNzVIajh2NlRacGJMbmZoNklVN3lvVUtDM0poU203MWNKeDFLM3M3bTJr?=
 =?utf-8?B?OEdtVXA4bHN6VVhkbzlyU2Nkb1pZb1ZZZUsxdVdyZGljZWFIcldPYkFxTnZh?=
 =?utf-8?B?ZkoybCtDUS9MSXZsdW81SFhaMUJUVmNUYnVSZXhjTTlRenVHNUZLMnBjb1Bs?=
 =?utf-8?B?a1ozQVNyL0ViZUpUWm44aWoxcEZvSzhsSWZXeHRCUEZITi9rdEsrdGtQRENR?=
 =?utf-8?B?enpiRDlDZGdXc1BIc1d1OHFXNlhxWURxVWUremtYN0lBcUhvUUxWckRWTzNR?=
 =?utf-8?B?V0k0QVNzaFMxdmU5dlJHbWlUemJVb3k3c3pLNGQvYU1VVDR6MzNwWEo2SFhW?=
 =?utf-8?B?cTF5MWpsb0VZOXlid252WEh6VUkraEhvRGlCYzJSUURacEs1eFZUTjBvNGYx?=
 =?utf-8?B?NnEwckRudW9sdTRWRkQ1RVgrUmxqRnN4bHF6ZzNiQUx4S0ZPMStlbFRqRmx1?=
 =?utf-8?B?SlVYR0tlWU8vdmN6RDcza0thdStqckVKdkJZV0pFZGIxcTNZTWR5c3AwTWhu?=
 =?utf-8?B?VnAvT0JhMW1sSXh4UkxoV2g5SFEyM3Q4VDY2cTZVSVh3U1V4QkxXRWF6RG9n?=
 =?utf-8?B?YU4vS1hLN1VFMFdDeXJqY2F1TWxxWW1sa29CRlJsS0k0UEhTRmtLeDZsT05y?=
 =?utf-8?B?ZTd5YjlQeWpYWjhObitkQ0hlemtVYk5CQmMwdi9yTnpGVWQxYVBabVFaNjNa?=
 =?utf-8?B?V0lDOWF3R04yY1lCbnFDcTljalR4QktCWklWTWdMRlJkTkRYZW9waDQyeWZz?=
 =?utf-8?B?Tm9RY0JsUE9sMFo1djcxUUJYWTRielZxKzAvSUVOUGw2RklOSUxaRGZ2WHZB?=
 =?utf-8?B?V3lsNVVlakRQRG8yM1RMRTdjTkhGZGl3dU5ML2hObU9JSHZuRFFhbkRxVWNs?=
 =?utf-8?B?bEdDKzEwRjRGUWE1NTlsY25LOU5HYVJya0pTZ0NDNHgwQXNESHkwRUZHV3ZY?=
 =?utf-8?B?R0dncDNWSndnS0x6NjZqaEVjSEJpSy9KVkdRRG0rNXUzVjRTa2dyWnRESnAv?=
 =?utf-8?B?ZFU2NFVaaUlWcDd3UUhQUmNzYkp0YkJTSlJvK1RORTJ1bmU4K1VYNFRlQU5l?=
 =?utf-8?B?QTRydkUyWTNvNGxLZEFmY3VrUGNmN0ppb28wbGZGS3lqQnhpOFNvdXhtR05E?=
 =?utf-8?B?MG5lTmVzdzNOQjNMNEVWZzVTcDBML1I5aTIvL3VGd1hTdzdwWXVEendlb25k?=
 =?utf-8?B?Q3EydHdhWm50TXBKdHF4TTQ2RHpGdGNyTkc5czZ0Qnk3RUdERElJWEVCWER6?=
 =?utf-8?B?NXVzTVpzUi9Zc0lYQXExU21abzd2L2pPakhqUTJvR0c2dDRkYTJuVk9DY1Qy?=
 =?utf-8?B?QWxzRTlqRWZQZWRCTHF3a082a01JazNmTXJlR0tmTWhjL2hCQ0pCMkpxdHdC?=
 =?utf-8?B?VVMxRkhVM0FLdkVmY09OZnpEVFJDbEtkNElhQ1ZqbUo1TWZTMWFaVHF2d20y?=
 =?utf-8?B?cGxMbldTczhDVDcvR3BmSEV3NDBCYVc0dnJnSURGZXFCeUpvbi9WUkNFOTFX?=
 =?utf-8?B?QTdKVmZDRC9XVUJoZGVSNVZOUlpkOVlzb1c1NUJMMUx4SDNwMHlMUzJxSnNs?=
 =?utf-8?B?YjNmUE01d3FYQ2RhSUFqUVJneU9mbnpYTTRDK05jcVQ1OC9CelRkbHN0K0VE?=
 =?utf-8?B?VHFGTkJ0cXQ3cm1rSTdyNzdNZkQrTVVIckI5ZERWMVRTSUtiQzhjVi9STWow?=
 =?utf-8?B?SDhQalBuV2NVd0RKdExZZXZpVGpleXJOVXdLOVZ1dnNWd0d5aHo0Tmd1QTV4?=
 =?utf-8?B?aytpNE5hNmZDbktHaXlSQk5uaHh0a3AvM2NjVHNpcmNhcmtzYTMrZTloNW1H?=
 =?utf-8?B?VmRoRmNzby9RZDlKWUdkVmszN3dHeTd5QnpRNXM1bzhmWGVzaHJ1Y2dsb3Yv?=
 =?utf-8?Q?axJEUEZHP6wQHVqk8WUNC1Olbnvo7NODtI47THuMdfCV4?=
X-MS-Exchange-AntiSpam-MessageData-1: rnmeNtUVbxn3fw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df018f7-e682-424a-e082-08da22fd6a83
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 18:41:43.7475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fskKvp1FBnjbnY0fvvK8r0di4023K2wVwvG1yc+kxq0VSUeW4nC7dJNboXVhGxvk7T/4BNaj8+HM71wbK2Z1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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

--------------Nv37bljtfNIt7WmU9pkIsUiB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I retested hot plug tests at the commit I mentioned bellow - looks ok, 
my ASIC is Navi 10, I also tested using Vega 10 and older Polaris ASICs 
(whatever i had at home at the time). It's possible there are extra 
issues in ASICs like ur which I didn't cover during tests.

andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test -s 13
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory


The ASIC NOT support UVD, suite disabled
/usr/local/share/libdrm/amdgpu.ids: No such file or directory


The ASIC NOT support VCE, suite disabled
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory


The ASIC NOT support UVD ENC, suite disabled.
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory


Don't support TMZ (trust memory zone), security suite disabled
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
/usr/local/share/libdrm/amdgpu.ids: No such file or directory
Peer device is not opened or has ASIC not supported by the suite, skip 
all Peer to Peer tests.


      CUnit - A unit testing framework for C - Version 2.1-3
http://cunit.sourceforge.net/


*Suite: Hotunplug Tests**
**  Test: Unplug card and rescan the bus to plug it back 
.../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
**passed**
**  Test: Same as first test but with command submission 
.../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
**passed**
**  Test: Unplug with exported bo .../usr/local/share/libdrm/amdgpu.ids: 
No such file or directory**
**passed*

Run Summary:    Type  Total    Ran Passed Failed Inactive
               suites     14      1    n/a      0        0
                tests     71      3      3      0        1
              asserts     21     21     21      0      n/a

Elapsed time =    9.195 seconds


Andrey

On 2022-04-20 11:44, Andrey Grodzovsky wrote:
>
> The only one in Radeon 7 I see is the same sysfs crash we already 
> fixed so you can use the same fix. The MI 200 issue i haven't seen yet 
> but I also haven't tested MI200 so never saw it before. Need to test 
> when i get the time.
>
> So try that fix with Radeon 7 again to see if you pass the tests (the 
> warnings should all be minor issues).
>
> Andrey
>
>
> On 2022-04-20 05:24, Shuotao Xu wrote:
>>>
>>> That a problem, latest working baseline I tested and confirmed 
>>> passing hotplug tests is this branch and commit 
>>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6 
>>> which is amd-staging-drm-next. 5.14 was the branch we ups-reamed the 
>>> hotplug code but it had a lot of regressions over time due to new 
>>> changes (that why I added the hotplug test to try and catch them 
>>> early). It would be best to run this branch on mi-100 so we have a 
>>> clean baseline and only after confirming  this particular branch 
>>> from this commits passes libdrm tests only then start adding the KFD 
>>> specific addons. Another option if you can't work with MI-100 and 
>>> this branch is to try a different ASIC that does work with this 
>>> branch (if possible).
>>>
>>> Andrey
>>>
>> OK I tried both this commit and the HEAD of and-staging-drm-next on 
>> two GPUs( MI100 and Radeon VII) both did not pass hotplugout libdrm 
>> test. I might be able to gain access to MI200, but I suspect it would 
>> work.
>>
>> I copied the complete dmesgs as follows. I highlighted the OOPSES for 
>> you.
>>
>> Radeon VII:
--------------Nv37bljtfNIt7WmU9pkIsUiB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I retested hot plug tests at the commit I mentioned bellow -
      looks ok, my ASIC is Navi 10, I also tested using Vega 10 and
      older Polaris ASICs (whatever i had at home at the time). It's
      possible there are extra issues in ASICs like ur which I didn't
      cover during tests. <br>
    </p>
    <p>andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test
      -s 13<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      <br>
      <br>
      The ASIC NOT support UVD, suite disabled<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      <br>
      <br>
      The ASIC NOT support VCE, suite disabled<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      <br>
      <br>
      The ASIC NOT support UVD ENC, suite disabled.<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      <br>
      <br>
      Don't support TMZ (trust memory zone), security suite disabled<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      /usr/local/share/libdrm/amdgpu.ids: No such file or directory<br>
      Peer device is not opened or has ASIC not supported by the suite,
      skip all Peer to Peer tests.<br>
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp; CUnit - A unit testing framework for C - Version 2.1-3<br>
      &nbsp;&nbsp;&nbsp;&nbsp; <a class="moz-txt-link-freetext" href="http://cunit.sourceforge.net/">http://cunit.sourceforge.net/</a><br>
      <br>
      <br>
      <b>Suite: Hotunplug Tests</b><b><br>
      </b><b>&nbsp; Test: Unplug card and rescan the bus to plug it back
        .../usr/local/share/libdrm/amdgpu.ids: No such file or directory</b><b><br>
      </b><b>passed</b><b><br>
      </b><b>&nbsp; Test: Same as first test but with command submission
        .../usr/local/share/libdrm/amdgpu.ids: No such file or directory</b><b><br>
      </b><b>passed</b><b><br>
      </b><b>&nbsp; Test: Unplug with exported bo
        .../usr/local/share/libdrm/amdgpu.ids: No such file or directory</b><b><br>
      </b><b>passed</b><br>
      <br>
      Run Summary:&nbsp;&nbsp;&nbsp; Type&nbsp; Total&nbsp;&nbsp;&nbsp; Ran Passed Failed Inactive<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suites&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; n/a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tests&nbsp;&nbsp;&nbsp;&nbsp; 71&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asserts&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a<br>
      <br>
      Elapsed time =&nbsp;&nbsp;&nbsp; 9.195 seconds<br>
    </p>
    <p><br>
    </p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-20 11:44, Andrey Grodzovsky
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com">
      
      <p>The only one in Radeon 7 I see is the same sysfs crash we
        already fixed so you can use the same fix. The MI 200 issue i
        haven't seen yet but I also haven't tested MI200 so never saw it
        before. Need to test when i get the time. <br>
      </p>
      <p>So try that fix with Radeon 7 again to see if you pass the
        tests (the warnings should all be minor issues).</p>
      <p>Andrey</p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2022-04-20 05:24, Shuotao Xu
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:549246A3-B326-47CC-92FD-608708E1876B@microsoft.com">
        <div>
          <blockquote type="cite" class="">
            <div class="">
              <div class="">
                <p class="">That a problem, latest working baseline I
                  tested and confirmed passing hotplug tests is this
                  branch and commit <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C39356160279b44accbe208da22af9c6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637860435039102940%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Lz7qOj8b%2BQ%2BI8XmC016E7M%2B7c7v6WHlRsMaynDUAL0o%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6" shash="aQsDnBBx+4wVN7dIUr4Ib91c16nNH4kHfx1IPv2d+8MyW5GFeo2j0+YcklqfAtyO82rJfGn0Sz11kc4IrTFF7Kb8E+okwybryejcAdvHmEzKeIspr9c5HDusNm/aejWGuhgbkBJD1eJrwEdZewgbPcvOh9jw4UV5jNl9d+7uNj8=" moz-do-not-send="true">
https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6</a>
                  which is amd-staging-drm-next. 5.14 was the branch we
                  ups-reamed the hotplug code but it had a lot of
                  regressions over time due to new changes (that why I
                  added the hotplug test to try and catch them early).
                  It would be best to run this branch on mi-100 so we
                  have a clean baseline and only after confirming&nbsp; this
                  particular branch from this commits passes libdrm
                  tests only then start adding the KFD specific addons.
                  Another option if you can't work with MI-100 and this
                  branch is to try a different ASIC that does work with
                  this branch (if possible).</p>
                <p class="">Andrey<br class="">
                </p>
              </div>
            </div>
          </blockquote>
          OK I tried both this commit and the HEAD of
          and-staging-drm-next on two GPUs( MI100 and Radeon VII) both
          did not pass hotplugout libdrm test. I might be able to gain
          access to MI200, but I suspect it would work.&nbsp;</div>
        <div><br class="">
        </div>
        <div>I copied the complete dmesgs as follows. I highlighted the
          OOPSES for you.</div>
        <div><br class="">
        </div>
        <div><span style="background-color: rgb(255, 38, 0);" class="">Radeon
            VII:</span></div>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Nv37bljtfNIt7WmU9pkIsUiB--
