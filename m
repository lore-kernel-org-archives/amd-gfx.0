Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA4BC369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 06:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C638B10E74A;
	Wed,  7 May 2025 06:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="taa8eWok";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D54010E74A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 06:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/owXQz6xOnvUDpqDpFz1qtDrx6dDuaUE4OWlZgHo+YA6syI/JK1Tx8DjzkIOyr4diaPxdKiZ84ADoINFLGXejeTDxWRoJhvPHKGKZhrDr3XCaC1AiGapKxeLa33xWeXTj96N6NomZZ0pB0WtPk5+KrfkmD6VoA4Mr4Gdq3hUs+VeGGB/Mg7CIpy12UwHlssDZnDz30VOz4I/Yp4/Sz2VMw5WXtCQTjcKInWLBflG8ztlVPr1ie1GnWufb455GkXkWHlfG0mLmXlJyKSQUGtRv2KgX65tILy+BRtbZvkpsWEG8XIl11H6SyrqpnUyzrAY/odID71ELLQsyJYpDhIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzZR7BBaNa3wQKaVLQv4WeUBTv8PTgnIzBob7DTwn5U=;
 b=tTVR/93YxXnFhG2yfFCHxiIs4XOng4xfKSQCUv3s9OXw+hdF5OKW5ci+U6sSHRVgDcQngcesMhoeRq/Km3830MwIrcq1NR/bqF/3t1VSjYTB0m248SYUuZjetyxe/dI0XC6HNQdPHhQib02jq0XgEPu7Ucs4/FCaKX7ZQWLst0BoTvr5UCwja4/3YMXW0NB0CWel9VZ3H+q+QS5/NkLW+NCVBxvrFZ00L0wuEDl8ySU9frbOM90qAs4ayjmW3Id+qaT1h+xHeqEdB56ZkaPzIT/d0pJgEcqNzkIII71qwvgRrby+jVaM0ua4eJ01Gv8bm494eG31xUCE4dNHxt0vVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzZR7BBaNa3wQKaVLQv4WeUBTv8PTgnIzBob7DTwn5U=;
 b=taa8eWok8slHKsZ6Q+dwLjNyxs30hPJL0Dgwva/6AwbRKFp7ahy0MwBZH394WBEspM/0jEFJVcvm8SoHSAG8X1znas68lEICSkQKbu/tLEx/15FW7CK7Z+CqW5sVaeH6bmtimJsB90Yb+ClcARhZvtZCW9zcoT96rpV31FsBiiY=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 06:29:35 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:29:34 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove mdelay in psp v12
Thread-Topic: [PATCH] drm/amdgpu: remove mdelay in psp v12
Thread-Index: AQHbsz1qGxsFSxOCz0iiRzm4SoUm77O6s4kAgAwYUDA=
Date: Wed, 7 May 2025 06:29:33 +0000
Message-ID: <SA1PR12MB7442274CFE3501BBBA96A06AFE88A@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20250422041629.1938342-1-ray.huang@amd.com>
 <aBDYCuLAlxgXIQBM@amd.com>
In-Reply-To: <aBDYCuLAlxgXIQBM@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fe3a8324-10a6-4fd5-b60c-caa84277ab4a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T06:27:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|IA0PR12MB8374:EE_
x-ms-office365-filtering-correlation-id: 0539b0e9-dd9c-465f-8b7f-08dd8d30881c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?280qtDAwbnicDMHdAdZIuaRF4K7wJorArMxMFNIFMDbMWJ2pOj+RD9M4T4ca?=
 =?us-ascii?Q?982R2iL7pbhdwRL2+MWwueG1WSTSDMAFSrf7c9a2sKAMEzvXRc+HIKE/i4M5?=
 =?us-ascii?Q?+wLbXlt+/NnD/vDhu6VF4C+4Vu1tipNJLJfDd2VzpV6/0/nuUZZINBQVZmxu?=
 =?us-ascii?Q?V85Gi+7utymIS6AmwVNRWgw1UTfgOIe6L/Y6soYxVdRc9Vv0sFlC+BZzLAGd?=
 =?us-ascii?Q?KQyCPAHT8xu9FsdgICkTgqFHAEiKComMRcR1J1tNnBzKZrnC7T+oCvPAh1zg?=
 =?us-ascii?Q?aruwDaJhNDDSP9oUdRWTGNRl+FuuTzSRyZye02ldVeYhiwaJJSedi6908tMq?=
 =?us-ascii?Q?flJcSYehjYQxRX3dzhBBcb1Nifhdr0tzdnfSYaaHjYeKztjKmOQs/yy8sEmS?=
 =?us-ascii?Q?XDYdxk84iO3RKYldrVBtE46gYmtYNNiauYj4gPIOkKhrIAiCnMQo7sV+jnz1?=
 =?us-ascii?Q?Fz3Y1HYDg3eaQtuFBgN66S06fHqzIsZAmWIiIr+r2CpLhCVO/m/ehpSJObN1?=
 =?us-ascii?Q?nZmBncaZNsY9fGWrOXlnc9TPML37V9U//KOrE0NfWy3kRgJLIaKZ5D6RLSXH?=
 =?us-ascii?Q?7UxJGFB/XmJY5zBUx2RdZBOK1hsk1Ul0oLOGnTIIyKiukBt0VNPl1OfjtSYw?=
 =?us-ascii?Q?05+mqbwWHdu9pGKt+t+c9oU/VsvUpIW6CTucMhSxHRaJqgyUrXdUQ7nMF6SD?=
 =?us-ascii?Q?U2xtDOd7iIXHhEvy6vv747X1IGRsHETDLnTBR7SIpkFEUFaWS9Iq8oiBY22/?=
 =?us-ascii?Q?HXaQOdwihf+RGrDptrLWRnhcYwO+tsNE3wuZzpx1yJqy5kNFL0C85cHh9KeS?=
 =?us-ascii?Q?mXI/kjo96D0R6JJ+dxB5PMUirblRYcaIjzAO1el33DhJt7Zz7KMVM+FtclfX?=
 =?us-ascii?Q?fiDrXYEF4p1m8NM6QwK4ibFNsZG0kNSLEocw65jm+qY35EuSBzRlhxn0Fnia?=
 =?us-ascii?Q?g31k904a+aypAjb8GmhID2wCULPknqO4EWXQ/I1GnpXmsR5SLQC4aF8bfnj+?=
 =?us-ascii?Q?jTkKvwI7KSoiQD8pvN+6yRqE9cO3r8BLPPmsbrNuwzivKUW9WAkMN9xJGg9n?=
 =?us-ascii?Q?Q4YkHhBbPf7vDMQMpvciHM6v6ghXywV7wybp0GidXVgXwq44MQ7ky7xpNhaZ?=
 =?us-ascii?Q?VYfcLAqPi5rsjoIL1ISmvzvYuzlpSF72KTOTyPf7hqYFf86QMsmPfttO3BCo?=
 =?us-ascii?Q?hjn9yJzXXvdV0aM0IX+mooS3PKYg26anChl+GFjMiDuRk9kvTNQVFaQOvsvS?=
 =?us-ascii?Q?ug+ifwhmJH1YnnAiEMEBk/zL+VdbURhmdsvL/FAvnRIWsv21mZV6q3swsQLM?=
 =?us-ascii?Q?uvftNmaAov7FW2I/VDxz7SIm7zukvDt5BSyxva3drnBwHuQ55UD3Npi0pK0i?=
 =?us-ascii?Q?dx06BoK4fYERby9Z9utJFf0zglW0Aq7Jals+9zdo1l9aUoqjBGFVad4AQxQz?=
 =?us-ascii?Q?m9+3iMhlFDtQQq8U1nTOnzVj+CN87dmnTUPBMdzAVoGTGU1E3qZSrA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SiyDaGABwIbHUZ+rtTNr5sKtO5DoUR7zxuBoZZwkSnW1K/Re+7d29TOKD+7z?=
 =?us-ascii?Q?AmuyUcFrZzpUTT+/uApD9vsRRTqMD2endtGLcmQ8J7Z6CLP6Nxym+x9tvWNC?=
 =?us-ascii?Q?5kquYZQdsNtkhFY6IHSadjrurgyWE0bDciHlI09ZHHAilvDqJmT2KUpEcnEX?=
 =?us-ascii?Q?MkiV3n+biaupmdrIXY1ble/+wlv2It/oqAiT9KynBDPsDXwtfwtwR9Jl/AT2?=
 =?us-ascii?Q?DBWhPKq5ZRhkuF5PpLCr3j0bcUjocbtbBZKmP0i6IvBAwW4jn4fKP8G70h+S?=
 =?us-ascii?Q?uOp4f6L+f0m+mHknHH5fN4qCI9Y2tDlI4uvRFS9j9GRn+opkBIzvF5xBNkcU?=
 =?us-ascii?Q?nOnmKB+HwDKWn4gfjjoFe2fDajA5ZeQodhpx/ZatQav4SW0vRXp5lb5XQa5Q?=
 =?us-ascii?Q?0LqozzkmagKKPzD8PXCyMgLlA67xUmc9p5twNGYmABrLelgZdSSHUQ5sLIdR?=
 =?us-ascii?Q?SkWFjIWXDmu+0+TEPEog7joOM+WNQuos19q+F1+S8FMbV6ZO1dxXV+J9nBbQ?=
 =?us-ascii?Q?LdAnUUV9/0oOhYkKttl6YkLy/zfD7sLsIS/QsHI4qKshiJ//aipg9uSRamTU?=
 =?us-ascii?Q?RVqgGcJV5bEU241gnz5vJc0Yt8t74JE2TgljHwVIMz6Lhwmb7ljt66EB4fH7?=
 =?us-ascii?Q?rBH6F9bI9SkAr+N7YQdipAW1Kzg1EUisQ3KnT0tkXPpChYpw4Td6y7aJGcfF?=
 =?us-ascii?Q?QQ1NAT2ZqmmB+wzgsvl60Nbk/lIedM/PWdB08BXW97NpWpHXgchh/gFza+PO?=
 =?us-ascii?Q?6LlLHz91/xidsJ742GwOtcJCyIxq7wC44xera038ySjzg4FptSWt5cpUok78?=
 =?us-ascii?Q?pb/teHlYN+DheyfjkrsVho5HulSL78n6fGFOCHZt0ir6sV0OvBgjkjSNnUpC?=
 =?us-ascii?Q?Pj4uiE26cKHHSESBovFOcQy2befv8G1gJqwuj54Scfi8uWgjAOgmMb0w4I7A?=
 =?us-ascii?Q?1CrrHsws75sBTxzsZ+7FUJ+6oie3VisXD3WXBB6M221eSTFsEu7qnVEXabvj?=
 =?us-ascii?Q?ooBzsaGxH46Wn8dEIXBTyLkaMwxEpypdBXG38LnskNwuGi5g6ih8Kq45irCO?=
 =?us-ascii?Q?PMf4qHFw305KG5Ci8yYqCioM4xFoQ7CPSsM6CrDL/EvY4L8re9pDUf/Ij3rg?=
 =?us-ascii?Q?5FliblxSOimsY3TvjyICG8a5D3mTKUZY/tLKudjLdMrjwHBeRgscJImpehWT?=
 =?us-ascii?Q?+jTTv+JTp1aisHs8wr0Dqs00eNCHAsjT7vGFDuqiq6GRImHkohZm9/uUz2qL?=
 =?us-ascii?Q?P8mgtr+yClCJ+J9n5xpODFJyTMbUspGPQvfXeJhLLuC+CJLv38PCEDKTiiMZ?=
 =?us-ascii?Q?zCXFqiMBBp//YfR+7mlWVsjDEzmdvLZP1Sgtx6Sd/ZRoqqw0js0OgxhIzVez?=
 =?us-ascii?Q?/iG1T8Emr8VT6pzmutCXbu73HMj/pwCk7u9jbXwkvJn8DOaYVN6aiELKbdj6?=
 =?us-ascii?Q?cf6tPMhHD8yL+geic4RFyoELbp3dHkWJcrFn75qFNX8rZuqgaf8TLI8gk0Fq?=
 =?us-ascii?Q?HWDIcS4VJMzSDh/c+/OWs4Q1RVUokSL3yyYrb92rlwhvNAIU91jFW9rntVwS?=
 =?us-ascii?Q?Fza+j/nd75OPygpdoWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0539b0e9-dd9c-465f-8b7f-08dd8d30881c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:29:33.7794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lP7pgfsy5nxgg/FAoni7+p66B+H+8s149pk9DbZ1huymghhm5Y95BDgxaU6To68f68YHkFvR3KZ+K/LP35wLlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, April 29, 2025 9:46 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Huang, Trigger <Trigger.Huang@amd.com>; Zhu, Lingshan
> <Lingshan.Zhu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: remove mdelay in psp v12
>
> Soft ping~
>
> On Tue, Apr 22, 2025 at 12:16:29PM +0800, Huang Rui wrote:
> > Since secure firmware is more stable than bring up phase, I believe we
> > don't need such mdelays any more before wait PSP response on PSP v12.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Trigger Huang <Trigger.Huang@amd.com>

> > ---
> >  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 16 ----------------
> >  1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > index fcd708eae75c..6331941440d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > @@ -99,9 +99,6 @@ static int psp_v12_0_bootloader_load_sysdrv(struct
> psp_context *psp)
> >     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
> >            psp_gfxdrv_command_reg);
> >
> > -   /* there might be handshake issue with hardware which needs delay *=
/
> > -   mdelay(20);
> > -
> >     ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_35),
> >                        0x80000000, 0x80000000, false);
> >
> > @@ -138,8 +135,6 @@ static int psp_v12_0_bootloader_load_sos(struct
> psp_context *psp)
> >     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
> >            psp_gfxdrv_command_reg);
> >
> > -   /* there might be handshake issue with hardware which needs delay *=
/
> > -   mdelay(20);
> >     ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_81),
> >                        RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
> >                        0, true);
> > @@ -161,7 +156,6 @@ static void psp_v12_0_reroute_ih(struct psp_context
> *psp)
> >     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> >     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
> > GFX_CTRL_CMD_ID_GBR_IH_SET);
> >
> > -   mdelay(20);
> >     psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> >                  0x80000000, 0x8000FFFF, false);
> >
> > @@ -173,7 +167,6 @@ static void psp_v12_0_reroute_ih(struct psp_context
> *psp)
> >     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> >     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
> > GFX_CTRL_CMD_ID_GBR_IH_SET);
> >
> > -   mdelay(20);
> >     psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> >                  0x80000000, 0x8000FFFF, false);  } @@ -200,9 +193,6 @@
> static
> > int psp_v12_0_ring_create(struct psp_context *psp,
> >             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
> >
> GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
> >
> > -           /* there might be handshake issue with hardware which needs=
 delay
> */
> > -           mdelay(20);
> > -
> >             /* Wait for response flag (bit 31) in C2PMSG_101 */
> >             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> >                                0x80000000, 0x8000FFFF, false); @@ -222,=
9
> +212,6 @@ static int
> > psp_v12_0_ring_create(struct psp_context *psp,
> >             psp_ring_reg =3D psp_ring_reg << 16;
> >             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
> psp_ring_reg);
> >
> > -           /* there might be handshake issue with hardware which needs=
 delay
> */
> > -           mdelay(20);
> > -
> >             /* Wait for response flag (bit 31) in C2PMSG_64 */
> >             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> >                                0x80000000, 0x8000FFFF, false); @@ -247,=
9
> +234,6 @@ static int
> > psp_v12_0_ring_stop(struct psp_context *psp,
> >             WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
> >                                  GFX_CTRL_CMD_ID_DESTROY_RINGS);
> >
> > -   /* there might be handshake issue with hardware which needs delay *=
/
> > -   mdelay(20);
> > -
> >     /* Wait for response flag (bit 31) */
> >     if (amdgpu_sriov_vf(adev))
> >             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> > mmMP0_SMN_C2PMSG_101),
> > --
> > 2.25.1
> >
