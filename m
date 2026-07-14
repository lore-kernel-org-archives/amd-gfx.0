Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3BEC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 10:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C3C10E67B;
	Tue, 14 Jul 2026 10:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1QANvH2+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F9B10E67B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 10:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLHCNR6eStj2PuuHPSBA29oHC5iYxuPgWpVO9Mvncys6yJ8XLqa4KLmcDohLZ8efQaEwlnjKbapLfPt8/QyVu/U9q1gS+sFdqTocAmTkULOoC/IHw557pwu0VsFa0vFR5dBc2bIPZgtDp5IjOHJvc0d8dFgvkbpVyVev6dYG7O+XsGqKXeZ7lFY3kCKQkWg4YO1Zt6Rvi9VfB3cfsKR7mOTrxNiVv9xMcuHEZ9mh5qq9u5wB8wm+ZkRd9DwVuIhwQFzh0CpvMoCQM+y8QtZ6esLSWA9bQnCJ8bQ2zk9KwnJnTriBSR9R+BVXFB74wu0fdScMZt0xRfs1wJ5tBWwcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uPEHuUTeAAXZwBGMbopAxKbnr8rsJzOPDw4U4T8MRc=;
 b=ihSNjvyqgO4kLn9U0jORz2ZZ19UtdGOqKIzLTCS2VpE2OlkEWjfFkt9gpF0725IAHNonJ8K4lxFpMWXXJfM1nUFnF49PTusvkkpsrYeXR+T6dcKMAPrQECVN/7LVsnjcgFdb4t845bXkSYPXX7XnYa54RB9i9AHNNpBqRdivGV+Tclzmv8H3hHa4cRJptCrx5c7LnIVoP0k/i+09sWYhi9A9e6IIJ9mj0tC7UXiNjMoFGbZArpCqKaX0JVJ9Sq/JHzfyQICEieOYVpN8rTMlNep74sxH0eYwgUq8Q09FG3+KkVT19ETn/1ELGYiTmtscHshqWF/kHvsiTjolZ0zsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uPEHuUTeAAXZwBGMbopAxKbnr8rsJzOPDw4U4T8MRc=;
 b=1QANvH2+07mRFYg/UHSYt+EarEgM0A+zUwgIbWqy7zim+yC7/Uq+jjSHmkwKFcc/ft1auQKHDcwnnpCIAqohCfax1quoyJkgUlc2awiTrMuuwxIUgteeepQn5TTghcfJQrMCOJFfnun8kLheac56YU3M+OEx9u6diX564FOW+Ls=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 14 Jul
 2026 10:27:25 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 10:27:24 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEwemLj48Zo5+FEGWvILeBy4uu7ZsZOoAgABfvQCAAAuG2g==
Date: Tue, 14 Jul 2026 10:27:24 +0000
Message-ID: <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
In-Reply-To: <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T10:25:40.2600717Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS7PR12MB5768:EE_
x-ms-office365-filtering-correlation-id: b13f2fef-118d-4a5f-efcc-08dee1927f28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|8096899003|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: cZYf1GaMATIVYZ8f3miFvBlraItILQXasgRlicsa+tFxScHUJjdwURjbS2C4qKmy/b21iEc674UNFhncWd2BoEXH6rfkXhXtf/mLyn9gYWmrHO7gxL0c/0XbfPTNHFVRnx/6mNiUzPjy1I84Oc2C8dM6U6/Ei5vO7ToMfMPM50DOGa4qMR1rIUv0+abYeZMOwDfnkz0aRdbnUu1H3idhbKXQ0mk0+I21wdF8SOeJIhHTsW9L5GEamQm/33zpOqWLGfSnLW3UBN6eAxKMA/oOaxSUyb0iodXQR2xSUs9vvb9xD+0RHl27dEAOv4KyblBkq9HnNGFMWSkN2G9t88mLMhla5qheaX/Ply9HhUC3lGFGXUYCLP/kh8WvCZaqKv11vVPWE9zaw284lbuhPgtkAy9VnoMVwsMVP/mJjOCcvFw7VKmh2Y+FhEczoW9dOoVjYznWXUz73OVeZbEgD4M9wDXR5WH3L6otnJKh/Ri0UbphmuQJ/P/gsj2t2uf9iklTEKKzIdRhVEBW1FNYkNEbgVUdaeWRKaWQkUzze+ir+35kjLk2lOq1hC1zGbp5GaBNyQSxZuIr5pR21FY4xYbGIIyTs6RUV6lrG694YUo8LCDqlZ5cwWw655/pd5kONJfhLsLNyZDhzw08/3RXI1nSm/5nOfE3Jvfp4axDc6afT7c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(8096899003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UWW2/oszVqYGBKsqQwcXfTf6qyTqcNQeYc3SBvjpO9LXATCIOhOcNN3ket2a?=
 =?us-ascii?Q?cGmoUFJY8OzXeNKg+zcpoIceSCmdxG4BMD1oKSWjCO0zVbSUWHCwiH2b3kh0?=
 =?us-ascii?Q?chaObmFGWfYyogfwXi88kruusJpzZKO4CBB3B7Ynx02XD2Z5wjczoxx9x6C5?=
 =?us-ascii?Q?7TFNTzNENJwA2KyYYfnRpzIXHVlRPBGljWERoDxFQLy8wZRe5DDVb3V7aCg2?=
 =?us-ascii?Q?CxiUOxaXEX8k/QMmhIWAz+kOYfBKp5tjWBdMSADX8x9sE2MGfroCxuZiLpoc?=
 =?us-ascii?Q?9s6kitSUYpoCQbR43DGiVgg7/XU8aTEeb50DHNtUumNkQQYbkq69sizAqAWI?=
 =?us-ascii?Q?7djFZ7yJw0sRTPHZKIMZdEWUMGV20ZhXTNx6vepakT+5DCL+vyvSozFnVT59?=
 =?us-ascii?Q?XR6RkuvAu/hyjMxW5vhAkT81lKxyN4w1c5AJ1S9YCfw54ERWWOhwZ7pCQpFJ?=
 =?us-ascii?Q?uhTh+H2X4oIcKyXndI6Y+1xtLCibZKBaLScd/vG/xqK7wzSOv2O424V9ekOM?=
 =?us-ascii?Q?V6oIBwxqdvIsQSjGogElD9OW4PkGo8Vyu0IuLWM0V5GYiBNjhOP8B4URwDsM?=
 =?us-ascii?Q?8Oeyae+3Z9LJreFmCpAgw/TIUxxM03v2yEQcJjhqCElieJ8EAqQDUzzCKq5Z?=
 =?us-ascii?Q?8rjQMMagW0Z4tOffFURYGuBIyELm0chgxHBJawX32e5zKxHdFst4knReVy1e?=
 =?us-ascii?Q?8OfOgfnqGsSLeJI6H2n6eDZ9s7iBMTE4uSKFBmBo3SHPg7K56g2e/qnuopcw?=
 =?us-ascii?Q?hGFBagx85hhWq6ykgSdKvuwPa5ch0Iydu4yZXfUnL4/Te3QTfQNLq4LFBExU?=
 =?us-ascii?Q?RgKl7jzD+F/SL/K7EwPkRPL5k+apN8RMI6OtAx0bQ/fJFtOQ4bx6mYzQCnCB?=
 =?us-ascii?Q?jnRGSRi3f3WL9shTpdFXzfuE+lx7RxpLu9lLbLRdXcUjwtLxbtdFYeS8k56p?=
 =?us-ascii?Q?kwXzGPcHzUKUAn+jzs1qDe+9+gzdKu7fj9PmgzhFmLl1Pd6zn/acPSKb5FeW?=
 =?us-ascii?Q?EnJueUuOVsDRVcvtW0UWo7G1xuz9GHhs+CV/+N/f//Jklf159GuyyKMI/u7G?=
 =?us-ascii?Q?WlTxoklbiVaYFuu7yKr3mwLzLo1FPOMuh6W7vLbU687lHp5LU65Wjl22uVn6?=
 =?us-ascii?Q?pf0NFp+UgrR5xYQ7fvl/bjSaVH/qp92N8LNrdXmqrq5Y5fscfMJhorRH58S3?=
 =?us-ascii?Q?Lrr6XsyDRz+ZMLEfq3XbQmiSV2Z8+HrPtv+X5GGzTDo7U0lloVM9iWfxlEMl?=
 =?us-ascii?Q?hn2PmWXoZlWQW4J5RQygLSLSCSP7SDPTIcuBblGBQUfHY1wX52zc/qsT2M0U?=
 =?us-ascii?Q?VyJcEbpxwkfmD78g/AldN0W6SHp+MOIYKc2CAbHnJKGjDGSvXX6srl+YewU3?=
 =?us-ascii?Q?P3MH4ssTkvMunxbON2/zXRxaGF29iNII0aFmgflziaZ5o40+q7oVyyJahVJc?=
 =?us-ascii?Q?2tMYZPlMmUJ9NyL2FT0OQgTpWtORdthi/Lh201UncOjNeH9DelOkYmnNqKkB?=
 =?us-ascii?Q?6nuD8wCnwUhPlrNSZOK0BiB47DLvQxtrMk3WuELTtKPZ5NoD/pdba25XG1i4?=
 =?us-ascii?Q?v0lC5hHtvUaXsQzcgqhnVJofp6pGFid/BeRq6ERGutDdM7954ohPPqrQ5qxF?=
 =?us-ascii?Q?tMl+RBchUi/zel7zCPSuoDtnGfYyofWYwMf05f2Ry0xovU81LvkPT5R69QkP?=
 =?us-ascii?Q?f4QA6SCANlW7Vny4RT4FfewGHxdjDbRE4Zjlz830fzpUST5Hgm5RbsCeQtHI?=
 =?us-ascii?Q?Oje2KmyPeg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR12MB8208F00938342B8FD8377E0090F92IA0PR12MB8208namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13f2fef-118d-4a5f-efcc-08dee1927f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 10:27:24.7826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9qgeYW2lA89E86r8H7JCUcaCA5SF6VLr32ZMuzNfpp5ut4UouTV1VC7Tz+JTG7tp1ozOv8y9u4vIchN6GUjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

--_000_IA0PR12MB8208F00938342B8FD8377E0090F92IA0PR12MB8208namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General



Get Outlook for Android<https://aka.ms/AAb9ysg>

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, July 14, 2026 3:14:34 PM
To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists=
.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com=
>
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets



On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
> AMD General
>
>> -----Original Message-----
>> From: Alex Deucher <alexander.deucher@amd.com>
>> Sent: Tuesday, July 14, 2026 2:09 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
>> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
>> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: [PATCH] drm/amdgpu/userq: properly account for resets
>>
>> We need to increment the reset counter, force fence completion, and set =
the
>> wedged event when a user queue is reset.
>>
>> mes_userq_reset_queue() handles this for collateral damage, but the call=
er needs
>> to handle this directly for the original guilty queue.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Cc: Prike Liang <Prike.Liang@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 6aa75da27f912..5e1262636e1e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
>> work_struct *work)
>>                                                         queue, NULL, NUL=
L);
>>                else
>>                        r =3D userq_funcs->reset(queue);
>> -             if (r)
>> +             if (r) {
>>                        gpu_reset =3D true;
>> +             } else {
>> +                     atomic_inc(&adev->gpu_reset_counter);
>> +                     amdgpu_userq_fence_driver_force_completion(queue);
>> +                     drm_dev_wedged_event(adev_to_drm(adev),
>> DRM_WEDGE_RECOVERY_NONE, NULL);
>> +             }
>>        } else {
>>                gpu_reset =3D true;
>>        }
>
> After the original queue was reset successfully, it did not update gpu_re=
set_counter, complete its pending fences, or send the wedged event.
> mes_userq_reset_queue() already updates gpu_reset_counter, completes the =
pending fences, and sends the wedged event for the other affected queues,
> but skips the original queue because it has already been reset.

What is the rationale of sending multiple device wedged events on a per
queue basis?

The question of whether drm_dev_wedged_event() should be emitted once per q=
ueue or once per overall recovery seems like a broader design discussion.

Thanks,
Srini




--_000_IA0PR12MB8208F00938342B8FD8377E0090F92IA0PR12MB8208namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);" =
id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(33, 33, 33);"=
>Get
</span><span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-syste=
m, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;"><a href=3D"https=
://aka.ms/AAb9ysg">Outlook for Android</a></span></div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>From:<=
/b>&nbsp;Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, July 14, 2026 3:14:34 PM<br>
<b>To:</b>&nbsp;SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;;=
 Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Liang, Prike &lt;Prike.Liang@amd.com&gt;; Khatri, Sunil &lt=
;Sunil.Khatri@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amdgpu/userq: properly account for res=
ets<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;"><br>
<br>
On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:<br>
&gt; AMD General<br>
&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt;&gt; Sent: Tuesday, July 14, 2026 2:09 AM<br>
&gt;&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; SHANMUGA=
M,<br>
&gt;&gt; SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Liang, Prike<br>
&gt;&gt; &lt;Prike.Liang@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.co=
m&gt;<br>
&gt;&gt; Subject: [PATCH] drm/amdgpu/userq: properly account for resets<br>
&gt;&gt;<br>
&gt;&gt; We need to increment the reset counter, force fence completion, an=
d set the<br>
&gt;&gt; wedged event when a user queue is reset.<br>
&gt;&gt;<br>
&gt;&gt; mes_userq_reset_queue() handles this for collateral damage, but th=
e caller needs<br>
&gt;&gt; to handle this directly for the original guilty queue.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt;&gt; Cc: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br>
&gt;&gt; Cc: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
&gt;&gt; Cc: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-<=
br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt;&gt; index 6aa75da27f912..5e1262636e1e9 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
&gt;&gt; @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(str=
uct<br>
&gt;&gt; work_struct *work)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue, NULL, NULL);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D userq_funcs-&gt;reset(queue);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (r) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu=
_reset =3D true;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;ade=
v-&gt;gpu_reset_counter);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_fence_=
driver_force_completion(queue);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_wedged_even=
t(adev_to_drm(adev),<br>
&gt;&gt; DRM_WEDGE_RECOVERY_NONE, NULL);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; gpu_reset =3D true;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; After the original queue was reset successfully, it did not update gpu=
_reset_counter, complete its pending fences, or send the wedged event.<br>
&gt; mes_userq_reset_queue() already updates gpu_reset_counter, completes t=
he pending fences, and sends the wedged event for the other affected queues=
,<br>
&gt; but skips the original queue because it has already been reset.<br>
<br>
What is the rationale of sending multiple device wedged events on a per<br>
queue basis?</div>
<div dir=3D"auto" style=3D"font-size: 11pt; color: rgb(33, 33, 33);"><br>
<span style=3D"color: rgb(0, 0, 0);">The question of whether drm_dev_wedged=
_event() should be emitted once per queue or once per overall recovery seem=
s like a broader design discussion.</span><br>
<br>
Thanks,</div>
<div dir=3D"auto" style=3D"font-size: 11pt;">Srini<br>
<br>
<br>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_IA0PR12MB8208F00938342B8FD8377E0090F92IA0PR12MB8208namp_--
