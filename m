Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D365606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=PM7Mksi4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F24010E20B;
	Tue, 10 Nov 2026 01:44:23 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011032.outbound.protection.outlook.com [52.103.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF6810E20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 01:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cljjja1XZGbHXXDZD6mjPdQt0YkdbWh5oW0OCCXpBC4QPMy8jY48Y90I9GVmUrzQvrfpQzMwejkddj37/g62F6CJ/aiaKv+wcE/OkLIocVKA4XBT7psuHdfx7DgVAOsJ78PLvED+u4I7vMqnaQzGmrHgoWKu75H3Am0qk9544tptUldP1w8l0S5bEkMpDb2pYZCw0vd/ZcD34hD9LrA43xKdWps4iIwRxWwcgtC5lapINkBDiPvdYCd/sAfk89p4AnmjZuqCBHBBAhcaQV0zHwHpcU63tepLHAKVqVNn6bJreQPiobKv1vfOb1HitJKAHVl1WB721dYx2hAHi9ISIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yCmqnLvIs7f95gd8TEbu6sIWtiO0BQkxaxAvHco9aY=;
 b=LS18N6YVUvROgGuP/O+H832pZT8PoVRxOeJ2q+pUi3YhV5Vos/ip8OE1T7cJ4GWfvR085J2NegkUJ5a3skiuUCTsDDj0/lMrbaR7RnU9vZLPqltQqghjOMy3NfmL3nV+aDbJEgEwN6WBRRh+VtmcCxl26LKUwU6hneR7s+XVUEp6ysdX+Q+tai4YYJrshStCvggpWH5tp/hbazTgVPRqjm2eLo8UUrgo1yA/VHqXqi3SGWVhPC4jhFKSGAREKKudGUZBonLWSf2K32udRpOOLDczDcnNVE7+J7S1ZgI6va4ijYQPnz7/yf7iXvgYW0wde1SCdX7qWlG7aO/6iXEvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yCmqnLvIs7f95gd8TEbu6sIWtiO0BQkxaxAvHco9aY=;
 b=PM7Mksi42PfqRS3UxKRWKufTjdwJzcVqy7f2ggDVSAShnwheAxFQvvaYpCKEWdrxLSh+vbSRybYRKHeJ4lnAxLEcVuQnqwP5nj/r8Gl0LNhaxbEAE0Dbaoz0LoGtAiyQijzEN6LU7W06PSJ+9DhOFjcNs4PW+SXeG8qORS+pxCCsXDNmbNq4KRIICnTmHaMZVuQ39uIBHSPWClFTyE1MIHSxf0din7DFp3XIaBATisL+dKMOEP3vkFI7VaMbBeZ/K+kJoXdd/1WxmOiY93lTPTOnfhXdxdl8vnVJ1kyxvTClQtPWKhK76x09W4kkOljbRimgXwZv8EE4b8XxkKs+vg==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY4PR01MB12957.jpnprd01.prod.outlook.com (2603:1096:405:1e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 01:44:13 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 01:44:13 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: [PATCH] drm/amdkcl: run the remaining foreground probes in background
Message-ID: <OS3PR01MB102510E3381EAC477967C91D2E7722@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Chengjun Yao" <Chengjun.Yao@amd.com>, "Bob Zhou" <bob.zhou@amd.com>, 
 "Yang Su" <Yang.Su2@amd.com>
Cc: "Kent Russell" <kent.russell@amd.com>, 
 "Flora Cui" <flora.cui@amd.com>, <amd-gfx@lists.freedesktop.org>
Date: Tue, 10 Nov 2026 01:44:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::15) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID: <c4eb1a75-6bdb-41bb-b0cd-d85095085368@milk.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY4PR01MB12957:EE_
X-MS-Office365-Filtering-Correlation-Id: 39767fa4-2a60-46fd-3dc5-08df3ecc1f3a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|41001999006|55001999006|19110799012|24021099003|25010399006|4140399003|22091999003|15080799012|24121999003|6090799003|5072599009|23021999003|25031999004|5062599005|51005399006|12091999003|40105399003|10035399007|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFpXUkdYMzhRNVdQRlVGSEpBLzNGL21WTVVlRzh6c0k1OXNjVFVJQmxldFY0?=
 =?utf-8?B?M3k3dFpSanlIY05FMW1jT2U4VkcxcnRrWEk1SlBoSHhGTlQzSDhmSC9JYnND?=
 =?utf-8?B?dy9CRVludHllN3lKZS9zQVRSYUF0QlFrNzY1bjhyaVI3Sld3MWRzY2ZGOHNM?=
 =?utf-8?B?UUtySytNc2pBdWM3VXZGS09HYXBHbFpQYXppcC9VaElCeXppNXkzQ0RQOWY5?=
 =?utf-8?B?V0szSGtMTVNXaVRzc0ZBR2srOXE5cFpzb2Y4REk5aHRiY004MmR0ZnJzc09Z?=
 =?utf-8?B?cWliWnVWZU4ycEdKeDJCWW1BcFRWSVdTeXF1ejV0Tm1qVEZuWThTbWEyeHNR?=
 =?utf-8?B?SFU0dFNDN1BFSUZvUytuVnc3dy9BVTVMeTRFRW5SOWV0MUVKdnZOOWptNHpl?=
 =?utf-8?B?cWw1UFZSSHZJOWZ3ZjRmT1RmUUFTVnJiMFdYNHdDK3BFQ3N0TDdSSG9Xcm9S?=
 =?utf-8?B?UTcwN25YdkJRT05KVUlKLzNmMTRJTmpkWSt0RkN4cHVBbGEzNm9tY3lic1k0?=
 =?utf-8?B?aEd2dnkxOFB1a1MrekladmhGenB1eXIxRVhyRU9NUjBJMDZQbEpQcGpUeTFF?=
 =?utf-8?B?T01SS0YraHhyRE15MlNlcHZsa0gzaXBmcWZ3R3BGTUdJNHZKRDB6Qm1ONWQv?=
 =?utf-8?B?YkkwaFhKb0Qwb0JSV1lvNkRRMkFhV3c3encvWCtuTXVzVUZzSG43WUhYTWVk?=
 =?utf-8?B?clNLZUU0TStHaTg5UUNpVS9NeGpJdmw3eGpibm81UTBkZ1dDMU10Q08wUjd0?=
 =?utf-8?B?WktLVEJPbE5pK2dVZG9YOUw1ZVptZVE3MW05eUxBQzUvQUMydzd4dDZTNlhI?=
 =?utf-8?B?YjhFY0JNS0w2THh1Y1VQZlA5WE5KUlVXbWRJWXhEZTAya2lEd0NlWlNGM2kw?=
 =?utf-8?B?cllRUHVoazdvdnFxVHdKV1ZJaktNT0xNQmF2U1UxcUkyMEhTc0taYUlXUHl0?=
 =?utf-8?B?MUlCa2xJdUdmMHNUZUxjU29NUWdFTVR1ZU53WFJaNUtycTM1ZklkVnp5bVhi?=
 =?utf-8?B?UDdmWXBhV1Ixa1Z4Yk5EbzlKcVFYZEJ3SC9EUU9UV0x1bmpOamZTbnl5T0xy?=
 =?utf-8?B?ZFJTQW90b1FMWkJ6UllLVU1FRnVocDNpQVBPOFZwb2lJUER2dTI5Wmt2UVZz?=
 =?utf-8?B?WllNS1IwQ1pnbmtrSGp0Lys4WkZQeTl3dGdsemlnY0QwcUZHVkxsbmNlWDl2?=
 =?utf-8?B?aTBaZmREczQ2Mll1TEJVdis2SmdrYmFnUU5CUE9BYVQ1eGFEN1YvTHVVb2V3?=
 =?utf-8?B?cEhFZ3NCQ253QzlWdDdxN2xLMmhMcW5wYjBibzRJbEJ4MUZGbkUrVWExTlRG?=
 =?utf-8?B?eElMK1VqekdmL1FIUzRYLzliWW5lTEV1NHRXSTByU1lpZVIwLzdGd09KMFQ0?=
 =?utf-8?B?OWUxcWZXVGw5UStydW85aEZnajNrZU5JQm8yaDd3dU92ekRuZHVnY1ViQVlO?=
 =?utf-8?B?NXNlcCtyVjN6YlQzVzdNMk1YdWpJSkJSTmVKVW12WW5FUS9odFU3bFo5L1E1?=
 =?utf-8?B?SjJBalB6K0lTNGJZRnZkY05uTkRJUTRTSEFPbDVNdEZleUJmN1hCNStjZTFT?=
 =?utf-8?B?SUNBQktYNG5rV0x2ZEowL2UzUjBzbjh3b0oxQmhTUFQvRkdOalI3TnpoMjNW?=
 =?utf-8?Q?kh1t4teSrs1VnPS2wlC+EFVYxfgbG0fApzYG/bCi3UCk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1c2RXVDcHJnN1JSeTI1WmZUZ2V3bWZsSHhEbTF4cGVmdGxEeWdpVldFbllG?=
 =?utf-8?B?dXp1V0RMRTZSa0RidGdiKzZQNXIxK2YzUnhIL2VvWXBwaGFzTVBJZER1eTZV?=
 =?utf-8?B?UHppall3RFRsMjRKcFlnTm5wbHFGUWdvYWtCenNRZjgwYUhGVWJFZlZtd0Zo?=
 =?utf-8?B?bTZPQnM2cVJONmErNGRBQ3ZKNVlrRzlsZVZBREVyMXNpQytnM29rMGZJb0du?=
 =?utf-8?B?RnJIT2RneC9KRG1Lb1NJc3ZyR25ncDdheXk1MDAycS9FeDVMR3UzSFFOd0V4?=
 =?utf-8?B?aFpSc0JnMkVkY20vTTUvOW9VaFpFZGZ1d3V3dDg2ZkxUM1drUDBEU1A4TS9B?=
 =?utf-8?B?MDZia3pvUmZIZm9YNkZjeDMxMmZqR3oxY3ljYjRRZzdwekhPem5VZVNXa0NJ?=
 =?utf-8?B?ZVF2R1prcUZ6WXVkNm5LNzVnUmlHTWtjQURTZVFxUDFQRVlGZXljQkc3OE5H?=
 =?utf-8?B?Y2Y3TjBBMUdUbm1mdmgvQnlVOTBNUHJ0cjBIZlhGMUxMa2ViV3Q4cU1HMUY0?=
 =?utf-8?B?cVNkbk0rUUt6SHpRWFZFNlJGVXNCZUcwQ2pRQXZkNGhIK3BKNm85aTFaWU1W?=
 =?utf-8?B?Z1RseWIxVlp5ejRBS3hOVzFrWVBHMk1aOVN2N216eXpoQ2JlbG8vZzNGb0Vz?=
 =?utf-8?B?akdQa2RJVVB4bXFYYXBGU1NubnNnMGN4THhKRi9aTzVFZTR2YlpseDhQejlL?=
 =?utf-8?B?eTJJM0lBaUJaazJrUitjNGRvZkJWZi9nNThUN0ROaGdmcEZNNnMrUWUvR0k0?=
 =?utf-8?B?M2NiSnNocGw0a21mNndDdy9neUdWQmV1RGZXUHpickJCMTQ3N2RwcEJRQWFY?=
 =?utf-8?B?Z2NVUkphRCtjUUtjZVdzNDE0bHAyU2p3bmJPSmZneEVLR3JDWmgwZkZyWVNh?=
 =?utf-8?B?YloyRFBpQ1k0L2tzTWRRRDFVdGJEL0RuR1lyWGQzZUdIbStBcjV3UmdEbytJ?=
 =?utf-8?B?RnVFeUZBeElaQXExTjRNSUFPdlBiWnYrY1JCVXIwb2h3alM3Y3gxaHo0WFVx?=
 =?utf-8?B?ZEVPSUVxRmRnckthLzIxOEtwbFptVmphZ1dBcDZkaWNaZlp6M2tKVmlnRnY5?=
 =?utf-8?B?NE56aWhyRkdwRkNHa3ZwMnU2ZGkraFh2TDYzam1Xa0NMblVMYkVwVTNCcDNV?=
 =?utf-8?B?T2ZlNitwemc4V0xNQTNSK05yY2hBeHlLMUV0Sm53TGdCdy9SY2I1TlJtZGRS?=
 =?utf-8?B?a1k2OStyNUVOR2p1OWRhQys2aXpWWmJGeE53K1JiSjdxYTFiYlFGZk14QkR2?=
 =?utf-8?B?S2dHMDNHYnRwalRMNUQ5MzZ0Zlhld21QbGdueWZ6YmNteDhCRDlrOEdzdFN0?=
 =?utf-8?B?SDJoWmRsVkI0dExQcXd0akQrSHZBbll2TGtTMXBXa0lRQ0FlUUUzK0JvSVFM?=
 =?utf-8?B?MWZxdTlyaDRBVW91ellwN1dKc0lGczRNVjh5VzZVWVY4STNKOFNLQXg5dHJY?=
 =?utf-8?B?dWZyUEcxRWxjN3pISnE0ZDJPaHBTc0J0cFpqZ2E2K2EwQUhoZlNKZ29ETDVu?=
 =?utf-8?B?TmFSR0ZWMVdadGlIVTRxMEpQSk96djZSNm5qUHFsQklTVWZvZENaU2NDRlN0?=
 =?utf-8?B?NUlXcGUrYUtFRVowVklZL3NYTUkveVd6bE1lY2lhU3lmbTBRSWJSVkFJc0w3?=
 =?utf-8?B?YWJiMm1uVEs5dkFZU0ZqR2kxYldhNTIrR3REekpGSDdMZ1hUdXc5N1d6YlIz?=
 =?utf-8?B?Z3MyeVN5RzNvYW1BcXFjUkNScFJ2VElUdm0zbTROVWdGdWcwSDUyYWVDU3FB?=
 =?utf-8?B?R21mUGV3clB0cUp5dTV1cUFvck1xOU5zRzFDT3M2eVg4a1BiMnNmVUpNVmFX?=
 =?utf-8?B?aEVnTWZoTmFQZTRMTXhsa01ZejQwc0djTW5JcHlIV1pRVXAyWGRaUE1lNDQx?=
 =?utf-8?B?VENDem9YWGMwS0VqSDVPNmlKMkNwK3BHK1lKdEZNTHVJK1E9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 39767fa4-2a60-46fd-3dc5-08df3ecc1f3a
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:44:12.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12957
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HDMI and DP colorspace property probes and the legacy gamma probe
are the only top-level probes that are not wrapped in
AC_KERNEL_DO_BACKGROUND. They run in the shared configure directory,
one at a time, while every other probe runs in parallel in its own
temporary directory.

Running in the shared directory also lets a probe see a conftest.o left
there by an earlier one. Before commit a4e55d0e6d9a ("drm/amdkcl: string
objtool from cflags for conftest") the probe command ended in
"; objtool ... conftest.o", so a failed compile was hidden by objtool
succeeding on that stale object. On v5.17 this defined
HAVE_DRM_MODE_CREATE_{HDMI,DP}_COLORSPACE_PROPERTY_2ARGS for kernels
that only have the 1-argument functions. That commit removed the cause;
running these probes in background like the others removes the shared
state as well.

Wrap each probe separately rather than the colorspace group as a whole:
AC_AMDGPU_DRM_CONNECT_ATTACH_COLORSPACE_PROPERTY already runs in
background, and a job started from inside another one is not in $procs,
so AC_KERNEL_WAIT would not wait for it.

The generated config.h is unchanged.

Link: https://github.com/ROCm/amdgpu/issues/228
Signed-off-by: Jiaming Fan <fan.jiaming@hotmail.com>
---
This was a real bug in the ROCm 6.0.0 DKMS package on kernel v5.17, which
I reported in issue #228. It is already fixed on master by a4e55d0e6d9a,
so this patch does not fix a bug there; it only makes these three probes
consistent with the rest. Feel free to drop it if you prefer to leave
them as they are.

 ...rm_mode_create_hdmi_colorspace_property.m4 | 40 ++++++++++---------
 .../drm/amd/dkms/m4/struct_drm_crtc_funcs.m4  | 12 +++---
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_pr=
operty.m4 b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_pro=
perty.m4
index ecc33db..3d7eee7 100644
--- a/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_property.=
m4
+++ b/drivers/gpu/drm/amd/dkms/m4/drm_mode_create_hdmi_colorspace_property.=
m4
@@ -20,30 +20,34 @@ dnl # commit v6.1-5783-g08383039cd19
 dnl # drm/connector: Allow drivers to pass list of supported colorspaces
 dnl #
 AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY], [
-	AC_KERNEL_TRY_COMPILE_SYMBOL([
-   			#include <drm/drm_connector.h>
-        ], [
-            drm_mode_create_hdmi_colorspace_property(NULL, 0);
-   		], [drm_mode_create_hdmi_colorspace_property], [drivers/gpu/drm/drm_c=
onnector.c], [
-   				AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY_2ARGS, 1,
-                    	[drm_mode_create_hdmi_colorspace_property() has 2 arg=
s])
-   		])
-])=20
+	AC_KERNEL_DO_BACKGROUND([
+		AC_KERNEL_TRY_COMPILE_SYMBOL([
+			#include <drm/drm_connector.h>
+		], [
+			drm_mode_create_hdmi_colorspace_property(NULL, 0);
+		], [drm_mode_create_hdmi_colorspace_property], [drivers/gpu/drm/drm_conn=
ector.c], [
+			AC_DEFINE(HAVE_DRM_MODE_CREATE_HDMI_COLORSPACE_PROPERTY_2ARGS, 1,
+				[drm_mode_create_hdmi_colorspace_property() has 2 args])
+		])
+	])
+])
=20
 dnl #
 dnl # commit v6.1-5783-g08383039cd19
 dnl # drm/connector: Allow drivers to pass list of supported colorspaces
 dnl #
 AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY], [
-	AC_KERNEL_TRY_COMPILE_SYMBOL([
-   			#include <drm/drm_connector.h>
-        ], [
-            drm_mode_create_dp_colorspace_property(NULL, 0);
-   		], [drm_mode_create_dp_colorspace_property], [drivers/gpu/drm/drm_con=
nector.c], [
-   				AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY_2ARGS, 1,
-                    	[drm_mode_create_dp_colorspace_property() has 2 args]=
)
-   		])
-])            =20
+	AC_KERNEL_DO_BACKGROUND([
+		AC_KERNEL_TRY_COMPILE_SYMBOL([
+			#include <drm/drm_connector.h>
+		], [
+			drm_mode_create_dp_colorspace_property(NULL, 0);
+		], [drm_mode_create_dp_colorspace_property], [drivers/gpu/drm/drm_connec=
tor.c], [
+			AC_DEFINE(HAVE_DRM_MODE_CREATE_DP_COLORSPACE_PROPERTY_2ARGS, 1,
+				[drm_mode_create_dp_colorspace_property() has 2 args])
+		])
+	])
+])
=20
=20
 AC_DEFUN([AC_AMDGPU_DRM_MODE_CREATE_COLORSPACE_PROPERTY_FUNCS], [
diff --git a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4 b/drivers=
/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4
index 6b53674..9e9acbc 100644
--- a/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4
+++ b/drivers/gpu/drm/amd/dkms/m4/struct_drm_crtc_funcs.m4
@@ -23,13 +23,15 @@ dnl #
 dnl # v5.10-1961-g6ca2ab8086af drm: automatic legacy gamma support
 dnl #
 AC_DEFUN([AC_AMDGPU_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL], [
-	AC_KERNEL_TRY_COMPILE_SYMBOL([
-		#include <drm/drm_atomic_helper.h>
-	], [
-		drm_atomic_helper_legacy_gamma_set(NULL, NULL, NULL, NULL, 0, NULL);
-	], [drm_atomic_helper_legacy_gamma_set], [drivers/gpu/drm/drm_atomic_help=
er.c],[],[
+	AC_KERNEL_DO_BACKGROUND([
+		AC_KERNEL_TRY_COMPILE_SYMBOL([
+			#include <drm/drm_atomic_helper.h>
+		], [
+			drm_atomic_helper_legacy_gamma_set(NULL, NULL, NULL, NULL, 0, NULL);
+		], [drm_atomic_helper_legacy_gamma_set], [drivers/gpu/drm/drm_atomic_hel=
per.c],[],[
 			AC_DEFINE(HAVE_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL, 1,
 				[HAVE_STRUCT_DRM_CRTC_FUNCS_GAMMA_SET_OPTIONAL is available])
+		])
 	])
 ])
=20
--=20
2.56.0


