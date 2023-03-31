Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F60C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 04:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1595A10F0E3;
	Fri, 31 Mar 2023 04:49:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCD210F0E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 04:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/jkIYBXI/BugLA6lBq7+owu1R1YuGrnn22b7VmQs73By9AnZoH3H6qyTixbabD792lFCQ2WlaI5V77J1QZtyUnLiOih2TJtlMOLtV62Iso2jgezTS6zHF5V65XGDWcP3S5v0QzHqMiwl02utz7o9Z7GhOOpW+z4HHcG94n11e6Jc8TukT5hZDp1np8xP8LFPdghtRv2BW9y40T15ccAFitWsRtltdOTn56ALUFp9+mlaNPGIN53Svs50LVC7dXwgkVnWU1pYtY2groOodiOXdPSXGr1oWaS6PN0PXgpfXwz1OzhqW6kFQCqLvIBdt/HkQHIEioTPaEr5aKo2cStDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFkAP4dzcQiOxJPNsMMRhPDTHNSmUSYE2q+MXtWDXDQ=;
 b=BaIB1d46/59iBVjKWtx/kuE3VxXjNj5fYQBGOFaZ5t0DKO4BlHofUkcwGfu/N3FBATSxDkftUliWUhZ8pvC2m6d+jsCBRmB4n1mee9TAqv25g4h7SEprWKbQhXL8GLrn43OlJVpPQsUGN8SYN+TuXm9AY5OjlgfI5dbSu3CzdhYWXt9RlxB8epceM2w18jUOHmUXwA8AFz1iMSOL40hXD1Z6fW1h8pckp6/oAztZ+1oF5iVyIUSAOSINhgS6pjS/3BBmrPl1Gwzvgdgb1NeN/HofjSQSeAkFYEInJbYp6dRCVUFjWDBLc3uhdDKAim5iTUsR4GJDTXG3Ni6CIO2JPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFkAP4dzcQiOxJPNsMMRhPDTHNSmUSYE2q+MXtWDXDQ=;
 b=L+9UnGT3gxxUFMV7Xk5fJpJiZteoPC3io2cYunEcTZKWS7llcF1JHVpQTE3SkyCoaNY4fibOTMUfAk6t2sPwQBfJcVG/+SC3eTw4jI0XP8Y3jO5BJl4WSlWpZJ7BeblCHvgWJwQTwU6lgQcTk+ESLF+75ndRS7ABv2TxvB1frvQ=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 04:49:11 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2%6]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 04:49:11 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4 (v2)
Thread-Topic: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4 (v2)
Thread-Index: AQHZY4MJele0UoTN9EKUxacCIQucXK8UT1FQ
Date: Fri, 31 Mar 2023 04:49:11 +0000
Message-ID: <BY5PR12MB3873A913AC6EED5CBBB2BA7BF68F9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230331034040.2498766-1-tim.huang@amd.com>
In-Reply-To: <20230331034040.2498766-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=65e2f683-42bf-4347-9c2a-94bbc4a296f0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-31T04:42:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SJ2PR12MB8978:EE_
x-ms-office365-filtering-correlation-id: 88c4e682-07a5-4f9a-09e9-08db31a34524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l72K8pbyXOeLvmQUMisujhvkdJdk46S3/GMRVZcHvPyrvofwWbOc+B5/8Ovu8De0c4tEcOTl4dlqPK2k8AaKZFq5kl1mYZr/TRv43OjHAgq6Z2gWgizXcjmeRu8eANeNRA/ZPK4ltpxB6TmDQqSbHhUcKV1WFKkufcYJRRKSDFnh4ehkZf+DY2nC5hivP8856wU99FIcTwOftdi570mvwGrfA1z8hJWtOaEYQykBWoDWKU/TOZB2JtfINiZfp4ksBq6NrN4e4pJZD8v3tb24dRB715v4WU9/+GRNot87zLhI6a5bQwksgyR/4kqljMch27/GQ7mXZOKxQOOzRW9YUdRVltWUFo0yFA0cCIsRGRFi3bhetjXv0JY5ekAhSKJi53cTnBFeNM+1j9lMbM3r+ETzG6yveX0oXFTmofR9VI7si47asCHTQIpZOZC7LSoQZ07PNUZqYCHLUvm0zVqxf3HaYQxcx7Qs7mgOZ4C/2LlXT4AT10c3rLpgqVftHAl7ZPqZlyQ2yrU9rVH6QQ7XeDuyfr0FUxqVj/i8+snFNRWbstGqchrKCvl/Z6sTH2Gb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(83380400001)(122000001)(26005)(53546011)(66446008)(54906003)(64756008)(316002)(7696005)(71200400001)(66556008)(76116006)(52536014)(66476007)(66946007)(55016003)(8676002)(38100700002)(41300700001)(86362001)(4326008)(6916009)(38070700005)(478600001)(9686003)(6506007)(966005)(33656002)(5660300002)(8936002)(2906002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L4/agzTWP+vzodxaHVyGC6sXcJnGZheXcAus+iBbe5NSmLO4Y2nnQp2rcnxN?=
 =?us-ascii?Q?Frkjrs9qo0SmCTFw4tWIiIvxvt2bTpYBUjiLm6uMFj5GR63QkyzbObI7LH80?=
 =?us-ascii?Q?vVPzP5a3BRRihETvBFFwSqvr6wUQdRvTmDhByiwqDwqzjY577XdZhR63CBwz?=
 =?us-ascii?Q?2JuZ9R78zkt7krl8nkN3zhZSNgw0QoHsuY95PGLoU/AyLf1yJf+Hpo5iqK3D?=
 =?us-ascii?Q?eUSCuE5mTERaWOTpxH2equOwvq/pk7qhWJYzD3pBLIX7WrVkWzzCpVoonfNr?=
 =?us-ascii?Q?jkU70oWprVLnZDTeI8tLrjEwPTo9AIfpbgDOdDAuioR+jczLJiMPPJL4I5AP?=
 =?us-ascii?Q?5DIUfQEovEWVIyMt84WX5T9X8Ewzm+vlDQ+gmvqvEFA5LFEk5+Cv9CB+LafE?=
 =?us-ascii?Q?+7+ACZwZisdfSYM55vD+ZeafCdl6zXRE3SyluHX7He50nAgWaxRvDL8kn2XJ?=
 =?us-ascii?Q?koBNyJJBW4IW2WPrzs35q6mCSNXjbz/xlL+kHLXv05Qup5iTimdQejlbglLc?=
 =?us-ascii?Q?EvzFFqkohyKAwo86b3Vp4Bea9XCj1NvttjXBNslQb1Ebc4N4Gr1Q3+9T/EJY?=
 =?us-ascii?Q?ew31vPWjTmSaZC6ViFwvrA7zG3gHfKq5Xi2OU5W8+jHljRU7wMxYqlpMh9JS?=
 =?us-ascii?Q?XV9KrvF0k3poEORKZVyz2wI+0XdEF5kP6odaGbiQAx91yQbM9egOWhL/jMY9?=
 =?us-ascii?Q?AKzPAAKX0OgsGZeZzOVQH0QIkHJG1owvJigVtA6m4mW0Z0OIj70xmcNYmT06?=
 =?us-ascii?Q?jG+2f+WtRVhfyX5TO3SBKDjv2ibKIofl4/zq3BTItBfuEcIryLu7/T07lpVe?=
 =?us-ascii?Q?GXkV/HIMwlTLEhRNY6z0sPoPK4g6N+GfGOP9b8o1VlN3e9QWunJ1mkBnr0Vz?=
 =?us-ascii?Q?Dga+iW8VsSEOIH/4vbzIwboHNFlJCath+PbTnJAsCGKQMzw8+e29Y5Ho4iCi?=
 =?us-ascii?Q?Q42YXzSzs4h5Yl+EpFVpunvH4cMmJ20mvyBHJRnihr6fCT5I1ZHA620y7VL5?=
 =?us-ascii?Q?BBBRDxiDQ4bLc0twtfaIRs5FGRau15NfOqrcys2RqKbmWblWWguZ9CEs/n1D?=
 =?us-ascii?Q?+DP2tIybFvid8k+1fyOe20uSN5lwFBTZ8nyuFAQtBS3BXCmGXk+MINOGkebF?=
 =?us-ascii?Q?F32/Jk4oBLafKAHzUmVGKCdfTE0NR4fmBbBM/Ve85oA8yJ+iixr48RFjz6xk?=
 =?us-ascii?Q?HmP5tkK9jQxGu65k+IZcVvtbhuM+dqMEFvLrAN2E3l5zrQNhj4KQqXW0iQ52?=
 =?us-ascii?Q?50V676kI7sBQYn9d+dZXf2ordjhJ010flbkwUNO6l+soLlF8StcFw6T3QsaB?=
 =?us-ascii?Q?wqo7AsvLLGf7gqNc+7Z6p1vb3FCGS4z40pCMCVdM7CnDKWhMZkxECpZv57lB?=
 =?us-ascii?Q?EHYeHtfKxdb2x6eG078rJqk+x6j8nQe4Jxka+ZDoDcvsYUcQXopirWKSEJ2F?=
 =?us-ascii?Q?bZVQaHPE8ACEFizpcEw5+grxTxGj64XZkQn4IFwIYRr5zjiLagqX2vqktWm/?=
 =?us-ascii?Q?ULi7Lc/md8C6QOF7YG8n4V6THlvvkrjS2kilYpcCbTA0zvjN5Ye8hekFMOLE?=
 =?us-ascii?Q?NtiDeDd3qu6mx/hGBFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c4e682-07a5-4f9a-09e9-08db31a34524
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 04:49:11.2447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkdQWXlGNfTBLn4jr31C3cg9XpFcYvgbOz6iQSdW/NjuTwT2L7rUGhSIG5C8JW22zMsdMr4/xUUY2aN6vpqFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore this v2 patch, already have one with the fix. Thanks.
https://gitlab.freedesktop.org/agd5f/linux/-/commit/2fec9dc8e0acc3dfb56d138=
9151bcf405f087b10


Best Regards,
Tim Huang

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, March 31, 2023 11:41 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <=
Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.=
com>; Huang, Tim <Tim.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to S=
4 (v2)

Skip mode2 reset only for IMU enabled APUs when do S4 to fix the possible S=
4 regression issues on old ASICs.

v2:
Update this commit message to add Fixes and Link tags.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2483
Fixes: 2bedd3f21b30 ("drm/amdgpu: skip ASIC reset for APUs when go to S4")
Signed-off-by: Tim Huang <tim.huang@amd.com>
Tested-by: Yuan Perry <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 0f7cd3e8e00b..edaf3ded4a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_de=
v *pdev)
  */
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)  {
-       if (adev->flags & AMD_IS_APU)
+       if ((adev->flags & AMD_IS_APU) &&
+           adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU enab=
led APUs */
+               return false;
+
+       if ((adev->flags & AMD_IS_APU) &&
+           amdgpu_acpi_is_s3_active(adev))
                return false;

        if (amdgpu_sriov_vf(adev))
--
2.25.1

