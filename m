Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C52C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 20:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B66B112350;
	Mon,  6 May 2024 20:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKNVvckb";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC344112183
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 20:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTmw/UhtgWvn++EoChJLCNxW1dhVF/CfgNfXZC3xVr1eF6iDF6xH3CF94GWLDhwnHcjkNS1ZTz85oe/6mpOsdmMPvOaW0JV8QK4C8JSbl0HQRgeSs+kvmAciMwH5ub72ywK/tfOU/v9TPenJz9StGpxcC49eWK3CD6u3sw29QS/D89tegwCwIg6zVE4Wy+BF3AF7MjljNDJF4CuUSDCaXm7Bvs7emDw1XGFCL8JiFCeJHzm2jhqB1amzkUtuTwCMLYvvEoba1sWL8d07aLCAweELCTUKyEUPIKA2aygFn243vKn8ItiRJ1HiNUIEjfEx0FfQVg/K04m8FLGXl6DZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fttQFl8KY1KcPvKudvtBR3B0B+RY2p5KdUof3IJHpG4=;
 b=dJnC4+YZFVMWoEWefTuq8dz/8gaUTjXG2epzXZw2LAG0hmfg2ph2XRSrF825r4fD88KSaB3135NgnEbtFheMChib7HfsWMkNpMYQ7RZOvvrrZV2p2k6yoYd/cnfRfhqiGDjBQbZp+Jc0s/MXX+aLms2B6ZWFF3ioRlx5K9+wg2Ek7lZaNFhQoeDOJLYAicGslUD1M+ppsuz7VvvxvJktswSQ00ubaFJbyX5aDfN5BpNAKhLcrPbWD6tCRecOlCp0TVYVKNaXivJiUtxzJI5IF7z1OT75+6OSyqwdyfbG85vSkblhspDhRHH5GQpCbZYGTW5+KNeWno2y/O7K5jmILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fttQFl8KY1KcPvKudvtBR3B0B+RY2p5KdUof3IJHpG4=;
 b=LKNVvckbdiRWgbDIcVfCEb5skAKrt1ZsyHsPd3iTdNeaOzkvayg7oREaP/LAIU9xmWJq1UNNZ5hsfgdfIEt//+hpOknW6bmLCByj2FfqqwngUlauA8EqVREQFuynYUuqRyQtXCndIbjHnIIm42mUATRIY9/doVhu963ZbIAYlVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:10:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:10:53 +0000
Message-ID: <85026e75-76b7-47d8-b1b1-2045a1fa928c@amd.com>
Date: Mon, 6 May 2024 16:10:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Refactor kfd CRIU into its own file
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240506192021.3884309-1-David.Francis@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240506192021.3884309-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ec048a-9c85-458b-e360-08dc6e08a1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZhOWhkSzE5RFhZVlg5OU9Bd2dFK3Bpb3BUWTduL3Y2SDFqT29jMVRZOUxO?=
 =?utf-8?B?VUpYb3B6VlB5UG5wTDgwVTNFTXU2R25HdEZGS2gySmpMd0t0YWtzeDYyOWk0?=
 =?utf-8?B?OHBiaVpjbXpadnpyL2o5c25RVEtpUktJSFA2QnNYREZSU0pJWXNINVZOQXRC?=
 =?utf-8?B?NzVJdExPRVRldmVqUlhlSThXbXcvNi9HQUNhVFB4L1lCQlpuWk9Ld2JRajlt?=
 =?utf-8?B?aks1Y3FPbDcyM2tJT0gydWlrUXpDNUlHWCtuajFORmJiUW03RUhncTNUYzkw?=
 =?utf-8?B?UjBOY3k5OWVxZXlTYWVMVjhmOSsxUUVjSUVBQlpVYmRuTnU4V1FJcUdTY0pO?=
 =?utf-8?B?TjVnTGVaVzVOcHp3RFNIVVVoWGg0YTZTOTJGbmpQNGg2c2l3OVgwYTVSWDBt?=
 =?utf-8?B?dnVNMCsxWmliZjhHbU53V1lCZklpa250Q1M3UVdQRU4vUjFFRUNhMWRVU0w2?=
 =?utf-8?B?QUhSbmw3bGlWM3BiL1pxbmVDQS9aVGsrY2RLeGVEYU5rS0tKUHRIeFczK25I?=
 =?utf-8?B?MDZQMStCaEE2R2wyYjlZV0NjZ2gvN2tFZkFJckIzZkxGVFBNNTZoZkZZbWQ5?=
 =?utf-8?B?RndnQUdXcjl1VFluaWVxMGNOc2c0UG1JWElMVXgzcUhRekkvNmJJVENYYmov?=
 =?utf-8?B?Y1N6NGN2RC9YNGE2dUxhM1I2MlBtYmtyd1doMUpDVzRPeFBKdm00YUwrcXlH?=
 =?utf-8?B?N2RHMVJWdVk1RG92NVQvKzRBdERHT1ZJSWtpV1ZpaU5kYTNKUWo5YjRPMUxQ?=
 =?utf-8?B?WGozalRjYUFmcmhHRkdaVk90MlozOTUzZGpYb3htbGg4NGRVcXFnN29abTlu?=
 =?utf-8?B?M1hTakxwQ3lNeWU4OVh4UkFZZDh2T3VjWHJpMUF4WHRaMkhNanJpSkhwKzVa?=
 =?utf-8?B?RkhaMFdvNWVsWmVjL3VlQXBuTG9nRDVEVDNsNHdpUXhYdHBGeTRWZTJJV2dl?=
 =?utf-8?B?MnpMbjAxTjdDcS93cmdxak9tZTN1bUtadmZoTC9zSDhuSWdYVmc4TkxmMDla?=
 =?utf-8?B?SnUyUDd3VGM0NXlxTCsxNGRzeWk4T0pabVFkMXd4Y0pRaTB4dVk1c2pCTVFG?=
 =?utf-8?B?QVpLUzhQcjQ3cUZVc1R0WFVhdFEyWndZNFhHYnFiT0RmZ3h1a1FFSTRKNDhj?=
 =?utf-8?B?Y0tQNEhQVUZ3SVhFcVkrR25kQWVNNkJYb2F5NE10Sk5uMENoUmlsNDFseEdj?=
 =?utf-8?B?SG5rTFNibC95L29yY1VZY3Y2S3RpamQ2VXFqQlJQSncyOWUyaURqRmZIZ3Ji?=
 =?utf-8?B?TFBhc3VaT205c01YN0ZsVUJGaGYrY3c4RU51MG53L3UyYXhIMGJlNndTRnpE?=
 =?utf-8?B?S1F1Z3FTTHFSOFNnTTZhRFEzYzRnSGJKVGhoUncxU2drbWwxS0NmMGUyU1ht?=
 =?utf-8?B?U1JHdlBOKzBRQURSczNCWkVmVFlwNmovMlEzaVlrNkR4SHlFc3kzc253dlJ0?=
 =?utf-8?B?eGtsblZTR0VHUmhGNkxtWlROcWZJeCtVbDRUTmg5Wnd1WTduZ1JDZ1dlM1pG?=
 =?utf-8?B?d2NhbkREdXYxTlBhSHUxNGp4dTJLY2ZuQ1kxVS90RlBBU0I5akpYWDJ1VTcz?=
 =?utf-8?B?bm9uOWhNc01PRWUxQ01WbHJObWhsRllGc0Qzck0yMjhKeGwvT01vR0tNNmo0?=
 =?utf-8?B?dXdic0o2UWVxbXNCczdaRVJEbEdVSmdGR21kVkVOeFlObDlVQTJPUHJjUlFp?=
 =?utf-8?B?d3RjcjdsazRINGcrMDBUeGhLVDBvb1lMckJTWjdoRzd2VFNPZ1gzUUVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NDTXhLOFlldmVjNnAwbWtkUWpuWkljWm43dWR3RnRiZC9QY29PZGpRUlo5?=
 =?utf-8?B?M1ZsTlNET0pQd0ZzempEeGhyNVVOTUs1bWVLRG9OQlNraEhrSjNPK3ZPelJk?=
 =?utf-8?B?emY1S2gwNDYxVkNEcjM2eUcrd05JSlQxMXNzVW9YdCtpQjlxNjl2MnJvUXY5?=
 =?utf-8?B?K3pvaGE3ZnRmeGRzSmxzOXZ6cGxGYlNoa0l0aWZDQ1ZxanZYKzRjcTdFRzVZ?=
 =?utf-8?B?YjM2bDBkUTNvRy9raDMzaWkyMzRwSDJYVUFqTGxZR3BONHpPd0N6ai9IbjI2?=
 =?utf-8?B?UkJqdFJUYmg4QVBiWTJISnNZeEdzVEU1YkVXbXp3TFhLSE1NeFBKZzhUY3Rv?=
 =?utf-8?B?bE5QcWY3eWYxczg1VmpZeEovZkJQbXdFdS9YaWMybWpRcFpTZHZiTnVpbHFq?=
 =?utf-8?B?cEdzOGJ6cUp4REdoV3A1SHQwRnFDd1lTSTZINGZ3c1lEMUo1Ulg1MGgwUzFC?=
 =?utf-8?B?QmdYSVJJT0tQNElUTzhUK1VSbE9kVVJDME5BWWRXdVkyWm9mSUVuYjVUOHRR?=
 =?utf-8?B?TlhmTG5YYkczeFo0YjRWejBVRS9nUUV5d3BzK0d0dDNwQUQ4TGdteEFIYWFZ?=
 =?utf-8?B?bjRWakpiTVNLQ0FuaHpob1cwU0VxVlhtc3FYaHZOM0dQbUk3RXdCTWo4Y3Zx?=
 =?utf-8?B?SmIxR3JFRWdqYlF0SytnenJPM1BleS9TNzFQelVwL1hvclNDYzZoaTd1TUlw?=
 =?utf-8?B?L05EWlhUaG1FOGU2K29ZaWU4cEwyanIvY0wvemlEQk5IMitWVFd6QWZGaHhl?=
 =?utf-8?B?b3RlSms4MTd4OHhaUmpUNzV4aWM4VjVkWkxXSldaUzkzbWRZYWJNRm5DZFRv?=
 =?utf-8?B?YjhNdXd6MU92VHNuY1NISlpVSHVEeHlBSENmN1BLZ09SS2xuU1RpeEdXSG5O?=
 =?utf-8?B?akl6MnZYdmx2ckkwZ0RhOHkyR3VncFVVS2VuczNGaEMzQmlhakVzL2dBT0dK?=
 =?utf-8?B?azNYcm9SMnM4dkZMZ0dneHBGa3FJbHVlM0ZvVEh4em1vR0RROEt2Q1NidVhT?=
 =?utf-8?B?bGtSbWsybVhseW1LNlczSDVYUkE5cm5uakdBUzRPT0pmK21ibHhISmRpY3Jk?=
 =?utf-8?B?Y0NrTldPc2QyUjJvMXVFbEZSZEw1RWxWcFRqZ2FBUVE0QVhIUkJtYVJ1NXdw?=
 =?utf-8?B?SnB0YkJLT2Q0OE5UOEt5ZHhWdEdRSnF1bGQrZzlOYUhsR0hlaTc2eDE1cnBv?=
 =?utf-8?B?OHBGQitlVU1icnZNU0kzV0lnNmhJazcxR21HaWpENUl5NkJzZEJ0SmxYNE5T?=
 =?utf-8?B?MDNQQlBiRnhKbFZEb3FIMTU5TDRXTVhWSXN2NDJYT3psMVk2NE9rQzAvbGh3?=
 =?utf-8?B?b2VYZGY2ZE5vWTVpSGlsM2tVQ05naWc4bjNqdEZvRFhGOVRkK09qaUhoQVNF?=
 =?utf-8?B?L3FwQkd1NW0vQmRwditLRE9odzJyVlBic1F2amlzWXRtSW5wYzM2LzBGTDFr?=
 =?utf-8?B?ditodWFQNXc2dFlCb012cTFJWlNTbGJsL2MyZHl6Z0pNNkxLazZsd2dJZFFr?=
 =?utf-8?B?SmU2UW10enNpUzZQdG5OaEtWSlQrYUc5RldnbnorRzZVQXhiRnJ3L2Rwcmpy?=
 =?utf-8?B?TVJWSDYwY0pIU2p2WmJsdjh5dnF5UVE0WHNkdVVCYU5NZmtpYWk1dmdJbXdw?=
 =?utf-8?B?TGZEN24rMGo1d0tzTDdkMy9VYi95bW5Kc0NqUmNtYlZoN2RRR0Nuem8wUlZP?=
 =?utf-8?B?MUk1UnBneGZxdytpNmYyNlVVbFBUWUJ1SmxqSmF3bCszY3JpVU9nRkthVU54?=
 =?utf-8?B?dHJjZ2FkbkRacWoxYmthVENJZW16VHlZYWVFY3c1Nk9ubEdpaGlRbzBUc2ZY?=
 =?utf-8?B?Z1VkYXM4Y1ZrVjZRL1d6WDdLNmo0SzhPaHFORXN0YlRVRUUxSXlucUNRQVJN?=
 =?utf-8?B?QkhCWkt3Ny9pZzUwUHhaKzRXZHZRNjQvQnBRS3dZTHN5ZVpiMW4zSkFxZDBq?=
 =?utf-8?B?M3NobTJFVHVBeDhPNEc5cmlHd3M1TlhlZFRRNm43akdkS0JLdmx3SXNHYjJD?=
 =?utf-8?B?OTJsMytENEZqam5RcXFxb3hkOWFqNGJ6c0RIUUVOVFZCTFpJM1FIaXc1UE1J?=
 =?utf-8?B?WGNobEpEUWl1a3ZNQ2VyR2luaUV3eXF0VnU0VVQzMUlFS2ZsV1o1WWw3YlB0?=
 =?utf-8?Q?jyDrqpGJvZJmtSbDUOe94h+du?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ec048a-9c85-458b-e360-08dc6e08a1df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:10:53.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0RmFLXFLyyRHKqbZAb+js06qKVNBBMGu11X/UMhKAov1EdAAFk++GRpx3k2LM05DxusZ/tS89R6YSOMUnKHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
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


On 2024-05-06 15:20, David Francis wrote:
> The kfd CRIU code takes up about a thousand lines
> in the kfd_chardev file; move it to its own file.
>
> No functional change intended.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/Makefile      |   1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 972 +---------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_criu.c    | 989 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_criu.h    |  50 ++
>   4 files changed, 1046 insertions(+), 966 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_criu.c
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_criu.h
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
> index 0d3d8972240d..e06af4073ac5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -32,6 +32,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
>   		$(AMDKFD_PATH)/kfd_flat_memory.o \
>   		$(AMDKFD_PATH)/kfd_process.o \
>   		$(AMDKFD_PATH)/kfd_queue.o \
> +		$(AMDKFD_PATH)/kfd_criu.o \

Any particular reason for adding this in the middle and not the end?


>   		$(AMDKFD_PATH)/kfd_mqd_manager.o \
>   		$(AMDKFD_PATH)/kfd_mqd_manager_cik.o \
>   		$(AMDKFD_PATH)/kfd_mqd_manager_vi.o \
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6b713fb0b818..e6e44a199a93 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -45,6 +45,7 @@

Can you remove #include <linux/fdtable.h> and "amdgpu_dma_buf.h" here? 
Or is it still needed by something else left in kfd_chardev.c?

Other than that, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   #include "kfd_smi_events.h"
>   #include "amdgpu_dma_buf.h"
>   #include "kfd_debug.h"
> +#include "kfd_criu.h"
>   
>   static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>   static int kfd_open(struct inode *, struct file *);
> @@ -1751,967 +1752,6 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   }
>   #endif
>   
> -static int criu_checkpoint_process(struct kfd_process *p,
> -			     uint8_t __user *user_priv_data,
> -			     uint64_t *priv_offset)
> -{
> -	struct kfd_criu_process_priv_data process_priv;
> -	int ret;
> -
> -	memset(&process_priv, 0, sizeof(process_priv));
> -
> -	process_priv.version = KFD_CRIU_PRIV_VERSION;
> -	/* For CR, we don't consider negative xnack mode which is used for
> -	 * querying without changing it, here 0 simply means disabled and 1
> -	 * means enabled so retry for finding a valid PTE.
> -	 */
> -	process_priv.xnack_mode = p->xnack_enabled ? 1 : 0;
> -
> -	ret = copy_to_user(user_priv_data + *priv_offset,
> -				&process_priv, sizeof(process_priv));
> -
> -	if (ret) {
> -		pr_err("Failed to copy process information to user\n");
> -		ret = -EFAULT;
> -	}
> -
> -	*priv_offset += sizeof(process_priv);
> -	return ret;
> -}
> -
> -static int criu_checkpoint_devices(struct kfd_process *p,
> -			     uint32_t num_devices,
> -			     uint8_t __user *user_addr,
> -			     uint8_t __user *user_priv_data,
> -			     uint64_t *priv_offset)
> -{
> -	struct kfd_criu_device_priv_data *device_priv = NULL;
> -	struct kfd_criu_device_bucket *device_buckets = NULL;
> -	int ret = 0, i;
> -
> -	device_buckets = kvzalloc(num_devices * sizeof(*device_buckets), GFP_KERNEL);
> -	if (!device_buckets) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	device_priv = kvzalloc(num_devices * sizeof(*device_priv), GFP_KERNEL);
> -	if (!device_priv) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	for (i = 0; i < num_devices; i++) {
> -		struct kfd_process_device *pdd = p->pdds[i];
> -
> -		device_buckets[i].user_gpu_id = pdd->user_gpu_id;
> -		device_buckets[i].actual_gpu_id = pdd->dev->id;
> -
> -		/*
> -		 * priv_data does not contain useful information for now and is reserved for
> -		 * future use, so we do not set its contents.
> -		 */
> -	}
> -
> -	ret = copy_to_user(user_addr, device_buckets, num_devices * sizeof(*device_buckets));
> -	if (ret) {
> -		pr_err("Failed to copy device information to user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -
> -	ret = copy_to_user(user_priv_data + *priv_offset,
> -			   device_priv,
> -			   num_devices * sizeof(*device_priv));
> -	if (ret) {
> -		pr_err("Failed to copy device information to user\n");
> -		ret = -EFAULT;
> -	}
> -	*priv_offset += num_devices * sizeof(*device_priv);
> -
> -exit:
> -	kvfree(device_buckets);
> -	kvfree(device_priv);
> -	return ret;
> -}
> -
> -static uint32_t get_process_num_bos(struct kfd_process *p)
> -{
> -	uint32_t num_of_bos = 0;
> -	int i;
> -
> -	/* Run over all PDDs of the process */
> -	for (i = 0; i < p->n_pdds; i++) {
> -		struct kfd_process_device *pdd = p->pdds[i];
> -		void *mem;
> -		int id;
> -
> -		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
> -			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
> -
> -			if (!kgd_mem->va || kgd_mem->va > pdd->gpuvm_base)
> -				num_of_bos++;
> -		}
> -	}
> -	return num_of_bos;
> -}
> -
> -static int criu_get_prime_handle(struct kgd_mem *mem,
> -				 int flags, u32 *shared_fd)
> -{
> -	struct dma_buf *dmabuf;
> -	int ret;
> -
> -	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
> -	if (ret) {
> -		pr_err("dmabuf export failed for the BO\n");
> -		return ret;
> -	}
> -
> -	ret = dma_buf_fd(dmabuf, flags);
> -	if (ret < 0) {
> -		pr_err("dmabuf create fd failed, ret:%d\n", ret);
> -		goto out_free_dmabuf;
> -	}
> -
> -	*shared_fd = ret;
> -	return 0;
> -
> -out_free_dmabuf:
> -	dma_buf_put(dmabuf);
> -	return ret;
> -}
> -
> -static int criu_checkpoint_bos(struct kfd_process *p,
> -			       uint32_t num_bos,
> -			       uint8_t __user *user_bos,
> -			       uint8_t __user *user_priv_data,
> -			       uint64_t *priv_offset)
> -{
> -	struct kfd_criu_bo_bucket *bo_buckets;
> -	struct kfd_criu_bo_priv_data *bo_privs;
> -	int ret = 0, pdd_index, bo_index = 0, id;
> -	void *mem;
> -
> -	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
> -	if (!bo_buckets)
> -		return -ENOMEM;
> -
> -	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
> -	if (!bo_privs) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
> -		struct kfd_process_device *pdd = p->pdds[pdd_index];
> -		struct amdgpu_bo *dumper_bo;
> -		struct kgd_mem *kgd_mem;
> -
> -		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
> -			struct kfd_criu_bo_bucket *bo_bucket;
> -			struct kfd_criu_bo_priv_data *bo_priv;
> -			int i, dev_idx = 0;
> -
> -			if (!mem) {
> -				ret = -ENOMEM;
> -				goto exit;
> -			}
> -
> -			kgd_mem = (struct kgd_mem *)mem;
> -			dumper_bo = kgd_mem->bo;
> -
> -			/* Skip checkpointing BOs that are used for Trap handler
> -			 * code and state. Currently, these BOs have a VA that
> -			 * is less GPUVM Base
> -			 */
> -			if (kgd_mem->va && kgd_mem->va <= pdd->gpuvm_base)
> -				continue;
> -
> -			bo_bucket = &bo_buckets[bo_index];
> -			bo_priv = &bo_privs[bo_index];
> -
> -			bo_bucket->gpu_id = pdd->user_gpu_id;
> -			bo_bucket->addr = (uint64_t)kgd_mem->va;
> -			bo_bucket->size = amdgpu_bo_size(dumper_bo);
> -			bo_bucket->alloc_flags = (uint32_t)kgd_mem->alloc_flags;
> -			bo_priv->idr_handle = id;
> -
> -			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> -				ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
> -								&bo_priv->user_addr);
> -				if (ret) {
> -					pr_err("Failed to obtain user address for user-pointer bo\n");
> -					goto exit;
> -				}
> -			}
> -			if (bo_bucket->alloc_flags
> -			    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> -				ret = criu_get_prime_handle(kgd_mem,
> -						bo_bucket->alloc_flags &
> -						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
> -						&bo_bucket->dmabuf_fd);
> -				if (ret)
> -					goto exit;
> -			} else {
> -				bo_bucket->dmabuf_fd = KFD_INVALID_FD;
> -			}
> -
> -			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> -				bo_bucket->offset = KFD_MMAP_TYPE_DOORBELL |
> -					KFD_MMAP_GPU_ID(pdd->dev->id);
> -			else if (bo_bucket->alloc_flags &
> -				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
> -				bo_bucket->offset = KFD_MMAP_TYPE_MMIO |
> -					KFD_MMAP_GPU_ID(pdd->dev->id);
> -			else
> -				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
> -
> -			for (i = 0; i < p->n_pdds; i++) {
> -				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->dev->adev, kgd_mem))
> -					bo_priv->mapped_gpuids[dev_idx++] = p->pdds[i]->user_gpu_id;
> -			}
> -
> -			pr_debug("bo_size = 0x%llx, bo_addr = 0x%llx bo_offset = 0x%llx\n"
> -					"gpu_id = 0x%x alloc_flags = 0x%x idr_handle = 0x%x",
> -					bo_bucket->size,
> -					bo_bucket->addr,
> -					bo_bucket->offset,
> -					bo_bucket->gpu_id,
> -					bo_bucket->alloc_flags,
> -					bo_priv->idr_handle);
> -			bo_index++;
> -		}
> -	}
> -
> -	ret = copy_to_user(user_bos, bo_buckets, num_bos * sizeof(*bo_buckets));
> -	if (ret) {
> -		pr_err("Failed to copy BO information to user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -
> -	ret = copy_to_user(user_priv_data + *priv_offset, bo_privs, num_bos * sizeof(*bo_privs));
> -	if (ret) {
> -		pr_err("Failed to copy BO priv information to user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -
> -	*priv_offset += num_bos * sizeof(*bo_privs);
> -
> -exit:
> -	while (ret && bo_index--) {
> -		if (bo_buckets[bo_index].alloc_flags
> -		    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
> -			close_fd(bo_buckets[bo_index].dmabuf_fd);
> -	}
> -
> -	kvfree(bo_buckets);
> -	kvfree(bo_privs);
> -	return ret;
> -}
> -
> -static int criu_get_process_object_info(struct kfd_process *p,
> -					uint32_t *num_devices,
> -					uint32_t *num_bos,
> -					uint32_t *num_objects,
> -					uint64_t *objs_priv_size)
> -{
> -	uint64_t queues_priv_data_size, svm_priv_data_size, priv_size;
> -	uint32_t num_queues, num_events, num_svm_ranges;
> -	int ret;
> -
> -	*num_devices = p->n_pdds;
> -	*num_bos = get_process_num_bos(p);
> -
> -	ret = kfd_process_get_queue_info(p, &num_queues, &queues_priv_data_size);
> -	if (ret)
> -		return ret;
> -
> -	num_events = kfd_get_num_events(p);
> -
> -	ret = svm_range_get_info(p, &num_svm_ranges, &svm_priv_data_size);
> -	if (ret)
> -		return ret;
> -
> -	*num_objects = num_queues + num_events + num_svm_ranges;
> -
> -	if (objs_priv_size) {
> -		priv_size = sizeof(struct kfd_criu_process_priv_data);
> -		priv_size += *num_devices * sizeof(struct kfd_criu_device_priv_data);
> -		priv_size += *num_bos * sizeof(struct kfd_criu_bo_priv_data);
> -		priv_size += queues_priv_data_size;
> -		priv_size += num_events * sizeof(struct kfd_criu_event_priv_data);
> -		priv_size += svm_priv_data_size;
> -		*objs_priv_size = priv_size;
> -	}
> -	return 0;
> -}
> -
> -static int criu_checkpoint(struct file *filep,
> -			   struct kfd_process *p,
> -			   struct kfd_ioctl_criu_args *args)
> -{
> -	int ret;
> -	uint32_t num_devices, num_bos, num_objects;
> -	uint64_t priv_size, priv_offset = 0, bo_priv_offset;
> -
> -	if (!args->devices || !args->bos || !args->priv_data)
> -		return -EINVAL;
> -
> -	mutex_lock(&p->mutex);
> -
> -	if (!p->n_pdds) {
> -		pr_err("No pdd for given process\n");
> -		ret = -ENODEV;
> -		goto exit_unlock;
> -	}
> -
> -	/* Confirm all process queues are evicted */
> -	if (!p->queues_paused) {
> -		pr_err("Cannot dump process when queues are not in evicted state\n");
> -		/* CRIU plugin did not call op PROCESS_INFO before checkpointing */
> -		ret = -EINVAL;
> -		goto exit_unlock;
> -	}
> -
> -	ret = criu_get_process_object_info(p, &num_devices, &num_bos, &num_objects, &priv_size);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	if (num_devices != args->num_devices ||
> -	    num_bos != args->num_bos ||
> -	    num_objects != args->num_objects ||
> -	    priv_size != args->priv_data_size) {
> -
> -		ret = -EINVAL;
> -		goto exit_unlock;
> -	}
> -
> -	/* each function will store private data inside priv_data and adjust priv_offset */
> -	ret = criu_checkpoint_process(p, (uint8_t __user *)args->priv_data, &priv_offset);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	ret = criu_checkpoint_devices(p, num_devices, (uint8_t __user *)args->devices,
> -				(uint8_t __user *)args->priv_data, &priv_offset);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	/* Leave room for BOs in the private data. They need to be restored
> -	 * before events, but we checkpoint them last to simplify the error
> -	 * handling.
> -	 */
> -	bo_priv_offset = priv_offset;
> -	priv_offset += num_bos * sizeof(struct kfd_criu_bo_priv_data);
> -
> -	if (num_objects) {
> -		ret = kfd_criu_checkpoint_queues(p, (uint8_t __user *)args->priv_data,
> -						 &priv_offset);
> -		if (ret)
> -			goto exit_unlock;
> -
> -		ret = kfd_criu_checkpoint_events(p, (uint8_t __user *)args->priv_data,
> -						 &priv_offset);
> -		if (ret)
> -			goto exit_unlock;
> -
> -		ret = kfd_criu_checkpoint_svm(p, (uint8_t __user *)args->priv_data, &priv_offset);
> -		if (ret)
> -			goto exit_unlock;
> -	}
> -
> -	/* This must be the last thing in this function that can fail.
> -	 * Otherwise we leak dmabuf file descriptors.
> -	 */
> -	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> -			   (uint8_t __user *)args->priv_data, &bo_priv_offset);
> -
> -exit_unlock:
> -	mutex_unlock(&p->mutex);
> -	if (ret)
> -		pr_err("Failed to dump CRIU ret:%d\n", ret);
> -	else
> -		pr_debug("CRIU dump ret:%d\n", ret);
> -
> -	return ret;
> -}
> -
> -static int criu_restore_process(struct kfd_process *p,
> -				struct kfd_ioctl_criu_args *args,
> -				uint64_t *priv_offset,
> -				uint64_t max_priv_data_size)
> -{
> -	int ret = 0;
> -	struct kfd_criu_process_priv_data process_priv;
> -
> -	if (*priv_offset + sizeof(process_priv) > max_priv_data_size)
> -		return -EINVAL;
> -
> -	ret = copy_from_user(&process_priv,
> -				(void __user *)(args->priv_data + *priv_offset),
> -				sizeof(process_priv));
> -	if (ret) {
> -		pr_err("Failed to copy process private information from user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -	*priv_offset += sizeof(process_priv);
> -
> -	if (process_priv.version != KFD_CRIU_PRIV_VERSION) {
> -		pr_err("Invalid CRIU API version (checkpointed:%d current:%d)\n",
> -			process_priv.version, KFD_CRIU_PRIV_VERSION);
> -		return -EINVAL;
> -	}
> -
> -	pr_debug("Setting XNACK mode\n");
> -	if (process_priv.xnack_mode && !kfd_process_xnack_mode(p, true)) {
> -		pr_err("xnack mode cannot be set\n");
> -		ret = -EPERM;
> -		goto exit;
> -	} else {
> -		pr_debug("set xnack mode: %d\n", process_priv.xnack_mode);
> -		p->xnack_enabled = process_priv.xnack_mode;
> -	}
> -
> -exit:
> -	return ret;
> -}
> -
> -static int criu_restore_devices(struct kfd_process *p,
> -				struct kfd_ioctl_criu_args *args,
> -				uint64_t *priv_offset,
> -				uint64_t max_priv_data_size)
> -{
> -	struct kfd_criu_device_bucket *device_buckets;
> -	struct kfd_criu_device_priv_data *device_privs;
> -	int ret = 0;
> -	uint32_t i;
> -
> -	if (args->num_devices != p->n_pdds)
> -		return -EINVAL;
> -
> -	if (*priv_offset + (args->num_devices * sizeof(*device_privs)) > max_priv_data_size)
> -		return -EINVAL;
> -
> -	device_buckets = kmalloc_array(args->num_devices, sizeof(*device_buckets), GFP_KERNEL);
> -	if (!device_buckets)
> -		return -ENOMEM;
> -
> -	ret = copy_from_user(device_buckets, (void __user *)args->devices,
> -				args->num_devices * sizeof(*device_buckets));
> -	if (ret) {
> -		pr_err("Failed to copy devices buckets from user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -
> -	for (i = 0; i < args->num_devices; i++) {
> -		struct kfd_node *dev;
> -		struct kfd_process_device *pdd;
> -		struct file *drm_file;
> -
> -		/* device private data is not currently used */
> -
> -		if (!device_buckets[i].user_gpu_id) {
> -			pr_err("Invalid user gpu_id\n");
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -
> -		dev = kfd_device_by_id(device_buckets[i].actual_gpu_id);
> -		if (!dev) {
> -			pr_err("Failed to find device with gpu_id = %x\n",
> -				device_buckets[i].actual_gpu_id);
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -
> -		pdd = kfd_get_process_device_data(dev, p);
> -		if (!pdd) {
> -			pr_err("Failed to get pdd for gpu_id = %x\n",
> -					device_buckets[i].actual_gpu_id);
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -		pdd->user_gpu_id = device_buckets[i].user_gpu_id;
> -
> -		drm_file = fget(device_buckets[i].drm_fd);
> -		if (!drm_file) {
> -			pr_err("Invalid render node file descriptor sent from plugin (%d)\n",
> -				device_buckets[i].drm_fd);
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -
> -		if (pdd->drm_file) {
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -
> -		/* create the vm using render nodes for kfd pdd */
> -		if (kfd_process_device_init_vm(pdd, drm_file)) {
> -			pr_err("could not init vm for given pdd\n");
> -			/* On success, the PDD keeps the drm_file reference */
> -			fput(drm_file);
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -		/*
> -		 * pdd now already has the vm bound to render node so below api won't create a new
> -		 * exclusive kfd mapping but use existing one with renderDXXX but is still needed
> -		 * for iommu v2 binding  and runtime pm.
> -		 */
> -		pdd = kfd_bind_process_to_device(dev, p);
> -		if (IS_ERR(pdd)) {
> -			ret = PTR_ERR(pdd);
> -			goto exit;
> -		}
> -
> -		if (!pdd->qpd.proc_doorbells) {
> -			ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
> -			if (ret)
> -				goto exit;
> -		}
> -	}
> -
> -	/*
> -	 * We are not copying device private data from user as we are not using the data for now,
> -	 * but we still adjust for its private data.
> -	 */
> -	*priv_offset += args->num_devices * sizeof(*device_privs);
> -
> -exit:
> -	kfree(device_buckets);
> -	return ret;
> -}
> -
> -static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
> -				      struct kfd_criu_bo_bucket *bo_bucket,
> -				      struct kfd_criu_bo_priv_data *bo_priv,
> -				      struct kgd_mem **kgd_mem)
> -{
> -	int idr_handle;
> -	int ret;
> -	const bool criu_resume = true;
> -	u64 offset;
> -
> -	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
> -		if (bo_bucket->size !=
> -				kfd_doorbell_process_slice(pdd->dev->kfd))
> -			return -EINVAL;
> -
> -		offset = kfd_get_process_doorbells(pdd);
> -		if (!offset)
> -			return -ENOMEM;
> -	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
> -		/* MMIO BOs need remapped bus address */
> -		if (bo_bucket->size != PAGE_SIZE) {
> -			pr_err("Invalid page size\n");
> -			return -EINVAL;
> -		}
> -		offset = pdd->dev->adev->rmmio_remap.bus_addr;
> -		if (!offset) {
> -			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
> -			return -ENOMEM;
> -		}
> -	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> -		offset = bo_priv->user_addr;
> -	}
> -	/* Create the BO */
> -	ret = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(pdd->dev->adev, bo_bucket->addr,
> -						      bo_bucket->size, pdd->drm_priv, kgd_mem,
> -						      &offset, bo_bucket->alloc_flags, criu_resume);
> -	if (ret) {
> -		pr_err("Could not create the BO\n");
> -		return ret;
> -	}
> -	pr_debug("New BO created: size:0x%llx addr:0x%llx offset:0x%llx\n",
> -		 bo_bucket->size, bo_bucket->addr, offset);
> -
> -	/* Restore previous IDR handle */
> -	pr_debug("Restoring old IDR handle for the BO");
> -	idr_handle = idr_alloc(&pdd->alloc_idr, *kgd_mem, bo_priv->idr_handle,
> -			       bo_priv->idr_handle + 1, GFP_KERNEL);
> -
> -	if (idr_handle < 0) {
> -		pr_err("Could not allocate idr\n");
> -		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, *kgd_mem, pdd->drm_priv,
> -						       NULL);
> -		return -ENOMEM;
> -	}
> -
> -	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> -		bo_bucket->restored_offset = KFD_MMAP_TYPE_DOORBELL | KFD_MMAP_GPU_ID(pdd->dev->id);
> -	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
> -		bo_bucket->restored_offset = KFD_MMAP_TYPE_MMIO | KFD_MMAP_GPU_ID(pdd->dev->id);
> -	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
> -		bo_bucket->restored_offset = offset;
> -	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		bo_bucket->restored_offset = offset;
> -		/* Update the VRAM usage count */
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
> -	}
> -	return 0;
> -}
> -
> -static int criu_restore_bo(struct kfd_process *p,
> -			   struct kfd_criu_bo_bucket *bo_bucket,
> -			   struct kfd_criu_bo_priv_data *bo_priv)
> -{
> -	struct kfd_process_device *pdd;
> -	struct kgd_mem *kgd_mem;
> -	int ret;
> -	int j;
> -
> -	pr_debug("Restoring BO size:0x%llx addr:0x%llx gpu_id:0x%x flags:0x%x idr_handle:0x%x\n",
> -		 bo_bucket->size, bo_bucket->addr, bo_bucket->gpu_id, bo_bucket->alloc_flags,
> -		 bo_priv->idr_handle);
> -
> -	pdd = kfd_process_device_data_by_id(p, bo_bucket->gpu_id);
> -	if (!pdd) {
> -		pr_err("Failed to get pdd\n");
> -		return -ENODEV;
> -	}
> -
> -	ret = criu_restore_memory_of_gpu(pdd, bo_bucket, bo_priv, &kgd_mem);
> -	if (ret)
> -		return ret;
> -
> -	/* now map these BOs to GPU/s */
> -	for (j = 0; j < p->n_pdds; j++) {
> -		struct kfd_node *peer;
> -		struct kfd_process_device *peer_pdd;
> -
> -		if (!bo_priv->mapped_gpuids[j])
> -			break;
> -
> -		peer_pdd = kfd_process_device_data_by_id(p, bo_priv->mapped_gpuids[j]);
> -		if (!peer_pdd)
> -			return -EINVAL;
> -
> -		peer = peer_pdd->dev;
> -
> -		peer_pdd = kfd_bind_process_to_device(peer, p);
> -		if (IS_ERR(peer_pdd))
> -			return PTR_ERR(peer_pdd);
> -
> -		ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->adev, kgd_mem,
> -							    peer_pdd->drm_priv);
> -		if (ret) {
> -			pr_err("Failed to map to gpu %d/%d\n", j, p->n_pdds);
> -			return ret;
> -		}
> -	}
> -
> -	pr_debug("map memory was successful for the BO\n");
> -	/* create the dmabuf object and export the bo */
> -	if (bo_bucket->alloc_flags
> -	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> -		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
> -					    &bo_bucket->dmabuf_fd);
> -		if (ret)
> -			return ret;
> -	} else {
> -		bo_bucket->dmabuf_fd = KFD_INVALID_FD;
> -	}
> -
> -	return 0;
> -}
> -
> -static int criu_restore_bos(struct kfd_process *p,
> -			    struct kfd_ioctl_criu_args *args,
> -			    uint64_t *priv_offset,
> -			    uint64_t max_priv_data_size)
> -{
> -	struct kfd_criu_bo_bucket *bo_buckets = NULL;
> -	struct kfd_criu_bo_priv_data *bo_privs = NULL;
> -	int ret = 0;
> -	uint32_t i = 0;
> -
> -	if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
> -		return -EINVAL;
> -
> -	/* Prevent MMU notifications until stage-4 IOCTL (CRIU_RESUME) is received */
> -	amdgpu_amdkfd_block_mmu_notifications(p->kgd_process_info);
> -
> -	bo_buckets = kvmalloc_array(args->num_bos, sizeof(*bo_buckets), GFP_KERNEL);
> -	if (!bo_buckets)
> -		return -ENOMEM;
> -
> -	ret = copy_from_user(bo_buckets, (void __user *)args->bos,
> -			     args->num_bos * sizeof(*bo_buckets));
> -	if (ret) {
> -		pr_err("Failed to copy BOs information from user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -
> -	bo_privs = kvmalloc_array(args->num_bos, sizeof(*bo_privs), GFP_KERNEL);
> -	if (!bo_privs) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
> -	ret = copy_from_user(bo_privs, (void __user *)args->priv_data + *priv_offset,
> -			     args->num_bos * sizeof(*bo_privs));
> -	if (ret) {
> -		pr_err("Failed to copy BOs information from user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> -	*priv_offset += args->num_bos * sizeof(*bo_privs);
> -
> -	/* Create and map new BOs */
> -	for (; i < args->num_bos; i++) {
> -		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i]);
> -		if (ret) {
> -			pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
> -			goto exit;
> -		}
> -	} /* done */
> -
> -	/* Copy only the buckets back so user can read bo_buckets[N].restored_offset */
> -	ret = copy_to_user((void __user *)args->bos,
> -				bo_buckets,
> -				(args->num_bos * sizeof(*bo_buckets)));
> -	if (ret)
> -		ret = -EFAULT;
> -
> -exit:
> -	while (ret && i--) {
> -		if (bo_buckets[i].alloc_flags
> -		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
> -			close_fd(bo_buckets[i].dmabuf_fd);
> -	}
> -	kvfree(bo_buckets);
> -	kvfree(bo_privs);
> -	return ret;
> -}
> -
> -static int criu_restore_objects(struct file *filep,
> -				struct kfd_process *p,
> -				struct kfd_ioctl_criu_args *args,
> -				uint64_t *priv_offset,
> -				uint64_t max_priv_data_size)
> -{
> -	int ret = 0;
> -	uint32_t i;
> -
> -	BUILD_BUG_ON(offsetof(struct kfd_criu_queue_priv_data, object_type));
> -	BUILD_BUG_ON(offsetof(struct kfd_criu_event_priv_data, object_type));
> -	BUILD_BUG_ON(offsetof(struct kfd_criu_svm_range_priv_data, object_type));
> -
> -	for (i = 0; i < args->num_objects; i++) {
> -		uint32_t object_type;
> -
> -		if (*priv_offset + sizeof(object_type) > max_priv_data_size) {
> -			pr_err("Invalid private data size\n");
> -			return -EINVAL;
> -		}
> -
> -		ret = get_user(object_type, (uint32_t __user *)(args->priv_data + *priv_offset));
> -		if (ret) {
> -			pr_err("Failed to copy private information from user\n");
> -			goto exit;
> -		}
> -
> -		switch (object_type) {
> -		case KFD_CRIU_OBJECT_TYPE_QUEUE:
> -			ret = kfd_criu_restore_queue(p, (uint8_t __user *)args->priv_data,
> -						     priv_offset, max_priv_data_size);
> -			if (ret)
> -				goto exit;
> -			break;
> -		case KFD_CRIU_OBJECT_TYPE_EVENT:
> -			ret = kfd_criu_restore_event(filep, p, (uint8_t __user *)args->priv_data,
> -						     priv_offset, max_priv_data_size);
> -			if (ret)
> -				goto exit;
> -			break;
> -		case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
> -			ret = kfd_criu_restore_svm(p, (uint8_t __user *)args->priv_data,
> -						     priv_offset, max_priv_data_size);
> -			if (ret)
> -				goto exit;
> -			break;
> -		default:
> -			pr_err("Invalid object type:%u at index:%d\n", object_type, i);
> -			ret = -EINVAL;
> -			goto exit;
> -		}
> -	}
> -exit:
> -	return ret;
> -}
> -
> -static int criu_restore(struct file *filep,
> -			struct kfd_process *p,
> -			struct kfd_ioctl_criu_args *args)
> -{
> -	uint64_t priv_offset = 0;
> -	int ret = 0;
> -
> -	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
> -		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
> -
> -	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
> -	    !args->num_devices || !args->num_bos)
> -		return -EINVAL;
> -
> -	mutex_lock(&p->mutex);
> -
> -	/*
> -	 * Set the process to evicted state to avoid running any new queues before all the memory
> -	 * mappings are ready.
> -	 */
> -	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_RESTORE);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	/* Each function will adjust priv_offset based on how many bytes they consumed */
> -	ret = criu_restore_process(p, args, &priv_offset, args->priv_data_size);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	ret = criu_restore_devices(p, args, &priv_offset, args->priv_data_size);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	ret = criu_restore_bos(p, args, &priv_offset, args->priv_data_size);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	ret = criu_restore_objects(filep, p, args, &priv_offset, args->priv_data_size);
> -	if (ret)
> -		goto exit_unlock;
> -
> -	if (priv_offset != args->priv_data_size) {
> -		pr_err("Invalid private data size\n");
> -		ret = -EINVAL;
> -	}
> -
> -exit_unlock:
> -	mutex_unlock(&p->mutex);
> -	if (ret)
> -		pr_err("Failed to restore CRIU ret:%d\n", ret);
> -	else
> -		pr_debug("CRIU restore successful\n");
> -
> -	return ret;
> -}
> -
> -static int criu_unpause(struct file *filep,
> -			struct kfd_process *p,
> -			struct kfd_ioctl_criu_args *args)
> -{
> -	int ret;
> -
> -	mutex_lock(&p->mutex);
> -
> -	if (!p->queues_paused) {
> -		mutex_unlock(&p->mutex);
> -		return -EINVAL;
> -	}
> -
> -	ret = kfd_process_restore_queues(p);
> -	if (ret)
> -		pr_err("Failed to unpause queues ret:%d\n", ret);
> -	else
> -		p->queues_paused = false;
> -
> -	mutex_unlock(&p->mutex);
> -
> -	return ret;
> -}
> -
> -static int criu_resume(struct file *filep,
> -			struct kfd_process *p,
> -			struct kfd_ioctl_criu_args *args)
> -{
> -	struct kfd_process *target = NULL;
> -	struct pid *pid = NULL;
> -	int ret = 0;
> -
> -	pr_debug("Inside %s, target pid for criu restore: %d\n", __func__,
> -		 args->pid);
> -
> -	pid = find_get_pid(args->pid);
> -	if (!pid) {
> -		pr_err("Cannot find pid info for %i\n", args->pid);
> -		return -ESRCH;
> -	}
> -
> -	pr_debug("calling kfd_lookup_process_by_pid\n");
> -	target = kfd_lookup_process_by_pid(pid);
> -
> -	put_pid(pid);
> -
> -	if (!target) {
> -		pr_debug("Cannot find process info for %i\n", args->pid);
> -		return -ESRCH;
> -	}
> -
> -	mutex_lock(&target->mutex);
> -	ret = kfd_criu_resume_svm(target);
> -	if (ret) {
> -		pr_err("kfd_criu_resume_svm failed for %i\n", args->pid);
> -		goto exit;
> -	}
> -
> -	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
> -	if (ret)
> -		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
> -
> -exit:
> -	mutex_unlock(&target->mutex);
> -
> -	kfd_unref_process(target);
> -	return ret;
> -}
> -
> -static int criu_process_info(struct file *filep,
> -				struct kfd_process *p,
> -				struct kfd_ioctl_criu_args *args)
> -{
> -	int ret = 0;
> -
> -	mutex_lock(&p->mutex);
> -
> -	if (!p->n_pdds) {
> -		pr_err("No pdd for given process\n");
> -		ret = -ENODEV;
> -		goto err_unlock;
> -	}
> -
> -	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
> -	if (ret)
> -		goto err_unlock;
> -
> -	p->queues_paused = true;
> -
> -	args->pid = task_pid_nr_ns(p->lead_thread,
> -					task_active_pid_ns(p->lead_thread));
> -
> -	ret = criu_get_process_object_info(p, &args->num_devices, &args->num_bos,
> -					   &args->num_objects, &args->priv_data_size);
> -	if (ret)
> -		goto err_unlock;
> -
> -	dev_dbg(kfd_device, "Num of devices:%u bos:%u objects:%u priv_data_size:%lld\n",
> -				args->num_devices, args->num_bos, args->num_objects,
> -				args->priv_data_size);
> -
> -err_unlock:
> -	if (ret) {
> -		kfd_process_restore_queues(p);
> -		p->queues_paused = false;
> -	}
> -	mutex_unlock(&p->mutex);
> -	return ret;
> -}
> -
>   static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	struct kfd_ioctl_criu_args *args = data;
> @@ -2720,19 +1760,19 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
>   	dev_dbg(kfd_device, "CRIU operation: %d\n", args->op);
>   	switch (args->op) {
>   	case KFD_CRIU_OP_PROCESS_INFO:
> -		ret = criu_process_info(filep, p, args);
> +		ret = kfd_criu_process_info(filep, p, args);
>   		break;
>   	case KFD_CRIU_OP_CHECKPOINT:
> -		ret = criu_checkpoint(filep, p, args);
> +		ret = kfd_criu_checkpoint(filep, p, args);
>   		break;
>   	case KFD_CRIU_OP_UNPAUSE:
> -		ret = criu_unpause(filep, p, args);
> +		ret = kfd_criu_unpause(filep, p, args);
>   		break;
>   	case KFD_CRIU_OP_RESTORE:
> -		ret = criu_restore(filep, p, args);
> +		ret = kfd_criu_restore(filep, p, args);
>   		break;
>   	case KFD_CRIU_OP_RESUME:
> -		ret = criu_resume(filep, p, args);
> +		ret = kfd_criu_resume(filep, p, args);
>   		break;
>   	default:
>   		dev_dbg(kfd_device, "Unsupported CRIU operation:%d\n", args->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_criu.c b/drivers/gpu/drm/amd/amdkfd/kfd_criu.c
> new file mode 100644
> index 000000000000..72a9b358a642
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_criu.c
> @@ -0,0 +1,989 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/fdtable.h>
> +
> +#include "kfd_criu.h"
> +#include "kfd_svm.h"
> +
> +static int criu_checkpoint_process(struct kfd_process *p,
> +			     uint8_t __user *user_priv_data,
> +			     uint64_t *priv_offset)
> +{
> +	struct kfd_criu_process_priv_data process_priv;
> +	int ret;
> +
> +	memset(&process_priv, 0, sizeof(process_priv));
> +
> +	process_priv.version = KFD_CRIU_PRIV_VERSION;
> +	/* For CR, we don't consider negative xnack mode which is used for
> +	 * querying without changing it, here 0 simply means disabled and 1
> +	 * means enabled so retry for finding a valid PTE.
> +	 */
> +	process_priv.xnack_mode = p->xnack_enabled ? 1 : 0;
> +
> +	ret = copy_to_user(user_priv_data + *priv_offset,
> +				&process_priv, sizeof(process_priv));
> +
> +	if (ret) {
> +		pr_err("Failed to copy process information to user\n");
> +		ret = -EFAULT;
> +	}
> +
> +	*priv_offset += sizeof(process_priv);
> +	return ret;
> +}
> +
> +static int criu_checkpoint_devices(struct kfd_process *p,
> +			     uint32_t num_devices,
> +			     uint8_t __user *user_addr,
> +			     uint8_t __user *user_priv_data,
> +			     uint64_t *priv_offset)
> +{
> +	struct kfd_criu_device_priv_data *device_priv = NULL;
> +	struct kfd_criu_device_bucket *device_buckets = NULL;
> +	int ret = 0, i;
> +
> +	device_buckets = kvzalloc(num_devices * sizeof(*device_buckets), GFP_KERNEL);
> +	if (!device_buckets) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	device_priv = kvzalloc(num_devices * sizeof(*device_priv), GFP_KERNEL);
> +	if (!device_priv) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	for (i = 0; i < num_devices; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		device_buckets[i].user_gpu_id = pdd->user_gpu_id;
> +		device_buckets[i].actual_gpu_id = pdd->dev->id;
> +
> +		/*
> +		 * priv_data does not contain useful information for now and is reserved for
> +		 * future use, so we do not set its contents.
> +		 */
> +	}
> +
> +	ret = copy_to_user(user_addr, device_buckets, num_devices * sizeof(*device_buckets));
> +	if (ret) {
> +		pr_err("Failed to copy device information to user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	ret = copy_to_user(user_priv_data + *priv_offset,
> +			   device_priv,
> +			   num_devices * sizeof(*device_priv));
> +	if (ret) {
> +		pr_err("Failed to copy device information to user\n");
> +		ret = -EFAULT;
> +	}
> +	*priv_offset += num_devices * sizeof(*device_priv);
> +
> +exit:
> +	kvfree(device_buckets);
> +	kvfree(device_priv);
> +	return ret;
> +}
> +
> +static uint32_t get_process_num_bos(struct kfd_process *p)
> +{
> +	uint32_t num_of_bos = 0;
> +	int i;
> +
> +	/* Run over all PDDs of the process */
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		void *mem;
> +		int id;
> +
> +		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
> +			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
> +
> +			if (!kgd_mem->va || kgd_mem->va > pdd->gpuvm_base)
> +				num_of_bos++;
> +		}
> +	}
> +	return num_of_bos;
> +}
> +
> +static int criu_get_prime_handle(struct kgd_mem *mem,
> +				 int flags, u32 *shared_fd)
> +{
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
> +	if (ret) {
> +		pr_err("dmabuf export failed for the BO\n");
> +		return ret;
> +	}
> +
> +	ret = dma_buf_fd(dmabuf, flags);
> +	if (ret < 0) {
> +		pr_err("dmabuf create fd failed, ret:%d\n", ret);
> +		goto out_free_dmabuf;
> +	}
> +
> +	*shared_fd = ret;
> +	return 0;
> +
> +out_free_dmabuf:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
> +static int criu_checkpoint_bos(struct kfd_process *p,
> +			       uint32_t num_bos,
> +			       uint8_t __user *user_bos,
> +			       uint8_t __user *user_priv_data,
> +			       uint64_t *priv_offset)
> +{
> +	struct kfd_criu_bo_bucket *bo_buckets;
> +	struct kfd_criu_bo_priv_data *bo_privs;
> +	int ret = 0, pdd_index, bo_index = 0, id;
> +	void *mem;
> +
> +	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
> +	if (!bo_buckets)
> +		return -ENOMEM;
> +
> +	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
> +	if (!bo_privs) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
> +		struct kfd_process_device *pdd = p->pdds[pdd_index];
> +		struct amdgpu_bo *dumper_bo;
> +		struct kgd_mem *kgd_mem;
> +
> +		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
> +			struct kfd_criu_bo_bucket *bo_bucket;
> +			struct kfd_criu_bo_priv_data *bo_priv;
> +			int i, dev_idx = 0;
> +
> +			if (!mem) {
> +				ret = -ENOMEM;
> +				goto exit;
> +			}
> +
> +			kgd_mem = (struct kgd_mem *)mem;
> +			dumper_bo = kgd_mem->bo;
> +
> +			/* Skip checkpointing BOs that are used for Trap handler
> +			 * code and state. Currently, these BOs have a VA that
> +			 * is less GPUVM Base
> +			 */
> +			if (kgd_mem->va && kgd_mem->va <= pdd->gpuvm_base)
> +				continue;
> +
> +			bo_bucket = &bo_buckets[bo_index];
> +			bo_priv = &bo_privs[bo_index];
> +
> +			bo_bucket->gpu_id = pdd->user_gpu_id;
> +			bo_bucket->addr = (uint64_t)kgd_mem->va;
> +			bo_bucket->size = amdgpu_bo_size(dumper_bo);
> +			bo_bucket->alloc_flags = (uint32_t)kgd_mem->alloc_flags;
> +			bo_priv->idr_handle = id;
> +
> +			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +				ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
> +								&bo_priv->user_addr);
> +				if (ret) {
> +					pr_err("Failed to obtain user address for user-pointer bo\n");
> +					goto exit;
> +				}
> +			}
> +			if (bo_bucket->alloc_flags
> +			    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> +				ret = criu_get_prime_handle(kgd_mem,
> +						bo_bucket->alloc_flags &
> +						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
> +						&bo_bucket->dmabuf_fd);
> +				if (ret)
> +					goto exit;
> +			} else {
> +				bo_bucket->dmabuf_fd = KFD_INVALID_FD;
> +			}
> +
> +			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> +				bo_bucket->offset = KFD_MMAP_TYPE_DOORBELL |
> +					KFD_MMAP_GPU_ID(pdd->dev->id);
> +			else if (bo_bucket->alloc_flags &
> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
> +				bo_bucket->offset = KFD_MMAP_TYPE_MMIO |
> +					KFD_MMAP_GPU_ID(pdd->dev->id);
> +			else
> +				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
> +
> +			for (i = 0; i < p->n_pdds; i++) {
> +				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->dev->adev, kgd_mem))
> +					bo_priv->mapped_gpuids[dev_idx++] = p->pdds[i]->user_gpu_id;
> +			}
> +
> +			pr_debug("bo_size = 0x%llx, bo_addr = 0x%llx bo_offset = 0x%llx\n"
> +					"gpu_id = 0x%x alloc_flags = 0x%x idr_handle = 0x%x",
> +					bo_bucket->size,
> +					bo_bucket->addr,
> +					bo_bucket->offset,
> +					bo_bucket->gpu_id,
> +					bo_bucket->alloc_flags,
> +					bo_priv->idr_handle);
> +			bo_index++;
> +		}
> +	}
> +
> +	ret = copy_to_user(user_bos, bo_buckets, num_bos * sizeof(*bo_buckets));
> +	if (ret) {
> +		pr_err("Failed to copy BO information to user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	ret = copy_to_user(user_priv_data + *priv_offset, bo_privs, num_bos * sizeof(*bo_privs));
> +	if (ret) {
> +		pr_err("Failed to copy BO priv information to user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	*priv_offset += num_bos * sizeof(*bo_privs);
> +
> +exit:
> +	while (ret && bo_index--) {
> +		if (bo_buckets[bo_index].alloc_flags
> +		    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
> +			close_fd(bo_buckets[bo_index].dmabuf_fd);
> +	}
> +
> +	kvfree(bo_buckets);
> +	kvfree(bo_privs);
> +	return ret;
> +}
> +
> +static int criu_get_process_object_info(struct kfd_process *p,
> +					uint32_t *num_devices,
> +					uint32_t *num_bos,
> +					uint32_t *num_objects,
> +					uint64_t *objs_priv_size)
> +{
> +	uint64_t queues_priv_data_size, svm_priv_data_size, priv_size;
> +	uint32_t num_queues, num_events, num_svm_ranges;
> +	int ret;
> +
> +	*num_devices = p->n_pdds;
> +	*num_bos = get_process_num_bos(p);
> +
> +	ret = kfd_process_get_queue_info(p, &num_queues, &queues_priv_data_size);
> +	if (ret)
> +		return ret;
> +
> +	num_events = kfd_get_num_events(p);
> +
> +	ret = svm_range_get_info(p, &num_svm_ranges, &svm_priv_data_size);
> +	if (ret)
> +		return ret;
> +
> +	*num_objects = num_queues + num_events + num_svm_ranges;
> +
> +	if (objs_priv_size) {
> +		priv_size = sizeof(struct kfd_criu_process_priv_data);
> +		priv_size += *num_devices * sizeof(struct kfd_criu_device_priv_data);
> +		priv_size += *num_bos * sizeof(struct kfd_criu_bo_priv_data);
> +		priv_size += queues_priv_data_size;
> +		priv_size += num_events * sizeof(struct kfd_criu_event_priv_data);
> +		priv_size += svm_priv_data_size;
> +		*objs_priv_size = priv_size;
> +	}
> +	return 0;
> +}
> +
> +int kfd_criu_checkpoint(struct file *filep,
> +			   struct kfd_process *p,
> +			   struct kfd_ioctl_criu_args *args)
> +{
> +	int ret;
> +	uint32_t num_devices, num_bos, num_objects;
> +	uint64_t priv_size, priv_offset = 0, bo_priv_offset;
> +
> +	if (!args->devices || !args->bos || !args->priv_data)
> +		return -EINVAL;
> +
> +	mutex_lock(&p->mutex);
> +
> +	if (!p->n_pdds) {
> +		pr_err("No pdd for given process\n");
> +		ret = -ENODEV;
> +		goto exit_unlock;
> +	}
> +
> +	/* Confirm all process queues are evicted */
> +	if (!p->queues_paused) {
> +		pr_err("Cannot dump process when queues are not in evicted state\n");
> +		/* CRIU plugin did not call op PROCESS_INFO before checkpointing */
> +		ret = -EINVAL;
> +		goto exit_unlock;
> +	}
> +
> +	ret = criu_get_process_object_info(p, &num_devices, &num_bos, &num_objects, &priv_size);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	if (num_devices != args->num_devices ||
> +	    num_bos != args->num_bos ||
> +	    num_objects != args->num_objects ||
> +	    priv_size != args->priv_data_size) {
> +
> +		ret = -EINVAL;
> +		goto exit_unlock;
> +	}
> +
> +	/* each function will store private data inside priv_data and adjust priv_offset */
> +	ret = criu_checkpoint_process(p, (uint8_t __user *)args->priv_data, &priv_offset);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	ret = criu_checkpoint_devices(p, num_devices, (uint8_t __user *)args->devices,
> +				(uint8_t __user *)args->priv_data, &priv_offset);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	/* Leave room for BOs in the private data. They need to be restored
> +	 * before events, but we checkpoint them last to simplify the error
> +	 * handling.
> +	 */
> +	bo_priv_offset = priv_offset;
> +	priv_offset += num_bos * sizeof(struct kfd_criu_bo_priv_data);
> +
> +	if (num_objects) {
> +		ret = kfd_criu_checkpoint_queues(p, (uint8_t __user *)args->priv_data,
> +						 &priv_offset);
> +		if (ret)
> +			goto exit_unlock;
> +
> +		ret = kfd_criu_checkpoint_events(p, (uint8_t __user *)args->priv_data,
> +						 &priv_offset);
> +		if (ret)
> +			goto exit_unlock;
> +
> +		ret = kfd_criu_checkpoint_svm(p, (uint8_t __user *)args->priv_data, &priv_offset);
> +		if (ret)
> +			goto exit_unlock;
> +	}
> +
> +	/* This must be the last thing in this function that can fail.
> +	 * Otherwise we leak dmabuf file descriptors.
> +	 */
> +	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> +			   (uint8_t __user *)args->priv_data, &bo_priv_offset);
> +
> +exit_unlock:
> +	mutex_unlock(&p->mutex);
> +	if (ret)
> +		pr_err("Failed to dump CRIU ret:%d\n", ret);
> +	else
> +		pr_debug("CRIU dump ret:%d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int criu_restore_process(struct kfd_process *p,
> +				struct kfd_ioctl_criu_args *args,
> +				uint64_t *priv_offset,
> +				uint64_t max_priv_data_size)
> +{
> +	int ret = 0;
> +	struct kfd_criu_process_priv_data process_priv;
> +
> +	if (*priv_offset + sizeof(process_priv) > max_priv_data_size)
> +		return -EINVAL;
> +
> +	ret = copy_from_user(&process_priv,
> +				(void __user *)(args->priv_data + *priv_offset),
> +				sizeof(process_priv));
> +	if (ret) {
> +		pr_err("Failed to copy process private information from user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +	*priv_offset += sizeof(process_priv);
> +
> +	if (process_priv.version != KFD_CRIU_PRIV_VERSION) {
> +		pr_err("Invalid CRIU API version (checkpointed:%d current:%d)\n",
> +			process_priv.version, KFD_CRIU_PRIV_VERSION);
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("Setting XNACK mode\n");
> +	if (process_priv.xnack_mode && !kfd_process_xnack_mode(p, true)) {
> +		pr_err("xnack mode cannot be set\n");
> +		ret = -EPERM;
> +		goto exit;
> +	} else {
> +		pr_debug("set xnack mode: %d\n", process_priv.xnack_mode);
> +		p->xnack_enabled = process_priv.xnack_mode;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +static int criu_restore_devices(struct kfd_process *p,
> +				struct kfd_ioctl_criu_args *args,
> +				uint64_t *priv_offset,
> +				uint64_t max_priv_data_size)
> +{
> +	struct kfd_criu_device_bucket *device_buckets;
> +	struct kfd_criu_device_priv_data *device_privs;
> +	int ret = 0;
> +	uint32_t i;
> +
> +	if (args->num_devices != p->n_pdds)
> +		return -EINVAL;
> +
> +	if (*priv_offset + (args->num_devices * sizeof(*device_privs)) > max_priv_data_size)
> +		return -EINVAL;
> +
> +	device_buckets = kmalloc_array(args->num_devices, sizeof(*device_buckets), GFP_KERNEL);
> +	if (!device_buckets)
> +		return -ENOMEM;
> +
> +	ret = copy_from_user(device_buckets, (void __user *)args->devices,
> +				args->num_devices * sizeof(*device_buckets));
> +	if (ret) {
> +		pr_err("Failed to copy devices buckets from user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	for (i = 0; i < args->num_devices; i++) {
> +		struct kfd_node *dev;
> +		struct kfd_process_device *pdd;
> +		struct file *drm_file;
> +
> +		/* device private data is not currently used */
> +
> +		if (!device_buckets[i].user_gpu_id) {
> +			pr_err("Invalid user gpu_id\n");
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		dev = kfd_device_by_id(device_buckets[i].actual_gpu_id);
> +		if (!dev) {
> +			pr_err("Failed to find device with gpu_id = %x\n",
> +				device_buckets[i].actual_gpu_id);
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		pdd = kfd_get_process_device_data(dev, p);
> +		if (!pdd) {
> +			pr_err("Failed to get pdd for gpu_id = %x\n",
> +					device_buckets[i].actual_gpu_id);
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +		pdd->user_gpu_id = device_buckets[i].user_gpu_id;
> +
> +		drm_file = fget(device_buckets[i].drm_fd);
> +		if (!drm_file) {
> +			pr_err("Invalid render node file descriptor sent from plugin (%d)\n",
> +				device_buckets[i].drm_fd);
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		if (pdd->drm_file) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		/* create the vm using render nodes for kfd pdd */
> +		if (kfd_process_device_init_vm(pdd, drm_file)) {
> +			pr_err("could not init vm for given pdd\n");
> +			/* On success, the PDD keeps the drm_file reference */
> +			fput(drm_file);
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +		/*
> +		 * pdd now already has the vm bound to render node so below api won't create a new
> +		 * exclusive kfd mapping but use existing one with renderDXXX but is still needed
> +		 * for iommu v2 binding  and runtime pm.
> +		 */
> +		pdd = kfd_bind_process_to_device(dev, p);
> +		if (IS_ERR(pdd)) {
> +			ret = PTR_ERR(pdd);
> +			goto exit;
> +		}
> +
> +		if (!pdd->qpd.proc_doorbells) {
> +			ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
> +			if (ret)
> +				goto exit;
> +		}
> +	}
> +
> +	/*
> +	 * We are not copying device private data from user as we are not using the data for now,
> +	 * but we still adjust for its private data.
> +	 */
> +	*priv_offset += args->num_devices * sizeof(*device_privs);
> +
> +exit:
> +	kfree(device_buckets);
> +	return ret;
> +}
> +
> +static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
> +				      struct kfd_criu_bo_bucket *bo_bucket,
> +				      struct kfd_criu_bo_priv_data *bo_priv,
> +				      struct kgd_mem **kgd_mem)
> +{
> +	int idr_handle;
> +	int ret;
> +	const bool criu_resume = true;
> +	u64 offset;
> +
> +	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
> +		if (bo_bucket->size !=
> +				kfd_doorbell_process_slice(pdd->dev->kfd))
> +			return -EINVAL;
> +
> +		offset = kfd_get_process_doorbells(pdd);
> +		if (!offset)
> +			return -ENOMEM;
> +	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
> +		/* MMIO BOs need remapped bus address */
> +		if (bo_bucket->size != PAGE_SIZE) {
> +			pr_err("Invalid page size\n");
> +			return -EINVAL;
> +		}
> +		offset = pdd->dev->adev->rmmio_remap.bus_addr;
> +		if (!offset) {
> +			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
> +			return -ENOMEM;
> +		}
> +	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +		offset = bo_priv->user_addr;
> +	}
> +	/* Create the BO */
> +	ret = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(pdd->dev->adev, bo_bucket->addr,
> +						      bo_bucket->size, pdd->drm_priv, kgd_mem,
> +						      &offset, bo_bucket->alloc_flags, criu_resume);
> +	if (ret) {
> +		pr_err("Could not create the BO\n");
> +		return ret;
> +	}
> +	pr_debug("New BO created: size:0x%llx addr:0x%llx offset:0x%llx\n",
> +		 bo_bucket->size, bo_bucket->addr, offset);
> +
> +	/* Restore previous IDR handle */
> +	pr_debug("Restoring old IDR handle for the BO");
> +	idr_handle = idr_alloc(&pdd->alloc_idr, *kgd_mem, bo_priv->idr_handle,
> +			       bo_priv->idr_handle + 1, GFP_KERNEL);
> +
> +	if (idr_handle < 0) {
> +		pr_err("Could not allocate idr\n");
> +		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, *kgd_mem, pdd->drm_priv,
> +						       NULL);
> +		return -ENOMEM;
> +	}
> +
> +	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> +		bo_bucket->restored_offset = KFD_MMAP_TYPE_DOORBELL | KFD_MMAP_GPU_ID(pdd->dev->id);
> +	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP) {
> +		bo_bucket->restored_offset = KFD_MMAP_TYPE_MMIO | KFD_MMAP_GPU_ID(pdd->dev->id);
> +	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
> +		bo_bucket->restored_offset = offset;
> +	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		bo_bucket->restored_offset = offset;
> +		/* Update the VRAM usage count */
> +		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
> +	}
> +	return 0;
> +}
> +
> +static int criu_restore_bo(struct kfd_process *p,
> +			   struct kfd_criu_bo_bucket *bo_bucket,
> +			   struct kfd_criu_bo_priv_data *bo_priv)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kgd_mem *kgd_mem;
> +	int ret;
> +	int j;
> +
> +	pr_debug("Restoring BO size:0x%llx addr:0x%llx gpu_id:0x%x flags:0x%x idr_handle:0x%x\n",
> +		 bo_bucket->size, bo_bucket->addr, bo_bucket->gpu_id, bo_bucket->alloc_flags,
> +		 bo_priv->idr_handle);
> +
> +	pdd = kfd_process_device_data_by_id(p, bo_bucket->gpu_id);
> +	if (!pdd) {
> +		pr_err("Failed to get pdd\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = criu_restore_memory_of_gpu(pdd, bo_bucket, bo_priv, &kgd_mem);
> +	if (ret)
> +		return ret;
> +
> +	/* now map these BOs to GPU/s */
> +	for (j = 0; j < p->n_pdds; j++) {
> +		struct kfd_node *peer;
> +		struct kfd_process_device *peer_pdd;
> +
> +		if (!bo_priv->mapped_gpuids[j])
> +			break;
> +
> +		peer_pdd = kfd_process_device_data_by_id(p, bo_priv->mapped_gpuids[j]);
> +		if (!peer_pdd)
> +			return -EINVAL;
> +
> +		peer = peer_pdd->dev;
> +
> +		peer_pdd = kfd_bind_process_to_device(peer, p);
> +		if (IS_ERR(peer_pdd))
> +			return PTR_ERR(peer_pdd);
> +
> +		ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->adev, kgd_mem,
> +							    peer_pdd->drm_priv);
> +		if (ret) {
> +			pr_err("Failed to map to gpu %d/%d\n", j, p->n_pdds);
> +			return ret;
> +		}
> +	}
> +
> +	pr_debug("map memory was successful for the BO\n");
> +	/* create the dmabuf object and export the bo */
> +	if (bo_bucket->alloc_flags
> +	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> +		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
> +					    &bo_bucket->dmabuf_fd);
> +		if (ret)
> +			return ret;
> +	} else {
> +		bo_bucket->dmabuf_fd = KFD_INVALID_FD;
> +	}
> +
> +	return 0;
> +}
> +
> +static int criu_restore_bos(struct kfd_process *p,
> +			    struct kfd_ioctl_criu_args *args,
> +			    uint64_t *priv_offset,
> +			    uint64_t max_priv_data_size)
> +{
> +	struct kfd_criu_bo_bucket *bo_buckets = NULL;
> +	struct kfd_criu_bo_priv_data *bo_privs = NULL;
> +	int ret = 0;
> +	uint32_t i = 0;
> +
> +	if (*priv_offset + (args->num_bos * sizeof(*bo_privs)) > max_priv_data_size)
> +		return -EINVAL;
> +
> +	/* Prevent MMU notifications until stage-4 IOCTL (CRIU_RESUME) is received */
> +	amdgpu_amdkfd_block_mmu_notifications(p->kgd_process_info);
> +
> +	bo_buckets = kvmalloc_array(args->num_bos, sizeof(*bo_buckets), GFP_KERNEL);
> +	if (!bo_buckets)
> +		return -ENOMEM;
> +
> +	ret = copy_from_user(bo_buckets, (void __user *)args->bos,
> +			     args->num_bos * sizeof(*bo_buckets));
> +	if (ret) {
> +		pr_err("Failed to copy BOs information from user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	bo_privs = kvmalloc_array(args->num_bos, sizeof(*bo_privs), GFP_KERNEL);
> +	if (!bo_privs) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	ret = copy_from_user(bo_privs, (void __user *)args->priv_data + *priv_offset,
> +			     args->num_bos * sizeof(*bo_privs));
> +	if (ret) {
> +		pr_err("Failed to copy BOs information from user\n");
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +	*priv_offset += args->num_bos * sizeof(*bo_privs);
> +
> +	/* Create and map new BOs */
> +	for (; i < args->num_bos; i++) {
> +		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i]);
> +		if (ret) {
> +			pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
> +			goto exit;
> +		}
> +	} /* done */
> +
> +	/* Copy only the buckets back so user can read bo_buckets[N].restored_offset */
> +	ret = copy_to_user((void __user *)args->bos,
> +				bo_buckets,
> +				(args->num_bos * sizeof(*bo_buckets)));
> +	if (ret)
> +		ret = -EFAULT;
> +
> +exit:
> +	while (ret && i--) {
> +		if (bo_buckets[i].alloc_flags
> +		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
> +			close_fd(bo_buckets[i].dmabuf_fd);
> +	}
> +	kvfree(bo_buckets);
> +	kvfree(bo_privs);
> +	return ret;
> +}
> +
> +static int criu_restore_objects(struct file *filep,
> +				struct kfd_process *p,
> +				struct kfd_ioctl_criu_args *args,
> +				uint64_t *priv_offset,
> +				uint64_t max_priv_data_size)
> +{
> +	int ret = 0;
> +	uint32_t i;
> +
> +	BUILD_BUG_ON(offsetof(struct kfd_criu_queue_priv_data, object_type));
> +	BUILD_BUG_ON(offsetof(struct kfd_criu_event_priv_data, object_type));
> +	BUILD_BUG_ON(offsetof(struct kfd_criu_svm_range_priv_data, object_type));
> +
> +	for (i = 0; i < args->num_objects; i++) {
> +		uint32_t object_type;
> +
> +		if (*priv_offset + sizeof(object_type) > max_priv_data_size) {
> +			pr_err("Invalid private data size\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = get_user(object_type, (uint32_t __user *)(args->priv_data + *priv_offset));
> +		if (ret) {
> +			pr_err("Failed to copy private information from user\n");
> +			goto exit;
> +		}
> +
> +		switch (object_type) {
> +		case KFD_CRIU_OBJECT_TYPE_QUEUE:
> +			ret = kfd_criu_restore_queue(p, (uint8_t __user *)args->priv_data,
> +						     priv_offset, max_priv_data_size);
> +			if (ret)
> +				goto exit;
> +			break;
> +		case KFD_CRIU_OBJECT_TYPE_EVENT:
> +			ret = kfd_criu_restore_event(filep, p, (uint8_t __user *)args->priv_data,
> +						     priv_offset, max_priv_data_size);
> +			if (ret)
> +				goto exit;
> +			break;
> +		case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
> +			ret = kfd_criu_restore_svm(p, (uint8_t __user *)args->priv_data,
> +						     priv_offset, max_priv_data_size);
> +			if (ret)
> +				goto exit;
> +			break;
> +		default:
> +			pr_err("Invalid object type:%u at index:%d\n", object_type, i);
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +	}
> +exit:
> +	return ret;
> +}
> +
> +int kfd_criu_restore(struct file *filep,
> +			struct kfd_process *p,
> +			struct kfd_ioctl_criu_args *args)
> +{
> +	uint64_t priv_offset = 0;
> +	int ret = 0;
> +
> +	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
> +		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
> +
> +	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
> +	    !args->num_devices || !args->num_bos)
> +		return -EINVAL;
> +
> +	mutex_lock(&p->mutex);
> +
> +	/*
> +	 * Set the process to evicted state to avoid running any new queues before all the memory
> +	 * mappings are ready.
> +	 */
> +	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_RESTORE);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	/* Each function will adjust priv_offset based on how many bytes they consumed */
> +	ret = criu_restore_process(p, args, &priv_offset, args->priv_data_size);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	ret = criu_restore_devices(p, args, &priv_offset, args->priv_data_size);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	ret = criu_restore_bos(p, args, &priv_offset, args->priv_data_size);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	ret = criu_restore_objects(filep, p, args, &priv_offset, args->priv_data_size);
> +	if (ret)
> +		goto exit_unlock;
> +
> +	if (priv_offset != args->priv_data_size) {
> +		pr_err("Invalid private data size\n");
> +		ret = -EINVAL;
> +	}
> +
> +exit_unlock:
> +	mutex_unlock(&p->mutex);
> +	if (ret)
> +		pr_err("Failed to restore CRIU ret:%d\n", ret);
> +	else
> +		pr_debug("CRIU restore successful\n");
> +
> +	return ret;
> +}
> +
> +int kfd_criu_unpause(struct file *filep,
> +			struct kfd_process *p,
> +			struct kfd_ioctl_criu_args *args)
> +{
> +	int ret;
> +
> +	mutex_lock(&p->mutex);
> +
> +	if (!p->queues_paused) {
> +		mutex_unlock(&p->mutex);
> +		return -EINVAL;
> +	}
> +
> +	ret = kfd_process_restore_queues(p);
> +	if (ret)
> +		pr_err("Failed to unpause queues ret:%d\n", ret);
> +	else
> +		p->queues_paused = false;
> +
> +	mutex_unlock(&p->mutex);
> +
> +	return ret;
> +}
> +
> +int kfd_criu_resume(struct file *filep,
> +			struct kfd_process *p,
> +			struct kfd_ioctl_criu_args *args)
> +{
> +	struct kfd_process *target = NULL;
> +	struct pid *pid = NULL;
> +	int ret = 0;
> +
> +	pr_debug("Inside %s, target pid for criu restore: %d\n", __func__,
> +		 args->pid);
> +
> +	pid = find_get_pid(args->pid);
> +	if (!pid) {
> +		pr_err("Cannot find pid info for %i\n", args->pid);
> +		return -ESRCH;
> +	}
> +
> +	pr_debug("calling kfd_lookup_process_by_pid\n");
> +	target = kfd_lookup_process_by_pid(pid);
> +
> +	put_pid(pid);
> +
> +	if (!target) {
> +		pr_debug("Cannot find process info for %i\n", args->pid);
> +		return -ESRCH;
> +	}
> +
> +	mutex_lock(&target->mutex);
> +	ret = kfd_criu_resume_svm(target);
> +	if (ret) {
> +		pr_err("kfd_criu_resume_svm failed for %i\n", args->pid);
> +		goto exit;
> +	}
> +
> +	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
> +	if (ret)
> +		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
> +
> +exit:
> +	mutex_unlock(&target->mutex);
> +
> +	kfd_unref_process(target);
> +	return ret;
> +}
> +
> +int kfd_criu_process_info(struct file *filep,
> +				struct kfd_process *p,
> +				struct kfd_ioctl_criu_args *args)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&p->mutex);
> +
> +	if (!p->n_pdds) {
> +		pr_err("No pdd for given process\n");
> +		ret = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
> +	if (ret)
> +		goto err_unlock;
> +
> +	p->queues_paused = true;
> +
> +	args->pid = task_pid_nr_ns(p->lead_thread,
> +					task_active_pid_ns(p->lead_thread));
> +
> +	ret = criu_get_process_object_info(p, &args->num_devices, &args->num_bos,
> +					   &args->num_objects, &args->priv_data_size);
> +	if (ret)
> +		goto err_unlock;
> +
> +	dev_dbg(kfd_device, "Num of devices:%u bos:%u objects:%u priv_data_size:%lld\n",
> +				args->num_devices, args->num_bos, args->num_objects,
> +				args->priv_data_size);
> +
> +err_unlock:
> +	if (ret) {
> +		kfd_process_restore_queues(p);
> +		p->queues_paused = false;
> +	}
> +	mutex_unlock(&p->mutex);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_criu.h b/drivers/gpu/drm/amd/amdkfd/kfd_criu.h
> new file mode 100644
> index 000000000000..1a3d418a9505
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_criu.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __KFD_CRIU_H__
> +#define __KFD_CRIU_H__
> +
> +#include <uapi/linux/kfd_ioctl.h>
> +#include "kfd_priv.h"
> +
> +int kfd_criu_process_info(struct file *filep,
> +				struct kfd_process *p,
> +				struct kfd_ioctl_criu_args *args);
> +
> +int kfd_criu_checkpoint(struct file *filep,
> +			   struct kfd_process *p,
> +			   struct kfd_ioctl_criu_args *args);
> +
> +int kfd_criu_unpause(struct file *filep,
> +			struct kfd_process *p,
> +			struct kfd_ioctl_criu_args *args);
> +
> +int kfd_criu_restore(struct file *filep,
> +			struct kfd_process *p,
> +			struct kfd_ioctl_criu_args *args);
> +
> +int kfd_criu_resume(struct file *filep,
> +			struct kfd_process *p,
> +			struct kfd_ioctl_criu_args *args);
> +
> +#endif
