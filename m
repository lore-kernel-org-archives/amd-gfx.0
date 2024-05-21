Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F87FC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 06:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A8710E45F;
	Tue, 21 May 2024 06:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K8af1TO0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C7810E45F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 06:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebo1NWUmg3niHb/dOvbI3dbAir7Xtif4eS3uQtpO8j5uE9fnzjxlhRBUgTIWmCdN5LoxZ6YYXH13Mh9Pej7570qhdzbiuIzh+x0rFOG1WEYROy8QWV5B82GAGT+WvyHZOaXGiUrGEFTy2O9Nt5q+OAkfmDRHc3qoLEaoMRZurcNlgo0FdpNYJ3oxXH4lxC5V7sFxBwBFK9p2wuNAusRk7/EHkNSjdFVESCNAQiVdNYkhe5sY/6AB/lR9glstTYf77CenTIE/O1hHUT3JsyQDWqC2gbgkO9YzXMYW/zaxfiPYXwDrRm128bOcimUSTI9Vh8piocF+K78ZNWHZExzhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg8ct7vH9Q8myehNCwrGD7/7p/1P19agSGm9hfbj1v0=;
 b=eKXPrVj34/r1jrXYCXjZEOA4ATbGvQ5fvdnC7aZxanafsPNlbCRVG3lrG47ZAYKjCijrNx8oTUB00Zc92mTAFRldZaSFrrX6JZqFkuUsUUdH8Gz+/XzVtvanHJI+IlZ2HO4czwKE7KS4723W7gqHX5PGd3Ik2q9k6+Qe3y5T/p+HiPexXD/dz9/DUwwIwzQQOQIksxRNEs9EH4UPrWEaA20labk4LGaCUT/T+0mJU/sMd7XvICn7TqMu2RHNvbkDmtEsERFiKNluUCFyt1HZ2H92JjhxO5wBShCj2g6DoUV44f6b4Xz0dd2tPK6s7cSwHh+LLg47e7WS4nKD6lf+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg8ct7vH9Q8myehNCwrGD7/7p/1P19agSGm9hfbj1v0=;
 b=K8af1TO0IG1UeGWyUT5ccxiRaOzwPH5DSDCtTGv3MEIFCK15UTv/FdM7O7AWH2V7coY+EsFLX6paZ/cbFRtCCcGTyqI0Oxmh6TcAeYqPdgvB5uJIsSeHvBpiLDPc834GJ6a3pVjVuxksdIYHPm9VZPvlurFwvmwt0q/H9iIHLYk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 06:01:41 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 06:01:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer
Thread-Topic: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer
Thread-Index: AQHaqy19ew0aLDQWWEay/fK9dbeTArGhMkOQ
Date: Tue, 21 May 2024 06:01:40 +0000
Message-ID: <PH7PR12MB5997D58BF63AD3C81D31488682EA2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240521031724.2612-1-tao.zhou1@amd.com>
In-Reply-To: <20240521031724.2612-1-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=27b9abe7-d26d-4659-a0b5-729d99a45574;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T06:01:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB5914:EE_
x-ms-office365-filtering-correlation-id: 125bc160-26f8-46f5-0b3f-08dc795b7bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?rZZwTeCYuGVr016wCVAfqUPX8qt4RaLZH2dC43VCBADIeF9F6RZNGXYI+TCI?=
 =?us-ascii?Q?M39KjDOUMrJlysdGSj04dZZxAoH0uv1+9i78Zr4qwwneuK6WseTg8SM8kiHT?=
 =?us-ascii?Q?2rN72qygkmnZvE7TjovUlYM9eeHAsl2Pfhoh50gjql+rbSNaNCHiXguH54nS?=
 =?us-ascii?Q?DG3lRl6EAeFuOlKlDRzjRrK+eDuxijN7y6SapJMF3sV1oGUM7BJUkuJ/Rvgy?=
 =?us-ascii?Q?7wU3S1YcJwrCDkho6vRywzcpP5FM1Oy3+ucvE1tT9/pLi8R/AMvhlzGFEALe?=
 =?us-ascii?Q?snjnwNMADIV2vbHuC5q5aBY3oXb4+g58KIiUrdP/g/Av6lLvy3h6LPDxOVX/?=
 =?us-ascii?Q?EJNI16J8EIducybqNG7GORW5AirffbSFv+nuqAsCLP3t+t/PCPQWa1YWhKCJ?=
 =?us-ascii?Q?OhDVxcugDvDmtDpGSBFgFuRo4MELmewSJ1k0MEc7y2ujgSEV5qujihCun7PP?=
 =?us-ascii?Q?P6kDQW2o0tyYSHBU7YFakwfe6oL2zG8NR59RpnCvbTDqzYl0RR14VjQ99A0/?=
 =?us-ascii?Q?o1rhbciaz51YmBX7v5L3i4bs+TTkNfids9ZFWb548sd5xBIF/Cxt0PJ3eiCX?=
 =?us-ascii?Q?c1YgDEuL2KjlrlGpiVc7x2TRatkOrv0QyUBgfcI+9lCE32fQP0YmRt+9dnjL?=
 =?us-ascii?Q?wJw+TUcSUqEVZcAUVARSNMfc+HeOgPYHPM9jQEF+kF4IYyiMBuuZVW14OXcl?=
 =?us-ascii?Q?XGxf+pXSD5swDEe6TrjGDgTwrlq444h3QNYYZIhs7WScCfE7fOZH1jF0vgL9?=
 =?us-ascii?Q?A8VbgL9ixeu7sYhmxrAP8jfo+88+CLiJ9AgsbTTTxqObQVOG4C+wKLg6IPhM?=
 =?us-ascii?Q?EOgxyZ+tYRSkeKzMzK+DlHj0wN1p3kpgqVRWWQIksOv9wwwHXxLIm/9Iqxz+?=
 =?us-ascii?Q?W1I7u37hpzCZmDNQ/OBVxxACLLoVpEwuk90VWFYQPHJo+ncIRaeFlMPIBY2k?=
 =?us-ascii?Q?eWip6gbhaBNAbbQLzfBJ4dNqp7QniZsv2zRJ9FqeLm54/HPsPuv3rAQWSpPt?=
 =?us-ascii?Q?cFY/AbOvmD3PWA7RV3tKLROY8otO4hz42N8acC3+SWbnH3VbvKwtwZ13+QTw?=
 =?us-ascii?Q?WSotgL5jnVY4QzWtl0+o/FGaNAASKEhvIKOEBIOCg8s5LEmgUgUBxsULuyfi?=
 =?us-ascii?Q?w1ZanmUoukFiFO0lPBWZAghla/dQMreu8U9gDKPkFGrMDtFXNdYIlwitWkmK?=
 =?us-ascii?Q?G5VFsCdN5vyDZvwAoAgCxqozgqMhSLuDd+ic4dKXJOE8kFKc+LbNteKNVvCR?=
 =?us-ascii?Q?xrsUcgl5akacq1mW0Ec9MmAkzqwFp+zwr9OtvTf1WT0w8jCZ6kydTMFtM7pV?=
 =?us-ascii?Q?pGvON0Xnys456hbWQNEvwVVj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Ym4emFD4xvnNrfO/3eAjmmZMPSOjAxh7q47niVakAslSSbAo0FI4MsjeBx9?=
 =?us-ascii?Q?IL/5JCVNl3Vrmzl6WBJ4v64JduFbnxJebG05CPqpAgBrxcKCc+92vkQaUImv?=
 =?us-ascii?Q?xAh2cwxHxmatMobtJolDkl1NEiFdTo2sbshXYeu3bFkv21ze3/+GFfLX8LHv?=
 =?us-ascii?Q?zrVDanlHgVUfURBMQ7eDn05/LR/Wz1+w1GNVwrndyvFLklF5mJ7BU8U4AT4b?=
 =?us-ascii?Q?Rg0pCso8Z656KrZuF5LJG4+Kpa0Ns3jVKhS0+e5rWL8B6oxC665O+/h6o9FT?=
 =?us-ascii?Q?L9IXJ7kxnSU0RVOfj1UZSROTmY1Y1XEkjVYDnyIe0aOg4lvAB1i/Dq0GgdZb?=
 =?us-ascii?Q?5x/Dwf0B3TDPXKhWj3dMyirrDERqiXFSBo7OJnS/FeqLSVm/0C04rzt5t6a5?=
 =?us-ascii?Q?V3aPrc4mijYHAZZHjHytr8KRqVcJ/n8kE+wC9aZLKsFKpfWURaBbTF7ZNjK3?=
 =?us-ascii?Q?/YgwZ3uoD60oCgTXZVfXjEh89oTCHcO1Hov7r1Tj8Tsf10Wz2wzPPduXBO7C?=
 =?us-ascii?Q?cMSYHNpGmRsGreltJ4U2aBOTNYOZglY1S67WQAo57lrZJG6xK5gz+NPdHi/P?=
 =?us-ascii?Q?N+VFVo83jffot7ReH0DmtA4qWLCkU9f4EILdMdIk4whk+vgXmWZM6JU2W1Yj?=
 =?us-ascii?Q?FquNBsFQErksa5H6NHVWR6US3lenR0hQSTwj+YHH5t4b85O9pk284ADx/Qlv?=
 =?us-ascii?Q?6fwxbLsVa0CzVoFnm5qveFQfIN7xzlmEg8IfuvWuXCEZpVzh6+g31fnZ+0i1?=
 =?us-ascii?Q?9KXNcPXsR+rL62OfVfud8pHR7OenoAZy6HmNZpL0oFbwkAoqql+LKbpf7KYe?=
 =?us-ascii?Q?0Vf2sVPQz9AYcFin7nCJwnRi7wlzdYU4scx3yPLMLt3RZ8zqbrZ15IqipCOh?=
 =?us-ascii?Q?QBYrIWKQoQfceLxv2yE1t2shkL2x6x7ghab+xDy2cxq7lbs7mX09bDQ1ZdO5?=
 =?us-ascii?Q?Z8neeq0L3+tqoyGN70RxyRCcxOFAfkS74e3g1dX9Uks7P2G2AA7JJllJUVG/?=
 =?us-ascii?Q?LZqftzUIHM3hQNP9pKve66NCo445Y1NGhko3MrBx2m07Ll3ztKTgrx+HeH2H?=
 =?us-ascii?Q?HZtZvPahJpA9b/Q+idrJyIN/boSSf6A0Y25/pFxtwebnYJr4I25/NPsBQI95?=
 =?us-ascii?Q?WNeEbplbjXCUtMqWqnw0BkuWDb8pzPzC9Ot3RTtxqwTBbyk306j7+VOfMvF+?=
 =?us-ascii?Q?hIHkxQxbXqyTaH3VKv54y7privr8IuWI4TQjs5VmbxovR5iu6HniaVR+RZET?=
 =?us-ascii?Q?noIayiKFwKBBN9OsrMb16Q0fgppDw3Z8K/d8Y47HV9BC6x6SPvrmeyuO0iMT?=
 =?us-ascii?Q?0xmh+o3xGq4MKIPAYhfMqXGRDMD8sEeWgL2nDB/TVefegeKQIB8a8wwUuTl2?=
 =?us-ascii?Q?NaNbEvh5mQNc85D4zPdL5Ckhx8K6hb0eumPaZxZPIYjFaNiMIe6gRc5FFbe1?=
 =?us-ascii?Q?ZnHClWUNGc8iu3eRA5C9Dau+xwfcn+v1Rc+gGihB8cXlSV25CXVVJKqVLLCv?=
 =?us-ascii?Q?KF1BJgHA49qFn66EcVbOIWRZODq8qrs8AUKPegG46SqiESrElNTX8mjD8qOx?=
 =?us-ascii?Q?0AIeeUyxv1XUco3jWu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125bc160-26f8-46f5-0b3f-08dc795b7bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 06:01:40.8027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjK9DpjIgkuPdK6ctwIPMJMtoZt3rNIMdiTd5IYVvsR9atLIkZz9RG4fdzXuS/rA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, May 21, 2024 11:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer

And also make sure the the value of msg[1].len should be in the range of u1=
6.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.c
index 09a34c7258e2..35fee3e8cde2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -90,7 +90,7 @@
 #define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 0xF))

 static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_a=
ddr,
-                               u8 *eeprom_buf, u16 buf_size, bool read)
+                               u8 *eeprom_buf, u32 buf_size, bool read)
 {
        u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
        struct i2c_msg msgs[] =3D {
@@ -133,15 +133,15 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i=
2c_adap, u32 eeprom_addr,
                         * cycle begins. This is implied for the
                         * "i2c_transfer()" abstraction.
                         */
-                       len =3D min(EEPROM_PAGE_SIZE - (eeprom_addr &
-                                                     EEPROM_PAGE_MASK),
-                                 (u32)buf_size);
+                       len =3D min(EEPROM_PAGE_SIZE - (eeprom_addr & EEPRO=
M_PAGE_MASK),
+                                       buf_size);
                } else {
                        /* Reading from the EEPROM has no limitation
                         * on the number of bytes read from the EEPROM
                         * device--they are simply sequenced out.
+                        * Keep in mind that i2c_msg.len is u16 type.
                         */
-                       len =3D buf_size;
+                       len =3D min(U16_MAX, buf_size);
                }
                msgs[1].len =3D len;
                msgs[1].buf =3D eeprom_buf;
--
2.34.1

