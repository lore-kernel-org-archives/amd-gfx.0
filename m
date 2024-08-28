Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC3C7112F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EE210E5D1;
	Wed, 28 Aug 2024 20:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x9q3kZOn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE4D10E5D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 20:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guKnK3SJPAYMmAkoww3PQaLnXaRjO3qv5hERaOeqNtfb3U2B99A2HrOZuqIApYoE0yByPOPqrysdUp4JAX+5DIpDX6Y9bYdoraGnKZ+MKyOMusLsDosXELXK+033Z3eHvZq3PzMFvMq1pz/ayG8PxdL12/XHl0Bu3WRIk9aGlY2r3JIqG8S1bE1n3oQgqkrLrEZ3dpWFRHvZRC1HWKpIWmqr19OdNFLoSEQALFGYFAUgiEm0OKwUjISEeT6mQJuv2wefAF0DIQM8V3b0rK6k2LAJ9HwkqHWHoHg0RrBSOZJLtv1A8+3nbkHg+QkCOaW7lki49D/2Oe62YclvZM4kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIzR5sCdDJ+5U5/aUKftOKo279DP0R1d4zQNJqBIcDk=;
 b=CZe6weUpw1UEDHYCetD68MfXH7VvP52ucHtn6KtG6vyDTZyTKspDRI7MJu27NvLABiHm7HQDM2GygclBmgVbDXYwot+UognhRmv5dTcpDKoecZFpTFmUs6phI2aiTNZYaTpNQGwzXufO+kMCY58SeFi2NToStiC0DRwk+53Vj8dZHGRLPtYyajfaBazTCJYgNwKv1VqNIfyJ6xceFO+SdFKk5fjuLX0qXSMKNkrdHufm2OOw3ERRtdn0VicyeIKhZZ2azlYucxrn9fN392z4CiDGkMTnFYTEbmoFButrnZkwY6gytGUzp+FjJBx+1r7HpVzQlmhnMtl1lPlCdrSAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIzR5sCdDJ+5U5/aUKftOKo279DP0R1d4zQNJqBIcDk=;
 b=x9q3kZOnXgcJT2ErTABDxe8l+ePAwvclq4DzPgA7tKIUGYcsFYtbN8z9ljIT07rwaOgVrK8YH8KDD3iZw1ImBlO47DWVYWgHgzgdjX7/pbepxTs2f6s9/zigljPSKlCvfTw2WHvZGWZSDJEk70ZTQ/9Zubmg51QUX53ti/fDrSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 20:34:06 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 20:34:06 +0000
Content-Type: multipart/alternative;
 boundary="------------zmmTRiR07jXHNOe866d6HbZU"
Message-ID: <3ad48bb9-ec0d-4908-a9d6-af60aead9de2@amd.com>
Date: Wed, 28 Aug 2024 15:34:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
Content-Language: en-CA
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
 <773d3d99-4e97-45cf-a457-51989ba3081c@amd.com>
 <DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <77342503-b366-4d8f-93f1-91e75c0682a8@amd.com>
 <DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::26) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a0a1f9-b1a1-49a8-edb1-08dcc7a0c345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qi9jcVA2bU0xM3k5bk42S0hKQTA1VXBFSXFnbmoxRjhVcWdCcDRZOWFGRXYy?=
 =?utf-8?B?SUU4MU1vVkpiUVB2bzdCN3ZDdk5KMFhISVFNLzlENk5EUmtscUprQUxqQ1BR?=
 =?utf-8?B?Z0s5dkN5am8wZ2gyc1JiM3l0eFAwbDJJRyt4RjVqUnZJdjh4eGtaWjRXSnc0?=
 =?utf-8?B?UWpVbzhIU2FpRlpXaDFxMTVwZ0hseVVodDdNVFgxcU16eEx1QkRNYkJSMVdH?=
 =?utf-8?B?c0NqZXk4dFhiOWlVWXZaQXZrVTlKY0dkQ3NlYmFybm5lcjk0Z1FpOTFTS2tJ?=
 =?utf-8?B?U0IvMVJRZndiZVpDWXQ2U2pjdzZhT1Z0eGlyL0hySC92WkVJdGM0bjZ2dTJT?=
 =?utf-8?B?VVVSdkJGUTBzclNKZHQ5SnE3NkNONVZUa3RvdnhrZ2YvL3FsNzZWZ2tmeGJF?=
 =?utf-8?B?VzJjVy9LSnVVREttWlBhdDY4aGJ6SjQzZXVuaVpndVFGYVVEQnBjN1J3eDFp?=
 =?utf-8?B?empUUGNuZ0VNVVVvaC9Tajg4Y2JKU1A2VFZVNGZLa0dJUVIzUThJZDJlbFdU?=
 =?utf-8?B?eG9oZVpHaHpPVUtoanpPZSt5ZFUzVmY3OWtVWVZXdTB1dEgranh6M0p4ZjJ2?=
 =?utf-8?B?UGYwRUs3ckFlNXlHYkMySDAxb0ZzYklndUM3SEJHY2puL1JBY3psQTRlOS8x?=
 =?utf-8?B?bVNKZDMvSXdPQ0ZZbGV6a05mZ3lJdWU3ejlSa2JYSlBxKzdnVnVQRzkzcFZT?=
 =?utf-8?B?cGdXaGZWM2NaSjVjYllORTRTRG1IUlM0VGFRRkIrVlFaaG4zTVRqRG1TUWgv?=
 =?utf-8?B?TGZESDEyWTZGb0FUbGxlVzM1REZkR2VmeTdiaWFWbTcyZ3QyZnNzOGs4NHZp?=
 =?utf-8?B?MmRTekFsQVdWNVZLQzlUSCtHbXNKN2hxTUdqVGliay90MGtQYVJVQWF4anZz?=
 =?utf-8?B?VmdOWDhxRjA2UU1CRXZ6bVA2am5uZElrdDVJUjJGcFNlcm5hbXZrZmVCdWdM?=
 =?utf-8?B?QWNsTUV1VHloUnJMMll3RC80a091WHEyeXN1dFg3T1pYZFNEc3dBRlBhRzRO?=
 =?utf-8?B?Q05pTC9OV2d6UjVkWU1lVlpkVmhidWdCa1dCc3dDeVdESGZQZFRZN3lORllW?=
 =?utf-8?B?Q0tXSEJVNHVRVVpLb1laMHJxZ3JBaTA4bXQvWHJYNmQrTnh6QU85ZmJCaS91?=
 =?utf-8?B?cEgxRlZCTmdkdkJySmlISXg1dzlFbWdleGN2VzFhei9JQ0tRbjU2ajhCb0Yz?=
 =?utf-8?B?a2VIeHVvSkUreUZYQUhSWkxXbHhHQUdTZ2VvcmRpci9pNXJXd0FLZWk2Ulk3?=
 =?utf-8?B?Y0poS08xa0ZHdlZZSDEreVBFaVNtSEIyZ0dKbnFQVTJwOEFCS2tOYncyeTlE?=
 =?utf-8?B?TFI0aG4zZjNtK1QxemNKcVhoUEZaZmxCa21vd2FqaDdteFJCRFVDSVdjN2NL?=
 =?utf-8?B?OHI1UHBwRTBxbURPN2R5UmtkU1VwMXBSaEc1MTlZVjRiVU9tbXA4ZnBzei9K?=
 =?utf-8?B?Rm9xK3diMWRtTVBlQkoxeW9lYVhKUXlXL2xobVpJZzlNeEtzZERpQWpCY0dr?=
 =?utf-8?B?T1dFa1FoOFNyVHZhRDdsbFJXTklvdVpYZDhQelQrWWl1ak1vMUJtWWs2MnFv?=
 =?utf-8?B?N0orZmJtTlhET0U3MEdJclBwUUh6VVIweW13RGVmNmQyVEhHL1BiaEZNNU9C?=
 =?utf-8?B?UFdIc2JoTlNNQUNmY1J1WGNsK3JrWWtwUkFzVDRIZHd2VWwyaE9xSCs5NUV6?=
 =?utf-8?B?cHNBajNtckI1em8xRDBkOG94d0V4Q0ZuQ0tLNkpWbzJpUUw5MFluSzN6dS9S?=
 =?utf-8?B?VEU5R21CWDM0Mkl6OHlIQjYxcGtqMHZpQnlkQ1lIS1Z5QWQvUEsycmRva0JS?=
 =?utf-8?B?RHNFbDdiV1FMRTNBdlJ4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNLam1PanZBM3ZvRUVNNjR2QU10LzVBTXB1NHY5RDQ2QXA5KzhiL295OXh3?=
 =?utf-8?B?TmFqOWIydS9waW1jdllPUCtaNzJEZnRTdW16MmJubXJHcThnR3RRbVozUmkz?=
 =?utf-8?B?YUdjZGhzNC8yc1Z2Tk0ySTBOM1docG9uYVBBamVlYVJQNXVnTHZiQkVRZG00?=
 =?utf-8?B?Y2phODk3TzBmSmpUNWZkYllSREthYVB1a3ZjVXZHK3o0dFhWVXg2MnQ5ZW95?=
 =?utf-8?B?dDl0YXRCN3VzNmw4azBKNjY2d0d3dE8xRkF2RCtQTldtdnJnOEZiM3RjOHdJ?=
 =?utf-8?B?RUo5ajU0V0hUVVNzcjRmQnN3ZTRseFN6UHgvdDUwL2VIY2IzUmQ5ZDhzNGRR?=
 =?utf-8?B?NW9YczVWT3ZqSWFDN3lNb3YwMUhmOHppV3dldTNvanhMRjN5V2ZEK1pud0F6?=
 =?utf-8?B?VmtvdHdrS1ZHaVJoTjdxRkV1R0ZvWlR6NXA3QWprM3BURUJVU3F1cllzemVk?=
 =?utf-8?B?WENYeFJHVzlVekZrbjkvdVpHNHh1VkQ2U2hqMnRDdGNnY3Y2ZE5LNVduQm5B?=
 =?utf-8?B?elNDcUl1QU1vdkJYS1cvMnVqdWVFd0gwdU9GL01vY1RiTk9vS1VVOHh3bks4?=
 =?utf-8?B?dzh2NytJakxkSjVoRkoydlEzUHkybzZWaW9sTmg2YmpBQlJVbzBVWlh4QWxh?=
 =?utf-8?B?M01BUFV0T0xWcldsWHZVL2hDaTFnT09KWHBXVHM0VmxMQnZrb05aQzdMT3N0?=
 =?utf-8?B?bDNqdGQxbEloUUloNXgzSm1GVkJQLzg5VWVvbW1NN29rMFV5RHF4OHhCM21i?=
 =?utf-8?B?d2J0YVU5YktNaUczblRLV3p1dFZ3TnhYeEFUVjIyWTdFNXFYbW8zeXdodnJn?=
 =?utf-8?B?RjJ1WFZRY1MyUXZQR0tEcTRYenVaVnVYT0M4K25IUkJ3MDNkMVI0UENvc1dB?=
 =?utf-8?B?RVROWEVMMTB6NThSb0ZYNVJQNkxvVlBBU1YzQTBLdXRqbW1sdG9OU0gyVzZF?=
 =?utf-8?B?NnFCTUVQSUY0ZTlFUG5DR2ZBZThOQXBiZFhkbzFucC9OaG1sSWNmcVJtV2Vv?=
 =?utf-8?B?Tk50T0E5TzdXdDRGS1ROSzZCQWZrWTBvaklUdXl2dVJiR2dpVTUzRUVJQTNj?=
 =?utf-8?B?TFBSK2hrK1hJMnk3aytaZlJLT2t3QVZIQVpnOENVd1Fhc2JVVk04VVA2VTM3?=
 =?utf-8?B?VVBNVnhmSnFaNmVVdkJkZFM5NStqblZDVzAxNFl1N3ZWMDI0Q2dVMzdiNUs1?=
 =?utf-8?B?cm5vS2FMSzR0NVJYQzR6dEMzNGU2d3U1L2RJSVZ1UVk5M3hSUmtLWlRuMmtU?=
 =?utf-8?B?bjEwWUhKbVBOYVdHcVFXWU1ma3dIc0ZTME5lSEVnb2N6SE50QkZzYVEzQW9V?=
 =?utf-8?B?VTFTR1AwZURaeDg5b0pNT2pCTmZqM1VtK25BWFVwM1B6dzZGU1NaTjJRUFBo?=
 =?utf-8?B?MnNtT01ENGlsVFdocW9Bbkt2RXk1T3hEWUtlVVRrcUtEZWJlOTlmcEtTa29G?=
 =?utf-8?B?TzRES2VBQlpIcnArMGJqRmJBRytaREVsOCswMy94UGZ1SWUyUW5FeEtRTlBt?=
 =?utf-8?B?cmtpSit5dnhVVmhpSkZZa2NIdzU2aW5HMUwzaW9YZVp4SHlJUEVHRVZyQW9V?=
 =?utf-8?B?M0VJclYwZjFvaTNuZkhtbXpuOUlFWGxDQTYrUU9DYmkvaWRFQlFHQkZkdXB3?=
 =?utf-8?B?M3ZSVCtMRHdyRmp5TldUTmNMVVhxblh0cktWemlIdlE0Rno1L3BmeXZ4Qmsx?=
 =?utf-8?B?RWtoV2M5MVBjQndWMmhDZWZVNGkwaExIRGlOUVhHRkx0NTFBa1UveFQyTkpR?=
 =?utf-8?B?cjIzNjJaSVNXazU0Qkw2ejFJY3FzWjdEM1ZnUlpDQ1Avcy9vNS96anNuUUd6?=
 =?utf-8?B?N3YrcDJ5Q3ZKNGpiei9jRG5DS1U3WUlXNUdhMGlBK3BCbnB1V1I1MFl5TVZm?=
 =?utf-8?B?ZGhYOHd3S0Q1ajc2Y21pdVZUM1MvTnZYT1RTeXMvMXlDMkpsVXgzc1NtYzk1?=
 =?utf-8?B?T1VwM3RrSElhd3lYQWNBTU9pLzV3V2VaZVJpaUh2ZHFnbStqT3ZzaVVEemxw?=
 =?utf-8?B?TFRpTk0wNVBKUEY1Mnpod3dHLzMzWGpVSGp6MXlsOGFCWVhwcW4rTzlPNG9p?=
 =?utf-8?B?WWp4TktoZjRKOERUbis1MmYwVHBqUEJueXRiTW9aWWJkRmZZa0FUNjlsbStx?=
 =?utf-8?Q?aPg4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a0a1f9-b1a1-49a8-edb1-08dcc7a0c345
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:34:06.6198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWwVx7OxZru17MZpBRBUhejujUjA0U9RBAMNO1AEFTEZ4uJATDn1CIlryzABFO/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
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

--------------zmmTRiR07jXHNOe866d6HbZU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/2024 3:26 PM, Errabolu, Ramesh wrote:
>
> Responses inline
>
> Regards,
>
> Ramesh
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Wednesday, August 28, 2024 3:01 PM
> *To:* Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; 
> amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW 
> module parameter
>
> On 8/28/2024 2:52 PM, Errabolu, Ramesh wrote:
>
>     Response inline
>
>     Regards,
>
>     Ramesh
>
>       
>
>     -----Original Message-----
>
>     From: Chen, Xiaogang<Xiaogang.Chen@amd.com>  <mailto:Xiaogang.Chen@amd.com>  
>
>     Sent: Wednesday, August 28, 2024 2:43 PM
>
>     To: Errabolu, Ramesh<Ramesh.Errabolu@amd.com>  <mailto:Ramesh.Errabolu@amd.com>;amd-gfx@lists.freedesktop.org
>
>     Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter
>
>     Why need this driver parameter? kfd has KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set migration granularity per prange. If both got set which will take precedence?
>
>     Ramesh: Use of Kfd Ioctl is available to users of registered memory. It allows users to control GOBM per buffer level, including overwriting default value. For ranges that do not specify GOBM, the default value will be found.
>
> If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will overwrite 
> this parameter value for a prange, then how to know which granularity 
> take effect? That is decided when user set this parameter and when the 
> api got used.
>
> Ramesh: The value bound by Kfd ioctl will take effect. In the life 
> cycle of a prange it can go from the default value to one that is set 
> by user via set_attr() call. However, it is generally understood that 
> that users of set_attr() will not call it directly i.e. the rely on 
> higher level apis from ROCr or HIP.
>
driver parameter can be set at run time, not only at boot time. It is 
not predictable  when user set this driver parameter and when the api 
got called.

Regards

Xiaogang

> Regards
>
> Xiaogang
>
>     Regards
>
>     Xiaogang
>
>     On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
>
>         Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>         Enables users to update the default size of buffer used in migration
>
>         either from Sysmem to VRAM or vice versa.
>
>         The param GOBM refers to granularity of buffer migration, and is
>
>         specified in terms of log(numPages(buffer)). It facilitates users of
>
>         unregistered memory to control GOBM, albeit at a coarse level
>
>         Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com>  <mailto:Ramesh.Errabolu@amd.com>
>
>         ---
>
>            drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>
>            drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
>
>            drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>
>            drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
>
>            4 files changed, 51 insertions(+), 9 deletions(-)
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>         index e8c284aea1f2..73dd816b01f2 100644
>
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>         @@ -237,6 +237,7 @@ extern int sched_policy;
>
>            extern bool debug_evictions;
>
>            extern bool no_system_mem_limit;
>
>            extern int halt_if_hws_hang;
>
>         +extern uint amdgpu_svm_attr_gobm;
>
>            #else
>
>            static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>
>            static const bool __maybe_unused debug_evictions; /* = false */ @@
>
>         -313,6 +314,9 @@ extern int amdgpu_wbrf;
>
>            /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
>
>            #define AMDGPU_SWCTF_EXTRA_DELAY               50
>
>         +/* Default size of buffer to use in migrating buffer */
>
>         +#define AMDGPU_SVM_ATTR_GOBM       9
>
>         +
>
>            struct amdgpu_xcp_mgr;
>
>            struct amdgpu_device;
>
>            struct amdgpu_irq_src;
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>         index b9529948f2b2..09c501753a3b 100644
>
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>         @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>
>            char *amdgpu_disable_cu;
>
>            char *amdgpu_virtual_display;
>
>            bool enforce_isolation;
>
>         +
>
>         +/* Specifies the default size of buffer to use in
>
>         + * migrating buffer from Sysmem to VRAM and vice
>
>         + * versa
>
>         + *
>
>         + * GOBM - Granularity of Buffer Migration
>
>         + *
>
>         + * Defined as log2(sizeof(buffer)/PAGE_SIZE)  */ uint
>
>         +amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
>
>         +
>
>            /*
>
>             * OverDrive(bit 14) disabled by default
>
>             * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@
>
>         module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>
>            MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
>
>            module_param_named(msi, amdgpu_msi, int, 0444);
>
>         +/**
>
>         + * DOC: svm_attr_gobm (uint)
>
>         + * Size of buffer to use in migrating buffer from Sysmem to VRAM and
>
>         +vice versa  */ MODULE_PARM_DESC(svm_attr_gobm, "Defined as
>
>         +log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
>
>         +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
>
>         +
>
>            /**
>
>             * DOC: lockup_timeout (string)
>
>             * Set GPU scheduler timeout value in ms.
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         index 9ae9abc6eb43..c2e54b18c167 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>
>         @@ -868,6 +868,18 @@ struct svm_range_list {
>
>                   struct task_struct              *faulting_task;
>
>                   /* check point ts decides if page fault recovery need be dropped */
>
>                   uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
>
>         +
>
>         +       /* Indicates the default size to use in migrating
>
>         +        * buffers of a process from Sysmem to VRAM and vice
>
>         +        * versa. The max legal value cannot be greater than
>
>         +        * 0x3F
>
>         +        *
>
>         +        * @note: A side effect of this symbol being part of
>
>         +        * struct svm_range_list is that it forces all buffers
>
>         +        * of the process of unregistered kind to use the same
>
>         +        * size in buffer migration
>
>         +        */
>
>         +       uint8_t attr_gobm;
>
>            };
>
>            /* Process data */
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         index b44dec90969f..78c78baddb1f 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         @@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>
>            }
>
>            static void
>
>         -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>
>         -                                uint8_t *granularity, uint32_t *flags)
>
>         +svm_range_set_default_attributes(int32_t *location,
>
>         +                       int32_t *prefetch_loc, uint32_t *flags)
>
>            {
>
>                   *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>
>                   *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>
>         -       *granularity = 9;
>
>                   *flags =
>
>                           KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
>
>            }
>
>         @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>
>                           bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>
>                                       MAX_GPU_INSTANCE);
>
>         +       prange->granularity = svms->attr_gobm;
>
>                   svm_range_set_default_attributes(&prange->preferred_loc,
>
>         -                                        &prange->prefetch_loc,
>
>         -                                        &prange->granularity, &prange->flags);
>
>         +                               &prange->prefetch_loc,
>
>         + &prange->flags);
>
>                   pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>
>         @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct
>
>         kfd_process *p, int64_t addr,
>
>                   *is_heap_stack = vma_is_initial_heap(vma) ||
>
>         vma_is_initial_stack(vma);
>
>         +       /* Determine the starting and ending page of prange */
>
>                   start_limit = max(vma->vm_start >> PAGE_SHIFT,
>
>         -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
>
>         +                     (unsigned long)ALIGN_DOWN(addr, 1 <<
>
>         + p->svms.attr_gobm));
>
>                   end_limit = min(vma->vm_end >> PAGE_SHIFT,
>
>         -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
>
>         +                   (unsigned long)ALIGN(addr + 1, 1 <<
>
>         + p->svms.attr_gobm));
>
>         +
>
>                   /* First range that starts after the fault address */
>
>                   node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
>
>                   if (node) {
>
>         @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
>
>                           if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>
>                                   bitmap_set(svms->bitmap_supported, i, 1);
>
>         +       /* Bind granularity of buffer migration, either
>
>         +        * the default size or one specified by the user
>
>         +        */
>
>         +       svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
>
>         +       pr_debug("Granularity Of Buffer Migration: %d\n",
>
>         + svms->attr_gobm);
>
>         +
>
>                   return 0;
>
>            }
>
>         @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
>
>                   node = interval_tree_iter_first(&svms->objects, start, last);
>
>                   if (!node) {
>
>                           pr_debug("range attrs not found return default values\n");
>
>         -               svm_range_set_default_attributes(&location, &prefetch_loc,
>
>         -                                                &granularity, &flags_and);
>
>         +               granularity = svms->attr_gobm;
>
>         +               svm_range_set_default_attributes(&location,
>
>         +                                       &prefetch_loc, &flags_and);
>
>                           flags_or = flags_and;
>
>                           if (p->xnack_enabled)
>
>                                   bitmap_copy(bitmap_access,
>
>         svms->bitmap_supported,
>
>         --
>
>         2.34.1
>
--------------zmmTRiR07jXHNOe866d6HbZU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/28/2024 3:26 PM, Errabolu, Ramesh
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle22
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style>
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt">Responses
            inline<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        <div>
          <p class="MsoNormal"><span style="font-size:11.0pt;color:black">Regards,</span><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;color:black">Ramesh</span><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
        </div>
        <p class="MsoNormal"><span style="font-size:11.0pt;color:black">&nbsp;</span><span style="font-size:11.0pt"><o:p></o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
                <br>
                <b>Sent:</b> Wednesday, August 28, 2024 3:01 PM<br>
                <b>To:</b> Errabolu, Ramesh
                <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <b>Subject:</b> Re: [PATCH v2] drm/amdgpu: Surface
                svm_attr_gobm, a RW module parameter<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal">On 8/28/2024 2:52 PM, Errabolu, Ramesh
            wrote:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre>Response inline<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Regards,<o:p></o:p></pre>
          <pre>Ramesh<o:p></o:p></pre>
          <pre>&nbsp;<o:p></o:p></pre>
          <pre>-----Original Message-----<o:p></o:p></pre>
          <pre>From: Chen, Xiaogang <a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a> <o:p></o:p></pre>
          <pre>Sent: Wednesday, August 28, 2024 2:43 PM<o:p></o:p></pre>
          <pre>To: Errabolu, Ramesh <a href="mailto:Ramesh.Errabolu@amd.com" moz-do-not-send="true">&lt;Ramesh.Errabolu@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
          <pre>Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Why need this driver parameter? kfd has KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set migration granularity per prange. If both got set which will take precedence?<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Ramesh: Use of Kfd Ioctl is available to users of registered memory. It allows users to control GOBM per buffer level, including overwriting default value. For ranges that do not specify GOBM, the default value will be found. <o:p></o:p></pre>
        </blockquote>
        <p>If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will
          overwrite this parameter value for a prange, then how to know
          which granularity take effect? That is decided when user set
          this parameter and when the api got used.<o:p></o:p></p>
        <p><span style="font-size:11.0pt">Ramesh: The value bound by Kfd
            ioctl will take effect. In the life cycle of a prange it can
            go from the default value to one that is set by user via
            set_attr() call. However, it is generally understood that
            that users of set_attr() will not call it directly i.e. the
            rely on higher level apis from ROCr or HIP.</span></p>
      </div>
    </blockquote>
    <p>driver parameter can be set at run time, not only at boot time.
      It is not predictable&nbsp; when user set this driver parameter and
      when the api got called.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p><span style="font-size:11.0pt"><o:p></o:p></span></p>
        <p>Regards<o:p></o:p></p>
        <p>Xiaogang<o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre><o:p>&nbsp;</o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Regards<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Xiaogang<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:<o:p></o:p></pre>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Enables users to update the default size of buffer used in migration <o:p></o:p></pre>
            <pre>either from Sysmem to VRAM or vice versa.<o:p></o:p></pre>
            <pre>The param GOBM refers to granularity of buffer migration, and is <o:p></o:p></pre>
            <pre>specified in terms of log(numPages(buffer)). It facilitates users of <o:p></o:p></pre>
            <pre>unregistered memory to control GOBM, albeit at a coarse level<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Signed-off-by: Ramesh Errabolu <a href="mailto:Ramesh.Errabolu@amd.com" moz-do-not-send="true">&lt;Ramesh.Errabolu@amd.com&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre>&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++++<o:p></o:p></pre>
            <pre>&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++<o:p></o:p></pre>
            <pre>&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp; | 12 ++++++++++++<o:p></o:p></pre>
            <pre>&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; | 26 ++++++++++++++++---------<o:p></o:p></pre>
            <pre>&nbsp; 4 files changed, 51 insertions(+), 9 deletions(-)<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <o:p></o:p></pre>
            <pre>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
            <pre>index e8c284aea1f2..73dd816b01f2 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></pre>
            <pre>@@ -237,6 +237,7 @@ extern int sched_policy;<o:p></o:p></pre>
            <pre>&nbsp; extern bool debug_evictions;<o:p></o:p></pre>
            <pre>&nbsp; extern bool no_system_mem_limit;<o:p></o:p></pre>
            <pre>&nbsp; extern int halt_if_hws_hang;<o:p></o:p></pre>
            <pre>+extern uint amdgpu_svm_attr_gobm;<o:p></o:p></pre>
            <pre>&nbsp; #else<o:p></o:p></pre>
            <pre>&nbsp; static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;<o:p></o:p></pre>
            <pre>&nbsp; static const bool __maybe_unused debug_evictions; /* = false */ @@ <o:p></o:p></pre>
            <pre>-313,6 +314,9 @@ extern int amdgpu_wbrf;<o:p></o:p></pre>
            <pre>&nbsp; /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */<o:p></o:p></pre>
            <pre>&nbsp; #define AMDGPU_SWCTF_EXTRA_DELAY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+/* Default size of buffer to use in migrating buffer */<o:p></o:p></pre>
            <pre>+#define AMDGPU_SVM_ATTR_GOBM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>&nbsp; struct amdgpu_xcp_mgr;<o:p></o:p></pre>
            <pre>&nbsp; struct amdgpu_device;<o:p></o:p></pre>
            <pre>&nbsp; struct amdgpu_irq_src;<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <o:p></o:p></pre>
            <pre>b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></pre>
            <pre>index b9529948f2b2..09c501753a3b 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></pre>
            <pre>@@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;<o:p></o:p></pre>
            <pre>&nbsp; char *amdgpu_disable_cu;<o:p></o:p></pre>
            <pre>&nbsp; char *amdgpu_virtual_display;<o:p></o:p></pre>
            <pre>&nbsp; bool enforce_isolation;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+/* Specifies the default size of buffer to use in<o:p></o:p></pre>
            <pre>+ * migrating buffer from Sysmem to VRAM and vice<o:p></o:p></pre>
            <pre>+ * versa<o:p></o:p></pre>
            <pre>+ *<o:p></o:p></pre>
            <pre>+ * GOBM - Granularity of Buffer Migration<o:p></o:p></pre>
            <pre>+ *<o:p></o:p></pre>
            <pre>+ * Defined as log2(sizeof(buffer)/PAGE_SIZE)&nbsp; */ uint <o:p></o:p></pre>
            <pre>+amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>&nbsp; /*<o:p></o:p></pre>
            <pre>&nbsp;&nbsp; * OverDrive(bit 14) disabled by default<o:p></o:p></pre>
            <pre>&nbsp;&nbsp; * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@ <o:p></o:p></pre>
            <pre>module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);<o:p></o:p></pre>
            <pre>&nbsp; MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 = disable, -1 = auto)&quot;);<o:p></o:p></pre>
            <pre>&nbsp; module_param_named(msi, amdgpu_msi, int, 0444);<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+/**<o:p></o:p></pre>
            <pre>+ * DOC: svm_attr_gobm (uint)<o:p></o:p></pre>
            <pre>+ * Size of buffer to use in migrating buffer from Sysmem to VRAM and <o:p></o:p></pre>
            <pre>+vice versa&nbsp; */ MODULE_PARM_DESC(svm_attr_gobm, &quot;Defined as <o:p></o:p></pre>
            <pre>+log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB&quot;); <o:p></o:p></pre>
            <pre>+module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>&nbsp; /**<o:p></o:p></pre>
            <pre>&nbsp;&nbsp; * DOC: lockup_timeout (string)<o:p></o:p></pre>
            <pre>&nbsp;&nbsp; * Set GPU scheduler timeout value in ms.<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <o:p></o:p></pre>
            <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
            <pre>index 9ae9abc6eb43..c2e54b18c167 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<o:p></o:p></pre>
            <pre>@@ -868,6 +868,18 @@ struct svm_range_list {<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *faulting_task;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check point ts decides if page fault recovery need be dropped */<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_ts[MAX_GPU_INSTANCE];<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Indicates the default size to use in migrating<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * buffers of a process from Sysmem to VRAM and vice<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * versa. The max legal value cannot be greater than<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0x3F<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @note: A side effect of this symbol being part of<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * struct svm_range_list is that it forces all buffers<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of the process of unregistered kind to use the same<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * size in buffer migration<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t attr_gobm;<o:p></o:p></pre>
            <pre>&nbsp; };<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>&nbsp; /* Process data */<o:p></o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <o:p></o:p></pre>
            <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
            <pre>index b44dec90969f..78c78baddb1f 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
            <pre>@@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)<o:p></o:p></pre>
            <pre>&nbsp; }<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>&nbsp; static void<o:p></o:p></pre>
            <pre>-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *granularity, uint32_t *flags)<o:p></o:p></pre>
            <pre>+svm_range_set_default_attributes(int32_t *location,<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t *prefetch_loc, uint32_t *flags)<o:p></o:p></pre>
            <pre>&nbsp; {<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *granularity = 9;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags =<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;<o:p></o:p></pre>
            <pre>&nbsp; }<o:p></o:p></pre>
            <pre>@@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;granularity = svms-&gt;attr_gobm;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;prange-&gt;prefetch_loc,<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;prange-&gt;granularity, &amp;prange-&gt;flags);<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;prange-&gt;prefetch_loc, <o:p></o:p></pre>
            <pre>+ &amp;prange-&gt;flags);<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>@@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct <o:p></o:p></pre>
            <pre>kfd_process *p, int64_t addr,<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *is_heap_stack = vma_is_initial_heap(vma) || <o:p></o:p></pre>
            <pre>vma_is_initial_stack(vma);<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Determine the starting and ending page of prange */<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_limit = max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 8));<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DOWN(addr, 1 &lt;&lt; <o:p></o:p></pre>
            <pre>+ p-&gt;svms.attr_gobm));<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_limit = min(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 8));<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 1 &lt;&lt; <o:p></o:p></pre>
            <pre>+ p-&gt;svms.attr_gobm));<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First range that starts after the fault address */<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node = interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1, ULONG_MAX);<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node) {<o:p></o:p></pre>
            <pre>@@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_set(svms-&gt;bitmap_supported, i, 1);<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind granularity of buffer migration, either<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the default size or one specified by the user<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Granularity Of Buffer Migration: %d\n&quot;, <o:p></o:p></pre>
            <pre>+ svms-&gt;attr_gobm);<o:p></o:p></pre>
            <pre>+<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></pre>
            <pre>&nbsp; }<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>@@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!node) {<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;range attrs not found return default values\n&quot;);<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;granularity, &amp;flags_and);<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; granularity = svms-&gt;attr_gobm;<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_set_default_attributes(&amp;location,<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&amp;prefetch_loc, &amp;flags_and);<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags_or = flags_and;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;xnack_enabled)<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(bitmap_access, <o:p></o:p></pre>
            <pre>svms-&gt;bitmap_supported,<o:p></o:p></pre>
            <pre>--<o:p></o:p></pre>
            <pre>2.34.1<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
          </blockquote>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------zmmTRiR07jXHNOe866d6HbZU--
