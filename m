Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4016DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 17:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CAC64E39
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 17:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CAC64E39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A476EE9F;
	Fri, 12 Feb 2021 17:01:13 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD256E1D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 17:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNHiaWbbemea1UqS2FK6/rclc9TqV41USCKU+m3qbKtzeysjrc5kZauKPy1zF9Edn9klQPY4EdGybhAQ66UFMqWlQGJF3XbUjZELglgseccl/8HumnfK5g2WF97jcgy3wjm2QgEiAwkhYWYzcnFhHyqV1lrwizUscNccxad7WxcsGOf2UKChtqlqxGnFyXQeow+6NpG8cT5DcQhqnSW1CupOkduh0E6maGLms2D+Zt0m+umUi3rSfgWX8r8iXDy3fOumUouQ3wi1NtEbXuTmcIW5n397qsoTl+mNlOrVYFuU9aby59+Q+fl8gm49931NSoHOndmJ+QLF7ywSOMTTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7UGrbnExUquMU+3cd9ieeaSt40IRAQ7GpIARokMJvo=;
 b=GhPOz2/oFZBqiBC8az64vRHllJ1qvy4LAnbDFU7ZgtdBNgKLuFhPc3ENaykCBSCf+1pMlqGQicTK0/l77Q66GleNKh3MiYl/T4IMqoPLx4cB7eM1soJ+sUNhiqjvLhhxyMhlcsb+1ShKbfmOEuQKgHihNVNEHyoe75RVw8/gcLqHGqe4S+ANuS/75FhyTADtHrV6wdDe/iAq6CRCfND/bYmLJHcXUxGVwnwFRwdy87suBvchlbv+g68Sb16ni0Uy8c8f4DW8f3iyLV8MDnbGMCeueZ9977tWvJCAE7ZeupXC5eyNGnBxD1YXLoUhkur1nGuTyIwoVhdvz+a/AP9+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7UGrbnExUquMU+3cd9ieeaSt40IRAQ7GpIARokMJvo=;
 b=WkOMyAeJVJAfKE54ah13tWd9f/QQJov+tfrxSI0OR6K8+SVMAOa9EHvXVPUMoTKDpP+/j1etbEKN6SQpwDw7JOjgXp7D40h3wUGCBzu/0+RVinRn1koZmKx/1x4+0H9nbuzPqXi5On+XaqCzxtA7FHIt2i3KZnlUxZ/sna7YOoA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3744.namprd12.prod.outlook.com (2603:10b6:208:166::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 12 Feb
 2021 17:01:10 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%6]) with mapi id 15.20.3846.031; Fri, 12 Feb 2021
 17:01:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu/display: remove hdcp_srm sysfs
Thread-Topic: [PATCH 1/1] drm/amdgpu/display: remove hdcp_srm sysfs
Thread-Index: AQHW/9E3ScFXdLZOu0WH6aH9RqwBa6pUwU+AgAAAPFU=
Date: Fri, 12 Feb 2021 17:01:09 +0000
Message-ID: <MN2PR12MB4488FAA069BAF6397AC7F3B7F78B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210210172134.121327-1-nirmoy.das@amd.com>,
 <ad0e03da-0d50-e262-cd4a-531980dbbdfc@amd.com>
In-Reply-To: <ad0e03da-0d50-e262-cd4a-531980dbbdfc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-12T17:01:09.239Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0cb3f28-e7a1-493e-1e6d-08d8cf77cbbd
x-ms-traffictypediagnostic: MN2PR12MB3744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB374478D03C2519BC7F52641EF78B9@MN2PR12MB3744.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:66;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7gPwbzNut6I/aeublEMiEpJDmpeQS1LA79m5P0jH8X/C4B5pfM7uLt1IZPmzygpKgacGDNeVUyUzNWoF9ySdd7QGMPt9igf3FDiWzZ57pY/Z8zb7usUylcUxD2WS0n1NT2WqdFDzWS3Z/K6O6ezapPZtZQ5imOVAHljJj/cjZJor9uBTSDsJ2QpFO9D2A2gWIaS1t5+N8EDtzu6YkWy6dbXqeGENU9eTdnxDNlQZf4fJ0GEFWoXJG0Sic/jDMtTxK+AJxytebdUIdy38r7JW1zKsiu9YvQqZBe9AQ8cQgHIchRTM8Vi8OQGXQWgx1nMbynUaUmmhI4h6hriR0npa1ei7LQ7A0kvDcb7V6jRVXDb28V0ZVf8WlIIJw99awFv3OleEliyWV7UJd063gjUXvX3iOO+MowHiQFz3Z72dIP/9q+eAFy+OiFmITJV8AhG4jhYuVfDHoZqeP3NQMndpOzkf0b0IvQLxEPE0P/fjhsijiVXi+r6OuV7vvNdpHsD1hjpXLUrV+c6zixdUzVFclzjN/Zq6hGJQ/IrTb3YH1bjUyx1bg2TN/cnuAGBzvYbl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(66446008)(66556008)(66946007)(26005)(64756008)(52536014)(186003)(55016002)(86362001)(66476007)(5660300002)(9686003)(76116006)(478600001)(45080400002)(166002)(19627405001)(33656002)(2906002)(83380400001)(966005)(8676002)(7696005)(71200400001)(8936002)(316002)(6506007)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7pAGibFlpGvaabWyZCoL4eDldBrb1Jsbx8bW6aNExKKs7+BQFgezs8w8YCW5?=
 =?us-ascii?Q?wH0TWX6KAsrvbzvzTY5hXz9N1oTuAWsBbFg4I1EsvwNj84Tw4cKRcs+4AlNT?=
 =?us-ascii?Q?/REhRp6w2f4CzGAVEwqvNKSD/IMWPkDHd1TVBsZN4YAHfHrCHPGmCsFl/zLE?=
 =?us-ascii?Q?/HUHv6CsQGE+2v1rHhL6TiA1y5hWE40Tk2NGPaBWmESOeHlC393Spf3UrMIU?=
 =?us-ascii?Q?AvE3ZH4g15vxn1HGn0nC1EWsHErjV3nMIy2foeXL4opjRvPtFDp0t5AF2tch?=
 =?us-ascii?Q?M+ruIcc80F9LnLyEh987JGTDVYz4lGwXYeThOV9q92Xf3DelS+HjqXo+N7Dt?=
 =?us-ascii?Q?bZ45NnUk5jLkt0GWA70gYDQQmpFSANredzqymFP8avxSYPT3EMy8APbDYwyM?=
 =?us-ascii?Q?S6Q0GAzrYpVryWhVgmlJvkGm5HlpbCUFyFTqAPzkq27J77x8gTUpePOr3Qlr?=
 =?us-ascii?Q?JAg8FdVCjWdeK1g/TfSPxU8koKKbGxAf8r4sd8yvHIVS+L7ygZON2/uT+Lhl?=
 =?us-ascii?Q?RBl5fnD01UmCm0HOr+mjm+IgDoYGsorU/fUGioBbGTkpqVdix6c2tG5IX7Ea?=
 =?us-ascii?Q?VXnLYMRDwDlfEZ3VLEEeMcIMHuf60R8qzvMR4ia8MdBThlXmfSSSTE+Qou1Y?=
 =?us-ascii?Q?66yF9G1utezzRpkAkYiNlB0mMZWoRo3EKfQAeb/jl1zBnbdsY2JaQi4Bk0rn?=
 =?us-ascii?Q?j9lhWkizcvLgoNiW2T/iL+qicpvtzRb/GBTZafDpaZIouNbARDkA1+Se2jlv?=
 =?us-ascii?Q?ucWnL47PO4B6yR+mn8OL+oXSuEk+ssph03X/W4WOwA8YRnLthLJJZn8oV29X?=
 =?us-ascii?Q?6vUWwM6awgL+/vclpuAzEzSc+rUZmeZ2LROAQw0C14e8ISVau+l4wVzt4ZlF?=
 =?us-ascii?Q?YtPXo1nCJZdLn1NrRPCXdfjsDH0hGA1D7VGirCtQBMY/0ejMWBc6lfKZGAWa?=
 =?us-ascii?Q?6btq5XTi6Gmxi1tAACp710/ju/87c7WML0Pri00WrzvkU6l/6NvH6DQYkTOu?=
 =?us-ascii?Q?OwSc3UZL8ktqLYPhdhdROJkDdN9HI71babbEe7GOYcW/GLnrlGnD1RNepXCb?=
 =?us-ascii?Q?QKwJ4wTMMZkz+ZWfdV9BGk59ZghKLgzjnWEU0IMU3mKuyXzBUc7q2gb46hlA?=
 =?us-ascii?Q?EBnU5jmhF7P+4qCbr+Cx7AJ6SI0pDx/0bTDe1YkNni9DzHt0+Az2Xalisn+p?=
 =?us-ascii?Q?T932txcxj5+Q5OQ6MiMQIFA7qjL2q8f/A2pXm91GrZayqeOoWasTdE6X1jPm?=
 =?us-ascii?Q?8Z6TDk/9i8Mc137NJKIjr2fZ6otyOMYlxAjCBs+XE6si2iUNpzUuz6x6KF7x?=
 =?us-ascii?Q?7qDIA0/3pNvg6v+XWp+2xlDL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cb3f28-e7a1-493e-1e6d-08d8cf77cbbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 17:01:09.7549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YwMhsXsXqFvlX6Y/IFqX2CC/vQ5yA8DQNGKKz2GVF/ryEpukXkwTTJw3kHVT4VGri5Bn5Aif2xrokkvmztnCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3744
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
Content-Type: multipart/mixed; boundary="===============0393149530=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0393149530==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FAA069BAF6397AC7F3B7F78B9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FAA069BAF6397AC7F3B7F78B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy <=
nirmodas@amd.com>
Sent: Friday, February 12, 2021 11:59 AM
To: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu/display: remove hdcp_srm sysfs

ping!

I should've added more info into the subject line :

s/remove hdcp_srm sysfs/remove hdcp_srm sysfs on device removal

Without this patch I get below error on second/later modprobes

[ 404.362298] sysfs: cannot create duplicate filename
'/devices/pci0000:00/0000:00:01.1/0000:10:00.0/0000:11:00.0/0000:12:00.0/hd=
cp_srm'



Regards,

Nirmoy

On 2/10/21 6:21 PM, Nirmoy Das wrote:
> Fixes: 9037246bb2da5 ("drm/amd/display: Add sysfs interface for set/get s=
rm")
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 ++-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h | 2 +-
>   3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 626a8cc92d65..083d75b747c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1128,7 +1128,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *ad=
ev)
>
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>        if (adev->dm.hdcp_workqueue) {
> -             hdcp_destroy(adev->dm.hdcp_workqueue);
> +             hdcp_destroy(&adev->dev->kobj, adev->dm.hdcp_workqueue);
>                adev->dm.hdcp_workqueue =3D NULL;
>        }
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index b297ddc24d3a..0cdbfcd475ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -376,7 +376,7 @@ static void event_cpirq(struct work_struct *work)
>   }
>
>
> -void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
> +void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work=
)
>   {
>        int i =3D 0;
>
> @@ -385,6 +385,7 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
>                cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwor=
k);
>        }
>
> +     sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
>        kfree(hdcp_work->srm);
>        kfree(hdcp_work->srm_temp);
>        kfree(hdcp_work);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> index 5159b3a5e5b0..09294ff122fe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> @@ -69,7 +69,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_wo=
rk,
>
>   void hdcp_reset_display(struct hdcp_workqueue *work, unsigned int link_=
index);
>   void hdcp_handle_cpirq(struct hdcp_workqueue *work, unsigned int link_i=
ndex);
> -void hdcp_destroy(struct hdcp_workqueue *work);
> +void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);
>
>   struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev=
, struct cp_psp *cp_psp, struct dc *dc);
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cf40303a3004b47d738b208d8cf77a0eb%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637487460023369776%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DQQJJm%2FfsnHj5kdltRjDv8Jd8qK8IYxEHleraMrXRuKY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488FAA069BAF6397AC7F3B7F78B9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy &lt;nirmodas@amd.com&g=
t;<br>
<b>Sent:</b> Friday, February 12, 2021 11:59 AM<br>
<b>To:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/1] drm/amdgpu/display: remove hdcp_srm sysfs</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">ping!<br>
<br>
I should've added more info into the subject line :<br>
<br>
s/remove hdcp_srm sysfs/remove hdcp_srm sysfs on device removal<br>
<br>
Without this patch I get below error on second/later modprobes<br>
<br>
[ 404.362298] sysfs: cannot create duplicate filename <br>
'/devices/pci0000:00/0000:00:01.1/0000:10:00.0/0000:11:00.0/0000:12:00.0/hd=
cp_srm'<br>
<br>
<br>
<br>
Regards,<br>
<br>
Nirmoy<br>
<br>
On 2/10/21 6:21 PM, Nirmoy Das wrote:<br>
&gt; Fixes: 9037246bb2da5 (&quot;drm/amd/display: Add sysfs interface for s=
et/get srm&quot;)<br>
&gt;<br>
&gt; Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3=
 ++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h | 2=
 +-<br>
&gt;&nbsp;&nbsp; 3 files changed, 4 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 626a8cc92d65..083d75b747c2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1128,7 +1128,7 @@ static void amdgpu_dm_fini(struct amdgpu_device =
*adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMD_DC_HDCP<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;dm.hdcp_workque=
ue) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hdcp_destroy(adev-&gt;dm.hdcp_workqueue);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hdcp_destroy(&amp;adev-&gt;dev-&gt;kobj, adev-&gt;dm.hdcp_workqueue);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;dm.hdcp_workqueue =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; index b297ddc24d3a..0cdbfcd475ec 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; @@ -376,7 +376,7 @@ static void event_cpirq(struct work_struct *work)<=
br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; <br>
&gt; -void hdcp_destroy(struct hdcp_workqueue *hdcp_work)<br>
&gt; +void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_w=
ork)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -385,6 +385,7 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;hdcp_work[i].watchdog_tim=
er_dwork);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_bin_file(kobj, &amp;hdcp_work[0=
].attr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hdcp_work-&gt;srm);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hdcp_work-&gt;srm_temp=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hdcp_work);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h<br>
&gt; index 5159b3a5e5b0..09294ff122fe 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h<br>
&gt; @@ -69,7 +69,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp=
_work,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void hdcp_reset_display(struct hdcp_workqueue *work, unsig=
ned int link_index);<br>
&gt;&nbsp;&nbsp; void hdcp_handle_cpirq(struct hdcp_workqueue *work, unsign=
ed int link_index);<br>
&gt; -void hdcp_destroy(struct hdcp_workqueue *work);<br>
&gt; +void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *work);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu=
_device *adev, struct cp_psp *cp_psp, struct dc *dc);<br>
&gt;&nbsp;&nbsp; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cf40303a3004b47d738b208d8cf77a0eb%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637487460023369776%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DQQJJm%2FfsnHj5kdltRjDv8Jd8qK8IYxEHleraMrXRuKY%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cf40303a3004b47d738b208d8cf77a0=
eb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637487460023369776%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DQQJJm%2FfsnHj5kdltRjDv8Jd8qK8IYxEHleraMrXRuK=
Y%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FAA069BAF6397AC7F3B7F78B9MN2PR12MB4488namp_--

--===============0393149530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0393149530==--
