Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91465C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 04:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B66360720
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 04:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B66360720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5E76E9BB;
	Tue, 11 May 2021 04:46:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020ED6E9B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 04:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCPLXIG9tQzjEyckj8Y4qoeTo6f2qh1sOb7WBv1l2MLYErzKHjcY3DuyK4g3xZndR0fVo5fybIOO6OVbVm3J5i5sxJJTGRoKtku6PJJs89YBZTMSp7tFBbqtk1SrGO8JCwWJ302L9vDx9eGz4RVjv/BOdDQmlKQpZRAaPpdHmBbgaSt1/Og2gmJM6dQwrbQgQC/GnQQN8uirL9E9Rh6PxM7aspCFLhqZ0vEedCuZcA2evyB6F7lH6rYG186uIgns/PInYJHzq2ltwhLyYPhfkdFCdR320AHIY2GnFBLu3D6QodRRofjnWGW6zQ5Vu3ZEKhziboaKdQpssmVWkMowtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrcmGt8k6/haoDQxX6rGiuiBHA8I9iJQKrMRTXdTMTE=;
 b=BR6frmh4MTLy6xOJ9yu+l2G+hKwxQciodATbeAOPnrQl1m3dQoCRh7gfqnsbShSVOwxEght03ZXdYUDsHgiE1CJ/VvOdR0rnoXhC7wfbVrjRyaQS7RQw7V0bq/pKexm6UVE8vXjqVKVr6dGGCFYUhWyVFDApkLkj9V2jsArcjCaAcVWNzcsnBNSUATDt/BIRy0SOGS0QZBkqVWnsgnk/bZa6kZLwzp3Hg5+y9B8aJruN3okqkDFLpUaddlDqvMKV3qbw0prs4wXDFT9P5FdiClEpAnuZz6jQtPsqmGtP/xTTECLCvYJi+TfRR0FlEUz+9yF4mISqjrs0dztUwL/WJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrcmGt8k6/haoDQxX6rGiuiBHA8I9iJQKrMRTXdTMTE=;
 b=oFPSSwaJIv78dUjEmmBv1xI/QNZB4kEKeVxi4QCMetqh7I/gv1ccsWjQA0DA1P2xPwt5DKBMLgyhoQGE5Mf7K6pFRABzNI3gIR32i355S/jsizAKnwUk6astxtyd//7z+U6oSY9lgBl2g9+ohv3IdorvS6xW/4ZmUTMa87Lk8iE=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1271.namprd12.prod.outlook.com (2603:10b6:903:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 04:46:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 04:46:26 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: add judgement when add ip blocks
Thread-Topic: [PATCH 1/2] drm/amdgpu: add judgement when add ip blocks
Thread-Index: AQHXRhkWHpAwSrPeq0C5dk/jozQeZqrdtNOA
Date: Tue, 11 May 2021 04:46:25 +0000
Message-ID: <CY4PR12MB12879FFB42D2444E57952BA3F1539@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210511035219.2291350-1-likun.gao@amd.com>
In-Reply-To: <20210511035219.2291350-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T04:46:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=75f1124a-81a0-4a7f-b951-da2a967990b6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 818f5e32-8a4d-4469-936b-08d91437bc18
x-ms-traffictypediagnostic: CY4PR12MB1271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB12719FF0EBF9EFA80426A764F1539@CY4PR12MB1271.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:233;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbOelS1buJBaCTk5vf/ccsGCf/9nukBX6EixLlI+2Cj0HWTkCCkCzlssV9CCDYhOopjU4A3II2wQiXVFF4kkM06zF3cwhpRbRXvzMfNjQfeFhdCvIL2h9xUfbRAMoQpd0EDVeMSnP0rODyuCx0BsMAXKqIc4TGfO7KqNpKNcREjysVZvPaIIIkISnQWZqMsdd/iWEj67TXTG2ovVEL2t2n+17O2R7XEMxyPWbhQxSS7DuspG4arqww+hlUjsQ/MJ1ltz0GCLcRltxYncw++SHCWNb3a6CdquDL6izR7vGBqUSbTrDFgrq2cdu+pGZJiV6vMuacp62fPeXej8jyz16CFHa4HH8I/RPTY+iJZsf1a7mLnQxiT74iVl1dZpm0jDE5x1vwlCT7M+tkyLL4lq4QBy++SNGit27EUUvnGL+LwiSyx14mJ5GefBEo0TS3N9ihBM9pQ7EskHLhwgOPHehtt/O0RZr0tZ70UmFHbVcJ4gsxeiCkdfLzMXG0he+CYyUbKsOVpaHas8pdknwZ1RYNoPB1lUGO6N/0gmzE6r7SUNOKqpRG7An2zCGnPLRtt/BuF+SwhMLHzhY6ur7mqaFHeV76VsIl58OZAmp29l58Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(66476007)(2906002)(478600001)(6506007)(55016002)(186003)(9686003)(66946007)(66446008)(66556008)(316002)(64756008)(83380400001)(110136005)(122000001)(54906003)(38100700002)(71200400001)(76116006)(5660300002)(53546011)(8936002)(4326008)(7696005)(52536014)(33656002)(26005)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?a51IAFcorYjfmoDsfk3dZ3LaZE9QTw9vZhkKZFoTwR//IDuK4irFRflmrAbY?=
 =?us-ascii?Q?ezjetmyD12mN7LAZC0eAyfA86bYeDdBfu4C3nwS4G4ttoSIy0dx2g3P1b8Bk?=
 =?us-ascii?Q?yXz3vNfCPVfcBjl/PaWfkCon61vKM+WdVDxxYhYfhZq/HELSS7BxgWGPbhI3?=
 =?us-ascii?Q?c4Kn0n8LZ24Q6IusuHF3IHk8ftSkMgws1EsTo36W1WRgI7AYBZovLcBzIjD/?=
 =?us-ascii?Q?wBA+z7as1gJSRQmwKE+WsNSZ1PjxUryRpRfHsiKRoF8xVMP10pZSsf7nJF13?=
 =?us-ascii?Q?/lrYtigR88YeQFPxV+NO240I28lAC4lk3+H4g1hsU1YTAmmQ58k/w7Mt7JT9?=
 =?us-ascii?Q?R4XxiEzVi9NBhZ9eU9GtvKg/yFLWtOLctPyiycvS0FYWhjinMhnyQE0IYnMa?=
 =?us-ascii?Q?73e2wUsWCiY4S21n3nvHZeoahh/P1Ef0IqBn+AuHtadankJCx/UKZ0wdx05Q?=
 =?us-ascii?Q?8b4QA11eRe9CWlfUMsHbPIzNVlK5z30SVT1Y8WbUgS0t9mHI3UD/i8lT+eQr?=
 =?us-ascii?Q?aKswqPR0yaHKn2CmQqbLMBX9nW2MJsUVtQzNqZ8fYIZbiA9uq0yH+8ftUFnS?=
 =?us-ascii?Q?MBrdtdx/VA6/mePYjtSeLbY5uTw8dA1gfZnnECoOqk6LPv9lzBZtLFsd017E?=
 =?us-ascii?Q?Tdf5ssKEKwrZ1XUQf7dVWLewFJA7Cnunz3g7Ud95tQAkf0iazVfqgI7gPTeR?=
 =?us-ascii?Q?GO571XoToIKbWhiArM7Z1h9QxWGflmbfDa6WpXEYSOcjfoQ+iWLpD5tmeq71?=
 =?us-ascii?Q?78HfeuP4m2cDmDZmWFfRCGFLyahGQdUb0mBeqhwnC0rZCLrkmIIokzNHR3rB?=
 =?us-ascii?Q?d9RDc7IJTsGATpTN1W9jjwbsemR/tWQ6hvuzXK/07K8uRLSbtFTXoLM4UtGH?=
 =?us-ascii?Q?BYnWfEHWpa8jCEKPkP7RGtOpUhGK3iWzT5DEmhYBT7ImMGSlm9uPEJefB3BU?=
 =?us-ascii?Q?z3NHOW9j3IvPqg7/3KL/8OpQmyAU/8uiyQwgwq583E3Vgz6srO9vTusHXJwG?=
 =?us-ascii?Q?3nkPKKKuqgeLBKbf+X2gzAlAuNlASvzDcIFbivXoxvWfwCd1lNCNAWj4J5RH?=
 =?us-ascii?Q?goB9E/F5XF9OWCfGsitCYhkC/icYSdK2QbjsLa+xgYoc/slMpYjbYnw/EoXN?=
 =?us-ascii?Q?8YJeBIAmLD9t/TlnuEkHdE2vA8J10HzXlnDtGfmuAk2tRldYV4eek5zUgiz2?=
 =?us-ascii?Q?UNTEyQEOLiXRrGAjltLaPx00pg1L179vyYHv9u47HN8TxtBOfP42I22nRbxu?=
 =?us-ascii?Q?9YaW5zmDltoFcSmA2K7lpOKr3Gz89qw+PZNXyNcxIN9FYf/wK24YpCd2sloM?=
 =?us-ascii?Q?KTffSt2CXyJBLfMVDLdf6Ss1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f5e32-8a4d-4469-936b-08d91437bc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 04:46:25.9380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ptvvu98EANuK/3ezLVskYY85CzdN+YWNvL5QCi101+iblieJAtKrd7DykCmMpXNQqKmjX+Oji/Xbd7/L/3vwNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1271
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Song,
 Asher" <Asher.Song@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

The series look good to me.

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, May 11, 2021 11:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Song, Asher <Asher.Song@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add judgement when add ip blocks

From: Likun GAO <Likun.Gao@amd.com>

Judgement whether to add an sw ip according to the harvest info.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 15 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 30 +++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |  8 ++++-
 drivers/gpu/drm/amd/include/amd_shared.h      |  6 ++++
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 10d9a8a237fd..3147c1c935c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1010,6 +1010,7 @@ struct amdgpu_device {
 	struct amdgpu_df                df;
 
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
+	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
 	struct mutex	mn_lock;
 	DECLARE_HASHTABLE(mn_hash, 7);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b0543f409039..6881015f40be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1683,6 +1683,19 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 	if (!ip_block_version)
 		return -EINVAL;
 
+	switch (ip_block_version->type) {
+		case AMD_IP_BLOCK_TYPE_VCN:
+			if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
+				return 0;
+			break;
+		case AMD_IP_BLOCK_TYPE_JPEG:
+			if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
+				return 0;
+			break;
+		default:
+			break;
+	}
+
 	DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
 		  ip_block_version->funcs->name);
 
@@ -3111,7 +3124,6 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
 }
 
-
 static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)  {
 	struct amdgpu_device *adev =
@@ -3274,6 +3286,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->vm_manager.vm_pte_funcs = NULL;
 	adev->vm_manager.vm_pte_num_scheds = 0;
 	adev->gmc.gmc_funcs = NULL;
+	adev->harvest_ip_mask = 0x0;
 	adev->fence_context = dma_fence_context_alloc(AMDGPU_MAX_RINGS);
 	bitmap_zero(adev->gfx.pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b2dbcb4df020..99255c2f08f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -373,6 +373,36 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 	return -EINVAL;
 }
 
+void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev) {
+	struct binary_header *bhdr;
+	struct harvest_table *harvest_info;
+	int i;
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
+			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
+
+	for (i = 0; i < 32; i++) {
+		if (le32_to_cpu(harvest_info->list[i].hw_id) == 0)
+			break;
+
+		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
+			case VCN_HWID:
+				adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
+				adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+				break;
+			case DMU_HWID:
+				adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
+				break;
+			default:
+				break;
+		}
+	}
+
+	return;
+}
+
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)  {
 	struct binary_header *bhdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 8f6183801cb3..1b1ae21b1037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -29,6 +29,7 @@
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
+void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
                                     int *major, int *minor, int *revision);  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 82a380be8368..d261f459c982 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -635,6 +635,8 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 			goto legacy_init;
 		}
 
+		amdgpu_discovery_harvest_ip(adev);
+
 		return 0;
 	}
 
@@ -777,7 +779,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
@@ -1154,6 +1155,11 @@ static int nv_common_early_init(void *handle)
 		return -EINVAL;
 	}
 
+	if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
+		adev->pg_flags &= ~(AMD_PG_SUPPORT_VCN |
+				    AMD_PG_SUPPORT_VCN_DPG |
+				    AMD_PG_SUPPORT_JPEG);
+
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_init_setting(adev);
 		xgpu_nv_mailbox_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 43ed6291b2b8..9ab706cd07ff 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -216,6 +216,12 @@ enum PP_FEATURE_MASK {
 	PP_GFX_DCS_MASK = 0x80000,
 };
 
+enum amd_harvest_ip_mask {
+    AMD_HARVEST_IP_VCN_MASK = 0x1,
+    AMD_HARVEST_IP_JPEG_MASK = 0x2,
+    AMD_HARVEST_IP_DMU_MASK = 0x4,
+};
+
 enum DC_FEATURE_MASK {
 	DC_FBC_MASK = 0x1,
 	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = 0x2,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
