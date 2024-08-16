Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D141FC52D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 23:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889E710E861;
	Fri, 16 Aug 2024 23:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1tYzPXH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D2C10E861
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 23:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv8FQOmQzyQflbkftbmOzD5p4R0ZRYS5GvqcCNyZ1am42h7Nvs/UlUfMC7V1uxozoHE5vgN22FmBtuLTo4S51+QqpX5cj+JG4Fnp2ySq3aVEMY5fZKPALmpodqDNXYwJ27Gf9hOeuY8UQcdGtdBFOXGK1fRbZczRjIQWXLxT+DUiwfvGePgXHylk0UIpJWlfphpQXlhSc7YuaLqBUpHOXeb/AvL09E00W8eWbijNXO06zPCJFwod1x1EGX1oyyJxdCs7FGg4pyCPFZVFl34f8LSszL4sVQ0mhcC3ZBY3vskV8SKANzs/v9mpR+XCiC+D+/Nrv9x1k4o+ijgNcB5icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4P7fO7oqXSJvzdVWwd4jADExTCbmPessVvbXa8/Ovg=;
 b=wJiLZEHEMt+wFr1iSEG9cgGcoHzvk0bYIJ8ytNdNnSCMHpdPwEjRhMKALNgf7452nYWaw15/6wZcZePpgpnCnBoW4IQnYt90YvYpsfxuCE3ZAAg0NMbZ6fMNN5sc6SKjkmyJsuNzb9Hd4/KiCD4+EcL43ulozCe0/d10NVmm+KzBUB/31aUm9Ojn4dwxWuDDkFRP14NzynEPPPZG2E9j8znoTSAcpnSXGKM3wZOpxG5He3+ixKJeq5NHDlq14VYKeq4WbJ+WmOVsRWdgHs3OzwrQ2ef3hKjMIFEDOA8jWS0hZLVXrFVM61Fb9UwupT/TB9uPrE/3W7yM3JLJxZBcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4P7fO7oqXSJvzdVWwd4jADExTCbmPessVvbXa8/Ovg=;
 b=R1tYzPXHuEwL7jA33LBx6lCUY4+0FR4yuepDiTf5qoFkql2Y8xKdV9T6FmaGgD1GSM9occMUMkOmbgOpMZo3St0LRSsbE2+tMIN9AnGOzLFw0lJE+VLBDWcEu3UjxU7rdu7rj77KzdF4WfVt8mM/l5FFUZ2WkosqW9QK7xpOCsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 23:09:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 23:09:15 +0000
Message-ID: <a0f20b00-e65a-4e06-9618-c09c84687b73@amd.com>
Date: Fri, 16 Aug 2024 19:09:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/3] drm/amdkfd: Update BadOpcode Interrupt handling
 with MES
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
References: <20240816180138.1171558-1-mukul.joshi@amd.com>
 <20240816180138.1171558-3-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240816180138.1171558-3-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aadda6c-def9-4573-e4e2-08dcbe4872d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0lTYk9tZ2IzNjV4Sk5FK3orbGVFdGxiVHlPVmUrM0xzMnQrbVFuK2Fnd0Vt?=
 =?utf-8?B?VTRYRWVVKy9iaml1VUx0MUR4RkwySHZaOFlPaEhIMXd6ZEVxY2F0eHVGZEFn?=
 =?utf-8?B?Y1c4S3lUYUx2L2thUXo2VzdnbFl4T1hHcC84cDZtZTd2cFlZaWFFSmZaMmx1?=
 =?utf-8?B?TnJQYlUydnhQYW94MVZJei8rMWlzRVdENnVWQksvSGJHaTBTM0E0QnlhUWl6?=
 =?utf-8?B?K2lreFVYeGdvdkNwUGFCR0VjSHhJdVA1OU1TcHFlVHpQUmFHY0o1dmhZN2lZ?=
 =?utf-8?B?RmdYTFdnNVJzWFVmSUs0enExTk5tTVlxRDAxRmFvbmZSQkpFZFFHdjhpdEpt?=
 =?utf-8?B?RldiSmtjRGZEM0VVVk1GUG9HZEN2MzZyLzN0SGhyQUJMQ0srbC9QVkw5OVRz?=
 =?utf-8?B?a3ppdGdXUHY3K3lDMVdrdWt0Y3p1cXVoRzhPdi9YSGVPNzFhaHdkZzJMcktu?=
 =?utf-8?B?aG1zRVZiektwY1lmNFlpWVVabC9yWFRzZ3p1ZlByMVYxaFBwZ0x0WDM5Y1RT?=
 =?utf-8?B?NFhWMnhFR3RpWXliWURuRGl5SExMekFFZ0NnaUJLenIxNnhUMkRqS1pKYjF2?=
 =?utf-8?B?MmVtTDYrR0RJSFlWMVcvYUZUSW1SbFZJaHU5VHNlTUNWQ2pYK3l2ejQ1T3JU?=
 =?utf-8?B?R3dHZEtyS3p5SEVENGZ5Mzhna0dYaGdlTUN1U05IdUdlem5MdzM5WTJBc2d3?=
 =?utf-8?B?TG41cnY5VzhVY2V2VTdvL3VCRlZwcnpWMGJDclJ4VExJMmg5YXJuUUJWdFpN?=
 =?utf-8?B?aCsvOVFsZXY3ZzRyYmxjZ1dpV29sWlhUUzd0SDBuYm8zZ084cWRkTzJDcHZq?=
 =?utf-8?B?UlNvTkprSWdSOUJmWHdxeHg2TERmUFNWTENlenVENHd4RG1iZWRmOTlUR1N1?=
 =?utf-8?B?RmY5VnJ6QzJPdHhneFU3UWsrbnp6bVVWYzNqUndsNHIyc0s2bjE3VGlTVmN2?=
 =?utf-8?B?SnMrckk4YXNoYVZoTExuSnRpaURydkFQWjdYVE9nTklLUVh2NWFHYlppWkJr?=
 =?utf-8?B?dWV1aWRaU1BHTGx3ZmFoMHVMbGxHVlYvUmd1blFCVlhjQ0FraE11cHFWKzZr?=
 =?utf-8?B?TXBYZHBVZk5wYWo5Ly9HR3NSSHJQM2Z3T1hGbHk0ekdtWEVOUGhlWnJsM1k0?=
 =?utf-8?B?QXpUbmtrLytoRUdxWHhFd3E4Tnk4TzFSei9sOU5zN003ZDIxd25oR2NHRm8x?=
 =?utf-8?B?TFZialZRUUEveEMyOGpkOTB3RFRzei9TLzlRVFYxcXZHb3VhaWljUjlwTXh5?=
 =?utf-8?B?YjVLcDN6U292ZmhVUWpGRmxaaE5tNWNTYUhvcDQyOWQ0d2lsbGo1V054TnNG?=
 =?utf-8?B?a0tKNDdZc2ZiY3kyZk0wYVVPMm1wMERZT1J6eWdTM0RaNVdlaUZ3aUpqN21E?=
 =?utf-8?B?dkY4Wm9ZVmhCajFFQ2wrc0lCZmQ5emZScGc2SGV4MkFxb1ArUTlpMG5xUUJi?=
 =?utf-8?B?Vy9kYzBkYnVKZ2NFOUhZclcwZFVCazZPL0lmcWpJMnJ2NzZSSTNqUmdiWkhs?=
 =?utf-8?B?SkFtWEoybzFsV2g5TmFONitYYlhzS0RaS01DeUFrQzhpbkhoSFNlS2NLaE5u?=
 =?utf-8?B?b1l5SDFUaWpaRFVoQkNySkVta3MzM2J2blpSZitRdi9DUDdlcmszd2R4Sm83?=
 =?utf-8?B?OFVUSW5kc2ppKzEvbFZyT1JvbTMxVmNPZ0R0UlEyUHlZSm9KamVYZ2dEUytz?=
 =?utf-8?B?M1JsZ285VzhqLytGRUw0WWxWbUdxK1NzejZkZDhoOUpUQi9qb1E4Y2p5ZmdU?=
 =?utf-8?B?cEszQmdNNzdYVGxlbUo0S1NNMUtORFZRL0N0OFJHV2N4YngyeXhvT2VnN1Jl?=
 =?utf-8?B?akR6eitJY1RvYlExQ1Z1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXVDSnVsR2VhVW9lWnBhSlhjYTJsQ24rdllNYWhEYXJqcnpPb05hd0VsQjFI?=
 =?utf-8?B?WStvdnNvaTdVT3FJWnZrOUVSaWlwTEJGWFpQRHdFWlp4czM0aWUzeTUyR1hx?=
 =?utf-8?B?cEhKdFJyRXJsM3NCV1BiaWxkblRVaDkycWp5M3FSL1dsSmZZS1dBYXZlRnlK?=
 =?utf-8?B?ai9xSE9lTzkvUVNBU3RYYnFUbmhaQWxSVTVUTExwY0xPTjhwSVMvYjJ2aW1l?=
 =?utf-8?B?VmJnUkZ3cEJNQ2lXbUVWUlVCdUhKUzI3aUU1bEVaVXV3TWU0YnhDRVBacHZF?=
 =?utf-8?B?WEFCMXgvRjNYa1ZIN2RpSzNwam91T0U3NENpVzVXb1JwY1VUZlYrZ0dpdGNO?=
 =?utf-8?B?RGQrd053dktGSlBjbVJGY2xtMTVMSXo4V29TL0pYUGxXYW5HZWNPU0FuSldh?=
 =?utf-8?B?Yml1NjllNzBaNENnZ0syN3JDTHVmY1dKcjVYTkcyR21Ca0JKZVZlTjc1d0hJ?=
 =?utf-8?B?TUoyNi9wYU9nU1BsVnE1em5Mdi80Rm8xVzkyYzBsWnNKcWdVSFRzWElmSXp5?=
 =?utf-8?B?U2RyR3F3aUFIQ3huY09KRVpJajZWb2RNS016N3JWUDNHWlN1eFBMREZRRjRJ?=
 =?utf-8?B?TWpjenFVTnF1ZWxwcmlORlJVeWVONEk0K1RFdE5JR1BBS1dVOUlTQ2NwUXVw?=
 =?utf-8?B?N1YyeUlFOFc2S2IyVU5GaWRpVDRPN041Q2xiY3IwQzZoSDB4RWlmN2FXSlJj?=
 =?utf-8?B?Y1lqUkhmWjlMdE11V0ZGNVRSa1hRdWxFcXhVN2h6K2t0OWJMa2VmWVBCV2gx?=
 =?utf-8?B?WnYwR2FIQnNvYzZOODlnT05zbWVybzRHWGkyQ0Q4UVdIQ1VoWG5EaHdISlZD?=
 =?utf-8?B?Sm1Gcms4UStpcTVvR2wyaStlcGVkdFJIQUcraVh3elpQUGxnVUR6M0VkYnpJ?=
 =?utf-8?B?bUNjZUF3WmNRSkF5UjdZeXN0aGVYZFJ5andlS1JhZUNvN3ZFTi9nSUthZ0xk?=
 =?utf-8?B?UENmVkxlM0l4T2tNcDJkQ0wwUXl0cVNDU0ZBY2h1b2dKdFptWHBQWGkwQnNW?=
 =?utf-8?B?OGlvYTNYN1kvU0ltUGZVbzJwN0lmNnZNZFJkMkY1alJMWXpFMEFpMmdiSE5Z?=
 =?utf-8?B?V05pZTliTTNHc0RidjNDMGpCVHoxbEdZTFVGa0MyZnVScThWUi9Yc3E1WkhS?=
 =?utf-8?B?UHdIOFZBeUZuNkVFRVozekFWd3lJRVp4V3ZSK3piaWw2Y0JtQng1c2RhNGxa?=
 =?utf-8?B?Ty8welV2eDh1eDUxV044RnVMZXZKMWlSbVNFNmJtTGNkcVlWSTVCOWRKVWJZ?=
 =?utf-8?B?YnFpR1dUaW5HRm02d09CSkx0aXBYL0YrYzB3YzNjVzNYbVpQTE12ZWtzVWtI?=
 =?utf-8?B?THF1aTkyVVBWb09zb0FiRjFUSmN3L0k3UFFaZisxRTFZSUIxdzhvWmdVMDBC?=
 =?utf-8?B?NUk2dHhjSWR0ajNQVVZOKzJUamp6djVBQWVNcUswYVBUdjZSdi9PYUt6WGc0?=
 =?utf-8?B?NDFWblRRa2cveGU0Q3lWS2RlRWZKVldHcU1vVTI0V1dZTkN3NzVRRGdvbkYx?=
 =?utf-8?B?OUlDQ1hZOTl4YzYxZHp6eTg1em45a2owcm5pSDRIY0VYYWdOanVqMitwT0E0?=
 =?utf-8?B?S3hNaU5sdnQ3Y2QrTUIyNHNYbmxCek0xZEtZQXhWR00xcUNrUE43N2l1VHAr?=
 =?utf-8?B?SVVZZVRFaUZndis2SnVjVGlucUQwYXI4cXRaNnR4a3U0SDVZVnZPSCtHK1Rv?=
 =?utf-8?B?cG1YNWUzczBXMzJ3RktjQm1IV0lTYk5kcXdoNE43eC9ucjdtQnIzLzB5eTQv?=
 =?utf-8?B?Q25hdEM0ZTV4V214RDNRZ0RxaEdrT2laNWFoTjMwWlQ3MkFCSTkrdTBqejVp?=
 =?utf-8?B?K1liT3A4THAyRkpIblowV2JJTnlTT0ZlcGlVK1poUS94NzdKMEVrTEt6ZXRq?=
 =?utf-8?B?MVVwUlJjL3NsdnNQSDNaNnZaVGl4NWNHR2p0Tm83N3dadWt2bytnaU51WGtG?=
 =?utf-8?B?Z3dEOWJYUUJNY2hkekRITm1qbEdYOU5ZMXhiQitmL21LcnB3eGJBcHdBbVlF?=
 =?utf-8?B?bDM5TEgvL2lZZm1ReEw4RDI4cVJZd3pZV2xzMnBJR3FwVTlVbHRhTnlZZG03?=
 =?utf-8?B?elRLcTI1WFVMaTdoUWpJWWlhMmc4ZDhZaTViNFArOGFtcXlJMzdycEFYMGZq?=
 =?utf-8?Q?QZ9xsdv17DCj/gH9ojNG+PeEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aadda6c-def9-4573-e4e2-08dcbe4872d5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 23:09:15.4400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5KX8ltgc1blfj7E0V8z05rW5bQxPU4CLXGTeV/gbLT/mBMRz1mrSzTQeOZ7zY9yQvCoXE7V1HiWoqON6whlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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


On 2024-08-16 14:01, Mukul Joshi wrote:
> Based on the recommendation of MEC FW, update BadOpcode interrupt
> handling by unmapping all queues, removing the queue that got the
> interrupt from scheduling and remapping rest of the queues back when
> using MES scheduler. This is done to prevent the case where unmapping
> of the bad queue can fail thereby causing a GPU reset.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - No change.
>
> v2->v3:
> - No change.
>
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 51 +++++++++++++++++++
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   3 files changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0ca933d2099c..d7db33f378e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2875,6 +2875,57 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   	kfree(dqm);
>   }
>   
> +int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct device_queue_manager *dqm = knode->dqm;
> +	struct device *dev = dqm->dev->adev->dev;
> +	struct qcm_process_device *qpd;
> +	struct queue *q = NULL;
> +	int ret = 0;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	dqm_lock(dqm);
> +
> +	pdd = kfd_get_process_device_data(dqm->dev, p);
> +	if (pdd) {
> +		qpd = &pdd->qpd;
> +
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
> +				ret = suspend_all_queues_mes(dqm);
> +				if (ret) {
> +					dev_err(dev, "Suspending all queues failed");
> +					goto out;
> +				}
> +
> +				q->properties.is_evicted = true;
> +				q->properties.is_active = false;
> +				decrement_queue_count(dqm, qpd, q);
> +
> +				ret = remove_queue_mes(dqm, q, qpd);
> +				if (ret) {
> +					dev_err(dev, "Removing bad queue failed");
> +					goto out;
> +				}
> +
> +				ret = resume_all_queues_mes(dqm);
> +				if (ret)
> +					dev_err(dev, "Resuming all queues failed");
> +
> +				break;
> +			}
> +		}
> +	}
> +
> +out:
> +	dqm_unlock(dqm);
> +	return ret;
> +}
> +
>   static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
>   				   struct qcm_process_device *qpd)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index f524a55eee11..b3f988b275a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -330,11 +330,14 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
>   		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
>   			kfd_signal_event_interrupt(pasid, context_id0, 32);
>   		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
> -			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)))
> -			kfd_set_dbg_ev_from_interrupt(dev, pasid,
> -				KFD_CTXID0_DOORBELL_ID(context_id0),
> +			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0))) {
> +			u32 doorbell_id = KFD_CTXID0_DOORBELL_ID(context_id0);
> +
> +			kfd_set_dbg_ev_from_interrupt(dev, pasid, doorbell_id,
>   				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
>   				NULL, 0);
> +			kfd_dqm_suspend_bad_queue_mes(dev, pasid, doorbell_id);
> +		}
>   
>   		/* SDMA */
>   		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f7c12d4f0abb..7bba6bed2f48 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1324,6 +1324,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>   					enum kfd_queue_type type);
>   void kernel_queue_uninit(struct kernel_queue *kq);
>   int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
> +int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id);
>   
>   /* Process Queue Manager */
>   struct process_queue_node {
