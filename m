Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39B7C61DB8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 14:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6FE10EAD4;
	Fri,  6 Jun 2025 14:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UjIRZqLG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0643010EAC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 14:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AONWetXYrPn+b/7HVqvVwicfCFfAsFiB7IY5Yzsmduhr3Dta5jkQH4hbuuba7NooH6JouphBcUXITX4Ozti5K0TeTdRiA8DZS1xvdvXO0ZjaTSqmMjYS19SfHfXPBRSpjSipYiNJGepGT4G7z1fhjWlUjCTrwdctfRLSwpL+66q4+aT5P8J/TpzFglfyVNuv79TK2cM/tOqJD4hmjXAk6aVg8zONIbpmW1m6S8D3blvlAc4NKmT+H2l9PT1T79qzPyECxXAMI5TJD7sZ7tWtfdz1lK3aGG1iFN54OEY+7GDM+fR3tuosk9HWWKHuv/SkncC0ieMEjtVSfnvU3lqV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckGY7sWcWNh2RwM23s4Rt6/9X0J+BiIu0LsSgambgjU=;
 b=Icf+E7fQ68uPDEkUNuSgg7ZOLtPKgZU5grB4q67v8sXeaxdipFA03uu6smEMs1LspHGsX3HCZzHGvWHxhCmpKenhrCfNaKBdAQi1fnk75AzjRBOVnmA4jrbbjN+bZoEejCvmH3F0rjKKvN3svT2y3PIsFwmBG52u3ftKffoSyfJs2EbyxtNYGCtJxcCrvA4pRq3C/3xV0EhiBBxn+7oJmZaNHeJ7W9TS+1NwHYHF4b5AbTlX6A/r0ln+TaP24Y4E5GA1ZI4CG3xWGehzXE7uaRuLVvSWhlhLl8pK8kAUMHtge/P0tDQz+lQ0bRXi66nQZaqAB0Syc+J2xw7cFgmE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckGY7sWcWNh2RwM23s4Rt6/9X0J+BiIu0LsSgambgjU=;
 b=UjIRZqLGUR1tTAMbID2zekhldTb9cuP5/1gVyE7/7HYWLPqsBYUQVM5ZQBDJhWOWBk0gbpw3ChWonrEXhpS+dKobKCKLanayWaNEHPtQ/8Y5csiXp/guYiLeI+j1GrCGMH/CNlrKAjt0ljprDBAr1wXm5+oOtAg/KiWbc8rVG+E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 14:15:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 14:15:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Gui, Jack"
 <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, brahma_sw_dev <brahma_sw_dev@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add kicker fws loading for
 gfx11/smu13/psp13
Thread-Topic: [PATCH 2/2] drm/amdgpu: add kicker fws loading for
 gfx11/smu13/psp13
Thread-Index: AQHb1umToBkSWNBvaUyyXwq1bfKuHLP2LOCA
Date: Fri, 6 Jun 2025 14:15:04 +0000
Message-ID: <BN9PR12MB52578695D0DFE35DCDC0C063FC6EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250606133229.411322-1-Frank.Min@amd.com>
 <20250606133229.411322-2-Frank.Min@amd.com>
 <SN7PR12MB69324D3595BFC8C05BE48897E96EA@SN7PR12MB6932.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB69324D3595BFC8C05BE48897E96EA@SN7PR12MB6932.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=49794f50-ed04-43f8-809a-058fd8e91db6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-06T13:37:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB7646:EE_
x-ms-office365-filtering-correlation-id: 4781770d-4a98-4194-f564-08dda5048894
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?O1ovFtcGSKZFuRqUZKVC2J2dou+Xs90Mm1lG48RG2KMhEDDkoyUIMl508sr7?=
 =?us-ascii?Q?wU30FhojoR2G8grBJeuK8zfOrqIRbknKQDVI3E9bCkGEMRK9XIgSPg8SnmKo?=
 =?us-ascii?Q?uZNfXH89viFxD7aDxlpkPh+u8sQDnpSbzjLnR2Spm15tS2dH9ZNLM2gCcGrz?=
 =?us-ascii?Q?/A37Sfu1UH93WPd+D9KNIWZsiOq3u4sEfY4luDbf2/eFUgYtaG0USXHFU8/x?=
 =?us-ascii?Q?3QorrS7N8c62xmbGVaMyDFVM3KdVEjiIn3eKHChOn8IJ4Us85ir/L8GIB2dm?=
 =?us-ascii?Q?ce0qxdBKmwFyTOx5MJxUe8NbGvTIrhrKtiXqXYVblVtz7mTi9yTRmCRJ25Ns?=
 =?us-ascii?Q?Ip5YeWslCygRNIaTnveSw/bMP/Gwxn8/ubn3OhyQlO/A9L9DGe/tF6eVIg53?=
 =?us-ascii?Q?DTK4pGnefLA4W8cFSl1BgrxBUzdXCt6ddNn1f3ovHyFSJ31HOKzojhEPBpxT?=
 =?us-ascii?Q?DHKblpsbw1Sk74GdpKcNCJ48Jwps4t5DjbxWRTXQ5Shjd70ybunLG9oowI1m?=
 =?us-ascii?Q?eQUDu4rN3xefKPCS0/YdLywTCNnXrL3tJdIvzcBba7SOMsN4ug8my8aiGxCy?=
 =?us-ascii?Q?ackGzd/GwnU+aDItD+RBktH7AR+SvEYqnEb8J1E5S8/JtQT0lFsaTq38pabx?=
 =?us-ascii?Q?q8S5JLsmPqBDEdYZa91uhcK5FPU5Nlg2eY9pMtdorSDOw1ONTzZCOOdGTmqI?=
 =?us-ascii?Q?5s0tsmLjkPrcYNgZAgRILsqOWFsotAQHcdR7Za9OO7uEJLqgAwgzAm4wZUXh?=
 =?us-ascii?Q?pY0gYH5xrVPgiPkrjrjyKErqMgyJAJ0n63Gk9cMj5x7Zfg1air0bv0sNsMBH?=
 =?us-ascii?Q?rU1ZA/aB5PbW3JR9qrTVGEV9HGsTHqkswf9LuwskuSP1UVco7oSUu3eeMIA8?=
 =?us-ascii?Q?2b+4L7zAyfIKJyLxUMDBEXCLHcc0eDLs0/Ats6C9SBsHWE3vgFk8uEzXXnV6?=
 =?us-ascii?Q?uCB0Ocsfsseomb7rHiHi+rKN3lYLtJCFCD9nneGMvYfh/4V6LyqpCM+SYaRW?=
 =?us-ascii?Q?z6rEogFcygaPL5IUyoflPKF7JijEZTD1oPv9FfE6JtN1JHigq3nKCEMjF2/E?=
 =?us-ascii?Q?RatPzYCJzVjGzy+NrLsWeMra/IfOvBKkCGkQzpUSwZsoUT/sVCVzZtlUcAuq?=
 =?us-ascii?Q?VRB5Hkt9GHSNUM+s//vBpUjCQafigpY/m+xrfrx4ocKjE/wK8vs9oAKo55dV?=
 =?us-ascii?Q?ay3hYDQwNXq0Nxjmo28cxhkhFfH9uCpuaP94pQVxxPNz3MVXb5zRE9DS/f+R?=
 =?us-ascii?Q?JKX4BTM0W7zUJuiWJgycsU9nF/ao/oBzv/1+5gPEf00iiFUuKpr5mjSz7F13?=
 =?us-ascii?Q?Wr+ob+zi2i5cc5fSmote/YxQ1hpxZcPSM139ih15gLYI+JyuY08yWODG/SZN?=
 =?us-ascii?Q?BL6vCsi8o93FZEMuC7p1XkRRMZnpkBQQKz2l+JQGbzDVrGSN/9aiTN4JbEfz?=
 =?us-ascii?Q?6OBVuijZ0HW/jSOgdnEZQ/XpcTm6xGOCkPvGzePAJ8g+rQkiwNjpVsmBV/NX?=
 =?us-ascii?Q?NSw9qzpjhZPhVhpEpCNqcU5FUjc5O0wbAi1Z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wh+dKUrc/d4o225Hq8+0Q8SOnSRTVDcq4yNHSaW7dJ31pz9/G43XQDIaJDBW?=
 =?us-ascii?Q?W7CqAGTxYzYx8TeChgsrhREOWshFgJjrDDwr/M8TiGF/46S34JANy3tydHXj?=
 =?us-ascii?Q?yq1mbvLJXOa7scc2VcAGmo7mncNaRjmcZnCj5vgxLmZZ0dsi4j52/vhliJPt?=
 =?us-ascii?Q?6B/BQs9Wt9qqV7yKk87LKogQFpgGVLCbcnzuY2FFMpONtz2JjdHMP2/zGH3x?=
 =?us-ascii?Q?amlIPX1nFcAmkxfgPD4W1NfYqt6c+eVED7kfCWAR4hGW9jyimkx2fyqAbtVa?=
 =?us-ascii?Q?ZLoMh/R8KgG+XFRgiUS1/18b6MVoRNdVcwpgcrQD/IURnzbhZkUer442LZTq?=
 =?us-ascii?Q?HqWbTFG4q89wugC3FCIS1bwmsHxwyKwm3SeB3VdTyq9qT/Ku96gsf0iipYOd?=
 =?us-ascii?Q?6ohOEs1k3NkHUT7JOfX2z/kyhTkYaeNytMNEabvw+xnWGtVjp/IsFJpv80LK?=
 =?us-ascii?Q?ZqN+kEog2CBdrFA0yFUfWYYUvt+m1p65Oup8Fk0WnV45cnK/Kzfaa7DrE6b0?=
 =?us-ascii?Q?mrDN7FMxTrJLu9QPd3A91VGwnVgs3FgQHlRbx8h9w8HUvMhqsjz23X+aEeO8?=
 =?us-ascii?Q?5N1Ud48bgsh+UEwnIQXZaJStC4iVLl45hRlS/GRpqzRFcNHYYOR37AlWtORq?=
 =?us-ascii?Q?wXL2wspM5PdOF9vcfwakEwij1VozeuBX5KcHOFr9NjRaPwY0pgBlFFU3DCWB?=
 =?us-ascii?Q?587YLS5p7/OeKpkhZ5mstLP5fnSXMhIn39wui1Iwdmg4JGi1e1U4g0esQJVg?=
 =?us-ascii?Q?hFwV/t+UzCzW1UFb+ScD4x98jEtDrd3QPMYK8ODWCMvXXYniZSPWSTyQbHih?=
 =?us-ascii?Q?Agj+lKznAckL4DoYH8A5XLkxOAZJLZckvoxeanzHAYIaS5C+xeBt/svnaP6h?=
 =?us-ascii?Q?11zjP5QYI6mW7h3KUGtjE11/vR6+iLBZL4go71MZWsSpXydj2XNkSV9t7vbq?=
 =?us-ascii?Q?9DNnEEWst8Fvyav8TvAxZWRDa6C3BT0LfHZN+hP3Fg+lxYPmc6NdzBGsgPwS?=
 =?us-ascii?Q?NOh2znj+GYmUzzLKGyMIr+EsQAZ0MG92ziJeR4StWPsBgt4fnRozv3x3OM2i?=
 =?us-ascii?Q?OKbxchrt5kqmqj8IK/tHdv3l15dKXZQTUPVWjbs47cp7Cl2ZnGVZ0a9u+U4X?=
 =?us-ascii?Q?FU10TcvRp471M0DItwOAsJ9yxgUxFw2IP/dl/cObtKs9WvEjz9APACQlnFQ3?=
 =?us-ascii?Q?voniLSBv6MF5TmDJkQkTgDMByR2WS5iNN9WbfUou+BINJ8Oeo4A6U1RpVSn1?=
 =?us-ascii?Q?arr6V+tEeCehSNYC5k/kg+Jcs+xr2OTQCFh8Mu+kmouSZY9UZQkSGxl/M6Gd?=
 =?us-ascii?Q?46fjwsEcgiKmRst0l+BbbnRUb8Lk6IErG7CD3AZ/9yHa91vc3AUDfz4WbzG0?=
 =?us-ascii?Q?+O9FBOgRze0lRzne0pqM4BlApHyaQQHLOdHcOFfEpuHGyjYgqtoVVnEHcqhJ?=
 =?us-ascii?Q?Pq+C0xqhmzGna0K9v/+sNXNGCEPPr9bp5Obfdzir71oPmdNas4B5Fx0WibVv?=
 =?us-ascii?Q?kAmGhmVNYiut6vOzI995en9V41vaFh5s1DOYVRZqp+W8dB5RhmGZd8R5CV8j?=
 =?us-ascii?Q?nbPTcpHMB42YOgbN/7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4781770d-4a98-4194-f564-08dda5048894
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 14:15:04.6259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFZvZlodf4ZURdYz5Oq37C04JOowlZ/fc0dZi3x343uyQjoNT5sZhA4assACe0SVq9pp8gSu4zKAyrWrflChhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
X-Mailman-Approved-At: Fri, 06 Jun 2025 14:59:13 +0000
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Friday, June 6, 2025 21:48
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Gui, Jack <Jack.Gui@amd.co=
m>; amd-gfx@lists.freedesktop.org; brahma_sw_dev <brahma_sw_dev@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add kicker fws loading for gfx11/smu13/psp=
13

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

1. Add kicker firmwares loading for gfx11/smu13/psp13 2. Register additiona=
l MODULE_FIRMWARE entries for kicker fws
   - gc_11_0_0_rlc_kicker.bin
   - gc_11_0_0_imu_kicker.bin
   - psp_13_0_0_sos_kicker.bin
   - psp_13_0_0_ta_kicker.bin
   - smu_13_0_0_kicker.bin

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  5 +++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c         |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 +++++++++---
 5 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 9588278083cf..6068b95dabff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3522,8 +3522,12 @@ int psp_init_sos_microcode(struct psp_context *psp, =
const char *chip_name)
        uint8_t *ucode_array_start_addr;
        int err =3D 0;

-       err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGPU_UCODE_=
REQUIRED,
-                                  "amdgpu/%s_sos.bin", chip_name);
+       if(amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_sos_kicker.bin", chip=
_name);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_sos.bin",
+ chip_name);
        if (err)
                goto out;

@@ -3799,8 +3803,12 @@ int psp_init_ta_microcode(struct psp_context *psp, c=
onst char *chip_name)
        struct amdgpu_device *adev =3D psp->adev;
        int err;

-       err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU_UCODE_R=
EQUIRED,
-                                  "amdgpu/%s_ta.bin", chip_name);
+       if(amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU=
_UCODE_REQUIRED,
+                                          "amdgpu/%s_ta_kicker.bin", chip_=
name);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU=
_UCODE_REQUIRED,
+                                          "amdgpu/%s_ta.bin",
+ chip_name);
        if (err)
                return err;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 86309c990455..d7b62048cd0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -85,6 +85,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc_1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_pfp.bin");
@@ -759,6 +760,10 @@ static int gfx_v11_0_init_microcode(struct amdgpu_devi=
ce *adev)
                        err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
                                                   AMDGPU_UCODE_REQUIRED,
                                                   "amdgpu/gc_11_0_0_rlc_1.=
bin");
+               else if (amdgpu_is_kicker_fw(adev))
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
+                                                  AMDGPU_UCODE_REQUIRED,
+
+ "amdgpu/%s_rlc_kicker.bin", ucode_prefix);
                else
                        err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
                                                   AMDGPU_UCODE_REQUIRED, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/am=
dgpu/imu_v11_0.c
index cfa91d709d49..cc626036ed9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -32,6 +32,7 @@
 #include "gc/gc_11_0_0_sh_mask.h"

 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
@@ -51,8 +52,12 @@ static int imu_v11_0_init_microcode(struct amdgpu_device=
 *adev)
        DRM_DEBUG("\n");

        amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(=
ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_=
REQUIRED,
-                                  "amdgpu/%s_imu.bin", ucode_prefix);
+       if (amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu_kicker.bin", ucod=
e_prefix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu.bin",
+ ucode_prefix);
        if (err)
                goto out;

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index df612fd9cc50..ead616c11705 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -42,7 +42,9 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3b7a011b4691..58ec53597c18 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -58,6 +58,7 @@

 MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
+MODULE_FIRMWARE("amdgpu/smu_13_0_0_kicker.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");

@@ -92,7 +93,7 @@ const int pmfw_decoded_link_width[7] =3D {0, 1, 2, 4, 8, =
12, 16};  int smu_v13_0_init_microcode(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err =3D 0;
        const struct smc_firmware_header_v1_0 *hdr;
        const struct common_firmware_header *header; @@ -103,8 +104,13 @@ i=
nt smu_v13_0_init_microcode(struct smu_context *smu)
                return 0;

        amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof=
(ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUI=
RED,
-                                  "amdgpu/%s.bin", ucode_prefix);
+
+       if(amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s_kicker.bin", ucode_pr=
efix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s.bin",
+ ucode_prefix);
        if (err)
                goto out;

--
2.43.0


