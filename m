Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C5C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 14:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC8010E3A8;
	Thu, 20 Mar 2025 14:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7I5LvsQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D883F10E3A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 14:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgCdVCGf51HchsKZ7Ru4Cxv/tVqklRw6atYOKvdlIaA8jNJHS9GNuhu4/n+gjroAuDUQOG+hQ65YXXbmCr0I30pIPu1+d9wVsSNb6VcHL1dlt3I10CF5EKgCd2+D8Pr13wNpDysOkeMbKye7VueyX8hDF1ShSF5kzbjq0UivKZyjlpdTUTEWYIiKoD8guxmXB9PoUI/x4fkXD9QuHp0wmCSY+kXmpI8kwm9UmdvC4jOyLtt6c4dgrRPRaCbHtSA98G4k/Xv76Nsevq1iC/MdK7IXT+0hJa56B7MTXmnoSNMRjb+t7nq6auBJj66IxGNdBU4KpeiWNNsidnA0jXuLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DzVuqi032iusKKs7cbZhatXQkydXQH9us9hI2a+ct4=;
 b=OjUXlXGo35Sr2o4/swSWnsHXRQnQfdIyPRku35AfPPxk/tSmEpVEWULhkokkDYdgqkq1Am5ye16uhdOVebYaYUZQG4VwN7/NsEvbVC20Cyo1YIXz7h/HEkQOSJ/vTC8stA5PGcL8TXJkcHUxdiTQRwnIIMr/+bNoglGS5eglvTnRFz3cpiSSFm4Tbj2k9ju0iYZPOv6pvwaZyFsGQbFMONj9+zRsMyTD2TdYTxueJ8Q2V5BZ2C1hymRadYA6VGEISd9/vCBSH814uBVPmZZeNNN3XCbU42GQ/Mn12iphZ66TLLm4IAiuMLkwbCNsns9OEZ4+sKu4Fn4k3gdMHuxnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DzVuqi032iusKKs7cbZhatXQkydXQH9us9hI2a+ct4=;
 b=k7I5LvsQIoEzgi+locLen0OO0Ms29zrI/TKNrHonz8QzAQHkNKuy8kzS/bYUOGRXyvkYtE65ukrlvR6mZ6U0xvONyFOjD6y9igqyoHZriztdr6vKy5k2mOCjMIabigEpXHSrQ7h8+gSJqF2ycs6aj21UX/501Vc32kSaaSVQZf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 14:21:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:21:26 +0000
Message-ID: <f9b9ccb5-ce78-4063-b73c-e0d92e38a94b@amd.com>
Date: Thu, 20 Mar 2025 19:51:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Shaoyun.liu" <Shaoyun.liu@amd.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
 <CADnq5_Mw834v4AkCFW6tSqwE-i1poAK+83GpKt_cvb8HaHDjRQ@mail.gmail.com>
 <878f6a71-204c-4f3b-becc-c8bb7ef80252@amd.com>
 <CADnq5_OZy000v62NFf2vQmjSy8i9-C1Am+Oh=quqOMVdQRkyhQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_OZy000v62NFf2vQmjSy8i9-C1Am+Oh=quqOMVdQRkyhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5340be13-6118-4e2d-b5de-08dd67ba7fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHNrL0E1TVlXN0dPaCtZb0lKalF4U2VVZy8wVmlzeXozenBDUCtSd3p6VExn?=
 =?utf-8?B?R1dpVkduU0ZQemtwRHhHK2c5VEV3Q1QwR2xyNDVuWEtyTGZEcUVnMW5pU2tD?=
 =?utf-8?B?OWpRaXZ6NDFURHpjS3NDb1NyWlJrN0g3ZVQyWnhpeGVUYkdyOW5YWHBmbzN3?=
 =?utf-8?B?VUxRSS9hbTZRNGxFRkpRRThVYXJ0REdvVXVzR2xBZjR4RVRyOVZrblJJbWJG?=
 =?utf-8?B?b0Q2QWFidUYvRFJFMWRwRTBBb3dGdThoUkdHTDdxL3cvZUdiMjkxVUtvOXZl?=
 =?utf-8?B?ZmRNanp0b1JoRjlmSElFN3RaMDVSWjIzZ2dTc1VhUmVsTmJiNzBMZUpYVmtO?=
 =?utf-8?B?ejgvYTlwSlNtMmJuYUNtWVVyZnJlQ1hnaHZyK2lXckI5TUh5OFV1VWhDMDlK?=
 =?utf-8?B?ZEhwUzZBN21jK2loaVRVYm5CeTlzdmJhRFNhZWtrZWEwSjZDQUV0WTliZkhD?=
 =?utf-8?B?cFEzTDdNZmZudGlGU3lOeEJhdlZVRzg5S2c0TGtJS3IzazlRU2VQRnlZQVZG?=
 =?utf-8?B?WnA3OWZ0aTBob3VzZmUxbUZtTVJpS05jbGhpakowT0c0Q0FYU014QWQ3V0tp?=
 =?utf-8?B?UUplNWd0V0JEMDJRN0hrSEM1bXg2ZW54UWptdUIzUkJsL29zN3J3V2o0SlNH?=
 =?utf-8?B?QUt6UVRzYkJHMjF3aDhnTDI3SXR0WWtUaUVjK1RRRWsrSGh6cnBGdEtZZTg1?=
 =?utf-8?B?QnlIdjk0a3JmSXNkYTlCTGhqWVdKUEgyRi96UDJPUkRiNDBCU2FaVWFVRlFa?=
 =?utf-8?B?d3JwSFdxcDZGMFY0U1BxMHpKTVluU2JrQzhCSE4xVVNYaDN3elVaSjZKVTVh?=
 =?utf-8?B?VTFCbWEvdHJRd0p5MXk3ajhoM3lWNWx4cktWM3FrMVo3L0NNUStDaDdiUHhk?=
 =?utf-8?B?Zm5qUFYvMDU5aVpJYXJGZXd3MUtIV3o1M0pDSXIrYUl4eXRpMnd5UFR5RGhG?=
 =?utf-8?B?dXQ3M0liMHN1bDQzdVpEaE5aMFN2NTkwYzRhWVJlTk1jb0tNWm1sMzVja21N?=
 =?utf-8?B?Z212dGhjZ3VaSDlSUmZ6SjJiTWxCZ2d4YWcrZHREaUZBb2pSQXpERkJPd2hG?=
 =?utf-8?B?NUlVV0JRL1FBTngwWG9sN29USzlOeFpQMkpwR2FqNEZ6T1FjYjAxMndpTnUz?=
 =?utf-8?B?ZHFRV2IrZjV0R0g5VmF5R1BoU1NUV0UxcitBdW5HVWNhdUlsTEZpZFRmajhj?=
 =?utf-8?B?YUk3SzlCR1RNWVF6WjQ5QjRIaEl0dUxRaUVRVXV6b1ZOcVJTSmRHUjBBQzJ2?=
 =?utf-8?B?Si9jZ0dyYTc1Z3NZcmVFTnBjQnNKaVJZMm5peVFXUDJESW14UjdNbXZTSWN2?=
 =?utf-8?B?ZlJKcVkxOURnUldlelk2bi8yMERCNjQzVVpnT2ljVjdMWTFFcVJkemZoa3Fw?=
 =?utf-8?B?MzBNeUlhVTNlNXVSRW1vMmpxZzlJSENnMzB2UVkxWDBiaUkzSXV4YzhhOWE3?=
 =?utf-8?B?eUw3WlhPdUhRWDBnMzVyK0QzUml3bEEyc1JtYmpGRFNlRUZYU3NLMWs0Qk9y?=
 =?utf-8?B?d1NWVTAzRFhHVUxsT0hRdUtDcytlRFp5TXdyVi9EV3gwTHZIOFBSNDhLeXFi?=
 =?utf-8?B?S1d4SjhnWnArRkx6elc1Qm9jcXZiS2FtMmp5VXQ0NTA1UUR2KzZtMGY1ejZW?=
 =?utf-8?B?QTZhZk1CL0RIOGxvVTNCWjdybEtzVDNEMUNBNjRsdlZVczg3WThhN1FKTFov?=
 =?utf-8?B?UmVyYkdyYi80MjRtSExySDhDUEJDZmJYeUFQQU9UR3ozS2t5U1E4RTI5dUd0?=
 =?utf-8?B?eVJ3V2JxcGJMS21FK1BTOXI1T04yeVJNeEdqcmJEd0tUYVNOSmVYNEJaWldq?=
 =?utf-8?B?M1pvRHBHUi9TbS9aRDcyWG9ITzVRY2VPdjJUTnpBZ3UzYnR5SW11bVVuTDc2?=
 =?utf-8?Q?K2nArel1a+Zvx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhCZllsZW1ET2wvaHZZSjU1NjdHZU53QzQrMURuK3hiMlJ2MXljNVJvTTJU?=
 =?utf-8?B?V2QyN1g3ZHZMVnA2bUtERFpEOFJld1lBM3d1RmdNOHB4UWZ3bG4zaVNmUy9y?=
 =?utf-8?B?U2FsU3g3WnhMWHlOVEdKcXF0anNIS0Rrcjd2cGRSbThsYUFYNUM2ZDMzZmxL?=
 =?utf-8?B?WW9JTmxjcE1ENHhmK2FEZlJhMzIvdndKYjZVZmxYcHpBbjA1cTdqYjNnNzBU?=
 =?utf-8?B?alJiMjJibDdjQlRzTitKTmx4Y0daREZXR2tIbTVJaXhaVW9FcEhUOE1jU3J2?=
 =?utf-8?B?Q3BKWFd2ajN4TmN5cWFpZi9STHp6VDhtcS9sZUIzbm5kY0ExMVlIQUd1Zmp2?=
 =?utf-8?B?ZDQwaUxJaW1QS1hkOUp0WGFTVzVGbXJpcDZxR1lnRjVubE04NXJnaHd3bEFF?=
 =?utf-8?B?aXZvNm5UYUZiWGpETUlvbGNjS2dCTGg4Skt5SWhOMG9pZkJrdytaQ2EzdmlU?=
 =?utf-8?B?SjB5Q3dDUEhNQVVkNVhIdXZQcXJWUTlmRWNwM2dsZWQvQkxpVEYvWjBURU1Z?=
 =?utf-8?B?NUVSaXJsQXlNYk10SHNpbDd6bFFNTHZuZmtxK0tXRDg4WWlLRkNNMHlidmNK?=
 =?utf-8?B?RnBJRW40TUVrQ0VBMVVwalprU3FtaWhZay9rMkxVajdFOWtxb0lvRjM0NDVG?=
 =?utf-8?B?SHBIVUcrK0gzVlUvYWhjYkVManhJMUNBTTFlSGNBNTdoNXJwbGxOQnZYaHNG?=
 =?utf-8?B?WllLUkNGNk1IVVlKQ0E1T1lCTyt0UENWTmNHWGdYTXRYUGZsUjhKUmh3UmNn?=
 =?utf-8?B?WnRUV1RpSkkxb29uL0tJRkNMVEdKQ3k0S0lvWjFteE1IMTJuNzluTlREdFI4?=
 =?utf-8?B?M1o0SzNKL1kzVUJxaUZndldIOFNmL3RKS1JOdFRuL3B1UkJFMDdaaVp5LzhN?=
 =?utf-8?B?RjRrQ0VpRVM5QTk3OXJkM0dQWWk4c1lEV1ZvYUdDV1R4cllSSlNIR09wZUQr?=
 =?utf-8?B?OVB1T3hVM3oyNzh2YzFWWWJPV29HUmUwelg4bTEwLzFVT1dHQXF4a1hMTFJB?=
 =?utf-8?B?RXNOdTlvOTJXaUlsRlNPMnVkZHppQWVlRCs2UE9uRUd6Rk1JbDgyUjZNSE8w?=
 =?utf-8?B?MEVtc1JOT0FLZ3g1aTJiVDhNamVwY1gxamxWRjZoMFQ0ZGdKUHMvRHRTejg1?=
 =?utf-8?B?MElTendURy85aUN6QSs5S01OdDhYWldudDNEb2VubjM1VVd6VDRWaFJWcDEz?=
 =?utf-8?B?VHlxZG1FN2NTTXNQc0U1UDhuSFE5ZkxBbzJNcERPTmoxaVRxWDRkN0NqbHJG?=
 =?utf-8?B?aytwQjBibnBxWFFKR0l1dm00WjY0S2xTZGphZTltRU5BTUlXSDhqZGJlZXph?=
 =?utf-8?B?VjJlRmFTUHdJT3MvQ0syNlpUWEFMQ1RxU0VEZlNMZHVxUE5CWkpLUng1aGg0?=
 =?utf-8?B?dTNRbmxMNzBNN0Y4UWJEMGV5YW1NVW5zdVhWYU5wZ0QyTW5jRDExaTUxV2Js?=
 =?utf-8?B?N3JSWFkxY3RRajFudW1iaWcvM3FiNUlITlRMcTh1QUx6cjFScGdNVCt1ZThj?=
 =?utf-8?B?eE0vQWpvclh3VkV6SVBHTlJMMmFBa3pqMDFaNjFEUDlQR2xlcDJqM3VBV2Vh?=
 =?utf-8?B?TmhjR1FFejZjdHU2Ykx0MDRDR3pyYXJ1cFlIdXZQdTlkaW5hRGk2ZForU2Fn?=
 =?utf-8?B?ejRIK0VZWWlWNlluWnhNNXJObzRZa1dYbWhqN2c2R0FVUzBzcnlLRGsrYU9m?=
 =?utf-8?B?VnUvalI5L3B1aWw4dkdIVjdZSWVma3NPVlljUFVNN0o4TUtjQ2R2ekR4Skll?=
 =?utf-8?B?WC9FSDY0WElWQkZFTDJtaVZvc2pMNXc2WGVCZFVFZGJFa1RuZ05ncnNGYUR0?=
 =?utf-8?B?NkFlQXpxc1FMK2p5UlN3bldBYVJGQjZXUmZ1M0M4cDdBL29PUEl0RnBNTFRr?=
 =?utf-8?B?alJaWGF4ZHlIMnhvL1JGUStvNkFRRTYxTVQvYUVEc0tjVDIwenlXZkNMOEFE?=
 =?utf-8?B?YUFJc2s3YmpaLzJYMkhsYjl5SER4VWw3V1c4NFpERVZldllkcUs3dWZ6MkF6?=
 =?utf-8?B?ZjM5VEMrUklUNjk2VWVIYWtBSDVSRWlXZnJ0Sm1ONklReSs5dFh3ZURoKzNC?=
 =?utf-8?B?aHhJN2ZLYVhya0ZHbWxGdWdpdDlOclVtRGg4cEw3SGNGcHFtMkdqRXRhSWZR?=
 =?utf-8?Q?kLRyMaUD14QDk+/230bGI7Jke?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5340be13-6118-4e2d-b5de-08dd67ba7fc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:21:26.6354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFidu26Uxq5WzsM9t/Fv9prf9rGk9No8f+yYpn1jfmIc5fke3EjofyPuU6b8QuuQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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



On 3/20/2025 7:23 PM, Alex Deucher wrote:
> On Thu, Mar 20, 2025 at 9:44 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 3/20/2025 6:21 PM, Alex Deucher wrote:
>>> On Thu, Mar 20, 2025 at 7:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/20/2025 12:38 AM, Alex Deucher wrote:
>>>>> Break when we get to the end of the supported pipes
>>>>> rather than continuing the loop.
>>>>>
>>>>> Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> index 3b83880f9e2cc..10f14bf925778 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> @@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>>>       for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>>>>
>>>> Unless I'm not seeing something, why not just keep it i <
>>>> adev->gfx.mec.num_pipe_per_mec?
>>>
>>> AMDGPU_MES_MAX_COMPUTE_PIPES Is the size of the array and I think it
>>> is aligned to the max supported by the firmware, so if we had
>>> num_pipe_per_mec larger than that for some reason this would prevent
>>> an overflow.
>>>
>>
>> I think it should be kept the other way and array size should be fixed,
>> otherwise it hides a real problem.
> 
> How about a dev_warn when we break out of the loop?  If we see that,
> we can fix the array size or figure out why it's too large.
> 

Yes, that will do.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>               /* use only 1st MEC pipes */
>>>>>               if (i >= adev->gfx.mec.num_pipe_per_mec)
>>>>> -                     continue;
>>>>> +                     break;
>>>>>               adev->mes.compute_hqd_mask[i] = 0xc;
>>>>>       }
>>>>>
>>>>
>>

