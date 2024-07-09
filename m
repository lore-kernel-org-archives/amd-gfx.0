Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0CDC3DA41
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 09:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3E610E4D9;
	Tue,  9 Jul 2024 09:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AK0Watot";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F64210E4D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 09:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h65gY7edj7TGO1GsrjDW/uHXVLTIEhgXX4eWXQ5Tn938yl1A+1D/+g3IocA1+VJmMfQllqFy2XNL4IZ+AlvmjYpseoSLyRkuJUXPaA1bjlv/SV52/jK0Oj80Var6eNnqhxsvvu8y1LleBpRPAt89A8/dD4K5sMerh8xU6+MXyvaJuqPp3x61uuxujyJnhuZWrsNRYjoYF73Jhnhc1DdFIAasY6Dt3keVxU/1GrR26rjfEQilaR6VepG5WdkljBq+/KPPeORjzqjDWB4Wj3J+JL2KrQNDkdgb469mUm7/xnAovlk3THBbAbO0VUaxX/jVrmKZcGgfkP4uQBQpGiqBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AazSoouQwXPWmGBDIZ47jrnBSmb+IZzO+RBQa724Cis=;
 b=O3Nfi+AeP6SOy+dSQ+rteVtNIkOCBMDuMbN+OiwW5FpZls6AxfZ7IDa8OuQT5D00tbi5f9SirhXakquiYvWZvR3UPXQrjJFbKau7W3YWohlLpPeSuR1ISHDxY+yTdvL/CT68mlHXniXuSvtLttNNPlh63qEwJnvGt+zDQjIX1vHVWpvF4q9fb6Nr34dDBoYtCiNVqmBZVP0C7YqBto1t2zzwawt5mwc8W2tqIQAgIFWZL1L9QXOIXVeku8CqRdxPfQXr+XPXPkMJld1z1PMPqpwys3/KQACbOwQiyDnJ7nxwnRHWsdwxfsIx3HReoE3XVP99rOVbFh2hgRqF9ufL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AazSoouQwXPWmGBDIZ47jrnBSmb+IZzO+RBQa724Cis=;
 b=AK0WatotN3YHBv3XAsHPTh9Oz2hC5uHOeO7QC+1ZYDcZrsW99saK47qfvZvSct/AtYKCk/8gFRFVGraolX6KpLkhtquKMjdtUb5jlI9N1WJl16KzVAr654oDwXeaLYXEkUUNhwwM1ieoa0BCu353wcN6mYrTqA7itt9DgJBvdPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Tue, 9 Jul
 2024 09:33:16 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:33:16 +0000
Message-ID: <e89d821f-aefe-40a0-a03c-3c610377b24e@amd.com>
Date: Tue, 9 Jul 2024 15:03:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Ignore initial value in smu response
 register
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240708133106.36933-1-danijel.slivka@amd.com>
Content-Language: en-US
Cc: "Wang, Yang(Kevin)" <kevinyang.wang@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240708133106.36933-1-danijel.slivka@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5ba146-8296-42d9-68b3-08dc9ffa2950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d08yU3docHhPUXVwdTVsbHpaNVNsL0JIcVcveWU3YVRWTjJYUVcxYkswb1RO?=
 =?utf-8?B?R3RNaHZBSEdKZWVkazdSRThseFVPaXpuT3o1VVIvZmtraXlwRjZ1MEl6QTdq?=
 =?utf-8?B?YnBNNGRiMUE2SC9LalQ0N0grQ0wrcDRnKzVKQ25QYkdGanNKUXFEcjdIVGpS?=
 =?utf-8?B?UHlralJQQThoWGwxaUFJa2F1cW96aFpXYVVyNnZEeEFESmJjOWRSMVVFaENq?=
 =?utf-8?B?Tk5BVmJBaVl3ZmphVUNDcFowUU1nRjR2Nk9UZEdFbVpOc0hDMzlQNE4rTE4r?=
 =?utf-8?B?dWI2cVFTUXRPWWd3bDJ5Q09yUHp6aXE4OXpxbzJ2Rlg1R3F6UGdmTkUwZEp3?=
 =?utf-8?B?Q2EralNqd2krWktqTXVzaDZHaERGOTNLeS9jckdadXplUHhKMUNGSFoyNFVx?=
 =?utf-8?B?MUQ3SlE4V2dVaVdRK3Fvdk9LczRtcEMrL201VTY0NFZlc1Y2TllvSUZ4V2xr?=
 =?utf-8?B?eEtlSlpiMFE3WFF4bnNDMnp0K1FHWWFkb05hL0M4QUZIdFhtY2lyU2xjajBv?=
 =?utf-8?B?d3Z1UUxaYjZWTTh1R0owejdsS25nUGNxMGNzSkxySElYbHUzT1lqY0ZGMkFT?=
 =?utf-8?B?K1EzaXJzVDAza1ZlL3lhMnQzR2NrcTgvNVFCQzV5MVpnanRqVDdJZjk4czJQ?=
 =?utf-8?B?TGt0V293aXZlczVQRkErT2w0SkhERjBkOUhpbXZ3UXRSSkxERWVJekttNlh4?=
 =?utf-8?B?VFpZTWs2TVFkYkxDNUZXMWdvcUZUOHdrSWhlYXhObDlXS3psYW51TW1majZC?=
 =?utf-8?B?cU15aTZpRkpwamdha3R3ZE9wUCs1cytwOGxzbUFaWFlDdHF5S0dLSU9JRVQ5?=
 =?utf-8?B?eDRFOUZtclpEcjA0ekF4enpIb1l6QjdVZjlUZUpsV0ZNUEhNZCtaUmhLZXVJ?=
 =?utf-8?B?ZGd2UFRoS3IxdDBpOWZGMkRNcXFYRUZOY05tU2QzZy9WdlpxQU8zZXdsY2xv?=
 =?utf-8?B?SzZ0UWZGMGJJem11cFp4NHBKOW9tbU8rMnE3bVRGZ3h0c3NIOVA1alRZSUZl?=
 =?utf-8?B?TitqakhNZllhbUdGbnpuMkJmVGw2V1l1OEhEbHlVZDBPRFlaL3pQYmZscTlt?=
 =?utf-8?B?a2o5dXUvOTczRUQ5ajlXMzFvR2xNY2pQQXFnOVExc1U0QS9sYm1INjlMK0JG?=
 =?utf-8?B?NmFyeWxxV2I5ZS9lcDJ6RDVCbEtGb3Y5MDRHc3ZUMG5UNExZcGtFbVRGZXFQ?=
 =?utf-8?B?bStrbHV4enVmV3lEVEV2QUNWdmEzRzhPdHNmdEF5SXhUTk5nMk5VWkk4eFJT?=
 =?utf-8?B?OGJwQ2tmeXdnRUF6MkRGTXg3cUJYNVk3K2xlZWRiWHZkT0hsc2xWWnI5Vldt?=
 =?utf-8?B?WGRFWWw1bDRBKzBNRjcwYm1JdHBIQlNhUS9vdTdQTmxkQWR2ZzZJMWJIMUZH?=
 =?utf-8?B?MkVXOEN6NGpKZnRoOXpXbVJ1SHQyVmxNN0poY3ZSWk85Z1daOHo5MEUvUnd4?=
 =?utf-8?B?TkJreDAvdU5lbnVTSStvSnNja3Q4ZDc2SXBDOWpudm4zUjl4akNyQzJWNVhx?=
 =?utf-8?B?VkQyaEJzVUU3M3lCN2FWYkRCVDFIbkJ2K1NuYnpZSlUyU3dmNWNTdFFTelZN?=
 =?utf-8?B?Uzh6Mjc0REU5Q2VqcFVrZTZWSW9LWTFTR1FoUk5aejFNdFVMNitRTkptY09G?=
 =?utf-8?B?RE9vdE1IZ1dlUll2aU9KWlRVbGwzd0xJRHFRb0ZhWnBvZjd4N1JLSEFmaG9s?=
 =?utf-8?B?UEZtbkJUeDJiUGw0ZUlVdXloclY5UjFvRVRic1VjQWhtcVNpcW9pK1RQV0dG?=
 =?utf-8?B?d1FKVTlzVmN5UGllVjJvN1F3RXZZZnBMUkFselFMR2YwOVBkbklOLzBpVHFI?=
 =?utf-8?B?ZFVoK292MWJiMkVoRWM5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3IxU2NmWVZIV05DSkFwOHIva0lWaFNpNVEzVnJXTEtpK1VmOHRWSVBlQlVP?=
 =?utf-8?B?QlZ3SnBuYnY1QzhiRTVoRjIvMnhWYXI3akZHb2x3MUk4QUNlRVB2V1JtbUIw?=
 =?utf-8?B?clRWSjNQcXVLMkhUMmxoTjcrWFhxQWsxa0l0ck5xb0xoNithaHROUlpDTlNC?=
 =?utf-8?B?ZzhjVC9HVmgyY3R5YkZSclU4dGQzbk9rWE9CR2Z2SzJFdXc2QmZXN2dZZ1lQ?=
 =?utf-8?B?VmJCUVZ6MlJPQWROeFFmTHZkdmE0RUF3UTJjOHJJV3J6czZ6M0Q1QnNKWW8r?=
 =?utf-8?B?Qmt4MkZ5dUdsRXBpMmVScWUxaW5uR0Y5TEFXeHV3VG9ibWpMWnNrYzEwVjE4?=
 =?utf-8?B?TmJ2eHdGZlo4a3paazB5VktSMk9ybWErU3lOVnhVRHFtbzAzRmxFWDdYUGp0?=
 =?utf-8?B?SlhQblM3eCtxcDVWc091eTl1UVZRUittcThiLytHck9vb0M3RlpwNHlRZitu?=
 =?utf-8?B?bkwwQlJIVjJhMHFkYzVKMlBiYm5uMTlJeTMrZlk5Z0x2aUh0dE9mTUhmVjFJ?=
 =?utf-8?B?dEJwWVYrdUIwOG1VeWUwQmhHWjVGeGRyTlBjaTZKZkNHL285bjNFNDBZWGgz?=
 =?utf-8?B?bjAzSjJyMWZHTWwyVXNLSDUyVWJQMWxFTngzR3A2UFR5RDY2R1BYVmN0c2c2?=
 =?utf-8?B?REZZOGJPTDRQWURIWThwQXcxWDBndjZNMm1uSzJUY3NFbGRsWnhkcmVpcjRZ?=
 =?utf-8?B?a0RBbmRNbXNBL3ZzUjRYb1BtdWU5MTQwMVpWcU91Q0tmVWpTTndXQUhnMUlY?=
 =?utf-8?B?SWZWdUQzMy9DVlpCSkJZbE56ZzZDL3JmUnZBOGJoa3ltL1NmRkdiUVVZbkNj?=
 =?utf-8?B?M1NJZW1qNXp2WHY2NFo2Y1JvWHQ2cmN5ejRHbmxjdTB4NnFtbGlhYjJROUF3?=
 =?utf-8?B?NDA1S21SSk1uRGJ3YVMrSStOb1lYNzVZYldHWnJ1enNlTmRyemhlYk1qbytt?=
 =?utf-8?B?NE9Sb0NVT2hTbFZxQmN1SktGQ01vc0JBcTVWcjMrQTdEUDlQUDhCN2JGWjgx?=
 =?utf-8?B?K0xVYW1VdmIwblFVRXpodzRjVngvNTkyQ3JuTW5WQ0tyaEp6d0I3eUdNQTlt?=
 =?utf-8?B?MXpwNTRiMDBTUm1tNnJBV0QrYndCdnUvMU4vM0pBdURwNnF0NkxMS0dBOE1l?=
 =?utf-8?B?VHNzMDJMY3REUjNpTE9BNFVxckpiOStJSlVpdDVDMmJsZzkyakk3amFTM3RL?=
 =?utf-8?B?WDFIcDk1R1FTYjFxYnpLWnBVRHVDeUdlbzcvZmp3Y0tITTZsYnJiUVFjbGtZ?=
 =?utf-8?B?UFRvQzN2dXdRZ2lZRUVXUFU3OFlEWGhRMVdnVE12V1V2NmpOdlZNdjVoVUNa?=
 =?utf-8?B?ZC9PRzhOTHNrTFVESkc3THpwOWJiV0E3TjlYWkJFMFh3NFcrckFzTEFWbmRt?=
 =?utf-8?B?S0tnS0lyQkpDYXhlUGZyRDVuZ3dBY1o3ZWtNUm1yaFZWRWowR0hDL2haUURh?=
 =?utf-8?B?eVV6SWJLQkVZNTZNcnFGSUdYbkJYK2VHSlV6Ny9hUWdIV2QvaEVCVm1PakFl?=
 =?utf-8?B?dTNWVnJMOEpHc3BSUER5SzAvMVlrbzVETFdUZnZ2RWloUkZOdVJBdk5TL3RJ?=
 =?utf-8?B?ei9NL3pIN016dHkyREJnZzVpWmFHNkxmamlZRHAvNXZPc0JScU5mdmk2Mzgw?=
 =?utf-8?B?ZTR6WXRrL3FtWmdLSzhsSzBsT1ZUTWJ3dkRPYktGVWtDY2FkNWRaMXllZFlq?=
 =?utf-8?B?aG9xWkZ5MFhOQ0hrVGpDL01NWEllZzlWNEc1SS8wbDRwdG9FL3hJVWpNdGNa?=
 =?utf-8?B?clN4bTQrNmlWZWhNTmRYanRtSHFRNHl5UGdDTlh3ZytYYlBQYnR2dUpWd2N2?=
 =?utf-8?B?NE4xQmFMUWlUenQvMnRYYVpIbE9ZbGl3UkFZOHpMOC9ib0J3NVBLT1ArM0pQ?=
 =?utf-8?B?eVcxNkZyMmZPSWV5NVJ0Yi9NbjkrU2F5V1kvWXM5cFlLdlczRW5pcHE3azYx?=
 =?utf-8?B?SzREbjBObUZmYWNRbTBtSEdSWlhYQk9uNS9KOUw4ZTVESmx1SXBYWDR5NDRK?=
 =?utf-8?B?VnVhVG9FNmUvSGpQRWltVGc1emVzSERjVjJrWHJkZndiQTg4THNTOVNzY25q?=
 =?utf-8?B?NDg3cHZJTGZmNTFVNEFLUnhTMk1sOVQ0bUhRd2hZU3dJUy9jVWdHZzdodU5k?=
 =?utf-8?Q?5Oh0I2iHR/RiNQt109UIxaa0q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5ba146-8296-42d9-68b3-08dc9ffa2950
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:33:16.4539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4SOGBGTlCUfX0y1Y5hCVY9o4blT8c+j+GE+jdUDkBaJLzSCM7TitxCVkrRAorSa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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



On 7/8/2024 7:01 PM, Danijel Slivka wrote:
> Why:
> If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver
> load or driver unload, subsequent amdgpu driver load will fail at
> smu_hw_init. The default of mmMP1_SMN_C2PMSG_90 register at a clean
> environment is 0x1 and if value differs from expected, amdgpu driver
> load will fail.
> 
> How to fix:
> Ignore the initial value in smu response register before the first smu
> message is sent,if smc in SMU_FW_INIT state, just proceed further to
> send the message. If register holds an unexpected value after smu message
> was sent set, smc_state to SMU_FW_HANG state and no further smu messages
> will be sent.
> 
> v2:
> Set SMU_FW_INIT state at the start of smu hw_init/resume.
> Check smc_fw_state before sending smu message if in hang state skip
> sending message.
> Set SMU_FW_HANG only in case unexpected value is detected
> 
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>

Patch looks good to me

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Copying Kenneth/Kevin as well.

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 34 ++++++++++++++++---
>  3 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d79bdb1e8cdf..fb8643d25d1b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1755,6 +1755,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	smu->smc_fw_state = SMU_FW_INIT;
> +
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>  		if (amdgpu_ip_version(adev, MP1_HWIP, 0) < IP_VERSION(11, 0, 0)) {
>  			if (smu->ppt_funcs->load_microcode) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a34c802f52be..b44a185d07e8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -495,6 +495,12 @@ struct stb_context {
>  	spinlock_t lock;
>  };
>  
> +enum smu_fw_status {
> +	SMU_FW_INIT = 0,
> +	SMU_FW_RUNTIME,
> +	SMU_FW_HANG,
> +};
> +
>  #define WORKLOAD_POLICY_MAX 7
>  
>  /*
> @@ -562,6 +568,7 @@ struct smu_context {
>  	uint32_t smc_fw_if_version;
>  	uint32_t smc_fw_version;
>  	uint32_t smc_fw_caps;
> +	uint8_t smc_fw_state;
>  
>  	bool uploading_custom_pp_table;
>  	bool dc_controlled_by_gpio;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 5592fd825aa3..d7c983a1f3f5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -315,11 +315,20 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>  	if (adev->no_hw_access)
>  		return 0;
>  
> -	reg = __smu_cmn_poll_stat(smu);
> -	res = __smu_cmn_reg2errno(smu, reg);
> -	if (reg == SMU_RESP_NONE ||
> -	    res == -EREMOTEIO)
> +	if (smu->smc_fw_state == SMU_FW_HANG) {
> +		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
>  		goto Out;
> +	}
> +
> +	if (smu->smc_fw_state == SMU_FW_INIT) {
> +		smu->smc_fw_state = SMU_FW_RUNTIME;
> +	} else {
> +		reg = __smu_cmn_poll_stat(smu);
> +		res = __smu_cmn_reg2errno(smu, reg);
> +		if (reg == SMU_RESP_NONE || res == -EREMOTEIO)
> +			goto Out;
> +	}
> +
>  	__smu_cmn_send_msg(smu, msg_index, param);
>  	res = 0;
>  Out:
> @@ -350,6 +359,9 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>  	reg = __smu_cmn_poll_stat(smu);
>  	res = __smu_cmn_reg2errno(smu, reg);
>  
> +	if (res == -EREMOTEIO)
> +		smu->smc_fw_state = SMU_FW_HANG;
> +
>  	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
>  	    res && (res != -ETIME)) {
>  		amdgpu_device_halt(smu->adev);
> @@ -418,6 +430,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>  			goto Out;
>  	}
>  
> +	if (smu->smc_fw_state == SMU_FW_HANG) {
> +		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
> +		goto Out;
> +	} else if (smu->smc_fw_state == SMU_FW_INIT) {
> +		/* Ignore initial smu response register value */
> +		poll = false;
> +		smu->smc_fw_state = SMU_FW_RUNTIME;
> +	}
> +
>  	if (poll) {
>  		reg = __smu_cmn_poll_stat(smu);
>  		res = __smu_cmn_reg2errno(smu, reg);
> @@ -429,8 +450,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>  	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>  	reg = __smu_cmn_poll_stat(smu);
>  	res = __smu_cmn_reg2errno(smu, reg);
> -	if (res != 0)
> +	if (res != 0) {
> +		if (res == -EREMOTEIO)
> +			smu->smc_fw_state = SMU_FW_HANG;
>  		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +	}
>  	if (read_arg) {
>  		smu_cmn_read_arg(smu, read_arg);
>  		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
