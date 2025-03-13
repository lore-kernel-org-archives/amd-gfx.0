Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C00C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 12:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604DF10E87C;
	Thu, 13 Mar 2025 12:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bvLDBkIk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB6910E87C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 12:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bj1RKzO3Y/9jZ7vgEB2axuwfXCwu5X8AhM23N4vYW5ra46Pql73ofGW1W7FKizdZroS6ZjlGGJ3eceBGSwU8A+5qG/pnB/WOExhaIXBGidEco3o6WfFV7D4AoZbq4XLLBOT2dm2On3qPCoXfuLzJpWgabxm92rIABQI8masfPDQZv9kyrvQJ84cjjd/XQzIlmCsyVJTnz2K55hoMbYSbkhVhUohpt5/oi8xyq71mgUaHYeEECr4NW8+oZFXJyj2iYoE+qgy1pvVRaCyqgHpH5pd6YFYDsouqdyP7b39VV1bRyt87UD1Be2N5bm8OM1rBVV/ZCUja1ntsGUDT8/DXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB5vbhxgVc73MKwZc6VR/IZUNLg084EViRC5kIt3J8k=;
 b=ZnRlCT6YjTJXQSeGVwJrQEU8/lXtQp6s3+MuM82GG0gOGbu4nqCswj3pBlcvxsrfmgJToZbnGknF2lAt5Fnq54iV+GcMjl7m4x75pq0O19tEr0q6VzU2BykYr8zj1W+hNCFaTdE/4mS/BkrBvNU3Ad67dkxTvC0XsmnGqud6xcUv/TEvuPu7JzOvYTIkBWlGvhSHE1EZI9KY9q3qmeQSxKr5WA5G0ZpdrlqkZcvWbVluTP6SvVmm2eCnNEP7wxPteSCnNSSA7kqoQ6AL3M4rSra8kcDTW6XwhqwukTWrjLS9nduH+X0Vp0pZFyT/ivw6gMVEoCRbl1eX4JIwOIvIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB5vbhxgVc73MKwZc6VR/IZUNLg084EViRC5kIt3J8k=;
 b=bvLDBkIkvYghfP5UXjMcI/RP4tfTjRfnZKLw12yo6L3X/h8YGQ89ULtquRYF7q67+yPiBmhXv+lgN5a4pRNKrWV3zFi3fZ/PlvqHISQPNGYTVrsW9+F3cRcsNRJepcwfvLli6pSmHlkHo6qt2xAYOfHNffg/5clNY1SOsUGuGrg=
Received: from DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 13 Mar
 2025 12:44:22 +0000
Received: from DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::241c:242c:562a:97a]) by DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::241c:242c:562a:97a%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 12:44:21 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] add mes type in mes ring dump.
Thread-Topic: [PATCH] add mes type in mes ring dump.
Thread-Index: AQHbk7kTnR3McE5UtkWqB2RiHd2S37NxA8e+
Date: Thu, 13 Mar 2025 12:44:21 +0000
Message-ID: <DS0PR12MB7993CAC9A2677C2B2BB3D91AF7D32@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <20250313014021.4163200-1-yifan1.zhang@amd.com>
In-Reply-To: <20250313014021.4163200-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T12:44:21.123Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7993:EE_|DM6PR12MB4186:EE_
x-ms-office365-filtering-correlation-id: 95456a75-1a4e-4a09-5a40-08dd622cc724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qLNUos0vzI9h0GriiubYY45qrNi2XZpy19B69GC1+hyEwHuQB5gCalzdK3?=
 =?iso-8859-1?Q?a2Vo/fjepHlZRWoUs+nF/66D6BUSp4lI82HFuCtvm5LJhFTRxyC55+2pZn?=
 =?iso-8859-1?Q?6E522QyG1Ohv4k3o2DRsNquSvFXa+8PGHlBXq6eXQTYeewXHq1C+Tf4Y0Y?=
 =?iso-8859-1?Q?bvEZmNI0pUqomUXYBuls8S1mvZjeRQ2Q/FNGnXlr4HB29ixhV5kNlk8UDY?=
 =?iso-8859-1?Q?yweHzrC9c7FrDqMyWBm1qTG+CT7NFbXzAaepk21sGUaDphkIVkjqGm3A2C?=
 =?iso-8859-1?Q?djF4HQw3UfcwZ0r/7d/gjz4Rbf1ra8oYGLutcs/WloppI4ev+T/Av5V2Ce?=
 =?iso-8859-1?Q?fkxBKW4MjjhEssun2odm4run2Zu+PoyQ2HGJ61iUldB48tlZFu+ANK854g?=
 =?iso-8859-1?Q?e+s3BhghJJYtbWsJQB0a+8Z/hxv0CCqZKl59wyG9SzYHOM2tw9V4pCXRIU?=
 =?iso-8859-1?Q?JVubeIiRNRWzcFojeOsyKwYiTCxCs/X6RjWkwO80obbrL2Of0MQJCS1rv2?=
 =?iso-8859-1?Q?5FX5gaZedBlvknYLEn68PneB8hiYYXzXycqhogw05kjFyVO1sko6TwSxWL?=
 =?iso-8859-1?Q?RK3EXjWMIWx2CE67qWazyWDlJd55qcfgVWkGt3F0CtlCfy3+Jc8dlqW6ng?=
 =?iso-8859-1?Q?ngrIbExqviGrNp2H8mXq07k+xoJCkm9ojkhxkiD042Xdo1rolevLGXd//s?=
 =?iso-8859-1?Q?ycN5b6zimutCZLjQmYoet/9sycwaN8n/QIWamTulbf1LYv8/Dpg2XfEISA?=
 =?iso-8859-1?Q?hA4Vdcgq0SasIsAMhXRbIo2Yz+tvsUr6F0tZHetzLneejY2yOLzO2ti3FA?=
 =?iso-8859-1?Q?k6cTM+O/4SLWw0mXfr/xMrfvvliyicdSB6EWo7YayrAS99X8/fu8JWbfdA?=
 =?iso-8859-1?Q?Z+CHXVQQ609txb9psEDKz45b+HEpEipD9W/3+oT9aE2meKuJo0fhRzCwoD?=
 =?iso-8859-1?Q?jRTilLsYHw27g6TnmE5F3CGDrVu4Ufy2EPuw6fARNoSDl2529+SlAAw4LW?=
 =?iso-8859-1?Q?OvDWaLvDT+282YVtcHir+kAMTwdxb+pVDLSAR23BzXuiQQak38/rhXAF4y?=
 =?iso-8859-1?Q?FCl+upy5KvSeGMJ7PUGq+Y2C0F9BCeKvHPhJkekjVZTyWtPnNCAL5hfIJq?=
 =?iso-8859-1?Q?QYv6cs9sl8wU7sLFE4gV9tG8SYOIu6u/BlAvm4NxCDuSD0ZW4RMG6/rLx/?=
 =?iso-8859-1?Q?IqiUwc6Z18rZbU3G0jeCi0q5wWaZP/DVwKt9RSGRylpboPgLR9JNT2JziF?=
 =?iso-8859-1?Q?oNfysO8cMLHshquTxL68DgwDvvu6C3ZT+Fo8no5z2eJQgWGyz/Q7vuZHvE?=
 =?iso-8859-1?Q?MBRN5PpvB6jJZYrcSjZp3KGkxSw77Xh2drHsW6iB/dob9db3M6BlDbDYkm?=
 =?iso-8859-1?Q?5Skj/TF9qpmYT9hZLXIvOHkznsIY/e9LsdSYmwfATVM/QtegcXI6LTynlG?=
 =?iso-8859-1?Q?wLfAgWFQxi4Mvo7bhepFjAJJxj7zTEc5qcP10g6CEH8aWNBY93Xkvo2345?=
 =?iso-8859-1?Q?IV1jBaQLqJSGJeegDRXQAi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f1MgLfn5mansNH2qDhxSHiHUl/DRs+SU6XIwcQrmIkBDOqs+r5pPt59XQ3?=
 =?iso-8859-1?Q?V0syhqNsUY8C6NaUGFAY9ZxpPfZjrwZVssFnuqLlXu8VwVUZaPNChUnw6b?=
 =?iso-8859-1?Q?00PrhZtPltaAvrFoMynye7O5SIkM9CkUp2YEfYt/Hx8QWciBpEPQIHHD/i?=
 =?iso-8859-1?Q?2P9rlkl+QjamDLxgX9uINwvv0G+Sn+VrzRtIj0UrUsQAM/6hy5z6QnPkry?=
 =?iso-8859-1?Q?YWR4M3JYJ+hker4o3/Cr4x6g74+fAJoii58gKYCpsMweLfxa1SFIjNifqC?=
 =?iso-8859-1?Q?iQgvy5AgwnttO7RMBSCHc4Bi4t7u1VvPkviz0sM3C7Hlwaal60rN/+MDfL?=
 =?iso-8859-1?Q?hYMItBOL/Cy7XmRsVRFrSv9mp2Fd8ksiXe1cEb+A3mBdGBpw5zRquRDD/E?=
 =?iso-8859-1?Q?DA8ea2l4zg9w0OKwspMoVrjwzTKaTh0/mNmbl6MBsWGjbMh8PnkcAdVGzw?=
 =?iso-8859-1?Q?+02bumJYRLvXXiH2Do/trPzO/RrctToUgU6yYi1bdi77lIhuCj5j0wKDls?=
 =?iso-8859-1?Q?xqGQ0O5nr1snttwgAeQeEeG+9H0OManEWihQB3OZdBhGPCkxwuo6nYefzZ?=
 =?iso-8859-1?Q?gQgj7C6PLlByxpoACMmsfPryMyCzD/MFCeBlHGpwsjsUfFx/wWsH67lqC3?=
 =?iso-8859-1?Q?SCmJsidj4hPh2QPg3gNawyHnkrsKtPxIG8srTWSP3qi6e+akPgRquC8tPT?=
 =?iso-8859-1?Q?NLKs1ut3IqHzUWJtR2PKVn4RPi1iNNYpV2dY9i2Y0tscQ6dSciXnqrASHK?=
 =?iso-8859-1?Q?WFlS3XXiOIOiLA/4QcJ3GTCSoDJPknRruxQy5ZF12sqTHR6jsflin0vlYJ?=
 =?iso-8859-1?Q?oEQiHTes4EEqVuKY654KxXpH5zv1MCgqHKRKIrlXRqDu+vLjtOYQLBgvO2?=
 =?iso-8859-1?Q?huisdGGMHgR3u+qVXwqEToP8VeIDJQl8lY5F0derwxvt3w0XXZuuojJmsq?=
 =?iso-8859-1?Q?AEHYFyTgmhJvBBKiwhKjtsJJD+uvz5LyDuts6L9/23E886zR2vsMhOUPPs?=
 =?iso-8859-1?Q?gvL4E6V6JQ/CmzYulLKV/VwFXkvF7nywUScXA5id6Sl7nUoWgZe8dwbzFn?=
 =?iso-8859-1?Q?JTTZu+BSEK2+j4d9o1QPSqHmGdBsrDUmmuj8kOUheRs6zoAb6NI2CG2IfR?=
 =?iso-8859-1?Q?6ZdJP1neO0I9/NE7HDsJvXidkL22aeBRpQLAs5mvKXsDoKxs0zAOJZaTNg?=
 =?iso-8859-1?Q?NK+jcMclqPVFq7xgnWS0Y8KhZLjOn6b8Yc64iwve0lkbDKxo46OD9ARA6O?=
 =?iso-8859-1?Q?+nNH3D75DWn24ylJHBl4mePPeSl4lBcNRuCGupwhHvRoxjA7X8fph7Tssc?=
 =?iso-8859-1?Q?J0D1Tad5kkaA6+/AUAngDcfz3Fmz7LiBPzZQHxrGvH3eJgmVXi/Hy3fgpQ?=
 =?iso-8859-1?Q?wEEAsYnOmYHDQ+EZeJzmxNGRqjzOQKYNX9hHpf6g0slUizVl+pWRaWJTss?=
 =?iso-8859-1?Q?CX2KKCA/fOiDKghlELyggYZ2agE0Rk4rXPvoKMrPzYwcCQ7Py9s0TMD5ks?=
 =?iso-8859-1?Q?5wH+xPS1svN7RQhddGhhSaAptzocjK5HGCXX6lTjPvklXakSfQqgTuQAcP?=
 =?iso-8859-1?Q?anU5a1gbv7IhyVaovlFowayVSQuMwYYk6W1EVXRGzgAGNME7PNRjxx3qhx?=
 =?iso-8859-1?Q?hG5WyzCxJLEcc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95456a75-1a4e-4a09-5a40-08dd622cc724
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 12:44:21.5253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Qbg+4xmZLff4bs16GgJ7LNvpq1RVRZ5gb2G6Lux2+n30Uc2vcQi+u1xxbFui8PVJaOdG1A/WWrRdjjqI1Teeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks this was pushed out to main just now.

Cheers,
Tom

________________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, March 12, 2025 21:40
To: amd-gfx@lists.freedesktop.org
Cc: StDenis, Tom; Zhang, Yifan
Subject: [PATCH] add mes type in mes ring dump.

According to MES API spec, type 0 means invald. Pass mes type in ring
dump function to avoid confusion like below:

[0x0@0x00000000 + 0x7200]       [        0x000400e1]    Opcode 0xe [MES_SCH=
_API_MISC] (64 words, type: 0, hdr: 0x400e1)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 src/lib/read_mes_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/read_mes_stream.c b/src/lib/read_mes_stream.c
index 6146fd3b..b92ad9fc 100644
--- a/src/lib/read_mes_stream.c
+++ b/src/lib/read_mes_stream.c
@@ -295,7 +295,7 @@ struct umr_mes_stream *umr_mes_decode_stream_opcodes(st=
ruct umr_asic *asic, stru
        ui->start_ib(ui, ib_addr, ib_vmid, 0, 0, 0, 0);
        while (stream && opcodes-- && stream->nwords) {
                opcode_name =3D STR_LOOKUP(mes_v10_opcodes, stream->opcode,=
 "MES_UNK");
-               ui->start_opcode(ui, ib_addr, ib_vmid, 0, stream->opcode, 0=
, stream->nwords, opcode_name, stream->header, stream->words);
+               ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream=
->opcode, 0, stream->nwords, opcode_name, stream->header, stream->words);

                i =3D 0;
                ib_addr +=3D 4; // skip over header
--
2.43.0

