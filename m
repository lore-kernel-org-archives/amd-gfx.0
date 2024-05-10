Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7ACC25B5F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 03:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7AC10E10D;
	Fri, 10 May 2024 03:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s56lXqSw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B53310E10D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 03:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWWiI4GmYJJuiQGaRu4hTmUwTvwJQIqSZW6KvJCWyo32OO1vz7R9hbwFg9/kK+dDHdIVJ80oXZAqd1JYtXkp11hsPq/m0sv1DqnkLIfdT1pfwufSwOEJ33ejXfTGDx5QAGK51owayB6iDZSMuxJKPpkkiFpw9ZV/3kbXy2AhsY8JhrOZZkmI15eOTKgmxJXm3T1xzkkYKIOpuR/nj2Ebb1YxfU5tB94wzPdRc6HB0YcJoD0e3DnpPRRfQVTKUYvrH5iEO7MO621ZLElQwaWPmIaXOoNjNlK7x/IU1F2b+i26gOnmg1dhqeO9VABUjtx6T7GAVNmJm6MLRo6yERSUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noF1LO3ap1I+qwizlSBTY43YM2px1Yjaal2l+Fh0HNY=;
 b=J1Mgpo7Qxrjfez4tiNzs9DCScYdcSQuSRAVu1p/ibzzKTpw1Xpuj3Kxnmq/JsADRhGIbPn52C+0P2IGVdPWll3LM6D3WbhnpLfGD7xkQpq8uk8e+nK6V4MemQJrmzw3M4+fXZzLrkM6kjAlp+0zcMBgMlDdrDYF/YTfeJfvivnV5O2+YSg6TWeWcBkRC1lnnGVr65XterL8IQudvDCXp52caWq8W+WzxXOnepasxr8yb+If4b5nNSyo1QCCbMU7XoExeFrN+r9cpyEdaS0g4PhqyaNRHHs5JMx/AR+s3JVoGTPH1idN/gm/+zp5WaFW49d4nUJtWX8M7GXIUU4bwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noF1LO3ap1I+qwizlSBTY43YM2px1Yjaal2l+Fh0HNY=;
 b=s56lXqSwXzuaJmMYHrH89xLUoojhqBk3Bp7Si3nrjIL/WOlrIhqfckKMWVI44ILTNenH6C757egFwUScefXyp40gyVPan8UwLV4yMMGPzpT355JaxWGBV5w+VHCaKKH5zweJEgvAuoQMEueM8uxL0I9e8LtGEnOZhS68FXJN5ns=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 03:26:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:26:30 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Thread-Topic: [PATCH 09/22] drm/amd/pm: check specific index for smu13
Thread-Index: AQHaooUzp6snY8Jh40iHY+Y/KpcA67GPzpkA
Date: Fri, 10 May 2024 03:26:30 +0000
Message-ID: <PH7PR12MB599791FC58FBAE3FA959DA4482E72@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-9-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-9-jesse.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b050e490-1c7a-4745-8be3-fedb07106f7c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T03:26:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB7805:EE_
x-ms-office365-filtering-correlation-id: a7856566-f423-43ae-844f-08dc70a0fbf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?B9Ck7amO5ID8Bs8ZmwBL9w/XOjzUqeZhWlGFcGkXnXhKEpX2e3yxoJfuFb2Q?=
 =?us-ascii?Q?dk1KvLKNCRpMmDg28g9wuIxDpZAd2GMfgZB8nEWDE3Zf5QAmWCL/TdzpbYls?=
 =?us-ascii?Q?Vs3E5OZ6LKuR7raIQjxAcI4xm7hdfYLXgjGzmgkvZmMZ15RcLJAIk1159RI7?=
 =?us-ascii?Q?mx5f525mg4h0GxV9mFIwJPUtNmWUeK9K0WIRdZ3HYy64hkcX5mTlhQ+2pwC5?=
 =?us-ascii?Q?63WJqdwF9QAQkioEYUmTGD8ZxfZUQFvcxVxRacfuWz2iLrC9w/xkjUrl7qwt?=
 =?us-ascii?Q?dTXoBx2lChgcB/fSbaovIY//ALsALxYfk98ynbIEl2/bZeViUaF4JjU31Aw8?=
 =?us-ascii?Q?wjKyZedFniYWPbE8HqvGTkpTVQfkmUj7OPcUxmrYrtxo5W1LTa8Ob0FatYUO?=
 =?us-ascii?Q?1nVCJ9pgny1opLkv/SO9Ax9yFS1gK2sO+Ed/MWVFKVb1mR8VOQD2/sIaHnPO?=
 =?us-ascii?Q?fxHjIiei1gw1hiZ4D0HRjuVaeOp5hQGsVW/ib04KXo0+9G1UYkxOY5WPwC0Z?=
 =?us-ascii?Q?0/U/72ha+WjBhZGzS+/ErBs+PUWeaUjsIgb8OfNmiZ9IffxB3yz7nTBP/dHJ?=
 =?us-ascii?Q?5JsNpJqoMO0fm69RR1W8KASb3upsl8/ma05mU9DWhgetolovRa+ZoV1z/KeN?=
 =?us-ascii?Q?x9mWU6uetE4X7ZrQ+DmKK7+MFyuRLVxKQ3dttF4D6fygB+8LOFhQS3GCaZeZ?=
 =?us-ascii?Q?/pfVcRLVoTp/m+eonnjJM8wxZ43I/Rc+n1ZQKv0RHb8fbkkwDpk22XjXwMUB?=
 =?us-ascii?Q?t3qp1G1uoD4yDB9V3iTEuqtNYYqQRqUNsRBvwP7R9evQR8zpjd5B6Sh+fKMw?=
 =?us-ascii?Q?SqDX+yXCRY3DEituQNshO9PTsDm97/6oaP+UMBCx6OmXq6la/8WrvPSWFFAv?=
 =?us-ascii?Q?Winyr3nupVwfjs8to0T12y17O3b3rUSxWdvggcVqw99SeG2D8xT/uPdyozl8?=
 =?us-ascii?Q?kAbr5zx4nYMsR0/wo+bK5XbB020BSNVvYcpFlyxTkUVcriL8fZrjlb1lE9kG?=
 =?us-ascii?Q?iGCY95SjYlGdgVI2sg9HNr0lnRvfD3PGsuVwMKZfs2UxM30ZtFw7rn6Qd5VH?=
 =?us-ascii?Q?5Qy6C4myyL7iPCv9hs6HxJ+FfBSCAgkT4s08c8FZK5EXF+q/L3PPuYjNnkOH?=
 =?us-ascii?Q?nd5jREHCZaPtwKz7i1hw8JTqbZ0Ut1sABDBUi1Mp2RjM22oM91w4aUG+wU+w?=
 =?us-ascii?Q?yyG2IuNBDbYdqjyX5AE76udwBZyEP5ss0VlTPOgVtm8DuuxQ17OnH0RzbdiW?=
 =?us-ascii?Q?sdES405mko9YovxhpIosWo1eKyMlLTYK1svwuZpBALTLKsI3UdARVLe2P7hB?=
 =?us-ascii?Q?EKLVVSCWycz9Cf2Gqspv1Che0MN4aq3uM9CQvpASDkx/tw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ko0SPiCsWSaVt4Qm+53d2EKWqS067xwTOWU0Qmh9Tx+F8sGcEINaPTLbayrf?=
 =?us-ascii?Q?ogr8cWGiAvN7JqLglv1SE4RxqXywaEDpcp9T0U4B9Spx7Y/cpvBrRsPSg8XW?=
 =?us-ascii?Q?bBedL+USdqrkJxynxpSlkyrW2WHagPEBHZTfivCuV8epmbPYer//KfoV7l3A?=
 =?us-ascii?Q?91COfc5JtiVeh5XY+9gl1uDO3pj1aLrUxwVDbF57pEKI0czAJDaV5Mi8dQmB?=
 =?us-ascii?Q?BpzgtEL3fy22lK3IB1xjd5IAHx3c2AgZfK19xGgv4v/RDxJlncoS6Z3elTP/?=
 =?us-ascii?Q?pwofhzCeKsfsVPf4R+Jo6RomhGqm2DX7bpIZp31R+EFujY0y/AjhmJQ1IDHj?=
 =?us-ascii?Q?1EsiCXBLjZFl6phMVj0CFP33a45wKCKNMDN9VO5IO4RcjyVoQM9RQSLmemJi?=
 =?us-ascii?Q?Ly7PI94cD/zdkl8aOCFjKj++pv7wVABHFkO4KtSiOx8boLfFTkdXz1e8kLls?=
 =?us-ascii?Q?K0vRbC9zZHN22+TEqz7e/HLKGmcGPdTPwIf+gOVrrr7bHMMaQ+xosc59CeBw?=
 =?us-ascii?Q?PFWQSM19d217jzbdPCIfJ6alEdX+nu+41puJft9Ici1pke1bBxjqHnitWp4n?=
 =?us-ascii?Q?UDQ/o31XnGthBDF6GOu47i1Pn37GcCqEQoVLUsF3WJ611XhjkmehKP7Dt5D9?=
 =?us-ascii?Q?yY3bR8Us8/cJLH1luxQkR759m9E5fgHgMc0cPWWb8inAvjch9Csz13uBG3JD?=
 =?us-ascii?Q?m8Iu9jUgiqg/NT2kYI9oZzVSr00QWYTX+6RxR9ap4AnbR1w2BfQj57JBIS+2?=
 =?us-ascii?Q?bvo4c9ujISTPiyBVazcCBllVFC/6aSeHYaugxF7X3o9ztVDTMtv0dGjakEof?=
 =?us-ascii?Q?rg6tP1U5jxRb448NqO9xbyLId9mNCXshbD37VKWT0UHWsZ4k1upxW6oWjPHe?=
 =?us-ascii?Q?Yw53y3+OkvKbLNcx+LXHbOP4B7gconwWRIwYaseC+eqJ2XaBMrlz6Fr916FQ?=
 =?us-ascii?Q?BUQZwJ7kEAvPIioDR+tdPn8woJ1vy6cNj/ijDKRVXEd83SK/FwxG5vnRdvsV?=
 =?us-ascii?Q?1NypUufZ1WIxuIsDaVTZylIrODt5GMfIlFUd2UIKZwMcGYwcoxNSghOsdCFs?=
 =?us-ascii?Q?+0oLAZRKEEeFXqZMHivc543iQEM0QTKbRakEgALlHQ5BZh+fvx6bwPyifKRb?=
 =?us-ascii?Q?zx/XCMEzscNt/gaCcF3QS1S15xYwNgc1fKujeGd2YOh3F1VOjnHACyQaH2KD?=
 =?us-ascii?Q?baehi3TGmxapiNKjQLpthOIaah9PpxbUrjipO/uXwkmRpzzko3jbKYxZu+93?=
 =?us-ascii?Q?iDTS6NF+PyoJksLVP41i00OvmvHmLQpPVCOn2tRNDFlXLQLSEbhqA6p7IsQ1?=
 =?us-ascii?Q?B1HIRtQLe6Cop1fUNbjHep2N6q+QTSvEvw2U8zJny84EK55z9TjZ7ihFO3Vp?=
 =?us-ascii?Q?iUC0d9RIZzwepH8FDTmz9MbVSYbNoEVkOARD1J0m2O/flggIdbajlo7JtcXK?=
 =?us-ascii?Q?5QFEoa+g8vQw8LnQZleo12yGLM60FVesBw+/PcGO3zlpERMZ13h4SXon1qlx?=
 =?us-ascii?Q?Tcf2NAbhNu1VvDBzT87aNsS30t6DPLO8Mc4fOEixEjklVV5uZFx13ZuTp/9q?=
 =?us-ascii?Q?IX8fhSQZipfGyeZ0Hlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7856566-f423-43ae-844f-08dc70a0fbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:26:30.3514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/CM9APfMzQmW6G7XAa2SmBFUMthNB7ShFOeJCmLSneGKn5NHQM43Nk1IKd4m2Td
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 09/22] drm/amd/pm: check specific index for smu13

Check for specific indexes that may be invalid values.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 051092f1b1b4..7c343dd12a7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context=
 *smu)

        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                               SMU_MSG_GfxDeviceDriverReset=
);
+       if (index < 0)
+               ret =3D -EINVAL;

        mutex_lock(&smu->message_lock);

--
2.25.1

