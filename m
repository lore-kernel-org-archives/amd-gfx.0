Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FABEC144C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 14:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4968826D;
	Tue,  3 Mar 2026 14:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qii6aC3e";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D566D8826D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 14:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjVY8t/SzYGtyOnu4htIifpnTZczTqzF7rzPGKdrS01ikAmTBt3ja7JDF58ottNtqc/ggYghvco327Rtly5d1m1qmE57oOtnjVqT/CPxhqVA1lYlxoenUUEgBm/sph5mfOs1ddY/RFBZOA7QumSbW4iHvcEclXTC3MqqPKlKDJCOr7w44i5Yg/Kub/gamA2997tdJ8dIqwaU3Nz+HhwBFK4A7FeyaO/EePYiCdlujvXfAW9cxEi6bJOLVTZoL6u0YyTJ+3ox8kGrHav2nq4XCFErkuY8qZgYUW0aADMa+EvxwLdartaznXMvJdCgVay2lHoPFFnKCTAaeJuQMCrYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM2+8P5pWjA8zY87uNau7beDnQEb3xjE+8ioXuSW2d0=;
 b=UkThNONBS2ejGMutB1n2rz3JT8f0Q1FfxKIVx6/dp1Qu3e9hZJeQm1DMy08KvoTOjJ8PMDfKiqSPPOYjnddNg3BiSx8prFwHLcguZjYqgW1Qm8ElxsnQk3wG72solpc+N9acPOiZ5UxfOAZqijG+SgGCNiS1ZuwHFgx0vCZ8wrV18ZJ1XsJGriXLa8U+ppAdUnVtVjbQqEhhzfiYVjGrQ474HzMjkj3k5ZcPL3zFMwp4XJx/pa8YsU9O/fkJ9yR6H/XtReWi8dxi1pKhmu0N9mYHNv7j3H1mOrrX/A0gvqDeTrMSI2DJ46GXrSItOiBUtLp8ZMGgaQVqVoCSSeX3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM2+8P5pWjA8zY87uNau7beDnQEb3xjE+8ioXuSW2d0=;
 b=qii6aC3e/W1/dbmY8U74jhMQW2gSTwjiZ+3M7ezeuqbse7qJX2GOmrnIrV/Qm+jk3h+8OqncOle61O2sDlXg4yRVZdsodSLsvtjOfODt4BKiuBpBcDI0WRh43TnY4zMIvdK3xzld21925uL6OAZY40PlysMP4C9T+CTG0gAnib4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:13:33 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:13:33 +0000
Message-ID: <9c4b7ff3-ec22-43d3-93fc-1c0cb7de0e65@amd.com>
Date: Tue, 3 Mar 2026 19:43:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260303120654.2582995-1-sunil.khatri@amd.com>
 <38ec1a98-d112-4345-9711-d023a3e10da9@amd.com>
 <aeafbd1a-49a4-4049-8523-b29f78344fd3@amd.com>
 <e7b07f6f-c90c-4b78-910e-860c36280ced@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <e7b07f6f-c90c-4b78-910e-860c36280ced@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eac8bcd-2ec3-4c4f-cf0d-08de792f0d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: Bfe1JHqWnwaY7usHoqnvbnb5XuRkAclEkOrHpy//lNQTB98/rHMj6NifrUTZOri9dwHnMRpaqsAaDjBi84mzIBxIvdoF+AH1jjsXwA3UAkBJhGG70xOTQD8g9KLy+Fw8ZjkwUirsYMwKyRWWNKSZKecbJYkFNP36GSGOispktkUe+zRCinaV9uVE3+DDPedpRFjcyV0W+2QKu9me8DJdD0KCyAqYc85EZ5CpzhU+EtS3A5H1MMyfVa+ne3SpDB8YSCcUCqGsgfhEyZVmS5Bn+2zXEEqjITWxajLdnCv4f6aCJ7GMvLJJN8AyogQsRZQnZZolG9g9MmELjx8c+T99JKu1IL2Imo8s/eA0IXGELeOXWdp6GCzDhidanBzOSL2Ys4u62fHUBgdfbTT+G3e1oDNR0aE5siJjwcfcZ7VEShhCMU/jkggW3t8Wc8C3RmdR5htBPAlGock8Mf4u2VpyPbrIh6EVXLCSix+7xxArVo9/gAq7qnlXc/c2VsNJSxpn8slreHRrVUErafbrC7E0Pf5Bnd6oKFm/xCmSD6SWvms7VUduz/aRhmPl/Cgv58zE8bQnYBdQGwj1CHPBlAd+R8QfX10q0oAdYHxTl2TWDOhPtKeFNREug2QB4Gt5ZKXdkHylDfd1LIZBc1w8Wx+dSalV5Bh6g/ixskxK2V7+qnx5MSPsgzdrNLF9x47OXv5OTO6TS/R4OHPognBECcribm+qYDRwxYb1FqJcA9rED5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S00zZnlFY2hsTXplRWlvZ1V3UGRQZTRaRkNVTzd4QVprVHcvUmVGYjhaaHBi?=
 =?utf-8?B?Wm92WnBrTis4SlJ0TlVpaWpIb1dwczI3dWlyNVFnWEF6TXFuZ0hnNW1KTG9s?=
 =?utf-8?B?Z2ErZmZuOUJ1eUVjK0x2QStCZDlFZCtTSTZBQnQ4U3lMMHV1Z1NDSkJrek5o?=
 =?utf-8?B?eGw5ZEh5ODVUS0tJSFhXM0NjaUNNcGUrbEdqT295T1VWRnd1V3JzQ1BWaDhJ?=
 =?utf-8?B?Szc5Rk51dTZ0a3VzVkVSRVBPUDlRV1hrUk81UUVYY1JaYlVPM2lYR1NjTkxN?=
 =?utf-8?B?UlpSdFFtYjMrYUFESmNyOFd4eHV1YXM2SGIxUm92QVIyQWRoRjVuUm5pRWF6?=
 =?utf-8?B?VzRjMGRnVU1tSGIrbzhIT3ZucGxnUHkreDU1WDYzU0lBVXdyR054U2s5bm4y?=
 =?utf-8?B?TVZhVDRsWmxSTmFRQ2VDeW9rckNDM2VCa1ZkbFA0Wjl4VURIVzZqWnNhcFYw?=
 =?utf-8?B?SlR4UzVHQXorbDdzQ0FabHBTc0kvRWI2d0k3TXhWMG52N29SNEJDbjFTYTUv?=
 =?utf-8?B?M3huR0dlSDZjMS9yZHpEcmRQU2lDNE51TmZOb3pnOVlYYTliazVyMncvMVdQ?=
 =?utf-8?B?Q3FhVTNuRE9lMmNSUEJrSHpJWlJaSUhwY2IxQVV0bStVRDEzc0hUUFBYaTNo?=
 =?utf-8?B?S0hic2ZzS1Fuc1AwNjVoMy9hSzVoSXFSRHhwWi93UU16RTFOSHFyaWNLUFFQ?=
 =?utf-8?B?d2hvZ21DMDk0THczcHNWR20zcEFLNnNQTGdNNzluWmtMakpxU3huVUFneVNj?=
 =?utf-8?B?MzhzaTRERDg5UVR3MXpJUEI4Qmh1czd3clg4QW5ZUFZsZ1g1N1NhUHQ2c3Rn?=
 =?utf-8?B?VGswQzR5OWs1MkJ6dWV6bDh5Rzc4b3UrbUkvQVRLMDhUbzF1eFMwVGt6THAx?=
 =?utf-8?B?Smdyb1BoVkFuc3owR3lXRWRwVDFGeEhUVFZvRGp2QzAwR2tTOTZNaStJMWRG?=
 =?utf-8?B?a0ZOcXA3STFsbm9QUkprd0FDbmFrcTN2Y3U4Nmt3RXl3QnJrL09TN1lxM0tm?=
 =?utf-8?B?NVhHb3hwK3FpM1o2RG9jRjZHY0RCSm9MenpEVFFnc3hWdlpJVERYWE8xd2dw?=
 =?utf-8?B?OHVKRXN5LzhWaVdUZU5mUXZmbWM3djA0U0NtNnFDdml5VEdEYmlQREdkM25Q?=
 =?utf-8?B?WUN3eDJsbk1Cb0dkQXlWSVE5bk95c1RLMmJ4RHBUMEUwRVUwK0ZLbUQ4eFM2?=
 =?utf-8?B?cjZ2T1Q1M3llcG5CSHlqMU5NUHhYT1RwZkRqLy9mU2xpNzloRVlEbW1pQkJz?=
 =?utf-8?B?VFBodGhKdUw4ZG1uNnRkQzlhejNwSGNMZFl5TnErcDZKam4yeWszclVFdWFP?=
 =?utf-8?B?V2p6Ti8vYzltWEZHUW4zTnh3dldXcHBMS3pPendlSW1DdWpCY3RLU1N0Qkxy?=
 =?utf-8?B?dURLZ1U2aGtIOG51RnFXczZGT1NlaHhFV013cjZVR1A0ZklKSWRJWnpRVjZn?=
 =?utf-8?B?MnMzNjdhZmNsa1RHbDdUV0JodEoraTJxNVZXTHdLYURXZnNIVTlhOUNiVGU3?=
 =?utf-8?B?S1U0MVZSenQ0N0VzVnYzUzdGL0ZiYVZwVzZQOUU3c2FEUWZmUXNHS3RqWlN4?=
 =?utf-8?B?QWorVDY4Rm1NemFYMmNSSnR2YkoyU2Nhb0N5QnhuQVViVkpwcUJMWmFsdjJD?=
 =?utf-8?B?UTZ6ekpVSitoTTdPRFNyWkRXL1hPZlBwODYzRGFoeC9MWlQ4MjAzVXkzbWNV?=
 =?utf-8?B?UU1lSGsrTGxHNzFzbVJ4dXA0RENQK05YYUdYT1p1R2hYNG40UlRRK291d2U3?=
 =?utf-8?B?VjN3Wm1QNFJ0M3hGY1E1S0k2RGxURWVpOHNUN1ZaMmNhRWt1SE1OUEwwZmt4?=
 =?utf-8?B?eXJMMnN6U2E5Q2JqTXAzcy90cDI3d3JURGNLeGtPZW8vWDJlMGpvSFJQRC9F?=
 =?utf-8?B?SlpmRDMrRjdnSGYrcVkvSGliNDh0bHdCcGszNXpLVjMyOW9aazVrbDlpN3VG?=
 =?utf-8?B?K2VuMi96NnRqN0Z5WDNMS1BSb25pR3paWVZnZCs0RUluSFp4ak45Rkl4UXZj?=
 =?utf-8?B?QTR6Tm41YXBvSnhWYTREbkNLcDdGZGdNalp0dUU2cDI4MXZEblpuZW1CY0dB?=
 =?utf-8?B?Q3lDU2VWV0hvekhaMDRhSUxPblh1Y3BTcllsSk91aEd2TklIeUluWEhLeEhO?=
 =?utf-8?B?elVObGJlL3Z2amVlYXZzWWRySktRSGtrbXV1bW1sd1YraXBOUjhzUlBHbFNR?=
 =?utf-8?B?Nkh4ZnFXYVhZNGl5S3YvZDMrand6TG93V3l3REZzZHBVcjRpUWMrYWdvR09l?=
 =?utf-8?B?Nm5KNTRoeS85ZUwvUCt0ZDRqb29LRGlOajdhV0xFK3JRalB4cjVocGxRRCtU?=
 =?utf-8?B?QjRUMWpDNzRRSDNGQTZXSVI4M0VLaDlMakcxTWxyVjM0emZmVTQrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eac8bcd-2ec3-4c4f-cf0d-08de792f0d9c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:13:33.6890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+G5/XPnwhC/2mo+CmNhak1Ul79HbvvDbYQLDGsWUyBfh4atYWlHyWrq4vySnUeBz2By8v7TWVmyp0G7IQfDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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


On 03-03-2026 07:36 pm, Christian König wrote:
> On 3/3/26 14:49, Khatri, Sunil wrote:
>>>> @@ -1000,11 +1018,14 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>>>                drm_file_err(filp, "Failed to create usermode queue\n");
>>>>            break;
>>>>    -    case AMDGPU_USERQ_OP_FREE:
>>>> -        r = amdgpu_userq_destroy(filp, args->in.queue_id);
>>>> -        if (r)
>>>> -            drm_file_err(filp, "Failed to destroy usermode queue\n");
>>>> +    case AMDGPU_USERQ_OP_FREE: {
>>>> +        queue = xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>>> You need to have xa_lock around that or otherwise xa_load/kref_get can race.
>> __xa_erase is unlocked version, but xa_erase internally does have xa_lock, since there is nothing else but just erase here to it made more sense to have clear xa_erase.
> No, that doesn't work like that.
>
> The problem is that xa_erase() takes the lock only optionally when it can't exchange the entry with NULL atomically (e.g. because a full page needs to be freed up or similar).
>
> But in our use case taking the lock is mandatory because kref_get otherwise doesn't work.
Ok sure i would add explicit locks in that case. Thanks for that 
information.

Regards
Sunil Khatri
>
> Regards,
> Christian.
>
