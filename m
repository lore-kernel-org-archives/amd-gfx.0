Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8061CA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 11:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7237510E75C;
	Wed,  4 Sep 2024 11:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JXwbkmOC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF0810E75C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 11:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjrO/eWw/6U69MkUqKWXMu3y0aSh8oCt9sfcK+9ChBskUXMkm2QpdCg2zx3gXLcKCkukhCKQO7lJjh/j9fqMsS5A8f13LbqmXP5jiBGIIqx/FVgNxpuS446FTYMssqlmZPyu3AEK99dlHCtePoHPLtCDqvkZl4Kf4QZu+xTW1xP30JlcDBDhC12lf+KCh2dvDAx/irUxlKng51PhImitQGjhgDAfFMuWCFY7Ls9Lj12bo3T5QCvlgs8dBXA5jDvfgEy9rWzu6ifWB0XpVQRJiAw207PLLZZduTm7J9cbiM28MWVDBz+LEAu9kTPKt0PPMG5jNdMxAgFlb9yCpbgcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9O2nmzvnv5AFvb8hPeEKYJezUHAXcUqi2SPqas1UJY=;
 b=LopZBMPYVjmXOE1OipP3UZwn1Ra2KdT/Vt5PJy0RaPFc/kx20+uSnCVoe43iGHLPrgaybIUgFbFlFt3EImOJ8wZYxcTsVoX7Tgjp+a72fbWfOrMuuhFzj8i9YMIKtk6lpIdNoLkizn4astGQzp/MuXlPNc50O876Zmf1m2xiXuTV8lOaQo6oxANeFLV2qvdnWy/lOXmE7hK2V6H1VhYMfr1nfVtRZb+hlDaKdoDqf1T50cYP345DqnWVj1cWm0IVpaW1rJ7Elt/6DoEN70eKPxXQoTQkPLMxdGEEmpDLUlzsjidXJoIrIDl3yh3WoPBZweuSyGfIiNFmCgBKBEUmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9O2nmzvnv5AFvb8hPeEKYJezUHAXcUqi2SPqas1UJY=;
 b=JXwbkmOCH9J1xnuAz7xY0oxQqmn+qTPEocSpE6ifbLUURj6JcHpwbZNUTCEmQIw9Topy8Z3JwfIAzPeWFtmqsGkGx0V41Ql4/sFLgSYDe22OcfzvCUrBz1JIeTlWBIDSIL2jVPtgdOmlmISH3PopzDhMNPOcLGXEc9x3YzWru5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:03:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:03:11 +0000
Content-Type: multipart/alternative;
 boundary="------------S2jX6vg6I2HbQKHPM2CHQ0Ta"
Message-ID: <b775c53c-9367-4364-8a16-f805ba406ac0@amd.com>
Date: Wed, 4 Sep 2024 13:03:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in
 cleaner shader code
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240904095120.1813377-1-srinivasan.shanmugam@amd.com>
 <BL1PR12MB51440CA6B867F66075BD50ADF79C2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB51440CA6B867F66075BD50ADF79C2@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8ec2a7-228f-4853-760e-08dcccd12a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akpRT2h1M092VWE3RXU0cTJ5SlU1eHZLQVlKenkvdXV4dGZ6YTY1QWsvdW40?=
 =?utf-8?B?OXpUeC9PRzVsTHdTQi90UWpjeFlVLzg3T1pscXk0T2c4cVRiK1JtZC9oNHh6?=
 =?utf-8?B?YjBNV3pMV1pRcVB2ZGtvUFdpcVdCUFdKeHlEenN6YjE0R2ZVQU1udlF0V0Vi?=
 =?utf-8?B?S2lISlNNSy9lY0RQMkxrd3F4dzgrYU8xTHd4Z2lMeTY5TWVXMUFkRVFKZ29Z?=
 =?utf-8?B?V01DOVFpWW85UkUwaXJPVkRyZkxtNnI5RkJ2MUtyM21xZDFUeXdWSEdLUHNB?=
 =?utf-8?B?Y0NzMUVLL2Mrc3pkVkdFc3FERUd5dmY2bktyYkpUQ3VleCtNM3pxU0oremNU?=
 =?utf-8?B?Qmo5YkNzMVdNbzVoRW8yTklPWnNvREpGMStNM0x2Z0VkSzNjTmxDejVmY0tC?=
 =?utf-8?B?cU5UL0VBc0NubmpiQU9lYVJqY2syZnM3V3FkQ3V5MzRkMWkyVWZSRURyd1hO?=
 =?utf-8?B?bzZSNW5rdmUwdExXQVBIcUxuVHlKLzZXakdKZ1Vpclg4V1QvYzY1Zy9NSmJG?=
 =?utf-8?B?UGxPMTZ3SmlJQlA1NVNMcXdvdFE0MTduVG10YTIwcFZNVE5Tcmx4T3JId0tZ?=
 =?utf-8?B?TjB1ajgvTTFSVnVBMXUzV1J5dFh4T0ZGSTVWQXRPdlJHek1PeHFaQUlVa3hE?=
 =?utf-8?B?dkZlYWYxaUpUYUNUeVFLRWw1Ui9PU2hMbDNFMFlGTEl5RkowRzJzcldoY04r?=
 =?utf-8?B?UGk1bTM4MlRhR1ozUWZkTFFLdGM2NEpFVjdQdUI2a0V2U3VaSnFFZC9ITE03?=
 =?utf-8?B?d1ArS2swOVNjNUlhcUs5aXZnaDFxYVVHQXhoNy9sdjdGemZYSTdSWG5GZy96?=
 =?utf-8?B?dmtDbFZPUVV1MGo2aVFYNzlpYThFb2Y2Q2hxME8zekVLek5uMzNrQTE1R2sv?=
 =?utf-8?B?V3N1anJPdm1VeFh4OEpvc1crdlBFNkZUakIrVXRSVklKNjFvOEE1dE5RUHVp?=
 =?utf-8?B?NWlkNFMrc254VGhIUGJZc05rMEdWMGlDd0lpSmY0MXdtWHIxRVBCVHJVaFNo?=
 =?utf-8?B?dTl2UFRCRmdSeXFjTW5VWlNITUZYakdkRnEwenUzWkxWbTZUbC9qOEtFeTBw?=
 =?utf-8?B?b2U4a1BTMTRhK2dDR3ZBUXdQSkRSN3ZXN3dTaXNQbWJTVXdCVTQwOFZnSmlT?=
 =?utf-8?B?Mi9xVWhIcUFYb2NtNzFxOFZSZkIvMVAwdHM5cy9vVlNoMHFUUjB4RU54Rkhp?=
 =?utf-8?B?UnJyWXEwZlNZaEVtMVZkaWszdWQ2aVlvQW1EY3J1ZjNCQkY0Z0REMzl3dUs0?=
 =?utf-8?B?NStMOWM3NnJyU293SXA4aE5ZRFJyRlVyUm9NWjYzSTZGM2xIYjhOU2ppR3du?=
 =?utf-8?B?RTlLUjdUZFFsUE80TXA4WVF5UGR6WnFZSFZzUkpMNmVyR1JMQ0RrVjhqSG1W?=
 =?utf-8?B?UU9CUmhVL2lBRDNJWXFieG4wbi91Y29oOVIrNEdzUDJ2STNTeHV1MTBhNSth?=
 =?utf-8?B?ZStUcHJBVjN4Mlp1eDhyYjdJSTNLZ3hoRE55UWNYYk5SczBUSlM1OUJBWU4r?=
 =?utf-8?B?UUpDUDVYY2VkdlhjQnE4SDIzRE1pakV6WlFyaW90WmIzWDVtYks4S1YrSGQy?=
 =?utf-8?B?ZHFDc1JXZ1hsbXNzTVUrbVdUV3dUQkpmK0FRNW9hWVh6dG9lRVVNNkNKUUF4?=
 =?utf-8?B?cTF3cDhMY1JJYkVCUlU1Z1VSZDV0VXFUOVRsWlFoVWszOWlyY2Q3YkxXenJM?=
 =?utf-8?B?enlrR0I1Zm14VVVENk5OWUZSdi9xa0h2Y3JIT3Zja2llZnR0dlpPYVZXZ29z?=
 =?utf-8?B?WllKRWxOZ0N3aS9RMGthRTkyb3d1aHl2MFhoYnF2ZEg0dzRacG1qSGxTK1B5?=
 =?utf-8?B?cFhYRUYvNHlXRk0wMEl3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHppTWh1dE5kYzdKaTdVN1VlZkswNWt1T3JpMGhodzlPbW8yZ0s3RTJCeFdS?=
 =?utf-8?B?Q29OMjZZTlNTeGd5WU8zVVVPMzdSdzQvdWgyZXA5UjZreGZDUXg2N3RnQ3Zo?=
 =?utf-8?B?NG1zeFdDNk9VS0M0WCtWK04yclJGcm93dk0zcEFoNnY4K2pvaWQwb3pDbzNp?=
 =?utf-8?B?RFo1VjdnMTdrSnR6OEVYY3NVREtFSktRc1NQSmxrOThzTkdQLy9TdDVCcjZs?=
 =?utf-8?B?ZFZ3QUVMcXFNakpPeWdSWEw0UXJNcVg4Q1QySTNXNFlhZDBnR0w4OTM0UTlk?=
 =?utf-8?B?T0RYeXlzcFVYeFZWbzI1dVBja051RmM5WVJTUXgvaVBkd2lPRm1vYXNGMWwr?=
 =?utf-8?B?Q1ZWQmZrK0E2aS9acmludUkyVGtKWUZPTmlHck9ZbndBUTFRaGlLQzlmZ0h0?=
 =?utf-8?B?c0kwY3RGWUJ0S3FIQjR1ZXI0VnF4K0h0U1dxb1l0OVRPT2IwV2k0eVJUUEtP?=
 =?utf-8?B?MkpVUjVMTzhrdU04aGRzSUQzUVJzYjdSMHdLdHplTWptV2t5NEszQk1WZ3ZX?=
 =?utf-8?B?UVVwRGVKakJZRUVTM1pjM3pVcWltSnAyM01JaW9jdDYyeUJ3S0dpK2tKcG82?=
 =?utf-8?B?K29MZ2t1aGwyNkkxNjQ4N1ppQm9hNTRkVWtzUGhIL2h3OXZDSmpNVDZWUnBI?=
 =?utf-8?B?dXpxZ1V2RmxWa05Lb3llaDlrL1I0SVcyWEdzSmVpRjF6R0MzM3B3VGo1SEw1?=
 =?utf-8?B?bkxXaklkVFVYNDRwL3k4eVVpYWV5N2o0VkpFWmdmNWt5dEs3VVlMN0lBK1I5?=
 =?utf-8?B?ZEc5Ykx4MGZqbVIwOXZaNE9XWHlTL2FLOVJtM28zWEhXZjlsYTdTRFJHNXdm?=
 =?utf-8?B?M0kzN1JENGpYN0xyd3h3THBSYWpUOElxMG1aZUFrbmlidWpyc1RiZWM1NEJZ?=
 =?utf-8?B?ek8vblFvTms1MG1Pb2RxdmR6dFFHUnJNSW40bzkvOXV6UWQ4b1U2ZG5HbTA1?=
 =?utf-8?B?WFpQQnFNOUh0RWFhblYvd0k0eHRFelBxYzYzRVdZeHEybDBVNkpWQlBpVEo0?=
 =?utf-8?B?ZDRGN3ZjQjd3MXJ6a21IdXhCTmU3QWkzMVVUZ2c4dDQ4SWVzaE1nYzNrZlRl?=
 =?utf-8?B?aXZnb21YZ3IrMm82VzVVMGZyalV3OUplQ3ByK0NuYU9rYnpaMGd3aFNMeGVh?=
 =?utf-8?B?RzNqYVZtWVdEY0hraGxHc2R1Tkh6OXp5cUtXZFBScHRKeTZCNUpQOEFRbVU1?=
 =?utf-8?B?bi9PVVNpQmpkU1JmWkNXYlVDUi84ejVvcGFlWjk0KysxTTREM2plVjJCUElM?=
 =?utf-8?B?ZjZRNTlvS2xqOFhUazRwUzQzSUpncGsyaU5ucXJUeFJhcmp6NVlmbnFIbEFK?=
 =?utf-8?B?bzR5QUdhbSs5ZU8ydWI0WG5OSVFZcnNZbE1GdVd4R0R2RUw4MWxSbFZENHgw?=
 =?utf-8?B?dGlhbEFTWlhQTkRCT25UN052ekZ3UW96aElmVXJxSWhUWVFQcGwvZ2UxOExN?=
 =?utf-8?B?VFhMc0NsQ2UrRExzTU1UQzhRRUw1dEIxVmJiSnFGdEtCWXhKRDVtaTNRWDFL?=
 =?utf-8?B?Wkg1NW14Zm5DQzgxYldPS0k0RTVyRTJ3ekRoZ2swaHY4WjJhSTYzZFoxRkxF?=
 =?utf-8?B?ZW8zd0pTNUIzUnZia2dVZXEvdUFBSXhYL0dHQ2ZmNktXdXFwNUwwSm1wK0FP?=
 =?utf-8?B?TXZDbUlOMjQ1Q2R6am5IZWdXYkIvaHFNSVNYcUUwSWZwN0RRTkVZNTdhK2lr?=
 =?utf-8?B?bjRIdmNBNjhJUVhLb2l0ZEhScGR2MFE2V29hNmRTTFJtNTArM3JGMjgzUmIx?=
 =?utf-8?B?amh2UXI3VDllK0tva09HM0xYNmhsbElVR25BRXFWYnNCWmdtWlQ2V2xTTVY4?=
 =?utf-8?B?dy9LcGJqT3RPOXBmSjQ2Yjl6UDV2WEUreVFkUzExMmJ3YmF5NWxMVGs1dzRq?=
 =?utf-8?B?b01GZU1RbDVkL1h1T21UdGVPeDROdythdDhqZW1RVENGdmRZSFBmaG54OEoy?=
 =?utf-8?B?TGlsS25mS3BpUUsvcjNVSEFabmRsUzZJV2hoRUVoMUsxNVBQL2tjVWwxOXZN?=
 =?utf-8?B?M25sYlJUZm1tM0k4NlRNcTJLRDBweGdnSVBvN3pTL0VGSG01b0ZRTUlCT3RY?=
 =?utf-8?B?aWVnTkNmUXppQmdiQTJoanRlNVo5UUh2T3pzREZNVVJBckVrZHV4K3J5eUh4?=
 =?utf-8?Q?W75G6LTRuWIDoe0Ce3BJKqWFb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8ec2a7-228f-4853-760e-08dcccd12a0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:03:11.0432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz1UFLzDFSlFJ+wHjbghvUn3YnIZtFO+6eCe+PGd2H3/DLnCDkEOpFiZindU48Q0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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

--------------S2jX6vg6I2HbQKHPM2CHQ0Ta
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It could be that the automated testing tools will run amok on that.

I need to ask Felix for details but I think the code for the CWSR trap 
handlers were converted to C style comments as well because of that.

Christian.

Am 04.09.24 um 12:52 schrieb Deucher, Alexander:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> I think you can drop this patch.  This code is not compiled, it's just 
> for reference, and changing all of the comments will just make it 
> harder to keep in sync with the internal version.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> *Sent:* Wednesday, September 4, 2024 5:51 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> *Subject:* [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in 
> cleaner shader code
> This commit updates the comment style in the cleaner shader code from
> `//` to `/* ... */` to adhere to the Linux kernel coding style.
>
> The comments describe the operation of the cleaner shader, which is used
> to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched
> separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining
> SGPRs.
>
> Fixes: 3b721dfb2c95 ("drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>  - Corrected typo for iteraions
>  - Added fixes tag
>
>  .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
>  1 file changed, 72 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
> index d5325ef80ab0..8951b5a87ae1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
> @@ -21,47 +21,52 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
> -// This shader is to clean LDS, SGPRs and VGPRs. It is first 64 
> Dwords or 256 bytes of 192 Dwords cleaner shader.
> -//To turn this shader program on for complitaion change this to main 
> and lower shader main to main_1
> -
> -// MI300 : Clear SGPRs, VGPRs and LDS
> -//   Uses two kernels launched separately:
> -//   1. Clean VGPRs, LDS, and lower SGPRs
> -//        Launches one workgroup per CU, each workgroup with 4x 
> wave64 per SIMD in the CU
> -//        Waves are "wave64" and have 128 VGPRs each, which uses all 
> 512 VGPRs per SIMD
> -//        Waves in the workgroup share the 64KB of LDS
> -//        Each wave clears SGPRs 0 - 95. Because there are 4 
> waves/SIMD, this is physical SGPRs 0-383
> -//        Each wave clears 128 VGPRs, so all 512 in the SIMD
> -//        The first wave of the workgroup clears its 64KB of LDS
> -//        The shader starts with "S_BARRIER" to ensure SPI has 
> launched all waves of the workgroup
> -//          before any wave in the workgroup could end.  Without 
> this, it is possible not all SGPRs get cleared.
> -//    2. Clean remaining SGPRs
> -//        Launches a workgroup with 24 waves per workgroup, yielding 
> 6 waves per SIMD in each CU
> -//        Waves are allocating 96 SGPRs
> -//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent 
> these waves from allocating SGPRs 0-223.
> -//          As such, these 6 waves per SIMD are allocated physical 
> SGPRs 224-799
> -//        Barriers do not work for >16 waves per workgroup, so we 
> cannot start with S_BARRIER
> -//          Instead, the shader starts with an S_SETHALT 1. Once all 
> waves are launched CP will send unhalt command
> -//        The shader then clears all SGPRs allocated to it, cleaning 
> out physical SGPRs 224-799
> +/*
> + * This shader is to clean LDS, SGPRs and VGPRs. It is first 64 
> Dwords or 256 bytes of 192 Dwords cleaner shader.
> + * To turn this shader program on for complitaion change this to main 
> and lower shader main to main_1
> + *
> + * MI300 : Clear SGPRs, VGPRs and LDS
> + *   Uses two kernels launched separately:
> + *   1. Clean VGPRs, LDS, and lower SGPRs
> + *        Launches one workgroup per CU, each workgroup with 4x 
> wave64 per SIMD in the CU
> + *        Waves are "wave64" and have 128 VGPRs each, which uses all 
> 512 VGPRs per SIMD
> + *        Waves in the workgroup share the 64KB of LDS
> + *        Each wave clears SGPRs 0 - 95. Because there are 4 
> waves/SIMD, this is physical SGPRs 0-383
> + *        Each wave clears 128 VGPRs, so all 512 in the SIMD
> + *        The first wave of the workgroup clears its 64KB of LDS
> + *        The shader starts with "S_BARRIER" to ensure SPI has 
> launched all waves of the workgroup
> + *          before any wave in the workgroup could end.  Without 
> this, it is possible not all SGPRs get cleared.
> + *    2. Clean remaining SGPRs
> + *        Launches a workgroup with 24 waves per workgroup, yielding 
> 6 waves per SIMD in each CU
> + *        Waves are allocating 96 SGPRs
> + *          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent 
> these waves from allocating SGPRs 0-223.
> + *          As such, these 6 waves per SIMD are allocated physical 
> SGPRs 224-799
> + *       Barriers do not work for >16 waves per workgroup, so we 
> cannot start with S_BARRIER
> + *       Instead, the shader starts with an S_SETHALT 1. Once all 
> waves are launched CP will send unhalt command
> + *       The shader then clears all SGPRs allocated to it, cleaning 
> out physical SGPRs 224-799
> + */
>
>  shader main
>    asic(MI300)
>    type(CS)
>    wave_size(64)
> -// Note: original source code from SQ team
>
> -//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 
> 2176 clks)
> +/*
> + * Note: original source code from SQ team
> + *
> + * (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 
> 2176 clks)
> + */
>
> -  s_cmp_eq_u32 s0, 1                                // Bit0 is set, 
> sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3
> -  s_cbranch_scc0  label_0023                        // Clean VGPRs 
> and LDS if sgpr0 of wave is set, scc = (s3 == 1)
> +  s_cmp_eq_u32 s0, 1                                /* Bit0 is set, 
> sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3 */
> +  s_cbranch_scc0  label_0023                        /* Clean VGPRs 
> and LDS if sgpr0 of wave is set, scc = (s3 == 1) */
>    S_BARRIER
>
>    s_movk_i32    m0, 0x0000
> -  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times (loop unrolled 
> for performance)
> -  //
> -  // CLEAR VGPRs
> -  //
> -  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
> +  s_mov_b32     s2, 0x00000078  /* Loop 128/8=16 times (loop unrolled 
> for performance) */
> +/*
> + * CLEAR VGPRs
> + */
> +  s_set_gpr_idx_on  s2, 0x8    /* enable Dest VGPR indexing */
>  label_0005:
>    v_mov_b32     v0, 0
>    v_mov_b32     v1, 0
> @@ -75,24 +80,24 @@ label_0005:
>    s_set_gpr_idx_idx  s2
>    s_cbranch_scc0  label_0005
>    s_set_gpr_idx_off
> -
> -  //
> -  //
> -
> -  s_mov_b32     s2, 0x80000000                      // Bit31 is 
> first_wave
> -  s_and_b32     s2, s2, s1                          // sgpr0 has 
> tg_size (first_wave) term as in ucode only 
> COMPUTE_PGM_RSRC2.tg_size_en is set
> -  s_cbranch_scc0  label_clean_sgpr_1                // Clean LDS if 
> its first wave of ThreadGroup/WorkGroup
> -  // CLEAR LDS
> -  //
> +
> +  s_mov_b32     s2, 0x80000000                      /* Bit31 is 
> first_wave */
> +  s_and_b32     s2, s2, s1                          /* sgpr0 has 
> tg_size (first_wave) term as in ucode only 
> COMPUTE_PGM_RSRC2.tg_size_en is set */
> +  s_cbranch_scc0  label_clean_sgpr_1                /* Clean LDS if 
> its first wave of ThreadGroup/WorkGroup */
> +/*
> + * CLEAR LDS
> + */
>    s_mov_b32 exec_lo, 0xffffffff
>    s_mov_b32 exec_hi, 0xffffffff
> -  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID 
> (0..63)
> -  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID 
> (0..63)
> -  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread 
> is a double-dword address (8byte)
> -  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
> +  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          /* Set V1 to thread-ID 
> (0..63) */
> +  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         /* Set V1 to thread-ID 
> (0..63) */
> +  v_mul_u32_u24  v1, 0x00000008, v1           /* * 8, so each thread 
> is a double-dword address (8byte) */
> +  s_mov_b32     s2, 0x00000003f               /* 64 loop iterations */
>    s_mov_b32     m0, 0xffffffff
> -  // Clear all of LDS space
> -  // Each FirstWave of WorkGroup clears 64kbyte block
> +/*
> + * Clear all of LDS space
> + * Each FirstWave of WorkGroup clears 64kbyte block
> + */
>
>  label_001F:
>    ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
> @@ -100,11 +105,11 @@ label_001F:
>    v_add_co_u32     v1, vcc, 0x00000400, v1
>    s_sub_u32     s2, s2, 1
>    s_cbranch_scc0  label_001F
> -  //
> -  // CLEAR SGPRs
> -  //
> +/*
> + * CLEAR SGPRs
> + */
>  label_clean_sgpr_1:
> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times (loop unrolled 
> for performance)
> +  s_mov_b32     m0, 0x0000005c   /* Loop 96/4=24 times (loop unrolled 
> for performance) */
>    s_nop 0
>  label_sgpr_loop:
>    s_movreld_b32     s0, 0
> @@ -114,25 +119,25 @@ label_sgpr_loop:
>    s_sub_u32         m0, m0, 4
>    s_cbranch_scc0  label_sgpr_loop
>
> -  //clear vcc, flat scratch
> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
> -  s_mov_b64 vcc, 0               //clear vcc
> -  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1
> -  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3
> -  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5
> -  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7
> -  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9
> -  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11
> -  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13
> -  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15
> +  /* clear vcc, flat scratch */
> +  s_mov_b32 flat_scratch_lo, 0   /* clear flat scratch lo SGPR */
> +  s_mov_b32 flat_scratch_hi, 0   /* clear flat scratch hi SGPR */
> +  s_mov_b64 vcc, 0               /* clear vcc */
> +  s_mov_b64 ttmp0, 0             /* Clear ttmp0 and ttmp1 */
> +  s_mov_b64 ttmp2, 0             /* Clear ttmp2 and ttmp3 */
> +  s_mov_b64 ttmp4, 0             /* Clear ttmp4 and ttmp5 */
> +  s_mov_b64 ttmp6, 0             /* Clear ttmp6 and ttmp7 */
> +  s_mov_b64 ttmp8, 0             /* Clear ttmp8 and ttmp9 */
> +  s_mov_b64 ttmp10, 0            /* Clear ttmp10 and ttmp11 */
> +  s_mov_b64 ttmp12, 0            /* Clear ttmp12 and ttmp13 */
> +  s_mov_b64 ttmp14, 0            /* Clear ttmp14 and ttmp15 */
>  s_endpgm
>
>  label_0023:
>
>    s_sethalt 1
>
> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times (loop unrolled 
> for performance)
> +  s_mov_b32     m0, 0x0000005c   /* Loop 128/8=16 times  (loop 
> unrolled for performance) */
>    s_nop 0
>  label_sgpr_loop1:
>
> @@ -143,10 +148,10 @@ label_sgpr_loop1:
>    s_sub_u32         m0, m0, 4
>    s_cbranch_scc0  label_sgpr_loop1
>
> -  //clear vcc, flat scratch
> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
> -  s_mov_b64 vcc, 0xee            //clear vcc
> +  /* clear vcc, flat scratch */
> +  s_mov_b32 flat_scratch_lo, 0   /* clear  flat scratch lo SGPR */
> +  s_mov_b32 flat_scratch_hi, 0   /* clear  flat scratch hi SGPR */
> +  s_mov_b64 vcc, 0xee            /* clear vcc */
>
>  s_endpgm
>  end
> -- 
> 2.34.1
>

--------------S2jX6vg6I2HbQKHPM2CHQ0Ta
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    It could be that the automated testing tools will run amok on that.<br>
    <br>
    I need to ask Felix for details but I think the code for the CWSR
    trap handlers were converted to C style comments as well because of
    that.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 04.09.24 um 12:52 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB51440CA6B867F66075BD50ADF79C2@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          I think you can drop this patch.&nbsp; This code is not compiled,
          it's just for reference, and changing all of the comments will
          just make it harder to keep in sync with the internal version.</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            SHANMUGAM, SRINIVASAN <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, September 4, 2024 5:51 AM<br>
            <b>To:</b> Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM, SRINIVASAN
            <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH v2] drm/amdgpu/gfx9: Convert `//` to
            `/* ... */` in cleaner shader code</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">This commit updates the comment
                style in the cleaner shader code from<br>
                `//` to `/* ... */` to adhere to the Linux kernel coding
                style.<br>
                <br>
                The comments describe the operation of the cleaner
                shader, which is used<br>
                to clean LDS, SGPRs, and VGPRs. The shader uses two
                kernels launched<br>
                separately to clean VGPRs, LDS, and lower SGPRs, and to
                clean remaining<br>
                SGPRs.<br>
                <br>
                Fixes: 3b721dfb2c95 (&quot;drm/amdgpu/gfx9: Add cleaner
                shader for GFX9.4.3&quot;)<br>
                Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                Signed-off-by: Srinivasan Shanmugam
                <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a><br>
                ---<br>
                v2:<br>
                &nbsp;- Corrected typo for iteraions<br>
                &nbsp;- Added fixes tag<br>
                <br>
                &nbsp;.../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm&nbsp; | 139
                +++++++++---------<br>
                &nbsp;1 file changed, 72 insertions(+), 67 deletions(-)<br>
                <br>
                diff --git
                a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm<br>
                index d5325ef80ab0..8951b5a87ae1 100644<br>
                ---
                a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm<br>
                +++
                b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm<br>
                @@ -21,47 +21,52 @@<br>
                &nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
                &nbsp; */<br>
                &nbsp;<br>
                -// This shader is to clean LDS, SGPRs and VGPRs. It is&nbsp;
                first 64 Dwords or 256 bytes of 192 Dwords cleaner
                shader.<br>
                -//To turn this shader program on for complitaion change
                this to main and lower shader main to main_1<br>
                - <br>
                -// MI300 : Clear SGPRs, VGPRs and LDS<br>
                -//&nbsp;&nbsp; Uses two kernels launched separately:<br>
                -//&nbsp;&nbsp; 1. Clean VGPRs, LDS, and lower SGPRs<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches one workgroup per CU, each workgroup
                with 4x wave64 per SIMD in the CU<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are &quot;wave64&quot; and have 128 VGPRs each,
                which uses all 512 VGPRs per SIMD<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves in the workgroup share the 64KB of LDS<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears SGPRs 0 - 95. Because there
                are 4 waves/SIMD, this is physical SGPRs 0-383<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears 128 VGPRs, so all 512 in the
                SIMD<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The first wave of the workgroup clears its
                64KB of LDS<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader starts with &quot;S_BARRIER&quot; to ensure
                SPI has launched all waves of the workgroup<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; before any wave in the workgroup could
                end.&nbsp; Without this, it is possible not all SGPRs get
                cleared.<br>
                -//&nbsp;&nbsp;&nbsp; 2. Clean remaining SGPRs<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches a workgroup with 24 waves per
                workgroup, yielding 6 waves per SIMD in each CU<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are allocating 96 SGPRs<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP sets up SPI_RESOURCE_RESERVE_* registers
                to prevent these waves from allocating SGPRs 0-223.<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As such, these 6 waves per SIMD are
                allocated physical SGPRs 224-799<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Barriers do not work for &gt;16 waves per
                workgroup, so we cannot start with S_BARRIER<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Instead, the shader starts with an
                S_SETHALT 1. Once all waves are launched CP will send
                unhalt command<br>
                -//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader then clears all SGPRs allocated to
                it, cleaning out physical SGPRs 224-799<br>
                +/*<br>
                + * This shader is to clean LDS, SGPRs and VGPRs. It is&nbsp;
                first 64 Dwords or 256 bytes of 192 Dwords cleaner
                shader.<br>
                + * To turn this shader program on for complitaion
                change this to main and lower shader main to main_1<br>
                + *<br>
                + * MI300 : Clear SGPRs, VGPRs and LDS<br>
                + *&nbsp;&nbsp; Uses two kernels launched separately:<br>
                + *&nbsp;&nbsp; 1. Clean VGPRs, LDS, and lower SGPRs<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches one workgroup per CU, each workgroup
                with 4x wave64 per SIMD in the CU<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are &quot;wave64&quot; and have 128 VGPRs each,
                which uses all 512 VGPRs per SIMD<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves in the workgroup share the 64KB of LDS<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears SGPRs 0 - 95. Because there
                are 4 waves/SIMD, this is physical SGPRs 0-383<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each wave clears 128 VGPRs, so all 512 in the
                SIMD<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The first wave of the workgroup clears its
                64KB of LDS<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader starts with &quot;S_BARRIER&quot; to ensure
                SPI has launched all waves of the workgroup<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; before any wave in the workgroup could
                end.&nbsp; Without this, it is possible not all SGPRs get
                cleared.<br>
                + *&nbsp;&nbsp;&nbsp; 2. Clean remaining SGPRs<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Launches a workgroup with 24 waves per
                workgroup, yielding 6 waves per SIMD in each CU<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Waves are allocating 96 SGPRs<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CP sets up SPI_RESOURCE_RESERVE_* registers
                to prevent these waves from allocating SGPRs 0-223.<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As such, these 6 waves per SIMD are
                allocated physical SGPRs 224-799<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Barriers do not work for &gt;16 waves per
                workgroup, so we cannot start with S_BARRIER<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Instead, the shader starts with an S_SETHALT
                1. Once all waves are launched CP will send unhalt
                command<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The shader then clears all SGPRs allocated to
                it, cleaning out physical SGPRs 224-799<br>
                + */<br>
                &nbsp; <br>
                &nbsp;shader main<br>
                &nbsp;&nbsp; asic(MI300)<br>
                &nbsp;&nbsp; type(CS)<br>
                &nbsp;&nbsp; wave_size(64)<br>
                -// Note: original source code from SQ team<br>
                &nbsp;<br>
                -//&nbsp;&nbsp; (theorhetical fastest = ~512clks vgpr + 1536 lds +
                ~128 sgpr&nbsp; = 2176 clks)<br>
                +/*<br>
                + * Note: original source code from SQ team<br>
                + *<br>
                + * (theorhetical fastest = ~512clks vgpr + 1536 lds +
                ~128 sgpr&nbsp; = 2176 clks)<br>
                + */<br>
                &nbsp;<br>
                -&nbsp; s_cmp_eq_u32 s0, 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //
                Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW
                set COMPUTE_USER_DATA_3<br>
                -&nbsp; s_cbranch_scc0&nbsp; label_0023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //
                Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3
                == 1)<br>
                +&nbsp; s_cmp_eq_u32 s0, 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW
                set COMPUTE_USER_DATA_3 */<br>
                +&nbsp; s_cbranch_scc0&nbsp; label_0023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3
                == 1) */<br>
                &nbsp;&nbsp; S_BARRIER<br>
                &nbsp;<br>
                &nbsp;&nbsp; s_movk_i32&nbsp;&nbsp;&nbsp; m0, 0x0000<br>
                -&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000078&nbsp; // Loop 128/8=16 times&nbsp;
                (loop unrolled for performance)<br>
                -&nbsp; //<br>
                -&nbsp; // CLEAR VGPRs<br>
                -&nbsp; //<br>
                -&nbsp; s_set_gpr_idx_on&nbsp; s2, 0x8&nbsp;&nbsp;&nbsp; // enable Dest VGPR
                indexing<br>
                +&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000078&nbsp; /* Loop 128/8=16 times&nbsp;
                (loop unrolled for performance) */<br>
                +/*<br>
                + * CLEAR VGPRs<br>
                + */<br>
                +&nbsp; s_set_gpr_idx_on&nbsp; s2, 0x8&nbsp;&nbsp;&nbsp; /* enable Dest VGPR
                indexing */<br>
                &nbsp;label_0005:<br>
                &nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; v0, 0<br>
                &nbsp;&nbsp; v_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; v1, 0<br>
                @@ -75,24 +80,24 @@ label_0005:<br>
                &nbsp;&nbsp; s_set_gpr_idx_idx&nbsp; s2<br>
                &nbsp;&nbsp; s_cbranch_scc0&nbsp; label_0005<br>
                &nbsp;&nbsp; s_set_gpr_idx_off<br>
                - <br>
                -&nbsp; //<br>
                -&nbsp; //<br>
                - <br>
                -&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x80000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //
                Bit31 is first_wave<br>
                -&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, s2, s1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //
                sgpr0 has tg_size (first_wave) term as in ucode only
                COMPUTE_PGM_RSRC2.tg_size_en is set<br>
                -&nbsp; s_cbranch_scc0&nbsp; label_clean_sgpr_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //
                Clean LDS if its first wave of ThreadGroup/WorkGroup<br>
                -&nbsp; // CLEAR LDS<br>
                -&nbsp; //<br>
                +<br>
                +&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x80000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                Bit31 is first_wave */<br>
                +&nbsp; s_and_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, s2, s1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                sgpr0 has tg_size (first_wave) term as in ucode only
                COMPUTE_PGM_RSRC2.tg_size_en is set */<br>
                +&nbsp; s_cbranch_scc0&nbsp; label_clean_sgpr_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
                Clean LDS if its first wave of ThreadGroup/WorkGroup */<br>
                +/*<br>
                + * CLEAR LDS<br>
                + */<br>
                &nbsp;&nbsp; s_mov_b32 exec_lo, 0xffffffff<br>
                &nbsp;&nbsp; s_mov_b32 exec_hi, 0xffffffff<br>
                -&nbsp; v_mbcnt_lo_u32_b32&nbsp; v1, exec_hi, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set V1
                to thread-ID (0..63)<br>
                -&nbsp; v_mbcnt_hi_u32_b32&nbsp; v1, exec_lo, v1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set V1
                to thread-ID (0..63)<br>
                -&nbsp; v_mul_u32_u24&nbsp; v1, 0x00000008, v1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // * 8,
                so each thread is a double-dword address (8byte)<br>
                -&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000003f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // 64
                loop iteraions<br>
                +&nbsp; v_mbcnt_lo_u32_b32&nbsp; v1, exec_hi, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set V1
                to thread-ID (0..63) */<br>
                +&nbsp; v_mbcnt_hi_u32_b32&nbsp; v1, exec_lo, v1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set V1
                to thread-ID (0..63) */<br>
                +&nbsp; v_mul_u32_u24&nbsp; v1, 0x00000008, v1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* * 8,
                so each thread is a double-dword address (8byte) */<br>
                +&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; s2, 0x00000003f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 64
                loop iterations */<br>
                &nbsp;&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0xffffffff<br>
                -&nbsp; // Clear all of LDS space<br>
                -&nbsp; // Each FirstWave of WorkGroup clears 64kbyte block<br>
                +/*<br>
                + * Clear all of LDS space<br>
                + * Each FirstWave of WorkGroup clears 64kbyte block<br>
                + */<br>
                &nbsp; <br>
                &nbsp;label_001F:<br>
                &nbsp;&nbsp; ds_write2_b64&nbsp; v1, v[2:3], v[2:3] offset1:32<br>
                @@ -100,11 +105,11 @@ label_001F:<br>
                &nbsp;&nbsp; v_add_co_u32&nbsp;&nbsp;&nbsp;&nbsp; v1, vcc, 0x00000400, v1<br>
                &nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp; s2, s2, 1<br>
                &nbsp;&nbsp; s_cbranch_scc0&nbsp; label_001F<br>
                -&nbsp; //<br>
                -&nbsp; // CLEAR SGPRs<br>
                -&nbsp; //<br>
                +/*<br>
                + * CLEAR SGPRs<br>
                + */<br>
                &nbsp;label_clean_sgpr_1:<br>
                -&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; // Loop 96/4=24 times&nbsp;
                (loop unrolled for performance)<br>
                +&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; /* Loop 96/4=24 times&nbsp;
                (loop unrolled for performance) */<br>
                &nbsp;&nbsp; s_nop 0<br>
                &nbsp;label_sgpr_loop:<br>
                &nbsp;&nbsp; s_movreld_b32&nbsp;&nbsp;&nbsp;&nbsp; s0, 0<br>
                @@ -114,25 +119,25 @@ label_sgpr_loop:<br>
                &nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, 4<br>
                &nbsp;&nbsp; s_cbranch_scc0&nbsp; label_sgpr_loop<br>
                &nbsp; <br>
                -&nbsp; //clear vcc, flat scratch<br>
                -&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; //clear&nbsp; flat scratch
                lo SGPR <br>
                -&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; //clear&nbsp; flat scratch
                hi SGPR <br>
                -&nbsp; s_mov_b64 vcc, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //clear vcc<br>
                -&nbsp; s_mov_b64 ttmp0, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp0 and
                ttmp1 <br>
                -&nbsp; s_mov_b64 ttmp2, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp2 and
                ttmp3 <br>
                -&nbsp; s_mov_b64 ttmp4, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp4 and
                ttmp5 <br>
                -&nbsp; s_mov_b64 ttmp6, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp6 and
                ttmp7 <br>
                -&nbsp; s_mov_b64 ttmp8, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp8 and
                ttmp9 <br>
                -&nbsp; s_mov_b64 ttmp10, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp10 and
                ttmp11 <br>
                -&nbsp; s_mov_b64 ttmp12, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp12 and
                ttmp13 <br>
                -&nbsp; s_mov_b64 ttmp14, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Clear ttmp14 and
                ttmp15 <br>
                +&nbsp; /* clear vcc, flat scratch */<br>
                +&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; /* clear flat scratch
                lo SGPR */<br>
                +&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; /* clear flat scratch
                hi SGPR */<br>
                +&nbsp; s_mov_b64 vcc, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear vcc */<br>
                +&nbsp; s_mov_b64 ttmp0, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp0 and
                ttmp1 */<br>
                +&nbsp; s_mov_b64 ttmp2, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp2 and
                ttmp3 */<br>
                +&nbsp; s_mov_b64 ttmp4, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp4 and
                ttmp5 */<br>
                +&nbsp; s_mov_b64 ttmp6, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp6 and
                ttmp7 */<br>
                +&nbsp; s_mov_b64 ttmp8, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp8 and
                ttmp9 */<br>
                +&nbsp; s_mov_b64 ttmp10, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp10 and
                ttmp11 */<br>
                +&nbsp; s_mov_b64 ttmp12, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp12 and
                ttmp13 */<br>
                +&nbsp; s_mov_b64 ttmp14, 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear ttmp14 and
                ttmp15 */<br>
                &nbsp;s_endpgm<br>
                &nbsp;<br>
                &nbsp;label_0023:<br>
                &nbsp;<br>
                &nbsp;&nbsp; s_sethalt 1<br>
                &nbsp;<br>
                -&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; // Loop 96/4=24 times&nbsp;
                (loop unrolled for performance)<br>
                +&nbsp; s_mov_b32&nbsp;&nbsp;&nbsp;&nbsp; m0, 0x0000005c&nbsp;&nbsp; /* Loop 128/8=16
                times&nbsp; (loop unrolled for performance) */<br>
                &nbsp;&nbsp; s_nop 0<br>
                &nbsp;label_sgpr_loop1:<br>
                &nbsp;<br>
                @@ -143,10 +148,10 @@ label_sgpr_loop1:<br>
                &nbsp;&nbsp; s_sub_u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m0, m0, 4<br>
                &nbsp;&nbsp; s_cbranch_scc0&nbsp; label_sgpr_loop1<br>
                &nbsp; <br>
                -&nbsp; //clear vcc, flat scratch<br>
                -&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; //clear&nbsp; flat scratch
                lo SGPR <br>
                -&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; //clear&nbsp; flat scratch
                hi SGPR <br>
                -&nbsp; s_mov_b64 vcc, 0xee&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //clear vcc<br>
                +&nbsp; /* clear vcc, flat scratch */<br>
                +&nbsp; s_mov_b32 flat_scratch_lo, 0&nbsp;&nbsp; /* clear&nbsp; flat scratch
                lo SGPR */<br>
                +&nbsp; s_mov_b32 flat_scratch_hi, 0&nbsp;&nbsp; /* clear&nbsp; flat scratch
                hi SGPR */<br>
                +&nbsp; s_mov_b64 vcc, 0xee&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear vcc */<br>
                &nbsp;<br>
                &nbsp;s_endpgm<br>
                &nbsp;end&nbsp; <br>
                -- <br>
                2.34.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------S2jX6vg6I2HbQKHPM2CHQ0Ta--
