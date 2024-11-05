Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57BD12680
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 11:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5647310E0DE;
	Tue,  5 Nov 2024 11:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mG0mYtDP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8291210E0DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 11:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD1StUW7tq1bCoTaR1VdQgE5jlKR5kvVFLUcCdsLNPhMwU5JzgvPwHJcvvKG52yxzcH97MCou5ydeB55VPk/YiT159Nffhn71Ms0CT+qd5FgGUWPqKugUyKGIdOE3BQvFfMwAdHzJKelDTMzOPoNEBeFXEnxSRZfP8ommODISeKKboP1ilF7FuT9tLytVKnqdAYY+AwIi3rpW9eXe+iqceru7H20A+vtFtD3aPOem+LWIRPzi/S7V0ArUXDkX7Y2a/UaYlHavy/bbH68l+/KhKMemx1B4WPS3vcq1375GJy1rLW+3n9saebowyUZ6D+CpSG2yhqMHvgnan/SWDYqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mtHwZaKnmDZhFNOke98DRNdyaElhN/S47AucYlSfik=;
 b=hP2mwiDBKwxeUoERa4Y6zkBb0dfvFoBA/a9WRU+rkBetDQotYlxjhBIgXJfLuqYMnUjw/Ty3QFXrZ/UwJDVHzKW+cv8XlStg95Qeb3YFnNETDvryUbNtXKhiqimbg6DvGmuxGr2TWex/pzOzLWLDch7sse/k28udthtFrqqH3tw1eKq2q33YnrQLd76k2KWbSC7QSn1Wu2iYv3m+C6/Tdwzsg2Wu4lyo1jsedK1FcorGL+R2jojhKvVHORfwWG5vkPcVvDpXxkIAnXUADELfEzM32Hab5jjZvxPiQZrtlE4/vGgJlIIwGbFqCv950jeHc9qbhNJG+nzIJUVSl7ZAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mtHwZaKnmDZhFNOke98DRNdyaElhN/S47AucYlSfik=;
 b=mG0mYtDPGMgs7+Flu24Rz7m7vm70M2BHHgxwRhwmjmTsl7jw46ktHwt7GSktcuvp7efy28ugBcf4+HpX6e+l8W4RBnVpCKYZlTSIFJ/9iLgnlzQ6qqilRh1hW4v/rgsI4AE2Ztil44qmddvn9rjq5V+6/IWLxnWE6Ldm5QaViSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 11:02:42 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 11:02:36 +0000
Message-ID: <cd323a2f-451e-4d9c-a1a7-f82036430e3a@amd.com>
Date: Tue, 5 Nov 2024 16:32:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add supported NPS modes node
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
Cc: le.ma@amd.com, shiwu.zhang@amd.com, charis.poag@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com
References: <20241105105229.863776-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241105105229.863776-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 075fd411-51ae-4578-4b53-08dcfd895af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk5iNldvOUpQeXJ1a0JQSXk4cG9ZZkxsTmE0amtJaVdyWXpoTyt2Y0E0VVhL?=
 =?utf-8?B?V0FiRHIwblRCNDhxYlpJampFYTR6K0RTeEYzWkhCMnRPYS9XWm04eENTcFpm?=
 =?utf-8?B?RFhzQVJmM3VuYmF2WHdsUmdvMlZZRmJ1Mjd5ZFV4anZONk0yU0dMRjlTQjlt?=
 =?utf-8?B?OEJBRzZtejZrT1h0OUQ0bnFPZjBSZ3d2Y0c4U3Jpc21LeWZobnJScTlyRXdr?=
 =?utf-8?B?SDUvSmNXbjJYT0JpeTJ1aHNNYmxmbkp1YXRUVzZyNklyaURVQ21hTWZxb0Za?=
 =?utf-8?B?cGRsVzh2c29jMHNsUU5BamJuT29ocmg1UnZ2MUIxaXE2aVBCY2dWYjlsZTVP?=
 =?utf-8?B?amVONU1LYTBkVS84ZldhM2N5YldaNUo3eU84SmZxdFZpSVp6NGFsYnJ5cTdY?=
 =?utf-8?B?dVV0SEdITi94YXhUdlFSR2ZTOEpBdWVwZk5PdFpoSnFGdC90NCtrdUdVQTBo?=
 =?utf-8?B?UjFMQ2RrS0FJYUFvalVqS2pzQ3pteEE5aXNvN3FMZVdBU0x2S1poNlh0SE5W?=
 =?utf-8?B?djJJOVoydTJLbTJDYjdSSldIR2JPaVVxUktYY3FYUHhGVmtyK01yR21NVXJa?=
 =?utf-8?B?SHlPUTR5NHFmMHY0R2pCek1JRkV4YWJ0KzdJNGg0L3JzcmRRcXZySHlMS202?=
 =?utf-8?B?QVBMM3VsNHJHWVJJNHRMT29DYkhWdndkYjVUWHIrdXIyNEtXbHRYTXdWQjMv?=
 =?utf-8?B?eEhYV21qemIvcHozNStHZUdSekZGNnBxRktNUnMyZWhlYnE4WjZaMEZoUU5D?=
 =?utf-8?B?N2lQTnpEemJHc3QwN3RQYTN3MGlITVJtOVRUalJsdHlMckxxN3FlTHk0amxH?=
 =?utf-8?B?d0NhNnRxWFoxUlhjb011bXdUdXl3U2hQekpwZi84SGVTMmU4Y3EySllHaGJE?=
 =?utf-8?B?Y2lZWVF0SDBTVmZvV0FGTCs5cDBVUTZVR1BnVE9wblJ6SWNOUWtyNEI4L3JG?=
 =?utf-8?B?d1ZuZnZGMHFyWnJiQ0xRamErYldObzQ4YW92QWUxQzRYbWp6ejBLTE1SWHV1?=
 =?utf-8?B?SHdNMC9ncXl1V2dteVN2dEtydFpzWERQeG1hNDVhT200U2lFdXJ2MUZLVVh2?=
 =?utf-8?B?UnUrMkxoREJ3NENYMjRHc3JNeGFJbVh5eW16OGF3S3JOeHE0WEVHS1NEMWRY?=
 =?utf-8?B?eEFrZUU1eWFiVHFVamFXZ3NjRXl3bldOY0RXQ2xndXVXL2tERlJ4Nm5HeHI0?=
 =?utf-8?B?Q0VBdEpwb0lEWTEzY01kRHlnNzM2MWNoRXdOdFlSRkp3bGxnOEdPWFZZcEZE?=
 =?utf-8?B?Ny9JZnNuMlM5dE40clk2aFNtTmllTkJSNC9GNERaeWxFZTdGb0Jnd0NOMTBx?=
 =?utf-8?B?VGNOUXJVNm9ySjJUMDFJZmtnQmtSREx0bDh1QzFaSkpQb243cTJGRHFVT0Zp?=
 =?utf-8?B?Wm9QZjZQY0J2Y0E0WFZKOTgrYjdOTWw5dHJLOG0wV1d6NDVTaVBTUzlqMXd6?=
 =?utf-8?B?SUpHNlY5ZEpGQk15Y0xUT25Ud2hadmdockNCd1dBOUt2VHdZaS81a3AvOFBL?=
 =?utf-8?B?dXpnc3BSdkVra2VBc1RFTW5OSVFQUEptbjNEb1dKT2pqRXRvWUViZERGYlNm?=
 =?utf-8?B?WCs5dGFrZk5UTmphRnRuMk5PdlBhdDJQSFhLSjdDR1Q4ZCtRcHhmcVhJazBU?=
 =?utf-8?B?WGJPSUJrMXk0YWVXTUF0TUMwcVExOHFkUWNhR2gyc1JBbVBTOVdBQmhIVXQ4?=
 =?utf-8?B?WUNaZ2IyTFZwYUx6SExRZ1N4VFltaWkxeUdRbFZSc1MxK2hoanFNVUdNMXQz?=
 =?utf-8?Q?PCk9phj+/oal+ouAFb/GMZ4+5sePrH8fTvZWIGQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUYyZmFlMlY5dXVCY3VDcXIvMS9RMVNrWk0zaGtua0NVVXIzblJ6Y0h0L3Nv?=
 =?utf-8?B?QkM3QkVYSTJZNWNGKzhsdTcvYkFLaXpBZGpZekl1SEJQUzQwWkt1aEhCMmNZ?=
 =?utf-8?B?VitGOUVud015MHJYUHhxSHJqcFdlOGF1bVd5WmhwVVJjQmpkZEV5b21FTzhG?=
 =?utf-8?B?UUF0bzJiQjlTdGdCcWtvbTF6UjFNdXJRYURCYWllTmxWWkMvVHZyZTNBSGhv?=
 =?utf-8?B?SXIrUDRPMktxRnVnb3MzYVZXcTZuUWxiV2ZzenRVb3VSSHNBSVVwQ2h1dGgy?=
 =?utf-8?B?WnRFdk5ORnp1QlRNZ245VXh1SzVIc0xhRE9QNld5OGlmTDVZNUhRWDhWZmJi?=
 =?utf-8?B?RTJNMmwzMmk4dlVGT2V0QmRkRjg2MmtWeEhmNjIxbFprbENnc3dIV2lQbVdy?=
 =?utf-8?B?cUpIcEpEQ0xmZExNaGw0MFNFTnV4Rlp5UDY2MWkyYkVLQXgrVkt6TjYwSU1Z?=
 =?utf-8?B?dnlKL0hsMFpBdmJWV001U25oMUROTklMU3ozQXhaYzVhZW5uMjJBNWtHWGE5?=
 =?utf-8?B?UTMxTlcxa1NxVVJwMG9CYi9McTY2cjdpbkFtRnJyKy9GOERXV3R0b2hQZ2lO?=
 =?utf-8?B?V0M2ZnBtTjFCVXY5cXMyekVwTXgwMWRPVCs3WVlVcmxxRzVRNGsxeUtyYzRB?=
 =?utf-8?B?bCtndTFrS0Y5TlhBQXBMZzZaZ2hDbjFMem43Q2EzVkZCQ2hEQktqYytkUUE3?=
 =?utf-8?B?NUtXS2p2Z1JvME1obDIwenA2SUtpV09FSmM3U3R4NThMcmxNK3ZDdDE2aFFs?=
 =?utf-8?B?YXd1TUZWRU5OZTVScVBUTmNlSnhnN1J1cDc5elo4MkNISjlYbGdnUlRtOUpV?=
 =?utf-8?B?QjhYSmV1Nk9RVWhmUGFaeUs3VWRRYzZ1SFZNeUtTaTVodEE4bUl1R2F6ejdH?=
 =?utf-8?B?eTVMMC84V2xCNDhEK25RaS9MRk1uTEx2R3hEMStOVlJsS01ramZnQTVWNlNN?=
 =?utf-8?B?eklTcXFNQlRVcnN1eTcwcGtqT1hMS0hQRDBwVzdQb3VqK3lyRFMvbTV4bHRt?=
 =?utf-8?B?MEtZYkdNQWUrV1BiSW5pMER1KzlBcXhPRGZ3cDJSL1Y5VlVKZFpYUEhPQy9Q?=
 =?utf-8?B?Rm1wQVdNM1lRVUVraStzOHNjV3c2cjRsMUs3K1B3MW90Sng4RkIxRGNHakNp?=
 =?utf-8?B?ZjFVK3JGcUthMnBCbmNLRFYrTVJxSzJrbWNTSkRFOERnZ2NFVm1IZm16YlRI?=
 =?utf-8?B?anUrWllyTUZxb09IeFRnWXdielJhSVJkU3d4VkNRa0FwT01iV0tLb3VBbFFV?=
 =?utf-8?B?NVZhSHNkQ2ZQYkJYR0ZzeGJZQVlEUUFKaGNtMDJSU0xqclNWcXZGUmlmUi9t?=
 =?utf-8?B?cWhOVmpiOEZBNnJldVV5Uy80a2NSelVReCt4M09YQjlXNHhSRU9nd3g0cmRB?=
 =?utf-8?B?TTFvMjUvNUdnZUtmR1l0cFNsZXVGdndwM25XWEFRcjNSWVkwSDBqTGRiSjhr?=
 =?utf-8?B?TXNseUNocjh6dDlOLzJLMVd5VTdsZS9MUWRKMysrMUlEZGcyRGdRWHBUQ2Z2?=
 =?utf-8?B?ZlZMOVJ0NTd3aXJGb2xIYnpTR2JMakNYUDdaK21kUmZOSmY3VVVSTWFVb1RM?=
 =?utf-8?B?cU1HQ0FPZ0VKbVFDZDhVSWlJREhaeWd3Wnl5RXRNMFcrZDdIVXVYZ0N0R2xH?=
 =?utf-8?B?ckRNVk5GeXc5M3pLZjRSa1VCYkRTWjBVcGtvUFFYdlhhZnNDUXovcmlwZVlV?=
 =?utf-8?B?cktxRVlwTm9DbndyajVtK2I0QkxFU0Jtb0VqTkdzY0VkR25UTEVGODRsanBE?=
 =?utf-8?B?UjhYU3U2VXhCVE5OaFVPZUVoTDFMZlMrdUUxa2VTbWZPYklNWHh0NFJCRXZ2?=
 =?utf-8?B?ZTY3TkY5c3JZR1ptcjNFbEZOcmNvOFhpYWNYeHpDeXFrYlFiZ051VGcrcFBr?=
 =?utf-8?B?enN1Y1hCNWJDVFVZdkM2dmgvUzNpbXUzN244cFl2VzV2eWl4QjVlcU1BY3A4?=
 =?utf-8?B?eVZZVHlNVEVha0FTcTF3Q05YdlAvb3BUbnpnT2RPOEVjNDJMUlhZMjQzUzl5?=
 =?utf-8?B?SngzS0tuYzZETlFVVTJkUVMrK0hsTXVDelREZStleFF3ZzIzd0VSdExoTERH?=
 =?utf-8?B?SzY2ZXhEVUpTdnIxekRxeis4YW5lbjZ5bGdzaUlxL05tenpuN2g4azNDS08r?=
 =?utf-8?Q?oSFm9Yp/ZconQuXPsI2OZmDOz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075fd411-51ae-4578-4b53-08dcfd895af6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 11:02:36.1681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVDC8nuL5Bc5eEdro/9cw/2aKpZ+1FhYsnUV2ZnuetkiIGsqGHCsPNIjrrUvns9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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



On 11/5/2024 4:22 PM, Asad Kamal wrote:
> Add sysfs node to show supported NPS mode for the
> partition configuration selected using xcp_config
> 
> v2: Hide node if dynamic nps switch not supported
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 41 +++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 83a16918ea76..964667125be0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -471,6 +471,16 @@ static const char *xcp_desc[] = {
>  	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
>  };
>  
> +static const char *nps_desc[] = {
> +	[UNKNOWN_MEMORY_PARTITION_MODE] = "UNKNOWN",
> +	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
> +	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
> +	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
> +	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
> +	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
> +	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
> +};
> +
>  ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
>  
>  #define to_xcp_attr(x) \
> @@ -540,6 +550,26 @@ static ssize_t supported_xcp_configs_show(struct kobject *kobj,
>  	return size;
>  }
>  
> +static ssize_t supported_nps_configs_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
> +	int size = 0, mode;
> +	char *sep = "";
> +
> +	if (!xcp_cfg || !xcp_cfg->compatible_nps_modes)
> +		return sysfs_emit(buf, "Not supported\n");
> +
> +	for_each_inst(mode, xcp_cfg->compatible_nps_modes) {
> +		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
> +		sep = ", ";
> +	}
> +
> +	size += sysfs_emit_at(buf, size, "\n");
> +
> +	return size;
> +}
> +
>  static ssize_t xcp_config_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
>  {
> @@ -596,6 +626,9 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
>  static struct kobj_attribute supp_part_sysfs_mode =
>  	__ATTR_RO(supported_xcp_configs);
>  
> +static struct kobj_attribute supp_nps_sysfs_mode =
> +	__ATTR_RO(supported_nps_configs);
> +
>  static const struct attribute *xcp_attrs[] = {
>  	&supp_part_sysfs_mode.attr,
>  	&xcp_cfg_sysfs_mode.attr,
> @@ -625,6 +658,12 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto err1;
>  
> +	if (adev->gmc.supported_nps_modes != 0) {
> +		r = sysfs_create_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
> +		if (r)
> +			goto err1;

This doesn't look correct. At this point other files are created which
need to be removed on error.

Thanks,
Lijo

> +	}
> +
>  	mode = (xcp_cfg->xcp_mgr->mode ==
>  		AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
>  		       AMDGPU_SPX_PARTITION_MODE :
> @@ -673,6 +712,8 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
>  		kobject_put(&xcp_res->kobj);
>  	}
>  
> +	if (adev->gmc.supported_nps_modes != 0)
> +		sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
>  	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
>  	kobject_put(&xcp_cfg->kobj);
>  }
