Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE6FCDE032
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 08:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB67310E9CB;
	Fri, 14 Nov 2025 08:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PgW9NJkZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1B010E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 08:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdXszEuNBoATHVw/DX6HNOIKISUzgMAviQf3CJqUTFvFhADq/upkNBwjE78tTs/KgOfYoZPm6M8taTaNr2bjpwwAdS+x87qDwINu0D0vZhRkuiUaCEM/U1h2YseUjvbwACKZFxLoOt8uCqLr1C3f4Ld9dUM0IlSjnt26N2CSgV1tubKCv7xDbgDT41HNdAQdxqHaNJ/XQoullgIpaVciDsdCfg0cw9bJ5/ew+Zqhzg/DVmnvjdSDzcB+lrJ0Rk6gwEeyRJl/6Qf+KObskpwRFWHzDJl9qy4+UgJZUOZP1M80uqMXjvrn61+oU8FBrQVcs/3KqlDHX5Bc1DRrCs1B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkBEToEPQ4melGlb53ZSmU9q8zXovw1AV+CuaXU9G0I=;
 b=WwiAyhP0PtcJCwbOGHSSIQXOKpExn76TVRXTReCluezdpAG2vFhT5fG9RmzCvBwukXoFmH+ayYRfBrI3NPG8wfK5zAe9faFkSalxBmVbcTtG9r7GRS0HC08c8EPdrdI8PGz8x716q4XFkBstNUQFkXwlL1d//hvoVIhx0z4MOSFGSVpJbs6E5kYVfzu4ez4mPFRftNSxddrUvBWys70zY4vu2fWBZ9AIIAtYWPSBpMxQOYMwWFMi8Xxut4/SkKTeA6ZttpyMXmTZdeSJfyqh7agabGgxR1WzcD6Z/frI4+Zc5r6n/+zrBkvGL50CMc5W8ywFx7HdPjnwwwtW+6dmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkBEToEPQ4melGlb53ZSmU9q8zXovw1AV+CuaXU9G0I=;
 b=PgW9NJkZXuM+c4bNCL2uNSRnzNWRrX/qsOnT34jalOG2o2u8H70v6MiNER+4I21kXAfwbjzYwV2ALlDEau+cHJe2FuSMyPxwTkrh9RtcLwDD8N+MgZxvAMsUhmfR4Xr+UICfaaXWObkopAcSP4IhJu9YgRYU4XZcOX2jcJsJoGM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 08:38:50 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9298.010; Fri, 14 Nov 2025
 08:38:50 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Add lock to serialize sriov command
 execution
Thread-Topic: [PATCH 2/3] drm/amdgpu: Add lock to serialize sriov command
 execution
Thread-Index: AQHcVHmKoLkKJXa89UO8uTZjQBeycLTx2dXQ
Date: Fri, 14 Nov 2025 08:38:50 +0000
Message-ID: <PH7PR12MB5997F8F3446C199443C5CF0D82CAA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251113084154.115932-1-YiPeng.Chai@amd.com>
 <20251113084154.115932-2-YiPeng.Chai@amd.com>
In-Reply-To: <20251113084154.115932-2-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-14T08:33:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS5PPFD22966BE3:EE_
x-ms-office365-filtering-correlation-id: 66fec27b-11b9-40f9-3aa3-08de23593c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oxjrZkeLVmHWaudw3y7PuP9zvk1nrxNlJxvpm897sWzdUzD2XrYEnUFEWBMO?=
 =?us-ascii?Q?42MSfTKIyequBd3n045vc8KDRKP9XBPzP0X4F+6xiHEqMt3E4mPjbb2J7ITt?=
 =?us-ascii?Q?ozKOcqsDUvBXk+nva6dqdBkwqL4n/wb2puUFpC3RWezLDZACZglVRCj6xspp?=
 =?us-ascii?Q?7UuQZxvMXmsHL5vQ8jxCPuMLHppIs2Pp3h7SyQZ3m30/+vpTaRkcbieR5NDt?=
 =?us-ascii?Q?h51n+baHzh9KyY4v/ztdTikfCWBeCeCtCl7/NTkZeLA/EinEZ/tZL+p2B9Kk?=
 =?us-ascii?Q?L/oPLoLLG7t8+86qA7Bo0mgStjpXyNVeQkXl0FHtyopYxm2g7zP1EpeqVYsO?=
 =?us-ascii?Q?tsA7NGzu9yWORZDn4hzZeVW4Pmn9A6Y5aVsAzaVFIRJwLj5yNq3z+iHFm0Py?=
 =?us-ascii?Q?BSJCwAzfWugrR0jNEweTZ5HMAZyiUdr9h+t4zbxD4P4rdBPQfmrk3hEZgudq?=
 =?us-ascii?Q?NXLhTXipyrd8lnpHbBh8ytPChDlsGqlc64u6JMKijB67LPydjoZ1MFVUU+AY?=
 =?us-ascii?Q?DYG8ztXHVJzy9qFLrW9lZ6Q4opGrWFgqEv34T8lbrFW+pL+6brLoDWOhE7VR?=
 =?us-ascii?Q?GmzaR06XzN+TrF+WJZQqy3L5iE5oIuy/OzjvLCFslmy5gZWXMJJjJb4ayjrH?=
 =?us-ascii?Q?6cOwDGESXAX+wL3+Qsk5LPqcPWADkNkbyTnWbWJyOCtdDcDD5SoRU9Ejd41p?=
 =?us-ascii?Q?LLYRxzbzGchdtXY7/Mivg3a68EGLj1W5nt5N4dJWdjlNFOxIIV+TMm4UmdgR?=
 =?us-ascii?Q?OQG24J4GJ23jSJY2vUa5Fug2jZ2O+uvZkoN1DgS+SX5VllxqZXt3gw4mzKsS?=
 =?us-ascii?Q?4jimnnQ84Vrmci8acBgmIyh0eMzYpN2EMiMOFNDRXdAibERe0ydeBHN48w0L?=
 =?us-ascii?Q?/lZNgCFPSCTPcLK2pbMJLVnQC2hwJvDVFyaAu+O1ok54D45HCzqKAqCJel9r?=
 =?us-ascii?Q?/3wUkFz644DVoddokMqqbjtvx4sPVwDW7/r6w9N07L+dbQZwAQNCcE9saZN4?=
 =?us-ascii?Q?av8LBV5sIxYyGBh1SbZuZaiyGfnb2h9oiHm/41ZK9uL+kT76WC7UsGudsc1V?=
 =?us-ascii?Q?TfvLhUs/lHpHIrha+Kelbjsp0zSlxyGlOOZATdHXbDdSI2vA9VwyvLc/QMNV?=
 =?us-ascii?Q?ZPMu1XLNPrkNOm9j3GCRNwYNYXIhmNWsVYrxf5dGvaEgWLtc9SERNXqBiTDb?=
 =?us-ascii?Q?hqeE9cnidWd2Tqu3hMd6twDD0FVkDLCvtxg7lr8obZhiSS5Do4085gtM6ms4?=
 =?us-ascii?Q?5CGYqriPnohA3gH0RoeT+zNYtTnDSYMPdLGOMVZnb4sxCwimoaaa3ERT151U?=
 =?us-ascii?Q?FbeMDnTQxQyJax4NaSIiGVF0uWwl6aBB2uvbN0qU58tWv9z8lbC9yTqeS9BT?=
 =?us-ascii?Q?0j35lIs1Zo29KmVeumvfUsk7fUUWbUnly99esvQoOIzSnj9XYc1m/Tpx/fcG?=
 =?us-ascii?Q?uOUJ+NSsAtnGW4VnXrGygtNw3x+DFhh+0QmdgUNjIFT8SMJIcTOnR0DIPjGi?=
 =?us-ascii?Q?j/U3vAVpRb2SoxUfHhGDTpws/TJtcVb6aBdG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3N9Lu2tjstRAUfVFlcxgOSSqalmzkxfiDVTiKprHo+g4zcZjBacGq1aYFGzi?=
 =?us-ascii?Q?71UcSY7YQweBnvfk0X60taCKQU8gUzUCUObGmuA47d6XuWrort62pM/sxa0G?=
 =?us-ascii?Q?J1nl+UgcHBywiasQE2Nb6CrGvGvW+W8dmSHf6NOahNR/F+9xZF/4bxK9Qzl5?=
 =?us-ascii?Q?b7xaLHZzUodN5Hz+gIshb5T5fTa10TSWfLGPKadKR+3Wm5nbbN2bhSG99MbS?=
 =?us-ascii?Q?RlcJoI0iwFlAx/2zT7PhqhsTxhXz8OV4IUBGOa7x97MvoC8sU0+s/cFjsL+Y?=
 =?us-ascii?Q?7g0FbOPqtVVssosvQgeKUVrDEEPOFxEs490VCpDAz++XSfA6wLq3CU79GR+n?=
 =?us-ascii?Q?7DjvmgMlueOmG16kEwIHys7zz+4JzSPcYYLmCVBxShRo4oPcLYpFijbkNOKu?=
 =?us-ascii?Q?J37YI21B1LhZN72ZLDQsaP7H3MM+Onk2pwSuc44hCcpy013MlgrJRa14I0Cp?=
 =?us-ascii?Q?//6hCes0YdzJusQ30s3TNU0ivPhWcWx3lmCq1l8fI2jXtTPPtsuYiSrkJUbj?=
 =?us-ascii?Q?TW3dS/UB9plrZTdgsxDTIiEed7/XMFUWNoZln7SckNk6ClBprGt0AZYo6kGc?=
 =?us-ascii?Q?l0ADB4ez8FrKFWWKsoHZOEmSp7aNbyHySBhY2kdCN/oBoaT3tyedASr5JxIh?=
 =?us-ascii?Q?Fz9uozr39krMmaKpYUdWbAfShYdT1KZVotREAyE/rfB7Q435lTfKWmam0gMB?=
 =?us-ascii?Q?cRapsOpBxB1BaC9Tl3/4BZJwKp7JQwlNVzqwz2u4anCC3GtmkZka8BH+3o3R?=
 =?us-ascii?Q?8Ev5bGEdpI+8hu2z/WORbqpRzPdZYaVYtS3rx+89UcTMTb/lB/9S1HJ/IJKH?=
 =?us-ascii?Q?y71caomIfmjHeoReJhkdS6gJKtO0d6O00Otkxh4SeQnTNHjSY0rXDXugIBEu?=
 =?us-ascii?Q?fYepRoxEL+bPUEUGptYDsigbt14eZDQmehgwtxosO169mXBnfdvjxxql6GZI?=
 =?us-ascii?Q?bhvnL1S7O1npPkvFQDcD0VQ73mXEELDqbYkfMjzucI7oqrkPRqO9qNTuYsvJ?=
 =?us-ascii?Q?lCfHvD1NN4AQprkYZ0BFJzthvDS1FbI0ek09QA4UZEfEW6KtbMYyhVSeyONn?=
 =?us-ascii?Q?BJlDoKfkYCyhSgrExEH/1Sb1TLgEEYxdUuPwUJOe5C7JIT0/yP0KmblkSYxC?=
 =?us-ascii?Q?VAcrtFyPLx3FNN2fI6FLSajp7/0VPhMzqfI84D5FcXbtoBDo0Ykju6qgJJ6H?=
 =?us-ascii?Q?UfEuzlZbchuE4DZ1DFjCEBCRSfZSh/ioLUSJV9Ix27UV1fOl93pB//T8DL0e?=
 =?us-ascii?Q?t/nLOQhFScUbDqjz1vYc5NzUiIyE+HiWyQqUuxJd7DPE13hzXWR8F818KZqP?=
 =?us-ascii?Q?tG+N7THoeJFkYAFpkC24BIHONjf5giwnM8c1h8iSvZzXIqW3Q5GSNVSJxvKi?=
 =?us-ascii?Q?H4xuH3MXChbmE+linuElLO3LeYIUnDhO0lhqdRZgZi2gPvSBaF5/JDNiep//?=
 =?us-ascii?Q?HldP8EWD3xinKbwZ0kQ83Agu5260k1SqU5lQKtyEqWdldm1NGPlAx11JWHYV?=
 =?us-ascii?Q?WgFyffRdvhCIUYfXcPP1IMAtmIZLgHwX7WS+PhWRfhq47sxKqDR4fUwxJh9G?=
 =?us-ascii?Q?ejNbrgdZSjgny+HPkTA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fec27b-11b9-40f9-3aa3-08de23593c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:38:50.0898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2obOWTfYt6ap102DoGNSgp8f1JnSrtda1isgnlPgon9noKag834i6M/xFWHSzsb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Thursday, November 13, 2025 16:42
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su=
, Joe <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add lock to serialize sriov command execut=
ion

Add lock to serialize sriov command execution.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  1 +  drivers/gpu/drm/amd/amdgp=
u/amdgpu_virt.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 17 ++++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f2ce8f506aa8..47a6ce4fdc74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -917,6 +917,7 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *=
adev)
                            RATELIMIT_MSG_ON_RELEASE);

        mutex_init(&adev->virt.ras.ras_telemetry_mutex);
+       mutex_init(&adev->virt.access_req_mutex);

[kevin]:

it seems the "mutex_destroy()" function is missed in this change?  this can=
 lead to resource leaks.

Btw, all above 2 locks have this kind of issue.

Best Regards,
Kevin

        adev->virt.ras.cper_rptr =3D 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 14d864be5800..8e61cf52c946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -324,6 +324,8 @@ struct amdgpu_virt {
        /* Spinlock to protect access to the RLCG register interface */
        spinlock_t rlcg_reg_lock;

+       struct mutex access_req_mutex;
+
        union amd_sriov_ras_caps ras_en_caps;
        union amd_sriov_ras_caps ras_telemetry_en_caps;
        struct amdgpu_virt_ras ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index cd5b2f07edb8..e7cd07383d56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -173,13 +173,17 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_=
device *adev,  static int xgpu_nv_send_access_requests_with_param(struct am=
dgpu_device *adev,
                        enum idh_request req, u32 data1, u32 data2, u32 dat=
a3)  {
-       int r, retry =3D 1;
+       struct amdgpu_virt *virt =3D &adev->virt;
+       int r =3D 0, retry =3D 1;
        enum idh_event event =3D -1;

+       mutex_lock(&virt->access_req_mutex);
 send_request:

-       if (amdgpu_ras_is_rma(adev))
-               return -ENODEV;
+       if (amdgpu_ras_is_rma(adev)) {
+               r =3D -ENODEV;
+               goto out;
+       }

        xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);

@@ -217,7 +221,7 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,

                        if (req !=3D IDH_REQ_GPU_INIT_DATA) {
                                dev_err(adev->dev, "Doesn't get msg:%d from=
 pf, error=3D%d\n", event, r);
-                               return r;
+                               goto out;
                        } else /* host doesn't support REQ_GPU_INIT_DATA ha=
ndshake */
                                adev->virt.req_init_data_ver =3D 0;
                } else {
@@ -246,7 +250,10 @@ static int xgpu_nv_send_access_requests_with_param(str=
uct amdgpu_device *adev,
                }
        }

-       return 0;
+out:
+       mutex_unlock(&virt->access_req_mutex);
+
+       return r;
 }

 static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
--
2.34.1

