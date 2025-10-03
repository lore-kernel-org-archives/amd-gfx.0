Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8961CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 15:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B1F10E084;
	Fri,  3 Oct 2025 15:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LFLWT8s9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8935B10E084
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 15:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abYWRL/HECr5wxRhB/aE1GRkB4+c+JcylbKUFatLky5HCE+ze4wmDW3BCTNdqPgyBtUted6LInIfbP0vLqzMDVHCxMIufB2LhJj9cjReHewu5idc8eEe5DOqaTX4urzgQPdFEw3VONouub1USDnZ1nrfZWKubpW2HwTUMcJ5tlDB/hiSE3gunUfbpqUgB3OEN3B61ITfT5QnulldlsSk5ezwjt7777k/DS1B6ODNpI5ThRDvzHLX4pxo1ZRIffYQQMKOMkmicDIrcNl2480xOoBhy0edDnevizZN9TexEPrSRapGu+vH/auHrEb+tTxh0Iz+/Q2l33lbmgCN5ICMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThRHsTJdpZyzy/oaZBgBRtzq0W7FaHVmNg85ids+vVQ=;
 b=o05KBKv25OuOVvdpR+l2v72cq7SI6hwf079aZIGvuHfSawGhnuuwZzjgBVzSDeANf50NqKiA8AUEtUiK5n8qEKOFw/y69rZuzxUV7mTFMmXdhaDHTJav4OF+HDUda8PoFhO3hUyn7UwGvKbAyBg4DObmS6GFYBy5xJLxgERopF1G32bdN2w2f1DIpwu0Xi+NoySd0IrrH3/twsliW26Ck78D1nnrPWwUjdHEqtsyXkLeJ1g1s5RQe+Zu+kYCZCkb3g5rvNeEoujBLhzk9fkQNBY0ds3e06LYZJ483Pd7hAmrORU6lDATgyhNjmMWOMQdkNL+ZWGVMGXE3azP8y5Q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThRHsTJdpZyzy/oaZBgBRtzq0W7FaHVmNg85ids+vVQ=;
 b=LFLWT8s9wF3IH5IjKEriGUx/Ls95DLN0g7mnXdg7ih3nwglIylPx6wsZ79f4iIAxS6d7q8DLjhnQwwLf8Gsh1rv05XWXTABPUNYgM7go0zXPKjOwMQRtCtXx0D/neK2xA9zd53bMTp0fWlQT94dtntackFyrzx9IvMc7ZNSF3Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 15:13:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 15:13:03 +0000
Message-ID: <884071e5-1638-b82d-bb0a-ba7a36d6f13d@amd.com>
Date: Fri, 3 Oct 2025 11:12:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/amdgpu: svm check hmm range kzalloc return NULL
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251002174307.10583-1-Philip.Yang@amd.com>
 <8942a78e-4946-4a86-a8d1-1324ec7c7f4d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <8942a78e-4946-4a86-a8d1-1324ec7c7f4d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f960282-cb3d-410c-ce33-08de028f591e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGdEMzdxdWtBRU83UDFnV2w2U0tmRkdMcy9QOEtsVDhoQXI1R0NhY0tNSmdr?=
 =?utf-8?B?TGRtZ1dQcDI4S3ZjaWJmVW5CNE1hTlR6WXhqVW5DM3d5YlZEN29UZTV1N0ZS?=
 =?utf-8?B?Tk4xUXRSdFNvRGZiV1dSRmpmQi9QREpIWnl6VjliVjgvNGt2QStacnAyRkxK?=
 =?utf-8?B?SDdwcThLTGdhMng5N3czMHdma1VPMkJwOS82VExPSHZ1bVJSSW4wRFZTTW0x?=
 =?utf-8?B?a1UwdmhIK1VBRDNUaFJ3N0dUcWJMdEdvKzVLRWZvSS9yWHljL082ckdZYTlI?=
 =?utf-8?B?TnJmV1BtRFl1TXY1bGd4N0ZjbzNwanBtemtoT0hIazg5VnVhbHBLc3pGRXBo?=
 =?utf-8?B?M0ZyeSt6VG5uWldmVFg0dWZKMGhXYkp5SXdJRlQ2TC81SkkvVVRoOFpLOHhp?=
 =?utf-8?B?bkNEejFOaGxSZFNGWm9ySTF6bHZuaDdnbjFIakNNZUV3ZVU2a2pQVktjRlFL?=
 =?utf-8?B?WkdHcTNRNjhtSWkrb2NXazRGakNVK1hBZDhKcnNJMU10ay9qN0hEU1NOODNT?=
 =?utf-8?B?aUQvQm5QQ1ZmV2hBaDZWK20zbW00blkxZUc4YnY3WDNkYUFvUjdQMU5wVGRy?=
 =?utf-8?B?UlB1QUxjM2Y1NFdKRGpyZk4vZ3haYUZyUit2YkR3TWp1M0lxZ0pOS2ZkUGlI?=
 =?utf-8?B?UitvUit1UmlyR2piUWVScmEzOUlIQzB2YWZnQTd6NzhmNXlybkx3ZTZ5cmRz?=
 =?utf-8?B?RFordktGcmxaMi8rdVNQbnN5cEVEajk1T1E3clVHR1FtWXlFVnhLdWRiZVF2?=
 =?utf-8?B?ZXh0aXJ0eWJTTStsUmRDTndJOW5NYjN5emNFWll0ekkvRGUxazgrQ2pEdkVu?=
 =?utf-8?B?d3Q5NnhBcTBBaEMxWEdFVXJIK0Z2cTBDN3UzMVNNM3BEcXVJcG4rR3p4TUpD?=
 =?utf-8?B?Y1pTbC9UdEJXZTJkcWZrWW83NEgyQnNSeWZNbUo0RVllYkoxY0k1ZjlGQ0t1?=
 =?utf-8?B?ZXhpU2lsT1AvdFFEODV6SGlrVFl5d3VDRWs3R0daZ0lzeWFGUVdKbzNHUGI0?=
 =?utf-8?B?bWdtY3luM0VQNHJNRGhHQ28rODFTNmtVOTZJcUU0QlFKa2RoR0IzYlRRVXVK?=
 =?utf-8?B?RFRGbUpPN09uTTIwMDdYMllzRmdDTGJ2ellSR3pXenBBNS9kd1c4YVUzRmR0?=
 =?utf-8?B?TXB1eXNvWlJOakFQaW5YeFFYbzVWU2xRL1RqRFNxc1FrUUtQY1ZPS2NKY1hV?=
 =?utf-8?B?SjV3aTRPS2RtWUZDeElvUDhuQktKTEQ2SVNYc1EvYmZuSHhVemJvd1ByOGFk?=
 =?utf-8?B?Ri8zbUlRVE1nWCtIVkZBQ0ZBbjljZjJBWTVFdDJEZWZ6LzVaNlV3Wkc2M2VZ?=
 =?utf-8?B?eEZTY3FPQ0tNangwV2dRb0VnYTJlY29RMjd3aHJiYkFvNWZMTTdHd0NwcXU3?=
 =?utf-8?B?M0U0TCtsTGpwTkJNazk4bFF5Y2xOSFBWeEtSNzNEbFBHS2VNMVh4ajFuUm16?=
 =?utf-8?B?aFlaQytzaDVOVGYxZ0llSExSY1FSZmFWSUxnb1BHWFBsd01FVlpNVzUwYyt4?=
 =?utf-8?B?S2I4QnFHdmcxRjZROHNZSW43YnFpbUsrT2ZJMW55T2tLV3NCSFo3citDMjNt?=
 =?utf-8?B?Mm5tYkxjNGVPUmtsbGNlZHpXQk9rdUNseXAzbzRnQmhDNDhpL24wZksvTU1s?=
 =?utf-8?B?VmVUVjJHNldvSUtGUXRrSjcyNlN4ZFhOZ01HRk55QVR0NUJNdnNjeU0vVDNp?=
 =?utf-8?B?RFI1QytQT09UcEszekJ6Ulc2QjZ3NWUrYWttUm5Lb2ZMZXJHQWx1VXNaUEJz?=
 =?utf-8?B?Ymx3amd4U3FhM1ZwUEVZQ3dxazJJWERnQzQreVBnaTlzd0p6N05ocHd2c0tG?=
 =?utf-8?B?UW83ZmUxbFNmRW5JQnhtU0ErQ293c3k0NjB6SzBMSEZ3ZnpqK2hHY2hlR09x?=
 =?utf-8?B?NDV1WUp6ckp0VGE5SGNQTHVkbWJWUUlrN1RVSm04RmRieXN4QW8zN0J4UHlw?=
 =?utf-8?Q?gTqk6YVwZU/MOfxKUX89x4XjPajM2Pl5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFBaUdIdHdZV2dPdk9UU2MxRmFnM0pqNjB2anVTd0JCZ3BTb2lMRkpHb3Bo?=
 =?utf-8?B?dmVTMWcwOXlZQkdZVEV2WHVVYmhSeStWVkZGTGJ1bm9jQVcxdzBDOUltREFY?=
 =?utf-8?B?aWg1dG4wMzVOV0JndjJvZW93ckJEMTB3WVErTnpEVjJQRnBkc0x2N3RqWjJz?=
 =?utf-8?B?aldiTGNYKzVpNjRJbzhWOGJQTHp0TXBkbndsejBlcWUxL0ZVVThwS250WVhR?=
 =?utf-8?B?ZldrSSt3WldFQjk3TW03dXZGcjE1bm5PR3RSbDVjOWJXejZnOVg3NHJ2T2pC?=
 =?utf-8?B?MGNDZXpvcTB0WVhhZE1vQUZDTUpqaTJuMll5ZFRjUTFSN0lUQ1g3UUJjUTMv?=
 =?utf-8?B?RmhnRmovZnhURTNXcmh6ZlVRbER3SzdjcE9rOVVPTWdtVjRyWFdoRXJpZGhj?=
 =?utf-8?B?aVdDY1BIMzd6a0dBT1c5eDNmUFVnMGJkaEdMYnVwZU1xSi8vN3RFUWZOUkUy?=
 =?utf-8?B?QXRuVzUxR25Yb0p6SjUralJyemJvOVhuUzN1UEkrVThhdkUxVDhPNGo4QnlK?=
 =?utf-8?B?SmRnTU5ZbVEvLzdEc1NKYW96QzhaaERkT29vY0FkTGRiTlloYlB2aGE2YVY3?=
 =?utf-8?B?MTRvdHljZzFlZmIxeGsxZm1WT3VoWlNmMGl2ekJKRkcwamRQNEdRd0xyb3Ez?=
 =?utf-8?B?TVFXQmZVKy9rUUhqcHozdUFZSnB2aWRqK2w3SzRPYlR0Nm56ZSt4cy9JOStL?=
 =?utf-8?B?dndFUmVJNXcxRWE1b0VaREtkc2NBSnEwdklML01pTVByWHRNSzV4NkZzbUt2?=
 =?utf-8?B?RUJ0ZHJzczlDcVRxWS9tdFMzWVE5WlhiMEpEZjdyWSs0ejd2MWdzdzN6Vlhw?=
 =?utf-8?B?T2hEcUpUNHc5WFhzcTd1Y2RQREtiRnNrN0YwWFdGdTFXejQ0cVViVXZXa0NY?=
 =?utf-8?B?ZkpZOGM5UXVaaTNaQUI2MHppcW85MXUydXo1ZDJmYUhMSDFUWm5zQkI1WE4r?=
 =?utf-8?B?UWtmVjFuVi94Wkl5TFR5cDU0SXEwdTVsM1p1UzVqMjJ3MzN5QU1ET0pFSFBB?=
 =?utf-8?B?ZzZEZnprRlJzdVdpek5ndWx4ci9kVEJvWVZiTnp3SmhxTFNCTktIZzRQenBZ?=
 =?utf-8?B?czVxc2wySStURjU2NnpoYU1ZZm9ZYW9BUEZ1em1kMUpHUDJXQnJVK0JiNC96?=
 =?utf-8?B?a3hUNFNQaC83Y0l5UnV1eHVlcy9RZXdqR1Jqallsc3NkVkhhS1Z1TnE3SlR1?=
 =?utf-8?B?MjVNcDBaRHcxc0ZIZUdTbUtMdndSblJpeWIxMmdmNm5vWi9wNVBvOEdTdXc4?=
 =?utf-8?B?a0w4K1REMFRERmxCTkMrVWhmQ0o2bGlFdm9ZK0RaV0FMT2ljayt6TUFpcGhp?=
 =?utf-8?B?eU9SZytqamJmaVVPOHlXUFloWWhhSkRMYzJyb0RmRTZCL1ZkOE1KVGozUjN6?=
 =?utf-8?B?QmpmTzArbkltTDd3bW0vMm43b3puK0sxUHRJVzFNUEZnM2ZJWG1uMVdEalE2?=
 =?utf-8?B?NzNMa2hidzMxbys0MU0ra1pReDU4Q3BwdDF4TmNuS1FaZGR2ZVJCQXJPUmx3?=
 =?utf-8?B?Z1lreVBaUDFFOC8yMTZyMVNBY1h1YlM1dzJZcFJxYzgvVkNHVlFtQTJibnhD?=
 =?utf-8?B?TzFsWkdWck1HQ1F1ZWl0V2d6ZTNNdC9lQ2s1UHoycFNjTUhESm9KZS9WTGpI?=
 =?utf-8?B?akQ4Q29GWWpBT2pycm5Vb3d4L1hraUJiOHg0VFljV2JnL05mYmNSTHVUSlMz?=
 =?utf-8?B?VmxLOVB1dlN5VEsyeGpGQXlSb08zTXBCeG1EQk9VUFRRM0NQLzJmUkVFVjYr?=
 =?utf-8?B?RmVSS2N4T3lzZkpHVTh6QVRhWmpRR1llQ1NBMlhjL0kxeklEU0pQWUtpMUFs?=
 =?utf-8?B?TWw1S09qOXFlL3QrMFU0dGwrbTVuemR1OVJkYXlFWUQrSnNFU0lvZWltcWJ2?=
 =?utf-8?B?aThYZGkxNmNrYzhJUlp2VWVUL09pL0podGY1Zm1yc1BvR1JXb2pYOU1hUFJh?=
 =?utf-8?B?LzdqSVNNUTZSWGZ0RXN5eXlQQlEzK2JXWjBhbUVjaW1QSGdXZi9aWW5JM1kw?=
 =?utf-8?B?ejdZYWJ6bWFGRDZsNkJpRHBqYkdHcHMvcVdyVUd2T1RtbGtIM2c1TnVPcHlj?=
 =?utf-8?B?NUhaYU5UdDlJeGRMbzJQWUFNaHVSNkNlV2Q3VExWcDV4SjFjOEJiTUY4NWFG?=
 =?utf-8?Q?prEk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f960282-cb3d-410c-ce33-08de028f591e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 15:13:03.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2fXLzsiRXva1LmGQr7saxZofx1iWrK0cAqd1vMJ1kv2Tl/tXzx+p6SkxxnRFHMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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


On 2025-10-02 17:48, Chen, Xiaogang wrote:
>
> On 10/2/2025 12:43 PM, Philip Yang wrote:
>> Add hmm_range kzalloc return NULL error check. In case the get_pages
>> return failed, free and set hmm_range to NULL, to avoid double free in
>> get_pages_done.
>>
>> Fixes: 29e6f5716115 ("drm/amdgpu: use user provided hmm_range buffer 
>> in amdgpu_ttm_tt_get_user_pages")
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 8c3787b00f36..e8a15751c125 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1736,15 +1736,20 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>                   continue;
>>               }
>>   -            WRITE_ONCE(p->svms.faulting_task, current);
>>               hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>> -            r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, 
>> npages,
>> -                               readonly, owner,
>> -                               hmm_range);
>> -            WRITE_ONCE(p->svms.faulting_task, NULL);
>> -            if (r) {
>> -                kfree(hmm_range);
>> -                pr_debug("failed %d to get svm range pages\n", r);
>> +            if (unlikely(!hmm_range)) {
>> +                r = -ENOMEM;
>> +            } else {
>> +                WRITE_ONCE(p->svms.faulting_task, current);
>> +                r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>> addr, npages,
>> +                                   readonly, owner,
>> +                                   hmm_range);
>> +                WRITE_ONCE(p->svms.faulting_task, NULL);
>> +                if (r) {
>> +                    kfree(hmm_range);
>> +                    hmm_range = NULL;
>
> How it avoid double free hmm_range? Currently hmm_range got freed at 
> amdgpu_hmm_range_get_pages_done. You free it here, then 
> amdgpu_hmm_range_get_pages_done would not free it. if do not free 
> here  amdgpu_hmm_range_get_pages_done would do.
>
> And besides free hmm_range, we also need to free hmm_range->hmm_pfns 
> that is done at amdgpu_hmm_range_get_pages_done.

if amdgpu_hmm_range_get_pages returns failed, hmm_range->hmm_pfns is 
already freed. If only free hmm_range, but don't set hmm_range to NULL, 
then amdgpu_hmm_range_get_pages_done is called and will double free 
hmm_range again.

>
> I think the real problem is hmn_range is allocated and free at 
> different places. I do not know why.

This is the change in 29e6f5716115, with details in the patch.

Regards,

Philip

>
> Regards
>
> Xiaogang
>
>
>> +                    pr_debug("failed %d to get svm range pages\n", r);
>> +                }
>>               }
>>           } else {
>>               r = -EFAULT;
