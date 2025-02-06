Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0016CC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 22:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD4810E993;
	Thu,  6 Feb 2025 22:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LCaT1Zkl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2E110E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 21:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnssmXfZ5OiRT/ZBE1nPwAtpcZvTH2CUdIxJAUERBzfP14baVR6f+OXqRAgBYGOjWGS3v8dtUFyT7ygLsYFfBcyAlWH4RWmf4sYxXmieyjL480JUhhg7A7gGZhJPOI3m3Pt08XyR8Yfvsf5ByVYKn2DbW0geeZhNlRPlO6UVt0p4YvpddnVK1n0IXZr8qWYSjmD8vCOP5EZeYGWA4a3lITpB0VvnUuHON/tOm5iJpZK98h8t5KBsdgdt32n+wjjXWp2W+RC3rfBxWAcm3KJnCA8oXz6SOU2n1aPQzrZNStGCXHKA732mmA5D2Q4/5iXhB9udF6eL1tr1spGD+jV14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eG0/3f6S4sd/ooRpQsCs8PdTz4hWJSGlgt+Ocai87RU=;
 b=XfOdDVaR6fLIVQz3Iv0A1rgOTKWU90oqFB1zkLlGQIqnUYGRSdXMtaK+bxbMYPNVuDEx7rbQtUX5iP8h59uGrutkZTDXTpWtywNDo4Xxm/PR1MCU/5Pm5MX8MyR1ez7TYM6n7i+umh5l2b54vDRVIrlhfrGju4axGwih37p2Kiw6IISOH4EPkqf2oePcbQnu/io10gWiuKRNnIw5UK/AheeclnUxzQwRhmJEmFBO+V8DANTvxhDqWn+YKvaE/v7DS3A6L+QDual1gMavT2w5ORWBQsrvE1HTNeJM6tNA4I3inJ1i/BxiNCQOUvwe1GUI3MwR3a/4dfl8V5WkQqBNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eG0/3f6S4sd/ooRpQsCs8PdTz4hWJSGlgt+Ocai87RU=;
 b=LCaT1ZklyNOomTxSoIJLyTToUp8j4Na4bROOmw+FAe9viwraPmwLrStQm7rmECmMhxWEWC4mEq57UVOy1i+tNoCR+oPd4PUJmwQGT91mPIIwB+Ee4QG6ZUlXjgmqRmRmvJ8YeqhurjJ+ACf5Ldb5J/WTvV17vZqzOVTRxPCuwVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 6 Feb 2025 21:57:08 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 21:57:08 +0000
Content-Type: multipart/alternative;
 boundary="------------ti0iw91RVXwXxQNJIC5UButi"
Message-ID: <822d7a16-1220-49ea-80bf-36217d052f4d@amd.com>
Date: Thu, 6 Feb 2025 15:57:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Don't modify grace_period in helper
 function
To: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
 <20250114195251.42661-2-Elena.Sakhnovitch@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250114195251.42661-2-Elena.Sakhnovitch@amd.com>
X-ClientProxiedBy: SN7PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:806:126::25) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 623f1e3e-31cd-4aa0-7ea3-08dd46f93375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGZaSXpzQW9aNFpiTENKMm5aQ1ZRQmQvMy9qMGRtOHRvbENPWDFFdjNqY3dn?=
 =?utf-8?B?YzBRMlhPaGh3UjdYWmhrVk9yZHJHZDlsWGxTZWd3TlNZcjByRFZOMTNaTU1i?=
 =?utf-8?B?TEpLaS8xM2R2MTM3RUVxbWEvcWNpNHJhN3BRL3p0OVBKeENSaUluQjREOFpu?=
 =?utf-8?B?N1cyR0RydWtpbENFOGtZRmxDa0xzZmhHWUh4UkNqVytxbzlOM3FMYVkzUnV5?=
 =?utf-8?B?WUFnZVpqb2R6OWd6Y1VOelBaa05pR0xqSWdTbmNZWG8xZHhJZklCamxpWk83?=
 =?utf-8?B?cm1uVmdONUhuNEpSSUV4NWhDRFhtNnE4Z2lqNkRSc1NXckpQSndtSlNiRm4z?=
 =?utf-8?B?SDYxS3VkTDNVNnUyNm0wdXhNcTJuVVQxV3NicmpnQVB4YkpqRjdCOHpvSnpF?=
 =?utf-8?B?dm5YdVJlenJweEt4YUJoNHQ3Wlp1M2V6UlVobHh6S09pRTVzZ1U3by9GYXN5?=
 =?utf-8?B?ZHI2WnBmWXR5Q0szR0o2eGpMN0VnZlNWR2xFOVZINm9jd3FzRDNMd3UzN2Vt?=
 =?utf-8?B?VVFKUWJ0Rld4Y2JadVFBSk5XOTF6NURXWVBpLzVOM2VTYWJKbFA2MU83dGZx?=
 =?utf-8?B?S0xDQWVBRkhBejNxcG9VV3VNWmUrajA5VEg0aUsrUStqOUJzWkhYMnRLcHkr?=
 =?utf-8?B?U0dWZElYWVRqYmhwV1g4eGdFTEprck9UVVNKMjhMWllCK09RdlhETDlYVGVj?=
 =?utf-8?B?MW8wQkR2RzlOMGVlWW9CemlZaldBakxXbFdhQ1pLazFkb1FLWitxb1h6ZEJL?=
 =?utf-8?B?UkpwNndieVdCUjEyeW5CeEp3bGdJV016YW05VEhEUjZkazNVbVk0eStidDcv?=
 =?utf-8?B?R09UaFNMdXpvcDZrUzFZZWNJNlRZWitjcWVvd2JWYlR5bzZFenpPb1NReEhk?=
 =?utf-8?B?M3NzNmVZSlNETXp6a0tXc0hFVS9ESzE5OTgvV0R5SmxFSDJUUTExdzV6dEs4?=
 =?utf-8?B?Umo5TnJ1dmNmWEN5czNWWlQ3V3kvRXM0OTJqNmF2S1g4T0VockdTQnBSRVRJ?=
 =?utf-8?B?TUYxZGxKOVJyeDJjUVRQTS8rV1NRZnczb0VTTTdxN2o0M3JueWV2UysxUC9r?=
 =?utf-8?B?ZU9JTnpBalNMY1dlbnlJNEFhV1ZzS0tjUDN6bFhzY0JvWVRQUHNabmV1WHRv?=
 =?utf-8?B?aTFmaDd5elhlTDdNbWNSdERKeUN5MGM3R0djMFhjTEFScWJXSU1TWXoyZjNt?=
 =?utf-8?B?ZTdKNlB3aUREcVNuRXA4QmhENDYyRmVweklEVmc3SXJtZVpVMHZhaG5rOE9F?=
 =?utf-8?B?SGtFbUcreHpQeGpSdkM4N2JOMVV6MkZMOEQxVVIvQzRXTmNEWTNLV0pPbTJL?=
 =?utf-8?B?cWdrWVRtRitVOGI0ZUVwcVhES2lYWVpFb2NGSVhkS2tqTU9sZlNLaWlhTUhL?=
 =?utf-8?B?RGg4aTVHR3hjbnduc1BvVkJ1dm55bzhieGpuekhONG81bTJ3dHF4UXRhOEc2?=
 =?utf-8?B?a0JLbEZ2ZHpqaW8vUjBsYS92MlN2aHNrUEI5Rkh2a3BYU29oZHZqZG5vNjMw?=
 =?utf-8?B?czVST3JvVWF1dEFQeEVDdWkraXo5QS9Bajloei9FaStkdjlXa3VSZ0o5UmFs?=
 =?utf-8?B?NFhNS1pseFRTRzZJV1JPL3JqZjAyTkVJSlZ6STRZS2d3ZFZ0ZnNFRUV1R0ZB?=
 =?utf-8?B?cUlRMU90dXJSMXpkWUljb1ZrS0phNU8yOGR3bEN4VHR6ZlRNVEtjalA2S0M1?=
 =?utf-8?B?K0hrZmZ4YUhyYVUwNys5cVFQT01YK0pxSFBHNTJzT25XVm1DeHJQMW8rbHBJ?=
 =?utf-8?B?QkUrR2ZPSFIxSFJNRVU3a0FLM1ZNNHl6V2JhR2tlSDR0U2I3L0tnam9KbGZO?=
 =?utf-8?B?ZmpnU3BtK05SRzNBS3pZbjVQbmlHK05OYUE5ZmhONWZlc3lTYlNwRlpzWFky?=
 =?utf-8?Q?6Taa5GgDCIgS8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdGcS9mcWZtb1dnSUxlelRZOVRDNkhHYnovUTVaMTJzQTB1RmxyMGlOeUtm?=
 =?utf-8?B?aW9GdTU3aEZzY21EZHBnMVoxUWk2a2hTc2RTdi9BUjNxbFBTWEdFeUFwNmlD?=
 =?utf-8?B?ZmNpaS8zTXltVUFiZE5jVmdkR0hLcjkzdVpucXpSK3pCWUc1eTYrd3Zna0ZB?=
 =?utf-8?B?V1RsYTgwcERYdjRLVUs5cHdJM1V6aFpjYUpCY0RnY1ZrZjV5ZWhXWHBMZmgy?=
 =?utf-8?B?VnFzRW1aajc2bkc2cW1CTCt5b2xIYktuUDJ0NVc2R0F3MTRLYWZJaVVEM1ZI?=
 =?utf-8?B?cTluVXZ5cjBGSFBILys2VUhIc1lHOUIwcldmRmE3V1pEVThvNWpNdC8vbFhU?=
 =?utf-8?B?dVdCdndicXNCVjR0VHBBUWFPa1lIc2VDUjZlOWE3MjRZbGtxVTJmK01lSVAr?=
 =?utf-8?B?ZklPc0Z5aTBTOU04UHJ3c2VmS1BDMXdUT09QeC8yejZUcXoxRlREaHR4MXM2?=
 =?utf-8?B?dExOQldLWlhBblZDYWhIdXFtb1ZldHZMN1JuVURlWnlnc3V6YzFURHdsWW4r?=
 =?utf-8?B?SC9Td1JJMTdKOS9SZUkySWpzMXhVaGZhZVhIVGpsVExWY0dMT05ZTWorV0JC?=
 =?utf-8?B?Ukl2VnRrNG96bVNBVms2S3RTTUU3ZFZmMmc0VnUwNVpkbFc5YVZJR1JiS3JH?=
 =?utf-8?B?RHZ6VWlSNnJKaGhjQXE2Q2NvSzdPVk9BTkMrdVo5TmxHaDNSQ0RXUFdmRUFP?=
 =?utf-8?B?L1c1SkNYbXRaRUVXMzlMVXlMQU01VU01ZEhDMUk5dXd5OWtTOCs5ZTJNM3Vl?=
 =?utf-8?B?MnNkZHBEeFppUnFwVHVIZXdqSkRsM0JQTmwyYnhFblZYK2V2VTRUbW5mNlp0?=
 =?utf-8?B?YjJ3dkxmeVlybGdoMlBkUGFOZTVQaEZMdWd0RC9vOFArV1J5UUh0NU5TL3Fq?=
 =?utf-8?B?aEVzYmNkUXdWSk1xYU1NYllaRUtINmdiLy9EdW8rM280MDkxcDM3UENwbVkz?=
 =?utf-8?B?Q0dUa2ZvVmlvWnB1cnZFZDYyaUtGaW9qWW92U1JraWNIUENIN0NsNzlMQVoy?=
 =?utf-8?B?dG05Z2Z3ZlpGN0Y2ZnJqM254blRrTWFBejdQejlRTVNiTDVGRWpxRUJmN0ZC?=
 =?utf-8?B?aElmSFNXWm1FT3RHR0RSZVVQZGV5WEp3K0Uza1M4RmRGeVp4S3FtaHB1a1ZT?=
 =?utf-8?B?S2hDUElrbjlaWFRjNTRHeW9ZMzkrOVNxREtZT243ZXRJNm9LSUltR2ExL25l?=
 =?utf-8?B?MlU3Y1VSNEhNSkp4MlhHMCtNczhaaDhzT0RLdndFZmVOZDBXRkV1ai85cnN1?=
 =?utf-8?B?dnN5NHlMZ0R6MEp1OWVVLzA4WlNveXE3d0NCUzBBS0hBa3VmaGlkeGk2ajRB?=
 =?utf-8?B?c3dQRVdITlFmQ1EvSmFTVnlmUkQyQlY1eldjUlBYaGExVGx3Y3F4MGJTQnBJ?=
 =?utf-8?B?Z3RHRjd1VFc0WFVqK1ZJZVN1VmtHbDA2RUJneVEwYU5YbnF4WC9PYXgxblQ0?=
 =?utf-8?B?a3BRTERxWG9BWmJ2TlVzTFZvSk50RU90aFV1U2ozbDl0UlBSNXYxNXJXdERU?=
 =?utf-8?B?ZW5lQU0zMWVMUXJiK3ZwUUdMZUk1L051UDhSV3RzVDB5dmVTYnNQRUdnWUU3?=
 =?utf-8?B?aVk3amVOMDlhNVFZMmsvM1VoZFJ2MHdIdnRiZHZ3MjRQSGtWRzRqZTAyS25R?=
 =?utf-8?B?QmVqU2pHS2NwdUZJTmJ2NHlweW44VDdoektObUFNTXpyZUpsVHM2TDJ0WUky?=
 =?utf-8?B?ZUdvOThxWjVpN2xiSW5JVVcyNExHS2RpdlkyLytoUnpMcTVEOGpuYnhlRk5v?=
 =?utf-8?B?cXYrbk5ST3hxZ002THBFdE92YXJ0NmNwNm1DV3VsRHQrWEd3OHJWRDNqYmMv?=
 =?utf-8?B?cVgvSXVLWVZ1VHhUZVlqNnpNbWtrbVdWNFBnTC90TmowL3M0Vk9GWEdCQUVr?=
 =?utf-8?B?ZTgvU1JndndsdDRNczRYK0UzcDJVWG5VaEpsenV6K3ZqRW5Kd3pxd1gzaTRa?=
 =?utf-8?B?ekt3clZmanRDcTQzVjIzRmZHSU4vNXJ3bHp2NUlJSVRXUkJYM0NVTngyRDVQ?=
 =?utf-8?B?d1pSODJwN09yS3B0WmYxVHRBaTZZUXVYRGJ5aUwrNngrbm82UlI0bEx5QkJD?=
 =?utf-8?B?MnlZQ0lYL3dXbDUwUHNFWnBLbHA5UTRtU2ZKQ1BlcW9JSHJCdTZrQkdwK01F?=
 =?utf-8?Q?BrQg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623f1e3e-31cd-4aa0-7ea3-08dd46f93375
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:57:08.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m6khGTaT/XPru0v9Rjx0k9DxyBxspcH8eVtwBfKK8IGfZprirOyRBaoS4oGFZfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

--------------ti0iw91RVXwXxQNJIC5UButi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/14/2025 1:52 PM, Elena Sakhnovitch wrote:
> From: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>
> build_grace_period_packet_info is asic helper function that fetches the
> correct format. It is the responsibility of the caller to validate the
> value.
but what is hurt to valid it at asic function? each asic may has its own 
requirement on grace_period, so has its own checking.
>
> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> Signed-off-by: Elena Sakhnovitch<Elena.Sakhnovitch@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 18 ++++++------------
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 17 ++++++-----------
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 12 ++++++++++++
>   3 files changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 62176d607bef..8e72dcff8867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1029,18 +1029,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>   {
>   	*reg_data = wait_times;
>   
> -	/*
> -	 * The CP cannont handle a 0 grace period input and will result in
> -	 * an infinite grace period being set so set to 1 to prevent this.
> -	 */
> -	if (grace_period == 0)
> -		grace_period = 1;
> -
> -	*reg_data = REG_SET_FIELD(*reg_data,
> -			CP_IQ_WAIT_TIME2,
> -			SCH_WAVE,
> -			grace_period);
> -
> +	if (grace_period) {
> +		*reg_data = REG_SET_FIELD(*reg_data,
> +				CP_IQ_WAIT_TIME2,
> +				SCH_WAVE,
> +				grace_period);
> +	}
>   	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 441568163e20..04c86a229a23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1085,17 +1085,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>   {
>   	*reg_data = wait_times;
>   
> -	/*
> -	 * The CP cannot handle a 0 grace period input and will result in
> -	 * an infinite grace period being set so set to 1 to prevent this.
> -	 */
> -	if (grace_period == 0)
> -		grace_period = 1;
> -
> -	*reg_data = REG_SET_FIELD(*reg_data,
> -			CP_IQ_WAIT_TIME2,
> -			SCH_WAVE,
> -			grace_period);
> +	if (grace_period) {
> +		*reg_data = REG_SET_FIELD(*reg_data,
> +				CP_IQ_WAIT_TIME2,
> +				SCH_WAVE,
> +				grace_period);
> +	}
>   
>   	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index fde212242129..adc7f7c78a18 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -306,6 +306,18 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
>   	uint32_t reg_offset = 0;
>   	uint32_t reg_data = 0;
>   
> +	/*
> +	 * The CP cannot handle a 0 grace period input and will result in
> +	 * an infinite grace period being set so set to 1 to prevent this.
> +	 */
> +	if (!grace_period) {
> +		pr_debug("Invalid grace_period. Setting default value 0x%x\n",
> +			 pm->dqm->wait_times);
> +		if (WARN_ON((pm->dqm->wait_times & CP_IQ_WAIT_TIME2__SCH_WAVE_MASK)
> +			== 0))
> +			return -EINVAL;

should set grace_period to 1 here?

Regards

Xiaogang

> +	}
> +
>   	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
>   		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
>   		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
--------------ti0iw91RVXwXxQNJIC5UButi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/14/2025 1:52 PM, Elena Sakhnovitch
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250114195251.42661-2-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>

build_grace_period_packet_info is asic helper function that fetches the
correct format. It is the responsibility of the caller to validate the
value.</pre>
    </blockquote>
    but what is hurt to valid it at asic function? each asic may has its
    own requirement on <span style="white-space: pre-wrap">grace_period, so has its own checking. </span>
    <blockquote type="cite" cite="mid:20250114195251.42661-2-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">

Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
Signed-off-by: Elena Sakhnovitch <a class="moz-txt-link-rfc2396E" href="mailto:Elena.Sakhnovitch@amd.com">&lt;Elena.Sakhnovitch@amd.com&gt;</a>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 18 ++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 17 ++++++-----------
 .../gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 12 ++++++++++++
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62176d607bef..8e72dcff8867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1029,18 +1029,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannont handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
-
+	if (grace_period) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				grace_period);
+	}
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 441568163e20..04c86a229a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1085,17 +1085,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannot handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (grace_period) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				grace_period);
+	}
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index fde212242129..adc7f7c78a18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -306,6 +306,18 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
 
+	/*
+	 * The CP cannot handle a 0 grace period input and will result in
+	 * an infinite grace period being set so set to 1 to prevent this.
+	 */
+	if (!grace_period) {
+		pr_debug(&quot;Invalid grace_period. Setting default value 0x%x\n&quot;,
+			 pm-&gt;dqm-&gt;wait_times);
+		if (WARN_ON((pm-&gt;dqm-&gt;wait_times &amp; CP_IQ_WAIT_TIME2__SCH_WAVE_MASK)
+			== 0))
+			return -EINVAL;</pre>
    </blockquote>
    <p>should set <span style="white-space: pre-wrap">grace_period</span>
      to 1 here?</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:20250114195251.42661-2-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	}
+
 	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
 		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
 		if (amdgpu_emu_mode == 0 &amp;&amp; dqm-&gt;dev-&gt;adev-&gt;gmc.is_app_apu &amp;&amp;
</pre>
    </blockquote>
  </body>
</html>

--------------ti0iw91RVXwXxQNJIC5UButi--
