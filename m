Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22211C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 19:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A745B10E46D;
	Wed, 17 May 2023 19:39:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F86F10E46D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 19:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYwDNIubzrXbN4/aD31fJIt5C8ZYhlBMbMM4tGb21syTeiZLOEHQ2hoYa2XR5xoey/BuoeOURnT1hE9MYBR6I1rW6KVvUsaPNuCcoM0wYNNWBF3hCkROlnI2iGyR1vEu5e3Otn6BRqw8wdUgSnx07vmaFEvBJ7ZwhAq+PsSOAM/7UwqLr9gxxy0HJTiKsrxZINzLi5RLnIRpfK9KBE7j5LtTQNZUxFIXnaSUNXEdA9u2H141PuTBZCXOeUCa9RZhnKGhPYVS00gI7ftNFS8l8LOoXnUTlf0ArbvSehcA+5LAVDbZU2Q2kZiEXh5D64vPqzHoEpmOHiV0POtb0fQz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB9Myc0oerRvFczXN5IO8kuOKyYcMBc6n7y+xwVmnzM=;
 b=cG4Oa6AEBMPzTu2Eby2TqwtMnQX0pC6xL6vxP3PwcyWGFjCI4xQS7s7e8zyNFL0pR92eb5b4Fc8YrRDxLZB6Ik2KbK/hW6qdZ+qg046xOLt0d9q+1M9wk3UqfBb7d74W7MKU+PxaR6xqUEJp1p8+1SF70KMRkQX9ZPCU9C5+7J1Bq7MG6w7Tija2IEvA9esUDDP/hoM7y6awDXPHMqzMNtnw8RXbC560d1Ki+0NLajOyn0BvEyJHOkvl5tzjLPJyOoxfYqlut2DAA6RSZBgTVD07M2oCcEL6ZVqShiV9nBsqXqP6GcrpKhvAm+58dg22xPgiHVJcQYCJnU6iI4NxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB9Myc0oerRvFczXN5IO8kuOKyYcMBc6n7y+xwVmnzM=;
 b=xLTZz69qzcQBRDKKFmf/FRwDXddhoPhjb7UDIHIJy9SekY8k0MlCMtqTbzszIya6bZvT2ISN9bB/NCmDQM0UcwSMe8Wzx7h0XMm9fuZIDDz/xGi7EgpxFzxAvRyrdPr4njMfCnxSB+tJJZjrPd2woOPFf9PBKbPen+5v6bIUEc4=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 19:39:09 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7ca6:a548:58f8:e0c0]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7ca6:a548:58f8:e0c0%2]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 19:39:09 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Thread-Topic: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Thread-Index: AQHZiO8tMS2Xzn20dku3ndXVbBdWBa9e3JeS
Date: Wed, 17 May 2023 19:39:09 +0000
Message-ID: <BL3PR12MB6425F9ACFE16956119B553CCEE7E9@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230517184052.165772-1-alexander.deucher@amd.com>
In-Reply-To: <20230517184052.165772-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T19:39:09.510Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: 6971e571-247f-4a80-f763-08db570e6292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1FgqYwyFBKHyDDlw0O5D5sA1WE3K7VyfVl8shL6TeJwyjqFf9/4uny+8IM6R6owme4MjUR4xMcdbOvkJ/oHF34GD3GC3VSF4MRjKrn16wWobXQCEndsycGPgyWa0OtNz2aw2Msi7PfzADYZP3iLa3yLD0s/AqYPXoS7sC82LzvN9bO4F68a7HgQcZfMezdgrgti21R5vq+UQQIEy03+dgti1hjP24B2hzTM0TiYL1WlqXT4v6GJMvka8jubzYv6w4aiut1aBDhnB8CXWSQCPiHFJVXq/KPWs2k8aiXLIXxZVHgTCOelMPmoc+dcYrl/rjScjbG1nOpeBMdB9EQreFH7KlwTldxvIiF4HvW4yHP88YeyilXY4ne0uj1+wSoZEskk027xTKNk/kkWuHTqHL7dwsW7WMm0LHHH8VN6ofu9l4quFA73A5iT6gRqyXWr/QbCgSWyKqEKiysGBsjCtogsJ7gtgn+8z+vsySQManC6O/bTjRbCOVghC/Qe/1Cfp/TGXzFnErouVONGoSTvg9DuNveCuOH3MnrIIGa7YAxy7cs+Zwv58f/r9f/+cJVrrK+Q5UPPduLChoUeljd02hBXDbVPOBbKv1XCXKZBP+SXcZssqoMxRfbplisPUX2c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(55016003)(66946007)(2906002)(7696005)(83380400001)(91956017)(66446008)(66476007)(66556008)(64756008)(76116006)(4326008)(110136005)(478600001)(9686003)(52536014)(8676002)(53546011)(8936002)(26005)(41300700001)(6506007)(5660300002)(316002)(71200400001)(186003)(38070700005)(122000001)(38100700002)(86362001)(33656002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?plQFG8GqlS5aR1fQ0rEsqPMnnYi2641ijjM+XEyO7Kvj5STNDQxdXbcTzdYI?=
 =?us-ascii?Q?xnSuBLr61Eexezr4YWHRnDT4DfqGgeVxG9biKd0dD0wODGfbBv2NIa+G4Efs?=
 =?us-ascii?Q?RiBRhl0/ino1DDJZlfWHkdQDqwk2Pf7TyHD3BuHuJaQanvbSRlfX4GWGAzvS?=
 =?us-ascii?Q?a4DbngahUbW7Bp/nrGXvwI0k7+7gufuq+8dAGngbZ++y2cH02igFcRqOI1lG?=
 =?us-ascii?Q?pyIpP8f9Ueaw16Syq6Tri8Iqs83A6VQdFKQlhsPrF6rJgFNX/lUdPKP5XaU4?=
 =?us-ascii?Q?qTJBuxwULeeBWBW1DjfPn/yUHj9bjDyKDDR3aLOiO1nxeIStpvbPTepSisQV?=
 =?us-ascii?Q?+Ud8U0Jrb4A/WGFrmRKlcmHFLwVYqt8sgvP47/77NSnJCD9B7Qf21vxy89DV?=
 =?us-ascii?Q?uRq66b4iU7ITmmgIO+sAnsE7VOG5+NZq3H1JexTHp4mEiMhJ1kcImFvjVRAY?=
 =?us-ascii?Q?B8qtXUgR2MfuWBNJnfNMhiAhu64f23fm7FOJuHDIr+F1X+vKvaDpbrcN2e0o?=
 =?us-ascii?Q?IsQSfdQXPR5Ph7UbIM8vxD0kklnLwZrnPUdO3DBgSQ3AYAqiIlUUJ7Yy87IY?=
 =?us-ascii?Q?GEFNnqFCJNaIuUqYXfq6hNSIOmRA8bt0LCRwvlq7Vj84UhhVPGGg0ob64+cb?=
 =?us-ascii?Q?+kGMjMJjJ8VKs6W45Fhd4yiMUI/+6t8g4xBMBlcLpRH8PhJDQSQgFzgW3gBh?=
 =?us-ascii?Q?OG4XUAncTtNRxtbs7zNY7lLpJwO+fqLFSz7NvOGcUn05908sunyz/PZDEWxN?=
 =?us-ascii?Q?IIY6vJUc9Rb4imj5lc3IRsU1gM3pBhyHBeAazH7MBcRBniyCXwazNkr5xjz9?=
 =?us-ascii?Q?H/2MSFuaiujsC2/bJLl+hgnjwPchzmQ75Dke6DMXQKaLQrBnNN6uh8ADpl1c?=
 =?us-ascii?Q?/wwEOpweKyFNHUJQjXd5XD6/Bb4Lkzmce7z8P1rW4QLaNYLEnbB15xKVWE4h?=
 =?us-ascii?Q?1egtp9lavcVoo83pqJ9kFfQbC2nZnfZwYCxOHQsRJERpV8b6fkHEQ0M1hklT?=
 =?us-ascii?Q?tBUNm2CdNAEnGQyYN1OGJJkJ15GdfP82lCVr/agq+PZZpXmKz7+ZLo+h5HVf?=
 =?us-ascii?Q?klY3CSv8fOdw7MoFmdzCJOaBha/Ben9R5glSgY0bTv163KZwfHj7IxQJI2ng?=
 =?us-ascii?Q?k5G5DeTsei6nrm5hgUVc9GBCWKAWKSyHvCbz7Muf1CM3OHU7JYi2hlF6tiMa?=
 =?us-ascii?Q?COD8T5EYXo1h3cI5lnIg3NsnX1aOcYoUeRgO2t2p7EbV6NZBr/ZurlSKBpuY?=
 =?us-ascii?Q?qYVlwf5zJrbNOBykE3Ze2ys2BDNO/W7yU3LZyIcBz4yDD0FEMZEIh3v/pKQp?=
 =?us-ascii?Q?BS1WWth21+SS61iaLjNQ3xBKVo0fVepPFLeIe+OmED1aodIiTOdrYBZ/mwDW?=
 =?us-ascii?Q?HKDWOhah/vWYc0jQU5V6r8xrIVOWf9xkJa2LohKXvezj3myDnS9VgEt5IKYx?=
 =?us-ascii?Q?YUZj28MnI2fbIJcvdd2uw+iLo2aXbApV0Cjx2xWusGlaZXGW45ykgBhkqEg7?=
 =?us-ascii?Q?osB9uvUNYaRRCIUENEvhIQcyiaCiKDgqMsU5f15VQePkiXGhE8Ifk7DHQDB3?=
 =?us-ascii?Q?O/4+d3AUgXCuosgrT9M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL3PR12MB6425F9ACFE16956119B553CCEE7E9BL3PR12MB6425namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6971e571-247f-4a80-f763-08db570e6292
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 19:39:09.7462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzi4rAC6cdgb/f79mrqI3giMqdzz8Qfng1dVKRa2jgG2jmxHuv3ossUaHa06q3i5B2R9k3k18ij2Obsy+Yr0nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL3PR12MB6425F9ACFE16956119B553CCEE7E9BL3PR12MB6425namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Wednesday, May 17, 2023 2:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Jos=
hi@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Rework logic or use do_div() to avoid problems on 32 bit.

v2: add a missing case for XCP macro
v3: fix out of bounds array access
v4: fix xcp handling harder

Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com> (v3)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  8 ++++++--
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 739eb7c0d133..5de92c9ab18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -794,3 +794,18 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *ad=
ev)
 {
        kgd2kfd_unlock_kfd();
 }
+
+
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
+{
+       u64 tmp;
+       s8 mem_id =3D KFD_XCP_MEM_ID(adev, xcp_id);
+
+       if (adev->gmc.num_mem_partitions && xcp_id >=3D 0 && mem_id >=3D 0)=
 {
+               tmp =3D adev->gmc.mem_partitions[mem_id].size;
+               do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+               return tmp;
+       } else {
+               return adev->gmc.real_vram_size;
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index be43d71ba7ef..94cc456761e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_dev=
ice *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
                uint64_t size, u32 alloc_flag, int8_t xcp_id);

+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
+
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
                ((adev)->xcp_mgr && (xcp_id) >=3D 0 ?\
                (adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)

-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
-               ((adev)->gmc.num_mem_partitions && (xcp_id) >=3D 0 ?\
-               (adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))=
].size /\
-               (adev)->xcp_mgr->num_xcp_per_mem_partition :\
-               (adev)->gmc.real_vram_size)
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((a=
dev), (xcp_id))
+

 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index ad664ef640ff..34724b771ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdg=
pu_device *adev,
        struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
        uint64_t total_pages =3D ttm->num_pages;
        int num_xcc =3D max(1U, adev->gfx.num_xcc_per_xcp);
-       uint64_t page_idx, pages_per_xcc =3D total_pages / num_xcc;
+       uint64_t page_idx, pages_per_xcc;
        int i;
        uint64_t ctrl_flags =3D (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
                        AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);

+       pages_per_xcc =3D total_pages;
+       do_div(pages_per_xcc, num_xcc);
+
        for (i =3D 0, page_idx =3D 0; i < num_xcc; i++, page_idx +=3D pages=
_per_xcc) {
                /* MQD page: use default flags */
                amdgpu_gart_bind(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 938c8dba9057..d559e7bc0f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *=
adev,
        adev->gmc.num_mem_partitions =3D num_ranges;

        /* If there is only partition, don't use entire size */
-       if (adev->gmc.num_mem_partitions =3D=3D 1)
-               mem_ranges[0].size =3D
-                       (mem_ranges[0].size * (mem_groups - 1) / mem_groups=
);
+       if (adev->gmc.num_mem_partitions =3D=3D 1) {
+               mem_ranges[0].size =3D mem_ranges[0].size * (mem_groups - 1=
);
+               do_div(mem_ranges[0].size, mem_groups);
+       }
 }

 static void
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,
                break;
        }

-       size =3D (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
-              adev->gmc.num_mem_partitions;
+       size =3D adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+       size /=3D adev->gmc.num_mem_partitions;

        for (i =3D 0; i < adev->gmc.num_mem_partitions; ++i) {
                mem_ranges[i].range.fpfn =3D start_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 41dacc015983..9ae5ebf47eb5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1938,10 +1938,14 @@ void svm_range_set_max_pages(struct amdgpu_device *=
adev)
        uint64_t max_pages;
        uint64_t pages, _pages;
        uint64_t min_pages =3D 0;
-       int i;
+       int i, id;

        for (i =3D 0; i < adev->kfd.dev->num_nodes; i++) {
-               pages =3D KFD_XCP_MEMORY_SIZE(adev, adev->kfd.dev->nodes[i]=
->xcp->id) >> 17;
+               if (adev->kfd.dev->nodes[i]->xcp)
+                       id =3D adev->kfd.dev->nodes[i]->xcp->id;
+               else
+                       id =3D -1;
+               pages =3D KFD_XCP_MEMORY_SIZE(adev, id) >> 17;
                pages =3D clamp(pages, 1ULL << 9, 1ULL << 18);
                pages =3D rounddown_pow_of_two(pages);
                min_pages =3D min_not_zero(min_pages, pages);
--
2.40.1


--_000_BL3PR12MB6425F9ACFE16956119B553CCEE7E9BL3PR12MB6425namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Reviewed-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 17, 2023 2:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Joshi, Muk=
ul &lt;Mukul.Joshi@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition c=
ode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Caution: This message originated from an External =
Source. Use proper caution when opening attachments, clicking links, or res=
ponding.<br>
<br>
<br>
Rework logic or use do_div() to avoid problems on 32 bit.<br>
<br>
v2: add a missing case for XCP macro<br>
v3: fix out of bounds array access<br>
v4: fix xcp handling harder<br>
<br>
Acked-by: Guchun Chen &lt;guchun.chen@amd.com&gt; (v1)<br>
Reviewed-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt; (v3)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 9 ++++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 +=
+++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 11 ++++++-----<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 8 ++++++--<br>
&nbsp;5 files changed, 35 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 739eb7c0d133..5de92c9ab18f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -794,3 +794,18 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_unlock_kfd();<br>
&nbsp;}<br>
+<br>
+<br>
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s8 mem_id =3D KFD_XCP_MEM_ID(adev, xc=
p_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions &=
amp;&amp; xcp_id &gt;=3D 0 &amp;&amp; mem_id &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D adev-&gt;gmc.mem_partitions[mem_id].size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; do_div(tmp, adev-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return adev-&gt;gmc.real_vram_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index be43d71ba7ef..94cc456761e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_dev=
ice *adev,<br>
&nbsp;void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag, int8_t xcp_id);<br>
<br>
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);=
<br>
+<br>
&nbsp;#define KFD_XCP_MEM_ID(adev, xcp_id) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ((adev)-&gt;xcp_mgr &amp;&amp; (xcp_id) &gt;=3D 0 ?\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (adev)-&gt;xcp_mgr-&gt;xcp[(xcp_id)].mem_id : -1)<br>
<br>
-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((adev)-&gt;gmc.num_mem_partitions &amp;&amp; (xcp_id) &gt;=3D 0=
 ?\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev)-&gt;gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))].=
size /\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev)-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition :\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev)-&gt;gmc.real_vram_size)<br>
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((a=
dev), (xcp_id))<br>
+<br>
<br>
&nbsp;#if IS_ENABLED(CONFIG_HSA_AMD)<br>
&nbsp;void amdgpu_amdkfd_gpuvm_init_mem_limits(void);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index ad664ef640ff..34724b771ace 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ttm_tt *gtt =3D (v=
oid *)ttm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t total_pages =3D ttm-&gt=
;num_pages;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_xcc =3D max(1U, adev-&gt=
;gfx.num_xcc_per_xcp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_idx, pages_per_xcc =3D =
total_pages / num_xcc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_idx, pages_per_xcc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ctrl_flags =3D (flags &=
amp; ~AMDGPU_PTE_MTYPE_VG10_MASK) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PTE_=
MTYPE_VG10(AMDGPU_MTYPE_NC);<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_xcc =3D total_pages;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(pages_per_xcc, num_xcc);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0, page_idx =3D 0; i =
&lt; num_xcc; i++, page_idx +=3D pages_per_xcc) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* MQD page: use default flags */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_gart_bind(adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 938c8dba9057..d559e7bc0f09 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.num_mem_partitions =
=3D num_ranges;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If there is only partition, d=
on't use entire size */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions =
=3D=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mem_ranges[0].size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mem_ranges[0].s=
ize * (mem_groups - 1) / mem_groups);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions =
=3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mem_ranges[0].size =3D mem_ranges[0].size * (mem_groups - 1);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; do_div(mem_ranges[0].size, mem_groups);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
<br>
&nbsp;static void<br>
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D (adev-&gt;gmc.real_vram_size=
 &gt;&gt; AMDGPU_GPU_PAGE_SHIFT) /<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gmc.num_mem_partitions;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D adev-&gt;gmc.real_vram_size =
&gt;&gt; AMDGPU_GPU_PAGE_SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size /=3D adev-&gt;gmc.num_mem_partit=
ions;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gm=
c.num_mem_partitions; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mem_ranges[i].range.fpfn =3D start_addr;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index 41dacc015983..9ae5ebf47eb5 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -1938,10 +1938,14 @@ void svm_range_set_max_pages(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t max_pages;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pages, _pages;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t min_pages =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, id;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;kf=
d.dev-&gt;num_nodes; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pages =3D KFD_XCP_MEMORY_SIZE(adev, adev-&gt;kfd.dev-&gt;nodes[i=
]-&gt;xcp-&gt;id) &gt;&gt; 17;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;kfd.dev-&gt;nodes[i]-&gt;xcp)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D adev-&gt;=
kfd.dev-&gt;nodes[i]-&gt;xcp-&gt;id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D -1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pages =3D KFD_XCP_MEMORY_SIZE(adev, id) &gt;&gt; 17;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pages =3D clamp(pages, 1ULL &lt;&lt; 9, 1ULL &lt;&lt; 18);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pages =3D rounddown_pow_of_two(pages);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; min_pages =3D min_not_zero(min_pages, pages);<br>
--<br>
2.40.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL3PR12MB6425F9ACFE16956119B553CCEE7E9BL3PR12MB6425namp_--
