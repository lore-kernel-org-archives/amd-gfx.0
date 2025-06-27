Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AA9C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 19:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD87910E484;
	Fri, 27 Jun 2025 19:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIFYLZPg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D9410E484
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 19:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyYIqbgE+QQft1OFZv4mJXct1H0DAjaWfauhVsBdZYQFU9q78Ud8LnBYs0OfH/C4onKuvqEhJf14UaIlSertEcd02m16cp1SkvRk+9VxpcJhWCdj+hu9xIscGkIWUNc12M2r+zdUWvmce5HkjxF80lxDF8hTeQna03lxv+dyzRqbKHX9KmRRPrPcaSphzxCOI6meXFiOSHZkPAICjlZxoU/K4tMpg5dC+12rMDorVp/wtac79krcC2PqsiqNkl3umQnhMxKFnC7GIds9A9XIGAgXltaO4KkZ5NDzpCGT15juac6l9LfyfJIoakER5ofE0L+U2eUa4o3McqJgYL8s1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5VRAqvclg4oJ7VyDkwjAPEnuveJRNM+rpv0gp0hbj4=;
 b=KWAaU0TaDxDGcDMALzx09MuuyuHbbI+wj360+RgTMr+G0Dz+BefZ2qqNgiqxbAJvblLVsYqnHVYwIWSaT7IFltdiq3ydedUUbQ2uB/bh1fseWwo3sSj//FfB4N1z9z/sgkts6leenltueEp9iBDEkREGZg720RhRAaAn/CV55TRkKogeAmN+FUm/2OQHrBOjft1Y8w1/DZqHiogXJDQmxgqKHgbFwqznkQT7vsrfy0sFFOX5UeCbPrklvSZeSF5Mi6UEssknbS5J7SBAvjIgm153a6qUD+44xUQOd1B9a5CGi7jnFbybkZwXO9L+Ubl2aoJyjif4/VNbv0LKYqYzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5VRAqvclg4oJ7VyDkwjAPEnuveJRNM+rpv0gp0hbj4=;
 b=uIFYLZPgp6qmI1vx+v0AlU/iGBhGzNUrO9uiwu4pG356I1d6uhTIAdKrCeFLax+sGG4vPoK7O6EzDHOVd/Vcy20SKn9vE3qm1qUdsWWBGtT0a8PAYeMamxY4BIu003ZAcBFQgyzI1/qL0NhHO4Xukosd3+S3zHIjEICXo7pfknY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 19:19:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 19:19:24 +0000
Message-ID: <6e025c54-e1c8-4429-8022-7021af72eb0d@amd.com>
Date: Fri, 27 Jun 2025 14:19:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add helper functions for isp buffers
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com
References: <20250627191422.353939-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250627191422.353939-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0152.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd8a48e-502e-4830-9ce7-08ddb5af86c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkR0YjI0Z2xoMWJ5ckdGMjNMUnQ5N3dMS05CQ1h1YkNWVHIycXVmY08rVW12?=
 =?utf-8?B?a2N0UDFHOFYwVFNheHJ4ZHNlbEExRVFTR2VmLzNEUjVEUkhWNm5qVmtOTEJz?=
 =?utf-8?B?OEhGUWpoMHRqeVlxc1g1S1ora2ozS1BNT0RoRjBobDA1THZDTTNSS25SdU9t?=
 =?utf-8?B?cjYyMDBYQU80QzFnalc1V09vY3NYdXU1TmZvbWVVcCt5OEp6bTNlRVl5Qlpp?=
 =?utf-8?B?UlFENWpUc2dvU1lWOTRqc0VCSldrRkp2eHQ3RUw1eXJCaXRjQklQU21CYTJO?=
 =?utf-8?B?YU16OVdxcHRKZ1d4QkJuRGhYZnMyZEdlQlJhSVVwdzYzODhsQm5JTGdzY3Iy?=
 =?utf-8?B?OGxjN1o1eEtvTE5zdTM4T2dGSDRYNUNTazVwejYzdDhyNCtRbkkrWTgvdkpa?=
 =?utf-8?B?ZGFOeEg0LzFnRk1OZFkwVU1iWnRnSzZOOUJCYlpmVkJmRFZhYWtZOWlaWldZ?=
 =?utf-8?B?SVhUQXNMUUY4WnJvaXUyZmdPZXJjUDYyZkxENm12T0lpTlN4WkJoL2lFcXNk?=
 =?utf-8?B?amN5Vk05M09UWmlKTG9xcDZWRTR6Y0hTU3dtUUIwTXV1MjJCMDdmUFlqYWZ3?=
 =?utf-8?B?SDZBaVhONmNhNlVzSVF2NGNoYXQxUUpNQzEwa1JhUmFFcytGNW9xTnZXckdq?=
 =?utf-8?B?amx1bXByTHdhOEg1T1FQbmpFY2pwYkg5Q0JUQ0RuUTJxaDA4VmZvOTJjS3N6?=
 =?utf-8?B?TDlIQ1VFd2toamxsWWFReWZVRndzQXZtdHQyUlNQd0VJK1FuWVVlOHVZcjhL?=
 =?utf-8?B?VExoU21BZU4vWUtjWUJLSmNZOGZ3NzZwd1BiYWNGeWNlNG50UVNMbC8zVlds?=
 =?utf-8?B?U0YwRk1makVzeTdKSHJXSnFmYkdFam9aMzRNOUxZMTFWejByQWIvcWhpTklK?=
 =?utf-8?B?eTB3VE41SjlmVGFUWWxDUUFiUEVwaG5qU0Y0di8zZFViTFdSYXNtTkJWM1Nr?=
 =?utf-8?B?YkJEb1c3dU4zZDQyT3daWlpxcmRmTkxvempYK1Fhd3lsek5SZUN5OElMd2ZD?=
 =?utf-8?B?Vkp3QnFNUWpGT0NlREp5Rk9sWTI1VC9YSm1MSkpjVUFTQ0gyY3dCUjM2MzRB?=
 =?utf-8?B?OEJZcDJDUnMxK0hWT0hJZWVhdHZyNi9HeFhpODc5eS9FWXNtZ0tPcmNDWWRn?=
 =?utf-8?B?Wjg1WllLV1RmbW1VSGRScjhGc3JWeE8vRkhkaUV6TDJrRHNWRnZWSnl0aU9O?=
 =?utf-8?B?emh5UnF2S0w3QkNjRFd4RmppUzdnSVFpSXFCR1RVMW4vQkE0ak1OWjB1Z1E1?=
 =?utf-8?B?bnFFcWNrQUxtT0g5YTVNbXQ1bnpERGozL09wWmtFcUQwMTZUVTdyS2hWWkcz?=
 =?utf-8?B?d2hvRW5YM1NCNkdXTlVwU01HSVhIVzBIZzIxTFlYdUJXckdVN09PcDRHNWRS?=
 =?utf-8?B?L1AweEJ4RzJsY0YvZXRmL091NHRERXk5WVVtUEZFR0p5WVdsdjlweS8zVUZ5?=
 =?utf-8?B?NWV3MGVFUFRRVFBnSGVFQkJ2ZkpEaEdCZThIU2tPWkpEdHphd283WmloaXMr?=
 =?utf-8?B?ZHNZS05nN2xSSERWWjdraTgycDVFK1cvMlRXVDM0V3dJTjFJTGszL1Zvd1o5?=
 =?utf-8?B?TnVzOU1RTDA1U0VKSU1KTnpMRGZUcGpEWVRSNkRtSlFHYlpIWWtPZ3FJU2lL?=
 =?utf-8?B?WVJFRkdLOExIdVpOeHlKL0MwRUpBd3Z6anduTHhtVGhzbkVvVzhnR3BKSzU2?=
 =?utf-8?B?bmZGTHlobUI2UEcyaTF0TFMyTWVyWHJZSUIvTk1oUnp2eUUyMDBkOVFLVXFU?=
 =?utf-8?B?SmVHL0x1Qy91NElUVnR0V2F3dDlVelBUNmNpZ2pGV3hHbkVaMXlxY0FHaC92?=
 =?utf-8?B?cHFqM2EwVytUZ1NrclBmMzI3YXZBMER1dHRrSCtVNW5WZ2FOYmpyT3orMlds?=
 =?utf-8?B?ZmcrUjZucHpjYjVtZHhkQXBQNjJCUU5ScWhLWE5HMmxRc0ZxOWlTM09ldk5w?=
 =?utf-8?Q?/JPoV1fJPZc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhlRGRJQU44dUNsdXh3bkY4WkdkSkp1bzRURzJBaG5kMUoxL1QrSUtTWlpa?=
 =?utf-8?B?VFkzbk5oV3M5Z3RqYmlkR21odzh2V2RvNGdQREt0TzlNcEZWNG81dm84Wk9O?=
 =?utf-8?B?R1A3YkxYQjQvbkxWWTRiRXZiaXlPQ2dPTGwyT1IreHNHNXpTU3U3L0pIWGlk?=
 =?utf-8?B?d1lscVFVUzNFaUdNTGJVVURpbnQ0TG5iRTdDelpsQlR2dmg2Y1RMa3IwZmZ4?=
 =?utf-8?B?YXoyd3gzcnJYSDVWT2FPdnVIdGwvamZiN05kcGNhNG1NZzFJT2pZRXlFeVRj?=
 =?utf-8?B?bm56Y0NqK3FvU0NQTTFqRHFJWTFrUGZJN3FQT1VBQW00OHlRZXV2SVl0ZS9a?=
 =?utf-8?B?ZkZINjQrYS9GYlJVUmNsK3Z5YUdyRFVCMyt1Sk13b3VybllqQk5BREQ3cmht?=
 =?utf-8?B?S3dXbnlpbDFlSmpTSTNrMVVRanFRVW9nMVZxNWpsTTBpdkU3TTEvWllKVWtp?=
 =?utf-8?B?Y2tmVzdTMEN2MTFla1cyTW5VbDVvZTBTSXdZbVlUYTNGaE5BMlB6MUZxaVVm?=
 =?utf-8?B?TE8wcWVRM1J4WlhrYXBhSEtjSm51eTZNM1ZwMU1xbkpualNEZUVWK1RzZjQr?=
 =?utf-8?B?VThXTmJUeVYxME9BbytQU1NhS3lPQXo5L3dGdkhFQThsQnQwb29uUm1LZUl0?=
 =?utf-8?B?UEFkZDNUMWlxUUtIL2xoTTR0TGFSdkIyanIxNFEwMlcvZytzS3RJSTNEVkxl?=
 =?utf-8?B?QWJYbWVkQy80RDloVEhDWUZBSnhOb25obTdrWHBPNzdCZ3lKaHY0VWFhazky?=
 =?utf-8?B?ZkhkWG9rbEVlM0drUjZ6RmVVYWFxYkl2bGs3dHJrMjRoK3pnTkRYcCtJQzNL?=
 =?utf-8?B?b3FjOXVOakRNa0U0MVBnN2VqN3R4bkRDR0xyYTlqYmV2NnlONzJUaklWdnVt?=
 =?utf-8?B?RjhaMVJqelZ1dkhySDRPVDdVOVV2eVFnUVBpeC9RZ2k5alNhcG9LQTNjRnhO?=
 =?utf-8?B?anRvdGRyZ1lyM24ybGpIOGZDSVgvWjFCMXI1V2xsTlY3Mm96SVdZSW1KM0h5?=
 =?utf-8?B?T1M1YjM3Tlk3bmJLOXE3M2M3RjFOcWxGNlZLa1J1OTFVblMrQzdvWllucDhi?=
 =?utf-8?B?TlVmSFNIY29hU0N3SFh3VHdBbXhWSXVUVlFicy9MQzZweHA1bDFvNEtBQlhv?=
 =?utf-8?B?VkpOWHlPMkVndUJrWklsRktFL3p4YkNKd2JBQmsvaWhRRHZLb3BxMWVQWnB6?=
 =?utf-8?B?QU9mSUtqUzhDc3pqT2x5TFBOTGtYd2ZWOVdhY0o4TUlPaHB0RTZ5cHY4MHBT?=
 =?utf-8?B?M29saWJKeXdTK2xzTGhWN0NsbU51YWpRRG1kZkNObmdGcUx6c0FPeGlWNVNn?=
 =?utf-8?B?UmxWMFdjcTBLUjNpcmVnWDNmLzloRlF6UHhyY0M2S3BhNC9GVUZ5WGR2eTBW?=
 =?utf-8?B?Q1FXVVpBaENJRGlnbG1ZMWN3dlJidFYrVXZLR1l2YmpCQWhwSlUrQXlPTFZx?=
 =?utf-8?B?OVRMRXEvdUxRWU9jS3A2MmV5QXNmaGtieGNBRitoYldiZ01DS1BtdWlSdSt4?=
 =?utf-8?B?OE1rTWdYWk5nbG84Wi9QcmtaMFpJdTZWK1NGMUVVbmZRVnAyblZ2RHowWFp6?=
 =?utf-8?B?cVdKM1Z2Y1QvZ1pxYXNPRkJiYWk3RzIwam55VzZ3NllwQjRKRHdMMFZJTVRp?=
 =?utf-8?B?UmhJRE9EbkpvRVp3Njd5YjNUZ0M4bGtJaUNRSDI5Q21GUGUyOG1aUllSTm13?=
 =?utf-8?B?aG4vMUJSb0xsTjREajNleGxuSDZaQ2h1TWw4YkM4b0hXbzFsQXBQZE5VcUdM?=
 =?utf-8?B?ZmtFZDJSM29ZcE1iejdxVHJ0WHMwWmE2djdlODJBVjB5bzN4WXpSNld5Wkln?=
 =?utf-8?B?TmZicmtoczNiNnhKN1lrYUpIak1wTmZsY3AvUUhKbUNneVUvMU95QjBBa0xV?=
 =?utf-8?B?c09ta3BQRXg1VlZmOUpRSWF3L1l4ZXFZZHNTeXQ4Z1dnQkRTcWc4UDhLNHNN?=
 =?utf-8?B?dXQ5MmV5VnQxZkcrZXYzdjRCQ2p2alJiS0QyUk1ZZ3o3Nlc3MFZzN0ZqQVBK?=
 =?utf-8?B?cWJyaDkrODJ0anJhaHlaYXpkSVdzelYxaGVaaDlDc2d5ZFM5b2s1RFR4OXNF?=
 =?utf-8?B?RTNOM3JYZTU1OGh5UnhBMm05SnllYlNSa1YrSUgxU013OWtCMEwvTWEvb1lT?=
 =?utf-8?Q?a+ROEzIrHtG4AmyCuM63Tc7kO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd8a48e-502e-4830-9ce7-08ddb5af86c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:19:24.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqVUxkvP0JJEI6wsTnZgCcQHkZq8H6oc30CcyZb/SLZB3rQpy6mnA+3mikcY8rbvk8H0V1F/VadVOisXEdBBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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

On 6/27/2025 2:13 PM, Pratap Nirujogi wrote:
> Accessing amdgpu internal data structures "struct amdgpu_device"
> and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
> buffers is not recommended.
> 
> Add new amdgpu_isp helper functions thats takes opaque params
> from ISP V4L2 driver and calls the amdgpu internal functions
> amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
> alloc/free GART buffers.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 75 +++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |  7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 --
>   drivers/gpu/drm/amd/amdgpu/isp.h           | 47 ++++++++++++++
>   4 files changed, 122 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/isp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 43fc941dfa57..bbbca85d95d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -33,6 +33,8 @@
>   #include "isp_v4_1_0.h"
>   #include "isp_v4_1_1.h"
>   
> +#define ISP_MC_ADDR_ALIGN (1024 * 32)
> +
>   /**
>    * isp_hw_init - start and test isp block
>    *
> @@ -78,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
>   
>   	/* read isp fw */
>   	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_OPTIONAL,
> -				"amdgpu/%s.bin", ucode_prefix);
> +				 "amdgpu/%s.bin", ucode_prefix);

Unrelated change, it should be it's own commit.

>   	if (r) {
>   		amdgpu_ucode_release(&adev->isp.fw);
>   		return r;
> @@ -141,6 +143,77 @@ static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
> +			  void **buf_obj, u64 *buf_addr)
> +{
> +	struct platform_device *ispdev = to_platform_device(dev);
> +	struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
> +	const struct isp_platform_data *isp_pdata;
> +	struct amdgpu_device *adev;
> +	struct amdgpu_bo *bo;
> +	u64 gpu_addr;
> +	int ret;
> +
> +	isp_pdata = mfd_cell->platform_data;
> +	adev = isp_pdata->adev;
> +
> +	ret = amdgpu_bo_create_isp_user(adev, dmabuf,
> +					AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
> +	if (ret) {
> +		drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", ret);
> +		return ret;
> +	}
> +
> +	*buf_obj = (void *)bo;
> +	*buf_addr = gpu_addr;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(isp_user_buffer_alloc);
> +
> +void isp_user_buffer_free(void *buf_obj)
> +{
> +	amdgpu_bo_free_isp_user(buf_obj);
> +}
> +EXPORT_SYMBOL(isp_user_buffer_free);
> +
> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
> +			    void **buf_obj, u64 *gpu_addr, void **cpu_addr)
> +{
> +	struct platform_device *ispdev = to_platform_device(dev);
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
> +	struct mfd_cell *mfd_cell = &ispdev->mfd_cell[0];
> +	const struct isp_platform_data *isp_pdata;
> +	struct amdgpu_device *adev;
> +	int ret;
> +
> +	isp_pdata = mfd_cell->platform_data;
> +	adev = isp_pdata->adev;
> +
> +	ret = amdgpu_bo_create_kernel(adev,
> +				      size,
> +				      ISP_MC_ADDR_ALIGN,
> +				      AMDGPU_GEM_DOMAIN_GTT,
> +				      bo,
> +				      gpu_addr,
> +				      cpu_addr);
> +	if (!cpu_addr || ret) {

Aren't these two different errors that deserve their own messages?  IE 
how do you end up with a success return call but no cpu address?

> +		drm_err(&adev->ddev, "failed to alloc gart kernel buffer (%d)", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(isp_kernel_buffer_alloc);
> +
> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
> +{
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
> +
> +	amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
> +}
> +EXPORT_SYMBOL(isp_kernel_buffer_free);
> +
>   static const struct amd_ip_funcs isp_ip_funcs = {
>   	.name = "isp_ip",
>   	.early_init = isp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> index 1d1c4b1ec7e7..cf26d283469e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -29,17 +29,12 @@
>   #define __AMDGPU_ISP_H__
>   
>   #include <linux/pm_domain.h>
> +#include "isp.h"
>   
>   #define ISP_REGS_OFFSET_END 0x629A4
>   
>   struct amdgpu_isp;
>   
> -struct isp_platform_data {
> -	void *adev;
> -	u32 asic_type;
> -	resource_size_t base_rmmio_size;
> -};
> -
>   struct isp_funcs {
>   	int (*hw_init)(struct amdgpu_isp *isp);
>   	int (*hw_fini)(struct amdgpu_isp *isp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index c5fda18967c8..122a88294883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>   
>   /**
>    * amdgpu_bo_create_isp_user - create user BO for isp
> @@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
>   
>   	return r;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
>   
>   /**
>    * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
> @@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   	if (cpu_addr)
>   		*cpu_addr = NULL;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_free_kernel);
>   
>   /**
>    * amdgpu_bo_free_isp_user - free BO for isp use
> @@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
>   	}
>   	amdgpu_bo_unref(&bo);
>   }
> -EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>   
>   /* Validate bo size is bit bigger than the request domain */
>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp.h b/drivers/gpu/drm/amd/amdgpu/isp.h
> new file mode 100644
> index 000000000000..6c8214ea28e1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/isp.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#ifndef __ISP_H__
> +#define __ISP_H__
> +
> +struct isp_platform_data {
> +	void *adev;
> +	u32 asic_type;
> +	resource_size_t base_rmmio_size;
> +};
> +
> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
> +			  void **buf_obj, u64 *buf_addr);
> +
> +void isp_user_buffer_free(void *buf_obj);
> +
> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
> +			    void **buf_obj, u64 *gpu_addr, void **cpu_addr);
> +
> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr);
> +
> +#endif

