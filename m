Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C8AD3C534
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 21:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A6C10E33E;
	Thu, 17 Oct 2024 21:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hIP8efRJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA54F10E19D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 21:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYYt4iI6SLbyzGEa1IVbM/moNrYr9iJGut2/iz6vK1TyF+lLXErEwWKWeK979yZ1Zz8Vp6L1ULccdO13Dqv5UFy6zA6WcI9lxO1aWEA0V8LhidTpzO3g9Z8+AH93F3R1G7s5V1KBtsE2WA8BHHEuiM5EPbSzze0eElzSZLXkMYDFPeO+nIrpEUeuDibG1IN6S9rqfDocXEp+l/4HHOqEciS+2Wnwyc2violUsguskUhHNjn3s489O3vI2/J2VxudykE0ZT6556I9vujdqPPCnt0+L4b4a/TgNpspK3iT3nzdbGUsg9BeyeU5CaaDwYOs7Z/W9ePJSxrcJEhuJTN+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikKSbQAP8EbFP00NEJJf8IwqG1q1t9ln20qn4ONGRtE=;
 b=CR6VYT9saDlUPJgEvOY7Jfj1aPWFj3+8s40CCKPgk7JPtnDM+kXd63lzShr5RYrCdGdQj92llUrS2Wzm25JjjFmnPiRsSqwATYYoAJhq3XXBmKn5OY8Ut4DFVRgE5rTdO1hcp7zBXn0SN5DBnEijkHOJQzhzHDF5vbQBhqVGPm7vdC0dGc94M4LmIbnX6XqIJ9biVyGv6FwGmNtOeyRwnFsTgzZsA638cqTCaPyPeNvlVZG5cd/ut8doh5zTG8ZcUdJI5Dqy1kszfFvyNIIoV11buRUlDGcZ9O4AZOaInMq1DP9VE4DEyXku0KNK7sFH/OTSkQBk3/eCgD83VS7eNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikKSbQAP8EbFP00NEJJf8IwqG1q1t9ln20qn4ONGRtE=;
 b=hIP8efRJ7rffan/puyj66Wk+6ttWdGe2WUbSamMMvvp0Lq2/+UcAQhpCpMIzjDt60FOQI99eCHisbNOwG4OHMcJ/WjIyPz5f7E+YF0A4hnYtqtMsAQV69XhwyRNmuc7v7a8VyX0/1eekasUxkDEBuZnsYQrU1cmXnh1kKCfKMlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:04:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 21:04:27 +0000
Message-ID: <003ddddb-9a6b-4e62-9980-da923f7b889f@amd.com>
Date: Thu, 17 Oct 2024 17:04:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20241015212139.63500-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241015212139.63500-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: daa2bca1-9288-47d1-0424-08dceeef4984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alJweXpvcjc1ZitPTXZNcENGcnRBN1BrWVhMbllEVTVqR3QxWXllNFNvOG1B?=
 =?utf-8?B?YU9QRFJCcWNiNTFOVGI3UHpQRmgxcUxuV0lYY2s5N2lFcHNDaTlVUUZOWFlR?=
 =?utf-8?B?SzY2UnVXVW1UOUd4MjhYS1NEdnJHa0g2ZG1xUEE5QWNoUHkzTWo2U3VzZ0RZ?=
 =?utf-8?B?L0E1WVdIS3JOTnJ6U09BQ3Uxclp0RVNEQzI3NkZIamlsWTNlOTNoTWVzd0xL?=
 =?utf-8?B?K0FZaHM0alpEMnlCYkRGTzVZY0RUUUpTUVhxL1Y5cXAxZW9LcmlYOEttUC9y?=
 =?utf-8?B?VVQ1OGp5UjZaOGR0RWV5RUVybW4wYklXR0RqWXd3QzVUY2tuV0x1UXBvQTdS?=
 =?utf-8?B?VFZqOVpHSklqUm81RTRRd3B5ME4yTXdLSTFQcXl2MU8yRTFmeU41WUVBTjV1?=
 =?utf-8?B?Ync5ajcwNENwSy91bzJzTkJUem9hU1pheCtvTnkzOER4NGJNSEhJMmVUNGNR?=
 =?utf-8?B?UFN1VWF4bll0TnY4czdaaEl1a3Q4bW54OVNIckJBUnFCR21ZakpibElHclM2?=
 =?utf-8?B?Q1VyL0cweld0aWlmQjROOTdjMzFJVHZydGlsVWJWQXVPV1RRY1IzMEhERjBM?=
 =?utf-8?B?U0RsODlKTW5NQS90RCtTNmFRT1NQbGc0dFovT2R1NmJhRDk0cHptbFR1TVhk?=
 =?utf-8?B?SXVoaGRwQjdCcjNQMys3NmE1bG0rY3BTTzcyeTYrRWVMTUpEZ0hCZTMyMG5t?=
 =?utf-8?B?cFBabC9nU241R1poeU5EcnY4YnM5TThFVUlDYVhZSHV3RTBwcGpaOWROWjdi?=
 =?utf-8?B?QzVxeWsrMnpwN3h2QjhjVk45a0NPTVlmaExLYk5VbUM1SXhSQjlTcDVHMVBD?=
 =?utf-8?B?Yk1QUng2dE1zcjFpRmt6dW9jVE9pdHlmUDNmZE9kNGZ6ZFUyYkRTaXQyNzhB?=
 =?utf-8?B?b1JQUldKSTk3QWc0R0I0NVNJbXdpNTRtblpvR3k0T1RmWTdlN1lpbTF5ZmQr?=
 =?utf-8?B?Q0dJNy9MZkNyeUxENmZsUWdOeDZSM1dKUjNxSy9HNnYwSjFsNUl0bGROb3hh?=
 =?utf-8?B?RlQxS2k4VE1SM2xIOTFWRktHejZhT3U4U0FxUDA4ZFB1TVZBN1ArV21kR3VQ?=
 =?utf-8?B?M0Rwb1VpVDJNZUxTdjhad0p5WFdUVHpCb0U5NTlkbkcwaEJxUWhmT1F4dGYv?=
 =?utf-8?B?V0s1amJGc3A0OGFpWGpzTGZiTVI2eGJWRzhnSlpnb3NaY3NyN2ltVFpYRndm?=
 =?utf-8?B?WTVNT0t5dWxqbGFXWS91dXRMUWY5RWtUS2pBeDFtdkVkY3RkYzFubW9hZEpz?=
 =?utf-8?B?MTFtSVdaSEprdUgyRDJnWkRkQ05UNEJTY1QrSllqRkw3UUdXSkYzMm1xZjJC?=
 =?utf-8?B?REtCNGQzcUhMRzdqdkZwQnV4ZVlQN1U2Z1Uwa2lkSEVGOERmQzNIc3FraW1h?=
 =?utf-8?B?T2t2Mkx6Mkt5SnlYbUJEWlZQekErbDdWUURsYnBSZ2tNUVYyeGVsZzBhSVVn?=
 =?utf-8?B?SndxNzBFbVBQaHlSTk5GcC9zTkNici9uMTEvOWNzcXl5TlBidDN0T2RwdDg0?=
 =?utf-8?B?UGIwaWVQaGp0L01WQXRSWU82TWplRGYzcE5VKzZ5T3RBTXB5elZMMzdjbzc4?=
 =?utf-8?B?WVc2Smc0aCtaeVVXb2VWYVZPaW1jZS9CVVRMYVkvMmVEdkxaZWZnTjU5YnhT?=
 =?utf-8?B?OEg5QVdqaWpsajhrZTc0aTFuS2Y5cG9VNThUZ2Z4Y21pRGx3c1dQNjJYczlr?=
 =?utf-8?B?SjJwVk1valdkZnpFR1B2c0o5aDRDbHJlUVJUVWRWNlg2aW5KcjdVQmZ4TnRX?=
 =?utf-8?Q?f8ImTrmI/jfMQTkPXWZpOwiTy8FUQBCIQelGoBE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVl6OXNlR1I5dkhzSXlWOXVyMW42clJiVlFXVnNEeXQxUUV4YWxiTTVwd1FN?=
 =?utf-8?B?aEZXcUNpbzNra3Arem14YVFaTDZRMWRiU2JWSU52TW9RYXJndGRwSGt2dHM4?=
 =?utf-8?B?bGpucjhkeC9ZamZtYi9BbFo5L3hUeWlDWWV2cUhsdTJhcFZkWEJxaWI0SXl2?=
 =?utf-8?B?bXdwckw5K1E0WXphR0VnZzFFQlNGMFp6R1lvOVQzd3hPUUxHMnhWVW9JYmRU?=
 =?utf-8?B?ZUUxYkdKNmJjVzRKc0JCbVlEeSt2dmxMckFLM3ZMQ1RwWTVPcnBNRXl0WEdU?=
 =?utf-8?B?MFBCRTcydHpHL3BNRGdYTXRtbVlUWDhpNDN4U2VkOCswUHZnU2tld0s4K05x?=
 =?utf-8?B?RmNQV2xCTVpJQVFsd2VXY3JZZUN5aWk1Z2h0QnNRZGJ1RGJsWnFrd24yVXB2?=
 =?utf-8?B?dkNicTJUamFXOVl5TktORi9NWU9uZityd0tNMjdCbjhPdWIybW1VenN0Qmg2?=
 =?utf-8?B?eXNla256ZWV6Tmx0ZkFXWmF3YzNHRmVkcVBaVXVNV2pIWDRxLy9CZTY3b0Q1?=
 =?utf-8?B?Snlad0pYUEZsNkN3WEV1MEp6d3VHSUFVSlB4MDNMTmU3M3IwSGFTa2x6SzFC?=
 =?utf-8?B?U3RTRGZmTHVuV0Q5RjFtZ3UvZ21la1M1Mlk2VDAxWi9SNHgxNysvM1ZFMVI1?=
 =?utf-8?B?RE8zZWUwMTVwblR4VUhRd3VDK21vL0dJYlF5c0d3bFlUbklKQzQzbWpCOW9w?=
 =?utf-8?B?U0d0ZDlWakFveGoxd1NSTlcyUmJZY2hIRXhzYUh6eFV1clFMR2p5RE5EOEdK?=
 =?utf-8?B?b3ZxVytKa0xaaHRZc0RUS2h0NUlGMlpoWHYwM0I5dVVhTE9OdHJGMEVlSFZt?=
 =?utf-8?B?d1d4bG42NUEyNGZVS1p4a0thTk82bVk5NVFqZ0dVQy9kMk9Pb0ppK2d1OHJo?=
 =?utf-8?B?ait1bTJ0d0NVa0dwdlp5ZWYxS2V0TC9XOFkyWVNSRDRZOXRFZU5YaFhxV0JH?=
 =?utf-8?B?QWMrNktFM1p5d0VqeGZjZDVTaDhXcGFPM0oySjkwTDcwQkxUUVVoQTdGaDlo?=
 =?utf-8?B?VFd5SFNia3YrN3ZPSXk1SmdybzMrTUN2cGtsUlB4WS9GaitERkpJV3g1aEYz?=
 =?utf-8?B?WDd1S0JRamVNUVpiNGp1ZUJIbzRXZ1FwbHZxUmxaelBqWkN4RkNjYUJlRVhF?=
 =?utf-8?B?emY3QVhUQnlsdVJYZDdka2VTN1ZqYXNsQWJqMGRVbzVOeFo2ZmhBOEF6SlVZ?=
 =?utf-8?B?N3huT0c1TG1LdVhVK0F6ekcrL3QyaTlGMnlhQy9lVWZGL000Z0lyeXVPeTB2?=
 =?utf-8?B?dDJFVEJPVm94NS93N0tsd2hBQlVpN1FuM00zeVZkTytyTFFTTUN1T0IxcUhv?=
 =?utf-8?B?VVVSa1lEeGRHZVgvY1pVRFIvOVNvb3ZoQVQySlBVZWl2NUMzNFB3aE5ZOFpt?=
 =?utf-8?B?eEpkcS95ZTBia05BVDBPREh2bFZ2THRBdHhEajJ4WDRQMjdLc3VjRitJQmx5?=
 =?utf-8?B?OVBpcVNkNGhsVmNLQ1pNUVlQYWlpeFdTdGx5dDc1QTArVTNiaE05V1Izck1u?=
 =?utf-8?B?cXRKcnovcEdpV09RRzQzVHFlc0h1cHlBQXJneWFkU3RiOXl1SEFkc2ZsNm5V?=
 =?utf-8?B?clZWeWw2eVAwVm5Kb1dnUitoR3ZYc01oNkt6bEVXN3lqRDY0QzZHdnpUb0hx?=
 =?utf-8?B?djdsdjdkQjhPc2tUT2NhOUtDdWxiTUFEU0duV0FVRlBObGN4WEdZbnFrYUNB?=
 =?utf-8?B?ajVVMytYcHF0SlFNY0pnVDhBRmtPQU1WUEt6aEwzSEJEMjZzUVpCeGpOTmNW?=
 =?utf-8?B?RnJ5MkM0Y21uWElFT0hXYllDVFM4dUt5ZXFvc1Q3dFRXNWg5QUNiRlVVaUEy?=
 =?utf-8?B?blFpaGcrajR2VjdRN0tDNDBENmpaOVgyb3dNTkR6blBjUXhoVE9ZSkpVVGZQ?=
 =?utf-8?B?RFNJQlozbnprUURZcDcvcS9vc1lEb1hGTDVkU0NHSFVDZ2wxYUVLdmh5ckVl?=
 =?utf-8?B?ZVkzVnY0MlhuN21xTnR1MTlJQmVxQkhROHltL3FBempwd2lNSjdUNVl0NUpU?=
 =?utf-8?B?bUVtd0xuRHEyenlVVWVVMDdjcHRTWjZoT2h5cjllRnNVWXQ0dmxva2RNenFn?=
 =?utf-8?B?T29Cdmpya2lKOHo5c3p0OUlHY2tiOHVheUJkY09yaWw2MnVLc3hXNGZ4MXdU?=
 =?utf-8?Q?3kNg/bo/CauvdCfQV6VZzb8sk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa2bca1-9288-47d1-0424-08dceeef4984
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:04:27.8834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxqaqrpKKuVRumX32L3ZUlKXlpXZbhj79YgnkCSjYkkBxqhowS2Ro60ToUnoASuzm0reXf9wCXJLS5gKyI60nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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


On 2024-10-15 17:21, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> The purpose of this patch is having kfd driver function as expected during AMD
> gpu device plug/unplug.
>
> When an AMD gpu device got unplug kfd driver stops all queues from this device.
> If there are user processes still ref the render node this device is marked as
> invalid. kfd driver will return error to following requests to the device from
> all existing user processes. Existing user processes can still use remaining
> gpu devices during/after unplug event.
>
> After all refs to the device have been closed from user space kfd driver
> topology got updated by removing correspodent kfd nodes.
>
> User space can use remaining gpu devices that are valid at same time. When all
> AMD gpu devices got removed kfd driver will not allow open /dev/kfd request.
>
> Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devices
> and function as usual.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 78 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 43 ++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  6 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++-
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 24 ++++++
>   9 files changed, 183 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index b545940e512b..651ae0775f80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>   		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>   }
>   
> +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd)
> +{
> +       kgd2kfd_teardown_kfd_device(kfd);
> +}
> +
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>   {
>   	if (adev->kfd.dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 7e0a22072536..bd241f569b79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>   
>   int amdgpu_amdkfd_init(void);
>   void amdgpu_amdkfd_fini(void);
> +void amdgpu_amdkfd_teardown_kfd_device(struct kfd_dev *kfd);
>   
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> @@ -431,6 +432,7 @@ int kgd2kfd_check_and_lock_kfd(void);
>   void kgd2kfd_unlock_kfd(void);
>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd);
>   #else
>   static inline int kgd2kfd_init(void)
>   {
> @@ -511,5 +513,10 @@ static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	return 0;
>   }
> +
> +void kgd2kfd_teardown_processes(void)
> +{
> +}
> +
>   #endif
>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e47655e02c6..4529d7a88b98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3315,7 +3315,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
> -	amdgpu_amdkfd_suspend(adev, false);
> +	if (adev->kfd.dev)
> +		amdgpu_amdkfd_teardown_kfd_device(adev->kfd.dev);
>   
>   	/* Workaroud for ASICs need to disable SMC first */
>   	amdgpu_device_smu_fini_early(adev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index a1f191a5984b..d246f72ae0e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,6 +327,13 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		err = -EINVAL;
>   		goto err_pdd;
>   	}
> +
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		pr_debug("gpu 0x%x is not available\n", args->gpu_id);
> +		err = -EINVAL;
> +		goto err_pdd;
> +	}
> +

Instead of duplicating this in all the ioctl functions, could this check 
be done in kfd_process_device_data_by_id?


>   	dev = pdd->dev;
>   
>   	pdd = kfd_bind_process_to_device(dev, p);
> @@ -578,6 +585,12 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
>   		goto err_pdd;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		pr_debug("gpu 0x%x is not available\n", args->gpu_id);
> +		err = -EINVAL;
> +		goto err_pdd;
> +	}
> +
>   	pdd = kfd_bind_process_to_device(pdd->dev, p);
>   	if (IS_ERR(pdd)) {
>   		err = -ESRCH;
> @@ -621,6 +634,11 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
>   		goto err_pdd;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		err = -EINVAL;
> +		goto err_pdd;
> +	}
> +
>   	pdd = kfd_bind_process_to_device(pdd->dev, p);
>   	if (IS_ERR(pdd)) {
>   		err = -ESRCH;
> @@ -704,6 +722,9 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		if (!is_kfd_process_device_valid(pdd))
> +			continue;
> +
>   		pAperture =
>   			&args->process_apertures[args->num_of_nodes];
>   		pAperture->gpu_id = pdd->dev->id;
> @@ -779,6 +800,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
>   	for (i = 0; i < min(p->n_pdds, args->num_of_nodes); i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		if (!is_kfd_process_device_valid(pdd))
> +			continue;
> +
>   		pa[i].gpu_id = pdd->dev->id;
>   		pa[i].lds_base = pdd->lds_base;
>   		pa[i].lds_limit = pdd->lds_limit;
> @@ -901,6 +925,11 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
>   		goto bind_process_to_device_fail;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		err = PTR_ERR(pdd);
> +		goto bind_process_to_device_fail;
> +	}
> +
>   	pdd->qpd.sh_hidden_private_base = args->va_addr;
>   
>   	mutex_unlock(&p->mutex);
> @@ -981,6 +1010,11 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>   		goto err_pdd;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		ret = -EINVAL;
> +		goto err_pdd;
> +	}
> +
>   	if (pdd->drm_file) {
>   		ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
>   		goto err_drm_file;
> @@ -1031,6 +1065,10 @@ static int kfd_ioctl_get_available_memory(struct file *filep,
>   
>   	if (!pdd)
>   		return -EINVAL;
> +
> +	if (!is_kfd_process_device_valid(pdd))
> +		return -EINVAL;
> +
>   	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
>   							pdd->dev->node_id);
>   	kfd_unlock_pdd(pdd);
> @@ -1090,6 +1128,11 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   		goto err_pdd;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		err = -EINVAL;
> +		goto err_pdd;
> +	}
> +
>   	dev = pdd->dev;
>   
>   	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
> @@ -1202,6 +1245,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>   		goto err_pdd;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		pr_err("Process device is not valid\n");
> +		ret = -EINVAL;
> +		goto err_pdd;
> +	}
> +
>   	mem = kfd_process_device_translate_handle(
>   		pdd, GET_IDR_HANDLE(args->handle));
>   	if (!mem) {
> @@ -1266,6 +1315,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   		err = -EINVAL;
>   		goto get_process_device_data_failed;
>   	}
> +
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		err = -EINVAL;
> +		goto get_process_device_data_failed;
> +	}
> +
>   	dev = pdd->dev;
>   
>   	pdd = kfd_bind_process_to_device(dev, p);
> @@ -1384,6 +1439,11 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		goto bind_process_to_device_failed;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		err = -EINVAL;
> +		goto bind_process_to_device_failed;
> +	}
> +
>   	mem = kfd_process_device_translate_handle(pdd,
>   						GET_IDR_HANDLE(args->handle));
>   	if (!mem) {
> @@ -1567,6 +1627,11 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		r = PTR_ERR(pdd);
> +		goto err_unlock;
> +	}
> +
>   	r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, args->dmabuf_fd,
>   						 args->va_addr, pdd->drm_priv,
>   						 (struct kgd_mem **)&mem, &size,
> @@ -1616,6 +1681,11 @@ static int kfd_ioctl_export_dmabuf(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
>   	mem = kfd_process_device_translate_handle(pdd,
>   						GET_IDR_HANDLE(args->handle));
>   	if (!mem) {
> @@ -1660,6 +1730,9 @@ static int kfd_ioctl_smi_events(struct file *filep,
>   	if (!pdd)
>   		return -EINVAL;
>   
> +	if (!is_kfd_process_device_valid(pdd))
> +		return -EINVAL;
> +
>   	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>   }
>   
> @@ -2990,6 +3063,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   			r = -ENODEV;
>   			goto unlock_out;
>   		}
> +
> +		if (!is_kfd_process_device_valid(pdd)) {
> +			r = -ENODEV;
> +			goto unlock_out;
> +		}
>   	}
>   
>   	switch (args->op) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fad1c8f2bc83..019567249110 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -893,6 +893,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	svm_range_set_max_pages(kfd->adev);
>   
>   	kfd->init_complete = true;
> +	kfd->valid = true;
>   	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
>   		 kfd->adev->pdev->device);
>   
> @@ -919,6 +920,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   {
> +	struct kfd_process *p;
> +	unsigned int i, j;
> +	unsigned int temp;
> +
>   	if (kfd->init_complete) {
>   		/* Cleanup KFD nodes */
>   		kfd_cleanup_nodes(kfd, kfd->num_nodes);
> @@ -929,6 +934,20 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>   	}
>   
> +	/* now this kfd_dev has been completely removed from kfd driver
> +	 * before kfree kfd iterate all existing kfd processes, if kfd process
> +	 * uses any kfd node from this kfd set its ref to NULL
> +	 */
> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +		for (i = 0; i < kfd->num_nodes; i++)
> +			for (j = 0; j < p->n_pdds; j++) {
> +				if (kfd->nodes[i] == p->pdds[j]->dev) {
> +					p->pdds[j]->dev = NULL;

Could this be done in teardown_kfd_device? Then you may not need a 
separate "valid" for is_kfd_process_device_valid. And any accidental 
access to a device associated with an invalid pdd would automatically 
trigger a kernel error message with a backtrace.


> +					break;
> +				}
> +			}
> +	}
> +
>   	kfree(kfd);
>   }
>   
> @@ -1485,6 +1504,30 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   	return node->dqm->ops.halt(node->dqm);
>   }
>   
> +/* tear down this kfd deve */
> +void kgd2kfd_teardown_kfd_device(struct kfd_dev *kfd)
> +{
> +	struct kfd_process *p;
> +	struct kfd_node *dev;
> +	unsigned int i;
> +	unsigned int temp;
> +
> +	kfd->valid = false;
> +	/* stop queues from kfd nodes in this kfd dev */
> +	for (i = 0; i < kfd->num_nodes; i++) {
> +		dev = kfd->nodes[i];
> +		dev->dqm->ops.stop(dev->dqm);
> +	}

If the GPU was unplugged already, what's the point of this? Won't this 
trigger a timeout?


> +
> +	/* signal a gpu device is being teared down to user spalce processes by
> +	 * KFD_EVENT_TYPE_HW_EXCEPTION event
> +	 */
> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
> +		kfd_signal_hw_exception_event(p->pasid);

This sends exceptions to all processes. It should only do this for 
processes that use the unplugged device (i.e. have a pdd that uses the 
device). This excludes processes that don't have the device in their cgroup.


> +
> +	return;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index dbcb60eb54b2..b8dd80ee17be 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -378,6 +378,12 @@ int kfd_init_apertures(struct kfd_process *process)
>   			continue;
>   		}
>   
> +		/* kfd device that this kfd node belogns is not valid */
> +		if (!dev->kfd->valid) {
> +			id++;
> +			continue;
> +		}
> +
>   		pdd = kfd_create_process_device_data(dev, process);
>   		if (!pdd) {
>   			dev_err(dev->adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6a5bf88cc232..97e7692ce569 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -371,6 +371,9 @@ struct kfd_dev {
>   
>   	/* bitmap for dynamic doorbell allocation from doorbell object */
>   	unsigned long *doorbell_bitmap;
> +
> +	/* this kfd_dev valid or not */
> +	bool valid;
>   };
>   
>   enum kfd_mempool {
> @@ -1055,6 +1058,10 @@ int kfd_process_restore_queues(struct kfd_process *p);
>   void kfd_suspend_all_processes(void);
>   int kfd_resume_all_processes(void);
>   
> +static inline bool is_kfd_process_device_valid(struct kfd_process_device *pdd) {
> +	return (pdd && pdd->dev && pdd->dev->kfd && pdd->dev->kfd->valid);
> +}
> +
>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
>   							 uint32_t gpu_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..c06eb9d8008e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1157,8 +1157,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	ef = rcu_access_pointer(p->ef);
>   	dma_fence_signal(ef);
>   
> -	kfd_process_remove_sysfs(p);
> -
>   	kfd_process_kunmap_signal_bo(p);
>   	kfd_process_free_outstanding_kfd_bos(p);
>   	svm_range_list_fini(p);
> @@ -1173,6 +1171,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>   
>   	put_task_struct(p->lead_thread);
>   
> +	/* the last step is removing process entries under /sys
> +	 * to indicate the process has been terminated.
> +	 */

This comment doesn't provide any useful information. What would be 
useful is, why this needs to be the last step? Without that, I see no 
good reason for this change.


> +	kfd_process_remove_sysfs(p);
> +
>   	kfree(p);
>   }
>   
> @@ -1536,6 +1539,12 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   	if (err != 0)
>   		goto err_init_apertures;
>   
> +	/* no any kfd_process_device can be created */
> +	if (!process->n_pdds) {
> +		err = -ENODEV;
> +		goto err_init_apertures;
> +	}
> +
>   	/* Check XNACK support after PDDs are created in kfd_init_apertures */
>   	process->xnack_enabled = kfd_process_xnack_mode(process, false);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c76db22a1000..eaf4ba65466c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -124,6 +124,11 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   		return -EINVAL;
>   	}
>   
> +	if (!is_kfd_process_device_valid(pdd)) {
> +		pr_debug("device 0x%x is not available\n",dev->node_id);
> +		return -EINVAL;
> +	}
> +
>   	/* Only allow one queue per process can have GWS assigned */
>   	if (gws && pdd->qpd.num_gws)
>   		return -EBUSY;
> @@ -498,6 +503,11 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   	if (WARN_ON(!dev))
>   		return -ENODEV;
>   
> +	if (!dev->kfd || !dev->kfd->valid) {
> +		pr_err("Process device is not valid\n");

Would you expect to see this message during process termination after a 
hot-unplug? Should this really be an error message, or would an info or 
debug message be more appropriate?


> +		return -1;

This should be a proper error code. -1 is -EPERM.


> +	}
> +
>   	pdd = kfd_get_process_device_data(dev, pqm->process);
>   	if (!pdd) {
>   		pr_err("Process device data doesn't exist\n");
> @@ -567,6 +577,10 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
>   		pdd = kfd_get_process_device_data(q->device, q->process);
>   		if (!pdd)
>   			return -ENODEV;
> +
> +		if (!is_kfd_process_device_valid(pdd))
> +			return -ENODEV;
> + 		vm = drm_priv_to_vm(pdd->drm_priv);
>   		err = amdgpu_bo_reserve(vm->root.bo, false);
>   		if (err)
> @@ -612,6 +626,11 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
>   		return -EFAULT;
>   	}
>   
> +	if (!pqn->q->device->kfd->valid) {
> +		pr_debug("device where queue %d exists is not valid\n", qid);
> +		return -EFAULT;
> +	}
> +
>   	/* CUs are masked for debugger requirements so deny user mask  */
>   	if (pqn->q->properties.is_dbg_wa && minfo && minfo->cu_mask.ptr)
>   		return -EBUSY;
> @@ -679,6 +698,11 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
>   		return -EFAULT;
>   	}
>   
> +	if (!pqn->q->device->kfd->valid) {
> +		pr_debug("device where queue %d exists is not valid\n", qid);
> +		return -EFAULT;

EFAULT means "bad address". Probably not the right error code here.

Regards,
   Felix


> +	}
> +
>   	return pqn->q->device->dqm->ops.get_wave_state(pqn->q->device->dqm,
>   						       pqn->q,
>   						       ctl_stack,
