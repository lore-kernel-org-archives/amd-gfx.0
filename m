Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26080C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 08:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893B010E282;
	Mon, 24 Jul 2023 08:40:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7041610E282
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 08:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbDVUAi0GCXULOvNgQ4DoyBm74JxrrwJdURNyIqzNf9Q8QoWgAXQttsK0RXYeNWHPjL10MaBgvKzG0lgh0tLHyjc39yP53OUxYLEyghn6pJpVjTAJqloQVG/QzClqPaJ2iEFzuibrZBchVWSPap26XmXYN5ft8e0J9TnHRDljGjNNDfzGzmxakA9iKdOB8pO9udc/jC8Y+yx4AqHAt8Oc1SRilNLjrd9Hx+lirslHGEgACHIxHLWhglV54C3XSD/EtiOrBfAxYt+jbNiih1Dzd5ucuxlgPpaU3+L5ZOqq4ytqh3iu0nZyLF0HPl5XAqGPF0BEti5nzhK4D/hg2O7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAQm5hThI1nYIS2b+uUvkENY9e9X64+E6MiZmciDyRc=;
 b=juVbwJWnjwWTQNA/n1kQo+lvnoicuR+tbAk55JtJVxxsjmgQmeQJy7e6Uow1mzroK4maKIdYVR+EcgI7VB3Kjg/JcFUA77T4GehJs15xdjuhY9ek+JlHqi2nXyhYUoTe/dIzl0ZGCWo5r5E6mgVU66/apSRuHpKK7PTQw9h+dN2d1oPUOjgpTr8RsTURF/UBq6BhXVzNqlsCdIQOpMTbeZhRIloNhj+aUPT1jha0gJ2rTFTsBXm7bbIzuzB5Dbkd7qnARZHYseYCM8XA8iX753SiZpHzvsb0uiAG1wED3+RTBO+bJw0jLP4rPT3hhrtkuo8VcRaUP6KG/cnia6Z2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAQm5hThI1nYIS2b+uUvkENY9e9X64+E6MiZmciDyRc=;
 b=mf2eXYWEYNZXhbIEHmWhwMZSOEA1KOC7q24H842xy5usezJmk0H8/ppanyHg+LZrtZIZZtuWh79RZxz1NaoEsXuUVrIepz9uXXpc5HqAApIGuPc6Q/6k3UBh5l8V+Ev0udmRsp3qDmZ2Vlzkry4O2j2QPpeJTojVCgzyKTmz+r8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Mon, 24 Jul 2023 08:40:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 08:40:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: remove redundant variable declaration
Thread-Topic: [PATCH V2] drm/amdgpu: remove redundant variable declaration
Thread-Index: AQHZvgnj3ymCkt3cjk+i0QUoTy0pua/ImIwA
Date: Mon, 24 Jul 2023 08:40:00 +0000
Message-ID: <DM5PR12MB2469E0FF1D440563DB1CA946F102A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230724083602.454512-1-bob.zhou@amd.com>
In-Reply-To: <20230724083602.454512-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=10e48459-bd05-4516-9d6e-bd94efb65ed8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-24T08:39:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY8PR12MB8363:EE_
x-ms-office365-filtering-correlation-id: 12305cfb-2cb3-4d3b-5139-08db8c219167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EUT7Dub1F6bWQxh6crI9OI9zPqsEOa9BcNrozhI7TTl4kp97j+gpqBFqnIPqIgKojYq7a3Nh2nlRwcOPm1vxRY78o4fCZ8yjVXH1BaC10e4sPbYexRTyl+r8bkM24XpfQ7iWGio+OdTPra1wIJRiQyrpo+/xULYA+qPqHXkAb/njlIfUeGna0Tw8Z+5xO8Y9bFxKNyTRVmTGYCrIxExqDut9vBVC5W0vrWGFGpWRu3AodwJMeDEx7aFzdjwYFI+sSm8fFHqjEkeu5E5Hf1ozs2ACQ6tjxEg7kFhMAcY9O+eif1q9uxJzB60MMmaUUvja0Uo3BmImBIUxRjHTKace70dlW2F+c9zQMvzH4dU1MgSVNmAIDQ4iKrUEzvhaA2xo8iBV1z2IcRf5ofHxApy4xGIBBaf2nc6DtltIdPkj85vYmqfAtZFFV6HOkvk3K5uc1T8TFba7FgRW3Q3dPoP8AYtmknw+odv2eD2RhjnsyZJYdy6KRQzkbIzLYwfNLPZa7pA1nVJx2kmCO/g6jIJjOCMWs5cYzhY23VDL6jqroI9Gus4J5ZT+lq3SNZw7lmA5umjRSn1B41BloFkRwCsA4qm1VjSWThivzjgZ45Ftrb9n3/nboTtXP5HYDywwWcPK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(8676002)(8936002)(316002)(5660300002)(52536014)(66446008)(122000001)(6636002)(4326008)(66476007)(66556008)(64756008)(66946007)(76116006)(110136005)(38100700002)(26005)(33656002)(41300700001)(6506007)(53546011)(83380400001)(478600001)(186003)(2906002)(9686003)(86362001)(7696005)(71200400001)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Um8MGQKnfqPdy9HubmM5wVGOOLgWEfX9tNpjRq1Qm3KM2QO1sL9wGWMGitZJ?=
 =?us-ascii?Q?oJaJA5qxj9IWGRvepcYD14+9GvJuotHBHHo6AUAwM289B/SbRJ7Xf/6vleWe?=
 =?us-ascii?Q?Sv1uz46POf+KPbasXbeOTvnYDaAM2gngra3Aq68MSCkhctme80dSBQUelr86?=
 =?us-ascii?Q?o/DoItGfSm4wiKJHqDBMaaNWRlzuXUVk0ZRUrONxcESo2nD/ypL2TksCXYB2?=
 =?us-ascii?Q?GU3Lxv0IHORO4eC8ug+H7g+IkBIGF9saQe+W7STNOPUn8DgnaDKK2AAj8QPG?=
 =?us-ascii?Q?7d5JropWxux2dqsJln+FMws1LN5RVdSTOHpxHuWyAh7C/6IDey5Jvp2a4IKs?=
 =?us-ascii?Q?FulQLtVVTaiGVnrPzW02FcEtj++geg1h8nutnHaoEogUXfzBbwU85p/h7+4x?=
 =?us-ascii?Q?2KaBXaPOVANvdICL4hCId5rXm1cHMCLV3kh/uyns0ublrrEax6N/35uvJry2?=
 =?us-ascii?Q?bSlrf8BKA1HI3VjIsuEM3T2ZDPm8fb4H0VBLe5FMAFJfncHFmIP8UQ4vDIEL?=
 =?us-ascii?Q?1jSJqN9N+8rHxj6IAKR76Gwtmo9bqG6R07fAijCNHs0Z5wSk6DqsveFdhb/C?=
 =?us-ascii?Q?gNaqHKIoyE+92HrjKJCZy20NdJZW/aH8ODnd5ExrwRcQlJNKf3aWEkOiNjJE?=
 =?us-ascii?Q?YiC5h3LXMP4i44T0Fs+Jo6WV9h23m50OO8lJBUOBUVlGofiqWFPHFI0tELiq?=
 =?us-ascii?Q?sAXgcqWThQ47HNYcPG+IbR0Ksf8vsOjc06egxLq7yBVEgxDrp+OeTTFf4J9a?=
 =?us-ascii?Q?iS0JWSd19ogoTjLoOr/REtQFmlqSoj+u8Tx/+DghRyjO22eBGbwn24jpu2HG?=
 =?us-ascii?Q?i4u9NUXi7crmu/thJVONr39pw8Ll8OwlUXEk4ncUx2np0pfn6U//xzeKSIs1?=
 =?us-ascii?Q?xLElJR1+ANuA4/WF2TNlP25SfUoxvrFofKBEPb4bC1ovguxVVyvaKsXXauKc?=
 =?us-ascii?Q?2J/xDE04Kl3097Nj4McjWZKPgE44yrVJXqToj80ZMB989tPJgey6Kr6xv5np?=
 =?us-ascii?Q?I2nfuL9d0ZQYZpWnBENw+8QyYZOSQ2tTiFddymbq8rpuoabWOxTcG5LkaR+i?=
 =?us-ascii?Q?VoyiFKCev4F3rTF5zdN0bylcKlSXPYKpp4r/1zzDXu7M8s0O1v5FgKcUuCex?=
 =?us-ascii?Q?/aOAzLoXT1hC5kJZJV8KECQ+BEKf+wvLBQDk/ISQsOtMhwwz590QDtrfpcAK?=
 =?us-ascii?Q?ei8OwipZXF15a2MNA0iCsjo1hnaNXfTcgLBZ8thyQ083XYYbXcaHaDzZXrk7?=
 =?us-ascii?Q?i9ModGdnDhtUaUn0S68KURAR6+Ryu+nonL8CyYmk4uGxDvYR2rqtIW+e8aPD?=
 =?us-ascii?Q?DxkBdKfHfljLnkMcewDUgYaCfFM1JmPayOxbMWH0BISzFPzWLpcxWB27Mg2U?=
 =?us-ascii?Q?6410vWmVhbSADLFo6z5RTK8kNPi4pm4Pf3BSvWEmLqqGliGAliOFlDx3Np34?=
 =?us-ascii?Q?UuBC4MXdWsUCadr4Zd5Frs6NwnY86VrULTapvgD3uOnFRbfOfxFHyhWYkcNp?=
 =?us-ascii?Q?UqSdkDIDAJzkteTEeTVgejeh9zbp8YApLRCqFlLKdpJ+yoiOqeJLYedOoISV?=
 =?us-ascii?Q?pNzUYo+m13XmTGI+iXc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12305cfb-2cb3-4d3b-5139-08db8c219167
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 08:40:00.4137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8K/s+mUAlRtmU1AhdJ9w3FCKHmYM03bKftBlAl293SrFGuaPg72RD4rWxUCTILmPR+Oa0fX3M++1gNI7zrgWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Monday, July 24, 2023 4:36 PM
> To: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric <Pierre-
> eric.Pelloux-prayer@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou, Bob
> <Bob.Zhou@amd.com>
> Subject: [PATCH V2] drm/amdgpu: remove redundant variable declaration
>
> building with gcc and W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1618:15:
> error: unused variable 'domain' [-Werror=3Dunused-variable] unsigned int
> domain;
>              ^~~~~~
>
> The variable domain is repeated, so remove it.
>
> Fixes: d769528e4649 ("drm/amdgpu: add VISIBLE info in
> amdgpu_bo_print_info")
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 5ac7544cc068..3f98174fb764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1578,7 +1578,6 @@ u64 amdgpu_bo_print_info(int id, struct
> amdgpu_bo *bo, struct seq_file *m)  {
>       struct dma_buf_attachment *attachment;
>       struct dma_buf *dma_buf;
> -     unsigned int domain;
>       const char *placement;
>       unsigned int pin_count;
>       u64 size;
> --
> 2.34.1

