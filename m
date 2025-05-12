Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97432C3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 07:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9E910E2E5;
	Mon, 12 May 2025 07:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TmscWWNk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4250F10E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwFqu6EtOG5rga+7Z2MLE4eIpHoE6E8GoXW6w724leoRXc7Q1U7iCL0IfQ51+ABHMXGgTWyzSD7Q72KXE/QFhyB/+sGDblpVdu3CqgGrrDcFkPPdC5mVJDKz/oi0JF620F5P2io6eNj0T+BrlLwRH9pR2dLuVY4KpS0mAJcM0WeJaH9ao/HXF/rUYa2aKfRTPMmvqCQQjDObtyCLF+0gPj1Mo+VHwz0KQ4SZGmg/aJhRN3iJTblkMiG7wth9x1c5xXMsj8Izlpi0iE7kL8TJG4G6kjRcN84as9/7ATrgiRHTZfmoL2fy0BvuW/O1W9QHHEAVz3FQSCDQG7TWdrBAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41elf2wdWlRKusRxjyUE6kB+XoOXgesYE87keQ/FMc0=;
 b=lSHAB9D/54jRJvoIxIPfsmIzmorwmrcBYIbEK5O55U8R3x3qPkd9Rn5avcfHWUUAqbZgLjSNWRfRa2JyOSKSIqxqmmnTkXNp1sC0HhwrUBA+YsX6Pn5c0EV8I2Wn5ZI3QHEdSGxHPFCWiN3HQXyDUsE5MMeV9HqLo4D9hZrt+8WkQ3Lxy/6/3BkSu6O+0O4m+rBaukDi7TFmaQuW66wXhnWSy6YMKy9/Hm8XAt7NM3cExhIr1m4S7AaZVBg+bSij3ZtJCTUXDgLyj0jcgUHqicOkMnyDcsJ8MNjeoPfrMKi01y1jBuEMkWKBdIgiTzz1iaXq2XHOaKpzd1kR2N7WJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41elf2wdWlRKusRxjyUE6kB+XoOXgesYE87keQ/FMc0=;
 b=TmscWWNkJtLmBWDqqBVkEmYP6NcJxWmxwMuDcqTT45qfmcrHzxPR+fLzjXoCLO4cFWyQmi4ZR0hgk0VE/WAfD2EIe1/AuNu9kfrnq/MPPJ9KZNahGhL6hTNpilkyFNEJTP5ljmM5PGyHWaLv27EDV9Nrk4pz455u0TEv97dgWOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 12 May
 2025 07:09:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 07:09:45 +0000
Message-ID: <74e83de0-1a1e-458a-b110-f6458db129c2@amd.com>
Date: Mon, 12 May 2025 09:09:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
 <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
 <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
 <cb73b496-1008-4338-83f4-a1ddcb81be46@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cb73b496-1008-4338-83f4-a1ddcb81be46@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: ba712b38-0d08-431f-1725-08dd9123f9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHBnUHdiNlFKVFRaOWgrN0lRT2djMjd4dlZucUtTUm9aRnphVktmNlhKNVc5?=
 =?utf-8?B?RGQ3UHFJak14UnJFaWpLRHcwb2VFU0lxYkx6Sk13R1hTclhNUkljNjZmNEFs?=
 =?utf-8?B?bm1pL1hCMGJEWUIrTkdQUE1WQ2VIdWM5VE45eDg2OWc4RWFobU5qYk9oaVYw?=
 =?utf-8?B?SXFQdWxScnBsSGRGNGpZOXdrZng0RlNuSzBHdm5qWTZRaDdaLzZRL1ZtN0tD?=
 =?utf-8?B?Q0p6WmpqcjBJY3lwWlBRR2QxVm1pMzFBeVdCSkRScHNGMm1pQUZ6MDdOQmZj?=
 =?utf-8?B?UnR2czZzNUJsQ1B5TlFlUjVUekRRODI0MXNKWEFaaGZ4c3QyNWxIYmMzWERX?=
 =?utf-8?B?Y1VuNUxoeWxFTzFzVEY0eFVJcFkyRW96OUE5c3Q1SkFwd3dKZnZtZEd5c3FF?=
 =?utf-8?B?d2pwa0Q1THdvczFMVGxWUGQ3Rk52S0NYN0g0ZkMzOVJDYVVYeDl5NnVzaERH?=
 =?utf-8?B?V3JscEc1c0JZRTN0SEVHVzdUOXZHK211R1VGNzdqOWtGdHlsTlNlSC90WTBH?=
 =?utf-8?B?WnNYZU9hcDBnWlc3Sk1GcUlJNVZUTUpOcDA3N01aQ3QzRU91aHJ2QUxaaHNX?=
 =?utf-8?B?WE5aTkFRYVVaMzd2YTNaS2J4Q3hSRDFpUzMybVU5cGlVYnl6UzBGR1JuQW9y?=
 =?utf-8?B?bkJmbzJBeUVPK3Ura0ZGM1IxVWJ0bFlCYnpKcmsvRlNzRW9iVmE1cU9EMWJG?=
 =?utf-8?B?WGF3L05GZ0NCYk1jT2NjSCtZbHNpc2xoVlhpQVBJZHFwYk10TVI1MElvM3cv?=
 =?utf-8?B?ZDFnb2lyMnNDRHhRV1dLQk9pOHlJNjkyUHNKcTdYOEszYlgwMDA2OSt5YUJ6?=
 =?utf-8?B?UVovSENSbis4amFDVVErNjA3dkdLdDVDU2N5SllqbzJuQkJlZE0xL1hiUHZT?=
 =?utf-8?B?RHVRdUFnL3VkWTFVYnU0bE1WRkhsNnptYUZVeVBPa0NCZXM3TW9XT042RXdF?=
 =?utf-8?B?UUYyMElOY3BpUGpaVDVUSTNKNEpWVlN4YzBLZlRCZWhFT1R5dHJ0NU1DaEhj?=
 =?utf-8?B?eW1NWnBCcW9IM2k4ZFJ0MUthOGlMRS8wRzRRbXNPcFN1azdrLzVkTVlNTUVn?=
 =?utf-8?B?Tm1SWTJneklPQ1FBY0dGM0JwdmNWVXJuUEdsdXhPZ2FRTlpVVnBQNEYzMTBz?=
 =?utf-8?B?aTQvWU1sRDFOekRibDRBVm5HOHNFUWY4dEVWUzd1Q0lhL3l4b0tWcHNIaVdh?=
 =?utf-8?B?OUdkVmYxMlNubUpDcFVtL1hTUjZ4bFZocUJvcTBjbDdrdGpnTnBENGpyL3Bo?=
 =?utf-8?B?NGlUSGFpR2xUcnBRUGprMmhTaktmL3VuQklQK2JYY2tUTThPOXhocWlHZTBk?=
 =?utf-8?B?NEJwSlJSbE1McDZhd0lUR2ZNWWI5bUFIZUlET1oxUzdyZVd0cnQwTnRGenhK?=
 =?utf-8?B?WGVvR1BzeGVUZ1JJODR6M2FMQlhmQlM5T3dhR3ZZTUQzWUxGWEw1OXVRSzhW?=
 =?utf-8?B?M2tCbFZQY25rcXdNVkZrY24zMkdZOFVrR3JIRUkvNFJHTlZ3QXU4czJUZWVk?=
 =?utf-8?B?b0daZkFSRFJHejJVdGpuTVpHc1Y5akVGblFMbFRNN0swbGJZK0I2R0JocUFX?=
 =?utf-8?B?M3JFRStDeTd0Q0hZM1lWT2p0RmVnUkxTdy9SVFl0SXdIMnVZUGNNVzFFb0xY?=
 =?utf-8?B?RlNlVnJHSFpMZ0liclVqam4yOVhQZEtEb0d6VXdCTTcxckR4VWhNNlQ4UDQ4?=
 =?utf-8?B?dHNtWWlBU0RNT0QwRmNTVlE2MFNldmtRYi84V1FyL09OUlo4L3JjdzI4STRj?=
 =?utf-8?B?MStxM3JrN0RXczNZR2xPMXdkVmJXSkM5SmNQUDhXY0x6ODJOYTY5am1DZjha?=
 =?utf-8?Q?6hbaR4goi3qasWpFAE7Z9tLCIsnOT4AfBxqFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Q0VjR3VUU1V3dyS2hyRFZqM3RXNFFReWVvR29RMlBHRjBkcW9hbWZkcWVS?=
 =?utf-8?B?QnQ0K2ZEVWQwbC9oZTRpSUY1a3J6aGNmb215bGdDemFQdE1SNDlNeDBjMVh6?=
 =?utf-8?B?UlBpMDhDQi9BelM5Ym5DT3VlblNxZ3VHSHlKOUpya1RDeXUyaVpNaWhKMkVz?=
 =?utf-8?B?MmI1TUx0b2tGMGFlMEo0K2s3Z25udW5oeGRqM1NTd2NUQ28wZStLQ2JjMlR2?=
 =?utf-8?B?OWhnNTh4azh3amsyMmRxakxPRHhiWWVRMWFzQUliUmplSGFzOUFscTVYeFlp?=
 =?utf-8?B?d0hIenoyYmhCS2o2Ylh2NDArRjFKQW03Y0hzc0d4dWFkcWJibDdyVVlVVFZS?=
 =?utf-8?B?WE9RY245b0RjTjhSSTl4R1hOZWpIV0x2eFJhczBYMU9tRzdKb3phc1l5RHdL?=
 =?utf-8?B?cUdMeVZWRCs3UGppWTg3WG9GT3VnNEovb2ltZnUvbVQ5N3VGVndpai9hZW15?=
 =?utf-8?B?bmR1V3dwOWNzSUU1TmtBY20yTUFabXcxWm1VZm0zUzZCNUZiSmpLbi85cnJi?=
 =?utf-8?B?cW9meC9DdmU5NXhXWXlJeXl3TkNIRHlhbGlFdFdhbm9LQ0ZSS3c3QWFsTmNU?=
 =?utf-8?B?YkNLbFZiSVJ5bXMrTEkyVlNPaUhVTDVkNE1jRFhpMlFDMlRnSEl2Nnhoelkr?=
 =?utf-8?B?d3pVNFh0OWRtK3cyWTRKTmtNRUNQTnVyUjBjbjZpWkhUdXdsT2JQamIzR1Aw?=
 =?utf-8?B?WnVNMnNQYVIySHNOQzhkaEovT0RNTXdJa21obHpPTHpUeXl4aDU4Z3daUWtv?=
 =?utf-8?B?MjRISkY2R0FPaEErUGJXTHlvWTRxV1lBMDJRa2RsYlorRE80cmVET056c0Rn?=
 =?utf-8?B?UVFOWWZHbnhLb2FyUlpvMTB6UEJ3b1VEL2thaURCaVlIQnNmS3BwZlc5aHZS?=
 =?utf-8?B?Z3BxM3pzaGU2NDdIUDNYWGRmQXo1Q1FQanl0MXh2QkFJTmtuczRpZW1zV2Z4?=
 =?utf-8?B?VFRKQU5HeC8rLzZwSW81NzFlWnRENUY3bmtXT0tDdE1QRDRCTG5aWGFBWHBB?=
 =?utf-8?B?ME51YnhYYm1FcjdBN2pyYW5scGt1aTlpS3JxdGF4YzQ0L0syTkxGWFN0cUZ1?=
 =?utf-8?B?MXVDZFBkbndUODNjVThqeDJWVjZYNDNoZGxwT1BXQ2pPK3Q2cnVPL1doT3lq?=
 =?utf-8?B?VlpPMnBCU3ZsUE9XYU5HelNuTlJGWGRrSWZQY0RHdks1SG11NjIxbFlYMHdp?=
 =?utf-8?B?WHM5ZnBNWkxTNFpCbU9iODFZUndmdWVDZS9Ddlhnc1dYc082WWFYL24rdXVs?=
 =?utf-8?B?dDZvZUZ0RVlnbjRzbUVQc0YxTjVZcm1OU0Y5aUhwdE5QUklraSs3ZUJ0Ui9s?=
 =?utf-8?B?ZXIzK0h6ZHFicEllcFdFS3VIMHJ0UzFZeHJHMkdwRVRTMDZVT3JaTFRYV1c3?=
 =?utf-8?B?QTBkeUVMTGJkSTRweUV4UmNRSFJscWxXdXNzMlJ4MEUrSVcvNDFLYklKOXZz?=
 =?utf-8?B?aXpvTkxJZllRU2ZNNE9YcDg2VGZDZnVZMEJESGlKVGN6UzZONE5SV0xiYWxn?=
 =?utf-8?B?ZE9Qd0tXOWlIanZBcVJTZENhOEw2bXpwdWJjVHMrTiswUTl1alV4U2xWd0o1?=
 =?utf-8?B?Tk1hb2JkYWtlVDkwQ2tZelpmbjRHQWI4SUU4bXNkWDlEUXI1NUVEM3Y2dnRx?=
 =?utf-8?B?REgwQmpZd1JTYUFVNUExV2JvMnI3bDFmdThOR2x4KzFaR05aQStVMVJ2SHRk?=
 =?utf-8?B?aGhMeWhoSUFid21GZDJEQVVtYXlzakNGVzNJOHJFSGNXSTNyUEd5Ry96ZFE1?=
 =?utf-8?B?OVpOZGl0Zld5UktTWkEvdDRXaWQzcUZUQzluTlZheXU2c09meG5TMldiVzcv?=
 =?utf-8?B?SmJXU2VZd3c3WTdQTFNlR1ZKamMyS2xvYjlvS2gxZC9lZUxwcDl5cWpHaE02?=
 =?utf-8?B?N2g3MDYyYWN3cm80ZHNQcVFaNU1rai9wc0tvTyszUnJjQzdCL2dCV09uWDRG?=
 =?utf-8?B?N2NwZVd0TXUvNzdmVFI3QVd2eDg1cHB1aTBtZVVyOHdyOXAremowQUR6M3Nw?=
 =?utf-8?B?VHhlc240RjlPY1IrRmtwNUFvMGZ0TTRUdnkxZjZ0a01CM0lwVytadjhxV0hR?=
 =?utf-8?B?UnBIL0xjcnhrdjF2MWNRdEUxcWkxZ0x3QVN4T2tKT2RtUUlwMW0rSHlHSXdX?=
 =?utf-8?Q?CXJc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba712b38-0d08-431f-1725-08dd9123f9c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 07:09:45.8599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmX4otWZWKFRkx+vzEMWCkKD4u8twKoZ5fEmDjAcxNvQ4fxOgOyodeSSHIaaaZ7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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



On 5/11/25 22:37, Paneer Selvam, Arunpravin wrote:
> 
> 
> On 5/12/2025 2:03 AM, Paneer Selvam, Arunpravin wrote:
>>
>>
>> On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
>>>
>>>
>>> On 5/2/2025 9:02 PM, John Olender wrote:
>>>> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>>>>
>>>>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>>>>> + Christian
>>>>>>
>>>>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com>
>>>>>> wrote:
>>>>>>> The drm_mm allocator tolerated being passed end > mm->size, but the
>>>>>>> drm_buddy allocator does not.
>>>>>>>
>>>>>>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>>>>>>
>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>>>> This looks correct to me.
>>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> I was thinking that we should return an error when lpfn > man->size.
>>>>>
>>>>> Regards,
>>>>> Arun.
>>>> This patch restores the previous behavior in the spirit of "Do not crash
>>>> the kernel".  The existing uvd placements are pretty clear in their
>>>> intent and were accepted until the switch to drm_buddy.  I think it's
>>>> fair to consider their style as expected.
>>>>
>>>> With that in mind, I'm not sure amdgpu_vram_mgr is the place this change
>>>> really belongs.  That is, I think it's worth asking:
>>>>
>>>> 1) Why does drm_mm accept end > mm->size without complaint?
>>>> 2) Why doesn't drm_buddy do the same?
>>>
>>> I remember that during the development of DRM buddy , we had a discussion with Intel folks and decided to
>>> return an error in DRM buddy when end > mm->size. This was done to ensure that, at the driver level,  lpfn
>>> has the correct value.
>>>
>>> I will modify this at drm_buddy to match with drm_mm and send the patch.
>> After giving it some thought, I think it is more effective to implement this tolerance at the VRAM manager level
>> and allow the DRM buddy manager to perform a strict validation, as this is necessary for other graphics drivers
>> (e.g., i915).
> 
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Ok in that case please pick this patch up and make sure that it land in amd-staging-drm-next Arun.

Alex most likely won't follow the discussion till the end.

Thanks,
Christian.

>>
>> Regards,
>> Arun.
>>>
>>> Regards,
>>> Arun.
>>>>
>>>> Thanks,
>>>> John
>>>>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/
>>>>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>> ttm_resource_manager *man,
>>>>>>>           int r;
>>>>>>>
>>>>>>>           lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>>>>> -       if (!lpfn)
>>>>>>> +       if (!lpfn || lpfn > man->size)
>>>>>>>                   lpfn = man->size;
>>>>>>>
>>>>>>>           fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>>>>> -- 
>>>>>>> 2.47.2
>>>>>>>
>>>
>>
> 

