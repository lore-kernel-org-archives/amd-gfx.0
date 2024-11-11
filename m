Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1D5D2E9D4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 10:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E3910E1DA;
	Mon, 11 Nov 2024 10:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLpsXPgm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F5110E1DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 10:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHG3VnJ3lSNpo2mfzGXwgvQhwjnVh7Z3i3dc8yX/Nr29Hop4MPLCkvBz7NLh3752uneksVxB0GQNOpCsh5ew2iUQk485Bol3dg142Gdqyqw+bVCzqilsipUwl7ulHH9lqS3fzVhlwcKKGY+rcQRy473Fw4vIOQF533xLllhaHkPNpKro7i/Ik6oy8ImSnobbRwgASKKHFw5Ug1FalYUKMjlxxf1f7Gt0t5SyfW5xK8wD++SZFFBomDaY2mtoO1/Ie6wk5d0GLbdQb4cGM4t0DulojezfOQGQXnel6MPA0POvoJAckDubYKz5PzHnHaUWX7qy1g9sfv6155rlHx4XHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArW7h/u8wRD/aCne4T8QkKOATPRrwEsxdPSzISYBmL4=;
 b=MN4sAzFJqNIF+Qvx9k63vHMgMkK3+c/xooPgNqd03NinzagKWeFIK2k9RO0PkyJ3iUgiYE7NTuSlpyGQlXT2+0M5jrfMIXb0g0Q3Dgaf5eddc6AF2Zu33UGU41Gml35JQlKeMFchP/vnN4HBNhM34RkeNHCyQmXqPoPeM5XU3sQtW4K+5a/LcbiJA4h+Pk9CkbIJEkhTKq4i2yK4jx6+mshgRhGL3Zg4tD7OD66MXIBrGWPSgro3bkVuwPJyhECjTR3znX6nnQ/IQZ8CUwdxNjF3V3EFjPdCxgGU9L4x56S3T6x5ndgVzeNepbQHwk2hp3Zov9hnneaBIMllZUg5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArW7h/u8wRD/aCne4T8QkKOATPRrwEsxdPSzISYBmL4=;
 b=lLpsXPgm28LVf1yzH3ijI0tUr+3HfnaaG/kCpyyCkLFSfOq3mj6O3uAsgJfpQljt8U6SMhfKMuBotLqpqRL+rYusHO3IpX9LlGL7Tt3oLWDXAerv+Vv8htU1whdy59HfZgMRS1ix7wbMUlanypDP1NR1aA1Vy0mrK+DqfiLixlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 10:03:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 10:03:25 +0000
Message-ID: <81849d7f-f1e9-4ace-af5a-7f36ab5f5c22@amd.com>
Date: Mon, 11 Nov 2024 11:03:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix UVD contiguous CS mapping problem
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, stable@vger.kernel.org
References: <20241111080524.353192-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241111080524.353192-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbaaaad-9f2b-471d-dc54-08dd023814f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGhWYzJKdWlsQjgzOEFxK3VCRXZBcFlyYkxDUXdDVHFmb0ZRZzhnUW9EYUlq?=
 =?utf-8?B?NmwwVjJmTFh2c0hjN3M3L0JaVU5hcENjb2w3THJObVo2RFh1d2ZZa1ptTlMr?=
 =?utf-8?B?a2tmTno5UHlIYTFUVFdURGZvWTQ5ZEdRWktrakxRZHN0NVNaaWczWHBQRTM4?=
 =?utf-8?B?cEtKbGFGWTA0VUhmUmVWbWtHNWFZQ0ZpV2hPK3JMN2VBeFMxS2pkLzhFQ05r?=
 =?utf-8?B?eUMxY1ZGRUZ4WnQvend1S0VZWFkvenBQeERGVTE3MXJrV2NpMlpsK3BsL2E0?=
 =?utf-8?B?Y3ovaFJZbkR6bWJmUytTUGRtOXY3SEhpakFROE1PTzc5QkozVGZDOGw4M0Rz?=
 =?utf-8?B?QURsL0NGRU90cEpyNlNMZmk1M0x0aU01MWhtdnhtUmdIbjNNVC9sZTN0d0Vx?=
 =?utf-8?B?TFlkZkFZQU15c0hVTml5QVVSRE1PMi91TkFPVFhaZHZxc3NCN0xhcHhkNW54?=
 =?utf-8?B?R0Q3NzRWQzhLLzF6LzVQUGRiNFE3RVBPWlYxb1dOd0FNanRHS3hMQWhzMTBh?=
 =?utf-8?B?dzlkcDcwakZnYXpCWmRWWjdZd1hXaGtQZnk3dUYyWWc4RGU3VkdjKzRRdjhi?=
 =?utf-8?B?Z29nQUhiTzhodmYrdWpGV09nSi9HMHB5bUlHNldJeHk4ZkdHN0kyc1RweWp5?=
 =?utf-8?B?MFB2bjlJdVVYSjNVV0lrUHlZQzh6bEZhWkZndTlNOXdVNTF4bk5FUmlOS1Bv?=
 =?utf-8?B?ejM5cjl1NS9tenZNek11ZG9XYXdsSi9Gd3lXYUJiMlBQVjJPcjVETklTbWRZ?=
 =?utf-8?B?T3dDU0tHY2ZkSk92bTRPdXNrN29lVzR4VHNsMmM1NGpLcE00NFZRc0tjZTNF?=
 =?utf-8?B?NHRVUHdYN0JUcnVqbVVWU01UZEVNWVdqSWFkUzR3aTBqUHhEWSsvZXJEdGlJ?=
 =?utf-8?B?RG9xcm9mUDM5WUY1Tk9DRUpmTzl0amE5L2wySzhCcjdORUE5dzlEdFhqOE9p?=
 =?utf-8?B?TVdYeG9GM0hITTRRd3pqb0pMcTlYQWNBU0x1bXBVM2NvbHlLb1MvdU1KWFQ5?=
 =?utf-8?B?SkdJdXFTWXFnT3JYZUUwbzFhWkJGZ3FtVU1xYWhkbytIbXI2Znd4M1ZJczFU?=
 =?utf-8?B?b29BTnBMTHUrbVVrU3BXR0xISFAxWkp4WTBOTWVhU040bmZ6d2dGdWNRem1U?=
 =?utf-8?B?YkhZSEtYcGlQYk53cGtybjVFaWNENE0vQXRQMklON1hrODNwWWgwdGJqTkdz?=
 =?utf-8?B?WGhhNTJEMGh1Z0VIUGJqTDRyYkU3S3NYanFid2pZUUFSQjJoKzRFdEQ0ZlJO?=
 =?utf-8?B?d1JCUVZuV29DU29NZFpYd0ZFaWlhRnNJNjZoWjRWOFNCSllsTUdIeFJMTWtx?=
 =?utf-8?B?RGZ6SXRiOWNpYnhySTBTNTg5Njc0L2NhUll4Z01iTlhxV21PSTA1OE14Ymc4?=
 =?utf-8?B?dVJpRmEwTExYOGp2SDQ1SHVxblJJS0dlalR6bWdHRmRDMVA1M2IwT1VCQ1Nm?=
 =?utf-8?B?YUVYWVVRRkl3VVREWmVPUmdnVTFCekxmWnM3NXlwei9CL2tnOGhKTVkvMk45?=
 =?utf-8?B?R3hZNjZveVNBQkc2ODZKcVIvM0FQWmIrbzB3dGZUeStuamdCSVE2ZWVIQXho?=
 =?utf-8?B?dDFNOXlwNmZXbmVOYk9VN1RVNDRXRUIrT0dOTUswUml5YS9lbkFvd0tsaHlI?=
 =?utf-8?B?c3VlanNyYkFhTk15SXZWZlVDWG5Gd281eitsdmR4REE2enFHZVBQdHBjWHZl?=
 =?utf-8?B?Z0lGRjRHSTZ5TWZIcE9qWTBlQ0x0V05ZVEJ0VTVINDVjYVBDTmJFbU1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmpHYkJpK0dINnlpNlRYKzJVdk9VOEs0Zk5ORkhsU3F1VUlSaEhiMWdiWmVG?=
 =?utf-8?B?bWNrZnE4R0hDNU5LeU12RkNCcU03TDNFOE8veFB4SlhaYWNrL3RPSVhXM0xt?=
 =?utf-8?B?Z2l6bDNjMG5sY1M4eTY4bEt5dnhwbVpQWmkvOWNtMDVjNE04WHM4MkZBc2lT?=
 =?utf-8?B?bTVNRlZQeElqRUwzbEcvMHdVNTdNeHoxbGViN3F6cVNaZDNybXNFR2o3QkpN?=
 =?utf-8?B?RFphTkJpNzVIc0VPUVJmc2NmMllQa0ZDaWFxbDVFeHBFOUFiWENPUmdDU2NY?=
 =?utf-8?B?dVl1ZFZBVXh2QnpSZGR5WWdLOUJZM3EycGpFRDJQYjdFaFhLaG4veDdaeVBH?=
 =?utf-8?B?a3JGelFLM1VWS1hvY09EcXk4N0R6TEU4bHFjMUJ2NktaeTRqRmJpM0pJREpJ?=
 =?utf-8?B?c0VkajFHVlVVaEtDaTYrVzM3dEFPU2QwMzd2bGJoQjhxMlhJeDNLeWR2V2Fl?=
 =?utf-8?B?aXFLRmpvMFVJb25WUUI5R0Zsa2wwbjVLelJKU0dpemhWb1BCZGc1NEhVMUE1?=
 =?utf-8?B?Z0FKQXBhbnJZOVYvejNVZDRiVEUrYlJpTFk5UmRwZk1ZOExkclFoaWg3Skdv?=
 =?utf-8?B?OU1GSk0rS1hHVzFtazdPT3lRWDFIbzRRNTA1YTFuWHNKL1pYeXhYSCtlMXRm?=
 =?utf-8?B?d1VmSGh0NjVxeFVjWEpyWmxjRzN0UEZ4L0F5aHBPRzRzM0YzYm0yejJrdTc1?=
 =?utf-8?B?L0lldE0zQkprdmdIUmdGYWdPME1SVDl2cEZ6eTVpeCtrRG5xdGZLSkVTMm56?=
 =?utf-8?B?UTArTHFHeTM4UEt5dUlSQlVNNW5GVDZEY1VFM0g4UWJBTUg2Q1ljRlR3UlJ0?=
 =?utf-8?B?ZUJzSlpKUFlkaXRKUitMeW0vQStBQmhvUVRHNlRra2N6T3dybDBLaWQ1Z3lq?=
 =?utf-8?B?cVpxY3Y5alVNRGIvaWZjeFJ1ODI3SGhUL2JnbERkM2VDUTVzTDlBWnJmMFJu?=
 =?utf-8?B?OC9YS0ltQW1Ma1gvM2tneno5NGxxUFlYTkpBbHVGcWRQWDYzY2Q1cDd2bks2?=
 =?utf-8?B?a2JOTDJkaFVZVFpsSk54Q1FzYSt2Zmh4VlMyaHZiUUxqRVArK3Jqd2JkeG1Y?=
 =?utf-8?B?NzY1S0pORXFTaVBIQXhHa1ZVclphSWVwazNPTmVBK1FHZE1JR2JHQWlreU9s?=
 =?utf-8?B?UW9lREJOZis5ZElxd1Zhd2U4KzdDbFF2bUlpVkVsS2pkbnBjQW0xekhad0dK?=
 =?utf-8?B?cWJtak9zbVJFZzRvMVJoZnlxb25YWTNCN3VEZFdFekVpYVdTd1FEczlsUmRu?=
 =?utf-8?B?WWJCWUltRDkrS1BIc0YwdXQxZTMrZFQxdjFRYzRaOG9kVzlxbkdudzYxVCt2?=
 =?utf-8?B?WW5UeCtZNzZFbERwWkg1Q20vYmJMLzNRQmprTlZWUUlEZUJvZ0ZNbloyYWxj?=
 =?utf-8?B?MytxMWVsaFhiUjUvVFR1d25JTG9wcDlVb1Z2RVFPNW9yaVRBaUlxaFQ0OFFW?=
 =?utf-8?B?WjVEMnFPMk95T3BIbEdodXZ5WlpZRjdyRjJYYjhGdEpzYVBmSm5kQzIzMGJu?=
 =?utf-8?B?M2N4OXA3UmY3eXRWNGM4SkFYbnZMb3dqOVFZbTNyNVVESmRQZGNFVUdOV1M5?=
 =?utf-8?B?NjhTTG1YSHhWVnFhYXBCWDUxUXk4TjNPZ0czdUpjak8rMDdoTzZiSjJ5czVs?=
 =?utf-8?B?Uzk3SlpoU0JUYjdTTmdlNVJlcWRkZFU2UUcybThpRTB1ZDVvYlFFYWIxczk2?=
 =?utf-8?B?a2xNdW9YTFozL3RZZjJKSmIyeGxEYXdCQnJXc2I5QUxkak1nRWFuY2xvazho?=
 =?utf-8?B?TENTU1o3MDcvVmpBR0Nxb3F4ei9aQmhzTjNCckdQRzZyeTF2MjdhTk9TTHhL?=
 =?utf-8?B?MW11YTAvQUhSckhoWkZ1dVluREFhOWg0aGNYOW5Pc2swTG9CYi9rTWRCaVJK?=
 =?utf-8?B?QlZzZmlzSk9rTFZkMGdhaHovNHY2MVY4K0lJbTZ0RjdMZllMMG1rN3BaVlN0?=
 =?utf-8?B?a2lqdUJpay9tN3dvVnNlK1E3WGNiSDUreHpZYWJHK0ZkMVJ1bjd2MjJLcXJs?=
 =?utf-8?B?UHFDTE9XNUQxRGEvV005TTk1Q05yMjhRd2dOc2xSelVQK1pCY3hGNy9Pa1pJ?=
 =?utf-8?B?TndXWUpmcENURzZBM083cURGVDk4V1Q2T29kZWNvK1Q1SDgzL0xxbWNhK2Fo?=
 =?utf-8?Q?jLJU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbaaaad-9f2b-471d-dc54-08dd023814f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 10:03:25.2212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW2oUY+PZrNws4X24MtzDRsXmWMQoIeTRvA0CHay02Bjm5q5rkTspZ5xcdsmbXT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

Am 11.11.24 um 09:05 schrieb Arunpravin Paneer Selvam:
> When starting the mpv player, Radeon R9 users are observing
> the below error in dmesg.
>
> [drm:amdgpu_uvd_cs_pass2 [amdgpu]]
> *ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!
>
> The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
> flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.
>
> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d891ab779ca7..9f73f821054b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1801,13 +1801,17 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>   	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
>   		return -EINVAL;
>   
> -	(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
> -	for (i = 0; i < (*bo)->placement.num_placement; i++)
> -		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
> -	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
> -	if (r)
> -		return r;
> +	if ((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
> +		(*bo)->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;

That is a pretty clearly broken approach. (*bo)->placements[0].flags is 
just used temporary between the call to 
amdgpu_bo_placement_from_domain() and ttm_bo_validate().

So setting the TTM_PL_FLAG_CONTIGUOUS here is certainly not correct. Why 
is that necessary?

Regards,
Christian.

> +	} else {
> +		(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
> +		for (i = 0; i < (*bo)->placement.num_placement; i++)
> +			(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
> +		if (r)
> +			return r;
> +	}
>   
>   	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>   }

