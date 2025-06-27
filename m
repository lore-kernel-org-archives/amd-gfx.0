Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FF5C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 16:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6501010EA6B;
	Fri, 27 Jun 2025 16:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtEKDRwA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AE410EA6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 16:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrE7WBi9zVXI51AGYVpdUoiSuYhSCe5X/5qSK29rmKdnK5DisOJ+EjkSs9vSxsHMRBQGETAbk8E+7we5oUJ62SmZUl+lWPQsqFzj4c1dE2V/muKX4GpGgQbaUV/1IvIiVSCa4QlixvInfEK4zS/Vmk3Wv0ymOJOVT2G8sBbVwUUlMj8rr/5Zqn4fToagCeg+zOT4LOLqbgMFJsAmGnW5koeIrQbDprdgRw9Fg1XNC4QqaU8cfZSwoYacV6BfVPQQkCOUS+WbgBr5YXMMdzjfdIbqaDSyJdbEJvPqfAxpRdOrwe1wCLP0Pjp01b0arFlqLDPN21yZO29vJ+GQxN8SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aVGJR9sSJUtytYrP+6r5MrDer5bwb6kGeQj6zSwF/U=;
 b=RTof6SSldzOtxBax/WgFuO9g/k6d3Btq8zezHd8v2PgqXRzdSwITlFNEeoy+AgiuEvX0hozEMC101WPMko/uyvGbEVkm0aQ0HOHntUM9WQXOSo0WemYgOiy7s7Des1PxTI8JhXc2CH69ZkZcDaOlGu+7mpYDb5wdyVkNyVEmm5k/ZikDGMYptqmno0WMtHC4vksV1UpyVIliFD1EKEG3BI5GiqUAvdvAj5oPVsj5dU5Ofy2ZuOtb3ulofjMx5j13XqHf27fyUrFrvKKFK14zk8GyaOZZJ+Z77c4pv+tAl8L9ifHg13HbFvcdQXMNqryVLWF0ZGO1FiMD6h8J6LyThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aVGJR9sSJUtytYrP+6r5MrDer5bwb6kGeQj6zSwF/U=;
 b=PtEKDRwA+g1HkfzZBSKwLL1NqlPSsCRhCFucNNEFTbtMOUkBdMqoVjpCylpERsjIrq03evts4MGbkzwi8f0mIiDkgNde76BUG3R7MX+QJyXuM502hXEzUJ8NOKfSn6c+ii7BV2Fe3DS8WskVwIN6SgXJf4ytMvAzaslcRcKQscM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 16:13:24 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%6]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 16:13:24 +0000
Message-ID: <46aa1df0-f655-4905-8b65-e339ce9c26c9@amd.com>
Date: Fri, 27 Jun 2025 12:13:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Initialize swnode for ISP MFD device
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250625220949.116574-1-pratap.nirujogi@amd.com>
 <eeef533c-f0b6-42da-b34b-26eb05aa2bb7@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <eeef533c-f0b6-42da-b34b-26eb05aa2bb7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To CY5PR12MB6429.namprd12.prod.outlook.com
 (2603:10b6:930:3b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3613fcf0-5661-4abb-3156-08ddb5958a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTFiQmlNakRtL1h0dFU1NXFzMDBuZ05yRFEzQlNaQmhZTlJYZ2x5d1VDYW5S?=
 =?utf-8?B?bTNpZGNLUUVwdE9wS0IxLzY1bjcvcEVCTThVZ25PM2VyVjhRUjJoY2gzZzNj?=
 =?utf-8?B?cTZSSkE3TFY2SkI4QmMwUmhDSmEvaUNHdXNESGcrTUt1WHh2d3g1Y3J5ZXBW?=
 =?utf-8?B?M1ZHREdnZUlPaFUwYlBKeTRLSXI1N0dIT1pROEJoOCtBTUJINGVEMGpoRisx?=
 =?utf-8?B?dVVyZWxJSlUzUVJFVmpUa05Eakk2VjFnZTBwVDBXdXZGMC8vWnlXckpPMUJ0?=
 =?utf-8?B?YThWNkt5OWI5U3grcnM4WUdRZDgzM0NnYUF6Q0FRb1Fzdk0remNXLzdpSnV5?=
 =?utf-8?B?R3lQWmt1WXNFT0hnMk92dDZWNjBVNmwrdWI4SVgvdGRPd1R3dGIzaldqQ2JD?=
 =?utf-8?B?akVUMUVERzlqZng5VURRL3JQalRJOUZKRkJoRTZZMzJndHdsYUMrU01VZlBQ?=
 =?utf-8?B?MXd5U1J2VEhFMkxwdFFpRGgxU01vc2J2dXBIdVo2cHFGM0cwSWE3YjFKOS9n?=
 =?utf-8?B?UTA2Zk5XUHVJNG5JTllPbkp0YWZkMHk3bURZd0Juc0lFdG1FUDc5M1NEZlF0?=
 =?utf-8?B?RVF2YjVUVXVVY2xrdWhKdjhFazVjOHZwR2FwVEwwZERYRHk1blJFOHF5Q1Vq?=
 =?utf-8?B?a3lvNldqdGY0U3d4ZldUekVFZ2NVVlQ1SWlhNEFJQUZVdGpiMUVZUlkweStH?=
 =?utf-8?B?M1dCMEFFaW9XRkx1UktxRVUzWFVPazF3bWRhL3JObFd5NzBBK0V0TmZwejNP?=
 =?utf-8?B?Mmg2KzZpVDk3ZEw3Nk9weElmRTczVTNSbjhmamhUb3RMVC9YcW1BL3hWZmsw?=
 =?utf-8?B?Y2FZTlc3eXhRbjViSWIxSFRhZ2V5Vk5MME1RaHluOG9hR2lIOVpsSXFrVlRB?=
 =?utf-8?B?L2lTVDlBalVGcVh6N2tXcTRyWlYwb3RYeWVtdzNDMmVYTU94UUpyTFZvdDYy?=
 =?utf-8?B?eS9WOW5VWnBFWVZIN2c2UlM1dnlETkUyWm1KL1FRMU5ESklHM2pydjNES0th?=
 =?utf-8?B?NHZGdGFqanRUOTZiZHhmM0t1SXdBa0tWNkNDYU9yeWdsNDZ4eWdLOEdaN1Y0?=
 =?utf-8?B?TEVWdzUzZklNc0doZnE4N3o5a1Nad3RpYmd0QXlBcDBLZnpkNzd6OFNOVDFz?=
 =?utf-8?B?V2hFUUF6MmI0bFB3TEtpTzJUTzBEdVRJcFFFdVNrR1NzS2I0cWtSQ0RmK0xk?=
 =?utf-8?B?MHZhOFdpeWRQNHNqSm5yTXVPYWlDcWVnQVNyT3BtMnBmcUovSjQwNCtCamZ0?=
 =?utf-8?B?RVJPaFFKSTlJSlJ4UG01NXZBTC9oeEFhaGU5QVVPTWgrb0NaeFJJM0VPMXhS?=
 =?utf-8?B?MGpQMElMMVBqaUN3cDlRblU0OCtENExqdWRoZ2crazhQampkWTNRUUI3QUhY?=
 =?utf-8?B?VXUvR25abFcrUS9RYlp2SkRnb1YzZGo2UkFlVnV6bE5wd1dHYUdZbjBYM1h4?=
 =?utf-8?B?RXRMMjlkTGEwZ1J0NUh2ZVcwTXNXRGlzZXgyTHV4blpQN1IvUHp2VEprMGpJ?=
 =?utf-8?B?UEhFNVh3bDYzd241Zi9ET3N6UWlvbjl1YURvYmZLOG91VHE2bFlBRi9aR0Vm?=
 =?utf-8?B?S2g5OXN1WnhFODMydEUvc2ZmMDBhNVgrRVptN3FJcGpiVXZ6VEpNaDM4STNC?=
 =?utf-8?B?a1I3YzhJLzBNMG10OEJLUzFqMkJtWVFxWmd2TGUzUlg2MmtGUCtoeS9pZ0JV?=
 =?utf-8?B?SmVYbnozMVRJSFlZNitPMFFUMnBFam8yYm9BTW1hZXZ5cUxFQTRKU3hOaGc3?=
 =?utf-8?B?LzlLUU5NT0JiS3J6MHBjUTVLSWFSOUJrU0tWcS9DYzJuZXBlbm1xb2M4eG5y?=
 =?utf-8?B?TEJBd2FJcC8zVnVnaGpMb0d5QlByQVJzd1BZZlN5WG42MjNQUk9QNU9QNktT?=
 =?utf-8?B?LzZQbzkrd25XRHJoUkJEN0ZZZG8xTDZUeUoyV1BCUm1xcXNqT1UrdUU2NjMx?=
 =?utf-8?Q?5W6Sb85RdDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZidFJCdkhKTlhSVjZXVVFPbUdvS2lobGI5YVdFVXJkdTFnWmFteDhyUE5a?=
 =?utf-8?B?ekNXRXFBM0Z5NnBqQzFYcUNtR1hRakVaalAxU0FSNG1CbHdkRXk2NnBaeVpE?=
 =?utf-8?B?Wm9pNkJaa3Btc1VRVlhCR1k4ZTY1S0VMdDFXOWFEUlNQRy8wbUFVSkxTVHp6?=
 =?utf-8?B?a2NnbFFScHpiRkpYb2g1aWlTRXlqNTN3TG51OHpKUTFaOXpLUXlubit5U2Rz?=
 =?utf-8?B?QnpZMTJMS2hVMmxudnVVUEdPcTR4RDdRK1BIb2tseHNsTDUxZWdNSjQ0ZDlF?=
 =?utf-8?B?QU5GVjVGUTZWMHFXRnVCalBmRGJQSUhzQUlGaTkxYUxIakIxUnBRUEVrQkJ6?=
 =?utf-8?B?WFlrbkVINlhBQXhzQ1ArdDJpS1oxYmgrQitMdzg5bzFhNko5OVlreXlPNVNP?=
 =?utf-8?B?V09VZVE1eGpodFdlaFNVc000bTJHSkV3ZW50MVJ1R2l3RTRBMzRqMTR0OEJN?=
 =?utf-8?B?ZFZMbk9DQVJ4cGtwRzExbWI3K0huVStlUlJMMFg5dFh4VnNLUnMwaXV3b2xu?=
 =?utf-8?B?ZFRZcHByVmkxTk1XK05sTEpEWE05dXpCZ2wwTFNmUE5oU0FCWVZwWkFwMjlS?=
 =?utf-8?B?VDRXc0NmTStNbkt4SkI1MnZEalloZ1BHdk1GQW12OFJQc0N1S0NoU1RHYk9H?=
 =?utf-8?B?UDJXQ21CL1FDREFhMjdXZ2U0Y0Z0b0hrUFlFbkpGL0FUMmsvSG0wRGFzNUFh?=
 =?utf-8?B?eE90RTNpb0VOakFqWmFJUjcxbStSUnkxeDBuM2JxM1JxRjdNNElxK21KUmxI?=
 =?utf-8?B?bmV6eXRqVTd6OUY2TUtHZmJ0MlJOeTdCTzhMR1V2NkRoZmVWdnE4d1g3SFh2?=
 =?utf-8?B?T2xnQmpkVmJCTlRSOHFXUmpQbGFFWlJLMStia01pUHlmL2RWcHBmdktFaThy?=
 =?utf-8?B?MXQ2enViWjI3VXd1WEcrTE41ZG5scFpWMThDT3VXYTRabnU4czhtdURIbXht?=
 =?utf-8?B?eWRFQlZMZkFwa0ZtcmovM0dZVS9RejRPUGlXV2dWZldLSzRNaFZiZ012NkdB?=
 =?utf-8?B?dUFsVXQyL0ZUV3BkUEdTODc5RzUwR0pWMU00QkJQM2FYd0ptNVRlNGNqVFJZ?=
 =?utf-8?B?ZjVLTzd1VktsMTYyRjlQUmhiQWczOFRRcXUvcms0bGxJOXBjMFRTVFR0SVhw?=
 =?utf-8?B?ejNpZEZKdHNvNUZ5MzhRVlBsYjd1ZTFxV1owU0xDVkdIREc1am0zR1B5OWVO?=
 =?utf-8?B?OE1vNUFucUFnWmgzSTN2ajhaVS9zZ1J2cEIzUXZpK05EanFENjJtbVNsVDdr?=
 =?utf-8?B?K2NjUE9kT0RBV3ZQYWtqWlJmbVBNaGg5ZC9jOWJObFJCNzFUMk9ERkRpSDdR?=
 =?utf-8?B?Q0NNZm5oY2htZWUwS29pVDJ0bWYySXZlKzlPU2xidzYxZGg2OWZqMERmZzhB?=
 =?utf-8?B?b1dOSzdqZU1udnA3SUdpUW1FaU5iT3JMdGtwVEVYOXYrYmplZEdWNldjTVd4?=
 =?utf-8?B?bkN6Mm83TzQ0d0hPOExvZHpMbTFHYy9RdFpJU2VXbnNpa1lYWUtIVjJVUkMz?=
 =?utf-8?B?NW9Xa1FtbEFnK3NYMEFBK25abFRrUmFTK1JWYkFwbGNMek83VlcwQnFpVlEw?=
 =?utf-8?B?c3NHMk1sNm52RlFQY29JdG5GUXhpUEtHQmtxOTYvUGRPSDEzR04yUk5wZTg3?=
 =?utf-8?B?MUlINEpzaWsrRTJnNDVEanIvTTVLV3NJYlI5TmtHanVRMjFhQ0RORFpkOHBu?=
 =?utf-8?B?QXptU3owNklCTVJkTDNzNis3QlhydkMvOTVBemlCaTFBWnMrWmZ1V3pwUjha?=
 =?utf-8?B?cTBqQ25zZ2k4cFNPczF2REZJdnZUelNmVFM1dGN2ZTlaakxiTHF6ZElEcmxt?=
 =?utf-8?B?WXRWRzhpaG5nQkxvS2RFNlJ2S0F3ekJJSGphQzMrRm1YbCt1NTJIbGFRSGZ3?=
 =?utf-8?B?a2tjZUIvS05MaUhGdTA4VlFlQlZiRVprYTI5eVVuOCtERHRTZWtxUTJoZ3Rm?=
 =?utf-8?B?ZjdhK2tVeVdRQzgzcXJxWStFMmR0aUM3bXZFVHlCWjZwNEZ2eDQxNHZmczZB?=
 =?utf-8?B?L1dyT1VReUswVmxlQmFHUGxoSHNqT1Y2WDlrWFVnY0JoVHQ2VVkxcmdkRTl6?=
 =?utf-8?B?MEhYdGx5RTZaTmg0N3ByTFBVSmJEbWg0aUcxYzVwa1NBbGNacFpUN25Ra256?=
 =?utf-8?Q?2pZ4yoCnBko+ppD+uSWfe1jiD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3613fcf0-5661-4abb-3156-08ddb5958a9b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 16:13:23.9248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw0ubWCzmzF7KO5k4fAam3rk8vgKf0TbGUDIjuG2FPu2zav2isCqZrGGLE+y+RQMYXg0I4TVMCVlVn7xQLZWqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

Thanks Mario.

On 6/27/2025 11:55 AM, Mario Limonciello wrote:
> On 6/25/2025 5:09 PM, Pratap Nirujogi wrote:
>> Create amd_isp_capture MFD device with swnode initialized to
>> isp specific software_node part of fwnode graph in amd_isp4
>> x86/platform driver. The isp driver use this swnode handle
>> to retrieve the critical properties (data-lanes, mipi phyid,
>> link-frequencies etc.) required for camera to work on AMD ISP4
>> based targets.
>>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 11 ++++++++---
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu.h
>> index 3f0b1fa590c6..7427986992d6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1718,7 +1718,7 @@ static inline bool 
>> amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return
>>   #endif
>>   #if defined(CONFIG_DRM_AMD_ISP)
>> -int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>> +int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev);
>>   #endif
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index f5466c592d94..ae2d08cf027e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1545,7 +1545,7 @@ static int isp_match_acpi_device_ids(struct 
>> device *dev, const void *data)
>>       return acpi_match_device(data, dev) ? 1 : 0;
>>   }
>> -int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
>> +int amdgpu_acpi_get_isp4_dev(struct acpi_device **dev)
>>   {
>>       struct device *pdev __free(put_device) = NULL;
>>       struct acpi_device *acpi_pdev;
>> @@ -1559,7 +1559,7 @@ int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid) 
>> [ACPI_ID_LEN])
>>       if (!acpi_pdev)
>>           return -ENODEV;
>> -    strscpy(*hid, acpi_device_hid(acpi_pdev));
>> +    *dev = acpi_pdev;
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>> drm/amd/amdgpu/isp_v4_1_1.c
>> index f857796f0297..a887df520414 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -183,15 +183,16 @@ static int isp_genpd_remove_device(struct device 
>> *dev, void *data)
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>> +    const struct software_node *amd_camera_node, *isp4_node;
>>       struct amdgpu_device *adev = isp->adev;
>> +    struct acpi_device *acpi_dev;
>>       int idx, int_idx, num_res, r;
>> -    u8 isp_dev_hid[ACPI_ID_LEN];
>>       u64 isp_base;
>>       if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>>           return -EINVAL;
>> -    r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
>> +    r = amdgpu_acpi_get_isp4_dev(&acpi_dev);
>>       if (r) {
>>           drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
>>           /* allow GPU init to progress */
>> @@ -199,7 +200,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>       }
>>       /* add GPIO resources required for OMNI5C10 sensor */
>> -    if (!strcmp("OMNI5C10", isp_dev_hid)) {
>> +    if (!strcmp("OMNI5C10", acpi_device_hid(acpi_dev))) {
>>           gpiod_add_lookup_table(&isp_gpio_table);
>>           gpiod_add_lookup_table(&isp_sensor_gpio_table);
>>       }
>> @@ -241,6 +242,9 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>           goto failure;
>>       }
>> +    amd_camera_node = (const struct software_node *)acpi_dev- 
>> >driver_data;
>> +    isp4_node = software_node_find_by_name(amd_camera_node, "isp4");
>> +
>>       /* initialize isp platform data */
>>       isp->isp_pdata->adev = (void *)adev;
>>       isp->isp_pdata->asic_type = adev->asic_type;
>> @@ -269,6 +273,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>       isp->isp_cell[0].num_resources = num_res;
>>       isp->isp_cell[0].resources = &isp->isp_res[0];
>>       isp->isp_cell[0].platform_data = isp->isp_pdata;
>> +    isp->isp_cell[0].swnode = isp4_node;
>>       isp->isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
>>       /* initialize isp i2c platform data */
> 

