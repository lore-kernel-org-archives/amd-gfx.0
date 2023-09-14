Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45C9EEAA41
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 13:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B91E10E11F;
	Thu, 14 Sep 2023 13:43:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AED10E11F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dabwrCWCsIGclCExrlDaies5eSpm0le25lpZgCUCsuXpGMmlFjIHz1FIAf2bqkk54pqhHNXn1JPvX+lI49fii7FXkUXLjEgETDZ5kLs9dhU6twyoBafAkJDo2LeMOn+SRMswZUUaLQEZadDUHizHCPSk9Cy1x8sxmIbEXWQffvWdtv4S9BvIXF+Fm0yxUxA0Mg8NBNdI0DTf94+lUAFJQPNIk1s6+jGQ/5FfXWQAX92RqaWy3S92nUMVWN94Gm6magsnAv5NzTKCMeRD6MqXugNLO30jhMM0Uk88hSieHMJNu5ynLAcui1Gx+S6cGay8dp+7z/j9YshKMJqX2EdxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+uBmKo2FqB+gb6/W1zho3KaexZ/OI/mg7AxHD4pSs8=;
 b=UaL7QicDB/EQvQnJ6u9jLXfba26GmCJART9EEJaCnDu0Zct6cGIroBfeO8ACA4+XlVDlYltlOTnc87taUBP+6skn1DqZNiDwiRNOIHGq+7/fcdy/WF4tL/WqkIgpQES4hnJ+nhGAzx5xKEif8jNijbjx6eTjduVq9YsfYMKekTjWRMe/WtpAWYgj9Mq9m8WWjk1iJ0Bv2Labrj1HBrX6P19r08zm5Fot9+QHef3KpmfVwdKjj2RPPRWlEU0g4geMe6E4KRgcGmiX+zKY2vZ3QxJTn/P/OnNYw0vH56z8aqwBVnrT5lzb1GmiZHjX7+yBBPJ1F9eL776k7vWTHQXXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+uBmKo2FqB+gb6/W1zho3KaexZ/OI/mg7AxHD4pSs8=;
 b=rPo087+9aKzrYYZqixvi8zZQ9bgHIdpw1/iE9Tm/3tzDgZb9H/PF8wiDtJJp7L3sGCbk4JQIqvZ6nu/Gp8gaWVtOwHZH1W7wJAAJRWVtte5O0K1MpjPQSdabFp15ufjuPeLAA4CBpdmv8cf2p0SIcsDVH+GNQtB+9MlgHqVkWaI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 13:43:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 13:43:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Remove SMUv13.0.6 unsupported feature
Thread-Topic: [PATCH] drm/amd/pm: Remove SMUv13.0.6 unsupported feature
Thread-Index: AQHZ5ww5/zKdebWAgUmmCXEbh+2WNbAaVJ+Q
Date: Thu, 14 Sep 2023 13:43:26 +0000
Message-ID: <PH7PR12MB5997B0286F4AEE1EEE7F869182F7A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230914130541.1235831-1-lijo.lazar@amd.com>
In-Reply-To: <20230914130541.1235831-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33bc8ddd-6a14-4b32-a75f-0b8fcff8b892;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-14T13:42:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB5709:EE_
x-ms-office365-filtering-correlation-id: 86f23fc1-daa7-4a2a-b964-08dbb528925d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rC84/KK2zzk7o7JC/4S/1fQ4hczqmMtBKkwitxVyWixrRBTZxBIldIPjZ61UBgeJ8yYRQq15pWUq2cEFqk1X5uiMHCmuT4WmkB4MjYaJ5272EdrfZLUcWBSoWPrbtQz9do9RohQo7LQrdN1ykjnG8zEKMwTimfLw50UeztUEiCEJr/TbnKekbLBd2iDJyeieryNhxWTbgzfWsh3fw7dmWNOPgr6QtxDY/XeTWg/3dhWjogqxA9IfmiWJYMaZzHnyVfBIFG8JXLrkqriMcOf/DUUiBUEzVEQe/MApVoKuRAsn0fDhHdO4AbNS7gbbvfdnpWz0FUZrMMeN/HiYAzJ78AJQx9XaEMQBJrMx0/8NryEfb76GCP4Z2kPiWMlkoKVxE2inecMU6V0WiM1vNhOowG2MC7+0ghQAEE/3d2P3uWWQ+ZebR3UXoBHbrFJIPyer5PdhXWIq3XQudIw/k/D4su+drBGvSWhzX+yBEpQgfetnx3ZzqFVyzDLeO0AKVHNUnna0OK9eoci26zJNee6jZv5UCBWrlQN7Y6zja1yl3z3Ho/gQ/Ttulm8HAgZysZq6K62gMQRjLA+SURgL//9YOUHZUWwSs0fnGNUoFr6Hzis=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(4326008)(8676002)(7696005)(110136005)(478600001)(76116006)(66556008)(64756008)(55016003)(122000001)(54906003)(53546011)(71200400001)(41300700001)(66476007)(316002)(8936002)(66446008)(9686003)(6506007)(5660300002)(26005)(83380400001)(52536014)(66946007)(2906002)(86362001)(38070700005)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SqY4D8bApG3MNI79TY84MyckQ1wgrR3DxALnKfAOunyAzNBUhD2eOYH1Vlbx?=
 =?us-ascii?Q?zoel43FxNj0WaJSbJYJPx8h9PtDbmoyb5HWiqcOC+cJV6azwHWbXMIAd3rto?=
 =?us-ascii?Q?sbUL2fyJlxxTsbc0KNECkL6Ppp7IChMEqsmLcWxIX5qF2fnirviZ7NcqJrhs?=
 =?us-ascii?Q?hsCxy8rtYIDXbfsxeIJOwwMh7Wav/i0QzxPtI6h3kfi0ZPmU/NILRVbXp+2E?=
 =?us-ascii?Q?1LCvZXxIRi+LP32Z6NUOpm38EomMs4WD81EzOVqXxkvMJF4buA4B3ZgSOfCZ?=
 =?us-ascii?Q?6v0D/Nt4dD9CxRPCJrKut1SpjQ2fB+W+/bRdRdTo4UExH1uet+DnksQUTbVj?=
 =?us-ascii?Q?5mk7EeZzhPA1uPnfglnAnFjDjlvhzN/IVkN8DKG7Lld9UTBPEbGcBWE9Gnmp?=
 =?us-ascii?Q?HlmGO3yIwkrRBBSj6j0KC7DpVN1i+naosARdMsXVakhHsLUaigZ+4GPsTHXS?=
 =?us-ascii?Q?I9g7yDoNBJi1eBKuKl02o/17rjm4lYH92x2PbvvyfTcVNcU8HnrhC0JQpB10?=
 =?us-ascii?Q?9i4Rpz+gAW8XtWKXFwusXm5c5OfInIiMD+PwrBSVD9Pz1/YwavPfsh+Qrp5v?=
 =?us-ascii?Q?ZjB2kKIY59FZRPRAIHm4rco4O7qjSgaXiZY5UXFL0+T7mpjjH24KBdUZ8vLA?=
 =?us-ascii?Q?EzLgMSdyAqFkwX8L6zOagETzEMTKxZlsIm1J+4gI/1FyVZ692Vwo+I2bDyqI?=
 =?us-ascii?Q?vtupEsRcgSa67lafCf3gPoDhaAoVBMRRfHkzYKrzqFCekw+H6as37cOiVQBL?=
 =?us-ascii?Q?RQ1t1MjVazDISZMtc65BBBZIbb8xFz8EKPNYhSjrFn7BWxKRwnzzUEnQS10m?=
 =?us-ascii?Q?9UkMOyjzNTm9xf88+yiXSXLXOiERCYpHV3lUCMRBviQsFdoZipFs5OdMS0kD?=
 =?us-ascii?Q?p8dPu9dAD264MRIyd5icFaRzSJjXJirxVsSy8iapGHkOAT+/XyxIJBrgFmRp?=
 =?us-ascii?Q?lIon5SE+GgHHU4vQRONOKVoB8KqsblFtO+WWP2zDp+MtOUljlEwuKRw10WoI?=
 =?us-ascii?Q?UocTSgbpUFlyk0g8zC+M+w8z1ixX2ZEmZ7N0uxjN3olxefgguw6eVNsTekQm?=
 =?us-ascii?Q?M3F5wE2iU1ZtWjniKHhW5q3C3NFqruSXLvTY3hFje8pOviRaqPqh07ZtRRKr?=
 =?us-ascii?Q?R55kFslsCzBw7fioGaPAdgBRiPrKjvE8KsmhdV3wGOeviBS9Rg5PiHtcCFeK?=
 =?us-ascii?Q?gyM1NxpQsh/gwPlr9jbe7c+4OkSx7Ni3gU6+xazXZ67dPsoJY3JXLyyCC0PP?=
 =?us-ascii?Q?l4LmKZtw5Q9QJi+63JyVTGayrzNI+OIw+Pzd0gWAGKx6ksS/7nkWdJm32n+z?=
 =?us-ascii?Q?sq4m4Nv3FnMBWEutBAJhpm+3L7ihvPPuTvnQZQiA6IsHvRdomskTNG7ExXcw?=
 =?us-ascii?Q?dqOYkLzw/cAGdw2L01SIQB8VXZ6d/bGjH5FzEbYZBi6IH78sgeGGZgH7+XLf?=
 =?us-ascii?Q?AYNxycV4WnGWT7v4UK6QYGtzNiolrEQCqwBNSqywxY6mkPIW3340rTCN69jW?=
 =?us-ascii?Q?1y6hIB49JgOEFNMm1Lw5TP64n0bkPRHL4pVb8GU8MVNGlzYCiOD/ibssXy7f?=
 =?us-ascii?Q?5HbwqW0xTMZwJhwrtk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f23fc1-daa7-4a2a-b964-08dbb528925d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 13:43:26.1628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbbEiTzb1uK7tx823vTjS58vmnXS4UHECdJs/h4Qr9d+PQcYL1ItiEGw4BgNZiof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 14, 2023 9:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove SMUv13.0.6 unsupported feature

Selectively updating feature mask is not supported in SMU v13.0.6.
Remove the callback corresponding to that.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 94b0a7226ba4..4ba6790cac5a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2222,7 +2222,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
        .allow_xgmi_power_down =3D smu_v13_0_6_allow_xgmi_power_down,
        .log_thermal_throttling_event =3D smu_v13_0_6_log_thermal_throttlin=
g_event,
        .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
-       .set_pp_feature_mask =3D smu_cmn_set_pp_feature_mask,
        .get_gpu_metrics =3D smu_v13_0_6_get_gpu_metrics,
        .get_thermal_temperature_range =3D smu_v13_0_6_get_thermal_temperat=
ure_range,
        .mode1_reset_is_support =3D smu_v13_0_6_is_mode1_reset_supported,
--
2.25.1

