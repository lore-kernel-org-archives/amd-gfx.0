Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E00CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 05:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4103610E171;
	Wed, 31 Jul 2024 05:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bq2pT4I+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBE810E171
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 05:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT5I4IEZD5oSswcZNLX2u/1fmj9/j7RNq7s2dNYD9ed4eETybM66RFGZYPRm9RrpsuO8L+5axPl93fbIeMUZACLEt+nM0N+vBBsQhp3mNZzQKXhuN763F3CzrzaBMQ3ESm85zoFd3z9wEt9xMMq3wPXj46gYJUzQJ9mSgJgARSfJclqLVnL6AwmadZtb5pXWvv6kxE/MVWNw0ICOQANUFVXT713Q5YPoK5PnDAvjjL8gthodKI+p3xEEuwcNE8zwGfQIjVXuIlztuHZuSDTLEqKeSPfAWzH4rQdX6PM3N215PVFzv5gFw5nXtM+wgUPpQzXcjCJ4SxswL0ubAMukww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8xqJYBD91jMPUOutk08HKMZ341MPmlAzLvG18XWd90=;
 b=P+xIgKQCiEwVhL05f+u1obpeCL8bkRQjHbO4fDubyhqJU/JKS0Q3BO8Sdx6KHjAy9I1DWGuXSHkPe+uCt+4s4l3diDRgtE/izMR3pxymikFYIlrWvVexI0SJqhxgksq20DdY0I96O2IB5wRetEkMyUdld7q/ZFJ1Sv1d2c7B1pWTy8ZV1/6KeoQ/puWcZ8lk1+AgreYznxAA96FEryY+NrDswXBtJIj808Q2OXUgqMza6oxHhrufdVBANmeN8SQxm1B/Gl74WavppvgAYApy0lDdeNgHkhop1g++Y5G7VqF3kj0RjaAvg01AF7A6Oj1x7uaL5eibmUy2av8sywGTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8xqJYBD91jMPUOutk08HKMZ341MPmlAzLvG18XWd90=;
 b=Bq2pT4I+gflsMebiz89zusjeGWBE3DejATM8eUfZUBFxZVSL82u/ps85GF0D4oP2cANw8Fd5UJbtY4Kk56tqhLbcE/tI61v4Afcz1laTxK/4HmOtQCTrKCcxOJlR7pwJJZwkS7gGQp4wEPbTFhmhixTlVcLimlsT+I7MCk87DYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 05:27:57 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 05:27:57 +0000
Message-ID: <7eb9ab9e-104f-4dc7-a1ec-63dfa2cadaba@amd.com>
Date: Wed, 31 Jul 2024 13:27:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Align 'dpp401_dscl_program_isharp' with
 actual function parameters
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240730041137.200169-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240730041137.200169-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 792e50d1-5977-4b28-33e4-08dcb1218929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1hZQjFsMXNVd0lRSkR2M0tkdkFwR2RFdjk2dHNvTXZpZ0t4cGd6MitVUmFl?=
 =?utf-8?B?RDFTUm5HeHJJZUZ3cnlobXprR1J1SGt1VVdkY0M5LzloT2xjQUtiU1B2Y3ZN?=
 =?utf-8?B?S0ptT0ZLaGdWNjFPczlxRzZhZDZPRUVlLy9Hdm9SUTFPVHZGdGRiajFsaTFX?=
 =?utf-8?B?cHd6aVFDN1ZWWEdEMDJUc3R5RW5qZzM3dnJTcFFxeHlYS0JtOEloNHBXeHdx?=
 =?utf-8?B?VGpUWnVOaytHM01RL1RCSXNOSFVsUW5CK2JqMGhxR0w5V2lIWk5HM2xUT09Q?=
 =?utf-8?B?aXBvd0V6SlF2a0FSWis0SFpmcldla3h1L1UzekZhWHlQVFBXZDJUL2ZOd1hy?=
 =?utf-8?B?RWN1ampESjVjWWMvVWJTcXNwT2NWdE0rWUpaUHBGMjZzYVN4NEhDTmo5Skdi?=
 =?utf-8?B?VEE2RUREUmZ3MFBIbzUvTjlXaVh0d0QwWWdsdTlKaGhuaGJ4RjRoVzhOWDdY?=
 =?utf-8?B?RlNzMnNrS0h3VTlyeHNBOWVkVGtkb3pTZzVpTUJNMFBHY3lQL3JZeUlZZmFJ?=
 =?utf-8?B?Ny95SDhDQ0dHek1Hdk9iSVp5bE5DeXBKSFlIUzFabUFZMGRud1IrUzFyZU1R?=
 =?utf-8?B?U3VuUzBwMnpIdm9SMmVHL1hmeHYzM3htc2tCVmdTNEN0SysybDhrZEZPYmNy?=
 =?utf-8?B?eG5uQzM4RVZDeXJuZUZJSTBReUhRZFNMYmYwS1V0aS8zVnlFOVhKbmJGSXdv?=
 =?utf-8?B?cVo5RkVLTWk4ZjBpVzNlMndMS3ppM04raldLOEF3ZnNrRWVYeVBBcEp4NjhF?=
 =?utf-8?B?YWhqZUlPZGU4aEZTc0RHaTZ3RndDU0hkM08rQk1mUnRCZUtJVVNmd1kwQUlV?=
 =?utf-8?B?US9YWHJIaGNFYlEvUC9QUnpSTmFabzE3aVhKOXdsaGlyMUFlQ2hJcnhGT25x?=
 =?utf-8?B?cHgzaGtSajlrWHY5SGFEQ3pCaHNXQXFPVmJMdXJDeExFT1lxMGp5bUhqUGtK?=
 =?utf-8?B?aHNjcVNBa1BOL2xtUVd6SW9aZXJoK0l4c3dwTjFrKzk4akszeGtsKzdjVkpx?=
 =?utf-8?B?cTdtbkRaMUdaVjNUMmVIclpDUFU2eFcwdnlIT2lTWlZnbVl4YmJ1RzBvYUYr?=
 =?utf-8?B?eTgyejEvWlBRMUZkeW5aUmR1VXpWbk9TWHVtWlZyWmdabG5xMzJ6MlB2YW53?=
 =?utf-8?B?SjRQaTB2Q3d1c2dreXVEeVlRNHJtZ1lWaFNZN3RwR2g5czhRTTVFSWZHU0NE?=
 =?utf-8?B?dk16RGR6dUtaOHVaTHNvUWdPMjl4N3A1YnB6SUxiVTNkTXhWV2ErZnU3MDBw?=
 =?utf-8?B?LzE0YXpiTk1vUDlUZkdXblYxQ1grR0xSbjM5bTJMT0REVEtlQzMwSFFpVmo3?=
 =?utf-8?B?RkVsWWdBa016K0ppdUlmUUJ0L2NiUzBmWFJsU0ExbFVnMDlxNytvWWxXcnZX?=
 =?utf-8?B?SjB5U0hzVEhOejhUYUVhbXZOckJUK3JncHNIRnoySEdESlVvSjZuWGdsUi85?=
 =?utf-8?B?bmJEUzB3S3RxZzBGMnI2QU8wVW9QOTUvYlo2R28vMjhYN0dhS0gzTGhiMU8y?=
 =?utf-8?B?MEwxUW9OSnBEbXNXZ1lqOTNjbzVIbDR4YkpCYXA5SHlXTWVYa3BYOXIraWhW?=
 =?utf-8?B?TW0vWUl0MklrSTlLNFVFTURRWTdQMm12T0VmdVlWNlUyaUJ0ZElSZHViMHNN?=
 =?utf-8?B?QWd6ZVFyUEpQelRuZThKSDJtZFFXRk5IV25IbmVqc2xjbUgwVWphVGhMRUd5?=
 =?utf-8?B?T2wrTVRZblc3bDFEM2IvOFdDdGtxbWRUem1NWGFSVzlPZzAzRFZHR3dBUWVO?=
 =?utf-8?B?RmxWNDRvaDh4Yk1pWlF5SUE0OTZNekMyL0Z0OWE2M3VtZU92dTM5YWhnUnVV?=
 =?utf-8?B?dmluU28yN3VHc2FnK3lMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjlzaTNyRGJLQmwxa1ZVTXZickxHUUUyM0VINXpocCs3bEE3VU04Mk9zak5Q?=
 =?utf-8?B?SDR3OUJmdCtsL3VDcVB4WGhIZngycTlNdjVuS2UzSkFuTlNnMFE2ZXg5Y3Qy?=
 =?utf-8?B?RjhqTnI3MHhuZ2ZvYlI3MnUvOHd6bTgxU3NPZy80czNDZEpmdmlUSVdRVTZF?=
 =?utf-8?B?Q3l1TW5rVDdUTlkrMjNSd0lkdTExMVJqUU1xOXovNFlyck5KOUtGT2lHeWxZ?=
 =?utf-8?B?L1R0dllqRGtITUlnaWJUendQMHBZdU9tN01vWDk2VVhyQ1ZMaCtuUWVIaHhJ?=
 =?utf-8?B?NWZoY2FteG83b3BnTXRXcllxbGQrRytETjZxZHRMSUxBZjhLdlhuYlBGQWNT?=
 =?utf-8?B?blhDdTBlRDJIL0JvUUgyTlhQQy9SK1R1LzA3V0syb1FUSUd4S1RxT1gzZUw2?=
 =?utf-8?B?SVpaVzB0aERyYkZxc3hTUWplQmJsK1lwaW1LOW5OL2hiMEIxYzA0S0hKMk9H?=
 =?utf-8?B?NTZBU1VMcEJTNG5jQ3hzTk81cGY3Ky8rcW5hTzJkTDlIdW1mRzdsYW5KWG5H?=
 =?utf-8?B?VzBDS2tGMjJSVmlvUTA0UHQzSjJoUXNNTUtqcDBCck94enkwem1yTlZPTUdw?=
 =?utf-8?B?US9LU1NvMGxMZHdzSENzTmMvQ0lJUjl2MG96b3hubzJVd3ArVmZ0OG0xZXdI?=
 =?utf-8?B?am0wVHFRZHdXSWpIZmJaaXRmdDVEUEl6RG5wQmVjUHh1bUVrYXIzclhHWk92?=
 =?utf-8?B?bWlNeG5qU3FRMmRoVUhtTkFMSnBXVEJjZzlOQnpjTEM1VkRqd0ZYK0MwSVVM?=
 =?utf-8?B?VWdJTkpoSHpNTXcvaktReWFpWHFKR05vTHZiMXRvcUtzbUdiTXZqVFVhbjVX?=
 =?utf-8?B?d1oyMWdoOStNdFNmWTdPa0o5ZkdUS1JRL3ZhbkF6TjBOTTltdGYvWENYMHRK?=
 =?utf-8?B?MnBtcHJhWDVoZExtdlRLTEtlU2xjaEJrNlpLQkZ6SHpEbVkxMWpCR0RmYWFm?=
 =?utf-8?B?YTgvaHV1S1NSY29mKzdSa0Y1Q0dyR2lhTG9DSWM4b3k2ZUlqMTJpQmNjQ0c1?=
 =?utf-8?B?dTF2K1V0S2dWWU5GRm1YakxwTVBDcERickxxMGk0WlNWMlBJeDBnSzNTcnhw?=
 =?utf-8?B?cFhEYm5PbFdlNGQwSXhuWC8vOWpaSmNhamtPL1FIT2ppQ0llWU1ML0J0dW1t?=
 =?utf-8?B?Nlo5SGNlSlYyd1h6aWdXaXViWXBYTjJzSk1LMHJNM2RXKzcwWEZwTGtCNEI0?=
 =?utf-8?B?RHpGdjFTUnU3TEJzbjkzSVpSTE5QWFB6T0lOMHEyRmJWRW1YTUVmWVlacTFq?=
 =?utf-8?B?Z2lPWW5zaWdydXBFUzZvWWk0a21oNVR1V1FnOXgzYjIzbUtZTC8wdTBuVHpN?=
 =?utf-8?B?eVoyUGVRbVpZQTArQVZaZ2diM1UxRUJHcXVXdFUycmlrVzhuQkQzV1R3SS8r?=
 =?utf-8?B?ZmRjMld1OGtXeTBudXB4L0FIZVc5eWs4TUh3SmlaWU1NaWtlb0NWaG5KZGVJ?=
 =?utf-8?B?SWpBT21FT2wxKzlidEdGMEo5TWtkaXZtQ3pjMWZiTHl1UUJRd2JTOU5FdnVC?=
 =?utf-8?B?eWxJQ0tZMHNvMDU5Yk1uN0x6S2pzMFJpZEdLZDJMSmFHY0JtWDI5UExsZ1ZP?=
 =?utf-8?B?RXpiZkRhd0kvU0x1NUNZL0FzUVYzZytKWXRKancxNlhWT3BETTlYTDFMYUhC?=
 =?utf-8?B?ZmJPY2h3VUYwUU9kbk9DNEJJUnY2NFNWYVdFN3p6bVdYTUpnUmVDM1VnQXA4?=
 =?utf-8?B?dGJjLzFJbFZGWnVRV25CUyt4T1RRYzJPUHFOOXpnQVpRTng5Y3ZRYnlSeWRN?=
 =?utf-8?B?cE1HY1hZbWJadndSRWg1NGx2SENacXQ5bTFWY3dyNGJlWUpYRE44RTc2UTBP?=
 =?utf-8?B?UVdnQzJYYThFWWNMZFdwaHMwaVh4QW1tYUhWL09FSEw0b1VJZ3kzSWI4Wmh5?=
 =?utf-8?B?RHpzS3F6aFBrQnhxR0thOUw1WFJ0TzljTlZjL1l5RDdIYXlFMGRBZ2xJUkp1?=
 =?utf-8?B?ZUV4eTcwNnFqMEtxQXlFRTVzaWtVYnFnUnZLVjhNbmFjYXZyNzZ2NXF0aVBn?=
 =?utf-8?B?K1RNbzl2T1lta0xIZUNJWWxCZExHbmpNNFFSSDI4UXdhcDFidFMrVi9tcmp1?=
 =?utf-8?B?ZHQwNDhhbmlaamtaZy96Ukw5N0ZmSExvMkpLTWZXek81aWd0N2FNRVpQUm5V?=
 =?utf-8?Q?KECoCNDfl7I3158oTyh+b+7zu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792e50d1-5977-4b28-33e4-08dcb1218929
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 05:27:57.4978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC6prcbgIdkjzGTVaOho8ng68+p56Y/Q/o/myouUIGIHqtth1lvMLI09rf2e6frR/EDaw0DzDyGUouaB39gKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/30/2024 12:11 PM, Srinivasan Shanmugam wrote:
> This commit corrects the function comment for
> 'dpp401_dscl_program_isharp' in 'dcn401_dpp_dscl.c'. The comment
> previously included a description for a  non-existent parameter
> 'bs_coeffs_updated'. This parameter description has been removed to
> reflect the function's actual parameters.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:981: warning: Excess function parameter 'bs_coeffs_updated' description in 'dpp401_dscl_program_isharp'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> index 88d24e36fe00..505929800426 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> @@ -971,7 +971,6 @@ static void dpp401_dscl_set_isharp_filter(
>    *
>    * @dpp_base: High level DPP struct
>    * @scl_data: scalaer_data info
> - * @bs_coeffs_updated: coeffs update flag
>    *
>    * This is the primary function to program isharp
>    *
