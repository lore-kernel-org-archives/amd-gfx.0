Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6994FC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 19:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D90010E9EE;
	Fri, 26 Jul 2024 19:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZAR7Yost";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D8510E9ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 19:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn1SwWCsrug2TTL3iHuOiU/8QdVqi0D9Vn+De2OHOpU5NEkrNLLlcCpm8S91DBklJlpoHTzKek7vju5zNIYM2IItuE4riMoB2hoc18CjrHMu31TTuug2t8fnzZNIgUc/zPHJ77Wgk73zAqm4N+a2GU4Rv5TVz8XAJYF1mMlxJ8yFDw16zYhN5Gv71zje7Qa6hQyksE6UJfqGWLWDVwin7SCYqYa92iacDDDYPQ22gGk0JRO6tSPDVOQR1suo86lPJvyr5YwhiT3B5GLLu9OZlt8qHg8c6cwNqmzPM8yEL3pyWSXDfVxoK1EtMVL43jSBvk6WMjVJuMQ3wpipRjseYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tpNgWBeZLglAJolmW2qUOMhOsKk1CMJ4ZZ17pvbAmg=;
 b=EpxT1jDDFYE3ykj7oyZMH3XuU+B3MitF5dVrU4tdZGx5785nTvIQO7V/WAzMLfZWvYf1tsd1WV7PieXgs07QuoBBwBlI8Z5HTK6x+onZqugoB50YwsBvF7kk/nnQND8FN45gZpoGzQsLvmnhzZkD0FEjb1X4PrmZPsX1eESu2XQyCAStpxqX3kpMCT4pyUG5boYKnnqQKNe3e3lZH6WosRu+DqGJ+BsXCnulG8if4p5T3j639iH5dzdoVxWDrMCinOaHQuTJulIpqiG800LjBc0sXObgP7Y17A1JisFxdVv0mpzRXfrt/nCOUp9/jHDT7Z3NtOuDA3/1nlBqFf4GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tpNgWBeZLglAJolmW2qUOMhOsKk1CMJ4ZZ17pvbAmg=;
 b=ZAR7YostP+9Ef7VcX81vUcnEvh+UFiLhXtBrKOFKzfiO8sObp+bxhZzrBIF1fRYRIWAEHRayAhv3QTUnr8PrjebWEbICqYqOI7y5jjh0ylHUPbAj1C0ifiKnGymWP1x/7NwiPyPhxLCNoJ47asjS2FZ1inq/AB/RyjG/n3aNFSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Fri, 26 Jul
 2024 19:21:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 19:21:35 +0000
Message-ID: <5d3f962c-6efc-4aee-99ac-5dc48c43235f@amd.com>
Date: Sat, 27 Jul 2024 00:51:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
 <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
 <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
 <CADnq5_OY_Zoqcrk-n6JvLt8fQCQifAfMX9r8a0qyRu0i9UEEaA@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_OY_Zoqcrk-n6JvLt8fQCQifAfMX9r8a0qyRu0i9UEEaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f074618-842c-4b5c-37cb-08dcada82a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDJ4VGpXNzduODFIaU9XZXlTR0ErNEloamRxNVVIT1F2OHZCY2c0K2gzOFNx?=
 =?utf-8?B?dlIzRnpTc3FSRnFWSHB2YjEvWnRST25YSFVWbzNHYU5DNitWWHRadzgzMEdi?=
 =?utf-8?B?aFRaSmorY01iQ1Z4MncwWUJGU3p2K3NSYTA5VWFwQTFEVm5nUjJOT001V1Nz?=
 =?utf-8?B?eFZlTzlrQTF4ejVzZzV5NzYrRW1ocjIxVVprSXlqSUtqV2FFd1paeDErV1lF?=
 =?utf-8?B?WTNTNzU4MVlCMXBHekVHSDh0aFZaLytiRUhjYWFKUWZuM0s1bHJjeDI5THZi?=
 =?utf-8?B?MTNFTkNiOTNkdXZFVUpzTUkrSWl2TEd5Y2RWQzQ3WXYzMWszQXdhZG1oZnM0?=
 =?utf-8?B?cjV4Z0ZLTU91V0lFeTFQdUl4VktNUVB5UU0yNmE0Tk5iQ21YdXl5TlZRQzVB?=
 =?utf-8?B?OFFRWEMxb1RYTUQzQk9hWjVjWkcvc3NTNXhCdHRFdGhJWEZIN1ZLMGpDS1lk?=
 =?utf-8?B?ckczWUV6bi9wckxyRUR5bVYvYmtYempZM3VOY0FWbXIvU0RSei9teUZIaUFO?=
 =?utf-8?B?V25XYitwOWk3aEsxUGN2Tk8zM0I3dGNLTW9DM2tzQXBUK291TmdCd2pxemJU?=
 =?utf-8?B?UVhRMk1HMG8vVEZMTFlybE42c0V1VisxWUR4dUd3MFBpZ2pHWUs3U1RtNzZG?=
 =?utf-8?B?SGJLL3lYM1B4ZUFWbS9hRGtQdllQdFhzQURmVDZOcVJ3Y2REeTF6c1ltbzBm?=
 =?utf-8?B?NmpaSHQrTHNsZGlxLy9TNGYwRVVER1A2R0xZdElzenh3d25lZG1LVXlTTjlF?=
 =?utf-8?B?MDBQcVVtNzRqNERJcS9QRmJmYm1rcmtBT0tjblZKYlRWY1ZMY3RSUFQ1UkRH?=
 =?utf-8?B?akxsTER4OElZRlJGN1liUitjR0dBaXRhRnlsRDY4L2JhWGlhWDZWZ0UzeDdB?=
 =?utf-8?B?V3NQOUpSRTJyUDg0RFdsemNIZk1KSW9XYjZWc3Arb2VoWFcvUTFwTTRycHRW?=
 =?utf-8?B?Qnp2dkFUcUVQWU1WemMwb0VPWTA3ZHFmOXM1K3pyYklVRXN3bTFrYXFCclg0?=
 =?utf-8?B?djcwRnR4dTVuYzBqNmcxSE9UbmtaTkJodU93SkRqRlBreGZwTS9ORVdKZVJi?=
 =?utf-8?B?NG5BSmtobFgwMGwyYStsRHZyL05CZHZCME1yS3NRWVpyVC9lcHcvK2dGMENL?=
 =?utf-8?B?c091M1pkTUFQR3ZUQkNOMnVYenRNZi91SEJmQ00zb210dHpHMk1neHF6Zy9N?=
 =?utf-8?B?ZVdnejdsdWYzbDZhbmhNTTBRWVNvM0hHc0NHcXp4ZWthNjRLYUQ2MytXTktW?=
 =?utf-8?B?YkY3Q21LeWNWMzdpZVpuU0RQM2NTQWtBaXczZzkrbzNSVG9OYlh5aWZUenpE?=
 =?utf-8?B?cFQrN2dlZElPRC9wRnBkNU5LYjljZjRqL014MHZSSjVFUUgyanlScENjZzQ5?=
 =?utf-8?B?SW9PQTRwTEJIeVlFQmlhbS9WTnFoZ3JLTlRod1RqaHRCK3hoL1ZEOHZ2a3dF?=
 =?utf-8?B?SkpvRko2aEhReTJwSHBsd3p3N3FLcjFGUHg1bHFLMVFoT3pYNzVnUlhIMGUr?=
 =?utf-8?B?YzQxNklKWkFzTG9aclArWGZ1a2FkUWlHLzloOU5TbnJzVEFFek1qTWdENUU1?=
 =?utf-8?B?MTVIWEF5N2lDM0Jra3ZXckoyeG1wYW5zRjI0QXkzL21WUEVBeFNRTU9pN2Nq?=
 =?utf-8?B?UlZpT2dKeS8rQXVEdmI3YW5tT2s1eE5FNXVvbUJSclVOWDJXUkFYZlB4SzVa?=
 =?utf-8?B?RjZhODRyWGtvRTRnNW9NTG5TVnZmWHFCTTUzbytFbFBFa3ZjbFAzcExFY0tm?=
 =?utf-8?B?M1VsUlNGWkZzVjZmYnpvZXptUXJQQzcydWtVeDE0amZGZFpVM2M3dHhnNzMv?=
 =?utf-8?B?Qy9Xc3ZuckpzalNqcVQxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0wvNmN6bHBQeWVCK0V5ZzhQWVVHZloyK1JtaEZOWUJPdHQzTkVOdXhjRWww?=
 =?utf-8?B?djNJbENEUzVrT3lrNnA2by9hM0lzM3RwNlUrZWloWDcxQS9HL0kzWFh3ZEdE?=
 =?utf-8?B?bFpSQ09YSWcvRVRpdnZoeDlTM0xyL09KZDBWZmZWUEtyQ2JNREVvSFpKRnM2?=
 =?utf-8?B?dEpIM0hHcTZNR1IvTHNHTWhCVlJ6NVFsQ21lckphMnFUTGtGSVY3aEttWmcz?=
 =?utf-8?B?Z1Ewa2VBeEN2b0NjZWdENmpIdnc1QkRHSHZkM29YSFdmaVVEWHUvV2twS3pn?=
 =?utf-8?B?azIwWlgxNlYwdHVnV05hcjhaQmdPUWtKSFBTMWVITmNZWUlvYU5PNzU1anlO?=
 =?utf-8?B?bm1KQ3VYN2R0UGhmbFVQSVZUUWpQQlVpQzVva0w2Nk1PSUlwS2MvVUs5c0Z3?=
 =?utf-8?B?bENsUFArRk1BdVNrUVFGWjNZaXdUcGt6RDZ6UGRpMlU2Tm5qZVJtTVp6cmZH?=
 =?utf-8?B?enBsdWVZL2dTc25tOHpjNHRiRVdOYjRyV0FtT3BmWVZiaFJVcXU0cHA0cC9S?=
 =?utf-8?B?RTY5WnlrQTlwZlZYcnlXN0lxMUFmTWZlbGZFdkZCcHNRZUZzeE0reDFiTDRX?=
 =?utf-8?B?ME5UcHhzR09Sem9BMWF2eTdhbDZ0NHoyaUlEUVM1TEZrNjRoSGplNWZOOVNk?=
 =?utf-8?B?Sk1BNENtdXhEUjdYTmhOb0cvcC9jTE5zQVhvY2hSQnkzSm9wa3lSUjYzZ0J1?=
 =?utf-8?B?ZTZRc01yVm9nR3FvemM3QVlVL1BBWkVTQSs1ZXFTclVjNkRWNkt3cHNldDgz?=
 =?utf-8?B?Q1ExTmRyQXN0THd3U2tqT2hUdDVWUzI1MXJvbjU0SzUyeHI1dGZhUkNIaGNG?=
 =?utf-8?B?WjMyZzFiUXBBNUVjbWIxbmZlQUMxK21sOFN6WUsya0JSUzJnbEJrRTlsY1Ex?=
 =?utf-8?B?WGgwVFAwNFFXM3BjbUtNcjJLaGFRM21WT3hIUFFkY0JhSm5CWldUV0paUnVr?=
 =?utf-8?B?ZW1LRG1VY3pJZnF2L2VLWHd0ejZCVnlxQ3Z3eExzcCs2aG1ER3RWV0lwaW9k?=
 =?utf-8?B?eDM0U09NTjVIbllpNXl3Q0JlRHF1dFFicDArK0Y4TVlmSXpIWDhEUWIxMVA2?=
 =?utf-8?B?VjRSTTdMcWRnK2F3N0NGd21vTERBQ0JUU2FOT1I2SzhReGVoQnZGVnpOajI1?=
 =?utf-8?B?L08xMUw2YStlbEZaYlhZU3E2RU85Z3JJUHI1WTBJelljbXh5YTNSaDcyNzVE?=
 =?utf-8?B?Uk5HVTlNK01oWVkyV1Qya0k2UFcwQU1XbVIxYytDUmpnelJsaWQxc0Iyc2hQ?=
 =?utf-8?B?SDRBN1VXOWZVK1I2ZFdWNWFPeUZzQU9vbjg0MjlRc1NCcnhGenZJRnBnQXFW?=
 =?utf-8?B?M3d1c1NFdGVpT2pmM2YrSDJENU9ZNzNiMFErWHhRSFM5WDl2RUU3UGt2Q2sy?=
 =?utf-8?B?Y2RQOVN6aW9JWWtaSzhOT2RrUjM3RDUxcnh2RUtFVnJydGxzMmJIUThBSmJQ?=
 =?utf-8?B?WU44ek9VdXBLMzAwVVZpMWtBZVB2cUF0WVdrTGdDbW15VHV5L2dTMTNBTmZE?=
 =?utf-8?B?ZEFhdVUvVUV6ekZKQk8rd0N3bkFKd0x4VktVUVlJUHdWcDl1OVFncW16b2ty?=
 =?utf-8?B?TUNMZ1FCYWpZZi9XZFcvWUkxVFh6WHk1VHNqU3p2MUxqQ2ZQbVVUNkpCbFdL?=
 =?utf-8?B?dWxWMG5JdjI1RnVEemhjV3h2V3BCL3FTNUltaTNrMlU4T2R0Yy96Q2xZcUcz?=
 =?utf-8?B?THpmL2pjK2RGd2pUdlhQQVNmaGdFcEw3MlB4QjVWQTEwYWVkZ2lVVG91cVlv?=
 =?utf-8?B?NHR5amlZR3huZW9NMDV5VThNTERzaWdVMjVQTktRZk53MVREcmN0YkNqTE9J?=
 =?utf-8?B?Z0Z3UzVvODZrcGxhdEk2bS80NG5JYkZRcUFla3RQWHcxVk4rZytmWFArSGFs?=
 =?utf-8?B?TVFDcjB2Q0diT3FNKytFeW9tWlFVaDZhUFUzSDRsYnZXNXFySC9hQTJHVEU4?=
 =?utf-8?B?L2pnUS9qS2JyNVFkZlpDV2pURzZXV2lvaVdDR0FxeFNKbGVSWEpkM09IeTFM?=
 =?utf-8?B?cVVZMkx1VFZ4WkRBbTRjZ250MElmSU9DczZDRkJrejNyb1hQbXN0V1liWkZS?=
 =?utf-8?B?SmZDZTg5bU9jYW0rK2YrWXpZLy9lT2NGVUZSKy9rTGJqNnM1aDBydDJmaWtJ?=
 =?utf-8?Q?ZubC/RQWxUi6T1Fd87kWEZ9KG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f074618-842c-4b5c-37cb-08dcada82a2b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 19:21:35.4368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOTClhA7QmtImsX9xV/StIcgAE+JRyfF5pzKPB87XCY75wVh9VEHXS34aAPUDKH018ahUJGu2Uc6a4KLP7eH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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


On 7/27/2024 12:13 AM, Alex Deucher wrote:
> On Fri, Jul 26, 2024 at 1:16 PM Khatri, Sunil <sukhatri@amd.com> wrote:
>>
>> On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
>>> On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
>>>> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>>>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com>
>>>>>>> wrote:
>>>>>>>> Problem:
>>>>>>>> IP dump right now is done post suspend of
>>>>>>>> all IP's which for some IP's could change power
>>>>>>>> state and software state too which we do not want
>>>>>>>> to reflect in the dump as it might not be same at
>>>>>>>> the time of hang.
>>>>>>>>
>>>>>>>> Solution:
>>>>>>>> IP should be dumped as close to the HW state when
>>>>>>>> the GPU was in hung state without trying to reinitialize
>>>>>>>> any resource.
>>>>>>>>
>>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>>>>> +++++++++++-----------
>>>>>>>>     1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>>>>> amdgpu_device *adev)
>>>>>>>>            return ret;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>> +{
>>>>>>>> +       int i;
>>>>>>>> +
>>>>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>> +
>>>>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>> +
>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>> A suspend also involves power/clock ungate. When reg dump is moved
>>>>>> earlier, I'm not sure if this read works for all. If it's left to
>>>>>> individual IP call backs, they could just do the same or better to move
>>>>>> these up before a dump.
>>>>> Suspend also put the status.hw = false and each IP in their respective
>>>>> suspend state which i feel does change the state of the HW.
>>>>> To get the correct snapshot of the GPU register we should not be
>>>>> fiddling with the HW IP at least till we capture the dump and that is
>>>>> the intention behind the change.
>>>>>
>>>>> Do you think there is a problem in this approach?
>>>>>>            amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>            amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>> Adding this does sounds better to enable just before we dump the
>>>>> registers but i am not very sure if ungating would be clean here or
>>>>> not. i Could try quickly adding these two calls just before dump.
>>>>>
>>>>> All i am worried if it does change some register reflecting the
>>>>> original state of registers at dump.
>>>>>
>>> I was thinking that if it includes some GFX regs and the hang happened
>>> because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
>> For GFX and SDMA hangs we make sure to disable GFXOFF before so for
>> those IP's
>> I am not worried and also based on my testing on NAVI22 for GPU hang
>> their registers
>> seems to be read cleanly.
>> Another point that i was thinking is after a GPU hang no where till the
>> point of dump
>> any registers are touched and that is what we need considering we are
>> able to read the registers.
>>
>> For VCN there is dynamic gating which is controlled by the FW if i am
>> not wrong which makes the VCN
>> off and registers cant be read. Only in case of VCN hang i am assuming
>> due to a Job pending VCN should be in power ON
>> state and out intent of reading the registers should work fine. Sadly i
>> am unable to validate it as there arent any test readily
>> available to hang VCN.
> We want to take the register dump as early as possible in the reset
> sequence, ideally before any of the hw gets touched as part of the
> reset sequence.  Otherwise, the dump is not going to be useful.
>
> Alex

Sure Alex. I am also of the same view that we dont want to change any 
power status of any IP as it could change the values.

Regards
Sunil Khatri

>
>
>>> BTW, since there is already dump_ip state which could capture IP regs
>>> separately and handle their power/clock gate situations, do you think
>>> this generic one is still needed?
>>>
>>> For whatever we have implemented till now seems to work fine in case of GPU hang withotu fidling the
>>> power state explicitly. But Calling suspend of each IP surely seems to change some state in IPs and SW state too.
>>> So i think until we experience a real problem we should go without the generic UNGATE call for all IP's
>>>
>>> But i am not an expert of power, so whatever you suggest would make more sense for the driver.
>> Regards
>> Sunil Khatri
>>> Thanks,
>>> Lijo
>>>
>>>>> What u suggest ?
>>>>> Regards
>>>>> Sunil
>>>> I quickly validated on Navi22 by adding below call just before we dump
>>>> registers
>>>> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>
>>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>
>>>>       amdgpu_reset_reg_dumps(tmp_adev);
>>>>       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>       /* Trigger ip dump before we reset the asic */
>>>>       for(i=0; i<tmp_adev->num_ip_blocks; i++)
>>>>           if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>               tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>                                       (void*)tmp_adev);
>>>>       dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>>> }
>>>> If this sounds fine with you i am update that. Regards Sunil Khatri
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>> +
>>>>>>>> +
>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>> +
>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>>>>                                     struct amdgpu_reset_context
>>>>>>>> *reset_context)
>>>>>>>>     {
>>>>>>>>            int i, r = 0;
>>>>>>>>            struct amdgpu_job *job = NULL;
>>>>>>>> +       struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
>>>>>>>>            bool need_full_reset =
>>>>>>>>                    test_bit(AMDGPU_NEED_FULL_RESET,
>>>>>>>> &reset_context->flags);
>>>>>>>>
>>>>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>                            }
>>>>>>>>                    }
>>>>>>>>
>>>>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>> &reset_context->flags)) {
>>>>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>> +
>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>> +                       /* Trigger ip dump before we reset the asic */
>>>>>>>> +                       for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>>>> +                               if
>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>> +
>>>>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>> +                                                       (void
>>>>>>>> *)tmp_adev);
>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>> Completed\n");
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>>                    if (need_full_reset)
>>>>>>>>                            r = amdgpu_device_ip_suspend(adev);
>>>>>>>>                    if (need_full_reset)
>>>>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            return r;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>> -{
>>>>>>>> -       int i;
>>>>>>>> -
>>>>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>> -
>>>>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>> -
>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>> -
>>>>>>>> -
>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>> -
>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>> -       }
>>>>>>>> -
>>>>>>>> -       return 0;
>>>>>>>> -}
>>>>>>>> -
>>>>>>>>     int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>                             struct amdgpu_reset_context *reset_context)
>>>>>>>>     {
>>>>>>>>            struct amdgpu_device *tmp_adev = NULL;
>>>>>>>>            bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>>>>            int r = 0;
>>>>>>>> -       uint32_t i;
>>>>>>>>
>>>>>>>>            /* Try reset handler method first */
>>>>>>>>            tmp_adev = list_first_entry(device_list_handle, struct
>>>>>>>> amdgpu_device,
>>>>>>>>                                        reset_list);
>>>>>>>>
>>>>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>> -
>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>>>> -                       if
>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>> -                               tmp_adev->ip_blocks[i].version->funcs
>>>>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>> Completed\n");
>>>>>>>> -       }
>>>>>>>> -
>>>>>>>>            reset_context->reset_device_list = device_list_handle;
>>>>>>>>            r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>>>>>>>            /* If reset handler not implemented, continue; otherwise
>>>>>>>> return */
>>>>>>>> --
>>>>>>>> 2.34.1
>>>>>>>>
