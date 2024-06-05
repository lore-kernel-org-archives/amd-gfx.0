Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA56C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 15:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F9110E18B;
	Wed,  5 Jun 2024 15:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DITlptuX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8FB10E18B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 15:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGiHzSLjY34RpJdDxKOuZat+ei5sN0WS/7KPsMVIKOCL91t7I3MYjSPbtVh9cmcu3BK+2kcXuQx9ua7nXdpq7Um7bl4MOegW+Q6Yvr2wPzvJgPJ/7hzCH7XJ8SVzmnGyHjXTFUwlWKHORfiBQb+TXn2xOz1JeVEDKc/Pc8KDbWzYAB5mWBXKeknwniLacvV73FGeShgtMMBG54YX37S7c/gpCFSIOPy5dc4nGBKmVBbGBUHUQLEwrijwqmb+9MDKSNw3mRpbw0jNCe/uLRnJI/c2Noc7X0lLRHxY78EOhinkwkJLd1RWugivCtY6Jc0cotSD7FnGkQelETc4ihMPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9NnKjG2r3a1PNoJ1KcOEFKopGaPFkysijTiv47P7Qg=;
 b=nsByth6rkdVD8kw8Q4TJkL6IWNzU4eAZ1Y+2Irz59l5C+cs1nKxo4N6KK4Ll20nXffDMzWR78d0t6YR5QGro9Fy8E6OeXBraTBGW3o4NWQNeXuYJnW4N5cu0U5jGc4hcDnBX9gOUiOyTrufx2f34vmlRJKB4UAjQDHoHvvrAm/M9qT0NivxzWGPxQrxkOZcKP/iG4+wG+zLJ8l2UcPDQTL0VR2W2MlC3iHG+zVFOAi7VMx473dtrrn2w35G68kPoyGslmGc2JZI4uMcZg83jFJuh52g3fdWTUnm6+ES86GvUIR1JEpCGqarRSJMQ29gCblDo5HpznXBzATUd5i9/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9NnKjG2r3a1PNoJ1KcOEFKopGaPFkysijTiv47P7Qg=;
 b=DITlptuXTwiZJYid8K+/iuHxSeaIrvkp2MqIt7fUqPM9GgGBzmHGfk1I3/Udqf2hIzVy+IMRzDHPbUj+/VabvgXWF8ps069J8kzysh6ndO7h9rWTVh0d4o23xZ9JNRLQW71RmMtIsCSIbe6QPbxoVZRoep17lRlynAoehmI6a6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 15:38:49 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 15:38:49 +0000
Message-ID: <570fd5ec-1fe1-4d75-b4aa-1ec579a0bcd0@amd.com>
Date: Wed, 5 Jun 2024 11:38:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, George Zhang
 <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
References: <20240604155027.542271-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240604155027.542271-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: efc79fb2-1e8e-4ae2-6ea3-08dc85759834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkdEVnNlb3ZHaWhyMytMQ3VLMVA0aEQvalFQU1Z6MjBxOFJDUjBRWVZXTFIw?=
 =?utf-8?B?MVhYencvYXdtZWNBL1VHK2d0MTh6TDJpQnJtZ0hheWl3M1lUOGV3dkFYd0c2?=
 =?utf-8?B?QWxQKzRXakJDUWpxU1Z6V21iaHhzbmUzTXI0RSt0Q24zU1NSV21Hb0RDdjg3?=
 =?utf-8?B?QXMweFFYRnNXeHZBZ201V3JPQVlmMzZqVFNaS1ZWbE1mZFhHV0ozSndkd0lz?=
 =?utf-8?B?bzV0QlQ2TUV0UENIZDJOc1J4a1RtTFFxUEcrYTk5VmFsMWs5MEtpaU9lQnNK?=
 =?utf-8?B?WHN1RG9mYXE3NHNyZjZkL3FMRDZ0MzV4bGs4U2hhcG1zR2pKTThNZ2ViOTV1?=
 =?utf-8?B?RERBbnhDNnVJMnhCclBLTmROc05rbFNtbjJjUHdFaDljSm9yYWt0YTdyb01x?=
 =?utf-8?B?ZW9kWXgyZEptTXB6SHlueE9uZmxLUWJHOGpyYmhVWWVXYWhYS05udUtiR2ND?=
 =?utf-8?B?SlhGQW9IZC93UlJRT2M1NnRUdjdBU0lpWVhscGgxTzkxVjJSSlY5d0NYSlNN?=
 =?utf-8?B?cGZqTG4wMFV1VnpxekxhWnJ6M200WWhIMjV5VnVyNWwzSk1mbFJOeVZpUlU4?=
 =?utf-8?B?eG9uV1pyY09kYk1yL1BONFpUb3VhTlRheUtrbUU3Q05hZWlGdkxkSEJvUi9S?=
 =?utf-8?B?bXFhUWxrYnJBL0kxc2hXeVdFQ0xSa2paYkhGaG1yNnAzSWhSVHhsclBsWjJO?=
 =?utf-8?B?d3UxakNydFpoQUV3aGRMdllOYnVSRUNEWVJlT2w0RlFnQWg2cXJRK29ic0hH?=
 =?utf-8?B?UFNhWFZjbXRUcWNiWFV2cEt4WHVUYm1yNytGL2duaHF6SDlwSi84aGVwVVQv?=
 =?utf-8?B?QTZXQkVuN0VLQkJFODlyQ09FUGhxS1dNYld0ZGdmbDJmSUhMcHVYOWV3d3Zz?=
 =?utf-8?B?YjBuUCtvMURUY2pkSTZQcDNMcGF4dnZ3TkQxNzNibzJjRkpRRDJWcnR1dk50?=
 =?utf-8?B?S0Mwd08rQVdxRGNoVkt4NkJyaCtpclZwTUk4L0M5Mks1OTJmM3NWR0hOUkZJ?=
 =?utf-8?B?dTRNV2l4VWdLZFVlNGdqek4rQWxqdG00NXp5V2RlcWQ1RjZhQms1SkN0WFJw?=
 =?utf-8?B?TmVJS1JxN0JyWGxScUpPdGlOL0w0QzFoaE1YWU9EWTM0ZWpNejNnUDdsOTV3?=
 =?utf-8?B?T2xteWQ1Q245UGt6aUszUUhwbDl4SHRubTN5dEozV1lQRERHWU43TmZTb2lW?=
 =?utf-8?B?RW1hRVpJaTR5dFJGZGJFZTlSTWNvWnFWcDh6SGJtUW1uVnhhZDBUV1dSTkFn?=
 =?utf-8?B?N0UvUFZCS1hDYkFjZ1BqZjhySVNHa2pOUDdRZHJkTENyNG9wb1RZZ3hhbnhU?=
 =?utf-8?B?RTVvZVNYTHhtUVhPbElCQ0hTcmdoTFRWR2RHM1BKWW1Ca2NrQnQwRlh3Nm1h?=
 =?utf-8?B?VCs4ejdMV09KeXd6dzg5ZmRPMG9kckJ1U2g5L2JaaWtBeFRWYXg3b0xHMzBW?=
 =?utf-8?B?VVlsR2VuVWRmb1NHVHFQdDhTc1lYNE8wWXdlZ1RvTmo4U2JoL2g5WS9mVyto?=
 =?utf-8?B?REJ2UCs2WUp2R1JoblRZL1J2amt5YUVaK3dRQnBlOGwxQkU5czRFaXd6ZHdi?=
 =?utf-8?B?L3hVZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklUbHhXTFU4TW9vVHRBN2VxUm56MlFwU2J4akxobWtqRW5BUFl5SFR0aGEz?=
 =?utf-8?B?aXhEUG1uT3VtNldSZlVzUGdtTjRPYkIxdFJSUGtmWEtNbWFwUHd3RTVxdUtS?=
 =?utf-8?B?U25jUTFmNGkvbFpFR1FhODJZSWFuWE1LSHd0UzZta1NFU0NxRktyOEJSaXpO?=
 =?utf-8?B?czZmSENlZnFBNVJTVkFZY2RiWk5Ha3MxUXRTQUxQYXRqVDVhaTBrTzBNYVJx?=
 =?utf-8?B?WC9pZUFQdlNvZjhmOFRla1g5cFY5RjNYZTU1Ym1xaFJGM1dEbTBMaTRZUVU1?=
 =?utf-8?B?NmdKR1ZFV1p2N1pXOThxRFVlYzg0bHFBTHRIKzF4akgycXdOb1M0cStZTnUz?=
 =?utf-8?B?YTFOdFRxZ3lJL2FldEsyeC8vZ2ExSDlJS1l4YnNyUzlsZDc1QmxnZkxaanpP?=
 =?utf-8?B?YldyWjBXQ2lmamtZc1ZZYjF4d1Z6ZlNyVWFXWmxPYm1XdnJlN2kybGtqcGV1?=
 =?utf-8?B?dWpZYXE3NVhFOVo2ODJBNmh4dkc4T1h0aGNFZGVJVmE1bEhRaVdJUFliK0JW?=
 =?utf-8?B?VHpyQzRZTUtEZyt4dWxsckFGRzN6WGhYOHdIYUdqbG5VOWZTTnpXbDYyNXB0?=
 =?utf-8?B?RWM4K2o3RHZEMHF2Z2NHbTJiSk1KK3VYbUlYTGwyRlVqdlFESDU3czZ2Mndn?=
 =?utf-8?B?UXRGQ2pob0RDajdCU1E1emg3azFhUVJxZkpCbXV1U0F2Wm9Fc3dMSFltbEU5?=
 =?utf-8?B?bG9JSytlWUFrRG12andBR3MyeTZqZytvM3l6eHYyVWc5eW5lTVZMU2JJY3Ix?=
 =?utf-8?B?UkZraW55RXhlN2UyY1hDVzdjbktla1BZZ1hxa3I1N2xDRHN6eVFiQzMrMG9l?=
 =?utf-8?B?SlZncGtSMzlOTld1THdMUS9iL3U0V2h5cnNsWUsweUhTcEVpSUJWUFJSTTU1?=
 =?utf-8?B?RlRodFRTeXRCQ3NJeXA4YkdISzUrNVF5Uk41emtSRGMwUU91K0UrQkJnM1hi?=
 =?utf-8?B?c3AxVEJjOFR4eFBEK283NU5yNEpJeG16aGFzdm92QUI0MlhHUXpsOERmSmlX?=
 =?utf-8?B?RzNaa1BpTWpGZ1ZhUXFBNVJRSFAwODZJUTFUeGVCVFlnWFQ5aHY4dUl2WmlS?=
 =?utf-8?B?cHN6ZjRqZ3MwS2RJQXQvK3dDUStHbmd3Z1I3TS9xWklXc0RYelhqRzlILzRx?=
 =?utf-8?B?RTlzc09mWnZjbzZhRTQvbGdPMm5xWjViamVlVEJ4OWhHZDVDczN3SWFXRE9x?=
 =?utf-8?B?MnY2MENyZmd0NmJSUkhCNmgzNVQvK3RtZDM3VElISmRRMyticUM0MldoWEtr?=
 =?utf-8?B?QXdQWnIrYmxHSUJmZkhxQ2RVSXJVQStDcksvRUE4MmJnS0JYMmdWVWttOENH?=
 =?utf-8?B?WGRKSHFtL0ZSRWw4a3pnV0llMGR3VmpVcks3TlBKT1o4SzA3M0RVL0RlVnJk?=
 =?utf-8?B?NTZiZHF5VHlWSUZzcjBmS0IyOUlRZW1ITzZEUHBISUZITW9hb1pENWNkMVpT?=
 =?utf-8?B?cElnVDkwL2lNcTNaR2pXdVlUS2VuTUhKQUt4eHpKbjFCeFkvVDZVTWFJVGt2?=
 =?utf-8?B?S1NFRXBGTjN2bkIyUmdXaUVtUlhGVEVDRWJkbW1LR0ZMV0twZVoydmx6czUz?=
 =?utf-8?B?NnMrWHFNY0hlemgxTjBVMU5BTTBjekxFcm9UOEpYQkkvZUFQRlUyMDJZRVJj?=
 =?utf-8?B?TU1OZ3pMS3ZLRTRlNDZhbm53aWE4NmFDVnFJRlRSaVhGbnlrY09OUWp4WkFo?=
 =?utf-8?B?VlZIY2k4ckljelFzM1dhdUVrVjB0dEd0QllydTB5ZDB4UThkTnU0d0NtU1lv?=
 =?utf-8?B?eGR2RjRNZkVBN2RGQzZjQnBHZXlrNkhRYmNFZE9lZU1Henhla2RIbWhxOGlm?=
 =?utf-8?B?N3grQ1RKQUlzb29JeEdhYWZtY1J1WmdEckI4ZFg1NHlKWC94ME1Lb3NFVkpL?=
 =?utf-8?B?aWZrN3FEZWNpQks5Tm9ySDBGYTRaWk5YVnpzbGxKNlRSaENDY0ZubWpLSUZ1?=
 =?utf-8?B?czFxTnhGQXM0aExJQWxQRWRLcEY2dUZBdEU3VjVoUHQ0WmlDSnNrKzRwZGhF?=
 =?utf-8?B?SjdMU0o4NzRQSWt3TXpjMmlFcmlkdEZGdHZiVUVqMnBBMTNjMHd6eWVsZzJI?=
 =?utf-8?B?QzRGVmxqNFV2eGZaZ3MyZXZVZUdTdmwzaDZQdS9SWGR5VWFwaXJhTy9RM0FT?=
 =?utf-8?Q?jYR3DXInm9HSmMlFc/Gtmo/vu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc79fb2-1e8e-4ae2-6ea3-08dc85759834
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:38:49.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH6c/06P/zSVVFTdV5n3ejMqiJ7Z/xVMky19rx4bvyjiAr4XxUMpd/+DkZwUgwEEf7TUcZqJdvHFJujjHQlynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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



On 2024-06-04 11:50, Alex Deucher wrote:
> This mirrors what the driver does for older DCN generations.
> 
> Should fix:
> 
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> Preemption disabled at:
> ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
> Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
> Workqueue: events_unbound async_run_entry_fn
> 
> Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
> Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: harry.wentland@amd.com
> Cc: sunpeng.li@amd.com
> Cc: Rodrigo.Siqueira@amd.com

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
>  .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index d0ed01ac460d..d843933ad731 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1444,6 +1444,7 @@ struct dc {
>  	} scratch;
>  
>  	struct dml2_configuration_options dml2_options;
> +	struct dml2_configuration_options dml2_tmp;
>  	enum dc_acpi_cm_power_state power_state;
>  
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 0f11d7c8791c..7a8aa9396dea 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
>  
>  static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>  {
> -	struct dml2_configuration_options *dml2_opt;
> +	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
>  
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>  
>  	DC_FP_START();
>  
> @@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
>  
>  	DC_FP_END();
>  
> -	kfree(dml2_opt);
> +	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>  }
>  
>  static struct resource_funcs dcn32_res_pool_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 07ca6f58447d..ef30e8632607 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
>  
>  static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>  {
> -	struct dml2_configuration_options *dml2_opt;
> +	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
>  
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>  
>  	DC_FP_START();
>  
> @@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>  
>  	DC_FP_END();
>  
> -	kfree(dml2_opt);
> +	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>  }
>  
>  static struct resource_funcs dcn321_res_pool_funcs = {

