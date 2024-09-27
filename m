Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A499CEBF7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 07:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA8910EC31;
	Fri, 27 Sep 2024 07:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4vIHcOpV";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4BB10EC31
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 07:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVUuVrZeS1Q3q4AczC0OpBLlidwcrj3nihMdp3gRGHrUHAhgNDfuBW22n3IjkeAlvm2oQtMeiTSR4DVbH/KyW/g5s8CvlsluW3QKRAdf7jGHQSCxUJvR1LvH/ySyY1faNKQeHbTMJ/+IJtGXfHszn01D59w0TOzubFin9qva4OMAo6MUkcs9Eeq8uh2msL3vnuP1KCkMtQDtp3yPyTArUuQq04laWH5odGys0koelUFlQP6uIrfogPpn0R5Cty5RFlYHPkK6yBFTzsQgbDTc3f4NslXt18BKMSDWWuvj7oOhTosisnz2hhBjB6yFR4JinsoQ/tHJzEQrGwXwUKBtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWn54pqH/+CzNRWClUaHa0AA79ggEli/lXwOThHCF9I=;
 b=tUwdx852Rhuej6KD69A/YresO14oL3yeFj7jSvWbloGmvkBInBGy8hBBgaVf7asjkH9i+E+0IuXoau2WOb4qLj+07vC2KUX14IQPM54UnszAN9DZynqiyU/Nr9diyBfgl4pgJ9vWq6RQK/drLtl2GqbnhyKoO7kfLEpKpDPybY9zB8o4CREAov2EsKW7MZbKR1ObrUhO0Dg/DBDx195epGX2wwp/aQhKz3rchSVKzf4G1dp12LCPgV5ejEatVtC+6QIME4d5JZE0q8CUv3zc+LMIh5/a44cawvQKJDcfI/qxTBsq7NV+0qAtIHkIjt3/J/II6wqqmTyS67z/cRlJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWn54pqH/+CzNRWClUaHa0AA79ggEli/lXwOThHCF9I=;
 b=4vIHcOpVlRQVCZ5+OfFlgqB5/rltmIu55wKc7Y9CXaADgbWurdQS1HJLP8ixMmKi6q6O/jzH2uHFSGrDBBtmgyPs1s+s053pa+PvhAyd3WWcincexFM+Gjg981806ytjieo3UTLx9JzPdBn6eJSQM5Vb0CB/fRqbd0+krn3JS4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 07:38:04 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Fri, 27 Sep 2024
 07:38:04 +0000
Subject: Re: [PATCH v2 0/7] Add support for dynamic NPS switch
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Vignesh.Chander@amd.com
References: <20240927045305.2718867-1-lijo.lazar@amd.com>
From: "Xu, Feifei" <feifxu@amd.com>
Message-ID: <57ccbda8-8182-7ead-b1c8-186a65e3627b@amd.com>
Date: Fri, 27 Sep 2024 15:37:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240927045305.2718867-1-lijo.lazar@amd.com>
Content-Type: multipart/alternative;
 boundary="------------FD1F34CAA94D763771F837F2"
Content-Language: en-US
X-ClientProxiedBy: TY2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:404:42::27) To CH2PR12MB4152.namprd12.prod.outlook.com
 (2603:10b6:610:a7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4152:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: cd241beb-9b77-4f71-f379-08dcdec7523d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk5yd2ttOUV6MVBSSlJxZ211VHhLRThxSml1NlNOTGNMajFyVkNaQTNyUkFs?=
 =?utf-8?B?SHJLT3lKRkg5N1ZFQTBCUUpEbGx3NnlVejlLWDFiZXRNVVhRTUJHWVNrdHEv?=
 =?utf-8?B?bkVCUXRRL00waDJUUk8reUQzZXRUbHUrUWVEeWNVQkVCWnBFd015L0VnL1ZO?=
 =?utf-8?B?VEl1R0RtY1lqRVhFK2xCclRaeEN0WUE3R1c3cDQyLy9MMjRDejVmeVVVVmJi?=
 =?utf-8?B?WjV2ZHJjK0txRFo3ajhYa0x3U1BqTEo4dEsrV0djc2NRN0VMT01VWngwOGhn?=
 =?utf-8?B?UThkN2xlZllKMTlObFBad0VzYTh6d1BWSTkwajE5RGlzVHVpczdwZVdmVnQy?=
 =?utf-8?B?aURFQTRpS0ZIdU8rYXBrV3dRRXBZVDNqeTRYSHg1bW1sRTFZdXFFQTFSUzNM?=
 =?utf-8?B?Smk4RHNYSnNwZmFNUi9MT0ZzTVpnUStDOWRGYlZUSXdzdkFLZGk0MnZvQ2Jy?=
 =?utf-8?B?bFcyVlRjWGkreGFON0VNMGR0N1JuMlBZNG9KNWdDdC92OG55K0IwRHJYa1dX?=
 =?utf-8?B?OEx1TG90b2ZxREtNZmVLdXR6R0FJUHhzYWlWZHdtRU5Jd2RGR3FCdHdydm8z?=
 =?utf-8?B?Y2JrWHVFM3lSOWlhcmZrSzN2N0RPdzkwamo4bnJSM1c2eCtOajJ1TmlkY1pO?=
 =?utf-8?B?akZhbzdlK2lPTzJ3TXlzNUxJOFA1MFJwWlMxeSs2eHM3SDlGblZNYjBTYWNu?=
 =?utf-8?B?WGkzVG1jNjBSL1EwUlordGc4WVF4cFVNSTE3c1Y5Mm8xSlczeUFpNnBqNzdo?=
 =?utf-8?B?ZlFIQkhQM0pwUGduV3RWSWNzeE9IMjZkdVBMZFgwQm9wQSt3YURQZ1M2bjRh?=
 =?utf-8?B?ZDRyeDN3bXU4UnNzcitCblBBaWpjRVkvN2hSbzAweHBVK1NmS1hXeEhZNlUr?=
 =?utf-8?B?YXNSVDZJK3U1WXMrVE4wemNFRFI5Si8zUGlPem1zdklnNXFwYnB3UzU2aXdt?=
 =?utf-8?B?c2RoU244R0Y3Nnc3Mk5uck15dUtXR3FrWm9XaUkxNmIxVWR6QjNKa1dHOFVw?=
 =?utf-8?B?S01veDkvVjBOSUNOVDl3N2ZJTnVwYVdteXZqTmt4NSt5OXBPTDd6S0hjVm5W?=
 =?utf-8?B?Wk9rTDY2SkZvTmd3OTdSSXdqZUNqaDBxNUUvZitMU0NZTHBwYkw5QU4wRDNi?=
 =?utf-8?B?eDRmV0I5ZGl6L3N4bDVGQ1NuVG00RXNtMGpsM1VOVzIvajF6NUt2OEJDUkRN?=
 =?utf-8?B?RExXT29pK2xmSVNKbVFVK3VBTWI1R3NPc1FteDVqYk5WaVdWdE1EZ1IvVVd3?=
 =?utf-8?B?WXRDSVNwWXJuZ2k5MFdRdWZMZEdtZHFpdHRhMDVFYUJBZG1FcnF3R1FtSVla?=
 =?utf-8?B?VEpqM2ttTjJNY3VxSnJFVStlYTlMaitJamVQc0tmS0ZOZkkvbUdiNVFBVW9q?=
 =?utf-8?B?YWlQMHczQ2VEbWEvNUIzT09FdXdRdU5zU3JhcFlqN2dOUlVpMWliR0JVVW10?=
 =?utf-8?B?ZVM4eC9WcUdtRnVkQkNTYTMyTGNMZXlDZmlLYWZ5OC9mZWNUbHV2UVIrSnE3?=
 =?utf-8?B?bEd6cENtTFdFeWgzRlJPZS95NytJVEhoY25wYjFjVi9vUE9ESmRnWUxPVGx1?=
 =?utf-8?B?ZG1ac01PL0hpMWlUaTJab00rZThvL0tEN3dTY1BFOG94cWlSRmdwR3NEVkMy?=
 =?utf-8?B?a3ZjV2p3SGdENENLMHVzanVEaVZTNXdEdFhTRW5CdUUxNCtmZkRzcW1oOEFX?=
 =?utf-8?B?Y3pReko3bW8xTzVrZE0rWWFLUjR5YUhFMjk3bHhJY3BFQW45a2g1aDdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExvNE14SHRuVDBBTEJFWkZ6Um1VRWRWTDlDWi9Qc0JCTjhvTEhEVnJWTGtG?=
 =?utf-8?B?MjdIbVVwNGN4S2VGNkpaTjUrWWpKWTJvN3VrTFowb3NTaHpwVWR5UlR2aTU2?=
 =?utf-8?B?dnEyRjJlamJXMDBJQ1lCQ29uNy9oUjgrcElQb1ViK1Y2YU9ZL2cxNVRvb0dj?=
 =?utf-8?B?bVRpVXF6K1BTMEdWb3g2NzFFL2FMNjh6MTlZYzlQcUpSQkx5ZW0yT2VzdE13?=
 =?utf-8?B?V1dPZm5yR21XTkRmU3FsU2J2KzEzcGRYNjVlbHdacjlVT3ZpdUxhdFBJeW5B?=
 =?utf-8?B?bk1qckFGM0Z6N2IxcGQwWnZHVDhLaksxNmQvemJPNm9JUzlieUR5OW0yb1Zv?=
 =?utf-8?B?ZWZIL0xVYU10bllOaC8vaC9FdFNGS0d4K2FWZk9nWGpVL1dFdkdkOEExc1hG?=
 =?utf-8?B?cksvMGNBeTFUeHVBcU1OZmQ0Y3hucE0yOTVPOEt0QUpRQzdHREsrZHhqdE1U?=
 =?utf-8?B?K3IyZXFTeDFocDRxTCtrNlAzTkh1RG1TT0JGc29CK1l2SEVvSjdPNmlyd0ZP?=
 =?utf-8?B?TldYeEw0L1pwazNIdTRhYklMSjRYMXhGMGt1aWloWlhJeVhJVkY5UkkxdDNL?=
 =?utf-8?B?VS9CUFRYcEFyam5Qb3YwUEwyMGhGdEFuME9zc1R4YU85bFhXalEzajBDYXZ5?=
 =?utf-8?B?N2EyQU4yMk5tM1hJTExrcjE1cCsxN0hudTlwanFTZUdmNFN1aU5iZGV4dkE4?=
 =?utf-8?B?bjFmVU9QT1QzOUltVGxLRUdnK1E4TkFvb0Nwb0tKVndRb3o2aHpOOHFkMFM4?=
 =?utf-8?B?cWFITUJWOUlQYWZqUG1ncjlVcmRZaERBMFFPd2J1YTIxSWZMM3kyM0UzZVFj?=
 =?utf-8?B?YzdDR2lIVjNmUk5xc3ducXRSYis4TXdSS1l5UnpOZ3dpbnNFaHE1L1BjLzNa?=
 =?utf-8?B?UzlVZnlLSGVRM1lMR2MzTXIyZi9XMFN3akY1REtPeEpYRzJSd3dMRXk5OC9D?=
 =?utf-8?B?UUo4VTh2SVAxb1MwU2o1UkQ2bk81aldqV3lzU0hJVHFOcWxZUS8vR3kxSVFL?=
 =?utf-8?B?Znl3WERoZ0tuMjFzOXhEMVR2VjAvMCswOUNnUlBFai9TNC9EVmJZVk9ldzlw?=
 =?utf-8?B?VGtHbDhqWU80TXlaTEl1ajdVMnpkbDJJL005dStVdlVXcmdkaVVZek1Db0k5?=
 =?utf-8?B?MytlTEtsZ3hKY0JOVVlJYUFuNXgzSlI5QllicEJaNTNydFZwTjVCcmlLVjVh?=
 =?utf-8?B?QXpJN1VrMUJMVTV5YW44ZDNUNXUvRWpmb2NoNVozR0Vpa0hMMURrSUVlVU5r?=
 =?utf-8?B?MUVsb1prZGVjeUdsZkJjYnBBR2U4dC9iT2MzNmpJYlYzWHExQ3F5OERROEFG?=
 =?utf-8?B?UlhGckR4aHRHRi9MTGc2YWZtNHRIaW12cEtZdzBmVjNaTElpN2ZGVUI1d0w0?=
 =?utf-8?B?N0ZCTnJ2TDlMek9Kdmp5U28rNVFhRTN6dFZJcFhSaTl3c0VBVVFMM1JYYlV2?=
 =?utf-8?B?bklBN1gvSUo2cEpMUmd2VjFBTnE2Z2wydUM2VGtVLzBVOFhNdmk3ZGJoUXdT?=
 =?utf-8?B?Z1JPYTdBZHlKV2hNOElaK3ZvS0lDek5lTlBwRXdzUDQyNFlINk5oYU85cTlH?=
 =?utf-8?B?NnRvVjJKaHhnMFFQTWFOSE55RkpXbGtZWWtZcmlTUW1GclhsOWdOZVhka2xW?=
 =?utf-8?B?VVZmZEszV3JaWUF4SVJzMWx5MXdvYTBEYjh6eit0MUNtb2VHbDFnR1VjQVpo?=
 =?utf-8?B?T0pLUC95Q1lqZUxQUUFpZjFveWx0ejFvaFg5Tkp2TkFNM0s1WDI2R01Kb1E2?=
 =?utf-8?B?TUtlc2s4OTArNkI0WjhYVWpyYlVlcFdyWnlSbWNNNFQyRG1mbHZYUDY4QVAv?=
 =?utf-8?B?bTZ1WnkzRDJNMW5oTzI0dTBaKzZqb2FCNGxNQjVHQWhmd1g5RXQ1aFZwMk95?=
 =?utf-8?B?bi91djBwY21EL3VlazZiWFE1N21obEV2dW0rLzhQay82b1lBeDdzN0ZFdDd3?=
 =?utf-8?B?SHcycHFVeS9Ta0Q1UlJMcE1janpqUE9vRWJ0VkZ2dGNIaTY5MkwvZ0t6NDN2?=
 =?utf-8?B?WDhVSG12WVdvdGZKZlAxYS9oZ3FBaXdkMWVWdmdPTnY0VUU1SWU1YzVNTk9i?=
 =?utf-8?B?ekdOQjFvdnZMRG5UcEFKZFRsSmhGWVRJZGNZS25SdHd3QnBEa0wxZ0ZUTjJU?=
 =?utf-8?Q?XqEmKT9jLzxy/S74ZaqCnK6eY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd241beb-9b77-4f71-f379-08dcdec7523d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:38:04.3133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fum76YfoPmLydWMaeI95gqlnfWnR/2sJkoR739zVjPaBbiCFuPdrQIvBP3MDSneQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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

--------------FD1F34CAA94D763771F837F2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Series is Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

On 9/27/2024 12:52 PM, Lijo Lazar wrote:
> This series adds supports for dynamic NPS switch on GC v9.4.3/9.4.4 SOC
> variants.
>
> In order to do dynamic NPS switch a sysfs interface is provided to request a new
> NPS mode. If the device is part of a hive, all hive devices are required to be
> in the same NPS mode. Hence a hive device request is saved in a hive variable.
> For individual device, it's saved in a gmc block variable.
>
> In order to do a NPS mode switch, the workflow is -
>
> 1) User places a requests through sysfs node.
> 2) User unloads the driver
> 3) During unload, driver checks for any pending NPS switch request. If any
> request is pending, it places the request to PSP FW.
> 4) For a hive, request is placed in one-go for all devices in the hive. If
> one of the requests fails, a request is placed again to revert to current NPS
> mode on the successful devices.
> 5) User reloads the driver.
> 6) On reload, driver checks if NPS switch is pending and initiates a mode-1
> reset.
> 7) During resume after a reset, NPS ranges are read again from discovery table.
> 8) Driver detects the new NPS mode and makes a compatible compute partition mode
> switch if required.
>
> v2:
> 	Move NPS request check ahead of TOS reload requirement check (Feifei)
>
> Lijo Lazar (7):
>    drm/amdgpu: Add option to refresh NPS data
>    drm/amdgpu: Add PSP interface for NPS switch
>    drm/amdgpu: Add gmc interface to request NPS mode
>    drm/amdgpu: Add sysfs interfaces for NPS mode
>    drm/amdgpu: Place NPS mode request on unload
>    drm/amdgpu: Check gmc requirement for reset on init
>    drm/amdgpu: Add NPS switch support for GC 9.4.3
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  68 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 190 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  19 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  25 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  39 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   5 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  44 ++++
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  12 ++
>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  14 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
>   14 files changed, 387 insertions(+), 36 deletions(-)
>

--------------FD1F34CAA94D763771F837F2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html data-lt-installed="true"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Series is Reviewed-by: Feifei Xu <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 9/27/2024 12:52 PM, Lijo Lazar
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240927045305.2718867-1-lijo.lazar@amd.com">
      <pre class="moz-quote-pre" wrap="">This series adds supports for dynamic NPS switch on GC v9.4.3/9.4.4 SOC
variants. 

In order to do dynamic NPS switch a sysfs interface is provided to request a new
NPS mode. If the device is part of a hive, all hive devices are required to be
in the same NPS mode. Hence a hive device request is saved in a hive variable.
For individual device, it's saved in a gmc block variable.

In order to do a NPS mode switch, the workflow is -

1) User places a requests through sysfs node.
2) User unloads the driver
3) During unload, driver checks for any pending NPS switch request. If any
request is pending, it places the request to PSP FW. 
4) For a hive, request is placed in one-go for all devices in the hive. If
one of the requests fails, a request is placed again to revert to current NPS
mode on the successful devices.
5) User reloads the driver.
6) On reload, driver checks if NPS switch is pending and initiates a mode-1
reset.
7) During resume after a reset, NPS ranges are read again from discovery table.
8) Driver detects the new NPS mode and makes a compatible compute partition mode
switch if required.

v2:
	Move NPS request check ahead of TOS reload requirement check (Feifei)

Lijo Lazar (7):
  drm/amdgpu: Add option to refresh NPS data
  drm/amdgpu: Add PSP interface for NPS switch
  drm/amdgpu: Add gmc interface to request NPS mode
  drm/amdgpu: Add sysfs interfaces for NPS mode
  drm/amdgpu: Place NPS mode request on unload
  drm/amdgpu: Check gmc requirement for reset on init
  drm/amdgpu: Add NPS switch support for GC 9.4.3

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  68 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 190 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  19 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  25 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  39 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  44 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  12 ++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  14 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
 14 files changed, 387 insertions(+), 36 deletions(-)

</pre>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------FD1F34CAA94D763771F837F2--
