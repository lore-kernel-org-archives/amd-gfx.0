Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BEACA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 12:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3163810E172;
	Thu, 14 Aug 2025 12:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j8T0o/GF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5682A10E172
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 12:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZlo8zBK+O9nWo7bl8fU3FPnQU3i3dcOtlALvHuVWUzgCr1jfKUfjLY+rx0nCMKHitVYCwxSrRRFvQfDtXPTXjqY5lK89Vb+vtAiaHK/2BgHQkXN65JSJcloynz7zc0+WOfEFGada8UkRqL0uxELDqegz1rcIVPNMO1y07DdHRDCc9bzhAs0ECwqalrCwXXB3JGuXQ+HMdJrQxv0wNFUKEhhJyZswCBq+CKibL0HT188/WVefhBq1CGSiPV8pcU3a6jHAMwF3w7THbVc+77MvNBOLDuOCY6oHLiX+L4g4r0ot3ZD6VujMY1/JWkrHEEaMRnD4nsFGF1RRDC0CKpODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnzllDTxNVyh/yJs6wiFqNkbYT9f6ELOV+sdc8f4fbo=;
 b=JEEunI/cbpAavpOgq+/yGDHsc+U9yiy23LfERxMhWtLSfTNmgKGTlGGWvm2frtPxAoMDz5ECQ2NrI6rRHg5yokOADE4BPRpbShguJLhHpfLG0gg2E6ty2G4n5vmJon1py3+Mu9zgxNKNqokRW63yNDEKSZonO8bqxw+WK4YLFV+9Facb/yMrKL2jlfY7Q8UoNxoJk5UhsACe8Jwh+LPI+9TeLMleW4FL/0Z0NCHwpF7o++k9idXQBlABHZ0Wv+az2vL2QfyXbJKFVMMgzZ78qtnrmwnIIovE0SQsRr0c0QXiwSIbF5y7UcMLVtSYhg8TntaOcHlRwVBgJA/GqNx8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnzllDTxNVyh/yJs6wiFqNkbYT9f6ELOV+sdc8f4fbo=;
 b=j8T0o/GFDf1xfUwshrxmQ6xgGLeIf6d6s5MNPtTRAqvijDXTZFTaxQ9rWyfMdKNSuaUArOjlHvkhVKs2B1fuQwcR7Gh+oaz4JW7ZUuVwnFVgB6q1pdPDBMAiGDoBKH7EpDa1QS+9BtDdJnCoWPyN0DzO9G6J+49WJ9ssqKZYK3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 14 Aug
 2025 12:19:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 12:19:07 +0000
Message-ID: <f52f530d-18e4-4bf1-a5b4-bbe02e136324@amd.com>
Date: Thu, 14 Aug 2025 14:19:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add more information in debugfs to
 pagetable dump
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tom.StDenis@amd.com
References: <20250814081248.1336050-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250814081248.1336050-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0408.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: f42ed860-e622-41ea-6836-08dddb2cc459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWtjQ3pOZ1lsUlRsVnZ1OGNtKzUvMC9KZllrdE5mSnNZMVFUNklvMmJMN3d3?=
 =?utf-8?B?NGpBdUJnRnRwODdsQVpGL2pCU1pUY0ZuN1pTWml1YXUzamRXLzNvL04rVHNE?=
 =?utf-8?B?Y0l0emhrZmk0cnd4cGtNSGR3SkVCejZuUDBNQWdIMG8zWG5wQVk0MEdJRUsv?=
 =?utf-8?B?Sk9uUEdGbUFpTmVaWUYyQmQxMFI3YWNkRFdldlpnVlZuM2lyZ2tEYlRlaldI?=
 =?utf-8?B?R09mTUdvY29yQVVTQ1ZCcEN4ekRxZmpQdUZsNTRRWkxIV01QUE9jMGpxbmhL?=
 =?utf-8?B?UEpoc1BtTjQ2cmxpdnQ2VFMrN0RwWDJsb3Nsa3BURXhRemhrRHIvenZTdTYr?=
 =?utf-8?B?YnZIdzhWVE5RdlNVMGxpWXlXc2VoSHhHZUVJV1JlcW94Z3IzdVFPcDhsUTgz?=
 =?utf-8?B?STVKeEt3cHZBV3ZUL3pkcFc4b1V1SXQyQjY0TUdWOFRRdnR5WUI4cnlNd0Q5?=
 =?utf-8?B?ZExXaGU1V2c5OXA4TDcxOEV5R2VuMjg4S0haY1RUWlFuVGF6T0V1WVhjWnZE?=
 =?utf-8?B?a1Q0VGFwcWZvWmhNMCtNRVpHaWpsRFFJMER5bStyQzFqc0c0bzBHS0hjYjFX?=
 =?utf-8?B?a1NJRFIxS2hFRFFoYkZWRXBrb1hxS29ZZXBxZnNFaU5SVHRhV1A3K2VqYjhi?=
 =?utf-8?B?WWdPRk5USElGcEkwRGo2YW9nclBpcElDT2QzYU9kdjF3QU1TelJnWXRJTG1X?=
 =?utf-8?B?cUJZNzc4b2dzalVkOVJRb1BWNEdNWlB4M0pQSFFBc0FyTU1kVHQxNHh0di9B?=
 =?utf-8?B?RW5IQW92NGtYSWFSZmEyZGxsbXhjNGg2R0RXMjNtVE90dy82RGsrWmFxTXZI?=
 =?utf-8?B?emV5ZmwvRHE0S3FWaExiZ0xkV0xGVEUrLzdjTzFJV3IzRHgxYXpPN3FYei9s?=
 =?utf-8?B?MGI2WmkvUW1kSUQ3d01oNnUwZUhRa1JjcDBUY0FzSk5iZmlGOGxZdWFuUHFS?=
 =?utf-8?B?aU9SZk15Kzc2RVVpdFNBZ056bGlyS2ZDcys4OWZsdEFGdGtaOUpXK2ZvQ0l5?=
 =?utf-8?B?YzcxcUMzNTBpNFpZUlVCMDFmTGNGc1BQLzR2Y0Z6YXhpT3p0aUh1MWJPRzY0?=
 =?utf-8?B?WHowOWRsT1M0YnNXeGtSdDBlSVBvRmZpaXhWbXMvLytKSlYzdTE0SGg0YmN4?=
 =?utf-8?B?MzRYQUVEV2NLUVJEMnFCZ0c0Y3dEbWxnVnhsSytrVUJuVlVOaXNyWXlGMnNP?=
 =?utf-8?B?ZzRuN3RRU2ViOHo5ekdyNm5vMzNEZi9BMkY3UTNpQ1QrZldhbUhkdC9zQWVO?=
 =?utf-8?B?WWdqVGozOGdadmVlOGI1UkVsQy9vZ3lBNmM4L3V4SnM1M0RYRHNSV3Nka0VF?=
 =?utf-8?B?YngzWDlzZW9OaE5EYytzM2s5Q1J2dUhFRWx2cC9HaU5jeXAwTHlNd0xJTzZB?=
 =?utf-8?B?c1BFZjErNHJIN0xBTUh1M1FpQ2Zrd0J4cW1VTjBYV1ovMXpXMm83K0RTa0lE?=
 =?utf-8?B?K1lZbHlMU2FFU0VHTFlNZC96V2owSWJmV2QxeXNFOHlMZnZ4Qk1JU2IrMFI4?=
 =?utf-8?B?eHBFNWc0Y2tocHE1ZW1Id2FuVldNY1FhYkY1VnNVQncwNkVja3ZxS25mYXRh?=
 =?utf-8?B?NlZSRTJoUjZmNDlaSnR5Vmg0c3pMdVZVR2ZXSmM0UlJ1emcrbks5c1p0QjFs?=
 =?utf-8?B?V0xvMnY3RERDVTdOOGJRN0R6NldyUmQ0YTdTUjlnRldvTWYrUERablFvOHFn?=
 =?utf-8?B?NGZobFFVcU1KalVWRTVUTTMzRDNKanlwbDFhZ3FEMG5VcTQxOGtEbzZHSk1V?=
 =?utf-8?B?UjJKWFVZUlI4YVRlcS9BaTVDOEc2MWdRRzc2ZDEyYjBJYk9uNDlMRGhocTB3?=
 =?utf-8?B?SHJzQlJlemZQeG9odkxQSytmT2w0NitkTjdWQXdQeGUvV3NRSXc5WW1FWHhs?=
 =?utf-8?B?YTBMZlNnTE9UTkx1UktBTmlwbWRxdU1DVFI0YjYxOUt6REsrd0JBY3p3d1I3?=
 =?utf-8?Q?OyGquLLp5nE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFpUk9DK3BNREVhNGVvUUVyTFZONGVRNXFRUDlSS3M3VlptdlFFSjgwbzFF?=
 =?utf-8?B?US9LOUxtWUpSV1BVRjhtSWZJblhyTjllSE11d3NhNDhDWUN2V29GSHArS21D?=
 =?utf-8?B?SkdwMnVWcS9aSGdFUk5EVEZkeVZER0FmU29CR0k3ZFVicUFuTVNRTml1R3FZ?=
 =?utf-8?B?MWhPNXc1UkZyL1VjN3lZRFF3cUN4Y0RqOXBLSERXSzMzQU9HbGVqcEJGdWVK?=
 =?utf-8?B?TnpsNGhBWkpKbGo3L1BjMFQ3bnlDeGRuL2Q2S2UvR25HbzVEZ0UrRUp0aGRm?=
 =?utf-8?B?c3BVcERMbGZIZVl1MnBGSHY1Z1Y5NVc3TnNzOUZIQ21mamluWmJNSnhpMGdG?=
 =?utf-8?B?QkIzM0s5ZmxucWpTem1DdkY1NzF0RVprL3FUL1ZacGg0VGsvUlNLbDRQbGhq?=
 =?utf-8?B?dlVTTUFFVnJkSWxoQ1FOVTBEc1hnVjdVQnhJTmtjeEFhUDh0dDh2c0pHRHJQ?=
 =?utf-8?B?QzQ5R3NrZ0JGa1AyMlpFUmFodUUyVEM5STFmek1NU0R4U0JTQlQxTXVDV3pu?=
 =?utf-8?B?OU9iODAvMkcvL2FHNm9lcCs3L3F2cXFvS2FudURNYnphSDYvZ3NKalpHMjZC?=
 =?utf-8?B?aWpVYkZ4R2FMcWxKWTFzTmIrL05STjl0VDA2a1g5bmJEMXVPM2FaOWxwUkFT?=
 =?utf-8?B?OEEyNzlSSmFqK2VWTHlId01EbnF5UWgxS3AzUTF6bk00WnZCKzNtZzhabXJm?=
 =?utf-8?B?ZFZkWHRhYzdGM1ZtcmVPY1NhVVVSSFhNUUpHSi9vZ2taNGY4Yy9McW0xdXBF?=
 =?utf-8?B?cnBla3pKbHBzZGd5KzI0VEVkVkMvcUoyT3h2SWIraHYySjkvTEN3N24vTnMy?=
 =?utf-8?B?Q3RHbTY0OEJJS01TZVBoanhscHRIWWFuUW9jR01rcEdJb1p6eUR2cHhsa0g1?=
 =?utf-8?B?Vy9YcUhXVTV6QktuMms3U0lBTHc5UmNZbWFWN1o1TlEyeGpnOHIyeTArRE0x?=
 =?utf-8?B?czJhaXJnOTlNVFBHY2E2UjdqWWJIOGE4WGtpTkFYNnBRQ0EzVm5wL29HNWRT?=
 =?utf-8?B?K2REQ1pROFYxQzF0SS96WFBJSFpib0R6bkx3aGtwUlJ3V3gveUE4YkhMRHB0?=
 =?utf-8?B?TFBBam1GVFc0SjJ0aFZvcGZ3eS9JMW9vbzBDeWNDMFZrQ0NGUkZ4bU5WYTVS?=
 =?utf-8?B?czFiKzBZaktQc0QvSG9MWGUyK2lKMUJKWW5HbEcrQy9OSFhKUm43YVM0UlND?=
 =?utf-8?B?TnpsVDJoNDF6NXVrai85WGJTTHNhM0R1UWtDMmNJTVlXYVU5QUNQS0VaQm5Y?=
 =?utf-8?B?dnFWbVBaVVdabUVLdjVEL3NoRm5ob3pCZVB4dm1hbld2cW9rR0hZUkpqN1du?=
 =?utf-8?B?UUVZZ2gzUE5oTC9IVzI4Nk94a1BpY1hmZWNvcjFHeTFkZi9DbE9EdGdrb2U3?=
 =?utf-8?B?WUdyZWs4WHhXWml1RkxGU2w5Wm9pbTNRYVk3bEpQSnlFT2czU0RNekxKdWpu?=
 =?utf-8?B?bUpJSjV5NkxCcjZZOXAzWXJCWDhvQlNGajVGRkhqb2xPSlI5ZUwrakQxOTNX?=
 =?utf-8?B?K3RvaVZ6bmFHUE1uNi9ld2RnZC9BSXB6WmZlWjR4enQyS2tPdWxuaW9KNTBN?=
 =?utf-8?B?TTBzdzFFWG13QlBMcXBUa3pSSGxNL3RYTUlVVjJ4RlhuYmRBS2VNS0JIeFhi?=
 =?utf-8?B?TW8zTlorWXFkN2hxdmZzS2xJZXhQRjRpdDhaK2MrN1kwa2ZwcWhuRjJCdkNH?=
 =?utf-8?B?SGdZdnQrdFc1amkxKzhobEU4MnN3RUc4UTN0MVBQVTJCV3lOUzZySFJUMWF4?=
 =?utf-8?B?TlpvYTJodFBkV0hMVW1DQUorK2tFUTdzeXorb0hQVktTSCt5QUVoUjZubWY2?=
 =?utf-8?B?NFNiU2t4NTZBRGxOMXJDbU5KVWtRL3JPQ3V3TlhNbE55ODhGc1VKQTlic0JG?=
 =?utf-8?B?NHlIVFVYZWtTTytEUklkakdEYlh6bzB1Y0g4UzV5VVU0ZzRrcXdiYlhJTFdS?=
 =?utf-8?B?d2pTK2JqRE00Z2Jkc2xSRmhmRVhUUzJxRVpWME1COUJ5azZOMmU3Q1I3ZTdI?=
 =?utf-8?B?T0M5UytPVzhMQVRXdlBiaHpucnNodzQvaHVObnozOExPNE5Ea1ovVU8xZ1Y0?=
 =?utf-8?B?WmhiSlZsNHVDYUZtYUU2TlV4UlFxSzE5TjV4VjhpL01aL1lzcDcwMnpmVVVN?=
 =?utf-8?Q?FDM9DtmMEdr4UuMrTlS2xf0ct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42ed860-e622-41ea-6836-08dddb2cc459
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:19:07.8753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG+BE1QTjWdOUP7RuBcfX7BTVEEdNYFfD3qpWeQc6vf5MicTq5dshZyKtHil/i/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

On 14.08.25 10:12, Sunil Khatri wrote:
> Add more information in the debugfs which is needed to dump
> a pagetable correctly for userqueues where vmid is not known
> in the kernel.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 63cd790b1d7b..6d52832fa9b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2136,12 +2136,14 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
>  	struct drm_file *file;
>  	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_bo *root_bo;
> +	struct amdgpu_device *adev;
>  	int r;
>  
>  	file = m->private;
>  	if (!file)
>  		return -EINVAL;
>  
> +	adev = drm_to_adev(file->minor->dev);
>  	fpriv = file->driver_priv;
>  	if (!fpriv || !fpriv->vm.root.bo)
>  		return -ENODEV;
> @@ -2154,6 +2156,10 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
>  	}
>  
>  	seq_printf(m, "gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(fpriv->vm.root.bo));
> +	seq_printf(m, "max_pfn: 0x%llx\n", adev->vm_manager.max_pfn);
> +	seq_printf(m, "num_level: 0x%x\n", adev->vm_manager.num_level);
> +	seq_printf(m, "block_size: 0x%x\n", adev->vm_manager.block_size);
> +	seq_printf(m, "fragment_size: 0x%x\n", adev->vm_manager.fragment_size);
>  
>  	amdgpu_bo_unreserve(root_bo);
>  	amdgpu_bo_unref(&root_bo);

