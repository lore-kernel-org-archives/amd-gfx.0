Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93425C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 21:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424DC10E2EC;
	Mon,  3 Mar 2025 21:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nyWpQDW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1702610E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 21:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQn1WDp2iQorD5f2JVrLparoXieZUzEtL2MGKKxQzwJk9gxI7pUd4048Fj9VZGMe584OuXDjoYAxRgZu01jIvArJ4BU8XydDfdKdsHNaYYNYfDV8hhZYDhdDUB46D7iU35il40NZmx8bQd8m/pi1yjV89MzpsbQ2ow3a//zMuvyx5+ky9une+n+UMOMnQKngJRb5spQ4L23Oi3U2gHOwwKs5HyxGsLiAvK+HPple5JBdZaY1OUep/kAvR6aSDxFITTO9CLiwztZvN7UL0WrivGVXMIeT7Fy/LGjVw0pitiDzwPY5cUwmRiv7N7wgmRr7xe7D8RoRfA0vgW1EHgCoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oLFB3zYDWwtfPSoVbDGWuIW+dtUVrTMPQxbWLC08rI=;
 b=a9fTC5tWzEs+Nn6jfHtavDX56/9BTJWqT517paKOoPio2tyuErU5/VsEijSFqR+tY3X5iHf4ouWFp7RZlNySOo8g2o+Ia8VIM1zKnCOE+RTCBvJaO59NWeg3+HVHnhxmfQOyVoNUHk8BXkkqvALSO68qef/2A1MQA9KhogvcaT19qQPWtnuArA+I45ISUFo4U2M9DzgtAU9f4oLpm71fFDQTwgXK3/mZz62HfRidWAQrDIHRX0/CKV6zpk/i/TvFZLnFnNwXz542YxSgYqgJzKTI0WfYczUN2sve9YGJTX1U4WnBU83VvxhGbGHaTElID7tiOJ2VgaXNjkGHPOOzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oLFB3zYDWwtfPSoVbDGWuIW+dtUVrTMPQxbWLC08rI=;
 b=3nyWpQDWtPF8EUI+eNgwkrwUR7jeJ4T8+s3nmtROLReV6eaG+f1Ft2yxbD+CptFM1E0OeVJ6mv33DjzWw/SmjBUeDwREo3fw5Rmuo0b0m9chtuJZqxVDwzHaHiDzAYsa30SUFMBQ2bfe4GIFYo0iFeC/ics61/J/Y2BlJqM0oXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Mon, 3 Mar
 2025 21:48:51 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:48:51 +0000
Message-ID: <dda228be-5438-4ed8-8f62-a3c987ad404d@amd.com>
Date: Mon, 3 Mar 2025 14:48:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: use drm_* instead of DRM_ in
 apply_edid_quirks()
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com
References: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
 <20250303135051.1177406-2-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250303135051.1177406-2-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::20) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 778b7e98-629f-4821-6618-08dd5a9d2f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGFRV2pES0cxZHBNZjlNanRNcG1vSkFYRjVDVGpyM0pKbCtqVXppcjRGRkpH?=
 =?utf-8?B?eXBVTXE0SElpOHowOWQxaGI0SjkvdlEvRWQ2L0ZHZ3hTVXVoWlhVWjg0MEtL?=
 =?utf-8?B?UmxpK2hKMllJb002QjRWem1MS1VwSXlpYVVZOUtFa0Yvc3V2cENGK2h2S0No?=
 =?utf-8?B?YndnUmtNaE15cHh4Sm5ycjZnb2NMNDc0Z1NBcG1lL1c3UXFOMW1JOWFRZUlw?=
 =?utf-8?B?V3AyK3grckl5UWRmaHdXL1RiUVR5eGRGWjdxc0g5dmtRbFdjSTVaQjA4Q0F3?=
 =?utf-8?B?OVljaG1xZHljLzV5elZKQnFRb21hclE2WnE5MEZBL3g0M3Z3NktTZjZDdHBp?=
 =?utf-8?B?S0ZualFqelF4THlFS2hvWE5aSStsUjlLb0pJRlRoUzNEKzdmd2ZML3NXeTgr?=
 =?utf-8?B?OXp2M3ZraWtyN3RUY1hidFBzcGl3R0hpeWV3QUNPQVMvNTAxOHNiRDFkaXZa?=
 =?utf-8?B?R3JVOExUYVJnS3U3K2JhQmpvZ2ZlTFF6aFZva1BXZyt6NENCbFJXSmdXaVds?=
 =?utf-8?B?VjhpOWpQK2lPVWJJUEFxb0UyQitMQ1VWOU5teWlCYU9ySmpuRkFleFNWZGtF?=
 =?utf-8?B?Y0wwSEwrTVpJM0QrUjAzbE1JMTI2MTBIeVE1YmttbTI4OTg2SEt2bDZIcHlw?=
 =?utf-8?B?enhVdzdoZU1mb21VaE85bTF4L2FCaUxjZmlOT1k2eTlsL3JTNWk5QWlFSXpj?=
 =?utf-8?B?Rkt1bEJTVlVDQXVXMGVFbDhiaVdyeHZWN2tLaE9pNmg1UngyakZadWNTSzlw?=
 =?utf-8?B?TFRYeXRTTXpQcUh2czkySlc5akpKQnkvR1NCdFl4K3RGcy9lcklUZVh6Z1Ja?=
 =?utf-8?B?YzFCcHZaWVhIVTE0Nng2amIvNG9WdVZGWGpsTUlIYk16WHpDSXgwbjJSQkFn?=
 =?utf-8?B?ODVUc3Vab3VFK2xKMWN2cHo4ZWlVTVFtMXhWYXg3ODVuNVA5NDB1NnBVaURS?=
 =?utf-8?B?UHdrMVMwWDVqQU0yeC9LWUoyblU4VVNZaFRidWlBcDkzNCtJVXlheVhtRFh0?=
 =?utf-8?B?Qm1GVFRrWTRIREJra3ZjVFRQUjFacDEycXppN0lRekRHMVdub2JGaW83RVJV?=
 =?utf-8?B?S2NzNU9qYlVrTTBleFcrZjdMM1c5RUNBV3ZKc3lxejU0VUpYS1N2NXRPcmd4?=
 =?utf-8?B?djk2Y0VoYi8rR3hCMXU0Q2ZnS0FQUFFrVFBGa042bVBWU1ZsTDI4WlhJTUNV?=
 =?utf-8?B?ZlM0bzlEa3BtRmNnN0puUmFMTkF6RVM4UTBIdGpiVm5vRjlOQVNrWkd2V0xy?=
 =?utf-8?B?UmVwUzBMa0FtcWtkaU12cUgrdTVZeVNjblk0ZVVwT3J1UGtSZXovRU8rSjJK?=
 =?utf-8?B?Z3hNeGdaSkw3cjloRTMvOHpSK0pEdjRxTU5Td2pubkZWdTYrMHFOTGs4Q0Jz?=
 =?utf-8?B?bTNGRUtzRWFyak9CUkFSdHBhNUV0UEVaY3ZPcVZ3R3pudDhlRC9SSllGUWpC?=
 =?utf-8?B?N0VVbXVLcllxUnlvMUh2TERIc3lERE9UZmVQbjNPWVpQUWF5WUlTRHFVbkdJ?=
 =?utf-8?B?NGVsNnJ2R0NzdHRkVXJQSzlQZlpUTDlWS1NjUWFJVXFCbnUvQ0dUNXdMd3Nx?=
 =?utf-8?B?YU5HS2RxMUljL1hLTE5sR0hqMmlMOWtOVE96a1FRVU5XMFNwMlI3QTMvZStU?=
 =?utf-8?B?K1B0cTdXMTNBM1Zqek5rVys0aFE1b2VRUDZnTVRMOFhRYndXdTBIalg2TE1F?=
 =?utf-8?B?SDUxdjd0cDArZ3RFZ09kMDFrd3ZwcjVsRG1hbXhWQUc1blp5dEEwdm9qQURq?=
 =?utf-8?B?Z2Y2SGU5OE5STnVSNnJUK1NEOW5xZkdyR0UwbHdKUEUvL240VTFzZ3dxeEVW?=
 =?utf-8?B?QllXWDFJVnlOU3hPdTI4ZXBjY1BpNmdIK3NEUVN4dmRkbVV2amIxRldYTHQ1?=
 =?utf-8?Q?odzt14gS2wiII?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFFb1N6cjRHUWJDcDZhdGxXVFNuQmZiLzBsb0p4OFBKZ1BBallQRE0rQnd1?=
 =?utf-8?B?VUZucGxzdlBZR1FIQlVWUWE2US9HRWloZTB6L3RPMzk4OHRYeDg1M2dDOExC?=
 =?utf-8?B?V1k1bDB1azJ4U3Z0eG4wQ3RLTEFLQllsUDR5ajF0cFAyUmUyQ0FiWU1WQ2pV?=
 =?utf-8?B?SVBWb0lwVXAvUEV2YktoNzBuSWs5ak93dEZDd0J3U3M2TklkUE14WkFKQWo1?=
 =?utf-8?B?LzdKSW5HcWJqbHE5eWdlU2FWaEN3VHJOT2pWK3FUZUVETDNERGZLa1RDZnp5?=
 =?utf-8?B?d29mYkZlME42Y0FIWnJOYUJLR0hBVmkvNjVDMkV4VjBXWXhPc1hWS0dlWERB?=
 =?utf-8?B?ei8zTi9QbytVYjJpMm84ano3b29rblNodHh0blZTdWtBREM2RVRFczZXOGNn?=
 =?utf-8?B?Y3pVbldjSU9NMzg1NXJOdllwaTZNa2ZJbTYyQXdJVTFxNGdtMlI5cXBLM3Br?=
 =?utf-8?B?OHdSYVM4cTJYSmF4aFg0NFFyNlh0ZzNTWlBzcklKYzZIcHdFQ2E4V0xLRzA2?=
 =?utf-8?B?QTlQeHF6c3Z1SEVkL1BKbURlRG82VmJKc1ZWVHZKRFo5MGp3ZVIzY2lrVnVI?=
 =?utf-8?B?WHIvcUdJck1vVndwbHA5d29lM1U4ZEdoblpPMHBDeWJHNFl1c09DV01EWjZi?=
 =?utf-8?B?cVRnVHJVOGxFRThmTVgzQ0xyWU81MFFXMXE0VnpKQ1g1eXRmdHJaUlZqM3pK?=
 =?utf-8?B?NC9KVHhxTUpRV3dhUXZ4U0FPTjBqbWtaa0RPejVzM0ZRbWo3SmFnV0xnMDlR?=
 =?utf-8?B?bU5uY0tYWk1iQnRmSjRZbjhVbkd2cHVEbTlyRjNjRWY1UFJINVN4L0grK2cz?=
 =?utf-8?B?UXJnc3pNMDk3c3docmhNbWRSM3J4MmExLzNXODJORlZxTUMyNUNkT050YWlR?=
 =?utf-8?B?UVQ0by9uZWVmd0NqT3pvMHl1RUxDL3FFc3FkUytuMkhGNE9neklzTmVwYkYw?=
 =?utf-8?B?WmlMNXVQYWNOMytJQUZ5cVZvL3RVd1Btdys4QkZJZndGNWRXVWpucFhxWU5C?=
 =?utf-8?B?ZUgrcGJJQi9hQWo5ZENKWG8wOGpQMFY0aHdlM1JzeFZWZTZ0RVFjNmRxcGcx?=
 =?utf-8?B?OFluYi85aGRURVVNK1czRFFqTU91Z1hScVRTbGlBQ0hiZ3FjeG5aQ3V2Mkpa?=
 =?utf-8?B?YWxtcWd1Z3U4MGJtVkZsQWhaTFA2aWE4VUFxampZYXBRQm04WjYveDZicUhP?=
 =?utf-8?B?eDdaY0ZpTlZoalA0RW9XY2tWdlUvc3VkSzJZY1lvVWg3bnQyY0dTWFd4V1I4?=
 =?utf-8?B?L2hwU2JkQ1AxQ3puK0hHRHNPQU1OZzVqSW55T2lzWWN0a3kwRnpGZitEdm9h?=
 =?utf-8?B?TkFSbjUxTW94MUdmQXBSN21DQ2xTWUtxN0k4OVBqaGVvQVI4c0lDUHFoZHBi?=
 =?utf-8?B?TlJhODAxM3NTVUJ6MzVGQlF1QlFZaFFQSlFRNjM4TDBaUlc1eGZIWGY0M1I2?=
 =?utf-8?B?d05xbjdmcG5PU1FjaWpQaTZ2WVF6eWs0bUlTSWxpRVNSTDRKQitKZGRQbXp0?=
 =?utf-8?B?QlZtKy96NUZNZVRmd3RndEFPOHBVNTFvaldId3hwTE0rS00vb0RjVnNkayth?=
 =?utf-8?B?ZEt1YzI2NEJLUG56dEZuSWJteEhqbHQyTm1mYXVQWk9SRzRyVGRwYlZ5ZmlY?=
 =?utf-8?B?L3k4YUx4WFJxUFJuQ29yU2ZMNHJ5aGN6UjZFRXV3MDRCVU5IMzVFbjdPUEo5?=
 =?utf-8?B?Y3JrUWFmb1pQQ3FaWXZSbCtCcDZjcnhMT2trcitoN1Avc0MrcTV4bmpadnlF?=
 =?utf-8?B?YUl6aXlvdDh6SGgxSnFaVm5jLzJoSTc5MlBIR0xtZ3ZLSlNKdmxDRTdXTTFo?=
 =?utf-8?B?eUZjWkd1TmxRQjlIcHh3eW4wMnZaZ1ExcGE0Vm4vOUJoY0ZtZnhYMHlrNTJv?=
 =?utf-8?B?bmV0blQ3RVVZa3JtZms0WThJVktGYVc2czdrQlZEUmNkOFhTRXFMMUF2NzZu?=
 =?utf-8?B?NU1QT1Y1Z0crU0M0WGNOU3NNZVNzNW9Zenp5ZHU0NjFwOWhMSmJJWWI0OTNw?=
 =?utf-8?B?UFBteXlzeWNaMnJDald1dG1OM0o2ZkNUaXVPUGdnMzI0NmpSVU92Z28xRkRE?=
 =?utf-8?B?YkM2VXBpQXZGRlpacTZUWXBmdDkwRVYvQW1FdVNFQnZEYjFvY20rM2xtSWND?=
 =?utf-8?Q?GDQ/sza/iiEFJy8tf85Sw3eB+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778b7e98-629f-4821-6618-08dd5a9d2f88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:48:51.1844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFW55GW0dvkg6AKKlEUppIksUA3OeEgqcy1xY2sq6vwBtKcN0jHFLEIlBqsrFhvbxJElKJqI04aQgHAMHnEycQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/3/25 06:50, Aurabindo Pillai wrote:
> drm_* macros are more helpful that DRM_* macros since the former
> indicates the associated DRM device that prints the error, which maybe
> helpful when debugging.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 253aac93e3d8..2cd35392e2da 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -69,7 +69,7 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
>   	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
>   	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
>   	case drm_edid_encode_panel_id('S', 'A', 'M', 0x71AC):
> -		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
> +		drm_dbg_driver(dev, "Disabling FAMS on monitor with panel id %X\n", panel_id);
>   		edid_caps->panel_patch.disable_fams = true;
>   		break;
>   	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
> @@ -78,11 +78,11 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
>   	case drm_edid_encode_panel_id('B', 'O', 'E', 0x092A):
>   	case drm_edid_encode_panel_id('L', 'G', 'D', 0x06D1):
>   	case drm_edid_encode_panel_id('M', 'S', 'F', 0x1003):
> -		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
> +		drm_dbg_driver(dev, "Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
>   		edid_caps->panel_patch.remove_sink_ext_caps = true;
>   		break;
>   	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4154):
> -		DRM_DEBUG_DRIVER("Disabling VSC on monitor with panel id %X\n", panel_id);
> +		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
>   		edid_caps->panel_patch.disable_colorimetry = true;
>   		break;
>   	default:

