Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA0606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b1UjGTpD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3302410E29F;
	Wed, 28 Oct 2026 12:54:09 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A4C10E29F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 12:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXtM217LFoUpCtxMZjLFI8vz/Ub/lllCgkdGeOKp1sqHT7kOOZ2u/IZ5eBWAztGfRBnspiqO6Wr0ZcemdsHSvuDHPV0IHidHdkjtGJDpubGm/WQIdzWAv6kGR+bbcDUgiRSx274DLpJAAPcdBLylZTJfaCaXDYCa3OVpvjj/AeqBNbmga+tx0oJO8kkQUbRlbkqxBJ6qYRrRSD/Uyx2rXXKjLeqwD46P4FuDmnaCoebmHn5QXiy/Eijp/wcUAA4MP+rZeWwNQcal91A/tqEDh3GNMcpknO2hcXhMARQV2DN52VQr62kjwioyz0jtup3DgPwtNyrgbFBzXDuUlCwA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b4VWqipkH6tJ8qT8YGAYZIui7EPb6WvT7yTgX9MzJM=;
 b=GqqghoEnGJGKTzX1xls+Dtzt1eqdKz+kyE8hiuxaMHEwJFisCwwJ2c90Z5hhWFY3wHbX3tMv8Q267Bra+BIVHNWhDCT6SyCbIf5luD2P+Hgg3xNYys1qrZ54nnRryTYWs/bXSFd1vDbdiT0I3J1vVIFICe0/ZVtaWPhgXlhAuObGS7elax0q5WvWWMvLrKaq9h3Y9L3EflKVvmWz6poboDL6pZzCDy70dqPN/OZWE0SH4T2FLp8OSE17FE+xCJLv81Vcvr7ls2L/JpuuGkPcf8CBuviUgFk+KEvomUkxc+raN3IJr0eL48gwrXVLxbruunl9EryOIQY1fbKJjYLu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b4VWqipkH6tJ8qT8YGAYZIui7EPb6WvT7yTgX9MzJM=;
 b=b1UjGTpDkpXnJhU3u3INBypwskRiGiszyXscVyyl2IkrjwhYi0S330MJ5jY/kvcE2/b+RUQUYXvm1mXW6RAunnxECyC/QEnVyV96WnLEPF2Ldd906EKmIvpd+iSLQXBT7oBpGDoZrnzWf1CUYM+zCXLyLwlDi4Vk/XempGDAGE8=
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:53:59 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 12:53:59 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
Thread-Topic: [RFC 02/10] drm/amdgpu: add device-wide PMC config
Thread-Index: AQHdSnWOzQ8tY02uoU6dqomSUALSC7bcNl2AgADc/ICAAIrIAIAVwGAAgB/BZ9w=
Date: Wed, 28 Oct 2026 12:53:59 +0000
Message-ID: <DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
 <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
 <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
 <c96bc906-c6aa-479b-84d6-75ec1816e853@amd.com>
In-Reply-To: <c96bc906-c6aa-479b-84d6-75ec1816e853@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T12:53:58.820Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|SJ0PR12MB8167:EE_
x-ms-office365-filtering-correlation-id: a3acd00b-752d-4183-68e2-08df34f288ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|10067099003|261021121427099003|261009223027099003|11063799006|22082099003|261026121527099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: 1NfIoi1/k4ZxzmV+OXx7thVyLhn/5Uv1E+QEroVWlMno+n2S3o2bAwxj5nMsY3GCKa6LevUrt7/5mnG5Z9TSncqikFL9xkVabG4yHHNB8dTLIR5yJMXZav37u5+xGpINZrwgaevIdtIOVDtd2ZI2IPcu1UgxwjecfSKoAvbAjUDYmaB4zZUx8tSS4AZ6PEAdUr01+8kVtubyUFhIabGWPrJfXwqZk8v8xl1jWDlqiuO0evrDQ7AOFh4BozBXOInb2bqvTLTyH2ZzvUaCtdfrnFR6lj+BPE7fcIIe/umYZD+ZW+QSSo7wWTenLsFKWh4OGLXNUVGdk1W9GP6IDB+ORnUqV1HklIR7JeCTgAo2whO5DfjqDoQYLSqHlTNqgYf94zCsfLZasQTaxIeDl5uNfazQUQL0Qcm1Zj3m7ujtVCm7hViYVLB7uvwBpOzBTYPpg7apTstm5SjOySth6L0NbagXp+DPTPldNcA5JZU3jutHrCuGwJKBOQyQ9DyAF8QxaxJSHVrHRZsPlmC2BH0oIbjmIR6+NbGb3dhD7IMVZEXjrqWG1N1chEm6rrXAxz0iYhM0I5uMJiKfoXFpPPlxuU3NLxk+D2XTF/nrY30bCe1HQyOWN7sFPL9eavLBKJTPyt47zipr2YYyxMvY96VaZrT10mJ3+jT3ctQFQ+OdoOYX4A3nAeIKt7tetdT/JKFbbGGIoB9ZydHd84zNMh/XghArldOaDMqfkdpKqIYWZOA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(10067099003)(261021121427099003)(261009223027099003)(11063799006)(22082099003)(261026121527099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IB9YzbSrl2EBq3H6AySZGfEdBVh3Admd2W0fjUc//dKT3+fJMSmNK3Dt9mZ0?=
 =?us-ascii?Q?tUuPZn5HAy2+SnmJjxaERbvnwqOhXO+8zoA62WJ4JQSRbzrWNGUSuVY1vQLq?=
 =?us-ascii?Q?EbzQmlusp73FSCZFfWGhd0OWS91Ynx0Mg+KC1Svnw19Lvd/JTZzVUZAhMUOT?=
 =?us-ascii?Q?Jq63VPBZRkB8+gyKADwjyYHZnmM9WCzqf37mvdxnkhUVGqxPUet8fjQ4LZ7H?=
 =?us-ascii?Q?9r8MLOG7mkD/iFxlabgMbuWjuNj5R0hqsfCzzIVCNcju0DsUOGKzSypBMcrU?=
 =?us-ascii?Q?j9pkZoIzG+dJTZSDh9Rk1a8nQ76CQ/XjxjuAA1W/2C6zTmFIHOsea9uLEKFj?=
 =?us-ascii?Q?M93hZmi5PCrN6SMztmdSEzmqse97WwsevsxTAOODDoHC0PViTgy2chQPZzMA?=
 =?us-ascii?Q?PEvoGUE5NMPv13f2mD09IjijY45LdOaHdI5lv8YY3dKAxCTEYRP7Da8VpT6w?=
 =?us-ascii?Q?30OxIO9C5+GlcI2/HqQ1zYKlTmR4Ut6fskU/bUIccxQjnLna/FR3QfA7T+Bt?=
 =?us-ascii?Q?fFBwqTuDEnXCygKh79v2KQ4eJYdzTL1aM2mEAQKKKbTCNSwFP8QEMDp7uqKa?=
 =?us-ascii?Q?4p8NsMAiYiNpZA2GdLVGotsVbC/HCuxnir2mGycFtCCtTz8IMaAFSauAil9I?=
 =?us-ascii?Q?ORtgDJb7pSSCbaE42dnP3Ta+8jKda7qwPW9NOHwUNzvmxY3Fz1+DKRrdFQEB?=
 =?us-ascii?Q?0G0wWiSuzbzwuS+/p4m7fuqCjXxtg7H/oCuLGkxjdvFceytPJlawnFc/x7Py?=
 =?us-ascii?Q?/xojG5vTWA8vDZJd8j/JK045IRCYZbPXcWPIZpj0OgezkP8gB+zqKTeZks3g?=
 =?us-ascii?Q?rx4KcsMw9rFKvNXl3ycW5E2TboLbmzjeB5uCPMTFLZZZ2DinZ3bi7SzTnG69?=
 =?us-ascii?Q?PFfItkGSU/9iYS7vGoDs8the9UNbkSm1owEbIb26BaZ50nzJBM4fjC4qSKuD?=
 =?us-ascii?Q?H8REpYEJhbAqdDjg6W6ViBp5VEtPNCKkCIbSLAFbi+dX9Miz7nxubTv8djUO?=
 =?us-ascii?Q?B9oZTgLdZc3DqiG4xDoo1MXCQZvQRt50r8c4I6N2WoA2FOMHD8k7wNdcoEt/?=
 =?us-ascii?Q?C06WSaPoSjpRdIAi2bqz80Rd9e8GYws8fwoaxBLmyPL8EFC/VM3mjPVyJsoH?=
 =?us-ascii?Q?E1my4Oj/v0EWkHFHhrZla9hN28KZQ2UYd55LGU6owZ2pI4AEteCp1JuPRask?=
 =?us-ascii?Q?chPUoCjpnyGvOmEp89RsfKYjx2uxIWwacJ4mRNs3nVD0Z91wMpQqdCYfFmyH?=
 =?us-ascii?Q?Aqg3nsXAqfUN+/TAbs8ZGQz7Idkc7t6l+ZL1COwdETw12yjh5dI4/iDJhL34?=
 =?us-ascii?Q?vhZSgPJwyuv6ERr3nUMUolSWS+tf4qb+butCoVL4CsVv8OyaU1Bmy2Br2lwW?=
 =?us-ascii?Q?4KDmtKNCFNIKwvp9ltEo9Ufz+9h7GDxwbHq4gZgZTh9i/vu5I5in+QxV0KxE?=
 =?us-ascii?Q?gv/pByOffZ35k+M6o9cWMidCoc+hOvoBz8z9MPDofHgptTfpvMeJA3lewN/n?=
 =?us-ascii?Q?uc1DiYyCGdMBBL32w5lBWJSI4752RFNbuYlKa7gvTn9ylr0cfV19tFARn+N+?=
 =?us-ascii?Q?J59XiDCAaok9AoEgcBn8MzHV/WqCAxdhqrbRmly9lXhu1Km7G3GUnf6WDxVO?=
 =?us-ascii?Q?Z1gX3qS+3AYenTTJL3TYJny3eLHq9l6bjDYkqDGETn1hpE2vTiPNHj0X6N47?=
 =?us-ascii?Q?sRULqfNvoGatYUACivEQc54VwGOqzfVMq9rw8R7SBWlivXUn?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB85589778D67BE6864EA41355E46F2DM4PR12MB8558namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3acd00b-752d-4183-68e2-08df34f288ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 12:53:59.3717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/CIpwbxLemVbs4rEPx4EFugmSe+9KYdbt9td6s1UkdjI35RA9QMacWLSqyJ279F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DM4PR12MB85589778D67BE6864EA41355E46F2DM4PR12MB8558namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi, Lingshan,

Sorry to reply later! Just be back from vacation.

Yes, there is only one set of PMC registers on the device.
But the minimum control scope is XCC. So, I think we should design PMC base=
d on
Node instead of device. We need not enable the PMC on XCCs which have no PM=
C data collection request.
Since the request is based on render node.

Thanks & Best Regards!

James Zhu

________________________________
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Thursday, October 8, 2026 3:50 AM
To: Zhu, James <James.Zhu@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config


On 9/24/2026 11:40 PM, James Zhu wrote:

On 2026-09-23 23:23, Zhu, Lingshan wrote:
On 9/23/2026 10:13 PM, James Zhu wrote:

On 2026-09-22 05:34, Zhu Lingshan wrote:
This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.
[JZ] I think it should be render-node wide, not device-wide
Hi James,

It could be, but we don't have a requirement document defines the scope.

But normally a profiler is a device scope,
I see KFD profiler operates on all queues under the device queue manager

[JZ] One device could be split into multiple nodes with different processes=
 running.

I am wondering if this is really we want.  Ben may comment on it.

Hello James,

Sorry for the late reply, it was mid-autumn festival and national holidays.

In my understanding, there is only one set of PMC registers on the device, =
so it should
be device scope.

Thanks
Lingshan


Thanks
Lingshan

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com><mailto:lingshan.zhu@amd.=
com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
  2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 8eff6b9ebe81..45897dca802f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
      AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER =3D 3,
  };
  +struct amdgpu_pmc_profiler {
+    struct mutex        lock;
+    struct drm_file        *owner;
+    bool            enable;
+};
+
  struct amdgpu_device {
      struct device            *dev;
      struct pci_dev            *pdev;
@@ -818,6 +824,8 @@ struct amdgpu_device {
       */
      struct xarray userq_doorbell_xa;
  +    struct amdgpu_pmc_profiler    pmc_profiler;
+
      /* df */
      struct amdgpu_df                df;
  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
index c924a55fd16f..74ed42e53264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
      mutex_init(&adev->pm.stable_pstate_ctx_lock);
      mutex_init(&adev->benchmark_mutex);
      mutex_init(&adev->gfx.reset_sem_mutex);
+    mutex_init(&adev->pmc_profiler.lock);
        /* Associate locks with lockdep classes for ordering validation */
      amdgpu_lockdep_set_class(adev);
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)
      kfree(adev->pci_state);
      kfree(adev->pcie_reset_ctx.swds_pcistate);
      kfree(adev->pcie_reset_ctx.swus_pcistate);
+
+    mutex_destroy(&adev->pmc_profiler.lock);
  }
    /**

--_000_DM4PR12MB85589778D67BE6864EA41355E46F2DM4PR12MB8558namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi, Lingshan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry to reply later! Just be back from vacation.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Yes, there is only one set of PMC registers on the device.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
But the minimum control scope is XCC. So, I think we should design PMC base=
d on&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Node instead of device. We need not enable the PMC on XCCs which have no PM=
C data collection request.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Since the request is based on render node.</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Best Regards! </div>
<div id=3D"divtagdefaultwrapper" class=3D"elementToProof">
<p class=3D"elementToProof" style=3D"direction: ltr; margin-top: 1em; margi=
n-bottom: 1em;">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">James Zhu<br>
</span></p>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Lingshan &lt;Lin=
gshan.Zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 8, 2026 3:50 AM<br>
<b>To:</b> Zhu, James &lt;James.Zhu@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<=
br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config</fon=
t>
<div>&nbsp;</div>
</div>
<div>
<pre>On 9/24/2026 11:40 PM, James Zhu wrote:</pre>
<blockquote type=3D"cite"><br>
On 2026-09-23 23:23, Zhu, Lingshan wrote: <br>
<blockquote type=3D"cite">On 9/23/2026 10:13 PM, James Zhu wrote: <br>
<blockquote type=3D"cite"><br>
On 2026-09-22 05:34, Zhu Lingshan wrote: <br>
<blockquote type=3D"cite">This commit implements a device-wide PMC config <=
br>
for amdgpu, which including the profiling owner, <br>
and the profiling enablement indicator. <br>
</blockquote>
[JZ] I think it should be render-node wide, not device-wide <br>
</blockquote>
Hi James, <br>
<br>
It could be, but we don't have a requirement document defines the scope. <b=
r>
<br>
But normally a profiler is a device scope, <br>
I see KFD profiler operates on all queues under the device queue manager <b=
r>
</blockquote>
<br>
[JZ] One device could be split into multiple nodes with different processes=
 running.
<br>
<br>
I am wondering if this is really we want.&nbsp; Ben may comment on it. <br>
</blockquote>
<pre>Hello James,

Sorry for the late reply, it was mid-autumn festival and national holidays.

In my understanding, there is only one set of PMC registers on the device, =
so it should
be device scope.

Thanks
Lingshan</pre>
<blockquote type=3D"cite"><br>
<blockquote type=3D"cite"><br>
Thanks <br>
Lingshan <br>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><br>
Signed-off-by: Zhu Lingshan <a class=3D"x_moz-txt-link-rfc2396E" href=3D"ma=
ilto:lingshan.zhu@amd.com">
&lt;lingshan.zhu@amd.com&gt;</a> <br>
--- <br>
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; | 8 ++++++++ <br>
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++ <br>
&nbsp; 2 files changed, 11 insertions(+) <br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
<br>
index 8eff6b9ebe81..45897dca802f 100644 <br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
@@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER =
=3D 3, <br>
&nbsp; }; <br>
&nbsp; +struct amdgpu_pmc_profiler { <br>
+&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lock; <br>
+&nbsp;&nbsp;&nbsp; struct drm_file&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; *owner; <br>
+&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enable; <br>
+}; <br>
+ <br>
&nbsp; struct amdgpu_device { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev; <br>
@@ -818,6 +824,8 @@ struct amdgpu_device { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xarray userq_doorbell_xa; <br>
&nbsp; +&nbsp;&nbsp;&nbsp; struct amdgpu_pmc_profiler&nbsp;&nbsp;&nbsp; pmc=
_profiler; <br>
+ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* df */ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_df&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; df; <br>
&nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c
<br>
index c924a55fd16f..74ed42e53264 100644 <br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev, <b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pm.stable_pstate_ct=
x_lock); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;benchmark_mutex); <=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex=
); <br>
+&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pmc_profiler.lock); <br>
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Associate locks with lockdep class=
es for ordering validation */ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_lockdep_set_class(adev); <br>
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pcistate)=
; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pcistate)=
; <br>
+ <br>
+&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&gt;pmc_profiler.lock); <br>
&nbsp; } <br>
&nbsp; &nbsp; /** <br>
</blockquote>
</blockquote>
</blockquote>
</blockquote>
</div>
</body>
</html>

--_000_DM4PR12MB85589778D67BE6864EA41355E46F2DM4PR12MB8558namp_--
