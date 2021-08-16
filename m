Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA3C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 14:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929986056B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 14:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 929986056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76A189A94;
	Mon, 16 Aug 2021 14:49:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248F689A94
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 14:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic/rCidjOqofFxqq0nodb22DO9gQX9OzfPrU19DBvIdZQ2BCkMTep6Bn2SGzpMMxqNIm1eGbFUjK+OKfQNlrU4v6+Q/wa4GmWriqVE2Y/3T90/C143HNl8g88n0zd4b5jX9MrRz1hU8t599yUhmC3uHN2ZoNa0F9XbCI5UL92hv4CzJxyedAxIZUEmRLbAe16+5k5VxJJ6lHqtMumSHCkdRbQ8xB8R0FdOBK+Qie0qunU8YOnsDeodLQPX2h6OqFYJsLmeikt1kIcigfP+IkOwyq9vlmTUwHJ7TgANphlcnVV8UyOJ7xUDOXeQd87dcD5l8gvzPJNnIJBB6Z8aGmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66DjaREjGAQZlTn/pIJAYUewjNxpSsF0yaNC5OtB57o=;
 b=blVXISTN2M5RlJxqqhXK2ErjI/xoyjjxBzK1g1DzAGAeQupN6toukAE8aw+NGQD7BS3gumFAHz0JLDJ6atZxsmj9sg2cnoIgmm+VhKO/yzkFvLMB/QW5P52Jf2DA5xNOlHA33JOnvO5WYYYz/gE3PWKj0mx5QGfc+96ISlE8OqXmb8F0xwqeqMazioSuZvJKx/E3IYA2MK/hpLzN6GHcUOBgP+QJOa8Bh1TW7J+Uvz+kq+TfWe82QGFu2RxFcsRaMi/oeidDKPoJS++IdKczz1V64ekvXef7+I+DcdEh6ao9JsgSk/CLJ8KprRNzpxbHg9eSNNL3LgCa5AxyvZV0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66DjaREjGAQZlTn/pIJAYUewjNxpSsF0yaNC5OtB57o=;
 b=0aByc7+zOZgBtiKLUxOwIrOFX7Qr8rXtqb3WxY1w7qqOfwTl+XI0YkW+s4o0Dw53/mAkUQXWI5jPyw8obGFsACyx5c9z2QHq/mJujEk6Nrk+gshiB+GtP9jdc1R1CJsFF+tRiM0fxtIPR3dGnSG+HIMJaUIMsojaAvKxE7uF8pM=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Mon, 16 Aug 2021 14:49:23 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::5d37:b014:de9c:344a]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::5d37:b014:de9c:344a%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:49:23 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct MMSCH version
Thread-Topic: [PATCH] drm/amdgpu: correct MMSCH version
Thread-Index: AQHXj4vTSNWFV42npUyDocFinAH9dqt2O5Rg
Date: Mon, 16 Aug 2021 14:49:23 +0000
Message-ID: <DM6PR12MB55344C769CBA7414D8637777F4FD9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210812150718.8827-1-zhigang.luo@amd.com>
In-Reply-To: <20210812150718.8827-1-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-16T14:49:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8531ada9-b1bb-46fd-b72c-42cadeeb6e4f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1c4aaa-9139-47e0-8b30-08d960c509b1
x-ms-traffictypediagnostic: DM4PR12MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5325AD523A660F6AB4E1A00CF4FD9@DM4PR12MB5325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KaHWv7Bi2atCR4HY/fwEL1rtHouXSghnbEg8C/jfnzu1LJqzoeX9OaMB12ihIu0yOuuwyooID6MM3G5hI5NFa1ZIWJfjuTFjgt8mrMXdgiZJ9ncIi7Rl1apiJaZjKz+ycRnbd5fVzdgfabi7ypSWVeeZaoEh00lxd1v2VkZkzHCyynzflwkf76NREc9ayrpfLiE3PnE1VcCfjQ1GULnJA4bePnUUwo6KVDasrUItOeA5M61WcRN9qTUnoNC+++KYqJBWpo+axoGMcovuvrT7KHJUbetPT/FEYH38sBHBCIOgJfogUKeDs21Ptgf93DpOCiGivohU+MgbEmh2Uc8IGWyHl7E84+Y8cDrN9Pgy3+o8P8M/mp1Qq3oQQu0D5cOUanGhTlvj6TKCd8wzzqjsR18EiZGqkCUL9uIpd4Wi5Jgcg4UpYgHj+yAaRIP+ejURqLlUwP3u7cAhziS/S9ifTCiDIOnn9MyXQ8cKkHj3/p9zTpm+s0xF3YuGqIJ9BRIsxThp6wTiROIRHciBBWhL3Q/HpaBkmPsD67ZlEFj4sYk9swTMH4q6Hq2KgwfIq4TauSWyDU0V3Vi65gW2pVAdPzPi7FG5wwOvkggnTceyrvg4mDv4jKUvt4Okpm+FBeQrLtRph8S5HIAdwxu0oL/MSDVrtE9OYMzztLaxWhfK6EAfYXuy4cMW4frlXjTlwmyg1k/msV1DBg0CxgFpxlJww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(110136005)(26005)(66556008)(66476007)(33656002)(9686003)(2906002)(64756008)(186003)(66446008)(71200400001)(38100700002)(8676002)(66946007)(8936002)(76116006)(55016002)(478600001)(86362001)(6506007)(53546011)(83380400001)(5660300002)(122000001)(316002)(52536014)(38070700005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zA3kVoRoVkxpSU8+s5u9FtKxqZOfxgVW13AoTuPFRGZTmHAS73T9kr523Yq4?=
 =?us-ascii?Q?p1XiyJz/gXkzT1FFICn9k7kMp32PapqwUBDqYhKwg2vrEE4JYOgUvMuZUgY0?=
 =?us-ascii?Q?8aQD6N52YmLrktpwbJGgDc8o0TABP1VkFFyFu8bxcti31i4JJjWWOXnPHSI7?=
 =?us-ascii?Q?KCMer+gnKfeyRSEUbT/NnUNP3K73/Fzw6vm3N2xo8P6pm0XQbPV6BnNnnT2J?=
 =?us-ascii?Q?2nWANGU/UbuLFAiIPB4nboWIIUw+6i65mWAeU3dxCuDIJ/jr8rOL8P0msoe7?=
 =?us-ascii?Q?B0c7sjI3qCxo0o1XRPhPuIQvTs3KeG7OiSHsl+GFP7k9LCKw7mnAXmTPLaqT?=
 =?us-ascii?Q?zCKSmMIl8ZDt/QYVsYmcKFhUKxPSv5H/3IO0vtxzVuw+hL5WP8IM3kTZ8n8t?=
 =?us-ascii?Q?BhaxRdhVgdxL5dA2a+pZ8cEy7Z0uAgVMGFAXNmBLZTuX5pDDiBznMj9vb23x?=
 =?us-ascii?Q?axaNpeM3fWwz5RJgfzI9Fi+i47jZPPu1XcV2t6VCWuntYAZHTCjA6BUPzQ/V?=
 =?us-ascii?Q?aqvru3ITng8ZoGCgy2JNfmx1tmEK5sj4iDCXm6oJfvPe/wXXDiFXYcuVnCj9?=
 =?us-ascii?Q?QbqdWFi+LItclr9ao5XUQORIzjcJkVDyjFBMJArcOeslDoJinPvt7Lf52tDU?=
 =?us-ascii?Q?4DPOu5A76Nwo5rHfvfEa2cmhaoXkippra9/DTgHkmE+HNNkoVEqHugqhyQKi?=
 =?us-ascii?Q?5P3tVdjaKRXn18AdmqeTkeI9iyphmOQOqfVChRvdy0JQaI46X6sBvyisEhoD?=
 =?us-ascii?Q?DbPCUCOzEuSMFi/G3USYYQmFLAfIGxrSGBtAc2VESjhaumV95KIEgmetdLb+?=
 =?us-ascii?Q?8OZz4zb8Z0Doh94koTBg1aGWl+YzUjUCG7WD2ESsEWGOu+0dHR9SVDEOzEXx?=
 =?us-ascii?Q?jIiEaHfXme7whnZq8F7fc5+iI42Go+7P/Hcg0jMiYAzLB2HFYvPyeSSE8AV4?=
 =?us-ascii?Q?tkBgJqieHeCH+/objh4tVYN3CSuZgG8oI7IKJM2QcEuIWnjS8nM+8IQUmszA?=
 =?us-ascii?Q?pkRYcBSv9Z95kPh5spTwQelPvtxj+nBaZvnjL6uXvfd5zVDZ3VlziLBqZBrW?=
 =?us-ascii?Q?4phJiRM+RaWfOqYHTbgFi/oDogUT8uQcNkjiXwqAFxDXn0KuzB23K2EZ88HE?=
 =?us-ascii?Q?wDK7K2MXUoSlfoWcpzISFCpaZMW/JPaybPWLORhZWGCbYZAVBl6w0XM0AWVL?=
 =?us-ascii?Q?hdc8hFbx0PSTwxz2bF1w+E4jxdp9YIsJa0ok57k4ubs0ZoF67tqkxjycKDIt?=
 =?us-ascii?Q?iNtwbn/HUs8xzs9h2zzeedgxl7uNb/+dBlv7iEaetygEqqrB82wYr+/bl/1b?=
 =?us-ascii?Q?L1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c4aaa-9139-47e0-8b30-08d960c509b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 14:49:23.5845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8cS/UCNcXyBpvJtdAtxy6opUFKg9kbeCfh2UQ6geXN6AutX7oIzWex4687F/eo05tXs5V3X92IZ8oPk8iXa+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

Is that information from MM team ?=20
Please make sure it won't break the ASICs that use the same  code path. Als=
o If this is true for all mmsch_v1.0 , you need to specify this is mmSCH v1=
.0 , since other MMSCH version will still use this major and  minor.=20

Shaoyun.liu


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang =
Luo
Sent: Thursday, August 12, 2021 11:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: correct MMSCH version

MMSCH doesn't have major/minor version, only verison.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h b/drivers/gpu/drm/amd/=
amdgpu/mmsch_v1_0.h
index 20958639b601..2cdab8062c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
@@ -24,9 +24,7 @@
 #ifndef __MMSCH_V1_0_H__
 #define __MMSCH_V1_0_H__
=20
-#define MMSCH_VERSION_MAJOR	1
-#define MMSCH_VERSION_MINOR	0
-#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+#define MMSCH_VERSION	0x1
=20
 enum mmsch_v1_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
--=20
2.17.1
