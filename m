Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025B3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 13:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B7D10E5D3;
	Wed, 16 Mar 2022 13:54:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E0810E5D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 13:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHzdHjmR8vhi0nqXF+iuxRhPDLYqHPfj7M5vzo/bzJob0oyi3R3A4O2iyT2KwM+x858nyncQIuSFq3/qsMjAiEmaNit6LczRdan8BmejYHaD+mATJzNo38HjGgVkXQneTnnrfbrOthKXacwFMpTa/W198RHbesF4htwrvP4D8O3tO2B/hG5mHNHRhgPMpUWJFEO5Nl+zp99JMcf+UrvDIEpZphLnS5gbzDczZub1Yxt8HdR7l+AaAQX8hZRbcrNWAgzg3KpmZRUR/VKoJOK96kYelEqFXvUCaPxCLDR9mRnR8+rf9fCwoLfcHZpn51ENzYtefUke6fBpgOwD053Q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+84saBqBfTzxMsyTYFsaQHtMSZf8gxIKELzx9JMtes=;
 b=f5+qqF6vWJsLSSf1tHygzD0GjlHjdoZvMjQ1rg4O5fRmh9n8RN3InR2KdCGDYdJna5dlT4+fllLl8sEvHkQXcqz5U2jqNZrso5+/n7RYBYuc+DCibAcfi/vA0zd/HGk6/pauYvz2NKNlAWJ0E9uhGWG3MgwvZAKSEdX4eHouYfz3UTa6mE3EsZiDe1GrZDqaH5Fj0B+QEFfR2rykokNvaYc+uvBfim97zErPgG2A2g0qxuEhCa6aCU4IcjeAYCRZjReDUi9gd2zzdKcDyzVou+VBTXxwlwKi3zpSQaDh4/N3z+sKSkdEephnhULWcESEvkIGoIv8pwOSdYMo1TrMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+84saBqBfTzxMsyTYFsaQHtMSZf8gxIKELzx9JMtes=;
 b=WWIH07K4h5BNaqul6DEAqnYRPMAs8Eeo1ndPJgQAxqHDK932Sri37HIohCaoIO2jL29Gw4Dy81QoqYm3/JqeoSrd3e07fgA4uw17yFTq1gXpdwBxu/KJEzL0kh44cw5Rd7xd4b7bYstdy/YgXZRoeWgTL6Y14TzsMH+ZZid1/A0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:54:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:54:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: add UTCL2 RAS poison query for Aldebaran
 (v2)
Thread-Topic: [PATCH 3/4] drm/amdgpu: add UTCL2 RAS poison query for Aldebaran
 (v2)
Thread-Index: AQHYORf00gLf3QbMykKDag8M7h5ma6zCCEvA
Date: Wed, 16 Mar 2022 13:54:08 +0000
Message-ID: <BN9PR12MB5257EC37089D4F27F5B2CE24FC119@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
 <20220316092627.17359-3-tao.zhou1@amd.com>
In-Reply-To: <20220316092627.17359-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bced3dc8-b204-4878-9c6d-44e74df077cc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-16T13:53:39Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0e52232-e8db-4d39-4f4d-08da07547132
x-ms-traffictypediagnostic: MN2PR12MB4094:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4094CDD3CDC25FF7306417AAFC119@MN2PR12MB4094.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5TRgowjomEmazkPiHPoZtTq1txGfyRlklirESrkYqYJgrR/bcLbmOnEiRD0WOuspfUHNIPN36alwx+VKPDMYd/TNN1yueyOHN8514nVr7p4potfg7KN7PRxJ7VTIAh8naxWnq4NrLzflWgizcQzxR6J+SzBHGSs+POoPZ6X1GNOXEVBZBXpr816QHFGILxPeRFwzcO8UtDX6jB6+yi2bi4S1QV8KueBjl1dDDWgy9KK65qertBcB3J0KGrVb3+dXb4pZHjTAB198OBkfqK0ilOZJJX8G56CYYMuF0rLbxZJNgVE/egz8N6JxB/Kua9to+gA6WujM0r9Ihn2IQkJV8QPLZz/i+klTuoXl0X4j2kktGsWUc6597zacy16zy+yg+h9H7jpNmSsEW6BFmhpXIKHT6+An15ep4NlH7JMbQEv4mxPYmLY2nzBTmAi/BL59m7BRa9ictz8itqhinwn4HpoUSt8Mpm0o93TvdvVxxQ5OET3yrzQ1OHySEfq3sAmFPGAJKLjX9AdSTi5zCDQiCfNxEvgHhfCwLtiB0nNm0SC+fIv6ptiZVP2zmTjPAIn0VS/KBNBpqCnTmgOBZFc67/F5M2RiS5qoPczwQSGseKX9FpOBskGFZqO6XhqgUiB1cxKDcjrHXAju2KVGPQbmGxyoRSkkqr2q/3qQD5wPOwOVDUU/IMTMpHlcUL7g3Oc9M5F6YqA8Zt/VRBL5B20Jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(55016003)(86362001)(122000001)(508600001)(71200400001)(38070700005)(110136005)(316002)(6636002)(7696005)(6506007)(26005)(53546011)(9686003)(83380400001)(8936002)(5660300002)(186003)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(8676002)(52536014)(76116006)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P4qGX7V85SaadQ6Vhho2v6mipmpFxduKhe8/TepraL+WvVAP5TCVqnHC5bNS?=
 =?us-ascii?Q?ZE8mN/k2z+ivzNIhOvXae8G++X9AFQtgJJSeMn3wjNdHcf30OTh013Spuy6H?=
 =?us-ascii?Q?E1r+S9PLj5FJDntGErQVbOhXM1F+CoVucxst1igew+Ic4N8zv+xeTitquKR4?=
 =?us-ascii?Q?guyxU3qOCqPAhZIt2Ekgbo/g7zaEryvGsm7+BGK9zmBAobKVB3E5xLMFbx8m?=
 =?us-ascii?Q?gsDBVgsCDgVU8D+ZFlMkxZg1u2tZkw9AOCOySDxvsX/UNgV6CkuVaYtwri4Q?=
 =?us-ascii?Q?DVDR8GPgujBz7nEtsqPu46GhB/jlVl00GFknUu+W4yXv7EH+UZB2wjyj1fVL?=
 =?us-ascii?Q?wOM4PH1nMNJWIX17FtT4tuleoTRV+4HC4iC0O47TveeWtxLvgkOjOpSGYwlw?=
 =?us-ascii?Q?NsA53rVY8TJct2mXoq0EJ78f9+FZVg13MfYJj36jg4ZigI0fYFExDDpk7nc3?=
 =?us-ascii?Q?Wt5F2J6GHi3NFP5umbnFou/yE6CJKarZR+QDUIfHe9pQiRfMyt285aE/+M4n?=
 =?us-ascii?Q?l6xnoSmD0IlX40+xwy2Y6LUdLz8lEcJK86dm6LxtsxY+pSUKk3PLkaNm2DBf?=
 =?us-ascii?Q?t+GdfUL273TR1TXSOkkBzPXVBwP31fAu/TLIFKR+7pDdvYXUR8IBSBUoX5nG?=
 =?us-ascii?Q?yJa05TEahyX98Ve+48X+V4X75cMObRiCTkuTilUJGYp2ftTX61qQ/S1eXTfo?=
 =?us-ascii?Q?QOqw3fAhK9Vm7qB7u23NBP0SLwdpCTAvYiBYbL/HyXFbyyxOPCCp7Qcq+IGr?=
 =?us-ascii?Q?M/795TbXB47W20E+amk5nH+cL6YPJUyI75o0FCr+2EREbTDHqopgEmKtxavF?=
 =?us-ascii?Q?uTAojSskdgMHk7dTD4LIY9RnUbM6ylNsIVdOIPkrexjav4Kieq/J3sngsX/Q?=
 =?us-ascii?Q?yBkBsqlEMl8szR3fzMUNPcdfnNLFV+SC1ywdDhWLhItDsvf1OaXV9r1LFKmu?=
 =?us-ascii?Q?Tis1Vror7jhaR+ptZAQSUdy/F9CqLCBeXkYMgRFFsMA8b7gGUG2l89CpsODk?=
 =?us-ascii?Q?wJrPpIQqd/Dmcz6EvdW9axTbBJpD3h7hfR/B7jvaW35mqKu8/Sgw8vG1ClZ4?=
 =?us-ascii?Q?0xijxT4Sd25rH2Xx1uJGz/mJQH9ZuIfxXuVguaNxvKhEUn2hFM2XdMNHrD9D?=
 =?us-ascii?Q?vwBvgcKEV16NSGhEEAasgBZosJy6LmPOfegqj2tPywtSOyyVMDk1g1mV3uYQ?=
 =?us-ascii?Q?3/3Xd+epZcg89fwkw44dIg/2sgjiwg3Yu3/zXgty4ZRYFvrH6As11ck2Vyeo?=
 =?us-ascii?Q?qSCSFqxNox3J+t5dlBJT2v6tCd7Uk6RUAE2HTJxEbizl3Ohju3CDyH4+Y4SB?=
 =?us-ascii?Q?eKpuGx7o7NAzzmyU1cvVMq6vxptOjNzKTU0Mp+FSN7nuTwo7whCTgddm3bNP?=
 =?us-ascii?Q?zJhkBCOTZgfsFBOPQ95+qr9s6iYW9+F4j+0wYW8rNooBQC1dXlaxKRum3jlh?=
 =?us-ascii?Q?6oFCxPk2YcoucZB0x1JmdIjVkNf8OfvJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e52232-e8db-4d39-4f4d-08da07547132
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:54:08.1616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wo0NNQ6lzo0WMF1XaaBiJnwdyE4qumD6C30fdJWyZ0cmqGbTk39rq/po2Mp8qktc8osbOOWb4yRbhtqOZsdi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

[AMD Official Use Only]

V2 looks good to me

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, March 16, 2022 17:26
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add UTCL2 RAS poison query for Aldebaran (=
v2)

Add help functions to query and reset RAS UTCL2 poison status.

v2: implement it on amdgpu side and kfd only calls it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  8 ++++++++  drivers/gpu/drm/=
amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    | 14 ++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 6ca1db3c243f..c18c4be1e4ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -724,3 +724,11 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(stru=
ct amdgpu_device *adev, bo
        else if (reset)
                amdgpu_amdkfd_gpu_reset(adev);
 }
+
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device
+*adev) {
+       if (adev->gfx.ras->query_utcl2_poison_status)
+               return adev->gfx.ras->query_utcl2_poison_status(adev);
+       else
+               return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 4cb14c2fe53f..0838926a8ef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struc=
t amdgpu_device *adev,  bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_d=
evice *adev, struct kgd_mem *mem);  void amdgpu_amdkfd_block_mmu_notificati=
ons(void *p);  int amdgpu_amdkfd_criu_resume(void *p);
+bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device
+*adev);

 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index dcb3c7871c73..5ed9b8a4c571 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -202,6 +202,7 @@ struct amdgpu_cu_info {  struct amdgpu_gfx_ras {
        struct amdgpu_ras_block_object  ras_block;
        void (*enable_watchdog_timer)(struct amdgpu_device *adev);
+       bool (*query_utcl2_poison_status)(struct amdgpu_device *adev);
 };

 struct amdgpu_gfx_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c
index 7653ebd0e67b..e0890e00eedf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1930,6 +1930,19 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struc=
t amdgpu_device *adev)
        mutex_unlock(&adev->grbm_idx_mutex);
 }

+static bool gfx_v9_4_2_query_uctl2_poison_status(struct amdgpu_device
+*adev) {
+       uint32_t status =3D 0;
+       struct amdgpu_vmhub *hub;
+
+       hub =3D &adev->vmhub[AMDGPU_GFXHUB_0];
+       status =3D RREG32(hub->vm_l2_pro_fault_status);
+       /* reset page fault status */
+       WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+       return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED); }
+
 struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops =3D {
                .ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
                .query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_coun=
t,
@@ -1943,4 +1956,5 @@ struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
                .hw_ops =3D &gfx_v9_4_2_ras_ops,
        },
        .enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
+       .query_utcl2_poison_status =3D gfx_v9_4_2_query_uctl2_poison_status=
,
 };
--
2.35.1

