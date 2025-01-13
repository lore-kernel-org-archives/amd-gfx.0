Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5848C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 22:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2D010E438;
	Mon, 13 Jan 2025 22:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kIWJv5ZL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB2410E438
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 22:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wawIAbqgLRpiVBfZsN+z3iPNLJEGR1dJFGSlLQI78IsmD0/xr2n/asTDkGBTGp6GDPkz6E/s6G6eoZ5zMeBwRwvofo3bVP+X6dLhECrVZfuSx5EpUXdSYE+RvJoQ6nkKpE69mxMbM3hswdlK7bBvX10/Mc+g2Z5BCF3e0cZKvX5YsakiO2HDNbAb4lGRmJQROZa4Oxe1a7FyhYL7f/3C9B4lPKwktmzNNSFSSCtMSzG95WrSQTarrc696O+l/MmueztaEnlLae1YGDE2OQXyEJvmxI2Xo5Enx2y/rVDdEhc36GoksZRc1RfgzyH4o5ZE8AtCzsZf7NqVGHtC2ppKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+1Y507YR/iP8YkqA3IX42Gdrd8vh5n+TeZn4chRbuA=;
 b=BPqyPJYyDVSqXF9/Vdtb05xwwc3Fyf/awrgXc6IUBW/Y1atsvzBqS6nX2lEYAxpPXsle0Q1kONcpfZNVeMDw4ubA1SQh9Du1ODQh/kOK4bfBRrz9tO4m/HGBhFUcZ+mmlmdAqkVgGz/bF8ZG0BXVmUzXiLUjUigN4SLULf9ARNn+6f5o0bLS0XsCoqpy0fZRUX9HM+9hCeH93ndm6x/f4g6saMD3Fpxwyd9stsPNjktwlO6at6xCNPIsywPLoNUvxMnJZT67PoLE3ynD1Dp+rhsYMHKQP1/R54uHF1w5C0dJjGmS2O+HzvD8gT2v969kiZhBmUN0YZiaRPfliSN1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+1Y507YR/iP8YkqA3IX42Gdrd8vh5n+TeZn4chRbuA=;
 b=kIWJv5ZLG5HDaoN+X8F++9NFypP3dIoTqS/5AcL1E0lukUEPdPu7cs9M2nOVOAt1pHo71woEn/Eu+PTwpE5XF9hlcHwf9N7ZL2zrwqVQgHhRh5nDrpY3GW6USCqU8KDiA/SXQzFaX79xC4MvrVWJIFvya6m19QD6ny1zy+3ZnOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 22:28:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 22:28:54 +0000
Message-ID: <73b0b498-76fa-4419-9b2a-0fdc867acacb@amd.com>
Date: Mon, 13 Jan 2025 16:28:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 13/15] drm/amdgpu: walk IP blocks in reverse order when
 shutdown
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <2d37b65e4f19bcac7ed68819e1f67e9a398a8163.1736732063.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2d37b65e4f19bcac7ed68819e1f67e9a398a8163.1736732063.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe71992-498f-4383-7548-08dd3421a9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWZ4V1o4L2xUWWp2d1VsVGtyR3JTZjY3VkE5SGhJWDg4VGxsTGdlalRuZytZ?=
 =?utf-8?B?b3M3WkNqTG5IQndPU3N6TG9RNXZTM2g0YjczNTY2VEljRjB1UERTamJiQXlm?=
 =?utf-8?B?dnczOEt0Z2RRaks3YkM1NTRxRGlqMm5nNW5JQVBhSHRIMlN1Qi82bnh1cWZs?=
 =?utf-8?B?Mk1jZy9rMG1tTkJyUXhPM1gxdERKK1NTV0hqeDVOMExFTS9YWEhzMEs2Qmh6?=
 =?utf-8?B?SzRKV1I5YXQwVHAxT1M5Q3ZBUElzQjVaaHZxUVZBbDZ5STRzOGFBdkZ3ZVlI?=
 =?utf-8?B?TGZKR3JUb0ZGVWFhR25KU2JzTVh5dlI3WkhqK0RGMTJaZlBqaFM4T20wN0RZ?=
 =?utf-8?B?R0hLc3ZoYTI1S0kvMWR2K0puVlFQUmgzcXJPTlF2YXBoanVkZ2F0dWNZNXVF?=
 =?utf-8?B?bjUvYzlTWE1lYXo1Y2hNR1JDSHlQYkJlOTQrNE1Rdm9rc05oWEFsZ1RsZ0tL?=
 =?utf-8?B?bHF1QnZyWXAyOGRNYW0xc1hSUWJ5MUlsOUdLaVNHcmQyb0E2dkZWVXFPR0lW?=
 =?utf-8?B?ZkFaUnBvWk56ZFkxbnVoZlF4RzlPdi9aZ0puNjB4anRBS3I2U2N4SWZLOWIw?=
 =?utf-8?B?WWdwQnhlQmZWZHdtM0pwTkRiSjQ1MC9ldzlmMGxpdGJCQ0pyeFplQTJYWVFw?=
 =?utf-8?B?Q0tqTklkQTZsWUYzdGxidHluNms1UzB1UlNoSDJESWxCT2pmelZWSnhMNEZ0?=
 =?utf-8?B?NEEyaUhqL0JCbGppVVFoT0xudGZkU3ROWThzY2RCQjN5aUsvWllUb3JPYTRL?=
 =?utf-8?B?M1VLUmJFVDlub1NnaVFtbzRkUlg3OVphTWRYSHR1QlZCNTZ0VXlRNzFMQnZG?=
 =?utf-8?B?ZUhnWHN6WC9RbDhtbElTZHlRRmppVXJaUDlhWDJ3SURSVUNFN3VBOU52OTdS?=
 =?utf-8?B?MzFCOUxLMHExQ08wWEloa2RaZTZxUnV3bkJxUTV2dVlYem13NXBTMVQ3MzdH?=
 =?utf-8?B?RE5VNmpMZDdIYUNGZkMreEdWNU5rR0xBMXBRZjg0aDFsL1FWY1dURFJRUnVI?=
 =?utf-8?B?alpqMVBzeG9zNDFwckFiR3hGbitmR3dPbkRhTEhRemNPUkx2NmVZNTdhbVVh?=
 =?utf-8?B?MTc2dUxGSjhhYmpnb0MxZ3pJU2hMUjdsVlMvQ0FyaVE0MlArRm42cTRqUWND?=
 =?utf-8?B?d1FoWjMwdW1zWnllVVNtYmgwWVR6NU12OG1BV1ZjYWwzL1BCUGx0UVZPdHBT?=
 =?utf-8?B?TXpHdFFoQnFyaEVGU01UZzAyR3E2MDhSYmhqUUZDeU9TaWpKSXhTLzRlOFBz?=
 =?utf-8?B?TUlrTGZ5dzFjbk5lZUtKaHVOSFdVM3ZSVW1NQ0hmRVY0V3lleWZHVi9NY215?=
 =?utf-8?B?ekh4T3BrK3pFbEk1MDJlbWx1NXFrVnYzbW83YUxOcmt1UHN3Y0pnbzZjMW81?=
 =?utf-8?B?NXFmWTV0K0RXRHE0L1hFODJmOWFDMGtWMEk4eDhPRy9idmxpRWdKT1FqYXNa?=
 =?utf-8?B?cEpKWTRuVHhiUHVYWUZ1QXhkSWtCWUJEaGd5bUFSRzRSOXBINjlrYW43WmVN?=
 =?utf-8?B?b2NoTFBaMG1SK3c2bHZqMUxoTEdMM3VxQmpYNTVyN2E4ZlVmY0VLaEd2cWt4?=
 =?utf-8?B?emE2OGxhSjdyU1AwNHl4VmdqYjFyRGxrbzRGcXU2MkdZSDFCTldkcHpMdGV0?=
 =?utf-8?B?K050UDhmNXlsSEptUHhnMkRpcm1IQndtRlFENGpHRkF4L0ZZZitpU0JHdnhG?=
 =?utf-8?B?SVYrUGUyakJGTTE1SC96YUpKcE9Cb1lEdWdiVmJCMnRlcXFVS2pZSmM1OW5p?=
 =?utf-8?B?bUhlQWV5bVc3OFRtNWd5WktJVXJRZ3lQaFAzL1BrK1pySEtMbkZSb1A4MDlP?=
 =?utf-8?B?ZnFyeE5aOTNKdFlnZ2J4UnVJYkR5dVlnMlgwUFZhdFc5VkJrUWxFdGRCK0Ux?=
 =?utf-8?B?Tm05dHZ0V2JtVXI0NUhMN3lHbmFUNm9HeGk1MENDcHdqSmY3THAwNndYYUJk?=
 =?utf-8?Q?z/VDf8vIrmg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2N3OVgwNzZrOGtZTWJlRHFFSElNbEp5cFJURis4TWMyWlAzRzdjY1lrZXBJ?=
 =?utf-8?B?WXNveFNTL3pFYzdRS3U3Rmw3YVFlZ0dzODFGNGRpZFZWR2xnV0oyNFpTQ2Zo?=
 =?utf-8?B?WjlvZ2hXVFRpUlZZa2RQeHVNRWNFdzhiL3l0UFNvbUZreGRSemRNbFJJTWxT?=
 =?utf-8?B?SHZVcS83d1VmTTlmTUlBVnhnd0h0ZlRPemRxczJBTUZDT0UwVEZMYjQvakpj?=
 =?utf-8?B?ZkxoYXZ5Y0FiQUpZaEJEZVorNHE2Q3BpQzByUWgySU4xbFNabitqT2Q2YVAw?=
 =?utf-8?B?bHkyM2RCUVBkYkhqeUdiYjg1b0xmWGIxRXFFUktnWTBQWFFsS2pjclFwOTJ0?=
 =?utf-8?B?WC8wYzZPZms3bUVPTnNOelJZbExGUEkxb29WL09mNjFkbXFFM1lMTTNXQ3Bm?=
 =?utf-8?B?dU5mQ09obElCWk1LSVVOOEVhY1VWN3Y2ZTdwRkVtUHFBSk9laXBhSUV3MkJI?=
 =?utf-8?B?WEN5dWtVMTVTZTk5ekJDeHQ2MlEvZFdHcTdadkZMTTFZL1dHUWNvbFRrTkFt?=
 =?utf-8?B?Q3J2d3RYOTdITFRVOWlBbVFMM25LcVdHMGFMQ0RnSHZzc1NYU1plSFJoM3h6?=
 =?utf-8?B?cVgvWmR6TkhuQ0JOMm02cElCdFNoL0J4b21FM0ljcDdhc3hCZlR0TUpJRDEy?=
 =?utf-8?B?YjZzalJLWTdQUWQ4Z1MrbFAwRVIyR2lNZE15c1FDaUwrVCswWVdiVm5hdng0?=
 =?utf-8?B?WkoxMkc4bW02LzllWXVSSmxBaUJaSjE1YXJ3dlpMMVhqWGZJMUtpeHJNQjNT?=
 =?utf-8?B?Z1FBbWVya0NLTzd2d1dTUWtrODdnQmpxRmNMRjRRL1dKOVVYUk9zQ05Tc2tS?=
 =?utf-8?B?eUxDYXhCd2VSQk1waU9iRlZRa3pnWUNpUVVLSTErMHFnbzl6ZFJNMU1LMnVJ?=
 =?utf-8?B?cXhSRXMraUFJR09xcVpTc1lTMUQzbHNCZ1FMSUtudVROSmNJOHVMWklCRzRy?=
 =?utf-8?B?SytTeVJEUGswWHlZYzQvaGpHaVdEeEJYWkM2RDV2NnNEWXBqa2JTNjhqMlh4?=
 =?utf-8?B?VjBlZms0a1g3dUJvbVJnLzJsVkpDaFlGeW9FOTErc3hXRUMvMFhpSmxCekU4?=
 =?utf-8?B?UzZFT0lQZWRxeWw2QU95RE1IYmtFN2dmbm01VTVZYkhpcmwrNU5KS1R6Vy9L?=
 =?utf-8?B?Y2EzZjJoYnNmcnZtM3Z5bjg5SVg5WCszVGcraW9wMDh5V2EvYmNjVStsTVhs?=
 =?utf-8?B?MXFHN0ZYQXovUHYyNGp1bDR3d2t3dFIyUGIxa1hLWEE3VHVuMHBDTnJ1QUsx?=
 =?utf-8?B?QnlhaVhaVVE1ZENGeFBBWk84TlpSRVIxWjY0STdvK1puSm8zbVQvRytRaEUv?=
 =?utf-8?B?VHdKSWpaUXE0YjNSU25mWXAweWZkSXU2aUduZ205MG5XSEZMam1NcWFRV3k5?=
 =?utf-8?B?SXpLaEtuaWc5V1FIUUg2MVhvbzVEN29UUExSdzhEejYydlBRMFI1SGduS3Vs?=
 =?utf-8?B?ZS9FYUowQVBWS3hIOXAvZnEyRmdxa3F4RzBIVHN3aHVucVZSU1lUa2R6eFk3?=
 =?utf-8?B?VWJFa2ZVbE1Ib3M0Ui9IODd0MDB1a3hYbWo0cWV3YkJUMkJoajVERVk1dzdV?=
 =?utf-8?B?aGVRSnZZKys5TTUzMmltS3MrcHpuSk5taEZxNjN4ckpXWkl6OVN3VE5hYUhF?=
 =?utf-8?B?VForbTNFU1NxbE5ydnVQSE9udkl3KzNqcUl3RExnK1Baa3IzbkJTNVpYTkVm?=
 =?utf-8?B?c2J0RjB0K2Y5ZUNtVTN4eGdTUGlrYXNMTm5YSk5rRmdWdE9IODVIbmRub3BH?=
 =?utf-8?B?YW5QYWVVMVlMVVFjYTRaaThwUFFPZnlpYlB2Njh1R0lGVERzSmZOV24yMmxZ?=
 =?utf-8?B?QzZhTkxNRit6OEdjVXZJRHZWRzJWajB4dUR4YXJ6YzlOdWE1cWZvaGtmTnJm?=
 =?utf-8?B?T0dxQjdSTDZYc0xWZ0Jwby9pQldxbEdXZGhTL1FMcHNSczE4RVlxVW1YZ1pD?=
 =?utf-8?B?TFZUTm8xT09PVEZRbjE4TGo4VzRnY21RMEQ5dzF1UGZGaWNtZkdldkNyQ0tw?=
 =?utf-8?B?djhFdUpWNlVHcXRCTTlkUWcxRGY3b1FiNDBvcjlyUkJwSUgzUjJDQ3A4OFV3?=
 =?utf-8?B?QVBXZ29vLzRONHIwREtCQzhFOEpmZkFGTFdUWTZlRUhyUnF1MzFjbjJ1eWo1?=
 =?utf-8?Q?zVsL814MabQsdsCPG9yva6P7v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe71992-498f-4383-7548-08dd3421a9e8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 22:28:54.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDrnIHMPqJVvC9DsZWXZqTHHSvCMyLx6I+VEEaM5GHWKo8hBJ6vqt8bI4PzcWwYuOZ9lkyHBtXQG7x9K02BCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Walk IP blocks in reverse order in function amdgpu_device_ip_fini_early
> and amdgpu_device_smu_fini_early, to keep consistence with other finish
> functions.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index af356226fbca..a1501344f336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3358,7 +3358,7 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0))
>   		return;
>   
> -	amdgpu_for_each_ip_block(adev, ip_block) {
> +	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
>   		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_HW)
>   			continue;
>   		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
> @@ -3373,7 +3373,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	int r;
>   	struct amdgpu_ip_block *ip_block;
>   
> -	amdgpu_for_each_ip_block(adev, ip_block) {
> +	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
>   		if (!ip_block->version->funcs->early_fini)
>   			continue;
>   

