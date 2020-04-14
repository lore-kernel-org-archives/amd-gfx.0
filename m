Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEBBC2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 02:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0157520644
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 02:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eWAmgPgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0157520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8926E445;
	Tue, 14 Apr 2020 02:58:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7806E445
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 02:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA/x0ztbxroameh9pjuk9lztB8+FJNt2wAVRvftTq+XFeLMA1/MrcrcJ2qZ4mtR7OibLR+wphNwgzaKC2m6qRKLmJkXeNVKqqgJilSH+vMyMyJIV89zD1jrJuFZsaTxk7gD21ZEgg+PNyW6FZTvartsX4k/qvQQMF7gzBmA/OZPGtdQaZn7ZMQ77K1JbggA0OGT0Hrp/3Cs6R12bHL3vJMz1qaLqVPUyx3oYNV3zbPm2r8C706GIaMuwlLBeTNAKe8lgnZ69r342yH1F5nzMdQWTVdtq6y+7lKy0Z9jp/Od/PFSApD/QLMYGLA8J6Uh1h4wbaf2gRLwS7sYt1f8LVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPWbvL8PDgYfLi9AfdA76JUHI84XOSuhYRpTHtO2A+c=;
 b=YN/L5GxWPxvBdaMVInL2x+NkMl6nt7ruYQYBlYYSIlx42/SaSZElQGr0mEmH03a1rdO3al1VG7L0Chx8p3i7Vd4sD+IDWd1lrGrkl+5WCTv8bqtmWLKhj0GdnATWDlSJKPs9IO1JaHk/YNsnWfNgSSgCC1vVFEfs86ueCUEakZYDR6oU/xatCSFGQtpnoUAQMx9uD5k4edUp0Hzpps2shX9JXinYrrkpt1sUgVc/7sn922mEuhiB+u5Q9hlAksMXJ5ux+7Yto96cdzOpQUVGT6eyYJ3AY6MYolRI45c+XuKQma32FyUj41zAOrQXTx3YY2JKTe9Hur7PWqzBvQJDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPWbvL8PDgYfLi9AfdA76JUHI84XOSuhYRpTHtO2A+c=;
 b=eWAmgPgkV2BX4wQSTIp7V1LNLddY3leuUaYzjtE1K7VG1wSTsrhGBkQg6LKJ+/0PNtbSm9NislXEaWxjWNU5CPyswvC9fJfnlZ0Pv4dIiuB84D1z9OGYVk8EK5Z+2IWpikXDy1bsRajypvfoZLYPXGhGzpXkjN1yeQjVBx3Cc4s=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 02:58:48 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 02:58:48 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/powerplay: correct i2c eeprom init/fini
 sequence
Thread-Topic: [PATCH 1/2] drm/amd/powerplay: correct i2c eeprom init/fini
 sequence
Thread-Index: AQHWEW0AvhiE4jj0EE+ibSRtn6eEpah37kKw
Date: Tue, 14 Apr 2020 02:58:48 +0000
Message-ID: <MN2PR12MB3598E5CBB165FED55E37787A8EDA0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200413082422.31786-1-evan.quan@amd.com>
In-Reply-To: <20200413082422.31786-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T02:58:44Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0b50329-19cc-428a-a33d-00006460be6c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T02:58:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 62df7cc1-93dc-4e88-947c-00006e92e496
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [240e:e0:8f58:a400:eca4:7196:e5b9:a351]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f67b258-9ea0-4fad-2b58-08d7e01fc14e
x-ms-traffictypediagnostic: MN2PR12MB4176:|MN2PR12MB4176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41768AB5CF500039C3C8A8AD8EDA0@MN2PR12MB4176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(6506007)(966005)(81156014)(110136005)(316002)(2906002)(8676002)(5660300002)(8936002)(33656002)(71200400001)(52536014)(53546011)(4326008)(186003)(478600001)(7696005)(55016002)(86362001)(66476007)(66946007)(66556008)(9686003)(45080400002)(64756008)(66446008)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHP/dJAQ2poweKWvMABXqbGpgsBt2yZ7wuSDTqTyPysFZhwy1Lr/Q4cuBPC4ydXRLvv/bxHvavnL0gWhRZpgJcRilQL4q75rJohabfMzBvrSpWTwLXudD8YIM9O4GAFOHK9zpoCIknlKWSNAkKkUqFxO2FT4+nuOpCHVcQmSsiWZNVMBZg9QnhfOQSIleGBWBbn2gDtgmI8KUhFj6FH3yQ3uEIsLwAVh8o2aDIUaPnIxCNVUOnc3VNAIHqfVQ6/2X1YS3rpLZSN0Bq2pnt2/D1A3kiLxoTG0TkFSUXiY/d1dJ/5I7fmjDTLKMnA8mfHrJMTNzNe2MUOom+e3Woih61mSCCyeE63hwBz1ig5jjnmhfWKobAOhvGipkbz/e9kA15ClXaa5qtZFPNscEbja37TtLg+nCSeUt6VmJXfZpC1/Qy8A7+tKLzl7gfk2KYA+cpn2ANjnHuR99uvWzISXXZMEftF3WpX6il7ywX2mQGc=
x-ms-exchange-antispam-messagedata: aJPHq4fhdydH5w7qnguZ6LdJwwgkIICxmgeH+kVMnOCqFy5jTJQjOc88bHAnaE3qqSPIdx3H4mpksATFVXmgK2kzQuHkRSHex5tRoKBzft0A0rRiTnvvRwsgbIZmQ2WS3/NOd4PdoeRkb7rQ2RMj/9NxqARIbQytgWi5KrlMusxoO97m5ZyuvbBbAEtUTWQkGB+2IvaYpLGCAayVieI1Bw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67b258-9ea0-4fad-2b58-08d7e01fc14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 02:58:48.7108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6M2zZz2ZjLSqyd27Yc7sPybjJ8wCfjYTSYn3gIIxMSoNXa2GRCFaKCOC2e2VKQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, April 13, 2020 4:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/powerplay: correct i2c eeprom init/fini sequence

[CAUTION: External Email]

As data transfer may starts immediately after i2c eeprom init completed. Thus i2c eeprom should be initialized after SMU ready. And i2c data transfer should be prohibited when SMU down. That is the i2c eeprom fini sequence needs to be updated also.

Change-Id: I8444c05b51e67347841641fe5768d3126d089792
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 22 ++++++++++---------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  5 -----
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  5 +++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index e8b27fab6aa1..b69e8d6c0a96 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -932,13 +932,6 @@ static int smu_sw_init(void *handle)
                return ret;
        }

-       if (adev->smu.ppt_funcs->i2c_eeprom_init) {
-               ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-
-               if (ret)
-                       return ret;
-       }
-
        return 0;
 }

@@ -948,9 +941,6 @@ static int smu_sw_fini(void *handle)
        struct smu_context *smu = &adev->smu;
        int ret;

-       if (adev->smu.ppt_funcs->i2c_eeprom_fini)
-               smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
        kfree(smu->irq_source);
        smu->irq_source = NULL;

@@ -1366,6 +1356,10 @@ static int smu_hw_init(void *handle)
        if (ret)
                goto failed;

+       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+       if (ret)
+               goto failed;
+
        if (!smu->pm_enabled)
                adev->pm.dpm_enabled = false;
        else
@@ -1403,6 +1397,8 @@ static int smu_hw_fini(void *handle)
        if (!smu->pm_enabled)
                return 0;

+       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
        if (!amdgpu_sriov_vf(adev)){
                ret = smu_stop_thermal_control(smu);
                if (ret) {
@@ -1542,6 +1538,8 @@ static int smu_suspend(void *handle)
        if (!smu->pm_enabled)
                return 0;

+       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
        if(!amdgpu_sriov_vf(adev)) {
                ret = smu_disable_dpm(smu);
                if (ret)
@@ -1587,6 +1585,10 @@ static int smu_resume(void *handle)
        if (ret)
                goto failed;

+       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+       if (ret)
+               goto failed;
+
        if (smu->is_apu)
                smu_set_gfx_cgpg(&adev->smu, true);

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ae2c318dd6fa..30643b9b5b3b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -580,11 +580,6 @@ int smu_check_fw_status(struct smu_context *smu);

 int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);

-#define smu_i2c_eeprom_init(smu, control) \
-               ((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((control)) : -EINVAL)
-#define smu_i2c_eeprom_fini(smu, control) \
-               ((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((control)) : -EINVAL)
-
 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed);

 int smu_get_power_limit(struct smu_context *smu, diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 40c35bcc5a0a..c97444841abc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -214,4 +214,9 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ  #define smu_set_power_source(smu, power_src) \
        ((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)

+#define smu_i2c_eeprom_init(smu, control) \
+               ((smu)->ppt_funcs->i2c_eeprom_init ? 
+(smu)->ppt_funcs->i2c_eeprom_init((control)) : 0) #define smu_i2c_eeprom_fini(smu, control) \
+               ((smu)->ppt_funcs->i2c_eeprom_fini ? 
+(smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
+
 #endif
--
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CKenneth.Feng%40amd.com%7Cd6b38cd4ce04447f032608d7df8420a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637223630903261750&amp;sdata=8IWr8iPwVZsHiVFtlouklQbMF%2BG8mdOzDGqc5wl5EwE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
