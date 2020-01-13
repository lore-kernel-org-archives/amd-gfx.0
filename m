Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB99C33CAA
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 03:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE39F206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 03:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mcjtMLET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39F206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F92F89AA7;
	Mon, 13 Jan 2020 03:39:46 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690083.outbound.protection.outlook.com [40.107.69.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC1E89AA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 03:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBvT7gaB65zAzk+cr9Oac509E0hiXcALTWc7IPPSoxsS9sy5/1jXzK3aDn13dUIdlaEQ0j1NN3SDEZM/azc2CykuissLT/bAyyEmyWmL0rXz+dZOS0feGy7i5DZu7YUZm7XO10PPdawY3pMGv+uKOeIYVKLGo95lLmSssDGndMLn6iDGjhC06Q8UpXoEDhBojMUSgICDk1npFeMS91uVEDHSjngG5+HDsgUZQTp4HYLwQX2qe5bO6/EJ+RnUrUyYCgifb/Wr/MmpspYM3yoNqAVNnnzQC5KjPN5tqY63XxG76kDndERBDHSxKrzD3+5JuEQFFoSrIw2zVMZzaskweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6x0H1gncYU7s5dbvA2Cpv05ZBPXQaWcVSrALwyd2e8=;
 b=Eaidg+X+dMaSIAHYJEjrF0st6tH5InOmjETCggmMCJ0IUTFPKfUMxd21o0y35w6B0piRPPSdDTQ17wPAMqGiKkIoCcIiWahONUgMGWQ2WJ+Mj+4diRRb1hWELCpTzQbWHoNVZjRWUiMWXoeNb4EqsDh1FWWNsO5xSru5QH3tFzHK7I1VCb2cggyaTMLy1TfeKsMoM+OM0NNzySQU9G/z5GxCSeLjg9OWvU/dtixvsepyPEIjrPZpSFllmPFnPvYIz3JpmB0+sWpGAg8gmgux8mFSgU4ctI2cfsAPUnHEcoZZnu9ae47s8kpIjgBOcJD3WYsr4CChiDg+a6B2MFyOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6x0H1gncYU7s5dbvA2Cpv05ZBPXQaWcVSrALwyd2e8=;
 b=mcjtMLET8IULKJD3pRWkwkfRjg3f/Bw6+xIYVrxvkx8qa8OsEAYLE/bl08DGDnlJJJ8YzE0UkfPK/BCSNKXSLM8lGu6uKcVF+JC7pS9SeE/ZNaR5VZS05XEnE6UGkG7ps02pEafCNKS18HteC1eNCBse4pyUQMyWQmEmmGeqq94=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 03:39:42 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 03:39:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix the null pointer issue on
 switching power profile
Thread-Topic: [PATCH] drm/amd/powerplay: fix the null pointer issue on
 switching power profile
Thread-Index: AQHVyboQHNbJtfZd8ka6sGG5S9BB16fn8iEQ
Date: Mon, 13 Jan 2020 03:39:42 +0000
Message-ID: <MN2PR12MB33442C6322B92936D4ACBB91E4350@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1578882870-22736-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1578882870-22736-1-git-send-email-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8c3802f2-9c62-4723-b2de-0000bc4174e7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-13T03:37:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 213451ea-d00a-4174-6b28-08d797da39bd
x-ms-traffictypediagnostic: MN2PR12MB3775:|MN2PR12MB3775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB377503529F640936138039B2E4350@MN2PR12MB3775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(45080400002)(54906003)(5660300002)(316002)(86362001)(110136005)(966005)(52536014)(4326008)(478600001)(55016002)(9686003)(33656002)(26005)(2906002)(186003)(6506007)(53546011)(81166006)(81156014)(66556008)(8676002)(76116006)(8936002)(66476007)(66946007)(64756008)(7696005)(71200400001)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3775;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+5ws/bQT2BOr1RirTHdgDbOfFYiSgCP9zHNxgIyI7grPpoKB8iqtsXHnkr+X7ee7pKU78XSX3OU6CLhoNzY2yB35bOdPAjr5BOTrVHa7UVzY/orn5n+lws31hPUS+walUiShYeUdieTXyVDuK++buZI9HB0PEBdfh9S/G9TvS6DmArmKZ+gLCSkmk/202c5/jIqsqNsquUl61biiMP8Md4sZL+ikSAEn0gTrzyrh6hTeX/sxWNhu9d0vzq0Zk0cAJBGW0ZqJQE/sVNsg2TJ55u6u0FFBT8VW2Nt7WRTZM/LS69WnJN614XQa/G3LS/1hxHJ3E5pc7fctvNXs8TtWNEl7VXF939DIu3LXRcrcJW8SotEowrNr64Zi3F2hMu+aX5Z1Q+FhSY9OAetZCH9o7u/mmzmRSXqleqbYiZsLulp5M0P7iY5YH61FbPnnI7CcBWVemYCdADXqUaNN2z00LUlAbu5zn1hKnMDIs8kI+g=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213451ea-d00a-4174-6b28-08d797da39bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 03:39:42.0985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj9ZMxbMhaIw9vBDnGnZQDgp2Kezt56hROOFIiGvGY9gQg2EiRVrVKR/yOp5j8X6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There was a same fix from Felix to address this.

Regards,
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang
> Rui
> Sent: Monday, January 13, 2020 10:35 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: [PATCH] drm/amd/powerplay: fix the null pointer issue on switching
> power profile
> 
> Fix the wrong input parameter of powerplay callback
> amdgpu_dpm_switch_power_profile which is encountered by kfd test.
> 
> [  176.758381] BUG: kernel NULL pointer dereference, address:
> 0000000000000220 [  176.758409] #PF: supervisor read access in kernel mode
> [  176.758424] #PF: error_code(0x0000) - not-present page [  176.758440] PGD
> 80000003f6eea067 P4D 80000003f6eea067 PUD 3ce06c067 PMD 0
> [  176.758461] Oops: 0000 [#1] SMP PTI
> [  176.758473] CPU: 5 PID: 2621 Comm: kfdtest Tainted: G           OE
> 5.4.0-rc7-custom #1
> [  176.758496] Hardware name: System manufacturer System Product
> Name/TUF Z370-PLUS GAMING, BIOS 0612 03/01/2018 [  176.758593] RIP:
> 0010:pp_dpm_switch_power_profile+0x46/0x1ee [amdgpu] [  176.758613]
> Code: 00 48 89 45 d8 31 c0 48 85 ff 0f 84 9f 01 00 00 48 89 fb 41
> 89 f4 41 89 d5 80 7f 15 00 0f 84 96 01 00 00 48 8b 87 78 02 00 00 <48> 83 b8
> 20
> 02 00 00 00 0f 84 ba 00 00 00 83 fe 05 0f 87 82 01 00 [  176.758663] RSP:
> 0018:ffffa530c12ebb50 EFLAGS: 00010282 [  176.758678] RAX:
> 0000000000000000 RBX: ffff9797c0b00000 RCX: 0000000000000000
> [  176.758698] RDX: 0000000000000001 RSI: 0000000000000005 RDI:
> ffff9797c0b00000 [  176.758718] RBP: ffffa530c12ebb80 R08: ffff9797ce221548
> R09: 000000000000036c [  176.758739] R10: ffffffff94006a80 R11:
> 00000000ffffffff R12: 0000000000000005 [  176.758759] R13:
> 0000000000000001 R14: ffff9797fff4dda8 R15: ffff9797ce221548 [  176.758779]
> FS:  00007efe09cc3780(0000) GS:ffff979826940000(0000)
> knlGS:0000000000000000
> [  176.758802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  176.758819] CR2: 0000000000000220 CR3: 00000003cdc70003 CR4:
> 00000000003606e0 [  176.758839] DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000 [  176.758859] DR3:
> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  176.758879] Call Trace:
> [  176.758932]  amdgpu_dpm_switch_power_profile+0x4c/0x6f [amdgpu]
> [  176.758995]  amdgpu_amdkfd_set_compute_idle+0x1a/0x1c [amdgpu]
> [  176.759056]  kfd_inc_compute_active+0x29/0x2b [amdgpu] [  176.759117]
> register_process+0x11c/0x14f [amdgpu] [  176.759177]
> pqm_create_queue+0x20b/0x527 [amdgpu] [  176.759234]
> kfd_ioctl_create_queue+0x4aa/0x5e5 [amdgpu] [  176.759294]
> kfd_ioctl+0x235/0x366 [amdgpu]
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index f7c0ae6..d3962e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -1123,7 +1123,8 @@ int amdgpu_dpm_switch_power_profile(struct
> amdgpu_device *adev,
>  		ret = smu_switch_power_profile(&adev->smu, type, en);
>  	else if (adev->powerplay.pp_funcs &&
>  		 adev->powerplay.pp_funcs->switch_power_profile)
> -		ret = adev->powerplay.pp_funcs->switch_power_profile(adev,
> type, en);
> +		ret = adev->powerplay.pp_funcs->switch_power_profile(adev-
> >powerplay.pp_handle,
> +								     type, en);
> 
>  	return ret;
>  }
> --
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cce7a462c82c94d51a9
> 6908d797d12d9d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 144797057908962&amp;sdata=LLvPWFsLxMKKk2upAUQAaG4E%2FfpNtWjt6G1
> mEpr78kg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
