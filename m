Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 13:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD1D61090
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 13:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFD1D61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1166ED11;
	Fri, 15 Oct 2021 13:01:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46396ED11
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 13:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj/hJtXDx8TghXoJZ7DFRmeVUwtXGaD1Bb/Bsxw/7aULktQcn4izNfD0RDzWq6qAHCIWOGnFYSQvCMxZ4Q15a29v7rv/GjHCyDSP1ZPcklr//pimmQmsoiYB+hGgyCiKo1NQ62esV8Qf4Bod9ghGMQu/Gx3CiQ5CECAOlgkj5+Pd6EtnOPoVL6oTpmxCT/Ow/vG8xYSB6cSNHD5QDc5Y8BzWbBuKmzV3RwdGWPW2B/ZMAJkej2hwbNsU5M47nfkSqLU3Uf0dgPGUT+I5xEdKNVQYC4t4DVmjdSPRsutnLdd+IVfJJY/Y5mIAgCa6U74sCE8R161k6t1F+kkz/kbgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP0S+TqJjIqCCnvB4hv4JoKG532GXV9fOiDhnMiDh5U=;
 b=Wbh+FHHVmJcrJ+FxCSkXkqxp83w2YcGuONN9m7FyzQdcNHuFkvsxguiVitYiiLujWAFRNqAI07d8hgFuG/QniPcZBFCdljhLbRFLo7H7Zo9pLNLd3TY35yP/y2FTV7tzny5LTdBytyI+LN47wO0iSqrdS3UYBMotfDUjQz1hZ49QnPKbwGijalW1BrOsJ4U8ddQir7ZYz3igGTf2XmZ1zoU8acdEJgxspV/kHYU+sKeZnKKWn7bEMiPwEdaAhy/LwJrJwjqOBmVnHW8OIgyB1xxOWOhV/g+EnxPV112Sgr+FKR8g/xilyxKNqVyraCd/OChJbI7hKo+1UEK/HtpZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP0S+TqJjIqCCnvB4hv4JoKG532GXV9fOiDhnMiDh5U=;
 b=PtLoIcE8KDB9zZzPXoE7eI44r89np60iDTnp4W5red4NPiiVST7MqexKp1V8VJJLC22OYYyRhgMZwlimhivJtlLF973muhHXGKIdVxtqwwPuKd1SIP30PGYBZ8lpu9bcTlkO99GstyanJ+nN3SdenXVPOTCtc72fpqIhFi606qo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:01:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 13:01:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: output warning for unsupported ras error
 inject
Thread-Topic: [PATCH] drm/amdgpu: output warning for unsupported ras error
 inject
Thread-Index: AQHXwaSJSJLUITotAkuw/6twx4yG8avUBajQ
Date: Fri, 15 Oct 2021 13:01:34 +0000
Message-ID: <BN9PR12MB5257C62227D3875B7BE2C7DCFCB99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211015091033.21214-1-tao.zhou1@amd.com>
In-Reply-To: <20211015091033.21214-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-15T13:01:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9e2644e9-7148-47ea-b337-51f0d99e2e3b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d21d6263-53d1-41c7-cef2-08d98fdbeab6
x-ms-traffictypediagnostic: BN9PR12MB5290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB529083A0090E721FF749EE8EFCB99@BN9PR12MB5290.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hytbPhHbftQjNxx1dbekyyOAWH2NXNnnkMu9vJsGPHtL1+5Z4ip2yc9tjozOd60Y3877OcTWhhA/ueMyr+hGm8gY6ykp4Qg4XL+ZvAIoVSsnT9TxNP0dkq3iKaGojFrpDOqq4PkBWe6bAd7Z9T+3mDJm1hTQ74OyZvWM4BaxLa5mh15tjkCq4KuILi0rnL9yjirvrUuu/2yzM1yUMpoRl6xo0VAqslIWH0AQ6knAKMXg9M00FSskBx+qc0oWq0mtBL9+lT2CcV3Cgz3VMHLqRRSLprvbDYCTqJG2/mbX9IvPB3cABJ/RPy+8ePE2d5KpY/YQgfX2PFttzlfGH4rVsyKQZ44TA/VmDjeAzg0va2utWo+6/+sYWL7vvJ5ReZQeMyk9euk3h3QIOLeRjcjdvkbyMOdIpNF5OGc7fOdAH8AFri9VOVGrNgKpzJg0DWFy/omHF2UbHenfzkCIpd2Phu5hm8ORdajKUbJcSzk8iUpWzdiS93l04rohUVy6ViYO35NrsbkAk/j21EU2jC7Ji1VFSk3JCK3m6AI7tTMO2GHe2T3GRnYPECq3/92kYtDmHgGBS/TdMqLvcaOGAEnm029y2B2JfLz/LkwB7Rhmw/7D/AJM/Kk0Ato5FbIWPKx2j+bs1KuUUxYUZt/xywfJtVwTlLndM/Hsgsi7XoAGU6hQSTIPGHEHUtJJSkTBtNDBcYUt6jagdBGfHjOVFnx9Ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(66556008)(316002)(8936002)(26005)(66946007)(508600001)(66476007)(5660300002)(76116006)(6636002)(9686003)(66446008)(71200400001)(38070700005)(38100700002)(8676002)(52536014)(110136005)(186003)(83380400001)(64756008)(2906002)(33656002)(6506007)(55016002)(53546011)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OZx7BIzBFjQsiUjgcNSFNKIo5haqQ4UEDEWkV3G9NiixhV8qUHlTIyPLiRKW?=
 =?us-ascii?Q?XquSEJtOdlHMI6XYSNQEfC3KE+o/I3H2xSCHzMfN6sRTKqEcx4Q4D016xbD3?=
 =?us-ascii?Q?VMpIUNpFYeo/t4+gVVEAF6FsZGNEHTrVv+c87oE452Ii3dWVtpK4OydwFWUh?=
 =?us-ascii?Q?0bOApMSW97mPfy1ryiIVyPGnj5zrBECZfP0c10RnaE9MhQ7Cp7cQNJ79YqPR?=
 =?us-ascii?Q?DkGClMJlKxWbfSktqL0n/bHdMQZb9RFLjKdBo99G9eLBWVTd2PT2eCklvnOz?=
 =?us-ascii?Q?9f/2kK9LngzXcWC4hiF+7uRVEnvJL1b8ErXuaEig1/wSst291RisM+jl5bSk?=
 =?us-ascii?Q?ESY2Kcb7Dd/8VtrjFzGV0V1Xr9sBLiTJMTBJY/+bBs/xw/G3pqnj1uYLcynh?=
 =?us-ascii?Q?u9plFLRUPNerDl9Oy+6EAQfqZu56iKfyZ6PkzCcqucG/N7isl19YpvP8SWKL?=
 =?us-ascii?Q?TJtwEWC5I3ibyXJ0Pfkuv4C2WFrd56o6DvjG1Y+uuUvzj/Qk81u0VqvTpcLc?=
 =?us-ascii?Q?E9TxTeuhNCOqHGwP2Yj5zBeqF2KhfbBXYdFDSmeyjY4B78ntmF3PlzyQatz5?=
 =?us-ascii?Q?jvN7ULpZvLOW5Z0UXBFTVJFOoxvp+st9TvBnSjOqh351BrdKd2ab31uI6mF5?=
 =?us-ascii?Q?yONnr/VQDOB4vo6W54jAgNjwajf8fyqH+6qd/omTkfLAGus4NSKO2cxR6CeQ?=
 =?us-ascii?Q?WUHGf9BXO0HjdX7L9fURiwfD7rLFsrb7LfMsBW1ahumTOMecE0kfeqmMePdW?=
 =?us-ascii?Q?1mkNkl8C9pXDTnD0Bmxrm/KJHIly+nEEAS4tIl8B4joJOutPXzn7E6bHtidR?=
 =?us-ascii?Q?we3/3UtEXi4hZ17rnR8xyTr9UO5EoIVKlNHqBLW8YFiY+JGvcwFO33GWnh+g?=
 =?us-ascii?Q?Gy1HngvPj8dODDn9nGERh/fm0B1F+R+YjWvUqPKZMEOceU2XuqzpB2Rrb65Q?=
 =?us-ascii?Q?b1DvbmDEnPuYSAV1yW4lh16FKOY7Qgkp1r+fhD81rcAcPzsRaXRt+NPlHNE/?=
 =?us-ascii?Q?UybwCEilBXkh+UsxQD8VnusD/h7BVPmi7u7WhG5kFDE1hjrDlQtcQROTZr4d?=
 =?us-ascii?Q?5Wi7yVmLMsVwJDJQChNXjZxQKgYrXjpkmh1TdRj8s2i+Zw+iUs6GosBtvvMe?=
 =?us-ascii?Q?I2PJTIM28O/2XTloySvCYOQwRQ0yzpu2DcsJT2egJuWsh7u7PDq7Jf5orMjs?=
 =?us-ascii?Q?5tmAbLj/2UaJ0nhqbNXaWKvNBtFh1ZsQc1O0nyX2QUzSXpG9XCHIsIdJvs7d?=
 =?us-ascii?Q?uyg9PCQvLZAC8lM2hY406dRGgujjK8CaSXBss7DV9/UjocYJz439V9PQ8iH7?=
 =?us-ascii?Q?7bIS/lbGH+gPnrAAPqDioUX3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21d6263-53d1-41c7-cef2-08d98fdbeab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 13:01:34.5685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9pHUYyMMj+UKteq36004Ne3ANAkV1CPhKcX+MFe7RGAWuAWuWOwO2AFri6VkPyFsL4dplSgLdi4pQtyhB+Uog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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

[AMD Official Use Only]

Would it better create a function to interpret the RAS TA error? I expect m=
ore error status is available soon?

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, October 15, 2021 17:11
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>; =
Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: output warning for unsupported ras error injec=
t

Output a warning message if RAS TA returns UNSUPPORTED_ERROR_INJ status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++  drivers/gpu/drm/amd/amdgp=
u/ta_ras_if.h  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 88274c254c76..50d84deeb8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1328,6 +1328,9 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t =
ta_cmd_id)
=20
 		if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__ERROR_UNSUPPORTED_IP)
 		    dev_warn(psp->adev->dev, "RAS WARNING: cmd failed due to unsupported=
 ip\n");
+		else if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__ERROR_UNSUPPORTED_ERR=
OR_INJ)
+			dev_warn(psp->adev->dev,
+				"RAS WARNING: cmd failed due to unsupported error injection\n");
 		else if (ras_cmd->ras_status)
 		    dev_warn(psp->adev->dev, "RAS WARNING: ras status =3D 0x%X\n", ras_c=
md->ras_status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h
index de24a0a97d5e..5093826a43d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -59,7 +59,12 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_SYS_DRV_REG_ACCESS         =3D 0xA011,
 	TA_RAS_STATUS__ERROR_RAS_READ_WRITE             =3D 0xA012,
 	TA_RAS_STATUS__ERROR_NULL_PTR                   =3D 0xA013,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             =3D 0xA014
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             =3D 0xA014,
+	TA_RAS_STATUS__ERROR_PCS_STATE_QUIET            =3D 0xA015,
+	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            =3D 0xA016,
+	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             =3D 0xA017,
+	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          =3D 0xA018,
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019
 };
=20
 enum ta_ras_block {
--
2.17.1
