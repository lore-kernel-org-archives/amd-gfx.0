Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E66C47DA2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 12:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393F410E086;
	Wed, 17 Jan 2024 12:09:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5DE10E09D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 12:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJySa8EiK8YDgnwbNNsaRgyga6bZVAUhX4TTFH3SHK/ORaYBt/40gRbBVsKhMoRV9f0XSu7I7F8Run4cQZWPU4NZpm28EmrNzC1BQoPTK0MtD+xedRwVH7wT5svC0BK3IpqoXJ/h/LIxkTiAcDK8AOlRCX/XBPHGo3AhHxDc20iBGpLvGjZUk/sLkuXWvM6d9z4pC4Hn+VU+bnm8bxyn1EodVLSA69AFhmK/5jNe7qJtmVD2mUD8mNTA7xAYk1c8xF6iI+IHamQv+xbLDxssLnX4sTVlzUxjd7iivVNxqrA7zEYY+zFnD3+UYqG7PGICmZi6wFh8XGy2neFKgO9TJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6zcPaQR1uPsIhwB1pDFqG888+CyhNASdM9o4NrCf5E=;
 b=nf3I6lhsgdgpZbLrQWG6vjly0X6Mc4/K/CJK36V899i+RwWQeDOtgm7qV21AvOCaG98IquehK8ZW7B+d4pxG8qmfe3zcZ8ZVwzzzwenQjxkYLGV48KHe4JdfCBlYjv9rVuSOmMaYhNlshJH2fDr0282U2a9hM9W9BEHsE34eSIP12Js5Qid1gbkhg5dceDl+oREU0q3B/NjQzyw76OTrj8ztHBNDJXy475GCjDznPk9aOsQMpFMmVb8c0Eko1kAZjqbAGjVQDyFni5qy+F6kWHSlbwCw1TqXv8jK5wVrx3fXG69x53OfFCPGJouz3h8GtCQ1SaFNnnV7uXao2oLhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6zcPaQR1uPsIhwB1pDFqG888+CyhNASdM9o4NrCf5E=;
 b=jrJBJLALzosRW+nyBHAy62DSdrYbo3u8ad1EjCgacmKpMj/Mh3dTSaO3WpEFN8xtw+kbKgIcXBjmho75StcQE3mbsl/LO61nSpmxi3aJ2/usBO4cDunDo/5oKtd3sCDHn364S9AUkCrSQdSqauAX0qyEmz8FONsNWZIYh8YtNXU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 12:08:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 12:08:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] update check condition of query for ras page retire
Thread-Topic: [PATCH 2/2] update check condition of query for ras page retire
Thread-Index: AQHaSSWoA0BwqveK+Ee73ar65tg/dLDd6SUw
Date: Wed, 17 Jan 2024 12:08:38 +0000
Message-ID: <BN9PR12MB5257A35A7FCCF270C82EEFBDFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240117091430.29140-1-tao.zhou1@amd.com>
 <20240117091430.29140-2-tao.zhou1@amd.com>
In-Reply-To: <20240117091430.29140-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5342b37a-e175-433a-abea-c0bb0332a21d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T12:07:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB7689:EE_
x-ms-office365-filtering-correlation-id: ade00a7e-e64a-4c5e-044e-08dc17550a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFrTJiN1dOO/QRRQFoJzQ8frQYVr7uNZTgjBndCXoxR6gWB4lyyrctQnBg7fC1Tj6ki7JaDScJm7jELkV7AiASyyn2Ans5tMfsCWy3xVp3I/VT4WRUD9gJlq6AiI4G5sopjcJYDkosuuZNwDV2wKjkTgKLPNL++q3AesGCrgsY6+OS6bqfVMQfusVo8eOrr8PqAM7sVFiD5HF4qKYM7cFiP+Oa1r5yP3qqu/GOJO1iPbyCTYz5cmvK85XFODg3LCfPWoOlMdqGyn2ihFFAtcP60OSEzqUeO9VRlvw9051HSu/5wQjwcYHKqprshMJDtPZtiz+GY4sEV34F77ZyYYEEW6zofDkpc0bRlTU8eBbkyS7pXfnvY3zGgDBUIZ808CGOXSxoI8Z9lOxYx2DWLlGeQntSonWkvLGR5yj0Z6XN/RJ1QbCMx0tbbQuTvmimQYRJkl7tuLZ/jbE4kSeYN0BiuLYWLGS4W5qA9DxL7wp97lzZHEgJ8o63El4JcZTLKnaPeZQV/sFpl7pYHq/exOASPn5RtY/2ZstbenR9EQzhdXexW9tupJrAs7rT+WLpTGCVeuniTvtWkongbo3lX6UeX2WX1hlpLmK0sPbiRe3/PmThgCbL6Kfolfg3pB8Jb3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(122000001)(83380400001)(38070700009)(86362001)(52536014)(76116006)(110136005)(66946007)(316002)(64756008)(66446008)(66476007)(66556008)(8936002)(2906002)(4326008)(8676002)(5660300002)(15650500001)(26005)(71200400001)(33656002)(478600001)(7696005)(9686003)(6506007)(53546011)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bo+MtIQnUAm/Vengxw2tSUm3g4+RAXW6ZQjRQJWLbLvIETC6qjm9Rk3b0W/F?=
 =?us-ascii?Q?FP2XA2r1UJjea/YsE0Xd6kZ99YJWk0Bu+wcCMPmoP7ZkLdo1409lJlKqPju8?=
 =?us-ascii?Q?5YXx7Wi00MNYCyK5s7QfDAkeVzg0KZ4+vQNL/E//duv4C8t2RHNZt5J/1ZAv?=
 =?us-ascii?Q?Xag3my8i6h/FhD/gLtcTXzkqiaizJrx4TZGF7jzhj64yOpPCfOtmVdjvK9M0?=
 =?us-ascii?Q?ZymCB8soLoANsDloSFExUr8pApV3EkDMtWAVS4fPnEOeX0uZwEtHIXGU9zbG?=
 =?us-ascii?Q?Za0MzX7WOMdQ7a5xzdQPkv2fM3gJKpcYxaPiRKO/e0EOYx9WRqgOWWebT0/S?=
 =?us-ascii?Q?sRQn8niIsU1fyNWqRP9fPm+hIGvL4WCmR4Xh1RfTi/tYDYWmQ2ETHXRmzT/U?=
 =?us-ascii?Q?DUDsBVvwc2m6eivCMzZhMbSkA0lHHICrxvr4n748J4rObdrxcB3Gn2qsHqDU?=
 =?us-ascii?Q?Y6fjDvgfsLJJ8CmDnNExOSnaNlO+5scAyOYlWtYFEsSz4J/Vc+fUF4f1ukx2?=
 =?us-ascii?Q?tnY5lE1o7LbFCgHIQnPFm25RmvbGRbZSbeRp2QgUYUZjczZNwGvm9wcI++tq?=
 =?us-ascii?Q?lMADvW7EiXUDclMwWqSz5x9/xruOtd0G16x3Op7wLDSFizE3BHvrUJglhuzI?=
 =?us-ascii?Q?adci7cSNqqktHR9Pcd0BBdFdh1Y21c5MKpnfQUB/Gsaw8LjmYC+C0sofsqZZ?=
 =?us-ascii?Q?y8YI3i7P92IyXwzUZk5ABA7vaV65YFN8AiVodSim6NBsoPeaKDEEBgUAuoRb?=
 =?us-ascii?Q?VOCnnbbjeNF5dDvn94cvLUywAq3NhdC0OpmYfK5ljekWtIu1IjH45QEOpJgd?=
 =?us-ascii?Q?C3Yoy/oulVJp/Egxfc8rAolsxuuQWrOTuTV6ncIepbkuWiJ+iChBpiEVGRHY?=
 =?us-ascii?Q?GZELo6UBm6OyiGHUTg7TDe7fLMizrmJfr5+L+/aSJUYr704cB3CJ/LAQhakm?=
 =?us-ascii?Q?R0fa3q50tZX9LTrHMvW6t6Al+YqFlUles+ng5DOfxAlbpVD8gwyqf6yC23u2?=
 =?us-ascii?Q?AYvYXTTYxSjRZ6vbFVd50k4Xv5pqLVocFBuXwE+cpL/zNtXKcdOlarTGlNCf?=
 =?us-ascii?Q?W5g3Cf9SLmcnx52dPeg7OtAbPTgj0NRIeynfSrHA1/hRnooDt8xUz+cKXKRR?=
 =?us-ascii?Q?VEsqALA9yCcT+sUgJhsn5Ya09PIwuWOCK3cWhWi7/Ta3+XibscooGAWpvVv9?=
 =?us-ascii?Q?j5iWIFxv9Opl+4A6dc6ke+mTGNGHPO+8ggCytm7AxgB2wbqIo5xpzwaWyLaC?=
 =?us-ascii?Q?7njEmtq0uVXlNVQzt+IL5RcJP6NjKZGVGVdsNxiyCDoJ2dZpG8da2kO4XyDs?=
 =?us-ascii?Q?6FLDIL3PZ3ZBhxTC+3zwa4Om5+WTgnO9N+RxB4uUoojaIvcWxowy0QiY9TEq?=
 =?us-ascii?Q?x/ryxCafW9gpSfsKkYw3aLfyavWsfBBmx8OdKKC1cHxt/DxXPMSeV0nF8StF?=
 =?us-ascii?Q?r1wzQQGDFZp7HCyGWt7dFYs/iPO+27MIL6HBQxL5Xo27CjDZfwQCWqmAPGtx?=
 =?us-ascii?Q?EnaYUbqgwHxl0vskgOdgOEuy8yJpoStxE47AAf+suxwTCvG8T35kCSzxaSc8?=
 =?us-ascii?Q?iM7B2IqUhrfjGybenPIf1SQvjZUt3m8Iy7NYUeS0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade00a7e-e64a-4c5e-044e-08dc17550a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 12:08:38.8139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5tJ1VyEZMVeeWlSi52PjGL/hTzE3nr+mYVeAyBQn4V4d+LzqrzeE1goDBTVnWveXbYl01TM9zxDfKPM0HrM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
                        void *table)
 {
-       /* Support ecc info by default */
-       return 0;
+       /* we use debug mode flag instead of this interface */
+       return -EOPNOTSUPP;
 }

Shall we just drop the callback implementation? smu_get_ecc_info will retur=
n -EOPNOTSUPP if the callback is not supported.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, January 17, 2024 17:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] update check condition of query for ras page retire

Support page retirement handling in debug mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c              | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 41139bac7643..6df32f0afd89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -90,12 +90,16 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_d=
evice *adev,  {
        struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       unsigned int error_query_mode;
        int ret =3D 0;

+       amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
+
        mutex_lock(&con->page_retirement_lock);

        ret =3D amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-       if (ret =3D=3D -EOPNOTSUPP) {
+       if (ret =3D=3D -EOPNOTSUPP &&
+           error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY) {
                if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
                    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
                    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(=
adev, ras_error_status); @@ -119,7 +123,8 @@ static void amdgpu_umc_handle_=
bad_pages(struct amdgpu_device *adev,
                         */
                        adev->umc.ras->ras_block.hw_ops->query_ras_error_ad=
dress(adev, ras_error_status);
                }
-       } else if (!ret) {
+       } else if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERROR_QUERY =
||
+           (!ret && error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY)=
) {
                if (adev->umc.ras &&
                    adev->umc.ras->ecc_info_query_ras_error_count)
                    adev->umc.ras->ecc_info_query_ras_error_count(adev, ras=
_error_status); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6=
_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c560f4af214d..d86c9e7fc64b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2909,8 +2909,8 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct=
 smu_context *smu,  static ssize_t smu_v13_0_6_get_ecc_info(struct smu_cont=
ext *smu,
                        void *table)
 {
-       /* Support ecc info by default */
-       return 0;
+       /* we use debug mode flag instead of this interface */
+       return -EOPNOTSUPP;
 }

 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
--
2.35.1

