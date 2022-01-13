Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EA5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 01:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E5810E66E;
	Thu, 13 Jan 2022 01:37:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A879610E66E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 01:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGXyLyyne6WSX+ocx8MH3QNDkrVEitaQRLXMYlaEhEEcj5PanouMfrb8IpkLqfn3PYi2ewbWwPAZaN4Ey37I7ZsVfWveAhLD3wtF3W7ij9hFSlwi7xHT7kVKDNev2h/vWh5BNm5sUJbxnhJrN0rW8FRGngocITk0YHTim5bX6HVY3jAvdEg/TQTPqYgLn0nwzf4Oyi8c94yc9sCgYRTJ2ZghPF7oRKmAve/vJ7KObT0ErcadGgmhdxQtTUfsLQb3Qgoik6Z0/UsVvDawJRAB6eY7tzur7fIiAbZZvYw5VCFtS1RMhMtH9ZkFN/fgsdOAogHdFVVhXfrettYf2+jyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNWmbrw568NUgF1mvGfNirs8qMlvSJN/5TB/PFeMBdQ=;
 b=lsT0Dvm0s/TlAAg9r9dPYwpxW9SIZq7MRB0xX0tTvsQBouEIzdn53EMX4/tKNRsl9X5+XqinYt5rHqeYrc4+7zsE0iNyuacIyTyCp9523tRgORGIb+SrUHX246mGL5H3b0mCE653pD07d8jOU2SQpZmv2rcMxWRKmZz8EKthelQ8tul03Mr++uuXLtmiL1sh+nx5Tp82PeCMQ4CwDNEBlLZX2yZrbaZD1fSrIjS29f+9hWjtucFxbKt3rzJcpO2ZoaWJDfjADIDramoVINQYpkeqBGGX+x9SBz5HOb1TTtcxWwibdKCHBlS+CsmjnfTuIDOPrdxKGjx0uUFK7hOIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNWmbrw568NUgF1mvGfNirs8qMlvSJN/5TB/PFeMBdQ=;
 b=sUDkN5/KwQzX6qn2slynNyYMwTBfkMmEaTI4BdjEXnzDVf2gZsHUR7n8iq0qEYAONhB33JE9byDEnCCFf1Btf0QoUeM4FZU5JLSCmeWfUxULOCn4Q70iffFot5ZsLO9ryLQpIzFp5LDXtRoYYcBV/sgfQXDVY9hvhDn2jP3gPQM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Thu, 13 Jan 2022 01:37:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 01:37:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu: make sienna cichlid function static
Thread-Topic: [PATCH] drm/amdgpu/swsmu: make sienna cichlid function static
Thread-Index: AQHYB/sdI3AXGt8HoEivozAwqzmyx6xgLDJw
Date: Thu, 13 Jan 2022 01:37:27 +0000
Message-ID: <DM6PR12MB26193C1481C0BDDD6C9B44D8E4539@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220112212628.3154974-1-alexander.deucher@amd.com>
In-Reply-To: <20220112212628.3154974-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-13T01:37:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c0a67cfd-8b66-4fc5-957c-665da3db77db;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 457f416f-1425-4d09-359a-08d9d63541f5
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_
x-microsoft-antispam-prvs: <DM5PR12MB177039CC5030273692475518E4539@DM5PR12MB1770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jeUKRqGtMs/0i0r8Go2St38O7CMdptmFTZZjF1xFZ2n+aE13x6TP3kab5/hYdtCABEbotx9co7svTW2bZoAB6KytIZB1eoGTuCHN/g6nbrQe3oC2cnrKb5oQ0B1DWQXTQ4HVxDM07wj9YYVAH8gK2TmKMaj7paxYoUU89UzA46RLMRAiCCnC6Qmt+GAMGxzuJB+RtW7XdTKYa7XeWSQnOcd04iduehDuuI6L/JFFjh8OhQT3Cmu+rEEt7u8BuTm3Ie6aXJ0EPWrrGnHmCTUYzDvhKJ2+Ot+TcDarOUFaPbUTxvzUsFBkWtYzzKmMg9WcOVzAmXQ30YqNgepz4RroyEA6GpYiwGdtBSU9bBV0cZWLiP5HezEQ9wKgQo2d/ZyOUSlxsXqM4gBUbbR5CtpBCqYWiKShSCMFZtnz+kmALPNG0pWZm31q5IauEF4PILp+eHTF+9e9uxVRMgBCQH9CN5no0kSOHUczBhq41rsswwr7jhFOpVJ7CW2bCnOmE413Ws4+IplNgmrCGkERayVFtXo+0L+eotlqHpRQgdWRRA3Zen6v+t+71WfM6KcSsUUI2G1B4nEdqfYj7wJSXFf1RGOZTD/lLEnx/0ZMBesqTXSn9u7RkHWnna+lS6qQH9JTigJrq5cSfKzLRbJPo0SB8ILf6wRF0GcaEmvV4ePNb/7IxRGidmjj6EOCagV2zneMKaWB2s7mZFnbV6xtNG7uQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(66446008)(33656002)(83380400001)(110136005)(2906002)(26005)(38070700005)(122000001)(9686003)(54906003)(86362001)(52536014)(66556008)(66476007)(7696005)(8936002)(64756008)(53546011)(186003)(4326008)(8676002)(55016003)(76116006)(5660300002)(6506007)(316002)(508600001)(71200400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JZc3OAnb7r3E9t85/qf7HPmy6KRGJBI3GhhwXV+z6VGYNbFHIjSZ31oCBe24?=
 =?us-ascii?Q?zFlWZ6HtbE6IhOvjv+fO8RoH/PDh7aUamycohxCTKkzm7WUg1kLWkR3mN3CJ?=
 =?us-ascii?Q?m6OZ/RitVbbUFj8/TMpKlapme/OUr1Ryvomo5MsEYCI89k7GbudxbA0din6U?=
 =?us-ascii?Q?i8c4G2xeTshPwQDB3/Tmvq0Bp+s8RncgUYg59TheLVGI0Evf9QwiDVZ/Ih91?=
 =?us-ascii?Q?rdf0Vo/T5WfJ7a5Gr9bgJhhI2JBOl9+47EpIjs/E82qoIvpORb7I1u7yiQc6?=
 =?us-ascii?Q?K8ltN7tkWaXjC7Hb4rQU7a6Q9MbYxGXWVGuQrqkmGjWNJRvc3odojiV4nCTz?=
 =?us-ascii?Q?e0wa72e4DQYXh0/LzU0l/92lg38E0Ss58RxC928V4NQJZgMBobSPDpwRJZJO?=
 =?us-ascii?Q?a0lBM6PUEkHaNsUSjAWWB+bOKZVsQp4196OfTd88GqIkGACKeaQ8wRtccipe?=
 =?us-ascii?Q?utHZoMoh8dKQfDbfB9jdOxTztosGl1ms32GtKLRpyeWA70zinzQu7VD95wl6?=
 =?us-ascii?Q?NuKwezWCombsFyIaeKF/aNG6XtSdo4vtjPR2KPv+qTk8qsbcL/pVyfa1rR+K?=
 =?us-ascii?Q?xmp12R5ryLGEaGIPTM+rLXGU7dsmfG+7e1K0G51g0nw3G5+PE3/pQwQWYYaT?=
 =?us-ascii?Q?ik7WtVK2EM2Ejsgu3GtvvDOflejjT9jxXwHvGzZtNwWOZ9Q57OT1wbAP5z7C?=
 =?us-ascii?Q?+XcQ7j1jLT6+YKRV6xguhtMSBAT7D7HuMMgXNuZKI+o9njelRwzX2q1AV845?=
 =?us-ascii?Q?TNTviua+J+dMR8s8DZdrUnu3l9kA856N6q6cUuEmqtfnFtqNfvxhjsAh5f4f?=
 =?us-ascii?Q?5g2r+vW1t+0959O+o9abKYhS83Uu9TZw0O/Wza4GcmKb/r2mK86EGvegjlCW?=
 =?us-ascii?Q?F2cRdAolDO0g0LUbfDAkcCTjdzzqfI+GUF5VgJUAM4Bi+WVQshYKHpLDRyBD?=
 =?us-ascii?Q?2JbZyX1izojlOopksweY6uJRDG4QEh8oPWdacbFIVba/X2aGIBKW6wim/vRg?=
 =?us-ascii?Q?aKN7472euzunXLbAeefRQL2hhtFB8PzHH4v1ofRBKQSInFzBB+HKrpAXY3yf?=
 =?us-ascii?Q?8WKhOQmpaSifP9TUWT+CoPn16YKq342sLL36q0OPbrupq0fH1kd2FrCCoI0b?=
 =?us-ascii?Q?yeAuWAHlLb++SmgzsuPa1Wcde5xM/GvtL3qjlwu6r1ID5MWSAu3CA7CoU45M?=
 =?us-ascii?Q?0s3HEvkf/MRin3G8f+gkCuBPoS4r7RQ7EfjsH3CNhm3qS+lsuzN0UydXwBcH?=
 =?us-ascii?Q?KCYfXFaZNaO2/I2ajRrWyrDJo/TQr3l86RB60a6ZfWgAiRMn2yDLRfOBDlzd?=
 =?us-ascii?Q?+DCfoKC0Qj++mrYY7kIG7ccvOhb+pR6XmUMcGOIuTysgWF4hGdWS0myzIoB0?=
 =?us-ascii?Q?L3N2C9fjVpSGVjPYvnhKjUpwqK6EZ6Zrfa9M6+oCbUtxsssRZEXBpiA+KXRl?=
 =?us-ascii?Q?EBIpr9F7gC/zEwP6e84mrP/UL3vM6hhGMNxS8gTpxmXtHBZ1x8tWiJRgs/oS?=
 =?us-ascii?Q?XVsJLgl0l/C1sEHWv05+AXROiKC76iu6GiYzgO1bSpJNLhthR1Y/LVND+G+c?=
 =?us-ascii?Q?Iw9eVoEoDw1MiZLcUE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457f416f-1425-4d09-359a-08d9d63541f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 01:37:27.6585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16fZ+Hp+kAnmSoGKuSqKI61PIMB3DaV9WXdFXBxx0Hb+kKS2+tdmXc2Db67FDc+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1770
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, January 13, 2022 5:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot
> <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu/swsmu: make sienna cichlid function static
>=20
> Unused outside of the file.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 9766870987db..4e37cd8025ed 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3810,9 +3810,9 @@ static void sienna_cichlid_stb_init(struct
> smu_context *smu)
>=20
>  }
>=20
> -int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
> -				       void *buf,
> -				       uint32_t size)
> +static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
> +					      void *buf,
> +					      uint32_t size)
>  {
>  	uint32_t *p =3D buf;
>  	struct amdgpu_device *adev =3D smu->adev;
> --
> 2.34.1
