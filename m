Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740DC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB47F20717
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UF9QdcSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB47F20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6051E89B00;
	Wed, 18 Dec 2019 08:26:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690041.outbound.protection.outlook.com [40.107.69.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5639489B00
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUp8okBuDDKV29h+nD99wBmRmaQqp+n/pKkZ+F9/v2K2D59HedxgmBSdtfZqS5p5ts4H9l24ppO6Nr65zeU1mM8eu/Y+4tHXWa7362sPMWAfhjOdlORA7eQeYCNyD0bQjkR07h2n1WCSZrMGS1+dOgNXgkZnM+BE9YrrOecs1GB/oXY78cAi1yXIn5kAMtF2724jRRiiFwaoCs1my7tzmwFQwX+dkyautQEOjXH4ogtsTemDfxmYRYMP10++PVTSriIjqVtW+XMC1lVCEcbM9knobwMSWRnciaShwacAlm+vJlVZvpXyn9HxxkphnnHQTLOHvHiNlvjl9q5qgruG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbBpa6yRFzNpxymX5pNQBUim+7pZGEjp2gDCcPV7Ktg=;
 b=lzt/Zbpq6ikD3FKISgu9XCgp0/4/51esMAHPDzYOXI2Wa3xStENXBLg9aZXqGqhuJOUN3DtbbGnftNm1TbZP9FnXY+qIB6EtDU/JTLoVlKn555pECTdu1YHJreYzRAY3vNR3H2YzC3rqIBdwZ3qsWpka0p75ynTdRiqqBFSqB9cNIjbhaYMC9kiDsUujFAD7pU9aFr0QmQif3K67MhnJzgjUdPj48uIJzzu1887CfddyNxTc89YfahsRltN8GTKFzbSB/bNdmQMOR1XtCBQBwhPQ5XN95gkmJBuFbdWVNlbqdwzQ6I71mSpkQPQapweDxp0RowgCNEeeADGwR4qLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbBpa6yRFzNpxymX5pNQBUim+7pZGEjp2gDCcPV7Ktg=;
 b=UF9QdcSqYqozbAtKoe/7ddXUSjk+irBtKgIEotGsi0keAUi1hulOHqX6zjOxyCcJC+BQdVKGOcXM6TiIuJF6VVTq6PJFlBdl8nsW5oFhbg3j5NShLWKnQAuPJfOCJErRhpQ4+mHW9hYO/kjDQVY8iDczPvBT9551VSz0el6cKGw=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4192.namprd12.prod.outlook.com (52.135.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 08:26:35 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 08:26:35 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: expose num_cp_queues data field to
 topology node
Thread-Topic: [PATCH 2/2] drm/amdkfd: expose num_cp_queues data field to
 topology node
Thread-Index: AQHVs97gHDmE1sxpF0ejpP0bxMhQyKe+/vkAgAEY9YA=
Date: Wed, 18 Dec 2019 08:26:34 +0000
Message-ID: <MN2PR12MB3309E2E1D6E3CCC4EDC93330EC530@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1576479771-10748-1-git-send-email-ray.huang@amd.com>
 <1576479771-10748-2-git-send-email-ray.huang@amd.com>
 <58f5772e-76dd-2ff7-d58a-46cf4063cb0a@amd.com>
In-Reply-To: <58f5772e-76dd-2ff7-d58a-46cf4063cb0a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T08:26:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=797fba3b-af8f-453a-bea5-0000462bcf5b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2538.017)
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-18T08:26:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c3f3e349-2556-457b-9b58-0000a4f2aaff
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4654061b-3b89-4e51-db76-08d78393fe8e
x-ms-traffictypediagnostic: MN2PR12MB4192:|MN2PR12MB4192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB419229F1BD1287933CB7B937EC530@MN2PR12MB4192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(7696005)(81166006)(8936002)(8676002)(81156014)(71200400001)(55016002)(53546011)(9686003)(6506007)(86362001)(26005)(478600001)(52536014)(6636002)(66476007)(66556008)(66446008)(66946007)(64756008)(4001150100001)(76116006)(6862004)(2906002)(186003)(33656002)(5660300002)(4326008)(54906003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4192;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2u72fgE/nUbGL0+72jMAqoY/XLpYb0RAFwRz8104TIhXBYme84bbIS3nbfLQDKEzUyVauHlOmpJ0zhSJo8CKLVT9EyidUCMfTUsdn4OWwHZGz59mMInlfNDhOcNMFMSDoLff/j2F8mLltA0g6MZQxTUI1FUSXLJ+mUSRWSRZrILwr1O5O61KUlzQBBt4DCaXxQZskcqJnSceRxGJWdN3r/ra4FKSpnfx18SXtwj6j5C/OuAmJzhD99iGhLL3QtXRMkT1QNh5kJrBUgw0DVHTfnfHqhxR9Rkg8CAb9j1HstOVygKASU0CAzG5CKWQNW46QUCvdn7NMNfadoMHXlV9nVNZRRcaAGSamqAZmjB6hqW3OGPgSNtLvcLOHbiFD+Z5Vdc6fdBr9TqASnTFCllzIr+j03zHKTOYJ0sbDU0nj4aiDUlsbBdv4I650zR+WPsF
Content-ID: <E665C549816988439B135BE570BD2EEB@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4654061b-3b89-4e51-db76-08d78393fe8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 08:26:34.9081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37d4TumU8BtW60QmBOWGT8QwX3bMc9Xe0hP4vbdHELcYj80Dr11uY1doz4m6kARRTV+Fqd5h/smfgt5mEIK+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhao,
 Yong" <Yong.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

On Wed, Dec 18, 2019 at 07:40:26AM +0800, Kuehling, Felix wrote:
> See comment inline. Other than that, the series looks good to me.
> =

> On 2019-12-16 2:02, Huang Rui wrote:
> > Thunk driver would like to know the num_cp_queues data, however this da=
ta relied
> > on different asic specific. So it's better to get it from kfd driver.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
> >   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 3 ++-
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> > index cc01ccd..203c823 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -488,6 +488,8 @@ static ssize_t node_show(struct kobject *kobj, stru=
ct attribute *attr,
> >   			dev->node_props.num_sdma_xgmi_engines);
> >   	sysfs_show_32bit_prop(buffer, "num_sdma_queues_per_engine",
> >   			dev->node_props.num_sdma_queues_per_engine);
> > +	sysfs_show_32bit_prop(buffer, "num_cp_queues",
> > +			dev->node_props.num_cp_queues);
> >   =

> >   	if (dev->gpu) {
> >   		log_max_watch_addr =3D
> > @@ -1316,6 +1318,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
> >   	dev->node_props.num_gws =3D (hws_gws_support &&
> >   		dev->gpu->dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS) ?
> >   		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
> > +	dev->node_props.num_cp_queues =3D get_queues_num(dev->gpu->dqm);
> >   =

> >   	kfd_fill_mem_clk_max_info(dev);
> >   	kfd_fill_iolink_non_crat_info(dev);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.h
> > index 9346cc1..e447901 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> > @@ -27,7 +27,7 @@
> >   #include <linux/list.h>
> >   #include "kfd_crat.h"
> >   =

> > -#define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 28
> > +#define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 24
> =

> I don't see why you need to change the name size here. I'm not aware of =

> any requirement that the structure size cannot change. This comment =

> applies to patch 1 as well.
> =


Oh, sorry, I miss read this field as "reserved", so I kept the struct size.
Will updated in V2.

Thanks,
Ray

> Regards,
>  =A0 Felix
> =

> >   =

> >   #define HSA_CAP_HOT_PLUGGABLE			0x00000001
> >   #define HSA_CAP_ATS_PRESENT			0x00000002
> > @@ -82,6 +82,7 @@ struct kfd_node_properties {
> >   	uint32_t num_sdma_engines;
> >   	uint32_t num_sdma_xgmi_engines;
> >   	uint32_t num_sdma_queues_per_engine;
> > +	uint32_t num_cp_queues;
> >   	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
> >   };
> >   =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
