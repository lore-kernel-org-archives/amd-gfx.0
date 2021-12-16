Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED793C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 02:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5439B10E7FA;
	Thu, 16 Dec 2021 02:13:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585CC10E7FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 02:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KboBtGF8oNDGCo7GUjwF0fqlfouGmCK+HJjcROxjQnWIflLFpf+L52yOK7C/g8TUWmQkWwSoU4dLoB1VsGO3RQcA8fhqFNob5fwbTXc8dmZsHh/Uv6YGFZ82fzmmyLwP97NEr56/SDIGSSjtldyZIK1zFKM1Yl8OU73Bj1bR4rKcVNXEcxqQE25AzcH4mtnIp/ZJGqs8Ht7K7BAVAIEYDY0CyTzR8Xom3qPHwOQrOjFeZiBLnYk6eGX7CMsXHF4ukVp8NpN5AWgyVXEwBr9VRf6BjwIVIENVDkb4Rav474ejH9Kx2UP74N9qxihkUWRdPOk19bPxvXfqQL0AtcQzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb1Tzcv80Ixo8moPnKkQ0hQm1FpFtXxwVrLnBilFovM=;
 b=OQ7tjCeaW2MwWjJdcsn3kqUtCRdJqmbgQsNB6pLQ8QXVtWayfU7iheeuHJYqwgalAtkak+i4HbWkbnDTrnW7haAdrqvVzAJvyUxVGjl6tLo529U4zQ6PftNAwcaSeQfRNxeim3tB1L4KXYciRxplnaSkTPP2lPjG6dHtmb3ky91n06E2mXBlXhIfTor2mEps26tk3urby8v4nII5/8QXCntWIU27HGe+twQmh4dMUjsiRuANOgLcjnc4kXiAuc0QynRctzBr+GkJujZF/TSo/cWjlEtvivAdm9mu9kU4i0HdagfdiOpaYIAKkbnJCcXlhQ/QF4+BZhrT98GifOD6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb1Tzcv80Ixo8moPnKkQ0hQm1FpFtXxwVrLnBilFovM=;
 b=3uvwPobSMzlU9iS2+KPKqvbbxY8GNpnXoCU6WAL80g8gFVBP/A7yAei8a1OaGFWJbIIg5s50M3+LaxDh6itHON2qFrdqy7y3JycWb1vGK7B/EGemTd3s38vegZUSvpvFZTXnBB35OUSfSpUFoU4OIhKVTM4sjhG1FipetKEl0wc=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH2PR12MB5561.namprd12.prod.outlook.com (2603:10b6:610:69::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 02:13:53 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Thu, 16 Dec 2021
 02:13:53 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Separate vf2pf work item init from virt
 data exchange
Thread-Topic: [PATCH 1/2] drm/amdgpu: Separate vf2pf work item init from virt
 data exchange
Thread-Index: AQHX7R68w96tAWLN7kmUUwZPaXrNQqw0ap4g
Date: Thu, 16 Dec 2021 02:13:52 +0000
Message-ID: <CH0PR12MB53722882C8DFCB757FDD9FA7F4779@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211209164809.504378-1-victor.skvortsov@amd.com>
In-Reply-To: <20211209164809.504378-1-victor.skvortsov@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T02:13:50Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ee562a53-ce8b-46d3-a195-e154c6ffb177;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-16T02:13:50Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b6f3fafc-9437-4408-bc63-014bad6fb815
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7c3572c-631d-47fe-792b-08d9c039b4e9
x-ms-traffictypediagnostic: CH2PR12MB5561:EE_
x-microsoft-antispam-prvs: <CH2PR12MB5561F071BA599DA8FFA646F8F4779@CH2PR12MB5561.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9IDFZNp+DlicraF4C+i5VaephaOEKNqJNOeXnPalhaJa5NxWOfYrncCplm51B4iNEkgIWuiTKhkiqPGYg9jBs6L0dRdWLWJZeb5RG6JClzIk7v59b3/4E4gEVQzTt8c/n5TB9kDnnmerH3kzQjglrs7k9u2GN0M1gBH2HhJMVHIgbXp7ynf7C64grUWI05HXpEyBD7Y4UHA3Uarv0pUuzKL0k/dhknRL5GlcySHfurtju8B8c4kXGXOOBnEoDPkhz+HZ/ZrwnpUPCFSi1AosHHaT9HLN53zlwehmqGToWsb/VLkmlYdnwXq1yWrBo72Il2fLKnoOuJBmAsPyuzUL3M+cqNxjXqjmt8dlQ3AjwAZwhdheGSEXyoC5f9Dm2vWvY/NYqY2qbLQTl1pcJ5sktkm6GV7r/yPglZMJUgXY4Lpz/0MO156aYNtPfOPpCJ2SWEUY7BL0oxkdSdpJNpIk2TVSDM7UgkEVlAX/nYFFvIYM50kCgb1QP/OAhA4ECjjrbX2+TXPePE64iFT87gbKNWnt2TdC49lUh2T6HqW7W3xo0u3lGg6PoRlvIdECI+gHAoOB+OFnwHuPVjR+iVFnI9antX5sAxXBdHpNdxrnwBeWg2HDKGMHyzqmdNduniv5bxCj8PnTH27GLH3q9PBTzwnYH5uGgLAf6nYaRGsD00WXFk8xgAvsITCATEo32x1WrZTO2Tgk7WOnLDG5vk6sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(8936002)(33656002)(86362001)(8676002)(52536014)(5660300002)(110136005)(38070700005)(316002)(66446008)(55016003)(2906002)(9686003)(71200400001)(186003)(508600001)(83380400001)(26005)(38100700002)(53546011)(6506007)(76116006)(66556008)(122000001)(66946007)(66476007)(7696005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBEVlPupoPIJPyzNVS80MnEfvig4XfhfGmgFQhzvKMHQBzjcmX+nuP7RzKpV?=
 =?us-ascii?Q?gN7NEaJs2D3og2xkhZOiLtl9nwML6pWQOoggQDYGVcwVrpjfAcGfpjVY1pIm?=
 =?us-ascii?Q?R89NyrdN26rENuL8wNnICAIPgMzN2uwV7yoUwt7dJWlHb9v9mTNhWvhIx/qh?=
 =?us-ascii?Q?IcATixtMsOgdB/ZuFeKJMZrapi8MQZWHVAxwnW1u1cGfWG+CZCS6ouOr77Qt?=
 =?us-ascii?Q?UC+HDvEt9uambTUB9HYt2fy//CCk598YBm9OQmXdPRHMkRS4xYt877ziu6XA?=
 =?us-ascii?Q?0t7Yx4+0CDcRCHjzxoVhc25KwFKgTFT+1jrw0AKovdl+repVX++K2WbEix1l?=
 =?us-ascii?Q?toWqn02vhYgm3ZGBmIUzKM39rxPtFKrppseMSagyyZy+/pjRf8tAbpT//9tt?=
 =?us-ascii?Q?dHMyj5BDhIgB9g/ngva1Hg7kApHo+KrR61+YarSfbJ5Ot/ULxUGhQSwoH+cK?=
 =?us-ascii?Q?3E9EWGxIXBCgDwHDsBFfWwVMXXdzqC7BdkUaxl99sktw5mSngKl79Xg6NiFi?=
 =?us-ascii?Q?F+EFjX5vDnY6umFgpr+fff6+U3z14yP+VJNoeCbA1MluaAYsW1RxfX3g+8Y9?=
 =?us-ascii?Q?pgFvSLSQ+kBfn866MLPywjASwToFH81Exw3xAqtdWJ81bK1cEIlBzmzI85Yz?=
 =?us-ascii?Q?sgRNt+/SJtOE+uXPMNwZYLknhIUn8XQBRKoa9SJYqHBn+Bd0cT9F8Yf73xS7?=
 =?us-ascii?Q?hYbpvxD9q5ganXqkmTj4HFzKrbo42H+mfJD6yaztLz8q71v0g+BHG6nLLYN3?=
 =?us-ascii?Q?yoaYarkR9y74jYTHPs0kW8AIWlGuHrRETQrPhM9vaHA3s+FVq7eej4Rw98yn?=
 =?us-ascii?Q?q6iEPcq2eCs+oT6hpV3KavGbCmErSIgZDh0BTatf0B048xI8DC0VdBoBGsc7?=
 =?us-ascii?Q?7g3WGdLh4w2UKxQMv8YvCeWTxOcHdmpi5nhHuclSuiZtetx8Ba8HwfhPm4N3?=
 =?us-ascii?Q?oA9KJuoP8T5YeNmBKSE/qvKGGpw08WaWRDiAmBOTORQqalYHxWy0rR1UUZI7?=
 =?us-ascii?Q?/G+jOcsjRTN0npW4WAFA8Wpc/xHA3jq4rwBf6hEDWmyZrqCSIYGeKcPb0/jJ?=
 =?us-ascii?Q?5b15eZY1zi2kM4TcTc2Ff1O9iy7twb8V8PDUeH5ZwKNFF+EypIj+qMV+xrb5?=
 =?us-ascii?Q?MRvRCPImFaG0XhVnuHKsYgaczaf9udrCmCOQbTIA5FergkkqX0BWnLmU/HqZ?=
 =?us-ascii?Q?zIXyilBziWItLGujK9JH9KMTzw9DEzZ89Vq8cvGxqMe96hf2lF9eJaXimGci?=
 =?us-ascii?Q?CIhBAULLq+1yTljIxNsvLRy+mcmjF0fs6iL5JRY+cwOsVtEUmQi4CjGu48hn?=
 =?us-ascii?Q?CVEc4sPs1tBcBk63m63a+rdt36eEmOHV8K32nSm4eHxx4RSxPAC95927PgMq?=
 =?us-ascii?Q?PUG7BZXBJIp1pDYXIa1ZDOnlDv7Ty8H2Wg0uTouSghCoGaxFjdrLKkMgYFEI?=
 =?us-ascii?Q?Hl7yGRWE/HFfe5ps0XDUxKOVevJQsTyE9vU+6MvUq243eizIqmVKp//owGOH?=
 =?us-ascii?Q?+KKyBFUdTi4UVGbGzYubCn3fAQfyYsoXfUgmuKXtUh3OuzQ4QXCg1jIeW2t4?=
 =?us-ascii?Q?GaNOoXk/riKAUJ+BH+moFkw25NrzvvdCMgBDCQPOOHJM1uPbbDv24vCnydB6?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c3572c-631d-47fe-792b-08d9c039b4e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 02:13:52.9558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icTnaj0Zo2MW2Zv4sh2TfaVqykfPHMRpaukA3DFLW3cinbd7Awymr4XwCO1N+Tb2m6JGuBFNEKcCnxU4R+Zptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5561
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
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Looks ok to me . This serial is Reviewed by: Shaoyun.liu <Shaoyun.liu@amd.c=
om>

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Thursday, December 9, 2021 11:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Separate vf2pf work item init from virt da=
ta exchange

We want to be able to call virt data exchange conditionally after gmc sw in=
it to reserve bad pages as early as possible.
Since this is a conditional call, we will need to call it again uncondition=
ally later in the init sequence.

Refactor the data exchange function so it can be called multiple times with=
out re-initializing the work item.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 42 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ce9bdef185c0..3992c4086d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2181,7 +2181,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)
=20
 			/*get pf2vf msg info at it's earliest time*/
 			if (amdgpu_sriov_vf(adev))
-				amdgpu_virt_init_data_exchange(adev);
+				amdgpu_virt_exchange_data(adev);
=20
 		}
 	}
@@ -2345,8 +2345,10 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
 		}
 	}
=20
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_exchange_data(adev);
+		amdgpu_virt_init_vf2pf_work_item(adev);
+	}
=20
 	r =3D amdgpu_ib_pool_init(adev);
 	if (r) {
@@ -2949,7 +2951,7 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *ad=
ev)
 	int r;
=20
 	if (amdgpu_sriov_vf(adev)) {
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_fini_vf2pf_work_item(adev);
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
=20
@@ -3839,7 +3841,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
 	 * */
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_request_full_gpu(adev, false);
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_fini_vf2pf_work_item(adev);
 	}
=20
 	/* disable all interrupts */
@@ -4317,7 +4319,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
 	if (r)
 		goto error;
=20
-	amdgpu_virt_init_data_exchange(adev);
+	amdgpu_virt_exchange_data(adev);
+	amdgpu_virt_init_vf2pf_work_item(adev);
+
 	/* we need recover gart prior to run SMC/CP/SDMA resume */
 	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
=20
@@ -4495,7 +4499,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,
=20
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_fini_vf2pf_work_item(adev);
 	}
=20
 	/* block all schedulers and reset given job's ring */ @@ -4898,7 +4902,7 =
@@ static void amdgpu_device_recheck_guilty_jobs(
 retry:
 			/* do hw reset */
 			if (amdgpu_sriov_vf(adev)) {
-				amdgpu_virt_fini_data_exchange(adev);
+				amdgpu_virt_fini_vf2pf_work_item(adev);
 				r =3D amdgpu_device_reset_sriov(adev, false);
 				if (r)
 					adev->asic_reset_res =3D r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 3fc49823f527..b6e3d379a86a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -611,16 +611,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct =
work_struct *work)
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_i=
nterval_ms);
 }
=20
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev) -{
-	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
-		DRM_INFO("clean up the vf2pf work item\n");
-		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
-		adev->virt.vf2pf_update_interval_ms =3D 0;
-	}
-}
-
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 {
 	uint64_t bp_block_offset =3D 0;
 	uint32_t bp_block_size =3D 0;
@@ -628,11 +619,8 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_devi=
ce *adev)
=20
 	adev->virt.fw_reserve.p_pf2vf =3D NULL;
 	adev->virt.fw_reserve.p_vf2pf =3D NULL;
-	adev->virt.vf2pf_update_interval_ms =3D 0;
=20
 	if (adev->mman.fw_vram_usage_va !=3D NULL) {
-		adev->virt.vf2pf_update_interval_ms =3D 2000;
-
 		adev->virt.fw_reserve.p_pf2vf =3D
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10)); =
@@ -666,13 +654,39 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_dev=
ice *adev)
=20
 		return;
 	}
+}
+
+void amdgpu_virt_init_vf2pf_work_item(struct amdgpu_device *adev) {
+	if (adev->mman.fw_vram_usage_va !=3D NULL) {
+
+		/* Inverval value is passed from the host.
+		 * Correct too large or too little interval value
+		 */
+		if (adev->virt.vf2pf_update_interval_ms < 200 || adev->virt.vf2pf_update=
_interval_ms > 10000)
+			adev->virt.vf2pf_update_interval_ms =3D 2000;
+
+		adev->virt.fw_reserve.p_pf2vf =3D
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+		adev->virt.fw_reserve.p_vf2pf =3D
+			(struct amd_sriov_msg_vf2pf_info_header *)
+			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB <<=20
+10));
=20
-	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
 		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_=
item);
 		schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_=
interval_ms);
 	}
 }
=20
+void amdgpu_virt_fini_vf2pf_work_item(struct amdgpu_device *adev) {
+	if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
+		DRM_INFO("clean up the vf2pf work item\n");
+		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+		adev->virt.vf2pf_update_interval_ms =3D 0;
+	}
+}
+
 void amdgpu_detect_virtualization(struct amdgpu_device *adev)  {
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 8d4c20bb71c5..c18a7daab693 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -307,8 +307,9 @@ int amdgpu_virt_wait_reset(struct amdgpu_device *adev);=
  int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);  void amdgpu_=
virt_free_mm_table(struct amdgpu_device *adev);  void amdgpu_virt_release_r=
as_err_handler_data(struct amdgpu_device *adev); -void amdgpu_virt_init_dat=
a_exchange(struct amdgpu_device *adev); -void amdgpu_virt_fini_data_exchang=
e(struct amdgpu_device *adev);
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev); void=20
+amdgpu_virt_init_vf2pf_work_item(struct amdgpu_device *adev); void=20
+amdgpu_virt_fini_vf2pf_work_item(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
=20
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgp=
u_ai.c
index 23b066bcffb2..cd2719bc0139 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -255,7 +255,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct=
 *work)
 	if (!down_write_trylock(&adev->reset_sem))
 		return;
=20
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_fini_vf2pf_work_item(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
=20
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0); diff --git =
a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_=
nv.c
index a35e6d87e537..2bc93808469a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -284,7 +284,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct=
 *work)
 	if (!down_write_trylock(&adev->reset_sem))
 		return;
=20
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_fini_vf2pf_work_item(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
=20
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
--
2.25.1
