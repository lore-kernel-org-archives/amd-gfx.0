Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB5C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 07:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38D710E29F;
	Tue, 18 Jun 2024 07:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cmlBifQU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F8510E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 07:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij5AWC1ZZ80u/YnsKgn8LWhFZ4ES/X9fBu/DGWSQsmkKuv8VhCUH3OcyyjI8P3xZhyl4XURMygWZPKF/9gXb8Q5ibn/J7G7GQUVXhowbDQr3HvYglXM67QJdobtjelUPUQ6ghbJSYlUZBwIJi+vWddp4QFvXPMkXbslyYAr8V89K4zr/W72cVQAyfs6fAOOqc7KLkBbm4IGE3SbIhKjZpMjwXfl3btkW53SvvDnSJ7F7elF5sw0W18HW63FR8+VOS/DdawDIE40N6dy6ymJ/9J7brqE5uS7nwgR5vUNAk7iBzc+qvJz/oIs5rRepCu7rGol4LiocPzFxQ8cmaX9LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfOGDN+v36JT+SMzM1choOwQwgULNK61FObmFLuDnRY=;
 b=dHNdq6s6gBlxYMTZI6HJh+/EwMGlmdonJIAbAkutj0N7xG/OZNTI1rmTWOarQp4dojnoFRNzU8+XtTm1gYf3O99Sa4Tcc0JBrAmczTkVM3+S19p3mApHH1q/hanSkaupo8Gfs8DhL1VWomGtDSAuKDxVKwQCW+XSh9Gf8PXOGZZqBEAiawZ8YId9tQeptGHwUtJhni5KBiYC7ZiX2H6btAQSs4itvpR3o4facA+jLYB6ttbFHOOsQF7LwYpfo22bQ0RsgJXGsIhqfAhq7qsoE2x9H5lWmbE+Rv2Gey9qEvrDPSlKK/ta7LuGelrt0wfIzPCauCqq8bPuCKShdx+BEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfOGDN+v36JT+SMzM1choOwQwgULNK61FObmFLuDnRY=;
 b=cmlBifQUfu3q9wn/QmEB0sevpvWOoeMXbfq9hGUBGfu++JbFGx7njUTyw+0Ikm9lAyVJvZ0+Qzv1WzxkMWOQHmTgkyszqOjtVuGB9hQ0AJhfY2jkW/m4fTvo2CAVQipxZqB8SyyMI+wQsSaZGU+91gle4gDiR23a8nxwNUNhc7E=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 07:58:50 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7677.019; Tue, 18 Jun 2024
 07:58:49 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] Revert "drm/amdgpu: change aca bank error lock type
 to spinlock"
Thread-Topic: [PATCH 2/2] Revert "drm/amdgpu: change aca bank error lock type
 to spinlock"
Thread-Index: AQHawVP29pTlltGuvEO602F8/zbCM7HNJ1UQ
Date: Tue, 18 Jun 2024 07:58:49 +0000
Message-ID: <CH2PR12MB4215D1609BF877034D95E718FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240618074835.1439008-1-kevinyang.wang@amd.com>
 <20240618074835.1439008-2-kevinyang.wang@amd.com>
In-Reply-To: <20240618074835.1439008-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5bd122fc-b5f1-401b-bafe-586b16fa130d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T07:56:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SA3PR12MB7879:EE_
x-ms-office365-filtering-correlation-id: d575d4c6-a0e2-4388-a441-08dc8f6c7d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?fiK/fi1R+T0wZds4HCCZIrNODeD15kooxH8g6h8D38oz9bh3VQG7vKB0pcR6?=
 =?us-ascii?Q?XmsPDCrUPzu2NCHA2q2ni8h3JSFhmyyfjainQ9lQ9BkSv4VAfCPOCnqD5aIp?=
 =?us-ascii?Q?v4JKQO8oE02Vl7q9F+1OjrhFYM2VmYeQGJ/wrYS/JTe5KzfwAl7oqGVjpi/2?=
 =?us-ascii?Q?TtIM25d4hPo605m0OoX1DLh4UstDkceg6dNxE/wEJd3m989sVMx5xWLnBSoC?=
 =?us-ascii?Q?K/UeWf2el5tE4aT0i+4TUd5aTFOkrzSoR1qFjFMgzJcZsjCmtYrC/dOnH2Rl?=
 =?us-ascii?Q?NJngyZyIwACAihsr9y/wCJ6c/h1GUpg3CmSMZqlGp7wuy6PGRjH7WI9sgIHD?=
 =?us-ascii?Q?wkBScwokJafLTUlVScXrekf/K6PVRgcLWBIpIxja3oJTGRy7eZBuPNqaHF6B?=
 =?us-ascii?Q?/wi+GiBKljp9fxf++U5+jY6/8znEYL7Z/7aENM6Y+CPzF8c0lDm+MkLJuKut?=
 =?us-ascii?Q?6BwOz7UY72T56Ijz+qspPAI2ObZERYEt8czicQZfbObM3ad2Wc3AW4/wFo7d?=
 =?us-ascii?Q?SVCrnq4VJV4aD5DRFFoA28zMpUWbXsMHlo3P80N/Q15LpQZujoYMvZ9RecVK?=
 =?us-ascii?Q?L2yz25EsdOW9AIC9aMuHi/Wqufs9vrbLT9EozV0upah9RNXyJhyCJuYdJtR7?=
 =?us-ascii?Q?Rf517HeAl8sl5YH+d/JU2RwVSqoEmwczwciOCU6k2bvBzSge+4DAerF2mmEj?=
 =?us-ascii?Q?P/MOFdP/4fyzneqarW0m7Q9L1dQjytnJYlmYQEOr1cYIytKDItnQcIkKyLiR?=
 =?us-ascii?Q?TZlKQOEyVewEXTmYWVF6feBjP9BmxEzEu3ZW3tHt6yDAa4OPWAotqxxN9VFY?=
 =?us-ascii?Q?2Bveyp/vL6cEm5H6SM7A3GaqkPRzyRAyB/T4XQLTAPi/rF9vacCoed8B1KCC?=
 =?us-ascii?Q?jO/aM0PyxXeYWf9cbEetIvwehkE0dSNXvocMKQByBpkJHhNvFpAKzzCQvrR7?=
 =?us-ascii?Q?BPoV29iDhV9fv3EmyTu0DPuvi+Hpn7bnvxaNhdJ6VmN4NC7CFBOU/bR0fcYQ?=
 =?us-ascii?Q?6O1Sdgrnsyo3p1HPuRMlJZklic9qebWTkM8JCekwH/k9rutbCvU3EhQAxih+?=
 =?us-ascii?Q?Kf5Xn9jGMfu6n+knBxT5dAizciDSyDynmJElzsS3YPRXlfd3OCxtSY4qaJO5?=
 =?us-ascii?Q?WodnB+mMWNhmJgq6XyY2CBEzFe7AEl6P9gyykgOZ3pm+gmZ4lOD4E7wZX3y1?=
 =?us-ascii?Q?rC2+Qp9yeUF4+XStx30IPANwUvzN2efQFR/3r9OMQdWFvoTlVp43uDMquJDP?=
 =?us-ascii?Q?QRQ84GO4U/La10v6ZH54zmIC+sIgT3xrq+Nx06LPjpLJJGz1Tq0paH7UPRrG?=
 =?us-ascii?Q?7hoGSB+geTY4qsBFvR6/oUZlXrOXcsas6Ina8vPZVHNXWi9Htqx0lz1Z0URn?=
 =?us-ascii?Q?zL0agnw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ejleV5IUozL9Ot0rVYr3jCfvjlT7+Z90Gk43dVjI1oLOUJIEWKbXCoczljgx?=
 =?us-ascii?Q?L0/272djLyr9C/i1+6c6pSsQ3miPAYdIWFqjIkPUugz4X0xWR1sV2YoddmBu?=
 =?us-ascii?Q?8a75qkZalBgPxpRX/2izAAZ47/79U7Get4I3gio+Kq7WmrigBAPHUTToEuJq?=
 =?us-ascii?Q?GBx2hRHZUsSr32g4SDdcpDtlvs+g7EdWJmiFLTTFO2rJ+Fm1KcwBsEC6OMCQ?=
 =?us-ascii?Q?q97kCGWSScJ3yxx08hWpbk00dOmDTGMYtB+YLOnm9duOg7wfz9Fm7vEHUb5b?=
 =?us-ascii?Q?FjdqHlYmVaZTvrYlaMjoZwnIEv1HOcTTYDmc55aW29aWJY6B9MWAjpA+gEXr?=
 =?us-ascii?Q?202f90MNWW9gXFd88UGRfFD4kleypIquRUekR6tpDyIP8G6Mzvp0DSCIL5tI?=
 =?us-ascii?Q?qOAOg8nQT3Oq1wJC20zrVx7KiVngN6HHs3KJa7VQd0aq17PHp70AvoMFx+ET?=
 =?us-ascii?Q?/Uu24SqlPYaNjYvtkQzZyC3Hgqb4fpY19VRkU+sGs5uaoNt2oQhjRQMpkMVs?=
 =?us-ascii?Q?9NwlSdOxgVM59zkYahze1IVKCHcSnhAB9+HoDGVKJCBgSDKishIKGc9pSJii?=
 =?us-ascii?Q?Ur7Tujb1Y722KziXbVejiNWfAQpKKrqeo/YB4XcN/xmp524y38liy2AD3e1u?=
 =?us-ascii?Q?IZQL7CPParooqhl6uusxgcAl7oRognu46D0DsqR/Rh2KGS75JldFtfvUTexA?=
 =?us-ascii?Q?mX16RCTytDTIxiZKUPB3EXss2XYKOXk1hAgbMTMRmGVNMqaYwh0mAu3sz5DD?=
 =?us-ascii?Q?Xcr7vttOBMTcTM/WpfCAYJrwNXPqPO0QBjLLuJFybrTM/TGDYjAYhczndepg?=
 =?us-ascii?Q?RNNc+XlFyjku8bw54vUXDMMKokw2P1vhWur6FNl8G0/IbjMI6/NY8zRryPsG?=
 =?us-ascii?Q?ycyGr9g0vkPdYTNRt7K2wMQn3G2+cTrk72MZXMnG1odInz8RQRmZxTuNRZoG?=
 =?us-ascii?Q?gfsjxmd3Ks82Aq78jZQ1vK+K02Ugp4OZeAgmq9uG1pbunlp9tGIM4596GPse?=
 =?us-ascii?Q?tmohpRqdGp0MzIBerdw9UFMTNp1RpJ2Yn16YJFLdvqroBVff6bnp+QE8Mtfz?=
 =?us-ascii?Q?VL6/kCOoFQShUi4ydZOtJi28dGtfobCN3pPgI96lJKP9iJz0IlQW3cuVZ1cN?=
 =?us-ascii?Q?FOV6gNBawjsl1B3kP/iieBFlcZwvWay0AC4AEO6ij9JhqibQ+X4rp3Qvoy3Z?=
 =?us-ascii?Q?Vyd6A7xq62oAupFO+J9LqRx2lWrDJsiNITkFY6TQc1NmJl6VZomceUkuntg/?=
 =?us-ascii?Q?MfN8Ex+zat3WuVkowNv/tZwBEtG5G1ekBNma7p2YzWCEFpa2r8gwzZ8ZM37o?=
 =?us-ascii?Q?24ka/mcJy0WU6cnDcliSFFt3DmCV0kRYe1+omSt6eUlLHHawEYdVBajGXSwA?=
 =?us-ascii?Q?mhLfa+cSlj4ZStwczel10yZd6gzBYF1vgzjbdm6UP/eXp0CVpcJ9LZrvbIqA?=
 =?us-ascii?Q?+RoGZyDEGDlbcIcnearmZrlBXIAwZVjviIoLFE3gnTN/wFaHfIgqZoCkCuyi?=
 =?us-ascii?Q?OBQ1ATwjG2Rhq9lKuOizlyRKA0w/5BJop+5UVt44QHFD1eqgdN0a/VGdBYQ3?=
 =?us-ascii?Q?qroe7WrnoHPNT0iG0Y0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d575d4c6-a0e2-4388-a441-08dc8f6c7d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 07:58:49.6224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coDZ3+WrXg586zrOxQSrgsHSG4/TOf2m+nyXzg78vigabVcZeG3iEJdImigEXSvKyJrB5M+GsNxa10PfNxCsng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

Series is
Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, June 18, 2024 3:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu: change aca bank error lock type to=
 spinlock"

This reverts commit 354436e7905d166011f2aa26dccd9fa04b20940e.

Revert this patch to modify lock type back to 'mutex' to avoid kernel callt=
race issue.

[  602.668806] Workqueue: amdgpu-reset-dev amdgpu_ras_do_recovery [amdgpu] =
[  602.668939] Call Trace:
[  602.668940]  <TASK>
[  602.668941]  dump_stack_lvl+0x4c/0x70 [  602.668945]  dump_stack+0x14/0x=
20 [  602.668946]  __schedule_bug+0x5a/0x70 [  602.668950]  __schedule+0x94=
0/0xb30 [  602.668952]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.668955]  ? hrtimer_reprogram+0x77/0xb0 [  602.668957]  ? srso_alias_=
return_thunk+0x5/0xfbef5
[  602.668959]  ? hrtimer_start_range_ns+0x126/0x370
[  602.668961]  schedule+0x39/0xe0
[  602.668962]  schedule_hrtimeout_range_clock+0xb1/0x140
[  602.668964]  ? __pfx_hrtimer_wakeup+0x10/0x10 [  602.668966]  schedule_h=
rtimeout_range+0x17/0x20
[  602.668967]  usleep_range_state+0x69/0x90 [  602.668970]  psp_cmd_submit=
_buf+0x132/0x570 [amdgpu] [  602.669066]  psp_ras_invoke+0x75/0x1a0 [amdgpu=
] [  602.669156]  psp_ras_query_address+0x9c/0x120 [amdgpu] [  602.669245] =
 umc_v12_0_update_ecc_status+0x16d/0x520 [amdgpu] [  602.669337]  ? srso_al=
ias_return_thunk+0x5/0xfbef5
[  602.669339]  ? stack_depot_save+0x12/0x20 [  602.669342]  ? srso_alias_r=
eturn_thunk+0x5/0xfbef5
[  602.669343]  ? set_track_prepare+0x52/0x70 [  602.669346]  ? kmemleak_al=
loc+0x4f/0x90 [  602.669348]  ? __kmalloc_node+0x34b/0x450 [  602.669352]  =
amdgpu_umc_update_ecc_status+0x23/0x40 [amdgpu] [  602.669438]  mca_umc_mca=
_get_err_count+0x85/0xc0 [amdgpu] [  602.669554]  mca_smu_parse_mca_error_c=
ount+0x120/0x1d0 [amdgpu] [  602.669655]  amdgpu_mca_dispatch_mca_set.part.=
0+0x141/0x250 [amdgpu] [  602.669743]  ? kmemleak_free+0x36/0x60 [  602.669=
745]  ? kvfree+0x32/0x40 [  602.669747]  ? srso_alias_return_thunk+0x5/0xfb=
ef5
[  602.669749]  ? kfree+0x15d/0x2a0
[  602.669752]  amdgpu_mca_smu_log_ras_error+0x1f6/0x210 [amdgpu] [  602.66=
9839]  amdgpu_ras_query_error_status_helper+0x2ad/0x390 [amdgpu] [  602.669=
924]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669925]  ? __call_rcu_common.constprop.0+0xa6/0x2b0
[  602.669929]  amdgpu_ras_query_error_status+0xf3/0x620 [amdgpu] [  602.67=
0014]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.670017]  amdgpu_ras_log_on_err_counter+0xe1/0x170 [amdgpu] [  602.67=
0103]  amdgpu_ras_do_recovery+0xd2/0x2c0 [amdgpu] [  602.670187]  ? srso_al=
ias_return_thunk+0x5/0

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 19 ++++++++++---------  drivers/=
gpu/drm/amd/amdgpu/amdgpu_aca.h |  3 +--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 04515c1c7241..7945173321a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -222,9 +222,9 @@ static struct aca_bank_error *new_bank_error(struct aca=
_error *aerr, struct aca_
        INIT_LIST_HEAD(&bank_error->node);
        memcpy(&bank_error->info, info, sizeof(*info));

-       spin_lock(&aerr->lock);
+       mutex_lock(&aerr->lock);
        list_add_tail(&bank_error->node, &aerr->list);
-       spin_unlock(&aerr->lock);
+       mutex_unlock(&aerr->lock);

        return bank_error;
 }
@@ -235,7 +235,7 @@ static struct aca_bank_error *find_bank_error(struct ac=
a_error *aerr, struct aca
        struct aca_bank_info *tmp_info;
        bool found =3D false;

-       spin_lock(&aerr->lock);
+       mutex_lock(&aerr->lock);
        list_for_each_entry(bank_error, &aerr->list, node) {
                tmp_info =3D &bank_error->info;
                if (tmp_info->socket_id =3D=3D info->socket_id && @@ -246,7=
 +246,7 @@ static struct aca_bank_error *find_bank_error(struct aca_error *=
aerr, struct aca
        }

 out_unlock:
-       spin_unlock(&aerr->lock);
+       mutex_unlock(&aerr->lock);

        return found ? bank_error : NULL;
 }
@@ -474,7 +474,7 @@ static int aca_log_aca_error(struct aca_handle *handle,=
 enum aca_error_type type
        struct aca_error *aerr =3D &error_cache->errors[type];
        struct aca_bank_error *bank_error, *tmp;

-       spin_lock(&aerr->lock);
+       mutex_lock(&aerr->lock);

        if (list_empty(&aerr->list))
                goto out_unlock;
@@ -485,7 +485,7 @@ static int aca_log_aca_error(struct aca_handle *handle,=
 enum aca_error_type type
        }

 out_unlock:
-       spin_unlock(&aerr->lock);
+       mutex_unlock(&aerr->lock);

        return 0;
 }
@@ -542,7 +542,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *ade=
v, struct aca_handle *han

 static void aca_error_init(struct aca_error *aerr, enum aca_error_type typ=
e)  {
-       spin_lock_init(&aerr->lock);
+       mutex_init(&aerr->lock);
        INIT_LIST_HEAD(&aerr->list);
        aerr->type =3D type;
        aerr->nr_errors =3D 0;
@@ -561,10 +561,11 @@ static void aca_error_fini(struct aca_error *aerr)  {
        struct aca_bank_error *bank_error, *tmp;

-       spin_lock(&aerr->lock);
+       mutex_lock(&aerr->lock);
        list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
                aca_bank_error_remove(aerr, bank_error);
-       spin_unlock(&aerr->lock);
+
+       mutex_destroy(&aerr->lock);
 }

 static void aca_fini_error_cache(struct aca_handle *handle) diff --git a/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
aca.h
index ba724c2a997d..5ef6b745f222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -25,7 +25,6 @@
 #define __AMDGPU_ACA_H__

 #include <linux/list.h>
-#include <linux/spinlock.h>

 struct ras_err_data;
 struct ras_query_context;
@@ -134,7 +133,7 @@ struct aca_bank_error {

 struct aca_error {
        struct list_head list;
-       spinlock_t lock;
+       struct mutex lock;
        enum aca_error_type type;
        int nr_errors;
 };
--
2.34.1

