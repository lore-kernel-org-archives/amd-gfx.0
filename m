Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2211EC02197
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB6F10E6D2;
	Tue,  4 Feb 2025 15:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7mBycbh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8159B10E6B2
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNHhrJKitG/gf8mVm2GQoSTh8B+Kv6+PqOQ2Uwl+jPZ8btfYZmVpP+WsgLuyDM0UsR7cqU9coID9WpLZ3nXZyxyAD+/ScUib7RQwfAgzddEML8CWDySfSHRICmBW1zcacc5UQdF/60sd/K/Z3rqfwhsmrVSVl+Rbg9Acv0BhBxpuZP8PB9aXDjiw5RNAYZX6N/6154hNtbazVY0yGUbzAq/XQ/xnOhaQfljN1wgS4JlXqBt9U1wZW09tGGe9NVwUx7fzVpv7e/fAtQYcLXjn6UlRJ1bPfLZX7bdwp/V6Mth5idStwJB4Z8lMmtTqP2nSkJ72qUQDG1VQiOGzZA+eTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YufEzgwupoIcTr0P7JYHV/XffMghBWktYAwdzl7Gsf4=;
 b=rQC3DW4obDWtQ51KuCGfhKgidMXvTyun9gye93z7UJRWzOqUWNik+LCyQfOQ/ea3k77QjttSsq43riBjYJ/venTIINou0lwKYESqHbsb7ht36+BMECA1U2XfjRozBI/2K4t//UbsyFHxKPsNDzbUjachVK7MWEMBzNo3zSgiHJ3PG3OMndV2mOwmE/ywoQiYSjIBsL4o2Nyx5cmTRJQqLZAFnYkCafSBGeWmqbAWKTg3Z5Ob31uvOAZneDZKYkVvEygn/0tMUGZwD1Zm+QCSeSPFPZgGRFLfFGsfRKXmoBQwviSWZAYmPpncBjca9+ACSg7h8S39sqZFMOoTcMfvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YufEzgwupoIcTr0P7JYHV/XffMghBWktYAwdzl7Gsf4=;
 b=K7mBycbh0OkQF98WdssUZpwe8zt/bY8yWSyddpbcJAqERnWT4ipUu7Yul4te5xExgDX65wdcydDbrzYcdqVW0gVzcL9Qh26wCTW3watTxNYryifXU1CRYKEp9WiTAMU3UWtDCEI1KWR8NjsUj5ctUwu/jeTdI/sjGUVSLROOm+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 15:51:34 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:51:33 +0000
Content-Type: multipart/alternative;
 boundary="------------bLQ6gq8VoMHg3rPbTiox5SMn"
Message-ID: <59a93be5-9833-41e3-969e-fc455d1cd9b7@amd.com>
Date: Tue, 4 Feb 2025 10:51:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/44] drm/amdgpu/vcn4.0.5: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-6-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-6-alexander.deucher@amd.com>
X-ClientProxiedBy: YQXP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::18) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e27a210-58fd-4d87-483f-08dd4533ccc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y08waXdwRUNCV0x1d0hNTWNsT3AvY3U3UUFVZERPRTJUY2VPUVE4eFR1cCtk?=
 =?utf-8?B?SUxNbHFORFpzSjlCbGR2Z2Rac3pnTk5rNVQ5OGJzVVlxUTQxanZpeEEwNnRy?=
 =?utf-8?B?bWt4aVhYbGNWS1lvTDNZZTFYYW9BUVYzZWxSWCtBT0RVV0Q0YVNnMVlLWElo?=
 =?utf-8?B?dmV6ZnRGL2x4RUhHRlhIemhXdjJuL1dNMGd0clhWaXpzdVlJUHdUUlhCdW0w?=
 =?utf-8?B?bm9ZaHhqVm9nbkZqTjRPNkk4c2dwbVBvdnZ1aTFuWENMckdaN3EwSWRKdldS?=
 =?utf-8?B?cGV4elRJbWhkT3FWUHZGdk0yVU9BdStjTFlHU0diVHJNSU9JY1NLSk5MODkz?=
 =?utf-8?B?T3VBSUxsYlpPQkplbGxyS1hOU2RKZ0xESExLRVJISHppSDZQNmVGbWZOZ0tV?=
 =?utf-8?B?bXlIZkczTm4xdXlQMzBVSnBzSmpsN29MbDFuMGpPOFdvZ0ZiWHhNN1g3ZWRj?=
 =?utf-8?B?Rnl6MGlyVHJEdnoybEVYSGJEM0pxRFRXUU40d0dKTi9GbmgyQlgyTmR0SkNF?=
 =?utf-8?B?SGVBUTRZaHNSSzlRUXpOL3FDR0RQMmJ3bEphUkZnc0szN2Jqa2VqaVBjMGdY?=
 =?utf-8?B?V1NyN3M0UmJjd3Z0Vm1VTW5yZlZ0eGtYYWVqYVphT0JCcTlBbURkMHM2ak5D?=
 =?utf-8?B?VjkzYVlhTDJFUWJnNldHWml1K2pXbUpnY1g4MDFzNldQaE5CT3RFOVd5c2JJ?=
 =?utf-8?B?SFIwREZXL3B1Y0ljQVhEeUp0YU1kejM4QVVzWVNwcXQ5QVJ4dFJ1RXowR1Va?=
 =?utf-8?B?bHJpZTFQc2pqYmJuVmpoNVJyMGhhbTNDSXNzOGVPTHc2ZXdwZXdIZWtmb0VY?=
 =?utf-8?B?blJhVHJmSXJYRmFzS0E2V1dhbzhaQ1FBaUpBNjZIbDVnY2tVN3RKMG9LOUVr?=
 =?utf-8?B?M0Z2YWdnREtFWElBU3phamVOZmo0V0dvWldTWlk3bGVHSUhIekFwSlp0WldJ?=
 =?utf-8?B?d29vYmJzYXNHUUlNL05BK2VET21QclIyaTd6SkFzOFJ4QXJyU3RwemVyblJS?=
 =?utf-8?B?UmxUMTA1TmtvMU1GOW1mcDBHOVIyMDEzdTZnODZtb21taEYrYWdlZjc2Mzlv?=
 =?utf-8?B?OU44dGNBQitwczFaTVhIUjJ1K1NocldWS0ZJSHU5NENvaTVtTjI1VTZuZ29m?=
 =?utf-8?B?QktWeC9xTFdSWktHZjJLUEVTVjI4YzE1c0h3NWxYclY0RjdFbzJOWk9BUHg3?=
 =?utf-8?B?WHNFSFFMSm9DWG9JbkVNcGZ6cmc2dnBJd2dyc2phQ0JmZGdSMHFrUFUzaU9Z?=
 =?utf-8?B?UHA3RUQzUGhTRDllVzZMRlZKazFFYlAxM3V2M2krV3NUR04yVzFWM1haaTQ2?=
 =?utf-8?B?aGV3NisvZGVVeGRpZ3ZpYXc1ZHhuZFlyRmpseVE0ckVMK3h2RmN2KzFpZjBQ?=
 =?utf-8?B?Q1M5cmRnS0Y1cUJNK0p1djlqOEhxY1NNZXAzZTBFUFdEQmNCWXdHaHFaNGJv?=
 =?utf-8?B?eW13b21HWHAxei8zV0pOaUptVVBveU9GME1iVFk4bWlva3NScVhtZWxLTTRV?=
 =?utf-8?B?Tkt1WWt6M2dmTWlqekJTRy83RitTZ0NtZlNybkp1blQ2ckd4OVdLdWVFd3RV?=
 =?utf-8?B?UXRteEtJbkxkM3ZzTm1IYytUbnR5SW16TWxMMTFKRE5yQW96QnpOMDIwbzE0?=
 =?utf-8?B?dVl6V3pKMlNweUdrZVYvKzg4L0R5RnFZUWNYNW80QlZ5c1B6TmY0M0FSMkU3?=
 =?utf-8?B?UVFucXNXSjVDUkN3bjRRd25ndTZvK1U4Z3lLNThNV0k0WU1DUFUrTHRtbEd4?=
 =?utf-8?B?Ni9xNTRibFd5bUNWNmZxOXFHZGRpTGh5ZytVNjZkV1lCWkRIRzdIaGppekhM?=
 =?utf-8?B?NExTRUc4L3lickNZWGhjenNHeVJBMzFYK01zSXhGNmdpQkdGY0d4eDBJaEhT?=
 =?utf-8?Q?GUAD2z4P6+OCf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhBZGhrd0ltbHR6djh4Y3piMjNXKzF5QkRmQS9USzRBampWUDh2STlqbG5D?=
 =?utf-8?B?dGc1Q1hWUFRPN0ZISERzT2lVRU0vWUoyNk05WnRKKzcxYWtUbDdDeWVaSmFC?=
 =?utf-8?B?SlYwVXE2WGl0L2NrTVE2M0p5bUx6WXZBQ3Azd2l6UVlONm1PTm1ZaFdOU1R1?=
 =?utf-8?B?OEN4SElTZXU5cXlnRTVUemIwNEI4L0I5YjdCNkdieU1XU0tmUEMwZWMrS0la?=
 =?utf-8?B?TTZETld2d2V3RFNPZmF6MDRVcm01N1ZZcE1DSDhGakZrVlEwV0hXU1ovdS8r?=
 =?utf-8?B?dys3REZCeml3eTVwbUZERjRzWjB4bFA4WmFsMzVUQmc3VGk4YnVPSGRvTlRY?=
 =?utf-8?B?WGxSSWVibXBFVEpVdlNyRU9mbTZvb203ODNPN0w4MFgyWGsvWSt2SjhDbVlH?=
 =?utf-8?B?eHpmRlZjOXQ1RFZ5V0tkTUZaZ1hXanNpV1creXpzOXRtbzFsZDNsUVVCQThH?=
 =?utf-8?B?YWVwYmNyQ21tYmd4MVNTaTBxUWF0K1ZhclluOU5BSzdqTUZVZ0ZVSld4UXRX?=
 =?utf-8?B?TytGM1RQQ3luV0RvcS9ySTlWZmdEWFltOGp1K2s4RFZ3TVF3WkZhcmJnOHl2?=
 =?utf-8?B?c05RRWxoR3hNdno2TnhiVWlOZ3duNTY4MHB3SisyLzd2a013ZGJ3c0ZkeHJz?=
 =?utf-8?B?SmpvSXB6STRaaU5TcTRvdCtJTEhHMGVBTjloc0JWTSsyajN0dTBLeU5XazJi?=
 =?utf-8?B?RmpIYVpDeXA5KzN4UmRXb3VnSXVaOTlFNzhvUWViMk5IWHk0RXdoVWRmekZD?=
 =?utf-8?B?U1hSMHdUeHEzV1NsN0QwdWZ6clowQVBjd0k1VS9scU5TVHVNVUplbksvd3Nv?=
 =?utf-8?B?MHpNOWhpNDlkYVVoa3B2U0JodjFaaE8rUDhmUEVlcFU1ME9tWEdpdzU2amVK?=
 =?utf-8?B?dWpqQklNQ0l6MGpyYVlkZTc1M2xhZHk4Rit5U2s4dTkvb3V3QTE2UlJIYkRX?=
 =?utf-8?B?YkxTbnpFT1ZnNGFOVENNbDgzcld3bkFEOWNBbGo1a0hwSEg0aG1IVm9TMVE3?=
 =?utf-8?B?a1c1TDl0UjVhSjZucW5PMmcwRzQ4ZHIrZ2xhczRZOG5EeHpSWVlneENyVnRy?=
 =?utf-8?B?RG1kZytQQWFnOHNtZEVSVFp6NVI4M3lIbHA0Q0w1MFJseEdwdXBPckNrZEVO?=
 =?utf-8?B?OTVJdG5IR3RRb1RVOHJxWncwYzhiMy9sR3BIYlh6MGJJR0t2Uks1SU9lbFJM?=
 =?utf-8?B?QyswNDJ0WUlXcXVyc1BwR3JkZytQWmNzNkg0UXg0WVVRdmViUnN1Q1hmVHhG?=
 =?utf-8?B?YjNCT0IrcjRlRW1HN3dXY2d2dGU5RVI1SEVZeWxoZWM3Um1uN3ZsMjBWRUtq?=
 =?utf-8?B?eHhWZnlHNHV6M1plRGx0WDkxWFhxMS8yUVMwVWx5SkJubE5RQWk4WGJSeC9R?=
 =?utf-8?B?eCtJclZnSW5KWldwMWNLUi8vV0VqQklCaGNpQmJKRHhoYTVlYjFhOXNZUEpY?=
 =?utf-8?B?MDVRMEJQZ1VyQU9SUFJKN08yN0I0OHhiWkRCZGp1KzFZVWxLTlRLcFFIVVFQ?=
 =?utf-8?B?azlkRjk2RWpOQXdwSmlPUHhLUENxKzdnekJBQjdTay9wY0VvaDZlOWFHd3hL?=
 =?utf-8?B?N1o5NUs0SStBd0R5QW0xUXFuMERHK2V6ZHAyZnlReW9BUzJEQ3pNZXgwRVpC?=
 =?utf-8?B?SEpGUGtJYXNnZ01sTERocUpFTzZ5ZXZzRVdESHZjUHR3RXczbU1TaVZKNVFN?=
 =?utf-8?B?T3E2Tm4xelNaY0FTVkVVdzNjbElGYVdPdC85Y2VZWk5lMFR4MUwrSzF6MjIz?=
 =?utf-8?B?WFh0TGhkc1lZMW4yMVpUZDNSSC94SHRGMEZPUWlDRXFoVXRocXJXQXVRQ0Zw?=
 =?utf-8?B?MVh1dmtyOVdJbEFBOS9GaUxCR01sZ1FkV2lxY0RIWjhKaC9ncERpTExocUdW?=
 =?utf-8?B?Q0Q1SDhKTU1haTVBVHBhRDBLL0MyMTJFWS9SSy83dzV4c25TT2lrVXNENnVG?=
 =?utf-8?B?bVk5aFdRQldFN2RXbmJtaGw5d3o0cnZxMEprSy9mVjQ3NjhVOTdaMmIxaWdQ?=
 =?utf-8?B?SStoYTdmRkNhdHFZaTRRMCtSYVZnOHkyL0ZKdGxHYmE0VTNuQkFyTXVldlVn?=
 =?utf-8?B?eTJKNmcwMFZXekZNTlA4WUZ6UmRmWkxkZEM3dFA5R0kvWFVuZkVGODJyRWhK?=
 =?utf-8?Q?8VCz4f4iprtK4XHnxTJjI/f8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e27a210-58fd-4d87-483f-08dd4533ccc1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:51:33.8961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRLUICIHrssNSHnMuBRVuFhLgKyuIFUq707VPmpAtgwv7sEG8dhYdM4TynTEKkd5rRKdxdFp7boKe7z0FNyfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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

--------------bLQ6gq8VoMHg3rPbTiox5SMn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 438 ++++++++++++------------
>   1 file changed, 216 insertions(+), 222 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 23d3c16c9d9f2..bf0da0da12512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -990,183 +990,178 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    * vcn_v4_0_5_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to start
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_5_start(struct amdgpu_device *adev)
> +static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		/* disable VCN power gating */
> -		vcn_v4_0_5_disable_static_power_gating(adev, i);
> -
> -		/* set VCN status busy */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> -
> -		/*SW clock gating */
> -		vcn_v4_0_5_disable_clock_gating(adev, i);
> -
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> -				~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> -				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -		/* setup regUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> -		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> -				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup regUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> -				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> -				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> -				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -		vcn_v4_0_5_mc_resume(adev, i);
> -
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> -				adev->gfx.config.gb_addr_config);
> -
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> -				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		for (j = 0; j < 10; ++j) {
> -			uint32_t status;
> -
> -			for (k = 0; k < 100; ++k) {
> -				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				mdelay(10);
> -				if (amdgpu_emu_mode == 1)
> -					msleep(1);
> -			}
> +	/* disable VCN power gating */
> +	vcn_v4_0_5_disable_static_power_gating(adev, i);
> +
> +	/* set VCN status busy */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
>   
> -			if (amdgpu_emu_mode == 1) {
> -				r = -1;
> -				if (status & 2) {
> -					r = 0;
> -					break;
> -				}
> -			} else {
> +	/* SW clock gating */
> +	vcn_v4_0_5_disable_clock_gating(adev, i);
> +
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +	/* setup regUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> +	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup regUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> +		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> +		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> +		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +	vcn_v4_0_5_mc_resume(adev, i);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (j = 0; j < 10; ++j) {
> +		uint32_t status;
> +
> +		for (k = 0; k < 100; ++k) {
> +			status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> +			if (status & 2)
> +				break;
> +			mdelay(10);
> +			if (amdgpu_emu_mode == 1)
> +				msleep(1);
> +		}
> +
> +		if (amdgpu_emu_mode == 1) {
> +			r = -1;
> +			if (status & 2) {
>   				r = 0;
> -				if (status & 2)
> -					break;
> -
> -				dev_err(adev->dev,
> -					"VCN[%d] is not responding, trying to reset VCPU!!!\n", i);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -							UVD_VCPU_CNTL__BLK_RST_MASK,
> -							~UVD_VCPU_CNTL__BLK_RST_MASK);
> -				mdelay(10);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -						~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -				mdelay(10);
> -				r = -1;
> +				break;
>   			}
> +		} else {
> +			r = 0;
> +			if (status & 2)
> +				break;
> +
> +			dev_err(adev->dev,
> +				"VCN[%d] is not responding, trying to reset VCPU!!!\n", i);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				 UVD_VCPU_CNTL__BLK_RST_MASK,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +			mdelay(10);
> +			r = -1;
>   		}
> +	}
>   
> -		if (r) {
> -			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> -			return r;
> -		}
> +	if (r) {
> +		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +		return r;
> +	}
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> -				UVD_MASTINT_EN__VCPU_EN_MASK,
> -				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> -				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> -				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -				VCN_RB1_DB_CTRL__EN_MASK);
> -
> -		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> -
> -		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> -		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> -
> -		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> -		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> -		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> -
> -		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> -	}
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> +		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +		     VCN_RB1_DB_CTRL__EN_MASK);
> +
> +	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +	WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> +	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> +
> +	tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> +	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> +	ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
> +	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>   
>   	return 0;
>   }
> @@ -1203,86 +1198,83 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_5_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to stop
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
> +static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int i, r = 0;
> +	int r = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			vcn_v4_0_5_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		vcn_v4_0_5_stop_dpg_mode(adev, i);
> +		return 0;
> +	}
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>   
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* disable LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* disable LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> -				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__BLK_RST_MASK,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -				~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -		/* apply soft reset */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +	/* apply soft reset */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
>   
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> +	/* clear status */
> +	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
>   
> -		/* apply HW clock gating */
> -		vcn_v4_0_5_enable_clock_gating(adev, i);
> +	/* apply HW clock gating */
> +	vcn_v4_0_5_enable_clock_gating(adev, i);
>   
> -		/* enable VCN power gating */
> -		vcn_v4_0_5_enable_static_power_gating(adev, i);
> -	}
> +	/* enable VCN power gating */
> +	vcn_v4_0_5_enable_static_power_gating(adev, i);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>   
>   	return 0;
>   }
> @@ -1536,15 +1528,17 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_5_stop(adev);
> -	else
> -		ret = vcn_v4_0_5_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v4_0_5_stop(adev, i);
> +		else
> +			ret |= vcn_v4_0_5_start(adev, i);
> +	}
>   
>   	if (!ret)
>   		adev->vcn.cur_state = state;
--------------bLQ6gq8VoMHg3rPbTiox5SMn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-6-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-6-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 438 ++++++++++++------------
 1 file changed, 216 insertions(+), 222 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 23d3c16c9d9f2..bf0da0da12512 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -990,183 +990,178 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  * vcn_v4_0_5_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to start
  *
  * Start VCN block
  */
-static int vcn_v4_0_5_start(struct amdgpu_device *adev)
+static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_5_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v4_0_5_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		/* disable VCN power gating */
-		vcn_v4_0_5_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_5_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
-		tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
-				((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-				 (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-				 (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-				 (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
-				((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-				 (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-				 (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-				 (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
-				((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
-				 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
-				 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_5_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-				adev-&gt;gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j &lt; 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k &lt; 100; ++k) {
-				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				mdelay(10);
-				if (amdgpu_emu_mode == 1)
-					msleep(1);
-			}
+	/* disable VCN power gating */
+	vcn_v4_0_5_disable_static_power_gating(adev, i);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status &amp; 2) {
-					r = 0;
-					break;
-				}
-			} else {
+	/* SW clock gating */
+	vcn_v4_0_5_disable_clock_gating(adev, i);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
+	tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
+		     ((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_5_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j &lt; 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k &lt; 100; ++k) {
+			status = RREG32_SOC15(VCN, i, regUVD_STATUS);
+			if (status &amp; 2)
+				break;
+			mdelay(10);
+			if (amdgpu_emu_mode == 1)
+				msleep(1);
+		}
+
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status &amp; 2) {
 				r = 0;
-				if (status &amp; 2)
-					break;
-
-				dev_err(adev-&gt;dev,
-					&quot;VCN[%d] is not responding, trying to reset VCPU!!!\n&quot;, i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-						~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-				mdelay(10);
-				r = -1;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status &amp; 2)
+				break;
+
+			dev_err(adev-&gt;dev,
+				&quot;VCN[%d] is not responding, trying to reset VCPU!!!\n&quot;, i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		if (r) {
-			dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
-			return r;
-		}
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-				~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-				ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB1_DB_CTRL__EN_MASK);
-
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
-		ring-&gt;wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-	}
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
+		     ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
+	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
+	ring-&gt;wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	return 0;
 }
@@ -1203,86 +1198,83 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_5_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to stop
  *
  * Stop VCN block
  */
-static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_5_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_5_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
-				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v4_0_5_enable_clock_gating(adev, i);
+	/* apply HW clock gating */
+	vcn_v4_0_5_enable_clock_gating(adev, i);
 
-		/* enable VCN power gating */
-		vcn_v4_0_5_enable_static_power_gating(adev, i);
-	}
+	/* enable VCN power gating */
+	vcn_v4_0_5_enable_static_power_gating(adev, i);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1536,15 +1528,17 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_5_stop(adev);
-	else
-		ret = vcn_v4_0_5_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v4_0_5_stop(adev, i);
+		else
+			ret |= vcn_v4_0_5_start(adev, i);
+	}
 
 	if (!ret)
 		adev-&gt;vcn.cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------bLQ6gq8VoMHg3rPbTiox5SMn--
