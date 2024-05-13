Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3529C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 15:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3864510E802;
	Mon, 13 May 2024 15:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aor1JyII";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9723210E802
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 15:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPRhsxn3oRDnTampg69AGU/dTOjgipYV2C5Q3LzAP6B1fNfTumK9hP8aPr2wZn6J/z7XHZj5uzznAJLJKXzGjgOWA3jLgWE1MbpenkOwn9xzVm25oYfSx3GvhcO5/UwDhV3a6KiRqf4kwNclP6eyHP0kBaKljk3adZkDISPPLASEkZICl8VNm+YOV10g/AGiRrvRefYtIR8pP5kSJtg1CLnrIWjv0RnYinFjCFgj+wlB4nZXyUyQa9HdRdIwQjXyrmRXsBAEYoiGtBhhj8jGkBC6+rFDvp5D+xHaVjRcSSRp4CecJEnH0lxqbshU92S+mHNdmJEkEJEZBRzUNT7bGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkKzK6lPZHPwKdJ6oqUF+ppAn3jXJ3UCEJUYIg9lZNU=;
 b=HxERkCcJjzcmJazuD40wqfH1FqS9Na9813p3iazqD/PalOOCZzSfvZTwgT6CAO3ts1Z5HBTTo9Roko1VuvPu6WbbNsmHqe2eoBRoMtFRWkg4P/8eGus1fxzklneuhlaySSRyS0x5JyIGsbuIxszmvCsxeUAy1iE6I0vCI+i0xHx2UaJOJLXSviQiD21FYuK+AsGhCez64g8wYPE6zKn5b3qW/ZoRMsK3+FuLBND9iQ0xbo8Ga74w67EMdMGZhp0EeXWxRyXZJSfhT9cyFi1moqz0SIqXDS0fcxBxwm58rseD/RRP/5nW9pZfgR6eCF2bqrlICe80OR4xZCLRCnaFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkKzK6lPZHPwKdJ6oqUF+ppAn3jXJ3UCEJUYIg9lZNU=;
 b=aor1JyIImP9mDwOcE/rOdxBQup/lLH7gLhyIHIf3mu2ZjulKsk4gt2f1f+NV91tMOmYpOK9CHWx3/NmnQoHiFY1D/icxT3FpVpRc1yfCLGyFGfmvX2Y3SkInUUpWnY0KiM7P925pQDPUoWRi/XsSTG5mNcsxI3DyAH3MTkn7gZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 15:23:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 15:23:04 +0000
Message-ID: <7c85794f-2d6d-4bb3-b320-99fc197d2301@amd.com>
Date: Mon, 13 May 2024 17:22:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
 <20240510085046.2718-4-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240510085046.2718-4-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0026.eurprd08.prod.outlook.com
 (2603:10a6:803:104::39) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dfacc1-8ca4-4c00-8d05-08dc7360956d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXY3RWQyZCtFUnJuaXBGcGVwdEloQ0ZOZGVqT21jRHptNTdFL1BKUTcrVElQ?=
 =?utf-8?B?alhPVHMzRVNQanZIWVo4V3BDdzREOGMvelBISUQyL2JUaFVKU3BJblFxL21h?=
 =?utf-8?B?QWpSNnlWK3ExdksxcjI3dFVzN0xOZU9TQXFadmVIeWNFeXpjajVodWdtdURN?=
 =?utf-8?B?KzFlQytwKzlWamgvQ0ljRy9sT25QUnpHUldsRnRQUC9rdCthYjB5a0VmZXZl?=
 =?utf-8?B?ZThIam1ldWs2L1ViTEpJdHk0dVhuN3Azb0xhSlNScGpQeGtPU3JXZkx3MDFX?=
 =?utf-8?B?WWQyd0YzejRhWkkxN2NSYmlMb245YlQwMHlicHU0cisvZWhmVEx3RHNqRG4x?=
 =?utf-8?B?L3NPZW4wVktMWFBBUWVkaG9GWHlDM0t3UHdSdkQ1WmMrbWlJOGhkSFdhRVo4?=
 =?utf-8?B?TFhrTHZINWx5ajRoejQxSWlCeGdMbGpSU2dxK0p2MUVrZlpiUmQ2aTdlSXFu?=
 =?utf-8?B?UVlrZ0U2aExzVEtNcVRDY2k4eGdEbms2N2hQRmJYcllwODJEcmp2UDd3Rit6?=
 =?utf-8?B?bCtEeGtBTk1CQXFsbVhKcGFLVWJSS3lwaGFTTjJ6WlVQYnYzNmlWU3Q3WmZo?=
 =?utf-8?B?YUxuQlRYdGNVQ3pQNXJFd1JIMHpteDVkTzFjSXh0OHU4bzlkNmMyNktQWUQ3?=
 =?utf-8?B?WDB4WHkwcU9mbjRjNUd6NGNzMWt1ZFJBN0FrU2tyemNHNFltQVQxcVpmbmpx?=
 =?utf-8?B?VjhoTHJNY3RxY0ZVbHdPbnZTcVF2WGdqVXE1LzNaTkhhV1Z3QlQxSy9scUZY?=
 =?utf-8?B?cnQvaG9hblBTWnBSbmlMdEZsRGZkR1hORFJwelRUMmZ1cUlXRmtTWEdhZ0tz?=
 =?utf-8?B?d3RtR1d5b25QUnNSOEFPc3IwQ1dHdmpzOHgxUnpZdWlTcHNQdEJBcGFRV2U0?=
 =?utf-8?B?TnhxNkp6RVRjanNoOGN4c2RtWm1uYi9aT0xNVktac2pHbDZJRFVOTGhqVDl2?=
 =?utf-8?B?RGUwVHdrT29mcjE4V3ArbzRqQVhzck9IbWxqR1JVbVY5dVZqRS95TzJFQkk1?=
 =?utf-8?B?K3o4VS9KcVFyR2dUMWtJTy8xZER6dkdVYTRjWGpodTB1azhmSVROdnRka2Jy?=
 =?utf-8?B?QWplNTlid0RXSDJyVFRZNDVRdVNjTjh4b3hlQkI2ZTM2UEhmamxoRFpib0Nt?=
 =?utf-8?B?aVJXelVCby9Eek5CanQxNU9NeU1taGNTM0xIeWlnRlM3UTRCWTNJcDArVEtM?=
 =?utf-8?B?cFVPRWs3T2Nad1BRRGc4QndOV2ZDdXVOc0ppZFhuTkdPVXRZMll0bGl1ejNE?=
 =?utf-8?B?OXNleGZVZFM4bENkQXZsRHFnY2hvYkZ2WkFvTUZBQU8yZm5nQnltbnNUN2pY?=
 =?utf-8?B?NjFSTGNxRVhUVFNRVFY4cWhKKzhsalI2eFQwMklIREVZVmF4bUNpQTRYMFZu?=
 =?utf-8?B?OTg5aDJPUlV4RmpTbFJpaDMxS0N5Z3lMQ25CdEt0TDU1bVNSQnR6c1Q4L2hQ?=
 =?utf-8?B?SWw0QXdPMlhuckVWcUF6ZHRkOHVNeXAxTU5mZDBWdWlnTjR5aHc2MFliWGcz?=
 =?utf-8?B?akkraE1wM3NUZGl5NVVtMk1mVktLd3dpcUh6WXhBK1U1YzdSYnBWRHRpTUZn?=
 =?utf-8?B?T0hiUHlraDQyclZKQzM2TEJ6OVRvVXJ5ejRSbEd0YUNrWUN4UnNtdjFYMEY5?=
 =?utf-8?B?U254S1BBQTAxeDlSVnQ5enZrckFCQTR6bk9KT2N2bCsrc1h0RlVMaE9XV29W?=
 =?utf-8?B?eXRMNVFETmxYNHFmWTZKN01yZE8yT2hBbWNMTG96SEM4dUQ0alNPZGJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhDTnZkc2pZNTRidjFtY0dtaUdlbTF5SStFRkFjZzZtWW5QaUorY2MydGhS?=
 =?utf-8?B?L3BsNEUrK1VkNFliRklyNzlab2tvdXRCQmFpTmpOVERXSUl6eWNYM0l2dEg4?=
 =?utf-8?B?a3FiYjVlaWh0c3AreDhVYlZGUWdRbjFtcVpOUitabEZCTS9lMWlwQlpsa1Ri?=
 =?utf-8?B?aWxHdEhBSjdtRTBRWG93QWpzZ0hPMkhmMTl1bUdielJUcTAyRlQrTGRwaGk2?=
 =?utf-8?B?eERscFhZNWdtOGc5TWt4NGVaeFl1eTBRV1hpY2lVaktNcEFSUlZMRnROMkVG?=
 =?utf-8?B?bkNiNkZEcjlGUGN3MjdSTmYyeG9OTVZab05XNk0rOEp0eUJrcG5JRDAzMjFx?=
 =?utf-8?B?MFNUV25iUUtkWjhUbTQ4T2cyT2xoVGZ5UnY5RWFpdnV6VDJ0Z3A5aDhjZDRK?=
 =?utf-8?B?RGltVWRSRmR1MFVXOCtVenV0Z05zeGtxTW9leGRnaDJvVkcvRVdPWVQyZWM1?=
 =?utf-8?B?U1YvTTltVThWb1FQV1RvSnU3c3lhSy9LREdiTmpEL0ViQWxuNWR5cjArVWFK?=
 =?utf-8?B?ZUJoU2RQNXM4eHU5RlRJVy9rcHBQRGFxZExUbkQvM3dFak82MmxuZUR4ZVh2?=
 =?utf-8?B?bkpNNE40ZEFqZ1AyN3lDRmlvUkNEejRZSWVCNEdLakhOZVRmOGl4WHRrMjRy?=
 =?utf-8?B?YUprL2RvK2RiTDNpcXpnemExeXltd3ZISTh1bzVNUHQ5Y2pMQm9ndXdldm9Z?=
 =?utf-8?B?WFFTV0M0UEI3a1FhMkFqa3ZkN3NaTE9rdnBVMXVJcWROZGE2WTMvWCtkbjVP?=
 =?utf-8?B?dUY3amhZaFJKMEdoU1ZZbFY2MHY0TSsyNVR0MHpqY2xqUmlhUW5HajVvQjFy?=
 =?utf-8?B?aW1mRWFyRGJkUjRCNXdoVkZHMHNaT2xKWlZwZ3hGUXYwQThJN09KZ01XcFA2?=
 =?utf-8?B?Y3JqR0JpdUw1aDVnenM1YTFnVFo1RVB1NkROVWdybGFwbTd0NFlNUmdxNDl1?=
 =?utf-8?B?eHV6aUEwRHI1WTRKeUJvQWtWUFFBYUM1YzQ1ckl2OWpzeWdlSEpRa0p3dGhu?=
 =?utf-8?B?VmFEL2cxSkk3Mys5MUlaU3VpbWIyS2RzTEhNcFhTTWpQbThRU1h6K0M4T3hJ?=
 =?utf-8?B?bVBTbnlqRm1ock5qNjFDNW9RVWNNTXdKMEpmWVhndGJXVEw0dzhuWGRhYVVE?=
 =?utf-8?B?L3VjMEY2OVZqM1pOcC9lT3ZhbVlRN2JkemZPSFI5ZEhtQzUwR0lBOGxWc01I?=
 =?utf-8?B?c054Yk1nWFRlVmZTb0haYWFrUjVHWE9vbk8xbTlwMU9mNFdLS3pKdlRVYmZS?=
 =?utf-8?B?QWo3RVd3dnRBbzQrVmZUcFpLWmxoQitXT0tNYnlsRzh4NVo4NzhtVVFCYmVw?=
 =?utf-8?B?ZDgyYlRRalpQTEZjWFlScUc0Z1UxMlRvNy8zVnd4bFh0QVJtcXB2dEpJOTRa?=
 =?utf-8?B?SXptS1U4aFgzZzdHRU1lRnJac29meTdFczhpV3o5NWZxaDBVelZUSk9ocEVY?=
 =?utf-8?B?NThOa2J0M3BkS0I3NFJXYnl4azd1YThWNTBKN0NVQytCeFhIWTY4V2E2VDlC?=
 =?utf-8?B?aW5GV3l6VjlYR1BrSGpHRDJDSHVmZUZRbjBzZnVQNXVuUHZ5WmxQWkRzM1BV?=
 =?utf-8?B?MmU0VWhPSFJyOE9raTdqOU5vWEIzQlkxVTRxWWZKMUdyUEp4T1VjdVZ5TFdZ?=
 =?utf-8?B?MEgvRVRXSUFHMUhrTGd4d3daVGExMFhSbzRiWE1ZMkRiZHFKSENzeERCNy9m?=
 =?utf-8?B?djg5MFRwNjNYT05MdWpIczcyUUFBL1d6RzhjaGlTQ253YjBTbUR3UVNOQXdI?=
 =?utf-8?B?UDlBOS91UmFHM0VVVWVVUCtoVFczRXZ0ZmRYbWFlaDJOczNjeUorQjJVbEYx?=
 =?utf-8?B?ZE5WUU8zL3V5bXk1K3VVc3hsUTlIbWt1WjBkMUhsWnBDaWdkZG9INE9nYmY4?=
 =?utf-8?B?cUdxbmloTmNLYitDSDd2VnVRYTVpdFFxNW0zRDV4R25FeEFYcng1RUdVSDlk?=
 =?utf-8?B?eVpRM3dXbGs0NDNMMGNEMnNXUkx5TkErbnFlVlZVZjdkMlhwenBOaWNrYWgy?=
 =?utf-8?B?dHFEVG01YlV2VXNNQ2tPVG5lSmZZdTZHYWwyVDVselNoazZ3aG9hVngrZ24z?=
 =?utf-8?B?ODYydmNIbElJcDFtdXh6WnlvVjdxMmF3TXpuY2ZEa0J0amt0RGY1bklKSDV3?=
 =?utf-8?Q?9gbsIkh+uEQSumZQvEF4xMiCj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dfacc1-8ca4-4c00-8d05-08dc7360956d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 15:23:04.3500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4aSasAtH2qDcPSGxjaeuSkQHSSFLIth0xPkpNitY4Y1VmMPeDpXa2wneJQFrNn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
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

Am 10.05.24 um 10:50 schrieb Arunpravin Paneer Selvam:
> This patch introduces new IOCTL for userqueue secure semaphore.
>
> The signal IOCTL called from userspace application creates a drm
> syncobj and array of bo GEM handles and passed in as parameter to
> the driver to install the fence into it.
>
> The wait IOCTL gets an array of drm syncobjs, finds the fences
> attached to the drm syncobjs and obtain the array of
> memory_address/fence_value combintion which are returned to
> userspace.
>
> v2: (Christian)
>      - Install fence into GEM BO object.
>      - Lock all BO's using the dma resv subsystem
>      - Reorder the sequence in signal IOCTL function.
>      - Get write pointer from the shadow wptr
>      - use userq_fence to fetch the va/value in wait IOCTL.
>
> v3: (Christian)
>      - Use drm_exec helper for the proper BO drm reserve and avoid BO
>        lock/unlock issues.
>      - fence/fence driver reference count logic for signal/wait IOCTLs.
>
> v4: (Christian)
>      - Fixed the drm_exec calling sequence
>      - use dma_resv_for_each_fence_unlock if BO's are not locked
>      - Modified the fence_info array storing logic.
>
> v5: (Christian)
>      - Keep fence_drv until wait queue execution.
>      - Add dma_fence_wait for other fences.
>      - Lock BO's using drm_exec as the number of fences in them could
>        change.
>      - Install signaled fences as well into BO/Syncobj.
>      - Move Syncobj fence installation code after the drm_exec_prepare_array.
>      - Directly add dma_resv_usage_rw(args->bo_flags....
>      - remove unnecessary dma_fence_put.
>
> v6: (Christian)
>      - Add xarray stuff to store the fence_drv
>      - Implement a function to iterate over the xarray and drop
>        the fence_drv references.
>      - Add drm_exec_until_all_locked() wrapper
>      - Add a check that if we haven't exceeded the user allocated num_fences
>        before adding dma_fence to the fences array.
>
> v7: (Christian)
>      - Use memdup_user() for kmalloc_array + copy_from_user
>      - Move the fence_drv references from the xarray into the newly created fence
>        and drop the fence_drv references when we signal this fence.
>      - Move this locking of BOs before the "if (!wait_info->num_fences)",
>        this way you need this code block only once.
>      - Merge the error handling code and the cleanup + return 0 code.
>      - Initializing the xa should probably be done in the userq code.
>      - Remove the userq back pointer stored in fence_drv.
>      - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()
>
> v8: (Christian)
>      - Move fence_drv references must come before adding the fence to the list.
>      - Use xa_lock_irqsave_nested for nested spinlock operations.
>      - userq_mgr should be per fpriv and not one per device.
>      - Restructure the interrupt process code for the early exit of the loop.
>      - The reference acquired in the syncobj fence replace code needs to be
>        kept around.
>      - Modify the dma_fence acquire placement in wait IOCTL.
>      - Move USERQ_BO_WRITE flag to UAPI header file.
>      - drop the fence drv reference after telling the hw to stop accessing it.
>      - Add multi sync object support to userq signal IOCTL.
>
> v9: (Christian)
>      - Store all the fence_drv ref to other drivers and not ourself.
>      - Iterate over uq_fence_drv_xa without holding a lock.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 431 +++++++++++++++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>   5 files changed, 462 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 844f7b5f90db..5892a4c1a92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2918,6 +2918,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f7baea2c67ab..339d82d5808f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -25,6 +25,7 @@
>   #include <linux/kref.h>
>   #include <linux/slab.h>
>   
> +#include <drm/drm_exec.h>
>   #include <drm/drm_syncobj.h>
>   
>   #include "amdgpu.h"
> @@ -92,6 +93,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	spin_lock_init(&fence_drv->fence_list_lock);
>   
>   	fence_drv->adev = adev;
> +	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> @@ -102,8 +104,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>   {
> +	struct amdgpu_userq_fence_driver *stored_fence_drv;
>   	struct amdgpu_userq_fence *userq_fence, *tmp;
> +	unsigned long index, flags;
>   	struct dma_fence *fence;
> +	struct xarray *xa;
>   	u64 rptr;
>   
>   	if (!fence_drv)
> @@ -114,15 +119,25 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   	spin_lock(&fence_drv->fence_list_lock);
>   	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
>   		fence = &userq_fence->base;
> +		xa = &userq_fence->fence_drv_xa;
>   
> -		if (rptr >= fence->seqno) {
> -			dma_fence_signal(fence);
> -			list_del(&userq_fence->link);
> -
> -			dma_fence_put(fence);
> -		} else {
> +		if (rptr < fence->seqno)
>   			break;
> +
> +		dma_fence_signal(fence);
> +		/*
> +		 * Walk over the fence_drv xarray and drop the old wait ioctl
> +		 * fence_drv references.
> +		 */
> +		xa_lock_irqsave_nested(xa, flags, SINGLE_DEPTH_NESTING);

You can just use xa_lock_irq() here, no need for the _nested() variant.

Otherwise you just eventually confuse lockdep into printing false negatives.

> +		xa_for_each(xa, index, stored_fence_drv) {
> +			__xa_erase(xa, index);
> +			amdgpu_userq_fence_driver_put(stored_fence_drv);
>   		}
> +		xa_unlock_irqrestore(xa, flags);
> +
> +		list_del(&userq_fence->link);
> +		dma_fence_put(fence);
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   }
> @@ -188,9 +203,29 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>   		       fence_drv->context, seq);
>   
> +	xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_LOCK_IRQ);
> +
>   	amdgpu_userq_fence_driver_get(fence_drv);
>   	dma_fence_get(fence);
>   
> +	if (!xa_empty(&userq->uq_fence_drv_xa)) {
> +		struct amdgpu_userq_fence_driver *stored_fence_drv;
> +		unsigned long index;
> +
> +		/*
> +		 * Move fence_drv references of old signal IOCTL calls to the
> +		 * newly created userq fence xarray.
> +		 */
> +		xa_lock(&userq->uq_fence_drv_xa);
> +		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
> +			__xa_store(&userq_fence->fence_drv_xa, index,
> +				   stored_fence_drv, GFP_KERNEL);

Again that won't work like this.

__xa_store() can't allocate memory using GFP_KERNEL and also can't drop 
the lock of uq_fence_drv_xa.

> +			/* Erase fence_drv reference entry from userq xarray */
> +			__xa_erase(&userq->uq_fence_drv_xa, index);
> +		}
> +		xa_unlock(&userq->uq_fence_drv_xa);
> +	}
> +
>   	spin_lock(&fence_drv->fence_list_lock);
>   	/* Check if hardware has already processed the job */
>   	if (!dma_fence_is_signaled(fence))
> @@ -240,6 +275,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>   
>   	/* Release the fence driver reference */
>   	amdgpu_userq_fence_driver_put(fence_drv);
> +
> +	xa_destroy(&userq_fence->fence_drv_xa);
>   	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>   }
>   
> @@ -255,3 +292,385 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.signaled = amdgpu_userq_fence_signaled,
>   	.release = amdgpu_userq_fence_release,
>   };
> +
> +/**
> + * amdgpu_userq_fence_read_wptr - Read the userq wptr value
> + *
> + * @filp: drm file private data structure
> + * @queue: user mode queue structure pointer
> + * @wptr: write pointer value
> + *
> + * Read the wptr value from userq's MQD. The userq signal IOCTL
> + * creates a dma_fence for the shared buffers that expects the
> + * RPTR value written to seq64 memory >= WPTR.
> + *
> + * Returns wptr value on success, error on failure.
> + */
> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> +					struct amdgpu_usermode_queue *queue,
> +					u64 *wptr)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo *bo;
> +	u64 addr, *ptr;
> +	int r;
> +
> +	addr = queue->userq_prop->wptr_gpu_addr;
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
> +	if (!mapping)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	r = amdgpu_bo_reserve(bo, true);
> +	if (r) {
> +		DRM_ERROR("Failed to reserve userqueue wptr bo");
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (r) {
> +		DRM_ERROR("Failed mapping the userqueue wptr bo");
> +		goto map_error;
> +	}
> +
> +	*wptr = le64_to_cpu(*ptr);
> +
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return 0;
> +
> +map_error:
> +	amdgpu_bo_unreserve(bo);
> +	return r;
> +}
> +
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_signal *args = data;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_gem_object **gobj = NULL;
> +	struct drm_syncobj **syncobj = NULL;
> +	u32 *syncobj_handles, num_syncobj_handles;
> +	u32 *bo_handles, num_bo_handles;
> +	struct dma_fence *fence;
> +	struct drm_exec exec;
> +	int r, i, entry;
> +	u64 wptr;
> +
> +	/* Array of syncobj handles */
> +	num_syncobj_handles = args->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj_handles);
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
> +
> +	/* Array of syncobj object handles */

Drop that comment, it's actually incorrect.

The other "Array of ...." comments are not very valuable either.

Rather comment why you do something and not what you do.

> +	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
> +	if (!syncobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_syncobj_handles; entry++) {
> +		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry]) {
> +			r = -ENOENT;
> +			goto free_syncobj_handles;
> +		}
> +	}
> +
> +	/* Array of bo handles */
> +	num_bo_handles = args->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		goto free_syncobj_handles;
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_bo_handles;
> +	}
> +
> +	for (entry = 0; entry < num_bo_handles; entry++) {
> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> +		if (!gobj[entry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);

E.g. here you can add something like /* Lock all BOs with retry handling */

And if you give num_bo_handles as last parameter it would making 
allocation of the array more efficient.

> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto exec_fini;
> +	}
> +
> +	/*Retrieve the user queue */
> +	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	if (!queue) {
> +		r = -ENOENT;
> +		goto exec_fini;
> +	}
> +
> +	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	if (r)
> +		goto exec_fini;
> +
> +	/* Create a new fence */
> +	r = amdgpu_userq_fence_create(queue, wptr, &fence);
> +	if (r)
> +		goto exec_fini;
> +
> +	for (i = 0; i < num_bo_handles; i++)
> +		dma_resv_add_fence(gobj[i]->resv, fence,
> +				   dma_resv_usage_rw(args->bo_flags &
> +				   AMDGPU_USERQ_BO_WRITE));
> +
> +	/* Add the created fence to syncobj/BO's */
> +	for (i = 0; i < num_syncobj_handles; i++)
> +		drm_syncobj_replace_fence(syncobj[i], fence);

I think it would be really nice to have the ability have a timeline 
point here.

> +
> +	/* drop the reference acquired in fence creation function */
> +	dma_fence_put(fence);
> +
> +exec_fini:
> +	drm_exec_fini(&exec);
> +put_gobj:
> +	while (entry-- > 0)
> +		drm_gem_object_put(gobj[entry]);
> +	kfree(gobj);
> +free_bo_handles:
> +	kfree(bo_handles);
> +free_syncobj_handles:
> +	while (i-- > 0)
> +		drm_syncobj_put(syncobj[i]);
> +	kfree(syncobj_handles);
> +
> +	return r;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	u32 *syncobj_handles, *bo_handles;
> +	struct dma_fence **fences = NULL;
> +	u32 num_syncobj, num_bo_handles;
> +	struct drm_gem_object **gobj;
> +	struct drm_exec exec;
> +	int r, i, entry, cnt;
> +	u64 num_fences = 0;
> +
> +	num_bo_handles = wait_info->num_bo_handles;
> +	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
> +				 sizeof(u32) * num_bo_handles);
> +	if (IS_ERR(bo_handles))
> +		return PTR_ERR(bo_handles);
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
> +				      sizeof(u32) * num_syncobj);
> +	if (IS_ERR(syncobj_handles)) {
> +		r = PTR_ERR(syncobj_handles);
> +		goto free_bo_handles;
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (!gobj) {
> +		r = -ENOMEM;
> +		goto free_syncobj_handles;
> +	}
> +
> +	for (entry = 0; entry < num_bo_handles; entry++) {
> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
> +		if (!gobj[entry]) {
> +			r = -ENOENT;
> +			goto put_gobj;
> +		}
> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r) {
> +			drm_exec_fini(&exec);
> +			goto put_gobj;
> +		}
> +	}
> +
> +	if (!wait_info->num_fences) {
> +		/* Count syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			dma_fence_put(fence);
> +
> +			if (r || !fence)
> +				continue;
> +
> +			num_fences++;
> +		}
> +
> +		/* Count GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence)
> +				num_fences++;
> +		}
> +
> +		/*
> +		 * Passing num_fences = 0 means that userspace doesn't want to
> +		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +		 * userq_fence_info and return the actual number of fences on
> +		 * args->num_fences.
> +		 */
> +		wait_info->num_fences = num_fences;
> +	} else {
> +		/* Array of fence info */
> +		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> +		if (!fence_info) {
> +			r = -ENOMEM;
> +			goto exec_fini;
> +		}
> +
> +		/* Array of fences */
> +		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> +		if (!fences) {
> +			r = -ENOMEM;
> +			goto free_fence_info;
> +		}
> +
> +		/* Retrieve GEM objects fence */
> +		for (i = 0; i < num_bo_handles; i++) {
> +			struct dma_resv_iter resv_cursor;
> +			struct dma_fence *fence;
> +
> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
> +						AMDGPU_USERQ_BO_WRITE), fence) {
> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					r = -EINVAL;
> +					goto free_fences;
> +				}
> +
> +				fences[num_fences++] = fence;
> +				dma_fence_get(fence);
> +			}
> +		}
> +
> +		/* Retrieve syncobj's fence */
> +		for (i = 0; i < num_syncobj; i++) {
> +			struct dma_fence *fence;
> +
> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> +						   0, 0, &fence);
> +			if (r || !fence)
> +				continue;
> +
> +			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +				r = -EINVAL;
> +				goto free_fences;
> +			}
> +
> +			fences[num_fences++] = fence;
> +		}
> +
> +		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
> +			struct amdgpu_userq_fence_driver *fence_drv;
> +			struct amdgpu_userq_fence *userq_fence;
> +			u32 index;
> +
> +			userq_fence = to_amdgpu_userq_fence(fences[i]);
> +			if (!userq_fence) {
> +				/*
> +				 * Just waiting on other driver fences should
> +				 * be good for now
> +				 */
> +				dma_fence_wait(fences[i], false);

Maybe try to wait interruptible here.

Apart from that looks really good to me.

Regards,
Christian.

> +				dma_fence_put(fences[i]);
> +
> +				continue;
> +			}
> +
> +			fence_drv = userq_fence->fence_drv;
> +			/*
> +			 * We need to make sure the user queue release their reference
> +			 * to the fence drivers at some point before queue destruction.
> +			 * Otherwise, we would gather those references until we don't
> +			 * have any more space left and crash.
> +			 */
> +			r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
> +				     xa_limit_32b, GFP_KERNEL);
> +			if (r)
> +				goto free_fences;
> +
> +			amdgpu_userq_fence_driver_get(fence_drv);
> +
> +			/* Store drm syncobj's gpu va address and value */
> +			fence_info[cnt].va = fence_drv->gpu_addr;
> +			fence_info[cnt].value = fences[i]->seqno;
> +
> +			dma_fence_put(fences[i]);
> +			/* Increment the actual userq fence count */
> +			cnt++;
> +		}
> +
> +		wait_info->num_fences = cnt;
> +		/* Copy userq fence info to user space */
> +		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
> +				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> +			r = -EFAULT;
> +			goto free_fences;
> +		}
> +
> +		kfree(fences);
> +		kfree(fence_info);
> +	}
> +
> +	drm_exec_fini(&exec);
> +	for (i = 0; i < num_bo_handles; i++)
> +		drm_gem_object_put(gobj[i]);
> +
> +	kfree(syncobj_handles);
> +	kfree(bo_handles);
> +
> +	return 0;
> +
> +free_fences:
> +	kfree(fences);
> +free_fence_info:
> +	kfree(fence_info);
> +exec_fini:
> +	drm_exec_fini(&exec);
> +put_gobj:
> +	while (entry-- > 0)
> +		drm_gem_object_put(gobj[entry]);
> +	kfree(gobj);
> +free_syncobj_handles:
> +	kfree(syncobj_handles);
> +free_bo_handles:
> +	kfree(bo_handles);
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index c3e04cdbb9e7..9c5f72a88440 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -37,6 +37,7 @@ struct amdgpu_userq_fence {
>   	 */
>   	spinlock_t lock;
>   	struct list_head link;
> +	struct xarray fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   
> @@ -52,6 +53,7 @@ struct amdgpu_userq_fence_driver {
>   	spinlock_t fence_list_lock;
>   	struct list_head fences;
>   	struct amdgpu_device *adev;
> +	struct xarray *uq_fence_drv_xa_ref;
>   	char timeline_name[TASK_COMM_LEN];
>   };
>   
> @@ -65,5 +67,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 73d225aa3e1e..404c39073661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -28,6 +28,32 @@
>   #include "amdgpu_userqueue.h"
>   #include "amdgpu_userq_fence.h"
>   
> +static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long index;
> +
> +	if (xa_empty(xa))
> +		return;
> +
> +	xa_lock(xa);
> +	xa_for_each(xa, index, fence_drv) {
> +		__xa_erase(xa, index);
> +		amdgpu_userq_fence_driver_put(fence_drv);
> +	}
> +
> +	xa_unlock(xa);
> +}
> +
> +static void
> +amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
> +{
> +	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
> +	xa_destroy(&userq->uq_fence_drv_xa);
> +	/* Drop the fence_drv reference held by user queue */
> +	amdgpu_userq_fence_driver_put(userq->fence_drv);
> +}
> +
>   static void
>   amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   			 struct amdgpu_usermode_queue *queue,
> @@ -37,7 +63,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>   	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>   
>   	uq_funcs->mqd_destroy(uq_mgr, queue);
> -	amdgpu_userq_fence_driver_put(queue->fence_drv);
> +	amdgpu_userq_fence_driver_free(queue);
>   	idr_remove(&uq_mgr->userq_idr, queue_id);
>   	kfree(queue);
>   }
> @@ -405,6 +431,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   	queue->doorbell_index = index;
>   
> +	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to alloc fence driver\n");
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index d3738f645adc..27e1617b234f 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -48,6 +48,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_obj	db_obj;
>   	struct amdgpu_userq_obj fw_obj;
>   	struct amdgpu_userq_obj wptr_obj;
> +	struct xarray		uq_fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   };
>   

