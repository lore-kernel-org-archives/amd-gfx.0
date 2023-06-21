Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E137DEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 01:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A94610E39D;
	Wed, 21 Jun 2023 01:28:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9044B10E39D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 01:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeF7+oNsZAKMsBkUooVXcHycmjirkJAgr5wnXN1BkAjzx/stqd7OE5Y7/2yRsNo6k/ThxHx3Im0VSLnCWCwGAWGhl9XqimLlx/aVKpKfpUm+QiXHnPntXj3lbiETnNIs9b2yRWMLff5SvoISFtL7d/f2KYCUhuLtNes6yk4HHKSiDXlgpVwf/7xfZJ8w24FtFODxFBnRDXJ1gXNo7ERroPyvsdFYH7JD98d96FywWiuP0agfbu6Gu2YrjAS8j50FY5gKnI7p6cwb2S4yVyICNZNLPT4snjLWRdPYa5bBhgdbLrHNKAkzqFKHQklGxt5TbBKhs+/rnj1XXanPrwpw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipgurp0NyoeMvuGyzwQ2/IXUbA3DCPNAMiMoAcvdOkw=;
 b=EXwarg+m+9jsnN/vJsZQjKwJlXUvvfzg8dvUtJT8KeWIgQslq2oOeLTGPp/aDMAU1NlF/+D989+b4bfXDyFWL6GP/81hfvgM9dgVqY2r+dcpJ1dlF8s6leaGZq8cdGAOGglA+aj8IsUIgmFlfYoWF4xYyZdSvsnAyCuU3U3jXL3H4th+KH3kpMi64pwuh5WMgz3AjiWgey/i5EDCO1kOJ78AR2GMSQ2kwrUw30WPX4u8KR2ryHdbvD6NdZtdcybvshdNMQNN/uPRBTGOhhGXA0zokocZkHeskZ8wa5UbYBuhD1cCYVt5tZA8/c2Os1dZ0KFF/igUrYf+kVTfTcpWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipgurp0NyoeMvuGyzwQ2/IXUbA3DCPNAMiMoAcvdOkw=;
 b=tKqHEJmOZ8aiqdT4swHozkk4oFGMUquwAClntnf7CrRqDhYD92vu0TqvF1UiYr2j5stNclWVPdF94uBuxSqrQ3ZEN+U02Epwfe710NC31aK8HYR8iEWNycrUEncFJZtCRentTY9JnbJ7x9odPahy/V6eTA+OBGR134gsjk9YSh0=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 01:28:41 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::1c82:424a:2817:86e1]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::1c82:424a:2817:86e1%6]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 01:28:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
Thread-Topic: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
Thread-Index: AQHZopgd3iVmR8MSCUCHHVzJadeb36+SHliAgAJWRtA=
Date: Wed, 21 Jun 2023 01:28:40 +0000
Message-ID: <PH0PR12MB5417FFB8CE5E3A1A3EC969AB8F5DA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20230619102334.2264865-1-Emily.Deng@amd.com>
 <DM8PR12MB539986B2B0C864DF21C83C1BE55FA@DM8PR12MB5399.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB539986B2B0C864DF21C83C1BE55FA@DM8PR12MB5399.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ec4964b7-f4f2-408c-a4c0-6d9b24c6fbe3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-19T13:18:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|BL1PR12MB5802:EE_
x-ms-office365-filtering-correlation-id: b7b76341-26ca-4bc7-fc4a-08db71f6d86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4oT+mb0qiIcebVSFDDqAHkCabmKhPJWZpTTG/W4EwbRfsTGuH45utP6DtNgCnf1Rj82l8DzbOAr/8LjsyjVCcmhg+iRSIBmSS7104LQJL71S//dl3ikan9Jj9mVv/rEE0CTPO2+IFjXyBBM0BZRwl2P89Q+MCiM3IVmjY3GP9ioQlJ0PxsrY243j7bHzfCaEYNtXWPvl8kTOTDILagDRz3FM6qU0dwhpCO2bBtR9HynLSbGW2nl1sp8xMIC6GE74E/cgYRHMh12S6tWLR8CNIDJYp1SMQsuOUSWxvUjN3LuquHqArFRO2zZ8vI1qfQ1PT8dsYe/0LUw0O7WhzbY/92LUZMDEEIXv8D20mwBccQo5tIgvriUo7fmG9DHLFvH2S1KkTeSyAl33CF26Rc0JYXjeKLFl61foVVFa5n8SiAwD3mL0ozo2fKjltZ2yg5l9/LEtFCNzEPhPiZpbuJJA2NwmJzI4ndyLwoHaHaUWH31B3+6tW7cErEcTA4znj+qcQevyIc0U9QcoolpBUnTBN9Qal4KoLiz6MR+m7gnheU7uKERJ+Ny0Q1qvS6x5Q64g11oom7alEmYtqChM1vjPJ1MDSuYZDnU0TtwnaiuOa3u9ICM26i/129GFoJGr9Zb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(66476007)(66946007)(76116006)(66446008)(66556008)(64756008)(186003)(122000001)(38100700002)(86362001)(9686003)(38070700005)(6506007)(26005)(83380400001)(478600001)(33656002)(110136005)(7696005)(71200400001)(55016003)(8676002)(8936002)(41300700001)(5660300002)(2906002)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ex0m/nM5T0Y0O2+05TGkTuV/gg21/okkiMyj5J4CnS9V5N1oBsf5mJQoWpPZ?=
 =?us-ascii?Q?HdhIaS7Ao1RvPckClD9lrKRbP2uMkpJDc04jmuky4GohpVtzEeIDrd2Puzii?=
 =?us-ascii?Q?tx4Oyxl5j9dSnjeI4sIl7OV88N4mHeyi6+8CYDij741Sx1HwRAb5hxpF8kP7?=
 =?us-ascii?Q?opsqlcdhNuXu+74hiKefKqCWpD3STYARyAzbTQGexrs7dqT1DdFLx4J1+lnY?=
 =?us-ascii?Q?hk1waWTxWlIFDGrg9z1PiUFpgiTDTcNcLKuSdVs/XsEyFZib9GxN9VyglUif?=
 =?us-ascii?Q?EtOG52HOVsoH5flWAaUAQOIh34dQAnyu7Ty0qO6EOugJFHZsjXO2wd41mi8k?=
 =?us-ascii?Q?e/+YIJ1o+ns5dHtqkUrPNdg9MP5fHjg9vYbjTCA11VDw1GQqFoZlnN1rUiYm?=
 =?us-ascii?Q?t29tKE3ybddA41Ol95FlIM3gogg3AIzBC+Ht4BP1vFzI086aubrGMnRjqWAk?=
 =?us-ascii?Q?E48RkWol3EddRtP8NyxefhayX4s5zPkBkSwsocz2i4FOYlpCqGPJK7XM0ECP?=
 =?us-ascii?Q?tbE0iy8renIP2lvHYnuEFhsKNnPZpu5lCjibXp4HvziAWgADilAAOkAe8Vsn?=
 =?us-ascii?Q?U+ckcDv2R+aGdFtwDHnRv4RfWKyZbY/glAMNX+HL99JcOV0GrJKpjbkCeS0q?=
 =?us-ascii?Q?ytZUAj3MUtBj//4o/nzLiU2+L38iEY6kyVdVE+NxZHMl9JjuCK0gXx/zx8T+?=
 =?us-ascii?Q?3Z1s+No2rSyhhxu8Tcj+o1iDPlS3be+YeZmo0P38azGQUctwOTitayv7rpu0?=
 =?us-ascii?Q?98JFuEfJFxqAufkRVuzPpB1iA71cHweSMKojy3thFbC2PtHH1sFbO2E/YYHY?=
 =?us-ascii?Q?odmdRKXibynkjhw9HVHtLUnzp0dYCIr/l2f2VplIeFIxrwC3mTh8R60IObtW?=
 =?us-ascii?Q?bEnaCVz3cEh8t7A4GmDt8IyVa07n5UtGnbz2fyzj1sX48fktMvAmG1JN6ySo?=
 =?us-ascii?Q?FQXkI95lN27PnLW7+qfO9WDbphRJRgJDUvmvu1U89UeJ4+TxDYU72bfGepEt?=
 =?us-ascii?Q?K83VqDN1TJcZ2qj6ZaKbc1APD1f+n6AP4DiJLzj7CIhT6ClS+Qealehtv2L8?=
 =?us-ascii?Q?FsTbldPun6XPeSfD0Fs6SmbYPwxmLU2RJ+92YZL315mIMXQt8mBtsu2GJsAg?=
 =?us-ascii?Q?KKnUYmd/PMVI9wyZcWcs3KLBO5FpP5TxQ/hNeVBAjI1odwyl4Hv3iF7NzF+m?=
 =?us-ascii?Q?9FZjaz2VGziOz2okN4afhR+hkw7vkFWeNZTqTlMYiNB6xh6pixPA/2i4i0ns?=
 =?us-ascii?Q?Sa3Cwpehf92n2MbP4CcIpWeso1Xyhrb+oyYwVKAywMSWdv3Nsjhi2fDaO5uq?=
 =?us-ascii?Q?TM0rPhFylYzWGtkSUgY41T5nbCsCVKtGJ2JIlJGiOfjpY4uldpOdtmvQUzzd?=
 =?us-ascii?Q?Db+WZy23pmarhao5Mz0WV/HG6KZz9dJbFSkcjFJ5zXpQkEDGtDFZa/0ndJX5?=
 =?us-ascii?Q?jUHRbL7nn9dLzZBjjdkrFVS1JZKbhWJ3n4yFkYBbrIfnBICRrrydlFqJwheY?=
 =?us-ascii?Q?D5fisO/Wk6zh3/rjwZMFcrfEA1ZNLo/REJKh2bfrlek8a39rnVioBu2y++no?=
 =?us-ascii?Q?JrSoOS/OqnkzBD8+oPA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b76341-26ca-4bc7-fc4a-08db71f6d86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 01:28:40.9760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ppTVjrclaBFfvHyMYL6D6W9lfToPF/szJBVjTbAEu2a7Seud4QTdfPyQMBuYjNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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

[AMD Official Use Only - General]

Hi Leo,
    Sorry, need to correct the commit message, it is unpasue, during unload=
ing driver,  I haven't seen any place call un-pause dpg for vcn4.0 for hw f=
ini. And it will report "[drm] Register(1) [regUVD_POWER_STATUS] failed to =
reach value
>0x00000001 !=3D 0x00000000n ", and with adding calling un-pause dpg, then =
issue disappears.

Best wishes
Emily Deng

>-----Original Message-----
>From: Liu, Leo <Leo.Liu@amd.com>
>Sent: Monday, June 19, 2023 9:27 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
>
>[AMD Official Use Only - General]
>
>Hi Emily,
>
>Do you want to pause or un-pause dpg mode based on and change and commit
>message?
>
>With bare metal, before calling the stop, the state of dpg should be un-pa=
used
>within the call the of amdgpu_vcn_idle_work_handler, is it not the case fo=
r
>SRIOV?
>
>Regards,
>Leo
>
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
>Sent: Monday, June 19, 2023 6:24 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
>
>Need to pause dpg first, or it will hit follow error during stop dpg:
>"[drm] Register(1) [regUVD_POWER_STATUS] failed to reach value
>0x00000001 !=3D 0x00000000n"
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>index b48bb5212488..259795098173 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>@@ -1424,8 +1424,10 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>  */
> static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int
>inst_idx)  {
>+       struct dpg_pause_state state =3D {.fw_based =3D
>VCN_DPG_STATE__UNPAUSE};
>        uint32_t tmp;
>
>+       vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
>        /* Wait for power status to be 1 */
>        SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
>                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>--
>2.36.1
>

