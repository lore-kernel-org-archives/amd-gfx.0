Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D86C432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 08:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29BF610A8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 08:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D29BF610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0AB6E342;
	Thu,  5 Aug 2021 08:37:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABF66E342
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 08:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjgLYHimxievoAtkrdPV0s1Y0BSAgm7wl4UWOp2CI0L3vxoK1P8EHO/uinY+dfdKg0xUHXxZXKyhbdU5PZmkCv5qqurIWZyhZIcRXgyEwPFBm3DKxz+KTjOekMOoo8Zbiioy/JOEZklZ9cUmqJYuHrqyh4UYjXDxb/ueVUvZvYYz2Z4RA7ovfhPgHVKc9ZzBrpNB9v5nNYIHyqK85/1fFuEVeGniiMn+m9dk87qdZS20MadZ/HhmvoJeabTxunH1ZpJ16XEm61jvPJrzAP7H7bRNGKuEAeBAsD5ZAyQNn8KUWTsvMaYhCsW9+Wd4Kgqu3hmRiUq8pISvbyQ5Okxnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57OPaw14wSa1NMqYWRmF2XNveus8ZjoNh0aINg1+efM=;
 b=ZKGE4iIuLXzKnzyg1Vl7HI15LzgWhD88UWc5mOV36ist+Er+cufks1Wv3q2kOnJW6HYGonbTj35VcYaXk8yiOUV71MA3uc87+iCGShAwA/COV7xNdIgBNNXc8xko+3GmXseOaU2xFDdSXqGSi6QujPLUwyLj7m27pK8UMeyjN/F7tm7jmSJ6+a1CGHieiRzjZqS9QcWczXIR96sUHeVrn6jjxM2k0W8EUfTipo8N6X/8auvdgMj6bhyW0m2yutitBQsr6ilqc74YtllvxwTivZckbZwvyKzVaaXFJffiOPvWfIv/Ffjvt9iSwr/mlIdf1rI2I6kbaKIat5mjfPIZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57OPaw14wSa1NMqYWRmF2XNveus8ZjoNh0aINg1+efM=;
 b=iHZiJYBi4jY6Ux0eyeiThv1MQ7rND9pvpKyxQ5XAwWO2szD2vli8K2Th0MqtYwA7Wt8MyZMuy3yV8tpiABaSsX6wveNgE5QYFf2XwDzErOZKr6w4lJWt/BGxi20sqrzSR3c3ub1xruWr80mtLAo5v/+6wMLxx5VLQ9YimM2MuNo=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 5 Aug
 2021 08:37:37 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::59af:41e:7d7a:6337]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::59af:41e:7d7a:6337%7]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 08:37:37 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Nieto, David M" <David.Nieto@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Topic: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Thread-Index: AQHXiQVtqMtFeiZkZ0CLdp1Q+4JgEKti/X8AgAF3mYCAACLuwA==
Date: Thu, 5 Aug 2021 08:37:37 +0000
Message-ID: <PH0PR12MB541795647A69D43684BD2CFF8FF29@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210804075024.9407-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-05T06:31:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6fff13d8-1b1d-48fe-a29d-d2c9d9653d2a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28ef9e88-aae7-4696-2321-08d957ec477d
x-ms-traffictypediagnostic: PH0PR12MB5484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB548469F04F9B718A0A6E75D18FF29@PH0PR12MB5484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AV0gU1StE7p4O/wwVYAt6XGGp5vHlVQPfQLFRWuKd1XQEo7E//4aPQX3pa9XerpbnD2Br6v+Ymh6Qh8jXybsDij9bCJnlFWpzOVUhsLJsoTA1UTcTrpNpbLHaH62e7Vn6IVW6QGLTv9dWSfQq3KyBc1iwxSDGZKwUETI8Vfq83tKXbej8K2GGcsxIVkCw/aGwke2YzfG+sTYwpfNGjoJ738kR7q8R60FVXHKFN8kFtkgCWICu4vnN0KxW/SUOvE+plk+G/aHf7UInNz2+t5lfk8vYj9wor8Nua0CIAuoKlC3VsNdz+tqe1g/D3LLY3C9koFDq6P7mydOEGg15Wx5a9f6tefWbSsIQ7h63ty2AyrIgsJUbq7Fl2QISvq7DZCzQAM/SMF5nD6PMaZWD+ix9eotoRVMNBR/JwfncTFslHELTXlXdoJ9mH95L7wSmuZWk0e7b2PiU6eezhXIFa4T7NqNqkaWWe11UIusa3SmfpzQiiuwSbCe5MaQhiWVwVUfPiLkGEzHiagD5ajPc/2LexRKIdm2Yo6xZNOdhkqn/jpQRkbZ4YXP+xF1AylmvUEdFtDdmmOKne4TCDnrXAqP8drcV5paPI+R0i0apIaCTQ7k3FHVplpO26q67FZYZA3QrdVNv7qsxffXnln+/juBlrDEjTH1TdEg/jWm8xBnTKBSztxs8gQjBZML/bF+d9x0KcGp5SVkxxxm5nboDoNIfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(8676002)(4326008)(6506007)(71200400001)(9686003)(7696005)(83380400001)(110136005)(478600001)(54906003)(86362001)(55016002)(2906002)(38100700002)(186003)(33656002)(76116006)(8936002)(66556008)(316002)(38070700005)(66946007)(66476007)(64756008)(122000001)(5660300002)(66446008)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+fd407CDPLep99Xi8xKlk9r5nKRl1A0Gfi/ZvwgvBm8bugBwo9uT2eWb5L46?=
 =?us-ascii?Q?7fgv71kDzuCCBtKqqohX+ewckAD8eCzrqLeDD9taAQvVuRVZ6l4IY6h3pMwU?=
 =?us-ascii?Q?DsAcls0SEo99W+Ib24hv2gKZbWTAeIZwRLl2mYB0r43zMZ6cLhPwofVQBsog?=
 =?us-ascii?Q?WJKXCB/Ad9N3NhaYgWZoGeFPDpUVQIxHPJNYTHfkhGoBE+F4eiDSXSfNrYMA?=
 =?us-ascii?Q?CT9nWTjRkI42NMoo+Nvnp23tIMHjr9LOkgeAMjZOz1Igva/14m7SPPF/uqKr?=
 =?us-ascii?Q?sgDIuC0znljG/90obr9mD9tcolQ4dG4InNiUcnqZqIcoubuyP7CJNxh6HsL4?=
 =?us-ascii?Q?vIQI0bEB/vNnzWj4Od0hwyNs4R87KrM/PGTRQTzUhfBYHrJPfWAhnaUc70cw?=
 =?us-ascii?Q?wmky02TrPwiE2HCnNaXsRLIeqCVPvA8o0ZR86Kvq7joTQUY8y5gqG5eqnpWO?=
 =?us-ascii?Q?o8ZL1s05v08YLsF8QcLugmhkx6MCYetX5T7U1c/GW0U6x6kvDv4zLM7CgyDt?=
 =?us-ascii?Q?3K75X905KrnnhO8Ha8D1SSJ4fTWee2acfHPjay8HngnpSAh3lKdJBkYbJ7c3?=
 =?us-ascii?Q?KzIR99hSOvVavJ6o2Kt4dT5vHiascu9Lca3STkTJpaFW2+5ipNPxy9TcuBOe?=
 =?us-ascii?Q?dlVV+mqc6UMfGqt2SITjjPQS39OYHMDVUnzcS9imisg3uHtgILSaplEdd/sB?=
 =?us-ascii?Q?2cThTdvgitoOAOIWRvtPaKDd2DqFuHoAKs64jhPzq8sO6Gs/nI85CFG9jaKx?=
 =?us-ascii?Q?mSQng3KS/F2XLP17KWagsbFw8EgaRBidubwCXQSf4Pd1CLhr/0oVg9DQjixH?=
 =?us-ascii?Q?NpU8oRY3xUjwsGD7G6sS4Lzu1p3L3PCqr/h92d1mBqvTiaHSjM7JEQ66T61s?=
 =?us-ascii?Q?/KpKrcV7Z4gG18CEe7NrF7UlrcL7ZE629C8J1iaeIjfPfB1Yc0F44IPlhyjT?=
 =?us-ascii?Q?Jt8tb389jhgkFGWJiW0UuMPl9xeZM15kUMdnlwKsIqYJWBgcDZYmnq2Zad02?=
 =?us-ascii?Q?9Dtrx+vb4wqUEA+A7KTAPjYHc5GmXne51VECMx7y4V3bJjtrNY4gYCsMhAQV?=
 =?us-ascii?Q?uv4F11uPMvF51wNS7F8MIy5fIT/rqvH7m4ySVir/fuLKwBq2ffTOY8ZJVcbf?=
 =?us-ascii?Q?PXNoQvNm6MdAuD6CFBa4Flwt2SH0MPxNGEb2aiXS5+VWNAF3F3+9XnSDQxB/?=
 =?us-ascii?Q?cI/tDDa5+h24B3KX17YeORXWG4GnP/rVxBdD/RHYMyYcykW0ihkyzpZ4/KJy?=
 =?us-ascii?Q?3Zyt4SHWxD7zK+JHU3zCs5zc3+rxgCBBRH3+/RjmcTdjNn/Xel64T4H37PlV?=
 =?us-ascii?Q?oXHdrfVSRzbj1VieSuuvU5dN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ef9e88-aae7-4696-2321-08d957ec477d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 08:37:37.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpHnvPTXiHDBDyZeQfbQJKv9945t7x+jDp/VCy0ryA+LWhQvg6NnBp+s70gJhcTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
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

Acked-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Sent: Thursday, August 5, 2021 2:32 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily
><Emily.Deng@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF
>mode
>
>[AMD Official Use Only]
>
>Ping.
>
>-----Original Message-----
>From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Sent: Wednesday, August 4, 2021 4:08 PM
>To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily
><Emily.Deng@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF
>mode
>
>[AMD Official Use Only]
>
>Add Alex.
>
>-----Original Message-----
>From: Jiawei Gu <Jiawei.Gu@amd.com>
>Sent: Wednesday, August 4, 2021 3:50 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily
><Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>Subject: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF
>mode
>
>Enable pp_num_states, pp_cur_state, pp_force_state, pp_table sysfs under
>SRIOV 1-VF scenario.
>
>Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>---
> drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>index 769f58d5ae1a..04c7d82f8b89 100644
>--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>@@ -2005,10 +2005,10 @@ static int ss_bias_attr_update(struct
>amdgpu_device *adev, struct amdgpu_device_  static struct
>amdgpu_device_attr amdgpu_device_attrs[] =3D {
> 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,
>		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>-	AMDGPU_DEVICE_ATTR_RO(pp_num_states,
>	ATTR_FLAG_BASIC),
>-	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,
>	ATTR_FLAG_BASIC),
>-	AMDGPU_DEVICE_ATTR_RW(pp_force_state,
>	ATTR_FLAG_BASIC),
>-	AMDGPU_DEVICE_ATTR_RW(pp_table,
>		ATTR_FLAG_BASIC),
>+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>+	AMDGPU_DEVICE_ATTR_RW(pp_table,
>		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,
>	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>--
>2.17.1
