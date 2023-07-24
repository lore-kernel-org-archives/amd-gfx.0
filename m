Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A41AC001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 03:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBDD10E26C;
	Mon, 24 Jul 2023 03:02:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C745110E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 03:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b66CQSnMPhwI3b4xOvb1sfkzzcYjNBl0YZ94/6Ww2Sir7Jha3TTgjv1cc6kaZQ2y1+Fz8gV0ZOzT+R+IL2qLNR4X1XkxNFmUkEc6MEq599Un7juSzP+IUGus99VWGkCDMoe8J6A+7JrDLVEK60P99LnDADj2FADECSXYeCgoCbWBc0WAKNRDpxcdLUtrzC3WSd7+C1H8a4kQHolZoi1vaJwJLJNrG4/aDXBo6HMo5jAoZoBXws/Tp/RCkRIvxGBelN/ZnEH+94Bg+CmOf/arVe7WSdU41d7UKJvSvoTKKSj92wjOesj1jv2Vl4osYb1Um1wsmMkf6EvaNwhN3gZB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS9cd4ZISyTkTlH2/lXRFWmWS/U3As0Zihby2wxZ+sM=;
 b=O3izE98LI/ShvctsSEoApMOnQ+G8mMrGdGvofgMI0Fr9olh8F+eFGkd806jWHqvPgjX1Hrmojss8pQIh8cIf/4T3a4FtJTWFAPQjL+SrnY7fJaMcctJmonI2ZX7+iYOhLTEqDYeEpRWpUwAG4JRBO2i0BJT/9HzundJD7XmQUTqhoK5Z++/c2ATfAmz8d2nfpNuyId/5Ejz5Ds39opj+EjaWMCznYKxikdYskO2HirkcqpboHNyiR2R7d797YOewb7RtY6eG6G+z4reftTHTpBT49/kt9G6s4a4FduEaZFll3NC+WTrlpkGRjArEk/QbtpSioCExlhVIdvE7m59CWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS9cd4ZISyTkTlH2/lXRFWmWS/U3As0Zihby2wxZ+sM=;
 b=jnPLupke/NXbtqgy9NfBfMMmR44s1QprPwTs1MDgIirxkobr5O49IDyX6mrFqpl5X8Zx4UZWdsY0fXYg9CpfYd5lrf9uni2+oCztS/cF9dHOz8UxG0AvaOPoRFH3EnVJRin0/OYYorqOv0/zEuYtN1ZxRyC/Lo50Gcxyh8ihF2o=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 03:02:38 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 03:02:38 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amd: remove repeat code for mes_add_queue_pkt
Thread-Topic: [PATCH] drm/amd: remove repeat code for mes_add_queue_pkt
Thread-Index: AQHZvdovaYcwyFsAiECX8jMLcpt5p6/IOj4Q
Date: Mon, 24 Jul 2023 03:02:38 +0000
Message-ID: <DM5PR12MB24693038BD5BDC99AEE3F145F102A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230724025433.426974-1-bob.zhou@amd.com>
In-Reply-To: <20230724025433.426974-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1dfcf25c-c02f-4b12-8cc6-4084b9617eb5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-24T03:00:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB7803:EE_
x-ms-office365-filtering-correlation-id: fabdf0cf-21ee-4a04-31ed-08db8bf27026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdeVsqqiDo+Jf5r/KpNZ6EP0ONRAFUZ0pFz+wWnttWt2Jht8ueuNF/5P4wZV9TUA7PCGGy5CSUPwx84WR4r8oz6pRq7VJP5R/Ra+xxN2bi2KG3/UrzhtWCe4wWb9XSFjb3zLd+0NQ1QmKkbUEP9Zc+FjoOgH55rduFbVk15JHER7I8SAtWaLiufNJMKta53BDjsNRuT8oy8LuikIHVdGv6SkihNDx2GwoAd5EIJIu3GDHO2vxC7+tV4SIZm0zAqB/cSM/yp15QIxk8nhmrFunbivy95FxH5y3SfLb5aGLgue/d41YJWDCyujg6lkxYNNfkSniHuDXdaZb1qO4cHX3zcMU/JQ5bb9ujSlIUBva8lIDayeu6Nq0/mcMvaM4y4iQg4l/iveh2+Zwi/1SNCey8bYynfehoGkrgr5+8+lFlYaQOy+stK3hGNVXbt2iSOjNUEHvuaYz6pndmxTzdPBlcpplBKUscusC/+61jPCAEcSAWfnTEPbBzDy1I6HWj0sDgU+PxE8WmgHnhh8w22gI83QtlALoJuedDIL44mbErBwWMoBywAplfkQIT5rkX6poTAdyg7y3xrKtU9GEN5av1y1Kxo1oywwTCQS6XsY1OcUuKbSiHq4fgCeW5iaSe+H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(71200400001)(7696005)(478600001)(9686003)(110136005)(53546011)(186003)(6506007)(26005)(2906002)(316002)(41300700001)(76116006)(66946007)(66556008)(66476007)(64756008)(6636002)(4326008)(66446008)(5660300002)(52536014)(8676002)(8936002)(38100700002)(122000001)(33656002)(86362001)(38070700005)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hoe1b+OPdgWrbODt2P/z6DI1fB/b+8ZPituVnmDXVANsQtgNXPAKLEWvRZJ8?=
 =?us-ascii?Q?5LoJxlbRb34Dku1mENYrHsUTHu5ExQbSYSBYotqvhNPPHcH1Gv32q2Hkpq70?=
 =?us-ascii?Q?1XMsBbUOZ7A8r7TqUIT5S/01S4ih+Ax0IeLUiOJ+EQAilLbZZM1PEFEBQO9u?=
 =?us-ascii?Q?rRe51pkAVLOp9PHBo7+i66FrF2bMPnC0kL5vOlPDPswjaeugxR2wIz7phPZw?=
 =?us-ascii?Q?CZhFs0L+klzl9yYDKehAQFUjmLpnbbozqAmwgIDzpPlJ1Labx1tSKS7NIvYQ?=
 =?us-ascii?Q?E8BjpPNvlREAhDuZ5QqjPupCVJRaJgFd01CeusiSvWGijE9YeT+gdwPMQeog?=
 =?us-ascii?Q?UBlS8eLfi4ypwXTNNJl31va3IqsbCaMNayoQN4y1OAJSsFVgOyVE6yJjhmNb?=
 =?us-ascii?Q?giILw8p7M+nx+XteGm9Q/uNCccb/Yy5TQAVwkUldL+bUEjHoqjdw94cmEKaq?=
 =?us-ascii?Q?3B9DPP6+swzSWz/voaN5IWQk5xXX+0/SPheN3wixxdTadaDWkxkqbtzZzLfv?=
 =?us-ascii?Q?Lm0D5Go/zQcS/rzuFm2Q9Kb0wqjE23k5E8fGOjCKpcp09mIUQzhd5fR+/ZBb?=
 =?us-ascii?Q?LmcCq+AnemdFPMLhBBoLbdxbOYcACyQoq4uRp+029BGHQCncqVxGkbREEIp+?=
 =?us-ascii?Q?Swa6/Klmtv17PhckzZ2mWEscNxhn71ndjEzINfLdqA6VkMiY6ZjYJproJ8aZ?=
 =?us-ascii?Q?Mwm3oclAe2XyKZCkof1buuo6NZK9TR3uIHbZcVfXM4jzsEaFVnWJ44p4Cl8f?=
 =?us-ascii?Q?smclLsoE5iJPMm2GthD7q4yeUtiEtutQo90UfkO2iJ6f8TL4JMiGVJKXH4Js?=
 =?us-ascii?Q?w6H/G3F3QSmdr6lG0+4fOF7Ca4rx7LPLbhDhW5CPmwV6iyEsX1z2tAr/9s6F?=
 =?us-ascii?Q?zT763uYXrnl+PwTU1cRFDnPQnIFSIhwKrTbL0d34Tagxm+uwcnyqzeQLdlYJ?=
 =?us-ascii?Q?N64uwrDSDZmfTwnIRR/MSRBxr/90CCfmuAgtSiPn2jxtR4yB2iSYc1zdqVgH?=
 =?us-ascii?Q?toCk0SQ0xT73jvg2i2VROfPqaiLOuMbVUBBIhjXM76u2ZMwc8ehdynbAISys?=
 =?us-ascii?Q?x7QZVz2d87eWToKvSJu+UX7yVdw/2j4cFF3mdGLsHEbZKM1tJlg7BPqxucMU?=
 =?us-ascii?Q?vsNkd5DzeNUjKszAuG0jLAjEQL268X+ZXEfiwgfY5u+d+jVVKr3Ivnxj2uK1?=
 =?us-ascii?Q?Xp8i0XnqEMiQerjXbbF2EGkKAJtC6rTyn9NRDN5UYT/ofDOlJ/sDB0zUTlfX?=
 =?us-ascii?Q?M5Bvyw745MQZ4Kz/UyJ5p647I/oeFZAz0NWTyAcn0DwP9JO76MRo2pjcryhi?=
 =?us-ascii?Q?Gm22rRXj5lzU8KjgYYcAna7ADvJRMbHlQKoKkA87VUQfvwxPcW1VtTPxTZtT?=
 =?us-ascii?Q?4B1j0Nt1eMM0fN1rKbS/YytttDWLc6+jhOPk7Ry26AxfJLFc/1vFpHJZA98c?=
 =?us-ascii?Q?RlMTHuWqiTb/hy68ZFaX3YhsLuNAVyHpo+TWmx7/WSSC8jov3EvDEgmnNCf2?=
 =?us-ascii?Q?4abs+axKbZ4/ktng99oGWAdwowhUvhv/o14qNRIZNzDYXvgWi0gN9wP2A60v?=
 =?us-ascii?Q?RZLR0gIVKpfSxFeqU/8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabdf0cf-21ee-4a04-31ed-08db8bf27026
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 03:02:38.2845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuWKdztvwTlhhIDIjweoHlQI2iuH0O0MsQULmyi1wUzmsnTh6U1beXCuOSOoAUNr/kwzJKvyEwwQRYrVrqUUiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

It's better to use prefix "drm/amdgpu: ..." in subject. With it fixed, this=
 patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Monday, July 24, 2023 10:55 AM
> To: amd-gfx@lists.freedesktop.org; Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou, Bob
> <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amd: remove repeat code for mes_add_queue_pkt
>
> The setting of mes_add_queue_pkt is repeat, so remove it.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 8e67e965f7ea..e806331fee42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -210,10 +210,6 @@ static int mes_v11_0_add_hw_queue(struct
> amdgpu_mes *mes,
>       mes_add_queue_pkt.is_aql_queue =3D input->is_aql_queue;
>       mes_add_queue_pkt.gds_size =3D input->queue_size;
>
> -     /* For KFD, gds_size is re-used for queue size (needed in MES for A=
QL
> queues) */
> -     mes_add_queue_pkt.is_aql_queue =3D input->is_aql_queue;
> -     mes_add_queue_pkt.gds_size =3D input->queue_size;
> -
>       mes_add_queue_pkt.exclusively_scheduled =3D input-
> >exclusively_scheduled;
>
>       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> --
> 2.34.1

