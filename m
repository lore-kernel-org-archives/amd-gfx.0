Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D9ACCD192
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 14:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3C110E229;
	Tue, 14 Oct 2025 14:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0m9JXmNf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7627710E630
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 14:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrDcc7Do+vS0oRzVRZhoiKLa/6jEWljtn1ohyv3FxuzxpdgKDe8jacmsNyQDSKgJia2D93tVXouSQWuCxeat99isqagbUkuHJH7lHOhAjTNJR1bLAKPw0E1GUs7hHUm2kckA3OfQUAOvfe8zQQhk8RGBywlxvtFVgqZe57FYYTLX8YwHByBUf+2f6CQ86KKFLFZil0pHu9gpGJtG6AbDCqrfD7ogvSYiwM2mIDzc/V0dqZBVWsIHDsMYFfkPi+oIp+V9DbeE7bdyRey+8Od0rHxmuylHcXGE6ZCf2XV8Hg6XXfvsvnbFNDeCllPCaI8SvF6xtOmrx+55jRCJoIsRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2d9vfzOvVxDDGiH5Zh1tdikYvFgN88aSP7uNEbzrgM=;
 b=estrGf87Eccfdw+dun5uvIxnUBjdsoLMDpRPDLePHsHAqZG9NLKXgfECKAYjgXwjI4bXr5Q3xRsRNQrhfdMlwi+t1y/hnnw5T0GnLYIuUvrgQaiLpsNsGk3iriU2ii4dSESvdQkdk7ar4GDVTrBDUmdg6XJAs0jLRGPRTr9gHjewituaT7zqk0ddYngA8QlP6NrL3GafiIbJ2iQznNeY3CSEtJBNbhzceY6amQHS5yIvLsZDyq73Wr797pt1jIKXtNCsnp6+hL0kUrSWPdCuojLVUPFOmXOWpitu+aPy9i3O8nU9Meo4/CvvoZwperADHaM6fQuM5JW1dOqg4oP/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2d9vfzOvVxDDGiH5Zh1tdikYvFgN88aSP7uNEbzrgM=;
 b=0m9JXmNfVhUDd5XxV2CFZ1995Uu+BXrlKJEom7mG1d7SATadT+/ulHuegHY20x2lzJ81jfQQADckPa499ErxbNzykaeliBMvjdWdS1PeD1d9dyNjqvdUMkQz9UkMI2ViKNuH40Xb6WP5d+cWRjg8IMDL8hequT/FDSXR6AgaTJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 14:25:19 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:25:19 +0000
Message-ID: <ac39add0-f211-4323-8cff-3ee017f6264b@amd.com>
Date: Tue, 14 Oct 2025 19:55:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amd/pm: Avoid writing nulls into
 `pp_od_clk_voltage`
To: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20251013163042.531225-1-ilya.zlobintsev@gmail.com>
 <20251013163042.531225-2-ilya.zlobintsev@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251013163042.531225-2-ilya.zlobintsev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb3fd13-cac7-487e-86b8-08de0b2d8060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFNLWUovbndkY202MTBBMlllNmljdk1RNGFoM2YxbHlLc2dkSlMzazY3Umd0?=
 =?utf-8?B?RFYzUk1CZWxmN2l4VkZ6cnNWQi9iN1Zuc3VXU2FRSkZrQUszbUJsTzJ2eXJW?=
 =?utf-8?B?RG0rT3NOOFgzdkhjc2VRMStyOWVlSStjSEpKcC8yRmdJcWNEZWI2OEVBdFhX?=
 =?utf-8?B?QWthZy9LOGdYMEFIYm02ei8zYkF6cVEvYXVrU1ZFKzlIRGNUbzlpaS9wNkM3?=
 =?utf-8?B?YWE4WjJtSUNpR1F2ZSs3SWdzR3RJQVZTVWZCcFhHeFZ1RVZMSjlNTjIzOExW?=
 =?utf-8?B?UStSVUdSQ0NCNkhoS0dsMFZqUzFyZS9Dc21PSDBBai9CWWhmcEJjaVlOeC9n?=
 =?utf-8?B?cHFSZncyNFdQVTV3aXpCSDArN3IzblBZSHhyMEpiRmJxdUl1bWtlZkdoRFR4?=
 =?utf-8?B?YVJvOHZkNGw1MjRBS296dXM1NlIrRkY5enN6VTlZS0RkSm1idDlFKzBUbitJ?=
 =?utf-8?B?ejhkK1VQV0FOSTZsZHp4VFZaaDkvNUtIVFJpc2pNUW5McG5KOE9XbHBFbnls?=
 =?utf-8?B?SC9hN1d0M0daUHdYaHIzOWhiRGFMNUhtdUxmV0ZhZ0hkTEd4L29ZQzFXRmdW?=
 =?utf-8?B?QXB2MVNvVWF2TjJPSTJtN1FocDhCRVJSTDMrTG5NVkhCNG9iNUxYdnpCblQr?=
 =?utf-8?B?ZXZ2MDF0ZzlONWJqcnBZd2UwZ3Jwb2dzWU0xLzE4MU44N2ZaMjY2WFVWckY4?=
 =?utf-8?B?aDV4T205Vjl2TUpGVEZyb2hvek1jMXliaTBkYTlQTERZRjRvYUJhZ0RCSTRw?=
 =?utf-8?B?R3k4MFF5OVIvVzVUQ3NpNUlnOFZ5ZFRmVUY1a1c3UG9yL2JYZXpPNVpER3Ew?=
 =?utf-8?B?YWw3dDk1aVIwcTZtcm5MT2ppZXZUbTZhMDdPYkdBU2hlM2h2OWRMWWNBLy8x?=
 =?utf-8?B?by9NUmdGQnQ3bCtUWllrMWgzM1Njcm5idHNqN0F2aEtwbFY0M08rNUN0ZkpD?=
 =?utf-8?B?L2t4NmxkcmZZMURMc3F4aUl3NWc5OCsvK2xXUWh1blF6UHJWUTBFZmEyVm9H?=
 =?utf-8?B?c0lsYzFPM1U2eUlQZEpiTDc2THhpTGVtbXJQd3Y3RkR5YXpNdkxFWlFaeXc2?=
 =?utf-8?B?SDRvQlVBZEE4VHdNM3ZTOXNHTDltRGIybUUwSE81ZlM5bkw5ejdrZXpBY1h2?=
 =?utf-8?B?K3ZJc1lyYXhZZkJLRTA5cEdFbG94c0kvS0lPYmRyOFNCaUN4UDRGNThuemRy?=
 =?utf-8?B?NEUrNWIveGtiRmZHVlZmWU0wUDFoWTk1KzIyckZqRy9mSjRmRUlKd2VndnRH?=
 =?utf-8?B?ck96QWJjb1loSE93V0pGY1IwUHJONnljdjJaRmZuakZuQmR1WEVMNlRrUGZ2?=
 =?utf-8?B?SSsxS2tzTmUrNEE1UVV3TnZmbzAxSEs3KzFGcERpUFJRbmExdXRoNW1tT0ZT?=
 =?utf-8?B?R1VyVDI3UGxQbGxhWWdyNlNqemUzRGNCYmplQmdSTzBYR2tJb2tzdUxHMUo4?=
 =?utf-8?B?ZFhWNTRSVzBaT1VCWGpTTFFLcmRRZWxXL2YxaFFFQWJwa09zV1RWc2d1Y0pX?=
 =?utf-8?B?WHNUc0g1TFVCekpqMnRCSERQNmtrSkJsQjV1dUl4Zlppc0hsVXlkWUhiMGpu?=
 =?utf-8?B?QVRSRFNvZU5GN0dyc25LWnVkTXhsbEVHdG02ZnpNd3lyY3ZDVFNicHJEN1Z2?=
 =?utf-8?B?dzZYa2xPSHlsc0NGYjBUS2VDblVsQVhFUGhySzdwL2FwYUN5cVRXRlJOUGFx?=
 =?utf-8?B?bitxeEN5Um5CemVOYVVaSm1BdloxRFEyQ01IeDFDVkRQZkg1M2t2VkN1Rkxq?=
 =?utf-8?B?NEZTRkpzYzJEUUlwc21YaENtMTNOZy9OSmh6eHRiSmVZQWJFaXFiNFUwR3FW?=
 =?utf-8?B?VEdwZTQ1VXpzdmVVeUhBZmpiZzg4c1p0c2lVajJvN3ljME0vaUFwWnVhTmpl?=
 =?utf-8?B?eDVKSlZoTDVxK0Zpa21aSUxaZUI3M09NTWYrd3BhdUdySGl4aGN1ZGd0NWpu?=
 =?utf-8?Q?dm1lZz7AUhra27oGLPD7bClDf2JLJAr1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lkaXZRTmZpWHVIYkNNdkd6b2ljS21nNVNKNXV0dGZ3US9mYzVTQVovMGRC?=
 =?utf-8?B?czFQaWZacFBraVVnejNhbjR4WWJsNUU0YzFiWVJWT2wxcW9NUTd5OUd5RUhw?=
 =?utf-8?B?NUVzMm1rSFFjRi9VcFFCMVdORmwwOGFMSlNoOUpqUTFhaW8vOE0wbHdla0tx?=
 =?utf-8?B?TCtSR0pGV0dxYXNybHA1SFVNZ0NpWWF5UGdRV1NubnhIWFk5VXNseVNmbnhz?=
 =?utf-8?B?bDc2WlNZOVZLUXZRL1VsdVd4NXVLbEtsQ2h3Vko3RngrRENsOWpKbTlNa2pa?=
 =?utf-8?B?Vk9aa2pWR3dmLzkvNllrUUdJWG5YdWNoeTVJZ2x3QXJXYWw4a2xGeTJ5cFdi?=
 =?utf-8?B?RmprL3JoaThXUUNsOTZudThBdEdvVXFYVGowL0lOQ2VSZWZPWVFRZzF3UXc3?=
 =?utf-8?B?eFpUTTRQZHpPR3NOQXBvcEx3ZjVrMDNsT3pTMjZxMU9pU1k1WER3cjdLMGVJ?=
 =?utf-8?B?MFlCVmk1Q0hWWkg5SEFmTmkxOEtNVWJSSndsSmZRTGovRlpZT1BrMkJTSWgw?=
 =?utf-8?B?eldKa3o4di85NzRTRjRhSmVuYkVRemptWW9UQ0VKdnJ6d2hoTitBYXRNcXRE?=
 =?utf-8?B?ZERkc3VnM0NDeWtaWWIxbEJ1KzBpNmtkRjBxRDcvbFpHNFkxUklRRHB4TVVv?=
 =?utf-8?B?enRYVWlSUWIvV0tpVGxqYXlnZmNpbWNCL2NMMVhDbWhhMDAvUHdEZkNkeTB3?=
 =?utf-8?B?TUVDNTZ6Q3ZDZnBYS3JOVnNHRHFjc1JwYkNWbE12Z0VveFZmVWlORXlmQ3pn?=
 =?utf-8?B?QVhNYnJoREZEQXhLYnh4NDBLdWhLUnMwTU1SZ0dXRC8zQkFWY3ROVlI4T2ww?=
 =?utf-8?B?ZlM5Q3JYZlVQZ1ovK200MVgwbmxHcjhwaWlzSlJWZk1rV1p6S0pSUU1IbnRy?=
 =?utf-8?B?azY1WE1rZGx5RWttdTF4RlU3MDZUK0RlbUhrZTFnWWZMcTZPN0V1VENmQllk?=
 =?utf-8?B?Ti9GMHROUFcrWG9XQktnRDA3c1NJSGM4U09yMzhmc1NwTVpob3pXUWFMeitU?=
 =?utf-8?B?eE4vYWI4UXFVY0RIT3JDNVNIQ2Z3d2FpdUpRcVR4clF0U1pINWlSOGgvUlRt?=
 =?utf-8?B?QTlZWWlXUXk0VXBhVnV6RWZXS0pZNWZtK09NbHFsTEdRVXpiZzNhRkdvV0w3?=
 =?utf-8?B?YWNUOTk5OE9tb01XM2c4SnVxTVZpb1VNSldEdmYvR3hJci94V2VGOXp0OXd3?=
 =?utf-8?B?eTU2eDZxQUhMYk1WL0Z5R1JrWExJOHA5WGFtY1dueWs0dGU1ZFE5YWphUHRK?=
 =?utf-8?B?eHp2ZTlqM2luWnlIRzRZUGNzbStJT3VQMnRhbEUwUExtdjUwUksyZWU2b3c2?=
 =?utf-8?B?VmZob3FKd3NpSUtxQ0F4MTZ4bXFhNVlNcVVpS0paZjZFT3d4Ym9sY1dRYXUy?=
 =?utf-8?B?R1BLTmY2NVFZZzR4TXJXVVVDZTZPb2NYRGF1cGVFdGVHanhnNDZReVRWSWhk?=
 =?utf-8?B?ZUdhcnlRNHBQdGtXQjg5TkJQdGQwT0lpbkg0TXRxK3B5ZXloU0NWYnowSnJG?=
 =?utf-8?B?Wkd4NFFhRGFlbXdsNUJRcmdNTkl1c0lXcWt0ZjVxSzJ0NkN0aTZUWWJ3Sm00?=
 =?utf-8?B?KzB3NXpIU25pcmlFK3Q0T3hKYjFLREdSUVRXUXhBSFBqTkZmcDJ3T0M1NlNF?=
 =?utf-8?B?Z3ZhcHZiRkZzY0t2SXFYZFdVcStURytuOUFodWh3WDJjak5HSXExR2dObUor?=
 =?utf-8?B?Sk90RlVqZTltT3dkUUZnV2JKb3dVU25jZVMxK1JneW8wY29vaG5IVjRQMSt4?=
 =?utf-8?B?bFl6elo0VVdGNVJqVlJla1Y2VGtsLzk3Z1VmN0M5VTNRK1pYSENWc3VPekEw?=
 =?utf-8?B?cjFaTHhmMDV6eEhPNlhMbm9Hd0wyeWtsTUhsS0lSYjVsVGpsVXNlUVNPSWJT?=
 =?utf-8?B?Tjcycm1aZy9yam9vRS9NVVh4b3M4QUFhaFpid0RTcjdEVVVINHBNSVVwYVZn?=
 =?utf-8?B?L1FaeG1iall5eElEN3VVVm0ybVRHWHAwVG1vM00zYzI4OVJMeFgvb1crR3pw?=
 =?utf-8?B?VjJyRTF1VVNVK1haQ0lBOHptM2tFUEkxU3lVdlByRWVIRG0yc1BKWWI2LzQv?=
 =?utf-8?B?cnllNXc2bUN4QkFtVEs2MDd3aitwMEIwQW8rK2p0S0hwdjNHd2ZmbWNRZTJz?=
 =?utf-8?Q?r0jDlsUbbvwQX7qbX4uQn3Zyf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3fd13-cac7-487e-86b8-08de0b2d8060
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:25:19.2128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhrvUJTZCHQ8UtmSjQ0lYB/i/UPM1KYJkap7uVFPWM22oozXObPqNNJVcWWvqoi/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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



On 10/13/2025 10:00 PM, Ilya Zlobintsev wrote:
> Calling `smu_cmn_get_sysfs_buf` aligns the
> offset used by `sysfs_emit_at` to the current page boundary, which was
> previously directly returned from the various `print_clk_levels`
> implementations to be added to the buffer position.
> Instead, only the relative offset showing how much was written
> to the buffer should be returned, regardless of how it was changed
> for alignment purposes.
> 
> Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  5 +++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 15 ++++++++-------
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++++++----
>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 ++++---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 ++++---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  5 +++--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  5 +++--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  7 ++++---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  7 ++++---
>   .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  5 +++--
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  5 +++--
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  7 ++++---
>   13 files changed, 52 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 9548bd3c624b..55401e6b2b0b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -291,11 +291,12 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
>   					enum smu_clk_type clk_type,
>   					char *buf)
>   {
> -	int ret = 0, size = 0;
> +	int ret = 0, size = 0, start_offset = 0;
>   	uint32_t cur_value = 0;
>   	int i;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -353,7 +354,7 @@ static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
>   		return ret;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 0028f10ead42..bbf09aec9152 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1469,7 +1469,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   			enum smu_clk_type clk_type, char *buf)
>   {
>   	uint16_t *curve_settings;
> -	int i, levels, size = 0, ret = 0;
> +	int i, levels, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	uint32_t freq_values[3] = {0};
>   	uint32_t mark_index = 0;
> @@ -1484,6 +1484,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   	uint32_t min_value, max_value;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_GFXCLK:
> @@ -1497,11 +1498,11 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   	case SMU_DCEFCLK:
>   		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
>   		if (ret)
> -			return size;
> +			return size - start_offset;
>   
>   		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
>   		if (ret)
> -			return size;
> +			return size - start_offset;
>   
>   		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
>   		if (ret < 0)
> @@ -1511,7 +1512,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   			for (i = 0; i < count; i++) {
>   				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>   				if (ret)
> -					return size;
> +					return size - start_offset;
>   
>   				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
>   						cur_value == value ? "*" : "");
> @@ -1519,10 +1520,10 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   		} else {
>   			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
>   			if (ret)
> -				return size;
> +				return size - start_offset;
>   			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
>   			if (ret)
> -				return size;
> +				return size - start_offset;
>   
>   			freq_values[1] = cur_value;
>   			mark_index = cur_value == freq_values[0] ? 0 :
> @@ -1653,7 +1654,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int navi10_force_clk_levels(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 31c2c0386b1f..774283ac7827 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1281,7 +1281,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
>   	OverDriveTable_t *od_table =
>   		(OverDriveTable_t *)table_context->overdrive_table;
> -	int i, size = 0, ret = 0;
> +	int i, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	uint32_t freq_values[3] = {0};
>   	uint32_t mark_index = 0;
> @@ -1289,6 +1289,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   	uint32_t min_value, max_value;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_GFXCLK:
> @@ -1434,7 +1435,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   	}
>   
>   print_clk_out:
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 2c9869feba61..665eee58358d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -565,7 +565,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
>   	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
>   	SmuMetrics_legacy_t metrics;
>   	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
> -	int i, idx, size = 0, ret = 0;
> +	int i, idx, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	bool cur_value_match_level = false;
>   
> @@ -576,6 +576,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
>   		return ret;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -658,7 +659,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int vangogh_print_clk_levels(struct smu_context *smu,
> @@ -666,7 +667,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   {
>   	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
>   	SmuMetrics_t metrics;
> -	int i, idx, size = 0, ret = 0;
> +	int i, idx, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	bool cur_value_match_level = false;
>   	uint32_t min, max;
> @@ -678,6 +679,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   		return ret;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -779,7 +781,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int vangogh_common_print_clk_levels(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 3baf20f4c373..eaa9ea162f16 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
>   static int renoir_print_clk_levels(struct smu_context *smu,
>   			enum smu_clk_type clk_type, char *buf)
>   {
> -	int i, idx, size = 0, ret = 0;
> +	int i, idx, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
>   	SmuMetrics_t metrics;
>   	bool cur_value_match_level = false;
> @@ -506,6 +506,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   		return ret;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_RANGE:
> @@ -550,7 +551,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   			size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
>   					i == 2 ? "*" : "");
>   		}
> -		return size;
> +		return size - start_offset;
>   	case SMU_SOCCLK:
>   		count = NUM_SOCCLK_DPM_LEVELS;
>   		cur_value = metrics.ClockFrequency[CLOCK_SOCCLK];
> @@ -607,7 +608,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index c1062e5f0393..677781060246 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1195,15 +1195,16 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
>   	struct smu_13_0_dpm_table *single_dpm_table;
>   	struct smu_13_0_pcie_table *pcie_table;
>   	uint32_t gen_speed, lane_width;
> -	int i, curr_freq, size = 0;
> +	int i, curr_freq, size = 0, start_offset = 0;
>   	int32_t min_value, max_value;
>   	int ret = 0;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	if (amdgpu_ras_intr_triggered()) {
>   		size += sysfs_emit_at(buf, size, "unavailable\n");
> -		return size;
> +		return size - start_offset;
>   	}
>   
>   	switch (clk_type) {
> @@ -1534,7 +1535,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index b081ae3e8f43..6908f9930f16 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -497,11 +497,12 @@ static int smu_v13_0_4_get_dpm_level_count(struct smu_context *smu,
>   static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
>   					enum smu_clk_type clk_type, char *buf)
>   {
> -	int i, idx, size = 0, ret = 0;
> +	int i, idx, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	uint32_t min, max;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -565,7 +566,7 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int smu_v13_0_4_read_sensor(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index f5db181ef489..4576bf008b22 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -861,11 +861,12 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
>   static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
>   				enum smu_clk_type clk_type, char *buf)
>   {
> -	int i, idx, size = 0, ret = 0;
> +	int i, idx, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	uint32_t min = 0, max = 0;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -928,7 +929,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
>   	}
>   
>   print_clk_out:
> -	return size;
> +	return size - start_offset;
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 285cf7979693..0e1b225dd875 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1428,7 +1428,7 @@ static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
>   static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   					enum smu_clk_type type, char *buf)
>   {
> -	int now, size = 0;
> +	int now, size = 0, start_offset = 0;
>   	int ret = 0;
>   	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
>   	struct smu_13_0_dpm_table *single_dpm_table;
> @@ -1437,10 +1437,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   	uint32_t min_clk, max_clk;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	if (amdgpu_ras_intr_triggered()) {
>   		size += sysfs_emit_at(buf, size, "unavailable\n");
> -		return size;
> +		return size - start_offset;
>   	}
>   
>   	dpm_context = smu_dpm->dpm_context;
> @@ -1575,7 +1576,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c96fa5e49ed6..a3fc35b9011e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1184,15 +1184,16 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
>   	struct smu_13_0_dpm_table *single_dpm_table;
>   	struct smu_13_0_pcie_table *pcie_table;
>   	uint32_t gen_speed, lane_width;
> -	int i, curr_freq, size = 0;
> +	int i, curr_freq, size = 0, start_offset = 0;
>   	int32_t min_value, max_value;
>   	int ret = 0;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	if (amdgpu_ras_intr_triggered()) {
>   		size += sysfs_emit_at(buf, size, "unavailable\n");
> -		return size;
> +		return size - start_offset;
>   	}
>   
>   	switch (clk_type) {
> @@ -1523,7 +1524,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long input)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 73b4506ef5a8..5d7e671fa3c3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -1041,12 +1041,13 @@ static uint32_t yellow_carp_get_umd_pstate_clk_default(struct smu_context *smu,
>   static int yellow_carp_print_clk_levels(struct smu_context *smu,
>   				enum smu_clk_type clk_type, char *buf)
>   {
> -	int i, idx, size = 0, ret = 0;
> +	int i, idx, size = 0, ret = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	uint32_t min, max;
>   	uint32_t clk_limit = 0;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -1111,7 +1112,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
>   	}
>   
>   print_clk_out:
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int yellow_carp_force_clk_levels(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index fe00c84b1cc6..b1bd946d8e30 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1132,11 +1132,12 @@ static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
>   static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
>   					enum smu_clk_type clk_type, char *buf)
>   {
> -	int i, idx, ret = 0, size = 0;
> +	int i, idx, ret = 0, size = 0, start_offset = 0;
>   	uint32_t cur_value = 0, value = 0, count = 0;
>   	uint32_t min, max;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	switch (clk_type) {
>   	case SMU_OD_SCLK:
> @@ -1202,7 +1203,7 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 086501cc5213..2cea688c604f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1056,15 +1056,16 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
>   	struct smu_14_0_dpm_table *single_dpm_table;
>   	struct smu_14_0_pcie_table *pcie_table;
>   	uint32_t gen_speed, lane_width;
> -	int i, curr_freq, size = 0;
> +	int i, curr_freq, size = 0, start_offset = 0;
>   	int32_t min_value, max_value;
>   	int ret = 0;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
> +	start_offset = size;
>   
>   	if (amdgpu_ras_intr_triggered()) {
>   		size += sysfs_emit_at(buf, size, "unavailable\n");
> -		return size;
> +		return size - start_offset;
>   	}
>   
>   	switch (clk_type) {
> @@ -1374,7 +1375,7 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
>   		break;
>   	}
>   
> -	return size;
> +	return size - start_offset;
>   }
>   
>   static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,

