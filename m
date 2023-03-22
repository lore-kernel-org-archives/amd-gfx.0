Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5171BC6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 03:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DDF10E23B;
	Wed, 22 Mar 2023 03:26:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CA510E23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 03:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5Zr8T2EkPCT44hxUdyOW0vjFW4MeZ3i1M4sddJ8W2/pqeCZjm+HbZ7mI4VaiSIr132P880zw67F5VQv4l+IrZahq5QdoRNJXBoOrgvm2E/erqm/VHobBscyxwxzSvzEl7KwwYUsENbJiX5w6H1LvICPqTc744zvdSvn4JK4BEFiFOdod60PaWv0Hym6EA26RYSv56sz8r+gugihrsT+0FWqZgFSP4HM7EadnUszcPEJNldeu11Hbi0oaxmPgbzMiNfl9ZvGyFpn5Sl7zjzpSiPitbK6xPu+0y7WVmH+QtBqrAhcGRoE7P0SJxczkVgTEgvfQFhWfvj5Kh17Eq3jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dw2/E5GF3AvJijdR3GfhsMZL72/35tOZiOHiwS5wKBY=;
 b=ArckCqbNGAJW4RHpyyrjX728C+k/n0tit7fsPKpDXT1X/W2yoD4Ji6p9x1SMQRn9kpWdRRQtQpwGlrIKl4iVnJsVkRhSmB7yyow9rCxOcIHQyqrrr9Y3aOrL5dKjQHraq0lj0uOOKgXwTAcsDYAOxjWXlIvspGZfYA2+cwXBsGtXy1ZZX+tQYNKOdWx3s2ffxhnrcKPGUx7le8Fe4CDZ1l44KDQd1NxJGtdzpXKErLOxtew58G31iEjlXeyQOd80pdg+eCxo/w5KoSCV5tV4oE9RDX+aHutFQ6HPnakRPe3sdwCcbCb5chXk8oIDzYSmpa/H9INkVrC8Xiz6JbWFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw2/E5GF3AvJijdR3GfhsMZL72/35tOZiOHiwS5wKBY=;
 b=ZhFZdZDode8zo1nj2r8LPm5+kBBCJE83Oo+OgYkSPnLk1p2qbPTzPaByroWd6Up2iYfNUXKIUd1NXfSUGfmg1EeXOD0XWeMzf4edVCNA1qjiQmbya2XuqCmh5oRpnnm8w9elhQE/sQoUj5r5fYuye8w9SvZ2+sU9cFny0jqht04=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 03:26:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 03:26:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Thread-Topic: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Thread-Index: AQHZXGdJ8PZrPM3XqU+MPlJlryo7Oq8GIiww
Date: Wed, 22 Mar 2023 03:26:00 +0000
Message-ID: <DM5PR12MB2469E33D753E88E2421E823BF1869@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230322023655.337567-1-Tong.Liu01@amd.com>
In-Reply-To: <20230322023655.337567-1-Tong.Liu01@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4435:EE_
x-ms-office365-filtering-correlation-id: 95cc4176-fca7-414a-715b-08db2a8528af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73c33wFMzax3BZcujy4nFUj+1V2EnQmINobSFaAN2SpYCKw98gYLny6KlUngMN9qo4ML/rcrMjODIsOInveYL9BURpLF0mCeQ6lUD2X0JV0UXBP05liU269l4gaQO+j+4FCE+pN4scdESbQMlP+MRWkqLcicS4fcH7gzK1Kp2lTkSJyDzTa3pK7JnbOK05+UZTt2/8MtxXbJR0DTN/SfKJEcVb/5qJHb1UBPATHw6q1KBXwH2UcerVOzAXj8/tOXCLBNk8dZEra2ecN4ThOS8JbA/ksGvGZKLCzU0+4S3dXNFd4MEVUPaITXhX2cL0ZmTb443+rkFR26Zhd1Ci58kkuhQ3fGHAfEOl9dT4hD3/envb7OkxBASe//zVE2KW4Wlm1HOwmQzlFFVmnMcL2+mcQG1WYe4OGKen74U/NdtvRRP/rOEt7MInMPZkC7gSAATlWAIUx2LsWTYcID75BBOuG8rxRaicxa0FiehzKZFB8ROt33zv9KDjGLMIuiPGt/MsUhtWITXyL7LUW1oEDV1+jj5VH585s46uoifZC6zP5e9MU8xDELvFSLsVduvXJ+1cIOptdNifr25aTw+Oiklp4MzW4uZJFCOpTI78VavG9jaOWs7xAsDuhfaPT8ErDJSkd/Rd7jjmukVHZyHsVa0d99I65VDbR8izkwrq7KIeCrFffSlePEwdtB7J3hPM43ZjZJE7BgLo6ODBvglrg8/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199018)(7696005)(71200400001)(66476007)(186003)(4326008)(478600001)(83380400001)(316002)(26005)(110136005)(76116006)(66446008)(64756008)(66556008)(66946007)(8676002)(53546011)(54906003)(6506007)(9686003)(41300700001)(52536014)(5660300002)(38100700002)(122000001)(2906002)(55016003)(38070700005)(86362001)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/TjI4HrN46Q8wUe9ky2cmb45rle2K76EIVnqbWM2M9k2rNZ/0qyRiJvFuBxT?=
 =?us-ascii?Q?ykZboiPYOQuzMK/0aFUtIvICLwg/LsAy0igZ2efx09nUMNyxZQRK3tDc4Ewg?=
 =?us-ascii?Q?Uq3N57GKgZOuTnEc3K2Slf/WCjeKdR4xA2GD0dE3x4iao3pR4/6/bk8ufjjX?=
 =?us-ascii?Q?6uQsVMu+ZK02S6NoG2v5T79scRkK1UG2a8QzM1moig+1semNGt9mMsLzp6SL?=
 =?us-ascii?Q?CC3xv99iK05mXUrDzyEADoVua8m7A/ZwDx1XqWAAKfBsiBcDLkQmk9BDQD0m?=
 =?us-ascii?Q?EvjHlDq78XaZpP6D2UCkfBTz4qmUTQPIYwe5oITEJtpDpgppDIlM2RA5c8Rk?=
 =?us-ascii?Q?LKh2mW9RsXmcv+3dcfumstYrVXk52jrROPsfj77R15boh2vLdrWnmZB488rK?=
 =?us-ascii?Q?qqnFwlKhe+J9278lY7NT9Xzw3bfDWcfYuLHCdaMK+S8OjPdvjITmS0W9dg1z?=
 =?us-ascii?Q?sjdctDJdoMEavF8rfKdwtARsIiVgLS0dzZUr8TY2Xs2Xrj+vROWeJOoBTPsX?=
 =?us-ascii?Q?W8dM8+bIc77lyvedKj4styaIU8uDgUwLsxLAyh20Yrqcvp8SjZY3kKskEL6r?=
 =?us-ascii?Q?oxnk2hpIs9MCDcHgu4SiBNN7okSDVFtCHA2eMK7NeYS0wHXaNQ97DUA6zmGL?=
 =?us-ascii?Q?57utAlkry7JZ2ewCUWQJ63LbkTSNuceFu/kRhhO4iVyrMiQf1uz2RUioebae?=
 =?us-ascii?Q?W2wSWnfTwpK2dbxhMwQreGkHQ7fUft4mo4NQAJAMQb2DtTJc0fhhrrg7aCI6?=
 =?us-ascii?Q?yCO9thD1gWrm6WSr04JjcJ433EWhyvb8yp+TUuy5HIrpFCyB/oNobJtWGFwV?=
 =?us-ascii?Q?QE7U2kTb9L7BoV56LjjsXdLIIVngPhvOXigUmjCeN0X4eP+mRPSd/DF/5QPK?=
 =?us-ascii?Q?Lof3VQnrmIxThZf1/xfze75uGiRzPMyD2YPFztQmOF8Pb7/zLddEXhMPA8Q0?=
 =?us-ascii?Q?1p1PQmBjmCrnDY/o3Oda+zuU1QvvKy/FPMHRRZrh68eg3e0tdQj7QtJWsYja?=
 =?us-ascii?Q?bzgzjeu+S6U7ox4oZD+Tz07veQonWekGdDNly406d247kbqHc1FeH9dtd5Z2?=
 =?us-ascii?Q?o0tY4d/hudTxqIRnqul5rmi1Cvn2VCpy6guPMtJDQj3NgWldl9uj8oRuZoef?=
 =?us-ascii?Q?PSH9c4ufRSNZvN72cvnpMu9fz6qWw9x+GvQZdrLDuk0ccwLFwJyGaO0PlBiz?=
 =?us-ascii?Q?90bDIwHhvwvLXwwWCcFFuuFITNrsckZyJWBvOkCu9p+AKqCMdybROopNJnmx?=
 =?us-ascii?Q?X7jO8BbnC4KWS4B0C0MC4MxbVIPXk75vv1/mz/lXe9BwltdigF6Ex47kStxk?=
 =?us-ascii?Q?LYvsznj9cjS6g/X+npJg/asmHclntWMFZQtlIdGl4Ghfkk9jilCLxODHzZ0n?=
 =?us-ascii?Q?ZTVm79MC/rLmghzQAaP6bljnkbk1xSbB+RVIY/Xf+Oa94Re5QCZjjSziRGZl?=
 =?us-ascii?Q?GzThBRqNpU98GgjFG+fSXC/C5Y4jRq5F66rWNrPYm2YCbU7q7lIkY2tkri8T?=
 =?us-ascii?Q?yX+bjpPOWMGDMe4tQm2kIFiPLM7UX3MlEstolSzqiHSDZ7BrjKsbBpwBUcWX?=
 =?us-ascii?Q?jhZFH44WWz57+2Aioosth3DntPsug8B4oFSLuqn9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cc4176-fca7-414a-715b-08db2a8528af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 03:26:00.4348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iVvipCU8CseNHuLlHWq1rr955+9T+HfuVQBKD3+ZXTIfKqajl0/OAHSwM6QcmP9D+xw6JdnLrDbzRNtmeBRQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Liu01,
 Tong \(Esther\)" <Tong.Liu01@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: Tong Liu01 <Tong.Liu01@amd.com>
> Sent: Wednesday, March 22, 2023 10:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>;
> Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
>=20
> [why]
> For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should also
> skip tmr unload
>=20
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0b9e99c35a05..0a3d9f7e277b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -839,7 +839,15 @@ static void psp_prep_tmr_unload_cmd_buf(struct
> psp_context *psp,  static int psp_tmr_unload(struct psp_context *psp)  {
>  	int ret;
> -	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
> +	struct psp_gfx_cmd_resp *cmd;
> +
> +	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
> +	 * Already set up by host driver.
> +	 */

I would say something like "skip TMR unload for Navi12 and CHIP_SIENNA_CICH=
LID SRIOV, as TMR is not loaded at all."

With above comment improved, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> +	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
> +		return 0;
> +
> +	cmd =3D acquire_psp_cmd_buf(psp);
>=20
>  	psp_prep_tmr_unload_cmd_buf(psp, cmd);
>  	dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");
> --
> 2.34.1

