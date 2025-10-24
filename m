Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F35CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B4A10EB25;
	Fri, 24 Oct 2025 17:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vp7TW4B0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357B610EB25
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ7vfd6V4E/aMKPxiYjl+FKokuKE1nJAh/1KcyyLVjUwfEqBJ12zR/m3FK5hzQ3vkIzO2GM7w2QnsYNuW/GkwqlVxoKjMrEABeVeRDYNNRACdzKmtMejoCJPvX59b8dkB56QujSsP9KH/wYvWazAuNjxmMvTyEELsVFJGfLXsvdCwTsmc0tFsmeRImz0udLteUX1cHbs03grMSACb6oBcHHWd4Y67feKeez/PqHMdJ8fKIhI3NVaQdsh6PEeaGxP4Tgc7KHkKbBZivrnO0nnY88YmjaB9cw4yt22qnQn2Jn/gON4Rjl5XjDDBDUcQd+jH2rrfO+M4He/DQwpKJ1zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp1EHhi2ORWm9+Dav6drHPZV907LPTRyeGnfJ6BK6nI=;
 b=n42ADkhd4g4dEbCqGr+I2jxEZEtL32fE0oAmRFftXDkMUlS0+L2g9iX0SswmDo7BLMFMU4hlrHz4N0/016oTPEGlG/RwAkR8fRoTOsz02ebpK4KllP6KSagPIRHSZrfOSsX7h/jC0B/1zgFDzaLPF2QJa9bT1kWGERS4j9sLnXxdn0T0GfL07R/rb4I4sOl061tQUR96U7ATJIiVfWcNIGdRO1YN6no7S0Hv3ax27Rh3mz0Rs+SpxSYOJi35vrB8I8n1PyZfkvrwI37moB1aO1RjOLdfwD/sxdhJ/xDoO4dGd+KVutwlFVtBfTydRCn8bIy9+N6gHGbC0CRgxpIW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp1EHhi2ORWm9+Dav6drHPZV907LPTRyeGnfJ6BK6nI=;
 b=Vp7TW4B0cNKKxcO68ItejcSXjbAawr3ZdnrJN9NEVha17L/XV7OmieazHRlJGmzWAvaHMkITgHBekXQCxrqCgCEb/b8jQz9jZKkiuy/IPSR3kBRURSXJlZelUQsgpJbGxQnp+FHO04DlEhz+FLTtLJyf3pY7PvUkTXIOZx9j/DQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:11:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:11:54 +0000
Message-ID: <c10ff333-d120-4ecf-94bf-7099feb48fed@amd.com>
Date: Fri, 24 Oct 2025 12:11:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: move PMFW rlc notifier to where it's
 required
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lkml@antheas.dev, bob.beckett@collabora.com
References: <20251024170811.57760-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251024170811.57760-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:5:40::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f2681a-1599-49fb-66f2-08de13206e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2R4a3RTU1hMTjMzT0xvSVdhUHFzZFhqNGZRNkFNZjV4b0pmZVhmUVhLOEQx?=
 =?utf-8?B?TnArYXpKbTJOTm1JQlpIWWp6ck5LTmduZHhYdWpQY1ByUEVrSGNWQjBsbFFY?=
 =?utf-8?B?Y29RV0daRWRRZ21KRVpsNmcvZDRNN0pBOFVDRmFUamQ2VU0wSllvc1B3MEwz?=
 =?utf-8?B?UDRzMnBHL2dDYlZSVjEvak9memdVYnVvMzJIMFVqbnZpaWhXRHdzU2VKVE9L?=
 =?utf-8?B?amNxRUxSYkp0cGhZZkNPRlNCY0NqbzF5a0lVQW91MWoxY2grQkQ4MXdYQmd2?=
 =?utf-8?B?SCtzaWVUOVRQRUpXS1ZyLzUyQWpFODhUUDM1aTVTblVkWVRYZTZGUWx2TWwv?=
 =?utf-8?B?clllYnYrS0FhUUhkeXlWREN3TkNKaWJHQWhUZW9pSHVUTndtRVNSUFhMN1FS?=
 =?utf-8?B?cnhhZlV2TnZwaG51RDF0bTE1Z2ZaeHA5TU82NVF6Smp4M2U0NHFycE8vRUJt?=
 =?utf-8?B?SUF5N2xsTkRGbmNmT3dLdGdmOURRSmd0R0pNYzc1b2dPV1VrdjNOM1R6NjNZ?=
 =?utf-8?B?Wk15d0N0MUcySGdOQmg4WGlBVGFSb0dWR1lnUW5oUnNSZFhYbFVHdzRsMmVw?=
 =?utf-8?B?S0s3QUxFbnN6Qit4R3d5bEdadlc0MUl0TUIwNTJBQkdsSmNINjVmM0pha3Nx?=
 =?utf-8?B?dlRRWHVVVGxERnY1VUVIdjBOOFcyWVdvbkgzYzQ4V2ZhY2grRWNtZ3cyblJO?=
 =?utf-8?B?YjFFRU5HeVBYU2YrL1BiVzNDdU0wVDFCNTVkV1ZPOURhMWJzSFdLRjNRdzNF?=
 =?utf-8?B?VmphNzNZVm5JTjJuekRwcGNVNjM0bWFuUUh2YjhoMmtmaU12SmNnRnBqWHNY?=
 =?utf-8?B?MjFnSHorK0dXOHV5eXE5cUo4dEhzelZwejJTVWh1eUQ0YjJ2TnA4a2FHN1dl?=
 =?utf-8?B?Y01od3FnNklxdHB2SlVERnhNRnpUQ3MvR2hDb2hXbWxCQ0svdlhuUjZ5SHg5?=
 =?utf-8?B?Sk9GV1VCZU92NVlUS3dJMS9xRm84NjZJdHRwNkREV0pJZWN3Y2hTZFlUUWxn?=
 =?utf-8?B?ZXRzUDF5VXU3Z0ZRWlpMc25pZEExZjI1T3dmOXdvZVQycmd2d0E2TmlNWEJ3?=
 =?utf-8?B?enB2cWJQSk1VYlF3eFhjRXZhRTRNSjU5UHQ4R3k4b0JJcmx5MkxIa3A5STN1?=
 =?utf-8?B?TlBjZ3FJSFFYUW5KRGR6aGhHWlBXWndTUmZqelVHdmcxTDE2OXdyMC9rbmJ0?=
 =?utf-8?B?M2ttd1VQK1pIdTNZekJlbzBHcVkzbXd2aVBqcEt6RmkrYWcvM3IxYWZrSGkr?=
 =?utf-8?B?alI5UGRhVW15L0RBazVQZ2wzUnAwOVVzWmFjMWVyemMwaTBkdHliZjhSSEZR?=
 =?utf-8?B?R0QxSUxyZGFseDlsUk16NVhoaUVNS3gxb0dXT1cyQVlXWGRIcEJsSlh6c3hU?=
 =?utf-8?B?eWdWcTBWeVVOV2J3Z1FFZklVV0l0Z2dERlg2Mld3K0lTYlpXNVVrL1VSSCtK?=
 =?utf-8?B?VW1HTkNpOWxtRTNYU1VBczVMZDdHdXZyYzJ3Y2JGTHZpYmo4MkVMS0JlNWxr?=
 =?utf-8?B?STlvUEl2N1VBa29YYzNlMUV1bnlRUjduNWxVbVZtdWZwWE1WWlV1U3RvZkFN?=
 =?utf-8?B?NzJ3ejkvS0swbWh0akxZaTVRMGJ4c2tLeEQ1eUV2bjlhTnVRcDRHdXkyVEto?=
 =?utf-8?B?TENHdVRaUWFQelFZelJJODBrZHczV3hTU3I1dkIzYlZGaXhlaXBycmc1U05Q?=
 =?utf-8?B?Sko2WFlDUDQxOU81a3JnSmpWek5rTkljbGtsaHlCbUdHQTVCSjk1ZnJxOUdG?=
 =?utf-8?B?Z0poaEt0OXNudmZ0anZXWkR4WnRlc05qNzlhZ2IvZGhyME8rV29zT2VvdjE4?=
 =?utf-8?B?ZXoxeVYwNm5BV083K21jaEViNWN0b2NGamRQZVVDRmFwaW1QNy9mVHk4ZUt3?=
 =?utf-8?B?eTlCTWwzKzM3eTNKdlRxNkxyd3l2dE4yR0I5Um80SXFrOStCa09UMUZIOWhz?=
 =?utf-8?Q?XLU4VPKEE47fGK4TDH7hIcnWpZOfWz4T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjNNMWN6U3BjYTRpQnc2SHJlTGxHRjBjSW9HaUhJcVBPUVdQUDF2elZsb01n?=
 =?utf-8?B?Uit2OEZKdm9POXRxTVdlZDNvM21HSngxeERidnpjVWlLRU1seVpSNEgyenRr?=
 =?utf-8?B?aTdTVHBwU2NVV0JPZWJkWnQwTThra2NHTm52cXFUd2RBTHROZXFxYjJvQWxt?=
 =?utf-8?B?V3B6VE5EMzdEU2E3V3JHYW1ITVRKVDJKbEpUV3Zsa0RSUkhsNmszWlk0dG10?=
 =?utf-8?B?KzVNZ2wzMUpQZTIyRDRjUVR3RjBUZlZDYkUrZEZnNDR6VUQ3TmkzSW1zbi9G?=
 =?utf-8?B?bkw2VzFkRlVMZzlQVWE4eloyNmxJdlVvKzBCY2tkcENKdUFaVTBhbXRmYmtK?=
 =?utf-8?B?WUpTamkxZnUwaUlwcWIyaFhMZFlqQXNGTXF0VG1wbC83eTVNdnJBcktURkk1?=
 =?utf-8?B?NWhGWDY2c0ZaQXJ6azJYMHNnalJoam5nRjRBYjRFc3FEOGVsM29zK3VsZkw4?=
 =?utf-8?B?L0d2TTFzcWxnTmFTNGJQYm1oYlJHdUFKZzFFbSsxNE9hcWxnRDBCaUtHaDly?=
 =?utf-8?B?a2NNZ21IbTBsV3FSM3cwRTBZVm5HWDlPUEo5dHZqVmZIOGZNT0FlT1Z0QWt6?=
 =?utf-8?B?TTZ1L0Q4Zmd3L3JuOVp1RVNKY25mS3hhdlBLV0M0Uy8rZmlHOTdtelBKaTJq?=
 =?utf-8?B?bDY5R1dNZk9jTXF1TWxHT3lHTnY3UmV6MDBUMjFzdnhKZkpHdzNVYk91RTR4?=
 =?utf-8?B?bWVlakFXaUJiYmlTcDJ0ZEdXUGM1VjVMdWpDTHFteUVab2ZkQ1g5MVZ0Ym81?=
 =?utf-8?B?L2NuRU1VTE1KQytpandzaHdDemZGNEQwMWhkdFpSSzRYVTJaUHd5Vnl4TmV6?=
 =?utf-8?B?cXNKUkc0aXdrN2UwSkZUNEdCVGhJYWpkVXdUeUZyb0NmVHFNWHBmamJFSHoy?=
 =?utf-8?B?eHo2dTFXTlNCYWVMSXRTSFp4N0pMYlBoMW9HcmRqdVVYT0NzdnFUdHNLbjM4?=
 =?utf-8?B?ekJEcGs5UnBmZWxSWWZxTW54SVJGQk1sMHB0V3lrbkZFM0RHNVlzWGF0dVN5?=
 =?utf-8?B?NHRiVXJaUzFZSHVMWURkT3l2MWVwK29TejhQQUhoNzVKQ1F3VEJrMG5TZWZD?=
 =?utf-8?B?YVJoQ1NYWklHNUhQTUhFZXNnSjNQM0Qyd0Q0Tk54RDl2Q3NFZkFRVkUraXVx?=
 =?utf-8?B?Z0NXek1PY1lzRW1lQ1FDV21YSVB1RktWMGpaaUZ5d3JCa3VpdTI2QUxQaUxh?=
 =?utf-8?B?Z05FeTdFRlI4OU9HdGU5YTdVTkEwV1FvR09iSGgyVEduek9GWHdmUlZ5VUky?=
 =?utf-8?B?VndOVlU5ZVRmMVVuRkFKSGtwV1NwK3JmaGsvVDg4S1Y0alROQ2lpeWlGVUJv?=
 =?utf-8?B?aDFpbDlHZ1B6eEZ4aC9RQ2RtVFBpTWM2SUV0RnBCREJCK3l1SEY5ZGlYdi9H?=
 =?utf-8?B?aWdsR1lXcFFBNEJubDlPbTNKSHlHQ3h3NnIzSVptMHp1bjZlam92NWFIbnZW?=
 =?utf-8?B?MHFNNEt2dzFOdTNxOWhPODlJaUVwY24vbVR6KzN2MjRtZGNmalE2ZjJkTFYx?=
 =?utf-8?B?Qkg1V1RKVU5nTyt0UE1tTVVwRTJmSHBtYW1Xd3FsUjgvTHBkQUIxN25PK041?=
 =?utf-8?B?eGxXRFAwQnZtOEREeWY0TFhRbU12MVhxbGM3R2hIZmU4WGM4WjJlVFZ1YzJq?=
 =?utf-8?B?R3FybGMrTm8vckR0U05DMDlPcU95VTFHK0ZJWUJiV2tETm9jOTZNODhMdDJr?=
 =?utf-8?B?SmpQQmkxcFZENytXY3dDZjdYSnhJWkc5WXZySjF1Z0FVWEZlQUVubVBKUGxT?=
 =?utf-8?B?Q3pPbDZXZEFFRTJGMUFlMHM0S2ZvOFhoNzdrcWN2QWI1Wlpla0tRbWdSeC9r?=
 =?utf-8?B?ZVZpd0FxQVNjL0hLNjloN2lacVBwMjkyQ254YWZUQysxN3NNZSt2eVBtNmJH?=
 =?utf-8?B?M3BIaHM3TkMzZlBIeFhodzhMUzBzeHk2Mld1dXRFVEFZWWlCMFBCUVViSzlh?=
 =?utf-8?B?MHNVSVZ2NGFnc0dMUkJiVGZqRFNYbWxzS1kzWURJY1Q2Q3pKVHFyT0kzZ2R6?=
 =?utf-8?B?MHg5M3ZnYW0zR2E4ZmkrSVIrMWlOV1JRWVZzd21lSXhtQXYyUVFKZEZiNnda?=
 =?utf-8?B?dmwyVGI5bllINXkvRnR0MnptVHpaUnV2cHhZVVhkeElxYjZjZkpqQm8zbDc2?=
 =?utf-8?Q?WlwLH0bxOT4C4ZnzgbwEYDmjV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f2681a-1599-49fb-66f2-08de13206e82
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:11:54.8992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwZ8U5tJiRtz7jKT72K4crPCopJuu9KgwgJ1ytF3wMF2ZozBspRvLuq5Thvl/8ohk7Exfiwfbzly+2NCtIdMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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



On 10/24/2025 12:08 PM, Alex Deucher wrote:
> For S3 on vangogh, PMFW needs to be notified before the
> driver powers down RLC.  Move this notification to
> the rlc stop function so it will always get called bfore
> stopping the RLC. The call in amdgpu_device_suspend()
> seems to be superfluous so remove that as well.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

One nit below.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ----
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 12 +++++++++++-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 10 ----------
>   3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5053c5f475ba9..78c0fc3a50ae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5283,10 +5283,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_release_full_gpu(adev, false);
>   
> -	r = amdgpu_dpm_notify_rlc_state(adev, false);
> -	if (r)
> -		return r;
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 39b8adf23a9fa..d64579f5fb1f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5470,8 +5470,18 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
>   
>   static void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)
>   {
> -	u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
> +	u32 tmp;
> +	int r;
> +
> +	/* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
> +	 * otherwise SMU will hang while interacting with RLC if RLC is halted
> +	 * this is a WA for Vangogh asic which fix the SMU hang issue.
> +	 */
> +	r = amdgpu_dpm_notify_rlc_state(adev, false);
> +	if (r)
> +		dev_info(adev->dev, "failed to notify PMFW of RLC powerdown\n");

This should probably be dev_err().

>   
> +	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
>   	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
>   	WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4317da6f7c389..10d42267085b0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context *smu)
>   		}
>   	}
>   
> -	/* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
> -	 * otherwise SMU will hang while interacting with RLC if RLC is halted
> -	 * this is a WA for Vangogh asic which fix the SMU hang issue.
> -	 */
> -	ret = smu_notify_rlc_state(smu, false);
> -	if (ret) {
> -		dev_err(adev->dev, "Fail to notify rlc status!\n");
> -		return ret;
> -	}
> -
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
>   	    !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
>   	    !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)

