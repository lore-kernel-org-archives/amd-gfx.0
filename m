Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ACAC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 09:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EAE8920D;
	Tue, 18 Jun 2024 09:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2OEecvp8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5D28920D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 09:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu1/RfulzIEMEMofisSyjyKaNQ4nHZ9/0ogV9J7hMzNHJp3rtbVMswYn3IP2divsJlQV1MIZnFoLPsl9xW0O9z984w4mwKhsbC6WjYOMME7dE4BRLK8HuznG3VH3g9Cp7tYPWDR8BSKxzSz5+eFDnoAWNiMyc6b2KWZ7wgadfRTr2LvdHBat6mm3x0ZxHwF8+cPpONOKkb41SFfkz9XGHh5eUvekp14A9yD58wQfORMuU0tUXXB/PttnhNVnoO7xXb6634jxCPeWrxtXz6Q1OO80/XyLA0syP1/vcGNG1l66eoYJoSbhNRkj3KAa3yaiAsUmb4tyOJ4sP1RBA+ZYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ+I1iu9N1Oi6ORyyk0IQHAaX8WwWhsd6VmMf6v2GdY=;
 b=WRPppFjkpGhh2Z5+fM2VpXBoBQfKvquF39LFFzmq0LVAurq/O6VlCZeKQ5EtMpoM7GY0XFJtoWJ6cjGp0EURcCEn5bxU9cWJWhO572CeebZ4gsntIpMxTPqmeWHnqVT8ZHON7Rh8/WDijORDFhwhDeOXFpIObf0+MzhyYtk+4R3A4rQFFCM3X2jOVmkPP3MdQ/ioBrMoo4aNpxnx9xaFJILmkuH7aOKM+Wwd/CSUM+Z4N+ZLl6nyb9Pxl9F/hkNlYDUJ1zoMOmk51l9Qm8ErJw2KsC0EOkEM3RNl75rFg/i5Mxza4IKn97FFPGMflbATns0gdFPh4b/amZKu4A94pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ+I1iu9N1Oi6ORyyk0IQHAaX8WwWhsd6VmMf6v2GdY=;
 b=2OEecvp8x6CC3nTKLFfN/cScusR+iKkHVYCe/UO2P88iuTFHb+57n/pC19JvzL6ImS8mvpdBr834BA9+2y4R8sfqPswZBnDx1XvXHQYOp7cGGvYpIG4QrnHe39vUQiVC70dxsjXY89Y30qCNcftTw+lqAPRQcC7IFAHRRdma0C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 09:27:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:27:55 +0000
Message-ID: <4dd1197a-635c-4b75-b874-7b4be45b9524@amd.com>
Date: Tue, 18 Jun 2024 14:57:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov
To: Jane Jian <Jane.Jian@amd.com>, Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240617101114.243566-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240617101114.243566-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a90687f-0b3f-4b65-8da3-08dc8f78ef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjdzRHFsSDhyOGRQaEsybnZ4SkF2ME1SVE5xZkF5Qzg4dUlGM0hrM2QzWkJO?=
 =?utf-8?B?WjF3SjEwcXFGQVpuSmEzcDl4SDFMMWtoNG9sbis1bGlNaEF5bUxTd09SWWZX?=
 =?utf-8?B?RzV4M3FqSkJqWEFCQm5uQ2cyeElrRGNFbVBESFJsbm05MEhxbFJWeXROVHJk?=
 =?utf-8?B?UTBqWW1yYXoxQXZOSmdXTzNaZVEyNlJLckZtS1JuV29aYnhuWUJhUFFTMTRL?=
 =?utf-8?B?WnRzREFaU2o4ZkJOd2RCK0FWUnlLWFRmd2thQ1BBc05ZMWwvMW9DU2RPZ1c0?=
 =?utf-8?B?QU5lL2VZcStKM3gxMnYrUjBwKzd5ZU0yMmpVUXY5eWV0MEtmdkZJaFYrL2N2?=
 =?utf-8?B?ckJmVnNkZDZCUk4rOU5BeHFhdHNDcGQvSFhRUWVSQzRHR0NjMTVqMUlTdThw?=
 =?utf-8?B?bjJpTDJjM216MnZqSE56QTJJeVc1SUVDaDV0OGNVclpTazN1TXlzNFZJdk9z?=
 =?utf-8?B?T3B0L2plTUxrSEpUSlNaZE5NQUZ6WHljcE1MK2prUWxUUVFzaHA5djlzbTlF?=
 =?utf-8?B?WktaVGdSMDZ3cHJFaDMxWEREUEFibDh0VUhOZGlnTXpzUUNUTU52aWUwUGhm?=
 =?utf-8?B?RDBpVUNIK1FNNy92NUQ1NXhtVXRleWUwUE1lNFNzZ000alp0S0ptZ1R4UnNL?=
 =?utf-8?B?TlZHRHZwVTVPbEtobzZ0aXQrN3ZPMTl2SmR4ZkRMdDJncW5GMUswTFluMGp0?=
 =?utf-8?B?N0dEYmt1YzhzS3BYM3Bub1pEZ1FURVRybTBjOU9XbjB3d3EwTUJSUDJBYzJu?=
 =?utf-8?B?V0xFQS93SDJyeUJ0VWRIOGZQd3hSV1hoRGtxa0VHSGxDU1Baa1RzelRaL2hr?=
 =?utf-8?B?OUF2dmpGR0NDai9QbjBFWExIeGNjWTFPbzMwZEYzQXdGSTFVWVJGZ1RkM3My?=
 =?utf-8?B?RTJWd1hvTnJtU2hsQ1JjNXhwZUlJSTR0VDdkS0toSDJ2UXhwTDIzL2JrU2Va?=
 =?utf-8?B?U0F6RHZrMWJ5dDNzQ3N6M3ltR1IwR3JzTUluR2FkUnhGbXZORmlQMDQwSDJQ?=
 =?utf-8?B?YWR2WXhNaFRMMDRoZkM2eExQYm95N3BaK1VBMXNRa3VIREV4V3ZTMEs4Qi9o?=
 =?utf-8?B?MU5MWkE2b2RGcWJLYlpCL3Q4THlGRUFhenVia2IrM09VRUJHUlBuK0kxcjYx?=
 =?utf-8?B?bnFRZjhMOXFhNEVNT3E5ZXdjOW12ZHBxM202VVJlelMwODVCU1paMFZSdXpx?=
 =?utf-8?B?a28rdlFKTERZb0NQQm1RdE9HWTVXV2JzcXcrUGFrRkwzaVh4UE1JT1hNZEJZ?=
 =?utf-8?B?RElWTUs5amx6SjAvdy9XYzBrbnBjVFYyVU82MHNnN1kwVGUxbEdiaHBuZlJo?=
 =?utf-8?B?OE1aM0xKNnRLSUVWenZ0OFpCSDRxWTdOb2pKVXpSNzhCT0RsMEVYdEIzN3Fl?=
 =?utf-8?B?d0VqQU01YWJ0L0pqUDkzNE9ZR2hOTzJ3V3B5K3pxakl6QVduYnJIcEVzQWt6?=
 =?utf-8?B?dDBFK01jbW16YzJCVEsyYkhDeGFGVURHZ1lucFY1V2ExUmg5bFlpc0JiRmJ4?=
 =?utf-8?B?N1NoTnprcUdlaEw3RHNpWVhRQjlXblZWZmxFMlNnOWplQnQvaDREcWdXQnVo?=
 =?utf-8?B?WVVWUUh0MzlleU1ySlNxZndvZnRIaG1ITjZ3bFhoMGJQNG9UOXlJSTU4Zi9Z?=
 =?utf-8?B?TXpWRENYSUlTNDIvaWhwd2N4UVZuNXFhVU5ISS9scFpIS2dXb3M0TUN0WlNn?=
 =?utf-8?B?RzFxL1dWNHZwUC9nVGFLUEw5OWJ3RkIxdDEvdllVRzZnV3RYWC8vY2xUSSti?=
 =?utf-8?Q?VBgPpSh6sW6BMi4BdOAdAMgc4KPOyBEk7R42a3h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhMVFZrQW9CZUdsSFBiUDNySDNJdmZMY1k5V1pMdTYvUG5leVZXRG5jZmUz?=
 =?utf-8?B?R1cwcTFmTWJwaUFHd2t4c2tid1J2MlU2a1ovR3VsLzhTbmtjaVNDYXFIQVkv?=
 =?utf-8?B?dzk5NmpYUjNSQXJqSDIxQU9kd2dZd1JkOXJpbVhuVG9KT1VEMGFJYWxhMkR4?=
 =?utf-8?B?WUw2WVNCQnVFcmduK3MzTUdWNUh4cVdHcDZtaDluYU90K2NGQXJwbkthS05P?=
 =?utf-8?B?d2ZRR3NwbkFpSXVMa1Z0UWVlb01lQjdqRW1CbFFTYXJrYlhlbC9NNEtQTDlD?=
 =?utf-8?B?eHlKUkwraE1jcW0zbmVVVVhRRm42dzNPRmdxOHowNUs1OXRxZDhRRUtRdDJW?=
 =?utf-8?B?SWxlcGR6Rmc3aFViMXBVZTFzend2b2JoZktGSFlyZDBIYTR6SERKSTVVMlda?=
 =?utf-8?B?TUE5NUZlc1Y5ZFc1NFlRZm51b2ZHRmZYZUJYUCtQZTZ2L0JCZWNpZDVOWVNx?=
 =?utf-8?B?VzU0dDVuRHNpSE5McUF0ZmhuVGlwS0wvZ2l0THRzZmxSLzNaMTRINzdORmZv?=
 =?utf-8?B?b0tobWlJZHlmWnEyWFdIcE9zY0JkRTZOc01ybVdEMDloNkpGZjFMbEpZY2lW?=
 =?utf-8?B?RUNJWTlaZGkxZHdNcjI2UThnU1lpY052cG04ckNERVFxaExsWTNoZ3RLc1J4?=
 =?utf-8?B?U3E3RkswKzJvdjM1TVZIMGNMY0hIMlFqeFk3Q3dMMUd0ZzIxWFRnRGY0ZlRs?=
 =?utf-8?B?eG5WamxhSlRVZ0xXelJvS1ZyMlZqdmJJSU1SRlhhRFdYUEl1bVc3TkVBYnpF?=
 =?utf-8?B?Q3FtME1sY1lic1ZQMnRsdVMraUhmLzRSaVVKb2RTM3UzYXdhUDRHNFF5dHpO?=
 =?utf-8?B?Z2s5TjR5Y3VPd0FjVDlmb0tXeVZVcGRZTDdzMnNzRG8rVm40WVdSWm9VeUl2?=
 =?utf-8?B?aHVxc3YvSG95eXlFZFVNMWd0Um1ZOTFJaUNlL0hJRU5NTm9RZ0x5OXFORlB2?=
 =?utf-8?B?VEVza2JFdGxWOFJCZFhnS3U0R2xDQWhWdUNiblljbDA4RjIxRzAxSFVuaEpD?=
 =?utf-8?B?NXpuUXF4RUhVdkFjODFnM1lVVlFpdmhSZ1RHT1dZdnprWWlPUXZjQk1QQWNG?=
 =?utf-8?B?ekJBNU5IYmVrcUJBdFRBWWlFM2NwL2MwVkNISEp3RzJNVCtSRHlPTkcrTG1i?=
 =?utf-8?B?eU5jMEt4cVBXaW10ZWVKVm9mMlFBL3dPQWtub0JUM2VGb1U4aG01R0MxN0FN?=
 =?utf-8?B?ZFk3OWxqRFdqeHFYMUNaVE55dnZSb05hWTBpVEluVjg5SlUwR3h5OFVwTU5l?=
 =?utf-8?B?MW1RbDJDTUFaVmJUejBVTWpiSjBsNnNLbUJtWlp1ZnRMSXNkSjgwcitYWEgr?=
 =?utf-8?B?aFRvQjJCY0ZnMlpBV2Y3QitGSXl3cnFaZXF2bmpXYThUTEovcnZ0V3B6OWxx?=
 =?utf-8?B?bVk2S2p3cE12WE9jcjVvQTF4RWJnL3QrUHgxWTQzdGhMMXVFSjNuTm9CWjJV?=
 =?utf-8?B?R2JhbkRSN2ZnZVVzemozYjNEYzZMUGJxQUMxd3NsdGtYWHNQUXZhbldONVRH?=
 =?utf-8?B?YmlQSzFmaE1zK2R1V0pkMDZJVHhSQ1p1aVM4SGpMY0k2UUVsZ3pDeHlxdkwx?=
 =?utf-8?B?YzhXdnB4ZVUrc0VMVUt2ZDJtaUV4NTU4L3RuL3N0NXVlK3RVM3VHSVV2b1Z5?=
 =?utf-8?B?cHVENWgxM05TTnY4ZzdrZ2NSRTlqL3hLcU05cTJZREd4K3BYV3lNRU5ieWpO?=
 =?utf-8?B?ejgralZNTzlvOVR6YVZFSmw2MmZXQngwaldpay9zc3Q5SHBqUnVWT2p5NW8v?=
 =?utf-8?B?RmNhb2theElSMHY4b0FuZk4rMGJ4UWFWd28vRzY3Y210dGRzVjZCVVFiK08w?=
 =?utf-8?B?TnFTcElydGloRmlTaWw0eUZGZzdNMzVrRjBlMkFMa1haamx1eW9Ec21zcjFO?=
 =?utf-8?B?cUZBS3VTUE1Vb0xaMVhObitiL0FlUGo3Qmk0ZU5CNCtYK1BmTUZNb2U1Zlhv?=
 =?utf-8?B?K25tUHNCU2xGZS9wQ3FuVEFSN0hrZEFDQit6Q2I5YU9IcTNKWlVFQXoxdUhD?=
 =?utf-8?B?U3pMOUNnTStsa0prR2xRMW5wTW4vRllJek5lWnQ3REtHN0I5MWNBMmxLZlZZ?=
 =?utf-8?B?a244VlNhNGRCSFJROGhqaEFxSWZxNnhEWDJCcjgvUEg5ZGlQK3dhUk9UM0F5?=
 =?utf-8?Q?hWjdlEjtpjyZUkowqOnpEeapx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a90687f-0b3f-4b65-8da3-08dc8f78ef2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:27:55.5404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXd7HRpgfwBfjfgxi/zlBpa6yCIwFQNUNg22XD1T9xSw0SznEpDAb5dqvvrgAg4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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



On 6/17/2024 3:41 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
> 
> also fix the typo in sriov_w/rreg:
> for KIQ case, use xcc with xcc_id to read and write
> 
> v2
> amend some typos
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h |  2 ++
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 63f2286858c4..d43652a38484 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1075,6 +1075,10 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return;
>  
> +	/* Select lower 16 bits to write in local xcc */
> +	if ((hwip == GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
> +		offset = NORMALIZE_XCC_REG_OFFSET(offset);

This cannot be generalized. Instead use a similar approach of having an
soc specific function => adev->asic_funcs->encode_ext_smn_addressing

> +
>  	if (!amdgpu_sriov_runtime(adev) &&
>  		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
>  		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
> @@ -1084,7 +1088,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>  	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>  		WREG32_NO_KIQ(offset, value);
>  	else
> -		WREG32(offset, value);
> +		WREG32_XCC(offset, value, xcc_id);

This doesn't look correct. AFAIU, this macro is specifically for XCC
registers. amdgpu_sriov_wreg can have registers other than hwip == GC_HWIP.

>  }
>  
>  u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
> @@ -1095,6 +1099,10 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>  	if (amdgpu_device_skip_hw_access(adev))
>  		return 0;
>  
> +	/* Select lower 16 bits to read in local xcc */
> +	if ((hwip == GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
> +		offset = NORMALIZE_XCC_REG_OFFSET(offset);
> +
>  	if (!amdgpu_sriov_runtime(adev) &&
>  		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
>  		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);
> @@ -1102,7 +1110,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>  	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>  		return RREG32_NO_KIQ(offset);
>  	else
> -		return RREG32(offset);
> +		return RREG32_XCC(offset, xcc_id);>  }
>  
>  bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 88b4644f8e96..5bb275b96e6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	 */
>  	if (adev->gfx.kiq[inst].ring.sched.ready &&
>  	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		/* Select lower 16 bits to write in local xcc */
> +		if (AMDGPU_IS_GFXHUB(vmhub)) {
> +			req = NORMALIZE_XCC_REG_OFFSET(req);
> +			ack = NORMALIZE_XCC_REG_OFFSET(ack);
> +		}
Not sure if there are other things to check like cross AID register
offsets for MMHUB.

Thanks,
Lijo
>  
>  		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>  						 1 << vmid, inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 242b24f73c17..9ddf68e7d06e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -210,4 +210,6 @@
>  #define WREG64_MCA(ext, mca_base, idx, val) \
>  	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
>  
> +#define NORMALIZE_XCC_REG_OFFSET(offset) (offset & 0xffff)
> +
>  #endif
