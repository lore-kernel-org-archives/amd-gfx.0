Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CCBC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004E210E8DD;
	Thu,  6 Feb 2025 16:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpRQFoVZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFD410E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXqe67vRpovQ8ZtD5gYmjEyFnj/R6lAoXXNf/Ju4uI+tlx3jREaXt03IjUTiIszRSI05iY0oPTG+KMbxW6laS47utrA6y8gdiGvCl47dqwVVyzTOiY1wdGe6oSNF2hk1Dj9N03KGud8fRknvAxkuv5d0MtP0l/BnQbwDyOio6ZFPFdgDnq/Tzp+kdy8vHmeOUOh+i+P5cXCYZ/0pYVyacxihyAHQFL2XHWPypEYLj2MB0Pz9BoAOhlLEVmMWi2Bibxw5cSosscKyNOHxB7nq8rD+QnPZzZoq5O5Gvho06nZd1RZlqWQWw+Y6GEUwtvdZkiVgYZ+WDjwHYKlkdRORfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loz47I2bIci8v03ZdfxS3YScpNObKB+H0UFD5QtCGQo=;
 b=Yik5B5lCxC4TAokgLXeX9a9sEArZEUT3INLIj6D8oylDVYgtnbmC61SSY9Jj1srdTdBilcTNLE85daWQatClNKA1eeMHMF4BRBfpdSuXvwwg9q72waDdpKTwnNKbvop6x0apbucplmHLIPceiYikRo6g5tpN7RmSpUXMdKAx5WEn++55/wPhyR2OD9dAAjxZgj94Iyl3eRb/IRPjyOgXpe+8YvFMeji7MRr2wd9jTC0eHfcg3xulZ0GllidtvnHdvUMtDuMNIPtJKlv7HsB5agYv6GekG41cKQZ+W5nsDdP/Hi+6kOane6qSwRMObjLm8IIIeLq4dMfSc8urVGdXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loz47I2bIci8v03ZdfxS3YScpNObKB+H0UFD5QtCGQo=;
 b=wpRQFoVZm0N1cakJ8LS17meZauddECZTuw6fwAkJH3/8eiZlbISG+OfOQafqymml7KYS9676plZ1XAl5O1VDynRDf6bX7RIpHKVjLUK2l2JocsA6w4mskQ+CY/lCWlEKm0f6k+Exl3P/iwuSh/ytzA0+z8JAuYZrQCrcT9JRZpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 16:48:49 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%3]) with mapi id 15.20.8398.014; Thu, 6 Feb 2025
 16:48:49 +0000
Content-Type: multipart/alternative;
 boundary="------------xyycKEiEAJleKf99kaEKE3P3"
Message-ID: <b8f65db6-a4fa-4d13-809c-ab8061276e7b@amd.com>
Date: Thu, 6 Feb 2025 11:48:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
 <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
 <10a87efa-1e38-4fbb-b194-036042e2ef43@amd.com>
 <DS0PR12MB78048C1038DC5F279EF24E2A97F62@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <DS0PR12MB78048C1038DC5F279EF24E2A97F62@DS0PR12MB7804.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 0325ef9e-adf5-497e-9dad-08dd46ce2146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG9Pd0p6ellxVEpUUklTRloySUFFK0VHblV0UEt3c0ZBWmtWeEU3eU9SUHhh?=
 =?utf-8?B?N1p2TU80NkNYams5bTNSOTZyZXkwMkdQd1Avd2VlTXZ5OUM5RDJpRGgyc0RP?=
 =?utf-8?B?Q2wraXpaaFMwSkVYUkt3bWw2QVlWakFVNDNmMDlLcEpuOVUyZkRjL3JlQWY4?=
 =?utf-8?B?bmVGbGhZZ1U4YTM0eEJuUGpUcTY1WjZMZmJsVCtGTi9vTGN2QytGS2xrV2cz?=
 =?utf-8?B?WGlnS0sxeEdYU1dzY09WTkY1Y2VnTWxabWcwRTNFL3BHOFlNVnE2b1NoOURl?=
 =?utf-8?B?OURkNW15Ym5ZWCtjNnl1V2lLM3cwNzUrWDlNbmhrNXRmSEYvemhxaHVScTBJ?=
 =?utf-8?B?YTdKbXJwRDFQa3V0RUkxWmlKSE9JMExNM09uSDJDVDkxVUZMNTVkZnFyUG0z?=
 =?utf-8?B?Sk92VThOR0N3NFBmRitTaU12TStNckdjUDF4UUMxSjRFMnZpZUpIRE56OXlw?=
 =?utf-8?B?amlIYUhDQVRIdTg4VWZzTWpYRVF1aVRyZzQ2eGkvZFVHeno1S2ttK1NwZElK?=
 =?utf-8?B?bmNJQUxwUVpTZS9lU2tCMGxOdXFhRndtQS9zSGZjdGowZUI1aC82SXBoQUpl?=
 =?utf-8?B?UU5SQXJJU2l6cVZRL056bFR0dDFEd3FXLzV2UUxVM01JME9DTlYvRnpacmJR?=
 =?utf-8?B?TTR2SVVZanloblZXSzdTS0srNmIwVktEY1I4YTFlUEJkSGhjVDhZZ01HZCtU?=
 =?utf-8?B?R0NPT3NUT0hjMmdRTFNSMElKVUtzUkRTODRNeE5IZ1RIcTU2MVZCaGkvc1Mx?=
 =?utf-8?B?RVZzakJYemYvRWtVV2pKS0tyWEprWW8xZU5BUElWTU5pY29nYVRuS2hITGNY?=
 =?utf-8?B?ZlVzcUMrVnJuTjdxU3VGU1ZpSStOV1o1MWE2UUFydnRsWHlMQjVqeFZ4Q3My?=
 =?utf-8?B?R0s4SFFaZWZ0bkVzTXI3TzNtYXEyQXhUSWhYY25UQWQxdDdqRG5YekV4ZjhR?=
 =?utf-8?B?YnNTWHQzd0FKY1lZcWpnU0FMVm8yNUd0QzdUUC8xZW5uQ2NmQTBzVWxiR002?=
 =?utf-8?B?Z1QzZ2w0eFBUS3BIZkR0ajZHSDJ6RDd4VTdtOHp6RlRSSUZnOHAwNHpQNm1K?=
 =?utf-8?B?U2RIODA5QWRvcWJCTm82M2ZXOGZ3RmxtM1lhYUphamdhUjMyL09mRlplblNX?=
 =?utf-8?B?NDcrSGRXMkpBN1F2ajB3MkZ4dFJLVE92SDlsN3lKTzQ2Wmx2ei83NjJMVTRs?=
 =?utf-8?B?UStIQUNGeS9LZVBzc29QQlN0ZXFQNFFaWklZdHgrdUgrT2c2QkFXNkE1ZVVM?=
 =?utf-8?B?clNSdkhmSEFHV1V6SXZIRlBNZlpDZ3Nnc0Z2cmhRUnhaY20rNytncXltYktY?=
 =?utf-8?B?OFNFVHBkWjlkcVhsUzk0V3haMUpmczhXZTRsUm50dmxMUERxazRWV3NqQUFw?=
 =?utf-8?B?T3p3Sy9zQm53Z3QyY3VuVCt4bWlWU3l3K2daRnFtdXFFbW5EWDBVUzlKTExE?=
 =?utf-8?B?RUh5c2FxZ3ozUGVFN2wzNzFXYVMrK3o4dk9QOVgvd2ZuNTBuajh2Z2dMS0Jy?=
 =?utf-8?B?dXJoUk05T0FBaU4zZEhXNHRmcmZVUG9ldUl2QVVZU2dZREtxbDVuaDJyb2Zm?=
 =?utf-8?B?bVYxZ0xiUG85OWRqUTNvNkY2d1F2aWsraGl6M0w2MlBtNHI2dUxDdjdYYVd3?=
 =?utf-8?B?UlREejE3NDVkUEVVeE1FUFVUQzVVWDVIbTZHUEpmWEV2aTdmY2NyaThwMFJK?=
 =?utf-8?B?b1YydEZBQ0JxajZKc0tsek1lQzVKQThVRUYzVkJRYllTWnlnVFFpQXA3OG16?=
 =?utf-8?B?VjFITjgrdkYwUnNabTYrVkN2aUpvc0t0dDlPRlFZUXdVeEpQVHYvU3RYUVZu?=
 =?utf-8?B?QWliQmNBOGxqMG5EZUNoRWozS092Z1pnTnh1ZGpoRkR0TTNkdVkvSzN0U1RO?=
 =?utf-8?Q?sRGokmsjCiLWJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9OQzRPSzFvSDNmZkdQL1JERldNWGNkTDZkZmJMQ28zY2RtVjZFT044Mi93?=
 =?utf-8?B?YkozQUZpMS9BZFNURlkxRDY0NDZ5dlVLRDF6R2ovNGFIU0QwQ0hHR01Ncld2?=
 =?utf-8?B?amRjTjBjbWZ4Ky8xcFRXa3llMHpZYnplZ1pDZ3g0SmdBRURLblNtUXgvRjJo?=
 =?utf-8?B?R0FIUGxvNEcrNzZxeWM0NjloT3IxNmRLejIvME1rSDJQYnRSaFBlY1Q0dE12?=
 =?utf-8?B?Z2E4aVZhT3JucG5tcVBwL2FicFUxVXFYclEyOGZxelZoR0MzaWN1bzZZZUdP?=
 =?utf-8?B?TmpxVEQ3UnRHSCs0bEdKaDAvZjhHMnZVeWVBdjh6dWkvdlZpUlJMQjBUWlJr?=
 =?utf-8?B?TjJOOVhXQVZ4WUFLdStCbVhlSFJlSkFvbDF3UXZVcHRZL3ZPaUMvbFhpeFJR?=
 =?utf-8?B?QW5uMFZ5SDU4UEkyVHdya3JLb2c5THJiZ0pBZXZURzFOTUJ2aHZScGtiT20v?=
 =?utf-8?B?NHdxYVArY0d1Sk1nVWR5RERUUW5zcFBuODVFaTd3VitRdkdmMFBSVG9ZbzNp?=
 =?utf-8?B?L1pkcjdQL0xmVkg0Vmh4WE80cEdWd283VE5XeDZwUzgwSUxObkZVbFBuSnFi?=
 =?utf-8?B?aTNHazZCM0M4TGpVRVJ4SVRLU0ZJelEwUjNMd2xZdHhBeGJmaENMMnN4SWJy?=
 =?utf-8?B?V2tiQThFK0xvUFZmNkhyV3JHbWhsaGFIdUZnR1dXY0hEOU5nRmRJb05LMThw?=
 =?utf-8?B?S0lxTWVkZjJ5RmJDZFNXU2hlK1ZNeEhqcVNmeWZBMDc3Rnovd082OHlGNGtt?=
 =?utf-8?B?MFlwUDYxZ0IyUFRZR0prdkJBb2VEbzFRblZ0NHg3UWRremRtU1FURkRtTEZl?=
 =?utf-8?B?UW5UTUpaYklkWnpmNVd5OEJOOVVrWXg2QVUyaGkvMmRMQjVrYzh5TXVjWjRD?=
 =?utf-8?B?dVJWNUN2SkVkdFZENUpCd25qRTlpU3JJN0dkQit3ZWZSVUtma0RRRmhMeVlN?=
 =?utf-8?B?MFphM3d5ZzZpQWpvS1lRRWhQNjFlSUJzSHY1UEh6SmpjaXFldzZBNWJSZFEy?=
 =?utf-8?B?M3hxaVNwV2ZiQmNzNTVWU3NBbml6QkZ6bXhRcXQ4eDREcHFQeEVpTUZrVklo?=
 =?utf-8?B?cVFhTDRWUGpnRjJrSW1EVkVWTkVLb0xxRStiYXd1bDZkajNmTE1kSU5oS3FL?=
 =?utf-8?B?b1JySnFoR0lxRDkrNkhOQmo2WTRtMWl2aUU1NEhBRlVpRXRJa1F5Uk9UQ3pR?=
 =?utf-8?B?ZVNzT25UU3V1YXlHZVlTNGh4TjNzUHJnaURoMnE3NC9KZUU2VnBBT0QxQksy?=
 =?utf-8?B?SGFEcW1rTW5MNy9vT2UwYm9rZ0MyL3I1RUdNdVJLcFBEeTVyQmpKSjRIc3ow?=
 =?utf-8?B?UmpHQndpaGNWaEFCL2l4c0pTdHFsK3FvN3BSTThCSzVBc3dLeERUZXoyTFJl?=
 =?utf-8?B?M1BXbEZIWDB2QW1NeXZSN3pkUm1aZDVwb1JhRC80SmpJczRzSTVzVmN0bWR4?=
 =?utf-8?B?YVQzTFJyT0prbDNJOUZXdHMxTFBmNVpTRFpTbktkWEg5MWdkRzZpZEhoRGV0?=
 =?utf-8?B?WnFROE1ubkFJbTdmcm51N21qeTFkeEgvNXFtNmFUSXd1dDlzN3F3K0FNaUxZ?=
 =?utf-8?B?VWUwa0VWV3Byb1lWOTNMa1ZUZ3N3clowRkVFcFVjZVVqUmVTVXFLRHpGT21B?=
 =?utf-8?B?MEtMbUZaTkxDVmFQWkczNUhybjRBTXh4VlNRSEkrNmRFcnRxTmlDQVl5bkdC?=
 =?utf-8?B?Ynh4aFBRRVovQldDWFRjS3JUNU1qbU00YStnQ0dYQXByUG9BdDVzQURvako5?=
 =?utf-8?B?bEFXVGdldE1NYTdBTHhtUERhV2pSWldSTGxadEEzSG5VUm1ZaWorWm9QNXRB?=
 =?utf-8?B?TnhsaXVMOUpiVjUyQ3ZIU1lrNCtkNTBYZVQ1czhEaDhGanhlZTZDclRNTE5U?=
 =?utf-8?B?S3Y0d2EwUFRrN2RnZG1EZFVRcEhTRGo2MHQ4YU1Ha2xUM3ZMOC9Pclh2N1hq?=
 =?utf-8?B?ZjhQVUM1akJTYkVtKzBqYXpvRzFhak80MHl0RjhqRExKb3dzQlhYMUxZT3VF?=
 =?utf-8?B?dVZWSlNxZytSdHdDMlh3SlpzU1J2SEttZ2JrcTZlZXZBVUJLVk5XMEUrUkJx?=
 =?utf-8?B?eis0NGlRTG5jeGhFSE9ld1JLTDZwYkc3ek5QZUk2d1ZmQW5rRE1pK0M2UDRv?=
 =?utf-8?Q?7vLJaeM8neuNBkzuC4BS4Sk4l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0325ef9e-adf5-497e-9dad-08dd46ce2146
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:48:49.3289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIgQ5EyTcrNi3hcoA8aiVQKjcQ1joYZBLhcKwH/lydhcZWaCgMKcRwWcCj9EV9GDJVBgykzLZS0kX96k33uvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

--------------xyycKEiEAJleKf99kaEKE3P3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I understand your concern. KFD currently only reports one L2 instance, 
but not every L2 instance. If customers want to have more detail in all 
available L2 info, we probably can change the logic in this function, 
but it is not related to my change. My change is based on current kfd 
logic and fixes missing L2 issue.

Thanks,
Eric

On 2025-02-06 11:37, Lazar, Lijo wrote:
>
> [Public]
>
>
> Yes, the problem is that. If a node has 2 XCCs, it should report the 
> L2 of each separately with the number of CUs sharing each L2.
>
> In this, it appears to loop through and find the first non-zero of all 
> XCCs of a node and not based on the first non-zero per XCC basis. It 
> makes a difference in number of L2 instances available.
>
>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> *Sent:* Thursday, February 6, 2025 10:00:38 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
>
> On 2025-02-06 10:14, Lazar, Lijo wrote:
> >
> > On 1/29/2025 8:50 PM, Eric Huang wrote:
> >> In some ASICs L2 cache info may miss in kfd topology,
> >> because the first bitmap may be empty, that means
> >> the first cu may be inactive, so to find the first
> >> active cu will solve the issue.
> >>
> >> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
> >>   1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >> index 4936697e6fc2..73d95041a388 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct 
> kfd_cache_properties **props_ext,
> >>                               int cache_type, unsigned int 
> cu_processor_id,
> >>                               struct kfd_node *knode)
> >>   {
> >> -    unsigned int cu_sibling_map_mask;
> >> +    unsigned int cu_sibling_map_mask = 0;
> >>       int first_active_cu;
> >>       int i, j, k, xcc, start, end;
> >>       int num_xcc = NUM_XCC(knode->xcc_mask);
> >>       struct kfd_cache_properties *pcache = NULL;
> >>       enum amdgpu_memory_partition mode;
> >>       struct amdgpu_device *adev = knode->adev;
> >> +    bool found = false;
> >>
> >>       start = ffs(knode->xcc_mask) - 1;
> >>       end = start + num_xcc;
> >> -    cu_sibling_map_mask = cu_info->bitmap[start][0][0];
> >> +
> >> +    /* To find the bitmap in the first active cu */
> >> +    for (xcc = start; xcc < end && !found; xcc++) {
> > It seems there is an assumption made here that a CU in one XCC could
> > share this cache with CU in another XCC. This is not true for GFX 9.4.3
> > SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.
> In KFD topology we only report L2 cache info of the first active cu in A
> XCC, which could be XCC0 or XCC1. It is generic for L2 info in the
> certain XCP/kfd node, and not specific for every XCC, so it doesn't mean
> the L2 cache found in XCC0 can be shared with XCC1, it only means there
> is L2 cache in this kfd node.
>
> Regards,
> Eric
> >
> > Thanks,
> > Lijo
> >
> >> +            for (i = 0; i < gfx_info->max_shader_engines && 
> !found; i++) {
> >> +                    for (j = 0; j < gfx_info->max_sh_per_se && 
> !found; j++) {
> >> +                            if (cu_info->bitmap[xcc][i % 4][j % 4]) {
> >> + cu_sibling_map_mask =
> >> + cu_info->bitmap[xcc][i % 4][j % 4];
> >> +                                    found = true;
> >> +                            }
> >> +                    }
> >> +            }
> >> +    }
> >> +
> >>       cu_sibling_map_mask &=
> >>               ((1 << pcache_info[cache_type].num_cu_shared) - 1);
> >>       first_active_cu = ffs(cu_sibling_map_mask);
>

--------------xyycKEiEAJleKf99kaEKE3P3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    I understand your concern. KFD currently only reports one L2
    instance, but not every L2 instance. If customers want to have more
    detail in all available L2 info, we probably can change the logic in
    this function, but it is not related to my change. My change is
    based on current kfd logic and fixes missing L2 issue.<br>
    <br>
    Thanks,<br>
    Eric<br>
    <br>
    <div class="moz-cite-prefix">On 2025-02-06 11:37, Lazar, Lijo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DS0PR12MB78048C1038DC5F279EF24E2A97F62@DS0PR12MB7804.namprd12.prod.outlook.com">
      
      <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div dir="auto"><span dir="auto" style="font-family: -apple-system, HelveticaNeue; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Yes,
            the problem is that. If a node has 2 XCCs, it should report
            the L2 of each separately with the number of CUs sharing
            each L2.</span>
          <div dir="auto" style="font-family: -apple-system, HelveticaNeue; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
            <br>
          </div>
          <div dir="auto" style="font-family: -apple-system, HelveticaNeue; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
            In this, it appears to loop through and find the first
            non-zero of all XCCs of a node and not based on the first
            non-zero per XCC basis. It makes a difference in number of
            L2 instances available.</div>
          <div dir="auto" id="x_ms-outlook-mobile-signature" style="font-family: -apple-system, HelveticaNeue; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
            <div dir="auto"><br>
            </div>
          </div>
        </div>
        <div id="ms-outlook-mobile-signature" dir="auto">
          <div><br>
          </div>
          <div dir="auto">Thanks,</div>
          <div dir="auto">Lijo</div>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>From:</b> Huang, JinHuiEric
            <a class="moz-txt-link-rfc2396E" href="mailto:JinHuiEric.Huang@amd.com">&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, February 6, 2025 10:00:38 PM<br>
            <b>To:</b> Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdkfd: fix missing L2 cache
            info in topology</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText"><br>
                On 2025-02-06 10:14, Lazar, Lijo wrote:<br>
                &gt;<br>
                &gt; On 1/29/2025 8:50 PM, Eric Huang wrote:<br>
                &gt;&gt; In some ASICs L2 cache info may miss in kfd
                topology,<br>
                &gt;&gt; because the first bitmap may be empty, that
                means<br>
                &gt;&gt; the first cu may be inactive, so to find the
                first<br>
                &gt;&gt; active cu will solve the issue.<br>
                &gt;&gt;<br>
                &gt;&gt; Signed-off-by: Eric Huang
                <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a><br>
                &gt;&gt; ---<br>
                &gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_topology.c |
                18 ++++++++++++++++--<br>
                &gt;&gt;&nbsp;&nbsp; 1 file changed, 16 insertions(+), 2
                deletions(-)<br>
                &gt;&gt;<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
                b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                &gt;&gt; index 4936697e6fc2..73d95041a388 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                &gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                &gt;&gt; @@ -1665,17 +1665,31 @@ static int
                fill_in_l2_l3_pcache(struct kfd_cache_properties
                **props_ext,<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cache_type,
                unsigned int cu_processor_id,<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node
                *knode)<br>
                &gt;&gt;&nbsp;&nbsp; {<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; unsigned int cu_sibling_map_mask;<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp; unsigned int cu_sibling_map_mask = 0;<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int first_active_cu;<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, xcc, start, end;<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_xcc =
                NUM_XCC(knode-&gt;xcc_mask);<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_cache_properties *pcache =
                NULL;<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_memory_partition mode;<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
                knode-&gt;adev;<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp; bool found = false;<br>
                &gt;&gt;&nbsp;&nbsp; <br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start = ffs(knode-&gt;xcc_mask) - 1;<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end = start + num_xcc;<br>
                &gt;&gt; -&nbsp;&nbsp;&nbsp; cu_sibling_map_mask =
                cu_info-&gt;bitmap[start][0][0];<br>
                &gt;&gt; +<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp; /* To find the bitmap in the first active
                cu */<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp; for (xcc = start; xcc &lt; end &amp;&amp;
                !found; xcc++) {<br>
                &gt; It seems there is an assumption made here that a CU
                in one XCC could<br>
                &gt; share this cache with CU in another XCC. This is
                not true for GFX 9.4.3<br>
                &gt; SOCs. In those, a CU in XCC0 doesn't share L2 with
                CU in XCC1.<br>
                In KFD topology we only report L2 cache info of the
                first active cu in A <br>
                XCC, which could be XCC0 or XCC1. It is generic for L2
                info in the <br>
                certain XCP/kfd node, and not specific for every XCC, so
                it doesn't mean <br>
                the L2 cache found in XCC0 can be shared with XCC1, it
                only means there <br>
                is L2 cache in this kfd node.<br>
                <br>
                Regards,<br>
                Eric<br>
                &gt;<br>
                &gt; Thanks,<br>
                &gt; Lijo<br>
                &gt;<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                gfx_info-&gt;max_shader_engines &amp;&amp; !found; i++)
                {<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt;
                gfx_info-&gt;max_sh_per_se &amp;&amp; !found; j++) {<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (cu_info-&gt;bitmap[xcc][i % 4][j % 4]) {<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                cu_sibling_map_mask =<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                cu_info-&gt;bitmap[xcc][i % 4][j % 4];<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found =
                true;<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
                &gt;&gt; +<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_sibling_map_mask &amp;=<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((1 &lt;&lt;
                pcache_info[cache_type].num_cu_shared) - 1);<br>
                &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first_active_cu =
                ffs(cu_sibling_map_mask);<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------xyycKEiEAJleKf99kaEKE3P3--
