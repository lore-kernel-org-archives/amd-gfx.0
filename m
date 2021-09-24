Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B6361211
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9B6361211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768DA6EDE5;
	Fri, 24 Sep 2021 05:55:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60426EDE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4ad7WaUMpHTrKGXG6HOUp9/eC7lphowoIHRb7xG5SReWi6VbLcNR3zkA4r/aqfo1xxfiu170+XP94MEwoT5/uWJ5u4q6fGAdvc8rpe6M0yvlzO+jLUKUnRYGGQeImBW0bW/kNMfuA+ERe90Nzw7Lhi/9MCEwyDIl/lSOv3uuSUzs7iRLWyIn9e46mAthAPwPFjZvsSC2ytLTVMjTaSKw0OjiQuAAnYhufm6QLuS3ZNOAhayrBQtUGmMPMBUQtwYEAf4n4Q1uscJat9rIaPhSaOwtkaM1rkrukwJCFS7iAiDGULaKNxwk2iiWuPLkbt5jIpTa9tmTfYIdAemaaZF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ExCPFSKPhbnLd680jsS9hWXO7wlB2+YlFAzAvFD/M3o=;
 b=LreM47Pa0VpMc+oqFBuIcFLOyuV/jzCQ6xYRvomTmsNWB7QVVbSQ5uOIbPK351PLKT0fs+QX1QqBvjwCgNE7eaTnKmUfZY3PIQWi+QJy57v4wM7R3tm5gJhrNhqrIwOyoaNGcJ1WT7Rog2u/ONRubik59IiAi191pcEdge/XMZpYzvKso44ngrgSL5MlP0SQ8eq5jJ0CImeh9p/5zjtz6pM4Ap0wrI6VL6Y/c3XD1WSQkNCQCrzP4YtQ7UPXwi5CuDzXaZxRrC/6uBNTUAc/p/P3K/7LBPi5Zn86/GjL4PiN/1wl3eu4fpHY6iC08PDNZxjaNEDDwcgSYrb7OS23Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExCPFSKPhbnLd680jsS9hWXO7wlB2+YlFAzAvFD/M3o=;
 b=QbWCvkYJ+NT8kIaxKOkvkPbDrh12+pBx4J57nx6cZZJxz1W7fpjWXESOd3gCyX1Std5M04LhtuqcjACAr8C1c/gXyK7bWVIaJfBnLfX3+AP6VE4iE/pX42vTfO+Rc4PLKTuIuGKvzrAwUOb6Ax+tRdeh9pG1d3SaUKSZS9aPj1o=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 05:55:20 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ec2f:450f:5fbd:e925]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ec2f:450f:5fbd:e925%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:55:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix
Thread-Topic: [PATCH] drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix
Thread-Index: AQHXsQP778wZZjq1dUy9aPktQMm5wKuyrmwQ
Date: Fri, 24 Sep 2021 05:55:19 +0000
Message-ID: <BYAPR12MB3238AD2EF7485BCE5D7342F8FBA49@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1632460680-2225-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1632460680-2225-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b08337e4-9530-406c-995e-b8bc4e60e10e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-24T05:51:47Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2560e3b-07c5-418e-2b50-08d97f1fe439
x-ms-traffictypediagnostic: BYAPR12MB2600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26002FF6594EFE1216B1ADF8FBA49@BYAPR12MB2600.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9YOH4NG2E10VUxeQr8gUZ0TC1iZsJjrEzqa8sN/yNIfQmn1l8mNAZM/J+w0isjMBq6jBPNtDSknzcvbdTGX6LcpmdrY74TUNWWSh6nB8bg2tXVpiPs8d/SrCVN8A5rJfPZhSHiTvvnE0eTo/BZxBoDVNRb4BSNj12F04htZEsoFV6JHfRNjkv2x8sLvr4d5UUb633vKUbkAv0LpScO7GAdJwPMxg9uBYpBD3wOcE23xwCdBwfkq1NxKRE4/YO78wMjcv09N8186WqkggDaDAngmcwE0HXbCIazmVXdjJYenLG3SQ7Roatz+yvIx/79kgRNNJfi3dpfZIHksSA6RKEipYr4dA8APxEtHElZiPcwkpSxLgwXo2fT20/g06oL97lVKCs5+M3QOgD5NGD7ERS8t+gvQVdZ1aGrWP9GcWG9mSXMKHARq7E02EZbQv/Q94/XN9s9l52/jXxpXgqle1ZDtbQRlcVliAYhtU59PzTLwrANg8O/9ZpxDSgfeLoXIFbL+qapPMcdP+CRuhuOhOZRulJa6zl8awfxTclJXsLB+vueAz/HbmqwyMj9ZDIZ/n9qmrtSwsfr+VUuFsYQSSv9q6JCv2XR3XweP7dHxTab4uqJc2aO7MdzDkXHpAxnAw2pCb4RvU75IzxG+ayMvIQVruEEQbB013FBFm+LE75uSQ1TVtSCYMtI4vXPKDGUdWVt7j9G3fmS3RmUMolXR/WFzH6x+tnM3Jzs+vBwjgho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(4326008)(8936002)(122000001)(9686003)(6506007)(83380400001)(38070700005)(55016002)(54906003)(7696005)(52536014)(6916009)(86362001)(53546011)(38100700002)(33656002)(71200400001)(66446008)(316002)(2906002)(26005)(8676002)(76116006)(66476007)(5660300002)(66556008)(64756008)(508600001)(66946007)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nzBLnhKvcbNXL3VGDHigc/myVcMUxh31o4OMv08pMSIVit1rNYFq4m69KX7R?=
 =?us-ascii?Q?2o6NgnURByDDKXwyMo3xP8DRXnkEpko6AYKSMXuJjO4g7IQB5wAED6VEksUY?=
 =?us-ascii?Q?T5jCNXADYzEwe/OPUHOGY5OgsnhXOvlerKh3mS0ExZr7mGZxMW7ZxSIyppJU?=
 =?us-ascii?Q?a4B/BVXOn/6bQEiZabRzvKqFIZjx/bA1fl6lcl1yj+/NYQ55hbczhVNPlKfM?=
 =?us-ascii?Q?N0zSPI+jd458+Tb6HAE9jmhSgdbzaPk1RSO9TJW2VSBMCXstvyEdIRN9h00S?=
 =?us-ascii?Q?OUtf5Z6OXx+gWOjI/qV7uNIUKKXC2oNj5STZxPoTNW654zpRon1P/FzoI+RH?=
 =?us-ascii?Q?tIfhY68yCKQqduDSiNP3uXjeMjVG9cROOieQ6fv1vekIvtmiXHvL1bwJ5Wyq?=
 =?us-ascii?Q?6lMjrA7kdVyuCfkypQ35O2U8WDz6YoIBFOBkllSbxByNaIZsTuuSToS+cSso?=
 =?us-ascii?Q?uG/IJtwUxvQWz+9FowJ3rHG1oFbx+CiLqf/4mRb/XSAPl0YKM12fM9QGZblQ?=
 =?us-ascii?Q?ghrkIzM/PKfdLB9yG8YAH28id3WjHkLVHlSAYnQfVuCl2nYQuxCzLlK22+9U?=
 =?us-ascii?Q?0KjLlkFe9W37q3EKUrvqdFSBcog5VNC1d30IyFQdjEoTDPrhH9JTwhcnV1d3?=
 =?us-ascii?Q?k4liLyhY+snZBAoSMz9HexSahxwSzKtmvEhDWJPyrOWK4iSoJakrODO/aBcT?=
 =?us-ascii?Q?M+ZfYyvmhAo50eeuoTzU9mXo/cnZJFpDvADQmer+sQXv+jggRxU5TX3118Xk?=
 =?us-ascii?Q?c2H5o8T5uhzYdaL/+VE6IBds0FJDiCloP5/QNfhCi75VyEls2xtAFD2L6BZA?=
 =?us-ascii?Q?Y6OxE316PbVGX8nUZ6kEOiP7fRPkbmSLux84Aw0EqpdDWMDJBlHMf88jyp0O?=
 =?us-ascii?Q?4ofE5ZVd0iMWqilLuTKpWxcAXkmyLWxngY4NoxwzZIoEzD/P22IVJqn8akiJ?=
 =?us-ascii?Q?xZ785Oun0tBe/j/WYmrJ+t895mTvCjrHSQc2slAn/kI2Sh5Wef6/r3dC1tH8?=
 =?us-ascii?Q?UzE8Xgnr1TjRo5mEh5wVmPbVvHWez3mASA2A6Q6DGgHoPyJJnhF7BeFK2zDr?=
 =?us-ascii?Q?i700zUFdq60zlJMexIczhIVX+K75E7ynK7169tiQcVJ6ZI4azO1S6mCNoVTK?=
 =?us-ascii?Q?jbn4hdQvX14ZxefLHDxzm/8CimgHgJr2quG7a3Vu4I51YqtuHDVM9R8MlzUZ?=
 =?us-ascii?Q?7ucSyoOmNdDwMR0xQLPB4sgvKz0Crzh39mkptolj3z/LNDUTqVzyduVIYmTY?=
 =?us-ascii?Q?saYIPX4RZPO873lGzjPu4uwvdSOD99/33KqtSWB6klBQwF6W8CoBSg4yqYpq?=
 =?us-ascii?Q?IvYG1tfqOComN6FiAiTB40j6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2560e3b-07c5-418e-2b50-08d97f1fe439
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 05:55:19.7982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTEgQe9mE3veIpITcGlhT3psRh3uZbf6TfCPRLs2r3P7MvS7pY9P8l+T6idk4mAG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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

[Public]

Hold on there's still need further check the gfxoff control residence and w=
ill update the patch.

Thanks,
Prike
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, September 24, 2021 1:18 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: force exit gfxoff on sdma resume for rmb
> s0ix
>
> In the s2idle stress test sdma resume fail occasionally,in the failed cas=
e GPU
> is in the gfxoff state.This issue may introduce by FSDL miss handle doorb=
ell
> S/R and now temporary fix the issue by forcing exit gfxoff for sdma resum=
e.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 24b0195..af759ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7608,6 +7608,14 @@ static int gfx_v10_0_suspend(void *handle)
>
>  static int gfx_v10_0_resume(void *handle)  {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     /* TODO: check whether can submit a doorbell request to raise
> +      * a doorbell fence to exit gfxoff.
> +      */
> +     if (adev->in_s0ix)
> +             amdgpu_gfx_off_ctrl(adev, false);
> +
>       return gfx_v10_0_hw_init(handle);
>  }
>
> @@ -7819,6 +7827,9 @@ static int gfx_v10_0_late_init(void *handle)
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>       int r;
>
> +     if (adev->in_s0ix)
> +              amdgpu_gfx_off_ctrl(adev, true);
> +
>       r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
>       if (r)
>               return r;
> --
> 2.7.4

