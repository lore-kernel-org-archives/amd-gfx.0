Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E837CEFC22
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1B910E251;
	Tue,  8 Oct 2024 15:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTwWt+FU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58EB10E57A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGsa57V3VO6YktJg4GvZcvAOiGSuSquEbRS+xNgqH6P4XMTkgWVQE9d2370FQGbz6/xJNO72qcqYUN3ajmRkYxzD+Ei31NsMQhEsyDFT31AXBmsPBOD1ZOXR5rZ9WCwWKIOok7U9eKxiJ/6wFZUxd439vSGxMfTKrUR1EBkOXkqhRS5oc+0iHuEhLX74ChNn9niENbgiKFqyWLqPgyPVcPwo6tZJ8U9xkB9hbKRudKQG0YabuH22q4pv2rx1JOjj2aEvGSMFI9iO4DD5wkd2LudOOClNj7QrCDMuIMUPQZWwulxtX70C38DwEK28R2F6t2WiRAIw8D3IE9Xua7aASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPD5meLLY9xcXLt/owFuJm3opAvr9gBu6UxRzXBNL6g=;
 b=ymMMSeiZ/LVYjUOhy3CZuOiIb/PO5FmzYvm+Tew8uItKkWhX0HSWlS3aBd9CfP5DrTeAx8ifnTywELY8xhuShwCwudfwQUGwuEabfS5jHNqBBFj9XGLSLBGmAr6uafJoK7d+c8ceh/0enrV0wqfIDnvITvUwiKcVe07grhGacv7OI7xbWigjUl83Z45OghOJlEinjwpBsoQfE0Ybce/Tdha4rYEV/lWe3+L1aVJFxSJmq55W4o9Y9mAY7JSGUVW+zTd7sseUrskuP8/BPko3UbZ5phTY05hHUf8EPQqXeuumPhnhKZ71kM6AqTvJX/2G7cXcuzuyVDf3LDC+HMlr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPD5meLLY9xcXLt/owFuJm3opAvr9gBu6UxRzXBNL6g=;
 b=xTwWt+FUhZ5b+df+3q/0rqsrV+nnc31H/7SFwaWi9JkrsTgLEYbW20NdqBAQJUjkNJL4xH7dB0E0D9i3Ome2eDOUz9eU+WDraAZwn6o11xY4saQUsTDDZj2gWLqbDVGQ65aX/Myc+w2IJu3BSo8T6wiM4VyyJpV5BdzRPmMDzOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 15:13:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:13:48 +0000
Message-ID: <cf29eae5-f95c-4586-9b76-82ce2204c497@amd.com>
Date: Tue, 8 Oct 2024 17:13:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] optimize insert nop operation on cpu side
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241008133456.710083-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241008133456.710083-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b40c70-73c4-47d5-fecb-08dce7abcf2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2pQcytsN1ZacFBDOTE4Y3gwVDZzbCt0QnFPZXE1ZnlVendzMnlWZm41Yncw?=
 =?utf-8?B?RHNiRkc4bXFlZFNLaW1ZVFZvWHNJZ3UvUWxiRHhESUx6ZGNEaWN1WGI3NmlS?=
 =?utf-8?B?WUpWR25KTXdPaVFQVEMwQ0JYK2xscTZpZ3VOcWRnQ3A2SzcwcmZWTS9sVjVC?=
 =?utf-8?B?N1FVcU1zWlI2ZE9MY2Q4Y2RNZ1NiVTJ1UU95dmJVUlZNWEQrd2UvTjc3SjZ6?=
 =?utf-8?B?VVM5cHFwemZHYklFSEtmUTYzVGovV29BRzRIWWt0TmxCM2JCUHgrSGw3dVlE?=
 =?utf-8?B?YkpCR0xveUJMOUhENlhVeHFKam9DZE44Rm9haThlY3lPZWdXWHl2LzVKbUpI?=
 =?utf-8?B?SkswNGJsdzdLa1J1bDArVlppSXZqcWFBdCtPUHkxNzBLNlJSVzN2dkdZWElM?=
 =?utf-8?B?RUowdXpWNVh3Zzlpc1graGwrVTNiL0tPbk1MTVc2dUdubXZ4aC93bXNEYlBy?=
 =?utf-8?B?S3BkQ052VS9VYzNRbjNFcEgzQWVJQTlhTWc3c2ZKNW1DQjAyZmRIVkUrUjNa?=
 =?utf-8?B?K2t0MWF5azFyVkhHYU1KemlScDU0TlZUNkdqREJrak1iVWtrczg1TURqcTVv?=
 =?utf-8?B?QTZ0Qnp3TWF0MjZpeGF0RzI5M0NXSUI5UEpETDkzcGhpZTAvdUpZd01sTCs5?=
 =?utf-8?B?UGJwUmpTWm5pRHNkU1R1eDM5dTM5Z2MrL2ptTDFNM1JiMWhXbWc4OWVUUk9D?=
 =?utf-8?B?MEdDTnh1Y3NlRi9HQlhNbmRPeldlNDNrSFBMckVOMmdsQ1B3eFZGUytOSEVD?=
 =?utf-8?B?eUl1QzJiY3UvVTRHTDk4RWI3dmZBdGU2a2ptaUNoejdpR1Uvakc2K2tTMUpY?=
 =?utf-8?B?YXhaQ0J2dHUvVWs4UXZGaG1TM3c2aTkwdkNteDJ4QjhJUStkRG9NQWx3ZWoy?=
 =?utf-8?B?MFRxdUxuYVhhVDM3K0xwek9tTk13eHEvdU55dXBHaDdQQ2FaUWh4dFkvOXBN?=
 =?utf-8?B?QnNHM3E0OEpWbVhPaCtuNjFpdEMrWXY0ZEw5aHRFZy9PTzYwM1ZYaEY4bEcy?=
 =?utf-8?B?UW40aXlrVittL3NQak1VaDBaNXlHUllRK2k5alVRcmdGY2hFRFBxVU10SER6?=
 =?utf-8?B?UmhxZVFxcDdualNST2lISSt6a2hPb1BscjFpN2hxeUVLOExJVkpTMkxjdEYz?=
 =?utf-8?B?N0lQVCtVcTNSamdaUUNRVzJMK1I5M3VGRWpYRUpGREluRW5XejUxc3ZWMGNS?=
 =?utf-8?B?Yk8xZVhCVnFZSDZ0SEZoYmJPQlp0N3U4Skg2ME1UWkFqWXNjUXJMaW45L2d2?=
 =?utf-8?B?MFVWV2NrQWtvME5GR3Fmdm5EZmcwSngxMEtiSU96Q0pvSlJFRDJXdkFUWXdW?=
 =?utf-8?B?by9wejM4R3R3Q1gyS3o0NnBTcXVubFhPNmlPUi96ZEN4SjhjZFFsNVhvTy93?=
 =?utf-8?B?SktGcVMwa1MwcWFqbDFUdWtkYVpnUTJjQldJeXBEZ2ZXZ01PRHd0QWJmNUo0?=
 =?utf-8?B?K0xqbWZKUEpmOTZVdVZydjYwZzB1WXU5VEptWDZ5a2FuWXN2dDlWOXdObk9E?=
 =?utf-8?B?Y2dyR1FickFSalJHaVI0SEdmQXhLQ2pCeTQ5d2tpdUVQdmhEMVppVjVnMStF?=
 =?utf-8?B?Vlh5NjdtblNwamV0alVGR0R1T0lTWmkxc0hVSG5PZDZEWDdWMnJvLzJ1TnFQ?=
 =?utf-8?B?T3psKzE2dG9lOEY2bGdVbm1Scmp4Mk00WmFSa3RoOTFjZkV2TGhwdFRzRkQ0?=
 =?utf-8?B?YzdieCt6SGVaK0FDMEVEOHhsb1VMbnAyWU1uZ2VYdkRra3JwODZvbHR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklUdjgzNVJ2ZUpJLzJ0Qkp3ZnBoUmtZbzFSa1QyVk1UdDZDVkZ2OFhCcU9W?=
 =?utf-8?B?MXVVRUF2N1F4M3pUK3I1QnhRZng2T3EvZGhUeXhkNXB2ME82TzV3U3lXOW1V?=
 =?utf-8?B?U01jc0xUdmY0eXI1Z2EyREdUNzBXeTZhaXZCTVBXQitIZGNTQUdaMmpETlBq?=
 =?utf-8?B?ZU9RRjNVY3BwWjBTUTZKTTd5T2V3VlZ0eTMxWGlSV0Z3dnNCQzkvdldaSTd6?=
 =?utf-8?B?ZG91WU9Rd0x6L3J5Nyt6ZzhwQ1BnOFBQa0N1TlQxS284a05DSlZLREJFTFBv?=
 =?utf-8?B?STB6eWdLVWdmd3hnLzExVmhwcm56S1g2SkJGMWJXNzduK09KK1krMXorYVZQ?=
 =?utf-8?B?NUk1UEN6M3E1UDU3UXo4QVBSK3VEc1d2RmhFTEFRUW9Wb3RpZ1E3NG92Zjhk?=
 =?utf-8?B?ZWRmNzRieHh2M2tUV3BkQUZpU054b1NFcnZJbDdEVys2dVZXeGdDaWF0MWwr?=
 =?utf-8?B?NkpOZWtvMDl2M0d3bTRUTm9NNXRzQ216cndtNkEwbVVsTFpxN2s1VTFtSVV2?=
 =?utf-8?B?b25VU3RZTDM5T1BCY2grQ20xNXBsOWdiWFFYSWtLVnFsK0hITDBoNndnY2tC?=
 =?utf-8?B?R1lWbnY5N09SQ21RaUhxbFBUMWJTekhMOElYQXRhR1JHZlJCL09OQmw5a204?=
 =?utf-8?B?eTlZM3l0SEJzRnpIYndKK0hyRHRpekZ1eFlJbjQ0TEg2L1NrL1hLZ09vTUZr?=
 =?utf-8?B?TjM0amR0VGkwSTNGVzdXdE9jT1V1aGl5UStqdis3aHBSK1lHZVlJRWp1MGNj?=
 =?utf-8?B?RS9IYnlIUjk3cUNGek5IZStObkFUWWViWTVOYXFGZWlsbjFoUjlFdTBudDhH?=
 =?utf-8?B?ZUNGNFc1L1NBWmsrMzJnVVo3WVZvNmJpTFRoNStyK1Q5V3gxaHpuNmlFTE1Y?=
 =?utf-8?B?WGNWSkFtTTlaQ05yWHJzZVpQRnNDRTlLODBma2VzZTJQb3BSZ1ZPdVMvblFU?=
 =?utf-8?B?aWU5M3ZldUk2VHhlUUQ4ck1sWjFZdmwzTGpVU1liMDhvbHR1QXZCYnIzUlZo?=
 =?utf-8?B?Y3JTb2RxV0xJK1RDNG01YUVBVldYOG9od1c1alZ4TERMZzUydEJ5bVpPdTEz?=
 =?utf-8?B?dVRBekorK0dpVFpKbW0zSnJ2eHFFYlo1UGpWaWtMeGE3SnphZWJia3J1Y3I2?=
 =?utf-8?B?STh6ZW92V0VPcmEyRTd3ZHJIZGNEbXJKVnFlQXRuOXI2eGl4UlpwOFBmbVBa?=
 =?utf-8?B?NEN5a1BLU00weVBJN3luMUVoZjhVUXZZUlJNem8zdklzVDZHeHdZMmlENEd4?=
 =?utf-8?B?Uk81bldGU2QyeVRRWmo2emdtVzBILzdjaFBISE5MZHFnQlFUeElqVVNHK2RS?=
 =?utf-8?B?MkMwaFRHNURuNEw0ZjllWUNVdGxNSUwxdWZRaU96TG4rR2s1ZjdDQnBzSm9l?=
 =?utf-8?B?Vjh5VmlDRUJBK0cwQk9WdkdWRUo2TjB6SUZHb3JwOVVKUEZzdWlrWGlONTg4?=
 =?utf-8?B?NVp6UHVPbnVZU3lNU0xFbUloeVNPWEhDTWxpM3RRUTdNRTFzczc0eUV1dVVk?=
 =?utf-8?B?blBrMGJvTEpBRlZIRjJjMXdxcWoyMmtyMUFuOUswdmZCSEI2ckE1UW16ZXZ5?=
 =?utf-8?B?UTk1S0JMM1N6d0JxNFQzWmhDVGtWcUVXNHc0cG8ydlQ5L08xZ1kzR1V3dnBo?=
 =?utf-8?B?UVRDc0NNTEZFQkpISnVWOGZuYWF1VlU4RnptNExGRUp6WEprZmdNTWtLTGZG?=
 =?utf-8?B?MnNyZThJc0JLRERpZmNhMnRLQXJHQmRMOFlVT3AxMXhsbFU0eVJkbmdCWjhq?=
 =?utf-8?B?TmFWR21IbUNlY2psNjFLNFlkMTdQYnR4Y2F3T3VsMHc4bytCYVV3bERYcnRP?=
 =?utf-8?B?Z051Z212b3dLdGU4S2l2dUdWSUdmQTZEMUx4VE0rb3I4bVZGYnZwUkFMTXZZ?=
 =?utf-8?B?T3pmWWlIbTZ1UklIbDEydlRheGgwMEQ3NFd1bUkwNkFva3dXVHIxbnF2SmZT?=
 =?utf-8?B?KzkzeG5zQ1MzaExHTVdBbHZ1SnZMNW0wTU1aM25mMnlUSHoraE5hMmxhbVdM?=
 =?utf-8?B?eHRHOVZ4RGpJaklocjM4OHloei9xbi9NSDRtbXluY2RGQ0xHb2tDSlJnb3dY?=
 =?utf-8?B?UmJZejlBRUNBWVVmdUZabGpMbno3REp0RzZYb3N0UW82TlJWS2pDTnBKUE5U?=
 =?utf-8?Q?kCCcyhuUFYKHtS45ocJSR8A1m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b40c70-73c4-47d5-fecb-08dce7abcf2a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:13:48.3437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb6PHL157ruau6OGUOUeJ3fJCbAd8muiBr8/LZQ6xeBLYfgUTmAaEhN4ubTHSTzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

Am 08.10.24 um 15:34 schrieb Sunil Khatri:
> *** BLURB HERE ***
>
> Sunil Khatri (6):
>    drm/amdgpu: optimize insert_nop using multi dwords
>    drm/amdgpu: optimize fn gfx_v9_4_3_ring_insert_nop
>    drm/amdgpu: optimize fn gfx_v9_ring_insert_nop
>    drm/amdgpu: optimize fn gfx_v10_ring_insert_nop
>    drm/amdgpu: optimize fn gfx_v11_ring_insert_nop
>    drm/amdgpu: optimize fn gfx_v12_ring_insert_nop
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 22 +++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  5 +----
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  5 +----
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  5 +----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  5 +----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  5 +----
>   6 files changed, 24 insertions(+), 23 deletions(-)
>

