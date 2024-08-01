Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73CAC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 04:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BDF10E73E;
	Thu,  1 Aug 2024 04:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9zm2mAW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208ED10E73E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 04:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOwvCZcsQWvZbH8grhquHDaMnIekvwpPG1NwZZwKLhCCd8R+Y77hAGDOFlku1G36yFX7kNbFjMhlSQkphCy/9GBcc7EEUi5XAwe/1u6EGrLKCQEnbPiZnukINPWi5pT+qJhXUUpfK8Pj78ina+7jXcrw3gNPbuoUX0FhDIvbK/oVa2jdQMoaWyzknBQD1GDDYQySw2g4mpTuZu6T2gFNxhtS26ba9RB2NTOmNXzuC3XCdmGYVrzJoK0HTiHXxCHBgmLqRSd5gdgy63Sgig9lbw9nOhiYT/oNA9yzt7mlhkL2brruAexaMoKU5ZlyCiigSQF0iDZGs1dWv8fWnOWoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48EdzhxwzqlVwpI4MJQ2uPDAPKQcUfxC5/GKsOVSw0g=;
 b=KH+TXE/sVOIzcwvFHB+/qFfL6Au6hX3G3u6NqvlqY0vh/qOVpVZX0OGYnpGbfJK/EZ0mOK0UBAJYMpqZde/7ih0K3WVgW9vzBm39ROhSsvIcwF+BfaME59sRaRO/lLG7Tn8Xm/niyfz/Imu5zuVio7xVzMgPDV+aqCgfVuE9z7G3W9lS0cq3R4OW9XMlcArFjmZ4lRNrZrFkeMt1ueayNQnu9DLjFbUGpC7ySbqeC0YdbFrZXoWgt1aEiEhQp0d3+6F93r6Jx8utuLwpmbOiJKlF+51WYp4310LRs6FoOa2JZtgBSPbwphfRUZTmAcLlEiSsiQxhX/2DnqpHielLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48EdzhxwzqlVwpI4MJQ2uPDAPKQcUfxC5/GKsOVSw0g=;
 b=X9zm2mAW+KYyXUUb+pu9KEDYTd2OcL3tB+gpen+ga30EqIVbmzdCmpIKL2ZlfCIqgJarNk8TB6ZVPwLkrDM4PSb8Kx3xnjj1Pdc/mh4joaFY8tpORiYeBzdNs03WPkomwQNQIYTSbHolO/XMe66pLZNI+M6HLwFgzkmQVycdOXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 04:34:27 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 04:34:27 +0000
Message-ID: <0c7b0373-d29f-4f77-a8e5-347d66a462a5@amd.com>
Date: Thu, 1 Aug 2024 10:04:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A7AoEXu_TP8LkMb6KbeSMtL2QT+AfjQMoi52WHYMixkSQ@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CAAxE2A7AoEXu_TP8LkMb6KbeSMtL2QT+AfjQMoi52WHYMixkSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: b44a1424-a648-428a-38b1-08dcb1e33a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGwwLy94R3F5VitYbWJDZ3BLUFI2Q0ZtUUwvN0VDdXVBWkRNSmlwNXVhUWlW?=
 =?utf-8?B?M3N5My80RGRLaHh1MlRDak8yTTJwb3ByYUJ1eElEUmRycFRZU1dqQm1IcEZV?=
 =?utf-8?B?ODdVbnNzMVhTdFZCUVNVRDZ5b1hwUzVsc2RZZkgybHJGS24xR3BNbEFKRjUr?=
 =?utf-8?B?ZjZhQkJnUE1vWk5iRjBrYVhsQmZOOGwxVm5Yd29ya3MwN2c4d2V2QUl1TS9q?=
 =?utf-8?B?Kys5ODZNc21vc1p5SmJ2Ulh1MzVSOFR4dGNvZ0pkV1Z6dFdCZlkxUEhCcEdP?=
 =?utf-8?B?TTNGQStsTm1VSDdibU02YjU4d2o0MlZTTDVkTDBsYWZJcHR5dksySFo5dk1j?=
 =?utf-8?B?WjMrUExhck1QMXJaNTUraU02M2hTVEorWk5UeGtkNHEwM21ITUhuaUc3djlN?=
 =?utf-8?B?SXh2NzlXMThkOXBhakh0VTNGZVp1N1hTdk5XM2tKcFN1TkpOZDZyeXBZMjRB?=
 =?utf-8?B?SkhqSEZzWWM0OHVmM3lDQmk0Y3h0dFRHVCttWTlqUG9oUDlKR0lDQmxnSXFi?=
 =?utf-8?B?RFlaL0xhMUs1eW1ESnNVSFRWQjQ1STFCWGJNcWlYTlVndXlkemg3bm56MExn?=
 =?utf-8?B?M21OeWFQSTYrbXpwWU04TDZTdFRZUmJmMk9zMEhiOVJFeHJYQVp1cW1qR1N6?=
 =?utf-8?B?TjIyZkd5WVNHK3RIOE16VlhrcWVXeWkwMGk2K2lXYXY2SUVkNnB1VkVRUS9L?=
 =?utf-8?B?UHdlYlRUOWJUbnJDdy9QdWhwamlYWE1zOWNtOGp3SWh0MVdZeitGcTkrZGI2?=
 =?utf-8?B?SFRmQzNaTGlkUlhtK2s2clRjVkRaOHNEVzByZjQrZkhpU04vMUpYb2dRbjFl?=
 =?utf-8?B?NVFmbGJFbERkZXplWllzVEdMSVliWXNLRFE3bkhYZEROSWMvR0ZzSUVlWEhH?=
 =?utf-8?B?QldBNi9lMkozb0xROGViR0JVZ2RYUzMwZ0l3eHdmMDFSSVRpTFE2L280T2xt?=
 =?utf-8?B?OFB0QXNjTlUvajFmUy9RaUs5UkNhWEJtNk9kaS9MNk41NlptYW5qVGVNL3Fx?=
 =?utf-8?B?Qm5HUU5XVHFndWhlRG11YWJkQkZobzRSK29WdmNhK1ZnQXRjcG9SMVNNREhL?=
 =?utf-8?B?VUpIZmFNRXhSYmM4WEJtR2ViTC9hTitQdWxjY0tRbmpTSnZHc0tpcnhwMk9F?=
 =?utf-8?B?TVdNQkl3d0x3WHNqNzROdGoxejI4RGFaZk1SOHlUeG5DamsrcEtDMGd6S3pW?=
 =?utf-8?B?VXo2dFlJdG5PY0R4RmwzQzlCY0tEWGpzSkhGajVScEpqUTV5Q2gyQ2NtU1FH?=
 =?utf-8?B?a2QwSzFPSy9rOFNzdXpRVEhKTmJHMWpwYm43TTYzdWpCbFBTaVlVcWFtbUdz?=
 =?utf-8?B?NGNNVE1WZzJGOFZvOWt0Wjc0NTNoZW5BRWV5aEYwcUZEWHVuVGxhRzVlTlhj?=
 =?utf-8?B?cHJaUUJjVnh0UEtzTHd0ZEovSjU4MHMwcFU1RTdCM1F2TktoaFFraTJ2dDZz?=
 =?utf-8?B?SnN4YkhTM3RZbSs1ejI0TUVMa2pRaCtVUEpoSDlnSXhLbU9ZMGlJSld0OFNQ?=
 =?utf-8?B?QnQvNGU4d2U2WTRtQjVkODF4T05BajlDbm04WWlYeldOMzZYQzZOMTVaTkVo?=
 =?utf-8?B?YWZmWXp5Nms5ckJEa0gxVytGUU5oZ24vYmNwVllGTnY4Qlp0Z1kzMHlScTZu?=
 =?utf-8?B?bUlaT0lwMFltaUNFSkpQY1QyRTJyNXowVXFjUWVWWEYzMEMxODhWMHNjYXNE?=
 =?utf-8?B?disxemRKOGtEelNIYk1ZaHp3M0V5alQzdjhWdVlHN0JMeUhTMTYvVHlaeWQy?=
 =?utf-8?B?cTJnbkVoTlVkcUVnZE9VZ3M1OTRjR3BvR0VrQXdjeHhLSTlqbVM3MEhjenFl?=
 =?utf-8?B?VjB5ZWxIbGVnOXpKRzVDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1VqakdHeThyY1Q2NXJ3YzYzaCtSQWJleUdhNmsxemFMTlNmK0xSOVBxdUc0?=
 =?utf-8?B?WnpINDEzRG1PY1RGS0RBRkZNYXJIL0o1OVMwVGJRODFHaVZVd3RJTlpLYkJk?=
 =?utf-8?B?dDBXdkl6UnFPNVJqYnlzRnRsSVhyRWpkWGJ4cW9NcTVsMXdCOGRvSW01M3VD?=
 =?utf-8?B?eVFKbFZtdFMrZUY4Zi83YXhWZkxtb2NSNlBCYlJiSHNBSjJ4ZTQ5RDRSUENh?=
 =?utf-8?B?azgrMVdZSitmYnpiWGdWeURhZWpoOTFpOFFvRjBuL0F0RkVKeExGWWpkWS9m?=
 =?utf-8?B?Z0RuQ1ZhQ0pkK0ZBZENlOUpnckRSVjB2YWkrWko5Sy9IcFRSWFZha3JVQXhS?=
 =?utf-8?B?NGV0VWIxWE5zalpLRXNwUjhIVXBlQmRwbDRWeGhrYi81WmEwbjhORS8wU0I3?=
 =?utf-8?B?QlFFemlUbWpwL3JyUUJjTGxLQUZvUkduaXB6aUdmalJudUE2c0tNTEtYK2pX?=
 =?utf-8?B?eG4zOENMcm03aG9uRW1rZFN1U0hqVnllc0E2MWFEeHY1Mkp2ZWNlbDNnUHdH?=
 =?utf-8?B?YWluRmg5blpvNDNuYmphVXpyUnpMdTlleXhKdjBKYTNvMTR2REpPZG4zMzFh?=
 =?utf-8?B?eHRWSzNsTnVTazVzMmdtOTF1VFRON0hsMmFMdC9Dcm5KV3JZbzNnL0Q4RklW?=
 =?utf-8?B?aWdzdXdPK2h2S0JGUjRTN1VYUlo4TXFKSVFZTFF4S25qQnVReVlEY0tSUjhH?=
 =?utf-8?B?UVBtbWtVS09HTFBjMktXUXozSi8zTk9QT3lSVnorTzRZcUNSVWFtb3hhVHZY?=
 =?utf-8?B?cE1ONTQ2Y0FHVDZNelVZZldlbTN1VlpWSDI0bVU1QzJXM2ppd2c5aGdWazly?=
 =?utf-8?B?NElWQy8xMHJrL1d4TTVxVUV4VGYzV2dsVjRwRXlENFVrY0tPazErRmZ1bk5I?=
 =?utf-8?B?Y2lLUjhxNmVzbzE4TlpKLzU3eXRWcWtIYmlVRU44SXZJRGNJaHhnejBTRmI5?=
 =?utf-8?B?WW1qMDltLzVNeVdlbGRjSzBKSWhlUU8wdDJSNG1sZllrTWp5YkRrOUhzNmU3?=
 =?utf-8?B?a0tyTkdUc0c5WDBPM0ZxbDl0YUNUR2FWVy95QTB4V0lxbzFGV0c0L2JGeVlQ?=
 =?utf-8?B?bWh2ZzJJV1FYRW1BN2M5YXJUc045VEd4MzVFU1grelo0MG40bnU2NjVZczQ2?=
 =?utf-8?B?NkFnSHJHOGhGakIyTndWVk5KQjZ0MnF0bU9BR0M2enprU0Ztdk4xL0dxVU9x?=
 =?utf-8?B?dTZ3ZFh3aEhwdUlxSDlmQW03VjJkVXBndGRGcFlmZXcwUnhrWEVUT3cvMkxj?=
 =?utf-8?B?cDB2Nm5uYndwaDRmeFYvbEQvRXNSUU1FQy9kYUdLWXlrRUR4WGJ5Njg5ZHpX?=
 =?utf-8?B?SXVEblVaOE0wT1lmakVqUkNzY3JDbmNSZ29NQk54bkpTYk1KNWR1d2VkdTNJ?=
 =?utf-8?B?bU1DV0ZEc09LbHY5K0RGcis2cm1lUkVxNkZjZ0N5a09aRTZvTzBrb01oTkI5?=
 =?utf-8?B?ZFRUOFliTFljbENybGxkSHpjOVdFTUlrNUIwdVZxeTlrcnB0bmJzaWxZa3NZ?=
 =?utf-8?B?Tmx6VW9tQ3UzOGFGWmgwWnRpRHM0MFl2em9qaDJtbk9GOUI1UUhlN1FJRU5s?=
 =?utf-8?B?aXBBUmxhRUhBZU9FTzFYRlV6RkZlUU5UV1dYZ3daZ2VDOW1TQWNjUEFpYjhx?=
 =?utf-8?B?a2JsSjdBY1NXOS81VjdrT1dTSUhDQ1prSDA3cGVtRzBVVGtTUTQ5cjhJUnBX?=
 =?utf-8?B?V2lXNms3VnN1VUpRa3RiNkVhQmRYZmNQNW12Rjc0ekZ3Ti9xNE9MRkl3WTEr?=
 =?utf-8?B?U01uSjg0K3hWRVV2NXk5cmR3eGZTTDJkaXdYL1p4TitUNlB6b0RIUVlBMTBi?=
 =?utf-8?B?RWRnZkYzY2tUOXVFWkc3MnM5aDZnMFg2a0QzbjNwWW84U3p4elV2ZHR0d2xo?=
 =?utf-8?B?V3F3dXZQVFZSL1lQOGhwUkYwNnVma005RmlCKzJzZFRwcFk2TXVBUFNGSjVE?=
 =?utf-8?B?dW5UT2RjSFljQ0NDN2psRm1xQjVqRWd0NWZCbWVheUdBd0g3S2U3N29lZU55?=
 =?utf-8?B?TVRTL3N0dmNCdEFUK3JsOCtzT3hjMytjTkgyeFFhK3ZYMFRDSWdsUmhhTTV5?=
 =?utf-8?B?VjZzRlVwMDkvMk5YL00vMTQwMERVa0g1MmZFWFd4WHRBeGFkSzk4OUdIWjR5?=
 =?utf-8?Q?N6IAyidaGbcq+lG9NJnbNOHvj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44a1424-a648-428a-38b1-08dcb1e33a4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 04:34:27.6687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwB/BD2UNXifluPVTJHNjyNfR3iuSUWG/zUxNhNvDnWvGr46WpvvUL/Cha/WcmFv8gR/rTJypN+ZmzirLx3BGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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


On 8/1/2024 8:54 AM, Marek Olšák wrote:
> On Tue, Jul 30, 2024 at 8:43 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Adding NOP packets one by one in the ring
>> does not use the CP efficiently.
>>
>> Solution:
>> Use CP optimization while adding NOP packet's so PFP
>> can discard NOP packets based on information of count
>> from the Header instead of fetching all NOP packets
>> one by one.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Cc: Tvrtko Ursulin <tursulin@igalia.com>
>> Cc: Marek Olšák <marek.olsak@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 853084a2ce7f..edf5b5c4d185 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>   }
>>
>> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
> It would be better to have this function in common code instead of
> duplicating it in 5 files.
Although the code here is seem but its architecture dependent. Keeping 
the code in common file also need to redefine PACKET3 and PACKET NOP etc 
in common which are defined in soc15.h
So it was suggested not to move architecture specific changes to common 
code.
>
> Marek
>
>> +{
>> +       int i;
>> +
>> +       /* Header itself is a NOP packet */
>> +       if (num_nop == 1) {
>> +               amdgpu_ring_write(ring, ring->funcs->nop);
>> +               return;
>> +       }
>> +
>> +       /* Max HW optimization till 0x3ffe, followed by remaining one NOP at a time*/
>> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
>> +
>> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's */
>> +       for (i = 1; i < num_nop; i++)
>> +               amdgpu_ring_write(ring, ring->funcs->nop);
>> +}
>> +
>>   static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>          .emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>>          .test_ring = gfx_v10_0_ring_test_ring,
>>          .test_ib = gfx_v10_0_ring_test_ib,
>> -       .insert_nop = amdgpu_ring_insert_nop,
>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .emit_switch_buffer = gfx_v10_0_ring_emit_sb,
>>          .emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
>> @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>>          .emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>>          .test_ring = gfx_v10_0_ring_test_ring,
>>          .test_ib = gfx_v10_0_ring_test_ib,
>> -       .insert_nop = amdgpu_ring_insert_nop,
>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .emit_wreg = gfx_v10_0_ring_emit_wreg,
>>          .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>> @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>>          .emit_fence = gfx_v10_0_ring_emit_fence_kiq,
>>          .test_ring = gfx_v10_0_ring_test_ring,
>>          .test_ib = gfx_v10_0_ring_test_ib,
>> -       .insert_nop = amdgpu_ring_insert_nop,
>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>          .emit_rreg = gfx_v10_0_ring_emit_rreg,
>>          .emit_wreg = gfx_v10_0_ring_emit_wreg,
>> --
>> 2.34.1
>>
