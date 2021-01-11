Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4918C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C27B224D2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C27B224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339CE89B9F;
	Mon, 11 Jan 2021 04:54:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B0989B9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa/MS1tENKBgp7JMQoXIFCusAGxlhhkWHeMhYpxTUwsCGdcARLomd6PjqW8g3sETrpp+AONU2XCZiUd42X9mKlJDC0p7u9ejMW948kmNJ8szaRpExOe3qhunQwA8Vo2qm6Eg9yzsxBabZDVaMM++0Efi/h5R79cO+8Zvj5GQivUUircpasmEq6wd4XgMzI6FaGTgU9l/6/78/V6JBqsy8h6S/i/7dHHq8BILlpj4bjmN3aHb9mUHVazcGz9WH8+tq/HvHqF4MMFneHNJEsUGbQgQzmZkSIKmvVbY+LubzoZWyd1/QqIWawniv5qlARQlK8OqXBw3n5O/OyGuzUc/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stOBTYhS0djJls2HkHGoatC/EqL4OkViY2Yg2Kgh+k4=;
 b=k+NsawttcSnGSc18VfJL5Q4HBWxB8rcbdOuglWVelej+hSvRyLXWGkDNWYi80WZcALIUQwW9Ds1Xni6RDj/ktB0WBqrMXlDVlKbxK+bmM3P+NEhrQ1kc0NE9DelzFsdxf3NY8X1S4s6Lt4coCafviuTiK2/uE4nYxk2k3PJWN2zGOOrK7UKWLE2PsRlMNTZLN1Tut9glTBmiHWosPKs3XiM0MHmzdB4BhTkgILS1WwkKSbA4r4asfZ2f/wa08AiXe8uY8H7X2mtblQTt0VANwiXnNKhHDP49DDeA77hFTNf6b4grMZ32f0iTfdsYq4wAwxicR/gc4FyzwIGMXv1yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stOBTYhS0djJls2HkHGoatC/EqL4OkViY2Yg2Kgh+k4=;
 b=iDW0sjedBjoYnXsTRsKwePK1AIO7/bCqG9kjtR1SLrbaPH57iP7G182PS2jbkZBvJYRDptnYfgRUXFoN50DzE8AuZwsILLwQ/qZGzo26dH63fbS7CZd3k3AahULOCxjjp5o6LVs8fRT7e1EabYOIUO5XFrtwg+YaRkxYlN4pf24=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 04:54:05 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Mon, 11 Jan 2021
 04:54:05 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Decrease compute timeout to 10 s for sriov
 multiple VF
Thread-Topic: [PATCH v2] drm/amdgpu: Decrease compute timeout to 10 s for
 sriov multiple VF
Thread-Index: AQHW5J/6IokWbVhYOUueFKR9tZGsfqoh4kvQ
Date: Mon, 11 Jan 2021 04:54:05 +0000
Message-ID: <BY5PR12MB41151564C8F47155067320228FAB0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210107025109.605633-1-Emily.Deng@amd.com>
In-Reply-To: <20210107025109.605633-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0e39209b-6ed3-4fe3-8ac1-3250ababfbc8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-11T04:53:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94d519d7-f074-4219-47f8-08d8b5ecec33
x-ms-traffictypediagnostic: BYAPR12MB3414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3414E9D988AFA5596648AA878FAB0@BYAPR12MB3414.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFhk9FG5bCKH9+BMid4qt1ejKPTOsQzoK1hqX8vF+3KaAf/gmcYPoYiuYegnMUkIViJdwkQcpSq0BKELUWwGCRJwC8bEL5ByIOhUO1aTAb/xdx9nF1DiOvu6szfieAF4TM8e4b1fxgcHWo1ZIsoUl/671Mit2BQyPhjVCVQlSVgnWyVOOrgq+UkNj84kxNtTdcut1acT65iUDxhMC+TzLyoHGFAPQcR1JUDD/i7Tm9sbn19daF6mni7dVccmDSMNmOMYy91HdFycC9btupTNKcT22XZ9v4aeVrpikKdxwEPEilD8u/Ba618j6uoUyP9M53yXvV7KL8AVlCnKsNMie6yxfcln5mP7dw9s0bL2pk8L68Sl0cgs9EEwoepvOdzVuwilbrmQSUSdaUSxdF23hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(71200400001)(86362001)(66446008)(52536014)(64756008)(8936002)(8676002)(76116006)(2906002)(186003)(83380400001)(5660300002)(55016002)(66556008)(66476007)(66946007)(9686003)(33656002)(478600001)(6506007)(316002)(26005)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WY8kQugL2X6HWFW4v3eyhaTfv/GsrKFw42CY7objJC4VeK/USOaJ1AGGi1IA?=
 =?us-ascii?Q?E69rPc5PPSIca94BXyC/48epxcwfA1xBtja02v6XqJn0zAjAYFUUC1BHQ4vw?=
 =?us-ascii?Q?xWZREKt7aXJS4C9iCiMTkXmqBMZyuxQHVms2j+nkmwGPW5QNVgSspa0W4+Ui?=
 =?us-ascii?Q?C+OkBaAd0KmzK6uOXRrU3J2FW6uKeB+TuRdK1xI00gZ3cJddhQF5FF4Cem45?=
 =?us-ascii?Q?gDQyP2lLc9C627GU8j7NYLQhVJX2d0xkfihb8IVBLDemsSTtx+YOMsZQ2wA9?=
 =?us-ascii?Q?uBbDhgC1RCwq7v9sPMHIGiV5B9MvDRx4znN2mGHJkdOK0VmVNbePio68Tx5n?=
 =?us-ascii?Q?ucaZfomW5UOls97nE16ex7VaqYY8WgDvO90f7neo+YtjeskQs0clV++3dF5Y?=
 =?us-ascii?Q?F4jpAlG+yzek74iLD3FTXvaP+KQfPhWV/EHhyJZTj/wzoIC6asqzzVd6fcp+?=
 =?us-ascii?Q?y11SQzFeyHGJs/nGQWgpiswtX/uowWCzvr/SSZZ4ZW9kha3Qx7qQGTAdf4QM?=
 =?us-ascii?Q?h6VTVdhD6rWKhishdv0COUQp8ntSfLJ5fpfbmcnPC/5QRQFve1sOvqegElBP?=
 =?us-ascii?Q?VpttHVkDjHhR/4M6Z0tVsSeX7MJdOkwm3fvLtTptZSRREPSt0xl2lNz8sga+?=
 =?us-ascii?Q?7U11Ow3X7N1Ryn/pxycSVE5NDFpt8mwYbcUZEE0SSqoRjOaPq3Dw/ytl6JQv?=
 =?us-ascii?Q?P9v88Of/G6kR30VCeOIGU04pohX6w5S9i90PHlFnTKN5C0uOytdat3u+jhQl?=
 =?us-ascii?Q?gGhPxnXTnsj2oXhR3noOpBBsv6y3xqZv9FGGVBND9mS2TyLy2P+4gFBDH+Hd?=
 =?us-ascii?Q?TXf8pVwBNvcvg+TyOciPYtZ+//g+GQktchOTKqIsK3TBg5Rm9hmiozWh0qEw?=
 =?us-ascii?Q?AxRZvgcXt276hpYyfUk4cgO83mLpYxktxyTL38HF/sijux6lo/pk1LKBQRgC?=
 =?us-ascii?Q?fAOi1tc26VDZ9iHjtgA7UA/ShvMvESOPx7q8qfVIBts=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d519d7-f074-4219-47f8-08d8b5ecec33
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 04:54:05.1184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqj6pJnUOzZXV0vWHFm35AGVGQS+ke8IJhHWmKMYMmZcx3ea1NY9kgUZNgbNiDV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping .....

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Thursday, January 7, 2021 10:51 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH v2] drm/amdgpu: Decrease compute timeout to 10 s for sriov
>multiple VF
>
>From: "Emily.Deng" <Emily.Deng@amd.com>
>
>For multiple VF, after engine hang,as host driver will first encounter FLR, so
>has no meanning to set compute to 60s.
>
>v2:
>   Refine the patch and comment
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 5527c549db82..35edf58c825d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3133,7 +3133,10 @@ static int
>amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>  */
> adev->gfx_timeout = msecs_to_jiffies(10000);
> adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
>-if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
>+if (amdgpu_sriov_vf(adev))
>+adev->compute_timeout =
>amdgpu_sriov_is_pp_one_vf(adev) ?
>+msecs_to_jiffies(60000) :
>msecs_to_jiffies(10000);
>+else if (amdgpu_passthrough(adev))
> adev->compute_timeout =  msecs_to_jiffies(60000);
> else
> adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
