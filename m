Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21933E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 13:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C502610E3B4;
	Thu,  2 Jan 2025 13:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzaKGITZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F28910E402
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 13:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQZjo64qceh3/aBI64dalySBZjk0pCjIgHn9U+WuvYbB2D6ZRCuOGxZvgKn9jmbDvcJQaEep36P8XBlFC9Xic2l+RXud+vxPSYhZvhouExn4lOpkgKJVUAco/CJwNO4hLV3/r0dQeKSfkmo8aC/sX6wTRi2IozT2Vqed1Y+1jidRpTjP4IL2cIbNrZiMpCvYhMRzFg3igLFsAZwAUagNUzKJb1GBR4GS4KkjfNZddc7YAuxdmEbIS5IYbREbUUG3CDfud1RKBAHMawBMtHLdud3gnU2yAurL2Uz1JaGF9QlJ5aXXd9uMge3vUgshhqwcp4D2wvm/ksNXbE3x9abyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvLPHgb6RGF6E2H2Uk0/azmpBKe01Z6LqeAH8XBWH/I=;
 b=U2sdWkU4PfjkF57TcKhGj0uKmIJ3sbzCkMTjTlCYYrLKi4kaiUnocqSihNhh0fj0zwTQay0jtFEb2YcDSAbMrhSEHrdMi3hyLChm60qJAvYgPU/dfrgu6+Py7Kfoo961QnqVFpoUVso6ha+jO7RoWJF1S686OPmQwcGQAzjDUx9BZQwTJ8UYRJGuPoVJooHTkwjzsIEqct42HmhOfUWycV5lz8EkNS2d/xY4sUmhKoUtFrttKhRR72YaiC1VKnR3pca8OxoPAOEtTborM4i6HKdEWJIDVoqzob23W6INGBKSySMRxozC21YZ8djKcRLmu0OBDaot+KjC9E+M6M9V2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvLPHgb6RGF6E2H2Uk0/azmpBKe01Z6LqeAH8XBWH/I=;
 b=bzaKGITZ15SAuoz/xmr58MxMi9pJrSzLN24oj284uwW/3KISV7PADOBI9rWcZBRCBtZRa4Ura6k9K4bVPdZXdSHljGEBiktxkuB7l2LsgJPPqK37fd9pll3UqN0KDEIFSnri1zgsmlm4ioKv2CDNaUDNrPya8/1Dy0yn2leFuzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 13:28:05 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 13:28:05 +0000
Message-ID: <5d460846-9400-4821-a371-72388093f85b@amd.com>
Date: Thu, 2 Jan 2025 14:28:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [drm/amdgpu]: user queue doorbell allocation for IP reqs
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 veerabadhran.gopalakrishnan@amd.com
References: <20250101060338.402215-1-saleemkhan.jamadar@amd.com>
Content-Language: en-US
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20250101060338.402215-1-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: f8df5ea6-27ee-44eb-a258-08dd2b3149ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3pSSnpQbCtucnRwWlZDdWxuOWZtWlVET1U5K1lGZXkvY1hWWWlpbHhrTysx?=
 =?utf-8?B?UUVhamM3alcva09KeUUwZkk5WW14SlZLY0ZLWXpqc285WDAxaGVZRG92cDd0?=
 =?utf-8?B?eUo2Ky91TEM0bkRWN2VOTEFhMFBYalc2UWY3ZHE4Rjh6bDNXRXAwcS9mbXFG?=
 =?utf-8?B?V253bExoeHV1OEFxUGlMSmZWN0JrQ2V5bFJ6YVpacWt1STdQOFUvRXgzOVhi?=
 =?utf-8?B?SFM1NFFIMnhKTXQzN2ZuRXIrOXpkWGZRV0VSbVI3ZlZKYXcxd0UrYmkzOUQ4?=
 =?utf-8?B?Q0ZNWisrR0V3ZUlNc0FVYVJ1OWdjR05YcSt6SS9KZFU0Si95R0RhdlU4STJ3?=
 =?utf-8?B?Qm5IZ1U5K0s1a0xnNDREcGdXRFpSOUVZM1hua1VaUDIvb0RNU1RSZy9raTZ3?=
 =?utf-8?B?eGE1bFQ3VzBMUzBkS3U3b3o0ODA3Kzc3ZEJoWmFHeWJjMXk3T0MwbC83THlZ?=
 =?utf-8?B?S0ExVE9uZUQyMG90SnpKTExWUlpSNkU5TWpLNXZRV1VhQmIzdkJWS25ncUNT?=
 =?utf-8?B?ODVLSU1wb2RmdEZKRytDSGwvOTAxV2lxbEFDUFhMZWxhbC9nYlNDRUlmemdI?=
 =?utf-8?B?QVBNOWxOcVRiTWcvQzVjWm0zUEhzZ2htK3ArQmxTRUlRbWcvazkvcXd3cy9T?=
 =?utf-8?B?bVNEWTkrK3ZZcklWcksyZ0R4S05CKzE5U2JzcFk3RnJOUmdNUDJMOStaSjRt?=
 =?utf-8?B?Q0NMNkpKUktLOTBhNnhrWnIvOGNqYlhsdWExTEw4U1dqeFVrcWV2Njk1cGRD?=
 =?utf-8?B?NHNLOTF4N1NkUXErd2pBcEZzQ2V3eEEvRzhJL2l2U1N1ME1BellmakNyR00r?=
 =?utf-8?B?N0ZnVFlxdnBqelFqbjlkRGNQdWc3dUIvVmNxc3c0SjBHeTVLd1NaT0c5eHBm?=
 =?utf-8?B?ZDZFNkNqTVlyUnFuSkRxaDlQUFpqdm8xc2ZLWkVWcEFOM0RZMGZLS2IrVnM0?=
 =?utf-8?B?NVIxZnN0YUdkR1VpRG8yWnRweG9qVnBLOHFPSzJJam0rcWdIeHkxRkYweHpt?=
 =?utf-8?B?Mkh2Z2lRalNsTEFHQkxpeW5XekNpdG9UZGpMYjZnTmU3OE1uM240U2x3bHJs?=
 =?utf-8?B?U1ppK3FPQkE5K2R2cjRmNUZ5c1FKTk9BU3VDNUJMdVdPZkd1MHd5d0NqUWUx?=
 =?utf-8?B?MWVSQlVUd1pGQkdidFU4Y1BmNkduUFhGV1lONUR4Qy9CM3lrUk91bW1ESFYw?=
 =?utf-8?B?OVBFeXdxL0lrR0QweWJPekRKRmlENUFvcUU0MW5lNHRKMzFjNkZaS2ZDTGFs?=
 =?utf-8?B?V2RSUG9MZVNDZFAxNUhibXdHdzBxQ3hIc2ZEbkFoRDNmS0trNFhpRzFpNzFw?=
 =?utf-8?B?MzNpcnRObjlra2k2QWlITzlhUDB6M0s4ZEtZOEE2aVNSRjBkU0pRbzJZKytl?=
 =?utf-8?B?dVBqeTFVbVlKbDlUeGM3aDVERi9Oa3pEa0xqUVdNSW5DaTYvdVZGNXBaK0ND?=
 =?utf-8?B?dER6dzhIcEJ1ZHBOK214TTlFeWljWlpkRTh0Tm9lSXZLR1VQb1Y3ZGNZQzNM?=
 =?utf-8?B?dU43TDdLRkgxMzlSYXBETWdnK0haNnB4eWF4c1ZZUU0yWlZyeVFiaUh1TFRG?=
 =?utf-8?B?UVpwdURXMVNtakZsZmdTclVmOHJZNi9WVHpna3paN0dIMis0dnF3akZ1YkZh?=
 =?utf-8?B?cVQ5OEI5YkZUUE5DYUpRZlIxQ2VDMmNla09DZXU3Z0Vud3lUWlgzd2VUYzRS?=
 =?utf-8?B?SFdySElCR0o1SEVHRjdjVzJlb25IcVBXNWhyZFZIQi9nL1ExUGI3a2s1clZS?=
 =?utf-8?B?ZzZrUnZiV1l1SXhBVXJzQ2VXRHdFdUxZZHBEL2pwdXdISU9DOSt4UVZod2hQ?=
 =?utf-8?B?R0VqTUluRkpaRmdwZkE1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2Iyc1Z4eUd1Z1R2R1JYMWdIK29xWHRhVEhwMUhkaURMbHZDVFNLLzRXZGQw?=
 =?utf-8?B?K3B5eGl2b3E1NkR6S0Rsbm9zZi96eDBReWpNVmRjTUdySitVS0RpTEtheS8w?=
 =?utf-8?B?enpKTjBDK1Z0QjdrN0g3dlRkWDhBSllYbzZjbDhvR3lZSGFaQ0p3aTRQZTY5?=
 =?utf-8?B?SEtucHJDRFBINlhMUnAvYjlTNUlJTE9UOGM0dGtMUlpHcXcvRTdJWDViSkJj?=
 =?utf-8?B?V1EzS2Fyb2RjUlg2SWRWU1RoSit1REpjeS9TT0FWdm5qUHhjOGxxRmsvWFJY?=
 =?utf-8?B?UVdtWjlKY3ZqTjdYZ29NUm5ZMC9rNHo4d0pmdXFuai9hRzVwWFRIQ0RyMlRZ?=
 =?utf-8?B?SU9Fd1VYblhjczA2aXZHcHZBYWFCSUtsRTAvYjMzLy9HeE4ydzVjanppUW1y?=
 =?utf-8?B?Y0NqbXhGMlNwTFNhbzRsMTlUQ3dGWG5tVHdsWlUyNUwreDRrM0tTWEpvQWpM?=
 =?utf-8?B?cGU3bHVFa2lJUVR2OUFMc0ttdHl0bGd5Q1Z5dVdWVVh0ajZIZGNTOU43WVM1?=
 =?utf-8?B?a0VOMm5lNy91b1NweGR2c3N1cnNUeDZJb3NzTkFhdytqQjBMVFJCMWV1S1A0?=
 =?utf-8?B?UEdpME5xMmZWUXVnbjBuL3M1Wi9RUE02TTNEd2NZcUFQK0JtUDZ4amkyRUNp?=
 =?utf-8?B?Ukw5YnU0aGE2SHlwakNHbWpQWTlWSVlmYUFISjF3SlZmelF6Y3pHcVNhM0Uw?=
 =?utf-8?B?clRGdndraWlibFhydlBNSEVEVHRSS3liSnFtN01GSVNSVDB4MU1GUlNsRUVM?=
 =?utf-8?B?Wmd4ZXhIMFNseEFoMitkVGdWUXJVTEdmc2IzNkJYb0dNUnRxMXJQMDE5ZVFm?=
 =?utf-8?B?WkFVMlp6Y2s5SVNVRlpIVGJtU2JLczExdU9iK3BRZk5sNzFoTWk5dTI0bUZi?=
 =?utf-8?B?b21VZEVRQkpJKzhiaFVKYUxMSnFkQTYwbDF0S2FYMWNsb1EyMFBLNm54OEZ5?=
 =?utf-8?B?RkRyM2xZaTBCaUhPeUNsVzhtQXY4MmpIWVMxQlhManI3MDdGUVgyTTdTd1N2?=
 =?utf-8?B?U01LVHZ5VXlnVzQ1WE5nQ0RFY2tuUFV5c0RMdXpWbG9pLzBnelJuZmdNUW9v?=
 =?utf-8?B?MGlHN3V4M0psZmZwdFRzWlkwL3JpNmNpUXJoaFVJa0FMSlpjcEdxVEtaTXl6?=
 =?utf-8?B?bFdzVnZpbXpqN2RWNGs3bWVTaWxoWTN2cEdnT1Z0cWRTY2NobzFhRml3cDJS?=
 =?utf-8?B?YllCQjVFM29PS3hFK2pURkNvUmhzYWlhbzZneWRHN0l1UE5PWDBuZWZiT2hI?=
 =?utf-8?B?a3RzeDNNaDB2UUE4VzlxeGJ0dk9hWCtOdjZ4ejZ5V0FGb1hsalN5b3RMSWc2?=
 =?utf-8?B?WWdUQ2pldVdRWEZsajlEV3RzemYzZ2FPWlhJMURpdTdKSWtaaGFlTmNmbEFC?=
 =?utf-8?B?K3BvaVhkK2xEdVU3Tk8xZHExNmlSNEQrZnZGanBVL0JTeVdwaU1haU1QZnd5?=
 =?utf-8?B?R25ZYStQZkRmLzhyT3Z1WGp2cHpVL2sycitQYkp2UkZsdlA0Vzk3eE1MRGNx?=
 =?utf-8?B?QXV0VEgzTEFIaFN1TDZhU0M2OUt4R29tS2ZuWnRMUDJyd2F4YXNLQTlqMUJp?=
 =?utf-8?B?TDZoOXZtaXhjMTRDRTRMTFJCUFdMK0xJZURpUkprZVg4dUlOT0FmaGhPNGJY?=
 =?utf-8?B?cFhMWkJ3bVRKdUh6T2ZPUDIrZEV6VW5WU2QwRmxydENMbURnMFJSUGtjS3hM?=
 =?utf-8?B?S0ZyWW1jejlVSW9ZcTVYUjNMKzNKSnZuTlBHVkJDbGlKeXo4RGZhL25YOWJX?=
 =?utf-8?B?S2FuTG1Ea2pBOXJwdytRbjM3WTN1b1pMa2tBcXhIT2hQQjg1WVZWUnJZNnVj?=
 =?utf-8?B?RVpjUGhxdUgzRHFqUDE5OXRxYlg4Sk5CU3FqZGM2c0p5eGtIUFJEOS9hMWhH?=
 =?utf-8?B?Um1HSytvKytIQUFDVUh3Q0NFU09wNTZvUS85V3h5TnVTVzJSUzFGU1BwZDhw?=
 =?utf-8?B?ZGx4OCsyNE93amE2VUJ3eExJaWlnY1FsZ0NsQVRFbFFmYjNINDZFajRkc3dt?=
 =?utf-8?B?ZGhINC9GSjZJSW05L0lhY3ZYcnk5S1luSGF3NkFubk5UdThicVVGcUJmSzM2?=
 =?utf-8?B?TldvL3ArSVdSL2FjOEkzQUtRckI5RjFPU0FoOWhsdTFnUTFEUlVUZFF0VEJp?=
 =?utf-8?Q?5xPpcG0ThNBYgR5xSJUwQpgOm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8df5ea6-27ee-44eb-a258-08dd2b3149ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 13:28:05.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f76b1/L/2YnX0GMah3VlAaaQGIEd8q4RlBz9jCn7cykWQ8F86tB2Oc86L/eCiAHpxBZJZe4HDHDDlwxr5jm1OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

+ (amd-gfx)

On 01/01/2025 07:03, Saleemkhan Jamadar wrote:
> #resending  patch
>
>  From 79cd62f882197505dbf9c489ead2b0bcab98209f Mon Sep 17 00:00:00 2001
> From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Date: Wed, 18 Dec 2024 19:30:22 +0530
> Subject: [PATCH] drm/amdgpu: user queue doorbell allocation for IP reqs
>
> Currenlty doorbell allocation handles only 64 bit db size.
>
> In case of VCN we need to allocated AGDB and per instance
> doorbell.VCN/UMSCH doorbell size is 32 bit and offset
> calculated is from specific range from the allocated page.
>
> With these changes individual IP can provide specific reqs
> for db allocation.
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 41 ++++++++++++++-----
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 ++++++
>   2 files changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index cba51bdf2e2c..4fff15e0d838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -163,18 +163,17 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   	amdgpu_bo_unref(&userq_obj->obj);
>   }
>   
> -static uint64_t
> +uint64_t
>   amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> -				     struct amdgpu_usermode_queue *queue,
> -				     struct drm_file *filp,
> -				     uint32_t doorbell_offset)
> +				     struct amdgpu_db_info *db_info,
> +				     struct drm_file *filp)
>   {
>   	uint64_t index;
>   	struct drm_gem_object *gobj;
> -	struct amdgpu_userq_obj *db_obj = &queue->db_obj;
> -	int r;
> +	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
> +	int r, db_size;
>   
> -	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
> +	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
>   	if (gobj == NULL) {
>   		DRM_ERROR("Can't find GEM object for doorbell\n");
>   		return -EINVAL;
> @@ -196,8 +195,23 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   		goto unpin_bo;
>   	}
>   
> +	switch (db_info->queue_type) {
> +	case AMDGPU_HW_IP_GFX:
> +	case AMDGPU_HW_IP_COMPUTE:
> +	case AMDGPU_HW_IP_DMA:
> +		db_size = sizeof(u64);
> +		break;
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		db_size = sizeof(u32);
> +		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
> +		break;
> +	default:
> +		DRM_WARN("User queues not supported for IP (%d )\n", db_info->queue_type);
> +		return -EINVAL;
> +	}
> +
>   	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
> -					     doorbell_offset, sizeof(u64));
> +					     db_info->doorbell_offset, db_size);
>   	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
>   	amdgpu_bo_unreserve(db_obj->obj);
>   	return index;
> @@ -242,6 +256,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_db_info db_info;
>   	uint64_t index;
>   	int qid, r = 0;
>   
> @@ -269,19 +284,23 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   	queue->doorbell_handle = args->in.doorbell_handle;
> -	queue->doorbell_index = args->in.doorbell_offset;
Nack, this is going to break mapping/unmapping for GFX UQ. Nothing 
should be removed from the queue structure, as all of it is accounted for.
>   	queue->queue_type = args->in.ip_type;
>   	queue->vm = &fpriv->vm;
>   
> +	db_info.queue_type = queue->queue_type;
> +	db_info.doorbell_handle = queue->doorbell_handle;
> +	db_info.db_obj = &queue->db_obj;
> +	db_info.doorbell_offset = args->in.doorbell_offset;
> +
I can see that all the information you are adding in struct db_info is 
coming from queue only, then why to add a new structure here at all ? 
Instead, you can just do this in function

amdgpu_userqueue_get_doorbell_index():

db_size = sizeof(u62);

switch(queue->queue_type) {
case VCN:
     queue->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
     db_size = sizeof(u32);
     break;
}

<same doorbell offset calculation as usual>

- Shashank

>   	/* Convert relative doorbell offset into absolute doorbell index */
> -	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
> +	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, filp);
>   	if (index == (uint64_t)-EINVAL) {
>   		DRM_ERROR("Failed to get doorbell for queue\n");
>   		kfree(queue);
>   		goto unlock;
>   	}
> -	queue->doorbell_index = index;
>   
> +	queue->doorbell_index = index;
>   	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 2bf28f3454cb..3d54601c6a24 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -39,6 +39,13 @@ struct amdgpu_userq_obj {
>   	struct amdgpu_bo *obj;
>   };
>   
> +struct amdgpu_db_info {
> +	uint64_t doorbell_handle;
> +	uint32_t queue_type;
> +	uint32_t doorbell_offset;
> +	struct amdgpu_userq_obj	*db_obj;
> +};
> +
>   struct amdgpu_usermode_queue {
>   	int			queue_type;
>   	uint8_t			queue_active;
> @@ -93,4 +100,9 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   void amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr);
>   
>   int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
> +
> +uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +				     struct amdgpu_db_info *db_info,
> +				     struct drm_file *filp);
> +
>   #endif
