Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CBECD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F5410E4BA;
	Tue, 26 May 2026 07:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g6/F85nR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EE610E4BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMsS0auLTf0qDvtHix604HyOmliO7636ofaWWoAODJuI9LosHK9JHsUiMicQF10aUPK8MLqYbCtWmJ79uFYTGXsN3E9yzCL9/DQ388c4siKPTSmJW51Qb+mXS+xFMhYuxJ9QLDxbREXTLyxQpV6n31uGenZEFh6iIju8IXu3Xnzabnmep/D71Sa6zfrrrMjDTjiabMb4/Jt0mg0gTyfXYttZZt/VVa+iAdYq9t3jHB12sFo3VNbt7cI+QC6JXX5pdgNXm3GeJgFzDA1bO3yNkWziuALKqmpKgKgaMseFfeD8Qq57xKhVCA8QJGj5QNXZ1WSpMo+fHaC9k4UlVwgMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2PS3zszYXHYM/Qcf+PQ8DLzQv8R2cSnaFRJd4L25+Y=;
 b=MO1IuAL1TKT7jMG7RklROlbugKyRx17UEKlieD6C/rxrNMp2Wf3WBy+fLLDuPPnPD5V/XDbGdq2UZcm877jw+hzj+1fMS9jZEWIRa5WV23k3YctKWK0gCQWiPH/STPXX6JIZ90OHPqePrKyjhCro7T66ahmVHG2QblFb317qCWEihrQXFn3yLzAJ0X5+Q/sHOACHr39ElsbI7KKc5e38ejKMcr3SatKsYwH+90gA7lAljqdHpJyuu5kzXg2bQBbUA9WJmBsoK1x74vt3NUxrHPVYQ5LRWaD7gwRBGP4FwxbM25lnuZPSWSfzjgmxQiPBK3aA+0r0Sn1BIZcqLz9j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2PS3zszYXHYM/Qcf+PQ8DLzQv8R2cSnaFRJd4L25+Y=;
 b=g6/F85nRCfsiAUyg+mrr/h5KazwSBRkGw5bjk6/GnJ8S6n5Z+LlNpq+67CobeawNfHqU8QGDwbkZeQuq7BkkuW59rKq0ZvR4jV3VaZkHW7n5XMKbDQ7IRkah2Sw89CEAUaIi6GVlAgdpF0noposHH2WPsE8vyS+LcqL6ZCpWDdI=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 07:09:20 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 07:09:20 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yi, 
 Tony" <Tony.Yi@amd.com>
Subject: RE: [PATCH v5] drm/amdgpu: grow VF RAS bad page table with bounded
 dynamic alloc
Thread-Topic: [PATCH v5] drm/amdgpu: grow VF RAS bad page table with bounded
 dynamic alloc
Thread-Index: AQHc7HmMWgWFjIfvbkeS8BawvBOaJLYf4/VA
Date: Tue, 26 May 2026 07:09:19 +0000
Message-ID: <BN9PR12MB5306BA43DAA6A99CBF37EFCAFC0B2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260508180705.217683-1-Chenglei.Xie@amd.com>
 <20260525190600.2910538-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260525190600.2910538-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-26T07:08:28.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|DS0PR12MB6415:EE_
x-ms-office365-filtering-correlation-id: d3897c7f-cca2-45fd-6ba5-08debaf5b519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|11063799006|4143699003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: y+s21DVpc5MgPXWaU2ytJdBFcCrV78hyz43Xf513KaVZj0Hkzy4l3kl1FaFVG8HulO0mUTQFqGz7nsFSsoEWdwaEjAUz2EouOtSDRaB//Hb+cBYoMGXNcvONgg58HK1ltosC8plD/rzh1uOZYvT8uuFrGYC+VJl8SAKizRkKLfCt5rkj9j7mU4ZnQbSvxyg6mSQeySDKxlWvQdZL4dOPMzoylZv/00W1/zyv+LAODz6Q9WxvtjsMdj0954g4o1ayWdf/ER6AbjLqH1SHHq8qPfNumaPZu8Sr0oJtqJh7ChcYsKK/33u04vXo1YOF9IXLFSNe4g9fhPieWfNjg61EHIvitdhvU3esiDxoce4Stx5ZUQ/0i5b6LJfEVaEsQxu4rtBIpkTG7jvoqqShh/i82tH0R2Iz2VsB1vE49RcEVcuJwSVgVyyomRQ4MeKaObX93HcsgjmfK2R5tCM7TVjGncYyNosA23sI/HxSTk7QDoZqP6nHnOQQ3/ym/MZEV+zIr25dx6HiC3H8TrJMQmDhjU2jSDZ2MnDyNFsyVcO3kvoNmkC9XLqMr7jzGjphoZxVzsfMdFPHIK1jI0Ez31k/yPJJsWspPQ51BgLP2DPoqvugRetieLgLMwEGC8PV25rxRvZx4WDp/FmjXDJRTB3yqv4MYkuSUlcTPNP03V14PF968hff9t8OluZFVpvc2eBSR84DkstNd0wcZh2QlCzACTtwMhA09forxfvZiYf0+vF9l60WoguGBwegoJ5ssCpH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uvnPf+BETnhMzsB0BeTtnmmGY1Pk0UetL9t9OeQhTf7SuAg6hwvFg1OEmoCb?=
 =?us-ascii?Q?5xXZUdXy9sq/nnE6NgMLYkHiQs+u9nrRq1QORC3GF94mdNnWNqGGSv0c+Kgs?=
 =?us-ascii?Q?YQI1EQi/T4fiyPWrK8BUo43JOLGEYIArmc98ryUwEWqi85qTIg2B9JP5urS2?=
 =?us-ascii?Q?GjjFkqHk74jNpcpJyivnLFH0pKkksYafM4xbHAIUsPtmqV4u3YETN6GMTEaW?=
 =?us-ascii?Q?LfbSWRtzjm/g5YGlhBwODCpDeOuqzalARNjTOULLcq/bVc4MD6tf+lJfnzDC?=
 =?us-ascii?Q?RvSU/JQTQmbtCsNpIIu6aP9aY6CHAxOlccB1okTTfn7+NZRjhwBQGMQeejf8?=
 =?us-ascii?Q?MCpcTuE55E+rSyYgWi1qulJJI4TAYPM+prlx9nXHESJAqiELpf60sVKXZJ3C?=
 =?us-ascii?Q?rE+eHFYMHBA9edj9YG8irOVbFeFd1zarOys+up835NUq8YKQYGS0/CJd8fJs?=
 =?us-ascii?Q?suyeFwhIAd6rCJKUQzK24WmEppfJFCGQJNmihFxCxfhXAxRQT9ZVetFI1qQi?=
 =?us-ascii?Q?FVmonryUDnTa4eMlPCLeT7e7lkuUgT3jnM1vyeN1AIkx0HI+46GTL8HYsdV8?=
 =?us-ascii?Q?iNMLM8xghpiJHTmlNQZpKkj3nBYUnlANNwRgMUOa7TlO+l70Y30gBxQq/o46?=
 =?us-ascii?Q?R0Fyj4zPRTMBXftuFnhaTkGbZzlQwCn8brQAL8mg0TkYEvnpAx6H+biZR32S?=
 =?us-ascii?Q?DBI41rd07wh7OywTkl+pAk1Qgj3zhlzgiXyjWtajcUdav+htMGR3iKK7TCWA?=
 =?us-ascii?Q?r3NUI19feF1xzhH6NTFKCp3rZRbfofiI0JHWNIzoG0nCNkw2BihvEs9Ela1A?=
 =?us-ascii?Q?KDXCf0Sl5U5bqs4CrcrCTMF16EzQz7rKLxYl+od7nE+HNfcgHK6LdImFwG4e?=
 =?us-ascii?Q?UqTKh/XqLN1cocOItLLEGIwGPwfP6fI1MIJttDHAQzqxI8CTi4tjfYO1Hpgc?=
 =?us-ascii?Q?mD8U16AVsiDu/UjYde+YoekIGtYFgu6T7HBkCDrAbYNmniqH4Ua2g5sdpkrZ?=
 =?us-ascii?Q?1Q4ZsaJzBar+/KTOqzxSwqEFvsZH2d+hjQOpiBbor9c1luc4+lXxuNSXlnRb?=
 =?us-ascii?Q?TWQM29bxyIMj+d0rOiMXA2llOtsABNukyMK9bsyMcxvw9NoOyT1loZxQ02rq?=
 =?us-ascii?Q?g2nbJVqpOLtlY1Z2vgSwDFb29TtXRMxZOGOdTmL7C8liH9W2i9QmDOuIPgxM?=
 =?us-ascii?Q?gj88CTh+Hie/UeQ0fGAq5ex8LW1XUz1fb+7WXp1IZvaaYm557IElJq/vKYyd?=
 =?us-ascii?Q?JxYq4CQmvYMWPk4U5oFS0Vi5y7YGa7JP/NY3ScPldkoCNVDVOF9azccpmsXs?=
 =?us-ascii?Q?mipkeXLu2eP/HhrUtC/gxGURx5bAuG0Y+250EAgaHY7BOgpDN+sMyVfevX8e?=
 =?us-ascii?Q?EbTV0cs0WmDEMDbylCXiup+/iggPLHXlpObNBXgc2zGk8eG38fYbsnJhxVt+?=
 =?us-ascii?Q?jqFRWsWOF1/gNLU7/+LpLhnWp4QT+deFYh3G9JwDBGhp7f6Kr06AA1fNImVN?=
 =?us-ascii?Q?B0vNrwEsD01VpOcnl21deUDzi2YF+57ci/ma13owMIODY92z/UxBYsF6Y1+l?=
 =?us-ascii?Q?Ddk5DbhwU6SJ5nrHtaS3jNOpcRkdGWFf6gf/FXEr3LPr7fXXlzAhVqK6npGC?=
 =?us-ascii?Q?9rYMCcQwHEb94J4QpAqV58uFfz/WXU4LTNVSkNtbgmFHbe1LJxh3EsILq6zF?=
 =?us-ascii?Q?qDrQsk1NeMKxSVuc6LWOVkoeE84vuUVaErtmLDCAXk2tFeGA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3897c7f-cca2-45fd-6ba5-08debaf5b519
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 07:09:20.0891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+4K1TmbbSmvlvaKUNg4Hm56A2Xrv2e/16LM8027J8ivtoX0H3jEVZwLBYJHSMk6/xXXIpbMRY1cT/W+Fomiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

AMD General

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

Best Regards,
Thomas
-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Tuesday, May 26, 2026 3:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Yi, Tony <Tony.Yi@amd.c=
om>
Subject: [PATCH v5] drm/amdgpu: grow VF RAS bad page table with bounded dyn=
amic alloc

The VF RAS error handler used fixed-size bps[] / bps_bo[] arrays (512 slots=
). When the PF2VF bad-page block listed more entries than fit,
amdgpu_virt_ras_add_bps() could memcpy() past the end of those arrays.

Replace the fixed backing store with a dynamically grown table:
- Add capacity to track allocated slots separately from count.
- Start at 512 slots and realloc bps / bps_bo together when full.
- Refuse growth beyond maximum EEPROM record limit (AMDGPU_VIRT_RAS_BAD_PAG=
E_TABLE_MAX_CAPACITY).
- Return failure from amdgpu_virt_ras_add_bps() and stop processing
  the PF2VF block if allocation fails or the cap is reached.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 111 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |   2 +
 2 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f8e58d12e39ae..7b0d425101611 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,66 @@ unsigned int amd_sriov_msg_checksum(void *obj,
        return ret;
 }

+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY   512
+/* Max bad page slots allowed for SRIOV*/
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY    10665U
+
+/**
+ * amdgpu_virt_ras_realloc_eh_data_space - alloc/realloc VF bad-page
+@data->bps and @data->bps_bo
+ * @adev: amdgpu device
+ * @data: VF RAS error-handler data
+ * @pages: minimum number of new slots to add beyond @data->capacity
+ *
+ * Return: 0 on success, %-ENOMEM on failure.
+ */
+static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *ade=
v,
+               struct amdgpu_virt_ras_err_handler_data *data,
+               int pages)
+{
+       struct eeprom_table_record *new_bps;
+       struct amdgpu_bo **new_bo;
+       unsigned int old_space;
+       unsigned int new_space;
+       unsigned int align_space;
+
+       old_space =3D (unsigned int)data->capacity;
+       new_space =3D old_space + max_t(unsigned int, (unsigned int)pages,
+                                     (unsigned int)AMDGPU_VIRT_RAS_BAD_PAG=
E_TABLE_INIT_CAPACITY);
+       if (new_space < old_space || new_space > AMDGPU_VIRT_RAS_BAD_PAGE_T=
ABLE_MAX_CAPACITY)
+               return -ENOMEM;
+
+       align_space =3D ALIGN(new_space, AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INI=
T_CAPACITY);
+       if (align_space > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY)
+               return -ENOMEM;
+
+       new_bps =3D kmalloc_array(align_space, sizeof(*data->bps), GFP_KERN=
EL);
+       new_bo =3D kcalloc(align_space, sizeof(*data->bps_bo), GFP_KERNEL);
+       if (!new_bps || !new_bo) {
+               kfree(new_bps);
+               kfree(new_bo);
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: failed to grow bad page tab=
le to %u slots\n",
+                                    align_space);
+               return -ENOMEM;
+       }
+
+       memcpy(new_bps, data->bps, data->count * sizeof(*data->bps));
+       memcpy(new_bo, data->bps_bo, data->count * sizeof(*data->bps_bo));
+
+       kfree(data->bps);
+       kfree(data->bps_bo);
+       data->bps =3D new_bps;
+       data->bps_bo =3D new_bo;
+       data->capacity =3D (int)align_space;
+
+       return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *ade=
v)  {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data **data =3D &virt->virt_eh_d=
ata;
-       /* GPU will be marked bad on host if bp count more then 10,
-        * so alloc 512 is enough.
-        */
-       unsigned int align_space =3D 512;
+       unsigned int align_space =3D
+AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
        void *bps =3D NULL;
        struct amdgpu_bo **bps_bo =3D NULL;

@@ -302,12 +354,13 @@ static int amdgpu_virt_init_ras_err_handler_data(stru=
ct amdgpu_device *adev)
        if (!bps)
                goto bps_failure;

-       bps_bo =3D kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP=
_KERNEL);
+       bps_bo =3D kcalloc(align_space, sizeof(*(*data)->bps_bo), GFP_KERNE=
L);
        if (!bps_bo)
                goto bps_bo_failure;

        (*data)->bps =3D bps;
        (*data)->bps_bo =3D bps_bo;
+       (*data)->capacity =3D align_space;
        (*data)->count =3D 0;
        (*data)->last_reserved =3D 0;

@@ -361,17 +414,33 @@ void amdgpu_virt_release_ras_err_handler_data(struct =
amdgpu_device *adev)
        virt->virt_eh_data =3D NULL;
 }

-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-               struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+               const struct eeprom_table_record *bps, int pages)
 {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_dat=
a;
+       int need;

-       if (!data)
-               return;
+       if (!data || pages <=3D 0)
+               return false;
+
+       if (pages > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY - data->cou=
nt) {
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: bad page table at capacity =
(count=3D%d pages=3D%d max=3D%u)\n",
+                                    data->count, pages,
+                                    AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAP=
ACITY);
+               return false;
+       }
+
+       need =3D data->count + pages;
+       if (need > data->capacity &&
+           amdgpu_virt_ras_realloc_eh_data_space(adev, data, need - data->=
capacity))
+               return false;

        memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
        data->count +=3D pages;
+
+       return true;
 }

 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) @@ -44=
3,20 +512,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *=
adev,

        memset(&bp, 0, sizeof(bp));

-       if (bp_block_size) {
-               bp_cnt =3D bp_block_size / sizeof(uint64_t);
-               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
-                       retired_page =3D *(uint64_t *)(vram_usage_va +
-                                       bp_block_offset + bp_idx * sizeof(u=
int64_t));
-                       bp.retired_page =3D retired_page;
+       if (!bp_block_size)
+               return;

-                       if (amdgpu_virt_ras_check_bad_page(adev, retired_pa=
ge))
-                               continue;
+       bp_cnt =3D bp_block_size / sizeof(uint64_t);
+       for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
+               retired_page =3D *(uint64_t *)(vram_usage_va +
+                               bp_block_offset + bp_idx * sizeof(uint64_t)=
);
+               bp.retired_page =3D retired_page;

-                       amdgpu_virt_ras_add_bps(adev, &bp, 1);
+               if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+                       continue;

-                       amdgpu_virt_ras_reserve_bps(adev);
-               }
+               if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+                       break;
+
+               amdgpu_virt_ras_reserve_bps(adev);
        }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index d563deec0916b..d8500c3e48a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -265,6 +265,8 @@ struct amdgpu_virt_ras_err_handler_data {
        struct eeprom_table_record *bps;
        /* point to reserved bo array */
        struct amdgpu_bo **bps_bo;
+       /* number of slots in bps[] / bps_bo[] (always >=3D count) */
+       int capacity;
        /* the count of entries */
        int count;
        /* last reserved entry's index + 1 */
--
2.34.1

