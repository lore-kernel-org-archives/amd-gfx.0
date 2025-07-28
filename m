Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D3DC87FC9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 13:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE61210E097;
	Mon, 28 Jul 2025 13:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uE7cBMkV";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2463510E097
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 13:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR9VZzdzf0tBvS0romahcUha/wbUYLTA/py84lJzgBjFbPupBVr9xmiVJlNFTuuXJe6X+ys3USBWYuNzsMjXVXOTpgyUWsMq+y3xFqwaVoiweJ56tee5eDr9sJ/SLPxVwTLasIjJkfXyYDH+5bLKgBWpC7kyxvH/5uemhL72LUP4qlOtlfFf2Fxb+nwyMfh+PE5b1L7SpbtMtIrBdbUzbpOsNC3nFtIme0B0kRqrEJTPZMK5ny2Isk7LZh5J9ixufmIvox5aMwyd0pQpeEhOGEw9ZTEYT5F30nDBXwoYhUUpYjEQHvU1g7Lucb1di3vdQ138kiLbHQqY05LJc+Vo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv7XSFvllvIjwbr4fon70o67IjJYiGYGvsHYeN8LDJ4=;
 b=RtVQqF8lnKfxiWRS6TwrwBUE870VOlK8koHuB8znhD6FZf+MVqkRyNaD0Xvigy0OnW2T53f9HDZV0OHOyd8FiQXQBsLBtLiEBMCILTEFCXpff/8x/BuLFnga2XEbiOeY/0w0C2usHNqzOI5MerdiW7saTTL5fEiVixUkmQQokF1uoLwDggfol7ko+941eYs1TNrReVFyYwGS0Tl7/+5znWLS9CSVu8uuZigYnpbNLm1GB+oifhQ45gwornqaAVwcVxwnwqvGsS4U4GwwNGGnx0FVB98mvZNqJSZnnoqyDe74oe0LW0o0DKU/AY+S2re8GUGXdNvqYxZeK5Gv0neBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv7XSFvllvIjwbr4fon70o67IjJYiGYGvsHYeN8LDJ4=;
 b=uE7cBMkVshkjlcwhRd5KHnfqi6jWq1ORLyUJcEzWk9CAn5+J2qt6AdVz65DJFMY+NIaBcs/Tvv23CcySKbyg6STEx2beHLXxG3tj5BgYqzh5iYWOFoz2j+HsQStHIrqr0wF5pdA1xOzskLZH+rqlSpTpyDbJACrq5UuexjcM6YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 13:42:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:42:22 +0000
Message-ID: <5e9ed6bf-6b8f-4848-be9e-9977a1dc46e1@amd.com>
Date: Mon, 28 Jul 2025 09:42:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect PTE flags gfx12
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Mark Broadworth <mark.broadworth@amd.com>
References: <20250727165218.849866-1-David.YatSin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250727165218.849866-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0457.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b43d34-62f5-4b48-1bd7-08ddcddc9494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eS9MMENiMkl2RUFYRi9XOGEvS3lzSktjWkNwM05OWXpicm5HeEY3NHFIK1U2?=
 =?utf-8?B?dVZkeXJuTWNGbnNCKzBHZ3FOSlg4MUFkSlBPNGxFNVR0S0E0djhFU0Uwdkhl?=
 =?utf-8?B?Nm03SUpzTU1vM2lUZngyUTRBdWNIQ3FST0hXME8rME9NMnU3bHhVd01ockQ2?=
 =?utf-8?B?L2c5OFZGWXF1cjZBYlJobFgwdEdZRUF6N3NmZXFMUmNVbkprWnBkZTdSQTRq?=
 =?utf-8?B?VDk0eDVzaysvZUVOZzRoUVJTSURZOTlnZmc5YzU0VmdjMGRHU1pPM3pLQ3FD?=
 =?utf-8?B?NTlDdWZ0MGJQVEh2UU9VR0FTRXEzODhoaWhkbFBka1dzdFRkYXNEWG9QNGtH?=
 =?utf-8?B?R09zdGlaaFlGKzJod2NzZHJHNnQzT3NsRDM2cWVRQ0NZVXlpT0hXNURKN084?=
 =?utf-8?B?Nk5JNWIrZkprNjlZdFZLREFBa0hRNjBSOGw5V3RVdnBpNm15ZW1ncWNVREFz?=
 =?utf-8?B?N1VCTnFhZldNZzRHdTMvMXVhYlZZamxqMldSS2tmOHRzWmxheU1WS2JTUHYy?=
 =?utf-8?B?MytpNXN1TEY4d1g1OGZ5Mkk4b0IxU1UxQm96V25yR1A2V3psZTFIZXMxbDBK?=
 =?utf-8?B?VGFTdHNhYWZmUm1ibFEvbUI1bTZDTU9FUmIrcUNJVFhra3puVzRmWWltOGRt?=
 =?utf-8?B?TXBZR3pncmx3L1p6QUwvQTVjS0VsZnFmUGxxSHZMUjZSaHFmdTRVNG5lZ1R1?=
 =?utf-8?B?ZytGd0V5a3p1YzR2VFZsOTl6NFJsS24yenR0anJVbHVQWEtWaENETHdqVWFq?=
 =?utf-8?B?UlRvakdvbDhyeU00QzlyK0xWYWxCYXpxdEtjYmhLYzV3WWlRciszZTdqdkhD?=
 =?utf-8?B?RWhhSjM4K3c3eFNSRHAxNXhNR1VndTZaRUNDaUVIcWliQ29XbkpzeU9NVDZl?=
 =?utf-8?B?UW4wVWVPNW5XRERpY2plV0dzZHhOUHJSMkZtZFVTdTdTVFJ4U2owc2dYS1dz?=
 =?utf-8?B?ZDgwWWVoUUFDdnh4UFhSaHorMkJoN3pZOUlhK0NQMVJSWVNTbGNGTmhYSWNG?=
 =?utf-8?B?dGlPK3VrSnN2Z3o3dHNrbm1KOCtRMEhCU2g0Sk42UkpjelhkTXJKd0xGc1BK?=
 =?utf-8?B?dVF4WXh1ckp1d2lTRDZQREFUMmVvVnpvQVRIWThjSUhvdExyU0pPdkNqQytH?=
 =?utf-8?B?M1U5SE1OeDBMTmR1cjU1SG1NMDVPRG1Na2JrNGRiOHpGSHQ5dUx2VTg0c0hB?=
 =?utf-8?B?ZmZXZE9EVzVkZUlveGpNOFM0Tml2M3JvNTB5MFZTZDRYTmFFczdaV0xpdE92?=
 =?utf-8?B?MjRmWUNlaGxoV3QzeGxaSHdnN3RlMllNajhzRDhvZVNKY1Z2b0pNcWV1VlhZ?=
 =?utf-8?B?VHA4ZGY1Z0llNFI0amlKN2FTRGk5K3RiQ1BIUTJONVhnVXlwRFhNMWNlNngy?=
 =?utf-8?B?eUgxSTJsNUhHSmhrT01Xb2NGKzZHTWtjNktHZkZRZlF1VUxLVzc2V1JRZENh?=
 =?utf-8?B?NWtaYXRMOWFtYjROTnVkbk84MHMrelpWUDlBbWhtOU9PT2NUN254MVl0T2Ru?=
 =?utf-8?B?Y1I5NWNlU0dGTDJTVDlncGVEOVlZdDFwbHVBc1EvTk5QdWZsZnFMaGFlOXk0?=
 =?utf-8?B?WG9COTRUUWlYZWNaR0Exb0pRWER5SjVDV0RUZ2hwQkltUGplTkF1eS83MWsv?=
 =?utf-8?B?T1ZaR0p2a1hyUjZwcHVmNGtRMExkcUpwZFhSY2RNRjY2MUJLNjlIU2R2cTFG?=
 =?utf-8?B?eGpVQUFkV2d6Wml5bUJqemR1aitRSHpTa3JpcGhSYUtPK0JPSXg4YXVYT3Yv?=
 =?utf-8?B?bDJRdlhIanRjaW50T0hBN0xZZXptK2YxL3JUQ1dLbUREVll4anBQWEx2Q20w?=
 =?utf-8?B?RDFSVjdXSUlJRElrYUlaZSt0V1A4ZjhDQzJXOFAwZ2g4OVFoYXZkdjErVDla?=
 =?utf-8?B?T1ZVZFZoYmwwaUFnS3lKZ2R2T2NMTnRjdmZsNC9qTVphakFRRzBGRElxVWww?=
 =?utf-8?Q?WPdUUClQWqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVnZkhmSXBMMDFiWmQ4dWxZMmhQU0UzU3FYMVo4MjB5REJkQ3NheDkzMVUv?=
 =?utf-8?B?eHo2UmcwZmpHL05CME5RMUI0K21UUGFaRTFGSW9od2NUUXZqN0xXK2dFMTJz?=
 =?utf-8?B?SVU3LzlxOVlPejR2M2ZjUlpQYVVuMTVZWU9UQWg1UVFzVHBxWlg2V29Vb0hX?=
 =?utf-8?B?aGoyeTF3ZU96VmIvb1ExeVZzbGhtblRVUVNOSFdSZDJjdHZDUWY3c0xmdVd5?=
 =?utf-8?B?THdLRWVuOWtmYTRRWWtMczd0NlFEeDd2NUd5UTN3SzBGQm01N1V5UEI5bXMw?=
 =?utf-8?B?WGIrSEhZUU9LRnJkRVJaYjBEZzQ3bFNiZGpVdnhNMWM5dDdaYUdzVjd2SFhw?=
 =?utf-8?B?V2U1M0lMWkpwenI0VTM3UGEyblJNa1NFY0l6UHV4TlBYYzFtZjdLZm9KT2lr?=
 =?utf-8?B?LzJsV2poNzNPR0ZtV3prWTFMekNNek96QkFCaXRvaGdSb0xzZmc1MjhYMmpo?=
 =?utf-8?B?Z2dhQWF1cUtrSlNxL3E4all5eDNEVm80NnhjSGtJTTBjRHUrb3hJQ3B0RXBw?=
 =?utf-8?B?bVVCaHI3M0lkTVlYZEQ5T25iVmhjTGhsT1FqaEMxS3l2ZVVZeFR2WFNYQWd2?=
 =?utf-8?B?L3FZamdMZTgxUmhtTjNuakgycUw3eXd4aXhiZXgrUkJMRU55UENic1FJUjln?=
 =?utf-8?B?LzRBQ3diZitWRlJQUmdSRno5aEhOSUg4VkNZa0tZR1pwcUJScXdsWDJDbkpV?=
 =?utf-8?B?VVdsYlM3M0UwVFZOWFJUQkFDUkFjYXhFNHV6cnRreGhlc0ZrdnZOUmU2MVhX?=
 =?utf-8?B?T0hNOG91TXdQaXM0UFlqZnpGWTRkVERzMFpZenA4aGFJblVGMTg1Q3BLWlNo?=
 =?utf-8?B?SGpqYXdzTXBqaVpoTER3Q3NVNFNlVGVXV1pMS25BMzltTFFjUXlXMSs0TkJG?=
 =?utf-8?B?MmFhbnhMbEpvcnlKYithT2F3eUlGZzJraEhWQW8zV1Y2cFY4YllUcjQxeElY?=
 =?utf-8?B?aEJyRXB0OWZkZ2l3MGdhME1lM0pvK1dOR0xZQ2FSZlV2VnphaFE0cXRSdnZO?=
 =?utf-8?B?R2w2bk9DLzNZZkdoSGZDMG82aFdIU3dTN3d5cW5rVElISEpOMURWeXJUR3Zh?=
 =?utf-8?B?a2E1WmxRNi9obGppZkVtOHBmTUJxUExYQkplSXpGWXYydjFlR1hPbHFocDZ6?=
 =?utf-8?B?d05aSWQ4RG14aWlGdzRMZjlUOWdKSGh3VTNtaG8zektDMTZONERKR0pYLzcr?=
 =?utf-8?B?YWlQemtUaXVTb09BQ0d0dUxjK1ZKWG5JU3plM1BUb2xzTnZXSGJFM2R6VTI3?=
 =?utf-8?B?N0FPQVBETGY3OElQSS8yc0I1UnVtdXY4UytTQVEza2F4b28rdXRDdFhpeE5i?=
 =?utf-8?B?ZGo2N2VMcjJzUnNKYTBCUEJnUEg2UG5qeHpmVUU4djcwUFVtSGxnQklZcTl4?=
 =?utf-8?B?Ny9YcXBFNk13OVdZNXpJZUpyWFJhUWlMMEZUV2hYRGtiNFV3TWwwc3AzTkcr?=
 =?utf-8?B?cXk4N0ZRbkVKamg2NlUrNm54djhNejdVWEdIWTVXcEwzeFFrYktweFh6MVJQ?=
 =?utf-8?B?QXVvcmtyQkt6VS8zeS9paGVYOHFsRXJFeVBTTmZ0WTFaNDRmaHJYWmYzTjBQ?=
 =?utf-8?B?WlN0NktjRlpyR0FjeTAzU1Nic3J1UXhQeXpJUGxnY0pWekhtZktvKzY5SVZy?=
 =?utf-8?B?dFBmZVBlK2NJUVNiSUo5blRFbklXcVRKQzEwOFlqTUZFVHVoaHd5VHBuWWRr?=
 =?utf-8?B?NVVsVWN2RUt1T2tBTXpPNWtzaVJNODltT2tieVI4SFlMV3lNa00zQ0dCT1Ri?=
 =?utf-8?B?TzJIUTFSUGNFTERBK0lOOUFJRjlGWnVsNDhzYWptaVFSRmg4YmxMOFZhekhU?=
 =?utf-8?B?cXhMWHVtcnM5UjJyUURBTmVGTWdMY1o4T0hvUEVVaU9NOGVrUVJRWVZyWm5j?=
 =?utf-8?B?enU3VllUcDE1SU4rNExSdEU5NEllR2t3TzJpMkloMUlQUkc0OThoUU5WRmVD?=
 =?utf-8?B?M2tvS2VZRUwwc3FMSEp2NEExU29hTXhyRzhzZU52R3NaOEt1QjhOR2FXZ1dy?=
 =?utf-8?B?Q2lsOVFiNDhMbGNEOHNubDFjc3FxTjNnRUlVWm9KWlljaWU4Rkt1Vng2bzVq?=
 =?utf-8?B?T2luUG9kRTFVeWtYN1ZQbUR2bmM5cFFTai9WV2pJREt6MVhlM1hpWTEwdndr?=
 =?utf-8?Q?V/SFa6d0MI6dle1Sv3iXhE1T6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b43d34-62f5-4b48-1bd7-08ddcddc9494
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:42:22.7267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJEgEQI/ciN1NBOkOx9DKMu29olaMkCuz+8UmUjkT/91FUjlEUHc5kU8Qi/9vHGPw2sJab3UM6y6dtd6PR4ABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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

On 2025-07-27 12:52, David Yat Sin wrote:
> NV10 mask used for gfx12. Fix it.
> Put back DCC flag and default mtype to MTYPE_NC.
>
> Fixes: b8c76c59987a ("drm/amdgpu: rework how PTE flags are generated")
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Co-authored-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Tested-by: Mark Broadworth <mark.broadworth@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index fb3fb31724a8..feb92e107af8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -514,10 +514,11 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  		*flags &= ~AMDGPU_PTE_VALID;
>  	}
>  
> -	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> -			       AMDGPU_GEM_CREATE_EXT_COHERENT |
> -			       AMDGPU_GEM_CREATE_UNCACHED))
> -		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> +		*flags |= AMDGPU_PTE_DCC;
> +
> +	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>  }
>  
>  static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
