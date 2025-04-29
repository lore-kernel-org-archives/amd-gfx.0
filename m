Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EFEC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 18:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B3810E461;
	Tue, 29 Apr 2025 18:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W1HJjl80";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA3D10E461
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 18:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5431oDf1pqmrPmamBwbgPkYU2vpk9PNPSO5v7Vs+a0Ym6v9G2YZZ/EYNJFCs606Rbm+9HgqfSG49RV/mXegcpV1DUzMjFgNvCaB6Wk2kvwHc0k3pWSh6vMa4PvOo0Zzugmdk/4hFPv8YBaHIRilqUKAeLH1Xnh5cMFZVY74IlPCl6B79iD3kQIzieTnhsLu2kM9uc4khhiDF2l0SIZj5LPqB09bxCzhvFrVRFn6w/m+PlQHXn0A5/VRLIdomwo3sDN5z0hwofZF4HqzzoqyazhBODq1CvoEohupTJXDeITSIHrGFIU44IvIIV2avrlzNat1V3XQC3c5BCPAxU2CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuOtd6TwSa4lDyy1fJXW6lYuV8eiH6rQql/ztDqjIL0=;
 b=BjvU7jcJSxkK6Vkw2UD6udpMl0VEF9+kwMb52Yt9ZxK2ld8yhfn2WSbbjkedgcXEqUUscURAZ+zKecZisKIy1ZlRmqIlu5GC4BFbIsWVK5H7uKApCj4lsawY4tiLMYuOjJvr517BqrkHU+4gLuC8A5/HlosU9r7IEmvfflTpPrtp3DOl7ZWpbPz4UO6WpTfi/1yr8Kqqd4Mr4oDVH0NuOc0BV9C32hcROGjBKmV95sL7dYM5U9MheXViVIP/msKC3FwmyifDJG2ehCm4BXXzLC2Z7i+u29IWp1vLI56+84YIjZikTI4VWHM6nVuRuz1Q4Vh8yza1vZ5TOYnYQT6hog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuOtd6TwSa4lDyy1fJXW6lYuV8eiH6rQql/ztDqjIL0=;
 b=W1HJjl8069/mK66VJo3xW6+XdgGea/cC2pEEIKBl2GTWt36Ti7A8KYDXxlNmXRMlwCPLmn9HCLONQeChiCMN+Sq3hEpXnHXR/WgNq75nBDwUeYnZ9DmNbcViOtgQASqY1/uWdHLrbmgorpwRgj2Dr3QlK+Pl7WmuK0Rwk7JVjYE=
Received: from SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Tue, 29 Apr 2025 18:12:05 +0000
Received: from SJ1PR12MB6268.namprd12.prod.outlook.com
 ([fe80::305b:71d7:26f4:3d93]) by SJ1PR12MB6268.namprd12.prod.outlook.com
 ([fe80::305b:71d7:26f4:3d93%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 18:12:05 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>
Subject: Re: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Topic: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Index: AQHbuIN/DZp166ja5k6xMdj4GSSgALO68Tvb
Date: Tue, 29 Apr 2025 18:12:05 +0000
Message-ID: <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
 <20250428212050.1098434-5-alexander.deucher@amd.com>
In-Reply-To: <20250428212050.1098434-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Enabled=True;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SetDate=2025-04-29T18:12:04.603Z;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Name=Published AMD
 Product; MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ContentBits=0;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6268:EE_|DS7PR12MB5936:EE_
x-ms-office365-filtering-correlation-id: a28cddf6-3e43-4b2f-1165-08dd87495901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Opdauog6+xwzZn9dKXmwCFEHzDHvcPC441FVnqNC9/WZMVHUNg8wp5KgdR?=
 =?iso-8859-1?Q?EawFXjCNViFjYvXOkYlDRm5W2o5UfPydHpmkHfoRNlbzSj0qouWwehpmPO?=
 =?iso-8859-1?Q?N4abeQ/p3t8jnTJGaetTm/Wm3ehqCd2F2xoqowtiNJ0sFMi6C6wVUN1vYa?=
 =?iso-8859-1?Q?CGZwuxeA80DnpkoX3bOzDLXiiPGEe0Spfa0nz47g3X+sinO79CgvWi7Xpt?=
 =?iso-8859-1?Q?SmkwvAWELIs8UgFO4xm1xXqzeCcKtrmcKN4Sys0FAGsvt3GyvKRE1IWW01?=
 =?iso-8859-1?Q?B7B9Ib1QKaiY0hgruDVwc9l49PLwkR1x08QIydPZjGuYNNh8ogQi2r+OtD?=
 =?iso-8859-1?Q?CQbnpe3Dqvfg47XPre7fa2AOpD3eN9kGJVBmgWtvrisq/fsPVFUbRebEhY?=
 =?iso-8859-1?Q?o0IUPda94NFkwCibJcw0NAZcU2CNaClSEe1yy+2ig8jnFXNNkbmZ/Rd64l?=
 =?iso-8859-1?Q?ICDPLoYHrwnpA6EVz5kpcXqjpZq/HUQr9G8vJWxkkeMq36ybzfHMxplOmz?=
 =?iso-8859-1?Q?i2AbWAZFikCM8iODFjr+qPvTZBQ3PauwCI1gRBDfc/8lfhDL14JECbk8eo?=
 =?iso-8859-1?Q?SO2YclkQaw6S+NYPkkwgY1D+T7CY4gxTJ55qNSAN7WFGzk6eNdm7WUhzBG?=
 =?iso-8859-1?Q?VNdfSyiifM4E1Vv1Z+cABYqsROdMlBx+A5sIlztfoaIIslgKKPcyH5n3GJ?=
 =?iso-8859-1?Q?/o8/b5VpeFmSUeOpoEIETvk/O62et7rvFdsgtQl71RSxx5jptSYh4NrfeQ?=
 =?iso-8859-1?Q?GMkEcTqiFABNt/fc7wcchMID/cqQ+yfglUkJ+ZyEaD3KYYkM/VYtY/5vkD?=
 =?iso-8859-1?Q?JNmAKZxYFkyxlE4Ynjcrfs0V/l360oylsHB4nnQ/XOf0YBUaiU1TwMcTF7?=
 =?iso-8859-1?Q?Yw5lRbkvSU7DrWYKXL9Mxl0kauBXkQQNjDGHB5etA0+gQWOl/RuOn3lmjX?=
 =?iso-8859-1?Q?iFI8v6r4lygM8Aci9+pDaMJytJMdoO/krLdJghObDajM6GBJbLvLb7pkV2?=
 =?iso-8859-1?Q?HfzsHmbwDMS9Q64gHrstv/oREc02DS0/nKSfFfDLkkq4FH1gv1YwHsebEM?=
 =?iso-8859-1?Q?uPTdSGRlTXmIg/rIwcuZTq/4kVDWHlaHkY4reyaWSEjrha4kOlkW6UqQ+T?=
 =?iso-8859-1?Q?TiGRUjYZ9UncVd+VqCLxhldSeW3NsJSTekzq6kmCo1kHmnmK8zgUCpsopi?=
 =?iso-8859-1?Q?EhKajl/gj2sot7G6M/3SBlJXCmS/pHLkOO+RyRFSX3L14gwG+tpiDTMNBZ?=
 =?iso-8859-1?Q?hIyWj/nuLgrBFkD+sVE6omDdAHECSQo9mHA6ygh81j5j4wmLO2EHIv3IFa?=
 =?iso-8859-1?Q?vOAT2P06sfVsYi8U8zhzS2Vv2XlALeXAUS9ejUNHqb3DuDvN2AuEYydciY?=
 =?iso-8859-1?Q?33mvFMdbv3ziYq105SgXy8ZOOEqWZ+8EZNb1cFkemk4Gn5b/fl1dxrlKqH?=
 =?iso-8859-1?Q?2Kfj5N4wewSM+l2MVSyqyoUYqOZRIYb6j/v78mNZow4HoK0bQgi1UJCbyq?=
 =?iso-8859-1?Q?zQxXZE9BkfPId4ofCPaYOzCmMXRWWMViN1i9f+POWAl9lEIM8TdTn3rUiQ?=
 =?iso-8859-1?Q?rqdGrC0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6268.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SqorMn5FRTqFbBo+gyM1xueUExPj7CIcIBlHE77B8pFwheTObe7zxBj3KH?=
 =?iso-8859-1?Q?98dA5F6aJuWqPvNdwsU67cJkvivHqvwHggPqHrV3pRlJWGtktZXcyCUad1?=
 =?iso-8859-1?Q?RZDwLVYfFBGf/2reD6H7T0GAHwNjpe9as0/WTgM4KX0apgllvFB5Vgp7B0?=
 =?iso-8859-1?Q?YVElZnNzmgdkK18aeAHtiWANdXTydtzpO7PZE8wL0haL+gSWAJJOR2zLhd?=
 =?iso-8859-1?Q?ob5YpW5Y3FOOixHY8Dcn7N3mDYMchLfYngk42IsOArph9A/nlp5DjMm6XA?=
 =?iso-8859-1?Q?Eqcy7d9JrWW5vnbp0qEixqRWDWXyfHUIPCeQgv+oZ9ez2LXjzRrP9RMWL0?=
 =?iso-8859-1?Q?hrX+kPmOFJDvyZ7Ve2zg6JZ+CRO6OGrlJKRBLfXrWKd4roI1r9TFiachAi?=
 =?iso-8859-1?Q?ykTdv+SZYB5+Hn28j7p2YUAJK0s3Fzk0RcNPDnDyW1ba08Mm4hFfzipxYA?=
 =?iso-8859-1?Q?nXrMx6UZZrRXoN0dB4QB+l8bL8xKGrTnk8SvQrITttQB3WCvytd8ovPDn3?=
 =?iso-8859-1?Q?NjirlxCiP+5E6kl5+jtIOTPvyoMEip6q6DRsMLpBkKbUrIUnyvSgqGMYwv?=
 =?iso-8859-1?Q?msevisulmnfdBA9SUzuF/64quEMpnyYSOxK6jcjvvrnIe5ax4nUkh5VUx0?=
 =?iso-8859-1?Q?VMuxouUVzHCCgg2zcLNAddHd0QlHzGpJG1qWCSie/4t9448ObMpNSu6kd/?=
 =?iso-8859-1?Q?BIfSVfXPadBFbsNPuU2sIYagJDKOLwrUDbI7SwS6lclb+pq5lNIBqOqlFn?=
 =?iso-8859-1?Q?SNV/18vIERvO2XjD24GLatmcbQDKtiw0BscnQWP73DWKMG7bMYcCussq/e?=
 =?iso-8859-1?Q?nt8fWBEhyyg7TQSZ+w1XP30hxZva3dM8KhWaXf13op7UK6GUEy7U2QnShP?=
 =?iso-8859-1?Q?KX3stzC6C8Xi73g94B5yHPFxP5AhQdL6ztniw8pxNGxe0HcuXL3CcoA0/y?=
 =?iso-8859-1?Q?gvU1pjRnRz5CMa3+sx63LPdN0MJZFVWKm7avrAS6C3fBL8OlhloNvNbjYd?=
 =?iso-8859-1?Q?uw93ZN99nCaVsbbZclltWyIPS0Ztw9vmIsAZAKveW3F2/K2iVAOM72eruz?=
 =?iso-8859-1?Q?OZOH2Rl7PPkRiKdkPMbD1KrQLe/qC7arG6nPbEIIBcGHVNUlZXPqMC1h0W?=
 =?iso-8859-1?Q?FonBhAzirRyPCc3XsBzBzCLv7P38XmLVxoC8JCInayCLyTJJXjQHCjZWkS?=
 =?iso-8859-1?Q?yLgxjbq00JR16d7z9A4Ca+0zv0FefIges1+6B4Si62Yuo4cHpoQb75y1OC?=
 =?iso-8859-1?Q?9aY7XWCsJCNEgjY8iPKMFHixpYAqMcyn+Hr/UsjrJPON8jS6tpNZV2s244?=
 =?iso-8859-1?Q?NU6084VG0lyKyLNs2V76e/Wn3Nd4k41dg9egX5GUawkzV7+QNqakPbHyrU?=
 =?iso-8859-1?Q?kmXswEpYtNiZn7pjxjDhbLtyEKcyiWjy46NgzosaZK5mWrP4kfiIvBAo78?=
 =?iso-8859-1?Q?s7JhcOwgcIXyCBGMDj+bT67yH7qvfr7xW9YSxAYE5RyTu+o//tU4wXmQOu?=
 =?iso-8859-1?Q?sNOXJl8+JACamtiaNKxu1etFVNPdkqs5gLyqgXHw/0MUoC9U6EKj8ipYZo?=
 =?iso-8859-1?Q?AxpF4YP8nlVRGQpVKznxFADaKJgSjNP3yERZuH6t1iV2wOeFK7LdmwclHu?=
 =?iso-8859-1?Q?6IF8AM0vvdWKs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB626846D071EF8DD342E4900294802SJ1PR12MB6268namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28cddf6-3e43-4b2f-1165-08dd87495901
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 18:12:05.1534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hz71ttWVdtdcMG374AjPrAc+LHpSF8sztNGWMNX2Zz1CZn3wZEvlklWwqB+78Mh6IVN6FWbqUM+F43zKUKndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

--_000_SJ1PR12MB626846D071EF8DD342E4900294802SJ1PR12MB6268namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Monday, April 28, 2025 5:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Kh=
atri@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index f9f2fbc0a7166..57d8b78210f9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes =
*mes,
                         offsetof(union MESAPI__RESET, api_status));
 }

+static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
+                                    struct mes_set_gang_submit_input *inpu=
t)
+{
+       union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+       int pipe;
+
+       memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+       mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
+       mes_gang_submit_pkt.header.opcode =3D MES_SCH_API_SET_GANG_SUBMIT;
+       mes_gang_submit_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
+
+       mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
+               input->primary_gang_context_addr;
+       mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =3D
+               input->secondary_gang_context_addr;
+
+       if (mes->adev->enable_uni_mes)
+               pipe =3D AMDGPU_MES_KIQ_PIPE;
+       else
+               pipe =3D AMDGPU_MES_SCHED_PIPE;

I think this packet should be always submitted to AMDGPU_MES_SCHED_PIPE, sa=
me pipe
as in mes_v12_0_add_hw_queue where the queue is created.
This is because HWS on AMDGPU_MES_KIQ_PIPE does not have the queue informat=
ion.

+
+       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+                       &mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+                       offsetof(union MESAPI__SET_GANG_SUBMIT, api_status)=
);
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
         .add_hw_queue =3D mes_v12_0_add_hw_queue,
         .remove_hw_queue =3D mes_v12_0_remove_hw_queue,
@@ -888,6 +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {
         .resume_gang =3D mes_v12_0_resume_gang,
         .misc_op =3D mes_v12_0_misc_op,
         .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
+       .set_gang_submit =3D mes_v12_0_set_gang_submit,
 };

 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
--
2.49.0


--_000_SJ1PR12MB626846D071EF8DD342E4900294802SJ1PR12MB6268namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;amd-gf=
x &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &=
lt;alexander.deucher@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, April 28, 2025 5:20 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Khatr=
i, Sunil &lt;Sunil.Khatri@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com=
&gt;<br>
<b>Subject:</b>&nbsp;[PATCH 5/8] drm/amdgpu/mes12: add support for setting =
gang submit</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Enable a primary a=
nd secondary queue that schedule together.<br>
<br>
v2: fix offset of api_status (Prike)<br>
<br>
Acked-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
Reviewed-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 28 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index f9f2fbc0a7166..57d8b78210f9f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes =
*mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offse=
tof(union MESAPI__RESET, api_status));<br>
&nbsp;}<br>
&nbsp;<br>
+static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mes_se=
t_gang_submit_input *input)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union MESAPI__SET_GANG_SUBMIT mes_gan=
g_submit_pkt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;mes_gang_submit_pkt, 0, s=
izeof(mes_gang_submit_pkt));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_gang_submit_pkt.header.type =3D M=
ES_API_TYPE_SCHEDULER;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_gang_submit_pkt.header.opcode =3D=
 MES_SCH_API_SET_GANG_SUBMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_gang_submit_pkt.header.dwsize =3D=
 API_FRAME_SIZE_IN_DWORDS;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_gang_submit_pkt.set_gang_submit.g=
ang_context_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; input-&gt;primary_gang_context_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_gang_submit_pkt.set_gang_submit.s=
lave_gang_context_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; input-&gt;secondary_gang_context_addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I think this packet should be always submitted to AMDGPU_MES_SCHED_PIPE, sa=
me pipe&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
as in mes_v12_0_add_hw_queue&nbsp;where the queue is created.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
This is because HWS on AMDGPU_MES_KIQ_PIPE does not have the queue informat=
ion.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mes_v12_0_submit_pkt_and_poll_=
completion(mes, pipe,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes_gang_su=
bmit_pkt, sizeof(mes_gang_submit_pkt),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(union M=
ESAPI__SET_GANG_SUBMIT, api_status));<br>
+}<br>
+<br>
&nbsp;static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .add_hw_queue =3D mes_v12_=
0_add_hw_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove_hw_queue =3D mes_v=
12_0_remove_hw_queue,<br>
@@ -888,6 +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume_gang =3D mes_v12_0=
_resume_gang,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .misc_op =3D mes_v12_0_mis=
c_op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_hw_queue =3D mes_v1=
2_0_reset_hw_queue,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_gang_submit =3D mes_v12_0_set_ga=
ng_submit,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev=
,<br>
--<br>
2.49.0<br>
<br>
</div>
</div>
</body>
</html>

--_000_SJ1PR12MB626846D071EF8DD342E4900294802SJ1PR12MB6268namp_--
