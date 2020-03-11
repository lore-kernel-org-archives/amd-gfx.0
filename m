Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F6C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5524D20726
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ddur6jDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524D20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE27F89E0C;
	Wed, 11 Mar 2020 14:10:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22AC89E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 14:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt0yvX/h1ceXZ1mgPmtuIyx+K0pa+vC8ZM/yHz1qyeDMCLo18AIGEGjgj0k1YlUUgy3dhjNn2HuBYuqqlBYbdgCVrQ2cbmIG80otYp4e7HtyHesDfLcVbj9/HRx5T9ZAFh0n7uZiCGLCgWz5x3Q8MkPzZMNGLdPPsRE+8s+6NQ5c3RbB6wrkcRBP5noIxBpwlMwYCIKx+9Yz0X9019su3Tvitgmbx6U6o+8JRJ+7iuzaAPGb6vh0J7bHNJuwZyGrhI/0eLf3PAhHq6wqhs4I0+1vgGxaPhuFdNXuGE2Vun4xqaWI1tGyM2WnZIdqqUcanNzXLJ1fEeu+JhVJmLfhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIQHtISU7knlJMQ7LyGj8x42HH9oATmuSRW0NOF9+40=;
 b=AHhxuDIdtea32W5RhoEFYCgeck4dRgaioU/eOM65TB12z78Hzz24SWnG3ybtHaUwzSmSEpQWkJj9gRY7n1spndi8HPnpBjwLwHYZXVZdcue3ePA4586ODsXjd/WaRC4/TLcLvShB0+Hea/omHMLeYuluJXPeE3O6Iuw3/ZJUM04QNFPzsY/B2uBPYEnPcxeLXx0cqRN3S7l0URSnX6ngNTEExcfJ833c0ZHd5b+pjTctz4MceE4zxLCFCDie2a4NZnDkm9weMqXv4CGfc83sxXgI5duoK2bTr0jZXQhHX1XeeI2/+2a0K0ybxnO/31z9YBhOGi5kMCBJWX5VGWrJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIQHtISU7knlJMQ7LyGj8x42HH9oATmuSRW0NOF9+40=;
 b=ddur6jDDuVUcx7hSvkF8whxC/sJqKxwD7GTsnXkMXXFddm2+5frGoXrdQDznjT72EUWWVymMJ36t/+VRKYDEuVmO+jn6B19VeogdMmB7Cvo7Cre0pMHLWqlIgA3yi1BBJ4jzXmZFt+TvHAwghyLpR2XuWFhRpns8GLE3V45A1iA=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 14:09:56 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 14:09:56 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Thread-Topic: [PATCH] drm/amdgpu: add fbdev suspend/resume on gpu reset
Thread-Index: AQHV933Tf7gGWznR+0WS+z+w3RLdvqhDbdkO
Date: Wed, 11 Mar 2020 14:09:56 +0000
Message-ID: <MN2PR12MB30878D358DE0914CD84EC7AC89FC0@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20200311081853.25274-1-evan.quan@amd.com>
In-Reply-To: <20200311081853.25274-1-evan.quan@amd.com>
Accept-Language: en-US
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
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [112.64.61.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd4ee414-ea91-4aca-acd6-08d7c5c5e0c6
x-ms-traffictypediagnostic: MN2PR12MB4566:|MN2PR12MB4566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB456622802F767B561F490FC689FC0@MN2PR12MB4566.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(8676002)(66946007)(66556008)(81166006)(66446008)(9686003)(186003)(5660300002)(66476007)(71200400001)(7696005)(52536014)(26005)(55016002)(15650500001)(2906002)(316002)(110136005)(8936002)(45080400002)(6506007)(53546011)(81156014)(64756008)(33656002)(966005)(76116006)(91956017)(478600001)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4566;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+3Q41ZnXB3a8xfpmvezMxKUeg/IpQ9VfwpQ0vnsDwblBCwpKElJhDnOKTVXEUtS/zm2KubxJNyDFSVDos7K5oS/24c99ct8i6DY9wEbe03B9JpZIvRikW++uxJaUJKxJqFDb5NJitugnnxZdKmcYSy7jpE+lrK6vhI7PZXpqgkAejraqR+EAk/9sP0yDAHsR9lQ8fZrrIJHGHyrgxF2FyoWn9rUzZ+E1L+SwTD4nBeS6zxAv6iev3T6BVSQp8x3SyF7wtkCe9AmpFrFoLEnTMkC6qR6XPpPP0sR5xd1Yec+nIGSs4x3YNJbXY5BRV+cEd+tWvVa9Xignjfr3gQRF8nJaISqWSHme2MNDcerB/gVXv3AWwbNMfLSAlQ8Deo5xaX4GBbg7hyjWLQySpsqDY82la72DNss9Uh1GfhOxrvMbrdOqy4IdCcYvrv0Ye8bgNnExcRFTvxupxuhqyJYf4skJn4OBRmm3z0L9bRS5ssk0NZrnSQntYXemjpeClGE
x-ms-exchange-antispam-messagedata: 4n+gNAxVo79O6LGxZh/hKT1j/lRh5veMRlkiqlIUVHUBlPQ+E+8xvj5ZlbcQGB5S0J/JI4fS8H8CuQq3GOj80jV6xOSp+USsqpZatM6VUK5EJeD1wrd+7SrsCxGQwLWbmuLJA7E1rce0ZQs+YKJKzw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4ee414-ea91-4aca-acd6-08d7c5c5e0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 14:09:56.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXmQ3PwxI5cLk7h/BZi70Z3vSUK9nn/w1cXYh408RNQ7+9t2r8/N5rjsc2MxvWwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
And this should be a low risk fix as the same sequence
is already used for system suspend/resume.

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
