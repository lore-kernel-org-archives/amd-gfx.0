Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766B2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E4D10F82B;
	Fri, 29 Apr 2022 02:41:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7328310F6CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7xY9t/GTkBsvmoHIJNdAYPxmtNctXo2wixSAT9EsUmn/+bxqqGGj4Nlu+3VV2u3HOG3s1gQ7GD1+s4d3T1yh2VXvELG0CcY3ONAfwCj47Q9VKFxqsZsTFJLruZz9BP4VkoM2bvdF3bTkkubxOdMFUm9+wQh3Hr1GXCWzKdDQZQ+uM/V3iOXJMLAZM8i0R+SVikaRqrTogZhWVxtOapByh7z3tCRYRy+QLikKfkWSkIBMLtZA0lkyS+813PyWintJtnMJxvVwsTeKEvCRbsk5ZRzmK1bTfmWejVx4QdfRTVzk0EE3UOzRh36JgoZfCmTRTfCjH48j3GV1NVFcEvYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTPx8Qk4WTt4EOZrXhBn4vWxXOObT+okHlPpd9EpU0I=;
 b=W/I5mLK3yasWwUNE7ooBPBqt1KRkRRk8Jd00i7KkrkyqdmK+T7DkqY+8QlJgeLaMd22FampjwPMA1Ay9hkU+zVtUKpZ0XS3vSCSyxnsr0v3x/GvM4crIr/Ny3YbRKBIwvVUynHsMRwitppjpOPtK17BParmC9/239N7BwHRW/G8Qkvb1TQdf5/WjwQXNSP4d3fZF5I5D7bubgFMS2q588NXmGzF6NFPd7PlAAdIPQCFuGkqmaOG2plfoROLMBj4lDeBHkj5tl5V8eXZzFKa5CQp+golfet4EP19+MKyxxIf9gaaub9lIjwTfxiCtqwNs7tBhfiHFD5XILHcPjBFqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTPx8Qk4WTt4EOZrXhBn4vWxXOObT+okHlPpd9EpU0I=;
 b=ztcTY6FgiEKDC9NwIdC1zdI87w+yrvigtqmpZJk/JWThOiYfUkqSFViuGq3efunJ/TOrdmxvfai4AF5j8s/XHcCnQcm4IS98E4BcpGJFG0t37Ha/83SQSqpbZGoEepcgLNGFZWU2fkgqXye1T84tdYX2dVp5sVdV7ODVscH/UgA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 02:41:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:41:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amd/smu: Increace dpm level count only for aldebaran
Thread-Topic: [PATCH] drm/amd/smu: Increace dpm level count only for aldebaran
Thread-Index: AQHYW0celINcMWtGNEKvdTkYggg2a60GLmiA
Date: Fri, 29 Apr 2022 02:41:08 +0000
Message-ID: <BN9PR12MB5257EED020629A3AFCEE0A99FCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Likun.Gao@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=761dcd19-114d-47a9-9d20-986424d885a1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:40:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a65c08-8279-4b3e-f0f2-08da2989b6e4
x-ms-traffictypediagnostic: BYAPR12MB3623:EE_
x-microsoft-antispam-prvs: <BYAPR12MB36235E62E6D6E9BBBAF9F775FCFC9@BYAPR12MB3623.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 141Xn5cQKGsD1srLA8fcyMTKqv1dTWh8Hnaoyu+xcawzc0gTfH+vH9XM/lixMdgqFsjl2T4SoEbsab+IJ/bAgYA2QcI1xQpGdCFmuzDrScoRsaKZPCgRhvL41riVjJi2/cqKK3kROOcAluXQKmYuyTvi9w/2iZWqiWeiDSLs4hL+TOhA+LakEP7iS/8nrnY7y1jU6opWuUN7ZelZwsExykINbQHmlLpu874Az0j2cG5sQ0Rss1LmjAhKyRtFcBjEXJtq83rybqJc4jLL37KPmplVqx4QUxJG1l2+P7CJOxN3v9vmZGuU6qAsA1+mDGhGDs4xoTcY2xNFx0qa5tZdrztPAO2fQsMEJRdOU9xdVPKeQwSwYAk0Hf7tHUWs9HJn/puG/Dgc8zhNqtA0MMlYZ6n1zLUMatGJTioi+TQRdlaVwlsySgOeszV8Rom0oa7QJkaiHTkkckr5X9ipvkapYY9IEcg5cc6jS0i7nWgLPA3H7VZ6SbJzNpqNn2IkhjYZ+Id6jkQO9u8QPpIgZ7Iv/WShv0HGsuR2Z8X+vqxzgGi31JV1dzEH8AOnQUlglY9gA2GutVYbX99VAsktwYQXsSAOUF092abip/3udNKqlzQBhAThoLjrucpeAe3HFzz7M1qVIeOR37DHscCHk8K9Prs84j0kwtyC2p01tobpnpYi8VWh7Nr/1be9gzvvXGH37trLHQKFSpDfqT6rHmaXD8Weten4n/yeahCgAZSnKDI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(71200400001)(66946007)(66446008)(64756008)(316002)(66476007)(76116006)(66556008)(83380400001)(110136005)(8676002)(38100700002)(38070700005)(122000001)(6636002)(86362001)(186003)(53546011)(508600001)(6506007)(7696005)(33656002)(2906002)(5660300002)(55016003)(8936002)(52536014)(9686003)(143363002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RXiAotb1ZKRVlv1RLku5OMBbQORo0pC8FA8s1ScLA9Cjbr8lsmu8o3F9y9Js?=
 =?us-ascii?Q?uFblwh/oQfrmQbbZuoO+qYUWYJLvEuunmtqyXNnjsS1zt94uLbJMK0p1i+eC?=
 =?us-ascii?Q?8bJX2t/qVDsRuEnx4I+DaZkiDRG5rXro1CnGGGniJAoZ7cIl6Z7Zs1urOzf6?=
 =?us-ascii?Q?dk/SJPltIe/e0L2VSyToyDrIvy/AjZlRqNv5treLsLLlr2VavisFmom5Y+d3?=
 =?us-ascii?Q?8MVyWL52so6V/peAtTrgigSQ8JBwD6x7lc2bL3gCowWqJs+5/JIWycWvbxgx?=
 =?us-ascii?Q?9NfcvsqDS10DrZPirjn70fv5bBZ2VHe3dVEzmJyQB0t5yOXG5EmVLqrSJ5AX?=
 =?us-ascii?Q?P26E+g/6MJLpnJgcWQtVXFQX0QaeFfY4l4T6gsgExWMH/SJmIfR2CUlPuxso?=
 =?us-ascii?Q?4jQ9/AcRM7UjdEPACuU82+e6CfJo4mvNTVmQUI4l0HvaE+Wuicqnp3zD78dw?=
 =?us-ascii?Q?G42XfJuBRCmW/cn8AQC/JPqt+0iZXNgQIgERy/RJRPcvQLqK4IT+LQKTmrY2?=
 =?us-ascii?Q?Wao8RjYPyNn0k1j0hes/13vdeeD+aqBQPe+bslSKWGJj4zhTMlYj3qoOKxF0?=
 =?us-ascii?Q?Hsqlg05lxCFvJRx48PP23NubafQqOoxu4TgDEaAbrSPtKEls26nd29V993t0?=
 =?us-ascii?Q?2A2JEqMfrQgAjPDTAHAjp1QEEypYMkrEvWgg91YfrceOimwaG7Euke4OZfHs?=
 =?us-ascii?Q?Q1ngqP0p+jnLSviiNe4vnk0LsM6fgyiCLVx1adTvfkH49IwKVcUI/b50XGfH?=
 =?us-ascii?Q?vnmbACMgPJgnyicDxNH9Z+l9WCDHLLUQz7X7JkayRJ1lfr9TGfOjVq569Nyx?=
 =?us-ascii?Q?ZjSzn+XM5HAGM17qew5Of1ghtjbtPSsmB86R8dVnO7Y94UQVO3WD/77ZLws0?=
 =?us-ascii?Q?WdTmVTLYE2Zg5hR0Y65KmW8ZH56dNKRNZJ35Zux4wXsoED+YHfxgK22nZT/r?=
 =?us-ascii?Q?vIoKxyyyOOBWp9ZE6+VhfVLqS0Elaa80m/ncI0a/+lJLnRq65MClL/7viWHa?=
 =?us-ascii?Q?t+RX8Lb4Xqun+RqNNiSaR3izzltYpDc+aaYBKp0Oob3ifq2doU5JkjEhn4ax?=
 =?us-ascii?Q?u1nhqFACMPS/EC17wn8/LK+9hiJybCVCnoknRgix5Y2tCLvdxsysILszvtpP?=
 =?us-ascii?Q?yZJf/GYyX6JlRjLycH8iBiwbOs85iWcYov4os9fkx/NKynZtYxRijlyw24qK?=
 =?us-ascii?Q?6CfpqEicTYXicaf6L+5IWQgZWBrYGEoQ5pHk21uaVWuHL4CTwOQt3wJBynw2?=
 =?us-ascii?Q?Ev+Mkkbp1qqb+fSXUkRM5D4IACcfjZgMTnlEYVONMibXBN7EM+VdEMEdPFJM?=
 =?us-ascii?Q?VPmpiD7mLM4COKI9Std8ZApSA8dSFRFbznMbf2QWJca0TnG3X7DeRMI7FMnM?=
 =?us-ascii?Q?v2WUr3JglOERWlJ4HHWL5C/wnX5xeYUL790R874uHE2J3El4bqY/pd92QnXY?=
 =?us-ascii?Q?vUfwCr9TGFVCY+TrLgLiWJT40F/CfnN7f6MlmBg7bffDQ9lomyYUZnLV9Z2j?=
 =?us-ascii?Q?rJpazcSsw/aKkKXCRN3ht3RdNJ6/J13ZXPCyKMde1UsVy0FWDwS/J7o0PX9T?=
 =?us-ascii?Q?Z6s8yCC/W2zxY889DNFRz7zYCgduF3P19aTTFjS9jByA6/Tov5nXEGKmtdon?=
 =?us-ascii?Q?glDciMffIk7sB6g22DxkgqkqxrXHnyGnmfrUI5XOKjQBc4laWtxziZNn8soy?=
 =?us-ascii?Q?ZHd39BuxCbXxPgwrHgwMRS1eig3jF/shlcoQ27//rQGqrHpCa3uljsbZpN8w?=
 =?us-ascii?Q?j5mGCV2tUg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a65c08-8279-4b3e-f0f2-08da2989b6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:41:08.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WO29HeuM7Opx2zhGiGGRijzP/Jt/UBRdNGRAsBT+Ry8uIfGzmuKZ4Kls7PpebASssI3xj1jDHl3IYTFJoTWW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
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

Hi @Gao, Likun,

Can we replace the asic_type check with ip versioning check?

Regards,
Hawking

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, April 29, 2022 05:30
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/smu: Increace dpm level count only for aldebaran

From: Likun Gao <Likun.Gao@amd.com>

Only aldebaran on SMU v13 will get 0 based max level from fw and increment =
by one, other ASIC will not need for this.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf09e30bdfe0..21b1187028fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1750,8 +1750,8 @@ int smu_v13_0_get_dpm_level_count(struct smu_context =
*smu,
        int ret;

        ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value)=
;
-       /* FW returns 0 based max level, increment by one */
-       if (!ret && value)
+       /* ALDEBARAN FW returns 0 based max level, increment by one for it =
*/
+       if((smu->adev->asic_type =3D=3D CHIP_ALDEBARAN) && (!ret && value))
                ++(*value);

        return ret;
--
2.35.1

