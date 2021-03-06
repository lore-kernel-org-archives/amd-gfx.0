Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C06C433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 04:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AEE65005
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 04:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AEE65005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C646ECBA;
	Sat,  6 Mar 2021 04:09:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C528C6E063
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 04:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV93NaXLecyLCaCaAqE6qMQ+cwvYCqJz+6jWqwClXi4jps/7NT6t4I5xH2141Yvr0yn1Xmbli6u8V5toNs27BjftyhlARPxfLnlZ2hgHtH/KBElNKjX+SJJhWtlgyRItTO0FZgmaVVJziUUlKFTKKpCpn3ShEu6FMgs1ZmbyCj+Ozvfdl5Vd70IHVvoUPtEEUoTTCUTJFudSuNuI0NWfCVKyPms4UgNNg2Fj2eDIfnLQdWrhTAQYmDWaRwXpUDHo07GRWnhRfcrOrhq8616OPg+/79ckwtKnTkLgRnDv2CrzCJ1LMsA3ARmOym1mxTio3bBMbcHuO8N1utCIt7C6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeiqBB5Y8YNBtAghqh60pQ0w111+8YfUagHWX2mmVTk=;
 b=ofxJi9ZpD2yGo63T3RQU61hY3afWDwOBmP7UsZOzQOUuWc6nIgPHi+8UUqQ7BLnSLMQZLnBwkP7Lql0MUwUsrqL265t9FSsIzk6fzMZ+JouCXzC6UcOlvsLZLa+NTgy2uSaU2eAFt2O18q+P7L/UCrYAg8nn2gDsWvMN+PN4rwYXEyX47qvB4PBDt/mZzVMM3MYck/C/dFBZcnzuOAB9IIB0a5pyYL+4TJxYWwWiHILSgGwJG1OeEvtnUu7a9uVtXg3NxF3bEU9EKPp3HYcQiDjEkCx8YABhs90miyYhAGhyVhheyAE2jiQ3VKWKRHxPJPqk7iOeO8IyXcG3g1gX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeiqBB5Y8YNBtAghqh60pQ0w111+8YfUagHWX2mmVTk=;
 b=TjJxOMPVqLgz6738WXHKkSMS/wxSaHfoMV5awKPey9V05PWMgs9UlzWew6vB2M1Urvm2Wi0m19kGY8uxqYCUW1oKRmkzzNfdD5ILKgbLOjIcFzeEZjySnDSvd3qxkZSo/psLhRHHLNdluow1X79utskWXAI7R3h7kciWWxPjnJA=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sat, 6 Mar
 2021 04:09:26 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.033; Sat, 6 Mar 2021
 04:09:26 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Thread-Topic: [PATCH 2/5] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Thread-Index: AQHXEehEo7NELKNXOkmgV4nn4nfkh6p2WKkk
Date: Sat, 6 Mar 2021 04:09:26 +0000
Message-ID: <MN2PR12MB45495A668922FDE528A182EF97959@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210305175149.32020-1-shaoyun.liu@amd.com>
In-Reply-To: <20210305175149.32020-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-06T04:07:34.6623579Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [27.59.74.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21437c09-7771-4d0e-1d92-08d8e055a1b1
x-ms-traffictypediagnostic: MN2PR12MB4224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4224AF34BE60029B12E4539997959@MN2PR12MB4224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIcbWBk/O4aW49kb4YBMX/coddEIMFuPsWxJMqut5wi6ro+u/N7kTikHnS0ysvERB6XZaCHd2kkv9y+lQs0/8xyhlrFpIkhziOKl/MkWr0RGOjgn9Chf1cmIsjAHvJlqy+fEIDFBMWN7Hkkf3jYJGnFcCcJ3hxVzdmOa0PZ65UP6+n4zLIezfcbJEASvxL1tsys5mSYBf7vAPiqfxcSeDY2dlMJL7xA4ryf9X8ja7duSTFJDdQHQ8CAtrGcLOeZR7Z0wgcNrziY+KlxqJv6m/SxjSI5mDr42okYTu4rLST+5M4OKLwgPeL0yliPyX3c17d6Xn/uCu/cwV21z6JsOL3Ev+fFUDVuPJEV6Uxj3DR0iNtk2ateT6crhuuvpsekJbustl7zaIxMsjxI8dBGtjW7UGU9P/f4isF7eGnfV9elbMNTUzGKcMYCaitXCZ/y6mLn9J6YA0vG3alaGcSf+5lfAARFDCbEBVLcr0F/YkQprYr1YlMkKF6KqpZmGwIbO7tn15zuzcIzHhFStzYRA+oGVnq3lhK9reLCxWzDQbMnnqU9+nE0Blzeoyzmjo7Eq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(2906002)(83380400001)(166002)(45080400002)(66446008)(66556008)(66476007)(64756008)(52536014)(5660300002)(66946007)(76116006)(91956017)(8936002)(8676002)(71200400001)(478600001)(26005)(316002)(33656002)(110136005)(86362001)(186003)(9686003)(966005)(6506007)(7696005)(53546011)(55016002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FsFDPjjZfVAsLtZZh1Y1GKhnjRd+ulMK3+e+Qz0x6uHf0AY4Exh8zOwrDzso?=
 =?us-ascii?Q?aUEdwtKgGgbDqviDohKg0kVLDwfo1WPg9xpC5ut5V12Hz/mtLdtNwsERSGDJ?=
 =?us-ascii?Q?A9IruWRAH2XtTU2C8NzPYgxMj4ct2AEvWIyXpfrrmaKpmOz49zt9904TqcEZ?=
 =?us-ascii?Q?Wjwq7UnY+tdTvphLRq9Xzi2s8dlPnkW5AwN2dkGlFUYstFOozHnTEb8CF67f?=
 =?us-ascii?Q?GyVBCvuh9/l/sFBF2JCFnmi+agYyU/dHQXC64BH6wqPCOxDusP/k22Tb9t5I?=
 =?us-ascii?Q?4Zj6FLi5O2+i0pVWxrCkSnEgcgDcK9f6yB5grHYz0WfPpqctyzqBGeYN/inO?=
 =?us-ascii?Q?rw2MW7sVFcZMm0mqgdCoTkZV007ilfRTAFOC2EqXx1F1Jgbs/7LoNpkXaTDO?=
 =?us-ascii?Q?xUR7GP4CIG0T3HLlIhu9ds4Yxv1WB34B7hrEqPtdtDI7Ptyt0STgPMY2Nl+B?=
 =?us-ascii?Q?wxRVI32kzkS/v9EOja19snEP8JTNf7P68jHsOzinB6EmhPGuAxygPKBgdnTW?=
 =?us-ascii?Q?jyhco8SMO70D2KdtGZMfVBFN32u0Ei70Vpwy1N4tr9mlS4r6uTNNB4pGv7jh?=
 =?us-ascii?Q?ZkmxkR1YF2Ha2O5dGjuVGMOlE0t2UU6YhFvx3aBPh77iHDXAoqd74QuOuWRx?=
 =?us-ascii?Q?+oRL0HckWv+tFJBdzRMpWjJgKW5JoCba2e1lT6ydL0+mrntVFO7PBWbSKmUo?=
 =?us-ascii?Q?UUBv2g+1dFqIDH0znsJta/dz5Pje0haKhGvjFxYFxOHJTdP00l/E/ipdRi5Y?=
 =?us-ascii?Q?OrTQKr3NC8pN0fqFEYJho4i1zCeG3wa0MHMRn8c/G4/mlOOqpNMKkIHADiIp?=
 =?us-ascii?Q?aDynrS84aryuPaG3aJ+v7nMVj4vgSEPqPmdt/AgDEj5g7Mmmrml+Jd0Vym1W?=
 =?us-ascii?Q?wdz+P2DXwAVr/S5P1uw4Sry2CW2lZ8Rv7dPAijw92V6uZmrcZTMfua7YxaSj?=
 =?us-ascii?Q?BQDZ+17Vilagx+iRs0sFa0HQqabhqfz0mhzwRW/ugZWGzmr/izLd6dB76aWC?=
 =?us-ascii?Q?ccZ9dH5AP32Dr90tMI7CpybKYL+RquTNCncV47Fi1wswu5yX4203fe+3ED1j?=
 =?us-ascii?Q?QpAtlWsDw1EYpx/eVu0ZT5f3dUqIzU6fA0EHx+B15K0OHGyP8RoduXnfEbtQ?=
 =?us-ascii?Q?wD+CilO8u/flDblmcWvhi7/0Oslhx7KneBidl9BeAJ8yUq6cbMwBKD9jx+GC?=
 =?us-ascii?Q?Z0DyGNSWDBPM8wcsHDCaHmCqvmWYFTs80/DcrsZuw17300IElfhfaOi/pkgx?=
 =?us-ascii?Q?tXOeUVYsEUn7vw9dNYvVGs3kEQQHeEMtAq3nN/gwZ9yF60214Jz01OQwxqmT?=
 =?us-ascii?Q?e3mOhJfmU9oHAsnFzw7Krtj3+D/XfE7ecRS4QsDOG1QX4w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21437c09-7771-4d0e-1d92-08d8e055a1b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 04:09:26.1510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGv2RuqHFhe8mt3Q9GMH7FqHCyJKSkijd2/o6oM6VSjEa0ow0kGKuJKxZsEBDHtg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============1332314567=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1332314567==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45495A668922FDE528A182EF97959MN2PR12MB4549namp_"

--_000_MN2PR12MB45495A668922FDE528A182EF97959MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Instead of mixing to recover workflow, can this be separated out to somethi=
ng like early_reset().

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of shaoyunl=
 <shaoyun.liu@amd.com>
Sent: Friday, March 5, 2021 11:21:49 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add kfd init_complete flag to check from a=
mdgpu side

amdgpu driver may be in reset state during init which will not initialize t=
he kfd,
driver need to initialize the KFD after reset by check the flag

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..a876dc3af017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *ad=
ev)
                                         adev->doorbell_index.last_non_cp;
                 }

-               kgd2kfd_device_init(adev->kfd.dev, adev_to_drm(adev), &gpu_=
resources);
+               adev->kfd.init_complete =3D kgd2kfd_device_init(adev->kfd.d=
ev,
+                                               adev_to_drm(adev), &gpu_res=
ources);
         }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 4687ff2961e1..3182dd97840e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {
 struct amdgpu_kfd_dev {
         struct kfd_dev *dev;
         uint64_t vram_used;
+       bool init_complete;
 };

 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a11760ec3924..62d7ce621457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4788,9 +4788,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,

 skip_sched_resume:
         list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-               /*unlock kfd: SRIOV would do it separately */
+               /* unlock kfd: SRIOV would do it separately */
                 if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
                         amdgpu_amdkfd_post_reset(tmp_adev);
+
+               /* kfd_post_reset will do nothing if kfd device is not init=
ialized,
+                * need to bring up kfd here if it's not be initialized bef=
ore
+                */
+               if (!adev->kfd.init_complete)
+                       amdgpu_amdkfd_device_init(adev);
+
                 if (audio_suspended)
                         amdgpu_device_resume_display_audio(tmp_adev);
                 amdgpu_device_unlock_adev(tmp_adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7Cdb39943153f3475c5b4808d8dfff64ec%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637505635308266548%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DpYd=
yi4KiRX7qz5S1Gog63pYZ26sSIUesx3V1jHMXwrM%3D&amp;reserved=3D0

--_000_MN2PR12MB45495A668922FDE528A182EF97959MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Instead of mixing to recover workflow, can this be separated out to somethi=
ng like early_reset().</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of shaoyunl &lt;shaoyun.liu@amd.=
com&gt;<br>
<b>Sent:</b> Friday, March 5, 2021 11:21:49 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/5] drm/amdgpu: Add kfd init_complete flag to check=
 from amdgpu side</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">amdgpu driver may be in reset state during init wh=
ich will not initialize the kfd,<br>
driver need to initialize the KFD after reset by check the flag<br>
<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu@amd.com&gt;<br>
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++++-<br>
&nbsp;3 files changed, 11 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index c5343a5eecbe..a876dc3af017 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kgd2kfd_device_init(adev-&gt;kfd.dev, adev_to_drm(adev), &amp;gp=
u_resources);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;kfd.init_complete =3D kgd2kfd_device_init(adev-&gt;kfd.=
dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev_to_drm(adev), &am=
p;gpu_resources);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index 4687ff2961e1..3182dd97840e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {<br>
&nbsp;struct amdgpu_kfd_dev {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_used;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool init_complete;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum kgd_engine_type {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a11760ec3924..62d7ce621457 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -4788,9 +4788,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;<br>
&nbsp;skip_sched_resume:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, device_list_handle, gmc.xgmi.head) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*unlock kfd: SRIOV would do it separately */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* unlock kfd: SRIOV would do it separately */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!need_emergency_restart &amp;&amp; !amdgpu_sriov_=
vf(tmp_adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_amdkfd_post_reset(tmp_adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* kfd_post_reset will do nothing if kfd device is not initializ=
ed,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * need to bring up kfd here if it's not be initialized bef=
ore<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;kfd.init_complete)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_de=
vice_init(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (audio_suspended)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_resume_display_audio(tmp_adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_adev(tmp_adev);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7Cdb39943153f3475c5b4808d8dfff64ec%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637505635308266548%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3DpYdyi4KiRX7qz5S1Gog63pYZ26sSIUesx3V1jHMXwrM%3D&amp;amp;rese=
rved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7=
C01%7Clijo.lazar%40amd.com%7Cdb39943153f3475c5b4808d8dfff64ec%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637505635308266548%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;amp;sdata=3DpYdyi4KiRX7qz5S1Gog63pYZ26sSIUesx3V1jHMXwrM%3D&amp;amp;reser=
ved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB45495A668922FDE528A182EF97959MN2PR12MB4549namp_--

--===============1332314567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1332314567==--
