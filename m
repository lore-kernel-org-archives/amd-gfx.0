Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28FCC52D71
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 09:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8251610E6A0;
	Thu,  8 Aug 2024 09:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZtZxBeER";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB83B10E6A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 09:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq8/g2BvmhkhyXN9Jq84oa5TUuuQZAy0J/UNgKYoXv+mBGTrRf65Yz7e6DxYB/SKgeCXLtzNgnQWFYjhLoQ/NPDEVzB3oy1FC8KCrh5ygsC6il6mS4gM83E+9oT3J4WhAPji8u1XVCAToOK6MiTOi6EJ16sTN1pE/DYQYFuj6yslliaX9JfAXtPZj/RyxHQDHi7k4yaXeY4/DLj/T2t8Ixp2rKYd81Pvk0mZur3bfTkeUxvPkvMPJql+r9TEY5rvPXHg+bqDo4Oq2gelPtkj0LjNzUpd+8gzl/7Mi1um7hjjMvj/mkoAaJmYOD+Z8PNITaR+XznNT1BH10f3PY1UHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYR1HY8Gx5XDLy3J7HUQWbxiCl9wV+d6yJB7OtZLVYw=;
 b=UD5PbI+TIXqOLX+AcWCoYD83Q06h+3/+TrWeDmnPY5gbQuqgUehlekt6eBOxgdR3l7FoUXXvIyeKMMdcbko/upPyHCNCJgwECesgqRkOfmnLE7eicQeu+8vIjhoibMQu46BqQYmHkllUlZTMtsEOgCbMpkJC81xYNfni7Co5NYR/e6IN04qSriP6qlPULXHBeWeuQvO3pOFMcFemoLXbdQhNGfNPvID/e1LTJe9hvSZRhDEmwSJyUtYs4A4hdZhTW71xNOm4h2ATkaRX0pbEBzWE6JIM0cI+yBiHrK44js/fXQTTxaqtg89WyiIYhTEQS4NFvPfpXvxcGaTKXGYr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYR1HY8Gx5XDLy3J7HUQWbxiCl9wV+d6yJB7OtZLVYw=;
 b=ZtZxBeERWJl+zul2F9nrhZoigKBgbdGrQ4b1Gw5Tly2DtL/lDMm2wlG7F8jlxKsjChJG72m0SSHVzzg79/ZYED8sfrxOLVC/CDpemHzV/s6pNJGJGrug9GqZ+6XuzyN+R+RferkjETnuY+zm66RaiI8GbcFq0Tq49E9uTeZr2hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 09:29:34 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%7]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 09:29:33 +0000
Message-ID: <d10d09a3-a684-4769-9fde-dc17aa32bcd8@amd.com>
Date: Thu, 8 Aug 2024 14:59:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
To: "Khatri, Sunil" <sukhatri@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
 <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
 <a35d84a7-3d8b-4ca3-9157-7d8d48a54b02@amd.com>
 <2ad50a00-b443-47c4-a9b4-04fbfdc67be9@amd.com>
 <e3dde88f-8362-4e80-9e48-c6fb99035861@amd.com>
 <f787a816-96fe-4799-ad7c-cde1bd7b3065@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <f787a816-96fe-4799-ad7c-cde1bd7b3065@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bdbee5-e5d4-49dc-de03-08dcb78c9d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUtPWjdTcjh2Y2YrbHRIVUcwT3V2TVdNeXQvNHpqalhBUHlxNFlXY0FhNmNo?=
 =?utf-8?B?bG15aW1NNTNYNG9OY1NYcEZKRTdQdktSckR3N2JVeUs3eWZoSUFXQmsydHJV?=
 =?utf-8?B?TktxWVJvUGlHVGUyM3BzNzdhdUFRK2NxU1FTNlgwUG1Wak51YXdJcURLK0Fr?=
 =?utf-8?B?VGQ0VFVIWXFCSzJmcCsrVmFtdGpmT21BN2gvRk90Y0ZDekxYWVRVNmdEL1Vo?=
 =?utf-8?B?SktoUFFDMmI1QUhRaUszbE1NVHFLTDNidzdNWHYyaXRERU1zeS9IU0JUZ2Fj?=
 =?utf-8?B?cVVJYVp4T1Nnam53U2R4VTU5MmgxWVA3NXdxckpMY1lrRHc1TWRHNjVLRHVI?=
 =?utf-8?B?bStBZ2U2V2k2emg1ckJabldhV0JKWm0yVnFjWUJnSXRwWUE0L3IyaHJmTGRk?=
 =?utf-8?B?MEtkeTNoaUl6RFVNcUZVRTRNMDNZbXdsN3hvc2tYOG5kU2tlOUZZWnZTblZ0?=
 =?utf-8?B?Mk4yc05nMFNHbnhTVk5WR2xEYkpDYWx0VHhkaVBwZFhnMDFWZzJ0cDRQcGIv?=
 =?utf-8?B?MFZKcElGY0lmOUJTYlZEdlZZUkNGbzArZzAyM2lodUxGQ0hLMkNWS2pkMkFu?=
 =?utf-8?B?RmRrajhuN3Vjd2NvcmNQcFBlL3lSY3dNcWVRQzBXYVg3VXVYdEJ0Q3U3eFJw?=
 =?utf-8?B?VTNLNnhZempPQTNSU2xwRnRBK0VXZndZSWFQekdYZzllRmp3Z2N0dEFoN3B2?=
 =?utf-8?B?a0ZtZTZVNG0rYTREUS9MNGtkM1JaRmIyM245Nks1Ym1mOW8xMWRweGw5WktK?=
 =?utf-8?B?WnZIQWVKOGpUVjQreUhIS0FtVzg5VThOQnliOGZ2YmllbGlGWVZtNHpPSUlx?=
 =?utf-8?B?aVNwSWxibjdZRmFteFRMY2lsbk5mQnFOMkRpR0JXTjN2b2FGVFVSeFhpMTlj?=
 =?utf-8?B?MUdUZUh2VjVEUy84dzFuY04vRmVqY1hEaUFsMWRYZk1zQ2FaVU85S1duajNY?=
 =?utf-8?B?eDV1WlgxM0xWeTc5QnZoeUtIbEV2azdWMkZiTFcrK0xMdm9aTGtWT0ltOFdO?=
 =?utf-8?B?TkRKOCt0TVhFakNtd21XdDdSSndVNmRRdzJJTkdPaXpvU1E2NVdCMzJBZWNR?=
 =?utf-8?B?VXRDMCtveS9HZDNOYm1aMk0yb0hFWG5IYy9xN1dQdVM4WmZFNFBZNEp3R3hC?=
 =?utf-8?B?Q2pNVmxVOSt6bDZlRHBWN1ZOSEIwL1cwNWhybGVlcHlDbzBDS0xCWlljdkNT?=
 =?utf-8?B?SUJhZWZKdUFrSUI3ZHNzRDhHL05kU1pCUTArMWpQaFJoYk5XcEVIYm0xU1gr?=
 =?utf-8?B?NEp0UjM0VGZDL2JqRk1MbEZoQ1JBSGV1Z0k2eG1CNENPQUlCSVRmM1NZVHRp?=
 =?utf-8?B?cG5YYmhXczR2czB2Z3FsNmYvVGQ2dFo2OENYU21Za2dUdVB2bWRWU3h6WnRU?=
 =?utf-8?B?RGl6VCtSM0FGWmJ0N0J4aWVVNGR3Wm11N0RHUENiQWdhbjJERncyNXI4dGdo?=
 =?utf-8?B?YWd6NmxrWEZuSWlFQmdLRmozdngzMmNROFFPemtKeXl4SmNmM0I4blJmV3Ba?=
 =?utf-8?B?L1FKNzljTXhZU3Zmc3gwWEd0Qjk4VExDOWZCamdtNm5McS9KeXV1WWE5eG42?=
 =?utf-8?B?MHRIM2VKeE9CWUxxaVRFaENMWnFTN2dnSEpzVUZHT3Ira1NFNFRzbGhldVg1?=
 =?utf-8?B?MnB1alUvZFhGWDNqdFNId015VDgvK3c2T2puK01FWng4UEMvejVBZFhJNDV2?=
 =?utf-8?B?L3RNOVVqZG9wQWExVjN6bmJQWThsVTBmaGpLdmxMUVVZNTVHOStRUnRXQkhT?=
 =?utf-8?B?TlRuNUwxT28yQ3pSZVBRZzFka3lpVTVLTDJhNHFjZ2M1a1VvRFFuYWU5KzNw?=
 =?utf-8?B?cnhMbUVXK2FxZXh6M2s3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNlaDJqU05Fd1NDVVVoQXZncGh5b1gxTnpyTTBpUGltTy9xQ25CTzFkd25h?=
 =?utf-8?B?MjIxcnBBNXdVanRUb0tLa2ZZZnd1ZWtkeVNHQUVNelVxUWRGaTlFQVlESXg2?=
 =?utf-8?B?bElsSlI2TUZaU0hHakFqaS90ZVM3VmZtVjd3ZytrWlpMdGlqYjl1MGFTQjlD?=
 =?utf-8?B?ZUJVdWs2STF3KzdYdDBFUlcvQ0EvTUxHNDNYcjVNZStJNzI2MzNsQUJ2ZUt2?=
 =?utf-8?B?OWp1Y3hkekVRZE9ZSENxb0VtVHZ2UG85cU5vbmNUaW5WSHZVOXgwL0xXbGxO?=
 =?utf-8?B?K2o2VGltRGpjZzFiSWtUbHl1YktSU2xlYUNTZEJOVWRuSVVVNUl0SU1oeEtQ?=
 =?utf-8?B?ZWtGY2JmQTRvMGhTektqRWtWYzY5UllJV21Ddm9wSWY5dUF3SzFpYVdzSmpD?=
 =?utf-8?B?eGJoRUJEYS9tV1g3c1R5RVBaQmFDbWNoUGlZYjZSdzhCZVkxM3FNSWRRQU9o?=
 =?utf-8?B?STV5RVdoN0V5ZUxVTlUrV0dxekxRWEg4cGo4OVU4YTFETXd6dWtrMk5RWElQ?=
 =?utf-8?B?Y2FGM0tFY3hPZGRCc1FldlJKS1Y0SjFMZTk3YVg2T1pjMG1aZWdrb1FLL0dz?=
 =?utf-8?B?N1U3NmJ5dTNOUVFoK0gza0NSRGdYdzlxMGd2SHUwajFxeHRSQzNyN2hMeTZL?=
 =?utf-8?B?amJSelJCMEw5S012QUlsL3JhQzVaaUZ0WWl4T09BelczblozN0o0bUNaaE1J?=
 =?utf-8?B?UFBodWZQWThwYXVaVWptN1RneFRvRE1nQjdyUmtjWHl0UWpEbDYvVjI0MzhB?=
 =?utf-8?B?b1UzTjRsaDBjbm0xUExZQ0tjVTZVMWZQVTVjSDBRZ1dqZitGbUFEb3FUaFl1?=
 =?utf-8?B?QkN0VTJGaU9RZWY1YzRteEFWK3U1T3EwWERQQ2NZRFc2UnBBTDVYb3FLdzlh?=
 =?utf-8?B?MGZ2RjI4NEVZUGwycjl0M0VrNkJ5N2prYmRFbndCMXNVbzQvY0Z0QllNdFlY?=
 =?utf-8?B?cGt2aTJyVXh3VHpxeitPQmpPMlZlb3VtSk8zZzNNVEw5dDM4TUZuZ3lhWTBP?=
 =?utf-8?B?aGRYd3lRQnNDc3ZSVDZoQjhxcHpFa05ubFFKV3JLQ2xzRjlVa0lZQWJVZDZx?=
 =?utf-8?B?NmV4cUVVdlVodFF5TmNrYWRnaCtMWFJzdUFNODBIamJQVnRTeUQvc0lhWmh4?=
 =?utf-8?B?MUZPVEI3bGhNY0pkczk1UGxsKzQ1aUZQTzlNbGNJWGVkcHArb3E1Ris1ZG13?=
 =?utf-8?B?dHJSSDZCa0VHSjU2NUZzTlRjckxJRURyS3BnZlB4Z0JEU0hWci9aT3B2L0J4?=
 =?utf-8?B?RFB0NjIzOEFqTFkzbDMvSnByYUc4ZHZGY3Z6Z1VnTmt5eGd3bm9PNmx4b2pN?=
 =?utf-8?B?NVByRkZBckIrWFNYa283WnhqNnllS1pFRUFybW9pZEVPdDA5WURMbld4blBZ?=
 =?utf-8?B?R0xjRHJKb0hMWDNNY2xSQUJSUnlpdnorYkxiL3liLzUxK2IvVTZGUDFXOEoy?=
 =?utf-8?B?THRWMXJRaEN3VDEwSkhlc0pFbWxxTUh2WlhnOFhjMit3NHcrY2lGa21yRFFE?=
 =?utf-8?B?OU9nUUdPQnlqM0k1YjJFOWxueFc3RU1kL1o4TzU2eFhYZ09iLzk0cDcxaTQy?=
 =?utf-8?B?MHV6NkxMYjhxN3RNK09JVHRoaU44bWFmQjliUU5RQnhqWVZVQ1NnL3liWjJU?=
 =?utf-8?B?S3l0Yk0vVVVBQWFRd1A4R0JKVDJIaTVkZVpObkxZZEFsRE5ieWRFUGgxTkg1?=
 =?utf-8?B?L0dFYmMvYlZGMlNsR1BVVHJWMUs2c1ZFZUsvZTRUMGN3cGlNSHVEb05MaTZV?=
 =?utf-8?B?VW95ZHZ2ZUx2dDd2TVNIalNYaVU0THZWd0hqT1REbnRlVEFyRnVUZUtlTDY0?=
 =?utf-8?B?TGpEWEplS2wxaEU4QzU4bU5jc1pqSHBVMU53cy9PZ1k4ODRyZ3lOUWxWb1VB?=
 =?utf-8?B?Sm9jWGt4aWVURUJKMWVDT0Nsc05Oa21lb3dmZmJsTFdDYStML0RoWUJka3Jm?=
 =?utf-8?B?ZDhPUWRyZ0Q0Rk1tQVRXM0dMcWNrSGlmYlhoSGM3T2EvTEdwU2g3TlZQVUQz?=
 =?utf-8?B?bXZkM2hja2ZOOWgvSnljRC90RmFZbDF1SG5kTkZSN0NLY0JCblF3TDEyYWRD?=
 =?utf-8?B?bWNPT29XK0dtN0UwakpyQjJ1MkFQM2NWNm9ENEUzTWppOUFWdVlnRGtXTEx4?=
 =?utf-8?Q?XTW3uhkslQxJGV/AFAXyAEf65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bdbee5-e5d4-49dc-de03-08dcb78c9d00
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 09:29:33.9104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH89MwCNCbDn78xpMfCX4G2Xdi6Og0g7gW8KVKCxzidcP3IjjdRSlp3b+Cs6l0WuAP+gRAAWFOBBaveCFW0rIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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


if adev->vcn.cur_state == AMD_PG_STATE_UNGATE then vcn is powered on and 
holding vcn.vcn_pg_lock to access it is safe.

And cancelling vcn.idle_work must be the first thing to do, else you can 
run into a vcn power off in the middle of register dump which you want 
to avoid i think.

This is safer check than accessing registers to find out if powered on 
which is asynchronous w.r.t job handling path. I am not aware of all the 
possible states during which ip_dump can be triggered, so ignore if 
above isn't a possible scenario.


Regards,

Sathish

On 8/8/2024 12:59 PM, Khatri, Sunil wrote:
>
> On 8/8/2024 12:44 PM, Lazar, Lijo wrote:
>>
>> On 8/8/2024 12:36 PM, Khatri, Sunil wrote:
>>> On 8/8/2024 11:20 AM, Lazar, Lijo wrote:
>>>> On 8/7/2024 2:58 AM, Alex Deucher wrote:
>>>>> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <sunil.khatri@amd.com>
>>>>> wrote:
>>>>>> Add support of vcn ip dump in the devcoredump
>>>>>> for vcn_v4_0_3.
>>>>>>
>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170
>>>>>> +++++++++++++++++++++++-
>>>>>>    1 file changed, 169 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> index 9bae95538b62..dd3baccb2904 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>>> @@ -45,6 +45,132 @@
>>>>>>    #define VCN_VID_SOC_ADDRESS_2_0 0x1fb00
>>>>>>    #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>>>>>>
>>>>>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, 
>>>>>> regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0,
>>>>>> regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
>>>>>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
>>>>>> +};
>>>>>> +
>>>>>>    #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>>>>>                   (offset & 0x1FFFF)
>>>>>>
>>>>>> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>>>>           struct amdgpu_device *adev = (struct amdgpu_device 
>>>>>> *)handle;
>>>>>>           struct amdgpu_ring *ring;
>>>>>>           int i, r, vcn_inst;
>>>>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>>>>> +       uint32_t *ptr;
>>>>>>
>>>>>>           r = amdgpu_vcn_sw_init(adev);
>>>>>>           if (r)
>>>>>> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>>>>>                   }
>>>>>>           }
>>>>>>
>>>>>> +       /* Allocate memory for VCN IP Dump buffer */
>>>>>> +       ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count,
>>>>>> sizeof(uint32_t), GFP_KERNEL);
>>>>>> +       if (ptr == NULL) {
>>>>>> +               DRM_ERROR("Failed to allocate memory for VCN IP
>>>>>> Dump\n");
>>>>>> +               adev->vcn.ip_dump = NULL;
>>>>>> +       } else {
>>>>>> +               adev->vcn.ip_dump = ptr;
>>>>>> +       }
>>>>>> +
>>>>>>           return 0;
>>>>>>    }
>>>>>>
>>>>>> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>>>>>>
>>>>>>           r = amdgpu_vcn_sw_fini(adev);
>>>>>>
>>>>>> +       kfree(adev->vcn.ip_dump);
>>>>>> +
>>>>>>           return r;
>>>>>>    }
>>>>>>
>>>>>> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct
>>>>>> amdgpu_device *adev)
>>>>>>           adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>>>>    }
>>>>>>
>>>>>> +static void vcn_v4_0_3_dump_ip_state(void *handle)
>>>>>> +{
>>>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>> +       int i, j;
>>>>>> +       bool is_powered;
>>>>>> +       uint32_t inst_off;
>>>>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>>>>>> +
>>>>>> +       if (!adev->vcn.ip_dump)
>>>>>> +               return;
>>>>>> +
>>>>>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>>>>> +               if (adev->vcn.harvest_config & (1 << i))
>>>>>> +                       continue;
>>>>>> +
>>>>>> +               inst_off = i * reg_count;
>>>>>> +               /* mmUVD_POWER_STATUS is always readable and is
>>>>>> first element of the array */
>>>>>> +               adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i,
>>>>>> regUVD_POWER_STATUS);
>>>>> I think you need to use the GET_INST() macro to properly handle
>>>>> this.  E.g.,
>>>>> vcn_inst = GET_INST(VCN, i);
>>>>>
>>>>> Alex
>>>>>
>>>>>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>>>>>> +
>>>>>> UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>>>>>> +
>>>>>> +               if (is_powered)
>>>>>> +                       for (j = 1; j < reg_count; j++)
>>>>>> + adev->vcn.ip_dump[inst_off + j] =
>>>>>> +
>>>>>> RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>>>>>> +
>>>>>> vcn_reg_list_4_0_3[j], i));
>>>> VCN 4.0.3 supports DPG. As far as I understand, most of these 
>>>> registers
>>>> are accessed indirectly in DPG mode through indirect SRAM.
>>>>
>>>> Checking UVD power status alone may not be sufficient for direct 
>>>> access.
>>> i am following what windows is following and most of the registers are
>>> directly access but i agree some might not be.
>> Whether Windows logic works is the first question other than the
>> secondary question of value in logging some of those registers.
> True. Cant say but the bare minimum we could do for a starting point 
> was the intent. Dumping VCN registers is a challenge due to its 
> dynamic power gating controlled by firmware.
> based on VCN fw guys probability is in case of VCN hung we might be in 
> power up state to read some of the status registers if not all.
>>
>>    We are assuming in case
>>> of a VCN hang it should be in good power state and we should be able to
>>> read most of the registers.
>> 'is_powered ' - It's quite obvious that there is no assumption like that
>> :). Secondly, when there are multiple instances where only one VCN
>> instance got hung, and others may not be - this assumption won't hold 
>> good.
>
> The principal is we are dumping all the IP's irrespective of who 
> caused the hang so no matter what instance causes hang the registers 
> are dumped for all. The vcn hang information is captured in the kernel 
> logs
>
> that can be used along with it. Also is_powered is per instance and if 
> its powered off we arent going to read the register at all.
>
> Based on the experiments i did in case of hang caused by gfx i found 
> vcn to be powered off as there isnt any work load on VCN to keep it 
> up. We will improvise on the functionality as we start seeing issues.
>
>> Thanks,
>> Lijo
>>
>>> Based on further feedback will do the
>>> needful but right now the point where we are dumping the registers we
>>> could not make any change in power state.
>>>
>>> Regards
>>> Sunil khatri
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>>    static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>>>>>           .name = "vcn_v4_0_3",
>>>>>>           .early_init = vcn_v4_0_3_early_init,
>>>>>> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs
>>>>>> vcn_v4_0_3_ip_funcs = {
>>>>>>           .post_soft_reset = NULL,
>>>>>>           .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>>>>>           .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>>>>>> -       .dump_ip_state = NULL,
>>>>>> +       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>>>>>>           .print_ip_state = NULL,
>>>>>>    };
>>>>>>
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
