Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD25EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 04:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2063810E286;
	Tue,  4 Jul 2023 04:00:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84ABB10E286
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 04:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXdr84MUZ0pZiyKFkfM8Jj5lzFnpiHLaxELJDTItnnk7278GX0x3abuQmvamGs0Hqh70P1WVzUOgShOKnCPfQVDjM/N9Qcd68ojkgDpR+xZQ1kN37/lw4EMIJ4edtoZkSZUxsU/RyQuc3Z3WuxW8h8bQi9FaOfyisVGjvwybdXNbNwYMnCxzCTcBUKfYhiUTVv4hA0GKt1Le7nSHGbr0ZHF1asmt/QBvnX134royZjNcxXLU63cPwGMf3MhmCcx901rImRYUmwlbN8mGqg9N/imI6AfLr6xwjstHi8ZOM3fRICZsj+ZmwhkF+Xm40XvOlYcFZv0pbo8DmXgEAc8bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R43yAivTVsIuTW6HMyKAbpb07rbB6fT0GSQ/OiMGEcY=;
 b=hTYcM0+QCZ6M4RK0DldvCNOgwpeIhaLIC7DluxTO7KByI214HgcqKrdhS5pPh5xXpLKKi+gSsawaPj+fIJJpZfqTPDl7T4Yn7kl18eiyEyXnuZKwY2bRikv4sobsXSnjDNOm9LP6ISuD80wMxDKESx7AM7+/XU/zuTu7W2RvVqd9XSS+A2KI8TaOwRMkicfQvtjTbU0G5xIMQEQ6UXZszd/p1kvv7p2E+/Osv+dmn887jfq7KhFdSmXHybNNfrbCjJEl4x6PDBDAJbGjTz4HKxmb/umcFyojQEins5vh7p77RM6pzN//jGKXOYxdD6wVYhWYMKmW5PatF3J2VgvJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R43yAivTVsIuTW6HMyKAbpb07rbB6fT0GSQ/OiMGEcY=;
 b=BGTGLift1uJRlcEdnf1K1WBerzrYPAsl/ARdaXnfu8iShkXO367uADChxCzIhJlFXpdiTgHqZJZiV7V/zVMDnCEnQFsy0lq+8j7tc2bPjgSn4o+tV5E+WXf+I36muRwY+5f6zJlYrOE03SUAC6jITn6qsf3QXThwovsZnARzNLY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:00:41 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::b918:c914:98d9:2975]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::b918:c914:98d9:2975%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:00:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Issue ras enable_feature for gfx ip only
Thread-Topic: [PATCH 3/3] drm/amdgpu: Issue ras enable_feature for gfx ip only
Thread-Index: AQHZrYw2a+LI0PbH3UiWhZreeKMlzq+o/P9g
Date: Tue, 4 Jul 2023 04:00:41 +0000
Message-ID: <PH7PR12MB87966F1F652A083B7E0299C0B02EA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230703085531.11563-1-Hawking.Zhang@amd.com>
 <20230703085531.11563-3-Hawking.Zhang@amd.com>
In-Reply-To: <20230703085531.11563-3-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1dfffd8b-9372-4e57-bcb0-1593c1b6a99f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-04T04:00:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BY5PR12MB4066:EE_
x-ms-office365-filtering-correlation-id: 5647aca3-9753-4fd4-6400-08db7c433beb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PPmPsGYtvegjo9w86A6+tDtNII+PgaZEFwXbhxFZE7qQVILJsuLjqKVHyv0eaAEkTevY33tegV3lQ/IM1Jp4I814JWgG2c4JdqYcz6bBnHFC42N52Dl4GZjP3x7vZOfHBiJE1u1NqPdYJsW1Oq5mDwsHpQh/TIiz8dYW00Y6nZe7A6k7od3tfLt88T2eG2f5FkmGRXTdO/7ogvd2M3lppOjnV9oqGovaI9IlP8NQ4qCIl/q1kUz8SF2rcybKhRzjQC/dG34OtXlSmp0AtFIspKpg6MmwfyxArYiMKv8aXWmqO5+oXraZiNuYFjwL2+yStQVY2qy+cXCy6kPI5dcLEz+ZoV7F8AEegDswvlw/bmp8+C7fH8y3jvlhGbXT9nuROChGsxlg6CJXdMnlnqpq5rTr7EkREL153VM5xYeEkLXYCet+80oo5tuWL/4Q21TjRrndesvxhIQ2Wn1SZg9MaPum/8gME0HXzK65XVyBG86m66iaPDXLpjQrTcmsXVmw9Ild/yO/LWIH9HBQdBpV76bmjefxqvimOtnxidj79NR1nYTBtiK+eSv6uBXDZ+gGdAliiMlHTQrc1hHcSRwwRCbqTtmBDMxRUGh1x+xBR0Dvd4uVLNIwHGJWyivjaQZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(26005)(478600001)(6506007)(9686003)(71200400001)(86362001)(186003)(38100700002)(66446008)(6636002)(66946007)(66556008)(64756008)(66476007)(83380400001)(110136005)(53546011)(7696005)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jeB1YJ0o3Uftiv/3pkvPfR1RN2Puc3tTJ05kkdlmVb+ZAKs2xdxrHgXYCCdX?=
 =?us-ascii?Q?mD+0hagu9noTBNHdErdyYHJvL0fQIbHlJaZ7ilDaUldQT/Yiu84fIeh/GBpZ?=
 =?us-ascii?Q?/n/1f3aMwLJatUCWRL8IGeEre1aPUV8ecqQM3v75V80k3l/S8lkQJivvO5/d?=
 =?us-ascii?Q?vpfxt4wjAvo+IiB9NEBU++1TDDLOLRgUmTQlXvhqV+UPgFczwnu4F6936tb7?=
 =?us-ascii?Q?DvUX1bg95K4DF325dX5PRVY37lE2LK/A7GXXC8vVuccfyncj+gpYg4opluL2?=
 =?us-ascii?Q?rv7VEmMbCg4damN0scGSuh3uRqle9odqJuQIKEO9NIXQxPGm8Ycm5QHRt217?=
 =?us-ascii?Q?jVdDKhV6aAKa18KaOFLhfQ5PEYojzny+Xjkpl8xTONBvATT5lr8QQC45Ror5?=
 =?us-ascii?Q?VTVE4+3LZe3YavcCcy2bKi4T+LvCD1ykOHLjO8F9e+Qx410281a6VBv2OCm/?=
 =?us-ascii?Q?1WcaPMFS/BhhOBBUoDTOXDMjzVnQFG6L5Qb0CegufMdUHL/x8eBNhRNBdwF4?=
 =?us-ascii?Q?IX7tMKXcCzR3t4Kb1vHrHxu70X2h0Sn1+H9UJs5SQSh3Rrse890YL9fysu+S?=
 =?us-ascii?Q?d/FlOhQOhCTnuEgsX1ZzqZ2byq3Z3FXPl4S4PDD9566jY/cIPd2qEdS+Un9/?=
 =?us-ascii?Q?vvnJgIUVyu0x40JYb6ykkAFGUas12nPGYV69zrl+9OP3bWvC8qz+kQ7uB40J?=
 =?us-ascii?Q?zC8/5DIob7STkYZsVQ44n8SECAD2AXYFjFwUo0AxeqA9Vxo2M4TphQtZQSBi?=
 =?us-ascii?Q?R22UUs057d2kG+GdhveR6lG97bFPawkNjANEPqhA37zqoUPExK0obYosrKis?=
 =?us-ascii?Q?/0/tRzK+iN5zHJPNpFeBLwiSFSJkHdyJfiwZ+IMIcm1LkfJ6fYODRGxQ1/8b?=
 =?us-ascii?Q?DMAWzxGPVGSIMB1epZD4caofaipTtYEl3KICjgx+JfiWRwny+dI6yXz5I9im?=
 =?us-ascii?Q?nf8YRmT/sXhH0ZJ3RQKLAbVNodK2DDdYHUTH9UbJGK5a9x/0qAUrmT94QYJm?=
 =?us-ascii?Q?pa9HEOZOvl095yPRkO2H7ELgBLMkKRnLJ81C/2eTrX0YKXDcworhVBPAKCCH?=
 =?us-ascii?Q?dEfnjLmIi+anTWpKKI+SwILotIqHuvQR9RfNRi3tn2WHfFSHKbygy/Wvrpbk?=
 =?us-ascii?Q?Y5oEalNFgpw4e7oKnvlhRltuI7xPnjGQYlpqWzWDBLfJSUHkde6r9ZyZXa1U?=
 =?us-ascii?Q?5dAhARGsmNYQoBn+mzAY/EaduFUpFC4QIELxgvv8s8sFNlxUjdLcl/wAcOr2?=
 =?us-ascii?Q?AYNSUivAV5IItenxCjqLjoSCQdTj1yqV19f6+IGUsZ4vrQ/LTxDzbt5uJLYv?=
 =?us-ascii?Q?6XeqdFeWsjwqzEwOLZFi+Q3507VvrZDnhhczI6cJsmUOJEZDiaqnsFCn5/7v?=
 =?us-ascii?Q?L2Aaef47BVgn9bUVCEZizN433vvf3hTOd2GbST+69CYeh+Y8gXu9y0dNSDxx?=
 =?us-ascii?Q?zrturCrZARsQOMQyvwFX0MX9r9scoseGDOK3SskVFogemcSp/B0vzfXBozPq?=
 =?us-ascii?Q?RVopZ8ZAQX5JlEfRDe/CKWb3N0wVQAYLN6iCeI3du9Qg810qvwVLED/fWQe1?=
 =?us-ascii?Q?mWfDNrF/OeY9KHjqpdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5647aca3-9753-4fd4-6400-08db7c433beb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 04:00:41.2946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o0s6a1mWOWSLD1QPrq1gVTBbHG38kAJeJhUp+JRRdcPYE4v/2l9PxGOVxVOSF+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, July 3, 2023 4:56 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Issue ras enable_feature for gfx ip only
>
> For non-GFX IP blocks, set up ras obj if ras feature is allowed. For GFX =
IP blocks,
> force issue ras enable_feature command to firmware and only set up ras ob=
j if ras
> feature is allowed
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 30 +++++++++----------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8524365761b6..2e9154bbec64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -761,16 +761,6 @@ static int __amdgpu_ras_feature_enable(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> -static int amdgpu_ras_check_feature_allowed(struct amdgpu_device *adev,
> -             struct ras_common_if *head)
> -{
> -     if (amdgpu_ras_is_feature_allowed(adev, head) ||
> -             amdgpu_ras_is_poison_mode_supported(adev))
> -             return 1;
> -     else
> -             return 0;
> -}
> -
>  /* wrapper of psp_ras_enable_features */  int
> amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>               struct ras_common_if *head, bool enable) @@ -782,7 +772,16
> @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>       if (!con)
>               return -EINVAL;
>
> -     if (head->block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
> +     /* Do not enable ras feature if it is not allowed */
> +     if (enable &&
> +         head->block !=3D AMDGPU_RAS_BLOCK__GFX &&
> +         !amdgpu_ras_is_feature_allowed(adev, head))
> +             goto out;
> +
> +     /* Only enable gfx ras feature from host side */
> +     if (head->block =3D=3D AMDGPU_RAS_BLOCK__GFX &&
> +         !amdgpu_sriov_vf(adev) &&
> +         !amdgpu_ras_intr_triggered()) {
>               info =3D kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL=
);
>               if (!info)
>                       return -ENOMEM;
> @@ -798,16 +797,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device
> *adev,
>                               .error_type =3D amdgpu_ras_error_to_ta(head=
-
> >type),
>                       };
>               }
> -     }
>
> -     /* Do not enable if it is not allowed. */
> -     if (enable && !amdgpu_ras_check_feature_allowed(adev, head))
> -             goto out;
> -
> -     /* Only enable ras feature operation handle on host side */
> -     if (head->block =3D=3D AMDGPU_RAS_BLOCK__GFX &&
> -             !amdgpu_sriov_vf(adev) &&
> -             !amdgpu_ras_intr_triggered()) {
>               ret =3D psp_ras_enable_features(&adev->psp, info, enable);
>               if (ret) {
>                       dev_err(adev->dev, "ras %s %s failed poison:%d
> ret:%d\n",
> --
> 2.17.1

