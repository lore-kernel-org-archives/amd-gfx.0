Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C58C33C9E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6DD2467A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 02:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DDVZd98S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6DD2467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED17A6E825;
	Wed, 15 Jan 2020 02:14:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45846E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 02:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2MoXztvv2wDR3R3qxWH4fYJB8J8A95cox/B8aXDlLY13dSIKu66MXpxqMpohWEBbR2RwQ4UpcuxvpurVLTAA5H5e1BfGsNkGQDhhBLwTRrz+GOtp6VkcXYuvSZZPbtncpdtkf2B8NZpjwlQ+9BWvMkwDW7JAermLU7wXyakqimdRHI6a7EAp58MD5M0p7qANIf+5tNLrCqus7PhyWQ94mByKd1Sr7vnYzQgpXLPRwZaZ+3jDmq4tLw3KW5TdQ4qwWyXmhq7Y56l2bXv9isEmxm7TC4N4rI+04sYjanG/3emofP87RWxLj/pjyBcnnveTvFGb7b0AB4J6UCMGWDGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSKJ58cZYtO8kANXEgG3SbzFWAH9vCGFrUc8iFuYZI0=;
 b=LVbZPW8kSTK0k5ufUilV7S4ic7oD6qwfSp6mwbBv0mZ9JHk3CIhMl4Q5NfNcufgPCw0JyW7/8pEvTNhzAxsBRDVdxkNKooOZGVpu1FPW1TJO/OdXqrsOVfqSeqMdvl4LfWkn5hnRSMs/5kih81vJx9LKH+FOfheDXS1jGyuVS3LrvEVcuGQopaX0YzDlwb8EKOXOzgFxdaAi6whO1dHcXsII0vAF2cU5yfFqoDmOjQJ6mwxszM/qsH3L23SrmWzuIcybVfkBCK1fdUcByMUeUouc36yBZgQTnmPqJqPfQipUdI5JKVcFmeqOzOtl5K5SGnFj2esaLKz3nH539myMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSKJ58cZYtO8kANXEgG3SbzFWAH9vCGFrUc8iFuYZI0=;
 b=DDVZd98S4lJO8dfxYApr7v4pwPLSQWc3rkIC5xykSY2067eFMV9YB1C50vJJiWzqNVQVclB3bInY8HIKAndwjIU2OZUvIiu97DhYUqxe+q0G3Dpcc2ew3tDrKHy9QzJNvjfOv5ZTgaBCSwxmZeLv1XwLCDwbBax+XXOdDFrwux8=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB4047.namprd12.prod.outlook.com (52.135.51.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 02:14:03 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a%7]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 02:14:03 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
Thread-Topic: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
Thread-Index: AQHVysD6dJXJDijupUy22p7/8lVXvKfqENUa
Date: Wed, 15 Jan 2020 02:14:03 +0000
Message-ID: <MN2PR12MB3087E571C762E686584D3EBA89340@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20200114095819.8373-1-nirmoy.das@amd.com>
In-Reply-To: <20200114095819.8373-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-15T02:14:02.428Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f04b45dd-3ca1-4504-6506-08d799609769
x-ms-traffictypediagnostic: MN2PR12MB4047:|MN2PR12MB4047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4047B1079F0ECB72E2A1022C89370@MN2PR12MB4047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(478600001)(52536014)(4326008)(8936002)(66556008)(110136005)(64756008)(66946007)(66476007)(66446008)(5660300002)(45080400002)(966005)(54906003)(91956017)(76116006)(316002)(8676002)(55016002)(6506007)(9686003)(81156014)(53546011)(33656002)(81166006)(2906002)(86362001)(71200400001)(186003)(26005)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4047;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ry1OIQFo0cwFKSr0loZ6R26E5NQN0M89WFlcCWXGA0fuvVryyzsWxmRDY8fVq1F8mwOe63DeRGgHdbeyEi4P883ikSsivgZgLri12CR2BepguWX3pd/EqlQNsAXPYwtRjhX4yIjsyYruw+zm+4co4s/R/CnS0qa9EWavq1G5u2Xwx2OSqb2e0laj20hvlcBirulYgvVQ3K0yyjeI1t7X9OZ00k9CjQKbvdyACA3Nv+KR5a5z/vJJQCRYnYcxJn7WDh0qEo4wmIqAtAQ6s54jvg4+QAWfUspT6iCdlIcsNuQQT6SxnLrJV8RWW6ulOqEQ0AN0+9vfjm2M/rIFd/j5ZASeeXKmXDj7hE9VmmbyuIZ4pza7vGFFnB3UyACrDTwyOZrhx3r8NW88hnfvoTNoB830Xk3GzCl9NnTDm49b5d02SMwZ/JUmkW3hAxzH6UIvj/SPkc1zZWkV9wz0zR2E33nJ5Rm3Kwg8XLzr/kGWJA=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04b45dd-3ca1-4504-6506-08d799609769
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 02:14:03.1092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gmj4KEemxP537Ny+NsNkIADJElPzzjCZZVHRsXxQOYK660vfy5Gw7BvmZggEZ/WO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ho,
 Kenny" <Kenny.Ho@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Nirmoy,

Seems like documentation for struct drm_sched_entity@gpu_scheduler.h need update as well.

BR,
Xiaojie

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy Das <nirmoy.aiemd@gmail.com>
Sent: Tuesday, January 14, 2020 5:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander; Ho, Kenny; Das, Nirmoy; Koenig, Christian
Subject: [PATCH] drm/scheduler: fix documentation by replacing rq_list with sched_list

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2e3a058fc239..62bcca855c69 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -45,7 +45,7 @@
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note: the rq_list should have atleast one element to schedule
+ * Note: the sched_list should have atleast one element to schedule
  *       the entity
  *
  * Returns 0 on success or a negative error code on failure.
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CXiaojie.Yuan%40amd.com%7Cb5b5e9e4c2a34ac6b50308d798d81903%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145926254946780&amp;sdata=ZgkmwrForbuXnPGGHz2UVE67anyILWedAMNlcSA%2BvUw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
