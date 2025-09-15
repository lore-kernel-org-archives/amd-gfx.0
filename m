Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D2CAC587
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 01:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7556F10E26E;
	Mon, 15 Sep 2025 01:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bFOIy3rh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7337D10E26E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 01:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYBDK4Dx2FlywvNdDjtQPxN5+olvkVfDKDFCdhUJsK5Ivu/z0aCnex2SuXCsv98ahJ2/usVM3taWRNvlJvzOTVtv4djH6PW7veIY4C14X/uFkOb+b7i4lGK74g00AwQzz9iJNJAZrO0ufRl6n5obKbmwKUnxQM6VsM5zzyhP6LzNyxVAkK2JykRAmzpw7599QXdEWJPm8MR6yNnwCR37eCaBm9L64Wtzg4zvgyovGLm1oSqWyzIklB8i4L9TIT8b51HZ1PhavifYHPULcr828XVUdfuK5OdmTqO6+UIsc/Tzi59JORN5VSlIeEf3YIDm65FVe500aKvKaxtOqld6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5FOHaU6YMP0zHT2oayC40VI9jfum5Y+jS3EWPnX3Ec=;
 b=q3mrXXR9+h6slErH2dIOqPVfEBS+az4SIqPqwfIib6H3SzcOCpLtlLLJXL9GT3vsqtNg0LdmrsESQRi5/Sx635JtaMf+rjByz+uDpZIJ+4twk8VE53UKiMNUT2ARTQPSDK2gCmc9TDsGpLlfs5c4ay1MYWTiVq8ghGjFrOQsSlg87zxP44pQlAEur8+UEFzr54Ixvz6Xf4pwO2/ap+xH1k4swQrUOxrhSW5x6qfnvsgWsAxqzitQTNhAAPJtAbpTcGv7BhDWEhaEmZ2R6rbj2QPthyce1ko9XZzXqxNfame8nd/IGUD/T0nbZN7UXHyFBeGNhzyKjWq0mcCm56VGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5FOHaU6YMP0zHT2oayC40VI9jfum5Y+jS3EWPnX3Ec=;
 b=bFOIy3rhWtj9l8JOPuDIxRjx2WiBj1S1JpoT3hLepSpARhHErn0Fz2yIdOtMKjFq+BMViHDjA0v6TB5t1qcV1JstehlARXvSWQPXqRXZCsodEkRqQUqj9WPmnAo6Q2ulrEO7DOzo9ZiRhCtrAyCYgPD4maogKVFfREiPXs8oArg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 00:59:59 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 00:59:59 +0000
Message-ID: <db2b5b26-b44d-430c-91fa-cb45faaec851@amd.com>
Date: Sun, 14 Sep 2025 18:59:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com
References: <20250825213333.612600-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250825213333.612600-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0368.namprd04.prod.outlook.com
 (2603:10b6:303:81::13) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 183f1786-0cee-4112-a37a-08ddf3f331aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHlPSkVTa3RKK3labkZlNFMrNThqcnMyYmw0RUlBSktzVWwvQlBMaHpFVUJy?=
 =?utf-8?B?cGJCWFVhM0J3WjlTRVk2SHByVGNzL1JpZE1zMmtQZXd4Wi8xQUdiREZkT09s?=
 =?utf-8?B?RjVmTkI4dkNmNlNTaE95Q2dsazR5NmY3MVBueXZUejlTUFVNeld5cnFtZ1pz?=
 =?utf-8?B?ZkxVWkRlVnEvVE81L3pKNTF3RmJJMm81RUozMk9LVzR2a1pZVTdnTmxzOU90?=
 =?utf-8?B?TjJVTEpJVEJ3WDdCNzBNVEhoS0RIME9PRndWU1pvZ3FqMzk3T3hpdVl2dW9n?=
 =?utf-8?B?YkRmako0bGpkZWRDZFg2cGEwMmlVcEJsRDJwaW5LeUVpRTh4STlGdUd4U1Yr?=
 =?utf-8?B?VzlGUXFqNmJPTWgybzdKWjhENm9kNkIwSWZtU3hFVFpJSGpqQzRvSzYwTW1I?=
 =?utf-8?B?Q1BRbTFHd2ZSYTNqVVFCWS9Cb3hJZno2MWphSHM2MnFUSm1tWDllalJUS0Np?=
 =?utf-8?B?QnZsdHVjTlNGbUk2b1luMk1mTm56bDBwSTMwcXd0YTNRZjBzQVlIamRGakZa?=
 =?utf-8?B?NjNyM25JNzJyUloybE1rVy9ZdWpLbjFNRTFHMUQ3M1VrcHpVNCtHbVFCSTV5?=
 =?utf-8?B?Q1ZsK1ZnZjRjb3pKZ2pvVlVyQ0tPNGtTN0ZqY2RSY1VEVjZNMTJOdWI2WXA0?=
 =?utf-8?B?MUE1M01LNDkyTEppS21td25MY21RY044NGhkNllDUVhiRE9qaGJNTGxvT3ZN?=
 =?utf-8?B?QkFUMEpnNjQ3YlZZZDdESVFoM1d3MzQxZytOU3djNUw3MkZFMTI4SFF3R1d5?=
 =?utf-8?B?bU4rdGpaV3V5OWRVdy9oQ2oxY1d1dUFIbTF6VkpadWpHR1FWZzRGY0JJQzZZ?=
 =?utf-8?B?MDlSZlE4VElPSTd6UFF2RkV3aHd3dzhYWnN0aEExZVZLK3pLaTFvSnFCSUJn?=
 =?utf-8?B?eHVSL1l2NFFROVp5aUFwZG1VQVFadldkSkhZT0d1N1prMUFvVENJZk1tT3RE?=
 =?utf-8?B?TEx4RjRzc05lMlBicjNMNkRRcVpnYktqMnFOd1FHMWRISzFXODY3VnVxLzF4?=
 =?utf-8?B?WmtlWVU2OFpFeXFPWFQ1M3Q5VlpMdk1QWHZjNmVodXNmZXNhZ0VnaytNY0s4?=
 =?utf-8?B?NlA1dWM2T2JTTWRHVk8rYjZVdHhjSGROdkdmNVprRWxiN3c1WFVuNkVHVG1w?=
 =?utf-8?B?eld6TW5Ba3ZMRXB6dTRtRkpOKzI2bjQ4Y2lObEdiQVZkcmE5anRGQWZLWmor?=
 =?utf-8?B?NzMvZGhRdGhITzlsQklkbllCQ2VKcTBrQmR1UXpVV1dvVlVmVFA4ejlNS0RN?=
 =?utf-8?B?bUJJVTBwV3kzdmRSbkdralpDdFpUeUUxNGw1dlUrVTBZbFdQMldNSzVmQkxL?=
 =?utf-8?B?eUlJTTJVY1IyVHorNHBnbkdqKzFIZnU0bjhBVElIenQvOG1mN3ZEMndTMERm?=
 =?utf-8?B?aGNDV2FTWE1HTExSOHVuQmN0WUR3djFzWEJDR1JoSUY5VVRaUHFOSnBJSC9I?=
 =?utf-8?B?MHFzU3lVZnVIcGhLR2krQkhFcUpFV3RROVowMU1UWXYxU1h6WUpVQ0w1bWht?=
 =?utf-8?B?bld5aUNWbGFWY01zNTJMTDBmb3E2SFhBMnpOUGR2RnlQbm1UQm1IdkkrUTFG?=
 =?utf-8?B?eEtoWHpPYisrUW8vMUlyYm81bFJPakQyRzYrWm5VaHUwUFpsYzQwSDFURkUz?=
 =?utf-8?B?ODFOaHVSZEphcjFSajF4MDBSeXZCYjdsQUsrUG42My9idjBVaElUSUVyREtY?=
 =?utf-8?B?STltN0dDbnlML1h5RWo2U3dIL3o4MzEyMjFGQVNSR05nVXJxanBxRENjNHN2?=
 =?utf-8?B?M2RUTVo5cndxU1ZwNnUvcU9Bem5nOWh3ZEtHTnFUWDN0Ym1lMHVyVGRxQ012?=
 =?utf-8?B?dURNTnpZSUF5c2lTK1VTeW44V3Q5a1dpY0k2VTNueWtkSHo2ejY4ellBcWxL?=
 =?utf-8?B?R0xyeHdOS3ZNNjlxTW1hTG80L2NIK2hhLytkTWtYK0RNcnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGQraVFFYUU2ZFpvSndsRFJlclZ4RUZ5U20wTW5rZUxiMUtqeXdBcHhaY0pK?=
 =?utf-8?B?UWtMT0RZY0s3QlY2R0lkNnFUVDM3TXBwMVR1Vi90cEZDN21VaFVjREx1ditN?=
 =?utf-8?B?VjhZeDFPaEdmNkQrVGcxcExMdFM2RUYyN3Vsa1JkQkN1ZWkraS9rT0hJNG9V?=
 =?utf-8?B?RHNCNWNZaklLQXBLQVpDVmJ6MHBtMVltOU5RdG8yVUJFTVA3ODZZUHVpeHJK?=
 =?utf-8?B?SUh1Tm9XQ2tpUjJrNkpyMFdVZkFwMUhMR3I1aHcwMFdXa2kwRGlVV21yczBG?=
 =?utf-8?B?Y2RubjdjaklNT0lwMWFydm5IL3o2VzlaQUFUSS9jR2F4WFF3T1FyTVdJa1Fs?=
 =?utf-8?B?aUJ5bHNUcmlSRDZiMjluOUtjK244NEFZZHlPcEhVZE1SY2NPN2dnRXVkVHo4?=
 =?utf-8?B?bkhzN3Y0ZVpwcFRXaDhwd2NhNGo1S1ZRU2ZOWFlVSlRqdzk2WkFPZ2p2V2xV?=
 =?utf-8?B?clVCaitkSzVEbjczcUZKTUlITVl6SFRwUEJRUkVoOEJEZjhydUZvVTdwZ2xw?=
 =?utf-8?B?S01oN3FYcHEwM2lIRWQ5QzZCNzJrbC85eGpLYkxHWDgrcUlNUEwzYllGQWwx?=
 =?utf-8?B?dTR6U0dJcHpuU0pQbHpFWEpjUUxydVpQUHVhL0x3NTBVbXQ4dXZpMTZtdSts?=
 =?utf-8?B?QURrenlUeG1wNy85ckl1Z2ZpV2lLaFcxMlZuTFZ6cjE0OUFxTTJKWk9OQ0ZQ?=
 =?utf-8?B?R3pKOXlEOVUrbURhN2pneFppc2tlVGpESkw3R2pPRHMxUGNnNGJwUFRWa2wv?=
 =?utf-8?B?alc1eCtFQWU1MmRkS2dBYUQyTG16M0FGZC9pT3BjbFBna1JCVHRGbWZYdk1D?=
 =?utf-8?B?UHRrNlVRUGFlaHBSdzhrQVpWWFh2QlFwREg0UUhWRVNlbkpBbWRYZThNMDhZ?=
 =?utf-8?B?eEpYRUo5bGo4OUlqakFTZWVQUWtBVVhwb25MVHdwaEVLV3BpUEVqY1NVc0sz?=
 =?utf-8?B?eEl3REQvOVZPTmgxWnEzSmd4S1RKSm1pVW1UUHoyUVVTaERTSU9hOVVvNG9h?=
 =?utf-8?B?dHZ1WjFQUHl0N2pPTVlhdEZCZUNwWnRTbXBsNHlBZkZRcXc0Y2pJYnE0WElC?=
 =?utf-8?B?VnJTUjZQV1RiMlp3RDlFTzdKUk95RnFlVTBDWEI4dmE5QWljU25SNUhZUUJX?=
 =?utf-8?B?TFlUT1JxcFRWVUN0aXdEK2lhOFo3WGtxMm5VNndsckNHTWN3M2g2K2dwc0ph?=
 =?utf-8?B?UnVDalc5TmxLSWJLVm9SVzM0ZVdIUTlXUjg5T1E4UXdyNlN1SERReTQyTTI1?=
 =?utf-8?B?NElETSsrWFRwUUliSFJJUUk2Y2d3T3pHeGZvS3dGeHBNVExyU29YQ202c0x0?=
 =?utf-8?B?cUZ3bHFyaGxNYVBSSnh3TUVJMkZqUUZVREdaSll5Y0Z3RXFJU3BkSmYwWHZL?=
 =?utf-8?B?NEE3bzBENHM4cTBMWWJLVkpVUlRoZ2U1OFBSWExvcjFCb2pBaWlNVVl2bmhW?=
 =?utf-8?B?WjVtMDVXcnd0aTJ5d3RPWjFxeGJUZnpXY1RmdFI1MkptTFlJK2F2NTN3SVA2?=
 =?utf-8?B?Q0JwVDN1bWJnclRIRTlTUXpWRUl0NjVGTmczaWdIUVN1aU84bC95dG95eGxw?=
 =?utf-8?B?b1VxOEFRSTc5VHBzZHNsTnlsMDY1c3dFdnA5MllRaHUvNE04SXIrU2c0L0Nr?=
 =?utf-8?B?Y1p4NU9Rd2VWS2dSZVdlcGNQaWlCbFVqejg1d3NkekJydzd2WnB5bENJcXBV?=
 =?utf-8?B?bWFETHo4NXJiQ1ZUL1ArcVlFWEsvZ0p0TjRodWpOZURRMHRaZEZzU0ZsZVlj?=
 =?utf-8?B?L0tYWmZTTFRqMVBXa3M0bGE4WmFkOHhucXZQNDh6U0xZSGNodGRvTFJySjY1?=
 =?utf-8?B?d2ZCdTFyYjZhTW9ncHJhQ0pmb1ZySjNZLzJwS1ZoRUVjOFJNWTFLTFdwazZM?=
 =?utf-8?B?MXJ1S3VYMU9tenlNMlVrVXVHcjlxVVdBYlNxMmUzek1MNVcycnpmc0h2dzBE?=
 =?utf-8?B?RysvU1VlRUpJOEJ0b0VKK1I1NkhSRHMwUklmZGRGcFNrRnVraEFJZ2VMS1Iw?=
 =?utf-8?B?N1gxdVBaYmZobW5pK0ZMWHgvNWgvanpFYXJsSUFCdUxMWHV3cXBNdjR6bzls?=
 =?utf-8?B?WStSVE14QUdkZVFxaThuaG1kQVAyTFQ5b3VwVWJmS0xyYVVUWEIwcjZ3M0l5?=
 =?utf-8?Q?89MPIlN5zNSYvSP3XI8IhP6ua?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f1786-0cee-4112-a37a-08ddf3f331aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 00:59:59.4853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTxaeqnu+/ngLmA8ps6CMdTDOBFd7DW9tdMSDh4R1i1h2J3Ht1BKEx5Q4FdadwM40StlHMuksxSL3sPiPCYyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7
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

No regression found in DC promotion test.

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 8/25/25 15:33, Timur Kristóf wrote:
> When the EDID has the HDMI bit, we should simply select
> the HDMI signal type even on DVI ports.
> 
> For reference see, the legacy amdgpu display code:
> amdgpu_atombios_encoder_get_encoder_mode
> which selects ATOM_ENCODER_MODE_HDMI for the same case.
> 
> This commit fixes DVI connectors to work with DVI-D/HDMI
> adapters so that they can now produce output over these
> connectors for HDMI monitors with higher bandwidth modes.
> With this change, even HDMI audio works through DVI.
> 
> For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
> with the following GPUs:
> 
> Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
> Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 827b630daf49..42180e6aca91 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1140,6 +1140,10 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>   		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
>   		    !sink->edid_caps.edid_hdmi)
>   			sink->sink_signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
> +		else if (dc_is_dvi_signal(sink->sink_signal) &&
> +			aud_support->hdmi_audio_native &&
> +			sink->edid_caps.edid_hdmi)
> +			sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
>   
>   		if (link->local_sink && dc_is_dp_signal(sink_caps.signal))
>   			dp_trace_init(link);

