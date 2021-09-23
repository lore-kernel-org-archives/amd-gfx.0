Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F98C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A941261216
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A941261216
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461B96E077;
	Thu, 23 Sep 2021 12:25:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2796E077
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 12:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQdDSYlpUc4u+rafboRLZ3YpJ+I/Pc5JY7JnhsMysdsiJMxUQvBTXr3LtAPi/e1pANnP8quq22qyHxOO1zs/jbHR4f8vdABcdTizy37ZF79j/6NgogsG3IIY/y1/0YC0NPpSLOmJtMCc8izjPoiTl40iztyRVort8MIH/+402c2Y1sBG51rD2Ahn7IDWyP81kdlxPujZGi7SPooLlyaJLlcFo9D7fV5IYU7wI9UaSRoQ+CgxHbB9ptWSTEXXW0ZBB0buyrN1hXCns8bamcTH5UJntxPKNvpyYy2w8aOXfG2xNxs43DWJ9kt9zZ9efsQhWaCfV7vfkpIcQhe/kjFlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CJSjs8mqO8Rpa6YWx+oQmnSwe7s6gloN08ujV5SRZGY=;
 b=PTtkmViNqlL0hwgIsg7FZLZUW4bdF54WqMqfRl7eWVbZpZIBSrnsLzfiZ5boBMB6zJ4OjznrR+CBpAM8In6vtCgbND5RYIgkqt7hiNIIu61ahodm2mj1r1YCAhb65cmeeam930dfXkoVAoCT+Hd81TsQdlU+NimPIJzwCGNGviam82icfpJIbevyQ/hxIozYb2jGNd8D8LQgSWOpGOgXhozKV6EXdtWDFC1RUtEEzCgP5y0C7O0zvvjmhSbROxEzr33aQevhHD8CgRpS/OMuP9nJKyQIxfhS70Qnbn2QLCe+DHS/50Jo3tEpDBdv00O41zTN6SX+E9B1pdt+ANKl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJSjs8mqO8Rpa6YWx+oQmnSwe7s6gloN08ujV5SRZGY=;
 b=mqjvrSyA7nX+BQBy2wAfKCsMrxlbGsZl6ZzciAmz4Ithhho8zLstIu6nE2ruBAkZrYHaEMtn4hRO6FrJGdVJdhbxOyTb6moEZ+D1WR5IJhl/7LgqWCHSFhAyoARa0QT2OuFiXJLtbDS7CDqFlvyrOkAMd/4PhFTCP0UXlc56eoY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 12:25:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:25:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Update intermediate power state for SI
Thread-Topic: [PATCH] drm/amd/pm: Update intermediate power state for SI
Thread-Index: AQHXsDOr4JhBPAudZkG7Ie9lMNCuH6uxi9Xw
Date: Thu, 23 Sep 2021 12:25:53 +0000
Message-ID: <BN9PR12MB52576468A9D0639B1EEF1456FCA39@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210923042937.16385-1-lijo.lazar@amd.com>
In-Reply-To: <20210923042937.16385-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T12:25:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d323f42a-db72-4cbc-b071-d3ff1f24325c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 958dcfda-c884-4bdf-9057-08d97e8d49a0
x-ms-traffictypediagnostic: BN9PR12MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB520965DEC5624DFE90A471D3FCA39@BN9PR12MB5209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HU0bae+WDcmRHuqh3wkRJnpzsKH0S1SwwiSlyRoWf6DOdN+uSDfNavnkAs1WnBpkGF640FRSmexeJOxsa4LKuILLehNXn6GDYuwSlcCEyQVHGJt04Yetr3c66Q9heK82NMUCJ/OcLQhPac1IsyjmHDMmOfwIbuNr2aQmKJU05JWmdSZvLMbOTb+ub69fW/1KRmmwQDG3DqHm40D/99GA+161gyF1/Bg+UPRkmIY/Cdo341/pTT7x1GT7qxyTLxrPlpOk0dvSp24BPKDevkp3IhVjLh7d0JNhYnfgkobsDJVLIBjgz78mMzCSC7BIe6aM3rHkpt3PLoyUcBGzu17puDBzOuXEFU8IdaGajbHckcLS1D8VPw+VxvDDzltVPE+iU+3BGW/dPgYW0WArVW8YFB0IMDQUTuFTgq+8IcrcEmuiGnwKDR2UZRjVpqkAjLMdnMC7b0tVan5vdxhj7en4H2yYuGXoFk44Cmqjggqy6sHyZSYe9gpIU/ijxAgcZZsovgItlhg5VDBhud9nqOf2YeSnUg8m29cFE1UFAcNfcr3ydGirAUGdIFu59kYSQJaxNHAGmzz9mh3C8ChoESs3dW8KdD+3fyrhFXg3yikEEONcS/AdhROS5CeeTFnyRcVT4hYAOuND77iMExQ2G/QH0ai5qbv04Xbd23o0Ew+B7A/te2ySHWZFgqmoJ8OwiAp7DF5kHdz2iPGhp3+jWTmY7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(2906002)(8936002)(76116006)(110136005)(55016002)(83380400001)(4326008)(66476007)(66446008)(9686003)(66946007)(122000001)(64756008)(71200400001)(38100700002)(5660300002)(52536014)(66556008)(316002)(8676002)(33656002)(53546011)(508600001)(38070700005)(15650500001)(7696005)(26005)(186003)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rz7S6zYQ5wka3vnU+loEQAm+niGmXHPQr7yUuxHnUjlAfFRkq61PxMyTUGeL?=
 =?us-ascii?Q?SGPKk9tyQdaNcPO19l7hBfODRRfVK4Y2+W9Xt5/JsLlJwaxSoJEdaHc9hvT+?=
 =?us-ascii?Q?l365Fpz/GP9oGo54YGL89tw6GZ0yhVpszbX7vCx1TN5X/CxIpt5qZic+DkZ5?=
 =?us-ascii?Q?TRBXNBX7andfmD67Cddyg37YmcH/NUujnpWQM9kq40h5y0u+2smtQ6+rd9tW?=
 =?us-ascii?Q?pxdyjeX/Sh7d3a8Fl0kfGmgSvYoB95J7BbGzchZaK9Tr79LElY5rJ9ASuncP?=
 =?us-ascii?Q?A5xrb28/o5LZhfI6WRLfF1qrAp3KiNEV2on+twG00Ebc4p9D+s2V5hKIhnTx?=
 =?us-ascii?Q?keLnJHTwopAvXb7w33iMcmX1HRENEMHE040ux32mhLtRHvsN3OhaZm6bS57P?=
 =?us-ascii?Q?UtQ5/vYL7kLqkUoCHFDsv6mGYCXvxEGWTPpXxeaKUaxtZmCJ/VDo0iaxDEUU?=
 =?us-ascii?Q?SKENy8MyDhLpvZ85Q973hKYcDfY7nwAl7SkRB5BFzUleVJ2228iwCQ0V9oFr?=
 =?us-ascii?Q?LUHFHLHkl454XvaMZNfClZV0eEnMVLzBceektlMG2VUELWkBKiZKYgAhrU22?=
 =?us-ascii?Q?spwlW+MQEGMjOTeXys3s//5nislfpsA1lfH7v+ce5zT32vpNHyo9qYvQnTVA?=
 =?us-ascii?Q?jYjsAahPeAI5R3J4F0ZDb5T5aF4Wzj4LgqAS/koWAYF+oCbldMRvk7WyoMCY?=
 =?us-ascii?Q?Lelf6ZK+66H9T/JnWq4/XAG5FyPb4L0ERKacIeMt8/EA88FTMMRHEjXar049?=
 =?us-ascii?Q?OfN0hiseZ6CyEyt34fUQh8uboHx1xrPpkiYZbwqfdN8a+kFw7pJgyVVgyVLs?=
 =?us-ascii?Q?DOHw6pIASKwJuQK57QeahJAF6OOPTPIPVpoVQqjTnhU3p/9GO1pN4q1GtTo0?=
 =?us-ascii?Q?VLPAaZTP4QnFI64ccVxltgpbnamtVlYkkvQeld3zyWIqzpyyADj4+W5lPzsm?=
 =?us-ascii?Q?R6RtwOWBgyxlJXFmfs/Tc2aOOTcyY6cv4moTUdLkD0dMCDsBDekgdIsZTXq3?=
 =?us-ascii?Q?shPPPdo4666tNmnpKGLFHg/OqkzoJLR6OcL3Jtrcj7YiMdlikdKNGbHHGEkv?=
 =?us-ascii?Q?1jznNYEbMq6i8eibf1rbZSQCJ6HxlHaAJJvH/Lp08iZK5IvuvQGYHGsWrm84?=
 =?us-ascii?Q?qejQAX1lYm0+mKy8IV5lHnaPDbCrJ/0xcyeP/v9o7Kixm4RiODa6HpY8QYRW?=
 =?us-ascii?Q?PTNsq85tKGm9ggNG7FrJxt+GEef/AAcLhqavfooSZvYZ0VHSOkQYblkA9O3C?=
 =?us-ascii?Q?h+YqsQXpbjxiQSftJNWTPUCxGAjOrHhO08uu5BGV0LHlUKiFxyYEvAKpNIKY?=
 =?us-ascii?Q?CPNeHdDl7uo/G1wQVnn83Dtz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958dcfda-c884-4bdf-9057-08d97e8d49a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 12:25:53.7864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEOaQmbdDt8ED/lWiEhn2gC7CG+oVSKATib5VV1Sv1DHcJypLG3yUzw5Puiz9Kk5r1+/IXJaHo0F4EK2AQ9IWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Thursday, September 23, 2021 12:30
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth =
<Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Update intermediate power state for SI

Update the current state as boot state during dpm initialization.
During the subsequent initialization, set_power_state gets called to transi=
tion to the final power state. set_power_state refers to values from the cu=
rrent state and without current state populated, it could result in NULL po=
inter dereference.

Bug:https://gitlab.freedesktop.org/drm/amd/-/issues/1698

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/am=
d/pm/powerplay/si_dpm.c
index bdbbeb959c68..81f82aa05ec2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6867,6 +6867,8 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL=
, true);
 	si_thermal_start_thermal_controller(adev);
=20
+	ni_update_current_ps(adev, boot_ps);
+
 	return 0;
 }
=20
--
2.17.1
