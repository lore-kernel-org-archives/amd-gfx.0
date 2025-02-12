Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09ECC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 14:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7F810E8C7;
	Wed, 12 Feb 2025 14:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Th2haFAN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E67710E8C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 14:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkQulMMsh2tTxnDdnMA09cEQNETFRnn+qDSfg7ueaKQERjXaPVZBmQHPHqsOgqzReRQ8ASFaaduj6Tb1COPRt3prp5TmuHKAdnUJTy1TSZsUqt234HusDTQmW+/2mmldq/rQJYJ6QZoH4vZQDKpONPFVtYWhQx7kQTDAkGuLm/1SwZjvaYqZD83WZlnB+AQg6abh/p91gXqcAMHzQwsVpoYoLHw7ZugrHqy1heXq3/a7wT46KtUc8t2b2zObk2KAxqNJDbTrKUTIPIP9Ym6VeLbadixi4qSoMHb7GihVTX7rJTFAciGsq1GP+ORdbsWseQPY4/yQ/hkiBIMsXfNmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmvOrkqRTiq0srmP+14GiDzogVETw2HPZK95soMuG+s=;
 b=n7MN8v3KiAncoQVVcbkSXUpt60t8jn7v612CenBxQDZQtOcEminF5MIneH+oYC4vn/QA70LktVaPIK12KnoFVPFdBw1nR1qpEnsF7rk5IgJjjP39hpp0i9oKInTqkUzExVJo2kDOnHrt+pCFa3OnXR7MlEtkVySb9Q1/Z4j+wREG5L73UqqBHSTtf2Lq7uXvXHEtb7aBll87b3H/CzvE0YuCesvZHNa8VCkAFL2wpRDebw0BprBnj/E9wDX3rHzMkx41lohPI8gAyVJ+v2KJqc3J/MAj0hFR24cw405cmIAv9hc9qrbT8dj3UQ/u+LTXEwKPET1ajhint2z9WzyHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmvOrkqRTiq0srmP+14GiDzogVETw2HPZK95soMuG+s=;
 b=Th2haFANnqWDXF9rkCGlEsaMTbnzUDSK8lY7mS5fytezGbo9VKRuowOesUB8JP2qTw2vVMKpgbE+b9dLmjT+ECXfI+uggyOK0GIkoE03Bbe3DMSbxDEqtiVEBZnebZnxxhCurXyvJ71MxS3tWT0XC867ply1h5Okt060ROmkfCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 14:31:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 14:31:05 +0000
Message-ID: <3ca698e1-dda5-4e82-65af-68d8b15dcd54@amd.com>
Date: Wed, 12 Feb 2025 09:31:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250207102823.1565467-1-Emily.Deng@amd.com>
 <PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com>
 <841a21b8-b0b6-48a9-af2d-62b51d5d6a1b@amd.com>
 <PH0PR12MB54174DCAA0C2AF44C320C1098FF22@PH0PR12MB5417.namprd12.prod.outlook.com>
 <6c888bc6-a942-b608-3302-4c37374f76f8@amd.com>
 <CO6PR12MB54117113A866F8DC26466CAE8FFD2@CO6PR12MB5411.namprd12.prod.outlook.com>
 <PH0PR12MB541766DE7BC6B2960F79ED908FFD2@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB54172210D0A892CC1A8FB5BD8FFC2@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB54172210D0A892CC1A8FB5BD8FFC2@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0416a9-6c72-4f61-90d2-08dd4b71e23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RSttSWMzSzZ5c1kzNEpiOVlyMGhMbU56SmlVSWEvdVYxZDYrYXhsMTVkS0Vu?=
 =?utf-8?B?b3VPY2JJVWJwc3FnRWdNK3BZajEwaDk5aGhWMGtGZG5qZXM1Y3VkeTdQSFhM?=
 =?utf-8?B?aUR5dVhSOWh4RlMyZmZFTkZDUWpoUUYzdWUxcUdaS3FDQ3NHZVFlRlV5cTcr?=
 =?utf-8?B?Y2dCK0ZaWjMyQ2ZEU1gxR3pWc25DWXRwR0NtYjJ5NkRkQ2lNRnR5TUhhZENW?=
 =?utf-8?B?c1E0cHJTaHh2TEYvYUhVWTNzTGlLNVBDQmN4c1NKZjl4RkRLZHZjWUtnaGFl?=
 =?utf-8?B?dk9CVXNzblpidnhrc1ppbWxrb1M1VEpza3hyZDVEM1o0c3pBSmUrenN3bFA3?=
 =?utf-8?B?T0JlUC9nK2NzQUZvdHdRcVJsY2dFWndaeTBOdVAxcDFrbUZhaStUUDFDb0U3?=
 =?utf-8?B?TDc3VFk5eFhuY0lVanRPakNhMFRIcmVDekpXNndwdEp2Z1BvcDZkUVI2Tm9M?=
 =?utf-8?B?eklSTitVUGQrZUdRaHNlUEVNMjN1UHR5SVJFaWxIMWpnR21vemV1NHhYRVVj?=
 =?utf-8?B?NHQ5MU5xMm05cCtBYUoybEpKM210WXZzUWp2RFJNeitiWFJkbUFlYlpVWlBs?=
 =?utf-8?B?ZVJpOWZoSHg1a2VDNy9Gd0hGOTM0cHByaVBkSVZIZGpCaWdhWEdQY2Y0N2sr?=
 =?utf-8?B?Qm4vaWJiVmxUSUZLU0UxVDZHQktmNWVqL0JienliLzcrMEs0NExnTlNpNTdz?=
 =?utf-8?B?Q3hnOUlSTVlXRGtOTWRlSXJ4empVTTlsbWxVd3pucTdaMEJVZ2NmeVJQbnlr?=
 =?utf-8?B?N285aFE2M24zS2xzR0ZIa1pVNFNvcVVhOXdKSWJrYktBa0MyditZbzBFZy9x?=
 =?utf-8?B?N1BDdlJUeGVGdU94UGlsTDNidyt2dmxWSlA2OVB3UmZxRGh3dExzNms0Q01Q?=
 =?utf-8?B?aWozMVBZdlg1Y3JYL3VWVXljUXNoSGptUGRLa3hhYkt1R2g4d1YyR1VIMWdw?=
 =?utf-8?B?VzBHNmMvN1l6QU9xMHlFYWw5bFZNZzIxb2RRU0txQ1BDaUUveG5DOGQrUWpm?=
 =?utf-8?B?U28xaElTNW9hWE5aY2pGS1NlN0xYY3NWNGlXcldoZVdwUWZKY2FGMCtBa0J1?=
 =?utf-8?B?Nkp6YXdwUXRqbXpHUyt2TUdIR1lreWh5bldUdlpURms4T1U3NDAzclkrMXhi?=
 =?utf-8?B?UG9BZkZzUmdKSnBLZjFxcnQ1dGd3aFM4NCtYYmRvTSs3MjFUMTlYQlBDRnQx?=
 =?utf-8?B?UlZ5Z2dvNlR2dVYxVzFnWFdQS2lhUjM1VmZ2NmQ4aUxzeCt1OUlKRjVqeVow?=
 =?utf-8?B?TStzU3FWcGl4YUNjbGtWUmVFUFNhM2hzZU9MMXZReVorUGMxTHd2QnZKcTA4?=
 =?utf-8?B?MHNNZmZKTFlNdms0M3hFTzFwaVVlNUF4ZjhDQWF2WDJTb2RRUzByR1I5Y2FJ?=
 =?utf-8?B?dXpYTEgvcFZWYmliUkJHQmZ2WUZwLzFoTzJXUmpnTEdpZWF2ZVBrd1hMUTRn?=
 =?utf-8?B?QzZYTEg0RDJFcmV1NTcrak9LaW1ZcEx5ejVHVW5CZlplNmxERVFzNVdzOUVG?=
 =?utf-8?B?aU9EdlJnTUgrdlFvSjhQd1M4MkZqdTRVc0FIaG1SZjIzUkVIUnJBdmRBMzJo?=
 =?utf-8?B?U1lvREVUaGhYNjd0UHVKc2w2bSt1WUNDRGM4WnBhYlpkWVBiSjJKTFVVWTN6?=
 =?utf-8?B?U0dkMm1CVjV2emxNN25PSmRHeUF4WG1HMkhEb2tpU1V6SHBWWEZQenFEcG82?=
 =?utf-8?B?bG9HdlFQWlhnVGlqN2Q4ZFFhbUUzNktVL2h6Yno5R2twNmI5ZXdJbUMzaWlN?=
 =?utf-8?B?eng1ZjVMS1JINTdjZlRTT0ZmZDBQM2V1ajFudmFkWFRwRjlMZjk5bUJlQyt0?=
 =?utf-8?B?VzBLc2c5d290U0JPZ3J6UThMZW9BcHdnVWJFL0kwbXgrc01OU3RyODdtNUhC?=
 =?utf-8?Q?El2NjPknukTYa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hqVVBTQTJ0SDc1Mld3M3J2dUVhMFhNbS9VTWdhSGwzSUtmU3Fqa0NpMmpw?=
 =?utf-8?B?UEliajFMTFdwZjB1bGkrRE5DbTRyKzVpaGlxV0gvUWRaaUhyMDA2SGxLME5y?=
 =?utf-8?B?L0pndU45SlF5d1lzTlZKd1dqWGpKWFVnYXZESEVUL0xySS9QWCtPUkpnTnFi?=
 =?utf-8?B?N2hMZktuMnVJd01xZkx3bGp4dnI1d2k5NGNMWmdRSGJ3Q1JaSTV0cGhGWkQy?=
 =?utf-8?B?L0RtR09lQ29rTjRRaUkyVHoxRjVibFN5QmsyeWxSMG5JYythb1g1YU5VTjJn?=
 =?utf-8?B?K3lkVmJiWDVRZnBEK0FicGJPNTltV2tPYlBPZnd6V3NsSy8yWWhNRGJXVUJP?=
 =?utf-8?B?VmgyWkN4eWRsSGNzU0xoYktMV0lQTVo4dWlvcnlWb0w5YW1ua1I5SWdKUitH?=
 =?utf-8?B?M3JPeEliUkQ4RndmUkFaenExYWhyRlU0Y2lRUkNlTXloV0lRbU5HN2lGaitp?=
 =?utf-8?B?WTZIcmdQdFY4QXNEdDVMUTdYdXJZMEllQlZ4VTNlRHJSZVk1VXZyNVdyQ2I0?=
 =?utf-8?B?NVgycVJYaG5jdDFYaWRvaDlVYzU4eEZtRXRjWlhPSEdiU0xFVVI0cTZ0RTRO?=
 =?utf-8?B?RktMY0ZaNy83bEdjaERJbUlNa3Q1Vlc0UVp2Skd6ejlYNit0VUE5SGgyRlMx?=
 =?utf-8?B?SEpCMEQ4dllWY3B0Z0lWeFRqcEUwK2xMTjJlSnpuVlZkVE9vQ1Y3NXQ3dE1t?=
 =?utf-8?B?Ni9GUkxSQjN4Tm5kZDUxanJ4VTg4YVovbk5paW4wTkwrU0ZUNmFxZDE4Zmo3?=
 =?utf-8?B?aUdqaHpFa1l4bmFwVDBNYnNyYUZaakY5VU4zUzVDSUxoamdQUHVPaGdLN0pk?=
 =?utf-8?B?MnhBck4vZitrTkhjdnVMNEZhN0JueFBrQ3JoM2tHSmVkY2IybjVXSk4yYXl6?=
 =?utf-8?B?c00rTFFlSWtRdCtRa3dGR0lMVDBkYTBTNC85MDMrQ0xhRnNQNVIzeHg4RHR6?=
 =?utf-8?B?cEVYSFFpV215MkxCdUN4TG1XWEthdXlja2tJT0F6S2hERFZBZUNORnlUMVZY?=
 =?utf-8?B?VDNoc0ZNVzBERnBFTStSKzdTbUh2d2FrcEo0anpsOE1lMHhrUVdtVm5taVN3?=
 =?utf-8?B?VlF5Q3dXZWZDYnVSVmNQNFBrRUNPNGFTNG1CZ0d4OEtEeWpHdEk5a3dzcUFZ?=
 =?utf-8?B?REhKSCtKTXExVDFVNTM4ZGdMNlpXTkViSlByK2QzZWk3aklzRUlneVBuRG9U?=
 =?utf-8?B?clgvMTRScFBWSFFuTnlIY2wzRjBYQXM0Zm8xaWRwajY5UHJIZzlDbVRJdk0r?=
 =?utf-8?B?YUJWVlk2Qmdkb05HVXVwWHdtNVN2Zlc4THdmMmdzR1UxRnlTYWZCV016cmFJ?=
 =?utf-8?B?Zmx6d0dtMmh1OURwODFmNHlqZG1HNUR3OWtDTWJBZFl5SjlOa05PcFRqcmg5?=
 =?utf-8?B?WkpLMGdKczB3OTUvd2NKSkVFM3R3N09LejV2dUl6dHNwVDNNNHZRV2dvUStp?=
 =?utf-8?B?UkRTTkxCWjZZbHN2cklieHpDUUNxbFozTmVjdkgzMVVWTVRzN2wvbTZ0bytP?=
 =?utf-8?B?R2hXckJsMkZtRkZFeWRjVngyR1VTMnJxeTY1alpCcDlyQUZFTEdwRkx3K0Uv?=
 =?utf-8?B?SXlnbUQ4WndwdHo0bW10eXl6bDUyWEkyMHV5bk5Vd2d4YWxYMms4dzVva0pW?=
 =?utf-8?B?cnpJVmt5UlZzQjBpN2ZyQUdDQjVWa051ZWtkU1BsREdjMHJ0ZVgwckxaZzBJ?=
 =?utf-8?B?NTk3Y0tBbFFvTzdtNmljRi9pdzFiT3VyblcrUEgzcjk0MDJtSWVYZDl1aHhI?=
 =?utf-8?B?MmlUWVpTcHlySHNuZnZOYkJPSlZ1UzE4MmcyaXVBV0t0T0x2YlA1SzgzTFhn?=
 =?utf-8?B?Ulpkc1NZeUhteXBHQnM3TXpsamg5MWJTSHpjNHEraUxnYitydUIxKzVmdlhC?=
 =?utf-8?B?LzJocDhHTVpwMForc2hIaUhjYVE5NU1ISzI3SmpwWXBhY3FVbSsvSlpVaVNi?=
 =?utf-8?B?eHBhelV0N29tQUVQekJPVkNFd1M5THBkQ3g0aGNOUVcyemFOdXdGWFEvSTZQ?=
 =?utf-8?B?cktXQnpnWVZ1YmhnMkN5bkprSlBBbmprR0RpMGg3UmJGMU5SNTJUTWFmdDRq?=
 =?utf-8?B?Q2FtcHQ5bG9MMldjWXBuYzZlbEgvOE83NEFBeGZvK1FoZEFlTWFkWXk3K1Vw?=
 =?utf-8?Q?liTxZkbbRIxvDWVXPen/kJeBP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0416a9-6c72-4f61-90d2-08dd4b71e23a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:31:05.7732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fnwfn56/FErhnYO6Coj6r9JiJxlp1nyfdFg5L3qDr8SPC+1HpSFC75kKg9278dK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-02-12 03:54, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB54172210D0A892CC1A8FB5BD8FFC2@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
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
	font-family:Consolas;}span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Ping……<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
              Deng<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
              Wishes<o:p></o:p></span></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Tuesday, February 11, 2025 8:21 PM<br>
                    <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                    Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Chen,
                    Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> RE: [PATCH] drm/amdkfd: Fix the
                    deadlock in svm_range_restore_work<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Hi
                  Philip,<o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;
                  Upon further consideration,
                  removing&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;is
                  challenging because it is paired
                  with&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;in&nbsp;svm_migrate_ram_to_vram.
                  However, this pairing does introduce issues, as it
                  prevents&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;from
                  accurately detecting out-of-memory conditions.
                  Ideally,&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;should be
                  tied to the actual freeing of memory. Furthermore,
                  since&nbsp;ttm_bo_delayed_delete&nbsp;delays the call
                  to&nbsp;amdgpu_vram_mgr_del, there remains a possibility
                  that&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;reports
                  sufficient memory, while a subsequent call
                  to&nbsp;amdgpu_vram_mgr_new&nbsp;fails. For these reasons, I
                  believe this patch is still necessary.<o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                  Deng<o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                  Wishes<o:p></o:p></span></p>
              <div style="border:none;border-left:solid blue
                1.5pt;padding:0in 0in 0in 4.0pt">
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                        amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                        <b>On Behalf Of </b>Deng, Emily<br>
                        <b>Sent:</b> Tuesday, February 11, 2025 6:56 PM<br>
                        <b>To:</b> Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Philip.Yang@amd.com</a>&gt;;
                        Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xiaogang.Chen@amd.com</a>&gt;;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                        <b>Subject:</b> RE: [PATCH] drm/amdkfd: Fix the
                        deadlock in svm_range_restore_work<o:p></o:p></span></p>
                  </div>
                </div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <div>
                  <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                      Official Use Only - AMD Internal Distribution
                      Only]<o:p></o:p></span></p>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  <div>
                    <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                    <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                    <div style="border:none;border-left:solid blue
                      1.5pt;padding:0in 0in 0in 4.0pt">
                      <div>
                        <div style="border:none;border-top:solid #E1E1E1
                          1.0pt;padding:3.0pt 0in 0in 0in">
                          <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                              Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Philip.Yang@amd.com</a>&gt;
                              <br>
                              <b>Sent:</b> Tuesday, February 11, 2025
                              6:54 AM<br>
                              <b>To:</b> Deng, Emily &lt;<a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Emily.Deng@amd.com</a>&gt;;
                              Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xiaogang.Chen@amd.com</a>&gt;;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                              <b>Subject:</b> Re: [PATCH] drm/amdkfd:
                              Fix the deadlock in svm_range_restore_work<o:p></o:p></span></p>
                        </div>
                      </div>
                      <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                      <p><o:p>&nbsp;</o:p></p>
                      <div>
                        <p class="MsoNormal">On 2025-02-10 02:51, Deng,
                          Emily wrote:<o:p></o:p></p>
                      </div>
                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                            Official Use Only - AMD Internal
                            Distribution Only]<o:p></o:p></span></p>
                        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                        <div>
                          <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                              Official Use Only - AMD Internal
                              Distribution Only]<o:p></o:p></span></p>
                          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                          <div>
                            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                            <div style="border:none;border-left:solid
                              blue 1.5pt;padding:0in 0in 0in 4.0pt">
                              <div>
                                <div style="border:none;border-top:solid
                                  #E1E1E1 1.0pt;padding:3.0pt 0in 0in
                                  0in">
                                  <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                                      Chen, Xiaogang
                                      <a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
                                      <br>
                                      <b>Sent:</b> Monday, February 10,
                                      2025 10:18 AM<br>
                                      <b>To:</b> Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                                      <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                                      <b>Subject:</b> Re: [PATCH]
                                      drm/amdkfd: Fix the deadlock in
                                      svm_range_restore_work</span><o:p></o:p></p>
                                </div>
                              </div>
                              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                              <p>&nbsp;<o:p></o:p></p>
                              <div>
                                <p class="MsoNormal">On 2/7/2025 9:02
                                  PM, Deng, Emily wrote:<o:p></o:p></p>
                              </div>
                              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                                <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                                <pre>&nbsp;<o:p></o:p></pre>
                                <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                                <pre>&nbsp;<o:p></o:p></pre>
                                <pre>Ping.......<o:p></o:p></pre>
                                <pre>&nbsp;<o:p></o:p></pre>
                                <pre>Emily Deng<o:p></o:p></pre>
                                <pre>Best Wishes<o:p></o:p></pre>
                                <pre>&nbsp;<o:p></o:p></pre>
                                <pre>&nbsp;<o:p></o:p></pre>
                                <pre>&nbsp;<o:p></o:p></pre>
                                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                                  <pre>-----Original Message-----<o:p></o:p></pre>
                                  <pre>From: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                                  <pre>Sent: Friday, February 7, 2025 6:28 PM<o:p></o:p></pre>
                                  <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
                                  <pre>Cc: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                                  <pre>Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>It will hit deadlock in svm_range_restore_work ramdonly.<o:p></o:p></pre>
                                  <pre>Detail as below:<o:p></o:p></pre>
                                  <pre>1.svm_range_restore_work<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_list_lock_and_flush_work<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;mmap_write_lock<o:p></o:p></pre>
                                  <pre>2.svm_range_restore_work<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_validate_and_map<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_update_range<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_ptes_update<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_pt_alloc<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_evict_svm_bo_worker<o:p></o:p></pre>
                                </blockquote>
                              </blockquote>
                              <p>svm_range_evict_svm_bo_worker is a
                                function running by a kernel task from
                                default system_wq. It is not the task
                                that runs svm_range_restore_work which
                                is from system_freezable_wq. The second
                                task may need wait the first task to
                                release mmap_write_lock, but there is no
                                cycle lock dependency.<o:p></o:p></p>
                              <p>Can you explain more how deadlock
                                happened? If a deadlock exists between
                                two tasks there are should be at least
                                two locks used by both tasks.<o:p></o:p></p>
                              <p>Regards<o:p></o:p></p>
                              <p style="margin-left:11.0pt">Xiaogang <o:p></o:p></p>
                              <p style="margin-left:5.5pt">In Step 2,
                                during the&nbsp;amdgpu_vm_pt_alloc&nbsp;process,
                                the system encounters insufficient
                                memory and triggers an eviction. This
                                initiates
                                the&nbsp;svm_range_evict_svm_bo_worker&nbsp;task,
                                and waits for the&nbsp;eviction_fence&nbsp;to be
                                signaled. However,
                                the&nbsp;svm_range_evict_svm_bo_worker&nbsp;cannot
                                acquire the&nbsp;mmap_read_lock(mm),
                                preventing it from signaling
                                the&nbsp;eviction_fence. As a
                                result,&nbsp;amdgpu_vm_pt_alloc&nbsp;remains
                                incomplete and cannot release
                                the&nbsp;mmap_write_lock(mm).
                                <o:p></o:p></p>
                              <p style="margin-left:5.5pt">Which means
                                the&nbsp;svm_range_restore_work&nbsp;task holds
                                the&nbsp;mmap_write_lock(mm)&nbsp;and is stuck
                                waiting for the&nbsp;eviction_fence&nbsp;to be
                                signaled
                                by&nbsp;svm_range_evict_svm_bo_worker.
                                However,&nbsp;svm_range_evict_svm_bo_worker&nbsp;is
                                itself blocked, unable to acquire
                                the&nbsp;mmap_read_lock(mm). This creates a
                                deadlock.<o:p></o:p></p>
                            </div>
                          </div>
                        </div>
                      </blockquote>
                      <p>The deadlock situation should not happen as
                        svm_range_restore_work is only used for xnack
                        off case, there is no VRAM over commitment with
                        KFD amdgpu_amdkfd_reserve_mem_limit. We reserved
                        VRAM ESTIMATE_PT_SIZE for page table allocation
                        to prevent this situation.<o:p></o:p></p>
                      <p>Regards,<o:p></o:p></p>
                      <p>Philip<o:p></o:p></p>
                      <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Hi
                          Philip,<o:p></o:p></span></p>
                      <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;
                          You're correct. Upon further investigation,
                          the issue arises from the additional call
                          to&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;in&nbsp;svm_migrate_ram_to_vram,
                          which
                          prevents&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;from
                          detecting the out-of-memory condition. I will
                          submit another patch to remove
                          the&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;call
                          in&nbsp;svm_migrate_ram_to_vram.</span><o:p></o:p></p>
                      <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>We check all SVM memory must fit in system memory, don't account
      svm VRAM usage. For xnack off, application should check available
      VRAM size and avoid VRAM over commitment.<br>
    </p>
    <p>svm_range_restore_worker ensure all SVM ranges are mapped to GPUs
      then resume queues, this is done by taking mmap write lock and
      flush deferred_range_list. downgrade to mmap read lock cannot
      prevent unmap from CPU as mmu notifier callback can add range to
      deferred_range_list again and unmap from GPUs, so this patch can
      not work.<br>
    </p>
    <p>We should not use mmap write lock to sync with mmu notifier,
      there is a plan to rework svm locks to fix this.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB54172210D0A892CC1A8FB5BD8FFC2@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-left:solid blue
                1.5pt;padding:0in 0in 0in 4.0pt">
                <div>
                  <div>
                    <div style="border:none;border-left:solid blue
                      1.5pt;padding:0in 0in 0in 4.0pt">
                      <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                          Deng<o:p></o:p></span></p>
                      <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                          Wishes<o:p></o:p></span></p>
                    </div>
                    <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                    <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <div>
                        <div>
                          <div style="border:none;border-left:solid blue
                            1.5pt;padding:0in 0in 0in 4.0pt">
                            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                                Deng</span><o:p></o:p></p>
                            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                                Wishes</span><o:p></o:p></p>
                          </div>
                          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                          <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;mmap_read_lock(deadlock here, because already get mmap_write_lock)<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>How to fix?<o:p></o:p></pre>
                              <pre>Downgrade the write lock to read lock.<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                              <pre>---<o:p></o:p></pre>
                              <pre>drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-<o:p></o:p></pre>
                              <pre>1 file changed, 2 insertions(+), 1 deletion(-)<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                              <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                              <pre>index bd3e20d981e0..c907e2de3dde 100644<o:p></o:p></pre>
                              <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                              <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                              <pre>@@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct<o:p></o:p></pre>
                              <pre>*work)<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;process_info-&gt;lock);<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_list_lock_and_flush_work(svms, mm);<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                              <pre>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mmap_write_downgrade(mm);<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evicted_ranges = atomic_read(&amp;svms-&gt;evicted_ranges);<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>@@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct<o:p></o:p></pre>
                              <pre>*work)<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>out_reschedule:<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);<o:p></o:p></pre>
                              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;process_info-&gt;lock);<o:p></o:p></pre>
                              <pre>&nbsp;<o:p></o:p></pre>
                              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If validation failed, reschedule another attempt */<o:p></o:p></pre>
                              <pre>--<o:p></o:p></pre>
                              <pre>2.34.1<o:p></o:p></pre>
                            </blockquote>
                            <pre>&nbsp;<o:p></o:p></pre>
                          </blockquote>
                        </div>
                      </div>
                    </blockquote>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>
