Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FAAC25B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 13:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E7510E40B;
	Thu, 23 May 2024 13:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s0KLL9Bm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED00510E40B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 13:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PanvIdgtwU+29g/N6rm0ki1zqg3HCnPfvaqzAdfDC9EDpfdueQiC5S/lBbTMQlcO5Qvtatw3P3N4YtXNUs38+tGU4ZecRPUF714dhHYTGpb00DSD8ONgWGtFJb4Mfm353k86GsLqID35Jdxws1heb69dpPBmcM4PEFPSQX4o+Vj8b6kJEomEYkQGHLLie1q+rmqNb8fusc1QsrckjUZHXlBaN4DeDapfJAX444ZTYXbxFZqILegzQqRnDcLJn8lbgx2Gt520yfxJ9ir0abiMjp390Ka3EatI8Y80ULneAsAa8GX2YGcl62tKym+U/3z84obbZy/AcoKIo2XKE0xHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qB3LbOkNWpjruvz3Oi8kAfexsOD1NiK2mooO7aEkwM=;
 b=hKCI7XUHZMaOj6VBT1xRcfPWsdvFWriiWSfj3Kx6NTs90yoBMwAtxAXxSaFb+MWVf1jNQuq3KaagiGu0mQRLRGO9jLM6D89KSsl8m2Ex4qQu0/ko6J2tGThA1sCVRHLAN7Jpef42086KWw8F2aIEMWzCbvi6h9cI0Ey05So/AeMhlJUE/CRAPDKIhrLt2bnJPrGqnjFHNb6FqF4EB7tTDI4SD30kNy+ST9p6SYUEpWVJEUslXZ1E87dtXEO2x3kaG7X9ZymfFB2bqj3C279s+4Cxmt4bGGQJbaPtaGNWNWREmG7+N/QonHH6WjqIqoFltxtVeto92KPR63h4Dh1dMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qB3LbOkNWpjruvz3Oi8kAfexsOD1NiK2mooO7aEkwM=;
 b=s0KLL9BmaXQtGeqG5/Od7AuXEUYZldQFsatrbxsKvQHHdJfKhVZXa5Ntu9k683x6J5glDbucWWkHb/x5OTbOCvR0Z1Ouan2+P59JZb9KP/3uDwWS0KLbrLh48CycchOCx6Qhs0I5HKZcViycB4KNp0vxWg8G8c45zHlGOHdWsK0=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 13:56:35 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 13:56:35 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
Thread-Topic: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
Thread-Index: AQHarPhHa2J63NhYq0mPYiwaHL6QvrGk1sUA
Date: Thu, 23 May 2024 13:56:35 +0000
Message-ID: <PH7PR12MB7988A8EEBFB64B5F9ECE70B39AF42@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240523100148.2457-1-tao.zhou1@amd.com>
In-Reply-To: <20240523100148.2457-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8466b0d3-ce4a-4ef2-a3d4-5ee580aa1072;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-23T13:51:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|MW4PR12MB7359:EE_
x-ms-office365-filtering-correlation-id: 7ec4d08c-5ea9-4b34-5b97-08dc7b3028ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?B9Bxe1S5je8kt9cxMaHsmrdpBaoAoCTWyoCkNkSTosMBrQ9owG0ooTVQ4n/B?=
 =?us-ascii?Q?l158lOx+u/otX7HkRLQCWZkjkuA3FUnxA8ochdLqST9TumJEjaH9DG3Ra0Ga?=
 =?us-ascii?Q?BC+sG8ukN2a3OB17Oe0YRWprZLxGSONevGiSv/2Ow1Ipo+n/1eZnTAGwDAll?=
 =?us-ascii?Q?UGTAg4Lo/sTuvyqydtdZckPGVExkXKtpQ3yPPok9izcC2eNZyQ6yURpPjfyP?=
 =?us-ascii?Q?9+7fEMPfQ76mjR769YD2UeEvD33kdsgM/WysIG4IVrJBrFTCUIWALKfnl3J8?=
 =?us-ascii?Q?menG8Lfe+1apfD+WSDeA3oFWk5MUnY1ia8539XSHkwpIhi36R7hpush/4XqS?=
 =?us-ascii?Q?NC+biJ/rGQ+BHV/Z7YL34ynKW2hnuSMjz0+cyfzvThwf1RGyuBXyPhDK7Ta2?=
 =?us-ascii?Q?EwjIwwkQGAbH4AIS9TF6rwOTH1+aEgV1YmRnBR2Uu59Uri/jG6YPq+P1ucEv?=
 =?us-ascii?Q?+raNVSYcTUmLgGqLQ6g4IwLuNmN2B3wiY2Ls9VVByc3QAusApP8hgWPRySWh?=
 =?us-ascii?Q?DX3rdLXDknX37hE8gsGHW8saEeopjzMQCUKtV2dfTLjanZ3GBg0qk9alNELf?=
 =?us-ascii?Q?MSUygHrSCIO0N5Z+O3AUjdvw5RJJOAMhUe88Qwq7VKwpfBeh+IxRWBhHZzXq?=
 =?us-ascii?Q?M7HFNNrOwtyKZ19dq9es7s+hl9H+us91lK7OJp2Jwi8M3DdZWcq8okuiM54o?=
 =?us-ascii?Q?YJ3OlHMRqdq7iP2k80rMOMvbEYcgH3PLaOIXx30v7HCpoMIl0F2CG9iIorf2?=
 =?us-ascii?Q?6ksF63k6yMc6v7I0dZzrTNhfpkhfKP8p3Zv5rPuHn9UselmaPvXV9KAatH3I?=
 =?us-ascii?Q?8MjaQAlDSYzM/buk1GFVz+lZbkReL6vq6byzYzC6cPUuLznoYU3hyJkNYKK4?=
 =?us-ascii?Q?VyBr9pBwDiHXQfye1cUfNoPcn+dvJILP0wQ0fV/iNGhzswwPyp+LslZsKtUL?=
 =?us-ascii?Q?c97AbyA5NijIuBmnNEphooPECRAOgfHY22y6ZA8nGIs/zLywr18ivELXtby9?=
 =?us-ascii?Q?/F/itPVdqu/mj7NU+gPKb/ZZvsp+FM2C+LPkxpVTYUr0ivdsXroL1tEmd0GI?=
 =?us-ascii?Q?94VUufjmGn5z0TbseRd5EIKV86BVewDskabuTY20ufmqs+6ZSqbx0z5VrD48?=
 =?us-ascii?Q?4e6xUoF9NzwAXe3xlLG8mgmy/DOXze+PKvhx6jmF1A3wQNHONlBHTl20y8hR?=
 =?us-ascii?Q?7v47Ti/lPDWbQyU5XA0mczNL1ytRJyjbHswquL8fqTc6CgbIV88rkQOAioDs?=
 =?us-ascii?Q?5umrKuvtCQ/PWQICB438SJ2Z6p2URqA6eOnzoIaUdQLKeq9SrVKaBXOd1lbL?=
 =?us-ascii?Q?YhmVBGR8d1A0lqSMNacTZAWSjYlEkbAx0FqD2ur6VqUDmw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nfk9z2cYS8hFIh/K/pAYUZz4hYeAYeN7//CDUL0Y/SHSi5iDwT/QUwwMKBC2?=
 =?us-ascii?Q?RCf96K4MR+8w7KUV+QuEQxSUPVJ83AV+GRHZY682Y9IVoCo/VC7MVkDzpIN9?=
 =?us-ascii?Q?JX60qP6niTfJ54yQA5HS6ZsGqMRhwklY3/x3F1UQVCWXnJmNLAMefDZL0Ed4?=
 =?us-ascii?Q?PMFkFOnyRALYkMpJ2MI56rhVuZsREKNAZjx1knJ2Bt3mxER2IPOjsKY0b/vO?=
 =?us-ascii?Q?9R98EAQ5cWFidSqFYmGVGDcxahI31Ta4HvQZ1K3g1hzjXqI5xKcZGXMIljz8?=
 =?us-ascii?Q?/W1dtMuDPpp+GqxNf1Sco+RG0FOjogTVhuAgzhcNCw12s4FBCXkQvXAYr+uL?=
 =?us-ascii?Q?YijL6GugUhyg/Bn02/1LN7dPYD6CoHwC5GBFGGKFgDZ0vfPE3NhB0T8iZh+P?=
 =?us-ascii?Q?bOkjsgeMEBXxLwtjCGrCga4UnwvAYFozd0TfeyQ+pARNItLP3wZAecJC4MVI?=
 =?us-ascii?Q?sXDy2gYd8w4obMtFuj265ILuNMZnU1snbB8OdnMANq7BIizuZd3fBodXAxd0?=
 =?us-ascii?Q?Q4aNXHUNGNRgRPx0OuFxU0mrJJPEAZyDiGQZb18J8w/6qWbjsIV82ZlgHGEZ?=
 =?us-ascii?Q?XaakFefmDd66sVhIQSH9VYM+f7gK2NU4G2cOvlGaojj+/2kQoQCiFJpxS3/z?=
 =?us-ascii?Q?XRvdoCQyb0R4WTNsBwtJ+m+WYBeE1QVQgUQr4dt/3YYiR6x7n3GfDIqfuobM?=
 =?us-ascii?Q?SrtvnHcAeYVnzuKxR4ChkIkgeX9shgkENCwkQrn7dtRmK77/m2rAZCn6RLjc?=
 =?us-ascii?Q?LAHCAbddu050uG543jFJZdq2i/tGVivu+QTbfoZ6DuWvBoWJmOGfvcbimWPj?=
 =?us-ascii?Q?XRPlrkJOuu8A03ZG+pFR46Mq9FNqi2u0OVSDIFfOzyXTvuR3wWZcF1Z8T0Xn?=
 =?us-ascii?Q?UiRR5H2XnNf9eJA1NYqcU81o4zZR8HFmjyyaqUpFHnfb6w/FtOqqUjT5WXKl?=
 =?us-ascii?Q?3cTMfTSl7TiOMhpeyeNcCrSI6XMzf0Ay18D/7lFphUEHN+/daHRLdOQnPzTa?=
 =?us-ascii?Q?TRbyzWnAdf4Y4ZP5HdLx2f16m93ziETEW1omQlX3EzCRzUC92qJm9DcA/g+F?=
 =?us-ascii?Q?HpYWgNEgYHjEFF5oON0er19Bs2CErJQHjfatALuPrIhYyjuvlr8vPfh1VWxy?=
 =?us-ascii?Q?cMhVvh0zRnvBVNaetXL6+8RAZS9CtShsEOrMJ9XxeG4IbUDapu7ihkx+BVw7?=
 =?us-ascii?Q?5rXCrnCzOIL1NP6MEpY70Ui6eiTdX2xexbafRPsJwEj+v0CdQojppzieGWcl?=
 =?us-ascii?Q?lz5m5sgdv6atcYbHuCLJJRWItSCGaA/VoecpSbbQ0+I/rsQKtDITajSnn03v?=
 =?us-ascii?Q?dv6BBmYUxIvV8T+iZ1DHBK496fpNt6uSKyD+k2fBeHmeajwH41k523/9GHlU?=
 =?us-ascii?Q?rH69fbFenfnH+vlypTrXqfa4Fnl2bthvR+4yEgFjtboU51fQAQ2RhEN2tO5r?=
 =?us-ascii?Q?9yyLJkI9WGOBSfllASKzrivsKif7wGWsIQkJ+yj6DaLx7U5/OsrQXuHO51yG?=
 =?us-ascii?Q?ISmUte1TZSkg6eg9wtpteUlqbF52MswxPxvG2G3+lNDADdkEHcCakeOT3/hg?=
 =?us-ascii?Q?yXXApbUmaHio5Vij0oM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec4d08c-5ea9-4b34-5b97-08dc7b3028ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:56:35.4573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUZa98RJFzA5MP6Wynx8om41CYba2D/9E1EW3x2+K8qbsv5ZDZwdaZFOo2kYr6qBZY73rwUeqVsDVemC66iHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Thursday, May 23, 2024 6:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add RAS is_rma flag
>
> Set the flag to true if bad page number reaches threshold.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 +--
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ecce022c657b..934dfb2bf9e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2940,7 +2940,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct ras_err_handler_data **data;
>       u32  max_eeprom_records_count =3D 0;
> -     bool exc_err_limit =3D false;
>       int ret;
>
>       if (!con || amdgpu_sriov_vf(adev))
> @@ -2977,12 +2976,12 @@ int amdgpu_ras_recovery_init(struct
> amdgpu_device *adev)
>        */
>       if (adev->gmc.xgmi.pending_reset)
>               return 0;
> -     ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit=
);
> +     ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
>       /*
>        * This calling fails when exc_err_limit is true or
>        * ret !=3D 0.
>        */
> -     if (exc_err_limit || ret)
> +     if (con->is_rma || ret)
>               goto free;
>
>       if (con->eeprom_control.ras_num_recs) { @@ -3033,7 +3032,7 @@ int
> amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>        * Except error threshold exceeding case, other failure cases in th=
is
>        * function would not fail amdgpu driver init.
>        */
> -     if (!exc_err_limit)
> +     if (!con->is_rma)
>               ret =3D 0;
>       else
>               ret =3D -EINVAL;

[Stanley]: Should stop device service if device is under RMA during running=
? the amdgpu_ras_recovery_init function only be called during the process o=
f loading driver.

Regards,
Stanley
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index d06c01b978cd..437c58c85639 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -521,6 +521,7 @@ struct amdgpu_ras {
>       bool update_channel_flag;
>       /* Record status of smu mca debug mode */
>       bool is_aca_debug_mode;
> +     bool is_rma;
>
>       /* Record special requirements of gpu reset caller */
>       uint32_t  gpu_reset_flags;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 9b789dcc2bd1..eae0a555df3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -750,6 +750,9 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                       control->tbl_rai.health_percent =3D 0;
>               }
>
> +             if (amdgpu_bad_page_threshold !=3D -1)
> +                     ras->is_rma =3D true;
> +
>               /* ignore the -ENOTSUPP return value */
>               amdgpu_dpm_send_rma_reason(adev);
>       }
> @@ -1321,8 +1324,7 @@ static int __read_table_ras_info(struct
> amdgpu_ras_eeprom_control *control)
>       return res =3D=3D RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;  }
>
> -int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> -                        bool *exceed_err_limit)
> +int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>  {
>       struct amdgpu_device *adev =3D to_amdgpu_device(control);
>       unsigned char buf[RAS_TABLE_HEADER_SIZE] =3D { 0 }; @@ -1330,7
> +1332,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control
> *control,
>       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>       int res;
>
> -     *exceed_err_limit =3D false;
> +     ras->is_rma =3D false;
>
>       if (!__is_ras_eeprom_supported(adev))
>               return 0;
> @@ -1422,7 +1424,7 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control,
>                               dev_warn(adev->dev, "GPU will be initialize=
d
> due to bad_page_threshold =3D -1.");
>                               res =3D 0;
>                       } else {
> -                             *exceed_err_limit =3D true;
> +                             ras->is_rma =3D true;
>                               dev_err(adev->dev,
>                                       "RAS records:%d exceed threshold:%d=
, "
>                                       "GPU will not be initialized. Repla=
ce this
> GPU or increase the threshold", diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 6dfd667f3013..b9ebda577797 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -129,8 +129,7 @@ struct eeprom_table_record {
>       unsigned char mcumc_id;
>  } __packed;
>
> -int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> -                        bool *exceed_err_limit);
> +int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
>
>  int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control
> *control);
>
> --
> 2.34.1

