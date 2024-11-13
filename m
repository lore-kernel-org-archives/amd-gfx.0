Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA8D41C22
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 09:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4FF10E6B8;
	Wed, 13 Nov 2024 09:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UdPgIu5Q";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5D410E6B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 09:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbjzgNcQE+1Uy0RjLQMZWtzIZ+rfqlclEHCB7ejpKGfzhmR+vpsgsknFjdUHdFnFIUWAw/YUUqObcu5PsWkZRB9vcAmxeebHE1n8lu0SK0rT+p5iDlCuFVitlQb3bN5JskMeGUZpxaYkNRGhuRr98QSvrA2rX4HXJzfUSz1Q7kbdKa3IaO/W6sA52QAjVZlzDamZgo6EXNo981fYFtRTtHJpuW+Pnh8iJag7eTkOw24gzMSO2H/Ka+QMwEfsZRqjlUyvQbx0WQ9I7d+/GLadToc/WMxBuTfjhO7lsnBi6Y4qLWkAy+w4RkrZh/VPe5SqWEakv6e5B1ff2qR4Ph45ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39sJs9G9o0Pua3yvptm3daCmO0GJDAxwS4H4pVhERWA=;
 b=UZnIeN+tiW99me70LqxwV9A4h94Kxq1AQdeMyzUXBsgiIbU2onoRu97ixbhVomiX4XI8r+glyo175Xich4we6CI+OyDxl9t+mvokH+AjFmWI/r34Xa+iGuyDYAdPTkr0X6Bvja7KdW6N9FyhN51HAa+0RODjmXmnyAYhjgmD6vsWg6t7V/yYBHpvyYGViyMkhqv1CpTiArzzezCx04cCc6wxW5hId458GtpOKYBCUrreQKK3RWpjoH/1GekWnZHW1Xtxm6pB6MG+TkhVTVfjvFNwdgNxynMhIGKW4ZqCPxV6hPwM7CPUnGz0lXd+eoTrLDbyD30vdeVk0YkmqvRGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39sJs9G9o0Pua3yvptm3daCmO0GJDAxwS4H4pVhERWA=;
 b=UdPgIu5Q2XEIDjn0EOLqTASFkiNzdIAtHtZwjOfSyj5rs+9C2OzCf4jM7CTtsW8cwsS3BN/WfT7l//YBeZ4CcdcAHFRk0q9Lyu8BPGZHzff4+DIKd6IAj1ZmrikuGdypjwueAMurHHfUMZK1Lgs84CelCr14G4O+/kwTlINDDyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 09:22:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 09:22:48 +0000
Content-Type: multipart/alternative;
 boundary="------------PTdV000k05ZmrbDOcpPB0NBV"
Message-ID: <61c40d46-1bf2-4341-a3b8-fb573ee098c3@amd.com>
Date: Wed, 13 Nov 2024 10:22:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check pending job finished or not to identify
 has bad job
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>
References: <20241113031411.698366-1-shikang.fan@amd.com>
 <SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2@SA1PR12MB7343.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2@SA1PR12MB7343.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: acaf962c-6689-49a1-ae15-08dd03c4bd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3hpaXRrVmxFb2NoREFxc2dYR1RVMHNvMFloUFBFTjBsMGdMcktJYkkwZGtZ?=
 =?utf-8?B?U0RIVHRGMTN1RVQ1Q0FOOENKTG5FNFEwUDVGR0c2cjd6TFlxMUtFZDZzTVN5?=
 =?utf-8?B?ak5ONEpSTTRBQlc4ZjVqM0hvT0tLVTZIK0ZET3pqT3lRanhHUWV0T2NWaWJM?=
 =?utf-8?B?SlMrL3dWbllpaE9lK1ZaTjdiV2lSTGZKS1lEUWFaVEVGK09VN2hFYXJkM3Zz?=
 =?utf-8?B?L25pUUxtNU1VVXR5SE05NVg3d0JVaXl5VGtKTkF4aVVJdmpFK3FrR25WR1l3?=
 =?utf-8?B?TjZyQStGcHd6QUlMOFREZllCRlgxWmt6U0xXbndicEJSdlllNW5rR1l4U3k0?=
 =?utf-8?B?Ynh2Mi9jSFU4WDZUd0trOHYrbTNZQWY0ZkRvdVUxcjdnVE9FUVJqbldFRzVR?=
 =?utf-8?B?RTgvckhaMjROL1hCelRpbktvVnVLcU4rckxMNDgyWUtySkgvRW5jNUZsVC8x?=
 =?utf-8?B?T0FXMW5DUnJYY0pKVGJsMERyTW9yVTRZVklPTzFTRnNuSmFMSzcwVGZYMFh5?=
 =?utf-8?B?ZTRpejVPM0RkbC9HelBPZDg3K3dDakhhU3d4TVFwUTRQYlZ4SElab0xVNDFT?=
 =?utf-8?B?TDlwKzMzUXVqeDJyeG9jK2prSENUK3RDN2cxTFNIRFd3UkJHZE9mMTc5bTVi?=
 =?utf-8?B?NzBwWmU0T1JGbTV5cUdjVDlyVi9vT3hmQURDQjU0M1FkV0hxNWREQVhCZUk4?=
 =?utf-8?B?Njk4S2RvTit5eitBWHV0VjlyRUh0ZXE1RXIxWWtuYmg2b1NBOE9YWERnZjRn?=
 =?utf-8?B?VmxQSTIwTXEwSkxEMDVpaUxkVEkzMjVTcW1UVVFXU2ZZcTFjZ0ZrMFlyeS9j?=
 =?utf-8?B?R2FRbG9Leit2OU16K0Z5b0NDQTMxaHp3c2dwamZGYkp6eGcycWlzdHcweERQ?=
 =?utf-8?B?cHF6U1FsaDJpZHBlK3lHNm5Qdm9BelUrb1RUOUl0Q1NST25kanVHS2doUnZa?=
 =?utf-8?B?MWlSVWlYc1Yxa1ZuaDFGNDRzM0lzUlo4L3pDVU9rN2FoQ2hpZVI1cDVLOE43?=
 =?utf-8?B?T0phSFduWGNwNGJVVGNlUWtubGVYWFhoVSt0ZHp6MWFXMnQxU3BmWW00ZEhT?=
 =?utf-8?B?YWdkZU82M08wUTEyT0wxdHY1elJuQjl3TkpVRnNmc096RWxtdDdNUkkzQ0U3?=
 =?utf-8?B?citlN3RRWHdsZ0VBTkhuQ1p3emo2QnRxZHc3OFJQUmdISlZRNlRXdSs4NmhS?=
 =?utf-8?B?d0d5NzFZUUM5QjFOdHhjeVd0c3dXUU53eWNQSC9TOGF2K3ZLTDduR2pXWlhr?=
 =?utf-8?B?aTc0Z2tGTDZ0UzA4TCtnMS85TWhBN01uN1lDaG5BTmtpL2kySkxSNzR3Mk9k?=
 =?utf-8?B?QW0zSDZQQUU1djBXbTZtcGFzUm5ORnB3NisxOHM5UG5LbHNsS2g2NERQUitk?=
 =?utf-8?B?cnZ6S1pQbzVzZWU0U2RBUHczNHdqU3g3QnhtQW9qQzN4U2g5ZE4wNmV1Nm5h?=
 =?utf-8?B?YjltT0E4K3lva3Nrb0MxcC85ZURsWlg3aXFsRnpmeVRINEhtaDVwZmhWcmlh?=
 =?utf-8?B?OGlwbTkrSFBLeFI2bHR2Z2lUbU1iZ2ppWHpvdTlYTi9odDlnYjF1LzV2UzRj?=
 =?utf-8?B?NTBXWUtRZnNRWVNFZ3ZPZThOWHQxd1MxUlhmeUpYak1LNU81Qnozc200UmxE?=
 =?utf-8?B?ZjhWT0FsL0l0dGtNbUNtY3JkaWhlaVR0R2R2ZVF2MW1rRmY3QXV4M1J1a1BI?=
 =?utf-8?B?ZTkxS3haZXRqRVBhZVZmQmZ4TkxWSXVRaFk0RDlZU1B1NmgvRkVaNXRhSmRv?=
 =?utf-8?Q?qtR2MtC+AwTBL3Hp5uqSMUiurly/MwkefvJAGGC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lCb1FPd3p0RkQ3QUVHTUNOa3FrNy9yTnV3OTRaMkQyMWh6THhGc2g2Ull0?=
 =?utf-8?B?b1JRbDRkcUl0TlBTOEJYbEFhcUlrMjZlVXRRckdDdUNmdm9nbW9VWmw4Tlda?=
 =?utf-8?B?bVRWbmgrV3BWVVdESXBzeHRlYk13ZWNackRPczhlOXpuWWRjVzFSTU5zaElV?=
 =?utf-8?B?YWRCRTZUYkw3Umh3OU45ajFFcXZva2kxdkRJaHpzUVlpZDZBVTRaU2RNQWhn?=
 =?utf-8?B?MHpDUjNmYTJhMG1GOG1uYkFCYzdaUmNKQ1IyRnJ1SnhoQUFkeTNmeDNVekpw?=
 =?utf-8?B?Tmp0M1RpZ2dwMWpyRWUrZU0rOXNEQmlzNFBWclNORjByeXR2K3RObDRjWkF3?=
 =?utf-8?B?L2lKZjZxRDlYZk1UL0tpWnlNbVFURERtQ2Q4VWhkSWJWMzdlOHA5N0ZXc2I4?=
 =?utf-8?B?eVphdU1uOC84YzA4K0VKaW4zRlVxeGM1SjlaZzBQcVg0SjRyOG5ibFlObWlk?=
 =?utf-8?B?bk5WUng0MFh0d1lLblM4M3NFNTBJNkx3cEg3eXRrcU1neVU2M2c0Wk9tVkd4?=
 =?utf-8?B?N09OeFhiZEZ3RWhBU1N5YVI4UWxsZTg3L3FPQ0VjRG10ZDZZTmZ1d0hjbGJ5?=
 =?utf-8?B?RHZtSWxCamx1WkVOSEN3NG5oZHM1bkFtK2VJdGRhS2NDeWM4eThpNitrajYx?=
 =?utf-8?B?dUdEc1hQbG15bGhqckFKVzRKRVVLdE5sblh5L1JicFZzMDhqejFHZ2twQ296?=
 =?utf-8?B?UHBNWEFFNDRjc2pJbFZpQ2ZDRU1QV05VWitxMnk2M2k0VHFtbUtuNDZLbG1Z?=
 =?utf-8?B?WkNlQmFoUVhoVVRoSENtWDVrcVRJZ1dTdm9uMTFYSTJKUzMxRHBlQmhLWGRX?=
 =?utf-8?B?UkZMclpJV3lLdGkzRDRoWENKOXhCcHhoSkhlTXBqY1NrK3FOZzFSekE2cCt2?=
 =?utf-8?B?Rnp2am5YNFBnNS9RMjBmY3NoZHNKRVhCRlEwTjIzZ2h6cmFFeEdPanFuWDFy?=
 =?utf-8?B?UTZvQWZTY0xCWE1qZHRQYnh4ZzVPMWQyU3FNK2IrL201aHUrbWozaDR0a0Jt?=
 =?utf-8?B?RlE3b2NsTmRxd012UGY2aG1hYWVHVklSUVY0NTQzUzdqZG0xS01WbE42TldO?=
 =?utf-8?B?M29UczBFdzNJMzY3NW9NOGNid3o3dXhhY2t4T2ZmOEVUVWsvb3pOMU42UUwy?=
 =?utf-8?B?VnQzWTVVbk0vNzBQaytEQjRzczlqRzc5VTI0Rk9OaFNET1JZT1FqMllieWV0?=
 =?utf-8?B?UkFLSEtvNmZNOUlvY09VZE8vOFJhMTlnWUtxbVVaVjIrSjEyUjZ2RnJHK3gx?=
 =?utf-8?B?SzhsZUIxZHVmVVRiYWVmKzBhcElpQ1Q0TEZnVU9xdlNkaitYQ0pWUGJmVTg0?=
 =?utf-8?B?M3FRT0tpTGRPTEovZE1UYnlONDJZSVNVdWFlOHFBTGVOTjE0enZ5WmlzU0NX?=
 =?utf-8?B?ZDMvbm1hWkVkeWRVTEpPeGd0UW40WjQ3aUZuSzZvMVQ0czJSc2xSUCtKT2hF?=
 =?utf-8?B?cThiNi82Z0ZZeDhMblRYN3JYUnlsSnV0QWJhVWVMY3lQSkM5Q1pxZ2dQQnU3?=
 =?utf-8?B?L1AwZ2xjSVYwTjlSY2lkNmtnTzZBRDZJRXgxamxOU09qZ0pwNWp0U2NmSGpr?=
 =?utf-8?B?eGQ5N05KNUVpTTU1MjRkeWN4dStqQlhXa0kvcXZ6Y1FyS0MxSTVyMkptaXk2?=
 =?utf-8?B?RmFpUlhCM0E3ZVQvOEZRRW8xU05FV0F5NGdWQ3ZJZmpTL0gwZU4yS2hkSXdh?=
 =?utf-8?B?Nkx0SGdhZGgyVFYycyswVjJyR2tTUEVGOVlGT08wQmpac1JwdVgzME5Ld1ZY?=
 =?utf-8?B?SEM4MTg5c2dKU2dQYTVaQzlrNzFEQTV6UFJsQ0ZwM2R5eThnakNDSlAza2Zp?=
 =?utf-8?B?M2gweFBabEYrNTBnN09BREQwSm9DcVpwcFVwekFiQVhMa3Nic3JRZ2hHYVg0?=
 =?utf-8?B?enNXSGFLaHpWRWQ4UmdsU1ZYdmNESHpubEdRcERLTC9iYlBESEhLdkM2Q0dI?=
 =?utf-8?B?TUJKM1R5a1loeENFRnRRRzN5RmpleFU1MVFZaEhFaklBN0dIVjFOQjZMTkc4?=
 =?utf-8?B?Yld3UWd5cTBVcUMrcitBWG4vWENJTFNCa08rdTczb2NlUkhlWUE1ejEweUR5?=
 =?utf-8?B?Unh3WWZkSWp0YWR6QWxLK3hWNzNFbmg1L1NYNE5ZNnJ3dHo3Z1RkOUpXaDlD?=
 =?utf-8?Q?l22VQLNUSFmiHijLY4ViXHlnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaf962c-6689-49a1-ae15-08dd03c4bd66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:22:48.3771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X93cMaNsMX51fKeG7baObM0ZH0p4rJacXKJGWSLaODJcWPbhrANgXoffHYDFlvAc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

--------------PTdV000k05ZmrbDOcpPB0NBV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi guys,

can you please explain to me why it's always you guys which come up with 
such nonsense?

When you need to find the number of ongoing hardware submission then 
please use the amdgpu_fence_count_emitted() function and not mess with 
any scheduler internals.

This patch here is a clear NAK from my side.

Regards,
Christian.

Am 13.11.24 um 09:46 schrieb Fan, Shikang:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> +@Koenig, Christian <mailto:Christian.Koenig@amd.com>
>
> Hi Christian,
>
> Could you please help review this patch? Thank you.
>
> Regards,
> Shikang
> ------------------------------------------------------------------------
> *From:* Shikang Fan <shikang.fan@amd.com>
> *Sent:* Wednesday, November 13, 2024 11:14 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Fan, Shikang <Shikang.Fan@amd.com>; Liu01, Tong (Esther) 
> <Tong.Liu01@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Check pending job finished or not to 
> identify has bad job
> drm_sched_free_job_work is a queue work function,
> so even job is finished in hw, it still needs some time to
> be deleted from the pending queue by drm_sched_free_job_work.
> here iterates over the pending job list and wait for each job to finish
> within specified timeout (1s by default) to avoid jobs that are not
> cleaned up in time or are about to finished.
> if wait timeout, return true
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 071d3d9b345d..da2a22618f42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
>  #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
>  #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
>  #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
> +#define AMDGPU_PENDING_JOB_TIMEOUT msecs_to_jiffies(1000)
>
>  static const struct drm_driver amdgpu_kms_driver;
>
> @@ -5224,7 +5225,8 @@ static int amdgpu_device_reset_sriov(struct 
> amdgpu_device *adev,
>  bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>  {
>          int i;
> -       struct drm_sched_job *job;
> +       struct drm_sched_job *job, *tmp;
> +       long r;
>
>          for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>                  struct amdgpu_ring *ring = adev->rings[i];
> @@ -5233,11 +5235,20 @@ bool amdgpu_device_has_job_running(struct 
> amdgpu_device *adev)
>                          continue;
>
> spin_lock(&ring->sched.job_list_lock);
> -               job = list_first_entry_or_null(&ring->sched.pending_list,
> -                                              struct drm_sched_job, 
> list);
> +
> +               /* iterates over the pending job list
> +                * wait for each job to finish within timeout (1s by 
> default)
> +                * if wait timeout, return true
> +                */
> +               list_for_each_entry_safe(job, tmp, 
> &ring->sched.pending_list, list) {
> +                       r = 
> dma_fence_wait_timeout(&job->s_fence->finished,
> +                                                               false, 
> AMDGPU_PENDING_JOB_TIMEOUT);
> +                       if (r <= 0) {
> + spin_unlock(&ring->sched.job_list_lock);
> +                               return true;
> +                       }
> +               }
> spin_unlock(&ring->sched.job_list_lock);
> -               if (job)
> -                       return true;
>          }
>          return false;
>  }
> -- 
> 2.34.1
>

--------------PTdV000k05ZmrbDOcpPB0NBV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi guys,<br>
    <br>
    can you please explain to me why it's always you guys which come up
    with such nonsense?<br>
    <br>
    When you need to find the number of ongoing hardware submission then
    please use the amdgpu_fence_count_emitted() function and not mess
    with any scheduler internals.<br>
    <br>
    This patch here is a clear NAK from my side.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.11.24 um 09:46 schrieb Fan,
      Shikang:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB7343D24CCFC921D157E2CDCCEB5A2@SA1PR12MB7343.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          +<a href="mailto:Christian.Koenig@amd.com" id="OWAAM717321" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">@Koenig, Christian</a><br>
          <br>
          Hi Christian,<br>
          <br>
          Could you&nbsp;please help review this patch? Thank you.<br>
          <br>
          Regards,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shikang</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, November 13, 2024 11:14 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a>; Liu01,
            Tong (Esther) <a class="moz-txt-link-rfc2396E" href="mailto:Tong.Liu01@amd.com">&lt;Tong.Liu01@amd.com&gt;</a>; Deng, Emily
            <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: Check pending job
            finished or not to identify has bad job</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">drm_sched_free_job_work is a queue
                work function,<br>
                so even job is finished in hw, it still needs some time
                to<br>
                be deleted from the pending queue by
                drm_sched_free_job_work.<br>
                here iterates over the pending job list and wait for
                each job to finish<br>
                within specified timeout (1s by default) to avoid jobs
                that are not<br>
                cleaned up in time or are about to finished.<br>
                if wait timeout, return true<br>
                <br>
                Signed-off-by: Tong Liu01 <a class="moz-txt-link-rfc2396E" href="mailto:Tong.Liu01@amd.com">&lt;Tong.Liu01@amd.com&gt;</a><br>
                Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
                Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
                ++++++++++++++++-----<br>
                &nbsp;1 file changed, 16 insertions(+), 5 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index 071d3d9b345d..da2a22618f42 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -100,6 +100,7 @@
                MODULE_FIRMWARE(&quot;amdgpu/navi12_gpu_info.bin&quot;);<br>
                &nbsp;#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 &gt;&gt; 2)<br>
                &nbsp;#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 &gt;&gt; 2)<br>
                &nbsp;#define AMDGPU_PCIE_DATA_FALLBACK (0x3C &gt;&gt; 2)<br>
                +#define AMDGPU_PENDING_JOB_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp;
                msecs_to_jiffies(1000)<br>
                &nbsp;<br>
                &nbsp;static const struct drm_driver amdgpu_kms_driver;<br>
                &nbsp;<br>
                @@ -5224,7 +5225,8 @@ static int
                amdgpu_device_reset_sriov(struct amdgpu_device *adev,<br>
                &nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device
                *adev)<br>
                &nbsp;{<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *tmp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long r;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                @@ -5233,11 +5235,20 @@ bool
                amdgpu_device_has_job_running(struct amdgpu_device
                *adev)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job =
                list_first_entry_or_null(&amp;ring-&gt;sched.pending_list,<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                drm_sched_job, list);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* iterates over the pending job list<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * wait for each job to finish within
                timeout (1s by default)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if wait timeout, return true<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(job, tmp,
                &amp;ring-&gt;sched.pending_list, list) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                dma_fence_wait_timeout(&amp;job-&gt;s_fence-&gt;finished,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false,
                AMDGPU_PENDING_JOB_TIMEOUT);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt;= 0) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job)<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                &nbsp;}<br>
                -- <br>
                2.34.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------PTdV000k05ZmrbDOcpPB0NBV--
