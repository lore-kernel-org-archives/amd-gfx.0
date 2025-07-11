Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA911C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AE210EA2D;
	Fri, 11 Jul 2025 12:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="39b/IOyR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC2910EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS3cNGKQWWHlJ0yP9Ww/mgzvRBwhumJlZlaIPG85GleUzTLW+djr+s3/pF8Q3Wj+XRf24YNkH/9IA8AGWvvCVVN8mAvaSRA3mFGi+KO+yznFHCV4YqxEpEMijw0z41Lz/rumfA3UViAqYmMURZ+DhS3cn+GzCLfLqLTR707v5Q4wQwZ8Y4ySo3LcVXlikR0vqJAfdn0Xlp7Tyk3LCc2twUasuxpGRsuuE4/7QBjPAx+hzxKwAkhmDfi90V1PK1cJlsaZqaIZhO6kUiG5mPCYWSSMAW98i0sYGdC3i49rQoZ0RO6C3me4e/XtznZNfvWEKoKjbl6+suNyJyKFB7VxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq274qtLdhxtNSDfDVoDgLST+bml9+5JidbGZgmnCW4=;
 b=EK4SxMscxO74VzotLW1l6j/M39t8Tw/WjizPYVIo+n5bBehvK1dql7WK5uxGgAfVJ4+5iF8gvk9fblcsmHWVvxozpotdbbBaBeZlW+/sY1LonXLEAfmU1PZAz/bwnmIce4NgRhqGFr5tI3uwWEfDAiLVY/ZJ9eRmHKZIwmy9ioFFMkVqXz3xW4iGgi4kRfq+ZXwMpK5m3LUeJ7NskjAz+rvNp9Q877BjjT9VxtAwI6ByQYxvHoDqALB/y+KXk93HNS65G/br+JBy63qwN60NKbtVzIJDluaZ/5qQDs9G7ghwADLvwHiZbBMvh6/CFM+/WfxC5r2LTTpEkkTybRpgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq274qtLdhxtNSDfDVoDgLST+bml9+5JidbGZgmnCW4=;
 b=39b/IOyRCEC58xh6XREsumVwqi6xFHJzK4gw7JnKJYVWgjpqRBlBC2LeRLkxySPKVLtXEps/zmc7xxpBZKrufA1xWoAEA8V/v/sJEf0ZvuPp+l9M99COK2P1do13UPAEufq0rDC9vcJMwyJUBUM/C5PfFBGSPs2hC/2ZS57/F2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 11 Jul
 2025 12:12:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:12:36 +0000
Message-ID: <4e9bb1f8-2c73-40c2-96e3-cc186a476a5c@amd.com>
Date: Fri, 11 Jul 2025 14:12:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] drm/amdgpu: validate userq's last fence prior to
 destroying
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-7-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711093930.1411470-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f501fb0-897f-4682-49e4-08ddc07438df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTBRNlFqTDRJaHV2ZFh0djlQMXE5aHp5eWowVU9TVmJzcGJqRWVBZDg5bUlY?=
 =?utf-8?B?TFJPNXZtd1R0bHFDOFFhbUtFT2E3OUtCczJpN3VLVHB6SnRGUWVUNWZ0YmZv?=
 =?utf-8?B?SllMUnFDSFFsVDhTMEJHdlpudWcvNXJwdEQwUjFnL2NsOERyazhtZkg4ZHZX?=
 =?utf-8?B?a2h6YjA2NHU4ck9wZm5ENktQdWc3RHhTR1BEdG5ZSnNJUXFxRHNuZVd4eDE5?=
 =?utf-8?B?bVZhVi9vLzdGdUVNZnN1Z2lZY2RZZlQrLzZXRG05UmQ2cmVuNU9mS21raktJ?=
 =?utf-8?B?cmdROW9FWmFLdEJXaGZ5djZQYWRaNTFDeVZCdFY3Yk5wMVRWRXFxTExnRWpp?=
 =?utf-8?B?L08vZm5PUktPMCtIb1lFemZFaUlkbXdER0JsSGpjR1ZqYXh4aURBR2xEMG83?=
 =?utf-8?B?WWNGQW5IY1QvcStYYTRHUStEd0xuYUNNcndtQXRURU1YckNjS2lqMUdJY1VT?=
 =?utf-8?B?OGVQcmNPcmVuT1p1Q2FMWi8vRlVsaEJ5cXgrZEtVN3ZPRERxR0Jld3A3M3o0?=
 =?utf-8?B?QnlFRzVaeFVqZnpBOU5YYmFUQ3Z6Y3lsU281UTBEbVUwaTZnWmp5UHlvWU5K?=
 =?utf-8?B?dWlzWjRKZG1jYmZBU1pSVmYwMzBPVXJXK3FpS2FxbjVwR2ZZdHRsNStsWWcx?=
 =?utf-8?B?WS9sSDgvQ0V4d0laQVp6WERhUGVIT1RSQUtrMlA3M0p3SG9wSXIrUzN2QXRh?=
 =?utf-8?B?UWhrcjhrWlh3Y0FKUVRnOThRWC9leUhhMlFudGxQMkt1T3R1NytGL2NqUTB6?=
 =?utf-8?B?VjNoKzUxMWhmaDdJamxhZ0tMSGpoM2RqQzloMGRZdkJGQlp4YW9kTzBQWWRZ?=
 =?utf-8?B?cHRiZW13MnZ2USt1SlVSS2VKQWRNT2RVaENkUjgycmVGTGpxbzR1VXpCWkZq?=
 =?utf-8?B?cVNiV3pYTWhoUDBDN2FlQlFEdnpCcDVlNHpWYlN2VmZxcWJzd1dvZm1wNUYw?=
 =?utf-8?B?OE1rSVlIdUVRL2pvUEQzS2tIdFdHdVQrc3FNY2huVmhtdHorWDBDbTdlci9S?=
 =?utf-8?B?cW1WYVdxUFF6MTM3TnplMGtXY0lkMUFDVnVEdHlvWWtvMXJmazgrM2Y1dkNQ?=
 =?utf-8?B?KzFtZ0p5Y25PMXA4M05VdGIzQjg2T1RGcUovcVZMcTFRZGJoU3NrbGNYK2wz?=
 =?utf-8?B?MDhHemVMcGs4eEtFcEkvUzdkSzZIMDhkRVY2Q2dheUJUQU5wVnBHZnRONDNy?=
 =?utf-8?B?ZVNyY2Yya0ptWXJZbVlmOHdoS0wrV1d3S1lKU0w1RTlqU1R0Mkp3Zm9FV1Yr?=
 =?utf-8?B?UHdzUFZ6RjE1NkxlR0RWSlFKNnJQWmRzaGhKTWRkUitEV1JGa2llMkZXS0hl?=
 =?utf-8?B?RkZkd0ZGSzJyK01tNWF4eFRxQVZ1aEFHQXcxOUxFM3JRU3BiaFFaNjNWeURS?=
 =?utf-8?B?VzF2SDcvd2hIbDV3bkVUQ0kra1dBWU84VjZzSUNsMjNMdUhYWUdqbW8zcENM?=
 =?utf-8?B?VWJSM0RiNllMTStwQzlGaXBqZDdMYzh6L2RXcDN3bzNHOGgxL2xNMUJ2VVJv?=
 =?utf-8?B?UGhPMHpKdjE0eVRsUHJISnlWaU9OUm5aM3M3Ty9mVUdPZWc1SUV1NFloZDNV?=
 =?utf-8?B?MSt1Nk9ZQWgwYTN6K045VkFHOUUrYUwxQ0FwalJlTS9hUVExdG1QVmtKRTVw?=
 =?utf-8?B?d3Vka3dIOVUrdFl6ZmV2V1dyOThNc1lFQ21wMXFLVU9DNVBwd3JpeFJQUzZ4?=
 =?utf-8?B?dGlUT2xiSDJpRFdZV2kxZCtBakZJTGtFZzRlbzlkZFdkT2E3eFpmbVFlTDV6?=
 =?utf-8?B?MDBmUDE5emlDQm84bFByNXIwLzBKMkpwSE55cGZuNHBTczhPbkw1ekZXRGFx?=
 =?utf-8?B?Ti9hVzdXNzlzWHowRzliVU1vdGZITGlkWmVyck5CcVFLUlJnVUtlNndUcUNp?=
 =?utf-8?B?MzNEQ3NkZ3UvZFpBVVJIVHdhbHB1UmpzUXRGUWZ0TFcxRFJBd3ZTY2piQk1t?=
 =?utf-8?Q?+q7vgnhD8+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVg2NXlDSXlvdVBtNUUyeVR5Sit1QVdRdy9RaUpFZVIyZksyRDBKM3ZVL2Fo?=
 =?utf-8?B?enh5SzBpMFdRQ3NHbERVRlUvRjVINlN0dXNtOGRWNWt5V1MyY3FGalVCYmFL?=
 =?utf-8?B?Q0IydHJ6aUFHZ1dOOTFHSkNQbEhNQm9LdTBybjg3dGIzWnpJK2cvUkNHajlC?=
 =?utf-8?B?SEpCSVZmMUpqOU5FZXJLWm02ZXVHSEdIaHIvMExmTXNFcE9HWU80S3A0NGgx?=
 =?utf-8?B?SDlPb2hiZTRqMkt4L3dHams1TlRHVU9TckswL3RIdkdDWEtONnUvMFR3RlJB?=
 =?utf-8?B?dDJkM1o3eGI2M1grWE9vT1lzekk1M05vV3VmS0dOUjBpM1VUS2tzOXp1Ry9r?=
 =?utf-8?B?QzRqazMzTTJZZjRyRkl6aUFna3dxcHkreGdXMmRXZExSWWtXS3RoRm1Xa1Zv?=
 =?utf-8?B?dUU0WWNER3kxZzZPdWdCQ3BidUpGbWRyZHZzTmVsdk1hSEFaTnlGQnpHMUFS?=
 =?utf-8?B?SXhGZ2cyUXpsdGVXamlkZHFyZW96MEZ5Yzd4WlJiZzZwN3pabUlJWG9JT1RI?=
 =?utf-8?B?U0FGU0JPVDIyMFhVVVpEZ1lJcTVHWVozQW5mNkpZU2dmcFo1emZYWTNpcFVn?=
 =?utf-8?B?dlJPNXBVTUhrUmJ6V1ZoOWpJUEtCQkUxWWJ2NTltQUQwSWNlRENlczJLdExm?=
 =?utf-8?B?Q1IvcE5nVlBWSmQ5MTJwZC9Zdk9lQVNydHdmdWk5WU5RY1FqOHhPcHRoT3Rq?=
 =?utf-8?B?K29EUVk2TGtxRjM5YkF0OHVFQUtQTFJaa285SnlMOW91UDcvZWxTSlcyaEpP?=
 =?utf-8?B?Q0xKUmVXMGQ4YzNkbEVQSXhZRTBBNGdzc1IxYnppTkpyOGlsS0t4Ums4MnhW?=
 =?utf-8?B?akIvdDBId1RBVWcwWCs3b1NpcllLTnp3bHNEZ2YvU0ovRnpTTmNDd1NYYmxv?=
 =?utf-8?B?cW9ZVnJHQVJIWjAvaDZOZ2hhTmZiOVBvZk1TQTEzaFNwVTZFNGo2N0ZlWkpp?=
 =?utf-8?B?WVRyZkcvTS9SeFdBalFobUhFengrb2I3ZSs1WHlkZ2hHZzRFRVplcVdkMnkv?=
 =?utf-8?B?RzBKMGR6a0htTmQxV2wyZUZSQWVYL09UVEI5bnJwNzRxU0dYay82OVJsR1Nr?=
 =?utf-8?B?TmZIaWdza0wvWC9qNGt3WS9LZXY1dUlPS1dtZm1aaVUzMmJBR0ZmK3FmK1Fy?=
 =?utf-8?B?V2szbkRQelhIbm1tSDNkbHEyN0RhQ1FqSGFwZ3ppN2ZLZWlaSENNMktpZ1Zr?=
 =?utf-8?B?YnlVWlRUaXArdHp2N2dkb2d0Q1Uwa1FOTU9QRlhFY1dNK0xCR1VtMjJKeEI4?=
 =?utf-8?B?N29vWFgzNVpRVUpVSUtTQVJVUGVXNmhtRWtFRjRwczl0dGRJOWhlMDlpWFpB?=
 =?utf-8?B?YWk0cUhhT3doaDczL0FlSHFDU3l4bHBqQmEzckxLL09Qa1JpNGZxdDZKMTVh?=
 =?utf-8?B?Vk1Gd1JUQ0d5NzRXS3JTK2JnN1M4ZW0rVEpkVmhIdmZERFhGdVNZZ1pkYTVu?=
 =?utf-8?B?VCtlOHZWdTN1eHhyMG5CRzNPV0ZBNmM4cHY0eW91UU52OTV4ZnVpb3kxUHRT?=
 =?utf-8?B?TFdoSDUxQ0diUld5Q3JiZEFqQVhVaWt0cmVtNG5RZW8rMDJOQzVQL1hwV0xD?=
 =?utf-8?B?UzV5VUF4U2pCdE5nUm9rVzFkbHo0RVJBRTlXZ2FzemtPdS8yWDlkeGYyS3RV?=
 =?utf-8?B?QjRXbnI3andtVUY5RkkxRVEwWWlBWDJob1dUd0l2dFVySTVJNWtKQkpwR24r?=
 =?utf-8?B?T1BIMzRIZTJqUDdKcXNHcFZqdWFnUTNBMjBuczFnVVlQZVZseGw5Nzl1a3hN?=
 =?utf-8?B?VTJSSnJBMmRYckRLb0V5TFByV2s2Z0ludXAxM013OWJ1N2s4dzBBdTRpVFQr?=
 =?utf-8?B?Rk8xMXp6TGxCdGtEcTN3YVRQaUprbC9xZVdBL0t6ME96RDdvbStkcy9HV2R4?=
 =?utf-8?B?MnlZZGlNcmZGL1pqY0RQd1B1cnhwT2lHZmhOZkhDNHJwSFRDWXU3YUN5VDBC?=
 =?utf-8?B?ZTRyQXZkcllJNXo0RnYxYnZFUzU0MWlGNXZkN1UyU3Y4VkJZSUtZdCt1R0lQ?=
 =?utf-8?B?L0d4Rkx3akk0ZEVWTi90U2NpKzhqT3R4M1BGeS9YUnBJTFRkTTZseWtDRGlm?=
 =?utf-8?B?QldFNzdMRUNKb1dvYUMrTGRJeUZoazZMYXE3YWtKaTBBcTJ0cFZMNGNYYW1Z?=
 =?utf-8?Q?tNHRAo/sXb3z96agBqwgjfZBv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f501fb0-897f-4682-49e4-08ddc07438df
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:12:36.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o0WZfw0wKVpxxG+4zLBx1wA9w37nAirf89+yi5xaiZl7vuNZwEh3i81g5ybzr0K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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

On 11.07.25 11:39, Prike Liang wrote:
> The userq requires validating queue status before destroying
> it, if user tries to destroy a busy userq by IOCTL then the
> driver should report an error for this illegal usage.

Clear NAK, destroying a busy userqueue is perfectly valid!

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 81fbb00b6d91..bcbe8d3f66ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	return r;
>  }
>  
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_usermode_queue *queue)
>  {
> @@ -290,10 +290,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>  
>  	if (f && !dma_fence_is_signaled(f)) {
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> -		if (ret <= 0)
> +		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> +			return -ETIMEDOUT;
> +		}
>  	}
> +
> +	return 0;
>  }
>  
>  static void
> @@ -509,7 +513,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		mutex_unlock(&uq_mgr->userq_mutex);
>  		return -EINVAL;
>  	}
> -	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
> +		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
> +		/* For the fence signal timeout case, it requires resetting the busy queue.*/
> +		r = -ETIMEDOUT;
> +	}
>  
>  	/*
>  	 * At this point the userq obj va should be mapped,

