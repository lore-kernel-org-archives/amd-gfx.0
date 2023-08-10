Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0479FC001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 12:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A99A10E515;
	Thu, 10 Aug 2023 12:44:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6591110E186
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 12:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UemoZzp+XDoItddh0nMGxi/EjBYFr919hHjf4DMh6Eb+TlGiAiq8ftJQNSptRY2LiXtD5bRvJ4fDFgkugWItzcatXan+W0liVi01sGXHjFUqRIxHfshVXaknvWo8no5gxElFv2yfcCTlc/O2GZ/BWAqZEFDhVJlVtPFLzj82z9o8P9V3D36hhlaDEf26aUif6bLIkB7idT+3Te6wSJx9tjppLx5lsDPsxypbQIhF6d56U00P7TcGjX9Zx/h12/HkcM7H9QjaPaWee+CQrroCNe6LnIOOIUtaT+/RDPatCjqQf5M8DST0LJjEcJfEvEQErTPy464SnweNbcWLYoqjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0W+GE8DGkA2ODPxzCOJMZFt/sqmpFq+XHyWyO9LsT8=;
 b=iUE7TZ7c29uib+0Mzix1AQUEnRTPVSDwUf1edoKRUbieMF2t0laEvwOTFYZeiDa4axtf3h18it6e50KPeOhdfU+4Em0/fLr9LrTgCGHJn2EhdT9aTXRSGRE1dV/yCTy7XS+GBZ2S35GX3BXyXYXcSShhfcL7OnWdbmrCwi+T695pJmsMLh3N72QyOnwrctg9A8wgeEiPdUGBcWBWJK3Z/nhlxHa4HPjo9lcn8fR5G+frN9Ntt5MLF+YBL5SbmHfKLHM8FX7aV8fclNqRMXEYotYIKSxa0HwSTZnSl3ECg5GNw6/ed7c0l+8cWyv5q7muhJ3/OcRPYOZhUUouLbQEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0W+GE8DGkA2ODPxzCOJMZFt/sqmpFq+XHyWyO9LsT8=;
 b=mI6WzFrX73SFjeSV4MGB/pxPOMrf66uHhCTO2klxkMqinUZVRctTH0rzRsMrqkxrcv0zDPYjHO3AYF3G2goVnwZb1hW8OULwfNXWFUIE7eVGb47iSrMbfmlKFWQiKAYp8tRNFdE+IAz6wAqBz8EpUqxnPsM6wC/yGao80AgWzog=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:44:22 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:44:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix temperature unit of SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Fix temperature unit of SMU v13.0.6
Thread-Index: AQHZy3fg1Hd6bm9t4EW1c2PT41LBr6/jebqA
Date: Thu, 10 Aug 2023 12:44:22 +0000
Message-ID: <PH7PR12MB5997FF1C75EF10F0EA60886B8213A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230810104536.643172-1-lijo.lazar@amd.com>
In-Reply-To: <20230810104536.643172-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32896be5-8fb7-40de-8e33-4bf37efc6670;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-10T12:43:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL0PR12MB4866:EE_
x-ms-office365-filtering-correlation-id: d98956fa-ce00-4e8c-2464-08db999f85a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhriQ5sChznul4CoSz7JEHMvYHhTCrWebzIV9oa/Pv5BPuzybP2K1gVdc/SNtPik0r/TFuILNSw+Jse0A2fv2dPb2hgcsGOfmpY/ccxsFY3CTfO1Dtm3WTncCa5JpyI6Ie1N1E/73BUd5Jo9qPYc6Z4tSRlMP2VBxvzIH0PNrQH6CZ4EcBEC4P+0PTAp/kpRa7fwL90p3YrYpyq8TK8BCA1gMcT0hdI6jUGjiiyPLbqbTr2EQ9tSbP6RoXjpVx8MV7GDY/f7X+hmRLpaXhuvwTaLhTLDSuNNWGNv9mkgnbzg5RPKhdRBoJhxuVQjIbxexuv6ZTXAbNOBdoo/RurOjG2vDXfuXrTH82LH55MqXQ0ZdG1jxu1IRDjAY0TcFWH+kL7i3pMk9Dg//qYo7It/bu87gBS0krIbxMpgA/mvP+x4mVnqGEISMydGo9djHSCY14RxAvEllNdWAIi0I5h47qWDBalWwPu5RDgcWGoXy1GwfInjy29cMlAolRQOEH134dj61QkMIGR8vWgr6b4dA5I2I5uaQoQUXJ9uF46Uvl1PUediSmsCzISRUOnbRN5PxdoT2O5Xl0RslK3Fe1eeKHlq0dMkc+vgLk4wcxtBSI1mOaY9CeX+Lz32f5EuES3e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(1800799006)(186006)(26005)(5660300002)(53546011)(6506007)(8936002)(8676002)(41300700001)(33656002)(38100700002)(2906002)(83380400001)(122000001)(86362001)(38070700005)(55016003)(52536014)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(4326008)(9686003)(54906003)(110136005)(71200400001)(7696005)(478600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j9TTVGAvbkRZzXds/Ty8/K/Pk8sO2vYAYcq/nBI6DCyejz5XA9fe+m5IMadF?=
 =?us-ascii?Q?h8ldzKlmfX19aieQzBOv1iL7zMdctKm+ud4ZfLj35vQ78qyYOV2RbQi99YaO?=
 =?us-ascii?Q?NUEeWjoyaHG3+jpsuMojed/K++FH0u9AQABsmy3IV0X11h85K3OAyEzmWQxt?=
 =?us-ascii?Q?/VMpm9voMHhzOgiSCyS4cQNS7Z8oFxywqc520iIi/E44apKwVedtlE7ri3MJ?=
 =?us-ascii?Q?J1izS3Cn1AlZbvxpWlIWzx5YcCOCmGKAvjHyUdytE5w4naDvyjCgCyHOXvXL?=
 =?us-ascii?Q?I9Myqa9tosoBTWv+pw1EuoOlRJr/h0tSdOfjgWurhwdZ+e2yqa+W/lC0lhsr?=
 =?us-ascii?Q?XoX3bwNymkjGVg8CX0279eVxXae3sJbTCtmLAwVDYLOaJ5SJaXXp+U/65nm+?=
 =?us-ascii?Q?XEmKt+Q2qOQhLx4q3U7WGNG2LAEHTXpjdUsjXaTNvC3a0HUjPYb1cg7Asfup?=
 =?us-ascii?Q?bTqsDyigeG5R0EvGF4o5HptK0ChKzFu4curqnz08XyCPcAPPcCzn6aohijA5?=
 =?us-ascii?Q?4oSDJP2lVFaojRx6SbO5xFJkBHIL0vccOIK8RXyurFPV+H8mMQXayKdgT2Fx?=
 =?us-ascii?Q?bu2+kbb+SPfLd5mod2Ui83dZ9lW4uigzFuxYJ9SPNi/JIEFEIh5B2V6/IteP?=
 =?us-ascii?Q?OosBVd44vtSsdYwFfpQXG1LKF3ZrpVaS6HOpfwb0W73HNlHZx0pyb2vsd0BQ?=
 =?us-ascii?Q?zV51FnTSsE7wjyHICgr1rEB+aRxa8bahPZey5iGpCTpApAq2hHvhbKs7QwMD?=
 =?us-ascii?Q?4EfysRP0c1IUXw4KeARGlHV2onBshsslL501wkyf+gSYmEMSqrDBZ6Ip58il?=
 =?us-ascii?Q?4VrC+bLHIqHDUDE01TeSLOgfCW6mXnKfzJE2HqxE/NCIf9VM+whcyPsGw5em?=
 =?us-ascii?Q?hbpN8P7WgWM19+yUG25n9M6tWgx2mExnnxE6wH8XAdv4Ss9Hf1wFm0UTRwOw?=
 =?us-ascii?Q?DEBFjp5UwSc7rqr+nLNccGv9oeCevNoic3EsYWIAHPrRnGTefcRny+zPjvke?=
 =?us-ascii?Q?SNAWFNfXrAohb8/PsSZcAGGV6m/81TClYI9UlmKsfGU4drIVwp2UzEAYMFsT?=
 =?us-ascii?Q?vxBvW11QCCGZHtspKRAx4BhqUNYY/BYFsYsUf8eUaYx13q4aRac+JlPvNnE7?=
 =?us-ascii?Q?Ox9PpSzCHR434DvtHZCyB2bVbPmC1Qij7hov5SJscan1av2pDEhG934hXSw+?=
 =?us-ascii?Q?MQgG+ScM2wvNSthewRiC+EUWdhSx+stdzi6mMmPJvpYDZaSf2AkqJGXkQ7fJ?=
 =?us-ascii?Q?iTFLin/lz69baMjKtAL1+yMrBcOJ04mUnZX9cp8eV2tE6u7Cv+9RWr8IUKco?=
 =?us-ascii?Q?u12qGOg++7oWMJIpUY9BnCyzqRdhHKNaLszxGByyFstN9O694TXL/5kiEmIR?=
 =?us-ascii?Q?DlIDymCd0vSXlxvuE35reiVkuyFaxmuPRMC0NWiEuW+yztbHFnpEz/eL4g5g?=
 =?us-ascii?Q?cJuZH09SyFK0QIRpI8ksvll1YILEQqPcIi9ogLKEoiFZhi42a2HbgQGJ/SQ4?=
 =?us-ascii?Q?C8IdS0voJ3NDGNu1yhE2BGQg/95MU+yUBB/VfMWbjkq8Os82gX6nbWvt1Cf3?=
 =?us-ascii?Q?qkg5cbPd0X2VjYqQkDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98956fa-ce00-4e8c-2464-08db999f85a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 12:44:22.3999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZCg06RICaKLNk6HLhoJ0XcgudUyQwMSOUAVOEFw/woB6jW6uXtnSGftKDP4m6e5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, August 10, 2023 6:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix temperature unit of SMU v13.0.6

Temperature needs to be reported in millidegree Celsius.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 244e6d31560d..da8ba1aa57eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -708,16 +708,19 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,
                *value =3D SMUQ10_TO_UINT(metrics->SocketPower) << 8;
                break;
        case METRICS_TEMPERATURE_HOTSPOT:
-               *value =3D SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
+               *value =3D SMUQ10_TO_UINT(metrics->MaxSocketTemperature) *
+                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                break;
        case METRICS_TEMPERATURE_MEM:
-               *value =3D SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
+               *value =3D SMUQ10_TO_UINT(metrics->MaxHbmTemperature) *
+                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                break;
        /* This is the max of all VRs and not just SOC VR.
         * No need to define another data type for the same.
         */
        case METRICS_TEMPERATURE_VRSOC:
-               *value =3D SMUQ10_TO_UINT(metrics->MaxVrTemperature);
+               *value =3D SMUQ10_TO_UINT(metrics->MaxVrTemperature) *
+                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                break;
        default:
                *value =3D UINT_MAX;
--
2.25.1

