Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A32CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 19:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B4610E9D4;
	Wed, 10 Sep 2025 19:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjC/25FW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3D810E9D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCkMf/IDCBbjlINpZgIkNcZZhHbJ/LdG2PWLooIEPcGu0WYAs9qGS2fWNhp5IO9cK5NXJAWQdqFCqD4MSWEMVLL2Q/U8Gr2/aTMdxHUMO/gRhhRtSIFmhZicBreNHxlWhXb7b8zaaGIRRKdJiAwPTM8TDjwUT6FIhstPNaLskOlhxBQD8v8doReZ3/UVmSlLjApi7AOcBNXVEaMvy6TkrxYwaxxQB/+ZxmnWNHdt6A5dJ40rVGWAKRBIaZuD5GddApRIT5bVdECLdvxG9kX4AEV42yxYBJIOHaRKNwRRWOptYNhVaYcpTh9uaHgb56epDoXhqvxJ0sqmVjpmk3nEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQZBGwpJ6lokpSzz5ElAsIAli771sr4uI+PrNrDZP7k=;
 b=a/RN7wl1BYT/6NpxlOc64Gfd3Jo9KObiRdzJH8A01b8SQDul0LuM5gJyKOg4newEGp3dxakRNJZjiJQGq5biwokZMnxPDQM9m/yVrUYaRHg+4HSXQuQuwrhv6pXx5kOCkKXaZ+revEDOTypHCb1IDeJnb6JXw0M00/Fw1t2I46pzusaAL2X+WfKiQn1Ic47NbNzKlMUylFnv4rsMHyy+P+YvWES8cEFbQWXD72ilsMaOaLPMhOBhehGlpy2XBjkbwit0AJh5QGh6f8hmWLgTEp/LsAhPUr+CxsU5dcWWYo6lWzhp7I/HVWwyShIYL4AolcYlhBHpcIbILwJ2hc+uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQZBGwpJ6lokpSzz5ElAsIAli771sr4uI+PrNrDZP7k=;
 b=MjC/25FWXN7HsOlCzCRkBPue4+UkiAy54nbC1V3GfVp0L3qzMnvlgx/Tal79HBJkHqzPQQYNjQy1Eda8qjRlqB1Y9907TQzSTu4KZzUkDZxTMwNSZJeCNg3anREJu9fxTB2KEhPR0dIgWRdl703MDtphjpOeb20xJj4cirWEX3M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:48:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:48:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/pm: Allow to set power cap in vf mode
Thread-Topic: [PATCH 3/3] drm/amd/pm: Allow to set power cap in vf mode
Thread-Index: AQHcHh+kbo7sTv9H6kCSiVdGfRxPHbSM23MA
Date: Wed, 10 Sep 2025 19:48:43 +0000
Message-ID: <BN9PR12MB5257218B6F8E920B02D2F7A6FC0EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250905044301.1947978-1-asad.kamal@amd.com>
 <20250905044301.1947978-3-asad.kamal@amd.com>
In-Reply-To: <20250905044301.1947978-3-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-10T19:48:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8374:EE_
x-ms-office365-filtering-correlation-id: 21d31530-a7f8-43e9-5976-08ddf0a30c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RIvQqsubp1E/qHo+k5U2cBMqMYvPRwmhLwegs0UjPp9QJ7tvIQRda49vEJFp?=
 =?us-ascii?Q?WXlpxH7A+GauuHa0kbnaddM6LOlT2rJ6Hkr13OswSLsPfCvVwpzqswlzDYBh?=
 =?us-ascii?Q?DiowMF8i6MkUSPbqcEtHCJsLTkMoWDXgJUo8ZWcnYiUp4VnQibCKT9G1WRXY?=
 =?us-ascii?Q?C308RBtjaPe+fb4lNGUke8pAo1qoaPk7yCo/7FyM3tcr1f2P8/qEtZXg9WNN?=
 =?us-ascii?Q?ADidk9Fkxzh/1o29tqvmerYqbVQMTiL37xk3poEJFcL0jaoSIqbznRXXWM4u?=
 =?us-ascii?Q?Yhtv2Qeh7Qi4eNv729g5auCRCcXd6bQViYqpiDjhxltB5tZ3tjMryagqy62Y?=
 =?us-ascii?Q?UspBujAzhTi82HVy5TSDSjeWtcqajvhskYH1L+EigvpX4wyWNM5ZC/cKGuQl?=
 =?us-ascii?Q?jKZlYXKZ7wyQjKzbUojscIbYoP3bMOYvH8EFNHs3e62K6It4v04GgeUOV7Xb?=
 =?us-ascii?Q?0QzovrqqqBAqTUjdkU7RPIPRJW4ZHVQd1bTYgMJ8o0kZ/pE9vgmyUrCz6gzI?=
 =?us-ascii?Q?ulCC6DFe7zl95CM1g6evkYlqGbCmZaGhokxxAL1Sc1MeY1XDuT1cGPTYPI5R?=
 =?us-ascii?Q?LAztR85oZdEimg15g0ie6o5MrYV1mHzbGI6qU6fK2N774917wprDI+z436Md?=
 =?us-ascii?Q?uX+GUU1VFdMxrO11yaYYgjBnlrXKfzJ3tAxTKDpy5rvfHUjLMlMn2LAHgIWD?=
 =?us-ascii?Q?wbggUxdf8NHKYrz/87fALtd9mhu4mUspveu0l+PRPOVaD1g8dZmN41DNFkKd?=
 =?us-ascii?Q?LDCn1XO9auqiCF/AGXftMApQ1vf+yih8j5yTWKxThLECMTdpkW+eZuLNDoQC?=
 =?us-ascii?Q?f7ih3YG3Ojj5qs0wXd1Lc4W8P0tlvBiEkWzLgkq9tgg1npDti/7FgTDG6XOr?=
 =?us-ascii?Q?Q8PUr2PAWZXsHrjvNyYlF4KPG6JbqF9T1BJLfKWFtbRRreI0mb2g7jqJTMwM?=
 =?us-ascii?Q?c3Ek9EEI7QUrJYmYOyijNuUQLvE4xyuYs7d5fVDdA8yhxzqquBhoxXILVJtG?=
 =?us-ascii?Q?JwbIa4/di4LXjvYFaBQ+eHUX9sxq7p262fwzPwAckOXDwPLH4/U83K4d6Lrj?=
 =?us-ascii?Q?z48znfd+ImcnIb8lJRDvfKVIzvaq7zZDbMPQINGD2IBmf31ZHte1g8ItTguG?=
 =?us-ascii?Q?efhSgAdNV3vo6GCIEQqUz2KVsMjnq8Vh84QkVvf9YgRQ8JHD8Zhd/ZCiky0Q?=
 =?us-ascii?Q?bmnOhFdd11sbcHthXVYVHhFa0I1Rn5eUp2KobiqJ7U1/sY2aWDYJ5dlsb1UY?=
 =?us-ascii?Q?d4x3/+m9Vu23KV3SF2JD+ta4Vtv5ANAQr+u7V4gpk4WLtl0T82xuY8twq+sv?=
 =?us-ascii?Q?AMyUASnze/v3BEGCUUTmmcQ7L6yLeREv4GGT63gVDLk9ihZDDHxt2/3bkI5h?=
 =?us-ascii?Q?RWWKc1Ksqv0RfGMrcwDt8t3R3lyOgKS6TS7JZZBmCXxHxWQ3U0MWQul2sOYK?=
 =?us-ascii?Q?QvL9ajirszO0G2YCDF5ChJGtEUWUcnqOEWMAXS9YDe3eN/d/pT8V6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wz2GdNjTRx5jRVl3pVidsX17WPWqlnTiUS8bdB38XUThKtr9I+jHrbm+Sz2O?=
 =?us-ascii?Q?Jg5//bEdBeJvFoLXkSwkhRNVyr1S8IOQiky8C+aeiGO4JDQwr5oXLXE1n8C3?=
 =?us-ascii?Q?bqChjGO/jgah/a1n7ASbSoQ6AGYBOuwgRletM5TJ+UvVxk4b0cP5l39W5r6v?=
 =?us-ascii?Q?5lLX8ygAHIGP8XO2Cxc2mnWYl5HcAq9NN66qvRh1KUlLV3qlaPDtUTqxmAue?=
 =?us-ascii?Q?s4sQMrr9Nv3/UmW5LWGKz68LwNqHeFwMrrfZW1wyq5kQoj8pKbGQ4yze7Or3?=
 =?us-ascii?Q?x2Oeeo4BpHIRCTduuqBfu8ocf7koh8t0ZOOv8orm2+NfZmOP6CVpqVHTinkY?=
 =?us-ascii?Q?yrbAOMtjz0ftYdXJRIFp45Gi3/F14z/86gm7C1BFFHU/Sq724ntGhevFcIOz?=
 =?us-ascii?Q?q6r4zNnpKF9Z2gzfN0NwzK4w9EmJjmTG/hFqmbqjyUDwe6M7Lrtd4WE8I4M+?=
 =?us-ascii?Q?MKuUrkDrNpneTNteWxGfkZ7vvd3TCheSznVpiIbs1E9M28T2CK6eXyYUkkbo?=
 =?us-ascii?Q?Y4B8rmqbHeLDkNx68+GyY/Ltun2ACHvpZfhYEnGDu8k3JgaPmvxskkKJSrQv?=
 =?us-ascii?Q?xdwi1kGUSOQfiXIukNaydIncE/w/VUZdIOOH6TSGh2LNfrB5kFEr82kKXXwN?=
 =?us-ascii?Q?0TZFz87JUFts6bHbNQQfv4RcEg0IW2HV9/rSuOKNuViCyKv+R6s8TLuXl2Qy?=
 =?us-ascii?Q?GVb7r5YoOPkCGj7S08Nh+xQheow72b3D0fYLeWsW53tsDIxYWcj+qm+mhvHg?=
 =?us-ascii?Q?acvFeGeSANcvCmU9imFgyRI/l1ogGW/8DjaRxaqTX7WKAmoooIPmcISaXkBT?=
 =?us-ascii?Q?WulcFAZGI0nO5t0usPnnl/uLhz3LqBy+wE4oHsyimRE5XLPiWLEAGhN5QFTi?=
 =?us-ascii?Q?Kg0ms8GJcyFH9vBVKmgBLEuQuDTRwYc9vQOoS2Wwaa+y+4ESVZdZNM9X9lUL?=
 =?us-ascii?Q?J6DrdUl36zKewhfyCR0ph73YpMxI0FjQSwbkZ6WTqI2xiaJQyyxZB24X/0zS?=
 =?us-ascii?Q?IHWAu7LHgyU31voYzqguqpSz+jPym3pNN6PLjifGXpjHVBSYSUWqlw7uK8w4?=
 =?us-ascii?Q?I9V0B+qO6dHAbFrSbwRdGw8vO0QlqpGaKC9S9RLDqYsBwFGKtOQv8edTDzxB?=
 =?us-ascii?Q?d4agoqxvx8P3JoQTmvBdZTr7aZ+VRVvgnS+cBXIn7k+6D0a/OJZv5nl8eGrV?=
 =?us-ascii?Q?CYv771RFr742H0nRnWN6Dlkui5HdYsIjoWfQkVppjWkCkNszJNzJxVRDZZ62?=
 =?us-ascii?Q?F42SSyLBcU179d3Tl4zn+7jQsCv9qtqK0BzVl7Xu8h56glMluxKCR1SVN4rV?=
 =?us-ascii?Q?kGvHUYCmVAAcRILsitl6m42IjENpESCyIqYKXOeiZtm5FFV0EzwC5H+04amF?=
 =?us-ascii?Q?lDI1Bo4NDjh22dgSeCN7fvCDz2PYIVrj9mb+CsDx+Qwt1+Gp1lRFjBm6e37B?=
 =?us-ascii?Q?dJ4qSIJVnPqQSEoTOvAUKYyAwOVqA3ax3DXE4QiD7ImWklvU76oNzglp8W0E?=
 =?us-ascii?Q?RLQ3JTro7wFAB6onV2kZ7c30NH8KhnT4QBX3uc/nCG2FWGdZPNxi6xEwK/Yb?=
 =?us-ascii?Q?bThcK7Z0QYweG9I7UfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d31530-a7f8-43e9-5976-08ddf0a30c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 19:48:43.5193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkPaDqh1kOW4TnkZp/nlGwrZ+oUQQ+kReUMmVCw6y/+MPobjTj2dSY8VSv4zZ6/s5vdG8aQCAKKpCa0+f1zbcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad Kam=
al
Sent: Friday, September 5, 2025 00:43
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Allow to set power cap in vf mode

Allow setting power cap for smu_v13_0_6 in 1vf mode

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5230276628a3..3c1346085c3a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3253,9 +3253,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct devi=
ce *dev,
        int err;
        u32 value;

-       if (amdgpu_sriov_vf(adev))
-               return -EINVAL;
-
        err =3D kstrtou32(buf, 10, &value);
        if (err)
                return err;
@@ -3597,6 +3594,10 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
                        return 0;
        }

+       if (attr =3D=3D &sensor_dev_attr_power1_cap.dev_attr.attr &&
+           amdgpu_virt_cap_is_rw(&adev->virt.virt_caps, AMDGPU_VIRT_CAP_PO=
WER_LIMIT))
+               effective_mode |=3D S_IWUSR;
+
        /* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
        if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
             ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)))=
) && diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index e37b7b5358ea..0acf574930d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -143,7 +143,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(GetMinDpmFreq,                       PPSMC_MSG_GetMinDpmFre=
q,                   1),
        MSG_MAP(GetMaxDpmFreq,                       PPSMC_MSG_GetMaxDpmFre=
q,                   1),
        MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqBy=
Index,               1),
-       MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,=
                     0),
+       MSG_MAP(SetPptLimit,                         PPSMC_MSG_SetPptLimit,=
                     1),
        MSG_MAP(GetPptLimit,                         PPSMC_MSG_GetPptLimit,=
                     1),
        MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverRes=
et,                  SMU_MSG_RAS_PRI | SMU_MSG_NO_PRECHECK),
        MSG_MAP(DramLogSetDramAddrHigh,              PPSMC_MSG_DramLogSetDr=
amAddrHigh,          0),
@@ -413,6 +413,10 @@ static void smu_v13_0_6_init_caps(struct smu_context *=
smu)
                        smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS)=
);

                if (amdgpu_sriov_vf(adev)) {
+                       if (fw_ver >=3D 0x00558200)
+                               amdgpu_virt_attr_set(&adev->virt.virt_caps,
+                                                    AMDGPU_VIRT_CAP_POWER_=
LIMIT,
+                                                    AMDGPU_CAP_ATTR_RW);
                        if ((pgm =3D=3D 0 && fw_ver >=3D 0x00558000) ||
                            (pgm =3D=3D 7 && fw_ver >=3D 0x7551000)) {
                                smu_v13_0_6_cap_set(smu,
--
2.46.0

