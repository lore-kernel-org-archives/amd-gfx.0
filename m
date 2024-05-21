Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B8DC25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4072410E2A5;
	Tue, 21 May 2024 07:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UtRznA5H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F04D10E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSO1aNuX/LOrZuyl1k5bOuyEzgjwgRVj9ztpRJmBBjdQVxfG8sCSLFLbbbTU3Pzq1KcE2CKXHWTjBw3M8eY0MS//zFDyHjiJ2Q+WkS6w/T1sw1ndACYZJkyS7oHR+MB0gI7cu0m1HIWdkIduFWaSzd7WfGOFO/gTLvlXQtNk3VmsQ2VMZvBum5bDmGbJ11/qVVmDCPkRc79asZF7HjpmaCt7fB7bwdeg2JpfqVMwL+BWPPMUwjXwFPd9U8skyyF128j7nxj6UUHfaB1nrlvBY/rmucaa+TbhlU1PUd4t/AWPsJyraIf8WVD9GmDG5EkH42Z5sl+AXBlJsHwHWbppbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ije8WyfZak9JAsWReoyJe5q/VlPV7qYGMDPCx3VwDYk=;
 b=HXXNaMe0iU1XjdieUD/aDmgJ40To7LCPNDcSllL4TFKj7P43z+TKjd6Hvajec2x1XHsK8/N/D5s/nWQas3FXHuEZDFGDXWaHQOzEyWrfQO8eyQIV/WheAiSDEeBlSrLj628TmjY9ubQwe9LNVj7Vb0l0Ow6PWbnx+J2Imd5gAUz/2mOf5ek3BQyeu0ipA9MrpMxHT6ReU7mgit+KQeR6EofoAE84vV0i9rddAO4vYQnUoJ/UMrxtnbSNPeBhUA0cu/mZx9DTpLqQxEZRfKpdzipbRBABWqVQXi8jx7Zyv5OC92JjBgTRvksizZgtrXs3yWs/857vsaaaJblpIGsYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ije8WyfZak9JAsWReoyJe5q/VlPV7qYGMDPCx3VwDYk=;
 b=UtRznA5HyX3hAaCqiuNpXVD+NIXXSFYgkM9u6EJwLT/KIDNT5eXTGFb4oloF+Tu5HXSRmHnHDkg3ukVY39pVSY27DS8zIAHpdB7iBtMykMt+NBLXu4blANmRm175UHMFMNGdpzZvFBsNZo29Hk+NC4Tzki0+231zbWeS9Td/cfM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 07:54:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:54:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes12: mes hw_fini fix for mode1 reset
Thread-Topic: [PATCH] drm/amdgpu/mes12: mes hw_fini fix for mode1 reset
Thread-Index: AQHaq1GHcoZB/FHB9Uiiydb4wWfJ0LGhUWkw
Date: Tue, 21 May 2024 07:54:17 +0000
Message-ID: <BN9PR12MB5257631F5ABFE8EAAC49541AFCEA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240521073535.2474624-1-Jack.Xiao@amd.com>
In-Reply-To: <20240521073535.2474624-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1bdc636c-e9b3-4af9-a72a-4cdcceb3e424;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T07:53:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5770:EE_
x-ms-office365-filtering-correlation-id: 4d68fcdf-0ede-4ebd-22e2-08dc796b3777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|38070700009|921011; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Um1V6k8/rW/7T2vUqLFQNJYfPdpKCjXcbsPej7zurgcIki3Vd8tTnEloBsM5?=
 =?us-ascii?Q?LnpyIB3kDCl3N8IYs8zEeiW+eFzJmQOIrfFlRo8Upn2I4aF4/yQpLx+MFdpG?=
 =?us-ascii?Q?uLm/SmrnR057PGGN9zxM7H8nMYoEofmMVdJLqSD4VXSSjSIeeB70IRxi4XXf?=
 =?us-ascii?Q?L3r7FebeTk+qA+6fFfyl6xuPx19EDKkkL8Wh0KKYatZXNXDmG7LTU0wWdXqo?=
 =?us-ascii?Q?drdQmE17uvLp8DyLBScM+S8lyNuolb+HQ2YZERjJa0zkbfmYB971c0DrZ3/U?=
 =?us-ascii?Q?9U0QiQ+sfF5JPwVuHJ91UEJvSQMdm0mMcptFKsSwVVKoGJgLrS9/eSKShMjQ?=
 =?us-ascii?Q?M9DkiGhn7no5W93hepbZppF98L99DJoZDOF2alfO65scvNmX3Y0jwyXQfgnm?=
 =?us-ascii?Q?FyPfZr8Ovb7L9aBErPeQrackwQIydETP6U9Un4LqDmW2nlOXkkagvy+uuW9E?=
 =?us-ascii?Q?uBWlSNQmBFY3Lqb8JbWtO1SlLktDyhP3tzaD7MBwvbuXK0dRxG0vJmYuIt48?=
 =?us-ascii?Q?MWyvBWYp66+FgJ++RiDc+sMH4kLJvAlvj6/eN+z8rMUTIuRWPuR/+lnmLj0C?=
 =?us-ascii?Q?KUS58SlIhKccS++J522bLO3xSav1Gbrns1Z4YKgDWzGPOyNFn496O9aO2UTk?=
 =?us-ascii?Q?Cm0KWSYVYEH4tAh06tLFswiyWB8zDxmw7qVoKA0JI/5u17wEQlAxuJyja0RV?=
 =?us-ascii?Q?e3PLs/GJ/PcSQPclKDDuMfZkeff3hrwTYTNB5r/joSwO9RzPABt3h+EO3xJp?=
 =?us-ascii?Q?fOVlLf/36ywc5O7tSp5g7ARp87FZls3c31buSL/NkJoa9XjLTb7lGmOfpgxP?=
 =?us-ascii?Q?+EyHjFtCuc0v1UMIPn/W5yfUebfuWgPkLq2GDZSMYsyIBFHgAmEcXo6V37Dc?=
 =?us-ascii?Q?l3OVSOFYELTNr42mL+g501AEfuW/yEHC6X2EYVh0mUH/9U/5g1nCHr1kct5h?=
 =?us-ascii?Q?AOjcqd46WWI9Vo0RVVGg5tVfwqlYxnRNPZlYvmftI7t7+T3q7sEGo0x5EIve?=
 =?us-ascii?Q?N56AhxDTw/VIYtx9lT5Wdwh0sNAv/YxlxAOPO5FbAZY0RBj7L3TqbuyUZjE1?=
 =?us-ascii?Q?DxHJbUC5l5w9EkaQ7afGqjMRfvJp2lSE6NCHLTif7hTfB4cGSyzgVADfo/t6?=
 =?us-ascii?Q?6kQeHzwzUvZlRLJbUwCl5SwZl1Xw5+ELjvii9cWvR6f+oLd8VDxZLRW4azU8?=
 =?us-ascii?Q?wR2vBg9hY3rXSzJFUyH1RrsXDdUZVbKwVm2OTzT8PPXzDZl017Q+4IRZuIuS?=
 =?us-ascii?Q?YjUyalAXf2lBglRJrhedtVuBtflMj3Yw8K67/oHQG5GGL+I/SavBxxi5RixX?=
 =?us-ascii?Q?BUsHmR2FRLft9UtQQznOhlbtV1dBKfcxHsXUvWSRGbq9Mra5hESRgejGanlb?=
 =?us-ascii?Q?jEV6yaw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(921011); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InC4EJLB+JdujzUnymz+popZ1jiDmhYO1pvvwoOMZYEFx+u0Ncq3zHs7pNeb?=
 =?us-ascii?Q?ASNmRUNyq9zo01GvguOIkm4iIIeT1pYaOruS9pgFO5TbqUgGpd/Ur12wab+F?=
 =?us-ascii?Q?OusrEX3ZA2UWow1zBlf1s9mLzh9slDndIpzY0xr0DAyFuIMrmvzbSyatgcHZ?=
 =?us-ascii?Q?BxuUXQ8TSnXHFI0MsabG9zS1/B5zwGveLp+QuvKpW59Wb4PgAIOLSoEanCRV?=
 =?us-ascii?Q?pUArCHdpOQNPSHM0b3r6CRttpg/sljjMCqD7gyICP/kLGoCW7VrOBWirez6m?=
 =?us-ascii?Q?IGVbc7KdTVQDncDEQydfKf0AfBiY+TNa4uiSHRufxjswEmWHQA95I02EQMol?=
 =?us-ascii?Q?PERPw7/i10g1tC7h03FUB0eCUJNMtvOI65D+I297CRNzWks4PtuO+PMl9RKz?=
 =?us-ascii?Q?5+obbaSNj+YEWq88MMsIL9GxgA1KovroGrwGlrd6in96SWLPj5tuxgYXZt0l?=
 =?us-ascii?Q?BJKYrdvK97lRTly+Y22sZmdwBoucKTTPWvakkePAtBkEn7gZNoH3XfmzVUaB?=
 =?us-ascii?Q?f/i+/bDU/u+Nqu5ygFLF7g3ShoKl01+0qErBcN75Zq7v89DAZVeIiL4tw3kx?=
 =?us-ascii?Q?HhxdqJVYte33wIQLjyPyYbJAfiX3Y0byd+ykN9r3zgDsdgOnXksZluU11gse?=
 =?us-ascii?Q?1dlC5xU6NY5xzVoPp/LFaAJtx2WbkzD80BvlnFIONdDaf5U2ARxovdKtGVMB?=
 =?us-ascii?Q?/W4yTeMMJLbBZ8o6JScZuyoBPP0qbCWBLjeVfpWGo+ffcgwdD6trmsXfjnIn?=
 =?us-ascii?Q?XDfzwzX6UJNQ4QFYt6aZkiN3NH2IzvIiDzMQCiRjCnGmut7sJoX54sPaLqGF?=
 =?us-ascii?Q?erVJpZZONQAk6F35Tjv2U55Tzp/J5kuoALTTYCmsU1ABGt+IF6zgRzA3i1cs?=
 =?us-ascii?Q?Vc66vfIz+ynvNneWw7AmVMtariA6z5gCcjXf1wxOZKJqvN7b0gwQdfy2Q5Me?=
 =?us-ascii?Q?7eUINimedlIlfz0qeh9VBIp/pQmg/Pdp/AxkBtLdJ8tzCtu2avEH1Qx0j3hP?=
 =?us-ascii?Q?U3h/uiKQpKYdNtayXhDqcYEBVCB3mmk3+/YuCvVwncPL0w/hUqFnHS3lwlUy?=
 =?us-ascii?Q?iyQUm67SC3ZDrbP9cIimhSG/CRf2VhmvtwhAkniI1PLOvnCAwF/zFIdHyI5Q?=
 =?us-ascii?Q?ZgbqlwE1FV6jZKVMQOwQbrfzBf748qnzOotgNtHcYQiuukB8SY3XUlez7BVv?=
 =?us-ascii?Q?jtb1kGLyYIOsVyznGK0LoRU/TupW9YqlKxcu/b3lWKpiftY+8iNRD4xevcgp?=
 =?us-ascii?Q?k//HeA+g2D3hOGIvVS6LSrO59etoP7KrV8sEATcyhUK4VeyyFfMh3rlXV7C2?=
 =?us-ascii?Q?qyb8TKJ3nQBffrxgqALO/0SEHYfeuJQYmH3GoiziHhBRP9oY0QuVsItueATE?=
 =?us-ascii?Q?LIyQz8gww4cPLouthb45uW2tMT6yLBhV7gYwYRZ1Q/X4wY3uSI7hawaBuumT?=
 =?us-ascii?Q?NqQ9YJXDtTYOkIlI2dQjdt8pjdD27glgS6VZxtyU4tH9ArJ4tT6edmRyF6hs?=
 =?us-ascii?Q?Kb3APxw3n01axfkjFT2oBG1O/y3+4ZKwsbQkOI//HZC7MmS5kaYk0joT/bf1?=
 =?us-ascii?Q?BKbGCjvKnYTfpXIIxSAfPu/go7iX8h0Xv6NAUGGc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d68fcdf-0ede-4ebd-22e2-08dc796b3777
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:54:17.8433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhNGYA0oKs5mWvYL/e+VbmpdgV4JEX34wOEt2iuFbf7tPTH7d7yQ8zPcH+JJNOkdzC1jXW8fwZuQNuUroNj3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Tuesday, May 21, 2024 15:36
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Min, Frank <Frank.Min@amd.c=
om>; Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: mes hw_fini fix for mode1 reset

Port mes11 hw_fini to mes12, fix for mode1 reset.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 45b70a4c4ada..f18fdda023c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1380,11 +1380,12 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_devi=
ce *adev)

 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)  {
-       if (!adev->enable_uni_mes && adev->mes.ring.sched.ready)
+       if (adev->mes.ring.sched.ready) {
                mes_v12_0_kiq_dequeue_sched(adev);
+               adev->mes.ring.sched.ready =3D false;
+       }

-       if (!amdgpu_sriov_vf(adev))
-               mes_v12_0_enable(adev, false);
+       mes_v12_0_enable(adev, false);

        return 0;
 }
--
2.41.0

