Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 14:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E1110E0F5;
	Tue,  7 Jun 2022 14:54:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB7710E0F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 14:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDefmgqPEGDuP7tiRpOGesfq+R7wQCMyDSAsss21fBvUtUFXpCfVrPzzH8WoJFB1ygvEx/RQrzJZSYUcuFCv/O11WxIwEybir3MvP6xTR8A4ot42rz5zPnd6GdhjjxoEeejEknSn/esQkn7b2w++Z2JPau9B/dSJ05LC7qgpeMNku3hzsaX9e8k9lbZ7W0LsRFNDoLRDK8jG/NHslMJsnSNMgkgJWD+JLjxuSygDWYExitqIdnJflOzVc2tSb/1JhXTkqUgDenYcxGJvm8GpJMuMTu8HRRdnR0MD8y390iqPN7Oxm1kQDCa8fLgOdW/LClUMRcBsGbj0aOo0WBW4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxKLCT+R4wDmPWDL+jy0O1gsw59kVSQ856TrPyx4Mpo=;
 b=YTWSPLViMEiBGGrUcOmQj3HC2d+cS7sEeoQZmE1n4hxozovH3oNFaOz8hEsqeZocsf0ziblaFLHv98u/aZ5v+7XRaVim4o0/JSWJqs3r11EHBAePohIzWdpxhCcaKPVW24nyQA5thjeNF5QgPo4iF2ACjt9n48i32237oaGeiJ7sseVMgYkXRSPjFLH1oMK/DhnCsILIg2pJ8SeKqm/QAopQXu3ASDPzgGDWDlPfxvUdYQMelQYS9kpKu3QbR832tW2sRMuMx4pK07QU5DbgZVnRF0pf7HelTIbhZw6g6VoCvegSqxBSCoc+v/2NMx/mkNjpklJWSSc4Voc84sUbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxKLCT+R4wDmPWDL+jy0O1gsw59kVSQ856TrPyx4Mpo=;
 b=bquGmy5B/X40nNca13WWBYMzQ8oxOmhBa7d4rJMFWbtxNR3Rs+j+51Ah7vIjZPc4YIcgk7xG0ymf756K5ulHlW1cDjiB55K0dHY1B8mQohmCyS5G1cyPHBaHxqeSCyLN91/1W7Ra2MRM4AbcaiREThYsFOglTFBXkTV/evEvs0g=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 14:54:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:54:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Thread-Topic: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Thread-Index: AQHYeZIFnFjPLJgQokODHQ4yfl/Grq1EBM8AgAAE8gg=
Date: Tue, 7 Jun 2022 14:54:46 +0000
Message-ID: <BL1PR12MB5144C65545B53C25082A61D6F7A59@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220606104007.3801900-1-yifan1.zhang@amd.com>
 <CY5PR12MB6369D69C432A2052DF49B587C1A59@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369D69C432A2052DF49B587C1A59@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-07T14:54:46.460Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98bf7103-b716-4db1-6d4d-08da4895aa3e
x-ms-traffictypediagnostic: BN9PR12MB5050:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5050B8319365A85FB797D792F7A59@BN9PR12MB5050.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jRWg/76TT8IsEtdHs7kCvx6akLdh+4kLKY13+SHhncZUhbvCqPibxARyz+WFP+furLRAY+Pwe6TadJHwgHMds3INhaznwb5JJxkTXZ6kC2pBCwwF6lZJmoeZ29/Itg2BSRiWIBg/e/pj4EfmdCgg7H83ulEwWc3x6w7AEy13nc2jqPN72OOWZGW0ajFRU5PDMhuOnU6b3vMD8nmEEhH0nO1uKesuXH+LAPsjJmSu5VL2eePooRI/oKxlzR3kRbalV4GMoFrjoTPdCc4px8jkiHM9jyYdUvi8lFcFIugJKZGi/6PDNqIGH/3EfTmyKXuNzv3xsYH5OUS2rGub2LhxixaSJWdkdMdbi3/GHuujp1op6haIqA4FMDXgnewMtuS38mGep/Cmi23zfEXLJMtSOZrR1DGkX6L7VGBMvZk9KmVQvkHNMDfmouQ7ryOumkjY9pS39xbhCGTxbZ0PTB82B1E58eCG20cnEpJPHhbEGzf27Rz6+2N47UCzZ8uL5xss0y9bL0xAjDZMdJzrEOhGx5YdyGT/PQjgxQw9WMLcCHpIwFlalksiu4G9105kz40WUQk8l5NFvw42CrujWNCcmTMfgOql2+wxj1bS4uTf9b4tcJpd7tUKNHbpiCXl2ABSik7B/7CpiSgKyjDuN70+iulYpIUh5Kjnfr/PG/TbBkAQLgmexT9q5ijw6uFWpZlouGKc3htxlWDMc6Zx/OKag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66946007)(19627405001)(66556008)(38070700005)(4326008)(83380400001)(2906002)(71200400001)(55016003)(26005)(9686003)(110136005)(316002)(54906003)(6506007)(186003)(53546011)(7696005)(33656002)(5660300002)(38100700002)(76116006)(508600001)(8676002)(8936002)(66476007)(66446008)(52536014)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6gyNdW7yNWvPZpYOOY6P8HiGlOrG4dKszB5VtjFsNCDdIhn0OQyVvcvV0VsP?=
 =?us-ascii?Q?89umxrUK7WFAhHG6Frx/WxEB+uyhzXN9jDaDsSPfciYsnZjEjjw17y8BU5/V?=
 =?us-ascii?Q?oxo6JtcorDHAAvO4cNmvT9+axHwDaMotkG2cWJ4hzH46UwroWx6PDHd+CJKZ?=
 =?us-ascii?Q?aayY2dDTiOHSnXwoayKujlUvZAoEwk9nZM1YIKCffGPt3LwmqUVpSKIW+XF6?=
 =?us-ascii?Q?ffuo94UX8YrbodIww4BXVtJWApWjhG+iA2LEGqlgkET3v2zM5ydsNHQsfdHB?=
 =?us-ascii?Q?i9iBe/bIxk8PLdXpKnenHPHWjWfM69dYAFd/FjO+nvNYOSqoV4Aal8zpKAZS?=
 =?us-ascii?Q?1TONu+U37jwN6GeilYKqZPUiVimuXWngF13dnXt4Tn6h6dXfqkUOGUXJj+Kk?=
 =?us-ascii?Q?uvd9/iFZT15WDi9wJvNAeCcN57lEB7tknCPYuJZdeYVz2P9IDvHmjCrxQWpP?=
 =?us-ascii?Q?F48jg+WqDCQ263/RmAJRAHI9onTsI0q/mGlbJlyHK9XyElWhjH2EepNR4UA2?=
 =?us-ascii?Q?lGQueX+MQP0u7UQ8GCGwKQpsMBPKwXuR/i4gMdOpozeVUPSm1+I46BS0Kn7b?=
 =?us-ascii?Q?oCdGLBxyZfyHc1n9SvoJmRHwQn7Q28pl/Ah4bEG+40jiLcKc0zZ9wIAhMOKR?=
 =?us-ascii?Q?QCzYfkfaAp5u4wBEkhWFg9bHAbOGpjm3OWKJ8/j49Tjd13om1nbVFPZxQWec?=
 =?us-ascii?Q?IJQvOSdE2cPRuooTiwFGtmCaz3kfD6vEOtMdWz+2a7p1N9yt3LGiqwGTrFIj?=
 =?us-ascii?Q?3FzjGq4ayGpLJ7yJk/wumchxkuzHX4KT5wbozZj+2R3QqhXTKYeZ3/jUAcKw?=
 =?us-ascii?Q?qy73GkTawXmUYMFiT0iZVNVoOtVFIxyW1se6sOS9VaY2lc26aKqm3wGjRMOO?=
 =?us-ascii?Q?WabJE4uvi8iFu3B3dke7I5rtvSAoQjQ+D4EvZGLr+swLKVrPHiuAl6xiad7A?=
 =?us-ascii?Q?HQLY4oGQAxk/qJMpYmp5QxubSXs2L38HXVT3XpcAKbkVo/VWn0C85Vsd/ohE?=
 =?us-ascii?Q?ikD2lzHEZGevrm+mNmsJQUQpYqe1MjKx7pIGCE9aiLDyqiravSAvt2qLx3wt?=
 =?us-ascii?Q?4aEa6augicwHdkIefPQ5BiWWUtDRt+oaq08ZIWPzgyG9ohRyRMAL5cmdZlD3?=
 =?us-ascii?Q?+C2vfDIfdICRbPZHuIjIOqdEHA6CKzdicHERts7LSAL5bcCJTjii3RLBgWC8?=
 =?us-ascii?Q?OiJLi4kLj82je6GEbfqw6hXwp5EVOkTyh4vxyYfIJ5kWJngCR1Em6PWEkgyK?=
 =?us-ascii?Q?ofF3/FSZcqP4rwPbxDevZYMZy8UXY2I2UPFR7Y5hUPJBBNIlJw50hLy8t9fy?=
 =?us-ascii?Q?/3xrU71Kv9orEIkNQEUt5wlCqQfmcNGjMfF656CeiDylKQS45IS/Ag6Nv1XL?=
 =?us-ascii?Q?FB6VocUsW4quNaViaCv/UzRP/DMOFgGVXn1S4cH1croO/x8XGSsCOqQIAQcg?=
 =?us-ascii?Q?WBgTTkvIH7ulW8r1rHUB17NuIxOsHk2aBgByRRP2EzkCHPO8wLeIWLjhD0xn?=
 =?us-ascii?Q?x/IHLJt0/Qb08Ua1pOFgR4BF3krNSEx1ArKK2fzMv8iKbLJuhzZUGikKunIX?=
 =?us-ascii?Q?Vaeq4gx8AMcn1glJ+9FT2rX0Zo+upMDhRVFTsy9hbkwGwj4kd+/T+JMI0+oL?=
 =?us-ascii?Q?fnoOMcSsJ7gJA7wOLXqpLiRfZMAGSaoVBvb4tG4/yrUQ6qlUp9gutVLR0NT+?=
 =?us-ascii?Q?D+iB302HJ1H7nwHnfrgl9krOZTUpU/mfVWTswUeZkyHdB2/zbTHMsWY2SvL2?=
 =?us-ascii?Q?hu9yTINUtQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C65545B53C25082A61D6F7A59BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bf7103-b716-4db1-6d4d-08da4895aa3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:54:46.9421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ptc+FPNfPLmSqqOBflCkIRncdRnRWgYr8ERTrlk749PL9DZzjImxFUiH1YNFVD39m1swRhlG3QLbJmZtZoVTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: "Huang, Tim" <Tim.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C65545B53C25082A61D6F7A59BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, June 7, 2022 10:36 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Huang, Tim <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish=
 loading both pipe MES FWs.

[AMD Official Use Only - General]

Ping

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, June 6, 2022 6:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish loa=
ding both pipe MES FWs.

invalid/prime icahce operation takes effect on both pipes cuconrrently, the=
refore CP_MES_IC_BASE_LO/HI and CP_MES_MDBASE_LO/HI have to be both set bef=
ore prime icache. Otherwise MES hardware gets garbage data in above regster=
s and causes page fault

[  470.873200] amdgpu 0000:33:00.0: amdgpu: [gfxhub] page fault (src_id:0 r=
ing:217 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  470.873222] amdgpu 0000:33:00.0: amdgpu:   in page starting at address 0=
x000092cb89b00000 from client 10
[  470.873234] amdgpu 0000:33:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS=
:0x00000BB3
[  470.873242] amdgpu 0000:33:00.0: amdgpu:      Faulty UTCL2 client ID: CP=
C (0x5)
[  470.873247] amdgpu 0000:33:00.0: amdgpu:      MORE_FAULTS: 0x1
[  470.873251] amdgpu 0000:33:00.0: amdgpu:      WALKER_ERROR: 0x1
[  470.873256] amdgpu 0000:33:00.0: amdgpu:      PERMISSION_FAULTS: 0xb
[  470.873260] amdgpu 0000:33:00.0: amdgpu:      MAPPING_ERROR: 0x1
[  470.873264] amdgpu 0000:33:00.0: amdgpu:      RW: 0x0

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index fcf51947bb18..9741b7ff4224 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -541,7 +541,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)

 /* This function is for backdoor MES firmware */  static int mes_v11_0_loa=
d_microcode(struct amdgpu_device *adev,
-                                   enum admgpu_mes_pipe pipe)
+                                   enum admgpu_mes_pipe pipe, bool prime_i=
cache)
 {
         int r;
         uint32_t data;
@@ -593,16 +593,18 @@ static int mes_v11_0_load_microcode(struct amdgpu_dev=
ice *adev,
         /* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
         WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);

-       /* invalidate ICACHE */
-       data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-       data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
-       data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1=
);
-       WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
-
-       /* prime the ICACHE. */
-       data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-       data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-       WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+       if (prime_icache) {
+               /* invalidate ICACHE */
+               data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+               data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACH=
E, 0);
+               data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_=
CACHE, 1);
+               WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+
+               /* prime the ICACHE. */
+               data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+               data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACH=
E, 1);
+               WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+       }

         soc21_grbm_select(adev, 0, 0, 0, 0);
         mutex_unlock(&adev->srbm_mutex);
@@ -1044,17 +1046,19 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_devi=
ce *adev)
         int r =3D 0;

         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
-               r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE);
+
+               r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, t=
rue);
                 if (r) {
                         DRM_ERROR("failed to load MES kiq fw, r=3D%d\n", r=
);
                         return r;
                 }

-               r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE)=
;
+               r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE,=
 false);
                 if (r) {
                         DRM_ERROR("failed to load MES fw, r=3D%d\n", r);
                         return r;
                 }
+
         }

         mes_v11_0_enable(adev, true);
@@ -1086,7 +1090,7 @@ static int mes_v11_0_hw_init(void *handle)
         if (!adev->enable_mes_kiq) {
                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT)=
 {
                         r =3D mes_v11_0_load_microcode(adev,
-                                            AMDGPU_MES_SCHED_PIPE);
+                                            AMDGPU_MES_SCHED_PIPE, true);
                         if (r) {
                                 DRM_ERROR("failed to MES fw, r=3D%d\n", r)=
;
                                 return r;
--
2.35.1

--_000_BL1PR12MB5144C65545B53C25082A61D6F7A59BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 7, 2022 10:36 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Du, Xiaoj=
ian &lt;Xiaojian.Du@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/mes: only invalid/prime icache after=
 finish loading both pipe MES FWs.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - General]<br>
<br>
Ping<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Yi=
fan Zhang<br>
Sent: Monday, June 6, 2022 6:40 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yifan &lt;=
Yifan1.Zhang@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish loa=
ding both pipe MES FWs.<br>
<br>
invalid/prime icahce operation takes effect on both pipes cuconrrently, the=
refore CP_MES_IC_BASE_LO/HI and CP_MES_MDBASE_LO/HI have to be both set bef=
ore prime icache. Otherwise MES hardware gets garbage data in above regster=
s and causes page fault<br>
<br>
[&nbsp; 470.873200] amdgpu 0000:33:00.0: amdgpu: [gfxhub] page fault (src_i=
d:0 ring:217 vmid:0 pasid:0, for process&nbsp; pid 0 thread&nbsp; pid 0)<br=
>
[&nbsp; 470.873222] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp; in page starti=
ng at address 0x000092cb89b00000 from client 10<br>
[&nbsp; 470.873234] amdgpu 0000:33:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_S=
TATUS:0x00000BB3<br>
[&nbsp; 470.873242] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; Faulty UTCL2 client ID: CPC (0x5)<br>
[&nbsp; 470.873247] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MORE_FAULTS: 0x1<br>
[&nbsp; 470.873251] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WALKER_ERROR: 0x1<br>
[&nbsp; 470.873256] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PERMISSION_FAULTS: 0xb<br>
[&nbsp; 470.873260] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MAPPING_ERROR: 0x1<br>
[&nbsp; 470.873264] amdgpu 0000:33:00.0: amdgpu:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; RW: 0x0<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 +++++++++++++++----------=
-<br>
&nbsp;1 file changed, 18 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index fcf51947bb18..9741b7ff4224 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -541,7 +541,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)<br>
&nbsp;<br>
&nbsp;/* This function is for backdoor MES firmware */&nbsp; static int mes=
_v11_0_load_microcode(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum admgpu_mes_pip=
e pipe)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum admgpu_mes_pip=
e pipe, bool prime_icache)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
@@ -593,16 +593,18 @@ static int mes_v11_0_load_microcode(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set 0x3FFFF (256K-1) to=
 CP_MES_MDBOUND_LO */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_=
MES_MDBOUND_LO, 0x3FFFF);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* invalidate ICACHE */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_ME=
S_IC_OP_CNTL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_I=
C_OP_CNTL, PRIME_ICACHE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_I=
C_OP_CNTL, INVALIDATE_CACHE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_MES_IC_OP_C=
NTL, data);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* prime the ICACHE. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_ME=
S_IC_OP_CNTL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_I=
C_OP_CNTL, PRIME_ICACHE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_MES_IC_OP_C=
NTL, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prime_icache) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* invalidate ICACHE */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE=
, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* prime the ICACHE. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0,=
 0, 0, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;srbm_mutex);<br>
@@ -1044,17 +1046,19 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load=
_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;failed to load MES kiq fw, r=3D%d\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, fals=
e);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;failed to load MES fw, r=3D%d\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v11_0_enable(adev, tru=
e);<br>
@@ -1086,7 +1090,7 @@ static int mes_v11_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;enable_mes_k=
iq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD=
_DIRECT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 mes_v11_0_load_microcode(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MES_SCHED_PIPE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MES_SCHED_PIPE, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to MES fw=
, r=3D%d\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
--<br>
2.35.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C65545B53C25082A61D6F7A59BL1PR12MB5144namp_--
