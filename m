Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD5C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 07:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F207210E317;
	Wed, 15 May 2024 07:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EvUU1p6n";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AFD10E317
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 07:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Zy8syKboo6urbw0syB4fmFbDpUXgIElBwVvmbPhrpoNcW5icm/z3CrLJMO7tDoc05iKcWyWAV0UqLwwwYILiODMHU0gsK4x+EipK71NJ/rCa+fU3h1tFzUNlC5KE4MDbcwEwcTf9l1FAL7nXe/t9pUowPhbI9jgEyUmQKbjxfF0YiMZlGeSN5pnypx1tyE8dWYfK8+TGGCm/NdTNO3JyUlzR2wnBsxSIVQM7YIpXK+yNYn/gJrfT0LFy+1CQH4NNCq3mJTqJmt2uNnK9GXfs6s3maCYO5LL3hKlw/ebQDs00tKNZQE+b0iVPXyAKRxSzyNZq8l/SFrFTT9O9WyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR/fnzNLwgDogo3bIVP+oDVnD6Oh3p2rGwOd1o/5/rQ=;
 b=RpQVXnJSMC9as6fqfh1fUT1tCAoswjkdrHv7uCdpGgi8JpOZNOrFu1isdARKdLNd0KzWPI3lDJHZkLCNN52a77oSWmyRI3yplnqIHkpHFdvAP/933GGVfhLCazQdR/xgJ56n+68TdLstXsgYYQMAPrI3oQDwRETgaxeXAgQ69jWhKFwOjky6txBz+cziWRL621bc98onv48/ANRFPJ2ftTu0dHwWuBiikSkhBrD/Zj3sEZi9lDbLYwRp1SVx+lRhWiwafG4bLskszoY4z7AtGFSpWFyAImGX/gOpUPr+Bc+2s5HZ2vpxkKvg5a0q6IcX4ENMHDBAhH9Z6nBxhtu9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR/fnzNLwgDogo3bIVP+oDVnD6Oh3p2rGwOd1o/5/rQ=;
 b=EvUU1p6nFKd66l2ab9DApNQyAUgkVUVRFRRHYY12CaFvs0gwB/IkO4Fx2XvHaQIxD/9KSF0LcF2D5Z9mTtAlw6QqjWLUu3poM8xzyldsZVAMxdpKV/JqsoU1X7KXfZ3qBCY6NGsQJa6l3EAg/4DIdrmWgd8lord5mJkfopZm5Ws=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:40:24 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:40:24 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Ma, Le"
 <Le.Ma@amd.com>
Subject: RE: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies
Thread-Topic: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies
Thread-Index: AQHape7IRrT5H/9VVUKGvtKt0XFhXbGX6RYw
Date: Wed, 15 May 2024 07:40:24 +0000
Message-ID: <PH7PR12MB599728DBD2B17E24E853639F82EC2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
 <20240514110606.396234-2-lijo.lazar@amd.com>
In-Reply-To: <20240514110606.396234-2-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=abb6a132-e9e1-475a-8534-3add8e2d3bba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T07:35:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM3PR12MB9433:EE_
x-ms-office365-filtering-correlation-id: edaca7d4-f6df-473c-0a1d-08dc74b24846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ckBmI/B4hMIT8I5HnJo3ezxO9Ed4WonoUqVXBFle+cHH5iPKck6X+vWE+wuE?=
 =?us-ascii?Q?f9TaVBChViTj+VDmZKw5vWc2dCkVpMhUzjiWMSNXH7vNluNWEfJ5NVkm5Iaj?=
 =?us-ascii?Q?y0AUjDQea36bKHwj3yAENRn/3aif6HdwLl8krnh1D2GYtHUYVZttSHoYYqxD?=
 =?us-ascii?Q?YP8YNRv3TBDoYzm1ViNHvv3dZYvEbyW3zoZAP0YIEEvYwknJnovRMD80t0IW?=
 =?us-ascii?Q?eW9J531te0Cy4hQkHnewEzbQpSUQD0EOFCI9udS9Jw2A3219Z6zn6TPoM7FU?=
 =?us-ascii?Q?l0PAyiiFG2ihGcj7J36GubLbKRsjk47GqUA++nYjhNkNOWovpiKqGjwdWL1R?=
 =?us-ascii?Q?ERtithhQZMQxcFNoNQ+NCHe21++t+lF0PvHB6SdUF7jqRWXZqTQECBCGraq3?=
 =?us-ascii?Q?W/x1SwuQyEenfh6YS2T+pqPy8TveC60qotxPIjxmaBabt813O2ZC4lmhiQ9x?=
 =?us-ascii?Q?+eb7MqiUz60+ELB6aSGzBi0LMcjkaGklkLD1O5c8DWLZu46lCRIqfRN28Qhd?=
 =?us-ascii?Q?fzeARlri1id9gJfqYzltjsh1hzoh5hBHLEEMNNmW8kyeh5BXYuagJYLns4te?=
 =?us-ascii?Q?dheL3jViSWZ261mh6j5wGgfikILCHoIRcqY3R97BBAxqDz9fdNSZ97+bb9mh?=
 =?us-ascii?Q?0FC+bN0nPmqnMuW1P0iFeEqea/dAdtbu+h5cxDlxJT8YGR3fmr9eWKhdEY5Z?=
 =?us-ascii?Q?51R7aVdcSUxufh5FDjvhVBepsj89Kc/TDvNdQSqvh30kbm1vwfhz/WVkfuts?=
 =?us-ascii?Q?/ws5GnpBOZ8ZkCoNF/VpIlQAAxhweCnOv0xJxeLTCWuvBJFk2O9lFSr0zUKe?=
 =?us-ascii?Q?V0OXihOA1EPTLdf2sT0xa42Dc6GezJqMWpsU8blkZtnDbvWlB9z44HswNBSu?=
 =?us-ascii?Q?UA45zJsl47jlyU+bAjnjwgpyOtSBc1zIfdmjp7rUPPLNpTzV+ta2JhHRQ4HN?=
 =?us-ascii?Q?67xw5LWT0U3/7Pox05fAskYGjl6UMQNstw+Tc/AUUhVPLEFqOBg0sKvWekDP?=
 =?us-ascii?Q?u4fIZqxpYyeBmV915sALc3XoQZB9c62ax+GHgkuBQB4n2xFKfeIOZ3Uq5BW9?=
 =?us-ascii?Q?UODXgQXqIUvnzUGCizOo0/uMkpWj9Uvzke3CsttKNsAmFr/eaOrvS9IXVAM4?=
 =?us-ascii?Q?A3Z2xTQGobRkaXhY/ir6GgNF6uMCrEoE/poHuhzDw6oJRHMuvU+Yugvibst6?=
 =?us-ascii?Q?jJi+0rowRSd0iZXF3Is09GHYZnPgTMHrUBs3HjuPW3Jh4UY9HmoroVKIVJCO?=
 =?us-ascii?Q?hvQkrtT/qLCflxDqVLiq+VAwGVdlbwq+f6ZDd7lKcKQH6kTb+dYtCVXf0+H+?=
 =?us-ascii?Q?CS26yqzR8D7Ik4VljVBbq0Uf4hMFgp6BnBbJpLsCRmJM2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x7OernD+KcGq4ZB7H6zxW5aQmqyDifCQtnB2Zt0i/Y6cxOUKUAUjujhsFD/i?=
 =?us-ascii?Q?jos24N+/sJ5up+USMmHMYDJgAE6HVKgQxfmOQB2P0Rx3+xXWdZ3FESX8C82a?=
 =?us-ascii?Q?uwwVDYeAywA+q7qyptoFQJvu8lPaNyuEgJ13Qq5lNO+1tURyQbnZchuzdSbd?=
 =?us-ascii?Q?Z/F4+DQLVO5ikg97KVQu58IKDK66CyrJwOCeYGsMdFzLfgwtflzKBOiEVl6k?=
 =?us-ascii?Q?ggtloonwDyUF7widRcRfVn59t9oeU/LGZQcOEcwjiXsb/HNFPI5QrPvXOLjY?=
 =?us-ascii?Q?6QrGmXLTwAVq+4OYdgdZUL+Ba2j/HAqYn22xn8tL2Huvg8Na05pJh16hBKxi?=
 =?us-ascii?Q?MUnx+kHQwvk3yweoS398ozoUooRIrxdC5tQcco3H3aKcyJ4tUDm/uWL9oDqR?=
 =?us-ascii?Q?oqw27aeqI/G71YeOytouhHvSVLiLMJ/8dr0NcU5SefmlYy2qXDt7tGNygbD1?=
 =?us-ascii?Q?3FPxJcV0XXqojok8up9vbBqMI0MSIUubYEaaFHAIRrkf9s+MQMk4KyJ4F67x?=
 =?us-ascii?Q?zXsy9uPRyQWHF9fvAGZWpMEDahIckmvufQfaPoO1zzEE2wadChqdLk1MSRzH?=
 =?us-ascii?Q?dEs5OWiAkhBwhyKVWWLLk5ROI3hSjQOQEI9E17eIRsqGxBQ/mNxJSxVtXS7p?=
 =?us-ascii?Q?VSagbgCXixgc7wund2iPAOvmVIJ+QYcxj2hkMsgA319Q18Ebg5jhGZ2W74sQ?=
 =?us-ascii?Q?kXlLG9MbQ9+ydvyORmS1OC+j7vq4S+nQcPRxn3FumCc0mV5vZlLIuqTTjCwS?=
 =?us-ascii?Q?JWQ6b4n6g3zyqoNICnZjFjvKu1SZX3OOQru+K6b0RROOPmVj7ttEjEJszqF6?=
 =?us-ascii?Q?IwI19wLsjCmfpJzN+HQSSpcWju8KsbbwkPQioXq7ffV9KmQqrFm+v5Iczh0Z?=
 =?us-ascii?Q?1pLUT4oQxKuEcCk/0GiZ9uIYmht3/zVj8QwaYbj89U57GhqUYlVPF88XmYA1?=
 =?us-ascii?Q?3Gco08eelf2d6a/Iy8MKHIWAIrY1kwvSRYl86vIPpb39jOL08JqL8vCLZQrb?=
 =?us-ascii?Q?tHFuOYLLpmlZJfwurpKn6UA+gpM8NTeabFbt21v5cd2FLsSi2kRm8g1i/7R7?=
 =?us-ascii?Q?XkAPsloQSw1DC5Dc1u/eUyL5jJWoohHIgCmrOyBKHEg/F5Lv/Nox5VLs+hJg?=
 =?us-ascii?Q?BBCeasVzbUiKrV1ggcTlEOZTL50PWEyGifQo639Q8sdN+4JkIJM02//K74of?=
 =?us-ascii?Q?Zhw4EQQV+HbE7nWr4cyTPkyw3RQ2YJ8UrD98t7jNh2q51cwv34ViSOVpruiR?=
 =?us-ascii?Q?TArCP5JTekogAXWMd+wtjnJjGiwX0OwHUogZulWB5OW5fa1ZUnPBkeTixnrK?=
 =?us-ascii?Q?UlgU0qM2cu5PgEUIQMKXDHQ6KKMgKEXQEfvpoGhmPh7pXZ6ftPe0/6YM9v5n?=
 =?us-ascii?Q?eqF3GJDsO4uK8e1CfQ/lf4KrxFy2a0VrChy9ZNbGzJTDogyR0FtRvParDS59?=
 =?us-ascii?Q?tLzmGQFwQgoY0EWsgEkf6bBE2CPM5D7L9EtStm8D6AUCSDc5G8+Rs5nnn0AW?=
 =?us-ascii?Q?l03rt53FkvxA26zdToR8QubwhXz7hdqfN9IUnR6W9XrzgiUVOZMXln4efN0e?=
 =?us-ascii?Q?nBbKzbQ9vBl6iQ8xo4o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaca7d4-f6df-473c-0a1d-08dc74b24846
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:40:24.4984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/g0SnJlg0/rPWjCa5jtfDnTw+kCPg7eTv3FDlvvhfvUovsFFianS1xW2zsm9r8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, May 14, 2024 7:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies

Add support to set/get information about different DPM policies. The suppor=
t is only available on SOCs which use swsmu architecture.

A DPM policy type may be defined with different levels. For example, a poli=
cy may be defined to select Pstate preference and then later a pstate prefe=
rence may be chosen.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2: Add NULL checks before accessing smu_dpm_policy_ctxt
v3: Rebase to add device_attr_id__pm_policy
v4: Use macro to define policy type for consistency.

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 94 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 98 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 31 ++++++
 7 files changed, 273 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 805c9d37a2b4..8ed9aa9a990d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -273,6 +273,22 @@ enum pp_xgmi_plpd_mode {
        XGMI_PLPD_COUNT,
 };

+enum pp_pm_policy {
+       PP_PM_POLICY_NONE =3D -1,
+       PP_PM_POLICY_SOC_PSTATE =3D 0,
+       PP_PM_POLICY_NUM,
+};
+
+enum pp_policy_soc_pstate {
+       SOC_PSTATE_DEFAULT =3D 0,
+       SOC_PSTATE_0,
+       SOC_PSTATE_1,
+       SOC_PSTATE_2,
+       SOC_PSTAT_COUNT,
+};
+
+#define PP_POLICY_MAX_LEVELS 5
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index eee919577b44..b443906484e7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -411,6 +411,35 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device=
 *adev, int mode)
        return ret;
 }

+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
+*buf) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_get_pm_policy_info(smu, buf);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+                            int policy_level)
+{
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_set_pm_policy(smu, policy_type, policy_level);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)  {
        void *pp_handle =3D adev->powerplay.pp_handle; diff --git a/drivers=
/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 110f2fc31754..6dab0b085239 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2278,6 +2278,98 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct de=
vice *dev,
        return count;
 }

+static ssize_t amdgpu_get_pm_policy(struct device *dev,
+                                   struct device_attribute *attr, char *bu=
f) {
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       return amdgpu_dpm_get_pm_policy_info(adev, buf); }
+
+#define STR_SOC_PSTATE_POLICY "soc_pstate"
[Kevin]:

Better to move above macro to top of file.

Best Regards,
Kevin
+
+static ssize_t amdgpu_set_pm_policy(struct device *dev,
+                                   struct device_attribute *attr,
+                                   const char *buf, size_t count)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       int policy_type, ret, num_params =3D 0;
+       char delimiter[] =3D " \n\t";
+       char tmp_buf[128];
+       char *tmp, *param;
+       long val;
+
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       count =3D min(count, sizeof(tmp_buf));
+       memcpy(tmp_buf, buf, count);
+       tmp_buf[count - 1] =3D '\0';
+       tmp =3D tmp_buf;
+
+       tmp =3D skip_spaces(tmp);
+       if (strncmp(tmp, STR_SOC_PSTATE_POLICY, strlen(STR_SOC_PSTATE_POLIC=
Y)) =3D=3D 0) {
+               policy_type =3D PP_PM_POLICY_SOC_PSTATE;
+               tmp +=3D strlen(STR_SOC_PSTATE_POLICY);
+       } else {
+               return -EINVAL;
+       }
+
+       tmp =3D skip_spaces(tmp);
+       while ((param =3D strsep(&tmp, delimiter))) {
+               if (!strlen(param)) {
+                       tmp =3D skip_spaces(tmp);
+                       continue;
+               }
+               ret =3D kstrtol(param, 0, &val);
+               if (ret)
+                       return -EINVAL;
+               num_params++;
+               if (num_params > 1)
+                       return -EINVAL;
+       }
+
+       if (num_params !=3D 1)
+               return -EINVAL;
+
+       ret =3D pm_runtime_get_sync(ddev->dev);
+       if (ret < 0) {
+               pm_runtime_put_autosuspend(ddev->dev);
+               return ret;
+       }
+
+       ret =3D amdgpu_dpm_set_pm_policy(adev, policy_type, val);
+
+       pm_runtime_mark_last_busy(ddev->dev);
+       pm_runtime_put_autosuspend(ddev->dev);
+
+       if (ret)
+               return ret;
+
+       return count;
+}
+
+static int amdgpu_pm_policy_attr_update(struct amdgpu_device *adev,
+                                        struct amdgpu_device_attr *attr,
+                                        uint32_t mask,
+                                        enum amdgpu_device_attr_states *st=
ates) {
+       if (amdgpu_dpm_get_pm_policy_info(adev, NULL) =3D=3D -EOPNOTSUPP)
+               *states =3D ATTR_STATE_UNSUPPORTED;
+
+       return 0;
+}
+
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
        AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2326,6 +2418,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
        AMDGPU_DEVICE_ATTR_RW(smartshift_bias,                          ATT=
R_FLAG_BASIC,
                              .attr_update =3D ss_bias_attr_update),
        AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,                         ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pm_policy,                                ATT=
R_FLAG_BASIC,
+                             .attr_update =3D amdgpu_pm_policy_attr_update=
),
        AMDGPU_DEVICE_ATTR_RO(pm_metrics,                               ATT=
R_FLAG_BASIC,
                              .attr_update =3D amdgpu_pm_metrics_attr_updat=
e),  }; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/=
drm/amd/pm/inc/amdgpu_dpm.h
index 501f8c726e8d..1455db9c3789 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -598,4 +598,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struc=
t amdgpu_device *adev,
                                                  unsigned int *num_states)=
;
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
                                   struct dpm_clocks *clock_table);
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+                            int policy_level);
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
+*buf);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h
index 448ba3a14584..6ec9fca045e0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,7 @@ enum amdgpu_device_attr_id {
        device_attr_id__smartshift_bias,
        device_attr_id__xgmi_plpd_policy,
        device_attr_id__pm_metrics,
+       device_attr_id__pm_policy,
        device_attr_id__count,
 };

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index e61aa4418d44..df9ff377ebfd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3498,6 +3498,104 @@ static int smu_get_prv_buffer_details(void *handle,=
 void **addr, size_t *size)
        return 0;
 }

+static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char *sysb=
uf,
+                                size_t *size)
+{
+       size_t offset =3D *size;
+       int level;
+
+       offset +=3D sysfs_emit_at(sysbuf, offset, "%s \n", policy->desc->na=
me);
+       for_each_set_bit(level, &policy->level_mask, PP_POLICY_MAX_LEVELS) =
{
+               if (level =3D=3D policy->current_level)
+                       offset +=3D sysfs_emit_at(
+                               sysbuf, offset, "%d : %s*\n", level,
+                               policy->desc->get_desc(policy, level));
+               else
+                       offset +=3D sysfs_emit_at(
+                               sysbuf, offset, "%d : %s\n", level,
+                               policy->desc->get_desc(policy, level));
+       }
[Kevin]:

It is better to add 'offset' check to avoid buffer overflow.
After fixes, the patch Series is,

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
+
+       *size =3D offset;
+}
+
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf) {
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       struct smu_dpm_policy *dpm_policy;
+       size_t offset =3D 0;
+       int i;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt =
||
+           !policy_ctxt->policy_mask)
+               return -EOPNOTSUPP;
+
+       if (!sysbuf)
+               return -EINVAL;
+
+       for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+               dpm_policy =3D &policy_ctxt->policies[i];
+               if (!dpm_policy->level_mask || !dpm_policy->desc)
+                       continue;
+               smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
+       }
+
+       return offset;
+}
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+                                        enum pp_pm_policy p_type)
+{
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       int i;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!policy_ctxt)
+               return NULL;
+
+       for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+               if (policy_ctxt->policies[i].policy_type =3D=3D p_type)
+                       return &policy_ctxt->policies[i];
+       }
+
+       return NULL;
+}
+
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+                     int level)
+{
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy *dpm_policy =3D NULL;
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       int ret =3D -EOPNOTSUPP;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt =
||
+           !policy_ctxt->policy_mask)
+               return ret;
+
+       if (level < 0 || level >=3D PP_POLICY_MAX_LEVELS)
+               return -EINVAL;
+
+       dpm_policy =3D smu_get_pm_policy(smu, p_type);
+
+       if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy->set_poli=
cy)
+               return ret;
+
+       if (dpm_policy->current_level =3D=3D level)
+               return 0;
+
+       ret =3D dpm_policy->set_policy(smu, level);
+
+       if (!ret)
+               dpm_policy->current_level =3D level;
+
+       return ret;
+}
+
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
                           enum pp_xgmi_plpd_mode mode)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 0917dec8efe3..ee5b9701038c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -362,6 +362,27 @@ struct smu_table_context {
        void                            *gpu_metrics_table;
 };

+struct smu_context;
+struct smu_dpm_policy;
+
+struct smu_dpm_policy_desc {
+       const char *name;
+       char *(*get_desc)(struct smu_dpm_policy *dpm_policy, int level); };
+
+struct smu_dpm_policy {
+       struct smu_dpm_policy_desc *desc;
+       enum pp_pm_policy policy_type;
+       unsigned long level_mask;
+       int current_level;
+       int (*set_policy)(struct smu_context *ctxt, int level); };
+
+struct smu_dpm_policy_ctxt{
+       struct smu_dpm_policy policies[PP_PM_POLICY_NUM];
+       unsigned long policy_mask;
+};
+
 struct smu_dpm_context {
        uint32_t dpm_context_size;
        void *dpm_context;
@@ -372,6 +393,7 @@ struct smu_dpm_context {
        struct smu_power_state *dpm_request_power_state;
        struct smu_power_state *dpm_current_power_state;
        struct mclock_latency_table *mclk_latency_table;
+       struct smu_dpm_policy_ctxt *dpm_policies;
 };

 struct smu_power_gate {
@@ -1551,6 +1573,11 @@ typedef struct {
        uint32_t                MmHubPadding[8];
 } WifiBandEntryTable_t;

+#define STR_SOC_PSTATE_POLICY "soc_pstate"
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+                                        enum pp_pm_policy p_type);
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !def=
ined(SWSMU_CODE_LAYER_L4)  int smu_get_power_limit(void *handle,
                        uint32_t *limit,
@@ -1598,5 +1625,9 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_devic=
e *adev);  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t=
 size);  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_=
t size);  int smu_send_rma_reason(struct smu_context *smu);
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+                     int level);
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf);
+
 #endif
 #endif
--
2.25.1

