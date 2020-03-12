Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7FC0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D9020735
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IKcQDFiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D9020735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C026EA15;
	Thu, 12 Mar 2020 03:08:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059986EA15
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 03:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoWKxsCE/Y32O7lxt4nQGD/BAeygXPQQH4wvaUk4xcCGz6CBNoe1+Ts/06qeCiXU+UxxRMaO4Q0Q4tbhIZkKob7m+iG47o5FkocKLt5cLj46SjNCdLIA45dELCb0VUqr6vppTtZbhbiOH0uLSfSji9Iep/CXuBBnqjAt3SNs0wSIjnffmFokV1v4I5PZybMaEWgLCQO8NvN9sVwi6a7akkkIOybM6ugtF4tFmGlidgb7u8IWSzERRHMw4WCZzsvnx1dWhY79BxcglZF7NtFszYaTsAghIxFFOAae+4Yp3WJtOyTLRb1+0M/bujgF6q6cQPs2bmV0achWGALnY4FNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La6nXrVWVYzyp1XmwvuYVWaPtNKkcwI7uEIq+xpmIEI=;
 b=RfZma6zaS2CY8cRIVF02TppvD1Nkk0CxOLHXot+8vvfoRM/QLSyFRmURzfqRLQ4bM9DjCIsVFbDMGH+hHFcEzktX6ja6a7J6h4wGPgoqov0MRZbtrVwhpq8fUjlvIRg75QkB6DuTeOvdreU1rAy/u4RBC7VRQyqWmJiFricSbfsVTsDuwTrjQTEs1mW5hrAuAz1lq4TbPLVaBp6AnbNUH5m2liOo94ZW6lucuqmOqy5DwB45At1qKTDtsPB9ky21tFCS2pDi54qYaK+D3fZ7GyupMTnuXUXKFwhZ6aMSGJHgMfoKBgdAh9P4V6yNJ1QWLjQjQi4mNrCzUCm9MaeYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La6nXrVWVYzyp1XmwvuYVWaPtNKkcwI7uEIq+xpmIEI=;
 b=IKcQDFiYz3IKu5xCJ/5bzqYBQSrg3pmyLyR2enFRGz3ybT8DjBprE+XI/xA6eoV7oQ4AUCqakle6+4e59Pq8XKBbi1adTnlC1d1/o7ZThVUi4WGLD8WrbU+DrOzWd8z/v6R/KnKGiIrSzAyHYhDGXAahjw3yA667vz7GgTKKLME=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Thu, 12 Mar
 2020 03:08:54 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 03:08:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Thread-Topic: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Thread-Index: AQHV932+83uWYBsNdkC971Snh6+a+qhDboAAgADZNUA=
Date: Thu, 12 Mar 2020 03:08:54 +0000
Message-ID: <MN2PR12MB334433E8444AC1964B95A610E4FD0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200311081853.25274-1-evan.quan@amd.com>
 <MN2PR12MB30878D358DE0914CD84EC7AC89FC0@MN2PR12MB3087.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB30878D358DE0914CD84EC7AC89FC0@MN2PR12MB3087.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-11T14:09:56.064Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0733cdef-4d4e-4416-5fd9-08d7c632b2de
x-ms-traffictypediagnostic: MN2PR12MB4016:|MN2PR12MB4016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40169119F10ABE33DDAFED5BE4FD0@MN2PR12MB4016.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(8936002)(6506007)(7696005)(9686003)(55016002)(66946007)(66446008)(76116006)(8676002)(81166006)(15650500001)(53546011)(66556008)(186003)(64756008)(52536014)(66476007)(26005)(86362001)(71200400001)(45080400002)(5660300002)(110136005)(478600001)(33656002)(316002)(966005)(2906002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4016;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecmOuCwyDGGzvIWpuynOKKFMvNYTJSIpssvtJknvOrIlu4vM/7+9MQrlzWb/NGfrmtMLOUGqSRe1DFupkP20heJAOOqDjHD6ya9VXfimGi5lVQvrG+KlleYDkCnzdT+mAVOHcKQoWaWVXPdnjaISFkJ6PkCC4DL8u+0vf5EzM53/v1o5PbiBFoQudb76MZ5LVl1C5VNct/ceMSL7WsP8rq+9EYjaRUTgjRRD2rq6J3ClryOiWbxyR9xXnnGVjwi+CXygpu7Uo4GQ55FZMy1CmRHlsNTenA5AsG1yyzgQhkJbty9ePwKNpbwn25yT3tWOk47vaf2/4jYVjyJHzq3WboJ2dj2rN7P6jHj2sKlLSB5Cs2xPbyx+CD5BlhvP3b8u8T4cdZivNtl+lpi3jghpWpdb1qqb71ea9O5stMYBrWgARB1v4gLK0uUnV/wVUk/SwSA6nCq8MLrllfnUrnKT74MtT2ndEaNpmnRppSgtRsB+4nASDOzWSp1E00lKnCXCWiynKP/f8t/aZUc/LDnzqA==
x-ms-exchange-antispam-messagedata: HhPdioByKp1j+2apEMQlHcP+lDERzwGp4HKek5nLHUpfp4NCRgMqUbAM+6njwrI2JPyg65zilhXDHXVHZzLneTU4vTbvffah2a+ZPdgeACVOpnAA5Y1YlqINUUercyxVcrnu8EKjzmqq2ZLNAXwKkA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0733cdef-4d4e-4416-5fd9-08d7c632b2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 03:08:54.6697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olSRJbFm5rXRr/lXZxXjPHMcsutw4QOQHua5wmHj+RXOt594ChacJbOcON5umtWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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

Have not tried Navi14 yet. But likely it can fix that baco failure.
At least it can fix the baco issue of Navi10 which is very similar as Navi14's.

Regards,
Evan
-----Original Message-----
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com> 
Sent: Wednesday, March 11, 2020 10:10 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset

[AMD Official Use Only - Internal Distribution Only]

Hi Evan,

Does this patch also fix the baco failure on Navi14 with display connected?

BR,
Xiaojie

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Quan <evan.quan@amd.com>
Sent: Wednesday, March 11, 2020 4:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan
Subject: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset

This can fix the baco reset failure seen on Navi10.
And this should be a low risk fix as the same sequence is already used for system suspend/resume.

Change-Id: Idb4d02c5fcbbd5b7817195ee04c7af34c346a053
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 572eb6ea8eab..a35c89973614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3935,6 +3935,8 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
                                if (r)
                                        goto out;

+                               amdgpu_fbdev_set_suspend(tmp_adev, 0);
+
                                /* must succeed. */
                                amdgpu_ras_resume(tmp_adev);

@@ -4108,6 +4110,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
                 */
                amdgpu_unregister_gpu_instance(tmp_adev);

+               amdgpu_fbdev_set_suspend(adev, 1);
+
                /* disable ras on ALL IPs */
                if (!(in_ras_intr && !use_baco) &&
                      amdgpu_device_ip_need_full_reset(tmp_adev))
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CXiaojie.Yuan%40amd.com%7C3eace080fd0b4f67337e08d7c594e441%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637195115872403614&amp;sdata=%2B%2B3xRFOl2Ho%2BRe9VuzqHtZNoVZ3s%2BxIP7xTv6yG11LA%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
