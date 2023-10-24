Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42911C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A733C10E3CB;
	Tue, 24 Oct 2023 14:40:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1554C10E3CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP/mNCxFIryCDX7/A8XbNYMd5U+x/Hbyn/vDLo3aLEPgQjMAPQye+dzUDT7YYw1oEPLksCZjIse8tyO8tYU8a/S4PZ8kEoJiNrJeb2G5EViXp0h7P0lFTHoejDFRMnor9yIU8ri6b0Hx0XDV6MdATzTppkR2pEiGW2E+V7NDuSADXqUz/uxdCB/ftjNQPuDNS/Qen5fRwF5y4R4mX30riv+mWKiU2l1UVTxDIWG3Q3+xCd0OrD8u2g3hesAYZbMa7r8c83kxUjRTBUAsHWKm18V+Oev9ZGashQ0tcFUwn2V/WYPc/4rbKgDWkRRQa0ZqS331FThf/IuNdJ8KYhpp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFCz1aQzcMobHF9rSBZ64X34pN+Pk+qYQTuYbu8zO/s=;
 b=M6i32uoxmLeTSFHEzstTHRlnlfurBJ7N/X0lvxlYxMoNaQckOREsmvXI307/9mZMfUT0AT5JZ5/12NbCXdgZjTbvIMJQADtnAWmGXwLprMbDsZQw6WkYQzGP9z3EjkGOiHFa/WtQFegSwT5ME9ksVEK1RmZl2+tdkInWzCYJUKZvF8jKKzUmspaI4Cfs7UdBD4FhQi/z65LCDxmFzrwnCRF7Gz0bVmkf6GudXXv2wP5Phc7lOTnk32MPvpR2n8EmvSHf1oMCjsdhmRKHVe1y8BqVX054KOa5/thKvCsDp0oCZS/0sybLDAnwUmAhdfT0uSzmW/eaZUsQWYPxUkJCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFCz1aQzcMobHF9rSBZ64X34pN+Pk+qYQTuYbu8zO/s=;
 b=dx498ZDrJYkqA14AwpbigSHXl1fgz99/31weNY1WEq6LebzWaL1PVzTcvrNfic7APCmvB0fzliBrjoD+SjG9Xoyo6f4GejRRlrXtDQb/GxP7PUprObNbF6+eBOzHVpWUgQl+8dvGwqmFJt9+GWNNKyWax03nXy4VK5dpGk3tbBM=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Tue, 24 Oct 2023 14:40:47 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::d257:cea8:6e29:e0a3]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::d257:cea8:6e29:e0a3%5]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 14:40:47 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects
Thread-Topic: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects
Thread-Index: AQHaA2guUjoAlEfGvUyF3+/msCdG9bBXuq+AgAFOdzs=
Date: Tue, 24 Oct 2023 14:40:47 +0000
Message-ID: <DS7PR12MB5933F569451BDCF2E02C9DBAFEDFA@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20231020151422.349394-1-lijo.lazar@amd.com>
 <BYAPR12MB461474F7B4D09C21EF63EE9897D8A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB461474F7B4D09C21EF63EE9897D8A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-23T18:42:25.2551108Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5933:EE_|DM4PR12MB6352:EE_
x-ms-office365-filtering-correlation-id: 9ebaa927-78c5-4980-8fef-08dbd49f35f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMe1ihbE5mQqWBNMTt2ASoiUPHAJY36LS+YsLgCLqN+OmHuGgjsjVLi+LDPFNVmgosZ5CFLWcbvvSC7TWFUtYMwKYINKBz1jI+5DpeFwk00Xlu8UzjE2v4VJuhjNgh4gXliwj4BuVEo7JnTYGPbP6331FRm6wukCPTxeCCNQnE+OHc5VNCrQveSm0YeaB16+UGFP5mDgfqviefq59WuLPvlYODrdAJY2yKlxJN5zj+q9+MCN6eJenXor7UbAXy0fo3NbzCS1n+qGXB9SghRUdAr2WdsJm3gDo3ROOX7TLYgqIRCtPaUhE+L4iIbtRgvqm3K38QJPWjv+qYJjWhZi47oIbyln+Lc3lK5/YG2Maxh814s+GVMkbekgwrFR3JRBKMyDSpIRnSgViepAMnusYNkRUSybtTf/leSD4v+Nfiw+lPQhaMLrHIoQfxPbM+2+BPYIYW8IZMRNtgTiNLS4t1VdSWufjOixxLAKRfdZq3DsMQWiT0bzefVgcLCg/KrbuAT0EzYxaA3CtCBsaMYkhi6vxURdDrc8k0qzwMj12Fxjbet1YfS77DVO9A2Dnka7WOHa/8eFD/jRmogZNqMbj5kmaYXACu5WUwsHwr3NWAgIjIKvPdZndzuUC+cck7lX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38070700009)(55016003)(86362001)(71200400001)(52536014)(8676002)(54906003)(8936002)(76116006)(316002)(66556008)(478600001)(66946007)(110136005)(66476007)(33656002)(66446008)(64756008)(41300700001)(5660300002)(4326008)(122000001)(2906002)(38100700002)(7696005)(6506007)(9686003)(53546011)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/77PpZpvkjGkIdkJzw5o825QiZc6CMtnLF3ONABk5/VmJwGAa7m0ZsA/yBa?=
 =?us-ascii?Q?S88xQ8eNg0OK8xgfx3K/Ouel6i6LrjtLnB3wez2RBTxMUEl8mg53NRWEL313?=
 =?us-ascii?Q?Hmu4K5CRu7yrfNWcmhrg0x1uFd+uicwJ53HXNmU+3+/AJJK3Wf3EYoD9AN7R?=
 =?us-ascii?Q?srxHoc7Jxr2FNB9BiHtUucXFztcLqaDGD1KZo0GXgNtMXMYbiLUAzmoMpiuv?=
 =?us-ascii?Q?IL/drZQw5/5Ke9+XH7KV1ebDH9vCfnL+aix17cv8zpRCo89gpZQbo/Bn8FtS?=
 =?us-ascii?Q?rsR2nJ0rmsrKjxtfNvNEYfzGk2MB8Pnw0h3h8Fpb3brEpXM2tXQZ0CPcIf+o?=
 =?us-ascii?Q?f1SnWzuyMoe9n1ZBPIQgmDsdkrwgJjZFisu7QiVdvY+Ssik5I6J7N/Q68ZeQ?=
 =?us-ascii?Q?I12OQeDdM8Q3pW3s2tC3PH9Hp5s4zJUVbKPl118L0DOTY20yFH3us71ptI8i?=
 =?us-ascii?Q?0Z31LwOWz8prsLHE+EMVLJV/sHDhLbhxiLrqM1ZTz4BUBn1ICyx5jZa41T5l?=
 =?us-ascii?Q?J6JMxrUXx0yzvFG0m698Z+4MaiVvuDYp/dFfWNrWPpEQR1i0fYAouhhIcUQS?=
 =?us-ascii?Q?4lzib/reORQEOI5JuUVFaFkNJLRWcie78LU3hWEqlaf1qCpmQgQiRJU9ArZ+?=
 =?us-ascii?Q?5BED/rUh727+iDADgMJYK+tzPE3s7fTGlCRza+WMqWD1YWUEWI/FfO2+hPgp?=
 =?us-ascii?Q?ljV4qfqb8LchtxDq+CdjbMnimb06G7mO4jyGYErG1njL2ca8uCn25r0irnO0?=
 =?us-ascii?Q?DRd3zSTpxUupI9/CpKWz3TnFNUsfIORzG3FuJooUT+ERlq7aZCcMEcFAUTwN?=
 =?us-ascii?Q?o+f6M2MaCeFEmHV9Bk92nNullWM0SfxalebxkezLBuqQEiDD2EaodyZ5xmMn?=
 =?us-ascii?Q?ckXv1Lra/mIczaqB6fXiaLoN2KnHi15iDKIm+KJW1ffg2JlsPyEBGGfWRyZz?=
 =?us-ascii?Q?eICl9WEdIkT0g7M0jVhLwLiAmC/EKUKkHCTBvuHjDf4/pJRle3qbZ8u3HKiL?=
 =?us-ascii?Q?kt3QjW31UFj3JJ5XOrTxwGxloHDWJg3TAEW27OTPsUksXXMNHNBL/FOccCIg?=
 =?us-ascii?Q?U1t++UfNIhhU+BOzXNSyzuG8CbmgYLTOu6mOVhC+U2yrbhgbQ0SWvc/j0sb0?=
 =?us-ascii?Q?ePL3OjDsEGFi7sTyZfmb1Nk8swZsbxLQXL8u9mkauzD5BazZWftWx0RQSvdE?=
 =?us-ascii?Q?PZYZtw01PCDj2m7wVpmCns9ecrJfi8V0xRxYhghBuQuRzv8dlFlqQ2TNlhBi?=
 =?us-ascii?Q?Of/f28DizO9rz9skdnzc3i+C/WQsKEWRa17iYCnpwBvZa4fuLX1Piq1PiSw+?=
 =?us-ascii?Q?9RPlrFyfZJLTvh/etKH6FtL5TH3Bo1oCJK8Kp3I7n/Mdpge0esgrJkuvOphX?=
 =?us-ascii?Q?1U1S87q6JmnCYrX6BMVi9rcsK08rcwuE+gr+RuqQXzCIaKBNlNztuBsuwjSk?=
 =?us-ascii?Q?ctel2KAMkAOHQ/3xcDvVmZoI0EsH9W90Gx5y7JtRZvqNH3QkHHERJM2bwg/o?=
 =?us-ascii?Q?LJbexmOqYR4NQxbz8aeR3eAVCUZuZYfU6p7QjzKRVG30rRsDjVRf01yc1aN6?=
 =?us-ascii?Q?zQhUEQ6mzPJE7SHG6EczTZrRF6bxQlTUMI3seym72ED7/l3nG8dcmzcqhgjX?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB5933F569451BDCF2E02C9DBAFEDFADS7PR12MB5933namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebaa927-78c5-4980-8fef-08dbd49f35f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 14:40:47.3072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9baEMk1capEBORbYsrJJzm4/ZPxThkqYQJp5iQPqhfWs8L8cABEFHLQMBxW0paI6aaACiPcjSpSqEgtAbErzlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS7PR12MB5933F569451BDCF2E02C9DBAFEDFADS7PR12MB5933namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Looks good to me.
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Regards,
Rajneesh
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, October 23, 2023 2:43:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects


[AMD Official Use Only - General]

<ping>

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Friday, October 20, 2023 8:44:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects

PCI domain/segment information of xccs is available through ACPI DSM
methods. Consider that also while looking for devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++-----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 2bca37044ad0..d62e49758635 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -68,7 +68,7 @@ struct amdgpu_acpi_xcc_info {
 struct amdgpu_acpi_dev_info {
         struct list_head list;
         struct list_head xcc_list;
-       uint16_t bdf;
+       uint32_t sbdf;
         uint16_t supp_xcp_mode;
         uint16_t xcp_mode;
         uint16_t mem_mode;
@@ -927,7 +927,7 @@ static acpi_status amdgpu_acpi_get_node_id(acpi_handle =
handle,
 #endif
 }

-static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u32 sbdf)
 {
         struct amdgpu_acpi_dev_info *acpi_dev;

@@ -935,14 +935,14 @@ static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_d=
ev(u16 bdf)
                 return NULL;

         list_for_each_entry(acpi_dev, &amdgpu_acpi_dev_list, list)
-               if (acpi_dev->bdf =3D=3D bdf)
+               if (acpi_dev->sbdf =3D=3D sbdf)
                         return acpi_dev;

         return NULL;
 }

 static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
-                               struct amdgpu_acpi_xcc_info *xcc_info, u16 =
bdf)
+                               struct amdgpu_acpi_xcc_info *xcc_info, u32 =
sbdf)
 {
         struct amdgpu_acpi_dev_info *tmp;
         union acpi_object *obj;
@@ -955,7 +955,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_=
info **dev_info,

         INIT_LIST_HEAD(&tmp->xcc_list);
         INIT_LIST_HEAD(&tmp->list);
-       tmp->bdf =3D bdf;
+       tmp->sbdf =3D sbdf;

         obj =3D acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_gui=
d, 0,
                                       AMD_XCC_DSM_GET_SUPP_MODE, NULL,
@@ -1007,7 +1007,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,

         DRM_DEBUG_DRIVER(
                 "New dev(%x): Supported xcp mode: %x curr xcp_mode : %x me=
m mode : %x, tmr base: %llx tmr size: %llx  ",
-               tmp->bdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode,
+               tmp->sbdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode=
,
                 tmp->tmr_base, tmp->tmr_size);
         list_add_tail(&tmp->list, &amdgpu_acpi_dev_list);
         *dev_info =3D tmp;
@@ -1023,7 +1023,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,
 }

 static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
-                                   u16 *bdf)
+                                   u32 *sbdf)
 {
         union acpi_object *obj;
         acpi_status status;
@@ -1054,8 +1054,10 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_ac=
pi_xcc_info *xcc_info,
         xcc_info->phy_id =3D (obj->integer.value >> 32) & 0xFF;
         /* xcp node of this xcc [47:40] */
         xcc_info->xcp_node =3D (obj->integer.value >> 40) & 0xFF;
+       /* PF domain of this xcc [31:16] */
+       *sbdf =3D (obj->integer.value) & 0xFFFF0000;
         /* PF bus/dev/fn of this xcc [63:48] */
-       *bdf =3D (obj->integer.value >> 48) & 0xFFFF;
+       *sbdf |=3D (obj->integer.value >> 48) & 0xFFFF;
         ACPI_FREE(obj);
         obj =3D NULL;

@@ -1079,7 +1081,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
         struct acpi_device *acpi_dev;
         char hid[ACPI_ID_LEN];
         int ret, id;
-       u16 bdf;
+       u32 sbdf;

         INIT_LIST_HEAD(&amdgpu_acpi_dev_list);
         xa_init(&numa_info_xa);
@@ -1107,16 +1109,16 @@ static int amdgpu_acpi_enumerate_xcc(void)
                 xcc_info->handle =3D acpi_device_handle(acpi_dev);
                 acpi_dev_put(acpi_dev);

-               ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &bdf);
+               ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &sbdf);
                 if (ret) {
                         kfree(xcc_info);
                         continue;
                 }

-               dev_info =3D amdgpu_acpi_get_dev(bdf);
+               dev_info =3D amdgpu_acpi_get_dev(sbdf);

                 if (!dev_info)
-                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info, b=
df);
+                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info, s=
bdf);

                 if (ret =3D=3D -ENOMEM)
                         return ret;
@@ -1136,13 +1138,14 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device *=
adev, u64 *tmr_offset,
                              u64 *tmr_size)
 {
         struct amdgpu_acpi_dev_info *dev_info;
-       u16 bdf;
+       u32 sbdf;

         if (!tmr_offset || !tmr_size)
                 return -EINVAL;

-       bdf =3D pci_dev_id(adev->pdev);
-       dev_info =3D amdgpu_acpi_get_dev(bdf);
+       sbdf =3D (pci_domain_nr(adev->pdev->bus) << 16);
+       sbdf |=3D pci_dev_id(adev->pdev);
+       dev_info =3D amdgpu_acpi_get_dev(sbdf);
         if (!dev_info)
                 return -ENOENT;

@@ -1157,13 +1160,14 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device *=
adev, int xcc_id,
 {
         struct amdgpu_acpi_dev_info *dev_info;
         struct amdgpu_acpi_xcc_info *xcc_info;
-       u16 bdf;
+       u32 sbdf;

         if (!numa_info)
                 return -EINVAL;

-       bdf =3D pci_dev_id(adev->pdev);
-       dev_info =3D amdgpu_acpi_get_dev(bdf);
+       sbdf =3D (pci_domain_nr(adev->pdev->bus) << 16);
+       sbdf |=3D pci_dev_id(adev->pdev);
+       dev_info =3D amdgpu_acpi_get_dev(sbdf);
         if (!dev_info)
                 return -ENOENT;

--
2.25.1


--_000_DS7PR12MB5933F569451BDCF2E02C9DBAFEDFADS7PR12MB5933namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>Looks good to me.&nbsp;</div>
<div dir=3D"ltr">Reviewed-by: Rajneesh Bhardwaj &lt;rajneesh.bhardwaj@amd.c=
om&gt;</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Regards,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Rajneesh</div>
</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, October 23, 2023 2:43:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;; Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwaj@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects=
</font>
<div>&nbsp;</div>
</div>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"auto">&lt;ping&gt;</div>
<div id=3D"x_ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@a=
md.com&gt;<br>
<b>Sent:</b> Friday, October 20, 2023 8:44:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">PCI domain/segment information of xccs is availa=
ble through ACPI DSM<br>
methods. Consider that also while looking for devices.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++----------=
-<br>
&nbsp;1 file changed, 22 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index 2bca37044ad0..d62e49758635 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -68,7 +68,7 @@ struct amdgpu_acpi_xcc_info {<br>
&nbsp;struct amdgpu_acpi_dev_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head xcc_list;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sbdf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t supp_xcp_mode;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t xcp_mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t mem_mode;<br>
@@ -927,7 +927,7 @@ static acpi_status amdgpu_acpi_get_node_id(acpi_handle =
handle,<br>
&nbsp;#endif<br>
&nbsp;}<br>
&nbsp;<br>
-static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)<br>
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u32 sbdf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *acpi_dev;<br>
&nbsp;<br>
@@ -935,14 +935,14 @@ static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_d=
ev(u16 bdf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(acpi_d=
ev, &amp;amdgpu_acpi_dev_list, list)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (acpi_dev-&gt;bdf =3D=3D bdf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (acpi_dev-&gt;sbdf =3D=3D sbdf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n acpi_dev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_inf=
o,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_xcc_info *xcc_info, u16 =
bdf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_xcc_info *xcc_info, u32 =
sbdf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union acpi_object *obj;<br=
>
@@ -955,7 +955,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_=
info **dev_info,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;tmp-&g=
t;xcc_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;tmp-&g=
t;list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt;bdf =3D bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt;sbdf =3D sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj =3D acpi_evaluate_dsm_=
typed(xcc_info-&gt;handle, &amp;amd_xcc_dsm_guid, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_XCC_DSM_GET_SUPP_MODE, NULL,<br>
@@ -1007,7 +1007,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;New dev(%x): Supported xcp mode: %x curr xcp_mo=
de : %x mem mode : %x, tmr base: %llx tmr size: %llx&nbsp; &quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp-&gt;bdf, tmp-&gt;supp_xcp_mode, tmp-&gt;xcp_mode, tmp-&gt;me=
m_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp-&gt;sbdf, tmp-&gt;supp_xcp_mode, tmp-&gt;xcp_mode, tmp-&gt;m=
em_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp-&gt;tmr_base, tmp-&gt;tmr_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;tmp-&gt=
;list, &amp;amdgpu_acpi_dev_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev_info =3D tmp;<br>
@@ -1023,7 +1023,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_=
info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 *bdf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *sbdf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union acpi_object *obj;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acpi_status status;<br>
@@ -1054,8 +1054,10 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_ac=
pi_xcc_info *xcc_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_info-&gt;phy_id =3D (o=
bj-&gt;integer.value &gt;&gt; 32) &amp; 0xFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* xcp node of this xcc [4=
7:40] */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_info-&gt;xcp_node =3D =
(obj-&gt;integer.value &gt;&gt; 40) &amp; 0xFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PF domain of this xcc [31:16] */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sbdf =3D (obj-&gt;integer.value) &am=
p; 0xFFFF0000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PF bus/dev/fn of this x=
cc [63:48] */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *bdf =3D (obj-&gt;integer.value &gt;&=
gt; 48) &amp; 0xFFFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sbdf |=3D (obj-&gt;integer.value &gt=
;&gt; 48) &amp; 0xFFFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI_FREE(obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj =3D NULL;<br>
&nbsp;<br>
@@ -1079,7 +1081,7 @@ static int amdgpu_acpi_enumerate_xcc(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_device *acpi_d=
ev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char hid[ACPI_ID_LEN];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;amdgpu=
_acpi_dev_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xa_init(&amp;numa_info_xa)=
;<br>
@@ -1107,16 +1109,16 @@ static int amdgpu_acpi_enumerate_xcc(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xcc_info-&gt;handle =3D acpi_device_handle(acpi_dev);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; acpi_dev_put(acpi_dev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &amp;bdf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &amp;sbdf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree=
(xcc_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(bdf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(sbdf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dev_info)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_a=
cpi_dev_init(&amp;dev_info, xcc_info, bdf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_a=
cpi_dev_init(&amp;dev_info, xcc_info, sbdf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -ENOMEM)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1136,13 +1138,14 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device *=
adev, u64 *tmr_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; u64 *tmr_size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *dev_info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tmr_offset || !tmr_si=
ze)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdf =3D pci_dev_id(adev-&gt;pdev);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(bdf)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf =3D (pci_domain_nr(adev-&gt;pdev=
-&gt;bus) &lt;&lt; 16);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf |=3D pci_dev_id(adev-&gt;pdev);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(sbdf=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
@@ -1157,13 +1160,14 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device *=
adev, int xcc_id,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *dev_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_xcc_inf=
o *xcc_info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!numa_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdf =3D pci_dev_id(adev-&gt;pdev);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(bdf)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf =3D (pci_domain_nr(adev-&gt;pdev=
-&gt;bus) &lt;&lt; 16);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf |=3D pci_dev_id(adev-&gt;pdev);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(sbdf=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB5933F569451BDCF2E02C9DBAFEDFADS7PR12MB5933namp_--
