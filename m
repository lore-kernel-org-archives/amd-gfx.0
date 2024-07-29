Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9317FC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 05:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3545210E099;
	Mon, 29 Jul 2024 05:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYDKhdd7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9262010E099
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 05:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+bf9pSuKWY9mgoydC0zt5nSedzPkBDcbICHIVOffk6mi5P956oFljx/Dp8/5oFqWD3uMOqgohSCiVDt2OAbLMQpsk/ah/XIUOWeJadNQUEpGocgCL13D0qZzKGBAE36XjPvy/H5c0dTmwy5PqFzlxa2/jRmX+3rgKr2BNDUKDO50fkVu7XYDIHOUHZuvVU1ZVwW8U5w+feciQW2mdF7Sxd0YqR5vILJg4cLIjweZcxEgy2lD2JWvNHNeEEEwiBwFNcdN3h4XiMSuaSuZLxCRJa7IurOR73fsz7DzWhoSsyAu5b/Z5QRV1HbO/yruykJ6Db0hzaC7B2+9dyiCtBIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUxoRc2V5VWqJ8P8arlYepNupkjjh+gLJ7xxuIeszqM=;
 b=kdogT57TbmuCtjoSsukn/uGmZ2UDGUzrTpxwQRLNb1qiJyxwSl8l84GGDjfQFNsdsdDF/CTd+VF5ceGVD4EZZLdf2CrHEsW37Re1oMQpNptkWi7qBB2RduA3VOPeNoxB3yeukzSb+aet2UPZV3PfSety3YAxU1eWrf5TJ0jrIxuhbtm0DWtm592Ss/d9evfMvDWy8JeZFEGGmBjvgTISkbbxy76toXZ2sqqtKNA+RwuwVHk+c6PQbQghZSBJOSPp6qwzUoQ6bBGYLC1jxSI+4VoHinUEpy00uN3z2/CS1vn9LkBaDncXBvdLx7yQLm3P8LiqF7gEDe/yZeAyWyam8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUxoRc2V5VWqJ8P8arlYepNupkjjh+gLJ7xxuIeszqM=;
 b=tYDKhdd7aNnVOFa7cGdu0jZKMVOIdDYQ2MJoAKYQ8sTFjpue552jHw/uUaUG+PI9JrKCLrk2/pEUlwg5p1VWhoDEi7sBtYHP78u/6955P6NhKXDyYYPWQAp+vZ9AhWdTmI6ArJ/WIDdQlQh6E/HsXHTk9HibsxCmfr84P6nDEMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.24; Mon, 29 Jul 2024 05:47:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 05:47:13 +0000
Message-ID: <5ead684a-e70d-4388-ac45-c59995eb8161@amd.com>
Date: Mon, 29 Jul 2024 11:17:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
To: "Khatri, Sunil" <sukhatri@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
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
 <5d3f962c-6efc-4aee-99ac-5dc48c43235f@amd.com>
 <a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com>
 <16cfb6c9-c2de-4d19-909e-f06df27c78a6@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <16cfb6c9-c2de-4d19-909e-f06df27c78a6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 137b454e-4085-457a-53a3-08dcaf91e501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTg5RjdtanhESnRiYVV3R2RsRVNNaC9PTWduNTZWbTA1TFZXYXF5bGgzRDJL?=
 =?utf-8?B?QXlTenFPcEphSUtRQUI1NS92R1N4eENST2VOblpmT2g1cFdlREVVVWtsRVk2?=
 =?utf-8?B?ZCtTb0d5MHRRaXlIdW1uRnNKMHRDNmF1dlBDSUNuRHVFcHZEK2t3ZE1VdlV4?=
 =?utf-8?B?UlcwQUlrWXFHeGIrNCttYXZlUEtGeXNzdGIxTVlGL3NveWZCMnQxd21VWjhD?=
 =?utf-8?B?c3BHMkJKNmZzeXBRUFBpQUVhUE93d043QUJFUGFleW0wYjVjV3ZkbnNTYUhL?=
 =?utf-8?B?dWpqbHB1K3pqQXBGMnJZTnhEOHU5Q0J2SmxMSG9GNWV4MUptaS82enVWOWY1?=
 =?utf-8?B?L3BndlZxUkc5VVgzRWlWa2RyeWtFRktybjVhOTBZVkpJcjhVL3lEUkNaZ04r?=
 =?utf-8?B?cno0QzRlRUJGeHZCWUdxQ1QwUWk1L1lURUNXNE5yV3EwWlNmLzI5RDAxc3Vu?=
 =?utf-8?B?MTdaMjdjNFVGaFhtMEFhdjRWNXUzTmM5Q3g5dWJZbmM5a2dsVE0vRDdhRHRN?=
 =?utf-8?B?eG03VDBkOVE4dGV2VU4yVWJtbmE4WE9KaWdrbGR0UTdYdGFwYXpkQ212RXdF?=
 =?utf-8?B?MXBsRFkvN0pCUUFaRGZnTElkNWI5azlUZ2d2UXd0b1pJWmJwU0dJVWU4aU8x?=
 =?utf-8?B?NmV2enVLMEpGeGdsVlhlWU5lZ2swZFdzUldUZktET0FXa2x6ZDBWck5KMkJm?=
 =?utf-8?B?RlVMa2lLSjhtYnJNMDZvbUg5TU0rSVdiR2x0Q2ZSMmtKZ1Zmdlhrc3JhTWMw?=
 =?utf-8?B?MUhhUDRMOW55eXAxRWtDd1h1dHp3V0hnanBxMGpuOFBHNDJTbTVkbHFaWDkx?=
 =?utf-8?B?TW5GMkNTZUtzbXZTajI5K29FTm1HaUFqSS9NMHhkRU5qU2tZMFJsY0xzZnlC?=
 =?utf-8?B?cy9YemN2M3RWdm5oWTdmSVpsSFR0eStkYTZwL1J0cWJITGVoVUY4Wk5peVMv?=
 =?utf-8?B?amU0aXh1MDN4QTNrOTVqYk55bFM1S2xVcTBHb0dsalN1ZjFMMGVybWRMb1Fi?=
 =?utf-8?B?VnRTL0NpQ2xsdVAyZnVpcHlXNmwwTEFvNmNRQ0RlRWl5NFhCRU1wUjB5QjRn?=
 =?utf-8?B?MlVKUjJFNUMvbkwyeE5Zb1BDbWFFNUl4TzlkWHU3aG4vQVdHS0h6V2twdE5s?=
 =?utf-8?B?YWZtWHZoNjdVTlB1bldQTVo5M29vUEpidkFiZmZmZEljdVJxV0hWalA5VVJi?=
 =?utf-8?B?eHhCeEgvdnhmMk5VOWVXT0J0MWpYaFhYbS9BU2h4RlZsclhSZmVWamx3N1Q1?=
 =?utf-8?B?dkoyMXBkT0t1aDV2Q3VmbGYxUU8vNEdrUTRtVzRLeUUwMndNQWFTZXJuUWtr?=
 =?utf-8?B?YjVKZ2RrZjBkWkE1N3NoTkRvSFRiYW1DR0hLaXFvTEhWVVZkMlJzdFBrMDlQ?=
 =?utf-8?B?N3JNRXVVNlIrQkVIc3JzRVo3anB2RS9JaGZDZVpOaXNBYUd3R3kydHR3ZjRH?=
 =?utf-8?B?UW1BaFZGa0JwMHhTbGJpckE0MnhZYks5Vm1XVURrajRZTWh0TmpQcUtSaWxv?=
 =?utf-8?B?QmFreWlPbk5EbnpENmN1aG9DaHJ3SjM1Wnc5bVRZT0ZrRmlRbEp2K2NUdUx4?=
 =?utf-8?B?RGFaN0hDdlYxZDMyYUU4LzQ2Q0V0YUlqNVVXaGZaNGFZdjcxOTZ5VXBBK1gr?=
 =?utf-8?B?NDBqWVFTMnE1Um40RU1Iek9QRWpoL1UyUUszTWtpczFlRzJoL05veVRWaDlj?=
 =?utf-8?B?SnV4RmpVNDJiSUI1TnhiNWkrS0pPbnRnQ3ZpVlhLOXRsTWU3NWhvdmh3Qkc3?=
 =?utf-8?B?Nko5QjNrWmdrYVphQXZ1MzI4eFB2YVJlNkU1V3RZeWZsWTR4QWUrYk9pdDAw?=
 =?utf-8?B?akFBZUdwRWp3ay9JSnB6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ZySEtkKzQxekVHdVVkV0hySTAramVtd1VMem8rR2ExeElLSmphZDRrdkRa?=
 =?utf-8?B?YmExWkpLNTRzTUF0ZmtIaHRteHVZSE1hL2hHRnlnUjJJcjVoaVR2MlROK0p4?=
 =?utf-8?B?bzlQVE1DR0VYSVh3d21tZk1Na29CRE5TcTI4ZVNqTHM2NkFPbXRvZVFDcmZB?=
 =?utf-8?B?UVB2MFNXbU1ERDlJZU1LdjJjZWI1Vis4Q0ZUbTg0VHFwR3dmL0FRaGJmWG1o?=
 =?utf-8?B?U01tU2hHNjNKb0lNcjhnN0NDTUQrZTZtTHVNOHFha2JTQ3M1Q3BYK3BRem1U?=
 =?utf-8?B?NXF6VGU2K2ZXSmE2U2JqYnVWUTNOQjRpMDR1djcvQnNyb1Q1OXhuSVM2UUVx?=
 =?utf-8?B?dHhrVmRoQkJqUFNXcXdsV240cGx0SWoyYTEvR3c3a1FwNXh0eHpKL1BLN3BN?=
 =?utf-8?B?Z1MwRFBRNDVucDBmQlhicXJHbEczQ2UvaVE2cWZBZ0RHaFRMNTlvL2luM1Vn?=
 =?utf-8?B?bzdORGZpVjFuZ1U1VGgwVUYyWDhyOHdSUTNmS1lQdytSU0Y3aUV4azdCdHlo?=
 =?utf-8?B?K3Z2ZzNoNjduWjBSVzY0SHgxVWlrcTlRU3M5SGRTcU1wa3BYU1NKT2ZUTW1G?=
 =?utf-8?B?QXZLRXFMRHFsdzBoTHY3ZmdkZmRzS0RQbXUwRUFTbk54ek9sSXFVYUtaNmtr?=
 =?utf-8?B?cElZZWpLQm1MY1hGRjkrQ0g5a0dMTUdlVEtUY1A3K0VKekNIZWxDL1IyQzlD?=
 =?utf-8?B?anV6ak5vazJKLzJubGR4NTVQOVpZU2Y2V2E2WG1PVGtPRjFpUWlPdVF3Z0ly?=
 =?utf-8?B?ZzdmeUs5bFM2RGZKVlgwRDQrNmt5Y01leHZZSFNnRUJrY21CcHF4RUc3c2lU?=
 =?utf-8?B?bFJzTEFjLzZQRzdrVEVvdUZtck4vWkE3ZWVLdS81d01GSFh6dGVacW9lRXhz?=
 =?utf-8?B?ZzJXTHlwZVQxVnRkb1VLU2tJMkVoZDFTekZ3YlN5dS9oSzhuVnRQNTlBNlBD?=
 =?utf-8?B?V0RPaDc5aGcwWk5YTDlDMkE5aGdta2JrSzVnbzg5ZDRKbWZUclBwQ0g5Y2dR?=
 =?utf-8?B?aTA2L1p5OTc4ditsaURlZnBEVlVCeHNGaThqOVVLVElCS0VLbkd6Wk9EczY2?=
 =?utf-8?B?ZUZIcThVd2k4cWJNWGc2SFBTWXJJaU80WGZzUnhXcnZsVFVRVElIQVA4SnVZ?=
 =?utf-8?B?Mk5HUElXMDFTckxndlNvcC8yVHVNYjBTcXNjelQrOHM4SDJPbldRL3lNanZU?=
 =?utf-8?B?K0c4eFZnd3RKSkhKWjNvcEl3clpubXVKcGtDQmlIRllnUTdlSWpud3lxVmpN?=
 =?utf-8?B?eDJzZnN1Wjc5S2VEK0oyMG5MZTF6TWpxS24wU0wxRXhtdTRIdHhJVHBFNHIw?=
 =?utf-8?B?cGM5Y0tPdVhPdWVZY3JlQ3BZRndlYVFvTnlzcmZoVGZ2aU9WTU5oVHprQWY4?=
 =?utf-8?B?N0lML3Z0clhHMGQvYmpjdnpvVHBHL1RUQmh5eEY5T3M4QWN5VEZSRjd1bXBM?=
 =?utf-8?B?djFscHVkeDVTbE1zbDREM1pWVmZ4QStkU1FxSWd0b2hHaUtlakZ2bkZubDha?=
 =?utf-8?B?TitkTWhNdWJaT0hNUHNCUE1OK0JUYjIvYnlXQ202L3NnUlJEbDBhWFdGSG9C?=
 =?utf-8?B?REl4RnF2UFMyY0ttYmErc3ljQml6a0E4UXE4TytPTkx5cTNxbGszdkE4ZFo2?=
 =?utf-8?B?TEpXRmlBTVZuRzI4RklTcWYxK0VzUGVpcE9qTEYxOFd2WXAwMmxzUE5CTTBH?=
 =?utf-8?B?RDVEQ1hGREdKSVJ1UC9kV2JZRUFCY1RYMjhLaldMY2ZWYWxteEU0cW41dVA1?=
 =?utf-8?B?VWxTTEZSa2dZdGY2QlNJTEVjWHYvazlGWGJCcVh3Rnlvd3V0eUVRRW9nTXJ2?=
 =?utf-8?B?b1pDU1hzc3VaRUhJRzEyOGNkcGtPaUF1N1o4MVB6MmFqY2IwbVRDSWYvaFA1?=
 =?utf-8?B?dzQ4bUp3L2QrOHhBM0hqNDl0Smoxa2Q4VllZeW5VU0Z2ZXhjY29iUU10MkVs?=
 =?utf-8?B?bWhlSVFpdk9xWURieCtEMG5ORmp0U2N2QTRKVE9BN05tRkRwOFVYZWV1Qm9W?=
 =?utf-8?B?Y2NGOTYwNWtqSU5LM0VGdSszc2xKWldOclRWSmNvWUd2RExwczZKM29SeGh1?=
 =?utf-8?B?SFpHcEJpT1Z1MjFmRmZ6VXpWc3NiaEtYM05xUGF4Q1lyRm5nSURyeGcxcDY1?=
 =?utf-8?Q?6TISdWK1hliUz8LH0ksH+/JPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137b454e-4085-457a-53a3-08dcaf91e501
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 05:47:13.0309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+Xkfr10kLNXrRkLNp4sh4IlnEO0vcyYe6wYAiHjvG/Z+ytFmKKGs/RrwsW6DJDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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



On 7/29/2024 11:08 AM, Khatri, Sunil wrote:
> 
> On 7/29/2024 10:08 AM, Lazar, Lijo wrote:
>> On 7/27/2024 12:51 AM, Khatri, Sunil wrote:
>>> On 7/27/2024 12:13 AM, Alex Deucher wrote:
>>>> On Fri, Jul 26, 2024 at 1:16 PM Khatri, Sunil <sukhatri@amd.com> wrote:
>>>>> On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
>>>>>> On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
>>>>>>> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>>>>>>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>>>>>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>>>>>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>>>> wrote:
>>>>>>>>>>> Problem:
>>>>>>>>>>> IP dump right now is done post suspend of
>>>>>>>>>>> all IP's which for some IP's could change power
>>>>>>>>>>> state and software state too which we do not want
>>>>>>>>>>> to reflect in the dump as it might not be same at
>>>>>>>>>>> the time of hang.
>>>>>>>>>>>
>>>>>>>>>>> Solution:
>>>>>>>>>>> IP should be dumped as close to the HW state when
>>>>>>>>>>> the GPU was in hung state without trying to reinitialize
>>>>>>>>>>> any resource.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>>>>>>>> +++++++++++-----------
>>>>>>>>>>>     1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>            return ret;
>>>>>>>>>>>     }
>>>>>>>>>>>
>>>>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>>>> +{
>>>>>>>>>>> +       int i;
>>>>>>>>>>> +
>>>>>>>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>>>> +
>>>>>>>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>>>> +
>>>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>>> A suspend also involves power/clock ungate. When reg dump is moved
>>>>>>>>> earlier, I'm not sure if this read works for all. If it's left to
>>>>>>>>> individual IP call backs, they could just do the same or better
>>>>>>>>> to move
>>>>>>>>> these up before a dump.
>>>>>>>> Suspend also put the status.hw = false and each IP in their
>>>>>>>> respective
>>>>>>>> suspend state which i feel does change the state of the HW.
>>>>>>>> To get the correct snapshot of the GPU register we should not be
>>>>>>>> fiddling with the HW IP at least till we capture the dump and that is
>>>>>>>> the intention behind the change.
>>>>>>>>
>>>>>>>> Do you think there is a problem in this approach?
>>>>>>>>>            amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>>>>            amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>>> Adding this does sounds better to enable just before we dump the
>>>>>>>> registers but i am not very sure if ungating would be clean here or
>>>>>>>> not. i Could try quickly adding these two calls just before dump.
>>>>>>>>
>>>>>>>> All i am worried if it does change some register reflecting the
>>>>>>>> original state of registers at dump.
>>>>>>>>
>>>>>> I was thinking that if it includes some GFX regs and the hang happened
>>>>>> because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
>>>>> For GFX and SDMA hangs we make sure to disable GFXOFF before so for
>>>>> those IP's
>>>>> I am not worried and also based on my testing on NAVI22 for GPU hang
>>>>> their registers
>>>>> seems to be read cleanly.
>>>>> Another point that i was thinking is after a GPU hang no where till the
>>>>> point of dump
>>>>> any registers are touched and that is what we need considering we are
>>>>> able to read the registers.
>>>>>
>>>>> For VCN there is dynamic gating which is controlled by the FW if i am
>>>>> not wrong which makes the VCN
>>>>> off and registers cant be read. Only in case of VCN hang i am assuming
>>>>> due to a Job pending VCN should be in power ON
>>>>> state and out intent of reading the registers should work fine. Sadly i
>>>>> am unable to validate it as there arent any test readily
>>>>> available to hang VCN.
>>>> We want to take the register dump as early as possible in the reset
>>>> sequence, ideally before any of the hw gets touched as part of the
>>>> reset sequence.  Otherwise, the dump is not going to be useful.
>>>>
>>>> Alex
>>> Sure Alex. I am also of the same view that we dont want to change any
>>> power status of any IP as it could change the values.
>> There is a debugfs interface 'amdgpu_reset_dump_register_list_write' tp
>> add registers to reset_info.reset_dump_reg_list. Presently there is no
>> check about which registers are added to that list. For ex: if user has
>> added some GFX related registers, this is going to hang while in GFXOFF
>> as ip dump state comes later.
>>
> this isnt being used and i will clean it up. its original intent was to
> for dump only which we based on all conditions are taking care. So this
> needs clean up and i will check on it.
> 

Right, that's why I asked before whether this generic dump is really
required - "since there is already dump_ip state which could capture IP
regs separately and handle their power/clock gate situations, do you
think this generic one is still needed?"

>> Also, all IPs don't handle dynamic wakeup; therefore, regardless of a
>> reset scenario, direct access to powergated IPs could result in a hang
>> and that will make things worse.
> 
> Before dumping any IP we are taking care of Power status of the IP so we
> should be fine. Like for GFX, SDMA we make sure GFXOFF is disabled. VCN
> we are dumping only if its power is shown as ON and like wise it will be
> done for other IPs too.
> 

Yes, it's better to handle at IP level itself and remove the generic
interface. If the IP that is hung is known, it's likely that there is no
need to power ungate as the IP could be in some sort of busy state.
Also, there may not be any response to further operations from that IP.

Thanks,
Lijo

> Regards
> 
> Sunil Khatri
> 
>> Thanks,
>> Lijo
>>
>>> Regards
>>> Sunil Khatri
>>>
>>>>>> BTW, since there is already dump_ip state which could capture IP regs
>>>>>> separately and handle their power/clock gate situations, do you think
>>>>>> this generic one is still needed?
>>>>>>
>>>>>> For whatever we have implemented till now seems to work fine in case
>>>>>> of GPU hang withotu fidling the
>>>>>> power state explicitly. But Calling suspend of each IP surely seems
>>>>>> to change some state in IPs and SW state too.
>>>>>> So i think until we experience a real problem we should go without
>>>>>> the generic UNGATE call for all IP's
>>>>>>
>>>>>> But i am not an expert of power, so whatever you suggest would make
>>>>>> more sense for the driver.
>>>>> Regards
>>>>> Sunil Khatri
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>> What u suggest ?
>>>>>>>> Regards
>>>>>>>> Sunil
>>>>>>> I quickly validated on Navi22 by adding below call just before we dump
>>>>>>> registers
>>>>>>> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>>>>
>>>>>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>>>
>>>>>>>       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>       /* Trigger ip dump before we reset the asic */
>>>>>>>       for(i=0; i<tmp_adev->num_ip_blocks; i++)
>>>>>>>           if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>               tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>                                       (void*)tmp_adev);
>>>>>>>       dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>>>>>> }
>>>>>>> If this sounds fine with you i am update that. Regards Sunil Khatri
>>>>>>>>> Thanks,
>>>>>>>>> Lijo
>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +
>>>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>>>> +
>>>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>>>> +       }
>>>>>>>>>>> +
>>>>>>>>>>> +       return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>     int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>>>>>>>                                     struct amdgpu_reset_context
>>>>>>>>>>> *reset_context)
>>>>>>>>>>>     {
>>>>>>>>>>>            int i, r = 0;
>>>>>>>>>>>            struct amdgpu_job *job = NULL;
>>>>>>>>>>> +       struct amdgpu_device *tmp_adev =
>>>>>>>>>>> reset_context->reset_req_dev;
>>>>>>>>>>>            bool need_full_reset =
>>>>>>>>>>>                    test_bit(AMDGPU_NEED_FULL_RESET,
>>>>>>>>>>> &reset_context->flags);
>>>>>>>>>>>
>>>>>>>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>                            }
>>>>>>>>>>>                    }
>>>>>>>>>>>
>>>>>>>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>>>> &reset_context->flags)) {
>>>>>>>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>>> +
>>>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP
>>>>>>>>>>> State\n");
>>>>>>>>>>> +                       /* Trigger ip dump before we reset the
>>>>>>>>>>> asic */
>>>>>>>>>>> +                       for (i = 0; i <
>>>>>>>>>>> tmp_adev->num_ip_blocks; i++)
>>>>>>>>>>> +                               if
>>>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>>>> +
>>>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>>>>> +                                                       (void
>>>>>>>>>>> *)tmp_adev);
>>>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>>>> Completed\n");
>>>>>>>>>>> +               }
>>>>>>>>>>> +
>>>>>>>>>>>                    if (need_full_reset)
>>>>>>>>>>>                            r = amdgpu_device_ip_suspend(adev);
>>>>>>>>>>>                    if (need_full_reset)
>>>>>>>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>            return r;
>>>>>>>>>>>     }
>>>>>>>>>>>
>>>>>>>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>>>> -{
>>>>>>>>>>> -       int i;
>>>>>>>>>>> -
>>>>>>>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>>>> -
>>>>>>>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>>>> -
>>>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>>>>> -
>>>>>>>>>>> -
>>>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>>>> -
>>>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>>>> -       }
>>>>>>>>>>> -
>>>>>>>>>>> -       return 0;
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>>     int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>>>>                             struct amdgpu_reset_context
>>>>>>>>>>> *reset_context)
>>>>>>>>>>>     {
>>>>>>>>>>>            struct amdgpu_device *tmp_adev = NULL;
>>>>>>>>>>>            bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>>>>>>>            int r = 0;
>>>>>>>>>>> -       uint32_t i;
>>>>>>>>>>>
>>>>>>>>>>>            /* Try reset handler method first */
>>>>>>>>>>>            tmp_adev = list_first_entry(device_list_handle, struct
>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>>                                        reset_list);
>>>>>>>>>>>
>>>>>>>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>>>> &reset_context->flags)) {
>>>>>>>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>>>> -
>>>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>>>>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>>>>>>> -                       if
>>>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>>>> -                              
>>>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs
>>>>>>>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>>>> Completed\n");
>>>>>>>>>>> -       }
>>>>>>>>>>> -
>>>>>>>>>>>            reset_context->reset_device_list = device_list_handle;
>>>>>>>>>>>            r = amdgpu_reset_perform_reset(tmp_adev,
>>>>>>>>>>> reset_context);
>>>>>>>>>>>            /* If reset handler not implemented, continue;
>>>>>>>>>>> otherwise
>>>>>>>>>>> return */
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.34.1
>>>>>>>>>>>
