Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880AFCD6E56
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 10:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B3910E64A;
	Wed, 11 Oct 2023 10:12:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EFD10E04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 10:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTYAPFHUi3UyNL1e+Ig7N+nLXHayBfw0/LlO1G9sAYq2w73HEfBkXSN5NFE+v6rr28PetRXbsR3wZyItL4LQCiRwtAkAS5ZWH49at8OBxM8XiyYvZTeKViaVageKISTYxmrYHdgyF36VkrnJzxZJnE3fM+f8zol4HaWoVHtQSGP9bCGwc2ulC1zPEG1Ht8Lt1l8Ci19YfoJ4/jpVRF1YblY94OWX8GlW+2C4wNs1QCrdHSV+rTkcWy2YRtWYi13u/DbvqX2aqq7we72A+d4noRjIWVOo9WeXGU95U1Zt0N9R8EDCpIyVpa48BcdOSJeoRcTHJ3cKVYDnDvhLBqmzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJe3I7ZApww9ZWwnIW2jUfX8lnY3cUFH4Ts0A1chtx8=;
 b=k8OqqgSJ8JvZeHfoRlcccYZ/YCQSO9B0RFpAlydv0PXG/6KNTZpc9aX/QB67hJE54Kz3FtVCUnF7Ge47JGHoJAdRgRvVv/qlBHIJqChVTpbLN1O4bHjD0ANfIaq8EtNHQUoo1ErrmeDM0ZztlUSaA972p0UezEhBO80D7z0Fl0Bi6+b7J5Ug2M6d8/RUwEawPr6LxsvpkfdMGEtsaWTAHi53LVdDumLP11C2RZLT/pWK9adVKbwfT8I3+59oE+wKlcnj6DhJOkusSDQSfJjAu3EjEb/RiH9VZmoE8WvsTyxzUu5O1fzmMwW00Iy/PnOGFwzk2L39diTcYw/4VLQO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJe3I7ZApww9ZWwnIW2jUfX8lnY3cUFH4Ts0A1chtx8=;
 b=3bsUJmTdDnG47urT9wteaUSvJxmTjr0Q3Dvl3A5N13sDR36Bklkk29qt1+W31Ae9bT1Ejdwb0VOafnaLlvlj9/I4V9oYr8NS9VUERCi/npfmuq1us2VQECtKid2KVi2Qn8YEfe8HqiKxF2IabtGonJOoBZV5DMKhMUKnDn9r4FA=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 10:12:16 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6267:6ad7:2bd:3094]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6267:6ad7:2bd:3094%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 10:12:16 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: Program xcp_ctl registers as needed"
Thread-Topic: [PATCH] Revert "drm/amdgpu: Program xcp_ctl registers as needed"
Thread-Index: AQHZ/CctWsDqSTXRy06XQoh/l2xh0rBEXlGg
Date: Wed, 11 Oct 2023 10:12:15 +0000
Message-ID: <DS7PR12MB6071899BB7E4160735BF12498ECCA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231011094127.199320-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20231011094127.199320-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32d0ba88-3523-4245-a3e1-43c5c3df5cfd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-11T10:11:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM6PR12MB4372:EE_
x-ms-office365-filtering-correlation-id: 015ba7c2-5cf8-494b-9a74-08dbca428b78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDwQUKoDRJaV5PrnycTtZVopOayO+aqgwMOfi7DJuvto4k9p/9dx2wtAjtRAuUyGFZkOs6SHpwx7mrQ1RS4kZdI271Ac3gVQFyQmJmlp3UOchy/CdpFnZID6Q1JvsMJWD4m+O73vDqOw7ccfPxhK2EYCUUJsN8veyzyMvrjqMDB2DYODDlWin3MVWZQbjgwllsO0eI37T8bcSGCrdoTk78KdztPZ3kds4RK2m9P4makdgjYNqbq3RbrHdaGhGfXE4LUBrgyy3T9m4FocJforWk2RVA9dwoyfKXkBq2b6DrEF2UusYv5dZ/TQ3RXFa65BM+XX6eUFh+BPIE33DcRTkrAcP3GsYdNXZNoyOCU4vQUiRbTjILj3EGVb8qWjwRFyTV1Y85lZqBrVSn52ZEEN+3vu0oOSZvRfFJqVWNacK0UX0YqD8NF2z7CGKrDWD5HDJVi2oc16pOQAezSg6YCUrcfE+Ds9my0cKkF3h1ylzLmpw7MUXXBfE3pDO6PX3YAZeGiDCMJM8anEhiik/8gnO5j6kifGLIg59lbQlRZXMPayNfkAvqeNelxjQwltCc/Z6TVmDtMtV/yfj/a97/0NP8lRKxWKyl/BBZjuG6ATxeHU+2PGgmahCNxXFZllKSqNn8yAOtPUSKZiyVIOnnWE9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700005)(55016003)(5660300002)(41300700001)(122000001)(8676002)(52536014)(921005)(8936002)(4326008)(33656002)(86362001)(2906002)(6506007)(53546011)(7696005)(9686003)(478600001)(83380400001)(26005)(71200400001)(316002)(110136005)(6636002)(66476007)(66446008)(66556008)(66946007)(76116006)(64756008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AySe5gjtxUtvXxBXrkY/x4Vdm7fv4tMvETR0Lsh8EX5BaDoTdRHcPbkbBUue?=
 =?us-ascii?Q?GywP/5JIiD2YJVzm9nLu9PgGHJEvF9XiE6kMfNMWfOyO5TWiNkn4nIAAMVr2?=
 =?us-ascii?Q?yw4pokrEep+Y1EzqxMgGrTptcRpPcS0tcbuVW88upkn0XFacVtD2FM56JTzw?=
 =?us-ascii?Q?aNCRwnUgh0n7TqVRMrJbDHjlkOhmmr2RjxtkE/KFcZObRgw5O2wx3xN3QjhY?=
 =?us-ascii?Q?8b1iEI4/5r7uqJhtbraC/8Id3nwYusmcKt+Uv3pYzctXq5Xn6EjFrs1hinvI?=
 =?us-ascii?Q?1ePnSRxubXtMQUV8xdYoWUXU2QXE49v1pxEXtIAPvOVeEPGafqZRdw42f4Nx?=
 =?us-ascii?Q?gE0ebu/KhCJcWlH9A6p4JuH+zfjwl8Jo/RtFdSGyaOzUAE3PXIZheReDQkoF?=
 =?us-ascii?Q?teYtNyDVal+WRx0T1doyqsBXqcQ/GFYZYKMDiY718WxhYyKQJ6hq3uBiIppt?=
 =?us-ascii?Q?uBR8VXyR7L/NbZfcP8MsCDfphr8sZ09bnU2LAGTC19qZ/YfxOhUyPnYscLs3?=
 =?us-ascii?Q?qYib9Mq5/CSWyKxpfdehG6eFYgLSHRLDQ+iHnrv0JYboiojaXRIXc2KnxZe3?=
 =?us-ascii?Q?Zybh6/RqJ57fnMr59jrho7DxhyYjiiGylRBzXAOMxpBtDF8rrceNopD4Zb1z?=
 =?us-ascii?Q?YQwqGbYD+WPvv6eJBRWBYdCJupDT8rgwOigUhFUFAOAobf8ag1pKQ0054rhf?=
 =?us-ascii?Q?qDl18Vwq5loJbyG7PhjPtkyutNaOnLdhllvTRLJZ2GkOHQPlJ6v0B+C5634n?=
 =?us-ascii?Q?3KasgxW04FfSe/35kMAWkLbwWUhpe6KNhM4+s3GuhdSw+O3o/iRnvPXBxSy2?=
 =?us-ascii?Q?7A7UGFStXJueC0876M8T+/w8ruX8hCHUWYT0OupbRnTf2Ok3FAEvVNYcj3yP?=
 =?us-ascii?Q?IZBkASHNhegqnpX8dAH0guukl9aokat+MCPyiHZ4gx4xbFwf9nQSYd0QQncy?=
 =?us-ascii?Q?C3i875yUkC7bH8d1AYkqjqVCG9VZPFuyY2s3uqHJnoGUoJdiwPAohQfZcMmu?=
 =?us-ascii?Q?EMI6EWK4AD62RSjTS5SeDWOZe9nhuH1Dk4r+2d7LFLtrF8xvytv/lm/6G/pD?=
 =?us-ascii?Q?5V16SK6EvmGZUnnQr+av27XqoK3kxXDoZw79rnvecY45jWI6lQb7nFnjCwAT?=
 =?us-ascii?Q?ZwbqBius/yRymwxTMuyIyx3y8rsqo982PhsZ+JKBBxSPUr1Zk42et+mCLWM5?=
 =?us-ascii?Q?+iDAkSq4r1myIO5WyZmNfJyQHETTs3quefGc3YD2KMo7QFsvq6RYbenJGK8k?=
 =?us-ascii?Q?ebn1AnS2VfeNh8vX91Cu/pNAMneLyeTWImuRYKyktuYa3mMZdTeG6ytvIYQC?=
 =?us-ascii?Q?a6C17f8OxixdEQNyRj220tlsYHbplme6bX8whowxMhRIMzgn1vQhWXmtzIJv?=
 =?us-ascii?Q?wWSYsOLxvxMT5mBUzyHnC3IWByAT1zAfpj64WXgQwY2/LqDEdyPXfOQhk+EE?=
 =?us-ascii?Q?uXMEfDgDPdBUFStsFXy7qVt1kj27xDZXKf7/8Q0Cu5ulWavWoJRYj1/YCBxq?=
 =?us-ascii?Q?91ZtAi0nb3QiqRRbOOIYeKCDC7vgbFrmhhFIGTeXp+W4G+W2/6z3+apjr6tT?=
 =?us-ascii?Q?kQW8cOxxan2pslGrF4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015ba7c2-5cf8-494b-9a74-08dbca428b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 10:12:15.9113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJjyySVQSvfPh/OzbPoJC8CydALfCXbAe6UmmM/GT3/wANB2AKTmd0YdZbsW2IiVB1tnJJehAxHvPUFHzNQShA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Gadre, Mangesh <Mangesh.Gadre@amd.com>
Sent: Wednesday, October 11, 2023 3:11 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Sh=
iwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>
Subject: [PATCH] Revert "drm/amdgpu: Program xcp_ctl registers as needed"

This reverts commit 3cf01336313894419498a0d5eb367f092a436195.

XCP_CTL register is programmed by firmware and register access is protected=
.

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index fbfe0a1c4b19..39bc441695f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,7 +623,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct a=
mdgpu_device *adev,
                                                int num_xccs_per_xcp)
 {
        int ret, i, num_xcc;
-       u32 tmp =3D 0, regval;
+       u32 tmp =3D 0;

        if (adev->psp.funcs) {
                ret =3D psp_spatial_partition(&adev->psp, @@ -631,24 +631,2=
3 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *a=
dev,
                                                    num_xccs_per_xcp);
                if (ret)
                        return ret;
-       }
-
-       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       } else {
+               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);

-       for (i =3D 0; i < num_xcc; i++) {
-               tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-                                   num_xccs_per_xcp);
-               tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-                                   i % num_xccs_per_xcp);
-               regval =3D RREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_=
CTL);
-               if (regval !=3D tmp)
+               for (i =3D 0; i < num_xcc; i++) {
+                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_=
IN_XCP,
+                                           num_xccs_per_xcp);
+                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_=
XCC_ID,
+                                           i % num_xccs_per_xcp);
                        WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL=
,
                                     tmp);
+               }
+               ret =3D 0;
        }

        adev->gfx.num_xcc_per_xcp =3D num_xccs_per_xcp;

-       return 0;
+       return ret;
 }

 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_no=
de)
--
2.34.1

