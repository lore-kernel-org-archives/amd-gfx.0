Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F04CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 09:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DEB10E646;
	Tue,  2 Sep 2025 09:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1H8Qd33x";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2A210E646
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 09:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEoXxFyk2446O/DmdP/0LTW86XPk2ZLhmZkZg0UGPWytlFS8h8dhXpkLFZvJErfCvw28afn0bv7tr/ryXFRgDKvpOo5c3KGVbAXdU/N0BiE93UHJhEo+3UxjV1iq2vLDJFc6kyiu0E8UK8XgHvRpujXVhFwPYPu7RPPunpQuvvXJ8c4uD9UoQmVZ5XytoOWr9Pva0fzgzgD432IecCY1IiAYvNFRMpZZRIgbHpcLcJ0jx8pmDd8YP9bJS9yG8Yl+d96BlQ2fktk9NN8ldoycOqHjWW5LTgJTRWVsuUuVp7fAjWsBUNFN54Y5U3BXkAWsdRPOuqR+Liayh0x03Dizog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYDqsno0QXIgg2o3j7cxY53niA5Z2rQsodCoNVK0jKk=;
 b=tb5lP8XfQzjRSIsxcwdposi9nRC80stkaR2teIuEQm+ISwMQoACo+8TZVWqAbovV9UmD5EQNLP1JxryLkHUqdqPKNKyXSSnmlSd+WjBkXeRhJOewJiTLfElAiC7R+PwuXPbnqb+fmCC5OE5EuZaIVytH4E4fCGCdsfo/8DDLrljo/be1fAKXHyWxUj0lTU0R5OU4QCCqi4dr8uptx2tvLZwnvxdZV6hs3wu5OcTHV4DM/cwQETIx2B7wonC77QY0wp0yC9zCaQK5Oi4v0TwAaLB5Q2AtV384hIhZH2769XFV9dVJIf946DOz8cPd6/QS5zwavR/3RmqwTdPUVik99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYDqsno0QXIgg2o3j7cxY53niA5Z2rQsodCoNVK0jKk=;
 b=1H8Qd33x6LgoXa2c6xncWnIvZU0LX6tIoxBgbI6PBNXFgHIIntZY3gbDAGYvU2uiKgMSVOG73Mmt9gOPp8zramb3Si3rRoHkIQsvrZ9FarTvksYtu/silRNm8EruAOcXaFSs9I/X7eNEypQm1EJNKus7O3AO+AjMWsd4JWWvGfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Tue, 2 Sep
 2025 09:54:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 09:54:30 +0000
Message-ID: <9b366fac-4a12-438a-a630-98f60b3e49c4@amd.com>
Date: Tue, 2 Sep 2025 11:54:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
 <64c1bcdb-8954-43a6-b0cd-90c75b29d3f4@amd.com>
 <6b780734f2e33ee4351b6c605f33e95a84a9b752.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6b780734f2e33ee4351b6c605f33e95a84a9b752.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 5340a39b-9c76-4905-00ee-08ddea06b606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzVyY01lbk9RR2NWK3RXRFF6N29aSGdvT0s2UHdmNTduSlN6Z2tQUW5WbXZQ?=
 =?utf-8?B?RVptb3RRUlBmQkNEOFY1a0Qxcy8wWHRHaWF6RE9ZazBqdGNVYXFSZHA3eW5K?=
 =?utf-8?B?TXFVOHpseVc1SUZDWFVvVDZVL2hzSDhUNHN4VzNtbGdTNVcwQ3BpaC95ekZ6?=
 =?utf-8?B?ZVpRc05nN1hBSVQ4S2xQYWxvMEVLeWdnUThmMkhxc0R0WDRuNkMrTGdUbVJE?=
 =?utf-8?B?bHZxakxpWFA2OWNhWnVnRVNudU0rb1hhZm0wenp2NzFSajZjWWh1YVQ4QnlT?=
 =?utf-8?B?cGxxOUptUjZrWExZOXNYRERXcTdVNDNXcnRHSkJuczFpcWdrRmk2N3EwbHV2?=
 =?utf-8?B?VGZRbzdvbTZ3QmptWi96MURQSFJLZzBDNWtpV2Iwc2wyeWc5d3hGYXBQL1BW?=
 =?utf-8?B?cHh6bk0rWVdXWXlUajRoL1JlVFNsbjBYZk5vamk0N1ViZElyTWU3ajRYNG9V?=
 =?utf-8?B?QTkyZzZuM2NReVFGTTVOT1p6K1I1SDJJVXgrb0U2cC9BNW05b29GU0ZZMmh3?=
 =?utf-8?B?ZTJRSitWQUFKYXc0dUU1YXZWOUlNZW5yYU5PcmpTVkg5SGJlcmZFRVlmMG9k?=
 =?utf-8?B?LzdBN282dlk5Z0JhZWpyL2ZLbTZyRDUrb3d1bFJGUmJIYlNvenR6cUZ6amQ5?=
 =?utf-8?B?SWhMMHpJWDBaRE1hZ00vblRmamxoK2RYNHc2YXE5MUIwVkdFVENpZ2d6ZXZy?=
 =?utf-8?B?NkRhUzNhWk00S1l2cE9WQXNJaTM1UFp4RTA5SVJYMGpiVnRhTlk3eFpQWm1I?=
 =?utf-8?B?OGRxck1qU2VJSzM1eUtyY0RGU3ZKRlU1KzE3QnlRb1hud1hDc2lpekRaWjRv?=
 =?utf-8?B?VTNGRlVRbHZaWE1hdmpPS1Y2Y3lNcThMOUpDbVBBc3oxYUNvTVpzb1ZOSTB3?=
 =?utf-8?B?dkpYSk5xcktKWThpdFl4NWZWb3BGQWtabDR3a0tFc2FWUjlnYXl6V2JoSFpX?=
 =?utf-8?B?ZE1Qa3pJRS8zMGJISy9aeUtxaDVVVW55VlBKbXE0L2V6T25iaHBRV2FmM1RJ?=
 =?utf-8?B?U1RJaFhYbWUydzBkd1ZJRTNYUG5BcnV2YzZHUzhJcnAwR2I4RWE1MXdPOFNG?=
 =?utf-8?B?Z2RmRjJhQXFNdm1ubEFJSDQ4S0tqWmZXYjVXdURKT1QzL1krTHlPNVJ2WDRj?=
 =?utf-8?B?Q3JHenBqdktIVzJ3dGN5elRiTXE0NDlLc2FjTmdRNUlTMHM2V1pDamVGWmJu?=
 =?utf-8?B?a0ZyWC9oY1lpSm5XTS9yck1hNkZUYXZnbmxzRHNLUTArUmlMbGFVMnZDRzlq?=
 =?utf-8?B?TGZpdGhSQ2RjNzZtRU9Ia2ZDaDNiaWhBQWJSN3VMT1VWWWttbCtVVWNvYTdv?=
 =?utf-8?B?aExVbmtoLzVwREpZU01ISUk1VW5OT2phZTV2aGRFcGxMVmVsalRsSjNuLzlk?=
 =?utf-8?B?eVRyQ2VhcDFPTUFQbHd1NGJCZWJyWGNLaGpwUHZuUE9EalBnR0tad05QK2p4?=
 =?utf-8?B?a3dNRElSMGV4WjJPR0xWTWp0RnpjNm1RWkdmc0ZrN3pUN3hmQVBPdlB4dXND?=
 =?utf-8?B?YlliSkdlQjdMay9mQ0ZBUHFMTXNjU3Rsa215SkNaRTBJMzVIbVRwMllEOVNr?=
 =?utf-8?B?R1E3TElVbkJKVEhDdGl2WDlRUGVjNTU5L1FrKzdGbDNsdHY4MDNBNzlkYkpp?=
 =?utf-8?B?ZTVFdEllT3hFb1hKZkFkSnlBQ051OWpQWWc1OU1pQ05wNi96TVIzajBDK1F0?=
 =?utf-8?B?Um5uL0JkVVhlRCtXam4yNUdCMEhDRGd0eDI2YW9LQjhpRkp0QzhrMTNGaTQr?=
 =?utf-8?B?RWQrNjBHVTdrcldlSldKbUhudDNwZUtYZFhEa2lDYkFlOGlRV2J4Vm5TYWdS?=
 =?utf-8?B?UGl0ZXNrbVpTN1Qwc2hXK3BucXNsOWpUNGpjbW4rNXVzSXpTY0d4bzZoVFkx?=
 =?utf-8?B?ME8zRVVUM0tWNVVFNFMzZTFJY1Y4bml6ajBDSnZHQjI1d2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEV4ZWN6V2RlN1VCVnBLMlJMdy80UzZQem83WldaengyTFlyai9VVFhTVEdy?=
 =?utf-8?B?cWYvUHIxZHVhUHZUNU80Y05wUHN5eGd3eWtFT3oyWlQvemlKWGdSUlV3R1Rx?=
 =?utf-8?B?alk3VktsdnRvRGxSY2g4Kzh3eHc5UVhXWXUvRklxSTJrMkQ5NkJ1dGRydVZN?=
 =?utf-8?B?eDh5VDV0UEdjajVWVUoyQ1ZhdzFNWHo4QmxvZlpzTC83K2tFeDZWOHptQU53?=
 =?utf-8?B?b2lvd2NuemhRQkZNazNjMDlLMTQyM3IvNGdZUWVzSlBFcUZsY1pvOHpjdmxV?=
 =?utf-8?B?QzJyeklsSkNsS3ZLTHppeHdMamJQWk1sS2Z5eVo2ek1HRWZJVVJGV2NqclIz?=
 =?utf-8?B?WkZNemc1RVZacE43SytJbGlNdU1xKzhhdDh4T2JSRktPMEd4WGNRWVJRV2ps?=
 =?utf-8?B?VWlOb1FBY0ZyMXk0ajd1cEdZOTQ1aXhNTFBtVHBsRGVYcVRWakZ2T25WQjhj?=
 =?utf-8?B?c3Q3dCtYYzc1cHYwWURIZE5nc3hGZlFqdnNyUzVjT3lJUXowc2dIL0d5ZzRm?=
 =?utf-8?B?TmJJN1VnSjJ2aVl2djRsVE5Eb0N3K3pOMnJ3QWtUZkMvczk4U21ESmMxWjFl?=
 =?utf-8?B?NG1jMXJ5SERnZmNjTXpuMlE2K2xjV29RQ0Z2b1BvUDRPL2dHOGxFaXAzTXVs?=
 =?utf-8?B?VjFTZDRHVUE4b0JBV2I0WXpyeE5TNDloQXdHQ3dzZVpUN2tCUTBTU3E4TWx1?=
 =?utf-8?B?aXl1Q2taL1VNVUtzQ1dZNXhzVDB6S2tXYThXd2FISHJ2ajJzcEFLVkg0NHlm?=
 =?utf-8?B?Rm1VZ2lWY2VxSllFTEQvbVVkY2tLYkhENmhOY2x6VDZjYjl2bHVUNC9ydFhO?=
 =?utf-8?B?SGthd3FtT3plMVQ0SXE1R2U4VFowVzdRWVdSM1pwd3BVaFhmNCt3eGRQNC9L?=
 =?utf-8?B?Y1dIdit0d0srQmdGNWNFUTNXa2RlaFhPWGdRd2ZXQWFHVW1Sb2tzdi9PUXh2?=
 =?utf-8?B?RnFlMC9udDJRb2pGYUF0L0FFSXpYY1hESitTb2xLV3NYdGk3TGFJeGpmcURV?=
 =?utf-8?B?MS9BZ1pWQXk5TTlvYnpRcFRPMndocGw5YUtJNGh6SW9IanJSK2VrV1oySnlk?=
 =?utf-8?B?V0RLQlBqMTUzalJ5UHJtcDNHZjdHeitmVzlmR0hqNWUxYkplZm9LVGhGRFVn?=
 =?utf-8?B?dGhtM05aRk5UdVo2NWFvNGtSQjU3QzRFU3ZnQ3h6VEljaWdDSUVBTTlvY0R6?=
 =?utf-8?B?SEUxeUJKc3FET3Zjcnc4ejRxdEZpVzFFaDZYdnErb1FueWtLRmNjRG5qTDQ3?=
 =?utf-8?B?bkZuallEV2M3dlBjdUJwN3VuMy9xK3ZGS1VqbmJ2YjdvSlZXanZibis2MWFQ?=
 =?utf-8?B?V3NyV2ZsaHdMNmtRVWZZNXBzcFFoTDBXVkl5RzF3ZXQvVlR2dDEwZ0pxWmtY?=
 =?utf-8?B?dHpFTzVZZFQwT3Mzd2lOdVlJcjQ4NkxUTms1L1hWcVQvNklEUW9WeXhqYXZU?=
 =?utf-8?B?cVZ2L2tYallMK0ZBOTA2L1E4T0NBUDB4R2ZjU2dUcmM1ZDhCVEhOSnJweWpx?=
 =?utf-8?B?UVRRSC84L3lQTW9CV21iRjNEL2Q1NURTV2Z1akRjclRISTcwL2ZucUh4SXpV?=
 =?utf-8?B?TDRTdzdHcDhhR28xSE4rN0tsT0VpZjFKNGZLMEpUUHRMY3gvbUg1WlJUNlps?=
 =?utf-8?B?bTJOc0hmSVpVdXJJYzRGUkNxOStmRzAwOHdrM1BpRTNZWDRlUWx4VkF0eE1a?=
 =?utf-8?B?bW5ZbjR3UWhXRGRnZmprMU9pQnYrK1haZXRYUGEvUnhzaHZVdG92RG1WZlJu?=
 =?utf-8?B?Z0thSWZycGxIc1N1Z0s3YnlIamhxV0padFlkcnpHVWJ3QzNWYVB4ZkJwVHlG?=
 =?utf-8?B?Z00zQ2huNkFRM1RjbVhJZm45dTRENlFkQjFaWnZmaENkcm56VnlFM0swK2s1?=
 =?utf-8?B?Tmo3UEFEbElLelFNU1Q2TWhyQXdONlRjalR6a2pPaDBKcnVGUXBZWkpZTGxu?=
 =?utf-8?B?Ynliay8xU1RkdlFsWmF4S1A1NEFPRTRuN2IxcWVCeVJ1Z09zQkdjUXh2N2sr?=
 =?utf-8?B?d0N2SDBWTnRwalVGQ2ZHc1JuWVdTdk5qamtVNCtDalpBMDU4NXhybGM5dzBl?=
 =?utf-8?B?ZTlRUFdFNGZuZE5UOHRFa0h5SzE0KzB6WExwM0hNd3htT0RUSHZ3WXF4MWtT?=
 =?utf-8?Q?nJthKtDXcNqQrah7/zghlPmCA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5340a39b-9c76-4905-00ee-08ddea06b606
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 09:54:30.5120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh3sJ4I9J2kTa8jyrwufIBSyFJ+XnS7bMjCS+A1BPA1kL0SCHvmggVG/m0xGH5Eu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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

On 02.09.25 09:42, Timur Kristóf wrote:
> On Tue, 2025-09-02 at 08:39 +0200, Christian König wrote:
>> On 01.09.25 12:00, Timur Kristóf wrote:
>>> Technically not necessary, but clear the extra dwords too,
>>> so that the command processors don't read uninitialized memory.
>>
>> That is most likely a really bad idea.
>>
>> The extra DWs are filled with a specific pattern for a HW workaround.
> 
> I was unaware so it looked to me like the extra dwords just remain
> uninitialized.
> 
> Where in the code does that happen?

See vcn_v4_0_init_ring_metadata() for an example.

> And what is the issue that is being worked around?

IIRC on the VCN4 engine there is a HW bug which triggered when some metadata for the ring was not in the same X megabyte segment of the ring buffer. So we just put this small metadata structure directly after the ring.

On some jpeg engine you had to insert commands after the end of the ring to actually make the ring work reliable. See jpeg_v1_0_decode_ring_set_patch_ring().

> Also, while we are at it, how was it possible to initialize that
> without causing VM faults? Considering that the allocated BO was not
> sufficiently large to hold the extra dwords. (That is fixed by the
> first patch of this series.)

BOs for VRAM and GTT are always rounded to the next 4KiB. The workaround need something like 100 bytes or 64 DW, so that always worked.

BTW: I just found that vcn_v4_0_unified_ring_vm_funcs() is using extra_dw as bytes already :)

Regards,
Christian.

> 
>>
>> Clearing them to NOPs makes no sense at all and potentially even
>> breaks the HW workaround.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
>>> jpeg ring")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 7670f5d82b9e..6a55a85744a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -474,6 +474,11 @@ static inline void
>>> amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>>>  	while (i <= ring->buf_mask)
>>>  		ring->ring[i++] = ring->funcs->nop;
>>>  
>>> +	/* Technically not necessary, but clear the extra dwords
>>> too,
>>> +	 * so that the command processors don't read uninitialized
>>> memory.
>>> +	 */
>>> +	for (i = 0; i < ring->funcs->extra_dw; i++)
>>> +		ring->ring[ring->ring_size / 4 + i] = ring->funcs-
>>>> nop;
>>>  }
>>>  
>>>  static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
>>> uint32_t v)

