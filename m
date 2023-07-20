Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B4EEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 07:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C309A10E568;
	Thu, 20 Jul 2023 07:30:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA3010E568
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 07:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py3RYHqow2OtVjKU0Q8vwSCgFF5xiQgeHYn7h1RMJBy2DBHKahX0xSBELGBEblZMz3vmT0Bc1ZtFDBGTysOCLRxCsbPb0XOIoIWLhJtVWGz/dl4IHJvVu3WW6R2pNlBry1dBUkWbnYHg8SjjKk1tA5/AonjOZINFP8Xd+oObAPDeATOQntZ/DjhQcQkXVT77cmOSklwV8R2SogpKi6r/N1E7o0VYHkEZFAK9b536be/CO1GtchNhPA0cj9siYo2X2hc2mMH856DgwjJ7OQWcyklWk3BbyL+J3gTjY4RCNgLmmrVjKuqmiXt+2gej55vUt/SYz4CMlMMfX52pA8k44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p49N6iYfj2Rij5nSf1ms53KtnBYqZ5oIoRxk36l0DT8=;
 b=eReWns2p0zHPsBbo/A2fq1oMSfxG+MKdB3jryx5lAV6k+zrbNNHep5Du9eu2+04/L9xiQLZUGMcP50coLTO4pC8WHBwOILuNL+h17Morjnjau1KVxdAg1iaknJoJcGT3Rj09zIGCfuDrE6UjKB18k86OA2kBL14gkGUo0xS7xmWh7hqifLfg2MeeTeixbwHC4Ivu70r3lF27J8W/20+FjGiceVmA9j5Vv9n3/WlzyuNWE4qbyrzH9Dj7Nja4B+wWQxoMLVG/Mwi47gHxTamoF1MhMJe/tkyzCNDniSe/mBamKKk7lnMBmwPx6iNwL4po+cbxNcWE5BYYjdHj4iu4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p49N6iYfj2Rij5nSf1ms53KtnBYqZ5oIoRxk36l0DT8=;
 b=G88qS3F023FWA7+ENAdWuMsuBYjCngKfpQ/edFzFFLqHE6VguZDLoC61Ss64liKbkXlSyPSI78xVvd3phkr3XX0L94UIUaas0VhfParnXsfjBOCAjgPXNh1kWTSZt1ddnM3UYkfq3g8/kFzxDmUObZOgg0H73rq6zlpnvCMTvQ8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 07:30:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 07:30:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Program xcp_ctl registers as needed
Thread-Topic: [PATCH] drm/amdgpu: Program xcp_ctl registers as needed
Thread-Index: AQHZus713yPLKLX/PU6odOmqD73Zza/CQnaA
Date: Thu, 20 Jul 2023 07:30:42 +0000
Message-ID: <BN9PR12MB5257A33D1B833C331DDBAA48FC3EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230720055624.3063280-1-lijo.lazar@amd.com>
In-Reply-To: <20230720055624.3063280-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d8ce4d44-445c-4003-b722-038965f66461;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-20T07:30:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB5864:EE_
x-ms-office365-filtering-correlation-id: f321c389-9d2c-4180-220f-08db88f3393b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwoHlwrhBc539SuMi+usTfDPT40/VvsJ3gB4hQgUmkDvAy2jQo9vfi8c3IlDw6hkVpY2vr1wbrABdqgMWAwecejQmkIJuAyck80CtyBCPh2j4ldFO/moazRbDyEtIo3KaEH9bFYop/rbsQlOovGaDdy/n7QQgFFrbd32CkV6OHzL78PZqcRT8s8crbrSYqq2FF1BFLjkLXE0Z4GM8gkwB2LHqw7p9GUcs8yFQSkYY1YhRLHSTnX8gO06ze1StHRVw5vap2S+1mSa3ok2M4x07n8yW05m5ncEmmc6yllSZuAbrw8Y+qR8LeZy6zLDV74jxSvEX34JBSWFwv+J8KwXyTxo0stKe5Tmb6c+jtdU81qx25oWFVaQCSP2MHZdg4XqTA6XwiWZpTSe8/gl6gbI8UWEPNR8VNGVsoHuywqIfWrR1x3OP1VwF+tBgajaDJUs46VXEThOQ86sMy5EXkxIMqLCHyapizsIH9JXD2Z74B7vO0/57M2wcOgXXyMG0Awasv56F7E9YbhIZ+FuoydWy3Cxcvdz4XxTCKREmDmkT6kWOU8PIpzzJGjvctn6oPCHJ43hr2SZfLIsQXMwP2pQer5lyFikOg30h7E184Man2KYuI9N3w7zDWp7ggXbJ+cK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(2906002)(478600001)(71200400001)(110136005)(7696005)(66476007)(8676002)(66556008)(54906003)(41300700001)(64756008)(316002)(76116006)(66446008)(66946007)(4326008)(8936002)(83380400001)(86362001)(122000001)(9686003)(55016003)(186003)(52536014)(53546011)(5660300002)(38070700005)(26005)(38100700002)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iybnC40YvqRe/VMK+M/GnjFIX2/py5+ysplunp3Eg+6fUQW+cdeLi3yOmrhV?=
 =?us-ascii?Q?yxReJyKypbGXNLEnjn7ztS5MhdZ3nAuZw0XuWMRZzBhKptXD/Lka8M8F+fMX?=
 =?us-ascii?Q?8XwFJVVvDkp6boY4/afSVVg6PQ3H445vvJbbrhVafVbDTk56YG4XsgPaKnqG?=
 =?us-ascii?Q?SdjrdmUjVHF1I4Fi9ZoJjYQwEoYaQSuyL778Jm8bNE/sOo4PVdGVybFH6eoj?=
 =?us-ascii?Q?Yyjhp+8SZHSSoEY0VjviylI2KDfZ8sRFXRC4smpLBeG5AoKCIx5kr+ZHLe0l?=
 =?us-ascii?Q?gzzH4DRT4fIgt5EUT4GodWnR9xb/xY74OhidD5nHMbtJbbzLbTPpiBjSdwlT?=
 =?us-ascii?Q?H8lwiy0bvTacrB1Le9eNfhWcB6x77SUFDfbHjZ7W9aWkyQJIjTtsLqB7a9E5?=
 =?us-ascii?Q?pwhjdtXRWmFEXltzA1u48ILz1fDoGwBvn1XRzvP30j7EGo1XoHAETNCP9hCg?=
 =?us-ascii?Q?xMFs9q6X5S1Li4FdGu5D/SadJm3I+Vbrb2xUvCHDEg4Lw0X0jG+7Cra9KHZn?=
 =?us-ascii?Q?ITj++yI3nrCPaPJfKtfc0J83pcK2vdQX50E1rRFdlrboS1lLipinWCXkOjVD?=
 =?us-ascii?Q?dNuTSWzDcKn9ctsgNhYJy9r9LlVy3lkqEtEK5yRgeV5Dya/uK6BAigp3tvSU?=
 =?us-ascii?Q?HOT2VqaLOn1h35yDhectgXbotasUxYsd65zVpr+jtzMDuKyziovvEjHQh2Au?=
 =?us-ascii?Q?O0Y5PJyBF0pFP87TXSnaUOHxSyKarZweCPKWtGKKXzgs1J2nDAASjLX896Zd?=
 =?us-ascii?Q?AxBM9z292D2ABRaYL4F0C4wBUFraD7jf8Ouh86liGnyzzoGm+YN9m9LS25/x?=
 =?us-ascii?Q?XVpMvmE8N1NNqloIYTEX+TEezZdC+Ssoa4CK1TXWaGwxsKBWhBwwHk5wUD5j?=
 =?us-ascii?Q?at6XQOnxoLzVFhA+Xx3vgD+ICvd1xOiWQSpSRkKPaTU15/zy4jCUg9YHIgaa?=
 =?us-ascii?Q?Y7cvvVUGRkF7BsNN7DNzJaD2mkx8H2YDHnqBDh4gCvFp+CO8jzC8ylJorzrU?=
 =?us-ascii?Q?JF8b9QuxOJ319HkK+ZDGnnJCky1m61XelDb998sR2kDXo6K7PMfu/xOjTEtI?=
 =?us-ascii?Q?8tOnKHfFv9XWSve/KpqleRhiy62PNfD8cbPaZ17TtipOXylSBvXw9zEGy9ws?=
 =?us-ascii?Q?OiOXwzqB2MpK6Kw08wOFqx9GF2q43OKlG9NrKPjmsBZB6QhQ/LDUoVprZSzU?=
 =?us-ascii?Q?szdY/s+IV7SkPx4u2L8bUWFVz2GFgjKjLWsuFUIPM+Klbs8t8+D3w3LK5cIK?=
 =?us-ascii?Q?RxJxPPyImOh6NlTiaOFn6q3SNP/5sSHufAnXNRWw47fhbAmlhR37e0JIuim+?=
 =?us-ascii?Q?zXJe0AFomyY4fuUyDfdrESNkkUoirACWW1aNDwnC3BVGVOhqXwZ4+0Qv4CCA?=
 =?us-ascii?Q?3h036LEK3c9GEL+2Rr8XGMIi/NtrbKpuJ5L9qxbJTjHsEDVTNfFJc/VbfrT9?=
 =?us-ascii?Q?+z7ZfYnv3uLj2CSZwZBoLcty/4trErHjhcEPtBjWu4ATGe3Dy+rF/posTNL3?=
 =?us-ascii?Q?y/M+9Oz1U7q34HJFhWA6G9IBMD+DVefTpYhzUHzM+0bp2a71ZuhwRhrbAns6?=
 =?us-ascii?Q?YuY4iyWqPWrZkuJppqX0DobH+VOH0M0cb3mXRE/5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f321c389-9d2c-4180-220f-08db88f3393b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 07:30:42.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F44uKXeGk+RyjHND7/B590w6rDkwIsylY5ajshG1Ynp3ZEK1LZ6yx+B2kiy4YRGbRKEyfnqaOd75pVTngNdzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, July 20, 2023 13:56
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Program xcp_ctl registers as needed

XCP_CTL register is expected to be programmed by firmware. Under certain co=
nditions FW may not have programmed it correctly. As a workaround, program =
it when FW has not programmed the right values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 738226ed6e50..c567be88c47d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -621,7 +621,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct a=
mdgpu_device *adev,
                                                int num_xccs_per_xcp)
 {
        int ret, i, num_xcc;
-       u32 tmp =3D 0;
+       u32 tmp =3D 0, regval;

        if (adev->psp.funcs) {
                ret =3D psp_spatial_partition(&adev->psp, @@ -629,23 +629,2=
4 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *a=
dev,
                                                    num_xccs_per_xcp);
                if (ret)
                        return ret;
-       } else {
-               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       }
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);

-               for (i =3D 0; i < num_xcc; i++) {
-                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_=
IN_XCP,
-                                           num_xccs_per_xcp);
-                       tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_=
XCC_ID,
-                                           i % num_xccs_per_xcp);
+       for (i =3D 0; i < num_xcc; i++) {
+               tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
+                                   num_xccs_per_xcp);
+               tmp =3D REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
+                                   i % num_xccs_per_xcp);
+               regval =3D RREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_=
CTL);
+               if (regval !=3D tmp)
                        WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL=
,
                                     tmp);
-               }
-               ret =3D 0;
        }

        adev->gfx.num_xcc_per_xcp =3D num_xccs_per_xcp;

-       return ret;
+       return 0;
 }

 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_no=
de)
--
2.25.1

