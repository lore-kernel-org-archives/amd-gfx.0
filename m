Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74ECD4F28
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 06:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1EE10E0EC;
	Thu, 13 Nov 2025 06:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Liysx/1p";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C41B10E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNdYJ1qQEhAXnw2WgHpaUKIkUKNV2xV3RSHbyaEYYvGmHFEQO8O81yJvM9idn0RLinHrxFPQZckLGl18jmzGdfARqctm7dTYrNjYpSG/LZHL2acSmKjxGgB0lSHmWA8t3AKaAp5s/sCMFSKRrLly9bH2V+mYCSSahBNf3+1qwY/GjDY+dncpKQ49idY3OaHRFKtgLmva3yBIUxIrLJIX0na/e5vQpLgcR3XWZZZUF3su7lztNSPJuBDs4VdpyCl2AcU1ouat4fpyXBhRKUU+lY46YReP3bf8hCz4hfM7KYPwKYTcJFKQj+Wd+5SDRZ4P6FdcrvkDuWp1lV1GzXKaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGS5LDL+P1pvi/lsv28fsP/wlHv+9S3LTPB30DqRl8s=;
 b=UEVfZdLP5f5GtV50ncP6m5vW7T5CUaCbziKqCz0/7pz7/xLXHnJEN7agNRFcRvERWiaDs6ps6Yk8cCjasrVBEIUc4TGRiKVBmxZbQZw/UhfZWZ62Ul6f44svnWUkJwR/731HtXQSzHlV2K1vU8JzC+feuXwGp4dlVhdpstDW5ph4ZvujTqrU/NFNAJwBqIi6MI39oqZ7eBa5diCkPajPO7IE1AoZgRrFP88USmVL0ihMWfTXd/8Kpqy7eRPFtaKHn7g0OsSYqMgj9SByzqTvo8jPgql8EHQoTpXo0RaXRIUb9TnbFhoZXPyi1yF0BUOsEzc/C3n7ZcJprMVpvN7kfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGS5LDL+P1pvi/lsv28fsP/wlHv+9S3LTPB30DqRl8s=;
 b=Liysx/1pd7YDfWMVZXIxECH3oA8K8hYm3AB8GQ6O4uNLpp9vWcpfljybTjAOVpSALfI/Ykwj8rmJT75jDKagEqEJdamNbrLQkFiBnyosT6DnY9gs6R7GILWPlPE1bf3Rufxov+SEeY3wrIk+KG5eFfJpdy1Sts7PeI08TVjw83w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 06:30:41 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 06:30:41 +0000
Message-ID: <0bd34547-e444-4037-a46c-0ff2975813d5@amd.com>
Date: Thu, 13 Nov 2025 12:00:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amd/pm: Add sysfs node for ubb power
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251112152815.203110-1-asad.kamal@amd.com>
 <20251112152815.203110-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251112152815.203110-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0547d08c-34d2-4265-6c5b-08de227e2ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sk1NdkwzTC8zeFZObDVlSVNYdmJmTTJnT2dkaHJ2NTFPbDk2YTlFZ3VCVURX?=
 =?utf-8?B?ck5weTRvUWdSSnErb1pmc3M0dTM0b0JVWWRoemcrV1pwUGEycmhiMnFiUzF5?=
 =?utf-8?B?cDMxUXJ5RjdhQlZBcWlkQnNEYlZQSkErZDZlSHBma1VWZGlaRzlSQ0gwOG9z?=
 =?utf-8?B?eVFVRFlEMU1VKzZlb1NtRlBzOWxCcmVTdmdOdnc3b2ZQcHJjSXFtcnZXdnVU?=
 =?utf-8?B?ZGpUbUNXd1dCeDJKQnVyTFBZc1pqdDFMTEE1d1pVYW12NVVsOGdZOGpPYW5m?=
 =?utf-8?B?SlhqVElqUGlKd2R0a1ZHRUx6Y2pXRXhic3FEbTVLeEEvUldTODhVcmswWDA5?=
 =?utf-8?B?bEZ5WnFvSUpjZWVtUTdqemh1eG8zcUxkank0OC9tTGp5YkNZUkgzSE1WNkV2?=
 =?utf-8?B?VVVwWWZjMDUyZm9RQ2JoejJkZHg2NzFRWW9kK25GMXhFUFplN1NjdkVtQ3Zt?=
 =?utf-8?B?Wkhtb1BZT1BMdHptSDVTbDJhbDByN2VkL21WZFJSM0hsQ0g1bGpORDJENDhp?=
 =?utf-8?B?MHJBM2ltbGdZOE1SV2o0QllFbXNWUnpBa3JOSSt1QUlEZ1Y3eDNrckZEYXlC?=
 =?utf-8?B?MGNSb05jNndCcVY5NlhzMnZ0Ymh4cUt6U283enZ0QnMxdytFajUySHgzRE5R?=
 =?utf-8?B?RzVXMDFLVXRuQUhXRTgrcW1pcG9TQnArK2JWczZReGFuRm0rMHZtKzlCclRB?=
 =?utf-8?B?d2JFclE4ck5Mbmx3eEp5VzVua3FGQkl5YUJPUkV1M3ZKWHZNeWNaVEEyK2ky?=
 =?utf-8?B?K0ZnbElGaDZHRnNiYk5aUjBWZXFpUXBTaEhPMHAyQ0JBVDJDS2JDaE9xUDFE?=
 =?utf-8?B?c1l0VlJPUFRVM0VFNEpEOFlVRnhobjJLWGRTZXNTNmRMbXBBaGdmcjNEZ1ZF?=
 =?utf-8?B?QUo5NllhQnVPRlZTYVhVQkJWbGJES216SnkxRWFmZHR6TE1LS013eExrdzFj?=
 =?utf-8?B?NkFrdFlwQ0xwdk1uS2ZyUlRDWmQzVFd1bFpFTkc1OHo2dEF3SktXS0tFSmFI?=
 =?utf-8?B?UXRPK1R3Z2NmZ00yckdoOVJnWklhWUlHbmNEQXc4UHZWZUhtSXkza0FWR1Fi?=
 =?utf-8?B?dG1JSGhwdjVNT0JLNjlrM1JpVnE5RjJYMFFKRjNhdWYxb3YxUmtmTDE2VlZR?=
 =?utf-8?B?UUNKbVNGWmFWUzAvMFQ4T21NQWlrK0s2M1Z0cTlnUjlSZ3RSQTlBUlhjaUZR?=
 =?utf-8?B?b0lsaTZZUUNicTQzek1nay9SZUNtT21hMy9md3RQanZMbk1lbG9DenNYQjVS?=
 =?utf-8?B?R1d5QU5iYlhIQlFiRUMwN3k0UHBnMnlwM3ZXbSswOEhRYU1BcnpzMU1kTFVn?=
 =?utf-8?B?SUJMbVBUL0VWVnJHbENCZFZUbXdWTFFqcE9UYlBRVHp4cFRzci9sNGpYKzkw?=
 =?utf-8?B?U2Q2VVpQdThLNS9ITXE4Z1M4YUtOYTE3MU8zaFZaelZZa2hzejVnYVRrRml1?=
 =?utf-8?B?aVM4bmh6UzgrZHBwQzRhT0pQVlowbU52S3JvNUVmeklRRXk2NkdpZ3ZnV1BO?=
 =?utf-8?B?TlpIdURPS0xBL2t3M2pTbjh1djc4OExUeURGTFpjQlRZVkVaeHI0VkRNNFdu?=
 =?utf-8?B?QmNZNTVxeWJpZHd1TlJUQkVQTkFKOTVHS0hhTmZRcUIrUG84d2NSUzFFZklk?=
 =?utf-8?B?TW8zRmw3Vm5rSlNrUE5tbWxsSG9CTUVjZVRDRVBEMGhXYnFYTGlUNzJiV1FC?=
 =?utf-8?B?NllXVDFaa1d2Wi9rZVdMeUlMcU9hMFI1WVNhVDEwbjVTZXdMWTRtS3BvQmF1?=
 =?utf-8?B?dnJlT0kvalRvK0dpK01kSlkrY0lFUk5TOHZFdGNqaTd1ZlMxS0VhWmljenBt?=
 =?utf-8?B?R2pQbEZKMFN5U2EyM05SeENwT2ZScDBYeENoRlIyUHJLNU9NbmpWazVqT3ZV?=
 =?utf-8?B?WGN4TFRwSnNUdTRQQXhHV2RzQkpDNmphTGdUNGlBTE1lY0tGY3BRYU84TWhu?=
 =?utf-8?Q?7yliMNhdSmz5jZIKDRvOTrZYE6a8ibdF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURCeXdCTFBybklMTC9oTUlKVjNDMytGVzRBOFRvMnBLUTVWWkpibko5aDRX?=
 =?utf-8?B?THdkRDRGWWI5dEppSDNmWlFpUTNrbHphVEt2TXlDZ0JMZE04Nnc2QkpDL0dq?=
 =?utf-8?B?NHVVY2xTQklGbFZSaGs2WWpzUlQ5N29GUnRnR1JvUE9meXBJeCtBMU51SWg0?=
 =?utf-8?B?V2xqWUs2NkQwMUFOYUdKSGh6ckdBUkpDd21KR2VXUzZwRUdZZUJGUFlBc0V5?=
 =?utf-8?B?VEpRMnBtRFhHSERMV1BrQ3BoTW9ML3VsVGtka1dURjJnK1JxRWwxTzlxNTZ3?=
 =?utf-8?B?SXY5MmFaRjczQ1BkZkRtRGY2VGNrN2pldnpmVzZ4UUlhdDcyRGd1NzJSQ0lp?=
 =?utf-8?B?T0JGRUVObDYyd0x5SmZtNmNmeGlXdWgrYzhCRUlJNDRDV1QvS2ZPNnpxcUp5?=
 =?utf-8?B?YVI3S1pJR3lEczVSZmpiMnYzS2QzVGgrVHhVVmRadzBGTkNrYlVqK2xDdlZi?=
 =?utf-8?B?c2tFVDRlNW9wd3VjemRqTjg0NHZQdytiMktvMU1iSTk4TjMwN3lnV2w3dmpj?=
 =?utf-8?B?WGtNNTRnTk9kSXZPT2syWFgvNk5VVFBtZTJuZWhqY1J4MXBsUFE1OWVUOWkw?=
 =?utf-8?B?SU1KcW93RUxOMXRZUXZsa090S3ZLVVlkOEJwS0JIT0hCcTRJYlk5azljdzFt?=
 =?utf-8?B?d2ZmWXlheGJIblJNL04zZVNzRUJkelZLVWd3Sk5iNzk3U29NeHhZR0lpNi9a?=
 =?utf-8?B?Vk5rR1JHOHh5bnB1NHFQeW1hTXYvOUJjVWU3S3pIUk8yN2FXZkQxZlFVQ2xE?=
 =?utf-8?B?blNVVzhyYTlxUExoMHdxbEhFTndtUkN0VktFaGhQT0FnOEh6SlVraDdhUWFa?=
 =?utf-8?B?M0xHY0Y5bFl3bEg2RVJCK21wVDFaNStWcFZwc0lkVlBQZmxoT3VGcWlmU0t1?=
 =?utf-8?B?ZjBEZ2tsYmZRZjQwMHQ5czJiS2l5L0I3NWFYRjJIY1NlNVgyVDlBeTc2SjlW?=
 =?utf-8?B?WWhJbllYd1E4SlJQMU5Eb2FDbTZGVmhHblozazExaDZUQnhmcW13L1dqa0wr?=
 =?utf-8?B?bDFGd09DU29mRXAzOFdIREd4QjhHblE4WmFWTFBkc1FGWkwrT3Q3SFBhQlpN?=
 =?utf-8?B?cHBpVkVnMUt5WjZlOTdGL1lDTElMTVE2cmdEQThROVJOR29jd3lHSkZyN2hp?=
 =?utf-8?B?TGxtYzl6L2tFYnhnWFd5dXdLcDU5VU5XZTBBcUQyODFSb3RCcndmU2k2dllF?=
 =?utf-8?B?bkdYUndzWGxKUWFqbERhWTdEYVd6K2xrb1VTNnNjaERxcHNDODRDZVVvYmNQ?=
 =?utf-8?B?c3hqN0ZUVTBZZXdLbElydHRtUWJwdGRqOXhSd1IrM1R2UEUrTlU2S0tDdEJX?=
 =?utf-8?B?dUo0QUpzN2FVQjlzU09NQUR6VTVzNlVQcUJ1dno3bXg4MkJValp1alVyeUFQ?=
 =?utf-8?B?OU50bldsRW40dVFQMFpzVERpMVpKc1BJQ2s3ajJZVjhIVm96NXpNN0N0Z0Fh?=
 =?utf-8?B?TEFlYTdjY1RmZGtRZEpWV3I1dkhxbVFiRzRLbnRmeC9zS2pudzlWREVwbHUy?=
 =?utf-8?B?TFl1eVlPOHBxMUNlN25Yb1IvS01kL0l2cUVhaGpFcENzVkU4L0s5TEZTUWF1?=
 =?utf-8?B?M0swMnBzZlU4QXgxb1lWNXdUbmt3czh2cTZ2OWlhWDkySTRVUjQreTYvaWR2?=
 =?utf-8?B?R01BVXRaZkxET2d0cCs2U1FiMUpjZDRSWHFHK3dvbjk1aG5mUHVPZEEzODFM?=
 =?utf-8?B?dEZVb2Y3VHV0TWp0Q2o4MVZXcjFZQWdPQzZhajdOWkhZUnlwQUNKN0hZQ0hX?=
 =?utf-8?B?bTIzc3Y4YWRNYWgySS9uU1dKdGNkUHVPeHlTQ1ZaaXhNRDZNVjJDOEFSMFVO?=
 =?utf-8?B?VmJSK1pwd0N0K1JxeVBYWXBoVGdocjFEWFVJeC8ybjdKbHZDbWkxRWNlTmg5?=
 =?utf-8?B?WXdEY0lwMFhaQUhINGc1Vmsxcy9FV2dWMFZzSDRIY0pzcFR1MEdUaHBvOGNl?=
 =?utf-8?B?aXpsV3RkMjRYNnE3b1R2YTlFRlJBaUY0ZytrdU1ORnVSUkFXcS9jaC9pZzdG?=
 =?utf-8?B?TEdqeElaWGxuS2Q0Zkp4RUlMbVVNRzhIVGs4YzJEd0VLSG9VbEI3RjNEcXhO?=
 =?utf-8?B?cFlDa3VvazRLT1FpMTEwSlVHTmNDWFl5L0JTT3ZxcGcvd0NCWEpWbldDNjZV?=
 =?utf-8?Q?fk+LM/l5oOiBGbzqRZRfdsXLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0547d08c-34d2-4265-6c5b-08de227e2ac3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 06:30:41.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkwFoPgXWR/R/irrJK/ppB20ICoBQuA7MX4z89KzdxK2A98PBKCHTQI9ql56fV8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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



On 11/12/2025 8:58 PM, Asad Kamal wrote:
> Add sysfs node to expose ubb power limit for smu_v13_0_12
> 
> v2: Update sysfs node name to baseboard_power & baseboard_power_limit to
> make it consistent with other node names (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 65 ++++++++++++++++++-
>   2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 2366e68262e6..92477120c28d 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -166,6 +166,8 @@ enum amd_pp_sensors {
>   	AMDGPU_PP_SENSOR_NODEPOWER,
>   	AMDGPU_PP_SENSOR_GPPTRESIDENCY,
>   	AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
> +	AMDGPU_PP_SENSOR_UBB_POWER,
> +	AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
>   };
>   
>   enum amd_pp_task {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d9e37fd6e186..1efa08771361 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2082,9 +2082,10 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>    * for user application to monitor various board reated attributes.
>    *
>    * The amdgpu driver provides a sysfs API for reporting board attributes. Presently,
> - * seven types of attributes are reported. Baseboard temperature and
> + * nine types of attributes are reported. Baseboard temperature and
>    * gpu board temperature are reported as binary files. Npm status, current node power limit,
> - * max node power limit, node power and global ppt residency is reported as ASCII text file.
> + * max node power limit, node power, global ppt residency, baseboard_power, baseboard_power_limit
> + * is reported as ASCII text file.
>    *
>    * * .. code-block:: console
>    *
> @@ -2101,6 +2102,10 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>    *      hexdump /sys/bus/pci/devices/.../board/node_power
>    *
>    *      hexdump /sys/bus/pci/devices/.../board/global_ppt_resid
> + *
> + *      hexdump /sys/bus/pci/devices/.../board/baseboard_power
> + *
> + *      hexdump /sys/bus/pci/devices/.../board/baseboard_power_limit
>    */
>   
>   /**
> @@ -2295,6 +2300,52 @@ static ssize_t amdgpu_show_max_node_power_limit(struct device *dev,
>   	return sysfs_emit(buf, "%u\n", max_nplimit);
>   }
>   
> +/**
> + * DOC: baseboard_power
> + *
> + * The amdgpu driver provides a sysfs API for retrieving current ubb power.
> + * The file baseboard_power is used for this.
> + */

Please also update the unit for both (W/kW/mW etc.).

Thanks,
Lijo

> +static ssize_t amdgpu_show_baseboard_power(struct device *dev,
> +					   struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	u32 ubbpower;
> +	int r;
> +
> +	/* get the node power */
> +	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER,
> +					 (void *)&ubbpower);
> +	if (r)
> +		return r;
> +
> +	return sysfs_emit(buf, "%u\n", ubbpower);
> +}
> +
> +/**
> + * DOC: baseboard_power_limit
> + *
> + * The amdgpu driver provides a sysfs API for retrieving threshold ubb power.
> + * The file baseboard_power_limit is used for this.
> + */
> +static ssize_t amdgpu_show_baseboard_power_limit(struct device *dev,
> +						 struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	u32 ubbpowerlimit;
> +	int r;
> +
> +	/* get the node power */
> +	r = amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
> +					 (void *)&ubbpowerlimit);
> +	if (r)
> +		return r;
> +
> +	return sysfs_emit(buf, "%u\n", ubbpowerlimit);
> +}
> +
>   static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
>   static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
>   static DEVICE_ATTR(cur_node_power_limit, 0444, amdgpu_show_cur_node_power_limit, NULL);
> @@ -2302,6 +2353,8 @@ static DEVICE_ATTR(node_power, 0444, amdgpu_show_node_power, NULL);
>   static DEVICE_ATTR(global_ppt_resid, 0444, amdgpu_show_global_ppt_resid, NULL);
>   static DEVICE_ATTR(max_node_power_limit, 0444, amdgpu_show_max_node_power_limit, NULL);
>   static DEVICE_ATTR(npm_status, 0444, amdgpu_show_npm_status, NULL);
> +static DEVICE_ATTR(baseboard_power, 0444, amdgpu_show_baseboard_power, NULL);
> +static DEVICE_ATTR(baseboard_power_limit, 0444, amdgpu_show_baseboard_power_limit, NULL);
>   
>   static struct attribute *board_attrs[] = {
>   	&dev_attr_baseboard_temp.attr,
> @@ -4748,6 +4801,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_npm_status.attr,
>   						amdgpu_board_attr_group.name);
>   		}
> +		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
> +						 (void *)&tmp) != -EOPNOTSUPP) {
> +			sysfs_add_file_to_group(&adev->dev->kobj,
> +						&dev_attr_baseboard_power_limit.attr,
> +						amdgpu_board_attr_group.name);
> +			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_baseboard_power.attr,
> +						amdgpu_board_attr_group.name);
> +		}
>   	}
>   
>   	adev->pm.sysfs_initialized = true;

