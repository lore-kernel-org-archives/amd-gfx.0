Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E7C3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 17:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6638610E42A;
	Mon,  5 May 2025 17:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOAsrkYQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C3610E31D
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 17:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyeWbF9LEcw0KgAYnTPPT8Ykh72c+CB0SzEFRWi4v/5N0uZLI2ZEQz5j5j2iwqZs7OzGg7UjQSCASlYZ15aBziFyyt1ejwmoUwrdxITSukp2N6ZXqC31dgTr/T3nHdyO3/Hbl5dQ/tTWpBDq+9F2si1b8MHeKPtLFIyCGwjJ0uNH4NrYaJVkNoQgNc8lyE8eTBsNr8XZYbkCq6eXVCP79Is61kr8wna9tTsVgW+Kw4JwNwsoXrrtsGC7GaOj89CQsiDu94w/EoIKsScR0ClVGqoR/ANTWasMHJJ4sW9D8+eefuBn0hkoTa07cXaa+9CRfpBJGZdliHI3j8dIbKHjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkmQfOLUtGnB2KU5HBd+3zhmi/lrQ40S0ywsdP+0sP0=;
 b=foQf+FogH5wWAr3LmhJ+uDTZqhTe+mH44ctY+1KbcyfvwKPD/B9E6NPZkAxDdT7lUdj8Ac0J3phOVSuED+dxSVQYvOJRfNvpDX5q5kMGxuICopta4q3ThAVVsWicbevPt+4FN+X4Q3kejsJIhCLb+QHDxNsUQmKZdEHESFC3F+wzAHfJiy35BA+KigHGfMeTvZvqFhp+/dC6mu24bEKk+tL8g4T09WfnckKBxNtSm9WK6+7tftouZd6aU8rwtCHIrKbj3H/Xq2jyxvy0PSV9rMOYP4Pkf4d6RxkRiFXI9VZOi+rh9mjqMs0F32VdmNAUy70Ed91Y4BeS783iykzR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkmQfOLUtGnB2KU5HBd+3zhmi/lrQ40S0ywsdP+0sP0=;
 b=vOAsrkYQ8TXlh77PmWdE7H+YKR3iD87DKaZu7MjcvErtFSkgrOCy2ltlmBKmY5ahQXxPLSuW7v8Z6vkeMazCOXOhwHAXkjfbO8CT1A5qk8/kWAaRO6ZYOaJW7qywel0AK5arGEMeM+vwyzEpGV87TwulrvQd2CSTiV3sAiOJXYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 17:50:39 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 17:50:39 +0000
Message-ID: <3dc36f6d-7f93-4c10-9689-b65c6b8af54a@amd.com>
Date: Mon, 5 May 2025 13:50:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/display: Use optc31_disable_crtc for DCN 31
 and 401
To: Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250504221154.409695-1-siqueira@igalia.com>
 <20250504221154.409695-3-siqueira@igalia.com>
 <41016b22-d09d-4cdb-abca-a2ab016e47ed@amd.com>
 <3417c8d2-459b-40dd-ad09-5757bb279935@amd.com>
 <720cb274-b482-46a0-be3c-e299c03069af@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <720cb274-b482-46a0-be3c-e299c03069af@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::19) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 024d8fb2-88e7-47b0-6761-08dd8bfd591a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDF2SVpLdENMT0Nwa2NTM2FJMnN3b0owYzdsVERsbEpFRGI4czdMVEsvWjMv?=
 =?utf-8?B?eE9JWjlvVjdHdTdSMlo1V21VQ3psNEpvNnp1YnhCcFdBTmJZSWlBeFNtV0hI?=
 =?utf-8?B?U1NIQWJlaHpubDFnbmhCd1JEUUVndm5UUjVlVTVuTCtIMlFhcWJEWVVqRkwv?=
 =?utf-8?B?LzBlb29QWG4zZlhSU0pickFTMTFqUGZYY3NWZ1FpamJZM1h0ei9NdzF0bnBX?=
 =?utf-8?B?K1ZtZFd1NE9WdjlnRi9zTmVsbnMydkRVNk9XUklyZmZ6NVNqTXk3NlEzT2Fi?=
 =?utf-8?B?a1BiSE93cGg5UkJRUS9JQ3cvekRLMFVxUGMrYWRuZ0t2SDkzcVZQblhycTNW?=
 =?utf-8?B?TmJtM0VSdEF2SjdVK3NpSC9FM0s5TEttbTUwMDVBUUhMWFdNVHJhTHdQSW5a?=
 =?utf-8?B?THF0MmhCZ21sTHRKSWZCWXRVV1ZmRExpOFF0WG5pU2ViaXE0ZEVNYTBJRjBy?=
 =?utf-8?B?dGFNcm1wVDJZVlFwWjhwVVhkcnE4c28zb2pRQmNDeGxIWHNINmdBL0JuN2VP?=
 =?utf-8?B?TUU0OVpwS0N5L3NscVN4NnR1RU1mend5ZFVuSVA5Vyt3SkY3S0ZHRWZVMGFw?=
 =?utf-8?B?cDdPb0k4RXVCb2QwclVpeGprUGVsODBFM3hKc0FmRXVna1lrWnNhc1gvTkRx?=
 =?utf-8?B?VlVMZHpwN2MycDA4NWE5bUFOeDhLSXNvWk02Qk84TjdJa1JkSmJaV2NYKzFr?=
 =?utf-8?B?cEVUcWQ0VFNIQkdwSnJVdnp6elpnZW9uSzkzVnlpcTBNd3ZXU2dDMlhrYVRZ?=
 =?utf-8?B?Q3lTUWc3d0k1WTVtMS9aT3dzVFRqK3BwWFhWSXdtalYvcGFVYk9Ba3BKTktG?=
 =?utf-8?B?eXZ5RlF1OVdBMFpqTklXaUFtYjJ0VUhyWFhzVlc4US9sLzJSWUhaSXpDTmFO?=
 =?utf-8?B?cE1PM05KMFB3NzFpSmROQTVmTFgvNGFzd0gvMkI3YVRQSkNGQm1HNlZseFdi?=
 =?utf-8?B?ZmhhS3c5LzZKbnZjWXpOa250UVBJUmc1OTY2WmNJcFh4N3VXRjlHTDUxNjEr?=
 =?utf-8?B?Z1ozMyt0dTRnWG5OejZSbjU0cWl0NkxOclVaS01aYWxVMXhNZXlhcHd2VGRD?=
 =?utf-8?B?RXh6eGRYVVpJR3hOZ0hvZ2J6WWdxUVBqNGpjRmNUdEdmdEZ0UjFFWTJmTEZZ?=
 =?utf-8?B?S2s5UlBwem9RcnBER09CSmxiZGJ3SWxDQXVBek9mRjJUMWpkSkRLRHcrSGdH?=
 =?utf-8?B?cXQyV1lDMjZOSEVHNDR6WVp4QllENkZ4bjNrbS92V09rRjJ0WHcyTEtMNWJw?=
 =?utf-8?B?WmlSLzZnY1I5UW9ibkIxM1l1VGxCVUpMQTdBUnhHSXlobkQwdnZpSG92WnNv?=
 =?utf-8?B?Q01yeUp1ZmszbTM0S3RGRjViRUNSMXpCaFZPUG1rRzFYY0RGRDZ2Y0Y4enRj?=
 =?utf-8?B?S1E5TjlWTnB1UHlpbk9wc1RyNmdxWURjU1NlRzhaNkgvQjhja3pGVGhuaTdM?=
 =?utf-8?B?VXM2TkpEYlM3d0tWQ1g0WTZWZGE1MCtqbSs5YzJ0WVJzSmpvTDdRS0xsaDIz?=
 =?utf-8?B?L2pZLzZscnh2b0VpWDYzNmx4WE80amgwZUwwcy9HZy9rTGxGUTFGQlJ4UExt?=
 =?utf-8?B?ekFhdTRXNEZmWVhWUlBHVE1DV1FqUXNrSWhxMFptR09tUjhIYThRZUhDeUJl?=
 =?utf-8?B?clVEaUpiYWREOERTWGpPNk1zMkhPdjlqa2JDTGFONjgxb0N0eXJEQkk5SVZs?=
 =?utf-8?B?ci9SOGh0VjNnMkQvaHdHVWFraXZSRlJJdERLeHN4SjVDaEtERTdVYXBsT0Za?=
 =?utf-8?B?ZGlia1hLellNcUlLdVg2SXYvSEpQeDJtckxBdFArajZ5NzdaN2VLZnErbC9j?=
 =?utf-8?B?bGxGMnpkQ1IvaVpDRTRHd0RvdHRTODFnZTl5cFdJVTZoc1NBUXFqRUt5dXgw?=
 =?utf-8?B?Y1hhejRzVzMrM3R2L0V3Q0s5UVo0UnV3a1h2a2FsdHVvVC9RTVFBa05STjEv?=
 =?utf-8?Q?N24x0QxQmgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpObGdEWEY1THhQWjJhRjlDTzV4VkRvRHJSbWM0VVlWS0tYSjFUVWZocCs3?=
 =?utf-8?B?ZjRXYXUvT05UdFByVjVzR05ScVEvcTFwVitBMGJDbXpOZ2hpdUdVYnhVYU1Z?=
 =?utf-8?B?eFVXNUxvd3pOVzFkT3B4WFhId3FTOHZ3TUtaU0phV3RqS1N4TWNqWkxzSVZ6?=
 =?utf-8?B?NkVaN1h4NzBiMmJZN2NEaXhhT2pxKyt2a3FRWUNGbEZ4VGMyK2ZUckl4T2Jy?=
 =?utf-8?B?RXdVWmRRc3JzMFNWOS93a3h6YnhjQkpNd2VmNWoyUzM3ekNFdDZ3eENOUFdE?=
 =?utf-8?B?SlIzOUZmdkROREhOWHZ1eXdMand0UVJrL0tKTE5ENGJGcjNXNEtrUHV5ZVB3?=
 =?utf-8?B?TjRsUGxFU3lseWZRYUY5UDQvdXdTbThHRTJ4Y05FTmtBSDlYZzkxbXc3UHpT?=
 =?utf-8?B?SXVNT1FOVGcvWXZyK0dUdFRoRzV1a2p2VW55VjVVYThVUDlPaHkvbU9OU01D?=
 =?utf-8?B?OVVCOVNhM3VrMzQyZkZnZWdNOTFrV1lMSWYzeDBLOWlqUXJscVIzU0o4WFFB?=
 =?utf-8?B?T1lYOHpyemhUZjlZMEFGR3lqZjBFYU5jQVhXUjNScFd2V3lpV0xDQm4vL1NE?=
 =?utf-8?B?TjdidCtHN0RwZUxDMjlqN1VvNmNhaytoTUJSakNhbDAwVnVUc0xxRVlad2pi?=
 =?utf-8?B?WWlCTFpGM24waWVjdnFhNlplYXpJU0oxL3pjNzBrMDJ3MVBrZEFUWG8ybGxP?=
 =?utf-8?B?UzJiOG9YOXh6bTV0UFg2YnNuMlNHczNnSXFjN0pqa0FyUno5WGtVNXAvNis0?=
 =?utf-8?B?RmpReWFycDFXaERka0Z2RXJCcmRVUDRvdUFKd2dNZm9HQnZHSXFtcU1IV2pn?=
 =?utf-8?B?ZmFxR0dXSUsyTWF2SnowVWpUNHJKN0ZmL1ZrMnRBRnpTYThCa1VkTEJyTndM?=
 =?utf-8?B?OUxPMC9QczFRY28xQ0hGck9wMTA3N21JVHBxQUFGYTdMc0gySVIzTytjOHIw?=
 =?utf-8?B?SHRLaFdZc1VTaHNnUXFDMWt1dGt4dnVCd1oyUk1yUTFsUzllR2ttaUZnTkFP?=
 =?utf-8?B?VFd4ZnRLK2RtcFplT0FXeWFhenFFazJJNXU1dWxHV29xVVdXRDZaTkg0VkNS?=
 =?utf-8?B?NnlBWDFSc2p3TnFwZG9QUXJ0cHVsY3FJMU9vQnoyMFBwd0tiN1RFNzZXaDMz?=
 =?utf-8?B?NUJUeG1Udit0QzlOVmhFUXpubjhheDJadmdyK0hGUVFsYklGTDcvbVpoRTMr?=
 =?utf-8?B?ZW1PRUYrVjQrV0t4a2VPMklNT2UrZ1Z5WEF5dlQ3d3JmTXh1c1BObmVvTDNN?=
 =?utf-8?B?N3h3ZnNwVFQ1cE03bFQ3ZU4xeko4bk5Fa1U2MTB0MjNMUVp0K1I2ZkpBamEz?=
 =?utf-8?B?Z1dFN2tvdG1BM2dycU9mQnRtQ0NwZmVCS3kwaVVPRng3VDJzSzdHVytjMjBt?=
 =?utf-8?B?U1RWZnFDYjkyaEY2OTVESXoxMUxDazhueUJnNStZeWpWZzUwdEc1WnZqT2xn?=
 =?utf-8?B?UFJYcGJ0T3Y3bkVDYnB3YUUvOHhjemJ3SXAzVXo4WndEVXczM2xDcGk1a2w3?=
 =?utf-8?B?S2czYU1vbXVJQ1V2ak40MStCT2N4MGsvODZHOU5OV1c2eCtJUTVBdWw3UXgv?=
 =?utf-8?B?SnkwbFdaU0hHTnE5WG9Zb0VYZ2lJVzVjWEd6UzlOZWh2dWo1SkFjbWdjbENp?=
 =?utf-8?B?QTUvZUVBMEdtSEJ4bmUyUnJ2eCtmVWFPSFZOeXZ5RnE4YU9FRHozdXltcW0z?=
 =?utf-8?B?RW41U3V3VUFSL3lBdlJ4WjBzdlR6NFN3dkhMeURwclh1dHBZSmdwME04ZEpZ?=
 =?utf-8?B?U2NYMWg4N3YxSENZT29qRDIxRDZCOEZFeG5rd09Vc0RXNFVsdU82Mmt0Wlk2?=
 =?utf-8?B?MXhVYndRNUw3bnhPUThKcWRGcHZSOHBvU1ZaZXB0QnU1WUsweUlld0oxVzZx?=
 =?utf-8?B?dHIwK1V5ZHc1Nk9wbTk5bWtKOUNobU1NRWhUVzQxRStub2dDYUpQSlRWdW9H?=
 =?utf-8?B?alppdnJMc0J3RUdjWm81UjFja25WRW5IcWU5NDU0QWtobzBCUzRPQVpHNEh5?=
 =?utf-8?B?bG9XdDV1NkwyK1VBMWFhNmxvUE5XNHdWMmpJY1d6eTlOU3NxNXV2QWc5Ry9o?=
 =?utf-8?B?MFRzRW0zVU9mKy9DTHBYc3NuWFRSV0RIblp2VEdCUmFZVnk2RXc0OHVOMkE5?=
 =?utf-8?Q?Nlv7xAxjH6B5BZMgWiZJUqcGa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024d8fb2-88e7-47b0-6761-08dd8bfd591a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:50:39.6019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXFdXF7uThlGTNO+gei8sTYALh8USz0Tg7rcUsDGvur7rOHYce66e9/2ifSmWW8GOoWdtGzZMsbPNO6zPwOVkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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



On 2025-05-05 13:37, Alex Hung wrote:
> 
> 
> On 5/5/25 10:32, Mario Limonciello wrote:
>> On 5/5/2025 11:27 AM, Alex Hung wrote:
>>> On 5/4/25 16:11, Rodrigo Siqueira wrote:
>>>> DCN401 and DCN31 share the same implementation for disabling CRTC. This
>>>> commit makes DCN401 use the DCN31 implementation and removes the code
>>>> duplication in the DCN401.
>>>
>>> Hi Rodrigo
>>>
>>> optc31_disable_crtc is not the same as optc401_disable_crtc. Please 
>>> see the dfiff below:
>>>
>>> < /* disable_crtc - call ASIC Control Object to disable Timing 
>>> generator. */
>>> < static bool optc31_disable_crtc(struct timing_generator *optc)
>>> ---
>>>  > /* disable_crtc */
>>>  > bool optc401_disable_crtc(struct timing_generator *optc)
>>> 147,148c232
>>> <                       1, 100000);
>>> <       optc1_clear_optc_underflow(optc);
>>> ---
>>>  >                       1, 150000);
>>> 152,155c236,237
>>>
>>>
>>> However, optc31_disable_crtc is the same as optc35_disable_crtc 
>>> (patch 3?) and optc32_disable_crtc is the same as optc401_disable_crtc.
>>
>> Is that last argument a timeout?  How about just extending the timeout 
>> to be the same for all of them?  That should be relatively harmless, no?
>>
> 
> Hi Mario,
> 
> "fa28030a83a6 drm/amd/display: increase hardware status wait time" 
> changed timeout from 100000 to 150000 and 401 is based on 32.
> 
> Do you mean we change all of timeout to 150000?
> 
> Hi Aurabindo,
> 
> do you have any comments?

No concerns. Making the timeout value consistent should be fine.

> 
> 
>>>
>>>>
>>>> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>>>> ---
>>>>   .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  2 +-
>>>>   .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  2 ++
>>>>   .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 34 
>>>> +------------------
>>>>   .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 -
>>>>   4 files changed, 4 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c 
>>>> b/ drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>>>> index 13c1f95b5ced..e6246e5ba86f 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>>>> @@ -125,7 +125,7 @@ bool optc31_enable_crtc(struct timing_generator 
>>>> *optc)
>>>>   }
>>>>   /* disable_crtc - call ASIC Control Object to disable Timing 
>>>> generator. */
>>>> -static bool optc31_disable_crtc(struct timing_generator *optc)
>>>> +bool optc31_disable_crtc(struct timing_generator *optc)
>>>>   {
>>>>       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h 
>>>> b/ drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>>>> index af67eeaf8505..db7e51fc787e 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>>>> @@ -267,6 +267,8 @@ void dcn31_timing_generator_init(struct optc 
>>>> *optc1);
>>>>   bool optc31_immediate_disable_crtc(struct timing_generator *optc);
>>>> +bool optc31_disable_crtc(struct timing_generator *optc);
>>>> +
>>>>   bool optc31_enable_crtc(struct timing_generator *optc);
>>>>   void optc31_set_drr(struct timing_generator *optc, const struct 
>>>> drr_params *params);
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/ 
>>>> dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/ 
>>>> dcn401_optc.c
>>>> index 6eba48de58ff..f472d2efe026 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>>>> @@ -170,38 +170,6 @@ void 
>>>> optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, 
>>>> bool ma
>>>>               OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
>>>>   }
>>>> -/* disable_crtc */
>>>> -bool optc401_disable_crtc(struct timing_generator *optc)
>>>> -{
>>>> -    struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>>> -
>>>> -    REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
>>>> -            OPTC_SEG0_SRC_SEL, 0xf,
>>>> -            OPTC_SEG1_SRC_SEL, 0xf,
>>>> -            OPTC_SEG2_SRC_SEL, 0xf,
>>>> -            OPTC_SEG3_SRC_SEL, 0xf,
>>>> -            OPTC_NUM_OF_INPUT_SEGMENT, 0);
>>>> -
>>>> -    REG_UPDATE(OPTC_MEMORY_CONFIG,
>>>> -            OPTC_MEM_SEL, 0);
>>>> -
>>>> -    /* disable otg request until end of the first line
>>>> -     * in the vertical blank region
>>>> -     */
>>>> -    REG_UPDATE(OTG_CONTROL,
>>>> -            OTG_MASTER_EN, 0);
>>>> -
>>>> -    REG_UPDATE(CONTROL,
>>>> -            VTG0_ENABLE, 0);
>>>> -
>>>> -    /* CRTC disabled, so disable  clock. */
>>>> -    REG_WAIT(OTG_CLOCK_CONTROL,
>>>> -            OTG_BUSY, 0,
>>>> -            1, 150000);
>>>> -
>>>> -    return true;
>>>> -}
>>>> -
>>>>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
>>>>   {
>>>>       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>>> @@ -435,7 +403,7 @@ static struct timing_generator_funcs 
>>>> dcn401_tg_funcs = {
>>>>           .setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
>>>>           .program_global_sync = optc401_program_global_sync,
>>>>           .enable_crtc = optc31_enable_crtc,
>>>> -        .disable_crtc = optc401_disable_crtc,
>>>> +        .disable_crtc = optc31_disable_crtc,
>>>>           .phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
>>>>           .disable_phantom_crtc = optc401_disable_phantom_otg,
>>>>           /* used by enable_timing_synchronization. Not need for 
>>>> FPGA */
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/ 
>>>> dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/ 
>>>> dcn401_optc.h
>>>> index 8e795e06e615..be74fd709d43 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>>>> @@ -180,7 +180,6 @@ void optc401_program_global_sync(
>>>>           int vupdate_offset,
>>>>           int vupdate_width,
>>>>           int pstate_keepout);
>>>> -bool optc401_disable_crtc(struct timing_generator *optc);
>>>>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
>>>>   void optc401_disable_phantom_otg(struct timing_generator *optc);
>>>>   void optc401_set_odm_bypass(struct timing_generator *optc,
>>>
>>
> 

-- 
Thanks & Regards,
Aurabindo Pillai

