Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26BDC3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 16:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171B10E4F5;
	Tue, 29 Apr 2025 16:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="huZDVbuJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0096510E4F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 16:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWWVcCpGDn8iNpUfdl8ePTTwBKoQaDXqAbhZ5JdazPPxcTvoje9ZnCgSfCQxmXZAAx+wwt77jnQPPqqSO077+jgMq9E/cSRq48OOp2WJxIR/5XnGyd92AqLTzfw4YKGBT0B6/97NbIbIPqoZ9oZeiuDeMAb04fLKYbX40iZb+Rgjcc8MCo3XvjjLmaRD2mXljCwdTE0rFGXyT+na8yQ72p+WL1TgdsRPOoaGmfvX40V5zRuJdQMY4eF37TT1jM0vOwzTdaWhNrSpVYX4wzdWBLJAQ+nIRtt0tC1bjvYK2Ae/CdKBenvr+aZxyKApTLcoJfJpYXHC1dgUe7V4urZ12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBv9HPdPOjC6l3r3U2EoU8QGK3VgV4H3oHNXjcZcp8w=;
 b=d6/0IIvwNhXTbDL8V3jlFJMsmIluD7wZXDAiK+mGLjsRqinlZ0MG+SHG3pnZcXLgtzCDn8+JXrcRTmaZNudsdvUhB3+GQIe6mz1Ex+7PgniN1WGqE9TNvuW+q2BX75+AZl0SBjQqqd54k8ss4qQfeSAwBoOdkGH5WZ5cdLSM/pZoDcL7yaLfZ4VUEqPpZOzGscOIa+zawx6pVp7u8dtRKoDNtYQkbH0gmelsE1wRclzikItUYBFdaHcNmupyh/aXzlWX1j+B2MNfQUWOj5NlpO/jiS0NFxjXTjCakdwdvI+Z3b4D6Q670y6MocVsQsuaWX2Gfd6IORiL91jX0Uwftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBv9HPdPOjC6l3r3U2EoU8QGK3VgV4H3oHNXjcZcp8w=;
 b=huZDVbuJ/VGgx3NE6kKCJA76x6yZ6WYJNcYwfEildH1TMR44fKkrboYKDHAklDoGMpI+EgE8Ni8I44biZ6UK3YaGQW1OL3+2QL87NSmeJ/gI37WeTm4Zq1rUuZpl0NB81cc9O4UzjKqlfSjNCsIt1XyaBakfdJZjmXjW2d+I/iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 16:01:10 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 16:01:09 +0000
Message-ID: <7943c1ee-d383-4164-9177-f12338b12741@amd.com>
Date: Tue, 29 Apr 2025 10:01:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/28] drm/amd/display: Remove unnecessary
 DC_FP_START/DC_FP_END
To: Alex Deucher <alexdeucher@gmail.com>, Ray Wu <ray.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
 <20250428135514.20775-19-ray.wu@amd.com>
 <CADnq5_NV3D1txYenNsit-3H6uqJDJ+rgOSHPbOtta24HmXqD+g@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_NV3D1txYenNsit-3H6uqJDJ+rgOSHPbOtta24HmXqD+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::15) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2b8725-88df-40bc-d238-08dd87370eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THhRM1ljYjIyOXR3YUdoM3NLNG1oUDFmZFhVb240YWZ3bUtDSTZOQlIwNm11?=
 =?utf-8?B?YXkrVHo2ajZuQzJZVTlqMTBONC9OMXVOSTMwOTg2eTZ2d3BsaGkwMjdBYzdr?=
 =?utf-8?B?NDhqZlFIVFRoT0ExVVoyc1E2TUxpdldWclh4cEc3OWhZMDN4ZVdjNE1BdmRE?=
 =?utf-8?B?ZzJjeDVOaDI5ejlNYlVYWXYzRnM2d1kzRjE2djVFblQ1UFVDS3IwNjJBby94?=
 =?utf-8?B?eEpMM2tVbC93NzR0bUt1cU0rMjI5WVJjcWJkcWdxcjBKOFB1SURYbnh0WXlw?=
 =?utf-8?B?alZQM0l3c0l2MWFWMDBvMGh6OENwdHdUblZSTDQxSVh4KzRvWU40elJsUlhH?=
 =?utf-8?B?eTJXRTFIMGxaaEcwSFhxQWx0Y2dhWDM1TlJzNmZxam1QQnkyanYvQyt0SzdR?=
 =?utf-8?B?WGlJVC9iaGFqR1JUWlZzbmtvVzFKT0hYQS9ieFhuUzdUY0tLbDNhTmRtNU5z?=
 =?utf-8?B?bFRmR0U0cDdyMHBIY0s4UW15RTRQRnhKMmZIbjJxSUNZVGRnQkxZeHQ1bnhu?=
 =?utf-8?B?RG5ZanlRdEd0NVlzSUh6SVgzVllpeVRTclN2N0J6VkNrZ0lxUVVBanR6ekxC?=
 =?utf-8?B?TXRRNlQyUHcrL3lubDQ4ZGl0c0xTNzkxVXlLWW9MVkUyZDU1SUZRYWJzUTc4?=
 =?utf-8?B?Wml3Tkt4QkZVZ3FKUGY5WElOUGRleWl1VlJ4Q1N5RVpFREIvM3BlYmNrYzNn?=
 =?utf-8?B?aGJ6ZEVrTDJpd0ZZMmpOQnI0UmJkSFRwSDBBbHA4ZitKTUZjUzUwUCtJTXlE?=
 =?utf-8?B?OWl1VDZybW9mblRQQkVPK3E1MzRTRWhTQytDZTVIVGN1RDZFWjdpQmw3ZThl?=
 =?utf-8?B?VUFiVDBwODJxa21XdGpOOHdpWnZydGMrRFEwNU1NR01DYUQvZVpqb1BVcjRn?=
 =?utf-8?B?WTJDNmdFaG9nWTdvbUhhVFMrZ2dON1dENUFzeUx1MGFDb21WY3VMOUo5RVpD?=
 =?utf-8?B?VXBQS0RvVjFtYlpVUEVXWnp0YlRLQ2RQR3E3YktyRHk4clR2cXN0aHpSd29u?=
 =?utf-8?B?SHRFZi8xdmJ1SkZBMTNra0dRc3ZpcGNKdWhNd2x3WUhnVmhBeU1vRU0xRi9B?=
 =?utf-8?B?VUpaMUhoNVptaldaSGlqWlNNV04vVlRpOW1Ddm83VTdEVjZkWlFNb3RlbTNH?=
 =?utf-8?B?V1JwOFRWTnRxZFN0NWtkYUI1Uk9vNW1mU1VBRG15N3dlRmxuNXdWM3EyZVVS?=
 =?utf-8?B?ellXQVdqdEw0LzIrbWgvUzNKMnlLUUVDODZRQmxDUmozMERzVThmWEFFWmgy?=
 =?utf-8?B?dFdwVDlkeTVNdDlveG8zUE4ydTljQ28zVVgwQ0QxWnVqaFk5YTFCZDIyMVJk?=
 =?utf-8?B?bUhQb2FLc2FkbGxGTkJhNkV3ZzBUaWt3MmxpQklrOE85L3JVVExLL1VCd05p?=
 =?utf-8?B?VnZMRnhRK2QxU3lLUlcvNEpMd3BlZlczaGVxSzBod1hoK1VMOWNldzRPcXRZ?=
 =?utf-8?B?Q29XSmc0L1dNeEQxazF6MUFKR0ZlVFpqYy9pNUdyVjk3VWJNeU82ZVJDNS9M?=
 =?utf-8?B?dnJaaDdqMFZIQSs1T3hEVktVa0U0OGkxbDVvV2NMU2k0OXpvbi9raGFCay8z?=
 =?utf-8?B?WDEvZ2lWUDBnREs4YnU1dDVNUFNERkplK0xHWmVJMWMyRWFFWWlBMzN0MVF0?=
 =?utf-8?B?Y3hkSEZMalVoMGRXaWJJdzVyRUhZT0cyTEwrUmtlSk9yUWN6QkJ0TDZ2ZjdX?=
 =?utf-8?B?S1FKanZhOTZSMm1XOHBSWFVUTzlaVnZ4TnJjVHhCTmV2SFlWM2JUMWRpMG54?=
 =?utf-8?B?WFJlMjhyZXk3cmIyOFhmcFlNaFJucHBqR2JBdnV2Zkdqc0V5K3czcmthalNs?=
 =?utf-8?B?UkVHK0htR2lCaVhNU0l0dUE2b29RekYyV3ZrVmtKd3FGNjFHNW8yQ3Q1c0Nn?=
 =?utf-8?B?dmVmRytCSDd6blNLVWpyaHpEZzRRVkVrWWxyS3NudUs5YjVwdVV5bUhvbm1L?=
 =?utf-8?Q?wkDZAGoMSlc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2g1RFI1VnhRTVZrNGphYThwK0NHQ0o5eVN6bUVaUHRidldnQkdsR0FmZG1I?=
 =?utf-8?B?UVFYRmwvYUNWVC80SnFNS2RoSWkzUkZYd2VIdTM0aGNQaUR5YVlSUkpBNmRM?=
 =?utf-8?B?aTdLT1pxN2JqSnhtSnlzYUZFWSs4R2YyeGtYVkRmTU1YS2JWK1QvRGloTWk3?=
 =?utf-8?B?Vzg0ejJOU1RDeTBHdjI1SHlHNHFnRFZ3b0ZHL2FkdnJ2clk2TXRGSVdPdVcr?=
 =?utf-8?B?d3FVSEJER1Q3djY1amtRaTJ2c3l4Z29TUlUycHZPZE1neWJ5bjR0L1VibGVU?=
 =?utf-8?B?YlArRUNXMTFSdC9lOGlUdHVlUkFPYUJDam96WC9mTUV4RVB4VVdjRml4NnlJ?=
 =?utf-8?B?SkFQbldxZWhyRFZ4Y2p6QjZMNFpwdS8zV3RrdHI4aUNaZUZ2czBlWjF5UnF3?=
 =?utf-8?B?U2VtZ1d2RlY5NFd0UGlNenAzZjAyRmQvekJKOFJVZm0rWGRiL0xGcEFNelZN?=
 =?utf-8?B?Ynp0Sy85STVFNndtQlFiRUllTWhjanVRRGRtSEc1ZXZ4SVAvckIvTnJ6bzNL?=
 =?utf-8?B?b1lzcit3Uk82SWUxMGVONnpyN0h0WUZFYnpoMncwZXY2WWpRRCs5WjdOVnpE?=
 =?utf-8?B?N3BZQ3FVY2IxRVZ6cXBsajhGeVpZY0R6d3RUaEdFOWdPTXk5dnZQUVRqcFJn?=
 =?utf-8?B?anBoM2RrdGF4am9qZWZGZmJWQWVabFNXRXJWL0tYblM0NnQvZjV4WXVQUHd4?=
 =?utf-8?B?eXV0emhkTFp1a2dUTDZIQkthOFE5V1grUHhBM3dNVUh5UzB4SVNELzhKQy9C?=
 =?utf-8?B?L25FVVZMWjErd0hScFFTRW8vOW1LYlFlemxtNElsTTJ2aEZocDNQM0pCb2dG?=
 =?utf-8?B?bjltaTNYNHdxUktyVDNoU05CTWRqUDBXdDNjTXdhM0FXYllHdVMyZVBKeW93?=
 =?utf-8?B?VlA2THZJc3VXdjNua01ZUDlCRnVCdTRQN0VadW1QaTduZnJtbmg5Z2hrSkJZ?=
 =?utf-8?B?L1NrdWF3a3RKTUI1dDhuUGFqMkwrbnJUcnZubCswcW1sRkRYbzVndWgyYWVP?=
 =?utf-8?B?ZGVFQjNZY1dlUlFuSWZkRXAvckk5QTRUb1VPUm5JNGpNdE4wTjRiSno0UVNJ?=
 =?utf-8?B?T3R3UWFVNkcrVkV6ZXVCN2s0QnNYS0hTc3VhL1dXTUg2VEtpZnpxeEJoNG9L?=
 =?utf-8?B?UitxaldaV1VGYkQyV3hIMjBOOUt2T2VvVmppcHh0VzE5ZmpsTVlIaUEzdkF3?=
 =?utf-8?B?aXBiUk1kVXpOMnJOaTZiMXZwR3J4NU9yRFhXV0VSSDY4cmJ2eTJYdEtNcUxx?=
 =?utf-8?B?Y3pYTFB6N0Q3alQ0QnhlQTRva1E2dGsvdkpOU3FCQ2pCSlJKb29lL0JqRjM2?=
 =?utf-8?B?M0s4enNNZW1VR1FXek5GbThMaVVPUVhESWVpSFliQ2I1VWJlN3pDK3MxazlU?=
 =?utf-8?B?UXFpcVFrbTlCRHdheU9zUnd3M0xNeDdvd1FEK0NnNW5VbDZ2MUFHR3o1Vk9G?=
 =?utf-8?B?S3p3bjZqdHhaMkJ0cFJ5SFFTRWRGNUlsSXdpam1TZTZCSHUvemRkU0toQzUz?=
 =?utf-8?B?WDRPMTJoblBxcXZPaW92UUk1Qk1WMTZGSE1GWHFmaUxBdmxnZXl4ZC9CYm11?=
 =?utf-8?B?VU14RTJidWxNc1J6eVovbU80VGdaOGJzZWZwQUpyVVJtTUNkemc4Tis2SFM2?=
 =?utf-8?B?WWdpdi85M0NIdCtvdEpHT2J3enhlVjNWYU9jYVVjbDdxMDJmUVJ1RXJwd3Ew?=
 =?utf-8?B?OE8vSno3eGhFa1VoWHdyRWtGQVJ6RjIzbVNtdGNVdmh6Wm9iOC96OVNrNFps?=
 =?utf-8?B?WDEvQW5VU1QyWXZGamFVS3NaUkFudjRlRmRHM1ZnNkdsR1puS0tLeHZLMS83?=
 =?utf-8?B?TlVTT1dCY0JrLzdHTnlncWVMZnhhK0dyVk52bWt2YzNRWmJKMFZqam5TMjk3?=
 =?utf-8?B?aHV3M29SWGhuN1ZxWEtCUW9jWUNmTEk5VGgxR2JTNTNLdFJUYWh1UGFRank1?=
 =?utf-8?B?bmY4MlFKSlNLcjJ2VGg3emcrVy9KUDBPMnY2NTZWS0ZuYzdLZ3dGUUkwSlRi?=
 =?utf-8?B?b0FVSGg3dk5NdjVSQkI1d3puMzBPWTNvVWZ0L1VvVk9NV2NibTY4UDNjR1BZ?=
 =?utf-8?B?ajZnc1dTRE8zUDVKTVRDWkZzUHJlQTV2b0pJNWFldWhUY29jdEQzU1ZjTUVG?=
 =?utf-8?Q?Luo8gdYZeqhKsPUtHKVdFJRx5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2b8725-88df-40bc-d238-08dd87370eab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:01:09.7377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/vXf3oCDwuo8Tm0T4DnIhGfSLC/75JqGvwYbRRJh7isY2ewhn09WXaRrSG1MBw5AlEJaMijsVyO5cThteZicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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



On 4/29/25 09:04, Alex Deucher wrote:
> On Mon, Apr 28, 2025 at 9:57 AM Ray Wu <ray.wu@amd.com> wrote:
>>
>> From: Alex Hung <alex.hung@amd.com>
>>
>> [WHY & HOW]
>> Remove the unnecessary DC_FP_START/DC_FP_END pair to reduce time in
>> preempt_disable. It also fixes "BUG: sleeping function called from
>> invalid context" error messages because of calling kzalloc with
>> GFP_KERNEL which can sleep.
> 
> Is this safe?  If this function uses FP or calls a function which uses
> FP, removing these will lead to register corruption.

I checked dcn32_resource_construct again and I did not find any FP or 
functions uses FP, and Aurabindo helped double check.

I also checked other dnc*_resource_construct (like 321, 35, 351, 36) and 
they don't use DC_FP_START/DC_FP_END pair either.

So it should be safe to remove this pair.

> 
> Alex
> 
>>
>> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> Signed-off-by: Ray Wu <ray.wu@amd.com>
>> ---
>>   .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>> index 2a59cc61ed8c..944650cb13de 100644
>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
>> @@ -2114,8 +2114,6 @@ static bool dcn32_resource_construct(
>>   #define REG_STRUCT dccg_regs
>>          dccg_regs_init();
>>
>> -       DC_FP_START();
>> -
>>          ctx->dc_bios->regs = &bios_regs;
>>
>>          pool->base.res_cap = &res_cap_dcn32;
>> @@ -2501,14 +2499,10 @@ static bool dcn32_resource_construct(
>>          if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) && (dc->config.sdpif_request_limit_words_per_umc == 0))
>>                  dc->config.sdpif_request_limit_words_per_umc = 16;
>>
>> -       DC_FP_END();
>> -
>>          return true;
>>
>>   create_fail:
>>
>> -       DC_FP_END();
>> -
>>          dcn32_resource_destruct(pool);
>>
>>          return false;
>> --
>> 2.43.0
>>

