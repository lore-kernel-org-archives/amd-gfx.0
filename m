Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469C0CA0EFC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 15:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E139C10E39C;
	Thu, 21 Aug 2025 15:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8qfMSNy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26B010E39C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 15:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiWx0Z/IJyqevzG5W+Yfd2F0vH70JAZkITLGbu7eEcZh/+f130WYfvlc/qRaNzNJj+adMYKUJFZte+zHHZGyX9mIEDhg9oIZHimeoxfUkvEAPLahTGxjI9fVelJrQHv+AGTHvHjLJyJO61N1cVJJ5yktwoUTFtoxjuWsXD8/ssIgC44BSOMGrOT+cDoRSUT4qzxeP86SPIlGOHZugDsJyyXghvTh8Xg86TKvBGvwK+Hfk/6jVCZ2YXLuE8cnvnd/+ZkmELW+eF7tgXSXKWHRdfuG2qcbiEMOq7yNom+ialiNLgLHUvOo87NFqKFyxlzLvoayzwSJ8Kv4Ll8d68OcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyqxS//dLmoJ0TpTYnFM7BE/ZM/WbLjNvH0XWla9SD4=;
 b=EZnGG2lX0Rq/C7WzqBp9mQZvN6W1ffXUzK1NOhCGhSEdvAgL4dLkbrmzDgKmAWCtaQCGNWeWEOzaBMHGUr7zs8lbYMXOU8ku7tj6Js25KfJuwYDiMxuT6E74XFMl1bHDPLh2LpKlvFb4Ll7iXAThXaemzN8wamk/2KvAhDkg5q1IB5P55NRVT0Eny+7g3Zcj0/8vLM84dCYM5cNgQsT4p74z6C615ihRTF/7ji14eEq0mZFkM8lK9WC+bOID3kBASI11QXr4OoFHsFKKarcMsEjtcGaeMgQVXoo6dBEmsQvJ4MaoVD/NwpnKFTMRF+9jsc3lhiuGa22DKjuneDQ/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyqxS//dLmoJ0TpTYnFM7BE/ZM/WbLjNvH0XWla9SD4=;
 b=j8qfMSNyPgfhyCUCzHf24doxa9nhQAimi40dUgZkJZX1AhyhG3xP1kPD+QVC5qKsSM2QvCwJ9nN6x6YPcCYqs1P36zRaF+mRisRuqTLiNYBmNeGEZ6OILdmowX+/u/V2L75LP2WXJ+f37SHdDEDMMqbYVpR9il7by6LCRt/P+80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.17; Thu, 21 Aug 2025 15:44:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Thu, 21 Aug 2025
 15:44:44 +0000
Message-ID: <ce9c1f2f-86ba-4c64-9cc4-10261dee138d@amd.com>
Date: Thu, 21 Aug 2025 21:14:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 leo.liu@amd.com, sonny.jiang@amd.com
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
 <20250820030400.514460-4-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Lijo Lazar <lijo.lazar@amd.com>
In-Reply-To: <20250820030400.514460-4-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 50eb38c0-b0d3-4776-dda9-08dde0c9a65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFBEN3VzbVZxWHlaOUM5YlNMTEM2WkxmU0NaN0JvNzQvTmt4SEVGcTVZSXVJ?=
 =?utf-8?B?SlVnYWtNU2VvQUdXUFNndE5KTy8wTDlnWjNUMk41YXJpdjd2MHVvc0RBYWtH?=
 =?utf-8?B?emRGcTJIK2VxeFM5bWtndVpTYXlhZlBidmZUVTdTbDJuaDlDQ1BOUzk3V0Fa?=
 =?utf-8?B?VVVRRU9xeXhqSzA0T2RCRndoQTVZVS90MWtGQzNXNmtSa0ZJZCs3VS8rWEFz?=
 =?utf-8?B?ciszRWExanRoRU5EYVkzN3pxRnRjK1NaZFlJZUtJVTRTcUVVOStIQXA2aUNF?=
 =?utf-8?B?aXh0Y05IbGFKRUJLaHV1QzBDckl4bjFOSkphRnM2aWdUQmxXSlBDbDJ2Tyt4?=
 =?utf-8?B?VnJJT1BNTXJ4M0RzZ2NBYU5CUDdCamZPZDZCejJaMmQ5MjV5OURESElZVCth?=
 =?utf-8?B?U0VONk44TmZvMGRqTVRCNkZLckNTcUxqNmlscVJlUXNtZTR4S1FiL1lJemxF?=
 =?utf-8?B?Q2oxa3h5Rlc1S2lIa015Q0RMYWYzcmJMMXdzM2JPMEZYMGJPRkFmZnZCUWgx?=
 =?utf-8?B?cXFYYkFSdGNtaGpNRnp3dElqMWxOa0IrdDlyRXprbzlpVUhSR0pjTEdPbWRU?=
 =?utf-8?B?SUtYdVBQRjJxOEpHQjdadnJ3SWREUHRqWGxqS2VhenpaZC92WkFsVmI4aVBF?=
 =?utf-8?B?Y3hOQ1c4dkFWSmxraTV2NW90ZDlicnJ6NjIvRGNReXF5aHBhdmQ5M1BWajVJ?=
 =?utf-8?B?cmtOd3phRm94bC9kR0VTeXZYVmJmZlpEOTFDdzhNUjkyU2tzdVluS01JZDRv?=
 =?utf-8?B?TEI0anFhZnE5SUZnM05PM21leGZsWXJPK05kTXBqSmhwb2huY0ZmUXRCZGEv?=
 =?utf-8?B?NG1Zb2hidE8wcm5KcHliNjFsTVA3S01Yazk0YlZ0ZmVxblFTR0ZoQkViZW1L?=
 =?utf-8?B?SzNINUhPYmRPWkVzVjgvWktBbUkzcTg5M1lNbXg4OW9kYjBUWDk4cDRaS05U?=
 =?utf-8?B?UXUrRlBSckJ1Z0JQd2lVN1ZXNFNpdmJ3cXBoVjI5SDBnN3RDK01nelRCRGlH?=
 =?utf-8?B?VVRtdVFGbWYwU29DRW5wVWVsTEZhL0RoRHZKalJPZ0R6Nzc5eXY4Wk1URXhU?=
 =?utf-8?B?Y05XWC8rNjFIRjUyYlcxeVViVUdHRHVlNW5vdkJvUkQ1am5IUWxOS2pQVDZi?=
 =?utf-8?B?NS9KZVZjQUFTaGpTTGd4cXhVYmloT1VsSkhvcGVoTTNGYUIwZjhZQzMyZkN6?=
 =?utf-8?B?QVhaVTZYRnIyQjQyZWlTai9XNU5scWFUWjVqMVUzbFZZNjViemllRGs3OWth?=
 =?utf-8?B?a0k4QXkzTVBxWCttMU5QQ0VjRG44NXl0b05wcmw0RTFmTjJSZTBmWlVvWUFx?=
 =?utf-8?B?VzBIQkRFcTQ2alJ5WWdlNWRUZ1RFcDNxOElSanFXSEVrRDdPeS91L28yMjZC?=
 =?utf-8?B?am5KMzFOOWpsNGVibHgvamV6YWhoRHBZdmxKTGxPcThsL2xNc3c5NXhQUURK?=
 =?utf-8?B?d2hQKy9aTWw4ajNQUmJzR05reUFLQ3ZpNnF2bSt5ZnZoOUlTbDZJZmxIUEkx?=
 =?utf-8?B?NC9LMmRBRkQzN1RTdkd0WW1Sd0N4SnNmaHZ6dk83QWU3dnZ1bFZXZ3htZjZk?=
 =?utf-8?B?eU5KcEk4Rk04U0VCTDJMM21FTmFsbFNWem9HNDFjaEcvSXc3UlFCVlozOFg5?=
 =?utf-8?B?cHM2aEdyK2tLOVlpUFJRc2hCNHVJUzFtQVdOUGtKQWV5YzdrRllaVUozcC9S?=
 =?utf-8?B?UEdIQ0NOdW16a3VVc2Z3SncyY3ZSbVFvNTAwV1hFMEpLTndsSGlSL0xINGEr?=
 =?utf-8?B?TjhWQ0VMUVBrMHJaRUM3K05SVWFBWTZqUmVXcVZZNGVQbVRxMUdNZTZQMkVG?=
 =?utf-8?B?VWFzTUFpOTRKT0ZyU0FMZjN1ZGxYczVxSDh0dU9ES01QRW5xQTlxVjcyK3ZU?=
 =?utf-8?B?N2NxbUFYeDMrQmZoRmkyd3dEY2l5ajZmeXd5b3lpa0l2SlAwNGRSZ2VRMlhu?=
 =?utf-8?Q?rMoT8eCrB84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3YzMjBWc0JSSEYwczc5L2QyL3hvQk1KbXdQMGI3d3QzaGNOVVVPY3B0OE9O?=
 =?utf-8?B?UDloYkV1SzJDTEZrUUFKb0N1VnpDc0h1aTJyY25WRVBsZkFWOCtIdmE3ZVdP?=
 =?utf-8?B?ekZHZit6TVpZd1FHRmRvRW1NYjdtc3B1MDZVYzJhdVNmTCtXNTkzZE9iSlZL?=
 =?utf-8?B?QkFuUmhtQ1NWemdlNGhjcG90QndJeHQ5dUJBdG9CV1k1SWcwemtUTFUzd0g0?=
 =?utf-8?B?RjR5YWQybjNZelpyU1RJQTRzY0JTS3RxQXYwQnhOWXk5L0hUUWlGRHEyaDdK?=
 =?utf-8?B?UGlQd0FVTEdkL0NRUTVBMWlWaHloUWlrUC9iZVFKejF1YU4vY2RGUkZVM0Mv?=
 =?utf-8?B?czVPY1hvdUt0V0VKdGMwWjk1SHY2Z2VyRHUxRnFIMlhCck94cDZGQVVkSlZw?=
 =?utf-8?B?UUNoYlRmNVJFSWZPTDZFMENwVHlwQjNWeEVXT2liTGx4VjZLWWN2ZnAwWFdo?=
 =?utf-8?B?aERZYXRDeTU2WVNGV3lOdUFCUFRMTTdDUHN0amRoRnNSRHp4VE9MNzJ4UnFy?=
 =?utf-8?B?cG5qQWRtL2Y3VmMrbU1VN3BHNUZGNllmQm5qemZqV01yT0RLZnQzUmRQQ0JB?=
 =?utf-8?B?U0xGc3VCS0YwOEVqV3RHODZNNUhna3JVU0lKN3BCT0pxdyt6d2FoTEsxU0Jq?=
 =?utf-8?B?V0RsOUdvUVZPTFM4YTVpdHlxTnBTRHZiL3pWZTdpUEY2YU53NC9VbkQ4aDF4?=
 =?utf-8?B?b3lEQ2tIdktUNmxQYW5PeGxQRDQ3dnBDaHlWb1dJZ0x6V1hnbkdZZjhTWWZh?=
 =?utf-8?B?dzkrVytnMWNJZS9ZNTdSM0Rkd2xlOVUvcG5yWHpLVGFwcXkwcm9UR1ZlTzI5?=
 =?utf-8?B?UWE2TTAvZmxTT1VMZFl4cDc5SkVIQ21jMGZyaVFqT2RXMDMzenplVXZCNFZ1?=
 =?utf-8?B?cWFWK1FvTGZVNTJGOFE3QmlGSlRxOHU2K28yVlNLa3ZSWlFTd0ZZY0JQYUZU?=
 =?utf-8?B?MWVPc1RWTmRFWlRvWnlObU1La2pHTnNVc3cvY0NKVFZEQ1BlajZKNVYxaTlk?=
 =?utf-8?B?QnhwZEpBem1Ubkx5blNuaElOMlppMDNnVmJmelFNeXRZenF2Um9Kc3gxc3Yr?=
 =?utf-8?B?Y2Q3TVRqSzhuQ0VLWGtRLzJ1cmhzakVHODNjWHNYVFRDSWd1OWo0bzdJaTM5?=
 =?utf-8?B?SnFwc0kzdndtV1hidVEranVQQ09YekVIOHBWem9QOXhIVi83Q0pjYkhVS01K?=
 =?utf-8?B?UDlGb3k5aWlaNmNpb0ZJWDdMWWRkRjBSS0hwaTN5dkxXQWZzemxFZ0NkT3U3?=
 =?utf-8?B?aVREVysyM25aYk5qVFMxeG1CTktRN2VIanlXb0d5UzdhVHM2WlpPZkVkTFJu?=
 =?utf-8?B?NGJBVzUrbjdHaW5VTVFya2pZOG9rYlZXNC9sM05CWjV6QmRBaHNNRFkwSFdL?=
 =?utf-8?B?RFNNaHhoMDlaVW0zaGxQeHlTa2dQVExyZG9zRld4SnZPZXhvdHNBd0tQbGln?=
 =?utf-8?B?SnVBNnJCRVg2RTI4SEloakN1M2liRFdpSjl0SlBKc1lYVS9IU002eWtDbnk2?=
 =?utf-8?B?bE5BOXdXN2huUjBXeVdGY2psYW1ma0dUTit1REtsUkE3anFWemp5Rk5rSVVa?=
 =?utf-8?B?MXl6TlhPVzU5N3ZwdmtxWlhmRUJYY2ZaQm56YnlhZExFTWpMYnIwU3JDSWkx?=
 =?utf-8?B?NTNPWm9TSjJUOC9tbFZrSGhZY2NMK01vMy9FdE9xZG1uN1J3MzlFN1ExVEdn?=
 =?utf-8?B?L0JEbVJBczYyekZIbEFTYmVRb0k2elk1OVZJTmx3T0I2NzU4REExRzMvWjVY?=
 =?utf-8?B?T2hQOVhnL3pKeW5IeXZ1V3E3cjg0MnhKNkk1bWVFWkJlNFdJdndlRlIweWVu?=
 =?utf-8?B?dk8zK2RJc3N1NVhzcThadWdIYjRsMzhqeG5rVE1ZaWZMY0JaTDFueVdiMndO?=
 =?utf-8?B?SlBVR1N4K3R6RFBnN29OTzNMQkJOaFV6MmtMTzhVemFHWHI1Z1ZwR21oTXJw?=
 =?utf-8?B?bGd3ZkhGOU9QSUZvaENVME0xVFFYS29sSE9YOVJsYWJkT0dhTXluTVJSRVFR?=
 =?utf-8?B?ZmdUSHc1UURUUjZiemtDMDNCSEhYSUE3cUc5QXBxZnFZdTc1Q2FnUXllSlFR?=
 =?utf-8?B?a2pNN2hpck0xL1hjamtGb3BDWFE3RHRLRURDcFFMcXVrUjdoNjBMeStGbkxS?=
 =?utf-8?Q?oFb4r9oC4DVKarwEOf/+JofBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eb38c0-b0d3-4776-dda9-08dde0c9a65a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:44:44.1667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMmY2g/JViXmLHVQ0cNeGhNFyMNZ171/sOHSjgy/gl4A+9YIvgBa5/FdYyjyFlrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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



On 8/20/2025 8:33 AM, Jesse.Zhang wrote:
> Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6 PPT
> initialization function. Specifically:
> 
> - Add support for VCN reset capability for firmware versions 0x00558200 and
>   above when the program version is 0.
> - Add support for VCN reset capability for firmware versions 0x05551800 and
>   above when the program version is 5.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 627a8188d868..9306bfe808e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -437,7 +437,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>  	    ((pgm == 4) && (fw_ver >= 0x4557000)))
>  		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>  
> -	if ((pgm == 4) && (fw_ver >= 0x04557100))
> +	if (((pgm == 0) && (fw_ver >= 0x00558200)) ||
> +	    ((pgm == 4) && (fw_ver >= 0x04557100)) ||
> +	    ((pgm == 5) && (fw_ver >= 0x05551800)))

pgm = 5 should be under smu_v13_0_14_init_caps().

Thanks,
Lijo

>  		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>  }
>  

