Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E32C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 21:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915EE10E10E;
	Fri, 16 Feb 2024 21:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzfBidXK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876E810E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 21:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc2gzjRysJpwKXEObDi92RbHRwIQIshqD7v7lNMxOM6RHRXOWdYEKC+WyLmZ9wL1cxohrfcnVmi+8E4JPHRP96LIlD30+VR4H6pNnCBRrAy/RU/RFNjEuuTepIG+tNFAB3eGJ/q1b9+le0Dg/G05ugl10OcLwZVyzcoXDNdWagPnwiAJRHnXHFmlD+sjVx9MsFA8DDSo1pjQZd6uuu1lb5voP6M5bB5F7lN6TLRshtEtpx84hVP2FaqtqXVgigE9IJr2YmSTwJaVwTX6h5Y7tKRyDuLjLrZ/V9fgFTjdaf/VtmXEUTW7VB/sO7oI6LyTZJWuQS1wfKpXV+CXKrjlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcVsJHVCGVhFoJw/hrWenfgHc5Un+7nd7UVMufZmNAc=;
 b=hvprH9ch261XSNvYFsz++xbKZnD8wFNxZw15pbj95JAJEkbw3NXUQvYfnA7JqtWxMwnYBZdCEtLol90MXZlh6V/NjEcYxmWE68NIBD1bMSQCffg3nhwe+oPzhrzNUVLkm8Zg0q7+MfJVwvjqbkbUfrhGxody0kaCP/c1eupIhCq6urA3jIllz8+GngXGpDC1MZARgcQ/T90u/uebVp9SyP+FNmlZdxiyTvqepSfbygVkP5IPE0ythf2dp5OpISzokBGG6+c3ZhwetTocpvxaFl5WGPdDlEICyB2+K/q7Fpwu01Lk732XtB1j/ZB1XFtmF8V+qCZZhMHHz0cpgyillw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcVsJHVCGVhFoJw/hrWenfgHc5Un+7nd7UVMufZmNAc=;
 b=SzfBidXKkjEF3cQhhAGlNs2QxpK/Gd8PabAMsndhvYWlo7O+lJLJUb/0MfvwmvOBkMdC2LWNZr5tzOQtLvh9s0yXoohDW7Q9LHsnxHCQrYTbR4dXGl4c4+0CLA1PRZaB4aVy8q6Y6IrRQeJHAfzr5MWVzDxZ+KAS6xFIT30Ba7c=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 21:10:19 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::b4a6:ef0f:c28b:3d38]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::b4a6:ef0f:c28b:3d38%4]) with mapi id 15.20.7292.022; Fri, 16 Feb 2024
 21:10:19 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for
 gmc_v9_0_vm_fault_interrupt_state
Thread-Topic: [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for
 gmc_v9_0_vm_fault_interrupt_state
Thread-Index: AQHaPaFmkK8z7Mppb0C3XcbpnL0fW7ENlnO1gAAmx6A=
Date: Fri, 16 Feb 2024 21:10:19 +0000
Message-ID: <DM4PR12MB5328796CB1B052628673C7C5F14C2@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
 <20240102173013.5543-3-victorchengchi.lu@amd.com>
 <PH7PR12MB5974D8CA3E8119960CD0F7BEFA4C2@PH7PR12MB5974.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5974D8CA3E8119960CD0F7BEFA4C2@PH7PR12MB5974.namprd12.prod.outlook.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-16T18:49:50.576Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|DM4PR12MB5817:EE_
x-ms-office365-filtering-correlation-id: fe4a14f4-6e1d-4a93-af84-08dc2f33ae54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lI0qLU47uwghqRhn3j0o8c1U6V+4ZWyElZ5PkEl/N79KmBNPBhC3z9REv9p85tihys7x7jyELzYXxrD6FB7seuDiHpFX8eQzl68LMFavv5ndPnPIEdaL8gDGUK+G9AOlvggmJPZFGTwx1zpmCX1CQWduI59m2V1aA7I+4yHwdQkE8kmNi0yzSgCGdphkU+lRERwELXQA+gHgmt4hvUgQzhvpLsHUeks/Gijg1R8MS6aoGZ16fdwMY9LEnkR4FpXsyFqNWbWbXP0IROgGQucFhXCkPRbYdio1lhwDPyu6ChuvXHzqC8XlaxSnIeWy4f9fyL5AxI9FGrCeQiDwJs31VFaiQ2j7RMLnda8XT+/b39GX7zklbEBXoaFrk8oB5vN6swV71Hy1f/qdnlcqey5Ta3ZlT14gcN1czArQTxrJldaCJmCZtTEwLM/fE5mzRP6HgGDcsYv8gpG3Z0n9JzFgpEmXA1808sT6gvaCCE89vML2LBTf+7FiQ7pF0T6wI0XvTq/3QGVH9Dg2lVpJGVW1wrBeiwQLGhK40iqmBVDRH7KLzVUaawqIeP+b9m7YLQkm5D9RkDmhe4I0rkTx8jVoQLQ/+tRpVzEdt0BhIzJts951mblJzEeexFJOWuQvNWwV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(8676002)(2906002)(66556008)(8936002)(5660300002)(64756008)(66446008)(52536014)(7696005)(122000001)(26005)(83380400001)(38100700002)(33656002)(86362001)(38070700009)(53546011)(6506007)(66476007)(76116006)(66946007)(6916009)(71200400001)(316002)(9686003)(478600001)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s34PMOnXnsE/AchV13KkdvFoxu4AxawwTCkdtTrXZV+4lTVmwIluh1RRkDhM?=
 =?us-ascii?Q?FskOLyF/ykeWHVTJUYiKOfvxF+0FMquSHICwJXAUBoDS42tcdqvlX8KO8unv?=
 =?us-ascii?Q?IuiiqNPkI8o2MVJSSPRiu2Yfg8CA2HaFsGpgObsaTONhzDulVMaHVsrkseJS?=
 =?us-ascii?Q?j81SN4//1U5R+EeWfvkgJ6nPoFLtbimnxWFDpDumoapLXUoOKDfv4EBOtAah?=
 =?us-ascii?Q?jJ7j16HRnJh0Z4ynOUIg+FV4Ok1tEOKliEl3C88TFo7PNDF0BXYbA8m43hxx?=
 =?us-ascii?Q?wJ/6MTClLy59HyuxSmf8pSbPBStDmktDWaYewimzu+UaGF088aQMuEEu7NNQ?=
 =?us-ascii?Q?LN61EaaOmEcX3o1FTttBH9WAd+8mEml6l79eC0XypxOuotB2NGbhhIHRNL0s?=
 =?us-ascii?Q?JqgbTvcsVlA0tPKQ38Jdy5FvVOOCBpQoV+4eRpCAOnZtGD1l2IJSrov2zz3m?=
 =?us-ascii?Q?WNAFsolLgFuD6QEZoxgXYnATTluB8rbyhTOWhVBMQ+dwdZNShWQ8/uWMPpFA?=
 =?us-ascii?Q?Dc+AG5fUJSQemO/7lyu9h4F6Gyzv0+UX7NvkQm/V8xi8Pom8VdGYn5YtTSeV?=
 =?us-ascii?Q?d/Iqx4wW0hecoTuxhftUOvnky/j0D/NWyRIFuat5yIEaN5SzY8g75RfkX7hF?=
 =?us-ascii?Q?Yp5yYM1SUfn8yWk0a9gx6MoaTBIGupc3QFOLRbHBzgiK1UcUoZL59hTekgwc?=
 =?us-ascii?Q?4n1W5fjav/HG5yJE1UeNI9xMtP7n2YvKUQ27BuaZ+dwyi5cKr+d8NhBQI8NQ?=
 =?us-ascii?Q?hznivTn1xGyx/teo6iqPL0LHMN3DblWgAG+posXTf1u4DRDowlit/w6qcwEU?=
 =?us-ascii?Q?QHwqs6m6mnEs7vfxRTudYMiVTIu4fB5CUmfLdL8k7R9/AomGqCWzpHm61Gh9?=
 =?us-ascii?Q?vVnsVpkDNPy3ICbc55IS3K0bxtbjJ+MSZC1sVbjuVnuJ9VNPZHzNbnPvO0LF?=
 =?us-ascii?Q?6aYzTU8HDL94dlU9+fs+djkPVKJjp3EcXxyaTRVmHFIBCd7rmUAVO8jrdIa/?=
 =?us-ascii?Q?1FJorruGYh9dd18vQWzX6DfkEYZrb6tVWv/fE3Wu5OYi2lof2Xq1KaQH5tZn?=
 =?us-ascii?Q?Fw4FEYVNlGa0zQARhh1Lzhne/yFn6ydXPmsc8yzLCAwq/DmUL/e41fibzqQl?=
 =?us-ascii?Q?hiiBtl+mB+EiRPGb8dzbf/I1wu6uMFai0EJQKGxzYbMbCH7Jxx0hXidxv/Do?=
 =?us-ascii?Q?LUmZTSvXiTGznRQvShh4YoiEsbipqf/WBB4pVPHcmhIhMHe4KbSXlozSE91Z?=
 =?us-ascii?Q?X0UumU719cAzvF8BQ7oIYAqSfYa+FtWiz1vnXxKOv+iiRg+rvpzGAeNsORZu?=
 =?us-ascii?Q?aUmWhxzkDeZr72mvL1Oo4jHtA6AvS0JYYT91598gMJda5K0N8qNJcTTt5mk/?=
 =?us-ascii?Q?3pnpreO3ZcYq7WlS1woQfFL7E7z1JTA9letxDCVFmxo8AU8ImZm7A29OyfuV?=
 =?us-ascii?Q?tPflXDL/kd1tJAiCi6mgEjh9VrdswMOatUxFbvkMdyzHblFm5GSIuvQT7LC1?=
 =?us-ascii?Q?EbxkRnuiXAWapV9HO/2CZfnTjVfz3bxhrQ//uJxluKZT1NUbs4mTF67ts8we?=
 =?us-ascii?Q?JCIRpGCv0C8VTfs7i6I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5328796CB1B052628673C7C5F14C2DM4PR12MB5328namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4a14f4-6e1d-4a93-af84-08dc2f33ae54
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 21:10:19.4202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tufHx35IU3GzHetXemrdHvZbNySRo1CIbfsN2+MGEF7JKK3av8w6dnPtGl8YUQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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

--_000_DM4PR12MB5328796CB1B052628673C7C5F14C2DM4PR12MB5328namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed By Zhigang Luo <Zhigang.Luo@amd.com>

From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Friday, February 16, 2024 1:50 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: Fw: [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for gmc_v9_0_v=
m_fault_interrupt_state


[AMD Official Use Only - General]


________________________________
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com<mailto:Victo=
rChengChi.Lu@amd.com>>
Sent: Tuesday, January 2, 2024 12:30 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chander, Vignesh <Vignesh.Chander@amd.com<mailto:Vignesh.Chander@amd.co=
m>>; Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com<mailto:Victor=
ChengChi.Lu@amd.com>>
Subject: [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for gmc_v9_0_vm_fa=
ult_interrupt_state

Under SRIOV, programming to VM_CONTEXT*_CNTL regs failed because the
current macro does not pass through the correct xcc instance.
Use the *REG32_XCC macro in this case.

The behaviour without SRIOV is the same.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com<mailto:victorchengchi.l=
u@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 473a774294ce..e2e14d40109c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -496,14 +496,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct a=
mdgpu_device *adev,
                                 if (j >=3D AMDGPU_MMHUB0(0))
                                         tmp =3D RREG32_SOC15_IP(MMHUB, reg=
);
                                 else
-                                       tmp =3D RREG32_SOC15_IP(GC, reg);
+                                       tmp =3D RREG32_XCC(reg, j);

                                 tmp &=3D ~bits;

                                 if (j >=3D AMDGPU_MMHUB0(0))
                                         WREG32_SOC15_IP(MMHUB, reg, tmp);
                                 else
-                                       WREG32_SOC15_IP(GC, reg, tmp);
+                                       WREG32_XCC(reg, tmp, j);
                         }
                 }
                 break;
@@ -524,14 +524,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct a=
mdgpu_device *adev,
                                 if (j >=3D AMDGPU_MMHUB0(0))
                                         tmp =3D RREG32_SOC15_IP(MMHUB, reg=
);
                                 else
-                                       tmp =3D RREG32_SOC15_IP(GC, reg);
+                                       tmp =3D RREG32_XCC(reg, j);

                                 tmp |=3D bits;

                                 if (j >=3D AMDGPU_MMHUB0(0))
                                         WREG32_SOC15_IP(MMHUB, reg, tmp);
                                 else
-                                       WREG32_SOC15_IP(GC, reg, tmp);
+                                       WREG32_XCC(reg, tmp, j);
                         }
                 }
                 break;
--
2.34.1

--_000_DM4PR12MB5328796CB1B052628673C7C5F14C2DM4PR12MB5328namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F4E79;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F4E79">Reviewed By Zhigang Lu=
o &lt;Zhigang.Luo@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F4E79"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lu, Victor Cheng Chi (Victor) &lt;Victo=
rChengChi.Lu@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 16, 2024 1:50 PM<br>
<b>To:</b> Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> Fw: [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for gmc=
_v9_0_vm_fault_interrupt_state<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lu, Victor Cheng Chi (Victor) &lt;<a href=3D"mailto=
:VictorChengChi.Lu@amd.com">VictorChengChi.Lu@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 2, 2024 12:30 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chander, Vignesh &lt;<a href=3D"mailto:Vignesh.Chander@amd.com">=
Vignesh.Chander@amd.com</a>&gt;; Lu, Victor Cheng Chi (Victor) &lt;<a href=
=3D"mailto:VictorChengChi.Lu@amd.com">VictorChengChi.Lu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 3/4] drm/amdgpu: Use correct SRIOV macro for gmc_v9_=
0_vm_fault_interrupt_state</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Under SRIOV, programm=
ing to VM_CONTEXT*_CNTL regs failed because the<br>
current macro does not pass through the correct xcc instance.<br>
Use the *REG32_XCC macro in this case.<br>
<br>
The behaviour without SRIOV is the same.<br>
<br>
Signed-off-by: Victor Lu &lt;<a href=3D"mailto:victorchengchi.lu@amd.com">v=
ictorchengchi.lu@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 473a774294ce..e2e14d40109c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -496,14 +496,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;=3D AMDGPU_MMHUB0(0))<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tmp =3D RREG32_SOC15_IP(MMHUB, reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_SOC15_IP(GC, reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_XCC(reg, j);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~bits;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;=3D AMDGPU_MMHUB0(0))<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; WREG32_SOC15_IP(MMHUB, reg, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, reg, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_XCC(reg, tmp, j);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -524,14 +524,14 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;=3D AMDGPU_MMHUB0(0))<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tmp =3D RREG32_SOC15_IP(MMHUB, reg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_SOC15_IP(GC, reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_XCC(reg, j);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D bits;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;=3D AMDGPU_MMHUB0(0))<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; WREG32_SOC15_IP(MMHUB, reg, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, reg, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_XCC(reg, tmp, j);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5328796CB1B052628673C7C5F14C2DM4PR12MB5328namp_--
