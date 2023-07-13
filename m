Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75370EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 01:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CCF10E052;
	Thu, 13 Jul 2023 01:58:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BB110E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 01:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnm+V9sCNHp6DSmODn//Tnd9mem6h4aYoWRDhfAsnARg6gUgJPla8e7wFCO2aUGF62lisaI3zBGIvpFSwMYVwuDr38/GKQ77wRJwMLGizOAhjHh3h0EjTNJmT8+FJlX+Dnn6BnCDVlmMwCbZ1SnBGvwUQwMV0cfqcyQyNt9WLzbMrTnD+rqrK9zhc8FI2LR9g+dAn8UBHhL5BDOgZF8dMUrY1uXTQg5HImDdbTW6KbTULdSpx/LDRb5R0jV9u93ABxKbra1EbPi7mCuhOS6R318Tk0yUu7QEUlseo5FI6HAlH4ZpQdSRZE5epAIXMe102ow9dt+B50x8fJTYO6YgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAKtZGzIfWPrxrht+QM1HLuymt4O2QOu3ypNy68GQ4U=;
 b=MNIpG95R+uOhkZWM0VCU7k4uXolwnpAKkAVuKy2Bs7Ijm71S2vwnmol8r5gm2+KPJxCzkwmdlqefqavGoxjcEXhfQnVAll1Oi9WIZ4C8ZCWH/kdocyCm2ki7fQiFH60/VbWzsZB8I1QCgpwDzDmAMT921gOLb441q5IH0lT6BpxOVGwnFXza9hVA+szqxRnV9VWi/mZ4qTbfQ0ZY9bcA/A5zPyGYORd+Cj9+itjWwr+I7VR/PC8YE6xarE7E0zzHcOSjOAa4fjIYt+vmD4O4DyFHhdsoC9PPi4G+ccHRapXnlpsmRoNDAydC56riq1OBykWWKbofWmtA3pyfU+VS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAKtZGzIfWPrxrht+QM1HLuymt4O2QOu3ypNy68GQ4U=;
 b=3Kyi+5mHvJwMa5CA9XI/jKRTS91FZshN0QZkFG/4UlFACtqtEFjwqfFUOcUgTUJYagFAtR7Ylm1o+hXAct5WaPZELCaqbD8ojJAyVPeJ6120RGupmqUBczq/yhjdG1sCJEcfqSsKHKNdxW8AnVdn625P6fH+zr4ExgNpc02Z2u4=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 01:58:12 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::46a4:cc9c:3b44:872c]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::46a4:cc9c:3b44:872c%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 01:58:10 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: enable mcbp by default on gfx9"
Thread-Topic: [PATCH] Revert "drm/amdgpu: enable mcbp by default on gfx9"
Thread-Index: AQHZtPFCHn1HxSfkCUGYUmAQ2rSyjK+28P2g
Date: Thu, 13 Jul 2023 01:58:10 +0000
Message-ID: <MW4PR12MB68751708D93D21BE181015759137A@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20230712184646.7955-1-alexander.deucher@amd.com>
In-Reply-To: <20230712184646.7955-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3eb0a466-0915-4832-b728-c944feeee8bc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-13T01:57:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|BN9PR12MB5177:EE_
x-ms-office365-filtering-correlation-id: d6efd8f5-c051-4691-dcaf-08db83449c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btlkVPrJtDaUK8XzPQXV0AkRdNbi9Y9tdW62zDD4XaIQc28AQuizGZHVRFCJCCSvGPvbRQfQI59kApWTzoaymjM0Nl1xuCchJ5R6L4EPAEAgBfxI6tSCd/cpdlCVmi8XMFt+H2LFbOpjQxDxufi4vuLkpXEzYI59kJaaSTuagU+4NhZN3rpD86e0/JvF7CuHY4SHITnaXmdxPhfjOBGnFiJki7Z1gBlua8O/7jNFWr3U89urbp8fbphoHUdCDfcVeEPKCbgWd2h9kOOMDcJsaLemhzlf9AuBeDxVMreRg5LDyfGaucKb7p+ih5KdR6W1z6NBk/aGaQ9MfBXlBMNFqpRENnOuzg3rqt3sW3K6JawsbRTfCYM+JhHzWb+mVSFgH2xYxIIK5qOMElMO5zqhICI0PKtCErF/lq77SIsOXlLRGOM1Jho8AvHGZKPtwkoix87uiFPJ7SuhgLMWvr09IhGcvGPX1RjQgbe6N8pYKnE3Q3m5mxyK56kfW/+3hQZA450sSLlCSjWYqS5W4o54sy8bqHty0e5epayCi5BHWSXWCDNhpdHOcJ0SIxXqzL1dqJFL4urP8dpDZrJGbs8SOG2uY4WROSfMEJzhlKZlr+Jt9KzqbO9wsdME/4wuSQ5G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(52536014)(66946007)(66556008)(66476007)(66446008)(76116006)(64756008)(316002)(2906002)(41300700001)(478600001)(8676002)(8936002)(110136005)(5660300002)(71200400001)(7696005)(55016003)(122000001)(53546011)(9686003)(6506007)(186003)(83380400001)(33656002)(38100700002)(26005)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pakXc4gXMkCBpn1Vp/H8yZ9thzOLgcc+NB097PeFimJ1hxqK2WbCash8zCDJ?=
 =?us-ascii?Q?YvKUcWDcOqtnrpDB/hMmwBTeS+DyYgQeQqAFNv5/REWzYeOhR5kEVAE/h/yF?=
 =?us-ascii?Q?aOyQ0WqCihqVvdIMkf+Ll/MPzX60jYaaxqkjmS8oNXToH+g9tH3RGmKVj29B?=
 =?us-ascii?Q?IP7dXruTKXCvGFBz5kUuyimmaTdQZZ9b8cB/52uuYGTwng2MH5L+mqR/EGqZ?=
 =?us-ascii?Q?unTzs2KezPiR1anNBzpl4Ype5lzJxcG9BuiEFbydQbzY4stkM3XfGPk0MuJB?=
 =?us-ascii?Q?9k0b9hijlgbRgAodiLHzmnb5R5qmvNAUL3w7PWOcZ0mL1vH9a2aQGKFxn0vb?=
 =?us-ascii?Q?tmafGTWPceaDFGZMU/+pVMupAnKOa28Im3irNV6aZL24q5GsU0mRoB+ubQyX?=
 =?us-ascii?Q?P1JFDuH02aBEUPoneAxELlgeknpg/v+DwGSCiTkyYnrE55usxl9x7kub5z6Y?=
 =?us-ascii?Q?HvNxIE0m8AfogKuUfuI/XELGy8QHrV+9PBIKOrSaFUIC2D3GWlS1SwvBBs12?=
 =?us-ascii?Q?eXNfu9cfAF34qgef1lSu8JOKqOzFIM1I2FZy2rbQgOrgRwC1xATcEaxEz2mZ?=
 =?us-ascii?Q?Hvbj/G3c0TgSMbJdwIll49/150GvPXX6Y1yVYTZl9gd8tcwK52hloXw/hMJT?=
 =?us-ascii?Q?N8qKjr4BUOktYraRjCMUsIZDVHDQy1KMoVpztRIV6REUszRLkmutmwigYRQE?=
 =?us-ascii?Q?XOBoNZ1bMkLGiHPT1Qu+nikuVGU705hrY0T7QzsVa7yfImw3A3pDlhLM25wI?=
 =?us-ascii?Q?30eyrth3SJuwiPNpZohPa4ov8YtRgukzgLRHEO2pI5QVQpK4HRdMHywWLjH+?=
 =?us-ascii?Q?gXS6V+dIJ5Yxk5zleNjnJ/mMWD7XQ3z+MdnnpU1Zhs6VWLuqY8NlcULMC8ok?=
 =?us-ascii?Q?ypQ2JSyzeJH92i7b4HMFZa4s8Y+1mO6AHqVJUPG/bDs8ds/TMwaId/BH2oqn?=
 =?us-ascii?Q?Gn4yi/Bn1pxQfVzwNoDR+PIkqXZyjt3WTCoSour7Ap3PU6PC9ayBC3KyH53p?=
 =?us-ascii?Q?SvH0nZ2CFyJ9k17zCKxFPDl3iYGNXZ8J4mDszLzQ8oOlC7IV+Nj1+3OGHVtA?=
 =?us-ascii?Q?pqlCRzglw1pvSQlo3Llt0uN8A8hd3jVIN3SMae7uxH62JY3pIwc0FSGL3kLP?=
 =?us-ascii?Q?kh5crcH8uTYH04RxHAMilurEGarkEvrZPdFtmOySO49tPNXoqHOFIjovp7wi?=
 =?us-ascii?Q?HkGsiClxgUl3uMUdfJgMufzaGd7LqaCPglmRRuLqT2CNGW0TCuYreOSnppP1?=
 =?us-ascii?Q?BCOHR/zWU5qxdMOtdzG6K/KatpQvaIessl/PO2quXw7m0w7SvgEQheyPXRIz?=
 =?us-ascii?Q?SE1iP7ifOc2Z9liOJkrldm2kcKz29vypEt/TjSktXRcLMadrEoL7ZVdRKDBu?=
 =?us-ascii?Q?W6m29cwGiDA/4fEJhI/ZBCypJ7DeYbpOKQ9f9egQiVd59HewwZbZ2IcWR1WF?=
 =?us-ascii?Q?mBMlyN56QO6hPBIJ7HPSCiq0MP2brXYi6KFfz556IoN7lyT3gpmRNY2O/DeV?=
 =?us-ascii?Q?WsWHZ3+TX6rGzdiJ4MtAiiMm6yYvXI7fYvQqs2POBPX9u6HyAfQtIXDhEoaH?=
 =?us-ascii?Q?2KDMJTgR3MNuY+/Lnd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6efd8f5-c051-4691-dcaf-08db83449c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 01:58:10.6650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2GWrkkWo33z78tiK5ml8r+m0BXSaCRSOQL0TR9XSLfnoPYD1Qu6eY2caqwCU/KX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, July 13, 2023 2:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Candice <Candice.Li=
@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: enable mcbp by default on gfx9"

This reverts commit 50a7c8765ca69543ffdbf855de0fd69aea769ccf.

This breaks some SQA tests on gfx9 dGPUs.  Chistian
also reported problems.

Cc: candice.li@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 6 +++---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index bbe4ea93db611..3673015a7f93a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3699,11 +3699,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_dev=
ice *adev)
        if (amdgpu_mcbp =3D=3D 1)
                adev->gfx.mcbp =3D true;

-       if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0)) &&
-           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
-           adev->gfx.num_gfx_rings)
-               adev->gfx.mcbp =3D true;
-
        if (amdgpu_sriov_vf(adev))
                adev->gfx.mcbp =3D true;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 33e370d998a87..f829a80e52924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -180,7 +180,7 @@ uint amdgpu_dc_feature_mask =3D 2;
 uint amdgpu_dc_debug_mask;
 uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring =3D 1;
-int amdgpu_mcbp =3D -1;
+int amdgpu_mcbp;
 int amdgpu_discovery =3D -1;
 int amdgpu_mes;
 int amdgpu_mes_kiq;
@@ -635,10 +635,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx_r=
ing, int, 0444);

 /**
  * DOC: mcbp (int)
- * It is used to enable mid command buffer preemption. (0 =3D disabled, 1 =
=3D enabled, -1 auto (default))
+ * It is used to enable mid command buffer preemption. (0 =3D disabled (de=
fault), 1 =3D enabled)
  */
 MODULE_PARM_DESC(mcbp,
-       "Enable Mid-command buffer preemption (0 =3D disabled, 1 =3D enable=
d), -1 =3D auto (default)");
+       "Enable Mid-command buffer preemption (0 =3D disabled (default), 1 =
=3D enabled)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);

 /**
--
2.41.0

