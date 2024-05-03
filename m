Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11D6C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 15:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514521130C7;
	Fri,  3 May 2024 15:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bXANhz9y";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108C31130C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSAvazW0diXh3JZDazwSh89auMR23y1GaLtqw5FJzTLlfQhJNklLbUb4iLPLNO0rk+RL368cBMkTSChHIkyW4UC2AP0Eg7nklKv8Pd+P5DKUJksdnCpoHKfIOoOl7EZ7mHcJHrDpvDzoYhbPQCxpry6GHMEezzv9ZxFbT/JwGdKY5p3BpibEksqLwpWX1UCnvNqYzpALDtbHISBajocyWsO4MHbH+kaoca0UNH9mZD2aPUv3+3MQ4yPC03buCN3UOoUBKOQN+SvoSVNjvkIKhs0YazaEYsB2Zq9nw8/f1tlQtqDSt3rcFTYEOiVsJ94oLauKYLHrNoMg+da4zofE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52aC5rLCS3PwCASC4BCxeHbpoiLjiXHHjVhdXfy8ZA4=;
 b=QK3oupc9kw54eeWvQs6bJpVufA6LhSn//6klyFHduk7JnsSgUKK5q/KZezhQYUbh0xvQijxETDaw8W2Kd22u70IEG3EPW0YhSPXKVZMQVY5+ZfxlKndtQ6LBXx8w+1zvHGo6NObGMZL3qhN8N65jQ1c1nAo61Uxg/21dHhGfCPKNol4HkX/C4aEyAVsuOYj6ScILKrpWQTrRhn6QoRppgq8EfV7iD3kQRyZPX8yvawQs2yPjxga33RnAYpehS/FYMB2DR+hsye2wJaHrdHucVKcXFoimNwLSr5yhCiJs8L7TwJ5txGon/a/BC8hC8SknN/S9da+LwTEL0bFBqwcnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52aC5rLCS3PwCASC4BCxeHbpoiLjiXHHjVhdXfy8ZA4=;
 b=bXANhz9yLtyDSueRv1QRyMI08A0Ixw+SuGjD0cC/zjGJPnyl+ZB79i8DvmexUn8ndHu7nkzI6Hfm3FYYMpnXfM+XNYxzSZh5oKbt7u5lZ2PLhrlLvM/1jUuX+cQp+4O2ftRQb7IDFXuFzJWzKrAybsxdQsiwn2Ng3Bdvb4MyXIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 15:36:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 15:36:53 +0000
Message-ID: <55de3e66-ff43-4a00-8f4f-8b8e45190496@amd.com>
Date: Fri, 3 May 2024 10:36:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Allow setting a power cap that's lower than recommended
To: fililip <fililip6483@protonmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1VLcj5GzcoG1-O6-r7zBAGyAXVUTTIHMyJRR8Svf-ckgPom-otJt8N3sT5oPHvLOiYjvdXx6zfZ3zatRHJFGsitQKAA8mHNV57KoFBMjNJk=@protonmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1VLcj5GzcoG1-O6-r7zBAGyAXVUTTIHMyJRR8Svf-ckgPom-otJt8N3sT5oPHvLOiYjvdXx6zfZ3zatRHJFGsitQKAA8mHNV57KoFBMjNJk=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af9b8e2-da12-49c3-508c-08dc6b86db24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M25CanhEZm9ucEM3S055Uk5QVXBsY1Azd1J3bFpKRjlDVU93Tkl0VW8rY3VM?=
 =?utf-8?B?dStPakJPbDFPd1BlRU52TWdYd28zMi9OcUQ2b0RoZ29CTW1lamRNdHB2RVRi?=
 =?utf-8?B?a2J2VXdqUmdCSFEyMTVWdXYrOWU5QnJOU0RuYmg1UXk3Ly8xUVMxRlBtYnQy?=
 =?utf-8?B?RjYvY2p0UW1BZk9XM3Jmdmx4Q0trM3kvU3RFOTBseUNqY01CNU5GdWJQU0cr?=
 =?utf-8?B?SVVlelFxYkxpUUxmMENxZFRUR3plQm5SN1A1U08yRFdlaHd5SnRUakpoV0dN?=
 =?utf-8?B?T0NyWWY0c3BvMmN6eW5kSE9zVlRUNGlsUWl6S1QvUFFFcHJRY1o1WGJRVGJo?=
 =?utf-8?B?MUhiU1UwejZJVmIzeXdSUW9IT0xaa0xjRS91TjBZL2FZenBRMlduYVBvbU1L?=
 =?utf-8?B?emZzOExDdDJyWWt0Q3pEZlllelNDbllEdjdNdlZzU2YwWVk0SGV1V0o5bUt5?=
 =?utf-8?B?RG12KytjTzM0VjRWcWE0cXp6Q3JLd3NnQnpudlYvbzZKQUhmUXJMUmNNRzhz?=
 =?utf-8?B?Qjk1bHhsd1VpWm81QWlwYzB6ZklWL2o1VTk5UVR5RXQyN2g5dW1aeDBLUFg0?=
 =?utf-8?B?TU16c0czZ3F5ZEJ0eWFRc2lnbE1TdjFYa0Q1cm1yZWFVMnZNc0Z0NE5aWUFU?=
 =?utf-8?B?UGZLZk5FM0VzQVRTWVVxbEtxTWR6cmVadEZPQkF1YWJzR0lhVm1XcFhCdHNT?=
 =?utf-8?B?ZWhiS1NDUTg5MW5pN0FYRnhvdGU1dHJqelN0Nis2RmdJTWFoY3lJNE5KWE1N?=
 =?utf-8?B?b041WkZQWGd2ZzNLa21MajhRdFErZ1BsbFhhL25pdXVPd3pjTUY0alVCYmtC?=
 =?utf-8?B?NHJQZ1d5YjM1bGlBRzVTUk41VTVCRmJ4Zmsrc1oraE40ai9IK21vVzUvRllN?=
 =?utf-8?B?T3BNdFFBZ2JhSlV2MGMwNllDSzFKNHpMdUxPcnJNbEdFbFdrdzBRZm5oRjBz?=
 =?utf-8?B?ckVKSDVHVGd2UUMzRXk2OExOS0VjaDdGZ0dHNjdrMkdJbmlMT3B3dldxd0t2?=
 =?utf-8?B?M0I0eExPYnYrNGxxYzh3MFFFUHlpZ0ZZRXZZbmoydjdCa3RSaVBYcTBuaStl?=
 =?utf-8?B?a0Z6T24zVFVtOVdGOE8yeS9rUjFyODVRYmpVdzZVVm5rb2d4QTNzdHd4NXVi?=
 =?utf-8?B?U3lxT0RoYXgrSEwxSzA2dkFJaE5HT0REdEFZaHFta3JCRzZ1emhGbDM1U20v?=
 =?utf-8?B?M2dzRWdKVkZwaE5yc095R1RyQlFOck9JVnVhNDBkNC83REVkN25mNVJtQ3o1?=
 =?utf-8?B?RUlXUWMzd2Z0bmFxSFoyWmdlWkh0TlRjVVBEZ0tSSTYvRFhZTnZhRWlUSDJt?=
 =?utf-8?B?bEVBTk5leFZBd09kZDJCb21hSHVzS3hZQUdPcWlqQjVaMnAvMUVTbjJyOXNR?=
 =?utf-8?B?QmI2T1NBcWlsTW04WWErR01mM1ZnMW9WWlpERkZqb1BqQjNJSUhzYUUvM0cy?=
 =?utf-8?B?ZTl0UWdyemgva1VNWTU5bXdvNnR0TUVzbU8wM3FGbmkrdGd0QlR1ejdPWU9y?=
 =?utf-8?B?MWRkV05iSUlqdzJDdldndnhtb2N3ZFgvYkpDYzZIQVEyZHhHL3BJRkdrenY0?=
 =?utf-8?B?SlJLaU0yZUxyajIvRy9XRFVEeWV2dXA0L1l3ZjdlYVlhU1dqakMvVUcvOUFa?=
 =?utf-8?Q?VJPjA8WRlQuw3z3wJ1jIU6K4xyFrRaZb2nuoniIx/EUg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFoajIyTVVxNkp4QjRTRXFDSVovS3VYWXBYbitsYXVjT08rTzNTUGUxYjk5?=
 =?utf-8?B?bk9qTUNpVys4UDBobWF0V0h0Wlk4TlRmbG0wWkhjbXpmWFV5Rm9lbXBNY0RL?=
 =?utf-8?B?TzNjOTZ3Ui9CVC9uK0N2NW5tNm9BZGlKdDR2S2gybGI5ejlQQUZPOW5vbHJk?=
 =?utf-8?B?ck12aTcremVBdWFpcnBTUWJzVTFvUG1hb096S1BYTnA0TXJ3WldXTmd0Vlhm?=
 =?utf-8?B?Z2Jia1RTYkRsck1rOENnb1B2ZTRLZW5xUlU5STRXS2t1NXdkZGk3UnhvVmVu?=
 =?utf-8?B?dUxla1FLR0JTL014dE5RVXoxTU9MZERocXJpSDhHbFg3ZFEwVnhzZ2RoNjVB?=
 =?utf-8?B?NHNobkVQS2RrSGxvZlM1RHZOTGVCQ2xKMnZ5SnZaUUowWldxc3dXVG9MNGlq?=
 =?utf-8?B?eFA3dXFZMG5ZRnJqQVcvVjJDbmk5ei9raWVZNkJ6M2Z6bnU3K2ZZTWtucFMr?=
 =?utf-8?B?Q3NHckZndDY2RC9ZYUdYN0RqVnBRd09MQ3Zvei9mcE5vOFdMaHV5WFFLVTBl?=
 =?utf-8?B?dmg2cU5XanZLNTBreThpeWNEV2hJbmVCY3NxZ1NkUWozRkZxV0RxM2doNUlM?=
 =?utf-8?B?LzZtV2pGbUQxOEFOaUk2SEg5akJjQnhCNVJueVFOdXRHc254T0pxMHBrMUg3?=
 =?utf-8?B?cFY5NUJpQW8veGVxQnMrT0JXdE1hOVNDdlRQM3FneTkvaTNjSDNlS2J3UmhO?=
 =?utf-8?B?VmcvOHZPTU5WemNyZitxdThuZEMzRDJoU3J2dEJrdCtXSHRaQnFaWE80K253?=
 =?utf-8?B?Y3pPWlBCZnMxa29mbjdKUndBcXhsQWpmeVJ2Ri85ZWxPd0xGT0RjSG5naDMy?=
 =?utf-8?B?N0NLNmtGWjBKOHRGYk81clFsR0J5cC9uSUJDczhSYTNjUldrVjdMay8yS2gr?=
 =?utf-8?B?TGhqWVNsNXVySld4b0FNM0tDTTdWSlBjK3FNZHU0S05ZTUtBQW9lSUFNeThE?=
 =?utf-8?B?MU9uVUxrSmRUR0t2UlRQcXJRUlNadHE5RndoZ0lvRkpiNFJFbE5OMU4xRmRV?=
 =?utf-8?B?bVpBSWx5WWxKQjVKTWNtMXRXeG5hSXAzaUtoT1o0dmVhREJXMWJ2am5XL3FV?=
 =?utf-8?B?V3Zhemp4V2lPTDBidXo5WFBrYWRFR2RNZGxHUU1VRld2L0NPOHpSdWVrK0hw?=
 =?utf-8?B?NXRjcmllVTJWTUZFMHZEUzhBRVhhdTVJMjFDZVR2VWR0R3dvVGxNVVlQSldw?=
 =?utf-8?B?cFV2SjJXcTYycnNLOHJnNExzdVRueDJ3NDJOYWQ1MmJVbFgvV2wwZDNRcUlR?=
 =?utf-8?B?eHdmazFCejZrQUZVRExGRjduNFVOYW1QSmJVaFloaVg3U3BNYVlJUG51S3Y5?=
 =?utf-8?B?T2FxUmoyQ011M2VkeU9ncld1V1cvTmZQZjJOR1RUQlNHeXhoenhKSENVY0dD?=
 =?utf-8?B?bnJnMG5waDFuUEtKWjh6dm1xUmd5NXhobzJVRTYyeHZNcFVITjVlV1hidFRW?=
 =?utf-8?B?SGhmQ0NFQWZ3K1V0Y3pRSzdYZDNyeW1vM3kvMUk3SGpSNU9XdjBVZC9PKzV3?=
 =?utf-8?B?T0N0d1QzeFBPU2tobDZyWGVhQjBzMlJZWjNQMHJHaGJuRTFpZER0ODd1WndV?=
 =?utf-8?B?N1laTi9pS0dpM1pQUmNLY0tJKzFDa1J5UWkwSlEra00xUk9RWUJxcTZ1dmZv?=
 =?utf-8?B?UVYzWHkvV1R2Y3RGRXgxYXM2OWdyVVJwdjhQcTI0YXNrTTVsTjVxRzJoaU03?=
 =?utf-8?B?QkpxVDJONDJ3ekJVTjRlc2dHcXNrbGhNbWlvVEZOakN2RjMwMkxQSlJISXZR?=
 =?utf-8?B?SXZUc01UN1VvZ1J0VGFCR2F6QW5iNzczRCtrV3FzdU50bWN1aTlrcEJzWnJl?=
 =?utf-8?B?Y2NVMzcyZ1lmbUFqM0w4MW5rMjdUUmp2ZkhmOUJxZmFickd3WGQ0TjNoSThQ?=
 =?utf-8?B?QndGZXAxWTYwUkZScU0zU213ZHJXSjdTUC9hNmttVzR5ZTlscHM1VUhtZ05X?=
 =?utf-8?B?a21SdFA3eEZtVm5Sd2d0KzAwQlltOUdZa05hMVc3cTJLZ1pTRXZJSzNsTGEw?=
 =?utf-8?B?SFJyWkxWQ1c2YXljOVhRdkpsbG03VGtJbEJPVEQzWVNMUVRVMnJacjJLOTRJ?=
 =?utf-8?B?ekpaZVNaZnI0blExbk9qV29DZlVSSWJxVGRPSmhuK1VBN3VPOEhhR2JlL2JO?=
 =?utf-8?Q?yh6f7r2BMNxjz3iUBtO8ZcHe9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af9b8e2-da12-49c3-508c-08dc6b86db24
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 15:36:52.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RTxPSKC2c4kLe444JhMKEFNYFphDTsVzttZkOj2xlk8Wo86ogXrSkAc4qafQL0VBvFxUt8wtU3z8eww+EDZ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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

On 5/3/2024 07:05, fililip wrote:
> This patch allows setting a low power cap if |ignore_min_pcap|​ is set to 1.
> 
> Signed-off-by: fililip <fililip6483@protonmail.com>

Rather than an attachment you should send the patch inline.  That would 
mean that your commit message and SoB should be at the top of the patch 
itself.

If you're not aware of it, you should read through:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Basically a maintainer should be able to run:

'b4 shazam $URL'

And it would download the patch and apply it.

That being said my comments on the patch content:

As Alex mentioned a concern about the the maintenance of more 
parameters, maybe it's worth making the sysfs file of the limit 
"writable" instead.

Then when it's written the kernel driver can add_taint() for 
TAINT_FIRMWARE_WORKAROUND when in use so we can see it clearly in logs.



