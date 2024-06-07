Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524B3C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 17:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CA210ECDC;
	Fri,  7 Jun 2024 17:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqJjV8V1";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9850B10ECD2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 17:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvukZI1Fqf6vJ0V1yjD8Ile7kyvT02RQK08Q4efwufAhIZFLWITKXsxTGML3w6H2lbMddTjg6OH5ZFfI0UWBS4/bPcvqHArR7x6veZgZcCwT3CX0YBwvPxyuVBc+4sS0re0g7IorWwSzthu6zHN8vwCh/fZOYwck6/OsaD1tkfq6621cQ+wp9zUGz8NAye2ZKy+CeLZBPFxMwt+qXHATDbYycJa8fHUIlgTxAOvKMcsTCBz5/4X7uKPTH8Usu9tsVvGokmMHgykClg7nbtCjwiXajehlMNK+VUUmphO0hEWhczI8dSI+eDT50yesHjRNRmoe7SPIfim3FD4uMUeP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4cHRFED2Frz1OOlVWll2DWF1vtDN0Gq6Yp6OjB1loc=;
 b=Vx2lCubW4MW6PBj488vjsxBM6FTY1VIdrEE79a9+1tVUtJtMjlSaQpdzrnttdT0YrnDfKQlYvK3Kkx9AgbxjlDXFX83nmV5rSU6wAtJUEYtN+PGurwBWoW+x67889yYsGZhpeg/yk6EJd5RGhhC4dmP3gi2ARxNTPetB3jxZzMOY5uGyEBLA3gluRJvw0lRCjHsby1v8Tw85mnlCop7cnZlDMtbv5/bD/K8wRSTIv+4sSEfHQYgGn9UAA7wVI/XaNLHXlOWoVSJ3arAlSWfAjOQ/eULw98rMV/e3GDDOFl0j0QW2xIwDFDd9aiQj00e6i/PIrh0bxWBo5VJN0jgUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4cHRFED2Frz1OOlVWll2DWF1vtDN0Gq6Yp6OjB1loc=;
 b=JqJjV8V1Ulp1lVGFJLhoR1Dv0xG9AFzyMX3fM0/D50/ruGLGX8AZ1XvxyTR8+YRwneb5KO+Kozju8cHyHkD+rcwr+fZOYdm6PtcRZk27kLlW4rRicKYqjHW4ENl4QrGsG/UrCeKqoFaSOmb3py/W2ecCU8WU2FGFTMseGejAYIw=
Received: from CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Fri, 7 Jun
 2024 17:36:03 +0000
Received: from CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929]) by CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929%3]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 17:36:03 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Li, Sun peng
 (Leo)" <Sunpeng.Li@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Choi, Nicholas"
 <Nicholas.Choi@amd.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>
Subject: RE: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb'
 before dereferencing in amdgpu_dm_plane_handle_cursor_update"
Thread-Topic: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb'
 before dereferencing in amdgpu_dm_plane_handle_cursor_update"
Thread-Index: AQHauPiONmfMOvG8E06an1c1V6TJh7G8kFtQ
Date: Fri, 7 Jun 2024 17:36:03 +0000
Message-ID: <CY8PR12MB7415746CC9E1558505842CFA94FB2@CY8PR12MB7415.namprd12.prod.outlook.com>
References: <20240607163359.18299-1-ivlipski@amd.com>
 <20240607163359.18299-2-ivlipski@amd.com>
In-Reply-To: <20240607163359.18299-2-ivlipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c1954cc1-6467-49e3-8984-3c4f0e772b4a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-07T17:35:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7415:EE_|CY8PR12MB7195:EE_
x-ms-office365-filtering-correlation-id: 3d6577ad-64fc-4091-f11f-08dc87184dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?U+Ewituojh+ew893OpittTMvgdhAKtXtlF+pswZMKyBuay1gWPibqKQb3QGy?=
 =?us-ascii?Q?8sug4yz4JriM/v7ocrtoyVzmDK/upElTOSTHnnhvFiM/LM93PIjPo26wJgY3?=
 =?us-ascii?Q?CxjzWwsWVIzLmDi8QIHaZYvJ15BFCbTRWWLh1T+c7SDCWv+nilUOiane5EFS?=
 =?us-ascii?Q?m3dkxWSdIlw4zVOvfqyabjZqSLHlqG9htlVJV11s6t+AF0Dua32EOqoBxL7i?=
 =?us-ascii?Q?fYGTV4kMb/cSd8+TZXqtL2RlTiHZxP8l94f/XYj6oSnT47IIYERopF1XhPP9?=
 =?us-ascii?Q?Nbikqg0S+1x7rrnn7d6kZufA7zuEibqIPzEWl/FYAi1xBQ6oMPsgDN6FAlRv?=
 =?us-ascii?Q?WY2X8IEne+0F6kGveCT6rjiZ4kL7+Icswj6e7fp5EFSz+X4sjR3iID44eRbC?=
 =?us-ascii?Q?46an/rHKPEQ0fh+9soLpmRcCmq+v32DUE+8RDj0v9by339JinMXKobuohe5g?=
 =?us-ascii?Q?mvWjngZU6+M6eWj7Na7HToP8GcElxSindWkGiHqIK38Y8jM2NlhnqvtaVYKH?=
 =?us-ascii?Q?x3S4A3OjUzvb2dOZkRf2QngTBLWJ3yQui0VQxxkRQQp7+vIJWQHtLlO/YsKS?=
 =?us-ascii?Q?jLUmxr0A7vfr10NDv1NqaY4zl1YuyRW22xNkYcRZMo+QYC2BUJoaXxz8bocZ?=
 =?us-ascii?Q?/YyNNc/vxBZ/gW+nbuihNo7za/S1ZUVQUODI5np7val/B6qzwHuLRcBDHkZ2?=
 =?us-ascii?Q?OUtdiHRKPob41Xi3vLAfcRMwgoWiohti4TCC2H09XJSli+sMXfTts78A3BCy?=
 =?us-ascii?Q?vy2mNbBWpooxmBsacZZpl+xMryD+fusz7G5MGTzfAtOltatB42AK7lZDJuvr?=
 =?us-ascii?Q?puJ6uJNYLeQEGk0fOEKEBLH1zm7quhBrVbh+tm2RYgGrBjsHlM/gJ7dTtEmw?=
 =?us-ascii?Q?/il3rjmGIK9LF+7DE63szchXZt7CD1i4pTyPgO8Pd/RIlyWX8HuZKqTiEHCU?=
 =?us-ascii?Q?96iakOwiz8uInbWZcf9QRuPuK6CFlYyB5rVFgR1bB1pUJBEC5tRjWqIo5Ekd?=
 =?us-ascii?Q?MfRRHfaLqYWgYlPoWsMic9Kzy/r5O58StmMFpG4g4zv7zJDZ6vXroLUZRAzT?=
 =?us-ascii?Q?9SMx0SN377ckxGZt4XLD55ZQgoaMLW1QrDhJNgreoqJBxlU4kQjt/+xcHpmD?=
 =?us-ascii?Q?MRkvGKo3zb0D3LPXeTPr8h7HtPBK8YsPggDTTiEjzUMGXaPpfE6CyyCyJfAI?=
 =?us-ascii?Q?5/ugV4TDEk0rPY5aIvjkYo6cHd8XomHSUPwRo8USZLCoQfNvCErYjNzfqJ/1?=
 =?us-ascii?Q?sVD1fA/qu7UWkhEmVY2iB9NQjTgitxP0A8+3Xejec2sD6HnO6I3nVUuCY2eo?=
 =?us-ascii?Q?cN2H4vQ3eCCv/vlU4ZTtazostOTzHgoaHyHCseyJUdkO6+3AIXMejqBYOs4B?=
 =?us-ascii?Q?byzL0uA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7415.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PvGEzqnu2mGWJkJD/XthXN1YUQCOhHaHDoOmQMf60UIua79uejB3uuo1lfo?=
 =?us-ascii?Q?H65LUEPaWNcpD4kIvMOVaf4DcIWmyBq8Y2MN/ngqa3SGTs+LB4eWK+AFkZ7z?=
 =?us-ascii?Q?8kLNWH4u1jKGWp2U3F7NDj9Jg6ifMxmYUWnyOztmuAqB5ik9Ot91DCZlQGPd?=
 =?us-ascii?Q?4WbJNyVdla7PJ2zFSDarQghmuG6Op4vKJHZeLJTjRJUyqk7qRn9mgAoVRogj?=
 =?us-ascii?Q?IemRCzUA9fuzifDsEj3v2whWcHnfAa6eCQZ7GOow1CLW2NuKSYMYweJwmrze?=
 =?us-ascii?Q?pov38Ro/5gp5JOGd8K+pqSvp7Wy0SO96Hxbi8mcSxD+0XseinCPj96WgIpA4?=
 =?us-ascii?Q?jVgdWvXeAQlgJO13w7sQcBPsygrZ7HpKspIK3LWGLqpiiIfo13p7OpHfW6rg?=
 =?us-ascii?Q?+hebSqmbTGWp79fj1DzfsAUOGh1b3DIhNOq/W0v2qCoRw50DXAAIXjt1+gH2?=
 =?us-ascii?Q?GhDeLnRWkeM+a7djdAqyqhPvPTNUbpygl0cSzPBFbb4Wm/Nymw5JOjl2xSo4?=
 =?us-ascii?Q?1C7SaWgbhbdtuZaECGywePNgD1DCGChL/Wx8kNi+s4/6rtySdZR7StX6XDhE?=
 =?us-ascii?Q?vOowl69zYLZpOPytB0C43CHxykqPLULuyk9Cxv09x2U8CLYguL9P/OkMklsk?=
 =?us-ascii?Q?jotAcXJd/5IeVTo04AlcJIhC5trdoxMdwkpya4i7u9ntBNpQYqYEYS7zpWrQ?=
 =?us-ascii?Q?LHGTXWIPOe16EZ+1d7Nt48aDf3vdaaftou9WVUgu/PjTlJ63JFN0wlO9pgRw?=
 =?us-ascii?Q?R30t/kU1DGetc4YLtXHomN4FOzd+waatzHDyJIv+yGjxCE4MtuPug0pR+daZ?=
 =?us-ascii?Q?yumpG6/6ihyoFCqgv9cz2ULTG1dVpQydRqM/2nYTG0qTVdAMfzazdL6o/dCM?=
 =?us-ascii?Q?HMip8n7YFr45xNN5lYCha/mz3+EwFgYrPl8KITdlEOixNvuXxoZtYi3mDHIw?=
 =?us-ascii?Q?RLsvYXg6HL/zApZ8BZsgBiH9HxanITMzdufle/Pz0YHSrp/KCE7YuopwQGhT?=
 =?us-ascii?Q?KieyfCyZN/fRhmgLg2el6Dldbq4FGrdzSGV2V9PMhUbVrO6l+m6rWXyu1Osj?=
 =?us-ascii?Q?rGldGjYF4XxStZgo/BeFcCW8BGkLbXpOTA5NB4LJFDZksMm1vOci+NR/NB++?=
 =?us-ascii?Q?qN7dSAZ5gJThLbeJ7HjnaWW/B0DItUgYTuWXbCoQf22lTOXM+lCe4IcmUAZM?=
 =?us-ascii?Q?GM9mDS3BwTY2RrybYRpPZXh1afrQWgxhwSXz/5SP04tXJQV6XpU2E1lKEUnB?=
 =?us-ascii?Q?ALX8+dRSdKy7CHJLF0QUQKzJiOmm7n0PaOegEs2Tf9WJ/YX5Rcyta6Joz6cV?=
 =?us-ascii?Q?STVyVzk7Pci/kxyss20pq3suRFf2RWguQzzaKmlayWnv2RVD1tEpwCddt6Q/?=
 =?us-ascii?Q?2PLB7IAr2WzfvWLpAJ0WcJaGKniZ7S9qmfP0jpG0V6ePpI0VZysD/tCASfYN?=
 =?us-ascii?Q?tiXSAHVYML4w74qekOcrJhUMjvFVCQZlfcA0/mxSL9eChlACkEVeDOjP0ugB?=
 =?us-ascii?Q?Gs2Vvo2Gv/33A7O2OhXmm3j+/reCu3TFVuTQtAWrXrjKq/ik6dr7sNR9r/+1?=
 =?us-ascii?Q?p9AI/iR8V0ucgxtz5MY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6577ad-64fc-4091-f11f-08dc87184dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 17:36:03.4065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP8182sixBpwx88bsmNLSr/WfXE1sZgZ9dS5ZbZ5EjeJHsmDeWk2qm5wjlep9FCIEpA7ZvUttZ9HGaKv+IQqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: George Zhang <George.zhang@amd.com>

Thanks,
George

-----Original Message-----
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: Friday, June 7, 2024 12:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Li, Sun peng (Leo=
) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira,=
 Rodrigo <Rodrigo.Siqueira@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>=
; Zhang, George <George.Zhang@amd.com>; alex.deucher@amd.com; LIPSKI, IVAN =
<IVAN.LIPSKI@amd.com>
Subject: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb' befo=
re dereferencing in amdgpu_dm_plane_handle_cursor_update"

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
This patch is a dupplicate implementation of 14bcf29b, which we
are reverting due to a regression with kms_plane_cursor IGT tests.

This reverts commit 0d84450ae0db367780c3dd2e208fe4e6fe5565b8.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b339642b86c0..a64f20fcddaa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1246,22 +1246,14 @@ void amdgpu_dm_plane_handle_cursor_update(struct dr=
m_plane *plane,
 {
        struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
        struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(plane->sta=
te->fb);
-       struct drm_crtc *crtc;
-       struct dm_crtc_state *crtc_state;
-       struct amdgpu_crtc *amdgpu_crtc;
-       u64 address;
+       struct drm_crtc *crtc =3D afb ? plane->state->crtc : old_plane_stat=
e->crtc;
+       struct dm_crtc_state *crtc_state =3D crtc ? to_dm_crtc_state(crtc->=
state) : NULL;
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+       uint64_t address =3D afb ? afb->address : 0;
        struct dc_cursor_position position =3D {0};
        struct dc_cursor_attributes attributes;
        int ret;

-       if (!afb)
-               return;
-
-       crtc =3D plane->state->crtc ? plane->state->crtc : old_plane_state-=
>crtc;
-       crtc_state =3D crtc ? to_dm_crtc_state(crtc->state) : NULL;
-       amdgpu_crtc =3D to_amdgpu_crtc(crtc);
-       address =3D afb->address;
-
        if (!plane->state->fb && !old_plane_state->fb)
                return;

--
2.34.1

