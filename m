Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500FCC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 19:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED23010E191;
	Mon, 28 Jul 2025 19:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G76vRDCB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF3710E191
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 19:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksd49kstujEPaiSOuwseH1PssD0VWHRqIAlsR0kZ4wBkZXaSmRWo4SO4kfUvEbcOrWGq5BmXIzLIZytu66bAmDjqrwC+4fPp8cjVxv/rNN20k7Qq9UaCu3lyjkPJEeDX5K7WkLwnjXkhSohH27L48q/j1D78yg+g3z3zKMcIS0bFaUFiJNGIowj31p3qSLzObJ71KGMHBZJJQQJ0k/nwBattVONoUjYNWT/gwkd/txyYQ78gnGiHc2t3kQc1MFnWcNBk/ReRcnnvoo4aUT9qYB8/mRFOWKi5rJAKU7R2pZ3GaU8g2udZ6s3nB7u1eHqtxXgdVsj/KhCBbCiMARORYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJESbEfa7HUr8hI8JZGF7WszKbcXBbeuL3C7hOGpF9o=;
 b=XMEclaHUpFGBMv/I2w2wKdCLMsIRJqvJeyiqIW5Mo5hLKrNaoBX8CH4L33EQIDZ55pUHtP0pgZnEzYZvDIX3rRizyfX5+NTrnAbf5TDDvSpl3RUd7Av3u73YNEl2yo9wu6sgW2TWADnIaFBZzENGjV0nDHpIGWgzalRdn9JIQWUsd0Gw0if6dqKrOXMeMke/19pZ1avF+yvUvPAQKesYk76uB/twNMTdwG4Ufg542F3DDQhBkroBJnGmNSefEn/tunwPbfKtPnfGgYhaiWEddZJWd86IXcOvRCGppBs3UQO+O+skN8teLLbNtCsz2I7p26Zsw0zHWBGOw5vMKtB6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJESbEfa7HUr8hI8JZGF7WszKbcXBbeuL3C7hOGpF9o=;
 b=G76vRDCBtV6UdsNo6DljiJbx04gZG8aIumJAjewBEbJe0D4EN8DFhXeaLOnjtBTw6e1QrALn9mvp/dx6ekHV1OSvqHAFnUSmBB3nDwB1LrnvQWx6FyAw+iPE3WukHyy84iYAvyNuaPhJFTCFjwWIU03al68xRB2007HfZHylIQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 19:59:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 19:59:03 +0000
Message-ID: <88f528e6-ab31-4864-8bda-60889a186059@amd.com>
Date: Mon, 28 Jul 2025 15:59:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
 <20250725024316.9273-10-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250725024316.9273-10-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0220.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: c853f1d4-bc0f-45fe-2ea5-08ddce1133e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFVRRlNVWUJvMEtVMDdNSWJlaWljbGpHWmNVbjhKMXEyWWg3K1lRNEJEWkdU?=
 =?utf-8?B?NXg4NVpXc1N5ZnBWdE9UQkg1TTVaM0E0SmoyZkZIdkhGNWxVK242c3pRQWlW?=
 =?utf-8?B?NFQ2dGh0b1NORkFnSXY3elhQajRsMnd0TjA4R2g4bUZwbGdkT2psbmRrOVAv?=
 =?utf-8?B?RUt4M0FwVE9Xd2QvSGdnSXFlTlMrSVJBMG12VkFKNzVoTlQ1bVlncitqUWoz?=
 =?utf-8?B?dHdPYVNpR0VLNEVLWjhOOWFvYXJCS1NjcWRuSENuZEcwN0dIVlkrUjQrUE1Y?=
 =?utf-8?B?MFBXbDhMQm8xaGt4dncwK3Y0RWgvMUt2UWVJeURlNzJueXlNSTZLY1JCZ0Jj?=
 =?utf-8?B?UkNEb0poNHRycUoxYUpjbXlVbk9QWU1sQ3htQ1FxMC9SUEZDMDdQMnFxTUxK?=
 =?utf-8?B?QWlJQm9xS09VWW1YalI2TlM1L3BXMnFMVy9BT05UNnp2Ykw5dTZGcllpZVpn?=
 =?utf-8?B?Ymg2WDlXaW1MMk15NUFnUHhIMjdybUF5bDhwcDhwSUx1OVUycmNLZEFQUjd6?=
 =?utf-8?B?RFIzVXh5bzBJNTMzVVJSa1IzZU5zR0MwYVdKRjhWWFc3T0l2QU12YWlqbmZ5?=
 =?utf-8?B?cjVyak9jckw2QTJ6RUdYRnBVa05wZTl5K2djamFvOFp1c2d0SVdjRlo4MXRr?=
 =?utf-8?B?SkwyQmhxMXloTldXL2FIME4yS0tSbEozWTJGTmlZWEdzZHdRd0FoVkhoaDdT?=
 =?utf-8?B?OU1hVk4xSE14MUhiYTg5Sks4cWVORWUrOEE2MVZLZjlEMnBDUHVGZlFwYnMy?=
 =?utf-8?B?cElmQ0lUQ1hDeGpxYUNoVWl4aFc4RTdUc2RTZ2FzM0pYeTVrUmNnZUJxN0Zq?=
 =?utf-8?B?aGFSbWlCMW5zWUNOamtrRTVmK2ZRcUtuVDJDbmlISmtDZnMzaUNKaVcwWEN1?=
 =?utf-8?B?TFZYZFQySCtnbU1wMEhVVFNnV3pLTDB4aDhIalp3Q09UZzBiOWM2eCs5anVk?=
 =?utf-8?B?VDhlTWFPZVRxb3o1NHZxQjJ0NWFrTDE1YjhjbTdCaVF4Mk93Z0tVRE1aZC81?=
 =?utf-8?B?YXdvdTFIRnZFVU40cXBpSGVWV0JLWnArT2hqM0ViaExpUGFFb3ZJZFlSaVJF?=
 =?utf-8?B?bVRqK1JZRkVMakQwb0hjUmpJTFQxRS84M2pETmVLNWk0NHhjenZ4UE5FME5L?=
 =?utf-8?B?eFMrbEt5SkxQNzNlNm0zQnQ3ekVvNG1xUkQzQ1hrZzNocVJPUW93VDkrR01r?=
 =?utf-8?B?ZktkN0x3akZhS1NuQ0MyVDZidzhJUUNCb3cxYmtNcjdCVUw1Zk85cy9QL3ZU?=
 =?utf-8?B?N3JzZVh1T3p4cUtyU3h1NkN2QTRxQnJTK1VKWStJYzdBdFNtMjBNckh1OVJ1?=
 =?utf-8?B?bGk0TzBjVFU1U1ZtVklNNlorUGxuNFRkVHZtYnBaaUYwKzI2QVJ1WnZuRGwv?=
 =?utf-8?B?TDEyYk9iRm1IdkQ4UzBObDVlUGdVTDBpWjZHWXJFU0FmTEI5UGdsS0I0WHRR?=
 =?utf-8?B?dmtYV0YwTnAyNTd5Um1PZUUwNjlLQmUvVnIwQnhub1ArdDZjN1d1eVhyL1da?=
 =?utf-8?B?MVRkQS9uaDkyWVhya0NiQjMyVk1ZWkt1SlBoMXJweHd3SktBZHN1dkhDM0dK?=
 =?utf-8?B?cUZTWThTdWZSZVYxbmpDRWZwWW5rdXA1YlZ4Zmc0T1gvYUhXWUVrNDF4THY3?=
 =?utf-8?B?djN5djBTVlFrTGVKUnd4QzBmelJjMUc0OGtyLytIOThTWnQ2RnFHVnh3NXp5?=
 =?utf-8?B?MDI1ZnFXdE9zZVU1S2pTOTBRUk5zOGFGVHBoWEwvOTRiZnMwNmI2U25OamJB?=
 =?utf-8?B?bHUxL0pnb3lscXZrRTE1dzJ3Umhma1N5aFM5ZTZYbjdFK2p0bmRaczRLcUJX?=
 =?utf-8?B?eWVqcFp6S1dEYzhiYkRqUjc2QVlsSVR3YW4xclZCYTRFTnFFUXNENWpFeWhN?=
 =?utf-8?B?VkNlMVRGQmlvTTFIc21CS3hRdUgzb0RLSVNXalRPL3g0UkVLM1VsS3JleGNO?=
 =?utf-8?Q?LJ2PP+vSUEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2l0emVJZHJDaUZZRk9ZNjRZSlA2cmowKzdzOVVWQ3VGWGM0TXBaZ3BZcEcw?=
 =?utf-8?B?ZXFTcXRKdTM2NHMvQ2ZvL0M2dWhvLzYwSW9xck1mSnVRMzExald0M2dZOUpz?=
 =?utf-8?B?TmxUa3d3VlpJT0RPNGt3NnUzcUxjbVFpZlJlY21xaEc0cDgvTDArR1lGSTdD?=
 =?utf-8?B?eGErMVM1SEVjUVhoS2Y1R3dXbW1GZUpSSTE5VzhhbHFIS0M5TDR6NHkxdVdD?=
 =?utf-8?B?OHhxQ0llRkFpMU9oYUdMMFZiM2kyZWVweHZRUm4rcVB6VHhlZkdYVy9tMVF2?=
 =?utf-8?B?cEZUR293NDlkTFF0K3I1K2xOYzZaMEkxbC9WOHNEME5wTkFYa1o1THloRk9v?=
 =?utf-8?B?aEg0ek9VWWNIK3Qvc3FNSUlzbzNOdVR4eWdIZFowS2J2UmpobHByNWtuMkhz?=
 =?utf-8?B?akFSNjNUVWUrTUQ3bkZwa2VER3F3dysrN1RmUUhkZXVaTDRpckFXaVJ6VWFa?=
 =?utf-8?B?WlBIc3RJbHYzYXVmY3FmY29TWWxJdWhIOUtBTnRhUW9VQW0vQ1BDNmlMeWIr?=
 =?utf-8?B?L0JZQW1YUnRCNjdPQzB2SUF0ekVGWlJHakZLays4bWxGbnBTblZlSmErdE15?=
 =?utf-8?B?bFIrYnRaME9jUkVPMjAyWWp0Um9tYjFraFpNdE5uTEFqQytZVDZUdVB3THZt?=
 =?utf-8?B?aWFKSDJ2eHVMSFR1UFRpUmZIM1RYNGFVM1EvdUJBL2tTbmdPdldGbmkwMW5R?=
 =?utf-8?B?NnRqWXVMNXp2bGUxWloxRVdoZVZDclp0K3hTeG9lR1ZpMUhMMDFmVEpwYXhj?=
 =?utf-8?B?S1ZUOG9nKzFQZU5iQjhiRGd6MHRRY2c3M1YvME8rUlR3NFA5QnhMcnFWeGZZ?=
 =?utf-8?B?OXZSVkpNdlJ5MzNBeXFzZEpKMTRSM1JOV0hDa093bmVIUldOQWljM2tUaVg1?=
 =?utf-8?B?elFOdHRGRExoVkpWR1ZodFlCckNZcFhoQ3VqRWpSVmsxa2YxNWQrZ3JpR2Zw?=
 =?utf-8?B?SjJzSGxrZnFyM1gydnU0VXV3RU4vMFJEb0YxVTFzYTJvNHlHL0FYbGdYYnl5?=
 =?utf-8?B?SElOUzBLYklucVlERm9TZGxnQ0FhSnZ3bWs1MWJ5aHU2RzZzQXZ1RlRsZkVj?=
 =?utf-8?B?VnpSc0R6dE42ZWM2UVBubGh4bldZMHRsejZVMk16WEZtL1J5cXg3amJtUFJL?=
 =?utf-8?B?STBwM3FoQ3BnMGp2NXl4andwK0FBL05ZZ1cwa0FRMzA5TE1Sai9pYjhMcXVH?=
 =?utf-8?B?dFhyZHZlUXltUENySHhLY3F6cmJ3WDhQS0piR1JTQXp4aEU3N1R2MkcvTEp5?=
 =?utf-8?B?VEJ3Tk9MM3NFV0Q1Rm1KRGVkaURNUUNRYzdsQzMvQTg1WlBHSER4Q0NjNWpt?=
 =?utf-8?B?UDhPVUlSSWZuUWY3ZkhQUEJzU0I1bjN3NklUYW1CaHZVdVh1Wnc3Vm9GamhK?=
 =?utf-8?B?NVpXQVJ5UEhCdEtIQlo3YmlRTENLb3U4dE1tMWlkb2NuNXZjTnJsSEdXQ2hS?=
 =?utf-8?B?ZkwvTDlTQVNZNHZtcmdZOTA1WkZZRjRwMlU2U1RXM2dyL0hCcW0zL2tBZ0FZ?=
 =?utf-8?B?blZUYWIweWNyZlZ0cnl3bGlQLzJhWCtnZERrZUxwcVRlakppQm1DMWdSKzBL?=
 =?utf-8?B?ejJZRnlXd0Q2WHcvTzh2dXNPVmVCQmtZRnRyaElxN1N0d21IWW45SFJ3a213?=
 =?utf-8?B?dTdjV0oxcXVKV3BQTEZJZ1h1ZWJBangxZ1N3N0QrK2JJZXBqWk5PSVNlY1pQ?=
 =?utf-8?B?bGQ5dWVZNXhLZDU2TWF3RTVCYnZzbzZWRGtybnVpelFGamw4WEtVWThhZkpI?=
 =?utf-8?B?cllQNG9zT0p0YjBQYWVVVzB6NENHSXdmR3lkSG1NU2RVZllneStsUFVYSEow?=
 =?utf-8?B?aGFMWC8yU0hkNTZyeERrNDFndnFSNWFoZWZFaER2cnJiMCsxOVJ6bmpTd3ZI?=
 =?utf-8?B?cDFZT2FUZ05rS25DMzlEQ1ZRYlVQc20wSWowc2ZONGhnTTNCaUc1b1lMUWlp?=
 =?utf-8?B?bVpTbnhKTmtzMFVmbm1yQ2dqejFlMDhHL3lyVVlOUnpsSExKdmIvUGhQVUkv?=
 =?utf-8?B?VWxWYWtLUDBnOGJLd2NnbjZNZHBJWTllVkwyTkt3MDRXdUVPazRvWW9BVVBi?=
 =?utf-8?B?YVdweVliMDZBMjJRL2JIUUUvcnptWVJpRkFwVjdvUGFzTDBWVCtpUm9CeWYz?=
 =?utf-8?Q?kpD8tghxCEHeIEJtDM6d+NOKe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c853f1d4-bc0f-45fe-2ea5-08ddce1133e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 19:59:03.9116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLdmOiqKEhYnSqWH37lj7wxYaIh5wZA+6cFDRfWWdQG/5zmxU466WEshynf5lRo3US+aGxrb/w+XkbObNt80aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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

On 2025-07-24 22:43, Zhu Lingshan wrote:
> This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
> that creates a new secondary kfd_progress on the FD.

To add a new ioctl upstream, do you have a link to the corresponding 
user mode changes?

Other than that, this patch looks good to me.

Regards,
   Felix


>
> To keep backward compatibility, userspace programs need to invoke
> this ioctl explicitly on a FD to create a secondary
> kfd_process which replacing its primary kfd_process.
>
> This commit bumps ioctl minor version.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
>   include/uapi/linux/kfd_ioctl.h           |  8 +++--
>   4 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 5b22e1c47b2e..f9c43ff8a89f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3136,6 +3136,44 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	return r;
>   }
>   
> +/* userspace programs need to invoke this ioctl explicitly on a FD to
> + * create a secondary kfd_process which replacing its primary kfd_process
> + */
> +static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	struct kfd_process *process;
> +	int ret;
> +
> +	if (!filep->private_data || !p)
> +		return -EINVAL;
> +
> +	if (p != filep->private_data)
> +		return -EINVAL;
> +
> +	/* Each FD owns only one kfd_process */
> +	if (!p->primary)
> +		return -EINVAL;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	process = create_process(current, false);
> +	mutex_unlock(&kfd_processes_mutex);
> +
> +	if (IS_ERR(process))
> +		return PTR_ERR(process);
> +
> +	/* Each open() increases kref of the primary kfd_process,
> +	 * so we need to reduce it here before we create a new secondary process replacing it
> +	 */
> +	kfd_unref_process(p);
> +
> +	filep->private_data = process;
> +	ret = kfd_create_process_sysfs(process);
> +	if (ret)
> +		pr_warn("Failed to create sysfs entry for the kfd_process");
> +
> +	return 0;
> +}
> +
>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>   	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>   			    .cmd_drv = 0, .name = #ioctl}
> @@ -3254,6 +3292,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
>   			kfd_ioctl_set_debug_trap, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
> +			kfd_ioctl_create_process, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a6e12c705734..a2b5081fbfc0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1051,6 +1051,7 @@ struct kfd_process *kfd_get_process(const struct task_struct *task);
>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>   						 struct kfd_process_device **pdd);
>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
> +struct kfd_process *create_process(const struct task_struct *thread, bool primary);
>   
>   int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
>   int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e1ba9015bb83..15a8de2275f4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -71,7 +71,6 @@ static struct workqueue_struct *kfd_restore_wq;
>   static struct kfd_process *find_process(const struct task_struct *thread,
>   					bool ref);
>   static void kfd_process_ref_release(struct kref *ref);
> -static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
>   
>   static void evict_process_worker(struct work_struct *work);
>   static void restore_process_worker(struct work_struct *work);
> @@ -1598,7 +1597,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>    * On return the kfd_process is fully operational and will be freed when the
>    * mm is released
>    */
> -static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
> +struct kfd_process *create_process(const struct task_struct *thread, bool primary)
>   {
>   	struct kfd_process *process;
>   	struct mmu_notifier *mn;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 04c7d283dc7d..1d206ecc831e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -44,9 +44,10 @@
>    * - 1.16 - Add contiguous VRAM allocation flag
>    * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>    * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
> + * - 1.19 - Add a new ioctl to craete secondary kfd processes
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 18
> +#define KFD_IOCTL_MINOR_VERSION 19
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
> @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
>   #define AMDKFD_IOC_DBG_TRAP			\
>   		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>   
> +#define AMDKFD_IOC_CREATE_PROCESS		\
> +		AMDKFD_IO(0x27)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x27
> +#define AMDKFD_COMMAND_END		0x28
>   
>   #endif
