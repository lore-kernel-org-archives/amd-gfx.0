Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DD5C27C44
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C59113B77;
	Wed, 29 May 2024 13:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BuCLoPlV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED910113B76
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 13:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Koi3bu7gOXpdHSThjmYjsArWI6QKokQmensxK+33R1/Fkdnme8gVM/DBKLuX63aFI/9f+UHgYS427LC1LYOH24qyp0D0ejRxnQGJm8g5AWnTzWFfbTvXfzjfUgM2iyQUK4W+Wj4y9lRNuh8iFtlNitkAu/qrpf02h+KpU7N1mnONoC/n+03NWNRJI7GF6+YdWGI6w7dr7yRNy9xQJZCn/WNTyh0LtvpDoqRynmtkyrIth5x2Cu6OTBNd38rppgDME+o1kbJRUDe9o1y38NirTiSS+t7POyaNpAXBOqdlV+jP11689ut0adyjcY6QmApMtXY4IIdfnCs1zDHbmjsKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbssr9Z7KWnLF16aA2FDW/dWGmRCZH4aYCA4/CXdjW4=;
 b=BglkicYMNizkyfXoBItQF5LBufg+dJcqy2gsIhSd+17OBxNwU5b6lZ5uI8xwnmnWj+EC/QVe1eVywMgh8UCi8qj08Ptsjf2CaP7Z5sztGW1GCwplZSur9DXRMuBZrlTzzH0CmW0FkNXQmVHVxxlioAcmtG8a6QjhwDrjBB84vOdXPyZsxziMmMaIS4rkhhOjQNl8JOIJPiQwZRdI9sLZb1NbRPXRacu6klF8+40stE+T4+HtNx6eZ4aqJ7+W8BMUDdWSRI78cMwa/QVaM9JeVpkCIXOhEb6NSPSriatadUhYSs7wb2mkzJKjIXehPmRpudYjbtTwafeluJ8ezKgf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbssr9Z7KWnLF16aA2FDW/dWGmRCZH4aYCA4/CXdjW4=;
 b=BuCLoPlVU3+ItbpW/rfWkyGhZrx9BlQvdGlWT6lhfTvaXolANEtZJUFouvk6ixNDePGA8R1pevvkkkIke4EwY2TwSxP/xzX38FQipfLv6A9LCP+wr8QHC1Ly4KKLe6+Hg8rnl5Z8rRxYw2cVmI217fM0IqGKet+X87G+bxtpJA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 29 May
 2024 13:56:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 13:56:04 +0000
Message-ID: <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
Date: Wed, 29 May 2024 15:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 014d0f96-814d-46b2-17bb-08dc7fe71472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHZnNG9Oc1RKS09EbEZzMmdpMWRnTXFOdktYbTBoQU1mbGM5NTJEeGUwTlht?=
 =?utf-8?B?VXkya0ZKdWpWMTVUZmZjR2Y5Y2xlRjVpd0lldlRhamhZQ1VCVmMvZWZvNlVx?=
 =?utf-8?B?V3cvRkh2T01kRkJmNU1XV3pBVlMrb2F1TW5obVZyT0ZOR3JSdEVONkVtMTVm?=
 =?utf-8?B?dHZTWkVpL1g5SFk1cXBtNTlvNFUxYi8rN0NZaXVhS1dibDNtZmxkK3NhbW5a?=
 =?utf-8?B?Ly8yaXoyc0VLc0JUNjZUVlh3YkQ2aE1WYzBnSlJMNUZnbDZZR3dhWG1rb3hM?=
 =?utf-8?B?UzNqUVA4aVhhcVJWWFZUQWZsalZyWkNjRHdydG9DRjl6Q0l1Q3VXalg5WE0w?=
 =?utf-8?B?KzZQcDloTmNmeDBHeVIyTXZHd3BPWm80dUUrdEw0aXdwaklzQklYVkhPaGVi?=
 =?utf-8?B?cXJWZGRZc29WdkJCbmhJWXVrbWxvL1N4OWdzeUZvdWpMQ3Z3RmpJcVF4S2Yy?=
 =?utf-8?B?emRlcmtjYWQ5WkdvQjVUK0c3Wno4ZFBlRXhkbjNMTUhlVnMwS2Y5akVRNVdG?=
 =?utf-8?B?MHFTcmRmZVlUREs2RGxUMEFiR1craTkza1NiVy9OQ1lpMDJ0YW1FT2IxWHUr?=
 =?utf-8?B?eU8zbm5BL2EyRHJhQmU2Ukk3UW9pSXY0dWEwL0llamtkVGNuNldheHpJdlV5?=
 =?utf-8?B?djZJaXo3Y2RWWW93RS9GZCs2MkNWaGVIOTdRZVRTZWpvdW81YzI3U01yNnpM?=
 =?utf-8?B?SXplaEd4Q0szbnZUb1o3eEdNb0JKa3pKbHEwWmt2OWYwemgxUnd1UnZ5M1I2?=
 =?utf-8?B?eEZWS0pTdEtZMGNvVXNWNUJkVS9OdW1pajd0QnJqN3BrOWY0TTYwUWhGVXpG?=
 =?utf-8?B?dWc1c1htd2d5SmQ4NWhvV2F6cmhseWxISHFMb2E0dER3K0d4MFNyb0c0VmVw?=
 =?utf-8?B?OXI1VVRZZk02dG5uSWQ4RXdvbDZyWDIxeTVrZlBDNTB2ZEhhSHA3ekhzL3U3?=
 =?utf-8?B?Mk1MUkxOaDZvTEdpT3hER3RNOUV0dTA3WTEyRXJlQnFyRGlCY3N0TEREdGxq?=
 =?utf-8?B?cFBDenBsMFJoRjFJRnp6cndocndpWUJYRzY5bXNpVDRxUEt6QVZCNzZSa2dv?=
 =?utf-8?B?akk0SUdWSGpDaGZLWEViRHI1Yi9SZVJURDl4MzNqSlU4emxDWHA3NVhidXVW?=
 =?utf-8?B?b0s5Q2o1ZnprV2FvS2ZMSXRkc0dXbGVkek5Ib25wNjdUV0RqVEl3dWpSb1pY?=
 =?utf-8?B?WkxET1hURDA4K3ZjQVg2QW9EZmFGWXBRSms3c3NMa3BDN0dwempBTVVmeTFR?=
 =?utf-8?B?WTJDTCtQUndJVVVtd2JFYlYvNnVISWNXbTl0dVQ3UTdUWVVleEtrcXU5cUk1?=
 =?utf-8?B?dEVRWG5oQ0dUVk9Pb0pTUGtvdWUzRDZGLzNCUGtEL1RLMWRnMnhmK1Z1OEdY?=
 =?utf-8?B?dGtQZ3dEbkR4bzI1SUNrc2JOR0ZJVkg1Yy9zbExURnE2aGpUaERQR2MyS21x?=
 =?utf-8?B?S0l4T0llRHVyN3dNRG5iNnR6SmtTNk5LTVovNGdjUE9SenpJM3ZYN1JGa2pj?=
 =?utf-8?B?bE80ZnhDRXlIUjB4UVl6QXVZV1RIenNNZUNtYWt2VFFNa05EMWJ0ZElRR0lJ?=
 =?utf-8?B?RmlDdURIM3pac0s1M0x4eGJJTW9qc0lEV2pzTU1lZjBGcVBodHpUT0U4ZURX?=
 =?utf-8?B?TlpLWXdMd0w2cEQ1Q1ZUZFd4dU16WE5saktSUkxVUHZwZk5xdzl2SzV4Uk9n?=
 =?utf-8?B?TjRCaVRQZHl4ZDFlRW96VHNwWXJ3TFZwaVY4alRhdkRyZmo1L3RJNWx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5SVjFra1dlYVFwbVJXV1pYcjlQNVBFZy9aWktmN3RWSFhEZlFrSUtLbjlr?=
 =?utf-8?B?Q3k5R25GbTZvRE9wN013RFJpWkQ0eUF0QXlKRnhYSjlRRUxQRkZZbStTWnNV?=
 =?utf-8?B?OE4wcWQ1eHRuamNSQ3I2T3gyRVY3cGxZdi9kb2V6akxPZHdKRWxSeE94Nnhz?=
 =?utf-8?B?cXdlKzNRdzI0VFg0WHdVSHMwdmsyU2NhU3lycGw5bmJ2ZGdLU014azhPRGtE?=
 =?utf-8?B?dG9Yek53TlhueWRWWWFnVWhHSzRpOXRuME10eDEwZVBtVlpYbXJMNXZtUnBZ?=
 =?utf-8?B?VUdQRXBkZk5EOUY5M3BjT2I3b0JCTHNwSmxhNnZKU0kvSkY2RTNMeHY3OHd1?=
 =?utf-8?B?clNicmhJdHhIWmkvSW80bmZsYklIeWQvclNaUDlCOG42dTdtMlNmc1FHVThB?=
 =?utf-8?B?WEJlemFvV05USDQ0NEVwU29ESDQ3L291MjVMRU9aK1BuTDlTblBhZ1h2WFow?=
 =?utf-8?B?UjM4T1FWKzdhSzdvc0RMdm9MZEoyUXhKdVdkamk4VUJEc1hqRlllRXFuRGtm?=
 =?utf-8?B?YmJJZ0Z4eWd1V1lPbFhZZ21hZFNyWkNNOEhhYURBazAxSHNJQWhLZU8rdXpp?=
 =?utf-8?B?RnZKMWdzeVlFcGUzSFkxYmt0OHoyNGZ2bFdOejBtNEFXdGwyckVnODhSWnJG?=
 =?utf-8?B?WUwxUThtMFIrOTFHQjVraFcydFFJSVpGS2hEZG9MVDFlZWpJbVNyRGdDSVlz?=
 =?utf-8?B?NkJXOUhXSUhyb2FwaGRBamc1SE1tV240dS9WZ1BhM0JJSjkyOEVlUnBSTzhr?=
 =?utf-8?B?bnBxbSs4V2NXUGtmVzc1Qi9RaTZCNnc0eE0rWm4xaEppZ3pJaktsUVEvRGhh?=
 =?utf-8?B?TU9aU1VvUm1MejNCN05kc2ZsUlh4Rm9zV2hUeTVPTndRSm1SVVZGNGdxbWFN?=
 =?utf-8?B?L3FUZm1jVFNKdW45eWlzUTN3M04xZHZFWmhqeUs0dVZIL2ZNRVRrUy9CN2Iy?=
 =?utf-8?B?empKTDRaRGt2cnR3UlFiOXpNSkJvamFwR1AzWFlvVjhiSTJsNnF0enh3TGs0?=
 =?utf-8?B?YUlTNituZy8vbEFoVW82Q0xRcUZvajY4R2dtYnpBV2IrTnVSUnNhakZzakh2?=
 =?utf-8?B?ZmdoTVB6SzNmMFBKU3MzYTV5dFpmajBkTURxOEFzcWtSZ3NEdXRzQ1pjOURY?=
 =?utf-8?B?c2tzQzY2RFVQQWR4Z0xERzUwMjNwU1hwQVdwOTZVK3NHNktObCtJbEVaV0cx?=
 =?utf-8?B?SUdYMG1SeEhjYkdsUzAvTlAzQ0ZnQ3BDWmlvVHQ2bUJZVlA4MkpaK24yZWVn?=
 =?utf-8?B?V1B2cVRHUlkyVFFIenAvMWwzUjdKYnI5ZDA5K1lOcDQycDk2U0E3bWZBNzh4?=
 =?utf-8?B?NVE5RHVDVFZuU3pDQ2RLbjhqOXdQYzZGalQxdmpXQkxiMlJlTUp0MGczbHV2?=
 =?utf-8?B?cjJaU2Vnb3c5ekkyNmpSVmhMY2RWenp6S2NFUlpDaGNBUE5BYWU3Z25TNFlL?=
 =?utf-8?B?Zzd2Ri9RbFg4N1QwQkREdVFzSktPeHVRcEYzWUtnMm90MXRCS2tXZEpyVE9N?=
 =?utf-8?B?cnB4ZTBSNDh0VTlmc2hmRFNKWmNiNEF5ZWdhRkpkTkRSeTlNR1hTSDNTKzBN?=
 =?utf-8?B?d1ErUEc2SGxJRXVUV3Y1RDJkNEE0TDJSV042RStxbis0VUFlbEk1ai9odlgx?=
 =?utf-8?B?dkRpSnM2cllDUGRmYVFJYmpyQ2o4WEwzSXNoZ2V2NHd4ZTlRMkpNWEdZd2pa?=
 =?utf-8?B?R1YzZHNKb3BUQVRZTklsZHBZOVl1SmNlaWJiaGwzd1kxcWtPTm13OTk3N3hE?=
 =?utf-8?B?T0pTZVhTczduRTBub00rVCtEWVJHUWszK1M3Lzg3cC9QbHZhbVZYWlZkWnZE?=
 =?utf-8?B?UHI2NmlVbVIvYWVKa0hoZkVQT3VzMndpdEdoWFhOWlY0cCtlTWZtQlZBUkJn?=
 =?utf-8?B?am96UVhxc3FDU2w1a0ZSWkZKOXkvSFdlWDk2Qy9TZ2FTeUd6cUtoK2U4VVZq?=
 =?utf-8?B?Mnhrd1dEYlFzWjdVb21ZWTkwNG8zNXVVN2VRTWtpbnJobXNWSmpXNHUvT2Vk?=
 =?utf-8?B?ZUR2dFhSZXg5dWxacGd6VHdmaVVGNko0ZjJ5Yk5aazJkU2hZSzhsY2NwTFpl?=
 =?utf-8?B?SjRPdnFCZFcrVThlTGhKRVdpODQ1T2s5SE9XTGJRcE80a0wrQ0loWS9jRDQ0?=
 =?utf-8?Q?WXdvgY+IH75GqLUDORWJcOIcn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014d0f96-814d-46b2-17bb-08dc7fe71472
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:56:03.9481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImHCqgVES8Il1vGEUDRFlGfhDAc2wEIj67agxjv2wH65YNgnbTWIwfXUQnidB1fH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Am 29.05.24 um 15:44 schrieb Li, Yunxiang (Teddy):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> I don't think trying to add some reset handling here makes sense in the first place.
>> Part of the reset/recovery procedure is to signal all fence and that includes the one we are waiting for here.
>> So this wait should return immediately in a reset anyway.
> As far as I can tell, these fence_ptr s that get polled are not packaged into a fence obj, and in practice I see 10s of seconds wait before these timeout and reset can begin. Also after reset there is often a long wait, up to 2 minutes, for all the tlb_fence_work to timeout (not addressed by this patch, still haven't figure out what's going on there)

The problem is that we don't force complete the non scheduler rings, 
e.g. MES, KIQ etc...

Try to remove this check here from the loop in 
amdgpu_device_pre_asic_reset():

                 if (!amdgpu_ring_sched_ready(ring))
                         continue;

Regards,
Christian.


>
> Teddy

