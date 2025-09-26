Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E225CAC5AC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 09:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80BD10EA0C;
	Fri, 26 Sep 2025 09:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tg7fVqMY";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD89910EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 09:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZcpPe0umD5giOI5H2Ix5WrmWhj2kRcCSHwhL1EWQNIvvlXMhb6cazr0v83mnqAc821I08CI0Vpye09ZefTFcCMwd8KdiGCdigHZPnFQR7wzazbaGoGa5GvzI4nJpNTOkH0Jt1KNNel7O1fRx/uLDfwuimKzJicNiAp2s74SUPY+bEmzj4UA8O+7LZo1BXowVhc4CbiXIpZcshfduWWwVjE2db5XjQtTo3qXgyzN/vYV2jbCsqRy7WvxV6ac5SCUSMwe2ZOe2Aro6T8X6LAbD0DTEovWBAnKBCCN2m2HuDDpQ9fsltPs+bnSmpN8VPf9VAqihwLKSz2QSF+5c+lZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TiuyzFQergT95sus5agTvjAtwiOrSbf0BOf/A3Ywfk=;
 b=S7nxVs4NTw/w//XRd8rcs5vB7acuTc6MIe1MahFMaxL3qqd8iZK0sE5jv//dJcZuTvE8IiJZ2pRvgM+93iYhZDTmRFDL3fZmTvbLvhp/Sd0X3PqR+Aibn8q/8jI/HQ9DoinsTrjC2Jc6DbiEwSwuxLNvqJQFoev0KzsU+6f9gMkdX1z31ysDzIjC68/xrrH6F9zpGfzBmZ15YyZV7vv4sm5pFsocCgkH/+CxNB23EIAWMP7dNRDhj1GR4V6NtSh+bZKEWWRzkOt391d80FVB2uunLjv8xOnHOizkPmo7EXhSJdP0VJFPZBitYdubyaKHLIYnaERvI+OJvKI6nit34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TiuyzFQergT95sus5agTvjAtwiOrSbf0BOf/A3Ywfk=;
 b=Tg7fVqMYjfD4EyX5nDO0hhFSFs1UpGOpSm0LO/FTWQ1LYl0npaYJ4OJCHESPUxpFGJvjwIRD34e0+Gq2bvhIDhz6e3nJKXjRooYzWTI18KwJP7zrOgFMDtVkYuZ8f1D/a0YY5YKo/+QCgV5wpd1YgSMYYVIquYvCYkrfV1VwFY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:04:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 09:04:12 +0000
Message-ID: <327ec8ce-1c4b-4058-b2ac-0e46d89b1aeb@amd.com>
Date: Fri, 26 Sep 2025 11:04:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu/userqueue: validate userptrs for userqueues
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250925090154.111303-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250925090154.111303-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: bf73523f-eaae-43ad-c34a-08ddfcdba919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1V4enVnNUVoeXJsWnc3QWZua2E1ZVNIY2lkdzVPS1RCODJhaE9Dd3R5bUlm?=
 =?utf-8?B?bzJtUDFMSS9RVjBkL0lPY1ZISnVuTVo2QjJxY2dPc250Zmh1WlQxdGNyM0dS?=
 =?utf-8?B?TU9YNm1pRFJac2RzL2lCdS93WUNsQjBGSCsxVWxVNnhzdkNyLzlBd0VDVFlp?=
 =?utf-8?B?Q2YwOTM1YXpqV1MzUG9NNlVUM1lwZWxZTXVhZDl2NWwxQmQ1dkZCeXZ5a2oy?=
 =?utf-8?B?YVZMak9UVW5MenhucnN2M0hxMXYwcVFsRW51SEZONUp3eEZKbU1qK0t5cVNQ?=
 =?utf-8?B?UFZGZ1p0NEkzZW9aVkFFbkRLS0VENUJwZmlpZUdEMW1Bc0pzVngvS0J6MnFv?=
 =?utf-8?B?QXhYTEdqdDVxWGlPY1FYTHNiSDdiZWRoVHdOdEVmdVFBRVhqUzBaMk1lcEky?=
 =?utf-8?B?dTlyaFFqSk9SaUg3YkptQzNrdmZ3TTcrbzJUSWd1NkN1T1d5N1BvcEUyOUFC?=
 =?utf-8?B?NlFQcVJ4QzNjdTV2cmhDNEtnTU5hd3JpZUczdmtaSi8vYUV3NFZiWXkyMDFD?=
 =?utf-8?B?dm1UckVDUkZoVmw3NG9RSXYwK1VPUzREN0JJMDVUQVM2QzFUeVJKYmN4aWJK?=
 =?utf-8?B?YnlpNUhueXBIZzlHWHhUbCtzUUVIcmdWanRmcFRTbTQyKzhFVUhSZHFRZzNs?=
 =?utf-8?B?cE54RXVrK2N3Ukl6VXJkU3d1UHk0anRtRTVlbDRST3VjWVRiZ2VWdEFMdVVN?=
 =?utf-8?B?Q3VmcVIzZGVxYlZuaDRZeTFPcFUzZUI5YXBnMU4rcE4zQno4T0IyRVFUMmJ3?=
 =?utf-8?B?ZHlYSDhnQ0JCWUNJa2o2TkJpNGZKaFhRRElCMExBNTJpb1BrQlp4YUNtSnZ3?=
 =?utf-8?B?THhyYjNsNHUwV1FjY21uVDVodHJjampGZ1VBVkVEZjdsQytkNFR4M0FEbm5s?=
 =?utf-8?B?ck5xd2JMRVJ2aWFhMFcvR0ZCSldseUQyOXNkeU9GTHNSMnZpOFkvZ2FqckJL?=
 =?utf-8?B?Tk1zbjFUUDgzN0pHemNGU1pCc1B4ZnNLdURDRDloWTR4WnpjdzZySTNwdUFm?=
 =?utf-8?B?OEdDVFhQeUk0Vmd6V0R5eHVwNWhVMDV4REFVQmRlMGFKZlRJVDJBY3pSYkgz?=
 =?utf-8?B?cTlHQVA5d2t2eUN6eWxhSkFOTUpsWDAycHJnZUlBN3o4VTgrWGV0VnhXeWx1?=
 =?utf-8?B?YkM5Q1RzS2pyQ1g2cHNtY3l1ZkVvbzBrZjQxd3lOZUduQ2hKNGdLSC84d25a?=
 =?utf-8?B?eVp0N3l2dng5MzJIS05BcW5IM0t1WnlJTUhwR3Nmb2MzbGk3K3JJVG9jZ0JO?=
 =?utf-8?B?TmJQaWdTUDJoK1lxS3pmMVRGNUFxbm9lVUtLWllZS0tPbFh6TU9FM1A2NEgw?=
 =?utf-8?B?VWhzTXN6UEZZWFNMQTVGWnJRYklBMGp0azAvZkV4Z3hRNjY0Y0dCaTdPVzYz?=
 =?utf-8?B?RXgwQlNkdzJ1elEySGNMRkQ1emJjK2tKQkRabm9iendqKzlNSkRjVk1PSCtE?=
 =?utf-8?B?cGFmZHdsOGNGVFU5LzI2Z2FMb09hNmJNa3Vvczd3ZTZOR0RpOVkwUXRCdmlY?=
 =?utf-8?B?S056TUsrVVMwNmF5VXdNdzY3RzZRNzJKTVV4SnozRjVGR2NUVmN1bGVUMi9u?=
 =?utf-8?B?ZzJobHZLeGNsOUNFeXg3bUVvaXAzbEtzdGN0SVJ0U1JVYUpmZFU0M2lvUkZl?=
 =?utf-8?B?MFR6VUdMbHhwMWYwWnJlWEVSMEtuMUxwRFV4aW0xT2ZPOEk2dk1qMDF5Y3BM?=
 =?utf-8?B?cFYxOXppbWlnd24rRDU4UElGQ3BhTitrMUdUZEZwQVB1OVZXR3YyYVhvblB0?=
 =?utf-8?B?TEFOZEFHUlA0L09tSndWTE0zYnJqdXE5d01qdjFoYWU2d1c4L3QwTm9mUlBq?=
 =?utf-8?B?TW10Y0F4VGZ2L3FyR08rVUI0ZFZ3TCtYZ2tBNTI0RUcrV3hjT1QxeDU4bERz?=
 =?utf-8?B?NkpVR0xEYWlOT2JaSkJxZkt1S1NVRVN6dlhMSnpjakg3c0YvSkYrNHhQdjlX?=
 =?utf-8?Q?zUVt6ujihekvq8edwDLYXr9FBG4SJ8Cm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1VzYXNTMWdqZjBKMS8xa1FjOTFSWHpyWWJ4TUF0YVBwbEdCQWt1bnhRQVcy?=
 =?utf-8?B?SVdOU3dtV20vd3pGeHBJR3JDWTRVZ0YyNUN1ajhXSldiMThMYmhvaHdPODFm?=
 =?utf-8?B?Q0dtUEV3akR0Z0hKM0JUaWhqV1VEbjQ4VU5mcXowcFJTMlh4VEcvZm5SS0pY?=
 =?utf-8?B?Y0xtWUxWOFVpcWxWMXprcWxSaU42UitaeEJOVVVhTVNKZ2s5NEsvZHVpNFdK?=
 =?utf-8?B?aCtUUCtjbXpYM01xZ1FSdUNMcHNTQWs3MWV4aTJjQUdxYW1seVFRb0NsN2ha?=
 =?utf-8?B?YmNqRVRHKzlkTWNlajZwMkRQS2lNRmxnOGV0Wko2N1VUUXljSmt6aW1aSHg4?=
 =?utf-8?B?dVc4dkNTV1FRY3RocmJvZXhOWWsxdXluaVA0VnI2ZTlBcVJZeW92M0tPQzFt?=
 =?utf-8?B?dk9NZDZqU1BUN0dNcnpONVl0RlNmWGF6ekUwamh6RVFJamNlKytxNGdScHJZ?=
 =?utf-8?B?RHprZ3NnOEVjNWRWekNjb3dhcS9FUEdDdDNyd05zaHlDaHhiMjRUK2w0dFlC?=
 =?utf-8?B?bFJFRnBINDN0Y3pXSHZyZGZxajl4OTkweFJDNG1haGlqb1BrOU16cEJjVndN?=
 =?utf-8?B?Q3ZqUGRqYmkvcmo1TzFudURzY2wwQ2crNTJ0OXpuVzBPeFgzZ1ZkcFQyd3c2?=
 =?utf-8?B?T1BLckpEblMxWUtuVzBjQVVaeTZ1VFg3L1BiTVR5aFVLKzFhdVBXS3lkZ204?=
 =?utf-8?B?dC9LeGFkbGxBQkRIVmhxZXpuM0JqbnVMN29ZU1ZGNmhYMHhoalFHcWM5VUYx?=
 =?utf-8?B?NGwwTEpnU0c3T3VwT2pEK29KdXY5YlpqSWlMT3pRczZHL1p6SWJEZHZMUFAv?=
 =?utf-8?B?TjFNY1pIUmxiV0Q1ekJ5akJyWWZjd01JY2NmMG4xSUpIdkViOG1ZWWJPSTVU?=
 =?utf-8?B?QWZQT2VQUU40ZzFtd0VOQ0FKUE9ReTF1eFpZdW8zd0xqWVJYQXAyRy9nTzBn?=
 =?utf-8?B?UW5kemhoSDBPK1luSUJ3dk1hb3BMVXJGOHoxQWpqNjRtdXVsUFE2emNJbnJx?=
 =?utf-8?B?cGQyQ1lXWDZscWJjeUtua1h5cDRzK253bDV5V0lnb2JucUt3QjNIVzdBTzZR?=
 =?utf-8?B?enNpaGlxMGFIQ2hjMzFHTkUxSVdja3piQTIzclRRWTIycVVpbUJ6QVFLM2ZD?=
 =?utf-8?B?Ynk2bkxaQlB2S3RhTE0vWmF6bHVwemVkUUw5dXpKMmhGaGwrREN6MzZ1eEN2?=
 =?utf-8?B?NGVTTXF6VTB4V05MemFmVW03T1pmZGxPaXlVRVVMNnp2UW1KQkd2MUNvQUUy?=
 =?utf-8?B?Sm41bFRuVVR4UzFwalNBWjJIUTlvcnY4ekR0cXhjaWk0NXpFejMrM1gwTEFG?=
 =?utf-8?B?L21WS0JHN2dKeSszaFBVaWowR2dyWVBybngvSkdIYjNNSk9VR09CaDBxUDN0?=
 =?utf-8?B?RzAxTkJiSDJzSFcvdnd1NWYxOXltbmRwajFZSlNxTktyNkdWa1pOQXdNYXV4?=
 =?utf-8?B?NnZ2cE1YSUhMUUtpeCtkUkZJb20xYmJQRHNyeWRQM2llOHZMNm1EbGs2bCtB?=
 =?utf-8?B?Wk5ENmNDb1BlelFFQXJpa0ZYY0o0aG8xT3NsQ3AyQzNaRkFZRzEvTS95UHNp?=
 =?utf-8?B?ek80ajI4d0Z2LzVOazROTjJZSWpwWFR0ZE9yclVYbVFINmZHY214TlZwNGxl?=
 =?utf-8?B?QXY3OUljZ0ZLYWczdUt0TXFoSU04ekFKU0tMSWMvUWIwdjcrdWZ3MnNCb091?=
 =?utf-8?B?MFk1Nk9qL1J2dlNOUmZsNUhtUmVxc3lZR2Zhdkg0dHdwY2NuK0RONHhjVGsx?=
 =?utf-8?B?R0dwUWp6L2hVcS93R3k1cnc0NkhSV0pFZ0dwaDgya1BFRGRjcGhNWldYWWZZ?=
 =?utf-8?B?U3JoZytCYkxubTVESjhoQktJc3VyZC85U2w4dFFId3hBMTliU2EwcHV3YlJR?=
 =?utf-8?B?RlVmVkhRdjYwNFFhZVh0Y2NKenROZ0N6N3Z2VU4wazJZODB1NmdwT0lpQnJD?=
 =?utf-8?B?K054VjdsUk1EYzFIZFY2ZWs2NUFjbEQ0VFVQcjlmVG5EM1FpTERKZHdIK0FS?=
 =?utf-8?B?UWxNYjZtSHFFRitndFREY2RxMWo3VExuYXRYbVhzeTNnSVdLWStaYkdhQ1RX?=
 =?utf-8?B?ZWFFdmpIb1V0U0ZBeC9sR0x5bEh6Z0g4SGRKcGs2cUR4WGRzYU5sL0h0RkRV?=
 =?utf-8?Q?IFwAuc/Z8QN0CzeH8zxew3hTv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf73523f-eaae-43ad-c34a-08ddfcdba919
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:04:12.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1L7ew6aBtUTpnQYwuZJuo55lgTwVX8wuzYC0Jkhz0xiQvqOzE0kz2Os3hkFp3lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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

On 25.09.25 11:01, Sunil Khatri wrote:
> userptrs could be changed by the user at any time and
> hence while locking all the bos before GPU start processing
> validate all the userptr bos.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 76 +++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3bbe1001fda1..880bcc6edcbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,6 +25,8 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/hmm.h>
> +#include <drm/ttm/ttm_tt.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> @@ -761,9 +763,19 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
>  	struct drm_exec exec;
> +	struct xarray xa;
> +	struct hmm_range *range;
> +	unsigned long key = 0, tmp_key, count = 0;
>  	int ret;
> +	bool present;
> +	bool invalidated = false;
> +	struct ttm_operation_ctx ctx = { true, false };

In general better keep long lines first and stuff like "i" or "ret" last.

> +
> +	xa_init(&xa);
>  
> +retry_lock:
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> @@ -794,6 +806,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  	if (ret)
>  		goto unlock_all;
>  
> +	if (invalidated) {

> +		tmp_key = 0;
That can be dropped.

> +		xa_for_each(&xa, tmp_key, range) {
> +			bo = range->dev_private_owner;
> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +			if (ret)
> +				goto unlock_all;
> +
> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +		}
> +		invalidated = false;
> +	}
> +


> +	/* Validate userptr BOs */
> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +		bo = bo_va->base.bo;
> +		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
> +			tmp_key = 0;
> +			present = false;
> +			xa_for_each(&xa, tmp_key, range) {
> +				if (range->dev_private_owner == bo) {
> +					present = true;
> +					break;
> +				}
> +			}

Rather code this something like this here:

key = 0;

list_for_each_entry(bo_va, &vm->done, base.vm_status) {
	bo = bo_va->base.bo;
	if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
		continue;

	range = xa_load(&xa, key);
	if (range && range->dev_private_owner != bo)
		free_up_range(range);

	if (!range) {
		range = kvmalloc(sizeof(*range), GFP_KERNEL);
		if (!range)
			...

		range->dev_private_owner = amdgpu_bo_ref(bo);
		invalidated = true;

		xa_store(&xa, key++, range, GFP_KERNEL);
	}
}

while (range = xa_load(&xa, key++)
	free_up_range(range);

if (invalidated) {
	....

}

> +
> +			if (!present) {
> +				range = kvmalloc(sizeof(*range), GFP_KERNEL);
> +				if (!range) {
> +					ret = -ENOMEM;
> +					goto unlock_all;
> +				}
> +
> +				xa_store(&xa, key++, range, GFP_KERNEL);
> +				range->dev_private_owner = bo;
> +				amdgpu_bo_ref(bo);
> +			}
> +		}
> +	}
> +
> +	if (key && (key != count)) {
> +		drm_file_err(uq_mgr->file, "userptr bos:%lu\n", key);
> +		drm_exec_fini(&exec);
> +		xa_for_each(&xa, tmp_key, range) {
> +			if (!range)
> +				continue;
> +			bo = range->dev_private_owner;
> +			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
> +			if (ret)
> +				goto unlock_all;
> +		}
> +		count = key;
> +		invalidated = true;
> +		goto retry_lock;
> +	}
> +	/* End validate user ptr*/
>  	ret = amdgpu_vm_update_pdes(adev, vm, false);
>  	if (ret)
>  		goto unlock_all;
> @@ -813,6 +882,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  
>  unlock_all:
>  	drm_exec_fini(&exec);
> +	tmp_key = 0;
> +	xa_for_each(&xa, tmp_key, range) {
> +		bo = range->dev_private_owner;
> +		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);

As Felix noted as well we should probably remove freeing up range from amdgpu_ttm_tt_get_user_pages_done() and into a separate function so that all kmalloc/kfree is balanced.

Next step is probably to move this into functions in amdgpu_ttm.c amdgpu_hmm.c and amdgpu_vm.c and then apply it to amdgpu_cs.c and see if the userptr IGT tests for kernel queues still work.

This way we can test our design for potentially errors.

Regards,
Christian.

> +		amdgpu_bo_unref(&bo);
> +	}
> +	xa_destroy(&xa);
>  	return ret;
>  }
>  

