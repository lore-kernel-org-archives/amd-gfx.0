Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F17CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF7210E8A4;
	Wed, 10 Sep 2025 08:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4LQ+DKKZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C426D10E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqRhclXx9NC2KoW1OX5irJHA/0ahYnfpbZzgxn75gvB36Uc9BhQ6u6oF4s0VAgVwxCKGw2yikFfRrAb75ZyKuX7MFNyo5cYRsDdijloSYcdx1zysRZ8XFaA30b4b5j9xZeub1ZBDyb1K5Aqhe9DVJxFwAwVRFrIDUI1QA2T54Ww6xLA8BBkxZSsEneq//votXdV2QpfLhyxT5l8BtwC5pM0GM5hfbMiEZDS/P39+o2zpGJRy+yoN+hf/1OKthdxYRmQoZ0P9JRIzMEEb/2pT2k6xPLHszOqfIGCMiU9v1WHwwo9oZ3xySKteGRpW+FBwKO81C+BbSuxd9OkhryoKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flE+Tr6h11SH4ivE9B+Y6cqrHqsXYKdlwyeMaQi5lhI=;
 b=bSrPXUB9Hf/pUa0g7Q1RBTjIPfNx0ZjfpiO5Y92Eg3Rd8ml14wxJjnP37Haw5t52L4TsG4P8bhV1LFsxihHDrZDc2K/YKYMRSGlPekmVxtHvHkFH+1LfRfCyR0xDrHuh7BeJa7SIBwyH9CyYv8OL6bCsHnCvSSzLo8q1rRJkPrNAxIqsitMMzjZ4iPvU1VlTvu7sD/QJAwhSE0xNAW/hkT36FiaOnW/KIOKYKxCePnnVf0isFgDAYWOw37BhMwRVdHr4st5byohgWyN9FEODRfR1K/Glu5EUqbFYWdc/GBXTvd86KhFHoop1+MNIUlmIY2CkJify36hRp10sFxRj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flE+Tr6h11SH4ivE9B+Y6cqrHqsXYKdlwyeMaQi5lhI=;
 b=4LQ+DKKZW9w/NGDM836+trVyqSFzjf9GpzIaPpv4MY1q+MWcoEMznTSw6xp5iJ7v+hCr7HCmap9zQcDT/yZMZt16x/zP4TtzZa6uViNq2mdPKC7G3t54oYt1j1m+CXnHJPKa3lfzF5uSdI44inPeZY8Bam7ql5ZAkbOd2gj0hVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:34:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 08:34:23 +0000
Message-ID: <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
Date: Wed, 10 Sep 2025 10:34:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 6395464d-9943-4997-cf15-08ddf044d827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDE3MXFSTTRZbE5tNE9DNzFEdkZpbXVnU3ZoN21HWVZReTRGY2dzTlg5UzdJ?=
 =?utf-8?B?SFNvUXVUSTY5VlRDQVVGb3NFT2lUTUNLRjlQcVk0QmFVQ3NFbjkzaDBHOURm?=
 =?utf-8?B?WFd3NmpLblRQTDVxSE81NEdMQlY1TUhRN0hLY0g2ZWozeHBVdnppZ0JZRWNG?=
 =?utf-8?B?NnJleFE2UmxPTDA3dmdBL0NPeSt2M1puM1ZxeTZ4TmhmVzVJRENwRTJRNXFV?=
 =?utf-8?B?NzVEQThEWkt2a25hbnk2c0N4RXhNa1YxbXBiTjFvTGgvckZweFU3dFBIS1pE?=
 =?utf-8?B?Z0dIZlpuUzBlLzlnWlVFaEpJbW9sZ25QSmFSallVOGdGZWFlMGZSMlVvZHY0?=
 =?utf-8?B?TkhaVjRFZ05GdC9QbWZjL0p3eU1nU2JOVzdraFltRzBXMkJKbmMyRkNhMVJz?=
 =?utf-8?B?L0x4d0pBbWJ3U0M2UTRYdG54UGw5dEJ6MElOZm9QTFNqeUpBWHJpVmpReFhy?=
 =?utf-8?B?cEIyWHRHeEFvWTREM1Z6K3VLUlNTNmpWRzdsbTZlM09YV0xWVVBFWEZrajZN?=
 =?utf-8?B?aUZ5cmN5MGhLSkRWSERZOVBZTkc4WnJYOTlOVHFpSXhyWlpzVkMzZ04zN1Bm?=
 =?utf-8?B?NXUxRGNnMHl1OGU5K3pTc0t5Ky9rSkxPOHlIWDZnZlhSWHJ4VDdFVWpRVkp4?=
 =?utf-8?B?UnZCbmM2Y1lxZkR2ejlTaFk2bGlNVFlBbkF6SmQycUFlVllHNlVGdWVPa1Jw?=
 =?utf-8?B?eFIrWnYxakg4bTJTRnBqemFvbHpKY0VoMVJBWnM5QS9HRzJoZldEWXFuZEpm?=
 =?utf-8?B?eEVteTc4WG9Vd0RaUWlpTmJhSmVjYTI2S24xR2hqSU5FQWtFalZSYUlESVEy?=
 =?utf-8?B?b0w5R1JpaThVZWwrb2Q0OVR0RzBZVVBwb3hlZDd1WjIzcTFIZUxFRHNaUHNx?=
 =?utf-8?B?Z29RZG5ObFd5dGpwSit1VjVUdEdJMStRS3ZEMWtERDNzRjdpbTB2U2tmVmF2?=
 =?utf-8?B?WGQwbXFlUEtlUmRRVGp3VjRuSDBDWHhuUXBOcDVvQkRuYmdXK3lkTWtaWkIr?=
 =?utf-8?B?S2ZOTnJXR3cxWko3Uk1iSFA1c1VOZzBnYUZGclVucVhBbzlUeVlWMnlFZWU4?=
 =?utf-8?B?bUd5bDR5VVpkbHo5UHNSVlRHek0vOEZpU0JiQ0pJc3R0aTFzOWkwZlJ6NkFV?=
 =?utf-8?B?bGxrTjQ1UmNtNUxzdHcyZGtkaE1PWUoyUDlnWFFwVjg1RHl0aENWZ1UwYW1r?=
 =?utf-8?B?RVM2MmtDV2ZoV3Zhbi81VzJudWVVQkxLWVFSNi9xVDZFVCs3Z083cjhKVXl6?=
 =?utf-8?B?aGllZEc1NVh3YnlHSWc1SFNxNmk1aTE4UlJyUkpGdytwaEpPSkp5ekNBMHJI?=
 =?utf-8?B?SjZybFJFZ1l6YnlTK3pVM2x2RU45Qlp6a2VmVmF3Ukk3TlVUUGp0MGQzMXhi?=
 =?utf-8?B?Ri9iK0xFZ3pBN2VTVkgyZ3p1VjhtaDFyMG5wd29RZERJVGtuMStNdnRZV0Ji?=
 =?utf-8?B?WUVGSHcyVnFPd1krL0JYUFV6Vzlmd09UK1N2OFVoYkg0ZDNTdXdzOWNkbkVG?=
 =?utf-8?B?cEZ5b3ByczVkSzRtTm90U1M5WGZPV2c1Wk1DY2h1Zm5FY3h0VTdwSHhDMTJI?=
 =?utf-8?B?azFCV1AzY09OV0ExRUF6cE1GbVdSWXNhUFhqSnZwSFdkSlJGNVQ2ZnhJUFdT?=
 =?utf-8?B?U3NPUkdraVFVZVpwUkdGRkVKY1VPWHQrRmdwcHZXWENkRFR2YUo0aXFvN00r?=
 =?utf-8?B?NDhmUG0xcTIvZ05DejFnT2l4K3N2em9HVHh1TlRmaTJENzJkalA3ZFAwVUIz?=
 =?utf-8?B?UDdGSktwUEVTZXcvLzRxTHdJclkwZkdUSGxSa1BzZ2NIMU9Sb0xoZmV4dnQ2?=
 =?utf-8?B?S0lMSkNWdzVnZUZTNE1EUFM4bjNRcTNOQU9xN3ROeSszeTB3ejBOekhxZE1t?=
 =?utf-8?B?b05xeXA5L2l0YzU3ZWsxMnJkSUpaK1ZmWEhlaVhtL3lvaFo4aURlQm12TmJW?=
 =?utf-8?Q?uSUQYWmpp28=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJtbXZqMkt0cVVMWDBBUjlySXV3TjZneFZpZmZJOHByVFFITGNScnVXQUt3?=
 =?utf-8?B?VXJXNUNNNkc1WHJ1RUduSlhzbnFEbTBsU29mblZhQi8yd2g2WncrbjMxOGhW?=
 =?utf-8?B?SXhBb1NOMStydEtFN0xNM1ZxY2xpNVFSSXJIckJKTTZ6ck03cVN6ekZVK0Ez?=
 =?utf-8?B?ZzJwVEU5MXZiVFErZk9rNGRtRkZKS3M0d1A4N3B5T2VRa3A0cDM2OTh5eGJX?=
 =?utf-8?B?bG4xWHdMQTl6YU1Dd2g3OURzMmt2UlRRWFlaU1BQUmxUM1JLZTNTSzB3NTh2?=
 =?utf-8?B?aUNoejE2NjRCK2lZYTRXa05zY3JSYWczRldGSXoraG45bjBVdFZjSkpzMHdH?=
 =?utf-8?B?ZW1hZ3JaczR2WWNleHBWcEl0Z2FQYzJNS0I3WU9JVXIzQ2QxTnVjSGlFRE5I?=
 =?utf-8?B?SXpBWmFxMjNRd2dwVjk0Zm4zZm5RejcxQXpXVW5mdjZKdVdDOVZHWmdOMGVQ?=
 =?utf-8?B?UVBPNExLQkpLTEU5UitoODBuQ0lPNGk5bm9xYmRMMW1NY21uUkdkczB0ays0?=
 =?utf-8?B?RzJ6Sk5LcFltWFAyYS9zK1RqeUx4RU50VFhCZ1VKZURsRUluZS83VWtnbkJn?=
 =?utf-8?B?SE90ZEQ4dXNvQXdBOVBIVThSbitiaVVaN1FqazZpaGFsbG5jclVHQXRWb2tN?=
 =?utf-8?B?MHdRTFM0RGlWUFY2T09sWHQ4bDk5ejFxWkV3VDdVMHV5ZlNpM3M2cFRtR1RP?=
 =?utf-8?B?aUdjUkdORHV0R2lHYmx3NFRyRzlwWHhUK0JXamsrV1BDWVVVaTFpWE44ekZw?=
 =?utf-8?B?ODFPOXRjYXRlYmlWV1dTNVo4NG1YUm1nVzN5cnZZWWdCOVNlUi9QQktiQXZ5?=
 =?utf-8?B?NmswWDkvUEt2VXFSaFlFakZqNTdyRzdFTmRrZVJmZFB1dFBOMmxiQ3haenBH?=
 =?utf-8?B?NkFEZFEzQ2JISjlBSGVCVDRpdTJGczhBWFF3eW9rZ1Jvc2EwNmhLcStsL24r?=
 =?utf-8?B?WG96N0VHdXVYZWd0ZnVRenltWEVZUFduTFUwbHFxTlFZZUtTVzVUOFZNQXE1?=
 =?utf-8?B?aWswSW9KOWRTc3dMZkdnZzJYK1pBNytZWW1ibDdKZ2grQWpmOTNQWjR6bWs3?=
 =?utf-8?B?eUhCVVJPR3dYdXpzVDh6WEUvL0ZsMFlreWJTeE9PL3ZQTitBNjYxYlY5TmhS?=
 =?utf-8?B?NHZ4TnRsSlFIWGhWUldrYTFkZitTSjMyOU1pai9uZ2NEMk56Rnc2SEliRFMr?=
 =?utf-8?B?UTNFeC9OeVhxMmlKd2ZKY3k5em5FUnVuLzVuUTZLeGFMb3NyNTdJVlYvODBp?=
 =?utf-8?B?RWgwN0c4VnZuQjVqbFRtSXVPMFZWYUJKcFVUZDhmbk41ZDV0SkR5bmlFMks4?=
 =?utf-8?B?L2hSYzRndmFCWVNHY2NLTEdjQnJRM3FPZHp2TTRnQ045aEcvTFBDM3ZxM2ZB?=
 =?utf-8?B?eEFSNy9OdnJJSmRrV3ZrZWRBVjFEZTVxdWM5dndUUi95WmhyTkxpWVF1b0pu?=
 =?utf-8?B?S1NDNnIyTVhvaWRrUVkxQzdsRnFkZjhrSmNyaE9ydFduT25QSERDZ0M3QUpt?=
 =?utf-8?B?ZCtSMEQyenhFMlpoc01RWlM0RGYwUFNlTWZzR2J0K0ZpY1k1ajFWQjQvckFP?=
 =?utf-8?B?a1VJNDFYbGcxWXRBWmVOM3B5eGk0TW0wbkRaejREaTlJbGg1bzlOTTZXbG92?=
 =?utf-8?B?cU56K0hTcG1DQmdaQWJGd1hxQVhna1dHaXBMV2FmaGdoa2crbEwyRVRMeWRp?=
 =?utf-8?B?MFZWQmRQT0x0VTlLd2ZKc1dXRGhzTmpBZUZ0OHA5RTRvcjk3YVVhRzQwakNx?=
 =?utf-8?B?QUpzM283SEZ1SUVWak9RV0xyTGIyNHVPVTdGZFVXL1dCVmw0OHlwSlp2WE1P?=
 =?utf-8?B?b0pWcVU2S3RMNVFrODBPL2NSS2lDMVQ3dlBjV2w3SEpEQmErb3FMcE9sZGdF?=
 =?utf-8?B?Q0UrbFlpTWlselc1T2xWaWR5RGlNVWJKTjNrc3NmdEFDcC94bXRtSTU5Mlla?=
 =?utf-8?B?NWluZkU3ZzBEbVA2QkpZbnJsOEMveWxMaGYvdzhQbERhR01SUmRIZHVPbkRY?=
 =?utf-8?B?eE55YWw5ZC91QUtPeUdzbHZ5eFhrTk9kR25oU1QyTExFbTd6WFV0OTFkbmQr?=
 =?utf-8?B?d0V4Z012Nk1kTXVFQlpKMTlWb3JDREtkU1VjV1FSTWJiZXhnQzQxTzNjR1h5?=
 =?utf-8?Q?LEPeqKizC+oYHPkxqPInkagxK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6395464d-9943-4997-cf15-08ddf044d827
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:34:23.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbN3p6kYT5swoTMeMxty54z2W+trvfoFU/PeGwd8mdT7FxNtsyEoIn/oVa/R9fBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
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

On 09.09.25 18:56, Timur Kristóf wrote:
>> Even when we apply it I think we should drop that, the value the
>> kernel uses is correct.
> 
> Hi Christian,
> 
> The kernel and Mesa disagree on the limits for almost all SDMA
> versions, so it would be nice to actually understand what the limits of
> the SDMA HW are and use the same limit in the kernel and Mesa, or if
> that isn't viable, let's document why the different limits make sense.
> 
> I'm adding Marek to CC, he wrote the comment that I referenced here.
> As far as I understand from my conversation with Marek, the kernel is
> actually wrong.
> 
> If the limits depend on alignment, then we should either set a limit
> that is always safe, or make sure SDMA copies in the kernel are always
> aligned and add assertions about it.

That's already done. See the size restrictions applied to BOs and the callers of amdgpu_copy_buffer().

We could add another warning to amdgpu_copy_buffer(), but that is just the backend function.

> Looking at the implementation of
> amdgpu_copy_buffer in the kernel, I see that it relies on
> copy_max_bytes and doesn't take alignment into account, so with the
> current limit it could issue subsequent copies that aren't 256 byte
> aligned.

"Due to HW limitation, the maximum count may not be 2^n-1, can only be 2^n - 1 - start_addr[4:2]"

Well according to this comments the size restriction is 32 bytes (256 bits!) and not 256 bytes.

Were do you actually get the 256 bytes restriction from?

Regards,
Christian.

> 
> Best regards,
> Timur
> 
> 
