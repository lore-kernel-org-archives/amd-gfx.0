Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BFDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 12:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CB810F10B;
	Fri,  8 Apr 2022 12:25:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C129510F10A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 12:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBsjJQi44bZELk41mqEjhojTyt6XVODaCgK8ofb9IhB6aB8mvht+iSx9glH9Gsxyg4gdp4pD9AeqcSJkCM8P4a1z6kWO756AzIoVpoBxgZhZ7cPgbrUy9cUEgB1v79mSf+ItZkAhbAjWvxsN7OhVj0AbCaG7w59YhkflnNvxns1li0cifqB3R/MSEjRu9pvOTQyZt2Y+VV8kVYM8sKyaAtd4Qv31yx8jYuG427tyd0v7L0jfr4VwMhclSd9fca4E43DrFh9eU63bKttztW/eYpI+Sik29ZbycQkX+7YnADO812cyrV8CxK+tutt8zNU4W2Kp1GxXGAaGvhUZjMiUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRoCFklhrV0gxYQ5Ers0N13bWJysOPwDVL6YtZ7dl0Q=;
 b=jWPRtL1bo3DLrHweEwDAoAGoEJYZC/9P/DFZXPkbXYQ5wVxNv8zhRYeOfjQzMItX1mj6p4n3pbHZToZJqXv32BSAUDTU9ZPIQSuAGzgIEnXbB7hG8PfpkH669K/YD67kRrDTnydCqhO3eV7KpO3+ho7ME002pMPglBpI7tQv4RjdE6iPFgrvHSjzmjvzcToRb0oZY8XOWI4Z5XwIQ071AXcrrTw/ZvuvfTVGNWvxihZ1R12v4efa2TU/EH9gTKUC9PspH8lDVBHx4uz52e0RRAbhrXZpyfSqy/hnKkMuNtDz1ygEDDrECt2mXj4R72WuBI/9e6uTggbJ9z2qLHT55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRoCFklhrV0gxYQ5Ers0N13bWJysOPwDVL6YtZ7dl0Q=;
 b=3JbO9jJHPSHnI0NMvPLLdTks5MLdzTaElvwK+u07+ve34iqPBa+7gFnm/lB65ZSiO8mqUd4tfe5DjmUi7grKFtsXnRfWw//xB8L3QtoPZLjIOogDJc625OgpqC7k4R4dZ+8vUXFBDNEliphjlqVZqoq/F9nW+Tt8Fu8z8GsRA+U=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 12:24:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc5c:3ef0:1281:98ba]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc5c:3ef0:1281:98ba%3]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 12:24:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: RE: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Topic: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Index: AQHX5/LJ4D+1UL2cPU263eD1r1iEEqzZfgGAgAANK6CAABQxgIABvleAgAAdTQCAAAHRAIAABW2QgAAzIYCAANzAsIAKJElA
Date: Fri, 8 Apr 2022 12:24:57 +0000
Message-ID: <DM6PR12MB2619529F8A58B49D2244745EE4E99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <BYAPR12MB2615608D66B2894697D8C5FEE4E09@BYAPR12MB2615.namprd12.prod.outlook.com>
 <20220401121847.5754-1-amarsh04@internode.on.net>
 <DM6PR12MB261926C1A94C438BA37815DEE4E39@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261926C1A94C438BA37815DEE4E39@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T12:24:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4e281cf7-2a82-4d7f-9ee2-ac3cd9cb29d3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16871a6c-ae9e-4ae4-72db-08da195acb48
x-ms-traffictypediagnostic: BY5PR12MB4146:EE_
x-microsoft-antispam-prvs: <BY5PR12MB414641B99D7B4248CE722AE2E4E99@BY5PR12MB4146.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eh4NFOiQIov50Exe7ICWaE8Mi1tPtUBnbyp1wxHWVbHlGkRLOF+zxYW/gOTnT/udZMezxLaCJlOi0h61rXji0hc+2l77Igg8MpL5DJn+xQbVTXEY5c0CsmO3DoQ+Hqsbub0I2zcJQv90q5XjJRRLQL7YsxU4/MPtHcZA0raF/IG0+WB7vwiERCX5WcHAFpv8qOu5tHdEFs8onOZc0prdaIhwBoFJ46RjSG5FvOPMciYjj96X3IFW6CARyDUoxZwgWqYy4YAe9HGT+rYMO4cKAc5zTb4+A+GqSMkttEhPCxxbEL5mL2qclDES3CQzo1T5ZrjIxXx+ACPWTpZ4xG8TeVKelgMaw14liBj58kC8/F2GGZX0dtu+qoRcGVvsrOAzg/3jvC4YDTtfMBKB5Cw+HJoozG4v8ktgBCLcI4A/Nf2fNLnmZUJz5rU2NCAm/68c8c2o+7Xm+/1I0agV/xWflUZnLFnDjUSnPxi+fCf8AuK8niTfWPEuSBpI6vK5H69U96b1Gri2GFcSFoSRPPlJfmItWNG0FOIEx3WxepqHg7rjRHsnyRF678467Ly0Zq+i59shWlnYsAsh0HcQivEadruR+QX0eYrxeIGT6QdhsHV77SLvYLbUaubJQDBCJft2vAEJJXuQVPxHzcAGbNs4jUfI9IdS9cgnFg6XugEDyyCdsDM3Tk6Sh7PLpI70n+EErKzbQpMyFm3kdXJfDPYLXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(52536014)(71200400001)(83380400001)(4326008)(508600001)(53546011)(8936002)(9686003)(186003)(26005)(33656002)(55016003)(86362001)(2906002)(7696005)(6506007)(38100700002)(76116006)(64756008)(38070700005)(316002)(8676002)(66476007)(66556008)(122000001)(66946007)(66446008)(54906003)(99936003)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QKpePOXbixeSCyKyKu0iCht/KZP1I6SiuLOdiG6Ue0hqXHCwGzGY2lZTL1ih?=
 =?us-ascii?Q?kHJpOAiEjqjWgESJ+LpMTiDm9q7S6kcw/TQB1nZlh/R/lSsNO9UmgGGg9Tc/?=
 =?us-ascii?Q?nOroEtTnDlfDOQyQEHX4qgSFXZgmWMpodsE5KL+Z7/0VUnUVKlXJjhLndbNp?=
 =?us-ascii?Q?zB8X0f6L8SlM/GNS13FL6CFY0rQseDuxR0EK2jE5aw6fwerkkRvFvJppLAPP?=
 =?us-ascii?Q?l7lNOnj9oQQZrAQ2deVs+CdRqgSl/1uRwmHTi7lCzgPcceBssaih0OWYO+Sk?=
 =?us-ascii?Q?qhgJsADw6aJAyR1gI4UnVPJmAU0iHGXl5eNSzW8uk/78JwvFIwhNltHtjLUz?=
 =?us-ascii?Q?JUjxyjGMbZXfbtcsVNOI5b3x/V4eoC59w91o6KGU0PikozIJOqQFDpSGTdJt?=
 =?us-ascii?Q?dpk/BgLOau63lfK7enX3UCIxUXAz7eKF8lAeITtJeCY9ym1JbK8q9webXqid?=
 =?us-ascii?Q?mwSQSolHMosG+iVzzuGzIuj49HaL+z5ZjO9bY5op2Ec8TGgMic0/XlHtDgSl?=
 =?us-ascii?Q?NGbjp7+uLJAPfupMYECov/iCrW+oLY1TEcArrExYMy3ulkEQgzZLqSjkkhiF?=
 =?us-ascii?Q?a4tQeyQRMtcloHxQOU1nVFtaDY6DAUFhjprLvJ/5+pwB4J32umL2WujSZIJN?=
 =?us-ascii?Q?WKFagaivHm/6yWNk8wUI1P0mEZvM6KgS7QPmfbD/lvhleiM3Kor/c/0G7XOZ?=
 =?us-ascii?Q?jEEzh7KKBrXpECbHyX4XNXXt7Jdd140dwjTLA9aIw/0QQyH3ts7GBHlccFbO?=
 =?us-ascii?Q?1B8Zn6cCDxiLcl7flY6UiH9gJPOQa4AmDQFhTMHKnGEMtpMK1+ChYRZxDbes?=
 =?us-ascii?Q?CbvgcKe9a52Dajkjt/7wQTk8xxTLq5JsP1Y/8n805ebsq8hXJOtNQ41LVEBh?=
 =?us-ascii?Q?ybg+4QMfCk0w6qcXaLanPdvfxuwVDZBwx2rpXpbKx+ifG72IKy1whgwGbuXd?=
 =?us-ascii?Q?ld146DlX6gbTrHGusGylltB3ByZi3yTJHbcrr9usdS0IvMIh7V9ifP6CdroR?=
 =?us-ascii?Q?O4Wq51DF6XByW66UuY83WGMws97UyQl96EGJgOufH/ESCeyYrcazMrV1zt8z?=
 =?us-ascii?Q?qEZjhFCP7gqwXnGqC0efZvefIYLMFNsqBepw+pBgqzsANG+nkYkdo2HrFqNk?=
 =?us-ascii?Q?tkXE2Dx0FjEZpx7kkJq42Nrcu6Zf9r2bSYHW5QDgQcNA3tzBgbFs2XOAuWVT?=
 =?us-ascii?Q?MRDDJMgPYwxqu651T1DF9bkcJdcn8A7/1HqF8Vna7umXtm6LExeGTn/i+J5+?=
 =?us-ascii?Q?vvzCh9bP5nGMrhMXdPPthENFzqbmlUl7E9z3vJEC3/oWlMe9vmRCv6+ZeuMm?=
 =?us-ascii?Q?OOqw9KGwpcmwWcBYTY09LBLfuQ0ZHvKDBzojfVNJAX/BP747VvFwMV2gMV8g?=
 =?us-ascii?Q?m+zlSMYgC5Ap9vx0QMe4xlkS43vMMVffVVQ3yAkm7QLBsJNboY2zNosqYxui?=
 =?us-ascii?Q?+KMBe6tYRjCB5kZj6cFWL4LCOzHcOo1Wohn/UBf1vYtE5STPEcv10aLlTxV2?=
 =?us-ascii?Q?Nqe70gqcLtJ6qL28UoMoe4Hqs8lIpNzyn3OXiHgi2pP2cvlRSormXqBQTama?=
 =?us-ascii?Q?KIAwZ/OFEtU7UjIIbkjjq6DR1b9YVixWcN7+N/QkGN4G9A5rf21wRJuumirl?=
 =?us-ascii?Q?RFsIhtXTakUbAbjrJ+jkJvzFNTsE1KgoCYYMzwCGbsBVbG0O+WSeQwgdqKDO?=
 =?us-ascii?Q?Uw0AZ1nhqUCdQust0CQScqKmKmnft7KfI+QAbcMTHYu5F27Y?=
Content-Type: multipart/mixed;
 boundary="_002_DM6PR12MB2619529F8A58B49D2244745EE4E99DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16871a6c-ae9e-4ae4-72db-08da195acb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 12:24:57.3214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvQJ/Jbtfg6U5mZblJPweo00ntBjahzHwZJxBVTM3mjbXiQ7gH4KWE83WOIPO23q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM6PR12MB2619529F8A58B49D2244745EE4E99DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Arthur,

Please give the attached patch a try and let me know the result.

Thanks,
Evan
> -----Original Message-----
> From: Quan, Evan
> Sent: Saturday, April 2, 2022 9:32 AM
> To: 'Arthur Marsh' <arthur.marsh@internode.on.net>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
> amdgpu_dpm.c
>=20
> [AMD Official Use Only]
>=20
> Thanks for the confirming. I probably know the root cause.
> Let me prepare an official patch for you.
>=20
> BR
> Evan
> > -----Original Message-----
> > From: Arthur Marsh <arthur.marsh@internode.on.net>
> > Sent: Friday, April 1, 2022 8:19 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> Christian
> > <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> > Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org;
> > arthur.marsh@internode.on.net
> > Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
> > amdgpu_dpm.c
> >
> > Hi, short answer is that with both patches applied, I am successfully
> > running the amdgpu kernel module on radeonsi (plasma desktop on X.org).
> >
> > I confirmed that CONFIG_LOCKDEP_SUPPORT=3Dy is enabled in the kernel.
> >
> > With the first patch applied and remotely connecting to the machine
> > and loading amdgpu via:
> >
> > modprobe amdgpu si_support=3D1 gpu_recovery=3D1
> >
> > the last lines of dmesg were:
> >
> > [  264.095969] [drm] Found UVD firmware Version: 64.0 Family ID: 13 [
> > 264.097779] [drm] PCIE gen 2 link speeds already enabled [
> > 264.648137] [drm] UVD initialized successfully.
> > [  264.648696] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per
> > SH 5, active_cu_number 8 [  264.984814] [drm] Initialized amdgpu
> > 3.46.0 20150101 for 0000:01:00.0 on minor 0 [  265.040280] fbcon:
> > amdgpudrmfb (fb0) is primary device
> >
> > After applying the second patch and building and restarting with the
> > new kernel, I could load amdgpu successfuly and start the plasma
> > desktop under X.org, with the last amdgpu load lines being:
> >
> > [  227.736281] fbcon: amdgpudrmfb (fb0) is primary device [
> > 227.760719] Console: switching to colour frame buffer device 240x67 [
> > 227.765024] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer
> > device
> >
> > I tried building a kernel with just the second patch and that
> > experienced a lockup after apparently loading amdgpu alright.
> >
> > First and second patches combined:
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > index 89fbee568be4..e9ebbc9f4cd2 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -80,8 +80,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> > amdgpu_device *adev, uint32_t block
> >  		return 0;
> >  	}
> >
> > -	mutex_lock(&adev->pm.mutex);
> > -
> >  	switch (block_type) {
> >  	case AMD_IP_BLOCK_TYPE_UVD:
> >  	case AMD_IP_BLOCK_TYPE_VCE:
> > @@ -102,8 +100,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> > amdgpu_device *adev, uint32_t block
> >  	if (!ret)
> >  		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
> >
> > -	mutex_unlock(&adev->pm.mutex);
> > -
> >  	return ret;
> >  }
> >
> > @@ -423,9 +419,7 @@ void amdgpu_dpm_compute_clocks(struct
> > amdgpu_device *adev)
> >  	if (!pp_funcs->pm_compute_clocks)
> >  		return;
> >
> > -	mutex_lock(&adev->pm.mutex);
> >  	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
> > -	mutex_unlock(&adev->pm.mutex);
> >  }
> >
> >  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool
> enable)
> >
> > Thanks for the assistance!
> >
> > Arthur.

--_002_DM6PR12MB2619529F8A58B49D2244745EE4E99DM6PR12MB2619namp_
Content-Type: application/octet-stream;
	name="0001-drm-amd-pm-fix-the-deadlock-issue-observed-on-SI.patch"
Content-Description:  0001-drm-amd-pm-fix-the-deadlock-issue-observed-on-SI.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-pm-fix-the-deadlock-issue-observed-on-SI.patch";
	size=6277; creation-date="Fri, 08 Apr 2022 12:21:38 GMT";
	modification-date="Fri, 08 Apr 2022 12:24:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYTc0YzU5YmVlN2JhNGFkYjIzMTQxOTM3NjljNmZiMmIwZWNiOGJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBG
cmksIDggQXByIDIwMjIgMTk6NTE6MzQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bt
OiBmaXggdGhlIGRlYWRsb2NrIGlzc3VlIG9ic2VydmVkIG9uIFNJCgpCeSBwbGFjaW5nIHRob3Nl
IHVucmVsYXRlZCBjb2RlIG91dHNpZGUgb2YgYWRldi0+cG0ubXV0ZXgKcHJvdGVjdGlvbnMgb3Ig
cmVzdHJ1Y3R1cmluZyB0aGUgY2FsbCBmbG93LCB3ZSBjYW4gZWxpbWluYXRlCnRoZSBkZWFkbG9j
ayBpc3N1ZS4gVGhpcyBjb21lcyB3aXRoIG5vIHJlYWwgbG9naWNzIGNoYW5nZS4KClNpZ25lZC1v
ZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+CkNoYW5nZS1JZDogSTc1ZGU0MzUw
ZDljMjUxN2FiYTBkNmFkYzEyZTFiYzY5NDMwZmQ4MDAKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2FtZGdwdV9kcG0uYyAgICAgICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrCiAuLi4v
Z3B1L2RybS9hbWQvcG0vbGVnYWN5LWRwbS9sZWdhY3lfZHBtLmMgICAgfCAxMCAtLS0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jICAgIHwgMzUgLS0tLS0tLS0t
LS0tLS0tLS0KIC4uLi9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jICB8
IDEwIC0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMKaW5kZXggNTUwNGQ4MWM3N2I3Li43
MmU3YjVkNDBhZjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2Rw
bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jCkBAIC00MjcsNiAr
NDI3LDcgQEAgaW50IGFtZGdwdV9kcG1fcmVhZF9zZW5zb3Ioc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIGVudW0gYW1kX3BwX3NlbnNvcnMgc2Vuc28KIHZvaWQgYW1kZ3B1X2RwbV9jb21wdXRl
X2Nsb2NrcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAljb25zdCBzdHJ1Y3QgYW1k
X3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBvd2VycGxheS5wcF9mdW5jczsKKwlpbnQgaTsK
IAogCWlmICghYWRldi0+cG0uZHBtX2VuYWJsZWQpCiAJCXJldHVybjsKQEAgLTQzNCw2ICs0MzUs
MTUgQEAgdm9pZCBhbWRncHVfZHBtX2NvbXB1dGVfY2xvY2tzKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCWlmICghcHBfZnVuY3MtPnBtX2NvbXB1dGVfY2xvY2tzKQogCQlyZXR1cm47CiAK
KwlpZiAoYWRldi0+bW9kZV9pbmZvLm51bV9jcnRjKQorCQlhbWRncHVfZGlzcGxheV9iYW5kd2lk
dGhfdXBkYXRlKGFkZXYpOworCisJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7IGkr
KykgeworCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsKKwkJaWYg
KHJpbmcgJiYgcmluZy0+c2NoZWQucmVhZHkpCisJCQlhbWRncHVfZmVuY2Vfd2FpdF9lbXB0eShy
aW5nKTsKKwl9CisKIAltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7CiAJcHBfZnVuY3MtPnBt
X2NvbXB1dGVfY2xvY2tzKGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUpOwogCW11dGV4X3VubG9j
aygmYWRldi0+cG0ubXV0ZXgpOwpAQCAtNDQzLDYgKzQ1MywyMCBAQCB2b2lkIGFtZGdwdV9kcG1f
ZW5hYmxlX3V2ZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpCiB7CiAJ
aW50IHJldCA9IDA7CiAKKwlpZiAoYWRldi0+ZmFtaWx5ID09IEFNREdQVV9GQU1JTFlfU0kpIHsK
KwkJbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOworCQlpZiAoZW5hYmxlKSB7CisJCQlhZGV2
LT5wbS5kcG0udXZkX2FjdGl2ZSA9IHRydWU7CisJCQlhZGV2LT5wbS5kcG0uc3RhdGUgPSBQT1dF
Ul9TVEFURV9UWVBFX0lOVEVSTkFMX1VWRDsKKwkJfSBlbHNlIHsKKwkJCWFkZXYtPnBtLmRwbS51
dmRfYWN0aXZlID0gZmFsc2U7CisJCX0KKwkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5wbS5tdXRleCk7
CisKKwkJYW1kZ3B1X2RwbV9jb21wdXRlX2Nsb2NrcyhhZGV2KTsKKwkJcmV0dXJuOworCX0KKwog
CXJldCA9IGFtZGdwdV9kcG1fc2V0X3Bvd2VyZ2F0aW5nX2J5X3NtdShhZGV2LCBBTURfSVBfQkxP
Q0tfVFlQRV9VVkQsICFlbmFibGUpOwogCWlmIChyZXQpCiAJCURSTV9FUlJPUigiRHBtICVzIHV2
ZCBmYWlsZWQsIHJldCA9ICVkLiBcbiIsCkBAIC00NTMsNiArNDc3LDIxIEBAIHZvaWQgYW1kZ3B1
X2RwbV9lbmFibGVfdmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSkK
IHsKIAlpbnQgcmV0ID0gMDsKIAorCWlmIChhZGV2LT5mYW1pbHkgPT0gQU1ER1BVX0ZBTUlMWV9T
SSkgeworCQltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7CisJCWlmIChlbmFibGUpIHsKKwkJ
CWFkZXYtPnBtLmRwbS52Y2VfYWN0aXZlID0gdHJ1ZTsKKwkJCS8qIFhYWCBzZWxlY3QgdmNlIGxl
dmVsIGJhc2VkIG9uIHJpbmcvdGFzayAqLworCQkJYWRldi0+cG0uZHBtLnZjZV9sZXZlbCA9IEFN
RF9WQ0VfTEVWRUxfQUNfQUxMOworCQl9IGVsc2UgeworCQkJYWRldi0+cG0uZHBtLnZjZV9hY3Rp
dmUgPSBmYWxzZTsKKwkJfQorCQltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKKworCQlh
bWRncHVfZHBtX2NvbXB1dGVfY2xvY2tzKGFkZXYpOworCQlyZXR1cm47CisJfQorCiAJcmV0ID0g
YW1kZ3B1X2RwbV9zZXRfcG93ZXJnYXRpbmdfYnlfc211KGFkZXYsIEFNRF9JUF9CTE9DS19UWVBF
X1ZDRSwgIWVuYWJsZSk7CiAJaWYgKHJldCkKIAkJRFJNX0VSUk9SKCJEcG0gJXMgdmNlIGZhaWxl
ZCwgcmV0ID0gJWQuIFxuIiwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vbGVn
YWN5LWRwbS9sZWdhY3lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0v
bGVnYWN5X2RwbS5jCmluZGV4IDk2MTNjNjE4MWMxNy4uZDNmZTE0OWQ4NDc2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0vbGVnYWN5X2RwbS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vbGVnYWN5LWRwbS9sZWdhY3lfZHBtLmMKQEAgLTEwMjgsMTYg
KzEwMjgsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9kcG1fY2hhbmdlX3Bvd2VyX3N0YXRlX2xvY2tl
ZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHZvaWQgYW1kZ3B1X2xlZ2FjeV9kcG1fY29t
cHV0ZV9jbG9ja3Modm9pZCAqaGFuZGxlKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwotCWludCBpID0gMDsKLQotCWlmIChh
ZGV2LT5tb2RlX2luZm8ubnVtX2NydGMpCi0JCWFtZGdwdV9kaXNwbGF5X2JhbmR3aWR0aF91cGRh
dGUoYWRldik7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgaSsrKSB7Ci0J
CXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFkZXYtPnJpbmdzW2ldOwotCQlpZiAocmluZyAm
JiByaW5nLT5zY2hlZC5yZWFkeSkKLQkJCWFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOwot
CX0KIAogCWFtZGdwdV9kcG1fZ2V0X2FjdGl2ZV9kaXNwbGF5cyhhZGV2KTsKIApkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jCmluZGV4IGNhYWU1NDQ4N2Y5Yy4uNjMz
ZGFiMTRmNTFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0v
c2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5j
CkBAIC0zODkyLDQwICszODkyLDYgQEAgc3RhdGljIGludCBzaV9zZXRfYm9vdF9zdGF0ZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIH0KICNlbmRpZgogCi1zdGF0aWMgaW50IHNpX3NldF9w
b3dlcmdhdGluZ19ieV9zbXUodm9pZCAqaGFuZGxlLAotCQkJCSAgICAgdWludDMyX3QgYmxvY2tf
dHlwZSwKLQkJCQkgICAgIGJvb2wgZ2F0ZSkKLXsKLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKLQotCXN3aXRjaCAoYmxvY2tfdHlw
ZSkgewotCWNhc2UgQU1EX0lQX0JMT0NLX1RZUEVfVVZEOgotCQlpZiAoIWdhdGUpIHsKLQkJCWFk
ZXYtPnBtLmRwbS51dmRfYWN0aXZlID0gdHJ1ZTsKLQkJCWFkZXYtPnBtLmRwbS5zdGF0ZSA9IFBP
V0VSX1NUQVRFX1RZUEVfSU5URVJOQUxfVVZEOwotCQl9IGVsc2UgewotCQkJYWRldi0+cG0uZHBt
LnV2ZF9hY3RpdmUgPSBmYWxzZTsKLQkJfQotCi0JCWFtZGdwdV9sZWdhY3lfZHBtX2NvbXB1dGVf
Y2xvY2tzKGhhbmRsZSk7Ci0JCWJyZWFrOwotCWNhc2UgQU1EX0lQX0JMT0NLX1RZUEVfVkNFOgot
CQlpZiAoIWdhdGUpIHsKLQkJCWFkZXYtPnBtLmRwbS52Y2VfYWN0aXZlID0gdHJ1ZTsKLQkJCS8q
IFhYWCBzZWxlY3QgdmNlIGxldmVsIGJhc2VkIG9uIHJpbmcvdGFzayAqLwotCQkJYWRldi0+cG0u
ZHBtLnZjZV9sZXZlbCA9IEFNRF9WQ0VfTEVWRUxfQUNfQUxMOwotCQl9IGVsc2UgewotCQkJYWRl
di0+cG0uZHBtLnZjZV9hY3RpdmUgPSBmYWxzZTsKLQkJfQotCi0JCWFtZGdwdV9sZWdhY3lfZHBt
X2NvbXB1dGVfY2xvY2tzKGhhbmRsZSk7Ci0JCWJyZWFrOwotCWRlZmF1bHQ6Ci0JCWJyZWFrOwot
CX0KLQlyZXR1cm4gMDsKLX0KLQogc3RhdGljIGludCBzaV9zZXRfc3dfc3RhdGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJcmV0dXJuIChhbWRncHVfc2lfc2VuZF9tc2dfdG9fc21j
KGFkZXYsIFBQU01DX01TR19Td2l0Y2hUb1N3U3RhdGUpID09IFBQU01DX1Jlc3VsdF9PSykgPwpA
QCAtODEyNSw3ICs4MDkxLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRfcG1fZnVuY3Mgc2lf
ZHBtX2Z1bmNzID0gewogCS5wcmludF9wb3dlcl9zdGF0ZSA9ICZzaV9kcG1fcHJpbnRfcG93ZXJf
c3RhdGUsCiAJLmRlYnVnZnNfcHJpbnRfY3VycmVudF9wZXJmb3JtYW5jZV9sZXZlbCA9ICZzaV9k
cG1fZGVidWdmc19wcmludF9jdXJyZW50X3BlcmZvcm1hbmNlX2xldmVsLAogCS5mb3JjZV9wZXJm
b3JtYW5jZV9sZXZlbCA9ICZzaV9kcG1fZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwsCi0JLnNldF9w
b3dlcmdhdGluZ19ieV9zbXUgPSAmc2lfc2V0X3Bvd2VyZ2F0aW5nX2J5X3NtdSwKIAkudmJsYW5r
X3Rvb19zaG9ydCA9ICZzaV9kcG1fdmJsYW5rX3Rvb19zaG9ydCwKIAkuc2V0X2Zhbl9jb250cm9s
X21vZGUgPSAmc2lfZHBtX3NldF9mYW5fY29udHJvbF9tb2RlLAogCS5nZXRfZmFuX2NvbnRyb2xf
bW9kZSA9ICZzaV9kcG1fZ2V0X2Zhbl9jb250cm9sX21vZGUsCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKaW5kZXggZGJlZDcyYzFlMGM2Li4x
ZWI0ZTYxM2IyN2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5
L2FtZF9wb3dlcnBsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9h
bWRfcG93ZXJwbGF5LmMKQEAgLTE1MDMsMTYgKzE1MDMsNiBAQCBzdGF0aWMgdm9pZCBwcF9wbV9j
b21wdXRlX2Nsb2Nrcyh2b2lkICpoYW5kbGUpCiB7CiAJc3RydWN0IHBwX2h3bWdyICpod21nciA9
IGhhbmRsZTsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGh3bWdyLT5hZGV2OwotCWlu
dCBpID0gMDsKLQotCWlmIChhZGV2LT5tb2RlX2luZm8ubnVtX2NydGMpCi0JCWFtZGdwdV9kaXNw
bGF5X2JhbmR3aWR0aF91cGRhdGUoYWRldik7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01B
WF9SSU5HUzsgaSsrKSB7Ci0JCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFkZXYtPnJpbmdz
W2ldOwotCQlpZiAocmluZyAmJiByaW5nLT5zY2hlZC5yZWFkeSkKLQkJCWFtZGdwdV9mZW5jZV93
YWl0X2VtcHR5KHJpbmcpOwotCX0KIAogCWlmICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9y
dChhZGV2KSkgewogCQlhbWRncHVfZHBtX2dldF9hY3RpdmVfZGlzcGxheXMoYWRldik7Ci0tIAoy
LjI5LjAKCg==

--_002_DM6PR12MB2619529F8A58B49D2244745EE4E99DM6PR12MB2619namp_--
