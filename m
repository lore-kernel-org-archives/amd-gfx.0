Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46BAC83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 08:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428548905A;
	Mon,  7 Jul 2025 08:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PkLaXFyV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861CC8905A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 08:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0xevRqAv5HPSRTg3WqoM24dZhqRVQjZoaEVBKZjfORXacMgblBvIN2U/uAen9o7wOZ4d6r8BPqvKx7mMduDXrFURl/Br4qvYD7B6IR0q0VO+6Ot0YImj7DCbrcln83pu6bBxXDJ45b/fcofALjymGB7rIspGkrWENdT+v5pkkJ3sweUJ6Z+86tfNl8IaLusdBG8P9srKfzrYViqkrx4AWbqGKcnBBsZIXJpvnGEdj/jYSb0VzQIKRTr/ECu0RbBH+QGKwbisrebW1MqMN6cf3bj+AAb4VitQ870p1UWExKY58Cxad3K6i0WS2N4cFJwhFguHU7EbCQqe2r/VnG1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLXPKXBUhpZoCHOKiEC4jVVkF25gI90vcExixelgMgE=;
 b=uRzaM/VNHau346iTNR3xOFw8Dtug2ygb8o6qqfqDXdnzmYhzzKVDdFgN9KEsdV6lnVjBEbHoTqL9Qfh0BOw5tTWyWnFJyHQtWC4M+NEmGU2MLKnfV/4Nifyw3dnUKCkey4CXVb5UGu0Ws6Xnz1wwaNv4lZ0El/r9v06bZA3g8cNdkSHM71lGYVoexZF1t4tliCBFNO6jUSVHGzoQhIIdDZHESJYR2oA72aL2kZj9ta1+lJ1NUROz/06EqFWl8SoLRnfcmeV/hWtj6QcjXgeztRX1kxx8KzF8ur56lBzO5vDzIn/cDkQIRnVzPKNAaWfPWIJ4cJ2nl13tepq6aAK8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLXPKXBUhpZoCHOKiEC4jVVkF25gI90vcExixelgMgE=;
 b=PkLaXFyVvx5EpNQRpEuf5IYUID5r14wxJjKWgOE4QrqhUfOZay5qv6Tg5rcF13fDTX0yeUyCBeYjGlp/HVzFGnuhOljLyB6NQNQdcvFVVANEz/qeIH0aTDtGYuWQfwpUmxJd5bTcoQ0DiyP2APIwdcuGkX9qwR5zDuaHJd9L4Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Mon, 7 Jul 2025 08:14:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Mon, 7 Jul 2025
 08:14:44 +0000
Message-ID: <168790ca-3f53-4f8d-b7c1-85181c11fa1b@amd.com>
Date: Mon, 7 Jul 2025 13:44:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
To: Meng Li <li.meng@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Cc: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250707070807.2034235-1-li.meng@amd.com>
 <20250707070807.2034235-2-li.meng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250707070807.2034235-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab813f2-4b2a-4420-e3f7-08ddbd2e545c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1VrbkFRNkZMZUdSdEtSSmg2aFhaUkNGUFkvZHdFWnRzVmhRaFhmR240Q0Y0?=
 =?utf-8?B?YlkxdGdpQkhEK0FsMHE2Wm5VZjFCenlFRTRUZnlZdkxnaHIzODk5UEtQRzVx?=
 =?utf-8?B?ZnR2YlZUUzYxZXg1QkpTQWhxRWJPay9oUTcyUEZaR0gwUUg2WUN6Y0hEekEx?=
 =?utf-8?B?Y09FSlF5enRtdXJhbUxNV2hEYW56bDdGUnE3WURiSGdFL2M0blorbWt5Sisx?=
 =?utf-8?B?d1QzbWJaYWFLdm92MkphcDRhbjA1NlFmVDZzMk4xNkEySHZVNGY4Y3ArelJq?=
 =?utf-8?B?WEV5UE1JS3dkTzBTQTR0WVdxeTRkYjUrU0xyTDdlc05yMmlyajdBeXNISUVl?=
 =?utf-8?B?cStGQUoxL0RQejZyYWIxSEJ5SmYzMXI0cDJGeFh0Y3VKTkpSOFFRZGllR0lw?=
 =?utf-8?B?Ny9QVUQ1TitTaU5XWGhpektMd0t2NGJFZXpaTTlTeUg2ZW5lZDQwQTVKUXc3?=
 =?utf-8?B?a1ZjNW9CSndhYm8vZ084RHZScldBMHlTVjZ0NVA2WU9nQU9GSlFWTFNjSk8y?=
 =?utf-8?B?S1NuUUtkNHhOamRHRmMrKy9tVHhMTGplQVBBVGxNNkozT0NYQWxYZHd4VGtk?=
 =?utf-8?B?K2YxMXJGVmlXb2VTUVFYVWluVytRN2tzK3pnSGFmT1Zla3oxK2ZyL0Y3Mzdm?=
 =?utf-8?B?amlOOUNmck1XWjV2a291SVZQbzlMZTdBaTlEZnQyNzNGcnZnVk5qWDVhd3Fl?=
 =?utf-8?B?ZHFJRlByMWNRRXlDb0xIWFZGaGg1cXNSU2VSbHhyOTJ2TFgxVHgxZ3dsTWc2?=
 =?utf-8?B?MEJjb2UwK3R2NVFIczE2VzFRekc5ZTVzS1hyMXBPTWdZQ3E0SytOODdWM29a?=
 =?utf-8?B?clZrb01nQXVNL3NGc21KOHJ2ZFg1QzdjaGtKQzlyTGZuMVQ4VDNSbytWdk41?=
 =?utf-8?B?QlBrdnhTcGx6MWlFSVhHYTJZUGVQSWQxNFJXV0t0dmRUTEFkeFR5ZnRFZUMy?=
 =?utf-8?B?Z3FvQ2sxVjQwcHBsZGg5M0o1L1piNG1aK3daczFVdVNJeTFXRVhvQVVZNWRV?=
 =?utf-8?B?d0kzSGgwb2xsYVlyNkVBMzJsVlNRT2FET3h1SW1oYVZ4UmZjdDIrWkFBT2pX?=
 =?utf-8?B?K0VWVGt3ZTlkZk9QZ1hWYXI4c2dHdk90Z1FpZW1na1p1MkNjQlNEbFF1LytX?=
 =?utf-8?B?bjdpWnNJK0o1VlJhaEVCSEs3WndRNlV6ejV5Z1ZPVE5MK2pwU1ZJMnVPWXgy?=
 =?utf-8?B?TDc3SlUwWkhMLzI1TllaR2MwWk9xRHc3dHBPNEY5NXZndEI3VTBrM3A4MW1r?=
 =?utf-8?B?aG5aZnJPSFJVQ0NCcml3bHhTOEI5MEcybzlaNFZPa0FmS2FidkxkdllzdGYy?=
 =?utf-8?B?anZRS3QyWG9oZ0xFUGVRN2JUK0FSQmExV0gxMGVIWDBObFNGSzFNYjhLbWlG?=
 =?utf-8?B?UEZET0NBZzhrSlBiS2V6Tkp3b3dCN0dYYUhNR0dFYkZIM0pNbm9BU0JOajZ0?=
 =?utf-8?B?dTNLajhOek13VjVFdWMwYXVWUW8yRDZ2cHpYaDdOTXo3N0cxb2toRUVCQ2V2?=
 =?utf-8?B?ZXYwT2VjQUlMWFlrOFV5MGpPaWxPN2dPb1BPOFNXdWJsaW5JNEwwam5FUjRa?=
 =?utf-8?B?aE1DQThvRW9SNmxaQzNZekxlNWZkSjZTNU5JcGlveVl4NU9obEh1VXFvNG1l?=
 =?utf-8?B?UW1UeFBEdWZ3SnVyZXpJWDdhQjI0RzE0dlRyc2l1UW5vUHdWL3d6NkZTRDRa?=
 =?utf-8?B?SiswRFprbVhGcnJBZUg0d2N0dVg0VEJLMmFCWEE2Mi9pM1BWNmcxbGZEM1Bu?=
 =?utf-8?B?YThqQy8raG4zVHlYYUpIckRzZ1B1Vk5ydG4wWUVNWlNVeHhFaFJRcE40Ungz?=
 =?utf-8?B?WGhvUmZBeXY1U1RDQnA4Yit0UjNwOVBiQ1EzYzVKZStVTEY0dmVLZjZGbkl1?=
 =?utf-8?B?aUlNUGFPdTE2SWgxOXVZVU5iRnplUmxKbmwzeWdzcTIxZ1FiSGdyK2Y1c0dG?=
 =?utf-8?Q?ZX0BXOxz6ec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emw1bE10UkduUXhlTG9yMkpQZXU4Z0poRjRXdEpqWFlCUHQzVGg3d2NpZ2h4?=
 =?utf-8?B?cDJhM2V3d3V6UVlmeEhnNnJLT3VONU5XVTZqU053dVROREwzbjk1WENFVXho?=
 =?utf-8?B?WUU0N0FqTUN5ZGdRdGw3ZGtacFNlbWFOdWN0RmtETEQvYVRkSG8yRWgwRXRs?=
 =?utf-8?B?eSswTmlXclZhT2o1U2xPS2pDZmpmZ0hiajZIVDVGZUg4am1paGI4YkQwVVdR?=
 =?utf-8?B?aGJqQyt3QjRpdDF0YjNvNy91cWZSNElsN094ZzRTQ1dteVk0MWJhWjNNeC95?=
 =?utf-8?B?TC9Jc0hlQkIvTVBjbnRYREtVdXpWUWdETy9HK0RBZXROeDI3VnpJZjY2bHd1?=
 =?utf-8?B?WnhLUkFjU3h6a2ZsZ1pDTm1EWVlqd0c0cUw1cjloMGNWRVJjaUZRSys0bTJT?=
 =?utf-8?B?WEI2UEp5ZUF4SXpKVTcvTVpKS29OV09OK2ZUSWhKSEFrOHlpemhWemdvUWZN?=
 =?utf-8?B?M0x2aks5M3B0bnJpWSs0bm9Ec05RbWFYT09POC84M2JVMktQSzd1dkQxaHVo?=
 =?utf-8?B?UUZGeWtPWHZ2Z2Z3d3ZFOS93VTd3aE5rdk9IL1U1MlNnVXdtT2lFbXNtZkZU?=
 =?utf-8?B?enhWQmsrQ25wclFQUm5MQkcrOGh1dFpTbENHcTRxa2U1Q0hXZ3RiaUw0bXc5?=
 =?utf-8?B?SlFnQURkZlh6YzhSdVh1eS9ad2lWOWNUa0phOTZuYldIRTFqb25iWFNERVBN?=
 =?utf-8?B?K21TRG9HS3J5czdEWG5NcCtSVVhHeGhNeXgxcUFQdzNRbXRUZGY2Nmgreis0?=
 =?utf-8?B?cXVybFlWWGJBTWR2OHdyN1B0VnBxTFdFL0ZsUU9KY0lEVXROVFY4QmxXTmtC?=
 =?utf-8?B?VlJRZURPMkVQSk83SGVKVTNVVlZjM0p3cThkdlBRazlZbHlON0VObDF4Y3l2?=
 =?utf-8?B?dldBT2lwT1dvVWl4dWNBQUYrMUtMZS9FTzFEQ2pmNFFjV3BTbTNoTS9zTU00?=
 =?utf-8?B?czZSTzBhU2dJR1NiZFBtNDlJWDM1c21CKzZWM21mcnRZU2VKV0tTSXpOTi9o?=
 =?utf-8?B?Y3drUDFwc0xWT3hzbUNUOE5wUE9ROXcvK2RiNmxTT2NQcWsvUEwwTG80VlBN?=
 =?utf-8?B?eDZWT0pBTGhjS1ZhaUhKSlFoTGFEM2RxT1gzMityeTg1bFBFZVZBNEdMSFR5?=
 =?utf-8?B?STBUL0xOdjBZUjU5MUZ3TElvZUpIaVJNZldzTDE1dVB5M0pJbGlic2lLOTBw?=
 =?utf-8?B?b2UveElQMTBYeWVWMTBQNU9KRFpKMk1FdEY4cUFhNVNtOHJIODZiNmVXcFVU?=
 =?utf-8?B?SHZSeHMxdngrdjJlL0dzRWcyL1RHWHBGQnBQdWpQU05tRVcrSzYvNXdVZUIy?=
 =?utf-8?B?V0lzbFg3ZWFhS2dXbmgrdDN2aFlkaWFveFlmM0tHQ2F5M2xZMzRxSVJ3YWpC?=
 =?utf-8?B?R3hDaDN0NzY2OTZzM0VmZGlMdGZWdEhScjlLcFdvaysxVFZpeFE3N2lrSmFB?=
 =?utf-8?B?eWZtdVhza0QvU3FxKytFZnZSQ243Ulg0RllObCtTcytLYnFDUUZteGtOck5t?=
 =?utf-8?B?U01LNmlJdGh0cmNUaFlEYkJ3R2ZZOStSZGx5WE5KeDlZbWdHZytabmxUcXZC?=
 =?utf-8?B?RDU1TlJUWEx4WEMrTUMzMVkzbHN2ZVYvY3E4RWI2TDloNVViaFcxNEZzQ1lo?=
 =?utf-8?B?VFQ5Nk4veFFXNktWVVdoM04vdW9xSUZicWovR1Ivb1hrV1BacVU4b3FiN2E4?=
 =?utf-8?B?OVZlNmNtb1Rac0dTWENUNnJPOGRzVXo1SDNITVhhK0RaREtmcFMvTnN3Nk13?=
 =?utf-8?B?Zm5FUzhqWnFBQmtrendCNVlLb3NGVnBNek9RYVBxWVl3Q1VBMjZQNDNnaWpM?=
 =?utf-8?B?L3hjanM3SW5wY2cvZ05adURqbWNBaXY2cTJaVG1PRkxvakNoYzRVZ3hLR01J?=
 =?utf-8?B?WjZhRmxFQWEwT2RGeWZvU3g2T0UzYzVHekpnOFlRU1BoeUpNazRPRjdyRXR5?=
 =?utf-8?B?U2lUMzRuNGVRcXIzZUpjaVMvZkhsQmNtbVNramtzaWpQNTYwMHZpWjNRemcz?=
 =?utf-8?B?WVh6VG1ZQXVpaGhEdjRpMHg1NzZzdUF6NC9WWnJxclY4LzhBN2lCNEN4L1BG?=
 =?utf-8?B?NVY2TlJTbVM4Y2poYlUwblhoNVlGMU43L3pjY0ZhZlZsd1cyNC8zeFMwQVE3?=
 =?utf-8?Q?WI3WoZcku5/CZqrAB3ktLoyQ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab813f2-4b2a-4420-e3f7-08ddbd2e545c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:14:44.3269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCSU/HXrGu7G/J8XJUHErvkqwTBHCNE+WuJTwX8zRn8EiCZn8a5hAr0Uf1TQNh8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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



On 7/7/2025 12:38 PM, Meng Li wrote:
> Add a new API amdgpu_xcp_drm_dev_free().
> After unplug xcp device, need to release xcp drm memory etc.
> 
> Co-developed-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 58 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  3 files changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index c8fcafeb6864..e5717c657fd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -394,6 +394,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>  		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>  		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>  		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		amdgpu_xcp_drm_dev_free(p_ddev);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index 8bc36f04b1b7..447f46c29015 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -46,18 +46,29 @@ static const struct drm_driver amdgpu_xcp_driver = {
>  
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  {
>  	struct platform_device *pdev;
>  	struct xcp_device *pxcp_dev;
>  	char dev_name[20];
> -	int ret;
> +	int ret, i;
> +
> +	guard(mutex)(&xcp_mutex);
>  
>  	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>  		return -ENODEV;
>  
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		if (!xcp_dev[i])
> +			break;
> +	}
> +
> +	if (i >= MAX_XCP_PLATFORM_DEVICE)
> +		return -ENODEV;
> +
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
>  	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
> @@ -73,8 +84,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  		goto out_devres;
>  	}
>  
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[i] = pxcp_dev;
> +	xcp_dev[i]->pdev = pdev;
>  	*ddev = &pxcp_dev->drm;
>  	pdev_num++;
>  
> @@ -89,16 +100,45 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>  
> -void amdgpu_xcp_drv_release(void)
> +static void free_xcp_dev(int8_t index)
>  {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
> +		struct platform_device *pdev = xcp_dev[index]->pdev;
>  
>  		devres_release_group(&pdev->dev, NULL);
>  		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +
> +		xcp_dev[index] = NULL;
> +		pdev_num--;
> +	}
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int8_t i;
> +
> +	guard(mutex)(&xcp_mutex);
> +
> +	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
> +			free_xcp_dev(i);
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
> +void amdgpu_xcp_drv_release(void)
> +{
> +	int8_t i;
> +
> +	guard(mutex)(&xcp_mutex);
> +
> +	for (i = 0; pdev_num && i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		free_xcp_dev(i);
> +		if (pdev_num == 0)
> +			break;

This if check is not required. It's already covered in loop exit condition.

Thanks,
Lijo

>  	}
> -	pdev_num = 0;
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */

