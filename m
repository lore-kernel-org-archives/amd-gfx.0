Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6DC48BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 03:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09448613D5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 03:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09448613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C556E863;
	Thu, 17 Jun 2021 03:05:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CE66E863
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 03:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD2Y+Zn13t3f3xn/TcZhLjzEev0zWGa/bcgGWjzC0BXH8LuRPtO2laLOJbo0W/sYUX5Nzf5ZwJ54VPfxAnQa6lwbnH3BxtCyWmZyzMJZPoaKHd8EC7JBxdOuhKJiPcDZRmn6xPXbUc8wJO6dGqpZP+N+beCFKwC6JBIRTku0RjxvH4bKLxqNizzFYOXYbtTICn/KKWju9/1uFnZTWGMcas5tR8Wa2kViD6bHz2ojTMBLXAmsSp7VsMYt9cveiLXJnxM4sEP268Ptg/rOhL7IBifG54jlzXOlP6ZS7toguFzLpV1hlRJYQF/UvPpPccF/mVu5nylZ3NXxIGwqPr9hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2BxaePQ27ZK/+NR5NhSEB+aXLHRAsu/tzIF3soIEKk=;
 b=G2EMtaKiFmSVze2lL/H1GGryHe92szbmboj2M9AMta+iX5zH05QcVYYNVg7BGfLr13uSji4GsdsoecqNjzDyejeTt4+TCuR3Bn9I7xqsmn39OYOwnNSALRmIAXL0tY2qEV2ri3jYgpfM8V7wK+4g05gNIXFVlpcqapbtOvXH0mgGm2Ifl5+ZsqKaMEe+FOtuq2kVE3AmxYD7wORYtGCavK4uDJUkFdgZgrgQ19FEihQb0dgMXCH/CHPB35GEgAPvRBzAUy4w3VymiQfMJAjNeWZ5AtNs7YQiadk9VUmFqCnRjwaSfSsXnJFgdgPJBH4ID6ZrkqXywWyUIwpt/g5UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2BxaePQ27ZK/+NR5NhSEB+aXLHRAsu/tzIF3soIEKk=;
 b=to7+fsliq2/0XECkEf5xbKjGJ4w0s1rtKPx+vgwWqXahw7SJZIFSiJZlUMFUSdHPb8V6K8eE+jQ7an9VQ7HV+s7XwY4T80IYsy84W62XMvC/F5hLewLaYvIjb7Kj8KMCqv8oWHwTrnGE3a7NwRpmJjRzvt8+quwgxL5dauL5LS0=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by BY5PR12MB5558.namprd12.prod.outlook.com (2603:10b6:a03:1d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 03:05:29 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::b123:6491:dff1:e2b9%9]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 03:05:29 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Walk thorugh list with dqm lock hold
Thread-Topic: [PATCH 2/2] drm/amdkfd: Walk thorugh list with dqm lock hold
Thread-Index: AQHXYoqWQ+DoEKdNtEual2MkW/SfVKsXRCcAgABAzLA=
Date: Thu, 17 Jun 2021 03:05:29 +0000
Message-ID: <BY5PR12MB5557E86301A9D56861B4E6ACEA0E9@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210616083511.2489-1-xinhui.pan@amd.com>
 <20210616083511.2489-2-xinhui.pan@amd.com>
 <4f9fa596-f64e-8ddb-2c91-5a03bb378775@amd.com>
In-Reply-To: <4f9fa596-f64e-8ddb-2c91-5a03bb378775@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7dbb77d8-d4e9-45e0-b7cd-b28f9ff52193;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-17T03:01:07Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14d9c78c-e0bb-4e21-aae5-08d9313cc36b
x-ms-traffictypediagnostic: BY5PR12MB5558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB555872A35D28E984179FB2E3EA0E9@BY5PR12MB5558.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCiFgB1vdSyN1v1I/la5zCGlBrGSJT4gVcVnKr9FeDrQFdC3PyQdw43Fwqg0CCQrNYq0O6v1jP0rkUBiUp4yMrGmT1HPbbLGI8yCD+iKq1Ovs6M/Ez63dq9O9dj96oqFNuGGZUpIX06n36YkXeEPKmNeyljOVSc+1W+8o4R/hZgMiHg8Eb+/JWv4tX16bPReIX5SQsMAYdcO04mUoXVc5wWjKkmwi9XMOwxrpaT6XP2rJ1E4Q9VXNQqoCL5/PGs128bmujaj1inPHGhiKKFIRwCjJ9LO7o9ceOOd42Sl1TUDQONdCci8GXR1r+qoXICLLTYfcgE7HNsbVboXcoBbsIhFQ2TJPpf4FpBFBNZLwcGrxRftrdwFTH9RbTIgPhNrxxfMwyEVI2h5BcVSbANHmpyrWg3BXU1TlUXBlTSUoZag0iZBNriHFyj106BLN70Ro1RGhKjcJqx8O2tl6J7ZZA4EjYuBp/4tPET7pFY1WxXe+TR8ER9vvDvbgbELszls08jNBckYDu6l23NuFGnyN/EUvqL7o3z2BM9EumjUdx9CycY2icHYfn3yZAAAASxTLXH04VEm45C2JJ9pcYTh9pcL4E6qVYCjHfS/hQlWvNjxzNc4rf7tHtaqo+WYPfjybECWUauHf/lBO0OKoP5TJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(86362001)(478600001)(45080400002)(76116006)(52536014)(110136005)(2906002)(8676002)(966005)(55016002)(8936002)(4326008)(9686003)(5660300002)(71200400001)(54906003)(316002)(66556008)(66446008)(66946007)(66476007)(64756008)(186003)(38100700002)(122000001)(26005)(33656002)(83380400001)(6506007)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LPSmbI3EuJBihBiXtfELGjMRji8NVxcuHqk0HCl+jjeX3of8S+NbYMVpXD?=
 =?iso-8859-1?Q?wD59yRKYAzKwCmEUffknLeqnYh0ku+niQyqsmuCbydIjQ5jyRpGMWkolkS?=
 =?iso-8859-1?Q?bLVWm6FfMEaFx64oKKEqHfsXQQJc1duLsCFPbBkT0E6AvdusQdeCzKsGAb?=
 =?iso-8859-1?Q?Vpcxc8Ksh98ra4bEC9ZIOuVV3+4zPNaqlCyTDat7VDtU//yCeYvJgQaRoz?=
 =?iso-8859-1?Q?EZHTEhUhGAmDsGU/x9qHSZpKllKnEvlrFFV+4Cfxg8t+m+CAVdDWXpXwFw?=
 =?iso-8859-1?Q?NG9Ql0Z8zPYs/SddGjErwwosajTgIpvg+5gkhBW9fG1kNNo8DbJSjKrZ/s?=
 =?iso-8859-1?Q?+NDWgMx9La0QU8WtKjBY7/VlfUNLWYDpTzoX3DDRwHQ9Yd30iRe7w8op6y?=
 =?iso-8859-1?Q?m3rEyaP4jDHyUogIluQReKMajgQbuPE+Pk9YIjEgIzJUUdnpYJ1xc0mNPd?=
 =?iso-8859-1?Q?FCeWYONzcPvKOfk0f1/49ptKNKxjXEJ6Mg/yS6KvwbyemXVEG1e6nBYYHU?=
 =?iso-8859-1?Q?BGHWqGgMnBPMlxPlEOZtMhXpLOTAgLcOl6RvCJlKTCcpIa36FaDtf9pzT8?=
 =?iso-8859-1?Q?KLkqBaw31aZiTVLHFEgstjo8QMKcYwr3Pn8odo6A4QdoQpjAz5H21mXORp?=
 =?iso-8859-1?Q?4uyibi8Yf/Y09roSo7jjsx63rCglZReh4/rWON7bnVUgn5IUMU0ULK5BbI?=
 =?iso-8859-1?Q?DVSyH51YZIZ8A97sk5gJ4+zQVFha99yAWlXHKKGFG6e/b6JC0Vd7lA3D+a?=
 =?iso-8859-1?Q?pqon/21d/ZIdSwIkEseUinlW/bZS9QmrC7biB+y5u3tKn7qeTWXPorViUZ?=
 =?iso-8859-1?Q?5MzybDc1i9LJ4xbj1VvGcPZdGqFw6DKd+KE4NSD2k06pGyPfocMKSJXtdR?=
 =?iso-8859-1?Q?1VvYcBsSYRFgNY9F68R6i3KvnN3AKyZN5EObFd2o+ljC4sqxCCqu0It7gF?=
 =?iso-8859-1?Q?xXlww0KBU0PfYWsXk0MhoqdqH5cCaR9P/6jfNuEMlMsLiPUnbD8TZ5o0QD?=
 =?iso-8859-1?Q?gQQ32OnsOkVPAmu4ighilbE1Nwmpr9zOAR+rjXAckDlCj16uzqy2ok64oy?=
 =?iso-8859-1?Q?DypHItx+LYNU/LITjlW+vIFxLGyEuImyorGF96NFeJ5XYobAl8OfgRM/my?=
 =?iso-8859-1?Q?7c2yU6/GHxfqZG+XbAxtMDgEuZK5qTdIJX3qsS5eF7Ed61b1JEmSpGBy9m?=
 =?iso-8859-1?Q?A6sPkHm1xh57GpofeES4puEJYs+NjgsWLrchzmiuPYHgnUBstSQZYZ0KTk?=
 =?iso-8859-1?Q?Ibh4SRe5bR1bKXyUBvHoe1jvqQLkKSN6RnQBgxmcOeUQ3agFoO+jq7M4GW?=
 =?iso-8859-1?Q?gvVHDAgEn2d2fY7w14FUUtOtV/fo8fsk2bFKD8nMSAzO2/t5oSAX+rOWqJ?=
 =?iso-8859-1?Q?2XHoE8hHJe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d9c78c-e0bb-4e21-aae5-08d9313cc36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 03:05:29.4215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyPLsATvR+nEjJf40HqQG878N9dCxZvqASVzG2g54/5ej6W3IOcGAz7ZFP1QdeXxbGn7i+fl512uO9OPK+vAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5558
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

BTW, there is an obvious typo in the subject, Walk thorugh => Walk through.

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Thursday, June 17, 2021 7:09 AM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: Walk thorugh list with dqm lock hold

On 2021-06-16 4:35 a.m., xinhui pan wrote:
> To avoid any list corruption.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c24ab8f17eb6..1f84de861ec6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1704,7 +1704,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>               struct qcm_process_device *qpd)
>   {
>       int retval;
> -     struct queue *q, *next;
> +     struct queue *q;
>       struct kernel_queue *kq, *kq_next;
>       struct mqd_manager *mqd_mgr;
>       struct device_process_node *cur, *next_dpn; @@ -1739,8 +1739,6 @@
> static int process_termination_cpsch(struct device_queue_manager *dqm,
>                               qpd->mapped_gws_queue = false;
>                       }
>               }
> -
> -             dqm->total_queue_count--;

I think this should stay here. This is only used to check the maximum user queue limit per-device, which is a HW limitation. As far as the HW is concerned, the queues are destroyed after the call to execute_queues_cpsch. So there is no need to delay this update.


>       }
>
>       /* Unregister process */
> @@ -1772,13 +1770,19 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>       /* Lastly, free mqd resources.
>        * Do free_mqd() after dqm_unlock to avoid circular locking.
>        */
> -     list_for_each_entry_safe(q, next, &qpd->queues_list, list) {
> +     dqm_lock(dqm);

Instead of taking the dqm lock again, just move this up a couple of lines before the dqm_unlock call.

Regards,
   Felix


> +     while (!list_empty(&qpd->queues_list)) {
> +             q = list_first_entry(&qpd->queues_list, struct queue, list);
>               mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>                               q->properties.type)];
>               list_del(&q->list);
>               qpd->queue_count--;
> +             dqm->total_queue_count--;
> +             dqm_unlock(dqm);
>               mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
> +             dqm_lock(dqm);
>       }
> +     dqm_unlock(dqm);
>
>       return retval;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C47251235ca70449c924608d9311bc4ce%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637594817623083340%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=h%2FzO6DHA%2F6%2Btw0iJp4aBFfw8KZPVgtmgkfj3VQho4pM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
