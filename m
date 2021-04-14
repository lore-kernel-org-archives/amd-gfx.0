Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BACCC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC751611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC751611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9572A6E8F9;
	Wed, 14 Apr 2021 09:17:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BA96E900
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3xzTqmhw4UD0plxedUFlCR4uh7XO2kcp9ic9P1GIR2YlArnYN3VZSUrlU81LiR5WLKDl+rBaedU2/VpToqhrIpaXQhxsdilCyBRupviLbJ9KZea+HoHpthk4wak0KYrZHJPbfAcz8GmtUSuYYcPMBDR4hoUfRELwC5Je1/l1cIQTs4cXaGo32VwrevtvrF1LfJcBYLtSXLBLM7cCD5UL5Ez5YqubZLTey51ie4rPmxqwIFZ70zNh/QSiWgH+BkCDRVaZfgccC1c8nLDDwr+4ZDBaGXCfMcdrmbPSrV/slvRb8i/kp3Wig96KGaJw8EKM66a43JIGlztYAzPIhhu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IJXy/x21/ku2M+pG0yNAtAtFg6EqXWAWqIi5eQNkqs=;
 b=XIUMXErIkjXqomzRFwccAn8n0itAfod4UPIZf1Nsta7ZAz+aoRziT0x6Azx+qj3+yAQr4cwjD4r+DOGCPTQLPOtog4AmzG2hNGNziwPnpPuyOXEbL7XFzWSEvtV2lDO35GBoZKlSftOsbp2AhQb8bubn9iVbG/Riwtm5tmx5BI+QStan1NqUE+sY0USEHKI+YZLKMFQXhtLRPmlhOXZH79yGkHDyQHTaCR5p+p3vrQRUKpgLr1aMJQnvhtp7YAl61cSlDDFvJ/lI/hbqzF9sPvRi7WdhRBoIF/TGMizQZDaHPDrVixTuMe7HQrSIKYKtOeO03/hlEe5OJf1JL9hRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IJXy/x21/ku2M+pG0yNAtAtFg6EqXWAWqIi5eQNkqs=;
 b=UgmT3BToyvQV1VhCMz9445Aif6hsmjlWJE2K9e32TO0sCdI9207qvfLTjSa65QCnZOBkD+k3yPfMea7cA882MWrzcnvAyeXgnjKZJ1Uj9ONNUxtDClpRuTN+6EAVOgry85z4m19vscFvz0ZrNfZ6gp5Xq9c+F67hGqmfojwPeZg=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 09:17:19 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:17:19 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Topic: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Index: AQHXMQ0etd6/MbhQK06bROG14bgUz6qzu2KQ
Date: Wed, 14 Apr 2021 09:17:18 +0000
Message-ID: <MW2PR12MB24608FBFFC544C0B2045486A9A4E9@MW2PR12MB2460.namprd12.prod.outlook.com>
References: <20210414090355.737034-1-Jack.Zhang1@amd.com>
In-Reply-To: <20210414090355.737034-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-14T09:17:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a18ab709-2777-42a8-a8c6-2c6792279147;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c68d616e-9a91-4379-4a0a-08d8ff261a87
x-ms-traffictypediagnostic: MWHPR1201MB0174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB017416989406767D8A1604679A4E9@MWHPR1201MB0174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2g0/Q9qBwrG0L+i2sW8vyqR4erLlALE6Ls54UTNkcJ+ZYODhiFU8JbS12JW/L6VoPqu5FavnVnNuJs5e9fmSc/XQQAl+JSiMSIc3SUeoEc5kXuJBXGGR5H+jXE8LUB0vtmuj3/HDHWAQYvis2cIlNSmwQ/KR3LlXrrWvbHV8I3Soi1+5vd1Kj7yThmsDkGjf3Kh261Txse+GmLHn35UeHfZL7MjjeLgGw3TO0CIDNPF++8jHvlqI3oKFOVYglfU4YomLr7mf/uKjIy6XU7xFReCzEYrReDU8I0ioTiBUDe4Nvdh9S3WthZ6EAn9fGS1eF7K+1gwq3uTtXueS8HoaviCdsb30GvJJpLIGtKiZd2fdJerZPHgdTaOfW7Rx9x+Vi0XKjFtL2Drsi2kBaGi7nFbHRKu5935IBIRiO2CXF+DzxYbQaSqZPYc1QRDubq0lBZzBUMKwLkcvBEb8bCLA4HLciQCxhN/OPADskyOv7tYJkGxOUcWFsLMaD8gsBwB3qwFa7AZnAgQwuvh8/6BZwcSoQrWky5+STjYu74hCU42AAQntD2G2hwJjkmIsnQif5UT+kWGmj5QlnmAlyQAmdW0nnutFDlrQlS7UxkN3VKU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(55016002)(86362001)(9686003)(33656002)(478600001)(110136005)(4326008)(6636002)(8936002)(8676002)(186003)(52536014)(316002)(64756008)(66476007)(66946007)(76116006)(66556008)(66446008)(83380400001)(53546011)(6506007)(7696005)(38100700002)(71200400001)(2906002)(26005)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rzeCGLNSpmQUhLXWOpxbZ/HVYnEXNnGEAyCYDJJPj/yiVnlOW6+hFQ/AYcXC?=
 =?us-ascii?Q?cW9zuGeKSlVFfaQif6K7tgjQ7PBuYPovxP+pskidb4rDK34tBEYVjFA2hJR6?=
 =?us-ascii?Q?dveB2Y096Xorw5EZfiRACnp/a8/f/bzn2ZNhmnUFyja2HR4DL2vn96M4SH8O?=
 =?us-ascii?Q?Z7ZPD4Zs8YT9mfKmHAE+gjVy+trdTiVwsP8oYxw3r6IO43dFfz9tFCEveD7c?=
 =?us-ascii?Q?Ibgy+wkxN555bkRih8ZNNRZvUmP7FgTUGY2FsL7zoXubiO6z6508+XwlBtVD?=
 =?us-ascii?Q?6SHiLMlovbDj9QRuEHpccVUOd8bpiy1CHelxQkGpZYvXWXudYMStOGsF25cu?=
 =?us-ascii?Q?yqWeXlRd146HoYOuK+5f12S0ahcDBIhAV2pchjpZOgaFGAi8C94SrpB2gB8b?=
 =?us-ascii?Q?eYiaRrThGEtUoqbyH2GVVDwAUQKvBD8hReWiU9FSzCEUxYzywkWOv45ex+vW?=
 =?us-ascii?Q?L5RIXX1kX40l4zrnGqzT6k+c+n70tVWGiK33oXe5I4ScVEf1+SygG1xtP0pk?=
 =?us-ascii?Q?tpJWmzxKyxZ1HbpPZsgJkHcnGNO/kegfCfxcagwA1ndBe6IRRoWzLUq+aNA6?=
 =?us-ascii?Q?TWtWL3IAiPFS1xSHxPbUTsSD0gwnbzMEgp22/ltki6NNwJp0mQeKvb+2M3va?=
 =?us-ascii?Q?4ga9TT3wVAN7GJNV6MoYwE/MyG2BEv/nAP09i6tDx6izh/BIQIlEogeEeV3+?=
 =?us-ascii?Q?IqrLsu1CIzTor2zd+R+GYdjp3ED8qpSIcCKs+qfQsYU3lDBjbr1DB7kmxYx2?=
 =?us-ascii?Q?YDyO4NCwv1WqFbXleZAvwZeg4GdCXRmekLn6BUkoYoMf3LVG+oMBDXcEaza/?=
 =?us-ascii?Q?8dOTWKhvoQWLcHaV3vhHLy2RcniDabQBMJS70nHXlA5HxrkWmLU1/XQ21h3B?=
 =?us-ascii?Q?sNPixIdTo/tmUZBZL0mr51DlWlnm1BqrIX0acvogl4q6HyJuSHOQlUoVe+x2?=
 =?us-ascii?Q?XAb4A90SgNRm8kbDlg72RI9nm+hLL5++BfFU+ZYZV3LgJpb/5Lq3W2xb6sIc?=
 =?us-ascii?Q?AHQBpJaK/dkkCTx6GLCPqq2Rc5nrhBsb8bRnisDEUg3lCanKEZyJhniI/+Nk?=
 =?us-ascii?Q?tYAYQPVvi3OwgA1YH30dwmStA492Kv70KW6MLY/CLr2aNXjNVLtdVvXuHUJ0?=
 =?us-ascii?Q?mZ8wQE1sxxKScbYZRjzBhDI6Xw7GUG+DfD6fPgV34/6a+OBsdl3LrSn34Peb?=
 =?us-ascii?Q?8QyUu4JfAywqeqGNQyzFm+jdTnCYV9Wl6/FzzYQD9dB8lh4NjX9Y8CUHbtEc?=
 =?us-ascii?Q?gEg7zDvgUYl6vpMOq6unZa2Gb27uAAUnnr4lObXTIMqgku/yKblqP3raHw10?=
 =?us-ascii?Q?QVSL2ZT+db0qrzgv4QehM975?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68d616e-9a91-4379-4a0a-08d8ff261a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:17:19.0070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYLp0FVLduVhJaWDpxUMn2OOlcrlwq2yFuTtOYlpF0jKK85zeLVDMD947rVA11XYUCC9gR7xV1Chv7meov6X3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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

Stanley.Yang <Stanley.Yang@amd.com>

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
