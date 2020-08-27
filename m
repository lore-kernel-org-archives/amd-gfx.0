Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94401C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3067820738
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Je/JTUgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3067820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E976E484;
	Thu, 27 Aug 2020 08:22:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC656E491
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 08:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTEZ9VM5xNSWyJUm+j7UykTipHNlXfYSxRwIVP7xLKI0vsMHpkaun1ppwu2lW6ZMg2bt95+xLZT64IDfhg6Fb13pI8DX8wqXpvDb/RJ+qxdIEWp6ViQvHqePj5S6EVtgZoBf817BNYqf+rEGOpaSwMoVDkio2acUwqWXgDQHoL6aEuiGwQSIRlPI9GAuzk90/6msx8R5jJ6KC+OeoPZBD9OGd2NKWEbxGTM6sNeyaL57HN4AGULHfoiGMcLTuR6eEnr3juBI+V0mZa5DDAd/SjzzCbCO5BNZUU9yDj7RUBev+gQ5t12WsrPWgEw2u4c/fp17H/XnpCf1KU6KhWb2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGWZZfgGweQq6780H5G/RMp3yKUT/ZtgcNz/wdg8CoQ=;
 b=awabZ6uEJbEnE4VnVJA4QDY6dKOJLoW895Tvkc6aIReHbIw9HF+nHnt1EqQexJzNeBswVRk2VrJ5axnkWneN7aSjijm6zvBmSDg/aW8vdepTvk98m5uQjZJnOCGeczul1px6sQDXerB4FECXXEDzu/OleOxaAIxIPjnc0ubh5G9XWljWIkFjkd/2EXuKQtk11RgMXLecQ3mePhh1FNIRqm15n9iiDiLH/0qi83nFvPhfwun7Ek6kobiuJTEtr6UtvoGiE879mfz0hoEud8ESs0X4nc0Gf5Z/Ivy76TzMpnehKIklt1HqJOVgscIcis6y4FzSyqafd+ThKXVMhWclhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGWZZfgGweQq6780H5G/RMp3yKUT/ZtgcNz/wdg8CoQ=;
 b=Je/JTUgFe+iPEGed7pDdvh/AFKUAGV/NibGZqZVQpsEi+gFVpjxE2Q/yg3v4g/NfObjxUPOLIQdRjr56utqV+pATHeDT093bhGTqA4HroToIDvRl9Wnw8omsRyctSImRrVhtIDdH22mSBAEH8Nb6kX2OrW04TjjG8QiH43gbkfM=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 08:22:19 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 08:22:19 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-220451 - Query guest's information by VF2PF message
 - part 2
Thread-Topic: [PATCH] SWDEV-220451 - Query guest's information by VF2PF
 message - part 2
Thread-Index: AQHWH+IZT20Rr4iWPUubgtnIdrkb+alMVpPw
Date: Thu, 27 Aug 2020 08:22:19 +0000
Message-ID: <DM5PR12MB17085DBCF71F2F3C421A51E184550@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200501174818.35669-1-Bokun.Zhang@amd.com>
In-Reply-To: <20200501174818.35669-1-Bokun.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22843a28-e407-44d7-a0d9-0000366f6d7d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T08:22:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fccfdd86-c981-4e58-8a6d-08d84a6250af
x-ms-traffictypediagnostic: DM5PR12MB1164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11641D14019E8A74090040BB84550@DM5PR12MB1164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gI0jtr10PTtC6WznWjurPv6GfFyEvamid/GaSVhpg9/Nl1JjIO9ESDci7g9B8/nMknurBL6pCtR66d47EFVb+9ASoQ9mV7+94LI2/gJFIc/DIrWXd/ZpW4c5cWCJKlbSigvjaw86D2ErcL6zPTlOPzicyBWj6zSuCvTUKNCcae+tLy1UO2Yn/37xc2aNS86csugfXPFx7i6B5jYbl0HwWAflctgmmwK/p6ZfqutVWi0VCqT579zjxBkFOvgvCS2deKgDdz6oLu/g+MyEbJFviSDW2gUEaSxfZfmvgOzML44C1s3YyD01fVPoqDzgw0YJq+dDjOyUIcLbeCvu1dWZ2F9DBWNaQayxOhhfo8qV4/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(30864003)(5660300002)(52536014)(7696005)(15650500001)(53546011)(26005)(86362001)(45080400002)(6506007)(186003)(8936002)(8676002)(66556008)(66446008)(71200400001)(66476007)(64756008)(316002)(966005)(110136005)(76116006)(66946007)(2906002)(478600001)(33656002)(83380400001)(55016002)(9686003)(4326008)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Et2xRswa87AxQByGj6lh+rQbVPSzpzdNrttPgDRXlhuNpQO8UL0crjbhQhMDH1jPYakDxsG8KRtgxg49d9umpFQlqwoAjwsumHHYDxfcwkqRdhD87wugKip9JL9XiNmIntLkbGE/K6DxTwVCdgE/rrhgCS5n1TQ2onJta2+mrraOCCzbQJf6cC4O97n7YfEfWkchKlzW3zg4zTnme2pFMZU4wxd+JMJ0WcUhG/P/wVflcxd/RR6rJuajRIudmzVv10Mmb/Kpp5TtOaR+fTRNgS05/MQSh/rePMlwknykTKsAm/Gcq8k3Y5RQt5oyf2WteghUNCaIL2utowVY3wuUv6N4bR9yo2qan8fF8elZyvmtgtQqxlWh5ve/BTbrwxFi77QO4CeqvXyzeScJFoDbVEXDdD7teEy14NxhFOhAxEMKK7vZAxtpofkbSsLp1cOGivCa36YWkHkxWt2S2Irss9PvlB5UU59Z1r2lXBIPDWSA7QHFwpF4bkCw4ZKYPQ5TxUa2imq95mDgIWNtpuFzys0W65i4uu6EU/QwU8ymqhbk903EUCNgbH4XMgDZuIX97vKpS5GucBOvx/N1R71Hy6HKjbAbfq/QvISmDJU3s26+4xE2S/gb1X39KXyCq7D2fCq4zWBncRYD9XitHSXIBw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccfdd86-c981-4e58-8a6d-08d84a6250af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 08:22:19.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S81UMdGxdDC5BfA7hyRV3wqM8l0ZlB3Bc3vFuotZGJm4gLAkgiRO8WjjdrvKW5u7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zhang
Sent: Saturday, May 2, 2020 1:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] SWDEV-220451 - Query guest's information by VF2PF message - part 2

- Guest side change

- Refactor and implement VF2PF information

- Share checksum function between guest and host

- Refactor code in amdgpu_virt.c since some of them are useless

Change-Id: I881989d8fb6b6af88209badf4c4070c281f65b6a
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 249 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 232 ++++++++++++-------
 3 files changed, 354 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a928fa9077c6..37f1d2669d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3305,8 +3305,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 /* make sure IB test finished before entering exclusive mode
  * to avoid preemption on IB test
  * */
-if (amdgpu_sriov_vf(adev))
+if (amdgpu_sriov_vf(adev)) {
 amdgpu_virt_request_full_gpu(adev, false);
+amdgpu_virt_fini_data_exchange(adev);
+}

 /* disable all interrupts */
 amdgpu_irq_disable_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 8c10084f44ef..b83212b76277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -27,6 +27,12 @@

 #include "amdgpu.h"

+#define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
+do { \
+vf2pf_info->ucode_info[ucode].id = ucode; \
+vf2pf_info->ucode_info[ucode].version = ver; \
+} while (0)
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)  {
 /* By now all MMIO pages except mailbox are blocked */ @@ -228,77 +234,212 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
 adev->virt.mm_table.gpu_addr = 0;
 }

-
-int amdgpu_virt_fw_reserve_get_checksum(void *obj,
-unsigned long obj_size,
-unsigned int key,
-unsigned int chksum)
+/*
+ * encode: obj.checksum = amd_sriov_msg_checksum(obj, size, key, 0)
+ * decode:            0 = amd_sriov_msg_checksum(obj, size, key, obj.checksum)
+ */
+unsigned int amd_sriov_msg_checksum(void *obj,
+unsigned long obj_size,
+unsigned int key,
+unsigned int checksum)
 {
-unsigned int ret = key;
+unsigned int ret = 0;
 unsigned long i = 0;
 unsigned char *pos;

-pos = (char *)obj;
-/* calculate checksum */
+/* calculate checksum of obj*/
+pos = (unsigned char *)obj;
 for (i = 0; i < obj_size; ++i)
 ret += *(pos + i);
-/* minus the chksum itself */
-pos = (char *)&chksum;
-for (i = 0; i < sizeof(chksum); ++i)
+
+pos = (unsigned char *)&checksum;
+for (i = 0; i < sizeof(checksum); ++i)
 ret -= *(pos + i);
+
+ret ^= key;
+
+ret -= checksum;
+
 return ret;
 }

-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev) {
+struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+uint32_t checksum;
+
+if (adev->virt.fw_reserve.p_pf2vf == NULL)
+return -EINVAL;
+
+if (pf2vf_info->size > 1024) {
+DRM_ERROR("invalid pf2vf message size\n");
+return -EINVAL;
+}
+
+switch (pf2vf_info->version) {
+case 1:
+checksum = ((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->checksum;
+checksum = amd_sriov_msg_checksum(
+adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+adev->virt.fw_reserve.checksum_key, checksum);
+if (checksum != 0) {
+DRM_ERROR("invalid pf2vf message\n");
+return -EINVAL;
+}
+
+adev->virt.vf2pf_update_interval_ms = 0;
+adev->virt.gim_feature =
+((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->feature_flags;
+break;
+case 2:
+checksum = pf2vf_info->checksum;
+checksum = amd_sriov_msg_checksum(
+adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+0, checksum);
+if (checksum != 0) {
+DRM_ERROR("invalid pf2vf message\n");
+return -EINVAL;
+}
+
+adev->virt.vf2pf_update_interval_ms =
+((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->vf2pf_update_interval_ms;
+adev->virt.gim_feature =
+((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
+break;
+default:
+DRM_ERROR("invalid pf2vf version\n");
+return -EINVAL;
+}
+
+if (adev->virt.vf2pf_update_interval_ms < 200 || adev->virt.vf2pf_update_interval_ms > 10000)
+adev->virt.vf2pf_update_interval_ms = 2000;
+
+return 0;
+}
+
+static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device
+*adev) {
+struct amd_sriov_msg_vf2pf_info *vf2pf_info;
+vf2pf_info = (struct amd_sriov_msg_vf2pf_info *)
+adev->virt.fw_reserve.p_vf2pf;
+
+if (adev->virt.fw_reserve.p_vf2pf == NULL)
+return;
+
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCE,      adev->vce.fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_UVD,      adev->uvd.fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MC,       adev->gmc.fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ME,       adev->gfx.me_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_PFP,      adev->gfx.pfp_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_CE,       adev->gfx.ce_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC,      adev->gfx.rlc_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLC, adev->gfx.rlc_srlc_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLG, adev->gfx.rlc_srlg_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,      adev->psp.asd_fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,   adev->psp.ta_ras_ucode_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,  adev->psp.ta_xgmi_ucode_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.instance[0].fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.instance[1].fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCN,      adev->vcn.fw_version);
+POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_DMCU,     adev->dm.dmcu_fw_version);
+}
+
+static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 {
-uint32_t pf2vf_size = 0;
-uint32_t checksum = 0;
-uint32_t checkval;
-char *str;
+struct amd_sriov_msg_vf2pf_info *vf2pf_info;

+vf2pf_info = (struct amd_sriov_msg_vf2pf_info *)
+adev->virt.fw_reserve.p_vf2pf;
+
+if (adev->virt.fw_reserve.p_vf2pf == NULL)
+return -EINVAL;
+
+memset(vf2pf_info, 0, sizeof(struct amd_sriov_msg_vf2pf_info));
+
+vf2pf_info->header.size = sizeof(struct amd_sriov_msg_vf2pf_info);
+vf2pf_info->header.version = AMDGPU_FW_VRAM_VF2PF_VER;
+
+#ifdef MODULE
+if (THIS_MODULE->version != NULL)
+strcpy(vf2pf_info->driver_version, THIS_MODULE->version);
+else
+#endif
+strcpy(vf2pf_info->driver_version, "N/A");
+
+vf2pf_info->pf2vf_version_required = 0; // no requirement
+vf2pf_info->driver_cert = 0;
+vf2pf_info->os_info.all = 0;
+
+vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(&adev->mman.bdev.man[TTM_PL_VRAM]) >> 20;
+vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(&adev->mman.bdev.man[TTM_PL_VRAM]) >> 20;
+vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
+vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
+
+amdgpu_virt_populate_vf2pf_ucode_info(adev);
+
+/* TODO read dynamic info */
+vf2pf_info->gfx_usage = 0;
+vf2pf_info->gfx_health = 0;
+vf2pf_info->compute_usage = 0;
+vf2pf_info->compute_health = 0;
+vf2pf_info->avc_enc_usage = 0;
+vf2pf_info->avc_enc_health = 0;
+vf2pf_info->hevc_enc_usage = 0;
+vf2pf_info->hevc_enc_health = 0;
+
+vf2pf_info->header.checksum =
+amd_sriov_msg_checksum(
+vf2pf_info, vf2pf_info->header.size, 0, 0);
+
+return 0;
+}
+
+void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work) {
+struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+virt.vf2pf_work.work);
+
+amdgpu_virt_read_pf2vf_data(adev);
+amdgpu_virt_write_vf2pf_data(adev);
+
+schedule_delayed_work(&(adev->virt.vf2pf_work),
+adev->virt.vf2pf_update_interval_ms);
+}
+
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev) {
+if (adev->virt.vf2pf_update_interval_ms != 0) {
+DRM_INFO("clean up the vf2pf work item\n");
+flush_delayed_work(&adev->virt.vf2pf_work);
+cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+}
+}
+
+void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev) {
 adev->virt.fw_reserve.p_pf2vf = NULL;
 adev->virt.fw_reserve.p_vf2pf = NULL;
+adev->virt.vf2pf_update_interval_ms = 0;

 if (adev->fw_vram_usage.va != NULL) {
+/* default 2 second */
+adev->virt.vf2pf_update_interval_ms = 2000;
+
 adev->virt.fw_reserve.p_pf2vf =
-(struct amd_sriov_msg_pf2vf_info_header *)(
-adev->fw_vram_usage.va + AMDGIM_DATAEXCHANGE_OFFSET);
-AMDGPU_FW_VRAM_PF2VF_READ(adev, header.size, &pf2vf_size);
-AMDGPU_FW_VRAM_PF2VF_READ(adev, checksum, &checksum);
-AMDGPU_FW_VRAM_PF2VF_READ(adev, feature_flags, &adev->virt.gim_feature);
-
-/* pf2vf message must be in 4K */
-if (pf2vf_size > 0 && pf2vf_size < 4096) {
-checkval = amdgpu_virt_fw_reserve_get_checksum(
-adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
-adev->virt.fw_reserve.checksum_key, checksum);
-if (checkval == checksum) {
-adev->virt.fw_reserve.p_vf2pf =
-((void *)adev->virt.fw_reserve.p_pf2vf +
-pf2vf_size);
-memset((void *)adev->virt.fw_reserve.p_vf2pf, 0,
-sizeof(amdgim_vf2pf_info));
-AMDGPU_FW_VRAM_VF2PF_WRITE(adev, header.version,
-AMDGPU_FW_VRAM_VF2PF_VER);
-AMDGPU_FW_VRAM_VF2PF_WRITE(adev, header.size,
-sizeof(amdgim_vf2pf_info));
-AMDGPU_FW_VRAM_VF2PF_READ(adev, driver_version,
-&str);
-#ifdef MODULE
-if (THIS_MODULE->version != NULL)
-strcpy(str, THIS_MODULE->version);
-else
-#endif
-strcpy(str, "N/A");
-AMDGPU_FW_VRAM_VF2PF_WRITE(adev, driver_cert,
-0);
-AMDGPU_FW_VRAM_VF2PF_WRITE(adev, checksum,
-amdgpu_virt_fw_reserve_get_checksum(
-adev->virt.fw_reserve.p_vf2pf,
-pf2vf_size,
-adev->virt.fw_reserve.checksum_key, 0));
-}
-}
+(struct amd_sriov_msg_pf2vf_info_header *)
+(adev->fw_vram_usage.va + AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET);
+adev->virt.fw_reserve.p_vf2pf =
+(struct amd_sriov_msg_vf2pf_info_header *)
+((void *)adev->virt.fw_reserve.p_pf2vf + AMD_SRIOV_MSG_SIZE);
+
+amdgpu_virt_read_pf2vf_data(adev);
+amdgpu_virt_write_vf2pf_data(adev);
+}
+
+if (adev->virt.vf2pf_update_interval_ms != 0) {
+INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+schedule_delayed_work(&(adev->virt.vf2pf_work),
+adev->virt.vf2pf_update_interval_ms);
 }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index de27308802c9..4f2f5481d7a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -35,6 +35,31 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503

+enum amd_sriov_ucode_engine_id {
+AMD_SRIOV_UCODE_ID_VCE = 0,
+AMD_SRIOV_UCODE_ID_UVD,
+AMD_SRIOV_UCODE_ID_MC,
+AMD_SRIOV_UCODE_ID_ME,
+AMD_SRIOV_UCODE_ID_PFP,
+AMD_SRIOV_UCODE_ID_CE,
+AMD_SRIOV_UCODE_ID_RLC,
+AMD_SRIOV_UCODE_ID_RLC_SRLC,
+AMD_SRIOV_UCODE_ID_RLC_SRLG,
+AMD_SRIOV_UCODE_ID_RLC_SRLS,
+AMD_SRIOV_UCODE_ID_MEC,
+AMD_SRIOV_UCODE_ID_MEC2,
+AMD_SRIOV_UCODE_ID_SOS,
+AMD_SRIOV_UCODE_ID_ASD,
+AMD_SRIOV_UCODE_ID_TA_RAS,
+AMD_SRIOV_UCODE_ID_TA_XGMI,
+AMD_SRIOV_UCODE_ID_SMC,
+AMD_SRIOV_UCODE_ID_SDMA,
+AMD_SRIOV_UCODE_ID_SDMA2,
+AMD_SRIOV_UCODE_ID_VCN,
+AMD_SRIOV_UCODE_ID_DMCU,
+AMD_SRIOV_UCODE_ID__MAX
+};
+
 struct amdgpu_mm_table {
 struct amdgpu_bo*bo;
 uint32_t*cpu_addr;
@@ -73,11 +98,13 @@ struct amdgpu_virt_fw_reserve {
 struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
 unsigned int checksum_key;
 };
+
 /*
  * Defination between PF and VF
  * Structures forcibly aligned to 4 to keep the same style as PF.
  */
-#define AMDGIM_DATAEXCHANGE_OFFSET(64 * 1024)
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET(64 * 1024)
+#define AMD_SRIOV_MSG_SIZE(1024)

 #define AMDGIM_GET_STRUCTURE_RESERVED_SIZE(total, u8, u16, u32, u64) \
 (total - (((u8)+3) / 4 + ((u16)+1) / 2 + (u32) + (u64)*2)) @@ -95,14 +122,118 @@ enum AMDGIM_FEATURE_FLAG {
 AMDGIM_FEATURE_PP_ONE_VF = (1 << 4),
 };

+#pragma pack(push, 1)
+union amd_sriov_msg_feature_flags
+{
+struct {
+uint32_t  error_log_collect  : 1;
+uint32_t  host_load_ucodes   : 1;
+uint32_t  host_flr_vramlost  : 1;
+uint32_t  mm_bw_management   : 1;
+uint32_t  pp_one_vf_mode     : 1;
+uint32_t  reserved           : 27;
+} flags;
+uint32_t      all;
+};
+
+union amd_sriov_msg_os_info
+{
+struct {
+uint32_t  windows            : 1;
+uint32_t  reserved           : 31;
+} info;
+uint32_t      all;
+};
+
+/* PF to VF message header */
 struct amd_sriov_msg_pf2vf_info_header {
 /* the total structure size in byte. */
 uint32_t size;
 /* version of this structure, written by the GIM */
 uint32_t version;
+/* 32 bit checksum */
+uint32_t checksum;
 /* reserved */
-uint32_t reserved[2];
-} __aligned(4);
+uint32_t reserved[1];
+};
+
+/* PF to VF message struct, libgv */
+struct  amd_sriov_msg_pf2vf_info {
+/* header contains size and version */
+struct amd_sriov_msg_pf2vf_info_header header;
+/* frequency for VF to update the VF2PF area in msec, 0 = manual */
+uint32_t vf2pf_update_interval_ms;
+/* The features flags of the HOST driver supports */
+union amd_sriov_msg_feature_flags feature_flags;
+/* (max_width * max_height * fps) / (16 * 16) */
+uint32_t hevc_enc_max_mb_per_second;
+/* (max_width * max_height) / (16 * 16) */
+uint32_t hevc_enc_max_mb_per_frame;
+/* (max_width * max_height * fps) / (16 * 16) */
+uint32_t avc_enc_max_mb_per_second;
+/* (max_width * max_height) / (16 * 16) */
+uint32_t avc_enc_max_mb_per_frame;
+/* reserved */
+uint32_t reserved[256-10];
+};
+
+/* VF to PF message header */
+struct amd_sriov_msg_vf2pf_info_header {
+/* the total structure size in byte. */
+uint32_t size;
+/* version of this structure, written by the GIM */
+uint32_t version;
+/* 32 bit checksum */
+uint32_t checksum;
+/* reserved */
+uint32_t reserved[1];
+};
+
+/* VF to PF message struct, libgv */
+struct amd_sriov_msg_vf2pf_info {
+/* header contains size and version */
+struct amd_sriov_msg_vf2pf_info_header header;
+/* Version of PF2VF that VF understands */
+uint32_t pf2vf_version_required;
+/* driver version */
+uint8_t  driver_version[64];
+/* driver certification, 1=WHQL, 0=None */
+uint32_t driver_cert;
+/* guest OS type and version */
+union amd_sriov_msg_os_info os_info;
+/* guest fb information in the unit of MB */
+uint32_t fb_size;
+uint32_t fb_vis_size;
+uint32_t fb_usage;
+uint32_t fb_vis_usage;
+/* guest gfx engine usage percentage */
+uint32_t gfx_usage;
+/* guest gfx engine health percentage */
+uint32_t gfx_health;
+/* guest compute engine usage percentage */
+uint32_t compute_usage;
+/* guest compute engine health percentage */
+uint32_t compute_health;
+/* guest avc engine usage percentage. 0xffff means N/A */
+uint32_t avc_enc_usage;
+/* guest avc engine health percentage. 0xffff means N/A */
+uint32_t avc_enc_health;
+/* guest hevc engine usage percentage. 0xffff means N/A */
+uint32_t hevc_enc_usage;
+/* guest hevc engine usage percentage. 0xffff means N/A */
+uint32_t hevc_enc_health;
+/* guest ucode data */
+struct {
+uint8_t  id;
+uint32_t version;
+} ucode_info[40];
+
+/* reserved */
+uint32_t reserved[256-85];
+};
+#pragma pack(pop)
+
+/* PF to VF message struct, amdgim */
 struct  amdgim_pf2vf_info_v1 {
 /* header contains size and version */
 struct amd_sriov_msg_pf2vf_info_header header; @@ -122,46 +253,7 @@ struct  amdgim_pf2vf_info_v1 {
 unsigned int checksum;
 } __aligned(4);

-struct  amdgim_pf2vf_info_v2 {
-/* header contains size and version */
-struct amd_sriov_msg_pf2vf_info_header header;
-/* use private key from mailbox 2 to create chueksum */
-uint32_t checksum;
-/* The features flags of the GIM driver supports. */
-uint32_t feature_flags;
-/* max_width * max_height */
-uint32_t uvd_enc_max_pixels_count;
-/* 16x16 pixels/sec, codec independent */
-uint32_t uvd_enc_max_bandwidth;
-/* max_width * max_height */
-uint32_t vce_enc_max_pixels_count;
-/* 16x16 pixels/sec, codec independent */
-uint32_t vce_enc_max_bandwidth;
-/* MEC FW position in kb from the start of VF visible frame buffer */
-uint64_t mecfw_kboffset;
-/* MEC FW size in KB */
-uint32_t mecfw_ksize;
-/* UVD FW position in kb from the start of VF visible frame buffer */
-uint64_t uvdfw_kboffset;
-/* UVD FW size in KB */
-uint32_t uvdfw_ksize;
-/* VCE FW position in kb from the start of VF visible frame buffer */
-uint64_t vcefw_kboffset;
-/* VCE FW size in KB */
-uint32_t vcefw_ksize;
-uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (9 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];
-} __aligned(4);
-
-
-struct amd_sriov_msg_vf2pf_info_header {
-/* the total structure size in byte. */
-uint32_t size;
-/*version of this structure, written by the guest */
-uint32_t version;
-/* reserved */
-uint32_t reserved[2];
-} __aligned(4);
-
+/* VF to PF message struct, amdgim */
 struct amdgim_vf2pf_info_v1 {
 /* header contains size and version */
 struct amd_sriov_msg_vf2pf_info_header header; @@ -192,6 +284,7 @@ struct amdgim_vf2pf_info_v1 {
 unsigned int checksum;
 } __aligned(4);

+/* VF to PF message struct, amdgim */
 struct amdgim_vf2pf_info_v2 {
 /* header contains size and version */
 struct amd_sriov_msg_vf2pf_info_header header; @@ -223,49 +316,30 @@ struct amdgim_vf2pf_info_v2 {
 uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 64, 0, (12 + sizeof(struct amd_sriov_msg_vf2pf_info_header)/sizeof(uint32_t)), 0)];  } __aligned(4);

-#define AMDGPU_FW_VRAM_VF2PF_VER 2
-typedef struct amdgim_vf2pf_info_v2 amdgim_vf2pf_info ;
-
-#define AMDGPU_FW_VRAM_VF2PF_WRITE(adev, field, val) \
-do { \
-((amdgim_vf2pf_info *)adev->virt.fw_reserve.p_vf2pf)->field = (val); \
-} while (0)
-
-#define AMDGPU_FW_VRAM_VF2PF_READ(adev, field, val) \
-do { \
-(*val) = ((amdgim_vf2pf_info *)adev->virt.fw_reserve.p_vf2pf)->field; \
-} while (0)
-
-#define AMDGPU_FW_VRAM_PF2VF_READ(adev, field, val) \
-do { \
-if (!adev->virt.fw_reserve.p_pf2vf) \
-*(val) = 0; \
-else { \
-if (adev->virt.fw_reserve.p_pf2vf->version == 1) \
-*(val) = ((struct amdgim_pf2vf_info_v1 *)adev->virt.fw_reserve.p_pf2vf)->field; \
-if (adev->virt.fw_reserve.p_pf2vf->version == 2) \
-*(val) = ((struct amdgim_pf2vf_info_v2 *)adev->virt.fw_reserve.p_pf2vf)->field; \
-} \
-} while (0)
+#define AMDGPU_FW_VRAM_VF2PF_VER 3

 /* GPU virtualization */
 struct amdgpu_virt {
 uint32_tcaps;
 struct amdgpu_bo*csa_obj;
 void*csa_cpu_addr;
-bool chained_ib_support;
+boolchained_ib_support;
 uint32_treg_val_offs;
 struct amdgpu_irq_srcack_irq;
 struct amdgpu_irq_srcrcv_irq;
 struct work_structflr_work;
 struct amdgpu_mm_tablemm_table;
 const struct amdgpu_virt_ops*ops;
-struct amdgpu_vf_error_buffer   vf_errors;
+struct amdgpu_vf_error_buffervf_errors;
 struct amdgpu_virt_fw_reservefw_reserve;
-uint32_t gim_feature;
-uint32_t reg_access_mode;
-int req_init_data_ver;
-bool tdr_debug;
+uint32_tgim_feature;
+uint32_treg_access_mode;
+intreq_init_data_ver;
+booltdr_debug;
+
+/* vf2pf message */
+struct delayed_work vf2pf_work;
+uint32_tvf2pf_update_interval_ms;
 };

 #define amdgpu_sriov_enabled(adev) \
@@ -314,13 +388,19 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev);  int amdgpu_virt_wait_reset(struct amdgpu_device *adev);  int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);  void amdgpu_virt_free_mm_table(struct amdgpu_device *adev); -int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
-unsigned int key,
-unsigned int chksum);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
+
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);

 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
+
+/* checksum function between host and guest */ unsigned int
+amd_sriov_msg_checksum(void *obj,
+unsigned long obj_size,
+unsigned int key,
+unsigned int checksum);
+
 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C92cd0041c3a7436c263108d7edf91756%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637239527004275499&amp;sdata=LmCc1651WD4TaK%2FxlGqgpdDIcSK4zerVd%2FgiD0pNbnE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
