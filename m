Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 11:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169D610E2EE;
	Wed,  1 Jun 2022 11:42:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E1C10E2EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 11:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsxK2RyC1EKnXJhIzNw0rB5jBXni6oA1bg48dGrRbeQTB7nd0xw74TnPTTwA7AiGRXu9X7l5UmteSogFQyJvNEx4OeT8MX20Cr4YlBQyEhpsZnGA70MlU8KKO7dT6Yhbf+RgnMZrsHB8lV4yc1U1Y5RXo+kakvBgxQCDYbOCpi9fKlK6XfySSz+uzB5SM1j+OGAFoEc8U6NPJdG5HsivPUOVOCgdVNbKA7EE75FGYHMqwFyeUgUjmoh4K0WqmKV6lhaaQmhjYwnYSNrira3j8JY6ysQYMI6nInlboq/HR2cI8YfnO5d6fmdRkpya/bfeEWnf1f2bQBawi1U0ohwUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM+z/Us8nrgm1X/f2Q3dtTSyFnffdvFRZLR7Nck9nFs=;
 b=dJvYyB+5smBwlFM67lmwNZHdDD4LAU3F92Nw2cHq5jsybFCcqkhJWh5R+L9aHrQvX1UNQftsNSkGWmRRL2P/cU3CeC4IjPUmyFKFMoZMrMxznYgK0HQT3TLOggZIZVS5NLqSI/u43gSv4So0veRQcQX4sFEXXGuqnT6owOKRvZk/922uYjX4kUEKx0GVhiORkISZ58JZRqWXTQR/5QuY0Y1GEO4pOatwKTIzCBnTWytIb3Ua9zD1b+HfhxMsOX7UciYW1ks9gVuTT5sivKzLs+hNN+2ROL41tAgoS2svNxZlrM1XeQuSKb/cMbvnV/UMKAheEFHzCjCrET1n9nSybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM+z/Us8nrgm1X/f2Q3dtTSyFnffdvFRZLR7Nck9nFs=;
 b=JSWhV8lm39L0oGmHHDfmWCFGXn4lJ+X17Zose8Az7BEMIWvxjKCvYR1qSuTRfTBOpOMwNsp2gE3UGozV++eabKe1z8hNQz+Lm/P1AxxikMNa6rRJMEU1mFGTngDDOwyY0WuQhWVVGVkaPHidoibwuVGDAQbrYw5N6hCtdwYEQFM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 11:42:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%8]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 11:42:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue after cold
 boot on Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue after cold
 boot on Arcturus
Thread-Index: AQHYdZ6V0B7R0cfvWU2OgnV0UwOr+606bibg
Date: Wed, 1 Jun 2022 11:42:53 +0000
Message-ID: <BN9PR12MB52576EBFE09C12F0DE4E4193FCDF9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220601100105.9893-1-candice.li@amd.com>
In-Reply-To: <20220601100105.9893-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d95189f5-c12f-43ce-9310-8764f5901e73;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-01T11:42:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2ec47d0-fcef-4269-4c0c-08da43c3dd54
x-ms-traffictypediagnostic: MN2PR12MB3917:EE_
x-microsoft-antispam-prvs: <MN2PR12MB39175315274B2D98DDEEB1FBFCDF9@MN2PR12MB3917.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fqNuHov6e1feRhihLzsOFTDWUVjEBALz3Yus4kgJlsySOCihPTTeu5PVUbGlQNdnD1JGUHvBEfKx3UoAxHQJ/NgNiWXIrpnsiquCCHOUPzq5n4k476O37JbqTlT7rvqu4cByP3bN3RXsO01P3DGbXM13ZLwknG5RJcIv9gN6c/aenGPe4AapjuScABhVMe4ha043jQWPx/nYrxMb8ZnE1nltC1FLXdh8B00es6f6BKjGiNXOP03eQZ/RDHMDDNNqimtOad479ADmsurEUeRO7p9VjyCkpWtuu671gCItbVUvIr4VmDDzTxhrDYz/6gJAq/ZNDuaC3QuOfIGulVH0bJ9HTv8rkmd57fST1LfWZK3b/SANL5kluX+YqMfTK8llRXS72eMHx0fJOB5V3ogGM+kzs9t8Qjo3XBpRNKeaX6KKOocgRYcyHLThYwFaV8qmjK14r2y91rEppymdXCbqXlsxSpCg23fG2CBluCkNi375emrIfYuQjET/R183JRJ+9vFcv8dpliIeKgx3BmB0bpXwRUlPGTOsRlVLLMxGKTIBjUMnc8gmuaIyAWU+SFLNRDyQqS5ec/LknC/dDTuTufnhlZjku7t/b0R7o1udFHnVNj9QoSPpOl+26InsVqxl/hlXVQlAJWjNiB3qSqPFQVodkSB+M4x5IjOJYWQV5zP3h3ftCXwO6OLVGsQpbOMJ1zHDMCmFVej+rCXK2YUBWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(7696005)(53546011)(6506007)(2906002)(26005)(38100700002)(83380400001)(38070700005)(122000001)(33656002)(55016003)(186003)(8936002)(5660300002)(4326008)(8676002)(76116006)(86362001)(508600001)(66946007)(66446008)(52536014)(64756008)(66476007)(110136005)(66556008)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UrjHqyd8hPcGBaS44bxHaRNjPwy9y4gUsisYfx/QcqYtdZAYQuGYMM7bRw+9?=
 =?us-ascii?Q?FaHoMprnlDVXbNAc03M2xuL0f7ikLhfhyBqCFcC1P9aV0dpEaJIOVpGZaFQa?=
 =?us-ascii?Q?EV78Mx1hlt1xIfLQGs5cao0+I4diw4VTKtXC7/m494iwpcVjMMCWQPc82TUJ?=
 =?us-ascii?Q?yH4MM0z8nWLFfYuvhda4GkdpMAzQ81LBTl64GpE4VLoDrLdUT3jfAAo3WXzS?=
 =?us-ascii?Q?D2MlZnVWU+uP9N2eb+RbcqDtXNGna3O6MaDfaQW/z9FMaJ2ZXOjY7urfgb+B?=
 =?us-ascii?Q?SFDkapUH2XycEMlENBLRIFZmGtHzvduhs6sOx/zYWKSun3Nt0Qd2m/MYCyED?=
 =?us-ascii?Q?sCGFu8AuDmSDIWeu6Y9izR1kgC+oxcbuX0ZcatZOXFNWj2zNnN/deF4gkzrc?=
 =?us-ascii?Q?CuTqhUzMfoHpa1O058HnSaMp4b/7hw4JaUOcVxgsypNySnqm3H33LH+6qC0z?=
 =?us-ascii?Q?Idas20xQyhVGuZCPlSbx4u0WyckB1k5LeZTsoR1g6oQsVUVImUgyPM75fkb5?=
 =?us-ascii?Q?fFiVpC4xZU9//HdDxApzX28AtVU2r77zBeQne3uh+bTV1reClo49q0KVJBDU?=
 =?us-ascii?Q?x/aNJ//mYXcHpfZtD62jZH4/XeK1WDJ9s/NskbSoWRYC/qMOE4RWWZ1jONcy?=
 =?us-ascii?Q?55yjGcn7GY7f6BLFbMB85EpXIP4VbaekzSOyOD1TH5qxSLVIdN4UcZYfFAgS?=
 =?us-ascii?Q?9SGrSAWfvE7z0qWZ0kAiQSpR9nHEW6L61DtlY4m8etIthkhi57VDegn+E3cw?=
 =?us-ascii?Q?CLKTdMWrD80SQbIjRcRrIY3JFYfWLVMeAFOIOFIFHjuIxWCJyWY7OVyTrzRf?=
 =?us-ascii?Q?WbFoCbbrjvg//AzZUziwrVBB9jkNudaUZldRfhxIfUovE9MFJK8lJ2oEVxnX?=
 =?us-ascii?Q?KlsE6bteWex7ZFfe+zilSKSBmbnpRZ7LnfgIbmBrTUFU2vesa5jVYBF0uRLR?=
 =?us-ascii?Q?XfmcOsy+Or5zA+UB+DzL822e47tz58QE1xCyNBrxe4o8keCLln6OpShZa7Qe?=
 =?us-ascii?Q?I9/GI3Q6bMFTrWhYGEsHUoMHGLocVNlqhr4QJQHFdjJGxbrXTcffFIsrDhg5?=
 =?us-ascii?Q?jcJGzj/f8jnMrBo2LReZd8dNyS6ArU2Qpeww1Fd1tPTUbmHKSZt+/8tAeOHh?=
 =?us-ascii?Q?CUtos4+JtHBbYLciFliFhUVDWICRr60HNJGSEgmaGukoXLiIRxXAq7N57RBo?=
 =?us-ascii?Q?UB1qEX85LQLjKGwvsdHXiVVRWA9pDpHmbH+nQxcLPP9uew+suwmX4Yx/yr8p?=
 =?us-ascii?Q?cjBX4j9EI6xMazA/ntLOgBMlFi/Euo7Dge6VNFRiOFJyKgTQJlN9A2M8rrQF?=
 =?us-ascii?Q?yRBb4hK5pmyCfmuEJTcMUYWBh2KasgaRtF1ivT+iug7GNWel/2m6YA3o/Dk9?=
 =?us-ascii?Q?nLsRvW0rTJ+TBrc9i3bvbIJRcDDFssfPkVqTDBUEqz4tKOK2A4g4QDsmiISE?=
 =?us-ascii?Q?Pzl4F/oESDhE0Ps0cCPXQNW/yqD4LQ1UIqZnrqcb8tzzmrH2dBS5sEzWQzN/?=
 =?us-ascii?Q?qOfC1a+5KGV1STm+F5z6bLRf4eND5HAQ8YSdMkOwRs4JMQV1QM4Xv9dQV7gO?=
 =?us-ascii?Q?rMIy5RoCOSCb5DmoCYLM4/UiljAGVCWVn7JR5FT9Ye7EMvtp+4qCX2mp2xJP?=
 =?us-ascii?Q?xsky/MFvDVHcphJ5LJu8y1bnYyjm7jg/E2PIeQaUWQarFt1fL1QWudqymIgQ?=
 =?us-ascii?Q?gj4lhlWsydkJ0zWvlZpg75NN8IPb8u2IOHHEbgsgCckWhb+NWVHWdlqvj6hV?=
 =?us-ascii?Q?+bfpp79Ang=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ec47d0-fcef-4269-4c0c-08da43c3dd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 11:42:53.7007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFLMno6F7+YBJ8h13qxmilSBn7g1aHeuMv4nEmZL/tgNCmiWd3Y3h7ie/NV0+jT841UQF1SRO2/Ny+mT5deUJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, June 1, 2022 18:01
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue after cold b=
oot on Arcturus

Adjust the sequence for ras late init and separate ras reset error status f=
rom query status.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  7 ++++---  drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c | 27 ++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index ede2fa56f6c90d..99c1a2d3dae84d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -594,14 +594,15 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *a=
dev, uint32_t *value)  int amdgpu_gfx_ras_late_init(struct amdgpu_device *a=
dev, struct ras_common_if *ras_block)  {
        int r;
-       r =3D amdgpu_ras_block_late_init(adev, ras_block);
-       if (r)
-               return r;

        if (amdgpu_ras_is_supported(adev, ras_block->block)) {
                if (!amdgpu_persistent_edc_harvesting_supported(adev))
                        amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOC=
K__GFX);

+       r =3D amdgpu_ras_block_late_init(adev, ras_block);
+       if (r)
+               return r;
+
                r =3D amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
                if (r)
                        goto late_fini;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 31207f7eec0291..9c5e05ef8beb0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -197,6 +197,13 @@ static ssize_t amdgpu_ras_debugfs_read(struct file *f,=
 char __user *buf,
        if (amdgpu_ras_query_error_status(obj->adev, &info))
                return -EINVAL;

+       /* Hardware counter will be reset automatically after the query on =
Vega20 and Arcturus */
+       if (obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) &=
&
+           obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) =
{
+               if (amdgpu_ras_reset_error_status(obj->adev, info.head.bloc=
k))
+                       dev_warn(obj->adev->dev, "Failed to reset error cou=
nter and error status");
+       }
+
        s =3D snprintf(val, sizeof(val), "%s: %lu\n%s: %lu\n",
                        "ue", info.ue_count,
                        "ce", info.ce_count);
@@ -550,9 +557,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *de=
v,
        if (amdgpu_ras_query_error_status(obj->adev, &info))
                return -EINVAL;

-       if (obj->adev->asic_type =3D=3D CHIP_ALDEBARAN) {
+       if (obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) &=
&
+           obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) =
{
                if (amdgpu_ras_reset_error_status(obj->adev, info.head.bloc=
k))
-                       DRM_WARN("Failed to reset error counter and error s=
tatus");
+                       dev_warn(obj->adev->dev, "Failed to reset error cou=
nter and error
+status");
        }

        return sysfs_emit(buf, "%s: %lu\n%s: %lu\n", "ue", info.ue_count, @=
@ -1027,9 +1035,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device=
 *adev,
                }
        }

-       if (!amdgpu_persistent_edc_harvesting_supported(adev))
-               amdgpu_ras_reset_error_status(adev, info->head.block);
-
        return 0;
 }

@@ -1149,6 +1154,12 @@ int amdgpu_ras_query_error_count(struct amdgpu_devic=
e *adev,
                if (res)
                        return res;

+               if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2=
) &&
+                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4=
)) {
+                       if (amdgpu_ras_reset_error_status(adev, info.head.b=
lock))
+                               dev_warn(adev->dev, "Failed to reset error =
counter and error status");
+               }
+
                ce +=3D info.ce_count;
                ue +=3D info.ue_count;
        }
@@ -1792,6 +1803,12 @@ static void amdgpu_ras_log_on_err_counter(struct amd=
gpu_device *adev)
                        continue;

                amdgpu_ras_query_error_status(adev, &info);
+
+               if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2=
) &&
+                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4=
)) {
+                       if (amdgpu_ras_reset_error_status(adev, info.head.b=
lock))
+                               dev_warn(adev->dev, "Failed to reset error =
counter and error status");
+               }
        }
 }

--
2.17.1

