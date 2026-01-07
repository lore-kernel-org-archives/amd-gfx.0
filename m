Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C974CFD658
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D999E10E5F2;
	Wed,  7 Jan 2026 15:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Wn8DBgl";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B6E10E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCI07C7eYToj8N4QkKpj0J38Zg1mhLWI8kXGqUTR5KaeIfcdPQix5NpeyyahPMYvbKI0O8mHpzO2FDZZJHKscQa8BgXZGZikq0xkY8wkbOhjsmU2Ch9opyxkXdY9cjzCbs0zCap5imatGjZkrBnKcvMggvma5fjI2A+43rQb6HZClPKebTSajIOrRBqp7D57pAklaxvJVs8RwEGbsEATowM5O1XUoc7UtkM9D5d+Jb36WrWegHPbGBG5WUAOyLzl3JTpw7fW3cAupH0hUFglskjr4Ik06DvU5I+0GueJWb0vjs4Xf/2IXpqhhCvwdxbF6mvJ2k+tIij1H+nL8HTN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U140st/bSgn+SEmEMLEMSYDhmU4HXuIeOfpS9AspTOM=;
 b=uRpavIkDZ4JO1DnVNQgV4GuWbmqXH819ghncF3OV3LAu4RRidTVMQ86lc0wJYBaiYhyjagBZEpca3Slrpjf9IsD0L/2CeMjMxNojIrXIEAj5lMJWLMjdXevzaRtug9yOOLOZ9/tJne8Vkv+Zzbddk1WvOSVtZ4juL2vEv4dP2Gg1ew5Z5KK9MPnxdnY9fagjN26vakiWihkGHKEl494whSDvqHSBD0zghup+7msZ38S1VypMOnGjLzmDahA8GmN6FwQMUdWfYECC2vtaLE85STTxALlvRjfIExZVEhuUWNgaw4uXXch34SQacKB+gfV9Wt95ZDSh7VxzKuNLado4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U140st/bSgn+SEmEMLEMSYDhmU4HXuIeOfpS9AspTOM=;
 b=2Wn8DBglklXd//sHG87UN1VoO9AFF+yU0P5Y13LEnB511tDbYS4+fg3WePbdVB+q+A+Tbppqjij/1kBpCeUlmVU7BbUk7ZD1DyK8qfaBboMmsES06zXwKjwMHng8ZqIyEcKZYgMjYQOErjIElbCePwEr3QxbOkZ/DOaupfcfEZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:39:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 15:39:47 +0000
Message-ID: <abc0181d-a8d6-4fa3-b532-4506741615e2@amd.com>
Date: Wed, 7 Jan 2026 16:39:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/amdgpu: change the timeout for user queue
 fence waiting
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0480.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b1041b-2697-40ac-cc3e-08de4e02fcc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTJrZUd0T0I4NzZCMTZPSFlSZWQ3UEpUWEVYM0YrN3NSUnlraENqNzd6cXBs?=
 =?utf-8?B?ajBOcll5bjBJd2QwV3gydjNiTXNrRVpSZFBobXZwWEYrQVZ5RDg5VUJCM1RF?=
 =?utf-8?B?WHd6azAvMi9iK1lhZFZXR3pqaUVlcVBBRXlRNlhoVVpSeGg2ZFcvZ0Q4eWFU?=
 =?utf-8?B?QzVBVUUzRmo3QVhqUUpjc1FNSFFIMHh5emlyaGNBcUNDZFRiYUxybzl4YXpI?=
 =?utf-8?B?NlgrWWJSczBuL2k4SE16MFJkN3M5WXgvY1NMT2doWUxlL0pTNUQra09GV3dX?=
 =?utf-8?B?WURLeGhXOC9FNVJCZ0grS2tjTkVkYm9ycWxjeUhocnBtRy84aVhHelVCV2hB?=
 =?utf-8?B?YmxIaU1aVlZackg1M01nMFBJajBhaUUvZ3haV09uTEw4MzVPMnJpMGxOQUlP?=
 =?utf-8?B?TERWejM2K244bmdHT0tyakxVa3RlNXYvd1VVbE5JS2hxbW1xeGFvR0xVN3Vu?=
 =?utf-8?B?aURHck9VbmpIS2FsdlFrdzlEWEp5WWFoUy9iVXI2NWhrQWtlTFlwK1FqdElR?=
 =?utf-8?B?dVNLSTBMcm1WYkI2dTFpQXVrTVhHT3E1eG5SZjdjYnJnVlI2Nyt6cVUrMnZC?=
 =?utf-8?B?cVZaR2oxTmp3ZzZPSERrdnFhY3BZWVBBMnE4ckxHSkk3RDVjZmFVUGxtUmd2?=
 =?utf-8?B?bXN1VXYyKytoU3dkeW5sVlMxMlh6TDJ0UzNLa0NzZWVUaFZjOXZFUTNVWEhJ?=
 =?utf-8?B?Y0RBOTRZa3U3RHpDWUJrUHM2NC9uT1F2bFFVTXVTQXhkZUJGWlNHSm1pSWNq?=
 =?utf-8?B?OEhMdXdBMEJ2Rzlad2VrQzd4V2FhdmRBSGExcC8yamhHNi9qREJjZDZxSzF5?=
 =?utf-8?B?WTNDSUppbDIrQTVHdWZLUS9MTGloek43ajhSa2U0UUhoRG9pWklxcUZrMUl6?=
 =?utf-8?B?dXBvTzcyR01nSUJ4blZmeE0vVVN5Y3YrdDVBK2RVcGZyVkl6ZGNVVTNnQkFF?=
 =?utf-8?B?czdRU3llVllldWxGQ1JvR1U4NmJtN2lWUDNseGIwR3RnT0dTcGxWc1N0RDJ3?=
 =?utf-8?B?NEwzbUJ4QisreXZrUEk1RDBDZWoyS2t0MzduTU5wNTZXZ3F3cmVEVUNTN0RD?=
 =?utf-8?B?NEFQQXBxdVdZa3c4bFpmY3B6RWFXUWtNOTJhQXU4bkxNajFYS1p5WjFQTkRH?=
 =?utf-8?B?WHROZk1lVy93QWs2enZpSXY3NmlsMUdzcjF3OFc2c2srTksydkhZZ2dkVjFm?=
 =?utf-8?B?L29LVW1wYmdVajNWcEpxdzREU0Z5QkxiNExWR2NrN2lVQ1pYRDR1OFRGc2t1?=
 =?utf-8?B?K0RJQkdNdFF2S1M0dmhDOXNyQUdQZm10RVBsTk9DOVNrTFhvdE1PcnpKek5E?=
 =?utf-8?B?MThlWXV4MEJ0U2Yyd3loYjFJZWdSMWpnRWxieXJ5R0xrbndmQXZGNm9BSk8r?=
 =?utf-8?B?MlRPZGZaaEdjNkxWVDNkOHU4SEhiQ0wvUFZjanBaM2FvM3VSYUZBdDBXZjY4?=
 =?utf-8?B?NmFFckxYaUk5bUN0UkRaWjJEL2t3bXZJWkIwejZZc1Ayamt6ODF0MjhVZzlz?=
 =?utf-8?B?KzlJWVpydXMzc1NDZFZXOThzTU9FMGZhV0wzYXo3SGZ2MkpHV0NJbmhxY2Za?=
 =?utf-8?B?Wmc0Y29uckpWdm5FNnVnbWhlQXBOcWo4VHJMVUlUc0lONEozRTFoeVJMK2dt?=
 =?utf-8?B?KzBGVTl4VVdJZDJzcXBQT3NtL1cydWZNOUxabjdZc0RjcTc0YUxLV3c0MTQx?=
 =?utf-8?B?R2FoYjljaG5vUWtwVHhmbVRhSnJRSC9IMHlxZHlMVkVIL2dkdStoRkQ4b3Y0?=
 =?utf-8?B?SmhBMmFGZUZlM1paQlQxb0lLcitEUVQ0Qmo3UldBQXNzaVJZQU0wb0U3MXY4?=
 =?utf-8?B?VFBTb3R3WHl2dDhlek1ld2VXeVNxNWVXUkd3eHU1NVdoOWg4Rm9kcGd0TVAr?=
 =?utf-8?B?emlDSk1Ha2JhT09YTTZJZFZZQXVlWStDM2ljTnRqaWsxYzdNNEdGeVRmZXFP?=
 =?utf-8?Q?SeF9SIxfzv9NmR/QfFnys6GZHJ+ahu5j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC95U0NDWlo2ZFVOWjhFSFc5TEI2Q2c0eVh0blBZYStpejl0TUtOdTdSbmF6?=
 =?utf-8?B?YW1sdU5mcEZMTDFSUjZYZWZZaUhuMmVHYXgzQlZQbjVsSXF2TU9yQmRwVXpT?=
 =?utf-8?B?a2V4enU1SVNMTXc4SXFodXZrTTV3VVQ5aE1mVkxGS0tiMXc2YTF0WXMyQ3lj?=
 =?utf-8?B?K3RrSXRSYVpBbWpZdWZBK0hMWm0vWXVGTHkza1BzTW0yWDBWMFNMWThWUlpo?=
 =?utf-8?B?YnpPeHBMRGJwNmxkTnVLN1ppaEZQanpSVTRXNUJRZWlOdGtuZExWa2EyTXQr?=
 =?utf-8?B?OW9sS2dYd3N1S3RRNzFpYXNnSkZHdzdHZHRiSHc0OXBrN1dnR2pvQjJIc0Nt?=
 =?utf-8?B?UHg2bWZYM096VVdlUnNvTkdUcEhTekozdmxxc3RUSEJ5ajFML2tTTVNFb1p5?=
 =?utf-8?B?dExPaGtOVWhMN2YyU2RqVmZOOXBFR2g3M21ZM3lPV3lUU3ArSDAwNWFobzRX?=
 =?utf-8?B?aWdkc01nclVCTGdHbE0rZC85cGFtK3FSR3VZcGRMVmJQOVJOZjQ4TDVodldH?=
 =?utf-8?B?NFRUaEpNMnh3d3VsTThPZDZLUE1qZTMwdUJHUUY1VEdIUmtMSUFsb0Y5NTUv?=
 =?utf-8?B?cm5Fb3FuM0VyY1hRVkFTK3poNFhYaTl3S1E1cCtrVTZwb1dOZmdWaWVGSzUx?=
 =?utf-8?B?SmhmblpNZms4cTFJREYzankzSWJqRktDb211WjhJVlVXdkJuV1hFMGdudDNJ?=
 =?utf-8?B?bWZlWnRiUDRrcjZWcDZCNU0xZzkrL3B6c2NHTUQwZmg0NjR0Um1vQ3d3ZUpH?=
 =?utf-8?B?YU1NL3RYbVNFVHdVc0czVWdaRVVpZ3JVVVhXTFZxdEh4UStXRnpZV0NRMjk0?=
 =?utf-8?B?SDNqaFhBMmdqYU5WcjR3dEZqd1JrdWNRMDhxYzZYTzVldlYvRVRDUkhzdVlr?=
 =?utf-8?B?OGRVMWlIckk0Vjh2bUg0bUR3djNORnJZU0VNYm05azM1akRENTArbXVBeFJT?=
 =?utf-8?B?SWZNZ2t0a2dWYjM3amdXcERZTGorRlZTUy9PNW1WS2JxQXBwM2E3akVBUVBk?=
 =?utf-8?B?MTJ5L3d4YmZSd0Rhcm41MmZXRHJGd1BaV2NUeXRqbW0rVzN0VmZIMEFaZlkv?=
 =?utf-8?B?L1ZWNlhJcTYvSzhYZWgxREI4QkpWcFNmWkpUUmdlN2J2aTB4Mmt6VWs4U1ZM?=
 =?utf-8?B?UFBsdi9GWi9lejR6d21HWkg2N0NmNmhHVzRxYTRJUTZnSHliNEF4U20xTGdL?=
 =?utf-8?B?bjJlemVCRzFxMmVLaCtsSEFVQ2F2ak1xeFVlbi8vQ1YzNCtNVUxPWENxbkdV?=
 =?utf-8?B?YjgvQ2MvWDNhSzJIZ0xTTzMrOHZZWFpnbDJPbnluOE5YTmZHOE9ydXpTYm9o?=
 =?utf-8?B?T05LbjQ4WXV2Q1BhNzlzRnI5TFk3d3U3a044YkQrcGlkU3hhTnc3T1JxbWpD?=
 =?utf-8?B?TEZjY250OTNBR05KZkZ6TWcrMXVjZGZ3U2NzbXBXMlRtODIzMnJEbEt0dE1j?=
 =?utf-8?B?UlNkSDhrdUoxZ0JUbjdEVFlpOUN2ZTdNWUdIWVZKcTJrWFF6MmdUQ1BqeC9X?=
 =?utf-8?B?ZDN2eGc2TUtWRktOUXVoKzZYbHA3OWRScnFaVXRuWkdybllLUnZINldXdnFY?=
 =?utf-8?B?T05wSG9CdmVHeEQrRHdxKzRWTjBvMGJIaW5FRGs0eGE3Wi8xMzZXZ3Z0VEc1?=
 =?utf-8?B?bk1oVWdQRUZGbFBTL1NXSjhzaC9XeWNzRjhaNUNSQWdXREMweXQrWGhtR0RT?=
 =?utf-8?B?dXNlMitLQytZOUx4dmJ5dm1UM25LMXgxYjRCM1R3VVBOWUxxTlJwTGhXR2tG?=
 =?utf-8?B?NVdJTmNQYzFLMGxWSjlWeTU5eEVDS1lETDBLVE95bE9KYmNWalJPb0pkZjln?=
 =?utf-8?B?bktNQ3M2Z1NCb1pQRFF6TE9ENGx3Ty9XSW1yZFpuODFXRVpJZ09UcGdCcmsv?=
 =?utf-8?B?VkxqSEpnVlAwTmpJODQvTjNBVmtjNzZ5YVdrQVMveStQNTAvUjUvQXhFbGpN?=
 =?utf-8?B?ZzFlWTk0ZTdvNnRQWTdtVzhGSnFTVjQrUGY0ZFVPcVVGRXE2TUYrQXZLeDA1?=
 =?utf-8?B?Q2FYaVlRVFFqZDZNNUhlSm13VnJmYjhnUWxDQmJrYVRoRlJ0MHVMdnh1Zm84?=
 =?utf-8?B?QWFiQnA4VmczczlqandQaDZEN3UzRktJSXZzSUQxZDlzeTlvWE9ORkw1SWNi?=
 =?utf-8?B?cWxDdVV4d0VIeVp3MjZ6N0NTZmpIK3R2dlJoS1l0WE9mV0hRTllyV0RXNXYr?=
 =?utf-8?B?aS9oRVlHYXpjZ3J6Y1lqYWlURm1CNWNqbUlqN05ucDI5elpwa25mNVBtYlBV?=
 =?utf-8?B?Q25RRkdnU2ZyTG9VdWlmbjIrckNwd1lZcXdQNHNHMWNCSHRRTzRzS1ZzTFlk?=
 =?utf-8?B?N1RxcjhRTjlJSWdnc1VBN3ZXWitSdWxuTXBMT3piT1gySnMwZXlmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b1041b-2697-40ac-cc3e-08de4e02fcc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:39:47.2900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs9vW6kDhj1A/Scyg6lcpFrB48m8INltIL15D5qqjoT3WGhQpsCo9ed1E7SKekd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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



On 12/29/25 10:19, Jesse.Zhang wrote:
> In certain error scenarios (e.g., malformed commands), a fence may never become signaled, causing the kernel to hang indefinitely when waiting with MAX_SCHEDULE_TIMEOUT.
> To prevent such hangs and ensure system responsiveness, replace the indefinite timeout with a reasonable 2-second limit.
> 
> This ensures that even if a fence never signals, the wait will time out and appropriate error handling can take place,
> rather than stalling the driver indefinitely.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 98110f543307..c28332f98aad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -371,7 +371,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>  	int ret = 0;
>  
>  	if (f && !dma_fence_is_signaled(f)) {
> -		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
> +		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(2000));

That is clearly a no-go.

That we hang infidelity and never return is a must have behavior or otherwise we might run into data-corruption.

Regards,
Christian.

>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);

