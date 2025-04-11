Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818D9C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299C810EC0C;
	Fri, 11 Apr 2025 16:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bFE5r3Ai";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA5110EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFKPpWKzEtKYgNBMLxMs5XOvzWDnHS1YMnGCFY/c5hV5m4ruUTBzxJ2o5M3bf7qTjfGwQZK65lqPAVnCYFgrC6m0fBiy6L5vnc+J//BKQkrhDK6X1ta3vzIA1Y8X3vOA4cNo/SMPc9mEzRCo4izPCmPnVR0ALMIy2DKXMvS5v7QEO42gjR+zsucpj+g/88gKsfgPC5o/WwNyZvJOKdoNNNqO816kA2E+o534+SUsYNKHSfQABbFPYbKGCo9HQfJncSjSJngvSngYVejrTSoppYUmdhyzVFtKzd0+ewjFNRwLGeuL3JrmX+rcv+6lQ+3cFPFyRT0mMCp0MzFJdGYvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoTFEXevMKUCDbWrm+UFp8F5yBzFFUS9HbSWkh4T/kk=;
 b=FKISnLI5oTo+R0R1kms5awuY9zdU3VC78jDBT0binlDemaU8xZAfKGy84Sx9w9Kb6lFQtLIgKJt1pj7bXPTfWt8WA6zdwR39wpEC6HnuV59HOPKn5JSSUI80PbbF4XD3HoXIpy/C8Ahhq5+64nJFrKJIs2meeY0ew5135f2UgbUdOEwNjzJo1KVt4pAWFZxmfIvhoXpOGcP+rFMQ7l8MobtevKNUgxGrmgRCUbT+hEaVFtabA1mmFepucLYThwnnZQ/RHsep2xUTfVOggoxkaa7v0cXxY1bzHML+LEUlPTSNzXXmZSTyaY8BFHWZ00WYoxiru1omhs7dMV/dIvI/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoTFEXevMKUCDbWrm+UFp8F5yBzFFUS9HbSWkh4T/kk=;
 b=bFE5r3Ai3MvF4nQIjEsw3Jl0BMlrpyrBZ7gue83A0j2JcOHo0609wSLgOkVW1pIVdO8v40q8pATkdbgi3bJPrpfq0rQsWilV7Iz6Ikg+o3jSiV82yqhdjIxYQKVGImJ+NVat+G1oI+auh4a4aE9PCgtA33DsDIfpzVeAmvybMb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 16:07:28 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:07:28 +0000
Message-ID: <cd6c3637-4768-4420-aaf0-6a9f21ee3624@amd.com>
Date: Fri, 11 Apr 2025 21:37:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu: don't swallow errors in
 amdgpu_userqueue_resume_all()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-7-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411141228.2722962-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0055.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: a5109424-811e-48dd-16bf-08dd7912f4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnpXMjNvUk5Ta0VNa0ZIbUtpeEZlcHgxZFpqSlRuek1EWGszN2xiSlFJVWto?=
 =?utf-8?B?clVBcmR2NXhtMFpoV3B5enBkbDBQOEtMSWcxSDRMRmdTT1BtVGNlb0hhVDh3?=
 =?utf-8?B?enNmTStTN3IrSkU5SksxTFZHT3g0d05tVDdxSjk3c0tHL3YyOXp1UXlUdDh1?=
 =?utf-8?B?V3p5M2xTa0c3YWdEeDBNS2RXUmhsM2R5eC9KL2Y2Ulc1ME0vU3BoQ0RacGJZ?=
 =?utf-8?B?N2Q1Q3g1Vnl1dUpRcFZFOUZlcUtaMXBLSUsxeStGTW9UUXlRY1pnWUdWQTgx?=
 =?utf-8?B?YlRaemgvOVc2Tkg0VDFySDE3MWRSZHdXS3VTZlNySWo2NXJ6aEczSlRGYXdN?=
 =?utf-8?B?VUJoQ0tESCttME4zTEJuYzh5dE1tcVo0cmpDaitpYldBRDdrT2cxUTNUZDFV?=
 =?utf-8?B?Z09qc3JwWW5HU2EzSzUxSHBoQjY0aEMzK0I5Z0RvQURrUzBjSHVFU3pyYzhp?=
 =?utf-8?B?U0hsNldMb3VsN0UvTEFxemJ6bEZZMy9ZRGRrTnE5SXFGZ2JUUFR1Um5EOVYw?=
 =?utf-8?B?aDlVcWlKM0NTRUN6cWs1QlovblRnR3grdnVDNHJFQ1h6aTd2TkMxeDlrRkNv?=
 =?utf-8?B?NThBblRKZEpwOHhFYlJ3Mlp1WXJUYVhPR3FqNUxQNUFXVFZlc1JhYXhNM0gw?=
 =?utf-8?B?NE54cG5Ma2N6eEZkTjZhZTBXS2NXZ2lUU2dLWE1Jbk1WWDMvRjUweFpKZUVm?=
 =?utf-8?B?QVhRd2QvcEJDd081Vmw0ZFJ6Z0cxbDdEdHk3b2hCUDBzeUtTaEsrbjdObjNF?=
 =?utf-8?B?emNXRVdWWG5zWmxFdjJjTTByNnBseVBHMkEvS2lxYThLRXhVeVArL1J3alVp?=
 =?utf-8?B?bHJZKzNPK1lWNXFUTi9UTkRSWWk1aVBURHdNK2gzdGZyeFo0ZnNPWW1jbUp2?=
 =?utf-8?B?UFE3Z2tXMVU0L2FGUEY1N0dpS2FvdzNuM1pHWk1DUmhZR3RjdDFZT0lhUTNw?=
 =?utf-8?B?NjNRL3AxcXE1SnVOdWVjdStOQjFCdHZmZENRVUpxT0psZGxwakZJNXpmNnpU?=
 =?utf-8?B?aHNvbFdyNnVTL1N2Sk5RdjlxYzRvcVNEMGJvdW43N0Z0dHRIQ2VUZ1NralMx?=
 =?utf-8?B?YmJzc2N1L2VpQk1LYTlQeFdxUXRXd012NVZHaUd0L0xvamVEaHI5dmdMTCtw?=
 =?utf-8?B?T2M3LzBQeGE4OFFwS3Exa1Uxc3dPRzRWclQzWkdFaXdVampFZlJ3eHhwMlE5?=
 =?utf-8?B?YUtWTDNqakc0eGFaWU1td3VPZkJ5OVZNTVE1KzhwUEo5eUdOSE51STJ5ZUFO?=
 =?utf-8?B?Q2IvMkFmaGFtZWhDUWFPL1ZjZzlrTDUwYnZnZXFHaCtnVVpEU21TR3BEWnla?=
 =?utf-8?B?YmM4RlBkNWd6S0NJVnRnQllzT1U1aXN5N3ZsSHUyaVRtMjJ6b2tRNmJXV0Ew?=
 =?utf-8?B?QnUwK3RLOE83b2NORm1GTDJJeGh2VVN3YkZVYkV5ZHBwTUE2d0xHSWlWZWtK?=
 =?utf-8?B?S0dCeERJUmoxUC9RaUlBR1o1Skx6SnpBdWF1Wm5rdk1mUEQvVWlGdUI5MG9X?=
 =?utf-8?B?ZmdVSDZZdEZLVFpqeEs0eXFKcHZKYitTRm4rNnl1RncwY3N5TlVKY3BKb2p6?=
 =?utf-8?B?YUd3YjJ5bmtNS0l6aVNMRGFDVER5Sm5FTjhoWkdFeUl4aWhNVmJURWh6NTY2?=
 =?utf-8?B?OHp5VTJiOUEydGQrUUxhK204eEJyN2FWVFM3OTZtdVJ0SGdJSlpCdFdGN0xS?=
 =?utf-8?B?MGsxdHJmTnNFcTFrNWQ0Ry9EUlRxaUM2clRVOStwNk15S0h2bkdrVElNcjVx?=
 =?utf-8?B?ODFYZGhld3BGakE3UHRSRy9YNzk5QXRrYW8wb3FScVJ5Zmp1c05laEZyUm9Z?=
 =?utf-8?B?cWs5czk4M0ZjV0JyUlEzeTVQZGxYblIwcVdLdkdHVEk1N0NNZEtpMDBBNWdo?=
 =?utf-8?B?MzE3VkZYYnlwemFsMFpJRzN2VVRpNmg1UmZEWDFmUWl1dDdzdXB2L0hxcDBs?=
 =?utf-8?Q?eQqGRDkX9Hc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1jb2w2QWRjcGY1aURHbEhGVVY0M3JYci83MEdjMEQ3QjU3L2VTN05YbkR6?=
 =?utf-8?B?SjNjenFmNjdmNkNlazNiVThnWWo2VUZFYVdPVHNyK2p0cEpwZjdjMjF2QmEz?=
 =?utf-8?B?YkFmbTRGdEZNbkd1aUpBb2hUSkxUZzhmMkZYNThmQzdSbnQ2VlZPQkwxMFI0?=
 =?utf-8?B?Ujg1bUExdlJhWXE4NncwR1dZeUNBQkhvWmI0a0JhclNkVVd2d1lyNGJUdkRE?=
 =?utf-8?B?N1VwVFY5SWdMMFZhMmd2RTJJUnQreDRjcjNVWFpGZnFXb1Rtc3Y4NXNnY045?=
 =?utf-8?B?NlptNllkblRRd2p1VS90SU9Zd2svVUZGaVdsb2VQblhCcXNXNWJ5c3FHSVNE?=
 =?utf-8?B?M20yUisxVnFBTmVCall3T0J5QVltTGwrOC9ybnJ5d0NVVXpEWnoveVcwT3VD?=
 =?utf-8?B?VUFmWStvMFNpdzJEL0M3UHV4Z0F4bnlKQWkzc3VNOWNQRnE4d3BxTXFaRksz?=
 =?utf-8?B?U1BaVTFiZVRBN3JXaXF5WXdvb2hUUmtTMlNBRFE3eTF6V2VvZ0pGS0t5SWR6?=
 =?utf-8?B?QXljaGI1d09wK3kzTHFIV0tGUVlNUWVEWlJCNjdWS3hmMEN1Q2VhR0dGNFhy?=
 =?utf-8?B?QW12MEZrR2JKM1cxUlpYSmNMOUNCQjVKbTNaZjQrNE50b1JrOElkQUh1Wkhk?=
 =?utf-8?B?R0dpNGJlUmlRRmtkYWRpWExRRnRQTjcxL21WNWhLdmJQSThST2ZCV2VEaFF3?=
 =?utf-8?B?Tk1uclViQ0dvU1VnQmtFMUUzZGxISGUwNzFiNHdnSU9uUzBDVU5idlBtSFhk?=
 =?utf-8?B?dzBBaGVHN3B2ZjBnVkQzOWQ3enZEOStrR3B3Q3NuRmJHaHZ6ak1kcTVSOWVs?=
 =?utf-8?B?RkxGV3dySFFoVTlDRlpiem84NzJ4Q2VUa3piODVaOXhwN2NDWHBoSTBqVFdk?=
 =?utf-8?B?YWtIWHlxbWNKV0dXNVFGa1QwR2VlYjVyc1dCTjNEVmJsWCtiK0VMWnhnVGoy?=
 =?utf-8?B?UjZ6MDVUTTk1Z3JRZmdvSWVPWkgvUHMyZWttWmhoQ1duOEhnS3VDV09ZUUlV?=
 =?utf-8?B?ckZkU2NuZXIvdWk4NldMOFFrM0xuM1k4T1B5TTg0OVBqY0ROdENVaVpscU5N?=
 =?utf-8?B?VXRqbzIyL1drOERzNjloNzdUQjZ4QkJJdnlBa0VSbmxrcXpobzU3Qk5LTk9D?=
 =?utf-8?B?bGhUN2VWam1GZjdvZC9WZjZsTjV4UTZrWGJFcW10Y0hJK3lORU1QMGFKdFAx?=
 =?utf-8?B?ci9DM3NEUG1VeCtBTEFFdzRFcW5nTE1XeFZubkN1TlFFMEFXQndLUWh0QlBQ?=
 =?utf-8?B?NFZreTdyVjV5dllWQWt5K2tidi80Uktrd0VtOTJZbzJHMk02M2FWUHZQTlRr?=
 =?utf-8?B?NDE3Uk5TTFJjSjJ4em5kRjFpTUloeU1NMU9RL2Y4YzdEVVZIcjBEdVd6UXVT?=
 =?utf-8?B?MU4vM2crbU5MQkl1ak05aDVrejlzNXNJVkFrWFNkZERoNUJOK2tYZDZWY0Fm?=
 =?utf-8?B?b2p4UXVsZittU1VGWExFdGJJMVRwZEZBN1FNK1JlZlFVRzNmcWpFVFdlM2Uw?=
 =?utf-8?B?SGcyWkR3YkJJa3VxY1ZITEdXQ3J0ZjE3M29vS3dTTG1HaXNyZWV3enF6d3B2?=
 =?utf-8?B?WVkxTmlrUndzSkpNSnN6Qm9oaDZzbkk3a2VLaTdmMVJXK2JpN21VMDdGSlMr?=
 =?utf-8?B?OS9IVGJDWGVSczN1WFhoSzRFQ3h4cTBYWGVqSHJFdmFjRFYvdEZsUnMvVXBD?=
 =?utf-8?B?VFBwdFB4Z2NkeDQ5ZlJyZTVwYi9MOGJXWFloamhwNEpvRHVTOEVhQ2VxTjZP?=
 =?utf-8?B?MnFZNklaVitWSzM5cHEwZE9aK212K0pYTWQxVHlxWHdEc3hiTmlYTjhmUnNN?=
 =?utf-8?B?VFdsWjg2bytPWS91RnpmVm0xZ2MvMjFYK2krb0VEVkxMKzZpVUhWVG9XbG9l?=
 =?utf-8?B?dlg5TWdPUnBDV1ZtRnFTOGhkT3V2UnhKSS9yekdlZ1lUeVVqdUdjNzdSNkc3?=
 =?utf-8?B?WjN2eUVHbEtRUzlvMmI4bEh1Ym5SalROVWtrUzZBTFQ2eWh4ZFpvVEtIdit0?=
 =?utf-8?B?ZWJBKyszcEgwakVGVFdHQTNobUpwQjZXWS9VYXRLalJuaytZNmx4dmc0bEZI?=
 =?utf-8?B?aGNhZ0lWQklDcnBtdU5HdGdVSUhUa0l6SkRaUWFUODFpbHpZd0x4dEZjNGhR?=
 =?utf-8?Q?dJtm7Mvsjw37OegyViqXvMVyB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5109424-811e-48dd-16bf-08dd7912f4ef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:07:28.4995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4cM76DDNHV9hoZxp+jVyu2egi2ZqzApOp8Bi5zvTTueal5dwN4XP1WQfgoh/T/xDiX9owULhbUQRYKnceovPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 7:42 PM, Alex Deucher wrote:
> since we loop through the queues |= the errors.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index f5c2489baae43..aa7222137c31d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -423,7 +423,7 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
>   	/* Resume all the queues for this process */
>   	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>   		userq_funcs = adev->userq_funcs[queue->queue_type];
> -		ret = userq_funcs->map(uq_mgr, queue);
> +		ret |= userq_funcs->map(uq_mgr, queue);
>   	}
>   
>   	if (ret)
