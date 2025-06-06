Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B776C5B559
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 09:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5B310EA0B;
	Fri,  6 Jun 2025 09:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hn1j81Cj";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DC810EA0B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 09:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Re4KLI5Mge365px3zpLEAkRSUPck4KLQUIghuELOflNIqYgTsTpq1bfHq6BaZCllpnlVORV2npH4PH04z9Gux8wI9tniKxK2s0XunyiyV9zPAMJxu00qto76FSotkSIM52oTsgeir3eno/EKTSTILftnvtzX4yezhDZiRzE3wbhEzcbMzCBqR3kKTMzr0dWKDdM2mus/va846nO6pcrqBYo4HwVV9OX90FSzAQPFu/iSwPx4SxDyp/Bfj16YfFVzeIUapR1GdsBxMgIJVR2UudTIFJHXZfthwYExgbirPsutRZ9ZrDMCmSa9FPfy+lzOAyt8xx4WxGSoZm2zw3pCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/6mwMvniyLH3nev7OT/a5jRuYqgL9lSWztzWyVfRl0=;
 b=yzATQlCDsu6cg7w+rac8Cq+N6sFgW05OQxcQFSUWOTlx/xbZqZL48llcSRF2/Sp8C5GPUpIcJiI8ocIr5VGh2s2d4RQOLeeIwoOPOPa8qLS8pYBOnzN/3+yEQsAxisKaYJqran2eA5F/mEHzQeGqY+XTZ9OMkjm7INFB0fZI96dLkBYJKUZthscPyjRMFBvqfyMYlqcU+DbmhAXG+TJVZDsnYAHwBI/sBmFdMd4Yl05fGoHTDz49t6hpprLCtQcT8+Z8fyPoX10khWig4UVlDkq3J73QwpKS/TlXfHR2mIb6VDLdEoXsd4dFZZHQD6YphX7UCLjwM41Lnx/hIOf3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/6mwMvniyLH3nev7OT/a5jRuYqgL9lSWztzWyVfRl0=;
 b=hn1j81CjJkNBMVKQXOLHBA5ky1rBX31qXqV28MiJgi7KRoe96xwq/Z4MLRBXqtIIWY3cAO/ymYM7rhEtze6eOTUvbt2Xt+5yxIXxXL2wIUopfwtBoWqjDB2dBy1+Bfdd5Gdy+L9rsU0wyD0Umyr4pjd5bPb9dN1x/fEl0hB7r2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 09:39:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 09:39:55 +0000
Message-ID: <40e3ba3a-73a3-4a4c-ad2a-b1463fe9776c@amd.com>
Date: Fri, 6 Jun 2025 11:39:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
To: "Liang, Prike" <Prike.Liang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-9-Prike.Liang@amd.com>
 <CADnq5_M1nRDbPXRkbtdTbjgFBNRwJ_jHgCUp2+rhZcfrYogaAA@mail.gmail.com>
 <DS7PR12MB6005C42DAA5C3BBEB72B2290FB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005C42DAA5C3BBEB72B2290FB6EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:335::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9980d63e-c994-466a-2841-08dda4de1815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUp6MXJ3cUtTZFpOOXkva1RTam81N1dDbEtnWDJFZ3ExNEVjN2xoL2c5bk9H?=
 =?utf-8?B?clFPY0dJMEhVM3NsRUtvaXB0VzZleVRZNm04VkplcG85NUtTMUhDQStaWlg2?=
 =?utf-8?B?cWdBNE4rUWl0OVVRY2pHd2M0Q2VWbVBlYWl6MkFuMGZUQkpkWDdvdGVyekNK?=
 =?utf-8?B?aVdtNmlSR2psVDNxejI1dFBPeWxySWV6c2Q3UnY2dXNsdG1TOTEwTGpJNHRP?=
 =?utf-8?B?Q1V5N2J0dmwvY1BmejRuc0s4Ri9PZFphUDB0ZGJBK1kyMnBZcXpQbjFKdXNV?=
 =?utf-8?B?djRZUk1PWDM0MnZkMkVMbzUrT0lBVklHYUQrK0N5M0FncC9zSGlUU0pMZXRU?=
 =?utf-8?B?ek9BamgrZGFFRGh2S3B0bUpDOGpVaWJNbGNkc05odGprMkc1R2d1dVVjZzJs?=
 =?utf-8?B?bVF4T2V1ZllnTkV1N0Z2eEdHV3dpSVhQOVVWaTlnT1dxeWRiT0E0WjlmTWNX?=
 =?utf-8?B?RllHTEZSdCsrQzJOK3E1ZUN0QXFaVzBZbGpLUytLdmdlWU9VcGRDU2VtNEIy?=
 =?utf-8?B?R0hvNWhtMzZXZUFvei9RWDdFYzZCMGpvRCtoRG5YRnFDc1dWNXoyWnFFRjRW?=
 =?utf-8?B?N2hocnRiS2h2dld1dk93bE02WGtKR3gxVXJnQkdPbWd5SlYwbzZ2Ly80b09l?=
 =?utf-8?B?SUNTU2Jxak4wa0x3eFdScDhTQU0yV0lmUXVjSDIzMGpGbUUzYzRsU0tzVUk4?=
 =?utf-8?B?TWdOWDZtQ1N1a2dKVUtnS3dSanVEQXM5Uy8zM3kzaG94RUU2U0gvWEZzV0p1?=
 =?utf-8?B?QkFPdEozcDdkT1NOOFdHVklBdFJNUzgzYVdyUW1tOFdXK1dqVm5hdnJZejZq?=
 =?utf-8?B?U3oyN2FFQUsyUEw2eEJhU3ZNcFlUem1jemM4RUFRSzlIbFNKWVJyUkIrRWF2?=
 =?utf-8?B?UjlncFlNbUN2S0dQY2N4NitLaHI0cm53RDBMTTFSZlRvVWs0N2lVZWpWYWdM?=
 =?utf-8?B?eDN0V0Z6VTJ6R0E5R0ZHTitRU1hDWWt4aHduVnJxY3BpK211MStVOTBXc0FQ?=
 =?utf-8?B?UGtTYlFUU05qU015ejV6b2ltZEdYckhpNzdNMWpiYU5QOTB6WnRaZCtsUmwv?=
 =?utf-8?B?cGxiTzdOaExra1VQazdRV000aTNrTHNDUGg5dkM5QWhrRGRDUngwcEdsU2lR?=
 =?utf-8?B?UEQ1dkV1QW1KTnhhaXJtOGs5N2pzTVZmU2Q0WTJ2dkFhbHowNjhOcmZpcFRK?=
 =?utf-8?B?UWpoT2dHT2VleFhucnVyem5lU3QvU0JZQVlDcDVxNDVLQVF5QkNHWVlzanhz?=
 =?utf-8?B?TmI4RURPTmovUVBlZ05OZ1QrMGwwc0NESTlwUkllWFRFZUV0eU1GK0JYRjhj?=
 =?utf-8?B?TVBwUi9Bb1plTlFEd0wvcHhBR3VnanNVYXdGblZOTVgrYURrWFNkdHFFelVW?=
 =?utf-8?B?NVlmMFhZZVFuZUIwMnhGT01pQklqV2NMeFZwS1hiYkZsLzhkUXhpYWpQZ0wv?=
 =?utf-8?B?cW5Ed0k4dkRpSTFRN09ueGZib2I1K1NOQ3lZcHpPZ2d1NHdvbHVuVC9wSmky?=
 =?utf-8?B?Y3NaM0swNy9KTDJYWmtrSDF1OEpGL2JFTG8xeHhPdHd4STBHeWl3R0pOSDdF?=
 =?utf-8?B?MnBya2U0MWdQczZFL3JJdzdwVGlBbVc0SW82TTY2R3UrVTQweUpPb1lxQm54?=
 =?utf-8?B?MStzTjdudU9wRVIzb2pvZkJJRUNVL3hnRko2bG5ibDVzTFpLelQxM1FOOEtE?=
 =?utf-8?B?QVdSSXA4c3FpWTc1KzZkbis2MDhQYUoyYkVFQlZoZjF1SVlWN1BQRGpIYnh2?=
 =?utf-8?B?OHpJZ3hXM0NjLzlkUWo1NjNTL1NzeE9RZFc4Mk1OMjUyRU1nK2xSVDZRZkdL?=
 =?utf-8?B?VWlSYmpWb1YyR1VJL2dqcU00WVVZeWh2bVRrV1VNZTZoZTFocFVIMHJ2T3VE?=
 =?utf-8?B?dlNhTmRtODRxSVlweVlGbENNVXcyUnBRR2JBYWw5aFBEVVhtRTFzcVJoYUww?=
 =?utf-8?Q?PTUy7PyGG30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2w2QUlYREoxZ2wzY1ExUXRGMXJWMElrNnZpNmM5MC9GdllyUFhJU3lxbitK?=
 =?utf-8?B?VWlleFJMcnBuVFNlYVVBWWVmNnVlQklJYm9MY1ZNRXNyano1OXpMQXphTzh4?=
 =?utf-8?B?dVpkZytWdVBqb0E5SHN5SVhxaGY0RmVUVEl5dFBGOEJjUzROOG0zK1pLMXBy?=
 =?utf-8?B?N2twNkF6bytqa2c3WG1jd2N4VklROXM2b3ZFVm1vMlo3dW5PcmNOaGtoNURv?=
 =?utf-8?B?QktqaEFxVnVKTmpYeHlsMCtXdnIrT1JQYU91OTdFU3ZQQ2FNOFNiSXhGa3JP?=
 =?utf-8?B?WEVQOCtxREEra1gzTkM1NjRWdE0vSytiSk5RaTFRS0pQRWZ3OXA4UXcwQ0pv?=
 =?utf-8?B?RWt4VXRKcDlhUThmd2RKVjV6Yk5UbVkxZnFsTjY4Z0VTNzZiSXBjdVdSRjY0?=
 =?utf-8?B?VTVVRTk0UG5rSWtSY0x1aEIwU0RmU09BTUZBZzVnaXlSaHFSRVhGOUN4eERO?=
 =?utf-8?B?c29NY2dtV08vSDJ6QmVGY3o0K3BFL2ZjU3Q0T3B2OVdaZDRDbFc3dFBlcTlW?=
 =?utf-8?B?TjBIcEFjcXNTWDFCTHk2N1lhUTEvbWR6WDIwNkF2Qm5MZWFYK05VNDIwNkdU?=
 =?utf-8?B?d0tnSDRITTROSGwwMGM1OU1iaGpDOXRCRk5mTjZlckJhLzhQeUM1b2hiekRy?=
 =?utf-8?B?eHJPOExZMnFEQmZZMldtdFRhMytyVXFtSG1ITzBISDR1TkVVNUsyYWJnOUt5?=
 =?utf-8?B?YlEvMDFyQUJQZEdvTzFUR1JTbnFhTzVyMHBta0RxMzlyc0NuVS9SczZDOVp3?=
 =?utf-8?B?YVpyVFVGUzVCRWU0OXZCOUdzL1pLaWFsckx0K1d4Sm1NcUcxcXdRSzM4MHJp?=
 =?utf-8?B?RjU4TUgrdzk4UjNnK3VTTWxiTmxmYWF3Y2VyZ2FxOEk3Znh0L25xSzdFZmhu?=
 =?utf-8?B?VUVOcFpEMXlpbWZVVHZmZXFXTjdGUXdKNVJDZkdRRysxQXlLVjQ4RVpDM1Bs?=
 =?utf-8?B?SHlnMlFJLzNITHl4VXVPa3RENGxXcUI1eGh1SHhTemN5Umw3OXIyRStNb1E3?=
 =?utf-8?B?ckFCNUpaWFVibzY4ZzB5NFZKMGZlZFdjYU55ek1OaHk5S1NxTjhFb3pWdDE4?=
 =?utf-8?B?OUI2ZDNGZE0rQlVHcU1OUXV3b0ZxbDZtVDkxSXBpd3psVFU5cy94SFBNWVBU?=
 =?utf-8?B?d1JEZTlTRHZ6cGVhRkVLTWlCZ1JtK0QyK2wxelc4Y0xrVWJTbnRpcS9UWWNL?=
 =?utf-8?B?TWUzS0l1Z2w2dSswcWFuelhRcU41RWczUUMvSExqbXJGZTJpNmpsbmV3MTFM?=
 =?utf-8?B?aEROMGswVlZncHBDa2swdkhjMW5DU1FXdlRxZSthMlRoZlF5TXdkcEZWWG9G?=
 =?utf-8?B?U28xZnFCdVZWNE8rSTBzdlBrNzA1UE9tYytLeXVramtxMUVDazY2dlpOb3Fu?=
 =?utf-8?B?dVJZS0gwb3AzdDI5bjJDRnRYUjU0cHFRdEkvN1ZSbE5ZdWVueFpLSEZEdE1J?=
 =?utf-8?B?UVEzVnJjOVpDWUFlWlplTDNLMzU4RkNqTk5VNTFPazNyVkpWNElEU0VvTHJ0?=
 =?utf-8?B?M0QvQndxYjU2V1FhZEJTdWxCbVJQVkpjZHpBQnd4dlVLbVNmTlUwTUtURnpW?=
 =?utf-8?B?TkxRT1FzVWw3Snh2WVF1MXlDc0o3aTVpMzBQMmZaSEx0aU5JTlYxRGFic0Za?=
 =?utf-8?B?c3E4RG1JUmZITkQzRnZrek5JeVF2aWZBSHk1SnViSXAxV3BVZlJUekgrRDdH?=
 =?utf-8?B?TzJIMXFhRll0TDdOelFtZk5SYlZyc0hoTlVkL2JHbTF1ZzhOTUlWU1RwSDkw?=
 =?utf-8?B?TVpwTGxQd3EwYnBiMmU5dEdNeHNJZ0tQeGNoTGtCL200OFROM0ErRGVBTUxF?=
 =?utf-8?B?OVQ2UzZKV3hCUDFSWFlnbXhuQ2EzclZmbEhxbk1tV3ZlTGREWHJCWjF1LzQz?=
 =?utf-8?B?ZkdhU3ZNVC9ETEZQb3docmZtNEkxemhsbytiWXBUU2ZYbzZEd3p5Z0ZBbjZ3?=
 =?utf-8?B?ck0zWmI1V1RyL3R6SjFZNTZ2Z09YRlMyeUZIbVVabXkvbEZuNUJTR1Vtb0lm?=
 =?utf-8?B?TGp2TitwQ3dOMFUzM3A2QjVoc3JKRjBPWWRpMHRzWU1ndzZqMGF5Vm1jSmFy?=
 =?utf-8?B?V05GdENMdENZdXVCanMvMFA3NTk4K1dEaWdLZkNJVGprTHliRXdvRnRGM3J2?=
 =?utf-8?Q?xM/oeJiQZnZd4xd5x+cT118Xg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9980d63e-c994-466a-2841-08dda4de1815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:39:55.2069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFRZefg2PKXPez8az+3h+g/hEbyxnCuPvE+H9H4h+K68KrB9fjaBNeYRZ0ebmCkL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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

On 6/6/25 09:51, Liang, Prike wrote:
> [Public]
> 
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Saturday, May 31, 2025 5:54 AM
>> To: Liang, Prike <Prike.Liang@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
>> Lazar, Lijo <Lijo.Lazar@amd.com>
>> Subject: Re: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
>> unmap
>>
>> On Fri, May 30, 2025 at 4:05 AM Prike Liang <Prike.Liang@amd.com> wrote:
>>>
>>> The userq VA unmap requires validating queue status before unamapping
>>> it, if user tries to unmap an active userq by GEM VA IOCTL then the
>>> driver should report an error for this illegal usage.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++++
>>>  2 files changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index e43a61f64755..e2275280554d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -234,7 +234,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>         return r;
>>>  }
>>>
>>> -static void
>>> +static int
>>>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>                                  struct amdgpu_usermode_queue *queue)
>>> { @@ -243,10 +243,14 @@ amdgpu_userq_wait_for_last_fence(struct
>>> amdgpu_userq_mgr *uq_mgr,
>>>
>>>         if (f && !dma_fence_is_signaled(f)) {
>>>                 ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>> -               if (ret <= 0)
>>> +               if (ret <= 0) {
>>>                         drm_file_err(uq_mgr->file, "Timed out waiting for
>> fence=%llu:%llu\n",
>>>                                      f->context, f->seqno);
>>> +                       return -ETIMEDOUT;
>>> +               }
>>>         }
>>> +
>>> +       return 0;
>>>  }
>>>
>>>  static void
>>> @@ -464,7 +468,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int
>> queue_id)
>>>                 mutex_unlock(&uq_mgr->userq_mutex);
>>>                 return -EINVAL;
>>>         }
>>> -       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>> +
>>> +       if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
>>> +               drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy
>> userq\n");
>>> +               mutex_unlock(&uq_mgr->userq_mutex);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>>         r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>>>         if (!r) {
>>>                 amdgpu_bo_unpin(queue->db_obj.obj);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 5e075e8f0ca3..168fc3835aaf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1930,6 +1930,11 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
>> *adev,
>>>         struct amdgpu_vm *vm = bo_va->base.vm;
>>>         bool valid = true;
>>>
>>> +       if (amdgpu_userq_gem_va_unmap_wait(vm)) {
>>> +               dev_warn(adev->dev, "shouldn't unmap the VA for an active userq\n");
>>> +               return -EINVAL;
>>> +       }
>>
>> There's not need to wait for anything.  Just return an error if the userq has not been
>> destroyed yet.
> [Prike] The current userq destroy IOCTL request always comes after amdgpu_vm_bo_unmap(),
> the original destroy validation idea is that the userq BOs only be able to be unmapped when they are
> idle, so here do we need to do the BOs busy wait or just test and throw a warning/error message when
> the driver tries unmap a busy BO?

Yeah that discussion came up previously before.

As far as I can see we can't return an error from unmap because the BO might still be used by a queue.

At least on the gfx side such a behavior could easily lead to crashes because userspace doesn't expect that an unmap fails and tries to re-use the address range.

What we can do is deactivate that queue and prevent it from becomming active again.

Regards,
Christian.

> 
>> Alex
>>
>>> +
>>>         saddr /= AMDGPU_GPU_PAGE_SIZE;
>>>
>>>         list_for_each_entry(mapping, &bo_va->valids, list) {
>>> --
>>> 2.34.1
>>>

