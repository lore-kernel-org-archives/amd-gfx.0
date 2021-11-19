Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE35AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 03:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4929C61B29
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 03:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4929C61B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09606ED0F;
	Fri, 19 Nov 2021 03:07:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE2F6ED15
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 03:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeFi2YZKumZJylVCjCJ0Bpf+pLNCkGIQh/sRFAsnJjUHYgqhIjJQY/Fwh062iT/jUXDTlsNu8NABFdP4sL8UNPF9RoIbP6m3/f7aZvHvKjdlXFPTsSTvT36pIfngUlBZC+mvHMKZGOXyfnAaPpedcalg5rJ3a43YHZR2MJlVFdfBWodiRe8QtU2FtAoTtxi9gmz/9vFrbJRPtwRzZzlTCfD3S5fpa7DHcxIXjZlKRm4Vu9kL2yWr/dLiILcWF5v+XVW+F/44g5VfgW0+9Ca6VGULTmIQLbKYCR1SkovYEbo8vzfjYV8xg6mGetwTw8HZp5owgWzFkc1QMwpG9PqUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRyQwiR92+Jtjq+YovMkiUDWBxmqw0opYxC4Op0DoKs=;
 b=GJJB9mK6Am2C5vTBkDwkyPehs2uX1G2sbEOMBH5mR7x6A5gOkSoQi0cfoNWU3XR6GYI74DkDcI6vH2iB75vu4OGTudgZpB3mWsmgjf3RR+OeiqPUyJGRcSQSqGZAqFmyW7v+sXlD1hZpDsbvSoLnPpOCW/7KQGERX5wsT0fW/+ui5C3PU0soKVlgvfKxYDH3djhGzfBCTn8d7xwnqAcs3T2wQaZ6qgMJ9BO3D/ykii2xAb+NnchhN1dpIpFWxvFpPsTNFof1EmPVp2iIJwK6pMNSkjuxsXuzKpXHwjsaCzrGnDe8RwGC/ArAxPjpe8ApF0h+PbNjXfdcpm3FepeEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRyQwiR92+Jtjq+YovMkiUDWBxmqw0opYxC4Op0DoKs=;
 b=G2IiPPOudHw/CYbS1IMdEe30Mg2vGmEnPhIAfhJTVpgMkvNC8qXEYZUqOGtW+fDcnvO4O1rwjRSqGex8Jfy4VNKD2tWSViOY7wFoZiAHYx12K/yOlRs2Xed0V+1QquKcB9049p5k4aiR3jL7a7gTxTD5gtNv20euAGmwYXLu1JI=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 03:07:52 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::d1fa:7115:639b:7ac8%5]) with mapi id 15.20.4690.026; Fri, 19 Nov 2021
 03:07:52 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Thread-Topic: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Thread-Index: AQHX3J1tejNjhD04q0aFu2fssW4xvqwKK/AA
Date: Fri, 19 Nov 2021 03:07:52 +0000
Message-ID: <CH0PR12MB53722603350F564FD70B512FF49C9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211118165737.27432-1-shaoyun.liu@amd.com>
In-Reply-To: <20211118165737.27432-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-19T03:07:50Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=71b25f2d-c700-4f02-8767-d2fed4c560b3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c80c0d8b-83b1-4107-e3d4-08d9ab09c6dd
x-ms-traffictypediagnostic: CH0PR12MB5267:
x-microsoft-antispam-prvs: <CH0PR12MB5267D8776DE2F2CBC5AA78DAF49C9@CH0PR12MB5267.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaLwhT4VfjHIKeJE5Wzzkm3LVo9UTYB8vPVASIl+QTgocAbrzB7FaiAyQ9CggyjAPz4ykEWebqxfpJSQMsuIIaznqZRXR3X9b79QzfcsN5GfyOzLkFmQW+RhG/D4FPtdND2P9pMvFGNvorEtFdki4g0Fn0A9TeM9fNwNzXeaDjmMcvlXa8b0C3dCHYyRMr2da9hfxGi1d+D3mLAE0O8atdu8AqLyPHtGkXIgwDp41nXZ/XlN1sBHnUBQJ/g14Ih3/xK+OLFMIph0VRttwff+B7JZ7XCP890AkGZ/6STuVVYw2mV5KpuawIJXRkByzJGWNWRz29lqvQyoTYuVfhfDSnrY641wzW4krOlGUkTITdkq4JLd7UxSgMDsaqGTyvwJqMWlJdLFSD5DtW+tmmHYe4WKVSm6B1CWz47HBosss2INUeChchPvvQZUvwrL18VtLtBvcdqAh0J5ctQ7KyVON02C9GT+0XpeFnFbFjhBeVexFMcSGYwY9H5ZpbrAwUchqoZRgqSM5Eju1f3CH4KrZ0GMOhSHvxDP2Hn3K2lzSCuiZmbfuo7pqUJ6/J0puthMWWB3ckTW+Klqu8xLTEGT0O3odvCnrGsPKB797k38ewVM8W5KUZufehwZnJi2WbgZCMSFx1vtzcV04kNXvxMOTisMseUOFlMqseoRK/27N6k3um9bcSYysKjMkad6pKXkY26GntwFmyu2NEUavK70Yw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(26005)(52536014)(5660300002)(86362001)(55016002)(38100700002)(2906002)(33656002)(71200400001)(66446008)(66476007)(9686003)(66556008)(8676002)(186003)(66946007)(7696005)(122000001)(64756008)(6506007)(53546011)(8936002)(508600001)(76116006)(316002)(6916009)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bcWAeS2tfWOEZGRYD1kKTFs4yRLqxmOp34hzci5dI8njqK0O7CvK41j4AuAV?=
 =?us-ascii?Q?sQx8ykgcdaeFupRgZEkVvhuVMBTWaKthyiyYdwALKVNgpwP+vJmgSbBaWLtb?=
 =?us-ascii?Q?OYlbWmx6wD3MhwqDRMz2LCFXXv1LSwGQq+3bQQbjSNZgn0afFJy4tJGqwW3s?=
 =?us-ascii?Q?Cui3tTmE+87/k0LFx1hzJqaAOKe0XxCxKrMoKguuLVHRrl9lOjWq+WSeI7XR?=
 =?us-ascii?Q?FgrycyOiEg63Jw5oXAjzt3MdJTCXYJv3gHbPQT9CtC4AKIQqJjuNbtBgvBeH?=
 =?us-ascii?Q?q6X4QZGY3abKEhDpe5bPKrx093nLa5kA4anmikqRnW2Hs79MstBtTStL7pyH?=
 =?us-ascii?Q?2O2zsYy+PF37XcgrG+OZx8Bt/IfdUGY/DTo2XpCdW81GJS38Ne43624cBaIV?=
 =?us-ascii?Q?GbNHwqFRDcAXa4e346NpJ0Hag+oSruYN+G/e/xMAAURyL74oS/DtwVFwN/9Y?=
 =?us-ascii?Q?5m3K5RKoXUpVOSspJDQ6fzFF4LI8lbFTjcW47KxyOpFXd2DK0XnYgwJQ1Gym?=
 =?us-ascii?Q?u+SXVd6xzQCjLFCMnYNEDY5QLfv/cOwBnErPzTte2tkEfoFBaIDMnS2gOzA1?=
 =?us-ascii?Q?VAW01zgd8pL7TL4P5xuJDkORQK2SA4QutIlxkO+St8E7WJd0W18IFApRA1VG?=
 =?us-ascii?Q?PHuYIgkveJecelhNxZwmQ46oaSCjHNgxZNxNMLuyLatE24XCZvk9rjxj+yBc?=
 =?us-ascii?Q?9gw6BdrKE91GmkTphyRDtUo9ilyDTRDz0q5PeaSHAlw2qndBdAudcLXUN/is?=
 =?us-ascii?Q?yiNpCvAYQuAysa5a8RY1n06fjfH7RpojS23LtjlTZBv2c1MMwGnqT5PE2FrO?=
 =?us-ascii?Q?V2ygVeVng0MZRCRIXLUFde8aYzcne6/6G8sUM9H80HdCktpT1o9LQmwFEznV?=
 =?us-ascii?Q?+B8uVaEoY6NpLG78U79Aywb4mlTLM6l+hOY5NwhBP3+JUjoZTB6JxLXUhEP6?=
 =?us-ascii?Q?xCb672qjZU0+4E4BGpzXctCGphyuPoCFdSynKRyOcuoWR8aWkCMfBlQ/nTkd?=
 =?us-ascii?Q?719Danz/0zAQUz/M6GjhwqQaTtg8eWrxXM52oWrBEnVPMEeci3lhLtfAwrIu?=
 =?us-ascii?Q?57m5sHr8E6h0kamOfH0iRe/eS8DirBDsfmdUtmbhTV6vu0uf3uLbygR21mOq?=
 =?us-ascii?Q?jB+70On2Thsdm8yrUzIOl6a4R/o//XetcsoaI5KHVVBG2cAqCivgv7SR9+NZ?=
 =?us-ascii?Q?I1rVkvwkaMIc0ak1kk8TFZQARxr0J56t4t1/DVZR6D2tb3b5ORuvaJX0f56z?=
 =?us-ascii?Q?MekxGDH2kJTnkVv3Vkjjj7Ctmgx5LBCU1rV+r+yDqLsHEhRdgcTusIwFh8nm?=
 =?us-ascii?Q?1nDTD3JOMM0WPXpPCpArUSbVln/Pv4l55JIO0xM0zKXSQwF/0vXSOQoh8Wgm?=
 =?us-ascii?Q?Rwn/ai9RGnr8qlIyrfDi4u9IWXeVngrPfg9Df8nvS1Of+EwwZwRAmO4DGviB?=
 =?us-ascii?Q?t7gi4oK0I7kxwYGocMVAfS//n1gDeaygQ8J1KeHY07+7DQBlWUSU7uMIWVb4?=
 =?us-ascii?Q?OqqCLaCt4mEAFfFYOlkP7wqehW3YmLzHsajoKpTmpYBC6NsjOONCioZ8EnQL?=
 =?us-ascii?Q?s4TggY9BJddulMUMrpkw22BuFsF9wfYbDdWYa/ktAdNRIzwtvU4PUERMh3tE?=
 =?us-ascii?Q?3glEa6+3w9YcWfFPdlDHx0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80c0d8b-83b1-4107-e3d4-08d9ab09c6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 03:07:52.7787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVBd7kLXltC/Z6IEbtak/EZnYNJIaUbEZCq88nqw7fUHx1ClGg0e+tIV4+W4jj9wBVADpzHy/LCXN4htogXrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
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

[AMD Official Use Only]

Ping=20

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
Sent: Thursday, November 18, 2021 11:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov fun=
ction

For sriov XGMI  configuration, the host driver will handle the hive reset, =
so in guest side, the reset_sriov only be called once on one device. This w=
ill make kfd post_reset unblanced with kfd pre_reset since kfd pre_reset al=
ready been moved out of reset_sriov function. Move kfd post_reset out of re=
set_sriov function to make them balance .

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 10c8008d1da0..9a9d5493c676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4308,7 +4308,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
=20
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 	r =3D amdgpu_ib_ring_tests(adev);
-	amdgpu_amdkfd_post_reset(adev);
=20
 error:
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) { @@ =
-5081,7 +5080,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev=
,
=20
 	tmp_vram_lost_counter =3D atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
-	/* TODO Implement XGMI hive reset logic for SRIOV */
+	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
 		r =3D amdgpu_device_reset_sriov(adev, job ? false : true);
 		if (r)
@@ -5141,8 +5140,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
=20
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+		/* unlock kfd */
+		if (!need_emergency_restart)
 	                amdgpu_amdkfd_post_reset(tmp_adev);
=20
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
--
2.17.1
