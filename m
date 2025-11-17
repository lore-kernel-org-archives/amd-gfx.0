Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61BFCE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 22:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DB010E035;
	Mon, 17 Nov 2025 22:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qRMzraHT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9984F10E035
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 22:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNoMmXiJIZriOZSiyB7RKV8j3vjzhySSB79jGrYTwePg2wTXwyTNEtRi/wR9hA9vlEYQD6yLhw7Soz0y6BW2fkFyy0zb/Hp7ZMS+pIjQ2VGg5wNuJ6iPh6A3mC5RPDzTP6BejCxuCx5fcaO56nnQSxp5EuLx7Mz5msZvu5tPqrnVZvi6eMnX8r0o52bZ6HmbMJJQ5TfWCJRDIm+56KPTB2dzhBW46ixuN5jxqeWc9rrIN9PAFebMG4gzLKB5ENWtzzxuvJ4cCAVvjPKG1me8nqDB4O2bEK7PNkpwNMSC7gYbFoYPtrRBhjcxBri5VcqW20x+mdgFt4JIIAmJrMVfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKIkDHjwoTqtLdNRM4rF7sxwJemOMr65EDezrB0bat0=;
 b=qm8wOBltbVLus4tp+LPaJhAjBQtzMZlu/bGwglJ5xTevnQQrGcf6EG51VRHoTXmj1Yc4PPoy/8ZMiRp/rtvS5hK1DFeTP/jh/ATQ4RXmIHsR1e5gmDMRTgSMU8D+cVZ5EL249dun9G+e3sV2E8Q9xFMOy6+KR89QEw33P5+1I90Z0tDsfPMj/3f6M9ikdvPDGBxeNzXTdAFLFC7QrvwbGR/TvF3Clb5rd12TEz7xDUI/F8W+un+Xy/1busQMJJXJvYTmmqzMttsW1AV5neH9pfAz/z/rjowYv+7SpErQtmcLPesIJvwFy84hSosyi54/mWQ1Pr4NDH5eccgFP79cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKIkDHjwoTqtLdNRM4rF7sxwJemOMr65EDezrB0bat0=;
 b=qRMzraHTDiLrR3uJFkg1fFJ3uA8ekU3saJqLQVcZ37dXVn7FwdHcerXRGtgVKNGiUa1bh28oal5ZnbeOh/3TL5cvEZVZLsymXkueXZTmOuTESdGPWzZpH/uNMrfkLp4Mhx0hWKknY+bJ/1yiMtJQhUlmkNlH6xkfvM5lpTQJis0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 22:18:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 22:18:34 +0000
Message-ID: <c9b5c81b-bcfe-4f8f-a9f5-97518a64be9b@amd.com>
Date: Mon, 17 Nov 2025 16:18:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/amd/display: Follow-up patches to analog support
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com, Yu.Wang4@amd.com
References: <20251113163348.137315-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251113163348.137315-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ba0c48-ee0d-4a72-d2a3-08de26273f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTVkOElPeFJ3ZFYyYWt3TEs1MU92YWIxZnN5K0R4bTJ4Um9odWpJVVZ1bXlR?=
 =?utf-8?B?aXpyZVQ3VlNTcTZnYkFXcGVlVEtvUDYyOU9QRXo1V2E5eTFYcEZVSFVHbmNI?=
 =?utf-8?B?aWxlTldodmowUU83Y0x3K0grUHRpVDlvYXR6Zm9lT01LbWFQY0M4VEI3VWZP?=
 =?utf-8?B?ZnE0d09sUDV5MDJKSnY1enh3Z3VCbjVCWWovSHlsUzhDTGhUcXRBMnFMZ2Jq?=
 =?utf-8?B?RUlJTmdaeWhJNnZmQ3d1MHZYWkNFdjFaM3NIa2I4VXphUTlOWUQxOEV4TytF?=
 =?utf-8?B?MkhqMTdhVkhIbHBOaE5sckpnaWhOMXNyNzNkQzN0WHRmWTR6NFB2SUtvS3d1?=
 =?utf-8?B?cVhGQzJLeFdabHdCZHlKc1VRaUJEME00ejRHYk12SkhudVZvQWR0a0EvaHNC?=
 =?utf-8?B?UW9xTStFb0VkRld1WnZ0bDQ4emU4WU5CaXJNdSsyM0x0K3FXdDZVdm9jRkQ1?=
 =?utf-8?B?WlNhcWw3S0dnT3hFaUp4U2xjd20vbjM1MERabW9nZjJ0Mmw1RGNRLzg4RlFX?=
 =?utf-8?B?QUsveklPUWxTTkx3d2hQcjNRcVhYYzRoaHRkbVpnZ1c2YVUvTzNoNFQ2ZjVs?=
 =?utf-8?B?MmlrOEVMcVJsUjZGV0RBQjdtOGxGS2QvTGY2c2FRMm42V1ByM0Naa3RwUktR?=
 =?utf-8?B?WG1rTjQ4MllaRnBJR1JiaTRSM21iOHRBR3Q1L3ZDL3FKU2RQNFpnV1NlRHY1?=
 =?utf-8?B?b3BCdE44REtwcmJya0FGSXpmR3ppSk94c2pUZE5OazZiV0diTzBQdWEyT0Zo?=
 =?utf-8?B?QVFKdmtBQXBnQSsrVUZkdlltcEg2R1VPS2M1T2dFNHdYWHJGVHo2dVBuZTZo?=
 =?utf-8?B?NHRhcDAzL09FTVRRaXg2WkkzZ2JYYTVzL2xmYlJoYXU2cHNJVnhpTk5nbXhC?=
 =?utf-8?B?b2JQaWxPc282eHRUR3NZUzVwclJYcWRwY3lVbFVpQm8xV29QN2w0NDlHRFFI?=
 =?utf-8?B?NFJxSDlMOE5WT0xVdjBtZGYraWlVTlFiNTY2aUprbmlnZWZOMSs1cWNyREtS?=
 =?utf-8?B?OHNkMUtXOVJobEtnemRwNW9hV1ZxU3p5R3NNcHM2aytkcUlsbElHNTFSRERo?=
 =?utf-8?B?OVlXaGtBb25kWXh5OHFWbHlQUDJIOXIwWk9Vb3JjTXlMZUZoOWJjRFgzUFlG?=
 =?utf-8?B?b0Z3RFVwUDd3LzBpM0RiYzg0cisrbmlUU0VmS0drU0FmZ1VYRVNNYzk5SlF1?=
 =?utf-8?B?b3ZGZmxjRS95ckhUN0FrbFVtVzBjZHlMMm1nWlBWQS92M3lXOXBHS0pIL0Nh?=
 =?utf-8?B?aU9sb1VWQXArUnNOYzNtMU1XOTZFbTlDOStWK1FxVjQ0aXhuODFWbTJYczZC?=
 =?utf-8?B?WTA1VjlpSGdBKzVRRFpOQ1I5SjB0UlRUZ0hVZFc2S3lNMW1pQ1dGNkp2bExW?=
 =?utf-8?B?RlNwa0x0U3lVdlBwakVIaUNzSW1Tb0l2ekRuV1k5MnVHRjcwSDZFWU9VRnBH?=
 =?utf-8?B?aW1zaHR3RXdhazhSTURCMXNIWUJJdWE0STFjN1VHSGlsS1o4Y1hEZWg1dFA2?=
 =?utf-8?B?Z1pEdkZEUE55TXJ5Q0xuVVlySHJLNTRuRTBzaFlJTkpEZElSWUFlTGh5NHN2?=
 =?utf-8?B?dy81K2R6T0FPNnMyM2d4Y0hKQUFhOXFJSTl2VHJ6VHRPR3Q2NE1wcGNxb0hy?=
 =?utf-8?B?Q0o3OUJZdDAxeVc4Y1h4SFdEeTdKeVg1MHZSSC92VTNwR3pSa3BENmtobTZV?=
 =?utf-8?B?UnBwa1ZQUmJnQlFEQzJhaFdMb0k0eHhmczBUVlhpTWJ5KzJPN2RoRTI3TjBv?=
 =?utf-8?B?N21UY1A0NGVKSGFiMDY5NjBaS0xwOTJuQ3k3RUVvU2ZObEU0TVVGaDFJWFhq?=
 =?utf-8?B?MmluWHRaV1lWWmxVdzRENEFucGhieWIxL1F0TUI5RXdKNm0rUURzM01NMHZ0?=
 =?utf-8?B?WFVhYVZ6VENoanZBZkh5MjJJYzhzOFlmK0JxYm1kenA0bUxGd1krTVdnL3VY?=
 =?utf-8?Q?dGABwYO4JkOOYwdow64kbKBr8t1zl8G4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0pBVzZaRGlMblNpdDhnaUNlaDRPanFHZ2FGVENwdnRXVmdETVFOR1R3bCsw?=
 =?utf-8?B?MmV3a0paRDVKVXZsWDhweHJDRThUUlVyU1ZKSXNneWxIT3h2cG1XQ0pVRi9w?=
 =?utf-8?B?T1lPZVZjT09SL1FhQ0J2dmcreDIzdVprSjhsWU5BdXhnb0RkYTRNY1R1cmhP?=
 =?utf-8?B?cDRDZWVwT1Q4cUh3WWtMeC9sYmJzN1krQ3liWHB3RFM2NkdZTGRhNmhKNlZP?=
 =?utf-8?B?QlMxUnJJNStVOEd1d21pZmpJL0ZTc2VEV0dBcmhOMkpXNjZXbEdEZHBiK2x0?=
 =?utf-8?B?MGkyMXYrWmtycUhBWnR4bDRxZ0ZnZDRtQXFhcS82NUJWQ1gzRlVJYU9ITlFD?=
 =?utf-8?B?RUYxakNaM0dIS3ZlOHpyeFErVktIcGxQK1RreHkvamJuRmlHeUxaeHJra3kw?=
 =?utf-8?B?NmlNcjlOOFZCajJPV0FPT0hDRG05Y2pkdlMzRUFEeDdkNm5IMzJYZG9kdU9k?=
 =?utf-8?B?Vk1panZqSllNTENBeGU1RjBWL0o3dVNhcmxZVFZkV2lqMnJTdktwMFkyd1hz?=
 =?utf-8?B?RlMxeTBBaVNCL3BxQThrQUlWODVmOEpiNjJVSVR2OXNtNFlzaWtFVTZJdkpL?=
 =?utf-8?B?ajB1VDdxYW4ycGJsSER3WjczSmY3VUU0TWtWQ292Z0pMb3hOczZUQStaaWFG?=
 =?utf-8?B?Nk5sU0ZDWDBvblhpbjF2N21pTEsxUGRzWTF3SGM5bUpBN200dCtac2g1eW0r?=
 =?utf-8?B?ZWJXWXYweThxSTV5bHpQWmxaVFlJUmFNaW8xdTl5TXlXQndNNW54UnBESUNH?=
 =?utf-8?B?MXZ4czBwOUtFQ1lnekxNWWt2eFROalBEYndqWDF4dVg0QWU0Qktab2xuZ2Vh?=
 =?utf-8?B?N0ZrTjNiWlkwdWYrS2ptNTZaQlhKRmQzSHRLQ3FHMFNZMldnN1FXV0l1RkQv?=
 =?utf-8?B?RXFsaVZXU1JhWE50RWMvUkY5MW84T0F5Uy9kdnNhMFRNUmE3WTY5RnFMMm9t?=
 =?utf-8?B?VjJ6a2M0dU8xSm0rODJrQ0tsc2NLUHFTYTRmZFFDRUlIanVML2dkM3lFcWp3?=
 =?utf-8?B?QUwwSzU5NG42NlRnQzlUNU56a29FZHBNdXNIcTlvZTA1WFMwTmdMWTRwZVVE?=
 =?utf-8?B?cEUzOVdEbXV3SWROcnp4bnRoR3JpRU9xWEMydTBiRWdJVmVqdkdrNjArcERa?=
 =?utf-8?B?Rm9xTkUvTGRINm9GUC90YTBobWZwVjU5NTR4VTB3WUU0NlBOdE9EdVRiQ3lx?=
 =?utf-8?B?V0ZmR0c5SEVWeXdFdEtnS3g5ZjdzZlpYOGZ4ZGVtbzJFK1IvK3Y5NDF1b080?=
 =?utf-8?B?RHFuTzJLWjlIbmluUkxlU2JEUjFpRmdRSU1IMFRNQ3ZEWU9CY1grUkFrNXUy?=
 =?utf-8?B?dEhmYlRiR1FnbVlzbFNaalRibUs0bVJENWZETnBUSDIzS2NiOVlrOEwycGtG?=
 =?utf-8?B?VFhYUldzTzdJbityYm1Tcno2Q0NHbGlPTXM1eHA4eng0NlNSLzF4QnJNODhY?=
 =?utf-8?B?WWVoalFQeGlUV1JuTkg5YjhXUFlSdk9YZjFFY2JrTHhuaVJMUE9pU1BMUkcy?=
 =?utf-8?B?YWx1YWl0VU5nUzc5emZSVGxGTnZqZW5aNzVoMlhJQ1lsanpHRDJBOEtwdUlS?=
 =?utf-8?B?VVo1S24weDFDd0RndkZIREFsS1U1MWtrcFdsQ0lENkJPM0lSS1p6c1Budkhp?=
 =?utf-8?B?Z0tpZFR5ZmlXSVdJNTBvNUZrQnNnem80VUllSW00TmVTeWpGcEZRWG1ERlFh?=
 =?utf-8?B?cEx3OWM5M1R1ZDRXNWtMbk9IMGVycjhBLy9sN2pqNXdzUE0yTHBuTzc2R1FJ?=
 =?utf-8?B?RGtnUnR5R3VLU0hNK09EeFpPeHVXa2RQRFNlWEFhUWJLbnJXNjA2cnB1NGpj?=
 =?utf-8?B?UDdSQkorTU1NQ0VrWXBpNk9OOFEvSjc5THN0NFBLWDFGTFc1NzdYMGtRQlFu?=
 =?utf-8?B?NmV2RnlSSFl3TS9McEtQUTRXZnBQZytTMkVCN0NkNjNWMVJXaklFOFhTN1gv?=
 =?utf-8?B?T0lIbmt6NnhUSThlMXNRL3FuM0dJOVZpQmRQVk1hNWMzYXBNSTFncXd1bTY4?=
 =?utf-8?B?MHpHMFNnWWNGVHQ0TE9ybGVUWjVPeHp5OFdQYjNWMU5EeWlJd2EzdEZYVmV0?=
 =?utf-8?B?bWlENGNVVWdMd0g2aWpkL3AzRi83cWNSeXg5Rzl4WlB6ckY5OFJDQkZwRGlG?=
 =?utf-8?Q?VJAmyHsh4mQ5+acOLOg96ahbV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ba0c48-ee0d-4a72-d2a3-08de26273f1a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 22:18:33.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT2npzzrpEWShK4Q07ZMKDxUS2cDNtHmV2Tyq21Ncbv6d6pQos8pVKAOJPpAGAOkpcNyEViiDpfrgxSdmZDBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

On 11/13/2025 10:33 AM, Timur Kristóf wrote:
> This series addresses some feedback that I received after the DC analog
> series support landed. Harry already gave a review to the patches.
> Please feel free to let me know if you have any other feedback that I
> should address regarding the analog connector support.
> 
> Timur Kristóf (4):
>    drm/amd/display: Fix warning for analog stream encoders
>    drm/amd/display: Cleanup uses of the analog flag
>    drm/amd/display: Cleanup early return in construct_phy
>    drm/amd/display: Move analog check to dce110_hwseq
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
>   .../drm/amd/display/dc/dce/dce_stream_encoder.c   |  2 +-
>   .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++++--
>   .../gpu/drm/amd/display/dc/link/link_detection.c  |  2 --
>   drivers/gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +--
>   .../gpu/drm/amd/display/dc/link/link_factory.c    | 13 +++++++------
>   6 files changed, 25 insertions(+), 16 deletions(-)
> 

As these are reviewed by Harry and display promotion testing wouldn't 
catch issues with analog I've queued them up for the internal CI to run 
on and merge.

Will let you know if anything crops up in that, and if any future 
promotion tests fail and it bisects to these the promoter will respond 
accordingly.

