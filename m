Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C0FC3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 20:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EC210E134;
	Mon,  5 May 2025 20:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLWayCkd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB73F10E121
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 20:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0CkOggbI9VrVsFhgIvdy7EJc6YARVlI9Ml6iVorS6+IIMvOokzBkE41PaeHL84+bDVRyj3xcwhWhqjjyNJ490aL25P7JhagxIjARqDukLNIk6UWQrjRLMFg7O1efa35F04SVEM/LT4QYWJZq0YNnWKabQa/UNMfXndd/B1JcvxzXU2RTF3Zr3m0oUfgN6+W5QYrh87EL1xXBWkotSPlfPYARusk6tH8k/CTquxa+IES5Veeyt+YT1XM/HoKfYhx+vgllotjCVVyxeRlstLZCgA3DpXt0vGFOrdQHwgmNBRe6gFy+SQIi/kKPaUChuqu+OxSC70mO0ubJiQKmUeUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6QocmHhPB7uOrOaL0HIZGVAJm5I4ZHOaIwkdarmmI8=;
 b=ovVuKm+U1zXfz37pH4nnVAbpk8yPnDr2kvJvZC6xlPjYGzC1m5lXgTBqeAESh9KN2eOEdUs4wx5LngAsQYbdWRBlrIES4LpKlMfgLsb5i+emqvSNlMSJA1Q49XbFQMzXsU7LmHoClk8xNqG6tYqxQeWaKLOZIJQ6Vw0bLImvtE3c2wZvja5R85I/esnCF0i0yw+srHtqfhu3TdA7MVnB8lqcBELYRFzG6aFmF9ItxYTIaJd9hwqOR0B5PF+MIzoYiqpoQ/qEdAU1OZH9URfKWlC1PWCBwCp2zzPE++ad9+Y1Pk3iwBu9TCotiIG3Mv10I8zLSGHya+maW8c5IsaUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6QocmHhPB7uOrOaL0HIZGVAJm5I4ZHOaIwkdarmmI8=;
 b=kLWayCkdJxRogVnH3+XJ9S+1TEppHnUcJeNkubumtaG+zS70+BhrIshUj89mR7Q86pM6ZHqZxBSgxWiXo/RmrDMGilgjmSUX9aC0OU7mKm6lCvw5mvfs1q4/q/HjziVhiNQRSSlRGPI3415xDVxNMvjAGpxshSQrdXApYFDgUrk=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 20:16:02 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 20:16:02 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Rehman, Ahmad"
 <Ahmad.Rehman@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Add unrecoverable error message
 definitions for VFs
Thread-Topic: [PATCH 3/4] drm/amdgpu: Add unrecoverable error message
 definitions for VFs
Thread-Index: AQHbuU9jbIEnDjbfVEmfBho0I0yiY7PEgmWA
Date: Mon, 5 May 2025 20:16:02 +0000
Message-ID: <CY8PR12MB765715A04E58E8230140DF2C8B8E2@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250429214041.93096-1-yunru.pan@amd.com>
In-Reply-To: <20250429214041.93096-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c6e4267d-4659-4ce1-a800-c09c99577557;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-05T20:15:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|MN0PR12MB6295:EE_
x-ms-office365-filtering-correlation-id: 4c55a929-c813-42c0-a0b5-08dd8c11a888
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pfWItF8s20izhaBu+sTUyjvB25riHNcVnqfe0dKFomN5USpz7L2W2PjdIjnr?=
 =?us-ascii?Q?+P1beYUQz9gjgYycrB2WRQ8/Zj9XYzK1mkLCWckGwiIa2oUzvLfIJXBHOv6G?=
 =?us-ascii?Q?deli/eeVCExWFl8plCaSqFAdqPA1wHlu/C4MZlL0DK7LA2ttYQIoe7Y7QCv8?=
 =?us-ascii?Q?kIpuA4mb0NSCNCXit6DZr1HP+p4vgmzEgXvNI4cFE74BhXf08iuGplgdq8T1?=
 =?us-ascii?Q?DawunmAyPNLy/QTY2OEgjjyk8ZLBsCjMJKNrAAURohgmQyXUN3Leb9poX7Wh?=
 =?us-ascii?Q?nWVufBesw+f8MmMqbDEe5OLAtlLJhhFpRYFN2FjIxEsJubQAwZC2t10qu4v4?=
 =?us-ascii?Q?+N0pIt7YAHI3fJ4tfVSXZ59RewJFliiL0j9XFMhengdp4V65lstth2+ryCMo?=
 =?us-ascii?Q?O4miD2c5U7Sn8LI1RKh0T9PsMgLSRTAAgA8X6xo27jft/0TWM+BkK+SOXPzk?=
 =?us-ascii?Q?HlrHVKY4SAfp3awjcLlbqoPVe6NktsADANvIqTxiqFtCj9jy2UYXAhAAOYTn?=
 =?us-ascii?Q?wVog1TWRqDH9EevQqdLn4yoQikbF2sArPkcZnPojVSbTkSXrgdMqIEDma9ie?=
 =?us-ascii?Q?bhVGX3jvk6ay3LZNxFDKlyQMNzUG03egluXfOyNEGl4zL0jaPRaI/5PMtk71?=
 =?us-ascii?Q?//3plJJvxI7lgc5Ugmcd7ssXTyxujh9ZJenEsYXke/y3xlXRdcUqSlFQfLVy?=
 =?us-ascii?Q?Zj4suISb/TiRYrdLh1DG41HrB+j/PAFQSDa1ZJP4a6j2BP2UiFTOHAtrRpuj?=
 =?us-ascii?Q?53W3li8ZMPh3kysVPOts8XHnpsUZwySRZSmXn+Gsn7GZR9+sSzTEXuJNTOT6?=
 =?us-ascii?Q?7QFzcP5km29/2waTrvo9Pit+MB3CbZsz2iWBGoV8bviVzB+U3QYmhtQnYwbK?=
 =?us-ascii?Q?nCeus438vQCZRLqBUtJRBMTNJavY0RPJcckr+OQZ8D1MrP/BqOOeXGSuoa8g?=
 =?us-ascii?Q?Wf/kmR1T7UVs7FIZ4BB4vBcalB9MQaNfRr2UqEqqQwdgV96zwOxZ7kVKENK5?=
 =?us-ascii?Q?oqzExj2hy4B+lHlekZQEQuXMWZ64H9KvRJ1lZzyXqpcTzPMEHz/ym3k7lFer?=
 =?us-ascii?Q?IAj6oM6lKh8YiGUY6akZIZC5fnYZwfCFHJt2uo5DBJi3U/amhYOmLefRq0EH?=
 =?us-ascii?Q?Tjq7c6otJQi5zVs7/4aOt4qmGEIXyJ6OrNjGTDHwDRhoGGU5UyHX7fdXV5mt?=
 =?us-ascii?Q?+UUR8j7GYAkMWEz1MtF0p6snEGyKad3dKcHFDEqsvP2+r/TpT5d/+U8Iuwa1?=
 =?us-ascii?Q?U/JOIhMefK8RzzWR9JGQzkwYUqptz/ZKMnqKpz98bA4Dy4uqVaBGWz04Sfkw?=
 =?us-ascii?Q?Ldq/9HFoZACCTDY9Sd9qsACIMK+TJL6D3I5wLDMhY5gO7nHTcY8eQRLTZX+x?=
 =?us-ascii?Q?M5QkKFh2vCX1wEoWRpNAAJ1lglD8/sYWyynqzqNxBkqCIh8MfJhZejuqmW4x?=
 =?us-ascii?Q?NayaCC42udASHVPpWvF4+2A4cpVZyx7Mz0boYJ1UyxRocZaROj8hcENfyrLw?=
 =?us-ascii?Q?fI0VBAxnDkv8HOs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P5JOLhdAZ8U+7jYI2sVLyDV4PDRMP93ruTSknA3AVag9KFlGjBMH0VbfsKKy?=
 =?us-ascii?Q?HIAnXyPf6uL2X6n3oVvXlKZU4n50FO/h7EXPpmm5knMXbcuQ4gJCltDsaBz6?=
 =?us-ascii?Q?JXnWeSUTy86RBZ+WMb4QL2KXG3Eq/wu28SunLJAFflgsWrFYta0UDxTQECc0?=
 =?us-ascii?Q?yhrcDRm7wgCl2Bk5DxqOMPicrHkcA2sMeGJB1ps8R0K6IMR5KYVlqfTkkYix?=
 =?us-ascii?Q?n9kiISvayp64s5J9mccT+FERbP3dfoJ2YHh9jj0a2HHzc/+GyiSXjXtrRTRw?=
 =?us-ascii?Q?S1Y/uwDEEqnLKrTh2RyirHzWUP/U3a6Ihq06kft69hC+IIlTrWctoeVpFIDp?=
 =?us-ascii?Q?YKS/5vkC287t1LCVThcMUnxmP3ee05bpxgDgWWCDe06ynYo0e1MqwBMwQ/lO?=
 =?us-ascii?Q?Y/u8ikewcKk3ltxwZ1Qbs00+U/pqdreKAvuVAT09iRsyXsFkmp7fkfYe/09P?=
 =?us-ascii?Q?Y9ghd+bIH+a/veUGKtl1lr/89E5mHrvYVInZOGAdlQG6ZKOReRegdz2S1+yh?=
 =?us-ascii?Q?ecGvvLAPZJ5WA4jgpjZTxXP6AEFCv12zZb2R6PdCDU0npn16UVgObvHfqv8M?=
 =?us-ascii?Q?ufkvl7Rl2hcqgMejXTDqPry06zSXFi2VmfOJ9ZKA5E+hpnh7ZLMJn47BwXu6?=
 =?us-ascii?Q?AtD1N0Go1lRo/WufLZD5Dp+1PjMd6ItEOwXrEOYs0QivyRJ5ld4q8CHT+IYi?=
 =?us-ascii?Q?hrON4L5nn/pqCAzgaw3A5QdgDs0czv+r3roI4AOE1EBOva/BqnMLBQIZkdoC?=
 =?us-ascii?Q?fE6ZQYzpKpRl7r9ed/UqJ4HyIpulXxwQvUmp1swVUnf9p76uOFiXZOBCcXP1?=
 =?us-ascii?Q?moYzlkpFkNW/BjiJNIpSSu6y6Kk6afVV8MIXvCy0FkMVN3K3FVpPwzGR05W8?=
 =?us-ascii?Q?ZV7OZEbpDfO75kf9WotZwXThV2rKhZ6MlLBNR0iSdzjDLWK15opGx8jLkIg0?=
 =?us-ascii?Q?AKbx5lTdaEIV+yUNrVDdt+GQujDjfZpnT03YWx2Q3Y4j/X2jH+m4Dv2H5NWL?=
 =?us-ascii?Q?nBZW6zWTs3IPa9VK0DggPjjVUwKABwk3otDdUXVloXI3JeEKAcf7qc759soQ?=
 =?us-ascii?Q?poZrICJ0fBC5LPXv5ygOuRHrIYUPMQ/2l6pRNzZqaYe1IZqrCLXU7n2vhUmr?=
 =?us-ascii?Q?Nmmp3oYLtBOkEuViNM4ctlRLmJOaPjaFcK1ao+I5f86tXbe7AGtvg6bc6PVD?=
 =?us-ascii?Q?ZVaIAoaktDSW7/qUadjcwDaUAFFxel6gP4VzkboV8FUHb34fEfHapUO41W1o?=
 =?us-ascii?Q?By+c3q7d6W9UCA0o4hfNikhiVqHjWw5B48iVXEllH0/zN7R2fWJNEiZRLzlf?=
 =?us-ascii?Q?yf5IKn7/kSN6ucFsMM8IjpgZjquPKPAWkQiAHwUi5OysVTOR2QOhY7h3yTRm?=
 =?us-ascii?Q?scnc2AI59JFSnSn+GXd7bwiKLO42Rkmd7oxStuZi8HP5AUlkHA4m5n1SiK8N?=
 =?us-ascii?Q?hm8OFIpIbcqcxcKFv5H3EhNgELDrv/QqOwGx4kmvBlTzqKbACj3+0Ygz2t1j?=
 =?us-ascii?Q?AttuR1W1TuGvos6b8Sm23AfrXzrDJrFs/UY/WFh8a2zpIoBZlmqAJnAKCYU9?=
 =?us-ascii?Q?LOCv+R/1AOohsgHnSeQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c55a929-c813-42c0-a0b5-08dd8c11a888
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 20:16:02.5705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+hJVnCoQuEDsdhQEFKWePkIFsi3Jq4rztq8ibNImeBF+Qv6369d3v7NIFxE+Bzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
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

Looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Tuesday, April 29, 2025 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehm=
an@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Gande, Shravan kumar <=
Shravankumar.Gande@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Pan, Ellen=
 <Yunru.Pan@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add unrecoverable error message definition=
s for VFs

Host may stop runtime services after reaching a bad page threshold.

This notification will indicate to the VF that it no longer has access to t=
he GPU.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index 3b0c55f67fe4..92ca13097aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -351,6 +351,7 @@ enum amd_sriov_mailbox_response_message {
        MB_REQ_RAS_CPER_DUMP_READY              =3D 14,
        MB_RES_MSG_RAS_BAD_PAGES_READY          =3D 15,
        MB_RES_MSG_RAS_BAD_PAGES_NOTIFICATION   =3D 16,
+       MB_RES_MSG_UNRECOV_ERR_NOTIFICATION     =3D 17,
        MB_RES_MSG_TEXT_MESSAGE                 =3D 255
 };

--
2.34.1

