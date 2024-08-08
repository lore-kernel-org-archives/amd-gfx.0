Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249B0C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 17:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C868710E79D;
	Thu,  8 Aug 2024 17:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tsjiHeNL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE9910E7A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 17:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3uH8OQRA81cRHgn6lrJjd4vR3VMRreUpwFU3XklF+7SPuzLo7J0vznVPnEBrg/0xxB09Po8PgUQNbSjNKjtPv1JVHX48QFL7wLOYR17mrsXo/dvLWIqY2eSHUrFRoXq4KoF+Rzy05gShvVge+ba7aCjz35fYQXxVaXMEm8UFCnxZpgfljQLEOcH153pSltNP15CSP6Da49rq5cdusjmIk2kGvwhXdseDnLT/yxCDWCtxRworC/WS4mQ+sVVAibNhOQPy0yUsdBE03lnIsQXeHxLNGzIniZ5605BPn21vWytbexY/iOVdee96BYxxhb+s1E7Bj5pb2eIOByq5JIkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LUfVKT6L7fpKdnAyrl+8L38tN3Lkzuag8NYLX93o0Y=;
 b=vP0ALABfZUlv1sdkS3+quH+zS0UJ97nvVcnUvxnfslcIWa+TZxSVrsoCtV1scKSrZka4YGuo0/SmkDJ4TKtVY1m+MtGKXYeGVnRaQfSdT+GbCDzOT4pWogQL5x7EUekeGngYoNXMCpinRbNqiooCN6kFX0EW8GGDF84HIiA2qkMOQv0Aq+L1WDY91tO2Lft+bdHVVnLSu3aL9V/FwjGpzA+UcNYSpjQWniPujXcoKpFCOcQmplmR9QJbfiZG6IBo2qh5lcQseLIS5vwkVCBYAygceVPw8cdzimEgKFN+86pG450/O6ZUR/A84kafJroS5EpvHWI8GxK8utt5sGTF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LUfVKT6L7fpKdnAyrl+8L38tN3Lkzuag8NYLX93o0Y=;
 b=tsjiHeNLdpUedy7x6VzMtFV+vLFxUmItE7Gsrb2oYtGM+gc1sZ6DO+NZFv/LmcVVxxOJzn5FxOXkblK+s1UQXxw4bWvTH4yxcgQnAwqw3muhKBR7BBR/IyufNo5jMQzNiu5FKl2gznKbbW3m5vIrO1aUVztX8SxaM/Vq3mtxpc4=
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 17:03:08 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 17:03:08 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Prosyak, 
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: Re: amd-gfx Digest, Vol 98, Issue 218
Thread-Topic: amd-gfx Digest, Vol 98, Issue 218
Thread-Index: AQHa2Imh82UyfV5uq0CKgk8eiJ/9H7IduASggAAAdJc=
Date: Thu, 8 Aug 2024 17:03:08 +0000
Message-ID: <PH7PR12MB6420E736AECEEADA909D7C0D81B92@PH7PR12MB6420.namprd12.prod.outlook.com>
References: <mailman.774.1721248846.1131.amd-gfx@lists.freedesktop.org>
 <PH7PR12MB64204EF2BADBFA47DFE6135D81B92@PH7PR12MB6420.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB64204EF2BADBFA47DFE6135D81B92@PH7PR12MB6420.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T17:03:07.739Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6420:EE_|SA1PR12MB6749:EE_
x-ms-office365-filtering-correlation-id: 0d59a2d3-e49a-4eed-24dd-08dcb7cbfa23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|4022899009|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BdryblBkDMiNGslJ/QnHehE8Uw5kfKXau9p6bGAjnJtH6GVY2v/KFDGQBoYs?=
 =?us-ascii?Q?nsVuWwXpde6qTkWGv4aiDGme/xkHLbi5k10y5arKTD1DCOj6gIpV5SK38Qq3?=
 =?us-ascii?Q?hp7fejig0+H4tqs/736E/Ad7fctrbUqmZIOmOafYjhCyDMpQm1MdJf7Pk9xJ?=
 =?us-ascii?Q?XkPLdz5inTOicOg5yUw+CZwgDiFr5EXYxO/4P06znj8WZ2LSQZhQx4TxNIMN?=
 =?us-ascii?Q?MyDMogCocl/5zoLldn5IyegKypWT6XtzI4MY0t39mo/5woRNZx+FQWQq0+fM?=
 =?us-ascii?Q?f/QBfDhaJ1hBSdXDeP2KxLNejx0FlYZLyRXxqoUKid+X06VnZt8vR261M68k?=
 =?us-ascii?Q?j7eDygQtMdQUay4Jpb5KjuasFWXkGTR/WSt1RYJ+nbv3jtI6aWbbB4lwXLib?=
 =?us-ascii?Q?LooX/hPppuER2Kz8nqftF6ki2DHk2cU2aRFpwYv2m268XJUxzuRlZgf/3dKi?=
 =?us-ascii?Q?od1qE2XMCfiUwxY0Xuvw3O/LgdxylIBk9BtM+LiakVXfdIEI6isxgH0YxAAm?=
 =?us-ascii?Q?wEKOissH0RfGmGOK+a7eyXV8nyQ9rDFfj+Q8H+f55oCqLM90139HjPpimrk4?=
 =?us-ascii?Q?a+D7/efYXmA7eTYU27eiexbuZ0XkpPGUpzZ0CvnS7OgEHVhEEKqzMHSSZDxv?=
 =?us-ascii?Q?d5AhddntVrKCjdr4ZVHqMyMxdZnez8JHUzrFmOJJ9elzmCzErfQ4ZIBK/TcD?=
 =?us-ascii?Q?hqWTIjIyvlRbrDks5Sm70pBvWrN08c7gD3ydBUEP76Zr8nrgD3dFdV6IudG3?=
 =?us-ascii?Q?ZlncbmBWz+A4GOjm8LXeV0eOEWPUBr1ZYi//7F02TzkUOCcq6TTSA8zFudfV?=
 =?us-ascii?Q?5GgEUb2IXofZ7T07HXaALX/VKv4fqKbueGR/M2OojO6DsiecS+m7q5BbMQ7c?=
 =?us-ascii?Q?yK66sPIAOJS7SBe8/PypzRbkqQY8MVw4AYDlfD1GT/nS4ekaxVjW/j6oR93o?=
 =?us-ascii?Q?9NRDEsvBERruTRb8rFiLfCxPTUDpmWGHWI+X201cyX7/6nIbDYzqLlrw8RPC?=
 =?us-ascii?Q?USCEn7bJGLaB++mWw8AEHGMNKp30QM7sbDh302diZSGob2NIcqob2W0D+qlp?=
 =?us-ascii?Q?On0XZdTuXr4p4XULcpu9ll6w2USEDc2xoGzZxfNTTOS4aXDPHKH8U02yfcXN?=
 =?us-ascii?Q?IVLF6M5aMASyU8wzHlEpWFhB5teDvcVh2HycGhX/8y15zazqHdr4oW2QoxaD?=
 =?us-ascii?Q?gSlAUA5YHdk57YyMX5dtRdn8+jbFycw22GeK9ACsIvRHzanO2FU9TEHJMUvI?=
 =?us-ascii?Q?sPUhlih2jhygvQZAhieydWdrohGVnpJ1AR4p/OlGk9veB8NlAeAlIEf6+D6d?=
 =?us-ascii?Q?bUOLYErA+jK3iVfgi+wuBZaeBVKQkunXSH+WXKzrcYhVc/ji9JqutEro367A?=
 =?us-ascii?Q?xQdyL/Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(4022899009)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MA3/roNjZ2upeX3ok0IfipTfPodTLuKoK3bY2/gncTzDNCZif8s9D1AFtXHM?=
 =?us-ascii?Q?F3i2NXipaV9YeAXBBHnWaSKno+Wqu0wHhkaFq9FY4/FLasjclrN7NzIA9wct?=
 =?us-ascii?Q?GvAMZYrWPpukYg5aImDajpcCnEK4J+Zo2FsoG8U3WP1cAqYaM+DAHG0kMqjo?=
 =?us-ascii?Q?ZlBcW80MjDVC2VeGzkQcbVC18qf7ktTmVAHFeEpLxXLEIWbEJsDoUN+60uBd?=
 =?us-ascii?Q?EVxDUvdCT9ERPd3QIgza34+TxDmbUHlSJi7k98NMDtotgouHlbEjZhRIo/jN?=
 =?us-ascii?Q?qR8J0uU3qL5ksZrDx0ddtNYD2l0wPpIu+dzWXrVrnpr+SGCO8B7pjlHG0HnZ?=
 =?us-ascii?Q?hxSAuX7IjFLQr1vG8J1m+eC/yhQzVuZ2SRLRigQHVuYUg3wlN0247PawLsaK?=
 =?us-ascii?Q?btLs2wEMo/38OUdpit1qqn0sQ3rvmqKsEX81/bWz9sB+m6ecY7Sa6fnfRX1D?=
 =?us-ascii?Q?cguiDC2S1URou+76jPaqpp6RcvtccVzrWa0HyEQ8woda3R7MKmptdqbnyKZ6?=
 =?us-ascii?Q?GpHZ6cwpGfdKRQwxyY7NIFMqmpONsIGL8bi6ItQzmq1uvG8qdwHUoMoqHr2h?=
 =?us-ascii?Q?hSN/HMVmOyCLZ+o/VIQy6BnS4AXunLR/CYTAEZZLrjcCxUdA5MrWp+xSTVdc?=
 =?us-ascii?Q?PI1GnDcKfkU7SKrD3WYNT1pkToMsx1qeLGpt5kPMI9Br8Qk+tRX9p8lMwNzY?=
 =?us-ascii?Q?ESHZ5B79qYaYB6x82EsCzwiMEivTY7fh+mw71G+wFXQEP0PQfLZGgVGYwCj5?=
 =?us-ascii?Q?JJCLfwTgMmlsDmm/hD+usesE+N/7YWRGA02+ssKcm1+HhpGMni0G25MPdND7?=
 =?us-ascii?Q?20RTl/ZF8sqBaYfytwXu3yxJcA9241B9ZI+gALeDrS9i30sjOXgP9D1EXS6P?=
 =?us-ascii?Q?IcJhqk5V62wKrMBR2EPUnJX0/fPMZ9CK39U0HYht547VEmpntO+lzmjQLtXd?=
 =?us-ascii?Q?jnxpH3c9vnzz0EkdZHtPIVxIlV2q131OIb2It43m2ww79BPAtxUIHe6SIvOu?=
 =?us-ascii?Q?gcaf2t4+hWAb55DHQeAcrxq6OqI/rY/VJ2pTzLVIQkeU0niyatsWTozv6Jaf?=
 =?us-ascii?Q?F8E6Ks2gvkXvSEcwnux36dJFnZUX280lcXQWSFGj8fJiC+3RlrbyOua1BWHT?=
 =?us-ascii?Q?ZSWDHnDjZmFTxfRxiYL0hdClTeLd/UakGhNtGXwGw4bKqgWm6CJnsHeKSebU?=
 =?us-ascii?Q?EnUkHj1nfW/JNfCSlAFjqkagn7CXfnom+pIfWUQE8jlB21qWuQp1cduj3z22?=
 =?us-ascii?Q?E3tVoP4WbOJOxLigc4yRbpTSNV/F/LLnxjaR0aM1PHdoKsGXBtFuFWbgw2Xa?=
 =?us-ascii?Q?9oEsGJzE/dGOt/rAkRrFA4p2fc5Bj/xbFbhNf3Bj82qPyy94jCEP8HvmbQjP?=
 =?us-ascii?Q?C8OMMwrzdX0ypsKOPDZi8DkH+ydCbOZTUjvZVpaMse4iK320V+IpdhKp1olb?=
 =?us-ascii?Q?YIIeV4VyNMjpYGiyRbsGRzAkx6O9iRTebNriYnmBWCTRVq+RM74MBkkQRBlE?=
 =?us-ascii?Q?T84bWaajVH1MbQCiAVQc49f71ysSHxZZfhsxt2TBI+Q00gKzS2D4lDy4t/p3?=
 =?us-ascii?Q?Hy0zDjsp4D00ZQllxDg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB6420E736AECEEADA909D7C0D81B92PH7PR12MB6420namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d59a2d3-e49a-4eed-24dd-08dcb7cbfa23
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 17:03:08.2060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcH8q3UNOxJ2f7o6zgd4AWT+C0lSScPPQoGz+tly4RzDWiNyX4gZIzIqUKGGYAavv1VFTA0htP8V9vl1BTgO3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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

--_000_PH7PR12MB6420E736AECEEADA909D7C0D81B92PH7PR12MB6420namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
The entire series of patches for gfx 7, 8, 9, 11 and compute gfx 10, 12
 for queue_reset was tested using the new IGT test, amd_queue_reset, which =
has been merged upstream.
________________________________
From: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
Sent: Thursday, August 8, 2024 1:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 98, Issue 218

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
The entire series of patches for gfx 7, 8, 9, 11 and compute gfx 10, 12
 for queue_reset was tested using the new IGT test, amd_queue_reset, which =
has been merged upstream.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Wednesday, July 17, 2024 4:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 98, Issue 218

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt
      (Alex Deucher)
   2. [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
      (Alex Deucher)
   3. [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt
      (Alex Deucher)


----------------------------------------------------------------------

Message: 1
Date: Wed, 17 Jul 2024 16:40:11 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-6-alexander.deucher@amd.com>
Content-Type: text/plain

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 43a3ef276b5f..98fe6c40da64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -901,6 +901,13 @@ static int gfx_v9_4_3_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+                             GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__=
SRCID__CP_PRIV_REG_FAULT,
                               &adev->gfx.priv_reg_irq);
@@ -2162,6 +2169,7 @@ static int gfx_v9_4_3_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
         for (i =3D 0; i < num_xcc; i++) {
@@ -2327,6 +2335,10 @@ static int gfx_v9_4_3_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
+
         if (adev->gfx.ras &&
             adev->gfx.ras->enable_watchdog_timer)
                 adev->gfx.ras->enable_watchdog_timer(adev);
@@ -2964,6 +2976,46 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struc=
t amdgpu_device *adev,
         return 0;
 }

+static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *source,
+                                            unsigned type,
+                                            enum amdgpu_interrupt_state st=
ate)
+{
+       u32 mec_int_cntl_reg, mec_int_cntl;
+       int i, j, k, num_xcc;
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < num_xcc; i++) {
+                       WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_C=
NTL_RING0,
+                                             OPCODE_ERROR_INT_ENABLE,
+                                             state =3D=3D AMDGPU_IRQ_STATE=
_ENABLE ? 1 : 0);
+                       for (j =3D 0; j < adev->gfx.mec.num_mec; j++) {
+                               for (k =3D 0; k < adev->gfx.mec.num_pipe_pe=
r_mec; k++) {
+                                       /* MECs start at 1 */
+                                       mec_int_cntl_reg =3D gfx_v9_4_3_get=
_cpc_int_cntl(adev, i, j + 1, k);
+
+                                       if (mec_int_cntl_reg) {
+                                               mec_int_cntl =3D RREG32_XCC=
(mec_int_cntl_reg, i);
+                                               mec_int_cntl =3D REG_SET_FI=
ELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                          =
  OPCODE_ERROR_INT_ENABLE,
+                                                                          =
  state =3D=3D AMDGPU_IRQ_STATE_ENABLE ?
+                                                                          =
  1 : 0);
+                                               WREG32_XCC(mec_int_cntl_reg=
, mec_int_cntl, i);
+                                       }
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
 static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *adev=
,
                                               struct amdgpu_irq_src *sourc=
e,
                                               unsigned type,
@@ -3116,6 +3168,15 @@ static int gfx_v9_4_3_priv_reg_irq(struct amdgpu_dev=
ice *adev,
         return 0;
 }

+static int gfx_v9_4_3_bad_op_irq(struct amdgpu_device *adev,
+                                struct amdgpu_irq_src *source,
+                                struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream\n");
+       gfx_v9_4_3_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v9_4_3_priv_inst_irq(struct amdgpu_device *adev,
                                   struct amdgpu_irq_src *source,
                                   struct amdgpu_iv_entry *entry)
@@ -4228,6 +4289,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_=
priv_reg_irq_funcs =3D {
         .process =3D gfx_v9_4_3_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_bad_op_irq_funcs =3D {
+       .set =3D gfx_v9_4_3_set_bad_op_fault_state,
+       .process =3D gfx_v9_4_3_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs =
=3D {
         .set =3D gfx_v9_4_3_set_priv_inst_fault_state,
         .process =3D gfx_v9_4_3_priv_inst_irq,
@@ -4241,6 +4307,9 @@ static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_de=
vice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_4_3_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v9_4_3_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v9_4_3_priv_inst_irq_funcs;
 }
--
2.45.2



------------------------------

Message: 2
Date: Wed, 17 Jul 2024 16:40:07 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
        <Jesse.Zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>, Alex Deuc=
her
        <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-2-alexander.deucher@amd.com>
Content-Type: text/plain

From: Jesse Zhang <jesse.zhang@amd.com>

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

v2: update irq naming (drop priv) (Alex)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 02efa475eb7e..ce5cb60b8628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+                             GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
                               GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
@@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         if (!adev->no_hw_access) {
                 if (amdgpu_async_gfx_ring) {
@@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
         return 0;
 }

@@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,
         return 0;
 }

+static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                           struct amdgpu_irq_src *source,
+                                           unsigned type,
+                                           enum amdgpu_interrupt_state sta=
te)
+{
+       u32 cp_int_cntl_reg, cp_int_cntl;
+       int i , j;
+
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < adev->gfx.me.num_me; i++) {
+                       for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++=
) {
+                               cp_int_cntl_reg =3D gfx_v11_0_get_cpg_int_c=
ntl(adev, i, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_INT_CNTL_RING0,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
+                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j=
++) {
+                               /* MECs start at 1 */
+                               cp_int_cntl_reg =3D gfx_v11_0_get_cpc_int_c=
ntl(adev, i + 1, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
 static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
                                                struct amdgpu_irq_src *sour=
ce,
                                                unsigned int type,
@@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,
         return 0;
 }

+static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
+                               struct amdgpu_irq_src *source,
+                               struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream \n");
+       gfx_v11_0_handle_priv_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
                                    struct amdgpu_irq_src *source,
                                    struct amdgpu_iv_entry *entry)
@@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_p=
riv_reg_irq_funcs =3D {
         .process =3D gfx_v11_0_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs =3D {
+       .set =3D gfx_v11_0_set_bad_op_fault_state,
+       .process =3D gfx_v11_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs =3D=
 {
         .set =3D gfx_v11_0_set_priv_inst_fault_state,
         .process =3D gfx_v11_0_priv_inst_irq,
@@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v11_0_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v11_0_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v11_0_priv_inst_irq_funcs;

--
2.45.2



------------------------------

Message: 3
Date: Wed, 17 Jul 2024 16:40:09 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
        <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt
Message-ID: <20240717204011.15342-4-alexander.deucher@amd.com>
Content-Type: text/plain

From: Jesse Zhang <jesse.zhang@amd.com>

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

v2: update irq naming (drop priv) (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index c74c8a60a23a..63b073fd4dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1349,6 +1349,13 @@ static int gfx_v12_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* Bad opcode Event */
+       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
+                             GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
+                             &adev->gfx.bad_op_irq);
+       if (r)
+               return r;
+
         /* Privileged reg */
         r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
                               GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
@@ -3592,6 +3599,7 @@ static int gfx_v12_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

         if (!adev->no_hw_access) {
                 if (amdgpu_async_gfx_ring) {
@@ -3712,6 +3720,10 @@ static int gfx_v12_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+       if (r)
+               return r;
+
         return 0;
 }

@@ -4831,6 +4843,51 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,
         return 0;
 }

+static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+                                           struct amdgpu_irq_src *source,
+                                           unsigned type,
+                                           enum amdgpu_interrupt_state sta=
te)
+{
+       u32 cp_int_cntl_reg, cp_int_cntl;
+       int i , j;
+
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+       case AMDGPU_IRQ_STATE_ENABLE:
+               for (i =3D 0; i < adev->gfx.me.num_me; i++) {
+                       for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++=
) {
+                               cp_int_cntl_reg =3D gfx_v12_0_get_cpg_int_c=
ntl(adev, i, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_INT_CNTL_RING0,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
+                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j=
++) {
+                               /* MECs start at 1 */
+                               cp_int_cntl_reg =3D gfx_v12_0_get_cpc_int_c=
ntl(adev, i + 1, j);
+
+                               if (cp_int_cntl_reg) {
+                                       cp_int_cntl =3D RREG32_SOC15_IP(GC,=
 cp_int_cntl_reg);
+                                       cp_int_cntl =3D REG_SET_FIELD(cp_in=
t_cntl, CP_ME1_PIPE0_INT_CNTL,
+                                                                   OPCODE_=
ERROR_INT_ENABLE,
+                                                                   state =
=3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+                                       WREG32_SOC15_IP(GC, cp_int_cntl_reg=
, cp_int_cntl);
+                               }
+                       }
+               }
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
 static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
                                                struct amdgpu_irq_src *sour=
ce,
                                                unsigned int type,
@@ -4907,6 +4964,15 @@ static int gfx_v12_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,
         return 0;
 }

+static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
+                               struct amdgpu_irq_src *source,
+                               struct amdgpu_iv_entry *entry)
+{
+       DRM_ERROR("Illegal opcode in command stream \n");
+       gfx_v12_0_handle_priv_fault(adev, entry);
+       return 0;
+}
+
 static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
                                    struct amdgpu_irq_src *source,
                                    struct amdgpu_iv_entry *entry)
@@ -5219,6 +5285,11 @@ static const struct amdgpu_irq_src_funcs gfx_v12_0_p=
riv_reg_irq_funcs =3D {
         .process =3D gfx_v12_0_priv_reg_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v12_0_bad_op_irq_funcs =3D {
+       .set =3D gfx_v12_0_set_bad_op_fault_state,
+       .process =3D gfx_v12_0_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_inst_irq_funcs =3D=
 {
         .set =3D gfx_v12_0_set_priv_inst_fault_state,
         .process =3D gfx_v12_0_priv_inst_irq,
@@ -5232,6 +5303,9 @@ static void gfx_v12_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v12_0_priv_reg_irq_funcs;

+       adev->gfx.bad_op_irq.num_types =3D 1;
+       adev->gfx.bad_op_irq.funcs =3D &gfx_v12_0_bad_op_irq_funcs;
+
         adev->gfx.priv_inst_irq.num_types =3D 1;
         adev->gfx.priv_inst_irq.funcs =3D &gfx_v12_0_priv_inst_irq_funcs;
 }
--
2.45.2



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 98, Issue 218
****************************************

--_000_PH7PR12MB6420E736AECEEADA909D7C0D81B92PH7PR12MB6420namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The entire series of patches for gfx 7, 8, 9, 11 and compute gfx 10, 12</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;for queue_reset was tested using the new IGT test, amd_queue_reset, w=
hich has been merged upstream.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Prosyak, Vitaly &lt;V=
italy.Prosyak@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 8, 2024 1:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: amd-gfx Digest, Vol 98, Issue 218</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
The entire series of patches for gfx 7, 8, 9, 11 and compute gfx 10, 12</di=
v>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
&nbsp;for queue_reset was tested using the new IGT test, amd_queue_reset, w=
hich has been merged upstream.</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of amd-gfx-request@lists.freed=
esktop.org &lt;amd-gfx-request@lists.freedesktop.org&gt;<br>
<b>Sent:</b> Wednesday, July 17, 2024 4:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 98, Issue 218</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Send amd-gfx mailing list submissions to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrup=
t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
&nbsp;&nbsp; 2. [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
&nbsp;&nbsp; 3. [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Alex Deucher)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Wed, 17 Jul 2024 16:40:11 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-6-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 69 ++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 69 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index 43a3ef276b5f..98fe6c40da64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -901,6 +901,13 @@ static int gfx_v9_4_3_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC15_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_PRIV_REG_FAULT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.priv_reg_irq);<br>
@@ -2162,6 +2169,7 @@ static int gfx_v9_4_3_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&=
gt;gfx.xcc_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_x=
cc; i++) {<br>
@@ -2327,6 +2335,10 @@ static int gfx_v9_4_3_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.ras &amp;=
&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gfx.ras-&gt;enable_watchdog_timer)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras-&gt;enable_watchdog_timer(adev);<br>
@@ -2964,6 +2976,46 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struc=
t amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mec_int_cntl_reg, mec_int_cntl;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k, num_xcc;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&gt;gfx.xcc_=
mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_xcc; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15_P=
REREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENAB=
LE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (k =3D 0; k &lt; adev-&gt;gfx.mec.num_p=
ipe_per_mec; k++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mec_int_cntl_reg =3D gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);<b=
r>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (mec_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D RREG3=
2_XCC(mec_int_cntl_reg, i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_S=
ET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_XCC(mec_int_cnt=
l_reg, mec_int_cntl, i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *=
source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
@@ -3116,6 +3168,15 @@ static int gfx_v9_4_3_priv_reg_irq(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v9_4_3_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_fault(adev, entry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v9_4_3_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_sr=
c *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_ent=
ry *entry)<br>
@@ -4228,6 +4289,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_=
priv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_4_3_pr=
iv_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_bad_op_irq_funcs =3D {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_4_3_set_bad_op_fault_=
state,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_4_3_bad_op_irq,<b=
r>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_4_3_set_pr=
iv_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_4_3_pr=
iv_inst_irq,<br>
@@ -4241,6 +4307,9 @@ static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v9_4_3_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v9_4_3_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v9_4_3_priv_inst_irq_funcs;<br>
&nbsp;}<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 17 Jul 2024 16:40:07 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;, Jesse Zhang<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Jesse.Zhang@amd.com&gt;, Pri=
ke Liang &lt;Prike.Liang@amd.com&gt;, Alex Deucher<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;alexander.deucher@amd.com&gt=
;<br>
Subject: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-2-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
From: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
v2: update irq naming (drop priv) (Alex)<br>
<br>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
Reviewed-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 73 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 02efa475eb7e..ce5cb60b8628 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC21_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC21_IH_CLIENTID_GRBM_CP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,<br>
@@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;no_hw_access=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_async_gfx_ring) {<br>
@@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl_reg, cp_int_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i , j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.me.num_me; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.me.num_pipe_per_me; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v11_0_get_cpg_int_c=
ntl(adev, i, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v11_0_get_cpc_int_c=
ntl(adev, i + 1, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type=
,<br>
@@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream \n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v11_0_handle_priv_fault(adev, ent=
ry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
irq_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
iv_entry *entry)<br>
@@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_p=
riv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v11_0_pri=
v_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs =3D {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v11_0_set_bad_op_fault_s=
tate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v11_0_bad_op_irq,<br=
>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v11_0_set_pri=
v_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v11_0_pri=
v_inst_irq,<br>
@@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v11_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v11_0_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v11_0_priv_inst_irq_funcs;<br>
&nbsp;<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 17 Jul 2024 16:40:09 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;, Alex Deucher<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;alexander.deucher@amd.com&gt=
;<br>
Subject: [PATCH 4/6] drm/amdgpu/gfx12: Enable bad opcode interrupt<br>
Message-ID: &lt;20240717204011.15342-4-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
From: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
<br>
For the bad opcode case, it will cause CP/ME hang.<br>
The firmware will prevent the ME side from hanging by raising a bad opcode =
interrupt.<br>
And the driver needs to perform a vmid reset when receiving the interrupt.<=
br>
<br>
v2: update irq naming (drop priv) (Alex)<br>
<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 74 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 74 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index c74c8a60a23a..63b073fd4dc7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -1349,6 +1349,13 @@ static int gfx_v12_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bad opcode Event */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC21_I=
H_CLIENTID_GRBM_CP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.bad_op_irq);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Privileged reg */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC21_IH_CLIENTID_GRBM_CP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,<br>
@@ -3592,6 +3599,7 @@ static int gfx_v12_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gf=
x.bad_op_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;no_hw_access=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_async_gfx_ring) {<br>
@@ -3712,6 +3720,10 @@ static int gfx_v12_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;adev-=
&gt;gfx.bad_op_irq, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -4831,6 +4843,51 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v12_0_set_bad_op_fault_state(struct amdgpu_device *adev,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl_reg, cp_int_cntl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i , j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.me.num_me; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.me.num_pipe_per_me; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v12_0_get_cpg_int_c=
ntl(adev, i, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MECs start at 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_int_cntl_reg =3D gfx_v12_0_get_cpc_int_c=
ntl(adev, i + 1, j);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cp_int_cntl_reg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D RREG32_SOC15_IP(GC, cp_int_cntl_reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OPCODE_ERROR_INT_ENABLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type=
,<br>
@@ -4907,6 +4964,15 @@ static int gfx_v12_0_priv_reg_irq(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Illegal opcode in com=
mand stream \n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_0_handle_priv_fault(adev, ent=
ry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
irq_src *source,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
iv_entry *entry)<br>
@@ -5219,6 +5285,11 @@ static const struct amdgpu_irq_src_funcs gfx_v12_0_p=
riv_reg_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v12_0_pri=
v_reg_irq,<br>
&nbsp;};<br>
&nbsp;<br>
+static const struct amdgpu_irq_src_funcs gfx_v12_0_bad_op_irq_funcs =3D {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v12_0_set_bad_op_fault_s=
tate,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v12_0_bad_op_irq,<br=
>
+};<br>
+<br>
&nbsp;static const struct amdgpu_irq_src_funcs gfx_v12_0_priv_inst_irq_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v12_0_set_pri=
v_inst_fault_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v12_0_pri=
v_inst_irq,<br>
@@ -5232,6 +5303,9 @@ static void gfx_v12_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v12_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.num_types =3D=
 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.bad_op_irq.funcs =3D &am=
p;gfx_v12_0_bad_op_irq_funcs;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_inst_irq=
.funcs =3D &amp;gfx_v12_0_priv_inst_irq_funcs;<br>
&nbsp;}<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 98, Issue 218<br>
****************************************<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB6420E736AECEEADA909D7C0D81B92PH7PR12MB6420namp_--
