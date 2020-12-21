Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 09:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E15C22C7E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 09:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E15C22C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB026E46B;
	Mon, 21 Dec 2020 09:09:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E766E46B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 09:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3oA8Haz/R9B3KLQmeU/0jbJiUhLz0cyW+094l39zPjdhKtbjdEYLTaJCgyrvY3cxua2JPcVdgZJLwhhM8byNloa9sv8O+imSjvfk7O4bywowy18wzm0zLG8+716rWXeSPouoPPN7VhkBAILe5eBB4gujJFdjlDgZS4k2JIg7purPb2ad3OYd7g45cPquN0Yb5pSwlbrhswzkYdRx1IFF3GSeMeb0wUQnna6M5jTySyd+0Cb9dX4YkK7AKxA8LRcgIdVN+YIg32hOhXPSiyMWSpXUMWP4dZFAokdp1xcBYL8jAirvgvDBjuVSVXBpZIkjWlR+iaYjMfqWkutRPDUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd2AE8X3dmTIuvzJ1+wfqGMhYm05gqbqTUtj54FlI3w=;
 b=ZrUktRFm24DoGAfhMgVybIK5oRgTWoRUdZrSPStkt+nEJw/2Rkg2cGiSutOL5ePz8TIKam81r+c749WUJXnrjZIrXQOwKc1eQ+hNkvpE+YQnG/hbL/YM3XbJCOlgc4lp3TQ+NQWsSy1xg/2VWlakaWhskVAoUE2cMTWbYHzT3t07HN4c0ivpxs/PwrXhPZKT2QIMGUb4MrsiI4Sexmq2o0NcoTgMHr+JRBqpq+vTv1GRIpPraln5kLS4akJd/6kaUX+VHkz6142BJvLt5kCLpgovbVQ7svvlSGyCcIahKte1jC7CuVnRqHAm1oRXcAqF3WXU76QgvZ4qGLO9qhaIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd2AE8X3dmTIuvzJ1+wfqGMhYm05gqbqTUtj54FlI3w=;
 b=u69GoKicdX5YvMN9t6nenUmu0N5JnzQC75hHs3TaQ5/EDCuE5MxmjaPj7r9cQvHd45AsOt5lZ4wCL11d0S/DPZ5Y2wJoF2R0NcI2grx2meoS4hHCK5I9lJk+UHmCVMPxY52gKsQfx4vH6SfA6l9kG5Qyzw6/tOQe4ys+jUOBCDA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 09:09:21 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3676.029; Mon, 21 Dec 2020
 09:09:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Thread-Topic: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Thread-Index: AQHW1Ph9qopuEbobbEGYyWug1AMUC6oBR/KQ
Date: Mon, 21 Dec 2020 09:09:20 +0000
Message-ID: <DM6PR12MB2619401D9555CBE9933D9816E4C00@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201218044411.109708-1-evan.quan@amd.com>
In-Reply-To: <20201218044411.109708-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e8b0e18c-2a35-4729-88f4-77016d3b7a3e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-21T09:09:10Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3573782b-77bd-4b62-997f-08d8a5901a7d
x-ms-traffictypediagnostic: DM6PR12MB3369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3369D3ED547341E7494E375EE4C00@DM6PR12MB3369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTTfyVpCZyuchNvLmDAxCeSgvFe1bpcy8x8Dela5Mq3MgG4BLJkVBDc6JPaYzFCkQm4nH+Nrq6pXxu9Qr0q+defZBdxSq2WS0JoZ6kYcmPkHSgL1vSVOXhSOqjuanaUGVPdvOGhA0fpn3XD9JJE75gTCKjEX/7EIqHh4rsi9dxRBmgUoUZA21A52hPpagWhesNgF5Wct6F+hicQDVQo6U7N+C3MqBut6OWdcTifcBlZp6m1ELGnWLSmlIvYgRDAJoCbXIbgEwmwUJaK3BuV4C2cKMpkYEGOU5JumBw42QhhxZxQvfEW6/L9jW62Og9vcPL1DiPxAGNus7Tpl4pzzJEOV8LnTXuR3ksATwzy3nzNkz7fRIaEw2W2n8ojwPJDSphG1k91QkLxhMCy2ZGJNsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66476007)(186003)(64756008)(66446008)(4326008)(83380400001)(66556008)(66946007)(26005)(76116006)(5660300002)(52536014)(71200400001)(6916009)(9686003)(55016002)(316002)(478600001)(8936002)(53546011)(6506007)(33656002)(86362001)(7696005)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wr838E7vdaCXdoD+x1Amw/JNoj02V5oOMpf0RsDEa6iYmHMhHq7PHRj+DI9o?=
 =?us-ascii?Q?S0BHN+vstIK8i1Zdoj3nPPrRsHtk2xLYywAFfYSG4vSelP345j5Oj8mEVzFj?=
 =?us-ascii?Q?gYZVgNSV3+L12REvqGmzuET0tt8vZwfAqsWAXL6Ng1ZgJT/gU8j6LBIS6XwY?=
 =?us-ascii?Q?/nIReaJgLQlA6gVuMVdEC61EdzHj65a3BtSCdK0hj8b/nIe7FhPO8iTVIGDn?=
 =?us-ascii?Q?dH08E2cxY4WD4P1YFc0IRXILXGOmaDm7/LMQJRZ9H5pQYj7C2iLCZoLOgWqK?=
 =?us-ascii?Q?0PSXj+BFtPLPIdWT+o8JR2u0sCIzbibNd2PlzKo1T2ZITpY2IY5a96/qZK/X?=
 =?us-ascii?Q?J7/pzAN+GU4ZvMxXY/VqObFdHdfKMlNWzQDLRvEWnsRTxf0V0VoL8z+EWoB/?=
 =?us-ascii?Q?9Etj661pm/T6Jy1YNs0uWI56Pl1ZbPKRm4GI01Ea0u3eNuH1bJC/ffPDLkaL?=
 =?us-ascii?Q?lHswPP74ltvGL5S96s2ocG9meg4TwBdvKcgOMlJQTm1hXaHwnjgfQqTUxk3Y?=
 =?us-ascii?Q?sWyANLNH3d8CXmFJy9KGZrsKbxq+e2rlrz9RDAGrzwgtP0iVvEGx7vIrDTtG?=
 =?us-ascii?Q?9PImnUOPC8X0QHIFOfD4Ghg8kpRth7fbTn026KNhLs+e9JLvWzwAV+obgwv+?=
 =?us-ascii?Q?yhYzrP+StfqZRxQ8nzCiNyCIUpoVDI3CI6MJqt/wex7KihCDGBZnmbJktkVo?=
 =?us-ascii?Q?bYVVpBLJTKrXTsvfQWVgTNgJjIbbxnbxfUpdPRmEb9DgVv05sLCtUtHCJks/?=
 =?us-ascii?Q?Weo2fS1LUruay6iLc7/QVilAoxt7P+hHv/kXgvxtI83uGQTd98V0xNEFhEA3?=
 =?us-ascii?Q?IUQu2MV5QNREpn43t8ne75VjD4Qm5WIIetH9WrmEad9n0FIx5pi1lycMnRsa?=
 =?us-ascii?Q?lKS597yEVFOwHBLs6xJ5/9mHU4RazrWtVYdj2nDGgInl/1ZP4pDYFSM+rLK1?=
 =?us-ascii?Q?Z6EXU8pZasFDKvU1Ioesi5u19eYGtAZ9tmRkZ6bWLFQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3573782b-77bd-4b62-997f-08d8a5901a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 09:09:21.0488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3KHd8YWT0pv4xEQNWWu03ftJwCLymeIc6Dv7M6tugVKG+ldoN5DdH88sb/hJU8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping..

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, December 18, 2020 12:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to match latest pmfw

This can suppress the annoying but unharmful prompts.

Change-Id: I50bc5f9bd21572f51af4ff4c9e1946d1a441b714
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index e5aa0725147c..13de692a4213 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
