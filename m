Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B370AC0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 08:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB49E10E43F;
	Tue, 11 Feb 2025 08:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PTehLIY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A176610E43F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 08:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lho7/HJ+PJ4F92gt6r8VciaK28EukeJ+ISAcnoBJb3jzpUe8X1nPCcGe+YVeejz/MPSSqrlCY7ER1zrnzJ2+TCldiVdvvNTxPkQ/c1L3/ykIf4cQK5jR/ouVXx4p2/TQ6p9ExLQD/8w/qXEAEqzsBuJZDoR4CQ0lVXNjzw+tokAMzDlBmig6lRUZE60//6MpwbKlrFSGDONXyQGBC20AYygWeOizxkSIBkAtGlpoqxzkMwFoYrT3tnr5gpOtHZ0pyYWKmHSQvq3W9ltL+e1R4uKMUDy82BIj5quzFFPliVXYyL8QEPeRpA0qAsLCxir2HPgUrn40hYyhaW0ctCZ/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWD5n1fjs8Y3ymfdhzxfPdu5PsBkhRgMcx/pE7UBsMw=;
 b=ewhPcs8TEuSnJd3dnXVTbtMPzTVGQAHsEVboOhp9sh4uVFu5RlDk2Vq/MKFqX3JOtJIVWaZ8AtHaGoZsjAR7HEjExBi7ImMDHo90udubIXSw1/Wb93amMpDND1J6dtRkzaJTwjBZs1ZIReULHfeZYs7lX1yGAfs2aO8rWAknz+Meqr+QPjx0S3Aw2fEK2N0ZZ8FF4JAoaXK0FBTS1wNvXW2r02AqA6qimSDexhuymPGHNvugdhTKJ/Gb4tEklMkeIVLqDV1hk2DXd5NLU+hRDoilkHVQXCurC3IoYTHSDDXFEIDxPVo69b5uc2kbYlV0lqoEVYExgx3/N5+ZyQEC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWD5n1fjs8Y3ymfdhzxfPdu5PsBkhRgMcx/pE7UBsMw=;
 b=2PTehLIY9lPOj9nsJLqacsO1/+nC3Mm+Gd3HKDe6Z2HEbolQbcZ/t4jTAvl7W4xVFkw0LpC/XElXNZLIhHVL0qhSSrn+vdePPgQOUSOIphX2BKA8HGmBKqW/uqv3L1mjhGiinMmnG8lR0jgT5BJJUqF3fuwAQYbiba8wws542Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 08:28:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:28:14 +0000
Message-ID: <b23cf596-c472-4ca6-ab74-3ccb37854278@amd.com>
Date: Tue, 11 Feb 2025 09:28:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/sched: Remove a hole from struct drm_sched_job
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250206164031.43413-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: c9555e93-af4b-46f7-35ac-08dd4a7606ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODVySXJyL0pNUTdvL1pybmdwOGRlUlZZaE5UVzVaOStVR0YxV0FDUDVjVFZX?=
 =?utf-8?B?N0ZsMnhTVDRmaVNvbmZWVC85d1paS0NqSWE2YlM0MHB5ZSttMm9NR01hSzNV?=
 =?utf-8?B?NnhSUEUyanZCRFB2ck85ei9uRmdIOGlkZmREbHJZNmgzRGhRRjZ6UzVpSzRP?=
 =?utf-8?B?RGhrMlNyUmpMQlkzY084b2lnV1gzMG04UEpjZGFRb084SXdXVm5mbXE2cy9x?=
 =?utf-8?B?NkhwcVVMc0NTdGxWWU5BTWw0Y3Y0TWs2bklQQnYzT1ZlL0kwZEJCYVFDUm81?=
 =?utf-8?B?Wlp0OW9YVWJ1eUhac2lnK0tZaytwWFRwTGFyTFJjVmxOMlZFYTBuN0FkMHNT?=
 =?utf-8?B?SStvQ292cGRIY3BPK2JMTlJyZXlHSnRNdlNBK0NrdVVCYm4xZlpYOUwrVFZS?=
 =?utf-8?B?NHRGaTNqK0taS0NpNFVmdjNuQ25ua0R3dnBFZ0dHUDRURGdlK3R6TEF5OFhU?=
 =?utf-8?B?ZnVsaUhQTVkxVm5NQk9Fam9wY2U2UHVsNHVUREQrNUtuWEp5VnJxYk5NZTAw?=
 =?utf-8?B?Z3lXNlN0dGV4NGlqWnVzR2wzZmFzVUxaTDF2bjJwQlFFWjk3ZEEzSFlaR0U0?=
 =?utf-8?B?TWF5Z0ZBS0JRUUlmVHB1eGRKY1ZrcWRhV3dibllNYlNPUlowenYzdS9OYmow?=
 =?utf-8?B?SUVqSDh5THRvUVF0Sm9nc0laV2tYalFVaGs0NFpsN3N3RnBWVlFYS3NBMFFn?=
 =?utf-8?B?ZGVLSU1DUkJSSlVsTk5oeVlDVWw3dy90d1daMWUvMGNIT24xa2d2aE9qd0VP?=
 =?utf-8?B?Q1JzY1lIQmd6UGZqeG4ycDZkSlZLVWR0ZUloSlg2dHZzN2hsZ0JmYStvemJ1?=
 =?utf-8?B?SGlaYzRHRXg0YUdwcXk3UkZueXVIZVdRMHJQZVg3Ti9IZHRmTlVHTU4vU3Q4?=
 =?utf-8?B?bDVwT1ZQUXI5Y3VpZGpxL09SMlMzS2FicDF3UWVLeCt0bUw1OXhIRXFQc2VK?=
 =?utf-8?B?djNXSmZDalR3alo0TXFKdjR6M3lSRmtoZk1jWlZHeDV6RnRGVTcrYXdzUE5Q?=
 =?utf-8?B?MjBqKzBHNmF4QUdEZzlDL09BSW9CalhVR3NkN0NZNFMyUVp4UEpYdW1aVzlV?=
 =?utf-8?B?aWpiMzd6b0JGcFpaYkhYOVgvc1d6ZDdjQVIwc0JZQ1dqd0pWS3MraGZ1WitI?=
 =?utf-8?B?OVZhSkpOM0NWSjhwVFdiajIzY0FhYml0aTdLYzJWUFhKU0FLRUJPVUJCVGJ1?=
 =?utf-8?B?bUI4aFhtQWlqZ2N4Mm1wcFNzcjZUVUFmaHJ0aGd1K3hGMlZnWXJ4dzBqY0kr?=
 =?utf-8?B?YjViVHBqSjR5RWF3bFRrMUd0RWdYelZjdzhDVHhaS2ZUUUNKdGUxV29jNkVr?=
 =?utf-8?B?SWYzeUpTYW9PQWdiZnVwZ2ZYaHBZNmNsR3VzNHMxclpka0xadEJ6d1o1RUkx?=
 =?utf-8?B?L2NvSkV0U2hPa1NWb25SUC93L3NkdWFRMmN2NkZXam9MZ3JTR2NXOHQyNlIw?=
 =?utf-8?B?QnBHODFoK3A2NGlwOEFsQkdCbzhuWmVTMjRzZnJvQXVPSEt3Mm1LaEFZK2s1?=
 =?utf-8?B?TnZVd0NDeTZ5NlIyVlJOSVh6dzE5c2cra0tLVnowQXozUzFDZDk4MWxjZEY5?=
 =?utf-8?B?OGR4c1hscVA4SUs1d3IwNUJPQlZtMm5yWDJ0WHBFNlpHRzhMcE1qUmJMMS9R?=
 =?utf-8?B?MFVqdW1Sakd3aUVrVzlpYndoeXFkL0o0eWZTLzdiWTZURjZEZzB5Rllvemli?=
 =?utf-8?B?Nks1aDhhaWFoQnlURGdBSTBpTWpoNW4ybHdJK2dMYUIzdG9NS3lYcFpGelBT?=
 =?utf-8?B?dktMd3ZTM0RBQTFXUkNESXFZMG1mNUVaTkNybGdodVNWSm03VWtaNFNRQVY2?=
 =?utf-8?B?eFpyWXJrVnQ0Q0xrRDJiNVZIdFk4K05pTGVnYXM4SDRuKzlDSXJ1MVZKYith?=
 =?utf-8?Q?cocJlCaU7DIBN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJWUVJwanZQVFRwMG94TzQxbGxCS21QT1JadTJna3pIbmJWdTJFRnZuT1A3?=
 =?utf-8?B?and2cDlzODFkT3ZsMVFibjRFeVpNRE9YdmdVL1FabWJHZm5ZZkZqWHEyMmxU?=
 =?utf-8?B?Tm5kaDNtMEpRaklraDRXL3R6bS9Oc2pzRXJ5OWRPeHRtTGt0UkVyL0xXLzFS?=
 =?utf-8?B?Tm8vYmcxUXFtUkc1eFYwNGFBdlVmbFJHR3FLY3FYUW9HUk1wM3IzaHM5c21a?=
 =?utf-8?B?c3NadzBFUDhaaXJWUW8ydjltL29KTEpuUy9Yc0tCOGNkN3AycEZZQzRJNWp5?=
 =?utf-8?B?QW5lTldYRW5mZ21reXZBTUgvYy9qTmZuL2c3ME12cEdZTllIN040T1B0bHF5?=
 =?utf-8?B?STJXVG0xSk9iLzdsK1dGZktSTmFJNkRFczJpZk9BYk1UQnNtbGpzSFBmSisr?=
 =?utf-8?B?WDNsUFpLcXJEMWErZWYxM0ZHSXUyTVBRUmYzcmNHN0tqSlpmc0lBODJuMThs?=
 =?utf-8?B?MW50UkdTcXlQcTRja0FvdHpsSDZyemRuamk2ZkE0dGE0b1VjaWw5TnBSdGRh?=
 =?utf-8?B?YktEeUQzcVlicGpldXdWN3E5NHZpbXZ2NUV1ZUVZRGs3N3FKSTNVcTZaSkhQ?=
 =?utf-8?B?QnVOS2NsSzd1TnJLY0VnVTRRdHllRmgvMTgzVDY0M25iTysrZkYrSHBmWlR3?=
 =?utf-8?B?M0hQcFFvMXNyZk1MTXZ5MmdaWW9tSFFjVlBjSUhIMzd2MUhybjlTMzJhV05q?=
 =?utf-8?B?aHlENG5TTm4zb2xCcENKR2g0UjlHeEdOK1JtMkMrU0dWUnpuaTdzdFBlZnEr?=
 =?utf-8?B?ZzNnZmVpV3BUNTI4VE5IUzVRYXlGdGJNdXkxQk5TampCTGUzRkt4aXZuMXNY?=
 =?utf-8?B?ajRDN0FaYStVWklwUWhHd3FDSm9Eb2NvckZPZDFGYmdRMTVYWk1CYjZkR2hi?=
 =?utf-8?B?T3hZcUljdmpISlo4dEdYYk14ZDQyazBqaDEwRkpNWms4ZUo2MlF6QmVVZUh3?=
 =?utf-8?B?Zm8rdEhqLys1ckNqZC9lVGNScTcyV3BrVEFYY2lpUkF2Zmh6NlVjaHcrNjBv?=
 =?utf-8?B?ejlNaTdaQ3FFNTl2SVovSFpRRGlaOHd3UW1xVFo1TVpGdENqRm40VUxZUGFK?=
 =?utf-8?B?R3JSVTAzMkJUa3NiOWpLUWVzc1lsNVpyRWZEZGREYW9KbVcvbyt0bUJ5eHJE?=
 =?utf-8?B?YkZuNW8rZnR6UkFwM0ZEZEloaFFYK1dYZ0FTQldRNHRHY2lvcHZyS29sRlhN?=
 =?utf-8?B?MjIzTW9nZ1hWNkFha2lVczBCNlpKWThBK0JQdHdGVDNOdFhvdXpsS21UeE9z?=
 =?utf-8?B?TzFwT3NUQ1d0SUM0TGdNQnljM0U2c2dXRlJKWlErLytZWGt0UHNDaWR0T2hj?=
 =?utf-8?B?MXp5K0g5T0JzTnYxd2lVMmRTZXkwYk95M3NTZ29sbTRxbTRzbjRtdjRHTUlV?=
 =?utf-8?B?S0hUdnRUSW9LcFZ3NHk1TVNCWkVVcU8zcGI1SlhvM2Nuc0dYTUlhVmVpSGR0?=
 =?utf-8?B?ZUlJZTZVNUtJMklUZlpKbkJtN01RU3JkNkJTbDE2QXU0ejQxekZiWkNmOFZ6?=
 =?utf-8?B?OFgxdGM4dkg5WDJJK2VWalZTNSs2cXlmOW52WFhOQ2twamduekpZcFlrSThV?=
 =?utf-8?B?eHpBODBaUmQvVXNCamU1cXlCMUlSTStsUG5xcDNlcjJla0w4eDBoYjVFVzgx?=
 =?utf-8?B?SDZsTkZQQ25XN3EzMTlxaTB2WHB3aDdUL3FwN1hJY0pWOUZkYUZ2R1g4Rlho?=
 =?utf-8?B?Q0wxR1k1WnRmSTJjNDRuVTc4TlZ5a3BWSUxFMzJYU0x5L014aU1nZkRaNXV6?=
 =?utf-8?B?MWdnSHhwR05ycXEzS212MkVaL05leVhPQ1hINnJyUlpZaVpMQWVMM1U4U2tq?=
 =?utf-8?B?emxETCtiUHBUQXdVL0pjSkVEUDN0SjFKV21qd2tYUFV2VkVkOEZPN1NYUW00?=
 =?utf-8?B?QWsvaWR6U0llOXZIMXNmbmRTbXNFenZRQWp0UjdCdVNLdUhFR291UUJBWG9K?=
 =?utf-8?B?YjgrTjVlQXdlbit4bjRwNkU4amtkVUF5K3JYQUNLUGRYQ2VjYm1KN1BkRjMx?=
 =?utf-8?B?RmFaWUpMRHpUME9NOGpxMWF3bEVZcG9wL3J2dEs3RUY1bm53UldQZ1JkSTJI?=
 =?utf-8?B?aS9OT1JIbmgxbzVrY2g4bkRNaFRRRTNKSDI3WmJUVUJlQ3pJeDQ4TEdYWUZO?=
 =?utf-8?Q?OxNvbsArLYj1L7EKGCnKZ0iiw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9555e93-af4b-46f7-35ac-08dd4a7606ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:28:14.1796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUNNxAzzFAyZO3FWaNC+OGsoOasgwNJkrDjZA/jTAqSuNpUwUsEgUA0POoVZTEkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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

Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
> We can re-order some struct members and take u32 credits outside of the
> pointer sandwich and also for the last_dependency member we can get away
> with an unsigned int since for dependency we use xa_limit_32b.
>
> Pahole report before:
>          /* size: 160, cachelines: 3, members: 14 */
>          /* sum members: 156, holes: 1, sum holes: 4 */
>          /* last cacheline: 32 bytes */
>
> And after:
>          /* size: 152, cachelines: 3, members: 14 */
>          /* last cacheline: 24 bytes */
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
>   include/drm/gpu_scheduler.h | 38 +++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index a0ff08123f07..68da3dec8dba 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -338,8 +338,14 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>    * to schedule the job.
>    */
>   struct drm_sched_job {
> -	struct spsc_node		queue_node;
> -	struct list_head		list;
> +	u64				id;

Not actually part of this patch here, but I think we should remove this 
id field and rather always use the context/sequence number pair of the 
scheduler fence to identify a submission.

The patch itself is Acked-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +
> +	/**
> +	 * @submit_ts:
> +	 *
> +	 * When the job was pushed into the entity queue.
> +	 */
> +	ktime_t                         submit_ts;
>   
>   	/**
>   	 * @sched:
> @@ -349,24 +355,30 @@ struct drm_sched_job {
>   	 * has finished.
>   	 */
>   	struct drm_gpu_scheduler	*sched;
> +
>   	struct drm_sched_fence		*s_fence;
> +	struct drm_sched_entity         *entity;
>   
> +	enum drm_sched_priority		s_priority;
>   	u32				credits;
> +	/** @last_dependency: tracks @dependencies as they signal */
> +	unsigned int			last_dependency;
> +	atomic_t			karma;
> +
> +	struct spsc_node		queue_node;
> +	struct list_head		list;
>   
>   	/*
>   	 * work is used only after finish_cb has been used and will not be
>   	 * accessed anymore.
>   	 */
>   	union {
> -		struct dma_fence_cb		finish_cb;
> -		struct work_struct		work;
> +		struct dma_fence_cb	finish_cb;
> +		struct work_struct	work;
>   	};
>   
> -	uint64_t			id;
> -	atomic_t			karma;
> -	enum drm_sched_priority		s_priority;
> -	struct drm_sched_entity         *entity;
>   	struct dma_fence_cb		cb;
> +
>   	/**
>   	 * @dependencies:
>   	 *
> @@ -375,16 +387,6 @@ struct drm_sched_job {
>   	 * drm_sched_job_add_implicit_dependencies().
>   	 */
>   	struct xarray			dependencies;
> -
> -	/** @last_dependency: tracks @dependencies as they signal */
> -	unsigned long			last_dependency;
> -
> -	/**
> -	 * @submit_ts:
> -	 *
> -	 * When the job was pushed into the entity queue.
> -	 */
> -	ktime_t                         submit_ts;
>   };
>   
>   static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,

