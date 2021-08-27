Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D245AC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 02:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9F860FF2
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 02:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E9F860FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293086E048;
	Fri, 27 Aug 2021 02:43:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E426E048
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 02:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBW5aaejbpVCopjvykXG5vxwah2b19RmTkLTSAOWjmAbN+L9LeH2i+Im0p3WgMYhhmg+E22TwLWLQIh/qgnya9c3+BuFpR1EqODvs0Zux/2nuEewUHiEDqRF6GmGrYqEe7H5oovYaheuNwwJFjQGfKb7KmM4b5/PJSlazwOvQtu+60uweBYBMFz9CLucjqoFqbfIwYnoaVwesMfESHkOonqzx7zOemLfkMONcntUTZlDCJjmhpoE7+Nl9ey/HnoVTWKvuIAN+lyDjfO/HyMUTjlb2p5Ci7JyuIH8joM6bVzKwUVAtGrxn+WzdQXtDH9cvUCqEQOcQw3V/3xU8+vQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUK19cyxilFloRYnfGNHJeY5NCL9OJbFYYe3Rt4J194=;
 b=EJpKq6MvNZKZg0lljn8w50lrZOCdOZOIMezdzWaWqdnaQfB5GWuUtwcTdwcFpYJZVdoX3z13idE4avS33INVL/7845tK2RCTvZ8/YPToK/ro2aaABB9Uzpzw98qjj+1nOYCFFu6Wl3l6ohJ5UMBRVhMhtluw/FCg9KFyeEOUQ/2fJZ7hpc2FuDn828eBTs0FpTS0d+FlEP3MlmOYt6WTHnuQlK30gK87fYxPodmtN4H1mjwKiieKhvKN9aRCLjmoB65ZXYE94fkSUc4kLyvAWV/2WG/FP6ZNpd08hLyZze74a1y46CGwE9ry3MutCcfvWNEPfkBRjcOmaMZBtR8CuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUK19cyxilFloRYnfGNHJeY5NCL9OJbFYYe3Rt4J194=;
 b=ij5seCrJTf4EDfIRkdjVkpWyS+gEtJQjwT+/8X+e5UB9LFMoXzeX5plONjBpP64CiT7M+8SI+NgdS7IAGJ2FvWo0yTCgO7M+zrTvokXhQhjfAy0n7N3Tywjl41jtN5Xg90NGwfnxtFNjqUZWmWVJGxfCaj0qh9AFHsQJqN4GzM0=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1738.namprd12.prod.outlook.com (2603:10b6:3:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 02:43:18 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8%7]) with mapi id 15.20.4436.025; Fri, 27 Aug 2021
 02:43:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add some additional RDNA2 PCI IDs
Thread-Topic: [PATCH] drm/amdgpu: add some additional RDNA2 PCI IDs
Thread-Index: AQHXmrmGy5zh0DqdV0iXujaCYk3qy6uGpPbF
Date: Fri, 27 Aug 2021 02:43:18 +0000
Message-ID: <DM6PR12MB4650E5C9DCC81B34323EF476B0C89@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210826203221.710350-1-alexander.deucher@amd.com>
In-Reply-To: <20210826203221.710350-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-27T02:43:17.737Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451c8875-e40b-4a07-02db-08d969046d62
x-ms-traffictypediagnostic: DM5PR12MB1738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17385C9662AA46BBBD76FE1EB0C89@DM5PR12MB1738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SONSxn11QDH8lKLnVDwDV8kRYs5LHHy2nP8PeM51FWn+vpPTTAbcwI0qkhAarEHh0BCUv6L+7AwC3+OGbjXJd9KGZFCKAS0usGeIQv0s4CyTpM8zfIZl0lLfU5w3B3QciqYU+G4V7ywwe5dNeDRV7bn2nWpgRejZrXQDmnCC06Yff0OUzfLt+q0YHz+0RUAlVsG/rZzAjq83e9qLbewnG/+UF8oMSIW6nXqN4+SkMnfqxYKWyD0ynQVXESjI0OK716TIvJsMz0QwIrxRjHjMlRCQhIZK3en7FTU4viHan3n33VFy9+vVXBN6dwk1MSAJ0OBpEQfftGOMeRYKOXa1AYB9UgR5DvVkPftZ5nj97VlxxwWNC20GZaxYwjXk4A8HeW+Y5qGADkFDMOS2Ro8Hn4IDt0GfQBurRufwVdHSTkgZZYnkAt7jlEFTGi3VEddHbSa95JVHHpOIhuKhnPBlKbJtF9vJk1qZcsuR+rR7zVd8jdTSwqa8w3z3XLa78mUWHqfPA28sql3BVvjAlOSaf6qUDh5DxnFv4lWau0gv08cu4OnrpZNL8gHCDCmva7vHfjpk3LUSR2L/K4nKS3JYgDEMZ+J+c7n1d+0Y1pVS47EhvlB/OcxbTOPdKWyH9QAZGDDafew73D/RnJ/PG3d1mo97ANRqFfAayOIIARm9eiJ8aQjO8zCTbSVliXxD3qvwRpmleP2tQVfCyrHlDeG3MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(2906002)(5660300002)(8676002)(110136005)(33656002)(9686003)(71200400001)(186003)(316002)(66446008)(64756008)(38070700005)(8936002)(7696005)(91956017)(478600001)(52536014)(26005)(19627405001)(53546011)(6506007)(66476007)(66556008)(76116006)(38100700002)(122000001)(55016002)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gZ/ZdlmVdSI9DNnJ1Kd5peBSnO8V3cWisxVj6WyF8TARRnfwZQjv2YZNcs4g?=
 =?us-ascii?Q?9jN2vVjfGhCmrYFY96hU3JFV661I1UckveIiGZmVfAWp14X872OhtIfn6qg6?=
 =?us-ascii?Q?KsLALhrzavPsoBAA4aNeJZMQlbl8slPtAwVChA6z6KOI1tBNxizSZzbv26GY?=
 =?us-ascii?Q?Vz+wb/3mHgere3rLbvGhBGmZFdwNpTGvv8RuLHzxchVstl8Gx8P502Nttv2q?=
 =?us-ascii?Q?t/kHD3l2DzLW74H6eIdx+RqSE4oZQXwk3/dqdJrJX1c3uj/QNaq3vg2swwd1?=
 =?us-ascii?Q?1FPf4lFu7BFozZHnuHMxB99T3umoXhb0pzEoQpX8t/3gq2/0FBAKKRyXCjqX?=
 =?us-ascii?Q?GQTa4s2NFxtOWOpbte67OcNit9yBrWWSqQmb9OYQyq9WSYixSzWVN5v1bRgy?=
 =?us-ascii?Q?13m7cQz3QayzKQSu2nF1SnIY3J4VYIgyzlQzbk64/camgOBX7gFegtePT51v?=
 =?us-ascii?Q?qvcnHYJlmlGLxV32mQiD81THccmMv9ykcueR7+Xk69YB2lrywcXwZ2Y6a6uR?=
 =?us-ascii?Q?6kgY6GEBJA0xBf1O2VrVCdNGlM0LAUVWgDUIe9c9CoxGNEa3xt0JyHhbahQc?=
 =?us-ascii?Q?LdD8cAGf/zWIni61BIKdYOyzGmNAxQiag6uOxJVgRxo0KU+luylWIThP6UZ5?=
 =?us-ascii?Q?wJOidJ8Zja2wIpRVWIZMjQ391HKRwk/zqrrxKamHV9ME9vOicS1JnskdZqdh?=
 =?us-ascii?Q?SezyOtkUcYtaCVI5+V1vbdV9Zcv16xZoA+PM5mxzGpojRbmtt2NCmMW1DjGR?=
 =?us-ascii?Q?RZSD3NQlsN6QmRKVbOIAIlpe8nkFP9pLntwvAV9zkW+6ZiJUiiBQGkzZt682?=
 =?us-ascii?Q?B4HxD2J/M/GI7Su/ZbQuTing6xWFuuH4EpzxGIhPGYBgQmkxi6Ru8JNzSQix?=
 =?us-ascii?Q?jHAps0lZg+UV/eKblK5UfeWbP860pEZcOfOIcepy585WLL4Z1/EhCrXQ8sxQ?=
 =?us-ascii?Q?rnfSiF744KRfwvIY63ZGIADbxT19rewp1UncCsNPqFrq1NsgP1pMhZc+pWrW?=
 =?us-ascii?Q?bUtoAHYxh/5P/kp9Qyx5Xaix3vf4/wIvUpXMp3wGV4LubP55hbLouW6t9lxQ?=
 =?us-ascii?Q?/iNWOYOOycTOWp2KbYCA10swMZKJAh8UsPc/OTodIcfoD6f83aU9IbFu7mX1?=
 =?us-ascii?Q?NWJ1I+NX6nuXugU2QZlf572v9F1yIbDJC3I0uGUsNsSrZdnudLqqIebBt4tQ?=
 =?us-ascii?Q?evM1SfCzl6IlMUWUH8up4BZ3I/mgFWl1hmCNgLd3sBNIfVaLP9W6VPYe+bEA?=
 =?us-ascii?Q?BB7NaEUgP4NoY2likMo5nwhkUIdYiA1ERHyrHTD77MDYuu1REjo4NY/ZY3Z4?=
 =?us-ascii?Q?oVq7TWFcNcIssHCP21fpcQeH?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4650E5C9DCC81B34323EF476B0C89DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c8875-e40b-4a07-02db-08d969046d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 02:43:18.3932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIeXn86syq6aUoRFODX4yZsSgIj2qi+5DdXiOL5Vkn24UR+z7tasRQu/n4/tRMvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
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

--_000_DM6PR12MB4650E5C9DCC81B34323EF476B0C89DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Friday, August 27, 2021 4:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add some additional RDNA2 PCI IDs

New PCI IDs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 6400259a7c4b..0bdfdfc29299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1181,7 +1181,12 @@ static const struct pci_device_id pciidlist[] =3D {
         {0x1002, 0x73A1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
         {0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
         {0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
+       {0x1002, 0x73A5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID}=
,
+       {0x1002, 0x73A8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID}=
,
+       {0x1002, 0x73A9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID}=
,
         {0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
+       {0x1002, 0x73AC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID}=
,
+       {0x1002, 0x73AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID}=
,
         {0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
         {0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
         {0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID=
},
@@ -1197,6 +1202,11 @@ static const struct pci_device_id pciidlist[] =3D {
         {0x1002, 0x73C0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER}=
,
         {0x1002, 0x73C1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER}=
,
         {0x1002, 0x73C3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER}=
,
+       {0x1002, 0x73DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+       {0x1002, 0x73DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+       {0x1002, 0x73DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+       {0x1002, 0x73DD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+       {0x1002, 0x73DE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
         {0x1002, 0x73DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER}=
,

         /* DIMGREY_CAVEFISH */
@@ -1204,6 +1214,13 @@ static const struct pci_device_id pciidlist[] =3D {
         {0x1002, 0x73E1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFI=
SH},
         {0x1002, 0x73E2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFI=
SH},
         {0x1002, 0x73E3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFI=
SH},
+       {0x1002, 0x73E8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
+       {0x1002, 0x73E9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
+       {0x1002, 0x73EA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
+       {0x1002, 0x73EB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
+       {0x1002, 0x73EC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
+       {0x1002, 0x73ED, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
+       {0x1002, 0x73EF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFIS=
H},
         {0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFI=
SH},

         /* Aldebaran */
--
2.31.1


--_000_DM6PR12MB4650E5C9DCC81B34323EF476B0C89DM6PR12MB4650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family:Calibri,sans-serif;background-color:white;margin=
:0">Reviewed-by: Tao Zhou &lt;</span><a href=3D"mailto:tao.zhou1@amd.com" t=
arget=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable" st=
yle=3D"font-family:Calibri,sans-serif;background-color:white;margin:0" data=
-linkindex=3D"0">tao.zhou1@amd.com</a><span style=3D"font-family:Calibri,sa=
ns-serif;background-color:white;margin:0">&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Friday, August 27, 2021 4:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add some additional RDNA2 PCI IDs</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">New PCI IDs.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++<br>
&nbsp;1 file changed, 17 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 6400259a7c4b..0bdfdfc29299 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1181,7 +1181,12 @@ static const struct pci_device_id pciidlist[] =3D {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73A1, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73A2, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73A3, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73A5, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73A8, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73A9, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73AB, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73AC, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73AD, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73AE, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73AF, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73BF, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},<br>
@@ -1197,6 +1202,11 @@ static const struct pci_device_id pciidlist[] =3D {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73C0, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73C1, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73C3, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73DA, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73DB, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73DC, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73DD, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73DE, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73DF, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DIMGREY_CAVEFISH */<br>
@@ -1204,6 +1214,13 @@ static const struct pci_device_id pciidlist[] =3D {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73E1, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73E2, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73E3, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73E8, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73E9, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73EA, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73EB, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73EC, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73ED, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73EF, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x73FF, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Aldebaran */<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4650E5C9DCC81B34323EF476B0C89DM6PR12MB4650namp_--
