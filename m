Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A584DC77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E9A10E238;
	Wed, 17 May 2023 16:26:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D4610E238
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIt1C/8pmSfb1aEwmVXgB7MILLEvyUpFcHjnpGXObxrL8WCp9Mw3lr6/DNWZvFDgHzV2NE0VeBqXkOMSRRNx5iTFRaC9ZQeUTocgDYW+nDxNbVM4b/TXhX4BElw1G6e8sg84EHLaXiNrlwfjmm2uRkd7D/k4A0ZkvyQTns7R8nAxfTJr7KWmBXWb8ML1iEDAYU88sB8YlwaAf1XB2YNzWyceFn3r+yHn912cj3KXuv8YfXqIjBw8E8WZp9FRfSlW7vF4b0cHFDyyCyd5p4cvSDC29jRPkY9R4H/5vXQ+vuug6YViDV8RJ4ctd/x38zj1dZZVbRHvoUXMTqtGSO/bYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lqVo4E9Y4T0VjOOdPG4WYlJ4jQjo9E++EMG6H/goNo=;
 b=LCsWwpeI/pGCqPTr8rpajQ/nvQy0MD17JlcVf72eaaMow+cRin8ELfkilDWDTTebPG2aW+gN0ha8iI0BNd6f7VOPBilXrLj91iuRDjL2/emZib1XLw3FBjrzNu2IjHKsBUAsfGlED7n62oIPzDPTJ6bB2TRLomOKBX7oBq5e1xxLUa61Ni3YpCyblqYpndPzx0/tXE2KvlFGZPpEhm1rEpsmH1S85wpjkeFqf9MPIluU8344jEuIcTHEgNmHcY7efcq7VTiKBfSMw3iZ9lazqyx0xSFJ2B/kK95Vl6yR+p3f2Tb8QpHiTk1MAimBN3DtPSfMwZmD+hJecZE4Q6s+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lqVo4E9Y4T0VjOOdPG4WYlJ4jQjo9E++EMG6H/goNo=;
 b=wHemg8ZNuQFnWLIwWBlIqV7dhslH4+9ht7aZLzLkVQSZRDa9xUBOh1GxSAbjM3UmGBEvaafbWAQ0A4kbI3Ymr3mM4nGXlHZtXnYpVpJhw8KP44wEk5LTGhIQr2LUEsPH93dKzf5qZn1tcVZDqFd3zxaheYupzv6c3iVSki/SsqI=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:26:17 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7ca6:a548:58f8:e0c0]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7ca6:a548:58f8:e0c0%2]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:26:17 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Thread-Topic: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Thread-Index: AQHZiMxXtH7gJFmuCkGH+9K0bma2I69eoan2
Date: Wed, 17 May 2023 16:26:17 +0000
Message-ID: <BL3PR12MB64255F59A97B4E656F9CE387EE7E9@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230517143130.3016720-1-alexander.deucher@amd.com>
In-Reply-To: <20230517143130.3016720-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T16:26:16.828Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DM6PR12MB5519:EE_
x-ms-office365-filtering-correlation-id: c95ef16f-85ec-467c-66bd-08db56f370c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+mLbVlT08WGbL5/jXaEj1aFq8KaULcVd/OM8VIrjdPaGcOXb3MIVtF1uC3/+XQMaWoQWew8rCEu5IPDtuluBKwdT9+YMhDl+nUwcxV8DazYpcOTA8K0eNkigyr9CxJz7Hoo01GIjOlGKSc6sVfZIYkVPGju/AlUFYK4CS/G4ZXu3cy7TtUhn7V8dOxZzLcuZ0wxglqx6pxW8iPc6mtWWVBBp6iXk+YTxFIWqV4+ZpM9s7rNmkk5AQDs+YiZ5z4k5DTo7sxnTBRa3zVICz5jsU5HmIIwGKitHKZbyGKJo1S1ChYXITrbpbIXEiq9W4WI91Mu10TIf1Ti9KAbvCnGNX6UdDLKPdzXVITIT5iyZBOqZ1jNNeROUoUvtJwMPukybENuJ4sicMXv7beO9db0kqXqrkQFCX84Q7pb72s4ssP1nLwmbz9SbIfqLpqVInMMsBT8jYEkFepuP0SMhs1rfyvm4aqX1IpNKJ2HRjNXfqdkrksP5hPWNMLwI3yFBXmbj+12uEIkvNEpfY53AxKX5k9KI14B7ttBxDNd06iO/l7HIAJDy3k8a8VGqsfpjeRZbzrPhWGt9HuUL0HnvoRYzL9r1qElCBVL/nb7IO2TvAcwJurlNFRgpOJpKMf/Vp3T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(26005)(9686003)(6506007)(53546011)(7696005)(55016003)(83380400001)(38100700002)(33656002)(86362001)(38070700005)(122000001)(186003)(2906002)(8936002)(52536014)(478600001)(4326008)(19627405001)(316002)(110136005)(5660300002)(8676002)(76116006)(66476007)(66946007)(66556008)(66446008)(71200400001)(64756008)(91956017)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lwds86WoqOmoAsdDyATpAkOFkDbcmwkJOVJyJ5Ekd/JebrlPGojM525qyM?=
 =?iso-8859-1?Q?Ve6/qASxbHH8nR0FTjZsdqnyvD9z7BoJndZ5E07KK2r86VdaEon2e1fDin?=
 =?iso-8859-1?Q?809uvz5zNXsdxihwoNAL71QrG30uwGgmfLh6kzc8Du1SieseDp09GJFUiG?=
 =?iso-8859-1?Q?LC6T37EqIwJMsCf9socMEYodSuq+O/wxgJ0yQpcancMvXfp02eJiR/rMJf?=
 =?iso-8859-1?Q?Y67RTafMNa30QnMhCDaCS36qcwoDcZ2MaTI3ktli/aFSdynanZO+/KEUb4?=
 =?iso-8859-1?Q?5awUb0Oh4lEmSsu4j4XnYbTxZXlMK12cu3KOFw8PFamPB6RjawLWl+Lped?=
 =?iso-8859-1?Q?n+EYAXOx6ScjYEmZJGeHnj9VH4HiaR4gx5dDjjoNwLjnf4ptV1pCB9+YhQ?=
 =?iso-8859-1?Q?GgCYYKqKWRzC9VJDrWFCm1nUu8sZGeMwZ/nwosjP2IgZr7MlIToh5KHQl1?=
 =?iso-8859-1?Q?yqnBk9/fJo10yxw9OOlUbr7XYPjShrruRxvudNHJLcaj0U5RLzztP6jEB9?=
 =?iso-8859-1?Q?wwUfAg2hOH63dozvLiam/wCtv4ZjbU2fMaPv1FnKn2XuenSjhWCxRZG1fs?=
 =?iso-8859-1?Q?I96RL+Oz9TjC/9K5WbAdp1bownN5ve8O40RihntBjQvJUlbbFk61rYdFTY?=
 =?iso-8859-1?Q?1oM65YZ9xrqRjPhSoKlagknwlbNfNXoNE4bZDrnWNYKgVJIbZDIA+Cv23s?=
 =?iso-8859-1?Q?81RjipyYviiwAQD4ZikqONA6wC24WNm18Td49tNA2V/j+YZZbK5pyDxQH1?=
 =?iso-8859-1?Q?SkuAOe5MARD3Kztfsz/Dn0wneO9UWq5kPQLz/6msWzdOsCxslTN41FHTtw?=
 =?iso-8859-1?Q?NhuPqL+8LjL466KByv+Rpap9+c7wd9Lb7iyEalucz//M4+9Ee53x7kuBTl?=
 =?iso-8859-1?Q?7PZOX8Ue5dnRivIu4LsGZupsLvCPB1Qa0tVJzNOkXc84DItlxVygzULiJU?=
 =?iso-8859-1?Q?4DCgXoIDZfSvJmK3GtLbzoK/XBxAkn6GOIEylz8+KBkdh+8J4rwwSRNsSu?=
 =?iso-8859-1?Q?6f6XTlNVWfoNNTpe9dT/Z9Vv/lZ8s+72DjwOxcCMTCJ0xSiRfHGA4Ll4yg?=
 =?iso-8859-1?Q?QUFLSI9tAsq+MepA/FHVIBk+TvBBy+LAbN/nKbhVHLyIkNwwGmG7JoxRp0?=
 =?iso-8859-1?Q?NXOIWhDB/7DzEY9l9XBFv8i5eKSb8AgXzJKkhhn8JdUHGir7bsr7OgJ7zq?=
 =?iso-8859-1?Q?tb3BfhQtEaeG9fLVnYFgNGfhFg2BxlE1k7NtdF9p9xt416e5qegg/iaKid?=
 =?iso-8859-1?Q?U3b2lhE+ynXiX3xfxIPVkKuuV+53BVS8cpYNuske6EuAS1ndgRBMx9H8aE?=
 =?iso-8859-1?Q?4gQGmKzYzjME/2OHzTjp7TbWC5ewFq4k9If0p9PQoZ/2QQLcLibSI84ixN?=
 =?iso-8859-1?Q?jU3ZEj6zlwq1yCOFmYy71aF+pjVib4J8i4/QQXib6FS0/+UKpe/Cflz0xa?=
 =?iso-8859-1?Q?G5rkRc+jy/a7L7gczr19QYdOdWwarR8iDoMYURxPEegjHxBPGuB65rDQQ9?=
 =?iso-8859-1?Q?dBelOPIogfeOCma3qYemw6WMOnGOejBpJp/tpF1UhQwk97UFFeUf8OQx7Z?=
 =?iso-8859-1?Q?ZH4aAegkXESesWotbtWZ7D7QNVeEwKWEvBEMdWheOkOgmGd8PcZRfwzl2k?=
 =?iso-8859-1?Q?r9riEpN8teFFw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL3PR12MB64255F59A97B4E656F9CE387EE7E9BL3PR12MB6425namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95ef16f-85ec-467c-66bd-08db56f370c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 16:26:17.1857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gClpywLRcQQd/IBrQUIJohI7R6UvBv4VVQ+0og8zt+ylXiu7vUP2JtuLE3NB5bJcA06PU1XkUXrlfqc2We1MXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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

--_000_BL3PR12MB64255F59A97B4E656F9CE387EE7E9BL3PR12MB6425namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Alex,

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Wednesday, May 17, 2023 10:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>
Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Rework logic or use do_div() to avoid problems on 32 bit.

v2: add a missing case for XCP macro

Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 739eb7c0d133..fed545cdd1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -794,3 +794,17 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *ad=
ev)
 {
        kgd2kfd_unlock_kfd();
 }
+
+
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
+{
+       u64 tmp;
+
+       if (adev->gmc.num_mem_partitions && xcp_id >=3D 0) {
+               tmp =3D adev->gmc.mem_partitions[KFD_XCP_MEM_ID(adev, xcp_i=
d)].size;
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

Did you miss using the do_div() here?

Thanks,
Mukul

        for (i =3D 0; i < adev->gmc.num_mem_partitions; ++i) {
                mem_ranges[i].range.fpfn =3D start_addr;
--
2.40.1


--_000_BL3PR12MB64255F59A97B4E656F9CE387EE7E9BL3PR12MB6425namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Alex,</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> amd-gfx &lt;amd-=
gfx-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexand=
er.deucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 17, 2023 10:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition c=
ode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">Caution: This message originated fr=
om an External Source. Use proper caution when opening attachments, clickin=
g links, or responding.<br>
<br>
<br>
Rework logic or use do_div() to avoid problems on 32 bit.<br>
<br>
v2: add a missing case for XCP macro<br>
<br>
Acked-by: Guchun Chen &lt;guchun.chen@amd.com&gt; (v1)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 ++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 9 ++++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 +=
+++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 11 ++++++-----<br>
&nbsp;4 files changed, 28 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 739eb7c0d133..fed545cdd1de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -794,3 +794,17 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *ad=
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
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.num_mem_partitions &=
amp;&amp; xcp_id &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D adev-&gt;gmc.mem_partitions[KFD_XCP_MEM_ID(adev, xcp_id)=
].size;<br>
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
Did you miss using the do_div() here?</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">Thanks,</div>
<div class=3D"PlainText elementToProof">Mukul&nbsp;</div>
<div class=3D"PlainText elementToProof"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;gm=
c.num_mem_partitions; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mem_ranges[i].range.fpfn =3D start_addr;<br>
--<br>
2.40.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL3PR12MB64255F59A97B4E656F9CE387EE7E9BL3PR12MB6425namp_--
