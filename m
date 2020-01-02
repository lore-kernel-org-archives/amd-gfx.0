Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0408EC2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 13:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBA42072C
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 13:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YExenTk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBA42072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E06389BDB;
	Thu,  2 Jan 2020 13:40:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F66C89BDB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 13:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmnq8jMcLAp0vvO+5lj9ZK6JLgbjNdmKO1rZ2bMQ0ZkxSXV06yd7Nlrm27ouBlvayvHSj3XYbawnGip7NTGO+GoO6a4apdsYIYB4RL87vgFwVulINeYnBKGHuXPESfyB/x8s8w38fiTmi1Mtr+31CP7DUAdu7fbyhg7oVP4gJPCxK9riLp5b2XkUSBvCdcMLYVmuUR668grWa3FtfQ6MQNruvv3aWKz2i7h2ucUHcqnr4XqttwZH6IgzhYVvisubHBoBaD9jxx7Ed6aC0wGKkfafbRXWjnACfIWvUtPJAL/+HGP0dhliN3aW7iIELAMh8s+mYhWYaj2KxoeAPQjjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDDoQcazctkEKXMS7aBR6CuUPRx6v3qsKE8y7GjHTuc=;
 b=KSxbv0d0pgR6PVx0CTKzPrwEsCzL9n2+K1t9MOL59OSGM1K8jzXDKfGOXmHxZmLbkgzvhuozXEJLsYL4g6rDxHqW49Tq4/AIDcK2Kyl/COXSlAtlE0SVUMjSCMCqgg8lkxnEjKUBwQY2lEY482xhimZihznXHBfDmVKeA1pIKi3ThCOOfHib2gzkV7EUDOFb9MBgxSxHU0/VlI3nRBu7d4MZQ3Lo5XHeEclcpAKXODs6aaI/+/Byj/fhPo6AqAcK5y5scrUiaSCC0Mlux1zLehzr1HBP41TVY6/iwnpJzy/CZN4wTLrUOmyGj1hencA+XFsyeQF4W5Gdvp6JOtnq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDDoQcazctkEKXMS7aBR6CuUPRx6v3qsKE8y7GjHTuc=;
 b=YExenTk4ibSTl3vxI7XSRJtGHqAdpP9Nx4s9z/avL37wwhC5UkMEdcMKK8Dmj85qN4BwfxtpHFQen7VcNdOtaIRdQeibn5l7E/CtNnwyvHzjlUKQKiHu5ISkA2BH2o7aTPz1cCp5Wld6J9L8FGwClG5jI59zCyeer1ejrhpTHE4=
Received: from DM6PR12MB3146.namprd12.prod.outlook.com (20.178.30.205) by
 DM6PR12MB2652.namprd12.prod.outlook.com (20.176.118.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 13:40:10 +0000
Received: from DM6PR12MB3146.namprd12.prod.outlook.com
 ([fe80::d50e:6a6e:19c3:4c03]) by DM6PR12MB3146.namprd12.prod.outlook.com
 ([fe80::d50e:6a6e:19c3:4c03%7]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 13:40:10 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdkfd: Remove unused variable
Thread-Topic: [PATCH 2/4] drm/amdkfd: Remove unused variable
Thread-Index: AQHVtw/C2+74riWxIEK9IZDKfvRbAafXdiiQ
Date: Thu, 2 Jan 2020 13:40:09 +0000
Message-ID: <DM6PR12MB3146B7990AE73E1B90F9176D85200@DM6PR12MB3146.namprd12.prod.outlook.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
 <20191220083001.30607-2-Felix.Kuehling@amd.com>
In-Reply-To: <20191220083001.30607-2-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T13:40:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=043e0b45-f04d-4162-a60c-00002b663dec;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-02T13:40:08Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4cd9321b-4001-48fd-88c7-000055893ac5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 605fbca0-e3e9-43ac-8994-08d78f89496e
x-ms-traffictypediagnostic: DM6PR12MB2652:|DM6PR12MB2652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26527D7ABAEDDB3B5D1E716685200@DM6PR12MB2652.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(13464003)(66946007)(6506007)(110136005)(966005)(71200400001)(478600001)(53546011)(9686003)(316002)(186003)(45080400002)(76116006)(66446008)(66556008)(64756008)(66476007)(55016002)(81166006)(8936002)(2906002)(52536014)(5660300002)(86362001)(8676002)(26005)(7696005)(33656002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2652;
 H:DM6PR12MB3146.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCYq48HTd3F3RcVjDTVK284nPQjhpXBxwvCDrn+q8y68UD1DevgdDgQzcWJGJ4oZS/xMR8srVV/Ukwx4kRyhzJlE0gdxc35LVbX/ZUgevW1Lh3mfcSQkeNG8ShBRFBjBOGxwNBbhKvBvQ9aoLxGP6oDyG5MTKcYVX7JSsRmQ8E/HklA2N9vBU+pggwKZGWT32Lm41OnItDe8Hlh9xv8knbtaJpM7Y9kKx2nhI0zRkZHVL9b1jzdTfgRyq760kblYqVfnNApPCCduV3oBTOAtokm+y1NWp7gUx5igu6tEbLrh4amZT7xtcMvR09mkjNuL9eoetF1wfmKmSbmcnVVSXAkzQ0hnPQSsKqd+3WxnMPN/5VrKQqU3QfhCs6RJSqky/lyBtsPDjeK5IPZ3XnJgcnRYU9/VDFNk3yy8JyRbOchPXMO/n4P/k8g8bElYSSK8kXUaQEbLy+95OlPDNUJ90x8lSpSY9wUdgH7irvbju+Pm/SoeREUY6DXpdC8p2bQDVdBzWPGvK5jucSGWdEMi/qnFm1oGNCtLKDyav6t5IFo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605fbca0-e3e9-43ac-8994-08d78f89496e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 13:40:09.9548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFKMtUzK3MCrUTvq5jsIOgVd1QCL/FCBJ0AHCO8hs0umakFWYnCg+70MwrwRLYfH6S9gbS3KksARjqBgpPuh6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
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

Reviewed-by: Kent Russell <kent.russell@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Friday, December 20, 2019 3:30 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdkfd: Remove unused variable

dqm->pipeline_mem wasn't used anywhere.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f7f6df40875e..558c0ad81848 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -930,7 +930,6 @@ static void uninitialize(struct device_queue_manager *dqm)
 	for (i = 0 ; i < KFD_MQD_TYPE_MAX ; i++)
 		kfree(dqm->mqd_mgrs[i]);
 	mutex_destroy(&dqm->lock_hidden);
-	kfd_gtt_sa_free(dqm->dev, dqm->pipeline_mem);
 }
 
 static int start_nocpsch(struct device_queue_manager *dqm) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index a8c37e6da027..8991120c4fa2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -190,7 +190,6 @@ struct device_queue_manager {
 	/* the pasid mapping for each kfd vmid */
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
-	struct kfd_mem_obj	*pipeline_mem;
 	uint64_t		fence_gpu_addr;
 	unsigned int		*fence_addr;
 	struct kfd_mem_obj	*fence_mem;
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C1c4037940973425f605808d78526de75%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124274380882459&amp;sdata=0SF%2F%2FKC%2BEOK%2FzFNDwQBltE5%2F9euhi7IrbKNPp8dlDrQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
