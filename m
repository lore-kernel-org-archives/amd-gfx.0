Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E868C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 22:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB6910E7D9;
	Wed,  1 Nov 2023 22:15:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECEFD10E7D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 22:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/rcm4Szyw3QcPdT1+NXg6DgzZ8UAdIaBAb54EQUaM016X255Tpw2OOLlIW/hbUy/nJXBvNNnbkankQ6NZ2sjloAY2i/9xnj9rsRJ/8ZKNmkWUTNWaWxG7Y/QWr53SGL/G+G2KmekQ52LJV8bMx4KGNy7lgDiMq1dmFfzTX0IK/gzmlP+Zu9FK+xY1+jubRWlFYq3A7y77iuhUDfIPV++nLi0Et+rvTb75xE04KgtOyI3T169nhqYyEjPrtsMOu92GGUakcQsBTjeU4+0nDpiMYPqn6j32guPcX1iubXAuYfmkrbPt+RzKv28tsmv/j80V0ZLo83e/sqV3S5p/vuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY3pEhLHfrpG9ItSn07Scx6CWlX6kTwpYP7TMFJ2lxE=;
 b=AImR11i+wN7XLMmht98GHIDv6T+cnzKf4xcStSapiC9VfqosFoD4C79Z94yohCv+cMOykCS41aRbUmTRQMCuIqgthLS72YKzB24cY1GUIqC9FUosKE2GzyE8tlPaR5Zu0rg5zUxKFOp1e7E+82BLIuV/QpOvoDdmPnEf/sJJD+Ldy0CF/WwnxFyYOL+QjablluVftw80abpdCHyG904ZCPdaRIFT6TiXX04LhiUv0VI1dd7kaSLZPFEAj5PVjKRf3/HkRP+pAYiAWfMZwTl/u+t5ta2wHzq9rQ43Zw3f0EDJCVbv2hskegj6/9k9oqf2eXvFNV7DWmckSrZdFh4vLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY3pEhLHfrpG9ItSn07Scx6CWlX6kTwpYP7TMFJ2lxE=;
 b=1HWFIbI4kTAC+VTxloRuPRESZTS8GymYrcAg9y7oy+eDOI/pppb61mR5cjtEq2IgQf7BCtqjTxS8ntHNkTigFloei84DKLFJhs8ie8zKejfG3M1me5efWWMe6mfb8qdf0WuJ1GaydwGB71efyu8hDUDhTGyKLB2D3ISNGxLLG4k=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 22:14:57 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6933.025; Wed, 1 Nov 2023
 22:14:57 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/smu13: drop compute workload workaround
Thread-Topic: [PATCH] drm/amdgpu/smu13: drop compute workload workaround
Thread-Index: AQHaDPypNE1Y4k/1pk2aX4sprmuACbBmB18x
Date: Wed, 1 Nov 2023 22:14:57 +0000
Message-ID: <PH7PR12MB59974AAF1C322B11F9D4418382A7A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231101194958.3526118-1-alexander.deucher@amd.com>
In-Reply-To: <20231101194958.3526118-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-01T22:13:41.8837571Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB7769:EE_
x-ms-office365-filtering-correlation-id: 823730ad-47d8-4ba5-c7f2-08dbdb27fb6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcOMifYFHa5JdenKdbGIe00GLY0e6pVs3pwO2QyssGheATnc7NJUyN/7+gxP18LNlVZQ2q3TFWrfdga+y5JOXuazwrOAC7kQACw5RSRxt5hNLldIhxdKQjQKpaf8gR2dVXeE5o/ZYceYIk4WQN/iS3sw9AOnHPE87Ha7lUXm5dd5AFoB96JpI0kTt8Itz/RqL6/N02DbJ60xWbha6lgNf6Yzdqpnj2FX411LGTp6/5oiq5ZatQfIPnubjGiEkJUXNfLWHpijrlk6x38cWGL/y4A6xzK2HZLkLvjJwd+TfyGygDSeDfEuPGvg3i1yDuJXQjqNVnyrFSK8bYNL/X177Hkq0DxnuaRwe57Hp6Ly4JBzQWTpu1oG6saN4/aq/3cMZ2DC45tMpFG1SpTsHu73KJJiCbeHCi7Kxuni/ZxdzmlYwlBfrfOUrYDtQTFPPQGS9pXSwiqatozayZS7PgbwVQYHoPT2ZsrPEDUbc+aV1GrG92Tn1T2JidDNZg8+FH/i8nhMkRJDH/1qiThLavJDNRiJ7jym7WXFq3plgvFHlhs3EXonVQKmu5lwgBPUGcQkM60g80tvow1CzSx0MMwZEj9l3H9kY2LAt6NxScTwurdRw3TOJFaURzRcxx3xeLXrAr4hb6vN+8Gfg1i6OSwWB9tyQO9en00tdpiM7kKMxjs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799009)(451199024)(186009)(64100799003)(316002)(71200400001)(55016003)(2906002)(33656002)(41300700001)(38070700009)(52536014)(110136005)(8936002)(86362001)(8676002)(4326008)(76116006)(38100700002)(66446008)(66476007)(122000001)(6636002)(6506007)(66556008)(5660300002)(66946007)(83380400001)(26005)(478600001)(7696005)(53546011)(9686003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGo27ZryFqdVck//CNSOYGrUccxqbVdN/WYnZSCp1cnUGLqBRQin72tYzUhX?=
 =?us-ascii?Q?wTxatMEMCxK6LXWT8liw/NAtuXZHkrzA8VhKz35ZRqgORgmEJa9j8JYTiFiO?=
 =?us-ascii?Q?gWgy2/mqKMHkd32ymSggVpvLV032fpOR+0bkMTfkcW6YWs0tyNAPGM2Bq+7G?=
 =?us-ascii?Q?3Aa/XXu7JT0+t4yqZCcElqhx66ICm+ja3U4NrL3PLy1SaHGPQBjbvULPAOeL?=
 =?us-ascii?Q?gWqCXpGE97slSebR6V9+rtjT7d9UbJL8YiijUep4nEpwoc/rh+d9jotArPNK?=
 =?us-ascii?Q?pUS8iJkVvVhfDu8LQvvRn9G1dlJIQDV9xczyJ88EjrC7g8VBwz1MV3YdSZ5f?=
 =?us-ascii?Q?czsul4E636hr6F8Tk4GC4K/J9b4MlihZOpkaM6hOsPoGiH6SQGXQVA98QMBR?=
 =?us-ascii?Q?D8dszFqnP381Kji3IsaxExgig8UDKVRWavn3/2pjKfyrvuQic4hTisw6vPKQ?=
 =?us-ascii?Q?QDxwsCyH7cXIoXAtI3D2nsIjf7+y3Ku4x/S2Oq9DczkCkB3y0sk7q/YFc+pK?=
 =?us-ascii?Q?zDz/x/tjf+ddukGausK3dEuEFovjswVZRJW9VT/l2GEbR8dSnLt3JGvWuQ9E?=
 =?us-ascii?Q?R9VQunsq8rJcJs372UMFN+CYIPiRMuaXPD2ST4aFAn/3+2O5Dv5cMVSOzYrA?=
 =?us-ascii?Q?YJxXq8h0pS+9oNLV45mIiP0H5u11P5m6LPL6sWNhXSG0TSANiTkHcNNL44t5?=
 =?us-ascii?Q?IDNMSpuaznJHQYGZw6t4AR9nouxsnFD6PA2pUH1qoji6FkFCCH7o+7Wt2IMC?=
 =?us-ascii?Q?Ss88EFCc3/69VUOF74wVbaWjNJ8HS2JE2yB7i8YgsGhBmlwRnlT73hg2mxOn?=
 =?us-ascii?Q?LvJ8HsnTJWxM/S6vCQB8Xnm2uJMI2WcdSCDeOScPNDmI51SseIuSxZpcd/JH?=
 =?us-ascii?Q?Y/+LrYuMMFulclnXxn8v07t7QjFX2DnYkeEDWV0UWEi4d/aJ5HjgnIGytGqw?=
 =?us-ascii?Q?GQQ0qBhVt60SFMgKsy5g2tZGM0BCX75REoXVnnlN5MVlSt2TVywgeAgyhtkI?=
 =?us-ascii?Q?khD6ysFqWTNj3Ak+P2sC0oYjIleFTPj0u8kDQtZoAJv/G5gGFDCaHqKqGGai?=
 =?us-ascii?Q?JvYc5Y8rZFI/T8bI2MUCzu0jpBPwHKqCC6p1z7pFtP4o1q3tBUfI/AA0nuVn?=
 =?us-ascii?Q?N5b1wApANYV31k81CF6hHV3UvOykX1Z2xBtcRhQoijmSeXnpPoKVU+MVUam1?=
 =?us-ascii?Q?qwaQ57Zm1nlVep+7Ibk79Y54b/dQDe4PWSZ9PRLiCL5Ej0xwJxbOruswXbY+?=
 =?us-ascii?Q?oq0ptDrt9ZjXJYkUF0tHaK79h2MX4OaCfdKT9hMcke9JwZxdsTVZ6Noqba7G?=
 =?us-ascii?Q?49/1hHKpmd5adbAPOUzOOEHrs0nK/U7s1Y4dHG/XWy7zGvlSOr6C0/NwZe9c?=
 =?us-ascii?Q?fAjOyMo4GCv9UP4ALkCtDhF9bWTTZYVZFhQRHqEWx2Rn4H+WKWMM737nzegK?=
 =?us-ascii?Q?BB+GBHOA9RIx3M4lojs+L3RbRKyPHY+gjRVsIkllC55PimOVfM+lSG4BdDlU?=
 =?us-ascii?Q?P90v/D2/lXUnyqkm+DdctNC0B68F1eqzDr5WKNZzgB4VlS7vg0+Vuq4ApdWF?=
 =?us-ascii?Q?S8Dq8x68f75YVBssEqdZW1RJW4Ma+ipKbzlUmEvq?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59974AAF1C322B11F9D4418382A7APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823730ad-47d8-4ba5-c7f2-08dbdb27fb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 22:14:57.0929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cr9qnUl3gtSQ1bBUP+vypnIKBMzdxv+a9XTklwaCAHxmKsumm4RiL0HopavTxsDc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59974AAF1C322B11F9D4418382A7APH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Thursday, November 2, 2023 03:50
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu13: drop compute workload workaround

This was fixed in PMFW before launch and is no longer
required.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 32 ++-----------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ef0c30075658..82c4e1f1c6f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2530,38 +2530,10 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
                 }
         }

-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
-               (((smu->adev->pdev->device =3D=3D 0x744C) && (smu->adev->pd=
ev->revision =3D=3D 0xC8)) ||
-               ((smu->adev->pdev->device =3D=3D 0x744C) && (smu->adev->pde=
v->revision =3D=3D 0xCC)))) {
-               ret =3D smu_cmn_update_table(smu,
-                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
-                                          WORKLOAD_PPLIB_COMPUTE_BIT,
-                                          (void *)(&activity_monitor_exter=
nal),
-                                          false);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to get activit=
y monitor!", __func__);
-                       return ret;
-               }
-
-               ret =3D smu_cmn_update_table(smu,
-                                          SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
-                                          WORKLOAD_PPLIB_CUSTOM_BIT,
-                                          (void *)(&activity_monitor_exter=
nal),
-                                          true);
-               if (ret) {
-                       dev_err(smu->adev->dev, "[%s] Failed to set activit=
y monitor!", __func__);
-                       return ret;
-               }
-
-               workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                      CMN2ASIC_MAPPING_WOR=
KLOAD,
-                                                      PP_SMC_POWER_PROFILE=
_CUSTOM);
-       } else {
-               /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-               workload_type =3D smu_cmn_to_asic_specific_index(smu,
+       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+       workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                        CMN2ASIC_MAPPING_WO=
RKLOAD,
                                                        smu->power_profile_=
mode);
-       }

         if (workload_type < 0)
                 return -EINVAL;
--
2.41.0


--_000_PH7PR12MB59974AAF1C322B11F9D4418382A7APH7PR12MB5997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behalf =
of Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 2, 2023 03:50<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/smu13: drop compute workload workaround
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This was fixed in PMFW before launch and is no lon=
ger<br>
required.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp; | 32 ++-----------=
------<br>
&nbsp;1 file changed, 2 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index ef0c30075658..82c4e1f1c6f0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2530,38 +2530,10 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;power_profile_mode =3D=3D=
 PP_SMC_POWER_PROFILE_COMPUTE &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (((smu-&gt;adev-&gt;pdev-&gt;device =3D=3D 0x744C) &amp;&amp; (s=
mu-&gt;adev-&gt;pdev-&gt;revision =3D=3D 0xC8)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((smu-&gt;adev-&gt;pdev-&gt;device =3D=3D 0x744C) &amp;&amp; (sm=
u-&gt;adev-&gt;pdev-&gt;revision =3D=3D 0xCC)))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ACTIVITY_MONITOR_COEFF,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; WORKLOAD_PPLIB_COMPUTE_BIT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (void *)(&amp;activity_monitor_external),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;=
adev-&gt;dev, &quot;[%s] Failed to get activity monitor!&quot;, __func__);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_update_table(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; SMU_TABLE_ACTIVITY_MONITOR_COEFF,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; WORKLOAD_PPLIB_CUSTOM_BIT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (void *)(&amp;activity_monitor_external),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;=
adev-&gt;dev, &quot;[%s] Failed to set activity monitor!&quot;, __func__);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; workload_type =3D smu_cmn_to_asic_specific_index(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; CMN2ASIC_MAPPING_WORKLOAD,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_CUSTOM);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; workload_type =3D smu_cmn_to_asic_specific_index(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* conv PP_SMC_POWER_PROFILE* to WORK=
LOAD_PPLIB_*_BIT */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workload_type =3D smu_cmn_to_asic_spe=
cific_index(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMN2ASIC_MAPPING_WORKLOAD,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (workload_type &lt; 0)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-- <br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59974AAF1C322B11F9D4418382A7APH7PR12MB5997namp_--
