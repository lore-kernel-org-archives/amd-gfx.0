Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FAFC35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 17:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B90E20732
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 17:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H+706ToO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B90E20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5274B6EB4D;
	Tue, 25 Feb 2020 17:12:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680053.outbound.protection.outlook.com [40.107.68.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55086EB4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 17:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8oX95x/7xFVeT4titPhovZoWr6AuRCBU9yWh7zWR9gw1XeL3OP4UsEZk8tRC93evUzPzf/gKMRUaOhKCYDzXiOG+X2NE02H5scAjqDzJl7WWnLhSBlsJW3cVZzAz2C6z+xV0qxDHxGodI8PwAqUTjwszloqUenxuNcTbQd9M9s1wqGx7xPCFHx3X8ZCVjWgnhS802rSLYsMHcE9czia1K+ovrQV4sa+dprthFr6fRskFoONbCvHfm6iH6gkfvox405eez7rySf+Cwc+b9gDtbYu4sTe2r5CdNxA49dhyneU1lFyp1WYCcbdWW5xwlSxsZ1x0HRgGvcHYgE0R1yUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0qChZLTPWU+s1QS3rWYA0naSp1RH1vx8CcddvA/MGM=;
 b=Q0KX/XVmdJmVIIgIgNf09lEJs175NF4n93YwCIHoERErAVIBQaL4fBhJRYOIMwcPgp6lxnJlSn5yUTHgWrcx34s+q8amzbDl0Vb+R7tzIpQM2K+wsIapNEAkYVdKh0OzPMEhJ/xMcjhGAWi0qo9MW5OZHDbz6jcuqgpVWrVbT8ENKRpVoSTORSb0ocL3VeFutcoSWdBV6trlm//q1jOidDQq+l0wixZfq1PEZ6uOhew/+vvfIR0AQGWvLhRzzipNPr+zYnEf3dtNcxvaz99+D8hfXpjnj7ZvoWf146DZo+x5u4wzg3V22Yv5NxqWcC1hzyQ4VdMVWEeMsEg5nzBxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0qChZLTPWU+s1QS3rWYA0naSp1RH1vx8CcddvA/MGM=;
 b=H+706ToOU7pWIUXW0Mwyu5+Wne1PaObOuZzZnjHH5IKTSbi/oVDk1BaGBClHcPdqby1D9qU9al4C4dKaE0AB44xakydl7ccLzsj0iTcsl/4ArPhHF51Vlgc7eJlubhhTDS7Zy4kV633+ZMoHgNnIOGw0e3nPNqg0TpVbpsS2F/U=
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3861.namprd12.prod.outlook.com (2603:10b6:610:2a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 17:12:12 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:12:12 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package
 submissions
Thread-Topic: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package
 submissions
Thread-Index: AQHV62BpivWObPlALkO2AYIrtH3vragsJQkAgAAAnX0=
Date: Tue, 25 Feb 2020 17:12:12 +0000
Message-ID: <CH2PR12MB3926227A6166B79BC89741B9F0ED0@CH2PR12MB3926.namprd12.prod.outlook.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
 <20200224221842.14110-6-Yong.Zhao@amd.com>,
 <f99701ac-37e0-def4-4a58-bc1f24bb28d5@amd.com>
In-Reply-To: <f99701ac-37e0-def4-4a58-bc1f24bb28d5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-25T17:12:08.345Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5788fe5-d582-48d7-84f4-08d7ba15dab3
x-ms-traffictypediagnostic: CH2PR12MB3861:|CH2PR12MB3861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB386104C8A7E8FEA08BA7F41FF0ED0@CH2PR12MB3861.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(478600001)(30864003)(52536014)(8676002)(8936002)(66476007)(81156014)(71200400001)(7696005)(5660300002)(81166006)(2906002)(91956017)(26005)(66556008)(55016002)(66946007)(110136005)(86362001)(9686003)(64756008)(186003)(53546011)(316002)(33656002)(76116006)(66446008)(19627405001)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3861;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 353FMcwyEdK0nzfupvsopybkoYcEzUCHPhHD0cElEMovqY+xgAX5zOzvANNbyt2BFwo8lXcO6W1h2eN1JaJFi6fn+0sihS92hIo5gTih28w8ArAAs9HXv3fa70oq+NcQ4GJ4F9SjJW2v1nDdiLOEfC6CT0Lj1/Pwqa0+pzZhD/pe81lMEP966ldHV1uIOkaUziICTHLvBCHnO/lZPEAuNkYVQ2YVWBSttLU9xvtM12hnoZto05QPUQXB6CdoCz2f5BR3hP4QtbnclgOOqm2nOTJ+uIhswO75B9I3aI28bVN0JzmW+J3Fwh9rb7uE6VGtlgIwbqRp0eJZJOJ7oHWXKaE+KCFksSb8J0P71OcxyoahbFuLR7bog8ZH2j3fLLm9r031sl+i0Da2mwSwYYfyCvnS1HHCV0MzQd4Cky2vsON3mtnsEYZs7HpFRdHVFNxt
x-ms-exchange-antispam-messagedata: glXZc0DPeCkzmlxG3ycfZlyLCKMyYGJs8Pwrzn3zDHEV1q6ZsSSZtvnmdMxUoMGaVnMZ3MDswZd9HLbWxfyNyqaPskIgZJRzMEVBVN3cTKQIv8MVg3JN5RvtEaA6iTMV8iqJD/u5aVUT5Fiy2KdNEA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5788fe5-d582-48d7-84f4-08d7ba15dab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 17:12:12.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIQfy9J+o405kDEXjNA994Kpm9B3XhRTWlRy1cR45XUye9K3v7zMpOR/LTXoa2iy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3861
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
Content-Type: multipart/mixed; boundary="===============0502067495=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0502067495==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3926227A6166B79BC89741B9F0ED0CH2PR12MB3926namp_"

--_000_CH2PR12MB3926227A6166B79BC89741B9F0ED0CH2PR12MB3926namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks! I will update the commit message before pushing. It should be the w=
ay how SDMA queue count were used to unmap SDMA engines according to the pr=
evious understanding was wrong.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, February 25, 2020 12:06 PM
To: Zhao, Yong <Yong.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package=
 submissions

As I understand it, the SDMA queue counting wasn't incorrect. The main
change here is that you no longer send separate unmap packets for SDMA
queues, and that makes SDMA queue counting unnecessary.

That said, this patch series is a nice cleanup and improvement. The
series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

On 2020-02-24 17:18, Yong Zhao wrote:
> The previous SDMA queue counting was wrong. In addition, after confirming
> with MEC firmware team, we understands that only one unmap queue package,
> instead of one unmap queue package for CP and each SDMA engine, is needed=
,
> which results in much simpler driver code.
>
> Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++-------------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 -
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++--
>   3 files changed, 29 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 958275db3f55..692abfd2088a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -109,6 +109,11 @@ static unsigned int get_num_xgmi_sdma_engines(struct=
 device_queue_manager *dqm)
>        return dqm->dev->device_info->num_xgmi_sdma_engines;
>   }
>
> +static unsigned int get_num_all_sdma_engines(struct device_queue_manager=
 *dqm)
> +{
> +     return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
> +}
> +
>   unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
>   {
>        return dqm->dev->device_info->num_sdma_engines
> @@ -375,11 +380,6 @@ static int create_queue_nocpsch(struct device_queue_=
manager *dqm,
>        if (q->properties.is_active)
>                increment_queue_count(dqm, q->properties.type);
>
> -     if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
> -             dqm->sdma_queue_count++;
> -     else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
> -             dqm->xgmi_sdma_queue_count++;
> -
>        /*
>         * Unconditionally increment this counter, regardless of the queue=
's
>         * type or whether the queue is active.
> @@ -460,15 +460,13 @@ static int destroy_queue_nocpsch_locked(struct devi=
ce_queue_manager *dqm,
>        mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>                        q->properties.type)];
>
> -     if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
> +     if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
>                deallocate_hqd(dqm, q);
> -     } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
> -             dqm->sdma_queue_count--;
> +     else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
>                deallocate_sdma_queue(dqm, q);
> -     } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
> -             dqm->xgmi_sdma_queue_count--;
> +     else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
>                deallocate_sdma_queue(dqm, q);
> -     } else {
> +     else {
>                pr_debug("q->properties.type %d is invalid\n",
>                                q->properties.type);
>                return -EINVAL;
> @@ -915,8 +913,6 @@ static int initialize_nocpsch(struct device_queue_man=
ager *dqm)
>        INIT_LIST_HEAD(&dqm->queues);
>        dqm->active_queue_count =3D dqm->next_pipe_to_allocate =3D 0;
>        dqm->active_cp_queue_count =3D 0;
> -     dqm->sdma_queue_count =3D 0;
> -     dqm->xgmi_sdma_queue_count =3D 0;
>
>        for (pipe =3D 0; pipe < get_pipes_per_mec(dqm); pipe++) {
>                int pipe_offset =3D pipe * get_queues_per_pipe(dqm);
> @@ -981,8 +977,11 @@ static int allocate_sdma_queue(struct device_queue_m=
anager *dqm,
>        int bit;
>
>        if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
> -             if (dqm->sdma_bitmap =3D=3D 0)
> +             if (dqm->sdma_bitmap =3D=3D 0) {
> +                     pr_err("No more SDMA queue to allocate\n");
>                        return -ENOMEM;
> +             }
> +
>                bit =3D __ffs64(dqm->sdma_bitmap);
>                dqm->sdma_bitmap &=3D ~(1ULL << bit);
>                q->sdma_id =3D bit;
> @@ -991,8 +990,10 @@ static int allocate_sdma_queue(struct device_queue_m=
anager *dqm,
>                q->properties.sdma_queue_id =3D q->sdma_id /
>                                get_num_sdma_engines(dqm);
>        } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
> -             if (dqm->xgmi_sdma_bitmap =3D=3D 0)
> +             if (dqm->xgmi_sdma_bitmap =3D=3D 0) {
> +                     pr_err("No more XGMI SDMA queue to allocate\n");
>                        return -ENOMEM;
> +             }
>                bit =3D __ffs64(dqm->xgmi_sdma_bitmap);
>                dqm->xgmi_sdma_bitmap &=3D ~(1ULL << bit);
>                q->sdma_id =3D bit;
> @@ -1081,8 +1082,7 @@ static int initialize_cpsch(struct device_queue_man=
ager *dqm)
>        INIT_LIST_HEAD(&dqm->queues);
>        dqm->active_queue_count =3D dqm->processes_count =3D 0;
>        dqm->active_cp_queue_count =3D 0;
> -     dqm->sdma_queue_count =3D 0;
> -     dqm->xgmi_sdma_queue_count =3D 0;
> +
>        dqm->active_runlist =3D false;
>        dqm->sdma_bitmap =3D ~0ULL >> (64 - get_num_sdma_queues(dqm));
>        dqm->xgmi_sdma_bitmap =3D ~0ULL >> (64 - get_num_xgmi_sdma_queues(=
dqm));
> @@ -1254,11 +1254,6 @@ static int create_queue_cpsch(struct device_queue_=
manager *dqm, struct queue *q,
>        list_add(&q->list, &qpd->queues_list);
>        qpd->queue_count++;
>
> -     if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
> -             dqm->sdma_queue_count++;
> -     else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
> -             dqm->xgmi_sdma_queue_count++;
> -
>        if (q->properties.is_active) {
>                increment_queue_count(dqm, q->properties.type);
>
> @@ -1315,20 +1310,6 @@ int amdkfd_fence_wait_timeout(unsigned int *fence_=
addr,
>        return 0;
>   }
>
> -static int unmap_sdma_queues(struct device_queue_manager *dqm)
> -{
> -     int i, retval =3D 0;
> -
> -     for (i =3D 0; i < dqm->dev->device_info->num_sdma_engines +
> -             dqm->dev->device_info->num_xgmi_sdma_engines; i++) {
> -             retval =3D pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYP=
E_SDMA,
> -                     KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i=
);
> -             if (retval)
> -                     return retval;
> -     }
> -     return retval;
> -}
> -
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int map_queues_cpsch(struct device_queue_manager *dqm)
>   {
> @@ -1366,12 +1347,6 @@ static int unmap_queues_cpsch(struct device_queue_=
manager *dqm,
>        if (!dqm->active_runlist)
>                return retval;
>
> -     pr_debug("Before destroying queues, sdma queue count is : %u, xgmi =
sdma queue count is : %u\n",
> -             dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
> -
> -     if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
> -             unmap_sdma_queues(dqm);
> -
>        retval =3D pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPU=
TE,
>                        filter, filter_param, false, 0);
>        if (retval)
> @@ -1444,13 +1419,10 @@ static int destroy_queue_cpsch(struct device_queu=
e_manager *dqm,
>
>        deallocate_doorbell(qpd, q);
>
> -     if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
> -             dqm->sdma_queue_count--;
> +     if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
>                deallocate_sdma_queue(dqm, q);
> -     } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
> -             dqm->xgmi_sdma_queue_count--;
> +     else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
>                deallocate_sdma_queue(dqm, q);
> -     }
>
>        list_del(&q->list);
>        qpd->queue_count--;
> @@ -1673,13 +1645,10 @@ static int process_termination_cpsch(struct devic=
e_queue_manager *dqm,
>
>        /* Clear all user mode queues */
>        list_for_each_entry(q, &qpd->queues_list, list) {
> -             if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
> -                     dqm->sdma_queue_count--;
> +             if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)
>                        deallocate_sdma_queue(dqm, q);
> -             } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XG=
MI) {
> -                     dqm->xgmi_sdma_queue_count--;
> +             else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI=
)
>                        deallocate_sdma_queue(dqm, q);
> -             }
>
>                if (q->properties.is_active)
>                        decrement_queue_count(dqm, q->properties.type);
> @@ -1759,8 +1728,7 @@ static int allocate_hiq_sdma_mqd(struct device_queu=
e_manager *dqm)
>        struct kfd_dev *dev =3D dqm->dev;
>        struct kfd_mem_obj *mem_obj =3D &dqm->hiq_sdma_mqd;
>        uint32_t size =3D dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
> -             (dev->device_info->num_sdma_engines +
> -             dev->device_info->num_xgmi_sdma_engines) *
> +             get_num_all_sdma_engines(dqm) *
>                dev->device_info->num_sdma_queues_per_engine +
>                dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
>
> @@ -2012,8 +1980,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data=
)
>                }
>        }
>
> -     for (pipe =3D 0; pipe < get_num_sdma_engines(dqm) +
> -                     get_num_xgmi_sdma_engines(dqm); pipe++) {
> +     for (pipe =3D 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
>                for (queue =3D 0;
>                     queue < dqm->dev->device_info->num_sdma_queues_per_en=
gine;
>                     queue++) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 05e0afc04cd9..50d919f814e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -182,8 +182,6 @@ struct device_queue_manager {
>        unsigned int            processes_count;
>        unsigned int            active_queue_count;
>        unsigned int            active_cp_queue_count;
> -     unsigned int            sdma_queue_count;
> -     unsigned int            xgmi_sdma_queue_count;
>        unsigned int            total_queue_count;
>        unsigned int            next_pipe_to_allocate;
>        unsigned int            *allocated_queues;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 3bfa5c8d9654..eb1635ac8988 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -241,16 +241,12 @@ int pqm_create_queue(struct process_queue_manager *=
pqm,
>        switch (type) {
>        case KFD_QUEUE_TYPE_SDMA:
>        case KFD_QUEUE_TYPE_SDMA_XGMI:
> -             if ((type =3D=3D KFD_QUEUE_TYPE_SDMA && dev->dqm->sdma_queu=
e_count
> -                     >=3D get_num_sdma_queues(dev->dqm)) ||
> -                     (type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI &&
> -                     dev->dqm->xgmi_sdma_queue_count
> -                     >=3D get_num_xgmi_sdma_queues(dev->dqm))) {
> -                     pr_debug("Over-subscription is not allowed for SDMA=
.\n");
> -                     retval =3D -EPERM;
> -                     goto err_create_queue;
> -             }
> -
> +             /* SDMA queues are always allocated statically no matter
> +              * which scheduler mode is used. We also do not need to
> +              * check whether a SDMA queue can be allocated here, becaus=
e
> +              * allocate_sdma_queue() in create_queue() has the
> +              * corresponding check logic.
> +              */
>                retval =3D init_user_queue(pqm, dev, &q, properties, f, *q=
id);
>                if (retval !=3D 0)
>                        goto err_create_queue;

--_000_CH2PR12MB3926227A6166B79BC89741B9F0ED0CH2PR12MB3926namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks! I will update the commit message before pushing. It should be the w=
ay how SDMA queue count were used to unmap SDMA engines according to the pr=
evious understanding was wrong.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 25, 2020 12:06 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue =
package submissions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As I understand it, the SDMA queue counting wasn't=
 incorrect. The main
<br>
change here is that you no longer send separate unmap packets for SDMA <br>
queues, and that makes SDMA queue counting unnecessary.<br>
<br>
That said, this patch series is a nice cleanup and improvement. The <br>
series is<br>
<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
On 2020-02-24 17:18, Yong Zhao wrote:<br>
&gt; The previous SDMA queue counting was wrong. In addition, after confirm=
ing<br>
&gt; with MEC firmware team, we understands that only one unmap queue packa=
ge,<br>
&gt; instead of one unmap queue package for CP and each SDMA engine, is nee=
ded,<br>
&gt; which results in much simpler driver code.<br>
&gt;<br>
&gt; Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 &#43;&#=
43;&#43;&#43;&#43;&#43;-------------<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.h |&nbsp; 2 -<=
br>
&gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbs=
p; | 16 &#43;&#43;--<br>
&gt;&nbsp;&nbsp; 3 files changed, 29 insertions(&#43;), 68 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index 958275db3f55..692abfd2088a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c<br>
&gt; @@ -109,6 &#43;109,11 @@ static unsigned int get_num_xgmi_sdma_engines=
(struct device_queue_manager *dqm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dqm-&gt;dev-&gt;devic=
e_info-&gt;num_xgmi_sdma_engines;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static unsigned int get_num_all_sdma_engines(struct device_queue_=
manager *dqm)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return get_num_sdma_engines(dqm) &#43; g=
et_num_xgmi_sdma_engines(dqm);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; unsigned int get_num_sdma_queues(struct device_queue_manag=
er *dqm)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dqm-&gt;dev-&gt;devic=
e_info-&gt;num_sdma_engines<br>
&gt; @@ -375,11 &#43;380,6 @@ static int create_queue_nocpsch(struct device=
_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, q-&gt;properties.type);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_T=
YPE_SDMA)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;sdma_queue_count&#43;&#43;;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D KFD_QU=
EUE_TYPE_SDMA_XGMI)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;xgmi_sdma_queue_count&#43;&#43;;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unconditionally incr=
ement this counter, regardless of the queue's<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * type or whether the =
queue is active.<br>
&gt; @@ -460,15 &#43;460,13 @@ static int destroy_queue_nocpsch_locked(stru=
ct device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs=
[get_mqd_type_from_queue_type(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;p=
roperties.type)];<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_T=
YPE_COMPUTE) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUE=
UE_TYPE_COMPUTE)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; deallocate_hqd(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;sdma_queue_count--;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D KF=
D_QUEUE_TYPE_SDMA)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA_XGMI) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;xgmi_sdma_queue_count--;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D KF=
D_QUEUE_TYPE_SDMA_XGMI)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_debug(&quot;q-&gt;properties.type %d is invalid\n&qu=
ot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; @@ -915,8 &#43;913,6 @@ static int initialize_nocpsch(struct device_qu=
eue_manager *dqm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;dqm-&gt;=
queues);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_queue_count =
=3D dqm-&gt;next_pipe_to_allocate =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_cp_queue_coun=
t =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_queue_count =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; g=
et_pipes_per_mec(dqm); pipe&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; int pipe_offset =3D pipe * get_queues_per_pipe(dqm);<br=
>
&gt; @@ -981,8 &#43;977,11 @@ static int allocate_sdma_queue(struct device_=
queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bit;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =
=3D=3D KFD_QUEUE_TYPE_SDMA) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (dqm-&gt;sdma_bitmap =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (dqm-&gt;sdma_bitmap =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;No mor=
e SDMA queue to allocate\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bit =3D __ffs64(dqm-&gt;sdma_bitmap);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_bitmap &amp;=3D ~(1ULL &lt;&lt; bit);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;sdma_id =3D bit;<br>
&gt; @@ -991,8 &#43;990,10 @@ static int allocate_sdma_queue(struct device_=
queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;properties.sdma_queue_id =3D q-&gt;sdma_id /<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_num_sdma_engines(dqm);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.=
type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (dqm-&gt;xgmi_sdma_bitmap =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (dqm-&gt;xgmi_sdma_bitmap =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;No mor=
e XGMI SDMA queue to allocate\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bit =3D __ffs64(dqm-&gt;xgmi_sdma_bitmap);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_bitmap &amp;=3D ~(1ULL &lt;&lt; bit);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; q-&gt;sdma_id =3D bit;<br>
&gt; @@ -1081,8 &#43;1082,7 @@ static int initialize_cpsch(struct device_qu=
eue_manager *dqm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;dqm-&gt;=
queues);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_queue_count =
=3D dqm-&gt;processes_count =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_cp_queue_coun=
t =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_queue_count =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_queue_count =3D 0;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;active_runlist =3D f=
alse;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_bitmap =3D ~0UL=
L &gt;&gt; (64 - get_num_sdma_queues(dqm));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_bitmap =3D=
 ~0ULL &gt;&gt; (64 - get_num_xgmi_sdma_queues(dqm));<br>
&gt; @@ -1254,11 &#43;1254,6 @@ static int create_queue_cpsch(struct device=
_queue_manager *dqm, struct queue *q,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, &a=
mp;qpd-&gt;queues_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count&#43;&#43=
;;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_T=
YPE_SDMA)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;sdma_queue_count&#43;&#43;;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D KFD_QU=
EUE_TYPE_SDMA_XGMI)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;xgmi_sdma_queue_count&#43;&#43;;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_acti=
ve) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, q-&gt;properties.type);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -1315,20 &#43;1310,6 @@ int amdkfd_fence_wait_timeout(unsigned int =
*fence_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static int unmap_sdma_queues(struct device_queue_manager *dqm)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i, retval =3D 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dqm-&gt;dev-&gt;device_=
info-&gt;num_sdma_engines &#43;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;dev-&gt;device_info-&gt;num_xgmi_sdma_engines; i&#43;&#43;) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D pm_send_unmap_queue(&amp;dqm-&gt;packets, KFD_QUEUE_TYPE_SDM=
A,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_UNMAP_QUEUES_FILTER=
_DYNAMIC_QUEUES, 0, false, i);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (retval)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; /* dqm-&gt;lock mutex has to be locked before calling this=
 function */<br>
&gt;&nbsp;&nbsp; static int map_queues_cpsch(struct device_queue_manager *d=
qm)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -1366,12 &#43;1347,6 @@ static int unmap_queues_cpsch(struct device=
_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;active_runlist)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Before destroying queues, sdm=
a queue count is : %u, xgmi sdma queue count is : %u\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;sdma_queue_count, dqm-&gt;xgmi_sdma_queue_count);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;sdma_queue_count &gt; 0 || dqm-&=
gt;xgmi_sdma_queue_count)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unmap_sdma_queues(dqm);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D pm_send_unmap_que=
ue(&amp;dqm-&gt;packets, KFD_QUEUE_TYPE_COMPUTE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; filter,=
 filter_param, false, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&gt; @@ -1444,13 &#43;1419,10 @@ static int destroy_queue_cpsch(struct devi=
ce_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deallocate_doorbell(qpd, q);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_T=
YPE_SDMA) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;sdma_queue_count--;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUE=
UE_TYPE_SDMA)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA_XGMI) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dqm-&gt;xgmi_sdma_queue_count--;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (q-&gt;properties.type =3D=3D KF=
D_QUEUE_TYPE_SDMA_XGMI)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count--;<br>
&gt; @@ -1673,13 &#43;1645,10 @@ static int process_termination_cpsch(struc=
t device_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear all user mode queue=
s */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q, &amp;=
qpd-&gt;queues_list, list) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;sdma_queue_coun=
t--;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dealloc=
ate_sdma_queue(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;xgmi_sdma_queue=
_count--;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dealloc=
ate_sdma_queue(dqm, q);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decreme=
nt_queue_count(dqm, q-&gt;properties.type);<br>
&gt; @@ -1759,8 &#43;1728,7 @@ static int allocate_hiq_sdma_mqd(struct devi=
ce_queue_manager *dqm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D dqm-=
&gt;dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mem_obj =
=3D &amp;dqm-&gt;hiq_sdma_mqd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D dqm-&gt;mq=
d_mgrs[KFD_MQD_TYPE_SDMA]-&gt;mqd_size *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (dev-&gt;device_info-&gt;num_sdma_engines &#43;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev-&gt;device_info-&gt;num_xgmi_sdma_engines) *<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; get_num_all_sdma_engines(dqm) *<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev-&gt;device_info-&gt;num_sdma_queues_per_engine &#43=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_HIQ]-&gt;mqd_size;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -2012,8 &#43;1980,7 @@ int dqm_debugfs_hqds(struct seq_file *m, voi=
d *data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; get_num_sdma_engi=
nes(dqm) &#43;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_num_xgmi_sdma_engin=
es(dqm); pipe&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; get_num_all_s=
dma_engines(dqm); pipe&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (queue =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue &lt; dqm-&gt;dev-&g=
t;device_info-&gt;num_sdma_queues_per_engine;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue&#43;&#43;) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
&gt; index 05e0afc04cd9..50d919f814e9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
h<br>
&gt; @@ -182,8 &#43;182,6 @@ struct device_queue_manager {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processes_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_queue_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_cp_queue_count;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_queue_count;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_sdma_queue_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_queue_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_pipe_to_allocate;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *allocated_queues;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
&gt; index 3bfa5c8d9654..eb1635ac8988 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager=
.c<br>
&gt; @@ -241,16 &#43;241,12 @@ int pqm_create_queue(struct process_queue_ma=
nager *pqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA:<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA_XGM=
I:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((type =3D=3D KFD_QUEUE_TYPE_SDMA &amp;&amp; dev-&gt;dqm-&gt;sdma_qu=
eue_count<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;=3D get_num_sdma_qu=
eues(dev-&gt;dqm)) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (type =3D=3D KFD_QUEUE_=
TYPE_SDMA_XGMI &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;dqm-&gt;xgmi_sd=
ma_queue_count<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;=3D get_num_xgmi_sd=
ma_queues(dev-&gt;dqm))) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Over-sub=
scription is not allowed for SDMA.\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EPERM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_create_queue;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* SDMA queues are always allocated statically no matter<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * which scheduler mode is used. We also do not need to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * check whether a SDMA queue can be allocated here, because<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * allocate_sdma_queue() in create_queue() has the<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * corresponding check logic.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; retval =3D init_user_queue(pqm, dev, &amp;q, properties=
, f, *qid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (retval !=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r_create_queue;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3926227A6166B79BC89741B9F0ED0CH2PR12MB3926namp_--

--===============0502067495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0502067495==--
