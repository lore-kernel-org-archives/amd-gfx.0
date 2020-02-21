Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55652C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 14:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173A724650
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 14:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nkz5fkep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173A724650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BBC6F45A;
	Fri, 21 Feb 2020 14:34:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE9D6E31D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 14:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOCfYR0iKExZzQVoySSfHmAnhF/hu56IKdj4Eojb6hNQRnTzcaTxBfgaWcJCHYJeCWvt3plY6rIbx/vm5AXfalv7JhYPlREq/rhlP6O730A39Aw9AwTy6GOtidrDToX782mk4s9BAqw+CvWsfkh+gKi6b/3Pwt1ZlZY5tfNKr9LBGSUJnjwJyPNymr5nDGDgl9ueewL6+qs8yIGUXsKxtWsn7LIhIbLFsmtW+3ZRM3MsatKYPnPwx5sxUy2Pjr2YLILXNnY/Cdk9nsraZSKj8Rny8MLvsdbVCi92d79MlnBFGniKra3H0dJcMx95jS2ZrmLoPyhU//lyVcZPiP9soA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxFrNzB9urRdxCjkhamZZIOcwBu8Pd0KufEOdhQni1U=;
 b=ja8sIeNOKiMuKcyAg5TFgP8pZR9hHRSE50bfJKO3qiB42iwKESheOO9KUDCjXz7E87uXDSUwqlZ4MArk8JRTkHtN9TRZBr3jwXTUI1Y2vLzyhjanTgJmy1TM2RqaexMgBtnRtyR8shnQQMgVl9NKRwj0zd0GpGMe2AhvThGBgUda8nUFd95WH8q0skTvMfqcLdEIl2Skvdlc9KPTWjbxkXk9xTFvU6tuWyZHtywLDhb9GUcal5nUZ2eax0ExyxX0yGtemplP2joJCaxftA/gCe6kMxbQeckoIpI2zrJb20a9ngByL04lt3DKpzrztr++xpGnCBAF/FzN6eeyhQe/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxFrNzB9urRdxCjkhamZZIOcwBu8Pd0KufEOdhQni1U=;
 b=Nkz5fkeplWlW9Z0iei3KnOTbrgHpKEpR6OcWsYgBB8+NKtnjG+q+HWGEnNT1oaHm1D/ax7Ed2ri/zhQxopgV706Phm7oMLdPYhURDMJn8BuB41zIKebYsxRV7Fr6wJKhrN8YCREW36FtB3OLauRhtFsKoZ0KO00Kjo8rbPpsTXE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3904.namprd12.prod.outlook.com (10.255.237.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 21 Feb 2020 14:34:09 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 14:34:09 +0000
Date: Fri, 21 Feb 2020 22:34:00 +0800
From: Huang Rui <ray.huang@amd.com>
To: Tom St Denis <tom.stdenis@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to
 MMIO
Message-ID: <20200221143359.GF28698@jenkins-Celadon-RN>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
Content-Disposition: inline
In-Reply-To: <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0401CA0002.apcprd04.prod.outlook.com (2603:1096:202:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 14:34:07 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1232c1c3-5bc5-4a3b-a92c-08d7b6db1cbc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3904:|MN2PR12MB3904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3904ADC9F092AF449AD74A38EC120@MN2PR12MB3904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(6862004)(956004)(2906002)(9686003)(55016002)(5660300002)(1076003)(66476007)(66556008)(66946007)(45080400002)(966005)(478600001)(316002)(16526019)(4326008)(33716001)(8676002)(6636002)(6666004)(8936002)(26005)(54906003)(33656002)(86362001)(81166006)(81156014)(6496006)(53546011)(186003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3904;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pr3D/tVH1c0onLIAjCEYUw0dwlosGtqA3AzFKM/YFBcTv+ASbD3MpEyfwXVGfwYt/wX8ma8JOfAmGiYzzGZjGlMugZBP/Fh0CK9cXmk+MwBIP8rwzEK/I/GWunPJ1yyCBr+Y5z8/KR8hWA2YMFpaIEhcvLELFug9B+llDjGQrtp6xC1NYRiLHoyulHIlRabtqubwtzu1J026RrnXzP2+Ga8KXLH3esrlQE5ejjg2pWXtG93ByT367LaGa3vaeysJ4EKt7COHAy3I0CHU6lBoUSZDlOtKHKzLCoDKnx4IbTRzNYQlrJS7jk4asQjPj+YlDAOuuwZ6O5Wn8OVXwMpy3hWoh4DkZGEdiSZLDHlKg5rMwBlnqW8CdCHluucNYoP3HOH33PwxNJWjYqoljgLxKNAjlemGVzvPLF4sZSeB4yENd2cZ1BlgB+Wp/i6fqWQoNJaXvwiWFscVRyFePApQu2NcSdrDIgrT+5axVnmu6pv251clCaaoMskMe2U657Vy9a+utXtDrJ61hbvrK0dsmQ==
X-MS-Exchange-AntiSpam-MessageData: O2uMiKkQHKwKVAlgZSMvF2xAyhCj+jcD5/JxmF6HWNsZXeRGiS3hMRttFPZu+MfUpjPjK49PBGWyeZTsipLVH7HOAgN+ep/JPgW7FrQ+WIZ7Bp/BjXU9AG2b6v51ipXjO+q0jKjpuGCHUxXJNtJAqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1232c1c3-5bc5-4a3b-a92c-08d7b6db1cbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 14:34:09.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmow3QU49y2yB/gm500jyN1wZHYT4QhAYALhiN/fJETndWBMDWl+gnZ8B0SCYhW8ht8JOmtqMDMosbphBOD4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3904
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 19, 2020 at 10:09:46AM -0500, Tom St Denis wrote:
> I got some messages after a while:
> =

> [=A0 741.788564] Failed to send Message 8.
> [=A0 746.671509] Failed to send Message 8.
> [=A0 748.749673] Failed to send Message 2b.
> [=A0 759.245414] Failed to send Message 7.
> [=A0 763.216902] Failed to send Message 2a.
> =

> Are there any additional locks that should be held?=A0 Because some comma=
nds
> like --top or --waves can do a lot of distinct read operations (causing a
> lot of enable/disable calls).
> =

> I'm going to sit on this a bit since I don't think the patch is ready for
> pushing out.
> =


How about use RREG32_KIQ and WREG32_KIQ?

Thanks,
Ray

> =

> Tom
> =

> On 2020-02-19 10:07 a.m., Alex Deucher wrote:
> > On Wed, Feb 19, 2020 at 10:04 AM Tom St Denis <tom.stdenis@amd.com> wro=
te:
> > > Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> > Please add a patch description.  With that fixed:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > =

> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > =

> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_debugfs.c
> > > index 7379910790c9..66f763300c96 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > @@ -169,6 +169,7 @@ static int  amdgpu_debugfs_process_reg_op(bool re=
ad, struct file *f,
> > >          if (pm_pg_lock)
> > >                  mutex_lock(&adev->pm.mutex);
> > > =

> > > +       amdgpu_gfx_off_ctrl(adev, false);
> > >          while (size) {
> > >                  uint32_t value;
> > > =

> > > @@ -192,6 +193,8 @@ static int  amdgpu_debugfs_process_reg_op(bool re=
ad, struct file *f,
> > >          }
> > > =

> > >   end:
> > > +       amdgpu_gfx_off_ctrl(adev, true);
> > > +
> > >          if (use_bank) {
> > >                  amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff=
, 0xffffffff);
> > >                  mutex_unlock(&adev->grbm_idx_mutex);
> > > --
> > > 2.24.1
> > > =

> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cra=
y.huang%40amd.com%7C7db7d3365c8842d46cde08d7b54dc560%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637177217984125436&amp;sdata=3DNBNxMQ%2Fuq7YswVzlrvZ=
WbSmcf4JUt4eL5L62%2F7iLL28%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cray.hu=
ang%40amd.com%7C7db7d3365c8842d46cde08d7b54dc560%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637177217984125436&amp;sdata=3DNBNxMQ%2Fuq7YswVzlrvZWbSm=
cf4JUt4eL5L62%2F7iLL28%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
