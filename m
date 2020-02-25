Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD53CC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFC82064A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oZvlD6Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFC82064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F586EABE;
	Tue, 25 Feb 2020 13:39:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173866EABE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 13:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQpNf4efgz1RNFl6djwhtwX4aL7vJZqCxi2vmcoYRxq/uM99eDnI7tHdHrQf/BA7yFwYWSnxc2ibw4uQGR+RDQJ0psnxScXoOjfsdytnPeoSa1ue42kuNbyOgI38k3GUg9svy+Uv4XJW9IL46CLcQQswnwjXOo7s8u3+Q1Y4WQjhsxVybqEcDenYVzcvwJ/Je25lv/B9JNhAB54LZndP9hqS4sG1DOBcAQdJdT4v6rvwKngCMUqP0SsJNxRnP0Ct1obcXA4b6xKMiYnhvom5ln9A8sV5+wk5Y8F4u+iPXUMU1U6i62+0U8mvtFldOxcJWi4SQDtO7r3sbh7vi4n3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpRH1CL9CsaSnR4oDRj+N/tByywEQrlGABuecNqVyAY=;
 b=FVF8RBB4szEpI2K2umCxNrM354i3KXvvYpwSGAz5biSCf6K5jHPBi6E3EW/nPZ9YBI1sxJPJnjvqkH8LMQE+lZQYsSgrZDNzoHcAHpnRU8LaWF9Xc72BIaCaaRxynZV/EMBjJpVrlxWlMA1Brq6ZSTeIqWYs63YtWb1g0fEHOwfVjHPyq4AYXnthByxyMEYDqzIUT+0Xd1OVdelj/gPjS0Bbs6Ott9xRLWBJoi7GWHRrG7ZHHND5xsMJy4rQ7pPCoai7K9LGwELOHOTj6DF4OoELufxUhkJ0Nd2lnDvp6Lu2hS5quscWBWCxTvDxiMs5Q+P2JNDK7FpLhbbsIcxoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpRH1CL9CsaSnR4oDRj+N/tByywEQrlGABuecNqVyAY=;
 b=oZvlD6OvGo7o479STsjWTTG13JCv0GCHmUq0FKhG7ao3j0gjLSWdvn5eA1Qrnz8hFEy5IkDNI9dLNerpxtPOLOGPDdreQCL6PvnS6GbgOjHCmEadI6gWrSN855qofnlJltlWVkrVtBmj2/Nric5Kr4Xblh2zuvcNQV/FjPpS9hg=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 13:39:52 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:39:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package
 submissions
Thread-Topic: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package
 submissions
Thread-Index: AQHV62BzUFsvFYer9EqnsHiKIOLOj6gr6zPw
Date: Tue, 25 Feb 2020 13:39:52 +0000
Message-ID: <CH2PR12MB3912FF27C79132CA1F84F3D6F7ED0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>,
 <20200224221842.14110-6-Yong.Zhao@amd.com>
In-Reply-To: <20200224221842.14110-6-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-25T13:39:51.770Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca9e4671-8c56-482b-9999-08d7b9f83123
x-ms-traffictypediagnostic: CH2PR12MB4309:|CH2PR12MB4309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4309E755C1946D06F7AA257AF7ED0@CH2PR12MB4309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(76116006)(66946007)(7696005)(186003)(966005)(316002)(64756008)(5660300002)(86362001)(66446008)(66476007)(66556008)(110136005)(9686003)(45080400002)(8936002)(26005)(2906002)(81166006)(81156014)(71200400001)(33656002)(55016002)(30864003)(6506007)(8676002)(52536014)(19627405001)(478600001)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4309;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZCCKVFKeFS1f0ZbFZ/ouiVSvwxYGa0DT9E4D+i+kH2ZBlWKTCHpj480WdGipuVnITzDRDhcwalr1FDEs4kDp8leYSReJXID7JCNQzduA+Mzul5Ix7nzBrsVS/l8dJ7XHlNSnB8rxhDNLEPKjPtuA430bdsZboe4dN5sGkQL4QENW+DaRHojSwm+8YIU/8lhGOrSoigFFuYhpq5f3cVEGBhwpZ+C4kjOjgjRxLli5+PFcod/6AMe287MtbLR+jhFQ8N7foCmnwAJup3i1YKe8pdxz/h0UMVJP1Ol3SAk3BjEcBxItQ8NRgPVgC6IXkK5vf0Rk/z0bdbGlq2SNLtRn9EeCaxoqJaWEJyiXHvTukxGoGdytut/qiB7TVkC7x81TBMjArbP6NrXB52PGqlNU48uauZYySCwQzdcTl4+o1+wlLc+IL4vb75yT93kqFNOSQH6PHX0wWeg9d3ckZyityvaVl7AiMEQMdyVd3MEkFbBK3ctpWM5rkmXlBkKu9mDBlF5MrwnO7rn9xth/AvetQ==
x-ms-exchange-antispam-messagedata: wt7T6Qj6/wjMsB3ZKP7yJwr+ReROjIZgkU1xsCBYdpVh4dVvo8k9tdzqxDFXKUeECJXbZ3JfK8XjpCuJglotg5EUOl4dOkwBire1PwtWBV+5P6Z7bcAs5ey926dkBy8c/FbOUnTwSIJyU2q5m2miuA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9e4671-8c56-482b-9999-08d7b9f83123
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 13:39:52.2030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Sn6tZ+ZPJW7mX+v53q7AItxSnv5T+T/P+TvIhBY4YjvMEhhgL8thpn7lLDOFJjZOZq2ZHnYwgYvlRUWn56YGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
Content-Type: multipart/mixed; boundary="===============1701656078=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1701656078==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912FF27C79132CA1F84F3D6F7ED0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912FF27C79132CA1F84F3D6F7ED0CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yong Zha=
o <Yong.Zhao@amd.com>
Sent: Monday, February 24, 2020 5:18 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package sub=
missions

The previous SDMA queue counting was wrong. In addition, after confirming
with MEC firmware team, we understands that only one unmap queue package,
instead of one unmap queue package for CP and each SDMA engine, is needed,
which results in much simpler driver code.

Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++-------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 -
 .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++--
 3 files changed, 29 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 958275db3f55..692abfd2088a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -109,6 +109,11 @@ static unsigned int get_num_xgmi_sdma_engines(struct d=
evice_queue_manager *dqm)
         return dqm->dev->device_info->num_xgmi_sdma_engines;
 }

+static unsigned int get_num_all_sdma_engines(struct device_queue_manager *=
dqm)
+{
+       return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
+}
+
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
 {
         return dqm->dev->device_info->num_sdma_engines
@@ -375,11 +380,6 @@ static int create_queue_nocpsch(struct device_queue_ma=
nager *dqm,
         if (q->properties.is_active)
                 increment_queue_count(dqm, q->properties.type);

-       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
-               dqm->sdma_queue_count++;
-       else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
-               dqm->xgmi_sdma_queue_count++;
-
         /*
          * Unconditionally increment this counter, regardless of the queue=
's
          * type or whether the queue is active.
@@ -460,15 +460,13 @@ static int destroy_queue_nocpsch_locked(struct device=
_queue_manager *dqm,
         mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                         q->properties.type)];

-       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
+       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
                 deallocate_hqd(dqm, q);
-       } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
-               dqm->sdma_queue_count--;
+       else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
                 deallocate_sdma_queue(dqm, q);
-       } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
-               dqm->xgmi_sdma_queue_count--;
+       else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
                 deallocate_sdma_queue(dqm, q);
-       } else {
+       else {
                 pr_debug("q->properties.type %d is invalid\n",
                                 q->properties.type);
                 return -EINVAL;
@@ -915,8 +913,6 @@ static int initialize_nocpsch(struct device_queue_manag=
er *dqm)
         INIT_LIST_HEAD(&dqm->queues);
         dqm->active_queue_count =3D dqm->next_pipe_to_allocate =3D 0;
         dqm->active_cp_queue_count =3D 0;
-       dqm->sdma_queue_count =3D 0;
-       dqm->xgmi_sdma_queue_count =3D 0;

         for (pipe =3D 0; pipe < get_pipes_per_mec(dqm); pipe++) {
                 int pipe_offset =3D pipe * get_queues_per_pipe(dqm);
@@ -981,8 +977,11 @@ static int allocate_sdma_queue(struct device_queue_man=
ager *dqm,
         int bit;

         if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
-               if (dqm->sdma_bitmap =3D=3D 0)
+               if (dqm->sdma_bitmap =3D=3D 0) {
+                       pr_err("No more SDMA queue to allocate\n");
                         return -ENOMEM;
+               }
+
                 bit =3D __ffs64(dqm->sdma_bitmap);
                 dqm->sdma_bitmap &=3D ~(1ULL << bit);
                 q->sdma_id =3D bit;
@@ -991,8 +990,10 @@ static int allocate_sdma_queue(struct device_queue_man=
ager *dqm,
                 q->properties.sdma_queue_id =3D q->sdma_id /
                                 get_num_sdma_engines(dqm);
         } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
-               if (dqm->xgmi_sdma_bitmap =3D=3D 0)
+               if (dqm->xgmi_sdma_bitmap =3D=3D 0) {
+                       pr_err("No more XGMI SDMA queue to allocate\n");
                         return -ENOMEM;
+               }
                 bit =3D __ffs64(dqm->xgmi_sdma_bitmap);
                 dqm->xgmi_sdma_bitmap &=3D ~(1ULL << bit);
                 q->sdma_id =3D bit;
@@ -1081,8 +1082,7 @@ static int initialize_cpsch(struct device_queue_manag=
er *dqm)
         INIT_LIST_HEAD(&dqm->queues);
         dqm->active_queue_count =3D dqm->processes_count =3D 0;
         dqm->active_cp_queue_count =3D 0;
-       dqm->sdma_queue_count =3D 0;
-       dqm->xgmi_sdma_queue_count =3D 0;
+
         dqm->active_runlist =3D false;
         dqm->sdma_bitmap =3D ~0ULL >> (64 - get_num_sdma_queues(dqm));
         dqm->xgmi_sdma_bitmap =3D ~0ULL >> (64 - get_num_xgmi_sdma_queues(=
dqm));
@@ -1254,11 +1254,6 @@ static int create_queue_cpsch(struct device_queue_ma=
nager *dqm, struct queue *q,
         list_add(&q->list, &qpd->queues_list);
         qpd->queue_count++;

-       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
-               dqm->sdma_queue_count++;
-       else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
-               dqm->xgmi_sdma_queue_count++;
-
         if (q->properties.is_active) {
                 increment_queue_count(dqm, q->properties.type);

@@ -1315,20 +1310,6 @@ int amdkfd_fence_wait_timeout(unsigned int *fence_ad=
dr,
         return 0;
 }

-static int unmap_sdma_queues(struct device_queue_manager *dqm)
-{
-       int i, retval =3D 0;
-
-       for (i =3D 0; i < dqm->dev->device_info->num_sdma_engines +
-               dqm->dev->device_info->num_xgmi_sdma_engines; i++) {
-               retval =3D pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYP=
E_SDMA,
-                       KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i=
);
-               if (retval)
-                       return retval;
-       }
-       return retval;
-}
-
 /* dqm->lock mutex has to be locked before calling this function */
 static int map_queues_cpsch(struct device_queue_manager *dqm)
 {
@@ -1366,12 +1347,6 @@ static int unmap_queues_cpsch(struct device_queue_ma=
nager *dqm,
         if (!dqm->active_runlist)
                 return retval;

-       pr_debug("Before destroying queues, sdma queue count is : %u, xgmi =
sdma queue count is : %u\n",
-               dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
-
-       if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
-               unmap_sdma_queues(dqm);
-
         retval =3D pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPU=
TE,
                         filter, filter_param, false, 0);
         if (retval)
@@ -1444,13 +1419,10 @@ static int destroy_queue_cpsch(struct device_queue_=
manager *dqm,

         deallocate_doorbell(qpd, q);

-       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
-               dqm->sdma_queue_count--;
+       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
                 deallocate_sdma_queue(dqm, q);
-       } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
-               dqm->xgmi_sdma_queue_count--;
+       else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
                 deallocate_sdma_queue(dqm, q);
-       }

         list_del(&q->list);
         qpd->queue_count--;
@@ -1673,13 +1645,10 @@ static int process_termination_cpsch(struct device_=
queue_manager *dqm,

         /* Clear all user mode queues */
         list_for_each_entry(q, &qpd->queues_list, list) {
-               if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
-                       dqm->sdma_queue_count--;
+               if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
                         deallocate_sdma_queue(dqm, q);
-               } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XG=
MI) {
-                       dqm->xgmi_sdma_queue_count--;
+               else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI=
)
                         deallocate_sdma_queue(dqm, q);
-               }

                 if (q->properties.is_active)
                         decrement_queue_count(dqm, q->properties.type);
@@ -1759,8 +1728,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_=
manager *dqm)
         struct kfd_dev *dev =3D dqm->dev;
         struct kfd_mem_obj *mem_obj =3D &dqm->hiq_sdma_mqd;
         uint32_t size =3D dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
-               (dev->device_info->num_sdma_engines +
-               dev->device_info->num_xgmi_sdma_engines) *
+               get_num_all_sdma_engines(dqm) *
                 dev->device_info->num_sdma_queues_per_engine +
                 dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;

@@ -2012,8 +1980,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
                 }
         }

-       for (pipe =3D 0; pipe < get_num_sdma_engines(dqm) +
-                       get_num_xgmi_sdma_engines(dqm); pipe++) {
+       for (pipe =3D 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
                 for (queue =3D 0;
                      queue < dqm->dev->device_info->num_sdma_queues_per_en=
gine;
                      queue++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 05e0afc04cd9..50d919f814e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -182,8 +182,6 @@ struct device_queue_manager {
         unsigned int            processes_count;
         unsigned int            active_queue_count;
         unsigned int            active_cp_queue_count;
-       unsigned int            sdma_queue_count;
-       unsigned int            xgmi_sdma_queue_count;
         unsigned int            total_queue_count;
         unsigned int            next_pipe_to_allocate;
         unsigned int            *allocated_queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 3bfa5c8d9654..eb1635ac8988 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -241,16 +241,12 @@ int pqm_create_queue(struct process_queue_manager *pq=
m,
         switch (type) {
         case KFD_QUEUE_TYPE_SDMA:
         case KFD_QUEUE_TYPE_SDMA_XGMI:
-               if ((type =3D=3D KFD_QUEUE_TYPE_SDMA && dev->dqm->sdma_queu=
e_count
-                       >=3D get_num_sdma_queues(dev->dqm)) ||
-                       (type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI &&
-                       dev->dqm->xgmi_sdma_queue_count
-                       >=3D get_num_xgmi_sdma_queues(dev->dqm))) {
-                       pr_debug("Over-subscription is not allowed for SDMA=
.\n");
-                       retval =3D -EPERM;
-                       goto err_create_queue;
-               }
-
+               /* SDMA queues are always allocated statically no matter
+                * which scheduler mode is used. We also do not need to
+                * check whether a SDMA queue can be allocated here, becaus=
e
+                * allocate_sdma_queue() in create_queue() has the
+                * corresponding check logic.
+                */
                 retval =3D init_user_queue(pqm, dev, &q, properties, f, *q=
id);
                 if (retval !=3D 0)
                         goto err_create_queue;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ccbd81ebf5d5e4c67e7d508d7b9778eaf%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637181795552610204&amp;sdata=3Dt6I98xMQpezJ6xa5eAD=
JmZqozS0rIz1GgRhn7qXCnhs%3D&amp;reserved=3D0

--_000_CH2PR12MB3912FF27C79132CA1F84F3D6F7ED0CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yong Zhao &lt;Yong.Zhao@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, February 24, 2020 5:18 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue pack=
age submissions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The previous SDMA queue counting was wrong. In add=
ition, after confirming<br>
with MEC firmware team, we understands that only one unmap queue package,<b=
r>
instead of one unmap queue package for CP and each SDMA engine, is needed,<=
br>
which results in much simpler driver code.<br>
<br>
Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 &#43;&#43;&#43;&#4=
3;&#43;&#43;-------------<br>
&nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.h |&nbsp; 2 -<br>
&nbsp;.../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; | 16 &#4=
3;&#43;--<br>
&nbsp;3 files changed, 29 insertions(&#43;), 68 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 958275db3f55..692abfd2088a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -109,6 &#43;109,11 @@ static unsigned int get_num_xgmi_sdma_engines(stru=
ct device_queue_manager *dqm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dqm-&gt;dev-&gt;dev=
ice_info-&gt;num_xgmi_sdma_engines;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static unsigned int get_num_all_sdma_engines(struct device_queue_manag=
er *dqm)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return get_num_sdma_engines(dqm) =
&#43; get_num_xgmi_sdma_engines(dqm);<br>
&#43;}<br>
&#43;<br>
&nbsp;unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dqm-&gt;dev-&gt;dev=
ice_info-&gt;num_sdma_engines<br>
@@ -375,11 &#43;380,6 @@ static int create_queue_nocpsch(struct device_queu=
e_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_ac=
tive)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, q-&gt;properties.type);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;sdma_queue_count&#43;&#43;;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D=
 KFD_QUEUE_TYPE_SDMA_XGMI)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count&#43;&#43;;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unconditionally in=
crement this counter, regardless of the queue's<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * type or whether th=
e queue is active.<br>
@@ -460,15 &#43;460,13 @@ static int destroy_queue_nocpsch_locked(struct de=
vice_queue_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mg=
rs[get_mqd_type_from_queue_type(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt=
;properties.type)];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_COMPUTE) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D =
KFD_QUEUE_TYPE_COMPUTE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; deallocate_hqd(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.type =3D=
=3D KFD_QUEUE_TYPE_SDMA) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;sdma_queue_count--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =
=3D=3D KFD_QUEUE_TYPE_SDMA)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.type =3D=
=3D KFD_QUEUE_TYPE_SDMA_XGMI) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =
=3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;q-&gt;properties.type %d is invalid\n&=
quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -915,8 &#43;913,6 @@ static int initialize_nocpsch(struct device_queue_m=
anager *dqm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;dqm-&g=
t;queues);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_queue_count=
 =3D dqm-&gt;next_pipe_to_allocate =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_cp_queue_co=
unt =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_queue_count =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt;=
 get_pipes_per_mec(dqm); pipe&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int pipe_offset =3D pipe * get_queues_per_pipe(dqm);<=
br>
@@ -981,8 &#43;977,11 @@ static int allocate_sdma_queue(struct device_queue=
_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bit;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =
=3D=3D KFD_QUEUE_TYPE_SDMA) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dqm-&gt;sdma_bitmap =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dqm-&gt;sdma_bitmap =3D=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot=
;No more SDMA queue to allocate\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bit =3D __ffs64(dqm-&gt;sdma_bitmap);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_bitmap &amp;=3D ~(1ULL &lt;&lt; bit);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; q-&gt;sdma_id =3D bit;<br>
@@ -991,8 &#43;990,10 @@ static int allocate_sdma_queue(struct device_queue=
_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; q-&gt;properties.sdma_queue_id =3D q-&gt;sdma_id /<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_num_sdma_engines(dqm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;propertie=
s.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dqm-&gt;xgmi_sdma_bitmap =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (dqm-&gt;xgmi_sdma_bitmap =3D=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot=
;No more XGMI SDMA queue to allocate\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bit =3D __ffs64(dqm-&gt;xgmi_sdma_bitmap);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_bitmap &amp;=3D ~(1ULL &lt;&lt; bit=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; q-&gt;sdma_id =3D bit;<br>
@@ -1081,8 &#43;1082,7 @@ static int initialize_cpsch(struct device_queue_m=
anager *dqm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;dqm-&g=
t;queues);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_queue_count=
 =3D dqm-&gt;processes_count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_cp_queue_co=
unt =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_queue_count =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count =3D 0;<=
br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_runlist =3D=
 false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_bitmap =3D ~0=
ULL &gt;&gt; (64 - get_num_sdma_queues(dqm));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_bitmap =
=3D ~0ULL &gt;&gt; (64 - get_num_xgmi_sdma_queues(dqm));<br>
@@ -1254,11 &#43;1254,6 @@ static int create_queue_cpsch(struct device_queu=
e_manager *dqm, struct queue *q,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, =
&amp;qpd-&gt;queues_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count&#43;&#=
43;;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;sdma_queue_count&#43;&#43;;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D=
 KFD_QUEUE_TYPE_SDMA_XGMI)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count&#43;&#43;;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_ac=
tive) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, q-&gt;properties.type);<br=
>
&nbsp;<br>
@@ -1315,20 &#43;1310,6 @@ int amdkfd_fence_wait_timeout(unsigned int *fenc=
e_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int unmap_sdma_queues(struct device_queue_manager *dqm)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, retval =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dqm-&gt;dev-&gt;=
device_info-&gt;num_sdma_engines &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;dev-&gt;device_info-&gt;num_xgmi_sdma_engines; i&#43;&#4=
3;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; retval =3D pm_send_unmap_queue(&amp;dqm-&gt;packets, KFD_QUEUE_T=
YPE_SDMA,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_UNMAP_QUEUES=
_FILTER_DYNAMIC_QUEUES, 0, false, i);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (retval)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
-}<br>
-<br>
&nbsp;/* dqm-&gt;lock mutex has to be locked before calling this function *=
/<br>
&nbsp;static int map_queues_cpsch(struct device_queue_manager *dqm)<br>
&nbsp;{<br>
@@ -1366,12 &#43;1347,6 @@ static int unmap_queues_cpsch(struct device_queu=
e_manager *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;active_runlis=
t)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Before destroying queu=
es, sdma queue count is : %u, xgmi sdma queue count is : %u\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;sdma_queue_count, dqm-&gt;xgmi_sdma_queue_count);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;sdma_queue_count &gt; 0 |=
| dqm-&gt;xgmi_sdma_queue_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unmap_sdma_queues(dqm);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm_send_unmap_q=
ueue(&amp;dqm-&gt;packets, KFD_QUEUE_TYPE_COMPUTE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; filte=
r, filter_param, false, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
@@ -1444,13 &#43;1419,10 @@ static int destroy_queue_cpsch(struct device_qu=
eue_manager *dqm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deallocate_doorbell(qpd, q=
);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;sdma_queue_count--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D =
KFD_QUEUE_TYPE_SDMA)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.type =3D=
=3D KFD_QUEUE_TYPE_SDMA_XGMI) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =
=3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count--;<br>
@@ -1673,13 &#43;1645,10 @@ static int process_termination_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear all user mode que=
ues */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q, &am=
p;qpd-&gt;queues_list, list) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_que=
ue_count--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deall=
ocate_sdma_queue(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdm=
a_queue_count--;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XG=
MI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deall=
ocate_sdma_queue(dqm, q);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decre=
ment_queue_count(dqm, q-&gt;properties.type);<br>
@@ -1759,8 &#43;1728,7 @@ static int allocate_hiq_sdma_mqd(struct device_qu=
eue_manager *dqm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D dq=
m-&gt;dev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mem_ob=
j =3D &amp;dqm-&gt;hiq_sdma_mqd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D dqm-&gt;=
mqd_mgrs[KFD_MQD_TYPE_SDMA]-&gt;mqd_size *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (dev-&gt;device_info-&gt;num_sdma_engines &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev-&gt;device_info-&gt;num_xgmi_sdma_engines) *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; get_num_all_sdma_engines(dqm) *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev-&gt;device_info-&gt;num_sdma_queues_per_engine &#=
43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_HIQ]-&gt;mqd_size;<br>
&nbsp;<br>
@@ -2012,8 &#43;1980,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *da=
ta)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; get_num_sd=
ma_engines(dqm) &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_num_xgmi_sdm=
a_engines(dqm); pipe&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; get_nu=
m_all_sdma_engines(dqm); pipe&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (queue =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue &lt; dqm-&gt;dev-=
&gt;device_info-&gt;num_sdma_queues_per_engine;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue&#43;&#43;) {<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
index 05e0afc04cd9..50d919f814e9 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
@@ -182,8 &#43;182,6 @@ struct device_queue_manager {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processes_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_queue_count;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_cp_queue_count;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_queue_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_sdma_queue_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_queue_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_pipe_to_allocate;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *allocated_queues;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
index 3bfa5c8d9654..eb1635ac8988 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br=
>
@@ -241,16 &#43;241,12 @@ int pqm_create_queue(struct process_queue_manager=
 *pqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA_X=
GMI:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((type =3D=3D KFD_QUEUE_TYPE_SDMA &amp;&amp; dev-&gt;dqm-&gt;=
sdma_queue_count<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;=3D get_num_=
sdma_queues(dev-&gt;dqm)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (type =3D=3D KFD=
_QUEUE_TYPE_SDMA_XGMI &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;dqm-&gt;=
xgmi_sdma_queue_count<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;=3D get_num_=
xgmi_sdma_queues(dev-&gt;dqm))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;O=
ver-subscription is not allowed for SDMA.\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EPER=
M;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_=
queue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* SDMA queues are always allocated statically no matter<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * which scheduler mode is used. We also do not need to=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * check whether a SDMA queue can be allocated here, be=
cause<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * allocate_sdma_queue() in create_queue() has the<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * corresponding check logic.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; retval =3D init_user_queue(pqm, dev, &amp;q, properti=
es, f, *qid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (retval !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
err_create_queue;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ccbd81ebf5d5e4c67e7d508d7b9778eaf%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637181795552610204&amp;amp;sdata=3D=
t6I98xMQpezJ6xa5eADJmZqozS0rIz1GgRhn7qXCnhs%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7Ccbd81ebf5d5e4c67e7d508d7b9778eaf%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637181795552610204&amp;amp;sdata=3Dt6I98xMQpezJ6xa5e=
ADJmZqozS0rIz1GgRhn7qXCnhs%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912FF27C79132CA1F84F3D6F7ED0CH2PR12MB3912namp_--

--===============1701656078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1701656078==--
