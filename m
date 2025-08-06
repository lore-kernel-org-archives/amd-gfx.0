Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D1FC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 13:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43FAD10E76C;
	Wed,  6 Aug 2025 13:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a8Uq/xA8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AF010E76C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 13:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNVv+u+7L7D07ChsQVbG1ItPQ9Cpo1BzXGhReNuoI3Cs64X74BfQM0QsolJgr8w9z66QfW2IpguaiCVA86vDvPJJbivZEhmjJFllIvbbkI1TbKHuUFJTZlIt2m9vt5pNE6DKvmwfCzuLKWYdqbog9+TXK+6XFPvLeiG30M8r0ViOSv5ST5o/Kg4sRfjHJq1Vh1ghJTErXZZ2Eg+9Zao6HSsSPditkhMed3pXZ6IGgNCELC5fsE0bRLwjodE24yoBCf+N4awVWcNr3SXAFQIVjpgd/oPBAdiR11FSzCSh11BRtWKMXqnCRsfQ+3tX6QGXgV1NFT5PRLN/trfzRwb6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls/1t4SDHNF6kP1B7NF8BcJ8zqQ2WLAfS8pzofHDNXI=;
 b=Wy8W39qxgYtTje+aPhW3xhgkIaVtLki7wYjK94UHU5BuUHVm0O3qOC/HvFvV0c0TTLUX0Ilnscmgry3G6z5ySuHd4ztqgES2dgzL0xACr/dfJl69Z24nkqLUIbmdeTxawsy0/TuRFm66uONT24FgFsmAG/orhlNS4mHwWqQflQe2UzRJrfrkite+lf6osIq843qo8pFlqruqJB019Oy11z6lWaOFa8COI9R4r+9SFxyBpY9mpS54WXIiS1cnVL/dw5dN1YhfqwoK/ZAPoFrJRA3D1OmnZGG3ErPSbDVBV7lBTD3J4tpH0E7YORCrjut3Cgmxc0NlSPS/EaTxdpAr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls/1t4SDHNF6kP1B7NF8BcJ8zqQ2WLAfS8pzofHDNXI=;
 b=a8Uq/xA8Hz0uJJS03ZtUVs9v0JRM+DmSdWuXpitAq0cSk3Vr4ePrqp3gjZijo5oPhcV5lAFtVcHewFr3qzJY6GGhIEJSMNihOGNSVlzU/7MuRmPkzalrsqUrtkr2gav8yY+GtoP2FobCotIu+HwX+/GzAmfL+/zUK6S9KsVImqo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 13:09:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 13:09:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX
 command
Thread-Topic: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX
 command
Thread-Index: AdwG0wC+py0ihZ1LSMOlNG6CWeWPuAAAFnCw
Date: Wed, 6 Aug 2025 13:09:54 +0000
Message-ID: <BN9PR12MB525795375DC3A7263AABF8C0FC2DA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <PH7PR12MB69348D15141806A2D30FE097E92DA@PH7PR12MB6934.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB69348D15141806A2D30FE097E92DA@PH7PR12MB6934.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T13:04:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9336:EE_
x-ms-office365-filtering-correlation-id: 3203e65c-14fb-4135-0fe6-08ddd4ea893b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0zb/fekn/ct+F5piTFLAw6t4bnFiPIqxT7IhR8Y8paRQzWFUhwJUbPVzFPUK?=
 =?us-ascii?Q?FgSYtaR2lUndnovBv2A0ubpcU5lcjAlC+ntHNvhCH08d+GA6nJ3gcsNsnimQ?=
 =?us-ascii?Q?XKsWB2Gj6nMuMTMTw10BKYKxgvdr8OfW7S6zoxut0Vhj/MMmlknHbfJsbnG7?=
 =?us-ascii?Q?y6qvjzI11sTUERg7fmXwLtrVHTHYQgbAo1MyUe3eVM3eENb/xVw7YI6nGCxZ?=
 =?us-ascii?Q?HXtigEjYLnYW6qT9zSpU6xj2UjOwEfGEm4JM16d+L2zoWwmtrygAyy+pGT1w?=
 =?us-ascii?Q?xOAA6P8tJOITeS6zW6RbiVA6a+Z8v9wi8kslRRNyjEbaQqKrTBhHb4h/g63m?=
 =?us-ascii?Q?0gWpbnUKKt492w6oEPY0BDNFSuc+EUUOkpPJoRI4fsXXITZ+40D/5F8ctla5?=
 =?us-ascii?Q?TbfKjFYbnVGXdwM7P3akFFGF9novVAnuF3w4t1lSUwlacFn2PVL4DWhVhkBc?=
 =?us-ascii?Q?+pLqqrrffB91eyLQg26NhFjplHsbEa6afailu9NoH4Wr8gNZ1xYV+ptUR8yO?=
 =?us-ascii?Q?5tZT7lVdhrKQPAR7hTXeTwkGYm9sxfZW4osblnE6jngKj58cJAbB+KqawwtL?=
 =?us-ascii?Q?MchtAC1+SLcMyotfQy5/zhErGeGs0fgLzHxqIocKFtrhTMkw7UdCOurh9ljb?=
 =?us-ascii?Q?+unC3dUyqvz4WST3O64OJGh75sCw5uDduSmCW5IXy6TI4jnDOs/9bi5KHXgK?=
 =?us-ascii?Q?F8HAZJU0RO4I6XzZiqMt9+dHwSH95ZIQLRtoSHMhpbPEm1PgZL1Ca6l+8cZ+?=
 =?us-ascii?Q?xiFpuajfOQWLpflV+km2tM7YNjsjeb2UnyjsKWA0bF1TRg9XIGjn3SnUTTaH?=
 =?us-ascii?Q?McwUk50OWa+dg+i0Hywi8/T+ccFwAWZv80U8DvqQJ5c+KP7uk0g89d0FNOLO?=
 =?us-ascii?Q?eURyZFkSoCsASWJ1MptgiKDHB+82IubUxqVAhgTHzsMD4DrIwLO9pIYXTqYj?=
 =?us-ascii?Q?g+FO2uvIjlLWZ4Apgy4Z18GS4nf+R/MyOuguAjBkYwZ/2ARJk7zxTR6eo+Qb?=
 =?us-ascii?Q?D/zxJiVqjko/0FPKAbbYCgY6cyvO/qeqztkObWDZmHdTytmou62L9zXSYrXD?=
 =?us-ascii?Q?1qo4KkcIpLlqfTAqekaCMNyMk5pR1+33GAhj1Lu9b0B/KLMZ2C2NeXdaUML0?=
 =?us-ascii?Q?oXVKvrNBUPxzFgfF/eQovpPhGf1muiXSxYOLhqJ0hNO/MH6VPFNiX+PLaRVn?=
 =?us-ascii?Q?cFtptba6/z1C9hhBFoG1PrOvUxqpIeVF8eGoBVfdNu5bWJRtjdafblz90Bd0?=
 =?us-ascii?Q?e5124ULgLNsAxDDax5h8DzVv6/h6OhkOl5963r1aXXP6LVHpVk7dcDtYISm2?=
 =?us-ascii?Q?Tf70Fcaj/grCCtTrb5WUxhvfGOLv5g2wDLFhluzYsNy+UFLAjnrknkYUVLXV?=
 =?us-ascii?Q?+FzZ/bwbTB+LN1k1QjQRRDZRkP6xtGedbEwLEBM2W1GOHTwUtg+qjkhThy5A?=
 =?us-ascii?Q?aUpzjOErjvgXIRmtms/GGvTqmj0AxMdmSN4blNz35gG9+040cwZ1x+0xlHRN?=
 =?us-ascii?Q?A1tfL0ihTFiUKQg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aieKK1Vy6e6ZrZ8ddO5a3bxhuISMNsz10SuBQaxCPdSWbg1+9akbRDGtVM7o?=
 =?us-ascii?Q?jgGRf0kdo46NA7MBoZkSHmO0avpzKKD9egm9oSkDBCp/sVPH5OR65ugae4F6?=
 =?us-ascii?Q?m3rjQYMust5Jrm4KQ5HeKcSKSds5iavllCZCjA6D3/xu88cV3Q2B1FoIAq9M?=
 =?us-ascii?Q?ck0XWsg3rZ+Hm0RS1eyTUiS+GXL4iW8X5UVrL3DM6uIAieNoZEa2zYFKZbD/?=
 =?us-ascii?Q?M9s1cwp+jmrfyT0YrR9RrUkLnL6Zc61MbwUGNGjzPBims7JYQAOdMmNYNlle?=
 =?us-ascii?Q?cRsBhewAzyVuhH6ZVscd9SSKM6GE+ZtxVbTBxnekwYDrQYCX0h6NBKFo/IFM?=
 =?us-ascii?Q?rc7Yd7G4PYWiYOZ0XJbxeIPmTdH06dvO1YW7cu8YvJaAaDEWycDfMC1asWZc?=
 =?us-ascii?Q?rUkXN0ppaAvNClIKN7BpM9UvtDi2OLaLHPFiKd4KIv9FVv2zZchjgAOpH3EP?=
 =?us-ascii?Q?TDX/oqZN872Ipk1u7c1UphDYpHWVz8x4iW5p4XMjtO/5OqYxsCCwpSgvMo5L?=
 =?us-ascii?Q?ceK6e4/tRzA9KEZVMtoU5jIYuji8dB1ArgdyXYrkirczXCmLqnf26UZAjCsj?=
 =?us-ascii?Q?hBaDez1DEHUJngxlFUsfXlTPsclUR+ZmR3LPVVVh0VYfSLqpH/COKKCrUZv9?=
 =?us-ascii?Q?xAgsW1r7BcqQJyhQdzE4GsgyB8xQIfyGFmt7t9ZCSylJDfGJa0usFX9pM/yK?=
 =?us-ascii?Q?eAzKEMht8AiGXUOWjLBJuupGc//4N85vZkf3hZcJuK18oNpufm8dWR1ezL8i?=
 =?us-ascii?Q?mUIOvpUAI/IC+bsqEerAFn7m1+xUSfu5xj2v70Wv2pl8IbOCzZKPn+bQmTlA?=
 =?us-ascii?Q?7XOA7Gw9LwmYF7Jj6pjZIu8dSiz3Z5PTOqQJq6VIqam+IHfJUpFG1fuDBUdw?=
 =?us-ascii?Q?lfnnCgNgYxbg0WMErQl4WhKg5aV94IT57Pdsezjc26IEW0VA8IY0eqQXhM+A?=
 =?us-ascii?Q?Z7T6wWQz8TA3v30SNQeGGA/Oi6DdQTe1bHN6zdBeUvgLBSKEg7QZ8fjH8GFZ?=
 =?us-ascii?Q?r6Quz++aTzOzkfDdKLg6hngJDifloipe4qYXUJjvlPGVj75hmPrm9isV3w1N?=
 =?us-ascii?Q?4rFwrxdolj+GbKYfxErJNeMUznWLVL0YUm6jZ6dapOEp2dPykOFVXp5yyLyv?=
 =?us-ascii?Q?OjBtIGWpCKDp4hGlbjtMyvXSrY4LF6b4CJbZVJy8X+tmRdpH7ObyfsEHV89v?=
 =?us-ascii?Q?Q63CVMpKD4F9oQYY764dcklvgk8j54oPqSDzP5RXqn/nHvUueZncmBbGDcoe?=
 =?us-ascii?Q?dJiDF8MzprESkbk5jY+yvpkSuwpnzdSB1eHV+mk+GeYIO09j3QgeUObu6lgD?=
 =?us-ascii?Q?kQOqYdBS8xchjjZfMhYizuSol0nH2+f96584/otI91muvkuSN4Li4LY9HeRU?=
 =?us-ascii?Q?RCFKwDUXWrxtxrWG6LtDXNTrjwOT1Qzgg83NBEY5ZSc6aUvaaZWq2GRbZk1m?=
 =?us-ascii?Q?6J99fJpIjuxPpdgCMCRBecEzPbP4yOQmobPW+YmiIPzOxrA83UIL/vMBeeCL?=
 =?us-ascii?Q?1S2/n1Yy/8cKy0ofLneJ6/+AlFHS84qv/rhg+CFmvmTXNCf7dalHxPUAoteI?=
 =?us-ascii?Q?XAHWD62SRiLwvFYMHX8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525795375DC3A7263AABF8C0FC2DABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3203e65c-14fb-4135-0fe6-08ddd4ea893b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 13:09:54.5885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TsFTzvGWzBmjSkOPm8/JyQdck/ulvPkSV0wQcU2LKC2RJDXohuw2Oi0gOsOmwiCitiPiriikOcL+RG/TvTPuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
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

--_000_BN9PR12MB525795375DC3A7263AABF8C0FC2DABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Min, Frank <Frank.Min@amd.com>
Sent: Wednesday, August 6, 2025 21:07
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX co=
mmand


[AMD Official Use Only - AMD Internal Distribution Only]


From: Frank Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>

Date: Tue, 5 Aug 2025 22:30:54 +0800

Subject: [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX

command



The fw reserved GFX command is only supported starting from PSP fw

version 0x3a0e14 and 0x3b0e0d. Older versions do not support this command.



Add a version guard to ensure the command is only used when the running

PSP fw meets the minimum version requirement.



This ensures backward compatibility and safe operation across fw

revisions.



Signed-off-by: Frank Min <Frank.Min@amd.com<mailto:Frank.Min@amd.com>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++++---

1 file changed, 16 insertions(+), 3 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c

index 14121efb9d95..1acc1ffce31d 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

@@ -1043,15 +1043,28 @@ int psp_update_fw_reservation(struct psp_context *p=
sp)

{

        int ret;

        uint64_t reserv_addr, reserv_addr_ext;

-       uint32_t reserv_size, reserv_size_ext;

+       uint32_t reserv_size, reserv_size_ext, mp0_ip_ver;

        struct amdgpu_device *adev =3D psp->adev;



+       mp0_ip_ver =3D amdgpu_ip_version(adev, MP0_HWIP, 0);

+

        if (amdgpu_sriov_vf(psp->adev))

                return 0;



-       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(14, 0, 2)=
) &&

-           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(14, 0, 3)=
))

+       switch (mp0_ip_ver) {

+       case IP_VERSION(14, 0, 2):

+               if (adev->psp.sos.fw_version < 0x3b0e0d)

+                       return 0;

+               break;

+

+       case IP_VERSION(14, 0, 3):

+               if (adev->psp.sos.fw_version < 0x3a0e14)

+                       return 0;

+               break;

+

+       default:

                return 0;

+       }



        ret =3D psp_get_fw_reservation_info(psp, GFX_CMD_ID_FB_FW_RESERV_AD=
DR, &reserv_addr, &reserv_size);

        if (ret)

--

2.43.0

--_000_BN9PR12MB525795375DC3A7263AABF8C0FC2DABN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Arial",sans-serif;
	mso-ligatures:standardcontextual;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Arial",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.co=
m&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Regards,<br>
Hawking<o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Min, Frank &lt;Frank.Min@amd.c=
om&gt;
<br>
<b>Sent:</b> Wednesday, August 6, 2025 21:07<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add PSP fw version check for fw reserve=
 GFX command<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">From: Frank =
Min &lt;<a href=3D"mailto:Frank.Min@amd.com">Frank.Min@amd.com</a>&gt;<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Date: Tue, 5=
 Aug 2025 22:30:54 +0800<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Subject: [PA=
TCH] drm/amdgpu: Add PSP fw version check for fw reserve GFX<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">command<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">The fw reser=
ved GFX command is only supported starting from PSP fw<o:p></o:p></span></p=
>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">version 0x3a=
0e14 and 0x3b0e0d. Older versions do not support this command.<o:p></o:p></=
span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Add a versio=
n guard to ensure the command is only used when the running<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">PSP fw meets=
 the minimum version requirement.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">This ensures=
 backward compatibility and safe operation across fw<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">revisions.<o=
:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">Signed-off-b=
y: Frank Min &lt;<a href=3D"mailto:Frank.Min@amd.com">Frank.Min@amd.com</a>=
&gt;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">---<o:p></o:=
p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">drivers/gpu/=
drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++++---<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">1 file chang=
ed, 16 insertions(+), 3 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_psp.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">index 14121e=
fb9d95..1acc1ffce31d 100644<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">--- a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+++ b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">@@ -1043,15 =
+1043,28 @@ int psp_update_fw_reservation(struct psp_context *psp)<o:p></o:=
p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">{<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserv_addr, reserv_addr_ext;<o:p><=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">-&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserv_size, reserv_size_ext;<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserv_size, reserv_size_ext, mp0_ip_ver=
;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;adev;=
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mp0_ip_ver =3D amdgpu_ip_version(adev, MP0_HWIP, =
0);<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">-&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP=
_VERSION(14, 0, 2)) &amp;&amp;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">-&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, =
MP0_HWIP, 0) !=3D IP_VERSION(14, 0, 3)))<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; switch (mp0_ip_ver) {<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(14, 0, 2):<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (adev-&gt;psp.sos.fw_version &lt; 0x3b0e0d)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span><=
/p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(14, 0, 3):<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (adev-&gt;psp.sos.fw_version &lt; 0x3a0e14)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span><=
/p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas"><o:p>&nbsp;<=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_get_fw_reservation_info(psp, GFX=
_CMD_ID_FB_FW_RESERV_ADDR, &amp;reserv_addr, &amp;reserv_size);<o:p></o:p><=
/span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">--<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:Consolas">2.43.0<o:p><=
/o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB525795375DC3A7263AABF8C0FC2DABN9PR12MB5257namp_--
