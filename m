Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F338CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 13:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D734C10E1E3;
	Mon, 18 Aug 2025 13:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0oQPoypX";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8014E10E1E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 13:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCu/fag8op5glPnx1hzjMWVsJJp0yAMSRsAMoaNizNwJVJxYS6Vt3FIgl9PEUr5hivor/qatuUjM2beg0MkcCpx9ChQOz8Q5OOAXIX8pnIMDIyc9quh1os3RNRdZjhESYUqLyegOb54tUGTwiv0YW9Lr+i0Mum+uNaiDLcKc4Auqfx7WePL9cuqt1hAhIZm5ox0eyB4trxRSQEfHzVenH2H6Vc8GZhPIsAHugJc07Jge3b9OdZZErzEtYG3yyr9LtVVSn1w3LaZFs5O6ufOujBBwEDYguleDXyB9ANVdNSkkbPqCtYunUsZcVvBRPyvjs0iL/vXr0BGqdveKlV5/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHQiwucvmWCw+lXYPP5HTP+nPxt9tTXZ3KVb74LVgMM=;
 b=e89VvAUtI/8ugEZgZav4nVSZEKdbW+8VvFxEDqUeon2QkgR5XHlLmiUn6dGCXVr9FnGemWj3gs1+C2QU3O4Ay/tj0klcHism4tvOKKfPGhEkJ/IKw1EGJ5C2FcjsKX4PNhgdzr7OXorAcQHtncZThLQn4LEz8YxE3DC+H/+ulUSVUBqAyy73Hm2GQWdJCAR7uqUFFkEqiwyZOy9NgKG+RcAf7Za5LE9BpjEGz0s8YnEsu4uO422GWM0JcafMbxZaqaKH5agRoSqNhBDyazcmTU8k41+w+b0b57+eNHLVPxZah65MZ0If0gUCMtTzj2AHKnQ6d+CSfx501WVFYUm6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHQiwucvmWCw+lXYPP5HTP+nPxt9tTXZ3KVb74LVgMM=;
 b=0oQPoypXv5xQUCggA5JheI7eyi+PYxPQwDl9dF3UAi4/lS9z/68ePhgkpjwsFiUH7QWj+WA8t00DFSC8S0R8kaXTJY8oR1fUHSlMjbws+yt61Lx4O/2pCtn5Glz+Q4CnODQ4xfRd1388AWKS5QkpaTLn+n5EiTOxWVtyPQDgKyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 13:49:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 13:49:09 +0000
Message-ID: <5a0a43ed-a29c-411a-8277-4436e96a6270@amd.com>
Date: Mon, 18 Aug 2025 15:49:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: print root PD address in PDE format
 instead of GPU
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tom.StDenis@amd.com
References: <20250818134822.1927480-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250818134822.1927480-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: aba772fa-aede-45ce-79f4-08ddde5e01d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0pUcjFqb3pwdlZST2tQL1JzM3prbW9RYkFpTkVlVDdXZlE3dnNUb3VjaTNX?=
 =?utf-8?B?a09rc005aHRpY0dDVHZXZmdveEdCT3Y5eDNqOG12R21WZnBzRE9PSXZZSXNK?=
 =?utf-8?B?aVNveHZDclNjN0lPMjhxellBQWxTQWFOcUlkV3FrdGcvNW1GNnF3M3RNR2Js?=
 =?utf-8?B?WlRRdmZ5Um1CeTlhbGdLWmpoYU0xUm4yYXZ0VHhSSnpWc2d0NHJ1UUFqZGI3?=
 =?utf-8?B?VDJ1NXZMMW5FYnpWVHVxdWRWNWl4MVhBanExQ0hCSU81cVFEMkxhQi9lT2Uz?=
 =?utf-8?B?VWpCbmErdVdaMDkwRld3OHVBMGFtdFRYcXlxOXFlUWRGVnJweU10R1NqUjl6?=
 =?utf-8?B?dnJ1ajNyQ2k1TjY0RENOOWt6d0VvWEs0UHVXbDNreHZvNWZkd3lKZmNRK2Fv?=
 =?utf-8?B?ZStCN1h5c0ZaMzdDc09neEZjRGhXNnVlT0RhRzF5N1pIb0l1dE8wZytEYkNt?=
 =?utf-8?B?WU5MZlZLWmVPdGtlWUdoeEp5amw1VWF0MkZGaWVWK2ltbG5hSnpYQVovdVNr?=
 =?utf-8?B?ZmhncVNiV2sxeWlZZUltL3EvOXNHK2ZsdVk1ZmZSNnp1VHRnaEhMRmRXcjFY?=
 =?utf-8?B?WEo4U3YzSFF0ME1SZlhxcmZoR3RUZUV4UDFPd3NiZTNVZzRhMVZlSGlYUExV?=
 =?utf-8?B?aDd1Yk5tek9EQkVvSmxsL2phMWNDMXhmZUM0WVljMlBHVXA5c3lUT0N2L1RB?=
 =?utf-8?B?cmhhZ25uZ2V1VjVNRzA4TndVaG1RUVkzaGx5YXRuZVVjUURMTUlzOFh4c0Rq?=
 =?utf-8?B?ZzlPd1ZsaVpRbC9qbUlTcUIxZzlzeXUreGtvNEpIb3NQZVZCbGV2a0dXMElm?=
 =?utf-8?B?NDBpbC9ncFZHWFhyUWkvTysvRjA0emozM3IvclNJbXM5eVVnWVU0UWpBZnh2?=
 =?utf-8?B?d01KK2dmUWMvRnhvVEtxVmZOWVRlWlBUMEVLTWErWVZSUXFEVGZMbGhxU1Yr?=
 =?utf-8?B?WmlmclVsZUVlelRpOC9NZkk0OHE4czdBVTA2aXYwQ0x4U3l6czI3UVJnbHpQ?=
 =?utf-8?B?VjRRNnpOdHY0N1BZSUVlTlZ3cnlRQ2JmeDlHOHBTVE1WNXc3TTRpYjNaZmFt?=
 =?utf-8?B?QU9rVllWOVVIRThxMjkyZm82NkFPN0JGZmFwL3JWTy9tclJlQkM4Mk83dDdv?=
 =?utf-8?B?cUJMRlpCWFQvblRBZTljMGFDZ25Od29kRXZQTGJrN1lkMkRKdTU0d1o3RkZt?=
 =?utf-8?B?OG8rcEtsUm5Nd3pmVERWcWY4WlpOUDlybURJdXBHeWNtUjJ5c3RMN3FHVHZB?=
 =?utf-8?B?U052TGVJSzdPQnROZ3pvOFVzRjZMZndnVzZlem4yN0ZHMC96WjVrT2xYRVNP?=
 =?utf-8?B?ajRSRWdkTzNTZUppVC9FV01kVGJtR2NnM0tuQXpZcEdzaUVOSXJFM3pGekpP?=
 =?utf-8?B?V0dHM3VBVlpGWFp2M20xQU1yT25MTmRVamJUYWp5WTBPMi9QWUZpbFZBRjJG?=
 =?utf-8?B?cHUyelJDWGlMTlcxUDRzMEV3dnJtZERyRW1CTzJldFlQVFlMbnorTnFFZUZC?=
 =?utf-8?B?VGZ1OHd0UmVFNmRPUG8rSndoNldIbGpDRFdzQzVmeXNqbEh6OHVjb1F2elF1?=
 =?utf-8?B?S2pVWkpOamU0Wkx5ZnlKMVMxRk8zU0FVNmpmQUZ1YlIxMHQxVGQ4VmlKNGc3?=
 =?utf-8?B?NUs1RXNJSWtRZEhWNU1CSkVtd3cyZ3BsTFhreVdXSlRjSmZzVzVtVmt2cWpO?=
 =?utf-8?B?N3JNaWFxQllwc0YzU3poMGJ0cWZzY3hPYS9sZ3cveFB6NVlqdXFYVE0reUlG?=
 =?utf-8?B?QlZNdzN6OGdnNHlFbTd2R1VMNlRUT2FvWEVYMmEvU2FrTG95eHY0M3o4UXJS?=
 =?utf-8?B?MzZZSWVHUkdoa3JJNk5odG91ZmNEcWZiOFJST2lSTHh2Tk9PbGxrdU5rc3dF?=
 =?utf-8?B?aEgraU5ueW9acFVqM3AxZEdvb2s0ZWdKWElFM0ViRndaVEZNeVdOcVNzVW5n?=
 =?utf-8?Q?EABHlN6+5PE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtUSm13bkdJL09FZ05PQ0dxZ3Ezd005VnBEVXBoUTBWbTdPN2VFUk5UbG55?=
 =?utf-8?B?ZWY3eXJoQ0tLelVBYXJQY1NFNEJ2YmtBdU1PZ3FnMUNqUDhVSGV0MnROZFIv?=
 =?utf-8?B?SFNoTWdwNVZJQ0UxRTR2bkhiT2JpcVlSSGtPaVlqWUwwL1poMERQZENrSEhm?=
 =?utf-8?B?Si9hSFQwZnJTUXBqNVZENk4rT09yNmljQ1RLZ0NUcitCbVVrWVZrWUNwRzF0?=
 =?utf-8?B?clNzZkI0c0dyTVZqUkIzb1hUTGQ0U0pGV2ZwZjRMc09yWmZDR3NhdmhwMDEw?=
 =?utf-8?B?QmczWWRoK1ZZTmcxM0RkZ01LeFBKVE9BeDZkcmc1eFp1VUthbU1OcXZuYkhz?=
 =?utf-8?B?RHZNTC92RWpNcGFvOGptQ3psUHpRRldCWEJkUWVvaTdZTEdXekJxSDVYYzBJ?=
 =?utf-8?B?MUMydFg1OUdFa0R4WlpIWTZoN3YxMXVzMFpkc3UxTG9NdVVyYTIrdEtjQnVI?=
 =?utf-8?B?cmxFQmFuU1gzK0Uveitrbk9LeStxOHRrampoRG5wYkFiS3UwWHZCazdmNlhX?=
 =?utf-8?B?elpYbXNoUVhkakhkT1YxYVdobk9mSjQ3My9jMU9UaExTcS9hREQyR21pWkpQ?=
 =?utf-8?B?bGlnUHNpL3AzNmxwc3NkSStnWkU1VVIvdWFqL2xxOUYvN3hHbTdvd0RqWlh6?=
 =?utf-8?B?Q25ieVpNRGkzUUc1TjVtbTdZMnBFbkcvZzZyOXlWL0IxMGZPbmZTYnBwdkxv?=
 =?utf-8?B?bEowRUpvaHlpNzF0dU80bXNubGgraHRTTlJHcjhRUXBEYkd6cVpTeGU3eEcw?=
 =?utf-8?B?eURWcXdjc0VXQ3BvVUYrbVRDNldKUDA0OEJLVDB4LzJCblRJYkx4dEw5bkxU?=
 =?utf-8?B?dGdCaTVKc0JlK1hSR25IL0Eyb0tkdjU5L1pnS0FYeGxqdFMrYXh3bVlUTFFK?=
 =?utf-8?B?eC9FMHNkOWlhYVMrMkw5dnBoeHQvcCtRTDBWVmlwTDFDM3ZaWFNXZWFxOG9k?=
 =?utf-8?B?SUhRZW9iVmJzaitCQVhETzZBNUZhdnN0TjdqdEVyVFo0ck51Q2dQNGYwU1pQ?=
 =?utf-8?B?VHd5cUZyY0lkSFZZaDJ6UlhGekxNMEdrc2hIM0ttcG8vN0p0dmJsd1Nld0h1?=
 =?utf-8?B?d3drdkMxbEN0SFlHMDQ2a0RMREMzWVRHb1p0ZVRzc2k2d1BXZ1R0TE5XYkZK?=
 =?utf-8?B?UUxlWGJnWTM5VjQrMWR4UUpxWlhUaEREZDNpR1RhbjM5N0Z5cWNkZVFGRnNR?=
 =?utf-8?B?a0dhVCtYRUt6cUNPM2RMc3R5cXMvRW5KUVJoMC9selNvQkJFa0NuVE02eVlU?=
 =?utf-8?B?NE1aVjFTUlBwZ08zY3hXdjBwa1F0bkZRRlVPdWxka0NEelVMVjFiTmFGR0Jk?=
 =?utf-8?B?WktYVHRzQTVDOHZ0b0lKRUN0NmFkU0EwZk82UThCSU5DQVlpUzVlZEs3aFVa?=
 =?utf-8?B?eVY4WmMwZEFCcUpkYkdvL1hXRHoyVEpwcDFMVkk4SEl6LzM2Q1orblNnSS9l?=
 =?utf-8?B?ZTE2a2VkYlhoSVJnZ0M3RDY2dkZmUENRdzRha0NRRUI3cStmODZycFY5aVdp?=
 =?utf-8?B?NVhhK0syVzVJR2NaUUJnT3lKNWovN2RKRzRnWUI0OFpMVzBTeXF0QmU4UExC?=
 =?utf-8?B?TFBubU9GcXVPMzBNd0tLYWFsK0ZjSGlvR2tONTA4ckJmd29ydzJEamw3UldZ?=
 =?utf-8?B?NDJFNE0rUVgvNW5BVEhKa3FPUzRiQVpJMXFESGlhbzB3Z3FvOTAvaEZya3h1?=
 =?utf-8?B?Y1pGVUd3dTlTSVpBMjAzcVdTQWtSVXNxeVpURTgwUU1ZbmNLS09IaTNlL3Z5?=
 =?utf-8?B?anpQdnJ2b0lSMXJLWURDL0cwMGpjZlByVXBmcytjKzlvUWxnZzlnd0VPbDRN?=
 =?utf-8?B?T2tTQVBzemh0TU91UGlTSWNxVU1SNnFjSm1qYSsxSDg2OVM5dHcyTVl3bDI2?=
 =?utf-8?B?N0ZVZWlNQkVkdEpabC9uR3J4akx5dVJyT0FTaVducDIyS3ZaWWlYQ3VpN21F?=
 =?utf-8?B?d0dtdERqNUJFOVVTeWVaWlFsYm43YmRJOFNXVEZ1cFB3dWtpS1EyRGlWMVh2?=
 =?utf-8?B?KzFITUQyRm1lWEg3WWRveGVCUHk3d0JpOUFWVm9uWFVyYjZIdmRtYytGM0Zx?=
 =?utf-8?B?MEpBb280Qi82dndvbnJXOTlvM0NTcHlDWE1hLzNQcEJLbWpaRVRkalZ0M1Ew?=
 =?utf-8?Q?xh3YEYsU3yAYW6CT+1OrHM2uQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba772fa-aede-45ce-79f4-08ddde5e01d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 13:49:09.8175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGrOgUsUv2LB24GD5iDLERmvaXKvARVlD9hZQdhEqaxpBjp/zWZX1h0TXH9vQazd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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



On 18.08.25 15:48, Sunil Khatri wrote:
> Print PD address of VM root instead of GPU address in the debugfs.
> On modern GPU's this is what UMR tool expects in the registers
> as well.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 127091de0f34..a70651050acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2155,7 +2155,7 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
>  		return -EINVAL;
>  	}
>  
> -	seq_printf(m, "gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(fpriv->vm.root.bo));
> +	seq_printf(m, "pd_address: 0x%llx\n", amdgpu_gmc_pd_addr(fpriv->vm.root.bo));
>  	seq_printf(m, "max_pfn: 0x%llx\n", adev->vm_manager.max_pfn);
>  	seq_printf(m, "num_level: 0x%x\n", adev->vm_manager.num_level);
>  	seq_printf(m, "block_size: 0x%x\n", adev->vm_manager.block_size);

