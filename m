Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0E1C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 11:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C6A10E46D;
	Tue, 31 Oct 2023 11:00:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B26110E46D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 11:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiWC422YlLxQOkYsdjS6/SDkJGjhMzH7YFwSckqbjVEmWthOYUFS0FAjVHrdIJgj1nl++2oicne0QunMJv1y1oScjyCn+mA+KTxG+/0v0Vtv2NtI92kr3gb3YWUe8RMCH/Hp63DcpQMXhQ7QMwcVMkAvBWPryKOkT2H6VoWHWT3+LSi0UfIxB+1q0EVqse0ABtmTE79lvcXIZlgabR68o2mpY0QxMwznw0wiXMKXI0ORbweWx68eZFPVf+JiEbMr9im9XiAuIUfcjPIrGqN0AWp8mZGjIsigbqrvSpYqaOZlRwPrzntodhzhLe+PxErMS7nYPOjBvQ6AzLRevN4J+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOEuTTd/hKVhCi1G1asbo4lLEi2OK0zISXHKy/vnK8c=;
 b=ZQAi31Tgldk2rSKPUuxcdtJZ6d8PPIQf9nUjsRjhy5Ta9Py5gfpNpk/JdkGbqDhxlV1EZ0ZxgQ3P0JeYmUr3aoGsgXSrYhVhS6+JQzs1pnViSH4L2hvAyBoQ9i1FWaTh0TniD+T76ch3wZAJ+deqGQeTpJFfQCAYd/aAEXx4kGABK6+0wzAqbYestYnJVl0iW37hNO/nwSFbBo1daffrdC7GVakn9XQcUps5lAnGmQXDaI5v08OF+3VBmue22YV0ec3+wjhwUe1EnqszT3yY/06ENn11xz3d4bq7fFvFJ2h5WUby23qjUgh6mZYk/aQ7UClUu17zgrNas9EZrQN5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOEuTTd/hKVhCi1G1asbo4lLEi2OK0zISXHKy/vnK8c=;
 b=cnSW5+TuVn/TYWWSRKgwcD33fG4ZbbTCh3lWHANfA65mzKOYajODS0UiIjdNr+Ruwjfftbc/Qvp0OvxGIk5sY5OtfeaUq7j4B677MeEYJ3ELvzSQ+zyXDKOIku3SMJXw71r35NqGcXCM/lFHs2BrmPtyCWVhr+2Ft8ZHDINNi1A=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Tue, 31 Oct
 2023 11:00:53 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f%5]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 11:00:52 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check recovery status of xgmi hive in
 ras_reset_error_count
Thread-Topic: [PATCH] drm/amdgpu: check recovery status of xgmi hive in
 ras_reset_error_count
Thread-Index: AQHaC8moz/cDBgS8+kyIte4FLedbtLBjuyiQ
Date: Tue, 31 Oct 2023 11:00:33 +0000
Message-ID: <PH7PR12MB7988FF033C9A05950E5E84D49AA0A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231031071231.16744-1-tao.zhou1@amd.com>
In-Reply-To: <20231031071231.16744-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e5402ac-66c9-42bd-b5f0-2877cbc27f7f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T10:59:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|LV3PR12MB9354:EE_
x-ms-office365-filtering-correlation-id: a7318709-bbd7-469c-7b80-08dbda009ad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Ana/JMOUtR67OG1cwMTEVzludFaqfquHb2RvfN0X4EqHl67ZIMTu+dnOsXOhX54TLQikE/ecj0waXt4J4at6rzVsWnDmAWSPl4+KuBryIsr0hlFkO8GwoiiHF+clt14jiB9VE40AlKIeI7d8Jx2L9yWkH8oJkh4jISp3d13wCIWhBxRtXI7WZpcCXjP5Wi+OSALLpfH6keRAXHzZfTcWpOe7NHqBmPnyAtd9cB7eOmdM/kHZUlJLsyvALnxHlFKcxntuu0DhtmuddtEKG5IvwZruteHLTwlOfJCOkJDMgTqJNRQ335SpX+7ql5fdqagkjTjaSWZHuZUd1IvKVYH4VABtYH+zl/oOeU/W/AK4AS7QAN+EZ4fBgr/i/CNXI/3b01A6pyoaGXD2W17qS3J/A0tKkCwP5RFcP3Dcafy2jiJ0n1izg2AbqaTiKDuZOLlILThfYqHD2Cs+hz9G1qVHMO1h1+F1ZzjDAgdTjG5lDnJqngC/EZ8hnqEYRGsWNnwFSMUrpJZQbiEp1ErRm5gm1ntsfOTcNXARZEICLHQwQ2aNiuHbsCiPXzNBusHVY/4IoVjFiSwlKG8uuiwB4ChHz+FRyXxRGVE6qfO30Rtt9qzzoee/qCSkAr5o5bnacVQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(83380400001)(5660300002)(71200400001)(6666004)(6506007)(7696005)(53546011)(52536014)(122000001)(8676002)(8936002)(66446008)(64756008)(54906003)(41300700001)(66476007)(66556008)(33656002)(316002)(9686003)(38070700009)(66946007)(55016003)(86362001)(76116006)(478600001)(2906002)(38100700002)(110136005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnCGnSNbLlnyoOsYLxfuhzpn2JsVJnYf5dv7ALl3OLdoqGdsf6HxOFVZcCok?=
 =?us-ascii?Q?I6WjncxKk1J6P8aIO4n0elSOwubfUt6/SE/cysq6k/6n8WfIugGbGn5wC/px?=
 =?us-ascii?Q?Jt0kZF1kjE9qmoR4Ba5CJy8ypBVaQnVNjpe3un1Tz62hMv4S56sSdrIVhfgo?=
 =?us-ascii?Q?vQKzboaY7ItsZzdwHDA3QmGulHf+P1PIPuyIe/YJa0jePXEfhoKx2CCq8i/O?=
 =?us-ascii?Q?L2IsvMWFbTqsKtD4Fsz+4enozmZ+Sb567lPJroNQi/Nn/PnRT33pLd6mtyvx?=
 =?us-ascii?Q?zi8H5Ogye/mXfl89MUE+KxtQ4sjbScXCtfbWslz2HJXgotzcOWw6lzA+Gq1S?=
 =?us-ascii?Q?LNNW+E8AeFwvsBiAJorlsZUqjJvULlA1Owtbl9kMAWft4KK7GeLBRKQ1g8Rf?=
 =?us-ascii?Q?Y6x8rmwm8ACd8pgGym3KPq+KBqkSF9IkC3jYKu5RDTOZbA5y4frCIssVshvi?=
 =?us-ascii?Q?B6jaYvEDNceK5EoMa1ukGmD2P1WKtdPi21A4n/ipxqBVNVnwCPrjrtU3y9Ra?=
 =?us-ascii?Q?adOXH5Usrji0J1qzDdifNr17HSaCt22rR2oK8P6lKqByIkEOiAv6/9OUzU8j?=
 =?us-ascii?Q?MPd/00q6nTaY5l6+OHf1tqlhUf+XyD/VzdyuADfoOSSW3z7B26BgXSEIExyM?=
 =?us-ascii?Q?w0JOn5S4oLxj6SsUwDoASykVLHtr5eZj83EOLLA7DrVLZ1yvsm9TfrSozasw?=
 =?us-ascii?Q?64k87GK2IAsBEaiTmbHMwtBXSUwVrY9G22B1ojlbISWebVEnEskSoHnLiYK5?=
 =?us-ascii?Q?AvfBcWDQEHY8b/jLTRWAM90aEaf2hJ936AK0gNIOjeIJsmhQWDPSRSoxeLWb?=
 =?us-ascii?Q?PuWxrVfcis/E7qT6AbL7phI9FO2mFGjS5Rsrq7AxGSBhrja1IjRgWt/K92kd?=
 =?us-ascii?Q?DXKXCRWHzFOhLAPdRBjijOyC3npjYceem84uLmBMeFM6WT6juIl1aFgBJIPA?=
 =?us-ascii?Q?Ovkr9FSgcSl1mQsITVwim2LPI10c2KrzrsXHXgb1G80Bbx44vddZ16u6uxxs?=
 =?us-ascii?Q?9kXdrAJ1b49V6k2211XeZu/ktcnCN0+4naf7eYi/UGufjjwiVm8Hur7yu+l+?=
 =?us-ascii?Q?zsFCvFDYZam3ThuJlu4ODeQDh0fBpgefGeVQb4xE08D8CJ4Czlud13KYnVAf?=
 =?us-ascii?Q?j2AGmw2zmHHlP06OdVWMUeiUvBaHGy8r3lGwHj7eMSxY/OsjYldYhvydFKic?=
 =?us-ascii?Q?NmwQ2jIOicexY0b2EVIejV5r6DuthICRpG+8zkF0/pJuralGupuXuhJXPq8Q?=
 =?us-ascii?Q?D1SEbfFvf/x18iPAiq8ZogDbTDfX8bdmX6Z/njLH4pu8XBg1l2eJZ7R5vlcR?=
 =?us-ascii?Q?y21KU//RTqGkLTRpVJZlQf138MXBIUxyVuS6QzvhzBPS93l46Tg6f9im60QC?=
 =?us-ascii?Q?wgZnTv9bD3xX/y/vyrVK61vEAcUX90WDfMqf+9AeSyNmjgXg+HXzRF5db8Sr?=
 =?us-ascii?Q?U+UPQ37KuydEFGTMZpxEbUKYLCw6wxSXotq34AE2aqSs+EZjZ7m/P0fRQk9F?=
 =?us-ascii?Q?TTezZDARyFBAHYZMaEkRHBwBtOJCtOUR9kYWXpu0Be4U1WxNbj+khCymyQoA?=
 =?us-ascii?Q?JpVuETm+xpAWjvMUw8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7318709-bbd7-469c-7b80-08dbda009ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 11:00:33.5322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ns48Dt5VknOX7MSRs8CDZGxR1iAie0rsGBGEveGddqR005eiLEQBw4mZqatab1wLebwwqQc5EaULQRbD78WW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Tuesday, October 31, 2023 3:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: check recovery status of xgmi hive in
> ras_reset_error_count
>
> Handle xgmi hive case.
>
> Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 753260745554..0093c28f4343 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1226,6 +1226,8 @@ int amdgpu_ras_reset_error_count(struct
> amdgpu_device *adev,
>       struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
>       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev-
> >mca.mca_funcs;
> +     struct amdgpu_hive_info *hive;
> +     int hive_ras_recovery =3D 0;
>
>       if (!block_obj || !block_obj->hw_ops) {
>               dev_dbg_once(adev->dev, "%s doesn't config RAS
> function\n", @@ -1237,8 +1239,15 @@ int
> amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
>           !amdgpu_ras_get_mca_debug_mode(adev))
>               return -EOPNOTSUPP;
>
> +     hive =3D amdgpu_get_xgmi_hive(adev);
> +     if (hive) {
> +             hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
> +             amdgpu_put_xgmi_hive(hive);
> +     }
> +
>       /* skip ras error reset in gpu reset */
> -     if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery)) &&
> +     if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
> +         hive_ras_recovery) &&
>           mca_funcs && mca_funcs->mca_set_debug_mode)
>               return -EOPNOTSUPP;
>
> --
> 2.35.1

