Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DD2CD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 13:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AA61126F8;
	Wed,  3 Apr 2024 13:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ozd4JQTY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65071126FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 13:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhsUmIVc9sSSW9QbDf3IFjn6DaeV38KHOfCc6tr0Cua/JcZ/g3JtZvxl2BkSsePrB3nQSLJkd7QDNsPOztKniihPe5McVn8FSkzTqPjnDJTTJbOg1Rc75AANDBMQL70ZO9N2ZJ8OHucrKt0eZRSp/4TxlKVFzKG6r5OIR3yNk2FAezNcwpufHUWoMJXZmrslerWtCo48kL1m2AnVMD+M2BSHrN0TWXT76wX9M7nOIXahDjlg9sc4pk27/99dE45SER9MZJHJMifh62nYlbLXfQ47TbwRKI2dBnjNHFUbaxUc5OBOJ+Vx0u9dIrM6D7mG28FY7rcnUru/5PixWWdKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7lo0BqaM/nshO/JuusZGGDNL9U1Go0tvque41z5P/I=;
 b=iXKYRLwKQ4AipRIaIOAmKNwhFzGdYOFlGofxuYEByyhHLISeCXQ7xUvoz97/Oz8zgYDHI1KjwEuvEFvBh9iUoAZGT/PrQd/SH8Jy7oR88woeC0lI4ZcEDj0RY1FIU5WwHcybtxaaXg4l3hmLnQz7LxNzmzYDadXijSaWMf71Cj0TsRagmACCHr2GpMpXhShppaxf1hupGIDjGnr32ZCn8S5zbtnn4gFnnQc7TtFimOxELmc2L2YeNKKGKXp+TQKi99NLK5S4XPiVmEdN2j7x+lPd9cDgGnHNqW+lQYrhdg1GwmvkgY23sjDkWh+TdkcubWFPepI1Be4xrzO/5PAI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7lo0BqaM/nshO/JuusZGGDNL9U1Go0tvque41z5P/I=;
 b=Ozd4JQTYKzyw5ekya81Fe4DNL0akAwvjuQoSrEykdx7YVyIqGDEzzguEJ5mjh+oeNDiuVZOYT7P3HDxRKQKmrGK9MofjBD0QHeIoHh8CXNFAgT+WLGuiFHAw5+9fyxTNv6IYCYzJ04sOV6HMechW+Xcdz6sKZYf7R7YjkwkfuIE=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:48:37 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7409.038; Wed, 3 Apr 2024
 13:48:37 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect number of active RBs for gfx11
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect number of active RBs for gfx11
Thread-Index: AQHahbBvBdUQxM7m9kOmp+MBd7//prFWj1/g
Date: Wed, 3 Apr 2024 13:48:37 +0000
Message-ID: <CY5PR12MB63697ED469B13AC7FEF6DF69C13D2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240403101747.420602-1-tim.huang@amd.com>
In-Reply-To: <20240403101747.420602-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cb5f1350-cdbe-4ed2-812e-9de0bb76e7a7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-03T13:46:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DS7PR12MB5791:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4gA9uqzupRuVwmQDsqk1lNiXDHOxxVNVtSVOX1owgp9dj7SHDUcjbaS/OSANOW1Yh06UrQJquk09QhLojxVWtaz5LEVnk7WxWRNyakuBdc+8MAd/rlOODc8+OHc7C3fZjpWy53d1jYYAgKEwm8qsXG8YK/dsqPU4A5ZPIiJ3KghDUmWC7IGXBZhaZNJ/AF2StULAG1+HtJhBSfr2lhaPrQwhGyVIpDmpIg8rNxs/9HpGoCgbiWgllSsT76D9jn7FyiEJLeK+TAXvg7MhaC16DNfs29lcsK9gw6HnFHqQ/TgL0eSiCs1/mhcx5JsLh6ACPsBYnWft2yU06hrjZAPEnNBY9+Q8h/IM1RIRyAHPqrVM+vDAh7ppYB/kUJX57CGQiSncmrXYgH3iNwz+0c0PWOL4Rf8G2JazizEm9bM9SdNjCQTHELw3tNKhb6ITUFiOh6cECFBwiJL6/BgKP5tBz7lITCXAT4dKPQ2KTqVVbQne085YymcmmIp6E4XMOEb2aCtWn7wzIDdoEfSZ3+50u684XU6r4HFyfr0bOAr37EEdovuD+YXmD1QmX8CPpfkoFhBUg7AAbHrwfj7Dayk1LtrYEkF9uIq4nbZcwGvHRsCAJnnUmqT3BEiIKtbCsA8/ufVdxBbBpkZqODt/q655LzT9u50+vi028BNhJQ3reU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S9XoVfDZ9rZND8GN9A5pcM2a7Sf63m46Z7gmlReDt41P7XneMYdeJGmLgqyt?=
 =?us-ascii?Q?BaOfOy3ox7M9loZujEUbDo9D0ntEEVj1LR31ppRc1isfPRsviZLYiQIdzjwc?=
 =?us-ascii?Q?2SFir/stobeZEo1SW0EAzqKEVqmDgjfYVVe0PDCS8xi/tOn/RWfCGdXPgwe4?=
 =?us-ascii?Q?0HBVHa3lK+8lb533Qw79vgRySb97loHkowR7VV5OGtVIz3jHQyac3stcCOEP?=
 =?us-ascii?Q?J+xN10uG+/PzegSDKnKrqJCTGtNfsvVmKC+kDsBCHISog4gh0GRahteX3imD?=
 =?us-ascii?Q?bTDYQy9KWi3c6dFsjbPKNAP99mBLut0BmkE+LVHC0AcKf6VyRr1pcgiRGRci?=
 =?us-ascii?Q?CmZ7C/5cnKqRlvl/Xs1c/cv2b/yaM9xCBGV9PVa7cp98twwZzdg6GEu2oLY+?=
 =?us-ascii?Q?3l5XDvqt/YI/RiZSU5yUenqAI3157rYnATIKHZ1M9P354Mr1vQs1EYq0LZE4?=
 =?us-ascii?Q?O5gb2JxWSholL8zexbRq/5zB+uwaVpT2CrrsY1fsmmE0ADf68GbdsLHH6CQy?=
 =?us-ascii?Q?ORAcRDH6d1ZUhjzMy+snq15UapiwgwVjN10q7iYk20Jqd07M2Q44MdI4VqNc?=
 =?us-ascii?Q?q/V4Sb4dS8WMgQtxNP2IUjqrCDMAmsZFZrszGxk8qfeOlklUjnlKHYqiGOTU?=
 =?us-ascii?Q?WanSaEBh3Q9HcWCu36WclhvDeyNRcUAQ3fNuIcA8BbGVBti3VzxFgkPyED2H?=
 =?us-ascii?Q?wN1bobGybAVWSGFHPRc+qNoA5ek0NP+TU6rzAszDF5g2+jkNUQ5yPRMi0+AL?=
 =?us-ascii?Q?YImh291Nyp886zjYUYgzVt/gPQCjjGnVIg+W7iVsXEL0Yb6OuEIBzTqPm0/6?=
 =?us-ascii?Q?/vhpBTAJWUGHvg99noFHQQ5QvRc9ZbWqOF7P/ZhxtKZX5KXu8p084sni+8ny?=
 =?us-ascii?Q?/tfMdactV3r93HIiPRUlP0v0GUKFzcg0txc3T0yXt/2FIxKMEVDdy0o5O6ch?=
 =?us-ascii?Q?p77zyCwlQIeJI+uxr7FLOilRL7DeqptFhRD6N+GO/hUTUwkmXofxiWOSQrtz?=
 =?us-ascii?Q?rHhheeZHW5I5P+npYujX7COlatM8/1Aguu3uQiD28TgA8i1nVh68sFLFBY0O?=
 =?us-ascii?Q?Q4Hv1M1DA3Rppi/ubslMGxa9zqZU/5gPyx48bDDX5ZIx/jyPFDCHZbXlugt4?=
 =?us-ascii?Q?HrNxw26RXgyuHIO80LEUh01z+p5sAlLg+0bDqcnz2DkTYjTTR2dCqsp+AQqg?=
 =?us-ascii?Q?J0q8KOTYN9BeOnL+0dwbprfBbH1Fb4ba60wnyR+vI9v5wUnZZc1RqVEg6ai7?=
 =?us-ascii?Q?P7wBLkPGysge4M0ozn3ZrojkTrbOqp9tHhcMABCP0SlA/ypHfx4wM+xXi/10?=
 =?us-ascii?Q?2aeZC8+Du0C1EU6dkuYAT2VLQYC7KMLqJThY5NI3YU9q0DWbFVj1ImgPBuvv?=
 =?us-ascii?Q?2zH9y53E6vpPCS2qTX7X4Gf2aLltnZv4y4IzUTaVMvaStKrMERYUsb0HBad3?=
 =?us-ascii?Q?dM3BILa8aWF24R57XUjHNFDCcrdpm/dr2rmyMSbhsLf2d7puIbTAl205atx7?=
 =?us-ascii?Q?mUBhkoR32hjI5SjpZYXnUlZ50Ua3HBC6tbL4atiy2v1pTv12KeiH6uAAA7MV?=
 =?us-ascii?Q?zydsVVyDE0t4uypvwUk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0e68de-8da3-4cdb-be57-08dc53e4c370
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 13:48:37.6340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78NPQQhThl7Eh4uONmi1hJF/YwdY7QrWuMoTXfPdbK3jXe+Y0+fXIwoVCesnOt8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
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

Nice catch.

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Wednesday, April 3, 2024 6:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Huang, Tim <Tim.Huang=
@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect number of active RBs for gfx11

From: Tim Huang <Tim.Huang@amd.com>

The RB bitmap should be global active RB bitmap & active RB bitmap based on=
 active SA.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 7a906318e451..07cdeef9d44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1635,7 +1635,7 @@ static void gfx_v11_0_setup_rb(struct amdgpu_device *=
adev)
                        active_rb_bitmap |=3D (0x3 << (i * rb_bitmap_width_=
per_sa));
        }

-       active_rb_bitmap |=3D global_active_rb_bitmap;
+       active_rb_bitmap &=3D global_active_rb_bitmap;
        adev->gfx.config.backend_enable_mask =3D active_rb_bitmap;
        adev->gfx.config.num_rbs =3D hweight32(active_rb_bitmap);  }
--
2.39.2

