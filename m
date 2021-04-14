Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E324C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DA961176
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DA961176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549B76E8FA;
	Wed, 14 Apr 2021 09:14:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804FF6E8FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg924GQQyxFIaYpV3C4/2iy2medjY4KQrf4EXJqNh4yKXX4fPjtorm7FB9NeppZluyV8JAEwNBCC/RJfW0TjS+Ft/J8WLakLg/rfOl7iwZ/2gxE8Xyj4PuhXrwKQUCKViqxVuHEgdLSvUMFGCqGgB5RRBjmElDVb2wC7rGDGGAYxLYsSDSRieq4gKQrvJ14Mgr0nHK14VadWX8Hp1dK204xJTC157114vgZsFIFGE2wiaC6rUQcxxc+WCbu3MDaDfim6u1s9HpYZRYn2tUMkbRIkC5vxNNWsRTtvwMjqvKQq10YbilrJcVwNkdt/OMkj3GVA1IY7ltSI9ZL09Cf4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuBfyrxjLAXfBukbBXBR8vj4ry+sX4iU8fTrLVhdBoM=;
 b=BhuVoUhbx8+5YZG/bpxPMhzHa0cobvb6rTIXjC0Nrnknxe4+YDefqzHEIyLfcsoVQEhXNxmIyWyqhvFooLrTYOTEiyLDIFozrqlTrFj2y4hzRPAfi4jd8xzZlcQxrOx4OYhLszncDIX+dcij3wxFvZhEkjaaHO8S9aLdDSTNVMJoE/RUhejNfzGGarM6xR961/F4GgyKkOoLv5AXBpHFdryisob2EGMvQTf1EORoH/tJ1L/FGuMt2B+tVvAnmmavn9rrRwTRrjLYzIeK+ZXxbOssqh6YDV3fQ3Maw3ljRWVFlOwUWCDivq14aOlxbL82ou2gTwLSbZ0gSauSDhr0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuBfyrxjLAXfBukbBXBR8vj4ry+sX4iU8fTrLVhdBoM=;
 b=A7CmwhbgmLRc7Rywus2A03hBt6+Zxo3xFoPr56o3gR/zgwrYT6u87LoNHMPVC316Io5zdUgGOqaAibwQ85lBGnkPMdjlFC4Pk4fImMkbYVgSUQGNfoA6oXklSB94/wrDv1Acqpho3kcTjlh3ebESQH71QS1VH4mZZ5VG+9yyrr0=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
 by MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 14 Apr
 2021 09:14:24 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:14:24 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Topic: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Index: AQHXMQ0etd6/MbhQK06bROG14bgUz6qzuq4g
Date: Wed, 14 Apr 2021 09:14:24 +0000
Message-ID: <MW2PR12MB2460D3523471F8E7E3D698B79A4E9@MW2PR12MB2460.namprd12.prod.outlook.com>
References: <20210414090355.737034-1-Jack.Zhang1@amd.com>
In-Reply-To: <20210414090355.737034-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-14T09:14:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0cb90de-b45e-465b-b251-0136b8c91852;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da019b88-9426-4270-a50e-08d8ff25b285
x-ms-traffictypediagnostic: MWHPR12MB1792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB179245E57200549E419341A59A4E9@MWHPR12MB1792.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+eP+g9a04w6NENzlRgR+MRdWFLCRMS0Kwn6qgWb2h9ZACE6pvXEoqMfq5RrWoWfMnak04jxC4Tvrz6En4lXTsxpbaTgw+ZcRl3cpB6Ay0hSzSrxSLZds6P2NttBL+3d+xniW86XepwhXsC3BjTAo/GLNHbG2mF8VO68f3acn0aM9jxCacR8i60qbsLK+9ZNsqtJtFvgoYcXRTVONw+lUumaGZPT/ETtCcXeoWdt8vZcoLx4h8Rpgp7Jua/pW9kLjBFC1rHV6UJm/RyZcnYkgXUOuxML92+fQU/Oyor4BgD25BPeNfMYHn2+JJ/vSEVaOVSOiBNbF2x6xAz4RbexbvQHUcZegx+6uEdvhL0xxoq1FQwBkpTc3eInjCFktvUTHJlYYdElHS9Dyod/hsWluIj/JFNmuTankCCpC1g5TVTekovrEqsQWnsIZpIz1i7I6vZMYjsQnKyYQax3zSUf+B9e5CHGKXKqo5b0sr2AoD9vlk6kzOOXnK8SpCp1jYbSQBxwsaQGZiqbxW+n2gTJyCkwA5j+1Q8yq5ooAxcqHLYv80jRm9XWN5MNUqWZWlOKvxhzmR9hq7l7Jbb8Roh80igALgtXZuSvZUmojRwPj5M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39850400004)(478600001)(76116006)(8936002)(66556008)(186003)(110136005)(8676002)(71200400001)(64756008)(66946007)(2906002)(53546011)(86362001)(38100700002)(4326008)(5660300002)(66446008)(7696005)(26005)(83380400001)(6506007)(33656002)(9686003)(316002)(55016002)(6636002)(122000001)(52536014)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TLw2OJTmbP+obU7rVx9hFqGuHLitq8Wca7gKxuv9Y/MfckFGW8QSTRxDImKa?=
 =?us-ascii?Q?PW4BbXogQRPo+EmSU0HKfmEnpS938bRlHPQouAyXZQjfDUzGkmSKZN0CECdN?=
 =?us-ascii?Q?BKz73b0y0HSj7669+n2c14EH/wGgIu8ubWP5Gp3EAIQP1sA3EwvtPlF2FWfC?=
 =?us-ascii?Q?jCi/Snhc/3lV5elLOyyxSuuj6JPeCo2A9C1LR1n+YQRJc9Y3dAxD9lmBLrGa?=
 =?us-ascii?Q?6eU/Sb8OCHvQXyAnY+dpiZWJgF15sW8YnEbRhCp76ZTsXYtr8Hl0VXEI91C3?=
 =?us-ascii?Q?9TQqO0dJCuTjFOpZoCrpKaxtsCsfY/8cTgNvqqK2VBfbnAyrXylOWyswsPig?=
 =?us-ascii?Q?meuaO1MbYGn8/ACnzvF5JM55GB03GPXFhJARiFv2X+MA/EFiXcNA5sMgF7vG?=
 =?us-ascii?Q?+pfPg0HiSetQzKYtCKDCXLOtT+Gp8eQqGTURdcnqad3mZIp1fklItIcZ4DgI?=
 =?us-ascii?Q?JRVUqJa34W4Gvqvq0YGijT0APbt3Xc9Kk+wA3k5oCH2EScn/J+f/x/AOlPzR?=
 =?us-ascii?Q?5PppSU3hLhkl7Ayu+k3vVqGQMaqRwTfO/8RRpIfYv3FePKz2FpAGsMG8bbmd?=
 =?us-ascii?Q?O1DyNAQeZpCnaObz2pBZMHGvALhkXgC/DZyC9HXVidwgNgu77Dhtl5CB+/4H?=
 =?us-ascii?Q?udQk7SWN2RcehqnpWKHZPNm4uLIOE4gbpQhlj39TBJDYieXtox5GexXm4FkM?=
 =?us-ascii?Q?WRQCSbSTXvL26mW/CaRuKp6kuoEKsGi7GgOq2TtohdILxVoR+eM060CKDlNh?=
 =?us-ascii?Q?fOOIx32uNqy+weyPcgVZXoxyS9kNkCWRgql5N8Wm7priaDAI6yrHY212r5jV?=
 =?us-ascii?Q?/UossVBm8D+fuNjQN5nWHdTGUx1SqLQP0EBoBqZfdcVKLLm1letuqiW7SRpX?=
 =?us-ascii?Q?IWr91Zr+fh+gWPirFkyVznsreqInQSkKQ9DlTgixgvJnr26L53WcvhLLReoE?=
 =?us-ascii?Q?WlYKQOwsBc0Lw1OXyrt7QA/8a0qlXf94NQajGLxropjxW2glXFVY1zRI7el9?=
 =?us-ascii?Q?dTA74TTk1rhHB+k6Tm6/srl7OLEjmwOItC0q/DR1DZQKGGbdArIYTmkv6ctd?=
 =?us-ascii?Q?pY6b8fL3ZAPwwIE/YIATSKFfrpFXwgx+x16u49MJmkTAeoU9QwsudtxXDxv8?=
 =?us-ascii?Q?i4WRqy7W0Hd0u1m49by5HktLlcOrzvSERqrsEmMv8PSD9Sm9wwAAghypCR/v?=
 =?us-ascii?Q?0y3Y7riYBVPqLWYm+qn9c7V9LROIk6gcz5i/QLiz7J9Q/3egPc1S/pCI6twq?=
 =?us-ascii?Q?POMdKky+7y/x4oDjD4KGM4vebMzmEPjM4edWP1SPTNsjQYgDrQ6rgvNF6siU?=
 =?us-ascii?Q?E6EIsfCMizeHvcqpcGCnZwUg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da019b88-9426-4270-a50e-08d8ff25b285
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:14:24.5351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4MKe0gbaFbm5sJO/m+MNW7hm8fShtiSa+I9gRUT8QcPnbDsIAQhdhX9bl73DFpPljrXkDxkS5lJsHJNp1QDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Jack Zhang <Jack.Zhang1@amd.com>
> Sent: Wednesday, April 14, 2021 5:04 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>;
> Clements, John <John.Clements@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> Subject: [PATCH] drm/amd/sriov no need to config GECC for sriov
> 
> No need to config GECC feature here for sriov Leave the host drvier to do the
> configuration job.
> 
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 123ab3156f5a..7bdf93716fbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -567,7 +567,7 @@ static int psp_boot_config_set(struct amdgpu_device
> *adev)
>  	struct psp_context *psp = &adev->psp;
>  	struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> -	if (adev->asic_type != CHIP_SIENNA_CICHLID)
> +	if (adev->asic_type != CHIP_SIENNA_CICHLID ||
> amdgpu_sriov_vf(adev))
>  		return 0;
> 
>  	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
