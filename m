Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6E5FD5316
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD4C10EACF;
	Fri, 27 Feb 2026 09:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JlzAYg6d";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79D10E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTYBinkLvf65CR9qIYK4+FCQbOnrcAuZhsajLhwOGh4LqL8wWhIZIQ17UVVthvbIEIKgn5/emUK0riOny1kuJyFnWKL3ZEXW++2ixYg0zR32BcW9KAwJfgoGqhXHUAchlqfMTFNAdI510aXrktgQThWh3/DctEWpP7OcaNUx3LBjaiMoLAkO11dzXeRTp3o2oGB7NvuTgN9rvP8Pv1pg4oNqRn512xOxlaiiL+5+j1AbRZBI/Mmp0w5aZbPEolVOdZy1kXde31tsIXEf4TjfaTj1/RfLXyIRyuzzXrDhqa8q098sbXfgxl3RFg7OSqxC4QhzxysECQL6qY5+3OX59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQc5oF3EYwCU+twAdnR25blnn1y5B0N1uC0tVyczYI4=;
 b=MzZghTlzAKU6Bv5K1vhGW0o6zzKnOh+rjq/mkLwTeW+Sd0y3FGXfreQsOB/6jQo/R6gYf2LKhXIMQ/A2nlszdZTRyzZya8GHKk5dY+zTYD2v91QSacqJ6MFPiCPCVVbH0Azbnkv26r/FqD3G0y06nOWtxSI2Q0vVd0cR540+4SpJAELo2nPaLz3dfuMJv/lAbX6mQmAwKHj0c/9OnKlC1RKFpwcswk5AUSqxD6vfaWETgVEi3LAFbEZaX6fL1BhwQTpgCyHW7WV4yYFdff3oLSUGjssx1JdOGLowz8AGGsT/1HoSaLHzaTV47b14eRQjd110hAucn4kHFnfiGn/GTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQc5oF3EYwCU+twAdnR25blnn1y5B0N1uC0tVyczYI4=;
 b=JlzAYg6d0FUK6no5S5vgKvdAELvcfuGwqBF+Vbs3RYu63+giFd3m3ODkPu8THUITTxTj8HEHmUNwVszlteWLOy6vSswzmIE7IAYc6VZ8kJTeFchaF+opz9FawKF9ZULL189SNDyKFrC3QzJcB3qGEXY1DGVrG/Scvo93px4OEzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 09:22:09 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:22:09 +0000
Message-ID: <6e1ec357-6858-48ae-9447-e915fc946417@amd.com>
Date: Fri, 27 Feb 2026 14:52:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update type for num_syncobj_handles in
 drm_amdgpu_userq_signal
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260226155146.3727191-1-sunil.khatri@amd.com>
 <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
 <490f80ef-6614-4ba3-8183-fbca7698f8da@mailbox.org>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <490f80ef-6614-4ba3-8183-fbca7698f8da@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0103.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: cb98ca83-c39b-466e-da85-08de75e1ae8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: YzuA5g2WWnGWlL1ynG9vWmdSMutP4kkkjNlIquFG4z42eYuGoZfoj8npe09Pfiki8N5XNF0nTvp0rPwvkI4ZwiGZU4TconjtF8D36uRxOmZF9m8vCsrZR7Mkg/nwyIBIsDNZBtKKsNOeRCegUWpFc/xt5+TyQVmNkJTArGjT+MhaLAPE5PJ4pk9EChCIgMlxq2QjK0l+sndR0c0qxSXFHnPfY7uVQv3nqZqzXMVn0yKMQkoWG/QCkmyFWvp9Qgy0l7dwOwozOqt1ZXRf9zSfDYtG5IURMsadrZPmRL+y6xk2BFX/HPVLOTdVfeXi0dGKF5P3pEkaYx6pzCqfxEO+ltLU/KBstVXQCqYxCKWGqzYkbfFaVxLKapp0Lrq76/zh/58kdEekQPbHYaPajrPnh9QB4gAt/mvQWJF0YnByEQY771f69NudAklBcqoanpRFJrYZahWZwJsdyyHquyCiy0M7o516CSltnu2m6gsKiYwFbhbHAzL8Zu50wpFAsUZ0vgQwNtOoT7qDMpVcOeFnB8izjJEvaSKT37WksykHEiY+gUsYWHnLQaimpALIEyIGoaxZguQDJ773jjRpcuUIuAUgUAZ8Y3JmTqmISok+ESe7zwlhJ8mdhlzKi2qMQt4mJ4Z3AAoXta95ylBlbuDUA4RXq/uQkTTZjGOhIIdLvlbf8zkhM1qXI3S8eQSiqEHnUGqXiW2H+ou38ZUmbcFo7RrBhr59KRcH1/pt1Y1dWYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzEwY2JyQlNmemdHUXEzYzRUZ1BqVnVIQkk0TGRZZkZTVHRySHN1OTh2OHh4?=
 =?utf-8?B?OWprS2lEdk13Y0lobWFGeW9paFJueTJaWFZncDJhWUZqV2xGTVN3bUhBemp2?=
 =?utf-8?B?UTNsZ3N6Tms1ckJUYnBhVGtxbU9OZ2N2ajhOcDlVRnJsYkhlWEpnZVU0TDhW?=
 =?utf-8?B?QjF5V1ZqeGozTHNlM1VPOGpnNlRPQXFRSmNua1FjTjRoTGZDaDdqdmQ3Z0Q2?=
 =?utf-8?B?Z2tTeDJvZlh3WGt1UU5SMVNOSFltVDhhZXVkN0w4UWtqUXZSMHpSSkpEcGxI?=
 =?utf-8?B?cnlkNzFHaWpveENNTXF1blBYNjNwYVJXSGhNTmlLeEc3cVpKc01zV2FsTW95?=
 =?utf-8?B?R2YrMGk2T0QzcVNITk1ncGRGQ0RMblpVUEFFY3Vld1FoYXVVRjZLejlZUDEz?=
 =?utf-8?B?WTdTd0k0OFBYQUFsVDVIODU5SHBEMjRqWFF0RVFTa1RCWGRvbVh1MndRT3dS?=
 =?utf-8?B?NzVWK2FGbnEwTTFkM0ZOYVl4cWZGUFdzYXdtK3RVZlFDUWhFemZ5ZnRQWDg3?=
 =?utf-8?B?Smt3OW5HZWFGNHRPSDNYRHZBanVGQXpmbnNBU3NiU1JDUWJCL1Bqb1ppempR?=
 =?utf-8?B?VzFTRVNrZE14TUJTeVMwVWw4dDlkeVl1aUhjMEV5UW1IZmNYZUJ3M1FKM1lu?=
 =?utf-8?B?MTJLREMrY0Zrckw3bmU5KzZoWXZ0NUp6aEVMVDE5RHZBd2tWTDFLMXVaeTQy?=
 =?utf-8?B?TFdiUHpnREM3dlZ0Y3hiYVZMaWRmQS9EMUNOdzgyQnlhSGtjdmZGN1E4OEc0?=
 =?utf-8?B?RUNtZmQ4eG03bVovbE9DMGRQZzVFY2lUQTQ4dUwvd1h3YS9UTDhva1pkZDlT?=
 =?utf-8?B?b3JqcTd2MDY5Z042bXFIaGZ1ZjZLdU1Ia2JURXRYNzBqUmpjblBFS0NGTWRV?=
 =?utf-8?B?ajdvT1B1YXJVQVNJMWZXTXZTQXlrM3RhMWFUNS9wY2NRZnh3OSt0YjlrMDNI?=
 =?utf-8?B?VEQrRE9RdFV4bjlNZFpSUHIwUk1aUjRTbXhuNGN0bzNPK2pBT3VuVmloNXZL?=
 =?utf-8?B?bFpDRzRwdEUrYmxUN0o4TkNtTG5OcDBPOFZLL0h5YlpFZ2gwdXNrZTJ4MUZz?=
 =?utf-8?B?b0g1UGowV0tKNlNKL1FEWm5yVHdzSDdCdlZRdnVhSlVuSVNQcVNkczVOL2ox?=
 =?utf-8?B?UCtLU1pJTkhOSkprYmoyNGNPc0NiaC9ldFN3RXVYTlM4SHR0U0YzdndLZWpu?=
 =?utf-8?B?aG1LbmJtQTBGN0Jib1owMEU3Rkx6ZGdvZ28weU5ic29qQTJPWHFRK3VBUFNL?=
 =?utf-8?B?UVpTamJhZEliZnZyWXRxMnk4ZTc2T2hHUlZDYk1ERU0wNU94UU1sbkZGNkZX?=
 =?utf-8?B?aGtvOURhemxGOVE4RjI2MmFHUXlybFFGME1icEk5dGNBSTNCMTIxb0lDRFNV?=
 =?utf-8?B?cTFNbGZTRFA5WWNEQm5FWjJ5d29LNk5lQVpkMXhlSnFHMXNqV3VUWjl2MkZN?=
 =?utf-8?B?c2phK3ZzTHBzSlNBNTQ1b1drendwaUhHZ2VZYW5PRFJjN0ZWWEYwekZUczli?=
 =?utf-8?B?WWxRNTNTN0lWdnBpSkY0UUQyS2xsY3UrQ21EcW0xTE1OYjV1UkxOWlFneGlk?=
 =?utf-8?B?T3Jab3lWRGVVWXF6WWdzNUlremVDb3FsUkR1S0pMUlYrdHk4NGdYNCs1bU5o?=
 =?utf-8?B?S0FNVE9XYmNpWXo3TjlTYk40SDc2enVOVzRnTS9uaC94dUsxRy8vdkdCbVFB?=
 =?utf-8?B?cWNwM3k5VEhUY05nR2hqSmpBRUVrWVY5RU1IZmxZUGNmcU8xdXNhR24wdUlK?=
 =?utf-8?B?bVphckE2bEtvVHRnV3F6WUZ0OWwrT3ZrWTFJK0xzWUhKMjd4UGlXVVF6T0V6?=
 =?utf-8?B?eDlCOE1lZTdmdTkxYWovOFNDaFMrdDhzVy9qc1ZNMVhMSDliMGdRVm9hUlhI?=
 =?utf-8?B?ZmFYN05aWTF3Y3ZqdWVNcGZOYWZhV21TNVVJNW50cit4N21pOVVjcnRQOEJi?=
 =?utf-8?B?MU1zUktISTA0bHl0aTI3a1VSdzRUSURxcXFpRDVjODRkRWJQbUJBb2p2ckh0?=
 =?utf-8?B?blArenZQTm84WnoyVTZ0VWhacmJ2c0xaUEhTSFpuT2ZpSW1sZm5ZK1EyNlRP?=
 =?utf-8?B?TDlrMDkyb1hROFUyZi9zL0pDd1hkYkRlOXlFWXd2WmVpVEFaUGVTa0pZWGJv?=
 =?utf-8?B?TGMxSHE0aUl6S2xGYUJiT1RNK0hSZmtuYjNhNktKTjhxQ2pTRjlJUXJrNHBI?=
 =?utf-8?B?M1hZcHdDWGpRSE9XQmxaQi8zNXF1MXo1enU0MG9FMnNEcWZlWXF6alp3U2xD?=
 =?utf-8?B?bzFGUmQzL2dmblQ4YnJRczJFN1ZEdzlnaGUvU205alcwcUpCUEhyU0FRZmRH?=
 =?utf-8?B?R3dRb3lENnZxc29GLzl1Nm44TFI0UHNFSVJENUtKQnk3VnFBS1FKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb98ca83-c39b-466e-da85-08de75e1ae8a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:22:09.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y24IiI02tqIUWm5QZtXZpsGXtrn+COsB3csaT1CcBNVege/MjWjPE5D3Yr3+oE8rLSb5hTFGr7SWBjC/8F0h8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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


On 27-02-2026 02:43 pm, Michel Dänzer wrote:
> On 2/26/26 17:05, Tvrtko Ursulin wrote:
>> On 26/02/2026 15:51, Sunil Khatri wrote:
>>> update the type for num_syncobj_handles from __u64 to _u16 with
>>> required padding.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>    include/uapi/drm/amdgpu_drm.h | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index 33e8738ce91f..42b4c0f6746b 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -479,7 +479,9 @@ struct drm_amdgpu_userq_signal {
>>>         * @num_syncobj_handles: A count that represents the number of syncobj handles in
>>>         * @syncobj_handles.
>>>         */
>>> -    __u64    num_syncobj_handles;
>>> +    __u16    num_syncobj_handles;
>> Could probably cause build warnings/errors for something which builds fine today. Hm on big endian it actually breaks completely.
> Yeah this is a clear UAPI break, no go.

Yeah i am holding on this change for a cleaner solution. I acknowledge 
the UAPI breaking here.

Regards

Sunil khatri

>
>
>>> +    __u16    pad0;
>>> +    __u32    pad1;
>>>        /**
>>>         * @bo_read_handles: The list of BO handles that the submitted user queue job
>>>         * is using for read only. This will update BO fences in the kernel.
>
