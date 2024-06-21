Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40936C27C78
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 22:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBB310E15F;
	Fri, 21 Jun 2024 22:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Je3B86fY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B3410E18D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 22:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0O3kRlejfVTammmK68Pqp1/KcNZt0v+NXPwOIqwAFQgIgcrmJAQlE79VXo1d3GgJG8MC2pX1lcTSUJf7phD34svlh4gFZGzUaAZLnqikTiPjaR2dqSyg9UV+Fe1AvsNyEX5Mr2GQ3NRyIA8pJmqA/sbdnpgeWG9OzBQruPy0PzvsHzBc2WS5ICoiZzIrykfL4YuDhvgPVR51ysdm7K9sC9lf8kLCwU7W8PvE7J3jZO53KzxfWU1XLxRJ5IPDx2ZQitWQzCWkFvWUgbyRrN1BRjY238j3rRlX6Z7UrSQn0F3X+ktBqH+dBJVWRiuRESzgewBN8b0S17Rd9eGCuqSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU+mG2VFulLqiI/X8ApHnf4rmsNKuo9PXWNS4zgZXL8=;
 b=nppDactDZMwDYXqMmbY5epOBlV159LDXxv2PbA7upg/S9nSLLqLCgAPosfALV2EZhk9yne2Hou23VLAZzglA9Zx2ZATmDyPJwZqbmPPRVoK250m429eDe7LmQ6lmLPxj0qfhO/FOjxhSomDdZXtyvY23tbsfj7Ks7Xq1b4g/lApRu5fuUjGgSiGRUjWq1t4R1afpJfvoDC8hL9L510gJt3LojKFVwByckc+bcbHfvx+8O4fAWNAE+jTmZYhpBXilht4dpP2/uqjbsZT1JhgZQoQxozChQd8QxRdSVwb9bKjwaDqWOlyAvmo7vFF12UTS4XhPWnpijIBiv6qus613+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU+mG2VFulLqiI/X8ApHnf4rmsNKuo9PXWNS4zgZXL8=;
 b=Je3B86fYTwU9qSJ0UL/WjF4aJm2cMNFbO3zbgqZ8QmBk9/LKLXTl4Viiw5U+kszVWcp1VREnU0wDsUfBg6+m0A4lMXQCov+nexT4+bK0B/NuLs4VvP5NAuuoo+8/yXQ3RZx21hoi3mfsto/CeChIWdipQOGYGsKCXGwx/0mL3ak=
Received: from PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Fri, 21 Jun
 2024 22:12:19 +0000
Received: from PH7PR12MB8053.namprd12.prod.outlook.com
 ([fe80::8de1:8d93:7d2e:d4c6]) by PH7PR12MB8053.namprd12.prod.outlook.com
 ([fe80::8de1:8d93:7d2e:d4c6%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 22:12:19 +0000
From: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: process RAS fatal error MB notification
Thread-Topic: [PATCH] drm/amdgpu: process RAS fatal error MB notification
Thread-Index: AQHawtrW5TrcE9PQPkKETeVhYIwXWLHSxsUg
Date: Fri, 21 Jun 2024 22:12:18 +0000
Message-ID: <PH7PR12MB80532DB2688C33E1A9B43DEF96C92@PH7PR12MB8053.namprd12.prod.outlook.com>
References: <20240620062626.619810-1-Vignesh.Chander@amd.com>
In-Reply-To: <20240620062626.619810-1-Vignesh.Chander@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9b421a9d-02be-485c-8e23-55a570353673;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T21:59:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8053:EE_|IA0PR12MB7628:EE_
x-ms-office365-filtering-correlation-id: d3e5ba02-6c22-4b27-c6b0-08dc923f3766
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?gjGVam4qkOegyD0SsQ+J7+N3lIQo+jutTKpEy2PPXvhCok144nKweTbEpsJr?=
 =?us-ascii?Q?5aT6NOKvGCz2RB/Bhe2DPy2Tp6nIviS/LR43mRckFUt24D+6bArQsRPvHF2R?=
 =?us-ascii?Q?SVUKTOxtb0htDfuZZq8Km13v8MMJGZ3n5uo6hIVOZlNF4MoPNebMQqCH3Gr8?=
 =?us-ascii?Q?w5nQDhF4XMFdG5dnjb6i/Ah/cy0cQlpt2RZEbPFbD36zo8ffuBM8ms8FbI63?=
 =?us-ascii?Q?ASAw2aaGPSqjok8PfV86aBkrc7MoytuOSf38mQAg0qzTNzgWdL/+FFpjewnv?=
 =?us-ascii?Q?0YQtly0f54QUyYZhBary+l4HMbnnBULriegXqcaEJ0KjJUfDfjzTx+1m0oLv?=
 =?us-ascii?Q?RjuR/I3/n5MjdtA02geMz/jsLNZ2ApLCrBFpHbGN/JTGNl02cDTKuu8lS5Lj?=
 =?us-ascii?Q?3RXhs+TXzZw594I6Ny51kx6eqpNFjVBug9IdYSfsH9dxGJo+Myn0JDn7F36+?=
 =?us-ascii?Q?bSYp004RvAYnX0B7xCB1zb4ifE8z49TkZexJ/6TZyhrPgWgUKpz5QYrctUxS?=
 =?us-ascii?Q?bBu39FFYoQ7BPe6FD3t47FRUlJSR2IFAnMsMD7wbbpDZwxRnJ8jEfKW3lf1+?=
 =?us-ascii?Q?mcMY3a6jtcam/qVmIMweRuD9PRiXhuk2+H/Ytc5h87iqfrR/a4gvd861gBeJ?=
 =?us-ascii?Q?1W+krmIDce1JclNFDHB2XKM9bpEAFHol56iQ0jlB4JsJgmSI4+C99alu98Jm?=
 =?us-ascii?Q?LhAL6kQPOC1gB21BFNk5m7nuytlLmb79Fof/ULqmXfdbhSVa8wYU2X2shkha?=
 =?us-ascii?Q?Hr/5uLFBxvqVyUKuMwRBrc0FNy1Tfz+8nvFNkYjYRV2gcIVM3HTmqvAOoT0E?=
 =?us-ascii?Q?xkMyrGF5Iak+Wu30axyiw6mhXtunse6SOTSrqrHvrbDm95lysU5w41CnMDHo?=
 =?us-ascii?Q?PKBce2PzFMBL0llrYmSTsFvgNrfhtXQdaSbPHO7vQhJVmzdiwpmP7BFaR4/s?=
 =?us-ascii?Q?00/8gfkcodwFDjYq5w0GyfsEB5n4MCtPrOmjR4LVLLSDjm8iar6w05MDQ61d?=
 =?us-ascii?Q?bm4604ag8qLC4fcqm5hue5hFYcBtYhipk1dgTbHn1nrJ01d/AViCpDKWNpCV?=
 =?us-ascii?Q?JwNwytyHUp+19Cfx1du+wo+cJZ02cxLQc4FZUbCLORbnY80MlltZPbRLtAEw?=
 =?us-ascii?Q?hLyu5aYSAGxNmYLG2JuUtSIAG4zAiVx91vB3ktfuQa9kBOfyoZwHZDb2eXdY?=
 =?us-ascii?Q?kikuYosqPK3X5pfIU+urSvAzxT9Dy9rqZNvaarhUtKZ2JGswx+zP2ooXNsEI?=
 =?us-ascii?Q?psguSxkS833uZ4r7IU/g2dqwTtk6gXmmoTCG4GKkrH9+xm+8cUipL9fBDR8f?=
 =?us-ascii?Q?GvDasYF8eVrnruaAIqGadQnGIMgc4mHZ2ZPuAE3l88wNvGO/rg8sbPw5ssNQ?=
 =?us-ascii?Q?76LEQmU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8053.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Co5af4hLvcaPINeELV7TXaONCj677mRUzAEGE7jEWtQ2dWEXkH//ztgTwY0I?=
 =?us-ascii?Q?Ho0OaBzom2bj3NKEpHipVGCdBzl5QrkPGHjJX35Kf0p/QW6vYeyrJqAdRE7Q?=
 =?us-ascii?Q?8cUbSwYBDPRi+1kZlyEj14Xp/LWBFJ4LuWomJM5/ra49DFA21s5c+ZV8R4pH?=
 =?us-ascii?Q?T65AWBfBpR15URp38xPdNf2Dw7jcjYY9B6Kav7cktxFdGR84+xJpHAZBwhLP?=
 =?us-ascii?Q?gg9PcPphRS+tqTtw1W/1VOcY0gRHzqh6+3DRJtk5fXarpIAGdP5WRT0k4H9J?=
 =?us-ascii?Q?GnpCFEy884B6yaO8yfoNFPFmY121BvH1KIXYZuu9y27HtEIfREYXslFUuW7C?=
 =?us-ascii?Q?DHRo6irTdQGS0UpTNVrGw2QpwLDnjzgzg0jvwPb1ZUBZiwWaDBvkE5QcQ050?=
 =?us-ascii?Q?a4A0LPYM55IeFuU4gZ8LOnOM58rUx3sWsbl/o9HDZ2X9nREwIw1qsBhQSOqh?=
 =?us-ascii?Q?kYYn6oSOUcPQrUzZPRjcr/+NWV/1N2mN+84nNmcPPQVsTqV148svH4765KKX?=
 =?us-ascii?Q?COYRlYy6jX0Ur5w3SKkcLgr9lz7pzE96TME3G1MNGVkh/EizeGPw5Oqmyz7i?=
 =?us-ascii?Q?UWXtF9yVXYOrx6PWrCHjEWyOlS5VHEIZi40+l28kS2c+RJxTFpFqiIbX7Q5L?=
 =?us-ascii?Q?Fhr+7QelpnY8P++bZ5WvkzffmNWrIfTJJjvp++is9EOw+KmKGF1It2roW8+Q?=
 =?us-ascii?Q?F18L4BH+SnKkJGlm7cmqcgrb0oUba9bWkQjPooSsQa6sw7Ui2o3rM1E4bd+t?=
 =?us-ascii?Q?pewfpOmQZTzyvMCxcEeb6FseTfe1dsZv3KwpAcxyeFZ91A5b88qodx9Lg1cD?=
 =?us-ascii?Q?kepTZifF4CMLdQ0dhv2c3a5PRrW47Pv2t7pY0GZWXLannfgAV9qFgPAPqu05?=
 =?us-ascii?Q?UsQK+as+HgbEY/KCVR/bmxMNI3y8O9bzws3qH268pXTU+uVpYLdRmfco+lu7?=
 =?us-ascii?Q?M7m6s3KIuQQ04oDsHllDzrs730DVXyXSZcGWwlnEO9Ol+HPynH4esQW+nwer?=
 =?us-ascii?Q?lM+2ov+ElIGGKz19rmQ6EKmwuE6LpYKDHv29VywWntQ71YZbH+orU3FHr9gR?=
 =?us-ascii?Q?rBM4dJQNB+/ocp9EF6D+EltZ1ZkznTCzOmvrOHbBlOjRxk3y4o2Mu+MkY51H?=
 =?us-ascii?Q?2mZPAcIPhW8uJh75zERz0//kTXOVrBQ1P8muFfeCbmg4pajaKrKvD2sUHyzQ?=
 =?us-ascii?Q?Os3DXSuQ+cQ+AjKTkbOXjugrbJz43PN+yDGHKnD9v8Y4a7VR4X0+KzmA2GVS?=
 =?us-ascii?Q?tVUx91CZ5JokOLw9aFqwxEH9Ju6cIKVrqONNFBQWaXJeoelFU/SvsjK7Gi39?=
 =?us-ascii?Q?ymLNQnrEFTtaLUROZ4nowhvjgzZwej2aZyE1eoNOylFZMJSIe8TkcQZGavWF?=
 =?us-ascii?Q?Z+NGGJHvSBLkr1yd0knknSXhbDWtgBIYefgNlfrhcC2Walm/fTfkNEDqfIkK?=
 =?us-ascii?Q?4EuZhuNN6oQqE1cWESvmwiGxURpb++s4IjBARn83dMq91wv0A+iN6j6g3Xjc?=
 =?us-ascii?Q?lwzWpQADAabjl8ti/hURa6LIiLB1RE1keMwL6Oq8eaGIiiJ8RWr44zA5uNxP?=
 =?us-ascii?Q?TLu84z2MwQLVoNOiq0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e5ba02-6c22-4b27-c6b0-08dc923f3766
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 22:12:18.9815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMlwSfW5fZD1+dxFYH0V8K9uA3ypFaM2r0A3tPiPXRzgNipRtUIHPX9NEp3GNLQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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

Should we also set fed flag for the case where kfd detects timeout first?

I.e. adding

amdgpu_ras_set_fed(adev, true);

to amdgpu_device_gpu_recover or amdgpu_virt_rcvd_ras_interrupt if the RAS s=
ignature is found?

Thanks,
Hing Pong

-----Original Message-----
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: Thursday, June 20, 2024 2:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chander, Vignesh <Vignesh.Chander@am=
d.com>
Subject: [PATCH] drm/amdgpu: process RAS fatal error MB notification

For RAS error scenario, VF guest driver will check mailbox and set fed flag=
 to avoid unnecessary HW accesses.
additionally, poll for reset completion message first to avoid accidentally=
 spamming multiple reset requests to host.

v2: add another mailbox check for handling case where kfd detects timeout f=
irst

v3: set host_flr bit and use wait_for_reset

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 25 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 14 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h      |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 14 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h      |  5 +++--
 7 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7df5544ac9839e..1b204af9831d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5834,6 +5834,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
        /* Actual ASIC resets if needed.*/
        /* Host driver will handle XGMI hive reset for SRIOV */
        if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_ras_get_fed_status(adev) || amdgpu_virt_rcvd_ras=
_interrupt(adev)) {
+                       dev_dbg(adev->dev, "Detected RAS error, wait for FL=
R completion\n");
+                       set_bit(AMDGPU_HOST_FLR, &reset_context->flags);
+               }
+
                r =3D amdgpu_device_reset_sriov(adev, reset_context);
                if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0) {
                        amdgpu_virt_release_full_gpu(adev, true); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_virt.c
index 63f2286858c484..ccb3d041c2b249 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -229,6 +229,22 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *a=
dev)
        adev->virt.mm_table.gpu_addr =3D 0;
 }

+/**
+ * amdgpu_virt_rcvd_ras_interrupt() - receive ras interrupt
+ * @adev:      amdgpu device.
+ * Check whether host sent RAS error message
+ * Return: true if found, otherwise false  */ bool
+amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev) {
+       struct amdgpu_virt *virt =3D &adev->virt;
+
+       if (!virt->ops || !virt->ops->rcvd_ras_intr)
+               return false;
+
+       return virt->ops->rcvd_ras_intr(adev); }
+

 unsigned int amd_sriov_msg_checksum(void *obj,
                                unsigned long obj_size,
@@ -612,11 +628,14 @@ static void amdgpu_virt_update_vf2pf_work_item(struct=
 work_struct *work)
        ret =3D amdgpu_virt_read_pf2vf_data(adev);
        if (ret) {
                adev->virt.vf2pf_update_retry_cnt++;
-               if ((adev->virt.vf2pf_update_retry_cnt >=3D AMDGPU_VF2PF_UP=
DATE_MAX_RETRY_LIMIT) &&
-                   amdgpu_sriov_runtime(adev)) {
+
+               if ((amdgpu_virt_rcvd_ras_interrupt(adev) ||
+                       adev->virt.vf2pf_update_retry_cnt >=3D AMDGPU_VF2PF=
_UPDATE_MAX_RETRY_LIMIT) &&
+                       amdgpu_sriov_runtime(adev)) {
+
                        amdgpu_ras_set_fed(adev, true);
                        if (amdgpu_reset_domain_schedule(adev->reset_domain=
,
-                                                         &adev->kfd.reset_=
work))
+                                                       &adev->kfd.reset_wo=
rk))
                                return;
                        else
                                dev_err(adev->dev, "Failed to queue work! a=
t %s", __func__); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f04cd1586c7220..b42a8854dca0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,7 +52,7 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503

-#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2

 enum amdgpu_sriov_vf_mode {
        SRIOV_VF_MODE_BARE_METAL =3D 0,
@@ -94,6 +94,7 @@ struct amdgpu_virt_ops {
                          u32 data1, u32 data2, u32 data3);
        void (*ras_poison_handler)(struct amdgpu_device *adev,
                                        enum amdgpu_ras_block block);
+       bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
 };

 /*
@@ -352,6 +353,7 @@ void amdgpu_virt_ready_to_reset(struct amdgpu_device *a=
dev);  int amdgpu_virt_wait_reset(struct amdgpu_device *adev);  int amdgpu_=
virt_alloc_mm_table(struct amdgpu_device *adev);  void amdgpu_virt_free_mm_=
table(struct amdgpu_device *adev);
+bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);=
  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);  void am=
dgpu_virt_exchange_data(struct amdgpu_device *adev); diff --git a/drivers/g=
pu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 65656afc6ed1c2..2eba51b58ea88d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -257,9 +257,13 @@ static void xgpu_ai_ready_to_reset(struct amdgpu_devic=
e *adev)  static int xgpu_ai_wait_reset(struct amdgpu_device *adev)  {
        int timeout =3D AI_MAILBOX_POLL_FLR_TIMEDOUT;
+
+       if (adev->gmc.xgmi.num_physical_nodes > 1)
+               timeout *=3D adev->gmc.xgmi.num_physical_nodes;
+
        do {
                if (xgpu_ai_mailbox_peek_msg(adev) =3D=3D IDH_FLR_NOTIFICAT=
ION_CMPL) {
-                       dev_dbg(adev->dev, "Got AI IDH_FLR_NOTIFICATION_CMP=
L after %d ms\n", AI_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
+                       dev_dbg(adev->dev, "Got AI IDH_FLR_NOTIFICATION_CMP=
L with %d ms
+remaining\n", timeout);
                        return 0;
                }
                msleep(10);
@@ -408,6 +412,13 @@ static void xgpu_ai_ras_poison_handler(struct amdgpu_d=
evice *adev,
        xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);  }

+static bool xgpu_ai_rcvd_ras_intr(struct amdgpu_device *adev) {
+       enum idh_event msg =3D xgpu_ai_mailbox_peek_msg(adev);
+
+       return (msg =3D=3D IDH_RAS_ERROR_DETECTED || msg =3D=3D 0xFFFFFFFF)=
; }
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
        .req_full_gpu   =3D xgpu_ai_request_full_gpu_access,
        .rel_full_gpu   =3D xgpu_ai_release_full_gpu_access,
@@ -417,4 +428,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
        .trans_msg =3D xgpu_ai_mailbox_trans_msg,
        .req_init_data  =3D xgpu_ai_request_init_data,
        .ras_poison_handler =3D xgpu_ai_ras_poison_handler,
+       .rcvd_ras_intr =3D xgpu_ai_rcvd_ras_intr,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index c520b2fabfb9a8..ed57cbc150afba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -51,7 +51,9 @@ enum idh_event {
        IDH_FAIL,
        IDH_QUERY_ALIVE,
        IDH_REQ_GPU_INIT_DATA_READY,
-
+       IDH_RAS_POISON_READY,
+       IDH_PF_SOFT_FLR_NOTIFICATION,
+       IDH_RAS_ERROR_DETECTED,
        IDH_TEXT_MESSAGE =3D 255,
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 17e1e8cc243752..5854e8d2bbd4b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -294,9 +294,13 @@ static void xgpu_nv_ready_to_reset(struct amdgpu_devic=
e *adev)  static int xgpu_nv_wait_reset(struct amdgpu_device *adev)  {
        int timeout =3D NV_MAILBOX_POLL_FLR_TIMEDOUT;
+
+       if (adev->gmc.xgmi.num_physical_nodes > 1)
+               timeout *=3D adev->gmc.xgmi.num_physical_nodes;
+
        do {
                if (xgpu_nv_mailbox_peek_msg(adev) =3D=3D IDH_FLR_NOTIFICAT=
ION_CMPL) {
-                       dev_dbg(adev->dev, "Got NV IDH_FLR_NOTIFICATION_CMP=
L after %d ms\n", NV_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
+                       dev_dbg(adev->dev, "Got NV IDH_FLR_NOTIFICATION_CMP=
L with %d ms
+remaining\n", timeout);
                        return 0;
                }
                msleep(10);
@@ -449,6 +453,13 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_d=
evice *adev,
        }
 }

+static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev) {
+       enum idh_event msg =3D xgpu_nv_mailbox_peek_msg(adev);
+
+       return (msg =3D=3D IDH_RAS_ERROR_DETECTED || msg =3D=3D 0xFFFFFFFF)=
; }
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
        .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
        .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
@@ -458,4 +469,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
        .wait_reset =3D xgpu_nv_wait_reset,
        .trans_msg =3D xgpu_nv_mailbox_trans_msg,
        .ras_poison_handler =3D xgpu_nv_ras_poison_handler,
+       .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.h
index 1e8fd90cab4347..caf616a2c8a6c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -26,7 +26,7 @@

 #define NV_MAILBOX_POLL_ACK_TIMEDOUT   500
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT   6000
-#define NV_MAILBOX_POLL_FLR_TIMEDOUT   5000
+#define NV_MAILBOX_POLL_FLR_TIMEDOUT   10000
 #define NV_MAILBOX_POLL_MSG_REP_MAX    11

 enum idh_request {
@@ -52,7 +52,8 @@ enum idh_event {
        IDH_QUERY_ALIVE,
        IDH_REQ_GPU_INIT_DATA_READY,
        IDH_RAS_POISON_READY,
-
+       IDH_PF_SOFT_FLR_NOTIFICATION,
+       IDH_RAS_ERROR_DETECTED,
        IDH_TEXT_MESSAGE =3D 255,
 };

--
2.25.1

