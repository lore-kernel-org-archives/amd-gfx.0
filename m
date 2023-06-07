Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B2AC7EE2F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 01:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259AC10E409;
	Wed,  7 Jun 2023 01:16:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC7110E408
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 01:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jygx94UCOMxPkctvRP9C7BcQp3ohcEDTsVzYrECJ7ZJrbG8yOCREgTQvW1fPq52qGvZIAHHIlzumYwCkVUcdPKtg8wELE8mxM7RdNH2GRtSowvBvrJ/L1O61Cwsc5Qu+bijGKENKrGAF/OCF2NQzmpgt0kSe51Ru+18NAM19uN76Mb8vp+XgCwKLpof9sGtNzZLAMNkA3bPPa2pxL+JOQ0c/7u48PhnClth8c+AS4UyvZBMf3f5oVbyxi1jl0nkdiKKLiIDUFi9UJUCH8eRYsuxpCFBnOirCL0E7EZa9NJIkidANJ0mkvAJRiJfF83+2jGkdpXYa5HOdEcm22r1AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDDi5l64dlCWx0Ggft0ikzSA3cDFNJ9Apg0cyButDyc=;
 b=ODvE1uTYuufS6CHQu5GG6QA1qKK2SvXUL3KGhod3luDqYXv5YxBsYwejb32eiqOb2oYvTEpPAE87h52NrFUGk3MtNis+QeX0Jld7ih3K8tMWQfG+L6mkS3Hxj38d0fQ6LOdciOUSZdxp164bmV9vgFRRMxW4IeqiiCg7K1WMHGk7K66vyQKMIK0Q1mRnLcfwSmHfkZYQDFSVl1lpmrAHHlyA66GB3NZtQlOnqIEdUM3WxVjHR4RjG43JJl/bNZlVya/80E1/2b7FA4bW/mI3pAOpVl3AT0ik0ENVv9HQ4OuX9idVcKG4M1V4uB1zg21cDG2/adghH4DjzRW2Z3bfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDDi5l64dlCWx0Ggft0ikzSA3cDFNJ9Apg0cyButDyc=;
 b=orDPL/aoO+PaLy6BmoPWjjKLU7bxhQ1lQKnoll7eKgU38q/Bve/tjj3/lJFROYLNsUNqx4W/2Mm50OPYMAMw6Fg1DYxp0pG9FVv3lbrW6y5jaBJd2++V6cQuoyLJph05NPQZ4NRheVAWlymuVKc/n9e+P0SRHGrborFaUmkR/E0=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 01:16:46 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::8488:9af0:68fb:b2ce]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::8488:9af0:68fb:b2ce%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 01:16:46 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
 header
Thread-Topic: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
 header
Thread-Index: AQHZmEOLo/dylX8Wgka/S7Wc9KuBq69+it6Q
Date: Wed, 7 Jun 2023 01:16:46 +0000
Message-ID: <PH0PR12MB54179D8AE876C2278669678B8F53A@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20230606065210.3103195-1-Emily.Deng@amd.com>
In-Reply-To: <20230606065210.3103195-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1164e3bb-20f2-4fb9-ac98-c0e9440f540f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-07T01:16:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA0PR12MB8982:EE_
x-ms-office365-filtering-correlation-id: 7d19d73b-a880-4495-26b8-08db66f4dca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHVTEdKvNgTpJliw9ZjUw1DVgdTvTvs1qdRuKLCR2x10/jQcx6cGwxrVUkO4pGkjyRuld/ee3K5XHP6tVqJUCWKFbuNGLP0SdSqfDlG8j9qyAb4izZcNmhQzKf60jngdcumyn8/vDccp59xQSTWLBiMzQqxvb72zU+tFcJoQ6P0UzJGa8WOI3PxLE2YgIUapmdKC641lTX5bfdIh4TzcNmjHDXu5FI3XJcQoxO48gWOYArhT8BY5g6FdQ72h3K5ZVg9VfaexlfdI4An24+gkiVozQBPazo3gPqFJSCRzMxmTleFxtVkWQJROVfYt8jt7xABPOaZ9MGKk9aj2MRznq6qiFC7CDjnfBVjCEwHf4JZ+yJ1vMxSouVQ8q9cxlTTLFyv/99hPPbr6aFBB5BYw+FugFi4QFSlhP3E86vY1jybDRSFbYMzP43NqYmwTonTW35XjsSht9YlpWrZ6drlJ8/ulQfsnAdt8NW52/lrHUX/ZKD6/dRizaXevfwgLxnMyMx9Qsw4J013b6oHgprduu8AvNWP4d/W9an6hpVIlN40a2CjP0WLzcsmz6lh3TZEkRm7F+uAVAQqAdqby7dGvjpNAeDFGDnbjaSLc/kWWE8fPglhHh0aZvPi/vVQ1TYUR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(9686003)(6506007)(26005)(83380400001)(122000001)(33656002)(86362001)(38070700005)(38100700002)(186003)(55016003)(41300700001)(5660300002)(110136005)(66446008)(478600001)(76116006)(8936002)(66946007)(2906002)(64756008)(8676002)(316002)(52536014)(7696005)(66476007)(71200400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EbibJdjuEgDV+1CxUaEbGyZTb2NcLKivNLcZ2Z0fj6G5oBZYQ8FoslwGl1mz?=
 =?us-ascii?Q?G+JLBRqrkB9iNo/XwZHaY1PISU7hXJ3UTUZLAgYOD4tNm7Aoljj7u6s+m8Ym?=
 =?us-ascii?Q?aB8Kwiilk2UPMx+SVtuPW0LGhcc2RWCPFyo26toPS/cbrgXvvZ2qTbmpdHzf?=
 =?us-ascii?Q?uZesUIVItnkE7rmQ0JEo8dKUJKA5JuX9jCEIZuoPD/yqqr61sUjoK1AfvGga?=
 =?us-ascii?Q?4xifJlYVPH9WnlDgUAkg+HLmww6ZLe3canCkOvoCrs5GCivPPlVZwe/yR8QQ?=
 =?us-ascii?Q?Ygj+kZdPRzVOuycy/5gM4urN9Bh+U4k8qQolDndVch0VYmc38xw+gR6vjyqv?=
 =?us-ascii?Q?e3V5weVKlYs/zwM46kdLXI7stlFzW5QTrfQSnadEF+eBW0n2thdTbqme/ZMi?=
 =?us-ascii?Q?vVFIV1FSVzT8vGc0Z13jTIi7HgL1vE8OfS9WW4LWr3H9t+wRcyj4jS+Dr7Wf?=
 =?us-ascii?Q?1Z/LiHfNktTuD9J41Q26ItDvkLqbz0gB38bnPSX0D9mkRNQyTqbuEZ6N/PZl?=
 =?us-ascii?Q?Hw5F5dLpDdElzr6kqkbxNokAxN87GqEDWqLn1syxqEzCjC9sS30JH+KxukUA?=
 =?us-ascii?Q?dCrxJSqp6PDw7rKdO3Ebj8PiIy3J9VB/H93iyLgrV+Nq4n4vxQmfsWX7sbxS?=
 =?us-ascii?Q?GYVU+gXwWGrBnT+TfPACX0Rvzc+ce47L20eMR/Q4FgX/HSU7WDLn0LsZoTxX?=
 =?us-ascii?Q?D9j88Bj0btpGV5QnZujxEJXrsCS7saskXzcRynUBPDtYAGbCNs9cddRDl8zi?=
 =?us-ascii?Q?bEf5qIcZKxL7k9pqafoitfq/S5Ac11b2o9dlrR3bLqLbICG4x+18Xa4gDmJY?=
 =?us-ascii?Q?Z7McP06AJlUKCchkEWzlzV+JqMJUv41lD0HfwQJt+FXECjxiiJomslgFDI3u?=
 =?us-ascii?Q?o994DKfZ/qjooQvA4qwWOQwnaWBOH0IZsfuLmIOLOzs4QFudIqx2gpoCp7vz?=
 =?us-ascii?Q?yjGSOCtb6NSuvEVsX+OkcQOUcDvKnC4qvF1K7dbRdt+FtB5dwt4AXnXO/cUF?=
 =?us-ascii?Q?Og1NM2rMjCcdHnWX2o7FIHpQjr1T18HUu4BFEp6zBArKHBmDqxZYAVEFHHhT?=
 =?us-ascii?Q?HR6M1RKxKHURFehbcAQqhPflTzoAYFHz4Kkc1P+WwZKLmpzAf/XKGcjOWfQz?=
 =?us-ascii?Q?yxe86yqF7jq2oX7Wzo1EmbjbjINr/TiC5y8ArzvZKRzV6Dp/RaagCsxzqpBw?=
 =?us-ascii?Q?ZvrrSgwO1Z+66HPcRli/mMnl3xdIAsgPiz6wDDx1REQXTESx3Q1198MYQjYl?=
 =?us-ascii?Q?Sb3K3OOvMPfEhiWO1nEwne6AeGjFB/3/XKJ8gVmAs7kkxCrt7VBqndVl7MX3?=
 =?us-ascii?Q?ZSJZ4KQOaMR4hSbPVRXskv+/Ur94ajvsTbmEGGeoS67yxGhVpHvqr8sfbtZq?=
 =?us-ascii?Q?lMSEA2QTlbLD+DP14VGUuZgCsFr5Jc4XCcjtYSveGsJhwsc+C3zPIIi1S5Zd?=
 =?us-ascii?Q?MHHt2J4FCozYaGB/iXzCFOP7txxls2pobgtMIfHaj8SLS74Fs+YUMka/KrpW?=
 =?us-ascii?Q?xczPrBqtlGDTxzxU27lWFdyqGc3J2B1baLQXYcXyGVR56osGgR6gQOxvsGTM?=
 =?us-ascii?Q?UwQQINBDEyW/yh8NtXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d19d73b-a880-4495-26b8-08db66f4dca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 01:16:46.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cAO5mvaZb3JwXmAOmY/CmOkoPyZh/xzt1c17EJAAKo67xAd0mbI+MAqozCgETfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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

[AMD Official Use Only - General]

Ping......

Best wishes
Emily Deng



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, June 6, 2023 2:52 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
>header
>
>For the header, it is version related, shouldn't use MAX_VCN_INSTANCES.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h | 4 +++-
>drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h | 4 +++-
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
> 4 files changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>index 3e4e858a6965..a773ef61b78c 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>@@ -30,6 +30,8 @@
> #define MMSCH_VERSION_MINOR   0
> #define MMSCH_VERSION (MMSCH_VERSION_MAJOR << 16 |
>MMSCH_VERSION_MINOR)
>
>+#define MMSCH_V3_0_VCN_INSTANCES 0x2
>+
> enum mmsch_v3_0_command_type {
>       MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
>       MMSCH_COMMAND__DIRECT_REG_POLLING =3D 2, @@ -47,7 +49,7
>@@ struct mmsch_v3_0_table_info {  struct mmsch_v3_0_init_header {
>       uint32_t version;
>       uint32_t total_size;
>-      struct mmsch_v3_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
>+      struct mmsch_v3_0_table_info inst[MMSCH_V3_0_VCN_INSTANCES];
> };
>
> struct mmsch_v3_0_cmd_direct_reg_header { diff --git
>a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>index 83653a50a1a2..796d4f8791e5 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>@@ -43,6 +43,8 @@
> #define MMSCH_VF_MAILBOX_RESP__OK 0x1
> #define MMSCH_VF_MAILBOX_RESP__INCOMPLETE 0x2
>
>+#define MMSCH_V4_0_VCN_INSTANCES 0x2
>+
> enum mmsch_v4_0_command_type {
>       MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
>       MMSCH_COMMAND__DIRECT_REG_POLLING =3D 2, @@ -60,7 +62,7
>@@ struct mmsch_v4_0_table_info {  struct mmsch_v4_0_init_header {
>       uint32_t version;
>       uint32_t total_size;
>-      struct mmsch_v4_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
>+      struct mmsch_v4_0_table_info inst[MMSCH_V4_0_VCN_INSTANCES];
>       struct mmsch_v4_0_table_info jpegdec;
> };
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>index 70fefbf26c48..c8f63b3c6f69 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>@@ -1313,7 +1313,7 @@ static int vcn_v3_0_start_sriov(struct
>amdgpu_device *adev)
>
>       header.version =3D MMSCH_VERSION;
>       header.total_size =3D sizeof(struct mmsch_v3_0_init_header) >> 2;
>-      for (i =3D 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
>+      for (i =3D 0; i < MMSCH_V3_0_VCN_INSTANCES; i++) {
>               header.inst[i].init_status =3D 0;
>               header.inst[i].table_offset =3D 0;
>               header.inst[i].table_size =3D 0;
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>index 60c3fd20e8ce..8d371faaa2b3 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>@@ -1239,7 +1239,7 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>
>       header.version =3D MMSCH_VERSION;
>       header.total_size =3D sizeof(struct mmsch_v4_0_init_header) >> 2;
>-      for (i =3D 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
>+      for (i =3D 0; i < MMSCH_V4_0_VCN_INSTANCES; i++) {
>               header.inst[i].init_status =3D 0;
>               header.inst[i].table_offset =3D 0;
>               header.inst[i].table_size =3D 0;
>--
>2.36.1

