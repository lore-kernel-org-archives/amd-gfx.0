Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15625C30653
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 07:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8863E10E09A;
	Tue, 25 Jun 2024 07:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5BneneTd";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC4C10E09A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 07:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JclgZ8R+OPX40CjnV+kX/9Tqp9DW5FLF2xUOyGW/+L3hpKFiODmbODXKzfMcBiWKMnWuhU/RxMS84aWkQBzU2R5BBrwyFpPrc/94VumBhYtT048Q6Ve7PcFsG1L0i3BOaEUAuTNli2Yb7Yp/ZlbCH0dsGKppypi5hFf54IkYcyOhNlNxQRQxI0fuILAuLN7xJCtdmaPnIITDn4/hmt9G2BsDuI+FZis8rVT4EjARaA/m0XHgybHueQM2YKDsshsmOSk8FUS7Z6ItyOnyvu8EoeNkyFyrAdB8821HNNZ7RpQJ2ARdr41IvM93EkMxyLFK8AzA1lqMZlBcSXyMXEDgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7AIEPLeszFCQRY2pCwGGt+SAI1qaLGXCqkWrCTIWb4=;
 b=LxpbEIFVM4+iUpEA/LhwAc9Dy3L9Nkg4QggXaAd7/QJRUrmwxUlBe+cDaRcuynTmGWoKGld7kSh29tCqE9sny2dRmYlED+gStH3EAqBbAUryMweE+nXpRTCnEr10TBKjd5nOyNlg19N1yhPSKH2jkdvjYmDyg5EqrGoVXdZAY8zICUMvasv/+FXWK3bwbg8kpgKCCBVkygFx3qXArncPo1x6do7dj9UPkSnUre3I1ruPXc1Q9UUDNN45LSkH/CuzxM4+qMN3N2R5ICCUqpVqyqKagv5uGaaPXnLsW+k3HgnODJhKwd076KRZUbIVaCo3DlnBoKCBYYJoLCs1HqOvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7AIEPLeszFCQRY2pCwGGt+SAI1qaLGXCqkWrCTIWb4=;
 b=5BneneTdqo1JwtlPp0W55xBkTaonzEg9rBbDhkjtCXZR8Tx3s/tFLX98Mz1Ns8RX0XpKvsgsAJtKixTp2kiKFpAxYqsMN+/f991RxOmSmWfZzXy8nnYr1KZHVBPRF4A4RvSlimFmC3uxTByT+C5/4QOnoWLkheidrfT8rR57/aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) by
 DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Tue, 25 Jun 2024 07:02:08 +0000
Received: from DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::88d2:c637:770b:7678]) by DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::88d2:c637:770b:7678%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:02:06 +0000
Content-Type: multipart/alternative;
 boundary="------------fHPL3Uo4003Sbd20uhgJUlAc"
Message-ID: <898c76b8-3570-485e-86ef-81c07ff7bb77@amd.com>
Date: Tue, 25 Jun 2024 12:31:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: FW: [PATCH] drm/amdgpu/jpeg5: Add support for DPG mode
To: amd-gfx@lists.freedesktop.org, Sonny.Jiang@amd.com
References: <20240624175820.1508394-1-sonny.jiang@amd.com>
 <CH3PR12MB77628334F277DD806816E699FAD52@CH3PR12MB7762.namprd12.prod.outlook.com>
Content-Language: en-US
From: Saleemkhan Jamadar <Saleemkhan.Jamadar@amd.com>
In-Reply-To: <CH3PR12MB77628334F277DD806816E699FAD52@CH3PR12MB7762.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To DM5PR12MB2565.namprd12.prod.outlook.com
 (2603:10b6:4:b8::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2565:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c27aeb2-a6d2-42cb-9287-08dc94e4b939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGdBQ2NTTUtnaytOdWV5WG42eElZQUREMU9IbnRSS3FuVFhGMEtNQTU4TGxR?=
 =?utf-8?B?NXhRRjVLUEFOMmNVcC9QTWZQZk9BUU9WcVdscThwK3NuY3Zvck5QTm5CY2t6?=
 =?utf-8?B?T2ozcTVHdzJEajRobG5XRnZiNzIza0pFY21GcWdrUUl1UEpLeGRPWDdLSmdF?=
 =?utf-8?B?d09CK3BpRjNrQnNPMnJldmR2L29sdW1vM3ZWN0EyRHFFcHZyRkJtVEpaR1di?=
 =?utf-8?B?SGN1RFdiUmtuenNGS28zelZFZEhRck1sRlBKQkx1Z2dzOXNKejhaUWQ2enJa?=
 =?utf-8?B?aktBZjk5UVAzY0NLS1d3VVcreHJieWpWcjJaK0tMSVBMNUVWL1RoaU0rOGl2?=
 =?utf-8?B?MEhYRlFOSGsrZUFzR3ZZNWY2ZUVHRjR1WXpzQzR4dlE1S3BIU2VXYXVrdU95?=
 =?utf-8?B?a3hRMEY3TzdjR0NuMkdPNWt3VTBMRVdVVnFBcUp4TnpYTSs0SGxxVXlybW01?=
 =?utf-8?B?bVg1dTFrRXloVm5HWGwrQXYzTnp3aHI3UHphMlZEV2JJRHpod0lGeHZ1dlNm?=
 =?utf-8?B?RitvbzdCME84eEFkT3NnV0pFc0F6L3RhNUhJclNKQmJBRFVraGkzaitDalZy?=
 =?utf-8?B?Z2JLOC84ZUZnNFA0c1Z3cm5VK3lycDJRUnRreDBPUlZBY3NLMFV1RE9LYUlK?=
 =?utf-8?B?cjNUdkZTcmd6akpSMTM5NHhtcEMrazQ4ZHJVclp0dTZ1ZlRCWnpSdU0zQjVV?=
 =?utf-8?B?UUhxZ2lQQk9ZaGVqL0N1aTliN2RHSVhqTjVBdTVlMFJFa1pIK3BKUm9QTnJN?=
 =?utf-8?B?NmRuN1RJTC8wbitUTHVJMlBsa2NUZFFJWjRZYXBhV3Z2ZERDejNDTEVsYitN?=
 =?utf-8?B?MW5YQXhEaEtBM2E3WkhTNG1rVTcydkV4eTZVaWMyZGlZazNKUk13UmJmVW9a?=
 =?utf-8?B?c29QOXdFbkUwNDc5eVdzNlN5Mk12VTZkdkdyRW1mTy9TWE9ma1oxa29UTjN5?=
 =?utf-8?B?SExoc0lLaktMZUE3OEJHdlFZbFpnd1MrSElaU3pCbkFId3B3M290b2NuZlQy?=
 =?utf-8?B?WVBtSkxxNVphYjJoZ3hjVzlhaWpOb0ZZNStpMlYvcnhSMTVWQ2RpazVlakVC?=
 =?utf-8?B?NEFqbVZUSERXb1FtTjhxSFdhOWk1dER5WXlYTE1vRU1mM3hwMURjazlMV0xV?=
 =?utf-8?B?QU05LzR1VFQyK251ZDdzbW5yTzlKN2t1WjdRcHNraGhsdUpoSGxEUkV5N0ls?=
 =?utf-8?B?MEY3enJrR1J2SnFBSlE5Nk1JYnRLZ2xIY0M3dFZDa1BwdkJUQVFaRm9OTFZy?=
 =?utf-8?B?aWtuSHJRTCsvLzhnekh2Y3pYakRMVnRBQWMycERDZkorRU1obXV1UlFhcS92?=
 =?utf-8?B?dnJJWFlCYTlyNUNXbGtFRFBZeVU4V0FzeFQ1Zk9IZTBQVmFKdkFQR2NWMDI1?=
 =?utf-8?B?cVNKc2tpb1h1SWRybFBVdUE1NiszQ1NkK3N4MXZieFRvOE1LUEFNaElBZnhH?=
 =?utf-8?B?SGhlSzBDUll6cE5KUk1tMkZnRTRyY01lRE5pTHhGdVhBYkRvdFUzcllRMlpH?=
 =?utf-8?B?UzZOSG01VTN6Qm9GaWtmbmticWd2QXBKSzgydG9aaEdKRjQ0YU51bU9iVHY1?=
 =?utf-8?B?SFdvekV3ZWxoM1MrZVlwZWlKaE5uOWtnMWkwSnZOR0E2TEowNkl6Qk1TSjdV?=
 =?utf-8?B?di9FVHhuaXlJRWU1YXBDWU5HQWpxVDJvTE9QOVpPUEk0RlNENWFKYVlzYVgr?=
 =?utf-8?B?eHdqZjJ2U1VYdDRRRlJNYUNTLzBUanJUY3RiYlRnS0YzQzMxb3M5VjRrVmFm?=
 =?utf-8?Q?GAUcOoD1qxNOfjdPY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTIrUzdBRExSSW5PSHhZdmhsM3RlcS8vUWtITkVjUnplWldRdXJJSUtTSHpH?=
 =?utf-8?B?SG9aa0c5elJZVzFjSzRRalRLRG0zcGVkVVdBWXk2VUVFTTBTSVlMWDhGNVEy?=
 =?utf-8?B?MllvVUU3Wkd2RDdOZjJldTU1a3FSMGNzbFRqMU5OMXN6TGx4SnIySEhpc1li?=
 =?utf-8?B?ckY1QjAxSzI2Y3JzcmtGT0hleU1FTnpXbThMQnlyZHdMNkJJaHY5OXVNdFdY?=
 =?utf-8?B?ZW42NVFrbXNYVmt0dFcwSjZWR0VkRzEvMHEwU0NSSE9leTdQWlU3ei94Vjlp?=
 =?utf-8?B?ODhuREZ5eUNwRmVRWDlIQzJ0R2RUVUJVVHIzNE1SK3RZd0hHWFJmODVaR2ZQ?=
 =?utf-8?B?VW5QZC85QjNBNDhCSVRsU0NsQVNiR2JkbW5vcjRZMThqbnNOODRwdkR4dzYy?=
 =?utf-8?B?VGxtUDNZS3ArV0NuTUtrK3Uwd0JSUTdtUVg5QlUrWE9YUHFUZk1ZUE9VN1Z0?=
 =?utf-8?B?blNZMGNTRE9DWWg2UWNTQ3hkQkVJUTc3UHRKeUdUL05SVEd2TFdva2w2bFJU?=
 =?utf-8?B?MVhYMTE1VnVKMG5acXE3Z29ZMENXdFVuc2wxZzNoSkFCYlJwR2RMOVd6YndD?=
 =?utf-8?B?YldrZzlKS0k4MG1EQVRzYzlaeFZTYS9RRXM0eVBrZVlYZzFiVWt0NjgvZ2lO?=
 =?utf-8?B?ZkdSREFWMkVaQ25lK043TGxQNlRVYzFzRzljcmdXMWhTbG4xbHo4dDZ0eEh2?=
 =?utf-8?B?QXFQWHYxV1hpazdHdCtTQ0RVaUM1UnFwRE0xNGVQU05Qb1NQbEpKMlVDeVp2?=
 =?utf-8?B?SGxIM2pDNmR0bkczSi9mNGxUa3JranBXSjB6SFVxMjBFWEtoM0VOQlNsVWlr?=
 =?utf-8?B?V3lVU0hXNEo0RnVLM1puK0tVdWlFSU9YY0kwS05CS3VmOGpSZkg1V0ZtQ200?=
 =?utf-8?B?RWhldVl2Y1BuN3QxZGVadjlZVW81VjQvS3ZpVFVwTzFuekRJV3dRaTNxYTVy?=
 =?utf-8?B?eHVNTFRkOHhUUFlwcUJDV1VCczVxQmIrVC9rYjFVZHZsemp4SXNDTFljNnQw?=
 =?utf-8?B?bi8zMjhkR2hsdWIrTDNPWFg1UnlKREVUeHplQ0pON0pKS3lDWEZyUFovZEhS?=
 =?utf-8?B?S1JIQmFHMEJmcVJmZlRETVg5UU4rNGQ2MGZRVmJzWnpDMm5HSzJGS0czNzJP?=
 =?utf-8?B?WWRISlpoVlJZY0FIU0hRNERVNlpiV2Z0dlNkTXVUblB0TUtEWGJHMjhubjMw?=
 =?utf-8?B?cktsRUVTd0lTMlZXV2NSZzJBRk1wNXN6TFl6UUh4NjJnMldWNW8xS2JBSmRx?=
 =?utf-8?B?VVNUUTR4TDRIRTN1ckRQU2dReG1zMWpVVTEzakV3UHhybDZTbmMrZE5kZWM4?=
 =?utf-8?B?WUFFakNrWVkvUGFiU0VmdktPdlhVUE1jWk9TandlRmNkQWxXM1g0TWRMOG4x?=
 =?utf-8?B?R2pkRklwTXRNbFJGZWtQamg5NGhEOUZHYi9WaENMcm1yQUJMaERIUE5Lcnlz?=
 =?utf-8?B?OG96SjJObEoxTnJsazdwV1F0S3UxOXRwWitua3Z4UCt6OUorQkJHQUtOTXl1?=
 =?utf-8?B?T3NaSWdHb1BjVS8ySzhlYysvclNqTlFia1FMOW5Za3VsS0NtRTg4dlBkajlk?=
 =?utf-8?B?N2xsL1dQc25Cb25nVlAwUW10ampsR1d6dHJtWXB4dFJoNU1CSG9PVnBCQzZY?=
 =?utf-8?B?ZWY1TUdiNm1LVWxlWXQ4ODEzZnNHeU4ycWtFRmp3TnR5Mnc4SnhwS1ZHTUVh?=
 =?utf-8?B?SzJHVEVrTTFZNjNmUGJPMllDdCtyeDVhbm1XSi9WZXJkU2RpUGpXanNRVmda?=
 =?utf-8?B?em0rdll0WDgvbzVpM0tGdjJQMTh2SGoyWGZlYld5a21XR0hBa0VZN0JvSlNw?=
 =?utf-8?B?K25hRVp4K2U4QzVPdkN4aEhGdWdyS1NtK0NzUUg3M09Hd2ZSYW1sR1pZQlJu?=
 =?utf-8?B?dnZUSi9HREVEd0VYTyttRnNPdkZPdGR0M21ycDlwdkFyeWpwVDZYVDBtWUhO?=
 =?utf-8?B?YXBFR3ZTclBqaU9zMGFMY0s0RHd5Tld4MmxJSlV0Y1AwQWFOaFNoaGJjTHNu?=
 =?utf-8?B?R2RRdlA2ZGdmUjIyWjRqUlJGUkhYRm0xdVN0Vk1BM0hZOW1ZSWcvSXBEM0J4?=
 =?utf-8?B?Rk9vczFtN013dTNxMFN3dW8wdWdyRk04ZnhUMWdhMTd4dzVNS0w0NXVDT3pq?=
 =?utf-8?Q?F9FWzEIxpWPSFS//d7p1hlTEB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c27aeb2-a6d2-42cb-9287-08dc94e4b939
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:02:06.4664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3Q7UX5OXeLjZoogo0MFhtVfB8WdRCE0WwadulvLF/roohTGAQSNfuhBBp1DVMztgcITx/uCmW/ltClI3HwrgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

--------------fHPL3Uo4003Sbd20uhgJUlAc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Looks good to me !

Acked-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

> -----Original Message-----
> From: amd-gfx<amd-gfx-bounces@lists.freedesktop.org>  On Behalf Of Sonny Jiang
> Sent: Monday, June 24, 2024 11:28 PM
> To:amd-gfx@lists.freedesktop.org
> Cc: Jiang, Sonny<Sonny.Jiang@amd.com>
> Subject: [PATCH] drm/amdgpu/jpeg5: Add support for DPG mode
>
> From: Sonny Jiang<sonjiang@amd.com>
>
> Add DPG support for JPEG 5.0
>
> Signed-off-by: Sonny Jiang<sonjiang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  31 +++++  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 159 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |   6 +
>   drivers/gpu/drm/amd/amdgpu/soc24.c       |   1 +
>   4 files changed, 180 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index aea31d61d991..f9cdd873ac9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -60,6 +60,37 @@
>                  RREG32_SOC15(JPEG, inst_idx, mmUVD_DPG_LMA_DATA);                               \
>          })
>
> +#define WREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, value, indirect)          \
> +       do {                                                                    \
> +               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
> +                            regUVD_DPG_LMA_DATA, value);                       \
> +               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
> +                            regUVD_DPG_LMA_MASK, 0xFFFFFFFF);                  \
> +               WREG32_SOC15(                                                   \
> +                       JPEG, GET_INST(JPEG, inst_idx),                         \
> +                       regUVD_DPG_LMA_CTL,                                     \
> +                       (UVD_DPG_LMA_CTL__READ_WRITE_MASK |                     \
> +                        offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT |    \
> +                        indirect << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT));        \
> +       } while (0)
> +
> +#define RREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, mask_en)                  \
> +       do {                                                                    \
> +               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
> +                       regUVD_DPG_LMA_MASK, 0xFFFFFFFF);                       \
> +               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
> +                       regUVD_DPG_LMA_CTL,                                     \
> +                       (UVD_DPG_LMA_CTL__MASK_EN_MASK |                        \
> +                       offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));    \
> +               RREG32_SOC15(JPEG, inst_idx, regUVD_DPG_LMA_DATA);              \
> +       } while (0)
> +
> +#define ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, offset, value, indirect)          \
> +       do {                                                                    \
> +               *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = offset;       \
> +               *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;        \
> +       } while (0)
> +
>   struct amdgpu_jpeg_reg{
>          unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index e766b9463759..d694a276498a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -31,6 +31,7 @@
>   #include "vcn/vcn_5_0_0_offset.h"
>   #include "vcn/vcn_5_0_0_sh_mask.h"
>   #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
> +#include "jpeg_v5_0_0.h"
>
>   static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);  static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev); @@ -137,6 +138,10 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>          adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                          (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> +       /* Skip ring test because pause DPG is not implemented. */
> +       if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG)
> +               return 0;
> +
>          r = amdgpu_ring_test_helper(ring);
>          if (r)
>                  return r;
> @@ -235,7 +240,7 @@ static void jpeg_v5_0_0_enable_clock_gating(struct amdgpu_device *adev)
>          WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);  }
>
> -static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
> +static int jpeg_v5_0_0_disable_power_gating(struct amdgpu_device *adev)
>   {
>          uint32_t data = 0;
>
> @@ -248,14 +253,10 @@ static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
>          WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
>                  ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>
> -       /* keep the JPEG in static PG mode */
> -       WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
> -               ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
> -
>          return 0;
>   }
>
> -static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
> +static int jpeg_v5_0_0_enable_power_gating(struct amdgpu_device *adev)
>   {
>          /* enable anti hang mechanism */
>          WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), @@ -273,6 +274,121 @@ static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
>          return 0;
>   }
>
> +static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_device *adev,
> +              int inst_idx, uint8_t indirect) {
> +       uint32_t data = 0;
> +
> +       // JPEG disable CGC
> +       if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
> +               data = 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +       else
> +               data = 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +
> +       data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +       data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +
> +       if (indirect) {
> +               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, data,
> +indirect);
> +
> +               // Turn on All JPEG clocks
> +               data = 0;
> +               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
> +       } else {
> +               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, data,
> +indirect);
> +
> +               // Turn on All JPEG clocks
> +               data = 0;
> +               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
> +       }
> +}
> +
> +/**
> + * jpeg_v5_0_0_start_dpg_mode - Jpeg start with dpg mode
> + *
> + * @adev: amdgpu_device pointer
> + * @inst_idx: instance number index
> + * @indirect: indirectly write sram
> + *
> + * Start JPEG block with dpg mode
> + */
> +static int jpeg_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int
> +inst_idx, bool indirect) {
> +       struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
> +       uint32_t reg_data = 0;
> +
> +       jpeg_v5_0_0_enable_power_gating(adev);
> +
> +       // enable dynamic power gating mode
> +       reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
> +       reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
> +
> +       if (indirect)
> +               adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =
> +                       (uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr;
> +
> +       jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect);
> +
> +       /* MJPEG global tiling registers */
> +       if (indirect)
> +               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
> +                       adev->gfx.config.gb_addr_config, indirect);
> +       else
> +               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
> +                       adev->gfx.config.gb_addr_config, 1);
> +
> +       /* enable System Interrupt for JRBC */
> +       if (indirect)
> +               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN,
> +                       JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
> +       else
> +               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN,
> +                       JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
> +
> +       if (indirect) {
> +               /* add nop to workaround PSP size check */
> +               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, indirect);
> +
> +               amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
> +       }
> +
> +       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
> +               ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> +               VCN_JPEG_DB_CTRL__EN_MASK);
> +
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> +               lower_32_bits(ring->gpu_addr));
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> +               upper_32_bits(ring->gpu_addr));
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_RPTR, 0);
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR, 0);
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
> +       ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
> +
> +       return 0;
> +}
> +
> +/**
> + * jpeg_v5_0_0_stop_dpg_mode - Jpeg stop with dpg mode
> + *
> + * @adev: amdgpu_device pointer
> + * @inst_idx: instance number index
> + *
> + * Stop JPEG block with dpg mode
> + */
> +static void jpeg_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int
> +inst_idx) {
> +       uint32_t reg_data = 0;
> +
> +       reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
> +       reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
> +       WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data); }
> +
>   /**
>    * jpeg_v5_0_0_start - start JPEG block
>    *
> @@ -288,8 +404,13 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
>          if (adev->pm.dpm_enabled)
>                  amdgpu_dpm_enable_jpeg(adev, true);
>
> +       if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> +               r = jpeg_v5_0_0_start_dpg_mode(adev, 0, adev->jpeg.indirect_sram);
> +               return r;
> +       }
> +
>          /* disable power gating */
> -       r = jpeg_v5_0_0_disable_static_power_gating(adev);
> +       r = jpeg_v5_0_0_disable_power_gating(adev);
>          if (r)
>                  return r;
>
> @@ -300,7 +421,6 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
>          WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
>                  adev->gfx.config.gb_addr_config);
>
> -
>          /* enable JMI channel */
>          WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
>                  ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> @@ -340,17 +460,22 @@ static int jpeg_v5_0_0_stop(struct amdgpu_device *adev)  {
>          int r;
>
> -       /* reset JMI */
> -       WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
> -               UVD_JMI_CNTL__SOFT_RESET_MASK,
> -               ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> +       if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> +               jpeg_v5_0_0_stop_dpg_mode(adev, 0);
> +       } else {
>
> -       jpeg_v5_0_0_enable_clock_gating(adev);
> +               /* reset JMI */
> +               WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
> +                       UVD_JMI_CNTL__SOFT_RESET_MASK,
> +                       ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>
> -       /* enable power gating */
> -       r = jpeg_v5_0_0_enable_static_power_gating(adev);
> -       if (r)
> -               return r;
> +               jpeg_v5_0_0_enable_clock_gating(adev);
> +
> +               /* enable power gating */
> +               r = jpeg_v5_0_0_enable_power_gating(adev);
> +               if (r)
> +                       return r;
> +       }
>
>          if (adev->pm.dpm_enabled)
>                  amdgpu_dpm_enable_jpeg(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> index bd348336b215..5abb96159814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> @@ -24,6 +24,12 @@
>   #ifndef __JPEG_V5_0_0_H__
>   #define __JPEG_V5_0_0_H__
>
> +#define vcnipJPEG_CGC_GATE                                 0x4160
> +#define vcnipJPEG_CGC_CTRL                                 0x4161
> +#define vcnipJPEG_SYS_INT_EN                               0x4141
> +#define vcnipUVD_NO_OP                                     0x0029
> +#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
> +
>   extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
>
>   #endif /* __JPEG_V5_0_0_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index a15673e2dc99..d27fb4ea6612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -428,6 +428,7 @@ static int soc24_common_early_init(void *handle)
>
>                  adev->pg_flags = AMD_PG_SUPPORT_VCN |
>                          AMD_PG_SUPPORT_JPEG |
> +                       AMD_PG_SUPPORT_JPEG_DPG |
>                          AMD_PG_SUPPORT_VCN_DPG;
>                  adev->external_rev_id = adev->rev_id + 0x50;
>                  break;
> --
> 2.45.1
>
--------------fHPL3Uo4003Sbd20uhgJUlAc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi, <br>
    </p>
    <p>Looks good to me !</p>
    <p>Acked-by: Saleemkhan Jamadar <a class="moz-txt-link-rfc2396E" href="mailto:saleemkhan.jamadar@amd.com">&lt;saleemkhan.jamadar@amd.com&gt;</a><br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:CH3PR12MB77628334F277DD806816E699FAD52@CH3PR12MB7762.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of Sonny Jiang
Sent: Monday, June 24, 2024 11:28 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Jiang, Sonny <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a>
Subject: [PATCH] drm/amdgpu/jpeg5: Add support for DPG mode

From: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonjiang@amd.com">&lt;sonjiang@amd.com&gt;</a>

Add DPG support for JPEG 5.0

Signed-off-by: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonjiang@amd.com">&lt;sonjiang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  31 +++++  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 159 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |   6 +
 drivers/gpu/drm/amd/amdgpu/soc24.c       |   1 +
 4 files changed, 180 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index aea31d61d991..f9cdd873ac9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -60,6 +60,37 @@
                RREG32_SOC15(JPEG, inst_idx, mmUVD_DPG_LMA_DATA);                               \
        })

+#define WREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, value, indirect)          \
+       do {                                                                    \
+               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
+                            regUVD_DPG_LMA_DATA, value);                       \
+               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
+                            regUVD_DPG_LMA_MASK, 0xFFFFFFFF);                  \
+               WREG32_SOC15(                                                   \
+                       JPEG, GET_INST(JPEG, inst_idx),                         \
+                       regUVD_DPG_LMA_CTL,                                     \
+                       (UVD_DPG_LMA_CTL__READ_WRITE_MASK |                     \
+                        offset &lt;&lt; UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT |    \
+                        indirect &lt;&lt; UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT));        \
+       } while (0)
+
+#define RREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, mask_en)                  \
+       do {                                                                    \
+               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
+                       regUVD_DPG_LMA_MASK, 0xFFFFFFFF);                       \
+               WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),                    \
+                       regUVD_DPG_LMA_CTL,                                     \
+                       (UVD_DPG_LMA_CTL__MASK_EN_MASK |                        \
+                       offset &lt;&lt; UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));    \
+               RREG32_SOC15(JPEG, inst_idx, regUVD_DPG_LMA_DATA);              \
+       } while (0)
+
+#define ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, offset, value, indirect)          \
+       do {                                                                    \
+               *adev-&gt;jpeg.inst[inst_idx].dpg_sram_curr_addr++ = offset;       \
+               *adev-&gt;jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;        \
+       } while (0)
+
 struct amdgpu_jpeg_reg{
        unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index e766b9463759..d694a276498a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -31,6 +31,7 @@
 #include &quot;vcn/vcn_5_0_0_offset.h&quot;
 #include &quot;vcn/vcn_5_0_0_sh_mask.h&quot;
 #include &quot;ivsrcid/vcn/irqsrcs_vcn_4_0.h&quot;
+#include &quot;jpeg_v5_0_0.h&quot;

 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);  static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev); @@ -137,6 +138,10 @@ static int jpeg_v5_0_0_hw_init(void *handle)
        adev-&gt;nbio.funcs-&gt;vcn_doorbell_range(adev, ring-&gt;use_doorbell,
                        (adev-&gt;doorbell_index.vcn.vcn_ring0_1 &lt;&lt; 1), 0);

+       /* Skip ring test because pause DPG is not implemented. */
+       if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_JPEG_DPG)
+               return 0;
+
        r = amdgpu_ring_test_helper(ring);
        if (r)
                return r;
@@ -235,7 +240,7 @@ static void jpeg_v5_0_0_enable_clock_gating(struct amdgpu_device *adev)
        WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);  }

-static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
+static int jpeg_v5_0_0_disable_power_gating(struct amdgpu_device *adev)
 {
        uint32_t data = 0;

@@ -248,14 +253,10 @@ static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
        WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
                ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);

-       /* keep the JPEG in static PG mode */
-       WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
-               ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
-
        return 0;
 }

-static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
+static int jpeg_v5_0_0_enable_power_gating(struct amdgpu_device *adev)
 {
        /* enable anti hang mechanism */
        WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), @@ -273,6 +274,121 @@ static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
        return 0;
 }

+static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_device *adev,
+              int inst_idx, uint8_t indirect) {
+       uint32_t data = 0;
+
+       // JPEG disable CGC
+       if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_JPEG_MGCG)
+               data = 1 &lt;&lt; JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+       else
+               data = 0 &lt;&lt; JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+       data |= 1 &lt;&lt; JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+       data |= 4 &lt;&lt; JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+
+       if (indirect) {
+               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, data,
+indirect);
+
+               // Turn on All JPEG clocks
+               data = 0;
+               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
+       } else {
+               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, data,
+indirect);
+
+               // Turn on All JPEG clocks
+               data = 0;
+               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
+       }
+}
+
+/**
+ * jpeg_v5_0_0_start_dpg_mode - Jpeg start with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
+ *
+ * Start JPEG block with dpg mode
+ */
+static int jpeg_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int
+inst_idx, bool indirect) {
+       struct amdgpu_ring *ring = adev-&gt;jpeg.inst[inst_idx].ring_dec;
+       uint32_t reg_data = 0;
+
+       jpeg_v5_0_0_enable_power_gating(adev);
+
+       // enable dynamic power gating mode
+       reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+       reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
+
+       if (indirect)
+               adev-&gt;jpeg.inst[inst_idx].dpg_sram_curr_addr =
+                       (uint32_t *)adev-&gt;jpeg.inst[inst_idx].dpg_sram_cpu_addr;
+
+       jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect);
+
+       /* MJPEG global tiling registers */
+       if (indirect)
+               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
+                       adev-&gt;gfx.config.gb_addr_config, indirect);
+       else
+               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
+                       adev-&gt;gfx.config.gb_addr_config, 1);
+
+       /* enable System Interrupt for JRBC */
+       if (indirect)
+               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN,
+                       JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
+       else
+               WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN,
+                       JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
+
+       if (indirect) {
+               /* add nop to workaround PSP size check */
+               ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, indirect);
+
+               amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
+       }
+
+       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+               ring-&gt;doorbell_index &lt;&lt; VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+               VCN_JPEG_DB_CTRL__EN_MASK);
+
+       WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+       WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+               lower_32_bits(ring-&gt;gpu_addr));
+       WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+               upper_32_bits(ring-&gt;gpu_addr));
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_RPTR, 0);
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR, 0);
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring-&gt;ring_size / 4);
+       ring-&gt;wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
+
+       return 0;
+}
+
+/**
+ * jpeg_v5_0_0_stop_dpg_mode - Jpeg stop with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ *
+ * Stop JPEG block with dpg mode
+ */
+static void jpeg_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int
+inst_idx) {
+       uint32_t reg_data = 0;
+
+       reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+       reg_data &amp;= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+       WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data); }
+
 /**
  * jpeg_v5_0_0_start - start JPEG block
  *
@@ -288,8 +404,13 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
        if (adev-&gt;pm.dpm_enabled)
                amdgpu_dpm_enable_jpeg(adev, true);

+       if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_JPEG_DPG) {
+               r = jpeg_v5_0_0_start_dpg_mode(adev, 0, adev-&gt;jpeg.indirect_sram);
+               return r;
+       }
+
        /* disable power gating */
-       r = jpeg_v5_0_0_disable_static_power_gating(adev);
+       r = jpeg_v5_0_0_disable_power_gating(adev);
        if (r)
                return r;

@@ -300,7 +421,6 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
        WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
                adev-&gt;gfx.config.gb_addr_config);

-
        /* enable JMI channel */
        WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
                ~UVD_JMI_CNTL__SOFT_RESET_MASK);
@@ -340,17 +460,22 @@ static int jpeg_v5_0_0_stop(struct amdgpu_device *adev)  {
        int r;

-       /* reset JMI */
-       WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
-               UVD_JMI_CNTL__SOFT_RESET_MASK,
-               ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+       if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_JPEG_DPG) {
+               jpeg_v5_0_0_stop_dpg_mode(adev, 0);
+       } else {

-       jpeg_v5_0_0_enable_clock_gating(adev);
+               /* reset JMI */
+               WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
+                       UVD_JMI_CNTL__SOFT_RESET_MASK,
+                       ~UVD_JMI_CNTL__SOFT_RESET_MASK);

-       /* enable power gating */
-       r = jpeg_v5_0_0_enable_static_power_gating(adev);
-       if (r)
-               return r;
+               jpeg_v5_0_0_enable_clock_gating(adev);
+
+               /* enable power gating */
+               r = jpeg_v5_0_0_enable_power_gating(adev);
+               if (r)
+                       return r;
+       }

        if (adev-&gt;pm.dpm_enabled)
                amdgpu_dpm_enable_jpeg(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
index bd348336b215..5abb96159814 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
@@ -24,6 +24,12 @@
 #ifndef __JPEG_V5_0_0_H__
 #define __JPEG_V5_0_0_H__

+#define vcnipJPEG_CGC_GATE                                 0x4160
+#define vcnipJPEG_CGC_CTRL                                 0x4161
+#define vcnipJPEG_SYS_INT_EN                               0x4141
+#define vcnipUVD_NO_OP                                     0x0029
+#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
+
 extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;

 #endif /* __JPEG_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index a15673e2dc99..d27fb4ea6612 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -428,6 +428,7 @@ static int soc24_common_early_init(void *handle)

                adev-&gt;pg_flags = AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_JPEG |
+                       AMD_PG_SUPPORT_JPEG_DPG |
                        AMD_PG_SUPPORT_VCN_DPG;
                adev-&gt;external_rev_id = adev-&gt;rev_id + 0x50;
                break;
--
2.45.1

</pre>
    </blockquote>
  </body>
</html>

--------------fHPL3Uo4003Sbd20uhgJUlAc--
