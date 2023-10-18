Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B0FCDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E314610E3CE;
	Wed, 18 Oct 2023 11:53:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2060210E3CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG3+ArSb22mhevvRLkEDrKueWJn1RAM9XRnlKPLFvPT2ayXqzJ8Tb72gQ3U22m/vlaIpPP5yCQgUJ+Ug6ItxqVdsVzmHoipkp7r90EYhNbzQhBbDI1fmNFppACA+oW10hFfWnQ9jvRuoXuGerMrzq12d2HwJIjFSVLJ6hxlkWsn0KB3CJzLzNqoCv2PrAjEYZXnHKb0GKeXmKawnYLtTRBfpUtJeMxkai7+ZZGxDGHX032/rROKGRtUpBDEsv2m07dyZBoZxKJf9GJGAdy4wQOLLfcfpCUxdngfwTcWak9RNs0CzAM1a5dtycxzkRwELKOsfRx8fryGCDqgYKnV6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eomnp73tkjq2Prkqwoamlww7lA3HYQGd2SWT2Ugb7wI=;
 b=fBoT8UEbXc5GuZBBcjDpW07vVfvZkaA9hWUq991GzGNhTtmY5EaJvc57yzAUxG3LzxwBIGxHae+UwwdSnMQu4iFj8lbKYkPn9k7lEHOirjXALZZTQmtw8wlkC8m1HPlQajWZJUG68iFhADFWvfE0JE1kUWz0Cfoy4YJIn0XZ07XgNEp0zbHemUMx3ZmaitjFJgPWVFe/O0giLfraO3+OLWiePwnC1bn1zm6uQy7kD21UwWv7EOc3iD6LpgMM0bJyvdJGFTn8cHIpIK+Ew+Qoh84+4+v8YMV3o6mOka5OB0xHklZnGvtdWLSuQhkIuQU8jZo/K1yy63Cyl8OCBKrFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eomnp73tkjq2Prkqwoamlww7lA3HYQGd2SWT2Ugb7wI=;
 b=UIhVlc2M7WPyCMlJtoevENEn6QqnRtswDPqZcQS5V56Crqrjpls4ypyKw2Vya6m/0TDL46mPRiuHv3rmm5zJciKKCrl3KJrRnVqL/IzoJMwIKxCYPnjILBS0YzIj54Az1XgBb/FkSU3MzWj7qd14G2E77ah2L22mEGR2oxJHXGo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 11:53:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 11:53:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu: drop status query/reset for GCEA 9.4.3
 and MMEA 1.8
Thread-Topic: [PATCH 6/6] drm/amdgpu: drop status query/reset for GCEA 9.4.3
 and MMEA 1.8
Thread-Index: AQHaAbfrOz5bpv5BAkaNA6eNGTqkVrBPb+7w
Date: Wed, 18 Oct 2023 11:53:35 +0000
Message-ID: <BN9PR12MB5257657569FE92928A0E86ADFCD5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231018113957.20079-1-tao.zhou1@amd.com>
 <20231018113957.20079-6-tao.zhou1@amd.com>
In-Reply-To: <20231018113957.20079-6-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2872618a-9915-4b0d-8c91-f1af05cf10c0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-18T11:53:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4358:EE_
x-ms-office365-filtering-correlation-id: afe7a396-0b4f-4d81-6306-08dbcfd0dc5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HyJ4frPjZIGjbLHNtOvCS/MQZRSAfHDoRJ9bTrX+FupsXhBPmOU+By8BFxRwkKWfGUsKq9SJ1eKxqT8uEux3DkC1LWW2cjSMPMMJg9nh74bQ/47O/f88bot9FLqhspI8fuPOeYX1xaZrOPs5jG2o9ebImf9TJo1f+wqf/uz+fWWedTBQ3Q8nZBFs0gBfyEajSTokuGShQH7OtUWwR5p2Y3NGmZhEs7GFEGyLjvS4UngPl1Dm/dK+TmQwKrHT9tFxXSnPo9rJF+UNhih2j7yDViJK6RBc6Tw5J9oes4T64zjfJjc+SZ0r8QBJAQXQdUzl/VnJF0hX7XtaUd+T+Wnq9bKhY8g8orwHUqZ9Y9Da/hOEjYYQXdf8K26D0sm73xXThUoFJWFjdDULGCY8s4wOT3iwutnDXJlx5pIDol6duV5G01Y+fs1qaf/VGs4xtSsLkAB0YpX+JY+E++AOZ1NIBiSySPq5ULol8fbLqQVBDyoQRjSMLJU43BaAd/6TlXbgbEgMbEZIQUb5A2p+uTycvJkikSoAAhyXvsCcKO3aLtJViKWZGNcD6e7esO4Vv44GelOw81B3fjIynjp+ww46ENJlaBnPnSwx693uiN7FnkP5HUP0ig46dWHgc5hKqzP58LPFP/H69MekmeUsKFodQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(26005)(7696005)(6506007)(71200400001)(53546011)(8936002)(83380400001)(5660300002)(41300700001)(52536014)(316002)(2906002)(478600001)(8676002)(110136005)(6636002)(76116006)(66556008)(66946007)(64756008)(66446008)(66476007)(86362001)(122000001)(38070700005)(921005)(38100700002)(33656002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ha+T1WBaMCGSb9o4blfrvodFskJHBhOYPtGGwbwytvEaZ8ZDCy98tlFBpZqw?=
 =?us-ascii?Q?n/SUoKOqKcveaZmIBfU94B/IN99NESAIiUrsjNrOakG9FKxsmZJaCmF1cSq2?=
 =?us-ascii?Q?Mjse9v0/FuW4an3C8z5Af8s8fjfyzJZ9klDSlByq35Qe1R4kfv2v3T5V19rU?=
 =?us-ascii?Q?A7C1ujnoXYrJvUjRnCmkYiJ5Ba4gjVTF+dFvvdVdVWUjv7R1qi0HEo5ziLse?=
 =?us-ascii?Q?077uFQ1B0oZwZ7ZGEp7ZXalu7LBtih6HuKya981Bi1VdgEjWjIK79pPPyEED?=
 =?us-ascii?Q?+KP9Y1E0oD7xai6u71Q8nT8TDCPqWGmTwd+8/4jyQEBniiOc6S5/vZjbzOEw?=
 =?us-ascii?Q?5kYFXJFy6kbs3kQed4GdV5oantLY73Ujc8DmsjFVyImH6AsDXR9RxYyjq9VE?=
 =?us-ascii?Q?txMTilXWcwDBoQhVe6cDoV+RlyEDrGc6mBuIBmROA9eWkq5u9Sr6bYR18DN7?=
 =?us-ascii?Q?hYIegRRggpGlGXrG2BWVI07v8xcyIRIXfV/Y31/0GLzh3dJCPHNB1um76Vwv?=
 =?us-ascii?Q?zEhTCHtayBpBERCkk2tOfV98DsKt1QZo6CKIxSZzd/6drx2+zSxV8R9Eyae/?=
 =?us-ascii?Q?mhLp8xBYd33YJZuXVfBSU5SASi8ILDzS1jN3W4pYmffTwzjsRZGJUT5cQrds?=
 =?us-ascii?Q?uX/TumpZtQgOkyGHsVmyFQ/QqG0jp90sRnTv2BLV3fP3kzNVMKlukDTmO6+A?=
 =?us-ascii?Q?fnfeZH9DhuOOtENIcea8/KawzLCmW7aXMfZkp5Wdafc6ZPoQT+xfv+PxHr3a?=
 =?us-ascii?Q?T2OO7Az67YlNvYODfRiqArjnxvajuzmB0GMxCIVrAUZy4NE+oUHE+F6mn4XS?=
 =?us-ascii?Q?iTSdvn2O6fPGft2B0Oprq+ONHutF1UIroYLlNTmvVponeIuUc0shHfkoTrTI?=
 =?us-ascii?Q?3WCwpnv6wMkOsOhMJH2qcpCJdcll77ybGcrLigZ6NJmO8Xhg6XUWe4NuS7pn?=
 =?us-ascii?Q?VPuXjKLbal4OZc3vUy9Gvcq814LPPg3tCcqaSp2RIHpm1JcIHIxbTxGGIWPU?=
 =?us-ascii?Q?3n0qs8eOtDs7gQZi2mjRvKGwIDTOoG0LV0NJIwkzedoHPsWS3flaNsW3bBRT?=
 =?us-ascii?Q?Vi/8yGDsAO5NwGsZeebc4xb2F46K+KbfGxCFGsQjeolLaxKuuaBwzgk9THCd?=
 =?us-ascii?Q?IFJKyhMsQN3IbOvPUp3jvy2u4CTiHC0L3afohCaT2I6UUfK/upcRfkFo97qk?=
 =?us-ascii?Q?z5bASU5I0b5uOiUIhlEizb7X11ubnaz186G2jnQVthavV83svIGo1cVKD1gj?=
 =?us-ascii?Q?I5STL2K8HKfmR4SNsSmVrGRTB9TON2OA4po2+mFXa3rJS6zedsJ07r3YYu/z?=
 =?us-ascii?Q?GaykxWoQZZt3apIPOubsAlkTKBj5vGrdm6J7qtt4ddGqi9VIm8TUfz8bf43/?=
 =?us-ascii?Q?5Txhl9xygYyhWxiwEM9nL0PMxc9O84bNMOzdtfOMcz+UgYP9O/P8cgZGfQAO?=
 =?us-ascii?Q?Pckv/BtS2HknzprJ/mKU7VzacmSBmFu5OQuR3H0F4jkSBScJ6g47CKFH2jPC?=
 =?us-ascii?Q?VAFh3nKc8cOqgAGGaTSQUd+396c+efv40IkH+G/4m3b6j4jGSp0DXR87e8ly?=
 =?us-ascii?Q?6B6vzRqgcG1YD3nBEmAMMFLC6MPdig9ghe9Vt1I+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe7a396-0b4f-4d81-6306-08dbcfd0dc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 11:53:36.0294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFRp/KsBg1uY2cHd7LuDxaOnBHPx8BpQv3TMq5z15LWzRqloi2+dXtKCYnUcNXAYtV0nhAG/fhT5ILLhpV+Ojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
Sent: Wednesday, October 18, 2023 19:40
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Ya=
ng(Kevin) <KevinYang.Wang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: drop status query/reset for GCEA 9.4.3 and=
 MMEA 1.8

PMFW will be responsible for them.

v2: remove query interfaces.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  60 ----------  drivers/gpu/drm/=
amd/amdgpu/mmhub_v1_8.c | 143 ------------------------
 2 files changed, 203 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index a1c2c952d882..362bf51ab1d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3754,10 +3754,6 @@ static const struct amdgpu_gfx_ras_reg_entry gfx_v9_=
4_3_ue_reg_list[] =3D {
            AMDGPU_GFX_LDS_MEM, 4},
 };

-static const struct soc15_reg_entry gfx_v9_4_3_ea_err_status_regs =3D {
-       SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16
-};
-
 static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev=
,
                                        void *ras_error_status, int xcc_id)=
  { @@ -3846,39 +3842,6 @@ static void gfx_v9_4_3_inst_reset_ras_err_count(=
struct amdgpu_device *adev,
        mutex_unlock(&adev->grbm_idx_mutex);
 }

-static void gfx_v9_4_3_inst_query_ea_err_status(struct amdgpu_device *adev=
,
-                                       int xcc_id)
-{
-       uint32_t i, j;
-       uint32_t reg_value;
-
-       mutex_lock(&adev->grbm_idx_mutex);
-
-       for (i =3D 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
-               for (j =3D 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j=
++) {
-                       gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
-                       reg_value =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id)=
,
-                                       regGCEA_ERR_STATUS);
-                       if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_R=
DRSP_STATUS) ||
-                           REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_W=
RRSP_STATUS) ||
-                           REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_R=
DRSP_DATAPARITY_ERROR)) {
-                               dev_warn(adev->dev,
-                                       "GCEA err detected at instance: %d,=
 status: 0x%x!\n",
-                                       j, reg_value);
-                       }
-                       /* clear after read */
-                       reg_value =3D REG_SET_FIELD(reg_value, GCEA_ERR_STA=
TUS,
-                                                 CLEAR_ERROR_STATUS, 0x1);
-                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_=
STATUS,
-                                       reg_value);
-               }
-       }
-
-       gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffffff=
f,
-                       xcc_id);
-       mutex_unlock(&adev->grbm_idx_mutex);
-}
-
 static void gfx_v9_4_3_inst_query_utc_err_status(struct amdgpu_device *ade=
v,
                                        int xcc_id)
 {
@@ -3983,7 +3946,6 @@ static void gfx_v9_4_3_inst_query_sq_timeout_status(s=
truct amdgpu_device *adev,  static void gfx_v9_4_3_inst_query_ras_err_statu=
s(struct amdgpu_device *adev,
                                        void *ras_error_status, int xcc_id)=
  {
-       gfx_v9_4_3_inst_query_ea_err_status(adev, xcc_id);
        gfx_v9_4_3_inst_query_utc_err_status(adev, xcc_id);
        gfx_v9_4_3_inst_query_sq_timeout_status(adev, xcc_id);  } @@ -3996,=
27 +3958,6 @@ static void gfx_v9_4_3_inst_reset_utc_err_status(struct amdgp=
u_device *adev,
        WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATU=
S, 0x3);  }

-static void gfx_v9_4_3_inst_reset_ea_err_status(struct amdgpu_device *adev=
,
-                                       int xcc_id)
-{
-       uint32_t i, j;
-       uint32_t value;
-
-       mutex_lock(&adev->grbm_idx_mutex);
-       for (i =3D 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
-               for (j =3D 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j=
++) {
-                       gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
-                       value =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), re=
gGCEA_ERR_STATUS);
-                       value =3D REG_SET_FIELD(value, GCEA_ERR_STATUS,
-                                               CLEAR_ERROR_STATUS, 0x1);
-                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_=
STATUS, value);
-               }
-       }
-       gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffffff=
f,
-                       xcc_id);
-       mutex_unlock(&adev->grbm_idx_mutex);
-}
-
 static void gfx_v9_4_3_inst_reset_sq_timeout_status(struct amdgpu_device *=
adev,
                                        int xcc_id)
 {
@@ -4042,7 +3983,6 @@ static void gfx_v9_4_3_inst_reset_ras_err_status(stru=
ct amdgpu_device *adev,
                                        void *ras_error_status, int xcc_id)=
  {
        gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
-       gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
        gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index aa00483e7b37..ea142611be1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -700,152 +700,9 @@ static void mmhub_v1_8_reset_ras_error_count(struct a=
mdgpu_device *adev)
                mmhub_v1_8_inst_reset_ras_error_count(adev, i);  }

-static const u32 mmhub_v1_8_mmea_err_status_reg[] __maybe_unused =3D {
-       regMMEA0_ERR_STATUS,
-       regMMEA1_ERR_STATUS,
-       regMMEA2_ERR_STATUS,
-       regMMEA3_ERR_STATUS,
-       regMMEA4_ERR_STATUS,
-};
-
-static void mmhub_v1_8_inst_query_ras_err_status(struct amdgpu_device *ade=
v,
-                                                uint32_t mmhub_inst)
-{
-       uint32_t reg_value;
-       uint32_t mmea_err_status_addr_dist;
-       uint32_t i;
-
-       /* query mmea ras err status */
-       mmea_err_status_addr_dist =3D regMMEA1_ERR_STATUS - regMMEA0_ERR_ST=
ATUS;
-       for (i =3D 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) =
{
-               reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                               regMMEA0_ERR_STATUS,
-                                               i * mmea_err_status_addr_di=
st);
-               if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_ST=
ATUS) ||
-                   REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_WRRSP_ST=
ATUS) ||
-                   REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_DA=
TAPARITY_ERROR)) {
-                       dev_warn(adev->dev,
-                                "Detected MMEA%d err in MMHUB%d, status: 0=
x%x\n",
-                                i, mmhub_inst, reg_value);
-               }
-       }
-
-       /* query mm_cane ras err status */
-       reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS=
);
-       if (REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_RDRSP_STATUS)=
 ||
-           REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_WRRSP_STATUS)=
 ||
-           REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_RDRSP_DATAPAR=
ITY_ERROR)) {
-               dev_warn(adev->dev,
-                        "Detected MM CANE err in MMHUB%d, status: 0x%x\n",
-                        mmhub_inst, reg_value);
-       }
-}
-
-static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev) =
-{
-       uint32_t inst_mask;
-       uint32_t i;
-
-       if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-               dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-               return;
-       }
-
-       inst_mask =3D adev->aid_mask;
-       for_each_inst(i, inst_mask)
-               mmhub_v1_8_inst_query_ras_err_status(adev, i);
-}
-
-static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *ade=
v,
-                                                uint32_t mmhub_inst)
-{
-       uint32_t mmea_cgtt_clk_cntl_addr_dist;
-       uint32_t mmea_err_status_addr_dist;
-       uint32_t reg_value;
-       uint32_t i;
-
-       /* reset mmea ras err status */
-       mmea_cgtt_clk_cntl_addr_dist =3D regMMEA1_CGTT_CLK_CTRL - regMMEA0_=
CGTT_CLK_CTRL;
-       mmea_err_status_addr_dist =3D regMMEA1_ERR_STATUS - regMMEA0_ERR_ST=
ATUS;
-       for (i =3D 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) =
{
-               /* force clk branch on for response path
-                * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN =3D 1
-                */
-               reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                               regMMEA0_CGTT_CLK_CTRL,
-                                               i * mmea_cgtt_clk_cntl_addr=
_dist);
-               reg_value =3D REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
-                                         SOFT_OVERRIDE_RETURN, 1);
-               WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                   regMMEA0_CGTT_CLK_CTRL,
-                                   i * mmea_cgtt_clk_cntl_addr_dist,
-                                   reg_value);
-
-               /* set MMEA0_ERR_STATUS.CLEAR_ERROR_STATUS =3D 1 */
-               reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                               regMMEA0_ERR_STATUS,
-                                               i * mmea_err_status_addr_di=
st);
-               reg_value =3D REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
-                                         CLEAR_ERROR_STATUS, 1);
-               WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                   regMMEA0_ERR_STATUS,
-                                   i * mmea_err_status_addr_dist,
-                                   reg_value);
-
-               /* set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN =3D 0 */
-               reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                               regMMEA0_CGTT_CLK_CTRL,
-                                               i * mmea_cgtt_clk_cntl_addr=
_dist);
-               reg_value =3D REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
-                                         SOFT_OVERRIDE_RETURN, 0);
-               WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
-                                   regMMEA0_CGTT_CLK_CTRL,
-                                   i * mmea_cgtt_clk_cntl_addr_dist,
-                                   reg_value);
-       }
-
-       /* reset mm_cane ras err status
-        * force clk branch on for response path
-        * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET =3D 1
-        */
-       reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
-       reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
-                                 SOFT_OVERRIDE_ATRET, 1);
-       WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
-
-       /* set MM_CANE_ERR_STATUS.CLEAR_ERROR_STATUS =3D 1 */
-       reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS=
);
-       reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ERR_STATUS,
-                                 CLEAR_ERROR_STATUS, 1);
-       WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS, reg_value);
-
-       /* set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET =3D 0 */
-       reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
-       reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
-                                 SOFT_OVERRIDE_ATRET, 0);
-       WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
-}
-
-static void mmhub_v1_8_reset_ras_error_status(struct amdgpu_device *adev) =
-{
-       uint32_t inst_mask;
-       uint32_t i;
-
-       if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-               dev_warn(adev->dev, "MMHUB RAS is not supported\n");
-               return;
-       }
-
-       inst_mask =3D adev->aid_mask;
-       for_each_inst(i, inst_mask)
-               mmhub_v1_8_inst_reset_ras_err_status(adev, i);
-}
-
 static const struct amdgpu_ras_block_hw_ops mmhub_v1_8_ras_hw_ops =3D {
        .query_ras_error_count =3D mmhub_v1_8_query_ras_error_count,
        .reset_ras_error_count =3D mmhub_v1_8_reset_ras_error_count,
-       .query_ras_error_status =3D mmhub_v1_8_query_ras_error_status,
-       .reset_ras_error_status =3D mmhub_v1_8_reset_ras_error_status,
 };

 struct amdgpu_mmhub_ras mmhub_v1_8_ras =3D {
--
2.35.1

