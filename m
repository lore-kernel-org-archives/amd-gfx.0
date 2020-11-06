Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B28C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 19:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA71C206FA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yMFPG+Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA71C206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686646EB04;
	Fri,  6 Nov 2020 19:26:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CEA76EB04
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 19:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF7aUWP5uIxx8HaECpHnCHJ2tfDLYWgj+G7f4V6qg9zi1KwTTp5odYC+QPOyK+z74FsfcKyaczIwP9i5hBCtXeSM/TCXGoA/v6K2LwABj6A4SvPXvvcKXYDDydWWvr2Q5wxoKpaIxsMyHhpLnJYQvBxbNsBQroSBs5EMQgcG8thYHMftaAmqvu8Oq1qxMExyo+HcwvkMWV0/8wTzqR44MTMsE3/AMv0y9mghKoLu0jjV1V1V6lnRqRKn7PqwUO5WOGF6DnGqbkl2xU4CqTuC253xbhAS1fLzw605Fd/qFV57ZfQz3SmVk90ekv4B92CuYc8a38EOc+wItkrUIEhUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ftmq2IBwU0LjYffA060V7S8i3db0a/3yG/s9wZSopo=;
 b=fYAJEoMYsEcWSE3Q8DWGL42oNrtg1yKJDAlJOY9qea+JAdpEBD6C9FhRKWvaAXs8xTISOaOMK+4AWK9aO9KgmChwJW1r/bfd51C92sZrcYVI73cXeM/eCOIAPndgrtbHbg2+6Scy/odLEhhE8oVVQ5+GkSQ2enkKVNT2oKeKoy8JvPQRhhZnBNG1XZr/m1SRRkODaS5yQyV9D7qnhorh+QPlode8GX4sdWQXfO7FzrfadWlcCvVCpIydwNBvqUqOq91fIgsN/+gVCSYMVwrTdXPT2gwATLurVTxfVrJJfa4b0SjO8tf0WrcRn0I/eZ5J5L9BEmNFu79XyvsaxcFFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ftmq2IBwU0LjYffA060V7S8i3db0a/3yG/s9wZSopo=;
 b=yMFPG+RnEjwks/jtjx2Qn/27gChpceqyvvmkCUVmX25U7jpNLAlABwesMV3mb0YvEaPniNpoYvsylpurYVSj9yR42KCeUF3jltV6VklLiZNjcMdPrXNdIJ+84z+zPlhuqoo2QFObqAhgAf/7pqNItUBoUkriIaBZkKpai42HZsg=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Fri, 6 Nov 2020 19:26:34 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::30fb:62be:3da8:9916]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::30fb:62be:3da8:9916%5]) with mapi id 15.20.3499.029; Fri, 6 Nov 2020
 19:26:34 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Import amdgpu_amdkfd_gfx_v9 header file
 into implementation
Thread-Topic: [PATCH] drm/amd/amdgpu: Import amdgpu_amdkfd_gfx_v9 header file
 into implementation
Thread-Index: AQHWtG/YCTWEYh7bykSkma8RFoHWyam7fGxQ
Date: Fri, 6 Nov 2020 19:26:34 +0000
Message-ID: <DM6PR12MB2761AC072FE8B650ADE572888CED0@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20201106190528.10807-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20201106190528.10807-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-06T19:26:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=42700d63-4bc5-4150-8ece-c233f333ee97;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:690f:4067:c28e:b6d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38203ddb-2cb7-40d4-ed79-08d88289df78
x-ms-traffictypediagnostic: DM6PR12MB4074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4074B5480E36807125E6E1368CED0@DM6PR12MB4074.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYGwk9Z/u2eE8niitSUY0k4ZyqFcZaF51VNDiLrs6KsyT7tYyF9C86ArqmREdPV479/NArqE2Cmwr8pmGs9ga8w0FIjMp4ARnihdgKuag0WrO3RKM/LZrzINSyDqBLt09ZSznn+YDfQ2v5WFmMAbZzorUhQHpyufqdMmYxnfq/vRY+2FEROK+ZF6RBeHz6ZaB72dJ1yLgLigbFZ0b6L5QWDvopAKmelNLoVTBP4wIQ7VGfgip5pH5siq0YLvHOcelH0QNEOf3cHZBBym/7Doi0Co+laodsAIpxhdNhkDgRzoC3rjS8q23sjfUc/L4A3ygFBSSrE5hLYHI0/2NOY96NAQo+UiMiEMEmZdMCs1zfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(52536014)(33656002)(6506007)(53546011)(66446008)(8936002)(966005)(66556008)(66476007)(2906002)(316002)(45080400002)(66946007)(110136005)(55016002)(186003)(4326008)(64756008)(76116006)(71200400001)(478600001)(9686003)(5660300002)(7696005)(86362001)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1NsP6y1F9yrVItE0Tii/ZVEL8sUWZUqIpder7Gtfz22+wz3BWAcOJ2ZIiKpiQTdxvC7rkn8WSTqcS4OomACZsWHyimYEQlxNZ20mtKHImiQVVX619f9PJGcHtplVjUEdiq8ZVA0MhoJcHaLcjylQ3zUTu9VJ8zUDTBKA76fXJXWCr2xlQg72rWawgwQ3XR/gkeZIEgT8pPb24D1CCpLNKs3AHf23my2oky+zrF24OWvxBTWRSzry/SxaZFVhQfBSdVWAuTygDSx99Y0svh9qYYesN7CNnjT6gfohEXam6bNiBmsIXl484iChHF4gIssINLKt+pRbY41sfiZoZgQyvdNGqSNW1+dQBL/DZnKxV5lBa/BAh2NiiroJAfJ9HD/+KvAMac1ZAkzv5iJiwxXMXdAgqO/tRYj996FKj/lhoABgQBSdANb6tbKpdiJLEXsDUuduymciSJ3Rdzl0VjC2gcWO7mB/sU4XpRIh5Mw+Ve+DZbXQuZofNvVjPXNVWoA09LPin3HDgjuztdSlTBWZdzr/7XrC3srJs8Qdl8mBlYrQTOfkq21Z0+tIx3quek1dGqCx3M91Sh3o1n9pv5JVDF5atWuw18ZdJ0V5lkCmf5SDhsCEGZj3LWXK+AV5Aq9m1RbWRXv6PWcP1ni6ZHMyYqrAl2LGEjBkwtNJDhQcXJnhkKf7SYaqcq3I67sSBcGUErj+hPNzEFJS0ER1Y9+Ozg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38203ddb-2cb7-40d4-ed79-08d88289df78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 19:26:34.2780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYEJXKwvld4qogfbbPIH+9xS5uhSmmruSlUQ5LCw7iwgx4N3F68GJNJv2breeWEJkdSgu8K4nij7blE1eBmuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
Sent: Friday, November 6, 2020 2:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Import amdgpu_amdkfd_gfx_v9 header file into implementation

[Why]
Prevent compiler warnings when building amdgpu kernel module

[How]
Add the include directive for amdgpu_amdkfd_gfx_v9 header file

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index b75bf0bb05ae..c70d8cadaf18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -37,6 +37,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "gfx_v9_0.h"
+#include "amdgpu_amdkfd_gfx_v9.h"
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Charish.kasiviswanathan%40amd.com%7C70c6e0e7f48949c5fc1d08d88286f9e2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637402863520991631%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=XXHYWhGJ4jjQswsA%2Bgjlwp1OOaeJhJ3T3cXuzcGmSGQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
