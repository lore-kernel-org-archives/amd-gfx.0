Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8F3C61DB2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 03:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27A710E167;
	Fri, 13 Jun 2025 03:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SdldbrUQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF3410E167
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 03:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK30IMBEKbHQ9ZbbBb2m+PtxFUyvs36qg8DjvOULj+qplNLfbbfSQf07v3Yu0Qq+eiF10rRQXDpTugasEe/sSFMLNlkkxwG2I/bo2hkMOYtU600yfOLfKRu+r52XmFw176zs00ZT2MLd3Lw+MrSDy2c8YyW9zRftZpU+mYhVsYVYZoMzq1cZoh+QDDPfu/gZmU/IZIXer5gjkYPa3dd48chSEYABLMNs2Jv/TxPxlzBMiVg7XHRo58HzVssSj6p6jz7o70hZF1VGdj5Jc+FSQHlritJpEGUOYwVgRv7BBDX03CzReTfXpqtoPE2luow8k7OCne+qW9LCb482NMNXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNvlfE3FSFjLU/FJeRj9A/xsZEfl8HDIapBzkd97NlA=;
 b=dhvHqENxqQ+61fWCWWujoaSK/JW7MH+beTvRxKZQLXQsCzqOQ+cwUx+ziKUYgP1oWg2fFgTwhNttUm3cFxsMqKJZ7DJnzhWooQ2oYWtI4cybp5HBaUSRA7WAdYOzO4UlG+7EVJ1io3eZe411yyxq+U5kDXvb/Df78m0SAth/Q7vP7+eSfD5Ebewy6QqHaeEwfyvjJiJvzrNP9ZkR39dqoCxp/oIJR6XtZtjwBKJGjvl/TvRyWldV6zMucs5cLUyWpe4llPhGucrklCSNClISmW2KmJcfiZspzrMEpXCjnMIDzJGg0hSvIfKSyIlStiaoMJuyT80ISiWVzKjmJQfIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNvlfE3FSFjLU/FJeRj9A/xsZEfl8HDIapBzkd97NlA=;
 b=SdldbrUQk3xZTLsqeRJl6XabFLUtkLU95SXMbF/UgykITWJUO7wx6UCEqWWLUAZtPRzi9TIO6mSpf0ckf0+cVOFAsi8Gf6AHDxx/qLSXoEQBWfdM6kX05NQypak/cLGKm/Jn3QzD0OEa/iFcTvMKA+3BOu9EirHdpP7fhW0I4Tk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 03:51:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 03:51:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: Re: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Topic: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Index: AQHb3BBDnmW9woHOvkKRyWJSQiuCabQAc9CT
Date: Fri, 13 Jun 2025 03:51:43 +0000
Message-ID: <BN9PR12MB52575B4796D7E46E3DA1B5F3FC77A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250613030636.188030-1-ganglxie@amd.com>
In-Reply-To: <20250613030636.188030-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-13T03:48:05.9514735Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB8154:EE_
x-ms-office365-filtering-correlation-id: 5c1760f2-fb9e-41fb-87b5-08ddaa2d9c95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?SPvMhCfuN73j1zizrIMkWoW7z3KBLS8L8DU98yB+OEAY8WzsyAX6r+MP?=
 =?Windows-1252?Q?dTx13Qt+nVb4aOKmhxYoRPVdhZqD+a4ATSRlkSPrPH7UugyOppvZRYrr?=
 =?Windows-1252?Q?rdAj2EQ7QmMYp+ubzhVP+1zrQ53pY25cYIPaAzMtdEpfvnLRgu0Pvnqs?=
 =?Windows-1252?Q?Y0l6a40u/SyL/W6MaL6bkmUR0PWzMTBr/EqzjFlab7b8BDYlDm3gGnsM?=
 =?Windows-1252?Q?rwV2xfTeH40NzaVBSl2/TdpFtQ9b+ijKotBEN+pWrMtjRCBQHHA3p1XK?=
 =?Windows-1252?Q?RBMRcb6ggnxrZGezdQn766POEN9s/pFmvZxeMylmb7AiRyuBQUGhQaCz?=
 =?Windows-1252?Q?5crhbGSjX4GFv1MtWmq/FOwWYgh1jQd9WXTy7D1R6Ntq6XxoCdLPUTv6?=
 =?Windows-1252?Q?J5Y6ZKXUuyD/lWoqvDWT4q+AgBlakIseu7qeoVWCa6Uqn5YDtETOjHkA?=
 =?Windows-1252?Q?axAsj0HAp1V4Gkkp7I2NCkwTPoyBmBDKS9nh7+6jy3ZmrVKYCKRrnhN8?=
 =?Windows-1252?Q?NrXfWCnHq84GxnYYxuF8VurkWkZAFb01iBneX6uo+xL0vhFVD9wa9Q6p?=
 =?Windows-1252?Q?Uk3rkdEv+AQT0lO1nlENoJaNi5LKS1Vk5U3Em7xkB7FKwBaKkosx08so?=
 =?Windows-1252?Q?/kw6rkqkjUrNjlifo+JGZomTpxFx4jDB5Rqse6HMihTBtRlaXpAvySDq?=
 =?Windows-1252?Q?eDEUPLD5GadfFsUuShUqqfkVdr1rji3s2tDVlkmtwHwpnv0YLotItKST?=
 =?Windows-1252?Q?rB0GG+WvOv36hv5PVYnsNU4W9eSFP/cxm5ngsvi95AOgpvRGwbM8Y/NG?=
 =?Windows-1252?Q?yqi7bgwi4CFch3SP2Mn7z1GomEizHqi0CbSaSmHxxoMnRhZl9JwOzlLt?=
 =?Windows-1252?Q?3n4l/LUX88mWc6b9gmae9BY8XpbsgfqdXbnhW+hsn6qWjJxA99giope2?=
 =?Windows-1252?Q?fesrI4hkdEaLiNQfX68jNfIXU+3KuvWs08fNweYU1vTK0/w1tsSBENJ7?=
 =?Windows-1252?Q?tU7dnDjFCuawlprhQoBJCbJxA+FQTgITdK8Uyjvlv6gpZamKEdfTLWT5?=
 =?Windows-1252?Q?Qi0uDSxQ0FhkH/NBX6pW9SeHjkMBrsanTiJ4XC8nv4BnUGGVGS03wwyO?=
 =?Windows-1252?Q?MggipavjvxJ43xQ+fWl5504HwmgQAf4NvBIedzpumS/7I4tdkpI87d4i?=
 =?Windows-1252?Q?0uEPcYCNkQeDw0sYQt2Bg2TZsqoWtue/csLlkq/Y4XuZdiTwOR9jBAIU?=
 =?Windows-1252?Q?z4BmaQBZP1SRk+IW2cfbMCeWggzzZT0rm+03ea1Wfl/lqGMsbhbH37j5?=
 =?Windows-1252?Q?rC6ujN/8U5/9RvNr3h1w1UIixZTHlw0wRS7oJ+6aKiHf4qo5/6Ip1Vi/?=
 =?Windows-1252?Q?sIEGmq4Lv9vTOmfN9p0/OcYWEybJ4vm8G+O32/FkkWxF0K4WwoRqp5ra?=
 =?Windows-1252?Q?2ZsOUtN7fZP71tQ7IhSKaCzb4cw5pdUnPZeZixt4JsK/ySBSpwKIjq0v?=
 =?Windows-1252?Q?Dmn0uB1GpDNrQbZyMELR8n3Q6CQ54AKvwCyBWa0AT8lEQ0nli9/ofpgi?=
 =?Windows-1252?Q?cNRzt4GNKzxdDnWBp7m/AdYFtPV1ftrIG3eQOMvwvzzOG/kQJzSTkecn?=
 =?Windows-1252?Q?DJM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?DZEi76OyOnGDSfRvRYlcwH4USrPzUOwwuv8ml+PPp0PPb8AL2ippayVb?=
 =?Windows-1252?Q?JBpulJFQM9BblH4xoG42SofSRU9A7xz8tP6cnyDcfHfiwxCnzY/xQAh7?=
 =?Windows-1252?Q?xoLCy5G9Buy/SZEq9nNlVkw28/Gsd3ZxSOZ+pniUzlI6f6Erjj+Uxq2L?=
 =?Windows-1252?Q?NqcKhTDmCm9JDHLa1eIzqQcFh3Y5hdsgvv5yHKvHWlWqG8xKCcqQ9c6G?=
 =?Windows-1252?Q?gqRYH4BVnxr5g6Bd6uRBwKRHUt8gLP08zLdpLl/yTGofBVTdcB3Ff6R/?=
 =?Windows-1252?Q?7iV/DsSi5d2FlXaETzFrnXAw4apPCVydbyFtA5TGKe4CYZMjQJIL5a2c?=
 =?Windows-1252?Q?KZ5GRVan+Ut85VfxoU1xYsRuBI0fCE/OpaaIPEB1NCE/UkgN2KgSjHfA?=
 =?Windows-1252?Q?muzszMJUBZtQx4LYvIm3+HomwaWSd2467I1MI7BldXW4YRg9SVMxBE5q?=
 =?Windows-1252?Q?vsDy0rMuO1hUZVjZcaZJpjsFJFfHLoJA5GJA9HciY0KJCn40gdfyhjsH?=
 =?Windows-1252?Q?PDzP7eHedKqg05uMBRnCEA47GRRR06/VzGbatMK+AgbToXidMBV3WzU+?=
 =?Windows-1252?Q?DoTaY2iQOMoPcrxpebrKdn6pEjVYyE9QPrqGt2Xfgq3VMtdiaoCVAM1A?=
 =?Windows-1252?Q?NO35JY45L/2omakgArhD6YKEyqBmUNr90Wd+UDq7PZ1AIosUqsJEwU5E?=
 =?Windows-1252?Q?aIqY3OF9Nvnw+b52Ev39r44xBIMZK7NotJ0Roy42Vr4l/bnozDPtjPjL?=
 =?Windows-1252?Q?mpjs/2lz1kVnZkId/B1fdCWGtPUcmfPle/Pqne/s/touJZzoO+THKhbk?=
 =?Windows-1252?Q?iPLu5rJSnZ7J+pHwi8X8qzsceayu/yquDhX8KOSnAaeSjkU/DuNJvRoW?=
 =?Windows-1252?Q?s6Puh1ao0Y9TeZG/rAEhXf+dckabVhak55l5DGFpJPiXbf/Ezg0KOrHF?=
 =?Windows-1252?Q?qDGRXRN0SBUPp+dFAZSkeZ6Hrk2C1IQCxLjQHzsaoYA1GKTd9pfyMyFd?=
 =?Windows-1252?Q?IS8hzk2n8XNwVxZ1mbNJta/+wYy5kyO343IhwrRM/7RYovWjBUsrTzQD?=
 =?Windows-1252?Q?/s8OfJ00zajAmrvDaTFsImlk+aFn0DecLgk+FJBoxy6heQYe7Z5OBQJR?=
 =?Windows-1252?Q?6QFpsWNdd/6ufOIxZnk4u+Vo/wxP3CgaMWuMUvEQtVuVY4ePLNDckZXE?=
 =?Windows-1252?Q?Fg6k9ZxqzwxsmOe8iS0C7xowwSwPoTEJBlrg7kFsmyAX+tk/oiTpuyjD?=
 =?Windows-1252?Q?SE3LWl9o2KpuH//cRiVes86cRCoRUbODVo/D4rQ6uHlZF8dtsk2afF/B?=
 =?Windows-1252?Q?cPh39NK2qtRrD1dQxD1etVHWx34axnNaK+LuPtENiAV9nai/dULYQOeE?=
 =?Windows-1252?Q?zCRpV8sBJ4a7o3/gOysdwFno6Rh0ouNX/Kv/iPx3dd1rAqNeFvSxzczQ?=
 =?Windows-1252?Q?a+RzS5Ghcck6Z0xgLz1ec20c4hddQbd4EsaXmp34KF2TiHz514Aef8+K?=
 =?Windows-1252?Q?0Zgv0yNAOWBM5zvV5rjTII5LO6j9iXcAbN2+krbeMRZ8U+wqCpRiE6k7?=
 =?Windows-1252?Q?aY2xVy+58NozrcpWJY6lhl3Gng0slJqsQ8IVM8625XclDi7+XK0HYWOh?=
 =?Windows-1252?Q?PsRQHZAzJnjJVTxtFusc36gqhGTjw1kD62939MeojIdAqQ2ZYmbBUT7O?=
 =?Windows-1252?Q?P8Rz7NaZXPwrVvRPnN8m3khauKZgwKRsmP/hYfK/eomkqJSAPfGfgQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52575B4796D7E46E3DA1B5F3FC77ABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1760f2-fb9e-41fb-87b5-08ddaa2d9c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 03:51:43.3464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8o/qpxNzV1js3OrIOQXaBOajjmVrlHxLQ0bLqKjbHAFgYa+YIHpnU1Ny11opV00FKyCJh6cRSxVYarPXsP9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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

--_000_BN9PR12MB52575B4796D7E46E3DA1B5F3FC77ABN9PR12MB5257namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

                         if ((amdgpu_bad_page_threshold =3D=3D -1) ||
-                           (amdgpu_bad_page_threshold =3D=3D -2)) {
+                               (amdgpu_bad_page_threshold =3D=3D -2)) {

hmm=85. Is it fixing code alignment?

Regards,
Hawking
From: Xie, Patrick <Gangliang.Xie@amd.com>
Date: Friday, June 13, 2025 at 11:07
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>, Zhou1, Tao <Tao.Zhou1@amd.com>,=
 Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will issue a warning
message when threshold is reached and continue runtime services.

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2ddedf476542..a9246c53bde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)
                 dev_warn(adev->dev,
                         "Saved bad pages %d reaches threshold value %d\n",
                         control->ras_num_bad_pages, ras->bad_page_cnt_thre=
shold);
-               control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
-               if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
-                       control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD;
-                       control->tbl_rai.health_percent =3D 0;
-               }
-
                 if ((amdgpu_bad_page_threshold !=3D -1) &&
-                   (amdgpu_bad_page_threshold !=3D -2))
+                   (amdgpu_bad_page_threshold !=3D -2)) {
+                       control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
+                       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_=
1) {
+                               control->tbl_rai.rma_status =3D GPU_RETIRED=
__ECC_REACH_THRESHOLD;
+                               control->tbl_rai.health_percent =3D 0;
+                       }
                         ras->is_rma =3D true;
-
-               /* ignore the -ENOTSUPP return value */
-               amdgpu_dpm_send_rma_reason(adev);
+                       /* ignore the -ENOTSUPP return value */
+                       amdgpu_dpm_send_rma_reason(adev);
+               }
         }

         if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
@@ -1509,7 +1508,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                                 "RAS records:%d exceed threshold:%d\n",
                                 control->ras_num_bad_pages, ras->bad_page_=
cnt_threshold);
                         if ((amdgpu_bad_page_threshold =3D=3D -1) ||
-                           (amdgpu_bad_page_threshold =3D=3D -2)) {
+                               (amdgpu_bad_page_threshold =3D=3D -2)) {
                                 res =3D 0;
                                 dev_warn(adev->dev,
                                          "Please consult AMD Service Actio=
n Guide (SAG) for appropriate service procedures\n");
--
2.34.1

--_000_BN9PR12MB52575B4796D7E46E3DA1B5F3FC77ABN9PR12MB5257namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_bad_page_thr=
eshold =3D=3D -1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br=
>
<br>
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">hmm=85. Is it fixing code alignment?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Regards,<br>
Hawking<o:p></o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Xie, Patrick &lt;Ga=
ngliang.Xie@amd.com&gt;<br>
<b>Date: </b>Friday, June 13, 2025 at 11:07<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;, Xie, Patrick &lt;Gangliang.Xie@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_thresho=
ld<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will iss=
ue a warning<br>
message when threshold is reached and continue runtime services.<br>
<br>
Signed-off-by: ganglxie &lt;ganglxie@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp; | 21 +++=
++++++----------<br>
&nbsp;1 file changed, 10 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index 2ddedf476542..a9246c53bde9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Saved bad pages %d reaches threshold value %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; contr=
ol-&gt;ras_num_bad_pages, ras-&gt;bad_page_cnt_threshold);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; control-&gt;tbl_hdr.header =3D RAS_TABLE_HDR_BAD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (control-&gt;tbl_hdr.version &gt;=3D RAS_TABLE_VER_V2_1) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
rai.rma_status =3D GPU_RETIRED__ECC_REACH_THRESHOLD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
rai.health_percent =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((amdgpu_bad_page_threshold !=3D -1) &amp;&amp;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold !=3D -2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold !=3D -2)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
hdr.header =3D RAS_TABLE_HDR_BAD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (control-&gt;=
tbl_hdr.version &gt;=3D RAS_TABLE_VER_V2_1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_rai.rma_status =3D GPU_RETI=
RED__ECC_REACH_THRESHOLD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_rai.health_percent =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras-&=
gt;is_rma =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* ignore the -ENOTSUPP return value */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_send_rma_reason(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ignore the -E=
NOTSUPP return value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_send_=
rma_reason(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (control-&gt;tbl_hdr.ve=
rsion &gt;=3D RAS_TABLE_VER_V2_1)<br>
@@ -1509,7 +1508,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS records:%d exceed thre=
shold:%d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;ras_num_bad_pages, r=
as-&gt;bad_page_cnt_threshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((=
amdgpu_bad_page_threshold =3D=3D -1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;Please consult AMD Service Action Guide (SAG) f=
or appropriate service procedures\n&quot;);<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52575B4796D7E46E3DA1B5F3FC77ABN9PR12MB5257namp_--
