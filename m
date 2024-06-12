Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51931C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 23:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B63010E06E;
	Wed, 12 Jun 2024 23:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OStsSiKN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F178610E06E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 23:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uov3GHvA8+rmokL+cFWZIk//msMxq8KIo9nv2GPOIb195Tp0exnORIhgVXM+D2qnfJU30OY3MUi4J33o4cZsjvaM362mdsiEj0khenEUP0m5CTGibWE0XDJOOAOyt6jHUf86WrcWnUGhegA67LGfFL1SWgKS6v8vJrU7NyxOOdWX9OhZ1jTpbCYRtwFUCW5ZVyXXraXdpr99qYJyi5/HSD69q9Wbk6hIeSkAqCLoJIh/eKK5tZf/3zYCwouhypgXed1MdMhtn49EAteomXhtAKZnmoYLO73FEeHLdzzA/gg3vuKZBe2vBsng1MH6fBVK87USsIS1vLLrK6UEXb+WyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxqPQN/bZG1LEjwjIwf7q/t3g7+WXmJ+xn82S/MVyoY=;
 b=d8CpGsKkR2RcnvIN8Jqr8gg+jgH38fcq/DA/zVc4gh2jZfvJKpCxawoDw3Oj6AEPkHQeWvRqvipfLvbVMPgQu4/ZaEdZXHmobBVf5F9YaCoCwHhtVWX0c1sEYa0hcrXlS6PSaF5hq+Vm7By07ZZv36MA5nDGejLRK3oHzI0KguVR37nVNsoU/Do6ditMirG93ZvrcS7ZQ97RH9VZBVuvO8qFZfsacOIWo6SnK6vw3oxJdeue9lD5Fqvscy2INtbDs0PHA+4cjc+8ezwOhrOkCWVYlGadDNWysBESX8cTrQKqOZnh+vjOR0A1Llh+aLu2d2Z3yyu4sowydeiPUl9QIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxqPQN/bZG1LEjwjIwf7q/t3g7+WXmJ+xn82S/MVyoY=;
 b=OStsSiKNAXcLe+4co1MvA9uHsXF91Q0euywzl2lkjfoKliCMDp9Ov8iQb9hrm0uisxqLoSoDt2FgXI4wl7UE+J4HCq3N5YcGUqqBZFxYx2aB1iTzGWbMrqNxb4XSLiIZWY1mdUpyNy5KMXAJoSStMGNljTy/yldKI5IDQRRDicI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 23:49:49 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%6]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 23:49:49 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: Enable idle optimizations on DCN401
Thread-Topic: [PATCH] drm/amd/display: Enable idle optimizations on DCN401
Thread-Index: AQHavDTgJsJMNKpCoUG+flHmtCXuGbHEzccQ
Date: Wed, 12 Jun 2024 23:49:49 +0000
Message-ID: <DM4PR12MB516564255A30BEB2896FEADC8EC02@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240611192329.1983538-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240611192329.1983538-1-aurabindo.pillai@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fc886a23-0893-4618-b8c9-e28a7af24bf6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-12T23:48:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH0PR12MB8008:EE_
x-ms-office365-filtering-correlation-id: 27300ebc-d610-4976-cc74-08dc8b3a58bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?kH9sC1Zp5usiHyGd+Y1zsRkcFmLHId8KbHas4781IhWo+rIOoACMrtCNz1Us?=
 =?us-ascii?Q?WulJKIO04T4OFrmfKKL5ZqUemyDe96eHQLsKbweQWurgQzUBxo5i2GCO77n4?=
 =?us-ascii?Q?PRed/KNPtBWShic5dVsOK4/moiYI/sxPmqJOuCDxkkfxa5jARDHEXgsw9nF2?=
 =?us-ascii?Q?gGyuT6RyEBonJtte6FmPSCNRaCmt5SlRP6HYM4Ldw0IrEb1dNCAqfajn/Mg7?=
 =?us-ascii?Q?nL6HBxuSUbzFuWFKBib1yf1eAykzBZgIggPKjAbELsF7++IuVp/6jZtycuTL?=
 =?us-ascii?Q?Os1MhAUUfc7nCo+wzlv2iq1RdYadcYxRGRuyX5DfKakkPC1AjthukpwzfJ+a?=
 =?us-ascii?Q?L6pK+009jgmNyPBgWlEMJd0GuH3nSlTt84CQV73CfNOzIJJY2ydpBn+tCRFt?=
 =?us-ascii?Q?xRt2PB9S7zpAI0XWy/72bLTFAprfY1Vd8x1pqH10HLbVvirXxQ7oPo4lHgNq?=
 =?us-ascii?Q?+i8hgZxMu8Faffiss9b9/h5Tc3XT/6baDqnmjDZzOdoPxgI9ANjBPM6zPb4j?=
 =?us-ascii?Q?IIDfzk8ZieNVUYHqS8zzXAAipLWitxTsgnsWVL3X9TqrxPizPPUiK+SyWXV6?=
 =?us-ascii?Q?H9wGEbCRyZlbpVgY3lhdXLVu6VblJl0lE/fMmZ07aqgxhaV1Hqsh9WtKpzio?=
 =?us-ascii?Q?zURQINUTpy9Rix6MHiQJrRfwEwvF3vM5t9wPWV+EC3MZhS59DHdPQENz8sIU?=
 =?us-ascii?Q?IJo/1nnDStT+JuR5HEOF//fv4/8EAR0RQH6PGCvPpoCHv1stP9fURVytcVpQ?=
 =?us-ascii?Q?/tQwGw/eTerDrwSLK1x6+j08Rd/T+ZC+B3/aZH4+xkiUaY+4un1v0JPpkju1?=
 =?us-ascii?Q?F2nfertXLGhk/8Dwn8Berl5EbmGBdaPRdNqil8DORgjNhOfyQek47STF7OyP?=
 =?us-ascii?Q?h0kaaQzRqo5pDhG7Rpg8oZ0SiQalHkCu+RIhws51UkjPhs1+itoeRgnI8cbg?=
 =?us-ascii?Q?+8jnoaT3NCTgVCGb8nJRESsrT4Eyg8jhbdPCWZk8necbeBtwTekfCLdYcLrO?=
 =?us-ascii?Q?/uO2iTP73TS/zxc1ZrqTO8WgeEZaJEG4Kz804WsADKDaHnK67MH61/2tmmOe?=
 =?us-ascii?Q?gaRv86t54KZeGfWmHT9wLdlfe+WLxc/qMCim7d56ZfEywo1/GchQ0R+9YAxq?=
 =?us-ascii?Q?65krOExhA8AECQm+t2tvz7ecR1DVCMbuH9zpWfn+1N63b3KDhdvo+AEDnEZO?=
 =?us-ascii?Q?bez7KnNsE/kKXcEyMfqjbtgrMOdACSzacNvDTGMEnDNwt3jUwQ+9+hWrjgkq?=
 =?us-ascii?Q?ydZCKsUuP06IcJV02CgkrAv4wilDAmgxbQVEPsQe/aLv9CEBVV5utJnbyOME?=
 =?us-ascii?Q?3pLy19u/JP/N7X/xKAl2SgRWbu+qw8vXpfX+fFsSKWY1fZ5pUUlelkCXnjn2?=
 =?us-ascii?Q?AdnU4Vc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RKV+NsVXIE4sn4IHWjVxX02AYw1js/atYtG6Z6mEYrq/1xmDgBAvDIDU9HSl?=
 =?us-ascii?Q?b4LeBGvcqQtnDKwa4xH83iMqPToARxV5sKRkPTowhPkyf06MXNu7/+YvyqvI?=
 =?us-ascii?Q?0RS5rz87HWwlX44EAAzmv+egsuEqwqWMbL8JzG4hiEEsAjUUaAHPX4efhAYa?=
 =?us-ascii?Q?AYsGhTiVU/dAu37tlSZVYX/uIeleLVPijraL0PvUPxXcm94SBYjOvDn/4TWN?=
 =?us-ascii?Q?8jJ5ElDEa9m1Y4ibBpydH+hDFTuzvneYUMxtqBacPxzffy2D1jP0HG2CQSbA?=
 =?us-ascii?Q?EeDWZYKNTdXbqNyfammRQNvfoGSkFVNRN9CPadMVPvsn4bOwJcBxIEh5jHlQ?=
 =?us-ascii?Q?gvUGAY6SEV/pvwkMUCdGoCjsHUeAHhrfIE8EVvczlmcimBLHMdmqb2pFxTT8?=
 =?us-ascii?Q?GnpjI09uxGA1kREToeSB97xswYUsWRs0vTuFSNSRdQWIAHe+JWXBZBjxPgNb?=
 =?us-ascii?Q?fxPvoa4GSKG3JzJrghkktNanic1b8nMyg30j4cDhFDhK8DBIl6AesV+AFKsO?=
 =?us-ascii?Q?BkMu9SzB2tcN8pfoykS52U34QqIlAcXhe+NS7EKqI9LKkWLpMM0T8AJbggty?=
 =?us-ascii?Q?id2zBhYPP+OsUko8Bq8z/WLvQg3G2i3aPjwZn6DIFf2GqQnIwr3nMJ8cdBpi?=
 =?us-ascii?Q?Sy9MYZBLW0f0JgUiwv1yM/yDlOO34aMAXTcQEaCWShElEj+SmSjfJJNCukPX?=
 =?us-ascii?Q?JMmV3CE8j0FyxMO8P1sgEP8jIapj0shfc5+8mUq7hkRX+stBRyuRbJJohLra?=
 =?us-ascii?Q?EIwGt1I8HWMqXGevG2gy4oTQzsr8pCAlrja1/s2RacSum5naWviMcqfu7cc0?=
 =?us-ascii?Q?t0VkWTfRHwYxiPPMvTOH1TUUiZuPvPkHbOs9Lh8HFQGSAZr5vTpsEtjVGHSK?=
 =?us-ascii?Q?VpldK1tJ1vQHSnItaJp/4KzUPPSo6zSQsomsWegA9D/RZ4cAjIOb4X7TAMRj?=
 =?us-ascii?Q?dScnnuOeT92RWSd3UqEHEzGHS9pd2DKQw6OlN8ZX3YLdJtpcXSy7+h/DYJ0S?=
 =?us-ascii?Q?ShJ1DcAEg3cR632HcG6StKl22kwmEPBp0F2802R46k2VgnAffemcp2zACe9v?=
 =?us-ascii?Q?cT6pe8eZX0/YxlG5IqZsPQVE8iwIwZD7tpPeLhdKgv7NhJ+Nu6+cklFDczaP?=
 =?us-ascii?Q?FAigo+NPVOrRVlofcRNOr1Bo5rJncDL5w5ig3A0Ik++DXeBJfZMi34Xsr6Py?=
 =?us-ascii?Q?/a6staqtW6//uA10xW668L92Bdka+gteWHzpRuLHgE2ChaNL/iJ8wmWLLbLK?=
 =?us-ascii?Q?BT+i9oyDFS8TfrQyduFZ4vbpzA141FjRTPyOiHRBdeCtIMWqOTg+b0MSznJg?=
 =?us-ascii?Q?cuCfAFnP6IowI6hhw1iMD743m+qrT+tlv1QSTvBnIHayXanR0IBaDyt47eRn?=
 =?us-ascii?Q?Bq4iz5SNc9YhJC95LdEauTLRMMl96GpwP9zhh2Mfhh9n0Dus94QVwu4Y2Npp?=
 =?us-ascii?Q?b87FyBrItpQagG15fCbHxRazDETMOOvW855BNiH6uPpjb6DKAjqJrUy82nFK?=
 =?us-ascii?Q?QdCx6ulJkyODJZq6+88h9IK8KaTdpHpOxDRkinHxlRqLd+ssWKXyFIx926ZR?=
 =?us-ascii?Q?KerDOU8amx1UiPeGN90=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27300ebc-d610-4976-cc74-08dc8b3a58bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 23:49:49.2711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6EUb0bMyB/EoxDp6bt/w5KjRh6p4kSFG9sfGPq8iOUCnwPTuU9GIfu0pQSrnKho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: Wednesday, June 12, 2024 3:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Wentland, Harry <Harry.We=
ntland@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Pillai, Au=
rabindo <Aurabindo.Pillai@amd.com>
Subject: [PATCH] drm/amd/display: Enable idle optimizations on DCN401

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Idle optimizations were disabled due to some bugs which are now fixed in DM=
CUB and PM firwmare. Enable these the optimizations back.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index ea803df8645e..d78dc63f82fd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -731,9 +731,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
                }
        },
        .force_cositing =3D CHROMA_COSITING_TOPLEFT + 1,
-       .disable_idle_power_optimizations =3D true,
        .edp_oled_no_backlight_enable =3D true,
-       .disable_boot_optimizations =3D true,
 };

 static struct dce_aux *dcn401_aux_engine_create(
--
2.45.2

