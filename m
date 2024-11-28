Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA38D70DE6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A0D10ED04;
	Thu, 28 Nov 2024 16:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZAx9tWd0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCAE10ED04
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9oH/Kpyvq3T3U1l/0gSOko9BGjARWv8zoghDOKNS6OYgiP510hMMyKftd8RcGRdr39jK84afr+ex4hnwyUE8IUDuJyF6l7P2HSvdP4bafoUA7QgmN0KZI7UygGlTHDMdIU/usWKdITbUXiPk9Sbuf3TrEhi6//BnKiRu3KW6cHZ8fnTz4hAUW3vPxzHM2x/yutxdap+d9U++4P2YgLal8cnp6MmEk6qn+2eMoRaG2BEe9f+dXPcCkiLRWg+dzgmEgpKI2FDcMZSMtCdpT283KuZuQxq0lIvjvRGkiJ/c3rTlmWuMo4hkWzucpf+ayAMpZ6ei7GGPBjEqFapvKXFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj/7rLSVtHrAXqXnPTG09ubgDLunEhXuYmz1vj5fkWY=;
 b=JwQ8nNgnNHI/6kJ0ZQ6RMiaTArABgIcx1ik7ysZ25IWteRnpF2Q1AH0/BcJsDemFjCRRTuWcyTTuDOqlEsXoyowlWC2blwokIf9z0bSRFQRQyzqQb+73Wn1qFHI3nwSo/EnUxpi3hqaV0qcP90YWfvuENHKm2ekzazZFtgIHPOTNc4IY4tUtf040GIMFq/PJWUUAU4en/NxFU98Is9z57cAMuy3mkzz79Ifwkobz/AI4pKRPS7JMm41HWz2PF1o6kxV4K+wPXx6W9xa7TTNF6jnr/pLj4euBNY3hzc66ZmrTwe5/MD0PWMdW+rx5Hv3elQfii+trRQkbs70EWHkJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj/7rLSVtHrAXqXnPTG09ubgDLunEhXuYmz1vj5fkWY=;
 b=ZAx9tWd0iJMHzYk3abF2Noiv4BID/Jr0T9MErI6mDLdg9i4VTYjEE4+9A0gHuSt0LpqbzBl2nz8eBbiMwZzNbSH2lWl+2LaM1aO4TWdCQifLO6DXFxh05+Cx9a5zCavG8v+Ozuzd96XXb35oy9f6zLWuS6BNwFHBG7KQ8shXtIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 16:19:09 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 16:19:09 +0000
Message-ID: <fb8910ef-bf42-424e-9d43-4d7dd1fc9fd1@amd.com>
Date: Thu, 28 Nov 2024 11:19:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Sanity check the ACPI EDID
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: alex.hung@amd.com, regressions@lists.linux.dev,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 Chris Bainbridge <chris.bainbridge@gmail.com>
References: <20241128032500.2088288-1-superm1@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241128032500.2088288-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::32) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: c564c378-4106-4610-b39a-08dd0fc863af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlJWL0pBTWU0cEg1bE9yYUZScVoxcytsemR2dWc2SzVyUHBKRnBNVHNqbnI2?=
 =?utf-8?B?eDFnQklwQldvaVAwSms2ektBcld4K0UrcUNJRnRmdUdSdjBMM2J0QlpIWTVi?=
 =?utf-8?B?Z3l2eVhRUG4rSU0wQ0llYm9FWTRCckhwWk50SGdPWHBBUGpTdU0vcjdWUFZt?=
 =?utf-8?B?N3Fjd2JYbHQzbXdxTStGL2p6VkZwaW5jQys0dENOZ1p4M3lPTExqeVgxSW9Z?=
 =?utf-8?B?aStRdTFLZXNQTXluZnAxNm1iWjQ2MkNZcnF1R1FVU1htSkNtVU9uMCtQQ3R4?=
 =?utf-8?B?WjlVb0k5Y0xQYSs3QnFnaVdkSzBxeUMyQnZoRDNwdnpBdEpHKzlCZWVjUHBt?=
 =?utf-8?B?UnhDZ1RnWUc3MEt3SGRYK2FieXBacm5QeFB2SWtpOFE5SmlrM1R1QjdTNWxZ?=
 =?utf-8?B?YVY1Z01XbWc3Ris4eWhPSDRTbFAvV21GZ29sSjJ5LzRjSktzLzJhdHFJOURt?=
 =?utf-8?B?QVZFalFTTnBsV3FmUlJzMlB1N2RaZWFCY2RTU3MxcHdxQzJVSURXc0RqSkZZ?=
 =?utf-8?B?bHorNDlIL0RWamhza2RpeDNoMUxTK0o5MzczT0ZXcFJFR3pQZDRNZ3NVdWhI?=
 =?utf-8?B?UGJWM3NSSmUvc3Q3Z1h6bWJUSE56MzRIYUYvTGh6eC9pRDVCSkczcEV5Ukhl?=
 =?utf-8?B?SkdtOUoxK0ZkcW52QzhzMXltNTc0MzZNYzBsRmU1bjUwZEtzclpPYVJlbWVE?=
 =?utf-8?B?QVdISEhwQkpNajRMalQvVk55VEs2UzJIdG1RRHlDQ1hoTzNiV1RBOW1LWWZP?=
 =?utf-8?B?Z1k5eGhEVHJ6V2J6WXFqSUthR0tYT1dyMmRsZTRVVU9ic2QzTWIzMHBOTGpL?=
 =?utf-8?B?OHBKU3BLbVkvejdrNUR6MDR5NmdwREFCNWhLbnhyQURRVHV6cWxxd0VOR2Jz?=
 =?utf-8?B?LzZaVCtQZExEWkRqd1ZCQTNEcTlQb0RHVzFhOFpMWGlyTEdGOUdzaXE3MXd4?=
 =?utf-8?B?am9uQUQyOGZhTUZ0elZ1dnI1K25keDV1SllFbHpVc3Erb3c2cjhsaGxCZmdS?=
 =?utf-8?B?STEzYXhDZE5GWHhMWTBrZkQ4Z3hsU2RpeTZKRzV2TXhDbThrb3NVTHhBd2pr?=
 =?utf-8?B?cWlyRDFUbmJrMis4YlJwN2gxYmpKK0FlZkQzS3VsTDRzZzNFMzR1YnBHUU1i?=
 =?utf-8?B?K1BSVUlEOGVrVHNxNFdUNmhIMXZMMk11WU93ei9lNENieWsyVEVYSHBUOTV5?=
 =?utf-8?B?WWV2aE1ObkRBdjR1UG9qN1BjaUt1VEJSN2FmY1dGQnh1c2NjSkFMc2hheDAr?=
 =?utf-8?B?OTBSV2FqU0JuUTkxeUZGNTNGK1lmRU1ZZWRBQkYzeEN1OUxaL1JuMXVBSzlS?=
 =?utf-8?B?VW0vZEpZTm9vUnBUdk8yMlJROExLYkxtOUF3STZBcWZ1MzJFYUlRYmpuRTRJ?=
 =?utf-8?B?QnBnbTVGU2tlT044WVFJaVlDTWlzemJpdmxFN0xGMVRSN0t6ZENEdkx1R0Jq?=
 =?utf-8?B?aU9Sd2NTUVJlRktlUTVWRzNRYWxoZ1FGNjdVYlBkeGJaOGFsNnVVRTRRV2Uz?=
 =?utf-8?B?OWNsMnZaK1lsWS9LbzVock5iRkl4SVZXZG9JNFpjdDVnTUdHamRIL3pTaFlx?=
 =?utf-8?B?QWVPZk5naE8wVklISzhNckVMcWYyaU5kRnMwNyt2eUhvbGdpY1p1cW9ESkkv?=
 =?utf-8?B?czRySURhcDZhTWltSmF0RTNscWhDWXhML2FQQ1NDNVY2MElMY21Mb2FUYXRS?=
 =?utf-8?B?YWljV3hOVjdxWllUWXErNWd1ODhuQmdnTHl4RTdBSXdpbHQ1bHdHaEpvYXA2?=
 =?utf-8?Q?NSCH9cNJVKw6FMwbyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUc4aC9DVkNKVU4zR3JtUU5acFQ1dlRzUHlJTXBrcWNhSzJJQlhIemEwd2VJ?=
 =?utf-8?B?bjQxUnMrcmNwaVdjYlFSRDY5QUpPZ014K0tPMDZGczZVMjdDaWxOZFpKRjVh?=
 =?utf-8?B?R3dSNTZMMkErcU1OY1dWeUNuT2xJMXRpNGtZSlhNVndLdHRpWnZDMElhcWJz?=
 =?utf-8?B?UDdHeGVzYW1kTVI3VEVIYjcxTmRjb0FtbmFhNGRxeGN6SVVzbzBISFhYc2xC?=
 =?utf-8?B?U2VaVURqWjI1UWhzaElWQ1JTRkhRUTlOQjFYelV1VTMrdUlyZ3RBVHlXWGtM?=
 =?utf-8?B?YzVRazA0dEVIVFVNTVUwaGpNai9wVGlja2IrUlhiVDYwNHd6bDRhVnBQTU9n?=
 =?utf-8?B?cDU2dVhEUU11ZEFZVktpR212NmYwZVRGMUJSMnJYQ0llSFZyd1RvZmRFTFBu?=
 =?utf-8?B?OGx2em11cHJ4L0VhczhwVG5GNXJWYzVoNTE3R0NaVnYxbHJNQm5RaDRGbVJV?=
 =?utf-8?B?ejFpL2xrSXBJVzZUYis3Qk94cWFZSWRNMitjZVBHODNUbGp6MytYa1hvL2tk?=
 =?utf-8?B?ckhoOEpvVTQ5aE84Uko2M1MySTBvUncwSWd6a29FbkNzbVhLdXJrNUdRd2JI?=
 =?utf-8?B?dWRLSXVRb2dnczlJN0lxWHEveE55ZndpSGhWS0dKNHNZKy9VemYzaDFMMENL?=
 =?utf-8?B?MGdUaVBLei8wcndwWmg3d2p2RGRFN3YxR2ZSeW90SU5TaldtWmpXbE50UW02?=
 =?utf-8?B?bzVLL1lvL3RONzBwVU8vQTNMSVZVYUJMcThvWjcvM1hQY2c4VXBsbWRYa0xU?=
 =?utf-8?B?ZE5nNmZhcm50UGhacEluTHhLYWh6ZzNOMUNMVUtsNDk3ZGVuNVNoNG5LbUxV?=
 =?utf-8?B?M3pMbXRVYzRXM01La0YxZXBUZ3VkYjNOQnUwRGQ0ZmdFM2lRcmVLKzFYc2pG?=
 =?utf-8?B?NWtnaERnVDQ5eTFMcEQvT3huQ3Z3WmV2RGw4WmdHc2dGd2pwTjNGalRYOGky?=
 =?utf-8?B?R0dFSUpSckVoK2RhaXhTUy9lZFRHK2R6SmVYMGxJaGd0R2NPYzhwYUxMUERR?=
 =?utf-8?B?YktDUXB2YmlrMU9kdityL1NpSTROOUxSaHlob3VlZ05TQUZsRE16Q2FYcWlB?=
 =?utf-8?B?S2JoL3ZNblhhZjgwSjlYeGg1L0pDamtOaVROWDY3OU5iWTFPOHdOZkJBZzdB?=
 =?utf-8?B?dGNFbXNwZk82bzZtM2NrNGJGT1RCa3J6L083QVdxd0cxSjZTb2taUEVaejl0?=
 =?utf-8?B?OEMzVEpMclV3aXpFQlhwTUI2b1daUlF4MXJmdzhvZWZjbjhOeHFsZmJVSVdG?=
 =?utf-8?B?bzNjVHdhaUxPWTllSG9UUVhGOVk1cWRSemxHRWs2WmpUdHFGL2djQ1ZtckM3?=
 =?utf-8?B?RWlJY0ZURjlZS0lBY1lnQUI4TmdqSlpKa2gyLzJDVGN6NGVjbVFWcmdtMGdt?=
 =?utf-8?B?YnZHS0FLMVNnT0Z3WDdmTjg5ckRmdzBCa0RvNlpkUWYza3B6MHdqUEdiVC83?=
 =?utf-8?B?Zi94UmVMUCtVTDZDT0MwaXUxOXd1Yzg1a3V5SU5nbmVrelFjRXRNWFRjOUox?=
 =?utf-8?B?dHFvSjJkanpmeHJ6OXVueGRFUE04MmM5MWY1VkV1N2hLaGQ2blNoc09YVjRj?=
 =?utf-8?B?VXRYclRhVCtjZHpDazBlVTdpbEowZm5CNldpMkVFVXhaS2dhMW1pUVMvcktT?=
 =?utf-8?B?dXo3bzdJQVBlc0pBU3BjSHBpUUxFTHVMb1RLUGFhZytsQ2I4cjlZTlZjL3hN?=
 =?utf-8?B?OUdoT1E5Um9xQnZOQ0c5V1M0VHl4eFFKa21XRFA0REE4c2FUMXZTWGl0MGJj?=
 =?utf-8?B?RGhCUlRoYkhyTWRtZzBEbXlHT3ovaE1ndCs0dlJaWE1ZdnZPZ2tlaHZvWHpB?=
 =?utf-8?B?M2dETkx3ajVvRzVqQlFaNXYwQ0ZiRFJKWFhGTjlxczk2dG5NLzVrVjd1dkoz?=
 =?utf-8?B?Njc0NTlFc29LOWQ1MGJJbU53WnBtNEwvUFo5VVkyQ1FhMGtmTnptRVBEK3lL?=
 =?utf-8?B?dTViTERRN256Qy8zcjZJVUZSRER2OHV4Zjh3akltYUJST0phZHQvSHJZc0ho?=
 =?utf-8?B?ZUlaMll3WXVZeTEwejFBMXQyOTNVaGYwcXFydmNORVdPZzFUNEp2UXU4d3k0?=
 =?utf-8?B?a3VWSmZBaUtEdTF4a05WQWIxUXJ4MUw1NWhEVTFYekNCTGU2cWdaMktGdktU?=
 =?utf-8?Q?Wa+1nqiF1lBTwHaVOfDI/tR7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c564c378-4106-4610-b39a-08dd0fc863af
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:19:09.8399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /g0dOaJCk8SPhMyWKZw3VI60+rbjAEUN+plrsm3ZnnIgrvJagzXiT2qO6Je8PUrdGdmQt+2ERnti1Or7yQVaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

On 2024-11-27 22:25, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> An HP Pavilion Aero Laptop 13-be0xxx/8916 has an ACPI EDID, but using
> it is causing corruption. It's got illogical values of not specifying
> a digital interface. Sanity check the ACPI EDID to avoid tripping such
> problems.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3782
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index b0fea0856866d..6cbbb71d752be 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -907,14 +907,14 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
>  	struct drm_connector *connector = data;
>  	struct acpi_device *acpidev = ACPI_COMPANION(connector->dev->dev);
>  	unsigned char start = block * EDID_LENGTH;
> -	void *edid;
> +	struct edid *edid;
>  	int r;
>  
>  	if (!acpidev)
>  		return -ENODEV;
>  
>  	/* fetch the entire edid from BIOS */
> -	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
> +	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, (void *)&edid);
>  	if (r < 0) {
>  		drm_dbg(connector->dev, "Failed to get EDID from ACPI: %d\n", r);
>  		return r;
> @@ -924,7 +924,14 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
>  		goto cleanup;
>  	}
>  
> -	memcpy(buf, edid + start, len);
> +	/* sanity check */
> +	if (edid->revision < 4 || !(edid->input & DRM_EDID_INPUT_DIGITAL) ||
> +	    (edid->input & DRM_EDID_DIGITAL_TYPE_MASK) == DRM_EDID_DIGITAL_TYPE_UNDEF) {
> +		r = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	memcpy(buf, (void *)edid + start, len);
>  	r = 0;
>  
>  cleanup:

