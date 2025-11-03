Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4D6CCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 03:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA4D10E0C3;
	Mon,  3 Nov 2025 03:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tG6x7Lvi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144CC10E0C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 03:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayQrBbKj9nffNOAteojwEqiTs9XVvKwXGQwJolN74/Rw5IJG31dnhu0faXkvH63K8xnhJa5nGWCiS9lvJolAXWjPzAn346EiCa/d1ITUvGPoxCVO6NNtUwqL6eDbYw7Wq4WM36PZdd+Jr+l3Ga5BEFkdQYjdo1+sjazYznR4pPnD7LclE0CblQn+VD2XlS9JGtq1rmIerHdMyErV4UNwYlnR0sF1N1sUmBP0a7YS7SsTrht9nCpB3CohlfFXgqTXsBJiFYQtf5yLNZpfz886abggUeJGL3nVCQUbwX0nZPoPz4or1TdJhqye9TNjreuLIG8m85GtqwzUe3Qjg9V67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2AA1kIMyXH3/eOzzi7kGJU4zs8cty57o5mUtArIwNg=;
 b=Il+VN/FKDmwnuTg/WtMqjfvwyVLoMwGbinTwS1OWTC+38QyXnq0jBpz/cbzOeMxlYLhU8oodZNxCuFwzH9phtmIfjNAqEMY1tYVKARfcT6X5GOP1DmBXViejVVg6wl8QpDXuV5ogD12LeedfZFBDOFl6283rq5rfV2QA9JTiBnrY46Dw9IcahZprR2iNCGRufrpnU74kyNgzIrfHac9VdSKiWrwXzR3u2i8qbtIJOu3CmLdFleJB8uSxqOM0CD4dW3pvyFpJHOvMuzSZxtRqQhyxafx6/Q5RFL1R5Rq04r1irxJgYgPunVz3oMJNomXajVsyyhwf8J3S1aW3yM+fuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2AA1kIMyXH3/eOzzi7kGJU4zs8cty57o5mUtArIwNg=;
 b=tG6x7LvifPZoQj9uVoxpmvZJQf5fmrsfUx3IlzxZUxQ+L+IMXElItc9J78P+mYNKcjLZ1rqn8meJi2G36c0lENUbjcxjWO5ynKhM48Lra01rh+gaaczfWuEQWOe4o4Y/M7ozszdj9PQG+GV97OPJwsHS4/UIggpo7QmtF4mQe44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 03:04:07 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 03:04:07 +0000
Content-Type: multipart/alternative;
 boundary="------------O0ggdcAd0P4CRLV6UY7P97kR"
Message-ID: <e79e2606-7876-49c5-86bf-db1d43d32020@amd.com>
Date: Mon, 3 Nov 2025 11:04:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: remove pasid under kfd sysfs folders
To: "Kuehling, Felix" <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251031033228.2230-1-lingshan.zhu@amd.com>
 <c227267c-9daa-4587-834e-b44747d1331f@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <c227267c-9daa-4587-834e-b44747d1331f@amd.com>
X-ClientProxiedBy: TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::17) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DS7PR12MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: a2abb120-e75d-4e56-a0a0-08de1a85a6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmE0UGgyejJlRmRTTTZxMEFMVGpWNVpBTlRNNVZLNTdrRHV6eUtBbnZKZVdM?=
 =?utf-8?B?dTAxV3diRVRLOTBkWS9DL2tqckJ3RHYzcUxJVVc3cENZZVluSkVyQWM4bmRX?=
 =?utf-8?B?RGNXNDBnZ094K0Q2Ujk1Tzgrek5BN20wMEc1SVU5cHdCTnVzMHFVTUdMRXox?=
 =?utf-8?B?TFc0R1lScEpnQmIrbW1WMGF4cWU5QjM2RSs5Z2FkZWlRMjdxeE1iZjVnMFpp?=
 =?utf-8?B?RHlVb0kxeUJ6K0oyTStRS0JsaEVMaGxveXdxeWdYcHRrY1U1SFNlUWdNSmNj?=
 =?utf-8?B?MUVYU2VYbkM2elREb1A5ZitLMFdnbnlNeldCSzV6OHdvN25teUp3dUFTbjJ5?=
 =?utf-8?B?eG5hRWZLZkU2dHFPekxIMXdnRHdiSis0S0RuODNKWkM4UUszWnZGYlhUTEZS?=
 =?utf-8?B?Mk5oWFNJQkxHVkgwMWtRTlVrZm9rUG1yMVpPN0V3STVRK3F5dDZ6bExrSWhV?=
 =?utf-8?B?TXhiVm93bFA4ZzltenZreUxBODZzZ3RRV2lMVFFyT2JsZzFqOUg3S043d1Va?=
 =?utf-8?B?ZllUcEw1RjBEL3RIVzJiQ1ZteXhZNlkxd0FocWlGQnJ5VlltNUZiSm9NM3R6?=
 =?utf-8?B?eWtiQ1RXeVlnUERaMXNuaWw5cnlSM3RZeEFXZVZVYmFmbEwvaU9waVg2c0FC?=
 =?utf-8?B?ZG51YmowYTQ4UnhCOWVkRDVQc0xnQnN1SFlwQ0QrMStuVXA4THYyZ2xveGlL?=
 =?utf-8?B?bHdPYi9JY28vbGsvZGpWd1BOcEcxdUhRcUlMbHNleEFxOHViVUtHN0FyTDZ2?=
 =?utf-8?B?d1gycENIZERPV2sxajlRdzlHTSt6VTdjdmJhbG9PTzVmQm9SQUlLRllEeUEw?=
 =?utf-8?B?WEJTTEhmd3F3aVJ6YUtCZXQ3Y3RMcHpEaWdFUUt2N0ZPMVFjNkNraW45eStV?=
 =?utf-8?B?WE5VSWhGU1NXbVY0akhBU1JBWFRlaUx6Zi9SRXVmajdtZjlhM1FBNXd4MUdR?=
 =?utf-8?B?SUM4UVMxZUdoWWwwQVMxMG5YTXBIYU1TMHhhSm5uQ2RMUXZ2MHZyZmMrbldL?=
 =?utf-8?B?MVRXUjkvdXVST2hwMEM5bXpQNm9GcGtSbS9RamtsSmJHZnhCaEhmb085S3or?=
 =?utf-8?B?WUtoZWFNWGFuZkttMTZQRU1HWFFOQ3pnMUNlYkVuOVQrc0RGVUR3V0I4WFZ3?=
 =?utf-8?B?dWlGdkRxOEZBU0k2K2QyQlFMaTFSUGR3TU00cjBERWg2Tld2eUFscVpybVlI?=
 =?utf-8?B?NDYrQTNXWUZ1S3JMTXAxd3l3SVZaNEVWRXFIRzEwUFNXdy9pRForQ3d3bDlC?=
 =?utf-8?B?N1dRTDB5ekJTRk02V1lJOGpJK2c0OEtRckhwTER1MnNtMnBxbjVsVE9tNWNE?=
 =?utf-8?B?em0welNBQ3RRb3EyUlZneGdwbG44VW9Ud2ppN2JUTlpoSUVRQWFpc3JGZkhU?=
 =?utf-8?B?empRUFc3TXFrQkQ0ZndrZG5QMlYzeXppR29ENnRXdU11ZXBrTlZUWEhpS2xJ?=
 =?utf-8?B?L05QVVhwYUQwakw5a2p0UXZNVXNUYThHRGVtTkY1TCtzWStLL2UvSmFCclg3?=
 =?utf-8?B?NnBtamxEMU9aSzdNNjNzcUM0Zll6S2JCRldlOXpIYUFVV1JKOTUxYW9JZzFh?=
 =?utf-8?B?a3RQcmZ1b2xTWnZLYmFlSWFpT2p6S0RXa1BIVDNQUytJM1hLSDZGUW45Ykhn?=
 =?utf-8?B?N1ZXKytLVXhkcDQrTFRQVFZDOS9YMzlhWi9zVExuQXQ1SDNDMUVwRDJBd2U2?=
 =?utf-8?B?d0tPZ1oybVJLNDlSRzNQYVhQTE9IVGZiTnBpaEpnNXlnVmg2TFYzaEowWS83?=
 =?utf-8?B?aEd4cjVWMHFvQTYwSUZibGdjUzJ0dkc5Q3loMElnOWkzbytsNEZlSXN3OXNa?=
 =?utf-8?B?MFp6Ni9SMjVLN1J6QXRzQmQzTVI3QW13SVJ2ZU9jTVpXTitLTE5hb1JXOVhD?=
 =?utf-8?B?dmdJS0E0bFdkRC9NNm1tTGJtSHJvYjVkd1FlVktESTFTcUd1SDNPUjNxOVBH?=
 =?utf-8?Q?0KaKQhOKe4IE1jhb5Uht1icWurQxN/cO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZ2MFkxOC8xajA5OE5BK25CZC84akVKd29DeUtnbnNCTDNYMXVKR1FMUE5S?=
 =?utf-8?B?YUphVzg5VEhuanVhL0VuT1hKUWwzMEVQb0dSSW5Da25CUzl5ZWpuaE5abFRn?=
 =?utf-8?B?Q2ZuWjg0M0N4Q0laSHVIVGlpd1BaeG5WeHdqYml1VU1UL0JESUExSG14TndJ?=
 =?utf-8?B?R0hiVFpSSGlVZlJ0dFJwNTZNSWpWRmQrNkZ2QWZiSWN6blprWDZka2kwdEpX?=
 =?utf-8?B?WW44VDlTUCt6dUpGVFdNTmRUOUNlS0o4YTdtazY0KzdyTE5zYUdrZ1c0bm5W?=
 =?utf-8?B?RWhMWFRHcDFPdnJ3OXk2SDYrUDVkaGVCTllyeCtIcTFqbllqRzdOT04xZlpG?=
 =?utf-8?B?Nld3SWdVTzVEeVA0NVNHU21pNjFSSnJlYkpBTGhRVDZNVHRPN0RscWdYWG5H?=
 =?utf-8?B?dXUxOUhBRWNaZG9pMElvR3ZlWHZsUHJGYjhFMkRrQXFzcHR0WjJ3aHI1WEZ5?=
 =?utf-8?B?S09JaXlVSHVOZVRQcEZ0Tm9BbXpJQXUxNUxWcGVLYzhjMVdqSi92aUZUMitN?=
 =?utf-8?B?QndNQk1SUHJqMHZFWUpNM0YyWUpualNrN1QvNGJoYkpCVitmM2xVODN4WkFM?=
 =?utf-8?B?Y1FvSUVXS2ZZSWFxZXFiK2lDWGtnUTNGdVp0cEl2b29UancyTTlCeG91YkVJ?=
 =?utf-8?B?M0JnREExVVFWZkd2YWRBSDRzcjZBWEtsVGVSc1FCMGZsdEozbFAzWlczZEpX?=
 =?utf-8?B?eHV5SERhNm03WVhrK1R2cGo2MnNabmthTVNkemdtdnlIUVVMWXVqOE4zUmRn?=
 =?utf-8?B?dDE3N3R4d2NZZFdSR2J4NUdsZTlWbU0vWlRnNk9CVG9SWWpaVkJXQ2pUVElH?=
 =?utf-8?B?UCtWNVROczZpNmdZK2RER2hLbWFwYnhEdkVlQ2VTZWlwTWsxNytiSFppNC96?=
 =?utf-8?B?SDJ2MXdmalM2d0JJdWt1NUVMRGNxMTNmNExQVnpFamhQdHdMOUxoS3d3eklz?=
 =?utf-8?B?bXYrYXhhTGZpSzlGbVgvUjUvRFVQSUdWOXNBaHpXSzJVcjRzdzRtNHJrTFY2?=
 =?utf-8?B?VDlTMHdwU1dnOFg3bml2eW1CK1gyT2J1a2VzZGJlK2hhTkswdFlpZGc3eVJU?=
 =?utf-8?B?OVJldGgyNjBlMHZtdFNtdW42VDZZclkwdVM5ZFE2NUxYN2dYdDR2VXVKczB1?=
 =?utf-8?B?RWwvVU5pNmh6dU5YMzdlYTJxNWhVU0hsTWpxS1p6T0dTV1hNaTdHWkNtblhm?=
 =?utf-8?B?TVB0elYzaTNHVVpub1JrU2g3T2gzaUUyRm9uVG1qdkRZU00ydWRodit2TTBX?=
 =?utf-8?B?WUZPLzdMMjNxYjNrT05Pei8vS2R4aHkwbXJaS0R0S25RUnZ6Z2czaExTdkgr?=
 =?utf-8?B?bEFjNWdpblc4a2w2Yzdkd29QYWNSTjZyaWpoQXRvbjBqQWFzZCtxb0JMVFNB?=
 =?utf-8?B?bjQ3eEpEcW53SW0yaks1WFIxRTRDbHVYNEZoUisxaWxMTFV0NDRtdWpwTW1D?=
 =?utf-8?B?QnljUHJCMnFhZDIrL2tTWms1TkFOSUMwc3lhMFM2R3YzNXVDZi9CTkNxMXZq?=
 =?utf-8?B?TlkrdTNNZklxL0tnMHVaNEYyU0JXNzFQZUJlaEQra3FUN2QvZlgyRE1oSjdh?=
 =?utf-8?B?bDRaYWI2RWdJbzdiS1V6SU5LdTREdTdsNkxmc1NCOEl1aFlBTXdISzFUc3dR?=
 =?utf-8?B?YXR2ZHliWmYzTFYwYVk4SkRoU2dma1dMUVluNmxValluTmZtNDZxWlEyNDZF?=
 =?utf-8?B?bXoxRjhiV01udXpncUlLclFhS1B4bzFkNi85ZGNBNEcxdmR6bTdMUWQvZUx0?=
 =?utf-8?B?NHppeHlhRnROVC9aS1g2c2xvSmE1M3dBWW5maWxiNjBmcGpqWnFKODllbURR?=
 =?utf-8?B?VE9Nc3lLa0RVcXFPYytGRGwyMjJFMzNhOEo4UzFTeVduUFFkK1BycDNKQ3lO?=
 =?utf-8?B?QWwzVldNbVd2a3Z4U2ErZkRjdmlPcDI1Mi9QNEF3YXAvNndFRFlnWHZyTjh3?=
 =?utf-8?B?SnhWT3M3WGZyVnB4Ni96MGZTb2F5S1VGaXViWXVtUHdZVGVzdnIzUUZGS3lj?=
 =?utf-8?B?Q0w5THZWbEdwajBkOWN6bXJoR2svWTZmelUyaVdwZDErYlVPenYveU5pUVFX?=
 =?utf-8?B?aFhZZHV2WVlEVzVvZmRWZGJrV0R4dDRnVm5PZ0ZBSE55OFd0YlhZcmVENkVw?=
 =?utf-8?Q?v0Hx3Em1u5qYM0mri/KYWR0Yv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2abb120-e75d-4e56-a0a0-08de1a85a6f2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:04:06.9522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6exWMDSO4S5EJT9/dH1aEdq5jdNdugrO+M3pYs8TEGkgRP+Qg0dseh3IMrEk74IsWkCx4Vt4bWiaaeKxsoGtKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9501
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

--------------O0ggdcAd0P4CRLV6UY7P97kR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/1/2025 4:56 AM, Kuehling, Felix wrote:

> On 2025-10-30 23:32, Zhu Lingshan wrote:
>> This commit removes pasid under kfd sysfs folders
>> because pasid should only be used in kernel internally,
>> should not be exposed to user space, and current
>> pasid under kfd sysfs is buggy hard-coded 0.
>
> NAK. We left this file with a dummy value deliberately, to prevent
> breaking existing ROCm SMI versions. We can never remove this as long
> as such versions of ROCm SMI may be in circulation.

I am not sure 0 is a good dummy value, because 0 is meaningful, usually stands for "the first one" or "success".
ROCm SMI may treat pasid == 0 as a dummy, but there can be other user space tools, even non-opensource customer tools
may see this 0 as the first pasid.

pasid ==0 is misleading here, so I suggest we show pasid == -1 which is opposite to the concept of pasid.

Thanks
Lingshan 

>  
>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 7 -------
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +-------
>>   2 files changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 70ef051511bb..d69079cab1e6 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -983,7 +983,6 @@ struct kfd_process {
>>       /* Kobj for our procfs */
>>       struct kobject *kobj;
>>       struct kobject *kobj_queues;
>> -    struct attribute attr_pasid;
>>         /* Keep track cwsr init */
>>       bool has_cwsr;
>> @@ -1100,12 +1099,6 @@ void
>> kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>                       int handle);
>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>   -/* PASIDs */
>> -int kfd_pasid_init(void);
>> -void kfd_pasid_exit(void);
>> -u32 kfd_pasid_alloc(void);
>> -void kfd_pasid_free(u32 pasid);
>> -
>>   /* Doorbells */
>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ddfe30c13e9d..f45780502f06 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -328,9 +328,7 @@ static int kfd_get_cu_occupancy(struct attribute
>> *attr, char *buffer)
>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct
>> attribute *attr,
>>                      char *buffer)
>>   {
>> -    if (strcmp(attr->name, "pasid") == 0)
>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>> +    if (strncmp(attr->name, "vram_", 5) == 0) {
>>           struct kfd_process_device *pdd = container_of(attr, struct
>> kfd_process_device,
>>                                     attr_vram);
>>           return snprintf(buffer, PAGE_SIZE, "%llu\n",
>> atomic64_read(&pdd->vram_usage));
>> @@ -888,9 +886,6 @@ struct kfd_process *kfd_create_process(struct
>> task_struct *thread)
>>               goto out;
>>           }
>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>> -                      "pasid");
>> -
>>           process->kobj_queues = kobject_create_and_add("queues",
>>                               process->kobj);
>>           if (!process->kobj_queues)
>> @@ -1104,7 +1099,6 @@ static void kfd_process_remove_sysfs(struct
>> kfd_process *p)
>>       if (!p->kobj)
>>           return;
>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>       kobject_del(p->kobj_queues);
>>       kobject_put(p->kobj_queues);
>>       p->kobj_queues = NULL;
--------------O0ggdcAd0P4CRLV6UY7P97kR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 11/1/2025 4:56 AM, Kuehling, Felix wrote:</pre>
    <blockquote type="cite" cite="mid:c227267c-9daa-4587-834e-b44747d1331f@amd.com">On
      2025-10-30 23:32, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit removes pasid under kfd sysfs
        folders
        <br>
        because pasid should only be used in kernel internally,
        <br>
        should not be exposed to user space, and current
        <br>
        pasid under kfd sysfs is buggy hard-coded 0.
        <br>
      </blockquote>
      <br>
      NAK. We left this file with a dummy value deliberately, to prevent
      breaking existing ROCm SMI versions. We can never remove this as
      long as such versions of ROCm SMI may be in circulation.</blockquote>
    <pre>I am not sure 0 is a good dummy value, because 0 is meaningful, usually stands for &quot;the first one&quot; or &quot;success&quot;.
ROCm SMI may treat pasid == 0 as a dummy, but there can be other user space tools, even non-opensource customer tools
may see this 0 as the first pasid.

pasid ==0 is misleading here, so I suggest we show pasid == -1 which is opposite to the concept of pasid.

Thanks
Lingshan </pre>
    <blockquote type="cite" cite="mid:c227267c-9daa-4587-834e-b44747d1331f@amd.com">&nbsp;<br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; | 7 -------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +-------
        <br>
        &nbsp; 2 files changed, 1 insertion(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 70ef051511bb..d69079cab1e6 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -983,7 +983,6 @@ struct kfd_process {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Kobj for our procfs */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queues;
        <br>
        -&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keep track cwsr init */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_cwsr;
        <br>
        @@ -1100,12 +1099,6 @@ void
        kfd_process_device_remove_obj_handle(struct kfd_process_device
        *pdd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int handle);
        <br>
        &nbsp; struct kfd_process *kfd_lookup_process_by_pid(struct pid
        *pid);
        <br>
        &nbsp; -/* PASIDs */
        <br>
        -int kfd_pasid_init(void);
        <br>
        -void kfd_pasid_exit(void);
        <br>
        -u32 kfd_pasid_alloc(void);
        <br>
        -void kfd_pasid_free(u32 pasid);
        <br>
        -
        <br>
        &nbsp; /* Doorbells */
        <br>
        &nbsp; size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
        <br>
        &nbsp; int kfd_doorbell_init(struct kfd_dev *kfd);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index ddfe30c13e9d..f45780502f06 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -328,9 +328,7 @@ static int kfd_get_cu_occupancy(struct
        attribute *attr, char *buffer)
        <br>
        &nbsp; static ssize_t kfd_procfs_show(struct kobject *kobj, struct
        attribute *attr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buffer)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; if (strcmp(attr-&gt;name, &quot;pasid&quot;) == 0)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%d\n&quot;, 0);
        <br>
        -&nbsp;&nbsp;&nbsp; else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
        struct kfd_process_device,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
        atomic64_read(&amp;pdd-&gt;vram_usage));
        <br>
        @@ -888,9 +886,6 @@ struct kfd_process
        *kfd_create_process(struct task_struct *thread)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(process-&gt;kobj,
        &amp;process-&gt;attr_pasid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pasid&quot;);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj_queues =
        kobject_create_and_add(&quot;queues&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process-&gt;kobj_queues)
        <br>
        @@ -1104,7 +1099,6 @@ static void
        kfd_process_remove_sysfs(struct kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;kobj)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;p-&gt;attr_pasid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_del(p-&gt;kobj_queues);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(p-&gt;kobj_queues);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;kobj_queues = NULL;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------O0ggdcAd0P4CRLV6UY7P97kR--
