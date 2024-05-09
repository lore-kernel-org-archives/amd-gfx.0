Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA13EC25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C09F10F1DB;
	Thu,  9 May 2024 19:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yHhZDrGZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B576A10F1DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORgrwO9WJ2RnC/hLepqpE/43BzuiBj/QwE6AGaIjvkpEzmfuDqs5NJjJ7hKnUhNhII/UwsibsDIttMBXM1EmsWV9VCs5ZY2J7DXN/By2EeHBJJQslpG4aowuRpmZILkZQz1rJB/iE8guZbh2AhT/dWF6I9a1tDQIagy+01ApmM26DDCdWKTwJMyY899UrOYisE/WIN4ZmOP/cwFe+z2fmZWiQVFhc9pctI3ho8NevJo+iEHhXOsPGXFLIQqCrUC/jd+/7zvgVjS/a0Fxvh1zel7nLd18/EFnXRUd9ILFezZdYGl2Tyek/la1+A7uq6gDyFS1bmpa+B/CwDs9kRIddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql0SaFt0azkVe4nNwJjZ428fbr4szcDDrY6fP1OoGps=;
 b=LduNVH1gwpJr9XikMlaOdJXiuMTY+ISFX6eNR42DL00jjK2I/WucrkyFwfSKJ2PG2zNMHxS6cSQamLTOhPgaomyvp8F9NxA1p9s0j3bzwrhZn9wHNM6C+dReS8gKUTC1Xp3iU3olZieGhXheYHcJt+tejRVwYVtKhpWpO5rDPB/NlDTf+i2jxUt1dzq+Xz4G6qqqOYBDffh4YC972+ttTVH4Cat0Dk/OhuB21phYAAJjMcD8XaLFriWsZQyrcoUVD6VjeKzvbrJb421uNYzPDRVlcZhK5hOeR9jp0Mnn+Z3KL7FFQ85pow+bcKoUiqmooauxiunaAPN48dd+XSm3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql0SaFt0azkVe4nNwJjZ428fbr4szcDDrY6fP1OoGps=;
 b=yHhZDrGZ6qBFwgb2FYtsvri2i8Z0jb16Dh4GQA4pcNYGemPlu8nZj4J/0B5tRRQxIBdSLcYl/hRtHBt+0Oi87Ccyn9Usj3TRin+ALQ2NNepiMXp/kvAtWa1H1lxrQn/H7NjdotCZYuuVdKAUL0MZS5hbcZtcdqL7EABQb5ZWmiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Thu, 9 May 2024 19:55:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 19:55:10 +0000
Message-ID: <c5192d78-095b-4806-ace8-2b1bf17732ec@amd.com>
Date: Thu, 9 May 2024 14:55:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amd/amdgpu: Add ISP driver support
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mlimonci@amd.com, benjamin.chan@amd.com,
 king.li@amd.com, bin.du@amd.com
References: <20240509193531.129092-1-pratap.nirujogi@amd.com>
 <20240509193531.129092-3-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240509193531.129092-3-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b3a205-7653-4324-3462-08dc7061eed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUpiZmpDWngwMHozdEN2eGNxWUIxQjNGSGovL2FnMUdMc2NjWG1wRmh2elhY?=
 =?utf-8?B?VDRvRDdmQlgrYnFudWd6MnhMNlpoR25WZGJiZ2JJc2lLb3FlWUR5SGF1aDVk?=
 =?utf-8?B?Ym5aVGtYQjRYZ1FzSy84c1BPcWQ5QlFTbFdVS1daVkRpd0pqSThKV08wbElp?=
 =?utf-8?B?Ny9rRkx3cnAyZklaYSsyZkNRaXk2ejBRdDIwVWw1NVdoUzJ4YkxBaVVPc0t3?=
 =?utf-8?B?bTZoa1k5ODRhaTEwZVVVenJZSCtJSjl2Ny9QYjEzaktkYmc2NlZYS0w4S0to?=
 =?utf-8?B?TzZxcWZLSlpOcmZ6OUNDQ2JyQmQwN1hiZ0RiWlFPTmtNSmFGc2UvVlRGS3A0?=
 =?utf-8?B?L3o0eEs1RjRwaHpFb095MmpjbnJmLzdpUlhaN0lnd2IyOTJKWGxjdWpjMjNh?=
 =?utf-8?B?VHpJOEdWVmI2WC9kRmxBT2IzaG80Qk1FOFduRzdjRmVVYTlJWlNadHVpTmJX?=
 =?utf-8?B?dUpuS1Jma3lyK0FJMm1xbjYzMm9aMjBlNVV4Rkw2eEMvSlJJQnB5Z1FVc2Ix?=
 =?utf-8?B?Z0NFZ0h0VHU0MDVxNDFiZ1JVV2E5UkR6ZnpEZnBHa1k0OTFoNW9qSGZBRzlX?=
 =?utf-8?B?T1pDNFFaVlRMZFpDOEYwV0Nib2paSWo3RzRoY3Bic0VaTXRIZFJENmgrbzJP?=
 =?utf-8?B?c1k5dVpXRnVXeTlXNDBWMy9wV3pHVjdhTFhSUjQyVkl3WlpKTGlBbUliejZJ?=
 =?utf-8?B?SExsRlNBcHY2dUJtN2h5NFdtR1Z4a1pRMXpkeEtyYmUyNW96OWI2eng3a2lC?=
 =?utf-8?B?V1lMbmd0WXJPTytBMFdpL1hFUStHY0RsbklJSm43cVVLSENwNXVnbHlmUGpp?=
 =?utf-8?B?c2RJdThldFRZMC9UZ2RKeTFMaTl6K3JiOXlicWVlaTMxQkl4alBmRzBJODUx?=
 =?utf-8?B?TEZpZXJDalV3OEFFdjR1Qm9DOSs3bVRLT2JxWnB2M0hOeTQ0OEMvQlZ3akNm?=
 =?utf-8?B?NUxoZlpOa0pJOHBvbHhjdGhPYVJMc3pkZCtpbFlYQWE5SU9mTm5GNEtGVHFz?=
 =?utf-8?B?UWxualpHeDZGREpTVDlRVVRRREYwa3RKS1JEZ0hJL29pcUdJRGM2b2RQcGNj?=
 =?utf-8?B?dG80VUY3cjVqWi9mRU85cXk5MTJWM0VGYU1XRVlla2JYZHduWDdLRkRhVlVk?=
 =?utf-8?B?bzdyVjNPbHQyNS9EbEZwbys4TEZ5SkppeGJwelJsZWxvdWdUOWkvejF3OGpp?=
 =?utf-8?B?OTBKdG9qcHFxb0JweEJYeEhxOHhVUFNMejA0QWxWWjBiWENkYnBCcm84ek9h?=
 =?utf-8?B?SW9lV21Gd0dPNGFkeGZqazJONTNYWGgra2NyNWttWlVDS0tFeStZR01qM1RT?=
 =?utf-8?B?SFI5NTNYZ2FRNU5OUW9YbFpkVDJPb3ByamxpNGJPd29wTXZUSUswaGkyR3U2?=
 =?utf-8?B?YmdRSkdlWVliWTRNMVZSL1ZJK205ZTBsRmFKY1hRa3Z0My9rWUpPL3lqWEN2?=
 =?utf-8?B?WFlUeXoybmVMRHhwcjZhajZaU1NVd1AyZDBDRzNpdlNlRkpBbVZYUzByVzhj?=
 =?utf-8?B?Q0ZOOVhUN1NJQ05DUjBRQitWVWFRT2VlYmxSTnJucHViRFpXamJ1bmhIMUpW?=
 =?utf-8?B?RHBNSUhXMG5FeHdsN1pmL0RZdWdsK3dwUU9mdk40WU0rNDdaNlpIbDZtQkYy?=
 =?utf-8?B?OGNhVW1aZWxMOGVBZmsrRkJrT3RpTjFHYThNWFdnSHBxK1lDTVZwZlZOQkMr?=
 =?utf-8?B?SHFlRVAreGRHNnpoSzNHNHZYZUp0TmpXUzVNSXpvWVNRRFNSWEozNUlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE5GV3lQUDVEY1grVDNCZjF3WWxnYkM2d283cW5laXQvVEpJYkZkdnZvUlVh?=
 =?utf-8?B?WEE0eGordWh5bVpFNGJoWHhtODVwRTZpdXpMUEFEK0tId3c1UndwaVBHZ2hs?=
 =?utf-8?B?aGlwZW1UQitHZ2MvR2Z2cm5nMEhaYXArRm9rNlRDejQvQmtVNVNxeG1hL1Zp?=
 =?utf-8?B?Rk02MXZnSmZvaWpxTmQ3VG5ybFp2cEtKZWQ0MGJjekROb3p3Ym1VZTdLNkhG?=
 =?utf-8?B?eWVuRHJzSHVhWHlTRlhLNk5uTFZDTmhYZE1xTnVrSHhPOWREOUtMTUhFcDM0?=
 =?utf-8?B?aW1JSkphYzFzTWpCMVNzRFhZUTAveUgzSmVKOXdlcEVmTktHbU4yZ1FISUxU?=
 =?utf-8?B?VW11UTJkRVN2dy95dENHZUJxUHhKd0poQjdBRWhpVnFhYzJ2cGtCRktETVFl?=
 =?utf-8?B?SjQxTXdKSVBPc01HdWhHdkRaRjRnbzdaOExhc0dTT0UyUDdTdGhCUE4veHFy?=
 =?utf-8?B?NFk1VkJMOUFzKzlIT0taakhFd2pLcVc0TkhDSkxEQnJPb0NyMFVwT0cwZFBW?=
 =?utf-8?B?UDd3NGVMbCt2dkVtZDFvaHRhaUdZeUtFYVllMFNmR0FXOFBib20xUHVjYnI5?=
 =?utf-8?B?Q3dwN2F6Rmh2b3NIQ0k2V2FhUkRNbjUzd2Q1bGZSNlNDcUp4RHA4YXBUdmVj?=
 =?utf-8?B?VDFDK2ZTM3E4RTNkL1lYY1pDZ0dTb3lESkR2UUhHQy96Sk54ZkFLaGR2REdI?=
 =?utf-8?B?SGRmdVdKeXhTNFBRcDVqeG1UQk96L0lOL2wxSzIwUUh6cVFsVWRBc3I5STJK?=
 =?utf-8?B?VXhabTlVdnlHOGM5cFFMalhheEhXN1NNK0tQT2RLSW9WREUwK1dtUmxHb3JY?=
 =?utf-8?B?MHlLY0ZBU05qU2JNeHlEd0NUZXhKSXk4Qk8wa29vYU1iejdLT25pMTIydXhF?=
 =?utf-8?B?VVExNFk4MDBkbVQ3SWpkcFpxbmI4NFVIS3RmM1VUdUo2TUYxcUtVQjZkZTdP?=
 =?utf-8?B?ZHljWE9LampvVUFIamMzRWJKb011ME16bWxod1FMU0ZPRWpCWVB3d3d6NEcv?=
 =?utf-8?B?VjlOZnF0TkRvazkvT0g2UFp6S1REVjVVOXBoK3BPTGFxY0tRUlBMQ0ZRMHhl?=
 =?utf-8?B?bzhuMTFhUUllMEZtUGlLbElCbytpR2hHbjdkVk1PWEE2UDhKeG5pWjA0bnZL?=
 =?utf-8?B?MkNicDBHZjV4NWliL3RkOEFXTUcwV0NVVTVGZVlJaVprK2N3MGV6REd2UjNv?=
 =?utf-8?B?V1k1ZHJ5cmZPV3lkU1luYm1VTEFDdzhIN2dXTzdycjc3SFhsbkZtTXRJSlVi?=
 =?utf-8?B?WUdWTktzZmwybzJsWkwvOEREZGxjcXlUV2FvOTdsd1hWZHRaZUhHbVhpVWpR?=
 =?utf-8?B?Yi9QdnNZajZxdk02b2d4ZHBJSThnellPbmFScWZjUHliRFQvYU4yQnhYYkpD?=
 =?utf-8?B?ek5xNEJwMDR2M0JPdU5iVjJRcE1PREl3ZGoyNUErNkp5TTNsSDh1d3pCckZS?=
 =?utf-8?B?VnNmOTExdkxXUHV4NThKRFhQL20ySU9TbTlJS2dzS2k4YUQ5Y2NjbC8rYlpR?=
 =?utf-8?B?Sk45QklDU3dWbHJsR09vV0FacklkKzNNMDNKZ0NBemYzSFVCQmRzVDl6dHov?=
 =?utf-8?B?dGt5MUo3ODdhT3BxNzhXWFhTYjZlRE80dHlqcUN3ZkN5Q3I4SWRaaUorc2pt?=
 =?utf-8?B?WENSYmhRR09EUmYzVEhnTkF3Wjd4TWlZLzN5Z3J3UlppNm9WMjlPY0g5dy96?=
 =?utf-8?B?S21aVWttL3VhbkRaZ1E2ZGdQR1F5RG9HTW0wNlIzcC85c1lUUlhUYWxyKzRw?=
 =?utf-8?B?ZGNVQjFQQ1cwTkFyUlVaRGl1N3FMOFY0MkxmNnJOTlZMVW10WUJjZmg0TXR2?=
 =?utf-8?B?RDFMd3lVQjBoZDhDdStNcmtVOE1UWkJ0OWZ6L1VmbFREYi9SMkxOQ3ZJbWds?=
 =?utf-8?B?dEJKR1hnUk9lZzJldGFuRkJsdmRlOGZ4VGpEUFhFRnF5RHdvVGw2bURqbG5S?=
 =?utf-8?B?T1BDNytNVlpMWkcrZS9UQXY3OWZYWnFUSzZqZVVCdVRzd01kZzcvNk5rNVlv?=
 =?utf-8?B?aFkyNjFEVFY4cENNRU5DaGxhY2l4RWJaZGRtbVVnb3h6cGhZUkhaRXJOU01D?=
 =?utf-8?B?UkxLTm5yeUFCQ1JNL0hjWkZMckpiU0dTWndDZTVYU1dtSWFvM1VHaHdncVM0?=
 =?utf-8?Q?WnreJOeudaMi3nia+jssvIkix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b3a205-7653-4324-3462-08dc7061eed6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:55:10.2150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2zi09LzSb1V1CBIQ/2zr6KFwtCbh7ECjzbKecS161mI2qDSorBt71ABNOwmBVGvDS6KHMGXrSTZMl44CIHbfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

On 5/9/2024 14:35, Pratap Nirujogi wrote:
> Add the isp driver in amdgpu to support ISP device on the APUs that
> supports ISP IP block. ISP hw block is used for camera front-end, pre
> and post processing operations.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Change-Id: I67ef206e5eca1fe74e495c3262746be495e17d09

Ttypically we strip the Change-Id for things that were in Gerrit originally.

> ---
> Changes in v2:
>   - Remove adding IORESOURCE_IRQ
>   - Remove noisy info prints
>   - Avoid isp version numbers while naming
>   - Fix incorrect argument description
>   - Replace // with /* */ for comemnts
> 
>   drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c   | 287 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h   |  54 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
>   7 files changed, 357 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index de7b76327f5b..12ba76025cb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -324,4 +324,7 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
>   
>   endif
>   
> +# add isp block
> +amdgpu-y += amdgpu_isp.o
> +
>   obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index eb60d28a3a13..6d7f9ef53269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_seq64.h"
>   #include "amdgpu_reg_state.h"
> +#include "amdgpu_isp.h"
>   
>   #define MAX_GPU_INSTANCE		64
>   
> @@ -1045,6 +1046,9 @@ struct amdgpu_device {
>   	/* display related functionality */
>   	struct amdgpu_display_manager dm;
>   
> +	/* isp */
> +	struct amdgpu_isp		isp;
> +
>   	/* mes */
>   	bool                            enable_mes;
>   	bool                            enable_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> new file mode 100644
> index 000000000000..c28d90c25b10
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include <linux/irqdomain.h>
> +#include <linux/pm_domain.h>
> +#include <linux/platform_device.h>
> +#include <sound/designware_i2s.h>
> +#include <sound/pcm.h>
> +#include <linux/acpi.h>
> +#include <linux/firmware.h>

This list of headers should be sorted alphabetically.

> +
> +#include "amdgpu_smu.h"
> +#include "atom.h"
> +#include "amdgpu_isp.h"
> +#include "smu_internal.h"
> +#include "smu_v11_5_ppsmc.h"
> +#include "smu_v11_5_pmfw.h"
> +
> +#define mmDAGB0_WRCLI5_V4_1	0x6811C
> +#define mmDAGB0_WRCLI9_V4_1	0x6812C
> +#define mmDAGB0_WRCLI10_V4_1	0x68130
> +#define mmDAGB0_WRCLI14_V4_1	0x68140
> +#define mmDAGB0_WRCLI19_V4_1	0x68154
> +#define mmDAGB0_WRCLI20_V4_1	0x68158
> +
> +static int isp_sw_init(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	adev->isp.parent = adev->dev;
> +
> +	adev->isp.cgs_device = amdgpu_cgs_create_device(adev);
> +	if (!adev->isp.cgs_device)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int isp_sw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	if (adev->isp.cgs_device)
> +		amdgpu_cgs_destroy_device(adev->isp.cgs_device);
> +
> +	return 0;
> +}
> +
> +/**
> + * isp_hw_init - start and test isp block
> + *
> + * @handle: handle for amdgpu_device pointer
> + *
> + */
> +static int isp_hw_init(void *handle)
> +{
> +	int r;
> +	u64 isp_base;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +

Spurious new line here

> +	const struct amdgpu_ip_block *ip_block =
> +		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
> +
> +	if (!ip_block)
> +		return -EINVAL;
> +
> +	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
> +		return -EINVAL;
> +
> +	isp_base = adev->rmmio_base;
> +
> +	adev->isp.isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
> +	if (!adev->isp.isp_cell) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	adev->isp.isp_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
> +	if (!adev->isp.isp_res) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	adev->isp.isp_pdata = kzalloc(sizeof(*adev->isp.isp_pdata), GFP_KERNEL);
> +	if (!adev->isp.isp_pdata) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	/* initialize isp platform data */
> +	adev->isp.isp_pdata->adev = (void *)adev;
> +	adev->isp.isp_pdata->asic_type = adev->asic_type;
> +	adev->isp.isp_pdata->base_rmmio_size = adev->rmmio_size;
> +
> +	adev->isp.isp_res[0].name = "isp_reg";
> +	adev->isp.isp_res[0].flags = IORESOURCE_MEM;
> +	adev->isp.isp_res[0].start = isp_base;
> +	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
> +
> +	adev->isp.isp_cell[0].name = "amd_isp_capture";
> +	adev->isp.isp_cell[0].num_resources = 1;
> +	adev->isp.isp_cell[0].resources = &adev->isp.isp_res[0];
> +	adev->isp.isp_cell[0].platform_data = adev->isp.isp_pdata;
> +	adev->isp.isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
> +
> +	r = mfd_add_hotplug_devices(adev->isp.parent, adev->isp.isp_cell, 1);
> +	if (r) {
> +		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	/* Temporary WA added to disable MMHUB TLSi until the GART initialization
> +	   is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
> +	   using the TLSi path */

Linux "multi-line comment style" is

/*
  * Foo the bar
  * Bar the foo
  */

> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
> +
> +	return 0;
> +
> +failure:
> +
> +	kfree(adev->isp.isp_pdata);
> +	kfree(adev->isp.isp_res);
> +	kfree(adev->isp.isp_cell);
> +
> +	return r;
> +}
> +
> +/**
> + * isp_hw_fini - stop the hardware block
> + *
> + * @handle: handle for amdgpu_device pointer
> + *
> + */
> +static int isp_hw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	/* remove isp mfd device */
> +	mfd_remove_devices(adev->isp.parent);
> +
> +	kfree(adev->isp.isp_res);
> +	kfree(adev->isp.isp_cell);
> +	kfree(adev->isp.isp_pdata);
> +
> +	return 0;
> +}
> +
> +static int isp_suspend(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_resume(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_load_fw_by_psp(struct amdgpu_device *adev)
> +{
> +	const struct common_firmware_header *hdr;
> +	char ucode_prefix[30];
> +	char fw_name[40];
> +	int r = 0;
> +
> +	/* get isp fw binary name and path */
> +	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
> +				       sizeof(ucode_prefix));
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
> +
> +	/* read isp fw */
> +	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
> +	if (r) {
> +		DRM_ERROR("%s: failed to read isp fw %s\n", __func__, fw_name);

I think you should lose this DRM_ERROR() statement.

when isp_early_init() is called with the file missing you'll see this 
error as well as the DRM_WARN() from isp_early_init().

We should show exactly one message for problems like this.  Since it's 
not fatal I think we should only show the DRM_WARN() message.

> +		amdgpu_ucode_release(&adev->isp.fw);
> +		return r;
> +	}
> +
> +	hdr = (const struct common_firmware_header *)adev->isp.fw->data;
> +
> +	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].ucode_id =
> +		AMDGPU_UCODE_ID_ISP;
> +	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].fw = adev->isp.fw;
> +
> +	adev->firmware.fw_size +=
> +		ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +
> +	return r;
> +}
> +
> +static int isp_early_init(void *handle)
> +{
> +	int ret = 0;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	ret = isp_load_fw_by_psp(adev);
> +	if (ret) {
> +		DRM_WARN("%s: isp fw load failed %d\n", __func__, ret);
> +		/* allow amdgpu init to proceed though isp fw load fails */
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool isp_is_idle(void *handle)
> +{
> +	return true;
> +}
> +
> +static int isp_wait_for_idle(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_soft_reset(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_set_clockgating_state(void *handle,
> +				     enum amd_clockgating_state state)
> +{
> +	return 0;
> +}
> +
> +static int isp_set_powergating_state(void *handle,
> +				     enum amd_powergating_state state)
> +{
> +	return 0;
> +}
> +
> +static const struct amd_ip_funcs isp_ip_funcs = {
> +	.name = "isp_ip",
> +	.early_init = isp_early_init,
> +	.late_init = NULL,
> +	.sw_init = isp_sw_init,
> +	.sw_fini = isp_sw_fini,
> +	.hw_init = isp_hw_init,
> +	.hw_fini = isp_hw_fini,
> +	.suspend = isp_suspend,
> +	.resume = isp_resume,
> +	.is_idle = isp_is_idle,
> +	.wait_for_idle = isp_wait_for_idle,
> +	.soft_reset = isp_soft_reset,
> +	.set_clockgating_state = isp_set_clockgating_state,
> +	.set_powergating_state = isp_set_powergating_state,
> +};
> +
> +const struct amdgpu_ip_block_version isp_ip_block = {
> +	.type = AMD_IP_BLOCK_TYPE_ISP,
> +	.major = 4,
> +	.minor = 1,
> +	.rev = 0,
> +	.funcs = &isp_ip_funcs,
> +};

I think this is the wrong place for this isp_ip_block and also it should 
be named differently.  Maybe it should be named isp_ip_block_v4_1 and 
then in a different file?

Maybe Alex can confirm how he would rather see it done.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> new file mode 100644
> index 000000000000..2adcb4b4dc6e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#ifndef __AMDGPU_ISP_H__
> +#define __AMDGPU_ISP_H__
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/core.h>
> +
> +#define ISP_REGS_OFFSET_END 0x629A4
> +
> +struct isp_platform_data {
> +	void *adev;
> +	u32 asic_type;
> +	resource_size_t base_rmmio_size;
> +};
> +
> +struct amdgpu_isp {
> +	struct device *parent;
> +	struct cgs_device *cgs_device;
> +	struct mfd_cell *isp_cell;
> +	struct resource *isp_res;
> +	struct isp_platform_data *isp_pdata;
> +	unsigned int harvest_config;
> +	const struct firmware	*fw;
> +};
> +
> +extern const struct amdgpu_ip_block_version isp_ip_block;
> +
> +#endif /* __AMDGPU_ISP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 37820dd03cab..b4bd943a7cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2539,6 +2539,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>   	case AMDGPU_UCODE_ID_JPEG_RAM:
>   		*type = GFX_FW_TYPE_JPEG_RAM;
>   		break;
> +	case AMDGPU_UCODE_ID_ISP:
> +		*type = GFX_FW_TYPE_ISP;
> +		break;
>   	case AMDGPU_UCODE_ID_MAXIMUM:
>   	default:
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 75ece8a2f96b..a9de78bb96e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -712,6 +712,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
>   		return "RS64_MEC_P2_STACK";
>   	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
>   		return "RS64_MEC_P3_STACK";
> +	case AMDGPU_UCODE_ID_ISP:
> +		return "ISP";
>   	default:
>   		return "UNKNOWN UCODE";
>   	}
> @@ -1411,6 +1413,9 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	case VPE_HWIP:
>   		ip_name = "vpe";
>   		break;
> +	case ISP_HWIP:
> +		ip_name = "isp";
> +		break;
>   	default:
>   		BUG();
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index a3c04f711099..db745ab7b0c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -523,6 +523,7 @@ enum AMDGPU_UCODE_ID {
>   	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
>   	AMDGPU_UCODE_ID_P2S_TABLE,
>   	AMDGPU_UCODE_ID_JPEG_RAM,
> +	AMDGPU_UCODE_ID_ISP,
>   	AMDGPU_UCODE_ID_MAXIMUM,
>   };
>   

