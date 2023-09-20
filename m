Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9BDCE79AC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 08:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318D210E461;
	Wed, 20 Sep 2023 08:41:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF8210E461
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzzDeq6w116XGtq0OLLHWGToSUCmSqSBN000AaCaPguWujjucMT41UEdS1OygOBvICY5soNu7roeFYr020SbOPl2k41DJdXnT7AA4zteq+Ld57IWyqPxAxUu8DXPqmDrPoDCHChwRMkuaqa1/R5/Kbausis1ZPJkFThq2HoIl9/9suY9ihqUnfBLDugKlO2Yu0CVZbAGscorrZ6/B7lpib6QxKnwsh9mIcKJP4FE1hesNla8axPI6/X9VUiRGGF8aUuRyTCt4WTBQYqjx0/cN7Fnn90gF22RSLmj0AtA46+N1bs0ha2USmoC0x7+JfmsDobZjOrUtZv7hPsmw2trkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdvRA8FSGJz7YkPHJ3fhKcJYvCq7Ywt0b3BTnT7SHvc=;
 b=BIxov3pNhBI/SPFRhVytSSBuY78X13DHUZrtaExSNrz4GkjpT4MIM4KePuC7KzBBpuVN3tYTAE57QZ6xn9z33lD5g1ChnHV+92W12o29CY0YfGnckTDO4kiAXt8D3uUVVCOj5EPFeRovyenMYBnvIHCy5mLz7YvFbxFI7ptMBQxVycip/WBpg2aG+fzSIorb2KZXP2KanOmeDqPlBJGmySz5rBUt5S09FBjbiwam5BG7B1PMw4GycnYL3F1ICKJ1Bhi20caG/WKiVlgm0b8BKT+fviDxjyaUBcTzo3nA8T+B8SaSuDTDWfVP5ElVvjnVSgfmqN61V+YBGq7d2Ex9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdvRA8FSGJz7YkPHJ3fhKcJYvCq7Ywt0b3BTnT7SHvc=;
 b=Q/YsFbyPBg/OvzCqt0oY1ierI+54k3Vu84cmojfQ9L8nVJkGpG4xZ16qfmilH8spTFVs022cIppWQQall8tAuXbDVpZ+rqeNXHhzYQHCef1H3im3A7t6y2xh5Gsvb5YYHlqdkrw0StHAY4wXa/1j7KOM9fBedftB8u780Hdf3UI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 08:41:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:41:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
 bitmap update
Thread-Topic: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
 bitmap update
Thread-Index: AQHZ6522xDox4mqhO0+N0IQr57GEJbAjZSAA
Date: Wed, 20 Sep 2023 08:41:24 +0000
Message-ID: <BN9PR12MB525717BC1B6E352D57297367FCF9A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230920083659.8237-1-tao.zhou1@amd.com>
 <20230920083659.8237-3-tao.zhou1@amd.com>
In-Reply-To: <20230920083659.8237-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=acfd19d0-22c4-475f-82ec-414dcbd93766;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-20T08:40:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7606:EE_
x-ms-office365-filtering-correlation-id: 643b8fd6-f460-4655-cfbd-08dbb9b55f4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VK8tmPgQGg2Mp3QdLxxRWcEZAZHzwqZuEity6TdaamWz2B6VnrolkFaj880Ry3pICAx2DWhdw4HgS7PdhM+MxcG3z7bLxDzKJeyYZxKHn1pwCuId1op3K78S+fe0u40nTddUgwtzfxfytDYDsAGXOzvwlDYqTt7KbYxR2uALZCmwhfLS68bsZYQ85U1OVEuyyReQ4F67OEBqlOqL3rPeM9Swtztei8C6VgfAGsfesPi+Cjyz9IX9MBjMtSoKgiDDQTV9l7XJpxXiqfz2mQPQdy1zufvtAoMBOTNKLooJpgALFIZu5la4p+XLjuLBq+U2FRmiGfEwYEcuFea0zNb9CqKSN9Ba7sHoqMEOBVgBKWWJQrc0tDTxBV5Zf7N8aaXHgF2yshJ88iBr8hTFJz+haZT/LfRCp4JcMd+zNti/AjQRb+lukQ/C4y6RFPJjx3eBW//OsoQlIL7kCWJ1wjEWHXo+gHKXLSplTqtD9Vp1Vc9wPWzdvfDzO6o+Y42WRz9u3RaXitlJEiyhbhqJg54aVSdgXqHY4DQ8qnZCzczOEpXX10C/+i7oT/ooS6IUPf+eBpevFl+Rv4iz7zh9BAraqAWLudgsYbfy379vzyn6IoZpbILa50Rjaq5T8dW7YcSQREYHbcV6rY+oDrY30Sp/Pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199024)(186009)(1800799009)(38070700005)(38100700002)(53546011)(7696005)(6506007)(71200400001)(86362001)(55016003)(122000001)(921005)(33656002)(52536014)(26005)(15650500001)(110136005)(478600001)(9686003)(8676002)(5660300002)(6636002)(8936002)(41300700001)(316002)(76116006)(66946007)(66476007)(83380400001)(2906002)(64756008)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aa4p4PYA/MalzoP5H4ks6wZPlUa2QXKLz2z4ARjkbYv+42TMups5YK+V6vRK?=
 =?us-ascii?Q?7ZeJinmZcK7zSKDQEKbs/5AoJAU8aBz2pUpJjapGe2uQM+oBcIfliMFgvp4z?=
 =?us-ascii?Q?tcGjFc9k3cnIbawl8IS62toVU+3Jm968T0MKy+3OZj4iFNq81YoEaHNh0oE8?=
 =?us-ascii?Q?ACgF5xzXE3QTvVV1T9wHZSTCoVErtPsj7XWn0rvt4jhjghn2r4Cr0Wm/p4NW?=
 =?us-ascii?Q?rLlwp8SE5sEFM7cvl6+htt9tggTiyIZAVjWk6hy36pKhHXETg2THihFRslo3?=
 =?us-ascii?Q?QJydRDh1INUiLVabrcE3UFQsdf8FlE66dY1o7k9MgP0zmSpZYqOUP2rfe/+7?=
 =?us-ascii?Q?bBsxTIGffsM78gfRgneEGAzfkOcuxO5NiBZdBP5DGcaSpfToO88bmNHxyI7+?=
 =?us-ascii?Q?KYLe3Ctb4E2OQtKcpW+lC1bCaCQXHH3iTMNp8rW1FcbRv4dlCcCcdiCMCRCA?=
 =?us-ascii?Q?ibkJxwU67x5MYorenVlYo4ijZKWeiCggTB2bktlrQg6m2Rl87rvkJhC/Nz2M?=
 =?us-ascii?Q?bY9qx+tf39JIe/YBmz0yzmYFKRIRDmzomlTZYIjY56gtDLgQpK7ttvN08WT4?=
 =?us-ascii?Q?DrR2zKTmmDhdH/TusFWKNa//VkZzr0/rqnnkQrcKKQzR5TTbHTmq5fb3laIS?=
 =?us-ascii?Q?3R7A6vLibSSW7XzB2zDodWtk/C8UDu95KQ9D3fgomjSAjNzJifIOyX01aVLE?=
 =?us-ascii?Q?rFLd0FYY/1LWW89TcONgCvkWYb82UsVnLRE/l2oJ5yd5AOpSSDmEkK7b54bG?=
 =?us-ascii?Q?tqgnIxtaDIEv2J8JsR5Kq4JrUzuC1HlI75zrt/xtI4mzzefnVILLxpYpFl4y?=
 =?us-ascii?Q?gMcqvj5bU7QTIrzwVc+Lys7B9hbtyIu8S0dVRGbyaqP46MpFUtiyjmN94sa4?=
 =?us-ascii?Q?gLpliKysusUnMt4EDXdkOQblcIJxcyG3QNibtbKDyzaI/J0fyaPPC1fkPKpx?=
 =?us-ascii?Q?wZK/FBa8SpkOj1IJci77fKggFHQoevRMJ2R732t9xLXmYi1y++kMmpJssXfv?=
 =?us-ascii?Q?EJgKjOHB3RPvtT79XHrphE2pVP+J9ZT6k8FGEOYDpU/JoxBI6s3aFFh2DO9N?=
 =?us-ascii?Q?dKHOmWHhQEG8jhXrF7cNoGiVYxP6nyDixNKV4MPU+7lq3VucM/f161acU202?=
 =?us-ascii?Q?lGHJmcIwt2uWY5v+VwQzSl4cy4ORvYRTTf6waoQZm/DufygKCrNcK6rrvfb9?=
 =?us-ascii?Q?ZT8SUdUtOltUIhcLYQYkWdchCDSnwZFN3g81iW+rdg3cwyVySqIgVkC+3Wrx?=
 =?us-ascii?Q?7o6E2F84sNZPRZTmnFKnRcyPKLIu9LoxURGRW1bDZwUc5CYWue88PUzlGMKa?=
 =?us-ascii?Q?u4ywSPNKMOWkLbTwM584pDuRlJcnl6WPW9FrI8ThwTw43UTcJpDoYYgfXcER?=
 =?us-ascii?Q?05WtoTruFrBjVuylGah8Qemoy8XR0LpIXwIkrdHR2k+1rubIxho4ARgejWN6?=
 =?us-ascii?Q?GgrDdcvRSmFw0ORJqFgu+spfBplkL1+YlKbtDlcbkgWEU+64A7CIaqI4c3O5?=
 =?us-ascii?Q?lvOujfH+QoE6a7ew11wTpNWt/MQ5PHxYSzVOCSM2XpHVcb9de/pgUg98s9nd?=
 =?us-ascii?Q?YaqrfRedgf/l+q92rsHZDT/iI8spx6l8lLZcLPsV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643b8fd6-f460-4655-cfbd-08dbb9b55f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 08:41:24.2176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tySHzPzJzeVm7pREJPpSIZ/TlwU/jFzUKkQ46vZrpeDRhPjdl4nS0nXe8jrKnT5h7g+GQCsialBvWz8l/mEjuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, September 20, 2023 16:37
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: change if condition for bad channel bitmap=
 update

The amdgpu_ras_eeprom_control.bad_channel_bitmap is u32 type, but the chann=
el index could be larger than 32. For the ASICs whose channel number is mor=
e than 32, the amdgpu_dpm_send_hbm_bad_channel_flag
interface is not supported, so we simply bypass channel bitmap update under=
 this condition.

v2: replace sizeof with BITS_PER_TYPE, we should check bit number instead o=
f byte number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8ced4be784e0..c60d2f79eeef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -616,7 +616,8 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom=
_control *control,
                __encode_table_record_to_buf(control, &record[i], pp);

                /* update bad channel bitmap */
-               if (!(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
+               if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_cha=
nnel_bitmap)) &&
+                   !(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
                        control->bad_channel_bitmap |=3D 1 << record[i].mem=
_channel;
                        con->update_channel_flag =3D true;
                }
@@ -969,7 +970,8 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_con=
trol *control,
                __decode_table_record_from_buf(control, &record[i], pp);

                /* update bad channel bitmap */
-               if (!(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
+               if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_cha=
nnel_bitmap)) &&
+                   !(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
                        control->bad_channel_bitmap |=3D 1 << record[i].mem=
_channel;
                        con->update_channel_flag =3D true;
                }
--
2.35.1

