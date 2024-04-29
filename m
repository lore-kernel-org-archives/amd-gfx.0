Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5425C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 03:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320BD112AA7;
	Mon, 29 Apr 2024 03:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vO11PXfK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83AA112AA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 03:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKcjyCxyZfe9OXdoboE5LRJ4tWoKkpKxHQqvNGSdIejTyBYkHI8GGXL+/U3Uiltk00wWIXNjNQ9QBYC16WNo7ITgYyNutwc0VAZbCxSXALAjPL5dqRGdf5o+3PWKbVp044tVGLSB+5GJycQva1d5Xq/r2yoPp94ys9rsLYp4C+fdCnONvzFzQiBFIq9e30jrmKMaq1yngmBcfuJe6h5GZfpg76QnNnPe1WQcs8/BiH+hDZFRKgNzBpE9WVV+SA8DCQ2Stfo2T23Gnz/jQZA6hUXN8PNNuy3RaKZkbaafslqvtxWGfLNuDo9wcITpWIG8hUoivO0v09G4Ta0iPe3O2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+K+scTExbwBpF8sH31At7AAWY5qMoYFMhgrSE93bX4=;
 b=g1snxRscuG99p/wUFQqVeZBTwLRX6IBLmQtPPqtexoKFCAVS6WE8aCC3PryCx6AAUesyX+1s8evPxny+PZj5aMyHYYpiELP8+tCSHkc+4829DpVS+n+YfHIemQHsT8lQnoGHmqR4JANFYN6ydSQ+rdyyq6Ctvk3DwFuNNWWO6271nqWeXOtnkJTVaUwwFH2kq6rawcBc0VNIW7gItCaF/lp9ldzeDFpWGzBvjFDBf1s252XiuQZzpVMtaZB0T4Qh5Td12S7kuuLDt/k8CVv+K3zzxfaojRbvKU1eoh9qnFeLgbeQn5MzaftoOVvmKRmqQzsjfzLnVQvBLEAsInq7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+K+scTExbwBpF8sH31At7AAWY5qMoYFMhgrSE93bX4=;
 b=vO11PXfKDJQvNstbvGnC/CIpK5AXT2hcTSOli5DDWdbc1mLq7IUcRgfXk074wK4joKhEnmVdUPiTdV/Z57hvCU//aZ+9NgZIUQtF7FS1/MnjZ4E3OiqXEn4PDC98yVQwdzpx3uufx6pk3V/BFLgWn+zRslEr4IMu1Z7gAZa2vI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 03:42:48 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 03:42:48 +0000
Message-ID: <39ac0ab0-0dfa-4e9e-b2d1-cf42dbef4894@amd.com>
Date: Mon, 29 Apr 2024 11:42:37 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com,
 Alexander.Deucher@amd.com, kevinyang.wang@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
References: <20240428095435.126980-1-Jun.Ma2@amd.com>
 <20240428095435.126980-2-Jun.Ma2@amd.com>
 <CADnq5_OxXXU_2ezR3ruUWK8otWL2MU9gLP=SF8c9z4NsNSMe=A@mail.gmail.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_OxXXU_2ezR3ruUWK8otWL2MU9gLP=SF8c9z4NsNSMe=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: c013d90a-2007-4c48-e843-08dc67fe7019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUFUejh4Z1ZLYXJHKzhvWHJRdHRDeDNWLzBacXFNc3V2SGM2N2w0Tk9PSTda?=
 =?utf-8?B?aEdwczZUcDRJNDh0bFVEdXFZYWNEV0RIUEIzRzNlZmFoVzY3UXhpTHIvQVhN?=
 =?utf-8?B?Q1Z4R0k3cys4WG9ad1V5VS94bm05K2JDQUpYdlJXaVlHbU5rVTIyNitjWUZW?=
 =?utf-8?B?NWt4eDJlRDArT1RoajArL2pTTVlHd3dqbVNzSXJ5MDJPUTFtTnJ1dXh1TGZM?=
 =?utf-8?B?a0RRS0Y3ZzhIL0k4M0ZvclVCVFhnV1BKWnVzeHltcm5RYXRGSjhsNzFkbTJC?=
 =?utf-8?B?bkluZlJ3WWRsN0xwWjAwcy9EdjFSVUdNL1c5bDN4OS9iaVluc29aalFsK1BB?=
 =?utf-8?B?NjRacTQ0Y2Y0WU1LVlQ4ekJhNDZaMUg1OStLUWlsSElkdWlJYURMVVV0RzhG?=
 =?utf-8?B?ZmxoOEMxNU4rSnpIV2wzRkxaQVArYmtqeGhJMzBhNU9lbkdlTEs4ODlJNnFL?=
 =?utf-8?B?T2FyWks3bm1tY1hxSTNJa1hSeDBPRHhuSklMQkJNTTNxdHJzaHdKQ3A0NWpX?=
 =?utf-8?B?WElnVnNQeEtJSU1ZczJON1RkaldSN09VdXJjSXZhQk41YVVuNEdnbFFxb09T?=
 =?utf-8?B?ZmVkRGhzRHA2SkNqUitqUUJNbmM1bi9pOEpNTklLdUU1Rm93LzlGVDMwekFD?=
 =?utf-8?B?Ni9HbVV1VEdUbVQ3YVNlZDc3TktXK0xBVExhM1JlejdhNFZKRmxtK0JQYUdt?=
 =?utf-8?B?NThjMnlHbXlxZWdHWHVVK3lKd0RYM2prNkJQaGJGRXpUVmVNL0xVTkdzY0tl?=
 =?utf-8?B?dGhwTndsbm5ySHBERFdQTDE4eWtXaFpBY21uTDdiYlc0cmVNSHl2T2M4K1pX?=
 =?utf-8?B?eDkxUytlbnVRUHdEWTdYVURiU3dGRGlXOUNwL3BjUEJhZ2dLUTFyeldtbkxJ?=
 =?utf-8?B?emY2N1JuOW1ieWxidksxVG9IQTBHUTAwRDh1WjF0ZCtQVkRHVUdFTDcyZlNN?=
 =?utf-8?B?N3h1amNibmIzTzRRdzRPSUIvcFJvNFE5OWtVMDlrUTNMYnlQS3p2d09WS0th?=
 =?utf-8?B?TkRJQzZLYW50NlVJcmZTbVJkVmYxNzVxYVpHaFFINUh2NVlTV1JSSjc3N2hq?=
 =?utf-8?B?SFVvTVh0TjJMLzNCK1N6NzdQcm1POXVjSm45OE1DeVBUUTVSR1RRWGhEbXZk?=
 =?utf-8?B?MkZwcHNVck5Tb0lDcFRoQ1FqalB3a1JWbWFWYm90OHNpMnplb2dVMUJaTVIy?=
 =?utf-8?B?ZEhveisyWVA0aHR2eHRyQjdVQjJzWnAxR0xtNVJzWCt0NTRlamdCa0d3U3dT?=
 =?utf-8?B?NXZwd3B5RFBFUUE0OC9rV2loaHdlMGkwem1xRHRrL0s0Q3JxMS9rWnp3eThp?=
 =?utf-8?B?L1lNd1Bla0ZBZFlVNjhqeWtyZ3lzYTJsb0ViVkhWbHBma0FaZGNURHhhM3Jx?=
 =?utf-8?B?b0o5cEs1Y0c4RURoQzhQa1pnMzBhRUNTWnRlN1Y1ZWdpRmRhNWQ4T0xIRnA2?=
 =?utf-8?B?Z2doSnNrSk5oRFZ3bmZjZVRjdHlOR3RaZmhiN2lLR3NHNjNrTjJ6SlVyc09N?=
 =?utf-8?B?WjV5TU16NGpTWUk5cDN6dXl2QnltNlRQSFJXMHZwdWxVcWtQU1c4dXdCdk44?=
 =?utf-8?B?amdmNkF0a2FjbUV0ZlJqcGdtcnNRd256cDNtUFVqMk5HdG9CYytJMUtUbjNR?=
 =?utf-8?B?d0pnU0VRNXozTnVUOWlpR0p6cFdZVkNoN0VyamZ2Y051ZWljazlZNVJIcUor?=
 =?utf-8?B?MlhLdTBOMXdzaFFFa3MzbjdydWpnRFF4Um5lRWtSZ0dwYko3R1F1c0J3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emV3a2Z3REtSbk1YdEZCK1BBeHFGbDVLSEMwQlJta3dVSnFMdGcweTdXY0hi?=
 =?utf-8?B?ZHlVaXVvdi9QU3VrYzEyUWJnSVFMb3k2ZFNwTkZNWFIvUHUyK3c5Y1l2YW9s?=
 =?utf-8?B?QVR4Y2lKVmRpSnZkWG1lalczYlNIM1RPUkNDNnJKWmNLZ1ZCVTUwSi9vbXky?=
 =?utf-8?B?YnZVR0crUWx6OWRrWEVMa21LTDVtYlZtOENQdU8rZFNBOTB2Z3ZDb0VwS0hF?=
 =?utf-8?B?dVNIUE40SVZua2ptNTJOaVczNHJCbGkxelVOejBmczNDWUVmaUVwdEdvTm9o?=
 =?utf-8?B?N2NVWndBTGduWDdkUVNaUDY2b2p2S29Jdmp1Z3RCYzJ4eUw2QThqZGg4dGNG?=
 =?utf-8?B?SzUyek10dnFzSVFhVDFIWXM3eE44NDMxNlNyWEJwdGwyMW5wQTB2R1p2VG5J?=
 =?utf-8?B?SnV2aEoxY1doWkZTcDFSbXorbzJNT0VVTURRUEUwaHFJVmdLVXBZRkJ0MjI0?=
 =?utf-8?B?ZWNWeUh3Tm5RL2RwamFJWVdkTkJRM3VkY0pub3d0MFZUVzNBREgvaHFKb0la?=
 =?utf-8?B?ZG1vYWpXdGN2Mk12bDQ1eUhCYkxoeHZBdStMWm1uYllyQ0h1aXAvNFpJN2di?=
 =?utf-8?B?dU5hMkhxL29MRnA1aVN4OTQ2dTNNMEhoSXRKSlFTV28rd0dUUlhObDRRU0ZK?=
 =?utf-8?B?cm13dzFaSE5Bb1JlRXI1YUtoMW42U2oraHF5VUZtcE0rSytBRjdIVi9qUElU?=
 =?utf-8?B?dTJORDY3VlV6OWlEN0haS1JyaHRXaVIwQ2plSStMWHg0VlMreGJvUTd1VVlw?=
 =?utf-8?B?OEN0a01XV2pRWU5HcHBiNjJCZXlzTUhBeWVDVWVmSWEzWmp1ZERjVjd5bmJI?=
 =?utf-8?B?TENUNDdBbVdHTmxTc0IvVG5XOEExaWhGRWt4enRtU25uU2NQSzAwS09iNnZU?=
 =?utf-8?B?N2huY3RPeVdLdUVOTlJFZGJuZlpmUXh6TEZkb3RQSERtbFJkYzhhUnEweEFX?=
 =?utf-8?B?Y2tFaW03UmFQb3VYcklCV3MwZ1F0cHFIdW9HaW8veXhDMk5HQ1NEci80enBV?=
 =?utf-8?B?MTN5RVRUYmMvYXkrZkNXWTMzcEVycDJDcXhKNnpuUkgwTVNnMWZOZG41V3Jt?=
 =?utf-8?B?VS95a2krbE01Y0JQb1FRcnJQWDBGT3doLzZFU2c4REhJSzUwdnR2OUVYY25D?=
 =?utf-8?B?V0RMeTg5dTRoWHVNdVAvdllDV3J2VWpOWUhYZDFyckUzTzhrVENyc29WS3dW?=
 =?utf-8?B?UDhoOUdJSDhlREFVbzllMDIzYmo0MEc1c3ByUEN6Zkd0aU9qYlZqLzMwamxn?=
 =?utf-8?B?bGRvWndSNGFNYlJXRWRwRjREQUJiZTR6c1pudUh0K0loNkQ0TmNMdGJad2xX?=
 =?utf-8?B?R29ZNDBHUTU3aWdNVjc4TWU3N1RiNkFEdmw3R2JzODdTR3NZbmdGSHNYR1dX?=
 =?utf-8?B?bFA1MDZRNDh0OWxGUjY3b0k5dm1EVThKd09WZit5ZzU1anM4bGozY3g4RzVm?=
 =?utf-8?B?WXJDMWlDTllxaVpGVEg2L3hVNklJT29qSkc2Ky9GeTZYMjZaSEF1NDJoOHNC?=
 =?utf-8?B?blhZUmtxS2lnYmZKcjdBdzlXbisxNDVVMWFMN3QzMXVoOEN2ODdLTzBnOHRw?=
 =?utf-8?B?Skt0R3UzM0pZYlVzTVMzbGQrR2QzVkhjQ29uaW9nb2dHRGhLYlMxZ2ZYV0Ux?=
 =?utf-8?B?MHVSdndVaU1hRThVcWYzTVE4VVJsTkkxWHN2RktRME1xV1dTeXpBMytzRWZm?=
 =?utf-8?B?V05EeG53T2p4OHNTcFFBUFBRYWtTY1JSVVN4by9QMFd5QnhxU3BrYXUzTFFo?=
 =?utf-8?B?NHY1VDBheEl4UkRTdWtVYVlFU3ZQdEZuNmNhRXpJNXB2NW9uTjRSS3ZrdXRx?=
 =?utf-8?B?UlN3YTQvbE5Wb1NMV3JvcHMvVmtwYzFVU0hkZ2h1S0pSSE51Y0VBaHFSSko3?=
 =?utf-8?B?R0l2V1JWVVhzaUJGbENpU1hkTEZYbzdnYllZZUlCcnNUd2FlaFAxUWF0bWZV?=
 =?utf-8?B?TTJuSnNGMHVycGFLSkNqd2ZKWGFuRXhnVEM4cVdTQWdvS3lCNHMxOURSZTEx?=
 =?utf-8?B?R1RDSUZRNFI0dk5jZXBkY0hjUXdWa3dXUm1SUzBvazBST3RoTG4vNTlnaEZ3?=
 =?utf-8?B?S1IwR21nWTRMWVdKL0VrTGNmdGR4YmwvK055Vk81bXBpdjNOL3NqeCtQd1U4?=
 =?utf-8?Q?g2lQERH0PXD+DYJKPTcYW+0qd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c013d90a-2007-4c48-e843-08dc67fe7019
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 03:42:48.3059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grKKzkA9q2DBmAG2JiHnJBLyqb5mMuyKODcHaVyjNuHm9cARomOBzNqELU3msbLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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



On 4/28/2024 10:18 PM, Alex Deucher wrote:
> On Sun, Apr 28, 2024 at 7:12 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>
>> Check return value of smum_send_msg_to_smc to fix
>> uninitialized variable varning
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 ++++++++++++++-----
>>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  8 +++++--
>>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  6 ++++--
>>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  6 ++++--
>>  4 files changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>> index 0b181bc8931c..f62381b189ad 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>> @@ -1554,7 +1554,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>>                 }
>>
>>                 if (input[0] == 0) {
>> -                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
>> +                       ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
>> +                       if (ret)
>> +                               return ret;
>> +
>>                         if (input[1] < min_freq) {
>>                                 pr_err("Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
>>                                         input[1], min_freq);
>> @@ -1562,7 +1565,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>>                         }
>>                         smu10_data->gfx_actual_soft_min_freq = input[1];
>>                 } else if (input[0] == 1) {
>> -                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
>> +                       ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
>> +                       if (ret)
>> +                               return ret;
>> +
>>                         if (input[1] > max_freq) {
>>                                 pr_err("Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
>>                                         input[1], max_freq);
>> @@ -1577,10 +1583,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>>                         pr_err("Input parameter number not correct\n");
>>                         return -EINVAL;
>>                 }
>> -               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
>> -               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
>> -
>> +               ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
>> +               if (ret)
>> +                       return ret;
>>                 smu10_data->gfx_actual_soft_min_freq = min_freq;
>> +
>> +               ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
>> +               if (ret)
>> +                       return ret;
>> +
>>                 smu10_data->gfx_actual_soft_max_freq = max_freq;
>>         } else if (type == PP_OD_COMMIT_DPM_TABLE) {
>>                 if (size != 0) {
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>> index 74a33b9ace6c..c60666f64601 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>> @@ -2486,9 +2486,13 @@ static int vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr *hwmgr)
>>         struct vega10_hwmgr *data = hwmgr->backend;
>>         AvfsFuseOverride_t *avfs_fuse_table = &(data->smc_state_table.avfs_fuse_override_table);
>>
>> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
>> +       result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
>> +       if (result)
>> +               return result;
>>
>> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
>> +       result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
>> +       if (result)
>> +               return result;
>>
>>         serial_number = ((uint64_t)bottom32 << 32) | top32;
>>
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>> index c223e3a6bfca..9dd407134770 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>> @@ -364,8 +364,10 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>>         }
>>
>>         /* Get the SN to turn into a Unique ID */
>> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
>> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
>> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32))
>> +               return;
>> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32))
>> +               return;
>>
>>         adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
>>  }
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>> index f9efb0bad807..3a95f7c4c6e3 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>> @@ -404,8 +404,10 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>>         }
>>
>>         /* Get the SN to turn into a Unique ID */
>> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
>> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
>> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32))
>> +               return;
>> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32))
>> +               return;
>>
>>         adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
>>  }
> 
> Please align with Tim on the powerplay changes.  E.g., See this patch:
> drm/amd/pm: fix uninitialized variable warnings for vega10_hwmgr
> I'd like to have consistent function signatures for these functions.

Ok, I will update this in next version

Regards,
Ma Jun
> 
> Alex
> 
>> --
>> 2.34.1
>>
