Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F378C48BDF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F40861059
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F40861059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C605C6E5B2;
	Wed,  9 Jun 2021 10:56:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61296E5B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSyA5zhq3k+K0dmYF2RoaAGD9SBeBVw7lnGVNnTaO9n3EM0iBbloG4ESM9M6aQTlF2jt6LlQSrkKqATSUeJEV9LoCNgBr/7fm9rL4hjC2sIS/RAMLg5FWrqtlV2iLBKbIqwnew0oZdH60T3ssEpRR1UbBJaGDlEyAOeqw754xGgfXx91CSGMR4UUDmdO5s5fKVXJ5pDzEtJdIRtQJ18yJ8pbvU4tbXO47WSddYYZqthXQXUiEjOzx4KCaT9BowSPJ2dhKu8jF5hOCZKLQINVFMCNPBWLqJyB0wpuyFR6cQNLCaPY3BloOb6gFipPIcZxmiQ/44Uj8Wc6ZMz5iLvdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckPHqrYZdublbJLvDn/v59cxNhCELMiakkdUVCH8QyA=;
 b=WzVrhVqTnKr2iMXfJqydonEexn2YK3HtLv4uZwwbpSp+rmpbXsH3OENLHq0GC7j2+C8wcL3L6RcAy06UfzhAfMrNL/2U3rOXHE8OWLgKZGTCoaO4p7MaKce0eB75uPo+llAAN7qW1UwvrR5TYkkOUG4kY+NcVxyTLtTmPmQhZNUDVPuXv5wn3RZ4/Xe6DO9011uIzlmzHdD/cA8K09cquEYGW1m1mnI2UmsY+ikZ25bdJfhYOfOirhx97Q0BFkDD7CCJL57rpG+Eqe46kHLoE32LSxgeK8Ylwj90rKDB4+1jjMzhEnY84N0sKmhQsDtq+POTNzvCyRocrWevaUn5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckPHqrYZdublbJLvDn/v59cxNhCELMiakkdUVCH8QyA=;
 b=Wyhm0ODul8IlD58Wae4jzjd8dvSQXn2OUxI279s3U+nCxkN+QRNaAtAY4G7eJZmrahmNhQn+8Qtz43FLk147xLhsepWE3AJl+odmCTAcxSGiqwapGkv39bnQ3QhAqiw8OgD8qBJfb87PcINL/7+fzzsBwhs2Yg04hd5Qb4rZAtc=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Wed, 9 Jun 2021 10:56:14 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::3c63:9408:f8c:ee96]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::3c63:9408:f8c:ee96%3]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 10:56:14 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
Thread-Index: AQHXWGUhvMwMHMv+KECau9PTnYnNJ6sIN1KwgANTeVA=
Date: Wed, 9 Jun 2021 10:56:14 +0000
Message-ID: <DM8PR12MB5478A0F90B4FEB580B0A823CF8369@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210603104208.5725-1-PengJu.Zhou@amd.com>
 <20210603104208.5725-2-PengJu.Zhou@amd.com>
 <DM8PR12MB54782FB82F87D2E11A7ADCC3F8389@DM8PR12MB5478.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54782FB82F87D2E11A7ADCC3F8389@DM8PR12MB5478.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-09T10:56:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1d42ffb4-96aa-47b2-affc-8ea80d3ea924;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ae76f98-97a6-4c33-4484-08d92b35334e
x-ms-traffictypediagnostic: DM8PR12MB5477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB547753DFA4E0956F151214C3F8369@DM8PR12MB5477.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTmfmH3hGlTS/yyJoBY/w41B564a8fdCaqkRnXUsAMhwlWI0U27slh8Y+RBMDeV6jDZEOY4CXzY1YBVqjqqXldi9j88yrWwBYrjYYFMjGQMHnfAYlSEleXk8UOv8c1CmZrgVGjdTduEmjzo2BYor45wDDiR0EXOu5KYDDLaKYnW1qnlR+MeQJvo/jjUfA2/2JN4iugtoV32kiiXFzls02eVrN91MO2SRK96ee0ylBpp2PSqDPqZ7Zp4/YUUbv91D8uqsNThTNbQgpKpjUppttTjOuZbivqpFituKA3UeGCqhnWiAwgXPSmkAf/5iYAJMmIL/QQazgMso5kY4bc0+wYzy6zBk6qevdfoy5edE9GWdToYAHSn8xWQbU/ngA7Ka8rSb02VdIORv0QZtNFE9mbraxG+Q8tuvcDhgAdWAI0VJAW0vaaXJW5U0G4VQJOJhHzDkzBiXsD94et/RSaKXDAbP59cEYGBEJuP66MKr/qU6N9yd0fVJNwduxSA7FbKGHFHIrVtCZtttjQWDVbNr0du5Z8FBLRiCbD87IlXDmB4zfgb9Ki+dDMaQRDhNjJJhDgHsc7gc7r35Nqf3yOYLU6/gBPKYQFTXyxxTFFa3pZo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(33656002)(86362001)(316002)(7696005)(6636002)(84040400003)(110136005)(186003)(122000001)(478600001)(83380400001)(26005)(4326008)(38100700002)(9686003)(66476007)(76116006)(71200400001)(2906002)(66446008)(66556008)(5660300002)(64756008)(55016002)(52536014)(66946007)(8936002)(6506007)(53546011)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJ5PCdxwABKPQhYLoVMr83lF4CubNuQ8tTRR0k/ukPlMNdnbjFidDDMGfOPA?=
 =?us-ascii?Q?Ff5LOA2+pDUKFPv8j39mEbwE+yPt/OfKpDmKuFHzXf0tYjdzTuRY+3sgZ28f?=
 =?us-ascii?Q?Q/hbPOnKJvYlLGsuIAkI5ek9NE8IfOAUkvkhAPKpf2KWkuGwTRXfNZ/kiDd/?=
 =?us-ascii?Q?G+bZDmVcfpan5EzRTPufEhJKPZLeIiN/B3SS6H62fh83Yoz7xRf8GcMXi3Af?=
 =?us-ascii?Q?pSCcE4iM5sg6l456ExS4v9+3H3RwgWfaj3xsXbk6kSVS1y483Rf/W2dbPYW/?=
 =?us-ascii?Q?c8pgt4Z1hkjJEfUesFF34OScN58HSJMMJ1ra5ZrEXbA/sr8Qxab6G0TfZ5aO?=
 =?us-ascii?Q?FTReOsUXTGts+TP1tKsl/XgGkg597iGh4g3JtKPVRntznYQN545cr/MMk877?=
 =?us-ascii?Q?5Pa6KRYNcGgAIOuA84uh85H8JDZnoJtjhgANf4+KhNdoYwABiV+1fB0AcD/M?=
 =?us-ascii?Q?7cGF6/Ee+vSbK/cdcSFaaHGFd34bKv5SqafcGR/WUWda2Le/QBI3qylFljdi?=
 =?us-ascii?Q?Rv6eOvKo5qI7o7pY8qAt7te7/Oohp+C/2ly/9I0/CWE7kCNvOvbAP+v0o4Wq?=
 =?us-ascii?Q?l4s0aH8JQ1wAV9v6eymX3w5t4Xh63ngXhTF0KXtdi111Ie/s9Iyuv7azx+T4?=
 =?us-ascii?Q?SipjA5a0OtmCIV3PDGTC6uV+tG3x7rhVY6vjcmoKhZW1GWlv373VLAMuwuzW?=
 =?us-ascii?Q?FS3QvZQtQ0rLXiiw1SVDxOJ1f+nB9T/NawfQyZA0kqJzyc5gXPcE1PTFGL0A?=
 =?us-ascii?Q?l0tk2lr4kZ7e5spZESNscS8ong6EBINK/GkFrQ0RnwSDjgrlZGtgpO7N/PAY?=
 =?us-ascii?Q?BhMkIY0/Qkl+vNB2lo7wkeiJqJgpyTFys0VwWmc+WigSaRy2Gbe8Em8o5rq3?=
 =?us-ascii?Q?/OG0ZqePqKSWcUTEBbJ88CpP7rtRrMWrdS+tbK7dlEW3TXVQXsdG5Y4Log0K?=
 =?us-ascii?Q?sHi22CnUg/9Hjam1JntDohwT0y8PuU/eOjF6JCaFRPa7yQBSAjeWJrR26fgT?=
 =?us-ascii?Q?9bylkUWt9R7S+/+w7EWXIVuPULxwojeAIADSwqLtHMPdSmm/5SU8ZKb+rHBa?=
 =?us-ascii?Q?xMEdSnbgQVA3Iu2CfGO1JfrrORdq8nz8tg24V+fklLkNAV/hHZvE3MAbFHmw?=
 =?us-ascii?Q?Lwg0jk1V0lDKkFN4hbvjRWsk0rKEPvV7ke/HoSb4lU0LsZfMuYugEmW5NzQe?=
 =?us-ascii?Q?+Ex0cvKPaXFaNKvxDaUpyyMFGRqxbithJk8Y5x0AgxjEqCf9rfMzOmcdvywf?=
 =?us-ascii?Q?wICBmiZ178BfaagqaXdCMLYRt6Q9t3PVX62jDDcPWtA2YZ9b6eQogHs5JGGv?=
 =?us-ascii?Q?epnd3UsGs9P0gE/go8+UpEdB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae76f98-97a6-4c33-4484-08d92b35334e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 10:56:14.2728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+kknpgiY9hsipED3PGo4GHuFbQx8wAcHtiNowHn27imdfEEI2xgQINGWwIH1PeKft33LmzQhjVpFzCDWB0TOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping on this series

--------------------------
Pengju Zhou

> -----Original Message-----
> From: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Sent: Monday, June 7, 2021 4:13 PM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; amd-gfx@lists.freedesktop.org;
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
> Subject: RE: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
> amdgpu_discovery_get_ip_version
> 
> [AMD Official Use Only]
> 
> Hi Alex
> The following patch series were ported from amd-staging-dkms to fix VCN IB
> test fail.
> Can you help to review it?
> 
> [PATCH 1/2] drm/amd/amdgpu: Use IP discovery data to determine VCN
> enablement instead of MMSCH [PATCH 2/2] drm/amd/amdgpu: add
> instance_number check in amdgpu_discovery_get_ip_version
> 
> 
> ----------------------------------------------------------------------
> BW
> Pengju Zhou
> 
> 
> 
> > -----Original Message-----
> > From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > Sent: Thursday, June 3, 2021 6:42 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou, Peng Ju <PengJu.Zhou@amd.com>; Zhang, Bokun
> > <Bokun.Zhang@amd.com>
> > Subject: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
> > amdgpu_discovery_get_ip_version
> >
> > The original code returns IP version of instantce_0 for every IP. This
> > implementation may be correct for most of IPs.
> >
> > However, for certain IP block (VCN for example), it may have 2
> > instances and both of them have the same hw_id, BUT they have
> > different revision number
> > (0 and 1).
> >
> > In this case, the original amdgpu_discovery_get_ip_version cannot
> > correct reflects the result and returns false information
> >
> > Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 99255c2f08f4..f949ed8bfd9e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -325,7 +325,7 @@ int amdgpu_discovery_reg_base_init(struct
> > amdgpu_device *adev)
> >  	return 0;
> >  }
> >
> > -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int
> > hw_id,
> > +int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int
> > +hw_id, int number_instance,
> >  				    int *major, int *minor, int *revision)  {
> >  	struct binary_header *bhdr;
> > @@ -357,7 +357,7 @@ int amdgpu_discovery_get_ip_version(struct
> > amdgpu_device *adev, int hw_id,
> >  		for (j = 0; j < num_ips; j++) {
> >  			ip = (struct ip *)(adev->mman.discovery_bin +
> ip_offset);
> >
> > -			if (le16_to_cpu(ip->hw_id) == hw_id) {
> > +			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip-
> > >number_instance ==
> > +number_instance)) {
> >  				if (major)
> >  					*major = ip->major;
> >  				if (minor)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > index 1b1ae21b1037..02e340cd3a38 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > @@ -30,7 +30,7 @@
> >  void amdgpu_discovery_fini(struct amdgpu_device *adev);  int
> > amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);  void
> > amdgpu_discovery_harvest_ip(struct amdgpu_device *adev); -int
> > amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
> > +int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int
> > +hw_id, int number_instance,
> >                                      int *major, int *minor, int
> > *revision);  int amdgpu_discovery_get_gfx_info(struct amdgpu_device
> > *adev);
> >
> > --
> > 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
