Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FE4D2444F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 20:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D2410E9CF;
	Thu, 10 Oct 2024 20:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVrF/Kfp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC6A10E9CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 20:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvmGda2SyCqu0DyRjp/SxVB3G+XIscndup/G8VUD6LDlu2scJ5k3rZZ1PT6SbyIyceeb4YkRMhTXNvu749pIMBoxSAYcUsRpdbiZOPV93JXJxcNEm7grRAoktMFb0a4pnHWLv3Mlp1pMGkm8s3Vjs8peVLYaglMv2+KROYogq876va1oPw+i/xphXDRqLMpidSimXQg6D7X3BorMaEBRfhVT8GWh/CaTz8t5tJiduMHACbqp5TMtAJdwxm/8L/6hl2o4SlLrxr0A902YHh6wJJ4QXliDxR//fZD2wkmcIbnco+3mzDJE7fkAbHVDsy7H9SL0XaMCcUawChI+OyG9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8Dr3hAwEv11BkDv4s210Jdr4h7Gxc9NeH/czmYjnOk=;
 b=nwSsQZ9hFvw5DaM7WnKZHPgNEnR/0hr8cJxaQ6kTxajyU0ZAdHKWCyamGk5gjO0u3Aayg6wxaCi3c+1oKLIWIxpnyyqb1FqloNhbQ1RMnXJVAfLKqZZ8kZOHScDKMFmkrq3ZDOHf9Xc+iVssLnTb69+qBmwhDnGS8EzafeVrWuQ6p3RmsjFjPp04H2mAqyAMACjeuq3lmnzmyWUu9WvdJWyR01YULRQ6oDn3Keo/861kfKnLJ/I4O+zpqGYNBeWZBHWTms5qRInXsrn1BVfMKrg2/s0Z6Yn5Gvh1myy3MUWeec6naMx/eNJZnVOZPHsJV8AdJlNIXB1NN+v+vwOYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8Dr3hAwEv11BkDv4s210Jdr4h7Gxc9NeH/czmYjnOk=;
 b=gVrF/Kfp1D/Yz8FpmaNZtLzd/jKfNPnlI/Mckh2gPnDOFSnYGBGi3D6aVCUCd/gomtQtDQbKfYFVE2vjnqd4UbMCtBTAQv66WZoL5JqPpKlF+89TA7qFZSosg6lQIIq/vMFRl0QMWf4+YD8BIqzYL1W7VTdz0X4gFXpBVzwDvlM=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:43:12 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 20:43:12 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Li, Yunxiang
 (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdkfd: cleanup device pointer dereference
 chains
Thread-Topic: [PATCH v2 1/2] drm/amdkfd: cleanup device pointer dereference
 chains
Thread-Index: AQHbGy/7/eOXO5R/gEyLp83OfHTatLKAcuqA
Date: Thu, 10 Oct 2024 20:43:12 +0000
Message-ID: <BL3PR12MB6425D26D8E09E100B72AD3A1EE782@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-1-Yunxiang.Li@amd.com>
In-Reply-To: <20241010161730.13416-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a5d73328-f7b0-45d4-9d64-c82ac9e4d535;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-10T20:40:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|MN2PR12MB4375:EE_
x-ms-office365-filtering-correlation-id: da8a371b-4357-4132-4537-08dce96c285d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dANMxI83SRbv9aG8fwQBZFTa+xhR/j/1k4OOVW2MrPt0K/2OMu2xTvGWgUGX?=
 =?us-ascii?Q?uzg+eDuksm51nVDvP7XEXc4e4+7FDgWSzQpjB5I0E7Npa/WlWQD+Bz7mIXsG?=
 =?us-ascii?Q?gW5EacVrBdCeek53M8an2+/A0FtUu3Rkf8IAVopV6QOJU27RkO5Y+XdV0Ifg?=
 =?us-ascii?Q?49w5l/mJwYvBChra0TII+OkhnQOCc4HwriiH+tLp5hJpMzOMf9/PoNdGgThb?=
 =?us-ascii?Q?PzyPmB5xusccwWeTnXE/qjFJJc0oZnM7N4QBbGtDTaLXjZfTVFcCxRnDlZav?=
 =?us-ascii?Q?k3CvHpZx9q76yb1D5r3JrAsjgKo0NjMGCcL3SYmsJlijOcCIdlnEx9JN4BPQ?=
 =?us-ascii?Q?AcUysp9URxMfWpt++D6G7CSsdip4gp3v1+s14eoiqsgttCGlqex0GGs+Yw+q?=
 =?us-ascii?Q?wSS/kbG1Ae/khfZ+P8PpfCjO83UkNNGFo7Q/KjKRWD+Cf65j3K33LEHJThYm?=
 =?us-ascii?Q?e6J69hK1eRmgVhv+YmwaR/mSaDheFpBnDIUZbHs5+mgNy4+Q3BLvzZ+kheaF?=
 =?us-ascii?Q?w7nrH5Bkwt0fR65oHWF9/hHLiDBPL5B9H0OeKZ1YLNpN8j7Iy2qbH6A8Q4OC?=
 =?us-ascii?Q?GTA6UOlkgoaEjfxBqxFAWBBWs0pqwDARY2LvAmgZN8dY3c5irmSJrzSJmD/y?=
 =?us-ascii?Q?RjPalqynRM7RzQPZnQ5qOapRfxDb9fRc/EWo+wauuaI+HqQG/BDiGkuYQlnj?=
 =?us-ascii?Q?dQqVaiGROF+Nlho/yj+y9KvSu02nxIwS0bNUBI9r+BS9WO4DTbwjasbRMGMw?=
 =?us-ascii?Q?KTw5qYKkG1DjqSgDceTMjlHGwrBBUCFlYDjtvA5UEcZ2DeQciVcVNbU4RN0y?=
 =?us-ascii?Q?MCN3mdc6v2r6Mc3eXhwewB3oc9k1+g+XJUXU3O85TKai7LoThsdjE/YLVtWK?=
 =?us-ascii?Q?h6Kzqj4yR8Tn7E6Nl+rI8OaoUIAMVlkVHSDrH+Xw482IK1YaNQYtWxB0v3u4?=
 =?us-ascii?Q?OyR+PP1VAWJrggfIdSR0BKLeI+xc54uWzinIeOkjOC1jE/yoi8SwFBjfTVLl?=
 =?us-ascii?Q?3fhClUlPy/eG/vJb9dg9FXyGV0gCC1t10nEIUpLNsD/65rDfj7AkflvAdr0m?=
 =?us-ascii?Q?5fFAOciZcHE0exEt560K6aOD84ocV6LZAJgAEKKjGX+mmArk+m4KmtgLjEST?=
 =?us-ascii?Q?z68/8VGhAMWQg7Yey27i9vQ1Iw27dnetpmN75bhfBjF3jpFo2XoSE41Gs1Mm?=
 =?us-ascii?Q?0KZdC0de4+83VSYO5ZSo9IRXm/SJiFiJ/DiAb/Gh3Vowh1m77eigYota3P5l?=
 =?us-ascii?Q?GZLY0TRpBe5OljfRlyRtdmPFtaKmTTHlSCa+QJ1b26Wi30bkWYi2VJZHVtdE?=
 =?us-ascii?Q?yYCSSBf3iuXF6Fb/hl73TMpDEurbEkaQldWpxm5iNzolQw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uSw/7VJIoKUZ3fNAGTxLp0bUIZQWRncSH7w0acpYiCWlDmVT/liHAWYk15C7?=
 =?us-ascii?Q?Bss8fEV6RXAmIaRyvK9KaYov5NU/D2Zqe1qRtEX6Ey6PeiQcDJ95ReIhh/uI?=
 =?us-ascii?Q?LhtpEmHWq4zTfoYHCfaKOSWH192O9dUOP+QSYhvMFzdmpgDhZUZKIdcdRJcS?=
 =?us-ascii?Q?yj5x6hI0tI5kl6lciY7lFhuwBm2Wzog9Knef4Z8CqOWWjpUJMWzQBlcEG8NW?=
 =?us-ascii?Q?X6aoZxRzUeKIOSTt9G1XLWzi7Uk32PXpnlNhzkJiSuIwXjn538yOMxYL70Zc?=
 =?us-ascii?Q?SMN32XMKb/NjUxBn+OzM+axRalAHRy+aBVHcudS38zX/WUi6T5ndfBsu4eeF?=
 =?us-ascii?Q?4xTh1wcRSF3bC35mvIPt0Vcujk4Y+J8w9cJzC+wvI+gwjMrpCKwejcs4xuSf?=
 =?us-ascii?Q?ZNk3iuGwDs5lrx+0iPDVcRO9uTeuUgNJxqkVc1HcHCTv339SkI0DkRc4pCyo?=
 =?us-ascii?Q?jhJvE3ICAPG9jbprCX32Cv3ULWAQmKai00Tz4n+06Njy2/XWlLDDfQKLbHn2?=
 =?us-ascii?Q?8FkXgWOUw8zp3aasta9ppL9fqp7K4+j4dmzzRiXKHXWAVbqmdywIcqbkTB4Z?=
 =?us-ascii?Q?J0QLlh90x0LCowMjGgHIMP3rFujGo2bJOyCieI+0Sir5ZafdKLoWtXS2Ov3u?=
 =?us-ascii?Q?SXTm98qVI4YUBpS12zjyAY9X5lUBJO8y8LiDJdCIAhLXMuayAX0skJ36lnfq?=
 =?us-ascii?Q?FCBdwVRqRtSMg2BAeKmPxGo4lFdAazlXAsTRArUgylp0aJbk7eXrVDJC+5yR?=
 =?us-ascii?Q?iiEbpggJLP8UVSOiGnmYbIkXl//7A2XrY7ysbzVicYfvvQxCJHbSGkx0pDmp?=
 =?us-ascii?Q?MxhCjUuNMFh3wdUeh74//Hdhw73wKuMipmFz0GKv67ErUyPvxOrF2I5bzR8m?=
 =?us-ascii?Q?IS742JchTZm0i13DYsb0SSYHVoy8V0e1EVetZojbgPLHO7wqPaMAG5/Buw1f?=
 =?us-ascii?Q?os6z3dYHrxAV7kGcdDzoWyac3pCHCSEhtMaFGsUabyjDH7DcrkhW66zcu1sm?=
 =?us-ascii?Q?2rBDmaXGodTCbDUWnR7jbyBeZcRN58Ef1+bj/gkdR7Svn525JL3kDlXVRs/w?=
 =?us-ascii?Q?Vb88n07E1oP3ly/afl3CLTvIn8tvC9TvjQqRyjZ/LD2Ktk8tLW3hxAP3lqit?=
 =?us-ascii?Q?+qlUZfKEhP5hD36yIE16G9Z0MAR9ViSOl1twHdB9z9XrfDywgCLZ9PL8Fols?=
 =?us-ascii?Q?YGwY/gOD1nqu6W9v6AuTVitrZIHX1WYXwVcqlavY6MxgQIbDN/tyiGW4E1sS?=
 =?us-ascii?Q?OwdR7tjHHm/xKU8mPoKMiDTveAzK8OPISxRsmZvyg99f9oyuC52QM7QiBauE?=
 =?us-ascii?Q?rqFWzvRfXVEzV0zgTuTooSeo+vIjIdj/y/QZjzNlmfOrCNp02F4m1ZAsJVcy?=
 =?us-ascii?Q?bMfdXnJEv/1V2Mk+1P3ux/0uQoi+pBYtbccUbQJPDvxMSV8BWKgC9M1fO6K/?=
 =?us-ascii?Q?rday5wnXyuISmZIR3Daj6oAJlGUyaYn51IwP4zBwpsLtIkWE83rHaScFUW1x?=
 =?us-ascii?Q?AqzVVe/eUMqxFUI4JucavI4p1N5nRASjJRidDSs+4VzDl7EL1l714TNqMXZo?=
 =?us-ascii?Q?A7UM1/C2Bx4Nv5sKxiY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8a371b-4357-4132-4537-08dce96c285d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 20:43:12.2605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbejK7cNGdq/csoT4e2l10n+5QjBaCoY12DDBCHA4bl/0MT7+N15FBuv2/RN2PW4Xpg3oQtUAqun6NvubQu2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

This patch is:
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxia=
ng
> Li
> Sent: Thursday, October 10, 2024 12:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Li, Yunxiang
> (Teddy) <Yunxiang.Li@amd.com>
> Subject: [PATCH v2 1/2] drm/amdkfd: cleanup device pointer dereference ch=
ains
>
> Pull out some duplicated dereference chains into variables, and in some c=
ases grab
> struct device pointer directly from amdgpu_device instead of via drm_devi=
ce.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 29 ++++++++++++------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d665ecdcd12fc..c9ce95bc3ec8e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1051,6 +1051,7 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>
>       for (i =3D 0; i < p->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D p->pdds[i];
> +             struct amdgpu_device *adev =3D pdd->dev->adev;
>
>               pr_debug("Releasing pdd (topology id %d) for process (pasid
> 0x%x)\n",
>                               pdd->dev->id, p->pasid);
> @@ -1059,8 +1060,8 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               kfd_process_device_destroy_ib_mem(pdd);
>
>               if (pdd->drm_file) {
> -                     amdgpu_amdkfd_gpuvm_release_process_vm(
> -                                     pdd->dev->adev, pdd->drm_priv);
> +                     amdgpu_amdkfd_gpuvm_release_process_vm(adev,
> +                                                            pdd->drm_pri=
v);
>                       fput(pdd->drm_file);
>               }
>
> @@ -1073,15 +1074,14 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               kfd_free_process_doorbells(pdd->dev->kfd, pdd);
>
>               if (pdd->dev->kfd->shared_resources.enable_mes)
> -                     amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> -                                                &pdd->proc_ctx_bo);
> +                     amdgpu_amdkfd_free_gtt_mem(adev, &pdd->proc_ctx_bo)=
;
>               /*
>                * before destroying pdd, make sure to report availability
>                * for auto suspend
>                */
>               if (pdd->runtime_inuse) {
> -                     pm_runtime_mark_last_busy(adev_to_drm(pdd->dev-
> >adev)->dev);
> -                     pm_runtime_put_autosuspend(adev_to_drm(pdd->dev-
> >adev)->dev);
> +                     pm_runtime_mark_last_busy(adev->dev);
> +                     pm_runtime_put_autosuspend(adev->dev);
>                       pdd->runtime_inuse =3D false;
>               }
>
> @@ -1606,6 +1606,8 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>                                                       struct kfd_process =
*p)
>  {
>       struct kfd_process_device *pdd =3D NULL;
> +     struct amdgpu_device *adev =3D dev->adev;
> +     struct device *bdev =3D adev->dev;
>       int retval =3D 0;
>
>       if (WARN_ON_ONCE(p->n_pdds >=3D MAX_GPU_INSTANCE)) @@ -
> 1631,14 +1633,14 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>       atomic64_set(&pdd->evict_duration_counter, 0);
>
>       if (dev->kfd->shared_resources.enable_mes) {
> -             retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
> +             retval =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
>                                               AMDGPU_MES_PROC_CTX_SIZE,
>                                               &pdd->proc_ctx_bo,
>                                               &pdd->proc_ctx_gpu_addr,
>                                               &pdd->proc_ctx_cpu_ptr,
>                                               false);
>               if (retval) {
> -                     dev_err(dev->adev->dev,
> +                     dev_err(bdev,
>                               "failed to allocate process context bo\n");
>                       goto err_free_pdd;
>               }
> @@ -1647,10 +1649,8 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>
>       p->pdds[p->n_pdds++] =3D pdd;
>       if (kfd_dbg_is_per_vmid_supported(pdd->dev))
> -             pdd->spi_dbg_override =3D pdd->dev->kfd2kgd->disable_debug_=
trap(
> -                                                     pdd->dev->adev,
> -                                                     false,
> -                                                     0);
> +             pdd->spi_dbg_override =3D
> +                     pdd->dev->kfd2kgd->disable_debug_trap(adev, false, =
0);
>
>       /* Init idr used for memory handle translation */
>       idr_init(&pdd->alloc_idr);
> @@ -1750,11 +1750,12 @@ struct kfd_process_device
> *kfd_bind_process_to_device(struct kfd_node *dev,
>                                                       struct kfd_process =
*p)
>  {
>       struct kfd_process_device *pdd;
> +     struct device *bdev =3D dev->adev->dev;
>       int err;
>
>       pdd =3D kfd_get_process_device_data(dev, p);
>       if (!pdd) {
> -             dev_err(dev->adev->dev, "Process device data doesn't exist\=
n");
> +             dev_err(bdev, "Process device data doesn't exist\n");
>               return ERR_PTR(-ENOMEM);
>       }
>
> @@ -1767,7 +1768,7 @@ struct kfd_process_device
> *kfd_bind_process_to_device(struct kfd_node *dev,
>        * pdd is destroyed.
>        */
>       if (!pdd->runtime_inuse) {
> -             err =3D pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
> +             err =3D pm_runtime_get_sync(bdev);
>               if (err < 0) {
>                       pm_runtime_put_autosuspend(adev_to_drm(dev->adev)-
> >dev);
>                       return ERR_PTR(err);
> --
> 2.34.1

