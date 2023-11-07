Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE7DC4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 08:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218EC10E149;
	Tue,  7 Nov 2023 08:56:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C4510E149
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 08:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEXUY3Xb8Qz3PfOtJeGveVCHdNmE2QWEN/v4LP3jegcNy6o8MU7+9E61V6AYd1q/yfz6dlgcTIxnk+IzD3H4cX4uDO3L3hr17GfWQolN8qSbSotku232vLCVetb76HCI0s3LapA1+OxevOWP0WUZAJTT3x4xxpkQAG/Zk8q2DPtyCBy35xrW7j62adWnHpmkDpalRgl1/bD3FNA3yXOCQTPLMu7nOxv78KqMct4M7oWlBLQSGiqeX2kWXEruOpe48YOd7akdIIIFkjVqJlT47jKrBHfOZop1lKmC0yT60+qiVGYgv8SmUIjGWegh/jQBFDlHB30CEnXuANO9WPNqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k9/Wey/bR5d4Vc91MHIoYZvEfl2FMytVffXaMZ+1sQ=;
 b=lwDBVQmI9BsUZI/e1KW6pTqrZQy+Izd2z65y9FdquZ+qRulnjke3TjBj2e1RqtUwtJ1Gl2qv0sAeecgON1Hdw3AiRN1X4wYxJiT+4xxVKkSmwyHkSJt9s2ohyygrkHjAyaYSciUkkoM0WyQj670ooC0qafxf8/eJpjCb77BDytpLAop6tYG0M7Xx99sjAp7uPywrfH0ZCVpwvXcSVkRP/le7on1jZqxtyjErcHfhMoGwIx5piB7z2SVCZNZss7+vA/alGW385aDmTlMrToubsE8meXoMqQ5+sOobmXrClMzhVqMHtpGD1sZIFo4QbSsAb+Ci7Jef6BYzT7m+kX0h+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k9/Wey/bR5d4Vc91MHIoYZvEfl2FMytVffXaMZ+1sQ=;
 b=kAePcbtJDy5yVi+AM3L3iqbC45iCKoveJiaTi8RBcNEvNcHX7DP0Y2s4/mL5mGqARJPidPCTh0NM29S1pp5PfA0qES+74ne4pUgrgydINuDHVApUhmRtPpUtGMgOzhbWa5tL2omTPnc3yjMsEEdJkhUp61+zFnpCmjkaC21w6Gk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 08:56:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 08:56:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode
Thread-Topic: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode
Thread-Index: AQHaDWtpDUgpWZS+tE2RWJGe0/LFEbBulZQQ
Date: Tue, 7 Nov 2023 08:56:15 +0000
Message-ID: <BN9PR12MB525749F9E089AB5583DE3237FCA9A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231102090244.12144-1-tao.zhou1@amd.com>
In-Reply-To: <20231102090244.12144-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=380e9bb6-94ce-42aa-b7d4-02312086d6c7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-07T08:55:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5821:EE_
x-ms-office365-filtering-correlation-id: 24b64a4f-ac95-42f3-bf9d-08dbdf6f6674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B27gCt/s40jp4wNkDBS2saLgLYP2pfVN3mpRFhSBd9R2L3uUIxLH+PVglqfPyXyaNcirpJoRjxoxoGTQ1Ok/CTLH0iIkZNIsl+RZtVQNjq+7+6NiEhqc0EalLpHSjI+C7nQwSCpoCJhwc50Gw6fAQhLZLNmjj0BJQARkbI9+TzSLD+voi1liB/pJC0Jbka2G1dVv8Y2yEjv67SVVQWRRai9/E8MsCTXXYwfS9bYasuM8EWVMGhiJ4ehATF4gWAgfpt+Zn3EgXYXE/R4lFzEJyfbNC05bKQfszCSxnm6UTka31wwDUYUK52ULQrEADJ9J4Unt9yn82tjM34QO09vPUyKHj5OyE8ollX02FvPvLFkugwVn+YEVNrKhYpaT2XH+U/u7gnugfM2IjLu1afgHyUMRl+9mvSzB3T0k03Tc6tZDZl36W7H6AMESUVBn31W+1OcR/DNSITgx491YIBEboQHslZwUJBl2KD0eD0eNKkO9MoY+TeXk1SFVbiLHJYkEH7j7PE78DzcBDsUeaIk6VVqcJ9RkQW2P4E0EzrGIKIBC+Mc/YBXEXk+gO+59RG0SAk4BdKddQ3ERoOadxWxTikQ3CJsyMCfGc97KRK8qg1sGlymbEOsARSPpNOh5FTDd+Q/vRaAvLuLdbrM0+VBiFvFcBAC3Nz08uma86w2d8kI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(33656002)(53546011)(7696005)(6506007)(71200400001)(41300700001)(9686003)(66946007)(54906003)(64756008)(4326008)(66446008)(76116006)(66476007)(110136005)(66556008)(2906002)(5660300002)(316002)(8676002)(8936002)(478600001)(38070700009)(55016003)(83380400001)(26005)(52536014)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QmLNu221lQ6wIsTGaOJKFEn3RJJxqc53Kpzfy9UzFkpYLNKU/2ljmFGwkCFb?=
 =?us-ascii?Q?z1HN7vveLxGNbj+PU0uqOC5mVLX43uXjrC8H7lLRvrltATPnyDW0nvLIm2Mm?=
 =?us-ascii?Q?QqoOtaL5iSaSxcTec+FIPAYKMWiIezuMRJiWNGIQUY0uRJFPagL5u0F8ceme?=
 =?us-ascii?Q?ZwCV6EIBycby/vBpBd/ujrwbOvxQa6/HZrJ1FHhjXZsLfM2q264GrZoy+eSb?=
 =?us-ascii?Q?1p1+4UFZfu7lK5BbAzjDLPX2CTIOYtT79q3sknrpPentuwOxrpI6GKbyQ+tW?=
 =?us-ascii?Q?Sjgu5RQSQ9Syqj46UeZONh9xgffT6Lsi6RXwHNrqV+7cLWtndtgJBsyFtgS5?=
 =?us-ascii?Q?EDs+BLyyoKzVv2D3dWo9BQoZ+atyU3wnQOHv4rPr7EFHDuL9OqIIPUFzlqBC?=
 =?us-ascii?Q?n6gBVSvz7USaay2eZbT4VGZynOuUkyJFcYTOLicqOwsNRETHkmzGYAfCXqeC?=
 =?us-ascii?Q?+IBNJdQaTHGB6G6KnUpDTc76aqfp+e8fjxwcx69kfIPy+MlfkxpWPZZ4MlDz?=
 =?us-ascii?Q?260NvfBGKayOHFox3dQGyHIujKo+kH8SWE0IeBcstvoy7iysJHQmSnvQfF7g?=
 =?us-ascii?Q?fFNLvnJkg3GZkh/OGwF32jUxyYnfuI9/33sK7YUbFHLj9DFbh/D3+kEekGXU?=
 =?us-ascii?Q?i9xuNM8zy9Ge9BjgVl7/tjo0uB4zVaEBVAM1jWuohGKxHpQmMu9AsdLZFTwD?=
 =?us-ascii?Q?ViyIu+A1l0ovwGdxdek8FgFgoEpS5C7A5l7nb3H1SQbVbkCbggS6mAhvUxfe?=
 =?us-ascii?Q?tQG0IGtp0FQqzhh+AohdZVOCcFMHc95PMqjb5VmGurfajInO2RCRPgmagahQ?=
 =?us-ascii?Q?ysa67MdYDFu8MbCIHjubKnsCny/GJ19e9bYEbyK6XXQ0essuQbg1GiHI0kAc?=
 =?us-ascii?Q?m+gfeaFwRupq8ty2QDaErSr6U/e+blgdb4S08UU2/e8oandMQiG+HzgZW0SX?=
 =?us-ascii?Q?xCnpOeBrbRdcvFb2aUNRG9V96iLBQHy4SdFIjg6d9lcgiBo3Xw4Wyqko4jmm?=
 =?us-ascii?Q?A1+hgS0/JFTDANSe8LBsb3BcwEiIpQKkZ/3tJ0/qU0/Y7iWsqFvwVaW7JypW?=
 =?us-ascii?Q?5qJmoiYv15CIer5GmXacVGPizNjz7kuDASHvcgGb8tSRnDEc4g7poESWq7Yh?=
 =?us-ascii?Q?f0Fb3ON24w0CETlREOHTmfdJBD/JZYVCpSu0fdmMhXThUwAxB1RCLRFK+hbv?=
 =?us-ascii?Q?tEk23NWZkk/S7qMV8CLwRPaZe6QPTdeQlsasCb60JG/3sTvjEkj/YDqbfTrZ?=
 =?us-ascii?Q?f5UJ5gSsJVFWWzaLIitb7UbRFt7G9fdZW5fiLw/pdpPxQKB1lKB7Y958O179?=
 =?us-ascii?Q?ULY/VwK7M9OcDZB1/M5aS/XrlkXLxYSUKYwVJoTs8neZ4phiASi4o4Xx39gM?=
 =?us-ascii?Q?hQkIDVy5GMzTZKp/fvreFonxnoDVGx8qYYKTJzH9FTZfqjc9bBQQvyPR1GwH?=
 =?us-ascii?Q?KZotJltk0W0cSXyLMwXTgxDw4Jfomg83vXlKiFnpKdkI3+Vl45WE53H4S/zw?=
 =?us-ascii?Q?kv/yBCdC1lkyDMJjnQ4M6tuPy/Gc18ggOASAAvzJDS0EForccYllIIqm+nOV?=
 =?us-ascii?Q?15z6Ppoi54wghCzrPYk2ROH3QE4s1VTWGln+A4yO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b64a4f-ac95-42f3-bf9d-08dbdf6f6674
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 08:56:15.6226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGKYTHOdThkFbin57Apjad+CUvvRKetTfZEJOmX5NyXvThn/ykCCvTH57WzRajvfechTBaabR0fPQTVNzodtDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, November 2, 2023 17:03
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode

set_xgmi_plpd_mode may be unsupported and this isn't error, no need to prin=
t warning for it.

v2: add ret2 to save the status of psp_ras_trigger_error.

Suggested-by: lijo.lazar@amd.com
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 0533f873001b..a5a72e5aae94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1131,28 +1131,30 @@ static void amdgpu_xgmi_query_ras_error_count(struc=
t amdgpu_device *adev,  static int amdgpu_ras_error_inject_xgmi(struct amdg=
pu_device *adev,
                        void *inject_if, uint32_t instance_mask)  {
-       int ret =3D 0;
+       int ret1, ret2;
        struct ta_ras_trigger_error_input *block_info =3D
                                (struct ta_ras_trigger_error_input *)inject=
_if;

        if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
                dev_warn(adev->dev, "Failed to disallow df cstate");

-       if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW))
+       ret1 =3D amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW);
+       if (ret1 && ret1 !=3D -EOPNOTSUPP)
                dev_warn(adev->dev, "Failed to disallow XGMI power down");

-       ret =3D psp_ras_trigger_error(&adev->psp, block_info, instance_mask=
);
+       ret2 =3D psp_ras_trigger_error(&adev->psp, block_info, instance_mas=
k);

        if (amdgpu_ras_intr_triggered())
-               return ret;
+               return ret2;

-       if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT))
+       ret1 =3D amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT);
+       if (ret1 && ret1 !=3D -EOPNOTSUPP)
                dev_warn(adev->dev, "Failed to allow XGMI power down");

        if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
                dev_warn(adev->dev, "Failed to allow df cstate");

-       return ret;
+       return ret2;
 }

 struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops =3D {
--
2.35.1

