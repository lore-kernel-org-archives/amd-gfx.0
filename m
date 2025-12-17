Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF78D65528
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 10:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645FF10EC0C;
	Wed, 17 Dec 2025 10:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Mj2quLj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19CF10EC19
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 10:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8Yp1ch66Stgwx12qB9Zgt6XeFJIG9NSN1uug2Eupz/wkl4jFLLJ3iaYoFkSy3N7OcPMAfUqq77iy5MhkTfoW7EenhQXUAqtIPI4W2j0drVCd2237rzrmi1/EscKP9sfoG/CYpy7VTOrDQ4161dodHlJ02O2vJcCZD4nKbQ7ENOuZIK3yXVKR9OKfjCL2OHuLxPhiw9KJHPgHK/2sxIQ1Uzb4Pta7M6OREgEXWWycVqO559MFG4X0HsTO8/h2990BIcSnCl4tWzQ9JitlJdV7bimDzKhCi8Rr0xjOQOBr9ZIcmq3xnPEGFlGcQQNq+mdaGQLSAAnGknRfCpAVAFrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JusPFAY+uo3cYD5tO8Z0pJWH3hZqND8DXFuhthUh9ro=;
 b=AWafCCfx0l53Aqibq0NtBV20Zec0s5jHmd9BGPBrPRaySw7HfG7kcXyl/zAuLUBf/M4E4qpxvNgzrnSowaqBzf/dIgvq3mjmf5ciWlOQj7U9uGuy//SDHBjdXH7B0xk6ri/4c2fKUhmp3aIp/aywVIe5SFr8f3r0rM5RgbG66IfydiM+RE26OFQjF3BlhdIS3QR59QpnQArQvWqASzMxCEly2AfTf4BW+zoDlTQRegeGvVaqchjDYCQGMfRHaOql/KDhUosO+GI6urgORYxkQ36rlmOSVZTgxgxpWDFeI3obDbdvbRduZf+hFPKuVZficeESUl+u4pp515WeTYZo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JusPFAY+uo3cYD5tO8Z0pJWH3hZqND8DXFuhthUh9ro=;
 b=3Mj2quLjDn0voS4hygUdERWYOs7YpDDWaKliKCrkGWBd767t1PMZnrhTL3JlqnlhBHsUnbgkNSBQUceJbXbovBpApirfEBrS50bBuJZ/lRIIOQnvKbuBHcFWzGmzbLJdTJNNM2R+YMUJ3MHr7fw+talbwCMtlOT7shbTpnfTIvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 10:06:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 10:06:29 +0000
Message-ID: <a492aaf5-4251-482c-adf9-3a3178a5694b@amd.com>
Date: Wed, 17 Dec 2025 11:06:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix signal_eviction_fence() bool return value
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>,
 Gang BA <Gang.Ba@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20251217095811.709295-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251217095811.709295-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a739eba-79e8-4515-d4c6-08de3d53f272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clh1NXRodllBRmVGTmY4bFpON1lIVldhWnI1WnBGMWZTTndwbXRORmhBOXc4?=
 =?utf-8?B?NjVmVTRiVVpFRzFhUGtiUVNpQnh0dHBudkYwSnhwK1N5amtFMVpyWkJWY1U3?=
 =?utf-8?B?QzhQL1NrdTdmK0ZMS2dkbTdaNkM5RmxWVnJzUnlmQnNmd3o3SlZ4ckt0NDAw?=
 =?utf-8?B?Uk5QWmIrQUV6ZTJIQ1ZCbll6dHdRQ2xLd1MrUE1rZDllSDBRQ1o2TDNuTWU2?=
 =?utf-8?B?OGk3M0RVWVhpNnJUV1BkYXFWWjZDNFZGMG1kVyt1bTlacDduUVVKaVEyamlu?=
 =?utf-8?B?K0p6b2R2Y2RJaktMQmI0N2dMckF3Qi9EZEZKRTBFSlhSVUt0QVZYQng3UTY0?=
 =?utf-8?B?QjlaQ3RGdm0zT3JzU2ZraW8xOEdPRkJ6RDR4TFhRa0tsdTE0ajJlcUZwS2hB?=
 =?utf-8?B?WGd5dlBmU3ViVUU4STZqb2VqbVVrVkw1cFV2YnN6OUdKWHBpSVdXbnp6RlRD?=
 =?utf-8?B?ZXFjaURaNmVSNm1EaFhuUFNPOE5zVVdpT3pSYVM0Mit2em1yc2VWaGFNN0k4?=
 =?utf-8?B?YXBnZ1hFVi92TW9ESDJ1UzNvZm1GYjNGQWtJN1Y4N0ZZVnlEMlFNMWVSa0ZB?=
 =?utf-8?B?UGkwR0NVOGlaWk1GV0dBZCsrWTRzNEdhdTFXcjBUaE5xckdjQkNPSWRwd2VD?=
 =?utf-8?B?Z3AxSUlNS1lzelFFdmVYWk01eGxoZGJQMmJCaHViLzFrWTVWelZIbkV4am1a?=
 =?utf-8?B?SDRYQVRZWlBGM0dGc2p0dzlENUNrMXFxKzFsZ21LdGNvcWdBY3V2MW9UNGg4?=
 =?utf-8?B?SXdIaU1XSHMrdWRvQ3hnMUF5eXlIcHFCSHNWYXh5V2JvM0YweFpJSGFDOHY1?=
 =?utf-8?B?OEM0L3lwK3VteDNCYWF3dm1HK1lFNllDZFVtQ1k5YjNodnFGNTNpTzdyQy9F?=
 =?utf-8?B?ZWM2UmF4eEQ1eWpiWE1KalJRNkFXRkRWOWJWTWV5RHdpbVMzWnYydU5YNGNJ?=
 =?utf-8?B?amF4RWRJWHNGeU9OaWNYTTE3ZVp3YkVtMWxBTlJkeU04RldQL0FRemRIL2RB?=
 =?utf-8?B?NFA3a0l2Vnp2WUV1L0tydXlZY1BleE91bTJCREJsTU5KTTRpaWVWZUJ5MUZl?=
 =?utf-8?B?cldHeTllNUZiOXNHb2t1ZEl4K3VxNW5RQVBQaW9qTkplVUg5QzNXc1J1N1dp?=
 =?utf-8?B?aDF2UjlKcms3WHZNWmUraWxLZStaTlgzSFh5Yis3Sm53Znk4a25KNWFZVUlx?=
 =?utf-8?B?blRSdDR6Z0dhZTlNUXN0elU4c0dYRmE0WmF3ZmgxVTlkSGJuWnVuS0pKZzQ2?=
 =?utf-8?B?WTlabzF0bnZIUkY2TlFDY3BuVGxVTGUwOHY4RzhqcFlCandDYmdETUcydHl0?=
 =?utf-8?B?UHZFQVhpTnpmaWJNeDhlbmUrQ1BrTnJCaXlZSDgyaXBOMmM2aVZRcmdJQnlN?=
 =?utf-8?B?YmN3NG5rVFI4OXA3Qm04WmdIQ1V4MElNV0hzU1RPV1FEQ210em83RW80cm5Q?=
 =?utf-8?B?V3VDb05MWkowOXdmVlRSOGVhZHRTVzFEOFlLVXRBME5iVzNqUWxoZDhlRG96?=
 =?utf-8?B?RVZPL1FUYnBIM2g2S0EyUWxSNjVadmFXM1JRdlRTVGRVVWxYcFlrY2NOSVVJ?=
 =?utf-8?B?UkdaUGY3TVdoTFB0WlRJSlhsM3NGNFJQUk0raDJxOUdWZlFKMmdMVDBVUm5t?=
 =?utf-8?B?Y1lvOWwwcHRrekZmNnVKOFRaVkVKZWZROW95bG1tVzZZdVFrUnhvTHplN3Nl?=
 =?utf-8?B?REJVWEQwZzQ0MlZPUGVGRTdlODdQYVEyY1QvVS9CbUJJdE03cmEybTUvdHFH?=
 =?utf-8?B?dmJFcHVtTlVlZlVPai9ZejIyYXBBa2NibzFRbHZWOWxVZnd1WUgvckNJRU9p?=
 =?utf-8?B?QlpuRit2WkIvcFhNRTM0THBxYkp0ZlorbXluN2gxMFJVWjVWekcvT2RSVk1B?=
 =?utf-8?B?WjByQkJmcUxBV1UzOXZYVGxjc0RZS3RZb3ltWTd3ZGtPWCtuS2srMmwxblc3?=
 =?utf-8?Q?i3+GiwhG3GwyD9K+C77Eo752AaAf5vWG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0VPSnNVUzIzSHlXQUhoUFRWRmZmSm5OTUNaSEQxS01MUG9jcVhzVEp2L053?=
 =?utf-8?B?N2Jpd0lrSUFkUnlaUGZmaGptbFMwUG9pSThWaU83b2tkQXlIVzJVZUhCRis5?=
 =?utf-8?B?T2svRXdCZjd3cm92WjRyYzFtOW1TTkhia0NCSzJCWWxxNHdPQUczMWl3NFRO?=
 =?utf-8?B?elZwcXlxNWZSUlJxb2lWUmJBYjNuK0ZseXg5ZHJCN0dwUlh2UERmZ2hXQlRQ?=
 =?utf-8?B?MEtIakZYaHQrakFLd0ZWbURkdk82QUdCQkR6eXFPeU4ySE82NDQ4YWZ4MkJX?=
 =?utf-8?B?QVFwRzIyaGhVRnF6eUdHYlk1M2NyRkdQKzU1U2h3L2p2eHhzOTNOTHZnTlg4?=
 =?utf-8?B?WmdwTDYyTm9SL2hDYlhRVFcrKy9CUmwxNm5iaVhkWW14enp6cjlaWGZ5Mnlp?=
 =?utf-8?B?ZGhtajZNRDEwc083YlBDUXUwcXNVQVd4RkpHb3gxaFJTZ3pXdzZCb0FXSlRt?=
 =?utf-8?B?Qy9pdTRJTjM5dkhXNUFmNURHN2VoYy8yL1hkbkZPTmNpZGYrS1dmalBLS1Y0?=
 =?utf-8?B?M1Z6MGlsenNWK0FXTEJ0TmkwK04xd1Zwc0JqMGZIOG4vNUQ1SGl0TStWZGFw?=
 =?utf-8?B?S3VPZXQxT2tGYW9GcmlSbk5jS2czM09hQmR2empvWVBOZ0lqdUtyM3BoOU8v?=
 =?utf-8?B?Q3ZxK1hQSGhORHFZZk1mTitVVEdmN3gxaXdVWVdxNFpsdFV0L2QxMTN0bThW?=
 =?utf-8?B?UHVxMmdJb1VRRHV5TGYydStRRWtpSWlZTUk2Yit5K01TaXVteWhHNTY5Yzhl?=
 =?utf-8?B?SElYeU03dlhERjhncHN4WnhXRFphTmdta1YrZ1NMN205ckhGbkxvY3VRRy9S?=
 =?utf-8?B?Y0pyK0FOR2VHcVl5L0NQNUN5NmRVQzgvOUxONFBRTml2VXV5T25HTzMrY1hq?=
 =?utf-8?B?NXlTVHB4SjlVOTFPTXJJUDc4TGc5MGMyblAwbzJyUWRTREZ6Zit2QjcyTmZt?=
 =?utf-8?B?R0U5V25zTWswQ01lSVpHZjVBWWxvN0tVZjQzVmg1RTE0c2NJMTJsWTVqVjAw?=
 =?utf-8?B?MjR6QS9WVnowRnZOVTZiQ3ArMkVrM1NqOU9tSzduSUgxdUlURjBTOHV0QjZS?=
 =?utf-8?B?Q0VjeVQzZ1BQdnZub3I1QmhuYXhXWU9xSS83ZWUyQ1k0SEEzQStMOVRydEc0?=
 =?utf-8?B?cW1yMkpaRWFZemZQUFNVZ2dXblpWbXJWUGV5KzlTalAyZU96cUY0M3Jibncw?=
 =?utf-8?B?OXN5NUh2TFVHT05ITHhnUkJvQ3FSbEo2eUM3UUNweXpNWDg1cDRoMnJBOWlS?=
 =?utf-8?B?Q2xUK3lVMjNqM0YzVDBTMXJmRUFhZDdmOVg1bnNLVlRlOVhHdGJid3lwc1Bh?=
 =?utf-8?B?bVFLckJSTmVsaGlSTjk1eHJ6ajY1VkdDNTV2czF4T0FoSUhBQ1YyRmNDREVl?=
 =?utf-8?B?d3lzN2ZYZW10VlBWcExkNU9CUjFUK2hOSVlUYmV6TURmUGtZZlFJdS9rc2pJ?=
 =?utf-8?B?QmQ3MlRUTGc1MUMzS0YwZUNRSDR1TWVpL3dJTHUvZWFjQU4yS2JDalRwOXEy?=
 =?utf-8?B?cUZZWXl0SGg4RVE3SlpXN1UxdU5uRkFBMC9IaHJQSUhJRXFNeTJycnlsQnlR?=
 =?utf-8?B?ekJaUjhEcktKUncxZnNBNCtQY2cyUmtLV3hiMlFrOTZKaWpxQjRJUGNibkVS?=
 =?utf-8?B?UFp2UVVQdVRBSzFrMGRRT3o0RXdwNzIrY09DbUFUdjR0M2ovSnFucnVFejhW?=
 =?utf-8?B?WGJPVzJNR0hzWU4vUDNSbTJNOVZubHRFMGxETXhzdnd2OXBLTGFUTE1Wem1X?=
 =?utf-8?B?d0F4TlhsZXo0WVp2N1J6dXFZa3QvTFM0VDhPT0ozVHA3and0M1RUdHhIQzNG?=
 =?utf-8?B?cm1OUUhUam1UMzZDUTVlVkMzNXkybFpjYXRQR0EySjUrVzZrU1hZUVkzV2hE?=
 =?utf-8?B?RVRicWZpZWgyaHRUeldwTWN5NWdldkh0eFBEZVVzZkZJWVJoOElRNFhtQUZr?=
 =?utf-8?B?UmZPM005MGUwN3VNSjM4emxXRlBGVmJLS3dhdFNIU2ZWTi9DOVFVQ1RnTDZU?=
 =?utf-8?B?VU1MQXFZQ3FOY29pV3Jpdml3WUh5MnFJOVBRVEdTRnltaVZlSlVrUmRLaVJp?=
 =?utf-8?B?R3FSdVpZNGVRNnFNU0FQbG9sWWVxWHExaTlMQ28xV2hTVlBjSGFDMjhNUDJr?=
 =?utf-8?Q?5fSs01LwzLwRbCrdNrkdu6M0N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a739eba-79e8-4515-d4c6-08de3d53f272
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 10:06:29.3456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kREuNfXv2LTTQ3JKQdhPPOIGRmYJ2AIRM4uCmh6PF778PLROFb/Ykk0BZasjHez0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

On 12/17/25 10:58, Srinivasan Shanmugam wrote:
> signal_eviction_fence() is declared to return bool, but returns -EINVAL
> when no eviction fence is present.  This makes the "no fence" path
> evaluate to true and triggers a Smatch warning.
> 
> Return false when the fence pointer is NULL, and keep propagating the
> result of dma_fence_check_and_signal().
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:2099 signal_eviction_fence()
> warn: '(-22)' is not bool
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
>     2090 static bool signal_eviction_fence(struct kfd_process *p)
>                 ^^^^
> 
>     2091 {
>     2092         struct dma_fence *ef;
>     2093         bool ret;
>     2094
>     2095         rcu_read_lock();
>     2096         ef = dma_fence_get_rcu_safe(&p->ef);
>     2097         rcu_read_unlock();
>     2098         if (!ef)
> --> 2099                 return -EINVAL;
> 
> This should be either true or false.  Probably true because presumably it has been tested?
> 
>     2100
>     2101         ret = dma_fence_check_and_signal(ef);
>     2102         dma_fence_put(ef);
>     2103
>     2104         return ret;
>     2105 }
> 
> Fixes: 37865e02e6cc ("drm/amdkfd: Fix eviction fence handling")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Gang BA <Gang.Ba@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 2a72dc95cc0f..3e7e91dd4316 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2097,7 +2097,7 @@ static int signal_eviction_fence(struct kfd_process *p)
>  	ef = dma_fence_get_rcu_safe(&p->ef);
>  	rcu_read_unlock();
>  	if (!ef)
> -		return -EINVAL;
> +		return false;

Good catch, but I think returning true here is more appropriate and keeps the existing logic.

Regards,
Christian.

>  
>  	ret = dma_fence_signal(ef);
>  	dma_fence_put(ef);

