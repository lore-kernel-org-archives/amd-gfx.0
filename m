Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0BE7718B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 10:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A507610E423;
	Thu,  2 Jan 2025 10:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Urjifa18";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C6910E469
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 10:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTNf/PnfDalzrhCtgg6rTDHhxavTrY11cV+OyFFqkyW7b4f75XS9lZbzqv1jiQOoZDVzXvrORt1b9xsMizltPAI0PUVnO7cLRQpF3A6CXucOqAXi7/Y07Cj2g7n8nZxXI2Tiv7M1lPR20m+VeiO+HjlLPyIWSHNQWGmmj2VrcGkWQ3j+vQ1BlwVDa1k0AND2US+aVhICX+WekANh/v0R70a5j8X+vUUgJ1UpjluQFKCP9nVJLm/msNvwD3Wl6brqCb6zlkoQXPi17tUw/B4qrIR9i5ZyQWRzTA9XL/j+Cix30aDCVZ0a1xF/xeTD9sZZ4CXiVKU01WOd+l6HVHFylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whYW27kCxM2yQi6OiZtCLumEWiAbfGIjGcjsIXHvHVE=;
 b=HkE4E+0ZKj5TBiYo9nAZs5/gYXLGtcuSdwR+L3ryipbAbUKgJvevWdQIXGKdbKULSXp/9Rqr5jmb0ZRswuMbB9dTlsNMmmnOpdWdBRBnAcfCvmP6cRMsjlOTiFrtES42uxtMQY4PCO5/noIhWkxKA6SxVRqDt7sX7OQ9obIXaiWWZnIYnxpxNFsM0JrRPOxrsboAs+tyijMZC6gdjoeFjcSijVxWrPX45We4aiLkqvoNlhLXbfk+xG/90rcmw56Jq1dm71GalMIgQSHqR/CHJNZzaMvv6ebOwF/7JVH1EZFxUHwDSX+sIuvnM6vpzR/Id6nma9tTweP/qxq1xi1tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whYW27kCxM2yQi6OiZtCLumEWiAbfGIjGcjsIXHvHVE=;
 b=Urjifa18m7CP9s/l8veRJ62/T9PPghpqG8OQwNjI8CB45+SGMKPYTY7oP69IN42eha1xYe/z0lGBZ9DA9cWrHPdmklAVicUqcDlPjTq2puXnx+CZ9CorhO8NXYOLGGoT3CYbjgOThTfYRWOVL8jsOhU9DkU65YDW1w51u9vf8q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 10:55:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 10:55:49 +0000
Message-ID: <3bc7580c-3eab-48b0-b232-55bb07afc293@amd.com>
Date: Thu, 2 Jan 2025 11:55:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix Illegal opcode in command stream Error
To: Arvind Yadav <Arvind.Yadav@amd.com>, shashank.sharma@amd.com,
 alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20241223153439.2208-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241223153439.2208-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 31364413-021a-46d0-eda6-08dd2b1c0487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm51WDlUWmEwSldjRFlDd1dhZ2grMXZzb2k5cEUwbzZCUnVoSG0vWHdvR2Np?=
 =?utf-8?B?ZytqQWtQeUFQYS9JYnAzUEZNUk1sWDFlVEY2a2xyMjY4MEtvRUlJRGg5c3BE?=
 =?utf-8?B?eGRxUVgvSlZwdktoK21GWmtGcE96dWJvWG5aN0NocjFVRDFZY0JEcUk0eUNE?=
 =?utf-8?B?aGEyYWEvd2w3b2hrMXl6WEFpRVFqWHFSRHpmYU83TkZwbUFoN1FxSWVvRTlh?=
 =?utf-8?B?dUw1TXQ0bmpTUi80a0Z5ckdidVF6QXhhcmlVZHpLcGxSeEdHT281dVpsZm9n?=
 =?utf-8?B?TDJORm9jSElxRzd5UHZqZlliSHlweWx0akp2ZXYwU2JmRngxdk81TkQzN05B?=
 =?utf-8?B?elJwNWUzb1hZeGowU1pxMU5JcExWM0xsMksrcjVVbThBVFhKa1RvckZwaHEz?=
 =?utf-8?B?OG8zR1lRN2h5aXJUNXZYcnZ5U3A5c2o0WFFrcFBNNGwybUpjbU9MbFhSNGZD?=
 =?utf-8?B?YVlaT3hyRCtsTVVZNU5SOFhMY21jQ01VTUFhaHFQQUJzVkhobXo1S3RvU3Nn?=
 =?utf-8?B?Y1hGdnFGRGQ5bmV1eU9NangxQktjdm9ScE1vOUhuYVZOamNCaGczdHdYbkVR?=
 =?utf-8?B?S2dMTGMwTjFZeDhOT1FKZkh4MnNqM1kvWGd4SlVrVUJnTFl6MEcwcnhSbGtz?=
 =?utf-8?B?TTRreUcwTEZ4YUtFMUVsenp5cE1Gb1VmMGd2UUIvNm83c1o2aVl6a1kxR1pn?=
 =?utf-8?B?b3hkNGMvNFN2MFdJQ0dBVi9yc2tOaWlCQnFDRG01N3Q5SmYyRmlSRWJXRXlt?=
 =?utf-8?B?ZHNQTnVtaVlUZ0x6c01hTGpHbHQwZ3R5VVp2OG1Pck01Mkdwdmh3ZE9OMDE0?=
 =?utf-8?B?Rk01ZHNFdGZsbW9WL3RNeFFINVFpVHRIZFZuYTlncjVSZ0RzNXJUakVCUHBC?=
 =?utf-8?B?Tkc3enJlTnAyaDVjWDRKdHFtb1A5WnVhcnphN1p2ZzdXNVJ4MjNBMUxZaGRU?=
 =?utf-8?B?SC82MlF1eUlpZWs5WmhkQlhzTm5HUmtpMU9TOFFBRXo4dlhZRm9aeFZxZ0ZI?=
 =?utf-8?B?VlY4ajJSZzBVTGZaUTFuU2JnRnA1bm1qVnZFWS96WEVZYzUxM0tlVjV6eVFM?=
 =?utf-8?B?aDdzbHVrOVhVNUdZVW5rU1dhU0JweGVTYnAxRFlXdkN5TEhndGQyb1NsdDhx?=
 =?utf-8?B?Sm81b1lIdnd1ME04Mitici9XVDlyaVZjRTVzbUtERmNVdUw0SEdoUWo0RE5w?=
 =?utf-8?B?VEVsM2hCMWpWRmtoYm45a2k4eFRQTHV2a3kxN1NDOE5UbkdMVmdXQzJFbTZO?=
 =?utf-8?B?NTZMYmEyQU40RGRxVFNiaWtXRHROcVNwYjVQY2M4eS9ZMFBkMVZnT2E5TVVr?=
 =?utf-8?B?bkhaVHFOOFVMcS9KRnhHejVjcVV0MjVVaG9qSmZyVmhKWXpYdUQ3cExmTE1T?=
 =?utf-8?B?UUE4dGdSN0d4WS9JdGpBZ2JnenNvVnZ3aHhtVjI3Q3dPNmFlMG5EMlA5RHc5?=
 =?utf-8?B?cTA4WUh0Z0ptTzMrMUd3Rk5vbG90SHA0VUVGQUUvcjhhbFVCd1BhNVBNSVN6?=
 =?utf-8?B?WlMzTDkvb1draUZYWDZyV0pyV0pIYlFpb0NlSkJFejJIek9MU2NoZTcrRkVP?=
 =?utf-8?B?TUc3WlpkZmtoaWhQSDkzQkUyUlgvcElIYnY2NEExdVRwY3VOakZaRHV3TkpP?=
 =?utf-8?B?ZklBRkNDc1pxUlBENFF4eWNxVHdFNXhoaUxoVFovSThJS2pJY0VsRGlyeTM1?=
 =?utf-8?B?UFYrMExrQkxnYlRZN0hOSDMzR3JzMTdRWVZJd3BwdkNBNjFSdU1qT1FUWUwz?=
 =?utf-8?B?b01adFRLVm1EM01Da2JZd24vSHBhaEtvL013TDJFZkFTbUpCNjhlUTBRaU1t?=
 =?utf-8?B?M2NYR2VkbEFycWx4N25qc2M5cGdQbkFMbk5VYXMvWG9JT2daVHBKQXJ2Ny9T?=
 =?utf-8?Q?gw8gwFh3aiNOB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtNS1kzRzFtNEc3WHRBdFA4Zys4d0MrUVhuQkV6bHF2dFovYkxZUDVkV0d0?=
 =?utf-8?B?dDR6d0dVUHo2TWlNQldrV1FmN2ZVSCtYaEVudjhmMklLYjJlMFM5STdXK1Y3?=
 =?utf-8?B?bk9HQnN2ZHJORDRMbjBkMklhR2lyYVFXcnU3T0tab3JHaVpyRUlGWVF3b0h1?=
 =?utf-8?B?QTVQR2w1ZytRTE5oZDIxRWswaSttRUxTbGw1bWt5VjBGK2NxL2ZlRGl5WlhH?=
 =?utf-8?B?SThHc3hhSmN3T2hISm9hWlZ5Qkk0VG5jUExVK1ppSEp0Nm5hZlVwdnZxMG5N?=
 =?utf-8?B?bUNVdDhtVHBlckg2VDJNSFNpL09ZUjNmdE5ML1l4SFlvODBPamRGZTE3bW8x?=
 =?utf-8?B?NzYrR3k0REF4Q1BDVVpxYTRwazdXeTY2YXE0dUNwNm4ydXRNdllPSHZlZVk1?=
 =?utf-8?B?a2NSbmFkZmpObWUwdU4rd1hLVzNsQ0FhWlUxN0EwY2J5SEtJOWM5elloeTBP?=
 =?utf-8?B?dEswaGhYNElQUHRvbCsrN2xwcEYwL2VZNjNlUmc3YzdSUWN4THIvU25aK2lF?=
 =?utf-8?B?bERqanpwS09GdHQ3Z05nUXpmWkxCYUdWS0U4eDNqakIyeGRzckFNVGFnT0Mx?=
 =?utf-8?B?NUk3THUrdmdwRTA0V1NBMk5naHphTkQ1d0FwRFc3UkYwbzB5dXhaK2ZTVENN?=
 =?utf-8?B?eXZXMlZXVVMreHJWTkZKWkdKL2Y1cE1EeE15TEpVWjhSWlNrNDdjV3dTc2hE?=
 =?utf-8?B?bHpKbklKQVc5aTY5TVFUNzRCeTIrNVRjUUp6R3hySXBkckdzbG9OQU05eDR0?=
 =?utf-8?B?UFN1TEZGZHBKM0RESDkzOTFJb3luaWRWa016OHovVnRuWmE0Q1JLNXVVQXNR?=
 =?utf-8?B?WHJxd3J3VFVIWGFINHpZNTZ1NThIVlpQbmZEcEFCNzF2OFZPQlBTVERjWVpm?=
 =?utf-8?B?NEsxTnpnSUpTN1YyNi80WG1zZlc4c2lSK1BaSkQxalUrRVY3Tnk5SVlEWTZR?=
 =?utf-8?B?WElIekhtb0hEV0dMemEwSGZqNmF6OG5IdTBNNWJyT1VqK29IZ1E5Ni9SeW5z?=
 =?utf-8?B?enVHN2JKQlhndDVRelJmNXY2Y0dBNzFOUjZqNkVzSSt6RFhPR0hWRG85NzlF?=
 =?utf-8?B?TFZQZDNsK3dQQWUzS29tQnEwWUs5K05tMW9uM2dCS0Irc3dQZ3pZUkR0Q0V2?=
 =?utf-8?B?eC9KNmNCSXhRVDB0UkhEWW9HVWVoWmFWTWdjVG9FalVYNTVqN1hpWE1WSUl5?=
 =?utf-8?B?NzlYdXBGc2dCRis4K3UvU2lWMWFkZG9acy80L1NHQU1pZkZiRDl2ZXlaWTd6?=
 =?utf-8?B?MmN2WW1FUEYvSnJWaG1ZRzhBQzU5T1dBT0gwQmR3bU93RU5GazBQeEpnaUdm?=
 =?utf-8?B?VEdRYUxtTUNJVGV3aVZnTW9QbE1KV3Y1dHhEOU84dURDQ3JTNzM2V28vZm9k?=
 =?utf-8?B?WTl3NVgwUmhJVVAyMWM4VWR5SHRuVFFqazNXRkJ6OWRMcUpyQ2h2RTcwcWcy?=
 =?utf-8?B?d0JoY2EvSytHL2R6OHZ3eXN1VFRoa0tYbHVLNDVUSkt0NGxSNHJkUVpUQ0xT?=
 =?utf-8?B?eDZjUGRKQ1RvbFZhMEhHL21ZczA5cytEcEtncnN5UGMvd1VYVVBDUmpSMGhZ?=
 =?utf-8?B?ejlUVVd5Yk0zSTRrMWwzVTh1UHRjem5IQ0dTWDdyTmFGdFJ0ZytjbE5nQmRm?=
 =?utf-8?B?djB3UEE0SVF2VUE3QWZnQ05LVU5uU1FMRXBkVGlsb1dRWEhFTHlmbUhxdDkx?=
 =?utf-8?B?WTZ4YTJSUGR0cEFiYUFab1Z0RWlKQzlrRVc1TVJhNHpDNkduWi9PNlVSb0JZ?=
 =?utf-8?B?VFhENGd0clFEYzFHdjRpMkhHZlJzd0tRNXdmSDlTNTRoVVUzMjZKWmNLWU0r?=
 =?utf-8?B?ZFo5SFNZWGQ0S29xcURyTDhrbnpEa1BXb2JJQTd0TWVXaGdHTTgrVXZyK2wr?=
 =?utf-8?B?WW8xdVJGWnErK3Z0WWNnZm13Q0RGNnY1bW92RUs2VnVqUXpHbVo1bkhHMGZS?=
 =?utf-8?B?NE1mKzFWcGpNWldSd3BobHdpL2IyTjlndGJyemY3U3BGbkZ5TE9nUkNhZGcv?=
 =?utf-8?B?Y2NyaXhGVVg5Qm0yREt2QmhZL2ZaMkg2TWk2TGxUejg0ZzZmZUc3L3ZwOGxj?=
 =?utf-8?B?THNwVW1WaWtyRU1ORFZKQTEyMklhelNYVnhSZVlyMkliQ0hBMmFiM3EwMnNO?=
 =?utf-8?Q?yg7XbsnSQiCRqHz9r1q8s/DAi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31364413-021a-46d0-eda6-08dd2b1c0487
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 10:55:49.4326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWspJReztL/ZPaufMhCE9NohPewX9uIlcROCauzRrqPh+W2B9BjfrG2vIVZmKm44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

Am 23.12.24 um 16:34 schrieb Arvind Yadav:
> When applications closes, it triggers the drm_file_free
> function which subsequently releases all allocated buffer
> objects. Concurrently, the resume_worker thread will attempt
> to map the usermode queue. However, since the wptr buffer
> object has already been deallocated, this will result in
> an Illegal opcode error being raised in the command stream.
>
> Now replacing drm_release() with a new function
> amdgpu_drm_release(). This function will set the flag to
> prevent the scheduling of any new queue resume/map, stop
> all queues and then call drm_release().
>
> V2:
>    - Replace drm_release with amdgpu_drm_release(Christian).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 ----
>   2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 62de668e9ff8..acb9dc3705ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2794,6 +2794,20 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>   	return ret;
>   }
>   
> +static int amdgpu_drm_release(struct inode *inode, struct file *filp)
> +{
> +	struct drm_file *file_priv = filp->private_data;
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +
> +	if (fpriv) {
> +		fpriv->evf_mgr.fd_closing = true;
> +		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +	}
> +
> +	return drm_release(inode, filp);
> +}
> +
For now the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

But unrelated to this patch we should probably clean up all the DRM 
callback functions and move them into a separate file.

Somebody should probably setup a confluence page for small cleanup ideas.

Regards,
Christian.

>   long amdgpu_drm_ioctl(struct file *filp,
>   		      unsigned int cmd, unsigned long arg)
>   {
> @@ -2845,7 +2859,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>   	.owner = THIS_MODULE,
>   	.open = drm_open,
>   	.flush = amdgpu_flush,
> -	.release = drm_release,
> +	.release = amdgpu_drm_release,
>   	.unlocked_ioctl = amdgpu_drm_ioctl,
>   	.mmap = drm_gem_mmap,
>   	.poll = drm_poll,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2a046736edd..f908355df07c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1478,10 +1478,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   		amdgpu_bo_unreserve(pd);
>   	}
>   
> -	fpriv->evf_mgr.fd_closing = true;
> -	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> -	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> -
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
>   

